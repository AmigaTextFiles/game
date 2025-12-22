/***************************************************************************
                          leveldaten.cpp  -  description
                             -------------------
    begin                : Fri Jul 21 2000
    copyright            : (C) 2000 by Immi
    email                : cuyo@pcpool.mathematik.uni-freiburg.de
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include <cstdlib>

#include "leveldaten.h"
#include "cuyointl.h"
#include "fehler.h"
#include "pfaditerator.h"
#include "datendatei.h"
#include "knoten.h"
#include "prefsdaten.h"
#include "global.h"
#include "font.h"
#include "aufnahme.h"

#include "blop.h"

/* Provisorischerweise werden die Punktefeld-Schriften direkt von
   hier initialisiert */
#include "punktefeld.h"


#define toptime_default 50


using namespace std;


/* Globale Variable mit den Level-Daten */

LevelDaten * ld;

/** */
LevelDaten::LevelDaten(const Version & version): mLevelCache(),
  mVersion(version),
/* Wir basteln uns ein Array, dessen Indizierung nicht mit 0 beginnt...: */
  mSorten(mSortenIntern - blopart_min_sorte),
  /* Noch keine Sorten geladen */
  mAnzFarben(0)
/* Uninitialisierte Blops entstehen sehr früh, und die haben auch schon
   einen Bildstapel. Und der greift auf mStapelHoehe() zu. */
 // mStapelHoehe(0)
{
  for (int teil=0; teil<ldteile_anzahl; teil++) {
    mLevelConf[teil] = new DatenDatei();
    mGeladen[teil] = false;
  }
  ld = this;
  ladLevelConf(ldteil_summary,true,version);
  
  /* Auch die negativen Sorten sind noch nicht geladen: */
  for (int i = blopart_min_sorte; i < 0; i++)
    mSorten[i] = NULL;
}


/** */
LevelDaten::~LevelDaten() {
  entladLevel();

  for (int teil=0; teil<ldteile_anzahl; teil++)
    delete mLevelConf[teil];
}



void LevelDaten::ladLevelConf(LDTeil ldteil, bool aufJedenFall,
			      const Version & version) {

  if (aufJedenFall || (version!=mVersion)) {
  
    mVersion = version;

    mSpielerZahl = (mVersion.enthaelt("1") ? 1 : 2);

    /* Jetzt ist erst mal nix mehr geladen. Erst wenn ladLevelConf()
       durchgelaufen ist, ist wieder was da. */
    mGeladen[ldteil] = false;

    /* Abkürzung */
    DatenDatei * conf = mLevelConf[ldteil];

    switch (ldteil) {
      case ldteil_summary:

	/* Falls schon mal was geladen wurde: Erst mal alles
	   wieder rausschmeißen. */
	conf->leeren();

	/* Jetzt ist auch der richtige Zeitpunkt zum lazy löschen. */
	mLevelConf[ldteil_level]->leeren();
	mLevelCache = set<Str>();

	/* Im weiteren Verlauf wird irgendwann mIntLevelNamen ausgefüllt.
	   Falls da vorher noch Müll drin war, löschen wir das. */
	mIntLevelNamen.clear();

	/* Hier findet das parsen statt. */
	mSammleLevel = false;
	conf->laden("summary.ld");

	/* Hat der Benutzer noch eine eigene Leveldatei angegeben?
	   Dann wird die jetzt auch noch geladen. */
	if (gDateiUebergeben) {

	  /* Weil die Datei noch nicht durch genSummary.pl durch ist,
	     braucht sie vielleicht den Inhalt von global.ld.
	     Also laden wir alles, was in global= steht.
	     Im Unterschied zu unten diesmal aber nach ldteil_summary. */
	  ListenKnoten* global = conf ->
	    getListenEintrag("global",mVersion,false);
	  if (global) {
	    int l = global->getLaenge();
	    mSammleLevel = false;
	    for (int i=0; i<l; i++)
	      conf->laden(global->getDatum(i,type_WortDatum)->getWort());
	  }

	  /* Und wir nehmen die bisher definierten Level aus dem Knoten-Baum
	     wieder raus, damit wir keine doppelt definierten Level bekommen,
	     wenn der Benutzer den Namen eines Levels übergeben hat, der schon
	     von main.ld included wird. (loeschAlleLevel() lässt den Level
	     Namens "Title" drin...) */
	  conf->initSquirrel();
	  conf->getSquirrelPos()->loeschAlleLevel();

	  /* Gepfuscht: Wir wollen, dass die übergebene Datei da gesucht
	     wird, wo sie liegt und nicht bei den normalen Leveln o.ä.
	     Wenn wir den default-Pfad löschen, wird sie zumindest als
	     erstes da gesucht. */
	  PfadIterator::loescheDefault();

	  /* Hier findet schon wieder parsen statt. */
	  mSammleLevel = true;
	  conf->laden(gLevelDatei);

	} else {

	  ListenKnoten * lena = conf->getListenEintrag("level",mVersion,false);
	  int l = lena->getLaenge();
	  mIntLevelNamen.resize(l);
	  for (int i = 0; i < l; i++)
	    mIntLevelNamen[i]=lena->getDatum(i,type_WortDatum)->getWort();

	}

        /* Jetzt noch alles das laden, was in global= steht.
	   Das wird aber schon nach ldteil_level geladen. */
	{
  	  ListenKnoten* global = conf ->
	    getListenEintrag("global",mVersion,false);
	  if (global) {
	    int l = global->getLaenge();
	    mSammleLevel = false;
	    for (int i=0; i<l; i++) {
	      Str datei = global->getDatum(i,type_WortDatum)->getWort();
	      mLevelConf[ldteil_level]->laden(datei);
	      mLevelCache.insert(datei);
	    }
	  }
	}

	mGeladen[ldteil] = true;

	break;
      case ldteil_level:
	CASSERT(mGeladen[ldteil_summary]);
	{
	  DatenDateiPush ddp(*(mLevelConf[ldteil_summary]),
			     mIntLevelName, mVersion);
	  Str datei = (gDateiUebergeben
            ? mLevelConf[ldteil_summary]->
	        getWortEintragMitDefault("filename",mVersion,gLevelDatei)
	    : mLevelConf[ldteil_summary]->
                getWortEintragOhneDefault("filename",mVersion));
	  if (mLevelCache.find(datei)==mLevelCache.end()) {
  	      /* Sonst bräuchten wir gar nichts zu machen */
	    mSammleLevel = false;
	    conf->laden(datei);
	    mLevelCache.insert(datei);
	  }
	}
	break;
      case ldteile_anzahl:
        /* Hat mir jemand eine Idee, wie man das in C besser programmieren
           kann? (Ich wünsche mir, dass der enum LDTeil eine Teilmenge des
           enums ist, in dem auch ldteile_anzahl vorkommt) */
        CASSERT(0);
        break;
    }

    /* OK, Laden war erfolgreich. */
    mGeladen[ldteil] = true;
  }
}




/** Wird während des Parsens (d. h. innerhalb von ladLevelConf() von
    DefKnoten aufgerufen, wenn ein neuer Level gefunden wurde. Fügt
    den Level in die Liste der Level ein. ladLevelConf() kann sich
    danach immernoch entscheiden, ob es die Liste wieder löscht und
    durch die "level=..."-Liste ersetzt. */
void LevelDaten::levelGefunden(Str lna) {
  if (mSammleLevel)
    mIntLevelNamen.push_back(lna);
}



/** Läd ein paar Sorten. Wird mehrfach von ladLevel() aufgerufen. */
void LevelDaten::ladSorten(const Str & ldKeyWort, int blopart) {
  ListenKnoten * picsnamen;
  picsnamen = mLevelConf[ldteil_level]->
    getListenEintrag(ldKeyWort,mVersion,true);
  if (picsnamen) {
    int neueNamen = picsnamen->getLaenge();
    int neueFarben = picsnamen->getImpliziteLaenge();
    mAnzFarben += neueFarben;

    /** Die Nummern der Sorten wurden schon beim parsen in knoten.cpp
        festgelegt. Hier tun wir unser bestes, die selben Nummern zu
	bekommen. nr ist die, die zum nächsten logischen Listeneintrag
	gehört. */
    int nr = mLevelConf[ldteil_level]->getSquirrelPos()->
      getSortenAnfang(ldKeyWort);
    if (nr+neueFarben > max_farben_zahl)
      throw Fehler(_sprintf(_("#pics > %d"), max_farben_zahl));

    for (int namen_nr = 0; namen_nr < neueNamen; namen_nr++) {
      mSorten[nr] = new Sorte(picsnamen->getKernDatum(namen_nr,type_WortDatum)
		                ->getWort(),
			      mVersion, blopart);
      nr++;
      for (int i = picsnamen->getVielfachheit(namen_nr)-1; i>0; i--) {
	mSorten[nr]=mSorten[nr-1];
	nr++;
      }
    }
  }
}



/* Gibt Speicher frei */
void LevelDaten::entladLevel() {
  /* Positive Sorten löschen */
  for (int bnr=mAnzFarben-1; bnr>0; bnr--)
    if (mSorten[bnr]!=mSorten[bnr-1])
      delete mSorten[bnr];
  if (mAnzFarben>0)
    delete mSorten[0];
  mAnzFarben = 0;

  /* Die negativen Sorten löschen */
  for (int bnr = blopart_min_sorte; bnr < 0; bnr++)
    if (mSorten[bnr]) {
      delete mSorten[bnr];
      mSorten[bnr] = NULL;
    }
}



/** füllt alle Daten in diesem Objekt für Level nr aus; throwt bei Fehler */
void LevelDaten::ladLevel(int nr) {

  if (!mGeladen[ldteil_summary])
    throw Fehler(_("Sorry, no working level description file available."));

  /* Ggf. Speicher von altem Level freigeben */
  entladLevel();

  /* In den obersten Abschnitt der level descr springen. Wir könnten uns
     woanders befinden, wenn es irgend wann mal einen Fehler gegeben hatte. */
  mLevelConf[ldteil_summary]->initSquirrel();

  /* Nur für den Fall eines frühen throws... */
  mLevelName = "";
  
  /** Für bessere Fehlerausgaben. */
  Str fehlerpos = "";
  
  mIntLevelName = getIntLevelName(nr);

  ladLevelConf(ldteil_level, true, mVersion);

  if (!mGeladen[ldteil_level])
    throw Fehler(_("Sorry, no working level description file available."));

  try {

    /* In den Abschnitt dieses Levels springen. (Springt automatisch
       bei } wieder raus. */
    DatenDateiPush ddp(*(mLevelConf[ldteil_level]), mIntLevelName, mVersion);

    fehlerpos = mLevelConf[ldteil_level]->getSquirrelPos()->getDefString() +
                _(" (or somewhere below): ");

    /* DefKnoten des Levels abspeichern. */
    mLevelKnoten = mLevelConf[ldteil_level]->getSquirrelPos();

    /* Level-Name */
    mLevelName = mLevelConf[ldteil_level]->
      getWortEintragOhneDefault("name",mVersion);

    /* Level-Autor */
    mLevelAutor = mLevelConf[ldteil_level]->
      getWortEintragOhneDefault("author",mVersion);

    /* Beschreibungstext (optional) */
    mBeschreibung = mLevelConf[ldteil_level]->
      getWortEintragMitDefault("description", mVersion, "");

    /* Wie viele Steine müssen zusammen, damit sie platzen?
       (optional, da je Sorte definierbar (muß man dann aber auch tun)) */
    mPlatzAnzahlDefault = mLevelConf[ldteil_level]->getZahlEintragMitDefault
      ("numexplode", mVersion, PlatzAnzahl_undefiniert);
    mPlatzAnzahlMin = PlatzAnzahl_undefiniert;
    mPlatzAnzahlMax = PlatzAnzahl_undefiniert;
    mPlatzAnzahlAndere = false;

    /* Hintergrundfarbe... (optional; Default: weiß)
       Achtung: Die Hintergrundfarbe muss gesetzt werden, _bevor_
       Bildchen geladen werden, da es als Bonus-Farbe im XPM
       "Background" gibt... (im Moment nur für Explosion sinnvoll) */
    mHintergrundFarbe = mLevelConf[ldteil_level]->
      getFarbEintragMitDefault("bgcolor", mVersion, Color(255, 255, 255));

    /* Hintergrundbilchen (optional) */
    mMitHintergrundbildchen = mLevelConf[ldteil_level]->hatEintrag("bgpic");
    if (mMitHintergrundbildchen)
      mHintergrundBild.laden(mLevelConf[ldteil_level]->
			     getWortEintragOhneDefault("bgpic", mVersion));

    /* Schriftfarbe... (optional; Default: dunkelgrau) */
    setSchriftFarbe(mLevelConf[ldteil_level]->
		    getFarbEintragMitDefault("textcolor",mVersion,
					     Color(40, 40, 40)));

    /* Hetzrandfarbe... (optional; Default: hellgrau) */
    hetzrandFarbe = mLevelConf[ldteil_level]->
      getFarbEintragMitDefault("topcolor", mVersion, Color(200, 200, 200));

    /* Hetzrandgeschwindigkeit (optional) */
    hetzrandZeit = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("toptime", mVersion, toptime_default);
    if (hetzrandZeit < 1)
      throw Fehler(_("toptime < 1"));

    /* Hetzrandbildchen (optional) */
    mMitHetzbildchen = mLevelConf[ldteil_level]->hatEintrag("toppic");
    if (mMitHetzbildchen) {
      mHetzBild.laden(mLevelConf[ldteil_level]->
		      getWortEintragOhneDefault("toppic",mVersion));
  	
      /* Hetzrandüberlapp (optional) */
      mHetzrandUeberlapp = mLevelConf[ldteil_level]->
	getZahlEintragMitDefault("topoverlap", mVersion, mHetzBild.getHoehe());
    } else
      mHetzrandUeberlapp = 0;

    mHetzrandStop = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("topstop", mVersion, 0);

    mFall_langsam_pix = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("falling_speed", mVersion, 6);
    mFall_schnell_pix = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("falling_fast_speed", mVersion, gric);
    if (mFall_schnell_pix<=0)
      throw Fehler(_("falling_fast_speed must be positive"));

    /* Gras nur bei Kettenreaktion? (optional) */
    mGrasBeiKettenreaktion = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("chaingrass", mVersion, 0);

    /* Senkrecht spiegeln? (optional) */
    mSpiegeln = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("mirror",mVersion,0);

    /* Andere Nachbarschaft? (optional) */
    mNachbarschaft = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("neighbours", mVersion, nachbarschaft_normal);
    if (mNachbarschaft < 0 || mNachbarschaft > nachbarschaft_letzte)
      throw Fehler(_("neighbours out of range"));
    /* Sechseck-Raster? */
    mSechseck =
      mNachbarschaft == nachbarschaft_6 ||
      mNachbarschaft == nachbarschaft_6_schraeg ||
      mNachbarschaft == nachbarschaft_6_3d;


    /* Zufällige Graue? (optional) */
    mZufallsGraue = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("randomgreys", mVersion, zufallsgraue_keine);
  	  	
    /* Wo sind welche Grasbildchen am Anfang? */
    mAnfangsZeilen = mLevelConf[ldteil_level]->
      getListenEintrag("startdist",mVersion,false);


    /***** Noch ein paar einzelne Bilder laden *****/
    
    /* Explosion laden. Das darf erst nach dem Laden der Hintergrundfarbe
       passierren. */
    mExplosionBild.laden("explosion.xpm");

    /* Schriftfarbe der Punkte neu setzen. (Provisorisch) */
    Punktefeld::init();

    mDistKeyLen = 0;
    

    /***** Blops laden *****/

    mAnzFarben = 0;

    /* Wie viele Bilder malt ein Blop in einem Schritt höchstens?
       Erst mal keine. Die Sorten erhöhen diese Variablen selbst, wenn
       man sie lädt. */
    mStapelHoehe = 0;
    mNachbarStapelHoehe = 0;

    ladSorten("pics",blopart_farbe);
    ladSorten("startpic",blopart_gras);
    ladSorten("greypic",blopart_grau);

    /* Leer-Bildchen (optional) */
    mMitLeerBildchen = mLevelConf[ldteil_level]->hatEintrag("emptypic");
    /* Auch, wenn es kein Leer-Bildchen gibt, soll es geladen werden;
       dann liefert getEintrag() "" zurück, und Sorte::laden() weiß,
       dass es nur alle Werte auf Defaults setzen soll. */
    mSorten[blopart_keins] = new Sorte(mLevelConf[ldteil_level]->
        getWortEintragMitDefault("emptypic", mVersion, ""),
      mVersion, blopart_keins);

    /* Globaler Code (optional) */
    mSorten[blopart_global] = new Sorte("global", mVersion, blopart_global);
    mSorten[blopart_semiglobal] = new Sorte("semiglobal", mVersion,
					    blopart_semiglobal);
    
    
    /* Ok, alle Sorten geladen. Wenn wir noch mNachbarStapelhoehe zu
       mStapelHoehe addieren, stimmt diese Variable.
       Ab jetzt dürfen also Blops erzeugt werden
       (wenn man möchte). */
    //fprintf(stderr, "mStapelHoehe = %d, nsh = %d\n", mStapelHoehe, mNachbarStapelHoehe);    
    mStapelHoehe += mNachbarStapelHoehe;

    /* Nachbearbeitungen */
    if (mDistKeyLen==0)
      mDistKeyLen=1;

    /* Entstehungswahrscheinlichkeiten */
    mKeineGrauenW = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("nogreyprob", mVersion, 0);
    if (mKeineGrauenW<0)
      throw Fehler(_("nogreyprob must not be negative"));
    for (int i=0; i<anzahl_wv; i++) {
      mVerteilungSumme[i]=0;
      for (int j=blopart_min_sorte; j<mAnzFarben; j++)
	mVerteilungSumme[i] += mSorten[j]->getVerteilung(i);
    }
    if (mVerteilungSumme[wv_farbe]==0)
      throw Fehler(_("At least one %s must be positive."),
		   cVerteilungsNamen[wv_farbe]);
    if (mVerteilungSumme[wv_grau]+mKeineGrauenW==0)
      throw Fehler(_("nogreyprob or at least one %s must be positive."),
		   cVerteilungsNamen[wv_grau]);


   /* Musik (optional) */
   mMusik = mLevelConf[ldteil_level]->
     getWortEintragMitDefault("music", mVersion, "");

  /***** KI-Player-Bewertungen *****/
    mKINHoehe = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("aiu_height", mVersion, 10);
    mKINAnFarbe = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("aiu_color", mVersion, 10 * mAnzFarben);
    mKINAnGras = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("aiu_grass", mVersion, 20);
    mKINAnGrau = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("aiu_grey", mVersion, 10);
    mKINZweiUeber = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("aiu_two_above", mVersion, mKINAnFarbe / 2);
    mKINEinfarbigSenkrecht = mLevelConf[ldteil_level]->
      getZahlEintragMitDefault("aiu_monochromic_vertical", mVersion,
			       mKINAnFarbe);

  } catch (Fehler f) {
    Str fs = fehlerpos;
    /*if (!mLevelConf[ldteil_level]->getSquirrelPosString().isEmpty())
      fs += ", Section " + mLevelConf[ldteil_level]->getSquirrelPosString();
    fs += ":\n" + f.getText() + "\n";*/
    fs += f.getText() + "\n";
    
    if (!mLevelName.isEmpty())
      fs += _("(Level \"") + mLevelName + _("\")\n");
    throw Fehler(fs);
  }
	
} // ladLevel







/** Sollte am Anfang des Levels aufgerufen werden; kümmert sich
    um den Global-Blop */
void LevelDaten::startLevel() const {
  Blop::gGlobalBlop = Blop(blopart_global);
  // Damit Code ausgeführt werden darf:
  Blop::gGlobalBlop.setBesitzer(0,ort_absolut(absort_global)); 
}


/** Sollte einmal pro Spielschritt aufgerufen werden (bevor
    Spielfeld::spielSchritt() aufgerufen wird). Kümmert sich 
    um den Global-Blop */
void LevelDaten::spielSchritt() const {
  Blop::beginGleichzeitig();
  Blop::gGlobalBlop.animiere();
  Blop::endGleichzeitig();
}


/** Hilfsfunktion für getLevelAnz und getIntLevelName. Sucht nach dem
    ersten "." in na. */
int getPunktPos(Str na) {
  for (int i = 0; i < (int) na.length(); i++)
    if (na[i] == '.') return i;
  return -1;
}


/** Liefert zurück, wie viele Level es gibt. */
int LevelDaten::getLevelAnz() const {
  if (!mLevelConf[ldteil_summary])
    throw Fehler(_("Sorry, no working level description file available."));
  
  return mIntLevelNamen.size();
}


/** Liefert den internen Namen von Level nr zurück. */
Str LevelDaten::getIntLevelName(int nr) const {
  if (nr == level_titel)
    return Str("Title");

  int pos = nr - 1;
  Str s = mIntLevelNamen[pos];
  int pp = getPunktPos(s);
  if (pp == -1)
    return s;
  else
    return s.left(pp);
  
}

/** Liefert den Namen von Level nr zurück. Liefert "???" bei Fehler. */
Str LevelDaten::getLevelName(int nr) const {
  try {
    DatenDateiPush ddp(*(mLevelConf[ldteil_summary]),
		       getIntLevelName(nr), mVersion);

    return mLevelConf[ldteil_summary]->
      getWortEintragOhneDefault("name", mVersion);

  } catch (Fehler f) {
    return "???";
  }
}


/** Liefert die Nummer des Levels mit dem angegebenen Namen zurück,
    oder 0, wenn der Level nicht existiert. */
int LevelDaten::getLevelNr(Str na) const {
  /** Alles noch seeehr ineffektiv... */
  int anz = getLevelAnz();
  for (int i = 1; i <= anz; i++)
    if (na == getIntLevelName(i))
      return i;
  return 0;
}


/** Wenn eine Sorte ihre PlatzAnzahl rausgefunden hat, teilt sie uns das mit */
void LevelDaten::neue_PlatzAnzahl(int PlatzAnzahl) {
  if (mPlatzAnzahlMin==PlatzAnzahl_undefiniert) {
    CASSERT(mPlatzAnzahlMax==PlatzAnzahl_undefiniert);
    CASSERT(!mPlatzAnzahlAndere);
    mPlatzAnzahlMin = PlatzAnzahl;
    mPlatzAnzahlMax = PlatzAnzahl;
  }
  else {
    CASSERT(mPlatzAnzahlMax!=PlatzAnzahl_undefiniert);
    mPlatzAnzahlAndere = mPlatzAnzahlAndere ||
      ((PlatzAnzahl!=mPlatzAnzahlMin) && (PlatzAnzahl!=mPlatzAnzahlMax) &&
      (mPlatzAnzahlMin!=mPlatzAnzahlMax));
      /* Warum hat C eigentlich kein "||=" ? */
    if (mPlatzAnzahlMin > PlatzAnzahl)
      mPlatzAnzahlMin = PlatzAnzahl;
    if (mPlatzAnzahlMax < PlatzAnzahl)
      mPlatzAnzahlMax = PlatzAnzahl;
  }
}


int LevelDaten::zufallsSorte(int wv) {
  CASSERT(mVerteilungSumme[wv]);
  int nummer = Aufnahme::rnd(mVerteilungSumme[wv]);
  int i=blopart_min_sorte;
  for (; nummer>=0; i++)
    nummer-=mSorten[i]->getVerteilung(wv);
  /* Jetzt ist i die erste Sorte, die zu weit ist. */
  return i-1;
}



int LevelDaten::liesDistKey(const Str & key) {
  if (key=="")
    return distkey_undef;

  if (mDistKeyLen==0)
    mDistKeyLen=key.length();
  else
    if (mDistKeyLen!=key.length())
      throw Fehler(_("distkey \"%s\" does not have length %d as others do."),
		   key.data(), mDistKeyLen);

  switch (key[0]) {
  case '-': return distkey_grau;
  case '+': return distkey_farbe;
  case '*': return distkey_gras;
  case '.': return distkey_leer;
  default:
    bool anfang = true;
    int n=0;
    for (int i=0; i<key.length(); i++) {
      bool immernochanfang = false;
      n*=62;
      char c=key[i];
      if (c>='0' && c<='9')
	n+=c-'0';
      else
	if (c>='A' && c<='Z')
	  n+=c-'A'+10;
	else
	  if (c>='a' && c<='z')
	    n+=c-'a'+36;
	  else
	    if (anfang && c==' ')
	      immernochanfang = true;
	    else
	      throw Fehler(_("Illegal character \"%c\" in startdist or distkey %s"),
			   c,key.data());
      anfang = immernochanfang;
    }
    if (anfang)
      throw Fehler(_("All-spaces startdist entry or distkey is not allowed."));
    return n;
  }
}



const Version & LevelDaten::getVersion() const {
  return mVersion;
}



 /** Setzt mSchriftFarbe[...]. Berechnet also insbesondere die dunkle
     und die helle Farbe. */
void LevelDaten::setSchriftFarbe(Color f) {
  mSchriftFarbe[schrift_dunkel] =
     Color(f.mR / 2, f.mG / 2, f.mB / 2);
  mSchriftFarbe[schrift_normal] = f;
  mSchriftFarbe[schrift_hell] =
     Color(128 + f.mR / 2, 128 + f.mG / 2, 128 + f.mB / 2);

  /* Schriftfarbe der Punkte neu setzen. (Provisorisch) */
  Punktefeld::init();
  /* Und Hauptschriftfarbe setzen (Auch irgendwie provisorisch) */
  Font::setGameColor(f);
}

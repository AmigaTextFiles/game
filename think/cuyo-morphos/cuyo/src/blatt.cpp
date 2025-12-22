/***************************************************************************
                          blatt.cpp  -  description
                             -------------------
    begin                : Mit Jul 12 22:54:51 MEST 2000
    copyright            : (C) 2006 by Immi
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

#include <cstdio>
#include <cmath>

#include "../config.h"

#include "sdltools.h"

#include "font.h"

#include "cuyointl.h"
#include "ui.h"
#include "ui2cuyo.h"
#include "punktefeld.h"
#include "fehler.h"
#include "global.h"
#include "sound.h"

#include "prefsdaten.h"

#include "blatt.h"
#include "menueintrag.h"


/********************************************************************************/


void Blatt::doEvent(const SDL_Event & evt) {
  switch (evt.type) {
    case SDL_KEYDOWN:
      keyEvent(evt.key.keysym);
      break;
    case SDL_MOUSEMOTION:
      mouseMotionEvent(evt.motion.state & SDL_BUTTON(SDL_BUTTON_LEFT),
                       evt.motion.x, evt.motion.y,
                       evt.motion.x - evt.motion.xrel, evt.motion.y - evt.motion.yrel);
      break;
    case SDL_MOUSEBUTTONUP:
    case SDL_MOUSEBUTTONDOWN:
      if (evt.button.button == SDL_BUTTON_LEFT) {
        mouseButtonEvent(evt.button.state == SDL_PRESSED, evt.button.x, evt.button.y);
      }
      break;
    default:
      break;
  }
}


/********************************************************************************/


BlattSpiel::BlattSpiel() {
  mPunktefeld[0] = new Punktefeld();
  mPunktefeld[1] = new Punktefeld();

}



BlattSpiel::~BlattSpiel() {
  delete mPunktefeld[0];
  delete mPunktefeld[1];
}


void BlattSpiel::oeffnen(int lnr) {
  UI::setBlatt(this);
  Cuyo::startSpiel(lnr);
}





void BlattSpiel::keyEvent(const SDL_keysym & taste) {
  Cuyo::keyEvent(taste);
}





void BlattSpiel::anzeigen() {
  Color c = Color(150, 150, 150);
  
  /* Horizontale Ränder */
  Area::fillRect(0, 0, L_fenster_breite, L_rand, c);
  Area::fillRect(0, L_rand + L_punkte_hoehe, L_fenster_breite, L_rand, c);
  Area::fillRect(0, L_fenster_hoehe - L_rand, L_fenster_breite, L_rand, c);
  
  int spz = Cuyo::getSpielerZahl();

  int vx = 0;

  for (int i = 0; i < spz; i++) {
  
    /* Vertikaler Rand */
    int nx = L_spielfeld_x(i, spz);
    Area::fillRect(vx, 0, nx - vx, L_fenster_hoehe, c);
  
    Area::enter(SDLTools::rect(nx, L_spielfeld_y, L_spielfeld_breite, L_spielfeld_hoehe));
    Cuyo::malSpielfeld(i);
    Area::leave();
    
    Area::enter(SDLTools::rect(nx, L_rand, L_spielfeld_breite, L_punkte_hoehe));
    mPunktefeld[i]->updateGraphik();
    Area::leave();
    
    vx = nx + L_spielfeld_breite;
  }
  
  /* Vertikaler Rand */
  Area::fillRect(vx, 0, L_fenster_breite - vx, L_fenster_hoehe, c);
}



void BlattSpiel::zeitSchritt() {
  Cuyo::zeitSchritt();

  for (int i = 0; i < max_spielerzahl; i++)
    mPunktefeld[i]->zwinkerSchritt();

  /* Den folgenden Aufruf sollte man eigentlich
     Cuyo und den Punktefeldern ueberlassen; dann
     wuerd's nur passieren, wenn's muss */
  UI::nachEventAllesAnzeigen();
}



void BlattSpiel::setPunkte(int sp, int pt) {
  mPunktefeld[sp]->setPunkte(pt);
}



/*****************************************************************************/


BlattMenu::BlattMenu(bool immerscrollleiste /* = false */) :
    mImmerScrollleiste(immerscrollleiste),
    mEintraege(), mEintraegeY(1,0),
    mObermenu(NULL), mObereintrag(NULL), mWahl(eintrag_keiner), mHyperaktiv(eintrag_keiner),
    mInfoText(""), mInfoW(-1),
    mRaenderUpdaten(false), mInfozeileUpdaten(false)
{
}


BlattMenu::~BlattMenu() {
  menuLoeschen();
}


/* Gleich nach dem Konstruktor aufrufen, wenn das Obermenu nicht NULL
   sein soll. Schoener waers, obermenu direkt dem Konstruktor zu
   uebergeben. Das wuerde aber bedeuten, dass man gezwungen ist, in
   *jeder* Klasse, die von BlattMenu erbt, einen Konstruktor zu
   schreiben. Liefert einfach this zurueck, damit man 
     (new BlattMenuXXX())->setObermenu(...)
   schreiben kann */
BlattMenu * BlattMenu::setObermenu(BlattMenu * obermenu) {
  mObermenu = obermenu;
  return this;
}


void BlattMenu::setObereintrag(MenuEintragSubmenu * obereintrag) {
  mObereintrag = obereintrag;
}



void BlattMenu::neuerEintrag(MenuEintrag* eintrag) {
  mEintraegeY.push_back(mEintraegeY[mEintraege.size()]+eintrag->mHoehe);
  mEintraege.push_back(eintrag);
}


void BlattMenu::oeffnen(bool /*durchMaus*/, int wahl /*= eintrag_keiner*/) {


  mHyperaktiv = eintrag_keiner;
  mWahl = MausBereich(wahl);
  /* Nicht die nachfolgenden Setzroutinen verwenden, weil sonst
     evtl. ein nicht-mehr existenter voriger gewählter Menüpunkt neu
     gemalt wird. */
  //setHyperaktiv(eintrag_keiner);
  //setWahl(wahl);

  /* Jetzt manuell alles updaten */
  for (size_t i = 0; i < mEintraege.size(); i++)
    updateEintrag(i);

  /* Dafür manuell der Infozeile sagen, dass sie geupdatet werden muss */
  updateInfo();

  /* Zentrierlinien berechnen */
  int xsum[zl_anzahl];
  for (int i = 0; i < zl_anzahl; i++) xsum[i] = 0;
  for (size_t i = 0; i < mEintraege.size(); i++) {
    int zl = mEintraege[i]->getZentrierLinie();
    xsum[zl] += mEintraege[i]->getX0() + mEintraege[i]->getX1();
  }
  CASSERT(mEintraege.size());
  for (int i = 0; i < zl_anzahl; i++)
    mX0[i] = L_fenster_breite/2 - xsum[i]/((int) mEintraege.size());

  
  setScrollZielHigh(ynw_mitte, true);
  //if (durchMaus)
  //  setWahl(eintrag_keiner);

  UI::setBlatt(this);
  sichtbaresUpdaten();
}




int keypadersatz[10] = {
  SDLK_INSERT, SDLK_END, SDLK_DOWN, SDLK_PAGEDOWN, SDLK_LEFT,
  SDLK_KP5, SDLK_RIGHT, SDLK_HOME, SDLK_UP, SDLK_PAGEUP};

void BlattMenu::keyEvent(const SDL_keysym & taste) {

  /* Wenn die Taste einen Ascii-Code hat, dann wollen wir mit
     dem weiterarbeiten. (d.h. shift-& auf franzoesischer Tastatur
     ist 1) */
  int t = taste.unicode;
  /* Fuer sonstige Tasten (Pfeile, etc.) nehmen wir den SDL-Code */
  if (t <= 0 || t > 255)
    t = taste.sym;
  /* Aber Buchstaben haetten wir gerne als Grossbuchstaben.
     (Wenn wir auch Umlaute als Tastenkuerzel haetten, muessten
     wir uns auch darum kuemmern) */
  if (t >= 'a' && t <= 'z')
    t = t-'a'+'A';
  /* Wenn eine Ziffernblock-Taste gedrueckt wurde aber kein
     Uni-Code mitgeliefert wurde, dann soll das auf die uebliche
     Art wie Pfeiltasten wirken.
     (Manchmal macht SDL das automatisch; das scheint aber buggy
     zu sein.) */
  if (t>=SDLK_KP0 && t<=SDLK_KP9)
    t = keypadersatz[t-SDLK_KP0];
  
  
//   /* Keycode normalisieren */
//   int t = taste.sym;
//   if (t >= 'a' && t <= 'z')
//     t = t-'a'+'A';
//   if (t>=SDLK_KP0 && t<=SDLK_KP9) {
//     if (taste.mod & KMOD_NUM)
//       t = t-SDLK_KP0+'0';
//     else
//       t = keypadersatz[t-SDLK_KP0];
//   }
//   if (t==SDLK_KP_ENTER || t==SDLK_SPACE)
//     t=SDLK_RETURN;
// 
//   if (t == SDLK_ESCAPE) {
//     doEscape();
//     return;
//   }

  //printf("sym %d = '%c'     ", taste.sym, taste.sym);
  //printf("unicode %d = '%c'     ", taste.unicode, taste.unicode);
  //printf("taste %d = '%c'\n", t, t);

  /* Jeder Tastendruck stellt den Subbereich auf default;
     selbst solche, die nix bewirken */
  setWahl(mWahl.mEintrag);
 
  if (mHyperaktiv >= 0) {
    mEintraege[mHyperaktiv]->doHyperaktiv(taste,t);
    setWahl(mHyperaktiv);
    setHyperaktiv(eintrag_keiner);
    return;
  }

  switch (t) {
    case SDLK_UP:       navigiere(-1); break;
    case SDLK_DOWN:     navigiere(1); break;
    case SDLK_PAGEUP:   navigiere(-1,mZeigVon); break;
    case SDLK_PAGEDOWN: navigiere(1,mZeigBis-1); break;
    case SDLK_HOME:     navigiere(1,0); break;
    case SDLK_END:      navigiere(-1,mEintraege.size()-1); break;
    case SDLK_ESCAPE:
      doEscape();
      break;
    case SDLK_RETURN:
    case SDLK_KP_ENTER:
    case SDLK_SPACE:
      doReturn(false);
      break;
    default:
      /* Accelerator-Taste gedrückt? */
      for (int i = 0; i < (int) mEintraege.size(); i++) {
        if (t == mEintraege[i]->getAccel() && mEintraege[i]->getWaehlbar()) {
	  
          setWahl(i);
	  doReturn(false);
	  return;
        }
      }
      /* Vielleicht ist der gewählte Eintrag aktiv? */
      if (mWahl.mEintrag >= 0)
	if (mEintraege[mWahl.mEintrag]->getAktiv()) {
	  mEintraege[mWahl.mEintrag]->doHyperaktiv(taste,t);
          /* Tastatur-User wollen nix von Subbereichen wissen */
	  UI::nachEventAllesAnzeigen();
	}
      break;
  }

}


MausBereich BlattMenu::getMausPos(int x, int y) {
  /* Befindet sich die Maus in der Scrollbar? */
  bool sc = istScrollbar();
  if (sc || mImmerScrollleiste) {
    if (x >= L_scrollleiste_x && x < L_scrollleiste_x + gric) {
      /* Das mit dem 1000 ist weil negative Zahlen in die falsche Richtung gerundet werden */
      int yy = (y - L_scrollleiste_y + 1000 * gric) / gric - 1000;
      if (yy >= 0 && yy < L_scrollleiste_buttonzahl) {
        if (!sc && yy < 4) {
	  /* Auf grauem Scrollbarbutton */
	  return MausBereich();
	} else
          return MausBereich(eintrag_scrollleiste, yy);
      }
    }
  }

  int e=mEintraege.size();
  for (y-=mY0; e>=0 && y<mEintraegeY[e]; e--) {}
  /*                ~~ C garantiert, dass die rechte Seite nur
     ausgeführt wird, wenn's nötig ist */
  if (e < mAnimZeigVon || e >= mAnimZeigBis)
    return MausBereich();
  if (!mEintraege[e]->getWaehlbar())
    return MausBereich();
  int sb = mEintraege[e]->getMausPos(x - mX0[mEintraege[e]->getZentrierLinie()],
                                     y - mEintraegeY[e]);
  if (sb == subbereich_keiner)
    return MausBereich();
  else
    return MausBereich(e, sb);
}


/*  befindet sich der Cursor aus Sicht von Tastatur-Usern? */
int BlattMenu::getTastenCursorPos() {
  if (mHyperaktiv >= 0)
    return mHyperaktiv;
  else
    return mWahl.mEintrag;
}



void BlattMenu::mouseMotionEvent(bool press, int x, int y, int x_alt, int y_alt) {

  /* Bei gedrückter Maustaste rumfahren
     => Dort, wo der Knopf runter ging bleibt's ausgewählt */
  if (press) {
    return;
  }
  
  MausBereich mausAlt = getMausPos(x_alt, y_alt);
  MausBereich mausNeu = getMausPos(x, y);

  if (mausNeu == mausAlt)
    return;
  
  setWahl(mausNeu);
  UI::nachEventAllesAnzeigen();
}


void BlattMenu::mouseButtonEvent(bool press, int x, int y) {

  mPress = press;

  if (!press)
    return;
  
  MausBereich mausNeu = getMausPos(x, y);

  /* Wenn was hyperaktiv war, dann kann man's durch Mausklick
     enthyperaktivieren (selbst wenn man irgendwo anders ins
     Fenster klickt) */
  setHyperaktiv(eintrag_keiner);
  setWahl(mausNeu);

  if (mWahl.mEintrag >= 0)
    doReturn(true);
  else if (mWahl.mEintrag == eintrag_scrollleiste) {
    /* Um ganz hoch oder runter zu scrollen, können wir einfach auf
       viel zu weit setzen; setScrollZielLow macht das dann schon richtig */
    switch (mWahl.mSubBereich) {
      case 0: setScrollZielLow(99999); break;
      case 1: scrollleisteScroll(1); break;
      case 2: scrollleisteScroll(-1); break;
      case 3: setScrollZielLow(-99999); break;
      case 4: doEscape();
    }
  }
}





void BlattMenu::anzeigen() {

  //Area::fillRect(0, 0, L_fenster_breite, L_fenster_hoehe, Color(30, 30, 70));

  int info_oben = L_infosep + Font::gMenu->getFontHeight();

  
  /* Oberer und unterer Rand */
  if (mRaenderUpdaten) {
    /* Rand oberhalb des Menüs */
    Area::fillRect(0, 0, L_fenster_breite, mAnimY0+mEintraegeY[mAnimZeigVon],
		   Color(30, 30, 70));
    Area::updateRect(0, 0,
		     L_fenster_breite, mAnimY0+mEintraegeY[mAnimZeigVon]);
		     
    /* Zwischen Menü und Infozeile */
    /* Mark: Häh, ist das nicht das gleiche wie
       mAnimY0+mEintraegeY[mAnimZeigBis] ? */
    int y_u = mAnimY0+mEintraegeY[mAnimZeigBis - 1]
      + mEintraege[mAnimZeigBis - 1]->mHoehe;
    Area::fillRect(0, y_u, L_fenster_breite, info_oben - y_u,
		   Color(30, 30, 70));
    Area::updateRect(0, y_u, L_fenster_breite, info_oben - y_u);
    
    /* Wenn diese Farbe geändert wird, muß das auch in
       some_pic_sources/highlight.pov und some_pic_sources/Makefile
       geschehen. Und in menueintrag.cpp */
       
    mRaenderUpdaten = false;
  }

  int tc = getTastenCursorPos();

  for (int i = mAnimZeigVon; i < mAnimZeigBis; i++) {
    mEintraege[i]->anzeigen(mX0[mEintraege[i]->getZentrierLinie()],
                            mAnimY0+mEintraegeY[i], tc == i);
  }

  if (mInfozeileUpdaten) {
    Area::fillRect(0, L_fenster_hoehe - info_oben, L_fenster_breite, info_oben,
		   Color(30, 30, 70));
    Area::updateRect(0, L_fenster_hoehe - info_oben,
		     L_fenster_breite, info_oben);
    if (mInfoW>=0) {
      Font::gMenu->drawText(mInfoText,
			    mInfoX+L_info_hspace,
			    L_fenster_hoehe-L_infosep,
			    AlignBottomLeft);
      Font::gMenu->drawText(mInfoText,
			    mInfoX+L_info_hspace+mInfoW,
			    L_fenster_hoehe-L_infosep,
			    AlignBottomLeft);
    } else
      Font::gMenu->drawText(mInfoText, L_infosep, L_fenster_hoehe-L_infosep,
			    AlignBottomLeft);
    mInfozeileUpdaten = false;
  }
  
  bool sc = istScrollbar();
  if (sc || mImmerScrollleiste) {
    
    /* Provisorisch: Graphik wird noch jedes Mal neu gemalt */
    
    int scrollwahl = mWahl.mEintrag == eintrag_scrollleiste ? mWahl.mSubBereich : -1;
    for (int i = 0; i < L_scrollleiste_buttonzahl; i++) {
      int scrollbildchen[] = {2, 0, 1, 3, 6};
      int helligkeit = scrollwahl == i ? menupic_scrollbright : menupic_scroll;
      if (!sc && i < 4) helligkeit = menupic_scrolldimmed;
      gMenuPics[helligkeit].malBildchen(L_scrollleiste_x,
                        L_scrollleiste_y + i * gric,
			scrollbildchen[i]);
    }
    
    Area::updateRect(L_scrollleiste_x, L_scrollleiste_y,
                     gric, L_scrollleiste_buttonzahl * gric);
  }
}

void BlattMenu::doEscape() {
  if (mObermenu) {
    Sound::playSample(sample_menuclick,so_fenster);
    UI::setBlatt(mObermenu);
    mObermenu->sichtbaresUpdaten();
    if (mObereintrag)
      mObereintrag->doUntermenuSchliessen();
  }
}

void BlattMenu::doReturn(bool durchMaus) {
  if (mWahl.mEintrag == eintrag_keiner)
    return;
  if (mEintraege[mWahl.mEintrag]->getHyper()) {
    setHyperaktiv(mWahl.mEintrag);
  } else {
    mEintraege[mWahl.mEintrag]->doReturn(durchMaus);
  }
}


void BlattMenu::zeitSchritt() {
  /* Infozeile */
  if (mInfoW>=0) {
    mInfoX -= L_info_scrollspeed;
    if (mInfoX<=-mInfoW)
      mInfoX += mInfoW;
    mInfozeileUpdaten = true;
    UI::nachEventAllesAnzeigen();
  }
  
  /* Menüeinträge dürfen ihre Privat-Animation haben */
  for (size_t i=0; i<mEintraege.size(); i++)
    mEintraege[i]->zeitSchritt();
  
  /* Maus auf Scrollpfeil gedrückt? */
  if (mPress && mWahl.mEintrag == eintrag_scrollleiste) {
    if (mWahl.mSubBereich == 1) scrollleisteScroll(1); // hoch
    else if (mWahl.mSubBereich == 2) scrollleisteScroll(-1); // runter
  }
  
  /* Echte Scrollpos an gewünschte anpassen */
  scrollZeitSchritt();
}




void BlattMenu::navigiere(int d, int vorschlag /*=-1*/) {
  int sgn = d > 0 ? 1 : -1;

  int neu_wahl = mWahl.mEintrag;

  if (vorschlag >= 0) neu_wahl = vorschlag;
  else if (neu_wahl >= 0) neu_wahl += d;
  else if (sgn == 1) neu_wahl = -1 + d;
  else neu_wahl = mEintraege.size() + d;

  sgn = -sgn; /* Erstmal auf den alten Wert zulaufen */
  int angestossen = 0; /* Flags: 1=oben, 2=unten, 4=mitte */
  while (1) {
    if ((angestossen & 3) == 3) {
      /* Wenn wir beim Suchen eines passenden Menupunkts oben *und*
         unten anstossen, dann aufgeben */
      neu_wahl = -1;
      break;
    } else if (neu_wahl < 0) {
      neu_wahl = 0; sgn = 1; angestossen |= 5;
    } else if (neu_wahl >= (int) mEintraege.size()) {
      neu_wahl = mEintraege.size() - 1; sgn = -1; angestossen |= 6;
    } else if (neu_wahl==mWahl.mEintrag && !(angestossen & 4)) {
      sgn = -sgn; neu_wahl += sgn; angestossen |= 4;
    } else if (!mEintraege[neu_wahl]->getWaehlbar())
      neu_wahl += sgn;
    else
      break;
  }
  
  if (neu_wahl == mWahl.mEintrag) return;
  setWahl(neu_wahl);
  setScrollZielHigh(d>0 ? ynw_oben : ynw_unten);
  sichtbaresUpdaten();
  UI::nachEventAllesAnzeigen();
}



void BlattMenu::menuLoeschen() {
  for (int i = 0; i < (int) mEintraege.size(); i++)
    delete(mEintraege[i]);
  mEintraege.clear();
  mEintraegeY.clear();
  mEintraegeY.push_back(0);
}



/* Ändert wahl und kümmert sich drum, dass Graphik geupdatet wird */
void BlattMenu::setWahl(MausBereich wahl) {
  int walt = mWahl.mEintrag;
  mWahl = wahl;
  updateEintrag(walt);
  if (walt != wahl.mEintrag)
    updateEintrag(wahl.mEintrag);
  updateInfo();
}

void BlattMenu::setWahl(int eintrag, int subBereich /*= subbereich_default*/) {
  setWahl(MausBereich(eintrag, subBereich));
}


void BlattMenu::setHyperaktiv(int ha) {
  int halt = mHyperaktiv;
  mHyperaktiv = ha;
  updateEintrag(halt);
  if (halt != ha)
    updateEintrag(ha);
  updateInfo();
}


void BlattMenu::updateInfo() {
  Str neu = (mHyperaktiv >= 0
    ? mEintraege[mHyperaktiv]->getInfo()
    : (mWahl.mEintrag >= 0
      ? mEintraege[mWahl.mEintrag]->getInfo()
      : ""));
  if (neu != mInfoText) {
    mInfoText = neu;
    mInfoW = Font::gMenu->getLineWidth(mInfoText.data());
    if (mInfoW > L_fenster_breite-2*L_infosep) {
      mInfoW+=L_info_hspace;
      mInfoX=0;
    } else
      mInfoW=-1;
    mInfozeileUpdaten = true;
  }
}



/* Teilt dem Eintrag seinen neuen Subbereich mit. Der Eintrag kümmert
   sich dann um sein Graphik-Update */
void BlattMenu::updateEintrag(int e) {
  if (e < 0) return;
  mEintraege[e]->setSubBereich(
           mHyperaktiv == e ? subbereich_hyperaktiv :
           mWahl.mEintrag == e ? mWahl.mSubBereich :
           subbereich_keiner
         );
}


void BlattMenu::sichtbaresUpdaten() {
  for (int i = mAnimZeigVon; i < mAnimZeigBis; i++)
    mEintraege[i]->setUpdateFlag();
  mRaenderUpdaten = true;
  mInfozeileUpdaten = true;
}


bool BlattMenu::istScrollbar() const {
  return mEintraegeY[mEintraege.size()] > L_menu_hoehe;
}



void BlattMenu::scrollleisteScroll(int sgn) {
  setScrollZielLow(mY0 + sgn * L_maus_scroll_geschwindigkeit);
}



/* Gleicht mY0, mZeigVon und mZeigBis an mWahl an.
   sprung = true => keine Animation, sondern direkt dort hin. */  
void BlattMenu::setScrollZielHigh(yneuwahl ynw /*=ynw_mitte*/, bool sprung /* = false */) {

  /* Kein Menüpunkt gewählt? Dann nach oben */
  int w = mWahl.mEintrag < 0 ? 0 : mWahl.mEintrag;

  /* Erstmal nehmen wir an, daß wir mWahl gemäß ynw ausrichten wollen */
  int neuy = (L_menu_hoehe - mEintraege[w]->mHoehe)/2 - mEintraegeY[w];
  switch (ynw) {
    case ynw_mitte: break;
    case ynw_oben: neuy-=L_menu_scroll_vorsprung; break;
    case ynw_unten: neuy+=L_menu_scroll_vorsprung; break;
  }

  setScrollZielLow(neuy, sprung);
}




/* Setzt mY0 und gleicht mZeigVon und mZeigBis an.
   sprung = true => keine Animation, sondern direkt dort hin. */  
void BlattMenu::setScrollZielLow(int neuy, bool sprung /* = false */) {

  if (!istScrollbar()) {
    /* Das Menü passt komplett auf den Bildschirm. Dann wird der Scrollwunsch ignoriert. */
    neuy = (L_menu_hoehe-mEintraegeY[mEintraege.size()])/2;
    
  } else {
    /* Wenn scrollbar, dann aber nicht weiter rausscrollen als gesund wäre */
    if (neuy>L_menu_scroll_freiraum) {
      neuy = L_menu_scroll_freiraum;
    } else if (neuy+mEintraegeY[mEintraege.size()]+L_menu_scroll_freiraum<L_menu_hoehe) {
      neuy = L_menu_hoehe-L_menu_scroll_freiraum-mEintraegeY[mEintraege.size()];
    }
  }

  mY0 = neuy;
  
  calcZeigVonBis(mY0, mZeigVon, mZeigBis);
  
  if (sprung) {
    mAnimY0 = mY0;
    mAnimZeigVon = mZeigVon;
    mAnimZeigBis = mZeigBis;
    mScrollGesch = 0;
    sichtbaresUpdaten();
  } else {
    scrollZeitSchritt();
  }
}



/* Berechnet zeigVon und zeigBis aus Y0... mit oder ohne anim */
void BlattMenu::calcZeigVonBis(int y0, int & von, int & bis) {
  for (von = mEintraege.size();
       von>0 && y0+mEintraegeY[von-1]>=0;
       von--) {}
  for (bis = 0;
       bis<(int)mEintraege.size() && y0+mEintraegeY[bis+1]<=L_menu_hoehe;
       bis++) {}
}



void BlattMenu::scrollZeitSchritt() {
  if (mAnimY0 == mY0) {
    mScrollGesch = 0;
    return;
  }
  
  /* Wie schnell wären wir am liebsten, unter Berücksichtigung des Bremswegs?
     Die Formel mit der Wurzel und dem Abrunden sollte aufs Pixel genau stimmen. */
  int diff = mY0 - mAnimY0;
  int sgn = diff > 0 ? 1 : -1;
  int ziel_gesch = (int) floor((-0.5 + sqrt(0.25 + 2 * diff * sgn / L_scroll_beschleunigung))
             * L_scroll_beschleunigung) * sgn;

  /* Versuchen, diese Geschwindigkeit zu erreichen. */
  if (mScrollGesch + L_scroll_beschleunigung < ziel_gesch)
    mScrollGesch += L_scroll_beschleunigung;
  else if (mScrollGesch - L_scroll_beschleunigung > ziel_gesch)
    mScrollGesch -= L_scroll_beschleunigung;
  else
    mScrollGesch = ziel_gesch;
  
  mAnimY0 += mScrollGesch;
  
  calcZeigVonBis(mAnimY0, mAnimZeigVon, mAnimZeigBis);
  sichtbaresUpdaten();
  UI::nachEventAllesAnzeigen();
}



Bilddatei BlattMenu::gMenuPics[anz_menupics];

void BlattMenu::initMenus() {
  gMenuPics[menupic_pfeile].laden("menupics.xpm");
  gMenuPics[menupic_highlight].laden("highlight.xpm");
  gMenuPics[menupic_titel].laden("titel.xpm");
  gMenuPics[menupic_scroll].laden("scroll.xpm");
  gMenuPics[menupic_scrollbright].klonen(gMenuPics[menupic_scroll]);
  gMenuPics[menupic_scrolldimmed].klonen(gMenuPics[menupic_scroll]);

  gMenuPics[menupic_scroll].bildNachbearbeiten(Color(130,130,220));
  gMenuPics[menupic_scrollbright].bildNachbearbeiten(Color(255,255,128));
  gMenuPics[menupic_scrolldimmed].bildNachbearbeiten(Color(80,80,145));
}




/*****************************************************************************/

void BlattStartAt::oeffnen(bool durchMaus, int) {
  /* Zu umstaendlich:
     Im Moment liefert getMoeglicheLevel einen Vector von Strings zurück,
     der hier in einen Vector von Menueintraegen konvertiert werden muss.
     Besser waere, wenn direkt das Menu erzeugt werden koennte. */
  std::vector<Str> levNamen;
  int lev;
  Cuyo::getMoeglicheLevel(levNamen, lev);
  
  menuLoeschen();
  for (int i = 0; i < (int) levNamen.size(); i++)
    neuerEintrag(new MenuEintrag(this,levNamen[i]));
  /* MenuEintragAuswahl kann hier nicht verwendet werden: MenuEintragAuswahl()
     setzt das Blatt nach Return-Drücken auf Obermenü zurück; hier muss das
     Blatt aber auf Spiel gesetzt werden.
     (=> Im Moment kommt MenuEintragAuswahl nur noch an einer Stelle vor. Dafür
     lohnt sich eigentlich keine eigene Klasse.) */

  /* Darf erst jetzt aufgerufen werden; das Menü muss vorher schon aufgebaut
     worden sein */

  /* Wahl zählt bei 0 los, level bei 1 */
  BlattMenu::oeffnen(durchMaus, lev - 1);
}


void BlattStartAt::doReturn(bool) {
  Sound::playSample(sample_menuclick,so_fenster);
  /* Wahl zählt bei 0 los, level bei 1 */
  UI::startSpiel(mWahl.mEintrag + 1);
}




/*****************************************************************************/

void doNewGame() { UI::startSpiel(1); }
void doRestartLastLevel() {
  int lnr = Cuyo::getLetzterLevel();
  if (lnr != 0) {
    UI::startSpiel(lnr);
  }
}
void doQuit() { UI::quit(); }


bool stromRestartLastLevel() {
  return Cuyo::getLetzterLevel() != 0;
}


static MenuEintrag * gRestartLastLevel;

void updateRestartLastLevel() {
  gRestartLastLevel->updateStrom();
}

void setSchwierig(int i) {
  Cuyo::setSchwierig(i);
  gRestartLastLevel->updateStrom();
}

void setLevelpack(int p) {
  Cuyo::setLevelpack(p);
  gRestartLastLevel->updateStrom();
}

Str getVersionString() {
  /* The following should be done at compile time. */
  Str ret;
  for (const char * v = VERSION; *v; v++) {// VERSION is defined in config.h
    if (*v != '~')
      ret += *v;
  }
  return ret;
}


BlattHauptmenu::BlattHauptmenu() {
  neuerEintrag(new MenuEintragBild(this, menupic_titel));
  neuerEintrag(new MenuEintrag(this, _(getVersionString()),
         		      MenuEintrag::Art_deko));
  neuerEintrag(new MenuEintrag(this, "", MenuEintrag::Art_deko, L_medskip));
  
  neuerEintrag(new MenuEintrag(this,_("~New Game"), doNewGame));
  /* Den Eintrag RestartLastLevel abspeichern, damit er "Events" bekommt,
     wenn sein Stromstatus sich ändert */
  gRestartLastLevel = new MenuEintrag(this,_("~Restart last level"),
                                      doRestartLastLevel);
  gRestartLastLevel->setGetStrom(stromRestartLastLevel);
  neuerEintrag(gRestartLastLevel);

  neuerEintrag(new MenuEintragSubmenu(this,_("Start ~at level..."),
				      (new BlattStartAt())->setObermenu(this)));
  neuerEintrag(new MenuEintrag(this,"", MenuEintrag::Art_deko, L_medskip));
  neuerEintrag(new MenuEintragSpielerModus(this,_("~1 Player"),
                                           &updateRestartLastLevel, 1));
  neuerEintrag(new MenuEintragSpielerModus(this,_("~2 Player"),
                                           &updateRestartLastLevel, 2));
  neuerEintrag(new MenuEintragSpielerModus(this,_("Player vs. ~Computer"),
                                           &updateRestartLastLevel,
					   spielermodus_computer));
  neuerEintrag(new MenuEintrag(this,"", MenuEintrag::Art_deko, L_medskip));
  neuerEintrag(new MenuEintragAuswahlmenu(this,
					  _("~Level track"),
					  &Version::gLevelpack.mProsaNamen,
					  &Version::gLevelpack.mErklaerungen,
					  &Cuyo::getLevelpack,
					  &setLevelpack));
  neuerEintrag(new MenuEintragAuswahlmenu(this,
					  _("~Difficulty"),
					  &Version::gSchwierig.mProsaNamen,
					  &Version::gSchwierig.mErklaerungen,
					  &Cuyo::getSchwierig,
					  &setSchwierig,
					  "A few levels support difficulty settings\nIn the standard level track, a selection will be made"));
  neuerEintrag(new MenuEintrag(this,"", MenuEintrag::Art_deko, L_medskip));
  neuerEintrag(new MenuEintragSubmenu(this,_("~Preferences..."),
				      (new BlattPrefs())->setObermenu(this)));
  neuerEintrag(new MenuEintrag(this, "", MenuEintrag::Art_deko, L_medskip));
  neuerEintrag(new MenuEintrag(this, _("~Quit"), doQuit));
  if (gDebug) {
    neuerEintrag(new MenuEintrag(this, "", MenuEintrag::Art_deko, L_medskip));
    neuerEintrag(new MenuEintrag(this, _("Debug mode; Press alt-h for help."),
				 MenuEintrag::Art_deko));
  }
}


/********************************************************************************/


BlattPrefs::BlattPrefs(): BlattMenu() {

  for (int i = 0; i < 2; i++) {
    Str s = _sprintf(_("Keys Player %d:"), i + 1);
    neuerEintrag(new MenuEintrag(this, s, MenuEintrag::Art_deko));
    neuerEintrag(new MenuEintragTaste(this, _("Left"), i, 0));
    neuerEintrag(new MenuEintragTaste(this, _("Right"), i, 1));
    neuerEintrag(new MenuEintragTaste(this, _("Turn"), i, 2));
    neuerEintrag(new MenuEintragTaste(this, _("Down"), i, 3));
    neuerEintrag(new MenuEintrag(this, "", MenuEintrag::Art_deko, L_medskip));
  }

  neuerEintrag(new MenuEintragAI(this, _("AI Speed")));
  neuerEintrag(new MenuEintrag(this, "", MenuEintrag::Art_deko, L_medskip));
  neuerEintrag(new MenuEintragSound(this, _("Sound")));
  neuerEintrag(new MenuEintrag(this, "", MenuEintrag::Art_deko, L_medskip));
  neuerEintrag(new MenuEintragEscape(this));
}




void BlattPrefs::doEscape() {
  PrefsDaten::schreibPreferences();
  BlattMenu::doEscape();
}



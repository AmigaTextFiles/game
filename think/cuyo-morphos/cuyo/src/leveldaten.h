/***************************************************************************
                          leveldaten.h  -  description
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

#ifndef LEVELDATEN_H
#define LEVELDATEN_H

#include <vector>
#include <set>

#include "sdltools.h"

#include "sorte.h"
#include "bilddatei.h"
#include "version.h"

class Str;
class Code;
class Blop;
class DefKnoten;
class ListenKnoten;
class DatenDatei;
class Fehler;


/***** Konstanten, die irgend was einstellen *****/


#define max_spielerzahl 2

/* Größe des Levels */
#define grx 10
#define gry 20

#define platzbild_anzahl 8 // Anzahl der Bildchen der Platz-Animation

#define max_farben_zahl 200 // Max. Anzahl der Farben in einem Level

/* Wofür gibt es wie viele Punkte */
#define punkte_fuer_normales 1
#define punkte_fuer_graues 0
#define punkte_fuer_gras 20
#define punkte_fuer_kettenreaktion 10

/* Pixel pro Schritt: Bonus-Hetzrand-Geschwindigkeit */
#define bonus_geschwindigkeit 32
/* Punkte pro Zeitschritt der Bonus-Animation */
#define punkte_fuer_zeitbonus 10



/***** Konstanten, die einfach nur was bedeuten *****/

#define zufallsgraue_keine (-1)
#define PlatzAnzahl_undefiniert (-1)


/* Zur Übergabe an laden(), um den Titel-Level zu laden */
#define level_titel (-1)


/* Für das Array mSchriftfarbe */
#define schrift_dunkel 0
#define schrift_normal 1
#define schrift_hell 2

/* Für die codes in startdist */
#define distkey_leer (-1)
#define distkey_gras (-2)
#define distkey_grau (-3)
#define distkey_farbe (-4)
#define distkey_undef (-5)

/* nachbarschaft_... steht in sorte.h */



/* Zur Unterscheidung von lazy und eager */

enum LDTeil {
  ldteil_summary,
  ldteil_level,
  ldteile_anzahl
};



/** (Einziges globales) Objekt enthält alle Informationen über
    den aktuellen Level.
    
    Das Parsen der ld-Dateien:
    - Beim Aufruf des constructors von LevelDaten() wird ladLevelConf()
      aufgerufen.
    - ladLevelConf() sucht die richtige Datei und erzeugt ein
      DatenDatei-Objekt
    - Der Constructor davon öffnet die Datei und ruft parse() auf.
    - parse() ruft den bison-Parser auf. Der erzeugt folgendes:
      - Einen Baum aus Knoten: DefKnoten, ListenKnoten, WortKnoten
      - Jeder DefKnoten enthält noch eine Liste von Codeen (die
        in der level.descr in << >> definiert wurden)
      - Codeen sind auch wieder baumartig
    - Wenn in einem Code ein Name eines anderen Codes vorkommt,
      wird das schon beim Parsen aufgelöst, indem in den CodeSpeichern
      der darüberliegenden DefKnoten nachgeschaut wird
      
    
    @author Immi
*/


class LevelDaten {
  friend class Sorte;
  friend int yyparse();
	
 public:
  LevelDaten(const Version & version);
  ~LevelDaten();
  
  /** Läd die Levelconf (neu). Wird vom Konstruktor aufgerufen.
      Und, wenn sich Einstellungen verändert haben.
      Eine Vorbedingung ist also, daß niemand grad auf irgendwelche Daten
      dieses Objekts angewiesen ist, insbesondere also, daß grad kein
      Spiel läuft.
      Bei aufJedenFall=false wird nur dann wirklich neu geladen,
      wenn version!=mVersion.
      Bei ldteil=ldteil_summary wird am Ende noch der inhalt aller in
      global= aufgeführten Dateien nach ldteil_level geladen. */
  void ladLevelConf(LDTeil ldteil, bool aufJedenFall, const Version & version);
  
  /** Wird während des Parsens (d. h. innerhalb von ladLevelConf() von
      DefKnoten aufgerufen, wenn ein neuer Level gefunden wurde. Fügt
      den Level in die Liste der Level ein. ladLevelConf() kann sich
      danach immernoch entscheiden, ob es die Liste wieder löscht und
      durch die "level=..."-Liste ersetzt. */
  void levelGefunden(Str lna);

  /* Gibt Speicher frei */
  void entladLevel();
  
  /** füllt alle Daten in diesem Objekt für Level nr aus; throwt bei Fehler */
  void ladLevel(int nr);

  /** Sollte am Anfang des Levels aufgerufen werden; kümmert sich
      um den Global-Blop */
  void startLevel() const;
  
  /** Sollte einmal pro Spielschritt aufgerufen werden (bevor
      Spielfeld::spielSchritt() aufgerufen wird). Kümmert sich 
      um den Global-Blop */
  void spielSchritt() const;

  /** Liefert zurück, wie viele Level es gibt. */
  int getLevelAnz() const;

  /** Liefert den Namen von Level nr zurück. Liefert "???" bei Fehler. */
  Str getLevelName(int nr) const;

  /** Liefert den internen Namen von Level nr zurück. */
  Str getIntLevelName(int nr) const;

  /** Liefert die Nummer des Levels mit dem angegebenen Namen zurück,
      oder 0, wenn der Level nicht existiert. */
  int getLevelNr(Str na) const;

  /** Wenn eine Sorte ihre Platzanzahl rausgefunden hat,
      teilt sie uns das mit */
  void neue_PlatzAnzahl(int);

  int zufallsSorte(int wv);

  int liesDistKey(const Str &);

  const Version & getVersion() const;

  /** Setzt mSchriftFarbe[...]. Berechnet also insbesondere die dunkle
      und die helle Farbe. */
  void setSchriftFarbe(Color f);

 protected:
   
  /** Läd ein paar Sorten. Wird mehrfach von ladLevel() aufgerufen. */
  void ladSorten(const Str & ldKeyWort, int blopart);
 
 
 /** Die Objekte, mit denen man auf die Dateien zugreift. Hier stehen nur
     Pointer drauf, damit diese .h-Datei nicht so viel includen muss. */
  DatenDatei * mLevelConf[ldteile_anzahl];
  /** True, wenn zur Zeit was geladen ist. */
  bool mGeladen[ldteile_anzahl];
  /** Alle Level, die schon mal geladen wurden und daher noch vorhanden sind.
      Hier stehen die Dateinamen. */
  std::set<Str> mLevelCache;
  /** Liste der internen Levelnamen. */
  std::vector<Str> mIntLevelNamen;

  Version mVersion;
  
 public:

  /* Die ganzen nachfolgenden Variablen werden von ladLevel() gesetzt.
     Danach greifen alle anderen Objekte, die was mit dem Spiel zu tun
     haben, direkt darauf zu. */


  /***** Allgemeines *****/
  int mSpielerZahl;
  /** Interner Level-Name vom aktuellen Level. (Wird von Aufnahme
      benötigt.) */
  Str mIntLevelName;
  Str mLevelName;
  Str mLevelAutor;
  /** Der Knoten zum aktuellen Level. */
  DefKnoten * mLevelKnoten;
  /** Beschreibungstext für den Level */
  Str mBeschreibung;
  Color mHintergrundFarbe;
  bool mMitHintergrundbildchen;
  Bilddatei mHintergrundBild;
  /** Farbe der Schrift in dem Level:
      0 = abgedunkelt, 1 = normal, 2 = aufgehellt */
  Color mSchriftFarbe[3];
  bool mGrasBeiKettenreaktion;
  Bilddatei mExplosionBild;
  int mPlatzAnzahlDefault;
  int mPlatzAnzahlMin;
  int mPlatzAnzahlMax;
  /* Gibt an, ob neben mPlatzAnzahlMin und mPlatzAnzahlMax noch andere
     PlatzAnzahlen vorkommen. */
  bool mPlatzAnzahlAndere;
  Str mMusik;
  
  /** Max. Anzahl der Bilder, die ein Blop gleichzeitig malt. Wird
      (ggf.) von den Sorten erhöht, wenn man sie lädt. */
  int mStapelHoehe;
  /** Anzahl der Bilder, die Blops auf Nachbarfelder malen. Der Einfachheit
      halber wird das hier für alle Sorten aufsummiert, statt alles schön
      nach relativen Koordinaten zu trennen, etc.
      Wird auch von den Sorten erhöht, wenn man sie lädt. */
  int mNachbarStapelHoehe;
  
  /***** Die Sorten *****/
 protected:
  /** Das Array, in dem alle Sorten stehen. Allerdings soll die Index-
      Menge nicht bei 0 losgehen, sondern bei blop_min_sorte. Deshalb
      gibt es in public die Variable mSorten... */
  Sorte * mSortenIntern[max_farben_zahl - blopart_min_sorte];
 public:
  /** Wird ganz am Anfang auf mSortenIntern - blopart_min_sorte
      initialisiert. */
  Sorte * * const mSorten;
  int mAnzFarben;
  int mVerteilungSumme[anzahl_wv];
  int mKeineGrauenW;    /** Zählt nicht zu mGrauSumme */
 
  /***** Hetzrand *****/
  Color hetzrandFarbe;
  int hetzrandZeit;
  bool mMitHetzbildchen;
  Bilddatei mHetzBild;
  int mHetzrandUeberlapp;
  int mHetzrandStop;

  /***** Fall *****/
  int mFall_langsam_pix;
  int mFall_schnell_pix;

  /***** Gras *****/
  ListenKnoten * mAnfangsZeilen;
  int mDistKeyLen; /** Länge der distKeys. 0, wenn es noch keinen gab. */


  /***** KI-Player-Nutzen-Funktion *****/
  /** Zusatzpunkte für beide Blops gleiche Farbe & Senkrecht*/
  int mKINEinfarbigSenkrecht;
  /** Vorfaktor vor Bewertung der Blop-Höhe */
  int mKINHoehe;
  /** Punkte für Blob mit gleicher Farbe benachbart */
  int mKINAnFarbe;
  /** Punkte für Blob mit Gras benachbart */
  int mKINAnGras;
  /** Punkte für Blob mit Grauem benachbart */
  int mKINAnGrau;
  /** Punkte für Blob zwei über gleicher Farbe */
  int mKINZweiUeber;
	
  /***** Sonderfeatures *****/
  bool mSpiegeln;
  int mNachbarschaft; // Default-Wert für die Sorten
  /** true bei Sechseckraster. Wird direkt aus mNachbarschaft bestimmt. */
  bool mSechseck;
  bool mMitLeerBildchen;
  int mZufallsGraue;

 protected:

  bool mSammleLevel; /* Bestimmt, ob levelGefunden überhaupt was tun soll. */

};

/* Definition in leveldaten.cpp */
extern LevelDaten * ld;


#endif

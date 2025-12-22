/***************************************************************************
                          sorte.h  -  description
                             -------------------
    begin                : Fri Apr 20 2001
    copyright            : (C) 2001 by Immi
    email                : cuyo@karimmi.de
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef SORTE_H
#define SORTE_H

#include <vector>
#include "stringzeug.h"

//#include "fehler.h"
//#include "bilddatei.h"
//#include "blopbesitzer.h" // Nur für die Verbindungskonstanten

class Version;
class DefKnoten;



/* Zur Übergabe an Sorte() */
#define verbart_nein 0
#define verbart_selten 1
#define verbart_ja 2


/* Für das verbindetMitRand-Array: */
#define rand_links 0
#define rand_rechts 1
#define rand_oben 2
#define rand_unten 3

/* Konstanten für neighbours= */
#define nachbarschaft_normal 0
#define nachbarschaft_schraeg 1
#define nachbarschaft_6 2
#define nachbarschaft_6_schraeg 3
#define nachbarschaft_springer 4
#define nachbarschaft_dame 5
#define nachbarschaft_6_3d 6
#define nachbarschaft_garnichts 7
#define nachbarschaft_letzte 7


/** Event-Nummern in mEventCode. Die entsprechenden Strings stehen
    in sorte.cpp. */
#define event_draw 0 // Haupt-Mal-Code; Sonderbehandlung; muss 0 bleiben
#define event_init 1 // einmal am Anfang
#define event_turn 2 // bei jedem drehen
#define event_land 3 // kommt auf dem Boden auf (nur bei Fall)
#define event_changeside 4 // wechselt zum anderen Spieler
#define event_connect 5    // Verbindungen neu berechnen
#define event_row_up1 6    // Reihe bekommen
#define event_row_up2 7    // Reihe bekommen
#define event_row_down1 8  // Reihe abgegeben
#define event_row_down2 9  // Reihe abgegeben
#define event_keyleft 10   // Taste links
#define event_keyright 11  // Taste rechts
#define event_keyturn 12   // Taste drehen
#define event_keyfall 13   // Taste fallen
#define event_anz 14


/* Blop-Arten / -Sortennummern. Die Nummern >= 0 sind die normalen
   Farbsorten. */
#define blopart_keins (-1)
/* Letzte Art, auf die man ein Blop von cual aus noch setzen darf */
#define blopart_min_cual (-1)
/* Blop, der nicht wirklich zu sehen ist, sondern nur die globale
   Animation ausführt */
#define blopart_global (-2)
/* dito, aber hiervon gibt es je Spieler einen */
#define blopart_semiglobal (-3)
/* Letzte Art, von der es noch wirklich eine Sorte und Blops gibt. Alles
   andere sind nur Rückgabewerte oder so was. */
#define blopart_min_sorte (-3)
/* Rückgabewert, falls Koordinaten nach außerhalb vom Spielfeld zeigen. */
#define blopart_ausserhalb (-4)
/* Rückgabewert von getArt(), wenn es sich um einen Farbblop handelt.
   Und Wert, den man an Sorte::Sorte() übergeben kann. */
#define blopart_farbe (-5)
#define blopart_gras (-6)
#define blopart_grau (-7)



/* W-Verteilungen für die zufällige Sortenauswahl */

enum {
  wv_farbe,
  wv_grau,
  wv_gras,
  anzahl_wv
};

/* Namen werden in sorte.cpp definiert. */
extern const char cEventNamen[event_anz][33];
extern const char* cVerteilungsNamen[anzahl_wv];


class Bilddatei;
class Blop;
class Code;





/** Enthält alle Informationen über eine Blopsorte; kann solche Blops malen
  *@author Immi
  */

class Sorte {
	

 public: 
  /** Lädt die Sorte mit dem angegebenen Namen. Schaut auch in der
      entsprechenden Gruppe von mLevelConf nach, setzt die Gruppe
      aber danach zurück. blopart muss nur angegeben werden, damit ein
      paar Art-abhängige Defaults richtig gesetzt werden können.
      Throwt Fehler, wenn erfolglos. */
  Sorte(const Str & name, const Version & version, int blopart);
  
  ~Sorte();
	
  
  
  
	
 protected:
  /** löscht die ganzen Bilder aus dem bilddateien-Array */
  void loeschBilder();

  /** Wird an zwei Stellen in Sorte() aufgerufen */
  void setzeDefaults(DefKnoten * quelle);

  /** Wird von Sorte() aufgerufen; ausgelagert, weil Sorte() langsam
      lang und unübersichtlich wird */
  void ladeCualEvents(const Version & version);


 public:
 
  /***** Getter-Methoden, mit denen man auf die ganzen Informationen
         zugreifen kann. *****/
  
  
  Str getName() const;

  int getBlopart() const;
  
  bool getVerbindetMitRand(int r) const;
  
  int getNachbarschaft() const;
  
  int getPlatzAnzahl() const;

  int getVerteilung(int wv) const;

  int getDefault(int var) const;
  int getDefaultArt(int var) const;
  
  Code * getEventCode(int evt) const;

  int getDistKey() const;
  int getVersions() const;
  
  Bilddatei * getBilddatei(int nr) const;
	
  
  /* ACHTUNG! Beim Neueinfügen von Variablen, die aus der
   * level.descr gelesen werden, nicht vergessen, am Anfang
   * von Sorte::Sorte() defaults zu setzen! */
  
 protected:			
  /** Der Name, unter dem in Code-Programmen auf die Sorte
      zugegriffen wird. */
  Str mName;
  /** Was beim Konstruktor übergeben wurde */
  int mBlopart;
  /** Verbinden sich diese Blops auch zum Rand hin? Aufgeschlüsselt
      nach den Rändern. (Konstanten rand_...) */
  bool mVerbindetMitRand[4];
  /** Was zählt als Nachbarn im Sinne einer Kette? */
  int mNachbarschaft;
  /** Wie viele Steine müssen zusammen, damit sie platzen? */
  int mPlatzAnzahl;
  /** Entstehwahrscheinlichkeiten */
  int mVerteilung[anzahl_wv];
  /** Defaultwerte für Blops dieser Sorte. */
  int * mDatenDefault;
  int * mDatenDefaultArt;
  /** Repräsentation in startdist:
      Zeichen(kette) für version=0, Anzahl an Versionen */
  int mDistKey;
  int mVersions;

  /** Alle Bildchen zu diesem Blop */
  std::vector<Bilddatei *> mBilddateien;

  /** Code, der zu bestimmten Events aufgerufen wird (bzw. 0). */
  Code * mEventCode[event_anz];
  
};

#endif

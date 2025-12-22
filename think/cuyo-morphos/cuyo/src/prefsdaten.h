/***************************************************************************
                          prefsdaten.h  -  description
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

#ifndef PREFSDATEN_H
#define PREFSDATEN_H

#include <set>
#include <vector>

#include "SDL.h"

/* Konstanten für das Tasten-Array */
/* Achtung: Vor Ändern dieser Konstanten checken, ob
   ui::zeigePrefs() immernoch so von diesen Konstanten abhaengt. */
#define taste_anz 4
#define taste_links 0
#define taste_rechts 1
#define taste_dreh 2
#define taste_fall 3



/** Datenstruktur für das, was in .cuyo steht:
    Das, was man im preferences-Dialog einstellen kann und
    welche Level gewonnen wurden. */

namespace PrefsDaten {

  void init();

  /** Schreibt eine Liste aller auswählbaren Level nach levnamen;
      levnamen sollte vorher leer sein.
      sp2 = true bedeutet zweispielermodus
      In def wird ein default zurückgeliefert, den man verwenden
      kann, wenn es nicht eh grad eine naheliegende nächste Level-Nr
      gibt. */
  void getMoeglicheLevel(bool sp2, std::vector<Str> & levnamen,
                                     int & def);


  /** sp2: true bei zweispielermodus */
  void schreibGewonnenenLevel(bool sp2, int lnr);
  
  /** Liefert true, wenn die Taste k belegt ist, und speichert dann
      in sp und t ab, was die Taste tut. */
  bool getTaste(SDLKey k, int & sp, int & t);
  
  SDLKey getTaste(int sp, int t);
  double getKIGeschwLin();
  int getKIGeschwLog();
  
  void setTaste(int sp, int t, SDLKey code);
  void setKIGeschwLog(int kigl);
  
  bool getSound();
  void setSound(bool s);

  /* Sollte nach Aenderungen mit set...() aufgerufen werden */
  void schreibPreferences();
}


#endif

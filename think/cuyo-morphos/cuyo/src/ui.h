/***************************************************************************
                          ui.h  -  description
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

#ifndef UI_H
#define UI_H

#include "inkompatibel.h"
#include "stringzeug.h"

#include "leveldaten.h" // wegen grx, gry, max_spielerzahl; sollte woanders hin



#define MENU_new_game 100
#define MENU_restart_level 101
#define MENU_start_at 102
#define MENU_pause_game 104
#define MENU_stop_game 105
#define MENU_preferences 110
#define MENU_quit 120

#define MENU_1_player 131
#define MENU_2_player 132
#define MENU_KI_player 133

class Blatt;

namespace UI {


  /** "construtor" */
  void init();
  /** "Descructor" */
  void destroy();
  
  void run();

  /* Auf diese Surface muessen die Spielfelder malen */
  SDL_Surface * getSpielfeldSurface(int sp);
  
  /* Zeigt *jetzt* den neuen Bildschirminhalt an */
  void sofortAllesAnzeigen();
  /* Zeigt den Bildschirminhalt zu einem vernünftigen
     Zeitpunkt neu an */
  void nachEventAllesAnzeigen();
  
  void setPunkte(int sp, int pt);
    
  void startSpiel(int lnr);
  
  /** Cuyo teilt dem ui mit, dass das Spiel zu Ende ist */
  void stopSpiel();
  
  /***** Die folgenden Methoden sollen nur von der ui-Haelfte des
         Programms aufgerufen werden und nicht von der cuyo-Haelfte *****/
  
  /* Ein Blatt sollte selbst in seiner oeffnen()-Methode setBlatt(this)
     aufrufen. Kann man aber auch woanders aufrufen, wenn das entsprechende
     Blatt grad keinen oeffnen()-Aufruf braucht. */
  void setBlatt(Blatt * b);

  void malText(const Str & text);
  
  void quit();

}

#endif

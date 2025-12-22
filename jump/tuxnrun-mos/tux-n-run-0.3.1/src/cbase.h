/***************************************************************************
                          cbase.h  -  description
                             -------------------
    begin                : Sat Jun 14 2003
    copyright            : (C) 2003 by Marius Andra
    email                : marius@hot.ee
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef CBASE_H
#define CBASE_H

#include <string>
#include <map>

#include "csdl.h"
#include "cinput.h"
#include "ctitle.h"
#include "cgame.h"
#include "cleveledit.h"

using namespace std;

enum mode {TITLE, GAME, GAMETITLE, LEVELEDIT, END};

/**
  *@author Marius
  */

class CBase
{
  public: 
  CBase();
  ~CBase();
  
  /** Initalizes the engine. Loads initial datafiles, etc... */
  int init(map<string, string> arguments);
  /** Gets called every 1/100 seconds. Everything is done from here */
  int update(CInput &Input);
  /** Draw everything */
  int render();
  /** Change the current displayed screen */
  void changeMode(mode nextMode);
  /** Returns 1 if game is over, 0 otherwise. */
  int gameOver();
  /** End the game */
  void gameIsOver();
  /** free memory, etc */
  void cleanUp();
  /** Returns the SDL class */
  CSDL * getSDL();
  /** Return the Game class */
  CGame * getGame();
  /** Start the game */
  void startGame(int players);

  private:
  CSDL mSDL;
  CTitle mTitle;
  CGame mGame;
  CLevelEdit mLevelEdit;
  mode mMode;
  mode mNextMode;
  int mFadeTimer;
  int mGameOver;
};

#endif

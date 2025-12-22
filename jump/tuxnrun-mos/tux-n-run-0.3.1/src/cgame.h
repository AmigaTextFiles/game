/***************************************************************************
                          cgame.h  -  description
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

#ifndef CGAME_H
#define CGAME_H

#include <map>
#include <string>
#include <vector>

#include "cinput.h"
#include "csdl.h"
#include "clevel.h"

#include "keysyms.h"

class CBase;

using namespace std;

/**
  *@author Marius
  */

class CGame
{
  public: 
  CGame();
  ~CGame();
  /** Initialize */
  int init(map<string, string> &arguments, CBase *base);
  /** Render the display */
  int render(int game);
  /** Clean up */
  void cleanUp();
  /** Update */
  void update(CInput &Input, int game);
  /** Change the level */
  void loadLevel(int nr, int players);
  /** Return the level */
  CLevel * getLevel();

  private:
  CBase *mBase;
  CSDL *mSDL;
  CLevel mLevel;
  int mNumLevels;
  vector<string> mLevels;
  vector<string> mLevelPasswords;
  string mDataDir;
  int mPaused;
	int mNumViews;
	int mKeys[4][KEY_COUNT];
};

#endif

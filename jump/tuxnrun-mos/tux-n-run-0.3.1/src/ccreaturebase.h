/***************************************************************************
                          ccreaturebase.h  -  description
                             -------------------
    begin                : Sun Jun 15 2003
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

#ifndef CCREATUREBASE_H
#define CCREATUREBASE_H

#include <string>
#include <vector> 
#include "csdl.h"
#include "ctileset.h"

using namespace std;

/**
  *@author Marius
  */

enum creature_state {WALK_LEFT = -1, TURN, WALK_RIGHT, MOUNT};
  
class CCreatureBase
{
  public: 
  CCreatureBase();
  ~CCreatureBase();
  /** Load the creature base */
  /** Initialize the creature base */
  void init(CSDL *sdl);
  int load(string path);
  /** Clear everything, free memory */
  int dispose();
  /** Return the width of the creature */
  int getWidth();
  /** Return the height of the creature */
  int getHeight();
  /** Draw the creature */
  int draw(int x, int y, creature_state state, int frame, int special);
  /** Do we have the turn bitmap? */
  int hasTurn();
  /** Number of frames in the turn animation */
  int getTurnFrames(int special);
  /** Number of frames in the walk left animation */
  int getWalkLeftFrames(int special);
  /** Number of frames in the walk right animation */
  int getWalkRightFrames(int special);
  /** Return the ID of the special creature tileset corresponding to a string */
  int getSpecialID(string special);

  private:
  int mLoaded;
  CSDL *mSDL;
  CTileSet *mWalkLeft, *mWalkRight, *mTurn;
  int *mWalkLeftFrames, *mWalkRightFrames, *mTurnFrames;
  int mWidth, mHeight, mOffsetX, mOffsetY;
  int mNumSpecials;
  vector<string> mSpecials;
  string mSExtension, mSWalkLeft, mSWalkRight, mSTurn, mSSeperator;
  int mHasTurn, mHasWalkLeft, mHasWalkRight, mHasSeperator, mHasExtension;
  string mSound_Jump, mSound_Fall, mSound_Squish, mSound_BigJump, mSound_Die;
};

#endif

/***************************************************************************
                          ccreaturebase.cpp  -  description
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

#include <fstream>
#include <iostream>
 
#include "ccreaturebase.h"

CCreatureBase::CCreatureBase() {mLoaded=0;}
CCreatureBase::~CCreatureBase() {}

/** Load the creature base */
int CCreatureBase::load(string path)
{
  cout << "Loading creature " << path << endl;
  if(mLoaded && dispose())  return 1;
  ifstream file((path+"/info").c_str());
  if(!file.is_open())
  {
    cout << "Error loading creature file " << path << "/info" << endl;
    return 1;
  }

  string temp, temp2;

  mSExtension = ""; mHasExtension = 0; mSWalkLeft = ""; mHasWalkLeft = 0; mSWalkRight = ""; mHasWalkRight = 0;
  mSTurn = ""; mHasTurn = 0; mWidth = 0; mHeight = 0; mOffsetX = 0; mOffsetY = 0; mNumSpecials = 0; mSSeperator = "";
  mHasSeperator = 0; mSound_Jump = ""; mSound_Fall = ""; mSound_BigJump = ""; mSound_Die = ""; mSpecials.clear();
  
  while( !file.eof() )
  {
    file >> temp >> temp2;
    if(temp == "extension") { mSExtension = temp2; mHasExtension = 1; }
    if(temp == "walk_left") { mSWalkLeft = temp2; mHasWalkLeft = 1; }
    if(temp == "walk_right") { mSWalkRight = temp2; mHasWalkRight = 1; }
    if(temp == "turn") { mSTurn = temp2; mHasTurn = 1; }
    if(temp == "width") { mWidth = atoi(temp2.c_str()); }
    if(temp == "height") { mHeight = atoi(temp2.c_str()); }
    if(temp == "offset_x") { mOffsetX = atoi(temp2.c_str()); }
    if(temp == "offset_y") { mOffsetY = atoi(temp2.c_str()); }
    if(temp == "specials") { mNumSpecials = atoi(temp2.c_str()); }
    if(temp == "special") { mSpecials.push_back(temp2); }
    if(temp == "seperator") { mSSeperator = temp2; mHasSeperator = 1; }
    if(temp == "sound_jump") { mSound_Jump = temp2; }
    if(temp == "sound_fall") { mSound_Fall = temp2; }
    if(temp == "sound_squish") { mSound_Squish = temp2; }
    if(temp == "sound_bigjump") { mSound_BigJump = temp2; }
    if(temp == "sound_die") { mSound_Die = temp2; }
  }

  file.close();

  mNumSpecials = mNumSpecials > 0 ? mNumSpecials : 0;
  mTurn = new CTileSet[ mNumSpecials + 1 ];
  mWalkLeft = new CTileSet[ mNumSpecials + 1 ];
  mWalkRight = new CTileSet[ mNumSpecials + 1 ];
  mTurnFrames = new int[ mNumSpecials + 1 ];
  mWalkLeftFrames = new int[ mNumSpecials + 1 ];
  mWalkRightFrames = new int[ mNumSpecials + 1 ];

  for(int i=0;i<=mNumSpecials;i++)
  {
    mTurn[i].init(mSDL);
    mWalkLeft[i].init(mSDL);
    mWalkRight[i].init(mSDL);
    if(i == 0)
    {
      if(mHasTurn) mTurn[0].load(path, mSTurn+mSExtension, mSTurn+".dat");
      if(mHasWalkLeft) mWalkLeft[0].load(path, mSWalkLeft+mSExtension, mSWalkLeft+".dat");
      if(mHasWalkRight) mWalkRight[0].load(path, mSWalkRight+mSExtension, mSWalkRight+".dat");
    } else {
      if(mHasTurn) mTurn[i].load(path, mSTurn+mSSeperator+mSpecials[i-1]+mSExtension, mSTurn+mSSeperator+mSpecials[i-1]+".dat");
      if(mHasWalkLeft) mWalkLeft[i].load(path, mSWalkLeft+mSSeperator+mSpecials[i-1]+mSExtension, mSWalkLeft+mSSeperator+mSpecials[i-1]+".dat");
      if(mHasWalkRight) mWalkRight[i].load(path, mSWalkRight+mSSeperator+mSpecials[i-1]+mSExtension, mSWalkRight+mSSeperator+mSpecials[i-1]+".dat");
    }
    if(mHasTurn) mTurnFrames[i] = mTurn[i].getNumTiles();
    if(mHasWalkLeft) mWalkLeftFrames[i] = mWalkLeft[i].getNumTiles();
    if(mHasWalkRight) mWalkRightFrames[i] = mWalkRight[i].getNumTiles();
  }
  
  return 0;
}

/** Initialize the creature base */
void CCreatureBase::init(CSDL *sdl)
{
  mLoaded = 0;
  mSDL = sdl;
}

/** Clear everything, free memory */
int CCreatureBase::dispose()
{
  for(int i=0;i<=mNumSpecials;i++)
  {
    mTurn[i].dispose();
    mWalkLeft[i].dispose();
    mWalkRight[i].dispose();
  }

  mSExtension = ""; mHasExtension = 0; mSWalkLeft = ""; mHasWalkLeft = 0; mSWalkRight = ""; mHasWalkRight = 0;
  mSTurn = ""; mHasTurn = 0; mWidth = 0; mHeight = 0; mOffsetX = 0; mOffsetY = 0; mNumSpecials = 0; mSSeperator = "";
  mHasSeperator = 0; mSound_Jump = ""; mSound_Fall = ""; mSound_BigJump = ""; mSound_Die = ""; mSpecials.clear();
  return 0;
}

/** Return the width of the creature */
int CCreatureBase::getWidth()
{
  return mWidth;
}

/** Return the height of the creature */
int CCreatureBase::getHeight()
{
  return mHeight;
}

/** Draw the creature */
int CCreatureBase::draw(int x, int y, creature_state state, int frame, int special)
{
  if(state == TURN)
  {
    if(!mHasTurn)
    {
      state = WALK_LEFT;
    } else {
      mTurn[special].drawTile(frame%mTurnFrames[special], x-mOffsetX, y-mOffsetY);
      return 0;
    }
  }
  if(state == WALK_LEFT)
  {
    if(!mHasWalkLeft)
    {
      state = WALK_RIGHT;
    } else {
      mWalkLeft[special].drawTile(frame%mWalkLeftFrames[special], x-mOffsetX, y-mOffsetY);
      return 0;
    }
  }
  if(state == WALK_RIGHT)
  {
    if(!mHasWalkRight)
    {
      return 1;
    } else {
      mWalkRight[special].drawTile(frame%mWalkRightFrames[special], x-mOffsetX, y-mOffsetY);
    }
  }
  return 0;
}

/** Do we have the turn bitmap? */
int CCreatureBase::hasTurn()
{
  return mHasTurn;
}

/** Number of frames in the turn animation */
int CCreatureBase::getTurnFrames(int special)
{
  return mTurnFrames[special];
}

/** Number of frames in the walk left animation */
int CCreatureBase::getWalkLeftFrames(int special)
{
  return mWalkLeftFrames[special];
}

/** Number of frames in the walk right animation */
int CCreatureBase::getWalkRightFrames(int special)
{
  return mWalkRightFrames[special];
}

/** Return the ID of the special creature tileset corresponding to a string */
int CCreatureBase::getSpecialID(string special)
{
	for(int i=0;i<mNumSpecials;i++)
	{
   	if(mSpecials[i] == special) return i;
	}
	return -1;
}

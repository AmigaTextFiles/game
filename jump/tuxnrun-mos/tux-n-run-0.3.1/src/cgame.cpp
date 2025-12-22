/***************************************************************************
                          cgame.cpp  -  description
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

#include <fstream>
#include <iostream>
 
#include "cbase.h"
#include "cgame.h"
#include "keysyms.h"

CGame::CGame() {}
CGame::~CGame() {}

/** Initialize */
int CGame::init(map<string, string> &arguments, CBase *base)
{
  mBase = base;
  mSDL = mBase->getSDL();

  mDataDir = arguments["datadir"];

  ifstream file((mDataDir+"/levels/levels").c_str());
  if(!file.is_open())
  {
    cout << "Error loading level data" << endl;
    return 1;
  }

  int temp;
  string temp1, temp2;
  mNumLevels = 0;
  while(!file.eof())
  {
    file >> temp >> temp1 >> temp2;
    mLevels.push_back(temp1);
    mLevelPasswords.push_back(temp2);
    mNumLevels++;
  }
	mNumViews = 1;

  file.close();

	mKeys[0][KEY_LEFT] = SDLK_LEFT;
	mKeys[0][KEY_RIGHT] = SDLK_RIGHT;
	mKeys[0][KEY_JUMP] = SDLK_UP;
	mKeys[0][KEY_SHOOT] = SDLK_RETURN;

	mKeys[1][KEY_LEFT] = SDLK_a;
	mKeys[1][KEY_RIGHT] = SDLK_d;
	mKeys[1][KEY_JUMP] = SDLK_w;
	mKeys[1][KEY_SHOOT] = SDLK_q;

  mLevel.init(mSDL);
  
  return 0;
}

/** Clean up */
void CGame::cleanUp()
{
  mLevel.dispose();
}

/** Render the display */
int CGame::render(int game)
{
	int mWidth = mSDL->getWidth();
	int mHeight = mSDL->getHeight();
	int mWidth2 = mSDL->getWidth()/2;
	int mHeight2 = mSDL->getHeight()/2;
  if(game)
  {
		if(mNumViews == 1)
		{
			mSDL->clip(0,0,mWidth,mHeight);
	    mLevel.render(0,0,mWidth,mHeight,0);
		} else if(mNumViews == 2) {
			mSDL->clip(0,0,mWidth,mHeight2);
	    mLevel.render(0,0,mWidth,mHeight2,0);

			mSDL->clip(0,mHeight2,mWidth,mHeight2);
	    mLevel.render(0,mHeight2,mWidth,mHeight2,1);
		} else if(mNumViews == 3 || mNumViews == 4) {
			mSDL->clip(0,0,mWidth2,mHeight2);
	    mLevel.render(0,0,mWidth2,mHeight2,0);

			mSDL->clip(mWidth2,0,mWidth2,mHeight2);
	    mLevel.render(mWidth2,0,mWidth2,mHeight2,1);

			mSDL->clip(0,mHeight2,mWidth2,mHeight2);
	    mLevel.render(0,mHeight2,mWidth2,mHeight2,2);

			if(mNumViews == 4)
			{
				mSDL->clip(mWidth2,mHeight2,mWidth2,mHeight2);
		    mLevel.render(mWidth2,mHeight2,mWidth2,mHeight2,3);
			} else {
				mSDL->clip(mWidth2,mHeight2,mWidth2,mHeight2);
				mSDL->clearArea(mWidth2,mHeight2,mWidth2,mHeight2,0x000000);
			}
 		}
		mSDL->clip(0,0,mWidth,mHeight);
		if(mNumViews > 1)
		{
 			mSDL->clearArea(0,mHeight2,mWidth,1,0xffffff);
		}
		if(mNumViews > 2)
		{
 			mSDL->clearArea(mWidth2-1,0,1,mHeight,0xffffff);
		}
  } else {
		mSDL->clip(0,0,mWidth,mHeight);
    if(mLevel.hasTitle())
    {
      mSDL->drawSurface(mLevel.getTitle(), 0, 0, NULL);
    } else {
      mBase->changeMode(GAME);
    }
  }
  return 0;
}

/** Update */
void CGame::update(CInput &Input, int game)
{
  if(game)
  {
    if(Input.wasPressed(SDLK_ESCAPE))
    {
      mBase->changeMode(TITLE);
    }

    if(Input.wasPressed(SDLK_1))
    {
      mNumViews = 1;
    }
    if(Input.wasPressed(SDLK_2))
    {
      mNumViews = 2;
    }
    if(Input.wasPressed(SDLK_3))
    {
      mNumViews = 3;
    }
    if(Input.wasPressed(SDLK_4))
    {
      mNumViews = 4;
    }

    if(!mPaused)
    {
      mLevel.update(Input, mKeys);
    }
  } else {
    if(Input.wasPressed(-1))
    {
      mBase->changeMode(GAME);
    }
  }
}

/** Change the level */
void CGame::loadLevel(int nr, int players)
{
  if(nr>0 && nr <= mNumLevels)
  {
    cout << "Loading level: " << nr << endl;
    mLevel.load(mDataDir,"levels/"+mLevels[nr-1], players);
		mNumViews = players;
  } else {
    cout << "Error! Can't open level nr. " << nr << ": it doesn't exist!" << endl;
  }
}

/** Return the level */
CLevel * CGame::getLevel()
{
  return &mLevel;
}

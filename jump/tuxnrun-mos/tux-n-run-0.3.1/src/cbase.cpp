/***************************************************************************
                          cbase.cpp  -  description
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

#include <iostream>
 
#include "cbase.h"

#define FADETICKS 30

CBase::CBase() { }
CBase::~CBase() { }

/** Initalizes the engine. Loads initial datafiles, etc... */
int CBase::init(map<string, string> arguments)
{
  if(mSDL.init(1,1))
  {
    return 1;
  }
  
  if(mSDL.setVideoMode(
    atoi(arguments["screen_width"].c_str()),
    atoi(arguments["screen_height"].c_str()),
    atoi(arguments["screen_depth"].c_str()),
    atoi(arguments["fullscreen"].c_str())))
  {
    return 1;
  }

  if(mTitle.init(arguments, this)) return 1;
  if(mGame.init(arguments, this)) return 1;
  if(mLevelEdit.init(arguments, this)) return 1;

  mFadeTimer = 0;
  mGameOver = 0;

	SDL_WM_SetCaption(arguments["window_caption"].c_str(), NULL);

  return 0;
}

/** Gets called every 1/100 seconds. Everything is done from here */
int CBase::update(CInput &Input)
{
	if(Input.wasPressed(SDLK_F1))
	{
   	mSDL.toggleFullScreen();
	}

  if(mFadeTimer < FADETICKS) mFadeTimer++;
  if(mFadeTimer==0)
  {
    mMode = mNextMode;
  }

  if(mMode == TITLE)
  {
    mTitle.update(Input);
  } else if(mMode == GAME || mMode == GAMETITLE) {
    mGame.update(Input, mMode == GAME);
  } else if(mMode == LEVELEDIT) {
    mLevelEdit.update(Input);
  }
  
  return 0;
}

/** Draw everything */
int CBase::render()
{
  if(mMode == TITLE)
  {
    mTitle.render();
  } else if(mMode == GAME || mMode == GAMETITLE) {
    mGame.render(mMode == GAME);
  } else if(mMode == LEVELEDIT) {
    mLevelEdit.render();
  }

  if(mFadeTimer != FADETICKS)
  {
    mSDL.drawBlackLayer((Uint8)((FADETICKS-(float)abs(mFadeTimer))/FADETICKS*255.0));
  }
  
  mSDL.flush();
  return 0;
}

/** Change the current displayed screen */
void CBase::changeMode(mode nextMode)
{
  mNextMode = nextMode;
  if(mFadeTimer == FADETICKS)
  {
    mFadeTimer = -FADETICKS;
  } else if(mFadeTimer > 0) {
    mFadeTimer = -mFadeTimer;
  }
  cout << "Request to change mode to " << nextMode << endl;
}

/** Returns 1 if game is over, 0 otherwise. */
int CBase::gameOver()
{
  return mMode == END;
}

/** End the game */
void CBase::gameIsOver()
{
  changeMode(END);
}

/** free memory, etc */
void CBase::cleanUp()
{
  mTitle.cleanUp();
  mGame.cleanUp();
  mLevelEdit.cleanUp();
  mSDL.cleanUp();
}

/** Returns the SDL class */
CSDL * CBase::getSDL()
{
  return &mSDL;
}

/** Return the Game class */
CGame * CBase::getGame()
{
  return &mGame;
}

/** Start the game */
void CBase::startGame(int players)
{
  mGame.loadLevel(1, players);
  if(mGame.getLevel()->hasTitle())
  {
    changeMode(GAMETITLE);
  } else {
    changeMode(GAME);
  }
}

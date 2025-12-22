/***************************************************************************
                          cinput.cpp  -  description
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

#include <string.h>

#include "cinput.h"

CInput::CInput() {}
CInput::~CInput() {}

/** Return the events */
SDL_Event * CInput::getEvents()
{
  return &mEvent;  
}

/** Update input stuff */
void CInput::update()
{
  mAnyPressed = 0;
  mAnyDown = 0;
	for(int i=0;i<SDLK_LAST;i++)
	{
   	if(mPressed[i] == 1) mAnyPressed = 1;
   	if(mDown[i] == 1) mAnyDown = 1;
	}
	mMouseClick = 0;

  mMouseButtons = SDL_GetMouseState(&mX, &mY);
	if(mLastPress == -1 && (mMouseButtons & SDL_BUTTON(1)))
	{
    mLastPress = 1;
		mPressedX = mX;
		mPressedY = mY;
	} else if(mLastPress == 1 && !(mMouseButtons & SDL_BUTTON(1))) {
    mLastPress = -1;
		mReleaseX = mX;
		mReleaseY = mY;
		mMouseClick = 1;
	}
}

/** Return the keys currently held down */
Uint8 * CInput::getKeys()
{
  return mDown;
}

/** Returns true if key is being held down */
int CInput::isDown(int key)
{
  if(key == -1) return mAnyDown;
  return mDown[key];
}

/** Clear things like keys pressed, mouse clicks, etc. */
void CInput::clear()
{
  memset(mPressed,0,SDLK_LAST);
  mAnyPressed = 0;
	mMouseClick = 0;
}

/** Initalize */
void CInput::init()
{
  mDown = new Uint8[SDLK_LAST];
  mPressed = new Uint8[SDLK_LAST];
  memset(mDown,0,SDLK_LAST);
  memset(mPressed,0,SDLK_LAST);
	mLastPress = -1;
}

/** Was the key pressed? */
int CInput::wasPressed(int key)
{
  if(key == -1) return mAnyPressed;
  return mPressed[key];
}

/** The key was pressed down */
void CInput::keyDown(int key)
{
	mDown[key] = 1;
}

/** The key got released */
void CInput::keyUp(int key)
{
	mDown[key] = 0;
	mPressed[key] = 1;
}

/** Has the mouse been clicked? And if so, where? */
int CInput::mouseClicked(int *px, int *py, int *rx, int *ry)
{
	if(!mMouseClick) return 0;

	if(px != NULL) *px = mPressedX;
	if(py != NULL) *py = mPressedY;
	if(rx != NULL) *rx = mReleaseX;
	if(ry != NULL) *ry = mReleaseY;

	return 1;
}

/***************************************************************************
                          cinput.h  -  description
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

#ifndef CINPUT_H
#define CINPUT_H

#include "SDL.h"

/**
  *@author Marius
  */

class CInput
{
  public: 
  CInput();
  /** Return the events */
  SDL_Event * getEvents();
  ~CInput();
  /** Return the keys currently held down */
  Uint8 * getKeys();
  /** Update input stuff */
  void update();
  /** Returns true if key is being held down */
  int isDown(int key);
  /** Clear things like keys pressed, mouse clicks, etc. */
  void clear();
  /** Initalize */
  void init();
  /** Was the key pressed? */
  int wasPressed(int key);
  /** The key got released */
  void keyUp(int key);
  /** The key was pressed down */
  void keyDown(int key);
  /** Has the mouse been clicked? And if so, where? */
  int mouseClicked(int *px, int *py, int *rx, int *ry);

  private:
  SDL_Event mEvent;
  Uint8 *mDown;
  Uint8 *mPressed;
  int mAnyPressed, mAnyDown;
	int mGravity;
	int mX, mY;
	int mReleaseX, mReleaseY;
	int mPressedX, mPressedY;
	Uint8 mMouseButtons;
	int mLastPress;
	int mMouseClick;
};

#endif

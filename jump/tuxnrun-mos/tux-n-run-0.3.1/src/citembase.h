/***************************************************************************
                          citembase.h  -  description
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

#ifndef CITEMBASE_H
#define CITEMBASE_H

#include "csdl.h"
#include "ctileset.h"

/**
  *@author Marius
  */

class CItemBase
{
  public: 
  CItemBase();
  ~CItemBase();
  /** Load the creature base */
  int load(string name, string path);
  /** Initalize the creature base. */
  void init(CSDL *sdl);
  /** Clear memory used by the item base */
  int dispose();
  /** Return the number of frames in the item animation */
  int getFrames();
  /** Render a frame on the screen. */
  void render(int x, int y, int frame);
  /** Do gravitational forces apply to items of this type? */
  int hasGravity();
  /** Return the width of the item base. */
  int getWidth();
  /** Return the height of the item base. */
  int getHeight();
  /** Return the delay between two frames */
  int getDelay();
  /** Return the name of the item type */
  string getName();

	private:
	CSDL *mSDL;
	CTileSet mTiles;
	int mLoaded;
	int mWidth, mHeight, mOffsetX, mOffsetY;
	int mDelay, mGravity;
	string mName;
};

#endif

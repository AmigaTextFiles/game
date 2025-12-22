/***************************************************************************
                          citembase.cpp  -  description
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

#include "citembase.h"

CItemBase::CItemBase() {mLoaded = 0;}
CItemBase::~CItemBase() {}

/** Initalize the creature base. */
void CItemBase::init(CSDL *sdl)
{
	mSDL = sdl;
}

/** Load the creature base */
int CItemBase::load(string itemName, string path)
{
	mName = itemName;
  cout << "Loading item " << path << endl;
  if(mLoaded && dispose())  return 1;
  ifstream file((path+"/info").c_str());
  if(!file.is_open())
  {
    cout << "Error loading item info file " << path << "/info" << endl;
    return 1;
  }

	string ext, name;
	string temp, temp2;

  while( !file.eof() )
  {
    file >> temp >> temp2;
    if(temp == "extension") { ext = temp2; }
    if(temp == "filename") { name = temp2; }
    if(temp == "width") { mWidth = atoi(temp2.c_str()); }
    if(temp == "height") { mHeight = atoi(temp2.c_str()); }
    if(temp == "offset_x") { mOffsetX = atoi(temp2.c_str()); }
    if(temp == "offset_y") { mOffsetY = atoi(temp2.c_str()); }
    if(temp == "delay") { mDelay = atoi(temp2.c_str()); }
    if(temp == "gravity") { mGravity = (temp2=="on"||temp2=="yes"); }
  }

  file.close();

	mTiles.init(mSDL);
	mTiles.load(path,name+ext,name+".dat");

 	mLoaded = 1;
	return 0;
}

/** Clear memory used by the item base */
int CItemBase::dispose()
{
  if(mLoaded)
	{
   	mTiles.dispose();
		mLoaded = 0;
	}
	return 0;
}

/** Return the number of frames in the item animation */
int CItemBase::getFrames()
{
	return mTiles.getNumTiles();
}

/** Render a frame on the screen. */
void CItemBase::render(int x, int y, int frame)
{
	mTiles.drawTile(frame, x-mOffsetX, y-mOffsetY);
}

/** Do gravitational forces apply to items of this type? */
int CItemBase::hasGravity()
{
	return mGravity;
}

/** Return the width of the item base. */
int CItemBase::getWidth()
{
	return mWidth;
}

/** Return the height of the item base. */
int CItemBase::getHeight()
{
	return mHeight;
}

/** Return the delay between two frames */
int CItemBase::getDelay()
{
	return mDelay;
}

/** Return the name of the item type */
string CItemBase::getName()
{
	return mName;
}

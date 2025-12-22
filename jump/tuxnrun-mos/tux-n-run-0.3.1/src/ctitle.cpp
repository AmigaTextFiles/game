/***************************************************************************
                          ctitle.cpp  -  description
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
#include "ctitle.h"

CTitle::CTitle() {}
CTitle::~CTitle() {}

/** Initialize */
int CTitle::init(map < string , string > & arguments, CBase *base)
{
  mBase = base;
  mSDL = mBase->getSDL();
  mTitleImage = mSDL->loadImage(arguments["datadir"]+"/title.bmp");
  return 0;
}

/** Clean up */
void CTitle::cleanUp()
{
  mSDL->disposeSurface(mTitleImage);
}

/** Render the display */
int CTitle::render()
{
  mSDL->drawSurface(mTitleImage, 0, 0, NULL);
  return 0;
}

/** Update */
void CTitle::update(CInput & Input)
{
	int px, py, rx, ry;
  if(Input.wasPressed(SDLK_ESCAPE))
  {
    mBase->changeMode(END);
  } else if(Input.mouseClicked(&px, &py, &rx, &ry)) {
		if(inArea(px,py,rx,ry,68,75,258,47)) { mBase->startGame(1); }
		if(inArea(px,py,rx,ry,68,123,258,48)) { mBase->startGame(2); }
		if(inArea(px,py,rx,ry,68,312,258,56)) { mBase->changeMode(END); }
  } else if(Input.wasPressed(-1)) {

  }
}

/** Are the coordinates px, py and rx, ry in the area x,y + (w,h)? */
int CTitle::inArea(int px, int py, int rx, int ry, int x, int y, int w, int h)
{
	if(px >= x && px <= x+w && py >= y && py <= y+h &&
     rx >= x && rx <= x+w && ry >= y && ry <= y+h) return 1;
	return 0;
}

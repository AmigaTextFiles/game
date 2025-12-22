/***************************************************************************
                          ctitle.h  -  description
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

#ifndef CTITLE_H
#define CTITLE_H

#include <map>
#include <string>

#include "cinput.h"
#include "csdl.h"

class CBase;

using namespace std;

/**
  *@author Marius
  */

class CTitle
{
  public: 
  CTitle();
  ~CTitle();
  /** Initialize */
  int init(map < string , string > & arguments, CBase *base);
  /** Update */
  void update(CInput & Input);
  /** Render the display */
  int render();
  /** Clean up */
  void cleanUp();
  /** Are the coordinates px, py and rx, ry in the area x,y + (w,h)? */
  int inArea(int px, int py, int rx, int ry, int x, int y, int w, int h);

  private:
  CBase *mBase;
  CSDL *mSDL;
  SDL_Surface *mTitleImage;
};

#endif

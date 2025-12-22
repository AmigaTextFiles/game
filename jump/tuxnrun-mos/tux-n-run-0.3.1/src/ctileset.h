/***************************************************************************
                          ctileset.h  -  description
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

#ifndef CTILESET_H
#define CTILESET_H

#include <string>

#include "csdl.h"

using namespace std;

/**
  *@author Marius
  */

class CTileSet
{
  public: 
  CTileSet();
  ~CTileSet();
  /** Unload the tileset from memory */
  int dispose();
  /** Load a tileset into memory */
  int load(string path, string img, string data);
  /** Return the number of tiles in the loaded tileset */
  int getNumTiles();
  /** Initalize the class */
  int init(CSDL *sdl);
  /** Return the height of a tile. */
  int getHeight();
  /** Return the width of a tile. */
  int getWidth();
  /** Draw a tile on the screen */
  int drawTile(int nr, int x, int y);
  /** Return the tileset SDL_Surface */
  SDL_Surface * getSurface();

  private:
  CSDL *mSDL;
  SDL_Surface *mTiles;
  int mLoaded, mNumTiles, mTileHeight, mTileWidth;
  int mCols, mRows, mBorder, mBorderTop, mTRed, mTGreen, mTBlue;
};

#endif

/***************************************************************************
                          ctileset.cpp  -  description
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

#include "ctileset.h"

CTileSet::CTileSet() {mLoaded=0;}
CTileSet::~CTileSet() {}

/** Load a tileset into memory */
int CTileSet::load(string path, string img, string data)
{
  string temp, temp2;
  if(mLoaded) dispose();
  cout << "Loading tileset " << path << "/" << img << endl;

  ifstream dataIn((path + "/" + data).c_str());
  if(!dataIn.is_open())
  {
    cout << "ERROR loading data file " << path << "/" << data << endl;
    return 1;
  }

  mTRed = -1; mTGreen = -1; mTBlue = -1;
  mBorder = 0; mBorderTop = 0; mCols = 0; mRows = 0;

  while( !dataIn.eof() )
  {
    dataIn >> temp >> temp2;
    if(temp == "cols") mCols = atoi(temp2.c_str());
    if(temp == "rows") mRows = atoi(temp2.c_str());
    if(temp == "tile_width") mTileWidth = atoi(temp2.c_str());
    if(temp == "tile_height") mTileHeight = atoi(temp2.c_str());
    if(temp == "border") mBorder = atoi(temp2.c_str());
    if(temp == "border_top") mBorderTop = atoi(temp2.c_str());
    if(temp == "transparent_red") mTRed= atoi(temp2.c_str());
    if(temp == "transparent_green") mTGreen = atoi(temp2.c_str());
    if(temp == "transparent_blue") mTBlue = atoi(temp2.c_str());
  }
  dataIn.close();

  if(mTRed > -1)
  {
    if((mTiles = mSDL->loadImage(path+"/"+img, mTRed, mTGreen, mTBlue)) == NULL)
    {
      cout << "ERROR loading image file " << img << "!" << endl;
      return 1;
    }
  } else {
    if((mTiles = mSDL->loadImage(path+"/"+img)) == NULL)
    {
      cout << "ERROR loading image file " << img << "!" << endl;
      return 1;
    }
  }

  mNumTiles = mCols * mRows;
  
  mLoaded = 1;
  
  return 0;  
}

/** Unload the tileset from memory */
int CTileSet::dispose()
{
  if(mLoaded)
  {
    SDL_FreeSurface(mTiles);
  }
  mLoaded = 0;
  
  return 0;
}

/** Initalize the class */
int CTileSet::init(CSDL *sdl)
{
  mSDL = sdl;
  return 0;
}

/** Return the number of tiles in the loaded tileset */
int CTileSet::getNumTiles()
{
  return mNumTiles;
}

/** Return the width of a tile. */
int CTileSet::getWidth()
{
  return mTileWidth;
}

/** Return the height of a tile. */
int CTileSet::getHeight()
{
  return mTileHeight;
}

/** Draw a tile on the screen */
int CTileSet::drawTile(int nr, int x, int y)
{
  if(nr<0 || nr >= mNumTiles || !mLoaded) return 1;
  mSDL->drawSurface(mTiles, x, y,
      mBorderTop+(nr%mCols)*(mTileWidth+mBorder),
      mBorderTop+(nr/mCols)*(mTileHeight+mBorder),
      mTileWidth, mTileHeight); 
  return 0;
}

/** Return the tileset SDL_Surface */
SDL_Surface * CTileSet::getSurface()
{
  return mTiles;
}

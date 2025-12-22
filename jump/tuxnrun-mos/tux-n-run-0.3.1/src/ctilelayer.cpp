/***************************************************************************
                          ctilelayer.cpp  -  description
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

#include "ctilelayer.h"

#include <fstream>
#include <iostream>

CTileLayer::CTileLayer() {mLoaded = 0;}
CTileLayer::~CTileLayer() {}

/** Load the tile layer into memory */
int CTileLayer::load(string map, CTileSet *tiles)
{
  if(mLoaded) dispose();

  cout << "Loading tile layer " << map << endl;
  
  mTileSet = tiles;
  ifstream file(map.c_str(), ios::binary);
  if(!file.is_open())
  {
    cout << "Error opening tile-data" << endl;
    return 1;
  }
  file >> mWidth >> mHeight >> mRepeatX >> mRepeatY;
  mTileData = new Sint16[mWidth*mHeight];
  file.read((char *)(mTileData), sizeof(char));
  file.read((char *)(mTileData), sizeof(Sint16)*mWidth*mHeight);
  file.close();
  mLoaded = 1;
  return 0;
}

/** Save the tile layer into a file */
int CTileLayer::save(string map)
{
  if(!mLoaded) return 1;

  cout << "Saving tile layer into " << map << endl;
    
  ofstream file(map.c_str(), ios::binary);
  if(!file.is_open())
  {
    return 1;
  }
  file << mWidth << endl << mHeight << endl << mRepeatX << " " << mRepeatY;
  file.write((char *)(mTileData), sizeof(Sint16)*mWidth*mHeight);
  file.close();
  return 0;
}

/** Get rid of the loaded data */
int CTileLayer::dispose()
{
  if(mLoaded)
  {
    delete [] mTileData;
    mLoaded = 0;
  }
  return 0;
}

#define TILEDATA(x,y) ((x<mWidth&&y<mHeight)?mTileData[(x)%mWidth+((y)%mHeight)*mWidth]:-1)

/** Render the tilelayer on the screen */
int CTileLayer::render(int offsetx, int offsety, int x, int y, int w, int h)
{
  int ox = offsetx / 16, oy = offsety / 16;
  for(int i=0;i<(w/16)+2;i++)
  {
    for(int j=0;j<(h/16)+2;j++)
    {
      mTileSet->drawTile(TILEDATA(ox+i,oy+j), x+(i*16)-offsetx%16, y+(j*16)-offsety%16);
    }
  }
  return 0;
}

/** Modify one tile in the tilemap */
int CTileLayer::setTile(Sint16 nr, int x, int y)
{
  if(x < mWidth && y < mHeight && x >= 0 && y >= 0)
  {
    mTileData[x+y*mWidth] = nr;
    return 0;
  }
  return 1;
}

/** Return the width of the layer */
int CTileLayer::getWidth()
{
  return mWidth*mRepeatX;
}

/** Return the height of the tile layer */
int CTileLayer::getHeight()
{
  return mHeight*mRepeatY;
}

/** Return the tile in the position x, y. Check the position for validity. Return 0 on error (empty tile). */
Sint16 CTileLayer::getTile(int x, int y)
{
  if(x < mWidth && y < mHeight && x >= 0 && y >= 0)
    return mTileData[x+y*mWidth];
  return -1;
}

/** Return the tile. Don't check the coordinates for validity. */
Sint16 CTileLayer::getTileNoCheck(int x, int y)
{
  return mTileData[x+y*mWidth];
}

/** Resize the tileset. Crop/Expand if neccesary. */
int CTileLayer::resize(int width, int height)
{
  if(width < 0 || height < 0) return 1;
  cout << "Resizing tile layer to " << width << "x" << height << endl;
  Sint16 *newTiles = new Sint16[width*height];
  if(newTiles == NULL)
  {
    cout << "Not enough memory to complete operation" << endl;
    return 1;
  }
  for(int i=0;i<width*height;i++)
  {
    newTiles[i] = 0;
  }
  int w = (width < mWidth) ? width : mWidth, h = (height < mHeight) ? height : mHeight;
  for(int i=0;i<w;i++)
  {
    for(int j=0;j<h;j++)
    {
      newTiles[i+j*h] = mTileData[i+j*mHeight];
    }
  }
  delete [] mTileData;
  mTileData = newTiles;
  mWidth = width;
  mHeight = height;
  return 0;
}

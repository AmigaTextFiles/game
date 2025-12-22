/***************************************************************************
                          ctilelayer.h  -  description
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

#ifndef CTILELAYER_H
#define CTILELAYER_H

#include "csdl.h"
#include "ctileset.h"

using namespace std;

/**
  *@author Marius
  */
  
class CTileLayer
{
  public: 
  CTileLayer();
  ~CTileLayer();
  /** Load the tile layer into memory */
  int load(string map, CTileSet *tiles);
  /** Save the tile layer into a file */
  int save(string file);
  /** Get rid of the loaded data */
  int dispose();
  /** Render the tilelayer on the screen */
  int render(int offsetx, int offsety, int x, int y, int w, int h);
  /** Return the height of the tile layer */
  int getHeight();
  /** Return the width of the layer */
  int getWidth();
  /** Modify one tile in the tilemap */
  int setTile(Sint16 nr, int x, int y);
  /** Return the tile in the position x, y. Check the position for validity. Return 0 on error (empty tile). */
  Sint16 getTile(int x, int y);
  /** Return the tile. Don't check the coordinates for validity. */
  Sint16 getTileNoCheck(int x, int y);
  /** Resize the tileset. Crop/Expand if neccesary. */
  int resize(int width, int height);

  private:
  CTileSet *mTileSet;
  int mLoaded;
  int mWidth, mHeight;
  int mRepeatX, mRepeatY;
  Sint16 *mTileData;
};

#endif

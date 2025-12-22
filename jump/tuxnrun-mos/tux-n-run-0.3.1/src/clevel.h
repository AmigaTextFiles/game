/***************************************************************************
                          clevel.h  -  description
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

#ifndef CLEVEL_H
#define CLEVEL_H

#include <string>

#include "cweather.h"
#include "ctileset.h"
#include "ctilelayer.h"
#include "cspacepartition.h"
#include "csdl.h"
#include "cinput.h"
#include "ccreaturebase.h"
#include "ccreature.h"
#include "citembase.h"
#include "citem.h"
#include "keysyms.h"

using namespace std;

/**
  *@author Marius
  */

class CLevel
{
  public: 
  CLevel();
  ~CLevel();
  /** Unload the level */
  int dispose();
  /** Load a level */
  int load(string datadir, string levelpath, int numplayers);
  /** Initialize the class */
  int init(CSDL *sdl);
  /** Update action */
  void update(CInput &Input, int keys[][KEY_COUNT]);
  /** Render the level */
  void render(int x, int y, int w, int h, int player);
  /** Does the level have a title screen or not? */
  int hasTitle();
  /** Return the title surface */
  SDL_Surface * getTitle();
  /** Change the control over the creatures */
  void numPlayers(int num, int change);

  private:
  CWeather mWeather[4];
  CTileSet mTileSet;
  int mLoaded;
  int mNumLayers, mBaseLayer, mHasTitle;
  SDL_Surface *mTitle;
  CTileLayer *mTileLayers;
  float *mLayerRatioX, *mLayerRatioY;
  CSDL *mSDL;
  int mNumCreatureBases;
  CCreatureBase *mCreatureBases;
  int mPlayer[4];
  int mNumCreatures;
  CCreature *mCreatures;
	int mNumItemBases;
	CItemBase *mItemBases;
	int mNumItems;
	CItem *mItems;
	int mPlayerCount;
  float mScrollX[4], mScrollY[4];
};

#endif

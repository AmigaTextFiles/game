/***************************************************************************
                          clevel.cpp  -  description
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
#include <fstream>

#include <vector>
#include <map>

#include "clevel.h"

CLevel::CLevel() {mLoaded=0;}
CLevel::~CLevel() {}

/** Load a level */
int CLevel::load(string datadir, string levelpath, int numplayers)
{
  if(mLoaded && dispose()) return 1;

  ifstream file((datadir+"/"+levelpath+"/info").c_str());
  if(!file.is_open())
  {
    cout << "Error! Couldn't open level info: " << datadir << "/" << levelpath << "/info" << endl;
    return 1;
  }

  mNumLayers = 0;
  mBaseLayer = 0;
  mHasTitle = 0;
  mNumCreatureBases = 0;
	mNumItemBases = 0;

  string temp, temp2;
  string tileImage, tileData;
  vector<string> tiles;
  vector<string> creatureBases;
  vector<string> itemBases;
  map<string, int> creatureBaseIDs;
  map<string, int> itemBaseIDs;

  string wMode, wExtra;
  while(!file.eof())
  {
    file >> temp >> temp2;
    if(temp == "weather") { wMode = temp2; }
    if(temp == "weather_extra") { wExtra = temp2; }
    if(temp == "tileset_image") { tileImage = temp2; }
    if(temp == "tileset_data") { tileData = temp2; }
    if(temp == "layer") { mNumLayers++; tiles.push_back(temp2); }
    if(temp == "baselayer") { mBaseLayer = atoi(temp2.c_str())-1; }
    if(temp == "title") { mTitle = mSDL->loadImage(datadir+"/"+levelpath+"/"+temp2); mHasTitle=1; }
    if(temp == "creature_type") { mNumCreatureBases++; creatureBases.push_back(temp2);
                                                       creatureBaseIDs.insert(map<string, int>::value_type(temp2, mNumCreatureBases-1)); }
    if(temp == "item_type") { mNumItemBases++; itemBases.push_back(temp2);
                                                       itemBaseIDs.insert(map<string, int>::value_type(temp2, mNumItemBases-1)); }
  }

  file.close();

  mTileSet.init(mSDL);
  mTileSet.load(datadir+"/shared/tiles", tileImage, tileData);
  
  mTileLayers = new CTileLayer[mNumLayers];
  for(int i=0;i<mNumLayers;i++)
  {
    mTileLayers[i].load(datadir+"/"+levelpath+"/layers/"+tiles[i], &mTileSet);
  }
  mLayerRatioX = new float[mNumLayers];
  mLayerRatioY = new float[mNumLayers];
  for(int i=0;i<mNumLayers;i++)
  {
    mLayerRatioX[i] = ((float)mTileLayers[i].getWidth()) / ((float)mTileLayers[mBaseLayer].getWidth());
    mLayerRatioY[i] = ((float)mTileLayers[i].getHeight()) / ((float)mTileLayers[mBaseLayer].getHeight());
  }

  cout << "Number of different creatures in the level: " << mNumCreatureBases << endl;
  mCreatureBases = new CCreatureBase[mNumCreatureBases];
  for(int i=0;i<mNumCreatureBases;i++)
  {
    mCreatureBases[i].init(mSDL);
    mCreatureBases[i].load(datadir+"/shared/creatures/"+creatureBases[i]);
  }

  ifstream file2((datadir+"/"+levelpath+"/creatures").c_str());
  if(!file2.is_open())
  {
    cout << "Error! Couldn't open level creature data " << datadir << "/" << levelpath << "/creatures" << endl;
    return 1;
  }

  file2 >> mNumCreatures;

  cout << "Number of creatures in the level: " << mNumCreatures << endl;

  mCreatures = new CCreature[mNumCreatures];

	mPlayer[0] = -1;
	mPlayer[1] = -1;
	mPlayer[2] = -1;
	mPlayer[3] = -1;

  int x, y, i=0;
	mPlayerCount = 0;
  float speed;
  string direction, player;
  while(!file2.eof() && i<mNumCreatures)
  {
    file2 >> temp >> x >> y >> direction >> player >> speed;
    if(player == "player" && mPlayerCount<numplayers) { mPlayer[mPlayerCount] = i; mPlayerCount++; }
    mCreatures[i].init(mSDL, &mCreatureBases[creatureBaseIDs[temp]], x, y, direction == "right"?1:-1, mPlayerCount > 0 && mPlayer[mPlayerCount-1] == i,
      &mTileLayers[mBaseLayer], speed);
    i++;
  }
  file2.close();

	int a = 0;
	for(int i=mPlayerCount;i<4;i++)
	{
   	for(int j=0;j<mNumCreatures;j++)
		{
			a = 0;
     	for(int k=0;k<4;k++)
			{
        if(mPlayer[k] == j) a = 1;
			}
			if(a == 0)
			{
       	mPlayer[i] = j;
			}
		}
	}

  cout << "Number of different items in the level: " << mNumItemBases << endl;
  mItemBases = new CItemBase[mNumItemBases];
  for(int i=0;i<mNumItemBases;i++)
  {
    mItemBases[i].init(mSDL);
    mItemBases[i].load(itemBases[i], datadir+"/shared/items/"+itemBases[i]);
  }

  ifstream file3((datadir+"/"+levelpath+"/items").c_str());
  if(!file3.is_open())
  {
    cout << "Error! Couldn't open level item data " << datadir << "/" << levelpath << "/items" << endl;
    return 1;
  }

	file3 >> mNumItems;

  cout << "Number of items in the level: " << mNumItems << endl;

  mItems = new CItem[mNumItems];

  i=0;
	string grav, effect;
	int value=0;
	int respawn=-1;
  while(!file3.eof() && i<mNumItems)
  {
    file3 >> temp >> x >> y >> grav >> effect >> value >> respawn;
		mItems[i].init(mSDL, &mItemBases[itemBaseIDs[temp]], &mTileLayers[mBaseLayer], x, y, (grav=="on"|grav=="yes"?1:(grav=="off"|grav=="yes"?0:-1)), effect, value, respawn);
    i++;
  }
	file3.close();

	mWeather[0].init(mSDL, datadir+"/shared/weather");
  mWeather[0].changeMode(wMode, wExtra, mPlayerCount<1?1:mPlayerCount);

	mWeather[1].init(mSDL, datadir+"/shared/weather");
  mWeather[1].changeMode(wMode, wExtra, mPlayerCount<1?1:mPlayerCount);

	mWeather[2].init(mSDL, datadir+"/shared/weather");
  mWeather[2].changeMode(wMode, wExtra, mPlayerCount<1?1:mPlayerCount);

	mWeather[3].init(mSDL, datadir+"/shared/weather");
  mWeather[3].changeMode(wMode, wExtra, mPlayerCount<1?1:mPlayerCount);
	
  mLoaded = 1;
  return 0;
}

/** Unload the level */
int CLevel::dispose()
{
  if(mLoaded)
  {
    if(mHasTitle) { mSDL->disposeSurface(mTitle); }
    for(int i=0;i<mNumLayers;i++)
    {
      mTileLayers[i].dispose();
    }
    delete [] mTileLayers;
    delete [] mLayerRatioX;
    delete [] mLayerRatioY;
    mNumLayers = 0;
    mTileSet.dispose();
    mWeather[0].dispose();
    mWeather[1].dispose();
    mWeather[2].dispose();
    mWeather[3].dispose();
    for(int i=0;i<mNumCreatureBases;i++)
    {
      mCreatureBases[i].dispose();
    }
    delete [] mCreatureBases;
    for(int i=0;i<mNumCreatures;i++)
    {
      mCreatures[i].dispose();
    }
    delete [] mCreatures;
    mNumCreatures = 0;
    mNumCreatureBases = 0;

    for(int i=0;i<mNumItemBases;i++)
    {
      mItemBases[i].dispose();
    }
    delete [] mItemBases;
    for(int i=0;i<mNumItems;i++)
    {
      mItems[i].dispose();
    }
    delete [] mItems;
    mNumItems = 0;
    mNumItemBases = 0;
  }
  return 0;
}

/** Initialize the class */
int CLevel::init(CSDL *sdl)
{
  mLoaded = 0;
  mSDL = sdl;
  return 0;
}

/** Update action */
void CLevel::update(CInput &Input, int keys[][KEY_COUNT])
{
	for(int i=0;i<mPlayerCount;i++)
	{
	  if(!Input.isDown(keys[i][KEY_LEFT]) && !Input.isDown(keys[i][KEY_RIGHT])) { mCreatures[mPlayer[i]].stop(); }
	  else if(Input.isDown(keys[i][KEY_LEFT]) && Input.isDown(keys[i][KEY_RIGHT])) { mCreatures[mPlayer[i]].moveLeftRight(); }
	  else if(Input.isDown(keys[i][KEY_LEFT])) { mCreatures[mPlayer[i]].moveLeft(); }
	  else if(Input.isDown(keys[i][KEY_RIGHT])) { mCreatures[mPlayer[i]].moveRight(); }
	
	  if(Input.isDown(keys[i][KEY_JUMP])) { mCreatures[mPlayer[i]].jump(); }
	  if(!Input.isDown(keys[i][KEY_JUMP])) { mCreatures[mPlayer[i]].unjump(); }
	}

  for(int i=0;i<mNumCreatures;i++)
  {
    mCreatures[i].update(0.01, mItems, mNumItems, mCreatures, mNumCreatures, i);
  }

  for(int i=0;i<mNumItems;i++)
  {
    mItems[i].update(0.01);
  }

	mWeather[0].update(0.01);
	mWeather[1].update(0.01);
	mWeather[2].update(0.01);
	mWeather[3].update(0.01);
}

/** Render the level */
void CLevel::render(int x, int y, int w, int h, int player)
{
	if(mPlayer[player] == -1) player = 0;
	if(mCreatures[mPlayer[player]].isAlive())
	{
	  float px = mCreatures[mPlayer[player]].getX(), py = mCreatures[mPlayer[player]].getY();
		float mNewScrollX=mScrollX[player], mNewScrollY=mScrollY[player];
	  if(px-mScrollX[player] < 0.31*w) mNewScrollX = px-0.31*w;
	  if(px-mScrollX[player] > 0.56*w) mNewScrollX = px-0.56*w;
	  if(py-mScrollY[player] < 0.27*h) mNewScrollY = py-0.27*h;
	  if(py-mScrollY[player] > 0.50*h) mNewScrollY = py-0.50*h;
	
	  if(mNewScrollX < 0) mNewScrollX = 0;
	  if(mNewScrollY < 0) mNewScrollY = 0;
	  if(mNewScrollY > mTileLayers[mBaseLayer].getHeight()*16-h) mNewScrollY = mTileLayers[mBaseLayer].getHeight()*16-h;
	
		mWeather[player].move((int)(mNewScrollX - mScrollX[player]), (int)(mNewScrollY - mScrollY[player]));
	
		mScrollX[player] = mNewScrollX;
		mScrollY[player] = mNewScrollY;
	} else {
		mWeather[player].move(0, 0);
	}

  mSDL->clearScreen(0);
  for(int i=0;i<=mBaseLayer;i++)
  {
    mTileLayers[i].render((int)(mScrollX[player]*mLayerRatioX[i]), (int)(mScrollY[player]*mLayerRatioY[i]),x,y,w,h);
  }
  for(int i=0;i<mNumItems;i++)
  {
		if(mItems[i].isThere()) mItems[i].render(mScrollX[player]-x, mScrollY[player]-y);
  }
  for(int i=0;i<mNumCreatures;i++)
  {
		if(!mCreatures[i].isDead()) mCreatures[i].render((int)mScrollX[player]-x, (int)mScrollY[player]-y);
  }
  for(int i=mBaseLayer+1;i<mNumLayers;i++)
  {
    mTileLayers[i].render((int)(mScrollX[player]*mLayerRatioX[i]), (int)(mScrollY[player]*mLayerRatioY[i]),x,y,w,h);
  }
	mWeather[player].render();
}

/** Does the level have a title screen or not? */
int CLevel::hasTitle()
{
  return mHasTitle;
}

/** Return the title surface */
SDL_Surface * CLevel::getTitle()
{
  return mTitle;
}

/** Change the control over the creatures */
void CLevel::numPlayers(int num, int change)
{
	
}

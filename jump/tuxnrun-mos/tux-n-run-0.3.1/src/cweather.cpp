/***************************************************************************
                          cweather.cpp  -  description
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

#include <stdlib.h>

#include "cweather.h"

CWeather::CWeather() {}
CWeather::~CWeather() {}

/** Free memory */
void CWeather::dispose()
{
	mMode = NONE;
	mTileSet.dispose();
	delete [] mParticles;
}

/** Change the weather */
void CWeather::changeMode(string newMode, string extra, int pc)
{
	if(mLoaded) dispose();
	if(newMode == "snow")
	{
		mTileSet.load(mDataDir, "snow.bmp", "snow.dat");
		mMode = SNOW;
		mExtra = atoi(extra.c_str())/*/pc*/;
		mParticles = new weather_particle[mExtra];
		mLoaded = 1;

    for(int i=0;i<mExtra;i++)
		{
			mParticles[i].x=(float)(rand()%mSDL->getWidth());
	    mParticles[i].y=(float)(rand()%mSDL->getHeight());
	    mParticles[i].vx=((float)((rand()%2)?((float)(rand()%10+8)):(-(float)(rand()%10+8))))*3.33;
	    mParticles[i].vy=((float)(rand()%10+10))*6.66;
		}
	}
}

/** Initalize the class */
int CWeather::init(CSDL *sdl, string datadir)
{
  mSDL = sdl;
	mTileSet.init(mSDL);
	mDataDir = datadir;
	mMode = NONE;
	mLoaded = 0;
	return 0;
}

/** Render the weather FX */
int CWeather::render()
{
	mTileSet.drawTile(0,0,0);
  for(int i=0;i<mExtra;i++)
  {
		mTileSet.drawTile(0,(int)mParticles[i].x,(int)mParticles[i].y);
  }
	return 0;
}

/** Update the particle movement */
int CWeather::update(float dt)
{
	if(mMode == SNOW)
	{
 		for(int i=0;i<mExtra;i++)
 		{
    	mParticles[i].x+=mParticles[i].vx*dt;
    	mParticles[i].y+=mParticles[i].vy*dt;
  	}
	}
	return 0;
}

/** Move the particle's coordinates. */
void CWeather::move(int x, int y)
{
	if(mMode == SNOW)
	{
	  for(int i=0;i<mExtra;i++)
	  {
	    mParticles[i].x-=x;
	    mParticles[i].y-=y;
	   	if(mParticles[i].x<-2) mParticles[i].x+=640;
	 	 	if(mParticles[i].x>640) mParticles[i].x-=642;
	 		if(mParticles[i].y<-2) mParticles[i].y+=480;
	  	if(mParticles[i].y>480) mParticles[i].y-=482;
		}
	}
}

/***************************************************************************
                          cweather.h  -  description
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

#ifndef CWEATHER_H
#define CWEATHER_H

#include <string>

#include "csdl.h"
#include "ctileset.h"

using namespace std;

/**
  *@author Marius
  */

enum weather_mode {NONE, SNOW, RAIN, WEATHER_COUNT};
struct weather_particle
{
	float  x,  y;
	float vx, vy;
  int value;
	int alive;
};

class CWeather
{
  public: 
  CWeather();
  ~CWeather();
  /** Change the weather */
  void changeMode(string newMode, string extra, int pc);
  /** Free memory */
  void dispose();
  /** Initalize the class */
  int init(CSDL *sdl, string datadir);
  /** Update the particle movement */
  int update(float dt);
  /** Render the weather FX */
  int render();
  /** Move the particles' coordinates. */
  void move(int x, int y);

	private:
	CSDL *mSDL;
	string mDataDir;
	CTileSet mTileSet;
  weather_mode mMode;
	int mExtra;
	int mLoaded;
	weather_particle *mParticles;
};

#endif

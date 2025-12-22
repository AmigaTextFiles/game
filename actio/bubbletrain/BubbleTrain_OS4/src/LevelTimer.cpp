/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
 
#include "LevelTimer.h"

LevelTimer* LevelTimer::_instance = (LevelTimer*)NULL; /// initialize static instance pointer

LevelTimer* LevelTimer::Instance()
{
	if (_instance == NULL)
	{
		_instance = new LevelTimer();
	}
	return _instance;
}

LevelTimer::LevelTimer()
{
	LevelTimer::reset();
}
LevelTimer::~LevelTimer()
{

}

void LevelTimer::pause()
{
	this->paused = true;
}

void LevelTimer::increment()
{
	// If the timer has been paused then adjust the start / end times to cope
	// with the pause
	if (this->paused)
	{
		this->startTime += SDL_GetTicks() - this->endTime;
		this->paused = false;
			}
	this->endTime = SDL_GetTicks();
}
	
Uint32 LevelTimer::getTime()
{
	return (this->endTime - this->startTime) / 100;
}

void LevelTimer::reset()
{
	this->startTime = SDL_GetTicks();
	this->endTime = SDL_GetTicks();
}

void LevelTimer::adjust(long time)
{
	this->startTime -= time * 1000;
}

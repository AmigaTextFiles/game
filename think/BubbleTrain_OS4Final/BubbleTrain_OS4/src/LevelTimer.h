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
 
 /*
  * Timer to keep track of the time spent during the game / level. 
  * This allows the timer to be paused when the game is. So it is actual time
  * 
  * Produced using the singleton pattern so it can be called from more then one
  * place and have the same values
  */
 
#ifndef LEVELTIMER_H
#define LEVELTIMER_H

#include "General.h"

class LevelTimer
{

private:
	static LevelTimer* _instance;		// Singleton instance

	Uint32 startTime;					// The time started
	Uint32 endTime;						// The current end time in msec.
	bool paused;
	
public:
	static LevelTimer* Instance();

	LevelTimer();
	virtual ~LevelTimer();
	
	void pause();
	void increment();
	Uint32 getTime();
	void reset();
	void adjust(long time);
};

#endif // LEVELTIMER_H

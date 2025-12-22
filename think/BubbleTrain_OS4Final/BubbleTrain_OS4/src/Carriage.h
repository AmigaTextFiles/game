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
 * A carriage is a container for a bubble moving along the track.
 */
 
#ifndef CARRIAGE_H
#define CARRIAGE_H

#include "Bubble.h"

enum CarriageState 
{
  CS_ON_TRACK,				// This is running completely on the rails
  CS_NEAR_TRACK,			// This is part of the train but is still merging so not quite on the rails
  CS_IN_STATION				// Not part of the train yet
};

enum CarriageMoveState 
{
  CMS_CRASHED,			 	// Run off the end of the track
  CMS_ON_TRACK,			 	// Running ok
  CMS_RETURN_TO_STATION, 	// Run off the start of the track so return to the station
};

class Carriage {

public:
  
    Bubble* bubble;			// Containing bubble the carriage is currently carrying
    CarriageState state;	// State of the carriage i.e. in station or on track
  
  	Carriage(Colour colour);
  	Carriage(SFX sfx);
  	Carriage(Bubble* bubble);
  	~Carriage();
    
    bool checkCollision(Point pos);
    void animate();
    void draw(SDL_Surface* screenDest);
    void draw(SDL_Surface* screenDest, Point pos);
    
};

#endif

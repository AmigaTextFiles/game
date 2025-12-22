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
  * This is the bullet fired from the cannon. It encapsulates a bubble and simply
  * moves the bullet across the screen.
  *  
  */

#ifndef BULLET_H
#define BULLET_H

#include "General.h"
#include "Bubble.h"

class Bullet {

public:
	Bullet(Colour colour); 	// Create a bullet and a new bubble with the given colour
	Bullet(SFX sfx);		// Same as above but a special bubble.
	~Bullet();

    Velocity velocity; 		// Defines the velocity of the bullet
    Bubble* bubble;			// The encapsulating bubble
    
    bool onScreen(Rect range, bool allInRange);	// Determines if the bullet is still on screen
	
	void animate();
    void draw(SDL_Surface* screen);
	
};

#endif



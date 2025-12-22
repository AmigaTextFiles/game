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
 *  Exploding Bubble is a bubble which moves under gravity. It is used when 
 *  carriages explode because of groups or bombs
 */
 
#ifndef EXPLODINGBUBBLE_H
#define EXPLODINGBUBBLE_H

#include "IWidget.h"
#include "Bubble.h"
#include "General.h"

#define GRAVITY 2		// Gravity factor used to adjust the velocity of the bubbles
						// in pixels per frames					

class ExplodingBubble : public Bubble
{
private:
	
	bool brakesOn;		// Defines if the bubble must remain stationary	
	Velocity vel;		// Defines the current velocity for the bubble
	
	void initalise();

public:

	ExplodingBubble();
	ExplodingBubble(Colour colour);
	ExplodingBubble(SFX type);
	ExplodingBubble(Colour colour, Point position);
	virtual ~ExplodingBubble();

	// Properties for adjusting the velocity / brakes	
	Velocity getVelocity();
	void setVelocity(Velocity vel);
	bool getBrakesOn();
	void setBrakesOn(bool brakes);

	void animate();

};

#endif // EXPLODINGBUBBLE_H

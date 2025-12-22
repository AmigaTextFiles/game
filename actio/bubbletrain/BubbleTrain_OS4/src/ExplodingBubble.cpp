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

#include "ExplodingBubble.h"

ExplodingBubble::ExplodingBubble() : Bubble(COL_RED)
{
	this->brakesOn = false;
	ExplodingBubble::initalise();
}

ExplodingBubble::ExplodingBubble(Colour colour) : Bubble(colour)
{
	this->brakesOn = false;
	ExplodingBubble::initalise();
}

ExplodingBubble::ExplodingBubble(SFX type) : Bubble(type)
{
	this->brakesOn = false;
	ExplodingBubble::initalise();
}

ExplodingBubble::ExplodingBubble(Colour colour, Point position) : Bubble(colour, position)
{
	this->brakesOn = false;
	ExplodingBubble::initalise();
}

ExplodingBubble::~ExplodingBubble()
{

}

Velocity ExplodingBubble::getVelocity()
{
	return this->vel;
}

void ExplodingBubble::setVelocity(Velocity vel)
{
	this->vel = vel;
}

bool ExplodingBubble::getBrakesOn()
{
	return this->brakesOn;
}

void ExplodingBubble::setBrakesOn(bool brakes)
{
	this->brakesOn = brakes;
}

void ExplodingBubble::animate()
{
	// Update the position of the bubble based on it's velocity.
	// Also accelerate the bubble due to gravity	
	if (!this->brakesOn)
	{
		Bubble::position.x += this->vel.getXComp();
		Bubble::position.y += this->vel.getYComp();
			
		// update the velocity y component due to gravity
		this->vel.setYComp(this->vel.getYComp() + GRAVITY);
	}
	
	Bubble::animate();
}

void ExplodingBubble::initalise()
{
	this->vel.setSpeed(10 + (rand() % 10));
	this->vel.setAngle(radians(rand() % 360));	
}

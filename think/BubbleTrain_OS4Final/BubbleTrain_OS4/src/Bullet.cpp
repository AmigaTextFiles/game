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
 
#include "Bullet.h"

Bullet::Bullet(Colour colour)
{
	this->bubble = new Bubble(colour);
	this->velocity.setSpeed(0);
	this->velocity.setAngle(0);
}

Bullet::Bullet(SFX sfx)
{
	this->bubble = new Bubble(sfx);
	this->velocity.setSpeed(0);
	this->velocity.setAngle(0);
}

Bullet::~Bullet()
{
	if (this->bubble)
		delete this->bubble;
}

void Bullet::animate()
{
	Point newPoint;
	
	// Update the position of the bullet based on the velocity
	newPoint = this->bubble->getPosition();
	
	newPoint.x += this->velocity.getXComp();
	newPoint.y -= this->velocity.getYComp();
	
	this->bubble->setPosition(newPoint);
	
	this->bubble->animate();
	
}

bool Bullet::onScreen(Rect range, bool allInRange=0)
{
	// Check all in range means that if 1 then all of the buble must be within the range.
	// Otherwise it means is any of the bubble in the range

	Point currentPoint = this->bubble->getPosition();
	
	// Check that all of the bubble is in range
	// Check the left edge of bubble against left edge of range etc
	if (allInRange && 
		(currentPoint.x - BUBBLE_RAD < range.topLeft.x ||  
		currentPoint.x + BUBBLE_RAD > range.bottomRight.x || 
		currentPoint.y - BUBBLE_RAD < range.topLeft.y || 
		currentPoint.y + BUBBLE_RAD > range.bottomRight.y))
		return false;
	
	// Check that any part of the bubble is in range
	// Check opposite edges i.e. right edge of bubble again left edge of range etc.
	if (!allInRange && 
		(currentPoint.x + BUBBLE_RAD < range.topLeft.x ||  
		currentPoint.x - BUBBLE_RAD > range.bottomRight.x || 
		currentPoint.y + BUBBLE_RAD < range.topLeft.y || 
		currentPoint.y - BUBBLE_RAD > range.bottomRight.y))
		return false;

	return true;
}

void Bullet::draw(SDL_Surface* screen)
{
	if (this->bubble != NULL)
		this->bubble->draw(screen);
}

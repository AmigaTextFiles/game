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
 
#include "Carriage.h"

Carriage::Carriage(Colour colour)
{
	this->bubble = new Bubble(colour);
	this->state = CS_IN_STATION;
}

Carriage::Carriage(SFX sfx)
{
	this->bubble = new Bubble(sfx);
	this->state = CS_IN_STATION;
}

Carriage::Carriage(Bubble* bubble)
{
	this->bubble = new Bubble(*bubble);
	this->bubble->startTimer();
	this->state = CS_IN_STATION;
}

Carriage::~Carriage()
{
	if (this->bubble)
		delete this->bubble;
}

bool Carriage::checkCollision(Point pos)
{
	return (fabs(this->bubble->getPosition().distanceFrom(pos)) <= BUBBLE_SIZE);
}
    
void Carriage::animate()
{
	this->bubble->animate();
}

void Carriage::draw(SDL_Surface* screenDest)
{
	if (this->bubble != NULL)
		this->bubble->draw(screenDest);
}

void Carriage::draw(SDL_Surface* screenDest, Point pos)
{
	if (this->bubble != NULL)
		this->bubble->draw(screenDest, pos);
}

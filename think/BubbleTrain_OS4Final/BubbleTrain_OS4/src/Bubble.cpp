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
 
#include "Bubble.h"

#undef LOG_THRESHOLD
#define LOG_THRESHOLD SV_WARNING

Bubble::Bubble(Colour colour)
{
	Bubble::initialise();
	this->colour = colour;
}

Bubble::Bubble(SFX type)
{

	Bubble::initialise();
	this->effectType = type;
	
	// Handle special bubbles
	if (type == SFX_RAINBOW)
	{
		this->maxColours = MAX_COLOUR;  // Set the number of colours
	}
	else if (type == SFX_SPEED)
	{
		// Make sure we have a range of -1.5 -> 1.5
		this->speedMultiplier = random(3) - 1.5; 
		// Make the effect life inversely proportional to the speed
		this->effectLife = (int)(5 / fabs(this->speedMultiplier));
		
		// Make sure the speed life doesn't exced 10 seconds
		if (this->effectLife > 10)
			this->effectLife = 10;
			
		this->endTime = SDL_GetTicks() + (this->effectLife * 1000);
	}
}


Bubble::Bubble(Colour colour, Point position)
{
	Bubble::initialise();
	this->colour = colour;
	this->position = position;
}

Bubble::~Bubble()
{
	
}
  
Colour Bubble::getColour()
{
	return this->colour;	
}

Point Bubble::getPosition()
{
	return this->position;	
}

double Bubble::getSpeedMultiplier()
{
	return this->speedMultiplier;
}

SFX Bubble::getType()
{
	return this->effectType;
}

void Bubble::setType(SFX type)
{
	this->effectType = type;	
}

void Bubble::setPosition(Point position)
{
	this->position = position;	
}

void Bubble::setMaxColour(int maxCol)
{
	this->maxColours = maxCol;
}

void Bubble::resetToNormal()
{
	this->effectType = SFX_NORMAL;
	this->speedMultiplier = 1;
}

void Bubble::startTimer()
{
	this->timerEnabled = true;
	
	// reset the endtime for the timer
	this->endTime = SDL_GetTicks() + (this->effectLife * 1000);
}

void Bubble::animate()
{
	switch(this->effectType)
	{
		case SFX_RAINBOW:
		{
			// Rainbow bubbles should change colour every 15 frames
			if (effectLife-- <= 0)
			{
				this->colour = (Colour)random(this->maxColours);
				effectLife = 15;
			}
			break;
		}
		case SFX_SPEED:
		{
			// Speed bubbles only last for a certain time. So when the timer is enabled then
			// count down, when it reaches zero then reset it back to a normal bubble but with 
			// a random colour.

			// Don't adjust the timer unless enabled
			if (!this->timerEnabled)
				break;
				
			this->effectLife = (this->endTime - SDL_GetTicks()) / 1000;
			// When the timer is up then reset the bubble to a normal one
			if (this->effectLife <= 0)
			{
				Bubble::resetToNormal();
				this->colour = (Colour)random(this->maxColours);
			}
			
		}
		default:
			break;	
	}
}

void Bubble::draw(SDL_Surface* screen)
{
	Bubble::draw(screen, this->position);
}

void Bubble::draw(SDL_Surface* screen, Point pos)
{
	// Map the bubble colour to a graphic
	GfxRes bulletColour;
	switch (this->colour)
	{
		case COL_RED:
			bulletColour = GFX_BUBBLE_RED;
			break;
		case COL_YELLOW:
			bulletColour = GFX_BUBBLE_YELLOW;
			break;
		case COL_BLUE:
			bulletColour = GFX_BUBBLE_BLUE;
			break;
		case COL_GREEN:
			bulletColour = GFX_BUBBLE_GREEN;
			break;
		case COL_ORANGE:	
			bulletColour = GFX_BUBBLE_ORANGE;
			break;
		default:
			bulletColour = GFX_BUBBLE_RED;
	}
	
	// If a special bubble then re-map the graphic
	if (this->effectType != SFX_NORMAL)
	{
		switch (this->effectType)
		{
			case SFX_NORMAL:
			case SFX_RAINBOW:
				break;
			case SFX_SPEED:
				bulletColour = GFX_BUBBLE_SPEED;
				break;
			case SFX_BOMB:
				bulletColour = GFX_BUBBLE_BOMB;
				break;
			case SFX_COLOUR_BOMB:
				bulletColour = GFX_BUBBLE_COLOURBOMB;
				break;
		}	
	}

	// Draw the bubble to the screen	
	Theme::Instance()->drawOffsetSurface(bulletColour, pos, 0, 50,50);
	
}

bool Bubble::onScreen(Rect range, bool allInRange=0)
{
	// Check if the bubble is within the bounding rectangle
	// Check all in range means that if 1 then all of the buble must be within the range.
	// Otherwise it means is any of the bubble in the range

	Point currentPoint = this->getPosition();
	
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


void Bubble::initialise()
{
	this->colour = COL_RED;
	this->position = Point(0,0);
	this->speedMultiplier = 1;
	this->effectType = SFX_NORMAL;
	this->effectLife = 0;
	this->maxColours = 0;
	this->endTime = 0;
	this->timerEnabled = false;
}

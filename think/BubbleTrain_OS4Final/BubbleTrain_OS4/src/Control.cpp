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

#include "Control.h"

Control::Control() : IWidget()
{
	Control::initialise();
}

Control::Control(int x, int y) : IWidget(x,y)
{
	Control::initialise();
}

Control::Control(Point pos) : IWidget(pos)
{
	Control::initialise();
}
	
Control::~Control()   
{

}

void Control::setActiveColour(Uint32 colour)
{
	this->activeColour = colour;
	Control::updateBorderType();
}

Uint32 Control::getActiveColour()
{
	return this->activeColour;
}

void Control::setInActiveColour(Uint32 colour)
{
	this->inActiveColour = colour;
}

Uint32 Control::getInActiveColour()
{
	return this->inActiveColour;
}


void Control::setBorderColour(Uint32 col)
{
	this->borderColBottomRight = col;
	this->borderColTopLeft = col;
	Control::updateBorderType();
}

void Control::setBevelType(BevelType bevType)
{
	this->borderType = bevType;
	Control::updateBorderType();
}

void Control::addChangeEvent(Callback0Base& changeEvent)
{
	this->changeEvent = changeEvent.clone();
}

void Control::addClickEvent(Callback0Base& clickEvent)
{
	this->clickEvent = clickEvent.clone();	
}

void Control::addDoubleClickEvent(Callback0Base& doubleClickEvent)
{
	this->doubleClickEvent = doubleClickEvent.clone();
}

void Control::fireChangeEvent()
{
	if (this->changeEvent)
		(*this->changeEvent)();
}

void Control::fireClickEvent()
{
	if (this->clickEvent)
		(*this->clickEvent)();
}

void Control::fireDoubleClickEvent()
{
	if (this->doubleClickEvent)
		(*this->doubleClickEvent)();
}

void Control::initialise()
{
	// Background colours
	this->activeColour = 0;
	this->inActiveColour = 0;
	
	this->borderType = BEV_OUTER;
	Control::updateBorderType();
	
	// Border colours
	this->borderColTopLeft = 0;
	this->borderColBottomRight = 0;
	
	// Events
	this->changeEvent = NULL;
	this->clickEvent = NULL;
	this->doubleClickEvent = NULL;

}

void Control::updateBorderType()
{
	switch (this->borderType)
	{
		case BEV_NONE:
			break;
		case BEV_NORMAL:
			break;
		case BEV_INNER:
		case BEV_OUTER:
		{
			Uint8 r = 0, g = 0, b = 0;
			Uint8 adjustFactor = 0x30;
			SDL_GetRGB(this->activeColour, SDL_GetVideoSurface()->format, &r, &g, &b);
			Uint8 rl = (r + adjustFactor > 255) ? 255 : r + adjustFactor;
			Uint8 gl = (g + adjustFactor > 255) ? 255 : g + adjustFactor;
			Uint8 bl = (b + adjustFactor > 255) ? 255 : b + adjustFactor;
			
			Uint8 rd = (r - adjustFactor < 0) ? 0 : r - adjustFactor;
			Uint8 gd = (g - adjustFactor < 0) ? 0 : g - adjustFactor;
			Uint8 bd = (b - adjustFactor < 0) ? 0 : b - adjustFactor;
			
			if (this->borderType == BEV_INNER)
			{
				this->borderColTopLeft = SDL_MapRGB(SDL_GetVideoSurface()->format, rd, gd, bd);
				this->borderColBottomRight = SDL_MapRGB(SDL_GetVideoSurface()->format, rl, gl, bl);
			}
			else
			{
				this->borderColBottomRight = SDL_MapRGB(SDL_GetVideoSurface()->format, rd, gd, bd);
			 	this->borderColTopLeft = SDL_MapRGB(SDL_GetVideoSurface()->format, rl, gl, bl);
			}
		}
	}
	
	
}

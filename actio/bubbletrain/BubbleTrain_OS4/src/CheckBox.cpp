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
 
#include "CheckBox.h"

CheckBox::CheckBox(Point pos) : Control(pos)
{
	this->checked = false;
	this->changeEvent = NULL;
}

CheckBox::~CheckBox()
{
	
}
	
bool CheckBox::getChecked()
{
	return this->checked;
}

void CheckBox::setChecked(bool state)
{
	this->checked = state;
}

void CheckBox::draw(SDL_Surface* screenDest)
{
	SDL_Rect screenRect;
	screenRect.x = (short int)this->point.x;
	screenRect.y = (short int)this->point.y;
	screenRect.w = CHECKBOX_SIZE;
	screenRect.h = CHECKBOX_SIZE;
	
	// Draw the background text box
	Uint32 colour;
	if (this->active)
		colour = this->activeColour;
	else
		colour = this->inActiveColour;
	SDL_FillRect (screenDest, &screenRect, colour);
	
	// Draw a border around the textbox
	// Top and left in a dark colour
	// Bottom and right in a light colour
	Point bottomRight (this->point.x + CHECKBOX_SIZE, this->point.y + CHECKBOX_SIZE);
	// top
	Theme::Instance()->drawLine(screenDest, this->borderColTopLeft, this->point , Point(this->point.x + CHECKBOX_SIZE, this->point.y));
	// bottom
	Theme::Instance()->drawLine(screenDest, this->borderColBottomRight, Point(this->point.x, this->point.y + CHECKBOX_SIZE), bottomRight);
	// left
	Theme::Instance()->drawLine(screenDest, this->borderColTopLeft, this->point , Point(this->point.x, this->point.y + CHECKBOX_SIZE));
	// right
	Theme::Instance()->drawLine(screenDest, this->borderColBottomRight, Point(this->point.x + CHECKBOX_SIZE, this->point.y), bottomRight);
	
	if (this->checked)
	{
		bottomRight.x -= 1;
		bottomRight.y -= 1;
		Uint32 crossCol = SDL_MapRGB(screenDest->format, 0xff, 0xff, 0xff);
		// Draw out the text with a 2 pixel border
		Theme::Instance()->drawLine(screenDest, crossCol, Point(this->point.x + 1, this->point.y + 1), bottomRight);
		Theme::Instance()->drawLine(screenDest, crossCol, Point(this->point.x + CHECKBOX_SIZE - 1, this->point.y + 1), Point(this->point.x + 1, this->point.y + CHECKBOX_SIZE - 1));		
	}
	
}

bool CheckBox::mouseDown(int x, int y)
{
	// Check if in my area
	if (x < this->point.x || this->point.x + CHECKBOX_SIZE < x
	|| y < this->point.y || this->point.y + CHECKBOX_SIZE < y)
	{
		this->active = false;
		return false;
	}
	
	this->checked = !this->checked;
	this->fireClickEvent();
	this->fireChangeEvent();
	this->active = true;
	
	return true;
}

bool CheckBox::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	if (!active)
		return false;
	
	if (key == SDLK_SPACE)
	{
		this->checked = !this->checked;
		this->fireChangeEvent();
		return true;
	}
		
	return false;
}

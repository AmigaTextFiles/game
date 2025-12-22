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

#include "Slider.h"

Slider::Slider(Rect rect) : Control (rect.topLeft)
{
	this->minValue = 0;
	this->maxValue = 100;
	this->stepValue = 10;
	this->currentValue = 0;
	this->displayValue = false;
	this->width = (int)rect.width();
	this->height = (int)rect.height();
}
Slider::~Slider()
{

}
	
int Slider::getMaxValue()
{
	return this->maxValue;
}

void Slider::setMaxValue(int value)
{
	if (this->minValue >= value)
		return;
		
	this->maxValue = value;
	if (this->currentValue > value)
		this->currentValue = value;
}

int Slider::getMinValue()
{
	return this->minValue;
}

void Slider::setMinValue(int value)
{
	if (this->maxValue <= value)
		return;
		
	this->minValue = value;
	if (this->currentValue < value)
		this->currentValue = value;
}

int Slider::getValue()
{
	return this->currentValue;
}

void Slider::setValue(int value)
{
	if (this->minValue <= value && this->maxValue >= value)
		this->currentValue = value;
}

int Slider::getStepValue()
{
	return this->stepValue;	
}

void Slider::setStepValue(int value)
{
	this->stepValue = value;
}


void Slider::draw(SDL_Surface* screenDest)
{
	// Draw a line with a disc on top
	Theme::Instance()->drawLine(screenDest, this->activeColour, Point(this->point.x, this->point.y + this->height / 2) , Point(this->point.x + this->width, this->point.y + this->height / 2));
	
	// Draw a disc on the line which is proportional to the value
	Point centre(this->point.x, this->point.y + this->height/2);
	
	// figure out where to draw the current value
	if (this->currentValue > 0)
		centre.x += this->width * this->currentValue / (this->maxValue - this->minValue);
	
	// Draw the current value
	Theme::Instance()->drawDisc(screenDest, this->activeColour, centre, this->height/2);
	Theme::Instance()->drawCircle(screenDest, this->activeColour, centre, this->height/2);
}

bool Slider::mouseDown(int x, int y)
{
	// Check if in my area
	if (x < this->point.x || this->point.x + this->width < x
	|| y < this->point.y || this->point.y + this->height < y)
	{
		this->active = false;
		return false;
	}
	
	// Figure out if we clicked to the right or left of the slider and move it accordingly
	int xPos = 0;
	if (this->currentValue > 0)
		xPos = (int)(this->point.x + this->width * this->currentValue / (this->maxValue - this->minValue));
	
	// Increment the current value but also make sure it doesn't go out of bounds
	if (x > xPos)
	{
		this->currentValue += this->stepValue;
		if (this->currentValue > this->maxValue)
			this->currentValue = this->maxValue;	
	}
	else
	{
		this->currentValue -= this->stepValue;
		if (this->currentValue < this->minValue)
			this->currentValue = this->minValue;
	}

	this->active = true;
	this->fireClickEvent();
	this->fireChangeEvent();
	return true;
}

bool Slider::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	// Only move the current selection if active
	if (!active)
		return false;
		
	switch (key)
	{
		case SDLK_UP:
		case SDLK_RIGHT:
			this->currentValue += this->stepValue;
			if (this->currentValue > this->maxValue)
				this->currentValue = this->maxValue;
			this->fireChangeEvent();
			return true;
		case SDLK_DOWN:
		case SDLK_LEFT:
			this->currentValue -= this->stepValue;
			if (this->currentValue < this->minValue)
				this->currentValue = this->minValue;
			this->fireChangeEvent();
			return true;
		default:
			break;
	}
	return false;
}

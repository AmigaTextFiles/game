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
 
#include "Button.h"

Button::Button(Callback0Base& clickEvent, const char* name, Rect rect) : Control((int)rect.topLeft.x, (int)rect.topLeft.y)
{
	this->clickEvent = clickEvent.clone();
	this->name = strdup(name);
	this->width = (int)rect.width();
	this->height = (int)rect.height();
	this->backgroundImage = NULL;
	this->activeBackgroundImage = NULL;
	this->accessKey = SDLK_UNKNOWN;
	this->font = FONT_BUTTON;
}

Button::~Button()
{
	if (this->backgroundImage != NULL)
		SDL_FreeSurface(this->backgroundImage);
		
	if (this->activeBackgroundImage != NULL)
		SDL_FreeSurface(this->activeBackgroundImage);
	
	delete name;
	
}

int Button::getWidth()
{
	return this->width;
}

void Button::setWidth(int width)
{
	this->width = width;
}

int Button::getHeight()
{
	return this->height;
}

void Button::setHeight(int height)
{
	this->height = height;
}

void Button::loadBackgroundImage(const char* image)
{
	// Clean up the image if already loaded
	if (this->backgroundImage != NULL)
		SDL_FreeSurface(this->backgroundImage);
	
	// Load the onto the button.
	this->backgroundImage = IMG_Load(image);

	if (!this->backgroundImage)
		Log::Instance()->die(1, SV_ERROR, "Trouble loading image %s", image);
}

void Button::loadActiveBackgroundImage(const char* image)
{
	// Clean up the image if already loaded
	if (this->activeBackgroundImage != NULL)
		SDL_FreeSurface(this->activeBackgroundImage);
	
	// Load the onto the button.
	this->activeBackgroundImage = IMG_Load(image);

	if (!this->activeBackgroundImage)
		Log::Instance()->die(1, SV_ERROR, "Trouble loading image %s", image);
}

void Button::setAccessKey(SDLKey key)
{
	this->accessKey = key;
}

void Button::setFont(FontRes font)
{
	this->font = font;
}

void Button::draw(SDL_Surface* screenDest)
{
	SDL_Rect screenRect;
	screenRect.x = (short int)this->point.x;
	screenRect.y = (short int)this->point.y;
	screenRect.w = this->width;
	screenRect.h = this->height;

	// Draw the background
	if (this->active && this->activeBackgroundImage)
		SDL_BlitSurface(this->activeBackgroundImage, NULL, screenDest, &screenRect);	
	else if (this->backgroundImage)
		SDL_BlitSurface(this->backgroundImage, NULL, screenDest, &screenRect);	
	else
	{
		// Draw a solid background colour with a beveled edge
		SDL_FillRect (screenDest, &screenRect, this->activeColour);
		for (int i = 0; i < 1; i++)
		{
			// Draw the top & left
			Theme::Instance()->drawLine(screenDest, this->borderColTopLeft, (int)this->point.x + i, (int)this->point.y + i, (int)this->point.x + i , (int)this->point.y + this->height - 1 - i);
			Theme::Instance()->drawLine(screenDest, this->borderColTopLeft, (int)this->point.x + 1 + i, (int)this->point.y + i, (int)this->point.x + this->width- 1 - 2 * i, (int)this->point.y + i);
			// Draw the bottom & right
			Theme::Instance()->drawLine(screenDest, this->borderColBottomRight, (int)this->point.x + i, (int)this->point.y + this->height - 1 - i, (int)this->point.x + this->width - 1 - 2 * i, (int)this->point.y + this->height - 1 - i);
			Theme::Instance()->drawLine(screenDest, this->borderColBottomRight, (int)this->point.x + this->width - 1 - i, (int)this->point.y + 1 + i, (int)this->point.x + this->width - 1 - i, (int)this->point.y + this->height - 1 - 2 * i);
		}	
	}
	
	// Draw out the text
	Rect size(screenRect.x, screenRect.y, screenRect.x + screenRect.w, screenRect.y + screenRect.h);
	Theme::Instance()->drawText(screenDest, this->font, size, Middle, Centred, name);
}

bool Button::mouseDown(int x, int y)
{
	
	// Check if in my area
	if (x < this->point.x || this->point.x + this->width < x)
		return false;
	if (y < this->point.y || this->point.y + this->height < y)
		return false;
	
	// Fire a click event if one exists
	if (this->clickEvent)
	{
		Theme::Instance()->playSound(SND_CLICK);
		this->fireClickEvent();
	}
	
	return true;
}

bool Button::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	// Fire a key event if the key matches our access key
	if (this->accessKey == ANY_KEY || this->accessKey == key)
	{
		if (this->clickEvent)
		{
			Theme::Instance()->playSound(SND_CLICK);
			this->fireClickEvent();	
		}
		return true;
	}
	return false;
}

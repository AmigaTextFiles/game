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
 * The widget is defined as the basic screen entity. I.e. contrains drawing, animate,
 * control interfaces.
 * 
 */
 
#ifndef IWidget_H
#define IWidget_H

#include "General.h"

class IWidget
{

protected:

	Point point;
	Uint8* keyStates;
	bool active;
	bool visible;
	
public:

	IWidget()
	{
		this->keyStates = SDL_GetKeyState(NULL);
		this->point.x = 0;
		this->point.y = 0;
		this->active = false;
		this->visible = true;	
	}
	
	IWidget(Point point)
	{
		this->keyStates = NULL;
		this->point = point;
		this->active = false;
		this->visible = true;
	}

	IWidget(int x, int y)
	{
		this->keyStates = NULL;
		this->point.x = (float)x;
		this->point.y = (float)y;
		this->active = false;
		this->visible = true;
	}
	
	// Make sure we can clean up all child classes
	virtual ~IWidget()
	{
	
	}
	
	inline void move(Point point)
	{
		this->point = point;	
	}
	
	// Accessors for the active / visibility
	virtual bool getActive(){return this->active;};
	virtual void setActive(bool act){this->active = act;};
	virtual bool getVisible(){return this->visible;};
	virtual void setVisible(bool vis){this->visible = vis;};
	
	virtual void animate(){};							// Move the contents for the next frame
	virtual bool pollKeyStates(){return false;};		// Process the key states
	virtual void draw(SDL_Surface* screenDest){};		// Draw the item to the given screen
	virtual bool mouseDown(int x, int y){return false;};// The mouse has been pressed let the class handle it
	virtual bool keyPress(SDLKey key, SDLMod mod, Uint16 character){return false;}; // A key has been pressed let the class handle it
	
};

#endif

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
  * A simple button to be placed on a window. It has a call back to fire when clicked
  * or the access key is pressed.
  * 
  */
 
#ifndef BUTTON_H
#define BUTTON_H

#include "IWidget.h"
#include "Control.h"
#include "Theme.h"
#include "CallBack.h"

// Defines an access key which maps to any key that has been pressed.
const SDLKey ANY_KEY = SDLK_WORLD_0;

class Button : public Control
{
	
private:

	SDL_Surface* backgroundImage;			// Background image
	SDL_Surface* activeBackgroundImage;		// Alternative background image for when button is active
	SDLKey accessKey;						// A short cut key which triggers the button / event
	FontRes font;							// Define the font to use for the text of the button
	
	char* name;								// Text to appear on the button
	int width;								// Dimensions of the button
	int height;
	
public:
	// The button must have an event to call when clicked, along with the name
	Button(Callback0Base& clickEvent, const char* name, Rect rect);
	virtual ~Button();

	// Basic Properties
	int getWidth();
	void setWidth(int width);	
	int getHeight();
	void setHeight(int height);
	void loadBackgroundImage(const char* image);		// load the default background image
	void loadActiveBackgroundImage(const char* image);	// load an image to be displayed when this is active
	void setAccessKey(SDLKey key);						// Set the shortcut key required to trigger this button
	void setFont(FontRes font);							// Define the font used for the text on the button
	
	// IWidget Methods
	virtual void draw(SDL_Surface* screenDest);
	virtual bool mouseDown(int x, int y);
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character );
};

#endif // BUTTON_H

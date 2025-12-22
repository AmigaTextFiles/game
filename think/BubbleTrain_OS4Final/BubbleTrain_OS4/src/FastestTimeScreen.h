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
  * Window / screen for displaying the fastest times to the user.
  * 
  * Simply call the draw method on the fastest times class and close
  * the window when ever a key or mouse button is pressed.
  */
  
#ifndef FASTESTTIMESCREEN_H
#define FASTESTTIMESCREEN_H

#include "MainMenu.h"
#include "FastestTime.h"
#include "Window.h"
#include "WindowManager.h"

class FastestTimeScreen : public Window
{
private: 
	
	void loadMenu();			// Load the main menu to quit the highscore screen

public:

	FastestTimeScreen(SDL_Surface* screen);
	virtual ~FastestTimeScreen();
	
	// IWidget methods
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character);
	virtual bool mouseDown(int x, int y);
};

#endif // FASTESTTIMESCREEN_H

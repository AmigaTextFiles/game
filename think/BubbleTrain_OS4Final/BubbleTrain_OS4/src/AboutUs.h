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
 * 
 * Display the about box as a window using a graphic for the background on a button
 * which covers the whole of the window
 * 
 */
 
#ifndef ABOUTUS_H
#define ABOUTUS_H

// System includes
#include <SDL.h>

// Game inlcudes
#include "MainMenu.h"
#include "Window.h"
#include "WindowManager.h"

class AboutUs : public Window
{
private: 
	
	// Load the mainmenu
	void loadMenu();

public:

	AboutUs(SDL_Surface* screen);
	virtual ~AboutUs();
	
	// Pick up key presses so we can quit if anything is click
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character);
	virtual bool mouseDown(int x, int y);
};

#endif // ABOUTUS_H

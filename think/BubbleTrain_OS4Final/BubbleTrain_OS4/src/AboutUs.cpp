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
 
#include "AboutUs.h"

AboutUs::AboutUs(SDL_Surface* screen) : Window(screen)
{
	// Setup the window to be the same size as the image
	int aWidth = 535;
	int aHeight = 265;
	Rect rAboutUs; 
	rAboutUs.topLeft.x = (screen->w - aWidth) / 2;
	rAboutUs.topLeft.y = (screen->h - aHeight) / 2;
	rAboutUs.bottomRight.x = rAboutUs.topLeft.x + aWidth;
	rAboutUs.bottomRight.y = rAboutUs.topLeft.y + aHeight;
	Window::setSize(rAboutUs);
	Window::loadBackgroundImage("../gfx/aboutus.png");
}

AboutUs::~AboutUs()
{
	// Nothing to do because it is tidied up by the window class
}

void AboutUs::loadMenu()
{
	// This window will be displayed over other windows so
	// just remove it from the screen.
	WindowManager::Instance()->remove(this);
}

bool AboutUs::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	// If any key is pressed then remove the about box
	AboutUs::loadMenu();
	return true;
}

bool AboutUs::mouseDown(int x, int y)
{
	// Remove the about box if the mouse is clicked anywhere on the screen.
	AboutUs::loadMenu();
	return true;
}

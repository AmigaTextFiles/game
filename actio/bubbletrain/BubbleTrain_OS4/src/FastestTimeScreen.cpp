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
 
#include "FastestTimeScreen.h"

FastestTimeScreen::FastestTimeScreen(SDL_Surface* screen) : Window(screen)
{
 	Rect rFastestTimeScreen(100, 100, screen->w - 100, screen->h - 100);
    
    Window::setSize(rFastestTimeScreen);
    Window::loadBackgroundImage("../gfx/FastestTime.png");

    // Append the FastestTime to draw it stuff onto the menu
    Window::addControl(FastestTime::Instance());
}

FastestTimeScreen::~FastestTimeScreen()
{

}

void FastestTimeScreen::loadMenu()
{
	// Update the windows manager
	WindowManager::Instance()->clear();
	WindowManager::Instance()->push(new MainMenu(Window::rootScreen));
}

bool FastestTimeScreen::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	FastestTimeScreen::loadMenu();	
	return true;
}

bool FastestTimeScreen::mouseDown(int x, int y)
{
	FastestTimeScreen::loadMenu();	
	return true;	
}

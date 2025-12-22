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
 
#include "SplashScreen.h"

SplashScreen::SplashScreen(SDL_Surface* screen) : Window(screen)
{
	Rect rSplash(0, 0, screen->w, screen->h);
    
    Window::setSize(rSplash);
    Window::loadBackgroundImage("../gfx/intro.png");

	Callback0<SplashScreen> loadmenuCallback(*this, &SplashScreen::loadMenu);

    Window::setTimedAction(loadmenuCallback, 2000, false);
}

SplashScreen::~SplashScreen()
{

}

void SplashScreen::loadMenu()
{
	// Update the windows manager
	WindowManager::Instance()->clear();
	WindowManager::Instance()->push(new MainMenu(Window::rootScreen));
}

bool SplashScreen::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	// If any key is pressed then remove the about box
	SplashScreen::loadMenu();	
	return true;
}

bool SplashScreen::mouseDown(int x, int y)
{
	SplashScreen::loadMenu();	
	return true;	
}

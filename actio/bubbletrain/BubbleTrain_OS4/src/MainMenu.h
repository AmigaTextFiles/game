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
  * Screen shown at the beginning with the menu options on, providing access to the
  * game
  */
 
#ifndef MAINMENU_H
#define MAINMENU_H

#include "General.h"
#include "GameSelect.h"
#include "Game.h"
#include "AboutUs.h"
#include "FastestTimeScreen.h"
#include "LevelEditor.h"
#include "OptionsScreen.h"

class MainMenu : public Window
{
	
private:

	void newGame ();
	void FastestTime();
	void options();
	void levelEditor();
	void aboutUs();
	void quit ();

public:

	MainMenu(SDL_Surface* screen);
	virtual ~MainMenu();
};

#endif // MAINMENU_H

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
  * Display a list box of the games the player can select from. Simply check for
  * any files with the game gms extension. And display in the box. When selected
  * start that game.
  */
 
#ifndef GAMESELECT_H
#define GAMESELECT_H

// System includes
#include <dirent.h>

// Game includes
#include "Game.h"
#include "Window.h"
#include "WindowManager.h"

class GameSelect : public Window
{
private:
	const char *directory;	// Defines the directory to check for games to play

	ListBox* gameList;	// List box control to populate with the games
		
	void getGameFiles();
	void loadGameClick();
	void loadGame(const char* gameFile);
	void cancel();
	
public:
	GameSelect(SDL_Surface* screen);
	virtual ~GameSelect();
};

#endif // GAMESELECT_H

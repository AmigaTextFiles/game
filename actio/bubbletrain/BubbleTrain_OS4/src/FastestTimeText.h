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
  * A window for entering the name of the user who has just gotten onto the fastest
  * time screen. 
  * 
  * Inherit from window so it can handle all of the user input / drawing for us.
  * 
  * Once they have inputted their name then display the fastest time screen.
  * Also if they don't input their name then default to something for them.
  */
  
#ifndef FASTESTTIMETEXT_H
#define FASTESTTIMETEXT_H

#include "General.h"
#include "FastestTime.h"
#include "FastestTimeScreen.h"
#include "Window.h"
#include "WindowManager.h"

class FastestTimeText : public Window
{
private:

	TextBox* txtName;			// Name the user entered
	int level;					// The details the user reached.
	int score;
	char* game;
	
	void addScore();
	
public:

	FastestTimeText(SDL_Surface* screen, const char* game, int level, int score);
	virtual ~FastestTimeText();
};

#endif // FASTESTTIMETEXT_H

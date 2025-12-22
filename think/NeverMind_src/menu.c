/*
* This file is part of NeverMind.
* Copyright (C) 1998 Lennart Johannesson
* 
* NeverMind is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* NeverMind is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with NeverMind.  If not, see <http://www.gnu.org/licenses/>.
*
*/
#include <clib/intuition_protos.h>
#include "graphics.h"
#include "menu.h"
#include "game.h"
#include "keys.h"
#include "setup.h"
#include "sound.h"
#include "scores.h"

int pressedkey=0, menuoption=8;


void mainmenu(void)
{
	int quit=0;

	loadmenupic("data/menu.raw");
	menupal=loadpalette("data/menu.pal");
	loadblocks(filename);	
	
	setpalette(menupal);

	menutitle();
	drawmenu();

	while(!quit)
	{
		drawmainmenu();
		getkeypress();

		if(pressedkey==space && menuoption==6)
		{
			cleararea(0,121, 320, 125);			
			displayscores();
			cleararea(0,121, 320, 125);			
			drawmenu();
			pressedkey=0;
		}

		if(pressedkey==space && menuoption==7)
		{
			cleararea(0,131, 320, 125);			
			settingsmenu(); /* Go to settings Menu */
			cleararea(0,131, 320, 125);			
			menuoption=7;
		}

		if(pressedkey==space && menuoption==8)
		{
			play();
			setpalette(menupal);
			menutitle();
			drawmenu();
			pressedkey=0;
		}

		if(pressedkey==space && menuoption==9) quit=1;

		if(checkabort()) quit=1;
		if(pressedkey==move_up) menuoption-=1;
		if(pressedkey==move_down) menuoption+=1;
		if(menuoption<6) menuoption=9;
		if(menuoption>9) menuoption=6;
	}
}

void settingsmenu(void)
{
	int quitsettings=0;

	menuoption=15;
	while(!quitsettings)
	{
		drawsettingsmenu();
		getkeypress();

		if(pressedkey==space && menuoption==13)
		{
			ScreenToBack(gamescreen);
			mode_request();
			shutdown("You have selected a (new) mode\nPlease close this requester and\nrestart NeverMind!");
		}

		if(pressedkey==space && menuoption==11)
		{
			mines_per_row++;
			if(mines_per_row>5) mines_per_row=2;
		}

		if(pressedkey==space && menuoption==12) chooseblocks();
		if(pressedkey==space && menuoption==14)
			if(nm_music==0)
				nmplaysong();
 			else
				nmstopsong();

		if(pressedkey==space && menuoption==15) quitsettings=1;

		if(checkabort()) quitsettings=1;
		if(pressedkey==move_up) menuoption-=1;
		if(pressedkey==move_down) menuoption+=1;
		if(menuoption<11) menuoption=15;
		if(menuoption>15) menuoption=11;
	}
}

void drawmenu()
{
	textxy("V1.00\n",280,8,12);
	textxy("(C) 1997-1998 Lennart Johannesson\n",20,92,10);
	textxy("Music made by Martin Persson\n",40,103,5);
   textxy("Icons made by Giorgio Signori\n",36,112,3);
}

void drawmainmenu()
{
	int color=0;

	if(menuoption==6) color=7 else color=5;
	textxy("Highscores\n",76,150,color);

	if(menuoption==7) color=15 else color=4;
	textxy("Game Settings\n",76,170,color);

	if(menuoption==8) color=10 else color=9;
	textxy("Start Game\n",76,190,color);

	if(menuoption==9) color=13 else color=12;
	textxy("Quit!\n",76,220,color);

}

void drawsettingsmenu()
{
	int color=0;
	if(menuoption==11)	color=7 else color=5;
	textxy("Difficulty:\n",76,150,color);

	if(mines_per_row==2)
	{
		if(menuoption==11) color=15 else color=4;
		textxy("Beginner     \n",170,150,color);
	}
	if(mines_per_row==3)
	{
		if(menuoption==11) color=10 else color=9;
		textxy("Novice       \n",170,150,color);
	}
	if(mines_per_row==4)
	{
		if(menuoption==11) color=12 else color=3;
		textxy("Professional \n",170,150,color);
	}
	if(mines_per_row==5)
	{
		if(menuoption==11) color=13 else color=12;
		textxy("HBe-Expert   \n",170,150,color);
	}

	if(menuoption==12) color=7 else color=5;
	textxy("Change Blockset\n",76,160,color);

	if(menuoption==13) color=7 else color=5;
	textxy("Select Another Screenmode\n",76,170,color);

	if(menuoption==14) color=10 else color=9;
	if(nm_music==1)
		textxy("Music is on \n",76,190,color);
	else
		textxy("Music is off\n",76,190,color);

	if(menuoption==15) color=13 else color=12;
	textxy("Back to Main!\n",76,230,color);

 
}

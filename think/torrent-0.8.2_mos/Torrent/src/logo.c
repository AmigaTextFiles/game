/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: logo.c
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software Foundation,
 *  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 */

#include "ShiftyEngine.h"

extern void SE_Redraw();

static SDL_Surface * mainScreen = 0;
static SDL_Surface * logo       = 0;
static SDL_Surface * icon       = 0;

static Uint32 init = 0;
Uint32 logoShowing = 0;

Sint32 ICON_X = 0;
Sint32 ICON_Y = 0;
Sint32 ICON_W = 0;
Sint32 ICON_H = 0;

/*****************************************************
 ****************************************************/
void showIcon()
{
	SDL_Rect dest;

	if(!init) {
		SE_Error("Logo module has not been initialized yet.");
		return;
	}

	dest.x = ICON_X;
	dest.y = ICON_Y;
	if(SDL_BlitSurface(icon, 0, mainScreen, &dest) != 0)
		SE_Error("A Blit failed.");
}

/*****************************************************
 ****************************************************/
static void showLogo()
{
	SDL_Rect dest;

	logoShowing = 1;

	dest.x = (mainScreen->w/2) - (logo->w/2) ;
	dest.y = (mainScreen->h/2) - (logo->h/2) ;
	if(SDL_BlitSurface(logo, 0, mainScreen, &dest) != 0)
		SE_Error("A Blit failed.");
}

/*****************************************************
 ****************************************************/
static void hideLogo()
{
	logoShowing = 0;
}

/*****************************************************
 ****************************************************/
void logoClicked()
{
	if(!init) {
		SE_Error("Logo module has not been initialized yet.");
		return;
	}

	if(!logoShowing) {
		showLogo();
		SDL_UpdateRect(mainScreen, 0, 0, 0, 0);
	} 
	else {
		hideLogo();
		SE_Redraw();
	}
}

/*****************************************************
 ****************************************************/
void initLogo(SDL_Surface * surface)
{
	logo = loadPNGDisplay("pics/shiftygames.png");
	icon = loadPNG("pics/sg_icon.png");

	mainScreen = surface;

	ICON_H = icon->h;
	ICON_W = icon->w - 15;
	ICON_X = 0;
	ICON_Y = mainScreen->h - ICON_H;

	init = 1;
}

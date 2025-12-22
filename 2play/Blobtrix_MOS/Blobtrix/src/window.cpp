/*
    Copyright (c) 2004-2005 Markus Kettunen

    This file is part of Blobtrix.

    Blobtrix is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Blobtrix is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Blobtrix; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


#include "window.h"

window::window(){
	oldflags=0;
}

window::~window(){}

extern graphics Graphics;


SDL_Surface * window::OpenWindow(int width, int height, int bpp, int flags) {
	if (!flags) {
		flags = oldflags^SDL_FULLSCREEN;
	}

	oldflags = flags;

	screen = SDL_SetVideoMode(width, height, bpp, flags);
	return screen;
}

void window::ToggleFullscreen() {
	fprintf (stderr, "Changing screen mode..\n");

	SDL_Surface *bg =	SDL_CreateRGBSurface(SDL_HWSURFACE, GetScreen()->w, GetScreen()->h,
				32, 0xFF000000, 0x00FF0000, 0x0000FF00, 0x0);
		
	Graphics.DrawIMG (bg, GetScreen(), 0, 0 );
	OpenWindow(GetScreen()->w, GetScreen()->h, GetScreen()->format->BitsPerPixel, 0);
	Graphics.DrawIMG (GetScreen(), bg, 0, 0 );
	SDL_Flip(GetScreen());
	Graphics.DrawIMG (GetScreen(), bg, 0, 0 );

	SDL_FreeSurface (bg);
}

void window::ToWindowed(){
	OpenWindow(GetScreen()->w, GetScreen()->h, GetScreen()->format->BitsPerPixel, SDL_HWSURFACE);
}

void window::SetTitle(char *text) {
	SDL_WM_SetCaption (text, NULL);
}

bool window::Iconify() {
	return SDL_WM_IconifyWindow();
}

SDL_Surface *window::GetScreen() {
	return screen;
}

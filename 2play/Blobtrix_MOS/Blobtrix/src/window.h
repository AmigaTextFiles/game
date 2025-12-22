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


#ifndef _WINDOW_H_
#define _WINDOW_H_

#include "SDL.h"
#include "graphics.h"

#include "config.h"

class window
{
	public:
		window();
		~window();

		SDL_Surface * OpenWindow(int width, int height, int bpp, int flags);
		void ToWindowed();
		void SetTitle(char *text);
		bool Iconify();

		void ToggleFullscreen();

		SDL_Surface *GetScreen();

	private:
		SDL_Surface *screen;
		int oldflags;



};

#endif


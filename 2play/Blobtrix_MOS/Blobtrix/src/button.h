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

#ifndef _BUTTON_H_
#define _BUTTON_H_

#include "SDL.h"
#include "config.h"

class button {
	public:
		button(int x, int y, int x2, int y2, SDL_Surface *d, SDL_Surface *bg);

		~button();

		bool Handle();

		void Draw();

	private:
		int x, y, x2, y2;
		SDL_Surface *downimg;
		SDL_Surface *background;

		bool clicked;
		bool selected;
		bool down;







};







#endif

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


#ifndef _SCROLLBAR_H_
#define _SCROLLBAR_H_

#include "SDL.h"
#include "config.h"

class scrollbar {
	public:
		scrollbar(int x, int y, int height, int showy, SDL_Surface *sel, SDL_Surface *up, SDL_Surface *down, SDL_Surface *bg);
	
		void SetScrollTime(int scrolltime);
		void SetScrollY(int scrolly);
		int GetScrollY();
	
		int Handle();
	
		void SetMaxY(int scrollmaxy);
		void SetShowY(int showy);
	
		void Draw();
	
	private:
		SDL_Surface *bg, *sel;
		SDL_Surface *up, *down;
		int x, y;
		int height;
		int scrolly;
		int showy;
		int scrollmaxy;
		
		int scrolltime;
		int scrolltimer;
		
		bool clicked;
		bool selected;
		
		int ox, oy, osy;



};


#endif

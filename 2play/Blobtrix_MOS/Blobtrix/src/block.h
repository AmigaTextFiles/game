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

#ifndef _BLOCK_H_
#define _BLOCK_H_

#include "SDL.h"

#include "config.h"



class block {
	public:

		void LoadPics();
		void FreePics();
		void Draw(int x, int y, int c);
		void DrawBlockGroup(int x, int y, int c, int r);
		bool IsNonzero(int b, int r, int x, int y);
		char GetColour(int b, int r, int x, int y);
		void DrawYesno(int x, int y, bool i);

		void SetBackground();
		SDL_Surface *GetBackground();

		void Clean(int x, int y, int x2, int y2);

		void DrawWinner(int i);

		void DrawSelected(int x, int y, int b);

		void DrawWaiting();


		int GetMinX(int type, int angle);
		int GetMaxX(int type, int angle);
		int GetMinY(int type, int angle);
		int GetMaxY(int type, int angle);
		int GetMiddleX(int type, int angle);
		int GetMiddleY(int type, int angle);



	private:
		SDL_Surface *blocks;
		SDL_Surface *selected;
		SDL_Surface *background;
		SDL_Surface *yesno;
		SDL_Surface *youwon, *youlost;
		SDL_Surface *waiting;

};







#endif

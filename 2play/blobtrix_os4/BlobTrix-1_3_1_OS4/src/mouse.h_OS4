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


#ifndef _MOUSE_H_
#define _MOUSE_H_

#include "SDL.h"

#include "config.h"

#define MOUSE_LBUTTON 1
#define MOUSE_MBUTTON 2
#define MOUSE_RBUTTON 3


class mouse
{
	public:
		mouse();
		~mouse();

		void UpdateTimer();
		Uint32 GetTimer();

		void ShowCursor(bool showing);
		void GetCursorCoords(int *x, int *y);
		void SetCursorCoords(int x, int y);
		char Clicked(int button);

		void ResetReleased();
		char Released(Uint8 button);

	private:
		bool buttondown[3];

		Uint32 mousetimer;

		/* XPM */
		char * blank_cursor[36][32];
};

#endif

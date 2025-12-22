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


#include "mouse.h"

mouse::mouse(){};
mouse::~mouse(){};

void mouse::UpdateTimer() {
	mousetimer = SDL_GetTicks();
}
Uint32 mouse::GetTimer() {
	return mousetimer;
}

void mouse::ShowCursor(bool showing) {
	SDL_ShowCursor(showing);
}

void mouse::GetCursorCoords(int *x, int *y) {
		SDL_GetMouseState(x, y);
}

void mouse::SetCursorCoords(int x, int y) {
	SDL_WarpMouse(x, y);
}

char mouse::Clicked(int button) {
	return ( SDL_GetMouseState(NULL, NULL)&SDL_BUTTON(1) );
}

void mouse::ResetReleased() {
	for (int i=0; i<3; i++) {
		buttondown[i]=false;
	}
}

char mouse::Released(Uint8 button) {
	if (Clicked(button)) {						// if button pressed, mark it.
		if (!buttondown[button]) {			// if pressed first time, report it with 2.
			buttondown[button]=true;
			return 2;
		}
	} else {
		if (buttondown[button]==true) {			// if not button pressed, but WAS pressed -> click
			buttondown[button]=false;
			return 1;
		}
	}
	return 0;
}

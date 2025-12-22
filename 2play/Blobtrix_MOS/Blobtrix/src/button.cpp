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

#include "button.h"


#include "mouse.h"
#include "graphics.h"
#include "window.h"

extern mouse Mouse;
extern graphics Graphics;
extern window Window;

button::button(int x, int y, int x2, int y2, SDL_Surface *d, SDL_Surface *bg) {
	this->x=x;
	this->y=y;
	this->x2=x2;
	this->y2=y2;

	if (d) this->downimg=d;
	else this->downimg=NULL;

	this->background=bg;

	this->clicked=false;
	this->selected=false;
	this->down=false;
}

button::~button() {
}

bool button::Handle() {
	int mx, my;
	Mouse.GetCursorCoords(&mx, &my);
	

	if (!clicked && Mouse.Clicked(1)==1) {
		if (mx>=x && mx<=x2 && my>=y && my<=y2) {
			clicked=true;
			selected=true;
		} else {
			clicked=true;
			selected=false;
		}
	}

	if (selected && mx>=x && mx<=x2 && my>=y && my<=y2) down=true;
	else down=false;

	if (clicked && Mouse.Clicked(1)==0) {
		if (mx>=x && mx<=x2 && my>=y && my<=y2 && selected) {
			clicked=false;
			selected=false;
			return true;
		} else {
			clicked=false;
			selected=false;
		}
	}

	return false;
}

void button::Draw() {
	if (downimg!=NULL) {
		if (down) Graphics.DrawIMG( Window.GetScreen(), downimg, x, y );
		else Graphics.DrawPartOfIMG( Window.GetScreen(), background, x, y, downimg->w, downimg->h, x, y);
	} else Graphics.DrawPartOfIMG( Window.GetScreen(), background, x, y, x2-x, y2-y, x, y);
}

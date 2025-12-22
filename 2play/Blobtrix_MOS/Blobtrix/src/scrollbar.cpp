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


#include "scrollbar.h"

#include "window.h"
#include "graphics.h"
#include "keyboard.h"
#include "mouse.h"

extern window Window;
extern graphics Graphics;
extern keyboard Keyboard;
extern mouse Mouse;

scrollbar::scrollbar(int x, int y, int height, int showy, SDL_Surface *sel, SDL_Surface *up, SDL_Surface *down, SDL_Surface *bg) {
	this->x=x;
	this->y=y;
	this->height=height;
	this->showy=showy;
	this->sel=sel;
	this->up=up;
	this->down=down;
	this->bg=bg;
	
	this->selected=false;
	this->clicked=false;
	this->scrolltime=30;
	this->scrolltimer=0;
	this->scrollmaxy=1;
	
	this->ox=0;
	this->oy=0;
	this->osy=0;
	this->scrolly=0;
}

void scrollbar::SetScrollY(int scrolly) {
	this->scrolly=scrolly;
}

int scrollbar::GetScrollY() {
	return scrolly;
}

int scrollbar::Handle() {
	int mx, my;
	Mouse.GetCursorCoords(&mx, &my);
	
	if (scrolltimer>0) scrolltimer--;
	
	if (!clicked && Mouse.Clicked(1)==1) {
		int a, b, c;
		if (scrollmaxy>0) {
			a = (int)((float)scrolly/(float)scrollmaxy*height);
			b = (int)((float)showy/(float)scrollmaxy*height);
			c = (int)((float)(scrollmaxy-scrolly-showy)/(float)scrollmaxy*height);
		} else {
			a=0;
			b=height;
			c=0;
		}
	
		if (mx>=x && mx<=x+20 && my>=y+a && my<=y+a+b) {
			clicked=true;
			ox=mx;
			oy=my;
			osy=scrolly;
		}

	}
	
	if (clicked) {
		scrolly = osy + (int)((my-oy)*scrollmaxy/height);
	}
	
	if (!Mouse.Clicked(1)) {
		clicked=false;
	}
	
	if (scrolly>scrollmaxy-showy) scrolly=scrollmaxy-showy;
	if (scrolly<0) scrolly=0;
	
	return scrolly;
}

void scrollbar::SetScrollTime(int scrolltime) {
	this->scrolltime = scrolltime;
}

void scrollbar::SetMaxY(int scrollmaxy) {
	this->scrollmaxy=scrollmaxy;
}

void scrollbar::SetShowY(int showy) {
	this->showy=showy;
}

void scrollbar::Draw() {
	int a, b, c;
	if (scrollmaxy==0) {
		a=0;
		b=height;
		c=0;
	} else {
		a = (int)((float)scrolly/(float)scrollmaxy*height);
		b = (int)((float)showy/(float)scrollmaxy*height);
		c = (int)((float)(scrollmaxy-scrolly-showy)/(float)scrollmaxy*height);
	}

	Graphics.DrawPartOfIMG( Window.GetScreen(), bg, x, y, 20, a, x, y);
	
	Graphics.DrawPartOfIMG( Window.GetScreen(), sel, x, y+a, 20, b, 0, a);
	Graphics.DrawIMG( Window.GetScreen(), up, x, y+a);
	Graphics.DrawIMG( Window.GetScreen(), down, x, y+a+b-3);

	Graphics.DrawPartOfIMG( Window.GetScreen(), bg, x, y+a+b+1, 20, c, x, y+a+b+1);
	

/*

------ .
|	| . scrolly/maxy*height (a)
|____| .
|	|   .
|	|   . showy/maxy*height (b)
|____|   .
|	       .
	|      .
|	       .
	|      .  (maxy-scrolly-showy)/maxy*height (c)
|	       .
	|      .
|	       .
	|      .
------


}





*/

}

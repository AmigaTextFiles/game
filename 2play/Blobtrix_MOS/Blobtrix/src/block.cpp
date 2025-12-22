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

#include "block.h"

#include "graphics.h"
#include "window.h"

#include <stdlib.h>

#include "files.h"

extern graphics Graphics;
extern window Window;

char blockgroup[7][4][4][4]={
{
{{0,0,0,0}, {1,1,1,0}, {0,1,0,0}, {0,0,0,0}}, // T
{{0,1,0,0}, {1,1,0,0}, {0,1,0,0}, {0,0,0,0}},
{{0,1,0,0}, {1,1,1,0}, {0,0,0,0}, {0,0,0,0}},
{{0,1,0,0}, {0,1,1,0}, {0,1,0,0}, {0,0,0,0}}
},
{
{{0,2,0,0}, {2,2,0,0}, {2,0,0,0}, {0,0,0,0}}, // Z
{{0,0,0,0}, {2,2,0,0}, {0,2,2,0}, {0,0,0,0}},
{{0,2,0,0}, {2,2,0,0}, {2,0,0,0}, {0,0,0,0}},
{{0,0,0,0}, {2,2,0,0}, {0,2,2,0}, {0,0,0,0}}
},
{
{{3,0,0,0}, {3,3,0,0}, {0,3,0,0}, {0,0,0,0}}, // S
{{0,0,0,0}, {0,3,3,0}, {3,3,0,0}, {0,0,0,0}},
{{3,0,0,0}, {3,3,0,0}, {0,3,0,0}, {0,0,0,0}},
{{0,0,0,0}, {0,3,3,0}, {3,3,0,0}, {0,0,0,0}}
},
{
{{4,4,0,0}, {0,4,0,0}, {0,4,0,0}, {0,0,0,0}}, // L
{{0,0,4,0}, {4,4,4,0}, {0,0,0,0}, {0,0,0,0}},
{{0,4,0,0}, {0,4,0,0}, {0,4,4,0}, {0,0,0,0}},
{{0,0,0,0}, {4,4,4,0}, {4,0,0,0}, {0,0,0,0}}
},
{
{{0,5,5,0}, {0,5,0,0}, {0,5,0,0}, {0,0,0,0}}, // J
{{0,0,0,0}, {5,5,5,0}, {0,0,5,0}, {0,0,0,0}},
{{0,5,0,0}, {0,5,0,0}, {5,5,0,0}, {0,0,0,0}},
{{5,0,0,0}, {5,5,5,0}, {0,0,0,0}, {0,0,0,0}}
},
{
{{0,6,0,0}, {0,6,0,0}, {0,6,0,0}, {0,6,0,0}}, // I
{{0,0,0,0}, {6,6,6,6}, {0,0,0,0}, {0,0,0,0}},
{{0,6,0,0}, {0,6,0,0}, {0,6,0,0}, {0,6,0,0}},
{{0,0,0,0}, {6,6,6,6}, {0,0,0,0}, {0,0,0,0}}
},
{
{{0,0,0,0}, {0,7,7,0}, {0,7,7,0}, {0,0,0,0}}, // O
{{0,0,0,0}, {0,7,7,0}, {0,7,7,0}, {0,0,0,0}},
{{0,0,0,0}, {0,7,7,0}, {0,7,7,0}, {0,0,0,0}},
{{0,0,0,0}, {0,7,7,0}, {0,7,7,0}, {0,0,0,0}}
}};

void block::LoadPics() {
	background = Graphics.LoadPicture(DATA_BACKGROUND_PNG);

	blocks = Graphics.LoadPicture(DATA_PALIKAT_PNG);
	selected = Graphics.LoadPicture(DATA_SELECTED_PNG);
	Graphics.SetTransparentColor(selected, 0, 0, 0);
	yesno = Graphics.LoadPicture(DATA_YESNO_PNG);
	Graphics.SetTransparentColor(yesno, 255, 0, 0);

	youwon = Graphics.LoadPicture(DATA_YOUWON_PNG);
	youlost = Graphics.LoadPicture(DATA_YOULOST_PNG);
	Graphics.SetTransparentColor(youwon, 255, 255, 255);
	Graphics.SetTransparentColor(youlost, 255, 255, 255);

	waiting = Graphics.LoadPicture(DATA_WAITING_PNG);
}

void block::FreePics() {

	SDL_FreeSurface(background);

	SDL_FreeSurface(blocks);
	SDL_FreeSurface(selected);
	SDL_FreeSurface(yesno);

	SDL_FreeSurface(youwon);
	SDL_FreeSurface(youlost);

	SDL_FreeSurface(waiting);

}

void block::Draw(int x, int y, int c) {
	if (c>=1) Graphics.DrawPartOfIMG(Window.GetScreen(), blocks, x, y, 19, 19, 0, 19*c);
	if (c==0) Graphics.DrawPartOfIMG(Window.GetScreen(), background, x, y, 19, 19, x, y);
}

void block::DrawYesno(int x, int y, bool i) {
	Graphics.DrawPartOfIMG(Window.GetScreen(), yesno, x, y, 28, 28, i*28, 0);
}

// T, Z, S, L, J, I, O

bool block::IsNonzero(int b, int r, int x, int y) {
	if (blockgroup[b][r][y][x]) return true;
	return false;
}
char block::GetColour(int b, int r, int x, int y) {
	return blockgroup[b][r][y][x];
}

void block::SetBackground() {
	Graphics.DrawIMG(Window.GetScreen(), background, 0, 0);
}

SDL_Surface *block::GetBackground() {
	return background;
}

void block::Clean(int x, int y, int x2, int y2) {
	Graphics.DrawPartOfIMG(Window.GetScreen(), background, x, y, abs(x2-x)+1, abs(y2-y)+1, x, y);
}

void block::DrawWinner(int i) {
	Uint32 *p=(Uint32*)Window.GetScreen()->pixels;
	Uint32 *img;
	
	if (i==1) img=(Uint32*)youwon->pixels;
	if (i==2) img=(Uint32*)youlost->pixels;
	
	if (SDL_MUSTLOCK(Window.GetScreen())) SDL_LockSurface(Window.GetScreen());
	if (SDL_MUSTLOCK(youwon)) SDL_LockSurface(youwon);
		
	
// 11111110111111101111111011111110 = 4278124286
	Uint8 r, g, b;
		
	const Uint32 mask = 4278124286U;
		
	for (int y=0; y<youwon->h; y++) {
		for (int x=0; x<youwon->w; x++) {
			Graphics.GetRGB(*img, youwon->format, &r, &g, &b);
			if (r!=255 && g!=255 && b!=255) {
				if (r==0 && g==0 && b==0) {
					*p = ( ((*p) & mask) >>1 );
				} else {
					*p = *img;
				}
			}
			p++;
			img++;
	 	}
		p+=800-youwon->w;
	}
	
	if (SDL_MUSTLOCK(Window.GetScreen())) SDL_UnlockSurface(Window.GetScreen());
	if (SDL_MUSTLOCK(youwon)) SDL_UnlockSurface(youwon);

}

void block::DrawBlockGroup(int x, int y, int c, int r) {
	if (c<=-1) {
		c=-c;
		for (int x2=0; x2<4; x2++) {
			for (int y2=0; y2<4; y2++) {
				fprintf (stderr, "c-1=%d, r=%d, y2=%d, x2=%d\n", c-1, r, y2, x2);
				if (blockgroup[c-1][r][y2][x2]!=0) Draw(x+x2*19,y+y2*19, 0);
			}
		}
		return;
	}


	if (c==0) {
		for (int x2=0; x2<4; x2++) {
			for (int y2=0; y2<4; y2++) {
				Draw(x+x2*19,y+y2*19, 0);
			} 
		}
		return;
	}

	if (c>=1) {
		for (int x2=0; x2<4; x2++) {
			for (int y2=0; y2<4; y2++) {
				if (blockgroup[c-1][r][y2][x2]!=0) Draw(x+x2*19,y+y2*19, blockgroup[c-1][r][y2][x2]);
			}
		}
		return;
	}

}

int block::GetMinX(int type, int angle) {
	if (type<0 || type>7 || angle < 0 || angle > 3) return -1;

	for (int cx=0; cx<4; cx++) {
		for (int cy=0; cy<4; cy++) {
			if ( IsNonzero(type-1, angle, cx, cy) ) return cx;
		}
	}
	return -1;
}
int block::GetMaxX(int type, int angle) {
	if (type<0 || type>7 || angle < 0 || angle > 3) return -1;

	for (int cx=3; cx>=0; cx--) {
		for (int cy=0; cy<4; cy++) {
			if ( IsNonzero(type-1, angle, cx, cy) ) return cx;
		}
	}
	return -1;
}
int block::GetMinY(int type, int angle) {
	if (type<0 || type>7 || angle < 0 || angle > 3) return -1;

	for (int cy=0; cy<4; cy++) {
		for (int cx=0; cx<4; cx++) {
			if ( IsNonzero(type-1, angle, cx, cy) ) return cy;
		}
	}
	return -1;
}
int block::GetMaxY(int type, int angle) {
	if (type<0 || type>7 || angle < 0 || angle > 3) return -1;

	for (int cy=3; cy>=0; cy--) {
		for (int cx=0; cx<4; cx++) {
			if ( IsNonzero(type-1, angle, cx, cy) ) return cy;
		}
	}
	return -1;
}

int block::GetMiddleX(int type, int angle) {
	int maxx = GetMaxX(type, angle);
	int minx = GetMinX(type, angle);

	return 19*minx + (int)( (maxx-minx)*19/2 );
}

int block::GetMiddleY(int type, int angle) {
	int maxy = GetMaxY(type, angle);
	int miny = GetMinY(type, angle);

	return 19*miny + (int)( (maxy-miny)*19/2 );
}



void block::DrawSelected(int x, int y, int b) {
	if (b==1) Graphics.DrawPartOfIMG(Window.GetScreen(), selected, x, y, 90, 90, 0, 0);
	if (b==2) Graphics.DrawPartOfIMG(Window.GetScreen(), selected, x, y, 90, 90, 90, 0);
	if (b==0) Graphics.DrawPartOfIMG(Window.GetScreen(), background, x, y, 90, 90, x, y);

}

void block::DrawWaiting() {
	Graphics.DrawIMG(Window.GetScreen(), waiting, 0, 0);
}

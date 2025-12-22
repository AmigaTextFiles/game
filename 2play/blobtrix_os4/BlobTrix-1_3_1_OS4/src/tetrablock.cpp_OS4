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


#include "tetrablock.h"
#include "block.h"
extern block Block;


tetrablock::tetrablock(int x, int y, int type, char *blockmap) {
	this->x = x;
	this->y = y;
	this->type = type;
	this->blockmap = blockmap;
	this->falling=false;
	this->angle=0;
	this->inuse=true;
	this->falling=false;
	
//	this->notinusetime=0; NOTICE
}

tetrablock::tetrablock(char *blockmap) {
	this->x = 0;
	this->y = 0;
	this->type = 0;
	this->blockmap = blockmap;
	this->falling=false;
	this->angle=0;
	this->inuse=false;
	this->falling=false;
	
//	this->notinusetime=0; NOTICE
}

tetrablock::tetrablock() {
}

int tetrablock::CollideHorizontalWalls(int x, int y) {
	for (int cx=0; cx<4; cx++) {
		for (int cy=0; cy<4; cy++) {
			if ( Block.IsNonzero(type-1, angle, cx, cy) ) {
				if (x+cx < 0) return 1;
				if (x+cx >= XSIZE) return 2;
			}
		}
	}
	return false;
}

bool tetrablock::CollideBlocks(int x, int y) {
	for (int cx=0; cx<4; cx++) {
		for (int cy=0; cy<4; cy++) {
			if ( Block.IsNonzero(type-1, angle, cx, cy) ) {
				if (GetBlock(x+cx, y+cy)>0 ) return true;
				if ( (cy+y<0) || (cy+y>=YSIZE) ) return true;
			}
		}
	}
	return false;
}

int tetrablock::GetMinY() {
	for (int cx=0; cx<4; cx++) {
		for (int cy=0; cy<4; cy++) {
			if ( Block.IsNonzero(type-1, angle, cx, cy) ) return y+cy;
		}
	}
	return -1;
}

int tetrablock::GetMaxY() {
	for (int cx=0; cx<4; cx++) {
		for (int cy=3; cy>=0; cy--) {
			if ( Block.IsNonzero(type-1, angle, cx, cy) ) return y+cy;
		}
	}
	return -1;
}

bool tetrablock::MoveLeft() {
	if (!CollideHorizontalWalls(x-1, y) ) {
		x--;
	 	return true;
	}
	return false;
}

bool tetrablock::MoveRight() {
	if (!CollideHorizontalWalls(x+1, y) ) {
		x++;
	 	return true;
	}
	return false;
}


void tetrablock::Fossilize() {
	for (int cx=0; cx<4; cx++) {
		for (int cy=0; cy<4; cy++) {
			char c = Block.GetColour(type-1, angle, cx, cy);
			if (x+cx >= 0 && x+cx < XSIZE && y+cy >= 0 && y+cy < YSIZE) {
				if (c>0) SetBlock(x+cx, y+cy, c);
			}
		}
	}
}
void tetrablock::Fossilize(char *bmap, int i) {
	for (int cx=0; cx<4; cx++) {
		for (int cy=0; cy<4; cy++) {
			char c = Block.GetColour(type-1, angle, cx, cy);
			if (x+cx >= 0 && x+cx < XSIZE && y+cy >= 0 && y+cy < YSIZE) {

				if (c>0) bmap[(y+cy)*XSIZE+(x+cx)]=i;
			}
		}
	}
}


int tetrablock::GetX() {
	return x;
}
int tetrablock::GetY() {
	return y;
}
int tetrablock::GetAngle() {
	if (angle<0) angle=3;
	return angle;
}
int tetrablock::GetType() {
	if (type<1) type=8;
	return type;
}

void tetrablock::SetX(int x) {
	this->x = x;
}
void tetrablock::SetY(int y) {
	this->y = y;
}
void tetrablock::SetAngle(int angle) {
	this->angle = angle;
}
void tetrablock::SetType(int type) {
	this->type = type;
}

void tetrablock::SetUsed(bool b) {
/*	if (inuse && !b) { NOTICE
		notinusetime=40; // noblink-fix
		inuse=b;
	}
	if (b) {
		inuse=b;
		notinusetime=0;
	}
*/
	inuse=b;

}
void tetrablock::QuickSetUsed(bool b) {
/*	if (inuse && !b) { NOTICE
		notinusetime=0; // noblink-fix
		inuse=b;
	}
	if (b) {
		inuse=b;
		notinusetime=0;
	}*/
	inuse=b;
}


bool tetrablock::IsUsed() {
//	if (!inuse) if (notinusetime<=0) return false; // noblink-fix - notinuse affects with a small lag so it won't blink so much.
	return inuse;
//	return true; NOTICE
}

void tetrablock::DecreaseHideTime() {
//	if (notinusetime>0) notinusetime--; NOTICE
}

bool tetrablock::Launched() {
	return falling;
}

void tetrablock::SetSpeed(int dropspeed, int dropdirection) {
	this->dropspeed=dropspeed;
	this->dropdirection=dropdirection;
	droptimer=dropspeed;
	falling=true;
}


inline int tetrablock::GetBlock(int x, int y) {
//	fprintf (stderr, "%d, %d\n", x, y);
	return blockmap[y*XSIZE+x];
}
inline void tetrablock::SetBlock(int x, int y, char c) {
	blockmap[y*XSIZE+x]=c;
}

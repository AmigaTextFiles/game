/*

	SnakeMe 1.0 GPL
	Copyright (C) 2000 Stephane Magnenat/Ysagoon

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/


#ifndef __CSNAKEARRAY_H
#define __CSNAKEARRAY_H

#include "SGU.h"

// constants
#define SNAKEARRAYW 80
#define SNAKEARRAYH 56


class CSnakeArray
{
public:
	CSnakeArray();
	~CSnakeArray(); 
	void ClearArray(void);
	void SetYStartPos(int y) { ystartpos=y; }
	bool Load(char *filename,SDL_Surface *si);
	bool Save(char *filename);
	void SetThemeSprite(SGU_Sprite *s) { sprite=s; }
	void FullBackgroundDraw(SDL_Surface *si);
	void SingleBackgroundPosDraw(int x,int y,SDL_Surface *si);
	bool TestForFreeSpace(int x,int y,int r);
private:
	// start y position
	int ystartpos;
	// theme sprite
	SGU_Sprite *sprite;
public:
	// arrays
	unsigned long int bgspritearray[SNAKEARRAYW][SNAKEARRAYH];
	signed long int obstaclearray[SNAKEARRAYW][SNAKEARRAYH];
};

#endif

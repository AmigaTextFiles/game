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


#ifndef __CSNAKE_H
#define __CSNAKE_H

#include <stdlib.h>
#include "CSnakeArray.h"
#include "SGU.h"

typedef struct
{
	int x,y;
} SSnakePos;

const SSnakePos SSPNULL = {0,0};

class CSnake
{
friend class CDeadSnake;
public:
	CSnake();
	~CSnake();
	void Clear(void);
	SSnakePos GetToken(int n) { if (n<length) return snake[n]; else return SSPNULL;}
	SSnakePos GetHead(void) {if (length>0) return snake[0]; else return SSPNULL;}
	SSnakePos GetPreHead(void) {if (length>1) return snake[1]; else return SSPNULL;}
	SSnakePos GetPrePreHead(void) {if (length>2) return snake[2]; else return SSPNULL;}
	SSnakePos GetTail(void) {if (length>0) return snake[length-1];else return SSPNULL; }
	SSnakePos GetPreTail(void) {if (length>1) return snake[length-2];else return SSPNULL; }
	int GetLength(void) { return length; }

	void SetArray(CSnakeArray *ar) { array=ar; }
	void SetSprite(SGU_Sprite *sp) { sprite=sp; }

protected:
	SSnakePos *snake;
	int *snakesprites;
	CSnakeArray *array;
	int length;
public:
	SGU_Sprite *sprite;
};

#endif

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


#ifndef __CDEADSNAKE_H
#define __CDEADSNAKE_H

#include "CSnake.h"

class CDeadSnake:public CSnake
{
public:
	CDeadSnake(CSnake *snaketemplate,int lifetime);
	CDeadSnake(CSnake *snaketemplate,int lifetime,int pos);
	~CDeadSnake();
	bool DoStepAndDraw(SDL_Surface *si);
private:
	int *snakesprites;
	int lifetimeleft;
	int maxlifetime;
};


#endif

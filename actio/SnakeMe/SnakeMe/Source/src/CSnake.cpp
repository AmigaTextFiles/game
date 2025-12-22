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


#include "CSnake.h"

CSnake::CSnake()
{ 
	snake=NULL; 
	snakesprites=NULL;
	length=0;
}

CSnake::~CSnake()
{ 
	if (snake) 
		free(snake); 
	snake=NULL; 
	if (snakesprites)
		free(snakesprites);
	snakesprites=NULL;
	length=0;
}

void CSnake::Clear(void)
{
	if (snake)
		free(snake);
	snake=NULL;
	if (snakesprites)
		free(snakesprites);
	snakesprites=NULL;
	length=0;
}




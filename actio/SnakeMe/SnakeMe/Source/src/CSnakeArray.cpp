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


#include "CSnakeArray.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>



CSnakeArray::CSnakeArray()
{
	ClearArray();
}

CSnakeArray::~CSnakeArray()
{

}


bool CSnakeArray::TestForFreeSpace(int x,int y,int r)
{
	int dx,dy;
	for (dx=MAX(x-r+1,0);dx<MIN(x+r,SNAKEARRAYW);dx++)
	{
		for (dy=MAX(y-r+1,0);dy<MIN(y+r,SNAKEARRAYH);dy++)
		{
			if (obstaclearray[dx][dy]!=-1)
				return false;
		}
	}
	return true;
}

void CSnakeArray::ClearArray(void)
{
	int x,y;

	// set full wall
	for (x=0;x<SNAKEARRAYW;x++)
	{
		for (y=0;y<SNAKEARRAYH;y++)
		{
			obstaclearray[x][y]=10;
		}
	}

	// delete non walls walls
	for (x=1;x<SNAKEARRAYW-1;x++)
	{
		for (y=1;y<SNAKEARRAYH-1;y++)
		{
			obstaclearray[x][y]=-1;
		}
	}
}

	
bool CSnakeArray::Load(char *filename,SDL_Surface *si)
{
	FILE *fp;
	int x,y;

	fp=fopen(filename,"rb");
	if (fp)
	{
		// load obstacles
		for (x=0;x<SNAKEARRAYW;x++)
		{
			for (y=0;y<SNAKEARRAYH;y++)
			{
				fscanf(fp,"%d\n",&(obstaclearray[x][y]));
			}
		}
		fclose(fp);
		return true;
	}
	else
	{
		return false;
	}
}

bool CSnakeArray::Save(char *filename)
{
	FILE *fp;
	int x,y;

	fp=fopen(filename,"wb");
	if (fp)
	{
		// save obstacles
		for (x=0;x<SNAKEARRAYW;x++)
		{
			for (y=0;y<SNAKEARRAYH;y++)
			{
				fprintf(fp,"%d\n",obstaclearray[x][y]);
			}
		}
		fclose(fp);
		return true;
	}
	else
	{
		return false;
	}
}

void CSnakeArray::FullBackgroundDraw(SDL_Surface *si)
{
	int x,y;
	for (x=0;x<SNAKEARRAYW;x++)
	{
		for (y=0;y<SNAKEARRAYH;y++)
		{
			SingleBackgroundPosDraw(x,y,si);
		}
	}
}

void CSnakeArray::SingleBackgroundPosDraw(int x,int y,SDL_Surface *si)
{
	// Draw background
	SDL_Rect r1,r2;
	r1.x=((x<<3)%sprite->GetW(0));
	r1.y=((y<<3)%sprite->GetH(0));
	r1.w=8;
	r1.h=8;
	r2.x=x<<3;
	r2.y=(y<<3)+ystartpos;
	r2.w=8;
	r2.h=8;
	SDL_BlitSurface(sprite->GetFrameSurface(0),&r1,si,&r2);
	// If other, draw on it
	if ((obstaclearray[x][y]>=9) && (obstaclearray[x][y]<14))
	{
		sprite->Display(si,(x<<3),(y<<3)+ystartpos,obstaclearray[x][y]-9);
	}
}


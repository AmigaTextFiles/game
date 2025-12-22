/*
* This file is part of NeverMind.
* Copyright (C) 1998 Lennart Johannesson
* 
* NeverMind is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* NeverMind is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with NeverMind.  If not, see <http://www.gnu.org/licenses/>.
*
*/
/* NeverMind  (C) 1997-1998 - Lennart Johannesson */
/* Part of NeverMind that does *heavy* calculations etc.
   & parts that take long time to compile */

#include <clib/dos_protos.h>
#include <exec/types.h>
#include <stdio.h>
#include "think.h"
#include "game.h"
#include "keys.h"
#include "graphics.h"

int checkmove(void) /* Checks if a move could be made */
{
   if((pressedkey==move_left) && ((xpos-1)>=0)) /* Checks Left */
   {
		if(miscfield[xpos-1][ypos]!=markedmine)
		{
			drawoldpos();
			xpos--;
			return(1);
		}
	}

	if((pressedkey==move_right) && ((xpos+1)<pf_xsize)) /* Checks Right */
	{
		if(miscfield[xpos+1][ypos]!=markedmine)
		{
			drawoldpos();
			xpos++;
			return(1);
		}
	}

	if((pressedkey==move_up) && ((ypos-1)>=0)) /* Checks Up */
	{
		if(miscfield[xpos][ypos-1]!=markedmine)
		{
			drawoldpos();
			ypos--;
			return(1);
		}
	}

	if((pressedkey==move_down) && ((ypos+1)<pf_ysize)) /* Checks Down */
	{
		if(miscfield[xpos][ypos+1]!=markedmine)
		{
			drawoldpos();
			ypos++;
			return(1);
		}
	}
	return(0);
}

int checkmines(void)
{
	int surround=0;
	if(xpos>0 && ypos>0)  /* Checks upper-left */
		if(playfield[xpos-1][ypos-1]==mine) surround++;

	if(ypos>0) /* Checks upper-middle */
		if(playfield[xpos][ypos-1]==mine) surround++;

	if(ypos>0 && xpos<(pf_xsize-1)) /* Checks upper-right */
		if(playfield[xpos+1][ypos-1]==mine) surround++;

	if(xpos>0) /* Checks middle-left */
		if(playfield[xpos-1][ypos]==mine) surround++;

	if(xpos<(pf_xsize-1)) /* Checks middle right */
		if(playfield[xpos+1][ypos]==mine) surround++;

	if(xpos>0 && ypos<(pf_ysize-1)) /* Checks lower-left */
		if(playfield[xpos-1][ypos+1]==mine) surround++;

	if(ypos<(pf_ysize-1)) /* Checks lower-middle */
		if(playfield[xpos][ypos+1]==mine) surround++;

	if(xpos<(pf_xsize-1) && ypos<(pf_ysize-1)) /* Checks lower-right */
		if(playfield[xpos+1][ypos+1]==mine) surround++;

	return surround;
}

void markmines(void)
{
	int surround=0,xmine,ymine;

	if(pressedkey==0x3d)
	{
		if(xpos>0 && ypos>0)   /* Marks upper-left */
		{
			xmine=xpos-1; ymine=ypos-1;
			if(miscfield[xmine][ymine]==unknown)
			{
				miscfield[xmine][ymine]=markedmine;
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
			if(miscfield[xmine][ymine]==markedmine)
			{
				miscfield[xmine][ymine]=unknown; 
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
		}
	}

	if(pressedkey==0x3e)
	{
		if(ypos>0)   /* Marks upper-middle */
		{
			xmine=xpos; ymine=ypos-1;
			if(miscfield[xmine][ymine]==unknown)
			{
				miscfield[xmine][ymine]=markedmine;
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
			if(miscfield[xmine][ymine]==markedmine)
			{
				miscfield[xmine][ymine]=unknown; 
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
		}
	}

	if(pressedkey==0x3f)
	{
		if(ypos>0 && xpos<(pf_xsize-1))   /* Marks upper-right */
		{
			xmine=xpos+1; ymine=ypos-1;
			if(miscfield[xmine][ymine]==unknown)
			{
				miscfield[xmine][ymine]=markedmine;
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
			if(miscfield[xmine][ymine]==markedmine)
			{
				miscfield[xmine][ymine]=unknown; 
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
		}
	}


	if(pressedkey==0x2d)
	{
		if(ypos>=0)   /* Marks left */
		{
			xmine=xpos-1; ymine=ypos;
			if(miscfield[xmine][ymine]==unknown)
			{
				miscfield[xmine][ymine]=markedmine;
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
			if(miscfield[xmine][ymine]==markedmine)
			{
				miscfield[xmine][ymine]=unknown; 
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
		}
	}

	if(pressedkey==0x2f)
	{
		if(xpos<(pf_xsize-1))   /* Marks right */
		{
			xmine=xpos+1; ymine=ypos;
			if(miscfield[xmine][ymine]==unknown)
			{
				miscfield[xmine][ymine]=markedmine;
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
			if(miscfield[xmine][ymine]==markedmine)
			{
				miscfield[xmine][ymine]=unknown; 
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
		}
	}

	if(pressedkey==0x1d)
	{
		if(xpos>0 && ypos<(pf_ysize-1)) /* Marks lower-left */
		{
			xmine=xpos-1; ymine=ypos+1;
			if(miscfield[xmine][ymine]==unknown)
			{
				miscfield[xmine][ymine]=markedmine;
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
			if(miscfield[xmine][ymine]==markedmine)
			{
				miscfield[xmine][ymine]=unknown; 
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
		}
	}

	if(pressedkey==0x1e)
	{
		if(ypos<(pf_ysize-1)) /* Marks lower-middle */
		{
			xmine=xpos; ymine=ypos+1;
			if(miscfield[xmine][ymine]==unknown)
			{
				miscfield[xmine][ymine]=markedmine;
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
			if(miscfield[xmine][ymine]==markedmine)
			{
				miscfield[xmine][ymine]=unknown; 
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
		}
	}

	if(pressedkey==0x1f)
	{
		if(xpos<(pf_xsize-1) && ypos<(pf_ysize-1)) /* Marks lower-right */
		{
			xmine=xpos+1; ymine=ypos+1;
			if(miscfield[xmine][ymine]==unknown)
			{
				miscfield[xmine][ymine]=markedmine;
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
			if(miscfield[xmine][ymine]==markedmine)
			{
				miscfield[xmine][ymine]=unknown; 
				putblock(xmine*16, ymine*16+titlebar_height, miscfield[xmine][ymine]);
				return;
			}
		}
	}
}

/* Lentos stackpusher usage: push(xnum, ynum, pointer to stack, point in stack) */
void push(UBYTE x, UBYTE y, UBYTE mystack[], unsigned int *stpoint)
{
	mystack[*stpoint]=x;
	(*stpoint)++;
	mystack[*stpoint]=y;
	(*stpoint)++;
}

/* Lentos stackpopper usage: push(*xnum, *ynum, pointer to stack, point in stack) */
void pop(UBYTE *x, UBYTE *y, UBYTE mystack[], unsigned int *stpoint)
{
	(*stpoint)--;
	*y=mystack[*stpoint];
	(*stpoint)--;
	*x=mystack[*stpoint];
}

int pathfinder(void)
{
	UBYTE pfield[pf_xsize][pf_ysize]; /* We need a copy of the field to manipulate! */
	UBYTE stack[stacksize];
	unsigned int spointer=0;
	UBYTE x, y;

	for(y=0;y<pf_ysize;y++) /* A copy of the playfield */
	{
		for(x=0;x<pf_xsize;x++)
		{
			pfield[x][y]=playfield[x][y];		
		}
	}

	x=0; y=0;

	push(x, y, stack, &spointer); /* Put startvalue on the stack */
 	
	while(spointer>0)
	{
		pop(&x,&y, stack, &spointer);
		if(pfield[x][y]==endblock) return 1;
		if(pfield[x][y]==water)
		{
			if(y>0) /* Check above */
			{	if((pfield[x][y-1]==water) || (pfield[x][y-1]==endblock))
					push(x,y-1, stack, &spointer);	}

			if(x<(pf_xsize-1)) /* Check the right */
			{	if((pfield[x+1][y]==water) || (pfield[x+1][y]==endblock))
					push(x+1,y, stack, &spointer);	}

			if(y<(pf_ysize-1)) /* Check below */
			{	if((pfield[x][y+1]==water) || (pfield[x][y+1]==endblock))
					push(x, y+1, stack, &spointer);	}

			if(x>0) /* Check to the left */
			{	if((pfield[x-1][y]==water) || (pfield[x-1][y]==endblock))
					push(x-1, y, stack, &spointer);	}

			pfield[x][y]=mine;

/*		putblock(x*16, y*16+titlebar_height, pfield[x][y]); */
		}
	}

	return 0;
}

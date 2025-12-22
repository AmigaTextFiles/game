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
#include <clib/dos_protos.h>
#include <stdlib.h>
#include <time.h>
#include "game.h"
#include "menu.h"
#include "graphics.h"
#include "keys.h"
#include "think.h"
#include "scores.h"

int mines_per_row=NULL;
UBYTE playfield[pf_xsize][pf_ysize];
UBYTE miscfield[pf_xsize][pf_ysize];
int xpos, ypos;

void drawfield(void)
{
	int x,y;
	for(y=0;y<pf_ysize;y++)
	{
		for(x=0;x<pf_xsize;x++)
		{
		putblock(x*16, y*16+titlebar_height, miscfield[x][y]);
		}
	}

	drawplayer();
	putblock(goal_xpos*16,goal_ypos*16+titlebar_height,endblock);
}

int makefield(void)
{
	int x,y,minenr, set;
	
	for(y=0;y<pf_ysize;y++)
	{
		for(x=0;x<pf_xsize;x++)
		{
			playfield[x][y]=water;		
			miscfield[x][y]=unknown;
		}
	}

	playfield[goal_xpos][goal_ypos]=endblock;   /* Goal position */
   miscfield[goal_xpos][goal_ypos]=endblock;

	srand(time(NULL));	
	for(y=0;y<pf_ysize;y++) /* Start randomize mines on row 0 */
	{
		for(minenr=0;minenr<mines_per_row;minenr++)
		{
			set=0;
			while(!set)      /* Repeat until a mine was set */
			{
				x=rand()%pf_xsize;
				if(!((x<=(xpos+1) && y<=(ypos+1)) || (x>=(goal_xpos-1) && y>=(goal_ypos-1))))
				{
					if(playfield[x][y]!=mine && playfield[x][y]!=endblock)
					{
						playfield[x][y]=mine;
						set=1; /* Mine was successfully placed! */
					}
				}	
			}
		}
	}
	return pathfinder();

}

void revealfield(void)
{
int x,y;
	for(y=0;y<pf_ysize;y++)
	{
		for(x=0;x<pf_xsize;x++)
		{
		putblock(x*16, y*16+titlebar_height, playfield[x][y]);
		}
	}
	drawplayer();
}

void drawplayer(void)
{
	putblock(xpos*16,ypos*16+titlebar_height, player); 
}

void drawoldpos(void)
{
	putblock(xpos*16,ypos*16+titlebar_height,playfield[xpos][ypos]); 
}

void dead(void)
{
	int blink;

	inform("Game Over!\n",116);
	for(blink=0; blink<5;blink++)
	{
		Delay(10);	/* These lines, creates a "flashing" block effect */
		putblock(xpos*16, ypos*16+titlebar_height, mine);
		Delay(10);
		putblock(xpos*16, ypos*16+titlebar_height, player);
	}

}

void won(void)
{
	int blink;
	inform("You Made It!\n",107);
	revealfield();
	for(blink=0; blink<5;blink++)
	{
		Delay(10);	/* These lines, creates a "flashing" block effect */
		putblock(xpos*16, ypos*16+titlebar_height, endblock); 
		Delay(10);
		putblock(xpos*16, ypos*16+titlebar_height, player);
	}
	inform("Final score is coming up...\n",50);
	Delay(100);
	inform("\n",0);


}

void play(void)
{
	int endgame, restartgame=1, score;

	pressedkey=0;
	wipescreen(0);
	setpalette(blockpal);

	while(restartgame){
		xpos=0; ypos=0; endgame=0; score=0;
		while(!makefield());
		drawfield();
		gamebar(checkmines(), score);
		miscfield[xpos][ypos]=playfield[xpos][ypos];

		while(!endgame)
		{
			getkeypress();      /* Checks key-press, if pressed stored in "pressedkey" variable */

			if(checkabort()){ endgame=1; restartgame=0; }
			if(checkmove())
			{
				if(miscfield[xpos][ypos]==unknown) score+=5;
				if(miscfield[xpos][ypos]==water) score--;
				if(score<0) score=0;
				miscfield[xpos][ypos]=playfield[xpos][ypos];
				drawplayer();
				gamebar(checkmines(), score);
			}

			if(checkmarkkey()) markmines();
	
			if(playfield[xpos][ypos]==endblock)
			{
				endgame=1; restartgame=0;
				won();
				score=finalscore(score);
			}

			if(playfield[xpos][ypos]==mine)
			{
				dead();
				endgame=1;
			}
		}

		revealfield();
		wipescreen(50);
	if(checkhighscore(score)) restartgame=0;
	}
}

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
/* Header file for NeverMind
   (C) 1997-1998 Lennart Johannesson */
#include <exec/types.h>

const int water=0;      /* The blocknumbers of the "scenario" */
const int player=1;
const int mine=2;
const int endblock=3;
const int unknown=4;
const int markedmine=5;

const int pf_ysize=15;  /* Width of the playfield */
const int pf_xsize=20;  /* Height of the playfield */

const int goal_xpos=pf_xsize-1; /* The x-and y-position of the goal */
const int goal_ypos=pf_ysize-1;

extern int mines_per_row;

void dead(void);        /* When you die! */
void drawplayer(void);  /* Draws player at current playerposition */
void drawoldpos(void);  /* Draws oldpos-brick at current playerposition */
void drawfield(void);   /* Draws the field at start */
int makefield(void);   /* Creates a new playfield */
void play(void);        /* Main gameloop... */
void revealfield(void); /* Reveals field when finished or dead! */
void won(void);             /* Hmmm... What could this functon do? */

extern UBYTE playfield[pf_xsize][pf_ysize]; /* The playfield */
extern UBYTE miscfield[pf_xsize][pf_ysize]; /* The Misc field, for different things */
extern int xpos,ypos; /* Position of the player */
extern int score;

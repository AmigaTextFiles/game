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

int checkmines(void);  /* Checks Number of mines around */
void markmines(void);  /* Marks/Unmarks mines, so you cant run into them */
int checkmove(void);   /* Checks if any move was made */
int pathfinder(void);  /* Checks if a level is completeable */
void pop(UBYTE *, UBYTE *, UBYTE *, unsigned int *); /* Pop from da stack! */
void push(UBYTE, UBYTE, UBYTE *, unsigned int *); /* Push on da stack! */

const int stacksize=5000; /* Size of the stack for the pathfinder */

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

const int pic_xsize = 96;     /* Width of screen */
const int pic_ysize = 16;     /* Height of screen */
const int menu_xsize = 320;   /* Width of screen */
const int menu_ysize = 88;    /* Height of screen */
const int titlebar_height=16; /* Height of the titlebar */

extern struct BitMap *blockpic;        //The blockpic bitmap
extern struct BitMap *menupic;         //The menupic bitmap 

extern ULONG *menupal;
extern ULONG *blockpal;

int power(int,int);                 /* ;) ;) ;) */
ULONG *loadpalette(char *);	    /* Alloc mem & load the palette file to it */
void setpalette(ULONG *);           /* Sets the specified palette */
void chooseblocks(void);            /* Load a different block set */
void gamebar(int, int);             /* Update gamebar */
void inform(char *, int);           /* Writes a text out at, x */
void loadblocks(char *);            /* Loads the blocks */
void loadmenupic(char *);           /* Loads the menupic */
void menutitle(void);               /* Displays the menupic, cool :) */
void putblock(int, int, int);       /* Put out a block on the screen */
void textxy(char *, int, int, int); /* writes a text at x,y with color */
void wipescreen(int );              /* Wipes the screen, sMOOth! */
void cleararea(int, int, int, int); /* Clear the area from x,y,width,height */

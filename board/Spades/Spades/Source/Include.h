/*
   FILE: Include.h
   PURPOSE: Bring in all the include files needed for Spades
   AUTHOR: Gregory M. Stelmack
*/

#include <exec/types.h>
#include <exec/memory.h>
#include <intuition/intuition.h>
#include <exec/libraries.h>
#include <graphics/gfxmacros.h>
#include <dos/dos.h>
#include <libraries/gadtools.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <proto/gadtools.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>
#include "Spades.proto"

/************** Program Constants **************/
#define MNONE     0  /* No Mouse Button Pressed    */
#define MLEFT     1  /* Left Mouse Button Pressed  */
#define MRIGHT    2  /* Right Mouse Button Pressed */

#define DIAMONDS  0  /* Suit Definitions */
#define CLUBS     1
#define HEARTS    2
#define SPADES    3

#define CARDMEMSIZE  52*126*2*3  /* Memory needed for card data */

#define RP       Wdw->RPort   /* Raster Port for Graphics Routines */
#define PENS         8        /* Number of Pens                    */
#define DEPTH        3        /* Number of BitPlanes               */

#define BLUP 0
#define BLKP 1
#define REDP 2
#define GRNP 3
#define WHTP 4
#define YELP 5
#define PURP 6
#define CYNP 7

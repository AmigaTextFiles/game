/*
    YacTris v0.0
    Copyright ©1993 Jonathan P. Springer

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 1, or (at your option)
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    For more details see the files README and COPYING, which should have
    been included in this distribution.

    The author can be reached during the school year at these E-Mail addresses:

	springjp@screech.alfred.edu	    (Internet)
	springjp@ceramics.bitnet	    (Bitnet)

    And can be reached by paper mail year-round at the following address:

	Jonathan Springer
	360 W. Main St.
	Dallastown, PA	17313-2014
	USA

*/


/*
**
**  springtris.h
**
**  Header File with Springtris information
**
**  Jonathan Springer
**
**  v 0.0
**
*/

#include <exec/types.h>
#include <graphics/gfx.h>

#define FHEIGHT 22
#define FWIDTH 10
#define STARTX 3
#define STARTY 0


struct ScreenInfo {
    struct Screen *	s;
    int 		planes;
    int 		xTimes, yTimes;
    int 		WTop, WBot;
    int 		WLeft, WRight;
    UWORD		pens[4];
    struct TextAttr *	font;
    APTR		vi;

    /*	Window Dimesions  */
    int 		WinWidth, WinHeight;

    /*	Playfield Dimensions  */
    int 		FieldInLeft, FieldInTop, FieldInWidth, FieldInHeight;

    /*	Nextpiece Dimensions  */
    int 		NextInLeft, NextInTop, NextInWidth, NextInHeight;
    struct IntuiText *	NextText;

    /*	Where to blit the piece  */
    int 		NPTop, NPLeft;

    /*	Scores Dimensions  */
    struct IntuiText *	ScoreTexts;
    int 		ScoreLeft, ScoreTop, ScoreWidth, ScoreHeight;

    /*	pWindow Information  */
    int 		pWidth, pHeight;
    int 		pxOffset, pyOffset;
    int 		pBMDown;
    int 		pxMult, pyMult;
    struct IntuiText *	pIText;
};

#define BACK	0
#define SHINE	1
#define SHADOW	2
#define FILL	3

struct MakeStruct {
    int 		command;
    BYTE		xMult, xOffSet;
    BYTE		yMult, yOffSet;
};

/*  Commands  */
#define STOP	0
#define DRAW	1
#define MOVE	2
#define FLOOD	3
#define PEN	4

struct PieceRot {
    int 		type;
    struct PieceRot *	next;
    struct BitMap	BitMap;
    int 		width, height;
    UBYTE *		map;
    struct MakeStruct * ms;
};

/*  Piece types  */
#define LINE	    0
#define BLOCK	    1
#define TEE	    2
#define ZIG	    3
#define ZAG	    4
#define ELL	    5
#define LEE	    6

#define NUM_TYPES   7

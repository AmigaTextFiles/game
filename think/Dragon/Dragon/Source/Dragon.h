/************************************************************************
*																		*
* Definitions header for Dragon game.									*
*																		*
*						Copyright ©1994 Nick Christie					*
*																		*
*************************************************************************/

#define SCRWIDTH		320			/* current screen specification */
#define SCRHEIGHT		256
#define SCRDEPTH		5

#define MAINWFLGS		(WFLG_ACTIVATE|WFLG_SMART_REFRESH|\
							WFLG_BORDERLESS|WFLG_BACKDROP)
#define MAINIDCMP		(IDCMP_MOUSEBUTTONS|IDCMP_MENUPICK)

#define ITEM_NEWGAME	0				/* menu item numbers */
#define ITEM_RESTART	1
#define ITEM_UNDOMOVE	2
#define ITEM_ABOUT		3
#define ITEM_QUIT		4

#define IEQ_SHIFT		(IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT)

#define TILEWIDTH		27			/* dims of tile images */
#define TILEHEIGHT		32
#define TILEDEPTH		4

#define TILEXSPACE		24			/* how much to separate tile images */
#define TILEYSPACE		29			/* by on screen, so that they overlap */

#define LEVELXADJ		3			/* how much to subtract from x & y per */
#define LEVELYADJ		3			/* level (z), to create perspective */

#define NUMTILES		120			/* total # of tiles */
#define MAXTILETYPE		30			/* 4 tiles of each type, 30 types */

#define BOARDX			12			/* number of tiles across, down & high */
#define BOARDY			6
#define BOARDZ			4

#define BRDLEFTEDGE		10			/* offset of board from screen topleft */
#define BRDTOPEDGE		50

#define SELECTLEFT		4			/* where to place image of currently */
#define SELECTTOP		123			/* selected tile on screen */

#define CopyBoard(s,d)	memcpy(d,s,sizeof(BOARD))

typedef UBYTE BOARD[BOARDZ][BOARDY][BOARDX];

struct StackMove {					/* To save moves in for undo-ing */
	UBYTE	tile;					/* The tile type removed */
	UBYTE	pad;
	UBYTE	x1,y1,z1;				/* The co-ordinates of the pair */
	UBYTE	x2,y2,z2;				/* of tiles removed */
};

/*
Copyright (c) 1992, Trevor Smigiel.  All rights reserved.

(I hope Commodore doesn't mind that I borrowed their copyright notice.)

The source and executable code of this program may only be distributed in free
electronic form, via bulletin board or as part of a fully non-commercial and
freely redistributable diskette.  Both the source and executable code (including
comments) must be included, without modification, in any copy.  This example may
not be published in printed form or distributed with any commercial product.

This program is provided "as-is" and is subject to change; no warranties are
made.  All use is at your own risk.  No liability or responsibility is assumed.

*/

#define NBITMAPS 20

#define PFWIDTH  10
#define PFHEIGHT 20

#define TWIDTH  (BSize + PWIDTH + BSize)
#define THEIGHT (4 * YSize + PHEIGHT + BSize)

#define UPDATE_TIME      50000
#define UPDATE_SECONDS   (1000000 / UPDATE_TIME - 1)

#define TETRIS_PORT "Tetris_Port"

#define COMMAND_IGNORE   0x0000
#define COMMAND_LEFT     0x0001
#define COMMAND_RIGHT    0x0002
#define COMMAND_DOWN     0x0003
#define COMMAND_ROTATE   0x0004

#define GOAL_CLEAR_LINES 0x0001
#define GOAL_TIME_LIMIT  0x0002
#define GOAL_ENDURANCE   0x0004

#define TETF_GAMEOVER  0x0001
#define TETF_NEXTLEVEL 0x0002
#define TETF_OUTOFTIME 0x0004
#define TETF_OUTOFROOM 0x0008

struct TPiece {
	WORD which, x, y, bx, by;
};

struct TLevel {
	WORD goal;     /* 1 for lines, 2 for time limit, 4 for endurance*/
	WORD lines;    /* number of lines to get */
	WORD time;     /* time to do it in, or time to last */
	WORD line_up;
	UWORD board[PFHEIGHT + 1];
};

struct TBoard { 
	struct TLevel level;
	WORD flags;
	struct RastPort *rastport;
	struct BitMap bitmap;
	Point board_off;
	Point score_off;
	Point line_off;
	Point time_off;
	Point next_off;
	WORD seed[3];
	struct TPiece piece;
	WORD next_which;
	WORD drop_up;
	WORD next_line_up, next_drop_up;
	WORD drop, next_drop;
	WORD lines;
	WORD next_sec, time;
	WORD clevel;
	LONG points;
	WORD pieces[7];
};


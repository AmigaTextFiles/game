#include <exec/exec.h>
#include <proto/exec.h>

#include <intuition/intuition.h>
#include <proto/intuition.h>

#include <proto/graphics.h>

#include <libraries/reqtools.h>
#include <proto/reqtools.h>

#include <libraries/gadtools.h>
#include <proto/gadtools.h>

#include <math.h>

#include "fil.h"

extern	APTR			VisualInfo;
extern struct Screen	*Scr;
extern struct Window	*mwWnd;
extern BOOL				startplayer;
extern UBYTE			currentplayer;
extern UWORD			offx;
extern UWORD			offy;
extern int				boardsize;

#define AttackFactor	4

static WORD Weight[] = { 0, 0, 4, 20, 100, 500, 0 };
UBYTE Board [ MAXBOARDSIZE + 1 ] [ MAXBOARDSIZE + 1 ];
UBYTE Aline [ 4 ] [ MAXBOARDSIZE + 1 ] [ MAXBOARDSIZE + 1 ] [ 2 ];
int   Value [ MAXBOARDSIZE + 1 ] [ MAXBOARDSIZE + 1 ] [ 2 ];

void drawboard ( void )
{
	int	row;
	int	col;

	for ( row = 0; row < boardsize; row ++ )
	{
		for ( col = 0; col < boardsize; col ++ )
		{
			DrawBevelBox ( mwWnd->RPort, offx + INTERWIDTH + ( row * BOXSIZE ),
				offy + INTERHEIGHT + ( col * BOXSIZE ), BOXSIZE, BOXSIZE, 
				GT_VisualInfo, VisualInfo, TAG_DONE );
		}
	}

}

int initnewgame ( void )
{
	int 	playerno;
	int 	depth;
	int 	row;
	int 	col;

	if ( startplayer ) {
		startplayer = FALSE;
		if ( currentplayer == NULL ) currentplayer = HUMAN;
	}
	else {
		startplayer = TRUE;
		if ( currentplayer == NULL ) currentplayer = AMIGA;
	}

    for ( row = 1; row <= boardsize; row ++ ) {
        for ( col = 1; col <= boardsize; col ++ )
            Board [ row ] [ col ] = EMPTY;
    }

    for ( depth = 0; depth <= 3; depth ++ ) {
        for ( row = 1; row <= boardsize; row ++ ) {
            for ( col = 1; col <= boardsize; col ++ ) {
                for ( playerno = 0; playerno <= 1; playerno ++ )
                    Aline [ depth ] [ row ] [ col ] [ playerno ] = 0;
            }
        }
    }

    for ( row = 1; row <= boardsize; row ++ ) {
        for ( col = 1; col <= boardsize; col ++ ) {
            for ( playerno = 0; playerno <= 1; playerno ++ )
                Value [ row ] [  col ] [ playerno ] = 0;
        }
    }

	EraseRect ( mwWnd->RPort, offx + INTERWIDTH, offy + INTERHEIGHT,
							  offx + INTERWIDTH + boardsize * BOXSIZE,
							  offy + INTERHEIGHT + boardsize * BOXSIZE);
	drawboard ();
	return ( TRUE );
}

void Addup ( int row, int col, int depth, BOOL *gamewon )
{
	int player;

	if ( currentplayer == AMIGA ) player = 1;
	else player = 0;

    if ( ++ Aline [ depth ] [ row ] [ col ] [ player ] == 5) *gamewon = TRUE;
}


void UpdateValue ( int row, int col, int x1, int y1, int dir, int j )

{
	int x;
	int y;
	int player;
	int opponent;

	if ( currentplayer == AMIGA ) {
		player = 1;
		opponent = 0;
	}
	else {
		player = 0;
		opponent = 1;
	}

	switch ( dir ) {
		case 0:
	        x = j;
    	    y = 0;
			break;

		case 1:
	        x = j;
    	    y = j;
			break;

		case 2:
	        x = 0;
    	    y = j;
			break;

		case 3:
	        x = - j;
    	    y = j;
			break;
    }

    if ( Aline [ dir ] [ x1 ] [ y1 ] [ opponent ] == 0)
		Value [ x1 + x ] [ y1 + y ] [ player ] = 
			Value [ x1 + x ] [ y1 + y ] [ player ] + 
			Weight [ Aline [ dir ] [ x1 ] [ y1 ] [ player ] + 1 ] - 
			Weight [ Aline [ dir ] [ x1 ] [ y1 ] [ player ] ];
    else if ( Aline [ dir ] [ x1 ] [ y1 ] [ player ] == 1)
			Value [ x1 + x ] [ y1 + y ] [ opponent ] =
				Value [ x1 + x ] [ y1 + y ] [ opponent ] - 
				Weight [ Aline [ dir ] [ x1 ] [ y1 ] [ opponent ] + 1 ];
}

void findmove ( int *x, int *y , FLOAT playlevel )

{
	int maxvalue = -1;
	int row;
	int col;
	int player;
	int opponent;
	int value;

	if ( currentplayer == AMIGA ) {
		player = 1;
		opponent = 0;
	}
	else {
		player = 0;
		opponent = 1;
	}

    *x = ( boardsize + 1 ) / 2;
    *y = ( boardsize + 1 ) / 2;

    if ( Board [ *x ] [ *y ] == EMPTY ) maxvalue = 4;

    for ( row = 1; row <= boardsize; row ++ ) {
        for ( col = 1; col <= boardsize; col ++ ) {
            if ( Board [ row ] [ col ] == EMPTY ) {
                value = Value [ row ] [ col ] [ player ] * 
					( 16 + AttackFactor ) / 16 + Value [ row ] [ col ] [ opponent ];
                if ( value > maxvalue ) {
					if ( drand48() >= playlevel ) {
            	        *x = row;
                	    *y = col;
                    	maxvalue = value;
					}
                }
            }
        }
    }
}

int checkdrawgame ( void )
{
	BOOL 	drawgame = TRUE;
	int		row;
	int		startrow;
	int		col;
	int		startcol;
	UBYTE	player;
	int		inline;

	for ( player = HUMAN; player <= AMIGA; player ++ ) {
		/* check horizontal */

		for ( row = 1; row <= boardsize; row ++ ) {
			inline = 0;
			for ( col = 1; col <= boardsize; col ++ ) {
				if ( Board [ row ] [ col ] == player || Board [ row ] [ col ] == EMPTY ) {
					inline ++;
					if ( inline == 5 ) {
						drawgame = FALSE;
						col = boardsize;
						row = boardsize;
						player = AMIGA + 1;
					}
				}
				else inline = 0;
			}
		}

		/* check vertical */

		if ( drawgame == TRUE ) {
			for ( col = 1; col <= boardsize; col ++ ) {
				inline = 0;
				for ( row = 1; row <= boardsize; row ++ ) {
					if ( Board [ row ] [ col ] == player || Board [ row ] [ col ] == EMPTY ) {
						inline ++;
						if ( inline == 5 ) {
							drawgame = FALSE;
							col = boardsize;
							row = boardsize;
							player = AMIGA + 1;
						}
					}
					else inline = 0;
				}
			}
		}

		/* check diagonal 1  */

		if ( drawgame == TRUE ) {
			for ( col = 1; col <= boardsize - 4; col ++ ) { 
				inline = 0;
				startrow = col + 5;
				if ( startrow > boardsize ) startrow = boardsize;
				for ( row = startrow; row >= 1; row -- ) {
					if ( Board [ row ] [ col ] == player || Board [ row ] [ col ] == EMPTY ) {
						inline ++;
						if ( inline == 5 ) {
							drawgame = FALSE;
							col = boardsize;
							row = 0;
							player = AMIGA + 1;
						}
					}
					else inline = 0;
				}
			}
		}

		/* check diagonal 2  */

		if ( drawgame == TRUE ) {
			for ( row = 1; row <= boardsize - 4; row ++ ) { 
				inline = 0;
				startcol = row + 5;
				if ( startcol > boardsize ) startcol = boardsize;
				for ( col = startcol; col >= 1; col -- ) {
					if ( Board [ row ] [ col ] == player || Board [ row ] [ col ] == EMPTY ) {
						inline ++;
						if ( inline == 5 ) {
							drawgame = FALSE;
							col = 0;
							row = boardsize;
							player = AMIGA + 1;
						}
					}
					else inline = 0;
				}
			}
		}
	}

	if ( drawgame ) {
		showresult ( "It's a draw!!!" );
		return ( FALSE);
	}
	else return ( TRUE );
}

void makemove ( int row, int col , BOOL *gamewon )
{
	int dir;
	int i;
	int j;
	int x1;
	int y1;

	dir = 0;
    for ( i = 0; i <= 4; i ++ ) {
        x1 = row - i;
        y1 = col;
        if ( x1 >= 1 && x1 <= boardsize - 4 ) {
            Addup ( x1, y1, dir, gamewon );
            for ( j = 0; j <= 4; j ++ )
                UpdateValue ( row, col, x1, y1, dir, j );
        }
    }

    dir = 1 ;
    for ( i = 0; i <= 4; i ++ ) {
        x1 = row - i;
        y1 = col - i;
        if ( ( x1 >= 1 && x1 <= boardsize - 4 ) && ( y1 >= 1 && y1 <= boardsize - 4 ) ) {
            Addup ( x1, y1, dir, gamewon );
            for ( j = 0; j <= 4; j ++ )
                UpdateValue ( row, col, x1, y1, dir, j );
        }
    }

    dir = 3;
    for ( i = 0; i <= 4; i ++ ) {
        x1 = row + i;
        y1 = col - i;
        if ( ( x1 >= 5 && x1 <= boardsize ) && ( y1 >= 1 && y1 <= boardsize - 4 ) ) {
            Addup ( x1, y1, dir, gamewon );
            for ( j = 0; j <= 4; j ++ )
                UpdateValue ( row, col, x1, y1, dir, j );
        }
    }

    dir = 2;
    for ( i = 0; i <= 4; i ++ ) {
        x1 = row;
        y1 = col - i;
        if ( y1 >= 1 && y1 <= boardsize - 4 ) {
            Addup ( x1, y1, dir, gamewon );
            for ( j = 0; j <= 4; j ++ )
                UpdateValue ( row, col, x1, y1, dir, j );
        }
    }
}

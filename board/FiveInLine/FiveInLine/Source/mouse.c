#include <intuition/intuition.h>
#include <proto/intuition.h>

#include <graphics/gfxmacros.h>
#include <proto/graphics.h>

#include <libraries/gadtools.h>
#include <proto/gadtools.h>

#include "fil.h"

extern APTR		VisualInfo;
extern struct 	Gadget	*mwGadgets [ 3 ];
extern struct 	Screen	*Scr;
extern struct 	Window	*mwWnd;
extern int		boardsize;
extern UBYTE 	Board [ MAXBOARDSIZE + 1 ] [ MAXBOARDSIZE + 1 ];
extern BOOL 	gamewon;
extern UBYTE	currentplayer;
extern UWORD 	offx;
extern UWORD	offy;

void draw_x ( int row, int col)
{
	int 	x = offx + INTERWIDTH + ( col - 1 ) * BOXSIZE + 2;
	int 	y = offy + INTERHEIGHT + ( row - 1 ) * BOXSIZE + 3;
	int 	x1 = x + BOXSIZE - 6;
	int 	y1 = y + BOXSIZE - 6;
	
	SetAPen ( mwWnd->RPort, 1);
	Move ( mwWnd->RPort, x, y );
	Draw ( mwWnd->RPort, x1, y1 );

	Move ( mwWnd->RPort, x1, y );
	Draw ( mwWnd->RPort, x, y1 );
}

void draw_o ( int row, int col)
{
	int 	x1 = offx + INTERWIDTH + ( col - 1 ) * BOXSIZE + BOXSIZE / 2;
	int 	y1 = offy + INTERHEIGHT + ( row - 1 ) * BOXSIZE + BOXSIZE / 2;

	SetAPen ( mwWnd->RPort, 2);
	DrawCircle ( mwWnd->RPort, x1, y1, BOXSIZE / 2 - 3 );
}

int handlemousebuttons ( struct IntuiMessage *msg , int *amiga_old_row, int amiga_old_col )
{
	static 	int 	old_row = -1;
	static 	int 	old_col;
	static  LONG 	humanscore = 0;
			int 	row;
			int		col;
			BOOL	running = TRUE;
			BOOL 	gamewon = FALSE;

	if ( msg->MouseY > ( offy + INTERHEIGHT ) )
		row = ( msg->MouseY - offy - INTERHEIGHT ) / BOXSIZE + 1;
	else row = 0;

	if ( msg->MouseX > ( offx + INTERWIDTH ) ) 
		col = ( msg->MouseX - offx - INTERWIDTH ) / BOXSIZE + 1;
	else col = 0;
	
	switch ( msg->Code )
	{
		case SELECTDOWN:
			if ( *amiga_old_row != -1 ) {
				DrawBevelBox ( mwWnd->RPort, offx + INTERWIDTH + ( amiga_old_col - 1 ) * BOXSIZE,
					offy + INTERHEIGHT + ( *amiga_old_row - 1 ) * BOXSIZE, BOXSIZE, BOXSIZE, 
					GT_VisualInfo, VisualInfo, TAG_DONE );
				*amiga_old_row = -1;
			}
			if ( row >= 1 && row <= boardsize && col >= 1 && col <= boardsize ) {
				if ( Board [ row ] [ col ] == EMPTY ) {
					DrawBevelBox ( mwWnd->RPort, offx + INTERWIDTH + ( col - 1 ) * BOXSIZE,
						offy + INTERHEIGHT + ( row - 1 ) * BOXSIZE, BOXSIZE, BOXSIZE, 
						GT_VisualInfo, VisualInfo, GTBB_Recessed, TRUE, TAG_DONE );
					old_row = row;
					old_col = col;
				}
				else old_row = -1;
			}
			break;
		case SELECTUP:
			if ( old_row != -1 ) {
				DrawBevelBox ( mwWnd->RPort, offx + INTERWIDTH + ( old_col - 1 ) * BOXSIZE,
					offy + INTERHEIGHT + ( old_row - 1 ) * BOXSIZE, BOXSIZE, BOXSIZE, 
					GT_VisualInfo, VisualInfo, TAG_DONE );
				if ( row == old_row && col == old_col) {
					makemove ( row, col , &gamewon );
					draw_x ( row, col );
					if ( gamewon ) {
						showresult ( "You won!" );
						humanscore ++;
						GT_SetGadgetAttrs ( mwGadgets [ GD_HUMAN ], mwWnd, NULL,
							GTNM_Number, humanscore,
							TAG_END );
						running = FALSE;
					}
					Board [ row ] [ col ] = HUMAN;
					currentplayer = AMIGA;
				}
			}
			break;
	}

	return ( running );
}

int amigamove ( int *old_row, int *old_col, FLOAT playlevel )
{
	static  LONG	amigascore = 0;
			int 	row;
			int 	col;
			BOOL	running = TRUE;
			BOOL 	gamewon = FALSE;

	findmove ( &row, &col, playlevel );
	makemove ( row, col , &gamewon );
	DrawBevelBox ( mwWnd->RPort, offx + INTERWIDTH + ( col - 1 ) * BOXSIZE,
		offy + INTERHEIGHT + ( row - 1 ) * BOXSIZE, BOXSIZE, BOXSIZE, 
		GT_VisualInfo, VisualInfo, GTBB_Recessed, TRUE, TAG_DONE );
	*old_row = row;
	*old_col = col;
	draw_o ( row, col );
	if ( gamewon ) {
		showresult ( "I won.");
		amigascore ++;
		GT_SetGadgetAttrs ( mwGadgets [ GD_AMIGA ], mwWnd, NULL,
			GTNM_Number, amigascore,
			TAG_END );
		running = FALSE;
	}
	Board [ row ] [ col ] = AMIGA;
	currentplayer = HUMAN;

	return ( running );
}

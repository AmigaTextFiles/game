#include <intuition/intuition.h>
#include <proto/intuition.h>

#include <libraries/gadtools.h>
#include <proto/gadtools.h>

#include <stdlib.h>

#include "fil.h"

extern	APTR			VisualInfo;
extern	struct Screen	*Scr;
extern	UWORD			offx;
extern	UWORD			offy;
		int				gadgetwidth;
		int				gadgetheight;
		int				scoreboxwidth;
		int				scoreboxheight;

int setupscreen ( void )
{
	if ( ! ( Scr = LockPubScreen ( "Workbench" ) ) )
		return ( 1L );
	else {
		offx = Scr->WBorLeft;
		offy = Scr->WBorTop + Scr->RastPort.TxHeight + 1;

		gadgetwidth = ( Scr->RastPort.TxWidth + 1 ) * 5;
		gadgetheight = Scr->RastPort.TxHeight + 5;
		scoreboxwidth = gadgetwidth * 2;
		scoreboxheight = 3 * gadgetheight + 4 * INTERHEIGHT;
	}

	if ( ! ( VisualInfo = GetVisualInfo ( Scr, TAG_DONE ) ) ) return ( 2L );
	else return ( 0L );
}

void closedownscreen ( void )
{
	if ( VisualInfo ) {
		FreeVisualInfo ( VisualInfo );
		VisualInfo = NULL;
	}

	if ( Scr ) {
		UnlockPubScreen ( NULL, Scr );
		Scr = NULL;
	}
}

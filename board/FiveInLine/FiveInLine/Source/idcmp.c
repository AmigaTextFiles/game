#include <exec/exec.h>
#include <proto/exec.h>

#include <intuition/intuition.h>
#include <proto/intuition.h>

#include <libraries/gadtools.h>
#include <proto/gadtools.h>

#include "fil.h"

extern struct Window	*mwWnd;
extern struct Menu		*mwMenus;
extern BOOL				player;
extern UWORD			offx;
extern UWORD			offy;

int handleidcmp ( int *amiga_old_row, int amiga_old_col, BOOL *terminated, FLOAT *playlevel )
{
	struct IntuiMessage	mwMsg;
	struct IntuiMessage	*m;
	struct MenuItem		*item;
	BOOL				running = TRUE;

	Wait ( 1 << mwWnd->UserPort->mp_SigBit );

	while ( mwWnd && ( m = GT_GetIMsg ( mwWnd->UserPort ) ) ) {

		CopyMem ( ( char * )m, ( char * ) &mwMsg, ( long ) sizeof ( struct IntuiMessage ) );

		GT_ReplyIMsg ( m );

		switch ( mwMsg.Class ) {

			case	IDCMP_REFRESHWINDOW:
				GT_BeginRefresh ( mwWnd );
				drawboard ();
				GT_EndRefresh ( mwWnd, TRUE );
				break;

			case	IDCMP_CLOSEWINDOW:
				closedownwindow ( terminated );
				running = FALSE;
				break;

			case	IDCMP_MENUPICK:
				while ( mwMsg.Code != MENUNULL && running ) {
					item = ItemAddress ( mwMenus, mwMsg.Code );

					switch ( MENUNUM ( mwMsg.Code ) ) {
						case 0: /* Project */					
							switch ( ITEMNUM ( mwMsg.Code ) ) {
								case 0:
									running = showabout ();
									break;
								case 2:
									closedownwindow ( terminated );
									running = FALSE;
									break;
							}
							break;
						case 1: /* Amiga Playing Level */
							switch ( ITEMNUM ( mwMsg.Code ) ) {
								case 0:
									*playlevel = LEVEL5;
									SetWindowTitles ( mwWnd, LEVELTEXT5, ( UBYTE * ) ~ 0 );
									break;
								case 1:
									*playlevel = LEVEL4;
									SetWindowTitles ( mwWnd, LEVELTEXT4, ( UBYTE * ) ~ 0 );
									break;
								case 2:
									*playlevel = LEVEL3;
									SetWindowTitles ( mwWnd, LEVELTEXT3, ( UBYTE * ) ~ 0 );
									break;
								case 3:
									*playlevel = LEVEL2;
									SetWindowTitles ( mwWnd, LEVELTEXT2, ( UBYTE * ) ~ 0 );
									break;
								case 4:
									*playlevel = LEVEL1;
									SetWindowTitles ( mwWnd, LEVELTEXT1, ( UBYTE * ) ~ 0 );
									break;
							}
							break;
						}
					mwMsg.Code = item->NextSelect;
				}
				break;

			case	IDCMP_MOUSEBUTTONS:
				running = handlemousebuttons ( m , amiga_old_row, amiga_old_col );
				break;

		}
	}
	return ( running );
}

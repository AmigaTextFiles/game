#include <exec/exec.h>
#include <proto/exec.h>

#include <intuition/intuition.h>
#include <proto/intuition.h>

#include <libraries/gadtools.h>
#include <proto/gadtools.h>

#include "fil.h"

extern	APTR			VisualInfo;
struct	Gadget			*mwGadgets [ 3 ];
extern	struct Screen	*Scr;
extern	struct Window	*mwWnd;
extern	struct Menu		*mwMenus;
extern	UWORD			offx;
extern	UWORD			offy;
extern	int				gadgetwidth;
extern	int				gadgetheight;
extern	int				scoreboxwidth;
extern	int				scoreboxheight;
extern	int				boardsize;

struct Gadget *mwGList = NULL;
struct NewMenu mwNewMenu[] = {
	NM_TITLE, ( STRPTR ) "Project", NULL, 0, NULL, NULL,
	NM_ITEM,  ( STRPTR ) "About...", ( STRPTR ) "?", 0, 0L, NULL,
	NM_ITEM,  ( STRPTR ) NM_BARLABEL, NULL, 0, 0L, NULL,
	NM_ITEM,  ( STRPTR ) "Quit", ( STRPTR ) "Q", 0, 0L, NULL,
	NM_TITLE, ( STRPTR ) "Playing Level", NULL, 0, NULL, NULL,
	NM_ITEM,  ( STRPTR ) "5 - A winner", NULL, CHECKIT | CHECKED | MENUTOGGLE, 30L, NULL,
	NM_ITEM,  ( STRPTR ) "4 - Good", NULL, CHECKIT | MENUTOGGLE, 29L, NULL,
	NM_ITEM,  ( STRPTR ) "3 - Average", NULL, CHECKIT | MENUTOGGLE, 27L, NULL,
	NM_ITEM,  ( STRPTR ) "2 - Poor", NULL, CHECKIT | MENUTOGGLE, 23L, NULL,
	NM_ITEM,  ( STRPTR ) "1 - Born loser", NULL, CHECKIT | MENUTOGGLE, 15L, NULL,
	NM_END, NULL, NULL, 0, 0L, NULL };

int setupwindow ( void )
{
	struct	NewGadget	ng;
	struct	Gadget		*g;

	if ( ! ( g = CreateContext ( &mwGList ) ) )	return ( 1L );

	ng.ng_VisualInfo = VisualInfo;
	ng.ng_TextAttr   = Scr->Font;
	ng.ng_LeftEdge   = offx + 3 * INTERWIDTH + boardsize * BOXSIZE;
	ng.ng_TopEdge    = offy + 2 * INTERHEIGHT;
	ng.ng_Height	 = gadgetheight;
	ng.ng_Width		 = scoreboxwidth;
	ng.ng_GadgetText = "Score:";
	ng.ng_Flags		 = PLACETEXT_IN;
	ng.ng_GadgetID	 = GD_SCORE;
	
	mwGadgets [ GD_SCORE ] = g = CreateGadget (TEXT_KIND, g, &ng,
		GTTX_Border, TRUE,
		TAG_END);

	ng.ng_LeftEdge   += scoreboxwidth / 2 ;
	ng.ng_TopEdge    += gadgetheight + INTERHEIGHT ;
	ng.ng_Width		 = gadgetwidth;
	ng.ng_GadgetText = "You:";
	ng.ng_Flags		 = PLACETEXT_LEFT;
	ng.ng_GadgetID	 = GD_HUMAN;
	
	mwGadgets [ GD_HUMAN ] = g = CreateGadget (NUMBER_KIND, g, &ng,
		GTNM_Border, TRUE,
		GTNM_Justification, GTJ_RIGHT,
		TAG_END);

	ng.ng_TopEdge    += gadgetheight + INTERHEIGHT;
	ng.ng_GadgetText = "I  :";
	ng.ng_GadgetID	 = GD_AMIGA;
	
	mwGadgets [ GD_AMIGA ] = g = CreateGadget (NUMBER_KIND, g, &ng,
		GTNM_Border, TRUE,
		GTNM_Justification, GTJ_RIGHT,
		TAG_END);

	if ( ! ( mwMenus = CreateMenus ( mwNewMenu, TAG_DONE ) ) )
		return ( 3L );

	LayoutMenus ( mwMenus, VisualInfo,
		GTMN_NewLookMenus, TRUE,
		TAG_DONE );

	if ( ! ( mwWnd = OpenWindowTags ( NULL,
			WA_Left,		offx + 10,	
			WA_Top,			offy + 10,
			WA_InnerWidth,	offx + offx + 4 * INTERWIDTH + boardsize * BOXSIZE + scoreboxwidth,
			WA_InnerHeight,	offy + offy + 2 * INTERHEIGHT + ( boardsize - 1 ) * BOXSIZE,
			WA_IDCMP, 		IDCMP_MOUSEBUTTONS | IDCMP_MENUPICK | IDCMP_CLOSEWINDOW | IDCMP_REFRESHWINDOW,
			WA_Flags, 		WFLG_DRAGBAR | WFLG_DEPTHGADGET | WFLG_CLOSEGADGET | WFLG_SMART_REFRESH | WFLG_NEWLOOKMENUS,
			WA_Gadgets,		mwGList,
			WA_Activate,	TRUE,
			WA_Title, 		LEVELTEXT5,
			WA_ScreenTitle,	"FiveInLine v2.2 - © 1994 Njål Fisketjøn",
			TAG_DONE ) ) )
		return ( 4L );

	SetMenuStrip ( mwWnd, mwMenus );
	GT_RefreshWindow ( mwWnd, NULL );

	DrawBevelBox ( mwWnd->RPort, offx + 2 * INTERWIDTH + boardsize * BOXSIZE,
		offy + INTERHEIGHT, 2 * INTERWIDTH + scoreboxwidth, scoreboxheight, 
		GT_VisualInfo, VisualInfo, TAG_DONE );

	return ( 0L );
}

void closedownwindow ( BOOL *terminated )
{
	if ( mwMenus ) {
		ClearMenuStrip ( mwWnd );
		FreeMenus ( mwMenus );
		mwMenus = NULL;	}

	if ( mwWnd ) {
		CloseWindow ( mwWnd );
		mwWnd = NULL;
	}

	if ( mwGList ) {
		FreeGadgets ( mwGList );
		mwGList = NULL;
	}

	*terminated = TRUE;
}

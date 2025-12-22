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
**  about.c
**
**  This module contains routines for responding to the "About..." menu item
**  and giving menu help.
**
*/

/*********************************/
/*  External Library References  */
/*********************************/
#include <exec/libraries.h>
extern struct Library *SysBase;
extern struct Library *IntuitionBase;
extern struct Library *GadToolsBase;

/**************/
/*  Includes  */
/**************/
#include <exec/types.h>
#include <intuition/intuition.h>
#include <libraries/gadtools.h>
#include <utility/tagitem.h>
#include "dbug/dbug.h"
#include "yactris.h"
#include "bruce.h"

/****************/
/*  Prototypes	*/
/****************/
#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/macros.h>

Prototype void DoAbout(struct Window *);

/****************/
/*  About Text	*/
/****************/

const char abTexts[] =
    "Yactris version 0.0\n"
    "by Jonathan Springer\n\n"
    "Yactris comes with\n"
    "ABSOLUTELY NO WARRANTY.\n\n"
    "Yactris is free software.\n"
    "You are welcome to redistribute it\n"
    "under certain conditions.\n\n"
    "See the files 'COPYING' and 'README'\n"
    "for details.\n";

/*****************/
/*  Actual Code  */
/*****************/

/*
**
**  DoAbout()
**
**  Display the About window
**
*/
#define DA_GO_ON 13

void DoAbout(struct Window *w)
{
    struct EasyStruct es = {
	sizeof(struct EasyStruct),
	0, "About Yactris",
	abTexts, "Wow!"
    };

#if 0
    struct NewGadget ng = {
	0, (AB_LINES+2)*si->font->ta_YSize + si->WTop,
	0, 2*si->font->ta_YSize,
	"Wow!", si->font,
	DA_GO_ON, PLACETEXT_IN,
	si->vi, NULL
    };

    struct Window *w;

    struct IntuiText it = {
	si->pens[SHADOW], si->pens[BACK], JAM1,
	0,0, si->font, NULL, NULL
    };

    int i, maxlen=0;

    struct Gadget *pgad=NULL, *glist;

    struct IntuiMessage *imsg;

    ULONG Class;
    struct Gadget *g;
    BOOL done = FALSE;
#endif

    DBUG_ENTER("DoAbout");

    EasyRequestArgs(w, &es, NULL, NULL);

#if 0
    for (i=0; i<AB_LINES; i++) if (abTexts[i]) {
	it.IText = abTexts[i];
	maxlen = MAX(maxlen, IntuiTextLength(&it));
    }

    ng.ng_Width = maxlen/3;
    ng.ng_LeftEdge = ng.ng_Width+si->WLeft+si->xTimes;

    pgad = CreateContext(&glist);

    if (pgad = CreateGadget(BUTTON_KIND, pgad, &ng, TAG_END) ) {

	if (w = OpenWindowTags(NULL, (Tag)
	    WA_IDCMP,		BUTTONIDCMP|
				IDCMP_CLOSEWINDOW|IDCMP_REFRESHWINDOW,
	    WA_Gadgets, 	glist,
	    WA_Title,		"About YacTris",
	    WA_ScreenTitle,	"YacTris v0.0",
	    WA_InnerWidth,	maxlen+2*si->xTimes,
	    WA_InnerHeight,	(AB_LINES+5)*si->font->ta_YSize,
	    WA_PubScreen,	si->s,
	    WA_DragBar, 	TRUE,
	    WA_DepthGadget,	TRUE,
	    WA_Activate,	TRUE,
	    WA_SmartRefresh,	TRUE,
	    WA_AutoAdjust,	TRUE
	)) {

	    GT_RefreshWindow(w, NULL);

	    for (i=0; i<AB_LINES; i++) if (abTexts[i]) {
		it.IText = abTexts[i];
		it.LeftEdge = (maxlen-IntuiTextLength(&it))/2;
		PrintIText(w->RPort, &it,
		    si->WLeft+si->xTimes, (i+1)*si->font->ta_YSize+si->WTop);
	    }

	    while (!done) {
		Wait(1L << w->UserPort->mp_SigBit);
		while ((imsg=GT_GetIMsg(w->UserPort)) && (!done)) {
		    Class = imsg->Class;
		    g = (struct Gadget *) imsg->IAddress;
		    GT_ReplyIMsg(imsg);
		    switch (Class) {

		    case IDCMP_GADGETUP:
			if (g->GadgetID==DA_GO_ON) done=TRUE;
			break;

		    case IDCMP_CLOSEWINDOW:
			done=TRUE;
			break;

		    case IDCMP_REFRESHWINDOW:
			GT_BeginRefresh(w);
			GT_EndRefresh(w, TRUE);
			break;

		    default:
			break;

		    }
		}
	    }

	    CloseWindow(w);
	}

    }

    FreeGadgets(glist);

#endif

    DBUG_VOID_RETURN;
}

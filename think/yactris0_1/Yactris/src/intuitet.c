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
**  intuitet.c
**
**  If it has to to with Tetris and intuition display, it's probably here
**
*/

/*  Changes for 0.1

    Altered routine to find an appropriate xSize and ySize to use C= aspect info.

    Added parameters to OpenPWindow() and InquirePubScreen() so their windows now
    open relative to the YacTris window.
*/

/**************/
/*  Includes  */
/**************/
#include <exec/types.h>
#include <exec/memory.h>
#include <dos/dos.h>
#include <graphics/displayinfo.h>
#include <intuition/intuition.h>
#include <intuition/screens.h>
#include <libraries/gadtools.h>
#include <utility/tagitem.h>
#include <clib/macros.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <math.h>
#include "dbug/dbug.h"
#include "yactris.h"
#include "bruce.h"


/****************/
/*  Prototypes	*/
/****************/

#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/gadtools_protos.h>

Prototype struct ScreenInfo *CreateScrInfo(struct Screen *);
Prototype struct Window *OpenTWindow(struct ScreenInfo *, struct Menu *, LONG, LONG);
Prototype void CloseTWindow(struct Window *);
Prototype void FlagWindow(struct Window *, BOOL);
Prototype void UpdateScores(struct Window *, struct ScreenInfo *, int, int, int);
Prototype struct Screen *InquirePubScreen(struct ScreenInfo *, struct Window *tw);
Prototype struct List *MakePubScrList(void);
Prototype void FreePubScrList(struct List *);
Prototype struct Window *OpenPWindow(struct ScreenInfo *, struct MsgPort *, struct Window *tw);
Prototype void ClosePWindow(struct Window *);
Prototype void DispPCount(struct ScreenInfo *, struct Window *, struct PieceRot *, int);
Prototype void FreeScrInfo(struct ScreenInfo *);

const char ScrTitle[] = "YacTris v0.0";

/*
**  Scoring IntuiTexts
*/
    static UBYTE LevelT[4], ScoreT[16], LinesT[16];

#define NUMSCORETEXTS 6

static struct IntuiText ScoreTexts[NUMSCORETEXTS] = {
    { 0,0,JAM1,0,0,NULL,"Level:",   &ScoreTexts[1] },
    { 0,0,JAM1,0,0,NULL,LevelT,     &ScoreTexts[2] },
    { 0,0,JAM1,0,0,NULL,"Score:",   &ScoreTexts[3] },
    { 0,0,JAM1,0,0,NULL,ScoreT,     &ScoreTexts[4] },
    { 0,0,JAM1,0,0,NULL,"Lines:",   &ScoreTexts[5] },
    { 0,0,JAM1,0,0,NULL,LinesT,     NULL }
};

static struct IntuiText NextText =
    { 0,0,JAM1,0,0,NULL,"Next:",    NULL };

static UBYTE pText[8];

static struct IntuiText pIText =
    { 0,0,JAM1,0,0,NULL,pText,	    NULL };

/*
**  Window IDCMP Flags
*/
#define IDCMPFALSE  IDCMP_MENUPICK|IDCMP_CLOSEWINDOW
#define IDCMPTRUE   IDCMPFALSE|IDCMP_INTUITICKS|IDCMP_VANILLAKEY

/*
**
**  CloseTWindow
**
*/
void CloseTWindow(struct Window *tw)
{
    ClearMenuStrip(tw);
    CloseWindow(tw);
}

/*
**
**  OpenTWindow()
**
**  Open a Tetris window on the passed screen at the passed location.
**
*/
struct Window *OpenTWindow(
    struct ScreenInfo *si,
    struct Menu *tm,
    LONG ox, LONG oy)
{
    struct Window *w;

    DBUG_ENTER("OpenTWindow");

    DBUG_PRINT("OpenTW",("Initial X: %d.  Initial Y:  %d.",ox,oy));

    /*	Open the window  */
    if (w=OpenWindowTags(NULL, (Tag)
	WA_Left,	    ox,
	WA_Top, 	    oy,
	WA_Width,	    si->WinWidth,
	WA_Height,	    si->WinHeight,
	WA_MinWidth,	    si->WinWidth,
	WA_MinHeight,	    si->WinHeight,
	WA_MaxWidth,	    si->WinWidth,
	WA_MaxHeight,	    si->WinHeight,
	WA_IDCMP,	    IDCMPFALSE,
	WA_Title,	    "YacTris",
	WA_ScreenTitle,     ScrTitle,
	WA_PubScreen,	    si->s,
	WA_DragBar,	    TRUE,
	WA_DepthGadget,     TRUE,
	WA_CloseGadget,     TRUE,
	WA_NoCareRefresh,   TRUE,
	WA_Activate,	    TRUE,
	WA_SmartRefresh,    TRUE,
	TAG_DONE)) {

	DBUG_PRINT("OTW",("Window Opened"));

	/*  Add the Menu strip	*/
	if (!SetMenuStrip(w, tm)) ByeBye(RETURN_WARN);

	DBUG_PRINT("OTW",("Menu Strip Added"));

	/*  Draw the BevelBox around the playing field.  */
	DrawBevelBox(w->RPort, si->FieldInLeft-2, si->FieldInTop-1,
	    si->FieldInWidth+4, si->FieldInHeight+2,
	    GTBB_Recessed,  TRUE,
	    GT_VisualInfo,  si->vi,
	    TAG_END);

	/*  Draw the BevelBox around the next piece field.  */
	DrawBevelBox(w->RPort, si->NextInLeft-2, si->NextInTop-1,
	    si->NextInWidth+4, si->NextInHeight+2,
	    GTBB_Recessed,  TRUE,
	    GT_VisualInfo,  si->vi,
	    TAG_END);

	/*  Add the "Next:" text  */
	PrintIText(w->RPort, si->NextText, si->NextInLeft, si->NextInTop);

    }

    DBUG_RETURN(w);
}

/*
**
**  CreateScrInfo()
**
**  Using the current tScreen as a pointer to a Screen structure, update all
**  the fields in the ScreenInfo structure, which seems to be where I keep all
**  sorts of fun information.
**
*/
struct ScreenInfo *CreateScrInfo(struct Screen *s)
{
    struct DrawInfo *drawInfo;
    struct DisplayInfo dispInfo;
    struct DimensionInfo dimInfo;
    struct ScreenInfo *sInfo;

    ULONG modeID;

    int i;

    DBUG_ENTER("CreateScrInfo");

    if (!(sInfo = AllocMem(sizeof(struct ScreenInfo),MEMF_CLEAR)))
	DBUG_RETURN(NULL);

    drawInfo = GetScreenDrawInfo(s);
    modeID = GetVPModeID(&s->ViewPort);

    /*	Screen Address	*/
    sInfo->s = s;

    /*	Graphics Information  */
    sInfo->planes = s->BitMap.Depth;

    if (!GetDisplayInfoData(NULL, (UBYTE *)&dimInfo,
	    sizeof (struct DimensionInfo), DTAG_DIMS, modeID))
	ByeBye(RETURN_WARN);

    if (!GetDisplayInfoData(NULL, (UBYTE *)&dispInfo,
	    sizeof (struct DisplayInfo), DTAG_DISP, modeID))
	ByeBye(RETURN_WARN);


    /*	This method of sizing was suggested by Olaf 'Olsen' Barthel */
    sInfo->xTimes = (6 * (dimInfo.Nominal.MaxX-dimInfo.Nominal.MinX+1))/320;
    sInfo->yTimes = sInfo->xTimes * dispInfo.Resolution.x / dispInfo.Resolution.y;
    sInfo->xTimes += sInfo->xTimes % 2;
    sInfo->yTimes += sInfo->yTimes % 2;

    DBUG_PRINT("crscinfo",("xTimes: %d.  yTimes: %d.",sInfo->xTimes,sInfo->yTimes));

/*  This is how I used to do it, in case anyone's curious.
    sInfo->xTimes = 24;
    if (dimInfo.Nominal.MaxX-dimInfo.Nominal.MinX < 1279) sInfo->xTimes = 12;
    if (dimInfo.Nominal.MaxX-dimInfo.Nominal.MinX < 639 ) sInfo->xTimes = 6;
    sInfo->yTimes = dispInfo.PropertyFlags & DIPF_IS_LACE ? 12 : 6;
*/

    sInfo->pens[BACK] = drawInfo->dri_Pens[BACKGROUNDPEN];
    sInfo->pens[SHINE] = drawInfo->dri_Pens[SHINEPEN];
    sInfo->pens[SHADOW] = drawInfo->dri_Pens[SHADOWPEN];
    sInfo->pens[FILL] = drawInfo->dri_Pens[FILLPEN];
    sInfo->font = s->Font;

    /*	Window Dimensions  */
    sInfo->WTop = s->WBorTop + s->Font->ta_YSize + 1;
    sInfo->WBot = s->WBorBottom;
    sInfo->WLeft = s->WBorLeft;
    sInfo->WRight = s->WBorRight;

    /*	GadTools Stuff	*/
    sInfo->vi = GetVisualInfo(s, TAG_END);

    /*	Playing Field Location	*/
    sInfo->FieldInLeft = sInfo->WLeft + sInfo->xTimes;
    sInfo->FieldInTop = sInfo->WTop + sInfo->yTimes;
    sInfo->FieldInWidth = FWIDTH * sInfo->xTimes;
    sInfo->FieldInHeight = FHEIGHT * sInfo->yTimes;

    /*	Next Piece Box Location and Text Info  */
    sInfo->NextInLeft = sInfo->WLeft + (FWIDTH+2) * sInfo->xTimes;
    sInfo->NextInTop = sInfo->WTop + sInfo->yTimes;

    sInfo->NextText = &NextText;
    sInfo->NextText->FrontPen = sInfo->pens[SHADOW];
    sInfo->NextText->BackPen = sInfo->pens[BACK];
    sInfo->NextText->ITextFont = sInfo->font;

    sInfo->NextInWidth = MAX(i=IntuiTextLength(sInfo->NextText),4*sInfo->xTimes) +
			    2*sInfo->xTimes;
    sInfo->NextInHeight = sInfo->font->ta_YSize + 7*sInfo->yTimes;

    sInfo->NextText->LeftEdge = (sInfo->NextInWidth-i)/2;
    sInfo->NextText->TopEdge = sInfo->yTimes;

    /*	Where to blit the next piece  */
    sInfo->NPTop = sInfo->NextInTop+sInfo->font->ta_YSize + 2*sInfo->yTimes;
    sInfo->NPLeft = sInfo->NextInLeft+(sInfo->NextInWidth-4*sInfo->xTimes)/2;

    /*	Scores display Information  */
    sInfo->ScoreTexts = ScoreTexts;
    for (i=0, sInfo->ScoreWidth=0; i<NUMSCORETEXTS; i += 2)
	sInfo->ScoreWidth =
	    MAX(sInfo->ScoreWidth, IntuiTextLength(&sInfo->ScoreTexts[i]));
    sprintf(ScoreT, "%d", 50000);
    sInfo->ScoreWidth =
	MAX(sInfo->ScoreWidth, IntuiTextLength(&sInfo->ScoreTexts[3]));

    sInfo->ScoreLeft = (sInfo->ScoreWidth<sInfo->NextInWidth) ?
	sInfo->NextInLeft+(sInfo->NextInWidth-sInfo->ScoreWidth)/2 :
	sInfo->NextInLeft;

    sInfo->ScoreTop = sInfo->NextInTop + 7*sInfo->xTimes + 3*sInfo->font->ta_YSize;
    sInfo->ScoreHeight = 8*sInfo->font->ta_YSize;

    for (i=0; i<NUMSCORETEXTS; i++) {
	sInfo->ScoreTexts[i].FrontPen = sInfo->pens[SHADOW];
	sInfo->ScoreTexts[i].BackPen = sInfo->pens[BACK];
	sInfo->ScoreTexts[i].ITextFont = sInfo->font;
	if (!(i%2)) sInfo->ScoreTexts[i].LeftEdge =
	    (sInfo->ScoreWidth-IntuiTextLength(&sInfo->ScoreTexts[i]))/2;
	sInfo->ScoreTexts[i].TopEdge = sInfo->font->ta_YSize * floor(i * 3/2);
    }

    /*	Window dimensions  */
    sInfo->WinWidth = sInfo->WLeft + sInfo->WRight + (FWIDTH+3)*sInfo->xTimes +
	MAX(sInfo->NextInWidth, sInfo->ScoreWidth);
    sInfo->WinHeight = sInfo->WTop + sInfo->WBot + 2*sInfo->yTimes +
	MAX( FHEIGHT * sInfo->yTimes, sInfo->ScoreTop + sInfo->ScoreHeight);

    /*	pWindow Stuff  */

    i=MAX(sInfo->font->ta_YSize, 2*sInfo->yTimes);

    /*	pWindow IntuiText  */
    sInfo->pIText = &pIText;
    sInfo->pIText->FrontPen = sInfo->pens[SHADOW];
    sInfo->pIText->BackPen = sInfo->pens[BACK];
    sInfo->pIText->LeftEdge = 5*sInfo->xTimes;
    sInfo->pIText->TopEdge = (i - sInfo->font->ta_YSize)/2;
    sInfo->pIText->ITextFont = sInfo->font;

    sprintf(pText,"%d",222);

    sInfo->pxOffset = sInfo->WLeft + sInfo->xTimes;
    sInfo->pyOffset = sInfo->WTop + sInfo->yTimes;

    sInfo->pxMult = 6*sInfo->xTimes + IntuiTextLength(sInfo->pIText);
    sInfo->pyMult = i + sInfo->yTimes;
    sInfo->pBMDown = (i - 2*sInfo->yTimes)/2;

    sInfo->pWidth = sInfo->pxOffset + 2*sInfo->pxMult + sInfo->WRight;
    sInfo->pHeight = sInfo->pyOffset + 4*sInfo->pyMult + sInfo->WBot;

    FreeScreenDrawInfo(s, drawInfo);

    DBUG_RETURN(sInfo);
}

/*
**
**  FlagWindow()
**
**  Modify the active/ghosted flags depending on whether Tetris is active or not.
**
*/
void FlagWindow(struct Window *tw, BOOL active)
{
    DBUG_ENTER("FlagWindow");

    if (active) {
	OffMenu(tw, FULLMENUNUM(0, 0, NOSUB));
	OnMenu(tw, FULLMENUNUM(0, 1, NOSUB));
	ModifyIDCMP(tw, IDCMPTRUE);
    } else {
	OnMenu(tw, FULLMENUNUM(0, 0, NOSUB));
	OffMenu(tw, FULLMENUNUM(0, 1, NOSUB));
	ModifyIDCMP(tw, IDCMPFALSE);
    }

    DBUG_VOID_RETURN;
}

/*
**
**  UpdateScores
**
**  Print the current scores in the Scoring window
**
*/
void UpdateScores(struct Window *tw, struct ScreenInfo *si, int lev, int sc, int lin)
{
    int i;

    DBUG_ENTER("UpdateScores");


    sprintf(LevelT, "%d", lev);
    sprintf(ScoreT, "%d", sc);
    sprintf(LinesT, "%d", lin);

    for (i=1; i<NUMSCORETEXTS; i+=2)
	si->ScoreTexts[i].LeftEdge =
	    (si->ScoreWidth-IntuiTextLength(&si->ScoreTexts[i]))/2;

    DBUG_PRINT("US",("IntuiTexts initialized."));

    EraseRect(tw->RPort,si->ScoreLeft, si->ScoreTop,
	    si->ScoreLeft + si->ScoreWidth-1,
	    si->ScoreTop + si->ScoreHeight-1);

    DBUG_PRINT("US",("Rectangle cleared."));

    PrintIText(tw->RPort, si->ScoreTexts, si->ScoreLeft, si->ScoreTop);

    DBUG_PRINT("US",("Score Printed."));

    DBUG_VOID_RETURN;
}

/*
**
**  InquirePubScreen
**
**  Returns the a pointer to a new, locked public screen to open the new window,
**  or null if the Screen is the same as current or not selected.
**
*/
#define LV  (0)
#define OK  (1)
#define CAN (2)

struct Screen *InquirePubScreen(struct ScreenInfo *si, struct Window *tw)
{
    struct Screen *newScreen = NULL;

    struct List *myList;
    struct Node *myNode;

    struct Window *lvw;
    struct Gadget *glist=NULL, *pgad, *lv;
    struct NewGadget newgad;

    int listcount = 0;

    BOOL done = FALSE;
    int whichps = -1;
    struct IntuiMessage *inMsg;
    ULONG Class;
    UWORD Code;
    struct Gadget *Object;
    ULONG oSeconds = 0, oMicros = 0;
    ULONG Seconds = 0, Micros = 0;

    struct EasyStruct es = {
	sizeof (struct EasyStruct), 0,
	"YacTris",
	"Unable to open Public Screen %s",
	"Try Another"
    };

    int i;

    DBUG_ENTER("InquirePubScreen");

    if (myList = MakePubScrList()) {

    for (myNode = myList->lh_Head; myNode->ln_Succ; myNode = myNode->ln_Succ) {
	listcount++;
	DBUG_PRINT("IPS",("Public Screen %s",myNode->ln_Name));
    }

    newgad.ng_LeftEdge = si->WLeft+2*si->xTimes;
    newgad.ng_TopEdge = si->WTop+2*si->font->ta_YSize;
    newgad.ng_Width = 30*si->xTimes;
    newgad.ng_Height = 10*si->font->ta_YSize;
    newgad.ng_GadgetText = "_Public Screens";
    newgad.ng_TextAttr = si->font;
    newgad.ng_GadgetID = LV;
    newgad.ng_Flags = 0;
    newgad.ng_VisualInfo = si->vi;
    newgad.ng_UserData = NULL;

    pgad = CreateContext(&glist);

    lv = pgad = CreateGadget(LISTVIEW_KIND, pgad, &newgad, (Tag)
		GT_Underscore,	    '_',
		GTLV_Labels,	    myList,
		GTLV_ShowSelected,  NULL,
		TAG_END);

    newgad.ng_TopEdge = si->WTop+13*si->font->ta_YSize;
    newgad.ng_Width = 10*si->xTimes;
    newgad.ng_Height = 2*si->font->ta_YSize;
    newgad.ng_GadgetText = "_OK";
    newgad.ng_GadgetID = OK;
    newgad.ng_Flags = PLACETEXT_IN;

    pgad = CreateGadget(BUTTON_KIND, pgad, &newgad, GT_Underscore, '_', TAG_END);

    newgad.ng_LeftEdge = si->WLeft+22*si->xTimes;
    newgad.ng_GadgetText = "_Cancel";
    newgad.ng_GadgetID = CAN;

    pgad = CreateGadget(BUTTON_KIND, pgad, &newgad, GT_Underscore, '_', TAG_END);

    if (pgad) {

    if (lvw = OpenWindowTags(NULL, (Tag)
		WA_Left,	    tw->LeftEdge + 20,
		WA_Top, 	    tw->TopEdge + 10,
		WA_Width,	    si->WLeft+si->WRight+34*si->xTimes,
		WA_Height,	    si->WTop+si->WBot+16*si->font->ta_YSize,
		WA_MinWidth,	    si->WLeft+si->WRight+34*si->xTimes,
		WA_MinHeight,	    si->WTop+si->WBot+16*si->font->ta_YSize,
		WA_MaxWidth,	    si->WLeft+si->WRight+34*si->xTimes,
		WA_MaxHeight,	    si->WTop+si->WBot+16*si->font->ta_YSize,
		WA_IDCMP,	    BUTTONIDCMP|LISTVIEWIDCMP|
				    IDCMP_CLOSEWINDOW|IDCMP_REFRESHWINDOW|
				    IDCMP_VANILLAKEY,
		WA_Gadgets,	    glist,
		WA_Title,	    "Select a new screen",
		WA_ScreenTitle,     "YacTris v0.0",
		WA_PubScreen,	    si->s,
		WA_DragBar,	    TRUE,
		WA_DepthGadget,     TRUE,
		WA_CloseGadget,     TRUE,
		WA_ReportMouse,     TRUE,
		WA_Activate,	    TRUE,
		WA_SimpleRefresh,   TRUE,
		WA_AutoAdjust,	    TRUE)) {

    GT_RefreshWindow(lvw, NULL);

    do {

	while (!done) {
	    Wait(1L << lvw->UserPort->mp_SigBit);
	    while (inMsg = GT_GetIMsg(lvw->UserPort)) {
		Code = inMsg->Code;
		Class = inMsg->Class;
		Object = inMsg->IAddress;
		oSeconds = Seconds;
		oMicros = Micros;
		Seconds = inMsg->Seconds;
		Micros = inMsg->Micros;
		GT_ReplyIMsg(inMsg);
		switch(Class) {

		case IDCMP_CLOSEWINDOW:
		    whichps = -1;
		    done = TRUE;
		    break;

		case IDCMP_GADGETUP:
		    switch (Object->GadgetID) {

		    case LV:
			if (Code==whichps &&
				DoubleClick(oSeconds, oMicros, Seconds, Micros))
			{
			    done = TRUE;
			} else {
			    whichps = Code;
			    DBUG_PRINT("IPS",("Currently Screen %d Selected",whichps));
			}
			break;

		    case CAN:
			whichps = -1;
		    case OK:
			done = TRUE;
			break;

		    default:
			break;
		    }
		    break;

		case IDCMP_REFRESHWINDOW:
		    GT_BeginRefresh(lvw);
		    GT_EndRefresh(lvw, TRUE);
		    break;

		case IDCMP_VANILLAKEY:
		    switch (Code) {

		    case 'c': case 'C':
			whichps = -1;

		    case 'o': case 'O':
			done = TRUE;
			break;

		    case 'p':
			if (whichps == -1) whichps = 0;
			else if (whichps < listcount-1) whichps++;
			GT_SetGadgetAttrs(lv, lvw, NULL, GTLV_Selected, whichps);
			break;

		    case 'P':
			if (whichps == -1) whichps = listcount - 1;
			else if (whichps > 0) whichps--;
			GT_SetGadgetAttrs(lv, lvw, NULL, GTLV_Selected, whichps);
			break;
		    }
		    break;

		default:
		    break;

		}
	    }
	}

    DBUG_PRINT("IPS",("Screen %d selected",whichps));

	if (whichps != -1) {

	    for (i=0, myNode = myList->lh_Head; i<whichps && myNode->ln_Succ;
		    i++, myNode = myNode->ln_Succ);

	    if (!(newScreen=LockPubScreen(myNode->ln_Name))) {
		struct List *l2;

		DBUG_PRINT("IPS",("Locking screen %s", myNode->ln_Name));
		EasyRequest(lvw, &es, NULL, myNode->ln_Name);
		l2 = MakePubScrList();
		GT_SetGadgetAttrs(lv, lvw, NULL,
			GTLV_Labels, l2, TAG_END, 0);
		FreePubScrList(myList);
		myList = l2;
		for (myNode = myList->lh_Head, listcount=0; myNode->ln_Succ;
			myNode = myNode->ln_Succ
		) {
		    listcount++;
		    DBUG_PRINT("IPS",("Public Screen %s",myNode->ln_Name));
		}
		done = FALSE;
	    }

	} else newScreen = NULL;

    } while (!done);

    if (newScreen==si->s) newScreen = NULL;

    CloseWindow(lvw);
    }

    FreeGadgets(glist);
    }

    FreePubScrList(myList);
    }

    DBUG_PRINT("IPS",("Address Returned: %p", newScreen));

    DBUG_RETURN(newScreen);

}

/*
**
**  MakePubScrList()
**
**  Construct a list of Public screen names
**
*/
struct List *MakePubScrList(void)
{
    struct List *myList;
    struct List *psList;
    struct Node *psNode;
    struct Node *myNode;

    BOOL fail = FALSE;

    DBUG_ENTER("MakePubScrList");

    if (!(myList = AllocMem(sizeof(struct List),MEMF_CLEAR)))
	DBUG_RETURN(NULL);

    /*	Initialize the list  */
    myList->lh_Head = (struct Node *) &myList->lh_Tail;
    myList->lh_Tail = NULL;
    myList->lh_TailPred = (struct Node *) &myList->lh_Head;

    psList = (struct List *) LockPubScreenList();

    for (psNode=psList->lh_Head; psNode->ln_Succ; psNode=psNode->ln_Succ) {

	DBUG_PRINT("MPSL",("Creating entry for %s",psNode->ln_Name));

	if (!(myNode = AllocMem(sizeof(struct Node),MEMF_CLEAR))) {
	    fail = TRUE;
	    break;
	}
	if (!(myNode->ln_Name = AllocMem(MAXPUBSCREENNAME,MEMF_CLEAR))) {
	    fail = TRUE;
	    FreeMem(myNode, sizeof(struct Node));
	    break;
	}
	strcpy(myNode->ln_Name, psNode->ln_Name);
	AddTail(myList, myNode);

    }

    UnlockPubScreenList();

    if (fail) {
	FreePubScrList(myList);
	DBUG_RETURN(NULL);
    }

    DBUG_RETURN(myList);
}

/*
**
**  FreePubScrList()
**
**  Free the list of Public Screen names
**
*/
void FreePubScrList(struct List *l)
{
    struct Node *n;

    DBUG_ENTER("FreePubScrList");

    for ( n=RemTail(l); n; n=RemTail(l) ) {
	DBUG_PRINT("FPSL",("Freeing entry for %s",n->ln_Name));
	FreeMem(n->ln_Name,MAXPUBSCREENNAME);
	FreeMem(n, sizeof(struct Node));
    }

    DBUG_PRINT("FPSL",("Freeing List Structure"));
    FreeMem(l, sizeof(struct List));

    DBUG_VOID_RETURN;
}

/*
**
**  OpenPWindow()
**
**  Open the window that the piece count will be displayed in.
**
*/
struct Window *OpenPWindow(struct ScreenInfo *si, struct MsgPort *mp, struct Window *tw)
{
    struct Window *w;

    DBUG_ENTER("OpenPWindow");

    if (w=OpenWindowTags(NULL, (Tag)
	WA_Left,	    tw->LeftEdge + si->WinWidth + 2*si->xTimes,
	WA_Top, 	    tw->TopEdge,
	WA_Width,	    si->pWidth,
	WA_Height,	    si->pHeight,
	WA_MinWidth,	    si->pWidth,
	WA_MinHeight,	    si->pHeight,
	WA_MaxWidth,	    si->pWidth,
	WA_MaxHeight,	    si->pHeight,
	WA_Title,	    "YacTris Piece Counts",
	WA_ScreenTitle,     ScrTitle,
	WA_PubScreen,	    si->s,
	WA_CloseGadget,     TRUE,
	WA_DragBar,	    TRUE,
	WA_DepthGadget,     TRUE,
	WA_NoCareRefresh,   TRUE,
	WA_SmartRefresh,    TRUE,
	TAG_DONE)) {

	w->UserPort = mp;

	ModifyIDCMP(w, IDCMP_CLOSEWINDOW);

    }

    DBUG_RETURN(w);
}

/*
**
**  ClosePWindow()
**
**  Close the Pieces window safely
**
*/
void ClosePWindow(struct Window *pw)
{
    struct IntuiMessage *msg;
    struct Node *succ;

    DBUG_ENTER("ClosePWindow");

    Forbid();

    msg = (struct IntuiMessage *) pw->UserPort->mp_MsgList.lh_Head;

    while (succ = msg->ExecMessage.mn_Node.ln_Succ) {
	if (msg->IDCMPWindow == pw) {
	    Remove((struct Node *) msg);
	    ReplyMsg((struct Message *) msg);
	}
	msg = (struct IntuiMessage *) succ;
    }

    pw->UserPort=NULL;
    ModifyIDCMP(pw, 0L);

    Permit();

    CloseWindow(pw);

    DBUG_VOID_RETURN;
}

/*
**
**  DispPCount()
**
**  Display the count for piece number P, including its BitMap
**
*/
void DispPCount(struct ScreenInfo *sInfo, struct Window *w,
	struct PieceRot *p, int count)
{
    int x,y;

    DBUG_ENTER("DispPCount");

    x = sInfo->pxOffset + floor(p->type/4) * sInfo->pxMult;
    y = sInfo->pyOffset + (p->type % 4) * sInfo->pyMult;

    EraseRect(w->RPort, x, y, x+sInfo->pxMult-1, y+sInfo->pyMult-1);

    BltBitMapRastPort(&p->BitMap, 0,0, w->RPort, x+sInfo->pBMDown,y,
	    4*sInfo->xTimes, 2*sInfo->yTimes, 0xc0);

    sprintf(pText, "%d", count);
    PrintIText(w->RPort, sInfo->pIText, x, y);

    DBUG_VOID_RETURN;
}

/*
**
**  FreeScrInfo()
**
**  The name says it all
**
*/
void FreeScrInfo(struct ScreenInfo *si)
{
    DBUG_ENTER("FreeScreenInfo");

    FreeVisualInfo(si->vi);

    FreeMem(si, sizeof(struct ScreenInfo));

    DBUG_VOID_RETURN;
}

/*
    YacTris v0.1
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
**  yactris.c
**
**  The definitive Tetris for AmigaDOS 2.0
**
**  Jonathan Springer
**
**  v 0.0
**
*/

/*  Changes for 0.1

    Added support for ToolTypes initial window position (suggested by Peter
	Eriksson).  This required adding a parameter to OpenPWindow() and
	InquirePubScreen().
*/

#include <exec/types.h>
#include <exec/memory.h>
#include <exec/ports.h>
#include <dos/dos.h>
#include <graphics/displayinfo.h>
#include <graphics/gfxmacros.h>
#include <intuition/intuition.h>
#include <intuition/screens.h>
#include <libraries/gadtools.h>
#include <utility/tagitem.h>
#include <workbench/startup.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "dbug/dbug.h"
#include "yactris.h"
#include "bruce.h"

/****************/
/*  Prototypes	*/
/****************/

#include <clib/dos_protos.h>
#include <clib/exec_protos.h>
#include <clib/icon_protos.h>
#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/layers_protos.h>

Prototype void TStartUp(void);
Prototype void Tetris(void);
Prototype struct PieceRot *PickPiece(void);
Prototype void ClearPlayField(void);
Prototype BOOL NewPiece(struct PieceRot *, int, int);
Prototype BOOL MovePiece(enum direction);
Prototype BOOL RotatePiece(void);
Prototype void ByeBye(int);
Prototype void PlacePiece(void);
Prototype BOOL GameOver(void);
Prototype void ResetTet(void);
Prototype void FillInTWindow(struct Window *, struct ScreenInfo *);
Prototype BOOL IsHitting(struct PieceRot *, int, int);
Prototype void DoNewPubScreen(struct Screen *news);
Prototype BOOL VerifyQuit(void);
Prototype int NoBreak(void);

enum direction {left, down, right, null};

/***********************/
/*  Piece Definitions  */
/***********************/

const UBYTE Multi[] =
/*    0  0  0  0  0  0	0  0  0  0  1  1  1  1	1  1  1  1  1  1  2  2
      0  1  2  3  4  5	6  7  8  9  0  1  2  3	4  5  6  7  8  9  0  1	  */

    { 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1 };

extern struct MakeStruct LineM0[], LineM1[], BlockM[], TeeM0[], TeeM1[],
    TeeM2[], TeeM3[], ZigM0[], ZigM1[], ZagM0[], ZagM1[], EllM0[], EllM1[],
    EllM2[], EllM3[], LeeM0[], LeeM1[], LeeM2[], LeeM3[];

struct PieceRot Line[2] = {
    { LINE, &Line[1], {0}, 4, 1, &Multi[4], LineM0 },
    { LINE, Line, {0}, 1, 4, &Multi[4], LineM1 }
};

struct PieceRot Block = { BLOCK, &Block, {0}, 2, 2, &Multi[4], BlockM };

struct PieceRot Tee[4] = {
    { TEE, &Tee[1], {0}, 3, 2, &Multi[9], TeeM0 },
    { TEE, &Tee[2], {0}, 2, 3, &Multi[10], TeeM1 },
    { TEE, &Tee[3], {0}, 3, 2, &Multi[12], TeeM2 },
    { TEE, Tee, {0}, 2, 3, &Multi[11], TeeM3 }
};

struct PieceRot Zig[2] = {
    { ZIG, &Zig[1], {0}, 3, 2, Multi, ZigM0 },
    { ZIG, Zig, {0}, 2, 3, &Multi[3], ZigM1 }
};

struct PieceRot Zag[2] = {
    { ZAG, &Zag[1], {0}, 3, 2, &Multi[3], ZagM0 },
    { ZAG, Zag, {0}, 2, 3, &Multi[16], ZagM1 }
};

struct PieceRot Ell[4] = {
    { ELL, &Ell[1], {0}, 3, 2, &Multi[2], EllM0 },
    { ELL, &Ell[2], {0}, 2, 3, &Multi[14], EllM1 },
    { ELL, &Ell[3], {0}, 3, 2, &Multi[4], EllM2 },
    { ELL, Ell, {0}, 2, 3, &Multi[13], EllM3 }
};

struct PieceRot Lee[4] = {
    { LEE, &Lee[1], {0}, 3, 2, &Multi[1], LeeM0 },
    { LEE, &Lee[2], {0}, 2, 3, &Multi[12], LeeM1 },
    { LEE, &Lee[3], {0}, 3, 2, &Multi[5], LeeM2 },
    { LEE, Lee, {0}, 2, 3, &Multi[9], LeeM3 }
};

struct BitMap Sqbm = {0};

struct PieceRot *Pieces[NUM_TYPES] = { Line, &Block, Tee, Zig, Zag, Ell, Lee };
int PieceCount[NUM_TYPES] = {0};

/**********************/
/*  Menu Definitions  */
/**********************/

struct NewMenu tNewMenu[] = {
    { NM_TITLE, "Game",          0 ,    0,  0,  0 },
    {  NM_ITEM, "Start",        "S",    0,  0,  0 },
    {  NM_ITEM, "Halt",         "H",    0,  0,  0 },
    {  NM_ITEM, "Reset",        "R",    0,  0,  0 },
    {  NM_ITEM, NM_BARLABEL,	 0 ,	0,  0,	0 },
    {  NM_ITEM, "About...",     "?",    0,  0,  0 },
    {  NM_ITEM, NM_BARLABEL,	 0 ,	0,  0,	0 },
    {  NM_ITEM, "Quit...",      "Q",    0,  0,  0 },
    { NM_TITLE, "Display",       0 ,    0,  0,  0 },
    {  NM_ITEM, "Show Next",     0 ,    CHECKIT|CHECKED|MENUTOGGLE, 0, 0},
    {  NM_ITEM, "Show Piece Count", 0,   CHECKIT|MENUTOGGLE, 0, 0},
    {  NM_ITEM, NM_BARLABEL,	 0 ,	0,  0,	0 },
    {  NM_ITEM, "New Screen...","P",    0,  0,  0 },
    {	NM_END, NULL,		 0 ,	0,  0,	0 }
};

/***********************/
/*  The Playing Field  */
/***********************/
UBYTE Field[FWIDTH][FHEIGHT] = {0};

/***************/
/*  The Piece  */
/***************/
struct PieceRot *Piece=NULL, *Next=NULL;
int Px, Py;

/***************/
/*  The Score  */
/***************/

int StartLev = 0;
const int CapLev = 11;
int Level;
int Lines = 0;
int Score = 0;
int Lin2Inc = 10;
BOOL ShowNext = TRUE;

char *StartScreen = NULL;
char ss[MAXPUBSCREENNAME];

/***********************/
/*  System Structures  */
/***********************/

struct Window *tWindow = NULL;
struct Window *pWindow = NULL;
struct Screen *tScreen = NULL;
struct Menu *tMenus = NULL;
struct ScreenInfo *ScrInfo = NULL;

struct Library *IconBase;

int NoBreak(void) { return 0; }

/*********************/
/*  Window Tracking  */
/*********************/
LONG starty = 20;
LONG startx = 100;

/*
**  main()
*/

int main (int argc, char **argv) {

#ifndef DBUG_OFF
#define ARGS 6
    char template[] = "STARTLEVEL/K/N,LINESTOINC/K/N,X=STARTX/K/N,Y=STARTY/K/N,PUBSCREEN/K,D=DBUG/K/F";
#else
#define ARGS 5
    char template[] = "STARTLEVEL/K/N,LINESTOINC/K/N,X=STARTX/K/N,Y=STARTY/K/N,PUBSCREEN/K";
#endif

    ULONG argout[ARGS] = {0};
    struct RDArgs *rda = NULL;

    DBUG_ENTER("main");

#ifdef DBUG_OFF
    onbreak(NoBreak);
#endif

    DBUG_PROCESS(argv[0]);

    if (rda=ReadArgs(template, argout, NULL)) {

	if (argout[0]) StartLev = *( (LONG *) argout[0]);

	if (argout[1]) Lin2Inc = *( (LONG *) argout[1]);

	if (argout[2]) startx = *( (LONG *) argout[2]);

	if (argout[3]) starty = *( (LONG *) argout[3]);

	if (argout[4]) StartScreen = strcpy(ss, (char *) argout[4]);

#ifndef DBUG_OFF
	if (argout[5]) DBUG_PUSH( (char *) argout[5] );
#endif

    }

    if (rda) FreeArgs(rda);

    DBUG_PRINT("main",("startx: %d.  starty: %d.", startx, starty));

    TStartUp();

    exit(0);

    DBUG_RETURN(0);
}

/*
**  wbmain()
*/
int wbmain(struct WBStartup *wbs)
{
    struct DiskObject *dobj = NULL;
    char *tstr;
    BPTR olddir = -1;

    DBUG_ENTER("wbmain");

    DBUG_PROCESS(wbs->sm_ArgList->wa_Name);

    if (IconBase = OpenLibrary("icon.library",33)) {

	if (wbs->sm_ArgList->wa_Lock)
	    olddir = CurrentDir(wbs->sm_ArgList->wa_Lock);

	if (dobj=GetDiskObject(wbs->sm_ArgList->wa_Name)) {

	    if (tstr = FindToolType(dobj->do_ToolTypes, "STARTLEVEL"))
		StartLev = atoi(tstr);

	    if (tstr = FindToolType(dobj->do_ToolTypes, "LINESTOINC"))
		Lin2Inc = atoi(tstr);

	    if (tstr = FindToolType(dobj->do_ToolTypes, "PUBSCREEN"))
		StartScreen = strcpy(ss, tstr);

	    if (tstr = FindToolType(dobj->do_ToolTypes, "STARTX"))
		startx = atoi(tstr);

	    if (tstr = FindToolType(dobj->do_ToolTypes, "STARTY"))
		starty = atoi(tstr);

#ifndef DBUG_OFF
	    if (tstr = FindToolType(dobj->do_ToolTypes, "DBUG"))
		DBUG_PUSH(tstr);
#endif

	    FreeDiskObject(dobj);

	}

	if (olddir != -1) CurrentDir(olddir);

    }

    TStartUp();

    if (IconBase) CloseLibrary(IconBase);

    exit(0);

    DBUG_RETURN(0);
}

/*
**
**  TStartUp()
**
**  Start up and Tetrisize
**
*/
void TStartUp(void)
{
    struct Screen *tScreen;

    DBUG_ENTER("TStartUp");

    srand(time(NULL));

    if (!(tScreen = LockPubScreen(StartScreen)))
	tScreen = LockPubScreen(NULL);

    if (ScrInfo = CreateScrInfo(tScreen)) {

	/*  Construct the Menus  */
	if (tMenus = CreateMenus(tNewMenu, TAG_DONE)) {

	    if (LayoutMenus(tMenus, ScrInfo->vi, TAG_DONE)) {

		/*  Open the Windows  */
		if (tWindow=OpenTWindow(ScrInfo, tMenus, startx, starty)) {

		    /*	Make the Pieces  */
		    if (MakePieces(ScrInfo)) {

			ResetTet();

			/*  Do the Tetris thing  */
			Tetris();

		    }

		    UnMakePieces(ScrInfo);

		}
	    }
	}
    }

    /*	Clean Up  */
    if (pWindow) ClosePWindow(pWindow);
    if (tWindow) CloseTWindow(tWindow);
    if (tMenus) FreeMenus(tMenus);
    if (ScrInfo) {
	if (ScrInfo->s) UnlockPubScreen(NULL, ScrInfo->s);
	FreeScrInfo(ScrInfo);
    }

    DBUG_VOID_RETURN;
}

/*
**
**  Tetris()
**
**  Do the actual Tetrising
**
*/

void Tetris(void)
{
    int tickstodrop = CapLev - Level;
    BOOL active = FALSE, hitting = FALSE, over = FALSE;
    BOOL breakmenloop = FALSE;
    int tickcount = 0;
    struct IntuiMessage *inMsg;
    int i;

    UWORD Code;
    ULONG Class;
    ULONG signals;
    struct Window *IWindow;

    struct Screen *news;

    DBUG_ENTER("Tetris");

    FlagWindow(tWindow, FALSE);

    while (!over) {
	signals = Wait(1L << tWindow->UserPort->mp_SigBit);
	while ((!over) &&
		(inMsg = (struct IntuiMessage *) GetMsg(tWindow->UserPort))
	) {
	    Code = inMsg->Code;
	    Class = inMsg->Class;
	    IWindow = inMsg->IDCMPWindow;
	    ReplyMsg( (struct Message *) inMsg);
	    switch(Class) {

	    case IDCMP_MENUPICK:
		DBUG_PRINT("Tetris",("PickMenu received"));
		breakmenloop = FALSE;
		while (Code != MENUNULL) {

		switch (MENUNUM(Code)) {

		case 0:
		    if (ITEMNUM(Code)!=NOITEM) switch (ITEMNUM(Code)) {

		    case 0:
			active = TRUE;
			FlagWindow(tWindow, TRUE);
			break;
		    case 1:
			active = FALSE;
			FlagWindow(tWindow, FALSE);
			break;
		    case 2:
			ResetTet();
			active = FALSE;
			FlagWindow(tWindow, FALSE);
			tickcount = 0;
			tickstodrop = CapLev-Level;
			hitting = FALSE;
			break;
		    case 4:
			DoAbout(tWindow);
			break;
		    case 6:
			if (VerifyQuit()) breakmenloop = over = TRUE;
			break;
		    default:
			break;

		    }
		    break;

		case 1:
		    if (ITEMNUM(Code)!=NOITEM) switch (ITEMNUM(Code)) {

		    case 0:
			if (ItemAddress(tMenus, Code)->Flags & CHECKED) {
			    if (!ShowNext) ShowNext = TRUE;
			    BltBitMapRastPort(&Next->BitMap, 0, 0,
				tWindow->RPort,
				ScrInfo->NPLeft, ScrInfo->NPTop,
				4*ScrInfo->xTimes, 4*ScrInfo->yTimes, 0xc0);
			} else if (ShowNext) {
			    ShowNext = FALSE;
			    EraseRect(tWindow->RPort,
				ScrInfo->NPLeft, ScrInfo->NPTop,
				ScrInfo->NPLeft+4*ScrInfo->xTimes-1,
				ScrInfo->NPTop+4*ScrInfo->yTimes-1);
			}
			break;

		    case 1:
			if (ItemAddress(tMenus, Code)->Flags & CHECKED) {
			    if (!pWindow) {
				if (pWindow =
				    OpenPWindow(ScrInfo, tWindow->UserPort, tWindow,
				)) {
				    for (i=0; i<NUM_TYPES; i++)
					DispPCount(ScrInfo, pWindow,
					    Pieces[i], PieceCount[i]);
				} else {
				    ClearMenuStrip(tWindow);
				    ItemAddress(tMenus, Code)->Flags &=
					    ~CHECKED;
				    ResetMenuStrip(tWindow, tMenus);
				}
			    }
			} else if (pWindow) {
			    ClosePWindow(pWindow);
			    pWindow = NULL;
			}
			break;

		    case 3:
			if (news = InquirePubScreen(ScrInfo, tWindow)) {
			    DBUG_PRINT("Tetris",("Opening new window, Screen Address %p",news));
			    DoNewPubScreen(news);
			    active = FALSE;
			    FlagWindow(tWindow, FALSE);
			    tickcount = 0;
			    BltBitMapRastPort(&Piece->BitMap,0,0,
				tWindow->RPort,
				ScrInfo->FieldInLeft + Px * ScrInfo->xTimes,
				ScrInfo->FieldInTop + Py * ScrInfo->yTimes,
				Piece->width * ScrInfo->xTimes,
				Piece->height * ScrInfo->yTimes, 0x60);
			    hitting = IsHitting(Piece, Px, Py);
			    UpdateScores(tWindow, ScrInfo, Level, Score, Lines);
			    breakmenloop = TRUE;
			}

		    default:
			break;

		    }

		default:
		    break;

		}

		if (breakmenloop) Code = MENUNULL;
		else Code = ItemAddress(tMenus, Code)->NextSelect;
		}

		break;

	    case IDCMP_CLOSEWINDOW:
		DBUG_PRINT("Tetris",("CloseWindow received"));
		if (IWindow == tWindow) {
		    over = TRUE;
		} else if (IWindow == pWindow && pWindow) {
		    ClosePWindow(pWindow);
		    pWindow = NULL;
		    ClearMenuStrip(tWindow);
		    ItemAddress(tMenus, FULLMENUNUM(1,1,NOSUB))->Flags &=
			    ~CHECKED;
		    ResetMenuStrip(tWindow, tMenus);
		}
		break;

	    case IDCMP_INTUITICKS:
		if (!(tickcount = ++tickcount % tickstodrop)) {
		    if (!hitting)
			hitting=MovePiece(down);
		    else {
			PlacePiece();
			if (NewPiece(PickPiece(),STARTX,STARTY)) {
			    active=FALSE;
			    if (!( over = GameOver() )) ResetTet();
			    FlagWindow(tWindow, FALSE);
			}
			hitting = FALSE;
			tickcount = 0;
			tickstodrop = CapLev - Level;
		    }
		}
		break;

	    case IDCMP_VANILLAKEY:
		switch (Code) {

		case '4':
		    hitting=MovePiece(left);
		    break;
		case '6':
		    hitting=MovePiece(right);
		    break;
		case '2':
		    if (!hitting)
			hitting=MovePiece(down);
		    else {
			PlacePiece();
			if (NewPiece(PickPiece(),STARTX,STARTY)) {
			    active=FALSE;
			    if (!( over = GameOver() )) ResetTet();
			    FlagWindow(tWindow, FALSE);
			}
			hitting = FALSE;
			tickcount = 0;
			tickstodrop = CapLev - Level;
		    }
		    break;
		case '5':
		    hitting=RotatePiece();
		    break;
		default:
		    break;
		}
		break;

	    default:
		break;
	    }
	}
    }

    DBUG_VOID_RETURN;
}

/*
**
**  PickPiece()
**
**  Pick a piece to fall next
**
*/

struct PieceRot *PickPiece(void)
{
    struct PieceRot *p;

    DBUG_ENTER("PickPiece");

    if (!Next) Next = Pieces[rand()%NUM_TYPES];

    p = Next;
    Next = Pieces[rand() % NUM_TYPES];

    if (ShowNext) BltBitMapRastPort(&Next->BitMap, 0, 0,tWindow->RPort,
	    ScrInfo->NPLeft, ScrInfo->NPTop, 4*ScrInfo->xTimes, 4*ScrInfo->yTimes,
	    0xc0);

    DBUG_RETURN(p);
}

/*
**
**  ClearPlayField()
**
**  Clear the playfield array and clear the window display
**
*/

void ClearPlayField(void)
{
    int i, j;

    DBUG_ENTER("ClearPlayField");

    for (i=0; i<FHEIGHT; i++)
	for (j=0; j<FWIDTH; j++)
	    Field[j][i] = 0;

    EraseRect(tWindow->RPort, ScrInfo->FieldInLeft, ScrInfo->FieldInTop,
	     ScrInfo->FieldInLeft + ScrInfo->FieldInWidth - 1,
	     ScrInfo->FieldInTop + ScrInfo->FieldInHeight - 1);

    DBUG_VOID_RETURN;
}

/*
**
**  NewPiece()
**
**  Set up and display a new piece
**
*/
BOOL NewPiece(struct PieceRot *p, int x, int y)
{
    BOOL loser=FALSE;
    int i,j;

    DBUG_ENTER("NewPiece");

    Piece = p;
    Px = x;
    Py = y;


    for (i=0; i<Piece->width && !loser; i++)
	for (j=0; j<Piece->height && !loser; j++)
	    if (Piece->map[j*Piece->width+i] && Field[Px+i][Py+j]) loser=TRUE;

    BltBitMapRastPort(&Piece->BitMap,0,0, tWindow->RPort,
	ScrInfo->FieldInLeft + Px * ScrInfo->xTimes,
	ScrInfo->FieldInTop + Py * ScrInfo->yTimes,
	Piece->width * ScrInfo->xTimes, Piece->height * ScrInfo->yTimes, 0x60);

    PieceCount[p->type]++;
    if (pWindow)
	DispPCount(ScrInfo, pWindow, Pieces[p->type], PieceCount[p->type]);

    DBUG_PRINT("NP",("List drawn, loser = %d",loser));

    DBUG_RETURN(loser);
}

/*
**
**  PlacePiece()
**
**  Add the piece to the playfield
**
*/

void PlacePiece(void) {

    int i,j,k;
    int numlines;
    int lines[4];
    int add2score = 1;

    DBUG_ENTER("PlacePiece");

    /*	Add the piece to the playfield array  */
    for (i=0; i<Piece->height; i++)
	for (j=0; j<Piece->width; j++)
	    if (Piece->map[i*Piece->width+j]) Field[Px+j][Py+i] = 1;

    /*	Increment the score  */
    Score++;

    /*	And check to see if any lines are complete  */
    for (j=Py+Piece->height-1, numlines=0; j>=Py; j--) {
	for (i=0; i<FWIDTH && Field[i][j]; i++);
	if (i==FWIDTH) {
	    lines[numlines]=j;
	    DBUG_PRINT("PP",("Line %d filled.", lines[numlines]));
	    numlines++;
	}
    }

    /*	If lines have been completed  */
    if (numlines) {

	/*  Do the graphics ...  */
	for (i=0; i<numlines; i++) {
	    DBUG_PRINT("PP",("Reversing line %d", lines[i]));
	    BltBitMapRastPort(tWindow->RPort->BitMap,0,0,tWindow->RPort,
		    ScrInfo->FieldInLeft,
		    ScrInfo->FieldInTop + lines[i]*ScrInfo->yTimes,
		    ScrInfo->xTimes * FWIDTH, ScrInfo->yTimes, 0x50);
	}

	/*  The array ... */
	for (i=numlines-1; i>=0; i--) {
	    DBUG_PRINT("PP",("Cleaning array for line %d", lines[i]));
	    for (k=lines[i]; k>0; k--)
		for (j=0; j<FWIDTH; j++)
		    Field[j][k]=Field[j][k-1];
	    for (j=0; j<FWIDTH; j++)
		Field[i][0] = 0;
	}

	/*  More graphics ... */
	for (i=numlines-1; i>=0; i--) {
	    DBUG_PRINT("PP",("Scrolling over line %d", lines[i]));
	    for (j=0; j<ScrInfo->yTimes; j++)
		ScrollRaster(tWindow->RPort, 0, -1,
			ScrInfo->FieldInLeft, ScrInfo->FieldInTop,
			ScrInfo->FieldInLeft+FWIDTH*ScrInfo->xTimes-1,
			ScrInfo->FieldInTop+lines[i]*ScrInfo->yTimes+j);
	}

	/*  And increment the score properly  */
	for (i=0; i<numlines; i++) add2score *=10;
	Score += add2score;
	Lines += numlines;
	if ( (Lines>=(Level-StartLev+1)*Lin2Inc) && (Level<CapLev-1)) Level++;
    }

    UpdateScores(tWindow, ScrInfo, Level, Score, Lines);

    DBUG_VOID_RETURN;
}

/*
**
**  MovePiece()
**
**  Move the Bob to the new location, and return whether it's hitting
**
*/

BOOL MovePiece(enum direction dir)
{
    BOOL legal = TRUE, hitting = FALSE;
    int i, j;

    DBUG_ENTER("MovePiece");

    /*	Check the legality of the move	*/
    switch (dir) {

    case down:
	if (Py + Piece->height == FHEIGHT) legal=FALSE;
	for (i=0; i < Piece->width && legal; i++)
	    for (j= Piece->height - 1; j >= 0; j--)
		if (Piece->map[ j * Piece->width + i])	{
		    if (Py+j+1 >= FHEIGHT) legal=FALSE;
		    else if (Field[Px+i][Py+j+1]) legal=FALSE;
		    break;
		}
	break;

    case left:
	if (Px == 0) legal=FALSE;
	for (j=0; j < Piece->height && legal; j++)
	    for (i=0; i < Piece->width; i++)
		if (Piece->map[ j * Piece->width + i]) {
		    if (Px+i <= 0) legal=FALSE;
		    else if (Field[Px+i-1][Py+j]) legal=FALSE;
		    break;
		}
	break;

    case right:
	if (Px + Piece->width == FWIDTH) legal=FALSE;
	for (j=0; j < Piece->height && legal; j++)
	    for (i = Piece->width - 1; i >= 0; i--)
		if (Piece->map[ j * Piece->width + i]) {
		    if (Px+i+1 >= FHEIGHT) legal=FALSE;
		    else if (Field[Px+i+1][Py+j]) legal=FALSE;
		    break;
		}
	break;

    default:
	break;

    }

    if (legal) {

	/*  Remove the old image  */
	BltBitMapRastPort(&Piece->BitMap,0,0,tWindow->RPort,
		ScrInfo->FieldInLeft+ScrInfo->xTimes*Px,
		ScrInfo->FieldInTop+ScrInfo->yTimes*Py,
		Piece->width*ScrInfo->xTimes, Piece->height*ScrInfo->yTimes,
		0x20);

	switch (dir) {
	    case down:	Py++; break;
	    case left:	Px--; break;
	    case right: Px++; break;
	    default:	break;
	}

	/*  And display the new one  */
	BltBitMapRastPort(&Piece->BitMap,0,0,tWindow->RPort,
		ScrInfo->FieldInLeft+ScrInfo->xTimes*Px,
		ScrInfo->FieldInTop+ScrInfo->yTimes*Py,
		Piece->width*ScrInfo->xTimes, Piece->height*ScrInfo->yTimes,
		0x60);

    }

    hitting = IsHitting(Piece, Px, Py);

    DBUG_PRINT("MP",("Piece Moved, hitting=%d",hitting));

    DBUG_RETURN(hitting);
}

/*
**
**  PieceRot()
**
**  Rotate the piece 1/4 turn clockwise
**
*/
BOOL RotatePiece(void)
{
    struct PieceRot *np;
    int nx, ny;
    int i, j;
    BOOL legal = TRUE, hitting = FALSE;

    DBUG_ENTER("RotatePiece");

    np = Piece->next;
    nx = Px;
    ny = Py;

    while (nx + np->width > FWIDTH) nx--;

    if (ny + np->height > FHEIGHT) legal = FALSE;
    else for (i=0; i < np->width && legal; i++)
	for (j = np->height - 1; j >= 0; j--)
	    if (np->map[j * np->width + i] && Field[nx+i][ny+j]) {
		legal=FALSE;
		break;
	    }

    if (legal) {
	/*  Remove the old piece  */
	BltBitMapRastPort(&Piece->BitMap,0,0,tWindow->RPort,
		ScrInfo->FieldInLeft+ScrInfo->xTimes*Px,
		ScrInfo->FieldInTop+ScrInfo->yTimes*Py,
		Piece->width*ScrInfo->xTimes, Piece->height*ScrInfo->yTimes,
		0x20);

	/*  Change some things	*/
	Px = nx;
	Py = ny;
	Piece = np;

	/*  And display the new piece  */
	BltBitMapRastPort(&Piece->BitMap,0,0,tWindow->RPort,
		ScrInfo->FieldInLeft+ScrInfo->xTimes*Px,
		ScrInfo->FieldInTop+ScrInfo->yTimes*Py,
		Piece->width*ScrInfo->xTimes, Piece->height*ScrInfo->yTimes,
		0x60);

    }

    hitting = IsHitting(Piece, Px, Py);

    DBUG_RETURN(hitting);
}

/*
**
**  ByeBye()
**
*/

void ByeBye(int back)
{
    DBUG_ENTER("ByeBye");

    DBUG_PRINT("Bye",("Emergency Exit:  Code %d", back));

    exit (back);

    DBUG_VOID_RETURN;
}

/*
**
**  GameOver()
**
**  Display the "Game Over" requester and ask if the user wants to play again.
**
*/
BOOL GameOver(void)
{
    struct EasyStruct es = {
	sizeof(struct EasyStruct),
	0,
	"YacTris",
	"\nGame Over\n\nFinal Score: %ld\nLines Cleared: %ld\n\nPlay Again?\n",
	"Yes|No"
    };

    int over;

    DBUG_ENTER("GameOver");

    over = !(EasyRequest(tWindow, &es, NULL, (APTR) Score, Lines));

    DBUG_RETURN(over);
}

/*
**
**  ResetTet()
**
**  Reset everything for a new game.
**
*/
void ResetTet(void)
{
    int i;

    DBUG_ENTER("ResetTet");

    ClearPlayField();
    Score = Lines = 0;
    Level = StartLev;
    UpdateScores(tWindow, ScrInfo, Level, Score, Lines);
    for (i=0; i<NUM_TYPES; i++) PieceCount[i] = 0;
    if (pWindow) for (i=0; i<NUM_TYPES; i++)
	DispPCount(ScrInfo, pWindow, Pieces[i], 0);
    NewPiece( PickPiece(), STARTX, STARTY);

    DBUG_VOID_RETURN;
}

/*
**  FillInTWindow
**
**  Recolor the proper blocks.
**
*/
void FillInTWindow(struct Window *tw, struct ScreenInfo *si)
{
    int i,j;
    const UWORD fill = 0xffff;

    DBUG_ENTER("FillInTWindow");

    SetAfPt(tw->RPort, &fill, 0);

    for (i=0; i<FWIDTH; i++)
	for (j=0; j<FHEIGHT; j++)
	    if (Field[i][j])
		BltBitMapRastPort(&Sqbm, 0, 0, tw->RPort,
		    si->FieldInLeft + i*si->xTimes,
		    si->FieldInTop + j*si->yTimes,
		    si->xTimes, si->yTimes,
		    0x60);

    DBUG_VOID_RETURN;
}


/*
**
**  IsHitting()
**
**  Returns TRUE if a piece is resting on a piece below it.
**
*/
BOOL IsHitting(struct PieceRot *p, int x, int y)
{
    int i,j;
    BOOL hitting = FALSE;

    DBUG_ENTER("IsHitting");

    for (i=0; i<p->width && !hitting; i++)
	for (j=p->height-1; j>=0; j--)
	    if (p->map[j*p->width+i]) {
		hitting = (BOOL)((y+j+1==FHEIGHT) || (Field[x+i][y+j+1]));
		break;
	    }

    DBUG_RETURN(hitting);
}

/*
**
**  DoNewPubScreen
**
**  Open the YacTris window on a new screen.
**
*/
void DoNewPubScreen(struct Screen *news)
{
    struct ScreenInfo *si = NULL;
    struct Window *tw = NULL;
    struct Window *pw = NULL;
    struct Menu *tm = NULL;

    BOOL success = FALSE;

    int i;

    DBUG_ENTER("OpenNewPubScreen");

    if (si = CreateScrInfo(news)) {
	if (tm = CreateMenus(tNewMenu, TAG_END)) {
	    if (LayoutMenus(tm, si->vi, TAG_END)) {
		if (tw=OpenTWindow(si, tm, startx, starty)) {
		    MakePieces(si);
		    FillInTWindow(tw, si);
		    if (ShowNext) {
			BltBitMapRastPort(&Next->BitMap, 0, 0,
			    tw->RPort, si->NPLeft, si->NPTop,
			    4*si->xTimes, 4*si->yTimes, 0xc0);
		    } else {
			ClearMenuStrip(tw);
			ItemAddress(tm, FULLMENUNUM(1,0,NOSUB))->Flags
			    &= ~CHECKED;
			ResetMenuStrip(tw,tm);
		    }
		    if (pWindow) {
			if (pw=OpenPWindow(si, tw->UserPort, tWindow)) {
			    for (i=0; i<NUM_TYPES; i++)
				DispPCount(si, pw, Pieces[i], PieceCount[i]);
			    ClearMenuStrip(tw);
			    ItemAddress(tm, FULLMENUNUM(1,1,NOSUB))->Flags
				    |= CHECKED;
			    ResetMenuStrip(tw, tm);
			} else {
			    ClearMenuStrip(tw);
			    ItemAddress(tm, FULLMENUNUM(1,1,NOSUB))->Flags
				    &= ~CHECKED;
			    ResetMenuStrip(tw, tm);
			}
		    } else {
			pw = NULL;
			ClearMenuStrip(tw);
			ItemAddress(tm, FULLMENUNUM(1,1,NOSUB))->Flags
				&= ~CHECKED;
			ResetMenuStrip(tw, tm);
		    }

		    if (pWindow) ClosePWindow(pWindow);
		    pWindow = pw;

		    CloseTWindow(tWindow);
		    tWindow = tw;

		    FreeMenus(tMenus);
		    tMenus = tm;

		    UnlockPubScreen (NULL, ScrInfo->s);
		    FreeScrInfo(ScrInfo);
		    ScrInfo = si;

		    tScreen = news;

		    success = TRUE;
		}
	    }
	}
    }

    if (!success) {
	if (pw) ClosePWindow(pw);
	if (tw) CloseTWindow(tw);
	if (tm) FreeMenus(tm);
	if (si) FreeScrInfo(si);
    }

    DBUG_VOID_RETURN;

}

/*
**
**  VerifyQuit
**
**  Check to be sure the user really wants to quit.
**
*/
BOOL VerifyQuit(void)
{
    struct EasyStruct es = {
	sizeof(struct EasyStruct),
	0,
	"YacTris Request",
	"Final Score: %ld\nLines Cleared: %ld\n\nReally Quit?\n",
	"Yes|No"
    };

    int ret;

    DBUG_ENTER("VerifyQuit");

    ret = EasyRequest(tWindow, &es, NULL, (APTR) Score, Lines);

    DBUG_RETURN(ret);
}


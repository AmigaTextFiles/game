/************************************************************************
*																		*
*								Dragon Game								*
*								===========								*
*																		*
*						Copyright ©1995 Nick Christie					*
*																		*
* Distributed under the terms of the GNU Public License.				*
*																		*
* Version 1.0	(29/08/92)												*
* ========================												*
* NB: The IFF ILBMs loaded as background and tiles must be of a certain	*
* format: see LoadBackground() and LoadTileImages() in DragDisp.c.		*
*																		*
*																		*
* Version 1.1	(2/7/94)												*
* ======================												*
* Converted to SAS/C 6.5.												*
*																		*
*																		*
*************************************************************************/

/*** TODO

Some help -> describe the numbers around the screen.

Face graphic with attitude according to success.

Cheat: can work out a solution ?

Triumph graphics ?

Record of best game and # of successes ?

Make NTSC compatible.

***/

/************************************************************************
******************************  INCLUDES  *******************************
*************************************************************************/

#include "DragonDefs.h"
#include "Dragon.h"

#define USAGEMSG "Usage: Dragon TILES/K BGND/K\n" \
				 "Where: TILES = optional, followed by name of IFF\n" \
				 "               ILBM file to get tile images from;\n" \
				 "       BGND  = as above for background image.\n" \
				 "Default names are DragonTiles.pic & DragonBgnd.pic.\n" \
				 "See the doc for specifications of these files.\n"

/************************************************************************
*************************  EXTERNAL REFERENCES  *************************
*************************************************************************/

extern BOOL OpenBufRPort(void);					/* all these from */
extern void CloseBufRPort(void);				/* DragDisp.c */
extern void LoadBackground(char *fname);
extern void UnloadBackground(void);
extern BOOL LoadTileImages(char *fname);
extern void UnloadTileImages(void);
extern void DrawBoard(BOARD board,struct RastPort *rp);
extern void DrawOneTile(UBYTE tile,struct RastPort *rp,UWORD x,UWORD y);
extern void DisplayStats(BOARD board,struct RastPort *rp);
extern UWORD PossibleMoves(BOARD board);
extern void SelectStats(UBYTE tile,BOARD board,struct RastPort *rp);

extern struct Library *SysBase;

/************************************************************************
*****************************  PROTOTYPES  ******************************
*************************************************************************/

ULONG main(ULONG cmdlen,char *cmdline);

char *ParseWBArgs(struct WBStartup *wbmsg,char **bgndptr,char **tileptr);
char *ParseCLIArgs(ULONG clen,char *cline,char **bgndptr,char **tileptr);

BOOL HandleMenu(UWORD code,UWORD qual);
void HandleMouse(UWORD code,UWORD qual,WORD msx,WORD msy);

BOOL WhichTileHit(WORD msx,WORD msy,UWORD *px,UWORD *py,UWORD *pz);
BOOL IsInTile(UWORD scrnx,UWORD scrny,UWORD tilex,UWORD tiley,UWORD tilez);
UWORD TopLevelTile(BOARD board,UWORD x,UWORD y);
BOOL  CanMoveTile(BOARD board,UWORD x,UWORD y,UWORD z);
void RemoveTile(BOARD board,struct RastPort *rp,UWORD x,UWORD y,UWORD z);

char *OpenAll(void);
void CloseAll(char *errmsg,BOOL fromwb);

void UndoMove(BOARD board,struct RastPort *rp);
void UndoAll(void);

void NewBoard(void);
void ShuffleBoard(BOARD board);

ULONG Random(UWORD max);
void Randomize(void);

int CXBRK(void) {return(0);}		/* Lattice: disables CTRL+C */
int chkabort(void) {return(0);}

/************************************************************************
*****************************  GLOBAL DATA  *****************************
*************************************************************************/

/*
 * Library bases
 */

struct Library	*GadToolsBase = NULL;
struct Library	*IFFParseBase = NULL;
struct Library	*IconBase = NULL;

/*
 * Pointers to the filenames for the background and tile IFF ILBMs,
 * initialized to defaults.
 */

char *BgndFilename = "DragonBgnd.pic";
char *TilesFilename = "DragonTiles.pic";

/*
 * If started okay from CLI, I allocate an RDArgs for the ReadArgs()
 * call to process the command line with. This must be free'd on exit.
 */

struct RDArgs *MyRDArgs = NULL;

/*
 * If started okay from WB, this receives ptr to my DiskObject, to
 * be released on exit. OrgCurDir receives the original current dir
 * lock, which we must return to before exit.
 */

struct DiskObject *MyDiskObj = NULL;
BPTR OrgCurDir = NULL;

/*
 * Make sure we get Topaz8 for all text
 */

struct TextAttr TopazAttr = {"topaz.font",8,FS_NORMAL,
									FPF_ROMFONT|FPF_DESIGNED};

/*
 * Screen & Window data
 */

struct ColorSpec ScrnClrs[] = {
	{0 , 0, 0, 0}, {1 ,15,15,15}, {2 ,15,13, 9}, {3 ,14,11, 0},
	{4 ,14,10, 0}, {5 ,12, 9, 0}, {6 , 9, 8, 5}, {7 , 7, 7, 7},
	{8 ,14, 6, 0}, {9 ,12, 7, 1}, {10, 9, 0, 0}, {11, 5,12, 3},
	{12, 5,10, 5}, {13, 3, 9, 8}, {14, 0, 9,15}, {15, 2, 8,12},
	{16, 0, 0, 0}, {17,14, 4, 4}, {18, 0, 0, 0}, {19,14,14,12},
	{20, 0, 0,15}, {21, 0, 2,13}, {22, 0, 4,11}, {23, 0, 6, 9},
	{24, 0, 8, 7}, {25, 0,10, 5}, {26, 0,12, 3}, {27, 0,15, 0},
	{28, 3,12, 0}, {29, 7, 8, 0}, {30,11, 4, 0}, {31,15, 0, 0},
	{-1,0,0,0}
};

struct TagItem ScreenTags[] = {
	SA_Left,		0,
	SA_Top,			0,
	SA_Width,		SCRWIDTH,
	SA_Height,		SCRHEIGHT,
	SA_Depth,		SCRDEPTH,
	SA_DisplayID,	0,
	SA_Type,		CUSTOMSCREEN,
	SA_Colors,		(ULONG) ScrnClrs,
	SA_Title,		(ULONG) "Dragon V1.1",
	TAG_DONE };

struct TagItem WindowTags[] = {
	WA_CustomScreen, NULL,
	WA_Left,		0,
	WA_Top,			0,
	WA_Width,		SCRWIDTH,
	WA_Height,		SCRHEIGHT,
	WA_IDCMP,		MAINIDCMP,
	WA_Flags,		MAINWFLGS,
	TAG_DONE };

struct NewMenu MyNewMenu[] = {
	NM_TITLE, "Project", 0l, 0, 0, 0l,
	NM_ITEM, "New Game", "N", 0, 0, 0l,
	NM_ITEM, "Restart", "R", 0, 0, 0l,
	NM_ITEM, "Undo Move", "U", 0, 0, 0l,
	NM_ITEM, "About...", "A", 0, 0, 0l,
	NM_ITEM, "Quit", "Q", 0, 0, 0l,
	NM_END, 0l, 0l, 0, 0l, 0l };

struct Screen		*MyScreen = NULL;
APTR				VisualInfo = NULL;
struct Menu			*MainMenu = NULL;
struct Window		*MainWindow = NULL;
struct RastPort		*MainRPort;
struct MsgPort		*MainIPort;
ULONG				MainISigs;

/*
 * Array that tells us what piece is where. The board is 12 tiles
 * across, 6 tiles down, and 4 tiles high, but not all of those
 * positions are used. Unused positions are marked as zero. The other
 * numbers are ID codes for the pieces, which come as 4 instances of
 * 30 types, making a total of 120 tiles. The particular arrangement
 * of tiles shown here is irrelevant: it gets shuffled before use.
 * Also, this array is only used to hold the starting arrangement, a
 * working copy is made for playing with.
 */

BOARD StartBoard =
	{
		{												/* bottom level */
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12},
			{ 0, 0, 0,13,14,15,16,17,18, 0, 0, 0},
			{ 0,19,20,21,22,23,24,25,26,27,28, 0},
			{ 0,29,30, 1, 2, 3, 4, 5, 6, 7, 8, 0},
			{ 0, 0, 0, 9,10,11,12,13,14, 0, 0, 0},
			{15,16,17,18,19,20,21,22,23,24,25,26}
		},{												/* first level */
			{ 0, 0,27,28,29,30, 1, 2, 3, 4, 0, 0},
			{ 0, 0, 0, 0, 5, 6, 7, 8, 0, 0, 0, 0},
			{ 0, 0, 0, 9,10,11,12,13,14, 0, 0, 0},
			{ 0, 0, 0,15,16,17,18,19,20, 0, 0, 0},
			{ 0, 0, 0, 0,21,22,23,24, 0, 0, 0, 0},
			{ 0, 0,25,26,27,28,29,30, 1, 2, 0, 0}
		},{												/* second level */
			{ 0, 0, 0, 0, 0, 3, 4, 0, 0, 0, 0, 0},
			{ 0, 0, 0, 0, 5, 6, 7, 8, 0, 0, 0, 0},
			{ 0, 0, 0, 0, 9,10,11,12, 0, 0, 0, 0},
			{ 0, 0, 0, 0,13,14,15,16, 0, 0, 0, 0},
			{ 0, 0, 0, 0,17,18,19,20, 0, 0, 0, 0},
			{ 0, 0, 0, 0, 0,21,22, 0, 0, 0, 0, 0}
		},{												/* top level */
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{ 0, 0, 0, 0,23,24,25,26, 0, 0, 0, 0},
			{ 0, 0, 0, 0,27,28,29,30, 0, 0, 0, 0},
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
		}
	};

/*
 * This is the array used as working copy of the board.
 */

BOARD WorkBoard;

/*
 * These hold the co-ordinates and type of the currently selected tile.
 * Here is also the count of the number of pairs left on the board.
 */

UBYTE SelectedTile;
UWORD SelectX,SelectY,SelectZ;

UWORD PairsLeft;

/*
 * For saving undo information.
 */

struct StackMove UndoStack[NUMTILES];
struct StackMove *UndoPtr;

/*
 * The seed for the random number generator:
 */

ULONG RandomSeed;

/*
 * Messages displayed by 'about' requester and version command.
 */

char VersionMsg[] = "\0$VER: Dragon 1.10 (8.2.94)";

char AboutMsg[] =	"    Dragon 1.10 (8.2.94)\n"
					"      by Nick Christie,\n"
					"      Copyright ©1995\n"
					"nick.christie@oucs.ox.ac.uk,\n"
					"    39 St Georges Drive,\n"
					"     Bransgore BH23 8EZ\n"
					"       Great Britain.";

/*
 * The structure used for the 'about' requester.
 */

struct EasyStruct EasyAbout = {
	sizeof(struct EasyStruct), NULL, "About", AboutMsg, "Okay" };

/************************************************************************
*******************************  MAIN()  ********************************
*************************************************************************
* Calls OpenAll() and waits for idcmp msgs. Calls CloseAll() before exit.
* NB: Custom startup supplies command line + length, not argc/argv !
* If WB, then cmdline ptr is actually WBStartupMsg ptr and len = 0.
*
*************************************************************************/

ULONG main(ULONG cmdlen,char *cmdline)
{
char				*errmsg;
struct IntuiMessage	*imsg;
ULONG				class;
UWORD				code,qual;
WORD				msx,msy;
BOOL				done,fromwb;

errmsg = NULL;
fromwb = (cmdlen == 0);

if (((struct Library *)SysBase)->lib_Version >= 36)
	{
	if (fromwb)
		errmsg = ParseWBArgs((struct WBStartup *)cmdline,&BgndFilename,
								&TilesFilename);
	else
		errmsg = ParseCLIArgs(cmdlen,cmdline,&BgndFilename,&TilesFilename);

	if (!errmsg)
		{
		if (!(errmsg = OpenAll()))
			{
			NewBoard();
			done = FALSE;

			while (!done)
				{
				Wait(MainISigs);

				while (imsg = (struct IntuiMessage *) GetMsg(MainIPort))
					{
					class = imsg->Class;
					code = imsg->Code;
					qual = imsg->Qualifier;
					msx = imsg->MouseX;
					msy = imsg->MouseY;
					ReplyMsg( (struct Message *) imsg);

					switch(class)
						{
						case IDCMP_MOUSEBUTTONS:
							HandleMouse(code,qual,msx,msy);
							break;

						case IDCMP_MENUPICK:
							done = HandleMenu(code,qual);
							break;
						}
					}
				}
			}
		}
	}

CloseAll(errmsg,fromwb);

return(errmsg ? 20 : 0);
}

/************************************************************************
****************************  PARSEWBARGS()  ****************************
*************************************************************************
* We were started from WB, so look in tooltypes for specification of
* background and tile image files:
*	BGND=bgndfilename
*	TILES=tilesfilename
* Put pointers to the correct strings at the locations supplied. If either
* is missing, the default is left alone. Error msg is returned, else null.
* CloseAll() is expected to release MyDiskObj and close icon library.
*
*************************************************************************/

char *ParseWBArgs(struct WBStartup *wbmsg,char **bgndptr,char **tileptr)
{
char	*name,*errmsg;

if (IconBase = OpenLibrary("icon.library",37))
	{
	OrgCurDir = CurrentDir(wbmsg->sm_ArgList->wa_Lock);

	if (MyDiskObj = GetDiskObject(wbmsg->sm_ArgList->wa_Name))
		{
		if (name = FindToolType(MyDiskObj->do_ToolTypes,"BGND"))
			*bgndptr = name;
		if (name = FindToolType(MyDiskObj->do_ToolTypes,"TILES"))
			*tileptr = name;
		errmsg = NULL;
		}
	else
		errmsg = "Couldn't access WB tooltypes.";
	}
else
	errmsg = "No icon library V37";

return(errmsg);
}

/************************************************************************
***************************  PARSECLIARGS()  ****************************
*************************************************************************
* Look for specification of background and tile image files on cmd line.
* Template is "Dragon [TILES=tilesfile] [BGND=bgndfile]".
* If found, sets pointers supplied to correct names, else leaves them
* with defaults.
*
*************************************************************************/

char *ParseCLIArgs(ULONG clen,char *cline,char **bgndptr,char **tileptr)
{
LONG	args[2];
char	*errmsg;

if (*cline == '?')
	errmsg = USAGEMSG;
else
	{
	if (MyRDArgs = (struct RDArgs *)AllocDosObject(DOS_RDARGS,NULL))
		{
		MyRDArgs->RDA_Source.CS_Buffer = cline;
		MyRDArgs->RDA_Source.CS_Length = clen;
		MyRDArgs->RDA_Source.CS_CurChr = 0;
		MyRDArgs->RDA_Flags |= RDAF_STDIN;
		args[0] = (LONG) *tileptr;
		args[1] = (LONG) *bgndptr;

		if (ReadArgs("TILES/K,BGND/K",args,MyRDArgs))
			{
			*tileptr = (char *)args[0];
			*bgndptr = (char *)args[1];
			errmsg = NULL;
			}
		else
			errmsg = "Error in command line arguments !";
		}
	else
		errmsg = "No memory !";
	}

return(errmsg);
}

/************************************************************************
****************************  HANDLEMENU()  *****************************
*************************************************************************
* Respond to menupick idcmp msg. Returns BOOL indicating quit if true.
*
*************************************************************************/

BOOL HandleMenu(UWORD code,UWORD qual)
{
BOOL	done = FALSE;

if ((code != MENUNULL) && (MENUNUM(code) == 0))
	{
	switch (ITEMNUM(code))
		{
		case ITEM_NEWGAME:
			NewBoard();
			break;

		case ITEM_RESTART:
			UndoAll();
			break;

		case ITEM_UNDOMOVE:
			UndoMove(WorkBoard,MainRPort);
			break;

		case ITEM_ABOUT:
			EasyRequest(MainWindow,&EasyAbout,NULL,NULL);
			break;

		case ITEM_QUIT:
			done = TRUE;
			break;
		}
	}

return(done);
}

/************************************************************************
****************************  HANDLEMOUSE()  ****************************
*************************************************************************
* Respond to mousebuttons idcmp msg. See if it was LMB down on a tile,
* and react if necessary by removing/highlighting tile(s). Also looks
* for SHIFT keys: if held down, selected tile is removed momentarily and
* then put back (cheating).
*
*************************************************************************/

void HandleMouse(UWORD code,UWORD qual,WORD msx,WORD msy)
{
UWORD	x,y,z;
UBYTE	tile;

if (code == SELECTDOWN)
	{
	if (WhichTileHit(msx,msy,&x,&y,&z))
		{
		if (tile = WorkBoard[z][y][x])
			{
			if (qual & IEQ_SHIFT)
				{
				WorkBoard[z][y][x] = 0;
				DrawBoard(WorkBoard,MainRPort);
				Delay(15);
				WorkBoard[z][y][x] = tile;
				DrawBoard(WorkBoard,MainRPort);
				}
			else
				{
				if (CanMoveTile(WorkBoard,x,y,z))
					{
					if ((SelectedTile == tile) && ((SelectX != x)
						|| (SelectY != y) || (SelectZ != z)))
						{
						RemoveTile(WorkBoard,MainRPort,x,y,z);
						}
					else
						{
						SelectedTile = tile;
						SelectX = x;
						SelectY = y;
						SelectZ = z;
						DrawOneTile(tile,MainRPort,SELECTLEFT,SELECTTOP);
						SelectStats(tile,WorkBoard,MainRPort);
						}
					}		/* endif CanMoveTile */
				}		/* endelse not SHIFT */
			}		/* endif tile != 0 */
		}		/* endif tile hit */
	}		/* endif SELECTDOWN */
}

/************************************************************************
***************************  WHICHTILEHIT()  ****************************
*************************************************************************
* Determines, from mouse x/y, which tile was hit, if any, and puts the
* tile's x/y/z co-ordinates into the supplied UWORDs. Returns false if
* mouse x/y is outside board area or if no tile there. Accomodates for
* overhanging tiles.
*
*************************************************************************/

BOOL WhichTileHit(WORD msx,WORD msy,UWORD *px,UWORD *py,UWORD *pz)
{
UWORD	mx,my,x,y,z;
BOOL	found = FALSE;

if ((msx >= 0) && (msy >= 0))
	{
	mx = msx;
	my = msy;
	y = BOARDY;

	do
		{
		y--;
		x = BOARDX;

		do
			{
			x--;
			z = TopLevelTile(WorkBoard,x,y);
			if (WorkBoard[z][y][x])
				found = IsInTile(mx,my,x,y,z);
			}
		while((x > 0) && !found);
		}
	while((y > 0) && !found);

	if (found)
		{
		*px = x; *py = y; *pz = z;
		}
	}

return(found);
}

/************************************************************************
*****************************  ISINTILE()  ******************************
*************************************************************************
* Return whether the given screen position is within the "naive"
* boundaries of the given tile, specified by x/y/z coordinates.
* Does not take account of "overhanging" tiles, but does take account of
* x/y adjustment for given z.
*
*************************************************************************/

BOOL IsInTile(UWORD scrnx,UWORD scrny,UWORD tilex,UWORD tiley,UWORD tilez)
{
UWORD	sx,sy;

sx = BRDLEFTEDGE + (tilex * TILEXSPACE) - (tilez * LEVELXADJ);
sy = BRDTOPEDGE + (tiley * TILEYSPACE) - (tilez * LEVELYADJ);

if ((scrnx >= sx) && (scrnx < sx+TILEXSPACE)
	&& (scrny >= sy) && (scrny < sy+TILEYSPACE)) return(TRUE);
else return(FALSE);
}

/************************************************************************
***************************  TOPLEVELTILE()  ****************************
*************************************************************************
* Determines the z coordinate of the topmost tile in the given board at
* the given x,y position. Returns z=0 if no tile could be found at that
* position at all, in which case this routine shouldn't have been called !
*
*************************************************************************/

UWORD TopLevelTile(BOARD board,UWORD x,UWORD y)
{
UWORD	z = BOARDZ-1;

while((z > 0) && (board[z][y][x] == 0)) --z;

return(z);
}

/************************************************************************
****************************  CANMOVETILE()  ****************************
*************************************************************************
* Determines whether a tile can be moved or not. It can if it has no
* neighbours to either the left or the right. The tile is assumed to be
* the topmost, ie. caller must have already determined that it is.
*
*************************************************************************/

BOOL  CanMoveTile(BOARD board,UWORD x,UWORD y,UWORD z)
{
if ((x == 0) || (x == BOARDX-1))
	return((BOOL)TRUE);
else
	return ((BOOL)!(board[z][y][x-1] && board[z][y][x+1]));
}

/************************************************************************
****************************  REMOVETILE()  *****************************
*************************************************************************
* Remove a pair of tiles from the given board. It has already been
* determined that the tile can be moved. One tile position is supplied,
* the other is in SelectX/Y/Z. Undo information is stored & the graphics
* are updated. One day this will return a BOOL meaning that all tiles
* are gone & victory effects should be shown.
*
*************************************************************************/

void RemoveTile(BOARD board,struct RastPort *rp,UWORD x,UWORD y,UWORD z)
{
UBYTE tile;

tile = board[z][y][x];
UndoPtr->tile = tile;
UndoPtr->x1 = (UBYTE) x;
UndoPtr->y1 = (UBYTE) y;
UndoPtr->z1 = (UBYTE) z;
UndoPtr->x2 = (UBYTE) SelectX;
UndoPtr->y2 = (UBYTE) SelectY;
UndoPtr->z2 = (UBYTE) SelectZ;
UndoPtr++;
UndoPtr->tile = 0;

board[z][y][x] = 0;
board[SelectZ][SelectY][SelectX] = 0;
SelectedTile = 0;
PairsLeft--;
DrawBoard(board,rp);
}

/************************************************************************
******************************  OPENALL()  ******************************
*************************************************************************
* Opens libraries, screen and window. Returns error msg if fail, else
* returns null.
*
*************************************************************************/

char *OpenAll(void)
{
if (!(IntuitionBase = (struct IntuitionBase *)
	OpenLibrary("intuition.library",37)))
		return("No Intuition V37 !");

if (!(GfxBase = (struct GfxBase *)
	OpenLibrary("graphics.library",37)))
		return("No Graphics !");

if (!(GadToolsBase = OpenLibrary("gadtools.library",37)))
	return("No GadTools !");

if (!(IFFParseBase = OpenLibrary("iffparse.library",37)))
	return("No IFFParse !");

if (!OpenBufRPort()) return("No memory !");

LoadBackground(BgndFilename);

if (!LoadTileImages(TilesFilename))
	return("No tiles !");

if (!(MyScreen = OpenScreenTagList(NULL,ScreenTags)))
	return("No screen !");

if (!(VisualInfo = GetVisualInfo(MyScreen,TAG_DONE)))
	return("No memory !");

WindowTags[0].ti_Data = (ULONG) MyScreen;

if (!(MainWindow = OpenWindowTagList(NULL,WindowTags)))
	return("No window !");

MainRPort = MainWindow->RPort;
MainIPort = MainWindow->UserPort;
MainISigs = 1L<<(MainIPort->mp_SigBit);

if (!(MainMenu = CreateMenus(MyNewMenu,GTMN_FrontPen,0L,TAG_DONE)))
		return("No memory !");

LayoutMenus(MainMenu,VisualInfo,GTMN_TextAttr,&TopazAttr,TAG_DONE);
SetMenuStrip(MainWindow,MainMenu);

return(NULL);
}

/************************************************************************
*****************************  CLOSEALL()  ******************************
*************************************************************************
* Release all resources obtained by OpenAll(), if any. At some stage will
* also display supplied error msg if it's non-null.
*
*************************************************************************/

void CloseAll(char *errmsg,BOOL fromwb)
{
BPTR	out;

if (MainMenu)
	{
	ClearMenuStrip(MainWindow);
	FreeMenus(MainMenu);
	}
if (MainWindow) CloseWindow(MainWindow);
if (VisualInfo) FreeVisualInfo(VisualInfo);
if (MyScreen) CloseScreen(MyScreen);
UnloadTileImages();
UnloadBackground();
CloseBufRPort();
if (IFFParseBase) CloseLibrary(IFFParseBase);
if (GadToolsBase) CloseLibrary(GadToolsBase);
if (GfxBase) CloseLibrary( (struct Library *) GfxBase);
if (IntuitionBase) CloseLibrary( (struct Library *) IntuitionBase);

if (IconBase)
	{
	if (MyDiskObj) FreeDiskObject(MyDiskObj);
	if (OrgCurDir) CurrentDir(OrgCurDir);
	CloseLibrary(IconBase);
	}

if (MyRDArgs)
	{
	FreeArgs(MyRDArgs);
	FreeDosObject(DOS_RDARGS,(APTR)MyRDArgs);
	}

if (errmsg)
	{
	if (fromwb)
		out = Open("CON:0/0/300/80/Dragon Error/CLOSE/WAIT",MODE_NEWFILE);
	else
		out = Output();

	if (out)
		{
		VFPrintf(out,"%s\n",(LONG *) &errmsg);
		if (fromwb)
			Close(out);
		}
	}
}

/************************************************************************
*****************************  UNDOMOVE()  ******************************
*************************************************************************
* Use the undo stack to take back the last move. Board is redrawn & state
* trackers updated.
*
*************************************************************************/

void UndoMove(BOARD board,struct RastPort *rp)
{
if (PairsLeft != NUMTILES/2)
	{
	UndoPtr--;
	board[UndoPtr->z1][UndoPtr->y1][UndoPtr->x1] = UndoPtr->tile;
	board[UndoPtr->z2][UndoPtr->y2][UndoPtr->x2] = UndoPtr->tile;

	SelectedTile = 0;
	PairsLeft++;

	DrawBoard(board,rp);
	}
}

/************************************************************************
******************************  UNDOALL()  ******************************
*************************************************************************
* Reset board to starting state. Doesn't actually need undo stack to do
* this, as the original board has been preserved.
*
*************************************************************************/

void UndoAll(void)
{
SelectedTile = 0;
PairsLeft = NUMTILES/2;
UndoPtr = UndoStack;
UndoPtr->tile = 0;
CopyBoard(StartBoard,WorkBoard);
DrawBoard(WorkBoard,MainRPort);
}

/************************************************************************
*****************************  NEWBOARD()  ******************************
*************************************************************************
* Resets for a new board. StartBoard gets shuffled to produce WorkBoard,
* which gets drawn. Counters & state trackers reset.
*
*************************************************************************/

void NewBoard(void)
{
SelectedTile = 0;
PairsLeft = NUMTILES/2;
UndoPtr = UndoStack;
UndoPtr->tile = 0;
ShuffleBoard(StartBoard);
CopyBoard(StartBoard,WorkBoard);
DrawBoard(WorkBoard,MainRPort);
}

/************************************************************************
***************************  SHUFFLEBOARD()  ****************************
*************************************************************************
* Shuffle the pieces in the supplied BOARD array into a random order.
* Normally, all 120 pieces are present in the array when the shuffle is
* performed, as this routine spends its time swapping tiles randomly.
* No tile is swapped with an array element of zero (where no tile is
* present). The tile array is handled as a flat array of bytes, as we
* are not concerned about the particular arrangement.
*
*************************************************************************/

void ShuffleBoard(BOARD board)
{
ULONG	r1;
ULONG	r2;
UWORD	i,x,y;
UBYTE	t1,t2,t3,t4,*p;
BOOL	reshuffle = TRUE;

while (reshuffle)
	{
	Randomize();

	p = (UBYTE *) board;

	for(i=0;i<8192;i++)
		{
		r1 = Random(BOARDX*BOARDY*BOARDZ-1);
		r2 = Random(BOARDX*BOARDY*BOARDZ-1);
		t1 = p[r1]; t2 = p[r2];
		if (t1 && t2)
			{
			p[r1] = t2; p[r2] = t1;
			}
		}

	reshuffle = FALSE;
	y = 0;

	while((y < BOARDY) && !reshuffle)
		{
		x = 0;

		while((x < BOARDX) && !reshuffle)
			{
			t1 = board[0][y][x];
			t2 = board[1][y][x];
			t3 = board[2][y][x];
			t4 = board[3][y][x];
			if (t4)
				{
				if (t1 == t2)
					{
					reshuffle = ((t2 == t3) || (t2 == t4));
					}
				else if (t3 == t4)
					{
					reshuffle = ((t1 == t3) || (t2 == t3));
					}
				}
			else if (t3)
				{
				reshuffle = ((t1 == t2) && (t2 == t3));
				}
			x++;
			}		/* endwhile x loop */
		y++;
		}		/* endwhile y loop */

	}		/* endwhile reshuffle */
}

/************************************************************************
******************************  RANDOM()  *******************************
*************************************************************************
* Utility for ShuffleBoard(), returns a pseudo-random number between 0
* and max. Uses RandomSeed, which should be initialized before use by
* calling Randomize().
*
*************************************************************************/

ULONG Random(UWORD max)
{
RandomSeed = ((UWORD)(RandomSeed & 0xffff) * (UWORD) 25173) + 13849L;
return((ULONG) ((RandomSeed & 0xffff) % (UWORD)(max)));
}

/************************************************************************
*****************************  RANDOMIZE()  *****************************
*************************************************************************
* Initializes RandomSeed to random number from system clock.
*
*************************************************************************/

void Randomize(void)
{
struct DateStamp	ds;

DateStamp(&ds);
RandomSeed = ds.ds_Minute+ds.ds_Tick;
}


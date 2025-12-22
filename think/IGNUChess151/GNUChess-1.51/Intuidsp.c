/************************************************************************/
/* IntuiDsp.c --- Intuition Interface for GNU Chess						*/
/************************************************************************/

static const char *Version = "$VER: IGNUChess 1.51 " __AMIGADATE__;

#include <exec/types.h>
#include <exec/memory.h>

#include <dos.h>

#include <libraries/diskfont.h>
#include <libraries/gadtools.h>
#include <libraries/asl.h>

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/diskfont.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <proto/gadtools.h>
#include <proto/asl.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <time.h>

#include "Global.h"
#include "gfx.h"
#include "Proto.h"
#include "Interface.h"
#include "gnuchess.h"

/* -------------------------------------------------------------------- */
/* Minimal library version for SAS/C auto open library feature			*/
/* -------------------------------------------------------------------- */

long __oslibversion = 37;

/* -------------------------------------------------------------------- */
/* static function prototypes											*/
/* -------------------------------------------------------------------- */

static void	Die(int);
static void	TerminateSearch(int);
static void	UpdateClocks(void);
static int	parse(FILE *, unsigned short *, short);
static void	GetGame(void);
static void	SaveGame(void);
static void ListGame(void);
static void	Undo(void);
static void	ChangeAlphaWindow(void);
static void	ChangeBetaWindow(void);
static void	GiveHint(void);
static void ChangeSearchDepth(void);
static void SetContempt(void);
static void ChangeXwindow(void);
static void	DoDebug(void);
static void	ShowPostnValues(void);
static void ShowError(int);

/* -------------------------------------------------------------------- */

unsigned int			tmbuf1[2],
						tmbuf2[2];
long					time1,
						time2;

struct Screen			*s;
struct ViewPort			*vp;
APTR					vi;
struct Window			*w;
struct RastPort			*rp;
struct FileRequester	*freq;
struct Remember			*rk;
ULONG					DisplayID;

static ULONG NewLook[] = { ~0 };

static struct ColorSpec ColorSpec[] = {
	{ COLOR_BCK    , 0x0B, 0x0B, 0x08 },
	{ COLOR_RAHMEN , 0x00, 0x00, 0x00 },
	{ COLOR_WFIG   , 0x0F, 0x0F, 0x0F },
	{ COLOR_REQBAR , 0x0C, 0x0C, 0x0A },
	{ COLOR_EMPTY  , 0x0C, 0x0B, 0x08 },
	{ COLOR_SFIG   , 0x06, 0x05, 0x02 },
	{ COLOR_WFELD  , 0x0A, 0x08, 0x01 },
	{ COLOR_SFELD  , 0x0E, 0x0D, 0x0A },
	{ COLOR_MENUBCK, 0x00, 0x05, 0x08 },
	{ COLOR_BLOCK  , 0x0D, 0x0D, 0x0B },
	{ COLOR_TXTBCK , 0x0E, 0x0E, 0x0C },
	{ COLOR_TXTFGR , 0x00, 0x00, 0x00 },
	{ COLOR_REQBCK , 0x08, 0x08, 0x01 },
	{ COLOR_MARK   , 0x0C, 0x04, 0x00 },
	{ COLOR_FMARK  , 0x0C, 0x04, 0x00 },
	{ -1, 0x00, 0x00, 0x00 }
};

#define FONTFLAGS (FPF_ROMFONT | FPF_DISKFONT | FPF_DESIGNED)

static struct TextFont	*TF_Times15,
						*TF_Times18,
						*TF_Courier15;

struct TextAttr	TA_Times15		= { "times.font"  , 15, FS_NORMAL, FONTFLAGS },
				TA_Times18		= { "times.font"  , 18, FS_NORMAL, FONTFLAGS },
				TA_Courier15	= { "courier.font", 15, FSF_BOLD , FONTFLAGS };

// Graphic-offsets for texts

int	off_comp_left,		// "Computer"
	off_comp_right,
	off_human_left,		// "Human"
	off_human_right,	//  *** smile ***
	off_clock_left,		// clocks
	off_clock_right,
	off_algbr_left,		// notation
	off_algbr_right;

/* -------------------------------------------------------------------- */
/* Fit texts into text boxes, parameter `where` is for placement into	*/
/* left or right column													*/
/* -------------------------------------------------------------------- */

#define LEFT	0
#define RIGHT	1

static int CalcTextFit(char *s, int where)
{
	ULONG	enable;

	SetFont(rp, TF_Courier15);
	enable = AskSoftStyle(rp);
	SetSoftStyle(rp, FSF_BOLD, enable);

	if ( where == LEFT )
		return       ( NX2 - NX1 )   / 4 - TextLength(rp, s, strlen(s)) / 2;
	else
		return ( 3 * ( NX2 - NX1 ) ) / 4 - TextLength(rp, s, strlen(s)) / 2;
}

static void Fit_All_Text(void)
{
	off_comp_left		= CalcTextFit("Computer" , LEFT );
	off_comp_right		= CalcTextFit("Computer" , RIGHT);
	off_human_left		= CalcTextFit("  Human  ", LEFT );
	off_human_right		= CalcTextFit("  Human  ", RIGHT);
	off_clock_left		= CalcTextFit("000:00:00", LEFT );
	off_clock_right		= CalcTextFit("000:00:00", RIGHT);
	off_algbr_left		= CalcTextFit("a1h8"     , LEFT );
	off_algbr_right		= CalcTextFit("a1h8"     , RIGHT);
}

/* -------------------------------------------------------------------- */
/* Print text string s at coordinates (x, y)							*/
/* -------------------------------------------------------------------- */

static void MyText(char *s, int x, int y)
{
	ULONG	enable;

	SetAPen(rp, COLOR_TXTFGR);
	SetBPen(rp, COLOR_TXTBCK);
	SetDrMd(rp, JAM2);
	SetFont(rp, TF_Courier15);
	enable = AskSoftStyle(rp);
	SetSoftStyle(rp, FSF_BOLD, enable);
	Move(rp, x, y);
	Text(rp, s, strlen(s));
}

/* -------------------------------------------------------------------- */
/* Reset game variables to their default values							*/
/* -------------------------------------------------------------------- */

#ifndef true
#	define true		1
#endif
#ifndef false
#	define false	0
#endif

static void ResetVars(void)
{
	beep				=
	hashflag			= true;
	reverse				=
	bothsides			=
	post				= false;
	
	Awindow				=
	Bwindow				=
	xwndw				= 90;
	MaxSearchDepth		= 29;

	opponent			= white;
	computer			= black;

	ResetGfx();
}

/* -------------------------------------------------------------------- */
/* This is called once at program start to initialize graphics			*/
/* -------------------------------------------------------------------- */

void Initialize(void)
{
	int						x, y;
	DisplayInfoHandle		handle;
	ULONG					sw, sh;
	int						transfer;
	struct DimensionInfo	di;


	/* ---------------------------------------------------------------- */
	/* Open Fonts														*/
	/* ---------------------------------------------------------------- */

	if ( ! (TF_Times15   = OpenDiskFont(&TA_Times15  )) ) ExitChess(1);
	if ( ! (TF_Times18   = OpenDiskFont(&TA_Times18  )) ) ExitChess(2);
	if ( ! (TF_Courier15 = OpenDiskFont(&TA_Courier15)) ) ExitChess(3);

	/* ---------------------------------------------------------------- */
	/* Open custom screen, assign ViewPort and VisualInfo vars			*/
	/* ---------------------------------------------------------------- */

	if ( ModeNotAvailable( DisplayID ) ) {
		DisplayID = DEFAULT_MONITOR_ID | HIRESLACE_KEY;
	}

	handle = FindDisplayInfo( DisplayID );
	if ( ! handle ) ExitChess(13);

	transfer = GetDisplayInfoData(
		handle,
		(UBYTE *) &di,
		sizeof(struct DimensionInfo),
		DTAG_DIMS,
		0
	);
	if ( ! transfer ) ExitChess(14);

	sw = (di.TxtOScan.MaxX - di.TxtOScan.MinX >= 680) ? STDSCREENWIDTH : 680;
	sh = (di.TxtOScan.MaxY - di.TxtOScan.MinY >= 460) ? STDSCREENWIDTH : 460;

	s = OpenScreenTags(
		NULL,
		SA_Width,			sw,
		SA_Height,			sh,
		SA_Depth,			4,
		SA_Colors,			ColorSpec,
		SA_DetailPen,		COLOR_TXTFGR,
		SA_BlockPen,		COLOR_BLOCK,
		SA_Font,			&TA_Courier15,
		SA_Title,			"Intuition GNU Chess interface",
		SA_Type,			CUSTOMSCREEN,
		SA_DisplayID,		DisplayID,
		SA_Overscan,		OSCAN_TEXT,
		SA_Pens,			NewLook,
		SA_FullPalette,		TRUE,
		SA_AutoScroll,		( sw != STDSCREENWIDTH ) || ( sh != STDSCREENHEIGHT ),
		TAG_DONE
	);
	if ( ! s ) ExitChess(4);

	vp = &(s->ViewPort);
	vi = GetVisualInfo(s, TAG_DONE);

	/* ---------------------------------------------------------------- */
	/* Open main window													*/
	/* ---------------------------------------------------------------- */

	w = OpenWindowTags(
		NULL,
		WA_Left,			0,
		WA_Top,				0,
		WA_IDCMP,			IDCMP_MOUSEBUTTONS	|
							IDCMP_GADGETUP		|
							IDCMP_MENUPICK		|
							IDCMP_REQVERIFY		|
							IDCMP_INTUITICKS	|
							IDCMP_REFRESHWINDOW,
		WA_CustomScreen,	s,
		WA_Flags,			WFLG_ACTIVATE		|
							WFLG_BORDERLESS		|
							WFLG_BACKDROP		|
							WFLG_SMART_REFRESH,
		WA_AutoAdjust,		TRUE,
		TAG_DONE
	);
	if ( ! w ) ExitChess(5);

	rp = w->RPort;

	/* ---------------------------------------------------------------- */
	/* Allocate ASL file requester										*/
	/* ---------------------------------------------------------------- */

	freq = (struct FileRequester *) AllocAslRequestTags(
		ASL_FileRequest,
		ASLFR_Window,			w,
		ASLFR_InitialLeftEdge,	0,
		ASLFR_InitialTopEdge,	24,
		ASLFR_InitialWidth,		421,
		ASLFR_InitialHeight,	421,
		ASLFR_SleepWindow,		TRUE,
		ASLFR_TextAttr,			&TA_Courier15,
		ASLFR_RejectIcons,		TRUE,
		TAG_DONE
	);
	if ( ! freq ) ExitChess(6);

	/* ---------------------------------------------------------------- */
	/* Create and install menus											*/
	/* ---------------------------------------------------------------- */

	Menu = CreateMenus(
		NM,
		GTMN_FrontPen,		COLOR_TXTFGR,
		GTMN_FullMenu,		TRUE,
		TAG_DONE
	);
	if ( ! Menu ) ExitChess(7);

	if ( ! LayoutMenus(Menu, vi, GTMN_TextAttr, &TA_Courier15, TAG_DONE ) )
		ExitChess(8);

	if ( ! SetMenuStrip(w, Menu) ) ExitChess(9);

	/* ---------------------------------------------------------------- */
	/* Initialize Gadgets												*/
	/* ---------------------------------------------------------------- */

	InitGads();

	/* ---------------------------------------------------------------- */
	/* Render basic graphics											*/
	/* ---------------------------------------------------------------- */

	SetRast(rp, COLOR_BCK);

	DrawBevelBox(
		rp,
		NX1 - 2,			NY1 - 2,
		NX2 - NX1 + 5,		NY2 - NY1 + 5,
		GT_VisualInfo,		vi,
		TAG_DONE
	);
	DrawBevelBox(
		rp,
		NX1 - 1,			NY1 - 1,
		NX2 - NX1 + 3,		NY2 - NY1 + 3,
		GT_VisualInfo,		vi,
		TAG_DONE
	);
	DrawBevelBox(
		rp,
		TX1 - 2,			TY1 - 2,
		TX2 - TX1 + 5,		TY2 - TY1 + 5,
		GT_VisualInfo,		vi,
		TAG_DONE
	);
	DrawBevelBox(
		rp,
		TX1 - 1,			TY1 - 1,
		TX2 - TX1 + 3,		TY2 - TY1 + 3,
		GT_VisualInfo,		vi,
		TAG_DONE
	);

	SetAPen(rp, COLOR_TXTBCK);
	RectFill(rp, NX1, NY1, NX2, NY2);
	RectFill(rp, TX1, TY1, TX2, TY2);

	SetAPen(rp, COLOR_RAHMEN);
	for ( y = -1; y <= 7; y++ ) {
		Move(rp, XPOS(0)-2, YPOS(y)-1);
		Draw(rp, XPOS(8)-1, YPOS(y)-1);
		Move(rp, XPOS(0)-2, YPOS(y)-2);
		Draw(rp, XPOS(8)-1, YPOS(y)-2);
	}
	for ( x = 0; x <= 8; x++ ) {
		Move(rp, XPOS(x)-2, YPOS(-1)-1);
		Draw(rp, XPOS(x)-2, YPOS( 7)-1);
		Move(rp, XPOS(x)-1, YPOS(-1)-1);
		Draw(rp, XPOS(x)-1, YPOS( 7)-1);
	}

	Fit_All_Text();
	ResetVars();
}

/* -------------------------------------------------------------------- */
/* Clean up, de-allocate everything opened at runtime, exit gracefully	*/
/* -------------------------------------------------------------------- */

void ExitChess( int error )
{
	if ( error			) ShowError( error );
	if ( w				) { ClearMenuStrip(w); CloseWindow(w); }
	if ( Menu			) 	FreeMenus(Menu);
				  			FreeGads();
	if ( vi				)	FreeVisualInfo(vi);
	if ( s				)	CloseScreen(s);
	if ( freq			)	FreeAslRequest((APTR) freq);
	if ( TF_Courier15	)	CloseFont(TF_Courier15);
	if ( TF_Times15		)	CloseFont(TF_Times15);
	if ( TF_Times18		)	CloseFont(TF_Times18);
	if ( rk				)	FreeRemember(&rk, TRUE);
	exit(0);
}

/* -------------------------------------------------------------------- */
/* This function is called every time the user is prompted for a move.	*/
/* -------------------------------------------------------------------- */

void InputCommand(void)
{
	short				ok,
						i;
	long				cnt,
						rate,
						t1,
						t2;
	unsigned short		mv;
	char				s[5]		= "a1a1",
						line[40];
	struct IntuiMessage	*msg;
	int					selected	= FALSE,
						toggle		= TRUE,
						sq1			= 0,
						sq2,
						mustredraw	= FALSE;

	ok		=
	quit	= false;
	player	= opponent;
	ft		= 0;

	/* ---------------------------------------------------------------- */
	/* Main input event selector loop									*/
	/* ---------------------------------------------------------------- */

	while ( ! ( ok || quit ) ) {
		WaitPort(IDCMPORT);
		msg = GT_GetIMsg(IDCMPORT);
		switch ( CLASS(msg) ) {

			/* -------------------------------------------------------- */
			/* Refresh window event, required for GadTools				*/
			/* -------------------------------------------------------- */

			case IDCMP_REFRESHWINDOW:
				GT_BeginRefresh(w);
				GT_EndRefresh(w, TRUE);
				break;

			/* -------------------------------------------------------- */
			/* Intuiticks, used for blinking selected square			*/
			/* -------------------------------------------------------- */

			case IDCMP_INTUITICKS:
				if ( selected ) {
					if ( toggle )
						SetRGB4(
							vp,
							COLOR_FMARK,
							ColorSpec[COLOR_RAHMEN].Red,
							ColorSpec[COLOR_RAHMEN].Green,
							ColorSpec[COLOR_RAHMEN].Blue
						);
					else
						SetRGB4(
							vp,
							COLOR_FMARK,
							ColorSpec[COLOR_FMARK].Red,
							ColorSpec[COLOR_FMARK].Green,
							ColorSpec[COLOR_FMARK].Blue
						);
					toggle = ! toggle;
				}
				chkabort();
				break;

			/* -------------------------------------------------------- */
			/* Mousebuttons, select start and end square for moves		*/
			/* -------------------------------------------------------- */

			case IDCMP_MOUSEBUTTONS:
				if ( mustredraw ) {
					UpdateDisplay(0, 0, 1, 0);
					mustredraw = FALSE;
				}
				if ( ! selected ) {
					if ( ( CODE(msg) & IECODE_UP_PREFIX ) && MFeld(msg, &sq1) ) {
						if ( color[sq1] == opponent ) {
							selected = TRUE;
							MarkField(sq1);
						}
					}
				}
				else {
					if ( ( CODE(msg) & IECODE_UP_PREFIX ) && MFeld(msg, &sq2) ) {
						if ( color[sq2] != opponent ) {
							s[0] = 'a' + (sq1 & 7);
							s[1] = '1' + (sq1 / 8);
							s[2] = 'a' + (sq2 & 7);
							s[3] = '1' + (sq2 / 8);
							player = opponent;
							ok = VerifyMove(s, 0, &mv);
							if ( ok && mv != hint )
								Sdepth	=
								ft		= 0;
							UnMarkField(sq1);
							selected = FALSE;
						}
					}
				}
				break;

			/* -------------------------------------------------------- */
			/* Gadget selection, currently none defined					*/
			/* -------------------------------------------------------- */

			case IDCMP_GADGETUP:
				break;

			/* -------------------------------------------------------- */
			/* Menu selection											*/
			/* -------------------------------------------------------- */

			case IDCMP_MENUPICK:
				if ( mustredraw ) {
					UpdateDisplay(0, 0, 1, 0);
					mustredraw = FALSE;
				}
				if ( selected ) {
					UnMarkField(sq1);
					selected = FALSE;
				}
				switch( CODE(msg) ) {
					case PROJECT_ABOUT:
						About();
						break;
					case PROJECT_NEWGAME:
						NewGame();
						break;
					case PROJECT_GETGAME:
						GetGame();
						break;
					case PROJECT_SAVEGAME:
						SaveGame();
						break;
					case PROJECT_SAVEEXT:
						SaveGame();
						break;
					case PROJECT_LISTGAME:
						ListGame();
						break;
					case PROJECT_QUIT:
						quit = true;
						break;
					case EDIT_EDITBOARD:
						EditBoard();
						break;
					case EDIT_GAMEDATA:
						PartieData();
						break;
					case EDIT_FORCE:
						force = ! force;
						break;
					case GAME_UNDO:
						if ( GameCnt >= 0 )
							Undo();
						break;
					case GAME_REMOVE:
						if ( GameCnt >= 1 ) {
							Undo();
							Undo();
						}
						break;
					case GAME_HINT:
						GiveHint();
						break;
					case GAME_SWITCHSIDES:
						computer	= otherside[computer];
						opponent	= otherside[opponent];
						force		= false;
						Sdepth		= 0;
						ok			= true;
						break;
					case GAME_COMPUTERWHITE:
						computer	= white;
						opponent	= black;
						ok			= true;
						force		= false;
						Sdepth		= 0;
						UpdateDisplay(0, 0, 1, 0);
						break;
					case GAME_COMPUTERBLACK:
						computer	= black;
						opponent	= white;
						ok			= true;
						force		= false;
						Sdepth		= 0;
						UpdateDisplay(0, 0, 1, 0);
						break;
					case GAME_COMPUTERBOTH:
						bothsides	= !bothsides;
						Sdepth		= 0;
						SelectMove(opponent, 1);
						ok			= true;
						UpdateDisplay(0, 0, 1, 0);
						break;
					case GAME_RESETVARS:
						ResetVars();
						break;
					case LEVEL_60_IN_005:
						TCmoves		= 60;
						TCminutes	= 5;
						TCflag		= true;
						SetTimeControl();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case LEVEL_60_IN_015:
						TCmoves		= 60;
						TCminutes	= 15;
						TCflag		= true;
						SetTimeControl();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case LEVEL_60_IN_030:
						TCmoves		= 60;
						TCminutes	= 30;
						TCflag		= true;
						SetTimeControl();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case LEVEL_40_IN_030:
						TCmoves		= 40;
						TCminutes	= 30;
						TCflag		= true;
						SetTimeControl();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case LEVEL_40_IN_060:
						TCmoves		= 40;
						TCminutes	= 60;
						TCflag		= true;
						SetTimeControl();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case LEVEL_40_IN_120:
						TCmoves		= 40;
						TCminutes	= 120;
						TCflag		= true;
						SetTimeControl();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case LEVEL_40_IN_240:
						TCmoves		= 40;
						TCminutes	= 240;
						TCflag		= true;
						SetTimeControl();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case LEVEL_01_IN_015:
						TCmoves		= 1;
						TCminutes	= 15;
						TCflag		= false;
						SetTimeControl();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case LEVEL_01_IN_060:
						TCmoves		= 1;
						TCminutes	= 60;
						TCflag		= false;
						SetTimeControl();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case LEVEL_01_IN_600:
						TCmoves		= 1;
						TCminutes	= 600;
						TCflag		= false;
						SetTimeControl();
						UpdateDisplay(0, 0, 1, 0);
						break;
					case PROPERTIES_HASH:
						hashflag	= ! hashflag;
						break;
					case PROPERTIES_BOOK:
						Book		= NULL;
						break;
					case PROPERTIES_BEEP:
						beep		= ! beep;
						break;
					case PROPERTIES_POST:
						post		= ! post;
						break;
					case PROPERTIES_REVERSE:
						reverse		= ! reverse;
						UpdateDisplay(0, 0, 1, 0);
						break;
					case PROPERTIES_RANDOM:
						dither		= 6;
						break;
					case DEBUG_AWINDOW:
						ChangeAlphaWindow();
						break;
					case DEBUG_BWINDOW:
						ChangeBetaWindow();
						break;
					case DEBUG_DEPTH:
						ChangeSearchDepth();
						break;
					case DEBUG_CONTEMPT:
						SetContempt();
						break;
					case DEBUG_XWINDOW:
						ChangeXwindow();
						break;
					case DEBUG_TEST:
						t1			= time(0);
						cnt			= 0;
						for ( i = 0; i < 10000; i++ ) {
							MoveList(opponent, 2);
							cnt += TrPnt[3] - TrPnt[2];
						}
						t2			= time(0);
						rate		= cnt / (t2-t1);
						sprintf(line, "cnt = %ld  rate = %ld", cnt, rate);
						ShowMessage(line);
						break;
					case DEBUG_SHOWPOSTNVAL:
						ShowPostnValues();
						mustredraw = TRUE;
						break;
					case DEBUG_DEBUG:
						DoDebug();
						mustredraw = TRUE;
						break;
				}
				break;
		}
		GT_ReplyIMsg(msg);
	}
    
	ClearMessage();
	ElapsedTime(1);
	if ( force ) {
		computer = opponent;
		opponent = otherside[computer];
	}
	timer(tmbuf1);
	time1 = 60 * tmbuf1[0] + tmbuf1[1] / 16667;
	signal(SIGINT, TerminateSearch);
}

/* -------------------------------------------------------------------- */
/* This is called if two successive breaks (CTRL-C) are sent 			*/
/* -------------------------------------------------------------------- */

static void Die(int dummy)
{
	static struct EasyStruct es = {
		sizeof(struct EasyStruct),
		0,
		"Please select",
		"Abort?",
		"Yes|No"
	};

	signal(SIGINT, SIG_IGN);
	if ( EasyRequestArgs(w, &es, NULL, NULL) == 1 ) ExitChess(0);
	signal(SIGINT, Die);
}

/* -------------------------------------------------------------------- */
/* This is called if a break (CTRL-C) is sent while GNUChess thinks		*/
/* -------------------------------------------------------------------- */

static void TerminateSearch(int dummy)
{
	signal(SIGINT, SIG_IGN);
	timeout		= true;
	bothsides	= false;
	signal(SIGINT, Die);
}

/* -------------------------------------------------------------------- */
/* Display current search depth											*/
/* -------------------------------------------------------------------- */

void ShowDepth(char ch)
{
	char buf[40];

	sprintf(buf, "Depth = %2ld%lc", Sdepth, ch);
	MyText(buf, NX1 + 6, NY1 + 13);
}

/* -------------------------------------------------------------------- */
/* Display evaluated position score and best line found					*/
/* -------------------------------------------------------------------- */

void ShowResults(short score, unsigned short *bstline, char ch)
{
	short	ply;
	char	buf[40];
	int		x, y;

	if ( post && player == computer ) {
		sprintf(buf, "Score = %5ld", score);
		MyText(buf, NX1 + 125, NY1 + 13);
		SetAPen(rp, COLOR_TXTBCK);
		RectFill(rp,
			NX1 +   6, NY1 +  20,
			NX1 + 231, NY1 + 100
		);
		for ( ply = 0; bstline[ply+1] > 0; ply++ ) {
			x = NX1 + 45 * ( ply % 5 ) +  6;
			y = NY1 + 17 * ( ply / 5 ) + 33;
			algbr(bstline[ply+1] >> 8, bstline[ply+1] & 0xFF, false);
			MyText(mvstr1, x, y);
		}
	}
}

/* -------------------------------------------------------------------- */
/* This is called every time GNUChess calculation is started			*/
/* -------------------------------------------------------------------- */

void SearchStartStuff(short side)
{
	signal(SIGINT, TerminateSearch);
	if ( player == computer ) {
		SetAPen(rp, COLOR_TXTBCK);
		RectFill(rp, NX1, NY1, NX2, NY2);
	}
}

/* -------------------------------------------------------------------- */
/* Display move GNUChess did											*/
/* -------------------------------------------------------------------- */

void OutputMove(void)
{
	char buf[40];

	if ( root->flags & epmask )
		UpdateDisplay(0, 0, 1, 0);
	else
		UpdateDisplay(root->f, root->t, 0, root->flags & cstlmask);

	strcpy(buf, "My move is: ");
	strcat(buf, mvstr1);

	MyText("                           ", TX1 + 6, TY2 - 27);
	MyText(buf, TX1 + 6, TY2 - 27);

	if ( beep ) DisplayBeep(NULL);

	if ( root->flags & draw )        MyText("Draw game!              ", TX1 + 6, TY2 - 26);
	else if ( root->score == -9999 ) MyText("opponent mates!         ", TX1 + 6, TY2 - 26);
	else if ( root->score ==  9998 ) MyText("computer mates!         ", TX1 + 6, TY2 - 26);
	else if ( root->score <  -9000 ) MyText("opponent will soon mate!", TX1 + 6, TY2 - 26);
	else if ( root->score >   9000 ) MyText("computer will soon mate!", TX1 + 6, TY2 - 26);
  
	if ( post ) {
		sprintf(buf, "Nodes     = %8ld", NodeCnt);
		MyText(buf, NX1 + 6, NY1 + 132);
		sprintf(buf, "Nodes/Sec = %8ld", evrate);
		MyText(buf, NX1 + 6, NY1 + 144);
	}
}

/* -------------------------------------------------------------------- */
/* Determine the time that has passed since the search was started.  If	*/
/* the  elapsed  time  exceeds the target (ResponseTime+ExtraTime) then	*/
/* set timeout to true which will terminate the search.					*/
/* -------------------------------------------------------------------- */

void ElapsedTime(short iop)
{
	et = time(NULL) - time0;
	if ( et < 0 )
		et = 0;
	ETnodes += 50;
	if ( et > et0 || iop == 1 ) {
		if ( et > ResponseTime + ExtraTime && Sdepth > 1 )
			timeout = true;
		et0 = et;
		if ( iop == 1 ) {
			time0	= time(NULL);
			et0		= 0;
		}
		timer(tmbuf2);
		time2		= 60 * tmbuf2[0] + tmbuf1[1] / 16667;
		cputimer	= 100 * (time2 - time1) / HZ;
		evrate		= ( cputimer > 0 ) ? (100 * NodeCnt) / (cputimer + 100 * ft) : 0;
		ETnodes		= NodeCnt + 50;
		UpdateClocks();
	}
}

static void UpdateClocks(void)
{
	int		m, s;
	char	buf[40];

	chkabort();

	m = et / 60;
	s = et % 60;
	if ( TCflag ) {
		m = (TimeControl.clock[player] - et) / 60;
		s = (TimeControl.clock[player] - et) % 60;
	}
	if ( m < 0 )
		m = 0;
	if ( s < 0 )
		s = 0;

	sprintf(buf, "%03ld:%02ld:%02ld", m / 60, m % 60, s);

	if ( player == white )
		MyText(buf, TX1 + off_clock_left , TY1 + 30);
	else
		MyText(buf, TX1 + off_clock_right, TY1 + 30);

	if ( post ) {
		sprintf(buf, "Nodes     = %8ld", NodeCnt);
		MyText(buf, NX1 + 6, NY1 + 132);
		sprintf(buf, "Nodes/Sec = %8ld", evrate);
		MyText(buf, NX1 + 6, NY1 + 144);
	}
}

void SetTimeControl(void)
{
	if ( TCflag ) {
		TimeControl.moves[white] =
		TimeControl.moves[black] = TCmoves;
		TimeControl.clock[white] =
		TimeControl.clock[black] = 60 * TCminutes;
    }
	else {
		TimeControl.moves[white] =
		TimeControl.moves[black] =
		TimeControl.clock[white] =
		TimeControl.clock[black] = 0;
		Level = 60 * TCminutes;
	}
	et = 0;
	ElapsedTime(1);
}

void DrawPiece(short sq)
{
	int piece;

	piece = ( color[sq] == black ) ? qxx[board[sq]] : pxx[board[sq]];
	if ( reverse )
		DrawFeld(piece, 7 - column[sq], 7 - row[sq]);
	else
		DrawFeld(piece, column[sq], row[sq]);
}

void UpdateDisplay(short f, short t, short flag, short iscastle)
{
	short l; 

	if ( flag ) {
		ResetGfx();
		if ( bothsides ) {
			MyText("Computer" , TX1 + off_comp_left  , TY1 + 13);
			MyText("Computer" , TX1 + off_comp_right , TY1 + 13);
		}
		else
			if ( computer == white ) {
				MyText("Computer" , TX1 + off_comp_left  , TY1 + 13);
				MyText("  Human  ", TX1 + off_human_right, TY1 + 13);
			}
			else {
				MyText("  Human  ", TX1 + off_human_left , TY1 + 13);
				MyText("Computer" , TX1 + off_comp_right , TY1 + 13);
			}

		for (l = 0; l < 64; l++)
			DrawPiece(l);
	}
	else {
		DrawPiece(f);
		DrawPiece(t);
		if ( iscastle )
			if (t > f) {
				DrawPiece(f+3);
				DrawPiece(t-1);
			}
	        else {
				DrawPiece(f-4);
				DrawPiece(t+1);
			}
	}
}

/* -------------------------------------------------------------------- */
/* Read in the Opening Book file and parse the algebraic notation for a	*/
/* move  into  an  unsigned  integer  format indicating the from and to	*/
/* square.   Create  a  linked  list  of  opening  lines  of play, with	*/
/* entry->next  pointing to the next line and entry->move pointing to a	*/
/* chunk  of  memory containing the moves.  More Opening lines of up to	*/
/* 256 half moves may be added to gnuchess.book.						*/
/* -------------------------------------------------------------------- */

void GetOpenings(void)
{
	FILE				*fd;
	int					c, i, j, side;
	struct BookEntry	*entry;
	unsigned short		mv, *mp, tmp[100];

	if ( fd = fopen("gnuchess.book", "r") ) {
		Book	= NULL;
		i		= 0;
		side	= white;
		while ( (c = parse(fd, &mv, side)) >= 0 )
			if ( c == 1 ) {
				tmp[++i]	= mv;
				side		= otherside[side];
			}
			else
				if ( c == 0 && i > 0 ) {
					entry = (struct BookEntry *)
						AllocRemember(&rk, sizeof(struct BookEntry), MEMF_PUBLIC);
					mp = (unsigned short *)
						AllocRemember(&rk, (i+1) * sizeof(unsigned short), MEMF_PUBLIC);
					entry->mv	= mp;
					entry->next	= Book;
					Book		= entry; 
					for ( j = 1; j <= i; j++ )
						*(mp++) = tmp[j];
					*mp		=
					i		= 0;
					side	= white;
				}
		fclose(fd);
	}
}


static int parse(FILE *fd, unsigned short *mv, short side)
{
	int		c, i, r1, r2, c1, c2;
	char	s[100];

	while ( ( c = getc(fd) ) == ' ' ) { ; }
	i		= 0;
	s[0]	= c;
	while ( c != ' ' && c != '\n' && c != EOF )
		s[++i]	=
		c		= getc(fd);
	s[++i] = '\0';
	if ( c == EOF )
		return -1;
	if ( s[0] == '!' || i < 3 ) {
		while ( c != '\n' && c != EOF )
			c = getc(fd);
		return 0;
	}
	if ( s[4] == 'o' )
		*mv = ( side == black ) ? 0x3C3A : 0x0402;
	else
		if ( s[0] == 'o' )
			*mv = ( side == black ) ? 0x3C3E : 0x0406;
		else {
			c1	= s[0] - 'a';
			r1	= s[1] - '1';
			c2	= s[2] - 'a';
			r2	= s[3] - '1';
			*mv	= ( locn[r1][c1] << 8 ) + locn[r2][c2];
		}
	return 1;
}

static void GetGame(void)
{
	FILE			*fd;
	char			fname[FMSIZE];
	int				c;
	BOOL			success;
	short			sq;
	unsigned short	m;

	success = AslRequestTags(
		freq,
		ASLFR_TitleText,	"Load Game File",
		ASLFR_InitialFile,	"chess.000",
		TAG_DONE
	);
	if ( success ) {
		strmfp(fname, freq->rf_Dir, freq->rf_File);
		if ( fd = fopen(fname, "r") ) {
			fscanf(
				fd,
				"%hd%hd%hd" "%hd%hd%hd%hd" "%hd%hd" "%ld%ld%hd%hd",
				&computer,
				&opponent,
				&Game50,

				&castld[white],
				&castld[black],
				&kingmoved[white],
				&kingmoved[black],

				&TCflag,
				&OperatorTime,

				&TimeControl.clock[white],
				&TimeControl.clock[black],
				&TimeControl.moves[white],
				&TimeControl.moves[black]
			);
			for ( sq = 0; sq < 64; sq++ ) {
				fscanf(fd, "%hd", &m);
				board[sq] = (m >> 8);
				color[sq] = (m & 0xFF);
				if ( color[sq] == 0 )
					color[sq] = neutral;
				else
					--color[sq];
			}
			GameCnt = -1;
			c = '?';
			while ( c != EOF ) {
				++GameCnt;
				c = fscanf(fd, "%hd%hd%hd%ld%hd%hd%hd",
						&GameList[GameCnt].gmove,
						&GameList[GameCnt].score,
						&GameList[GameCnt].depth,
						&GameList[GameCnt].nodes,
						&GameList[GameCnt].time,
						&GameList[GameCnt].piece,
						&GameList[GameCnt].color
				);
				if ( GameList[GameCnt].color == 0 )
					GameList[GameCnt].color = neutral;
				else
					--GameList[GameCnt].color;
			}
			GameCnt--;
			if ( TimeControl.clock[white] > 0 )
				TCflag = true;
			computer--;
			opponent--;
		}
		fclose(fd);
		InitializeStats();
		UpdateDisplay(0, 0, 1, 0);
		Sdepth = 0;
	}
}


static void SaveGame(void)
{
	FILE	*fd;
	char	fname[FMSIZE];
	short	sq, i, c;
	BOOL	success;

	success = AslRequestTags(
		freq,
		ASLFR_TitleText,	"Save Game File",
		ASLFR_InitialFile,	"chess.000",
		ASLFR_DoSaveMode,	TRUE,
		TAG_DONE
	);
	if ( success ) {
		strmfp(fname, freq->rf_Dir, freq->rf_File);
		if ( fd = fopen(fname, "w") ) {
			fprintf(
				fd,
				"%ld %ld %ld\n" "%ld %ld %ld %ld\n" "%ld %ld\n" "%ld %ld %ld %ld\n",
				computer+1,
				opponent+1,
				Game50,

	    	    castld[white],
				castld[black],
				kingmoved[white],
				kingmoved[black],

				TCflag,
				OperatorTime,

				TimeControl.clock[white],
				TimeControl.clock[black],
				TimeControl.moves[white],
				TimeControl.moves[black]
			);
			for ( sq = 0; sq < 64; sq++ ) {
				c = (color[sq] == neutral) ? 0 : color[sq]+1;
				fprintf(fd,"%ld\n",256*board[sq] + c);
			}
			for ( i = 0; i <= GameCnt; i++ ) {
				c = (GameList[i].color == neutral) ? 0 : GameList[i].color + 1;
				fprintf(
					fd,
					"%ld %ld %ld %ld %ld %ld %ld\n",
					GameList[i].gmove,
					GameList[i].score,
					GameList[i].depth,
					GameList[i].nodes,
					GameList[i].time,
					GameList[i].piece,
					c
				);
			}
			fclose(fd);
		}
	}
}


static void ListGame(void)
{
	FILE	*fd;
	short	i, f, t;
	BOOL	success;
	char	name[FMSIZE];

	success = AslRequestTags(
		freq,
		ASLFR_TitleText,	"List Game",
		ASLFR_InitialFile,	"chess.lst",
		ASLFR_DoSaveMode,	TRUE,
		TAG_DONE
	);
	if ( success ) {
		strmfp(name, freq->rf_Dir, freq->rf_File);
		if ( fd = fopen(name, "w") ) {
			fprintf(
				fd,
				"\n"
				"       score  depth  nodes  time         "
				"       score  depth  nodes  time\n"
			);
			for ( i = 0; i <= GameCnt; i++ ) {
				f = GameList[i].gmove >> 8;
				t = (GameList[i].gmove & 0xFF);
				algbr(f, t, false);
				fprintf(
					fd,
					(i % 2) ? "         " : "\n"
				);
				fprintf(
					fd,
					"%5s  %5ld     %2ld %6ld %5ld",
					mvstr1,
					GameList[i].score,
					GameList[i].depth,
					GameList[i].nodes,
					GameList[i].time
				);
			}
			fprintf(
				fd,
				"\n\n"
			);
			fclose(fd);
		}
	}
} 

/* -------------------------------------------------------------------- */
/* Undo the most recent half-move.										*/
/* -------------------------------------------------------------------- */

static void Undo(void)
{
	short f, t;

	f = GameList[GameCnt].gmove >> 8;
	t = GameList[GameCnt].gmove & 0xFF;
	if ( board[t] == king && distance(t, f) > 1 )
		castle(GameList[GameCnt].color, f, t, 2);
	else {
		board[f] = board[t];
		color[f] = color[t];
		board[t] = GameList[GameCnt].piece;
		color[t] = GameList[GameCnt].color;
		if ( board[f] == king )
			--kingmoved[color[f]];
	}
	if ( TCflag )
		++TimeControl.moves[color[f]];
	GameCnt--;
	mate	= false;
	Sdepth	= 0;
	UpdateDisplay(0, 0, 1, 0);
	InitializeStats();
}

void ShowMessage(char *s)
{
	ClearMessage();
	MyText(s, TX1 + 6, TY2 - 10);
}

void ClearMessage(void)
{
	MyText("                          ", TX1 + 6, TY2 - 10);
}

void ClrScreen(void)
{
	ClearMessage();
}

void ShowCurrentMove(short pnt, short f, short t)
{
	char buf[40];

	algbr(f, t, false);
	sprintf(buf, "(%2ld) %4s", pnt, mvstr1);
	MyText(buf, NX1 + 6, NY1 + 114);
}

void ShowSidetomove(void)
{
}

static void ChangeAlphaWindow(void)
{
	Awindow = NumberRequest("Alpha window size:", Awindow);
}

static void ChangeBetaWindow(void)
{
	Bwindow = NumberRequest("Beta window size:", Bwindow);
}

static void GiveHint(void)
{
	char s[40];

	algbr((short) (hint >> 8), (short) (hint & 0xFF), false);
	strcpy(s, "try ");
	strcat(s, mvstr1);
	ShowMessage(s);
}

static void ChangeSearchDepth(void)
{
	MaxSearchDepth = NumberRequest("Search depth:", MaxSearchDepth);
}

static void SetContempt(void)
{
	contempt = NumberRequest("Contempt value:", contempt);
}

static void ChangeXwindow(void)
{
	xwndw = NumberRequest("X window size:", xwndw);
}

void SelectLevel(void)
{
	OperatorTime	= 0;
	TCmoves			= 60;
	TCminutes		= 30;
	TCflag			= true;
	SetTimeControl();
	UpdateDisplay(0, 0, 1, 0);
}

static void ShowPostnValues(void)
{
	short i, r, c;
	char line[40];

	ExaminePosition();
	for ( i = 0; i < 64; i++ ) {
		if ( reverse ) {
			r = 7-row[i];
			c = 7-column[i];
		}
		else {
			r = row[i];
			c = column[i];
		}
		c1		= color[i];
		c2		= otherside[c1];
		PC1		= PawnCnt[c1];
		PC2		= PawnCnt[c2];
		atk1	= atak[c1];
		atk2	= atak[c2];
		if ( color[i] != neutral ) {
			sprintf(line, "%3ld", SqValue(i,opponent));
			MyText(line, XPOS(c)+FELDBREITE/2-15, YPOS(r)+FELDHOEHE/2+10);
		}
	}
	ScorePosition(opponent, &i);
	sprintf(line, "Score = %ld", i);
	ShowMessage(line);
}

static void DoDebug(void)
{
	short k, p, i, r, c, tp, tc;
	char s[40];

	ExaminePosition();
	strcpy(s, StringRequest("Enter piece:", ""));
	k = (s[0] == 'w') ? white : black;
	switch ( s[1] ) {
		case 'p':
			p = pawn;
			break;
		case 'n':
			p = knight;
			break;
		case 'b':
			p = bishop;
			break;
		case 'r':
			p = rook;
			break;
		case 'q':
			p = queen;
			break;
		case 'k':
			p = king;
			break;
		default:
			p = no_piece;
			break;
	}
	for ( i = 0; i < 64; i++ ) {
		if ( reverse ) {
			r = 7-row[i];
			c = 7-column[i];
		}
		else {
			r = row[i];
			c = column[i];
		}
		tp			= board[i];
		tc			= color[i];
		board[i]	= p;
		color[i]	= k;
		c1			= k;
		c2			= otherside[c1];
		PC1			= PawnCnt[c1];
		PC2			= PawnCnt[c2];
		atk1		= atak[c1];
		atk2		= atak[c2];
		sprintf(s, "%3ld", SqValue(i,opponent));
		MyText(s, XPOS(c)+FELDBREITE/2-15, YPOS(r)+FELDHOEHE/2+10);
		board[i]	= tp;
		color[i]	= tc;
	}
	ScorePosition(opponent, &i);
	sprintf(s, "Score = %ld", i);
	ShowMessage(s);
}

/* -------------------------------------------------------------------- */
/* Display error message												*/
/* -------------------------------------------------------------------- */

static char *errmsg[] = {
	"\0\012\014No error\0\0",										//  0
	"\0\012\014IGNUChess: Cannot open font times/15\0\0",			//  1
	"\0\012\014IGNUChess: Cannot open font times/18\0\0",			//  2
	"\0\012\014IGNUChess: Cannot open font courier/15\0\0",			//  3
	"\0\012\014IGNUChess: Cannot open screen\0\0",					//  4
	"\0\012\014IGNUChess: Cannot open main window\0\0",				//  5
	"\0\012\014IGNUChess: Cannot allocate file reqester\0\0",		//	6
	"\0\012\014IGNUChess: Cannot create menu strip\0\0",			//  7
	"\0\012\014IGNUChess: Layout of menu failed\0\0",				//  8
	"\0\012\014IGNUChess: Cannot attach menu strip to window\0\0",	//  9
	"\0\012\014IGNUChess: Cannot reset menu strip\0\0",				// 10
	"\0\012\014IGNUChess: Cannot create gadget list 1\0\0",			// 11
	"\0\012\014IGNUChess: Cannot create gadget list 2\0\0",			// 12
	"\0\012\014IGNUChess: Cannot find appropriate screen mode\0\0",	// 13
	"\0\012\014IGNUChess: Cannot get dimensions of screen mode\0\0"	// 14
};

static void ShowError( int error )
{
	DisplayAlert( RECOVERY_ALERT, errmsg[ error ], 20 );
}

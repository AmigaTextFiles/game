/* amiga_data.c
 *
 *  ``pinfocom'' -- a portable Infocom Inc. data file interpreter.
 *  Copyright (C) 1987-1992  InfoTaskForce
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; see the file COPYING.  If not, write to the
 *  Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * $Header: RCS/amiga_data.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#ifndef _AMIGA_GLOBAL_H

#define _AMIGA_DATA_C
#include "amiga_global.h"

#endif	/* !_AMIGA_GLOBAL_H */

	/* Clipboard support data. */

struct IFFHandle	*ClipHandle;

STRPTR			 ClipBuffer,
			 ClipIndex;

LONG			 ClipSize,
			 ClipLength;

Bool			 ClipInput;

	/* Version identifier. */

STATIC STRPTR		 VersionTag = VERSION_STRING;

	/* Global library pointers, don't touch! */

struct IntuitionBase	*IntuitionBase;
struct GfxBase		*GfxBase;

struct Library		*WorkbenchBase,
			*DiskfontBase,
			*IFFParseBase,
			*GadToolsBase,
			*UtilityBase,
			*IconBase,
			*AslBase;

struct Device		*ConsoleDevice;

	/* Workbench startup message. */

struct WBStartup	*WBenchMsg;

	/* Screen and window data. */

struct Window		*Window;
struct Menu		*Menu;
struct RastPort		*RPort;

struct Screen		*DefaultScreen,
			*Screen;
APTR			 VisualInfo;
UBYTE			 Depth;

	/* Default window title. */

TEXT			 WindowTitle[AMIGADOS_NAME_LIMIT + 1];

	/* Global flags. */

Bool			 UseCustomScreen,
			 WindowIsActive,
			 LibsOpened,
			 NewOS;

	/* Console IO data. */

struct IOStdReq		*ConRequest;
struct InputEvent	*InputEvent;
STRPTR			 InputEventBuffer;

LONG			 CursorX,
			 CursorY,
			 SpaceWidth,
			 LastCursorX,
			 LastCursorY,
			 OldCursorWidth,
			 NewCursorWidth,
			 DefaultCursorWidth;

int			 MenuLockCount;

Bool			 RedrawInputLine,
			 CursorEnabled;

	/* Process and window tricks. */

struct Process		*ThisProcess;
APTR			 WindowPtr;

	/* Timer data. */

struct MsgPort		*TimePort;
struct timerequest	*TimeRequest;

	/* Workbench appwindow support. */

struct MsgPort		*WorkbenchPort;
struct AppWindow	*WorkbenchWindow;

	/* The name of the project to restore. */

TEXT			 ProjectName[MAX_FILENAME_LENGTH];

	/* A temporary string buffer. */

TEXT			 TempBuffer[BUFFER_LENGTH];

	/* Story file name. */

char			*StoryName;

	/* Story serial number. */

ULONG			 StorySerial	= 0,
			 StoryRelease	= 0,
			 StoryIndex	= 0;

	/* Default story file name and file
	 * extension.
	 */

char			*StoryNames[]		= {FNAME_LST,NULL},
			*StoryExtensions[]	= {"",FEXT_LST,NULL};

	/* Two different fonts. */

struct TextFont		*PropFont,
			*FixedFont,
			*ThisFont;

	/* Disk font support. */

struct TextFont		*ListFont,
			*TextFont;

TEXT			 ListFontName[MAXFONTPATH],
			 TextFontName[MAXFONTPATH];

LONG			 FontSize;

struct TextAttr		 ListFontAttr,
			 TextFontAttr;

	/* Text font dimensions. */

UWORD			 TextFontWidth,
			 TextFontHeight;

	/* Window dimensions. */

WORD			 WindowWidth,
			 OldWindowWidth,
			 OldWindowHeight;

	/* Screen characteristics. */

LONG			 ConNumLines,
			 ConLinesPrinted,
			 ConLineContext,
			 ConLineIndent,
			 ConLineMargin;

	/* Text and background pens. */

LONG			 ConTextPen = 1,
			 ConBackPen = 0;

	/* Fixed status window support. */

LONG			 ConNumStatusLines	= 1;
int			 ConOutputWindow	= 0;

	/* History management. */

struct StringBuffer	 HistoryBuffer[HISTORY_LINES];
int			 LastHistory = -1;

	/* Function key support. */

struct StringBuffer	 FunctionKeys[NUM_FKEYS];

	/* Fake input buffer. */

TEXT			 InputBuffer[INPUT_LENGTH];
STRPTR			 InputIndex;

	/* Data to be located in chip-memory. */

UWORD			*ChipData;

	/* Pull-down menu definitions. */

struct NewMenu ConMenuConfig[NUM_MENUS] =
{
	{NM_TITLE, "Project",					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "About...",					"?",NULL,	0,NULL},
	{ NM_ITEM, NM_BARLABEL,					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Save as...",				"A",NULL,	0,"Save\r"},
	{ NM_ITEM, "Open...",					"O",NULL,	0,"Restore\r"},
	{ NM_ITEM, NM_BARLABEL,					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Script...",					"P",MENU_TICK,	0,NULL},
	{ NM_ITEM, NM_BARLABEL,					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Restart...",				"R",NULL,	0,"Restart\r"},
	{ NM_ITEM, NM_BARLABEL,					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Quit...",					"Q",NULL,	0,"Quit\r"},

	{NM_TITLE, "Edit",					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Cut",					"X",NULL,	0,NULL},
	{ NM_ITEM, "Copy",					"C",NULL,	0,NULL},
	{ NM_ITEM, "Paste",					"V",NULL,	0,NULL},
	{ NM_ITEM, NM_BARLABEL,					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Undo",					"Z",NULL,	0,NULL},

	{NM_TITLE, "Commands",					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Look",					"L",NULL,	0,"Look\r"},
	{ NM_ITEM, "Inventory",					"I",NULL,	0,"Inventory\r"},
	{ NM_ITEM, NM_BARLABEL,					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Diagnose",					"D",NULL,	0,"Diagnose\r"},
	{ NM_ITEM, "Score",					"S",NULL,	0,"Score\r"},
	{ NM_ITEM, "Time",					"T",NULL,	0,"Time\r"},
	{ NM_ITEM, NM_BARLABEL,					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Wait",					"W",NULL,	0,"Wait\r"},
	{ NM_ITEM, "Again",					"G",NULL,	0,"Again\r"},

	{NM_TITLE, "Story",					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Superbrief",				"<",NULL,	0,"Superbrief\r"},
	{ NM_ITEM, "Brief",					".",NULL,	0,"Brief\r"},
	{ NM_ITEM, "Verbose",					">",NULL,	0,"Verbose\r"},

	{NM_TITLE, "Options",					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "Display object attribute assignments",	"1",MENU_TICK,	0,"@attr\r"},
	{ NM_ITEM, "Display object attribute tests",		"2",MENU_TICK,	0,"@atest\r"},
	{ NM_ITEM, "Echo input",				"3",MENU_TICK,	0,"@echo\r"},
	{ NM_ITEM, "Page text output",				"4",MENU_TICK,	0,"@pager\r"},
	{ NM_ITEM, "Display alternate prompt",			"5",MENU_TICK,	0,"@prompt\r"},
	{ NM_ITEM, "Display status line",			"6",MENU_TICK,	0,"@status\r"},
	{ NM_ITEM, "Display tandy license",			"7",MENU_TICK,	0,"@tandy\r"},
	{ NM_ITEM, "Display object transfers",			"8",MENU_TICK,	0,"@xfers\r"},
	{ NM_ITEM, NM_BARLABEL,					 0 ,NULL,	0,NULL},
	{ NM_ITEM, "List available options",			"!",NULL,	0,"@\r"},

	{NM_END,   NULL,					 0 ,NULL,	0,NULL}
};

	/* Stopwatch mouse pointer data. */

UWORD StopwatchData[(1 + STOPWATCH_HEIGHT + 1) * 2] =
{
	0x0000,0x0000,

	0x0400,0x07C0,
	0x0000,0x07C0,
	0x0100,0x0380,
	0x0000,0x07E0,
	0x07C0,0x1FF8,
	0x1FF0,0x3FEC,
	0x3FF8,0x7FDE,
	0x3FF8,0x7FBE,
	0x7FFC,0xFF7F,
	0x7EFC,0xFFFF,
	0x7FFC,0xFFFF,
	0x3FF8,0x7FFE,
	0x3FF8,0x7FFE,
	0x1FF0,0x3FFC,
	0x07C0,0x1FF8,
	0x0000,0x07E0,

	0x0000,0x0000
};

	/* File requester support. */

struct FileRequester	*GameFileRequest;

	/* Game file release and serial numbers. */

LONG SerialNumbers[][3] =
{
	0,	97,	851218,	/* Ballyhoo */

	1,	23,	840809,	/* Cutthroats */

	2,	26,	821108,	/* Deadline */
	2,	27,	831005,

	3,	10,	830810,	/* Enchanter */
	3,	16,	831118,
	3,	24,	851118,
	3,	29,	860820,

	4,	37,	861215,	/* Hollywood Hijinx */

	5,	22,	830916,	/* Infidel */

	6,	118,	860325,	/* Leather Goddesses of Phobos */
	6,	50,	860711,
	6,	59,	860730,

	7,	4,	860918,	/* Moonmist */
	7,	9,	861022,

	8,	20,	830708,	/* Planetfall */
	8,	29,	840118,
	8,	37,	851003,

	9,	26,	870730,	/* Plundered Hearts */

	10,	15,	840501,	/* Seastalker */
	10,	15,	840522,
	10,	16,	850515,
	10,	16,	850603,

	11,	4,	840131,	/* Sorcerer */
	11,	6,	840508,
	11,	13,	851021,
	11,	15,	851108,

	12,	63,	850916,	/* Spellbreaker */
	12,	87,	860904,

	13,	15,	820901,	/* Starcross */
	13,	17,	821021,

	14,	107,	870430,	/* Stationfall */

	15,	14,	841005,	/* Suspect */

	16,	7,	830419,	/* Suspended */
	16,	8,	830521,
	16,	8,	840521,

	17,	47,	840914,	/* The Hitchhiker's Guide to the Galaxy */
	17,	56,	841221,
	17,	58,	851002,
	17,	59,	851108,

	18,	203,	870506,	/* The lurking Horror */
	18,	219,	870912,
	18,	221,	870918,

	19,	20,	831119,	/* The Witness */
	19,	21,	831208,
	19,	22,	840924,

	20,	68,	850501,	/* Wishbringer: The Magick Stone of Dreams */
	20,	69,	850920,

	21,	28,	821013,	/* Zork I: The Great Underground Empire */
	21,	30,	830330,
	21,	75,	830929,
	21,	76,	840509,
	21,	88,	840726,

	22,	18,	820517,	/* Zork II: The Wizard of Frobozz */
	22,	22,	830331,
	22,	48,	840904,

	23,	15,	830331,	/* Zork III: The Dungeon Master */
	23,	15,	840518,
	23,	17,	840727,

	-1,	0,	0	/* Terminator (not an Infocom game!) */
};

	/* Type 3 game titles. */

char *Titles[NUM_GAMES] =
{
	"Ballyhoo",
	"Cutthroats",
	"Deadline",
	"Enchanter",
	"Hollywood Hijinx",
	"Infidel",
	"Leather Goddesses of Phobos",
	"Moonmist",
	"Planetfall",
	"Plundered Hearts",
	"Seastalker",
	"Sorcerer",
	"Spellbreaker",
	"Starcross",
	"Stationfall",
	"Suspect",
	"Suspended",
	"The Hitchhiker's Guide to the Galaxy",
	"The Lurking Horror",
	"The Witness",
	"Wishbringer: The Magick Stone of Dreams",
	"Zork I: The Great Underground Empire",
	"Zork II: The Wizard of Frobozz",
	"Zork III: The Dungeon Master"
};

	/* Type 3 game authors. */

char *Authors[NUM_GAMES] =
{
	"Jeff O'Neill",
	"Michael Berlyn and Jerry Wolper",
	"Marc Blank",
	"Marc Blank and Dave Lebling",
	"Dave Anderson",
	"Michael Berlyn",
	"Steve Meretzky",
	"Stu Galley and Jim Lawrence",
	"Steve Meretzky",
	"Amy Briggs",
	"Stu Galley and Jim Lawrence",
	"Steve Meretzky",
	"Dave Lebling",
	"Dave Lebling",
	"Steve Meretzky",
	"Dave Lebling",
	"Michael Berlyn",
	"Douglas Adams and Steve Meretzky",
	"Dave Lebling",
	"Stu Galley",
	"Brian Moriarty",
	"Marc Blank and Dave Lebling",
	"Marc Blank and Dave Lebling",
	"Marc Blank and Dave Lebling"
};

	/* Type 3 game levels. */

int GameLevels[NUM_GAMES] =
{
	LEVEL_STANDARD,
	LEVEL_STANDARD,
	LEVEL_EXPERT,
	LEVEL_STANDARD,
	LEVEL_STANDARD,
	LEVEL_ADVANCED,
	LEVEL_STANDARD,
	LEVEL_INTRODUCTORY,
	LEVEL_STANDARD,
	LEVEL_STANDARD,
	LEVEL_INTRODUCTORY,
	LEVEL_ADVANCED,
	LEVEL_EXPERT,
	LEVEL_EXPERT,
	LEVEL_STANDARD,
	LEVEL_ADVANCED,
	LEVEL_EXPERT,
	LEVEL_STANDARD,
	LEVEL_STANDARD,
	LEVEL_STANDARD,
	LEVEL_INTRODUCTORY,
	LEVEL_STANDARD,
	LEVEL_ADVANCED,
	LEVEL_ADVANCED
};

char *Levels[LEVEL_EXPERT + 1] =
{
	"introductory level",
	"standard level",
	"advanced level",
	"expert level"
};

	/* Transcript file support. */

FILE			*ScriptFile;
TEXT			 ScriptFileName[MAX_FILENAME_LENGTH];
int			 ScriptWidth;
Bool			 ScriptAborted;

	/* Sound support. */

struct IOAudio		*SoundRequestLeft,
			*SoundRequestRight,
			*SoundControlRequest;
struct MsgPort		*SoundPort;

	/* Sound file search path. */

char			*SoundName,
			*SoundPath;

	/* Sound file data. */

int			 SoundNumber = -1;
APTR			 SoundData;
LONG			 SoundLength;

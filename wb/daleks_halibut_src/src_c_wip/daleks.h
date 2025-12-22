//=========================================================================
//=========================================================================
//
//	Daleks - includes, defines, externs and structures
//
//	Copyright 1998 Halibut Software/John Girvin, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================

// MUI
#ifndef		LIBRARIES_MUI_H
#include	<libraries/mui.h>
#endif

// System
#include	<exec/exec.h>
//#include	<dos/dos.h>
//#include	<dos/dostags.h>
#include	<libraries/locale.h>
#include	<libraries/gadtools.h>
#include	<utility/utility.h>
#include	<utility/tagitem.h>
#include	<utility/hooks.h>
//#include	<workbench/icon.h>
//#include	<workbench/workbench.h>
//#include	<intuition/classes.h>
#include	<datatypes/datatypes.h>
#include	<datatypes/pictureclass.h>
#include	<datatypes/pictureclassext.h>
#include	<graphics/gfx.h>

// Prototypes
#include	<clib/alib_protos.h>
#include	<clib/exec_protos.h>
//#include	<clib/dos_protos.h>
#include	<clib/intuition_protos.h>
#include	<clib/datatypes_protos.h>
//#include	<clib/icon_protos.h>
//#include	<clib/asl_protos.h>
#include	<clib/utility_protos.h>
#include	<clib/muimaster_protos.h>
#include	<clib/locale_protos.h>
#include	<clib/graphics_protos.h>

// pragmas
#include	<pragmas/exec_pragmas.h>
//#include	<pragmas/dos_pragmas.h>
#include	<pragmas/datatypes_pragmas.h>
#include	<pragmas/intuition_pragmas.h>
//#include	<pragmas/icon_pragmas.h>
//#include	<pragmas/asl_pragmas.h>
#include	<pragmas/utility_pragmas.h>
#include	<pragmas/muimaster_pragmas.h>
#include	<pragmas/locale_pragmas.h>
#include	<pragmas/datatypes_pragmas.h>
#include	<pragmas/graphics_pragmas.h>

// ANSI C
#include	<stdlib.h>
#include	<string.h>
#include	<stdio.h>
#include	<time.h>

#ifndef MAKE_ID
#define MAKE_ID(a,b,c,d)     ((ULONG) (a)<<24 | (ULONG) (b)<<16 | (ULONG) (c)<<8 | (ULONG) (d))
#endif

#define MIN(a,b)           ((a)<(b)?(a):(b))
#define MAX(a,b)           ((a)>(b)?(a):(b))

//=========================================================================
// Game state information
//=========================================================================
struct GameState
{
	ULONG	gs_state;	// State
	ULONG	gs_score;	// Current score
	ULONG	gs_level;	// Current level
	ULONG	gs_ndal;	// Number of Daleks initially
	ULONG	gs_count;
};


#define	GS_INITIALISING 0
#define	GS_ATTRACTMODE	1
#define	GS_LEVELINTRO	2
#define	GS_INGAME		3
#define	GS_LEVELOUTRO	4

//=========================================================================
// Datatypes picture structure
//=========================================================================
struct dtPic
{
	APTR				dp_obj;
    struct BitMapHeader *dp_bmhdr;
    struct BitMap       *dp_bm;

};

typedef enum
{
	GFX_DALEKR = 0,
	GFX_DALEKL,
	GFX_DOCTOR,
	GFX_UL,
	GFX_UP,
	GFX_UR,
	GFX_RT,
	GFX_DR,
	GFX_DN,
	GFX_DL,
	GFX_LF,

	GFX_LAST		// Must be last!
} _gfx_picnumbers;

//=========================================================================
// GUI event numbers
//=========================================================================
typedef enum
{
	MEN_ABOUT = 1,
	MEN_ABOUTMUI,
	MEN_QUIT,
	MEN_DALPREFS,
	MEN_MUIPREFS,

	BT_NEWGAME,
	BT_QUIT,
	BT_PREFS,
	BT_TELE,
	BT_SCREW,
	BT_LAST

} _mui_eventnumbers;


//=========================================================================
// String IDs for localisation
//=========================================================================
typedef enum
{
	MSG_PROJECT = 0,
	MSG_ABOUT,
	MSG_ABOUTMUI,
	MSG_QUIT,
	MSG_PREFS,

	MSG_WELCOMEDR,
	MSG_CLICKNEWGAME,
	MSG_TOPKILLERS,
	MSG_WRITTENBY,
	MSG_COPYRIGHT1,
	MSG_COPYRIGHT2,

	MSG_SCORE,
	MSG_HISCORE,

	MSG_BTNEWGAME,
	MSG_BTQUIT,
	MSG_BTPREFS,
	MSG_BTTELEPORT,
	MSG_BTSCREW,
	MSG_BTLAST,

	MSG_ERRORREQTITLE,
	MSG_ERRORREQBUTTON,

	MSG_lastmsg
} _locale_string_ids;

//=========================================================================
// Global variable references
//=========================================================================
extern STRPTR	Version;	// Version string
extern STRPTR	Copyright1;	// Copyright text
extern STRPTR	Copyright2;
extern STRPTR	BaseName;	// MUI App basename
extern STRPTR	AppTitle;	// MUI App title

extern ULONG	SigNum;

extern struct Library *DataTypesBase;
extern struct Library *GfxBase;
extern struct Library *IntuitionBase;
extern struct Library *LocaleBase;
extern struct Library *MUIMasterBase;
extern struct Library *UtilityBase;

extern struct Locale   *Locale;
extern struct Catalog  *Catalog;
extern struct Screen   *Screen;

extern Object	*MUI_App;
extern Object	 *WI_Splash;
extern Object	  *TX_Splash1;
extern Object	  *TX_Splash2;
extern Object	 *WI_Main;
extern Object	  *MN_Menus;
extern Object	  *BT_NewGame;
extern Object	  *BT_Quit;
extern Object	  *BT_Tele;
extern Object	  *BT_Prefs;
extern Object	  *BT_Screw;
extern Object	  *BT_Last;
extern Object	  *TX_Score;
extern Object	  *TX_HiScore;
extern Object	 *GP_Arena;
extern Object	  *GP_Mbox;
extern Object	   *TX_Mbox1;
extern Object	   *TX_Mbox2;
extern Object	  *BA_Arena;

extern struct MUI_CustomClass *DaleksArena_Class;
extern struct MUI_CustomClass *DaleksTimer_Class;

extern struct GameState	StateInfo;

extern struct BitMap *GameGfx[];
extern ULONG          GameGfxSize;

extern STRPTR AppStr[];

//=========================================================================
// Prototypes
//=========================================================================
STRPTR			getStr(ULONG);
void			exitProg(STRPTR);
void			setGameState(ULONG);

struct dtPic *	loadDTPic(STRPTR);
void			unloadDTPic(struct dtPic *);
BOOL			loadGFX(ULONG, ULONG);
void			unloadGFX(void);

void			mboxAttractMode(ULONG);
void			mboxLevelIntro(void);

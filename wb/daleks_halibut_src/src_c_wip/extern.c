//=========================================================================
//=========================================================================
//
//	Daleks - external variable storage
//
//	Copyright 1998 Halibut Software/John Girvin, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================
#include	"Daleks.h"

//=========================================================================
// Version etc.
//=========================================================================
       STRPTR Version	= "$VER: Daleks98 v0.1";
static STRPTR CompDate	= __DATE__ " " __TIME__ ;
       STRPTR Copyright1= NULL;
       STRPTR Copyright2= NULL;

       STRPTR BaseName	= "DALEKS98";
       STRPTR AppTitle	= "Daleks98";

//=========================================================================
// Misc
//=========================================================================
struct Locale   *Locale;
struct Catalog  *Catalog;
struct Screen   *Screen;

//=========================================================================
// Signal number
//=========================================================================
ULONG	SigNum		= -1;

//=========================================================================
// Library bases
//=========================================================================
struct Library *DataTypesBase = NULL;
struct Library *GfxBase       = NULL;
struct Library *IntuitionBase = NULL;
struct Library *LocaleBase    = NULL;
struct Library *MUIMasterBase = NULL;
struct Library *UtilityBase   = NULL;

//=========================================================================
// MUI globals
//=========================================================================
Object *MUI_App		= NULL;
 Object *WI_Splash	= NULL;
  Object *TX_Splash1= NULL;
  Object *TX_Splash2= NULL;
 Object *WI_Main	= NULL;
  Object *MN_Menus	= NULL;
  Object *BT_NewGame= NULL;
  Object *BT_Quit	= NULL;
  Object *BT_Prefs	= NULL;
  Object *BT_Tele	= NULL;
  Object *BT_Screw	= NULL;
  Object *BT_Last	= NULL;
  Object *TX_Score	= NULL;
  Object *TX_HiScore= NULL;

  Object *GP_Arena  = NULL;
   Object *BA_Arena	= NULL;
   Object *GP_Mbox  = NULL;
    Object *TX_Mbox1= NULL;
    Object *TX_Mbox2= NULL;

struct MUI_CustomClass *DaleksArena_Class = NULL;
struct MUI_CustomClass *DaleksTimer_Class = NULL;

//=========================================================================
// Array of pictures for game graphics
//=========================================================================
struct BitMap *GameGfx[GFX_LAST];
ULONG          GameGfxSize = 0;

//=========================================================================
// Game state
//=========================================================================
struct GameState StateInfo =
{
	GS_INITIALISING,	// State
	0,					// Score
	0					// Level
};


//=========================================================================
// Built-in localisation strings
//=========================================================================

STRPTR AppStr[] =
	{
		"Project",
		"About",
		"About MUI",
		"Quit",
		"Preferences",

		"W E L C O M E,  D O C T O R",
		"Click New Game to start",
		"TOP DALEK KILLERS",
		"Written by John Girvin",
		"Copyright 1998 Halibut Software",
		"All rights reserved",

		"Score",
		"HiScore",

		"_New Game",
		"_Quit",
		"_Prefs",
		"_Teleport",
		"_Screwdriver",
		"_Last Stand",

		"Daleks ERROR!",
		"OK",

		""
	};

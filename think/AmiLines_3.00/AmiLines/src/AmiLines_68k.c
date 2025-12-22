/**
  * Roman Razilov 2000-05-19 debug dummmy
  * Roman Razilov 2000-05-21 qimgio
  * Roland Florac 2004-08-04 adaptation for Amiga (OS3)
  *		  2004-10-03 adaptation to OS4
  *		  2005-11-29 adaptation to Reaction
  * Compilation : sc LINK OPTIMIZE AmiLines.c
**/

/***************************************************************************
 *									   *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or	   *
 *   (at your option) any later version.                                   *
 *									   *
 ***************************************************************************/


#include <stdlib.h>
#include <stdio.h>		/* for puts, sprintf */
#include <string.h>		/* for memcpy */
#include <stdarg.h>
#include <time.h>
#include <clib/alib_protos.h>
#include <exec/memory.h>
#include <intuition/classes.h>
#include <intuition/icclass.h>
#include <intuition/screens.h>
#include <libraries/locale.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/gadtools.h>	/* for NewMenus */
#include <proto/graphics.h>
#include <proto/icon.h>
#include <proto/intuition.h>
#include <proto/locale.h>

#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>
#include <reaction/reaction_macros.h>


#define LEVEL_MIN 0
#define NORMAL_LEVEL 2
#define LEVEL_MAX 9

#define CATALOG_VERSION 2

#define BALLSDROP 3	    /* Number of new balls for each turn */
#define ALIGNMENT_MIN 5     /* Minimum balls for erasure */

#define NOBALL -1
#define NCOLORS 7	    /* Number of used colors for the balls */

#define NUMCELLSW 9	    /* Dimensions of the game area */
#define NUMCELLSH 9

/* Libraries stuff ***********************************************************/
struct library {
    struct Library ** lib;
    long version;
    char * libname;
};

struct IntuitionBase * IntuitionBase;
struct GfxBase * GfxBase;
struct LocaleBase * LocaleBase;

struct Library * IconBase, * WindowBase, * LayoutBase,
	    * ButtonBase, * LabelBase, * StringBase, * IntegerBase, * ListBrowserBase,
	    * CheckBoxBase, * ChooserBase, * SpaceBase, * GadToolsBase;

struct library libs[] = {
    {	(struct Library **) &IntuitionBase, 41, "intuition.library" },
    {	(struct Library **) &GfxBase, 41, "graphics.library" },
    {	&IconBase, 41, "icon.library" },
    {	&WindowBase, 41, "window.class" },
    {	&LayoutBase, 41, "gadgets/layout.gadget" },
    {	&ButtonBase, 41, "gadgets/button.gadget" },
    {	&LabelBase, 41, "images/label.image" },
    {	&StringBase, 41, "gadgets/string.gadget" },
    {	&IntegerBase, 41, "gadgets/integer.gadget" },
    {	&ListBrowserBase, 41, "gadgets/listbrowser.gadget" },
    {	&ChooserBase, 41, "gadgets/chooser.gadget" },
    {	&SpaceBase, 41, "gadgets/space.gadget" },
    {	&GadToolsBase, 41, "gadtools.library" },
    {	(struct Library **) &LocaleBase, 41, "locale.library" },
    {	0, 0, 0 }
};
/*****************************************************************************/


struct cell {
    long color, align;
};

struct field {
    struct cell cell[NUMCELLSH][NUMCELLSW];
};

struct high_score {
    char name[15];
    long score, level;
};

long init_scores[LEVEL_MAX+1] = { 1000, 600, 400, 300, 200, 150, 120, 100, 80, 50 };
long step_scores[10] = {  100,	50,  35,  25,  18,  14,  11,   9,  7,  4 };

struct lines
{
    struct Screen * screen;
    Object * object, * ballsarea, * nextballs, * scorestring;
    struct Window * window;
    struct Menu * menu;

    /* Colors used to render the game and the balls */
    long colors[NCOLORS+2];

    /* Coordinates of the gadgets where are rendered the balls */
    struct IBox * field_area, * next_area, * score_area;

    long start_level, level, round, score, score_undo, speed, cellsizegadget, cellsize;
    long jumpingCol, jumpingRow, moves, ticks;
    struct field cells, cells_undo;
    BOOL ShowNextBalls, GameOver, selected;

    /* Data used for filling areas */
    PLANEPTR pointer;
    struct AreaInfo AreaInfo;
    struct TmpRas StructTmpRas;
    short int buffer[20];

    long nextBalls[BALLSDROP], nextBalls_undo[BALLSDROP];
    struct Waypoints {
	long x, y;
    }
    way[NUMCELLSW*NUMCELLSH], ballsdrop[BALLSDROP];

    /* High-scores */
    /* The 10 best scores are kept in memory, for each level */
    /* The last "level" is used to class all scores for any level */
    struct high_score high_score[LEVEL_MAX+1][10];
};

/* Gadgets ID */
enum { GADGET_SCORE=1, GADGET_LEVEL, GADGET_CLEAR,
    GADGET_OK, GADGET_NO, GADGET_SPEED, GADGET_SIZE, GADGET_NAME, GADGET_SAVE
};


APTR catalog;

#define AREA_BACKGROUND NCOLORS
#define LINES_COLOR NCOLORS+1
/* Color used to render the score */
#define RED 0		/* High score for the level */
#define GREEN 1 	/* One of the 10 high scores in the level */
#define BLUE 2		/* Bad score... */

/* Colors used in the game to render balls, game area, and lines (RVB values) */
ULONG color_levels[(NCOLORS+2)*3] = {
    /* Ball colors */
    0xFFFFFFFF, 0, 0,			    /* Red */
    0, 0xCFFFFFFF, 0,			    /* Green */
    0, 0, 0xFFFFFFFF,			    /* Blue */
    0xFFFFFFFF, 0, 0xFFFFFFFF,
    0xAFFFFFFF, 0xCFFFFFFF, 0,		    /* Yellow */
    0, 0xDFFFFFFF, 0xDFFFFFFF,
    0x7FFFFFFF, 0x7FFFFFFF, 0x7FFFFFFF,     /* Grey */
    /* Game area */
    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,     /* White */
    /* Lines */
    0, 0, 0				    /* Black */
};

/* Strings ID (for locale) */
enum {
    /* Menus */
    PROJECT_MENU_STRING = 0, NEWGAME_MENU_STRING, UNDO_MENU_STRING, LEVEL_MENU_STRING,
    SHOWNEXT_MENU_STRING, PASS_MENU_STRING, SHOWLAST_MENU_STRING,
    SCORES_MENU_STRING, PREFS_MENU_STRING, ABOUT_MENU_STRING, QUIT_MENU_STRING,

    /* Animation speed requester */
    ANIMATION_SPEED_STRING, VERY_SLOW_SPEED_STRING, SLOW_SPEED_STRING, MEDIUM_SPEED_STRING,
    FAST_SPEED_STRING, VERY_FAST_SPEED_STRING,

    /* Cell size requester */
    CELL_SIZE_STRING, SMALL_SIZE_STRING, MEDIUM_SIZE_STRING, LARGE_SIZE_STRING, VERY_LARGE_SIZE_STRING,

    AMILINES_PREFS_STRING, LEVEL_1_STRING, LEVEL_2_STRING, LEVEL_3_STRING,
    LEVEL_4_STRING, LEVEL_5_STRING, LEVEL_6_STRING, LEVEL_7_STRING,
    LEVEL_8_STRING, LEVEL_9_STRING, LEVEL_10_STRING, ALL_LEVEL_STRING,

    /* Some button labels */
    ACCEPT_STRING, CANCEL_STRING, OK_STRING, USE_STRING, SAVE_STRING, CLEAR_STRING,

    ABOUT_STRING, WARNING_STRING, NEXT_BALLS_STRING,
    LEVEL_STRING, START_LEVEL_STRING, SET_LEVEL_STRING, AMILINES_LEVEL_STRING, AMILINES_VERSION_LEVEL_STRING,
    HIGH_SCORE_STRING, YOU_GOT_SCORE_N_STRING, ENTER_YOUR_NAME_STRING, AMILINES_BEST_SCORES_STRING,

    GAME_OVER_STRING, GAME_OVER_START_NEW_STRING, START_GAME_FIRST_STRING,
    CLICK_ON_FREECELL_STRING, SELECT_BALL_STRING, NO_PATH_STRING,

    /* Error messages */
    AMILINES_ERROR_STRING, OPENING_LIBRARY_ERROR_STRING, OPENREQUESTER_ERROR_STRING,
    ALLOCATION_REQUESTER_ERROR_STRING, LOCKSCREEN_ERROR_STRING,
    NO_MEMORY_ERROR_STRING,

    SAVING_PREFS_ERROR_STRING, SAVING_SCORES_ERROR_STRING,
    LOADING_SCORES_ERROR_STRING, FORMAT_SCORES_ERROR_STRING,
    LOADING_DISKOBJECT_ERROR_STRING, SAVING_DISKOBJECT_ERROR_STRING,

    /* Errors checking tooltypes */
    BAD_CELLSIZE_VALUE_STRING, BAD_ANIMATIONSPEED_VALUE_STRING, BAD_LEVEL_VALUE_STRING,

    /* Best scores listview headers */
    NUM_STRING, NAME_STRING, SCORE_STRING,

    /* Must be the last one... */
    STRINGS_NUMBER
};

#define AMILINES_VERSION "3.00"

/* Localized strings (MUST BE in the SAME ORDER than the previous enum) */
STRPTR strings[STRINGS_NUMBER] = {
    /* Menus */
    "Project", "New game", "Undo", "Level", "Show next", "Pass", "Show last",
    "Scores", "Prefs", "About", "Quit",

    /* Animation speed requester */
    "Animation speed", "Very slow", "Slow", "Medium", "Fast", "Very fast",

    /* Cell size requester */
    "Cell size", "Small", "Medium", "Large", "Very large",

    "AmiLines prefs", "Level 1", "Level 2", "Level 3", "Level 4", "Level 5",
    "Level 6", "Level 7", "Level 8", "Level 9", "Level 10", "All levels",

    /* Some button labels */
    "Accept", "Cancel", "OK", "_Use", "_Save", "_Clear",

    "AmiLines "AMILINES_VERSION" - 29-Nov-2005\n\nAmiLines is based on\nKLines under Linux,\nwritten by Roman Merzlyakov,\noriginal author.\nAdapted on Amiga by R.Florac\n\nAll you have to do is\nto move balls to make lines\nwith 5 or more balls\nof the same color.",
    "Warning : changing the level\nwill stop the game !\nBe carefull...", "Next balls",
    "Level", "Start level", "The level can be set\nfrom 1 (very easy)\nto 10 (difficult)",
    "AmiLines "AMILINES_VERSION" - Level %ld", "AmiLines level", "Top ten High score !",
    "You got best score #%d for level %d", "Enter your name", "AmiLines top 10 best scores",

    "Game over !", "Game over ! Start a new game", "Start game first !",
    "Click on a free cell", "Select a ball", "No path...",

    /* Error messages */
    "AmiLines error", "Error opening library %s version %ld", "Could not open requester",
    "Could not allocate requester", "Could not lock pub screen",
    "No such available memory",

    "Could not save icon file", "Could not save high scores",
    "Could not load high scores", "Bad high scores file format",

    "Could not find AmiLines.info file\n  Loading prefs impossible",
    "Could not find AmiLines.info file\n   Saving prefs impossible",

    /* Errors checking tooltypes */
    "Bad cellsize value in AmiLines tooltypes",
    "Bad animation speed value in AmiLines tooltypes",
    "Bad level value in AmiLines tooltypes",

    /* Best scores listview headers */
    "N°", "Name", "Score",
};

/* Some not localized strings */
char AMILINES_TXT[] = "AmiLines "AMILINES_VERSION"";
char AMILINES_HIGHSCORES_FILE[] = "AmiLines.Highscores";
char AMILINES_HIGHSCORES_HEADER[] = "AmiLinesScores 1.0\n";


/* Definition of the menu entries */
enum { NEW_GAME_MENU=0, UNDO_MENU, LEVEL_MENU, SHOWNEXT_MENU, PASS_MENU, RECALL_MENU,
    HIGHSCORES_MENU, PREFS_MENU, ABOUT_MENU, QUIT_MENU
};

struct NewMenu newmenu[] =
{
    { NM_TITLE, 0, 0, 0, 0, (APTR) PROJECT_MENU_STRING },
    { NM_ITEM, 0, "N", 0, 0, (APTR) NEWGAME_MENU_STRING },
    { NM_ITEM, 0, "U", NM_ITEMDISABLED, 0, (APTR) UNDO_MENU_STRING },
    { NM_ITEM, 0, "L", 0, 0, (APTR) LEVEL_MENU_STRING },
    { NM_ITEM, 0, "N", MENUTOGGLE | CHECKIT, 0, (APTR) SHOWNEXT_MENU_STRING },
    { NM_ITEM, 0, "I", 0, 0, (APTR) PASS_MENU_STRING },
    { NM_ITEM, 0, "?", NM_ITEMDISABLED, 0, (APTR) SHOWLAST_MENU_STRING},
    { NM_ITEM, 0, "H", 0, 0, (APTR) SCORES_MENU_STRING},
    { NM_ITEM, 0, "P", 0, 0, (APTR) PREFS_MENU_STRING},
    { NM_ITEM, 0, "A", 0, 0, (APTR) ABOUT_MENU_STRING},
    { NM_ITEM, 0, "Q", 0, 0, (APTR) QUIT_MENU_STRING },

    {  NM_END, NULL, 0, 0, 0, 0}
};


STRPTR GetLocaleString (long i)
{
    STRPTR defstring = strings[i];
    if (catalog)
	return (STRPTR) GetCatalogStr (catalog, i, defstring);
    else
	return defstring;
}

static void init_menus (void)
{
    struct NewMenu * m;

    for (m = newmenu;  m->nm_Type != NM_END;  m++)
    {
	if (m->nm_Label  !=  NM_BARLABEL)
	    m->nm_Label = (STRPTR) GetLocaleString ((ULONG) m->nm_UserData);
    }
}

void alert (CONST_STRPTR message)
{
    struct EasyStruct easy = {
	sizeof(struct EasyStruct), 0, 0, 0, 0
    };

    if (IntuitionBase)
    {
	easy.es_Title = GetLocaleString (AMILINES_ERROR_STRING);
	easy.es_Flags = 0;
	easy.es_TextFormat = (UBYTE *) message;
	easy.es_GadgetFormat = GetLocaleString (OK_STRING);
	EasyRequest (0, &easy, 0, 0);
    }
    else
	puts (message);
}

void error (long string_ID)
{
    alert (GetLocaleString (string_ID));
}

long handle_request (struct lines * lines, Object * object)
{
    ULONG signal, end = FALSE, result;
    long code = -1, code2;
    struct Window * w;

    GetAttr (WINDOW_SigMask, object, &signal);
    GetAttr (WINDOW_Window, object, (ULONG *) &w);
    while (! end)
    {
	Wait (signal);
	while ((result = RA_HandleInput (object, &code2))  !=  WMHI_LASTMSG)
	{
	    switch (result & WMHI_CLASSMASK)
	    {
		    case WMHI_CLOSEWINDOW:
			end = TRUE;
			code = -1;
			break;

		    case WMHI_GADGETUP:
			code = result & WMHI_GADGETMASK;
			end = TRUE;
			break;

		    case WMHI_RAWKEY:
			code = result & WMHI_KEYMASK;
			if (code == 0x43  ||  code == 0x44)     /* ENTER or RETURN */
			{
			    end = TRUE;
			    code = GADGET_OK;
			}
			else if (code == 0x45)                 /* ESC */
			{
			    end = TRUE;
			    code = -1;
			}
			break;
	    }
	}
    }
    return code;
}

Object * new_button (long id, const char * m)
{
    return ButtonObject,
	    GA_ID, id,
	    GA_RelVerify, TRUE,
	    GA_Text, m,
	    BUTTON_SoftStyle, id == GADGET_OK ? FSF_BOLD : 0,
    ButtonEnd;
}

Object * locale_button (long id, long locale)
{
    return new_button (id, GetLocaleString (locale));
}

APTR new_object (struct TagItem * t)
{
    return NewObjectA (LAYOUT_GetClass(), NULL, t);
}

Object * label_object (long id)
{
    return LabelObject, LABEL_Text, GetLocaleString (id), LabelEnd;
}

Object * buttons_ok_no (void)
{
    return HGroupObject,
	LAYOUT_BevelStyle, BVS_GROUP,
	LAYOUT_AddChild, locale_button (GADGET_OK, ACCEPT_STRING),
	LAYOUT_AddChild, locale_button (GADGET_NO, CANCEL_STRING),
    LayoutEnd;
}

Object * number_gadget (long n, long id)
{
    return IntegerObject,
	INTEGER_Number, n,
	GA_RelVerify,	TRUE,
	GA_ID,		id,
	GA_TabCycle,	TRUE,
	STRINGA_Justification, GACT_STRINGCENTER,
	INTEGER_Arrows, TRUE,
    IntegerEnd;
}

void get_number (Object * gadget, ULONG * val)
{
    GetAttr (INTEGER_Number, gadget, val);
}

void set_number (Object * gadget, struct Window * w, long n)
{
    SetGadgetAttrs ((struct Gadget *) gadget, w, NULL, INTEGER_Number, n, TAG_DONE);
}

Object * string_gadget (char * s, long lmaxi, long id)
{
    return StringObject, STRINGA_MinVisible, lmaxi >= 30 ? 30 : lmaxi,
	STRINGA_MaxChars, abs(lmaxi),
	GA_RelVerify, TRUE,
	GA_TabCycle, TRUE,
	STRINGA_TextVal, s,
	STRINGA_Justification, GACT_STRINGCENTER,
	lmaxi < 0 ? GA_ReadOnly : TAG_IGNORE, TRUE,
	GA_ID, id,
    StringEnd;
}

void get_string (Object * gadget, char ** buffer)
{
    GetAttr (STRINGA_TextVal, gadget, (ULONG *) buffer);
}

void set_string (Object * gadget, struct Window * w, char * t)
{
    SetGadgetAttrs ((struct Gadget *) gadget, w, NULL, STRINGA_TextVal, t, TAG_DONE);
}

Object * cycle_object (long id, long selected, char ** labels)
{
    return ChooserObject, GA_ID, id, GA_RelVerify, TRUE, CHOOSER_AutoFit, TRUE, CHOOSER_Selected, selected, CHOOSER_Justification, CHJ_CENTER, CHOOSER_LabelArray, labels, ChooserEnd;
}

ULONG get_cycle (Object * objet)
{
    ULONG code;
    GetAttr (CHOOSER_Selected, objet, &code);
    return code;
}

APTR text_block (long string_number, const char ** strings)
{
    long i;
    struct TagItem * tags;
    APTR object;

    tags = AllocVec (sizeof(struct TagItem) * (string_number + 6), MEMF_CLEAR);
    if (tags)
    {
	tags[0].ti_Tag = LAYOUT_Orientation;
	tags[0].ti_Data = LAYOUT_ORIENT_VERT;
	tags[1].ti_Tag = LAYOUT_SpaceOuter;
	tags[1].ti_Data = TRUE;
	tags[2].ti_Tag = LAYOUT_VertAlignment;
	tags[2].ti_Data = LALIGN_CENTER;
	tags[3].ti_Tag = LAYOUT_HorizAlignment;
	tags[3].ti_Data = LALIGN_CENTER;
	tags[4].ti_Tag = LAYOUT_BevelStyle;
	tags[4].ti_Data = BVS_FIELD;
	if (string_number)
	{
	    for (i = 0;  i < string_number;  i++)
	    {
		tags[5+i].ti_Tag = LAYOUT_AddImage;
		tags[5+i].ti_Data = (ULONG) NewObject (LABEL_GetClass(), NULL,
			    LABEL_Justification, LJ_CENTRE,
			    LABEL_Text, *strings++,
			    LABEL_Underscore, '\0',
			TAG_END);
	    }
	    tags[5+i].ti_Tag = TAG_END;
	}
	else
	    tags[5].ti_Tag = TAG_END;
	object = new_object (tags);
	if (object)
	{
	    FreeVec (tags);
	    return object;
	}
	for (i =0;  i < string_number;  i++)
	    DisposeObject ((Object *) tags[5+i].ti_Data);
	FreeVec (tags);
    }
    return 0;
}

void display_messages (struct lines * lines, long string_number, ...)
{
    Object * object;
    struct Window * w;
    const char ** strings;
    long i;
    va_list varArgs;

    SetAttrs (lines->object, WA_BusyPointer, TRUE, TAG_END);
    if (strings = AllocVec (string_number * sizeof(char *), 0))
    {
	va_start (varArgs, string_number);
	for (i = 0;  i < string_number;  i++)
	    strings[i] = va_arg (varArgs, char *);
	va_end (varArgs);
	object = WindowObject,
	    WA_ScreenTitle, AMILINES_TXT,
	    WA_Title, AMILINES_TXT,
	    WA_Activate, TRUE,
	    WA_DepthGadget, TRUE,
	    WA_DragBar, TRUE,
	    WA_PubScreen, lines->screen,
	    WA_CloseGadget, TRUE,
	    WA_RMBTrap, TRUE,
	    WA_IDCMP, IDCMP_MOUSEBUTTONS | IDCMP_CLOSEWINDOW | IDCMP_GADGETUP | IDCMP_RAWKEY,
	    WINDOW_RefWindow, lines->window,
	    WINDOW_Position,  WPOS_CENTERSCREEN,
	    WINDOW_ParentGroup, NewObject (LAYOUT_GetClass(), NULL, LAYOUT_Orientation, LAYOUT_ORIENT_VERT,
		LAYOUT_DeferLayout, FALSE,
		LAYOUT_AddChild, text_block (string_number, strings),
		LAYOUT_AddChild, locale_button (GADGET_OK, OK_STRING),
	    TAG_END),
	EndWindow;
	FreeVec ((char **) strings);
	if (object)
	{
	    if (w = (struct Window *) RA_OpenWindow (object))
		handle_request (lines, object);
	    else
		error (OPENREQUESTER_ERROR_STRING);
	    DisposeObject (object);
	}
	else
	    error (ALLOCATION_REQUESTER_ERROR_STRING);
    }
    else
	error (NO_MEMORY_ERROR_STRING);
    SetAttrs (lines->object, WA_BusyPointer, FALSE, TAG_END);
}

/* Creation of the game window */
Object * create_requester (struct lines * lines)
{
    Object * o = WindowObject,
	WA_ScreenTitle, AMILINES_TXT,
	WA_Title, AMILINES_TXT,
	WA_Activate, TRUE,
	WA_DepthGadget, TRUE,
	WA_DragBar, TRUE,
	WA_NewLookMenus, TRUE,
	// WINDOW_NewMenu, newmenu,
	WA_PubScreen, lines->screen,
	WA_CloseGadget, TRUE,
	WA_IDCMP, IDCMP_INTUITICKS | IDCMP_MOUSEBUTTONS | IDCMP_IDCMPUPDATE | IDCMP_CLOSEWINDOW | IDCMP_RAWKEY | IDCMP_MENUPICK,
	WINDOW_Position, WPOS_CENTERSCREEN,
	WINDOW_ParentGroup, VGroupObject,
	    LAYOUT_AddChild, lines->ballsarea = SpaceObject, ICA_TARGET, ICTARGET_IDCMP, SPACE_MinWidth, NUMCELLSW * (lines->cellsize + 1), SPACE_MinHeight, NUMCELLSH * (lines->cellsize + 1), SPACE_BevelStyle, BVS_GROUP, SpaceEnd,
	    LAYOUT_AddChild, HGroupObject,
		LAYOUT_AddChild, HGroupObject,
		    LAYOUT_BevelStyle, BVS_GROUP,
		    LAYOUT_LabelPlace, BVJ_TOP_CENTER,
		    LAYOUT_SpaceOuter, TRUE,
		    LAYOUT_SpaceInner, TRUE,
		    LAYOUT_Label, GetLocaleString (NEXT_BALLS_STRING),
		    LAYOUT_AddChild, lines->nextballs = SpaceObject, SPACE_MinHeight, lines->cellsize + 3, SPACE_MinWidth, BALLSDROP * (lines->cellsize + 3), SPACE_BevelStyle, BVS_GROUP, SpaceEnd,
		LayoutEnd,
		CHILD_WeightedWidth, 0,
		LAYOUT_AddChild, HGroupObject,
		    LAYOUT_BevelStyle, BVS_GROUP,
		    LAYOUT_LabelPlace, BVJ_TOP_CENTER,
		    LAYOUT_SpaceOuter, TRUE,
		    LAYOUT_SpaceInner, TRUE,
		    LAYOUT_Label, GetLocaleString (SCORE_STRING),
		    LAYOUT_AddChild, lines->scorestring = SpaceObject, SPACE_MinHeight, lines->cellsize + 3, SPACE_MinWidth, lines->cellsize * 3, SPACE_BevelStyle, BVS_GROUP, SpaceEnd,
		LayoutEnd,
		// LAYOUT_EvenSize, TRUE,
	    LayoutEnd,
	LayoutEnd,
    EndWindow;
    return o;
}

void FillSpaceBox (struct lines * lines, struct IBox * area)
{
    SetAPen (lines->window->RPort, lines->colors[AREA_BACKGROUND]);
    RectFill (lines->window->RPort, area->Left, area->Top, area->Left + area->Width - 1, area->Top + area->Height - 1);
}

/* Routines to display score (7 segments like vectorial drawing) ***************************************/
/* Segment flags : 1 vertical, -1 horizontal, 0 nothing; for segments a, b, c, d, e, f, g respectively */
WORD segments [] =
{   -1, 1, 1,-1, 1, 1, 0,   /* 0 */
     0, 1, 1, 0, 0, 0, 0,   /* 1 */
    -1, 1, 0,-1, 1, 0,-1,   /* 2 */
    -1, 1, 1,-1, 0, 0,-1,   /* 3 */
     0, 1, 1, 0, 0, 1,-1,   /* 4 */
    -1, 0, 1,-1, 0, 1,-1,   /* 5 */
    -1, 0, 1,-1, 1, 1,-1,   /* 6 */
    -1, 1, 1, 0, 0, 0, 0,   /* 7 */
    -1, 1, 1,-1, 1, 1,-1,   /* 8 */
    -1, 1, 1,-1, 0, 1,-1    /* 9 */
};

WORD coords[] =     /* Coordinates for each segment (x, y) */
{
    0, 0,	/* a */
    1, 0,	/* b */
    1, 1,	/* c */
    0, 2,	/* d */
    0, 1,	/* e */
    0, 0,	/* f */
    0, 1,	/* g */
};

void display_segment (struct lines * lines, WORD x, WORD y, WORD w, WORD h, long direction)
{
    WORD d = (lines->cellsizegadget + 1) / 2;
    if (direction < 0)     /* horizontal */
	RectFill (lines->window->RPort, lines->score_area->Left + x, lines->score_area->Top + y - d, lines->score_area->Left + x + w, lines->score_area->Top + y + d);
    else		    /* vertical */
	RectFill (lines->window->RPort, lines->score_area->Left + x - d, lines->score_area->Top + y, lines->score_area->Left + x + d, lines->score_area->Top + y + h);
}

void display_decimal_number (struct lines * lines, WORD x, WORD y, WORD w, WORD h, long number)
{
    WORD * segs = &segments[number * 7], * coord = coords;
    long s;
    if (number < 0 ||  number > 9)
	puts ("error");
    else
    for (s = 0;  s < 7;  s++, segs++, coord += 2)
	if (*segs)
	    display_segment (lines, x + *coord * w, y + *(coord+1) * h , w, h ,*segs);
}

void display_score (struct lines * lines)
{
    WORD w, h;
    long s = lines->score;
    long color;

    FillSpaceBox (lines, lines->score_area);
    if (lines->score >= lines->high_score[lines->level][0].score)
	color = RED;
    else if (lines->score >= lines->high_score[lines->level][9].score)
	color = GREEN;
    else
	color = BLUE;
    SetAPen (lines->window->RPort, lines->colors[color]);
    w = lines->score_area->Width / 31;
    h = lines->score_area->Height / 3;
    if (s >= 10000)
    {
	display_decimal_number (lines, w, h / 2, 5 * w, h, s / 10000);
	s = s - (s / 10000) * 10000;
    }
    if (lines->score >= 1000)
    {
	display_decimal_number (lines, 7 * w, h / 2, 5 * w, h, s / 1000);
	if (s >= 1000)
	    s = s - (s / 1000) * 1000;
    }
    if (lines->score >= 100)
    {
	display_decimal_number (lines, 13 * w, h / 2, 5 * w, h, s / 100);
	if (s >= 100)
	    s = s - (s / 100) * 100;
    }
    if (lines->score >= 10)
    {
	display_decimal_number (lines, 19 * w, h / 2, 5 * w, h, s / 10);
	if (s >= 10)
	    s = s - (s / 10) * 10;
    }
    display_decimal_number (lines, 25 * w, h / 2, 5 * w, h, s);
}
/***********************************************************************************************/

void RedrawGame (struct lines * lines)
{
    long x;

    SetAPen (lines->window->RPort, lines->colors[AREA_BACKGROUND]);
    FillSpaceBox (lines, lines->field_area);
    FillSpaceBox (lines, lines->next_area);

    /* Draw lines */
    SetAPen (lines->window->RPort, lines->colors[LINES_COLOR]);
    for (x = 1;  x < NUMCELLSH;  x++)
    {
	/* ligne verticale */
	Move (lines->window->RPort, lines->field_area->Left + x * lines->cellsize, lines->field_area->Top);
	Draw (lines->window->RPort, lines->field_area->Left + x * lines->cellsize, lines->field_area->Top + (NUMCELLSH * lines->cellsize));
	/* ligne horizontale */
	Move (lines->window->RPort, lines->field_area->Left, lines->field_area->Top + x * lines->cellsize);
	Draw (lines->window->RPort, lines->field_area->Left + (NUMCELLSW * lines->cellsize), lines->field_area->Top + x * lines->cellsize);
    }
    Move (lines->window->RPort, lines->next_area->Left + lines->cellsize, lines->next_area->Top);
    Draw (lines->window->RPort, lines->next_area->Left + lines->cellsize, lines->next_area->Top + lines->cellsize - 1);
    Move (lines->window->RPort, lines->next_area->Left + 2 * lines->cellsize, lines->next_area->Top);
    Draw (lines->window->RPort, lines->next_area->Left + 2 * lines->cellsize, lines->next_area->Top + lines->cellsize - 1);
    display_score (lines);
}

BOOL open_window (struct lines * lines)
{
    if (lines->object = create_requester (lines))
    {
	if (lines->menu = CreateMenus (newmenu, TAG_DONE))
	    LayoutMenus (lines->menu, GetVisualInfo (lines->screen, TAG_DONE),  GTMN_NewLookMenus, TRUE, TAG_DONE);
	if (lines->window = (struct Window *) RA_OpenWindow (lines->object))
	{
	    SetMenuStrip (lines->window, lines->menu);
	    lines->pointer = (PLANEPTR) AllocRaster (lines->window->Width, lines->window->Height);
	    if (lines->pointer)
	    {
		GetAttr (SPACE_AreaBox, lines->ballsarea, (ULONG *) &lines->field_area);
		GetAttr (SPACE_AreaBox, lines->nextballs, (ULONG *) &lines->next_area);
		GetAttr (SPACE_AreaBox, lines->scorestring, (ULONG *) &lines->score_area);
		InitArea (&lines->AreaInfo, &lines->buffer, 4);
		lines->window->RPort->AreaInfo = &lines->AreaInfo;
		lines->window->RPort->TmpRas = InitTmpRas (&lines->StructTmpRas, lines->pointer, RASSIZE(lines->window->Width, lines->window->Height));
		RedrawGame (lines);
		return TRUE;
	    }
	    else
		error (NO_MEMORY_ERROR_STRING);
	}
	else
	    error (OPENREQUESTER_ERROR_STRING);
    }
    return FALSE;
}

void close_window (struct lines * lines)
{
    if (lines->menu)
    {
	ClearMenuStrip (lines->window);
	FreeMenus (lines->menu);
    }
    if (lines->pointer)
	FreeRaster ((PLANEPTR) lines->pointer, lines->window->Width, lines->window->Height);
    lines->pointer = 0;
    DisposeObject (lines->object);
    lines->window = 0;
    lines->object = 0;
}

void clearcell (struct cell * cell)
{
    cell->color = NOBALL;
    cell->align = 0;
}

void clearcells (struct field * cells)
{
    long x, y;

    for (y = 0;  y < NUMCELLSH;  y++)
	for (x = 0;  x < NUMCELLSW;  x++)
	    clearcell (&cells->cell[y][x]);
}

void check_level_tooltype (struct lines * lines)
{
    struct DiskObject * dobj;
    long d;

    if (dobj = GetDiskObject ("AmiLines"))
    {
	STRPTR const * toolarray;
	STRPTR s;
	long x;

	toolarray = dobj->do_ToolTypes;
	if (s = FindToolType (toolarray, "LEVEL"))
	{
	    d = StrToLong (s, &x);
	    if (d > 0  &&  x >= LEVEL_MIN  &&  x <= LEVEL_MAX)
		lines->start_level = lines->level = x - 1;
	    else
		error (BAD_LEVEL_VALUE_STRING);
	}
	if (s = FindToolType (toolarray, "CELLSIZE"))
	{
	    d = StrToLong (s, &x);
	    if (d > 0  &&  x >= 0  &&  x <= 3)
		lines->cellsizegadget = x;
	    else
		error (BAD_CELLSIZE_VALUE_STRING);
	}
	if (s = FindToolType (toolarray, "ANIMATION"))
	{
	    d = StrToLong (s, &x);
	    if (d > 0  &&  x >= 0  &&  x <= 4)
		lines->speed = x;
	    else
		error (BAD_ANIMATIONSPEED_VALUE_STRING);
	}
	FreeDiskObject (dobj);
    }
    else
	error (LOADING_DISKOBJECT_ERROR_STRING);
}

long checkBounds (long x, long y)
{
    return (x >= 0) && (x < NUMCELLSW) && (y >= 0) && (y < NUMCELLSH);
}

long isFree (struct cell * cell)
{
    return ((cell->color == NOBALL ) ? TRUE : FALSE);
}

long freeSpace (struct field * f)
{
    long s = 0, x, y;

    for (y = 0;  y < NUMCELLSH;  y++)
	for (x = 0;  x < NUMCELLSW;  x++)
	    if (isFree (&f->cell[y][x]))
		s++;
    return s;
}

long getBall (struct field * f, long x, long y)
{
    if (checkBounds (x, y))
	return f->cell[y][x].color;
    else
	return NOBALL;
}

void setColor (struct cell * f, long c)
{
    f->color = c;
}

void delay (long speed)
{
    static long delay[] = { 30, 20, 10, 5, 1 };
    Delay (delay[speed]);
}

long qmax (long a, long b)
{
    if (a > b)
	return a;
    return b;
}

long calcRun (struct field * f, long sx, long sy, long dx, long dy)
{
    long ix = sx, iy = sy;
    long run = 0, score = 0;
    long current_color = NOBALL;
    long lpr = 0, lprscore = 0, empty = 0, i, b;

    for (i = 0;  i < 9;  i++, ix += dx, iy += dy)
    {
	if ((ix < 0) || (iy < 0) || (ix >= NUMCELLSW) || (iy >= NUMCELLSH))
	    continue;
	b = f->cell[iy][ix].color;
	if (b == NOBALL)
	{
	    run++;
	    empty++;
	}
	else if (b == current_color)
	{
	    run++;
	    score++;
	    empty = 0;
	}
	else
	{
	    run = empty+1;
	    score = 1;
	    current_color = b;
	    empty = 0;
	}
	if (run > lpr)
	{
	    lpr = run;
	    lprscore = score;
	}
    }
    if (lpr < ALIGNMENT_MIN)
	lprscore = -10;
    else
	lprscore = lprscore * lprscore;
    return lprscore;
}

long calcPosScore (struct field * f, long x, long y, long whatIf)
{
    long score = -10;
    long color = f->cell[y][x].color;
    setColor (&f->cell[y][x], whatIf);
    score = qmax(score, calcRun (f, x, y-4, 0, 1));
    score = qmax(score, calcRun (f, x-4, y-4, 1, 1));
    score = qmax(score, calcRun (f, x-4, y, 1, 0));
    score = qmax(score, calcRun (f, x-4, y+4, 1, -1));
    setColor (&f->cell[y][x], color);
    return score;
}

void DrawBall (struct lines * lines, long x, long y, long color)
{
    SetAPen (lines->window->RPort, lines->colors[color]);
    AreaEllipse (lines->window->RPort, lines->field_area->Left + x * lines->cellsize + lines->cellsize / 2, lines->field_area->Top + y * lines->cellsize + lines->cellsize / 2, lines->cellsize/2 - 2, lines->cellsize/2 - 2);
    AreaEnd (lines->window->RPort);
}

void DrawSelectedBall (struct lines * lines, long x, long y, long color)
{
    DrawBall (lines, x, y, color);
    /* Clear the center of the ball */
    SetAPen (lines->window->RPort, lines->colors[AREA_BACKGROUND]);
    AreaEllipse (lines->window->RPort, lines->field_area->Left + x * lines->cellsize + lines->cellsize / 2, lines->field_area->Top + y * lines->cellsize + lines->cellsize / 2, lines->cellsize/4 - 2, lines->cellsize/4 - 2);
    AreaEnd (lines->window->RPort);
}

void putNextBall (struct lines * lines, long x, long y, long color)
{
    if (checkBounds (x, y))
    {
	setColor (&lines->cells.cell[y][x], color);
	if (color >= 0  &&  color < 7)
	    DrawBall (lines, x, y, color);
    }
}

void DrawNextBall (struct lines * lines, long ball, long color)
{
    SetAPen (lines->window->RPort, lines->colors[color]);
    AreaEllipse (lines->window->RPort, lines->next_area->Left + lines->cellsize / 2 + ball * lines->cellsize , lines->next_area->Top + lines->cellsize / 2 - 1, lines->cellsize/2 - 2, lines->cellsize/2 - 2);
    AreaEnd (lines->window->RPort);
}

void ShowNextBalls (struct lines * l, BOOL on)
{
    long i;
    if (! l->GameOver)
	for (i = 0;  i < BALLSDROP;  i++)
	{
	    DrawNextBall (l, i, on ? l->nextBalls[i] : AREA_BACKGROUND);
	    delay (l->speed);
	}
}

long random (long max)
{
    return (long) (rand() % max);
}

long placeNewBall (struct lines * lines, long ball)
{
    char xx[NUMCELLSW*NUMCELLSH], yy[NUMCELLSW*NUMCELLSH];
    long empty = 0, x, y;

    /* Check for empty places */
    for (y = 0;  y < NUMCELLSH;  y++)
	for (x = 0;  x < NUMCELLSW;  x++)
	    if (getBall (&lines->cells, x, y) == NOBALL)
	    {
		xx[empty] = x;
		yy[empty] = y;
		empty++;
	    };

    if (empty)
    {
	long color = lines->nextBalls[ball];
	long pos;
	if (lines->level == NORMAL_LEVEL)
	    pos = random (empty);
	else
	{
	    long best_pos = 0, i;
	    long best_score = lines->level > NORMAL_LEVEL ? 1000: -1000;
	    long maxtry = lines->level > NORMAL_LEVEL ? lines->level-2 : 2-lines->level;
	    for (i = 0;  i < maxtry;  i++)
	    {
		long pos = random (empty);
		long score = calcPosScore (&lines->cells, xx[pos], yy[pos], color) - calcPosScore (&lines->cells, xx[pos], yy[pos], NOBALL);
		if (((lines->level > NORMAL_LEVEL) && (score < best_score)) ||
		    ((lines->level < NORMAL_LEVEL) && (score > best_score)))
		{
		    best_pos = pos;
		    best_score = score;
		}
	    }
	    pos = best_pos;
	}
	DrawNextBall (lines, ball, AREA_BACKGROUND);
	putNextBall (lines, xx[pos], yy[pos], color);
	lines->ballsdrop[ball].x = xx[pos];
	lines->ballsdrop[ball].y = yy[pos];
	return 1;
    }
    return 0;
}

long placeNextBalls (struct lines * lines)
{
    long i, j, n = 0;

    for (i = 0;  i < BALLSDROP;  i++)
    {
	if (placeNewBall (lines, i))
	    n++;
	else
	    break;
    }
    for (j = n;  j < BALLSDROP;  j++)
	lines->ballsdrop[j].x = -1;
    for (j = 0;  j < 3;  j++)
    {
	delay (lines->speed);
	for (i = 0;  i < n;  i++)
	    DrawBall (lines, lines->ballsdrop[i].x, lines->ballsdrop[i].y, AREA_BACKGROUND);
	delay (lines->speed);
	for (i = 0;  i < n;  i++)
	    DrawBall (lines, lines->ballsdrop[i].x, lines->ballsdrop[i].y, lines->cells.cell[lines->ballsdrop[i].y][lines->ballsdrop[i].x].color);
    }
    return n;
}

void moveBall (struct lines * lines, long xa, long ya, long xb, long yb)
{
    struct cell * cell;

    if (checkBounds (xa, ya)  &&  checkBounds (xb, yb)  &&
	isFree (&lines->cells.cell[yb][xb]) && (xa != xb || ya != yb))
    {
	lines->cells.cell[yb][xb] = lines->cells.cell[ya][xa];
	cell = &lines->cells.cell[yb][xb];
	delay (lines->speed);
	DrawBall (lines, xa, ya, AREA_BACKGROUND);
	clearcell (&lines->cells.cell[ya][xa]);
	DrawBall (lines, xb, yb, cell->color);
    }
}

void generateRandomBalls (struct lines * lines)
{
    long i;

    lines->score_undo = lines->score;
    for (i = 0;  i < BALLSDROP;  i++ )
    {
	lines->nextBalls_undo[i] = lines->nextBalls[i];
	lines->nextBalls[i] =  random (NCOLORS);
    }
}

void updateTitle (struct lines * lines, long message_ID)
{
    static char title[50];
    char * message;

    if (lines->round)
    {
	display_score (lines);
	if (message_ID < 0)
	{
	    if (lines->GameOver)
		message_ID = GAME_OVER_STRING;
	    else
	    {
		sprintf (title, GetLocaleString(AMILINES_LEVEL_STRING), lines->level + 1);
		SetWindowTitles (lines->window, title, (char *) -1);
		lines->ticks = 0;
		return;
	    }
	}
    }
    if (message_ID < 0)
	message = AMILINES_TXT;
    else
	message = GetLocaleString (message_ID);
    SetWindowTitles (lines->window, message, (char *) -1);
    lines->ticks = 0;
}

void switchUndoMenu (struct lines * lines, BOOL u)
{
    if (u == TRUE)
	OnMenu (lines->window, SHIFTITEM(UNDO_MENU));
    else
	OffMenu (lines->window, SHIFTITEM(UNDO_MENU));
}

void switchRecallMenu (struct lines * lines, BOOL r)
{
    if (r == TRUE)
	OnMenu (lines->window, SHIFTITEM(RECALL_MENU));
    else
	OffMenu (lines->window, SHIFTITEM(RECALL_MENU));
}

void addScore (struct lines * lines, long ballsErased)
{
    if (ballsErased >= ALIGNMENT_MIN)
    {
	lines->score += 2 * ballsErased * ballsErased - 20 * ballsErased + 60;
	if (! lines->ShowNextBalls)
	    lines->score += 1;
	updateTitle (lines, -1);
    };
}

void startGame (struct lines * lines)
{
    lines->round = lines->score = lines->score_undo = 0;
    lines->GameOver = FALSE;
    clearcells (&lines->cells);
    generateRandomBalls (lines);
    if (placeNextBalls (lines))
	lines->round++;
    generateRandomBalls (lines);
    if (lines->ShowNextBalls)
	ShowNextBalls (lines, 1);
    updateTitle (lines, -1);
    switchRecallMenu (lines, TRUE);
    switchUndoMenu (lines, FALSE);
}

void viewmessage (struct lines * lines, long message_ID)
{
    SetWindowTitles (lines->window, GetLocaleString(message_ID), (char *) -1);
    lines->ticks = 20;
}

#define GO_EMPTY    4
#define GO_A	    5
#define GO_B	    6
#define GO_BALL     7

BOOL existPath (struct lines * lines, long bx, long by, long ax, long ay)
{
    long dx[4] = { 1, -1, 0, 0 }, dy[4] = { 0, 0, 1, -1 }, x, y, dir, i, nx, ny;
    char pf[NUMCELLSH][NUMCELLSW];
    struct Waypoints lastchanged[2][NUMCELLSH*NUMCELLSW];
    long lastChangedCount[2], currentchanged = 0, nextchanged = 1;
    BOOL reached = FALSE;

    if (getBall (&lines->cells, ax, ay) != NOBALL)
	return FALSE;

    for (y = 0;  y < NUMCELLSH;  y++)
	for(x = 0;  x < NUMCELLSW;  x++)
	    pf[y][x] = (getBall (&lines->cells, x, y) == NOBALL) ? GO_EMPTY : GO_BALL;

    lastchanged[currentchanged][0].x = ax;
    lastchanged[currentchanged][0].y = ay;
    lastChangedCount[currentchanged] = 1;
    pf[ay][ax] = GO_A;
    pf[by][bx] = GO_B;

    do
    {
	lastChangedCount[nextchanged] = 0;
	for (dir = 0;  dir < 4;  dir++)
	{
	    for (i = 0 ;  i < lastChangedCount[currentchanged];  i++)
	    {
		nx = lastchanged[currentchanged][i].x + dx[dir];
		ny = lastchanged[currentchanged][i].y + dy[dir];
		if ((nx >= 0) && (nx < NUMCELLSW) && (ny >= 0) && (ny < NUMCELLSH))
		{
		    if (pf[ny][nx] == GO_EMPTY  || (nx == bx && ny == by))
		    {
			pf[ny][nx] = dir;
			lastchanged[nextchanged][lastChangedCount[nextchanged]].x = nx;
			lastchanged[nextchanged][lastChangedCount[nextchanged]].y = ny;
			lastChangedCount[nextchanged]++;
		    };
		    if ((nx == bx) && (ny == by))
		    {
			reached = TRUE;
			break;
		    }
		}
	    }
	}
	nextchanged = nextchanged ^ 1;
	currentchanged = nextchanged ^ 1;
    }
    while (! reached  &&  lastChangedCount[currentchanged] != 0);

    if (reached)
    {
	lines->moves = 0;
	for (x = bx, y = by, dir;  (dir = pf[y][x]) != GO_A;  x -=dx[dir],y -= dy[dir])
	{
	    lines->way[lines->moves].x = x;
	    lines->way[lines->moves].y = y;
	    lines->moves++;
	}
	lines->way[lines->moves].x = x;
	lines->way[lines->moves].y = y;
    }
    return reached;
}

void drawAlignedBalls (struct lines * lines, BOOL on)
{
    long x, y;

    for (y = 0;  y < NUMCELLSH;  y++)
    {
	for(x = 0;  x < NUMCELLSW;  x++)
	{
	    if (lines->cells.cell[y][x].align)
		if (on)
		    DrawBall (lines, x, y, lines->cells.cell[y][x].color);
		else
		    DrawBall (lines, x, y, AREA_BACKGROUND);
	}
    }
}

long deleteAlignedBalls (struct lines * lines)
{
    long x, y, deleted = 0;

    for (x = 0;  x < 3;  x++)
    {
	drawAlignedBalls (lines, FALSE);
	delay (lines->speed);
	drawAlignedBalls (lines, TRUE);
	delay (lines->speed);
    }
    drawAlignedBalls (lines, FALSE);
    for (y = 0;  y < NUMCELLSH;  y++)
    {
	for (x = 0;  x < NUMCELLSW;  x++)
	{
	    if (lines->cells.cell[y][x].align)
	    {
		clearcell (&lines->cells.cell[y][x]);
		deleted++;
	    }
	}
    }
    return deleted;
}

long erase5Balls (struct lines * lines)
{
    long x, y, color, newcolor, count, i, xs, ys, cb;
    /* BOOL array for balls, that must be erased */
    BOOL bit_erase[NUMCELLSH][NUMCELLSW];

    for (y = 0;  y < NUMCELLSH;  y++)
	for (x = 0;  x < NUMCELLSW;  x++)
	    bit_erase[y][x] = FALSE;

    /* Check for horizontal alignments */
    for (y = 0;  y < NUMCELLSH;  y++)
    {
	count = 1;
	color = NOBALL;
	for (x = 0;  x < NUMCELLSW;  x++)
	{
	    if ((newcolor = getBall (&lines->cells, x, y)) == color)
	    {
		if (color != NOBALL)
		{
		    count++;
		    if (count  >=  ALIGNMENT_MIN)
			if (count  ==  ALIGNMENT_MIN)
			    for (i = 0;  i < ALIGNMENT_MIN;  i++)
				bit_erase[y][x-i] = TRUE;
			else bit_erase[y][x] = TRUE;
		}
	    }
	    else
	    {
		color = newcolor;
		count = 1;
	    }
	}
    }

    /* Check for vertical alignments */
    for (x = 0;  x < NUMCELLSW;  x++)
    {
	count = 0;
	color = NOBALL;
	for (y = 0;  y < NUMCELLSH;  y++)
	{
	    if ((newcolor = getBall (&lines->cells, x, y)) == color)
	    {
		if (color != NOBALL)
		{
		    count++;
		    if (count >= ALIGNMENT_MIN)
			if (count == ALIGNMENT_MIN)
			    for (i = 0;  i < ALIGNMENT_MIN;  i++)
				bit_erase[y-i][x] = TRUE;
			else bit_erase[y][x] = TRUE;
		}
	    }
	    else
	    {
		color = newcolor;
		count = 1;
	    }
	}
    }

    /* Check for left-down to rigth-up diagonal alignments */
    for (xs = NUMCELLSW-1, ys = NUMCELLSH - ALIGNMENT_MIN;  xs >= ALIGNMENT_MIN-1; )
    {
	count = 0;
	color = NOBALL;
	for (x = xs, y = ys;  x >= 0 && y < NUMCELLSH;  x--, y++ )
	{
	    if ((newcolor = getBall (&lines->cells, x, y)) == color)
	    {
		if (color != NOBALL)
		{
		    count++;
		    if (count >= ALIGNMENT_MIN)
			if (count == ALIGNMENT_MIN)
			    for (i = 0;  i < ALIGNMENT_MIN;  i++)
				bit_erase[y-i][x+i] = TRUE;
			else bit_erase[y][x] = TRUE;
		}
	    }
	    else
	    {
		color = newcolor;
		count = 1;
	    }
	}
	if (ys > 0)
	    ys--;
	else
	    xs--;
    }

    /* Check for left-up to rigth-down diagonal alignments */
    for (xs = 0, ys = NUMCELLSH - ALIGNMENT_MIN;  xs <= NUMCELLSW - ALIGNMENT_MIN; )
    {
	count = 0;
	color = NOBALL;
	for (x = xs, y = ys;  x < NUMCELLSW && y < NUMCELLSH;  x++, y++ )
	{
	    if ((newcolor = getBall (&lines->cells, x, y)) == color)
	    {
		if (color != NOBALL)
		{
		    count++;
		    if (count >= ALIGNMENT_MIN)
			if (count == ALIGNMENT_MIN)
			    for (i = 0;  i < ALIGNMENT_MIN;  i++)
				bit_erase[y-i][x-i] = TRUE;
			else
			    bit_erase[y][x] = TRUE;
		}
	    }
	    else
	    {
		color = newcolor;
		count = 1;
	    }
	}
	if (ys > 0)
	    ys--;
	else
	    xs++;
    }

    /* Remove all lines balls, that more than ALIGNMENT_MIN */
    cb = 0;
    for (y = 0;  y < NUMCELLSH;  y++)
	for (x = 0;  x < NUMCELLSW;  x++)
	{
	    if (bit_erase[y][x])
	    {
		lines->cells.cell[y][x].align = 1;
		cb++;
	    }
	}
    if (cb > 0)
    {
	cb = deleteAlignedBalls (lines);
	addScore  (lines, cb);
    }
    return cb;
}

char * open_name_requester (struct lines * lines, long level, long n)
{
    Object * object, * name_gadget, * layout_object;
    const char * chaine;
    char t[50], * name;
    struct Window * w;
    long end = FALSE, code;

    SetAttrs (lines->object, WA_BusyPointer, TRUE, TAG_END);
    sprintf (t, GetLocaleString (YOU_GOT_SCORE_N_STRING), n+1, level+1);
    chaine = t;
    object = WindowObject,
	WA_ScreenTitle, AMILINES_TXT,
	WA_Title, AMILINES_TXT,
	WA_Activate, TRUE,
	WA_DepthGadget, TRUE,
	WA_DragBar, TRUE,
	WA_PubScreen, lines->screen,
	WA_CloseGadget, TRUE,
	WA_RMBTrap, TRUE,
	WINDOW_RefWindow, lines->window,
	WINDOW_Position,  WPOS_CENTERSCREEN,
	WINDOW_ParentGroup, layout_object = VGroupObject,
	    LAYOUT_AddChild, text_block (1, &chaine),
	    LAYOUT_AddChild, name_gadget = string_gadget ("", 15, GADGET_NAME),
	    CHILD_Label, label_object (ENTER_YOUR_NAME_STRING),
	    LAYOUT_AddChild, buttons_ok_no(),
	LayoutEnd,
    EndWindow;
    if (object)
    {
	if (w = (struct Window *) RA_OpenWindow (object))
	{
	    ActivateLayoutGadget ((struct Gadget *) layout_object, w, NULL, (Object) name_gadget);
	    do
	    {
		code = handle_request (lines, object);
		switch (code)
		{
		    case -1:
		    case GADGET_NO:
			end = -1;	break;

		    case GADGET_OK:
			get_string (name_gadget, &name);
			if (name[0])
			{
			    if (n < 9)
				for (code = 9;  code >= n;  code--)
				    lines->high_score[level][code] = lines->high_score[level][code-1];
			    lines->high_score[level][n].score = lines->score;
			    strcpy (lines->high_score[level][n].name, name);
			    lines->high_score[level][n].level = lines->level;
			    end = TRUE;
			}
			break;
		}
	    }
	    while (end == FALSE);
	}
	else
	    error (OPENREQUESTER_ERROR_STRING);
	DisposeObject (object);
    }
    else
	error (ALLOCATION_REQUESTER_ERROR_STRING);
    SetAttrs (lines->object, WA_BusyPointer, FALSE, TAG_END);
    if (end == TRUE)
	return lines->high_score[level][n].name;
    return 0;
}

void load_highscores (struct lines * lines)
{
    char t[30];
    long n, i, lev;
    BPTR file = Open (AMILINES_HIGHSCORES_FILE, MODE_OLDFILE);
    if (file)
    {
	if (Read (file, t, 19) == 19)
	{
	    t[19] = 0;
	    if (strcmp (t, AMILINES_HIGHSCORES_HEADER) == 0)
	    {
		for (lev = 0;  lev <= LEVEL_MAX;  lev++)
		{
		    for (i = 0;  i < 10;  i++)
		    {
			if (Read (file, t, 24) != 24)
			{
			    error (LOADING_SCORES_ERROR_STRING);
			    break;
			}
			strncpy (lines->high_score[lev][i].name, t, 14);
			StrToLong (&t[15], &n);
			lines->high_score[lev][i].score = n;
			StrToLong (&t[21], &n);
			lines->high_score[lev][i].level = n - 1;
		    }
		}
	    }
	    else
		error (FORMAT_SCORES_ERROR_STRING);
	}
	else
	    error (LOADING_SCORES_ERROR_STRING);
	Close (file);
    }
    else
	error (LOADING_SCORES_ERROR_STRING);
}

void save_highscores (struct lines * lines)
{
    long i, lev;
    char m[24];
    BPTR file = Open (AMILINES_HIGHSCORES_FILE, MODE_NEWFILE);
    if (file)
    {
	if (Write (file, AMILINES_HIGHSCORES_HEADER, 19)  ==  19)
	{
	    for (lev = LEVEL_MIN;  lev <= LEVEL_MAX;  lev++)
	    {
		for (i = 0;  i < 10;  i++)
		{
		    sprintf (m, "%-14s %5ld %2ld", lines->high_score[lev][i].name, lines->high_score[lev][i].score, lev + 1);
		    if (Write (file, m, 23) != 23)
		    {
			error (SAVING_SCORES_ERROR_STRING);
			break;
		    }
		    if (Write (file, "\n", 1)  !=  1)
		    {
			error (SAVING_SCORES_ERROR_STRING);
			break;
		    }
		}
	    }
	}
	else
	    error (SAVING_SCORES_ERROR_STRING);
	Close (file);
    }
    else
	error (SAVING_SCORES_ERROR_STRING);
}

VOID freeListBrowserNodes (struct List * list)
{
    struct Node * node, * nextnode;

    node = list->lh_Head;
    while (nextnode = node->ln_Succ)
    {
	FreeListBrowserNode (node);
	node = nextnode;
    }
    // NewList (list);
}

long makeListBrowserNodes (struct List * list, struct lines * lines_copy, int show_level, long * n)
{
    struct Node * node;
    int i;

    NewList (list);
    for (i = 0;  i < 10;  i++)
    {
	* n = i + 1;
	node = AllocListBrowserNode (3,
	    LBNA_Column, 0,
		LBNCA_Integer, n++,
		LBNCA_Justification, LCJ_CENTER,
	    LBNA_Column, 1,
		LBNCA_CopyText, TRUE,
		LBNCA_Justification, LCJ_LEFT,
		LBNCA_Text, show_level <= LEVEL_MAX ? lines_copy->high_score[show_level][i].name : lines_copy->high_score[i][0].name,
	    LBNA_Column, 2,
		LBNCA_Integer, show_level <= LEVEL_MAX ? &lines_copy->high_score[show_level][i].score : &lines_copy->high_score[i][0].score,
		LBNCA_Justification, LCJ_RIGHT,
	TAG_DONE);
	if (node)
	    AddTail (list, node);
	else
	{
	    freeListBrowserNodes (list);
	    return 0;
	}
    }
    return 1;
}

void open_bestscores_requester (struct lines * lines, long show_level)
{
    Object * o, * level_gadget, * list_gadget;
    struct Window * w;
    struct lines * lines_copy;
    long end = FALSE, i, rank[10], level;
    char * level_labels[LEVEL_MAX+3];
    struct List list;
    struct ColumnInfo columns[] =
    {
       { 15, 0, 0 },
       { 65, 0, 0 },
       { 20, 0, 0 },
       { -1, (STRPTR)~0, -1 }
    };

    columns[0].ci_Title = (STRPTR) GetLocaleString(NUM_STRING);
    columns[1].ci_Title = (STRPTR) GetLocaleString(NAME_STRING);
    columns[2].ci_Title = (STRPTR) GetLocaleString(SCORE_STRING);
    if (lines_copy = (struct lines *) AllocVec (sizeof(struct lines), MEMF_CLEAR))
    {
	memcpy (lines_copy, lines, sizeof (struct lines));
	if (makeListBrowserNodes (&list, lines_copy, show_level, rank))
	{
	    for (i = LEVEL_MIN;  i <= LEVEL_MAX+1;  i++)
		level_labels[i] = GetLocaleString (LEVEL_1_STRING + i);
	    level_labels[i] = 0;
	    SetAttrs (lines->object, WA_BusyPointer, TRUE, TAG_END);
	    o = WindowObject,
		WA_ScreenTitle, AMILINES_TXT,
		WA_Title, GetLocaleString (AMILINES_BEST_SCORES_STRING),
		WA_Activate, TRUE,
		WA_DepthGadget, TRUE,
		WA_DragBar, TRUE,
		WA_PubScreen, lines->screen,
		WA_CloseGadget, TRUE,
		// WA_SizeGadget, TRUE,
		WA_RMBTrap, TRUE,
		WINDOW_Position, WPOS_CENTERSCREEN,
		WINDOW_ParentGroup, VGroupObject,
		    LAYOUT_AddChild, level_gadget = cycle_object (GADGET_LEVEL, show_level, level_labels),
		    LAYOUT_AddChild, list_gadget = NewObject (LISTBROWSER_GetClass(), NULL,
			GA_ReadOnly, TRUE,
			LISTBROWSER_Labels, (ULONG) &list,
			LISTBROWSER_ShowSelected, FALSE,
			LISTBROWSER_VerticalProp, FALSE,
			LISTBROWSER_ColumnInfo, (ULONG) columns,
			LISTBROWSER_ColumnTitles, TRUE,
			LISTBROWSER_MinVisible, 11,
		    TAG_END),
		    LAYOUT_AddChild, HGroupObject,
			LAYOUT_FixedVert, FALSE,
			LAYOUT_BevelStyle, BVS_GROUP,
			LAYOUT_SpaceOuter, TRUE,
			LAYOUT_SpaceInner, TRUE,
			LAYOUT_AddChild, locale_button (GADGET_SAVE, SAVE_STRING),
			LAYOUT_AddChild, locale_button (GADGET_OK, OK_STRING),
			LAYOUT_AddChild, locale_button (GADGET_CLEAR, CLEAR_STRING),
			LAYOUT_AddChild, locale_button (GADGET_NO, CANCEL_STRING),
			LAYOUT_EvenSize, TRUE,
		    LayoutEnd,
		LayoutEnd,
	    EndWindow;
	    if (o)
	    {
		if (w = (struct Window *) RA_OpenWindow (o))
		{
		    do
		    {
			i = handle_request (lines, o);
			switch (i)
			{
			    case -1:		/* CLOSEWINDOW */
			    case GADGET_NO:
				end = TRUE;
				break;

			    case GADGET_SAVE:
				memcpy (lines, lines_copy, sizeof (struct lines));
				save_highscores (lines);
				end = TRUE;
				break;

			    case GADGET_OK:
				memcpy (lines, lines_copy, sizeof (struct lines));
				end = TRUE;
				break;

			    case GADGET_CLEAR:
				level = get_cycle (level_gadget);
				if (level <= LEVEL_MAX)
				{
				    for (i = 0;  i < 10;  i++)
				    {
					strcpy (lines_copy->high_score[level][i].name, "AmiLines");
					lines_copy->high_score[level][i].score = init_scores[level] - step_scores[level] * i;
					lines_copy->high_score[level][i].level = 0;
				    }
				    SetGadgetAttrs ((struct Gadget *) list_gadget, w, 0, LISTBROWSER_Labels, ~0, TAG_DONE);
				    freeListBrowserNodes (&list);
				    makeListBrowserNodes (&list, lines_copy, level, rank);
				    SetGadgetAttrs ((struct Gadget *) list_gadget, w, 0, LISTBROWSER_Labels, &list, TAG_DONE);
				}
				break;

			    case GADGET_LEVEL:
				level = get_cycle (level_gadget);
				SetGadgetAttrs ((struct Gadget *) list_gadget, w, 0, LISTBROWSER_Labels, ~0, TAG_DONE);
				freeListBrowserNodes (&list);
				makeListBrowserNodes (&list, lines_copy, level, rank);
				SetGadgetAttrs ((struct Gadget *) list_gadget, w, 0, LISTBROWSER_Labels, &list, TAG_DONE);
				break;
			}
		    }
		    while (end == FALSE);
		}
		else
		    error (OPENREQUESTER_ERROR_STRING);
		DisposeObject (o);
	    }
	    else
		error (ALLOCATION_REQUESTER_ERROR_STRING);
	    freeListBrowserNodes (&list);
	}
	else
	    error (NO_MEMORY_ERROR_STRING);
	FreeVec (lines_copy);
    }
    else
	error (NO_MEMORY_ERROR_STRING);
    SetAttrs (lines->object, WA_BusyPointer, FALSE, TAG_END);
}

void check_scores (struct lines * lines)
{
    long i, jackpot = -1;

    for (i = 0;  i < 10;  i++)
    {
	if (lines->score >= lines->high_score[lines->level][i].score)
	{
	    if (lines->score == lines->high_score[lines->level][i].score)
		if (lines->level < lines->high_score[lines->level][i].level)
		    continue;
	    viewmessage (lines, HIGH_SCORE_STRING);
	    if (open_name_requester (lines, lines->level, i))
	    {
		jackpot = lines->level;
		break;
	    }
	    else
		return;
	}
    }
    if (jackpot >= 0)
	open_bestscores_requester (lines, jackpot);
}

void saveUndo (struct field * f1, struct field * f2)
{
    long x, y;

    for (y = 0;  y < NUMCELLSH;  y++)
	for (x = 0;  x < NUMCELLSW;  x++)
	    f1->cell[y][x] = f2->cell[y][x];
}

long mousePressEvent (struct lines * lines, long x, long y)
{
    long color, i;

    if (lines->GameOver)
    {
	viewmessage (lines, GAME_OVER_START_NEW_STRING);
	return -1;
    }
    if (! lines->round)
    {
	viewmessage (lines, START_GAME_FIRST_STRING);
	return -1;
    }
    y -= lines->field_area->Top;    y /= lines->cellsize;
    x -= lines->field_area->Left;   x /= lines->cellsize;

    /* Check range */
    if (! checkBounds (x, y))
    {
	if (lines->selected)
	    viewmessage (lines, CLICK_ON_FREECELL_STRING);
	else
	    viewmessage (lines, SELECT_BALL_STRING);
	return -1;
    }
    color = getBall (&lines->cells, x, y);
    if (lines->selected)
    {
	if (color == NOBALL)
	{
	    if (existPath (lines, lines->jumpingCol, lines->jumpingRow, x, y))
	    {
		DrawBall (lines, lines->jumpingCol, lines->jumpingRow, lines->cells.cell[lines->jumpingRow][lines->jumpingCol].color);
		lines->selected = 0;
		saveUndo (&lines->cells_undo, & lines->cells);
		switchUndoMenu (lines, TRUE);
		switchRecallMenu (lines, TRUE);
		updateTitle (lines, -1);
		for (i = 0;  i < lines->moves;  i++)
		    moveBall (lines, lines->way[i].x, lines->way[i].y, lines->way[i+1].x, lines->way[i+1].y);
		if (erase5Balls (lines))
		{
		    lines->round++;
		    return 0;
		}
		if (freeSpace (&lines->cells) > 0)
		    return 1;
		lines->GameOver = TRUE;
		updateTitle (lines, GAME_OVER_STRING);
		switchUndoMenu (lines, FALSE);
		check_scores (lines);
		return 0;
	    }
	    else
	    {
		viewmessage (lines, NO_PATH_STRING);
		DisplayBeep (0);
	    }
	}
	else
	{
	    if (lines->jumpingCol == x  &&  lines->jumpingRow == y)
	    {
		DrawBall (lines, lines->jumpingCol, lines->jumpingRow, lines->cells.cell[lines->jumpingRow][lines->jumpingCol].color);
		lines->selected = 0;
	    }
	    else
	    {
		DrawBall (lines, lines->jumpingCol, lines->jumpingRow, lines->cells.cell[lines->jumpingRow][lines->jumpingCol].color);
		lines->jumpingCol = x;
		lines->jumpingRow = y;
		DrawSelectedBall (lines, x, y, color);
	    }
	    updateTitle (lines, -1);
	    return 0;
	}
    }
    else
    {
	if (color != NOBALL)
	{
	    lines->jumpingCol = x;
	    lines->jumpingRow = y;
	    lines->selected = 1;
	    DrawSelectedBall (lines, x, y, color);
	    updateTitle (lines, -1);
	}
	else
	    viewmessage (lines, SELECT_BALL_STRING);
    }
    return 0;
}

void handle_next_turn (struct lines * lines)
{
    updateTitle (lines, -1);
    if (placeNextBalls (lines))
    {
	erase5Balls (lines);
	lines->round++;
	if (freeSpace (&lines->cells) > 0)
	{
	    generateRandomBalls (lines);
	    if (lines->ShowNextBalls)
		ShowNextBalls (lines, 1);
	}
	else
	{
	    lines->GameOver = TRUE;
	    updateTitle (lines, GAME_OVER_STRING);
	    switchUndoMenu (lines, FALSE);
	    check_scores (lines);
	}
    }
}

void restoreUndo (struct field * f1, struct field * f2)
{
    long x, y;

    for (y = 0;  y < NUMCELLSH;  y++)
	for (x = 0;  x < NUMCELLSW;  x++)
	    f1->cell[y][x] = f2->cell[y][x];
}

void ShowLastBalls (struct lines * lines)
{
    long i, j;

    for (j = 0;  j < 4;  j++)
    {
	delay (2);
	for (i = 0;  i < BALLSDROP;  i++)
	{
	    if (lines->ballsdrop[i].x < 0)
		break;
	    if (lines->cells.cell[lines->ballsdrop[i].y][lines->ballsdrop[i].x].color != NOBALL)
		DrawBall (lines, lines->ballsdrop[i].x, lines->ballsdrop[i].y, AREA_BACKGROUND);
	}
	if (i)
	    delay (2);
	else
	    break;
	for (i = 0;  i < BALLSDROP;  i++)
	{
	    if (lines->ballsdrop[i].x  <  0)
		break;
	    if (lines->cells.cell[lines->ballsdrop[i].y][lines->ballsdrop[i].x].color != NOBALL)
		DrawBall (lines, lines->ballsdrop[i].x, lines->ballsdrop[i].y, lines->cells.cell[lines->ballsdrop[i].y][lines->ballsdrop[i].x].color);
	}
    }

}

/* Redraw the balls (after undo) */
void RedrawBalls (struct lines * lines)
{
    long x, y;
    struct cell * c;
    struct field * f = &lines->cells;

    RedrawGame (lines);
    for (y = 0;  y < NUMCELLSH;  y++)
	for (x = 0;  x < NUMCELLSW;  x++)
	{
	    c = &f->cell[y][x];
	    if (! isFree (c))
		DrawBall (lines, x, y, c->color);
	}
}

void make_undo (struct lines * lines)
{
    long i;

    if (lines->GameOver)
       return;
    if (lines->round < 1)
	return;
    lines->round--;
    for (i = 0;  i < BALLSDROP;  i++ )
	lines->nextBalls[i] = lines->nextBalls_undo[i];
    lines->score = lines->score_undo;
    updateTitle (lines, -1);
    restoreUndo (&lines->cells, &lines->cells_undo);
    RedrawBalls (lines);
    switchUndoMenu (lines, FALSE);
    switchRecallMenu (lines, FALSE);
    lines->ballsdrop[0].x = -1;
    lines->selected = 0;
    if (lines->ShowNextBalls)
	ShowNextBalls (lines, 1);
}

long open_level_requester (struct lines * lines)
{
    long level = lines->level, code, end = FALSE;
    const char * chaine = GetLocaleString ((lines->GameOver == 0  && lines->round > 0) ? WARNING_STRING : SET_LEVEL_STRING);
    Object * object, * level_gadget, * layout_object;
    struct Window * w;

    SetAttrs (lines->object, WA_BusyPointer, TRUE, TAG_END);
    object = WindowObject,
	WA_ScreenTitle, AMILINES_TXT,
	WA_Title, GetLocaleString (AMILINES_VERSION_LEVEL_STRING),
	WA_Activate, TRUE,
	WA_DepthGadget, TRUE,
	WA_DragBar, TRUE,
	WA_PubScreen, lines->screen,
	WA_CloseGadget, TRUE,
	WA_RMBTrap, TRUE,
	WA_IDCMP, IDCMP_MOUSEBUTTONS | IDCMP_CLOSEWINDOW | IDCMP_GADGETUP | IDCMP_RAWKEY,
	WINDOW_RefWindow, lines->window,
	WINDOW_Position,  WPOS_CENTERSCREEN,
	WINDOW_ParentGroup, layout_object = VGroupObject,
	    LAYOUT_AddChild, text_block (1, &chaine),
	    LAYOUT_AddChild, level_gadget = number_gadget (level + 1, GADGET_LEVEL),
	    CHILD_Label, label_object (LEVEL_STRING),
	    LAYOUT_AddChild, buttons_ok_no(),
	LayoutEnd,
    EndWindow;
    if (object)
    {
	if (w = (struct Window *) RA_OpenWindow (object))
	{
	    ActivateLayoutGadget ((struct Gadget *) layout_object, w, NULL, (Object) level_gadget);
	    do
	    {
		code = handle_request (lines, object);
		switch (code)
		{
		    case GADGET_LEVEL:
			get_number (level_gadget, (ULONG *) &level);
			level = level - 1;
			if (level < LEVEL_MIN  ||  level > LEVEL_MAX)
			{
			    level = (level < LEVEL_MIN ? LEVEL_MIN : LEVEL_MAX);
			    set_number (level_gadget, w, level + 1);
			    DisplayBeep (0);
			}
			break;

		    case GADGET_OK:
			lines->level = level;
			level = -1;
			end = TRUE;
			break;

		    case GADGET_NO:
		    case -1:		/* CLOSEWINDOW */
			end = TRUE;
			break;
		}
	    }
	    while (end == FALSE);
	}
	else
	    error (OPENREQUESTER_ERROR_STRING);
	DisposeObject (object);
    }
    else
	error (ALLOCATION_REQUESTER_ERROR_STRING);
    SetAttrs (lines->object, WA_BusyPointer, FALSE, TAG_END);
    return level;
}

void save_prefs (struct lines * lines, long cellsizegadget)
{
    struct DiskObject * dobj;
    char level[8], animation[12], cellsize[12];
    STRPTR *  old_tooltypes, tooltypes[4];

    if (dobj = GetDiskObject ("AmiLines"))
    {
	old_tooltypes = dobj->do_ToolTypes;
	dobj->do_ToolTypes = tooltypes;
	tooltypes[0] = level;
	sprintf (level, "LEVEL=%ld", lines->start_level);
	tooltypes[1] = animation;
	sprintf (animation, "ANIMATION=%ld", lines->speed);
	tooltypes[2] = cellsize;
	sprintf (cellsize, "CELLSIZE=%ld", cellsizegadget);
	tooltypes[3] = 0;
	if (PutDiskObject ("AmiLines", dobj) == FALSE)
	    error (SAVING_PREFS_ERROR_STRING);
	dobj->do_ToolTypes = old_tooltypes;
	FreeDiskObject (dobj);
    }
    else
	error (SAVING_DISKOBJECT_ERROR_STRING);
}

long open_prefs_requester (struct lines * lines)
{
    long end = FALSE, cellsizegadget = lines->cellsizegadget, level = lines->start_level, code;
    Object * object, * level_gadget, * speed_gadget, * cellsize_gadget;
    struct Window * w;
    char * speed_labels[6], * cellsize_labels[5];

    SetAttrs (lines->object, WA_BusyPointer, TRUE, TAG_END);
    speed_labels[0] = GetLocaleString (VERY_SLOW_SPEED_STRING);
    speed_labels[1] = GetLocaleString (SLOW_SPEED_STRING);
    speed_labels[2] = GetLocaleString (MEDIUM_SPEED_STRING);
    speed_labels[3] = GetLocaleString (FAST_SPEED_STRING);
    speed_labels[4] = GetLocaleString (VERY_FAST_SPEED_STRING);
    speed_labels[5] = 0;
    cellsize_labels[0] = GetLocaleString(SMALL_SIZE_STRING);
    cellsize_labels[1] = GetLocaleString(MEDIUM_SIZE_STRING);
    cellsize_labels[2] = GetLocaleString(LARGE_SIZE_STRING);
    cellsize_labels[3] = GetLocaleString(VERY_LARGE_SIZE_STRING);
    cellsize_labels[4] = 0;
    object = WindowObject,
	WA_ScreenTitle, AMILINES_TXT,
	WA_Title, GetLocaleString (AMILINES_PREFS_STRING),
	WA_Activate, TRUE,
	WA_DepthGadget, TRUE,
	WA_DragBar, TRUE,
	WA_PubScreen, lines->screen,
	WA_CloseGadget, TRUE,
	WA_RMBTrap, TRUE,
	WA_IDCMP, IDCMP_MOUSEBUTTONS | IDCMP_CLOSEWINDOW | IDCMP_GADGETUP | IDCMP_RAWKEY,
	WINDOW_RefWindow, lines->window,
	WINDOW_Position,  WPOS_CENTERSCREEN,
	WINDOW_ParentGroup, VGroupObject,
	    LAYOUT_AddChild, level_gadget = number_gadget (lines->start_level + 1, GADGET_LEVEL),
	    CHILD_Label, label_object (START_LEVEL_STRING),
	    LAYOUT_AddChild, speed_gadget = cycle_object (GADGET_SPEED, lines->speed, speed_labels),
	    CHILD_Label, label_object (ANIMATION_SPEED_STRING),
	    LAYOUT_AddChild, cellsize_gadget = cycle_object (GADGET_SIZE, lines->cellsizegadget, cellsize_labels),
	    CHILD_Label, label_object (CELL_SIZE_STRING),
	    LAYOUT_AddChild, HGroupObject,
		LAYOUT_BevelStyle, BVS_GROUP,
		LAYOUT_AddChild, locale_button (GADGET_SAVE, SAVE_STRING),
		LAYOUT_AddChild, locale_button (GADGET_OK, USE_STRING),
		LAYOUT_AddChild, locale_button (GADGET_NO, CANCEL_STRING),
	    LayoutEnd,
	LayoutEnd,
    EndWindow;
    if (object)
    {
	if (w = (struct Window *) RA_OpenWindow (object))
	{
	    do
	    {
		code = handle_request (lines, object);
		switch (code)
		{
		    case GADGET_LEVEL:
			get_number (level_gadget, (ULONG *) &level);
			level = level -1;
			if (level < LEVEL_MIN  ||  level > LEVEL_MAX)
			{
			    level = (level < LEVEL_MIN ? LEVEL_MIN : LEVEL_MAX);
			    set_number (level_gadget, w, level + 1);
			    DisplayBeep (0);
			}
			break;

		    case GADGET_OK:
			lines->start_level = level;
			lines->speed = get_cycle (speed_gadget);
			cellsizegadget = get_cycle (cellsize_gadget);
			level = -1;
			end = TRUE;
			break;

		    case GADGET_SAVE:
			lines->start_level = level;
			lines->speed = get_cycle (speed_gadget);
			cellsizegadget = get_cycle (cellsize_gadget);
			save_prefs (lines, cellsizegadget);
			end = TRUE;
			break;

		    case GADGET_NO:
		    case -1:		/* CLOSEWINDOW */
			cellsizegadget = lines->cellsizegadget;
			end = TRUE;
			break;
		}
	    }
	    while (end == FALSE);
	}
	else
	    error (OPENREQUESTER_ERROR_STRING);
	DisposeObject (object);
    }
    else
	error (ALLOCATION_REQUESTER_ERROR_STRING);
    SetAttrs (lines->object, WA_BusyPointer, FALSE, TAG_END);
    return cellsizegadget;
}

void handle_game (struct lines * lines)
{
    BOOL end = FALSE;
    ULONG signal, classe, siggot;
    long x, y, new_size;
    struct IntuiMessage * message;
    UWORD code;

    do
    {
	signal = 1 << lines->window->UserPort->mp_SigBit | SIGBREAKF_CTRL_C;
	siggot = Wait (signal | SIGBREAKF_CTRL_C);
	if (siggot & SIGBREAKF_CTRL_C)
	    end = TRUE;
	while (message = (struct IntuiMessage *) GetMsg (lines->window->UserPort))
	{
	    classe = message->Class;
	    code = message->Code;
	    x = message->MouseX;
	    y = message->MouseY;
	    ReplyMsg ((struct Message *) message);
	    if (classe == IDCMP_CLOSEWINDOW)
		end = TRUE;
	    else if (classe == IDCMP_MOUSEBUTTONS)
	    {
		if (code == SELECTDOWN)
		    if (mousePressEvent (lines, x, y) > 0)
			handle_next_turn (lines);
	    }
	    else if (classe == IDCMP_INTUITICKS)
	    {
		if (lines->ticks > 0)
		{
		    if (--lines->ticks == 0)
			updateTitle (lines, -1);
		}
	    }
	    else if (classe == IDCMP_MENUPICK)
	    {
		switch ITEMNUM(code)
		{
		    case NEW_GAME_MENU: 	/* Début partie */
			RedrawGame (lines);
			startGame (lines);
			break;

		    case UNDO_MENU:		/* Undo */
			make_undo (lines);
			break;

		    case LEVEL_MENU:
			if (open_level_requester (lines) < 0)
			{
			    if (lines->round)
			    {
				lines->GameOver = TRUE;
				updateTitle (lines, GAME_OVER_STRING);
			    }
			    RedrawGame (lines);
			    startGame (lines);
			}
			break;

		    case SHOWNEXT_MENU:
			lines->ShowNextBalls ^= 1;
			if (lines->round)
			{
			    if (lines->ShowNextBalls)
				ShowNextBalls (lines, 1);
			    else
			    {
				ShowNextBalls (lines, 0);
				generateRandomBalls (lines);
			    }
			}
			break;

		    case PASS_MENU:
			if (lines->round)
			{
			    if (lines->GameOver)
				viewmessage (lines, GAME_OVER_START_NEW_STRING);
			    else
			    {
				saveUndo (&lines->cells_undo, &lines->cells);
				switchUndoMenu (lines, TRUE);
				switchRecallMenu (lines, TRUE);
				handle_next_turn (lines);
			    }
			}
			else
			    viewmessage (lines, START_GAME_FIRST_STRING);
			break;

		    case RECALL_MENU:
			if (lines->round)
			    ShowLastBalls (lines);
			else
			    viewmessage (lines, START_GAME_FIRST_STRING);
			break;

		    case HIGHSCORES_MENU:
			open_bestscores_requester (lines, lines->level);
			break;

		    case PREFS_MENU:
			new_size = open_prefs_requester (lines);
			if (new_size != lines->cellsizegadget)
			{
			    lines->cellsize = 22 + (lines->cellsizegadget = new_size) * 10;
			    close_window (lines);
			    if (open_window (lines))
				RedrawBalls (lines);
			    else
				end = 1;
			}
			break;

		    case ABOUT_MENU:	    /* About */
			display_messages (lines, 1, GetLocaleString (ABOUT_STRING));
			break;

		    case QUIT_MENU:	    /* Quit */
			end = 1;;
			break;
		}
		break;
	    }
	}
    }
    while (! end);
}

void lib_alert (char * lib, long ver)
{
    char m[256];

    sprintf (m, GetLocaleString (OPENING_LIBRARY_ERROR_STRING), lib, ver);
    alert (m);
}

struct Library * open_lib (char * libname, long version)
{
    struct Library * lib = OpenLibrary (libname, version);
    return lib;
}

static BOOL open_libs (void)
{
    struct library * lib = libs;

    while (lib->lib)
	if (! (*lib->lib = open_lib (lib->libname, lib->version)))
	{
	    lib_alert (lib->libname, lib->version);
	    return 0;
	}
	else
	    lib++;
    catalog = OpenCatalog (NULL, "AmiLines.catalog", OC_Version, CATALOG_VERSION, TAG_DONE);
    return 1;
}

static void close_libs (void)
{
    struct library * lib = libs;

    CloseCatalog (catalog);
    while (lib->lib)
    {
	CloseLibrary (* lib->lib);
	lib++;
    }
}

int main (void)
{
    LONG i;
    ULONG * color_level;
    struct lines * lines;

    /* Open the libraries.... */
    if (open_libs ())
    {
	if (lines = (struct lines *) AllocVec (sizeof(struct lines), MEMF_CLEAR))
	{
	    srand (time (NULL));
	    clearcells (&lines->cells);
	    /* Init default values */
	    lines->speed = 2;
	    lines->level = lines->start_level = 2;
	    lines->cellsizegadget = 1;
	    check_level_tooltype (lines);
	    load_highscores (lines);
	    lines->cellsize = 22 + lines->cellsizegadget * 10;
	    if (lines->screen = LockPubScreen ("Workbench"))
	    {
		color_level = color_levels;
		for (i = 0;  i <= LINES_COLOR;  i++)
		    lines->colors[i] = ObtainBestPen (lines->screen->ViewPort.ColorMap, *color_level++, *color_level++, *color_level++, TAG_DONE);
		init_menus ();
		if (open_window (lines))
		{
		    handle_game (lines);
		    close_window (lines);
		}
		for (i = 0;  i <= LINES_COLOR;  i++)
		    ReleasePen (lines->screen->ViewPort.ColorMap, lines->colors[i]);
		UnlockPubScreen (NULL, lines->screen);
	    }
	    else
		error (LOCKSCREEN_ERROR_STRING);
	}
	else
	    error (NO_MEMORY_ERROR_STRING);
	FreeVec (lines);
    }
    close_libs ();
    return 0;
}

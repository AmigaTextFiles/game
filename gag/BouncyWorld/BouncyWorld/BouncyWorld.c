/************************************************************************
*																		*
*								BOUNCYWORLD								*
*																		*
* Copyright ©1995 Nick Christie.										*
* All rights reserved.													*
* nick.christie@computing-services.oxford.ac.uk							*
*																		*
* Tab size = 4															*
*																		*
* Get a sprite and animate it as a ball that rolls around the view,		*
* bouncing off the sides and subject to friction. The ball can be		*
* "shoved" with the mouse pointer.										*
*																		*
* TODO:																	*
* 1. Use VB server to animate sprite instead of WaitTOF(), then main	*
*		loop just Wait()s for IDCMP.									*
* 2. Get the sprite to "roll" in the direction it is travelling.		*
*																		*
* To compile with SAS/C 6.51 (using supplied SCOPTIONS):				*
* sc BouncyWorld.c														*
* slink FROM LIB:c.o BouncyWorld.o TO BouncyWorld LIB LIB:scm.lib		*
*	LIB:sc.lib LIB:amiga.lib SC SD NOICONS								*
*																		*
*************************************************************************/

/************************************************************************
******************************  INCLUDES  *******************************
*************************************************************************/

#include "BouncyWorld.h"

/************************************************************************
*****************************  DEFINITIONS  *****************************
*************************************************************************/

#define SPRNUMBER		2
#define SPRINITX		20
#define SPRINITY		20
#define SPRINITSPEED	5
#define SPRINITTHETA	(7*PI/4)
#define SPRWIDTH		16
#define SPRHEIGHT		16
#define SPRCOLLMASK		(1<<9)
#define SPRFRAMECOUNT	6

#define PEN21RED		15
#define PEN21GREEN		15
#define PEN21BLUE		15
#define PEN22RED		0
#define PEN22GREEN		7
#define PEN22BLUE		14
#define PEN23RED		0
#define PEN23GREEN		10
#define PEN23BLUE		6

#define DEFFRICTION		0.995
#define DEFBOUNCE		0.7
#define DEFFORCE		0.2

#define VIEWWIDTH		320
#define VIEWHEIGHT		256

#define GAD_FRICTION	0
#define GAD_BOUNCE		1
#define GAD_FORCE		2
#define GAD_TOTAL		3

#define MENU_PROJECT	0
#define ITEM_ABOUT		0
#define ITEM_NEW		1
#define ITEM_QUIT		2

/*
 * Definitions for CreateGadgetList program system
 */

#define GADPROG_DONE		0
#define GADPROG_CONTEXT		1
#define GADPROG_LEFT		2
#define GADPROG_TOP			3
#define GADPROG_WIDTH		4
#define GADPROG_HEIGHT		5
#define GADPROG_TEXT		6
#define GADPROG_GID			7
#define GADPROG_FLAGS		8
#define GADPROG_TATTR		9
#define GADPROG_KIND		10
#define GADPROG_TAGPTR		11
#define GADPROG_CREATE		12

struct GadProgItem {
	UWORD	gpi_Tag;		/* one of above defines */
	ULONG	gpi_Data;		/* data pertinent to action */
};

/************************************************************************
*************************  EXTERNAL REFERENCES  *************************
*************************************************************************/

extern struct Custom far custom;			/* from amiga.lib */
extern void exit(ULONG);					/* from SAS c.o */

/************************************************************************
*****************************  PROTOTYPES  ******************************
*************************************************************************/

void main(void);
void HandleGadget(struct Gadget *gad,UWORD code);
BOOL HandleMenu(UWORD code);

void EnableNewItem(void);
void DisableNewItem(void);

char *OpenAll(void);
BOOL CreateGadgetList(struct GadProgItem *pc,APTR vi);
void CloseAll(char *);

void MoveBall(void);

/************************************************************************
********************************  DATA  *********************************
*************************************************************************/

/*
 * Library bases
 */

struct IntuitionBase	*IntuitionBase = NULL;
struct GfxBase			*GfxBase = NULL;
struct Library			*GadToolsBase = NULL;

/*
 * I want topaz-8 for text
 */

struct TextAttr TopazAttr = {
	"topaz.font",8,FS_NORMAL,FPF_ROMFONT|FPF_DESIGNED
};

/*
 * For the "About" requester:
 */

struct EasyStruct EasyAbout = {
	sizeof(struct EasyStruct), 0, "About...",
	"BouncyWorld V1.0 by Nick Christie (09/01/94)\n"
	"nick.christie@computing-services.oxford.ac.uk", "Okay" };

char VersionString[] = "$VER: BouncyWorld 1.00 (09.01.94)";

/*
 * Window data
 */

WORD ZoomBox[] = { 80, 40, 240, 11 };

struct TagItem WindowTags[] = {
	WA_Left,		80,
	WA_Top,			40,
	WA_Width,		240,
	WA_Height,		60,
	WA_MaxHeight,	60,
	WA_IDCMP,		IDCMP_CLOSEWINDOW|IDCMP_REFRESHWINDOW|\
					SLIDERIDCMP|IDCMP_MENUPICK,
	WA_Flags,		WFLG_SMART_REFRESH|WFLG_CLOSEGADGET|\
					WFLG_DRAGBAR|WFLG_DEPTHGADGET,
	WA_Title,		(ULONG) "BouncyWorld",
	WA_Zoom,		(ULONG) ZoomBox,
	TAG_DONE };

struct Screen		*ScreenLock = NULL;
APTR				VisualInfo = NULL;
struct Menu			*MainMenu = NULL;
struct Window		*MainWindow = NULL;
struct MsgPort		*MainIPort;
ULONG				MainISigs;
struct Gadget		*MainGList = NULL;
struct Gadget		*MainGadgets[GAD_TOTAL];
BOOL				MainGadgetsAdded = FALSE;

/*
 * Data for the creation of menus by gadtools.
 */

struct NewMenu MainNewMenu[] = {
	NM_TITLE, "Project", 0, 0, 0, 0,
	NM_ITEM, "About...", "A", 0, 0, 0,
	NM_ITEM, "New", "N", NM_ITEMDISABLED, 0, 0,
	NM_ITEM, "Quit", "Q", 0, 0, 0,
	NM_END
};

/*
 * Tag lists for gadtools gadget creation.
 */

struct TagItem SliderTags[] = {
	GTSL_Min,			0,
	GTSL_Max,			100,
	GTSL_LevelFormat,	(ULONG) "%3ld%%",
	GTSL_MaxLevelLen,	5,
	GTSL_LevelPlace,	PLACETEXT_RIGHT,
	GA_RelVerify,		TRUE,
	PGA_Freedom,		LORIENT_HORIZ,
	TAG_DONE
};

struct TagItem FrictionTags[] = {
	GTSL_Level,			100 - ((DEFFRICTION-0.9)*1000),
	TAG_MORE,			(ULONG) SliderTags
};

struct TagItem BounceTags[] = {
	GTSL_Level,			DEFBOUNCE*100,
	TAG_MORE,			(ULONG) SliderTags
};

struct TagItem ForceTags[] = {
	GTSL_Level,			DEFFORCE*100,
	TAG_MORE,			(ULONG) SliderTags
};

/*
 * Gadtools gadget creation "program" for window.
 */

struct GadProgItem MainGadgetProg[] = {

	GADPROG_CONTEXT,	(ULONG) &MainGList,

	GADPROG_LEFT,		80,
	GADPROG_TOP,		16,
	GADPROG_WIDTH,		110,
	GADPROG_HEIGHT,		11,
	GADPROG_TEXT,		(ULONG) "Friction",
	GADPROG_GID,		GAD_FRICTION,
	GADPROG_FLAGS,		PLACETEXT_LEFT|NG_HIGHLABEL,
	GADPROG_TATTR,		(ULONG) &TopazAttr,
	GADPROG_KIND,		SLIDER_KIND,
	GADPROG_TAGPTR,		(ULONG) FrictionTags,
	GADPROG_CREATE,		(ULONG) &MainGadgets[GAD_FRICTION],

	GADPROG_TOP,		30,
	GADPROG_TEXT,		(ULONG) "Bounce",
	GADPROG_GID,		GAD_BOUNCE,
	GADPROG_TAGPTR,		(ULONG) BounceTags,
	GADPROG_CREATE,		(ULONG) &MainGadgets[GAD_BOUNCE],

	GADPROG_TOP,		44,
	GADPROG_TEXT,		(ULONG) "Force",
	GADPROG_GID,		GAD_FORCE,
	GADPROG_TAGPTR,		(ULONG) ForceTags,
	GADPROG_CREATE,		(ULONG) &MainGadgets[GAD_FORCE],

	GADPROG_DONE
};

/*
 * I need to watch & react to the mouse pointer...
 */

WORD	MouseX,MouseY,MouseDX,MouseDY;

/*
 * Sprite Data
 */

BOOL	GotSprite = FALSE;
BOOL	SprAlive = TRUE;
BOOL	SprDead = FALSE;
double	SprX = SPRINITX;
double	SprY = SPRINITY;
double	SprSpeed = SPRINITSPEED;
double	SprTheta = SPRINITTHETA;
double	Friction = DEFFRICTION;
double	Bounce = DEFBOUNCE;
double	Force = DEFFORCE;

UWORD chip Ball00SprData[] = {
	0x0000,0x0000,
	0x3c0 ,0x400 ,0x7c0 ,0x1930,0xfc0 ,0x3bf8,0x7e4 ,0x7e1c,
	0x3f80,0x47fc,0x2600,0xdffe,0x4e2 ,0xff1e,0x200 ,0xfffe,
	0xf86 ,0xfffe,0xf86 ,0xfefe,0x2784,0x5e7c,0x1300,0x6ffc,
	0x178 ,0x3f80,0xfb0 ,0x1040,0x380 ,0x440 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball01SprData[] = {
	0x0000,0x0000,
	0x3c0 ,0x400 ,0xf80 ,0x1270,0x3f88,0x37f8,0x1ecc,0x7d3c,
	0x7e14,0x1ffc,0xac06,0x5ffe,0x1c4 ,0xfe3e,0x880 ,0xff7e,
	0x1e0e,0xfffe,0x1e0e,0xf9fe,0xe0c ,0x79f8,0x2604,0x5ffc,
	0x2f8 ,0x3f08,0x1f70,0x80  ,0x680 ,0x140 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball02SprData[] = {
	0x0000,0x0000,
	0x780 ,0x40  ,0x1f10,0x4f0 ,0x3e18,0x2ff8,0x3d8c,0x7a78,
	0x7c2c,0x3ff8,0xb00e,0x7ffc,0x271a,0xf8fe,0x1006,0xfffe,
	0x7c3e,0xfffe,0x7c3e,0xf7fe,0x1c1c,0x73e0,0x181c,0x7ff8,
	0x5f0 ,0x3e18,0x1ef0,0x100 ,0x740 ,0x80  ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball03SprData[] = {
	0x0000,0x0000,
	0x780 ,0x40  ,0x1e30,0x9f0 ,0x3d38,0x3ef0,0x7e5c,0x61f4,
	0x781c,0x7fe0,0xe03e,0xfffa,0x8e26,0xf1fe,0x440a,0xfbfe,
	0xf078,0xfffe,0xf07c,0xcffe,0x787c,0x67c0,0x303c,0x7fe0,
	0xae0 ,0x3d38,0x1cf0,0x300 ,0x540 ,0x280 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball04SprData[] = {
	0x0000,0x0000,
	0x740 ,0x80  ,0x1c70,0x13e0,0x3a78,0x3de0,0x6cfc,0x53ec,
	0x617c,0x7fc4,0x807e,0xffe6,0x38d8,0xc7fe,0x30  ,0xfffe,
	0xe1f0,0xfffe,0xe1f8,0x3ffe,0x60e8,0x1f94,0x6078,0x7fc4,
	0x35c8,0x3a70,0x19f0,0x600 ,0x6c0 ,0x100 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball05SprData[] = {
	0x0000,0x0000,
	0x740 ,0x80  ,0x18f0,0x7c0 ,0x35f8,0x3bc0,0x58fc,0x279c,
	0x42fc,0x7f9c,0x1fe ,0xffde,0xf136,0xffe ,0x2054,0xdffe,
	0x83c0,0xfffe,0x83e0,0xfffe,0x41c0,0x3e3c,0x1e0 ,0x7f9c,
	0xa90 ,0x35e8,0x13f0,0xc00 ,0x2c0 ,0x500 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball06SprData[] = {
	0x0000,0x0000,
	0x6c0 ,0x100 ,0x10f0,0xf90 ,0x2bf8,0x3788,0x65fc,0x1f7c,
	0x1fc ,0x7e3c,0x3fe ,0xff3e,0xc6cc,0x3ffe,0x818c,0x7ffe,
	0xf82 ,0xfffe,0xfc2 ,0xfffe,0x7c4 ,0x7c38,0x3c0 ,0x7e3c,
	0x3528,0xbd0 ,0x6f0 ,0x1900,0x580 ,0x240 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball07SprData[] = {
	0x0000,0x0000,
	0x6c0 ,0x100 ,0x1f0 ,0x1f30,0x17f8,0x2e18,0x4ffc,0x3efc,
	0x17f8,0x7c7c,0xff8 ,0xfefe,0x9ba ,0xfffe,0x2a8 ,0xfffe,
	0x1e02,0xfffc,0x1f04,0xfffe,0xe9c ,0x7964,0x784 ,0x7c7c,
	0x2a58,0x17a0,0xce0 ,0x1310,0x5c0 ,0x200 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball08SprData[] = {
	0x0000,0x0000,
	0x580 ,0x240 ,0x3e0 ,0x1f70,0xff0 ,0x3c38,0xff8 ,0x79fc,
	0x2ff0,0x79fc,0x1ff4,0xf9fa,0x3662,0xfffc,0xc66 ,0xfff8,
	0x7c10,0xfffe,0x7e18,0xfffe,0x1c28,0x63dc,0x1e08,0x79fc,
	0x34b0,0xf48 ,0x18c0,0x730 ,0x340 ,0x480 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball09SprData[] = {
	0x0000,0x0000,
	0x580 ,0x240 ,0x7c0 ,0x1ef0,0x1fe0,0x3978,0x5fe0,0x77fc,
	0x1fe4,0x63f8,0x7fc8,0xf7f6,0xcdd0,0xfffe,0x1548,0xfff6,
	0xf010,0xffee,0xf820,0xfffe,0x7c54,0x43b8,0x3c10,0x63fc,
	0x2960,0x1e98,0x1180,0xe70 ,0x380 ,0x440 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball10SprData[] = {
	0x0000,0x0000,
	0x300 ,0x4c0 ,0xf80 ,0x1cf0,0x3fc8,0x32f8,0x7fc0,0x6ffc,
	0x7f8c,0x47f0,0xffa4,0xcfda,0x3310,0xffee,0x6330,0xffce,
	0xe080,0xfffe,0xf0c0,0xfffe,0x69e8,0x1674,0x7864,0x47f8,
	0x33c0,0x3c38,0x310 ,0x1ce0,0x6c0 ,0x100 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball11SprData[] = {
	0x0000,0x0000,
	0x340 ,0x480 ,0x1f10,0x18e0,0x3f98,0x25f0,0x7f84,0x1ffc,
	0x7f1c,0x1fe4,0xfe4c,0x3fb2,0xee80,0xfffe,0xaa40,0xffbe,
	0x8082,0xff7e,0xc102,0xfffe,0x4280,0x3dfc,0x6088,0x1ff4,
	0x780 ,0x3878,0x730 ,0x18c0,0x700 ,0xc0  ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball12SprData[] = {
	0x0000,0x0000,
	0x640 ,0x180 ,0x1e30,0x11c0,0x3f38,0xbe8 ,0x7e0c,0x7ffc,
	0x7e7c,0x3f8c,0xfd2e,0xfed6,0x9884,0xff7e,0x9982,0xfe7e,
	0x406 ,0xfffe,0x606 ,0xfffe,0x4544,0x3bbc,0x4104,0x3ffc,
	0xf00 ,0x30f8,0xe70 ,0x1180,0x580 ,0x240 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball13SprData[] = {
	0x0000,0x0000,
	0x6c0 ,0x100 ,0x1c70,0x390 ,0x3e78,0x17d8,0x7c1c,0x7ff8,
	0x78fc,0x7f1c,0xf26c,0xfd9e,0x7408,0xfffe,0x5200,0xfdfe,
	0x41e ,0xfbfe,0x81e ,0xfff8,0x1e9c,0x6778,0x64c ,0x7fbc,
	0x3e08,0x1f8 ,0x1cf0,0x300 ,0x600 ,0x1c0 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball14SprData[] = {
	0x0000,0x0000,
	0x4c0 ,0x300 ,0x18f0,0x720 ,0x3df8,0xfb8 ,0x7878,0x7ff4,
	0x71f8,0x7e7c,0xe978,0xf6be,0xc426,0xfbf8,0x4c10,0xf3fe,
	0x203c,0xfffe,0x303c,0xfff6,0x2838,0x5fe4,0x898 ,0x7f7c,
	0x1c10,0x23f8,0x18f0,0x700 ,0x340 ,0x480 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball15SprData[] = {
	0x0000,0x0000,
	0x5c0 ,0x200 ,0x10f0,0xf40 ,0x3bf0,0x3f78,0x60f4,0x7fe8,
	0x67f0,0x78fc,0x9360,0xecfe,0x204e,0xfff0,0x1004,0xeffa,
	0xa0f8,0xdffe,0xc0f8,0xffce,0x5470,0x3bcc,0x1060,0x7ffc,
	0x3828,0x7f0 ,0x11e0,0xe10 ,0x440 ,0x380 ,0x0   ,0x0   ,
	0x0000,0x0000 };

UWORD chip Ball16SprData[] = {
	0x0000,0x0000,
	0x1c0 ,0x600 ,0x1e0 ,0x1f90,0x37e8,0x3ff0,0x41f8,0x7f84,
	0xfe0 ,0x71fc,0x4bc0,0xb5fe,0xa138,0xdfc6,0x6088,0x9ff6,
	0x81e0,0x7ffe,0x1e0 ,0xffbe,0x69e0,0x779c,0x64c0,0x7bfc,
	0x3050,0xfe8 ,0x2c0 ,0x1d30,0x6c0 ,0x100 ,0x0   ,0x0   ,
	0x0000,0x0000 };

struct SimpleSprite SprStruct = {
	Ball00SprData, SPRHEIGHT, SPRINITX, SPRINITY, 0 };

UWORD *BallSprTable[] = {
	Ball00SprData, Ball01SprData, Ball02SprData, Ball03SprData,
	Ball04SprData, Ball05SprData, Ball06SprData, Ball07SprData,
	Ball08SprData, Ball09SprData, Ball10SprData, Ball11SprData,
	Ball12SprData, Ball13SprData, Ball14SprData, Ball15SprData,
	Ball16SprData, NULL };

UWORD	**SprTableTop = BallSprTable;
UWORD	**SprTablePtr = BallSprTable;
UWORD	SprFrameCount = 0;

UWORD chip Die00SprData[] = {
  0x0000,0x0000,
  0x3c0 ,0x400 ,0x7c0 ,0x1930,0xfc0 ,0x3bf8,0x7e4 ,0x7e1c,
  0x3f80,0x47fc,0x2600,0xdffe,0x4e2 ,0xff1e,0x200 ,0xfffe,
  0xf86 ,0xfffe,0xf86 ,0xfefe,0x2784,0x5e7c,0x1300,0x6ffc,
  0x178 ,0x3f80,0xfb0 ,0x1040,0x380 ,0x440 ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die01SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x1c0 ,0x200 ,0x3c0 ,0xc30 ,0x7c0 ,0x1df8,
  0x3e4 ,0x3f1c,0x1f80,0x23fc,0x1300,0x6ffe,0x2e2 ,0x7f1e,
  0x786 ,0x7ffe,0x786 ,0x7ffe,0x1384,0x2f7c,0x900 ,0x37fc,
  0x78  ,0x1f80,0x7b0 ,0x840 ,0x180 ,0x240 ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die02SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x1e0 ,0x0   ,0x1e0 ,0x690 ,
  0x3e0 ,0xff8 ,0x1e4 ,0x1f1c,0xfc0 ,0x11fc,0x62  ,0x3f9e,
  0x100 ,0x3ffe,0x3c6 ,0x3ffe,0x3c6 ,0x3f7e,0x580 ,0x1bfc,
  0xb8  ,0xfc0 ,0x3d0 ,0x420 ,0x1c0 ,0x20  ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die03SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x1c0 ,0x200 ,0x3c0 ,0x420 ,
  0x7c0 ,0xdf0 ,0xf80 ,0x13f8,0xb00 ,0x37fc,0x2e4 ,0x3f1c,
  0x78c ,0x3ffc,0x78c ,0x3ffc,0xb88 ,0x1778,0x70  ,0xf80 ,
  0x7a0 ,0x40  ,0x180 ,0x240 ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die04SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0xc0  ,0x100 ,
  0x1c0 ,0x2b0 ,0x3c0 ,0x6f0 ,0x7c0 ,0x9f8 ,0x500 ,0x1bfc,
  0x0   ,0x1ffc,0x3cc ,0x1ffc,0x5c8 ,0xb38 ,0x80  ,0xff8 ,
  0x3f0 ,0x0   ,0xc0  ,0x100 ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die05SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x1c0 ,0x0   ,
  0x1c0 ,0x620 ,0x1c0 ,0xf30 ,0x780 ,0x9f0 ,0xc8  ,0x1f38,
  0x388 ,0x1ff8,0x388 ,0x1ff8,0x500 ,0xbf0 ,0x70  ,0x780 ,
  0x180 ,0x40  ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die06SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x180 ,0x0   ,0x380 ,0x7e0 ,0x780 ,0x1e0 ,0xd0  ,0xf30 ,
  0x390 ,0xff0 ,0x580 ,0x360 ,0x60  ,0x780 ,0x180 ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die07SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x80  ,0x100 ,0x180 ,0x2c0 ,0x300 ,0x5e0 ,
  0x1a0 ,0x7e0 ,0x3a0 ,0x160 ,0x1c0 ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die08SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0xc0  ,0x0   ,0xc0  ,0x1a0 ,
  0x40  ,0x3a0 ,0x80  ,0x3e0 ,0x60  ,0x180 ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die09SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x80  ,
  0x80  ,0x1c0 ,0x80  ,0xc0  ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die10SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x1c0 ,0x0   ,
  0x1c0 ,0x0   ,0x1c0 ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die11SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x1c0 ,0x0   ,0x3e0 ,0x0   ,
  0x3e0 ,0x0   ,0x3e0 ,0x0   ,0x1c0 ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die12SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x80  ,0x0   ,
  0x80  ,0x0   ,0x1c0 ,0x0   ,0x3e0 ,0x0   ,0x7f0 ,0x0   ,
  0x1ffc,0x0   ,0x7f0 ,0x0   ,0x3e0 ,0x0   ,0x1c0 ,0x0   ,
  0x80  ,0x0   ,0x80  ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die13SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x1c0 ,0x0   ,0x3e0 ,0x0   ,
  0x3e0 ,0x0   ,0x3e0 ,0x0   ,0x1c0 ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die14SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x1c0 ,0x0   ,
  0x1c0 ,0x0   ,0x1c0 ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die15SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x80  ,0x0   ,
  0x1c0 ,0x0   ,0x80  ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD chip Die16SprData[] = {
  0x0000,0x0000,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
  0x0000,0x0000 };

UWORD *DieSprTable[] = {
	Die00SprData, Die01SprData, Die02SprData, Die03SprData,
	Die04SprData, Die05SprData, Die06SprData, Die07SprData,
	Die08SprData, Die09SprData, Die10SprData, Die11SprData,
	Die12SprData, Die13SprData, Die14SprData, Die15SprData,
	Die16SprData, NULL };

/************************************************************************
*******************************  MAIN()  ********************************
*************************************************************************/

void main(void)

{
char				*errmsg;
struct IntuiMessage	*imsg;
ULONG				class;
UWORD				code;
APTR				iaddr;
BOOL				done = FALSE;

if (!(errmsg = OpenAll()))
	{
	while (!done)
		{
		if (SprDead)
			Wait(MainISigs);
		else
			{
			WaitTOF();
			MoveBall();
			}

		while (imsg = GT_GetIMsg(MainIPort))
			{
			class = imsg->Class;
			code = imsg->Code;
			iaddr = imsg->IAddress;
			GT_ReplyIMsg(imsg);

			switch(class)
				{
				case IDCMP_GADGETUP:
					HandleGadget((struct Gadget *)iaddr,code);
					break;

				case IDCMP_MENUPICK:
					done = HandleMenu(code);
					break;

				case IDCMP_REFRESHWINDOW:
					GT_BeginRefresh(MainWindow);
					GT_EndRefresh(MainWindow,TRUE);
					break;

				case IDCMP_CLOSEWINDOW:
					done = TRUE;
					break;

				default:
					break;

				} /* endswitch class */
			}	/* endwhile imsg */
		} /* endwhile !done */
	} /* endif OpenAll'd */

CloseAll(errmsg);
}

/************************************************************************
***************************  HANDLEGADGET()  ****************************
*************************************************************************/

void HandleGadget(struct Gadget *gad,UWORD code)

{
switch(gad->GadgetID)
	{
	case GAD_FRICTION:
		Friction = 0.9 + (100 - code)/1000.0;
		break;

	case GAD_BOUNCE:
		Bounce = code/100.0;
		break;

	case GAD_FORCE:
		Force = code/100.0;
		break;

	default:
		break;
	}
}

/************************************************************************
****************************  HANDLEMENU()  *****************************
*************************************************************************/

BOOL HandleMenu(UWORD code)
{
BOOL quit = FALSE;

if (MENUNUM(code) == MENU_PROJECT)
	{
	switch(ITEMNUM(code))
		{
		case ITEM_ABOUT:
			EasyRequestArgs(MainWindow,&EasyAbout,NULL,NULL);
			break;

		case ITEM_NEW:
			DisableNewItem();
			SprDead = FALSE; SprAlive = TRUE;
			SprX = SPRINITX; SprY = SPRINITY;
			SprSpeed = SPRINITSPEED; SprTheta = SPRINITTHETA;
			SprTableTop = SprTablePtr = BallSprTable;
			SprFrameCount = 0;
			break;

		case ITEM_QUIT:
			quit = TRUE;
			break;

		default:
			break;
		}
	}

return(quit);
}

/************************************************************************
***************************  ENABLENEWITEM()  ***************************
*************************************************************************/

#define NEWITEMNUM	SHIFTMENU(MENU_PROJECT)|SHIFTITEM(ITEM_NEW)|SHIFTSUB(NOSUB)

void EnableNewItem(void)

{
struct MenuItem	*mi;

ClearMenuStrip(MainWindow);
mi = ItemAddress(MainMenu,NEWITEMNUM);
mi->Flags |= ITEMENABLED;
ResetMenuStrip(MainWindow,MainMenu);
}

/************************************************************************
**************************  DISABLENEWITEM()  ***************************
*************************************************************************/

void DisableNewItem(void)

{
struct MenuItem	*mi;

ClearMenuStrip(MainWindow);
mi = ItemAddress(MainMenu,NEWITEMNUM);
mi->Flags &= ~ITEMENABLED;
ResetMenuStrip(MainWindow,MainMenu);
}

/************************************************************************
******************************  OPENALL()  ******************************
*************************************************************************
* Open libraries, window, etc. Return error msg on failure, else
* return NULL.
*************************************************************************/

char *OpenAll(void)

{
struct ViewPort	*vp;

if (!(IntuitionBase = (struct IntuitionBase *)
	OpenLibrary("intuition.library",37)))
		return("No Intuition V37 !");

if (!(GfxBase = (struct GfxBase *)
	OpenLibrary("graphics.library",37)))
		return("No Graphics !");

if (!(GadToolsBase = OpenLibrary("gadtools.library",37)))
	return("No GadTools !");

if (!(ScreenLock = LockPubScreen(NULL)))
	return("No default screen !");

if (!(VisualInfo = GetVisualInfoA(ScreenLock,NULL)))
	return("No visual info !");

if (!(MainWindow = OpenWindowTagList(NULL,WindowTags)))
	return("No window !");

MainIPort = MainWindow->UserPort;
MainISigs = 1L<<(MainIPort->mp_SigBit);

if (!CreateGadgetList(MainGadgetProg,VisualInfo))
	return("No gadgets !");

AddGList(MainWindow,MainGList,~0,-1,NULL);
MainGadgetsAdded = TRUE;
RefreshGList(MainGList,MainWindow,NULL,-1);
GT_RefreshWindow(MainWindow,NULL);

if (!(MainMenu = CreateMenus(MainNewMenu,GTMN_FrontPen,0L,TAG_DONE)))
	return("No menus !");

LayoutMenus(MainMenu,VisualInfo,GTMN_TextAttr,&TopazAttr,TAG_DONE);
SetMenuStrip(MainWindow,MainMenu);

if (GetSprite(&SprStruct,SPRNUMBER) < 0)
	return("No sprite !");

GotSprite = TRUE;
ChangeSprite(NULL,&SprStruct,(void *)Ball00SprData);

vp = &ScreenLock->ViewPort;
SetRGB4(vp,21,PEN21RED,PEN21GREEN,PEN21BLUE);
SetRGB4(vp,22,PEN22RED,PEN22GREEN,PEN22BLUE);
SetRGB4(vp,23,PEN23RED,PEN23GREEN,PEN23BLUE);

MouseX = IntuitionBase->MouseX;
MouseY = IntuitionBase->MouseY;

custom.clxcon = 0;

return(NULL);
}

/************************************************************************
*************************  CREATEGADGETLIST()  **************************
*************************************************************************
* Create a list of gadtools gadgets using supplied "GadProgItem" array.
* This is similar to a taglist, but is "interpreted" in sequence.
* Each gadprogitem ID tells the function to perform some particular act
* with the data field. Specifically...
*
* GADPROG_CONTEXT	Create new context with GList ptr pointed to by data.
* GADPROG_LEFT		Set newgadget LeftEdge for next "create" call.
* GADPROG_TOP		Set ng.TopEdge.
* GADPROG_WIDTH		Set ng.Width.
* GADPROG_HEIGHT	Set ng.Height.
* GADPROG_TEXT		Set ng.GadgetText.
* GADPROG_GID		Set ng.GadgetID.
* GADPROG_FLAGS		Set ng.Flags.
* GADPROG_TATTR		Set ng.TextAttr.
* GADPROG_KIND		Set the kind of gadget to create.
* GADPROG_TAGPTR	Set the taglist ptr for the gadget to create.
* GADPROG_CREATE	Call CreateGadgetA and store the result at data.
*
* Values are cached between calls to create, so don't have to be repeated
* for each gadget. A value _must_ be specified for _each_ field, however,
* for the first gadget created by a program. Several sets of gadgets may
* be created by repeated use of GADPROG_CONTEXT.
*
* The routine does all the success checking & will abort & return false
* if a create or context call fails.
*
****************************************************************************/

BOOL CreateGadgetList(struct GadProgItem *pc,APTR vi)

{
struct NewGadget	ng;
struct Gadget		*g = NULL;
struct TagItem		*tagptr = NULL;
ULONG				kind,data;

ng.ng_VisualInfo = vi;

while (pc->gpi_Tag != GADPROG_DONE)
	{
	data = pc->gpi_Data;
	switch (pc->gpi_Tag)
		{
		case GADPROG_CONTEXT:
			g = CreateContext( (struct Gadget **) data);
			if (g == 0) return(FALSE);
			break;

		case GADPROG_LEFT:
			ng.ng_LeftEdge = data;
			break;

		case GADPROG_TOP:
			ng.ng_TopEdge = data;
			break;

		case GADPROG_WIDTH:
			ng.ng_Width = data;
			break;

		case GADPROG_HEIGHT:
			ng.ng_Height = data;
			break;

		case GADPROG_TEXT:
			ng.ng_GadgetText = (UBYTE *) data;
			break;

		case GADPROG_GID:
			ng.ng_GadgetID = data;
			break;

		case GADPROG_FLAGS:
			ng.ng_Flags = data;
			break;

		case GADPROG_TATTR:
			ng.ng_TextAttr = (struct TextAttr *) data;
			break;

		case GADPROG_KIND:
			kind = data;
			break;

		case GADPROG_TAGPTR:
			tagptr = (struct TagItem *) data;
			break;

		case GADPROG_CREATE:
			g = CreateGadgetA(kind,g,&ng,tagptr);
			* ((struct Gadget **) data) = g;
			if (g == 0) return(FALSE);
			break;

		default:
			return(FALSE);

		} /* endswitch tag */

	pc++;							/* next tag item */

	} /* endwhile !GADPROG_DONE */

return(TRUE);
}

/************************************************************************
*****************************  CLOSEALL()  ******************************
*************************************************************************
* Undo whatever OpenAll() did, then exit (displaying the supplied errmsg
* if one was given).
*************************************************************************/

void CloseAll(errmsg)
char	*errmsg;

{
if (GotSprite) FreeSprite(SPRNUMBER);
if (MainMenu)
	{
	ClearMenuStrip(MainWindow);
	FreeMenus(MainMenu);
	}
if (MainGadgetsAdded) RemoveGList(MainWindow,MainGList,-1);
if (MainGList) FreeGadgets(MainGList);
if (MainWindow) CloseWindow(MainWindow);
if (VisualInfo) FreeVisualInfo(VisualInfo);
if (ScreenLock) UnlockPubScreen(NULL,ScreenLock);
if (GadToolsBase) CloseLibrary(GadToolsBase);
if (GfxBase) CloseLibrary( (struct Library *) GfxBase);
if (IntuitionBase) CloseLibrary( (struct Library *) IntuitionBase);

if (errmsg) printf("%s\n",errmsg);

exit(0);
}

/************************************************************************
*****************************  MOVEBALL()  ******************************
*************************************************************************/

void MoveBall(void)
{
double	dx,dy;

MouseDX = IntuitionBase->MouseX - MouseX;
MouseDY = IntuitionBase->MouseY - MouseY;
MouseX = IntuitionBase->MouseX;
MouseY = IntuitionBase->MouseY;

if (SprAlive && (custom.clxdat & SPRCOLLMASK))	/* hit with mouse pointer */
	{
	if ((MouseDX != 0) || (MouseDY !=0 ))
		{
		dx = SprSpeed * cos(SprTheta) + Force * MouseDX;
		dy = - SprSpeed * sin(SprTheta) - Force * MouseDY;
		SprSpeed = sqrt(dx*dx + dy*dy);
		SprTheta = atan2(dy,dx);
		if (SprTheta < 0) SprTheta += PI*2;
		}
	}

if (SprAlive && (SprSpeed > 0))
	{
	SprX += SprSpeed * cos(SprTheta);
	SprY -= SprSpeed * sin(SprTheta);
	SprSpeed *= Friction;

	if (SprX <= 0)							/* hit left hand side of view */
		{
		if (SprTheta <= PI)
			SprTheta = PI - SprTheta;		/* going "up" */
		else
			SprTheta = 3*PI - SprTheta;		/* going "down" */
		SprSpeed *= Bounce;
		SprX = 0;
		}

	if (SprX >= VIEWWIDTH - SPRWIDTH)		/* hit right hand side of view */
		{
		if (SprTheta <= PI/2)
			SprTheta = PI - SprTheta;		/* going "up" */
		else
			SprTheta = 3*PI - SprTheta;		/* going "down" */
		SprSpeed *= Bounce;
		SprX = VIEWWIDTH - SPRWIDTH;
		}

	if (SprY <= 0)							/* hit top side of view */
		{
		if (SprTheta <= PI/2)
			SprTheta = 2*PI - SprTheta;		/* going "right" */
		else
			SprTheta = 2*PI - SprTheta;		/* going "left" */
		SprSpeed *= Bounce;
		SprY = 0;
		}

	if (SprY >= VIEWHEIGHT - SPRHEIGHT)		/* hit bottom side of view */
		{
		if (SprTheta >= 3*PI/2)
			SprTheta = 2*PI - SprTheta;		/* going "right" */
		else
			SprTheta = 2*PI - SprTheta;		/* going "left" */
		SprSpeed *= Bounce;
		SprY = VIEWHEIGHT - SPRHEIGHT;
		}

	MoveSprite(NULL,&SprStruct,(WORD)SprX,(WORD)SprY);
	}

if (SprAlive)
	{
	if ((SprX >= VIEWWIDTH-SPRWIDTH-4) && (SprY <= 4))
		{
		SprAlive = FALSE;
		SprTablePtr = DieSprTable;
		SprTableTop = NULL;
		}
	}

if (SprTablePtr && (++SprFrameCount == SPRFRAMECOUNT))
	{
	SprFrameCount = 0;
	SprTablePtr++;
	if (*SprTablePtr == NULL) SprTablePtr = SprTableTop;
	if (SprTablePtr)
		ChangeSprite(NULL,&SprStruct,(void *)(*SprTablePtr));
	else
		{
		SprDead = TRUE;
		EnableNewItem();
		}
	}
}



// 1. INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#else
    #define ZERO (BPTR) NULL
#endif

#include <proto/exec.h>      // OpenLibrary()
#include <proto/icon.h>      // GetDiskObject()
#include <proto/intuition.h> // Object
#include <proto/graphics.h>
#include <proto/dos.h>
#include <proto/gadtools.h>
#define __NOLIBBASE__
#include <proto/locale.h>    // GetCatalogStr()
#undef __NOLIBBASE__
#define ASL_PRE_V38_NAMES    // OS4 proto/asl.h #includes libraries/asl.h
#include <proto/asl.h>
#include <proto/diskfont.h>
#ifdef __amigaos4__
    #include <proto/application.h>
#endif
#include <clib/alib_protos.h>

#include <exec/exec.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>
#include <utility/tagitem.h>
#include <diskfont/diskfont.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <graphics/gels.h>
#include <libraries/gadtools.h>    // struct NewMenu
#include <dos/dosextens.h>         // struct Process
#include <libraries/asl.h>         // ASL_FileRequest
#include <dos/dostags.h>           // SYS_Output
#define __NOLIBBASE__
#include <libraries/locale.h>
#undef __NOLIBBASE__
#define OLD_GRAPHICS_GFXMACROS_H
#include <graphics/gfxmacros.h>
#ifndef __AROS__
    #include <hardware/custom.h>
    #include <hardware/dmabits.h>
#endif
#ifdef __amigaos4__
    #include <dos/obsolete.h>      // CurrentDir()
    #include <libraries/application.h>
#endif
#include <intuition/gadgetclass.h> // GA_Disabled, etc.

#include <ctype.h>                 // toupper()
#include <stdlib.h>                /* EXIT_SUCCESS, etc. */
#include <stdio.h>
#include <string.h>                // strcpy(), etc.
#include <time.h>
// #define ASSERT
#include <assert.h>

#include "shared.h"
#include "saga.h"
#include "system.h"

#define CATCOMP_NUMBERS
#define CATCOMP_CODE
#define CATCOMP_BLOCK
#include "saga_strings.h"

// 2. DEFINES ------------------------------------------------------------

#define BASICMONSTERS            (27 - 1)
#define BASICTREASURES           ( 4 - 1)
#define ADVANCEDMONSTERS         (32 - 1)
#define ADVANCEDTREASURES        ( 8 - 1)

#define CONFIGVERSION             5 // means V1.91+
#define CONFIGLENGTH             31 // counting from 1 (0..30)
#define SAVELENGTH             (588 + (99 * 6 * 2)) // counting from 1
#define SCOREDISTANCE            13
#define MESSAGEY                483

#define HISTX                    10
#define HISTWIDTH               351 // (40-1)*9
#define HISTHEIGHT              210

#define HERO_STRENGTH             5
#define HERO_MOVES                4

#define ORANGE                    (FIRSTHEROCOLOUR    )
#define RED                       (FIRSTHEROCOLOUR + 1)
#define BLUE                      (FIRSTHEROCOLOUR + 4)

MODULE const STRPTR trueheroname[HEROES + 1] =
{   "Beowulf",
    "Brunhild",
    "Egil",
    "Ragnar",
    "Siegfried",
    "Starkad"
}, cycleheroname[HEROES + 1] =
{   "Beowulf:",
    "Brunhild:",
    "Egil:",
    "Ragnar:",
    "Siegfried:",
    "Starkad:"
};
MODULE const int cycleheropos[HEROES + 1] =
{   0, // Beowulf
    2, // brUnhild
    0, // Egil
    0, // Ragnar
    0, // Siegfried
    1  // sTarkad
};

#define MN_PROJECT           0
#define MN_SETTINGS          1
#define MN_HELP              2

#define IN_NEW               0
#define IN_OPEN              1
// ---                       2
#define IN_SAVE              3
#define IN_SAVEAS            4
// ---                       5
#define IN_QUITTITLE         6
#define IN_QUITDOS           7

#define IN_SHOW_TITLEBAR     0
// ---                       1
#define IN_WATCH_AMIGA       2

#define IN_GAME_SUMMARY      0
// ---                       1
#define IN_HELP_1            2
#define IN_HELP_2            3
#define IN_HELP_3            4
#define IN_HELP_4            5
// ---                       6
#define IN_MANUAL            7
// ---                       8
#define IN_ABOUT             9

#define INDEX_PROJECT        0
#define INDEX_NEW            1
#define INDEX_OPEN           2
// ---                       3
#define INDEX_SAVE           4
#define INDEX_SAVE_AS        5
// ---                       6
#define INDEX_QUITTITLE      7
#define INDEX_QUITDOS        8
#define INDEX_SETTINGS       9
#define INDEX_SHOW_TITLEBAR 10
// ---                      11
#define INDEX_WATCH_AMIGA   12
#define INDEX_HELP          13
#define INDEX_GAME_SUMMARY  14
// ---                      15
#define INDEX_HELP_1        16
#define INDEX_HELP_2        17
#define INDEX_HELP_3        18
#define INDEX_HELP_4        19
// ---                      20
#define INDEX_MANUAL        21
// ---                      22
#define INDEX_ABOUT         23

#define SUMMARYWIDTH       470
#define SUMMARYHEIGHT       32 // +10 per extra line (heading is already factored in)

#define MAXXSIZE          1280
#define MAXYSIZE          1024

#define ARGPOS_FIRSTHERO     0 // heroes are 0..5
#define ARGPOS_SCREENMODE    6
#define ARGPOS_PUBSCREEN     7
#define ARGPOS_FILE          8
#define ARGS                 9

// 3. EXPORTED VARIABLES -------------------------------------------------

// We use asl, diskfont, dos, exec, gadtools, graphics, intuition, locale.

EXPORT SBYTE                 NewPri                     = 0;
EXPORT UBYTE                 remapit[128];
EXPORT STRPTR                monstertypes[9];
EXPORT SLONG                 countertype,
                             faxirides,
                             monsters,
                             treasures,
                             turn,
                             turns                      = TURNS;
EXPORT ULONG                 AppLibSignal               = 0,
                             DisplayID                  = HIRES_KEY | PAL_MONITOR_ID | LACE,
                             DisplayWidth               = SCREENXPIXEL,
                             DisplayHeight              = SCREENYPIXEL,
                             WindowWidth                = SCREENXPIXEL,
                             WindowHeight               = SCREENYPIXEL,
                             MainSignal;
EXPORT int                   fontx                      = 8,
                             fonty                      = 8,
                             xoffset,
                             yoffset;
EXPORT WORD                  AboutXPos                  = (SCREENXPIXEL / 2) - (ABOUTXPIXEL / 2),
                             AboutYPos                  = (SCREENYPIXEL / 2) - (ABOUTYPIXEL / 2);
EXPORT UWORD                 DisplayDepth               = DEPTH;
EXPORT TEXT                  label[17 + 1][40 + 1],
                             line[2][MAXLINES + 1][80 + 1],
                             numberstring[13 + 1],
                             onekey[ONEKEYS + 1]        = {'Y', 'N', 'W', 'R', 'T', 'G', 'L'},
                             pathname[MAX_PATH + 1],
                             saystring[256 + 1],
                             saystring2[256 + 1],
                             screenname[MAXPUBSCREENNAME] = "";
EXPORT FLAG                  advanced                   = TRUE,
                             customscreen               = TRUE,
                             urlopen                    = FALSE,
                             watchamiga                 = TRUE;
EXPORT struct Window        *MainWindowPtr              = NULL,
                            *InfoWindowPtr              = NULL;
EXPORT struct Catalog       *CatalogPtr                 = NULL,
                            *StdCatalogPtr              = NULL;
EXPORT struct Process*       ProcessPtr                 = NULL;
EXPORT struct Screen*        ScreenPtr                  = NULL;
EXPORT struct TextFont*      FontPtr                    = NULL;
EXPORT struct VisualInfo*    VisualInfoPtr              = NULL;
EXPORT struct RastPort       OffScreenRastPort;
EXPORT struct Library       *AmigaGuideBase             = NULL,
                            *AslBase                    = NULL,
                            *DiskfontBase               = NULL,
                            *GadToolsBase               = NULL,
                            *IconBase                   = NULL,
                            *LocaleBase                 = NULL,
                            *OpenURLBase                = NULL;

#ifdef __amigaos4__
EXPORT struct Library             *ApplicationBase      = NULL,
                                  *GfxBase              = NULL,
                                  *IntuitionBase        = NULL;
EXPORT struct ApplicationIFace*    IApplication         = NULL;
EXPORT struct IntuitionIFace*      IIntuition           = NULL;
EXPORT struct IconIFace*           IIcon                = NULL;
EXPORT struct AmigaGuideIFace*     IAmigaGuide          = NULL;
EXPORT struct OpenURLIFace*        IOpenURL             = NULL;
EXPORT struct GadToolsIFace*       IGadTools            = NULL;
EXPORT struct DiskfontIFace*       IDiskfont            = NULL;
EXPORT struct AslIFace*            IAsl                 = NULL;
EXPORT struct GraphicsIFace*       IGraphics            = NULL;
EXPORT struct LocaleIFace*         ILocale              = NULL;
EXPORT ULONG                       AppID                = 0; // not NULL!
#endif

// this is required as GCC optimizes out any if (0) statement;
// as a result the version embedding was not working correctly.
USED const STRPTR verstag = VERSIONSTRING;

EXPORT struct TextAttr Topaz8 =
{   "topaz.font", // ta_Name (case-sensitive)
    8,            // ta_YSize
    FS_NORMAL,    // ta_Style
    FPF_ROMFONT   // ta_Flags
};

// 4. IMPORTED VARIABLES -------------------------------------------------

#ifndef __amigaos4__
    IMPORT struct ExecBase*  SysBase;
#endif

IMPORT struct Custom         custom;
IMPORT struct WorldStruct    world[36 + 30];
IMPORT struct RuneStruct     rune[RUNES + 1];
IMPORT struct TreasureStruct treasure[TREASURES + 1];
IMPORT struct HeroStruct     hero[HEROES + 1];
IMPORT struct JarlStruct     jarl[JARLS + 1];
IMPORT struct SordStruct     sord[SORDS + 1];
IMPORT struct MonsterStruct  monster[MONSTERS + 1];

// 5. MODULE VARIABLES ---------------------------------------------------

MODULE STRPTR                CycleOptions[4];
MODULE WORD                  speed                      = 1;
MODULE UBYTE                 lowercolour                = WHITE,
                             uppercolour                = WHITE,
                             IOBuffer[1800];
MODULE APTR                  OldWindowPtr               /* = NULL  */ ;
MODULE SLONG                 hint1len,
                             tickspeed[7 + 1]           = {0, 2, 4, 8, 12, 16, 20, -1};
MODULE FLAG                  allwithdrawn,
                             cliload                    /* = FALSE */ ,
                             gameaborted,
                             gotpen[128],
                             loaded,
                             morphos                    = FALSE,
                             saveconfig                 /* = FALSE */ ,
                             screenmode                 = FALSE,
                             titlebar                   = TRUE;
MODULE TEXT                  MainTitle[80 + 1],
                             thehint[  40 + 1]          = "",
                             oldupper[ 80 + 1]          = "",
                             oldlower[160 + 1]          = "";
MODULE int                   ignore                     = 0,
                             maxlen;
MODULE UWORD                *AboutData                  = NULL,
                            *BkgrndData                 = NULL,
                            *InnerCornerData[4],
                            *LogoData                   = NULL,
                            *OuterCornerData[4],
                            *MapData                    = NULL;
MODULE struct LocaleInfo     li;
MODULE struct RDArgs*        ArgsPtr                    /* = NULL  */ ;
MODULE struct FileRequester* ASLRqPtr                   /* = NULL  */ ;
MODULE struct Menu*          MenuPtr                    /* = NULL  */ ;
MODULE struct Gadget        *SpeedGadgetPtr             /* = NULL  */ ,
                            *TurnsGadgetPtr             /* = NULL  */ ,
                            *CycleGadgetPtr[HEROES + 1] /* = {NULL, NULL, NULL, NULL, NULL, NULL} */ ,
                            *AdvancedGadgetPtr          /* = NULL  */ ,
                            *StartGadgetPtr             /* = NULL  */ ,
                            *GListPtr                   /* = NULL  */ ,
                            *PrevGadgetPtr              /* = NULL  */ ;
MODULE struct BitMap*        OffScreenBitMapPtr         = NULL;
MODULE struct WBArg*         WBArg                      = NULL;
MODULE struct WBStartup*     WBMsg                      = NULL;

// 6. MODULE STRUCTURES --------------------------------------------------

EXPORT       UWORD *CounterData[COUNTERIMAGES],
                   *SelectedCounterData[SELCOUNTERIMAGES];

IMPORT       UWORD  OriginalCounterData[COUNTERIMAGES][48],
                    OriginalMapData[MAPSIZE];

EXPORT struct Image About =
{   0, 0,
    44, 38, 8,
    NULL,
    0xff, 0x0,
    NULL
}, Counter =
{   0, 0,
    24, 24, 8,
    NULL,
    0xFF, 0,
    NULL
}, MapImage =
{   0, 0,
    623, 467, 8,
    NULL,
    0xff, 0x0,
    NULL
};

MODULE struct Image Bkgrnd =
{   0, 0,
    58, 58, 8,
    NULL,
    0xFF, 0x00,
    NULL
}, Corner =
{   0, 0,
    9, 9, 8,
    NULL,
    0xff, 0x0,
    NULL
}, Logo =
{   0, 0,
    212, 74, 8,
    NULL,
    0xff, 0x0,
    NULL
};

MODULE struct
{   ULONG red, green, blue;
} taxcolours[10 + 1] =
{   {  0,  5,  0 }, // tax  0 (unused)
    {  1,  6,  1 }, // tax  1 (unused)
    {  2,  7,  2 }, // tax  2
    {  3,  8,  3 }, // tax  3
    {  4,  9,  4 }, // tax  4
    {  5, 10,  5 }, // tax  5
    {  6, 11,  6 }, // tax  6
    {  7, 12,  7 }, // tax  7
    {  8, 13,  8 }, // tax  8
    {  9, 14,  9 }, // tax  9
    { 10, 15, 10 }  // tax 10
};

#define MENUENTRIES 24 // counting from 0
MODULE struct NewMenu NewMenu[MENUENTRIES + 1] =
{   { NM_TITLE, "",           0 , 0,                    0, 0}, //  0 (project)
    {  NM_ITEM, "",          "" , 0,                    0, 0}, //  1 (new)
    {  NM_ITEM, "",          "" , 0,                    0, 0}, //  2 (open)
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //  3 (------------)
    {  NM_ITEM, "",          "" , 0,                    0, 0}, //  4 (save)
    {  NM_ITEM, "",          "" , 0,                    0, 0}, //  5 (save as)
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, //  6 (------------)
    {  NM_ITEM, "",           0 , 0,                    0, 0}, //  7 (quit to title screen)
    {  NM_ITEM, "",          "" , 0,                    0, 0}, //  8 (quit saga)
    { NM_TITLE, "",           0 , 0,                    0, 0}, //  9 (settings)
    {  NM_ITEM, "",          "" , CHECKIT | MENUTOGGLE, 0, 0}, // 10 (show titlebar?)
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, // 11 (-------------)
    {  NM_ITEM, "",          "" , CHECKIT | MENUTOGGLE, 0, 0}, // 12 (watch amiga movements?)
    { NM_TITLE, "",           0 , 0,                    0, 0}, // 13 (help)
    {  NM_ITEM, "",          "" , 0,                    0, 0}, // 14 (game summary)
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, // 15 (------------)
    {  NM_ITEM, "",          "1", 0,                    0, 0}, // 16 (help 1)
    {  NM_ITEM, "",          "2", 0,                    0, 0}, // 17 (help 2)
    {  NM_ITEM, "",          "3", 0,                    0, 0}, // 18 (help 3)
    {  NM_ITEM, "",          "4", 0,                    0, 0}, // 19 (help 4)
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, // 20 (------------)
    {  NM_ITEM, "",           0 , NM_ITEMDISABLED,      0, 0}, // 21 (manual)
    {  NM_ITEM, NM_BARLABEL,  0 , 0,                    0, 0}, // 22 (------------)
    {  NM_ITEM, "",          "?", 0,                    0, 0}, // 23 (about)
    {   NM_END, NULL,         0 , 0,                    0, 0}  // 24
};

// These are better to not be allocated on the stack
MODULE ULONG table1[] = {(13 << 16) + 0,
    0x00000000, 0x00000000, 0x00000000, //   0 (BLACK)
    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, //   1 (WHITE)
    0xCCCCCCCC, 0xCCCCCCCC, 0xCCCCCCCC, //   2 (LIGHTGREY)
    0x99999999, 0x99999999, 0x99999999, //   3 (MEDIUMGREY)
    0x66666666, 0x66666666, 0x66666666, //   4 (DARKGREY)
    0x66666666, 0xFFFFFFFF, 0x66666666, //   5 (GREEN)
    0xFFFFFFFF, 0xCCCCCCCC, 0x66666666, //   6 (Beowulf   - orange)
    0xFFFFFFFF, 0x66666666, 0x66666666, //   7 (Brunhild  - red)
    0xFFFFFFFF, 0xFFFFFFFF, 0x33333333, //   8 (Egil      - yellow)
    0x66666666, 0xFFFFFFFF, 0xFFFFFFFF, //   9 (Ragnar    - cyan)
    0x99999999, 0x99999999, 0xFFFFFFFF, //  10 (Siegfried - blue)
    0xFFFFFFFF, 0x66666666, 0xFFFFFFFF, //  11 (Starkad   - purple)
    0x00000000, 0x00000000, 0x99999999, //  12 (COLOUR_SEA)
// 13..16 are spare
// 17..19 are reserved for mouse pointer colours
    0};
MODULE ULONG table2[] = {(8 << 16) + 20,
    0x99999999, 0x99999999, 0xFFFFFFFF, //  20 (blue hero counter)
    0xDDDDDDDD, 0xDDDDDDDD, 0xFFFFFFFF, //  21 (light blue highlighted hero counter)
    0x99999999, 0xFFFFFFFF, 0x99999999, //  22 (green jarl counter)
    0xCCCCCCCC, 0xFFFFFFFF, 0xCCCCCCCC, //  23 (light green highlighted jarl counter)
    0xFFFFFFFF, 0xCCCCCCCC, 0x99999999, //  24 (orange monster counter)
    0xFFFFFFFF, 0xDDDDDDDD, 0xCCCCCCCC, //  25 (light orange highlighted monster counter)
    0xFFFFFFFF, 0x99999999, 0xFFFFFFFF, //  26 (purple sword counter)
    0xFFFFFFFF, 0xFFFFFFFF, 0x99999999, //  27 (yellow treasure counter)
    0};
// 26.. 31 are spare
// 32.. 67 are lands 0..35
// On map:
//  68.. 97 are seas 0..29
//  98..103 are coastlines etc.
// In game:
//  68.. 84 are spare
MODULE ULONG table3[] = {(29 << 16) + 85,
    0x44444444, 0x44444444, 0x44444444, //  85 bkgrnd start
    0xAAAAAAAA, 0xAAAAAAAA, 0xAAAAAAAA, //  86
    0x66666666, 0x66666666, 0x66666666, //  87 same as DARKGREY
    0x77777777, 0x77777777, 0x77777777, //  88
    0x88888888, 0x88888888, 0x88888888, //  89
    0x99999999, 0x99999999, 0x99999999, //  90 same as MEDIUMGREY
    0x55555555, 0x55555555, 0x55555555, //  91
    0xBBBBBBBB, 0xBBBBBBBB, 0xBBBBBBBB, //  92 bkgrnd end
    0x00000000, 0x00000000, 0xFFFFFFFF, //  93 logo start
    0x10101010, 0x14141414, 0xFFFFFFFF, //  94
    0x1F1F1F1F, 0x23232323, 0xFFFFFFFF, //  95
    0x2E2E2E2E, 0x32323232, 0xFFFFFFFF, //  96
    0x3D3D3D3D, 0x41414141, 0xFFFFFFFF, //  97
    0x4C4C4C4C, 0x4F4F4F4F, 0xFFFFFFFF, //  98
    0x5B5B5B5B, 0x5E5E5E5E, 0xFFFFFFFF, //  99
    0x6A6A6A6A, 0x6D6D6D6D, 0xFFFFFFFF, // 100
    0x79797979, 0x7C7C7C7C, 0xFFFFFFFF, // 101
    0x87878787, 0x89898989, 0xFFFFFFFF, // 102
    0x96969696, 0x98989898, 0xFFFFFFFF, // 103
    0xA5A5A5A5, 0xA7A7A7A7, 0xFFFFFFFF, // 104
    0xB4B4B4B4, 0xB6B6B6B6, 0xFFFFFFFF, // 105
    0xC3C3C3C3, 0xC4C4C4C4, 0xFFFFFFFF, // 106
    0xD2D2D2D2, 0xD3D3D3D3, 0xFFFFFFFF, // 107
    0xE1E1E1E1, 0xE2E2E2E2, 0xFFFFFFFF, // 108
    0xF0F0F0F0, 0xF1F1F1F1, 0xFFFFFFFF, // 109 logo end
// In logo: 110 is white (becomes WHITE)
// Custom screen only:
    0x99999999, 0x99999999, 0x99999999, // 110 border
    0xBBBBBBBB, 0xBBBBBBBB, 0xBBBBBBBB, // 111 border
    0xDDDDDDDD, 0xDDDDDDDD, 0xDDDDDDDD, // 112 border
    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, // 113 border
    0};

MODULE struct NewGadget SpeedGadget =
{   0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, TurnsGadget =
{   0, 0,
    128, 13,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, AdvancedGadget =
{   0, 0,
    0, 0,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, StartGadget =
{   0, 0,
    320, 39,
    (STRPTR) "",
    NULL,
    0,
    0,
    NULL,
    NULL
}, CycleGadget[HEROES + 1] =
{ { 0, 0,
    128, 13,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL
  },
  { 0, 0,
    128, 13,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL
  },
  { 0, 0,
    128, 13,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL
  },
  { 0, 0,
    128, 13,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL
  },
  { 0, 0,
    128, 13,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL
  },
  { 0, 0,
    128, 13,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL
} };

MODULE struct
{   ULONG red, green, blue;
} herocolour[HEROES + 1] =
{ { 15,  12,   6}, // orange
  { 15,   6,   6}, // red
  { 15,  15,   3}, // yellow
  {  6,  15,  15}, // cyan
  { 10,  10,  15}, // light blue
  { 15,   6,  15}  // purple
};

// 7. MODULE FUNCTIONS ---------------------------------------------------

MODULE void gameloop(void);
MODULE void newgame(void);
MODULE void titlescreen(void);
EXPORT FLAG loadgame(FLAG aslwindow);
MODULE void savegame(FLAG saveas, FLAG autosaving);
MODULE SLONG getcountry(WORD mousex, WORD mousey);
MODULE void infowindow(SLONG whichcounter);
MODULE void summarywindow(void);
MODULE void cycle(SLONG whichhero, UWORD qual);
MODULE void docwindow(SLONG number);
MODULE void infoloop(void);
MODULE void changespeed(void);
MODULE void changeturns(void);
MODULE void resay(void);
MODULE FLAG playersactive(void);
MODULE void titlescreen_loop(void);
MODULE void parsewb(void);

// 8. CODE ---------------------------------------------------------------

#ifdef LATTICE
    int  CXBRK(void)    { return 0; } /* Disable SAS/C Ctrl-C handling */
    void chkabort(void) { ;         } /* really */
#endif

int main(int argc, char** argv)
{   int             i,
                    len1, len2;
    BPTR            FileHandle /* = ZERO */ ,
                    OldDir;
    FLAG            ok;
    TEXT            tempstring[1 + 1];
    SLONG           whichcountry, whichhero,
                    args[ARGS + 1];
    ULONG           memflags      = MEMF_CLEAR;
    UWORD           Pens[46] =
    {   BLACK,     /* DETAILPEN            text in title bar */
        WHITE,     /* BLOCKPEN             fill title bar */
        BLACK,     /* TEXTPEN              regular text on BACKGROUNDPEN */
        LIGHTGREY, /* SHINEPEN             bright edge */
        DARKGREY,  /* SHADOWPEN            dark edge */
        BLUE,      /* FILLPEN              filling active window borders
                                           and selected gadgets */
        BLACK,     /* FILLTEXTPEN          text rendered over FILLPEN */
        MEDIUMGREY,/* BACKGROUNDPEN        background colour */
        ORANGE,    /* HIGHLIGHTTEXTPEN     highlighted text on BACKGROUNDPEN
                                           and used against BLOCKPEN in ASL
                                           save requesters */
        BLACK,     /* BARDETAILPEN         text/detail in screen-bar/menus */
        WHITE,     /* BARBLOCKPEN          screen-bar/menus fill */
        BLACK,     /* BARTRIMPEN           trim under screen-bar */
                   /* and used against BLOCKPEN in ASL save requesters */
// for OS4.x only...
        WHITE,     /* BARCONTOURPEN         contour above screen-bar */
        MEDIUMGREY,/* FOREGROUNDPEN         inside of unselected gadgets */
        LIGHTGREY, /* FORESHINEPEN          bright edges of unselected gadgets */
        DARKGREY,  /* FORESHADOWPEN         dark edges of unselected gadgets */
        LIGHTGREY, /* FILLSHINEPEN          bright edges for FILLPEN */
        DARKGREY,  /* FILLSHADOWPEN         dark edges for FILLPEN */
        MEDIUMGREY,/* INACTIVEFILLPEN       inactive window borders fill */
        LIGHTGREY, /* INACTIVEFILLTEXTPEN   text over INACTIVEFILLPEN           */
        DARKGREY,  /* INACTIVEFILLSHINEPEN  bright edges for INACTIVEFILLPEN    */
        MEDIUMGREY,/* INACTIVEFILLSHADOWPEN dark edges for INACTIVEFILLPEN      */
        MEDIUMGREY,/* DISABLEDPEN           background of disabled elements     */
        LIGHTGREY, /* DISABLEDTEXTPEN       text of disabled string gadgets     */
        LIGHTGREY, /* DISABLEDSHINEPEN      bright edges of disabled elements   */
        DARKGREY,  /* DISABLEDSHADOWPEN     dark edges of disabled elements     */
        MEDIUMGREY,/* MENUBACKGROUNDPEN     background of menus                 */
        BLACK,     /* MENUTEXTPEN           normal text in menus                */
        LIGHTGREY, /* MENUSHINEPEN          bright edges of menus               */
        DARKGREY,  /* MENUSHADOWPEN         dark edges of menus                 */
        BLUE,      /* SELECTPEN             background of selected items        */
        WHITE,     /* SELECTTEXTPEN         text of selected items              */
        LIGHTGREY, /* SELECTSHINEPEN        bright edges of selected items      */
        DARKGREY,  /* SELECTSHADOWPEN       dark edges of selected items        */
        WHITE,     /* GLYPHPEN              system gadget glyphs, outlines      */
        BLUE,      /* GLYPHFILLPEN          system gadget glyphs, colored areas */
        MEDIUMGREY,/* INACTIVEGLYPHPEN      system gadget glyphs, inact. windows*/
        0,         /* RESERVEDPEN           reserved - don't use                */
        BLACK,     /* GADGETPEN             gadget symbols (arrows, cycle, etc.)*/
        WHITE,     /* TITLEPEN              title of gadget groups              */
        LIGHTGREY, /* HALFSHINEPEN          half-bright edge on 3D objects      */
        DARKGREY,  /* HALFSHADOWPEN         half-dark edge on 3D objects        */
        MEDIUMGREY,/* FLATBORDERPEN         flat (non-3D) borders and frames    */
        BLUE,      /* FILLFLATPEN           flat outlines of active windows     */
        MEDIUMGREY,/* INACTIVEFILLFLATPEN   flat outlines of inactive windows   */
        (UWORD) ~0
    };

/* Colour allocations are as follows:
     0..  6: used by the game itself
     7:      spare (though used by map)
     8.. 10: spare
    11.. 16: 6 hero colours
    17.. 19: reserved for mouse pointer colours
    20.. 27: counter colours
    28.. 31: spare
    32.. 67: countries 0..35
    68.. 97: seas 0..29 (map only)
    98..103: coastlines etc. (map only)
    74..79: used for the Amigan Software logo
    80..85: spare
    86..88: spare
    92:     spare (although used by about: becomes 93)
    colours 93-110 are used for the Saga logo.
    colours 111-113 are used for the Amigan Software logo.
    121:    spare (although used by about: becomes 0)

    Start of program.

    before the first possible point of failure */

    init_counters();
    for (whichcountry = 0; whichcountry <= 65; whichcountry++)
    {   world[whichcountry].hero = -1;
    }
    pathname[0] = EOS;
    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   hero[whichhero].score[0] = 0;
    }
    for (i = 0; i <= ARGS; i++)
    {   args[i] = 0;
    }
    for (i = 0; i < 4; i++)
    {   InnerCornerData[i] =
        OuterCornerData[i] = NULL;
    }
    for (i = 0; i < COUNTERIMAGES; i++)
    {   CounterData[i] = NULL;
    }
    for (i = 0; i < SELCOUNTERIMAGES; i++)
    {   SelectedCounterData[i] = NULL;
    }
    for (i = 0; i < 128; i++)
    {   gotpen[i] = FALSE;
    }

#ifdef __amigaos4__
    if (!(IntuitionBase = (struct Library*) OpenLibrary("intuition.library", OS_30)))
    {   Printf("Saga: Can't open intuition.library V39+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(GfxBase = (struct Library*) OpenLibrary("graphics.library", OS_30)))
    {   Printf("Saga: Can't open graphics.library V39+!\n");
        cleanexit(EXIT_FAILURE);
    }
#else
    if (!(IntuitionBase = (struct IntuitionBase*) OpenLibrary("intuition.library", OS_30)))
    {   Printf("Saga: Can't open intuition.library V39+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(GfxBase = (struct GfxBase*) OpenLibrary("graphics.library", OS_30)))
    {   Printf("Saga: Can't open graphics.library V39+!\n");
        cleanexit(EXIT_FAILURE);
    }
#endif
    if (!(AslBase = (struct Library*) OpenLibrary("asl.library", OS_21)))
    {   Printf("Saga: Can't open asl.library V38+!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(DiskfontBase = (struct Library*) OpenLibrary("diskfont.library", OS_ANY))) // maybe we need a higher version?
    {   Printf("Saga: Can't open diskfont.library!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(GadToolsBase = (struct Library*) OpenLibrary("gadtools.library", OS_ANY)))
    {   Printf("Saga: Can't open gadtools.library!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IconBase = (struct Library*) OpenLibrary("icon.library", OS_ANY)))
    {   Printf("Saga: Can't open icon.library!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(LocaleBase   = (struct Library*) OpenLibrary("locale.library",   OS_ANY)))
    {   Printf("Saga: Can't open locale.library!\n");
        cleanexit(EXIT_FAILURE);
    }
    AmigaGuideBase = (struct Library*) OpenLibrary("amigaguide.library", OS_ANY);

#ifdef __amigaos4__
    if (!(IIntuition = (struct IntuitionIFace*) GetInterface((struct Library*) IntuitionBase, "main", 1, NULL)))
    {   Printf("Saga: Can't get intuition.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IGraphics  = (struct GraphicsIFace* ) GetInterface((struct Library*) GfxBase,       "main", 1, NULL)))
    {   Printf("Saga: Can't get graphics.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IAsl       = (struct AslIFace*      ) GetInterface((struct Library*) AslBase,       "main", 1, NULL)))
    {   Printf("Saga: Can't get asl.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IDiskfont  = (struct DiskfontIFace* ) GetInterface((struct Library*) DiskfontBase,  "main", 1, NULL)))
    {   Printf("Saga: Can't get diskfont.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IAmigaGuide = (struct AmigaGuideIFace*) GetInterface((struct Library*) AmigaGuideBase, "main", 1, NULL)))
    {   Printf("Saga: Can't get amigaguide.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IGadTools   = (struct GadToolsIFace*  ) GetInterface((struct Library*) GadToolsBase,   "main", 1, NULL)))
    {   Printf("Saga: Can't get gadtools.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(IIcon       = (struct IconIFace*      ) GetInterface((struct Library*) IconBase,       "main", 1, NULL)))
    {   Printf("Saga: Can't get icon.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
    if (!(ILocale     = (struct LocaleIFace*    ) GetInterface((struct Library*) LocaleBase,     "main", 1, NULL)))
    {   Printf("Saga: Can't get locale.library interface!\n");
        cleanexit(EXIT_FAILURE);
    }
#endif

    if
    (   execver                            < OS_20
#ifdef __amigaos4__
     || IntuitionBase->lib_Version         < OS_30
     ||       GfxBase->lib_Version         < OS_30
#else
     || IntuitionBase->LibNode.lib_Version < OS_30
     ||       GfxBase->LibNode.lib_Version < OS_30
#endif
     ||       AslBase->lib_Version         < OS_21
    )
    {   strcpy(saystring, "Saga: Need OS3.0+!\n");
        DISCARD Write(Output(), saystring, (LONG) strlen(saystring));
        cleanexit(EXIT_FAILURE);
    }

    if (FindResident("MorphOS"))
    {   morphos = TRUE;
    }
    if
    (   !morphos
     && (    execver >  53
         || (execver == 53 && execrev >= 12)
    )   ) // if (OS4.1.1) or later
    {   urlopen = TRUE;
    } else
    {   if ((OpenURLBase = (struct Library*) OpenLibrary("openurl.library", OS_ANY)))
        {   ;
#ifdef __amigaos4__
            if (!(IOpenURL    = (struct OpenURLIFace*   ) GetInterface((struct Library*) OpenURLBase,    "main", 1, NULL)))
            {   Printf("Saga: Can't get openurl.library interface!\n");
                cleanexit(EXIT_FAILURE);
            }
#endif
    }   }

    if (morphos)
    {   Topaz8.ta_Flags = FPF_DISKFONT;
    }
    if (DiskfontBase)
    {   FontPtr = (struct TextFont*) OpenDiskFont(&Topaz8);
    }

    ProcessPtr = (struct Process*) FindTask(NULL);

    /* NOTE FOR TRANSLATORS:
    MSG_CHAR_FOO messages are single-character strings which are the
    first letter of the relevant word. MSG_UNCHAR_FOO messages are the
    rest of the word. Eg. in English, MSG_CHAR_GLORY is "G" and
    MSG_UNCHAR_GLORY is "lory". They must each be different among their
    'set' (yes/no, glory/luck, restart/transfer/withdraw). */

    li.li_Catalog = NULL;
    if (LocaleBase)
    {   li.li_LocaleBase   = LocaleBase;
        li.li_Catalog      =
        CatalogPtr         = OpenCatalog(NULL, "Saga.catalog"   , TAG_DONE);
        StdCatalogPtr      = OpenCatalog(NULL, "generic.catalog", TAG_DONE);
    }
    strcpy(tempstring, (STRPTR) LLL(MSG_CHAR_YES,      "Y"));
    onekey[ONEKEY_YES]      = tempstring[0];
    strcpy(tempstring, (STRPTR) LLL(MSG_CHAR_NO,       "N"));
    onekey[ONEKEY_NO]       = tempstring[0];
    strcpy(tempstring, (STRPTR) LLL(MSG_CHAR_WITHDRAW, "W"));
    onekey[ONEKEY_WITHDRAW] = tempstring[0];
    strcpy(tempstring, (STRPTR) LLL(MSG_CHAR_RESTART,  "R"));
    onekey[ONEKEY_RESTART]  = tempstring[0];
    strcpy(tempstring, (STRPTR) LLL(MSG_CHAR_TRANSFER, "T"));
    onekey[ONEKEY_TRANSFER] = tempstring[0];
    strcpy(tempstring, (STRPTR) LLL(MSG_CHAR_GLORY,    "G"));
    onekey[ONEKEY_GLORY]    = tempstring[0];
    strcpy(tempstring, (STRPTR) LLL(MSG_CHAR_LUCK,     "L"));
    onekey[ONEKEY_LUCK]     = tempstring[0];
    CycleOptions[0]              = (STRPTR) LLL(MSG_GADGET_NONE,       "None");
    CycleOptions[1]              = (STRPTR) LLL(MSG_HUMAN,             "Human");
    CycleOptions[2]              = "Amiga";
    CycleOptions[3]              = NULL;
    StartGadget.ng_GadgetText    = (STRPTR) LLL(MSG_RETURN_START_GAME, "Start Game (ENTER/Spacebar)");

    monstertypes[0] =     (STRPTR) LLL(MSG_DRAGON       , "Dragon");
    monstertypes[1] =     (STRPTR) LLL(MSG_DROW         , "Drow");
    monstertypes[2] =     (STRPTR) LLL(MSG_GIANT        , "Giant");
    monstertypes[3] =     (STRPTR) LLL(MSG_GHOST        , "Ghost");
    monstertypes[4] =     (STRPTR) LLL(MSG_TROLL        , "Troll");
    monstertypes[5] =     (STRPTR) LLL(MSG_WITCH        , "Witch");
    monstertypes[6] =     (STRPTR) LLL(MSG_HYDRA        , "Hydra");
    monstertypes[7] =     (STRPTR) LLL(MSG_SEA_SERPENT  , "Sea Serpent");
    monstertypes[8] =     (STRPTR) LLL(MSG_KRAKEN       , "Kraken");
    rune[0].desc    =     (STRPTR) LLL(MSG_THE_GODS     , "rune of the gods");
    rune[1].desc    =     (STRPTR) LLL(MSG_TIME         , "rune of time");
    rune[2].desc    =     (STRPTR) LLL(MSG_PROPERTY     , "rune of property");
    rune[3].desc    =     (STRPTR) LLL(MSG_HEALING      , "rune of healing");
    rune[4].desc    =     (STRPTR) LLL(MSG_FURY         , "rune of fury");
    rune[5].desc    =     (STRPTR) LLL(MSG_THE_SUN      , "rune of the sun");
    for (whichcountry = 36; whichcountry <= 39; whichcountry++)
    {   world[whichcountry].name = (STRPTR) LLL(MSG_ATLANTIC_OCEAN , "Atlantic Ocean" );
    }
    for (whichcountry = 40; whichcountry <= 42; whichcountry++)
    {   world[whichcountry].name = (STRPTR) LLL(MSG_IRISH_SEA      , "Irish Sea"      );
    }
    for (whichcountry = 43; whichcountry <= 44; whichcountry++)
    {   world[whichcountry].name = (STRPTR) LLL(MSG_ENGLISH_CHANNEL, "English Channel");
    }
    for (whichcountry = 45; whichcountry <= 62; whichcountry++)
    {   if (whichcountry < 47 || whichcountry > 48)
        {   world[whichcountry].name = (STRPTR) LLL(MSG_NORTH_SEA  , "North Sea"      );
    }   }
    for (whichcountry = 63; whichcountry <= 65; whichcountry++)
    {   world[whichcountry].name = (STRPTR) LLL(MSG_BALTIC_SEA, "Baltic Sea");
    }
    treasure[BROSUNGNECKLACE].name           = (STRPTR) LLL(MSG_BROSUNG_NECKLACE     , "Brosung Necklace" );
    treasure[MAGICSHIRT].name                = (STRPTR) LLL(MSG_MAGIC_SHIRT          , "Magic Shirt"      );
    treasure[MAILCOAT].name                  = (STRPTR) LLL(MSG_MAIL_COAT            , "Mail Coat"        );
    treasure[HEALINGPOTION].name             = (STRPTR) LLL(MSG_HEALING_POTION       , "Healing Potion"   );
    treasure[INVISIBILITYRING].name          = (STRPTR) LLL(MSG_INVISIBILITYRING     , "Invisibility Ring");
    treasure[MAGICCROWN].name                = (STRPTR) LLL(MSG_MAGICCROWN           , "Magic Crown"      );
    treasure[TELEPORTSCROLL].name            = (STRPTR) LLL(MSG_TELEPORT_SCROLL      , "Teleport Scroll"  );

    len1   = strlen((STRPTR) LLL(MSG_INFINITE, "Infinite"  ))    ;
    len2   = strlen((STRPTR) LLL(MSG_SECS,     "%d.%d secs")) - 2;
    maxlen = (len1 > len2) ? len1 : len2;

    NewMenu[INDEX_PROJECT].nm_Label          = (STRPTR) LLL(MSG_MENU_PROJECT         , "Project"          );
    NewMenu[INDEX_NEW].nm_Label              = (STRPTR) LLL(MSG_MENU_NEW             , "New"              );
    NewMenu[INDEX_NEW].nm_CommKey            = (STRPTR) LLL(MSG_KEY_NEW              , "N"                );
    NewMenu[INDEX_OPEN].nm_Label             = (STRPTR) LLL(MSG_MENU_OPEN            , "Open..."          );
    NewMenu[INDEX_OPEN].nm_CommKey           = (STRPTR) LLL(MSG_KEY_OPEN             , "O"                );
    NewMenu[INDEX_SAVE].nm_Label             = (STRPTR) LLL(MSG_MENU_SAVE1           , "Save"             );
    NewMenu[INDEX_SAVE].nm_CommKey           = (STRPTR) LLL(MSG_KEY_SAVE             , "S"                );
    NewMenu[INDEX_SAVE_AS].nm_Label          = (STRPTR) LLL(MSG_MENU_SAVEAS          , "Save as..."       );
    NewMenu[INDEX_SAVE_AS].nm_CommKey        = (STRPTR) LLL(MSG_KEY_SAVEAS           , "A"                );
    NewMenu[INDEX_QUITTITLE].nm_Label        = (STRPTR) LLL(MSG_QUITTITLE            , "Quit to title screen");
    NewMenu[INDEX_QUITDOS].nm_Label          = (STRPTR) LLL(MSG_MENU_QUITWB          , "Quit Saga"        );
    NewMenu[INDEX_QUITDOS].nm_CommKey        = (STRPTR) LLL(MSG_KEY_QUIT             , "Q"                );
    NewMenu[INDEX_SETTINGS].nm_Label         = (STRPTR) LLL(MSG_MENU_SETTINGS        , "Settings"         );
    NewMenu[INDEX_SHOW_TITLEBAR].nm_Label    = (STRPTR) LLL(MSG_SHOW_TITLEBAR        , "Show titlebar?"   );
    NewMenu[INDEX_SHOW_TITLEBAR].nm_CommKey  = (STRPTR) LLL(MSG_SHORTCUT_S_T_B       , "B"                );
    NewMenu[INDEX_WATCH_AMIGA].nm_Label      = (STRPTR) LLL(MSG_W_A_M                , "Watch Amiga movements?");
    NewMenu[INDEX_WATCH_AMIGA].nm_CommKey    = (STRPTR) LLL(MSG_SHORTCUT_W_A_M       , "W"                );
    NewMenu[INDEX_HELP].nm_Label             = (STRPTR) LLL(MSG_MENU_HELP            , "Help"             );
    NewMenu[INDEX_GAME_SUMMARY].nm_Label     = (STRPTR) LLL(MSG_GAME_SUMMARY2        , "Game summary..."  );
    NewMenu[INDEX_GAME_SUMMARY].nm_CommKey   = (STRPTR) LLL(MSG_SHORTCUT_GAME_SUMMARY, "G"                );
    NewMenu[INDEX_HELP_1].nm_Label           = (STRPTR) LLL(MSG_HELP_1               , "Runes..."         );
    NewMenu[INDEX_HELP_2].nm_Label           = (STRPTR) LLL(MSG_HELP_2               , "Spells..."        );
    NewMenu[INDEX_HELP_3].nm_Label           = (STRPTR) LLL(MSG_HELP_3               , "Swords..."        );
    NewMenu[INDEX_HELP_4].nm_Label           = (STRPTR) LLL(MSG_HELP_4               , "Treasures..."     );
    NewMenu[INDEX_MANUAL].nm_Label           = (STRPTR) LLL(MSG_MENU_MANUAL          , "Manual..."        );
    NewMenu[INDEX_MANUAL].nm_CommKey         = (STRPTR) LLL(MSG_KEY_MANUAL           , "M"                );
    NewMenu[INDEX_ABOUT].nm_Label            = (STRPTR) LLL(MSG_ABOUT2               , "About Saga..."    );
    NewMenu[INDEX_ABOUT].nm_CommKey          = (STRPTR) LLL(MSG_KEY_ABOUT            , "?"                );

    srand((unsigned int) time(NULL));

    hero[BEOWULF  ].control = HUMAN;
    hero[BRUNHILD ].control = NONE;
    hero[EGIL     ].control = NONE;
    hero[RAGNAR   ].control = CONTROL_AMIGA;
    hero[SIEGFRIED].control = NONE;
    hero[STARKAD  ].control = NONE;

    ok = FALSE;
    if ((FileHandle = Open("PROGDIR:Saga.config", MODE_OLDFILE)))
    {   if
        (   Read(FileHandle, IOBuffer, CONFIGLENGTH) == CONFIGLENGTH
         && IOBuffer[24] == CONFIGVERSION
        )
        {   ok = TRUE;
            for (whichhero = 0; whichhero <= HEROES; whichhero++)
            {   hero[whichhero].control = (SLONG) ((SBYTE) IOBuffer[whichhero]);
            }
            DisplayID     = (ULONG) (  (IOBuffer[ 6] * 16777216)
                                     + (IOBuffer[ 7] *    65536)
                                     + (IOBuffer[ 8] *      256)
                                     +  IOBuffer[ 9]            );
            DisplayWidth  = (ULONG) (  (IOBuffer[10] * 16777216)
                                     + (IOBuffer[11] *    65536)
                                     + (IOBuffer[12] *      256)
                                     +  IOBuffer[13]            );
            if (DisplayWidth < SCREENXPIXEL)
            {   DisplayWidth = SCREENXPIXEL;
            }
            DisplayHeight = (ULONG) (  (IOBuffer[14] * 16777216)
                                     + (IOBuffer[15] *    65536)
                                     + (IOBuffer[16] *      256)
                                     +  IOBuffer[17]            );
            if (DisplayHeight < SCREENYPIXEL)
            {   DisplayHeight = SCREENYPIXEL;
            }
            DisplayDepth  = (UWORD) (  (IOBuffer[18] *      256)
                                     +  IOBuffer[19]            );
            speed         = (WORD)      IOBuffer[20];
            titlebar      = (FLAG)      IOBuffer[21];
            advanced      = (FLAG)      IOBuffer[22];
            turns         = (SLONG)     IOBuffer[23];
            // [24] is version byte
            watchamiga    = (FLAG)      IOBuffer[25];
            AboutXPos     = (UWORD) (  (IOBuffer[26] *      256)
                                     +  IOBuffer[27]            );
            AboutYPos     = (UWORD) (  (IOBuffer[28] *      256)
                                     +  IOBuffer[29]            );
            customscreen  = (FLAG)      IOBuffer[30];
        }
        DISCARD Close(FileHandle);
        // FileHandle = NULL;
    }

    if (advanced)
    {   monsters  = ADVANCEDMONSTERS;
        treasures = ADVANCEDTREASURES;
    } else
    {   monsters  = BASICMONSTERS;
        treasures = BASICTREASURES;
    }

    /* argument parsing */

    if (argc) /* started from CLI */
    {   if (!(ArgsPtr = ReadArgs
        (   "BEOWULF/K,BRUNHILD/K,EGIL/K,RAGNAR/K,SIEGFRIED/K,STARKAD/K,SCREENMODE/S,PUBSCREEN/K,FILE",
            (LONG*) args,
            NULL
        )))
        {   DISCARD Printf
            (   "%s: %s "
                "[BEOWULF=HUMAN|AMIGA|NONE] "
                "[BRUNHILD=HUMAN|AMIGA|NONE] "
                "[EGIL=HUMAN|AMIGA|NONE] "
                "[RAGNAR=HUMAN|AMIGA|NONE] "
                "[SIEGFRIED=HUMAN|AMIGA|NONE] "
                "[STARKAD=HUMAN|AMIGA|NONE] "
                "[SCREENMODE] "
                "[PUBSCREEN=<screenname>] "
                "[[FILE=]<savedgame>]\n",
                LLL(MSG_USAGE, "Usage"),
                argv[0]
            );
            cleanexit(EXIT_FAILURE);
        }

        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   if (args[ARGPOS_FIRSTHERO + whichhero])
            {   if     (!stricmp((STRPTR) args[ARGPOS_FIRSTHERO + whichhero], "HUMAN"))
                {   hero[whichhero].control = HUMAN;
                } elif (!stricmp((STRPTR) args[ARGPOS_FIRSTHERO + whichhero], "AMIGA"))
                {   hero[whichhero].control = CONTROL_AMIGA;
                } elif (!stricmp((STRPTR) args[ARGPOS_FIRSTHERO + whichhero], "NONE"))
                {   hero[whichhero].control = NONE;
                } else
                {   DISCARD Printf("%s: Hero control must be HUMAN, AMIGA or NONE\n", argv[0]); // localize?
        }   }   }
        if (args[ARGPOS_SCREENMODE])
        {   screenmode = TRUE;
        }
        if (args[ARGPOS_PUBSCREEN])
        {   strcpy(screenname, (STRPTR) args[ARGPOS_PUBSCREEN]);
        }
        if (args[ARGPOS_FILE])
        {   strcpy(pathname, (STRPTR) args[ARGPOS_FILE]);
            cliload = TRUE;
    }   }
    else // started from WB
    {   WBMsg = (struct WBStartup*) argv;
        WBArg = WBMsg->sm_ArgList; // head of the arg list

        for
        (   i = 0;
            i < WBMsg->sm_NumArgs;
            i++, WBArg++
        )
        {   if (WBArg->wa_Lock)
            {   // something that does not support locks
                parsewb();
            }
            else
            {   // locks supported, change to the proper directory
                OldDir = CurrentDir(WBArg->wa_Lock);
                parsewb();
                CurrentDir(OldDir);
            }
            if (i == 1)
            {   strcpy(pathname, WBArg->wa_Name);
                cliload = TRUE;
    }   }   }

#if defined(__AROS__) && (AROS_BIG_ENDIAN == 0)
    swap_byteorder((UWORD*) OriginalCounterData, sizeof(OriginalCounterData) / 2);
    swap_byteorder((UWORD*) OriginalMapData,     sizeof(OriginalMapData)     / 2);
    swap_byteorder((UWORD*) OriginalAboutData,   sizeof(OriginalAboutData)   / 2);
    swap_byteorder((UWORD*) OriginalLogoData,    sizeof(OriginalLogoData)    / 2);
    swap_byteorder((UWORD*) OriginalBkgrndData,  sizeof(OriginalBkgrndData)  / 2);
#endif

    if ((!ok || screenmode) && !screenname[0])
    {   getscreenmode();
    }
    if (!screenname[0])
    {   GetDefaultPubScreen(screenname);
    }

    WindowWidth  =  DisplayWidth;
    WindowHeight =  DisplayHeight;

#ifdef __amigaos4__
    registerapp();
#endif

    if (customscreen)
    {   ScreenPtr = (struct Screen*) OpenScreenTags
        (   NULL,
            SA_Width,         DisplayWidth,
            SA_Height,        DisplayHeight,
            SA_Depth,         DisplayDepth,
            SA_Behind,        TRUE,
            SA_AutoScroll,    TRUE,
            SA_ShowTitle,     titlebar ? TRUE : FALSE,
            SA_Title,         (ULONG) TITLEBAR,
            SA_Font,          (ULONG) &Topaz8,
            SA_Colors32,      (ULONG) table1,
#ifndef __AROS__
            SA_DisplayID,     DisplayID,
            SA_LikeWorkbench, TRUE, // to get sticky menu support on OS4, but not handled correctly by AROS
#endif
            SA_Pens,          (ULONG) Pens,
        TAG_DONE);
        if (!ScreenPtr)
        {   rq("Can't open screen!");
        }
#ifdef __AROS__
        SetAPen(&ScreenPtr->RastPort, 0);
        RectFill
        (   &ScreenPtr->RastPort,
            0,
            ScreenPtr->BarHeight,
            ScreenPtr->Width - 1,
            ScreenPtr->Height - 1
        );
#endif
        LoadRGB32(&(ScreenPtr->ViewPort), table2);
        LoadRGB32(&(ScreenPtr->ViewPort), table3);
    } else
    {   lockscreen();

        DisplayDepth = 8;
        DisplayID    = GetVPModeID(&(ScreenPtr->ViewPort));
    }
    if ((DisplayID & PAL_MONITOR_ID) == PAL_MONITOR_ID || (DisplayID & NTSC_MONITOR_ID) == NTSC_MONITOR_ID)
    {   memflags |= MEMF_CHIP;
    }

    saveconfig = TRUE;

    // this must be done before the menus are set up
    if (!customscreen)
    {   titlebar = TRUE;
        NewMenu[INDEX_SHOW_TITLEBAR].nm_Flags |= NM_ITEMDISABLED;
    }
    if (titlebar)
    {   NewMenu[INDEX_SHOW_TITLEBAR].nm_Flags |= CHECKED;
    }
    if (watchamiga)
    {   NewMenu[INDEX_WATCH_AMIGA  ].nm_Flags |= CHECKED;
    }

    if (!(OffScreenBitMapPtr = (struct BitMap*) AllocBitMap((ULONG) SCREENXPIXEL, (ULONG) SCREENYPIXEL, DisplayDepth, 0, ScreenPtr->RastPort.BitMap)))
    {   rq("Can't allocate friendly bitmap!");
    }
    InitRastPort(&OffScreenRastPort); // no return code
    OffScreenRastPort.BitMap = OffScreenBitMapPtr;
    SetFont(&OffScreenRastPort, FontPtr);
    fontx = OffScreenRastPort.TxWidth;
    fonty = OffScreenRastPort.TxHeight;

    if (!(VisualInfoPtr = (APTR) GetVisualInfo(ScreenPtr, TAG_DONE)))
    {   rq("Can't get GadTools visual info!");
    }
    if (!(MenuPtr = (struct Menu*) CreateMenus(NewMenu, TAG_DONE)))
    {   rq("Can't create menus!");
    }
    if (!(LayoutMenus(MenuPtr, VisualInfoPtr, GTMN_NewLookMenus, TRUE, TAG_DONE)))
    {   rq("Can't lay out menus!");
    }

    /* main window */
    if (!(MainWindowPtr = (struct Window*) OpenWindowTags(NULL,
#ifdef __AROS__
        WA_Left,                            ((ScreenPtr->Width  - WindowWidth ) / 2),
        WA_Top,                             ((ScreenPtr->Height - WindowHeight) / 2),
#else
        WA_Left,         customscreen ? 0 : ((ScreenPtr->Width  - WindowWidth ) / 2),
        WA_Top,          customscreen ? 0 : ((ScreenPtr->Height - WindowHeight) / 2),
#endif
        customscreen ? TAG_IGNORE : WA_Title,       (ULONG) "Saga " DECIMALVERSION,
        customscreen ? TAG_IGNORE : WA_ScreenTitle, (ULONG) "Saga " DECIMALVERSION,
        customscreen ? TAG_IGNORE : WA_DepthGadget, TRUE,
        customscreen ? TAG_IGNORE : WA_DragBar,     TRUE,
        customscreen ? TAG_IGNORE : WA_CloseGadget, TRUE,
        customscreen ? TAG_IGNORE : WA_SizeGadget,  FALSE,
        WA_IDCMP,               IDCMP_RAWKEY
                              | IDCMP_VANILLAKEY
                              | IDCMP_MOUSEBUTTONS
                              | IDCMP_INTUITICKS
                              | IDCMP_CLOSEWINDOW
                              | IDCMP_REFRESHWINDOW
                              | IDCMP_MENUPICK
                              | IDCMP_MENUVERIFY
                              | IDCMP_ACTIVEWINDOW
                              | CYCLEIDCMP
                              | CHECKBOXIDCMP
                              | BUTTONIDCMP
                              | SLIDERIDCMP,
        WA_Activate,            TRUE,
        WA_NewLookMenus,        TRUE,
        customscreen ? WA_Backdrop     : TAG_IGNORE,     TRUE,
        customscreen ? WA_Borderless   : TAG_IGNORE,     TRUE,
        customscreen ? WA_CustomScreen : TAG_IGNORE,     (ULONG) ScreenPtr,
        customscreen ? WA_Width        : WA_InnerWidth,  WindowWidth,
        customscreen ? WA_Height       : WA_InnerHeight, WindowHeight,
    TAG_DONE)))
    {   rq("Can't open window!");
    }

    if (customscreen)
    {   xoffset = yoffset = 0;
    } else
    {   xoffset = ScreenPtr->WBorLeft;
        yoffset = ScreenPtr->WBorTop + ScreenPtr->Font->ta_YSize + 1; // not fonty, as it can be a different font!
    }

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   CycleGadget[whichhero].ng_VisualInfo = VisualInfoPtr;
        CycleGadget[whichhero].ng_LeftEdge   = (WORD) LEFTGAP + 300;
        CycleGadget[whichhero].ng_TopEdge    = (WORD) TOPGAP  + 211 + (whichhero * 13);
        CycleGadget[whichhero].ng_TextAttr   = &Topaz8;
    }
    SpeedGadget.ng_VisualInfo    =
    TurnsGadget.ng_VisualInfo    =
    AdvancedGadget.ng_VisualInfo =
    StartGadget.ng_VisualInfo    = VisualInfoPtr;

    SpeedGadget.ng_LeftEdge      =
    TurnsGadget.ng_LeftEdge      =
    AdvancedGadget.ng_LeftEdge   = (WORD) LEFTGAP + 300;
    StartGadget.ng_LeftEdge      = (WORD) LEFTGAP + 160;

    SpeedGadget.ng_TopEdge       = (WORD) TOPGAP  + 307;
    TurnsGadget.ng_TopEdge       = (WORD) TOPGAP  + 321;
    AdvancedGadget.ng_TopEdge    = (WORD) TOPGAP  + 349;
    StartGadget.ng_TopEdge       = (WORD) TOPGAP  + 377;

    AdvancedGadget.ng_TextAttr   = // yes, needed even for checkbox gadgets! (for correct positioning)
    StartGadget.ng_TextAttr      = &Topaz8;

    if (!(PrevGadgetPtr = (struct Gadget*) CreateContext(&GListPtr)))
    {   rq("Can't create GadTools context!");
    }

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   CycleGadgetPtr[whichhero] = PrevGadgetPtr = (struct Gadget*) CreateGadget
        (   CYCLE_KIND,
            PrevGadgetPtr,
            &CycleGadget[whichhero],
            GTCY_Labels, CycleOptions,
            GTCY_Active, hero[whichhero].control,
        TAG_DONE);
    }
    SpeedGadgetPtr    = PrevGadgetPtr = (struct Gadget*) CreateGadget
    (   SLIDER_KIND,
        PrevGadgetPtr,
        &SpeedGadget,
        GA_RelVerify,     TRUE,
        GTSL_Min,         0,
        GTSL_Max,         7,
        GTSL_Level,       speed,
    TAG_DONE);
    TurnsGadgetPtr    = PrevGadgetPtr = (struct Gadget*) CreateGadget
    (   SLIDER_KIND,
        PrevGadgetPtr,
        &TurnsGadget,
        GA_RelVerify,     TRUE,
        GTSL_Min,         1,
        GTSL_Max,         99,
        GTSL_Level,       (WORD) turns,
    TAG_DONE);
    AdvancedGadgetPtr = PrevGadgetPtr = (struct Gadget*) CreateGadget
    (   CHECKBOX_KIND,
        PrevGadgetPtr,
        &AdvancedGadget,
        GA_RelVerify,     TRUE,
        GTCB_Checked,     (BOOL) advanced,
    TAG_DONE);
    StartGadgetPtr    = PrevGadgetPtr = (struct Gadget*) CreateGadget
    (   BUTTON_KIND,
        PrevGadgetPtr,
        &StartGadget,
        GA_RelVerify,     TRUE,
        GA_Disabled,      TRUE,
    TAG_DONE);

    AddGList(MainWindowPtr, GListPtr, 0, -1, NULL);
    RefreshGadgets(GListPtr, MainWindowPtr, NULL);
    GT_RefreshWindow(MainWindowPtr, NULL);

    /* redirection of AmigaDOS system requesters */
    OldWindowPtr = ProcessPtr->pr_WindowPtr;
    ProcessPtr->pr_WindowPtr = (APTR) MainWindowPtr;
    MainSignal = 1 << MainWindowPtr->UserPort->mp_SigBit;

    SetFont(MainWindowPtr->RPort, FontPtr);

    if
    (   !(AboutData                              = AllocMem(    456 / 2 * 8 * 2, memflags))
     || !(BkgrndData                             = AllocMem( 4 * 58     * 8 * 2, memflags))
     || !(LogoData                               = AllocMem(   7252 / 7 * 8 * 2, memflags))
     || !(MapData                                = AllocMem(MAPSIZE / 7 * 8 * 2, memflags))
    )
    {   if     (memflags & MEMF_CHIP) rq("Out of chip memory!"); else rq("Out of memory!");
    }
    for (i = 0; i < COUNTERIMAGES; i++)
    {   if (!(CounterData[i]                     = AllocMem(48 * 8 * 2, memflags)))
        {   if (memflags & MEMF_CHIP) rq("Out of chip memory!"); else rq("Out of memory!");
    }   }
    for (i = 0; i < SELCOUNTERIMAGES; i++)
    {   if (!(SelectedCounterData[i]             = AllocMem(48 * 8 * 2, memflags)))
        {   if (memflags & MEMF_CHIP) rq("Out of chip memory!"); else rq("Out of memory!");
    }   }
    for (i = 0; i < 4; i++)
    {   if (!(InnerCornerData[i]                 = AllocMem(9 * 8 * 2, memflags)))
        {   if (memflags & MEMF_CHIP) rq("Out of chip memory!"); else rq("Out of memory!");
        }
        if (customscreen && !(OuterCornerData[i] = AllocMem(9 * 8 * 2, memflags)))
        {   if (memflags & MEMF_CHIP) rq("Out of chip memory!"); else rq("Out of memory!");
    }   }

    remap();

    if (!(ASLRqPtr = AllocAslRequestTags
    (   ASL_FileRequest,
        ASL_Pattern, (ULONG) "#?.saga",
        ASL_Window,  (ULONG) MainWindowPtr,
    TAG_DONE)))
    {   rq("Can't create ASL file request!");
    }

    DISCARD SetMenuStrip(MainWindowPtr, MenuPtr);

    ScreenToFront(ScreenPtr);

    for (;;)
    {   titlescreen();
        if (!loaded)
        {   newgame();
        }
        gameloop();
}   }

MODULE void gameloop(void)
{   SLONG                bestscore = 0,
                         besthero  = -1, // to avoid spurious compiler warnings
                         fastest,
                         heroes    = 0,
                         strongest,
                         strongestjarl,
                         result,
                         whichhero,
                         whichjarl,
                         whichcountry,
                         whichmonster,
                         whichtreasure,
                         whichsord,
                         winners   = 0;
    FLAG                 transfer;

    do
    {   border(-1);
        strcpy(MainTitle, TITLEBAR);
        strcat(MainTitle, ": ");
        sprintf
        (   saystring,
            "%s %ld %s %ld",
            LLL(MSG_TURN, "Turn"),
            turn,
            LLL(MSG_OF, "of"),
            turns
        );
        strcat(MainTitle, saystring);
        strcat(saystring, "...");
        SetWindowTitles(MainWindowPtr, MainTitle, MainTitle); // this is not copied, it is a pointer
        say(LOWER, WHITE);
        hint
        (   LLL(MSG_OK, "OK"),
            LLL(MSG_OK, "OK")
        );

        OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_NEW,       NOSUB));
        OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,      NOSUB));
        OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,    NOSUB));
        OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE, NOSUB));

        savegame(FALSE, TRUE);

        allwithdrawn = TRUE;
        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   if (hero[whichhero].alive || !hero[whichhero].verydead)
            {   allwithdrawn = FALSE;
                break; // for speed
        }   }
        if (!allwithdrawn)
        {   result = getevent(MULTIKEYBOARD, WHITE);
            if (result == -4)
            {   for (whichhero = 0; whichhero <= HEROES; whichhero++)
                {   hero[whichhero].alive    = FALSE;
                    hero[whichhero].verydead = TRUE;
                }
                gameaborted = TRUE;
        }   }

        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_NEW,       NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,      NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,    NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE, NOSUB));

        if (!allwithdrawn && !gameaborted)
        {   for (whichhero = 0; whichhero <= HEROES; whichhero++)
            {   if (!hero[whichhero].alive && !hero[whichhero].verydead)
                {   transfer = FALSE;
                    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                    {   if (jarl[whichjarl].alive && jarl[whichjarl].hero == whichhero)
                        {   transfer = TRUE;
                            break; // for speed
                    }   }

                    if (hero[whichhero].control == CONTROL_AMIGA)
                    {   if (transfer)
                        {   strongest = fastest = strongestjarl = 0;
                            for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                            {   if
                                (   jarl[whichjarl].alive
                                 && jarl[whichjarl].hero == whichhero
                                )
                                {   if (jarl[whichjarl].strength > strongest)
                                    {   strongest     = jarl[whichjarl].strength;
                                        fastest       = jarl[whichjarl].moves;
                                        strongestjarl = whichjarl;
                                    } elif (jarl[whichjarl].strength == strongest)
                                    {   if (jarl[whichjarl].moves > fastest)
                                        {   strongest     = jarl[whichjarl].strength;
                                            fastest       = jarl[whichjarl].moves;
                                            strongestjarl = whichjarl;
                            }   }   }   }
                            sprintf
                            (   saystring,
                                "%s %s %s %s (%ld-%ld).",
                                LLL(MSG_DEAD_HERO, "Dead hero"),
                                hero[whichhero].name,
                                LLL(MSG_PROMOTES_JARL, "promotes jarl"),
                                jarl[strongestjarl].name,
                                jarl[strongestjarl].strength,
                                jarl[strongestjarl].moves
                            );
                            promote(whichhero, strongestjarl); // order-dependent
                        } else
                        {   if (turn > turns / 2)
                            {   withdraw(whichhero);
                                sprintf
                                (   saystring,
                                    "%s %s %s.",
                                    LLL(MSG_DEAD_HERO, "Dead hero"),
                                    hero[whichhero].name,
                                    LLL(MSG_WITHDRAWS_FROM_PLAY, "withdraws from play")
                                );
                            } else
                            {   newhero(whichhero, FALSE);
                                sprintf
                                (   saystring,
                                    "%s %s %s.",
                                    LLL(MSG_DEAD_HERO, "Dead hero"),
                                    hero[whichhero].name,
                                    LLL(MSG_RESTARTS, "restarts")
                                );
                        }   }
                        say(LOWER, FIRSTHEROCOLOUR + whichhero);
                        anykey();
                    } elif (hero[whichhero].control == HUMAN)
                    {   sprintf
                        (   saystring,
                            "%s %s, (%s)%s/(%s)%s",
                            LLL(MSG_DEAD_HERO,       "Dead hero"),
                            hero[whichhero].name,
                            LLL(MSG_CHAR_WITHDRAW,   "W"),
                            LLL(MSG_UNCHAR_WITHDRAW, "ithdraw"),
                            LLL(MSG_CHAR_RESTART,    "R"),
                            LLL(MSG_UNCHAR_RESTART,  "estart")
                        );
                        if (transfer)
                        {   sprintf
                            (   saystring2,
                                "/(%s)%s?",
                                LLL(MSG_CHAR_TRANSFER,   "T"),
                                LLL(MSG_UNCHAR_TRANSFER, "ransfer")
                            );
                            strcat(saystring, saystring2);
                        } else
                        {   strcat(saystring, "?");
                        }
                        say(LOWER, FIRSTHEROCOLOUR + whichhero);
                        do
                        {   result = getevent(WRKEYBOARD, FIRSTHEROCOLOUR + whichhero);
                        } while
                        (   result != onekey[ONEKEY_WITHDRAW]
                         && result != onekey[ONEKEY_RESTART]
                         && (!transfer || result != onekey[ONEKEY_TRANSFER])
                        );
                        if (result == onekey[ONEKEY_TRANSFER])
                        {   sprintf
                            (   saystring,
                                "%s %s, %s?",
                                LLL(MSG_DEAD_HERO, "Dead hero"),
                                hero[whichhero].name,
                                LLL(MSG_S_W_J_T_P, "select which jarl to promote")
                            );
                            say(LOWER, FIRSTHEROCOLOUR + whichhero);
                            do
                            {   whichjarl = getevent(COUNTER, FIRSTHEROCOLOUR + whichhero);
                            } while
                            (   whichjarl < 0
                             || countertype != JARL
                             || jarl[whichjarl].hero != whichhero
                            );
                            promote(whichhero, whichjarl);
                        } elif (result == onekey[ONEKEY_WITHDRAW])
                        {   withdraw(whichhero);
                        } elif (result == onekey[ONEKEY_RESTART])
                        {   newhero(whichhero, FALSE);
            }   }   }   }

            phase1(); // movement
            phase2(); // combat
            phase3(); // kingdoms

            /* "4. PLACE MONSTERS. A number of monsters equal to the number
            of heroes in play are randomly placed face up by rolling two dice
            and placing the monster in the area indicated. (This is done every
            turn until all counters are used. "Dead" monsters may not be
            reused."

            It's arguable whether monsters and jarls should be added
            at the end of the last turn. A strict reading of the rules
            would indicate that they should, but in practical terms it
            is better not to - adding them causes the new counters to
            appear on screen just before the screen is blanked, which
            is an annoying effect. */

            if (turn < turns)
            {   place_monsters(); // phase 4

            /* "5. PLACE JARLS. A number of jarls equal to the number of
            heroes in play are randomly placed face up by rolling two dice
            and placing the jarl in the area indicated. (This is done every
            turn until all counters are used. "Dead" jarls may not be
            reused." */

                place_jarls();    // phase 5

                updatescreen();
            }

            /* 6. MARK TURN. One turn is marked off. */

            for (whichhero = 0; whichhero <= HEROES; whichhero++)
            {   hero[whichhero].score[turn] = calcscore(whichhero);
            }
            turn++;
    }   }
    while (turn <= turns && !allwithdrawn && !gameaborted);

    /* "At the end of the 20th turn the game is over and players total
    their glory to determine who has won. The turn should be marked off on
    each player's record sheet." */

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   remove_hero(whichhero, FALSE);
    }
    for (whichjarl = 0; whichjarl <= JARL; whichjarl++)
    {   remove_jarl(whichjarl, FALSE);
    }
    for (whichmonster = 0; whichmonster <= MONSTERS; whichmonster++)
    {   remove_monster(whichmonster, FALSE);
    }
    for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
    {   remove_treasure(whichtreasure, FALSE);
    }
    for (whichsord = 0; whichsord <= SORDS; whichsord++)
    {   remove_sord(whichsord, FALSE);
    }
    // no reason to call unters() as we are about to blank the screen
    for (whichcountry = 0; whichcountry <= 65; whichcountry++)
    {   world[whichcountry].hero = -1;
    }
    clearscreen();

    if (!gameaborted)
    {   turn--;

        border(-1);
        SetDrMd(MainWindowPtr->RPort, JAM1);
        SetAPen(MainWindowPtr->RPort, remapit[LIGHTGREY]);
        RectFill(MainWindowPtr->RPort, LEFTGAP + 320 - 70, 198 + TOPGAP, LEFTGAP + 320 + 70, 198 + TOPGAP + 11);

        SetAPen(MainWindowPtr->RPort, remapit[WHITE]);
        Move(MainWindowPtr->RPort, LEFTGAP + 320 - 70, 198 + TOPGAP - 2);
        Draw(MainWindowPtr->RPort, LEFTGAP + 320 + 70, 198 + TOPGAP - 2);

        SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
        Move(MainWindowPtr->RPort, LEFTGAP + 320 - 70, 198 + TOPGAP - 1);
        Draw(MainWindowPtr->RPort, LEFTGAP + 320 + 70, 198 + TOPGAP - 1);
        Move(MainWindowPtr->RPort, LEFTGAP + 320 - 70, 198 + TOPGAP + 12);
        Draw(MainWindowPtr->RPort, LEFTGAP + 320 + 70, 198 + TOPGAP + 12);

        strcpy(saystring, LLL(MSG_HERO_NAME, "Hero Name"));
        Move(MainWindowPtr->RPort, LEFTGAP + 320 - 70 + 4, 198 + TOPGAP + 8);
        DISCARD Text(MainWindowPtr->RPort, saystring, strlen(saystring));

        strcpy(saystring, LLL(MSG_SCORE, "Score"));
        Move(MainWindowPtr->RPort, LEFTGAP + 320 + 70 - (fontx * 4) - 4 + (fontx * (4 - strlen(saystring))), 198 + TOPGAP + 8);
        DISCARD Text(MainWindowPtr->RPort, saystring, strlen(saystring));

        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   if (hero[whichhero].control != NONE)
            {   heroes++;
                hero[whichhero].score[turn] = calcscore(whichhero);

                if (hero[whichhero].score[turn] >= 15)
                {   SetAPen(MainWindowPtr->RPort, remapit[GREEN]);
                } else
                {   SetAPen(MainWindowPtr->RPort, remapit[RED]);
                }
                RectFill(MainWindowPtr->RPort, LEFTGAP + 320 - 70, 198 + TOPGAP + (heroes * SCOREDISTANCE), LEFTGAP + 320 + 70, 198 + TOPGAP + 11 + (heroes * SCOREDISTANCE));

                SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
                Move(MainWindowPtr->RPort, LEFTGAP + 320 - 70 + 4, 198 + TOPGAP + 8 + (heroes * SCOREDISTANCE));
                DISCARD Text(MainWindowPtr->RPort, hero[whichhero].name, strlen(hero[whichhero].name));

                stcl_d(numberstring, hero[whichhero].score[turn]);
                Move(MainWindowPtr->RPort, LEFTGAP + 320 + 70 - (fontx * 4) - 4 + (fontx * (4 - strlen(numberstring))), 198 + TOPGAP + 8 + (heroes * SCOREDISTANCE));
                DISCARD Text(MainWindowPtr->RPort, numberstring, strlen(numberstring));

                Move(MainWindowPtr->RPort, LEFTGAP + 320 - 70, 210 + TOPGAP + (heroes * SCOREDISTANCE));
                Draw(MainWindowPtr->RPort, LEFTGAP + 320 + 70, 210 + TOPGAP + (heroes * SCOREDISTANCE));
        }   }

        SetAPen(MainWindowPtr->RPort, remapit[WHITE]);
        Move(MainWindowPtr->RPort, LEFTGAP + 249, 196 + TOPGAP);
        Draw(MainWindowPtr->RPort, LEFTGAP + 249, 198 + TOPGAP + ((heroes + 1) * SCOREDISTANCE));

        SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
        Move(MainWindowPtr->RPort, LEFTGAP + 250, 198 + TOPGAP );
        Draw(MainWindowPtr->RPort, LEFTGAP + 250, 198 + TOPGAP + ((heroes + 1) * SCOREDISTANCE));
        Move(MainWindowPtr->RPort, LEFTGAP + 340, 198 + TOPGAP );
        Draw(MainWindowPtr->RPort, LEFTGAP + 340, 198 + TOPGAP + ((heroes + 1) * SCOREDISTANCE));
        Move(MainWindowPtr->RPort, LEFTGAP + 390, 198 + TOPGAP );
        Draw(MainWindowPtr->RPort, LEFTGAP + 390, 198 + TOPGAP + ((heroes + 1) * SCOREDISTANCE));
        Move(MainWindowPtr->RPort, LEFTGAP + 391, 198 + TOPGAP );
        Draw(MainWindowPtr->RPort, LEFTGAP + 391, 198 + TOPGAP + ((heroes + 1) * SCOREDISTANCE));
        Draw(MainWindowPtr->RPort, LEFTGAP + 250, 198 + TOPGAP + ((heroes + 1) * SCOREDISTANCE));

        strcpy(saystring, LLL(MSG_GAME_OVER, "Game over"));
        strcat(saystring, "!");

        if (heroes > 1)
        {   // determine winner
            for (whichhero = 0; whichhero <= HEROES; whichhero++)
            {   if (hero[whichhero].control != NONE && hero[whichhero].score[turn] >= bestscore)
                {   bestscore = hero[whichhero].score[turn];
            }   }
            for (whichhero = 0; whichhero <= HEROES; whichhero++)
            {   if (hero[whichhero].control != NONE && hero[whichhero].score[turn] == bestscore)
                {   winners++;
                    besthero = whichhero;
            }   }

            if (winners == 1)
            {   strcat(saystring, " ");
                strcat(saystring, hero[besthero].name);
                strcat(saystring, " ");
                strcat(saystring, LLL(MSG_WINS, "wins"));
                strcat(saystring, "!");
        }   }

        shadowtext
        (   MainWindowPtr->RPort,
            saystring,
            WHITE,
            LEFTGAP +             4,
            TOPGAP  + MESSAGEY + 16
        );

        OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE, NOSUB));

        Delay(50);
        clearkybd_gt(MainWindowPtr);

        getevent(GAMEOVERSCREEN, WHITE);
}   }

EXPORT void cleanexit(SLONG rc)
{   BPTR  FileHandle /* = ZERO */ ;
    SLONG whichhero;
    int   i;

    if (ASLRqPtr)
    {   FreeAslRequest(ASLRqPtr);
        ASLRqPtr = NULL;
    }
    if (OldWindowPtr)
    {   ProcessPtr->pr_WindowPtr = OldWindowPtr;
    }

    /* It does not matter whether there are outstanding messages for a
    window when it is closed, provided that the window does not use a
    shared IDCMP message port. */

    if (InfoWindowPtr)
    {   CloseWindow(InfoWindowPtr);
        InfoWindowPtr = NULL;
    }
    if (MainWindowPtr)
    {   ClearMenuStrip(MainWindowPtr);
        CloseWindow(MainWindowPtr);
        MainWindowPtr = NULL;
    }
    if (GListPtr)
    {   FreeGadgets(GListPtr);
        GListPtr = NULL;
    }
    if (MenuPtr)
    {   FreeMenus(MenuPtr);
        MenuPtr = NULL;
    }
    if (VisualInfoPtr)
    {   FreeVisualInfo(VisualInfoPtr);
        VisualInfoPtr = NULL;
    }
    if (customscreen)
    {   if (ScreenPtr)
        {   DISCARD CloseScreen(ScreenPtr);
            ScreenPtr = NULL;
    }   }
    else
    {   for (i = 0; i < 128; i++)
        {   if (gotpen[i])
            {   ReleasePen(ScreenPtr->ViewPort.ColorMap, remapit[i]);
                gotpen[i] = FALSE;
        }   }
        unlockscreen();
    }

    if (AboutData)
    {   FreeMem(AboutData,      456 / 2 * 8 * 2);
        // AboutData = NULL;
    }
    if (BkgrndData)
    {   FreeMem(BkgrndData,      4 * 58 * 8 * 2);
        // BkgrndData = NULL;
    }
    if (LogoData)
    {   FreeMem(LogoData,      7252 / 7 * 8 * 2);
        // LogoData = NULL;
    }
    if (MapData)
    {   FreeMem(MapData,    MAPSIZE / 7 * 8 * 2);
        // MapData = NULL;
    }
    for (i = 0; i < COUNTERIMAGES; i++)
    {   if (CounterData[i])
        {   FreeMem(CounterData[i],  48 * 8 * 2);
            // CounterData[i] = NULL;
    }   }
    for (i = 0; i < SELCOUNTERIMAGES; i++)
    {   if (SelectedCounterData[i])
        {   FreeMem(SelectedCounterData[i], 48 * 8 * 2);
            // SelectedCounterData[i] = NULL;
    }   }
    for (i = 0; i < 4; i++)
    {   if (InnerCornerData[i])
        {   FreeMem(InnerCornerData[i], 9 * 8 * 2);
            // InnerCornerData[i] = NULL;
        }
        if (OuterCornerData[i])
        {   FreeMem(OuterCornerData[i], 9 * 8 * 2);
            // OuterCornerData[i] = NULL;
    }   }

    if (OffScreenBitMapPtr)
    {   FreeBitMap(OffScreenBitMapPtr);
        OffScreenBitMapPtr = NULL;
    }
    if (FontPtr)
    {   CloseFont(FontPtr);
        FontPtr = NULL;
    }
    if (LocaleBase)
    {   if (   CatalogPtr) CloseCatalog(   CatalogPtr);
        if (StdCatalogPtr) CloseCatalog(StdCatalogPtr);
    }
    if (IntuitionBase)
    {   DISCARD OpenWorkBench();
    }
    if (ArgsPtr)
    {   FreeArgs(ArgsPtr);
        ArgsPtr = NULL;
    }

    if (saveconfig)
    {   for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   IOBuffer[whichhero] = (UBYTE) hero[whichhero].control;
        }
        IOBuffer[ 6] = (UBYTE)   (DisplayID     / 16777216);
        IOBuffer[ 7] = (UBYTE)  ((DisplayID     % 16777216) / 65536);
        IOBuffer[ 8] = (UBYTE) (((DisplayID     % 16777216) % 65536) / 256);
        IOBuffer[ 9] = (UBYTE) (((DisplayID     % 16777216) % 65536) % 256);
        IOBuffer[10] = (UBYTE)   (DisplayWidth  / 16777216);
        IOBuffer[11] = (UBYTE)  ((DisplayWidth  % 16777216) / 65536);
        IOBuffer[12] = (UBYTE) (((DisplayWidth  % 16777216) % 65536) / 256);
        IOBuffer[13] = (UBYTE) (((DisplayWidth  % 16777216) % 65536) % 256);
        IOBuffer[14] = (UBYTE)   (DisplayHeight / 16777216);
        IOBuffer[15] = (UBYTE)  ((DisplayHeight % 16777216) / 65536);
        IOBuffer[16] = (UBYTE) (((DisplayHeight % 16777216) % 65536) / 256);
        IOBuffer[17] = (UBYTE) (((DisplayHeight % 16777216) % 65536) % 256);
        IOBuffer[18] = (UBYTE)   (DisplayDepth                       / 256);
        IOBuffer[19] = (UBYTE)   (DisplayDepth                       % 256);
        IOBuffer[20] = (UBYTE)    speed;
        IOBuffer[21] = (UBYTE)    titlebar;
        IOBuffer[22] = (UBYTE)    advanced;
        IOBuffer[23] = (UBYTE)    turns;
        IOBuffer[24] =            CONFIGVERSION;
        IOBuffer[25] = (UBYTE)    watchamiga;
        IOBuffer[26] = (UBYTE)   (AboutXPos                          / 256);
        IOBuffer[27] = (UBYTE)   (AboutXPos                          % 256);
        IOBuffer[28] = (UBYTE)   (AboutYPos                          / 256);
        IOBuffer[29] = (UBYTE)   (AboutYPos                          % 256);
        IOBuffer[30] = (UBYTE)    customscreen;
        if ((FileHandle = Open("PROGDIR:Saga.config", MODE_NEWFILE)))
        {   DISCARD Write(FileHandle, IOBuffer, CONFIGLENGTH);
            DISCARD Close(FileHandle);
            // FileHandle = NULL;
    }   }

#ifdef __amigaos4__
    if (AppID)
    {   // assert(ApplicationBase);
        // assert(IApplication);
        UnregisterApplication(AppID, TAG_DONE);
        // AppID = 0;
    }

    if (IAmigaGuide)     { DropInterface((struct Interface*) IAmigaGuide ); }
    if (IApplication)    { DropInterface((struct Interface*) IApplication); }
    if (IAsl)            { DropInterface((struct Interface*) IAsl        ); }
    if (IDiskfont)       { DropInterface((struct Interface*) IDiskfont   ); }
    if (IGadTools)       { DropInterface((struct Interface*) IGadTools   ); }
    if (IGraphics)       { DropInterface((struct Interface*) IGraphics   ); }
    if (IIcon)           { DropInterface((struct Interface*) IIcon       ); }
    if (IIntuition)      { DropInterface((struct Interface*) IIntuition  ); }
    if (ILocale)         { DropInterface((struct Interface*) ILocale     ); }
    if (IOpenURL)        { DropInterface((struct Interface*) IOpenURL    ); }

    if (ApplicationBase) { CloseLibrary(ApplicationBase);                 ApplicationBase = NULL; }
#endif
    if (AmigaGuideBase)  { CloseLibrary(AmigaGuideBase);                  AmigaGuideBase  = NULL; }
    if (AslBase)         { CloseLibrary(AslBase);                         AslBase         = NULL; }
    if (DiskfontBase)    { CloseLibrary(DiskfontBase);                    DiskfontBase    = NULL; }
    if (GadToolsBase)    { CloseLibrary((struct Library*) GadToolsBase);  GadToolsBase    = NULL; }
    if (GfxBase)         { CloseLibrary((struct Library*) GfxBase);       GfxBase         = NULL; }
    if (IconBase)        { CloseLibrary((struct Library*) IconBase);      IconBase        = NULL; }
    if (IntuitionBase)   { CloseLibrary((struct Library*) IntuitionBase); IntuitionBase   = NULL; }
    if (LocaleBase)      { CloseLibrary((struct Library*) LocaleBase);    LocaleBase      = NULL; }
    if (OpenURLBase)     { CloseLibrary(OpenURLBase);                     OpenURLBase     = NULL; }

    exit((int) rc); // End of program.
}

EXPORT void say(SLONG position, UBYTE whichcolour)
{   if (position == UPPER)
    {   if (saystring[0] != '-')
        {   strcat(saystring, ". ");
            strcat(saystring, (STRPTR) LLL(MSG_PRESS_HELP_FOR_INFO, "Press Help for info."));
#ifdef __AROS__
            strcat(saystring, " [F11]");
#endif
        }
        strcpy(oldupper, saystring);
        uppercolour = whichcolour;
    } else
    {   // assert(position == LOWER);
        strcpy(oldlower, saystring);
        lowercolour = whichcolour;
    }

    resay();
}

EXPORT void hint(CONST_STRPTR thehint1, CONST_STRPTR thehint2)
{   sprintf
    (   thehint,
        "%s%s,%s%s",
        LLL(MSG_LMB, "LMB="),
        thehint1,
#ifdef __AROS__
        LLL(MSG_RMB, "M/RMB="),
#else
        LLL(MSG_RMB, "RMB="),
#endif
        thehint2
    );
    hint1len = strlen(thehint1);

    resay();
}

MODULE void resay(void)
{   SetAPen(&OffScreenRastPort, remapit[BLACK]);
    RectFill
    (   &OffScreenRastPort,
        0,
        MESSAGEY - 2,
        639,
        MESSAGEY + 27
    );

    SetDrMd(&OffScreenRastPort, JAM1);

    SetAPen(&OffScreenRastPort, remapit[uppercolour]);
    Move(&OffScreenRastPort, 4, MESSAGEY + 6);
    DISCARD Text(&OffScreenRastPort, oldupper, strlen(oldupper));

    SetAPen(&OffScreenRastPort, remapit[lowercolour]);
    Move(&OffScreenRastPort, 4, MESSAGEY + 16);
    if (strlen(oldlower) > 79)
    {   DISCARD Text(&OffScreenRastPort, oldlower, 79);
        Move(&OffScreenRastPort, 4, MESSAGEY + 26);
        DISCARD Text(&OffScreenRastPort, &oldlower[79], (ULONG) strlen(oldlower) - 79);
    } else
    {   DISCARD Text(&OffScreenRastPort, oldlower, strlen(oldlower));
    }

    Move(&OffScreenRastPort, 640 - 4 - ((18 + hint1len) * fontx), MESSAGEY + 26);
    DISCARD Text(&OffScreenRastPort, thehint, strlen(thehint));

    // bottom corners get obliterated and thus need this redoing here
    if
    (   DisplayWidth  >  SCREENXPIXEL
     && DisplayHeight >  SCREENYPIXEL
    )
    {   // assert(customscreen);

        SetAPen(&OffScreenRastPort, 110);
        WritePixel(&OffScreenRastPort, 0,                SCREENYPIXEL - 1);
        WritePixel(&OffScreenRastPort, SCREENXPIXEL - 1, SCREENYPIXEL - 1);
    }

    updatescreen();
}

EXPORT SLONG getevent(SLONG mode, UBYTE whichcolour)
{   TRANSIENT UWORD                code,
                                   qual;
    TRANSIENT ULONG                class;
    TRANSIENT struct IntuiMessage* MsgPtr;
    TRANSIENT LONG                 country;
    TRANSIENT SLONG                counter,
                                   ticks = 0;
    TRANSIENT WORD                 mousex, mousey;
    TRANSIENT struct MenuItem*     ItemPtr;
    PERSIST   SLONG                cheat = 0;
    PERSIST   FLAG                 wasdown = FALSE;
#ifdef __amigaos4__
    TRANSIENT int                  rc;
#endif

    /* return codes:
    -4: Escape
    -3: spacebar
    -2: backspace
    -1: invalid country */

    switch (mode)
    {
    case ANYKEY:
        hint
        (   LLL(MSG_OK,       "OK"),
            LLL(MSG_OK,       "OK")
        );
    acase YNKEYBOARD:
        hint
        (   LLL(MSG_YES,      "Yes"),
            LLL(MSG_NO,       "No")
        );
    acase GLKEYBOARD:
        hint
        (   LLL(MSG_GLORY,    "Glory"),
            LLL(MSG_LUCK,     "Luck")
        );
    acase WRKEYBOARD:
        hint
        (   LLL(MSG_WITHDRAW, "Withdraw"),
            LLL(MSG_RESTART,  "Restart")
        );
    /* adefault:
        Routines which use MULTIKEYBOARD or COUNTER or COUNTRY or GAMEOVERSCREEN must call hint() themselves */
    }

    clearkybd_gt(MainWindowPtr);

    for (;;)
    {   if
        (   Wait
            (   MainSignal
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(MainWindowPtr->UserPort)))
        {   class  = MsgPtr->Class;
            code   = MsgPtr->Code;
            mousex = MsgPtr->MouseX;
            mousey = MsgPtr->MouseY;
            qual   = MsgPtr->Qualifier;
            if (class == IDCMP_MENUVERIFY && code == MENUHOT && mousey > ScreenPtr->BarHeight) // this is no mistake
            {   if (!(qual & IEQUALIFIER_RCOMMAND))
                {   MsgPtr->Code = MENUCANCEL;
            }   }
            if (morphos && MsgPtr->Code == MENUCANCEL) // workaround for a MOS bug
            {   ReplyMsg((struct Message*) MsgPtr);
            } else
            {   GT_ReplyIMsg(MsgPtr);
            }

            switch (class)
            {
            case IDCMP_CLOSEWINDOW:
                cleanexit(EXIT_SUCCESS);
            acase IDCMP_ACTIVEWINDOW:
                ignore = 2; // ignore 2 messages (SELECTDOWN then SELECTUP)
            acase IDCMP_REFRESHWINDOW:
                GT_BeginRefresh(MainWindowPtr);
                GT_EndRefresh(MainWindowPtr, TRUE);
            acase IDCMP_MOUSEBUTTONS:
                // assert(!(qual & IEQUALIFIER_REPEAT)); // does this even have meaning for mousebuttons?
                if (code == SELECTDOWN || code == SELECTUP)
                {   if (ignore)
                    {   ignore--;
                    } elif (code == SELECTUP && wasdown)
                    {   wasdown = FALSE;
                    } else
                    {   if (code == SELECTDOWN)
                        {   wasdown = TRUE;
                        }

                        /* Some screen coords are apparently still affected by the invisible disabled GadTools gadgets behind
                        them; in these cases we won't receive the SELECTDOWN, only the SELECTUP */

                        if
                        (   mode != GAMEOVERSCREEN
                         && ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                        )
                        {   counter = checkcounters(mousex, mousey);
                            if (counter == -1)
                            {   country = getcountry(mousex, mousey);
                                if (country >= 0)
                                {   countertype = KINGDOM;
                                    infowindow(country);
                                } else
                                {   summarywindow();
                            }   }
                            else
                            {   infowindow(counter);
                        }   }
                        else
                        {   switch (mode)
                            {
                            case MULTIKEYBOARD:
                            case ANYKEY:
                            case GAMEOVERSCREEN:
                                return '0';
                            acase YNKEYBOARD:
                                return onekey[ONEKEY_YES];
                            acase GLKEYBOARD:
                                return onekey[ONEKEY_GLORY];
                            acase WRKEYBOARD:
                                return onekey[ONEKEY_WITHDRAW];
                            acase COUNTER:
                            case COUNTRY:
                                if (mousey >= (WORD) TOPGAP + MESSAGEY)
                                {   return -3;
                                }
                                counter = checkcounters(mousex, mousey);
                                if (counter == -1)
                                {   country = getcountry(mousex, mousey);
                                    countertype = KINGDOM;
                                    return country;
                                } else
                                {   if (mode == COUNTER)
                                    {   return counter;
                                    }
                                    // assert(mode == COUNTRY);
                                    switch (countertype)
                                    {
                                    case HERO:     return     hero[counter].where;
                                    case JARL:     return     jarl[counter].where;
                                    case MONSTER:  return  monster[counter].where;
                                    case SORD:     return     sord[counter].where;
                                    case TREASURE: return treasure[counter].where;
                }   }   }   }   }   }
                elif (code == MIDDLEDOWN || code == MENUUP)
                {   if (mode == MULTIKEYBOARD)
                    {   return '0';
                    } elif (mode == YNKEYBOARD)
                    {   return onekey[ONEKEY_NO];
                    } elif (mode == GLKEYBOARD)
                    {   return onekey[ONEKEY_LUCK];
                    } elif (mode == WRKEYBOARD)
                    {   return onekey[ONEKEY_RESTART];
                    } else
                    {   return -3;
                }   }
            acase IDCMP_INTUITICKS:
                if (mode == GAMEOVERSCREEN)
                {   break;
                }
                if (mode == ANYKEY && tickspeed[speed] != -1)
                {   ticks++;
                    if (ticks >= tickspeed[speed])
                    {   return -3;
                }   }
                counter = checkcounters(mousex, mousey);
                if (counter == -1)
                {   country = getcountry(mousex, mousey);
                    countertype = KINGDOM;
                    showcountry(country);
                } else
                {   switch (countertype)
                    {
                    case HERO:
                        DISCARD saywho(HERO, counter, FALSE, FALSE);
                        strcat(saystring, "(");
                        stcl_d(numberstring, hero[counter].strength);
                        strcat(saystring, numberstring);
                        strcat(saystring, "-");
                        stcl_d(numberstring, hero[counter].moves);
                        strcat(saystring, numberstring);
                        strcat(saystring, ")");
                        say(UPPER, FIRSTHEROCOLOUR + counter);
                    acase JARL:
                        if (jarl[counter].face == FACEDOWN)
                        {   strcpy(saystring, LLL(MSG_UNKNOWN_JARL, "Unknown jarl"));
                            strcat(saystring, " (?-?)");
                        } else
                        {   DISCARD saywho(JARL, counter, FALSE, FALSE);
                            strcat(saystring, "(");
                            stcl_d(numberstring, jarl[counter].strength);
                            strcat(saystring, numberstring);
                            strcat(saystring, "-");
                            stcl_d(numberstring, jarl[counter].moves);
                            strcat(saystring, numberstring);
                            strcat(saystring, ")");
                        }
                        if (jarl[counter].hero == -1)
                        {   say(UPPER, WHITE);
                        } else
                        {   say(UPPER, FIRSTHEROCOLOUR + jarl[counter].hero);
                        }
                    acase MONSTER:
                        strcpy(saystring, monstertypes[monster[counter].species]);
                        strcat(saystring, " ");
                        strcat(saystring, monster[counter].name);
                        strcat(saystring, " (");
                        stcl_d(numberstring, monster[counter].strength);
                        strcat(saystring, numberstring);
                        strcat(saystring, "-");
                        stcl_d(numberstring, monster[counter].moves);
                        strcat(saystring, numberstring);
                        strcat(saystring, ")");
                        say(UPPER, WHITE);
                    acase TREASURE:
                        strcpy(saystring, LLL(MSG_THE, "The"));
                        strcat(saystring, " ");
                        strcat(saystring, treasure[counter].name);
                        strcat(saystring, " ");
                        strcat(saystring, LLL(MSG_TREASURE2, "treasure"));
                        say(UPPER, WHITE);
                    acase SORD:
                        strcpy(saystring, LLL(MSG_SWORD, "Sword"));
                        strcat(saystring, " ");
                        strcat(saystring, sord[counter].name);
                        say(UPPER, WHITE);
                }   }
            acase IDCMP_VANILLAKEY:
                if ((code == ' ' || code == 13) && mode == ANYKEY)
                {   return -3;
                } elif (code == 27) // Escape
                {   if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                    {   cleanexit(EXIT_SUCCESS);
                    } elif (mode == MULTIKEYBOARD)
                    {   return -4;
                    } elif (mode == YNKEYBOARD)
                    {   return onekey[ONEKEY_NO];
                    } elif (mode == GLKEYBOARD)
                    {   return onekey[ONEKEY_LUCK];
                    } elif (mode == WRKEYBOARD)
                    {   return onekey[ONEKEY_RESTART];
                    } else
                    {   return -3;
                }   }
                elif
                (    mode == MULTIKEYBOARD
                 ||  mode == GLKEYBOARD
                 ||  mode == YNKEYBOARD
                 ||  mode == WRKEYBOARD
                 ||  mode == ANYKEY
                 ||  mode == GAMEOVERSCREEN
                )
                {   code = (UWORD) toupper((int) code);
                    return (SLONG) code;
                } elif (code == 8) // backspace
                {   return -2;
                }
            acase IDCMP_RAWKEY:
                if (mode == GAMEOVERSCREEN)
                {   return 0;
                }
                switch (code)
                {
                case SCAN_HELP:
                    if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                    {   summarywindow();
                    } else
                    {   counter = checkcounters(mousex, mousey);
                        if (counter == -1)
                        {   country = getcountry(mousex, mousey);
                            if (country >= 0)
                            {   countertype = KINGDOM;
                                infowindow(country);
                            } else
                            {   summarywindow();
                        }   }
                        else
                        {   infowindow(counter);
                    }   }
                adefault:
                    if
                    (   (    mode == MULTIKEYBOARD
                         || (mode == ANYKEY && tickspeed[speed] == -1)
                        )
                     &&  code < KEYUP
                     && (code < FIRSTQUALIFIER || code > LASTQUALIFIER)
                    )
                    {   if (code == SCAN_F1 + cheat)
                        {   cheat++;
                            if (cheat == 5)
                            {   cheat = 0;
                                hero[BEOWULF].luck = 5000;
                                DisplayBeep(ScreenPtr);
                        }   }
                        else cheat = 0;
                }   }
            acase IDCMP_MENUPICK:
                while (code != MENUNULL)
                {   ItemPtr = ItemAddress(MenuPtr, code);

                    switch (MENUNUM(code))
                    {
                    case MN_PROJECT:
                        switch (ITEMNUM(code))
                        {
                        case IN_NEW:
                            return -4;
                        case IN_SAVE:
                            savegame(FALSE, FALSE);
                        acase IN_SAVEAS:
                            savegame(TRUE, FALSE);
                        acase IN_QUITTITLE:
                            return -4;
                        acase IN_QUITDOS:
                            cleanexit(EXIT_SUCCESS);
                        }
                    acase MN_SETTINGS:
                        switch (ITEMNUM(code))
                        {
                        case IN_SHOW_TITLEBAR:
                            if (ItemPtr->Flags & CHECKED)
                            {   titlebar = TRUE;
                            } else
                            {   titlebar = FALSE;
                            }
                            ShowTitle(ScreenPtr, titlebar);
                        acase IN_WATCH_AMIGA:
                            watchamiga = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
                        }
                    acase MN_HELP:
                        switch (ITEMNUM(code))
                        {
                        case  IN_GAME_SUMMARY: summarywindow();
                        acase IN_HELP_1:       docwindow(1);
                        acase IN_HELP_2:       docwindow(2);
                        acase IN_HELP_3:       docwindow(3);
                        acase IN_HELP_4:       docwindow(4);
                        acase IN_MANUAL:       help_manual();
                        acase IN_ABOUT:        help_about();
                    }   }
                    code = ItemPtr->NextSelect;
        }   }   }

#ifdef __amigaos4__
        rc = handle_applibport(FALSE);
        if (rc == 1 || rc == 3)
        {   cleanexit(EXIT_SUCCESS);
        }
#endif
}   }

MODULE void newgame(void)
{   SLONG whichhero, whichjarl, whichmonster, whichcountry, whichslot,
          whichtreasure, whichsord;

    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_NEW,          NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_OPEN,         NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,         NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,       NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE,    NOSUB));
     OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP,    IN_GAME_SUMMARY, NOSUB));
    if (AmigaGuideBase)
    {   OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_MANUAL,       NOSUB));
    }

    pathname[0] = EOS;

    /* 0. SET UP

    "Divide the counters into four piles, keeping the heroes separate.
    The four piles, all face down, should be: monsters of all sorts,
    jarls, magic weapons [(swords)], and magic treasures.

    Each player picks a hero counter to represent him or her in the game.
    Players roll dice if two or more people want the same counter, and
    high roll chooses first." */

    reset_images();
    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   hero[whichhero].strength  = HERO_STRENGTH;
        hero[whichhero].moves     = HERO_MOVES;
        hero[whichhero].name      = trueheroname[whichhero];
        hero[whichhero].attacking =
        hero[whichhero].defending =
        hero[whichhero].alive     = FALSE;
        hero[whichhero].verydead  = TRUE;
        hero[whichhero].glory     =
        hero[whichhero].luck      =
        hero[whichhero].wealth    = 0;
        hero[whichhero].rune      = -1;
        deselect_hero(whichhero, FALSE);
        remove_hero(whichhero, FALSE);
    }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   jarl[whichjarl].hero      = -1;
        jarl[whichjarl].wealth    = 0;
        jarl[whichjarl].attacking =
        jarl[whichjarl].defending =
        jarl[whichjarl].alive     =
        jarl[whichjarl].taken     = FALSE;
        deselect_jarl(whichjarl, FALSE);
        remove_jarl(whichjarl, FALSE);
    }
    for (whichmonster = 0; whichmonster <= MONSTERS; whichmonster++)
    {   monster[whichmonster].alive = FALSE;
        monster[whichmonster].taken = FALSE;
        deselect_monster(whichmonster, FALSE);
        remove_monster(whichmonster, FALSE);
    }
    for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
    {   remove_treasure(whichtreasure, FALSE);
        treasure[whichtreasure].taken         = FALSE;
        treasure[whichtreasure].possessor     =
        treasure[whichtreasure].possessortype =
        treasure[whichtreasure].where         = -1;
    }
    for (whichsord = 0; whichsord <= SORDS; whichsord++)
    {   remove_sord(whichsord, FALSE);
        sord[whichsord].taken         = FALSE;
        sord[whichsord].possessor     =
        sord[whichsord].possessortype =
        sord[whichsord].where         = -1;
    }

    for (whichcountry = 0; whichcountry <= 65; whichcountry++)
    {   world[whichcountry].hero = -1;
        world[whichcountry].is   = FALSE;
        for (whichslot = 0; whichslot <= SLOTS; whichslot++)
        {   world[whichcountry].slot[whichslot] = FALSE;
    }   }

    SetAPen(&OffScreenRastPort, remapit[BLACK]);
    RectFill
    (   &OffScreenRastPort,
        0,
        0,
        SCREENXPIXEL - 1,
        SCREENYPIXEL - 1
    );
    darken();
    updatescreen(); // this calls drawmap() for us

    turn = 1;
    faxirides = 3;

    /* "Each player then picks a magic sword at random from the face-down
    pile. Magic swords will not be given out again in the game and so all
    of the left-over magic swords are put aside until the next game." */

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if (hero[whichhero].control != NONE)
        {   /* "Heroes begin the game in a randomly determined area (found in the
            same manner as monsters are placed). This area should be noted on the
            record sheet, as it is sometimes necessary to know a hero's home
            country." */
            newhero(whichhero, TRUE);
    }   }

    place_monsters();
    place_jarls();
    updatescreen();
}

MODULE void titlescreen(void)
{   SLONG whichhero;
    TEXT  sgtext[40 + 1];

    loaded      =
    gameaborted = FALSE;
    ignore      = 0;

     OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_NEW,          NOSUB));
     OnMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_OPEN,         NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,         NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,       NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE,    NOSUB));
    OffMenu(MainWindowPtr, FULLMENUNUM(MN_HELP,    IN_GAME_SUMMARY, NOSUB));
    if (AmigaGuideBase)
    {   OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP, IN_MANUAL,       NOSUB));
    }

    SetWindowTitles(MainWindowPtr, TITLEBAR, TITLEBAR); // this is not copied, it is a pointer

    clearscreen();
    drawlogo();
    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   GT_SetGadgetAttrs(CycleGadgetPtr[whichhero], MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_DONE);
    }
    GT_SetGadgetAttrs(SpeedGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, FALSE,                          TAG_DONE);
    GT_SetGadgetAttrs(TurnsGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, FALSE,                          TAG_DONE);
    GT_SetGadgetAttrs(AdvancedGadgetPtr, MainWindowPtr, NULL, GA_Disabled, FALSE,                          TAG_DONE);
    GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
    RefreshGadgets(GListPtr, MainWindowPtr, NULL);

    SetDrMd(MainWindowPtr->RPort, JAM1);
    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
        shadowtext
        (   MainWindowPtr->RPort,
            cycleheroname[whichhero],
            FIRSTHEROCOLOUR + whichhero,
            LEFTGAP + 292 - (strlen(cycleheroname[whichhero]) * fontx),
            TOPGAP  + 219 + (whichhero * 13)
        );
        shadowtext
        (   MainWindowPtr->RPort,
            "_",
            FIRSTHEROCOLOUR + whichhero,
            LEFTGAP + 292 - (strlen(cycleheroname[whichhero]) * fontx) + (cycleheropos[whichhero] * fontx),
            TOPGAP  + 219 + (whichhero * 13) + 1
        );
    }

    strcpy(sgtext, LLL(MSG_MESSAGE_DELAY, "Message Delay:"));
    shadowtext
    (   MainWindowPtr->RPort,
        sgtext,
        WHITE,
        LEFTGAP + 292 - (strlen(sgtext) * fontx),
        TOPGAP  + 316
    );
    strcpy(sgtext, LLL(MSG_TURNS, "Turns:"));
    shadowtext
    (   MainWindowPtr->RPort,
        sgtext,
        WHITE,
        LEFTGAP + 292 - (strlen(sgtext) * fontx),
        TOPGAP  + 330
    );
    strcpy(sgtext, LLL(MSG_ADVANCED_MODE, "Advanced Mode?"));
    shadowtext
    (   MainWindowPtr->RPort,
        sgtext,
        WHITE,
        LEFTGAP + 292 - (strlen(sgtext) * fontx),
        TOPGAP  + 357
    );

    changespeed();
    changeturns();

    if (cliload)
    {   if (Exists(pathname))
        {   if (loadgame(FALSE))
            {   loaded = TRUE;
                ScreenToFront(ScreenPtr);
            } else
            {   cliload = FALSE;
        }   }
        elif (strlen(pathname) <= 5 || stricmp(&pathname[strlen(pathname) - 5], ".saga"))
        {   strcat(pathname, ".saga");
            if (loadgame(FALSE))
            {   loaded = TRUE;
                ScreenToFront(ScreenPtr);
            } else
            {   cliload = FALSE;
        }   }
        else
        {   cliload = FALSE;
    }   }

    if (!cliload)
    {   titlescreen_loop();
    }

    cliload = FALSE;
    if (!loaded)
    {   for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   GT_SetGadgetAttrs(CycleGadgetPtr[whichhero], MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        }
        GT_SetGadgetAttrs(SpeedGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(TurnsGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(AdvancedGadgetPtr, MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
}   }

EXPORT FLAG loadgame(FLAG aslwindow)
{   SLONG offset = 12, whichhero, whichjarl, whichmonster, whichcountry,
          whichslot, whichtreasure, whichsord;
    TEXT  newpathname[MAX_PATH + 1];
    BPTR  FileHandle /* = ZERO */ ;
    FLAG  ok;
    int   i;

    if (aslwindow)
    {   if
        (   AslRequestTags
            (    ASLRqPtr,
                 ASL_Hail,          (ULONG) LLL(MSG_LOAD_GAME, "Load Game"),
                 ASL_FuncFlags,     FILF_PATGAD,
                 ASLFR_RejectIcons, TRUE,
            TAG_DONE)
         && *(ASLRqPtr->rf_File)
        )
        {   strcpy(newpathname, ASLRqPtr->rf_Dir);
            DISCARD AddPart(newpathname, ASLRqPtr->rf_File, MAX_PATH);
            ok = TRUE;
        } else
        {   ok = FALSE;
        }

        // ASL requester wrecks the colours under MOS, so this is needed...
        if (customscreen)
        {   LoadRGB32(&(ScreenPtr->ViewPort), table1);
            LoadRGB32(&(ScreenPtr->ViewPort), table2);
            LoadRGB32(&(ScreenPtr->ViewPort), table3);
            darken();
    }   }
    else
    {   ok = TRUE;
        strcpy(newpathname, pathname);
    }

    if (ok)
    {   /* strcpy(saystring, LLL(MSG_LOADING, "Loading"));
        strcat(saystring, " ");
        strcat(saystring, newpathname);
        strcat(saystring, "...");
        say(LOWER, WHITE); */

        if (!(FileHandle = Open(newpathname, MODE_OLDFILE)))
        {   strcpy(saystring, LLL(MSG_CANT_OPEN, "Can't open"));
            strcat(saystring, " ");
            strcat(saystring, newpathname);
            strcat(saystring, " ");
            strcat(saystring, LLL(MSG_FOR_READING, "for reading"));
            strcat(saystring, "!");
            msg();
            return FALSE;
        }

        // read file
        if (Read(FileHandle, IOBuffer, SAVELENGTH) != SAVELENGTH)
        {   DISCARD Close(FileHandle);
            // FileHandle = NULL;
            strcpy(saystring, LLL(MSG_CANT_READ_FROM, "Can't read from"));
            strcat(saystring, " ");
            strcat(saystring, newpathname);
            strcat(saystring, "!");
            msg();
            return FALSE;
        }

        if (strcmp((char*) IOBuffer, "SAGA 1.80"))
        {   DISCARD Close(FileHandle);
            // FileHandle = NULL;
            strcpy(saystring, newpathname);
            strcat(saystring, " ");
            strcat(saystring, LLL(MSG_I_N_A_V_S_G_F, "is not a valid saved game file"));
            strcat(saystring, "!");
            msg();
            return FALSE;
        }

        for (whichmonster = 0; whichmonster <= MONSTERS; whichmonster++)
        {   deselect_monster(whichmonster, FALSE);
            remove_monster(whichmonster, FALSE);
        }
        for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
        {   remove_treasure(whichtreasure, FALSE);
        }

        turn      = (SLONG) ((SBYTE) IOBuffer[10]);
        faxirides = (SLONG) ((SBYTE) IOBuffer[11]);

        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   hero[whichhero].control   = (SLONG) ((SBYTE) IOBuffer[offset++] );
            hero[whichhero].alive     = (FLAG)  ((SBYTE) IOBuffer[offset++] );
            hero[whichhero].verydead  = (FLAG)  ((SBYTE) IOBuffer[offset++] );
            hero[whichhero].moves     = (SLONG) ((SBYTE) IOBuffer[offset++] );
            hero[whichhero].god       = (SLONG) ((SBYTE) IOBuffer[offset++] );
            hero[whichhero].rune      = (SLONG) ((SBYTE) IOBuffer[offset++] );
            hero[whichhero].where     = (SLONG) ((SBYTE) IOBuffer[offset++] );
            hero[whichhero].homewhere = (SLONG) ((SBYTE) IOBuffer[offset++] );
            hero[whichhero].promoted  = (SLONG) ((SBYTE) IOBuffer[offset++] );
            hero[whichhero].wounded   = (FLAG)  ((SBYTE) IOBuffer[offset++] );
            hero[whichhero].wealth    = (SLONG) ((IOBuffer[offset    ] * 256) + IOBuffer[offset + 1]);
            hero[whichhero].glory     = (SLONG) ((IOBuffer[offset + 2] * 256) + IOBuffer[offset + 3]);
            hero[whichhero].luck      = (SLONG) ((IOBuffer[offset + 4] * 256) + IOBuffer[offset + 5]);
            offset += 6;
            hero[whichhero].sea       = (SLONG) ((SBYTE) IOBuffer[offset++]);
            hero[whichhero].loseturn  = (FLAG)  ((SBYTE) IOBuffer[offset++]);
            hero[whichhero].maidens   = (SLONG) ((SBYTE) IOBuffer[offset++]);
        }
        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   jarl[whichjarl].where     = (SLONG) ((SBYTE) IOBuffer[offset++]);
            jarl[whichjarl].homewhere = (SLONG) ((SBYTE) IOBuffer[offset++]);
            jarl[whichjarl].face      = (SLONG) ((SBYTE) IOBuffer[offset++]);
            jarl[whichjarl].hero      = (SLONG) ((SBYTE) IOBuffer[offset++]);
            jarl[whichjarl].taken     = (FLAG)  ((SBYTE) IOBuffer[offset++]);
            jarl[whichjarl].sea       = (SLONG) ((SBYTE) IOBuffer[offset++]);
            jarl[whichjarl].loseturn  = (FLAG)  ((SBYTE) IOBuffer[offset++]);
            jarl[whichjarl].alive     = (FLAG)  ((SBYTE) IOBuffer[offset++]);
        }
        for (whichmonster = 0; whichmonster <= MONSTERS; whichmonster++)
        {   monster[whichmonster].taken    = (FLAG)  ((SBYTE) IOBuffer[offset++]);
            monster[whichmonster].alive    = (FLAG)  ((SBYTE) IOBuffer[offset++]);
            monster[whichmonster].where    = (SLONG) ((SBYTE) IOBuffer[offset++]);
            monster[whichmonster].wealth   = (SLONG) ((SBYTE) IOBuffer[offset++]);
            monster[whichmonster].sea      = (SLONG) ((SBYTE) IOBuffer[offset++]);
            offset++; // skip monster[].loseturn
        }
        for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
        {   treasure[whichtreasure].taken         = (FLAG)  ((SBYTE) IOBuffer[offset++]);
            treasure[whichtreasure].possessor     = (FLAG)  ((SBYTE) IOBuffer[offset++]);
            treasure[whichtreasure].possessortype = (SLONG) ((SBYTE) IOBuffer[offset++]);
            treasure[whichtreasure].where         = (SLONG) ((SBYTE) IOBuffer[offset++]);
        }
        for (whichsord = 0; whichsord <= SORDS; whichsord++)
        {   sord[whichsord].taken         = (FLAG)  ((SBYTE) IOBuffer[offset++]);
            sord[whichsord].possessor     = (FLAG)  ((SBYTE) IOBuffer[offset++]);
            sord[whichsord].possessortype = (SLONG) ((SBYTE) IOBuffer[offset++]);
            sord[whichsord].where         = (SLONG) ((SBYTE) IOBuffer[offset++]);
        }
        for (whichcountry = 0; whichcountry <= 35; whichcountry++)
        {   world[whichcountry].hero = (SLONG) ((SBYTE) IOBuffer[offset++]);
            world[whichcountry].is   = (FLAG)  ((SBYTE) IOBuffer[offset++]);
        }
        advanced = (FLAG)  ((SBYTE) IOBuffer[offset++]);
        turns    = (SLONG) ((SBYTE) IOBuffer[offset++]);
        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   for (i = 1; i <= 99; i++)
            {   hero[whichhero].score[i]  = (SLONG) (IOBuffer[offset++] * 256);
                hero[whichhero].score[i] += (SLONG) (IOBuffer[offset++]      );
        }   }

        DISCARD Close(FileHandle);
        // FileHandle = NULL;

        strcpy(pathname, newpathname);

        if (advanced)
        {   treasures = ADVANCEDTREASURES;
            monsters  = ADVANCEDMONSTERS;
        } else
        {   treasures = BASICTREASURES;
            monsters  = BASICMONSTERS;
        }

        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   GT_SetGadgetAttrs(CycleGadgetPtr[whichhero], MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        }
        GT_SetGadgetAttrs(SpeedGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(TurnsGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(AdvancedGadgetPtr, MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
        GT_SetGadgetAttrs(StartGadgetPtr,    MainWindowPtr, NULL, GA_Disabled, TRUE, TAG_DONE);
     // RefreshGadgets(GListPtr, MainWindowPtr, NULL); seems not to be needed?

        for (whichcountry = 0; whichcountry <= 65; whichcountry++)
        {   for (whichslot = 0; whichslot <= SLOTS; whichslot++)
            {   world[whichcountry].slot[whichslot] = FALSE;
        }   }

        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   if (hero[whichhero].promoted == -1)
            {   hero[whichhero].name     = trueheroname[whichhero];
                hero[whichhero].strength = HERO_STRENGTH;
                hero[whichhero].moves    = HERO_MOVES;
            } else
            {   hero[whichhero].name     = jarl[hero[whichhero].promoted].name;
                hero[whichhero].strength = jarl[hero[whichhero].promoted].strength;
                hero[whichhero].moves    = jarl[hero[whichhero].promoted].moves;
            }
            deselect_hero(whichhero, FALSE);
            if (hero[whichhero].alive)
            {   move_hero(whichhero, FALSE);
            } else
            {   remove_hero(whichhero, FALSE);
        }   }

        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   jarl[whichjarl].recruitable = FALSE;
            if (jarl[whichjarl].alive)
            {   if (jarl[whichjarl].face == FACEUP)
                {   revealjarl(whichjarl, FALSE);
                } else
                {   // assert(jarl[whichjarl].face == FACEDOWN);
                    hidejarl(whichjarl, FALSE);
                }
                move_jarl(whichjarl, FALSE);
            } else
            {   remove_jarl(whichjarl, FALSE);
        }   }
        for (whichmonster = 0; whichmonster <= MONSTERS; whichmonster++)
        {   if (monster[whichmonster].alive)
            {   move_monster(whichmonster, FALSE);
        }   }

        for (whichtreasure = 0; whichtreasure <= treasures; whichtreasure++)
        {   if (treasure[whichtreasure].possessor == -1 && treasure[whichtreasure].where >= 0)
            {   move_treasure(whichtreasure, FALSE);
        }   }
        for (whichsord = 0; whichsord <= SORDS; whichsord++)
        {   if (sord[whichsord].possessor == -1 && sord[whichsord].where >= 0)
            {   move_sord(whichsord, FALSE);
            } else
            {   remove_sord(whichsord, FALSE);
        }   }

        clearscreen();
        SetAPen(&OffScreenRastPort, remapit[BLACK]);
        RectFill(&OffScreenRastPort, 0, 0, 639, 511);
        darken();
        updatescreen();

        if (faxirides == -1)
        {   faxirides = 0;
            treasure_disappear(FREYFAXI);
        }

        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_NEW,          NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_OPEN,         NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVE,         NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_SAVEAS,       NOSUB));
        OffMenu(MainWindowPtr, FULLMENUNUM(MN_PROJECT, IN_QUITTITLE,    NOSUB));
         OnMenu(MainWindowPtr, FULLMENUNUM(MN_HELP,    IN_GAME_SUMMARY, NOSUB));

        strcpy(saystring, LLL(MSG_LOADED, "Loaded"));
        strcat(saystring, " ");
        strcat(saystring, pathname);
        strcat(saystring, ".");
        say(LOWER, WHITE);
        return TRUE;
    } // implied else

    return FALSE;
}

MODULE void savegame(FLAG saveas, FLAG autosaving)
{   SLONG offset = 12, whichhero, whichjarl, whichmonster, whichcountry,
          whichtreasure, whichsord;
    FLAG  cont = TRUE;
    TEXT  newpathname[MAX_PATH + 1];
    BPTR  FileHandle /* = ZERO */ ;
    int   i;

    if (autosaving)
    {   strcpy(newpathname, "PROGDIR:Autosave.saga");
    } else
    {   strcpy(newpathname, pathname);
    }

    if (saveas || newpathname[0] == EOS)
    {   if
        (   AslRequestTags
            (   ASLRqPtr,
                ASL_Hail,          (ULONG) LLL(MSG_SAVE_GAME, "Save Game"),
                ASL_FuncFlags,     FILF_PATGAD | FILF_SAVE,
                ASLFR_RejectIcons, TRUE,
            TAG_DONE)
         && *(ASLRqPtr->rf_File) != 0
        )
        {   strcpy(newpathname, ASLRqPtr->rf_Dir);
            DISCARD AddPart(newpathname, ASLRqPtr->rf_File, MAX_PATH);
        } else
        {   cont = FALSE;
        }

        // ASL requester wrecks the colours under MOS, so this is needed...
        if (customscreen)
        {   LoadRGB32(&(ScreenPtr->ViewPort), table1);
            LoadRGB32(&(ScreenPtr->ViewPort), table2);
            LoadRGB32(&(ScreenPtr->ViewPort), table3);
            darken();
    }   }
    if (!cont)
    {   return;
    }

    if
    (   strlen(newpathname) < 5
     || stricmp(&newpathname[strlen(newpathname) - 5], ".saga")
    )
    {   strcat(newpathname, ".saga");
    }

    if (!autosaving)
    {   strcpy(saystring, LLL(MSG_SAVING, "Saving"));
        strcat(saystring, " ");
        strcat(saystring, newpathname);
        strcat(saystring, "...");
        say(LOWER, WHITE);
    }

    if (!(FileHandle = Open(newpathname, MODE_NEWFILE)))
    {   strcpy(saystring, LLL(MSG_CANT_OPEN, "Can't open"));
        strcat(saystring, " ");
        strcat(saystring, newpathname);
        strcat(saystring, " ");
        strcat(saystring, LLL(MSG_FOR_WRITING, "for writing"));
        strcat(saystring, "!");
        say(LOWER, WHITE);
        anykey();
        return;
    }

    /* write header
       SAGA 1.55*#%
       012345678901
       where * is NUL (EOS) byte and # is turn and % is faxi rides */

    strcpy((char*) IOBuffer, "SAGA 1.80");
    IOBuffer[10] = (UBYTE) turn;
    IOBuffer[11] = (UBYTE) faxirides;

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   IOBuffer[offset++] = (UBYTE) hero[whichhero].control;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].alive;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].verydead;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].moves;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].god;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].rune;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].where;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].homewhere;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].promoted;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].wounded;
        IOBuffer[offset++] = (UBYTE) (hero[whichhero].wealth / 256);
        IOBuffer[offset++] = (UBYTE) (hero[whichhero].wealth % 256);
        IOBuffer[offset++] = (UBYTE) (hero[whichhero].glory  / 256);
        IOBuffer[offset++] = (UBYTE) (hero[whichhero].glory  % 256);
        IOBuffer[offset++] = (UBYTE) (hero[whichhero].luck   / 256);
        IOBuffer[offset++] = (UBYTE) (hero[whichhero].luck   % 256);
        IOBuffer[offset++] = (UBYTE) hero[whichhero].sea;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].loseturn;
        IOBuffer[offset++] = (UBYTE) hero[whichhero].maidens;
    }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   IOBuffer[offset++] = (UBYTE) jarl[whichjarl].where;
        IOBuffer[offset++] = (UBYTE) jarl[whichjarl].homewhere;
        IOBuffer[offset++] = (UBYTE) jarl[whichjarl].face;
        IOBuffer[offset++] = (UBYTE) jarl[whichjarl].hero;
        IOBuffer[offset++] = (UBYTE) jarl[whichjarl].taken;
        IOBuffer[offset++] = (UBYTE) jarl[whichjarl].sea;
        IOBuffer[offset++] = (UBYTE) jarl[whichjarl].loseturn;
        IOBuffer[offset++] = (UBYTE) jarl[whichjarl].alive;
    }
    for (whichmonster = 0; whichmonster <= MONSTERS; whichmonster++)
    {   IOBuffer[offset++] = (UBYTE) monster[whichmonster].taken;
        IOBuffer[offset++] = (UBYTE) monster[whichmonster].alive;
        IOBuffer[offset++] = (UBYTE) monster[whichmonster].where;
        IOBuffer[offset++] = (UBYTE) monster[whichmonster].wealth;
        IOBuffer[offset++] = (UBYTE) monster[whichmonster].sea;
        IOBuffer[offset++] = (UBYTE) 0; // skip monster loseturn
    }
    for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
    {   IOBuffer[offset++] = (UBYTE) treasure[whichtreasure].taken;
        IOBuffer[offset++] = (UBYTE) treasure[whichtreasure].possessor;
        IOBuffer[offset++] = (UBYTE) treasure[whichtreasure].possessortype;
        IOBuffer[offset++] = (UBYTE) treasure[whichtreasure].where;
    }
    for (whichsord = 0; whichsord <= SORDS; whichsord++)
    {   IOBuffer[offset++] = (UBYTE) sord[whichsord].taken;
        IOBuffer[offset++] = (UBYTE) sord[whichsord].possessor;
        IOBuffer[offset++] = (UBYTE) sord[whichsord].possessortype;
        IOBuffer[offset++] = (UBYTE) sord[whichsord].where;
    }
    for (whichcountry = 0; whichcountry <= 35; whichcountry++)
    {   IOBuffer[offset++] = (UBYTE) world[whichcountry].hero;
        IOBuffer[offset++] = (UBYTE) world[whichcountry].is;
    }
    IOBuffer[offset++] = (UBYTE) advanced;
    IOBuffer[offset++] = (UBYTE) turns;
    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   for (i = 1; i <= 99; i++)
        {   IOBuffer[offset++] = (UBYTE) (hero[whichhero].score[i] / 256);
            IOBuffer[offset++] = (UBYTE) (hero[whichhero].score[i] % 256);
    }   }

#ifdef EXTRAVERBOSE
    DISCARD Printf("%ld bytes written.\n", offset);
#endif

    if (Write(FileHandle, IOBuffer, offset) != offset)
    {   DISCARD Close(FileHandle);
        // FileHandle = NULL;
        strcpy(saystring, LLL(MSG_CANT_WRITE_TO, "Can't write to"));
        strcat(saystring, " ");
        strcat(saystring, newpathname);
        strcat(saystring, "!");
        say(LOWER, WHITE);
        anykey();
        return;
    }

    DISCARD Close(FileHandle);
    // FileHandle = NULL;

    if (!autosaving)
    {   strcpy(pathname, newpathname);

        strcpy(saystring, LLL(MSG_SAVED, "Saved"));
        strcat(saystring, " ");
        strcat(saystring, pathname);
        strcat(saystring, ".");
        say(LOWER, WHITE);
        // no need for anykey(), as there is one when we return anyway.
}   }

EXPORT void darken(void)
{   SLONG whichcountry, colour;

    for (whichcountry = 0; whichcountry <= 35; whichcountry++)
    {   colour = whichcountry + 32;
        if (customscreen || gotpen[colour])
        {   if (world[whichcountry].is)
            {   SetRGB4(&ScreenPtr->ViewPort, remapit[colour], 12, 12, 12); // light grey ice
            } elif (world[whichcountry].hero != -1)
            {   SetRGB4
                (   &ScreenPtr->ViewPort,
                    remapit[colour],
                    herocolour[world[whichcountry].hero].red,
                    herocolour[world[whichcountry].hero].green,
                    herocolour[world[whichcountry].hero].blue
                );
            } else
            {   SetRGB4
                (   &ScreenPtr->ViewPort,
                    remapit[colour],
                    taxcolours[world[whichcountry].tax].red,
                    taxcolours[world[whichcountry].tax].green,
                    taxcolours[world[whichcountry].tax].blue
                );
}   }   }   }

MODULE SLONG getcountry(WORD mousex, WORD mousey)
{   int   wordwidth,
          x, xx, y;
    SLONG country;

    mousex -= (LEFTGAP +  9);
    mousey -= (TOPGAP  + 12);
    if (mousex < 0 || mousex >= 623 || mousey < 0 || mousey >= 467)
    {   return -1;
    }

    wordwidth = 623 / 16;
    if (623 % 16) wordwidth++;
    xx = mousex % 16;
    x  = mousex / 16;
    y  = mousey     ;
    // get the country of this pixel
    country = 0;
    if (OriginalMapData[(((467 * 0) + y) * wordwidth) + x] & (32768 >> xx)) country++;
    if (OriginalMapData[(((467 * 1) + y) * wordwidth) + x] & (32768 >> xx)) country +=  2;
    if (OriginalMapData[(((467 * 2) + y) * wordwidth) + x] & (32768 >> xx)) country +=  4;
    if (OriginalMapData[(((467 * 3) + y) * wordwidth) + x] & (32768 >> xx)) country +=  8;
    if (OriginalMapData[(((467 * 4) + y) * wordwidth) + x] & (32768 >> xx)) country += 16;
    if (OriginalMapData[(((467 * 5) + y) * wordwidth) + x] & (32768 >> xx)) country += 32;
    if (OriginalMapData[(((467 * 6) + y) * wordwidth) + x] & (32768 >> xx)) country += 64;

    if     (country >= 32 && country <= 97)
    {   country -= 32;
    } elif (country ==  98 || country ==  99)
    {   country = 11; // Scandia
    } elif (country == 100 || country == 101)
    {   country = 30; // Pictland
    } elif (country == 102 || country == 103)
    {   country = 31; // Hebrides
    } else country = -1;

    return country;
}

MODULE void infowindow(SLONG whichcounter)
{   SLONG lines,
          leftlines     = 0,
          rightlines    = 0,
          oldwhichline,
          whichline,
          whichcountry,
          whichjarl,
          whichhero,
          whichtreasure,
          whichsord,
          wide,
          whichmonster;
    FLAG  counterrow    = FALSE,
          ok;

    switch (countertype)
    {
    case HERO:
        sprintf(label[0],  "%s:", LLL(MSG_HERO_NAME,       "Hero Name"      ));
        sprintf(label[1],  "%s:", LLL(MSG_CONTROL,         "Control"        ));
        sprintf(label[2],  "%s:", LLL(MSG_COMBAT_STRENGTH, "Combat Strength"));
        sprintf(label[3],  "%s:", LLL(MSG_MOVEMENT_FACTOR, "Movement Factor"));
        sprintf(label[4],  "%s:", LLL(MSG_GLORY,           "Glory"          ));
        sprintf(label[5],  "%s:", LLL(MSG_LUCK,            "Luck"           ));
        sprintf(label[6],  "%s:", LLL(MSG_WEALTH,          "Wealth"         ));
        sprintf(label[8],  "%s:", LLL(MSG_HOMELAND,        "Homeland"       ));
        sprintf(label[9],  "%s:", LLL(MSG_MAIDENS,         "Maidens"        ));
        sprintf(label[10], "%s:", LLL(MSG_RUNE,            "Rune"           ));
        sprintf(label[11], "%s:", LLL(MSG_SWORD,           "Sword"          ));
        sprintf(label[12], "%s:", LLL(MSG_STATUS,          "Status"         ));
        sprintf(label[13], "%s:", LLL(MSG_GOD,             "God"            ));

        /* If labels beyond [13] are desired, the labels[] array will of
        course to be redimensioned. */

        strcpy(line[LEFTSIDE][0], hero[whichcounter].name);
        if (hero[whichcounter].control == HUMAN)
        {   strcpy(line[LEFTSIDE][1], LLL(MSG_HUMAN, "Human"));
        } else
        {   // assert(hero[whichcounter].control == CONTROL_AMIGA);
            strcpy(line[LEFTSIDE][1], "Amiga");
        }
        sprintf
        (   line[LEFTSIDE][2], "%ld (%ld/%ld)",
            hero[whichcounter].strength,
            getstrength(HERO, whichcounter, FALSE),
            getstrength(HERO, whichcounter, TRUE)
        );
        sprintf
        (   line[LEFTSIDE][3], "%ld (%ld)",
            hero[whichcounter].moves,
            getusualmoves(HERO, whichcounter)
        );
        sprintf(line[LEFTSIDE][4], "%ld", hero[whichcounter].glory);
        sprintf(line[LEFTSIDE][5], "%ld", hero[whichcounter].luck);
        sprintf(line[LEFTSIDE][6], "%ld", hero[whichcounter].wealth);
        print_location(hero[whichcounter].where, 7);
        sprintf
        (   line[LEFTSIDE][8], "%s (%ld)",
            world[hero[whichcounter].homewhere].name,
            world[hero[whichcounter].homewhere].tax
        );
        sprintf(line[LEFTSIDE][9], "%ld", hero[whichcounter].maidens);
        if (hero[whichcounter].rune == -1)
        {   strcpy(line[LEFTSIDE][10], LLL(MSG_NONE, "None"));
        } else
        {   strcpy(line[LEFTSIDE][10], rune[hero[whichcounter].rune].name);
        }
        ok = FALSE;
        for (whichsord = 0; whichsord <= SORDS; whichsord++)
        {   if
            (   sord[whichsord].possessortype == HERO
             && sord[whichsord].possessor == whichcounter
            )
            {   ok = TRUE;
                counterrow = TRUE;
                strcpy(line[LEFTSIDE][11], sord[whichsord].name);
                break; // for speed
        }   }
        if (!ok)
        {   strcpy(line[LEFTSIDE][11], LLL(MSG_NONE, "None"));
        }

        if (!hero[whichcounter].wounded)
        {   strcpy(line[LEFTSIDE][12], LLL(MSG_HEALTHY, "Healthy"));
        } else
        {   strcpy(line[LEFTSIDE][12], LLL(MSG_WOUNDED, "Wounded"));
        }

        switch (hero[whichcounter].god)
        {
        case ODIN:
            strcpy(line[LEFTSIDE][13], "Odin");
        acase THOR:
            strcpy(line[LEFTSIDE][13], "Thor");
        acase TYR:
            strcpy(line[LEFTSIDE][13], "Tyr");
        adefault:
            strcpy(line[LEFTSIDE][13], LLL(MSG_NONE, "None"));
        }

        print_paralyzed(hero[whichcounter].loseturn, 14);
           print_hagall(hero[whichcounter].hagall,   15);
              print_sea(hero[whichcounter].sea,      16);
           print_routed(hero[whichcounter].routed,   17);
        leftlines = 18; // counting from 1

        strcpy(line[RIGHTSIDE][0], LLL(MSG_RECRUITED_JARLS, "Recruited Jarls"));
        strcat(line[RIGHTSIDE][0], ":");

        whichline = oldwhichline = 1; // whichline always points to the NEXT line.
        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if (jarl[whichjarl].alive && jarl[whichjarl].hero == whichcounter)
            {   strcpy(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], jarl[whichjarl].name);
                strcat(line[RIGHTSIDE][whichline], " (");
                stcl_d(numberstring, jarl[whichjarl].strength);
                strcat(line[RIGHTSIDE][whichline], numberstring);
                strcat(line[RIGHTSIDE][whichline], "-");
                stcl_d(numberstring, jarl[whichjarl].moves);
                strcat(line[RIGHTSIDE][whichline], numberstring);
                strcat(line[RIGHTSIDE][whichline], ")");
                whichline++;
        }   }
        if (whichline == oldwhichline)
        {   strcpy(line[RIGHTSIDE][whichline], " ");
            strcat(line[RIGHTSIDE][whichline], LLL(MSG_NONE, "None"));
            whichline++;
        }

        strcpy(line[RIGHTSIDE][whichline], "");
        whichline++;
        strcpy(line[RIGHTSIDE][whichline], LLL(MSG_CONQUERED_KINGDOMS, "Conquered Kingdoms"));
        strcat(line[RIGHTSIDE][whichline], ":");
        whichline++;

        oldwhichline = whichline;
        for (whichcountry = 0; whichcountry <= 35; whichcountry++)
        {   if (world[whichcountry].hero == whichcounter)
            {   strcpy(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], world[whichcountry].name);
                strcat(line[RIGHTSIDE][whichline], " (");
                stcl_d(numberstring, world[whichcountry].tax);
                strcat(line[RIGHTSIDE][whichline], numberstring);
                strcat(line[RIGHTSIDE][whichline], ")");
                whichline++;
        }   }
        if (whichline == oldwhichline)
        {   strcpy(line[RIGHTSIDE][whichline], " ");
            strcat(line[RIGHTSIDE][whichline], LLL(MSG_NONE, "None"));
            whichline++;
        }

        strcpy(line[RIGHTSIDE][whichline], "");
        whichline++;
        strcpy(line[RIGHTSIDE][whichline], LLL(MSG_MAGIC_TREASURES, "Magic Treasures"));
        strcat(line[RIGHTSIDE][whichline], ":");
        whichline++;

        oldwhichline = whichline;
        for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
        {   if (treasure[whichtreasure].possessortype == HERO
             && treasure[whichtreasure].possessor     == whichcounter
            )
            {   counterrow = TRUE;
                strcpy(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], treasure[whichtreasure].name);
                if (whichtreasure == FREYFAXI)
                {   strcat(line[RIGHTSIDE][whichline], " (");
                    stcl_d(numberstring, faxirides);
                    strcat(line[RIGHTSIDE][whichline], numberstring);
                    strcat(line[RIGHTSIDE][whichline], " ");
                    if (faxirides != 1)
                    {   strcat(line[RIGHTSIDE][whichline], LLL(MSG_RIDES2, "rides"));
                    } else
                    {   strcat(line[RIGHTSIDE][whichline], LLL(MSG_RIDE,   "ride"));
                    }
                    strcat(line[RIGHTSIDE][whichline], ")");
                }
                whichline++;
        }   }
        if (whichline == oldwhichline)
        {   strcpy(line[RIGHTSIDE][whichline], " ");
            strcat(line[RIGHTSIDE][whichline], LLL(MSG_NONE, "None"));
            whichline++;
        }

        rightlines = whichline;
    acase MONSTER:
        sprintf(label[ 0], "%s:", LLL(MSG_MONSTER_NAME,    "Monster Name"   ));
        sprintf(label[ 1], "%s:", LLL(MSG_MONSTER_SPECIES, "Monster Species"));
        sprintf(label[ 2], "%s:", LLL(MSG_COMBAT_STRENGTH, "Combat Strength"));
        sprintf(label[ 3], "%s:", LLL(MSG_MOVEMENT_FACTOR, "Movement Factor"));
        sprintf(label[ 4], "%s:", LLL(MSG_WEALTH,          "Wealth"         ));
        sprintf(label[ 8], "%s?", LLL(MSG_TREASURE,        "Treasure"       ));
        sprintf(label[ 9], "%s:", LLL(MSG_GLORY,           "Glory"          ));
        sprintf(label[10], "%s:", LLL(MSG_LUCK,            "Luck"           ));

        strcpy(line[LEFTSIDE][0], monster[whichcounter].name);
        strcpy(line[LEFTSIDE][1], monstertypes[monster[whichcounter].species]);
        sprintf
        (   line[LEFTSIDE][2],
            "%ld (%ld/%ld)",
            monster[whichcounter].strength,
            getstrength(MONSTER, whichcounter, FALSE),
            getstrength(MONSTER, whichcounter, TRUE)
        );
        sprintf
        (   line[LEFTSIDE][3],
            "%ld (%ld)",
            monster[whichcounter].moves,
            getusualmoves(MONSTER, whichcounter)
        );
        sprintf(line[LEFTSIDE][4], "%ld", monster[whichcounter].wealth);
        print_location(monster[whichcounter].where, 5);
        print_hagall(monster[whichcounter].hagall, 6);
        print_sea(monster[whichcounter].sea, 7);
        ok = FALSE;
        for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
        {   if
            (   treasure[whichtreasure].possessortype == MONSTER
             && treasure[whichtreasure].possessor == whichcounter
            )
            {   ok = TRUE;
                break;
        }   }
        if (ok)
        {   strcpy(line[LEFTSIDE][8], LLL(MSG_YES, "Yes"));
        } else
        {   strcpy(line[LEFTSIDE][8], LLL(MSG_NO, "No"));
        }
        sprintf(line[LEFTSIDE][ 9], "%d", monster[whichcounter].glory);
        sprintf(line[LEFTSIDE][10], "%d", monster[whichcounter].luck);

        leftlines = 11; // counting from 1
        rightlines = 0;
    acase JARL:
        sprintf(label[0], "%s:", LLL(MSG_JARL_NAME,       "Jarl Name"      ));
        sprintf(label[1], "%s:", LLL(MSG_HERO,            "Hero"           ));
        sprintf(label[2], "%s:", LLL(MSG_COMBAT_STRENGTH, "Combat Strength"));
        sprintf(label[3], "%s:", LLL(MSG_MOVEMENT_FACTOR, "Movement Factor"));
        sprintf(label[4], "%s:", LLL(MSG_WEALTH,          "Wealth"         ));
        sprintf(label[6], "%s:", LLL(MSG_HOMELAND,        "Homeland"       ));
        sprintf(label[7], "%s:", LLL(MSG_SWORD,           "Sword"          ));

        if (jarl[whichcounter].face == FACEUP)
        {   strcpy(line[LEFTSIDE][0], jarl[whichcounter].name);
        } else
        {   strcpy(line[LEFTSIDE][0], LLL(MSG_UNKNOWN, "Unknown"));
        }
        if (jarl[whichcounter].hero == -1)
        {   strcpy(line[LEFTSIDE][1], LLL(MSG_KING_NONE, "None"));
        } else
        {   strcpy(line[LEFTSIDE][1], hero[jarl[whichcounter].hero].name);
        }
        if (jarl[whichcounter].face == FACEUP)
        {   sprintf
            (   line[LEFTSIDE][2], "%ld (%ld/%ld)",
                jarl[whichcounter].strength,
                getstrength(JARL, whichcounter, FALSE),
                getstrength(JARL, whichcounter, TRUE)
            );
        } else
        {   // assert(jarl[whichcounter].face == FACEDOWN);
            strcpy(line[LEFTSIDE][2], LLL(MSG_UNKNOWN, "Unknown"));
        }
        if (jarl[whichcounter].face == FACEUP)
        {   sprintf
            (   line[LEFTSIDE][3], "%ld (%ld)",
                jarl[whichcounter].moves,
                getusualmoves(JARL, whichcounter)
            );
        } else
        {   // assert(jarl[whichcounter].face == FACEDOWN);
            strcpy(line[LEFTSIDE][3], LLL(MSG_UNKNOWN, "Unknown"));
        }
        sprintf(line[LEFTSIDE][4], "%ld", jarl[whichcounter].wealth);
        print_location(jarl[whichcounter].where, 5);
        sprintf
        (   line[LEFTSIDE][6], "%s (%ld)",
            world[jarl[whichcounter].homewhere].name,
            world[jarl[whichcounter].homewhere].tax
        );
        ok = FALSE;
        for (whichsord = 0; whichsord <= SORDS; whichsord++)
        {   if
            (   sord[whichsord].possessortype == JARL
             && sord[whichsord].possessor == whichcounter
            )
            {   ok = TRUE;
                counterrow = TRUE;
                strcpy(line[LEFTSIDE][7], sord[whichsord].name);
                break; // for speed
        }   }
        if (!ok)
        {   strcpy(line[LEFTSIDE][7], LLL(MSG_NONE, "None"));
        }
        print_paralyzed(jarl[whichcounter].loseturn, 8);
        print_hagall(jarl[whichcounter].hagall, 9);
        print_sea(jarl[whichcounter].sea, 10);
        print_routed(jarl[whichcounter].routed, 11);
        leftlines = 12; // counting from 1

        strcpy(line[RIGHTSIDE][0], LLL(MSG_MAGIC_TREASURES, "Magic Treasures"));
        strcat(line[RIGHTSIDE][0], ":");
        whichline = oldwhichline = 1; // whichline always points to the NEXT line.
        for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
        {   if (treasure[whichtreasure].possessortype == JARL
             && treasure[whichtreasure].possessor     == whichcounter
            )
            {   counterrow = TRUE;
                strcpy(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], treasure[whichtreasure].name);
                if (whichtreasure == FREYFAXI)
                {   strcat(line[RIGHTSIDE][whichline], " (");
                    stcl_d(numberstring, faxirides);
                    strcat(line[RIGHTSIDE][whichline], numberstring);
                    strcat(line[RIGHTSIDE][whichline], " ");
                    strcat(line[RIGHTSIDE][whichline], LLL(MSG_RIDES2, "rides"));
                    strcat(line[RIGHTSIDE][whichline], ")");
                }
                whichline++;
        }   }
        if (whichline == oldwhichline)
        {   strcpy(line[RIGHTSIDE][whichline], " ");
            strcat(line[RIGHTSIDE][whichline], LLL(MSG_NONE, "None"));
            whichline++;
        }

        rightlines = whichline;
    acase TREASURE:
        strcpy(line[LEFTSIDE][0], LLL(MSG_TREASURE_NAME, "Treasure Name"));
        strcat(line[LEFTSIDE][0], ":");
        pad(line[LEFTSIDE][0]);
        strcat(line[LEFTSIDE][0], treasure[whichcounter].name);

        strcpy(line[LEFTSIDE][1], LLL(MSG_LOCATION, "Location"));
        strcat(line[LEFTSIDE][1], ":");
        pad(line[LEFTSIDE][1]);
        strcat(line[LEFTSIDE][1], world[treasure[whichcounter].where].name);

        strcpy(line[LEFTSIDE][2], LLL(MSG_RIDES, "Rides"));
        strcat(line[LEFTSIDE][2], ":");
        pad(line[LEFTSIDE][2]);
        if (whichcounter == FREYFAXI)
        {   // assert(faxirides != -1);
            stcl_d(numberstring, faxirides);
            strcat(line[LEFTSIDE][2], numberstring);
        } else
        {   strcat(line[LEFTSIDE][2], LLL(MSG_N_A, "n/a"));
        }

        line[LEFTSIDE][3][0] = EOS; // blank line
        switch (whichcounter)
        {
        case BROSUNGNECKLACE:
            strcpy(line[LEFTSIDE][4],  LLL(MSG_NECKLACE_1, "This treasure is worth 20 marks. It may"  ));
            strcpy(line[LEFTSIDE][5],  LLL(MSG_NECKLACE_2, "be traded for any item in a dragon's"     ));
            strcpy(line[LEFTSIDE][6],  LLL(MSG_NECKLACE_3, "hoard. The wearer moves into the area"    ));
            strcpy(line[LEFTSIDE][7],  LLL(MSG_NECKLACE_4, "adjacent to that of the dragon, and gives"));
            strcpy(line[LEFTSIDE][8],  LLL(MSG_NECKLACE_5, "it to the dragon while taking what the"   ));
            strcpy(line[LEFTSIDE][9],  LLL(MSG_NECKLACE_6, "dragon had. The wearer may then see what" ));
            strcpy(line[LEFTSIDE][10], LLL(MSG_NECKLACE_7, "he had traded for."                       ));
            leftlines = 11;
        acase FREYFAXI:
            strcpy(line[LEFTSIDE][4],  LLL(    MSG_FAXI_1, "This treasure is a magic horse that can"  ));
            strcpy(line[LEFTSIDE][5],  LLL(    MSG_FAXI_2, "be ridden only 3 times. It doubles the"   ));
            strcpy(line[LEFTSIDE][6],  LLL(    MSG_FAXI_3, "rider's movement factor."                 ));
            leftlines = 7;
        acase MAGICSHIRT:
            strcpy(line[LEFTSIDE][4],  LLL(   MSG_SHIRT_1, "It adds +1 to the combat strength of the" ));
            strcpy(line[LEFTSIDE][5],  LLL(   MSG_SHIRT_2, "wearer when he is defending. It also adds"));
            strcpy(line[LEFTSIDE][6],  LLL(   MSG_SHIRT_3, "+1 to the movement factor of the wearer." ));
            leftlines = 7;
        acase MAILCOAT:
            strcpy(line[LEFTSIDE][4],  LLL(    MSG_COAT_1, "It adds +2 to the combat strength of the" ));
            strcpy(line[LEFTSIDE][5],  LLL(    MSG_COAT_2, "wearer, but only when the wearer is"      ));
            strcpy(line[LEFTSIDE][6],  LLL(    MSG_COAT_3, "defending."                               ));
            leftlines = 7;
        acase HEALINGPOTION:
            strcpy(line[LEFTSIDE][4],  LLL(  MSG_POTION_1, "This treasure can be used only once. It"  ));
            strcpy(line[LEFTSIDE][5],  LLL(  MSG_POTION_2, "will heal any wounds that the hero is"    ));
            strcpy(line[LEFTSIDE][6],  LLL(  MSG_POTION_3, "suffering."                               ));
            leftlines = 7;
        acase INVISIBILITYRING:
            strcpy(line[LEFTSIDE][4],  LLL(    MSG_RING_1, "The ring gives a half chance of avoiding" ));
            strcpy(line[LEFTSIDE][5],  LLL(    MSG_RING_2, "a combat, when its wearer is being"       ));
            strcpy(line[LEFTSIDE][6],  LLL(    MSG_RING_3, "attacked."                                ));
            leftlines = 7;
        acase MAGICCROWN:
            strcpy(line[LEFTSIDE][4],  LLL(   MSG_CROWN_1, "There is a half chance per turn per"      ));
            strcpy(line[LEFTSIDE][5],  LLL(   MSG_CROWN_2, "kingdom that an abandoned kingdom will"   ));
            strcpy(line[LEFTSIDE][6],  LLL(   MSG_CROWN_3, "remain loyal to the crown's wearer."      ));
            leftlines = 7;
        acase TELEPORTSCROLL:
            strcpy(line[LEFTSIDE][4],  LLL(  MSG_SCROLL_1, "This treasure can be used only once. It"  ));
            strcpy(line[LEFTSIDE][5],  LLL(  MSG_SCROLL_2, "will teleport the user to any desired"    ));
            strcpy(line[LEFTSIDE][6],  LLL(  MSG_SCROLL_3, "location."                                ));
            leftlines = 7;
        }

        rightlines = 0;
    acase KINGDOM:
        strcpy(line[LEFTSIDE][0], LLL(MSG_KINGDOM_NAME, "Kingdom Name"));
        strcat(line[LEFTSIDE][0], ":");
        pad(line[LEFTSIDE][0]);
        strcat(line[LEFTSIDE][0], world[whichcounter].name);

        strcpy(line[LEFTSIDE][1], LLL(MSG_KING, "King"));
        strcat(line[LEFTSIDE][1], ":");
        pad(line[LEFTSIDE][1]);
        if (world[whichcounter].hero == -1)
        {   strcat(line[LEFTSIDE][1], LLL(MSG_KING_NONE, "None"));
        } else
        {   strcat(line[LEFTSIDE][1], hero[world[whichcounter].hero].name);
        }

        strcpy(line[LEFTSIDE][2], LLL(MSG_TAXATION_FACTOR, "Taxation Factor"));
        strcat(line[LEFTSIDE][2], ":");
        pad(line[LEFTSIDE][2]);
        stcl_d(numberstring, world[whichcounter].tax);
        strcat(line[LEFTSIDE][2], numberstring);

        strcpy(line[LEFTSIDE][3], LLL(MSG_TYPE, "Type"));
        strcat(line[LEFTSIDE][3], ":");
        pad(line[LEFTSIDE][3]);
        if (world[whichcounter].type == LAND)
        {   strcat(line[LEFTSIDE][3], LLL(MSG_LAND, "Land"));
        } elif (world[whichcounter].type == ISLE)
        {   strcat(line[LEFTSIDE][3], LLL(MSG_ISLAND, "Island"));
        } elif (world[whichcounter].type == SEA)
        {   strcat(line[LEFTSIDE][3], LLL(MSG_SEA, "Sea"));
        } else
        {   // assert(world[whichcounter].type == PENINSULA);
            strcat(line[LEFTSIDE][3], LLL(MSG_PENINSULA, "Peninsula"));
        }

        strcpy(line[LEFTSIDE][4], "Is (");
        strcat(line[LEFTSIDE][4], LLL(MSG_ICE, "ice"));
        strcat(line[LEFTSIDE][4], ")?");
        pad(line[LEFTSIDE][4]);
        if (world[whichcounter].is)
        {   strcat(line[LEFTSIDE][4], LLL(MSG_YES, "Yes"));
        } else
        {   strcat(line[LEFTSIDE][4], LLL(MSG_NO, "No"));
        }

        leftlines = 5; // counting from 1

        strcpy(line[RIGHTSIDE][0], LLL(MSG_CONTENTS, "Contents"));
        strcat(line[RIGHTSIDE][0], ":");

        whichline = oldwhichline = 1; // whichline always points to the NEXT line.
        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   if (hero[whichhero].alive && hero[whichhero].where == whichcounter)
            {   strcpy(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], LLL(MSG_HERO, "Hero"));
                strcat(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], hero[whichhero].name);
                strcat(line[RIGHTSIDE][whichline], " (");
                stcl_d(numberstring, hero[whichhero].strength);
                strcat(line[RIGHTSIDE][whichline], numberstring);
                strcat(line[RIGHTSIDE][whichline], "-");
                stcl_d(numberstring, hero[whichhero].moves);
                strcat(line[RIGHTSIDE][whichline], numberstring);
                strcat(line[RIGHTSIDE][whichline], ")");
                whichline++;
        }   }
        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if (jarl[whichjarl].alive && jarl[whichjarl].where == whichcounter)
            {   strcpy(line[RIGHTSIDE][whichline], " ");
                if (jarl[whichjarl].face == FACEUP)
                {   strcat(line[RIGHTSIDE][whichline], LLL(MSG_JARL, "Jarl"));
                    strcat(line[RIGHTSIDE][whichline], " ");
                    strcat(line[RIGHTSIDE][whichline], jarl[whichjarl].name);
                    strcat(line[RIGHTSIDE][whichline], " (");
                    stcl_d(numberstring, jarl[whichjarl].strength);
                    strcat(line[RIGHTSIDE][whichline], numberstring);
                    strcat(line[RIGHTSIDE][whichline], "-");
                    stcl_d(numberstring, jarl[whichjarl].moves);
                    strcat(line[RIGHTSIDE][whichline], numberstring);
                    strcat(line[RIGHTSIDE][whichline], ")");
                } else
                {   strcat(line[RIGHTSIDE][whichline], LLL(MSG_UNKNOWN_JARL, "Unknown jarl"));
                    strcat(line[RIGHTSIDE][whichline], " (?-?)");
                }
                whichline++;
        }   }
        for (whichmonster = 0; whichmonster <= MONSTERS; whichmonster++)
        {   if (monster[whichmonster].alive && monster[whichmonster].where == whichcounter)
            {   strcpy(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], monstertypes[monster[whichmonster].species]);
                strcat(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], monster[whichmonster].name);
                strcat(line[RIGHTSIDE][whichline], " (");
                stcl_d(numberstring, monster[whichmonster].strength);
                strcat(line[RIGHTSIDE][whichline], numberstring);
                strcat(line[RIGHTSIDE][whichline], "-");
                stcl_d(numberstring, monster[whichmonster].moves);
                strcat(line[RIGHTSIDE][whichline], numberstring);
                strcat(line[RIGHTSIDE][whichline], ")");
                whichline++;
        }   }
        for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
        {   if
            (   treasure[whichtreasure].possessortype == KINGDOM
             && treasure[whichtreasure].where == whichcounter
            )
            {   strcpy(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], LLL(MSG_THE, "The"));
                strcat(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], treasure[whichtreasure].name);
                whichline++;
        }   }
        for (whichsord = 0; whichsord <= SORDS; whichsord++)
        {   if
            (   sord[whichsord].possessortype == KINGDOM
             && sord[whichsord].where == whichcounter
            )
            {   strcpy(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], LLL(MSG_SWORD, "Sword"));
                strcat(line[RIGHTSIDE][whichline], " ");
                strcat(line[RIGHTSIDE][whichline], sord[whichsord].name);
                whichline++;
        }   }

        if (whichline == oldwhichline)
        {   strcpy(line[RIGHTSIDE][whichline], " ");
            strcat(line[RIGHTSIDE][whichline], LLL(MSG_NONE, "None"));
            whichline++;
        }

        rightlines = whichline;
    acase SORD:
        strcpy(line[LEFTSIDE][0], LLL(MSG_SWORD_NAME, "Sword Name"));
        strcat(line[LEFTSIDE][0], ":");
        pad(line[LEFTSIDE][0]);
        strcat(line[LEFTSIDE][0], sord[whichcounter].name);

        strcpy(line[LEFTSIDE][1], LLL(MSG_LOCATION, "Location"));
        strcat(line[LEFTSIDE][1], ":");
        pad(line[LEFTSIDE][1]);
        strcat(line[LEFTSIDE][1], world[sord[whichcounter].where].name);

        line[LEFTSIDE][2][0] = EOS; // blank line
        switch (whichcounter)
        {
        case BALMUNG:
            strcpy(line[LEFTSIDE][3], LLL( MSG_BALMUNG_1, "In any fight where its wielder is"        ));
            strcpy(line[LEFTSIDE][4], LLL( MSG_BALMUNG_2, "attacking an enemy wearing magic armour," ));
            strcpy(line[LEFTSIDE][5], LLL( MSG_BALMUNG_3, "it cancels out the benefit of the magic"  ));
            strcpy(line[LEFTSIDE][6], LLL( MSG_BALMUNG_4, "armour. Thus, the Mail Coat and the Magic"));
            strcpy(line[LEFTSIDE][7], LLL( MSG_BALMUNG_5, "Shirt provide no protection against it."  ));
            leftlines = 8;
        acase HRUNTING:
            strcpy(line[LEFTSIDE][3], LLL(MSG_HRUNTING_1, "The other side must flee instead when the"));
            strcpy(line[LEFTSIDE][4], LLL(MSG_HRUNTING_2, "combat result would be that the wielder's"));
            strcpy(line[LEFTSIDE][5], LLL(MSG_HRUNTING_3, "side must flee."                          ));
            leftlines = 6;
        acase LOVI:
            strcpy(line[LEFTSIDE][3], LLL(    MSG_LOVI_1, "In any battle against a side including"   ));
            strcpy(line[LEFTSIDE][4], LLL(    MSG_LOVI_2, "jarls, it adds an additional +2 to the"   ));
            strcpy(line[LEFTSIDE][5], LLL(    MSG_LOVI_3, "wielder's combat factor."                 ));
            leftlines = 6;
        adefault:
            strcpy(line[LEFTSIDE][3], LLL(MSG_NO_SPECIAL_POWERS, "No special powers."));
            leftlines = 4;
        }

        rightlines = 0;
    }

    if (leftlines >= rightlines)
    {   lines = leftlines;
    } else
    {   lines = rightlines;
    }
    if (rightlines > 0)
    {   wide = 1;
    } else
    {   wide = 0;
    }

    if (!(InfoWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          (DisplayWidth  / 2) - ((360 + (280 * wide )) / 2),
        WA_Top,           (DisplayHeight / 2) - (( 30 + ( 10 * lines)) / 2),
        WA_InnerWidth,        360 + (280 * wide ),
        WA_InnerHeight,        14 + ( 10 * lines),
        WA_IDCMP,         IDCMP_CLOSEWINDOW | IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS,
        WA_Title,         (ULONG) LLL(MSG_INFORMATION, "Information"),
        WA_Gadgets,       NULL,
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_NoCareRefresh, TRUE,
        WA_Activate,      TRUE,
        WA_GimmeZeroZero, TRUE,
    TAG_DONE)))
    {   rq("Can't open subwindow!");
    }
    fillwindow(InfoWindowPtr);
    SetFont(InfoWindowPtr->RPort, FontPtr);
    SetDrMd(InfoWindowPtr->RPort, JAM1);

    if (countertype == HERO || countertype == JARL || countertype == MONSTER)
    {   for (whichline = 0; whichline < leftlines; whichline++)
        {   shadowtext
            (   InfoWindowPtr->RPort,
                label[whichline],
                WHITE,
                12,
                13 + (whichline * 10)
            );
            shadowtext
            (   InfoWindowPtr->RPort,
                line[LEFTSIDE][whichline],
                WHITE,
                12 + (22 * fontx),
                13 + (whichline * 10)
            );
    }   }
    else
    {   for (whichline = 0; whichline < leftlines; whichline++)
        {   shadowtext
            (   InfoWindowPtr->RPort,
                line[LEFTSIDE][whichline],
                WHITE,
                12,
                13 + (whichline * 10)
            );
    }   }

    if (wide)
    {   for (whichline = 0; whichline < rightlines; whichline++)
        {   shadowtext
            (   InfoWindowPtr->RPort,
                line[RIGHTSIDE][whichline],
                WHITE,
                360 + 12,
                13 + (whichline * 10)
            );
    }   }

    if (counterrow)
    {   info(whichcounter);
    }

    infoloop();
}

MODULE void summarywindow(void)
{   SLONG count,
          i, j,
          length,
          lines = 0,
          summaryheight;
    FLAG  nomore = FALSE,
          ok;
    ULONG linecolour[HEROES + 1];
    int   firstturn,
          histy,
          whichhero;

    strcpy(line[0][0], LLL(MSG_SUMMARYLINE, "Hero Name  C-M J K S T C S R Glry Luck $$$$"));

                     /* Hero Name  C-M J K S T C S R Glry Luck $$$$
                                   o o a i w r o t u
                                   m v r n o e n a n
                                   b e l g r a t t e
                                   a m s d d s r u
                                   t e   o   u o s
                                     n   m   r l
                                     t   s   e
                                             s

                        Heldenname K-B J K S S K S @ Ruhm Glck $$$$
                                   a e a ö c c o t @
                                   m w r n h h n a @
                                   p e l i w ä t t @
                                   f g s g e t r u @
                                     u   r r z o s @
                                     n   e t e l
                                     g   i     l
                                     s   c     e
                                         h
                                         e */

    for (i = 0; i <= HEROES; i++)
    {   if (hero[i].control != NONE)
        {   linecolour[lines] = FIRSTHEROCOLOUR + i;

            lines++;

            strcpy(line[0][lines], hero[i].name);

            length = (SLONG) strlen(hero[i].name);
            for (j = length; j < 11; j++)
            {   strcat(line[0][lines], " ");
            }

            stcl_d(numberstring, hero[i].strength);
            strcat(line[0][lines], numberstring);
            strcat(line[0][lines], "-");

            stcl_d(numberstring, hero[i].moves);
            strcat(line[0][lines], numberstring);
            strcat(line[0][lines], " ");

            count = 0;
            for (j = 0; j <= JARLS; j++)
            {   if (jarl[j].alive && jarl[j].hero == i)
                {   count++;
            }   }
            stcl_d(numberstring, count);
            strcat(line[0][lines], numberstring);
            strcat(line[0][lines], " ");

            count = 0;
            for (j = 0; j <= 35; j++)
            {   if (world[j].hero == i)
                {   count++;
            }   }
            stcl_d(numberstring, count);
            strcat(line[0][lines], numberstring);
            strcat(line[0][lines], " ");

            ok = FALSE;
            for (j = 0; j <= SORDS; j++)
            {   if
                (   sord[j].possessortype == HERO
                 && sord[j].possessor     == i
                )
                {   numberstring[0] = sord[j].name[0];
                    numberstring[1] = EOS;
                    strcat(line[0][lines], numberstring);
                    ok = TRUE;
                    break;
            }   }
            if (!ok)
            {   strcat(line[0][lines], "-");
            }
            strcat(line[0][lines], " ");

            count = 0;
            for (j = 0; j <= TREASURES; j++)
            {   if
                (   (   treasure[j].possessortype == HERO
                     && treasure[j].possessor     == i
                    )
                 || (   treasure[j].possessortype == JARL
                     && jarl[treasure[j].possessor].hero == i
                )   )
                {   count++;
            }   }
            stcl_d(numberstring, count);
            strcat(line[0][lines], numberstring);
            strcat(line[0][lines], " ");

            if (hero[i].control == HUMAN)
            {   strcat(line[0][lines], LLL(MSG_CHAR_HUMAN, "H"));
            } else
            {   // assert(hero[i].control == CONTROL_AMIGA);
                strcat(line[0][lines], "A");
            }
            strcat(line[0][lines], " ");

            if (!hero[i].alive)
            {   strcat(line[0][lines], LLL(MSG_CHAR_DEAD,    "D"));
            } elif (hero[i].wounded)
            {   strcat(line[0][lines], LLL(MSG_CHAR_WOUNDED, "W"));
            } else
            {   strcat(line[0][lines], LLL(MSG_CHAR_HEALTHY, "H"));
            }

            strcat(line[0][lines], " ");
            if (hero[i].rune == -1)
            {   strcat(line[0][lines], "-");
            } else
            {   numberstring[0] = rune[hero[i].rune].name[0];
                numberstring[1] = EOS;
                strcat(line[0][lines], numberstring);
            }

            stcl_d(numberstring, hero[i].glory);
            length = (SLONG) strlen(numberstring);
            for (j = length; j < 5; j++)
            {   strcat(line[0][lines], " ");
            }
            strcat(line[0][lines], numberstring);

            stcl_d(numberstring, hero[i].luck);
            length = (SLONG) strlen(numberstring);
            for (j = length; j < 5; j++)
            {   strcat(line[0][lines], " ");
            }
            strcat(line[0][lines], numberstring);

            count = hero[i].wealth;
            for (j = 0; j <= JARLS; j++)
            {   if (jarl[j].alive && jarl[j].hero == i)
                {   count += jarl[j].wealth;
            }   }
            stcl_d(numberstring, count);
            length = (SLONG) strlen(numberstring);
            for (j = length; j < 5; j++)
            {   strcat(line[0][lines], " ");
            }
            strcat(line[0][lines], numberstring);
    }   }

    line[0][++lines][0] = EOS;

    histy = 20 + (lines * 10);
    summaryheight = SUMMARYHEIGHT + (lines * 10) + HISTHEIGHT;

    if (!(InfoWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          (DisplayWidth  / 2) - (SUMMARYWIDTH  / 2),
        WA_Top,           (DisplayHeight / 2) - (summaryheight / 2),
        WA_InnerWidth,    SUMMARYWIDTH,
        WA_InnerHeight,   summaryheight,
        WA_IDCMP,         IDCMP_CLOSEWINDOW | IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS,
        WA_Title,         (ULONG) LLL(MSG_GAME_SUMMARY, "Game Summary"),
        WA_Gadgets,       NULL,
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_NoCareRefresh, TRUE,
        WA_Activate,      TRUE,
        WA_GimmeZeroZero, TRUE,
    TAG_DONE)))
    {   rq("Can't open subwindow!");
    }

    fillwindow(InfoWindowPtr);
    SetFont(InfoWindowPtr->RPort, FontPtr);
    SetDrMd(InfoWindowPtr->RPort, JAM1);

    shadowtext
    (   InfoWindowPtr->RPort,
        line[0][0],
        WHITE,
        12,
        13
    );
    shadowtext
    (   InfoWindowPtr->RPort,
        LLL(MSG_PILES, "Piles"),
        WHITE,
        374,
        13
    );

    // underline
    SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
    Move(InfoWindowPtr->RPort, 12                + 1, 16 + 1);
    Draw(InfoWindowPtr->RPort, SUMMARYWIDTH - 13 + 1, 16 + 1);
    SetAPen(InfoWindowPtr->RPort, remapit[WHITE]);
    Move(InfoWindowPtr->RPort, 12,                    16    );
    Draw(InfoWindowPtr->RPort, SUMMARYWIDTH - 13,     16    );

    for (i = 1; i <= lines; i++)
    {   shadowtext
        (   InfoWindowPtr->RPort,
            line[0][i],
            nomore ? WHITE : linecolour[i - 1],
            12,
            15 + (i * 10)
        );
        if (line[0][i][0] == EOS)
        {   nomore = TRUE;
    }   }

    count = 12;
    for (i = 0; i <= MONSTERS; i++)
    {   if (!monster[i].taken)
        {   count += 7;
    }   }
    for (i = MONSTERS; i >= 0; i--)
    {   if (!monster[i].taken)
        {   print_monster(374, count, i);
            count -= 7;
    }   }
    for (i = 0; i <= JARLS; i++)
    {   if (!jarl[i].taken)
        {   count += 7;
    }   }
    for (i = JARLS; i >= 0; i--)
    {   if (!jarl[i].taken)
        {   print_jarl(404, count, i);
            count -= 7;
    }   }
    for (i = 0; i <= TREASURES; i++)
    {   if (!treasure[i].taken)
        {   count += 7;
    }   }
    for (i = TREASURES; i >= 0; i--)
    {   if (!treasure[i].taken)
        {   print_treasure(434, count, i);
            count -= 7;
    }   }

    if (turn > 40)
    {   firstturn = turn - 40;
    } else
    {   firstturn = 0;
    }
    // lastturn = turn;

    SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
    RectFill(InfoWindowPtr->RPort, HISTX, histy, HISTX + HISTWIDTH, histy + HISTHEIGHT);
    DrawBevelBox // bevel box for window client area
    (   InfoWindowPtr->RPort,
        HISTX      - 1,
        histy      - 1,
        HISTWIDTH  + 2,
        HISTHEIGHT + 2,
        GT_VisualInfo, VisualInfoPtr,
        GTBB_Recessed, TRUE,
    TAG_END);

    for (i = 1; i <= 38; i++)
    {   SetAPen(InfoWindowPtr->RPort, remapit[i + firstturn == turns ? WHITE : DARKGREY]);
        Move(InfoWindowPtr->RPort, HISTX + (i * 9), histy             );
        Draw(InfoWindowPtr->RPort, HISTX + (i * 9), histy + HISTHEIGHT);
    }

    SetAPen(InfoWindowPtr->RPort, remapit[WHITE]);
    Move(InfoWindowPtr->RPort, HISTX            , histy + HISTHEIGHT - (15 * 2));
    Draw(InfoWindowPtr->RPort, HISTX + HISTWIDTH, histy + HISTHEIGHT - (15 * 2));

    // draw graph
    // up to 40 values (39 line segments) are displayed
    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if (hero[whichhero].control != NONE)
        {   if (turn)
            {   hero[whichhero].score[turn] = calcscore(whichhero);
            }
            SetAPen(InfoWindowPtr->RPort, remapit[FIRSTHEROCOLOUR + whichhero]);
            Move
            (   InfoWindowPtr->RPort,
                HISTX,
                histy + HISTHEIGHT - (hero[whichhero].score[firstturn] * 2)
            );

            for (i = 0; i < 39; i++)
            {   if (firstturn + i >= turn)
                {   break;
                }
                if (hero[whichhero].score[firstturn + i + 1] < 100)
                {   Draw
                    (   InfoWindowPtr->RPort,
                        HISTX + ((i + 1) * 9),
                        histy + HISTHEIGHT - (hero[whichhero].score[firstturn + i + 1] * 2)
                    );
                } else
                {   Draw
                    (   InfoWindowPtr->RPort,
                        HISTX + ((i + 1) * 9),
                        histy
                    );
    }   }   }   }

    infoloop();
}

EXPORT void updatescreen(void)
{   int wh,
        y;

    drawmap();

    for (y = 0; y < 512; y++)
    {   for (wh = 0; wh <= HEROES; wh++)
        {   if (hero[wh].xpixel != HIDDEN_X && hero[wh].ypixel == y)
            {   Counter.ImageData = hero[wh].image;
                DrawImage(&OffScreenRastPort, &Counter, hero[wh].xpixel, hero[wh].ypixel);
        }   }
        for (wh = 0; wh <= JARLS; wh++)
        {   if (jarl[wh].xpixel != HIDDEN_X && jarl[wh].ypixel == y)
            {   Counter.ImageData = jarl[wh].image;
                DrawImage(&OffScreenRastPort, &Counter, jarl[wh].xpixel, jarl[wh].ypixel);
        }   }
        for (wh = 0; wh <= MONSTERS; wh++)
        {   if (monster[wh].xpixel != HIDDEN_X && monster[wh].ypixel == y)
            {   Counter.ImageData = monster[wh].image;
                DrawImage(&OffScreenRastPort, &Counter, monster[wh].xpixel, monster[wh].ypixel);
        }   }
        for (wh = 0; wh <= SORDS; wh++)
        {   if (sord[wh].xpixel != HIDDEN_X && sord[wh].ypixel == y)
            {   Counter.ImageData = CounterData[FIRSTIMAGE_SORD + wh];
                DrawImage(&OffScreenRastPort, &Counter, sord[wh].xpixel, sord[wh].ypixel);
        }   }
        for (wh = 0; wh <= TREASURES; wh++)
        {   if (treasure[wh].xpixel != HIDDEN_X && treasure[wh].ypixel == y)
            {   Counter.ImageData = CounterData[FIRSTIMAGE_TREASURE + wh];
                DrawImage(&OffScreenRastPort, &Counter, treasure[wh].xpixel, treasure[wh].ypixel);
    }   }   }

    ClipBlit(&OffScreenRastPort, 0, 0, MainWindowPtr->RPort, LEFTGAP, TOPGAP, SCREENXPIXEL, SCREENYPIXEL, 0xC0);
}

MODULE void cycle(SLONG whichhero, UWORD qual)
{   if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
    {   if (hero[whichhero].control == 0)
        {   hero[whichhero].control = 2;
        } else
        {   hero[whichhero].control--;
    }   }
    else
    {   if (hero[whichhero].control == 2)
        {   hero[whichhero].control = 0;
        } else
        {   hero[whichhero].control++;
    }   }
    GT_SetGadgetAttrs(CycleGadgetPtr[whichhero], MainWindowPtr, NULL, GTCY_Active, hero[whichhero].control       , TAG_DONE);
    GT_SetGadgetAttrs(StartGadgetPtr           , MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
}

MODULE void docwindow(SLONG number)
{   SLONG  lines          = 0,    // initialized to avoid a spurious SAS/C compiler warning
           whichline;
    SWORD  width, height;
    STRPTR titlestringptr = NULL; // initialized to avoid a spurious SAS/C compiler warning

    switch (number)
    {
    case 1:
        // runes
        titlestringptr = (STRPTR) LLL(MSG_HELPHAIL_1, "Runes");
        strcpy(line[0][0],  rune[AMSIR].name);
        strcat(line[0][0],  ", ");
        strcat(line[0][0],  rune[AMSIR].desc);
        strcpy(line[0][1],  LLL(MSG_AMSIR_1, "A hero with this rune has twice the"      ));
        strcpy(line[0][2],  LLL(MSG_AMSIR_2, "chance of having the gods notice him."    ));
               line[0][3][0] = EOS;
        strcpy(line[0][4],  rune[EON].name);
        strcat(line[0][4],  ", ");
        strcat(line[0][4],  rune[EON].desc);
        strcpy(line[0][5],  LLL(MSG_EON_1,   "+1 to movement factor."                   ));
               line[0][6][0] = EOS;
        strcpy(line[0][7],  rune[GEOFU].name);
        strcat(line[0][7],  ", ");
        strcat(line[0][7],  rune[GEOFU].desc);
        strcpy(line[0][8],  LLL(MSG_GEOFU_1, "A hero with this rune will have all the"  ));
        strcpy(line[0][9],  LLL(MSG_GEOFU_2, "areas in his kingdom yield one additional"));
        strcpy(line[0][10], LLL(MSG_GEOFU_3, "mark over and above the tax factor each"  ));
        strcpy(line[0][11], LLL(MSG_GEOFU_4, "turn."                                    ));
               line[0][12][0] = EOS;
        strcpy(line[0][13], rune[ING].name);
        strcat(line[0][13], ", ");
        strcat(line[0][13], rune[ING].desc);
        strcpy(line[0][14], LLL(MSG_ING_1,   "A hero with this rune can heal his wounds"));
        strcpy(line[0][15], LLL(MSG_ING_2,   "by spending one turn anywhere at rest."   ));
               line[0][16][0] = EOS;
        strcpy(line[0][17], rune[OGAL].name);
        strcat(line[0][17], ", ");
        strcat(line[0][17], rune[OGAL].desc);
        strcpy(line[0][18], LLL(MSG_OGAL_1,  "+1 to combat strength."                   ));
               line[0][19][0] = EOS;
        strcpy(line[0][20], rune[SYGIL].name);
        strcat(line[0][20], ", ");
        strcat(line[0][20], rune[SYGIL].desc);
        strcpy(line[0][21], LLL(MSG_SYGIL_1, "Every time a spell is cast at the hero"   ));
        strcpy(line[0][22], LLL(MSG_SYGIL_2, "who has this rune, it may not affect the" ));
        strcpy(line[0][23], LLL(MSG_SYGIL_3, "hero (though it may affect those in the"  ));
        strcpy(line[0][24], LLL(MSG_SYGIL_4, "same area with him)."                     ));
        lines = 25; // counting from 1
    acase 2:
        // spells
        titlestringptr = (STRPTR) LLL(MSG_HELPHAIL_2, "Spells");
        strcpy(line[0][0],  "Hagall (");
        strcat(line[0][0],  LLL(MSG_HAIL,           "hail"                                ));
        strcat(line[0][0],  ")");
        strcpy(line[0][1],  LLL(MSG_HAGALL_1,       "Reduces the combat factor of each counter"));
        strcpy(line[0][2],  LLL(MSG_HAGALL_2,       "in the area (including the caster) by one"));
        strcpy(line[0][3],  LLL(MSG_HAGALL_3,       "for the rest of the turn. It also"        ));
        strcpy(line[0][4],  LLL(MSG_HAGALL_4,       "prevents any of the counters from moving" ));
        strcpy(line[0][5],  LLL(MSG_HAGALL_5,       "by sea next turn."                        ));
               line[0][6][0] = EOS;
        strcpy(line[0][7],  "Is (");
        strcat(line[0][7],  LLL(MSG_ICE,            "ice"                                      ));
        strcat(line[0][7],  ")");
        strcpy(line[0][8],  LLL(MSG_IS_1,           "Makes it impossible for any hero to"      ));
        strcpy(line[0][9],  LLL(MSG_IS_2,           "found, or continue to have a kingdom in"  ));
        strcpy(line[0][10], LLL(MSG_IS_3,           "that country."                            ));
               line[0][11][0] = EOS;
        strcpy(line[0][12], "Jara (");
        strcat(line[0][12], LLL(MSG_LOSE_NEXT_TURN, "lose next turn"                           ));
        strcat(line[0][12], ")");
        strcpy(line[0][13], LLL(MSG_JARA_1,         "All in the area lose their next turn."    ));
               line[0][14][0] = EOS;
        if (!(li.li_Catalog)) // only if running in English
        {   strcpy(line[0][15], "Nied (");
            strcat(line[0][15], LLL(MSG_N_R_A_L_N_T,    "no result and lose next turn"             ));
            strcat(line[0][15], ")");
        } else // German rune description text is too long
        {   strcpy(line[0][15], "Nied");
        }
        strcpy(line[0][16], LLL(MSG_NIED_1,         "Makes the combat result an automatic \"no"));
        strcpy(line[0][17], LLL(MSG_NIED_2,         "result\" and causes all in the area to"   ));
        strcpy(line[0][18], LLL(MSG_NIED_3,         "lose one turn."                           ));
               line[0][19][0] = EOS;
        strcpy(line[0][20], "Wynn (");
        strcat(line[0][20], LLL(MSG_FLEEING,        "fleeing"                                  ));
        strcat(line[0][20], ")");
        strcpy(line[0][21], LLL(MSG_WYNN_1,         "Forces all of the heroes and jarls in the"));
        strcpy(line[0][22], LLL(MSG_WYNN_2,         "area to flee."                            ));
               line[0][23][0] = EOS;
        strcpy(line[0][24], "Yr (");
        strcat(line[0][24], LLL(MSG_WOUNDING,       "wounding"                                 ));
        strcat(line[0][24], ")");
        strcpy(line[0][25], LLL(MSG_YR_1,           "Causes all counters in the area (except"  ));
        strcpy(line[0][26], LLL(MSG_YR_2,           "face down jarls or monster counters) to"  ));
        strcpy(line[0][27], LLL(MSG_YR_3,           "be wounded."                              ));
        lines = 28; // counting from 1
    acase 3:
        // swords
        titlestringptr = (STRPTR) LLL(MSG_HELPHAIL_3, "Swords");
        strcpy(line[0][0],  sord[BALMUNG].name);
        strcpy(line[0][1],  LLL(MSG_BALMUNG_1,         "In any fight where its wielder is"        ));
        strcpy(line[0][2],  LLL(MSG_BALMUNG_2,         "attacking an enemy wearing magic armour," ));
        strcpy(line[0][3],  LLL(MSG_BALMUNG_3,         "it cancels out the benefit of the magic"  ));
        strcpy(line[0][4],  LLL(MSG_BALMUNG_4,         "armour. Thus, the Mail Coat and the Magic"));
        strcpy(line[0][5],  LLL(MSG_BALMUNG_5,         "Shirt provide no protection against it."  ));
               line[0][6][0] = EOS;
        strcpy(line[0][7],  sord[DRAGVENDILL].name);
        strcpy(line[0][8],  LLL(MSG_NO_SPECIAL_POWERS, "No special powers."                       ));
               line[0][9][0] = EOS;
        strcpy(line[0][10], sord[GRAM].name);
        strcpy(line[0][11], LLL(MSG_NO_SPECIAL_POWERS, "No special powers."                       ));
               line[0][12][0] = EOS;
        strcpy(line[0][13], sord[HRUNTING].name);
        strcpy(line[0][14], LLL(MSG_HRUNTING_1,        "The other side must flee instead when the"));
        strcpy(line[0][15], LLL(MSG_HRUNTING_2,        "combat result would be that the wielder's"));
        strcpy(line[0][16], LLL(MSG_HRUNTING_3,        "side must flee."                          ));
               line[0][17][0] = EOS;
        strcpy(line[0][18], sord[LOVI].name);
        strcpy(line[0][19], LLL(MSG_LOVI_1,            "In any battle against a side including"   ));
        strcpy(line[0][20], LLL(MSG_LOVI_2,            "jarls, it adds an additional +2 to the"   ));
        strcpy(line[0][21], LLL(MSG_LOVI_3,            "wielder's combat factor."                 ));
               line[0][22][0] = EOS;
        strcpy(line[0][23], sord[TYRFING].name);
        strcpy(line[0][24], LLL(MSG_NO_SPECIAL_POWERS, "No special powers."                       ));
        lines = 25; // counting from 1
    acase 4:
        // treasures
        titlestringptr = (STRPTR) LLL(MSG_HELPHAIL_4, "Treasures");
        strcpy(line[0][0],  LLL(MSG_BROSUNG_NECKLACE, "Brosung Necklace"                         ));
        strcpy(line[0][1],  LLL(MSG_NECKLACE_1,       "This treasure is worth 20 marks. It may"  ));
        strcpy(line[0][2],  LLL(MSG_NECKLACE_2,       "be traded for any item in a dragon's"     ));
        strcpy(line[0][3],  LLL(MSG_NECKLACE_3,       "hoard. The wearer moves into the area"    ));
        strcpy(line[0][4],  LLL(MSG_NECKLACE_4,       "adjacent to that of the dragon, and gives"));
        strcpy(line[0][5],  LLL(MSG_NECKLACE_5,       "it to the dragon while taking what the"   ));
        strcpy(line[0][6],  LLL(MSG_NECKLACE_6,       "dragon had. The wearer may then see what" ));
        strcpy(line[0][7],  LLL(MSG_NECKLACE_7,       "he had traded for."                       ));
               line[0][8][0] = EOS;
        strcpy(line[0][9],                                                     "Frey Faxi"                                 );
        strcpy(line[0][10], LLL(MSG_FAXI_1,           "This treasure is a magic horse that can"  ));
        strcpy(line[0][11], LLL(MSG_FAXI_2,           "be ridden only 3 times. It doubles the"   ));
        strcpy(line[0][12], LLL(MSG_FAXI_3,           "rider's movement factor."                 ));
               line[0][13][0] = EOS;
        strcpy(line[0][14], LLL(MSG_MAGIC_SHIRT,      "Magic Shirt"                              ));
        strcpy(line[0][15], LLL(MSG_SHIRT_1,          "It adds +1 to the combat strength of the" ));
        strcpy(line[0][16], LLL(MSG_SHIRT_2,          "wearer when he is defending. It also adds"));
        strcpy(line[0][17], LLL(MSG_SHIRT_3,          "+1 to the movement factor of the wearer." ));
               line[0][18][0] = EOS;
        strcpy(line[0][19], LLL(MSG_MAIL_COAT,        "Mail Coat"                                ));
        strcpy(line[0][20], LLL(MSG_COAT_1,           "It adds +2 to the combat strength of the" ));
        strcpy(line[0][21], LLL(MSG_COAT_2,           "wearer, but only when the wearer is"      ));
        strcpy(line[0][22], LLL(MSG_COAT_3,           "defending."                               ));

        if (advanced)
        {          line[0][23][0] = EOS;
            strcpy(line[0][24], LLL(MSG_HEALING_POTION,   "Healing Potion"                           ));
            strcpy(line[0][25], LLL(MSG_POTION_1,         "This treasure can be used only once. It"  ));
            strcpy(line[0][26], LLL(MSG_POTION_2,         "will heal any wounds that the hero is"    ));
            strcpy(line[0][27], LLL(MSG_POTION_3,         "suffering."                               ));
                   line[0][28][0] = EOS;
            strcpy(line[0][29], LLL(MSG_INVISIBILITYRING, "Invisibility Ring"                        ));
            strcpy(line[0][30], LLL(MSG_RING_1,           "The ring gives a half chance of avoiding" ));
            strcpy(line[0][31], LLL(MSG_RING_2,           "a combat, when its wearer is being"       ));
            strcpy(line[0][32], LLL(MSG_RING_3,           "attacked."                                ));
                   line[0][33][0] = EOS;
            strcpy(line[0][34], LLL(MSG_MAGICCROWN,       "Magic Crown"                              ));
            strcpy(line[0][35], LLL(MSG_CROWN_1,          "There is a half chance per turn per"      ));
            strcpy(line[0][36], LLL(MSG_CROWN_2,          "kingdom that an abandoned kingdom will"   ));
            strcpy(line[0][37], LLL(MSG_CROWN_3,          "remain loyal to the crown's wearer."      ));
                   line[0][38][0] = EOS;
            strcpy(line[0][39], LLL(MSG_TELEPORT_SCROLL,  "Teleport Scroll"                          ));
            strcpy(line[0][40], LLL(MSG_SCROLL_1,         "This treasure can be used only once. It"  ));
            strcpy(line[0][41], LLL(MSG_SCROLL_2,         "will teleport the user to any desired"    ));
            strcpy(line[0][42], LLL(MSG_SCROLL_3,         "location."                                ));

            lines = 42 + 1; // counting from 1
        } else
        {   lines = 22 + 1; // counting from 1
    }   }

    if (number == 1 || number == 2)
    {   width = 28 + (44 * fontx);
    } else
    {   // assert(number == 3 || number == 4);
        width = 64 + (44 * fontx);
    }
    height = 14 + (10 * lines);
    if (number == 3) // swords
    {   height += 8; // because counter image overhangs
    }

    if (!(InfoWindowPtr = (struct Window*) OpenWindowTags(NULL,
        WA_Left,          (DisplayWidth  / 2) - (width / 2),
        WA_Top,           (DisplayHeight / 2) - (height / 2),
        WA_InnerWidth,    width,
        WA_InnerHeight,   height,
        WA_IDCMP,         IDCMP_CLOSEWINDOW | IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS,
        WA_Title,         (ULONG) titlestringptr,
        WA_Gadgets,       NULL,
        WA_CustomScreen,  (ULONG) ScreenPtr,
        WA_DragBar,       TRUE,
        WA_CloseGadget,   TRUE,
        WA_NoCareRefresh, TRUE,
        WA_Activate,      TRUE,
        WA_GimmeZeroZero, TRUE,
    TAG_DONE)))
    {   rq("Can't open information window!");
    }
    fillwindow(InfoWindowPtr);
    SetFont(InfoWindowPtr->RPort, FontPtr);
    SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
    SetDrMd(InfoWindowPtr->RPort, JAM1);

    for (whichline = 0; whichline < lines; whichline++)
    {   if
        (   whichline == 0
         || (number == 1 && (whichline == 4 || whichline ==  7 || whichline == 13 || whichline == 17 || whichline == 20))
         || (number == 2 && (whichline == 7 || whichline == 12 || whichline == 15 || whichline == 20 || whichline == 24))
         || (number == 3 && (whichline == 7 || whichline == 10 || whichline == 13 || whichline == 18 || whichline == 23))
         || (number == 4 && (whichline == 9 || whichline == 14 || whichline == 19 || whichline == 24 || whichline == 29 || whichline == 34 || whichline == 39))
        )
        {   // embolden
            DISCARD SetSoftStyle(InfoWindowPtr->RPort, FSF_BOLD,  FSF_BOLD);
        } else
        {   // debolden
            DISCARD SetSoftStyle(InfoWindowPtr->RPort, FS_NORMAL, FSF_BOLD);
        }

        shadowtext
        (   InfoWindowPtr->RPort,
            line[0][whichline],
            WHITE,
            (number == 3 || number == 4) ? 48 : 13,
            13 + (whichline * 10)
        );
    }

    doc(number);

    infoloop();
}

MODULE void infoloop(void)
{   FLAG                 done = FALSE;
    ULONG                class;
    UWORD                code, qual;
    struct IntuiMessage* MsgPtr;
#ifdef __amigaos4__
    int                  rc;
#endif

    while (!done)
    {   if
        (   Wait
            (   (1 << InfoWindowPtr->UserPort->mp_SigBit)
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   CloseWindow(InfoWindowPtr);
            InfoWindowPtr = NULL;
            cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GetMsg(InfoWindowPtr->UserPort)))
        {   class  = MsgPtr->Class;
            code   = MsgPtr->Code;
            qual   = MsgPtr->Qualifier;
            ReplyMsg((struct Message*) MsgPtr);
            switch (class)
            {
            case IDCMP_CLOSEWINDOW:
            case IDCMP_MOUSEBUTTONS:
                done = TRUE;
            acase IDCMP_RAWKEY:
                if
                (   !(qual & IEQUALIFIER_REPEAT)
                 && code < KEYUP
                 && code != NM_WHEEL_UP
                 && code != NM_WHEEL_DOWN
                 && (code < FIRSTQUALIFIER || code > LASTQUALIFIER)
                )
                {   if
                    (   code == SCAN_ESCAPE
                     && ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
                    )
                    {   cleanexit(EXIT_SUCCESS);
                    } else
                    {   done = TRUE;
        }   }   }   }

#ifdef __amigaos4__
        rc = handle_applibport(FALSE);
        if (rc == 1 || rc == 3)
        {   CloseWindow(InfoWindowPtr);
            InfoWindowPtr = NULL;
            cleanexit(EXIT_SUCCESS);
        }
#endif
    }

    CloseWindow(InfoWindowPtr);
    InfoWindowPtr = NULL;

    clearkybd_gt(MainWindowPtr);
}

EXPORT void border(SLONG whichhero)
{   if (!customscreen)
    {   return;
    }

    switch (whichhero)
    {
    case BEOWULF:
        SetRGB32(&ScreenPtr->ViewPort, 110, 0x99999999, 0x66666666, 0x00000000);
        SetRGB32(&ScreenPtr->ViewPort, 111, 0xBBBBBBBB, 0x88888888, 0x22222222);
        SetRGB32(&ScreenPtr->ViewPort, 112, 0xDDDDDDDD, 0xAAAAAAAA, 0x44444444);
        SetRGB32(&ScreenPtr->ViewPort, 113, 0xFFFFFFFF, 0xCCCCCCCC, 0x66666666);
    acase BRUNHILD:
        SetRGB32(&ScreenPtr->ViewPort, 110, 0x99999999, 0x00000000, 0x00000000);
        SetRGB32(&ScreenPtr->ViewPort, 111, 0xBBBBBBBB, 0x22222222, 0x22222222);
        SetRGB32(&ScreenPtr->ViewPort, 112, 0xDDDDDDDD, 0x44444444, 0x44444444);
        SetRGB32(&ScreenPtr->ViewPort, 113, 0xFFFFFFFF, 0x66666666, 0x66666666);
    acase EGIL:
        SetRGB32(&ScreenPtr->ViewPort, 110, 0x99999999, 0x99999999, 0x00000000);
        SetRGB32(&ScreenPtr->ViewPort, 111, 0xBBBBBBBB, 0xBBBBBBBB, 0x11111111);
        SetRGB32(&ScreenPtr->ViewPort, 112, 0xDDDDDDDD, 0xDDDDDDDD, 0x22222222);
        SetRGB32(&ScreenPtr->ViewPort, 113, 0xFFFFFFFF, 0xFFFFFFFF, 0x33333333);
    acase RAGNAR:
        SetRGB32(&ScreenPtr->ViewPort, 110, 0x00000000, 0x99999999, 0x99999999);
        SetRGB32(&ScreenPtr->ViewPort, 111, 0x22222222, 0xBBBBBBBB, 0xBBBBBBBB);
        SetRGB32(&ScreenPtr->ViewPort, 112, 0x44444444, 0xDDDDDDDD, 0xDDDDDDDD);
        SetRGB32(&ScreenPtr->ViewPort, 113, 0x66666666, 0xFFFFFFFF, 0xFFFFFFFF);
    acase SIEGFRIED:
        SetRGB32(&ScreenPtr->ViewPort, 110, 0x44444444, 0x44444444, 0x99999999);
        SetRGB32(&ScreenPtr->ViewPort, 111, 0x66666666, 0x66666666, 0xBBBBBBBB);
        SetRGB32(&ScreenPtr->ViewPort, 112, 0x88888888, 0x88888888, 0xDDDDDDDD);
        SetRGB32(&ScreenPtr->ViewPort, 113, 0xAAAAAAAA, 0xAAAAAAAA, 0xFFFFFFFF);
    acase STARKAD:
        SetRGB32(&ScreenPtr->ViewPort, 110, 0x99999999, 0x00000000, 0x99999999);
        SetRGB32(&ScreenPtr->ViewPort, 111, 0xBBBBBBBB, 0x22222222, 0xBBBBBBBB);
        SetRGB32(&ScreenPtr->ViewPort, 112, 0xDDDDDDDD, 0x44444444, 0xDDDDDDDD);
        SetRGB32(&ScreenPtr->ViewPort, 113, 0xFFFFFFFF, 0x66666666, 0xFFFFFFFF);
    adefault:
        SetRGB32(&ScreenPtr->ViewPort, 110, 0x99999999, 0x99999999, 0x99999999);
        SetRGB32(&ScreenPtr->ViewPort, 111, 0xBBBBBBBB, 0xBBBBBBBB, 0xBBBBBBBB);
        SetRGB32(&ScreenPtr->ViewPort, 112, 0xDDDDDDDD, 0xDDDDDDDD, 0xDDDDDDDD);
        SetRGB32(&ScreenPtr->ViewPort, 113, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
}   }

MODULE void changespeed(void)
{   TEXT tempstring[20 + 1];

    if (speed == 7)
    {   strcpy(tempstring, (STRPTR) LLL(MSG_INFINITE, "Infinite"));
    } else
    {   sprintf
        (   tempstring,
            (STRPTR) LLL(MSG_SECS, "%d.%d secs"),
            tickspeed[speed] / 10,
            tickspeed[speed] % 10
        );
    }
    SetAPen(MainWindowPtr->RPort, remapit[customscreen ? MEDIUMGREY : DARKGREY]);
    RectFill
    (   MainWindowPtr->RPort,
        LEFTGAP + 438                   , TOPGAP + 309,
        LEFTGAP + 438 + (fontx * maxlen), TOPGAP + 318
    );
    shadowtext(MainWindowPtr->RPort, tempstring, WHITE, LEFTGAP + 438, TOPGAP + 316);
    GT_SetGadgetAttrs(SpeedGadgetPtr, MainWindowPtr, NULL, GTSL_Level, speed, TAG_DONE);
}

MODULE void changeturns(void)
{   stcl_d(numberstring, turns);
    SetAPen(MainWindowPtr->RPort, remapit[customscreen ? MEDIUMGREY : DARKGREY]);
    RectFill
    (   MainWindowPtr->RPort,
        LEFTGAP + 438, TOPGAP + 323,
        LEFTGAP + 454, TOPGAP + 332
    );
    shadowtext(MainWindowPtr->RPort, numberstring, WHITE, LEFTGAP + 438, TOPGAP + 330);

    GT_SetGadgetAttrs(TurnsGadgetPtr, MainWindowPtr, NULL, GTSL_Level, (WORD) turns, TAG_DONE);
}

EXPORT void drawlogo(void)
{   WORD leftx, topy, rightx, bottomy;

    SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
    RectFill
    (   MainWindowPtr->RPort,
        LEFTGAP + (640 / 2) - (Logo.Width / 2) - 8,
        TOPGAP  + 77 - 8,
        LEFTGAP + (640 / 2) + (Logo.Width / 2) + 8,
        TOPGAP  + 77 + 8 + Logo.Height
    );
    DrawImage
    (   MainWindowPtr->RPort,
        &Logo,
        LEFTGAP + (640 / 2) - (Logo.Width / 2),
        TOPGAP  + 77
    );

    leftx   = LEFTGAP + (640 / 2) - (Logo.Width / 2) - 16;
    topy    = TOPGAP  + 61;
    rightx  = LEFTGAP + (640 / 2) + (Logo.Width / 2) +  7;
    bottomy = TOPGAP  + 84 + Logo.Height;

    drawborder(leftx, topy, rightx, bottomy, FALSE);
}

EXPORT void drawborder(int leftx, int topy, int rightx, int bottomy, FLAG outer)
{   // corners
    Corner.ImageData = outer ? OuterCornerData[0] : InnerCornerData[0];
    DrawImage
    (   MainWindowPtr->RPort,
        &Corner,
        leftx,
        topy
    );
    Corner.ImageData = outer ? OuterCornerData[1] : InnerCornerData[1];
    DrawImage
    (   MainWindowPtr->RPort,
        &Corner,
        rightx,
        topy
    );
    Corner.ImageData = outer ? OuterCornerData[2] : InnerCornerData[2];
    DrawImage
    (   MainWindowPtr->RPort,
        &Corner,
        leftx,
        bottomy
    );
    Corner.ImageData = outer ? OuterCornerData[3] : InnerCornerData[3];
    DrawImage
    (   MainWindowPtr->RPort,
        &Corner,
        rightx,
        bottomy
    );

    // black
    SetAPen(MainWindowPtr->RPort, remapit[BLACK]);
    // left
    Move(MainWindowPtr->RPort, leftx     , topy    + 9);
    Draw(MainWindowPtr->RPort, leftx     , bottomy - 1);
    // right
    Move(MainWindowPtr->RPort, rightx + 8, topy    + 9);
    Draw(MainWindowPtr->RPort, rightx + 8, bottomy - 1);
    // top
    Move(MainWindowPtr->RPort, leftx  + 9, topy       );
    Draw(MainWindowPtr->RPort, rightx - 1, topy       );
    // bottom
    Move(MainWindowPtr->RPort, leftx  + 9, bottomy + 8);
    Draw(MainWindowPtr->RPort, rightx - 1, bottomy + 8);

    // darkest
    SetAPen(MainWindowPtr->RPort, remapit[outer ? 110 : DARKGREY]);
    // left
    Move(MainWindowPtr->RPort, leftx  + 1, topy    + 9);
    Draw(MainWindowPtr->RPort, leftx  + 1, bottomy - 1);
    Move(MainWindowPtr->RPort, leftx  + 7, topy    + 9);
    Draw(MainWindowPtr->RPort, leftx  + 7, bottomy - 1);
    // right
    Move(MainWindowPtr->RPort, rightx + 1, topy    + 9);
    Draw(MainWindowPtr->RPort, rightx + 1, bottomy - 1);
    Move(MainWindowPtr->RPort, rightx + 7, topy    + 9);
    Draw(MainWindowPtr->RPort, rightx + 7, bottomy - 1);
    // top
    Move(MainWindowPtr->RPort, leftx  + 9, topy    + 1);
    Draw(MainWindowPtr->RPort, rightx - 1, topy    + 1);
    Move(MainWindowPtr->RPort, leftx  + 9, topy    + 7);
    Draw(MainWindowPtr->RPort, rightx - 1, topy    + 7);
    // bottom
    Move(MainWindowPtr->RPort, leftx  + 9, bottomy + 1);
    Draw(MainWindowPtr->RPort, rightx - 1, bottomy + 1);
    Move(MainWindowPtr->RPort, leftx  + 9, bottomy + 7);
    Draw(MainWindowPtr->RPort, rightx - 1, bottomy + 7);

    // nearly darkest
    SetAPen(MainWindowPtr->RPort, remapit[outer ? 111 : MEDIUMGREY]);
    // left
    Move(MainWindowPtr->RPort, leftx  + 2, topy    + 9);
    Draw(MainWindowPtr->RPort, leftx  + 2, bottomy - 1);
    Move(MainWindowPtr->RPort, leftx  + 6, topy    + 9);
    Draw(MainWindowPtr->RPort, leftx  + 6, bottomy - 1);
    // right
    Move(MainWindowPtr->RPort, rightx + 2, topy    + 9);
    Draw(MainWindowPtr->RPort, rightx + 2, bottomy - 1);
    Move(MainWindowPtr->RPort, rightx + 6, topy    + 9);
    Draw(MainWindowPtr->RPort, rightx + 6, bottomy - 1);
    // top
    Move(MainWindowPtr->RPort, leftx  + 9, topy    + 2);
    Draw(MainWindowPtr->RPort, rightx - 1, topy    + 2);
    Move(MainWindowPtr->RPort, leftx  + 9, topy    + 6);
    Draw(MainWindowPtr->RPort, rightx - 1, topy    + 6);
    // bottom
    Move(MainWindowPtr->RPort, leftx  + 9, bottomy + 2);
    Draw(MainWindowPtr->RPort, rightx - 1, bottomy + 2);
    Move(MainWindowPtr->RPort, leftx  + 9, bottomy + 6);
    Draw(MainWindowPtr->RPort, rightx - 1, bottomy + 6);

    // nearly lightest
    SetAPen(MainWindowPtr->RPort, remapit[outer ? 112 : LIGHTGREY]);
    // left
    Move(MainWindowPtr->RPort, leftx  + 3, topy    + 9);
    Draw(MainWindowPtr->RPort, leftx  + 3, bottomy - 1);
    Move(MainWindowPtr->RPort, leftx  + 5, topy    + 9);
    Draw(MainWindowPtr->RPort, leftx  + 5, bottomy - 1);
    // right
    Move(MainWindowPtr->RPort, rightx + 3, topy    + 9);
    Draw(MainWindowPtr->RPort, rightx + 3, bottomy - 1);
    Move(MainWindowPtr->RPort, rightx + 5, topy    + 9);
    Draw(MainWindowPtr->RPort, rightx + 5, bottomy - 1);
    // top
    Move(MainWindowPtr->RPort, leftx  + 9, topy    + 3);
    Draw(MainWindowPtr->RPort, rightx - 1, topy    + 3);
    Move(MainWindowPtr->RPort, leftx  + 9, topy    + 5);
    Draw(MainWindowPtr->RPort, rightx - 1, topy    + 5);
    // bottom
    Move(MainWindowPtr->RPort, leftx  + 9, bottomy + 3);
    Draw(MainWindowPtr->RPort, rightx - 1, bottomy + 3);
    Move(MainWindowPtr->RPort, leftx  + 9, bottomy + 5);
    Draw(MainWindowPtr->RPort, rightx - 1, bottomy + 5);

    // lightest
    SetAPen(MainWindowPtr->RPort, remapit[outer ? 113 : WHITE]);
    // left
    Move(MainWindowPtr->RPort, leftx  + 4, topy    + 9);
    Draw(MainWindowPtr->RPort, leftx  + 4, bottomy - 1);
    // right
    Move(MainWindowPtr->RPort, rightx + 4, topy    + 9);
    Draw(MainWindowPtr->RPort, rightx + 4, bottomy - 1);
    // top
    Move(MainWindowPtr->RPort, leftx  + 9, topy    + 4);
    Draw(MainWindowPtr->RPort, rightx - 1, topy    + 4);
    // bottom
    Move(MainWindowPtr->RPort, leftx  + 9, bottomy + 4);
    Draw(MainWindowPtr->RPort, rightx - 1, bottomy + 4);
}

EXPORT void clearscreen(void)
{   SWORD x = 0,
          y;

    if (customscreen)
    {   while (x < (SWORD) DisplayWidth)
        {   y = 0;
            while (y < (SWORD) DisplayHeight)
            {   DrawImage
                (   MainWindowPtr->RPort,
                    &Bkgrnd,
                    x,
                    y
                );
                y += Bkgrnd.Height;
            }
            x += Bkgrnd.Width;
    }   }
    else
    {   SetAPen(MainWindowPtr->RPort, remapit[DARKGREY]);
        RectFill
        (   MainWindowPtr->RPort,
            xoffset,
            yoffset,
            xoffset + 640 - 1,
            yoffset + 512 - 1
        );
}   }

EXPORT void fillwindow(struct Window* WindowPtr)
{   SWORD x = 0,
          y;

    while (x < WindowPtr->GZZWidth)
    {   y = 0;
        while (y < WindowPtr->GZZHeight)
        {   DrawImage
            (   WindowPtr->RPort,
                &Bkgrnd,
                x,
                y
            );
            y += Bkgrnd.Height;
        }
        x += Bkgrnd.Width;
}   }

MODULE FLAG playersactive(void)
{   int whichhero;

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if (hero[whichhero].control != NONE)
        {   return TRUE;
    }   }
    return FALSE;
}

MODULE void titlescreen_loop(void)
{   FLAG                 done = FALSE;
    SLONG                whichhero;
    ULONG                class;
    UWORD                code, qual;
    struct Gadget*       addr;
    struct MenuItem*     ItemPtr;
    struct IntuiMessage* MsgPtr;
#ifdef __amigaos4__
    int                  rc;
#endif

    do
    {   if
        (   Wait
            (   MainSignal
              | AppLibSignal
              | SIGBREAKF_CTRL_C
            ) & SIGBREAKF_CTRL_C
        )
        {   cleanexit(EXIT_SUCCESS);
        }

        while ((MsgPtr = (struct IntuiMessage*) GT_GetIMsg(MainWindowPtr->UserPort)))
        {   addr  = (struct Gadget*) MsgPtr->IAddress;
            class = MsgPtr->Class;
            code  = MsgPtr->Code;
            qual  = MsgPtr->Qualifier;
            GT_ReplyIMsg(MsgPtr);
            switch (class)
            {
            case IDCMP_RAWKEY:
                if (code == SCAN_LEFT)
                {   if (speed > 0)
                    {   if
                        (   (qual & IEQUALIFIER_LSHIFT)
                         || (qual & IEQUALIFIER_RSHIFT)
                         || (qual & IEQUALIFIER_LALT)
                         || (qual & IEQUALIFIER_RALT)
                         || (qual & IEQUALIFIER_CONTROL)
                        )
                        {   speed = 0;
                        } else speed--;
                        changespeed();
                }   }
                elif (code == SCAN_RIGHT)
                {   if (speed < 7)
                    {   if
                        (   (qual & IEQUALIFIER_LSHIFT)
                         || (qual & IEQUALIFIER_RSHIFT)
                         || (qual & IEQUALIFIER_LALT)
                         || (qual & IEQUALIFIER_RALT)
                         || (qual & IEQUALIFIER_CONTROL)
                        )
                        {   speed = 7;
                        } else speed++;
                        changespeed();
                }   }
                elif (!(qual & IEQUALIFIER_REPEAT))
                {   switch (code)
                    {
                    case  SCAN_F1:   cycle(0, qual);
                    acase SCAN_F2:   cycle(1, qual);
                    acase SCAN_F3:   cycle(2, qual);
                    acase SCAN_F4:   cycle(3, qual);
                    acase SCAN_F5:   cycle(4, qual);
                    acase SCAN_F6:   cycle(5, qual);
                    acase SCAN_HELP: help_about();
                }   }
            acase IDCMP_VANILLAKEY:
                code = (UWORD) toupper((int) code);
                switch (code)
                {
                case ' ':
                case 13: // Return or Enter
                    if (playersactive())
                    {   done = TRUE;
                    }
                acase 27: // Escape
                    cleanexit(EXIT_SUCCESS);
                acase '1':
                case 'B':
                case '!':
                    cycle(0, qual);
                acase '2':
                case 'U':
                case '@':
                    cycle(1, qual);
                acase '3':
                case 'E':
                case '#':
                    cycle(2, qual);
                acase '4':
                case 'R':
                case '$':
                    cycle(3, qual);
                acase '5':
                case 'S':
                case '%':
                    cycle(4, qual);
                acase '6':
                case 'T':
                case '^':
                    cycle(5, qual);
                }
            acase IDCMP_MENUPICK:
                while (code != MENUNULL)
                {   ItemPtr = ItemAddress(MenuPtr, code);

                    switch (MENUNUM(code))
                    {
                    case MN_PROJECT:
                        switch (ITEMNUM(code))
                        {
                        case IN_NEW:
                            done = TRUE;
                        acase IN_OPEN:
                            if (loadgame(TRUE))
                            {   done = TRUE;
                                loaded = TRUE;
                            }
                     /* acase IN_QUITTITLE: should never happen
                            assert(0); */
                        acase IN_QUITDOS:
                            cleanexit(EXIT_SUCCESS);
                        }
                    acase MN_SETTINGS:
                        switch (ITEMNUM(code))
                        {
                        case IN_SHOW_TITLEBAR:
                            if (ItemPtr->Flags & CHECKED)
                            {   titlebar = TRUE;
                            } else
                            {   titlebar = FALSE;
                            }
                            ShowTitle(ScreenPtr, titlebar);
                        acase IN_WATCH_AMIGA:
                            watchamiga = (ItemPtr->Flags & CHECKED) ? TRUE : FALSE;
                        }
                    acase MN_HELP:
                        switch (ITEMNUM(code))
                        {
                        case  IN_HELP_1: docwindow(1);
                        acase IN_HELP_2: docwindow(2);
                        acase IN_HELP_3: docwindow(3);
                        acase IN_HELP_4: docwindow(4);
                        acase IN_MANUAL: help_manual();
                        acase IN_ABOUT:  help_about();
                    }   }
                    code = ItemPtr->NextSelect;
                }
            acase IDCMP_REFRESHWINDOW:
                GT_BeginRefresh(MainWindowPtr);
                GT_EndRefresh(MainWindowPtr, TRUE);
            acase IDCMP_GADGETUP:
                if (addr == SpeedGadgetPtr)
                {   speed = (WORD) code;
                    changespeed();
                } elif (addr == TurnsGadgetPtr)
                {   turns = (SLONG) code;
                    changeturns();
                } elif (addr == AdvancedGadgetPtr)
                {   if (AdvancedGadgetPtr->Flags & GFLG_SELECTED)
                    {   advanced  = TRUE;
                        monsters  = ADVANCEDMONSTERS;
                        treasures = ADVANCEDTREASURES;
                    } else
                    {   advanced  = FALSE;
                        monsters  = BASICMONSTERS;
                        treasures = BASICTREASURES;
                }   }
                elif (addr == StartGadgetPtr)
                {   done = TRUE;
                } else
                {   for (whichhero = 0; whichhero <= HEROES; whichhero++)
                    {   if (addr == CycleGadgetPtr[whichhero])
                        {   hero[whichhero].control = (SLONG) code;
                            GT_SetGadgetAttrs(StartGadgetPtr, MainWindowPtr, NULL, GA_Disabled, playersactive() ? FALSE : TRUE, TAG_DONE);
                            break;
                }   }   }
            acase IDCMP_CLOSEWINDOW:
                cleanexit(EXIT_SUCCESS);
        }   }

#ifdef __amigaos4__
        rc = handle_applibport(TRUE);
        if (rc == 1 || rc == 3)
        {   cleanexit(EXIT_SUCCESS);
        } elif (rc == 2)
        {   done = loaded = TRUE;
        }
#endif
    } while (!done);
}

MODULE void parsewb(void)
{   TRANSIENT       int                whichhero;
    TRANSIENT       struct DiskObject* DiskObject;
    TRANSIENT       STRPTR             s;
    TRANSIENT       STRPTR*            ToolArray;
    PERSIST   const STRPTR             capsheroname[HEROES + 1] =
    { "BEOWULF",
      "BRUNHILD",
      "EGIL",
      "RAGNAR",
      "SIEGFRIED",
      "STARKAD"
    };

    if ((*WBArg->wa_Name) && (DiskObject = GetDiskObject(WBArg->wa_Name)))
    {   ToolArray = (STRPTR*) DiskObject->do_ToolTypes;

        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   if ((s = (STRPTR) FindToolType(ToolArray, capsheroname[whichhero])))
            {   if     (MatchToolValue(s, "HUMAN"))
                {   hero[whichhero].control = HUMAN;
                } elif (MatchToolValue(s, "AMIGA"))
                {   hero[whichhero].control = AMIGA;
                } elif (MatchToolValue(s, "NONE"))
                {   hero[whichhero].control = NONE;
        }   }   }
        if ((s = (STRPTR) FindToolType(ToolArray, "SCREENMODE")))
        {   screenmode = TRUE;
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "PUBSCREEN" )))
        {   strcpy(screenname, s);
        }
        if ((s = (STRPTR) FindToolType(ToolArray, "FILE"      )))
        {   strcpy(pathname, WBArg->wa_Name);
            cliload = TRUE;
        }

        FreeDiskObject(DiskObject);
}   }

EXPORT void remap(void)
{   int    colour,
           i,
           wordwidth,
           x, xx, y;
    FLAG   logook;
    UBYTE  destpen;
    ULONG  red, green, blue;
    UWORD  thebit;
 // UWORD* colour_table;

    About.ImageData    = AboutData;
    Bkgrnd.ImageData   = BkgrndData;
    Logo.ImageData     = LogoData;
    MapImage.ImageData = MapData;

    if (customscreen)
    {   for (i = 0; i < 128; i++)
        {   remapit[i] = i;
        }

        for (i = 0; i < 4; i++)
        {   for (y = 0; y < 9; y++)
            {   for (x = 0; x < 9; x++)
                {   destpen = OriginalCornerData[i][y][x];
                    if   (destpen == '0') destpen = BLACK;
                    elif (destpen == '1') destpen = 110;
                    elif (destpen == '2') destpen = 111;
                    elif (destpen == '3') destpen = 112;
                    elif (destpen == '4') destpen = 113;

                    // and set it
                    if (destpen &   1) OuterCornerData[i][(9 * 0) + y] |= (32768 >> x);
                    if (destpen &   2) OuterCornerData[i][(9 * 1) + y] |= (32768 >> x);
                    if (destpen &   4) OuterCornerData[i][(9 * 2) + y] |= (32768 >> x);
                    if (destpen &   8) OuterCornerData[i][(9 * 3) + y] |= (32768 >> x);
                    if (destpen &  16) OuterCornerData[i][(9 * 4) + y] |= (32768 >> x);
                    if (destpen &  32) OuterCornerData[i][(9 * 5) + y] |= (32768 >> x);
                    if (destpen &  64) OuterCornerData[i][(9 * 6) + y] |= (32768 >> x);
                 // if (destpen & 128) OuterCornerData[i][(9 * 7) + y] |= (32768 >> x);
        }   }   }

        About.Depth        = ABOUTDEPTH;
        Bkgrnd.Depth       =
        Corner.Depth       =
        Counter.Depth      =
        Logo.Depth         =
        MapImage.Depth     = 7;

        About.PlanePick    = ABOUTDEPTHMASK;
        Bkgrnd.PlanePick   =
        Corner.PlanePick   =
        Counter.PlanePick  =
        Logo.PlanePick     =
        MapImage.PlanePick = 0x7F;

        logook = TRUE;
    } else
    {/* colour_table = (UWORD*) ScreenPtr->ViewPort.ColorMap->ColorTable;
        for (i = 0; i <= 255; i++)
        {   hostred[i]   = (colour_table[i] & 0xF00) >> 8;
            hostgreen[i] = (colour_table[i] & 0x0F0) >> 4;
            hostblue[i]  =  colour_table[i] & 0x00F      ;
            printf("#%d: RGB is %X%X%X!\n", i, hostred[i], hostgreen[i], hostblue[i]);
        } */

        for (i = 32; i <= 67; i++) // 36 pens
        {   allocpen(i, 0, 0, 0, TRUE);
        }
        for (i = 0; i <= 12; i++) // 13 pens
        {   red   =  table1[1 + (i * 3)];
            green =  table1[2 + (i * 3)];
            blue  =  table1[3 + (i * 3)];
            allocpen(i, red, green, blue, FALSE);
        }
        for (i = 20; i <= 27; i++) // 8 pens
        {   red   =  table2[1 + ((i - 20) * 3)];
            green =  table2[2 + ((i - 20) * 3)];
            blue  =  table2[3 + ((i - 20) * 3)];
            allocpen(i, red, green, blue, FALSE);
        }
        for (i = 85; i <= 109; i++) // 25 pens
        {   red   =  table3[1 + ((i - 85) * 3)];
            green =  table3[2 + ((i - 85) * 3)];
            blue  =  table3[3 + ((i - 85) * 3)];
            allocpen(i, red, green, blue, FALSE);
        }

        logook = TRUE;
        for (i = 93; i <= 109; i++)
        {   if (!gotpen[i])
            {   logook = FALSE;
                break; // for speed
        }   }
        if (!logook)
        {   for (i = 93; i <= 109; i++)
            {   if (gotpen[i])
                {   ReleasePen(ScreenPtr->ViewPort.ColorMap, remapit[i]);
                    gotpen[i] = FALSE;
    }   }   }   }

    for (i = 0; i < 4; i++)
    {   for (y = 0; y < 9; y++)
        {   for (x = 0; x < 9; x++)
            {   // get the colour of this pixel
                destpen = OriginalCornerData[i][y][x];
                if   (destpen == '0') destpen = BLACK;
                elif (destpen == '1') destpen = DARKGREY;
                elif (destpen == '2') destpen = MEDIUMGREY;
                elif (destpen == '3') destpen = LIGHTGREY;
                elif (destpen == '4') destpen = WHITE;

#ifdef __AROS__
                thebit = (x < 8) ? (128 >> x) : (32768 >> (x - 8));
#else
                thebit = 32768 >> x;
#endif

                // now remap it
                colour = remapit[destpen];

                // and set it
                if (colour &   1) InnerCornerData[i][(9 * 0) + y] |= thebit;
                if (colour &   2) InnerCornerData[i][(9 * 1) + y] |= thebit;
                if (colour &   4) InnerCornerData[i][(9 * 2) + y] |= thebit;
                if (colour &   8) InnerCornerData[i][(9 * 3) + y] |= thebit;
                if (colour &  16) InnerCornerData[i][(9 * 4) + y] |= thebit;
                if (colour &  32) InnerCornerData[i][(9 * 5) + y] |= thebit;
                if (colour &  64) InnerCornerData[i][(9 * 6) + y] |= thebit;
                if (colour & 128) InnerCornerData[i][(9 * 7) + y] |= thebit;
    }   }   }

    wordwidth = 44 / 16;
    if (44 % 16) wordwidth++;
    for (y = 0; y < 38; y++)
    {   for (x = 0; x < wordwidth; x++)
        {   for (xx = 0; xx <= 15; xx++)
            {   // get the colour of this pixel
                colour = 0;
#ifdef __AROS__
                thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                thebit = 32768 >> xx;
#endif
                if (      OriginalAboutData[(((38 * 0) + y) * wordwidth) + x] &  thebit) colour++;
                if (      OriginalAboutData[(((38 * 1) + y) * wordwidth) + x] &  thebit) colour +=  2;
                if (      OriginalAboutData[(((38 * 2) + y) * wordwidth) + x] &  thebit) colour +=  4;
                if (      OriginalAboutData[(((38 * 3) + y) * wordwidth) + x] &  thebit) colour +=  8;

                // now remap it
                colour = remapit[colour];

                // and set it
                if (colour &   1) AboutData[(((38 * 0) + y) * wordwidth) + x] |= thebit;
                if (colour &   2) AboutData[(((38 * 1) + y) * wordwidth) + x] |= thebit;
                if (colour &   4) AboutData[(((38 * 2) + y) * wordwidth) + x] |= thebit;
                if (colour &   8) AboutData[(((38 * 3) + y) * wordwidth) + x] |= thebit;
                if (colour &  16) AboutData[(((38 * 4) + y) * wordwidth) + x] |= thebit;
                if (colour &  32) AboutData[(((38 * 5) + y) * wordwidth) + x] |= thebit;
                if (colour &  64) AboutData[(((38 * 6) + y) * wordwidth) + x] |= thebit;
                if (colour & 128) AboutData[(((38 * 7) + y) * wordwidth) + x] |= thebit;
    }   }   }

    wordwidth = 58 / 16;
    if (58 % 16) wordwidth++;
    for (y = 0; y < 58; y++)
    {   for (x = 0; x < wordwidth; x++)
        {   for (xx = 0; xx <= 15; xx++)
            {   // get the colour of this pixel
                colour = 0;
#ifdef __AROS__
                thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                thebit = 32768 >> xx;
#endif
                if (      OriginalBkgrndData[(((58 * 0) + y) * wordwidth) + x] &  thebit) colour++;
                if (      OriginalBkgrndData[(((58 * 1) + y) * wordwidth) + x] &  thebit) colour +=  2;
                if (      OriginalBkgrndData[(((58 * 2) + y) * wordwidth) + x] &  thebit) colour +=  4;

                colour += 85; // 0..7 -> 85..92

                // now remap it
                colour = remapit[colour];

                // and set it
                if (colour &   1) BkgrndData[(((58 * 0) + y) * wordwidth) + x] |= thebit;
                if (colour &   2) BkgrndData[(((58 * 1) + y) * wordwidth) + x] |= thebit;
                if (colour &   4) BkgrndData[(((58 * 2) + y) * wordwidth) + x] |= thebit;
                if (colour &   8) BkgrndData[(((58 * 3) + y) * wordwidth) + x] |= thebit;
                if (colour &  16) BkgrndData[(((58 * 4) + y) * wordwidth) + x] |= thebit;
                if (colour &  32) BkgrndData[(((58 * 5) + y) * wordwidth) + x] |= thebit;
                if (colour &  64) BkgrndData[(((58 * 6) + y) * wordwidth) + x] |= thebit;
                if (colour & 128) BkgrndData[(((58 * 7) + y) * wordwidth) + x] |= thebit;
    }   }   }

    wordwidth = 212 / 16;
    if (212 % 16) wordwidth++;
    for (y = 0; y < 74; y++)
    {   for (x = 0; x < wordwidth; x++)
        {   for (xx = 0; xx <= 15; xx++)
            {   // get the colour of this pixel
                colour = 0;
#ifdef __AROS__
                thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                thebit = 32768 >> xx;
#endif
                if (      OriginalLogoData[(((74 * 0) + y) * wordwidth) + x] &  thebit) colour++;
                if (      OriginalLogoData[(((74 * 1) + y) * wordwidth) + x] &  thebit) colour +=  2;
                if (      OriginalLogoData[(((74 * 2) + y) * wordwidth) + x] &  thebit) colour +=  4;
                if (      OriginalLogoData[(((74 * 3) + y) * wordwidth) + x] &  thebit) colour +=  8;
                if (      OriginalLogoData[(((74 * 4) + y) * wordwidth) + x] &  thebit) colour += 16;
                if (      OriginalLogoData[(((74 * 5) + y) * wordwidth) + x] &  thebit) colour += 32;
                if (      OriginalLogoData[(((74 * 6) + y) * wordwidth) + x] &  thebit) colour += 64;

                if (logook)
                {   if (colour == 110)   colour = WHITE;
                } else
                {   if (colour != BLACK) colour = WHITE;
                }

                // now remap it
                colour = remapit[colour];

                // and set it
                if (colour &   1) LogoData[(((74 * 0) + y) * wordwidth) + x] |= thebit;
                if (colour &   2) LogoData[(((74 * 1) + y) * wordwidth) + x] |= thebit;
                if (colour &   4) LogoData[(((74 * 2) + y) * wordwidth) + x] |= thebit;
                if (colour &   8) LogoData[(((74 * 3) + y) * wordwidth) + x] |= thebit;
                if (colour &  16) LogoData[(((74 * 4) + y) * wordwidth) + x] |= thebit;
                if (colour &  32) LogoData[(((74 * 5) + y) * wordwidth) + x] |= thebit;
                if (colour &  64) LogoData[(((74 * 6) + y) * wordwidth) + x] |= thebit;
                if (colour & 128) LogoData[(((74 * 7) + y) * wordwidth) + x] |= thebit;
    }   }   }

    wordwidth = 24 / 16;
    if (24 % 16) wordwidth++;
    for (i = 0; i < COUNTERIMAGES; i++)
    {   if   (i < FIRSTIMAGE_JARL    ) destpen = 20; // hero
        elif (i < FIRSTIMAGE_MONSTER ) destpen = 22; // jarl
        elif (i < FIRSTIMAGE_SORD    ) destpen = 24; // monster
        elif (i < FIRSTIMAGE_TREASURE) destpen = 26; // sword
        else                           destpen = 27; // treasure

        for (y = 0; y < 24; y++)
        {   for (x = 0; x < wordwidth; x++)
            {   for (xx = 0; xx <= ((x == 0) ? 15 : 7); xx++)
                {   // get the colour of this pixel
#ifdef __AROS__
                    thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                    thebit = 32768 >> xx;
#endif
                    colour = (OriginalCounterData[i][(((24 * 0) + y) * wordwidth) + x] &  thebit) ? BLACK : destpen;

                    // now remap it
                    colour = remapit[colour];

                    // and set it
                    if (colour &   1) CounterData[i][(((24 * 0) + y) * wordwidth) + x] |= thebit;
                    if (colour &   2) CounterData[i][(((24 * 1) + y) * wordwidth) + x] |= thebit;
                    if (colour &   4) CounterData[i][(((24 * 2) + y) * wordwidth) + x] |= thebit;
                    if (colour &   8) CounterData[i][(((24 * 3) + y) * wordwidth) + x] |= thebit;
                    if (colour &  16) CounterData[i][(((24 * 4) + y) * wordwidth) + x] |= thebit;
                    if (colour &  32) CounterData[i][(((24 * 5) + y) * wordwidth) + x] |= thebit;
                    if (colour &  64) CounterData[i][(((24 * 6) + y) * wordwidth) + x] |= thebit;
                    if (colour & 128) CounterData[i][(((24 * 7) + y) * wordwidth) + x] |= thebit;
    }   }   }   }

    wordwidth = 24 / 16;
    if (24 % 16) wordwidth++;
    for (i = 0; i < SELCOUNTERIMAGES; i++)
    {   if   (i < FIRSTIMAGE_JARL    ) destpen = 21; // hero
        elif (i < FIRSTIMAGE_MONSTER ) destpen = 23; // jarl
        else                           destpen = 25; // monster

        for (y = 0; y < 24; y++)
        {   for (x = 0; x < wordwidth; x++)
            {   for (xx = 0; xx <= ((x == 0) ? 15 : 7); xx++)
                {   // get the colour of this pixel
#ifdef __AROS__
                    thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                    thebit = 32768 >> xx;
#endif
                    colour = (OriginalCounterData[i][(((24 * 0) + y) * wordwidth) + x] &  thebit) ? BLACK : destpen;

                    // now remap it
                    colour = remapit[colour];

                    // and set it
                    if (colour &   1) SelectedCounterData[i][(((24 * 0) + y) * wordwidth) + x] |= thebit;
                    if (colour &   2) SelectedCounterData[i][(((24 * 1) + y) * wordwidth) + x] |= thebit;
                    if (colour &   4) SelectedCounterData[i][(((24 * 2) + y) * wordwidth) + x] |= thebit;
                    if (colour &   8) SelectedCounterData[i][(((24 * 3) + y) * wordwidth) + x] |= thebit;
                    if (colour &  16) SelectedCounterData[i][(((24 * 4) + y) * wordwidth) + x] |= thebit;
                    if (colour &  32) SelectedCounterData[i][(((24 * 5) + y) * wordwidth) + x] |= thebit;
                    if (colour &  64) SelectedCounterData[i][(((24 * 6) + y) * wordwidth) + x] |= thebit;
                    if (colour & 128) SelectedCounterData[i][(((24 * 7) + y) * wordwidth) + x] |= thebit;
    }   }   }   }

    wordwidth = 623 / 16;
    if (623 % 16) wordwidth++;
    for (y = 0; y < 467; y++)
    {   for (x = 0; x < wordwidth; x++)
        {   for (xx = 0; xx <= 15; xx++)
            {   // get the colour of this pixel
                colour = 0;
#ifdef __AROS__
                thebit = (xx < 8) ? (128 >> xx) : (32768 >> (xx - 8));
#else
                thebit = 32768 >> xx;
#endif
                if (      OriginalMapData[(((467 * 0) + y) * wordwidth) + x] &  thebit) colour++;
                if (      OriginalMapData[(((467 * 1) + y) * wordwidth) + x] &  thebit) colour +=  2;
                if (      OriginalMapData[(((467 * 2) + y) * wordwidth) + x] &  thebit) colour +=  4;
                if (      OriginalMapData[(((467 * 3) + y) * wordwidth) + x] &  thebit) colour +=  8;
                if (      OriginalMapData[(((467 * 4) + y) * wordwidth) + x] &  thebit) colour += 16;
                if (      OriginalMapData[(((467 * 5) + y) * wordwidth) + x] &  thebit) colour += 32;
                if (      OriginalMapData[(((467 * 6) + y) * wordwidth) + x] &  thebit) colour += 64;

                if     (colour == 7)
                {   colour = BLACK;
                } elif (colour == 10) // map has
                {   colour = 11;      // these two
                } elif (colour == 11) // the wrong
                {   colour = 10;      // way around
                } elif (colour >= 68 && colour <= 97)
                {   colour = COLOUR_SEA;
                } elif (colour == 98 || colour == 100 || colour == 102)
                {   colour = BLACK; // coastline
                } elif (colour == 99 || colour == 101 || colour == 103)
                {   colour = COLOUR_SEA;
                }

                // now remap it
                colour = remapit[colour];

                // and set it
                if (colour &   1) MapData[(((467 * 0) + y) * wordwidth) + x] |= thebit;
                if (colour &   2) MapData[(((467 * 1) + y) * wordwidth) + x] |= thebit;
                if (colour &   4) MapData[(((467 * 2) + y) * wordwidth) + x] |= thebit;
                if (colour &   8) MapData[(((467 * 3) + y) * wordwidth) + x] |= thebit;
                if (colour &  16) MapData[(((467 * 4) + y) * wordwidth) + x] |= thebit;
                if (colour &  32) MapData[(((467 * 5) + y) * wordwidth) + x] |= thebit;
                if (colour &  64) MapData[(((467 * 6) + y) * wordwidth) + x] |= thebit;
                if (colour & 128) MapData[(((467 * 7) + y) * wordwidth) + x] |= thebit;
}   }   }   }

EXPORT void allocpen(int whichpen, ULONG red, ULONG green, ULONG blue, FLAG exclusive)
{// UBYTE nybblered, nybblegreen, nybbleblue;
    LONG  result;

 /* nybblered   = (red   & 0xF0000000) >> 28;
    nybblegreen = (green & 0xF0000000) >> 28;
    nybbleblue  = (blue  & 0xF0000000) >> 28; */

    if (exclusive)
    {   result = ObtainPen
        (   ScreenPtr->ViewPort.ColorMap,
            -1,
            red,
            green,
            blue,
            PEN_EXCLUSIVE
        );
        if (result == -1) // failed
        {   remapit[whichpen] = FindColor
            (   ScreenPtr->ViewPort.ColorMap,
                0x88888888,
                0x88888888,
                0x88888888,
                -1
            );
/* printf("NO:  Guest pen %2d ($%X%X%X), host pen %3d ($%X%X%X)\n",
whichpen, nybblered, nybblegreen, nybbleblue, remapit[whichpen], hostred[remapit[whichpen]], hostgreen[remapit[whichpen]], hostblue[remapit[whichpen]]); */
        } else
        {   gotpen[whichpen] = TRUE;
            remapit[whichpen] = result;
/* printf("YES: Guest pen %2d ($%X%X%X), host pen %3d ($%X%X%X)\n",
whichpen, nybblered, nybblegreen, nybbleblue, remapit[whichpen], hostred[remapit[whichpen]], hostgreen[remapit[whichpen]], hostblue[remapit[whichpen]]);
printf("Setting host colour %3d to %X%X%X\n",
remapit[whichpen], nybblered, nybblegreen, nybbleblue); */
         /* SetRGB4
            (   &ScreenPtr->ViewPort,
                remapit[whichpen],
                nybblered,
                nybblegreen,
                nybbleblue
            ); not needed */
    }   }
    else
    {   result = ObtainBestPen
        (   ScreenPtr->ViewPort.ColorMap,
            red,
            green,
            blue,
            OBP_Precision, PRECISION_IMAGE,
        TAG_DONE);
        if (result == -1)
        {   remapit[whichpen] = FindColor
            (   ScreenPtr->ViewPort.ColorMap,
                red,
                green,
                blue,
                -1
            );
/* printf("No:  Guest pen %2d ($%X%X%X), host pen %3d ($%X%X%X)\n",
whichpen, nybblered, nybblegreen, nybbleblue, remapit[whichpen], hostred[remapit[whichpen]], hostgreen[remapit[whichpen]], hostblue[remapit[whichpen]]); */
        } else
        {   gotpen[whichpen] = TRUE;
            remapit[whichpen] = result;
/* printf("Yes: Guest pen %2d ($%X%X%X), host pen %3d ($%X%X%X)\n",
whichpen, nybblered, nybblegreen, nybbleblue, remapit[whichpen], hostred[remapit[whichpen]], hostgreen[remapit[whichpen]], hostblue[remapit[whichpen]]);
printf("Setting host colour %3d to %X%X%X\n",
remapit[whichpen], nybblered, nybblegreen, nybbleblue); */
}   }   }

EXPORT SLONG goodrand(void)
{   ULONG seconds, micros;
    SLONG value;

    // SAS/C rand() is crap and never returns certain numbers, so
    // we adjust the value with the timer to increase the randomness
    // (otherwise endless loops can happen).

    CurrentTime(&seconds, &micros);
    value = rand() + micros + seconds;

    return (SLONG) (value & 0x7FFFFFFF);
}

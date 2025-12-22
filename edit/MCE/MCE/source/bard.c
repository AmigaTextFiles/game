/* Filename conventions:
   BT1:  TPW.<name>.C or ITEMS
   BT2:  TPW.<name>.C or ITEMS or save.game
   BT3:  THIEVES.INF or game.sav
   BTCS: ROSTER.CHR

1. INCLUDES ----------------------------------------------------------- */

#ifdef __amigaos4__
    #ifndef __USE_INLINE__
        #define __USE_INLINE__ // define this as early as possible
    #endif
#endif
#ifdef __LCLINT__
    typedef char* STRPTR;
    typedef char* CONST_STRPTR;
    typedef char  TEXT;
    #define ASM
    #define REG(x)
    #define __inline
#endif

#include <exec/types.h>
#include <exec/memory.h>
#include <dos/dos.h>
#include <intuition/intuition.h>
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>
#ifndef __MORPHOS__
    #include <gadgets/clock.h>
#endif

#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <clib/alib_protos.h>

#include <ctype.h>
#include <stdio.h>                           /* FILE, printf() */
#include <stdlib.h>                          /* EXIT_SUCCESS, EXIT_FAILURE */
#include <string.h>
#include <assert.h>

#ifdef LATTICE
    #include <dos.h>                         // geta4()
#endif

#include "mce.h"

/* 2. DEFINES ------------------------------------------------------------

main window */
#define GID_BT_LY1     0 // root layout
#define GID_BT_SB1     1
#define GID_BT_ST1     2 // character name
#define GID_BT_CH1     3
#define GID_BT_CH2     4
#define GID_BT_CH3     5
#define GID_BT_CH4     6
#define GID_BT_CH5     7
#define GID_BT_IN1     8
#define GID_BT_IN2     9
#define GID_BT_IN3    10
#define GID_BT_IN4    11
#define GID_BT_IN5    12
#define GID_BT_IN6    13
#define GID_BT_IN7    14
#define GID_BT_IN8    15
#define GID_BT_IN9    16
#define GID_BT_IN10   17
#define GID_BT_IN11   18
#define GID_BT_IN12   19
#define GID_BT_IN13   20
#define GID_BT_IN14   21
#define GID_BT_IN15   22
#define GID_BT_IN16   23
#define GID_BT_IN17   24
#define GID_BT_IN18   25
#define GID_BT_IN19   26
#define GID_BT_IN20   27
#define GID_BT_IN21   28
#define GID_BT_IN22   29
#define GID_BT_IN23   30
#define GID_BT_IN24   31
#define GID_BT_IN25   32
#define GID_BT_IN26   33
#define GID_BT_IN27   34
#define GID_BT_IN28   35
#define GID_BT_IN29   36 // first item integer
#define GID_BT_IN30   37
#define GID_BT_IN31   38
#define GID_BT_IN32   39
#define GID_BT_IN33   40
#define GID_BT_IN34   41
#define GID_BT_IN35   42
#define GID_BT_IN36   43
#define GID_BT_IN37   44
#define GID_BT_IN38   45
#define GID_BT_IN39   46
#define GID_BT_IN40   47 // last item integer
#define GID_BT_BU1    48 // damage range max
#define GID_BT_BU2    49 // first item button
#define GID_BT_BU3    50
#define GID_BT_BU4    51
#define GID_BT_BU5    52
#define GID_BT_BU6    53
#define GID_BT_BU7    54
#define GID_BT_BU8    55
#define GID_BT_BU9    56
#define GID_BT_BU10   57
#define GID_BT_BU11   58
#define GID_BT_BU12   59
#define GID_BT_BU13   60 // last item button
#define GID_BT_BU14   61 // maximize character
#define GID_BT_BU15   62 // maximize roster
#define GID_BT_BU16   63 // all
#define GID_BT_BU17   64 // none
#define GID_BT_BU18   65 // invert selection
#define GID_BT_CB1    66 // first item checkbox
#define GID_BT_CB12   77 // last item checkbox
#define GID_BT_LB2    78 // spells
#define GID_BT_LB3    79 // classes
#define GID_BT_IN41   80 // character #
#define GID_BT_IN42   81 // of #
#define GID_BT_CH6    82 // filetype
#define GID_BT_CH7    83 // location
#define GID_BT_BU19   84 // bank
#define GID_BT_BU20   85 // shoppe
#define GID_BT_BU21   86 // reset items file
#define GID_BT_BU22   87 // maximize items file
#define GID_BT_BU23   88 // when & where...

// items subwindow
#define GID_BT_LY2    89
#define GID_BT_LB1    90

// bank subwindow
#define GID_BT_LY3    91
#define GID_BT_IN43   92 //  1st account ID
#define GID_BT_IN52  101 // 10th account ID
#define GID_BT_IN53  102 //  1st account balance
#define GID_BT_IN62  111 // 10th account balance

// shoppe subwindow
#define GID_BT_LY4   112
#define GID_BT_IN63  113 //   1st shop item
#define GID_BT_IN189 239 // 127th shop item
#define GID_BT_LY5   240 //   1st shop item
#define GID_BT_LY131 366 // 127th shop item

// map subwindow
#define GID_BT_LY132 367 // when & where
#define GID_BT_SP1   368 // map
#define GID_BT_CH8   369 // facing (outdoor/BT3)
#define GID_BT_CH9   370 // plane
#define GID_BT_CH10  371 // area
#define GID_BT_CH11  372 // facing (BT2 dungeon)
#define GID_BT_CL1   373 // hour
#define GID_BT_IN190 374 // hour
#define GID_BT_IN191 375 // X
#define GID_BT_IN192 376 // Y
#define GID_BT_IN193 377 // dungeon level
#define GID_BT_IN194 378 // BT2 dungeon X
#define GID_BT_IN195 379 // BT2 dungeon Y
#define GID_BT_BU24  380 // hint oracle
#define GID_BT_ST2   381 // dungeon name

#define GIDS_BT      GID_BT_ST2

#define ItemGads(x)                                                       \
AddHLayout,                                                               \
    LAYOUT_AddChild,          gadgets[GID_BT_CB1  + x] = (struct Gadget*) \
    TickOrCheckBoxObject,                                                 \
        GA_ID,                GID_BT_CB1  + x,                            \
    End,                                                                  \
    CHILD_WeightedWidth,      0,                                          \
    LAYOUT_AddChild,          gadgets[GID_BT_IN29 + x] = (struct Gadget*) \
    IntegerObject,                                                        \
        GA_ID,                GID_BT_IN29 + x,                            \
        GA_TabCycle,          TRUE,                                       \
        INTEGER_Minimum,      0,                                          \
        INTEGER_Maximum,      255,                                        \
        INTEGER_MinVisible,   3 + 1,                                      \
    IntegerEnd,                                                           \
    CHILD_WeightedWidth,      0,                                          \
    LAYOUT_AddChild,          gadgets[GID_BT_BU2  + x] = (struct Gadget*) \
    ZButtonObject,                                                        \
        GA_ID,                GID_BT_BU2  + x,                            \
        GA_RelVerify,         TRUE,                                       \
        BUTTON_Justification, LCJ_LEFT,                                   \
    ButtonEnd,                                                            \
LayoutEnd

#define AddBank(x)                                                        \
AddHLayout,                                                               \
    LAYOUT_VertAlignment,     LALIGN_CENTER,                              \
    LAYOUT_AddChild,          gadgets[GID_BT_IN43 + x] = (struct Gadget*) \
    IntegerObject,                                                        \
        GA_ID,                GID_BT_IN43 + x,                            \
        GA_TabCycle,          TRUE,                                       \
        GA_RelVerify,         TRUE,                                       \
        INTEGER_Minimum,      0,                                          \
        INTEGER_Maximum,      9999,                                       \
        INTEGER_MinVisible,   4 + 1,                                      \
        INTEGER_Number,       accountid[x],                               \
    IntegerEnd,                                                           \
    Label("Account:"),                                                    \
    CHILD_WeightedWidth,      0,                                          \
    LAYOUT_AddChild,          gadgets[GID_BT_IN53 + x] = (struct Gadget*) \
    IntegerObject,                                                        \
        GA_ID,                GID_BT_IN53 + x,                            \
        GA_TabCycle,          TRUE,                                       \
        GA_Disabled,          accountid[x] ? FALSE : TRUE,                \
        INTEGER_Minimum,      0,                                          \
        INTEGER_MinVisible,   10 + 1,                                     \
        INTEGER_Number,       accountbalance[x],                          \
    ButtonEnd,                                                            \
    Label("Amount:"),                                                     \
    AddLabel("gp"),                                                       \
LayoutEnd

#define AddShop(x) LAYOUT_AddChild, (ULONG) gadgets[GID_BT_LY5 + x - 1]

#define MEN                  64 // BTCS supports at least 40

#define SUBMODE_ITEMS         0
#define SUBMODE_BANK          1
#define SUBMODE_SHOP          2
#define SUBMODE_MAP           3

#define FT_FLAG_C             0
#define FT_FLAG_R             1
#define FT_FLAG_I             2
#define FT_FLAG_S             3

#define CLASSGAD_ARCHMAGE     0
#define CLASSGAD_BARD         1
#define CLASSGAD_CHRONOMANCER 2
#define CLASSGAD_CONJURER     3
#define CLASSGAD_GEOMANCER    4
#define CLASSGAD_HUNTER       5
#define CLASSGAD_ILLUSION     6
#define CLASSGAD_MAGICIAN     7
#define CLASSGAD_MONK         8
#define CLASSGAD_MONSTER      9
#define CLASSGAD_PALADIN     10
#define CLASSGAD_ROGUE       11
#define CLASSGAD_SORCERER    12
#define CLASSGAD_WARRIOR     13
#define CLASSGAD_WIZARD      14

#define RACEGAD_HUMAN         6

#define ITEMS               342 // actual number of items available (not counting "Nothing") (was 291)
#define SPELLS              125 // counting from one

#define MAPWIDTH             22
#define MAPHEIGHT            22
#define SCALEDWIDTH         ((MAPWIDTH  * scalex) + 1)
#define SCALEDHEIGHT        ((MAPHEIGHT * scaley) + 1)

//      MAZEBLACK             0
//      MAZEWHITE             1
#define GREEN                 2
#define RED                   3
#define BLUE                  4
#define LIGHTGREEN            5
#define LIGHTYELLOW           6
#define PINK                  7
#define DARKGREY              8
#define PURPLE                9

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE FLAG filetovars(void);
MODULE void readgadgets(void);
MODULE void itemwindow(void);
MODULE void load_bt2(void);
MODULE void save_bt2(void);
MODULE void serialize_bt1(void);
MODULE void serialize_bt2(void);
MODULE void serialize_bt3(void);
MODULE void serialize_btcs(void);
MODULE void filetovar_race(int whichman, UBYTE thebyte);
MODULE void filetovar_class(int whichman, UBYTE thebyte);
MODULE void filetovar_status(int whichman, UBYTE thebyte);
MODULE UBYTE vartofile_race(int whichman);
MODULE UBYTE vartofile_class(int whichman);
MODULE UBYTE vartofile_status(int whichman);
MODULE void writegadgets(ULONG mode);
MODULE void maximize_man(int whichman);
MODULE void make_classes(void);
MODULE void bankwindow(void);
MODULE void shopwindow(void);
MODULE void mapwindow(void);
MODULE void drawcircle(int x, int y);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                game,
                            offset,
                            showtoolbar;
IMPORT LONG                 pens[PENS],
                            whitepen;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT int                  function,
                            gamesize,
                            loaded,
                            n1, n2,
                            page,
                            scalex,
                            scaley,
                            serializemode,
                            xoffset,
                            yoffset;
IMPORT UBYTE*               byteptr1[MAXHEIGHT];
IMPORT __aligned UBYTE      display1[GFXINIT(MAXWIDTH, MAXHEIGHT)];
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SexList,
                            SpeedBarList;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;
#ifndef __MORPHOS__
    IMPORT struct ClassLibrary* ClockBase;
    IMPORT Class*               ClockClass;
    IMPORT UWORD*               MouseData;
#endif

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

/* 6. MODULE VARIABLES --------------------------------------------------- */

MODULE FLAG                 lbtips;
MODULE TEXT                 dgnname[16 + 1],
                            hintstring[SPELLS][512 + 1],
                            ShopName[128][30 + 1];
MODULE ULONG                accountbalance[10],
                            accountid[10],
                            area,
                            dgnlevel,
                            facing1,
                            facing2,
                            filetype,
                            garth[128],
                            hour,
                            location           = 0,
                            location_x1, location_x2,
                            location_y1, location_y2,
                            men,
                            plane,
                            who                = 0;
MODULE int                  submode,
                            whichitem,
                            whichmap;
MODULE struct List          ClassesList,
                            FacingList1,
                            FacingList2,
                            ItemsList,
                            SpellsList;
MODULE const STRPTR         GameOptions[4 + 1] =
{ "BT1",
  "BT2",
  "BT3",
  "BTCS",
  NULL
}, FiletypeOptions[4 + 1] =
{ "Character file",
  "Roster file",
  "Items file",
  "Saved game",
  NULL
}, LocationOptions[6 + 1] =
{ "Tangramayne",
  "Ephesus",
  "Philippi",
  "Colosse",
  "Corinth",
  "Thessalonica",
  NULL
}, RaceOptions[7 + 1] =
{ "Dwarf",
  "Elf",
  "Gnome",
  "Half-Elf",
  "Half-Orc",
  "Hobbit",
  "Human",
  NULL
}, SpecialOptions[10 + 1] =
{ "Normal",
  "Aging",
  "Critical hit",
  "Insanity",
  "Item-zot",
  "Level drain",
  "Point Phaze",
  "Poison",
  "Possession",
  "Stoning",
  NULL
}, StatusOptions[8 + 1] =
{ "OK",
  "Dead",
  "Insane",
  "Old",
  "Paralyzed",
  "Poisoned",
  "Possessed",
  "Stoned",
  NULL
}, PlaneOptions[] =
{ "Realm",
  "Arboria",
  "Gelidia",
  "Lucencia",
  "Kinestia",
  "Tenebrosia",
  "Tarmitia",
  "Malefia",
  NULL
}, Area2Options[] =
{ "Wilderness",
  "Tangramayne",
  "Ephesus",
  "Philippi",
  "Colosse",
  "Corinth",
  "Thessalonica",
  NULL
}, Area3Options[8][17 + 1] = {
{ "Realm wilderness",
  "Skara Brae",
  "Catacombs 1",
  "Catacombs 2 aka Tunnels",
  "UnterBrae 1",
  "UnterBrae 2",
  "UnterBrae 3",
  "UnterBrae 4",
  NULL
},
{ "Arborian wilderness",
  "Ciera Brannia",
  "Festering Pit 1",
  "Festering Pit 2",
  "Crystal Palace",
  "Valarian's Tower 1",
  "Valarian's Tower 2",
  "Valarian's Tower 3",
  "Valarian's Tower 4",
  "Sacred Grove",
  NULL
},
{ "Gelidian wilderness",
  "White Tower 1",
  "White Tower 2",
  "White Tower 3",
  "White Tower 4",
  "Grey Tower 1",
  "Grey Tower 2",
  "Grey Tower 3",
  "Grey Tower 4",
  "Black Tower 1",
  "Black Tower 2",
  "Black Tower 3",
  "Black Tower 4",
  "Ice Dungeon 1",
  "Ice Dungeon 1",
  "Ice Keep 1",
  "Ice Keep 2",
  NULL
},
{ "Lucencian wilderness",
  "Celaria Bree",
  "Violet Mountain 1",
  "Violet Mountain 2",
  "Cyanis' Tower 1",
  "Cyanis' Tower 2",
  "Cyanis' Tower 3",
  "Alliria's Tomb 1",
  "Alliria's Tomb 2",
  NULL
},
{ "Barracks",
  "Ferofist's Palace",
  "Private Quarters",
  "Workshop",
  "Urmech's Paradise",
  "Viscous Plane",
  "Urmech's Sanctum",
  NULL
},
{ "Nowhere",
  "Dark Copse",
  "Black Scar",
  "Tar quarry",
  "Shadow Canyon",
  "Sceadu's Demesne 1",
  "Sceadu's Demesne 2",
},
{ "Tarmitian dungeon",
  "Wasteland",
  "Berlin",
  "Stalingrad",
  "Hiroshima",
  "Troy",
  "Rome",
  "Nottingham",
  "K'un Wang",
  NULL
},
{ "Malefia 1",
  "Malefia 2",
  "Malefia 3",
  "Tarjan",
  NULL
} }, ClassOptions[15] =
{ "Archmage",
  "Bard",
  "Chronomancer",
  "Conjurer",
  "Geomancer",
  "Hunter",
  "Illusion",
  "Magician",
  "Monk",
  "Monster",
  "Paladin",
  "Rogue",
  "Sorcerer",
  "Warrior",
  "Wizard"
  // NULL is not needed here
}, ClassAbbrevs[15] =
{ "Am",
  "Ba",
  "Ch",
  "Co",
  "Ge",
  "Hu",
  "Il",
  "Ma",
  "Mo",
  "Mn",
  "Pa",
  "Ro",
  "So",
  "Wa",
  "Wi"
  // NULL is not needed here
}, FacingOptions[4] =
{ "North",
  "East",
  "South",
  "West"
  // NULL is not needed here
};

MODULE const struct
{   UBYTE x, y;
} sizes[71] = {
{ 20, 20 }, //  0 Realm wilderness
{ 17, 17 }, //  1 Skara Brae
{ 13, 13 }, //  2 Catacombs 1
{ 22, 10 }, //  3 Catacombs 2 aka Tunnels
{ 15, 15 }, //  4 UnterBrae 1
{ 15, 15 }, //  5 UnterBrae 2
{ 15, 15 }, //  6 UnterBrae 3
{ 10, 22 }, //  7 UnterBrae 4
{ 12, 12 }, //  8 Arborian wilderness
{ 16, 16 }, //  9 Ciera Brannia
{ 15, 15 }, // 10 Festering Pit 1
{ 12, 12 }, // 11 Festering Pit 2
{ 15, 10 }, // 12 Crystal Palace
{  5,  5 }, // 13 Valarian's Tower 1
{  5,  5 }, // 14 Valarian's Tower 2
{  5,  5 }, // 15 Valarian's Tower 3
{  5,  5 }, // 16 Valarian's Tower 4
{ 10, 10 }, // 17 Sacred Grove
{ 16, 16 }, // 18 Gelidian wilderness
{  5,  5 }, // 19 White Tower 1
{  5,  5 }, // 20 White Tower 2
{  5,  5 }, // 21 White Tower 3
{  5,  5 }, // 22 White Tower 4
{  5,  5 }, // 23 Grey Tower 1
{  5,  5 }, // 24 Grey Tower 2
{  5,  5 }, // 25 Grey Tower 3
{  5,  5 }, // 26 Grey Tower 4
{  5,  5 }, // 27 Black Tower 1
{  5,  5 }, // 28 Black Tower 2
{  5,  5 }, // 29 Black Tower 3
{  5,  5 }, // 30 Black Tower 4
{  9,  9 }, // 31 Ice Dungeon 1
{  5,  5 }, // 32 Ice Dungeon 2
{ 12, 10 }, // 33 Ice Keep 1
{ 12, 10 }, // 34 Ice Keep 2
{ 12, 12 }, // 35 Lucencian wilderness
{ 16, 16 }, // 36 Celaria Bree
{ 18, 18 }, // 37 Violet Mountain 1
{ 11, 11 }, // 38 Violet Mountain 2
{  7,  7 }, // 39 Cyanis' Tower 1
{  7,  7 }, // 40 Cyanis' Tower 2
{  7,  7 }, // 41 Cyanis' Tower 3
{ 13, 17 }, // 42 Alliria's Tomb 1
{ 13,  9 }, // 43 Alliria's Tomb 2
{ 12, 15 }, // 44 Barracks
{ 18, 18 }, // 45 Ferofist's Palace
{  9, 17 }, // 46 Private Quarters
{  9,  9 }, // 47 Workshop 1
{ 15, 15 }, // 48 Workshop 2 aka Urmech's Paradise
{ 15,  9 }, // 49 Workshop 3 aka Viscous Plane
{ 13, 13 }, // 50 Workshop 4 aka Urmech's Sanctum
{ 11, 11 }, // 51 Nowhere aka Tenebrosian wilderness
{ 11, 11 }, // 52 Dark Copse
{ 16, 16 }, // 53 Black Scar
{ 11, 17 }, // 54 Tar quarry
{ 13, 22 }, // 55 Shadow Canyon
{ 15, 15 }, // 56 Sceadu's Demesne 1
{ 15, 15 }, // 57 Sceadu's Demesne 2
{ 12, 12 }, // 58 Tarmitian dungeon
{ 11, 17 }, // 59 Wasteland
{ 12, 12 }, // 60 Berlin
{ 12, 12 }, // 61 Stalingrad
{ 12, 12 }, // 62 Hiroshima
{ 12, 12 }, // 63 Troy
{ 12, 12 }, // 64 Rome
{ 12, 12 }, // 65 Nottingham
{ 12, 16 }, // 66 K'un Wang
{ 22, 22 }, // 67 Malefia 1
{ 22, 22 }, // 68 Malefia 2
{ 22, 22 }, // 69 Malefia 3
{  6,  6 }, // 70 Tarjan
};

MODULE const UBYTE bt3_map[71][(MAPHEIGHT * 2) + 1][(MAPWIDTH * 2) + 1 + 1] = { {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", //  0. Realm wilderness
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"                  +-----+  *             XXXX",
" #   *            |^ ^ ^|                XXXX",
"          +-----+ +-+ +-+       +-+-+    XXXX",
"   * *    |^ ^ ^|   |^|         |^ ^|    XXXX",
"          +-+ +-+   +-+   +-+   | +-+-+  XXXX",
"   *        |^|           |^|   |^|#|^|  XXXX",
"            +-+   +-----+ +-+   | | | |  XXXX",
"                  |# # #|    *  |^| |^|  XXXX",
"          +-+     +-+   |       +-+ +-+  XXXX",
"          |^|       |# #|                XXXX",
"  +---+   | +---+ +-+   |         +-----+XXXX",
"  |^ ^|   |^ ^ ^| |# # #|  *      |^ ^ ^|XXXX",
"  +---+   +---+ | +-----+   +-----+---+ |XXXX",
"              |^|           |^ ^ ^|   |^|XXXX",
"          +-+ +-+       +-+ | +---+   +-+XXXX",
"          |^|           |^| |^|#   #     XXXX",
"    +---+ +-+ +-+       +-+ | |          XXXX",
"    |^ ^|    *|^|           |^|          XXXX",
"    +---+-+   +-+           +-+          XXXX",
"        |^|          #               *   XXXX",
"    +---+-+               +-+   +-+      XXXX",
"    |^ ^|                 |^|   |^|  * # XXXX",
"    +---+-+               | | +-+-+      XXXX",
"   #    |^|            *  |^| |^|    * * XXXX",
"      +-+-+               | | +-+        XXXX",
"      |^|        *        |^|            XXXX",
"  +-+ +-+ +-----+         +-+   +-+      XXXX",
"  |^|     |^ ^ ^|               |^|      XXXX",
"  +-+     | +---+ +-+ +-+       +-+      XXXX",
"          |^|#    |^| |^|              * XXXX",
"          | +---+ +-+ +-+                XXXX",
"   * * *  |^ ^ ^|                        XXXX",
"          |     |     +-+                XXXX",
" *   # *  |^ ^ ^|     |^|      * * *   * XXXX",
"          +-----+   +-+-+                XXXX",
" *   * *            |^|      *       *   XXXX",
"                    +-+                  XXXX",
" *   *                       *   *   #   XXXX",
"                    +-+ +-+              XXXX",
"                    |^| |^|      *       XXXX",
"                    +-+ +-+              XXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", //  1. Skara Brae
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"            +-+-+                  XXXXXXXXXX",
"            | | |                  XXXXXXXXXX",
"    +-+-+---+=+=+-+-+-+-+-+-+-+    XXXXXXXXXX",
"    | | =       = | | | | | = |    XXXXXXXXXX",
"  +-+=+=+=+=+=+ +=+=+=+=+=+-+ +-+  XXXXXXXXXX",
"  |     = | | =           = = =#|  XXXXXXXXXX",
"  | +=+ +-+-+-+       +-+ +=+ +-+  XXXXXXXXXX",
"  | = = = | | =       | |     = |  XXXXXXXXXX",
"  +=+=+ +=+-+-+       +-+=+=+ +-+  XXXXXXXXXX",
"  | =     = | =       =#| | = = |  XXXXXXXXXX",
"+-+-+ +-+ +=+-+       +-+-+-+ +-+  XXXXXXXXXX",
"| | = | |   = =       = | | = = |  XXXXXXXXXX",
"+=+=+ +-+=+ +=+       +-+ +-+ +-+  XXXXXXXXXX",
"      =#| =           = |   | |    XXXXXXXXXX",
"+=+=+ +-+-+=+=+=+=+=+-+-+-+-+ +-+  XXXXXXXXXX",
"| | = | | | | | | | | | | =   = |  XXXXXXXXXX",
"+-+=+ +-+=+=+=+=+=+=+-+=+=+   +-+  XXXXXXXXXX",
"| =                 = =       |    XXXXXXXXXX",
"+-+   +=+ +=+       +-+ +=+=+ +-+-+XXXXXXXXXX",
"| =   = = = =       = = = | =   = |XXXXXXXXXX",
"+-+=+ +=+ +-+ +=+ +=+-+ +=+-+=+ +-+XXXXXXXXXX",
"  | =     = = = = = | =   = | = |  XXXXXXXXXX",
"  +-+ +=+ +-+ +=+ +=+-+=+=+-+-+ +-+XXXXXXXXXX",
"  | = = = = =       | | | |   | = |XXXXXXXXXX",
"  +=+ +-+ +-+ +-+   +-+-+-+ +-+ +-+XXXXXXXXXX",
"  |   = = = = | |   = |     | = |  XXXXXXXXXX",
"  +=+-+-+ +-+ +-+   +-+     +-+ +-+XXXXXXXXXX",
"  | | | = = =       = |       |#= |XXXXXXXXXX",
"  +-+ +-+ +-+ +-+   +-+     +-+ +-+XXXXXXXXXX",
"      | = | | | |   = |     | = |  XXXXXXXXXX",
"      +-+ +-+ +-+ +=+-+     +-+ +-+XXXXXXXXXX",
"      | = = =     = |         | = |XXXXXXXXXX",
"      +-+=+-+=+=+=+-+       +-+ +-+XXXXXXXXXX",
"        | | | | | |         | = |  XXXXXXXXXX",
"        +-+ +-+-+-+         +-+ +-+XXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", //  2. Catacombs 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXXXXXXXX",
"|   |d= = = = = |     |/ /|XXXXXXXXXXXXXXXXXX",
"+=+ +-+-+-+-+-+=+-+   +   +XXXXXXXXXXXXXXXXXX",
"| | =             =   |/ /|XXXXXXXXXXXXXXXXXX",
"+=+ +-+-+-+=+-+=+ +-+-+   +XXXXXXXXXXXXXXXXXX",
"| | |     | |   |         |XXXXXXXXXXXXXXXXXX",
"+-+=+   +-+-+-+-+ +   +   +XXXXXXXXXXXXXXXXXX",
"|       |     =   |   |   |XXXXXXXXXXXXXXXXXX",
"+=+-+   +-+-+-+   +-+=+-+ +XXXXXXXXXXXXXXXXXX",
"|   |   =             |   |XXXXXXXXXXXXXXXXXX",
"+ +=+   +-+   +-+=+-+=+   +XXXXXXXXXXXXXXXXXX",
"| = |  4= |   | = = |     |XXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+-+=+-+-+-+=+-+-+XXXXXXXXXXXXXXXXXX",
"|   |       |     =      3|XXXXXXXXXXXXXXXXXX",
"+   +       +-+   +-+-+   +XXXXXXXXXXXXXXXXXX",
"|   |       = |     | |   |XXXXXXXXXXXXXXXXXX",
"+   +-+=+-+-+ +-+-+=+=+   +XXXXXXXXXXXXXXXXXX",
"|       |   |   | =   |   |XXXXXXXXXXXXXXXXXX",
"+ +-+-+ +   +=+=+-+-+-+   +XXXXXXXXXXXXXXXXXX",
"| |   | |       =         |XXXXXXXXXXXXXXXXXX",
"+ +-+=+=+-+-+   +-+-+=+-+ +XXXXXXXXXXXXXXXXXX",
"|       =   |   |   =   | |XXXXXXXXXXXXXXXXXX",
"+=+-+-+=+   +=+=+   +   + +XXXXXXXXXXXXXXXXXX",
"|  2  | |   |   |   |   = |XXXXXXXXXXXXXXXXXX",
"+-+-+-+ +-+-+   +-+-+-+-+ +XXXXXXXXXXXXXXXXXX",
"+u   1          |         |XXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", //  3. Catacombs 2 aka Tunnels
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+",
"    |   |     | =   = | |# # / # #|       =/ ",
"  +=+-+=+=+-+=+-+   +=+=+ +=+ +-+=+=+-+-+-+  ",
"  |   = = |     |   |     | |/| = = =   | |/ ",
"+-+-+-+=+=+ +-+=+=+-+-+-+-+ +-+-+=+-+   +=+-+",
"  |   |   | = |   | =     = |/    | |   = |/ ",
"+=+=+=+   + +-+   +=+-+=+-+-+=+=+-+ +=+-+=+  ",
"    | |   |         | = |    /|   | =   | =/ ",
"+-+-+ +-+-+-+=+-+-+-+-+ +-+=+-+=+=+-+   +-+=+",
"|     |           |   = =   |/    |     |  /|",
"+-+=+-+-+-+-+-+   + +-+ +-+-+-+-+=+-+-+=+   +",
"|   |   | |   |   | |  6    =/      | = -  /|",
"+=+-+=+-+ +-+=+ +-+-+-+=+-+-+-+-+-+=+=+=+-+=+",
"=   |2    |   | |     | |    /|   |   |    /=",
"+-+-+=+-+=+=+=+=+-+=+-+ +-+=+-+=+=+-+-+=+-+-+",
"    | |   = |       | =      /  | = = = = |/ ",
"+-+-+ +   +-+-+-+-+=+ +=+-+-+=+-+=+=+-+=+-+ +",
"|    1|       |   =3  | =   |4= |   | = = |/|",
"+=+-+-+-+=+-+=+   +-+=+-+=+=+=+-+=+-+=+-+=+ +",
"|u|   |   |   |   |       | |/      | = |5=/|",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", //  4. UnterBrae 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXXXX",
"|               |     =M d@ |4|XXXXXXXXXXXXXX",
"+ +-+ +-----+   +=+---+---+ + +XXXXXXXXXXXXXX",
"| |             | =   =   |   |XXXXXXXXXXXXXX",
"+ + +-+       + +-+---+-+=+   +XXXXXXXXXXXXXX",
"|   |#|       | | =   =   |   |XXXXXXXXXXXXXX",
"+   +-+ +---+-+ +=+---+---+   +XXXXXXXXXXXXXX",
"|           | |               |XXXXXXXXXXXXXX",
"+   + +-+=+ +=+   +=+-+   +=+-+XXXXXXXXXXXXXX",
"|   | |   |       |   |   |3=#|XXXXXXXXXXXXXX",
"+-+-+=+   +-+ +   +---+ +=+-+-+XXXXXXXXXXXXXX",
"|5|/ /|       |/ /    | = =   |XXXXXXXXXXXXXX",
"| +   + +-----+===+---+-+=+-+ +XXXXXXXXXXXXXX",
"|     = |     |/ /            |XXXXXXXXXXXXXX",
"+---+=+=+=+   |   +-----+     +XXXXXXXXXXXXXX",
"|     |   |   |  /|     |/ / /|XXXXXXXXXXXXXX",
"+   +-+   +---+   | +   +=+---+XXXXXXXXXXXXXX",
"|   |             | |   | =/ /|XXXXXXXXXXXXXX",
"+---+-+=+-+-+   +-+=+---+=+   +XXXXXXXXXXXXXX",
"|   =     | |   |         |   |XXXXXXXXXXXXXX",
"|   +-+   | |   + +   +-+-+   +XXXXXXXXXXXXXX",
"|     |   | |   | |   |   =   |XXXXXXXXXXXXXX",
"| +   +---+=+-+=+-+=+-+---+   |XXXXXXXXXXXXXX",
"| |       |                   |XXXXXXXXXXXXXX",
"| +-+   +-+   +-----+ +=+     |XXXXXXXXXXXXXX",
"|             |     | | |     |XXXXXXXXXXXXXX",
"|   +   +     +-+=+-+ | |     |XXXXXXXXXXXXXX",
"|   |   |             | |     |XXXXXXXXXXXXXX",
"| +-+   |   +   +-----+ +-----+XXXXXXXXXXXXXX",
"|  2|   |   |              1 u|XXXXXXXXXXXXXX",
"+---+---+---+-----------------+XXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", //  5. UnterBrae 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-------------+---------+-----+XXXXXXXXXXXXXX",
"|             |         |u    |XXXXXXXXXXXXXX",
"|   +---+   +=+=+-+=+=+-+ +   |XXXXXXXXXXXXXX",
"|   |   =   |     | |   =1|   |XXXXXXXXXXXXXX",
"+---+-+=+   +---+-+ +-+=+ + +-+XXXXXXXXXXXXXX",
"|     = |   |   |             |XXXXXXXXXXXXXX",
"+-+---+ + +-+=+-+   +-+ +-----+XXXXXXXXXXXXXX",
"| |     | | = | |/ /|/ /|     |XXXXXXXXXXXXXX",
"+ +=+   + +-+=+ + +-+   +-+=+-+XXXXXXXXXXXXXX",
"|   |   |     | |       = = =2|XXXXXXXXXXXXXX",
"+   +---+-----+ +---+   +-+=+-+XXXXXXXXXXXXXX",
"|                   |   |     |XXXXXXXXXXXXXX",
"+     +===+=+---+   +-+ +-+---+XXXXXXXXXXXXXX",
"|     | = | =         |   |   |XXXXXXXXXXXXXX",
"+-+-+-+===+=+---+-+   +-+ |   |XXXXXXXXXXXXXX",
"|   |     |     | |     | |   |XXXXXXXXXXXXXX",
"+   +-+-+@+     + +-+---+=+   |XXXXXXXXXXXXXX",
"|        /&     |   |     |   |XXXXXXXXXXXXXX",
"+&+&+     &     +-+=+ +-+ +   |XXXXXXXXXXXXXX",
"|d| &    /&           | |     |XXXXXXXXXXXXXX",
"| | &     &           +=+     |XXXXXXXXXXXXXX",
"|4| &    /&                   |XXXXXXXXXXXXXX",
"| + +     +&&&+&&&+@+@+&&&&&&&+XXXXXXXXXXXXXX",
"| =R     / /  &               |XXXXXXXXXXXXXX",
"+&&&&&&&+     +     +     +   |XXXXXXXXXXXXXX",
"|   &               |     |   |XXXXXXXXXXXXXX",
"|   &   +-------+   +-+---+ +-+XXXXXXXXXXXXXX",
"|   &   |       |     |       |XXXXXXXXXXXXXX",
"|   +   + +-----+ +-+ +-+     |XXXXXXXXXXXXXX",
"|                    3|       |XXXXXXXXXXXXXX",
"+---+-----------------+-+-+-+-+XXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", //  6. UnterBrae 3
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---------------+-----+---+---+XXXXXXXXXXXXXX",
"|               |     |   |   |XXXXXXXXXXXXXX",
"| +---+=+---+=+ +-+=+-+-+=+   |XXXXXXXXXXXXXX",
"| |6        | | = =   |   =   |XXXXXXXXXXXXXX",
"+ +-----+   | +-+ +   +   +---+XXXXXXXXXXXXXX",
"| |         |   | |   =   |   |XXXXXXXXXXXXXX",
"+ +-+=+---+-+-+ +-+   +   +   |XXXXXXXXXXXXXX",
"|   =     |   |   |   |       |XXXXXXXXXXXXXX",
"+---+     +   +---+-+=+---+---+XXXXXXXXXXXXXX",
"|             | = =   =   |  3|XXXXXXXXXXXXXX",
"+-+   +=+---+=+=+-+   +   +=+-|XXXXXXXXXXXXXX",
"|     |     | |   |   |   |   |XXXXXXXXXXXXXX",
"+   +-+ +---+ +   +---+   +-+=|XXXXXXXXXXXXXX",
"|     | |   |     |       |   |XXXXXXXXXXXXXX",
"+-+-+-+-+   +-----+=+-----+=+-|XXXXXXXXXXXXXX",
"| |  /      =     =         = |XXXXXXXXXXXXXX",
"| +-----+   +-----+   +---+-+ |XXXXXXXXXXXXXX",
"|1|     |   |     |   |   |   |XXXXXXXXXXXXXX",
"| |     +---+-+---+-+=+===+ + |XXXXXXXXXXXXXX",
"|u|#          |2    |       | |XXXXXXXXXXXXXX",
"+-+-+---+     + +---+     +-+ |XXXXXXXXXXXXXX",
"|   |         | |   |     = | |XXXXXXXXXXXXXX",
"|   |     +=+-+ +===+ +=+ +-+ |XXXXXXXXXXXXXX",
"|   |     |   =       | |     |XXXXXXXXXXXXXX",
"|   +-----+   +-----+=+-+---+=+XXXXXXXXXXXXXX",
"|  #     #    |4=   |  # #    |XXXXXXXXXXXXXX",
"+---+         +=+-+=+ +     +=+XXXXXXXXXXXXXX",
"|   |             | = |     | |XXXXXXXXXXXXXX",
"|   +     +-+     +=+-+-+ +-+ |XXXXXXXXXXXXXX",
"|d 5=R    |       |   | = |   |XXXXXXXXXXXXXX",
"+---+-----+-------+---+-+-+---+XXXXXXXXXXXXXX",
}, {
"+---+---------------+XXXXXXXXXXXXXXXXXXXXXXXX", //  7. UnterBrae 4
"|   |/              |XXXXXXXXXXXXXXXXXXXXXXXX",
"|   |               |XXXXXXXXXXXXXXXXXXXXXXXX",
"|  B|/ / / /        |XXXXXXXXXXXXXXXXXXXXXXXX",
"|=+-+               |XXXXXXXXXXXXXXXXXXXXXXXX",
"|/ / /     /        |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|          / / /    |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|  / / /       /    |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|/ / / / / / / /    |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|  / / / / / /      |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|  / / / / / / # # #|XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|# # # / 2 / / # # #|XXXXXXXXXXXXXXXXXXXXXXXX",
"+-------+ +---------+XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"+@+@+@+@+@+@+@+@+@+@+XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"+@+@+@+@+@+@+@+@+@+@+XXXXXXXXXXXXXXXXXXXXXXXX",
"|    / / / / / /    |XXXXXXXXXXXXXXXXXXXXXXXX",
"+@+@+@+@+@+@+@+@+@+@+XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"+@+@+@+@+@+@+@+@+@+@+XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"+@+@+@+@+@+@+@+@+@+@+XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"+@+@+@+@+@+@+@+@+@+@+XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"+-------+ +---------+XXXXXXXXXXXXXXXXXXXXXXXX",
"|        1          |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|                   |XXXXXXXXXXXXXXXXXXXXXXXX",
"|u                  |XXXXXXXXXXXXXXXXXXXXXXXX",
"+-------------------+XXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", //  8. Arborian wilderness (12*12)
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"      +-+ + +-+ +        XXXXXXXXXXXXXXXXXXXX",
"   #  |^| |^| |^|    #   XXXXXXXXXXXXXXXXXXXX",
"      | | +-+ | |   +---+XXXXXXXXXXXXXXXXXXXX",
"   #  |^|     |^|   |^ ^|XXXXXXXXXXXXXXXXXXXX",
"      +-+     | | +-+---+XXXXXXXXXXXXXXXXXXXX",
"              |^| |^|#   XXXXXXXXXXXXXXXXXXXX",
"+-----+       +-+ | |    XXXXXXXXXXXXXXXXXXXX",
"|^ ^ ^|           |^|    XXXXXXXXXXXXXXXXXXXX",
"+-----+   +-+ +-+ +-+    XXXXXXXXXXXXXXXXXXXX",
"          |#| |#|        XXXXXXXXXXXXXXXXXXXX",
"          | +-+ |   +-+  XXXXXXXXXXXXXXXXXXXX",
"          |# # #|   |^|  XXXXXXXXXXXXXXXXXXXX",
"          |     | +-+ |  XXXXXXXXXXXXXXXXXXXX",
"          |# # #| |^ ^|  XXXXXXXXXXXXXXXXXXXX",
"          +-----+ +---+  XXXXXXXXXXXXXXXXXXXX",
"   #                     XXXXXXXXXXXXXXXXXXXX",
"          +---+          XXXXXXXXXXXXXXXXXXXX",
"         #|^ ^|    #     XXXXXXXXXXXXXXXXXXXX",
"          +---+-+        XXXXXXXXXXXXXXXXXXXX",
"              |^|        XXXXXXXXXXXXXXXXXXXX",
"              +-+ +---+  XXXXXXXXXXXXXXXXXXXX",
"                  |^ ^|  XXXXXXXXXXXXXXXXXXXX",
"          +-----+ +---+  XXXXXXXXXXXXXXXXXXXX",
"          |^ ^ ^|        XXXXXXXXXXXXXXXXXXXX",
"          + +-+ +        XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", //  9. Ciera Brannia
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+XXXXXXXXXXXX",
"| |                           | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+ +-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+ +-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | |                   | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+-+-+-+=+       +-+ +-+XXXXXXXXXXXX",
"| | | | | | | | |#=       | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+-+-+-+=+       +-+ +-+XXXXXXXXXXXX",
"| | | | =#=               | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+ +-+=+         +-+ +-+XXXXXXXXXXXX",
"| | | | | | | |#=         | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+ +-+-+ +-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+ +-+-+ +-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | |   =#| | | |XXXXXXXXXXXX",
"+-+ +-+ +-+ +-+-+ +-+   +-+-+ +-+XXXXXXXXXXXX",
"| | | | | |       | |   | | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+-+=+-+-+-+   +-+-+ +-+XXXXXXXXXXXX",
"| | | | | | |#| | | |   | | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+-+=+-+-+-+   +-+-+ +-+XXXXXXXXXXXX",
"| | | |                 | | | | |XXXXXXXXXXXX",
"+-+ +-+                 +-+-+ +-+XXXXXXXXXXXX",
"| | | |                 | | | | |XXXXXXXXXXXX",
"+-+ +-+=+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | |#| | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+=+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| |                           | |XXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 10. Festering Pit 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-----+-+---------------+-----+XXXXXXXXXXXXXX",
"|     | |               |    d|XXXXXXXXXXXXXX",
"|     +=+     +         +=+---+XXXXXXXXXXXXXX",
"|     | =     |         |     |XXXXXXXXXXXXXX",
"+=+---+-+-----+---+     |     |XXXXXXXXXXXXXX",
"|       |     |         |     |XXXXXXXXXXXXXX",
"|       |     |     +---+-+=+-+XXXXXXXXXXXXXX",
"|       |     |     =   |     |XXXXXXXXXXXXXX",
"|       +     +     +   |     |XXXXXXXXXXXXXX",
"|                   |   |     |XXXXXXXXXXXXXX",
"+-+ +-------+ +-----+   +     |XXXXXXXXXXXXXX",
"|             |     |   =     |XXXXXXXXXXXXXX",
"+-+           |     +---+-----+XXXXXXXXXXXXXX",
"|             |               |XXXXXXXXXXXXXX",
"|             + +---+         |XXXXXXXXXXXXXX",
"|                             |XXXXXXXXXXXXXX",
"+---+-----+=+---+-------+     |XXXXXXXXXXXXXX",
"|   |           |       |     |XXXXXXXXXXXXXX",
"|   |           | & &&& | +---+XXXXXXXXXXXXXX",
"|   |           | &   & |     |XXXXXXXXXXXXXX",
"|   +           | &&& & +---+ |XXXXXXXXXXXXXX",
"|   =           |       |     |XXXXXXXXXXXXXX",
"| +-+-----+=+---+-------+ +---+XXXXXXXXXXXXXX",
"| |             |         |   |XXXXXXXXXXXXXX",
"| +             |         +   |XXXXXXXXXXXXXX",
"| =             |             |XXXXXXXXXXXXXX",
"| +---------+---+-+---------+=+XXXXXXXXXXXXXX",
"|1=         |  2  =           |XXXXXXXXXXXXXX",
"+ +-------+ +---+=+           |XXXXXXXXXXXXXX",
"|u|       = |     |           |XXXXXXXXXXXXXX",
"+-+-------+-+-----+-----------+XXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 11. Festering Pit 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---------+-+-----------+XXXXXXXXXXXXXXXXXXXX",
"|    T    | |        1 u|XXXXXXXXXXXXXXXXXXXX", // 14N
"+-------+=+ + +---+-----+XXXXXXXXXXXXXXXXXXXX",
"|         | |     =     |XXXXXXXXXXXXXXXXXXXX", // 13N
"|         | +-----+     |XXXXXXXXXXXXXXXXXXXX",
"|         | |     |     |XXXXXXXXXXXXXXXXXXXX", // 12N
"+---+=+---+-+-----+     |XXXXXXXXXXXXXXXXXXXX",
"|     |     =#    |     |XXXXXXXXXXXXXXXXXXXX", // 11N
"|     +     +-----+-+-+ |XXXXXXXXXXXXXXXXXXXX",
"|           |       |   |XXXXXXXXXXXXXXXXXXXX", // 10N
"+-----+=+-+&+-+=+---+   |XXXXXXXXXXXXXXXXXXXX",
"|           |       |/ /|XXXXXXXXXXXXXXXXXXXX", // 9N
"|     +=+---+-+=+---+   |XXXXXXXXXXXXXXXXXXXX",
"|     |/ / /|       |   |XXXXXXXXXXXXXXXXXXXX", // 8N
"+-+=+-+-+=+-+       |   |XXXXXXXXXXXXXXXXXXXX",
"|   |       |       |   |XXXXXXXXXXXXXXXXXXXX", // 7N
"|   |       |       +=+-+XXXXXXXXXXXXXXXXXXXX",
"|   |       |    u  |   |XXXXXXXXXXXXXXXXXXXX", // 6N
"+---+-------+-------+   |XXXXXXXXXXXXXXXXXXXX",
"|   =       |/ / / /|   |XXXXXXXXXXXXXXXXXXXX", // 5N
"+---+       +-------+---+XXXXXXXXXXXXXXXXXXXX",
"|           =/ u / /=   |XXXXXXXXXXXXXXXXXXXX", // 4N
"|           +       +   |XXXXXXXXXXXXXXXXXXXX",
"|           |/ / / /|   |XXXXXXXXXXXXXXXXXXXX", // 3N
"+-----------+-------+---+XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 12. Crystal Palace
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+---+-+-+-----+-----+-+-+-+-+XXXXXXXXXXXXXX",
"| =   = = =     |     | | | | |XXXXXXXXXXXXXX", // 5N
"| +=+-+-+-+-----+     | +=+=+=+XXXXXXXXXXXXXX",
"| | = =         =     | =   = |XXXXXXXXXXXXXX", // 4N
"+-+-+-+ +---+-+-+=+---+ +---+=+XXXXXXXXXXXXXX",
"|S S S| |   | |       | | = | |XXXXXXXXXXXXXX", // 3N
"|     | |   +=+       | + +-+ |XXXXXXXXXXXXXX",
"|S S S| |     |       | = = | |XXXXXXXXXXXXXX", // 2N
"+---+=+ +-+=+=+       | +-+-+-+XXXXXXXXXXXXXX",
"|        /|/| |       | =1    |XXXXXXXXXXXXXX", // 1N
"|   +---+ + | |       + =     |XXXXXXXXXXXXXX",
"|       |/ /| |       = =1   u|XXXXXXXXXXXXXX", // 0N
"+=+-+ +-+-+ +-+       + +-+-+-+XXXXXXXXXXXXXX",
"| = | |   =/ /=       | = | = |XXXXXXXXXXXXXX", // 1S
"+-+-+ |   + +=+       | +-+-+ |XXXXXXXXXXXXXX",
"| = | |   |/| |       | | | = |XXXXXXXXXXXXXX", // 2S
"+=+=+ +=+-+ | +-+-+-+=| | +-+ |XXXXXXXXXXXXXX",
"|       | =/|   | |   | |   = |XXXXXXXXXXXXXX", // 3S
"+-+-+=+-+=+ +---+ +   | +---+ |XXXXXXXXXXXXXX",
"| = = = | =/=   | =   | =     |XXXXXXXXXXXXXX", // 4S
"+-+-+-+-+-+-+---+-+---+-+-----+XXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 13. Valarian's Tower 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | = | = |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2N
"+-+-+ +=+=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |   |u|2|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1N
"+-+-+=+-+=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|d| = = | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+=+ +=+=+=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|1  | |/  |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"+=+=+=+===+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | | |   |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"+-+-+-+---+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 14. Valarian's Tower 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-------+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =       |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2N
"+-+-+=+-+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   =/|d=1|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1N
"+-+-+=+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|u= | |   |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+-+ +=+=+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|  2|/= = |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"+=+-+=+-+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =   |   |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"+-+---+---+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 15. Valarian's Tower 3
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-----+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|2=     | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2N
"+-+-+=+-+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =     | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1N
"+-+ +-+ + |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|d 1&u| = |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+-+ +-+ + |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =     | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"+-+-+=+-+=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =     | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"+-+-----+ +XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 16. Valarian's Tower 4
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-----+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     =N| |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2N
"+-+=+-+-+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| = |   | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1N
"+=+-+=+ +=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| = |d|1= |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+=+-+=+ +=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|# #|/  | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"|   +---+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|# #= =/= |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"+---+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 17. Sacred Grove
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---+---------+-----+XXXXXXXXXXXXXXXXXXXXXXXX",
"|#  |         |      XXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+-+ + +---+-+ | +-+  XXXXXXXXXXXXXXXXXXXXXXXX",
"          |   | |    XXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"    +-+ + +-+ | +---+XXXXXXXXXXXXXXXXXXXXXXXX",
"    |   | |   |      XXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"  +-+ +-+-+-+ +---+  XXXXXXXXXXXXXXXXXXXXXXXX",
"  | |       |        XXXXXXXXXXXXXXXXXXXXXXXX", // 3S
"  | +-+     | +---+  XXXXXXXXXXXXXXXXXXXXXXXX",
"  |         | |      XXXXXXXXXXXXXXXXXXXXXXXX", // 4S
"  +-+ + + + + | +-+  XXXXXXXXXXXXXXXXXXXXXXXX",
"      | |2|   |   |  XXXXXXXXXXXXXXXXXXXXXXXX", // 5S
"+---+-+ +=+-+-+ +-+  XXXXXXXXXXXXXXXXXXXXXXXX",
"    |   |3&#|   |    XXXXXXXXXXXXXXXXXXXXXXXX", // 6S
"  +-+ +-+-+ +-+ + +-+XXXXXXXXXXXXXXXXXXXXXXXX",
"      | = =   |      XXXXXXXXXXXXXXXXXXXXXXXX", // 7S
"  + +-+=+-+-+-+-+ +  XXXXXXXXXXXXXXXXXXXXXXXX",
"  | |   = = = = | |  XXXXXXXXXXXXXXXXXXXXXXXX", // 8S
"+-+-+-+-+-+-+-+=+-+-+XXXXXXXXXXXXXXXXXXXXXXXX",
"|   = = = = = = =  V|XXXXXXXXXXXXXXXXXXXXXXXX", // 9S
"+---+-+-+-+-+-+-+---+XXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 18. Gelidian wilderness
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"                                 XXXXXXXXXXXX",
"     *   *       * * *       *   XXXXXXXXXXXX", // 9N
"                                 XXXXXXXXXXXX",
"   * *   * * *     # * * * * *   XXXXXXXXXXXX", // 8N
"                                 XXXXXXXXXXXX",
"     *             *         *   XXXXXXXXXXXX", // 7N
"                                 XXXXXXXXXXXX",
"   *       #       *     *   *   XXXXXXXXXXXX", // 6N
"                                 XXXXXXXXXXXX",
"       * * * *           *       XXXXXXXXXXXX", // 5N
"                                 XXXXXXXXXXXX",
"               *     * *     * * XXXXXXXXXXXX", // 4N
"                                 XXXXXXXXXXXX",
"   * *         * *     *         XXXXXXXXXXXX", // 3N
"                                 XXXXXXXXXXXX",
"     *   *                       XXXXXXXXXXXX", // 2N
"                                 XXXXXXXXXXXX",
"     * * * * *     * * *         XXXXXXXXXXXX", // 1N
"                                 XXXXXXXXXXXX",
"         *         * # *       * XXXXXXXXXXXX", // 0N
"                                 XXXXXXXXXXXX",
" * *     *         *   * * *     XXXXXXXXXXXX", // 1S
"                                 XXXXXXXXXXXX",
"   *     * *       *       *     XXXXXXXXXXXX", // 2S
"                                 XXXXXXXXXXXX",
" * * *             * * *     *   XXXXXXXXXXXX", // 3S
"                                 XXXXXXXXXXXX",
"     *         *         *       XXXXXXXXXXXX", // 4S
"                                 XXXXXXXXXXXX",
"     *       *   *       * * * * XXXXXXXXXXXX", // 5S
"                                 XXXXXXXXXXXX",
"                                 XXXXXXXXXXXX", // 6S
"                                 XXXXXXXXXXXX",
//1
//0 9 8 7 6 5 4 3 2 1 0 1 2 3 4 5
//W W W W W W W W W W E E E E E E
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 19. White Tower 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+---+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |   | =u|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| +   +=+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =   | = |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| +---+-+=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |   | = |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |   +=+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |   | = |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| +=+-+-+=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|#        |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---------+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 20. White Tower 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---+-+---+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   | =  #|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   | +   |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   | |  1|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+=+-+-+=+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |   | | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| +   | | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =   | | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+=+---+ +=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|/|   =   |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+---+---+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 21. White Tower 3
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     @1 #|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+@+   +@+=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =   @/ /|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| +@+=+@+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|2  |   | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+   +@+-+ +XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   | @   |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+@+@+ @ +@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     @ @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 22. White Tower 4
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   =   |d|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+   +=+@+ +XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   =/ / 1|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+@+ +---+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| = =   | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+ +-+@+ | +XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @   = @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+ +-+ +=+ +XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   @ |  W|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 23. Grey Tower 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @ @ @ @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 4N
"+@+@+=+@+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|/@ @ @ @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 3N
"+@+@+-+@+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @ |u| @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2N
"+@+@+=+@+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|/@ @ @ @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1N
"+@+@+@+@+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @ @ @ @#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+-+-+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 24. Grey Tower 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+@+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"= @ @ @ @u=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 4N
"+@+@+@+@+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @ @ @ @ @XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 3N
"+@+-+-+-+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @ |d| @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2N
"+@+@+=+@+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"@ | @1@ @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1N
"+@+@+@+@+=+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @ @ @ | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+-+-+@+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 25. Grey Tower 3
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @ @ @1@d|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 4N
"+@+@+@+-+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @/@ @ @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 3N
"| +@+@+@+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | @ @ @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2N
"+@+@+@+@+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @ @ @/@ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1N
"+@+@+@+@+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|u  @ @ @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+---+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 26. Grey Tower 4
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+     +-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |# # #| @XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 4N
"+@+-+ +-+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @ |G| @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 3N
"+-+@+-+@+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"@ @ @ @ | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2N
"+-+-+@+-+@+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| @ @ | @ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1N
"+-+@+-+@+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|d@1| | @ @XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+-+-+ +-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 27. Black Tower 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"           XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
" # /       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"           XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
" / /   / / XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"           XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"       / u XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"           XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
" / / /     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 3S
"           XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"           XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 4S
"           XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 28. Black Tower 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+&+ +&+&&&+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"& & & &  /&XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+&+&+ &   &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"&/  & &/  &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"+&&&+&+ +&+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"&u  &/ 1&d&XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"&   +&&&+&+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"&  /&     &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 3S
"&   &     &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"&   &  /  &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 4S
"+&+ +&&&&&+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 29. Black Tower 3
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+&+&&&+&&&+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"&/=  /=/  &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"& +   +&+ &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"& &   &u& &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"+=+&&&+ & &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"&d&     & &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"+&+     & &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"&/=     & &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 3S
"& +&&&&&+ &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"&/     1  &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 4S
"+&&&&&&&&&+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 30. Black Tower 4
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+         +XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"&      B  &XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+&&&+-+&+&+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"      &d&  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"&&&&&&&&&&&XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"       1   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"&&&&+&+&&&&XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"    & &    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 3S
"    & &    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"    &/&    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 4S
"    + +    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 31. Ice Dungeon 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-----+-+-----+---+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|  1 u|/=     |  d|XXXXXXXXXXXXXXXXXXXXXXXXXX", // 0S
"|   +-+ +---+=+   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|       |     |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"+---+=+-+=+=+=+=+=+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   |/ /| | |/| | |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"|   +   | | | | | |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   =   | | | | | |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 3S
"+---+   +-+-+-+-+=+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   =   |     |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 4S
"|   +   +-+   +   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   |   = |   =   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 5S
"+---+-+=+=+---+-+=+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|       |     =   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 6S
"|       |     +   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|       |     |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 7S
"|       |     |   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|       |     |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 8S
"+-------+-----+---+XXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 32. Ice Dungeon 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---+-----+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|u  |     |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"|   |     |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   |    2|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"+=+-+=+-+&+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|1  |/|# #|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"|   | +=+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   |/|   |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 3S
"|   + |   |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   =/|  3|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 4S
"+---+-+---+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 33. Ice Keep 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-------+-+-+-+-+XXXXXXXXXXXXXXXXXXXX",
"|2= | | |  5 u  | = | =4|XXXXXXXXXXXXXXXXXXXX", // 9N
"+-+ +=+ |       | = | +-+XXXXXXXXXXXXXXXXXXXX",
"| | = | |       | = | | |XXXXXXXXXXXXXXXXXXXX", // 8N
"+-+ +-+ |       | +-+ +=+XXXXXXXXXXXXXXXXXXXX",
"| = | | |       | | = | |XXXXXXXXXXXXXXXXXXXX", // 7N
"+-+ +=+ |       | +=+=+=+XXXXXXXXXXXXXXXXXXXX",
"| | = | |       | | | | |XXXXXXXXXXXXXXXXXXXX", // 6N
"| + +=+ |       | +=+ | |XXXXXXXXXXXXXXXXXXXX",
"| = | = |       | = | | |XXXXXXXXXXXXXXXXXXXX", // 5N
"+=+ +=+ |       | +=+ +-+XXXXXXXXXXXXXXXXXXXX",
"| | = | |       | | = = |XXXXXXXXXXXXXXXXXXXX", // 4N
"| | +=+ |       | +=+ + |XXXXXXXXXXXXXXXXXXXX",
"| | | | |       | | | | |XXXXXXXXXXXXXXXXXXXX", // 3N
"+-+=+-+=+-+=+---+=+-+=+-+XXXXXXXXXXXXXXXXXXXX",
"|       =       =      u|XXXXXXXXXXXXXXXXXXXX", // 2N
"|       +=+-+-+=+=+-+-+-+XXXXXXXXXXXXXXXXXXXX",
"|  1    |   |   | | | = |XXXXXXXXXXXXXXXXXXXX", // 1N
"|       |   |   | +=+=+-+XXXXXXXXXXXXXXXXXXXX",
"|  d   u|   |   |     =3|XXXXXXXXXXXXXXXXXXXX", // 0N
"+-------+---+---+-----+-+XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 34. Ice Keep 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"      +---+---+-------+  XXXXXXXXXXXXXXXXXXXX",
"      |   |  d|       |  XXXXXXXXXXXXXXXXXXXX", // 9N
"+-+---+=+-+   +-+=+---+-+XXXXXXXXXXXXXXXXXXXX",
"| =   |   |   |   |   | |XXXXXXXXXXXXXXXXXXXX", // 8N
"| +   |   |   |   |   + |XXXXXXXXXXXXXXXXXXXX",
"| |   |   |   |   |   = |XXXXXXXXXXXXXXXXXXXX", // 7N
"| +-+=+=+-+=+-+=+-+=+-+ |XXXXXXXXXXXXXXXXXXXX",
"| |                   | |XXXXXXXXXXXXXXXXXXXX", // 6N
"| +---+-----+-----+---+ |XXXXXXXXXXXXXXXXXXXX",
"| |   |     |     |   | |XXXXXXXXXXXXXXXXXXXX", // 5N
"| +---+-----+-----+---+ |XXXXXXXXXXXXXXXXXXXX",
"| =   |     |     =   = |XXXXXXXXXXXXXXXXXXXX", // 4N
"| +---+-+=+-+-+=+-+---+ |XXXXXXXXXXXXXXXXXXXX",
"| |   | | | | | | |# #| |XXXXXXXXXXXXXXXXXXXX", // 3N
"| +---+-+=+-+-+=+-+---+-+XXXXXXXXXXXXXXXXXXXX",
"| |   =                d|XXXXXXXXXXXXXXXXXXXX", // 2N
"| |   +         +=+-----+XXXXXXXXXXXXXXXXXXXX",
"| |   |         |  #    |XXXXXXXXXXXXXXXXXXXX", // 1N
"| |   |         |     +-+XXXXXXXXXXXXXXXXXXXX",
"| |   |d        |     | |XXXXXXXXXXXXXXXXXXXX", // 0N
"+-+---+---------+-----+-+XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 35. Lucencian wilderness
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"  +---+     +-+       +-+XXXXXXXXXXXXXXXXXXXX",
"  |^ ^|     |^|  #    |^|XXXXXXXXXXXXXXXXXXXX", // 5N
"  +-+ |     | |       | |XXXXXXXXXXXXXXXXXXXX",
"   #|^|#    |^|       |^|XXXXXXXXXXXXXXXXXXXX", // 4N
"    +-+     | +-----+ | |XXXXXXXXXXXXXXXXXXXX",
"            |^ ^ ^ ^| |^|XXXXXXXXXXXXXXXXXXXX", // 3N
"+-------+ +-+-------+ +-+XXXXXXXXXXXXXXXXXXXX",
"|^ ^ ^ ^| |^|#           XXXXXXXXXXXXXXXXXXXX", // 2N
"| +-----+ +-+-+ +-----+  XXXXXXXXXXXXXXXXXXXX",
"|^|         |^| |# # #|  XXXXXXXXXXXXXXXXXXXX", // 1N
"| |         +-+ +-+   |  XXXXXXXXXXXXXXXXXXXX",
"|^|#              |# #|  XXXXXXXXXXXXXXXXXXXX", // 0N
"| |   +-+       +-+   |  XXXXXXXXXXXXXXXXXXXX",
"|^|#  |^|       |# # #|  XXXXXXXXXXXXXXXXXXXX", // 1S
"| +---+ |       +-----+  XXXXXXXXXXXXXXXXXXXX",
"|^ ^ ^ ^|                XXXXXXXXXXXXXXXXXXXX", // 2S
"+-------+     +-------+  XXXXXXXXXXXXXXXXXXXX",
"              |^ ^ ^ ^|  XXXXXXXXXXXXXXXXXXXX", // 3S
"    +-+       +---+ +-+  XXXXXXXXXXXXXXXXXXXX",
"    |^|          #|^|    XXXXXXXXXXXXXXXXXXXX", // 4S
"    | |           | |    XXXXXXXXXXXXXXXXXXXX",
"    |^|# #        |^|    XXXXXXXXXXXXXXXXXXXX", // 5S
"    | +-+         +-+    XXXXXXXXXXXXXXXXXXXX",
"    |^ ^|                XXXXXXXXXXXXXXXXXXXX", // 6S
"    +---+                XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 36. Celaria Bree
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXX",
"| |                           | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+=+-+=+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | |#| |#| | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+=+-+=+-+-+-+-+ +-+XXXXXXXXXXXX",
"| |                           | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| |                           | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"                              | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| |                           | |XXXXXXXXXXXX",
"+-+ +-+-+-+=+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | |#| | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+=+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| |                           | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+=+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | |#| | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+=+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| |                           | |XXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 37. Violet Mountain 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-----+-------+-+---+---+-----+---+-+XXXXXXXX",
"|     |       | |   |   |     |   | |XXXXXXXX", // 17N
"+-+ +-+-+ +-+ | | +-+ + +-+ + + + + |XXXXXXXX",
"| |   |   |   | |     |     |   |   |XXXXXXXX", // 16N
"| +-+ + +-+ +-+ + + +-+-+ +-+ +-+---+XXXXXXXX",
"|#        |       |   |   |         |XXXXXXXX", // 15N
"+-+-+ +-+ | +-+ +-+-+ + +-+ + +---+ |XXXXXXXX",
"| |       |   |   |     | | |     | |XXXXXXXX", // 14N
"| + +-+---+ + +---+---+ + + +---+-+ |XXXXXXXX",
"|     |   | | |   |   |   |     |   |XXXXXXXX", // 13N
"+-+ +-+ + + + + + | + +---+   +-+   |XXXXXXXX",
"|     | |   |   | | |         | |   |XXXXXXXX", // 12N
"| +-+ +-+ +-+---+ | +-------+ + +---+XXXXXXXX",
"|     |    /    | | |    /  |       |XXXXXXXX", // 11N
"| +   +-+ +-+   + | +   +-+ +---+   |XXXXXXXX",
"| |     |   |     |     |   |   |/  |XXXXXXXX", // 10N
"+-+-+ +-+-+ | +---+---+ |   |   + +-+XXXXXXXX",
"  |     |   |    /|/    |   |        XXXXXXXX", // 9N
"  +-+ +-+-+ +---+ + +---+ +-+ +-+-+  XXXXXXXX",
"        |   |   |# #|   |   | | |    XXXXXXXX", // 8N
"+-+-+   +-+ +   |   |   +   | + +-+  XXXXXXXX",
"  |     |       |# #|       |   |    XXXXXXXX", // 7N
"  + +-+ | +-----+---+ +-----+-+-+-+  XXXXXXXX",
"    |   | |     |u  |         |   |  XXXXXXXX", // 6N
"  +-+---+ +   +-+   +-+ +-+-+ |   +  XXXXXXXX",
"  |     |       |  /|   | |   |      XXXXXXXX", // 5N
"+ + + +-+---+ +-+-+=+-+-+ + + | +---+XXXXXXXX",
"|   | |      /|       |     | | |#   XXXXXXXX", // 4N
"+-+ +-+ +-----+ +---+ +-+-+-+ | +-+ |XXXXXXXX",
"| | | | |     |/|# #|/| | |   |/    |XXXXXXXX", // 3N
"+ + + | | +-+ | |   | | + + +-+-+   +XXXXXXXX",
"      | | |   | |# #| |     |   |    XXXXXXXX", // 2N
"+-+-+ | | | +-+ | + | | +-+-+   +-+  XXXXXXXX",
"  |   | | | | | | |1| |   |     |    XXXXXXXX", // 1N
"  +   + + | + + | | | + + + +---+ +  XXXXXXXX",
"          |     | |d|   |         |  XXXXXXXX", // 0N
"+---------+-----+-+-+---+---------+-+XXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 38. Violet Mountain 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---------+-----+---+-+XXXXXXXXXXXXXXXXXXXXXX",
"|d 1      |     |   | |XXXXXXXXXXXXXXXXXXXXXX", // 6N
"+-+---+   | +-+ + + + |XXXXXXXXXXXXXXXXXXXXXX",
"| |   |   |   |   |   |XXXXXXXXXXXXXXXXXXXXXX", // 5N
"| |   | + + + +-+ +---+XXXXXXXXXXXXXXXXXXXXXX",
"| |   | |/  | |       |XXXXXXXXXXXXXXXXXXXXXX", // 4N
"| +-+ + +-+-+ +-+---+ |XXXXXXXXXXXXXXXXXXXXXX",
"|   |   | |     |     |XXXXXXXXXXXXXXXXXXXXXX", // 3N
"| + +-+-+ + + + +---+ |XXXXXXXXXXXXXXXXXXXXXX",
"| |   |     | |       |XXXXXXXXXXXXXXXXXXXXXX", // 2N
"| +-+ +-+ +-+-+-+---+-+XXXXXXXXXXXXXXXXXXXXXX",
"|   |  /  | |   |   | |XXXXXXXXXXXXXXXXXXXXXX", // 1N
"|   +-+---+ |   | + + |XXXXXXXXXXXXXXXXXXXXXX",
"|     |  /  |   | |   |XXXXXXXXXXXXXXXXXXXXXX", // 0N
"+---+ + + +-+ + + +-+ |XXXXXXXXXXXXXXXXXXXXXX",
"|       |     |   |   |XXXXXXXXXXXXXXXXXXXXXX", // 1S
"+-------+-----+---+   |XXXXXXXXXXXXXXXXXXXXXX",
"|      / /            |XXXXXXXXXXXXXXXXXXXXXX", // 2S
"+-+ + +-+-----+ + +-+-+XXXXXXXXXXXXXXXXXXXXXX",
"|#  | | |     | |   | |XXXXXXXXXXXXXXXXXXXXXX", // 3S
"| + +-+ +     | +-+ + |XXXXXXXXXXXXXXXXXXXXXX",
"|#|    2=  d  |   |   |XXXXXXXXXXXXXXXXXXXXXX", // 4S
"+-+-----+-----+---+---+XXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 39. Cyanis' Tower 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-------------+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|        #    |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| +---------+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |/ # # #  | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | +-----+ | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | |# # #|#|#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | | +-+ | | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |/| |u|#| | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | | | + | | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | | |  #| | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+=+ | +---+ | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|1|/|#      | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | +-------+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|d|           |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-----------+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 40. Cyanis' Tower 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---+-----+---+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   |     |   |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+ + + + + +-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     |u|     |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| +---------+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |# # # # #| |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | + +-+ + | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |#|#|d|#|#| |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | | + + + + |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|#|#|#   #|#|#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | +-+-+-+ + |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|#|#  | |  #|#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+ + + + + + + +XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|# #|/ / /|# #|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---+-----+---+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 41. Cyanis' Tower 3
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-------+-----+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|       |# # #|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| +-+ + | +-+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   | |d|# #|#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+ +-+-+-+ | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   |     |#|#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| +-+     | | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   |     |#|#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+ | +=+ | | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |/| =2= |#|#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| + +-+=+-+ | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   | |# # #|#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+ + +-----+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|#       # # #|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-------------+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 42. Alliria's Tomb 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---+-----+-----+---------+XXXXXXXXXXXXXXXXXX",
"|/  |     |  u  |        /|XXXXXXXXXXXXXXXXXX", // 10N
"| + + + + | +&+ | +-+ +   |XXXXXXXXXXXXXXXXXX",
"| |   | | | |C| | |   |   |XXXXXXXXXXXXXXXXXX", // 9N
"| +---+ | +-+ +-+ | +-+-+ |XXXXXXXXXXXXXXXXXX",
"|     | |   | |   |   |   |XXXXXXXXXXXXXXXXXX", // 8N
"+-+ +-+ |   + + + | + +-+ |XXXXXXXXXXXXXXXXXX",
"|   |   |/|     |/| |     |XXXXXXXXXXXXXXXXXX", // 7N
"+-+ + + +-+-----+-+ + +-+ |XXXXXXXXXXXXXXXXXX",
"|     |                 | |XXXXXXXXXXXXXXXXXX", // 6N
"| +-+ | +-+ + + +-+ +-+ + |XXXXXXXXXXXXXXXXXX",
"|     |     | |       |   |XXXXXXXXXXXXXXXXXX", // 5N
"| + +-+ + +-+-+-+ +-+ +-+ |XXXXXXXXXXXXXXXXXX",
"| |   | |   | |       | | |XXXXXXXXXXXXXXXXXX", // 4N
"+-+ +-+-+ + + + + +-+-+ + |XXXXXXXXXXXXXXXXXX",
"|/|       |/ / /|   |    /|XXXXXXXXXXXXXXXXXX", // 3N
"| + + +-+ + +-+ + + + + +-+XXXXXXXXXXXXXXXXXX",
"|   |   |/       /|   |   |XXXXXXXXXXXXXXXXXX", // 2N
"+-+-+ + +-+-----+-+---+-+ |XXXXXXXXXXXXXXXXXX",
"| | | |   |     | |       |XXXXXXXXXXXXXXXXXX", // 1N
"| + + + + + +-+ + +   +-+ |XXXXXXXXXXXXXXXXXX",
"|d      |/   2 1 /      | |XXXXXXXXXXXXXXXXXX", // 0N
"| +-+ + + +-+=+-+ +---+ | |XXXXXXXXXXXXXXXXXX",
"| |   |   |  3  |     | | |XXXXXXXXXXXXXXXXXX", // 1S
"| | +-+ +-+   + +---+ + +-+XXXXXXXXXXXXXXXXXX",
"| |     |     |     |     |XXXXXXXXXXXXXXXXXX", // 2S
"| | +-+-+ +-+ + +-+ +---+ |XXXXXXXXXXXXXXXXXX",
"| | | |             |     |XXXXXXXXXXXXXXXXXX", // 3S
"+-+ | + +---+-+   + | +---+XXXXXXXXXXXXXXXXXX",
"|   |   |   |     | | |   |XXXXXXXXXXXXXXXXXX", // 4S
"+---+-+ +-+ +   +-+ +-+ + |XXXXXXXXXXXXXXXXXX",
"|     |         |   |   | |XXXXXXXXXXXXXXXXXX", // 5S
"|   +-+   +-+   + + + +-+ |XXXXXXXXXXXXXXXXXX",
"|      4          |     | |XXXXXXXXXXXXXXXXXX", // 6S
"+-----------------+-----+-+XXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 43. Alliria's Tomb 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-------------------------+XXXXXXXXXXXXXXXXXX",
"|          S           # #|XXXXXXXXXXXXXXXXXX", // 18N
"+-+   +-------------------+XXXXXXXXXXXXXXXXXX",
"| |   |                   |XXXXXXXXXXXXXXXXXX", // 17N
"| +-+ +-+   +-----------+ |XXXXXXXXXXXXXXXXXX",
"|   |   |   |           | |XXXXXXXXXXXXXXXXXX", // 16N
"| + +-+ +-+ +-+   +---+ | |XXXXXXXXXXXXXXXXXX",
"|S|   |   |   |   |A  | | |XXXXXXXXXXXXXXXXXX", // 15N
"| +-+ +-+ +-+ +-+ +-+ | | |XXXXXXXXXXXXXXXXXX",
"|   |   |   |2  |   |S| | |XXXXXXXXXXXXXXXXXX", // 14N
"+-+ +-+ +-+ +-+ +-+ + | | |XXXXXXXXXXXXXXXXXX",
"|#|   |   |   |   |   | | |XXXXXXXXXXXXXXXXXX", // 13N
"| +-+ +-+ +-+ +-+ +-+ | | |XXXXXXXXXXXXXXXXXX",
"|#  |   |   |   |   | | | |XXXXXXXXXXXXXXXXXX", // 12N
"+-+ +-+ +-+ +-+ +-+ +-+ | |XXXXXXXXXXXXXXXXXX",
"|         |   |   |     | |XXXXXXXXXXXXXXXXXX", // 11N
"+---------+   +-+ +-----+ |XXXXXXXXXXXXXXXXXX",
"|d 1   / S      |    S    |XXXXXXXXXXXXXXXXXX", // 10N
"+---------------+---------+XXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 44. Barracks
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-----+-+-+-+-+---+---+-+XXXXXXXXXXXXXXXXXXXX",
"|     | | = | |   =   |#|XXXXXXXXXXXXXXXXXXXX", // 0N
"|     + +-+=+=+   +---+ |XXXXXXXXXXXXXXXXXXXX",
"|     =           |   |1|XXXXXXXXXXXXXXXXXXXX", // 1S
"+-----+ +=+-+=+-+ +   | |XXXXXXXXXXXXXXXXXXXX",
"|     = | | | | | =   | |XXXXXXXXXXXXXXXXXXXX", // 2S
"|   +-+ +-+=+-+=+ +---+ |XXXXXXXXXXXXXXXXXXXX",
"|   |   |/ / / /        |XXXXXXXXXXXXXXXXXXXX", // 3S
"+---+   +=+-+=+-+-------+XXXXXXXXXXXXXXXXXXXX",
"|   |   | | | | |       |XXXXXXXXXXXXXXXXXXXX", // 4S
"|   +   +-+=+-+=+ +-+=+ |XXXXXXXXXXXXXXXXXXXX",
"|   =    / / / / /|   | |XXXXXXXXXXXXXXXXXXXX", // 5S
"+---+ +---+ +---+ +---+ |XXXXXXXXXXXXXXXXXXXX",
"|   = |   = |   = |   | |XXXXXXXXXXXXXXXXXXXX", // 6S
"|   + +---+ +---+ | +-+ |XXXXXXXXXXXXXXXXXXXX",
"|   | =   | =   | | |   |XXXXXXXXXXXXXXXXXXXX", // 7S
"+---+ +---+ +---+ | +   |XXXXXXXXXXXXXXXXXXXX",
"|      / / / / /  | =   |XXXXXXXXXXXXXXXXXXXX", // 8S
"+-----+ +---+ +-+ +-+ +-+XXXXXXXXXXXXXXXXXXXX",
"|     = |   = | |     | |XXXXXXXXXXXXXXXXXXXX", // 9S
"+-----+ +---+ + | +---+ |XXXXXXXXXXXXXXXXXXXX",
"|     |       = | |   = |XXXXXXXXXXXXXXXXXXXX", // 10S
"+=+---+   +=+-+ | +=+-+-+XXXXXXXXXXXXXXXXXXXX",
"|         |   | |       |XXXXXXXXXXXXXXXXXXXX", // 11S
"+=+ +---+ +---+-+---+ +-+XXXXXXXXXXXXXXXXXXXX",
"| | |   =     =     | |R|XXXXXXXXXXXXXXXXXXXX", // 12S
"| | +---+-+   +-----+ | |XXXXXXXXXXXXXXXXXXXX",
"| | |     |/ / / /    | |XXXXXXXXXXXXXXXXXXXX", // 13S
"| | +-+=+-+ +=+-+ +=+-+ |XXXXXXXXXXXXXXXXXXXX",
"| |         |   | |     |XXXXXXXXXXXXXXXXXXXX", // 14S
"+-+---------+---+-+-----+XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 45. Ferofist's Palace
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---------+-----+-----+---+-+---+---+XXXXXXXX",
"|         |     |     |   |6|   |   |XXXXXXXX",
"|         |     |     |   | |   |   |XXXXXXXX",
"|         |     |     |   |#|   |   |XXXXXXXX",
"+-----+=+-+-+=+-+-+=+-+---+ +-+=+=+-+XXXXXXXX",
"|    #             # #          |   |XXXXXXXX",
"+-----+ +-----------+           |   |XXXXXXXX",
"|     = |           |           |   |XXXXXXXX",
"|     + +           |           +---+XXXXXXXX",
"|     | =           |    #      |   |XXXXXXXX",
"+-----+ +-----------+-+=+-------+   |XXXXXXXX",
"|     =# #          |# # #      |   |XXXXXXXX",
"+-+=+-+             |           +=+-+XXXXXXXX",
"|     |             |2             5|XXXXXXXX",
"|     +             |           +---+XXXXXXXX",
"|     =    # #      |           |   |XXXXXXXX",
"+-----+             |           |   |XXXXXXXX",
"|  # #     # #     #|# # # #    |   |XXXXXXXX",
"|                   +           +   |XXXXXXXX",
"|  # #     # #     #=  # # #    =   |XXXXXXXX",
"+-----+             +           +   |XXXXXXXX",
"|     =    # #     #|  # # #    |   |XXXXXXXX",
"|     +             |           |   |XXXXXXXX",
"|     |             |           |   |XXXXXXXX",
"+-----+             |           |   |XXXXXXXX",
"|     =             |# # #      |   |XXXXXXXX",
"+-----+ +---+-------+-+=+-------+---+XXXXXXXX",
"|     = |#  |       |            # 5|XXXXXXXX",
"|     + +   |       |   +-+=+---+---+XXXXXXXX",
"|     | =   |       |   |       =   |XXXXXXXX",
"+-----+ +---+-+=+---+   |       +   |XXXXXXXX",
"|    # 3           # #  |       |   |XXXXXXXX",
"+-+-+=+-+-+-+=+-+-+=+-+ +-+=+-+=+-+-+XXXXXXXX",
"|    2|   =     |     |#|   |       |XXXXXXXX",
"|     |   +     |     | |   |       |XXXXXXXX",
"|1    |   |     |     |4|   |       |XXXXXXXX",
"+-----+---+-----+-----+-+---+-------+XXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 46. Private Quarters
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-----+-+---+-+---+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|# # #= =   | |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 6N
"+-----+ +---+ +-+=+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|    2| =   | |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 5N
"|   +-+ +---+ +=+-+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   =      #  =   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 4N
"+---+=+ +---+ +   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|# # #| =   | |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 3N
"+-----+ +---+ +=+-+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     = |   = |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 2N
"|     + +---+ +   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     | =   | =  L|XXXXXXXXXXXXXXXXXXXXXXXXXX", // 1N
"+-----+ +---+ +---+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|# 1          |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+-----+ +---+ +   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     | =   | =   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 1S
"|     + +   | +---+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     = |   | =   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 2S
"+-----+ +---+ +   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     = |   | |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 3S
"|     + +   + +=+-+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     | =   | =   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 4S
"+-----+ +---+ +   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     | |   = |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 5S
"|     | |   + +-+=+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     | |   | =   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 6S
"+---+=+ +---+ +   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|#            |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 7S
"+-----+ +-+=+ +-+=+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     = |   | =   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 8S
"+-----+ +---+ +   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     = |   = |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 9S
"+---+=+ +=+-+ +---+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|     | |   | =   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 10S
"+-----+-+---+-+---+XXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 47. Workshop 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---+-+-+-+-+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"|   | | | | | | | |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 8N
"+-+=+=+=+=+=+=+=+ |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =             = |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 7N
"+-+ +---+ +-+   +-+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"| = |       |   = |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 6N
"+-+ |   + + |   +-+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"| = |   | | |   = |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 5N
"+-+ + +-+ | +   +-+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =       |     = |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 4N
"+-+       +-+   +-+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =             = |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 3N
"+-+     +-----+ +-+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =  d          = |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 2N
"+-+       +=+ +=+-+XXXXXXXXXXXXXXXXXXXXXXXXXX",
"| =       | | |   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 1N
"| +=+=+=+=+ | |   |XXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | | | | | |#|   |XXXXXXXXXXXXXXXXXXXXXXXXXX", // 0N
"+-+-+-+-+-+-+-+---+XXXXXXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 48. Workshop 2 aka Urmech's Paradise
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-----------------------------+XXXXXXXXXXXXXX",
"|                             |XXXXXXXXXXXXXX", // 16N
"| +-+=+-+=+-+=+-+=+-+=+-+=+-+ |XXXXXXXXXXXXXX",
"| | | | | | | | | | | | | | | |XXXXXXXXXXXXXX", // 15N
"| + +-+ +-+ +-+ +-+ +-+ +-+ | |XXXXXXXXXXXXXX",
"| |                         | |XXXXXXXXXXXXXX", // 14N
"| +-+   +-+         +-+   +-+ |XXXXXXXXXXXXXX",
"| = |   | |         |/|   |#= |XXXXXXXXXXXXXX", // 13N
"| +-+ +-+ +-+     +-+ +-+ +-+ |XXXXXXXXXXXXXX",
"| |   |     |     |/ / /|   | |XXXXXXXXXXXXXX", // 12N
"| +-+ +-+ +-+ +-+ +-+ +-+ +-+ |XXXXXXXXXXXXXX",
"| = |   | |   | |   |/|   |#= |XXXXXXXXXXXXXX", // 11N
"| +-+   +=+ +-+ +-+ +=+   +-+ |XXXXXXXXXXXXXX",
"| |         =     |         | |XXXXXXXXXXXXXX", // 10N
"| +-+       +-| +-+       +-+ |XXXXXXXXXXXXXX",
"| = |         | |         |#= |XXXXXXXXXXXXXX", // 9N
"| +-+   +-+   +-+   +-+   +-+ |XXXXXXXXXXXXXX",
"| |     | |         | |     | |XXXXXXXXXXXXXX", // 8N
"| +-+ +-+ +-+     +-+ +-+ +-+ |XXXXXXXXXXXXXX",
"| = | =     |     =     | |#= |XXXXXXXXXXXXXX", // 7N
"| +-+ +-+ +-+ +=+ +-+ +-+ +-+ |XXXXXXXXXXXXXX",
"| |     | |   | |   | |     | |XXXXXXXXXXXXXX", // 6N
"| +-+   +-+ +-+ +-+ +-+   +-+ |XXXXXXXXXXXXXX",
"| = |       |  d  |       |#= |XXXXXXXXXXXXXX", // 5N
"| +-+       +-----+       +-+ |XXXXXXXXXXXXXX",
"| |                         | |XXXXXXXXXXXXXX", // 4N
"+=+-+ +-+ +-+ +-+ +-+ +-+ +-+=+XXXXXXXXXXXXXX",
"|   | | | | | | | | | | | |   |XXXXXXXXXXXXXX", // 3N
"|   +-+=+-+=+-+=+-+=+-+=+-+   |XXXXXXXXXXXXXX",
"|   =          u          =   |XXXXXXXXXXXXXX", // 2N
"+---+---------------------+---+XXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 49. Workshop 3 aka Viscous Plane
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-------+-----+-+---+---------+XXXXXXXXXXXXXX",
"|       |     |u|   |         |XXXXXXXXXXXXXX", // 5N
"|     + | +-+ + + + | + +---+ |XXXXXXXXXXXXXX",
"|     | |   |     | | |     | |XXXXXXXXXXXXXX", // 4N
"| + +-+ +-+ +-----+ | +-+ + | |XXXXXXXXXXXXXX",
"| |   |     |       |     | | |XXXXXXXXXXXXXX", // 3N
"| +-+ +-----+ + + +-+ +-+-+ | |XXXXXXXXXXXXXX",
"|             | |       |   | |XXXXXXXXXXXXXX", // 2N
"| +-----+---+ | +-----+ | +-+ |XXXXXXXXXXXXXX",
"|       |     |1        |     |XXXXXXXXXXXXXX", // 1N
"+-----+ | +---+ +---+   +---+ |XXXXXXXXXXXXXX",
"|       |       |       |   | |XXXXXXXXXXXXXX", // 0N
"| +---+ | + + +-+ +-----+   | |XXXXXXXXXXXXXX",
"|     | | | |               | |XXXXXXXXXXXXXX", // 1S
"+---+ | + | +-+-------+ +-+ | |XXXXXXXXXXXXXX",
"|2  | |   |   |         |   | |XXXXXXXXXXXXXX", // 2S
"|   + +---+   +   + +---+   + |XXXXXXXXXXXXXX",
"|#        |       |     |     |XXXXXXXXXXXXXX", // 3S
"+-+-------+-------+-----+-----+XXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 50. Workshop 4 aka Urmech's Sanctum
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-------------------------+XXXXXXXXXXXXXXXXXX",
"|                         |XXXXXXXXXXXXXXXXXX", // 9N
"|                         |XXXXXXXXXXXXXXXXXX",
"|                         |XXXXXXXXXXXXXXXXXX", // 8N
"|   +-+ +-+ +=+ +-+ +-+   |XXXXXXXXXXXXXXXXXX",
"|   | | | | | | | | | |   |XXXXXXXXXXXXXXXXXX", // 7N
"|   +-+-+ +-+ +-+ +-+-+   |XXXXXXXXXXXXXXXXXX",
"|     |     | |     |     |XXXXXXXXXXXXXXXXXX", // 6N
"|   +-+     | |     +-+   |XXXXXXXXXXXXXXXXXX",
"|   |       | |       |   |XXXXXXXXXXXXXXXXXX", // 5N
"|   +-+ +---+=+---+ +-+   |XXXXXXXXXXXXXXXXXX",
"|     | |    u    | |     |XXXXXXXXXXXXXXXXXX", // 4N
"|   +-+ |         | +-+   |XXXXXXXXXXXXXXXXXX",
"|   |   |         |   |   |XXXXXXXXXXXXXXXXXX", // 3N
"|   +-+ |         | +-+   |XXXXXXXXXXXXXXXXXX",
"|     | |         | |     |XXXXXXXXXXXXXXXXXX", // 2N
"|   +-+ +-+-+=+-+-+ +-+   |XXXXXXXXXXXXXXXXXX",
"|   |     |  1  |     |   |XXXXXXXXXXXXXXXXXX", // 1N
"|   +-+   |    F|   +-+  #|XXXXXXXXXXXXXXXXXX",
"|     |   |     |   |     |XXXXXXXXXXXXXXXXXX", // 0N
"|   +-+-+ +-+ +-+ +-+-+   |XXXXXXXXXXXXXXXXXX",
"|   | | | | |M| | | | |   |XXXXXXXXXXXXXXXXXX", // 1S
"|   +-+ +-+ +-+ +-+ +-+   |XXXXXXXXXXXXXXXXXX",
"|                         |XXXXXXXXXXXXXXXXXX", // 2S
"|                         |XXXXXXXXXXXXXXXXXX",
"|                         |XXXXXXXXXXXXXXXXXX", // 3S
"+-------------------------+XXXXXXXXXXXXXXXXXX",
//1 1 1
//2 1 0 9 8 7 6 5 4 3 2 1 0
//W W W W W W W W W W W W W
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 51. Nowhere aka Tenebrosian wilderness
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"        +-+            XXXXXXXXXXXXXXXXXXXXXX",
"        |^|#           XXXXXXXXXXXXXXXXXXXXXX", // 1N
"    +-+ +-+   +-+ +-+  XXXXXXXXXXXXXXXXXXXXXX",
"    |^|       |#| |#|  XXXXXXXXXXXXXXXXXXXXXX", // 0N
"    +-+   +-+ | +-+ +-+XXXXXXXXXXXXXXXXXXXXXX",
"          |^| |# # #|^|XXXXXXXXXXXXXXXXXXXXXX", // 1S
"          +-+ |     +-+XXXXXXXXXXXXXXXXXXXXXX",
"     #        |# # #|  XXXXXXXXXXXXXXXXXXXXXX", // 2S
"+-+           +-+---+  XXXXXXXXXXXXXXXXXXXXXX",
"|^|             |^ ^|  XXXXXXXXXXXXXXXXXXXXXX", // 3S
"+-+             +---+  XXXXXXXXXXXXXXXXXXXXXX",
"     * *   #           XXXXXXXXXXXXXXXXXXXXXX", // 4S
"              +-+      XXXXXXXXXXXXXXXXXXXXXX",
"              |^|      XXXXXXXXXXXXXXXXXXXXXX", // 5S
"        +-+   +-+-+    XXXXXXXXXXXXXXXXXXXXXX",
"        |^|     |^|    XXXXXXXXXXXXXXXXXXXXXX", // 6S
"        +-+     +-+    XXXXXXXXXXXXXXXXXXXXXX",
"             * # *     XXXXXXXXXXXXXXXXXXXXXX", // 7S
"  +-+ +-+              XXXXXXXXXXXXXXXXXXXXXX",
"  |^|*|^|    * * *     XXXXXXXXXXXXXXXXXXXXXX", // 8S
"  +-+ +-+ +-+          XXXXXXXXXXXXXXXXXXXXXX",
"          +^+          XXXXXXXXXXXXXXXXXXXXXX", // 9S
"          +-+          XXXXXXXXXXXXXXXXXXXXXX",
//8 7 6 5 4 3 2 1 0 1 2
//W W W W W W W W E E E
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 52. Dark Copse
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---+             +---+XXXXXXXXXXXXXXXXXXXXXX",
" ^ ^|      #      |^ ^ XXXXXXXXXXXXXXXXXXXXXX", // 0S
"+---+ +---------+ +---+XXXXXXXXXXXXXXXXXXXXXX",
"      |^ ^ ^ ^ ^|      XXXXXXXXXXXXXXXXXXXXXX", // 1S
"+-+ +-+---+ +---+      XXXXXXXXXXXXXXXXXXXXXX",
"|^| |^|   |^|          XXXXXXXXXXXXXXXXXXXXXX", // 2S
"| | +-+   +-+ +---+    XXXXXXXXXXXXXXXXXXXXXX",
"|^|           |^ ^|    XXXXXXXXXXXXXXXXXXXXXX", // 3S
"+-+   +-------+---+    XXXXXXXXXXXXXXXXXXXXXX",
"      |^ ^ ^ ^|        XXXXXXXXXXXXXXXXXXXXXX", // 4S
"+-----+-+ +-+ + +-----+XXXXXXXXXXXXXXXXXXXXXX",
" ^ ^ ^| |^|#|^| |^ ^ ^ XXXXXXXXXXXXXXXXXXXXXX", // 5S
"+-----+ | +-+ | +-+ +-+XXXXXXXXXXXXXXXXXXXXXX",
"        |^ ^ ^|   |^|  XXXXXXXXXXXXXXXXXXXXXX", // 6S
"  +-+ +-+-----+   | |  XXXXXXXXXXXXXXXXXXXXXX",
"  |^| |^|         |^|  XXXXXXXXXXXXXXXXXXXXXX", // 7S
"  +-+-+-+ +-----+ +-+  XXXXXXXXXXXXXXXXXXXXXX",
"    |^|   |^ ^ ^|      XXXXXXXXXXXXXXXXXXXXXX", // 8S
"  +-+ |   | +---+ +---+XXXXXXXXXXXXXXXXXXXXXX",
"  |^ ^|   |^|     |^ ^|XXXXXXXXXXXXXXXXXXXXXX", // 9S
"  +---+   | |     | +-+XXXXXXXXXXXXXXXXXXXXXX",
"          |^|     |^|  XXXXXXXXXXXXXXXXXXXXXX", // 10S
"          +-+     +-+  XXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 53. Black Scar
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXX",
"| | | | | | | | | |#| | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXX",
"| |                           | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+XXXXXXXXXXXX",
"| | | |                   | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+-+-+-+-+-+-+-+ +-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+-+-+-+-+-+-+-+ +-+ +-+XXXXXXXXXXXX",
"|#| | | | |           | | | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+ +-+-+-+-+ +-+ +-+ +-+XXXXXXXXXXXX",
"| | | | | | | | |#| | | | | | =#|XXXXXXXXXXXX",
"+-+ +-+ +-+ +-+-+-+-+ +-+ +-+ +-+XXXXXXXXXXXX",
"| | | | |#| | |   | | |#| | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+ +-+   +-+ +-+ +-+ +-+XXXXXXXXXXXX",
"| | | | | | |#|   |#| | | | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+ +-+ +-+-+ +-+ +-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+ +-+ +-+-+ +-+ +-+ +-+XXXXXXXXXXXX",
"| | =#= | |           | | | | =#|XXXXXXXXXXXX",
"+-+ +-+ +-+-+-+-+-+-+-+-+ +-+ +-+XXXXXXXXXXXX",
"| | | | | | | | |#| | | | | | | |XXXXXXXXXXXX",
"+-+ +-+ +-+-+-+-+-+-+-+-+ +-+ +-+XXXXXXXXXXXX",
"| | | |                   | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+ +-+-+-+ +-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+ +-+-+-+-+-+-+-+-+ +-+-+-+ +-+XXXXXXXXXXXX",
"| |                           + |XXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXX",
"| | | | | | | | | | | | | | | | |XXXXXXXXXXXX",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+XXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 54. Tar quarry
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---------------------+XXXXXXXXXXXXXXXXXXXXXX",
"|                    #|XXXXXXXXXXXXXXXXXXXXXX", // 0N
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|  / / / / / / / / / /|XXXXXXXXXXXXXXXXXXXXXX", // 1S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|  /           /      |XXXXXXXXXXXXXXXXXXXXXX", // 2S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|  /   / / /   /   /  |XXXXXXXXXXXXXXXXXXXXXX", // 3S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|  /   / / /   /   /  |XXXXXXXXXXXXXXXXXXXXXX", // 4S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|1 /   / / / 3     /  |XXXXXXXXXXXXXXXXXXXXXX", // 5S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|  /   / / / / / / /  |XXXXXXXXXXXXXXXXXXXXXX", // 6S
"|       +-----+       |XXXXXXXXXXXXXXXXXXXXXX",
"|  /   /|F F F|    /  |XXXXXXXXXXXXXXXXXXXXXX", // 7S
"|       +-+ +-+       |XXXXXXXXXXXXXXXXXXXXXX",
"|  /   /           /  |XXXXXXXXXXXXXXXXXXXXXX", // 8S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|  /   /=/ / / /   /  |XXXXXXXXXXXXXXXXXXXXXX", // 9S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|  /               /  |XXXXXXXXXXXXXXXXXXXXXX", // 10S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|  / / / / / / / / /  |XXXXXXXXXXXXXXXXXXXXXX", // 11S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|                  /  |XXXXXXXXXXXXXXXXXXXXXX", // 12S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|/ / / / / / / /   /  |XXXXXXXXXXXXXXXXXXXXXX", // 13S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|          2       /  |XXXXXXXXXXXXXXXXXXXXXX", // 14S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|  / / / / / / / / /  |XXXXXXXXXXXXXXXXXXXXXX", // 15S
"|                     |XXXXXXXXXXXXXXXXXXXXXX",
"|                     |XXXXXXXXXXXXXXXXXXXXXX", // 16S
"+---------------------+XXXXXXXXXXXXXXXXXXXXXX",
}, {
"+     +-+   +-+   +---+   +XXXXXXXXXXXXXXXXXX", // 55. Shadow Canyon
"|     |#    | |       |   |XXXXXXXXXXXXXXXXXX", // 0N
"|   +-+   +-+ +-----+ +-+ |XXXXXXXXXXXXXXXXXX",
"|         |         |     |XXXXXXXXXXXXXXXXXX", // 1S
"+-+ +     +-+   +   |     |XXXXXXXXXXXXXXXXXX",
"| | |           |   |     |XXXXXXXXXXXXXXXXXX", // 2S
"| +-+   +-----+ |   |     |XXXXXXXXXXXXXXXXXX",
"|       |     | |   |     |XXXXXXXXXXXXXXXXXX", // 3S
"|   +---+     | +-+ +-+   |XXXXXXXXXXXXXXXXXX",
"|   |         |   |   |   |XXXXXXXXXXXXXXXXXX", // 4S
"|   |   +-----+   | +-+   |XXXXXXXXXXXXXXXXXX",
"|   |   |         |       |XXXXXXXXXXXXXXXXXX", // 5S
"|   |   +-----+   | +-+   |XXXXXXXXXXXXXXXXXX",
"|   |2        |/ /|   |   |XXXXXXXXXXXXXXXXXX", // 6S
"+   +-+ +-----+   +---+   +XXXXXXXXXXXXXXXXXX",
"                 3         XXXXXXXXXXXXXXXXXX", // 7S
"        +-----+            XXXXXXXXXXXXXXXXXX",
"        |     |            XXXXXXXXXXXXXXXXXX", // 8S
"+       +-+   |     +-----+XXXXXXXXXXXXXXXXXX",
"|             |     |     |XXXXXXXXXXXXXXXXXX", // 9S
"| +-+   +-+   |     |     |XXXXXXXXXXXXXXXXXX",
"| | |   |     |     |     |XXXXXXXXXXXXXXXXXX", // 10S
"+-+ |   | +---+     +-+   |XXXXXXXXXXXXXXXXXX",
"|   |   | |           |   |XXXXXXXXXXXXXXXXXX", // 11S
"+   |   | +---+       +-+ +XXXXXXXXXXXXXXXXXX",
"    |   |     |         |  XXXXXXXXXXXXXXXXXX", // 12S
"+   +-+ +-----+       +-+ +XXXXXXXXXXXXXXXXXX",
"|     |    1          |   |XXXXXXXXXXXXXXXXXX", // 13S
"|     +-+   +---------+   |XXXXXXXXXXXXXXXXXX",
"|      #|   |             |XXXXXXXXXXXXXXXXXX", // 14S
"+-------+-+ |             |XXXXXXXXXXXXXXXXXX",
"|         | |             |XXXXXXXXXXXXXXXXXX", // 15S
"+       +-+ +-------------+XXXXXXXXXXXXXXXXXX",
"        |4             # # XXXXXXXXXXXXXXXXXX", // 16S
"+   +---+ +---------------+XXXXXXXXXXXXXXXXXX",
"|   |     |               |XXXXXXXXXXXXXXXXXX", // 17S
"|   +-+   +-+             |XXXXXXXXXXXXXXXXXX",
"|     |     |             |XXXXXXXXXXXXXXXXXX", // 18S
"|     +-+   +-+           |XXXXXXXXXXXXXXXXXX",
"|       |     |           |XXXXXXXXXXXXXXXXXX", // 19S
"|       +-+   +-+         |XXXXXXXXXXXXXXXXXX",
"|         |     |         |XXXXXXXXXXXXXXXXXX", // 20S
"|     +---+     +-+       |XXXXXXXXXXXXXXXXXX",
"|     |           |       |XXXXXXXXXXXXXXXXXX", // 21S
"+     +-+   +-+   +---+   +XXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 56. Sceadu's Demesne 1
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"                               XXXXXXXXXXXXXX",
"                               XXXXXXXXXXXXXX", // 13N
"    +---+-+ +---+---+ +-----+  XXXXXXXXXXXXXX",
"    |   |       |   @       |  XXXXXXXXXXXXXX", // 12N
"    +   |       |   +       +  XXXXXXXXXXXXXX",
"        |       |   @          XXXXXXXXXXXXXX", // 11N
"    +-+ +-+-+   +@+@+   +      XXXXXXXXXXXXXX",
"    |/   /|     |       @      XXXXXXXXXXXXXX", // 10N
"    +     + +   +@+@+@+ +@+    XXXXXXXXXXXXXX",
"  #      #  |         |   @    XXXXXXXXXXXXXX", // 9N
"      +     +   +     | +@+@+  XXXXXXXXXXXXXX",
"      |         |     |   @    XXXXXXXXXXXXXX", // 8N
"    +-+-+ +-+   | +@+@+   +    XXXXXXXXXXXXXX",
"    |   |   |/  |     |        XXXXXXXXXXXXXX", // 7N
"    +   +   +-+ +-----+        XXXXXXXXXXXXXX",
"       #   3    |  /           XXXXXXXXXXXXXX", // 6N
"    +   + +-----+ +@+          XXXXXXXXXXXXXX",
"    |   | |     |/@d@    #     XXXXXXXXXXXXXX", // 5N
"    +-+-+ |     | +@+ +@+@+    XXXXXXXXXXXXXX",
"     /|   |  /  |  /  @ @      XXXXXXXXXXXXXX", // 4N
"      +   |     + + + + +      XXXXXXXXXXXXXX",
"          |       @ @          XXXXXXXXXXXXXX", // 3N
"          +-+   + + + +@+      XXXXXXXXXXXXXX",
"             #  |     @        XXXXXXXXXXXXXX", // 2N
"  +-+   +     + +@+@+@+   +@+  XXXXXXXXXXXXXX",
"   2|/  |  /  | | @       @    XXXXXXXXXXXXXX", // 1N
"  + +   +-+ +-+ | +   +   +    XXXXXXXXXXXXXX",
"  |u 1  |       |     @        XXXXXXXXXXXXXX", // 0N
"  +-----+-+ +---+---+ +-----+  XXXXXXXXXXXXXX",
"                               XXXXXXXXXXXXXX", // 1S
"                               XXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 57. Sceadu's Demesne 2
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-----------------------------+XXXXXXXXXXXXXX",
"                               XXXXXXXXXXXXXX", // 19N
"          +&+                  XXXXXXXXXXXXXX",
"          =S&                  XXXXXXXXXXXXXX", // 18N
"          +&+                  XXXXXXXXXXXXXX",
"                               XXXXXXXXXXXXXX", // 17N
"                               XXXXXXXXXXXXXX",
"                               XXXXXXXXXXXXXX", // 16N
"+-----------------------------+XXXXXXXXXXXXXX",
"|                             |XXXXXXXXXXXXXX", // 15N
"| +-------------------------+ |XXXXXXXXXXXXXX",
"| |/ / / / / / / / / / / / /| |XXXXXXXXXXXXXX", // 14N
"| | +---------------------+ | |XXXXXXXXXXXXXX",
"| |/|                     |/| |XXXXXXXXXXXXXX", // 13N
"| | |       +-+ +-+       | | |XXXXXXXXXXXXXX",
"| |/|       | | | |       |/| |XXXXXXXXXXXXXX", // 12N
"| | | +-+   | | | |   +-+ | | |XXXXXXXXXXXXXX",
"| |/|#| |   | | | |   | |#|/| |XXXXXXXXXXXXXX", // 11N
"| | | | +---+ +-+ +---+ | | | |XXXXXXXXXXXXXX",
"| |/|#|2       1   /   3|#|/| |XXXXXXXXXXXXXX", // 10N
"| | | | +---+ +-+ +---+ | | | |XXXXXXXXXXXXXX",
"| |/|#| |   | | | |   | |#|/| |XXXXXXXXXXXXXX", // 9N
"| | | +-+   | | | |   +-+ | | |XXXXXXXXXXXXXX",
"| |/|       | | | |       |/| |XXXXXXXXXXXXXX", // 8N
"| | |       +-+ +-+       | | |XXXXXXXXXXXXXX",
"| |/|                     |/| |XXXXXXXXXXXXXX", // 7N 
"| | +---------------------+ | |XXXXXXXXXXXXXX",
"| |/ / / / / / / / / / / / /| |XXXXXXXXXXXXXX", // 6N
"| +-------------------------+ |XXXXXXXXXXXXXX",
"|u                            |XXXXXXXXXXXXXX", // 5N
"+-----------------------------+XXXXXXXXXXXXXX", 
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 58. Tarmitian dungeon
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-----------------------+XXXXXXXXXXXXXXXXXXXX",
"|  1                 2 E|XXXXXXXXXXXXXXXXXXXX", // 11N
"+---+               +---+XXXXXXXXXXXXXXXXXXXX",
"|   |               |   |XXXXXXXXXXXXXXXXXXXX", // 10N
"| +=+-+=+-+=+-+=+---+=+-+XXXXXXXXXXXXXXXXXXXX",
"| | |   |   =   |       |XXXXXXXXXXXXXXXXXXXX", // 9N
"+-+=+---+=+-+=+-+=+-+   +XXXXXXXXXXXXXXXXXXXX",
"=         |/ / / /  |   =XXXXXXXXXXXXXXXXXXXX", // 8N
"+---+-----+=+-+-----+-+=+XXXXXXXXXXXXXXXXXXXX",
"|   |       = |     |   |XXXXXXXXXXXXXXXXXXXX", // 7N
"+   +-+=+-+-+=+-+=+-+   +XXXXXXXXXXXXXXXXXXXX",
"=   =     |/ / /| = =   =XXXXXXXXXXXXXXXXXXXX", // 6N
"+   +-+---+-+-+=+-+-+-+=+XXXXXXXXXXXXXXXXXXXX",
"|     =     |     =     |XXXXXXXXXXXXXXXXXXXX", // 5N
"+=+-+-+-+=+-+-+-+=+-+-+=+XXXXXXXXXXXXXXXXXXXX",
"|   |     =   |/ / /|   |XXXXXXXXXXXXXXXXXXXX", // 4N
"+-+=+-----+-+=+-----+   +XXXXXXXXXXXXXXXXXXXX",
"= = |     | =    / 3   /=XXXXXXXXXXXXXXXXXXXX", // 3N
"+=+-+=+-+-+=+   +-+=+---+XXXXXXXXXXXXXXXXXXXX",
"|     = |/ /|   |       |XXXXXXXXXXXXXXXXXXXX", // 2N
"+-+   +-+=+-+=+-+       |XXXXXXXXXXXXXXXXXXXX",
"|S|   |/ /  =   |       |XXXXXXXXXXXXXXXXXXXX", // 1N
"| +=+-+   +-+   |       |XXXXXXXXXXXXXXXXXXXX",
"|W  =     |     |       |XXXXXXXXXXXXXXXXXXXX", // 0N
"+---+-----+-----+-------+XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 59. Wasteland
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"                       XXXXXXXXXXXXXXXXXXXXXX",
"                       XXXXXXXXXXXXXXXXXXXXXX", // 16N
"    +-------+   +-+    XXXXXXXXXXXXXXXXXXXXXX",
"    |D          |      XXXXXXXXXXXXXXXXXXXXXX", // 15N
"    |           |      XXXXXXXXXXXXXXXXXXXXXX",
"    |           |      XXXXXXXXXXXXXXXXXXXXXX", // 14N
"    |   +-+     +      XXXXXXXXXXXXXXXXXXXXXX",
"    |   |B|            XXXXXXXXXXXXXXXXXXXXXX", // 13N
"    +   + + +---+ +    XXXXXXXXXXXXXXXXXXXXXX",
"                  |    XXXXXXXXXXXXXXXXXXXXXX", // 12N
"+-+               +---+XXXXXXXXXXXXXXXXXXXXXX",
"                       XXXXXXXXXXXXXXXXXXXXXX", // 11N
"+ +-----+---+   +-+ +-+XXXXXXXXXXXXXXXXXXXXXX",
"|       |   |   |     |XXXXXXXXXXXXXXXXXXXXXX", // 10N
"+     + +   +   +   + +XXXXXXXXXXXXXXXXXXXXXX",
"      |             |  XXXXXXXXXXXXXXXXXXXXXX", // 9N
"    + +     +   +   +  XXXXXXXXXXXXXXXXXXXXXX",
"    |       |   |N     XXXXXXXXXXXXXXXXXXXXXX", // 8N
"    +-------+   +---+  XXXXXXXXXXXXXXXXXXXXXX",
"                       XXXXXXXXXXXXXXXXXXXXXX", // 7N
"+     + +---+ + +-+ +-+XXXXXXXXXXXXXXXXXXXXXX",
"|     |       |   | | |XXXXXXXXXXXXXXXXXXXXXX", // 6N
"+     +-+   +-+   + + +XXXXXXXXXXXXXXXXXXXXXX",
"               2       XXXXXXXXXXXXXXXXXXXXXX", // 5N
"+ +-+   +---+ + +-+-+ +XXXXXXXXXXXXXXXXXXXXXX",
"| |K    |   | |   |   |XXXXXXXXXXXXXXXXXXXXXX", // 4N
"| +---+-+   | |   +   |XXXXXXXXXXXXXXXXXXXXXX",
"|     |     | |       |XXXXXXXXXXXXXXXXXXXXXX", // 3N
"+     +     + +     +-+XXXXXXXXXXXXXXXXXXXXXX",
"                       XXXXXXXXXXXXXXXXXXXXXX", // 2N
"  +-+     +---+---+ +-+XXXXXXXXXXXXXXXXXXXXXX",
"  |3|         |   | |  XXXXXXXXXXXXXXXXXXXXXX", // 1N
"  +=+         +   + +  XXXXXXXXXXXXXXXXXXXXXX",
"   1                   XXXXXXXXXXXXXXXXXXXXXX", // 0N
"                       XXXXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 60. Berlin
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-------+                XXXXXXXXXXXXXXXXXXXX",
"|       |                XXXXXXXXXXXXXXXXXXXX", // 11N
"|       +   +---+   +-+=+XXXXXXXXXXXXXXXXXXXX",
"|  R    =   |   =   |   |XXXXXXXXXXXXXXXXXXXX", // 10N
"|       +   |   +   +   |XXXXXXXXXXXXXXXXXXXX",
"|       |   |   |   =   |XXXXXXXXXXXXXXXXXXXX", // 9N
"+-------+   +---+   +---+XXXXXXXXXXXXXXXXXXXX",
"                         XXXXXXXXXXXXXXXXXXXX", // 8N
"+---+   +=+---+     +-+=+XXXXXXXXXXXXXXXXXXXX",
"|   =  3|     |     |   |XXXXXXXXXXXXXXXXXXXX", // 7N
"+---+   +     |     +---+XXXXXXXXXXXXXXXXXXXX",
"        =     |      W   XXXXXXXXXXXXXXXXXXXX", // 6N
"+---+   +-----+       +-+XXXXXXXXXXXXXXXXXXXX",
"    |   |  N  |       =  XXXXXXXXXXXXXXXXXXXX", // 5N
"    +   +     +   +-+ +  XXXXXXXXXXXXXXXXXXXX",
"    =   =     =D  | | |  XXXXXXXXXXXXXXXXXXXX", // 4N
"+---+   +-----+   +=+ +-+XXXXXXXXXXXXXXXXXXXX",
"                   4     XXXXXXXXXXXXXXXXXXXX", // 3N
"+-----+=+   +---+-+=+   +XXXXXXXXXXXXXXXXXXXX",
"|       |   |   |   |   |XXXXXXXXXXXXXXXXXXXX", // 2N
"|       |   |   |   |   |XXXXXXXXXXXXXXXXXXXX",
"|       |  2|   |   |   |XXXXXXXXXXXXXXXXXXXX", // 1N
"|       |   +-+=+---+   |XXXXXXXXXXXXXXXXXXXX",
"|1      |               |XXXXXXXXXXXXXXXXXXXX", // 0N
"+-------+               +XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 61. Stalingrad
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+---+   +----+    +-----+XXXXXXXXXXXXXXXXXXXX",
"|   |   =    |    |N    |XXXXXXXXXXXXXXXXXXXX", // 11N
"|   +   +    +    +     |XXXXXXXXXXXXXXXXXXXX",
"|   =   |    =    =     |XXXXXXXXXXXXXXXXXXXX", // 10N
"+---+   |    +    +-----+XXXXXXXXXXXXXXXXXXXX",
"        |    |           XXXXXXXXXXXXXXXXXXXX", // 9N
"+---+   +----+    +-+   +XXXXXXXXXXXXXXXXXXXX",
"|   |            1=4|   |XXXXXXXXXXXXXXXXXXXX", // 8N
"+   +---+   +---+=+-+   +XXXXXXXXXXXXXXXXXXXX",
"=       |   |       |   =XXXXXXXXXXXXXXXXXXXX", // 7N
"+       |   |       |   +XXXXXXXXXXXXXXXXXXXX",
"|      H|   |       |   |XXXXXXXXXXXXXXXXXXXX", // 6N
"+---+=+-+   +=+-----+   +XXXXXXXXXXXXXXXXXXXX",
"                         XXXXXXXXXXXXXXXXXXXX", // 5N
"      +---+=+-+   +-+=+  XXXXXXXXXXXXXXXXXXXX",
"      |       |   |   |  XXXXXXXXXXXXXXXXXXXX", // 4N
"      +-------+   |   |  XXXXXXXXXXXXXXXXXXXX",
"                 3|   |  XXXXXXXXXXXXXXXXXXXX", // 3N
"+---+=+ +-----+   |   +-+XXXXXXXXXXXXXXXXXXXX",
"|     | |     |   |    K|XXXXXXXXXXXXXXXXXXXX", // 2N
"+-+   | +     +   +-----+XXXXXXXXXXXXXXXXXXXX",
"  |   | =     =          XXXXXXXXXXXXXXXXXXXX", // 1N
"  | +=+ +     +   +-+=+  XXXXXXXXXXXXXXXXXXXX",
"  | |2  |     |   |D  |  XXXXXXXXXXXXXXXXXXXX", // 0N 
"+-+-+   +-----+   +---+-+XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 62. Hiroshima
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"  +       +   +-------+  XXXXXXXXXXXXXXXXXXXX",
"  |       |              XXXXXXXXXXXXXXXXXXXX", // 11N
"  +---+   +-+ +---+      XXXXXXXXXXXXXXXXXXXX",
"      |    S| |   |      XXXXXXXXXXXXXXXXXXXX", // 10N
"--+   |   +-+ +=+-+ +---+XXXXXXXXXXXXXXXXXXXX",
"  |   |   |         =    XXXXXXXXXXXXXXXXXXXX", // 9N
"  +   +=+-+ +-+---+ +    XXXXXXXXXXXXXXXXXXXX",
"  =         |4|T  = |    XXXXXXXXXXXXXXXXXXXX", // 8N
"+-+ +-----+ +-+---+ +---+XXXXXXXXXXXXXXXXXXXX",
"    |     |  2           XXXXXXXXXXXXXXXXXXXX", // 7N
"    +-+=+-+ +-----+      XXXXXXXXXXXXXXXXXXXX",
"            |     =      XXXXXXXXXXXXXXXXXXXX", // 6N
"+-+ +-+ +---+   +-+ +---+XXXXXXXXXXXXXXXXXXXX",
"  | | | =       |   |    XXXXXXXXXXXXXXXXXXXX", // 5N
"+-+ +-+ +-------+ +=+   +XXXXXXXXXXXXXXXXXXXX",
"|                 |     |XXXXXXXXXXXXXXXXXXXX", // 4N
"+   +-------+ +=+ +-+ +-+XXXXXXXXXXXXXXXXXXXX",
"    |      3= | |   |R|  XXXXXXXXXXXXXXXXXXXX", // 3N
"    |       + | |   +-+  XXXXXXXXXXXXXXXXXXXX",
"    |       | | |  1     XXXXXXXXXXXXXXXXXXXX", // 2N
"    +-------+ | +-----+  XXXXXXXXXXXXXXXXXXXX",
"              |      D|  XXXXXXXXXXXXXXXXXXXX", // 1N
"  +-------+   +       |  XXXXXXXXXXXXXXXXXXXX",
"  |       =   =       |  XXXXXXXXXXXXXXXXXXXX", // 0N
"  +       +   +-------+  XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 63. Troy
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"  +-----+ +-+-+-+ +---+  XXXXXXXXXXXXXXXXXXXX",
"  |     = |4| | | |   |  XXXXXXXXXXXXXXXXXXXX", // 11N
"  |   +-+ +=+ +=+ +-+ |  XXXXXXXXXXXXXXXXXXXX",
"  |   |    1        | |  XXXXXXXXXXXXXXXXXXXX", // 10N
"  |   | +---+=+     +-+  XXXXXXXXXXXXXXXXXXXX",
"  |   | |K    |          XXXXXXXXXXXXXXXXXXXX", // 9N
"  |   | +-----+ +=+---+  XXXXXXXXXXXXXXXXXXXX",
"  |   |         |     |  XXXXXXXXXXXXXXXXXXXX", // 8N
"  +---+ +-+ +=+ |     |  XXXXXXXXXXXXXXXXXXXX",
"        = | | | |     |  XXXXXXXXXXXXXXXXXXXX", // 7N
"    +=+ +-+ | | +-+   |  XXXXXXXXXXXXXXXXXXXX",
"    | |     |3|   |   |  XXXXXXXXXXXXXXXXXXXX", // 6N
"    | +-+ +-+ +-+ +---+  XXXXXXXXXXXXXXXXXXXX",
"    |   | |    R|        XXXXXXXXXXXXXXXXXXXX", // 5N
"    |   +-+     +-----+  XXXXXXXXXXXXXXXXXXXX",
"    |D    =     |     |  XXXXXXXXXXXXXXXXXXXX", // 4N
"    +-----+-----+-+   |  XXXXXXXXXXXXXXXXXXXX",
"               2  |   |  XXXXXXXXXXXXXXXXXXXX", // 3N
"  +---+ +-----+   +-+ |  XXXXXXXXXXXXXXXXXXXX",
"  |   = |H    |     | |  XXXXXXXXXXXXXXXXXXXX", // 2N
"  |   + +-+=+-+     +=+  XXXXXXXXXXXXXXXXXXXX",
"  |   |                  XXXXXXXXXXXXXXXXXXXX", // 1N
"  +---+   +-+=+-+ +=+-+  XXXXXXXXXXXXXXXXXXXX",
"          |     | |   |  XXXXXXXXXXXXXXXXXXXX", // 0N
"  +-----+ +-----+ +---+  XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 64. Rome
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"  +-+ +     +   +-----+  XXXXXXXXXXXXXXXXXXXX",
"      |     |            XXXXXXXXXXXXXXXXXXXX", // 11N
"  +=+ | +=+ | +-+   +=+  XXXXXXXXXXXXXXXXXXXX",
"  | | | | | | | =   | |  XXXXXXXXXXXXXXXXXXXX", // 10N
"+ | | +-+=+-+ +-+ +-+=+-+XXXXXXXXXXXXXXXXXXXX",
"| | |      2      |     |XXXXXXXXXXXXXXXXXXXX", // 9N
"| | +---+   +=+   |     |XXXXXXXXXXXXXXXXXXXX",
"| |     |   | |   |B    |XXXXXXXXXXXXXXXXXXXX", // 8N
"+ +=+---+ +-+ +-+ +-----+XXXXXXXXXXXXXXXXXXXX",
"          |     |        XXXXXXXXXXXXXXXXXXXX", // 7N
"+ +=+-+ +-+     +-+ +---+XXXXXXXXXXXXXXXXXXXX",
"| |  H| =    D    = =   |XXXXXXXXXXXXXXXXXXXX", // 6N
"| |   | +-+     +-+ +   |XXXXXXXXXXXXXXXXXXXX",
"| |   |   |     |3  |   |XXXXXXXXXXXXXXXXXXXX", // 5N
"+ |   +-+ +-+ +-+   +---+XXXXXXXXXXXXXXXXXXXX",
"  |     =   | |          XXXXXXXXXXXXXXXXXXXX", // 4N
"  +-----+   +=+ +-+=+-+  XXXXXXXXXXXXXXXXXXXX",
"                |     |  XXXXXXXXXXXXXXXXXXXX", // 3N
"  +-+=+-+ +-----+     |  XXXXXXXXXXXXXXXXXXXX",
"  |     | =           |  XXXXXXXXXXXXXXXXXXXX", // 2N
"  +-----+ +-----+     |  XXXXXXXXXXXXXXXXXXXX",
"   1            |     |  XXXXXXXXXXXXXXXXXXXX", // 1N
"  +=+ +-+=+-+   |     |  XXXXXXXXXXXXXXXXXXXX",
"  |4| |T    |   |     |  XXXXXXXXXXXXXXXXXXXX", // 0N
"  +-+ +     +   +-----+  XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 65. Nottingham
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"  +-----+   +---+        XXXXXXXXXXXXXXXXXXXX",
"  |     |                XXXXXXXXXXXXXXXXXXXX", // 11N
"  | +---+ +-----+ +-+    XXXXXXXXXXXXXXXXXXXX",
"  | |     |     | | |    XXXXXXXXXXXXXXXXXXXX", // 10N
"  +=+     +---+=+ +=+    XXXXXXXXXXXXXXXXXXXX",
"                   2     XXXXXXXXXXXXXXXXXXXX", // 9N
"  +---+=+-+ +=+-+ +=+    XXXXXXXXXXXXXXXXXXXX",
"  |S      | |   | |4|    XXXXXXXXXXXXXXXXXXXX", // 8N
"  +-------+ |   | +-+    XXXXXXXXXXXXXXXXXXXX",
"            |   |        XXXXXXXXXXXXXXXXXXXX", // 7N
"+-+ +=+ +-+ +-+ | +---+ +XXXXXXXXXXXXXXXXXXXX",
"| = | | | |  D| | =   | |XXXXXXXXXXXXXXXXXXXX", // 6N
"+-+ +-+ +=+   +-+ +---+ +XXXXXXXXXXXXXXXXXXXX",
"                         XXXXXXXXXXXXXXXXXXXX", // 5N
"+ +-+ +-+=+-+ +=+ +-----+XXXXXXXXXXXXXXXXXXXX",
"| = | |     | | | =     |XXXXXXXXXXXXXXXXXXXX", // 4N
"| +-+ +-----+ | | +     |XXXXXXXXXXXXXXXXXXXX",
"|            3| | |     |XXXXXXXXXXXXXXXXXXXX", // 3N
"+   +-----+ +-+ + +-----+XXXXXXXXXXXXXXXXXXXX",
"    =     | |   |        XXXXXXXXXXXXXXXXXXXX", // 2N
"    +     | +=+-+ +---+  XXXXXXXXXXXXXXXXXXXX",
"    |W    |       =  B|  XXXXXXXXXXXXXXXXXXXX", // 1N
"    +-----+ +=+-+ +---+  XXXXXXXXXXXXXXXXXXXX",
"            |   |        XXXXXXXXXXXXXXXXXXXX", // 0N
"  +-----+   +---+        XXXXXXXXXXXXXXXXXXXX",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 66. K'un Wang
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"                         XXXXXXXXXXXXXXXXXXXX",
"                         XXXXXXXXXXXXXXXXXXXX", // 15N
"    +-----+-----+-----+  XXXXXXXXXXXXXXXXXXXX",
"    |     |     |     |  XXXXXXXXXXXXXXXXXXXX", // 14N
"    |     |     |     |  XXXXXXXXXXXXXXXXXXXX",
"    |     |     |     |  XXXXXXXXXXXXXXXXXXXX", // 13N
"    |     +     +     |  XXXXXXXXXXXXXXXXXXXX",
"    |     =     =     |  XXXXXXXXXXXXXXXXXXXX", // 12N
"    +-----+     +-----+  XXXXXXXXXXXXXXXXXXXX",
"    |    T|     |     |  XXXXXXXXXXXXXXXXXXXX", // 11N
"    |   +-+     +-+   |  XXXXXXXXXXXXXXXXXXXX",
"    |   =         =   |  XXXXXXXXXXXXXXXXXXXX", // 10N
"    +---+---+=+---+---+  XXXXXXXXXXXXXXXXXXXX",
"                         XXXXXXXXXXXXXXXXXXXX", // 9N
"+ +---+---+ +---+ +-----+XXXXXXXXXXXXXXXXXXXX",
"| |S  |   | =   | =     |XXXXXXXXXXXXXXXXXXXX", // 8N
"| +-+=+   | +---+ +-+   |XXXXXXXXXXXXXXXXXXXX",
"|     =   |         |   |XXXXXXXXXXXXXXXXXXXX", // 7N
"| +-+ +---+ +-----+ |   |XXXXXXXXXXXXXXXXXXXX",
"| | |      1|     | |W  |XXXXXXXXXXXXXXXXXXXX", // 6N
"+ +=+       +-+   | +---+XXXXXXXXXXXXXXXXXXXX",
"              =   |      XXXXXXXXXXXXXXXXXXXX", // 5N
"+ +---+-+   +-+   | +---+XXXXXXXXXXXXXXXXXXXX",
"| |   = =   |     | |   |XXXXXXXXXXXXXXXXXXXX", // 4N
"| |   +-+-+ +-----+ |   |XXXXXXXXXXXXXXXXXXXX",
"| |      D|         |   |XXXXXXXXXXXXXXXXXXXX", // 3N
"| +-------+ +-+   +-+   +XXXXXXXXXXXXXXXXXXXX",
"|           | =   =     |XXXXXXXXXXXXXXXXXXXX", // 2N
"+ +=+ +-+   | +-+ +-----+XXXXXXXXXXXXXXXXXXXX",
"  | |2|3|   |   |        XXXXXXXXXXXXXXXXXXXX", // 1N
"  +-+ +-+   +---+        XXXXXXXXXXXXXXXXXXXX",
"                         XXXXXXXXXXXXXXXXXXXX", // 0N
"                         XXXXXXXXXXXXXXXXXXXX",
}, {
"+-----------------+-+---+---------+-+-------+", // 67. Malefia 1
"|                 =d|d  |         | |       |",
"|       +-+=+-+   +-+   +-+       | +---+-+ |",
"|       |     |   |       |       |     | | |",
"| +---+-+-----+-+-+-----+ +-+   +-+---+ | +=+",
"| |   |         |           |   |     | | = |",
"| |   +-+=+   +-+           +-+=+---+=+=+-+=+",
"| |     |d|   |               | =   =       |",
"| +---+=+-+ +-+     +-+-+     +-+   +---+---+",
"| |   =d= = |       | | |       |       |   |",
"| +   +-+=+-+     +-+ | +-+     +-+=+---+   |",
"| =   |A  |       |   |   |       |     =   |",
"| +---+-+-+     +-+ +-+ + +-+     +-+   +-+ |",
"| |     |       |d      |   |       |   | = |",
"+=+   +-+-+     +---+   +---+     +-+-+=+-+-+",
"| |   |   |     |   |       |     | | | = = |",
"| +=+-+-+=+-+   +-+ + +-+ +-+   +-+=+ +-+=+=+",
"| = |   = = |     |   |   |     | = =   | | |",
"| +-+-+=+=+ +-+   +-+ | +-+   +-+-+=+-+=+-+ |",
"| |   = |     |     | | |     | =     =   |d|",
"+-+   +-+-+   +-+   +-+=+   +-+=+=+=+-+=+-+-+",
"|d=   |       =d|           |   | |d|       |",
"+-+---+-+-----+-+---+   +---+---+-+-+-------+",
"|d      |           |   |           |      d|",
"+-+=+---+-+-+=+-+---+-+-+=+-+-+-----+-+=+-+-+",
"|   |     |#    =     |     = =         = |d|",
"|   |     +-+   +---+ | +---+ +=+-+-+   + +=+",
"|   |       |   |   | | |   | | | |d|   |   |",
"+=+-+---+=+-+-+=+   + | +   + +-+ + +-+ +   |",
"|             = |   = | =   | |       | |   |",
"+-----+-+=+=+-+=+---+ + +---+=+---+===+-+---+",
"|     | | |   | |   | | |  d|               |",
"|     + | |   | +   +=+=+   +-----+ +-----+ |",
"|     = | |   | =   |   |   =     | |     | |",
"| +=+-+-+=+---+=+   |   |   +     +=+---+=+ |",
"| | |   = =     |   |   |   |     = =       |",
"| +-+=+-+=+---+=+---+===+---+=+---+=+-----+ |",
"|       |       |           |     | |     | |",
"| +---+-+ +---+=+           +-----+ +-+-+=+ |",
"| |   |d| =     =    H      =     = | |   | |",
"| +-+ + | +-----+   + +     +-----+ + +   + |",
"| =     | |     |   | |     |     | | =   = |",
"+-+   +-+=+     |   | |     |     + +-+   +-+",
"|#=   | = =     |   |1|     |         |   =#|",
"+-+---+---------+---+-+-----+---------+-----+",
}, {
"+-----+-+-----------+---+-------+-----------+", // 68. Malefia 2
"|     | |          u|u  |u      |           |",
"|     | +   +=+-----+   + +-+=+=+-+=+-+   +=|",
"|     | =   |       |   = |   | =   = |   | |",
"|     +-+   |     +-+---+-+---+-+-+-+=+---+=+",
"|     = =   |     |                 |d      |",
"+-----+=+---+-+=+-+=+-----+=+-----+=+-----+=+",
"|       |u d|   =   |     = =     | |       |",
"| +-----+---+-+-+   +-----+=+---+-+=+       |",
"| |    u|     = |   | | |       =   =       |",
"|=+=+---+     + +=+-+---+---+=+-+   +-------+",
"|d= =   |     | |   =   =   | |d    |V      |",
"|=+ +---+=+=+-+-+=+-+   +   | |     +---+=+-+",
"|   |     |    d| |     |   | |     |   | = |",
"| +-+-+   +-----+-+-+-+ |   | |     |   | +=+",
"| |   |         |u    | |   | |     |   | = |",
"| +-+ +=+       +     +-+---+ +-----+ +-+ +=+",
"|   | | |       |     =   |         = = = = |",
"|   + + +-------+     +-----+ +---+-+-+-+-+ |",
"|   | =         |  L  |     | |   |     | |u|",
"+-+-+=+-+-----+-+-----+ +-+ | | +-+-+=+-+=+-+",
"|#| =   =     |u|       | | | |   =u= = =   |",
"+-+ +   +-----+-+=+-+   +=+ | +---+=+=+-+   |",
"|u  |   |     |     |       | |d    |   |  u|",
"+   +---+-+-+=+-+=+=+-+-----+=+-----+---+-+-+",
"|   =   = | = = | | = |             |      u|",
"|   +-+=+-+=+=+ +=+-+=+   +-------+=+-+=+-+ |",
"|   =   = = |         |   |       |u| = | | |",
"+   +=+-+=+-+ +-----+ |   +-+-+ + +=+-+ +=+=+",
"|   | |   =   |     | |   = |   | | | |d|   |",
"+ +-+ +=+-+=+ +-+=+-+=+---+ |   + | +=+-+   +",
"|   = = |   |             |u|     | = =     |",
"|   +-+=+ +=+ +-----+     +-+   +-+-+-+-----+",
"|       = | = |     |  d    |               |",
"+---+-+ +-+-+ + +   |       |   +-+   +-----+",
"|   = | = | = | |   |       |   | |   |     |",
"+=+-+ +-+=+=+=+-+=+=+-------+ +-+=+=+-+=+-+-+",
"    |   |  d=     =             =   |     =  ",
"+=+-+---+-+-+=+-+=+-+   +-+ +-+-+=+-+-+   +=+",
"|   |  u  |     | | |   |d| | = = |   |   | |",
"+-+=+ +-+ +---+-+ | +---+=+-+=+-+ +=+-+-+=+-+",
"|   |     |   |   |       |   =   |   |     |",
"+-+=+-+=+-+   +---+   +   +   +---+   +   +-+",
" #        |     |     |       =   |        # ",
"+-+---+---------+---+-+-----+-----+---------+",
}, {
"+-----+---+=+-+-----+-+-------+-+ +-----+---+", // 69. Malefia 3
"|     |   | = |     | |       |         |   |",
"|   +-+   +=+-+=+-+-+=+   +=+-+---+=+=+=+   |",
"|   = =     = |   |   =   |   |S    | | |   |",
"|   +-+-+---+-+=+-+   +   |   +---+-+=+-+=+-+",
"|   |   |     |   |   |   |   |   |  u= = = |",
"|   +=+-+ +-+ |   +-+=+---+---+   +=+-+ +=+ |",
"|   =   |  u  |       |#  =   |     =     | |",
"+---+   +=+-+=+-------+---+   +-----+---+ + |",
"|   |   |   |         |   =   |     |   | = |",
"|   +   |   +-+=+-+=+=+   +---+=+   +   +=+-+",
"|u  =   |   = = = = | |   =   |u|   =   |   |",
"+---+-+-+---+-+-+=+-+=+   +   +-+---+   +   |",
"|     |        u|     |   |   = =   |   =   |",
"|   +-+       +-+-----+---+---+ +   +---+   |",
"|   = =       |               | |   |   |   |",
"|   +-+-+     | +-----------+ +-+-+ +=+=+=+-+",
"|   |   |     | |           | |   | | | =   |",
"+-+=+   +-+---+ | +-------+ | |   +=+-+=+   |",
"|   |     |   | | |       | | |   = |   |   |",
"+   +-+=+-+   | | | +---+ | | |   + +---+---+",
" u  = = =     | | | |  T| | | |   |          ",
"+---+-+-+-----+ | | +=+-+ | | +---+---------+",
"|   |   |     | | | |     | | |u  |         |",
"|   +-+=+     | | +=+-----+ | +-+=+=+=+---+ |",
"|   =   =     | |           | |     | =   | |",
"+---+=+-+=+-+ | +-+=+-------+ | +---+-+-+=+ |",
"|   |   |   | |        P      | |     |   | |",
"|   +---+   | +-------+&+-+---+ +---+=+---+ |",
"|   |   |   | =       |1| |   |     = |u    |",
"+=+-+=+-+   +=+-+=+=+ + +=+   +---+-+-+-----+",
"|   =   =   = = | |   = |     =   | =       |",
"+---+-+=+=+-+-+=+-+---+ +-----+   +-+   +---+",
"|     |   |       =   |u|W        |     =   |",
"+=+-+-+ +-+-+---+=+-+=+ +         |   +-+   |",
"| = = = |   |   |     |           |   | =  u|",
"+-+=+=+-+   |   +=+-+ +---+-+-+---+   +-+---+",
"|   |   |  u|     = | |   | = |       =     |",
"|   +-+=+---+ +-+-+=+-+-+=+=+-+ +-+   +   +-+",
"|   = =       = =     | =u|   |   |   |   =F|",
"+---+=+-+=+=+-+=+---+-+=+-+   +---+---+---+-+",
"|       | |   | =   | |   =       |         |",
"+-+     +-+---+=+=+-+ +   +-+     +-+=+-+=+-+",
"|#      |       |     |     |     = =   |  #|",
"+-------+-+=+---+-----+-----+---+ +-+---+---+",
}, {
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // 70. Tarjan
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+-+-+-+-+-+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|# # # # # #|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| +-------+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |#     #|#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | +-+-+ | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |#|  #| |#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | | + | | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| |#| |#| |#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | | +-+ | |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|#|#|     |#|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"| | +-----+ |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"|#|# # # # #|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
"+-+---------+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
} };

MODULE const STRPTR oracle[71] = {
""                                                                          , //  0 Realm wilderness
"The Catacombs are entered by saying TARJAN to the priest in Skara Brae."   \
"\nSay CHAOS to the priest to enter UnterBrae."                             , //  1 Skara Brae
""                                                                          , //  2 Catacombs 1
"Exploration reveals the name of the true one, CHAOS."                      , //  3 Catacombs 2 aka Tunnels
"The answer is BLUE."                                                       , //  4 UnterBrae 1
"The answer is SHADOW."                                                     , //  5 UnterBrae 2
"The answer is SWORD."                                                      , //  6 UnterBrae 3
"Go N E N E E S S E E E E N N W N N W W N to pass the first ward. The"      \
"\nsecond ward is passed by going straight to one of the side walls and"    \
"\nfollowing it north. The final battle against Brilhasti ap Tarj is"       \
"\ndifficult but rewarding."                                                , //  7 UnterBrae 4
""                                                                          , //  8 Arborian wilderness
"The Sacred Grove can only be entered by giving Tslotha's head to the king.", //  9 Ciera Brannia
""                                                                          , // 10 Festering Pit 1
"Kill Tslotha normally and the Nightspear will absorb his soul."            \
"\nTake his head and his heart."                                            , // 11 Festering Pit 2
"Use a wineskin to collect as much of the Water of Life as possible."       , // 12 Crystal Palace
""                                                                          , // 13 Valarian's Tower 1
""                                                                          , // 14 Valarian's Tower 2
"Drop an acorn in the hole and then use the Water of Life."                 , // 15 Valarian's Tower 3
""                                                                          , // 16 Valarian's Tower 4
"When you enter the tomb, place the heart in the bowl, use the Water of"    \
"\nLife and wait for something to happen. You can then gain access to"      \
"\nValarian's Bow and the Arrows of Life."                                  , // 17 Sacred Grove
"Before coming to the Ice Keep you should visit the outpost and read"       \
"\nAlendar's diary."                                                        , // 18 Gelidian wilderness
""                                                                          , // 19 White Tower 1
""                                                                          , // 20 White Tower 2
""                                                                          , // 21 White Tower 3
"The lens is on the fourth level."                                          , // 22 White Tower 4
""                                                                          , // 23 Grey Tower 1
""                                                                          , // 24 Grey Tower 2
""                                                                          , // 25 Grey Tower 3
"Enter the broken cross on the fourth level by casting APAR into the flaw." , // 26 Grey Tower 4
""                                                                          , // 27 Black Tower 1
""                                                                          , // 28 Black Tower 2
""                                                                          , // 29 Black Tower 3
"The lens is on the fourth level."                                          , // 30 Black Tower 4
""                                                                          , // 31 Ice Dungeon 1
"The answer to the question is CALA, which will allow you through to the"   \
"\nWand of Power and the Sphere of Lanatir."                                , // 32 Ice Dungeon 2
"Say ALENDAR to make the stairs appear. In each of three corners there is"  \
"\nthe entrance to a tower - you need a lens from each one. They are"       \
"\nentered by casting the correct combination of spells. When you have the" \
"\nthree lenses it should be obvious where to use them (first level of the" \
"\nIce Keep). Cast these spells in the northwest corner to gain entrance to"\
"\nthe Grey Tower: INWO, WIHE, FOFO, INVI. Cast these spells in the"        \
"\nnortheast corner to gain entrance to the White Tower: LEVI, ANMA, PHDO." \
"\nCast these spells in the southeast corner to gain entrance to the Black" \
"\nTower: MAFL, SHSP, FEAR, SUEL, SPBI. The Ice Dungeon can be entered only"\
"\nafter you have used the three lenses in the right place in the Ice Keep.", // 33 Ice Keep 1
""                                                                          , // 34 Ice Keep 2
"Before entering Alliria's Tomb you should make sure you have five roses -" \
"\nred, blue, yellow, white and rainbow. (There is a bush near the city"    \
"\nwhich is not blooming. Use the Water of Life and then the dragon's"      \
"\nblood on it to make a rainbow rose)."                                    , // 35 Lucencian wilderness
"Bard's Hall (N13 E9): make sure you buy Kiel's Overture for your Bard to"  \
"\nuse. Wizard's Guild (N4 E5): your place of level advancement. Your"      \
"\nspellcasters can also pay 50,000 gp each to learn Divine Intervention."  \
"\nShrine (N2 E7): heals all. Tavern (N13 E7): if you don't have one, buy a"\
"\nwineskin here, as you'll need one for Violet Mountain, your next stop."  , // 36 Celaria Bree
""                                                                          , // 37 Violet Mountain 1
"Kill the dragon. You will receive a key to Cyanis's Tower. You should"     \
"\nalso collect some of the dragon's blood in a wineskin."                  , // 38 Violet Mountain 2
"Use the Crystal Key to unlock the door."                                   , // 39 Cyanis's Tower 1
""                                                                          , // 40 Cyanis's Tower 2
"Cyanis is on the third level and can be dealt with in two ways - either"   \
"\ncast a healing spell or else wait until he attacks you. Whichever you do"\
"\nyou will receive a magic triangle."                                      , // 41 Cyanis's Tower 3
"The stairs to level 2 are blocked - use of the magic triangle will fix"    \
"\nthis."                                                                   , // 42 Alliria's Tomb 1
"When you are asked for flowers, you should use the appropriate rose."      \
"\nThe order of use should be white, blue, red, yellow, rainbow. After you" \
"\nuse the last flower you will gain access to the Crown of Truth and the"  \
"\nBelt of Alliria."                                                        , // 43 Alliria's Tomb 2
"Exploration will reveal a Right Key here."                                 , // 44 Barracks
"Say ICEBERG to Hawkslayer. You should go to both the Private"              \
"\nQuarters and the Barracks before attempting to tackle the Workshop."     , // 45 Ferofist's Palace
"There are two thing here - a Left Key and a message from Ferofist which"   \
"\nrefers to the number of times each key should be turned."                , // 46 Private Quarters
"There is a locked door in the floor. You should turn the Right Key 18"     \
"\ntimes and the Left Key 15 times."                                        , // 47 Workshop 1
""                                                                          , // 48 Workshop 2 aka Urmech's Paradise
"Use the GILL spell to prevent yourself from dying in the oil."             , // 49 Workshop 3 aka Viscous Plane
"Show pity to Urmech - you can then collect the Hammer of Wrath and"        \
"\nFerofist's Helm. Urmech will also turn any of your fighters into"        \
"\nGeomancers if you wish."                                                 , // 50 Workshop 4 aka Urmech's Sanctum
"Find 'The Middle of Nowhere' and drop the door. Using the lock will open"  \
"\na hole in the ground."                                                   , // 51 Nowhere aka Tenebrosian wilderness
"There is a ring of trees in the middle of the copse which you cannot"      \
"\nenter. Use the tar to burn down a tree and collect the Shadow Door."     , // 52 Dark Copse
"Bard's Hall (N7 E6): Here you can learn the new song Minstrel Shield."     \
"\nWizard's Guild (N7 E9): Here you can buy the NUKE spell, the most"       \
"\npowerful offensive spell in the game."                                   , // 53 Black Scar
"There is only one safe path through the maze of traps. Go W10, S12, E8,"   \
"\nN4, W3, N1 (W W W W W W W W W W S S S S S S S S S S S S E E E E E E E E" \
"\nN N N N W W W N) and collect some tar in a wineskin."                    , // 54 Tar quarry
"Your task here is to find the Shadow Lock. The only access to this is by"  \
"\ncasting PHDO in the right place (ie. about halfway up on the eastern"    \
"\nside of the canyon)."                                                    , // 55 Shadow Canyon
""                                                                          , // 56 Sceadu's Demesne 1
"Sceadu is not where you would expect him to be, and should be killed"      \
"\nquickly. You can then collect the Helm of Justice and Sceadu's Cloak."   \
"\n(NB. To gain access to most of level two you will have to cast PHDO on"  \
"\nthe correct sections of wall. These are N10, E7 of the portal down.)"    , // 57 Sceadu's Demesne 2
"Fight Werra and six Black Slayers will appear - it is best to run from"    \
"\nthem, at which point you can safely collect Werra's Shield. Don't worry" \
"\nabout the Strifespear - it's in Malefia."                                , // 58 Tarmitian dungeon
"The name of the war god in each must be told to the death's head. Whenever"\
"\na god is named correctly the name of the next one is given. The god is"  \
"\nSDIABM."                                                                 , // 59 Wasteland
"When you return to Berlin you should say TYR and then WERRA."              , // 60 Berlin
"The name of the war god in each must be told to the death's head. Whenever"\
"\na god is named correctly the name of the next one is given. The god is"  \
"\nSVARAZIC."                                                               , // 61 Stalingrad
"The name of the war god in each must be told to the death's head. Whenever"\
"\na god is named correctly the name of the next one is given. The god is"  \
"\nSUSA-NO-O."                                                              , // 62 Hiroshima
"The name of the war god in each must be told to the death's head. Whenever"\
"\na god is named correctly the name of the next one is given. The god is"  \
"\nARES."                                                                   , // 63 Troy
"The name of the war god in each must be told to the death's head. Whenever"\
"\na god is named correctly the name of the next one is given. The god is"  \
"\nMARS."                                                                   , // 64 Rome
"The name of the war god in each must be told to the death's head. Whenever"\
"\na god is named correctly the name of the next one is given. The god is"  \
"\nST GEORGE."                                                              , // 65 Nottingham
"The name of the war god in each must be told to the death's head. Whenever"\
"\na god is named correctly the name of the next one is given. The god is"  \
"\nYEN-LO-WANG."                                                            , // 66 K'un Wang
"The on-screen map is useless here as some parts of each level are"         \
"\ninaccessible except via the other levels. You should map all the portals,"\
"\nstairs and teleports on the first three levels to find routes through to"\
"\nthe more difficult-to-reach areas. Your task is to free the six gods by" \
"\nusing the weapons named after them. There is one on level 1."            , // 67 Malefia 1
"The on-screen map is useless here as some parts of each level are"         \
"\ninaccessible except via the other levels. You should map all the portals,"\
"\nstairs and teleports on the first three levels to find routes through to"\
"\nthe more difficult-to-reach areas. Your task is to free the six gods by" \
"\nusing the weapons named after them. There are two on level 2."           , // 68 Malefia 2
"The on-screen map is useless here as some parts of each level are"         \
"\ninaccessible except via the other levels. You should map all the portals,"\
"\nstairs and teleports on the first three levels to find routes through to"\
"\nthe more difficult-to-reach areas. Your task is to free the six gods by" \
"\nusing the weapons named after them. There are three on level 3."         \
"\nOnce all are free a door opens allowing access to the central core and"  \
"\nfour of the toughest battles of your life."                              , // 69 Malefia 3
"When you reach Tarjan, it is best not to kill the Black Slayers, but to"   \
"\nkeep them away with SAST spells while your rogue sneaks up through the"  \
"\nshadows to kill the Mad God. Then finish off the Slayers with a few NUKE"\
"\nspells and you will be rewarded with quite a nice closing sequence."     , // 70 Tarjan
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[2][4 + (21 * 2)] = {
{   0x0000, 0x0000, // reserved

/*  ..GG .... .... ....    . = Transparent (%00)
    ..GB G... .... ....    G = Green       (%01)
    ..GB BG.. .... ....    P = Purple      (%10) (unused)
    ...G BBG. .... ....    B = Blue        (%11)
    .... GBBG .... ....
    .... .GBB G... ....
    .... ..GB BG.. ....
    ...G GGGB BBG. ....
    ..GB BBGB BBBG ....
    ..GB BBGB BBBB G...
    ..GB BGGB BBBB G...
    .GGG GGBB BBBB G...
    GBBB BBBB BBBB G...
    GBBB BBBB BBBB G...
    .GGG BBBB BBBB BG..
    ...G GBBB BBBB BGG.
    .... GGBB BBBB GBBG
    .... .GGG GBGG BBBG
    .... .... GGBB BGG.
    .... .... GBBB G...
    .... .... .GGG ....

    Plane 0 Plane 1 */
    0x3000, 0x0000,
    0x3800, 0x1000,
    0x3C00, 0x1800,
    0x1E00, 0x0C00,
    0x0F00, 0x0600,
    0x0780, 0x0300,
    0x03C0, 0x0180,
    0x1FE0, 0x01C0,
    0x3FF0, 0x1DE0,
    0x3FF8, 0x1DF0,
    0x3FF8, 0x19F0,
    0x7FF8, 0x03F0,
    0xFFF8, 0x7FF0,
    0xFFF8, 0x7FF0,
    0x7FFC, 0x0FF8,
    0x1FFE, 0x07F8,
    0x0FFF, 0x03F6,
    0x07FF, 0x004E,
    0x00FE, 0x0038,
    0x00F8, 0x0070,
    0x0070, 0x0000,

    0x0000, 0x0000  // reserved
},
{   0x0000, 0x0000, // reserved

/*  Y... .... .... ....    . = Transparent (%00)
    OY.. .... .... ....    Y = Yellow      (%01)
    .OY. .... .... ....    O = Orange      (%10)
    ..OY .... .... ....    - = Unused      (%11)
    ...O Y... .... ....
    ...O YYO. .... ....
    .YY. OYYY .... ....
    .OO. .YYY Y... ....
    .... OOOY YY.. ....
    .YYY YOOY YY.. ....
    .OOY YYYY YY.Y ....
    ...O OYYY OO.Y ....
    .... .OOO ..YY ....
    .... .... .OO. ....
    .... .... .... ....
    .... .... .... ....
    .... .... .... ....
    .... .... .... ....
    .... .... .... ....
    .... .... .... ....
    .... .... .... ....

    Plane 0 Plane 1 */
    0x8000, 0x0000,
    0x4000, 0x8000,
    0x2000, 0x4000,
    0x1000, 0x2000,
    0x0800, 0x1000,
    0x0C00, 0x1200,
    0x6700, 0x0800,
    0x0780, 0x6000,
    0x01C0, 0x0E00,
    0x79C0, 0x0600,
    0x1FD0, 0x6000,
    0x0710, 0x18C0,
    0x0030, 0x0700,
    0x0000, 0x0060,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,

    0x0000, 0x0000  // reserved
} };
#endif

/* Module and global variables are initialized to zero by default.
   Any variables used in GetAttr() calls must be ULONGs. */

MODULE struct
{   TEXT  name[14 + 1];
    ULONG status, race, theclass,
          curst, curiq, curdx, curcn, curlk,
          maxst, maxiq, maxdx, maxcn, maxlk,
          armour,
          curlev, maxlev,
          sorc, conj, magi, wiza, arch,
          songs, attacks, theimage, special, damage,
          equip[12], item[12], quantity[12],
          maxhp, curhp, maxsp, cursp,
          xp, gp,
          sex,
          spell[SPELLS + 1];
} man[MEN];

/* 7. MODULE STRUCTURES -------------------------------------------------- */

MODULE struct
{   const UBYTE  bt1, bt2, bt3, btcs;
    const STRPTR name;
} items[ITEMS + 1] = {
{  0,   0,   0,   0, "Nothing"},
{  0,   0, 117,   0, "Acorn"},
{ 62,  57,  57,   0, "Admt Chain"},
{ 51,   0,   0,   0, "Admt Dagger"},
{ 53,  51,  51,   0, "Admt Gloves"},
{ 52,  50,  50,   0, "Admt Helm"},
{ 54,   0,   0,   0, "Admt Mace"},
{ 64,  59,  59,   0, "Admt Plate"},
{ 63,   0,   0,   0, "Admt Scale"},
{ 50,  49,  49,   0, "Admt Shield"},
{ 49,  48,  48,   0, "Admt Sword"},
{  0,  72,  72,   0, "Ag's Arrows"},
{ 58,  54,  54,   0, "Ali's Carpet"},
{  0,   0,   0,  20, "Ancient Torch"}, // actually Ancient Torc [sic]
{  0,   0, 210,   0, "Angel's Harp"},
{  0,   0, 185,   0, "Angel's Ring"},
{  0, 102, 102,   0, "Angra's Eye"},
{  0,   0,   0,  14, "Ankh"},
{  0,   0,   0,  58, "Antidote"}, // actually Anitdote [sic]
{  0, 101, 101,   0, "Aram's Knife"},
{105,   0,   0,   0, "Arc's Eye"},
{ 85,   0,   0,   0, "Arc's Hammer"},
{ 66,   0,   0,   0, "Arcshield"},
{  0,   0, 122,   0, "Arefolia"},
{  0,  22,  22,  11, "Arrows"},
{  0,   0, 124,   0, "Arrows of Life"},
{  0,   0,   0,  45, "Assassin Cloak"},
{  0,   0,   0,  27, "Barbed Sword of Pain"},
{  0,  74,  74,   0, "Bard Bow"},
{ 29,  29,  29,   0, "Bardsword"},
{  0,   0, 136,   0, "Belt of Alliria"},
{  0,   0, 159,   0, "Black Arrows"},
{  0,   0, 114,   0, "Black Lens"},
{  0,   0,   0,  21, "Black Sphere"},
{  0,   0,   0,  26, "Blade"}, // actually lowercase
{ 44,   0,   0,   0, "Blood Axe"},
{  0,   0, 201,   0, "Blood Mesh Robe"},
{  0,   0, 146,   0, "Blue Rose"},
{  0,   0, 167,  51, "Bolt"}, // actually Bolts in BTCS
{  0,   0,   0,  33, "Boom Box"},
{  0,  53,  53,   0, "Boomerang"},
{  0,   0,   0,  10, "Bow"},
{ 65,  60,  60,   0, "Bracers [4]"},
{ 28,  28,  28,   0, "Bracers [6]"},
{  0,   0,   0,  37, "Bracers [8]"}, // actually omits the [8]
{  0,  82,  82,   0, "Breathring"},
{  0,   0,   0,  31, "Bright Blade of Hope"},
{  3,   3,   3,   2, "Broadsword"},
{ 55,   0,   0,   0, "Broom"},
{  0, 105, 105,   0, "Brothers Fgn"},
{ 10,  10,  10,   0, "Buckler"},
{  0,   0,   0,  44, "Bulk Shield"},
{  0,  56,  57,   0, "Bulldozer Fgn"},
{  0,   0,   0,  54, "Bullet-proof Vest"},
{  0,   0, 125,   0, "Canteen"},
{ 13,  13,  13,   8, "Chain Mail"},
{  0,   0, 222,   0, "Cli Lyre"},
{  0,  30,  30,   0, "Cold Horn"},
{ 84,  78,  78,   0, "Conjurstaff"},
{  0,   0, 135,   0, "Crown of Truth"},
{  0,   0,   0,  48, "Crusher"},
{  0,   0, 220,   0, "Crystal Gem"},
{  0,   0, 137,   0, "Crystal Key"},
{  0,   0, 112,   0, "Crystal Lens"},
{113,  89,  89,   0, "Crystal Sword"},
{  5,   5,   5,   0, "Dagger"},
{  0, 118,   0,   0, "Dagger!"},
{104,   0,   0,   0, "Dag Stone"},
{ 45,  44,  44,   0, "Dayblade"},
{116,   0,   0,   0, "Death Dagger"},
{  0,   0, 190,   0, "Death Fgn"},
{  0,   0, 200,   0, "Death Hammer"},
{  0,   0, 186,   0, "Deathhorn"},
{101,  88,  88,   0, "Deathring"},
{  0,  58,  58,   0, "Death Stars"},
{  0,   0,   0,  36, "Defense Ring"},
{  0,   0,   0,  59, "Deiley's Ring"},
{  0,   0, 142,   0, "Divine Halbard"},
{  0,   0, 189,   0, "Dmnd Bracers"},
{ 80,   0,   0,   0, "Dmnd Dagger"},
{  0,   0, 214,   0, "Dmnd Flail"},
{ 81,  75,  75,   0, "Dmnd Helm"},
{ 90,  84,  84,   0, "Dmnd Plate"},
{  0,   0, 181,   0, "Dmnd Scale"},
{ 79,  73,  73,   0, "Dmnd Shield"},
{  0,   0, 219,   0, "Dmnd Staff"},
{  0,   0, 213,   0, "Dmnd Suit"},
{ 78,   0,   0,   0, "Dmnd Sword"},
{ 41,   0,   0,   0, "Dork Ring"},
{108,  98,  98,   0, "Dragon Fgn"},
{ 89,  83,  83,   0, "Dragonshield"},
{ 93,  87,  87,   0, "Dragonwand"},
{  0,  93,  93,   0, "Drums of Death"},
{  0, 106, 106,   0, "Dynamite"},
{  0,   0, 217,   0, "Eelskin Tunic"},
{  0,  76,  76,   0, "Elf Boots"},
{ 47,  46,  46,   0, "Elf Cloak"},
{  0,   0, 183,   0, "Eternal Torch"},
{ 57,   0,   0,   0, "Exorwand"},
{119,   0,   0,   0, "Eye"},
{  0,   0, 204,   0, "Familiar Fgn"},
{  0,   0, 153,   0, "Ferofist's Helm"},
{ 42,  41,  41,   0, "Fin's Flute"},
{  0,   0, 131,   0, "Firebrand"},
{ 30,   0,   0,   0, "Fire Horn"},
{  0,   0,   0,  23, "Fire Ring"},
{  0,   0, 129,   0, "Fire Spear"},
{ 96,  91,  91,   0, "Flame Horn"},
{  0,   0, 175,   0, "Flame Knife"},
{  0,   0, 243,   0, "Flare Crystal"},
{ 22,   0,   0,   0, "Flute"},
{ 77,  71,  71,   0, "Frost Horn"},
{ 76,  70,  70,   0, "Galt's Flute"},
{  0,   0, 194,   0, "Galvanic Oboe"},
{ 19,  19,  19,   0, "Gauntlets"},
{  0,   0,   0,  63, "Gems"},
{ 61,  27,  27,   0, "Giant Fgn"},
{  0,   0,   0,  18, "Gloves of Whalo"},
{  0,   0, 245,   0, "Gods' Blade"},
{ 82,   0,   0,   0, "Golem Fgn"},
{  0,   0,   0,  49, "Great Axe"},
{  0, 109, 109,   0, "Grenade"},
{  7,   7,   7,   0, "Halbard"},
{  0,   0,   0,  32, "Halen's Guitar"},
{  0,   0, 152,   0, "Hammer of Wrath"},
{ 21,   0,   0,   0, "Harp"},
{  0,   0, 195,   0, "Harmonic Gem"},
{ 48,  47,  47,   0, "Hawkblade"},
{  0,   0,   0,  64, "Headache Maker"},
{ 75,   0,   0,   0, "Heal Harp"},
{  0,   0,   0,  57, "Healing Potion"},
{  0,   0, 177,   0, "Heartseeker"},
{  0,   0,   0,  50, "Heavy Crossbow"},
{  0,   0,   0,  39, "Heavy Metal"},
{ 17,  17,  17,   0, "Helm"},
{  0,   0, 156,   0, "Helm of Justice"},
{  0, 103, 103,   0, "Herb Fgn"},
{  0,   0,   0,  25, "Hilt"}, // actually lowercase
{  0,   0, 172,   0, "Holy Avenger"},
{  0,   0, 244,   0, "Holy Missile"},
{  0,   0,   0,  43, "Holy Shield"},
{  0,   0, 132,   0, "Holy Sword"},
{  0,   0, 182,   0, "Holy TNT"},
{  0,   0,   0,  12, "Horned Key"},
{  0,   0, 248,   0, "Horn of Gods"},
{  0,   0, 205,   0, "Hourglass"},
{  0,   0, 246,   0, "Hunter Blade"},
{  0,   0, 199,   0, "Hunters Cloak"},
{  0,   0,   0,  42, "Huskie Figurine"},
{  0,   0, 144,   0, "I-ching"},
{  0,   0, 143,   0, "Incense"},
{  0, 115,   0,   0, "Item of Kazdek"},
{  0,   0,   0,  62, "Jewels"},
{ 43,  42,  42,   0, "Kael's Axe"},
{  0,   0, 174,   0, "Kali's Garrotte"},
{  0,  68,  68,   0, "Kato's Bracer"},
{ 94,   0,   0,   0, "Kiel's Compass"},
{  0,   0,   0,  22, "Kyra's Cat Axe"},
{ 39,   0,   0,   0, "Lak's Lyre"},
{  2,   2,   2,   0, "Lamp"},
{ 12,  12,  12,   7, "Leather Armor"},
{ 18,  18,  18,  41, "Leather Glvs."}, // Leather Gloves in BTCS
{  0,   0, 164,   0, "Left Key"},
{  0,   0, 165,   0, "Lever"},
{118,   0,   0,   0, "Lich Fgn"},
{  0,   0,   0,  53, "Light Sabre"},
{  0,   0, 134,   0, "Lightstar"},
{ 31,  31,  31,   0, "Lightwand"},
{  0,   8,   8,   0, "Long Bow"},
{  0,   0,   0,  52, "Longsword"},
{ 92,   0,   0,   0, "Lorehelm"},
{ 60,  55,  55,   0, "Luckshield"},
{  8,   0,   0,   0, "Mace"},
{109,   0,   0,   0, "Mage Fgn"},
{  0,   0,   0,  38, "Mage Ring"},
{ 68,  63,  63,   0, "Mage Staff"},
{  0,   0, 203,   0, "Mages Cloak"},
{  0,   0, 242,   0, "Mages Glove"},
{ 59,   0,   0,   0, "Magic Mouth"},
{  0,   0,   0,  34, "Magic Sword"},
{  0,   0, 150,   0, "Magic Triangle"},
{ 20,  20,  20,   5, "Mandolin"},
{  0,  99,  99,   0, "Mastermage Fgn"},
{120, 110, 110,   0, "Master Key"},
{  0, 104, 104,   0, "Master Wand"},
{  0,   0, 198,   0, "Minstrels Glove"},
{  0,   0, 171,   0, "Misericorde"},
{  0,  38,  38,   0, "Molten Fgn"},
{117,   0,   0,   0, "Mongo Fgn"},
{ 88,   0,   0,   0, "Mournblade"},
{  0,  43,  43,   0, "Mthr Arrows"},
{ 35,  35,  35,   0, "Mthr Axe"},
{ 25,  25,  25,   0, "Mthr Chain"},
{ 32,  32,  32,   0, "Mthr Dagger"},
{ 34,  34,  34,   0, "Mthr Gloves"},
{ 33,  33,  33,   0, "Mthr Helm"},
{ 36,   0,   0,   0, "Mthr Mace"},
{ 37,  37,  37,   0, "Mthr Plate"},
{ 26,  26,  26,   0, "Mthr Scale"},
{ 24,  24,  24,   0, "Mthr Shield"},
{  0,   0, 240,   0, "Mthr Suit"},
{ 23,  23,  23,   0, "Mthr Sword"},
{  0,   0, 119,   0, "Nightspear"},
{  0, 111, 111,   0, "Nospin Ring"},
{  0,   0,   0,  61, "Nove Blade"},
{  0,   0, 166,   0, "Nut"},
{ 38,   0,   0,   0, "Ogre Fgn"},
{106,  67,  67,   0, "Ogrewand"},
{126,   0,   0,   0, "Old Man Fgn"},
{112,   0,   0,   0, "Onyx Key"},
{  0,   0, 184,   0, "Oscon's Staff"},
{ 99,  94,  94,   0, "Pipes of Pan"},
{ 15,  15,  15,  35, "Plate Armor"},
{  0,   0,   0,  56, "Platinum Crown"},
{  0,   0,   0,  46, "Poison Blade"},
{  0,   0, 192,   0, "Poison Dagger"},
{ 87,  81,  81,   0, "Powerstaff"},
{ 56,  52,  52,   0, "Pureblade"},
{ 67,  62,  62,   0, "Pure Shield"},
{  0,   0, 215,   0, "Purple Heart"},
{  0,   0, 149,   0, "Rainbow Rose"},
{  0,   0,   0,  16, "Red Cult pass"},
{  0,   0, 176,   0, "Red's Stiletto"},
{  0,   0, 163,   0, "Right Key"},
{100,  95,  95,   0, "Ring of Power"},
{  0,  80,  80,   0, "Ring of Return"},
{  0,   0,   0,  15, "Receipt"}, // actually lowercase
{  0,   0, 147,   0, "Red Rose"},
{ 16,  16,  16,   9, "Robes"},
{ 27,   0,   0,   0, "Samurai Fgn"},
{ 14,  14,  14,   0, "Scale Armor"},
{  0,   0, 157,   0, "Sceadu's Cloak"},
{  0, 119,   0,   0, "Seg #1"},
{  0, 120,   0,   0, "Seg #2"},
{  0, 121,   0,   0, "Seg #3"},
{  0, 122,   0,   0, "Seg #4"},
{  0, 123,   0,   0, "Seg #5"},
{  0, 124,   0,   0, "Seg #6"},
{  0, 125,   0,   0, "Seg #7"},
{  0,   0, 158,   0, "Shadelance"},
{  0,   0, 170,   0, "Shadow Door"},
{  0,   0, 169,   0, "Shadow Lock"},
{  0,   0, 173,   0, "Shadowshiv"},
{  0,   0, 162,   0, "Sheetmusic"},
{ 40,  40,  40,   0, "Shield Ring"},
{ 46,  45,  45,   0, "Shield Staff"},
{  4,   4,   4,   3, "Short Sword"},
{  0,   0, 209,   0, "Shrill Flute"},
{  0,  36,  36,   0, "Shuriken"},
{123,   0,   0,   0, "Silver Circle"},
{122,   0,   0,   0, "Silver Square"},
{124,   0,   0,   0, "Silver Triangle"},
{  0,  61,  61,   0, "Slayer Fgn"},
{  0,   0,   0,   6, "Small Shield"},
{  0,   0, 113,   0, "Smokey Lens"},
{  0,  96,  96,   0, "Song Axe"},
{  0,   0, 202,   0, "Soothing Balm"},
{  0,   0, 218,   0, "Sorcerer's Hood"},
{ 73,  69,  69,   0, "Sorcerstaff"},
{ 71,  66,  66,   0, "Soul Mace"},
{  0,   0, 168,   0, "Spanner"},
{  0,   0, 193,   0, "Spark Blade"},
{103,   0,   0,   0, "Spectre Mace"},
{127, 127,   0,   0, "Spectre Snare"},
{  0,  21,  21,   0, "Spear"},
{ 95,  90,  90,   0, "Speedboots"},
{  0,  39,  39,   0, "Spell Spear"},
{  0,   0, 115,   0, "Sphere of Lanatir"},
{ 98,   0,   0,   0, "Spiritdrum"},
{107,   0,   0,   0, "Spirithelm"},
{  9,   9,   9,   4, "Staff"},
{  0,   0, 247,   0, "Staff of Gods"},
{ 86,  79,  79,   0, "Staff of Lor"},
{  0,   0, 187,   0, "Staff of Mangar"},
{  0,   0,   0,  60, "Star Gavel"},
{  0,   0, 141,   0, "Steady Eye"},
{  0,   0, 139,   0, "Stealth Arrows"},
{114, 108, 108,   0, "Stoneblade"},
{  0,   0, 161,   0, "Strifespear"},
{  0,   0,   0,  13, "Suck-O-Matic"},
{  0,   0, 207,   0, "Surehand Amulet"},
{ 74,   0,   0,   0, "Sword of Pak"},
{  0, 113,   0,   0, "Sword of Zar"},
{  0,   0, 138,   0, "Tao Ring"},
{  0,   0, 188,   0, "Tesla Ring"},
{  0,   0, 211,   0, "The Book"},
{  0, 116,   0,   0, "The Ring"},
{  0, 126,   0,   0, "The Scepter"},
{ 70,  65,  65,   0, "Thief Dagger"},
{  0,   0, 208,   0, "Thieves Dart"},
{  0,   0, 206,   0, "Thieves Hood"},
{  0,   0,   0,  55, "Thieves Sting"}, // actually Thieve's Sting
{  0,   0,   0,  40, "Think Helm"},
{125,   0,   0,   0, "Thor Fgn"},
{  0, 107, 107,   0, "Thor's Hammer"},
{  0,   0, 191,   0, "Thunder Sword"},
{  0,   0, 216,   0, "Titan Bracers"},
{ 83,   0,   0,   0, "Titan Fgn"},
{  0,   0, 128,   0, "Titan Helm"},
{  0,   0, 126,   0, "Titan Plate"},
{  0,   0, 127,   0, "Titan Shield"},
{  0,   0, 241,   0, "Titan Suit"},
{  1,   1,   1,   1, "Torch"},
{  0, 112,   0,   0, "Torch!"},
{ 11,  11,  11,   0, "Tower Shield"},
{115,   0,   0,   0, "Travelhelm"},
{  0,  97,  97,   0, "Trick Brick"},
{110, 100, 100,   0, "Troll Ring"},
{111,   0,   0,   0, "Troll Staff"},
{  0,   0, 212,   0, "Troth Lance"},
{  0, 117,   0,   0, "Troy P."},
{ 97,   0,   0,   0, "Truthdrum"},
{  0,   0, 120,   0, "Tslotha's Head"},
{  0,   0, 121,   0, "Tslotha's Heart"},
{  0,   0, 197,   0, "Tung Plate"},
{  0,   0, 196,   0, "Tung Shield"},
{  0,   0,   0,  19, "VaccSuit"},
{  0,   0, 123,   0, "Valarian's Bow"},
{  0,  77,  77,   0, "Van Fgn"},
{  0, 114,   0,   0, "Vial"},
{  0,   0,   0,  17, "Violet Cult pass"},
{  0,   0,   0,  24, "Vorpal Rapier"},
{  0,   0,   0,  30, "Vrvix's Rat Hormonica"},
{  0,   0,   0,  28, "Wand of Fizzbinn"},
{  0,   0, 221,   0, "Wand of Force"},
{  0,   0, 133,   0, "Wand of Fury"},
{  0,   0, 116,   0, "Wand of Power"},
{  6,   6,   6,  47, "War Axe"},
{ 91,  85,  85,   0, "Wargloves"},
{ 69,  64,  64,   0, "War Staff"},
{  0,   0, 160,   0, "Werra's Shield"},
{  0,   0,   0,  29, "Whalo's Brain Bucket"},
{  0,   0, 145,   0, "White Rose"},
{  0,   0, 118,   0, "Wineskin"},
{  0,   0, 130,   0, "Willow Flute"},
{ 72,   0,   0,   0, "Wither Staff"},
{  0,  86,  86,   0, "Wizhelm"},
{121,   0,   0,   0, "Wizwand"},
{102,   0,   0,   0, "Ybarrashield"},
{  0,   0, 148,   0, "Yellow Rose"},
{  0,   0, 140,   0, "Yellow Staff"},
{  0,   0, 223,   0, "Youth Potion"},
{  0,  92,  92,   0, "Zen Arrows"}
};

MODULE struct
{   TEXT level[1 + 1],
         points[3 + 1];
} spellstring[SPELLS];

MODULE struct
{   const STRPTR shortname,
                 longname;
    const UBYTE  level,
                 theclass,
                 thebyte,
                 thebit,
                 points;
    const STRPTR range,
                 duration,
                 desc;
} spells[SPELLS] = {
{"ANDE", "Animate Dead",                    4, CLASSGAD_WIZARD,       92, 128,  14, "Character"     , "Combat"    ,
  "Reanimates a dead character with living strength" \
"\nso he attacks enemies as if truly alive."},
{"ANMA", "Anti-Magic",                      5, CLASSGAD_MAGICIAN,     87,   2,   8, "Party"         , "Combat"    ,
  "Causes the ground to absorb a portion of the spells cast at the party by" \
"\nmonsters, giving the party a chance to escape unharmed. This spell also aids" \
"\nin disbelieving illusions and shielding against magical fires such as DRBR."},
{"APAR", "Apport Arcane",                   7, CLASSGAD_CONJURER,     86, 128,  15, "Party"         , "Instant"   ,
  "Teleports the party within a dungeon to any location" \
"\nthat's not protected by a teleportation shield."},
{"ENIK", "Arboria -> Realm",                1, CLASSGAD_CHRONOMANCER, 94,  64,  10, "Party"         , "Instant"   , ""},
{"AREN", "Area Enchant",                    2, CLASSGAD_MAGICIAN,     87, 128,   5, "30'"           , "Short"     ,
  "Causes the dungeon walls within 30' (3 squares) of a stairway" \
"\nto call out if the party is headed towards the stairs."},
{"ARFI", "Arc Fire",                        1, CLASSGAD_CONJURER,     84,  64,   3, "1 Foe/10'"     , "Instant"   ,
  "Fiery blue flames spray from the spellcaster's fingers, inflicting" \
"\n1-4 damage points, depending on the conjurer's level."},
{"BASP", "Batch Spell",                     2, CLASSGAD_ARCHMAGE,     93,  64,  28, "Party"         , "Various"   ,
  "Executes the following batch of spells:" \
"\nGRRE, YMCA, SOSI, MALE and MACO."},
{"SPBI", "Baylor's Spell Bind",             5, CLASSGAD_WIZARD,       92,  64,  16, "1 Foe"         , "Instant"   ,
  "If successful, this spell possesses the mind of an" \
"\nenemy and forces him to join and fight for your party."},
{"BEDE", "Beyond Death",                    6, CLASSGAD_WIZARD,       92,   8,  18, "Character"     , "Instant"   ,
  "Brings a dead character back to" \
"\nlife and gives him 1 hit point."},
{"BRKR", "Brothers Kringle, The",           6, CLASSGAD_ARCHMAGE,     93,   4,  60, "Party"         , "Instant"   ,
  "The brothers are always ready to help friends in trouble." \
"\nEnough brothers appear to fill the empty slots in your party."},
{"CAMR", "Camaraderie",                     3, CLASSGAD_ARCHMAGE,     93,  32,  26, "Party"         , "Instant"   ,
  "Has a 50% chance of calming all monsters" \
"\nin your party that have turned hostile."},
{"CAEY", "Cat Eyes",                        4, CLASSGAD_SORCERER,     89,   1,   7, "Party"         , "Indefinite",
  "Endows the entire party with perfect night" \
"\nvision for an indefinite period of time."},
{"DEST", "Death Strike",                    7, CLASSGAD_MAGICIAN,     88,  16,  16, "1 Foe/10'"     , "Instant"   , "Instantly kills a selected enemy."},
{"DEBA", "Demon Bane",                      2, CLASSGAD_WIZARD,       91,   8,  11, "1 Foe/30'"     , "Instant"   ,
  "Inflicts 100-400 points of damage on a single" \
"\ncreature of evil or supernatural origin."},
{"DMST", "Demon Strike",                    7, CLASSGAD_WIZARD,       92,   2,  25, "Group/50'"     , "Instant"   ,
  "Unleashes the terrorizing power of demons into the" \
"\nenemy ranks, causing 200-400 points of damage."},
{"DISB", "Disbelieve",                      2, CLASSGAD_SORCERER,     89,  64,   4, "Party"         , "Instant"   ,
  "Reveals an attacking illusion for the true" \
"\nnonphysical object that it is, causing it to vanish."},
{"DISP", "Dispossess",                      3, CLASSGAD_WIZARD,       91,   2,  12, "Character"     , "Instant"   ,
  "Returns a possessed party member to" \
"\nthe normal state of consciousness."},
{"DIIL", "Disrupt Illusion",                5, CLASSGAD_SORCERER,     90,  64,   8, "All Foes"      , "Combat"    ,
  "Destroys any illusions among the ranks of the" \
"\nenemy and prevents new illusions from appearing."},
{"DIVA", "Divine Intervention",             0, CLASSGAD_WARRIOR,      99,  16, 250, "All Foes/Party", "Various"   ,
  "1) Turns illusionary chars into real chars; 2) Cures" \
"\nchars of all illnesses but age; 3) Restores all hit points" \
"\nto the party. If you're in combat, it also: 4) Lowers" \
"\nyour AC, saving throw, to hit and damage by 20 points;" \
"\n5) Increases your attack by 8 points; 6) Casts MAMA."},
{"DRBR", "Dragon Breath",                   4, CLASSGAD_MAGICIAN,     87,   4,   7, "Group/30'"     , "Instant"   ,
  "Lets the spellcaster belch a breath of fire at a group of" \
"\nmonsters, inflicting 8-64 points of damage on each monster."},
{"EADA", "Earth Dagger",                    1, CLASSGAD_GEOMANCER,    97,  32,   5, "Group/40'"     , "Instant"   ,
  "Cuts down the enemy with holy daggers" \
"\nfor 200-800 points of damage."},
{"EAEL", "Earth Elemental",                 2, CLASSGAD_GEOMANCER,    97,   2,  15, "Party"         , "Instant"   , "Summons an earth elemental."},
{"EAMA", "Earth Maw",                       7, CLASSGAD_GEOMANCER,    99,  64,  80, "Group/50'"     , "Instant"   ,
  "Commands the ground beneath the enemy's feet to open" \
"\nwide and drop the foes in, so they're never seen again."},
{"EASO", "Earth Song",                      1, CLASSGAD_GEOMANCER,    97,  16,   5, "Level"         , "Instant"   , "Reveals all booby-trapped areas that can injure the party."},
{"EAWA", "Earth Ward",                      1, CLASSGAD_GEOMANCER,    97,   8,   8, "Level"         , "Instant"   , "Casts the TRZP spell on the entire level."},
{"INSL", "Elik's Instant Slayer",           7, CLASSGAD_CONJURER,     86,  32,  12, "Party"         , "Instant"   , "Materializes a slayer who joins your party."},
{"INWO", "Elik's Instant Wolf",             4, CLASSGAD_CONJURER,     85,  64,   6, "Party"         , "Instant"   ,
  "Summons a giant and extremely" \
"\nfierce wolf to join your party."},
{"FOFO", "Fanskar's Force Focus",           1, CLASSGAD_WIZARD,       91,  32,  11, "Group/10'"     , "Instant"   ,
  "Lands a cone of gravitational energy on a group" \
"\nof your foes, inflicting 25-100 points of damage."},
{"NILA", "Fanskar's Night Lance",           4, CLASSGAD_ARCHMAGE,     93,  16,  30, "Group/60'"     , "Instant"   ,
  "Launches a chilling ice missile against a group" \
"\nof foes, inflicting 100-400 damage points."},
{"FADE", "Far Death",                       4, CLASSGAD_CHRONOMANCER, 95,  16,  50, "1 Foe/30'"     , "Instant"   ,
  "A long-range spell that drops a" \
"\ndistant foe dead in its tracks."},
{"FAFO", "Far Foe",                         7, CLASSGAD_CONJURER,     86,  64,  18, "Group"         , "Instant"   ,
  "Pushes a group of foes 40' further away from" \
"\nyour party, up to a total distance of 90'."},
{"FAFI", "Fatal Fist",                      7, CLASSGAD_CHRONOMANCER, 96,   1, 100, "All Foes"      , "Instant"   ,
  "Crushes the enemy under an unearthly gravitational" \
"\nforce for 400-1500 points of damage."},
{"FLCO", "Flame Column",                    3, CLASSGAD_WIZARD,       91,   4,  14, "Group/30'"     , "Instant"   ,
  "Creates a cyclone of flame that lashes out and delivers" \
"\n22-88 points of damage to a group of your foes."},
{"FLAN", "Flesh Anew",                      6, CLASSGAD_CONJURER,     85,   4,   9, "Party"         , "Instant"   , "Works like FLRE, but affects every member of the party."},
{"FLRE", "Flesh Restore",                   4, CLASSGAD_CONJURER,     85,  32,   6, "Char"          , "Instant"   ,
  "A powerful healing spell that restores 10-40 points to a party" \
"\nmember, curing those stricken with insanity or poisoning."},
{"FOTA", "Force of Tarjan",                 6, CLASSGAD_CHRONOMANCER, 96,  16,  70, "Group"         , "Instant"   , "Casts WIFI and SAST for a double offensive punch."},
{"FRFO", "Freeze Foes",                     2, CLASSGAD_CONJURER,     84,  16,   3, "Group"         , "Combat"    ,
  "Binds your enemies in a magical force, slowing them down" \
"\nand making them an easier target for your itching sword."},
{"COLD", "Frost Force",                     2, CLASSGAD_CHRONOMANCER, 94,  16,  20, "Group/80'"     , "Instant"   ,
  "Blasts the enemy with a deadly" \
"\nfrost for 50-400 points of damage."},
{"ECUL", "Gelidia -> Realm",                2, CLASSGAD_CHRONOMANCER, 94,   4,  15, "Party"         , "Instant"   , ""},
{"GILL", "Gilles' Gills",                   0, CLASSGAD_WARRIOR,      99,  32,  10, "Party"         , "Medium"    ,
  "This survival spell lets your party breathe underwater." \
"\nIt is cumulative in effect; casting it more than once" \
"\nwill extend the amount of time you can spend underwater."},
{"GIST", "Giant Strength",                  5, CLASSGAD_MAGICIAN,     87,   1,  10, "Party"         , "Combat"    ,
  "Instills tremendous power in your party," \
"\nincreasing their strike ability by 10."},
{"GLST", "Glacier Strike",                  5, CLASSGAD_GEOMANCER,    98,   4,  40, "1 Foe/90'"     , "Instant"   ,
  "Impales the enemy with an icy stalagmite," \
"\ncausing 400-1600 points of damage."},
{"GOFI", "God Fire",                        3, CLASSGAD_CHRONOMANCER, 94,   2,  25, "Group/80'"     , "Instant"   ,
  "A holy spell where blazing red fires are sent from the" \
"\nangry gods to roast the enemy for 60-240 damage points."},
{"NUKE", "Gotterdamurung",                  0, CLASSGAD_WARRIOR,      99,   8, 150, "All Foes"      , "Instant"   ,
  "The finest in offensive obliteration, this spell" \
"\nannihilates the opponents for 2000 damage points."},
{"GRRO", "Grave Robber",                    6, CLASSGAD_CHRONOMANCER, 96,  32,  65, "Character"     , "Instant"   ,
  "Casts BEDE and REGN for a life-" \
"\ngiving combination of spells."},
{"GRRE", "Greater Revelation",              5, CLASSGAD_CONJURER,     85,  16,   7, "View"          , "Long"      ,
  "Operates like LERE, but illuminates a" \
"\nwider area for a longer period of time."},
{"GRSU", "Greater Summoning",               6, CLASSGAD_WIZARD,       92,  16,  22, "Party"         , "Instant"   ,
  "Operates like PRSU, but causes a powerful elemental" \
"\ncreature to appear and fight for the party."},
{"HEAL", "Heal All",                        5, CLASSGAD_ARCHMAGE,     93,   8,  50, "Party"         , "Instant"   ,
  "A BEDE spell that resurrects every dead party member (except those" \
"\nturned to stone), and heals all wounds, paralysis and insanity."},
{"HOWA", "Holy Water",                      2, CLASSGAD_MAGICIAN,     86,   2,   4, "1 Foe/10'"     , "Instant"   ,
  "Holy water sprays from the spellcaster's fingers, inflicting 6-24" \
"\npoints of damage on any foe of evil or supernatural origin."},
{"ICES", "Ice Storm",                       7, CLASSGAD_MAGICIAN,     88,   8,  11, "Group/50'"     , "Instant"   ,
  "Pummels a group of monsters with chunks" \
"\nof ice, causing 20-80 points of damage."},
{"WHAT", "Identify",                        5, CLASSGAD_CHRONOMANCER, 95,   2,  60, "1 Object"      , "Instant"   ,
  "Cast this spell on something to" \
"\nfind out just what the heck it is."},
{"MACO", "Kiel's Magic Compass",            2, CLASSGAD_CONJURER,     84,   8,   3, "View"          , "Medium"    ,
  "A compass of shimmering magelight appears above" \
"\nthe party and shows the direction they face."},
{"OBRA", "Kinestia -> Realm",               4, CLASSGAD_CHRONOMANCER, 95,   4,  25, "Party"         , "Instant"   , ""},
{"INVI", "Kylearan's Invisibility Spell",   3, CLASSGAD_SORCERER,     89,   4,   6, "Party"         , "Combat"    ,
  "Invoke this spell to render the entire" \
"\nparty nearly invisible to the enemy."},
{"JOBO", "Jolt Bolt",                       7, CLASSGAD_GEOMANCER,    99, 128,  60, "All Foes"      , "Instant"   ,
  "Wrenches the earth below the enemy, smashing them" \
"\nto the ground and gives them a jolting electrical" \
"\nshock to cause 400-1600 points of damage."},
{"LEVI", "Levitation",                      3, CLASSGAD_CONJURER,     84,   1,   4, "Party"         , "Short"     ,
  "Partially nullifies gravity, letting the party" \
"\nfloat over traps, or up and down through portals."},
{"LERE", "Lesser Revelation",               3, CLASSGAD_CONJURER,     84,   2,   5, "View"          , "Long"      , "An extended MAFL spell that also reveals secret doors."},
{"LOTR", "Locate Traps",                    1, CLASSGAD_SORCERER,     89, 128,   2, "30'"           , "Short"     ,
  "Heightens the spellcaster's awareness for trap detection." \
"\nWorks for 30' in the direction that the spellcaster is facing."},
{"ILEG", "Lucencia -> Realm",               3, CLASSGAD_CHRONOMANCER, 95,  64,  20, "Party"         , "Instant"   , ""},
{"LUCK", "Luck Chant",                      4, CLASSGAD_CHRONOMANCER, 95,  32,  45, "Party"         , "Combat"    , "Increases your chances of hitting or defending by 8 points."},
{"MAFL", "Mage Flame",                      1, CLASSGAD_CONJURER,     84, 128,   2, "View"          , "Medium"    ,
  "A small flame floats above the spellcaster as he" \
"\nmoves about, illuminating the immediate area."},
{"MAGA", "Mage Gauntlets",                  2, CLASSGAD_MAGICIAN,     86,   1,   5, "Character"     , "Combat"    ,
  "Makes the hands (or weapon) of a party member more deadly by" \
"\nadding 4-16 points of damage to every wound it inflicts on a foe."},
{"MAGM", "Mage Maelstrom",                  7, CLASSGAD_SORCERER,     90,   1,  40, "Group"         , "Instant"   ,
  "Assaults a group of opposing spellcasters and" \
"\nmay do one of: 1) Inflict 60-240 points of damage;" \
"\n2) Turn them to stone; or 3) Kill them outright." \
"\nHowever, because the maelstrom is illusionary," \
"\na disbelieving enemy can totally nullify it."},
{"MABA", "Magma Blast",                     6, CLASSGAD_GEOMANCER,    98,   1,  50, "Group/50'"     , "Instant"   ,
  "Burns a group of foes with a blast of hot," \
"\nfiery magma for 300-1200 points of damage."},
{"LIVE", "Malefia -> Realm",                7, CLASSGAD_CHRONOMANCER, 97,  64,  50, "Party"         , "Instant"   , ""},
{"MALE", "Major Levitation",                6, CLASSGAD_CONJURER,     85,   2,   8, "Party"         , "Indefinite",
  "Operates like LEVI, but it lasts until the spell is" \
"\nterminated by some event like the activation of an anti-magic square."},
{"MAMA", "Mangar's Mallet",                 7, CLASSGAD_ARCHMAGE,     93,   2,  80, "All Foes/90'"  , "Instant"   ,
  "Inflicts 200-800 bone-crushing damage points" \
"\nagainst every monster group you face."},
{"MIBL", "Mangar's Mind Blade",             5, CLASSGAD_SORCERER,     90,  32,  10, "All Foes/30'/+", "Instant"   ,
  "An electric spell that strikes every opposing" \
"\ngroup within range with an explosion of energy" \
"\ncapable of inflicting 25-100 points of damage."},
{"MIJA", "Mangar's Mind Jab",               1, CLASSGAD_SORCERER,     88,   2,   3, "1 Foe/40'/+"   , "Instant"   ,
  "Casts a concentrated blast of electrical energy" \
"\nat one opponent, inflicting 2-8 points of damage" \
"\nfor each experience level of the spellcaster."},
{"MEME", "Melee Men",                       1, CLASSGAD_ARCHMAGE,     93, 128,  20, "Group"         , "Instant"   ,
  "Pulls an attacking group into melee range (10')" \
"\nregardless of how far they were when they began attacking."},
{"HAFO", "Oscon's Haltfoe",                 1, CLASSGAD_ARCHMAGE,     92,   1,  15, "All Foes"      , "1 Round"   ,
  "If successful, this spell causes every attacking group" \
"\nto miss all their attacks during the next round."},
{"OGST", "Oscon's Ogre Strength",           3, CLASSGAD_MAGICIAN,     87,  32,   6, "Character"     , "Combat"    ,
  "Endows a specific party member with the strength" \
"\nof INOG for the duration of the battle."},
{"PATH", "Pathfinder",                      6, CLASSGAD_GEOMANCER,    98,   2,  40, "Level"         , "Instant"   ,
  "An instant map, this shows the" \
"\nentire maze that the party's in."},
{"ROCK", "Petrify",                         3, CLASSGAD_GEOMANCER,    98, 128,  18, "1 Foe/60'"     , "Instant"   , "Turns an enemy up to 60' away into the hardest stone."},
{"PHBL", "Phase Blur",                      1, CLASSGAD_SORCERER,     88,   1,   2, "Party"         , "Combat"    ,
  "Causes the entire party to become blurry in the eyes" \
"\nof the enemy, making your party tougher to strike."},
{"PHDO", "Phase Door",                      6, CLASSGAD_MAGICIAN,     88, 128,  10, "Wall"          , "1 Move"    ,
  "Vaporizes any wall that's not protected" \
"\nby an anti-PHDO aura or spell into air."},
{"PREC", "Preclusion",                      7, CLASSGAD_SORCERER,     91, 128,  50, "All Foes"      , "Combat"    , "Keeps the enemy from being able to summon any creatures."},
{"PRSU", "Prime Summoning",                 2, CLASSGAD_WIZARD,       91,  16,  14, "Party"         , "Instant"   ,
  "Coerces a powerful undead creature" \
"\nto unwillingly join your party."},
{"QUFI", "Quick Fix",                       1, CLASSGAD_MAGICIAN,     86,   8,   3, "Character"     , "Instant"   ,
  "Regenerates 8 hit points for a character, up" \
"\nto the character's maximum hit point level."},
{"ARBO", "Realm -> Arboria",                1, CLASSGAD_CHRONOMANCER, 94, 128,  10, "Party"         , "Instant"   , ""},
{"GELI", "Realm -> Gelidia",                2, CLASSGAD_CHRONOMANCER, 94,   8,  15, "Party"         , "Instant"   , ""},
{"KINE", "Realm -> Kinestia",               4, CLASSGAD_CHRONOMANCER, 95,   8,  25, "Party"         , "Instant"   , ""},
{"LUCE", "Realm -> Lucencia",               3, CLASSGAD_CHRONOMANCER, 95, 128,  20, "Party"         , "Instant"   , ""},
{"EVIL", "Realm -> Malefia",                7, CLASSGAD_CHRONOMANCER, 97, 128,  50, "Party"         , "Instant"   , ""},
{"AECE", "Realm -> Tarmitia",               6, CLASSGAD_CHRONOMANCER, 96,   8,  35, "Party"         , "Instant"   , ""},
{"OLUK", "Realm -> Tenebrosia",             5, CLASSGAD_CHRONOMANCER, 96, 128,  30, "Party"         , "Instant"   , ""},
{"REGN", "Regeneration",                    7, CLASSGAD_CONJURER,     85,   1,  12, "Character"     , "Instant"   ,
  "A health spell that revives all the hit" \
"\npoints for one lucky member of the party."},
{"REST", "Restoration",                     7, CLASSGAD_MAGICIAN,     88,  32,  25, "Party"         , "Instant"   ,
  "Regenerates the body of every party member to" \
"\nperfect condition; even cures insanity or poisoning."},
{"RIME", "Rimefang",                        7, CLASSGAD_SORCERER,     90,   4,  20, "All Foes/40'"  , "Instant"   ,
  "Rakes enemies with shards of ice," \
"\ninflicting 50-200 points of damage."},
{"ROAL", "Roscoe's Alert",                  3, CLASSGAD_GEOMANCER,    98,  64,  20, "Level"         , "Instant"   , "Reveals to the party where the anti-magic areas are."},
{"SANT", "Sanctuary",                       5, CLASSGAD_GEOMANCER,    98,   8,  30, "Level"         , "Instant"   ,
  "Shows all mage regeneration squares," \
"\nso your spellcasters can be refreshed."},
{"SAST", "Sandstorm",                       4, CLASSGAD_GEOMANCER,    98,  16,  25, "Group"         , "Instant"   ,
  "With a violent swirl of sand," \
"\nall foes are whipped back 60'."},
{"SCSI", "Scry Site",                       1, CLASSGAD_MAGICIAN,     86,   4,   2, "Party"         , "Instant"   ,
  "Causes a dungeon wall or wilderness" \
"\npathway to reveal the party's location."},
{"SESI", "Second Sight",                    3, CLASSGAD_SORCERER,     89,   2,   6, "30'"           , "Medium"    ,
  "Heightens awareness so the spellcaster can" \
"\ndetect all traps that lie directly ahead."},
{"SHSH", "Shadow Shield",                   7, CLASSGAD_CHRONOMANCER, 96,   2,  60, "Party"         , "Indefinite",
  "Casts a grey shadow around the party," \
"\nand lowers their armour class by 4."},
{"SHSP", "Shock Sphere",                    5, CLASSGAD_CONJURER,     85,   8,   7, "Group/30'/+"   , "Instant"   ,
  "Creates a large globe of intense electrical energy that" \
"\nenvelops a group of enemies and inflicts 10-40 damage points."},
{"SOSI", "Sorcerer Sight",                  6, CLASSGAD_SORCERER,     90,   8,  11, "30'"           , "Indefinite",
  "Operates like the trap-detecting" \
"\nSESI spell, but lasts indefinitely."},
{"SPTO", "Spectre Touch",                   4, CLASSGAD_MAGICIAN,     87,   8,   8, "1 Foe/70'"     , "Instant"   ,
  "Drains a single enemy of 15-60 hit points" \
"\nas if it were touched lightly by death."},
{"STFL", "Star Flare",                      3, CLASSGAD_MAGICIAN,     87,  16,   6, "Group/40'/+"   , "Instant"   ,
  "An electrical spell that ignites the air around your" \
"\nenemies, scorching them for 10-40 damage points."},
{"STON", "Stone to Flesh",                  7, CLASSGAD_MAGICIAN,     88,   4,  20, "Character"     , "Instant"   ,
  "Takes a character who has been turned to stone" \
"\nand restores him to his natural flesh state."},
{"SOWH", "Storal's Soul Whip",              5, CLASSGAD_WIZARD,       92,  32,  13, "1 Foe/70'"     , "Instant"   ,
  "Whips out a tendril of psionic power to strike" \
"\na selected foe, inflicting 50-200 damage points."},
{"STUN", "Stun",                            3, CLASSGAD_CHRONOMANCER, 94,   1,  30, "All Foes"      , "Instant"   ,
  "An electric spell that gives the enemy a" \
"\nhigh-voltage zap for 50-200 damage points."},
{"SUSO", "Succor Song",                     4, CLASSGAD_GEOMANCER,    98,  32,  20, "Level"         , "Instant"   ,
  "Shows all heal-party squares, so your party" \
"\ncan put an end to their weakness and pain."},
{"SUEL", "Summon Elemental",                1, CLASSGAD_WIZARD,       91,  64,  10, "Party"         , "Instant"   ,
  "Creates a fire-being from the raw elements of" \
"\nthe universe to join and fight for your party."},
{"HERB", "Summon Herb",                     4, CLASSGAD_WIZARD,       91,   1,  13, "Party"         , "Instant"   , "Summons Herb to join your party."},
{"KULO", "Tarmitia -> Realm",               6, CLASSGAD_CHRONOMANCER, 96,   4,  35, "Party"         , "Instant"   , ""},
{"ECEA", "Tenebrosia -> Realm",             5, CLASSGAD_CHRONOMANCER, 96,  64,  30, "Party"         , "Instant"   , ""},
{"TREB", "Trebuchet",                       2, CLASSGAD_GEOMANCER,    97,   4,  10, "All Foes"      , "Instant"   , "Fries all foes with wickedly hot flames for 150-600 points."},
{"TRZP", "Trap Zap",                        1, CLASSGAD_CONJURER,     84,  32,   2, "30'"           , "Instant"   ,
  "Disarms any trap or chest within 30' in the" \
"\ndirection that the spellcaster is facing."},
{"VITL", "Vitality",                        1, CLASSGAD_CHRONOMANCER, 93,   1,  12, "Character"     , "Instant"   ,
  "Invigorates a character by healing 4-8" \
"\nhit points times the spellcaster's level."},
{"VOPL", "Vorpal Plating",                  1, CLASSGAD_MAGICIAN,     86,  16,   3, "Character"     , "Combat"    ,
"  Causes the weapon (or hands) of a party member to emit a" \
"\nmagical field that inflicts 2-8 points of additional damage."},
{"WIZW", "Wacum's Wizard War",              7, CLASSGAD_WIZARD,       92,   4,  16, "Group/50'"     , "Instant"   ,
  "An electric spell that creates a pyrotechnical storm over" \
"\na group of monsters, inflicting 50-200 damage points."},
{"WAWA", "Wall Warp",                       2, CLASSGAD_GEOMANCER,    97,   1,  15, "Wall"          , "Special"   , "Works like PHDO until the party leaves."},
{"WAST", "Warstrike",                       3, CLASSGAD_CONJURER,     85, 128,   5, "Group/20'"     , "Instant"   ,
  "An electric spell where a stream of energy shoots from the" \
"\nspellcaster's finger, frying a group of foes for 5-20 damage points."},
{"WIDR", "Wind Dragon",                     4, CLASSGAD_SORCERER,     90, 128,  12, "Party"         , "Instant"   ,
  "Creates an illusionary red dragon" \
"\nto join the ranks of your party."},
{"WIGI", "Wind Giant",                      6, CLASSGAD_SORCERER,     90,  16,  11, "Party"         , "Instant"   ,
  "Creates an illusionary elemental giant that" \
"\njoins your party and fights up a storm."},
{"WIHE", "Wind Hero",                       7, CLASSGAD_SORCERER,     90,   2,  16, "Party"         , "Instant"   ,
  "Creates an illusionary hero with the power" \
"\nof hurricane winds to join your party."},
{"WIOG", "Wind Ogre",                       3, CLASSGAD_SORCERER,     89,   8,   6, "Party"         , "Instant"   ,
  "Like INOG, it summons a mean," \
"\nillusionary ogre to join your party."},
{"WIWA", "Wind Warrior",                    2, CLASSGAD_SORCERER,     89,  32,   5, "Party"         , "Instant"   ,
  "Creates the illusion of a battle-ready ninja in the ranks of your" \
"\nparty. The illusionary ninja will fight until defeated or disbelieved."},
{"WIFI", "Witherfist",                      2, CLASSGAD_CHRONOMANCER, 94,  32,  20, "Group/20'"     , "Instant"   ,
  "Crushes a group of enemies under a huge fist" \
"\nof power for 300-600 points of damage."},
{"FEAR", "Word of Fear",                    2, CLASSGAD_SORCERER,     89,  16,   4, "Group"         , "Combat"    ,
  "An incantation that causes a group of enemies to quake in fear," \
"\nthus reducing their ability to attack and inflict damage."},
{"WOHL", "Word of Healing",                 2, CLASSGAD_CONJURER,     84,   4,   4, "Character"     , "Instant"   ,
  "With the uttering of a single word, this heals" \
"\na party member from 4-16 points of damage."},
{"YMCA", "Ybarra's Mystical Coat of Armor", 6, CLASSGAD_MAGICIAN,     88,  64,  10, "Party"         , "Indefinite", "Works just like MYSH, but lasts indefinitely."},
{"MYSH", "Ybarra's Mystic Shield",          3, CLASSGAD_MAGICIAN,     87,  64,   6, "Party"         , "Medium"    ,
  "Causes the air in front of the party to form an invisible shield" \
"\nthat's as hard as metal. The shield moves with the party."},
{"OLAY", "Youth",                           5, CLASSGAD_CHRONOMANCER, 95,   1,  60, "Character"     , "Instant"   ,
  "Coats a character with a light," \
"\nfragrant lotion to cure oldness."},
}; 

MODULE struct ColumnInfo ClassesColumnInfo[] =
{ { 0,                            // WORD   ci_Width
    "",                           // STRPTR ci_Title
    CIF_FIXED | CIF_NOSEPARATORS  // ULONG  ci_Flags
  },
  { 100,
    "",
    0 /* Last column must not have CIF_DRAGGABLE set (CIF_DRAGGABLE
         applies to the right border of the relevant column). */
  },
  { -1, (STRPTR) ~0, -1
} }, SpellsColumnInfo[] =
{ { 0,                            // WORD   ci_Width
    "",                           // STRPTR ci_Title
    0,                            // ULONG  ci_Flags
  },
  { 0,                            // WORD   ci_Width
    "Lv",                         // STRPTR ci_Title
    CIF_RIGHT,                    // ULONG  ci_Flags
  },
  { 0,                            // WORD   ci_Width
    "Cl",                         // STRPTR ci_Title
    0,                            // ULONG  ci_Flags
  },
  { 0,                            // WORD   ci_Width
    "Pts",                        // STRPTR ci_Title
    CIF_RIGHT,                    // ULONG  ci_Flags
  },
  { 0,                            // WORD   ci_Width (ignored due to LISTBROWSER_AutoFit)
    "Code",                       // STRPTR ci_Title
    0,                            // ULONG  ci_Flags
  },
  { 0,
    "Name",
    0 /* Last column must not have CIF_DRAGGABLE set (CIF_DRAGGABLE
         applies to the right border of the relevant column). */
  },
  { -1, (STRPTR) ~0, -1
} };

MODULE struct HintInfo bard_hintinfo[4 + SPELLS] = {
{ GID_BT_SB1,  1, "Open (Amiga-O)", 0}, // open
{ GID_BT_SB1,  2, "Save (Amiga-S)", 0}, // save
};

/* 8. CODE --------------------------------------------------------------- */

EXPORT void bt_main(void)
{   TRANSIENT int          i;
    TRANSIENT struct Node* NodePtr;
    PERSIST   FLAG         first = TRUE;

    if (first)
    {   first = FALSE;

        // bard_preinit()
        NewList(&ClassesList);
        NewList(&FacingList1);
        NewList(&FacingList2);
        NewList(&ItemsList);
        NewList(&SpellsList);

        // bard_init()
        lb_makelist(&ClassesList, ClassOptions, 15);
        for (i = 0; i <= ITEMS; i++)
        {   NodePtr = (struct Node*) AllocListBrowserNode
            (   1,
                LBNCA_Text,              items[i].name,
            TAG_END);
            // we should check NodePtr is non-zero
            AddTail(&ItemsList, (struct Node*) NodePtr);
        }
        for (i = 0; i < SPELLS; i++)
        {   sprintf(spellstring[i].level,  "%d", spells[i].level);
            sprintf(spellstring[i].points, "%d", spells[i].points);
            NodePtr = (struct Node*) AllocListBrowserNode
            (   6, // columns
                LBNA_CheckBox,           TRUE,
                LBNA_Column,             0,
                    LBNCA_Text,          "",
                LBNA_Column,             1,
                    LBNCA_Justification, LCJ_RIGHT,
                    LBNCA_Text,          spellstring[i].level,
                LBNA_Column,             2,
                    LBNCA_Text,          ClassAbbrevs[spells[i].theclass],
                LBNA_Column,             3,
                    LBNCA_Justification, LCJ_RIGHT,
                    LBNCA_Text,          spellstring[i].points,
                LBNA_Column,             4,
                    LBNCA_Text,          spells[i].shortname,
                LBNA_Column,             5,
                    LBNCA_Text,          spells[i].longname,
            TAG_END);
            // we should check NodePtr is non-zero
            AddTail(&SpellsList, (struct Node*) NodePtr);
    }   }

    tool_open      = bt_open;
    tool_loop      = bt_loop;
    tool_save      = bt_save;
    tool_close     = bt_close;
    tool_exit      = bt_exit;
    tool_subgadget = bt_subgadget;

    if (loaded != FUNC_BT && !bt_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_BT;

    scalex = scaley = 12;
    n1     = 4;
    n2     = 9;

    if
    (   (    ListBrowserBase->lib_Version >  48
         || (ListBrowserBase->lib_Version == 48 && ListBrowserBase->lib_Revision >= 2)
        )
     &&      ListBrowserBase->lib_Version <  50
    )
    {   lbtips = TRUE;
        bard_hintinfo[2 + SPELLS].hi_Text = "Hover over a spell for more information.";
    } else
    {   lbtips = FALSE;
        bard_hintinfo[2 + SPELLS].hi_Text = "Click & hover on a spell for more info.";
    }
    bard_hintinfo[2 + SPELLS].hi_GadgetID = GID_BT_LB2;
    bard_hintinfo[2 + SPELLS].hi_Code     = -1;
    bard_hintinfo[2 + SPELLS].hi_Flags    = 0;

    for (i = 0; i < SPELLS; i++)
    {   if (spells[i].desc[0] == EOS)
        {   sprintf
            (   hintstring[i],
                "%s (%s)\nSpell Points: %d\nRange: %s\nDuration: %s",
                spells[i].longname,
                spells[i].shortname,
                spells[i].points,
                spells[i].range,
                spells[i].duration
            );
        } else
        {   sprintf
            (   hintstring[i],
                "%s (%s)\nSpell Points: %d\nRange: %s\nDuration: %s\n\n%s",
                spells[i].longname,
                spells[i].shortname,
                spells[i].points,
                spells[i].range,
                spells[i].duration,
                spells[i].desc
            );
        }
        bard_hintinfo[2 + i].hi_GadgetID  = GID_BT_LB2;
        bard_hintinfo[2 + i].hi_Code      = i;
        bard_hintinfo[2 + i].hi_Text      = hintstring[i];
        bard_hintinfo[2 + i].hi_Flags     = 0;
    }
    bard_hintinfo[3 + SPELLS].hi_GadgetID = -1;
    bard_hintinfo[3 + SPELLS].hi_Code     = -1,
    bard_hintinfo[3 + SPELLS].hi_Text     = NULL;
    bard_hintinfo[3 + SPELLS].hi_Flags    = 0;

    bt_getpens();
    load_images(240, 254);
    ClassesColumnInfo[0].ci_Width = image[240]->Width + 6;
    make_classes();
    make_speedbar_list(GID_BT_SB1);
    HintInfoPtr = (struct HintInfo*) &bard_hintinfo;
    load_aiss_images( 6, 10);
    ch_load_aiss_images(11, 14, FacingOptions, &FacingList1);
    ch_load_aiss_images(11, 14, FacingOptions, &FacingList2);
    load_aiss_images(16, 16);
    makesexlist();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                         TRUE,
        WA_ThinSizeGadget,                                     TRUE,
        WINDOW_Position,                                       SPECIALWPOS,
        WINDOW_ParentGroup,                                    gadgets[GID_BT_LY1] = (struct Gadget*)
        VLayoutObject,
            GA_ID,                                             GID_BT_LY1,
            LAYOUT_SpaceOuter,                                 TRUE,
            LAYOUT_SpaceInner,                                 TRUE,
            LAYOUT_DeferLayout,                                TRUE,
            AddHLayout,
                AddToolbar(GID_BT_SB1),
                AddSpace,
                CHILD_WeightedWidth,                           50,
                AddVLayout,
                    LAYOUT_VertAlignment,                      LALIGN_CENTER,
                    LAYOUT_AddChild,                           gadgets[GID_BT_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_BT_CH1,
                        GA_Disabled,                           TRUE,
                        CHOOSER_LabelArray,                    &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    LAYOUT_AddChild,                           gadgets[GID_BT_CH6] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_BT_CH6,
                        GA_Disabled,                           TRUE,
                        CHOOSER_LabelArray,                    &FiletypeOptions,
                    ChooserEnd,
                    Label("File type:"),
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
                AddSpace,
                CHILD_WeightedWidth,                           50,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddLabel(""),
            CHILD_WeightedHeight,                              0,
            AddVLayout,
                LAYOUT_BevelStyle,                             BVS_GROUP,
                LAYOUT_Label,                                  "Roster & Saved Game",
                AddHLayout,
                    LAYOUT_VertAlignment,                      LALIGN_CENTER,
                    AddLabel("Character #:"),
                    LAYOUT_AddChild,                           gadgets[GID_BT_IN41] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_BT_IN41,
                        GA_RelVerify,                          TRUE,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       1,
                        INTEGER_Maximum,                       men,
                        INTEGER_Number,                        who + 1,
                        INTEGER_MinVisible,                    2 + 1,
                    IntegerEnd,
                    AddLabel("of"),
                    LAYOUT_AddChild,                           gadgets[GID_BT_IN42] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_BT_IN42,
                        GA_ReadOnly,                           TRUE,
                        INTEGER_Arrows,                        FALSE,
                        INTEGER_Number,                        men,
                        INTEGER_MinVisible,                    1,
                    IntegerEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                          0,
                AddVLayout,
                    LAYOUT_BevelStyle,                         BVS_GROUP,
                    LAYOUT_SpaceOuter,                         TRUE,
                    LAYOUT_Label,                              "Character",
                    AddHLayout,
                        AddVLayout,
                            AddVLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_BT_ST1] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                     GID_BT_ST1,
                                    GA_TabCycle,               TRUE,
                                    STRINGA_MaxChars,          13 + 1,
                                    STRINGA_TextVal,           man[who].name,
                                StringEnd,
                                Label("Name:"),
                                CHILD_WeightedHeight,          0,
                                LAYOUT_AddChild,               gadgets[GID_BT_IN1] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BT_IN1,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           ONE_BILLION,
                                    INTEGER_MinVisible,        10 + 1,
                                IntegerEnd,
                                Label("Gold Pieces:"),
                                CHILD_WeightedHeight,          0,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN2] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN2,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       32767,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN3] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN3,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       32767,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Hit Points:"),
                                CHILD_WeightedHeight,          0,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN4] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN4,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       32767,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN5] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN5,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       32767,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Spell Points:"),
                                CHILD_WeightedHeight,          0,
                                LAYOUT_AddChild,               gadgets[GID_BT_CH5] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                     GID_BT_CH5,
                                    CHOOSER_LabelArray,        &StatusOptions,
                                ChooserEnd,
                                Label("Condition:"),
                                CHILD_WeightedHeight,          0,
                                LAYOUT_AddChild,               gadgets[GID_BT_IN21] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BT_IN21,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           -128,
                                    INTEGER_Maximum,           127,
                                IntegerEnd,
                                Label("Base Armour:"),
                                CHILD_WeightedHeight,          0,
                                LAYOUT_AddChild,               gadgets[GID_BT_IN22] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BT_IN22,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           256,
                                IntegerEnd,
                                Label("Attacks:"),
                                CHILD_WeightedHeight,          0,
                                LAYOUT_AddChild,               gadgets[GID_BT_IN24] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BT_IN24,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                IntegerEnd,
                                Label("Image:"),
                                CHILD_WeightedHeight,          0,
                            LayoutEnd,
                            CHILD_WeightedHeight,              0,
                            AddVLayout,
                                LAYOUT_BevelStyle,             BVS_GROUP,
                                LAYOUT_Label,                  "Class",
                                LAYOUT_AddChild,               gadgets[GID_BT_LB3] = (struct Gadget*)
                                ListBrowserObject,
                                    GA_ID,                     GID_BT_LB3,
                                    GA_RelVerify,              TRUE,
                                    LISTBROWSER_ColumnInfo,    (ULONG) &ClassesColumnInfo,
                                    LISTBROWSER_Labels,        (ULONG) &ClassesList,
                                    LISTBROWSER_ColumnTitles,  FALSE,
                                    LISTBROWSER_MinVisible,    1,
                                    LISTBROWSER_ShowSelected,  TRUE,
                                    LISTBROWSER_AutoWheel,     FALSE,
                                ListBrowserEnd,
                            LayoutEnd,
                            CHILD_WeightedHeight,              100,
                            AddVLayout,
                                LAYOUT_BevelStyle,             BVS_GROUP,
                                LAYOUT_SpaceOuter,             TRUE,
                                LAYOUT_SpaceInner,             TRUE,
                                LAYOUT_Label,                  "Players",
                                LAYOUT_AddChild,               gadgets[GID_BT_CH4] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                     GID_BT_CH4,
                                    CHOOSER_LabelArray,        &RaceOptions,
                                ChooserEnd,
                                Label("Race:"),
                                CHILD_WeightedHeight,          0,
                                LAYOUT_AddChild,               gadgets[GID_BT_CH2] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                     GID_BT_CH2,
                                    CHOOSER_Labels,            &SexList,
                                ChooserEnd,
                                Label("Sex:"),
                                CHILD_WeightedHeight,          0,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN25] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN25,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       255,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN26] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN26,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       255,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                Label("Level:"),
                                CHILD_WeightedHeight,          0,
                                LAYOUT_AddChild,               gadgets[GID_BT_IN27] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BT_IN27,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                Label("Songs:"),
                                CHILD_WeightedHeight,          0,
                                LAYOUT_AddChild,               gadgets[GID_BT_IN28] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BT_IN28,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           ONE_BILLION,
                                    INTEGER_MinVisible,        10 + 1,
                                IntegerEnd,
                                Label("Experience Points:"),
                                CHILD_WeightedHeight,          0,
                            LayoutEnd,
                            CHILD_WeightedHeight,              0,
                            AddVLayout,
                                LAYOUT_BevelStyle,             BVS_GROUP,
                                LAYOUT_SpaceOuter,             TRUE,
                                LAYOUT_SpaceInner,             TRUE,
                                LAYOUT_Label,                  "Illusions/Monsters",
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN23] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN23,
                                        GA_TabCycle,           TRUE,
                                        GA_RelVerify,          TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       255,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                    CHILD_WeightedHeight,      0,
                                    AddLabel("to"),
                                    CHILD_WeightedWidth,       0,
                                    LAYOUT_AddChild,           gadgets[GID_BT_BU1] = (struct Gadget*)
                                    ZButtonObject,
                                        GA_ID,                 GID_BT_BU1,
                                        GA_ReadOnly,           TRUE,
                                        BUTTON_BevelStyle,     BVS_FIELD,
                                        BUTTON_Integer,        0,
                                        BUTTON_Justification,  BCJ_RIGHT,
                                    ButtonEnd,
                                    CHILD_WeightedHeight,      0,
                                LayoutEnd,
                                Label("Damage range:"),
                                LAYOUT_AddChild,               gadgets[GID_BT_CH3] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                     GID_BT_CH3,
                                    CHOOSER_LabelArray,        &SpecialOptions,
                                ChooserEnd,
                                Label("Special:"),
                            LayoutEnd,
                            CHILD_WeightedHeight,              0,
                        LayoutEnd,
                        CHILD_WeightedWidth,                   0,
                        AddVLayout,
                            AddHLayout,
                                AddHLayout,
                                    LAYOUT_BevelStyle,         BVS_GROUP,
                                    LAYOUT_SpaceOuter,         TRUE,
                                    LAYOUT_SpaceInner,         TRUE,
                                    LAYOUT_Label,              "Attributes",
                                    AddVLayout,
                                        LAYOUT_EvenSize,       TRUE,
                                        LAYOUT_AddChild,       gadgets[GID_BT_IN6] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,             GID_BT_IN6,
                                            GA_TabCycle,       TRUE,
                                            INTEGER_Minimum,   0,
                                            INTEGER_Maximum,   255,
                                            INTEGER_MinVisible,3 + 1,
                                        IntegerEnd,
                                        Label("ST:"),
                                        LAYOUT_AddChild,       gadgets[GID_BT_IN7] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,             GID_BT_IN7,
                                            GA_TabCycle,       TRUE,
                                            INTEGER_Minimum,   0,
                                            INTEGER_Maximum,   255,
                                            INTEGER_MinVisible,3 + 1,
                                        IntegerEnd,
                                        Label("IQ:"),
                                        LAYOUT_AddChild,       gadgets[GID_BT_IN8] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,             GID_BT_IN8,
                                            GA_TabCycle,       TRUE,
                                            INTEGER_Minimum,   0,
                                            INTEGER_Maximum,   255,
                                            INTEGER_MinVisible,3 + 1,
                                        IntegerEnd,
                                        Label("DX:"),
                                        LAYOUT_AddChild,       gadgets[GID_BT_IN9] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,             GID_BT_IN9,
                                            GA_TabCycle,       TRUE,
                                            INTEGER_Minimum,   0,
                                            INTEGER_Maximum,   255,
                                            INTEGER_MinVisible,3 + 1,
                                        IntegerEnd,
                                        Label("CN:"),
                                        LAYOUT_AddChild,       gadgets[GID_BT_IN10] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,             GID_BT_IN10,
                                            GA_TabCycle,       TRUE,
                                            INTEGER_Minimum,   0,
                                            INTEGER_Maximum,   255,
                                            INTEGER_MinVisible,3 + 1,
                                        IntegerEnd,
                                        Label("LK:"),
                                    LayoutEnd,
                                    AddVLayout,
                                        LAYOUT_EvenSize,       TRUE,
                                        LAYOUT_AddChild,       gadgets[GID_BT_IN11] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,             GID_BT_IN11,
                                            GA_TabCycle,       TRUE,
                                            INTEGER_Minimum,   0,
                                            INTEGER_Maximum,   255,
                                            INTEGER_MinVisible,3 + 1,
                                        IntegerEnd,
                                        Label("of"),
                                        LAYOUT_AddChild,       gadgets[GID_BT_IN12] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,             GID_BT_IN12,
                                            GA_TabCycle,       TRUE,
                                            INTEGER_Minimum,   0,
                                            INTEGER_Maximum,   255,
                                            INTEGER_MinVisible,3 + 1,
                                        IntegerEnd,
                                        Label("of"),
                                        LAYOUT_AddChild,       gadgets[GID_BT_IN13] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,             GID_BT_IN13,
                                            GA_TabCycle,       TRUE,
                                            INTEGER_Minimum,   0,
                                            INTEGER_Maximum,   255,
                                            INTEGER_MinVisible,3 + 1,
                                        IntegerEnd,
                                        Label("of"),
                                        LAYOUT_AddChild,       gadgets[GID_BT_IN14] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,             GID_BT_IN14,
                                            GA_TabCycle,       TRUE,
                                            INTEGER_Minimum,   0,
                                            INTEGER_Maximum,   255,
                                            INTEGER_MinVisible,3 + 1,
                                        IntegerEnd,
                                        Label("of"),
                                        LAYOUT_AddChild,       gadgets[GID_BT_IN15] = (struct Gadget*)
                                        IntegerObject,
                                            GA_ID,             GID_BT_IN15,
                                            GA_TabCycle,       TRUE,
                                            INTEGER_Minimum,   0,
                                            INTEGER_Maximum,   255,
                                            INTEGER_MinVisible,3 + 1,
                                        IntegerEnd,
                                        Label("of"),
                                    LayoutEnd,
                                LayoutEnd,
                                AddVLayout,
                                    LAYOUT_BevelStyle,         BVS_GROUP,
                                    LAYOUT_SpaceOuter,         TRUE,
                                    LAYOUT_SpaceInner,         TRUE,
                                    LAYOUT_Label,              "Levels",
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN16] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN16,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       7,
                                        INTEGER_MinVisible,    1 + 1,
                                    IntegerEnd,
                                    Label("Magician:"),
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN17] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN17,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       7,
                                        INTEGER_MinVisible,    1 + 1,
                                    IntegerEnd,
                                    Label("Conjurer:"),
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN18] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN18,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       7,
                                        INTEGER_MinVisible,    1 + 1,
                                    IntegerEnd,
                                    Label("Sorcerer:"),
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN19] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN19,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       7,
                                        INTEGER_MinVisible,    1 + 1,
                                    IntegerEnd,
                                    Label("Wizard:"),
                                    LAYOUT_AddChild,           gadgets[GID_BT_IN20] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_BT_IN20,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       7,
                                        INTEGER_MinVisible,    1 + 1,
                                    IntegerEnd,
                                    Label("Archmage:"),
                                LayoutEnd,
                            LayoutEnd,
                            CHILD_WeightedHeight,              0,
                            AddVLayout,
                                LAYOUT_BevelStyle,             BVS_GROUP,
                                LAYOUT_SpaceOuter,             TRUE,
                                LAYOUT_Label,                  "Inventory",
                                ItemGads(0),
                                ItemGads(1),
                                ItemGads(2),
                                ItemGads(3),
                                ItemGads(4),
                                ItemGads(5),
                                ItemGads(6),
                                ItemGads(7),
                                ItemGads(8),
                                ItemGads(9),
                                ItemGads(10),
                                ItemGads(11),
                            LayoutEnd,
                            CHILD_WeightedHeight,              0,
                            AddVLayout,
                                LAYOUT_BevelStyle,             BVS_GROUP,
                                LAYOUT_Label,                  "Spells",
                                LAYOUT_AddChild,               gadgets[GID_BT_LB2] = (struct Gadget*)
                                ListBrowserObject,
                                    GA_ID,                     GID_BT_LB2,
                                    GA_RelVerify,              TRUE,
                                    LISTBROWSER_ColumnInfo,    (ULONG) SpellsColumnInfo,
                                    LISTBROWSER_Labels,        (ULONG) &SpellsList,
                                    LISTBROWSER_ColumnTitles,  TRUE,
                                    LISTBROWSER_AutoFit,       TRUE,
                                    LISTBROWSER_ShowSelected,  TRUE,
                                ListBrowserEnd,
                                HTripleButton(GID_BT_BU16, GID_BT_BU18, GID_BT_BU17),
                                AddHLayout,
                                    AddSpace,
                                    AddLabel((lbtips ? "Hover over a spell for more information." : "Click & hover on a spell for more info.")),
                                    CHILD_WeightedWidth,       0,
                                    AddSpace,
                                LayoutEnd,
                                CHILD_WeightedHeight,          0,
                            LayoutEnd,
                            CHILD_WeightedHeight,              100,
                        LayoutEnd,
                    LayoutEnd,
                    MaximizeButton(GID_BT_BU14, "Maximize Character"),
                    CHILD_WeightedHeight,                      0,
                LayoutEnd,
                AddHLayout,
                    MaximizeButton(GID_BT_BU15, "Maximize Roster"),
                    MapButton(GID_BT_BU23, "_When & Where..."),
                LayoutEnd,
                CHILD_WeightedHeight,                          0,
            LayoutEnd,
            AddLabel(""),
            CHILD_WeightedHeight,                              0,
            AddVLayout,
                LAYOUT_BevelStyle,                             BVS_GROUP,
                LAYOUT_Label,                                  "Items File",
                LAYOUT_AddChild,                               gadgets[GID_BT_CH7] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                     GID_BT_CH7,
                    GA_Disabled,                               TRUE,
                    CHOOSER_LabelArray,                        &LocationOptions,
                ChooserEnd,
                Label("Location:"),
                AddHLayout,
                    LAYOUT_AddChild,                           gadgets[GID_BT_BU19] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                                 GID_BT_BU19,
                        GA_RelVerify,                          TRUE,
                        GA_Text,                               "Bedder's Bank for the Bold...",
                    ButtonEnd,
                    LAYOUT_AddChild,                           gadgets[GID_BT_BU20] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                                 GID_BT_BU20,
                        GA_RelVerify,                          TRUE,
                        GA_Text,                               "Garth's Equipment Shoppe...",
                    ButtonEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                          0,
                AddHLayout,
                    ClearButton(   GID_BT_BU21, "Reset to Defaults"),
                    MaximizeButton(GID_BT_BU22, "Maximize Items File"),
                LayoutEnd,
                CHILD_WeightedHeight,                          0,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
        LayoutEnd,
        CHILD_NominalSize,                                     TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_BT_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData[(game == BTCS) ? 1 : 0];
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets(1);
    // ActivateLayoutGadget(gadgets[GID_BT_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_BT_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void bt_loop(ULONG gid, UNUSED ULONG code)
{   FLAG  ok;
    int   i, j;
    ULONG lowest,
          newclass,
          selspell;
PERSIST const UBYTE vanillaitems[132] = {
    0x00,0x00,0x01,0x02,0x01,0x00,0x02,0x00,0x01,0x03,0x01,0x03,0x02,0x00,0x01,0x02, //  $8x
    0x02,0x01,0x03,0x02,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x02, //  $9x
    0x01,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x06,0x00,0x01,0x01,0x00,0x00,0x04,0x01, //  $Ax
    0x01,0x01,0x03,0x01,0x01,0x00,0x02,0x01,0x00,0x02,0x00,0x02,0x03,0x00,0x01,0x04, //  $Bx
    0x00,0x00,0x01,0x00,0x01,0x01,0x00,0x00,0x00,0x03,0x00,0x02,0x00,0x00,0x00,0x01, //  $Cx
    0x00,0x00,0x00,0x01,0x02,0x03,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, //  $Dx
    0x00,0x00,0x01,0x00,0x02,0x00,0x00,0x01,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00, //  $Ex
    0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x02, //  $Fx
    0x00,0x00,0x00,0x00 };                                                           // $100..$103

    switch (gid)
    {
    case GID_BT_LB2:
        if (!lbtips)
        {   DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_BT_LB2], (ULONG*) &selspell);
            bard_hintinfo[2 + SPELLS].hi_Text = hintstring[selspell];
            // DISCARD SetAttrs(WinObject, WINDOW_HintInfo, &bard_hintinfo, TAG_END); does not seem to be needed
        }
    acase GID_BT_LB3:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_BT_LB3], (ULONG*) &newclass);

        if
        (   (game == BT1 && (newclass == CLASSGAD_ARCHMAGE     || newclass == CLASSGAD_ILLUSION  || newclass == CLASSGAD_MONSTER))
         || (game != BT3 && (newclass == CLASSGAD_CHRONOMANCER || newclass == CLASSGAD_GEOMANCER                                ))
        )
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_BT_LB3], MainWindowPtr, NULL,
                LISTBROWSER_Selected, man[who].theclass,
            TAG_END); // this autorefreshes
        } else
        {   man[who].theclass = newclass;
        }

        if (game == BT3 && (man[who].theclass == CLASSGAD_MONSTER || man[who].theclass == CLASSGAD_ILLUSION))
        {   for (i = 0; i <= 11; i++)
            {   man[who].item[i]     =
                man[who].equip[i]    = FALSE;
                man[who].quantity[i] = 0;
        }   }
    acase GID_BT_IN23:
        DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN23], (ULONG*) &man[who].damage);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_BT_BU1], MainWindowPtr, NULL,
            BUTTON_Integer, man[who].damage * 4,
        TAG_END); // this might autorefresh
        RefreshGadgets((struct Gadget*) gadgets[GID_BT_BU1], MainWindowPtr, NULL);
    acase GID_BT_BU14:
        readgadgets();
        maximize_man(who);
        writegadgets(1);
    acase GID_BT_BU15:
        readgadgets();
        for (i = 0; i < (int) men; i++)
        {   maximize_man(i);
        }
        writegadgets(1);
    acase GID_BT_BU16:
        readgadgets();
        for (i = 0; i < SPELLS; i++)
        {   man[who].spell[i] = TRUE;
        }
        writegadgets(2);
    acase GID_BT_BU17:
        readgadgets();
        for (i = 0; i < SPELLS; i++)
        {   man[who].spell[i] = FALSE;
        }
        writegadgets(2);
    acase GID_BT_BU18:
        readgadgets();
        for (i = 0; i < SPELLS; i++)
        {   if (man[who].spell[i])
            {   man[who].spell[i] = FALSE;
            } else
            {   man[who].spell[i] = TRUE;
        }   }
        writegadgets(2);
    acase GID_BT_BU19:
        bankwindow();
    acase GID_BT_BU20:
        shopwindow();
    acase GID_BT_BU21:
        location = 0; // Tangramayne

        for (i = 1; i <= 22; i++)
        {   garth[i] = 255;
        }
        for (i = 23; i <= 127; i++)
        {   garth[i] = 0;
        }

        for (i = 0; i < 10; i++)
        {   accountid[i]      = 0; // not $FFFFFFFF, gets translated at load/save time
            accountbalance[i] = 0;
        }

        if (game == BT2)
        {   for (i = 0; i < 132; i++)
            {   IOBuffer[0x80 + i] = vanillaitems[i];
        }   }
    acase GID_BT_BU22:
        for (i = 1; i <= 127; i++)
        {   garth[i] = 255;
        }
        for (i = 0; i < 10; i++)
        {   if (accountid[i] == 0)
            {   // find lowest unused id
                lowest = 0;
                do
                {   lowest++;
                    ok = TRUE;
                    for (j = 0; j < 10; j++)
                    {   if (accountid[j] == lowest)
                        {   ok = FALSE;
                            break; // for speed
                }   }   }
                while (!ok);
                accountid[i] = lowest;
            }
            accountbalance[i] = ONE_BILLION;
        }
    acase GID_BT_BU23:
        mapwindow();
    acase GID_BT_IN41:
        readgadgets();   // read old man
        writegadgets(1); // write new man
    adefault:
        if (gid >= GID_BT_BU2 && gid <= GID_BT_BU13)
        {   whichitem = gid - GID_BT_BU2;
            itemwindow();
}   }   }

EXPORT FLAG bt_open(FLAG loadas)
{   if
    (   gameopen(loadas)
     && filetovars()
    )
    {   writegadgets(1);
#ifndef __MORPHOS__
        if (MainWindowPtr)
        {   MouseData = (UWORD*) LocalMouseData[(game == BTCS) ? 1 : 0];
            setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
        }
#endif
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void readgadgets(void)
{   int          i;
    STRPTR       stringptr;
    struct Node* NodePtr;

    // general
    DISCARD GetAttr(STRINGA_TextVal,      (Object*) gadgets[GID_BT_ST1],  (ULONG*) &stringptr);
    strcpy(man[who].name, stringptr);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN1],  (ULONG*) &man[who].gp);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN2],  (ULONG*) &man[who].curhp);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN3],  (ULONG*) &man[who].maxhp);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN4],  (ULONG*) &man[who].cursp);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN5],  (ULONG*) &man[who].maxsp);
    DISCARD GetAttr(CHOOSER_Selected,     (Object*) gadgets[GID_BT_CH5],  (ULONG*) &man[who].status);

    // attributes
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN6],  (ULONG*) &man[who].curst);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN7],  (ULONG*) &man[who].curiq);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN8],  (ULONG*) &man[who].curdx);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN9],  (ULONG*) &man[who].curcn);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN10], (ULONG*) &man[who].curlk);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN11], (ULONG*) &man[who].maxst);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN12], (ULONG*) &man[who].maxiq);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN13], (ULONG*) &man[who].maxdx);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN14], (ULONG*) &man[who].maxcn);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN15], (ULONG*) &man[who].maxlk);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN16], (ULONG*) &man[who].magi);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN17], (ULONG*) &man[who].conj);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN18], (ULONG*) &man[who].sorc);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN19], (ULONG*) &man[who].wiza);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN20], (ULONG*) &man[who].arch);

    // illusions/monsters
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN21], (ULONG*) &man[who].armour);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN22], (ULONG*) &man[who].attacks);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN23], (ULONG*) &man[who].damage);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN24], (ULONG*) &man[who].theimage);
    DISCARD GetAttr(CHOOSER_Selected,     (Object*) gadgets[GID_BT_CH3],  (ULONG*) &man[who].special);

    // players
    DISCARD GetAttr(CHOOSER_Selected,     (Object*) gadgets[GID_BT_CH4],  (ULONG*) &man[who].race);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN25], (ULONG*) &man[who].curlev);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN26], (ULONG*) &man[who].maxlev);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN27], (ULONG*) &man[who].songs);
    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN28], (ULONG*) &man[who].xp);
    DISCARD GetAttr(CHOOSER_Selected,     (Object*) gadgets[GID_BT_CH2],  (ULONG*) &man[who].sex);

    // class
    DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_BT_LB3],  (ULONG*) &man[who].theclass);

    // items
    for (i = 0; i < 12; i++)
    {   DISCARD GetAttr(GA_Selected,      (Object*) gadgets[GID_BT_CB1  + i], (ULONG*) &man[who].equip[i]);
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BT_IN29 + i], (ULONG*) &man[who].quantity[i]);
        // no need to read the item choosers
    }

    // assert(SpellsList->lh_Head->ln_Succ); // the list is non-empty
    i = 0;
    // Walk the list
    for
    (   NodePtr = SpellsList.lh_Head;
        NodePtr->ln_Succ;
        NodePtr = NodePtr->ln_Succ
    )
    {   DISCARD GetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (ULONG*) &man[who].spell[i]);
        i++;
    }

    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_BT_IN41], (ULONG*) &who);
    who--;

    DISCARD GetAttr(CHOOSER_Selected,     (Object*) gadgets[GID_BT_CH7],  (ULONG*) &location);
}

MODULE FLAG filetovars(void)
{   // assert(gamesize % 122 != 1 || gamesize % 94 != 0);

    if   (gamesize       ==   86) { game = BT2;  filetype = FT_FLAG_C; }
    elif (gamesize       ==   96) { game = BT1;  filetype = FT_FLAG_C; }
    elif (gamesize       ==  128) { game = BT1;  filetype = FT_FLAG_I; }
    elif (gamesize       ==  340) { game = BT2;  filetype = FT_FLAG_I; }
    elif (gamesize       ==  972) { game = BT3;  filetype = FT_FLAG_S; }
    elif (gamesize       == 4327) { game = BT2;  filetype = FT_FLAG_S; }
    elif (gamesize % 122 ==    1) { game = BT3;  filetype = FT_FLAG_R; }
    elif (gamesize % 94  ==    0) { game = BTCS; filetype = FT_FLAG_R; }
    else
    {   DisplayBeep(NULL);
        return FALSE;
    }

    serializemode = SERIALIZE_READ;
    switch (game)
    {
    case BT1:
        serialize_bt1();
    acase BT2:
        if (filetype == FT_FLAG_C || filetype == FT_FLAG_S)
        {   load_bt2();
        } else
        {   // assert(filetype == FT_FLAG_I);
            serialize_bt2();
        }
    acase BT3:
        serialize_bt3();
    acase BTCS:
        serialize_btcs();
    }
    if (MainWindowPtr)
    {   writegadgets(1);
    }
    return TRUE;
}
EXPORT void bt_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    switch (game)
    {
    case  BT1:
        serialize_bt1();
        if (filetype == FT_FLAG_C)
        {   gamesave("TPW.#?.C"       , "Bard's Tale 1", saveas, gamesize, FT_FLAG_C, FALSE);
        } else
        {   gamesave("#?"             , "Bard's Tale 1", saveas, gamesize, FT_FLAG_I, FALSE);
        }
    acase BT2:
        switch (filetype)
        {
        case FT_FLAG_C:
            save_bt2();
            gamesave("TPW.#?.C"       , "Bard's Tale 2", saveas, gamesize, FT_FLAG_C, FALSE);
        acase FT_FLAG_I:
            serialize_bt2();
            gamesave("#?"             , "Bard's Tale 2", saveas, gamesize, FT_FLAG_I, FALSE);
        acase FT_FLAG_S:
            save_bt2();
            gamesave("#?save.game#?"  , "Bard's Tale 2", saveas, gamesize, FT_FLAG_S, FALSE);
        }
    acase BT3:
        serialize_bt3();
        if (filetype == FT_FLAG_S)
        {   gamesave("#?game.sav#?"   , "Bard's Tale 3", saveas, gamesize, FT_FLAG_S, FALSE);
        } else
        {   gamesave("#?THIEVES.INF#?", "Bard's Tale 3", saveas, gamesize, FT_FLAG_R, FALSE);
        }
    acase BTCS:
        serialize_btcs();
        gamesave("#?ROSTER.CHR#?"     , "BTCS"         , saveas, gamesize, FT_FLAG_R, FALSE);
}   }

MODULE void itemwindow(void)
{   TRANSIENT ULONG        i,
                           ordinal = 0; // initialized to prevent spurious SAS/C optimizer warnings
    TRANSIENT struct Node* NodePtr;
    PERSIST   WORD         leftx   = -1,
                           topy    = -1,
                           width   = -1,
                           height  = -1;

    submode = SUBMODE_ITEMS;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Choose Item",
        (leftx  != -1) ? WA_Left         : TAG_IGNORE, leftx,
        (topy   != -1) ? WA_Top          : TAG_IGNORE, topy,
        (width  != -1) ? WA_Width        : TAG_IGNORE, width,
        (height != -1) ? WA_Height       : TAG_IGNORE, height,
        (leftx  == -1) ? WINDOW_Position : TAG_IGNORE, WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "bard-1",
        WINDOW_ParentGroup,                    gadgets[GID_BT_LY2] = (struct Gadget*)
        VLayoutObject,
            GA_ID,                             GID_BT_LY2,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_SpaceInner,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_BT_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_BT_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &ItemsList,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    192,
            CHILD_MinHeight,                   480,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubWindowPtr->Width, SubWindowPtr->Height);
#endif

    DISCARD SetGadgetAttrs(gadgets[GID_BT_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels, ~0,         TAG_END);
    DISCARD SetGadgetAttrs(gadgets[GID_BT_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels, &ItemsList, TAG_END);
    for (i = 0; i <= ITEMS; i++)
    {   if
        (   (game == BT1  && man[who].item[whichitem] == items[i].bt1 )
         || (game == BT2  && man[who].item[whichitem] == items[i].bt2 )
         || (game == BT3  && man[who].item[whichitem] == items[i].bt3 )
         || (game == BTCS && man[who].item[whichitem] == items[i].btcs)
        )
        {   DISCARD SetGadgetAttrs(gadgets[GID_BT_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected, i, TAG_END);
            ordinal = i;
            break;
    }   }
    RefreshGadgets((struct Gadget*) gadgets[GID_BT_LB1], SubWindowPtr, NULL); // this might autorefresh

    DISCARD SetGadgetAttrs(gadgets[GID_BT_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels, ~0, TAG_END);
    // assert(ItemsList.lh_Head->ln_Succ); // the list is non-empty
    i = 0;
    // Walk the list
    for
    (   NodePtr = ItemsList.lh_Head;
        NodePtr->ln_Succ;
        NodePtr = NodePtr->ln_Succ
    )
    {   switch (game)
        {
        case BT1:
            if (i == 0 || items[i].bt1)
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, NULL, TAG_END);
            } else
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, LBFLG_READONLY | LBFLG_CUSTOMPENS, TAG_END);
                DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 0, LBNCA_FGPen, whitepen, TAG_END);
            }
        acase BT2:
            if (i == 0 || items[i].bt2)
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, NULL, TAG_END);
            } else
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, LBFLG_READONLY | LBFLG_CUSTOMPENS, TAG_END);
                DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 0, LBNCA_FGPen, whitepen, TAG_END);
            }
        acase BT3:
            if (i == 0 || items[i].bt3)
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, NULL, TAG_END);
            } else
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, LBFLG_READONLY | LBFLG_CUSTOMPENS, TAG_END);
                DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 0, LBNCA_FGPen, whitepen, TAG_END);
            }
        acase BTCS:
            if (i == 0 || items[i].btcs)
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, NULL, TAG_END);
            } else
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, LBFLG_READONLY | LBFLG_CUSTOMPENS, TAG_END);
                DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 0, LBNCA_FGPen, whitepen, TAG_END);
        }   }

        i++;
    }
    DISCARD SetGadgetAttrs(gadgets[GID_BT_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,      &ItemsList, TAG_END);
    DISCARD SetGadgetAttrs(gadgets[GID_BT_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, ordinal,    TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_BT_LB1], SubWindowPtr, NULL);

    subloop();

    leftx  = SubWindowPtr->LeftEdge;
    topy   = SubWindowPtr->TopEdge;
    width  = SubWindowPtr->Width;
    height = SubWindowPtr->Height;

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT void bt_die(void)
{   lb_clearlist(&ClassesList);
    lb_clearlist(&ItemsList);
    lb_clearlist(&SpellsList);
}

EXPORT void bt_close(void) { ; }

EXPORT void bt_exit(void)
{   ch_clearlist(&SexList);
    ch_clearlist(&FacingList1);
    ch_clearlist(&FacingList2);
    lb_clearlist(&ClassesList);
}

MODULE void serialize_bt1(void)
{   int   i;
    ULONG temp;

    if (filetype == FT_FLAG_C)
    {   offset = 1;

        if (serializemode == SERIALIZE_READ)
        {   serialize1(&temp);             //  1
            filetovar_status(who, (UBYTE) temp);
            offset++;                      //  2
            serialize1(&temp);             //  3
            filetovar_race(who, (UBYTE) temp);
            offset++;                      //  4
            serialize1(&temp);             //  5
            filetovar_class(who, (UBYTE) temp);
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);

            temp = vartofile_status(who);
            serialize1(&temp);             //  1
            offset++;                      //  2
            temp = vartofile_race(who);
            serialize1(&temp);             //  3
            offset++;                      //  4
            temp = vartofile_class(who);
            serialize1(&temp);             //  5
        }

        serialize2ulong(&man[who].curst);  //  6.. 7
        serialize2ulong(&man[who].curiq);  //  8.. 9
        serialize2ulong(&man[who].curdx);  // 10..11
        serialize2ulong(&man[who].curcn);  // 12..13
        serialize2ulong(&man[who].curlk);  // 14..15
        serialize2ulong(&man[who].maxst);  // 16..17
        serialize2ulong(&man[who].maxiq);  // 18..19
        serialize2ulong(&man[who].maxdx);  // 20..21
        serialize2ulong(&man[who].maxcn);  // 22..23
        serialize2ulong(&man[who].maxlk);  // 24..25
        serialize2ulong(&man[who].armour); // 26..27
        serialize2ulong(&man[who].maxhp);  // 28..29
        serialize2ulong(&man[who].curhp);  // 30..31
        serialize2ulong(&man[who].maxsp);  // 32..33
        serialize2ulong(&man[who].cursp);  // 34..35

        for (i = 0; i < 8; i++)            // 36..51
        {   if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);
                if (temp)
                {   man[who].equip[i] = TRUE;
                } else
                {   man[who].equip[i] = FALSE;
            }   }
            else
            {   if (man[who].equip[i])
                {   temp = 0x80;
                } else
                {   temp = 0;
                }
                serialize1(&temp);
            }
            serialize1(&man[who].item[i]);

            if (serializemode == SERIALIZE_READ)
            {   if (man[who].item[i])
                {   man[who].quantity[i] = 255;
                } else
                {   man[who].quantity[i] = 0;
        }   }   }

        serialize4(&man[who].xp);         // 52..55
        serialize4(&man[who].gp);         // 56..59
        serialize2ulong(&man[who].curlev);// 60..61
        serialize2ulong(&man[who].maxlev);// 62..63
        serialize2ulong(&man[who].sorc);  // 64..65
        serialize2ulong(&man[who].conj);  // 66..67
        serialize2ulong(&man[who].magi);  // 68..69
        serialize2ulong(&man[who].wiza);  // 70..71
        offset +=  9;                     // 72..80
        serialize1(&man[who].songs );     // 81
        offset += 11;                     // 82..92
        if (serializemode == SERIALIZE_READ)
        {   serialize1(&man[who].attacks); // 93    or 101
            man[who].attacks++;

            man[who].arch     =
            man[who].damage   =
            man[who].theimage =
            man[who].special  = 0;
        } else
        {   // assert(mode == SERIALIZE_WRITE);
            temp = man[who].attacks - 1;
            serialize1(&temp);
        }

        gamesize         = 96;
        man[who].name[0] = EOS;
    } else
    {   // assert(filetype == FT_FLAG_I);

        offset = 1;

        for (i = 1; i <= 127; i++)
        {   serialize1(&garth[i]);
        }

        gamesize         = 128;
}   }

MODULE void serialize_bt2(void)
{   int i;

    // assert(filetype == FT_FLAG_I);

    offset = 0;

    location++; // 0..5 -> 1..6
    serialize1(&location);
    if (location >= 7)
    {   location = 0;
    } elif (location != 0)
    {   location--; // 1..6 -> 0..5
    }

    for (i = 1; i <= 127; i++)
    {   serialize1(&garth[i]);
    }

    offset = 260;

    for (i = 0; i < 10; i++)
    {   if (accountid[i] == 0)
        {   accountid[i] = 0xFFFFFFFF;
        }
        serialize4(&accountid[i]);
        if (accountid[i] == 0xFFFFFFFF)
        {   accountid[i] = 0;
        }
        serialize4(&accountbalance[i]);
    }

    gamesize = 340;
}

MODULE void load_bt2(void)
{   FLAG  found;
    UBYTE tempbyte;
    int   i,
          whichman;

    serializemode = SERIALIZE_READ;

    if (filetype == FT_FLAG_C)
    {   men = 1;
        who = 0;
        offset = 1;
    } else
    {   // assert(filetype == FT_FLAG_S)
        men = 7;
        offset = 0x112;
    }

    for (whichman = 0; whichman < (int) men; whichman++)
    {   man[whichman].name[0] = EOS;

        tempbyte = getubyte(); filetovar_status(whichman, tempbyte); // 1
        tempbyte = getubyte(); filetovar_race(  whichman, tempbyte); // 2
        tempbyte = getubyte(); filetovar_class( whichman, tempbyte); // 3

        man[whichman].curst    = getubyte(); //  4
        man[whichman].curiq    = getubyte(); //  5
        man[whichman].curdx    = getubyte(); //  6
        man[whichman].curcn    = getubyte(); //  7
        man[whichman].curlk    = getubyte(); //  8
        man[whichman].maxst    = getubyte(); //  9
        man[whichman].maxiq    = getubyte(); // 10
        man[whichman].maxdx    = getubyte(); // 11
        man[whichman].maxcn    = getubyte(); // 12
        man[whichman].maxlk    = getubyte(); // 13
        offset += 2;                         // 14-15
        man[whichman].armour   = getuword(); // 16-17
        man[whichman].maxhp    = getuword(); // 18-19
        man[whichman].curhp    = getuword(); // 20-21
        man[whichman].maxsp    = getuword(); // 22-23
        man[whichman].cursp    = getuword(); // 24-25

        for (i = 0; i <= 7; i++)
        {   if (getubyte())
            {   man[whichman].equip[i] = TRUE;
            } else man[whichman].equip[i] = FALSE;  // 26, 28, 30, 32, 34, 36, 38, 40 or 43, 45, 47, 49, 51, 53, 55, 57
            man[whichman].item[i]     = getubyte(); // 27, 29, 31, 33, 35, 37, 39, 41 or 44, 46, 48, 50, 52, 54, 56, 58
        }
        for (i = 0; i <= 7; i++)
        {   man[whichman].quantity[i] = getubyte(); // 42-49 or 59-66
        }
        for (i = 8; i <= 11; i++)
        {   man[whichman].equip[i]    = FALSE;
            man[whichman].item[i]     =
            man[whichman].quantity[i] = 0;
        }

        man[whichman].xp       = getulong(); // 50-53
        man[whichman].gp       = getulong(); // 54-57
        man[whichman].curlev   = getubyte(); // 58
        man[whichman].maxlev   = getubyte(); // 59
        man[whichman].sorc     = getubyte(); // 60
        man[whichman].conj     = getubyte(); // 61
        man[whichman].magi     = getubyte(); // 62
        man[whichman].wiza     = getubyte(); // 63
        man[whichman].arch     = getubyte(); // 64
        offset += 4;                         // 65-68
        man[whichman].songs    = getubyte(); // 69
        offset += 3;                         // 70-72
        man[whichman].attacks  = getubyte() + 1; // 73
        offset += 9;                         // 74-82
        man[whichman].theimage = getubyte(); // 83

        tempbyte               = getubyte(); // 84
        switch (tempbyte)
        {
        case  1:  man[whichman].special = 7; // poison
        acase 2:  man[whichman].special = 5; // level drain
        acase 3:  man[whichman].special = 3; // insanity
        acase 4:  man[whichman].special = 1; // aging
        acase 5:  man[whichman].special = 8; // possession
        acase 6:  man[whichman].special = 9; // stoned
        acase 7:  man[whichman].special = 2; // critical hit
        acase 8:  man[whichman].special = 4; // item-zot
        acase 9:  man[whichman].special = 6; // point phaze
        adefault: man[whichman].special = 0; // normal. Eg. 0
        }

        man[whichman].damage  = getubyte();  // 85 or 102
        offset++;                            // 86
    }

    if (filetype == FT_FLAG_S)
    {   for (whichman = 0; whichman < 7; whichman++)
        {   found = FALSE;
            for (i = 13; i >= 0; i--)
            {   if (!found && IOBuffer[(0x26 * whichman) + i] == ' ')
                {   man[whichman].name[i] = EOS;
                } else
                {   found = TRUE;
                    man[whichman].name[i] = IOBuffer[(0x26 * whichman) + i];
        }   }   }

           offset = 0x36D;    serialize1(&area);
           offset = 0x371;    serialize1(&location_y1);
           offset = 0x373;    serialize1(&location_x1);
           offset = 0x375;    serialize1(&facing1);
           offset = 0x4D9;    serialize1(&hour);
           offset = 0x4DC;    serialize1(&location_y2);
           offset = 0x4DE;    serialize1(&location_x2);
           offset = 0x4E0;    serialize1(&facing2);
        /* offset = 0x4E1; */ serialize1(&dgnlevel);

        if (IOBuffer[0x36B] == 4) // dungeon
        {   for (i = 0; i < 17; i++)
            {   if (IOBuffer[0xAE6 + i] == 0xFF)
                {   dgnname[i] = EOS;
                    break;
                } else
                {   dgnname[i] = IOBuffer[0xAE6 + i] & 0x7F;
        }   }   }
        else
        {   dgnname[0] = EOS;
}   }   }

MODULE void save_bt2(void)
{   int i,
        length,
        whichman;

    serializemode = SERIALIZE_WRITE;

    if (filetype == FT_FLAG_C)
    {   offset = 0;
    } else
    {   // assert(filetype == FT_FLAG_S);
        offset = 0x111;
    }

    for (whichman = 0; whichman < (int) men; whichman++)
    {   if (man[whichman].theclass == CLASSGAD_MONSTER || man[whichman].theclass == CLASSGAD_ILLUSION)
        {   IOBuffer[offset] = 1;
        } else
        {   IOBuffer[offset] = 0;
        }

        IOBuffer[offset +  1] = vartofile_status(whichman);
        IOBuffer[offset +  2] = vartofile_race(whichman);
        IOBuffer[offset +  3] = vartofile_class(whichman);
        IOBuffer[offset +  4] = (UBYTE)  man[whichman].curst;
        IOBuffer[offset +  5] = (UBYTE)  man[whichman].curiq;
        IOBuffer[offset +  6] = (UBYTE)  man[whichman].curdx;
        IOBuffer[offset +  7] = (UBYTE)  man[whichman].curcn;
        IOBuffer[offset +  8] = (UBYTE)  man[whichman].curlk;
        IOBuffer[offset +  9] = (UBYTE)  man[whichman].maxst;
        IOBuffer[offset + 10] = (UBYTE)  man[whichman].maxiq;
        IOBuffer[offset + 11] = (UBYTE)  man[whichman].maxdx;
        IOBuffer[offset + 12] = (UBYTE)  man[whichman].maxcn;
        IOBuffer[offset + 13] = (UBYTE)  man[whichman].maxlk;
        IOBuffer[offset + 17] = (UBYTE)  man[whichman].armour;
        IOBuffer[offset + 18] = (UBYTE) (man[whichman].maxhp / 256); // these parentheses are needed
        IOBuffer[offset + 19] = (UBYTE) (man[whichman].maxhp % 256);
        IOBuffer[offset + 20] = (UBYTE) (man[whichman].curhp / 256);
        IOBuffer[offset + 21] = (UBYTE) (man[whichman].curhp % 256);
        IOBuffer[offset + 22] = (UBYTE) (man[whichman].maxsp / 256);
        IOBuffer[offset + 23] = (UBYTE) (man[whichman].maxsp % 256);
        IOBuffer[offset + 24] = (UBYTE) (man[whichman].cursp / 256);
        IOBuffer[offset + 25] = (UBYTE) (man[whichman].cursp % 256);

        for (i = 0; i <= 7; i++)
        {   if (man[whichman].equip[i])
            {   IOBuffer[offset + (i * 2) + 26] = 0x80;
            } else
            {   IOBuffer[offset + (i * 2) + 26] = 0;
            }
            IOBuffer[    offset + (i * 2) + 27] = man[whichman].item[i];
        }
        for (i = 0; i <= 7; i++)
        {   IOBuffer[    offset +  i      + 42] = man[whichman].quantity[i];
        }

        IOBuffer[offset + 50] = (UBYTE)   (man[whichman].xp / 16777216);
        IOBuffer[offset + 51] = (UBYTE)  ((man[whichman].xp % 16777216) / 65536);
        IOBuffer[offset + 52] = (UBYTE) (( man[whichman].xp             % 65536) / 256);
        IOBuffer[offset + 53] = (UBYTE) (  man[whichman].xp                      % 256);
        IOBuffer[offset + 54] = (UBYTE)   (man[whichman].gp / 16777216);
        IOBuffer[offset + 55] = (UBYTE)  ((man[whichman].gp % 16777216) / 65536);
        IOBuffer[offset + 56] = (UBYTE) (( man[whichman].gp             % 65536) / 256);
        IOBuffer[offset + 57] = (UBYTE) (  man[whichman].gp                      % 256);
        IOBuffer[offset + 58] = (UBYTE) man[whichman].curlev;
        IOBuffer[offset + 59] = (UBYTE) man[whichman].maxlev;
        IOBuffer[offset + 60] = (UBYTE) man[whichman].sorc;
        IOBuffer[offset + 61] = (UBYTE) man[whichman].conj;
        IOBuffer[offset + 62] = (UBYTE) man[whichman].magi;
        IOBuffer[offset + 63] = (UBYTE) man[whichman].wiza;
        IOBuffer[offset + 64] = (UBYTE) man[whichman].arch;
        IOBuffer[offset + 69] = (UBYTE) man[whichman].songs;
        IOBuffer[offset + 73] = (UBYTE) man[whichman].attacks - 1;
        IOBuffer[offset + 83] = (UBYTE) man[whichman].theimage;

        switch (man[whichman].special)
        {
        case  1:  IOBuffer[offset + 84] = 4; // aging
        acase 2:  IOBuffer[offset + 84] = 7; // critical hit
        acase 3:  IOBuffer[offset + 84] = 3; // insanity
        acase 4:  IOBuffer[offset + 84] = 8; // item-zot
        acase 5:  IOBuffer[offset + 84] = 2; // level drain
        acase 6:  IOBuffer[offset + 84] = 9; // point phaze
        acase 7:  IOBuffer[offset + 84] = 1; // poison
        acase 8:  IOBuffer[offset + 84] = 5; // possession
        acase 9:  IOBuffer[offset + 84] = 6; // stoned
        adefault: IOBuffer[offset + 84] = 0; // normal. Eg. 0
        }

        IOBuffer[offset + 85] = (UBYTE) man[whichman].damage;

        offset += 86;
    }

    if (filetype == FT_FLAG_S)
    {   for (whichman = 0; whichman < 7; whichman++)
        {   length = strlen(man[whichman].name);
            if (length >= 1)
            {   for (i = 0; i < length; i++)
                {   IOBuffer[(0x26 * whichman) + i] = toupper(man[whichman].name[i]);
            }   }
            if (length <= 13)
            {   for (i = length; i <= 13; i++)
                {   IOBuffer[(0x26 * whichman) + i] = ' ';
        }   }   }

           offset = 0x36D;    serialize1(&area);
           offset = 0x371;    serialize1(&location_y1);
           offset = 0x373;    serialize1(&location_x1);
           offset = 0x375;    serialize1(&facing1);
           offset = 0x4D9;    serialize1(&hour);
           offset = 0x4DC;    serialize1(&location_y2);
           offset = 0x4DE;    serialize1(&location_x2);
           offset = 0x4E0;    serialize1(&facing2);
        /* offset = 0x4E1; */ serialize1(&dgnlevel);

        if (IOBuffer[0x36B] == 4) // dungeon
        {   for (i = 0; i < 17; i++)
            {   if (dgnname[i] == EOS)
                {   IOBuffer[0xAE6 + i] = 0xFF;
                    break;
                } else
                {   IOBuffer[0xAE6 + i] = dgnname[i] | 0x80;
        }   }   }
        // else leave it alone

        gamesize = 4327; // probably not needed
    } else
    {   gamesize =   86; // probably not needed
}   }

MODULE void serialize_bt3(void)
{   UBYTE SpellBuffer[16];
    ULONG temp;
    int   i,
          whichman;

    if (serializemode == SERIALIZE_READ)
    {   if (filetype == FT_FLAG_S)
        {   men = 0;
            for (i = 0; i < 7; i++)
            {   if (IOBuffer[i * 122] != EOS) // this is probably not how the game determines the number of characters
                {   men++;
                } else
                {   break;
            }   }
            if (men == 0)
            {   DisplayBeep(NULL);
                return;
        }   }
        else
        {   men = gamesize / 122;
        }
        if (who >= men)
        {   who = 0;
    }   }

    offset = 0;

    for (whichman = 0; whichman < (int) men; whichman++)
    {   if (serializemode == SERIALIZE_READ)
        {   zstrncpy(man[whichman].name, (char*) &IOBuffer[offset], 14);
        } else
        {   strncpy((char*) &IOBuffer[offset], man[whichman].name, 14); // 0..14
            // *not* zstrncpy() because we don't want to NUL-terminate it!
        }
        // pad byte                                  // $ F
        offset += 16;
        serialize1(&man[whichman].maxst);            // $10
        serialize1(&man[whichman].maxiq);            // $11
        serialize1(&man[whichman].maxdx);            // $12
        serialize1(&man[whichman].maxcn);            // $13
        serialize1(&man[whichman].maxlk);            // $14
        offset++;                                    // $15
        serialize4(&man[whichman].xp);               // $16..$19
        serialize4(&man[whichman].gp);               // $1A..$1D
        serialize2ulong(&man[whichman].curlev);      // $1E..$1F
        serialize2ulong(&man[whichman].maxlev);      // $20..$21
        serialize2ulong(&man[whichman].curhp );      // $22..$23
        serialize2ulong(&man[whichman].maxhp );      // $24..$25
        serialize2ulong(&man[whichman].cursp );      // $26..$27
        serialize2ulong(&man[whichman].maxsp );      // $28..$29

        if (serializemode == SERIALIZE_READ)
        {   serialize1(&temp);                       // $2A
            filetovar_class(whichman, (UBYTE) temp);
            serialize1(&temp);                       // $2B
            filetovar_race(whichman, (UBYTE) temp);
            serialize1(&man[whichman].sex);          // $2C
            serialize1(&man[whichman].theimage);     // $2D
            serialize1(&temp);                       // $2E
            filetovar_status(whichman, (UBYTE) temp);
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            temp = vartofile_class(whichman);
            serialize1(&temp);                       // $2A
            temp = vartofile_race(whichman);
            serialize1(&temp);                       // $2B
            serialize1(&man[whichman].sex);          // $2C
            serialize1(&man[whichman].theimage);     // $2D
            temp = vartofile_status(whichman);
            serialize1(&temp);                       // $2E
        }
        offset += 2;                                 // $2F..$30

        for (i = 0; i < 12; i++)                     // $31..$54 (12*3 bytes)
        {   if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);
                if (temp)
                {   man[whichman].equip[i] = TRUE;
                } else
                {   man[whichman].equip[i] = FALSE;
            }   }
            else
            {   // assert(serializemode == SERIALIZE_WRITE);
                if (man[whichman].equip[i])
                {   temp = 1;
                } else
                {   temp = 0;
                }
                serialize1(&temp);
            }
            serialize1(&man[whichman].item[i]);
            serialize1(&man[whichman].quantity[i]);
        }

        // spells
        if (serializemode == SERIALIZE_READ)
        {   for (i = 0; i < 16; i++)
            {   SpellBuffer[i] = IOBuffer[offset++]; // $55..$64
            }
            for (i = 0; i < SPELLS; i++)
            {   if (SpellBuffer[spells[i].thebyte - 84] & spells[i].thebit)
                {   man[whichman].spell[i] = TRUE;
                } else
                {   man[whichman].spell[i] = FALSE;
        }   }   }
        else
        {   // assert(serializemode == SERIALIZE_WRITE);
            for (i = 0; i < 16; i++)
            {   SpellBuffer[i] = 0;
            }
            for (i = 0; i < SPELLS; i++)
            {   if (man[whichman].spell[i])
                {   SpellBuffer[spells[i].thebyte - 84] |= spells[i].thebit;
            }   }
            for (i = 0; i < 16; i++)
            {   IOBuffer[offset++] = SpellBuffer[i]; // $55..$64
        }   }

        serialize1(&man[whichman].songs);            // $65
        offset += 5;                                 // $66..$6A
        if (serializemode == SERIALIZE_READ)
        {   serialize1(&man[whichman].attacks);      // $6B
            man[whichman].attacks++;
        } else
        {   temp = man[whichman].attacks - 1;        // $6B
            serialize1(&temp);
        }

        offset += 14;                                // $6C..$79

        if (serializemode == SERIALIZE_READ)
        {   man[whichman].curst   = man[whichman].maxst;
            man[whichman].curiq   = man[whichman].maxiq;
            man[whichman].curdx   = man[whichman].maxdx;
            man[whichman].curcn   = man[whichman].maxcn;
            man[whichman].curlk   = man[whichman].maxlk;
            man[whichman].armour  = 10;
            man[whichman].damage  =
            man[whichman].special =  0;
    }   }

    if (filetype == FT_FLAG_S)
    {   if (serializemode == SERIALIZE_READ)
        {   if (IOBuffer[0x365] == 4)
            {   switch (IOBuffer[0x359])
                {
                case     0: plane = 1; area =  2; // Festering Pit 1
                acase    1: plane = 1; area =  3; // Festering Pit 2
                acase    2: plane = 1; area =  4; // Crystal Palace
                acase    3: plane = 1; area =  5; // Valarian's Tower 1
                acase    4: plane = 1; area =  6; // Valarian's Tower 2
                acase    5: plane = 1; area =  7; // Valarian's Tower 3
                acase    6: plane = 1; area =  8; // Valarian's Tower 4
                acase    7: plane = 1; area =  9; // Sacred Grove
                acase    8: plane = 2; area =  1; // White Tower 1
                acase    9: plane = 2; area =  2; // White Tower 2
                acase  0xA: plane = 2; area =  3; // White Tower 3
                acase  0xB: plane = 2; area =  4; // White Tower 4
                acase  0xC: plane = 2; area =  5; // Grey Tower 1
                acase  0xD: plane = 2; area =  6; // Grey Tower 2
                acase  0xE: plane = 2; area =  7; // Grey Tower 3
                acase  0xF: plane = 2; area =  8; // Grey Tower 4
                acase 0x10: plane = 2; area =  9; // Black Tower 1
                acase 0x11: plane = 2; area = 10; // Black Tower 2
                acase 0x12: plane = 2; area = 11; // Black Tower 3
                acase 0x13: plane = 2; area = 12; // Black Tower 4
                acase 0x14: plane = 2; area = 13; // Ice Dungeon 1
                acase 0x15: plane = 2; area = 14; // Ice Dungeon 2
                acase 0x16: plane = 2; area = 15; // Ice Keep 1
                acase 0x17: plane = 2; area = 16; // Ice Keep 2
                acase 0x18: plane = 3; area =  2; // Violet Mountain 1
                acase 0x19: plane = 3; area =  3; // Violet Mountain 2
                acase 0x1A: plane = 3; area =  4; // Cyanis' Tower 1
                acase 0x1B: plane = 3; area =  5; // Cyanis' Tower 2
                acase 0x1C: plane = 3; area =  6; // Cyanis' Tower 3
                acase 0x1D: plane = 3; area =  7; // Alliria's Tomb 1
                acase 0x1E: plane = 3; area =  8; // Alliria's Tomb 2
                acase 0x1F: plane = 6; area =  1; // Wasteland
                acase 0x20: plane = 6; area =  0; // Tarmitian dungeon
                acase 0x21: plane = 6; area =  2; // Berlin
                acase 0x22: plane = 6; area =  3; // Stalingrad
                acase 0x23: plane = 6; area =  4; // Hiroshima
                acase 0x24: plane = 6; area =  5; // Troy
                acase 0x25: plane = 6; area =  6; // Rome
                acase 0x26: plane = 6; area =  7; // Nottingham
                acase 0x27: plane = 6; area =  8; // K'un Wang
                acase 0x28: plane = 0; area =  2; // Catacombs 1
                acase 0x29: plane = 0; area =  3; // Catacombs 2 aka Tunnels
                acase 0x2A: plane = 7; area =  0; // Malefia 1
                acase 0x2B: plane = 7; area =  1; // Malefia 2
                acase 0x2C: plane = 7; area =  2; // Malefia 3
                acase 0x2D: plane = 4; area =  0; // Barracks
                acase 0x2E: plane = 4; area =  1; // Ferofist's Palace
                acase 0x2F: plane = 4; area =  2; // Private Quarters
                acase 0x30: plane = 4; area =  3; // Workshop 1
                acase 0x31: plane = 4; area =  4; // Workshop 2 aka Urmech's Paradise
                acase 0x32: plane = 4; area =  5; // Workshop 3 aka Viscous Plane
                acase 0x33: plane = 4; area =  6; // Urmech's Sanctum
                acase 0x34: plane = 0; area =  4; // UnterBrae 1
                acase 0x35: plane = 0; area =  5; // UnterBrae 2
                acase 0x36: plane = 0; area =  6; // UnterBrae 3
                acase 0x37: plane = 0; area =  7; // UnterBrae 4
                acase 0x38: plane = 5; area =  3; // Tar quarry
                acase 0x39: plane = 5; area =  4; // Shadow Canyon
                acase 0x3A: plane = 5; area =  5; // Sceadu's Demesne 1
                acase 0x3B: plane = 5; area =  6; // Sceadu's Demesne 2
                acase 0x3C: plane = 7; area =  3; // Tarjan
            }   }
            else
            {   switch (IOBuffer[0x357])
                {
                case     0: plane = 0; area  = 0; // Realm wilderness
                acase    1: plane = 0; area  = 1; // Skara Brae
                acase    2: plane = 1; area  = 0; // Arborian wilderness
                acase    3: plane = 1; area  = 1; // Ciera Brannia
                acase    4: plane = 2; area  = 0; // Gelidian wilderness
                acase    5: plane = 3; area  = 0; // Lucencian wilderness
                acase    6: plane = 3; area  = 1; // Celaria Bree
                acase    7: plane = 5; area  = 0; // Nowhere aka Tenebrosian wilderness
                acase    8: plane = 5; area  = 1; // Dark Copse
                acase    9: plane = 5; area  = 2; // Black Scar
        }   }   }
        else
        {   // assert (serializemode == SERIALIZE_WRITE);
            switch (plane)
            {
            case 0: // Realm
                switch (area)
                {
                case   0: IOBuffer[0x357] =    0; IOBuffer[0x365] = 2; // Realm wilderness
                acase  1: IOBuffer[0x357] =    1; IOBuffer[0x365] = 2; // Skara Brae
                acase  2: IOBuffer[0x359] = 0x28; IOBuffer[0x365] = 4; // Catacombs 1
                acase  3: IOBuffer[0x359] = 0x29; IOBuffer[0x365] = 4; // Catacombs 2 aka Tunnels
                acase  4: IOBuffer[0x359] = 0x34; IOBuffer[0x365] = 4; // UnterBrae 1
                acase  5: IOBuffer[0x359] = 0x35; IOBuffer[0x365] = 4; // UnterBrae 2
                acase  6: IOBuffer[0x359] = 0x36; IOBuffer[0x365] = 4; // UnterBrae 3
                acase  7: IOBuffer[0x359] = 0x37; IOBuffer[0x365] = 4; // UnterBrae 4
                }
            acase 1: // Arboria
                switch (area)
                {
                case   0: IOBuffer[0x357] =    2; IOBuffer[0x365] = 2; // Arborian wilderness
                acase  1: IOBuffer[0x357] =    3; IOBuffer[0x365] = 2; // Ciera Brannia
                acase  2: IOBuffer[0x359] =    0; IOBuffer[0x365] = 4; // Festering Pit 1
                acase  3: IOBuffer[0x359] =    1; IOBuffer[0x365] = 4; // Festering Pit 2
                acase  4: IOBuffer[0x359] =    2; IOBuffer[0x365] = 4; // Crystal Palace
                acase  5: IOBuffer[0x359] =    3; IOBuffer[0x365] = 4; // Valarian's Tower 1
                acase  6: IOBuffer[0x359] =    4; IOBuffer[0x365] = 4; // Valarian's Tower 2
                acase  7: IOBuffer[0x359] =    5; IOBuffer[0x365] = 4; // Valarian's Tower 3
                acase  8: IOBuffer[0x359] =    6; IOBuffer[0x365] = 4; // Valarian's Tower 4
                acase  9: IOBuffer[0x359] =    7; IOBuffer[0x365] = 4; // Sacred Grove
                }
            acase 2: // Gelidia
                switch (area)
                {
                case   0: IOBuffer[0x357] =    4; IOBuffer[0x365] = 2; // Gelidian wilderness
                acase  1: IOBuffer[0x359] =    8; IOBuffer[0x365] = 4; // White Tower 1
                acase  2: IOBuffer[0x359] =    9; IOBuffer[0x365] = 4; // White Tower 2
                acase  3: IOBuffer[0x359] =  0xA; IOBuffer[0x365] = 4; // White Tower 3
                acase  4: IOBuffer[0x359] =  0xB; IOBuffer[0x365] = 4; // White Tower 4
                acase  5: IOBuffer[0x359] =  0xC; IOBuffer[0x365] = 4; // Grey Tower 1
                acase  6: IOBuffer[0x359] =  0xD; IOBuffer[0x365] = 4; // Grey Tower 2
                acase  7: IOBuffer[0x359] =  0xE; IOBuffer[0x365] = 4; // Grey Tower 3
                acase  8: IOBuffer[0x359] =  0xF; IOBuffer[0x365] = 4; // Grey Tower 4
                acase  9: IOBuffer[0x359] = 0x10; IOBuffer[0x365] = 4; // Black Tower 1
                acase 10: IOBuffer[0x359] = 0x11; IOBuffer[0x365] = 4; // Black Tower 2
                acase 11: IOBuffer[0x359] = 0x12; IOBuffer[0x365] = 4; // Black Tower 3
                acase 12: IOBuffer[0x359] = 0x13; IOBuffer[0x365] = 4; // Black Tower 4
                acase 13: IOBuffer[0x359] = 0x14; IOBuffer[0x365] = 4; // Ice Dungeon 1
                acase 14: IOBuffer[0x359] = 0x15; IOBuffer[0x365] = 4; // Ice Dungeon 2
                acase 15: IOBuffer[0x359] = 0x16; IOBuffer[0x365] = 4; // Ice Keep 1
                acase 16: IOBuffer[0x359] = 0x17; IOBuffer[0x365] = 4; // Ice Keep 2
                }
            acase 3: // Lucencia
                switch (area)
                {
                case   0: IOBuffer[0x357] =    5; IOBuffer[0x365] = 2; // Lucencian wilderness
                acase  1: IOBuffer[0x357] =    6; IOBuffer[0x365] = 2; // Celaria Bree
                acase  2: IOBuffer[0x359] = 0x18; IOBuffer[0x365] = 4; // Violet Mountain 1
                acase  3: IOBuffer[0x359] = 0x19; IOBuffer[0x365] = 4; // Violet Mountain 2
                acase  4: IOBuffer[0x359] = 0x1A; IOBuffer[0x365] = 4; // Cyanis' Tower 1
                acase  5: IOBuffer[0x359] = 0x1B; IOBuffer[0x365] = 4; // Cyanis' Tower 2
                acase  6: IOBuffer[0x359] = 0x1C; IOBuffer[0x365] = 4; // Cyanis' Tower 3
                acase  7: IOBuffer[0x359] = 0x1C; IOBuffer[0x365] = 4; // Alliria's Tomb 1
                acase  8: IOBuffer[0x359] = 0x1C; IOBuffer[0x365] = 4; // Alliria's Tomb 2
                }
            acase 4: // Kinestia
                switch (area)
                {
                case   0: IOBuffer[0x359] = 0x2D; IOBuffer[0x365] = 4; // Barracks
                acase  1: IOBuffer[0x359] = 0x2E; IOBuffer[0x365] = 4; // Ferofist's Palace
                acase  2: IOBuffer[0x359] = 0x2F; IOBuffer[0x365] = 4; // Private Quarters
                acase  3: IOBuffer[0x359] = 0x30; IOBuffer[0x365] = 4; // Workshop 1
                acase  4: IOBuffer[0x359] = 0x31; IOBuffer[0x365] = 4; // Workshop 2 aka Urmech's Paradise
                acase  5: IOBuffer[0x359] = 0x32; IOBuffer[0x365] = 4; // Workshop 3 aka Viscous Plane
                acase  6: IOBuffer[0x359] = 0x33; IOBuffer[0x365] = 4; // Urmech's Sanctum
                }
            acase 5: // Tenebrosia
                switch (area)
                {
                case   0: IOBuffer[0x357] =    7; IOBuffer[0x365] = 2; // Nowhere aka Tenebrosian wilderness
                acase  1: IOBuffer[0x357] =    8; IOBuffer[0x365] = 2; // Dark Copse
                acase  2: IOBuffer[0x357] =    9; IOBuffer[0x365] = 2; // Black Scar
                acase  3: IOBuffer[0x359] = 0x38; IOBuffer[0x365] = 4; // Tar quarry
                acase  4: IOBuffer[0x359] = 0x39; IOBuffer[0x365] = 4; // Shadow Canyon
                acase  5: IOBuffer[0x359] = 0x3A; IOBuffer[0x365] = 4; // Sceadu's Demesne 1
                acase  6: IOBuffer[0x359] = 0x3B; IOBuffer[0x365] = 4; // Sceadu's Demesne 2
                }
            acase 6: // Tarmitia
                switch (area)
                {
                case   0: IOBuffer[0x359] = 0x20; IOBuffer[0x365] = 4; // Tarmitian dungeon
                acase  1: IOBuffer[0x359] = 0x1F; IOBuffer[0x365] = 4; // Wasteland
                acase  2: IOBuffer[0x359] = 0x21; IOBuffer[0x365] = 4; // Berlin
                acase  3: IOBuffer[0x359] = 0x22; IOBuffer[0x365] = 4; // Stalingrad
                acase  4: IOBuffer[0x359] = 0x23; IOBuffer[0x365] = 4; // Hiroshima
                acase  5: IOBuffer[0x359] = 0x24; IOBuffer[0x365] = 4; // Troy
                acase  6: IOBuffer[0x359] = 0x25; IOBuffer[0x365] = 4; // Rome
                acase  7: IOBuffer[0x359] = 0x26; IOBuffer[0x365] = 4; // Nottingham
                acase  8: IOBuffer[0x359] = 0x27; IOBuffer[0x365] = 4; // K'un Wang
                }
            acase 7: // Malefia
                switch (area)
                {
                case   0: IOBuffer[0x359] = 0x2A; IOBuffer[0x365] = 4; // Malefia 1
                acase  1: IOBuffer[0x359] = 0x2B; IOBuffer[0x365] = 4; // Malefia 2
                acase  2: IOBuffer[0x359] = 0x2C; IOBuffer[0x365] = 4; // Malefia 3
                acase  3: IOBuffer[0x359] = 0x3C; IOBuffer[0x365] = 4; // Tarjan
        }   }   }
        
        offset = 0x35D; serialize1(&location_y1);   // $35D
        offset = 0x35F; serialize1(&location_x1);   // $35F
        offset = 0x3BA; serialize1(&hour);          // $3BA
    }

    if (serializemode == SERIALIZE_WRITE)
    {   temp = 0;
        serialize1(&temp);
    }

    if (filetype == FT_FLAG_S)
    {   gamesize = 972; // probably not needed
    } else
    {   gamesize = (men * 122) + 1;
}   }

MODULE void filetovar_race(int whichman, UBYTE thebyte)
{   switch (thebyte)
    {
    case  1:  man[whichman].race = 1; // elf
    acase 2:  man[whichman].race = 0; // dwarf
    acase 3:  man[whichman].race = 5; // hobbit
    acase 4:  man[whichman].race = 3; // half-elf
    acase 5:  man[whichman].race = 4; // half-orc
    acase 6:  man[whichman].race = 2; // gnome
    adefault: man[whichman].race = 6; // human. Eg. 0
}   }
MODULE void filetovar_class(int whichman, UBYTE thebyte)
{   switch (thebyte)
    {
    case 1:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_WIZARD;
        } else man[whichman].theclass = CLASSGAD_PALADIN;
    acase 2:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_SORCERER;
        } else man[whichman].theclass = CLASSGAD_ROGUE;
    acase 3:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_CONJURER;
        } else man[whichman].theclass = CLASSGAD_BARD;
    acase 4:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_MAGICIAN;
        } else man[whichman].theclass = CLASSGAD_HUNTER;
    acase 5:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_ROGUE;
        } else man[whichman].theclass = CLASSGAD_MONK;
    acase 6:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_BARD;
        } else man[whichman].theclass = CLASSGAD_CONJURER;
    acase 7:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_PALADIN;
        } else man[whichman].theclass = CLASSGAD_MAGICIAN;
    acase 8:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_HUNTER;
        } else man[whichman].theclass = CLASSGAD_SORCERER;
    acase 9:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_MONK;
        } else man[whichman].theclass = CLASSGAD_WIZARD;
    acase 10:
        man[whichman].theclass = CLASSGAD_ARCHMAGE; // same for all games
    acase 11:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_CHRONOMANCER;
        } else // game should be BT2 or BTCS
        {   man[whichman].theclass = CLASSGAD_MONSTER;
        }
    acase 12:
        if (game == BT3)
        {   man[whichman].theclass = CLASSGAD_GEOMANCER;
        } else // game should be BT2 or BTCS
        {   man[whichman].theclass = CLASSGAD_ILLUSION;
        }
    acase 13:
        // game should be BT3
        man[whichman].theclass = CLASSGAD_MONSTER;
    acase 14:
        // game should be BT3
        man[whichman].theclass = CLASSGAD_ILLUSION;
    adefault: // eg. 0
        man[whichman].theclass = CLASSGAD_WARRIOR; // same for all games
}   }
MODULE void filetovar_status(int whichman, UBYTE thebyte)
{   if (game == BTCS)
    {   if (thebyte & 0x40) thebyte = 0x40;
        if (thebyte & 0x20) thebyte = 0x20;
        if (thebyte & 0x10) thebyte = 0x10;
        if (thebyte & 0x08) thebyte = 0x08;
        if (thebyte & 0x04) thebyte = 0x04;
        if (thebyte & 0x02) thebyte = 0x02;
        if (thebyte & 0x01) thebyte = 0x01;
    }

    switch (thebyte)
    {
    case  0x80: if (game != BTCS) man[whichman].status = 2; // insane
    acase 0x40: if (game == BTCS) man[whichman].status = 4; /* paralyzed */ else man[whichman].status = 6; // possessed
    acase 0x20: if (game == BTCS) man[whichman].status = 7; /* stoned    */ else man[whichman].status = 4; // paralyzed
    acase 0x10: if (game == BTCS) man[whichman].status = 6; /* possessed */ else man[whichman].status = 7; // stoned
    acase 0x08: if (game == BTCS) man[whichman].status = 3; /* old       */ else man[whichman].status = 5; // poisoned
    acase 0x04: if (game == BTCS) man[whichman].status = 2; /* insane    */ else man[whichman].status = 3; // old
    acase 0x02: if (game == BTCS) man[whichman].status = 5; /* poisoned  */ else man[whichman].status = 1; // dead
    acase 0x01: if (game == BTCS) man[whichman].status = 1; // dead
    adefault:
        man[whichman].status = 0; // OK. Eg. 0, which is perfect health
}   }

MODULE UBYTE vartofile_race(int whichman)
{   UBYTE thebyte = 0; // initialized to prevent spurious SAS/C optimizer warnings

    switch (man[whichman].race)
    {
    case  0: thebyte = 2; // dwarf
    acase 1: thebyte = 1; // elf
    acase 2: thebyte = 6; // gnome
    acase 3: thebyte = 4; // half-elf
    acase 4: thebyte = 5; // half-orc
    acase 5: thebyte = 3; // hobbit
    acase 6: thebyte = 0; // human
    }

    return thebyte;
}
MODULE UBYTE vartofile_class(int whichman)
{   UBYTE thebyte = 0; // initialized to prevent spurious SAS/C optimizer warnings

    switch (man[whichman].theclass)
    {
    case CLASSGAD_ARCHMAGE:
        thebyte = 10; // same for all games
    acase CLASSGAD_BARD:
        if (game == BT3) thebyte =  6; else thebyte =  3;
    acase CLASSGAD_CHRONOMANCER:
        // assert(game == BT3);
        thebyte = 11;
    acase CLASSGAD_CONJURER:
        if (game == BT3) thebyte =  3; else thebyte =  6;
    acase CLASSGAD_GEOMANCER:
        // assert(game == BT3);
        thebyte = 12;
    acase CLASSGAD_HUNTER:
        if (game == BT3) thebyte =  8; else thebyte =  4;
    acase CLASSGAD_ILLUSION:
        if (game == BT3) thebyte = 14; else thebyte = 12;
    acase CLASSGAD_MAGICIAN:
        if (game == BT3) thebyte =  4; else thebyte =  7;
    acase CLASSGAD_MONK:
        if (game == BT3) thebyte =  9; else thebyte =  5;
    acase CLASSGAD_MONSTER:
        if (game == BT3) thebyte = 13; else thebyte = 11;
    acase CLASSGAD_PALADIN:
        if (game == BT3) thebyte =  7; else thebyte =  1;
    acase CLASSGAD_ROGUE:
        if (game == BT3) thebyte =  5; else thebyte =  2;
    acase CLASSGAD_SORCERER:
        if (game == BT3) thebyte =  2; else thebyte =  8;
    acase CLASSGAD_WARRIOR:
        thebyte =  0; // same for all games
    acase CLASSGAD_WIZARD:
        if (game == BT3) thebyte =  1; else thebyte =  9;
    }

    return thebyte;
}
MODULE UBYTE vartofile_status(int whichman)
{   UBYTE thebyte = 0; // initialized to prevent spurious SAS/C optimizer warnings

    switch (man[whichman].status)
    {
    case  0: /* OK        */ thebyte = 0;
    acase 1: /* dead      */ if (game == BTCS) thebyte = 0x01; else thebyte = 0x02;
    acase 2: /* insane    */ if (game == BTCS) thebyte = 0x04; else thebyte = 0x80;
    acase 3: /* old       */ if (game == BTCS) thebyte = 0x08; else thebyte = 0x04;
    acase 4: /* paralyzed */ if (game == BTCS) thebyte = 0x40; else thebyte = 0x20;
    acase 5: /* poisoned  */ if (game == BTCS) thebyte = 0x02; else thebyte = 0x08;
    acase 6: /* possessed */ if (game == BTCS) thebyte = 0x10; else thebyte = 0x40;
    acase 7: /* stoned    */ if (game == BTCS) thebyte = 0x20; else thebyte = 0x10;
    }

    return thebyte;
}

MODULE void writegadgets(ULONG mode)
{   ULONG        i, j;
    FLAG         found;
    struct Node* NodePtr;

    if
    (   page != FUNC_BT
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    /* Modes are:

    0: inventory only
    1: everything
    2: spells only */

    if (mode == 1)
    {   // general
        SetGadgetAttrs(gadgets[GID_BT_BU16], MainWindowPtr, NULL,                                               GA_Disabled, game == BT1 || game == BT2 || filetype == FT_FLAG_I, TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_BU17], MainWindowPtr, NULL,                                               GA_Disabled, game == BT1 || game == BT2 || filetype == FT_FLAG_I, TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_BU18], MainWindowPtr, NULL,                                               GA_Disabled, game == BT1 || game == BT2 || filetype == FT_FLAG_I, TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_IN41], MainWindowPtr, NULL, INTEGER_Number, who + 1, INTEGER_Maximum, men,GA_Disabled, game == BT1 || (game == BT2 && filetype != FT_FLAG_S) || filetype == FT_FLAG_I, TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_IN42], MainWindowPtr, NULL, INTEGER_Number,          men,                                                                                   TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_ST1 ], MainWindowPtr, NULL, STRINGA_TextVal,         man[who].name,       GA_Disabled, (game != BT3 && game != BTCS && (game != BT2 || filetype != FT_FLAG_S)) || filetype == FT_FLAG_I, TAG_END); // we must explicitly refresh
        RefreshGadgets((struct Gadget*) gadgets[GID_BT_ST1], MainWindowPtr, NULL);
        SetGadgetAttrs(gadgets[GID_BT_CH1 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) game,                                                                             TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_CH6 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) filetype,                                                                         TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN1 ], MainWindowPtr, NULL, INTEGER_Number,          man[who].gp,         GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN2 ], MainWindowPtr, NULL, INTEGER_Number,          man[who].curhp,      GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN3 ], MainWindowPtr, NULL, INTEGER_Number,          man[who].maxhp,      GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN4 ], MainWindowPtr, NULL, INTEGER_Number,          man[who].cursp,      GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN5 ], MainWindowPtr, NULL, INTEGER_Number,          man[who].maxsp,      GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN21], MainWindowPtr, NULL, INTEGER_Number,          man[who].armour,     GA_Disabled, game == BT3 || filetype == FT_FLAG_I,                   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_CH5 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].status,     GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        
        // attributes
        SetGadgetAttrs(gadgets[GID_BT_IN6 ], MainWindowPtr, NULL, INTEGER_Number,          man[who].curst,      GA_Disabled, game == BT3 || filetype == FT_FLAG_I,                   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN7 ], MainWindowPtr, NULL, INTEGER_Number,          man[who].curiq,      GA_Disabled, game == BT3 || filetype == FT_FLAG_I,                   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN8 ], MainWindowPtr, NULL, INTEGER_Number,          man[who].curdx,      GA_Disabled, game == BT3 || filetype == FT_FLAG_I,                   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN9 ], MainWindowPtr, NULL, INTEGER_Number,          man[who].curcn,      GA_Disabled, game == BT3 || filetype == FT_FLAG_I,                   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN10], MainWindowPtr, NULL, INTEGER_Number,          man[who].curlk,      GA_Disabled, game == BT3 || filetype == FT_FLAG_I,                   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN11], MainWindowPtr, NULL, INTEGER_Number,          man[who].maxst,      GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN12], MainWindowPtr, NULL, INTEGER_Number,          man[who].maxiq,      GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN13], MainWindowPtr, NULL, INTEGER_Number,          man[who].maxdx,      GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN14], MainWindowPtr, NULL, INTEGER_Number,          man[who].maxcn,      GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN15], MainWindowPtr, NULL, INTEGER_Number,          man[who].maxlk,      GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN16], MainWindowPtr, NULL, INTEGER_Number,          man[who].magi,       GA_Disabled, game == BT3 || filetype == FT_FLAG_I,                   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN17], MainWindowPtr, NULL, INTEGER_Number,          man[who].conj,       GA_Disabled, game == BT3 || filetype == FT_FLAG_I,                   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN18], MainWindowPtr, NULL, INTEGER_Number,          man[who].sorc,       GA_Disabled, game == BT3 || filetype == FT_FLAG_I,                   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN19], MainWindowPtr, NULL, INTEGER_Number,          man[who].wiza,       GA_Disabled, game == BT3 || filetype == FT_FLAG_I,                   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN20], MainWindowPtr, NULL, INTEGER_Number,          man[who].arch,       GA_Disabled, (game != BT2 && game != BTCS) || filetype == FT_FLAG_I, TAG_END);

        // illusions/monsters
        SetGadgetAttrs(gadgets[GID_BT_IN22], MainWindowPtr, NULL, INTEGER_Number,          man[who].attacks,    GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN23], MainWindowPtr, NULL, INTEGER_Number,          man[who].damage,     GA_Disabled, (game != BT2 || filetype == FT_FLAG_I),                 TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_BU1 ], MainWindowPtr, NULL, BUTTON_Integer,          man[who].damage * 4,                                                              TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN24], MainWindowPtr, NULL, INTEGER_Number,          man[who].theimage,   GA_Disabled, game == BT1 || game == BTCS || filetype == FT_FLAG_I,   TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_CH3 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].special,    GA_Disabled, game != BT2 || filetype == FT_FLAG_I,                   TAG_END);

        // players
        SetGadgetAttrs(gadgets[GID_BT_CH4 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].race,       GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN25], MainWindowPtr, NULL, INTEGER_Number,          man[who].curlev,     GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN26], MainWindowPtr, NULL, INTEGER_Number,          man[who].maxlev,     GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN27], MainWindowPtr, NULL, INTEGER_Number,          man[who].songs,      GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_IN28], MainWindowPtr, NULL, INTEGER_Number,          man[who].xp,         GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_CH5 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].status,     GA_Disabled, filetype == FT_FLAG_I,                                  TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_CH2 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].sex,        GA_Disabled, game != BT3 || filetype == FT_FLAG_I,                   TAG_END);

        SetGadgetAttrs(gadgets[GID_BT_BU16], MainWindowPtr, NULL,                                               GA_Disabled, game != BT3 || filetype == FT_FLAG_I,                   TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_BU17], MainWindowPtr, NULL,                                               GA_Disabled, game != BT3 || filetype == FT_FLAG_I,                   TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_BU18], MainWindowPtr, NULL,                                               GA_Disabled, game != BT3 || filetype == FT_FLAG_I,                   TAG_END); // this autorefreshes

        SetGadgetAttrs(gadgets[GID_BT_BU23], MainWindowPtr, NULL,                                               GA_Disabled, filetype != FT_FLAG_S,                                  TAG_END); // this autorefreshes

        // class
        DISCARD SetGadgetAttrs(gadgets[GID_BT_LB3], MainWindowPtr, NULL, LISTBROWSER_Labels, ~0, TAG_END);
        // assert(ClassesList.lh_Head->ln_Succ); // the list is non-empty
        i = 0;
        // Walk the list
        for
        (   NodePtr = ClassesList.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   if
            (   i == CLASSGAD_ARCHMAGE
             || i == CLASSGAD_ILLUSION
             || i == CLASSGAD_MONSTER
            )
            {   if (game == BT1)
                {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, LBFLG_CUSTOMPENS, TAG_END);
                    DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 1, LBNCA_FGPen, whitepen, TAG_END);
                } else
                {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, NULL, TAG_END);
            }   }
            elif
            (   i == CLASSGAD_CHRONOMANCER
             || i == CLASSGAD_GEOMANCER
            )
            {   if (game != BT3)
                {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, LBFLG_CUSTOMPENS, TAG_END);
                    DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 1, LBNCA_FGPen, whitepen, TAG_END);
                } else
                {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, NULL, TAG_END);
            }   }
            i++;
        }
        SetGadgetAttrs(gadgets[GID_BT_LB3 ], MainWindowPtr, NULL, LISTBROWSER_Labels,      (ULONG) &ClassesList,                                                             TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_LB3 ], MainWindowPtr, NULL, LISTBROWSER_Selected,    (WORD)  man[who].theclass,                                                        TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_LB3 ], MainWindowPtr, NULL, LISTBROWSER_MakeVisible, man[who].theclass,                                                                TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_LB3 ], MainWindowPtr, NULL,                                               GA_Disabled, filetype == FT_FLAG_I,                          TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_BT_LB3], MainWindowPtr, NULL);

        SetGadgetAttrs(gadgets[GID_BT_BU14], MainWindowPtr, NULL,                                               GA_Disabled, filetype == FT_FLAG_I,                          TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_BU15], MainWindowPtr, NULL,                                               GA_Disabled, filetype != FT_FLAG_R && filetype != FT_FLAG_S, TAG_END); // this autorefreshes

        // items file

        SetGadgetAttrs(gadgets[GID_BT_CH7 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) location,            GA_Disabled, filetype != FT_FLAG_I || game != BT2,           TAG_END); // this autorefreshes

        SetGadgetAttrs(gadgets[GID_BT_BU19], MainWindowPtr, NULL,                                               GA_Disabled, filetype != FT_FLAG_I || game != BT2,           TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_BU20], MainWindowPtr, NULL,                                               GA_Disabled, filetype != FT_FLAG_I,                          TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_BU21], MainWindowPtr, NULL,                                               GA_Disabled, filetype != FT_FLAG_I,                          TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_BU22], MainWindowPtr, NULL,                                               GA_Disabled, filetype != FT_FLAG_I,                          TAG_END); // this autorefreshes
    }

    if (mode >= 1)
    {   // spells
        SetGadgetAttrs(gadgets[GID_BT_LB2 ], MainWindowPtr, NULL,                                               GA_Disabled, game != BT3,                                    TAG_END);
        SetGadgetAttrs(gadgets[GID_BT_LB2 ], MainWindowPtr, NULL, LISTBROWSER_Labels,      ~0,                                                                               TAG_END);
        // assert(SpellsList.lh_Head->ln_Succ); // the list is non-empty
        i = 0;
        // Walk the list
        for
        (   NodePtr = SpellsList.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (BOOL) man[who].spell[i], TAG_END);
            i++;
        }
        SetGadgetAttrs(gadgets[GID_BT_LB2 ], MainWindowPtr, NULL, LISTBROWSER_Labels,      (ULONG) &SpellsList,                                                              TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_BT_LB2], MainWindowPtr, NULL);
    }

    if (mode <= 1)
    {   // items
        for (i = 0; i <= 11; i++)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_BT_CB1 + i], MainWindowPtr, NULL,
                GA_Selected, man[who].equip[i],
                GA_Disabled, (game != BT3 && i >= 8) || filetype == FT_FLAG_I,
            TAG_END);
            RefreshGadgets((struct Gadget*) gadgets[GID_BT_CB1 + i], MainWindowPtr, NULL);

            if (man[who].item[i])
            {   found = FALSE;

                for (j = 1; j <= ITEMS; j++)
                {   if
                    (   (game == BT1  && items[j].bt1  == man[who].item[i])
                     || (game == BT2  && items[j].bt2  == man[who].item[i])
                     || (game == BT3  && items[j].bt3  == man[who].item[i])
                     || (game == BTCS && items[j].btcs == man[who].item[i])
                    )
                    {   DISCARD SetGadgetAttrs
                        (   gadgets[GID_BT_BU2 + i], MainWindowPtr, NULL,
                            GA_Text, items[j].name,
                        TAG_END); // this autorefreshes
                        found = TRUE;
                        break;
                }   }

                if (!found)
                {   // we should not reach this point normally
                    DISCARD SetGadgetAttrs
                    (   gadgets[GID_BT_ST1 + i], MainWindowPtr, NULL,
                        GA_Text, "?",
                    TAG_END);
            }   }
            else
            {   DISCARD SetGadgetAttrs
                (   gadgets[GID_BT_BU2 + i], MainWindowPtr, NULL,
                    GA_Text, "-",
                TAG_END);
            }
            DISCARD SetGadgetAttrs
            (   gadgets[GID_BT_IN29 + i], MainWindowPtr, NULL,
                INTEGER_Number, man[who].quantity[i],
                GA_Disabled,    game == BT1 || ((game == BT2 || game == BTCS) && i >= 8) || filetype == FT_FLAG_I,
            TAG_END);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_BT_BU2 + i], MainWindowPtr, NULL,
                GA_Disabled,    (game != BT3 && i >= 8) || filetype == FT_FLAG_I,
            TAG_END);
}   }   }

MODULE void serialize_btcs(void)
{   int   whichman,
          i;
    UBYTE tempbyte;
    ULONG temp;

    if (serializemode == SERIALIZE_READ)
    {   men = gamesize / 94;
        if (who >= men)
        {   who = 0;
    }   }

    offset = 0;

    for (whichman = 0; whichman < (int) men; whichman++)
    {   if (serializemode == SERIALIZE_READ)
        {   zstrncpy(man[whichman].name, (char*) &IOBuffer[offset], 14); // 0..13
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            strncpy((char*) &IOBuffer[offset], man[whichman].name, 14); // 0..13
            // *not* zstrncpy() because we don't want to NUL-terminate it!
        }
        offset += 17;

        if (serializemode == SERIALIZE_READ)
        {   tempbyte = getubyte();              // 17
            filetovar_status(whichman, tempbyte);
            tempbyte = getubyte();              // 18
            filetovar_race(whichman, tempbyte);
            tempbyte = getubyte();              // 19
            filetovar_class(whichman, tempbyte);
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            temp = (ULONG) vartofile_status(whichman);
            serialize1(&temp);
            temp = (ULONG) vartofile_race(whichman);
            serialize1(&temp);
            temp = (ULONG) vartofile_class(whichman);
            serialize1(&temp);
        }

        serialize1(&man[whichman].curst);       // 20
        serialize1(&man[whichman].curiq);       // 21
        serialize1(&man[whichman].curdx);       // 22
        serialize1(&man[whichman].curcn);       // 23
        serialize1(&man[whichman].curlk);       // 24
        serialize1(&man[whichman].maxst);       // 25
        serialize1(&man[whichman].maxiq);       // 26
        serialize1(&man[whichman].maxdx);       // 27
        serialize1(&man[whichman].maxcn);       // 28
        serialize1(&man[whichman].maxlk);       // 29
        serialize2ilong(&man[whichman].armour); // 30..31
        serialize2ilong(&man[whichman].maxhp ); // 32..33
        serialize2ilong(&man[whichman].curhp ); // 34..35
        serialize2ilong(&man[whichman].cursp ); // 36..37
        serialize2ilong(&man[whichman].maxsp ); // 38..39

        for (i = 0; i < 8; i++)
        {   serialize1(&man[whichman].item[i]);  // 40, 42, 44, 46, 48, 50, 52, 54
            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);               // 41, 43, 45, 47, 49, 51, 53, 55
                if (temp)
                {   man[whichman].equip[i] = TRUE;
                } else
                {   man[whichman].equip[i] = FALSE;
            }   }
            else
            {   // assert(serializemode == SERIALIZE_WRITE);
                if (man[whichman].equip[i])
                {   temp = 0x20;
                } else
                {   temp = 0;
                }
                serialize1(&temp);
        }   }
        for (i = 0; i < 8; i++)
        {   serialize1(&man[whichman].quantity[i]); // 56..63
        }

        serialize4i(&man[whichman].xp );    // 64..67
        serialize4i(&man[whichman].gp );    // 68..71
        serialize1(&man[whichman].curlev ); // 72
        serialize1(&man[whichman].maxlev ); // 73
        serialize1(&man[whichman].sorc   ); // 74
        serialize1(&man[whichman].conj   ); // 75
        serialize1(&man[whichman].magi   ); // 76
        serialize1(&man[whichman].wiza   ); // 77
        serialize1(&man[whichman].arch   ); // 78
        offset += 3;                        // 79..81
        serialize1(&man[whichman].songs  ); // 82
        serialize1(&man[whichman].attacks); // 83
        offset += 10;                       // 84..93

        if (serializemode == SERIALIZE_READ)
        {   for (i = 8; i < 12; i++)
            {   man[whichman].equip[i]    = FALSE;
                man[whichman].item[i]     =
                man[whichman].quantity[i] = 0;
            }

            man[whichman].theimage =
            man[whichman].damage   =
            man[whichman].special  = 0;
    }   }

    gamesize = men * 94;
}

MODULE void maximize_man(int whichman)
{   man[whichman].status  = 0; // OK
    man[whichman].curst   = man[whichman].maxst =
    man[whichman].curiq   = man[whichman].maxiq =
    man[whichman].curdx   = man[whichman].maxdx =
    man[whichman].curcn   = man[whichman].maxcn =
    man[whichman].curlk   = man[whichman].maxlk = 200;
    man[whichman].curlev  = man[whichman].maxlev = 90;
    man[whichman].sorc    =
    man[whichman].conj    =
    man[whichman].magi    =
    man[whichman].wiza    =
    man[whichman].arch    = 7;
    man[whichman].songs   =
    man[whichman].attacks = 200;
    man[whichman].maxhp   = man[whichman].curhp =
    man[whichman].maxsp   = man[whichman].cursp = 9000;
    man[whichman].xp      =
    man[whichman].gp      = ONE_BILLION;
}

EXPORT FLAG bt_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_N7:
        if (submode == SUBMODE_MAP && game == BT3)
        {   map_leftorup(   qual, sizes[whichmap].x, (int*) &location_x1, GID_BT_IN191, SubWindowPtr);
            map_rightordown(qual, sizes[whichmap].y, (int*) &location_y1, GID_BT_IN192, SubWindowPtr); // this is no mistake
            bt_drawmap();
        }
    acase SCAN_UP:
    case SCAN_N8:
    case NM_WHEEL_UP:
        switch (submode)
        {
        case SUBMODE_ITEMS:
            lb_scroll_up(GID_BT_LB1, SubWindowPtr, qual);
        acase SUBMODE_MAP:
            if (game == BT3)
            {   map_rightordown(qual, sizes[whichmap].y, (int*) &location_y1, GID_BT_IN192, SubWindowPtr); // this is no mistake
                bt_drawmap();
        }   }
    acase SCAN_N9:
        if (submode == SUBMODE_MAP && game == BT3)
        {   map_rightordown(qual, sizes[whichmap].x, (int*) &location_x1, GID_BT_IN191, SubWindowPtr);
            map_rightordown(qual, sizes[whichmap].y, (int*) &location_y1, GID_BT_IN192, SubWindowPtr); // this is no mistake
            bt_drawmap();
        }
    acase SCAN_LEFT:
    case SCAN_N4:
        if (submode == SUBMODE_MAP && game == BT3)
        {   map_leftorup(   qual, sizes[whichmap].x, (int*) &location_x1, GID_BT_IN191, SubWindowPtr);
            bt_drawmap();
        }
    acase SCAN_RIGHT:
    case SCAN_N6:
        if (submode == SUBMODE_MAP && game == BT3)
        {   map_rightordown(qual, sizes[whichmap].x , (int*) &location_x1, GID_BT_IN191, SubWindowPtr);
            bt_drawmap();
        }
    acase SCAN_N1:
        if (submode == SUBMODE_MAP && game == BT3)
        {   map_leftorup(   qual, sizes[whichmap].x , (int*) &location_x1, GID_BT_IN191, SubWindowPtr);
            map_leftorup(   qual, sizes[whichmap].y, (int*) &location_y1, GID_BT_IN192, SubWindowPtr); // this is no mistake
            bt_drawmap();
        }
    acase SCAN_DOWN:
    case SCAN_N5:
    case SCAN_N2:
    case NM_WHEEL_DOWN:
        switch (submode)
        {
        case SUBMODE_ITEMS:
            lb_scroll_down(GID_BT_LB1, SubWindowPtr, qual);
        acase SUBMODE_MAP:
            if (game == BT3)
            {   map_leftorup(   qual, sizes[whichmap].y, (int*) &location_y1, GID_BT_IN192, SubWindowPtr); // this is no mistake
                bt_drawmap();
        }   }
    acase SCAN_N3:
        if (submode == SUBMODE_MAP && game == BT3)
        {   map_rightordown(qual, sizes[whichmap].x , (int*) &location_x1, GID_BT_IN191, SubWindowPtr);
            map_leftorup(   qual, sizes[whichmap].y, (int*) &location_y1, GID_BT_IN192, SubWindowPtr); // this is no mistake
            bt_drawmap();
    }   }

    return FALSE;
}

EXPORT FLAG bt_subgadget(ULONG gid, UWORD code)
{   ULONG seconds,
          temp;

    switch (gid)
    {
    case GID_BT_CH8:
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_BT_CH8], (ULONG*) &facing1);
        if (game == BT3)
        {   bt_drawmap();
        }
    acase GID_BT_CH9:
        // assert(game == BT3);
        GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_BT_CH9], &temp);
        if (plane != temp)
        {   plane = temp;
            area = 0;
            SetGadgetAttrs(gadgets[GID_BT_CH10], SubWindowPtr, NULL, CHOOSER_Selected, area, CHOOSER_LabelArray, &Area3Options[plane], TAG_END); // autorefreshes
            bt_drawmap();
        }
    acase GID_BT_CH10:
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_BT_CH10], (ULONG*) &area);
        if (game == BT2)
        {   SetGadgetAttrs(gadgets[GID_BT_IN191], SubWindowPtr, NULL, INTEGER_Maximum, (area == 0) ? 31 : 15, TAG_END);
            SetGadgetAttrs(gadgets[GID_BT_IN192], SubWindowPtr, NULL, INTEGER_Maximum, (area == 0) ? 47 : 15, TAG_END);
        } else
        {   // assert(game == BT3);
            bt_drawmap();
        }
    acase GID_BT_CH11:
        // assert(game == BT2);
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_BT_CH11], (ULONG*) &facing2);
#ifndef __MORPHOS__
    acase GID_BT_CL1:
        // assert(ClockBase);
        GetAttr(CLOCKGA_Time, (Object*) gadgets[GID_BT_CL1], (ULONG*) &seconds);
        seconds %= 86400         ; // seconds in day
        hour    =  seconds / 3600; // seconds in hour
        SetGadgetAttrs(gadgets[GID_BT_IN190], SubWindowPtr, NULL, INTEGER_Number, hour, TAG_END); // autorefreshes
#endif
    acase GID_BT_IN190:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_BT_IN190], (ULONG*) &hour);
#ifndef __MORPHOS__
        if (ClockBase)
        {   SetGadgetAttrs(gadgets[GID_BT_CL1], SubWindowPtr, NULL, CLOCKGA_Time, hour * 60 * 60, TAG_END); // autorefreshes
        }
#endif
    acase GID_BT_IN191:
        if (game == BT2)
        {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_BT_IN191], (ULONG*) &location_x1);
        } else
        {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_BT_IN191], (ULONG*) &temp);
            if (temp < sizes[whichmap].x)
            {   location_x1 = temp;
                bt_drawmap();
            } else
            {   SetGadgetAttrs(gadgets[GID_BT_IN191], SubWindowPtr, NULL, INTEGER_Number, location_x1, TAG_END); // autorefreshes
        }   }
    acase GID_BT_IN192:
        if (game == BT2)
        {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_BT_IN192], (ULONG*) &location_y1);
        } else
        {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_BT_IN192], (ULONG*) &temp);
            if (temp < sizes[whichmap].y)
            {   location_y1 = temp;
                bt_drawmap();
            } else
            {   SetGadgetAttrs(gadgets[GID_BT_IN192], SubWindowPtr, NULL, INTEGER_Number, location_y1, TAG_END); // autorefreshes
        }   }
    acase GID_BT_IN194:
        GetAttr(INTEGER_Number, (Object*) gadgets[GID_BT_IN194], (ULONG*) &location_x2);
    acase GID_BT_IN195:
        GetAttr(INTEGER_Number, (Object*) gadgets[GID_BT_IN195], (ULONG*) &location_y2);
    acase GID_BT_BU24:
        // assert(game == BT3);
        say(oracle[whichmap], REQIMAGE_INFO);
    acase GID_BT_LB1:
        if (code == 0)
        {   man[who].quantity[whichitem] = 0;
            man[who].equip[whichitem] = FALSE;
        } elif (man[who].item[whichitem] == 0)
        {   man[who].quantity[whichitem] = 255;
        }
        switch (game)
        {
        case  BT1:  man[who].item[whichitem] = items[code].bt1;
        acase BT2:  man[who].item[whichitem] = items[code].bt2;
        acase BT3:  man[who].item[whichitem] = items[code].bt3;
        acase BTCS: man[who].item[whichitem] = items[code].btcs;
        }
        writegadgets(0);

        return TRUE;
    default: // adefault is not necessary
        if (gid >= GID_BT_IN43 && gid <= GID_BT_IN52)
        {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[gid],  (ULONG*) &accountid[gid - GID_BT_IN43]);
            DISCARD SetGadgetAttrs
            (   gadgets[gid - GID_BT_IN43 + GID_BT_IN53], SubWindowPtr, NULL,
                GA_Disabled, accountid[gid - GID_BT_IN43] ? FALSE : TRUE,
            TAG_END); // this autorefreshes
    }   }

    return FALSE;
}

MODULE void make_classes(void)
{   int                     i;
    struct ListBrowserNode* ListBrowserNodePtr;

    NewList(&ClassesList);

    for (i = 0; i < 15; i++)
    {   if (!(ListBrowserNodePtr = (struct ListBrowserNode*) AllocListBrowserNode
        (   2,                  // columns,
            LBNA_Column,        0,
            LBNCA_Image,        image[240 + i],
            LBNA_Column,        1,
            LBNCA_Text,         ClassOptions[i],
	 // LBNCA_VertJustify is "not currently implemented and ignored by the gadget" :-(
        TAG_END)))
        {   rq("Can't create listbrowser.gadget node(s)!");
        }
        AddTail(&ClassesList, (struct Node*) ListBrowserNodePtr); /* AddTail() has no return code */
}   }

EXPORT void bt_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey)
{   switch (scancode)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        if (mouseisover(GID_BT_LB2, mousex, mousey))
        {   lb_scroll_up(GID_BT_LB2, MainWindowPtr, qual);
        } else
        {   lb_scroll_up(GID_BT_LB3, MainWindowPtr, qual);
        }
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        if (mouseisover(GID_BT_LB2, mousex, mousey))
        {   lb_scroll_down(GID_BT_LB2, MainWindowPtr, qual);
        } else
        {   lb_scroll_down(GID_BT_LB3, MainWindowPtr, qual);
        }
    acase SCAN_W:
        if (filetype == FT_FLAG_S)
        {   mapwindow();
}   }   }

MODULE void bankwindow(void)
{   TRANSIENT int  i;
    PERSIST   WORD leftx  = -1,
                   topy   = -1,
                   width  = -1,
                   height = -1;

    submode = SUBMODE_BANK;

    load_images(267, 267);

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Edit Bank Accounts",
        (leftx  != -1) ? WA_Left         : TAG_IGNORE, leftx,
        (topy   != -1) ? WA_Top          : TAG_IGNORE, topy,
        (width  != -1) ? WA_Width        : TAG_IGNORE, width,
        (height != -1) ? WA_Height       : TAG_IGNORE, height,
        (leftx  == -1) ? WINDOW_Position : TAG_IGNORE, WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "bard-2",
        WINDOW_ParentGroup,                    gadgets[GID_BT_LY3] = (struct Gadget*)
        VLayoutObject,
            GA_ID,                             GID_BT_LY3,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_SpaceInner,                 TRUE,
            AddHLayout,
                AddSpace,
                AddImage(267),
                CHILD_WeightedWidth,               0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                  0,
            AddLabel(""),
            CHILD_WeightedHeight,                  0,
            AddBank(0),
            AddBank(1),
            AddBank(2),
            AddBank(3),
            AddBank(4),
            AddBank(5),
            AddBank(6),
            AddBank(7),
            AddBank(8),
            AddBank(9),
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubWindowPtr->Width, SubWindowPtr->Height);
#endif

    DISCARD ActivateLayoutGadget(gadgets[GID_BT_LY3], SubWindowPtr, NULL, (Object) gadgets[GID_BT_IN43]);

    subloop();

    for (i = 0; i < 10; i++)
    {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_BT_IN53 + i], (ULONG*) &accountbalance[i]);
    }

    leftx  = SubWindowPtr->LeftEdge;
    topy   = SubWindowPtr->TopEdge;
    width  = SubWindowPtr->Width;
    height = SubWindowPtr->Height;

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE void shopwindow(void)
{   TRANSIENT int    i, j;
    PERSIST   WORD   leftx  = -1,
                     topy   = -1,
                     width  = -1,
                     height = -1;

    submode = SUBMODE_SHOP;

    for (i = 1; i <= 127; i++)
    {   strcpy(ShopName[i], "?");
        for (j = 1; j <= ITEMS; j++)
        {   if
            (   (game == BT1 && i == items[j].bt1)
             || (game == BT2 && i == items[j].bt2)
            )
            {   sprintf(ShopName[i], "%s:", items[j].name);
    }   }   }

    load_images
    (   game == BT1 ? 268 : 119,
        game == BT1 ? 268 : 119
    );

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    for (i = 0; i < 127; i++)
    {   gadgets[GID_BT_LY5 + i] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_VertAlignment,     LALIGN_CENTER,
            AddLabel(ShopName[i + 1]),
            CHILD_WeightedWidth,      0,
            AddSpace,
            LAYOUT_AddChild,          gadgets[GID_BT_IN63 + i] = (struct Gadget*)
            IntegerObject,
                GA_ID,                GID_BT_IN63 + i,
                GA_TabCycle,          TRUE,
                INTEGER_Minimum,      0,
                INTEGER_Maximum,      255,
                INTEGER_MinVisible,   3 + 1,
                INTEGER_Number,       garth[i + 1],
            IntegerEnd,
            CHILD_WeightedWidth,      0,
        LayoutEnd;
    }

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                             TRUE,
        WA_ThinSizeGadget,                         TRUE,
        WA_Title,                                  "Edit Shoppe Inventory",
        (leftx  != -1) ? WA_Left         : TAG_IGNORE, leftx,
        (topy   != -1) ? WA_Top          : TAG_IGNORE, topy,
        (width  != -1) ? WA_Width        : TAG_IGNORE, width,
        (height != -1) ? WA_Height       : TAG_IGNORE, height,
        (leftx  == -1) ? WINDOW_Position : TAG_IGNORE, WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                           "bard-3",
        WINDOW_ParentGroup,                        gadgets[GID_BT_LY4] = (struct Gadget*)
        VLayoutObject,
            AddHLayout,
                AddSpace,
                AddImage(game == BT1 ? 268 : 119),
                CHILD_WeightedWidth,               0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                  0,
            AddLabel(""),
            CHILD_WeightedHeight,                  0,
            AddHLayout,
                GA_ID,                             GID_BT_LY4,
                AddVLayout,
                    AddSpace,
                    AddShop( 1),
                    AddShop( 2),
                    AddShop( 3),
                    AddShop( 4),
                    AddShop( 5),
                    AddShop( 6),
                    AddShop( 7),
                    AddShop( 8),
                    AddShop( 9),
                    AddShop(10),
                    AddShop(11),
                    AddShop(12),
                    AddShop(13),
                    AddShop(14),
                    AddShop(15),
                    AddShop(16),
                    AddShop(17),
                    AddShop(18),
                    AddShop(19),
                    AddShop(20),
                    AddShop(21),
                    AddShop(22),
                    AddShop(23),
                    AddShop(24),
                    AddShop(25),
                    AddShop(26),
                    AddShop(27),
                    AddShop(28),
                    AddShop(29),
                    AddShop(30),
                    AddShop(31),
                LayoutEnd,
                AddVLayout,
                    AddShop(32 +  0),
                    AddShop(32 +  1),
                    AddShop(32 +  2),
                    AddShop(32 +  3),
                    AddShop(32 +  4),
                    AddShop(32 +  5),
                    AddShop(32 +  6),
                    AddShop(32 +  7),
                    AddShop(32 +  8),
                    AddShop(32 +  9),
                    AddShop(32 + 10),
                    AddShop(32 + 11),
                    AddShop(32 + 12),
                    AddShop(32 + 13),
                    AddShop(32 + 14),
                    AddShop(32 + 15),
                    AddShop(32 + 16),
                    AddShop(32 + 17),
                    AddShop(32 + 18),
                    AddShop(32 + 19),
                    AddShop(32 + 20),
                    AddShop(32 + 21),
                    AddShop(32 + 22),
                    AddShop(32 + 23),
                    AddShop(32 + 24),
                    AddShop(32 + 25),
                    AddShop(32 + 26),
                    AddShop(32 + 27),
                    AddShop(32 + 28),
                    AddShop(32 + 29),
                    AddShop(32 + 30),
                    AddShop(32 + 31),
                LayoutEnd,
                AddVLayout,
                    AddShop(64 +  0),
                    AddShop(64 +  1),
                    AddShop(64 +  2),
                    AddShop(64 +  3),
                    AddShop(64 +  4),
                    AddShop(64 +  5),
                    AddShop(64 +  6),
                    AddShop(64 +  7),
                    AddShop(64 +  8),
                    AddShop(64 +  9),
                    AddShop(64 + 10),
                    AddShop(64 + 11),
                    AddShop(64 + 12),
                    AddShop(64 + 13),
                    AddShop(64 + 14),
                    AddShop(64 + 15),
                    AddShop(64 + 16),
                    AddShop(64 + 17),
                    AddShop(64 + 18),
                    AddShop(64 + 19),
                    AddShop(64 + 20),
                    AddShop(64 + 21),
                    AddShop(64 + 22),
                    AddShop(64 + 23),
                    AddShop(64 + 24),
                    AddShop(64 + 25),
                    AddShop(64 + 26),
                    AddShop(64 + 27),
                    AddShop(64 + 28),
                    AddShop(64 + 29),
                    AddShop(64 + 30),
                    AddShop(64 + 31),
                LayoutEnd,
                AddVLayout,
                    AddShop(96 +  0),
                    AddShop(96 +  1),
                    AddShop(96 +  2),
                    AddShop(96 +  3),
                    AddShop(96 +  4),
                    AddShop(96 +  5),
                    AddShop(96 +  6),
                    AddShop(96 +  7),
                    AddShop(96 +  8),
                    AddShop(96 +  9),
                    AddShop(96 + 10),
                    AddShop(96 + 11),
                    AddShop(96 + 12),
                    AddShop(96 + 13),
                    AddShop(96 + 14),
                    AddShop(96 + 15),
                    AddShop(96 + 16),
                    AddShop(96 + 17),
                    AddShop(96 + 18),
                    AddShop(96 + 19),
                    AddShop(96 + 20),
                    AddShop(96 + 21),
                    AddShop(96 + 22),
                    AddShop(96 + 23),
                    AddShop(96 + 24),
                    AddShop(96 + 25),
                    AddShop(96 + 26),
                    AddShop(96 + 27),
                    AddShop(96 + 28),
                    AddShop(96 + 29),
                    AddShop(96 + 30),
                    AddShop(96 + 31),
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubWindowPtr->Width, SubWindowPtr->Height);
#endif

    DISCARD ActivateLayoutGadget(gadgets[GID_BT_LY4], SubWindowPtr, NULL, (Object) gadgets[GID_BT_IN63]);

    subloop();

    for (i = 1; i <= 127; i++)
    {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_BT_IN63 + i - 1], (ULONG*) &garth[i]);
    }

    leftx  = SubWindowPtr->LeftEdge;
    topy   = SubWindowPtr->TopEdge;
    width  = SubWindowPtr->Width;
    height = SubWindowPtr->Height;

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT void bt_getpens(void)
{   getclockpens();

    lockscreen();

    pens[MAZEBLACK      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1); //  0 wall
    pens[MAZEWHITE      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1); //  1 arrow
    pens[    GREEN      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xFFFFFFFF, 0x00000000, -1); //  2 tree/door
    pens[    RED        ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1); //  3 unused
    pens[    BLUE       ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0xFFFFFFFF, -1); //  4 special squares
    pens[    LIGHTGREEN ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xAAAAAAAA, 0xFFFFFFFF, 0xAAAAAAAA, -1); //  5 wilderness
    pens[    LIGHTYELLOW] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xCCCCCCCC, -1); //  6 city
    pens[    PINK       ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xCCCCCCCC, 0xCCCCCCCC, -1); //  7 dungeons
    pens[    DARKGREY   ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0x88888888, -1); //  8 darkness
    pens[    PURPLE     ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x88888888, 0xFFFFFFFF, -1); //  9 special borders

    unlockscreen();
}

EXPORT void bt_uniconify(void)
{   bt_getpens();
}

MODULE void mapwindow(void)
{   STRPTR stringptr;

    // assert(game == BT2 || game == BT3);
    // assert(filetype == FT_FLAG_S);

    make_clock(GID_BT_CL1);

    submode = SUBMODE_MAP;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    switch (game)
    {
    case BT2:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                                      "When & Where (BT2)",
            WINDOW_Position,                               WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                               "bard-4",
            WINDOW_ParentGroup,                            gadgets[GID_BT_LY132] = (struct Gadget*)
            VLayoutObject,
                AddVLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                    LAYOUT_Label,                          "Outdoor Location",
                    AddHLayout,
                        LAYOUT_HorizAlignment,             LALIGN_CENTER,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_BT_IN191] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_BT_IN191,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               (area == 0) ? 31 : 15,
                            INTEGER_MinVisible,            2 + 1,
                            INTEGER_Number,                location_x1,
                        IntegerEnd,
                        AddLabel("North:"),
                        CHILD_WeightedWidth,               0,
                        LAYOUT_AddChild,                   gadgets[GID_BT_IN192] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_BT_IN192,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               (area == 0) ? 47 : 15,
                            INTEGER_MinVisible,            2 + 1,
                            INTEGER_Number,                location_y1,
                        IntegerEnd,
                    LayoutEnd,
                    Label("East:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_BT_CH10] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_BT_CH10,
                        GA_RelVerify,                      TRUE,
                        CHOOSER_LabelArray,                &Area2Options,
                        CHOOSER_Selected,                  (WORD) area,
                    PopUpEnd,
                    Label("Area:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_BT_CH8] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_BT_CH8,
                        GA_RelVerify,                      TRUE,
                        CHOOSER_Labels,                    &FacingList1,
                        CHOOSER_Selected,                  (WORD) facing1,
                    PopUpEnd,
                    Label("Facing:"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                AddVLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                    LAYOUT_Label,                          "Dungeon Location",
                    AddHLayout,
                        LAYOUT_HorizAlignment,             LALIGN_CENTER,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_BT_IN194] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_BT_IN194,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               21,
                            INTEGER_MinVisible,            2 + 1,
                            INTEGER_Number,                location_x2,
                        IntegerEnd,
                        AddLabel("North:"),
                        CHILD_WeightedWidth,               0,
                        LAYOUT_AddChild,                   gadgets[GID_BT_IN195] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_BT_IN195,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               21,
                            INTEGER_MinVisible,            2 + 1,
                            INTEGER_Number,                location_y2,
                        IntegerEnd,
                    LayoutEnd,
                    Label("East:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_BT_IN193] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_BT_IN193,
                        GA_ReadOnly,                       TRUE,
                        INTEGER_Arrows,                    FALSE,
                        INTEGER_MinVisible,                1,
                        INTEGER_Number,                    dgnlevel,
                    IntegerEnd,
                    Label("Level:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_BT_ST2] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_BT_ST2,
                        GA_TabCycle,                       TRUE,
                        GA_Disabled,                       (IOBuffer[0x36B] == 4) ? FALSE : TRUE,
                        STRINGA_MaxChars,                  16 + 1,
                        STRINGA_TextVal,                   dgnname,
                    StringEnd,
                    Label("Name:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_BT_CH11] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_BT_CH11,
                        GA_RelVerify,                      TRUE,
                        CHOOSER_Labels,                    &FacingList2,
                        CHOOSER_Selected,                  (WORD) facing2,
                    PopUpEnd,
                    Label("Facing:"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_Label,                          "Time",
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
#ifndef __MORPHOS__
                    ClockBase ? LAYOUT_AddChild      : TAG_IGNORE, gadgets[GID_BT_CL1],
                    ClockBase ? CHILD_MinWidth       : TAG_IGNORE,  64,
                    ClockBase ? CHILD_MinHeight      : TAG_IGNORE,  64,
                    ClockBase ? CHILD_WeightedHeight : TAG_IGNORE, 100,
                    ClockBase ? CHILD_WeightedWidth  : TAG_IGNORE, 100,
#endif
                    LAYOUT_AddChild,                       gadgets[GID_BT_IN190] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_BT_IN190,
                        GA_TabCycle,                       TRUE,
                        GA_RelVerify,                      TRUE,
                        INTEGER_Number,                    hour,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   23,
                        INTEGER_MinVisible,                2 + 1,
                    IntegerEnd,
                    Label("Hour:"),
                    CHILD_WeightedHeight,                  0,
                    CHILD_WeightedWidth,                   0,
                LayoutEnd,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase BT3:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                                      "When & Where (BT3)",
            WINDOW_Position,                               WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                               "bard-5",
            WINDOW_ParentGroup,                            gadgets[GID_BT_LY132] = (struct Gadget*)
            VLayoutObject,
                AddVLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_Label,                          "Location",
                    AddHLayout,
                        AddSpace,
                        LAYOUT_AddChild,                   gadgets[GID_BT_SP1] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                         GID_BT_SP1,
                            SPACE_MinWidth,                SCALEDWIDTH,
                            SPACE_MinHeight,               SCALEDHEIGHT,
                            SPACE_BevelStyle,              BVS_FIELD,
                            SPACE_Transparent,             TRUE,
                        SpaceEnd,
                        CHILD_WeightedWidth,               0,
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
                    AddHLayout,
                        LAYOUT_HorizAlignment,             LALIGN_CENTER,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_BT_IN191] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_BT_IN191,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               MAPWIDTH - 1,
                            INTEGER_MinVisible,            2 + 1,
                            INTEGER_Number,                location_x1,
                        IntegerEnd,
                        AddLabel("N:"),
                        CHILD_WeightedWidth,               0,
                        LAYOUT_AddChild,                   gadgets[GID_BT_IN192] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_BT_IN192,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               MAPHEIGHT - 1,
                            INTEGER_MinVisible,            2 + 1,
                            INTEGER_Number,                location_y1,
                        IntegerEnd,
                    LayoutEnd,
                    Label("E:"),
                    LAYOUT_AddChild,                       gadgets[GID_BT_CH9] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_BT_CH9,
                        GA_RelVerify,                      TRUE,
                        CHOOSER_LabelArray,                &PlaneOptions,
                        CHOOSER_Selected,                  (WORD) plane,
                    PopUpEnd,
                    Label("Plane:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_BT_CH10] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_BT_CH10,
                        GA_RelVerify,                      TRUE,
                        CHOOSER_MaxLabels,                 17,
                        CHOOSER_LabelArray,                &Area3Options[plane],
                        CHOOSER_Selected,                  (WORD) area,
                    PopUpEnd,
                    Label("Area:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_BT_CH8] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_BT_CH8,
                        GA_RelVerify,                      TRUE,
                        CHOOSER_Labels,                    &FacingList1,
                        CHOOSER_Selected,                  (WORD) facing1,
                    PopUpEnd,
                    Label("Facing:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_BT_BU24] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_BT_BU24,
                        GA_RelVerify,                      TRUE,
                        GA_Text,                           "_Hint Oracle...",
                    ButtonEnd,
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_Label,                          "Time",
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
#ifndef __MORPHOS__
                    ClockBase ? LAYOUT_AddChild      : TAG_IGNORE, gadgets[GID_BT_CL1],
                    ClockBase ? CHILD_MinWidth       : TAG_IGNORE,  64,
                    ClockBase ? CHILD_MinHeight      : TAG_IGNORE,  64,
                    ClockBase ? CHILD_WeightedHeight : TAG_IGNORE, 100,
                    ClockBase ? CHILD_WeightedWidth  : TAG_IGNORE, 100,
#endif
                    LAYOUT_AddChild,                       gadgets[GID_BT_IN190] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_BT_IN190,
                        GA_TabCycle,                       TRUE,
                        GA_RelVerify,                      TRUE,
                        INTEGER_Number,                    hour,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   23,
                        INTEGER_MinVisible,                2 + 1,
                    IntegerEnd,
                    Label("Hour:"),
                    CHILD_WeightedHeight,                  0,
                    CHILD_WeightedWidth,                   0,
                LayoutEnd,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
    }   }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    if (game == BT3)
    {   setup_bm(0, SCALEDWIDTH, SCALEDHEIGHT, MainWindowPtr);

        bt_drawmap();
    }

#ifndef __MORPHOS__
    if (ClockBase)
    {   DISCARD SetGadgetAttrs(gadgets[GID_BT_CL1], SubWindowPtr, NULL, CLOCKGA_Time, hour * 60 * 60, TAG_END); // autorefreshes
    }
#endif

    subloop();

    if (game == BT2)
    {   GetAttr(STRINGA_TextVal, (Object*) gadgets[GID_BT_ST2], (ULONG*) &stringptr);
        strcpy(dgnname, stringptr);
    }

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;

    if (game == BT3)
    {   free_bm(0);
}   }

EXPORT void bt_drawmap(void)
{   int bgc,
        x, y;

    // assert(game == BT3);

    switch (plane)
    {
    case  0:  whichmap = area;      // Realm      ( 0.. 7)
    acase 1:  whichmap = area +  8; // Arboria    ( 8..17)
    acase 2:  whichmap = area + 18; // Gelidia    (18..34)
    acase 3:  whichmap = area + 35; // Lucencia   (35..43)
    acase 4:  whichmap = area + 44; // Kinestia   (44..50)
    acase 5:  whichmap = area + 51; // Tenebrosia (51..57)
    acase 6:  whichmap = area + 58; // Tarmitia   (58..66)
    acase 7:  whichmap = area + 67; // Malefia    (67..70)
    adefault: whichmap = 0; // should never happen
    }
    xoffset = (SCALEDWIDTH  - (sizes[whichmap].x * scalex) - 1) / 2;
    yoffset = (SCALEDHEIGHT - (sizes[whichmap].y * scaley) - 1) / 2;

    if
    (   (plane == 0 && area == 0) // Realm wilderness
     || (plane == 1 && area == 0) // Arborian wilderness
     || (plane == 2 && area == 0) // Gelidian wilderness
     || (plane == 3 && area == 0) // Lucencian wilderness
     || (plane == 5 && area == 0) // Nowhere aka Tenebrosian wilderness
     || (plane == 5 && area == 1) // Dark Copse
    )
    {   bgc = LIGHTGREEN;
    } elif
    (   (plane == 0 && area == 1) // Skara Brae
     || (plane == 1 && area == 1) // Ciera Brannia
     || (plane == 3 && area == 1) // Celaria Bree
     || (plane == 5 && area == 2) // Black Scar
    )
    {   bgc = LIGHTYELLOW;
    } else
    {   bgc = PINK;
    }

    for (y = 0; y < SCALEDHEIGHT; y++)
    {   for (x = 0; x < SCALEDWIDTH; x++)
        {   *(byteptr1[y] + x) = pens[MAZEWHITE];
    }   }

    for (y = 0; y <= (sizes[whichmap].y * scaley); y++)
    {   for (x = 0; x <= (sizes[whichmap].x * scalex); x++)
        {   *(byteptr1[yoffset + y] + xoffset + x) = pens[bgc];
    }   }

    for (y = MAPHEIGHT - sizes[whichmap].y; y < MAPHEIGHT; y++)
    {   for (x = 0; x < sizes[whichmap].x; x++)
        {   switch (bt3_map[whichmap][(y * 2) + 1][(x * 2) + 1])
            {
            case  '/': drawsquare(  x, y,    DARKGREY);
            acase 'u': drawtriangle(x, y, 0, MAZEBLACK);
            acase 'd': drawtriangle(x, y, 2, MAZEBLACK);
            acase '^': drawsquare(  x, y,    GREEN);
            acase '*': drawcircle(  x, y);
            acase ' ': ;
            adefault : drawsquare(  x, y,    BLUE);
    }   }   }

    // black dots
    for (y = MAPHEIGHT - sizes[whichmap].y; y <= MAPHEIGHT; y++)
    {   for (x = 0; x <= sizes[whichmap].x; x++)
        {   *(byteptr1[(y * scaley) - yoffset] + xoffset + (x * scalex)) = pens[MAZEBLACK];
    }   }

    for (y = MAPHEIGHT - sizes[whichmap].y; y <= MAPHEIGHT; y++)
    {   for (x = 0; x <= sizes[whichmap].x; x++)
        {   if (x < sizes[whichmap].x)
            {   switch (bt3_map[whichmap][ y * 2     ][(x * 2) + 1])
                {
                case  '-': drawhoriz(x, y, MAZEBLACK, MAPHEIGHT, FALSE);
                acase '=': drawhoriz(x, y, GREEN,     MAPHEIGHT, TRUE);
                acase '@': drawhoriz(x, y, RED,       MAPHEIGHT, FALSE);
                acase ' ': ;
                adefault : drawhoriz(x, y, PURPLE,    MAPHEIGHT, FALSE);
            }   }

            if (y < MAPHEIGHT)
            {   switch (bt3_map[whichmap][(y * 2) + 1][ x * 2     ])
                {
                case  '|': drawvert( x, y, MAZEBLACK, MAPWIDTH, FALSE);
                acase '=': drawvert( x, y, GREEN,     MAPWIDTH, TRUE);
                acase '@': drawvert( x, y, RED,       MAPWIDTH, FALSE);
                acase ' ': ;
                adefault : drawvert( x, y, PURPLE,    MAPWIDTH, FALSE);
    }   }   }   }

    if (location_x1 < sizes[whichmap].x && location_y1 < sizes[whichmap].y)
    {   drawarrow(location_x1, MAPHEIGHT - 1 - location_y1, facing1);
    }

    DISCARD WritePixelArray8
    (   SubWindowPtr->RPort,
        gadgets[GID_BT_SP1]->LeftEdge,
        gadgets[GID_BT_SP1]->TopEdge,
        gadgets[GID_BT_SP1]->LeftEdge + SCALEDWIDTH  - 1,
        gadgets[GID_BT_SP1]->TopEdge  + SCALEDHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );

    SetGadgetAttrs
    (   gadgets[GID_BT_BU24], SubWindowPtr, NULL,
        GA_Disabled, (oracle[whichmap][0] == EOS) ? TRUE : FALSE,
    TAG_END);
}

EXPORT void bt_sublmb(SWORD mousex, SWORD mousey)
{   ULONG x, y;

    if
    (   submode != SUBMODE_MAP
     || mousex < gadgets[GID_BT_SP1]->LeftEdge
     || mousey < gadgets[GID_BT_SP1]->TopEdge
     || mousex > gadgets[GID_BT_SP1]->LeftEdge + SCALEDWIDTH  - 1
     || mousey > gadgets[GID_BT_SP1]->TopEdge  + SCALEDHEIGHT - 1
    )
    {   return;
    }

    x = (mousex - xoffset - gadgets[GID_BT_SP1]->LeftEdge) / scalex;
    y = (mousey + yoffset - gadgets[GID_BT_SP1]->TopEdge ) / scaley;
    y = MAPHEIGHT - 1 - y;
    if (x < sizes[whichmap].x && y < sizes[whichmap].y)
    {   location_x1 = x;
        location_y1 = y;
        SetGadgetAttrs(gadgets[GID_BT_IN191], SubWindowPtr, NULL, INTEGER_Number, location_x1, TAG_END); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_BT_IN192], SubWindowPtr, NULL, INTEGER_Number, location_y1, TAG_END); // this autorefreshes
        bt_drawmap();
}   }

MODULE void drawcircle(int x, int y)
{/* 0         1
    0123456789012
    .............  0
    .............  1
    .............  2
    .............  3
    .....###.....  4
    ....#...#....  5
    ....#. .#....  6
    ....#...#....  7
    .....###.....  8
    .............  9
    ............. 10
    ............. 11
    ............. 12 */

    *(byteptr1[(y * scaley) - yoffset + 4] + (x * scalex) + xoffset + 5) =
    *(byteptr1[(y * scaley) - yoffset + 4] + (x * scalex) + xoffset + 6) =
    *(byteptr1[(y * scaley) - yoffset + 4] + (x * scalex) + xoffset + 7) =
    *(byteptr1[(y * scaley) - yoffset + 5] + (x * scalex) + xoffset + 4) =
    *(byteptr1[(y * scaley) - yoffset + 5] + (x * scalex) + xoffset + 8) =
    *(byteptr1[(y * scaley) - yoffset + 6] + (x * scalex) + xoffset + 4) =
    *(byteptr1[(y * scaley) - yoffset + 6] + (x * scalex) + xoffset + 8) =
    *(byteptr1[(y * scaley) - yoffset + 7] + (x * scalex) + xoffset + 4) =
    *(byteptr1[(y * scaley) - yoffset + 7] + (x * scalex) + xoffset + 8) =
    *(byteptr1[(y * scaley) - yoffset + 8] + (x * scalex) + xoffset + 5) =
    *(byteptr1[(y * scaley) - yoffset + 8] + (x * scalex) + xoffset + 6) =
    *(byteptr1[(y * scaley) - yoffset + 8] + (x * scalex) + xoffset + 7) = pens[MAZEBLACK];
}

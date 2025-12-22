// 1. INCLUDES -----------------------------------------------------------

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

// 2. DEFINES ------------------------------------------------------------

// #define LOGSERIALIZATION
// whether you want to be told more about loading and saving

// main window
#define GID_DM_LY1     0 // root layout
#define GID_DM_SB1     1 // toolbar
#define GID_DM_CH1     2 // game
#define GID_DM_CH2     3 // facing
#define GID_DM_CH3     4 // kind
#define GID_DM_SP1     5 // map
#define GID_DM_SP2     6 // tiles
#define GID_DM_SL1     7 // dungeon level
#define GID_DM_IN80    8 // dungeon level
#define GID_DM_IN81    9 // dungeon levels
#define GID_DM_BU2    10 // maximize party
#define GID_DM_BU3    11 // 1st man
#define GID_DM_BU4    12 // 2nd man
#define GID_DM_BU5    13 // 3rd man
#define GID_DM_BU6    14 // 4th man
#define GID_DM_ST33   15 // square contents
#define GID_DM_ST34   16

// man subwindow (top)
#define GID_DM_LY2    17
#define GID_DM_ST1    18 // name
#define GID_DM_ST2    19 // title
#define GID_DM_BU1    20 // maximize character
#define GID_DM_IN1    21 // cur HP
#define GID_DM_IN2    22 // max HP
#define GID_DM_IN3    23 // cur stamina
#define GID_DM_IN4    24 // max stamina
#define GID_DM_IN5    25 // cur mana
#define GID_DM_IN6    26 // max mana
#define GID_DM_IN7    27 // min luck
#define GID_DM_IN8    28 // cur luck
#define GID_DM_IN9    29 // max luck
#define GID_DM_IN10   30 // min str
#define GID_DM_IN11   31 // cur str
#define GID_DM_IN12   32 // max str
#define GID_DM_IN13   33 // min dex
#define GID_DM_IN14   34 // cur dex
#define GID_DM_IN15   35 // max dex
#define GID_DM_IN16   36 // min wis
#define GID_DM_IN17   37 // cur wis
#define GID_DM_IN18   38 // max wis
#define GID_DM_IN19   39 // min vit
#define GID_DM_IN20   40 // cur vit
#define GID_DM_IN21   41 // max vit
#define GID_DM_IN22   42 // min anti-magic
#define GID_DM_IN23   43 // cur anti-magic
#define GID_DM_IN24   44 // max anti-magic
#define GID_DM_IN25   45 // min anti-fire
#define GID_DM_IN26   46 // cur anti-fire
#define GID_DM_IN27   47 // max anti-fire
#define GID_DM_IN28   48 // food
#define GID_DM_IN29   49 // water
#define GID_DM_IN30   50 // fighter
#define GID_DM_IN31   51 // ninja
#define GID_DM_IN32   52 // priest
#define GID_DM_IN33   53 // wizard
#define GID_DM_IN34   54
#define GID_DM_IN35   55
#define GID_DM_IN36   56
#define GID_DM_IN37   57
#define GID_DM_IN38   58
#define GID_DM_IN39   59
#define GID_DM_IN40   60
#define GID_DM_IN41   61
#define GID_DM_IN42   62
#define GID_DM_IN43   63
#define GID_DM_IN44   64
#define GID_DM_IN45   65
#define GID_DM_IN46   66
#define GID_DM_IN47   67
#define GID_DM_IN48   68
#define GID_DM_IN49   69

// man subwindow (bottom)
#define GID_DM_LY3    70
#define GID_DM_IN50   71 //  1st item
#define GID_DM_IN79  100 // 30th item
#define GID_DM_ST3   101 //  1st item
#define GID_DM_ST32  130 // 30th item
#define GID_DM_IN82  131 //  1st bonus
#define GID_DM_IN83  132 //  2nd bonus
#define GID_DM_IN84  133 //  3rd bonus
#define GID_DM_IN85  134 //  4th bonus
#define GID_DM_IN86  135 //  5th bonus
#define GID_DM_IN87  136 //  6th bonus
#define GID_DM_IN88  137 //  7th bonus
#define GID_DM_IN89  138 //  8th bonus
#define GID_DM_IN90  139 //  9th bonus
#define GID_DM_IN91  140 // 10th bonus
#define GID_DM_IN92  141 // 11th bonus
#define GID_DM_IN93  142 // 12th bonus
#define GID_DM_IN94  143 // 13th bonus
#define GID_DM_IN95  144 // 14th bonus
#define GID_DM_IN96  145 // 15th bonus
#define GID_DM_IN97  146 // 16th bonus
#define GID_DM_IN98  147 // 17th bonus
#define GID_DM_IN99  148 // 18th bonus
#define GID_DM_IN100 149 // 19th bonus
#define GID_DM_IN101 150 // 20th bonus

#define GIDS_DM      GID_DM_IN101

#define MAPWIDTH      32
#define MAPHEIGHT     32
#define MAPSCALE      12
#define SCALEDWIDTH  (MAPWIDTH  * MAPSCALE)
#define SCALEDHEIGHT (MAPHEIGHT * MAPSCALE)
#define TILESWIDTH   (11        *       24)
#define TILESHEIGHT   24

#define DM1_2X         0
#define DM1_36         1
#define DM1_APPLE      2
#define DM1_IBM        3
#define CSB            4
#define CSB_ATARI      5
#define CSB_PC9801     6
#define CSB_ENG        7
#define CSB_FRAGER     8
#define DM2            9
#define DM2_LE        10

#define KIND_DUNGEON   0
#define KIND_SAVEGAME  1

#define AddItem(a, b) \
AddHLayout, \
    LAYOUT_AddChild,        gadgets[GID_DM_IN50 + a] = (struct Gadget*) \
    IntegerObject, \
        GA_ID,              GID_DM_IN50 + a, \
        GA_TabCycle,        TRUE, \
        GA_RelVerify,       TRUE, \
        INTEGER_Minimum,    0, \
        INTEGER_Maximum,    65535, \
        INTEGER_MinVisible, 5 + 1, \
    IntegerEnd, \
    CHILD_WeightedWidth,    0, \
    LAYOUT_AddChild,        gadgets[GID_DM_ST3 + a] = (struct Gadget*) \
    StringObject, \
        GA_ID,              GID_DM_ST3 + a, \
        GA_ReadOnly,        TRUE, \
    StringEnd, \
LayoutEnd, \
Label(b)

#define AddSkill(a, b, c) \
LAYOUT_AddChild,            gadgets[              a] = (struct Gadget*) \
IntegerObject, \
    GA_ID,                  a, \
    GA_TabCycle,            TRUE, \
    INTEGER_Minimum,        0, \
    INTEGER_Maximum,        999999999, \
    INTEGER_Number,         level[who][c], \
IntegerEnd, \
Label(b)

#define AddBonus(a, b, c) \
LAYOUT_AddChild,            gadgets[              a] = (struct Gadget*) \
IntegerObject, \
    GA_ID,                  a, \
    GA_TabCycle,            TRUE, \
    INTEGER_Minimum,        0, \
    INTEGER_Maximum,        255, \
    INTEGER_Number,         bonus[who][c], \
IntegerEnd, \
Label(b)

MODULE struct
{   FLAG   header,
           littleendian,
           portraits;
    int    keyoffset,
           champsize,
           timersize;
} formats[] = {
//header endian portrt key champsize time
{ FALSE, FALSE, TRUE , 10, 3328 / 2, 10 },
{ FALSE, FALSE, FALSE, 10, 1408 / 2, 10 },
{ FALSE, TRUE , TRUE , 10, 3324 / 2, 16 },
{ FALSE, TRUE , FALSE, 10, 1404 / 2, 10 },
{ FALSE, FALSE, FALSE, 29, 1408 / 2, 10 },
{ FALSE, FALSE, TRUE , 29, 3328 / 2, 10 },
{ FALSE, TRUE , FALSE, 29, 1404 / 2, 10 },
{ FALSE, FALSE, FALSE, 29, 1408 / 2, 10 },
{ TRUE , FALSE, FALSE, 29, 1408 / 2, 10 },
{ FALSE, FALSE, FALSE,  0,        0,  0 },
{ FALSE, TRUE , FALSE,  0,        0,  0 },
};

MODULE const STRPTR GameOptions[] =
{ "DM1 Amiga (V2.x)/Atari ST",
  "DM1 Amiga (V3.6)/X68000",
  "DM1 Apple ][GS",
  "DM1 MS-DOS/PC-9801/FM Towns",
  "CSB Amiga/X68000",
  "CSB Atari ST",
  "CSB PC-9801/FM Towns",
  "CSB Utility (English RX)",
  "CSB Utility (Eng/Fra/Ger)",
  "DM2 (big-endian)",
  "DM2 (little-endian)",
  NULL
}, KindOptions[2 + 1] =
{ "Dungeon",
  "Saved game",
  NULL
}, DM1DungeonName[14] =
{ "1st level",           //  0
  "2nd level",
  "3rd level",
  "4th level",
  "5th level",
  "6th level",
  "7th level",
  "8th level",
  "9th level",
  "10th level",
  "11th level",
  "12th level",
  "13th level",
  "14th level",
}, DM2DungeonName[44] =
{ "7th level southwest", //  0
  "1st level",
  "2nd level north",
  "2nd level south",
  "3rd level north",
  "3rd level south",
  "4th level north",
  "4th level south",
  "5th level north",
  "5th level south",
  "6th level interior",  // 10
  "6th level interior",
  "7th level west",
  "8th level",
  "6th level exterior",
  "6th level exterior",
  "6th level exterior",
  "6th level interior",
  "6th level interior",
  "6th level interior",
  "7th level northeast", // 20
  "7th level north",
  "6th level interior",
  "6th level interior",
  "6th level interior",
  "6th level interior",
  "6th level interior",
  "6th level interior",
  "6th level interior",
  "6th level exterior",
  "6th level exterior",  // 30
  "6th level interior",
  "6th level interior",
  "6th level exterior",
  "6th level interior",
  "7th level northwest",
  "7th level south",
  "6th level interior",
  "10th level",
  "6th level exterior",
  "7th level east",      // 40
  "6th level exterior",
  "6th level exterior",
  "6th level interior",  // 43
}; 

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void maximize_man(int whichman);
MODULE void eithergadgets(void);
MODULE FLAG DecodeSavedGame(void);
MODULE UWORD dm1_decrypt(UWORD* section, ULONG Key, ULONG NumberOfWords);
MODULE UWORD dm1_encrypt(UWORD* section, ULONG Key, ULONG NumberOfWords);
MODULE void writeitemgad(int whichitem);
MODULE void drawtile(int x, int y, int whichtile);
MODULE UBYTE getsquare(int x, int y);
MODULE void manwindow(void);
MODULE void readman(void);
MODULE void writeman(void);
MODULE void updatetiles(void);
MODULE void stampit(SWORD mousex, SWORD mousey);
MODULE void parse_dungeon(void);
MODULE void doword(UWORD* thevar);
MODULE void dolong(ULONG* thevar);
MODULE UBYTE readbits(int howmany);
MODULE void dm2_loadgame(void);
MODULE void dm2_savegame(void);
MODULE void dm2_decrypt(UBYTE* data, const UBYTE* mask, int buffSize, int repeat);
MODULE void dm2_encrypt(UBYTE* data, const UBYTE* mask, int buffSize, int repeat);
#ifdef LOGSERIALIZATION
    MODULE void showchar(int which);
#endif

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra;
IMPORT LONG                 gamesize,
                            pens[PENS];
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT UBYTE               *byteptr1[DISPLAY1HEIGHT],
                           *byteptr2[DISPLAY2HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE],
                            display2[DISPLAY2SIZE];

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE FLAG                 lmb,
                            reopening = FALSE;
MODULE TEXT                 name[4][8 + 1],
                            title[4][16 + 1];
MODULE UBYTE                crypting,
                            bitpos,
                            preserve,
                            CharData[4][261],
                            FlagsData[8],
                            BytesData[64],
                            WordsData[128],
                            VarData[56];
MODULE UWORD                block1[128],
                            block2[128],
                            block1sum,
                            block3[64],
                            champdata[3328 / 2];
MODULE ULONG                bonus[4][20],
                            curhp[4],
                            curmana[4],
                            curstamina[4],
                            dgnlevel = 1,
                            food[4],
                            game,
                            item[4][30],
                            kind,
                            level[4][20],
                            maxhp[4],
                            maxmana[4],
                            maxstamina[4],
                            curstat[4][7],
                            maxstat[4][7],
                            minstat[4][7],
                            water[4];
MODULE int                  bit,
                            brushpos = 1,
                            champs,
                            choice,
                            dungeonstart,
                            facing,
                            gvb, // offset of global variable block
                            leftx,
                            loc_lvl,
                            loc_x,
                            loc_y,
                            mansize,
                            mapsize,
                            mapstart,
                            men,
                            numlevels,
                            topy,
                            who;
MODULE struct List          FacingList;
#ifndef __MORPHOS__
    IMPORT UWORD*           MouseData;
#endif

// 7. MODULE ARRAYS/STRUCTURES -------------------------------------------

MODULE UBYTE _395a[] =
{ 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x07, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x03, 0x00,
  0x3F, 0x00, 0x03, 0x00, 0xFF, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x07, 0x00,
  0x07, 0x00, 0x03, 0x00, 0x01, 0x00, 0xFF, 0x00, 0x01, 0x00, 0x01, 0x03, 0xFF, 0xFF, 0xFF, 0x03,
  0xFF, 0x00, 0x1F, 0x03, 0xFF, 0xFF, 0xFF, 0xFF
}, _3956[] =
{ 0xFF, 0xFF
}, _3992[] =
{ 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x00, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F,
  0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x00, 0x03, 0x03, 0x07, 0x00,
  0x3F, 0x3F, 0x7F, 0x7F, 0x7F, 0x7F, 0x00, 0x00, 0x03, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x12, 0x00, 0x3F, 0x00, 0xFF, 0x03, 0xFF, 0x03, 0xFF, 0x3F, 0xFF, 0x3F, 0xFF, 0x03,
  0xFF, 0x03, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0, 0xFF, 0xFF,
  0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF,
  0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF,
  0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF,
  0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF,
  0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0xFF, 0x1F, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F,
  0x0F, 0x00, 0x00, 0x00, 0x00
};

MODULE const STRPTR knowitem[][2] = {
// $0..$FF
{ "Empty flask"   , "Ra bomb"        }, // $0000
{ "Empty flask"   , "Ros potion"     }, // $0001
{ "Empty flask"   , "Des potion"     }, // $0002
{ "Empty flask"   , "Um potion"      }, // $0003
{ "Empty flask"   , "Des potion"     }, // $0004
{ "Empty flask"   , "Des potion"     }, // $0005
{ "Empty flask"   , "Ya potion"      }, // $0006
{ "Empty flask"   , "Empty flask"    }, // $0007
{ "Vi potion"     , "Tattered pants" }, // $0008
{ "Ros potion"    , "Antivenin"      }, // $0009
{ "Ful bomb"      , "Sar potion"     }, // $000A
{ "Vi potion"     , "Dane potion"    }, // $000B
{ "Vi potion"     , "Claw bow"       }, // $000C
{ "Empty flask"   , "Ya potion"      }, // $000D
{ "Ful bomb"      , "Zo potion"      }, // $000E
{ "Empty flask"   , "Cross of Neta"  }, // $000F
{ "Empty flask"   , "Neta potion"    }, // $0010
{ "Empty flask"   , "Des potion"     }, // $0011
{ "Water flask"   , "Ya potion"      }, // $0012
{ "Ku potion"     , "Des potion"     }, // $0013
{ "Dane potion"   , "Mon potion"     }, // $0014
{ "Empty flask"   , "Fine robe (top)"}, // $0015
{ "Neta potion"   , "Antivenin"      }, // $0016
{ "Vi potion"     , "Empty flask"    }, // $0017
{ "Ful bomb"      , "Sar potion"     }, // $0018
{ "Empty flask"   , "Sar potion"     }, // $0019
{ "Ya potion"     , "Dane potion"    }, // $001A
{ "Vi potion"     , "Storm"          }, // $001B
{ "Ful bomb"      , "Dane potion"    }, // $001C
{ "Ven potion"    , "Yew staff"      }, // $001D
{ "Ful bomb"      , "Slayer"         }, // $001E
{ "Ven potion"    , "Pew bomb"       }, // $001F
{ "Ven potion"    , "Ra bomb"        }, // $0020
{ "Ven potion"    , "Staff of Claws" }, // $0021
{ "Ful bomb"      , "Mon potion"     }, // $0022
{ "Bro potion"    , "Elven doublet"  }, // $0023
{ "Ven potion"    , "The Firestaff"  }, // $0024
{ "Des potion"    , "Flamitt"        }, // $0025
{ "Ful bomb"      , "Antivenin"      }, // $0026
{ "Ful bomb"      , "Antivenin"      }, // $0027
{ "Empty flask"   , "Antivenin"      }, // $0028
{ "Bro potion"    , "Dane potion"    }, // $0029
{ "Ful bomb"      , "Storm"          }, // $002A
{ "Water flask"   , "Dane potion"    }, // $002B
{ "Ful bomb"      , "Sar potion"     }, // $002C
{ "Ven potion"    , "Mon potion"     }, // $002D
{ "Water flask"   , "Mon potion"     }, // $002E
{ "Ya potion"     , "Ra bomb"        }, // $002F
{ "Ya potion"     , "Kirtle"         }, // $0030
{ "Empty flask"   , "Ros potion"     }, // $0031
{ "Ful bomb"      , "Ya potion"      }, // $0032
{ "Ven potion"    , "Crystal shield" }, // $0033
{ "Ful bomb"      , "Staff of Irra"  }, // $0034
{ "Ven potion"    , "Flamitt"        }, // $0035
{ "Water flask"   , "Morning star"   }, // $0036
{ "Ya potion"     , "Dane potion"    }, // $0037
{ "Mon potion"    , "Powertowers"    }, // $0038
{ "Mon potion"    , "Sar potion"     }, // $0039
{ "Mon potion"    , "Dane potion"    }, // $003A
{ "Mon potion"    , "Mon potion"     }, // $003B
{ "Mon potion"    , "Dane potion"    }, // $003C
{ "Sar potion"    , "Mace of Order"  }, // $003D
{ "Sar potion"    , "Powertowers"    }, // $003E
{ "Sar potion"    , "Elven huke"     }, // $003F
{ "Sar potion"    , "Neta potion"    }, // $0040
{ "Sar potion"    , "The Firestaff"  }, // $0041
{ "Sar potion"    , "Ya potion"      }, // $0042
{ "Sar potion"    , "Ya potion"      }, // $0043
{ "Sar potion"    , "Rapier"         }, // $0044
{ "Sar potion"    , "Dane potion"    }, // $0045
{ "Sar potion"    , "Morning star"   }, // $0046
{ "Sar potion"    , "Dane potion"    }, // $0047
{ "Sar potion"    , "Antivenin"      }, // $0048
{ "Sar potion"    , "Rapier"         }, // $0049
{ "Sar potion"    , "Rapier"         }, // $004A
{ "Sar potion"    , "Mon potion"     }, // $004B
{ "Sar potion"    , "Dane potion"    }, // $004C
{ "Sar potion"    , "Kath bomb"      }, // $004D
{ "Sar potion"    , "Pew bomb"       }, // $004E
{ "Sar potion"    , "Crystal shield" }, // $004F
{ "Sar potion"    , "Ya potion"      }, // $0050
{ "Sar potion"    , "Slayer"         }, // $0051
{ "Sar potion"    , "Um potion"      }, // $0052
{ "Sar potion"    , "Mon potion"     }, // $0053
{ "Sar potion"    , "Diamond Edge"   }, // $0054
{ "Sar potion"    , "Antivenin"      }, // $0055
{ "Sar potion"    , "Diamond Edge"   }, // $0056
{ "Sar potion"    , "Throwing star"  }, // $0057
{ "Sar potion"    , "Water flask"    }, // $0058
{ "Sar potion"    , "Dane potion"    }, // $0059
{ "Sar potion"    , "Dragon poleyn"  }, // $005A
{ "Sar potion"    , "Ee potion"      }, // $005B
{ "Sar potion"    , "Um potion"      }, // $005C
{ "Sar potion"    , "Mon potion"     }, // $005D
{ "Sar potion"    , "The Firestaff"  }, // $005E
{ "Sar potion"    , "Mon potion"     }, // $005F
{ "Mon potion"    , "Water flask"    }, // $0060
{ "Mon potion"    , "Calista"        }, // $0061
{ "Mon potion"    , "Throwing star"  }, // $0062
{ "Mon potion"    , "Dane potion"    }, // $0063
{ "Mon potion"    , "Dane potion"    }, // $0064
{ "Mon potion"    , "Eye of Time"    }, // $0065
{ "Mon potion"    , "Mon potion"     }, // $0066
{ "Mon potion"    , "Ya potion"      }, // $0067
{ "Mon potion"    , "Ya potion"      }, // $0068
{ "Mon potion"    , "Des potion"     }, // $0069
{ "Mon potion"    , "Neta potion"    }, // $006A
{ "Mon potion"    , "Des potion"     }, // $006B
{ "Mon potion"    , "Biter"          }, // $006C
{ "Mon potion"    , "Pew bomb"       }, // $006D
{ "Mon potion"    , "Sar potion"     }, // $006E
{ "Mon potion"    , "Dane potion"    }, // $006F
{ "Mon potion"    , "Powertowers"    }, // $0070
{ "Mon potion"    , "Dane potion"    }, // $0071
{ "Mon potion"    , "Vorpal Blade"   }, // $0072
{ "Mon potion"    , "Crossbow"       }, // $0073
{ "Mon potion"    , "Pew bomb"       }, // $0074
{ "Mon potion"    , "Biter"          }, // $0075
{ "Mon potion"    , "Ya potion"      }, // $0076
{ "Mon potion"    , "Neta potion"    }, // $0077
{ "Mon potion"    , "Arrow"          }, // $0078
{ "Mon potion"    , "Des potion"     }, // $0079
{ "Mon potion"    , "Um potion"      }, // $007A
{ "Mon potion"    , "Mace of Order"  }, // $007B
{ "Mon potion"    , "Dane potion"    }, // $007C
{ "Mon potion"    , "Empty flask"    }, // $007D
{ "Mon potion"    , "Dane potion"    }, // $007E
{ "Mon potion"    , "Club"           }, // $007F
{ "Mon potion"    , "Mon potion"     }, // $0080
{ "Mon potion"    , "Horn of Fear"   }, // $0081
{ "Mon potion"    , "Des potion"     }, // $0082
{ "Mon potion"    , "Ya potion"      }, // $0083
{ "Mon potion"    , "Slayer"         }, // $0084
{ "Mon potion"    , "Des potion"     }, // $0085
{ "Mon potion"    , "Biter"          }, // $0086
{ "Mon potion"    , "Rapier"         }, // $0087
{ "Mon potion"    , "Sar potion"     }, // $0088
{ "Mon potion"    , "Tattered pants" }, // $0089
{ "Mon potion"    , "Diamond Edge"   }, // $008A
{ "Mon potion"    , "Crystal shield" }, // $008B
{ "Mon potion"    , "Staff"          }, // $008C
{ "Mon potion"    , "Dagger"         }, // $008D
{ "Mon potion"    , "Zo potion"      }, // $008E
{ "Mon potion"    , "Pew bomb"       }, // $008F
{ "Mon potion"    , "Biter"          }, // $0090
{ "Mon potion"    , "Ya potion"      }, // $0091
{ "Mon potion"    , "Samurai sword"  }, // $0092
{ "Mon potion"    , "Kath bomb"      }, // $0093
{ "Mon potion"    , "Poleyn of Ra"   }, // $0094
{ "Mon potion"    , "Pew bomb"       }, // $0095
{ "Mon potion"    , "Neta potion"    }, // $0096
{ "Mon potion"    , "Dane potion"    }, // $0097
{ "Mon potion"    , "Empty flask"    }, // $0098
{ "Mon potion"    , "Elven doublet"  }, // $0099
{ "Mon potion"    , "The Firestaff"  }, // $009A
{ "Mon potion"    , "Mace"           }, // $009B
{ "Mon potion"    , "Ya potion"      }, // $009C
{ "Mon potion"    , "Um potion"      }, // $009D
{ "Mon potion"    , "Kirtle"         }, // $009E
{ "Mon potion"    , "Club"           }, // $009F
{ "Mon potion"    , "Arrow"          }, // $00A0
{ "Mon potion"    , "Des potion"     }, // $00A1
{ "Mon potion"    , "Yew staff"      }, // $00A2
{ "Mon potion"    , "Dane potion"    }, // $00A3
{ "Mon potion"    , "Cloak of Night" }, // $00A4
{ "Mon potion"    , "Horn of Fear"   }, // $00A5
{ "Mon potion"    , "Flamitt"        }, // $00A6
{ "Mon potion"    , "Mon potion"     }, // $00A7
{ "Mon potion"    , "Mon potion"     }, // $00A8
{ "Mon potion"    , "The Firestaff"  }, // $00A9
{ "Mon potion"    , "Horn of Fear"   }, // $00AA
{ "Mon potion"    , "Um potion"      }, // $00AB
{ "Mon potion"    , "Pew bomb"       }, // $00AC
{ "Mon potion"    , "Slayer"         }, // $00AD
{ "Mon potion"    , "Rapier"         }, // $00AE
{ "Mon potion"    , "Boots of Speed" }, // $00AF
{ "Mon potion"    , "Yew staff"      }, // $00B0
{ "Mon potion"    , "Neta potion"    }, // $00B1
{ "Mon potion"    , "Throwing star"  }, // $00B2
{ "Mon potion"    , "Zo potion"      }, // $00B3
{ "Mon potion"    , "Cross of Neta"  }, // $00B4
{ "Mon potion"    , "Pew bomb"       }, // $00B5
{ "Mon potion"    , "Crystal shield" }, // $00B6
{ "Mon potion"    , "Greave of Ra"   }, // $00B7
{ "Mon potion"    , "Ya potion"      }, // $00B8
{ "Mon potion"    , "Kath bomb"      }, // $00B9
{ "Mon potion"    , "Mon potion"     }, // $00BA
{ "Mon potion"    , "Calista"        }, // $00BB
{ "Mon potion"    , "Flamitt"        }, // $00BC
{ "Mon potion"    , "Dane potion"    }, // $00BD
{ "Mon potion"    , "Mon potion"     }, // $00BE
{ "Mon potion"    , "Kath bomb"      }, // $00BF
{ "Mon potion"    , "Teowand"        }, // $00C0
{ "Mon potion"    , "Kath bomb"      }, // $00C1
{ "Mon potion"    , "Mon potion"     }, // $00C2
{ "Mon potion"    , "Club"           }, // $00C3
{ "Mon potion"    , "Mon potion"     }, // $00C4
{ "Mon potion"    , "Arrow"          }, // $00C5
{ "Mon potion"    , "Ya potion"      }, // $00C6
{ "Mon potion"    , "Vorpal Blade"   }, // $00C7
{ "Mon potion"    , "Poison dart"    }, // $00C8
{ "Mon potion"    , "Rapider"        }, // $00C9
{ "Mon potion"    , "Zo potion"      }, // $00CA
{ "Mon potion"    , "Zo potion"      }, // $00CB
{ "Mon potion"    , "Ya potion"      }, // $00CC
{ "Mon potion"    , "The Firestaff"  }, // $00CD
{ "Mon potion"    , "Ros potion"     }, // $00CE
{ "Mon potion"    , "Mon potion"     }, // $00CF
{ "Mon potion"    , "Arrow"          }, // $00D0
{ "Mon potion"    , "Dane potion"    }, // $00D1
{ "Mon potion"    , "Wand"           }, // $00D2
{ "Mon potion"    , "Flamitt"        }, // $00D3
{ "Mon potion"    , "Ya potion"      }, // $00D4
{ "Mon potion"    , "Um potion"      }, // $00D5
{ "Mon potion"    , "Poleyn of Ra"   }, // $00D6
{ "Mon potion"    , "Rapier"         }, // $00D7
{ "Mon potion"    , "Bezerker helm"  }, // $00D8
{ "Mon potion"    , "Dane potion"    }, // $00D9
{ "Mon potion"    , "Flamitt"        }, // $00DA
{ "Mon potion"    , "Dane potion"    }, // $00DB
{ "Mon potion"    , "Diamond Edge"   }, // $00DC
{ "Mon potion"    , "Arrow"          }, // $00DD
{ "Mon potion"    , "Neta potion"    }, // $00DE
{ "Mon potion"    , "Pew bomb"       }, // $00DF
{ "Mon potion"    , "Um potion"      }, // $00E0
{ "Mon potion"    , "Jewel Symal"    }, // $00E1
{ "Mon potion"    , "Mon potion"     }, // $00E2
{ "Mon potion"    , "Mon potion"     }, // $00E3
{ "Mon potion"    , "Sar potion"     }, // $00E4
{ "Mon potion"    , "Jewel Symal"    }, // $00E5
{ "Mon potion"    , "Mon potion"     }, // $00E6
{ "Mon potion"    , "Mon potion"     }, // $00E7
{ "Mon potion"    , "Sar potion"     }, // $00E8
{ "Mon potion"    , "Jewel Symal"    }, // $00E9
{ "Mon potion"    , "Mon potion"     }, // $00EA
{ "Mon potion"    , "Mon potion"     }, // $00EB
{ "Mon potion"    , "Sar potion"     }, // $00EC
{ "Mon potion"    , "Jewel Symal"    }, // $00ED
{ "Mon potion"    , "Mon potion"     }, // $00EE
{ "Mon potion"    , "Mon potion"     }, // $00EF
{ "Mon potion"    , "Sar potion"     }, // $00F0
{ "Mon potion"    , "Jewel Symal"    }, // $00F1
{ "Mon potion"    , "Mon potion"     }, // $00F2
{ "Mon potion"    , "Mon potion"     }, // $00F3
{ "Mon potion"    , "Sar potion"     }, // $00F4
{ "Mon potion"    , "Jewel Symal"    }, // $00F5
{ "Mon potion"    , "Mon potion"     }, // $00F6
{ "Mon potion"    , "Mon potion"     }, // $00F7
{ "Mon potion"    , "Sar potion"     }, // $00F8
{ "Mon potion"    , "Jewel Symal"    }, // $00F9
{ "Mon potion"    , "Mon potion"     }, // $00FA
{ "Mon potion"    , "Mon potion"     }, // $00FB
{ "Mon potion"    , "Sar potion"     }, // $00FC
{ "Mon potion"    , "Jewel Symal"    }, // $00FD
{ "Mon potion"    , "Mon potion"     }, // $00FE
{ "Mon potion"    , "Mon potion"     }, // $00FF
// $800..$93F
{ "Magical box"   , "Corn"           }, // $0800
{ "Rope"          , "Topaz key"      }, // $0801
{ "Moonstone"     , "Choker"         }, // $0802
{ "Rabbit's foot" , "!"              }, // $0803
{ "Bread"         , "Dragon steak"   }, // $0804
{ "Cheese"        , "Choker"         }, // $0805
{ "Apple"         , "Compass"        }, // $0806
{ "Choker"        , "Water"          }, // $0807
{ "Lock picks"    , "Sapphire key"   }, // $0808
{ "Boulder"       , "Solid key"      }, // $0809
{ "Copper coin"   , "Onyx key"       }, // $080A
{ "Water"         , "Ashes"          }, // $080B
{ "Gold key"      , "!"              }, // $080C
{ "Gold key"      , "Choker"         }, // $080D
{ "Gold key"      , "Emerald key"    }, // $080E
{ "Topaz key"     , "Compass"        }, // $080F
{ "Iron key"      , "Turquoise key"  }, // $0810
{ "Solid key"     , "Illumulet"      }, // $0811
{ "Gold key"      , "Ekkhard Cross"  }, // $0812
{ "Gold key"      , "Jewel Symal"    }, // $0813
{ "Emerald key"   , "Ashes"          }, // $0814
{ "Iron key"      , "Emerald key"    }, // $0815
{ "Key of B"      , "!"              }, // $0816
{ "Gold key"      , "Iron key"       }, // $0817
{ "Gold coin"     , "Square key"     }, // $0818
{ "Gold coin"     , "Ashes"          }, // $0819
{ "Silver coin"   , "Solid key"      }, // $081A
{ "Gold key"      , "Boulder"        }, // $081B
{ "Gold key"      , "Ra Key"         }, // $081C
{ "Gold key"      , "Key of B"       }, // $081D
{ "Cheese"        , "Iron key"       }, // $081E
{ "Waterskin"     , "Ashes"          }, // $081F
{ "Blue gem"      , "!"              }, // $0820
{ "Gold key"      , "Compass"        }, // $0821
{ "Compass"       , "Skeleton key"   }, // $0822
{ "Apple"         , "Sapphire key"   }, // $0823
{ "Gold coin"     , "The Hellion"    }, // $0824
{ "Gold coin"     , "Key of B"       }, // $0825
{ "Drumstick"     , "Magical box"    }, // $0826
{ "Gold coin"     , "Skeleton key"   }, // $0827
{ "Drumstick"     , "Square key"     }, // $0828
{ "Mirror of Dawn", "Compass"        }, // $0829
{ "Water"         , "!"              }, // $082A
{ "Rabbit's foot" , "Moonstone"      }, // $082B
{ "Illumulet"     , "!"              }, // $082C
{ "Gold coin"     , "Gor coin"       }, // $082D
{ "Iron key"      , "Ruby key"       }, // $082E
{ "Iron key"      , "Square key"     }, // $082F
{ "Blue gem"      , "Green gem"      }, // $0830
{ "Illumulet"     , "Compass"        }, // $0831
{ "Cheese"        , "Gold key"       }, // $0832
{ "Drumstick"     , "Sapphire key"   }, // $0833
{ "Bread"         , "Solid key"      }, // $0834
{ "Bread"         , "!"              }, // $0835
{ "Cheese"        , "Gor coin"       }, // $0836
{ "Bread"         , "!"              }, // $0837
{ "Gold coin"     , "Screamer slice" }, // $0838
{ "Gold coin"     , "Skeleton key"   }, // $0839
{ "Gold key"      , "!"              }, // $083A
{ "Ekkhard Cross" , "Winged key"     }, // $083B
{ "Gem of Ages"   , "Ashes"          }, // $083C
{ "Choker"        , "Key of B"       }, // $083D
{ "Corn"          , "Waterskin"      }, // $083E
{ "Boulder"       , "Square key"     }, // $083F
{ "Gem of Ages"   , "Screamer slice" }, // $0840
{ "Magnifier"     , "!"              }, // $0841
{ "Drumstick"     , "Compass"        }, // $0842
{ "Iron key"      , "Master key"     }, // $0843
{ "Iron key"      , "!"              }, // $0844
{ "Copper coin"   , "Topaz key"      }, // $0845
{ "Iron key"      , "Gold key"       }, // $0846
{ "Solid key"     , "Winged key"     }, // $0847
{ "Green gem"     , "Waterskin"      }, // $0848
{ "Skeleton key"  , "Compass"        }, // $0849
{ "Apple"         , "The Hellion"    }, // $084A
{ "Skeleton key"  , "Key of B"       }, // $084B
{ "Jewel Symal"   , "!"              }, // $084C
{ "Solid key"     , "Gor coin"       }, // $084D
{ "Rabbit's foot" , "!"              }, // $084E
{ "Corbamite"     , "Waterskin"      }, // $084F
{ "Ra key"        , "!"              }, // $0850
{ "Key of B"      , "!"              }, // $0851
{ "Drumstick"     , "Onyx key"       }, // $0852
{ "Key of B"      , "Sapphire key"   }, // $0853
{ "Gold key"      , "Key of B"       }, // $0854
{ "Silver coin"   , "!"              }, // $0855
{ "Boulder"       , "Jewel Symal"    }, // $0856
{ "Boulder"       , "Lock picks"     }, // $0857
{ "Ashes"         , "Iron key"       }, // $0858
{ "Ashes"         , "!"              }, // $0859
{ "Ashes"         , "Waterskin"      }, // $085A
{ "Boulder"       , "Compass"        }, // $085B
{ "Boulder"       , "!"              }, // $085C
{ "Ashes"         , "Key of B"       }, // $085D
{ "Square key"    , "!"              }, // $085E
{ "Ashes"         , "!"              }, // $085F
{ "Ashes"         , "Square key"     }, // $0860
{ "Boulder"       , "Mirror of Dawn" }, // $0861
{ "Copper coin"   , "Boulder"        }, // $0862
{ "Copper coin"   , "Compass"        }, // $0863
{ "Copper coin"   , "Gold key"       }, // $0864
{ "Apple"         , "!"              }, // $0865
{ "Blue gem"      , "Turquoise key"  }, // $0866
{ "Green gem"     , "Gor coin"       }, // $0867
{ "Blue gem"      , "Skeleton key"   }, // $0868
{ "Blue gem"      , "Topaz key"      }, // $0869
{ "Apple"         , "Apple"          }, // $086A
{ "Cheese"        , "Illumulet"      }, // $086B
{ "Cheese"        , "Compass"        }, // $086C
{ "Apple"         , "Iron key"       }, // $086D
{ "Drumstick"     , "Turquoise key"  }, // $086E
{ "Drumstick"     , "Gold key"       }, // $086F
{ "Apple"         , "Turquoise key"  }, // $0870
{ "Apple"         , "Gor coin"       }, // $0871
{ "Drumstick"     , "Key of B"       }, // $0872
{ "The Hellion"   , "Key of B"       }, // $0873
{ "Lock picks"    , "Solid key"      }, // $0874
{ "Corbamite"     , "Square key"     }, // $0875
{ "Cheese"        , "Gor coin"       }, // $0876
{ "Drumstick"     , "Lock picks"     }, // $0877
{ "Orange gem"    , "Gold key"       }, // $0878
{ "Cross key"     , "!"              }, // $0879
{ "Ra key"        , "Solid key"      }, // $087A
{ "Drumstick"     , "Compass"        }, // $087B
{ "Gold key"      , "Key of B"       }, // $087C
{ "Water"         , "!"              }, // $087D
{ "Drumstick"     , "Orange gem"     }, // $087E
{ "Drumstick"     , "Moonstone"      }, // $087F
{ "Drumstick"     , "Leta bones"     }, // $0880
{ "Cheese"        , "!"              }, // $0881
{ "Silver coin"   , "Iron key"       }, // $0882
{ "Drumstick"     , "Illumulet"      }, // $0883
{ "Winged key"    , "!"              }, // $0884
{ "Gold coin"     , "Key of B"       }, // $0885
{ "Drumstick"     , "Sapphire key"   }, // $0886
{ "Cheese"        , "!"              }, // $0887
{ "Cheese"        , "Key of B"       }, // $0888
{ "Copper coin"   , "Ashes"          }, // $0889
{ "Corn"          , "Gor coin"       }, // $088A
{ "Corn"          , "Gor coin"       }, // $088B
{ "Corn"          , "Solid key"      }, // $088C
{ "Apple"         , "!"              }, // $088D
{ "Boulder"       , "Boulder"        }, // $088E
{ "Solid key"     , "!"              }, // $088F
{ "Corn"          , "!"              }, // $0890
{ "Key of B"      , "Waterskin"      }, // $0891
{ "Apple"         , "!"              }, // $0892
{ "Drumstick"     , "Blue gem"       }, // $0893
{ "Apple"         , "Skeleton key"   }, // $0894
{ "Mirror of Dawn", "Sapphire key"   }, // $0895
{ "Bread"         , "Bread"          }, // $0896
{ "Topaz key"     , "Key of B"       }, // $0897
{ "Emerald key"   , "!"              }, // $0898
{ "Apple"         , "The Hellion"    }, // $0899
{ "Drumstick"     , "Winged key"     }, // $089A
{ "Apple"         , "Water"          }, // $089B
{ "Drumstick"     , "Iron key"       }, // $089C
{ "Corn"          , "Compass"        }, // $089D
{ "Apple"         , "Choker"         }, // $089E
{ "Apple"         , "Jewel Symal"    }, // $089F
{ "Apple"         , "Square key"     }, // $08A0
{ "Corn"          , "Dragon steak"   }, // $08A1
{ "Drumstick"     , "!"              }, // $08A2
{ "Moonstone"     , "Key of B"       }, // $08A3
{ "Pendant Feral" , "Gold key"       }, // $08A4
{ "Skeleton key"  , "Shank"          }, // $08A5
{ "Skeleton key"  , "Key of B"       }, // $08A6
{ "Ruby key"      , "!"              }, // $08A7
{ "Ra key"        , "Solid key"      }, // $08A8
{ "Turquoise key" , "Magical box"    }, // $08A9
{ "Ashes"         , "Illumulet"      }, // $08AA
{ "Rope"          , "Mirror of Dawn" }, // $08AB
{ "Magical box"   , "Mirror of Dawn" }, // $08AC
{ "Magical box"   , "Winged key"     }, // $08AD
{ "Magical box"   , "Mirror of Dawn" }, // $08AE
{ "Magical box"   , "Mirror of Dawn" }, // $08AF
{ "Copper coin"   , "Cheese"         }, // $08B0
{ "Ashes"         , "!"              }, // $08B1
{ "Magical box"   , "Solid key"      }, // $08B2
{ "Cheese"        , "!"              }, // $08B3
{ "Apple"         , "Sapphire key"   }, // $08B4
{ "Rabbit's foot" , "Ashes"          }, // $08B5
{ "Gold coin"     , "Gor coin"       }, // $08B6
{ "Green gem"     , "Solid key"      }, // $08B7
{ "Bread"         , "Ra Key"         }, // $08B8
{ "Bread"         , "Key of B"       }, // $08B9
{ "Copper coin"   , "Compass"        }, // $08BA
{ "Copper coin"   , "Lock picks"     }, // $08BB
{ "Cheese"        , "Skeleton key"   }, // $08BC
{ "Apple"         , "!"              }, // $08BD
{ "Corn"          , "Gor coin"       }, // $08BE
{ "Dragon steak"  , "Mirror of Dawn" }, // $08BF
{ "Corn"          , "Water"          }, // $08C0
{ "Cheese"        , "!"              }, // $08C1
{ "Cheese"        , "Key of B"       }, // $08C2
{ "Corn"          , "!"              }, // $08C3
{ "Apple"         , "Emerald key"    }, // $08C4
{ "Bread"         , "Ekkhard Cross"  }, // $08C5
{ "Screamer slice", "Master key"     }, // $08C6
{ "Bread"         , "Leta bones"     }, // $08C7
{ "Corn"          , "Blue gem"       }, // $08C8
{ "Cheese"        , "The Hellion"    }, // $08C9
{ "Bread"         , "!"              }, // $08CA
{ "Apple"         , "Green gem"      }, // $08CB
{ "Corn"          , "Choker"         }, // $08CC
{ "Silver coin"   , "Choker"         }, // $08CD
{ "Copper coin"   , "!"              }, // $08CE
{ "Skeleton key"  , "Waterskin"      }, // $08CF
{ "Apple"         , "Square key"     }, // $08D0
{ "Cheese"        , "!"              }, // $08D1
{ "Apple"         , "Magical box"    }, // $08D2
{ "Cheese"        , "!"              }, // $08D3
{ "Screamer slice", "Gor coin"       }, // $08D4
{ "Cheese"        , "Ashes"          }, // $08D5
{ "Cheese"        , "Solid key"      }, // $08D6
{ "Apple"         , "Ra Key"         }, // $08D7
{ "Corn"          , "!"              }, // $08D8
{ "Bread"         , "!"              }, // $08D9
{ "Drumstick"     , "Lock picks"     }, // $08DA
{ "Drumstick"     , "Choker"         }, // $08DB
{ "Drumstick"     , "Gold key"       }, // $08DC
{ "Cheese"        , "Square key"     }, // $08DD
{ "Copper coin"   , "Winged key"     }, // $08DE
{ "Drumstick"     , "Solid key"      }, // $08DF
{ "Cheese"        , "Magical box"    }, // $08E0
{ "Apple"         , "Gor coin"       }, // $08E1
{ "Drumstick"     , "!"              }, // $08E2
{ "Magical box"   , "Gor coin"       }, // $08E3
{ "Copper coin"   , "Emerald key"    }, // $08E4
{ "Copper coin"   , "Orange gem"     }, // $08E5
{ "Copper coin"   , "Solid key"      }, // $08E6
{ "Silver coin"   , "Cheese"         }, // $08E7
{ "Copper coin"   , "Jewel Symal"    }, // $08E8
{ "Cheese"        , "Magnifier"      }, // $08E9
{ "Apple"         , "!"              }, // $08EA
{ "Magical box"   , "Mirror of Dawn" }, // $08EB
{ "Magical box"   , "Blue gem"       }, // $08EC
{ "Bread"         , "Ashes"          }, // $08ED
{ "Bread"         , "!"              }, // $08EE
{ "Cheese"        , "Sapphire key"   }, // $08EF
{ "Corn"          , "!"              }, // $08F0
{ "Drumstick"     , "Magical box"    }, // $08F1
{ "Corn"          , "!"              }, // $08F2
{ "Magical box"   , "Cheese"         }, // $08F3
{ "Drumstick"     , "Winged key"     }, // $08F4
{ "Magical box"   , "!"              }, // $08F5
{ "Cheese"        , "Square key"     }, // $08F6
{ "Magical box"   , "!"              }, // $08F7
{ "Bread"         , "Square key"     }, // $08F8
{ "Cheese"        , "!"              }, // $08F9
{ "Corn"          , "Orange gem"     }, // $08FA
{ "Magical box"   , "!"              }, // $08FB
{ "Apple"         , "Dragon steak"   }, // $08FC
{ "Apple"         , "!"              }, // $08FD
{ "Ra key"        , "Solid key"      }, // $08FE
{ "Cross key"     , "Compass"        }, // $08FF
{ "Bread"         , "Jewel Symal"    }, // $0900
{ "Cheese"        , "Mirror of Dawn" }, // $0901
{ "Drumstick"     , "Choker"         }, // $0902
{ "Bread"         , "Square key"     }, // $0903
{ "Cheese"        , "Silver coin"    }, // $0904
{ "Drumstick"     , "Skeleton key"   }, // $0905
{ "Drumstick"     , "Jewel Symal"    }, // $0906
{ "Drumstick"     , "Ashes"          }, // $0907
{ "Magical box"   , "Gor coin"       }, // $0908
{ "Magical box"   , "!"              }, // $0909
{ "Copper coin"   , "!"              }, // $090A
{ "Copper coin"   , "Solid key"      }, // $090B
{ "Copper coin"   , "The Hellion"    }, // $090C
{ "Copper coin"   , "!"              }, // $090D
{ "Copper coin"   , "Gold key"       }, // $090E
{ "Copper coin"   , "Compass"        }, // $090F
{ "Magical box"   , "Lock picks"     }, // $0910
{ "Iron key"      , "Square key"     }, // $0911
{ "Magnifier"     , "Green gem"      }, // $0912
{ "Master key"    , "Solid key"      }, // $0913
{ "Silver coin"   , "Solid key"      }, // $0914
{ "Magical box"   , "!"              }, // $0915
{ "Magical box"   , "Key of B"       }, // $0916
{ "Magical box"   , "Gor coin"       }, // $0917
{ "Compass"       , "Leta bones"     }, // $0918
{ "Compass"       , "Leta bones"     }, // $0919
{ "Compass"       , "Key of B"       }, // $091A
{ "Compass"       , "Square key"     }, // $091B
{ "Compass"       , "Jewel Symal"    }, // $091C
{ "Compass"       , "Compass"        }, // $091D
{ "Compass"       , "Gold key"       }, // $091E
{ "Compass"       , "Screamer slice" }, // $091F
{ "Compass"       , "Mirror of Dawn" }, // $0920
{ "Compass"       , "Square key"     }, // $0921
{ "Compass"       , "Key of B"       }, // $0922
{ "Compass"       , "!"              }, // $0923
{ "Compass"       , "Key of B"       }, // $0924
{ "Compass"       , "Solid key"      }, // $0925
{ "Compass"       , "Solid key"      }, // $0926
{ "Compass"       , "Compass"        }, // $0927
{ "Compass"       , "Choker"         }, // $0928
{ "Compass"       , "Winged key"     }, // $0929
{ "Compass"       , "!"              }, // $092A
{ "Compass"       , "Choker"         }, // $092B
{ "Compass"       , "Winged key"     }, // $092C
{ "Compass"       , "Skeleton key"   }, // $092D
{ "Compass"       , "!"              }, // $092E
{ "Compass"       , "!"              }, // $092F
{ "Compass"       , "Key of B"       }, // $0930
{ "Compass"       , "Solid key"      }, // $0931
{ "Compass"       , "Skeleton key"   }, // $0932
{ "Compass"       , "Iron key"       }, // $0933
{ "Compass"       , "Gem of Ages"    }, // $0934
{ "Compass"       , "!"              }, // $0935
{ "Compass"       , "Square key"     }, // $0936
{ "Compass"       , "Jewel Symal"    }, // $0937
{ "Compass"       , "Square key"     }, // $0938
{ "Compass"       , "Green gem"      }, // $0939
{ "Compass"       , "Mirror of Dawn" }, // $093A
{ "Compass"       , "!"              }, // $093B
{ "Compass"       , "Gor coin"       }, // $093C
{ "Compass"       , "Bones"          }, // $093D
{ "Compass"       , "!"              }, // $093E
{ "Compass"       , "Cheese"         }, // $093F
// $1400..$14FF
{ "Eye of Time"   , "Winged key"     }, // $1400
{ "Throwing star" , "Fine robe (top)"}, // $1401
{ "Throwing star" , "Rapier"         }, // $1402
{ "Throwing star" , "Serpent Staff"  }, // $1403
{ "Dagger"        , "Elven huke"     }, // $1404
{ "Dagger"        , "Dragon Fang"    }, // $1405
{ "Samurai sword" , "Eye of Time"    }, // $1406
{ "Wand"          , "Sandals"        }, // $1407
{ "Poison dart"   , "Biter"          }, // $1408
{ "Poison dart"   , "Slayer"         }, // $1409
{ "Axe"           , "Rapier"         }, // $140A
{ "Bow"           , "Rapider"        }, // $140B
{ "Sword"         , "Neta Shield"    }, // $140C
{ "Arrow"         , "Sword"          }, // $140D
{ "Arrow"         , "Dagger"         }, // $140E
{ "Morning star"  , "Storm"          }, // $140F
{ "Torch"         , "Storm"          }, // $1410
{ "Torch"         , "Sword"          }, // $1411
{ "Club"          , "Biter"          }, // $1412
{ "Falchion"      , "Torch"          }, // $1413
{ "Poison dart"   , "Eye of Time"    }, // $1414
{ "Arrow"         , "Dragon Fang"    }, // $1415
{ "Dagger"        , "Stick"          }, // $1416
{ "Torch"         , "Speedbow"       }, // $1417
{ "Torch"         , "Biter"          }, // $1418
{ "Torch"         , "Sword"          }, // $1419
{ "Dagger"        , "Powertowers"    }, // $141A
{ "Torch"         , "Sword"          }, // $141B
{ "Wand"          , "Rapier"         }, // $141C
{ "Arrow"         , "Rapier"         }, // $141D
{ "Axe"           , "Eye of Time"    }, // $141E
{ "Horn of Fear"  , "Tattered pants" }, // $141F
{ "Arrow"         , "Axe"            }, // $1420
{ "Arrow"         , "Blue pants"     }, // $1421
{ "Arrow"         , "Tattered pants" }, // $1422
{ "Torch"         , "Axe"            }, // $1423
{ "Bow"           , "Vorpal Blade"   }, // $1424
{ "Dagger"        , "Flamebain"      }, // $1425
{ "Mace"          , "Fine robe (top)"}, // $1426
{ "Diamond Edge"  , "Sword"          }, // $1427
{ "Sword"         , "Rapier"         }, // $1428
{ "Rapier"        , "Vorpal Blade"   }, // $1429
{ "Bolt Blade"    , "Falchion"       }, // $142A
{ "Vorpal Blade"  , "Yew staff"      }, // $142B
{ "Dragon Spit"   , "Blue pants"     }, // $142C
{ "Sceptre of Lyf", "Biter"          }, // $142D
{ "Poison dart"   , "Torch"          }, // $142E
{ "Torch"         , "Biter"          }, // $142F
{ "Slayer"        , "Slayer"         }, // $1430
{ "Staff"         , "Speedbow"       }, // $1431
{ "Sabre"         , "Armet"          }, // $1432
{ "Staff"         , "Dagger"         }, // $1433
{ "Hardcleave"    , "Robe (bottom)"  }, // $1434
{ "Delta"         , "Suede boots"    }, // $1435
{ "Sling"         , "Throwing star"  }, // $1436
{ "Torch"         , "Eye of Time"    }, // $1437
{ "Speedbow"      , "Torch"          }, // $1438
{ "Sling"         , "Slayer"         }, // $1439
{ "Arrow"         , "Slayer"         }, // $143A
{ "Yew staff"     , "Blue pants"     }, // $143B
{ "Torch"         , "Biter"          }, // $143C
{ "Teowand"       , "Staff of Claws" }, // $143D
{ "Torch"         , "Dagger"         }, // $143E
{ "Rock"          , "Plate of Ra"    }, // $143F
{ "Staff of Manar", "Calista"        }, // $1440
{ "Torch"         , "Storm"          }, // $1441
{ "Torch"         , "Storm"          }, // $1442
{ "Torch"         , "Slayer"         }, // $1443
{ "Torch"         , "Torch"          }, // $1444
{ "Mace of Order" , "Vorpal Blade"   }, // $1445
{ "Sabre"         , "Staff"          }, // $1446
{ "Fury"          , "Storm Ring"     }, // $1447
{ "Slayer"        , "Slayer"         }, // $1448
{ "Throwing star" , "Sword"          }, // $1449
{ "Throwing star" , "Crossbow"       }, // $144A
{ "Throwing star" , "Sword"          }, // $144B
{ "Falchion"      , "Rapier"         }, // $144C
{ "Torch"         , "Helmet"         }, // $144D
{ "Snake Staff"   , "Yew staff"      }, // $144E
{ "Slayer"        , "Torch"          }, // $144F
{ "The Firestaff" , "Dragon poleyn"  }, // $1450
{ "The Inquisitor", "Sandals"        }, // $1451
{ "Torch"         , "Dragon Fang"    }, // $1452
{ "Staff of Claws", "Staff of Claws" }, // $1453
{ "Torch"         , "Winged key"     }, // $1454
{ "Stormring"     , "Neta Shield"    }, // $1455
{ "Flamitt"       , "Fine robe (top)"}, // $1456
{ "Throwing star" , "Helmet"         }, // $1457
{ "Club"          , "Slayer"         }, // $1458
{ "Torch"         , "Torch"          }, // $1459
{ "Torch"         , "Elven huke"     }, // $145A
{ "Torch"         , "Storm Ring"     }, // $145B
{ "Torch"         , "Vorpal Blade"   }, // $145C
{ "Throwing star" , "Plate of Ra"    }, // $145D
{ "Poison dart"   , "Sword"          }, // $145E
{ "Vorpal Blade"  , "Sword"          }, // $145F
{ "Morning star"  , "Rapier"         }, // $1460
{ "Falchion"      , "Eye of Time"    }, // $1461
{ "Throwing star" , "Biter"          }, // $1462
{ "Torch"         , "Torch"          }, // $1463
{ "Slayer"        , "Ruby key"       }, // $1464
{ "Crossbow"      , "Wand"           }, // $1465
{ "Yew staff"     , "Staff of Irra"  }, // $1466
{ "The Firestaff" , "Dragon poleyn"  }, // $1467
{ "Rock"          , "Ruby key"       }, // $1468
{ "Rock"          , "Dagger"         }, // $1469
{ "Rock"          , "Storm"          }, // $146A
{ "Eye of Time"   , "Dragon poleyn"  }, // $146B
{ "Eye of Time"   , "Ruby key"       }, // $146C
{ "Eye of Time"   , "Ra Blade"       }, // $146D
{ "Eye of Time"   , "The Firestaff"  }, // $146E
{ "Eye of Time"   , "Dragon poleyn"  }, // $146F
{ "Eye of Time"   , "Ruby key"       }, // $1470
{ "Eye of Time"   , "Rapier"         }, // $1471
{ "Eye of Time"   , "The Firestaff"  }, // $1472
{ "Eye of Time"   , "Suede boots"    }, // $1473
{ "Eye of Time"   , "Ruby key"       }, // $1474
{ "Eye of Time"   , "Biter"          }, // $1475
{ "Eye of Time"   , "Falchion"       }, // $1476
{ "Eye of Time"   , "Dragon poleyn"  }, // $1477
{ "Eye of Time"   , "Ruby key"       }, // $1478
{ "Eye of Time"   , "Ra Blade"       }, // $1479
{ "Eye of Time"   , "The Firestaff"  }, // $147A
{ "Eye of Time"   , "Throwing star"  }, // $147B
{ "Eye of Time"   , "Ruby key"       }, // $147C
{ "Eye of Time"   , "Sword"          }, // $147D
{ "Eye of Time"   , "Sword"          }, // $147E
{ "Eye of Time"   , "Throwing star"  }, // $147F
{ "Eye of Time"   , "Ruby key"       }, // $1480
{ "Eye of Time"   , "Square key"     }, // $1481
{ "Eye of Time"   , "Square key"     }, // $1482
{ "Eye of Time"   , "Dragon poleyn"  }, // $1483
{ "Eye of Time"   , "Ruby key"       }, // $1484
{ "Eye of Time"   , "Gold key"       }, // $1485
{ "Eye of Time"   , "Cross key"      }, // $1486
{ "Eye of Time"   , "Eye of Time"    }, // $1487
{ "Eye of Time"   , "Ruby key"       }, // $1488
{ "Eye of Time"   , "Ra Key"         }, // $1489
{ "Eye of Time"   , "Solid key"      }, // $148A
{ "Eye of Time"   , "Eye of Time"    }, // $148B
{ "Eye of Time"   , "Ruby key"       }, // $148C
{ "Eye of Time"   , "Solid key"      }, // $148D
{ "Eye of Time"   , "Winged key"     }, // $148E
{ "Eye of Time"   , "Throwing star"  }, // $148F
{ "Eye of Time"   , "Ruby key"       }, // $1490
{ "Eye of Time"   , "Onyx key"       }, // $1491
{ "Eye of Time"   , "Turquoise key"  }, // $1492
{ "Eye of Time"   , "Eye of Time"    }, // $1493
{ "Eye of Time"   , "Gunna"          }, // $1494
{ "Eye of Time"   , "Rapier"         }, // $1495
{ "Eye of Time"   , "Sword"          }, // $1496
{ "Eye of Time"   , "Wooden shield"  }, // $1497
{ "Eye of Time"   , "Stick"          }, // $1498
{ "Eye of Time"   , "Stone club"     }, // $1499
{ "Eye of Time"   , "Powertower"     }, // $149A
{ "Eye of Time"   , "Falchion"       }, // $149B
{ "Eye of Time"   , "Dagger"         }, // $149C
{ "Eye of Time"   , "Eye of Time"    }, // $149D
{ "Eye of Time"   , "Suede boots"    }, // $149E
{ "Eye of Time"   , "Dagger"         }, // $149F
{ "Eye of Time"   , "Powertower"     }, // $14A0
{ "Eye of Time"   , "Biter"          }, // $14A1
{ "Eye of Time"   , "Tattered pants" }, // $14A2
{ "Eye of Time"   , "Axe"            }, // $14A3
{ "Eye of Time"   , "Throwing star"  }, // $14A4
{ "Eye of Time"   , "Crossbow"       }, // $14A5
{ "Eye of Time"   , "Falchion"       }, // $14A6
{ "Eye of Time"   , "Dragon Shield"  }, // $14A7
{ "Eye of Time"   , "Axe"            }, // $14A8
{ "Eye of Time"   , "Eye of Time"    }, // $14A9
{ "Eye of Time"   , "Gunna"          }, // $14AA
{ "Eye of Time"   , "Falchion"       }, // $14AB
{ "Eye of Time"   , "Dex Helm"       }, // $14AC
{ "Eye of Time"   , "Storm Ring"     }, // $14AD
{ "Eye of Time"   , "Slayer"         }, // $14AE
{ "Eye of Time"   , "Biter"          }, // $14AF
{ "Eye of Time"   , "Staff of Claws" }, // $14B0
{ "Eye of Time"   , "Suede boots"    }, // $14B1
{ "Eye of Time"   , "Throwing star"  }, // $14B2
{ "Eye of Time"   , "Mace of Order"  }, // $14B3
{ "Eye of Time"   , "Fine robe (top)"}, // $14B4
{ "Eye of Time"   , "Eye of Time"    }, // $14B5
{ "Eye of Time"   , "Slayer"         }, // $14B6
{ "Eye of Time"   , "Sword"          }, // $14B7
{ "Eye of Time"   , "Throwing star"  }, // $14B8
{ "Eye of Time"   , "Casque 'n coif" }, // $14B9
{ "Eye of Time"   , "Dragon Fang"    }, // $14BA
{ "Eye of Time"   , "Dagger"         }, // $14BB
{ "Eye of Time"   , "Fine robe (top)"}, // $14BC
{ "Eye of Time"   , "Tattered pants" }, // $14BD
{ "Eye of Time"   , "Arrow"          }, // $14BE
{ "Eye of Time"   , "Sword"          }, // $14BF
{ "Eye of Time"   , "Torch"          }, // $14C0
{ "Eye of Time"   , "Suede boots"    }, // $14C1
{ "Eye of Time"   , "Storm"          }, // $14C2
{ "Eye of Time"   , "Sword"          }, // $14C3
{ "Eye of Time"   , "Samurai sword"  }, // $14C4
{ "Eye of Time"   , "Tattered pants" }, // $14C5
{ "Eye of Time"   , "Stone club"     }, // $14C6
{ "Eye of Time"   , "Silk shirt"     }, // $14C7
{ "Eye of Time"   , "Neta Shield"    }, // $14C8
{ "Eye of Time"   , "Sar Shield"     }, // $14C9
{ "Eye of Time"   , "Executioner"    }, // $14CA
{ "Eye of Time"   , "Silk shirt"     }, // $14CB
{ "Eye of Time"   , "Neta Shield"    }, // $14CC
{ "Eye of Time"   , "Illumulet"      }, // $14CD
{ "Eye of Time"   , "Tattered pants" }, // $14CE
{ "Ruby key"      , "Silk shirt"     }, // $14CF
{ "Cape"          , "Robe (bottom)"  }, // $14D0
{ "Sandals"       , "Robe (bottom)"  }, // $14D1
{ "Poleyn of Darc", "Sceptre of Lyf" }, // $14D2
{ "Ruby key"      , "Crossbow"       }, // $14D3
{ "Silk shirt"    , "Vorpal Blade"   }, // $14D4
{ "Fine robe (bot)","Helmet"         }, // $14D5
{ "Throwing star" , "Elven doublet"  }, // $14D6
{ "Ruby key"      , "Biter"          }, // $14D7
{ "Silk shirt"    , "Gunna"          }, // $14D8
{ "Robe (bottom)" , "Robe (bottom)"  }, // $14D9
{ "Eye of Time"   , "Staff of Claws" }, // $14DA
{ "Ruby key"      , "Stone club"     }, // $14DB
{ "Rapier"        , "Storm Ring"     }, // $14DC
{ "Yew staff"     , "Sceptre of Lyf" }, // $14DD
{ "Eye of Time"   , "Teowand"        }, // $14DE
{ "Ruby key"      , "Dagger"         }, // $14DF
{ "Leather boots" , "Topaz key"      }, // $14E0
{ "Cape"          , "Stone club"     }, // $14E1
{ "Eye of Time"   , "Staff of Claws" }, // $14E2
{ "Ruby key"      , "Mace"           }, // $14E3
{ "Vorpal Blade"  , "Dagger"         }, // $14E4
{ "Teowand"       , "Storm"          }, // $14E5
{ "Eye of Time"   , "Gunna"          }, // $14E6
{ "Ruby key"      , "Dagger"         }, // $14E7
{ "Delta"         , "Eye of Time"    }, // $14E8
{ "Mace of Order" , "Rapier"         }, // $14E9
{ "Suede boots"   , "Gunna"          }, // $14EA
{ "Club"          , "Gunna"          }, // $14EB
{ "Robe (top)"    , "Stone club"     }, // $14EC
{ "Leather boots" , "Gunna"          }, // $14ED
{ "Poleyn of Darc", "Elven boots"    }, // $14EE
{ "Ruby key"      , "Arrow"          }, // $14EF
{ "Delta"         , "Dagger"         }, // $14F0
{ "Sceptre of Lyf", "Dagger"         }, // $14F1
{ "Pollen of Darc", "Staff of Claws" }, // $14F2
{ "Ruby key"      , "Stone club"     }, // $14F3
{ "Mace of Order" , "Stone club"     }, // $14F4
{ "Staff of Manar", "Helmet"         }, // $14F5
{ "Throwing star" , "Gunna"          }, // $14F6
{ "Ruby key"      , "Winged key"     }, // $14F7
{ "Morning star"  , "Dagger"         }, // $14F8
{ "Bow"           , "Dagger"         }, // $14F9
{ "Suede boots"   , "Falchion"       }, // $14FA
{ "Ruby key"      , "Sword"          }, // $14FB
{ "Ghi trousers"  , "Stone club"     }, // $14FC
{ "Ghi"           , "Stone club"     }, // $14FD
{ "Eye of Time"   , "Flamitt"        }, // $14FE
{ "Ruby key"      , "Fine robe (top)"}, // $14FF
// $1800..$18FF
{ "Sandals"       , "Cloak of Night" }, // $1800
{ "Barbarian hide", "Boots of Speed" }, // $1801
{ "Silk shirt"    , "Helmet"         }, // $1802
{ "Tabard"        , "Leather jerkin" }, // $1803
{ "Sandals"       , "Tunic"          }, // $1804
{ "Barbarian hide", "Small shield"   }, // $1805
{ "Hide shield"   , "Silk shirt"     }, // $1806
{ "Sandals"       , "Waterskin"      }, // $1807
{ "Robe (top)"    , "Leg plate"      }, // $1808
{ "Robe (bottom)" , "Suede boots"    }, // $1809
{ "Leather jerkin", "Cloak of Night" }, // $180A
{ "Leather pants" , "Kirtle"         }, // $180B
{ "Leather boots" , "Cape"           }, // $180C
{ "Gunna"         , "Dragon Helm"    }, // $180D
{ "Elven doublet" , "Tattered pants" }, // $180E
{ "Tabard"        , "Gunna"          }, // $180F
{ "Ghi"           , "Casque 'n coif" }, // $1810
{ "Ghi trousers"  , "Solid key"      }, // $1811
{ "Mail Aketon"   , "Silk shirt"     }, // $1812
{ "Blue pants"    , "Leather pants"  }, // $1813
{ "Leather pants" , "Mithral mail"   }, // $1814
{ "Wooden shield" , "Silk shirt"     }, // $1815
{ "Kirtle"        , "Cheese"         }, // $1816
{ "Sandals"       , "Tabard"         }, // $1817
{ "Leg mail"      , "Helm of Ra"     }, // $1818
{ "Leather jerkin", "Sandals"        }, // $1819
{ "Blue pants"    , "Plate of Ra"    }, // $181A
{ "Leather boots" , "Plate of Ra"    }, // $181B
{ "Leather jerkin", "Suede boots"    }, // $181C
{ "Tunic"         , "Plate of Ra"    }, // $181D
{ "Leather pants" , "Plate of Ra"    }, // $181E
{ "Suede boots"   , "Mail Aketon"    }, // $181F
{ "Elven doublet" , "Gold key"       }, // $1820
{ "Elven huke"    , "Tabard"         }, // $1821
{ "Elven boots"   , "Orange gem"     }, // $1822
{ "Leather pants" , "Tunic"          }, // $1823
{ "Silk shirt"    , "Leather boots"  }, // $1824
{ "Leather boots" , "Fine robe (bot)"}, // $1825
{ "Gunna"         , "Tabard"         }, // $1826
{ "Silk shirt"    , "Calista"        }, // $1827
{ "Sandals"       , "Silk shirt"     }, // $1828
{ "Tunic"         , "Choker"         }, // $1829
{ "Leather pants" , "Dragon Plate"   }, // $182A
{ "Leather boots" , "Leather jerkin" }, // $182B
{ "Robe (top)"    , "Silver coin"    }, // $182C
{ "Robe (bottom)" , "Fine robe (bot)"}, // $182D
{ "Sandals"       , "Plate of Ra"    }, // $182E
{ "Gunna"         , "Cloak of Night" }, // $182F
{ "Sandals"       , "Gold key"       }, // $1830
{ "Leather pants" , "Silk shirt"     }, // $1831
{ "Suede boots"   , "Solid key"      }, // $1832
{ "Leather jerkin", "Ghi"            }, // $1833
{ "Leather jerkin", "Armet"          }, // $1834
{ "Suede boots"   , "Crown of Nerra" }, // $1835
{ "Hosen"         , "Tattered shirt" }, // $1836
{ "Ghi trousers"  , "Helmet"         }, // $1837
{ "Boots of Speed", "Leg plate"      }, // $1838
{ "Boots of Speed", "Lock picks"     }, // $1839
{ "Boots of Speed", "Neta Shield"    }, // $183A
{ "Leather pants" , "Dragon Helm"    }, // $183B
{ "Foot plate"    , "Dragon Helm"    }, // $183C
{ "Leather boots" , "Silver coin"    }, // $183D
{ "Leather boots" , "Cloak of Night" }, // $183E
{ "Elven doublet" , "Gunna"          }, // $183F
{ "Leather jerkin", "Gold key"       }, // $1840
{ "Leather pants" , "Sar Shield"     }, // $1841
{ "Suede boots"   , "Solid key"      }, // $1842
{ "Bezerker helm" , "Fine robe (bot)"}, // $1843
{ "Leather jerkin", "Leather boots"  }, // $1844
{ "Leather pants" , "Tabard"         }, // $1845
{ "Tunic"         , "Calista"        }, // $1846
{ "Bezerker helm" , "Rabbit's foot"  }, // $1847
{ "Mail Aketon"   , "Winged key"     }, // $1848
{ "Leather pants" , "Dragon Plate"   }, // $1849
{ "Leather jerkin", "Dragon Helm"    }, // $184A
{ "Elven huke"    , "Leather pants"  }, // $184B
{ "Helmet"        , "Gunna"          }, // $184C
{ "Helmet"        , "Suede boots"    }, // $184D
{ "Mail Aketon"   , "Tabard"         }, // $184E
{ "Leg mail"      , "Helm of Ra"     }, // $184F
{ "Hosen"         , "Fine robe (bot)"}, // $1850
{ "Flamebain"     , "!"              }, // $1851
{ "Crown of Nerra", "Fine robe (bot)"}, // $1852
{ "Boots of Speed", "Ghi"            }, // $1853
{ "Mail Aketon"   , "Basinet"        }, // $1854
{ "Helmet"        , "Tabard"         }, // $1855
{ "Torso plate"   , "Mail Aketon"    }, // $1856
{ "Casque 'n coif", "Tattered pants" }, // $1857
{ "Small shield"  , "Dragon poleyn"  }, // $1858
{ "Basinet"       , "Moonstone"      }, // $1859
{ "Elven boots"   , "Plate of Ra"    }, // $185A
{ "Casque 'n coif", "Helmet"         }, // $185B
{ "Large shield"  , "Leather boots"  }, // $185C
{ "Torso plate"   , "Compass"        }, // $185D
{ "Mithral Aketon", "Tunic"          }, // $185E
{ "Large shield"  , "Skeleton key"   }, // $185F
{ "Leg plate"     , "Helm of Ra"     }, // $1860
{ "Foot plate"    , "Flamebain"      }, // $1861
{ "Armet"         , "Mail Aketon"    }, // $1862
{ "Calista"       , "Suede boots"    }, // $1863
{ "Plate of Lyte" , "Ruby key"       }, // $1864
{ "Poleyn of Lyte", "Gunna"          }, // $1865
{ "Greave of Lyte", "Ruby key"       }, // $1866
{ "Plate of Darc" , "Gunna"          }, // $1867
{ "Poleyn of Darc", "Compass"        }, // $1868
{ "Halter"        , "Basinet"        }, // $1869
{ "Halter"        , "Dex Helm"       }, // $186A
{ "Buckler"       , "Casque 'n coif" }, // $186B
{ "Shield of Lyte", "Ashes"          }, // $186C
{ "Greave of Darc", "Tabard"         }, // $186D
{ "Shield of Darc", "Cape"           }, // $186E
{ "Helm of Darc"  , "Tattered pants" }, // $186F
{ "Helm of Lyte"  , "Plate of Ra"    }, // $1870
{ "Fine robe (top)","Dragon Helm"    }, // $1871
{ "Fine robe (bot)","Gunna"          }, // $1872
{ "Bezerker helm" , "Fine robe (top)"}, // $1873
{ "Hosen"         , "Leather jerkin" }, // $1874
{ "Mithral mail"  , "Tattered pants" }, // $1875
{ "Cloak of Night", "Leather boots"  }, // $1876
{ "Blue pants"    , "Fine robe (bot)"}, // $1877
{ "Sandals"       , "!"              }, // $1878
{ "Cape"          , "Dex Helm"       }, // $1879
{ "Cape"          , "Tabard"         }, // $187A
{ "Cape"          , "Leg plate"      }, // $187B
{ "Cape"          , "Jewel Symal"    }, // $187C
{ "Cape"          , "Leather pants"  }, // $187D
{ "Cape"          , "Cape"           }, // $187E
{ "Cape"          , "Dragon Plate"   }, // $187F
{ "Cape"          , "Gunna"          }, // $1880
{ "Cape"          , "Neta Shield"    }, // $1881
{ "Cape"          , "Tabard"         }, // $1882
{ "Cape"          , "Tabard"         }, // $1883
{ "Cape"          , "Skeleton key"   }, // $1884
{ "Cape"          , "Silk shirt"     }, // $1885
{ "Cape"          , "Fine robe (bot)"}, // $1886
{ "Cape"          , "Tattered shirt" }, // $1887
{ "Cape"          , "Tattered shirt" }, // $1888
{ "Cape"          , "Silk shirt"     }, // $1889
{ "Cape"          , "Gunna"          }, // $188A
{ "Cape"          , "Tattered pants" }, // $188B
{ "Cape"          , "Cape"           }, // $188C
{ "Cape"          , "Leather pants"  }, // $188D
{ "Cape"          , "Leg mail"       }, // $188E
{ "Cape"          , "Plate of Ra"    }, // $188F
{ "Cape"          , "Gunna"          }, // $1890
{ "Cape"          , "Silk shirt"     }, // $1891
{ "Cape"          , "Magical box"    }, // $1892
{ "Cape"          , "Silk shirt"     }, // $1893
{ "Cape"          , "Tabard"         }, // $1894
{ "Cape"          , "Tabard"         }, // $1895
{ "Cape"          , "Cape"           }, // $1896
{ "Cape"          , "Dragon Helm"    }, // $1897
{ "Cape"          , "Suede boots"    }, // $1898
{ "Cape"          , "Silver coin"    }, // $1899
{ "Cape"          , "Dragon Helm"    }, // $189A
{ "Cape"          , "Suede boots"    }, // $189B
{ "Cape"          , "Leather jerkin" }, // $189C
{ "Cape"          , "Magical box"    }, // $189D
{ "Cape"          , "Dex Helm"       }, // $189E
{ "Cape"          , "Silk shirt"     }, // $189F
{ "Cape"          , "Tabard"         }, // $18A0
{ "Cape"          , "Leather jerkin" }, // $18A1
{ "Cape"          , "Kirtle"         }, // $18A2
{ "Cape"          , "Hosen"          }, // $18A3
{ "Cape"          , "Silver coin"    }, // $18A4
{ "Cape"          , "Gunna"          }, // $18A5
{ "Cape"          , "Tattered pants" }, // $18A6
{ "Cape"          , "Gunna"          }, // $18A7
{ "Cape"          , "Neta Shield"    }, // $18A8
{ "Cape"          , "Plate of Ra"    }, // $18A9
{ "Cape"          , "Blue gem"       }, // $18AA
{ "Cape"          , "Fine robe (bot)"}, // $18AB
{ "Cape"          , "Dragon Shield"  }, // $18AC
{ "Cape"          , "Sar coin"       }, // $18AD
{ "Cape"          , "Mail Aketon"    }, // $18AE
{ "Cape"          , "Cape"           }, // $18AF
{ "Cape"          , "Tattered pants" }, // $18B0
{ "Cape"          , "Neta Shield"    }, // $18B1
{ "Cape"          , "Neta Shield"    }, // $18B2
{ "Cape"          , "Silver coin"    }, // $18B3
{ "Cape"          , "Gunna"          }, // $18B4
{ "Cape"          , "Leather boots"  }, // $18B5
{ "Cape"          , "Fine robe (bot)"}, // $18B6
{ "Cape"          , "Cheese"         }, // $18B7
{ "Cape"          , "Solid key"      }, // $18B8
{ "Cape"          , "Tattered shirt" }, // $18B9
{ "Cape"          , "Tattered shirt" }, // $18BA
{ "Cape"          , "Neta Shield"    }, // $18BB
{ "Cape"          , "Tattered pants" }, // $18BC
{ "Cape"          , "Leather jerkin" }, // $18BD
{ "Cape"          , "Mithral Aketon" }, // $18BE
{ "Cape"          , "Cloak of Night" }, // $18BF
{ "Cape"          , "Neta Shield"    }, // $18C0
{ "Cape"          , "Silk shirt"     }, // $18C1
{ "Cape"          , "Helmet"         }, // $18C2
{ "Cape"          , "Silk shirt"     }, // $18C3
{ "Cape"          , "Tabard"         }, // $18C4
{ "Cape"          , "Cross key"      }, // $18C5
{ "Cape"          , "Hosen"          }, // $18C6
{ "Cape"          , "Tattered pants" }, // $18C7
{ "Cape"          , "Ekkhard cross"  }, // $18C8
{ "Cape"          , "Dragon Plate"   }, // $18C9
{ "Cape"          , "Leather pants"  }, // $18CA
{ "Cape"          , "Leather boots"  }, // $18CB
{ "Cape"          , "!"              }, // $18CC
{ "Cape"          , "Skeleton key"   }, // $18CD
{ "Cape"          , "Dex Helm"       }, // $18CE
{ "Cape"          , "Cross key"      }, // $18CF
{ "Cape"          , "Neta Shield"    }, // $18D0
{ "Cape"          , "Tattered pants" }, // $18D1
{ "Cape"          , "Jewel Symal"    }, // $18D2
{ "Cape"          , "Cloak of Night" }, // $18D3
{ "Cape"          , "Leather jerkin" }, // $18D4
{ "Cape"          , "Cheese"         }, // $18D5
{ "Cape"          , "Silk shirt"     }, // $18D6
{ "Cape"          , "Silk shirt"     }, // $18D7
{ "Cape"          , "Tabard"         }, // $18D8
{ "Cape"          , "Cape"           }, // $18D9
{ "Cape"          , "Gunna"          }, // $18DA
{ "Cape"          , "Tattered pants" }, // $18DB
{ "Cape"          , "!"              }, // $18DC
{ "Cape"          , "Mithral mail"   }, // $18DD
{ "Cape"          , "Armet"          }, // $18DE
{ "Cape"          , "Ekkhard Cross"  }, // $18DF
{ "Cape"          , "!"              }, // $18E0
{ "Cape"          , "Fine robe (bot)"}, // $18E1
{ "Cape"          , "Tattered shirt" }, // $18E2
{ "Cape"          , "Ekkhard Cross"  }, // $18E3
{ "Cape"          , "!"              }, // $18E4
{ "Cape"          , "Robe (bottom)"  }, // $18E5
{ "Cape"          , "Fine robe (top)"}, // $18E6
{ "Cape"          , "Ekkhard Cross"  }, // $18E7
{ "Cape"          , "!"              }, // $18E8
{ "Cape"          , "Tabard"         }, // $18E9
{ "Cape"          , "Fine robe (top)"}, // $18EA
{ "Cape"          , "Sar coin"       }, // $18EB
{ "Cape"          , "!"              }, // $18EC
{ "Cape"          , "Gunna"          }, // $18ED
{ "Cape"          , "Kirtle"         }, // $18EE
{ "Cape"          , "Ekkhard Cross"  }, // $18EF
{ "Cape"          , "!"              }, // $18F0
{ "Cape"          , "Robe (bottom)"  }, // $18F1
{ "Mail Aketon"   , "Fine robe (top)"}, // $18F2
{ "Mail Aketon"   , "Mail Aketon"    }, // $18F3
{ "Mail Aketon"   , "!"              }, // $18F4
{ "Fine robe (bot)","Silk shirt"     }, // $18F5
{ "Fine robe (bot)","Silk shirt"     }, // $18F6
{ "Elven doublet" , "Mail Aketon"    }, // $18F7
{ "Mithral mail"  , "!"              }, // $18F8
{ "Small shield"  , "!"              }, // $18F9
{ "Small shield"  , "!"              }, // $18FA
{ "Suede boots"   , "Ekkhard Cross"  }, // $18FB
{ "Bezerker helm" , "!"              }, // $18FC
{ "Silk shirt"    , "!"              }, // $18FD
{ "Basinet"       , "!"              }, // $18FE
{ "Basinet"       , "Cape"           }, // $18FF
};

MODULE const STRPTR tile[][6] = {
{ "221212", //  0 dungeon floor
  "222121",
  "122122",
  "211111",
  "122221",
  "212212"
},
{ "444442", //  1 wall
  "422221",
  "422221",
  "422221",
  "422221",
  "211111"
},
{ "111212", //  2 closed "vertical" door
  "112121",
  "4OOOO4",
  "4oooo4",
  "011110",
  "101101",
},
{ "111212", //  3 open "vertical" door
  "112121",
  "512125",
  "501125",
  "011121",
  "101112",
},
{ "111212", //  4 broken "vertical" door
  "112121",
  "412OO4",
  "4o11o4",
  "012121",
  "102112",
},
{ "221212", //  5 object
  "222121",
  "125522",
  "215511",
  "122221",
  "212212",
},
{ "444443", //  6 wall object
  "433332",
  "435532",
  "435532",
  "433332",
  "322222",
},
{ "221212", //  7 pit
  "200001",
  "100002",
  "200001",
  "100001",
  "212212",
},
{ "221212", //  8 fake pit. Original was:    "221212"
  "2GGGG1", //                               "2GGGG1"
  "1G0002", //                               "1G0002"
  "2GGG01", //                               "2GGG01"
  "1G0001", //                               "1G0001"
  "2G2212", //                               "212212"
},
{ "B2C2B2", //  9 blue haze
  "2C2C2C",
  "B2B1B2",
  "2C1C1C",
  "C2B2C1",
  "2B2C1C",
},
{ "221212", // 10 hidden pit
  "200001",
  "102102",
  "201101",
  "100001",
  "212212",
},
{ "22RR12", // 11 spinner
  "2R21R1",
  "R2212R",
  "R11R1R",
  "12RRR1",
  "212212",
},
{ "222221", // 12 fake wall
  "211110",
  "211110",
  "211110",
  "211110",
  "100000",
},
{ "333332", // 13 secret wall. Original was: "333332"
  "32YYY1", //                               "32YYY1"
  "3Y2221", //                               "3YY221"
  "32YY21", //                               "322YY1"
  "3222Y1", //                               "3YYY21"
  "2YYY11", //                               "211111"
},
{ "OOOoo2", // 14 stairs up   (E-W)
  "443322",
  "443322",
  "443322",
  "443322",
  "OOOoo2",
},
{ "2OOooo", // 15 stairs down (W-E)
  "221100",
  "221100",
  "221100",
  "221100",
  "2OOooo",
},
{ "--00--", // 16 unknown
  "-0--0-",
  "----0-",
  "---0--",
  "------",
  "---0--",
},
{ "224401", // 17 closed horizontal door
  "22Oo10",
  "12Oo11",
  "21Oo00",
  "12Oo10",
  "214401",
},
{ "oooOO2", // 18 stairs down (E-W)
  "001122",
  "001122",
  "001122",
  "001122",
  "oooOO2",
},
{ "o0000o", // 19 stairs down (S-N)
  "o0000o",
  "o1111o",
  "O1111O",
  "O2222O",
  "222222",
},
{ "222222", // 20 stairs down (N-S)
  "O2222O",
  "O1111O",
  "o1111o",
  "o0000o",
  "o0000o",
},
{ "2ooOOO", // 21 stairs up   (W-E)
  "223344",
  "223344",
  "223344",
  "223344",
  "2ooOOO",
},
{ "O4444O", // 22 stairs up   (S-N)
  "O4444O",
  "O3333O",
  "o3333o",
  "o2222o",
  "222222",
},
{ "222222", // 23 stairs up   (N-S)
  "o2222o",
  "o3333o",
  "O3333O",
  "O4444O",
  "O4444O",
},
{ "115501", // 24 open "horizontal" door
  "111010",
  "122111",
  "211111",
  "122221",
  "215512",
},
{ "114401", // 25 broken "horizontal" door
  "111o10",
  "122122",
  "21O222",
  "12Oo21",
  "214412",
},
{ "00--00", // 26 party north
  "0----0",
  "-0--0-",
  "00--00",
  "00--00",
  "00--00",
},
{ "000-00", // 27 party east
  "0000-0",
  "------",
  "------",
  "0000-0",
  "000-00",
},
{ "00--00", // 28 party south
  "00--00",
  "00--00",
  "-0--0-",
  "0----0",
  "00--00",
},
{ "00-000", // 29 party west
  "0-0000",
  "------",
  "------",
  "0-0000",
  "00-000",
},
{ "111111", // 30 void (DM2 only?)
  "111111",
  "111111",
  "111111",
  "111111",
  "111111",
},
{ "GG1G1G", // 31 outside floor (grass)
  "GGG1G1",
  "1GG1GG",
  "G11111",
  "1GGGG1",
  "G1GG1G"
},
{ "OO1O1O", // 32 cave floor
  "OOO1O1",
  "1OO1OO",
  "O11111",
  "1OOOO1",
  "O1OO1O"
},
};

MODULE const STRPTR topdust[2] =
{ "110101",
  "111010",
}, leftdust[6] =
{ "11",
  "11",
  "01",
  "10",
  "01",
  "10",
}, topleftdust[2] =
{ "01",
  "10",
}, FacingOptions[4] =
{ "North",
  "East",
  "South",
  "West"
  // NULL is not needed here
};

MODULE struct
{   int start,
        xsize,
        ysize,
        style;
} levelinfo[44];

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{         0x0000,                0x0000, // reserved

/*  The game also has a yellow pointer but it looks crap so we use the hand instead.

    221. .... .... ....    . = Transparent (%00)
    1221 2121 .... ....    1 = Brown       (%01) ($620)
    .122 1212 121. ....    2 = Skin        (%10) ($C86)
    ..12 2121 2121 ....
    ...1 2212 1212 1...
    ...1 2221 2121 21..
    11.. 1222 2222 21..
    221. 1222 2222 221.
    1221 1222 2222 221.
    1222 1222 2222 221.
    .122 2222 2222 221.
    .122 2222 2222 221.
    ..12 2222 2222 2221
    ...1 1222 2222 2222
    .... .112 2222 2222
    .... ...1 2222 2222

          Plane 0                Plane 1      
    ..1. .... .... ....    22.. .... .... ....
    1..1 .1.1 .... ....    .22. 2.2. .... ....
    .1.. 1.1. 1.1. ....    ..22 .2.2 .2.. ....
    ..1. .1.1 .1.1 ....    ...2 2.2. 2.2. ....
    ...1 ..1. 1.1. 1...    .... 22.2 .2.2 ....
    ...1 ...1 .1.1 .1..    .... 222. 2.2. 2...
    11.. 1... .... .1..    .... .222 2222 2...
    ..1. 1... .... ..1.    22.. .222 2222 22..
    1..1 1... .... ..1.    .22. .222 2222 22..
    1... 1... .... ..1.    .222 .222 2222 22..
    .1.. .... .... ..1.    ..22 2222 2222 22..
    .1.. .... .... ..1.    ..22 2222 2222 22..
    ..1. .... .... ...1    ...2 2222 2222 222.
    ...1 1... .... ....    .... .222 2222 2222
    .... .11. .... ....    .... ...2 2222 2222
    .... ...1 .... ....    .... .... 2222 2222
           Brown                   Skin

          Plane 0                Plane 1 */
          0x2000,                0xC000,
          0x9500,                0x6A00,
          0x4AA0,                0x3540,
          0x2550,                0x1AA0,
          0x12A8,                0x0D50,
          0x1154,                0x0EA8,
          0xC804,                0x07F8,
          0x2802,                0xC7FC,
          0x9802,                0x67FC,
          0x8802,                0x77FC,
          0x4002,                0x3FFC,
          0x4002,                0x3FFC,
          0x2001,                0x1FFE,
          0x1800,                0x07FF,
          0x0600,                0x01FF,
          0x0100,                0x00FF,

          0x0000,                0x0000, // reserved
};
#endif

// 8. CODE ---------------------------------------------------------------

EXPORT void dm_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // dm_preinit()
        NewList(&FacingList);
    }

    tool_open      = dm_open;
    tool_loop      = dm_loop;
    tool_save      = dm_save;
    tool_close     = dm_close;
    tool_exit      = dm_exit;
    tool_subgadget = dm_subgadget;

    if (loaded != FUNC_DM && !dm_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_DM;

    dm_getpens();
    make_speedbar_list(GID_DM_SB1);
    load_aiss_images(10, 10);
    ch_load_aiss_images(11, 14, FacingOptions, &FacingList);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_DM_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            AddHLayout,
                AddToolbar(GID_DM_SB1),
                AddSpace,
                AddVLayout,
                    AddSpace,
                    LAYOUT_AddChild,                       gadgets[GID_DM_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_DM_CH1,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_DM_CH3] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_DM_CH3,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &KindOptions,
                    ChooserEnd,
                    Label("Kind:"),
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_SBAR_VERT,
                LAYOUT_Label,                              "Party",
                LAYOUT_SpaceOuter,                         TRUE,
                AddHLayout,
                    LAYOUT_EvenSize,                       TRUE,
                    LAYOUT_AddChild,                       gadgets[GID_DM_BU3] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_DM_BU3,
                        GA_Text,                           "Character #1...",
                        GA_RelVerify,                      TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_DM_BU4] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_DM_BU4,
                        GA_Text,                           "Character #2...",
                        GA_RelVerify,                      TRUE,
                    ButtonEnd,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,                       TRUE,
                    LAYOUT_AddChild,                       gadgets[GID_DM_BU5] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_DM_BU5,
                        GA_Text,                           "Character #3...",
                        GA_RelVerify,                      TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_DM_BU6] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_DM_BU6,
                        GA_Text,                           "Character #4...",
                        GA_RelVerify,                      TRUE,
                    ButtonEnd,
                LayoutEnd,
                AddHLayout,
                    AddSpace,
                    MaximizeButton(GID_DM_BU2, "Maximize Party"),
                    CHILD_WeightedWidth,                   0,
                    AddSpace,
                LayoutEnd,
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_SBAR_VERT,
                LAYOUT_Label,                              "Dungeon",
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_SpaceInner,                         TRUE,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_DM_IN80] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_DM_IN80,
                        GA_RelVerify,                      TRUE,
                        INTEGER_Minimum,                   1,
                        INTEGER_Maximum,                   numlevels,
                        INTEGER_Number,                    dgnlevel,
                        INTEGER_MinVisible,                2 + 1,
                    IntegerEnd,
                    Label("Level:"),
                    CHILD_WeightedWidth,                   0,
                    AddLabel("of"),
                    CHILD_WeightedWidth,                   0,
                    LAYOUT_AddChild,                       gadgets[GID_DM_IN81] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_DM_IN81,
                        GA_ReadOnly,                       TRUE,
                        INTEGER_Arrows,                    FALSE,
                        INTEGER_Number,                    numlevels,
                        INTEGER_MinVisible,                2,
                    IntegerEnd,
                    CHILD_WeightedWidth,                   0,
                    LAYOUT_AddChild,                       gadgets[GID_DM_SL1] = (struct Gadget*)
                    SliderObject,
                        GA_ID,                             GID_DM_SL1,
                        GA_RelVerify,                      TRUE,
                        SLIDER_Min,                        1,
                        SLIDER_Max,                        numlevels,
                        SLIDER_KnobDelta,                  1,
                        SLIDER_Orientation,                SLIDER_HORIZONTAL,
                        SLIDER_Ticks,                      numlevels,
                        SLIDER_Level,                      dgnlevel,
                    SliderEnd,
                LayoutEnd,
                LAYOUT_AddChild,                           gadgets[GID_DM_ST34] = (struct Gadget*)
                StringObject,
                    GA_ID,                                 GID_DM_ST34,
                    GA_ReadOnly,                           TRUE,
                    GA_Disabled,                           (game >= DM2) ? TRUE : FALSE,
                    STRINGA_TextVal,                       "-",
                StringEnd,
                Label("Description:"),
                AddHLayout,
                    AddSpace,
                    LAYOUT_AddChild,                       gadgets[GID_DM_SP1] = (struct Gadget*)
                    SpaceObject,
                        GA_ID,                             GID_DM_SP1,
                        SPACE_MinWidth,                    SCALEDWIDTH,
                        SPACE_MinHeight,                   SCALEDHEIGHT,
                        SPACE_BevelStyle,                  BVS_FIELD,
                        SPACE_Transparent,                 TRUE,
                    SpaceEnd,
                    CHILD_WeightedWidth,                   0,
                    AddSpace,
                LayoutEnd,
                LAYOUT_AddChild,                           gadgets[GID_DM_ST33] = (struct Gadget*)
                StringObject,
                     GA_ID,                                GID_DM_ST33,
                     GA_ReadOnly,                          TRUE,
                     STRINGA_TextVal,                      "-",
                StringEnd,
                Label("Contents:"),
                AddHLayout,
                    LAYOUT_AddChild,                       gadgets[GID_DM_SP2] = (struct Gadget*)
                    SpaceObject,
                        GA_ID,                             GID_DM_SP2,
                        SPACE_MinWidth,                    TILESWIDTH,
                        SPACE_MinHeight,                   TILESHEIGHT,
                        SPACE_BevelStyle,                  BVS_NONE,
                        SPACE_Transparent,                 TRUE,
                    SpaceEnd,
                    CHILD_WeightedWidth,                   0,
                    AddSpace,
                LayoutEnd,
                Label("Tool:"),
                LAYOUT_AddChild,                           gadgets[GID_DM_CH2] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                 GID_DM_CH2,
                    GA_RelVerify,                          TRUE,
                    CHOOSER_Labels,                        &FacingList,
                    CHOOSER_Selected,                      (WORD) facing,
                PopUpEnd,
                Label("Facing:"),
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_DM_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif

    setup_bm(0, SCALEDWIDTH, SCALEDHEIGHT, MainWindowPtr);
    setup_bm(1, TILESWIDTH , TILESHEIGHT , MainWindowPtr);

    writegadgets(); // do this before dm_drawmap()!
    dm_drawmap();
 // ActivateLayoutGadget(gadgets[GID_DM_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_DM_ST1]);
    lmb = FALSE;
    loop();
    readgadgets();
    closewindow();
}

EXPORT void dm_loop(ULONG gid, ULONG code)
{   int i;

    switch (gid)
    {
    case GID_DM_BU2:
        // assert(men);
        readgadgets();
        for (i = 0; i < men; i++)
        {   maximize_man(i);
        }
        writegadgets();
    acase GID_DM_BU3:
        who = 0;
        manwindow();
    acase GID_DM_BU4:
        who = 1;
        manwindow();
    acase GID_DM_BU5:
        who = 2;
        manwindow();
    acase GID_DM_BU6:
        who = 3;
        manwindow();
    acase GID_DM_SL1:
        dgnlevel = code;
        gadmode = SERIALIZE_WRITE;
        either_in(GID_DM_IN80, &dgnlevel);
        if (game >= DM2)
        {   SetGadgetAttrs(gadgets[GID_DM_ST34], MainWindowPtr, NULL, STRINGA_TextVal, DM2DungeonName[dgnlevel - 1], TAG_END);
        } else
        {   SetGadgetAttrs(gadgets[GID_DM_ST34], MainWindowPtr, NULL, STRINGA_TextVal, DM1DungeonName[dgnlevel - 1], TAG_END);
        }
        dm_drawmap();
    acase GID_DM_IN80:
        gadmode = SERIALIZE_READ;
        either_in(GID_DM_IN80, &dgnlevel);
        gadmode = SERIALIZE_WRITE;
        either_sl(GID_DM_SL1, &dgnlevel);
        if (game >= DM2)
        {   SetGadgetAttrs(gadgets[GID_DM_ST34], MainWindowPtr, NULL, STRINGA_TextVal, DM2DungeonName[dgnlevel - 1], TAG_END);
        } else
        {   SetGadgetAttrs(gadgets[GID_DM_ST34], MainWindowPtr, NULL, STRINGA_TextVal, DM1DungeonName[dgnlevel - 1], TAG_END);
        }
        dm_drawmap();
    acase GID_DM_CH2:
        GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_DM_CH2], (ULONG*) &facing);
        dm_drawmap();
}   }

EXPORT FLAG dm_open(FLAG loadas)
{   int i;

    if (!reopening)
    {   choice = -1;
    }

    if (!gameopen(loadas))
    {   return FALSE;
    } // implied else

    serializemode = SERIALIZE_READ;
    offset = 0;

    switch (gamesize)
    {
    case  2065: // FM Towns/PC-98 compressed
    case  2600: // FM Towns/PC-98 uncompressed
        game = CSB_PC9801;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 2066: // X68000 compressed
    case  2602: // X68000 uncompressed
        game = CSB;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 2076: // Amiga compressed
    case  2091: // Amiga compressed
    case  2618: // Amiga uncompressed
    case  2624: // Amiga uncompressed
        game = CSB;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 2098: // compressed
    case  2622: // uncompressed
        if (choice == -1)
        {   choice = ask("Which platform is this for?", "Amiga|FM Towns");
        }
        if (choice == 0) // Amiga
        {   game = CSB;
        } else
        {   game = CSB_PC9801;
        }
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 4806: // Amiga compressed
    case  6359: // Amiga uncompressed
        game = DM1_2X;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 4958: // Apple ][GS compressed
    case  6562: // Apple ][GS uncompressed
        game = DM1_APPLE;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 6535:
        if (choice == -1)
        {   choice = ask("Which platform is this for?", "IBM PC|Macintosh");
        }
        if (choice == 0) // IBM PC
        {   game = DM2_LE;
        } else
        {   game = DM2;
        }
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 25006: // compressed
    case  33444: // uncompressed
        if (choice == -1)
        {   choice = ask("Which platform is this for?", "Amiga|Apple ][GS");
        }
        if (choice == 0)
        {   game = DM1_36;
        } else
        {   game = DM1_APPLE;
        }
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 25380: // Amiga compressed
    case  25414: // Amiga compressed
    case  33792: // Atari ST or Amiga uncompressed
    case  33286: // Atari ST
    case  33314: // Atari ST
    case  33442: // Atari ST
    case  33774: // Atari ST or Amiga uncompressed
        game = DM1_2X;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 32655: // Atari ST
        game = CSB_ATARI;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 32688: // Amiga
        game = CSB_ENG;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 32776: // French Amiga
    case  32780: // German Amiga
        game = CSB_FRAGER;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 32684: // FM Towns
    case  33116: // FM Towns
        game = CSB_PC9801;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 33124:
        if (choice == -1)
        {   choice = ask("Which platform is this for?", "PC-98|X68000");
        }
        if (choice == 0) // PC-98
        {   game = CSB_PC9801;
        } else
        {   game = CSB;
        }
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 33357: // IBM
    case  33380: // SNES
    case  33423: // FM Towns
    case  33687: // IBM
    case  33705: // IBM
    case  33931: // FM Towns
        game = DM1_IBM;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 33990: // X68000
        game = DM1_36;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 37957:
        if (choice == -1)
        {   choice = ask("Which game is this for?", "CSB|DM2");
        }
        if (choice == 0) // CSB
        {   game = CSB;    // Mac/Sega CD
        } else
        {   game = DM2_LE; // IBM PS-V/PC-9821
        }
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase  39411: // Amiga/Mac
        game = DM2;
        kind = KIND_DUNGEON;
        parse_dungeon();
    acase 37954: // FM Towns
    case  39004: // PC-98
    case  39437: // MS-DOS
    case  39554: // MS-DOS
        game = DM2_LE;
        kind = KIND_DUNGEON;
        parse_dungeon();
    adefault:
        for (i = 0; i < 9; i++)
        {   game = i;
            kind = KIND_SAVEGAME;
            offset = 0;
            if (DecodeSavedGame())
            {   goto DONE;
        }   }

        if     (IOBuffer[0] == 0x00 && IOBuffer[1] == 0x01)
        {   game = DM2;
            kind = KIND_SAVEGAME;
            offset = 0x2A;
            parse_dungeon();
            dm2_loadgame();
        } elif (IOBuffer[0] == 0x01 && IOBuffer[1] == 0x00)
        {   game = DM2_LE;
            kind = KIND_SAVEGAME;
            offset = 0x2A;
            parse_dungeon();
            dm2_loadgame();
        } else
        {   say("Unknown file format!", REQIMAGE_WARNING);
            return FALSE;
    }   }

DONE:
    if
    (   (brushpos ==  0 && (game >= DM2 || kind != KIND_SAVEGAME))
     || (brushpos == 10 &&  game <  DM2)
    )
    {   brushpos = 1;
    }

    if (MainWindowPtr)
    {   writegadgets(); // do this before dm_drawmap()!
        dm_drawmap();
    }

    return TRUE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_DM
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;

    either_ch(GID_DM_CH1, &game);
    either_ch(GID_DM_CH3, &kind);

    if ((int) dgnlevel > numlevels)
    {   dgnlevel = numlevels;
    }
    SetGadgetAttrs(gadgets[GID_DM_IN80], MainWindowPtr, NULL, INTEGER_Number, dgnlevel, INTEGER_Maximum, numlevels,                          TAG_END);
    SetGadgetAttrs(gadgets[GID_DM_SL1 ], MainWindowPtr, NULL, SLIDER_Level,   dgnlevel, SLIDER_Max     , numlevels, SLIDER_Ticks, numlevels, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_DM_SL1], MainWindowPtr, NULL); // needed to redraw SLIDER_Ticks
    if (game >= DM2)
    {   SetGadgetAttrs(gadgets[GID_DM_ST34], MainWindowPtr, NULL, STRINGA_TextVal, DM2DungeonName[dgnlevel - 1], TAG_END);
    } else
    {   SetGadgetAttrs(gadgets[GID_DM_ST34], MainWindowPtr, NULL, STRINGA_TextVal, DM1DungeonName[dgnlevel - 1], TAG_END);
    }
    SetGadgetAttrs(gadgets[GID_DM_IN81], MainWindowPtr, NULL,                           INTEGER_Number , numlevels,                          TAG_END);
    SetGadgetAttrs(gadgets[GID_DM_CH2 ], MainWindowPtr, NULL, CHOOSER_Selected, (UWORD) facing, TAG_END);

    ghost(GID_DM_BU2, (kind != KIND_SAVEGAME || men < 1) ? TRUE : FALSE);
    ghost(GID_DM_BU3, (kind != KIND_SAVEGAME || men < 1) ? TRUE : FALSE);
    ghost(GID_DM_BU4, (kind != KIND_SAVEGAME || men < 2) ? TRUE : FALSE);
    ghost(GID_DM_BU5, (kind != KIND_SAVEGAME || men < 3) ? TRUE : FALSE);
    ghost(GID_DM_BU6, (kind != KIND_SAVEGAME || men < 4) ? TRUE : FALSE);
    ghost(GID_DM_CH2, (kind != KIND_SAVEGAME           ) ? TRUE : FALSE);

    eithergadgets();
}

MODULE void eithergadgets(void) { ; }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

EXPORT void dm_save(FLAG saveas)
{   int    creaturesize,
           i, j;
    FLAG   finished;
    UWORD  block2sum,
           checksum;
    UBYTE* byteptr;

    readgadgets();
    serializemode = SERIALIZE_WRITE;
    offset = 0;

    if (game < DM2 && kind == KIND_SAVEGAME)
    {   byteptr = (UBYTE*) champdata;

        for (i = 0; i < 4; i++)
        {   finished = FALSE;
            for (j = 0; j < 8; j++)
            {   if (finished)
                {   byteptr[(i * mansize)     + j] = EOS;
                } elif (name[i][j] == EOS)
                {   finished = TRUE;
                }
                byteptr[    (i * mansize)     + j] = toupper(name[ i][j]);
            }
            finished = FALSE;
            for (j = 0; j < 16; j++)
            {   if (finished)
                {   byteptr[(i * mansize) + 8 + j] = EOS;
                } elif (title[i][j] == EOS)
                {   finished = TRUE;
                }
                byteptr[    (i * mansize) + 8 + j] = toupper(title[i][j]);
            }

            champdata[    (i * (mansize / 2)) + ( 52 / 2)] = curhp[i];
            champdata[    (i * (mansize / 2)) + ( 54 / 2)] = maxhp[i];
            champdata[    (i * (mansize / 2)) + ( 56 / 2)] = curstamina[i];
            champdata[    (i * (mansize / 2)) + ( 58 / 2)] = maxstamina[i];
            champdata[    (i * (mansize / 2)) + ( 60 / 2)] = curmana[i];
            champdata[    (i * (mansize / 2)) + ( 62 / 2)] = maxmana[i];
            champdata[    (i * (mansize / 2)) + ( 66 / 2)] = food[i];
            champdata[    (i * (mansize / 2)) + ( 68 / 2)] = water[i];
            for (j = 0; j < 7; j++)
            {   byteptr[  (i *  mansize     ) +   70      + (j * 3)] = maxstat[i][j]; 
                byteptr[  (i *  mansize     ) +   71      + (j * 3)] = curstat[i][j]; 
                byteptr[  (i *  mansize     ) +   72      + (j * 3)] = minstat[i][j];
            }
            if (formats[game].littleendian)
            {   for (j = 0; j < 20; j++)
                {   byteptr[(i * mansize    ) +   97      + (j * 6)] =  level[i][j] / 16777216;
                    byteptr[(i * mansize    ) +   96      + (j * 6)] = (level[i][j] % 16777216) / 65536;
                    byteptr[(i * mansize    ) +   95      + (j * 6)] = (level[i][j] %    65536) /   256;
                    byteptr[(i * mansize    ) +   94      + (j * 6)] =  level[i][j]             %   256;
            }   }
            else
            {   for (j = 0; j < 20; j++)
                {   byteptr[(i * mansize    ) +   94      + (j * 6)] =  level[i][j] / 16777216;
                    byteptr[(i * mansize    ) +   95      + (j * 6)] = (level[i][j] % 16777216) / 65536;
                    byteptr[(i * mansize    ) +   96      + (j * 6)] = (level[i][j] %    65536) /   256;
                    byteptr[(i * mansize    ) +   97      + (j * 6)] =  level[i][j]             %   256;
            }   }
            for (j = 0; j < 30; j++)
            {   champdata[(i * (mansize / 2)) + (212 / 2) +  j     ] =  item[ i][j];
        }   }

        creaturesize  = block3[23] * 16;
        block3[6]     = loc_x;
        block3[7]     = loc_y;
        block3[8]     = facing;
        block3[9]     = loc_lvl;

        if (game >= CSB)
        {   block2[46] = dm1_encrypt(champdata, block2[30], formats[game].champsize);
            block2[44] = dm1_encrypt(block3   , block2[28], 128 / 2);
        } else
        {   block2[45] = dm1_encrypt(champdata, block2[29], formats[game].champsize);
            block2[43] = dm1_encrypt(block3   , block2[27], 128 / 2);
        }

        block2sum = 0;
        for (i = 0; i < 128; i++)
        {   block2sum += block2[i]; // overflow is OK
        }

        // Compute the block2 stored checksum based on block1 contents
        block1sum = 0;
        for (i = 0; i < 124; i += 4)
        {   block1sum += block1[i    ];
            block1sum ^= block1[i + 1];
            block1sum -= block1[i + 2];
            block1sum ^= block1[i + 3];
        }
        block1sum += block1[124];
        block1sum ^= block1[125];
        block1sum -= block1[126];
        block1[127] = block1sum ^ block2sum;

        DISCARD dm1_encrypt(block2, block1[formats[game].keyoffset], 128);
        // The value returned by the dm1_encrypt() function is meaningless for block 2;
        // the block 2 checksum must be computed using another algorithm.

        offset = formats[game].header ? 2 : 0;
        for (i = 0; i <                     128; i++) doword(&block1[i]);
        for (i = 0; i <                     128; i++) doword(&block2[i]);
        for (i = 0; i <                      64; i++) doword(&block3[i]);
        offset += creaturesize;
        for (i = 0; i < formats[game].champsize; i++) doword(&champdata[i]);
    }

    if (gamesize > mapstart + mapsize && (game < DM2 || kind != KIND_SAVEGAME))
    {   checksum = 0;
        for (i = dungeonstart; i < mapstart + mapsize; i++)
        {   checksum += IOBuffer[i]; // overflow is OK
        }

#ifdef LOGSERIALIZATION
        printf("Putting checksum $%04X at offset $%X!\n", mapstart + mapsize, checksum);
#endif

        if (formats[game].littleendian)
        {   IOBuffer[mapstart + mapsize    ] = checksum % 256;
            IOBuffer[mapstart + mapsize + 1] = checksum / 256;
        } else
        {   IOBuffer[mapstart + mapsize    ] = checksum / 256;
            IOBuffer[mapstart + mapsize + 1] = checksum % 256;
    }   }

    if (game >= DM2 && kind == KIND_SAVEGAME)
    {   dm2_savegame();
    }

    if (kind == KIND_SAVEGAME)
    {   if   (game >= DM2) gamesave( "SKSAVE#?.DAT", "Dungeon Master 2",   saveas, gamesize, FLAG_S, FALSE);
        elif (game >= CSB) gamesave(       "#?.DAT", "Chaos Strikes Back", saveas, gamesize, FLAG_S, FALSE);
        else               gamesave(     "DM#?.DAT", "Dungeon Master 1",   saveas, gamesize, FLAG_S, FALSE);
    } else
    {   // assert(king == KIND_DUNGEON);
        if   (game >= DM2) gamesave("DUNGEON#?.DAT", "Dungeon Master 2",   saveas, gamesize, FLAG_L, FALSE);
        elif (game >= CSB) gamesave(       "#?.DAT", "Chaos Strikes Back", saveas, gamesize, FLAG_L, FALSE);
        else               gamesave("DUNGEON#?.DAT", "Dungeon Master 1",   saveas, gamesize, FLAG_L, FALSE);
    }

    reopening = TRUE;
    project_open(FALSE); // because otherwise if we save twice we encrypt already-encrypted data
    reopening = FALSE;
}

MODULE void maximize_man(int whichman)
{   int i;

    for (i = 0; i < 7; i++)
    {   maxstat[whichman][i] =
        curstat[whichman][i] =
        minstat[whichman][i] =       250;
    }
    curhp[      whichman]    =
    maxhp[      whichman]    =
    curstamina[ whichman]    =
    maxstamina[ whichman]    =
    curmana[    whichman]    =
    maxmana[    whichman]    =
    food[       whichman]    =
    water[      whichman]    =     30000;
    for (i = 0; i < 20; i++)
    {   level[  whichman][i] = 900000000;
    }
    if (game >= DM2)
    {   for (i = 0; i < 20; i++)
        {   bonus[whichman][i] =     250;
}   }   }

MODULE UWORD dm1_decrypt(UWORD* section, ULONG Key, ULONG NumberOfWords)
{   UWORD decrypt,
          TempValue;
    int   i;

    TempValue = decrypt = Key;
    for (i = 0; i < (int) NumberOfWords; i++)
    {   decrypt    += section[i]; // overflow is OK
        section[i] ^= TempValue;
        decrypt    += section[i]; // overflow is OK
        TempValue  += NumberOfWords - i; // overflow is OK
    }

    return decrypt;
}

MODULE UWORD dm1_encrypt(UWORD* section, ULONG Key, ULONG NumberOfWords)
{   UWORD encrypt,
          TempValue;
    int   i;

    TempValue = encrypt = Key;
    for (i = 0; i < (int) NumberOfWords; i++)
    {   encrypt    += section[i]; // overflow is OK
        section[i] ^= TempValue;
        encrypt    += section[i]; // overflow is OK
        TempValue  += NumberOfWords - i; // overflow is OK
    }

    return encrypt;
}

MODULE FLAG DecodeSavedGame(void)
{   int    i, j;
    UWORD  block2sum,
           block3calcsum,
           block3key,
           block3storedsum,
           champcalcsum,
           champkey,
           champstoredsum,
           timers;
    UBYTE* byteptr;

    if (formats[game].header)
    {
#ifdef LOGSERIALIZATION
        printf("File header  at $%4X...\n", offset);
#endif
        offset += 2;
    }

#ifdef LOGSERIALIZATION
    printf(    "Block 1      at $%4X...\n", offset);
#endif
    for (i = 0; i < 128; i++) doword(&block1[i]);
#ifdef LOGSERIALIZATION
    printf("Block 2      at $%4X...\n", offset);
#endif
    for (i = 0; i < 128; i++) doword(&block2[i]);
#ifdef LOGSERIALIZATION
    printf("Block 3      at $%4X...\n", offset);
#endif
    for (i = 0; i <  64; i++) doword(&block3[i]);

    // Compute the block2 stored checksum based on block1 contents
    block1sum = 0;
    for (i = 0; i < 128; i += 4)
    {   block1sum += block1[i    ];
        block1sum ^= block1[i + 1];
        block1sum -= block1[i + 2];
        block1sum ^= block1[i + 3];
    }

    // Decrypt block 2
    DISCARD dm1_decrypt(block2, block1[formats[game].keyoffset], 128);
    // The value returned by the dm1_decrypt() function is meaningless for block 2;
    // the block 2 checksum must be computed using another algorithm.
    block2sum = 0;
    for (i = 0; i < 128; i++)
    {   block2sum += block2[i]; // overflow is OK
    }
    if (block1sum != block2sum)
    {
#ifdef LOGSERIALIZATION
        printf("For game #%d, block1sum != block2sum\n", game);
#endif
        return FALSE;
    }

    // Decryption keys and stored checksum values of subsequent blocks are stored at different offsets in DM and CSB
    if (game >= CSB)
    {   block3key       = block2[28];
        champkey        = block2[30];
        block3storedsum = block2[44];
        champstoredsum  = block2[46];
    } else
    {   block3key       = block2[27];
        champkey        = block2[29];
        block3storedsum = block2[43];
        champstoredsum  = block2[45];
    }

    // Decrypt block 3
    block3calcsum = dm1_decrypt(block3, block3key, 64);
    if (block3calcsum != block3storedsum)
    {
#ifdef LOGSERIALIZATION
        printf("For game #%d, block3calcsum != block3storedsum\n", game);
#endif
        return FALSE;
    }

    men       = block3[ 5];
    loc_x     = block3[ 6];
    loc_y     = block3[ 7];
    facing    = block3[ 8];
    loc_lvl   = block3[ 9];
    timers    = block3[14];
#ifdef LOGSERIALIZATION
    printf("Creatures    at $%4X... (%d creatures)\n", offset, block3[23]);
#endif
    offset += block3[23] * 16; // creatures data
#ifdef LOGSERIALIZATION
    printf("Champ  data  at $%4X...\n", offset);
#endif

    for (i = 0; i < formats[game].champsize; i++) doword(&champdata[i]);
    champcalcsum = dm1_decrypt(champdata, champkey, formats[game].champsize);
    if (champcalcsum != champstoredsum)
    {
#ifdef LOGSERIALIZATION
        printf("For game #%d, champcalcsum != champstoredsum\n", game);
#endif
        return FALSE;
    }

    byteptr = (UBYTE*) champdata;
    mansize = ((formats[game].champsize * 2) - 128) / 4; // in bytes
    for (i = 0; i < 4; i++)
    {   for (j = 0; j < 8; j++)
        {   name[ i][j] = byteptr[(i * mansize)     + j];
        }
        name[i][8] = EOS;

        for (j = 0; j < 16; j++)
        {   title[i][j] = byteptr[(i * mansize) + 8 + j];
        }
        title[i][16] = EOS;

        curhp[     i]   = (ULONG) champdata[(i * (mansize / 2)) + ( 52 / 2)];
        maxhp[     i]   = (ULONG) champdata[(i * (mansize / 2)) + ( 54 / 2)];
        curstamina[i]   = (ULONG) champdata[(i * (mansize / 2)) + ( 56 / 2)];
        maxstamina[i]   = (ULONG) champdata[(i * (mansize / 2)) + ( 58 / 2)];
        curmana[   i]   = (ULONG) champdata[(i * (mansize / 2)) + ( 60 / 2)];
        maxmana[   i]   = (ULONG) champdata[(i * (mansize / 2)) + ( 62 / 2)];
        food[      i]   = (ULONG) champdata[(i * (mansize / 2)) + ( 66 / 2)];
        water[     i]   = (ULONG) champdata[(i * (mansize / 2)) + ( 68 / 2)];
        for (j = 0; j < 7; j++)
        {   maxstat[i][j] = (ULONG) byteptr[(i *  mansize     ) +   70      + (j * 3)];
            curstat[i][j] = (ULONG) byteptr[(i *  mansize     ) +   71      + (j * 3)];
            minstat[i][j] = (ULONG) byteptr[(i *  mansize     ) +   72      + (j * 3)];
        }
        if (formats[game].littleendian)
        {   for (j = 0; j < 20; j++)
            {   level[i][j] =      (byteptr[(i *  mansize     ) +   97      + (j * 6)] * 16777216)
                            +      (byteptr[(i *  mansize     ) +   96      + (j * 6)] *    65536)
                            +      (byteptr[(i *  mansize     ) +   95      + (j * 6)] *      256)
                            +       byteptr[(i *  mansize     ) +   94      + (j * 6)];
            }
        } else
        {   for (j = 0; j < 20; j++)
            {   level[i][j] =      (byteptr[(i *  mansize     ) +   94      + (j * 6)] * 16777216)
                            +      (byteptr[(i *  mansize     ) +   95      + (j * 6)] *    65536)
                            +      (byteptr[(i *  mansize     ) +   96      + (j * 6)] *      256)
                            +       byteptr[(i *  mansize     ) +   97      + (j * 6)];
        }   }
        for (j = 0; j < 30; j++)
        {   item[i][j] =          champdata[(i * (mansize / 2)) + (212 / 2) +  j     ];
    }   }

#ifdef LOGSERIALIZATION
    printf(    "Timers data  at $%4X... (%d timers)\n", offset, timers);
#endif
    offset += timers * formats[game].timersize; // skip timers data
#ifdef LOGSERIALIZATION
    printf(    "Timers queue at $%4X... (%d timers)\n", offset, timers);
#endif
    offset += timers *                       2; // skip timers queue
    if (!formats[game].portraits) // if portraits are not in champ data, they will be here instead
    {
#ifdef LOGSERIALIZATION
        printf("Portraits    at $%4X...\n", offset);
#endif
        offset += 464 * 4;                      // skip portraits
    }
#ifdef LOGSERIALIZATION
    printf(    "Dungeon hdr  at $%4X...\n", offset);
#endif

    parse_dungeon();

#ifdef LOGSERIALIZATION
    printf("Successful for game #%d.\n", game);
#endif
    return TRUE;
}

EXPORT void dm_close(void) { ; }

EXPORT void dm_exit(void)
{   ch_clearlist(&FacingList);
}

EXPORT void dm_drawmap(void)
{   UBYTE value1, value2;
    int   colour,
          x,  y,
          xx, yy;

    leftx = (SCALEDWIDTH  - (levelinfo[dgnlevel - 1].xsize * 12)) / 2;
    topy  = (SCALEDHEIGHT - (levelinfo[dgnlevel - 1].ysize * 12)) / 2;

    if (leftx)
    {   for (y = 0; y < SCALEDHEIGHT; y++)
        {   for (x = 0; x < leftx; x++)
            {   *(byteptr1[                   y]                   + x) =
                *(byteptr1[                   y] + SCALEDWIDTH - 1 - x) = pens[0];
    }   }   }
    if (topy)
    {   for (y = 0; y < topy; y++)
        {   for (x = 0; x < SCALEDWIDTH; x++)
            {   *(byteptr1[                   y]                   + x) =
                *(byteptr1[SCALEDHEIGHT - 1 - y]                   + x) = pens[0];
    }   }   }

    for (    y = 0; y < levelinfo[dgnlevel - 1].ysize; y++)
    {   for (x = 0; x < levelinfo[dgnlevel - 1].xsize; x++)
        {   switch (getsquare(x, y))
            {
            case    0:
            case    1:
            case    2:
            case    3:
            case    4:
            case    5:
            case    6:
            case    7:
            case    8:
            case    9:
            case   10:
            case   11:
            case   12:
            case   13:
            case   14:
            case   15: drawtile(x, y,  1); // wall

            acase  16:
            case   17:
            case   18:
            case   19:
            case   20:
            case   21:
            case   22:
            case   23:
            case   24:
            case   25:
            case   26:
            case   27:
            case   28:
            case   29:
            case   30:
            case   31: drawtile(x, y,  6); // wall object

            acase  32:
            case   34: // same as  32?
            case   40:
            case  180:
            case  182: // same as 180?
            case  196:
            case  204: if (levelinfo[dgnlevel - 1].style == 1)
                       {   drawtile(x, y, 31); // grass
                       } elif (levelinfo[dgnlevel - 1].style == 2)
                       {   drawtile(x, y, 32); // cave floor
                       } else
                       {   drawtile(x, y,  0); // dungeon floor
                       }
            acase  46:
            case   47:
            case   48:
            case   49:
            case   50:
            case   51:
            case   52:
            case   53:
            case   54:
            case   55:
            case   56:
            case   57:
            case   58:
            case   59: drawtile(x, y,  5); // floor object

            acase  64:
            case   68:
            case   72:
            case   74: // same as  72?
            case   88:
            case   92: drawtile(x, y,  7); // pit

            acase  73: drawtile(x, y,  8); // fake pit

            acase  76:
            case   80:
            case   84: drawtile(x, y, 10); // hidden pit

            acase  96:
            case  112:                     // vertical stairs down
                if (x >= 1 && getsquare(x - 1, y) <= 31)
                {   drawtile(x, y, 18); // stairs down (E-W)
                } else
                {   drawtile(x, y, 15); // stairs down (W-E)
                }

            acase 104:
            case  120:                     // horizontal stairs down
                if (y >= 1 && getsquare(x, y - 1) <= 31)
                {   drawtile(x, y, 19); // stairs down (S-N)
                } else
                {   drawtile(x, y, 20); // stairs down (N-S)
                }

            acase 100:
            case  116:                     // vertical stairs up
                if (x >= 1 && getsquare(x - 1, y) <= 31)
                {   drawtile(x, y, 14); // stairs up (E-W)
                } else
                {   drawtile(x, y, 21); // stairs up (W-E)
                }

            acase 108:                     // horizontal stairs up
            case  124:
                if (y >= 1 && getsquare(x, y - 1) <= 31)
                {   drawtile(x, y, 22); // stairs up (S-N)
                } else
                {   drawtile(x, y, 23); // stairs up (N-S)
                }

            acase 144: drawtile(x, y, 24); // open   "horizontal" door
            case  152: drawtile(x, y,  3); // open   "vertical"   door

            acase 145:
            case  146:
            case  147:
            case  148: drawtile(x, y, 17); // closed "horizontal" door

            acase 153:
            case  154:
            case  155:
            case  156: drawtile(x, y,  2); // closed "vertical"   door

            acase 149: drawtile(x, y, 25); // broken "horizontal" door
            case  157: drawtile(x, y,  4); // broken "vertical"   door

            acase 176:
            case  184: drawtile(x, y, 11); // spinner

            acase 188: drawtile(x, y,  9); // blue haze

            acase 192:
            case  200:
            case  201:
            case  208:
            case  209:
            case  212: drawtile(x, y, 12); // fake wall

            acase 193: drawtile(x, y, 13); // secret

            acase 224: drawtile(x, y, 30); // void

            adefault:  drawtile(x, y, 16); // unknown
    }   }   }

    for (    y = 0; y < levelinfo[dgnlevel - 1].ysize; y++)
    {   for (x = 0; x < levelinfo[dgnlevel - 1].xsize; x++)
        {   value1 = getsquare(x, y);
            if
            (    value1 ==  32
             ||  value1 ==  40
             || (value1 >=  46 && value1 <= 59)
             ||  value1 == 180
             ||  value1 == 196
             ||  value1 == 204
            )
            {   if (y >= 1)
                {   value2 = getsquare(x, y - 1);
                    if (value2 <= 31)
                    {   for (yy = 0; yy < 2; yy++)
                        {   for (xx = 0; xx < 6; xx++)
                            {   switch (topdust[yy][xx])
                                {
                                case  '0': colour =  0;
                                acase '1': colour =  1;
                                adefault:  colour = 13;
                                }
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2)    ] + leftx + (x * MAPSCALE) + (xx * 2)    ) =
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2)    ] + leftx + (x * MAPSCALE) + (xx * 2) + 1) =
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2) + 1] + leftx + (x * MAPSCALE) + (xx * 2)    ) =
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2) + 1] + leftx + (x * MAPSCALE) + (xx * 2) + 1) = pens[colour];
                }   }   }   }

                if (x >= 1)
                {   value2 = getsquare(x - 1, y);
                    if (value2 <= 31)
                    {   for (yy = 0; yy < 6; yy++)
                        {   for (xx = 0; xx < 2; xx++)
                            {   switch (leftdust[yy][xx])
                                {
                                case  '0': colour =  0;
                                acase '1': colour =  1;
                                adefault:  colour = 13;
                                }
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2)    ] + leftx + (x * MAPSCALE) + (xx * 2)    ) =
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2)    ] + leftx + (x * MAPSCALE) + (xx * 2) + 1) =
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2) + 1] + leftx + (x * MAPSCALE) + (xx * 2)    ) =
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2) + 1] + leftx + (x * MAPSCALE) + (xx * 2) + 1) = pens[colour];
                }   }   }   }

                if (x >= 1 && y >= 1)
                {   value2 = getsquare(x - 1, y - 1);
                    if (value2 <= 31)
                    {   for (yy = 0; yy < 2; yy++)
                        {   for (xx = 0; xx < 2; xx++)
                            {   switch (topleftdust[yy][xx])
                                {
                                case  '0': colour =  0;
                                acase '1': colour =  1;
                                adefault:  colour = 13;
                                }
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2)    ] + leftx + (x * MAPSCALE) + (xx * 2)    ) =
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2)    ] + leftx + (x * MAPSCALE) + (xx * 2) + 1) =
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2) + 1] + leftx + (x * MAPSCALE) + (xx * 2)    ) =
                                *(byteptr1[(y * MAPSCALE) + topy + (yy * 2) + 1] + leftx + (x * MAPSCALE) + (xx * 2) + 1) = pens[colour];
    }   }   }   }   }   }   }

    // We do this after the dusting, it looks better this way...
    if (kind == KIND_SAVEGAME && loc_lvl == (int) (dgnlevel - 1))
    {   drawtile(loc_x, loc_y, 26 + facing); // party
    }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_DM_SP1]->LeftEdge,
        gadgets[GID_DM_SP1]->TopEdge,
        gadgets[GID_DM_SP1]->LeftEdge + SCALEDWIDTH  - 1,
        gadgets[GID_DM_SP1]->TopEdge  + SCALEDHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );

    updatetiles();
}

MODULE void drawtile(int x, int y, int whichtile)
{   int colour,
        xx, yy;

    for (yy = 0; yy < MAPSCALE / 2; yy++)
    {   for (xx = 0; xx < MAPSCALE / 2; xx++)
        {   switch (tile[whichtile][yy][xx])
            {
            case  '0': colour =  0;
            acase '1': colour =  1;
            acase '2': colour =  2;
            acase '3': colour =  3;
            acase '4': colour =  4;
            acase '5': colour =  5;
            acase 'o': colour =  6;
            acase 'O': colour =  7;
            acase 'G': colour =  8;
            acase 'B': colour =  9;
            acase 'C': colour = 10;
            acase 'R': colour = 11;
            acase 'Y': colour = 12;
            adefault:  colour = 13;
            }
            *(byteptr1[(y * MAPSCALE) + topy + (yy * 2)    ] + leftx + (x * MAPSCALE) + (xx * 2)    ) =
            *(byteptr1[(y * MAPSCALE) + topy + (yy * 2)    ] + leftx + (x * MAPSCALE) + (xx * 2) + 1) =
            *(byteptr1[(y * MAPSCALE) + topy + (yy * 2) + 1] + leftx + (x * MAPSCALE) + (xx * 2)    ) =
            *(byteptr1[(y * MAPSCALE) + topy + (yy * 2) + 1] + leftx + (x * MAPSCALE) + (xx * 2) + 1) = pens[colour];
}   }   }

EXPORT void dm_uniconify(void)
{   dm_getpens();
    dm_drawmap();
}

EXPORT void dm_getpens(void)
{   lockscreen();

    pens[ 0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1); // "0" (      black)
    pens[ 1] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x55555555, 0x55555555, 0x77777777, -1); // "1"
    pens[ 2] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x77777777, 0x77777777, 0x99999999, -1); // "2"
    pens[ 3] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x99999999, 0x99999999, 0xBBBBBBBB, -1); // "3"
    pens[ 4] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xBBBBBBBB, 0xBBBBBBBB, 0xDDDDDDDD, -1); // "4"
    pens[ 5] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1); // "5" (      white)
    pens[ 6] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x77777777, 0x33333333, 0x00000000, -1); // "o" (dark  brOwn)
    pens[ 7] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x99999999, 0x55555555, 0x00000000, -1); // "O" (light brOwn)
    pens[ 8] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xDDDDDDDD, 0x00000000, -1); // "G" (      Green)
    pens[ 9] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xDDDDDDDD, -1); // "B" (      Blue)
    pens[10] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xDDDDDDDD, 0xDDDDDDDD, -1); // "C" (      Cyan)
    pens[11] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1); // "R" (      Red)
    pens[12] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, -1); // "Y" (      Yellow)
    pens[13] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFF, -1); // "-" (      purple)

    unlockscreen();
}

EXPORT void dm_key(UBYTE scancode)
{   switch (scancode)
    {
    case SCAN_LEFT:
        if (dgnlevel == 1)
        {   dgnlevel = numlevels;
        } else
        {   dgnlevel--;
        }
        gadmode = SERIALIZE_WRITE;
        either_sl(GID_DM_SL1,  &dgnlevel);
        either_in(GID_DM_IN80, &dgnlevel);
        if (game >= DM2)
        {   SetGadgetAttrs(gadgets[GID_DM_ST34], MainWindowPtr, NULL, STRINGA_TextVal, DM2DungeonName[dgnlevel - 1], TAG_END);
        } else
        {   SetGadgetAttrs(gadgets[GID_DM_ST34], MainWindowPtr, NULL, STRINGA_TextVal, DM1DungeonName[dgnlevel - 1], TAG_END);
        }
        dm_drawmap();
    acase SCAN_RIGHT:
        if ((int) dgnlevel == numlevels)
        {   dgnlevel = 1;
        } else
        {   dgnlevel++;
        }
        gadmode = SERIALIZE_WRITE;
        either_sl(GID_DM_SL1,  &dgnlevel);
        either_in(GID_DM_IN80, &dgnlevel);
        if (game >= DM2)
        {   SetGadgetAttrs(gadgets[GID_DM_ST34], MainWindowPtr, NULL, STRINGA_TextVal, DM2DungeonName[dgnlevel - 1], TAG_END);
        } else
        {   SetGadgetAttrs(gadgets[GID_DM_ST34], MainWindowPtr, NULL, STRINGA_TextVal, DM1DungeonName[dgnlevel - 1], TAG_END);
        }
        dm_drawmap();
}   }

EXPORT void dm_tick(SWORD mousex, SWORD mousey)
{   int   x, y;
    TEXT  tempstring[48 + 1];
    UBYTE value;

    if (mouseisover(GID_DM_SP1, mousex, mousey))
    {   setpointer(TRUE , WinObject, MainWindowPtr, FALSE);

        x = (mousex - gadgets[GID_DM_SP1]->LeftEdge - leftx) / 12;
        y = (mousey - gadgets[GID_DM_SP1]->TopEdge  - topy ) / 12;

        if
        (   x <  0
         || y <  0
         || x >= levelinfo[dgnlevel - 1].xsize
         || y >= levelinfo[dgnlevel - 1].ysize
        )
        {   strcpy(tempstring, "-");
        } else
        {   value = getsquare(x, y);
            switch (value)
            {
            case    0:
            case    1:
            case    2:
            case    3:
            case    4:
            case    5:
            case    6:
            case    7:
            case    8:
            case    9:
            case   10:
            case   11:
            case   12:
            case   13:
            case   14:
            case   15: strcpy(tempstring, "Wall");

            acase  16:
            case   17:
            case   18:
            case   19:
            case   20:
            case   21:
            case   22:
            case   23:
            case   24:
            case   25:
            case   26:
            case   27:
            case   28:
            case   29:
            case   30:
            case   31: strcpy(tempstring, "Wall object");

            acase  32:
            case   34: // same as  32?
            case   40:
            case  180:
            case  182: // same as 180?
            case  196:
            case  204: strcpy(tempstring, "Floor");

            acase  46:
            case   47:
            case   48:
            case   49:
            case   50:
            case   51:
            case   52:
            case   53:
            case   54:
            case   55:
            case   56:
            case   57:
            case   58:
            case   59: strcpy(tempstring, "Floor object");

            acase  64:
            case   68:
            case   72:
            case   74: // same as  72?
            case   88:
            case   92: strcpy(tempstring, "Pit");

            acase  73: strcpy(tempstring, "Fake pit");

            acase  76:
            case   80:
            case   84: strcpy(tempstring, "Hidden pit");

            acase  96:
            case  112: strcpy(tempstring, "Horizontal stairs down");

            acase 104:
            case  120: strcpy(tempstring, "Vertical stairs down");

            acase 100:
            case  116: strcpy(tempstring, "Horizontal stairs up");

            acase 108:
            case  124: strcpy(tempstring, "Vertical stairs up");

            acase 144: strcpy(tempstring, "Open vertical door");

            acase 152: strcpy(tempstring, "Open horizontal door");

            acase 145:
            case  146:
            case  147:
            case  148: strcpy(tempstring, "Closed vertical door");

            acase 153:
            case  154:
            case  155:
            case  156: strcpy(tempstring, "Closed horizontal door");

            acase 149: strcpy(tempstring, "Broken vertical door");

            acase 157: strcpy(tempstring, "Broken horizontal door");

            acase 176:
            case  184: strcpy(tempstring, "Spinner");

            acase 188: strcpy(tempstring, "Blue haze");

            acase 192:
            case  200:
            case  201:
            case  208:
            case  209:
            case  212: strcpy(tempstring, "Fake wall");

            acase 193: strcpy(tempstring, "Secret wall");

            acase 224: strcpy(tempstring, "Void"); // DM2 only?

            adefault:  strcpy(tempstring, "?");
            }

            sprintf(ENDOF(tempstring), " ($%02X)", value);
            if ((int) (dgnlevel - 1) == loc_lvl && x == loc_x && y == loc_y)
            {   strcat(tempstring, " + party");
    }   }   }
    elif (mouseisover(GID_DM_SP2, mousex, mousey))
    {   setpointer(TRUE , WinObject, MainWindowPtr, FALSE);

        x = (mousex - gadgets[GID_DM_SP2]->LeftEdge) / 24;
        switch (x)
        {
        case   0: strcpy(tempstring, "Party");
        acase  1: strcpy(tempstring, "Wall");
        acase  2: strcpy(tempstring, "Floor");
        acase  3: strcpy(tempstring, "Pit");
        acase  4: strcpy(tempstring, "Fake pit");
        acase  5: strcpy(tempstring, "Hidden pit");
        acase  6: strcpy(tempstring, "Spinner");
        acase  7: strcpy(tempstring, "Blue haze");
        acase  8: strcpy(tempstring, "Secret wall");
        acase  9: strcpy(tempstring, "Door");
        acase 10: strcpy(tempstring, "Void");
    }   }
    else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);

        strcpy(tempstring, "-");
    }

    SetGadgetAttrs(gadgets[GID_DM_ST33], MainWindowPtr, NULL, STRINGA_TextVal, tempstring, TAG_END);
}

MODULE UBYTE getsquare(int x, int y)
{   return
    (   IOBuffer[mapstart
        +      levelinfo[dgnlevel - 1].start
        + (x * levelinfo[dgnlevel - 1].ysize)
        +  y]
    );
}

MODULE void manwindow(void)
{   TRANSIENT STRPTR mintext;
    PERSIST   WORD   leftx   = -1,
                     topy    = -1,
                     width   = -1,
                     height  = -1;


    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (game < DM2)
    {   mintext = " Min:";
        gadgets[GID_DM_LY3] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_BevelStyle,                         BVS_SBAR_VERT,
            LAYOUT_Label,                              "Items",
            AddVLayout,
                AddItem( 0, "Left Hand:"), // ready/pimp hand
                AddItem( 1, "Right Hand:"), // action/bitch hand
                AddItem( 2, "Head:"),
                AddItem(10, "Neck:"),
                AddItem( 3, "Torso:"),
                AddItem( 4, "Legs:"),
                AddItem( 5, "Feet:"),
                AddItem(11, "N Pouch:"),
                AddItem( 6, "S Pouch:"),
                AddItem(12, "NW Quiver:"),
                AddItem( 7, "NE Quiver:"),
                AddItem( 8, "SW Quiver:"),
                AddItem( 9, "SE Quiver:"),
                AddItem(13, "Pack:"),
                AddItem(14, "Pack:"),
            LayoutEnd,
            AddVLayout,
                AddItem(15, "Pack:"),
                AddItem(16, "Pack:"),
                AddItem(17, "Pack:"),
                AddItem(18, "Pack:"),
                AddItem(19, "Pack:"),
                AddItem(20, "Pack:"),
                AddItem(21, "Pack:"),
                AddItem(22, "Pack:"),
                AddItem(23, "Pack:"),
                AddItem(24, "Pack:"),
                AddItem(25, "Pack:"),
                AddItem(26, "Pack:"),
                AddItem(27, "Pack:"),
                AddItem(28, "Pack:"),
                AddItem(29, "Pack:"),
            LayoutEnd,
        LayoutEnd;
    } else
    {   mintext = " Enh:";
        gadgets[GID_DM_LY3] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_BevelStyle,                         BVS_SBAR_VERT,
            LAYOUT_Label,                              "Skill Bonuses",
            AddVLayout,
                AddBonus(GID_DM_IN82 , "Fighter:",  0),
                AddBonus(GID_DM_IN83 , "Ninja:"  ,  1),
                AddBonus(GID_DM_IN84 , "Priest:" ,  2),
                AddBonus(GID_DM_IN85 , "Wizard:" ,  3),
            LayoutEnd,
            AddVLayout,
                AddBonus(GID_DM_IN86 , "Swing:"  ,  4),
                AddBonus(GID_DM_IN90 , "Steal:"  ,  5),
                AddBonus(GID_DM_IN94 , "Idntfy:" ,  6),
                AddBonus(GID_DM_IN98 , "Fire:"   ,  7),
            LayoutEnd,
            AddVLayout,
                AddBonus(GID_DM_IN87 , "Thrust:" ,  8),
                AddBonus(GID_DM_IN91 , "Fight:"  ,  9),
                AddBonus(GID_DM_IN95 , "Heal:"   , 10),
                AddBonus(GID_DM_IN99 , "Air:"    , 11),
            LayoutEnd,
            AddVLayout,
                AddBonus(GID_DM_IN88 , "Club:"   , 12),
                AddBonus(GID_DM_IN92 , "Throw:"  , 13),
                AddBonus(GID_DM_IN96 , "Inflnce:", 14),
                AddBonus(GID_DM_IN100, "Earth:"  , 15),
            LayoutEnd,
            AddVLayout,
                AddBonus(GID_DM_IN89 , "Parry:"  , 16),
                AddBonus(GID_DM_IN93 , "Shoot:"  , 17),
                AddBonus(GID_DM_IN97 , "Defend:" , 18),
                AddBonus(GID_DM_IN101, "Water:"  , 19),
            LayoutEnd,
        LayoutEnd;
    }

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                                 TRUE,
        WA_ThinSizeGadget,                             TRUE,
        WA_Title,                                      "View/Edit Character",
        (leftx  != -1) ? WA_Left         : TAG_IGNORE, leftx,
        (topy   != -1) ? WA_Top          : TAG_IGNORE, topy,
        (width  != -1) ? WA_Width        : TAG_IGNORE, width,
        (height != -1) ? WA_Height       : TAG_IGNORE, height,
        (leftx  == -1) ? WINDOW_Position : TAG_IGNORE, WPOS_CENTERMOUSE,
        WINDOW_LockHeight,                             TRUE,
        WINDOW_UniqueID,                               "dm-1",
        WINDOW_ParentGroup,                            gadgets[GID_DM_LY2] = (struct Gadget*)
        VLayoutObject,
            GA_ID,                                     GID_DM_LY2,
            AddVLayout,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                LAYOUT_Label,                          "General & Attributes",
                LAYOUT_AddChild,                       gadgets[GID_DM_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                             GID_DM_ST1,
                    GA_TabCycle,                       TRUE,
                    STRINGA_MaxChars,                  8 + 1,
                    STRINGA_MinVisible,                8 + 1,
                    STRINGA_TextVal,                   name[who],
                StringEnd,
                Label("Name:"),
                LAYOUT_AddChild,                       gadgets[GID_DM_ST2] = (struct Gadget*)
                StringObject,
                    GA_ID,                             GID_DM_ST2,
                    GA_TabCycle,                       TRUE,
                    STRINGA_MaxChars,                  16 + 1,
                    STRINGA_MinVisible,                16 + 1,
                    STRINGA_TextVal,                   title[who],
                StringEnd,
                Label("Title:"),
                AddHLayout,
                    LAYOUT_EvenSize,                   TRUE,
                    AddSpace,
                    Label("    "),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN1,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_MinVisible,            5 + 1,
                        INTEGER_Number,                curhp[who],
                    IntegerEnd,
                    Label(" Now:"),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN2,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_MinVisible,            5 + 1,
                        INTEGER_Number,                maxhp[who],
                    IntegerEnd,
                    Label(" Max:"),
                LayoutEnd,
                Label("Hit Points:"),
                AddHLayout,
                    LAYOUT_EvenSize,                   TRUE,
                    AddSpace,
                    Label("    "),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN3,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_MinVisible,            5 + 1,
                        INTEGER_Number,                curstamina[who],
                    IntegerEnd,
                    Label(" Now:"),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN4] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN4,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_MinVisible,            5 + 1,
                        INTEGER_Number,                maxstamina[who],
                    IntegerEnd,
                    Label(" Max:"),
                LayoutEnd,
                Label("Stamina:"),
                AddHLayout,
                    LAYOUT_EvenSize,                   TRUE,
                    AddSpace,
                    Label("    "),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN5] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN5,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_MinVisible,            5 + 1,
                        INTEGER_Number,                curmana[who],
                    IntegerEnd,
                    Label(" Now:"),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN6] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN6,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               32767,
                        INTEGER_MinVisible,            5 + 1,
                        INTEGER_Number,                maxmana[who],
                    IntegerEnd,
                    Label(" Max:"),
                LayoutEnd,
                Label("Mana:"),
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN7] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN7,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                minstat[who][0],
                    IntegerEnd,
                    Label(mintext),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN8] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN8,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                curstat[who][0],
                    IntegerEnd,
                    Label(" Now:"),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN9] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN9,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                maxstat[who][0],
                    IntegerEnd,
                    Label(" Max:"),
                LayoutEnd,
                Label("Luck:"),
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN10] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN10,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                minstat[who][1],
                    IntegerEnd,
                    Label(mintext),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN11] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN11,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                curstat[who][1],
                    IntegerEnd,
                    Label(" Now:"),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN12] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN12,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                maxstat[who][2],
                    IntegerEnd,
                    Label(" Max:"),
                LayoutEnd,
                Label("Strength:"),
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN13] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN13,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                minstat[who][2],
                    IntegerEnd,
                    Label(mintext),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN14] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN14,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                curstat[who][2],
                    IntegerEnd,
                    Label(" Now:"),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN15] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN15,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                maxstat[who][2],
                    IntegerEnd,
                    Label(" Max:"),
                LayoutEnd,
                Label("Dexterity:"),
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN16] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN16,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                minstat[who][3],
                    IntegerEnd,
                    Label(mintext),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN17] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN17,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                curstat[who][3],
                    IntegerEnd,
                    Label(" Now:"),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN18] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN18,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                maxstat[who][3],
                    IntegerEnd,
                    Label(" Max:"),
                LayoutEnd,
                Label("Wisdom:"),
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN19] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN19,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                minstat[who][4],
                    IntegerEnd,
                    Label(mintext),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN20] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN20,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                curstat[who][4],
                    IntegerEnd,
                    Label(" Now:"),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN21] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN21,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                maxstat[who][4],
                    IntegerEnd,
                    Label(" Max:"),
                LayoutEnd,
                Label("Vitality:"),
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN22] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN22,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                minstat[who][5],
                    IntegerEnd,
                    Label(mintext),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN23] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN23,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                curstat[who][5],
                    IntegerEnd,
                    Label(" Now:"),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN24] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN24,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                maxstat[who][5],
                    IntegerEnd,
                    Label(" Max:"),
                LayoutEnd,
                Label("Anti-Magic:"),
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN25] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN25,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                minstat[who][6],
                    IntegerEnd,
                    Label(mintext),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN26] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN26,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                curstat[who][6],
                    IntegerEnd,
                    Label(" Now:"),
                    LAYOUT_AddChild,                   gadgets[GID_DM_IN27] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_DM_IN27,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_MinVisible,            3 + 1,
                        INTEGER_Number,                maxstat[who][6],
                    IntegerEnd,
                    Label(" Max:"),
                LayoutEnd,
                Label("Anti-Fire:"),
                LAYOUT_AddChild,                       gadgets[GID_DM_IN28] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_DM_IN28,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   32767,
                    INTEGER_MinVisible,                5 + 1,
                    INTEGER_Number,                    food[who],
                IntegerEnd,
                Label("Food:"),
                LAYOUT_AddChild,                       gadgets[GID_DM_IN29] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_DM_IN29,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   32767,
                    INTEGER_MinVisible,                5 + 1,
                    INTEGER_Number,                    water[who],
                IntegerEnd,
                Label("Water:"),
            LayoutEnd,
            AddHLayout,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                LAYOUT_Label,                          "Skills",
                AddVLayout,
                    AddSkill(GID_DM_IN30, "Fighter:",  0),
                    AddSkill(GID_DM_IN31, "Ninja:"  ,  1),
                    AddSkill(GID_DM_IN32, "Priest:" ,  2),
                    AddSkill(GID_DM_IN33, "Wizard:" ,  3),
                LayoutEnd,
                AddVLayout,
                    AddSkill(GID_DM_IN34, "Swing:"  ,  4),
                    AddSkill(GID_DM_IN38, "Steal:"  ,  5),
                    AddSkill(GID_DM_IN42, "Idntfy:" ,  6),
                    AddSkill(GID_DM_IN46, "Fire:"   ,  7),
                LayoutEnd,
                AddVLayout,
                    AddSkill(GID_DM_IN35, "Thrust:" ,  8),
                    AddSkill(GID_DM_IN39, "Fight:"  ,  9),
                    AddSkill(GID_DM_IN43, "Heal:"   , 10),
                    AddSkill(GID_DM_IN47, "Air:"    , 11),
                LayoutEnd,
                AddVLayout,
                    AddSkill(GID_DM_IN36, "Club:"   , 12),
                    AddSkill(GID_DM_IN40, "Throw:"  , 13),
                    AddSkill(GID_DM_IN44, "Inflnce:", 14),
                    AddSkill(GID_DM_IN48, "Earth:"  , 15),
                LayoutEnd,
                AddVLayout,
                    AddSkill(GID_DM_IN37, "Parry:"  , 16),
                    AddSkill(GID_DM_IN41, "Shoot:"  , 17),
                    AddSkill(GID_DM_IN45, "Defend:" , 18),
                    AddSkill(GID_DM_IN49, "Water:"  , 19),
                LayoutEnd,
            LayoutEnd,
            LAYOUT_AddChild, gadgets[GID_DM_LY3],
            MaximizeButton(GID_DM_BU1, "Maximize Character"),
            CHILD_WeightedHeight,                      0,
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

    writeman();
    subloop();
    readman();

    leftx  = SubWindowPtr->LeftEdge;
    topy   = SubWindowPtr->TopEdge;
    width  = SubWindowPtr->Width;
    height = SubWindowPtr->Height;

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE void readman(void)
{   int    i;
    STRPTR stringptr;

    GetAttr(    STRINGA_TextVal, (Object*) gadgets[GID_DM_ST1           ], (ULONG*) &stringptr); strcpy(name[ who], stringptr);
    GetAttr(    STRINGA_TextVal, (Object*) gadgets[GID_DM_ST2           ], (ULONG*) &stringptr); strcpy(title[who], stringptr);
    GetAttr(    INTEGER_Number , (Object*) gadgets[GID_DM_IN1           ], (ULONG*) &curhp[     who]   );
    GetAttr(    INTEGER_Number , (Object*) gadgets[GID_DM_IN2           ], (ULONG*) &maxhp[     who]   );
    GetAttr(    INTEGER_Number , (Object*) gadgets[GID_DM_IN3           ], (ULONG*) &curstamina[who]   );
    GetAttr(    INTEGER_Number , (Object*) gadgets[GID_DM_IN4           ], (ULONG*) &maxstamina[who]   );
    GetAttr(    INTEGER_Number , (Object*) gadgets[GID_DM_IN5           ], (ULONG*) &curmana[   who]   );
    GetAttr(    INTEGER_Number , (Object*) gadgets[GID_DM_IN6           ], (ULONG*) &maxmana[   who]   );
    GetAttr(    INTEGER_Number , (Object*) gadgets[GID_DM_IN28          ], (ULONG*) &food[      who]   );
    GetAttr(    INTEGER_Number , (Object*) gadgets[GID_DM_IN29          ], (ULONG*) &water[     who]   );
    for (i = 0; i < 7; i++)
    {   GetAttr(INTEGER_Number , (Object*) gadgets[GID_DM_IN7  + (i * 3)], (ULONG*) &minstat[   who][i]);
        GetAttr(INTEGER_Number , (Object*) gadgets[GID_DM_IN8  + (i * 3)], (ULONG*) &curstat[   who][i]);
        GetAttr(INTEGER_Number , (Object*) gadgets[GID_DM_IN9  + (i * 3)], (ULONG*) &maxstat[   who][i]);
    }
    for (i = 0; i < 20; i++)
    {   GetAttr(INTEGER_Number , (Object*) gadgets[GID_DM_IN30 +  i     ], (ULONG*) &level[     who][i]);
    }
    if (game >= DM2)
    {   for (i = 0; i < 20; i++)
        {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_DM_IN82 + i   ], (ULONG*) &bonus[     who][i]);
}   }   }

MODULE void writeman(void)
{   int i;

    SetGadgetAttrs(    gadgets[GID_DM_ST1           ], SubWindowPtr, NULL, STRINGA_TextVal, name[      who]   , TAG_DONE); // this autorefreshes
    SetGadgetAttrs(    gadgets[GID_DM_ST2           ], SubWindowPtr, NULL, STRINGA_TextVal, title[     who]   , TAG_DONE); // this autorefreshes
    SetGadgetAttrs(    gadgets[GID_DM_IN1           ], SubWindowPtr, NULL, INTEGER_Number,  curhp[     who]   , TAG_DONE); // this autorefreshes
    SetGadgetAttrs(    gadgets[GID_DM_IN2           ], SubWindowPtr, NULL, INTEGER_Number,  maxhp[     who]   , TAG_DONE); // this autorefreshes
    SetGadgetAttrs(    gadgets[GID_DM_IN3           ], SubWindowPtr, NULL, INTEGER_Number,  curstamina[who]   , TAG_DONE); // this autorefreshes
    SetGadgetAttrs(    gadgets[GID_DM_IN4           ], SubWindowPtr, NULL, INTEGER_Number,  maxstamina[who]   , TAG_DONE); // this autorefreshes
    SetGadgetAttrs(    gadgets[GID_DM_IN5           ], SubWindowPtr, NULL, INTEGER_Number,  curmana   [who]   , TAG_DONE); // this autorefreshes
    SetGadgetAttrs(    gadgets[GID_DM_IN6           ], SubWindowPtr, NULL, INTEGER_Number,  maxmana[   who]   , TAG_DONE); // this autorefreshes
    SetGadgetAttrs(    gadgets[GID_DM_IN28          ], SubWindowPtr, NULL, INTEGER_Number,  food[      who]   , TAG_DONE); // this autorefreshes
    SetGadgetAttrs(    gadgets[GID_DM_IN29          ], SubWindowPtr, NULL, INTEGER_Number,  water[     who]   , TAG_DONE); // this autorefreshes
    for (i = 0; i < 7; i++)
    {   SetGadgetAttrs(gadgets[GID_DM_IN7  + (i * 3)], SubWindowPtr, NULL, INTEGER_Number,  minstat[   who][i], TAG_DONE); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_DM_IN8  + (i * 3)], SubWindowPtr, NULL, INTEGER_Number,  curstat[   who][i], TAG_DONE); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_DM_IN9  + (i * 3)], SubWindowPtr, NULL, INTEGER_Number,  maxstat[   who][i], TAG_DONE); // this autorefreshes
    }
    for (i = 0; i < 20; i++)
    {   SetGadgetAttrs(gadgets[GID_DM_IN30 +  i     ], SubWindowPtr, NULL, INTEGER_Number,  level[     who][i], TAG_DONE); // this autorefreshes
    }
    if (game < DM2)
    {   for (i = 0; i < 30; i++)
        {   writeitemgad(i);
    }   }
    else
    {   for (i = 0; i < 20; i++)
        {   SetGadgetAttrs(gadgets[GID_DM_IN82 + i  ], SubWindowPtr, NULL, INTEGER_Number,  bonus[     who][i], TAG_DONE); // this autorefreshes
}   }   }

EXPORT FLAG dm_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_DM_BU1:
        readman();
        maximize_man(who);
        writeman();
    adefault:
        if (gid >= GID_DM_IN50 && gid <= GID_DM_IN79)
        {   // assert(game < DM2);
            GetAttr(INTEGER_Number, (Object*) gadgets[gid], (ULONG*) &item[who][gid - GID_DM_IN50]);
            writeitemgad(gid - GID_DM_IN50);
    }   }

    return FALSE;
}

MODULE void writeitemgad(int whichitem)
{   STRPTR thetext;
    UWORD  value;

    // assert(game < DM2);

    if (item[who][whichitem] == 0xFFFF)
    {   thetext = "-";
    } elif ((item[who][whichitem] & 0x3FFF) < 0x1000 || (item[who][whichitem] & 0x3FFF) > 0x2FFF)
    {   thetext = "!";
    } else
    {   value = item[who][whichitem] & 0x1FFF;
        if   (                   value <=   0xFF) thetext = knowitem[value                           ][game >= CSB ? 1 : 0]; //  256
        elif (value >=  0x800 && value <=  0x93F) thetext = knowitem[value -  0x800 + 256            ][game >= CSB ? 1 : 0]; //+ 320
        elif (value >= 0x1400 && value <= 0x14FF) thetext = knowitem[value - 0x1400 + 256 + 320      ][game >= CSB ? 1 : 0]; //+ 256
        elif (value >= 0x1800 && value <= 0x18FF) thetext = knowitem[value - 0x1800 + 256 + 320 + 256][game >= CSB ? 1 : 0]; //+ 256
        else                                      thetext = "?";                                                             //=1088
    }
    SetGadgetAttrs
    (   gadgets[GID_DM_IN50 + whichitem], SubWindowPtr, NULL,
        INTEGER_Number, item[who][whichitem],
    TAG_DONE); // this autorefreshes
    SetGadgetAttrs
    (   gadgets[GID_DM_ST3 + whichitem], SubWindowPtr, NULL,
        STRINGA_TextVal, thetext,
    TAG_DONE); // this autorefreshes
}

EXPORT void dm_lmb(SWORD mousex, SWORD mousey, UWORD code)
{   int x;

    if (code == SELECTUP)
    {   lmb = FALSE;
    } elif (code == SELECTDOWN) // this doesn't repeat
    {   lmb = TRUE;

        if (mouseisover(GID_DM_SP1, mousex, mousey))
        {   stampit(mousex, mousey);
        } elif (mouseisover(GID_DM_SP2, mousex, mousey))
        {   x = (mousex - gadgets[GID_DM_SP2]->LeftEdge) / 24;

            if
            (   x <  0
             || x > 10
             || (kind != KIND_SAVEGAME && x ==  0)
             || (game <  DM2           && x == 10)
            )
            {   return;
            }

            brushpos = x;
            updatetiles();
}   }   }

MODULE void updatetiles(void)
{   int colour,
        value = 0, // initialized to avoid a spurious SAS/C warning
        x,
        xx, yy;

    for (x = 0; x < 11; x++)
    {   switch (x)
        {
        case   0: value =  26 + facing;
        acase  1: value =   1; // wall
        acase  2: if   (levelinfo[dgnlevel - 1].style == 1) value = 31; // grass
                  elif (levelinfo[dgnlevel - 1].style == 2) value = 32; // cave floor
                  else                                      value =  0; // dungeon floor
        acase  3: value =   7; // pit
        acase  4: value =   8; // fake pit
        acase  5: value =  10; // hidden pit
        acase  6: value =  11; // spinner
        acase  7: value =   9; // blue haze
        acase  8: value =  13; // secret wall
        acase  9: value =   2; // door
        acase 10: value =  30; // void
        }

        for (yy = 0; yy < 6; yy++)
        {   for (xx = 0; xx < 6; xx++)
            {   switch (tile[value][yy][xx])
                {
                case  '0': colour =  0;
                acase '1': colour =  1;
                acase '2': colour =  2;
                acase '3': colour =  3;
                acase '4': colour =  4;
                acase '5': colour =  5;
                acase 'o': colour =  6;
                acase 'O': colour =  7;
                acase 'G': colour =  8;
                acase 'B': colour =  9;
                acase 'C': colour = 10;
                acase 'R': colour = 11;
                acase 'Y': colour = 12;
                adefault:  colour = 13;
                }
                *(byteptr2[(yy * 4)    ] + (x * 24) + (xx * 4)    ) =
                *(byteptr2[(yy * 4)    ] + (x * 24) + (xx * 4) + 1) =
                *(byteptr2[(yy * 4)    ] + (x * 24) + (xx * 4) + 2) =
                *(byteptr2[(yy * 4)    ] + (x * 24) + (xx * 4) + 3) =
                *(byteptr2[(yy * 4) + 1] + (x * 24) + (xx * 4)    ) =
                *(byteptr2[(yy * 4) + 1] + (x * 24) + (xx * 4) + 1) =
                *(byteptr2[(yy * 4) + 1] + (x * 24) + (xx * 4) + 2) =
                *(byteptr2[(yy * 4) + 1] + (x * 24) + (xx * 4) + 3) =
                *(byteptr2[(yy * 4) + 2] + (x * 24) + (xx * 4)    ) =
                *(byteptr2[(yy * 4) + 2] + (x * 24) + (xx * 4) + 1) =
                *(byteptr2[(yy * 4) + 2] + (x * 24) + (xx * 4) + 2) =
                *(byteptr2[(yy * 4) + 2] + (x * 24) + (xx * 4) + 3) =
                *(byteptr2[(yy * 4) + 3] + (x * 24) + (xx * 4)    ) =
                *(byteptr2[(yy * 4) + 3] + (x * 24) + (xx * 4) + 1) =
                *(byteptr2[(yy * 4) + 3] + (x * 24) + (xx * 4) + 2) =
                *(byteptr2[(yy * 4) + 3] + (x * 24) + (xx * 4) + 3) = pens[colour];
    }   }   }

    for (xx = 0; xx < 24; xx++)
    {   *(byteptr2[ 0] + (brushpos * 24) + xx) =
        *(byteptr2[ 1] + (brushpos * 24) + xx) =
        *(byteptr2[22] + (brushpos * 24) + xx) =
        *(byteptr2[23] + (brushpos * 24) + xx) = pens[5]; // white
    }
    for (yy = 2; yy < 22; yy++)
    {   *(byteptr2[yy] + (brushpos * 24)     ) =
        *(byteptr2[yy] + (brushpos * 24) +  1) =
        *(byteptr2[yy] + (brushpos * 24) + 22) =
        *(byteptr2[yy] + (brushpos * 24) + 23) = pens[5]; // white
    }

    if (kind != KIND_SAVEGAME)
    {   for (yy = 0; yy < 24; yy++)
        {   for (xx = 0; xx < 24; xx += 4)
            {   if (yy % 2)
                {   *(byteptr2[yy] + xx    ) = pens[0]; // black
                } else
                {   *(byteptr2[yy] + xx + 2) = pens[0]; // black
    }   }   }   }
    if (game < DM2)
    {   for (yy = 0; yy < 24; yy++)
        {   for (xx = 0; xx < 24; xx += 4)
            {   if (yy % 2)
                {   *(byteptr2[yy] + (10 * 24) + xx    ) = pens[0]; // black
                } else
                {   *(byteptr2[yy] + (10 * 24) + xx + 2) = pens[0]; // black
    }   }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_DM_SP2]->LeftEdge,
        gadgets[GID_DM_SP2]->TopEdge,
        gadgets[GID_DM_SP2]->LeftEdge + TILESWIDTH  - 1,
        gadgets[GID_DM_SP2]->TopEdge  + TILESHEIGHT - 1,
        display2,
        &wpa8rastport[1]
    );
}

EXPORT void dm_mouse(SWORD mousex, SWORD mousey)
{   if (lmb && mouseisover(GID_DM_SP1, mousex, mousey))
    {   stampit(mousex, mousey);
}   }

MODULE void stampit(SWORD mousex, SWORD mousey)
{   UBYTE value1,
          value2 = 0; // initialized to avoid a spurious SAS/C warning
    int   x, y;

    x = (mousex - gadgets[GID_DM_SP1]->LeftEdge - leftx) / 12;
    y = (mousey - gadgets[GID_DM_SP1]->TopEdge  - topy ) / 12;

    if
    (   x <  0
     || y <  0
     || x >= levelinfo[dgnlevel - 1].xsize
     || y >= levelinfo[dgnlevel - 1].ysize
    )
    {   return;
    }

    value1 = getsquare(x, y);

    switch (brushpos)
    {
    case  0: loc_x    = x;
             loc_y    = y;
             loc_lvl  = dgnlevel - 1;
             dm_drawmap();
    acase 1:                                       value2 =   0; // wall
    acase 2:                                       value2 =  32; // floor
    acase 3:                                       value2 =  72; // pit
    acase 4:                                       value2 =  73; // fake pit
    acase 5:                                       value2 =  76; // hidden pit
    acase 6:                                       value2 = 184; // spinner
    acase 7:                                       value2 = 188; // blue haze
    acase 8:                                       value2 = 193; // secret wall
    acase 9: if   (value1 == 144                 ) value2 = 148; // open   "horizontal" door -> closed "horizontal" door
             elif (value1 >= 145 && value1 <= 148) value2 = 149; // closed "horizontal" door -> broken "horizontal" door
             elif (value1 == 149                 ) value2 = 144; // broken "horizontal" door -> open   "horizontal" door
             elif (value1 == 152                 ) value2 = 156; // open   "vertical"   door -> closed "vertical"   door
             elif (value1 >= 153 && value1 <= 156) value2 = 157; // closed "vertical"   door -> broken "vertical"   door
             elif (value1 == 157                 ) value2 = 152; // broken "vertical"   door -> open   "vertical"   door
             else                                  value2 = 255;
             if (value2 != 255)
             {   IOBuffer[mapstart
                 +      levelinfo[dgnlevel - 1].start
                 + (x * levelinfo[dgnlevel - 1].ysize)
                 +  y] = value2;
                 dm_drawmap();
             }
    acase 10:                                      value2 = 224; // void (DM2 only?)
    }

    if
    (   ((brushpos >= 1 && brushpos <= 8) || brushpos == 10)
     && !(   (value1 >=  16 && value1 <=  31                   ) // wall  object
          || (value1 >=  46 && value1 <=  59                   ) // floor object
          || (value1 >=  96 && value1 <= 124 && value1 % 4 == 0) // stairs
          || (value1 >= 144 && value1 <= 149                   ) // horizontal door
          || (value1 >= 152 && value1 <= 157                   ) // vertical   door
    )    )
    {   IOBuffer[mapstart
        +      levelinfo[dgnlevel - 1].start
        + (x * levelinfo[dgnlevel - 1].ysize)
        +  y] = value2;
        dm_drawmap();
}   }

MODULE void doword(UWORD* thevar)
{   if (formats[game].littleendian)
    {   serialize2iword(thevar);
    } else
    {   serialize2uword(thevar);
}   }
MODULE void dolong(ULONG* thevar)
{   if (formats[game].littleendian)
    {   serialize2ilong(thevar);
    } else
    {   serialize2ulong(thevar);
}   }

MODULE void parse_dungeon(void)
{   int    columns = 0,
           i,
           jump    = 0,
           objlistsize,
           textsize;
    UBYTE  more[4],
           less[16],
           t;
    UBYTE* Uncompressed;
    ULONG  temp,
           thesize;
PERSIST const int multiplier[16] = {
 4, 6, 4, 8, 16, 4, 4, 4,
 4, 8, 4, 0,  0, 0, 8, 4 };

    dungeonstart = offset;

    dolong((ULONG*) &temp);                     //  0.. 1
    if (kind == KIND_DUNGEON && temp == 0x8104)
    {   if (formats[game].littleendian)
        {   serialize4i(&thesize);              //  2.. 5
        } else
        {   serialize4( &thesize);              //  2.. 5
        }
#ifdef LOGSERIALIZATION
        printf("Uncompressing dungeon of %d bytes...\n", thesize);
#endif

        offset += 2;                            //  6.. 7
        for (i = 0; i < 4; i++)
        {   serialize1to1(&more[i]);            //  8..11
        }
        for (i = 0; i < 16; i++)
        {   serialize1to1(&less[i]);            // 12..27
        }

        if (!((Uncompressed = malloc(thesize))))
        {   rq("Out of memory!");
        }

        bit = 0;
        for (i = 0; i < (int) thesize; i++)
        {   t = readbits(2);
            switch (t)
            {
            case  0: t = readbits(1); Uncompressed[i] = more[    t];
            acase 1: t = readbits(1); Uncompressed[i] = more[2 + t];
            acase 2: t = readbits(4); Uncompressed[i] = less[    t];
            acase 3: t = readbits(8); Uncompressed[i] =          t ;
        }   }
        // if (bit) offset++;

        memcpy(IOBuffer, Uncompressed, thesize);
        free(Uncompressed);
        offset = 2;
        gamesize = thesize;
    }

    dolong((ULONG*) &mapsize);                  //  2.. 3
    serialize1((ULONG*) &numlevels);            //  4
    offset++;                                   //  5
    dolong((ULONG*) &textsize);                 //  6.. 7
    textsize *= 2;
    offset += 2;                                //  8.. 9
    dolong((ULONG*) &objlistsize);              // 10..11
    objlistsize *= 2;

    for (i = 0; i < 16; i++)
    {   dolong((ULONG*) &temp);
        jump += multiplier[i] * temp;
    }

#ifdef LOGSERIALIZATION
    printf("Map defines  at $%4X...\n", offset);
#endif
    for (i = 0; i < numlevels; i++)
    {   dolong((ULONG*) &levelinfo[i].start);   //  0.. 1
        offset += 6;                            //  2.. 7
        dolong((ULONG*) &temp);                 //  8.. 9
        levelinfo[i].ysize = ((temp & 0xF800) >> 11) + 1; // HHHH,H---,----,----
        levelinfo[i].xsize = ((temp & 0x07C0) >>  6) + 1; // ----,-WWW,WW--,----
        offset  += 4;                           // 10..13
        dolong((ULONG*) &temp);                 // 14..15
        levelinfo[i].style = ((temp & 0x00F0) >>  4);
        columns += levelinfo[i].xsize;
    }
    columns *= 2;

#ifdef LOGSERIALIZATION
    printf("IOTWOOT      at $%4X... (%d bytes)\n", offset, columns);
#endif
    offset += columns;
#ifdef LOGSERIALIZATION
    printf("LOOIOFOOT    at $%4X... (%d bytes)\n", offset, objlistsize);
#endif
    offset += objlistsize;
#ifdef LOGSERIALIZATION
    printf("Text data    at $%4X... (%d bytes)\n", offset, textsize);
#endif
    offset += textsize;
#ifdef LOGSERIALIZATION
    printf("Object lists at $%4X... (%d bytes)\n", offset, jump);
#endif
    offset += jump;
#ifdef LOGSERIALIZATION
    printf("Dungeon data at $%4X... (%d bytes)\n", offset, mapsize);
#endif
    mapstart = offset;
    offset += mapsize;
#ifdef LOGSERIALIZATION
    if (offset < gamesize)
    {   printf("Checksum     at $%4X... (2 bytes)\n", offset);
    }
#endif
}

MODULE UBYTE readbits(int howmany)
{   UBYTE t,
          tt = 0;
    int   i;

    for (i = 0; i < howmany; i++)
    {   t  =   (IOBuffer[offset] & (0x80 >> bit)) ? 1 : 0;
        t  <<= howmany - i - 1;
        tt |=  t;
        if (bit == 7)
        {   bit = 0;
            offset++;
        } else
        {   bit++;
    }   }

    return tt;
}

MODULE void dm2_loadgame(void)
{   int i, j;

    crypting = bitpos = 0;

    gvb = offset;
#ifdef LOGSERIALIZATION
    printf("Loading global variable block at $%X.\n", offset);
#endif
    dm2_decrypt(  VarData, _395a, 56,  1); // global variables
    men     = (VarData[ 9] * 256) + VarData[ 8]; // little-endian (0..4)
    loc_x   = (VarData[11] * 256) + VarData[10]; // little-endian
    loc_y   = (VarData[13] * 256) + VarData[12]; // little-endian
    facing  = (VarData[15] * 256) + VarData[14]; // little-endian (0..3)
    loc_lvl = (VarData[17] * 256) + VarData[16]; // little-endian
    dm2_decrypt(FlagsData, _3956,  1,  8); // flags
    dm2_decrypt(BytesData, _3956,  1, 64); // bytes
    dm2_decrypt(WordsData, _3956,  2, 64); // words
    offset--;
    champs = offset;
    preserve = IOBuffer[offset - 1];

    if (men)
    {
#ifdef LOGSERIALIZATION
        printf("Loading characters at $%X.\n", offset); // eg. $AAA6
#endif
        for (i = 0; i < men; i++)
        {   dm2_decrypt(CharData[i], _3992, 261, 1);
            CharData[i][0] |= 0x40;
#ifdef LOGSERIALIZATION
            showchar(i);
#endif

            for (j = 0; j < 8; j++)
            {   name[ i][j] = CharData[i][j];
            }
            name[i][8] = EOS;

            for (j = 0; j < 16; j++)
            {   title[i][j] = CharData[i][8 + j];
            }
            title[i][16] = EOS;

            // words are always little-endian even in "big-endian" saves
            curhp[     i]    = (ULONG) (CharData[i][ 54] + (CharData[i][ 55] * 256));
            maxhp[     i]    = (ULONG) (CharData[i][ 56] + (CharData[i][ 57] * 256));
            curstamina[i]    = (ULONG) (CharData[i][ 58] + (CharData[i][ 59] * 256));
            maxstamina[i]    = (ULONG) (CharData[i][ 60] + (CharData[i][ 61] * 256));
            curmana[   i]    = (ULONG) (CharData[i][ 62] + (CharData[i][ 63] * 256));
            maxmana[   i]    = (ULONG) (CharData[i][ 64] + (CharData[i][ 65] * 256));
            // 2 bytes here
            food[      i]    = (ULONG) (CharData[i][ 68] + (CharData[i][ 69] * 256));
            water[     i]    = (ULONG) (CharData[i][ 70] + (CharData[i][ 71] * 256));
            for (j = 0; j < 7; j++)
            {   curstat[i][j] = (ULONG) CharData[i][ 72 + (j * 2)];
                maxstat[i][j] = (ULONG) CharData[i][ 73 + (j * 2)];
            }
            for (j = 0; j < 7; j++)
            {   minstat[i][j] = (ULONG) CharData[i][ 86 +  j     ]; // "enhanced" value
            }

            if (formats[game].littleendian)
            {   for (j = 0; j < 20; j++)
                {   level[i][j] =      (CharData[i][ 96 + (j * 4)] * 16777216)
                                +      (CharData[i][ 95 + (j * 4)] *    65536)
                                +      (CharData[i][ 94 + (j * 4)] *      256)
                                +       CharData[i][ 93 + (j * 4)];
            }   }
            else
            {   for (j = 0; j < 20; j++)
                {   level[i][j] =      (CharData[i][ 94 + (j * 4)] * 16777216)
                                +      (CharData[i][ 93 + (j * 4)] *    65536)
                                +      (CharData[i][ 96 + (j * 4)] *      256)
                                +       CharData[i][ 95 + (j * 4)];
            }   }
            for (j = 0; j < 20; j++)
            {   bonus[i][j]  = (ULONG)  CharData[i][173 +  j];
}   }   }   }

MODULE void dm2_savegame(void)
{   int i, j;

    offset = gvb;
    crypting = bitpos = 0;

#ifdef LOGSERIALIZATION
    printf("Saving global variable block at $%X.\n", offset);
#endif
    VarData[11] = loc_x   / 256; VarData[10] = loc_x   % 256; // little-endian
    VarData[13] = loc_y   / 256; VarData[12] = loc_y   % 256; // little-endian
    VarData[15] = facing  / 256; VarData[14] = facing  % 256; // little-endian
    VarData[17] = loc_lvl / 256; VarData[16] = loc_lvl % 256; // little-endian
    dm2_encrypt(VarData,   _395a, 56,  1);
    dm2_encrypt(FlagsData, _3956,  1,  8);
    dm2_encrypt(BytesData, _3956,  1, 64);
    dm2_encrypt(WordsData, _3956,  2, 64);

    if (men)
    {   offset = champs - 1;
#ifdef LOGSERIALIZATION
        printf("Saving characters at $%X.\n", offset);
#endif

        for (i = 0; i < men; i++)
        {   for (j = 0; j < 8; j++)
            {   CharData[i][j] = name[i][j];
            }
            CharData[i][0] &= 0xBF;

            for (j = 0; j < 16; j++)
            {   CharData[i][8 + j] = title[i][j];
            }

            // words are always little-endian even in "big-endian" saves
            CharData[i][54] = curhp[     i] % 256; CharData[i][55] = curhp[     i] / 256;
            CharData[i][56] = maxhp[     i] % 256; CharData[i][57] = maxhp[     i] / 256;
            CharData[i][58] = curstamina[i] % 256; CharData[i][59] = curstamina[i] / 256;
            CharData[i][60] = maxstamina[i] % 256; CharData[i][61] = maxstamina[i] / 256;
            CharData[i][62] = curmana[   i] % 256; CharData[i][63] = curmana[   i] / 256;
            CharData[i][64] = maxmana[   i] % 256; CharData[i][65] = maxmana[   i] / 256;
            // 2 bytes here
            CharData[i][68] = food[      i] % 256; CharData[i][69] = food[      i] / 256;
            CharData[i][70] = water[     i] % 256; CharData[i][71] = water[     i] / 256;
            for (j = 0; j < 7; j++)
            {   CharData[i][ 72 + (j * 2)] = (UBYTE) curstat[i][j];
                CharData[i][ 73 + (j * 2)] = (UBYTE) maxstat[i][j]; 
            }
            for (j = 0; j < 7; j++)
            {   CharData[i][ 86 +  j     ] = (UBYTE) minstat[i][j]; // "enhanced" value
            }

            if (formats[game].littleendian)
            {   for (j = 0; j < 20; j++)
                {   CharData[i][ 93 + (j * 4)] =  level[i][j] / 16777216;
                    CharData[i][ 94 + (j * 4)] = (level[i][j] % 16777216) / 65536;
                    CharData[i][ 95 + (j * 4)] = (level[i][j] %    65536) /   256;
                    CharData[i][ 96 + (j * 4)] =  level[i][j]             %   256;
            }   }
            else
            {   for (j = 0; j < 20; j++)
                {   CharData[i][ 94 + (j * 4)] =  level[i][j] / 16777216;
                    CharData[i][ 93 + (j * 4)] = (level[i][j] % 16777216) / 65536;
                    CharData[i][ 96 + (j * 4)] = (level[i][j] %    65536) /   256;
                    CharData[i][ 95 + (j * 4)] =  level[i][j]             %   256;
            }   }
            for (j = 0; j < 20; j++)
            {   CharData[i][173 + j] = (UBYTE) bonus[i][j];
            }

            dm2_encrypt(CharData[i], _3992, 261, 1);
    }   }

    IOBuffer[champs - 1] = preserve;
}

MODULE void dm2_decrypt(UBYTE* data, const UBYTE* mask, int buffSize, int repeat)
{   int bit,
        i, j;

    for (i = 0; i < repeat; i++)
    {   for (j = 0; j < buffSize; j++)
        {   if (mask[j] != 0)
            {   for (bit = 7; bit >= 0; bit--)
                {   if ((1 << bit) & mask[j]) // if this bit is set in mask
                    {   if (bitpos == 0)
                        {   crypting = IOBuffer[offset++];
                        }
                        if (crypting & 0x80)
                        {   crypting <<= 1;
                            crypting |=  1;
                            data[(i * buffSize) + j] |=   (1 << bit) ;
                        } else
                        {   crypting <<= 1;
                            data[(i * buffSize) + j] &= (~(1 << bit));
                        }
                        if (bitpos == 7)
                        {   bitpos = 0;
                        } else
                        {   bitpos++;
}   }   }   }   }   }   }

MODULE void dm2_encrypt(UBYTE* data, const UBYTE* mask, int buffSize, int repeat)
{   int bit,
        i, j;

    for (i = 0; i < repeat; i++)
    {   for (j = 0; j < buffSize; j++)
        {   if (mask[j])
            {   for (bit = 7; bit >= 0; bit--)
                {   if ((1 << bit) & mask[j]) // if this bit is set in mask
                    {   crypting <<= 1;
                        if ((1 << bit) & data[(i * buffSize) + j])
                        {   crypting |= 1;
                        }
                        if (bitpos == 7)
                        {   IOBuffer[offset++] = crypting;
                            bitpos = 0;
                            crypting = 0;
                        } else
                        {   bitpos++;
}   }   }   }   }   }   }
    
#ifdef LOGSERIALIZATION
MODULE void showchar(int which)
{   int i, j;

    printf("Character #%d:\n", which);
    for (i = 0; i < 256; i += 16)
    {   printf
        (   "%3d: %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X ",
            i,
            CharData[which][i     ],
            CharData[which][i +  1],
            CharData[which][i +  2],
            CharData[which][i +  3],
            CharData[which][i +  4],
            CharData[which][i +  5],
            CharData[which][i +  6],
            CharData[which][i +  7],
            CharData[which][i +  8],
            CharData[which][i +  9],
            CharData[which][i + 10],
            CharData[which][i + 11],
            CharData[which][i + 12],
            CharData[which][i + 13],
            CharData[which][i + 14],
            CharData[which][i + 15]
        );
        for (j = 0; j < 16; j++)
        {   if
            (    CharData[which][i + j] <   32
             || (CharData[which][i + j] >= 127 && CharData[which][i + j] <= 160)
            )
            {   printf("·");
            } else
            {   printf("%c", CharData[which][i + j]);
        }   }
        printf("\n");
    }
    printf
    (   "256: %02X %02X %02X %02X %02X                                  ",
        CharData[which][256],
        CharData[which][257],
        CharData[which][258],
        CharData[which][259],
        CharData[which][260]
    );
    for (j = 0; j < 5; j++)
    {   if
        (    CharData[which][256 + j] <   32
         || (CharData[which][256 + j] >= 127 && CharData[which][256 + j] <= 160)
        )
        {   printf("·");
        } else
        {   printf("%c", CharData[which][256 + j]);
    }   }
    printf("\n");
}
#endif

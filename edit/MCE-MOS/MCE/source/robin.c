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

// #define SHOWOFFSETS
// whether you want offsets of the map cells to be shown

// main window
#define GID_ROBIN_LY1    0 // root layout
#define GID_ROBIN_SB1    1 // toolbar
#define GID_ROBIN_SP1    2 // map
#define GID_ROBIN_SP2    3 // tiles
#define GID_ROBIN_SP3    4 // lower
#define GID_ROBIN_SP4    5 // middle
#define GID_ROBIN_SP5    6 // upper
#define GID_ROBIN_SP6    7 // barriers
#define GID_ROBIN_ST1    8 // 1st description
#define GID_ROBIN_ST2    9 // 2th description
#define GID_ROBIN_ST3   10 // 3rd description
#define GID_ROBIN_ST4   11 // 4th description
#define GID_ROBIN_ST5   12 // brush
#define GID_ROBIN_BU1   13 // clear layer
#define GID_ROBIN_BU2   14 // maximize character
#define GID_ROBIN_CH1   15 // layer
#define GID_ROBIN_CH2   16 // hood
#define GID_ROBIN_CH3   17 // lightning
#define GID_ROBIN_CH4   18 // ring
#define GID_ROBIN_CH5   19 // horn
#define GID_ROBIN_CH6   20 // toadstool
#define GID_ROBIN_CH7   21 // feather
#define GID_ROBIN_CH8   22 // orb
#define GID_ROBIN_CH9   23 // game
#define GID_ROBIN_CH10  24 // level
#define GID_ROBIN_IN1   25 // health
#define GID_ROBIN_IN2   26 // strength
#define GID_ROBIN_IN3   27 // gold
#define GID_ROBIN_IN4   28 // bravery
#define GID_ROBIN_IN5   29 // optimism
#define GID_ROBIN_IN6   30 // heroism
#define GID_ROBIN_CB1   31 // draw grid?
#define GIDS_ROBIN      GID_ROBIN_CB1

#define MAPWIDTH      64
#define MAPHEIGHT     64
#define MAPSCALE       6
#define SCALEDWIDTH    (MAPWIDTH  * MAPSCALE)
#define SCALEDHEIGHT   (MAPHEIGHT * MAPSCALE)
#define TILESWIDTH     (22        * MAPSCALE)
#define TILESHEIGHT    (12        * MAPSCALE)

#define BLUE        0
#define DARKGREEN   1
#define YELLOW      2
#define WHITE       3
#define BLACK       4
#define RED         5
#define LIGHTGREEN  6
#define GREY        7
#define PURPLE      8
#define DARKGREY    9
#define ORANGE     10
#define SKYBLUE    11
#define PINK       12
#define BROWN      13

#define ROBIN       0
#define ROME        1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void drawpoint(int x, int y, int colour);
MODULE void updatetiles(void);
MODULE void robin_drawmappart(int x, int y, FLAG redraw);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
IMPORT LONG                 gamesize,
                            pens[PENS];
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT Object*              WinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT UBYTE               *byteptr1[DISPLAY1HEIGHT],
                           *byteptr2[DISPLAY2HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE],
                            display2[DISPLAY2SIZE];

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE int                  game,
                            health,
                            item[7],
                            strength,
                            gold,
                            bravery,
                            optimism,
                            heroism;
MODULE FLAG                 lmb;
MODULE UBYTE                robin_stamp[4] = { 0, 0, 0, 0 };
MODULE ULONG                drawgrid       = FALSE,
                            layer          = 0, // lower
                            level;
MODULE struct RastPort      wpa8brushrastport[4];
MODULE UBYTE*               brushbyteptr[4][MAPSCALE * 2];
MODULE __aligned UBYTE      brushdisplay[4][GFXINIT(MAPSCALE * 2, MAPSCALE * 2)];
MODULE struct BitMap*       wpa8brushbitmap[4] = {NULL, NULL, NULL, NULL};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE const STRPTR GameOptions[2 + 1] =
{ "Robin Hood",
  "Rome: AD92",
  NULL
}, LevelOptions[2][4 + 1] = { {
  "Sherwood Forest",
  NULL,
  NULL,
  NULL,
  NULL
}, {
  "Herculaneum",
  "Rome",
  "Britain",
  "Egypt",
  NULL
} }, ItemOptions[4 + 1] =
{ "Missing",
  "Charging",
  "Ready",
  "In use",
  NULL
}, LayerOptions[4 + 1] =
{ "Lower",
  "Middle",
  "Upper",
  "Barriers",
  NULL
};

MODULE const STRPTR desc[][5] = {
{ "grass block"                , "grass block"      , "courtyard block"      , "grass block"           , "sand block"             }, // $00
{ "grass/dirt block"           , "grass/dirt block" , "dirt block"           , "lush grass block"      , "dirt block"             }, // $01
{ "dirt/grass block"           , "lawn block"       , "pavement block #2"    , "crops"                 , "slope ascending NW #2"  }, // $02
{ "stone block"                , "dirt block #3"    , "lawn block"           , "dirt/grass block"      , "slope ascending S"      }, // $03
{ "slope #4"                   , "dirt block #4"    , "pavement block #4"    , "grass/dirt block"      , "slope ascending W #4"   }, // $04
{ "slope #5"                   , "marsh"            , "marble block #5"      , "flat grass"            , "slope ascending NW #5"  }, // $05
{ "slope #6"                   , "slope #6"         , "marble block #6"      , "slope ascending NW #6" , "slope ascending SE"     }, // $06
{ "slope #7"                   , "slope #7"         , "marble block #7"      , "slope ascending NE #7" , "slope ascending E #7"   }, // $07
{ "slope #8"                   , "slope #8"         , "water"                , "slope ascending SW #8" , "slope ascending NE #8"  }, // $08
{ "slope #9"                   , "slope #9"         , "low E-W roof"         , "slope ascending NW #9" , "slope ascending SW #9"  }, // $09
{ "slope #10"                  , "slope #10"        , "low roof ascending N" , "slope ascending SE"    , "slope ascending SW #10" }, // $0A
{ "slope #11"                  , "slope #11"        , "high roof ascending N", "slope ascending SW #11", "slope ascending NE #11" }, // $0B
{ "slope #12"                  , "slope #12"        , "high E-W roof"        , "slope ascending NE #12", "slope ascending N #12"  }, // $0C
{ "slope #13"                  , "slope #13"        , "high roof ascending S", "slope ascending S"     , "slope ascending NW #13" }, // $0D
{ "slope #14"                  , "slope #14"        , "low roof ascending S" , "slope ascending E"     , "slope ascending W #14"  }, // $0E
{ "slope #15"                  , "flat grass"       , "low roof ascending E" , "slope ascending W #15" , "slope ascending N #15"  }, // $0F
{ "slope #16"                  , "slope #16"        , "high roof ascending E", "slope ascending W #16" , "slope ascending E #16"  }, // $10
{ "bridge block"               , "slope #17"        , "high N-S roof"        , "slope ascending N #17" , "step"                   }, // $11
{ "river block #18"            , "slope #18"        , "high roof ascending W", "slope ascending N #18" , "slope ascending NW #18" }, // $12
{ "river block #19"            , "slope #19"        , "low roof ascending W" , "seawater block"        , "?"                      }, // $13
{ "tree #20"                   , "tree"             , "low N-S roof"         , "freshwater block"      , "water block"            }, // $14
{ "tree #21"                   , "shrub"            , "high E-W roof"        , "NW grass/SE water #21" , "water w/ many plants"   }, // $15
{ "shrub"                      , "vines"            , "attic w/ win S"       , "NE grass/SW water #22" , "water w/ some plants"   }, // $16
{ "water block"                , "W end of boat"    , "castle w/ arch S"     , "SE grass/NW water #23" , "?"                      }, // $17
{ "water block w/ plants"      , "E end of boat #24", "castle"               , "SW grass/NE water #24" , "?"                      }, // $18
{ "grave w/ headstone"         , "E end of boat #25", "castle w/ wins #25"   , "SE grass/NW water #25" , "slope ascending SW #25" }, // $19
{ "empty grave"                , "seawater block"   , "castle w/ wins #26"   , "NE grass/SW water #26" , "?"                      }, // $1A
{ "grass block w/ river tunnel", "freshwater block" , "castle w/ E door"     , "NW grass/SE water #27" , "sand/grass block #27"   }, // $1B
{ "waterfall"                  , "path block"       , "top of arch"          , "SW grass/NE water #28" , "sand/grass block #28"   }, // $1C
{ "?"                          , "courtyard block"  , "columns"              , "water w/ some plants"  , "sand/grass block #29"   }, // $1D
{ "E-W wall w/ arrow slit"     , "drain block"      , "pavement block #30"   , "water w/ many plants"  , "grass/sand block"       }, // $1E
{ "N-S wall w/ arrow slit"     , "barrels"          , "bottom of arch"       , "beach block #31"       , "sand/grass block #31"   }, // $1F
{ "castle block w/ arched wins", "high N-S roof"    , "aqueduct"             , "dunes block #32"       , "bridge"                 }, // $20
{ "pyramidical roof w/ flag"   , "low N-S roof #33" , "archway #33"          , "dunes block #33"       , "dune"                   }, // $21
{ "?"                          , "wooden house"     , "archway #34"          , "beach block #34"       , "grass block"            }, // $22
{ "castle block w/ arrow slits", "house w/ windows" , "W-NE curve"           , "beach block #35"       , "tile block"             }, // $23
{ "low grey roof"              , "house w/ S door"  , "N-SW curve"           , "NE beach/SW seawater"  , "tree"                   }, // $24
{ "castle block w/ portcullis" , "house w/ E door"  , "stairs ascending W"   , "NW beach/SE seawater"  , "bottom of statue"       }, // $25
{ "raised drawbridge"          , "house w/ E window", "stairs ascending N"   , "beach block #38"       , "middle of statue"       }, // $26
{ "lowered drawbridge"         , "low N-S roof #39" , "dais"                 , "stakes"                , "top of statue"          }, // $27
{ "house block w/ door"        , "laden table"      , "high N-S wall"        , "grass/sand block"      , "obelisk #40"            }, // $28
{ "house block w/ square wins" , "columns"          , "high E-W wall"        , "sand/grass block #41"  , "N-S stone wall #41"     }, // $29
{ "house block w/ paned wins"  , "roof ascending S" , "low N-S wall"         , "sand/grass block #42"  , "E-W stone wall #42"     }, // $2A
{ "E-W thatched roof"          , "high E-W roof"    , "low E-W wall"         , "sand/grass block #43"  , "N-S stone wall #43"     }, // $2B
{ "N-S thatched roof"          , "fountain"         , "columns E"            , "skull"                 , "E-W stone wall #44"     }, // $2C
{ "bottom of gallows"          , "low E-W roof"     , "columns S"            , "tree #45"              , "crenellated block"      }, // $2D
{ "top of gallows #46"         , "altar"            , "columns SE"           , "tree #46"              , "stone w/ S sculpture"   }, // $2E
{ "flat grass"                 , "roof ascending N" , "column #47"           , "shrub"                 , "stone block"            }, // $2F
{ "unladen table"              , "roof ascending W" , "statue #48"           , "bridge"                , "obelisk #48"            }, // $30
{ "laden table"                , "roof ascending E" , "statue #49"           , "fire"                  , "stone w/ wins E"        }, // $31
{ "fire"                       , "high N-S wall"    , "statue #50"           , "?"                     , "stairs ascending W"     }, // $32
{ "?"                          , "archway"          , "fountain"             , "?"                     , "stairs ascending N"     }, // $33
{ "fire w/ meat"               , "low N-S wall"     , "obelisk"              , "?"                     , "stairs ascending NW"    }, // $34
{ "?"                          , "low E-W wall"     , "altar"                , "?"                     , "stairs ascending E"     }, // $35
{ "top of gallows #54"         , "throne"           , "pavillion"            , "hut #54"               , "stairs ascending NE"    }, // $36
{ "wooden block"               , "column"           , "tree"                 , "hut #55"               , "top of arch"            }, // $37
{ "ash heap"                   , "statue"           , "N-S hedge"            , "E-W palisade"          , "bottom of arch"         }, // $38
{ "archery target"             , "1/3 lava"         , "E-W hedge"            , "N-S palisade"          , "stone w/ E door"        }, // $39
{ "grass block w/ flowers"     , "2/3 lava"         , "N-S bench"            , "palisade corner"       , "arch"                   }, // $3A
{ "grass block w/ cave"        , "3/3 lava"         , "E-W bench"            , "menhir"                , "stone w/ wins S & E"    }, // $3B
};

MODULE const UBYTE stamp_to_barrier[8] =
{ 0x0F,
  0x09,
  0x06,
  0x00,
  0x8F,
  0x89,
  0x86,
  0x80
};

MODULE const TEXT gfx[5][60][6][6 + 1] = { { // Sherwood Forest
{ // 0: grass block
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
},
{ // 1: grass/dirt block
  "LLLLLL",
  "LBLLBL",
  "LLLLLL",
  "LLLLLL",
  "LBLLBL",
  "LLLLLL",
},
{ // 2: dirt/grass block
  "BBBBBB",
  "BLBBLB",
  "BBBBBB",
  "BBBBBB",
  "BLBBLB",
  "BBBBBB",
},
{ // 3: stone block
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 4: slope #4
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
},
{ // 5: slope #5
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
},
{ // 6: slope #6
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
},
{ // 7: slope #7
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
},
{ // 8: slope #8
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
},
{ // 9: slope #9
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
},
{ // 10: slope #10
  "LLLLLL",
  "LLLLLD",
  "LLLLDD",
  "LLLDDD",
  "LLDDDD",
  "LDDDDD",
},
{ // 11: slope #11
  "LLLLLL",
  "DLLLLL",
  "DDLLLL",
  "DDDLLL",
  "DDDDLL",
  "DDDDDL",
},
{ // 12: slope #12
  "LDDDDD",
  "LLDDDD",
  "LLLDDD",
  "LLLLDD",
  "LLLLLD",
  "LLLLLL",
},
{ // 13: slope #13
  "LLLLLL",
  "LLLLLD",
  "LLLLDD",
  "LLLDDD",
  "LLDDDD",
  "LDDDDD",
},
{ // 14: slope #14
  "DDDDDL",
  "DDDDLL",
  "DDDLLL",
  "DDLLLL",
  "DLLLLL",
  "LLLLLL",
},
{ // 15: slope #15
  "LDDDDD",
  "LLDDDD",
  "LLLDDD",
  "LLLLDD",
  "LLLLLD",
  "LLLLLL",
},
{ // 16: slope #16
  "LLLLLL",
  "DLLLLL",
  "DDLLLL",
  "DDDLLL",
  "DDDDLL",
  "DDDDDL",
},
{ // 17: bridge block
  "LLUULL",
  "LLUULL",
  "OOOOOO",
  "OOOOOO",
  "LLUULL",
  "LLUULL",
},
{ // 18: river block #18
  "LLUULL",
  "LLLUUL",
  "LLLUUL",
  "LLLUUL",
  "LLLUUL",
  "LLUULL",
},
{ // 19: river block #19
  "LLUULL",
  "LUULLL",
  "LUULLL",
  "LUULLL",
  "LUULLL",
  "LLUULL",
},
{ // 20: tree #20
  "CCCCCC",
  "CLLLLC",
  "CLLLLC",
  "CLLLLC",
  "CLLLLC",
  "CCCCCC",
},
{ // 21: tree #21
  "CCCCCC",
  "CLLLLC",
  "CLLLLC",
  "CLLLLC",
  "CLLLLC",
  "CCCCCC",
},
{ // 22: shrub
  "CCCCCC",
  "CCLLCC",
  "CLLLLC",
  "CLLLLC",
  "CCLLCC",
  "CCCCCC",
},
{ // 23: water block
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
},
{ // 24: water block w/ plants
  "UUUUUU",
  "UYUUYU",
  "UUUUUU",
  "UUUUUU",
  "UYUUYU",
  "UUUUUU",
},
{ // 25: grave w/ headstone
  "CCWWCC",
  "CWWWWC",
  "CWWWWC",
  "CWWWWC",
  "CWWWWC",
  "CWWWWC",
},
{ // 26: empty grave
  "CCAACC",
  "CAAAAC",
  "CAAAAC",
  "CAAAAC",
  "CAAAAC",
  "CAAAAC",
},
{ // 27: grass block w/ river tunnel
  "LLUULL",
  "LLUULL",
  "LLUULL",
  "LLUULL",
  "LLUULL",
  "LLUULL",
},
{ // 28: waterfall
  "UUUUUU",
  "WWWWWW",
  "UUUUUU",
  "UWWWWU",
  "UUUUUU",
  "UUWWUU",
},
{ // 29: ?
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
},
{ // 30: E-W wall w/ arrow slit
  "CCCCCC",
  "CCCCCC",
  "AAAAAA",
  "AAAAAA",
  "CCCCCC",
  "CCCCCC",
},
{ // 31: N-S wall w/ arrow slit
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
},
{ // 32: castle block w/ arched windows
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 33: pyramidical roof w/ flag
  "BBBBBB",
  "BYYYYB",
  "BYRRYB",
  "BYRRYB",
  "BYYYYB",
  "BBBBBB",
},
{ // 34: ?
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
},
{ // 35: castle block w/ arrow slits
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 36: house block w/ door
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 37: castle block w/ portcullis
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 38: raised drawbridge
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 39: lowered drawbridge
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 40: house block w/ door
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 41: house block w/ square windows
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 42: house block w/ paned windows
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 43: E-W thatched roof
  "BBBBBB",
  "BBBBBB",
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
},
{ // 44: N-S thatched roof
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
},
{ // 45: bottom of gallows
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 46: top of gallows #46
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 47: flat grass
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
},
{ // 48: unladen table
  "CCCCCC",
  "COOOOC",
  "COOOOC",
  "COOOOC",
  "COOOOC",
  "CCCCCC",
},
{ // 49: laden table
  "CCCCCC",
  "COOOOC",
  "CORROC",
  "CORROC",
  "COOOOC",
  "CCCCCC",
},
{ // 50: fire w/out meat
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
},
{ // 51: ?
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
},
{ // 52: fire w/ meat
  "RRRRRR",
  "RRRRRR",
  "RBBBRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
},
{ // 53: ?
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
},
{ // 54: top of gallows #54
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 55: logs block
  "BBBBBB",
  "OOOOOO",
  "BBBBBB",
  "OOOOOO",
  "BBBBBB",
  "OOOOOO",
},
{ // 56: ash heap
  "GAGAGA",
  "AGAGAG",
  "GAGAGA",
  "AGAGAG",
  "GAGAGA",
  "AGAGAG",
},
{ // 57: archery target
  "CBBBBC",
  "BBOOBB",
  "BOYYOB",
  "BOYYOB",
  "BBOOBB",
  "CBBBBC",
},
{ // 58: grass block w/ flowers
  "LLLLLL",
  "LYLLYL",
  "LLLLLL",
  "LLLLLL",
  "LYLLYL",
  "LLLLLL",
},
{ // 59: grass block w/ cave
  "LCCCCL",
  "LCCCCL",
  "LCCCCL",
  "LCCCCL",
  "LCCCCL",
  "LCCCCL",
} }, { // Herculaneum
{ // 0: grass block
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
},
{ // 1: grass/dirt block
  "LLLLLL",
  "LBLLBL",
  "LLLLLL",
  "LLLLLL",
  "LBLLBL",
  "LLLLLL",
},
{ // 2: lawn block
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
},
{ // 3: dirt block #3
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
},
{ // 4: dirt block #4
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
},
{ // 5: marsh
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
},
{ // 6: slope #6
  "LLLLLL",
  "LLLLLD",
  "LLLLDD",
  "LLLDDD",
  "LLDDDD",
  "LDDDDD",
},
{ // 7: slope #7
  "LLLLLL",
  "DLLLLL",
  "DDLLLL",
  "DDDLLL",
  "DDDDLL",
  "DDDDDL",
},
{ // 8: slope #8
  "LDDDDD",
  "LLDDDD",
  "LLDDDD",
  "LLLDDD",
  "LLLLDD",
  "LLLLLL",
},
{ // 9: slope #9
  "LLLLLL",
  "LLLLLD",
  "LLLLDD",
  "LLLDDD",
  "LLDDDD",
  "LDDDDD",
},
{ // 10: slope #10
  "DDDDDL",
  "DDDDLL",
  "DDDLLL",
  "DDLLLL",
  "DLLLLL",
  "LLLLLL",
},
{ // 11: slope #11
  "LDDDDD",
  "LLDDDD",
  "LLLDDD",
  "LLLLDD",
  "LLLLLD",
  "LLLLLL",
},
{ // 12: slope #12
  "LLLLLL",
  "DLLLLL",
  "DDLLLL",
  "DDDLLL",
  "DDDDLL",
  "DDDDDL",
},
{ // 13: slope #13
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
},
{ // 14: slope #14
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
},
{ // 15: flat grass
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
},
{ // 16: slope #16
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
},
{ // 17: slope #17
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
},
{ // 18: slope #18
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
},
{ // 19: slope #19
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
},
{ // 20: tree
  "CCCCCC",
  "CLLLLC",
  "CLLLLC",
  "CLLLLC",
  "CLLLLC",
  "CCCCCC",
},
{ // 21: shrub
  "CCCCCC",
  "CCLLCC",
  "CLLLLC",
  "CLLLLC",
  "CCLLCC",
  "CCCCCC",
},
{ // 22: vines
  "CCCCCC",
  "CCLLCC",
  "CLLLLC",
  "CLLLLC",
  "CCLLCC",
  "CCCCCC",
},
{ // 23: W end of boat
  "CBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "CBBBBB",
},
{ // 24: E end of boat #24
  "BBBBBC",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBC",
},
{ // 25: E end of boat #25
  "BBBBBC",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBC",
},
{ // 26: seawater block
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
},
{ // 27: freshwater block
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
},
{ // 28: path block
  "WGWGWG",
  "GWGWGW",
  "WGWGWG",
  "GWGWGW",
  "WGWGWG",
  "GWGWGW",
},
{ // 29: courtyard block
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 30: drain block
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 31: barrels
  "BBCCBB",
  "BBCCBB",
  "CCCCCC",
  "CCCCCC",
  "CCBBCC",
  "CCBBCC",
},
{ // 32: high N-S roof
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
},
{ // 33: low N-S roof #33
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
},
{ // 34: wooden house
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 35: house block w/ windows
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 36: house block w/ S door
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 37: house block w/ E door
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 38: house block w/ E window
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 39: low N-S roof #39
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
},
{ // 40: laden table
  "CCCCCC",
  "COOOOC",
  "CORROC",
  "CORROC",
  "COOOOC",
  "CCCCCC",
},
{ // 41: columns
  "AACCAA",
  "AACCAA",
  "CCCCCC",
  "CCCCCC",
  "AACCAA",
  "AACCAA",
},
{ // 42: roof ascending S
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "YYYYYY",
  "YYYYYY",
},
{ // 43: high E-W sloped roof
  "BBBBBB",
  "BBBBBB",
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
},
{ // 44: fountain
  "CUUUUC",
  "UOOOOU",
  "UOOOOU",
  "UOOOOU",
  "UOOOOU",
  "CUUUUC",
},
{ // 45: low E-W sloped roof
  "BBBBBB",
  "BBBBBB",
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
},
{ // 46: altar
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 47: roof ascending N
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
},
{ // 48: roof ascending W
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
},
{ // 49: roof ascending E
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
},
{ // 50: high N-S wall
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
},
{ // 51: archway
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 52: N-S wall
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
},
{ // 53: E-W wall
  "CCCCCC",
  "CCCCCC",
  "AAAAAA",
  "AAAAAA",
  "CCCCCC",
  "CCCCCC",
},
{ // 54: throne
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 55: column
  "CGGGGC",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "CGGGGC",
},
{ // 56: statue
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 57: 1/3 lava
  "RRRRRR",
  "RRRRRR",
  "CCCCCC",
  "CCCCCC",
  "CCCCCC",
  "CCCCCC",
},
{ // 58: 2/3 lava
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "CCCCCC",
  "CCCCCC",
},
{ // 59: 3/3 lava
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
} }, { // Rome
{ // 0: courtyard block
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 1: dirt block
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
},
{ // 2: pavement block #2
  "WGWGWG",
  "GWGWGW",
  "WGWGWG",
  "GWGWGW",
  "WGWGWG",
  "GWGWGW",
},
{ // 3: lawn block
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
},
{ // 4: pavement block #4
  "WGWGWG",
  "GWGWGW",
  "WGWGWG",
  "GWGWGW",
  "WGWGWG",
  "GWGWGW",
},
{ // 5: marble block #5
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
},
{ // 6: marble block #6
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
},
{ // 7: marble block #7
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
},
{ // 8: water
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
},
{ // 9: low E-W roof
  "BBBBBB",
  "BBBBBB",
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
},
{ // 10: low roof ascending N
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
},
{ // 11: high roof ascending N
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
},
{ // 12: high E-W roof
  "BBBBBB",
  "BBBBBB",
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
},
{ // 13: high roof ascending S
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "YYYYYY",
  "YYYYYY",
},
{ // 14: low roof ascending S
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "YYYYYY",
  "YYYYYY",
},
{ // 15: low roof ascending E
  "BBBBYY",
  "BBBBYY",
  "BBBBYY",
  "BBBBYY",
  "BBBBYY",
  "BBBBYY",
},
{ // 16: high roof ascending E
  "BBBBYY",
  "BBBBYY",
  "BBBBYY",
  "BBBBYY",
  "BBBBYY",
  "BBBBYY",
},
{ // 17: high N-S roof
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
},
{ // 18: high roof ascending W
  "YYBBBB",
  "YYBBBB",
  "YYBBBB",
  "YYBBBB",
  "YYBBBB",
  "YYBBBB",
},
{ // 19: low roof ascending W
  "YYBBBB",
  "YYBBBB",
  "YYBBBB",
  "YYBBBB",
  "YYBBBB",
  "YYBBBB",
},
{ // 20: low N-S roof
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
  "BBYYBB",
},
{ // 21: high E-W roof
  "BBBBBB",
  "BBBBBB",
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
},
{ // 22: attic w/ win S
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 23: castle block w/ arch S
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 24: castle block
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 25: castle block w/ wins #25
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 26: castle block w/ wins #26
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 27: castle block w/ E door
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 28: top of arch
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 29: columns
  "AACCAA",
  "AACCAA",
  "CCCCCC",
  "CCCCCC",
  "AACCAA",
  "AACCAA",
},
{ // 30: pavement block #30
  "WGWGWG",
  "GWGWGW",
  "WGWGWG",
  "GWGWGW",
  "WGWGWG",
  "GWGWGW",
},
{ // 31: bottom of arch
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 32: aqueduct
  "GGUUGG",
  "GGUUGG",
  "GGUUGG",
  "GGUUGG",
  "GGUUGG",
  "GGUUGG",
},
{ // 33: archway #33
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 34: archway #34
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 35: W-NE curve
  "CCCCAA",
  "CCCAAA",
  "AAAACC",
  "AAACCC",
  "CCCCCC",
  "CCCCCC",
},
{ // 36: N-SW curve
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CAACCC",
  "AACCCC",
  "AACCCC",
},
{ // 37: stairs ascending W
  "GAGGGG",
  "GAGAGG",
  "GAGAGA",
  "GAGAGA",
  "GAGAGG",
  "GAGGGG",
},
{ // 38: stairs ascending N
  "GGGGGG",
  "AAAAAA",
  "GGGGGG",
  "GAAAAG",
  "GGGGGG",
  "GGAAGG",
},
{ // 39: dais
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 40: high N-S wall
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
},
{ // 41: high E-W wall
  "CCCCCC",
  "CCCCCC",
  "AAAAAA",
  "AAAAAA",
  "CCCCCC",
  "CCCCCC",
},
{ // 42: low N-S wall
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
},
{ // 43: low E-W wall
  "CCCCCC",
  "CCCCCC",
  "AAAAAA",
  "AAAAAA",
  "CCCCCC",
  "CCCCCC",
},
{ // 44: columns E
  "CCCAAA",
  "CCCAAA",
  "CCCCCC",
  "CCCCCC",
  "CCCAAA",
  "CCCAAA",
},
{ // 45: columns S
  "CCCCCC",
  "CCCCCC",
  "CCCCCC",
  "CCCCCC",
  "AACCAA",
  "AACCAA",
},
{ // 46: columns SE
  "CCCCAA",
  "CCCCAA",
  "CCCCCC",
  "CCCCCC",
  "AACCAA",
  "AACCAA",
},
{ // 47: column #47
  "CGGGGC",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "CGGGGC",
},
{ // 48: statue #48
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 49: statue #49
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 50: statue #50
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 51: fountain
  "CUUUUC",
  "UOOOOU",
  "UOOOOU",
  "UOOOOU",
  "UOOOOU",
  "CUUUUC",
},
{ // 52: obelisk
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 53: altar
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 54: pavillion
  "COOOOC",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "COOOOC",
},
{ // 55: tree
  "CCCCCC",
  "CLLLLC",
  "CLLLLC",
  "CLLLLC",
  "CLLLLC",
  "CCCCCC",
},
{ // 56: N-S hedge
  "CCDDCC",
  "CCDDCC",
  "CCDDCC",
  "CCDDCC",
  "CCDDCC",
  "CCDDCC",
},
{ // 57: E-W hedge
  "CCCCCC",
  "CCCCCC",
  "DDDDDD",
  "DDDDDD",
  "CCCCCC",
  "CCCCCC",
},
{ // 58: N-S bench
  "COOOOC",
  "COOOOC",
  "COOOOC",
  "COOOOC",
  "COOOOC",
  "COOOOC",
},
{ // 59: E-W bench
  "CCCCCC",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "CCCCCC",
} }, { // Britain
{ // 0: grass block
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
},
{ // 1: lush grass block
  "LLLLLL",
  "LDLLDL",
  "LLLLLL",
  "LLLLLL",
  "LDLLDL",
  "LLLLLL",
},
{ // 2: crops
  "BBBBBB",
  "BYBBYB",
  "BBBBBB",
  "BBBBBB",
  "BYBBYB",
  "BBBBBB",
},
{ // 3: dirt/grass block
  "BBBBBB",
  "BLBBLB",
  "BBBBBB",
  "BBBBBB",
  "BLBBLB",
  "BBBBBB",
},
{ // 4: grass/dirt block
  "LLLLLL",
  "LBLLBL",
  "LLLLLL",
  "LLLLLL",
  "LBLLBL",
  "LLLLLL",
},
{ // 5: flat grass
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
},
{ // 6: slope ascending NW #6
  "LLLLLL",
  "LLLLLD",
  "LLLLDD",
  "LLLDDD",
  "LLDDDD",
  "LDDDDD",
},
{ // 7: slope ascending NE #7
  "LLLLLL",
  "DLLLLL",
  "DDLLLL",
  "DDDLLL",
  "DDDDLL",
  "DDDDDL"
},
{ // 8: slope ascending SW #8
  "LDDDDD",
  "LLDDDD",
  "LLLDDD",
  "LLLLDD",
  "LLLLLD",
  "LLLLLL",
},
{ // 9: slope ascending NW #9
  "LLLLLL",
  "LLLLLD",
  "LLLLDD",
  "LLLDDD",
  "LLDDDD",
  "LDDDDD",
},
{ // 10: slope ascending SE
  "DDDDDL",
  "DDDDLL",
  "DDDLLL",
  "DDLLLL",
  "DLLLLL",
  "LLLLLL",
},
{ // 11: slope ascending SW #11
  "LDDDDD",
  "LLDDDD",
  "LLLDDD",
  "LLLLDD",
  "LLLLLD",
  "LLLLLL",
},
{ // 12: slope ascending NE #12
  "LLLLLL",
  "DLLLLL",
  "DDLLLL",
  "DDDLLL",
  "DDDDLL",
  "DDDDDL",
},
{ // 13: slope ascending S
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
},
{ // 14: slope ascending E
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
  "DDDLLL",
},
{ // 15: slope ascending W #15
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
},
{ // 16: slope ascending W #16
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
  "LLLDDD",
},
{ // 17: slope ascending N #17
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
},
{ // 18: slope ascending N #18
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "DDDDDD",
  "DDDDDD",
  "DDDDDD",
},
{ // 19: seawater block
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
},
{ // 20: freshwater block
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
},
{ // 21: NW grass/SE water #21
  "LLLLLL",
  "LLLLLU",
  "LLLLUU",
  "LLLUUU",
  "LLUUUU",
  "LUUUUU",
},
{ // 22: NE grass/SW water #22
  "LLLLLL",
  "ULLLLL",
  "UULLLL",
  "UUULLL",
  "UUUULL",
  "UUUUUL",
},
{ // 23: SE grass/NW water #23
  "UUUUUL",
  "UUUULL",
  "UUULLL",
  "UULLLL",
  "ULLLLL",
  "LLLLLL",
},
{ // 24: SW grass/NE water #24
  "LUUUUU",
  "LLUUUU",
  "LLLUUU",
  "LLLLUU",
  "LLLLLU",
  "LLLLLL",
},
{ // 25: SE grass/NW water #25
  "UUUUUL",
  "UUUULL",
  "UUULLL",
  "UULLLL",
  "ULLLLL",
  "LLLLLL",
},
{ // 26: NE grass/SW water #26
  "LLLLLL",
  "ULLLLL",
  "UULLLL",
  "UUULLL",
  "UUUULL",
  "UUUUUL",
},
{ // 27: NW grass/SE water #27
  "LLLLLL",
  "LLLLLU",
  "LLLLUU",
  "LLLUUU",
  "LLUUUU",
  "LUUUUU",
},
{ // 28: SW grass/NE water #28
  "LUUUUU",
  "LLUUUU",
  "LLLUUU",
  "LLLLUU",
  "LLLLLU",
  "LLLLLL",
},
{ // 29: water w/ some plants
  "UUUUUU",
  "UYUUYU",
  "UUUUUU",
  "UUUUUU",
  "UYUUYU",
  "UUUUUU",
},
{ // 30: water w/ many plants
  "YUYUYU",
  "UYUYUY",
  "YUYUYU",
  "UYUYUY",
  "YUYUYU",
  "UYUYUY",
},
{ // 31: beach block #31
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
},
{ // 32: dunes block #32
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
},
{ // 33: dunes block #33
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
},
{ // 34: beach block #34
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
},
{ // 35: beach block #35
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
},
{ // 36: NE beach/SW seawater
  "YYYYYY",
  "UYYYYY",
  "UUYYYY",
  "UUUYYY",
  "UUUUYY",
  "UUUUUY",
},
{ // 37: NW beach/SE seawater
  "YYYYYY",
  "YYYYYU",
  "YYYYUU",
  "YYYUUU",
  "YYUUUU",
  "YUUUUU",
},
{ // 38: beach block #38
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
},
{ // 39: stakes
  "LLLLLL",
  "LBLLBL",
  "LBLLBL",
  "LBLLBL",
  "LBLLBL",
  "LLLLLL",
},
{ // 40: grass/sand block
  "LYLYLY",
  "YLYLYL",
  "LYLYLY",
  "YLYLYL",
  "LYLYLY",
  "YLYLYL",
},
{ // 41: sand/grass block #41
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
},
{ // 42: sand/grass block #42
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
},
{ // 43: sand/grass block #43
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
},
{ // 44: skull
  "CWWWWC",
  "WCWWCW",
  "WWWWWW",
  "WWWWWW",
  "CWCCWC",
  "CWCCWC",
},
{ // 45: tree #45
  "CCCCCC",
  "CCLLCC",
  "CLLLLC",
  "CLLLLC",
  "CCLLCC",
  "CCCCCC",
},
{ // 46: tree #46
  "CCCCCC",
  "CCLLCC",
  "CLLLLC",
  "CLLLLC",
  "CCLLCC",
  "CCCCCC",
},
{ // 47: shrub
  "CCCCCC",
  "CCLLCC",
  "CLLLLC",
  "CLLLLC",
  "CCLLCC",
  "CCCCCC",
},
{ // 48: bridge
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 49: fire
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
},
{ // 50: ?
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
},
{ // 51: ?
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
},
{ // 52: ?
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
},
{ // 53: ?
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
  "KKKKKK",
},
{ // 54: hut #54
  "CBBBBC",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "CBBBBC",
},
{ // 55: hut #55
  "CBBBBC",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "CBBBBC",
},
{ // 56: E-W palisade
  "CCCCCC",
  "CCCCCC",
  "BBBBBB",
  "BBBBBB",
  "CCCCCC",
  "CCCCCC",
},
{ // 57: N-S palisade
  "CCBBCC",
  "CCBBCC",
  "CCBBCC",
  "CCBBCC",
  "CCBBCC",
  "CCBBCC",
},
{ // 58: palisade corner
  "CCBBCC",
  "CCBBCC",
  "BBBBBB",
  "BBBBBB",
  "CCBBCC",
  "CCBBCC",
},
{ // 59: menhir
  "COOOOC",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "COOOOC",
} }, { // Egypt
{ // 0: sand block
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
},
{ // 1: dirt block
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
},
{ // 2: slope ascending NW #2
  "YYYYYY",
  "YYYYYB",
  "YYYBBB",
  "YYBBBB",
  "YBBBBB",
  "BBBBBB",
},
{ // 3: slope ascending S
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
},
{ // 4: slope ascending W #4
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
},
{ // 5: slope ascending NW #5
  "YYYYYY",
  "YYYYYB",
  "YYYYBB",
  "YYYBBB",
  "YYBBBB",
  "YBBBBB",
},
{ // 6: slope ascending SE
  "BBBBBY",
  "BBBBYY",
  "BBBYYY",
  "BBYYYY",
  "BYYYYY",
  "YYYYYY",
},
{ // 7: slope ascending E #7
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
},
{ // 8: slope ascending NE #8
  "YYYYYY",
  "BYYYYY",
  "BBYYYY",
  "BBBYYY",
  "BBBBYY",
  "BBBBBY",
},
{ // 9: slope ascending SW #9
  "YBBBBB",
  "YYBBBB",
  "YYYBBB",
  "YYYYBB",
  "YYYYYB",
  "YYYYYY",
},
{ // 10: slope ascending SW #10
  "YBBBBB",
  "YYBBBB",
  "YYYBBB",
  "YYYYBB",
  "YYYYYB",
  "YYYYYY",
},
{ // 11: slope ascending NE #11
  "YYYYYY",
  "BYYYYY",
  "BBYYYY",
  "BBBYYY",
  "BBBBYY",
  "BBBBBY",
},
{ // 12: slope ascending N #12
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
},
{ // 13: slope ascending NW #13
  "YYYYYY",
  "YYYYYB",
  "YYYYBB",
  "YYYBBB",
  "YYBBBB",
  "YBBBBB",
},
{ // 14: slope ascending W #14
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
  "YYYBBB",
},
{ // 15: slope ascending N #15
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
},
{ // 16: slope ascending E #16
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
  "BBBYYY",
},
{ // 17: step
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
  "BBBBBB",
},
{ // 18: slope ascending NW #18
  "YYYYYY",
  "YYYYYB",
  "YYYYBB",
  "YYYBBB",
  "YYBBBB",
  "YBBBBB",
},
{ // 19:
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
},
{ // 20: water block
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
  "UUUUUU",
},
{ // 21: water block w/ many plants
  "YUYUYU",
  "UYUYUY",
  "YUYUYU",
  "UYUYUY",
  "YUYUYU",
  "UYUYUY",
},
{ // 22: water block w/ some plants
  "UUUUUU",
  "UYUUYU",
  "UUUUUU",
  "UUUUUU",
  "UYUUYU",
  "UUUUUU",
},
{ // 23:
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
},
{ // 25: slope ascending NW #25
  "YYYYYY",
  "YYYYYU",
  "YYYYUU",
  "YYYUUU",
  "YYUUUU",
  "YUUUUU",
},
{ // 25: slope ascending SW #25
  "YUUUUU",
  "YYUUUU",
  "YYYUUU",
  "YYYYUU",
  "YYYYYU",
  "YYYYYY",
},
{ // 26:
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
  "AAAAAA",
},
{ // 27: sand/grass block #27
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
},
{ // 28: sand/grass block #28
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
},
{ // 29: sand/grass block #29
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
},
{ // 30: grass/sand block
  "LLLLLL",
  "LYLLYL",
  "LLLLLL",
  "LLLLLL",
  "LYLLYL",
  "LLLLLL",
},
{ // 31: sand/grass block #31
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
  "YYYYYY",
  "YLYYLY",
  "YYYYYY",
},
{ // 32: bridge
  "UUUUUU",
  "UUUUUU",
  "AAAAAA",
  "AAAAAA",
  "UUUUUU",
  "UUUUUU",
},
{ // 33: dune
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
  "YYYYYY",
},
{ // 34: grass block
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
  "LLLLLL",
},
{ // 35: tile block
  "BBBBBB",
  "BWWWWB",
  "BWWWWB",
  "BWWWWB",
  "BWWWWB",
  "BBBBBB",
},
{ // 36: tree
  "CCCCCC",
  "CCLLCC",
  "CLLLLC",
  "CLLLLC",
  "CCLLCC",
  "CCCCCC",
},
{ // 37: bottom of statue
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 38: middle of statue
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 39: top of statue
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 40: obelisk #40
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
  "OOOOOO",
},
{ // 41: N-S stone wall #41
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
},
{ // 42: E-W stone wall #42
  "CCCCCC",
  "CCCCCC",
  "AAAAAA",
  "AAAAAA",
  "CCCCCC",
  "CCCCCC",
},
{ // 43: N-S stone wall #43
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
  "CCAACC",
},
{ // 44: E-W stone wall #44
  "CCCCCC",
  "CCCCCC",
  "AAAAAA",
  "AAAAAA",
  "CCCCCC",
  "CCCCCC",
},
{ // 45: crenellated block
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 46: stone block w/ S sculpture
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 47: stone block
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 48: obelisk #48
  "CCCCCC",
  "CCOOCC",
  "COOOOC",
  "COOOOC",
  "CCOOCC",
  "CCCCCC",
},
{ // 49: stone w/ wins E
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 50: stairs ascending W
  "GAGGGG",
  "GAGAGG",
  "GAGAGA",
  "GAGAGA",
  "GAGAGG",
  "GAGGGG",
},
{ // 51: stairs ascending N
  "GGGGGG",
  "AAAAAA",
  "GGGGGG",
  "GAAAAG",
  "GGGGGG",
  "GGAAGG",
},
{ // 52: stairs ascending NW
  "GGGAGG",
  "GGAGGG",
  "GAGGAG",
  "AGGAGG",
  "GGAGGG",
  "GGGGGA",
},
{ // 53: stairs ascending E
  "GGGGAG",
  "GGAGAG",
  "AGAGAG",
  "AGAGAG",
  "GGAGAG",
  "GGGGAG",
},
{ // 54: stairs ascending NE
  "GGAGGG",
  "GGGAGG",
  "GAGGAG",
  "GGAGGA",
  "GGGAGG",
  "AGGGGG",
},
{ // 55: top of arch
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 56: bottom of arch
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 57: stone block w/ E door
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 58: arch
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
},
{ // 59: stone block w/ wins S & E
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
  "GGGGGG",
} } }, barriers[8][6][6 + 1] = {
{ // 0: none on white ($0F)
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
  "WWWWWW",
},
{ // 1: horizontal barrier (not 6) on white ($09)
  "WWWWWW",
  "WWWWWW",
  "AAAAAA",
  "AAAAAA",
  "WWWWWW",
  "WWWWWW",
},
{ // 2: vertical barrier (not 9) on white ($06)
  "WWAAWW",
  "WWAAWW",
  "WWAAWW",
  "WWAAWW",
  "WWAAWW",
  "WWAAWW",
},
{ // 3: total barrier (not 6 and not 9) on white ($00)
  "WWAAWW",
  "WWAAWW",
  "AAAAAA",
  "AAAAAA",
  "WWAAWW",
  "WWAAWW",
},
{ // 4: none on red ($8F)
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
  "RRRRRR",
},
{ // 5: horizontal barrier (not 6) on red ($89)
  "RRRRRR",
  "RRRRRR",
  "AAAAAA",
  "AAAAAA",
  "RRRRRR",
  "RRRRRR",
},
{ // 6: vertical barrier (not 9) on red ($86)
  "RRAARR",
  "RRAARR",
  "RRAARR",
  "RRAARR",
  "RRAARR",
  "RRAARR",
},
{ // 7: total barrier (not 6 and not 9) on red ($80)
  "RRAARR",
  "RRAARR",
  "AAAAAA",
  "AAAAAA",
  "RRAARR",
  "RRAARR",
} };

// 8. CODE ---------------------------------------------------------------

EXPORT void robin_main(void)
{   int i,
        y;

    tool_open  = robin_open;
    tool_loop  = robin_loop;
    tool_save  = robin_save;
    tool_close = robin_close;
    tool_exit  = robin_exit;

    if (loaded != FUNC_ROBIN && !robin_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_ROBIN;

    load_images(729, 738);
    make_speedbar_list(GID_ROBIN_SB1);
    load_aiss_images(9, 10);
    robin_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_LockHeight,                         TRUE,
        WINDOW_Position,                           WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                        gadgets[GID_ROBIN_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                     TRUE,
            AddHLayout,
                AddToolbar(GID_ROBIN_SB1),
                AddSpace,
                CHILD_WeightedWidth,               50,
                AddVLayout,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    LAYOUT_AddChild,               gadgets[GID_ROBIN_CH9] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                     GID_ROBIN_CH9,
                        GA_Disabled,               TRUE,
                        CHOOSER_LabelArray,        &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                LayoutEnd,
                CHILD_WeightedWidth,               0,
                AddSpace,
                CHILD_WeightedWidth,               50,
            LayoutEnd,
            CHILD_WeightedHeight,                  0,
            AddHLayout,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,         BVS_GROUP,
                        LAYOUT_Label,              "General",
                        LAYOUT_SpaceOuter,         TRUE,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddImage(729),
                            CHILD_WeightedWidth,   0,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_IN1] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,             GID_ROBIN_IN1,
                                GA_TabCycle,       TRUE,
                                INTEGER_Minimum,   0,
                                INTEGER_Maximum,   255,
                                INTEGER_MinVisible,3 + 1,
                            IntegerEnd,
                            Label("Health:"),
                        LayoutEnd,
                        CHILD_WeightedHeight,      0,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddImage(730),
                            CHILD_WeightedWidth,   0,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_IN2] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,             GID_ROBIN_IN2,
                                GA_TabCycle,       TRUE,
                                INTEGER_Minimum,   0,
                                INTEGER_Maximum,   255,
                                INTEGER_MinVisible,3 + 1,
                            IntegerEnd,
                            Label("Strength:"),
                        LayoutEnd,
                        CHILD_WeightedHeight,      0,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddImage(731),
                            CHILD_WeightedWidth,   0,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,             GID_ROBIN_IN3,
                                GA_TabCycle,       TRUE,
                                INTEGER_Minimum,   0,
                                INTEGER_Maximum,   255,
                                INTEGER_MinVisible,3 + 1,
                            IntegerEnd,
                            Label("Gold:"),
                        LayoutEnd,
                        CHILD_WeightedHeight,      0,
                        AddLabel(""),
                        CHILD_WeightedHeight,      0,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_IN4] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                 GID_ROBIN_IN4,
                            GA_TabCycle,           TRUE,
                            INTEGER_Minimum,       0,
                            INTEGER_Maximum,       255,
                            INTEGER_MinVisible,    3 + 1,
                        IntegerEnd,
                        Label("Bravery:"),
                        CHILD_WeightedHeight,      0,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                 GID_ROBIN_IN5,
                            GA_TabCycle,           TRUE,
                            INTEGER_Minimum,       0,
                            INTEGER_Maximum,       255,
                            INTEGER_MinVisible,    3 + 1,
                        IntegerEnd,
                        Label("Optimism:"),
                        CHILD_WeightedHeight,      0,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_IN6] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                 GID_ROBIN_IN6,
                            GA_TabCycle,           TRUE,
                            INTEGER_Minimum,       0,
                            INTEGER_Maximum,       255,
                            INTEGER_MinVisible,    3 + 1,
                        IntegerEnd,
                        Label("Heroism:"),
                        CHILD_WeightedHeight,      0,
                    LayoutEnd,
                    CHILD_WeightedHeight,          0,
                    AddSpace,
                    AddVLayout,
                        LAYOUT_BevelStyle,         BVS_GROUP,
                        LAYOUT_Label,              "Items",
                        LAYOUT_SpaceOuter,         TRUE,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddImage(732),
                            CHILD_WeightedWidth,   0,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_CH2] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,             GID_ROBIN_CH2,
                                CHOOSER_LabelArray,&ItemOptions,
                            ChooserEnd,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddImage(733),
                            CHILD_WeightedWidth,   0,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_CH3] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,             GID_ROBIN_CH3,
                                CHOOSER_LabelArray,&ItemOptions,
                            ChooserEnd,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddImage(734),
                            CHILD_WeightedWidth,   0,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_CH4] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,             GID_ROBIN_CH4,
                                CHOOSER_LabelArray,&ItemOptions,
                            ChooserEnd,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddImage(735),
                            CHILD_WeightedWidth,   0,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_CH5] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,             GID_ROBIN_CH5,
                                CHOOSER_LabelArray,&ItemOptions,
                            ChooserEnd,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddImage(736),
                            CHILD_WeightedWidth,   0,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_CH6] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,             GID_ROBIN_CH6,
                                CHOOSER_LabelArray,&ItemOptions,
                            ChooserEnd,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddImage(737),
                            CHILD_WeightedWidth,   0,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_CH7] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,             GID_ROBIN_CH7,
                                CHOOSER_LabelArray,&ItemOptions,
                            ChooserEnd,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddImage(738),
                            CHILD_WeightedWidth,   0,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_CH8] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,             GID_ROBIN_CH8,
                                CHOOSER_LabelArray,&ItemOptions,
                            ChooserEnd,
                        LayoutEnd,
                    LayoutEnd,
                    CHILD_WeightedHeight,          0,
                    AddSpace,                   
                    AddVLayout,
                        LAYOUT_Label,              "Tiles",
                        LAYOUT_SpaceOuter,         TRUE,
                        LAYOUT_BevelStyle,         BVS_GROUP,
                        AddSpace,
                        AddHLayout,
                            AddSpace,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_SP2] = (struct Gadget*)
                            SpaceObject,
                                GA_ID,             GID_ROBIN_SP2,
                                SPACE_MinWidth,    TILESWIDTH,
                                SPACE_MinHeight,   TILESHEIGHT,
                                SPACE_BevelStyle,  BVS_NONE,
                                SPACE_Transparent, TRUE,
                            SpaceEnd,
                            CHILD_WeightedWidth,   0,
                            AddSpace,
                        LayoutEnd,
                        CHILD_WeightedHeight,      0,
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            AddSpace,
                            LAYOUT_AddChild,       gadgets[GID_ROBIN_ST5] = (struct Gadget*)
                            StringObject,
                                GA_ID,             GID_ROBIN_ST5,
                                GA_ReadOnly,       TRUE,
                                STRINGA_MaxChars,  2 + 1,
                                STRINGA_MinVisible,2,
                            StringEnd,
                            Label("Brush: $"),
                            CHILD_WeightedWidth,   0,
                            AddSpace,
                        LayoutEnd,
                        CHILD_WeightedHeight,      0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedHeight,          0,
                    AddSpace,
                    MaximizeButton(GID_ROBIN_BU2, "Maximize Character"),
                    CHILD_WeightedHeight,          0,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,             BVS_GROUP,
                    LAYOUT_Label,                  "Map Editor",
                    LAYOUT_SpaceOuter,             TRUE,
                    LAYOUT_SpaceInner,             TRUE,
                    LAYOUT_AddChild,               gadgets[GID_ROBIN_SP1] = (struct Gadget*)
                    SpaceObject,
                        GA_ID,                     GID_ROBIN_SP1,
                        SPACE_MinWidth,            SCALEDWIDTH,
                        SPACE_MinHeight,           SCALEDHEIGHT,
                        SPACE_BevelStyle,          BVS_NONE,
                        SPACE_Transparent,         TRUE,
                    SpaceEnd,
                    CHILD_WeightedHeight,          0,
                    AddLabel(""),
                    LAYOUT_AddChild,               gadgets[GID_ROBIN_CH10] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                     GID_ROBIN_CH10,
                        GA_RelVerify,              TRUE,
                        CHOOSER_LabelArray,        &LevelOptions[game],
                        CHOOSER_Selected,          (WORD) level,
                    ChooserEnd,
                    Label("Graphics:"),
                    LAYOUT_AddChild,               gadgets[GID_ROBIN_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                     GID_ROBIN_CH1,
                        GA_RelVerify,              TRUE,
                        CHOOSER_LabelArray,        &LayerOptions,
                        CHOOSER_Selected,          (WORD) layer,
                    ChooserEnd,
                    Label("_Layer:"),
                    AddHLayout,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                 GID_ROBIN_ST1,
                            GA_ReadOnly,           TRUE,
                        StringEnd,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_SP3] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                 GID_ROBIN_SP3,
                            SPACE_MinWidth,        MAPSCALE * 2,
                            SPACE_MinHeight,       MAPSCALE * 2,
                            SPACE_BevelStyle,      BVS_NONE,
                            SPACE_Transparent,     TRUE,
                        SpaceEnd,
                        CHILD_WeightedWidth,       0,
                    LayoutEnd,
                    Label("Lower:"),
                    CHILD_WeightedHeight,          0,
                    AddHLayout,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_ST2] = (struct Gadget*)
                        StringObject,
                            GA_ID,                 GID_ROBIN_ST2,
                            GA_ReadOnly,           TRUE,
                        StringEnd,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_SP4] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                 GID_ROBIN_SP4,
                            SPACE_MinWidth,        MAPSCALE * 2,
                            SPACE_MinHeight,       MAPSCALE * 2,
                            SPACE_BevelStyle,      BVS_NONE,
                            SPACE_Transparent,     TRUE,
                        SpaceEnd,
                        CHILD_WeightedWidth,       0,
                    LayoutEnd,
                    Label("Middle:"),
                    CHILD_WeightedHeight,          0,
                    AddHLayout,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_ST3] = (struct Gadget*)
                        StringObject,
                            GA_ID,                 GID_ROBIN_ST3,
                            GA_ReadOnly,           TRUE,
                        StringEnd,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_SP5] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                 GID_ROBIN_SP5,
                            SPACE_MinWidth,        MAPSCALE * 2,
                            SPACE_MinHeight,       MAPSCALE * 2,
                            SPACE_BevelStyle,      BVS_NONE,
                            SPACE_Transparent,     TRUE,
                        SpaceEnd,
                        CHILD_WeightedWidth,       0,
                    LayoutEnd,
                    Label("Upper:"),
                    CHILD_WeightedHeight,          0,
                    AddHLayout,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_ST4] = (struct Gadget*)
                        StringObject,
                            GA_ID,                 GID_ROBIN_ST4,
                            GA_ReadOnly,           TRUE,
                        StringEnd,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_SP6] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                 GID_ROBIN_SP6,
                            SPACE_MinWidth,        MAPSCALE * 2,
                            SPACE_MinHeight,       MAPSCALE * 2,
                            SPACE_BevelStyle,      BVS_NONE,
                            SPACE_Transparent,     TRUE,
                        SpaceEnd,
                        CHILD_WeightedWidth,       0,
                    LayoutEnd,
                    Label("Barriers:"),
                    CHILD_WeightedHeight,          0,
                    AddHLayout,
                        LAYOUT_VertAlignment,      LALIGN_CENTER,
                        LAYOUT_AddChild,           gadgets[GID_ROBIN_CB1] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                 GID_ROBIN_CB1,
                            GA_RelVerify,          TRUE,
                            GA_Text,               "Draw _grid?",
                        End,
                        ClearButton(GID_ROBIN_BU1, "Clear Layer"),
                        CHILD_WeightedWidth,       0,
                    LayoutEnd,
                    CHILD_WeightedHeight,          0,
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_ROBIN_SB1);

    setup_bm(0, SCALEDWIDTH, SCALEDHEIGHT, MainWindowPtr);
    setup_bm(1, TILESWIDTH , TILESHEIGHT , MainWindowPtr);

    for (i = 0; i < 4; i++)
    {   InitRastPort(&wpa8brushrastport[i]);
        if (!(wpa8brushbitmap[i] = AllocBitMap
        (   (ULONG) MAPSCALE * 2,
            1,
            (ULONG) 1, // always 8 for Frodo! (doesn't seem to matter)
            0,
            MainWindowPtr->RPort->BitMap // NULL for Frodo! (doesn't seem to matter)
        )))
        {   rq("AllocBitMap() failed!");
        }
        wpa8brushrastport[i].BitMap = wpa8brushbitmap[i];
        for (y = 0; y < MAPSCALE * 2; y++)
        {   brushbyteptr[i][y] = &brushdisplay[i][y * ROUNDTOLONG(MAPSCALE * 2)];
    }   }

    robin_drawmap();
    writegadgets();
    lmb = FALSE;
 // ActivateLayoutGadget(gadgets[GID_ROBIN_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ROBIN_IN1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void robin_loop(ULONG gid, UNUSED ULONG code)
{   int i,
        x, y;

    switch (gid)
    {
    case GID_ROBIN_CH1:
        layer = code;
        robin_drawmap();
        updatetiles();
    acase GID_ROBIN_CH10:
        level = code;
        robin_drawmap();
        updatetiles();
    acase GID_ROBIN_CB1:
        GetAttr(GA_Selected, (Object*) gadgets[GID_ROBIN_CB1], &drawgrid);
        robin_drawmap(); // writegadgets() is not needed
    acase GID_ROBIN_BU1:
        offset = layer + ((game == ROBIN) ? 0 : 0x1880);
        for (y = 0; y < MAPHEIGHT; y++)
        {   for (x = 0; x < MAPWIDTH; x++)
            {   switch (layer)
                {
                case  0: IOBuffer[offset] = 0x00; // grass block
                acase 1: IOBuffer[offset] = 0xFF; // air
                acase 2: IOBuffer[offset] = 0xFF; // air
                acase 3: IOBuffer[offset] = 0x0F; // no barriers
                }
                offset += 4;
        }   }
        robin_drawmap();
    acase GID_ROBIN_BU2:
        for (i = 0; i < 7; i++)
        {   item[i] = 2;
        }
        strength    =  40;
        gold        = 200; // ie. 20 gp
        heroism     =
        health      =
        optimism    =
        bravery     = 255;
        writegadgets();
}   }

EXPORT FLAG robin_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if (gamesize == 31360)
        {   game = ROBIN;
        } elif (gamesize == 37632)
        {   game = ROME;
        } else
        {   DisplayBeep(NULL);
            return FALSE;
    }   }
    else
    {   return FALSE;
    }

    serializemode = SERIALIZE_READ;
    serialize();
    writegadgets();
    return TRUE;
}

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_ROBIN
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    for (i = 0; i < 6; i++)
    {   ghost(GID_ROBIN_IN1 + i, (game != ROBIN) ? TRUE : FALSE);
    }
    for (i = 0; i < 7; i++)
    {   ghost(GID_ROBIN_CH2 + i, (game != ROBIN) ? TRUE : FALSE);
    }
    ghost(    GID_ROBIN_BU2    , (game != ROBIN) ? TRUE : FALSE);

    SetGadgetAttrs
    (   gadgets[GID_ROBIN_CH10],
        MainWindowPtr, NULL,
        CHOOSER_LabelArray, &LevelOptions[game],
        CHOOSER_Selected,   level,
        GA_Disabled,        (game == ROBIN) ? TRUE               : FALSE,
    TAG_END);

    either_ch(GID_ROBIN_CH1,     (ULONG*) &layer);
    either_ch(GID_ROBIN_CH9,     (ULONG*) &game);
    either_ch(GID_ROBIN_CH10,    (ULONG*) &level);
    either_cb(GID_ROBIN_CB1,     (ULONG*) &drawgrid);

    eithergadgets();
    robin_drawmap();
    updatetiles();
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

EXPORT void robin_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  ROBIN: gamesave("Disk.2"       , "Robin Hood", saveas, 31360, FLAG_S, FALSE);
    acase ROME:  gamesave("Rome92ad.save", "Rome: AD92", saveas, 37632, FLAG_S, FALSE);
}   }

MODULE void eithergadgets(void)
{   int i;

    either_in(GID_ROBIN_IN1, (ULONG*) &health);
    either_in(GID_ROBIN_IN2, (ULONG*) &strength);
    either_in(GID_ROBIN_IN3, (ULONG*) &gold);
    either_in(GID_ROBIN_IN4, (ULONG*) &bravery);
    either_in(GID_ROBIN_IN5, (ULONG*) &optimism);
    either_in(GID_ROBIN_IN6, (ULONG*) &heroism);

    for (i = 0; i < 7; i++)
    {   either_ch(GID_ROBIN_CH2 + i, (ULONG*) &item[i]);
}   }

EXPORT void robin_close(void) { ; }

EXPORT void robin_exit(void)
{   int i;

    for (i = 0; i < 4; i++)
    {   if (wpa8brushbitmap[i])
        {   FreeBitMap(wpa8brushbitmap[i]);
            wpa8brushbitmap[i] = NULL;
}   }   }

MODULE void serialize(void)
{   int i;

    if (serializemode == SERIALIZE_READ && (game == ROBIN || level > 3))
    {   level = 0;
    }

    offset = 0x5986; if (game == ROME) offset += 0x1880; serialize1((ULONG*) &heroism);  // $5986
    offset = 0x59BF; if (game == ROME) offset += 0x1880; serialize1((ULONG*) &gold);     // $59BF
                     if (game == ROME) offset += 0x1880; serialize1((ULONG*) &health);   // $59C0
    offset = 0x59C2; if (game == ROME) offset += 0x1880; serialize1((ULONG*) &optimism); // $59C2
    offset = 0x59C6; if (game == ROME) offset += 0x1880; serialize1((ULONG*) &bravery);  // $59C6
                     if (game == ROME) offset += 0x1880; serialize1((ULONG*) &strength); // $59C7

    offset = 0x6471; if (game == ROME) offset += 0x1880; 
    for (i = 0; i < 7; i++)                              serialize1((ULONG*) &item[i]);  // $6471..$6477
}

EXPORT void robin_drawmap(void)
{   int x, y;

    for (y = 0; y < MAPHEIGHT; y++)
    {   for (x = 0; x < MAPWIDTH; x++)
        {   robin_drawmappart(x, y, FALSE);
    }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_ROBIN_SP1]->LeftEdge,
        gadgets[GID_ROBIN_SP1]->TopEdge,
        gadgets[GID_ROBIN_SP1]->LeftEdge + SCALEDWIDTH  - 1,
        gadgets[GID_ROBIN_SP1]->TopEdge  + SCALEDHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );
}

MODULE void robin_drawmappart(int x, int y, FLAG redraw)
{   UBYTE t;
    int   xx, yy;

    offset = layer + (y * 256) + (x * 4);
    if (game == ROME)
    {   offset += 0x1880;
    }
    t = IOBuffer[offset];
    if (layer == 3)
    {   drawpoint(x, y, (t & 0x80) ? RED : WHITE);
        if ((t & 6) != 6)
        {   for (xx = 0; xx < 6; xx++)
            {   *(byteptr1[(y * MAPSCALE) +  2] + (x * MAPSCALE) + xx) = pens[BLACK];
        }   }
        if ((t & 9) != 9)
        {   for (yy = 0; yy < 6; yy++)
            {   *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) +  2) = pens[BLACK];
    }   }   }
    elif (t == 0xFF)
    {   drawpoint(x, y, SKYBLUE);
    } elif (t <= 59)
    {   for (yy = 0; yy < 6; yy++)
        {   for (xx = 0; xx < 6; xx++)
            {   switch (gfx[game == ROBIN ? 0 : (level + 1)][t][yy][xx])
                {
                case  'A': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[BLACK     ];
                acase 'B': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[BROWN     ];
                acase 'C': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[SKYBLUE   ];
                acase 'D': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[DARKGREEN ];
                acase 'G': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[GREY      ];
                acase 'L': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[LIGHTGREEN];
                acase 'K': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[PINK      ];
                acase 'O': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[ORANGE    ];
                acase 'R': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[RED       ];
                acase 'U': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[BLUE      ];
                acase 'W': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[WHITE     ];
                acase 'Y': *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[YELLOW    ];
    }   }   }   }
    else
    {   drawpoint(x, y, PINK);
    }

    if (drawgrid)
    {   for (xx = 0; xx < 6; xx++)
        {   *(byteptr1[(y * MAPSCALE) +  5] + (x * MAPSCALE) + xx) =              // horizontal line
            *(byteptr1[(y * MAPSCALE) + xx] + (x * MAPSCALE) +  5) = pens[BLACK]; // vertical line
    }   }

    if (redraw)
    {   DISCARD WritePixelArray8
        (   MainWindowPtr->RPort,
            gadgets[GID_ROBIN_SP1]->LeftEdge,
            gadgets[GID_ROBIN_SP1]->TopEdge  + (y * 6),
            gadgets[GID_ROBIN_SP1]->LeftEdge + SCALEDWIDTH - 1,
            gadgets[GID_ROBIN_SP1]->TopEdge  + (y * 6) + 5,
            &display1[GFXINIT(SCALEDWIDTH, (y * 6))],
            &wpa8rastport[0]
        );
}   }

MODULE void drawpoint(int x, int y, int colour)
{   int xx, yy;

    for (yy = 0; yy < MAPSCALE; yy++)
    {   for (xx = 0; xx < MAPSCALE; xx++)
        {   *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[colour];
}   }   }

EXPORT void robin_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey)
{   int x, y;

    switch (scancode)
    {
    case SCAN_G:
        drawgrid = drawgrid ? FALSE : TRUE;
        writegadgets();
    return;
    case SCAN_L:
        if (qual & (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT))
        {   if (layer == 0)
            {   layer = 3;
            } else
            {   layer--;
        }   }
        else
        {   if (layer == 3)
            {   layer = 0;
            } else
            {   layer++;
        }   }
        writegadgets();
    return;
    }

    if (!mouseisover(GID_ROBIN_SP1, mousex, mousey))
    {   return;
    }

    x = (mousex - gadgets[GID_ROBIN_SP1]->LeftEdge) / MAPSCALE;
    y = (mousey - gadgets[GID_ROBIN_SP1]->TopEdge ) / MAPSCALE;

    offset = layer + (y * 256) + (x * 4);
    if (game == ROME)
    {   offset += 0x1880;
    }

    switch (scancode)
    {
    case SCAN_LEFT:
    case SCAN_N4:
    case SCAN_DOWN:
    case SCAN_N5:
    case SCAN_N2:
    case NM_WHEEL_DOWN:
        if (qual & (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT))
        {   IOBuffer[offset] =   0;
        } elif (layer == 3 || IOBuffer[offset] != 255)
        {   IOBuffer[offset]--; // underflow is OK
        } else
        {   IOBuffer[offset] =  59;
        }
        robin_drawmappart(x, y, TRUE);
    acase SCAN_RIGHT:
    case SCAN_N6:
    case SCAN_UP:
    case SCAN_N8:
    case NM_WHEEL_UP:
        if (qual & (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT))
        {   IOBuffer[offset] = 255;
        } elif (layer == 3 || IOBuffer[offset] !=  59)
        {   IOBuffer[offset]++; // overflow is OK
        } else
        {   IOBuffer[offset] = 255;
        }
        robin_drawmappart(x, y, TRUE);
}   }

EXPORT void robin_getpens(void)
{   lockscreen();

    pens[BLUE      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xFFFFFFFF, -1);
    pens[DARKGREEN ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x88888888, 0x00000000, -1);
    pens[YELLOW    ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, -1);
    pens[WHITE     ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1);
    pens[BLACK     ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1);
    pens[RED       ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1);
    pens[LIGHTGREEN] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xCCCCCCCC, 0x00000000, -1);
    pens[GREY      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x66666666, 0x66666666, 0x66666666, -1);
    pens[PURPLE    ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFF, -1);
    pens[DARKGREY  ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x44444444, 0x44444444, 0x44444444, -1);
    pens[ORANGE    ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x88888888, 0x00000000, -1);
    pens[SKYBLUE   ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0xFFFFFFFF, -1);
    pens[PINK      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x88888888, 0x88888888, -1);
 // pens[BROWN     ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xCCCCCCCC, 0x99999999, 0x88888888, -1); // light brown
    pens[BROWN     ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x66666666, 0x44444444, 0x00000000, -1); // dark brown

    unlockscreen();
}

EXPORT void robin_uniconify(void)
{   robin_getpens();
    robin_drawmap();
    updatetiles();
}

EXPORT void robin_tick(SWORD mousex, SWORD mousey)
{   TEXT  tempstring[60 + 1];
    UBYTE t, t2;
    int   i,
          x, xx, y, yy;

    if (mouseisover(GID_ROBIN_SP1, mousex, mousey))
    {   x = (mousex - gadgets[GID_ROBIN_SP1]->LeftEdge) / MAPSCALE;
        y = (mousey - gadgets[GID_ROBIN_SP1]->TopEdge ) / MAPSCALE;
        setpointer(TRUE, WinObject, MainWindowPtr, FALSE);
        for (i = 0; i < 4; i++)
        {   offset = (y * 256) + (x * 4) + i;
            if (game == ROME)
            {   offset += 0x1880;
            }
            t = IOBuffer[offset];
#ifdef SHOWOFFSETS
            sprintf(tempstring, "$%X: $%02X", offset, t);
#else
            sprintf(tempstring, "$%02X", t);
#endif
            if (i == 3)
            {   if   ((t & 15) == 15) strcat(tempstring, ": none");
                elif ((t &  6) ==  6) strcat(tempstring, ": vertical barrier");
                elif ((t &  9) ==  9) strcat(tempstring, ": horizontal barrier");
                else                  strcat(tempstring, ": total barrier");
            } else
            {   if (t <= 0x3B)
                {   sprintf(ENDOF(tempstring), ": %s", desc[t][game == ROBIN ? 0 : (level + 1)]);
                } elif (IOBuffer[offset] == 0xFF)
                {   strcat(tempstring, ": air");
                } else
                {   strcat(tempstring, ": ?");
            }   }
            SetGadgetAttrs
            (   gadgets[GID_ROBIN_ST1 + i],
                MainWindowPtr, NULL,
                STRINGA_TextVal, tempstring,
            TAG_END);

            if (i == 3)
            {   for (yy = 0; yy < 12; yy++)
                {   for (xx = 0; xx < 12; xx++)
                    {   *(brushbyteptr[i][yy] + xx) = pens[(t & 0x80) ? RED : WHITE];
                }   }
                if ((t & 6) != 6)
                {   for (xx = 0; xx < 12; xx++)
                    {   *(brushbyteptr[i][ 5] + xx) =
                        *(brushbyteptr[i][ 6] + xx) = pens[BLACK];
                }   }
                if ((t & 9) != 9)
                {   for (yy = 0; yy < 12; yy++)
                    {   *(brushbyteptr[i][yy] +  5) =
                        *(brushbyteptr[i][yy] +  6) = pens[BLACK];
            }   }   }
            elif (t == 0xFF)
            {   // draw air tile
                for (yy = 0; yy < MAPSCALE * 2; yy++)
                {   for (xx = 0; xx < MAPSCALE * 2; xx++)
                    {   *(brushbyteptr[i][(MAPSCALE * 2) + yy] + xx) = pens[SKYBLUE];
            }   }   }
            else
            {   for (yy = 0; yy < 6; yy++)
                {   for (xx = 0; xx < 6; xx++)
                    {   switch (gfx[game == ROBIN ? 0 : (level + 1)][t][yy][xx])
                        {
                        case  'A': t2 = (UBYTE) pens[BLACK     ];
                        acase 'B': t2 = (UBYTE) pens[BROWN     ];
                        acase 'C': t2 = (UBYTE) pens[SKYBLUE   ];
                        acase 'D': t2 = (UBYTE) pens[DARKGREEN ];
                        acase 'G': t2 = (UBYTE) pens[GREY      ];
                        acase 'L': t2 = (UBYTE) pens[LIGHTGREEN];
                        acase 'K': t2 = (UBYTE) pens[PINK      ];
                        acase 'O': t2 = (UBYTE) pens[ORANGE    ];
                        acase 'R': t2 = (UBYTE) pens[RED       ];
                        acase 'U': t2 = (UBYTE) pens[BLUE      ];
                        acase 'W': t2 = (UBYTE) pens[WHITE     ];
                        acase 'Y': t2 = (UBYTE) pens[YELLOW    ];
                        adefault:  t2 = (UBYTE) pens[PINK      ]; // should never happen
                        }

                        *(brushbyteptr[i][ yy * 2     ] + (xx * 2)    ) =
                        *(brushbyteptr[i][ yy * 2     ] + (xx * 2) + 1) =
                        *(brushbyteptr[i][(yy * 2) + 1] + (xx * 2)    ) =
                        *(brushbyteptr[i][(yy * 2) + 1] + (xx * 2) + 1) = t2;
            }   }   }

            DISCARD WritePixelArray8
            (   MainWindowPtr->RPort,
                gadgets[GID_ROBIN_SP3 + i]->LeftEdge,
                gadgets[GID_ROBIN_SP3 + i]->TopEdge,
                gadgets[GID_ROBIN_SP3 + i]->LeftEdge + (MAPSCALE * 2) - 1,
                gadgets[GID_ROBIN_SP3 + i]->TopEdge  + (MAPSCALE * 2) - 1,
                brushdisplay[i],
                &wpa8brushrastport[i]
            );
    }   }
    elif (mouseisover(GID_ROBIN_SP2, mousex, mousey))
    {   x = (mousex - gadgets[GID_ROBIN_SP2]->LeftEdge) / (MAPSCALE * 2);
        y = (mousey - gadgets[GID_ROBIN_SP2]->TopEdge ) / (MAPSCALE * 2);
        t = (y * 10) + x;
        setpointer(TRUE, WinObject, MainWindowPtr, FALSE);
        for (i = 0; i < 4; i++)
        {   if (i == (int) layer)
            {   if (x == 10 && y == 5)
                {   strcpy(tempstring, "$FF: air");
                } elif (layer == 3)
                {   if (x < 4 && y < 2)
                    {   sprintf(tempstring, "$%02X: ", stamp_to_barrier[(y * 4) + x]);
                        switch (x)
                        {
                        case  0: strcat(tempstring, "none");
                        acase 1: strcat(tempstring, "horizontal barrier");
                        acase 2: strcat(tempstring, "vertical barrier");
                        acase 3: strcat(tempstring, "total barrier");
                    }   }
                    else
                    {   strcpy(tempstring, "-");
                }   }
                else
                {   if (x == 10)
                    {   strcpy(tempstring, "-");
                    } else
                    {   sprintf(tempstring, "$%02X: %s", t, desc[t][game == ROBIN ? 0 : (level + 1)]);
            }   }   }
            else
            {   strcpy(tempstring, "-");
            }
            SetGadgetAttrs
            (   gadgets[GID_ROBIN_ST1 + i], MainWindowPtr, NULL,
                STRINGA_TextVal, tempstring,
            TAG_END); // this refreshes automatically
    }   }
    else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
        for (i = 0; i < 4; i++)
        {   SetGadgetAttrs
            (   gadgets[GID_ROBIN_ST1 + i], MainWindowPtr, NULL,
                STRINGA_TextVal, "-",
            TAG_END); // this refreshes automatically
}   }   }

EXPORT void robin_mouse(SWORD mousex, SWORD mousey)
{   int x, y;

    if
    (   !lmb
     || !mouseisover(GID_ROBIN_SP1, mousex, mousey)
    )
    {   return;
    }

    x = (mousex - gadgets[GID_ROBIN_SP1]->LeftEdge) / MAPSCALE;
    y = (mousey - gadgets[GID_ROBIN_SP1]->TopEdge ) / MAPSCALE;
    offset = (y * 256) + (x * 4) + layer;
    if (game == ROME)
    {   offset += 0x1880;
    }
    if (IOBuffer[offset] != robin_stamp[layer])
    {   IOBuffer[offset] = robin_stamp[layer];
        robin_drawmappart(x, y, TRUE);
}   }

MODULE void updatetiles(void)
{   int   x, y, xx, yy;
    UBYTE t;
    TEXT  tempstring[2 + 1];

    if (layer == 3)
    {   for (y = 0; y < 2; y++)
        {   for (x = 0; x < 4; x++)
            {   for (yy = 0; yy < MAPSCALE; yy++)
                {   for (xx = 0; xx < MAPSCALE; xx++)
                    {   switch (barriers[(y * 4) + x][yy][xx])
                        {
                        case  'A': t = (UBYTE) pens[BLACK     ];
                        acase 'R': t = (UBYTE) pens[RED       ];
                        acase 'W': t = (UBYTE) pens[WHITE     ];
                        adefault:  t = (UBYTE) pens[PINK      ]; // should never happen
                        }

                        *(byteptr2[(y * MAPSCALE * 2) + (yy * 2)    ] + (((x * MAPSCALE) + xx) * 2)    ) =
                        *(byteptr2[(y * MAPSCALE * 2) + (yy * 2)    ] + (((x * MAPSCALE) + xx) * 2) + 1) =
                        *(byteptr2[(y * MAPSCALE * 2) + (yy * 2) + 1] + (((x * MAPSCALE) + xx) * 2)    ) =
                        *(byteptr2[(y * MAPSCALE * 2) + (yy * 2) + 1] + (((x * MAPSCALE) + xx) * 2) + 1) = t;
        }   }   }   }

        // draw some unused tiles
        for (y = 0; y < 2 * MAPSCALE * 2; y++)
        {   for (x = 4 * MAPSCALE * 2; x < 11 * MAPSCALE * 2; x++)
            {   *(byteptr2[y] + x) = pens[BLACK];
        }   }

        // draw more unused tiles
        for (y = 2 * MAPSCALE * 2; y < 6 * MAPSCALE * 2; y++)
        {   for (x = 0; x < 11 * MAPSCALE * 2; x++)
            {   *(byteptr2[y] + x) = pens[BLACK];
    }   }   }
    else
    {   // draw most tiles
        for (y = 0; y < 6; y++)
        {   for (x = 0; x < 10; x++)
            {   for (yy = 0; yy < MAPSCALE; yy++)
                {   for (xx = 0; xx < MAPSCALE; xx++)
                    {   switch (gfx[game == ROBIN ? 0 : (level + 1)][(y * 10) + x][yy][xx])
                        {
                        case  'A': t = (UBYTE) pens[BLACK     ];
                        acase 'B': t = (UBYTE) pens[BROWN     ];
                        acase 'C': t = (UBYTE) pens[SKYBLUE   ];
                        acase 'D': t = (UBYTE) pens[DARKGREEN ];
                        acase 'G': t = (UBYTE) pens[GREY      ];
                        acase 'L': t = (UBYTE) pens[LIGHTGREEN];
                        acase 'K': t = (UBYTE) pens[PINK      ];
                        acase 'O': t = (UBYTE) pens[ORANGE    ];
                        acase 'R': t = (UBYTE) pens[RED       ];
                        acase 'U': t = (UBYTE) pens[BLUE      ];
                        acase 'W': t = (UBYTE) pens[WHITE     ];
                        acase 'Y': t = (UBYTE) pens[YELLOW    ];
                        adefault:  t = (UBYTE) pens[PINK      ]; // should never happen
                        }

                        *(byteptr2[(((y * MAPSCALE) + yy) * 2)    ] + (((x * MAPSCALE) + xx) * 2)    ) =
                        *(byteptr2[(((y * MAPSCALE) + yy) * 2)    ] + (((x * MAPSCALE) + xx) * 2) + 1) =
                        *(byteptr2[(((y * MAPSCALE) + yy) * 2) + 1] + (((x * MAPSCALE) + xx) * 2)    ) =
                        *(byteptr2[(((y * MAPSCALE) + yy) * 2) + 1] + (((x * MAPSCALE) + xx) * 2) + 1) = t;
        }   }   }   }

        // draw unused tiles
        for (y = 0; y < 5 * MAPSCALE * 2; y++)
        {   for (x = 0; x < MAPSCALE * 2; x++)
            {   *(byteptr2[y] + (10 * MAPSCALE * 2) + x) = pens[BLACK];
        }   }

        // draw air tile
        for (y = 0; y < MAPSCALE * 2; y++)
        {   for (x = 0; x < MAPSCALE * 2; x++)
            {   *(byteptr2[(5 * MAPSCALE * 2) + y] + (10 * MAPSCALE * 2) + x) = pens[SKYBLUE];
    }   }   }

    // highlight selected brush
    if (robin_stamp[layer] == 0xFF)
    {   xx = 10;
        yy = 5;
    } elif (layer == 3)
    {   yy = (robin_stamp[layer] & 0x80) ? 1 : 0;
        switch (robin_stamp[layer] & 0x7F)
        {
        case  0x0F: xx = 0;
        acase 0x09: xx = 1;
        acase 0x06: xx = 2;
        adefault:   xx = 3;
    }   }
    else
    {   xx = robin_stamp[layer] % 10;
        yy = robin_stamp[layer] / 10;
    }       
    for (x = 0; x < MAPSCALE * 2; x++)
    {   *(byteptr2[(yy * MAPSCALE * 2) +  x] + (xx * MAPSCALE * 2)     ) = // left
        *(byteptr2[(yy * MAPSCALE * 2) +  x] + (xx * MAPSCALE * 2) + 11) = // right
        *(byteptr2[(yy * MAPSCALE * 2)     ] + (xx * MAPSCALE * 2) +  x) = // top
        *(byteptr2[(yy * MAPSCALE * 2) + 11] + (xx * MAPSCALE * 2) +  x) = // bottom
        pens[BLACK];
    }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_ROBIN_SP2]->LeftEdge,
        gadgets[GID_ROBIN_SP2]->TopEdge,
        gadgets[GID_ROBIN_SP2]->LeftEdge + TILESWIDTH  - 1,
        gadgets[GID_ROBIN_SP2]->TopEdge  + TILESHEIGHT - 1,
        display2,
        &wpa8rastport[1]
    );

    sprintf(tempstring, "%02X", robin_stamp[layer]);
    SetGadgetAttrs
    (   gadgets[GID_ROBIN_ST5], MainWindowPtr, NULL,
        STRINGA_TextVal, tempstring,
    TAG_END); // this refreshes automatically
}

EXPORT void robin_lmb(SWORD mousex, SWORD mousey, UWORD code)
{   int x, y;

    if (code == SELECTUP)
    {   lmb = FALSE;
    } elif (code == SELECTDOWN)
    {   lmb = TRUE;

        if (mouseisover(GID_ROBIN_SP1, mousex, mousey))
        {   x = ((mousex - gadgets[GID_ROBIN_SP1]->LeftEdge) / MAPSCALE);
            y = ((mousey - gadgets[GID_ROBIN_SP1]->TopEdge ) / MAPSCALE);
            offset = (y * 256) + (x * 4) + layer;
            if (game == ROME)
            {   offset += 0x1880;
            }
            if (IOBuffer[offset] != robin_stamp[layer])
            {   IOBuffer[offset] = robin_stamp[layer];
                robin_drawmappart(x, y, TRUE);
        }   }
        elif (mouseisover(GID_ROBIN_SP2, mousex, mousey))
        {   x = ((mousex - gadgets[GID_ROBIN_SP2]->LeftEdge) / (MAPSCALE * 2));
            y = ((mousey - gadgets[GID_ROBIN_SP2]->TopEdge ) / (MAPSCALE * 2));
            if (x == 10)
            {   if (layer != 3 && y == 5)
                {   robin_stamp[layer] = 0xFF;
            }   }
            elif (layer == 3)
            {   if (x < 4 && y < 2)
                {   robin_stamp[layer] = stamp_to_barrier[(y * 4) + x];
            }   }
            else
            {   robin_stamp[layer] = (y * 10) + x;
            }
            updatetiles();
}   }   }

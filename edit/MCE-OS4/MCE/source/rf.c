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

// main window
#define GID_RF_LY1    0 // root layout
#define GID_RF_SB1    1 // toolbar
#define GID_RF_ST1    2 //  1st name
#define GID_RF_ST10  11 // 10th name
#define GID_RF_ST11  12 // contents
#define GID_RF_IN1   13 //  1st score
#define GID_RF_IN10  22 // 10th score
#define GID_RF_IN11  23 // level
#define GID_RF_SL1   24 // level
#define GID_RF_BU1   25 // clear high scores
#define GID_RF_BU2   26 // clear level
#define GID_RF_BU3   27 // edit graphics
#define GID_RF_CH1   28 // file type
#define GID_RF_CH2   29 // world
#define GID_RF_SP1   30 // map
#define GID_RF_SP2   31 // tiles
#define GID_RF_BU6   32 // edit title screen
#define GID_RF_BU7   33 // copy level
#define GID_RF_BU8   34 // paste level

// graphics editor
#define GID_RF_SK1   35 // editor
#define GID_RF_PL1   36 // colour
#define GID_RF_SB2   37 // command bar
#define GID_RF_SB3   38 // paint bar
#define GID_RF_BU4   39 // OK
#define GID_RF_BU5   40 // cancel

#define GIDS_RF      GID_RF_BU5

#define MAPWIDTH     40
#define MAPHEIGHT    22
#define MAPSCALE     16
#define SCALEDWIDTH  (MAPWIDTH  * MAPSCALE)
#define SCALEDHEIGHT (MAPHEIGHT * MAPSCALE)
#define COLOURS      32
#define TILESWIDTH   28
#define TILESHEIGHT   6

#define BLACK         0
#define WHITE        31

#define FILETYPE_HISCORES  0
#define FILETYPE_LEVEL     1

#define NameGad(x)  LAYOUT_AddChild, gadgets[GID_RF_ST1 + x] = (struct Gadget*) StringObject,  GA_ID, GID_RF_ST1 + x, GA_TabCycle, TRUE, STRINGA_TextVal, name[x], STRINGA_MaxChars, 10 + 1, STRINGA_MinVisible, 10 + stringextra, STRINGA_ReplaceMode, TRUE, StringEnd
#define ScoreGad(x) LAYOUT_AddChild, gadgets[GID_RF_IN1 + x] = (struct Gadget*) IntegerObject, GA_ID, GID_RF_IN1 + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 999999, INTEGER_MinVisible, 6 + 1, IntegerEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void sortscores(void);
MODULE void clearscores(void);
MODULE void updatetiles(void);
MODULE void stampit(SWORD mousex, SWORD mousey);
MODULE void rf_drawmappart(int x, int y);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(None)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT FLAG                 titlemode;
IMPORT int                  bu3, bu4, pl1, sb2, sb3, sk1,
                            function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra,
                            tilewidth,
                            tileheight;
IMPORT LONG                 gamesize,
                            pens[PENS];
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                currenttool,
                            fgpen_intable,
                            fgpen_real,
                            offset,
                            rf_world,
                            showtoolbar;
IMPORT UBYTE                convert[256],
                            convert2[256],
                            IOBuffer[IOBUFFERSIZE],
                            ScrnData[64000],
                            stamp,
                            TileData[5][200][320],
                            tileplanes[256];
IMPORT __aligned UBYTE      scrndisplay[GFXINIT(320, 200)];
IMPORT UBYTE*               scrnbyteptr[200];
IMPORT struct Hook          ToolHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;
IMPORT struct RastPort      sketchrastport,
                            wpa8rastport[2],
                            wpa8tilerastport;
IMPORT UBYTE               *byteptr1[DISPLAY1HEIGHT],
                           *byteptr2[DISPLAY2HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE],
                            display2[DISPLAY2SIZE];
IMPORT struct Library*      SketchBoardBase; // needed for MOS

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE FLAG                 gotallpens      = FALSE,
                            gotclip         = FALSE,
                            gotpen[32],
                            gottitle,
                            lev             = FALSE,
                            lmb;
MODULE TEXT                 Gfx_Pathname[MAX_PATH + 1],
                            name[10][10 + 1];
MODULE UBYTE                ClipBuffer[MAPHEIGHT][MAPWIDTH];
MODULE ULONG                filetype,
                            level           = 0,
                            score[10];

MODULE const STRPTR
FiletypeOptions[2 + 1] =
{ "High score table",
  "Levels",
  NULL
}, WorldOptions[5 + 1] =
{ "Hunter",
  "Cook",
  "Cowboy",
  "Spaceman",
  "Doctor",
  NULL
}, mapname[5] =
{ "hunt",
  "cook",
  "cowb",
  "astr",
  "doct",
};

MODULE const UBYTE black[5] = { 24, 13, 24, 26, 20 };

MODULE const struct
{   UBYTE to_file;
    FLAG  recommended;
    SWORD x, y;
} tilepos[168] = {
{    0, TRUE ,   4,   6 }, //   0 -> $00 empty
{    1, TRUE ,  36,   6 }, //   1 -> $01 grass
{    2, TRUE ,  68,   6 }, //   2 -> $02 elephant wall
{    3, TRUE , 132,   6 }, //   3 -> $03 flamingo wall #1
{    4, TRUE , 132,   6 }, //   4 -> $04 flamingo wall #1
{    5, FALSE, 164,   6 }, //   5 -> $05 flamingo wall #2
{    6, FALSE, 196,   6 }, //   6 -> $06 flamingo wall #3
{    7, FALSE, 228,   6 }, //   7 -> $07 flamingo wall #4
{    8, TRUE , 132,   6 }, //   8 -> $08 flamingo wall #1
{    9, FALSE,  20,   6 }, //   9 -> $09 3D thing
{ 0x0A, FALSE,  20,   6 }, //  10 -> $0A 3D thing
{ 0x0B, FALSE,  20,   6 }, //  11 -> $0B 3D thing
{ 0x0C, TRUE ,  68,  30 }, //  12 -> $0C blue dirt #1
{ 0x0D, FALSE, 100,  30 }, //  13 -> $0D blue dirt #2
{ 0x0E, FALSE, 132,  30 }, //  14 -> $0E blue dirt #3
{ 0x0F, FALSE, 164,  30 }, //  15 -> $0F blue dirt #4
{ 0x10, TRUE , 192,  26 }, //  16 -> $10 brown dirt #1
{ 0x11, FALSE, 224,  26 }, //  17 -> $11 brown dirt #2
{ 0x12, FALSE, 256,  26 }, //  18 -> $12 brown dirt #3
{ 0x13, FALSE, 288,  26 }, //  19 -> $13 brown dirt #4
// $14..$1F
{ 0x20, TRUE ,   0,  50 }, //  20 -> $20 you
// $21..$27
{ 0x28, TRUE ,   0,  66 }, //  21 -> $28 boulder
// $29..$2B
{ 0x2C, TRUE ,   0,  66 }, //  22 -> $2C boulder
{ 0x2D, FALSE,  16,  66 }, //  23 -> $2D boulder
{ 0x2E, TRUE ,  32,  66 }, //  24 -> $2E boulder
{ 0x2F, FALSE,  48,  66 }, //  25 -> $2F boulder
{ 0x30, TRUE ,  64,  66 }, //  26 -> $30 bat #1
{ 0x31, FALSE,  96,  66 }, //  27 -> $31 bat #3
{ 0x32, FALSE, 128,  66 }, //  28 -> $32 bat #5
{ 0x33, FALSE, 160,  66 }, //  29 -> $33 bat #7
{ 0x34, TRUE , 240,  66 }, //  30 -> $34 monkey #4
{ 0x35, TRUE , 224,  66 }, //  31 -> $35 monkey #3
{ 0x36, TRUE , 208,  66 }, //  32 -> $36 monkey #2
{ 0x37, TRUE , 192,  66 }, //  33 -> $37 monkey #1
{ 0x38, TRUE , 256,  66 }, //  34 -> $38 gold tap #1
{ 0x39, FALSE, 272,  66 }, //  35 -> $39 gold tap #2
{ 0x3A, FALSE, 288,  66 }, //  36 -> $3A gold tap #3
{ 0x3B, FALSE, 304,  66 }, //  37 -> $3B gold tap #4
{ 0x3C, FALSE, 224,  66 }, //  38 -> $3C monkey #3
{ 0x3D, FALSE, 208,  66 }, //  39 -> $3D monkey #2
{ 0x3E, FALSE, 192,  66 }, //  40 -> $3E monkey #1
{ 0x3F, FALSE, 240,  66 }, //  41 -> $3F monkey #4
{ 0x40, FALSE, 256, 146 }, //  42 -> $40 bat-coin #1
{ 0x41, FALSE, 272, 146 }, //  43 -> $41 bat-coin #2
{ 0x42, FALSE, 288, 146 }, //  44 -> $42 bat-coin #3
{ 0x43, FALSE, 304, 146 }, //  45 -> $43 bat-coin #4
{ 0x44, FALSE, 192, 162 }, //  46 -> $44 boulder-monkey #1
{ 0x45, FALSE, 208, 162 }, //  47 -> $45 boulder-monkey #2
{ 0x46, FALSE, 224, 162 }, //  48 -> $46 boulder-monkey #3
{ 0x47, FALSE, 240, 162 }, //  49 -> $47 boulder-monkey #4
{ 0x48, FALSE, 192, 146 }, //  50 -> $48 explosion #1
{ 0x49, FALSE, 208, 146 }, //  51 -> $49 explosion #2
{ 0x4A, FALSE, 224, 146 }, //  52 -> $4A explosion #3
{ 0x4B, FALSE, 240, 146 }, //  53 -> $4B explosion #4
{ 0x4C, FALSE, 224, 146 }, //  54 -> $4C explosion #3
{ 0x4D, FALSE, 240, 146 }, //  55 -> $4D explosion #4
{ 0x4E, FALSE, 288, 146 }, //  56 -> $4E bat-coin #3
{ 0x4F, FALSE, 304, 146 }, //  57 -> $4F bat-coin #4
{ 0x50, FALSE, 224, 178 }, //  58 -> $50 coin-boulder #3
{ 0x51, FALSE, 240, 178 }, //  59 -> $51 coin-boulder #4
// $52..$53
{ 0x54, FALSE, 304, 146 }, //  60 -> $54 bat-coin #4
{ 0x55, FALSE, 288, 146 }, //  61 -> $55 bat-coin #3
{ 0x56, FALSE, 272, 146 }, //  62 -> $56 bat-coin #2
{ 0x57, FALSE, 256, 146 }, //  63 -> $57 bat-coin #1
// $58..$5F
{ 0x60, FALSE,   0, 114 }, //  64 -> $60 droplet #1
{ 0x61, FALSE,  16, 114 }, //  65 -> $61 droplet #2
{ 0x62, FALSE,  64, 114 }, //  66 -> $62 droplet #5
{ 0x63, FALSE,  80, 114 }, //  67 -> $63 droplet #6
{ 0x64, FALSE,  96, 114 }, //  68 -> $64 droplet #7
{ 0x65, FALSE, 112, 114 }, //  69 -> $65 droplet #8
{ 0x66, FALSE,  32, 114 }, //  70 -> $66 droplet #3
{ 0x67, FALSE,  48, 114 }, //  71 -> $67 droplet #4
{ 0x68, FALSE, 128, 114 }, //  72 -> $68 flame #1
{ 0x69, FALSE, 144, 114 }, //  73 -> $69 flame #2
{ 0x6A, FALSE, 160, 114 }, //  74 -> $6A flame #3
{ 0x6B, FALSE, 176, 114 }, //  75 -> $6B flame #4
{ 0x6C, FALSE, 160, 114 }, //  76 -> $6C flame #3
{ 0x6D, FALSE, 176, 114 }, //  77 -> $6D flame #4
// $6E..$6F
{ 0x70, TRUE , 192, 130 }, //  78 -> $70 green circle #1
{ 0x71, FALSE, 208, 130 }, //  79 -> $71 green circle #2
{ 0x72, FALSE, 224, 130 }, //  80 -> $72 green circle #3
{ 0x73, FALSE, 240, 130 }, //  81 -> $73 green circle #4
{ 0x74, TRUE , 192, 114 }, //  82 -> $74 exit #1
{ 0x75, FALSE, 208, 114 }, //  83 -> $75 exit #2
{ 0x76, FALSE, 224, 114 }, //  84 -> $76 exit #3
{ 0x77, FALSE, 240, 114 }, //  85 -> $77 exit #4
{ 0x78, TRUE ,   0, 130 }, //  86 -> $78 '0'
{ 0x79, FALSE,  16, 130 }, //  87 -> $79 '1'
{ 0x7A, FALSE,  32, 130 }, //  88 -> $7A '2'
{ 0x7B, FALSE,  48, 130 }, //  89 -> $7B '3'
{ 0x7C, TRUE ,  64, 130 }, //  90 -> $7C clock #1
{ 0x7D, FALSE,  80, 130 }, //  91 -> $7D clock #2
{ 0x7E, FALSE,  96, 130 }, //  92 -> $7E clock #3
{ 0x7F, FALSE, 112, 130 }, //  93 -> $7F clock #4
{ 0x80, FALSE, 128, 130 }, //  94 -> $80 thing #1
{ 0x81, FALSE, 144, 130 }, //  95 -> $81 thing #2
{ 0x82, FALSE, 160, 130 }, //  96 -> $82 thing #3
{ 0x83, FALSE, 176, 130 }, //  97 -> $83 thing #4
{ 0x84, TRUE , 256, 114 }, //  98 -> $84 yellow circle #1
{ 0x85, FALSE, 272, 114 }, //  99 -> $85 yellow circle #2
{ 0x86, FALSE, 288, 114 }, // 100 -> $86 yellow circle #3
{ 0x87, FALSE, 304, 114 }, // 101 -> $87 yellow circle #4
{ 0x88, TRUE , 256, 130 }, // 102 -> $88 coin
// $89..$8B
{ 0x8C, FALSE, 256, 130 }, // 103 -> $8C coin
// $8D..$8F
{ 0x90, FALSE,   0,  82 }, // 104 -> $90 yellow snake #1
{ 0x91, FALSE,  16,  82 }, // 105 -> $91 yellow snake #2
{ 0x92, FALSE,  32,  82 }, // 106 -> $92 yellow snake #3
{ 0x93, FALSE,  48,  82 }, // 107 -> $93 yellow snake #4
{ 0x94, FALSE,  64,  82 }, // 108 -> $94 yellow snake #5
{ 0x95, FALSE,  80,  82 }, // 109 -> $95 yellow snake #6
{ 0x96, FALSE,  96,  82 }, // 110 -> $96 yellow snake #7
{ 0x97, FALSE, 112,  82 }, // 111 -> $97 yellow snake #8
{ 0x98, FALSE, 256,  82 }, // 112 -> $98 yellow snake #17
{ 0x99, FALSE, 272,  82 }, // 113 -> $99 yellow snake #18
{ 0x9A, FALSE, 288,  82 }, // 114 -> $9A yellow snake #19
{ 0x9B, FALSE, 304,  82 }, // 115 -> $9B yellow snake #20
{ 0x9C, FALSE, 256,  82 }, // 116 -> $9C yellow snake #17
{ 0x9D, FALSE, 272,  82 }, // 117 -> $9D yellow snake #18
{ 0x9E, FALSE, 288,  82 }, // 118 -> $9E yellow snake #19
{ 0x9F, FALSE, 304,  82 }, // 119 -> $9F yellow snake #20
{ 0xA0, FALSE, 128,  82 }, // 120 -> $A0 yellow snake #9
{ 0xA1, FALSE, 144,  82 }, // 121 -> $A1 yellow snake #10
{ 0xA2, FALSE, 160,  82 }, // 122 -> $A2 yellow snake #11
{ 0xA3, FALSE, 176,  82 }, // 123 -> $A3 yellow snake #12
{ 0xA4, FALSE, 192,  82 }, // 124 -> $A4 yellow snake #13
{ 0xA5, FALSE, 208,  82 }, // 125 -> $A5 yellow snake #14
{ 0xA6, FALSE, 224,  82 }, // 126 -> $A6 yellow snake #15
{ 0xA7, FALSE, 240,  82 }, // 127 -> $A7 yellow snake #16
// $A8..$AF
{ 0xB0, FALSE,  80,  66 }, // 128 -> $B0 bat #2
{ 0xB1, FALSE,  96,  66 }, // 129 -> $B1 bat #4
{ 0xB2, FALSE, 112,  66 }, // 130 -> $B2 bat #6
{ 0xB3, FALSE, 128,  66 }, // 131 -> $B3 bat #8
{ 0xB4, FALSE, 208,  66 }, // 132 -> $B4 monkey #2
{ 0xB5, FALSE, 192,  66 }, // 133 -> $B5 monkey #1
{ 0xB6, FALSE, 240,  66 }, // 134 -> $B6 monkey #4
{ 0xB7, FALSE, 224,  66 }, // 135 -> $B7 monkey #3
// $B8..$BB
{ 0xBC, FALSE, 192,  66 }, // 136 -> $BC monkey #1
{ 0xBD, FALSE, 240,  66 }, // 137 -> $BD monkey #4
{ 0xBE, FALSE, 224,  66 }, // 138 -> $BE monkey #3
{ 0xBF, FALSE, 208,  66 }, // 139 -> $BF monkey #2
// $C0..$C3
{ 0xC4, TRUE , 256, 178 }, // 140 -> $C4 blue tap #1
{ 0xC5, FALSE, 272, 178 }, // 141 -> $C5 blue tap #2
{ 0xC6, FALSE, 288, 178 }, // 142 -> $C6 blue tap #3
{ 0xC7, FALSE, 304, 178 }, // 143 -> $C7 blue tap #4
// $C8..$CF
{ 0xD0, FALSE,   0,  98 }, // 144 -> $D0 green snake #1
{ 0xD1, FALSE,  16,  98 }, // 145 -> $D1 green snake #2
{ 0xD2, FALSE,  32,  98 }, // 146 -> $D2 green snake #3
{ 0xD3, FALSE,  48,  98 }, // 147 -> $D3 green snake #4
{ 0xD4, FALSE,  64,  98 }, // 148 -> $D4 green snake #5
{ 0xD5, FALSE,  80,  98 }, // 149 -> $D5 green snake #6
{ 0xD6, FALSE,  96,  98 }, // 150 -> $D6 green snake #7
{ 0xD7, FALSE, 112,  98 }, // 151 -> $D7 green snake #8
{ 0xD8, FALSE, 256,  98 }, // 152 -> $D8 green snake #17
{ 0xD9, FALSE, 272,  98 }, // 153 -> $D9 green snake #18
{ 0xDA, FALSE, 288,  98 }, // 154 -> $DA green snake #19
{ 0xDB, FALSE, 304,  98 }, // 155 -> $DB green snake #20
{ 0xDC, FALSE, 256,  98 }, // 156 -> $DC green snake #17
{ 0xDD, FALSE, 272,  98 }, // 157 -> $DD green snake #18
{ 0xDE, FALSE, 288,  98 }, // 158 -> $DE green snake #19
{ 0xDF, FALSE, 304,  98 }, // 159 -> $DF green snake #20
{ 0xE0, FALSE, 128,  98 }, // 160 -> $E0 green snake #9
{ 0xE1, FALSE, 144,  98 }, // 161 -> $E1 green snake #10
{ 0xE2, FALSE, 160,  98 }, // 162 -> $E2 green snake #11
{ 0xE3, FALSE, 176,  98 }, // 163 -> $E3 green snake #12
{ 0xE4, FALSE, 192,  98 }, // 164 -> $E4 green snake #13
{ 0xE5, FALSE, 208,  98 }, // 165 -> $E5 green snake #14
{ 0xE6, FALSE, 224,  98 }, // 166 -> $E6 green snake #15
{ 0xE7, FALSE, 240,  98 }, // 167 -> $E7 green snake #16
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void rf_main(void)
{   int i;

    tool_open      = rf_open;
    tool_loop      = rf_loop;
    tool_save      = rf_save;
    tool_close     = rf_close;
    tool_exit      = rf_exit;
    tool_subgadget = sketchboard_subgadget;

    if (loaded != FUNC_ROCKFORD)
    {   stamp = 0;
        if (!rf_open(TRUE))
        {   function = page = FUNC_MENU;
            return;
        } // implied else
        loaded = FUNC_ROCKFORD;
    }

    bu3        = GID_RF_BU4;
    bu4        = GID_RF_BU5;
    pl1        = GID_RF_PL1;
    sb2        = GID_RF_SB2;
    sb3        = GID_RF_SB3;
    sk1        = GID_RF_SK1;
    tilewidth  =
    tileheight = 16;
    for (i = 0; i < 168; i++)
    {   tileplanes[i] = 5;
    }

    make_speedbar_list(GID_RF_SB1);
    load_aiss_images( 9,  9);
    load_aiss_images(18, 18);
    load_aiss_images(45, 45);
    load_aiss_images(47, 47);

    rf_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                                       WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                    gadgets[GID_RF_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                 TRUE,
            AddHLayout,
                AddToolbar(GID_RF_SB1),
                AddSpace,
                CHILD_WeightedWidth,                           50,
                AddVLayout,
                    LAYOUT_VertAlignment,                      LALIGN_CENTER,
                    LAYOUT_AddChild,                           gadgets[GID_RF_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_RF_CH1,
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
            AddHLayout,
                LAYOUT_BevelStyle,                             BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_Label,                                  "High Score Table",
                AddVLayout,
                    LABEL_Justification,                       LJ_CENTRE,
                    AddLabel("#1:"),
                    AddLabel("#2:"),
                    AddLabel("#3:"),
                    AddLabel("#4:"),
                    AddLabel("#5:"),
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
                AddVLayout,
                    NameGad(0),
                    NameGad(1),
                    NameGad(2),
                    NameGad(3),
                    NameGad(4),
                LayoutEnd,
                AddVLayout,
                    ScoreGad(0),
                    ScoreGad(1),
                    ScoreGad(2),
                    ScoreGad(3),
                    ScoreGad(4),
                LayoutEnd,
                AddLabel("  "),
                CHILD_WeightedWidth,                           0,
                AddVLayout,
                    LABEL_Justification,                       LJ_CENTRE,
                    AddLabel("#6:"),
                    AddLabel("#7:"),
                    AddLabel("#8:"),
                    AddLabel("#9:"),
                    AddLabel("#10:"),
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
                AddVLayout,
                    NameGad(5),
                    NameGad(6),
                    NameGad(7),
                    NameGad(8),
                    NameGad(9),
                LayoutEnd,
                AddVLayout,
                    ScoreGad(5),
                    ScoreGad(6),
                    ScoreGad(7),
                    ScoreGad(8),
                    ScoreGad(9),
                LayoutEnd,
                AddLabel("  "),
                CHILD_WeightedWidth,                           0,
                LAYOUT_AddChild,                               gadgets[GID_RF_BU1] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                     GID_RF_BU1,
                    GA_RelVerify,                              TRUE,
                    GA_Image,
                    LabelObject,
                        LABEL_Image,                           aissimage[9],
                        CHILD_NoDispose,                       TRUE,
                        LABEL_DrawInfo,                        DrawInfoPtr,
                        LABEL_VerticalAlignment,               LVALIGN_BASELINE,
                        LABEL_Justification,                   LJ_CENTRE,
                        LABEL_Text,                            "\nClear\nHigh\nScores",
                    LabelEnd,
                ButtonEnd,
                CHILD_WeightedWidth,                           0,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddLabel(""),
            CHILD_WeightedHeight,                              0,
            AddVLayout,
                LAYOUT_Label,                                  "Map Editor",
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_BevelStyle,                             BVS_SBAR_VERT,
                AddHLayout,
                    LAYOUT_VertAlignment,                      LALIGN_CENTER,
                    LAYOUT_AddChild,                           gadgets[GID_RF_CH2] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_RF_CH2,
                        GA_RelVerify,                          TRUE,
                        CHOOSER_LabelArray,                    &WorldOptions,
                    ChooserEnd,
                    CHILD_WeightedWidth,                       0,
                    Label("World:"),
                    LAYOUT_AddChild,                           gadgets[GID_RF_IN11] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_RF_IN11,
                        GA_TabCycle,                           TRUE,
                        GA_RelVerify,                          TRUE,
                        INTEGER_Minimum,                       1,
                        INTEGER_Maximum,                       8,
                        INTEGER_MinVisible,                    1 + 1,
                    IntegerEnd,
                    CHILD_WeightedWidth,                       0,
                    Label("Level:"),
                    LAYOUT_AddChild,                           gadgets[GID_RF_SL1] = (struct Gadget*)
                    SliderObject,
                        GA_ID,                                 GID_RF_SL1,
                        GA_RelVerify,                          TRUE,
                        SLIDER_Min,                            1,
                        SLIDER_Max,                            8,
                        SLIDER_KnobDelta,                      1,
                        SLIDER_Orientation,                    SLIDER_HORIZONTAL,
                        SLIDER_Ticks,                          8, // how many ticks to display
                    SliderEnd,
                    AddLabel("of 8"),
                    LAYOUT_AddChild,                           gadgets[GID_RF_BU7] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                                 GID_RF_BU7,
                        GA_RelVerify,                          TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_Image,                       aissimage[45], // seems OK to share with the sketchboard one
                            CHILD_NoDispose,                   TRUE,
                            LABEL_DrawInfo,                    DrawInfoPtr,
                            LABEL_VerticalAlignment,           LVALIGN_BASELINE,
                            LABEL_Justification,               LJ_CENTRE,
                            LABEL_Text,                        " Copy ",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                           gadgets[GID_RF_BU8] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                                 GID_RF_BU8,
                        GA_RelVerify,                          TRUE,
                        GA_Image,
                        LabelObject,
                            LABEL_Image,                       aissimage[47], // seems OK to share with the sketchboard one
                            CHILD_NoDispose,                   TRUE,
                            LABEL_DrawInfo,                    DrawInfoPtr,
                            LABEL_VerticalAlignment,           LVALIGN_BASELINE,
                            LABEL_Justification,               LJ_CENTRE,
                            LABEL_Text,                        " Paste ",
                        LabelEnd,
                    ButtonEnd,
                    LAYOUT_AddChild,                           gadgets[GID_RF_ST11] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_RF_ST11,
                        GA_ReadOnly,                           TRUE,
                        STRINGA_TextVal,                       "-",
                        STRINGA_MinVisible,                    3 + 1,
                    StringEnd,
                    CHILD_WeightedWidth,                       0,
                    Label("Contents:"),
                LayoutEnd,
                CHILD_WeightedHeight,                          0,
                AddHLayout,
                    AddSpace,
                    LAYOUT_AddChild,                           gadgets[GID_RF_SP1] = (struct Gadget*)
                    SpaceObject,
                        GA_ID,                                 GID_RF_SP1,
                        SPACE_MinWidth,                        SCALEDWIDTH,
                        SPACE_MinHeight,                       SCALEDHEIGHT,
                        SPACE_BevelStyle,                      BVS_NONE,
                        SPACE_Transparent,                     TRUE,
                    SpaceEnd,
                    CHILD_WeightedWidth,                       0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedHeight,                          0,
            LayoutEnd,
            AddHLayout,
                AddHLayout,
                    LAYOUT_Label,                              "Tiles",
                    LAYOUT_SpaceOuter,                         TRUE,
                    LAYOUT_BevelStyle,                         BVS_GROUP,
                    LAYOUT_AddChild,                           gadgets[GID_RF_SP2] = (struct Gadget*)
                    SpaceObject,
                        GA_ID,                                 GID_RF_SP2,
                        SPACE_MinWidth,                        TILESWIDTH  * 16,
                        SPACE_MinHeight,                       TILESHEIGHT * 16,
                        SPACE_BevelStyle,                      BVS_NONE,
                        SPACE_Transparent,                     TRUE,
                    SpaceEnd,
                    CHILD_WeightedWidth,                       0,
                    LAYOUT_AddChild,                           gadgets[GID_RF_BU3] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                                 GID_RF_BU3,
                        GA_RelVerify,                          TRUE,
                        GA_Disabled,                           (SketchBoardBase ? FALSE : TRUE),
                        GA_Image,
                        LabelObject,
                            LABEL_Image,                       aissimage[18],
                            CHILD_NoDispose,                   TRUE,
                            LABEL_DrawInfo,                    DrawInfoPtr,
                            LABEL_VerticalAlignment,           LVALIGN_BASELINE,
                            LABEL_Justification,               LJ_CENTRE,
                            LABEL_Text,                        "\nEdit\nTile\n_Graphics...",
                        LabelEnd,
                    ButtonEnd,
                LayoutEnd,
                LAYOUT_AddChild,                               gadgets[GID_RF_BU6] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                     GID_RF_BU6,
                    GA_RelVerify,                              TRUE,
                    GA_Disabled,                               (SketchBoardBase ? FALSE : TRUE),
                    GA_Image,
                    LabelObject,
                        LABEL_Image,                           aissimage[18],
                        CHILD_NoDispose,                       TRUE,
                        LABEL_DrawInfo,                        DrawInfoPtr,
                        LABEL_VerticalAlignment,               LVALIGN_BASELINE,
                        LABEL_Justification,                   LJ_CENTRE,
                        LABEL_Text,                            "\nEdit\nTitle\n_Screen...",
                    LabelEnd,
                ButtonEnd,
                LAYOUT_AddChild,                               gadgets[GID_RF_BU2] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                     GID_RF_BU2,
                    GA_RelVerify,                              TRUE,
                    GA_Image,
                    LabelObject,
                        LABEL_Image,                           aissimage[9],
                        CHILD_NoDispose,                       TRUE,
                        LABEL_DrawInfo,                        DrawInfoPtr,
                        LABEL_VerticalAlignment,               LVALIGN_BASELINE,
                        LABEL_Justification,                   LJ_CENTRE,
                        LABEL_Text,                            "\nClear\nLevel",
                    LabelEnd,
                ButtonEnd,
                CHILD_WeightedWidth,                           0,
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_RF_SB1);

    setup_bm(0, SCALEDWIDTH    , SCALEDHEIGHT    , MainWindowPtr);
    setup_bm(1, TILESWIDTH * 16, TILESHEIGHT * 16, MainWindowPtr);

    writegadgets();
    lmb = FALSE;
    if (filetype == FILETYPE_HISCORES)
    {   DISCARD ActivateLayoutGadget(gadgets[GID_RF_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_RF_ST1]);
    }

    loop();
    readgadgets();
    closewindow();
}

EXPORT void rf_loop(ULONG gid, UNUSED ULONG code)
{   int x, y;

    switch (gid)
    {
    case GID_RF_BU1:
        clearscores();
        writegadgets();
    acase GID_RF_BU2:
        for (x = 0; x < 40; x++)
        {   IOBuffer[(rf_world * 7040) + (level * 880) +                    x] =
            IOBuffer[(rf_world * 7040) + (level * 880) + (21 * MAPWIDTH) +  x] = 0x02; // magic wall
        }
        for (y = 1; y < 21; y++)
        {   IOBuffer[    (rf_world * 7040) + (level * 880) + (y * MAPWIDTH)     ] = 0x02; // magic wall
            for (x = 1; x <= 38; x++)
            {   IOBuffer[(rf_world * 7040) + (level * 880) + (y * MAPWIDTH) + x ] =    0; // empty
            }
            IOBuffer[    (rf_world * 7040) + (level * 880) + (y * MAPWIDTH) + 39] = 0x02; // magic wall
        }
        rf_drawmap(FALSE);
    acase GID_RF_BU3:
        gfxwindow();
    acase GID_RF_BU6:
        titlemode = TRUE;
        gfxwindow();
        titlemode = FALSE;
    acase GID_RF_BU7:
        for (y = 0; y < MAPHEIGHT; y++) // 22
        {   for (x = 0; x < MAPWIDTH; x++) // 40
            {   ClipBuffer[y][x] = IOBuffer[(rf_world * 7040) + (level * 880) + (y * MAPWIDTH) + x];
        }   }
        gotclip = TRUE;
        writegadgets();
    acase GID_RF_BU8:
        // assert(gotclip);
        for (y = 0; y < MAPHEIGHT; y++) // 22
        {   for (x = 0; x < MAPWIDTH; x++) // 40
            {   IOBuffer[(rf_world * 7040) + (level * 880) + (y * MAPWIDTH) + x] = ClipBuffer[y][x];
        }   }
        rf_drawmap(FALSE);
    acase GID_RF_CH2:
        gadmode = SERIALIZE_READ;
        either_ch(GID_RF_CH2, &rf_world);
        rf_freepens();
        rf_getpens();
        rf_drawmap(FALSE);
    acase GID_RF_SL1:
        gadmode = SERIALIZE_READ;
        either_sl(GID_RF_SL1, &level);
        level--;
        DISCARD SetGadgetAttrs
        (   gadgets[GID_RF_IN11], MainWindowPtr, NULL,
            INTEGER_Number, level + 1,
        TAG_DONE); // this autorefreshes
        rf_drawmap(FALSE);
    acase GID_RF_IN11:
        gadmode = SERIALIZE_READ;
        either_in(GID_RF_IN11, &level);
        level--;
        DISCARD SetGadgetAttrs
        (   gadgets[GID_RF_SL1], MainWindowPtr, NULL,
            SLIDER_Level, level + 1,
        TAG_DONE); // this autorefreshes
        rf_drawmap(FALSE);
}   }

EXPORT FLAG rf_open(FLAG loadas)
{   TRANSIENT BPTR   FileHandle    = ZERO;
    TRANSIENT UBYTE* Gfx_Buffer /* = NULL */ ;
    TRANSIENT int    i, j,
                     x, y;
    PERSIST   TEXT   tempstring[MAX_PATH + 80 + 1]; // PERSISTent so as not to blow the stack

    if (gameopen(loadas))
    {   if (gamesize == 35200)
        {   filetype = FILETYPE_LEVEL;
        } elif (gamesize == 180)
        {   filetype = FILETYPE_HISCORES;
        } else
        {   DisplayBeep(NULL);
            return FALSE;
    }   }
    else
    {   return FALSE;
    }

    serializemode = SERIALIZE_READ;
    serialize();

    if (filetype == FILETYPE_LEVEL)
    {   if (!(Gfx_Buffer = AllocMem(40000, MEMF_ANY)))
        {   rq("Out of memory!\n");
        }
        memset(&TileData[0][0][0], 0, sizeof(TileData));

        zstrncpy(Gfx_Pathname, pathname, (size_t) ((STRPTR) PathPart(pathname) - (STRPTR) pathname));
        if (!(AddPart(Gfx_Pathname, "LEV", MAX_PATH)))
        {   printf("Can't assemble path %s!\n", Gfx_Pathname);
            goto ABORT;
        }
        if (Exists(Gfx_Pathname))
        {   lev = TRUE;
        } else
        {   lev = FALSE;
        }

        for (i = 0; i < 5; i++)
        {   zstrncpy(Gfx_Pathname, pathname, (size_t) ((STRPTR) PathPart(pathname) - (STRPTR) pathname));
            if (lev && !(AddPart(Gfx_Pathname, "LEV/", MAX_PATH)))
            {   sprintf(tempstring, "Can't assemble path \"%s\"!\n", Gfx_Pathname);
                say(tempstring, REQIMAGE_WARNING);
                goto ABORT;
            }
            if (!(AddPart(Gfx_Pathname, mapname[i], MAX_PATH)))
            {   sprintf(tempstring, "Can't assemble pathname \"%s\"!\n", Gfx_Pathname);
                say(tempstring, REQIMAGE_WARNING);
                goto ABORT;
            }
            if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_OLDFILE)))
            {   sprintf(tempstring, "Can't open file \"%s\" for reading!\n", Gfx_Pathname);
                say(tempstring, REQIMAGE_WARNING);
                goto ABORT;
            }
            if (Read(FileHandle, Gfx_Buffer, 40000) != (LONG) 40000)
            {   sprintf(tempstring, "Can't read file \"%s\"!\n", Gfx_Pathname);
                say(tempstring, REQIMAGE_WARNING);
                goto ABORT;
            }
            DISCARD Close(FileHandle);
            // FileHandle = ZERO;

            for (j = 0; j < 5; j++)
            {   for (y = 0; y < 200; y++)
                {   for (x = 0; x < 320; x++)
                    {   if (Gfx_Buffer[(j * 8000) + (y * 40) + (x / 8)] & (0x80 >> (x % 8)))
                        {  TileData[i][y][x] |= (0x01 << j);
        }   }   }   }   }

        gottitle = FALSE;
        zstrncpy(Gfx_Pathname, pathname, (size_t) (PathPart((STRPTR)  pathname) - (STRPTR) pathname));
        if
        (   AddPart(Gfx_Pathname, "title.bin", MAX_PATH)
         && ((FileHandle = (BPTR) Open(Gfx_Pathname, MODE_OLDFILE)))
        )
        {   if (Read(FileHandle, Gfx_Buffer, 40000) == (LONG) 40000)
            {   gottitle = TRUE;

                for (i = 0; i < 5; i++)
                {   for (j = 0; j < 320 * 200; j++)
                    {   if (Gfx_Buffer[(i * 8000) + (j / 8)] & (0x80 >> (j % 8)))
                        {   ScrnData[j] |= (0x01 << i);
            }   }   }   }
            DISCARD Close(FileHandle);
            // FileHandle = ZERO;
        }

        FreeMem(Gfx_Buffer, 40000);
        // Gfx_Buffer = NULL;
    }

    writegadgets();

    return TRUE;

ABORT:
    if (FileHandle)
    {   DISCARD Close(FileHandle);
        // FileHandle = ZERO;
    }
    // assert(Gfx_Buffer);
    FreeMem(Gfx_Buffer, 40000);
    // Gfx_Buffer = NULL;

    return FALSE;
}

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_ROCKFORD
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    either_ch(GID_RF_CH1,  &filetype);
    either_ch(GID_RF_CH2,  &rf_world);
    level++;
    either_sl(GID_RF_SL1,  &level);
    either_in(GID_RF_IN11, &level);
    level--;

    for (i = 0; i < 10; i++)
    {   ghost_st(GID_RF_ST1 + i, (filetype != FILETYPE_HISCORES));
        ghost_st(GID_RF_IN1 + i, (filetype != FILETYPE_HISCORES));
    }
    ghost(       GID_RF_BU1    , (filetype != FILETYPE_HISCORES));

    ghost(       GID_RF_CH2    , (filetype != FILETYPE_LEVEL   ));
    ghost_st(    GID_RF_IN11   , (filetype != FILETYPE_LEVEL   ));
    ghost(       GID_RF_SL1    , (filetype != FILETYPE_LEVEL   ));
    ghost_st(    GID_RF_ST11   , (filetype != FILETYPE_LEVEL   ));
    ghost(       GID_RF_SP1    , (filetype != FILETYPE_LEVEL   ));
    ghost(       GID_RF_SP2    , (filetype != FILETYPE_LEVEL   ));
    ghost(       GID_RF_BU2    , (filetype != FILETYPE_LEVEL   ));

    ghost(       GID_RF_BU6    , (filetype != FILETYPE_LEVEL   || !gottitle));
    ghost(       GID_RF_BU7    , (filetype != FILETYPE_LEVEL   ));
    ghost(       GID_RF_BU8    , (filetype != FILETYPE_LEVEL   || !gotclip));

    rf_freepens();
    rf_getpens();
    rf_drawmap(TRUE);
}

MODULE void eithergadgets(void)
{   int i;

    if (filetype == FILETYPE_HISCORES)
    {   for (i = 0; i < 10; i++)
        {   either_st(GID_RF_ST1 + i,  name[i]);
            either_in(GID_RF_IN1 + i, &score[i]);
}   }   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i, j;

    if (filetype == FILETYPE_HISCORES)
    {   offset = 0;

        if (serializemode == SERIALIZE_READ)
        {   for (i = 0; i < 10; i++)
            {   for (j = 0; j < 10; j++)
                {   name[i][j] = getubyte();                    //  0..9
                }
                name[i][10] = EOS;
                offset++;                                       // 10
                score[i] =  (int) (getubyte() - '0') * 100000;  // 11
                score[i] += (int) (getubyte() - '0') *  10000;  // 12
                score[i] += (int) (getubyte() - '0') *   1000;  // 13
                score[i] += (int) (getubyte() - '0') *    100;  // 14
                score[i] += (int) (getubyte() - '0') *     10;  // 15
                score[i] += (int) (getubyte() - '0')         ;  // 16
                offset++;                                       // 17
        }   }
        else
        {   // assert(serializemode == SERIALIZE_WRITE);

            sortscores();

            for (i = 0; i < 10; i++)
            {   for (j = 9; j >= 0; j--)
                {   if (name[i][j] == EOS)
                    {   name[i][j] = '-';
                    } else
                    {   break;
                }   }
                for (j = 0; j < 10; j++)
                {   IOBuffer[offset++] = name[i][j];                               //  0..9
                }
                offset++;                                                          // 10
                IOBuffer[offset++] = (UBYTE) '0' + ( score[i]           / 100000); // 11
                IOBuffer[offset++] = (UBYTE) '0' + ((score[i] % 100000) /  10000); // 12
                IOBuffer[offset++] = (UBYTE) '0' + ((score[i] %  10000) /   1000); // 13
                IOBuffer[offset++] = (UBYTE) '0' + ((score[i] %   1000) /    100); // 14
                IOBuffer[offset++] = (UBYTE) '0' + ((score[i] %    100) /     10); // 15
                IOBuffer[offset++] = (UBYTE) '0' + ( score[i] %     10)          ; // 16
                offset++;                                                          // 17
        }   }

        for (i = 0; i < 10; i++)
        {   for (j = 9; j >= 0; j--)
            {   if (name[i][j] == '-')
                {   name[i][j] = EOS;
                } else
                {   break;
}   }   }   }   }

EXPORT void rf_save(FLAG saveas)
{   BPTR   FileHandle /* = ZERO */ ;
    FLAG   ok;
    UBYTE* Gfx_Buffer /* = NULL */ ;
    int    i, j,
           level,
           x, y;

    readgadgets();

    if (filetype == FILETYPE_LEVEL)
    {   for (level = 0; level < 40; level++)
        {   ok = FALSE;
            for (y = 0; y < MAPHEIGHT; y++)
            {   for (x = 0; x < MAPWIDTH; x++)
                {   if (IOBuffer[(level * 880) + (y * MAPWIDTH) + x] == 0x20) // you
                    {   ok = TRUE;
            }   }   }
            if (!ok)
            {   say("Can't save, because not every level has an entrance!", REQIMAGE_WARNING);
                return;
        }   }

        for (level = 0; level < 40; level++)
        {   ok = FALSE;
            for (y = 0; y < MAPHEIGHT; y++)
            {   for (x = 0; x < MAPWIDTH; x++)
                {   if (IOBuffer[(level * 880) + (y * MAPWIDTH) + x] == 0x74) // exit
                    {   ok = TRUE;
            }   }   }
            if (!ok)
            {   say("Can't save, because not every level has an exit!", REQIMAGE_WARNING);
                return;
    }   }   }

    serializemode = SERIALIZE_WRITE;
    serialize();

    if (filetype == FILETYPE_HISCORES)
    {   gamesave("#?Rockford.hi#?", "Rockford", saveas,   180, FLAG_H, FALSE);
    }  else
    {   gamesave("#?maps#?"       , "Rockford", saveas, 35200, FLAG_G | FLAG_L, TRUE);

        if (!(Gfx_Buffer = AllocMem(40000, MEMF_ANY)))
        {   rq("Out of memory!\n");
        }

        for (i = 0; i < 5; i++)
        {   memset(&Gfx_Buffer[0], 0, 40000);
            for (j = 0; j < 5; j++)
            {   for (y = 0; y < 200; y++)
                {   for (x = 0; x < 320; x++)
                    {   if (TileData[i][y][x] & (1 << j))
                        {   Gfx_Buffer[(j * 8000) + (y * 40) + (x / 8)] |= (0x80 >> (x % 8));
            }   }   }   }

            zstrncpy(Gfx_Pathname, pathname, (size_t) ((STRPTR) PathPart(pathname) - (STRPTR) pathname));
            if (lev && !(AddPart(Gfx_Pathname, "LEV/", MAX_PATH)))
            {   printf("Can't assemble path %s!\n", Gfx_Pathname);
                goto ABORT;
            }
            if (!(AddPart(Gfx_Pathname, mapname[i], MAX_PATH)))
            {   printf("Can't assemble pathname %s!\n", Gfx_Pathname);
                goto ABORT;
            }
            if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_NEWFILE)))
            {   printf("Can't open file %s for writing!\n", Gfx_Pathname);
                goto ABORT;
            }
            DISCARD Write(FileHandle, Gfx_Buffer, 40000);
            DISCARD Close(FileHandle);
            // FileHandle = ZERO;
        }

        memset(&Gfx_Buffer[0], 0, 40000);
        for (i = 0; i < 5; i++)
        {   for (j = 0; j < 64000; j++)
            {   if (ScrnData[j] & (1 << i))
                {   Gfx_Buffer[(i * 8000) + (j / 8)] |= (0x80 >> (j % 8));
        }   }   }

        zstrncpy(Gfx_Pathname, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
        if (!(AddPart(Gfx_Pathname, "title.bin", MAX_PATH)))
        {   printf("Can't assemble pathname %s!\n", Gfx_Pathname);
            goto ABORT;
        }
        if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_NEWFILE)))
        {   printf("Can't open file %s for writing!\n", Gfx_Pathname);
            goto ABORT;
        }
        DISCARD Write(FileHandle, Gfx_Buffer, 40000);
        DISCARD Close(FileHandle);
        // FileHandle = ZERO;

        FreeMem(Gfx_Buffer, 40000);
        // Gfx_Buffer = NULL;

        say("Saved files.", REQIMAGE_INFO);
    }

    return;

ABORT:
    // assert(Gfx_Buffer);
    FreeMem(Gfx_Buffer, 40000);
    // Gfx_Buffer = NULL;
}

EXPORT void rf_close(void) { ; }

EXPORT void rf_exit(void)
{   rf_freepens();
}

MODULE void sortscores(void)
{   int   i, j;
    TEXT  tempstr[10 + 1];
    ULONG tempnum;

    for (i = 0; i < 10; i++)
    {   for (j = 0; j < 10; j++)
        {   name[i][j] = toupper(name[i][j]);
    }   }

    for (i = 0; i < 10 - 1; i++)
    {   for (j = 0; j < 10 - i - 1; j++)
        {   if
            (   score[j    ]
              < score[j + 1]
            )
            {   tempnum      = score[j    ];
                score[j    ] = score[j + 1];
                score[j + 1] = tempnum;

                strcpy(tempstr,     name[j    ]);
                strcpy(name[j    ], name[j + 1]);
                strcpy(name[j + 1], tempstr);
    }   }   }

    writegadgets();
}

MODULE void clearscores(void)
{   int i;

    for (i = 0; i < 10; i++)
    {   name[i][0]  =
        name[i][10] = EOS;
        score[i]    = 0;
}   }

EXPORT void rf_drawmap(FLAG all)
{   int   i,
          whichpen,
          x, xx,
          y, yy;
    UBYTE here;
    FLAG  ok;

    for (y = 0; y < MAPHEIGHT; y++)
    {   for (x = 0; x < MAPWIDTH; x++)
        {   if (filetype == FILETYPE_HISCORES)
            {   here = 0; // empty
            } else
            {   here = IOBuffer[(rf_world * 7040) + (level * 880) + (y * MAPWIDTH) + x];
                ok = FALSE;
                for (i = 0; i < 168; i++)
                {   if (here == tilepos[i].to_file)
                    {   here = i;
                        ok = TRUE;
                        break;
                }   }
                if (!ok)
                {   here = 20; // you
            }   }
            for (yy = 0; yy < MAPSCALE; yy++)
            {   for (xx = 0; xx < MAPSCALE; xx++)
                {   whichpen = TileData[rf_world][tilepos[here].y + yy][tilepos[here].x + xx];
                    *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[whichpen];
    }   }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_RF_SP1]->LeftEdge,
        gadgets[GID_RF_SP1]->TopEdge,
        gadgets[GID_RF_SP1]->LeftEdge + SCALEDWIDTH  - 1,
        gadgets[GID_RF_SP1]->TopEdge  + SCALEDHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );

    if (all)
    {   updatetiles();
}   }

MODULE void rf_drawmappart(int x, int y)
{   FLAG  ok;
    UBYTE here,
          whichpen;
    int   i,
          xx, yy;

    here = IOBuffer[(rf_world * 7040) + (level * 880) + (y * MAPWIDTH) + x];
    ok = FALSE;
    for (i = 0; i < 168; i++)
    {   if (here == tilepos[i].to_file)
        {   here = i;
            ok = TRUE;
            break;
    }   }
    if (!ok)
    {   here = 20; // you
    }
    for (yy = 0; yy < MAPSCALE; yy++)
    {   for (xx = 0; xx < MAPSCALE; xx++)
        {   whichpen = TileData[rf_world][tilepos[here].y + yy][tilepos[here].x + xx];
            *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[whichpen];
    }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_RF_SP1]->LeftEdge,
        gadgets[GID_RF_SP1]->TopEdge  + (y * 16),
        gadgets[GID_RF_SP1]->LeftEdge + SCALEDWIDTH  - 1,
        gadgets[GID_RF_SP1]->TopEdge  + (y * 16) + 15,
        &display1[GFXINIT(SCALEDWIDTH, (y * 16))],
        &wpa8rastport[0]
    );
}

EXPORT void rf_uniconify(void)
{   rf_freepens();
    rf_getpens();
    rf_drawmap(TRUE);
}

EXPORT void rf_key(UBYTE scancode)
{   if (filetype != FILETYPE_LEVEL)
    {   return;
    }

    switch (scancode)
    {
    case SCAN_LEFT:
    case SCAN_N4:
        if (level == 0)
        {   level = 7;
            if (rf_world == 0)
            {   rf_world = 4;
            } else
            {   rf_world--;
            }
            rf_freepens();
            rf_getpens();
        } else
        {   level--;
        }
    acase SCAN_RIGHT:
    case SCAN_N6:
        if (level == 7)
        {   level = 0;
            if (rf_world == 4)
            {   rf_world = 0;
            } else
            {   rf_world++;
            }
            rf_freepens();
            rf_getpens();
        } else
        {   level++;
        }
    acase SCAN_E:
        gfxwindow();
    adefault:
        return;
    }

    writegadgets();
}

EXPORT void rf_tick(SWORD mousex, SWORD mousey)
{   FLAG  ok = FALSE;
    TEXT  tempstring[3 + 1];
    UBYTE whichtile;
    int   tileoffset,
          x, y;

    if (mouseisover(GID_RF_SP1, mousex, mousey))
    {   setpointer(TRUE, WinObject, MainWindowPtr, FALSE);

        if (filetype == FILETYPE_LEVEL)
        {   x = (mousex - gadgets[GID_RF_SP1]->LeftEdge) / MAPSCALE;
            y = (mousey - gadgets[GID_RF_SP1]->TopEdge ) / MAPSCALE;

            tileoffset = (rf_world * 7040) + (level * 880) + (y * MAPWIDTH) + x;
            sprintf(tempstring, "$%02X", IOBuffer[tileoffset]);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_RF_ST11], MainWindowPtr, NULL,
                STRINGA_TextVal, tempstring,
            TAG_END); // this refreshes automatically
            ok = TRUE;
    }   }
    elif (mouseisover(GID_RF_SP2, mousex, mousey))
    {   setpointer(TRUE, WinObject, MainWindowPtr, FALSE);

        if (filetype == FILETYPE_LEVEL)
        {   x = (mousex - gadgets[GID_RF_SP2]->LeftEdge) / MAPSCALE;
            y = (mousey - gadgets[GID_RF_SP2]->TopEdge ) / MAPSCALE;
            whichtile = (y * TILESWIDTH) + x;
            sprintf(tempstring, "$%02X", tilepos[whichtile].to_file);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_RF_ST11], MainWindowPtr, NULL,
                STRINGA_TextVal, tempstring,
            TAG_END); // this refreshes automatically
            ok = TRUE;
    }   }
    else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
    }

    if (!ok)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_RF_ST11], MainWindowPtr, NULL,
            STRINGA_TextVal, "-",
        TAG_END); // this refreshes automatically
}   }

MODULE void updatetiles(void)
{   int   x,  y,
          xx, yy;
    UBYTE whichpen,
          whichtile;

    if (filetype == FILETYPE_LEVEL)
    {   for (x = 0; x < TILESWIDTH; x++)
        {   for (y = 0; y < TILESHEIGHT; y++)
            {   whichtile = (y * TILESWIDTH) + x;
                for (xx = 0; xx < 16; xx++)
                {   for (yy = 0; yy < 16; yy++)
                    {   if (whichtile == stamp && (xx == 0 || xx == 15 || yy == 0 || yy == 15))
                        {   whichpen = tilepos[stamp].recommended ? WHITE : black[rf_world];
                        } else
                        {   whichpen = TileData[rf_world][tilepos[whichtile].y + yy][tilepos[whichtile].x + xx];
                        }
                        *(byteptr2[(y * 16) + yy] + (x * 16) + xx) = pens[whichpen];
    }   }   }   }   }
    else
    {   for (x = 0; x < TILESWIDTH * 16; x++)
        {   for (y = 0; y < TILESHEIGHT * 16; y++)
            {   *(byteptr2[y] + x) = pens[black[rf_world]];
    }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_RF_SP2]->LeftEdge,
        gadgets[GID_RF_SP2]->TopEdge,
        gadgets[GID_RF_SP2]->LeftEdge + (TILESWIDTH  * 16) - 1,
        gadgets[GID_RF_SP2]->TopEdge  + (TILESHEIGHT * 16) - 1,
        display2,
        &wpa8rastport[1]
    );

    DISCARD SetGadgetAttrs
    (   gadgets[GID_RF_BU3], MainWindowPtr, NULL,
        GA_Disabled, ((filetype == FILETYPE_LEVEL && SketchBoardBase && gotallpens) ? FALSE : TRUE),
    TAG_END); // this refreshes automatically
}

EXPORT void rf_lmb(SWORD mousex, SWORD mousey, UWORD code)
{   TRANSIENT int   x, y;
    PERSIST   ULONG oldsecs,
                    oldmicros,
                    newsecs   = 0,
                    newmicros = 0;

    if (filetype != FILETYPE_LEVEL)
    {   return;
    }

    if (code == SELECTUP)
    {   lmb = FALSE;
    } elif (code == SELECTDOWN) // this doesn't repeat
    {   lmb = TRUE;

        if (mouseisover(GID_RF_SP1, mousex, mousey))
        {   stampit(mousex, mousey);
        } elif (mouseisover(GID_RF_SP2, mousex, mousey))
        {   x = (mousex - gadgets[GID_RF_SP2]->LeftEdge) / 16;
            y = (mousey - gadgets[GID_RF_SP2]->TopEdge ) / 16;

            oldsecs   = newsecs;
            oldmicros = newmicros;
            CurrentTime(&newsecs, &newmicros);

            if
            (   x == stamp % TILESWIDTH
             && y == stamp / TILESWIDTH
             && DoubleClick(oldsecs, oldmicros, newsecs, newmicros)
             && SketchBoardBase
             && gotallpens
            )
            {   // assert(tileplanes[stamp]);
                gfxwindow();
                lmb = FALSE;
            } else
            {   stamp = (y * TILESWIDTH) + x;
                updatetiles();
}   }   }   }

MODULE void stampit(SWORD mousex, SWORD mousey)
{   UBYTE whichtile;
    int   tileoffset,
          x, y;

    x          = (mousex - gadgets[GID_RF_SP1]->LeftEdge) / 16;
    y          = (mousey - gadgets[GID_RF_SP1]->TopEdge ) / 16;
    tileoffset = (rf_world * 7040) + (level * 880) + (y * MAPWIDTH) + x;
    whichtile  = IOBuffer[tileoffset];

    if (whichtile != tilepos[stamp].to_file)
    {   IOBuffer[tileoffset] = tilepos[stamp].to_file;
        rf_drawmappart(x, y);
}   }

EXPORT void rf_mouse(SWORD mousex, SWORD mousey)
{   if (filetype != FILETYPE_LEVEL)
    {   return;
    }

    if (lmb && mouseisover(GID_RF_SP1, mousex, mousey))
    {   stampit(mousex, mousey);
}   }

EXPORT void rf_getpens(void)
{   TRANSIENT int i;
PERSIST const UWORD idealcolour[COLOURS][5] = {
{ 0x435, 0x555, 0x356, 0x047, 0x600 }, //  0
{ 0xFBB, 0xEC9, 0x333, 0xFFC, 0xC97 }, //  1
{ 0xB70, 0x4C4, 0xFC0, 0xA44, 0x8F0 }, //  2
{ 0xFA0, 0x5F5, 0xFE0, 0xF00, 0x080 }, //  3
{ 0xDB7, 0x393, 0xFA0, 0xF90, 0x0B6 }, //  4
{ 0x84F, 0xEA8, 0xD03, 0xFF0, 0x900 }, //  5
{ 0x97F, 0xF80, 0x923, 0xBF7, 0xE22 }, //  6
{ 0xBBF, 0xCCD, 0xFD2, 0x2B8, 0xF76 }, //  7
{ 0x070, 0x0A0, 0x060, 0x181, 0x0E0 }, //  8
{ 0x282, 0x0F0, 0x170, 0x08F, 0x05C }, //  9
{ 0x5A5, 0x610, 0x490, 0x05F, 0xE40 }, // 10
{ 0x9B9, 0xF2F, 0x30F, 0x04A, 0x666 }, // 11
{ 0x620, 0xFBF, 0xE00, 0x0BF, 0xAAA }, // 12
{ 0x942, 0x000, 0x665, 0x04F, 0xFFF }, // 13
{ 0xC74, 0xD00, 0xDBA, 0xCB9, 0xE00 }, // 14
{ 0xECA, 0x9B0, 0xEA8, 0xF00, 0xB31 }, // 15
{ 0xFC0, 0x080, 0x630, 0xCCF, 0xA52 }, // 16
{ 0xFD8, 0xB00, 0xA54, 0xFB3, 0xA64 }, // 17
{ 0xFEA, 0xF50, 0xC85, 0xD61, 0xD98 }, // 18
{ 0x84F, 0x16E, 0xFCA, 0xF30, 0xEB9 }, // 19
{ 0xF03, 0xF00, 0x108, 0x486, 0x000 }, // 20
{ 0xC48, 0xB60, 0x329, 0x5C9, 0xB73 }, // 21
{ 0x888, 0xFA0, 0x64A, 0xB70, 0xD97 }, // 22
{ 0x211, 0xB50, 0x87B, 0xFB0, 0xEB9 }, // 23
{ 0x000, 0xF80, 0x000, 0x87C, 0x33F }, // 24
{ 0x532, 0xFC2, 0x444, 0xBBF, 0x08C }, // 25
{ 0x865, 0x66D, 0x666, 0x000, 0x0BF }, // 26
{ 0xA98, 0x0CE, 0x777, 0x667, 0x666 }, // 27
{ 0xF67, 0x778, 0xAAA, 0x889, 0x888 }, // 28
{ 0xF03, 0xCCD, 0xCBB, 0xBBC, 0xBBB }, // 29
{ 0x90F, 0xEB4, 0xDDD, 0xD42, 0xEEE }, // 30
{ 0xFFF, 0xFFF, 0xFFF, 0xFFF, 0xFFF }, // 31 WHITE
}, scrncolour[COLOURS] = {
0x000, //  0
0x0BF, //  1
0xF50, //  2
0xF77, //  3
0xFC0, //  4
0x06F, //  5
0x2EF, //  6
0x0AE, //  7
0xA30, //  8
0xD44, //  9
0xF00, // 10
0xE90, // 11
0xFC0, // 12
0xC40, // 13
0xD67, // 14
0xD89, // 15
0xF9A, // 16
0xC0A, // 17
0xA39, // 18
0xEEE, // 19
0xFFF, // 20
0x655, // 21
0x877, // 22
0x877, // 23
0x988, // 24
0xA99, // 25
0xBAA, // 26
0xCBB, // 27
0xDCC, // 28
0xFEE, // 29
0xEEE, // 30
0xFFF, // 31
};

    lockscreen();

    gotallpens = TRUE;
    for (i = 0; i < 32; i++)
    {   pens[i] = (LONG) ObtainPen
        (   ScreenPtr->ViewPort.ColorMap,
            (ULONG) -1,
            ((idealcolour[i][rf_world] & 0x0F00) >> 8) * 0x11111111,
            ((idealcolour[i][rf_world] & 0x00F0) >> 4) * 0x11111111,
            ( idealcolour[i][rf_world] & 0x000F      ) * 0x11111111,
            PEN_EXCLUSIVE
        );
        if (pens[i] >= 0 && pens[i] <= 255)
        {   gotpen[i] = TRUE;
            convert[pens[i]] = i;
        } else
        {   gotallpens = FALSE;
            pens[i] = FindColor
            (   ScreenPtr->ViewPort.ColorMap,
                ((idealcolour[i][rf_world] & 0x0F00) >> 8) * 0x11111111,
                ((idealcolour[i][rf_world] & 0x00F0) >> 4) * 0x11111111,
                ( idealcolour[i][rf_world] & 0x000F      ) * 0x11111111,
                -1
            );
    }   }
    
    for (i = 32; i < 64; i++)
    {   pens[i] = FindColor
        (   ScreenPtr->ViewPort.ColorMap,
            ((scrncolour[i - 32] & 0x0F00) >> 8) * 0x11111111,
            ((scrncolour[i - 32] & 0x00F0) >> 4) * 0x11111111,
            ( scrncolour[i - 32] & 0x000F      ) * 0x11111111,
            -1
        );
        convert2[pens[i]] = i - 32;
    }

    unlockscreen();

    if (!gotallpens)
    {   rf_freepens();
}   }
EXPORT void rf_freepens(void)
{   int i;

    lockscreen();
    for (i = 0; i < 32; i++)
    {   if (gotpen[i])
        {   ReleasePen(ScreenPtr->ViewPort.ColorMap, (ULONG) pens[i]);
            gotpen[i] = FALSE;
    }   }
    unlockscreen();
    gotallpens = FALSE;
}

EXPORT void rf_realpen_to_table(void)
{   if (titlemode)
    {   fgpen_real = convert2[fgpen_real];
    } else
    {   fgpen_real = convert[ fgpen_real];
    }
    fgpen_intable  = fgpen_real;
}
EXPORT void rf_tablepen_to_real(void)
{   if (titlemode)
    {   fgpen_real = fgpen_intable + 32;
    } else
    {   fgpen_real = fgpen_intable;
}   }

EXPORT void rf_gettilepos(int* x, int* y)
{   *x = tilepos[stamp].x;
    *y = tilepos[stamp].y;
}

EXPORT void rf_readtitlescreen(void)
{   int x, y;

    // assert(titlemode);

    for (y = 0; y < 200; y++)
    {   ReadPixelLine8
        (   &sketchrastport,
            0, y,
            320 - 1,
            &ScrnData[y * 320],
            &wpa8tilerastport
        );
        for (x = 0; x < 320; x++)
        {   ScrnData[(y * 320) + x] = convert2[
            ScrnData[(y * 320) + x]           ];
}   }   }

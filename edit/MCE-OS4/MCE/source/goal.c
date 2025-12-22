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

#include <gadgets/gradientslider.h>

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
#define GID_GOAL_LY1    0 // root layout
#define GID_GOAL_SB1    1 // toolbar
#define GID_GOAL_ST1    2 // player  name
#define GID_GOAL_ST2    3 // team    name
#define GID_GOAL_ST3    4 // manager name
#define GID_GOAL_ST4    5 // file    name
#define GID_GOAL_IN1    6 // pace
#define GID_GOAL_IN2    7 // stamina
#define GID_GOAL_IN3    8 // aggression
#define GID_GOAL_IN4    9 // resilience
#define GID_GOAL_IN5   10 // keeping
#define GID_GOAL_IN6   11 // tackling
#define GID_GOAL_IN7   12 // passing
#define GID_GOAL_IN8   13 // shooting
#define GID_GOAL_IN9   14 // shirt #
#define GID_GOAL_BU1   15 // maximize player
#define GID_GOAL_BU2   16 // maximize team
#define GID_GOAL_CH1   17 // position
#define GID_GOAL_CH2   18 // formation
#define GID_GOAL_SP1   19 // 1st style
#define GID_GOAL_SP2   20 // 2nd style
#define GID_GOAL_SL1   21 // player #
#define GID_GOAL_SL2   22 // team   #
#define GID_GOAL_SL3   23 // file   #
#define GID_GOAL_GS1   24 // pace
#define GID_GOAL_GS2   25 // stamina
#define GID_GOAL_GS3   26 // aggression
#define GID_GOAL_GS4   27 // resilience
#define GID_GOAL_GS5   28 // keeping
#define GID_GOAL_GS6   29 // tackling
#define GID_GOAL_GS7   30 // passing
#define GID_GOAL_GS8   31 // shooting
#define GID_GOAL_PL1   32
#define GID_GOAL_PL2   33
#define GID_GOAL_PL3   34
#define GID_GOAL_PL4   35
#define GIDS_GOAL      GID_GOAL_PL4

#define FILES   40
#define TEAMS   32
#define PLAYERS 28

#define STYLEWIDTH   32 // must be at least 27 and divisible by 4
#define STYLEHEIGHT  32 // must be at least 23 and divisible by 4
#define STYLEXMARGIN ((STYLEWIDTH  - 27) / 2) // 2
#define STYLEYMARGIN ((STYLEHEIGHT - 23) / 2) // 2

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(int whichman);
MODULE void eithergadgets(void);
MODULE void draw1stshirt(void);
MODULE void draw2ndshirt(void);

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
IMPORT UBYTE               *byteptr1[DISPLAY1HEIGHT],
                           *byteptr2[DISPLAY2HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE],
                            display2[DISPLAY2SIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT UBYTE*               byteptr1[DISPLAY1HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE];

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE LONG                 sliderpens[54];
MODULE ULONG                colour[     FILES][TEAMS]         [2][2],
                            filenum   = 0,
                            formation[  FILES][TEAMS],
                            players[    FILES][TEAMS],
                            position[   FILES][TEAMS][PLAYERS],
                            shirt[      FILES][TEAMS][PLAYERS],
                            stat[       FILES][TEAMS][PLAYERS][8],
                            style[      FILES][TEAMS]         [2],
                            team      = 0,
                            who       = 0;
MODULE TEXT                 vfilename[  FILES]                [15 + 1],
                            teamname[   FILES][TEAMS]         [19 + 1],
                            managername[FILES][TEAMS]         [19 + 1],
                            playername[ FILES][TEAMS][PLAYERS][15 + 1];
MODULE int                  hoverover = 0,
                            lmb       = 0,
                            newstyle;

MODULE const STRPTR FormationOptions[4 + 1] =
{ "4-2-4", // 0
  "4-3-3", // 1
  "4-4-2", // 2
  "5-3-2", // 3
  NULL
}, PositionOptions[4 + 1] =
{ "Goal keeper",
  "Defender",
  "Midfield",
  "Forward",
  NULL
};

MODULE const TEXT StyleData[6][23][27 + 1] = {
{ "......#####.....#####......",
  ".....#YYYGG#...#GGYYY#.....",
  "....#YYYYYGG#.#GGYYYYY#....",
  "...#YYYYYYYGG#GGYYYYYYY#...",
  "..#YYYYYYYYYGGGYYYYYYYYY#..",
  ".#YYYYYYYYYYYGYYYYYYYYYYY#.",
  "#GGYYY#YYYYYYYYYYYYY#YYYGG#",
  ".#GGY##YYYYYYYYYYYYY##YGG#.",
  "..#G#.#YYYYYYYYYYYYY#.#G#..",
  "...#..#YYYYYYYYYYYYY#..#...",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......###############......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......###############......",
},
{ "......#####.....#####......",
  ".....#YGGGG#...#GGGGY#.....",
  "....#YGGGYGG#.#GGYGGGY#....",
  "...#YGGGGYYGG#GGYYGGGGY#...",
  "..#YGGYGGYYYGGGYYYGGYGGY#..",
  ".#YGGYYGGYYYGGGYYYGGYYGGY#.",
  "#YGGYY#GGYYYGGGYYYGG#YYGGY#",
  ".#GYY##GGYYYGGGYYYGG##YYG#.",
  "..#Y#.#GGYYYGGGYYYGG#.#Y#..",
  "...#..#GGYYYGGGYYYGG#..#...",
  "......#GGYYYGGGYYYGG#......",
  "......#GGYYYGGGYYYGG#......",
  "......#GGYYYGGGYYYGG#......",
  "......#GGYYYGGGYYYGG#......",
  "......#GGYYYGGGYYYGG#......",
  "......###############......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYY#YYYYYY#......",
  "......#YYYYYY#YYYYYY#......",
  "......#YYYYYY#YYYYYY#......",
  "......###############......",
},
{ "......#####.....#####......",
  ".....#YYYGG#...#GGYYY#.....",
  "....#YYYYYGG#.#GGYYYYY#....",
  "...#YYYYYYYGG#GGYYYYYYY#...",
  "..#YYYYYYYYYGGGYYYYYYYYY#..",
  ".#YYYYYYYYYYYGYYYYYYYYYYY#.",
  "#GYYYY#YYYYYYYYYYYYY#YYYYG#",
  ".#GYY##GGGGGGGGGGGGG##YYG#.",
  "..#G#.#GGGGGGGGGGGGG#.#G#..",
  "...#..#GGGGGGGGGGGGG#..#...",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGGGGGGGGG#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......###############......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYY#YYYYYY#......",
  "......#YYYYYY#YYYYYY#......",
  "......#YYYYYY#YYYYYY#......",
  "......###############......",
},
{ "......#####.....#####......",
  ".....#GGGGG#...#GGGGG#.....",
  "....#GGGGGYY#.#YYGGGGG#....",
  "...#GGGGGYYYY#YYYYGGGGG#...",
  "..#GGGGGYYYYGGGYYYYGGGGG#..",
  ".#GGGGGYYYYYYGYYYYYYGGGGG#.",
  "#GGGGG#YYYYYYYYYYYYY#GGGGG#",
  ".#GGG##YYYYYYYYYYYYY##GGG#.",
  "..#G#.#YYYYYYYYYYYYY#.#G#..",
  "...#..#YYYYYYYYYYYYY#..#...",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......#YYYYYYYYYYYYY#......",
  "......###############......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......###############......",
},
{ "......#####.....#####......",
  ".....#YYYYY#...#GGGGG#.....",
  "....#YYYYYGG#.#YYGGGGG#....",
  "...#YYYYYGGGG#YYYYGGGGG#...",
  "..#YYYYYGGGGGYYYYYYGGGGG#..",
  ".#YYYYYGGGGGGYYYYYYYGGGGG#.",
  "#YYYYY#GGGGGGYYYYYYY#GGGGG#",
  ".#YYY##GGGGGGYYYYYYY##GGG#.",
  "..#Y#.#GGGGGGYYYYYYY#.#G#..",
  "...#..#GGGGGGYYYYYYY#..#...",
  "......#GGGGGGYYYYYYY#......",
  "......#GGGGGGYYYYYYY#......",
  "......#GGGGGGYYYYYYY#......",
  "......#GGGGGGYYYYYYY#......",
  "......#GGGGGGYYYYYYY#......",
  "......###############......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......###############......",
},
{ "......#####.....#####......",
  ".....#YYYYG#...#GGGGG#.....",
  "....#YYYYYYG#.#GGGGGGY#....",
  "...#YYYYYYYYG#GGGGGGYYY#...",
  "..#YYYYYYYYYYGGGGGGYYYYY#..",
  ".#YYYYYYYYYYYYGGGGYYYYYYY#.",
  "#YYYYY#YYYYYYGGGGYYY#YYYYY#",
  ".#YYY##YYYYYGGGGYYYY##YYY#.",
  "..#Y#.#YYYYGGGGGYYYY#.#Y#..",
  "...#..#YYYGGGGGYYYYY#..#...",
  "......#YYYGGGGYYYYYY#......",
  "......#YYGGGGYYYYYYY#......",
  "......#YGGGGGYYYYYYY#......",
  "......#GGGGGYYYYYYYY#......",
  "......#GGGGYYYYYYYYY#......",
  "......###############......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGGGGGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......#GGGGGG#GGGGGG#......",
  "......###############......",
} };

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void goal_main(void)
{   TRANSIENT int   i;
    PERSIST   UWORD colourtable[2][16];   // this must stay valid!

    tool_open  = goal_open;
    tool_loop  = goal_loop;
    tool_save  = goal_save;
    tool_close = goal_close;
    tool_exit  = goal_exit;

    if (loaded != FUNC_GOAL && !goal_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_GOAL;

    goal_getpens();
    for (i = 0; i < 16; i++)
    {   colourtable[0][i] = pens[     i];
        colourtable[1][i] = pens[16 + i];
    }

    make_speedbar_list(GID_GOAL_SB1);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_ParentGroup,                                gadgets[GID_GOAL_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            AddToolbar(GID_GOAL_SB1),
            AddVLayout,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_Label,                              "File",
                LAYOUT_AddChild,                           gadgets[GID_GOAL_SL3] = (struct Gadget*)
                SliderObject,
                    GA_ID,                                 GID_GOAL_SL3,
                    GA_RelVerify,                          TRUE,
                    SLIDER_Min,                            0,
                    SLIDER_Max,                            FILES - 1,
                    SLIDER_KnobDelta,                      1,
                    SLIDER_Orientation,                    SLIDER_HORIZONTAL,
                    SLIDER_Ticks,                          FILES, // how many ticks to display
                SliderEnd,
                Label("File:"),
                CHILD_MinWidth,                            128,
                CHILD_WeightedHeight,                      0,
                LAYOUT_AddChild,                           gadgets[GID_GOAL_ST4] = (struct Gadget*)
                StringObject,
                    GA_ID,                                 GID_GOAL_ST4,
                    GA_TabCycle,                           TRUE,
                    STRINGA_MaxChars,                      15 + 1,
                    STRINGA_MinVisible,                    15 + stringextra,
                StringEnd,
                Label("Fil_ename:"),
                AddVLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_Label,                          "Team",
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_GOAL_SL2] = (struct Gadget*)
                        SliderObject,
                            GA_ID,                         GID_GOAL_SL2,
                            GA_RelVerify,                  TRUE,
                            SLIDER_Min,                    0,
                            SLIDER_Max,                    TEAMS - 1,
                            SLIDER_KnobDelta,              1,
                            SLIDER_Orientation,            SLIDER_HORIZONTAL,
                            SLIDER_Ticks,                  TEAMS, // how many ticks to display
                        SliderEnd,
                        Label("Team:"),
                        CHILD_MinWidth,                    128,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_GOAL_ST2] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GOAL_ST2,
                            GA_TabCycle,                   TRUE,
                            STRINGA_MaxChars,              19 + 1,
                            STRINGA_MinVisible,            19 + stringextra,
                        StringEnd,
                        Label("Team _name:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_GOAL_ST3] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GOAL_ST3,
                            GA_TabCycle,                   TRUE,
                            STRINGA_MaxChars,              19 + 1,
                            STRINGA_MinVisible,            19 + stringextra,
                        StringEnd,
                        Label("_Manager name:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_GOAL_CH2] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_GOAL_CH2,
                            CHOOSER_LabelArray,            &FormationOptions,
                        PopUpEnd,
                        Label("_Formation:"),
                        CHILD_WeightedHeight,              0,
                        AddHLayout,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_Label,                  "1st Kit",
                            AddHLayout,
                                LAYOUT_AddChild,           gadgets[GID_GOAL_SP1] = (struct Gadget*)
                                SpaceObject,
                                    GA_ID,                 GID_GOAL_SP1,
                                    GA_RelVerify,          TRUE,
                                    SPACE_MinWidth,        STYLEWIDTH,
                                    SPACE_MinHeight,       STYLEHEIGHT,
                                    SPACE_BevelStyle,      BVS_NONE,
                                    SPACE_Transparent,     TRUE,
                                SpaceEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,           0,
                            Label("Style:"),
                            AddVLayout,
                                LAYOUT_AddChild,           gadgets[GID_GOAL_PL1] = (struct Gadget*)
                                PaletteObject,
                                    GA_ID,                 GID_GOAL_PL1,
                                    GA_RelVerify,          TRUE,
                                    PALETTE_NumColours,    16,
                                    PALETTE_ColourTable,   colourtable[0],
                                PaletteEnd,
                                Label("_1st:"),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_PL2] = (struct Gadget*)
                                PaletteObject,
                                    GA_ID,                 GID_GOAL_PL2,
                                    GA_RelVerify,          TRUE,
                                    PALETTE_NumColours,    16,
                                    PALETTE_ColourTable,   colourtable[0],
                                PaletteEnd,
                                Label("_2nd:"),
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        AddHLayout,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_Label,                  "2nd Kit",
                            AddHLayout,
                                LAYOUT_AddChild,           gadgets[GID_GOAL_SP2] = (struct Gadget*)
                                SpaceObject,
                                    GA_ID,                 GID_GOAL_SP2,
                                    GA_RelVerify,          TRUE,
                                    SPACE_MinWidth,        STYLEWIDTH,
                                    SPACE_MinHeight,       STYLEHEIGHT,
                                    SPACE_BevelStyle,      BVS_NONE,
                                    SPACE_Transparent,     TRUE,
                                SpaceEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,           0,
                            Label("Style:"),
                            AddVLayout,
                                LAYOUT_AddChild,           gadgets[GID_GOAL_PL3] = (struct Gadget*)
                                PaletteObject,
                                    GA_ID,                 GID_GOAL_PL3,
                                    GA_RelVerify,          TRUE,
                                    PALETTE_NumColours,    16,
                                    PALETTE_ColourTable,   colourtable[1],
                                PaletteEnd,
                                Label("1st:"),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_PL4] = (struct Gadget*)
                                PaletteObject,
                                    GA_ID,                 GID_GOAL_PL4,
                                    GA_RelVerify,          TRUE,
                                    PALETTE_NumColours,    16,
                                    PALETTE_ColourTable,   colourtable[1],
                                PaletteEnd,
                                Label("2n_d:"),
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_Label,                      "Player",
                        LAYOUT_AddChild,                   gadgets[GID_GOAL_SL1] = (struct Gadget*)
                        SliderObject,
                            GA_ID,                         GID_GOAL_SL1,
                            GA_RelVerify,                  TRUE,
                            SLIDER_Min,                    0,
                            SLIDER_Max,                    PLAYERS - 1,
                            SLIDER_KnobDelta,              1,
                            SLIDER_Orientation,            SLIDER_HORIZONTAL,
                            SLIDER_Ticks,                  PLAYERS, // how many ticks to display
                        SliderEnd,
                        Label("Player:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_GOAL_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_GOAL_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_MaxChars,              15 + 1,
                            STRINGA_MinVisible,            15 + stringextra,
                        StringEnd,
                        Label("P_layer name:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_GOAL_IN9] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_GOAL_IN9,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               14,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Sh_irt:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_GOAL_CH1] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_GOAL_CH1,
                            CHOOSER_LabelArray,            &PositionOptions,
                        PopUpEnd,
                        Label("P_osition:"),
                        CHILD_WeightedHeight,              0,
                        AddHLayout,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_BevelStyle,             BVS_SBAR_VERT,
                            LAYOUT_Label,                  "Attributes",
                            AddVLayout,
                                LAYOUT_AddChild,           gadgets[GID_GOAL_IN1] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_GOAL_IN1,
                                    GA_TabCycle,           TRUE,
                                    GA_RelVerify,          TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       255,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                                Label("_Pace:"),
                                CHILD_WeightedHeight,      0,
                                LAYOUT_AddChild,           gadgets[GID_GOAL_IN2] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_GOAL_IN2,
                                    GA_TabCycle,           TRUE,
                                    GA_RelVerify,          TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       255,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                                Label("_Stamina:"),
                                CHILD_WeightedHeight,      0,
                                LAYOUT_AddChild,           gadgets[GID_GOAL_IN3] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_GOAL_IN3,
                                    GA_TabCycle,           TRUE,
                                    GA_RelVerify,          TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       255,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                                Label("_Aggression:"),
                                CHILD_WeightedHeight,      0,
                                LAYOUT_AddChild,           gadgets[GID_GOAL_IN4] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_GOAL_IN4,
                                    GA_TabCycle,           TRUE,
                                    GA_RelVerify,          TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       255,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                                Label("_Resilience:"),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_IN5] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_GOAL_IN5,
                                    GA_TabCycle,           TRUE,
                                    GA_RelVerify,          TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       255,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                                Label("_Keeping:"),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_IN6] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_GOAL_IN6,
                                    GA_TabCycle,           TRUE,
                                    GA_RelVerify,          TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       255,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                                Label("_Tackling:"),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_IN7] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_GOAL_IN7,
                                    GA_TabCycle,           TRUE,
                                    GA_RelVerify,          TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       255,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                                Label("Passin_g:"),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_IN8] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_GOAL_IN8,
                                    GA_TabCycle,           TRUE,
                                    GA_RelVerify,          TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       255,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                                Label("S_hooting:"),
                            LayoutEnd,
                            CHILD_WeightedWidth,           0,
                            AddVLayout,
                                LAYOUT_AddChild,           gadgets[GID_GOAL_GS1] = (struct Gadget*)
                                NewObject
                                (   NULL,                  "gradientslider.gadget",
                                    GA_ID,                 GID_GOAL_GS1,
                                    GA_RelVerify,          TRUE,
                                    PGA_Freedom,           LORIENT_HORIZ, // PGA_FREEDOM is obsolete even under OS3.9
                                    GRAD_MaxVal,           255,
                                    GRAD_CurVal,           stat[filenum][team][who][0], // shouldn't be required but is
                                    GRAD_PenArray,         sliderpens,
                                    GRAD_SkipVal,          5,
                                TAG_DONE),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_GS2] = (struct Gadget*)
                                NewObject
                                (   NULL,                  "gradientslider.gadget",
                                    GA_ID,                 GID_GOAL_GS2,
                                    GA_RelVerify,          TRUE,
                                    PGA_Freedom,           LORIENT_HORIZ, // PGA_FREEDOM is obsolete even under OS3.9
                                    GRAD_MaxVal,           255,
                                    GRAD_CurVal,           stat[filenum][team][who][1], // shouldn't be required but is
                                    GRAD_PenArray,         sliderpens,
                                    GRAD_SkipVal,          5,
                                TAG_DONE),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_GS3] = (struct Gadget*)
                                NewObject
                                (   NULL,                  "gradientslider.gadget",
                                    GA_ID,                 GID_GOAL_GS3,
                                    GA_RelVerify,          TRUE,
                                    PGA_Freedom,           LORIENT_HORIZ, // PGA_FREEDOM is obsolete even under OS3.9
                                    GRAD_MaxVal,           255,
                                    GRAD_CurVal,           stat[filenum][team][who][2], // shouldn't be required but is
                                    GRAD_PenArray,         sliderpens,
                                    GRAD_SkipVal,          5,
                                TAG_DONE),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_GS4] = (struct Gadget*)
                                NewObject
                                (   NULL,                  "gradientslider.gadget",
                                    GA_ID,                 GID_GOAL_GS4,
                                    GA_RelVerify,          TRUE,
                                    PGA_Freedom,           LORIENT_HORIZ, // PGA_FREEDOM is obsolete even under OS3.9
                                    GRAD_MaxVal,           255,
                                    GRAD_CurVal,           stat[filenum][team][who][3], // shouldn't be required but is
                                    GRAD_PenArray,         sliderpens,
                                    GRAD_SkipVal,          5,
                                TAG_DONE),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_GS5] = (struct Gadget*)
                                NewObject
                                (   NULL,                  "gradientslider.gadget",
                                    GA_ID,                 GID_GOAL_GS5,
                                    GA_RelVerify,          TRUE,
                                    PGA_Freedom,           LORIENT_HORIZ, // PGA_FREEDOM is obsolete even under OS3.9
                                    GRAD_MaxVal,           255,
                                    GRAD_CurVal,           stat[filenum][team][who][4], // shouldn't be required but is
                                    GRAD_PenArray,         sliderpens,
                                    GRAD_SkipVal,          5,
                                TAG_DONE),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_GS6] = (struct Gadget*)
                                NewObject
                                (   NULL,                  "gradientslider.gadget",
                                    GA_ID,                 GID_GOAL_GS6,
                                    GA_RelVerify,          TRUE,
                                    PGA_Freedom,           LORIENT_HORIZ, // PGA_FREEDOM is obsolete even under OS3.9
                                    GRAD_MaxVal,           255,
                                    GRAD_CurVal,           stat[filenum][team][who][5], // shouldn't be required but is
                                    GRAD_PenArray,         sliderpens,
                                    GRAD_SkipVal,          5,
                                TAG_DONE),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_GS7] = (struct Gadget*)
                                NewObject
                                (   NULL,                  "gradientslider.gadget",
                                    GA_ID,                 GID_GOAL_GS7,
                                    GA_RelVerify,          TRUE,
                                    PGA_Freedom,           LORIENT_HORIZ, // PGA_FREEDOM is obsolete even under OS3.9
                                    GRAD_MaxVal,           255,
                                    GRAD_CurVal,           stat[filenum][team][who][6], // shouldn't be required but is
                                    GRAD_PenArray,         sliderpens,
                                    GRAD_SkipVal,          5,
                                TAG_DONE),
                                LAYOUT_AddChild,           gadgets[GID_GOAL_GS8] = (struct Gadget*)
                                NewObject
                                (   NULL,                  "gradientslider.gadget",
                                    GA_ID,                 GID_GOAL_GS8,
                                    GA_RelVerify,          TRUE,
                                    PGA_Freedom,           LORIENT_HORIZ, // PGA_FREEDOM is obsolete even under OS3.9
                                    GRAD_MaxVal,           255,
                                    GRAD_CurVal,           stat[filenum][team][who][7], // shouldn't be required but is
                                    GRAD_PenArray,         sliderpens,
                                    GRAD_SkipVal,          5,
                                TAG_DONE),
                            LayoutEnd,
                            CHILD_MinWidth,                400,
                        LayoutEnd,
                        MaximizeButton(GID_GOAL_BU1, "Ma_ximize Player"),
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    MaximizeButton(GID_GOAL_BU2, "Maximi_ze Team"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_WeightedHeight,                              0,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_GOAL_SB1);

    setup_bm(0, STYLEWIDTH, STYLEHEIGHT, MainWindowPtr);
    setup_bm(1, STYLEWIDTH, STYLEHEIGHT, MainWindowPtr);

    writegadgets();
 // DISCARD ActivateLayoutGadget(gadgets[GID_GOAL_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_GOAL_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void goal_loop(ULONG gid, UNUSED ULONG code)
{   int   whichman;
    ULONG temp;

    switch (gid)
    {
    case GID_GOAL_BU1:
        readgadgets();
        maximize_man(who);
        writegadgets();
    acase GID_GOAL_BU2:
        readgadgets();
        for (whichman = 0; whichman < (int) players[filenum][team]; whichman++)
        {   maximize_man(whichman);
        }
        writegadgets();
    acase GID_GOAL_SL1:
        readgadgets();
        who = code;
        writegadgets();
    acase GID_GOAL_SL2:
        readgadgets();
        team = code;
        writegadgets();
    acase GID_GOAL_SL3:
        readgadgets();
        filenum = code;
        writegadgets();
    acase GID_GOAL_GS1:
    case GID_GOAL_GS2:
    case GID_GOAL_GS3:
    case GID_GOAL_GS4:
    case GID_GOAL_GS5:
    case GID_GOAL_GS6:
    case GID_GOAL_GS7:
    case GID_GOAL_GS8:
        GetAttr(GRAD_CurVal, (Object*) gadgets[gid], &temp);
        stat[filenum][team][who][gid - GID_GOAL_GS1] = (UBYTE) temp;
        SetGadgetAttrs
        (   gadgets[gid - GID_GOAL_GS1 + GID_GOAL_IN1], MainWindowPtr, NULL,
            INTEGER_Number, temp,
        TAG_DONE); // this autorefreshes
    acase GID_GOAL_IN1:
    case GID_GOAL_IN2:
    case GID_GOAL_IN3:
    case GID_GOAL_IN4:
    case GID_GOAL_IN5:
    case GID_GOAL_IN6:
    case GID_GOAL_IN7:
    case GID_GOAL_IN8:
        GetAttr(INTEGER_Number, (Object*) gadgets[gid], &temp);
        stat[filenum][team][who][gid - GID_GOAL_IN1] = (UBYTE) temp;
        SetGadgetAttrs
        (   gadgets[gid - GID_GOAL_IN1 + GID_GOAL_GS1], MainWindowPtr, NULL,
            GRAD_CurVal, temp,
        TAG_DONE); // this autorefreshes
    acase GID_GOAL_PL1:
        GetAttr(PALETTE_Colour, (Object*) gadgets[GID_GOAL_PL1], &colour[filenum][team][0][0]);
        draw1stshirt();
    acase GID_GOAL_PL2:
        GetAttr(PALETTE_Colour, (Object*) gadgets[GID_GOAL_PL2], &colour[filenum][team][0][1]);
        draw1stshirt();
    acase GID_GOAL_PL3:
        GetAttr(PALETTE_Colour, (Object*) gadgets[GID_GOAL_PL3], &colour[filenum][team][1][0]);
        draw2ndshirt();
    acase GID_GOAL_PL4:
        GetAttr(PALETTE_Colour, (Object*) gadgets[GID_GOAL_PL4], &colour[filenum][team][1][1]);
        draw2ndshirt();
}   }

EXPORT FLAG goal_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   int max;

    if
    (   page != FUNC_GOAL
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;

    either_sl(GID_GOAL_SL3, &filenum);
    either_sl(GID_GOAL_SL2, &team);
    max = ((players[filenum][team] >= 1) ? (players[filenum][team] - 1) : 0);
    if ((int) who > max)
    {   who = max;
    }
    either_sl(GID_GOAL_SL1, &who);

    SetGadgetAttrs(gadgets[GID_GOAL_SL1], MainWindowPtr, NULL, SLIDER_Max, max, SLIDER_Ticks, players[filenum][team], TAG_DONE);
    RefreshGadgets((struct Gadget*) gadgets[GID_GOAL_SL1], MainWindowPtr, NULL); // this is needed

    either_gs(GID_GOAL_GS1, &stat[filenum][team][who][0]);
    either_gs(GID_GOAL_GS2, &stat[filenum][team][who][1]);
    either_gs(GID_GOAL_GS3, &stat[filenum][team][who][2]);
    either_gs(GID_GOAL_GS4, &stat[filenum][team][who][3]);
    either_gs(GID_GOAL_GS5, &stat[filenum][team][who][4]);
    either_gs(GID_GOAL_GS6, &stat[filenum][team][who][5]);
    either_gs(GID_GOAL_GS7, &stat[filenum][team][who][6]);
    either_gs(GID_GOAL_GS8, &stat[filenum][team][who][7]);

    draw1stshirt();
    draw2ndshirt();

    eithergadgets();
}

MODULE void eithergadgets(void)
{   either_st(GID_GOAL_ST4,     vfilename[filenum]);
    either_st(GID_GOAL_ST2,      teamname[filenum][team]);
    either_st(GID_GOAL_ST3,   managername[filenum][team]);
    either_st(GID_GOAL_ST1,    playername[filenum][team][who]);

    either_pl(GID_GOAL_PL1,  &colour[     filenum][team]     [0][0]);
    either_pl(GID_GOAL_PL2,  &colour[     filenum][team]     [0][1]);
    either_pl(GID_GOAL_PL3,  &colour[     filenum][team]     [1][0]);
    either_pl(GID_GOAL_PL4,  &colour[     filenum][team]     [1][1]);

    either_ch(GID_GOAL_CH2,  &formation[  filenum][team]);
    either_in(GID_GOAL_IN9,  &shirt[      filenum][team][who]);
    either_ch(GID_GOAL_CH1,  &position[   filenum][team][who]);
    either_in(GID_GOAL_IN1,  &stat[       filenum][team][who][0]);
    either_in(GID_GOAL_IN2,  &stat[       filenum][team][who][1]);
    either_in(GID_GOAL_IN3,  &stat[       filenum][team][who][2]);
    either_in(GID_GOAL_IN4,  &stat[       filenum][team][who][3]);
    either_in(GID_GOAL_IN5,  &stat[       filenum][team][who][4]);
    either_in(GID_GOAL_IN6,  &stat[       filenum][team][who][5]);
    either_in(GID_GOAL_IN7,  &stat[       filenum][team][who][6]);
    either_in(GID_GOAL_IN8,  &stat[       filenum][team][who][7]);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int whichfile,
        whichteam,
        whichman;

    for (whichfile = 0; whichfile < FILES; whichfile++)
    {   offset = 0x410 + (whichfile * 16);

        if (serializemode == SERIALIZE_READ)
        {   zstrncpy(vfilename[whichfile], (char*) &IOBuffer[offset], 15);
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            zstrncpy((char*) &IOBuffer[offset], vfilename[whichfile], 15);
    }   }

    for (whichfile = 0; whichfile < FILES; whichfile++)
    {   offset = 0x1004 + (whichfile * 23040);

        for (whichteam = 0; whichteam < 32; whichteam++)
        {   if (serializemode == SERIALIZE_READ)
            {   zstrncpy(teamname[whichfile][whichteam], (char*) &IOBuffer[offset], 19);
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                zstrncpy((char*) &IOBuffer[offset], teamname[whichfile][whichteam], 19);
            }
            offset += 20;
            if (serializemode == SERIALIZE_READ)
            {   zstrncpy(managername[whichfile][whichteam], (char*) &IOBuffer[offset], 19);
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                zstrncpy((char*) &IOBuffer[offset], managername[whichfile][whichteam], 19);
            }
            offset += 21;
            serialize1(&formation[whichfile][whichteam]);
            offset++;
            serialize1(&players[  whichfile][whichteam]);
            serialize1(&colour[   whichfile][whichteam][0][0]);
            serialize1(&colour[   whichfile][whichteam][0][1]);
            serialize1(&style[    whichfile][whichteam][0]);
            serialize1(&colour[   whichfile][whichteam][1][0]);
            serialize1(&colour[   whichfile][whichteam][1][1]);
            serialize1(&style[    whichfile][whichteam][1]);

            for (whichman = 0; whichman < (int) players[whichfile][whichteam]; whichman++)
            {   if (serializemode == SERIALIZE_READ)
                {   zstrncpy(playername[whichfile][whichteam][whichman], (char*) &IOBuffer[offset], 15);
                } else
                {   // assert(serializemode == SERIALIZE_WRITE);
                    zstrncpy((char*) &IOBuffer[offset], playername[whichfile][whichteam][whichman], 15);
                }
                offset += 16;                              
                serialize1(&position[whichfile][whichteam][whichman]);
                serialize1(&shirt[   whichfile][whichteam][whichman]);
                offset++;
                serialize1(&stat[    whichfile][whichteam][whichman][0]); 
                serialize1(&stat[    whichfile][whichteam][whichman][1]); 
                serialize1(&stat[    whichfile][whichteam][whichman][3]); 
                serialize1(&stat[    whichfile][whichteam][whichman][2]); 
                serialize1(&stat[    whichfile][whichteam][whichman][6]); 
                serialize1(&stat[    whichfile][whichteam][whichman][7]); 
                serialize1(&stat[    whichfile][whichteam][whichman][5]); 
                serialize1(&stat[    whichfile][whichteam][whichman][4]); 
                offset++;
}   }   }   }

EXPORT void goal_save(FLAG saveas)
{   PERSIST   FLAG worn[       14 + 1]; // PERSISTent to avoid a spurious SAS/C warning
    PERSIST   TEXT tempstring[256 + 1]; // PERSISTent so as not to blow the stack
    TRANSIENT int  whichfile,
                   whichteam,
                   whichman,
                   whichshirt;

    readgadgets();

    // check shirts
    for (whichfile = 0; whichfile < FILES; whichfile++)
    {   if (vfilename[whichfile][0] != EOS)
        {   for (whichteam = 0; whichteam < TEAMS; whichteam++)
            {   for (whichshirt = 1; whichshirt <= 14; whichshirt++)
                {   worn[whichshirt] = FALSE;
                }
                for (whichman = 0; whichman < (int) players[whichfile][whichteam]; whichman++)
                {   if
                    (   shirt[whichfile][whichteam][whichman] == 13
                     || shirt[whichfile][whichteam][whichman] >  14
                    )
                    {   sprintf
                        (   tempstring,
                            "File \"%s\", team \"%s\", player \"%s\":\n" \
                            "Can't save, because player is wearing shirt #%ld!",
                            vfilename[ whichfile],
                            teamname[  whichfile][whichteam],
                            playername[whichfile][whichteam][whichman],
                            shirt[     whichfile][whichteam][whichman]
                        );
                        say(tempstring, REQIMAGE_WARNING);
                        return;
                    }
                    if
                    (   shirt[whichfile][whichteam][whichman] != 0
                     && worn[shirt[whichfile][whichteam][whichman]]
                    )
                    {   sprintf
                        (   tempstring,
                            "File \"%s\", team \"%s\", player \"%s\":\n" \
                            "Can't save, because player is sharing shirt #%ld!",
                            vfilename[ whichfile],
                            teamname[  whichfile][whichteam],
                            playername[whichfile][whichteam][whichman],
                            shirt[whichfile][whichteam][whichman]
                        );
                        say(tempstring, REQIMAGE_WARNING);
                        return;
                    }
                    worn[shirt[whichfile][whichteam][whichman]] = TRUE;
                }
                for (whichshirt = 1; whichshirt <= 14; whichshirt++)
                {   if
                    (   whichshirt != 13
                     && !worn[whichshirt]
                    )
                    {   sprintf
                        (   tempstring,
                            "File #%d (\"%s\"), team #%d (\"%s\"):\n" \
                            "Can't save, because shirt #%d is not being worn!",
                            whichfile, vfilename[whichfile],
                            whichteam, teamname[ whichfile][whichteam],
                            whichshirt
                        );
                        say(tempstring, REQIMAGE_WARNING);
                        return;
    }   }   }   }   }
    
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?", "Goal!", saveas, 901120, FLAG_S, FALSE);
}

EXPORT void goal_close(void) { ; }
EXPORT void goal_exit(void)  { ; }

MODULE void maximize_man(int whichman)
{   int i;

    for (i = 0; i < 8; i++)
    {   stat[filenum][team][whichman][i] = 209;
}   }

EXPORT void goal_key(UBYTE scancode, UWORD qual)
{   int max;

    switch (scancode)
    {
    case SCAN_LEFT:
        readgadgets();
        if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
        {   who = 0;
        } elif (who == 0)
        {   if (team == 0)
            {   team = TEAMS - 1;
                if (filenum == 0)
                {   filenum = FILES - 1;
                } else
                {   filenum--;
            }   }
            else
            {   team--;
            }
            /* max = */ who = ((players[filenum][team] >= 1) ? (players[filenum][team] - 1) : 0);
        } else
        {   who--;
        }
        writegadgets();
    acase SCAN_RIGHT:
        readgadgets();
        max = ((players[filenum][team] >= 1) ? (players[filenum][team] - 1) : 0);
        if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT))
        {   who = max;
        } elif ((int) who == max)
        {   if (team == TEAMS - 1)
            {   team = 0;
                if (filenum == FILES - 1)
                {   filenum = 0;
                } else
                {   filenum++;
            }   }
            else
            {   team++;
            }
            who = 0;
        } else
        {   who++;
        }
        writegadgets();
}   }

EXPORT void goal_getpens(void)
{   int i;

    lockscreen();

    for (i = 0; i < 2; i++)
    {   pens[(i * 16) +  0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xAAAAAAAA, -1);
        pens[(i * 16) +  1] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x33333333, 0xDDDDDDDD, -1);
        pens[(i * 16) +  2] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x44444444, 0x77777777, 0xFFFFFFFF, -1);
        pens[(i * 16) +  3] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xBBBBBBBB, 0xBBBBBBBB, -1);
        pens[(i * 16) +  4] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xEEEEEEEE, 0xEEEEEEEE, 0xEEEEEEEE, -1);
        pens[(i * 16) +  5] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x77777777, 0x77777777, 0x77777777, -1);
        pens[(i * 16) +  6] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x55555555, 0x55555555, 0x55555555, -1);
        pens[(i * 16) +  8] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x00000000, 0x00000000, -1);
        pens[(i * 16) +  9] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xBBBBBBBB, 0x22222222, 0x00000000, -1);
        pens[(i * 16) + 10] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xDDDDDDDD, 0x00000000, 0x00000000, -1);
        pens[(i * 16) + 11] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xEEEEEEEE, 0x88888888, 0x00000000, -1);
        pens[(i * 16) + 12] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xEEEEEEEE, 0x00000000, -1);
        pens[(i * 16) + 13] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x77777777, 0xBBBBBBBB, -1);
        pens[(i * 16) + 14] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x99999999, 0x00000000, 0x99999999, -1);
        pens[(i * 16) + 15] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x44444444, 0xCCCCCCCC, 0x44444444, -1);
    }
    pens[                7] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x66666666, 0x66666666, 0x66666666, -1);
    pens[               23] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1);

    for (i =  0; i <   8; i++) sliderpens[i] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x77777777, 0x44444444, 0x88888888, -1); // purple
    for (i =  8; i <  18; i++) sliderpens[i] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x11111111, 0xAAAAAAAA, 0x11111111, -1); // dark green
    for (i = 18; i <  28; i++) sliderpens[i] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x44444444, 0xEEEEEEEE, 0x44444444, -1); // light green
    for (i = 28; i <  38; i++) sliderpens[i] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xAAAAAAAA, -1); // yellow
    for (i = 38; i <  43; i++) sliderpens[i] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x99999999, 0x55555555, -1); // orange
    for (i = 43; i <= 52; i++) sliderpens[i] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1); // red
    sliderpens[53] = (UWORD) ~0;

    unlockscreen();
}

EXPORT void goal_uniconify(void)
{   goal_getpens();
    goal_resize();
}

MODULE void draw1stshirt(void)
{   int  bgc,
         effect,
         topleft, bottomright,
         thestyle,
         x, y;
    TEXT whichpen;

    if (hoverover == 1)
    {   topleft     = DrawInfoPtr->dri_Pens[SHADOWPEN];
        bottomright = DrawInfoPtr->dri_Pens[SHINEPEN];
        bgc         = DrawInfoPtr->dri_Pens[FILLPEN];
        effect      = 1;
        thestyle    = newstyle;
    } else
    {   topleft     = DrawInfoPtr->dri_Pens[SHINEPEN];
        bottomright = DrawInfoPtr->dri_Pens[SHADOWPEN];
        bgc         = DrawInfoPtr->dri_Pens[BACKGROUNDPEN];
        effect      = 0;
        thestyle    = style[filenum][team][0];
    }

    for (y = 0; y < STYLEHEIGHT; y++)
    {   for (x = 0; x < STYLEWIDTH; x++)
        {   *(byteptr1[y] + x) = bgc;
    }   }
    for (x = 0; x < STYLEWIDTH; x++)
    {   *(byteptr1[              0] + x) = topleft;
        *(byteptr1[STYLEHEIGHT - 1] + x) = bottomright;
    }
    for (y = 0; y < STYLEHEIGHT; y++)
    {   *(byteptr1[y]                 ) = topleft;
        *(byteptr1[y] + STYLEWIDTH - 1) = bottomright;
    }

    for (y = 0; y < 23; y++)
    {   for (x = 0; x < 27; x++)
        {   whichpen = StyleData[thestyle][y][x];
            switch (whichpen)
            {
            case  '#': *(byteptr1[y + STYLEYMARGIN + effect] + x + STYLEXMARGIN + effect) = pens[23]; // black
            acase 'Y': *(byteptr1[y + STYLEYMARGIN + effect] + x + STYLEXMARGIN + effect) = pens[colour[filenum][team][0][0]];
            acase 'G': *(byteptr1[y + STYLEYMARGIN + effect] + x + STYLEXMARGIN + effect) = pens[colour[filenum][team][0][1]];
    }   }   }
    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_GOAL_SP1]->LeftEdge,
        gadgets[GID_GOAL_SP1]->TopEdge,
        gadgets[GID_GOAL_SP1]->LeftEdge + STYLEWIDTH  - 1,
        gadgets[GID_GOAL_SP1]->TopEdge  + STYLEHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );
}

MODULE void draw2ndshirt(void)
{   int  bgc,
         effect,
         topleft, bottomright,
         thestyle,
         x, y;
    TEXT whichpen;

    if (hoverover == 2)
    {   topleft     = DrawInfoPtr->dri_Pens[SHADOWPEN];
        bottomright = DrawInfoPtr->dri_Pens[SHINEPEN];
        bgc         = DrawInfoPtr->dri_Pens[FILLPEN];
        effect      = 1;
        thestyle    = newstyle;
    } else
    {   topleft     = DrawInfoPtr->dri_Pens[SHINEPEN];
        bottomright = DrawInfoPtr->dri_Pens[SHADOWPEN];
        bgc         = DrawInfoPtr->dri_Pens[BACKGROUNDPEN];
        effect      = 0;
        thestyle    = style[filenum][team][1];
    }

    for (y = 0; y < STYLEHEIGHT; y++)
    {   for (x = 0; x < STYLEWIDTH; x++)
        {   *(byteptr2[y] + x) = bgc;
    }   }
    for (x = 0; x < STYLEWIDTH; x++)
    {   *(byteptr2[              0] + x) = topleft;
        *(byteptr2[STYLEHEIGHT - 1] + x) = bottomright;
    }
    for (y = 0; y < STYLEHEIGHT; y++)
    {   *(byteptr2[y]                 ) = topleft;
        *(byteptr2[y] + STYLEWIDTH - 1) = bottomright;
    }

    for (y = 0; y < 23; y++)
    {   for (x = 0; x < 27; x++)
        {   whichpen = StyleData[thestyle][y][x];
            switch (whichpen)
            {
            case  '#': *(byteptr2[y + STYLEYMARGIN + effect] + x + STYLEXMARGIN + effect) = pens[23]; // black
            acase 'Y': *(byteptr2[y + STYLEYMARGIN + effect] + x + STYLEXMARGIN + effect) = pens[colour[filenum][team][1][0]];
            acase 'G': *(byteptr2[y + STYLEYMARGIN + effect] + x + STYLEXMARGIN + effect) = pens[colour[filenum][team][1][1]];
    }   }   }
    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_GOAL_SP2]->LeftEdge,
        gadgets[GID_GOAL_SP2]->TopEdge,
        gadgets[GID_GOAL_SP2]->LeftEdge + STYLEWIDTH  - 1,
        gadgets[GID_GOAL_SP2]->TopEdge  + STYLEHEIGHT - 1,
        display2,
        &wpa8rastport[1]
    );
}

// Used  are: A   EFGHI KLMNOP RST       12
// Spare are:  BCD     J      Q   UVWXYZ0  3456789

EXPORT void goal_mouse(SWORD mousex, SWORD mousey)
{   if (lmb == 1)
    {   if (hoverover == 1)
        {   if (!mouseisover(GID_GOAL_SP1, mousex, mousey))
            {   hoverover = 0;
                draw1stshirt();
        }   }
        else
        {   if (mouseisover(GID_GOAL_SP1, mousex, mousey))
            {   hoverover = 1;
                draw1stshirt();
    }   }   }
    elif (lmb == 2)
    {   if (hoverover == 2)
        {   if (!mouseisover(GID_GOAL_SP2, mousex, mousey))
            {   hoverover = 0;
                draw2ndshirt();
        }   }
        else
        {   if (mouseisover(GID_GOAL_SP2, mousex, mousey))
            {   hoverover = 2;
                draw2ndshirt();
}   }   }   }

EXPORT void goal_lmb(SWORD mousex, SWORD mousey, UWORD code)
{   ULONG qual;

    if (mouseisover(GID_GOAL_SP1, mousex, mousey))
    {   if (code == SELECTDOWN)
        {   lmb = hoverover = 1;
            GetAttr(WINDOW_Qualifier, WinObject, &qual);
            if (qual & (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT))
            {   if (style[filenum][team][0] == 0)
                {   newstyle = 5;
                } else
                {   newstyle = style[filenum][team][0] - 1;
            }   }
            else
            {   if (style[filenum][team][0] == 5)
                {   newstyle = 0;
                } else
                {   newstyle = style[filenum][team][0] + 1;
        }   }   }
        elif (code == SELECTUP)
        {   if (lmb == 1 && hoverover == 1)
            {   style[filenum][team][0] = newstyle;
            }
            lmb = hoverover = 0;
        }
        draw1stshirt();
    } elif (mouseisover(GID_GOAL_SP2, mousex, mousey))
    {   if (code == SELECTDOWN)
        {   lmb = hoverover = 2;
            GetAttr(WINDOW_Qualifier, WinObject, &qual);
            if (qual & (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT))
            {   if (style[filenum][team][1] == 0)
                {   newstyle = 5;
                } else
                {   newstyle = style[filenum][team][1] - 1;
            }   }
            else
            {   if (style[filenum][team][1] == 5)
                {   newstyle = 0;
                } else
                {   newstyle = style[filenum][team][1] + 1;
        }   }   }
        elif (code == SELECTUP)
        {   if (lmb == 2 && hoverover == 2)
            {   style[filenum][team][1] = newstyle;
            }
            lmb = hoverover = 0;
        }
        draw2ndshirt();
    } elif (code == SELECTUP)
    {   lmb = hoverover = 0;
}   }

EXPORT void goal_resize(void)
{   draw1stshirt();
    draw2ndshirt();
}

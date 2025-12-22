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

#define GID_EPYX_LY1     0 // root layout
#define GID_EPYX_SB1     1 // toolbar
#define GID_EPYX_BU1     2 // clear high scores
#define GID_EPYX_CH1     3 // game

#define GID_CAL1_ST1     4
#define GID_CAL1_ST2     5
#define GID_CAL1_ST3     6
#define GID_CAL1_ST4     7
#define GID_CAL1_ST5     8
#define GID_CAL1_ST6     9
#define GID_CAL1_IN1    10
#define GID_CAL1_IN2    11
#define GID_CAL1_IN3    12
#define GID_CAL1_IN4    13
#define GID_CAL1_IN5    14
#define GID_CAL1_IN6    15
#define GID_CAL1_IN7    16

#define GID_WINTER_IN1  17 // hot dog ones                    (0..10)
#define GID_WINTER_IN2  18 // hot dog tenths                  (0.. 9)
#define GID_WINTER_IN3  19 // biathlon minutes                (0..9?)
#define GID_WINTER_IN4  20 // biathlon seconds                (0..59)
#define GID_WINTER_IN5  21 // speed skating minutes           (0..9?)
#define GID_WINTER_IN6  22 // speed skating seconds           (0..59)
#define GID_WINTER_IN7  23 // speed skating tenths of seconds (0.. 9)
#define GID_WINTER_IN8  24 // figure skating ones             (0..10)
#define GID_WINTER_IN9  25 // figure skating tenths           (0.. 9)
#define GID_WINTER_IN10 26 // ski jump integer part           (0.. ?)
#define GID_WINTER_IN11 27 // ski jump tenths                 (0.. 9)
#define GID_WINTER_IN12 28 // freestyle skating ones          (0..10)
#define GID_WINTER_IN13 29 // freestyle skating tenths        (0.. 9)
#define GID_WINTER_IN14 30 // bobsled integer part            (0.. ?)
#define GID_WINTER_IN15 31 // bobsled tenths                  (0.. 9)
#define GID_WINTER_ST1  32
#define GID_WINTER_ST2  33
#define GID_WINTER_ST3  34
#define GID_WINTER_ST4  35
#define GID_WINTER_ST5  36
#define GID_WINTER_ST6  37
#define GID_WINTER_ST7  38

#define GID_WORLD_ST1   39
#define GID_WORLD_ST2   40
#define GID_WORLD_ST3   41
#define GID_WORLD_ST4   42
#define GID_WORLD_ST5   43
#define GID_WORLD_ST6   44
#define GID_WORLD_ST7   45
#define GID_WORLD_ST8   46
#define GID_WORLD_ST9   47
#define GID_WORLD_ST10  48
#define GID_WORLD_ST11  49
#define GID_WORLD_ST12  50
#define GID_WORLD_ST13  51
#define GID_WORLD_ST14  52
#define GID_WORLD_ST15  53
#define GID_WORLD_ST16  54

#define GID_CAL2_ST1    55
#define GID_CAL2_ST2    56
#define GID_CAL2_ST3    57
#define GID_CAL2_ST4    58
#define GID_CAL2_ST5    59
#define GID_CAL2_IN1    60
#define GID_CAL2_IN2    61
#define GID_CAL2_IN3    62
#define GID_CAL2_IN4    63
#define GID_CAL2_IN5    64
#define GID_CAL2_IN6    65
#define GID_CAL2_IN7    66
#define GID_CAL2_IN8    67
#define GID_CAL2_IN9    68

#define GIDS_EPYX       GID_CAL2_IN9

#define CALIFORNIA1      0
#define CALIFORNIA2      1
#define WINTER           2
#define WORLD            3

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void clearscores(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra;
IMPORT LONG                 gamesize;
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
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                game,
                            cal1_score[7],
                            cal2_score[9],
                            winter_score[7];
MODULE TEXT                 cal1_name[6][10 + 1],
                            cal2_name[5][9 + 1],
                            winter_name[7][10 + 1],
                            world_name[8][16 + 1],
                            world_score[8][7 + 1];

MODULE const STRPTR GameOptions[4 + 1] =
{ "California Games 1",
  "California Games 2",
  "Winter Games",
  "World Games",
  NULL
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void epyx_main(void)
{   tool_open  = epyx_open;
    tool_loop  = epyx_loop;
    tool_save  = epyx_save;
    tool_close = epyx_close;
    tool_exit  = epyx_exit;

    if (loaded != FUNC_EPYX && !epyx_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_EPYX;

    make_speedbar_list(GID_EPYX_SB1);
    load_aiss_images(9, 9);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_EPYX_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            AddHLayout,
                AddToolbar(GID_EPYX_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_EPYX_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_EPYX_CH1,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "California Games 1",
                AddHLayout,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL1_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal1_name[0],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Half Pipe:"),
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_ST2] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL1_ST2,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal1_name[1],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Foot Bag:"),
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_ST3] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL1_ST3,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal1_name[2],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Surfing:"),
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_ST4] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL1_ST4,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal1_name[3],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Skating:"),
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_ST5] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL1_ST5,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal1_name[4],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("BMX Racing:"),
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_ST6] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL1_ST6,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal1_name[5],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Flying Disk:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_CAL1_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_CAL1_IN2,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_CAL1_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_CAL1_IN3,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           10,
                                INTEGER_MinVisible,        2 + 1, // we could allow higher than 10.0 (up to 9999.9)
                            IntegerEnd,
                            CHILD_WeightedWidth,           50,
                            AddLabel("."),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_CAL1_IN7] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_CAL1_IN7,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_MinVisible,        1 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           50,
                        LayoutEnd,
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_IN4] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_CAL1_IN4,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_CAL1_IN5,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_CAL1_IN6] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_CAL1_IN6,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999,
                            INTEGER_MinVisible,            6 + 1,
                        IntegerEnd,
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "California Games 2",
                AddHLayout,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_CAL2_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL2_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal2_name[0],
                            STRINGA_MaxChars,              9 + 1,
                            STRINGA_MinVisible,            9 + stringextra,
                        StringEnd,
                        Label("Hang Gliding:"),
                        LAYOUT_AddChild,                   gadgets[GID_CAL2_ST2] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL2_ST2,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal2_name[1],
                            STRINGA_MaxChars,              9 + 1,
                            STRINGA_MinVisible,            9 + stringextra,
                        StringEnd,
                        Label("Snowboarding:"),
                        LAYOUT_AddChild,                   gadgets[GID_CAL2_ST3] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL2_ST3,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal2_name[2],
                            STRINGA_MaxChars,              9 + 1,
                            STRINGA_MinVisible,            9 + stringextra,
                        StringEnd,
                        Label("Bodyboarding:"),
                        LAYOUT_AddChild,                   gadgets[GID_CAL2_ST4] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL2_ST4,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal2_name[3],
                            STRINGA_MaxChars,              9 + 1,
                            STRINGA_MinVisible,            9 + stringextra,
                        StringEnd,
                        Label("Skateboarding:"),
                        LAYOUT_AddChild,                   gadgets[GID_CAL2_ST5] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_CAL2_ST5,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               cal2_name[4],
                            STRINGA_MaxChars,              9 + 1,
                            STRINGA_MinVisible,            9 + stringextra,
                        StringEnd,
                        Label("Jet Surfing:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_CAL2_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_CAL2_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_CAL2_IN2] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_CAL2_IN2,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           5,
                                INTEGER_MinVisible,        1 + 1,
                            IntegerEnd,
                            AddLabel(":"),
                            LAYOUT_AddChild,               gadgets[GID_CAL2_IN6] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_CAL2_IN6,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           59,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            AddLabel("."),
                            LAYOUT_AddChild,               gadgets[GID_CAL2_IN7] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_CAL2_IN7,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        LAYOUT_AddChild,                   gadgets[GID_CAL2_IN3] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_CAL2_IN3,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_CAL2_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_CAL2_IN4,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           5,
                                INTEGER_MinVisible,        1 + 1,
                            IntegerEnd,
                            AddLabel(":"),
                            LAYOUT_AddChild,               gadgets[GID_CAL2_IN8] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_CAL2_IN8,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           59,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            AddLabel("."),
                            LAYOUT_AddChild,               gadgets[GID_CAL2_IN9] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_CAL2_IN9,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        LAYOUT_AddChild,                   gadgets[GID_CAL2_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_CAL2_IN5,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Winter Games",
                AddHLayout,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_WINTER_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WINTER_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               winter_name[0],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Hot Dog:"),
                        LAYOUT_AddChild,                   gadgets[GID_WINTER_ST2] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WINTER_ST2,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               winter_name[1],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Biathlon:"),
                        LAYOUT_AddChild,                   gadgets[GID_WINTER_ST3] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WINTER_ST3,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               winter_name[2],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Speed Skating:"),
                        LAYOUT_AddChild,                   gadgets[GID_WINTER_ST4] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WINTER_ST4,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               winter_name[3],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Figure Skating:"),
                        LAYOUT_AddChild,                   gadgets[GID_WINTER_ST5] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WINTER_ST5,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               winter_name[4],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Ski Jump:"),
                        LAYOUT_AddChild,                   gadgets[GID_WINTER_ST6] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WINTER_ST6,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               winter_name[5],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Freestyle Skating:"),
                        LAYOUT_AddChild,                   gadgets[GID_WINTER_ST7] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WINTER_ST7,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               winter_name[6],
                            STRINGA_MaxChars,              10 + 1,
                            STRINGA_MinVisible,            10 + stringextra,
                        StringEnd,
                        Label("Bobsled:"),
                    LayoutEnd,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddSpace,
                            CHILD_WeightedWidth,           33,
                            AddLabel(" "),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN1] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN1,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           10,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                            AddLabel("."),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN2] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN2,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN3,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                            AddLabel(":"),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN4,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           59,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                            AddLabel(" "),
                            CHILD_WeightedWidth,           0,
                            AddSpace,
                            CHILD_WeightedWidth,           33,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN5] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN5,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                            AddLabel(":"),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN6] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN6,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           59,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                            AddLabel("."),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN7] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN7,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddSpace,
                            CHILD_WeightedWidth,           33,
                            AddLabel(" "),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN8] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN8,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           10,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                            AddLabel("."),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN9] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN9,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddSpace,
                            CHILD_WeightedWidth,           33,
                            AddLabel(" "),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN10] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN10,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           3275,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                            AddLabel("."),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN11] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN11,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddSpace,
                            CHILD_WeightedWidth,           33,
                            AddLabel(" "),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN12] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN12,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           10,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                            AddLabel("."),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN13] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN13,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddSpace,
                            CHILD_WeightedWidth,           33,
                            AddLabel(" "),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN14] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN14,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           3275,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                            AddLabel("."),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_WINTER_IN15] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_WINTER_IN15,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9,
                                INTEGER_MinVisible,        4 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           33,
                        LayoutEnd,
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "World Games",
                AddHLayout,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_name[0],
                            STRINGA_MaxChars,              16 + 1,
                            STRINGA_MinVisible,            16 + stringextra,
                        StringEnd,
                        Label("Weight Lifting:"),
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST2] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST2,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_name[1],
                            STRINGA_MaxChars,              16 + 1,
                            STRINGA_MinVisible,            16 + stringextra,
                        StringEnd,
                        Label("Cliff Diving:"),
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST3] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST3,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_name[2],
                            STRINGA_MaxChars,              16 + 1,
                            STRINGA_MinVisible,            16 + stringextra,
                        StringEnd,
                        Label("Barrel Jumping:"),
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST4] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST4,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_name[3],
                            STRINGA_MaxChars,              16 + 1,
                            STRINGA_MinVisible,            16 + stringextra,
                        StringEnd,
                        Label("Bull Riding:"),
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST5] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST5,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_name[4],
                            STRINGA_MaxChars,              16 + 1,
                            STRINGA_MinVisible,            16 + stringextra,
                        StringEnd,
                        Label("Log Rolling:"),
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST6] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST6,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_name[5],
                            STRINGA_MaxChars,              16 + 1,
                            STRINGA_MinVisible,            16 + stringextra,
                        StringEnd,
                        Label("Slalom Skiing:"),
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST7] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST7,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_name[6],
                            STRINGA_MaxChars,              16 + 1,
                            STRINGA_MinVisible,            16 + stringextra,
                        StringEnd,
                        Label("Caber Toss:"),
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST8] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST8,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_name[7],
                            STRINGA_MaxChars,              16 + 1,
                            STRINGA_MinVisible,            16 + stringextra,
                        StringEnd,
                        Label("Sumo Wrestling:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST9] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST9,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_score[0],
                            STRINGA_MaxChars,              7 + 1,
                            STRINGA_MinVisible,            7 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST10] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST10,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_score[1],
                            STRINGA_MaxChars,              7 + 1,
                            STRINGA_MinVisible,            7 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST11] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST11,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_score[2],
                            STRINGA_MaxChars,              7 + 1,
                            STRINGA_MinVisible,            7 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST12] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST12,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_score[3],
                            STRINGA_MaxChars,              7 + 1,
                            STRINGA_MinVisible,            7 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST13] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST13,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_score[4],
                            STRINGA_MaxChars,              7 + 1,
                            STRINGA_MinVisible,            7 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST14] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST14,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_score[5],
                            STRINGA_MaxChars,              7 + 1,
                            STRINGA_MinVisible,            7 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST15] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST15,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_score[6],
                            STRINGA_MaxChars,              7 + 1,
                            STRINGA_MinVisible,            7 + stringextra,
                        StringEnd,
                        LAYOUT_AddChild,                   gadgets[GID_WORLD_ST16] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_WORLD_ST16,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               world_score[7],
                            STRINGA_MaxChars,              7 + 1,
                            STRINGA_MinVisible,            7 + stringextra,
                        StringEnd,
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            ClearButton(GID_EPYX_BU1, "Clear High Scores"),
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_EPYX_SB1);
    writegadgets();
    switch (game)
    {
    case  CALIFORNIA1: DISCARD ActivateLayoutGadget(gadgets[GID_EPYX_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_CAL1_ST1]);
    acase CALIFORNIA2: DISCARD ActivateLayoutGadget(gadgets[GID_EPYX_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_CAL2_ST1]);
    acase WINTER:      DISCARD ActivateLayoutGadget(gadgets[GID_EPYX_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_WINTER_ST1]);
    acase WORLD:       DISCARD ActivateLayoutGadget(gadgets[GID_EPYX_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_WORLD_ST1]);
    }
    loop();
    readgadgets();
    closewindow();
}

EXPORT void epyx_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_EPYX_BU1:
        clearscores();
        writegadgets();
}   }

EXPORT FLAG epyx_open(FLAG loadas)
{   if (gameopen(loadas))
    {   switch (gamesize)
        {
        case    98: game = WINTER;
        acase  162: game = CALIFORNIA1;
        acase  474: game = WORLD;
        acase 9432: game = CALIFORNIA2;
        adefault:
            DisplayBeep(NULL);
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
{   int gid;

    if
    (   page != FUNC_EPYX
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    either_ch(GID_EPYX_CH1, &game); // this autorefreshes

    for (gid = GID_CAL1_ST1; gid <= GID_CAL1_IN7; gid++)
    {   ghost(gid, game != CALIFORNIA1);
        RefreshGadgets((struct Gadget*) gadgets[gid], MainWindowPtr, NULL); // needed
    }
    for (gid = GID_CAL2_ST1; gid <= GID_CAL2_IN9; gid++)
    {   ghost(gid, game != CALIFORNIA2);
        RefreshGadgets((struct Gadget*) gadgets[gid], MainWindowPtr, NULL); // needed
    }
    for (gid = GID_WINTER_IN1; gid <= GID_WINTER_IN15; gid++)
    {   ghost(gid, game != WINTER);
        RefreshGadgets((struct Gadget*) gadgets[gid], MainWindowPtr, NULL); // needed
    }
    for (gid = GID_WINTER_ST1; gid <= GID_WINTER_ST7; gid++)
    {   ghost(gid, game != WINTER);
        RefreshGadgets((struct Gadget*) gadgets[gid], MainWindowPtr, NULL); // needed
    }

    for (gid = GID_WORLD_ST1; gid <= GID_WORLD_ST16; gid++)
    {   ghost(gid, game != WORLD);
        RefreshGadgets((struct Gadget*) gadgets[gid], MainWindowPtr, NULL); // needed
}   }

MODULE void eithergadgets(void)
{   TRANSIENT int   i;
    PERSIST   ULONG usergad[15];

    switch (game)
    {
    case CALIFORNIA1:
        for (i = 0; i < 6; i++)
        {   either_st(GID_CAL1_ST1   + i,  cal1_name[i]);
        }
        for (i = 0; i < 7; i++)
        {   either_in(GID_CAL1_IN1   + i, &cal1_score[i]);
        }
    acase CALIFORNIA2:
        for (i = 0; i < 5; i++)
        {   either_st(GID_CAL2_ST1   + i,  cal2_name[i]);
        }
        for (i = 0; i < 9; i++)
        {   either_in(GID_CAL2_IN1   + i, &cal2_score[i]);
        }
    acase WINTER:
        for (i = 0; i < 7; i++)
        {   either_st(GID_WINTER_ST1 + i,  winter_name[i]);
        }

        if (gadmode == SERIALIZE_WRITE)
        {   usergad[ 0] =  winter_score[0] /   10;
            usergad[ 1] =  winter_score[0] %   10;
            usergad[ 2] =  winter_score[1] /  100;
            usergad[ 3] =  winter_score[1] %  100;
            usergad[ 4] =  winter_score[2] / 1000;
            usergad[ 5] = (winter_score[2] % 1000) / 10;
            usergad[ 6] =  winter_score[2] %   10;
            usergad[ 7] =  winter_score[3] /   10;
            usergad[ 8] =  winter_score[3] %   10;
            usergad[ 9] =  winter_score[4] /   10;
            usergad[10] =  winter_score[4] %   10;
            usergad[11] =  winter_score[5] /   10;
            usergad[12] =  winter_score[5] %   10;
            usergad[13] =  winter_score[6] /   10;
            usergad[14] =  winter_score[6] %   10;
        }
        for (i = 0; i <= 15; i++)
        {   either_in(GID_WINTER_IN1 + i, &usergad[i]);
        }
        if (gadmode == SERIALIZE_READ)
        {   winter_score[0] = (usergad[ 0] *   10) +  usergad[ 1];
            winter_score[1] = (usergad[ 2] *  100) +  usergad[ 3];
            winter_score[2] = (usergad[ 4] * 1000) + (usergad[ 5] * 10) + usergad[6];
            winter_score[3] = (usergad[ 7] *   10) +  usergad[ 8];
            winter_score[4] = (usergad[ 9] *   10) +  usergad[10];
            winter_score[5] = (usergad[11] *   10) +  usergad[12];
            winter_score[6] = (usergad[13] *   10) +  usergad[14];
        }
    acase WORLD:
        for (i = 0; i < 8; i++)
        {   either_st(GID_WORLD_ST1  + i,  world_name[i]);
            either_st(GID_WORLD_ST9  + i,  world_score[i]);
}   }   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int   i, j,
          length;
    FLAG  clearing;
    ULONG tempscore;

    if (game != CALIFORNIA1)
    {   for (i = 0; i < 7; i++)
        {   cal1_score[i] = 0;
        }
        for (i = 0; i < 6; i++)
        {   cal1_name[i][0] = EOS;
    }   }
    if (game != CALIFORNIA2)
    {   for (i = 0; i < 9; i++)
        {   cal2_score[i] = 0;
        }
        for (i = 0; i < 5; i++)
        {   cal2_name[i][0] = EOS;
    }   }
    if (game != WINTER)
    {   for (i = 0; i < 7; i++)
        {   winter_score[i] = 0;
            winter_name[i][0] = EOS;
    }   }
    if (game != WORLD)
    {   for (i = 0; i < 8; i++)
        {   world_score[i][0] =
            world_name[i][0]  = EOS;
    }   }

    switch (game)
    {
    case CALIFORNIA1:
        if (serializemode == SERIALIZE_WRITE)
        {   if (cal1_score[2] == 10)
            {   cal1_score[6] = 0; // 10.1..10.9 -> 10.0
            }
            cal1_score[2] *= 100;
            cal1_score[2] += cal1_score[6] * 10;
        }

        offset = 0;
        for (i = 0; i < 6; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   zstrncpy(cal1_name[i], (const char*) &IOBuffer[offset], 10);
                for (j = 9; j >= 0; j--) // remove trailing spaces
                {   if (cal1_name[i][j] != ' ')
                    {   break;
                    }
                    cal1_name[i][j] = EOS;
                }
                offset += 17;

                cal1_score[i] = ((IOBuffer[offset    ] - '0') * 100000)
                             + ((IOBuffer[offset + 1] - '0') *  10000)
                             + ((IOBuffer[offset + 2] - '0') *   1000)
                             + ((IOBuffer[offset + 3] - '0') *    100)
                             + ((IOBuffer[offset + 4] - '0') *     10)
                             +  (IOBuffer[offset + 5] - '0');
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);

                length = strlen(cal1_name[i]);
                if (length <= 9)
                {   for (j = length; j <= 9; j++) // add trailing spaces
                    {   cal1_name[i][j] = ' ';
                    }
                    cal1_name[i][10] = EOS;
                }
                for (j = 0; j < 10; j++)
                {   IOBuffer[offset + j] = cal1_name[i][j];
                }
                offset += 17;
                for (j = 9; j >= 0; j--) // remove trailing spaces
                {   if (cal1_name[i][j] != ' ')
                    {   break;
                    }
                    cal1_name[i][j] = EOS;
                }

                IOBuffer[offset    ] = '0' + (cal1_score[i] / 100000);
                IOBuffer[offset + 1] = '0' + (cal1_score[i] % 100000) / 10000;
                IOBuffer[offset + 2] = '0' + (cal1_score[i] %  10000) /  1000;
                IOBuffer[offset + 3] = '0' + (cal1_score[i] %   1000) /   100;
                IOBuffer[offset + 4] = '0' + (cal1_score[i] %    100) /    10;
                IOBuffer[offset + 5] = '0' + (cal1_score[i] %     10);
            }
            offset += 10;
        }

        if (serializemode == SERIALIZE_READ)
        {   // eg. 000370 for 3.7
            cal1_score[6] =  (cal1_score[2] % 100) / 10;
            cal1_score[2] /= 100;
        }
    acase CALIFORNIA2:
        cal2_score[1] *= 6000;
        cal2_score[1] += cal2_score[5] * 100;
        cal2_score[1] += cal2_score[6];
        if (cal2_score[1] > 32767)
        {   cal2_score[1] = 32767;
        }

        cal2_score[3] *= 6000;
        cal2_score[3] += cal2_score[7] * 100;
        cal2_score[3] += cal2_score[8];
        if (cal2_score[3] > 32767)
        {   cal2_score[3] = 32767;
        }

        for (i = 0; i < 5; i++) // the game doesn't really mind if this operation isn't done
        {   length = strlen(cal2_name[i]);
            if (length < 9)
            {   for (j = length; j <= 9; j++)
                {   cal2_name[i][j] = ' ';
            }   }
            cal2_name[i][9] = EOS;
        }

        offset = 0x21D2;
        for (i = 0; i < 5; i++)
        {   serialize2ulong(&cal2_score[i]); // $21D2..$21D3
            offset += 34;                    // $21D4..$21F5
            serstring(cal2_name[i]);
            offset += 12;                    // $21F6..$2201
        }

        for (i = 0; i < 5; i++)
        {   for (j = 8; j >= 0; j--)
            {   if (cal2_name[i][j] == ' ')
                {   cal2_name[i][j] = EOS;
                } else
                {   break;
        }   }   }

        tempscore = cal2_score[1];
        cal2_score[1] =  tempscore / 6000       ; // minutes
        cal2_score[5] = (tempscore % 6000) / 100; // seconds
        cal2_score[6] = (tempscore % 6000) % 100; // hundredths of a second

        tempscore = cal2_score[3];
        cal2_score[3] =  tempscore / 6000       ; // minutes
        cal2_score[7] = (tempscore % 6000) / 100; // seconds
        cal2_score[8] = (tempscore % 6000) % 100; // hundredths of a second
    acase WINTER:
        offset = 0;
        for (i = 0; i < 7; i++)
        {   serialize2ulong(&winter_score[i]);
            if (serializemode == SERIALIZE_READ)
            {   strcpy(winter_name[i], (char*) &IOBuffer[offset]);
                // remove spaces
                for (j = 9; j >= 0; j--)
                {   if (winter_name[i][j] == ' ')
                    {   winter_name[i][j] = EOS;
                    } else
                    {   break;
            }   }   }
            else
            {   // add spaces
                clearing = FALSE;
                for (j = 0; j <= 9; j++)
                {   if (!clearing && winter_name[i][j] == EOS)
                    {   clearing = TRUE;
                    }
                    if (clearing)
                    {   winter_name[i][j] = ' ';
                }   }
                zstrncpy((char*) &IOBuffer[offset], winter_name[i], 10);
            }
            offset += 12;
        }
    acase WORLD:
        offset = 0xD8;
        for (i = 0; i < 8; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   strcpy(world_score[i], (char*) &IOBuffer[offset]);
            } else
            {   strcpy((char*) &IOBuffer[offset], world_score[i]);
            }
            offset += 10;
        }

        offset = 0x128;
        for (i = 0; i < 8; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   strcpy(world_name[i], (char*) &IOBuffer[offset]);
            } else
            {   strcpy((char*) &IOBuffer[offset], world_name[i]);
            }
            offset += 17;
}   }   }

EXPORT void epyx_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();

    switch (game)
    {
    case  CALIFORNIA1: gamesave("#?menu.cmp#?", "California Games 1", saveas,  162, FLAG_H, FALSE);
    acase CALIFORNIA2: gamesave("cgii"        , "California Games 2", saveas, 9432, FLAG_H, FALSE);
    acase WINTER:      gamesave("#?WGWR.DAT#?", "Winter Games"      , saveas,   98, FLAG_H, FALSE);
    acase WORLD:       gamesave("#?d0.bin#?"  , "World Games"       , saveas,  474, FLAG_H, FALSE);
    }

    writegadgets();
}

EXPORT void epyx_close(void) { ; }
EXPORT void epyx_exit(void)  { ; }

MODULE void clearscores(void)
{   int i;

    switch (game)
    {
    case CALIFORNIA1:
        for (i = 0; i < 6; i++)
        {   cal1_name[i][0] = EOS;
        }
        for (i = 0; i < 7; i++)
        {   cal1_score[i] = 0;
        }
    acase CALIFORNIA2:
        for (i = 0; i < 5; i++)
        {   cal2_name[i][0] = EOS;
        }
        for (i = 0; i < 9; i++)
        {   cal2_score[i] = 0;
        }
    acase WINTER:
        for (i = 0; i < 7; i++)
        {   winter_name[i][0] = EOS;
            winter_score[i] = 0;
        }
        winter_score[1] =  999; // Biathlon.      Means 9:99
        winter_score[2] = 9999; // Speed skating. Means 9:99.9
        winter_score[6] = 9999; // Bobsled.       Means   99.99
    acase WORLD:
        for (i = 0; i < 8; i++)
        {   strcpy(world_name[i],  "none"   );
            strcpy(world_score[i], "DEFAULT");
}   }   }

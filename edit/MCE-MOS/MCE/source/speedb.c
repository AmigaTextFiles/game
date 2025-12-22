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
#include <gadgets/chooser.h>

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

// main window
#define GID_SPEEDB_LY1     0 // root layout
#define GID_SPEEDB_SB1     1 // toolbar
#define GID_SPEEDB_BU1     2 // maximize
#define GID_SPEEDB_BU2     3 // players...
#define GID_SPEEDB_CB1     4 // playing extra time?
#define GID_SPEEDB_CB2     5 // manager?
#define GID_SPEEDB_CH1     6 // player 1 team
#define GID_SPEEDB_CH2     7 // player 2 team
#define GID_SPEEDB_CH3     8 // conference
#define GID_SPEEDB_CH4     9 // game
#define GID_SPEEDB_ST1    10 //  1st team name
#define GID_SPEEDB_ST16   25 // 16th team name
#define GID_SPEEDB_IN1    26 // player 1 coins
#define GID_SPEEDB_IN2    27 // player 2 coins
#define GID_SPEEDB_IN3    28 // round/week
#define GID_SPEEDB_IN4    29 // weeks
#define GID_SPEEDB_IN5    30 // player 1 stamina
#define GID_SPEEDB_IN6    31 // player 1 power
#define GID_SPEEDB_IN7    32 // player 1 skill
#define GID_SPEEDB_IN8    33 // player 2 stamina
#define GID_SPEEDB_IN9    34 // player 2 power
#define GID_SPEEDB_IN10   35 // player 2 skill
#define GID_SPEEDB_IN11   36 //   1st ladder grid cell
#define GID_SPEEDB_IN122 147 // 112th ladder grid cell

// players subwindow
#define GID_SPEEDB_LY2   148
#define GID_SPEEDB_ST17  149 //  1st player's name
#define GID_SPEEDB_ST28  160 // 12th player's name
#define GID_SPEEDB_IN123 161 //  1st player's grid cell
#define GID_SPEEDB_IN218 256 // 96th player's grid cell
#define GID_SPEEDB_BU3   257
#define GID_SPEEDB_BU4   258

#define GIDS_SPEEDB      GID_SPEEDB_BU4

#define SPEEDBALL1         0
#define SPEEDBALL2         1

#define PLAYERNAMES       30
#define STATGADS           8

#define NameGad(x)          LAYOUT_AddChild, gadgets[GID_SPEEDB_ST1                    + x] = (struct Gadget*) StringObject,  GA_ID, GID_SPEEDB_ST1                    + x, GA_TabCycle, TRUE, STRINGA_TextVal, table[x].name, STRINGA_MinVisible, 7 + stringextra, StringEnd
#define ExtraNameGad(x)     LAYOUT_AddChild, gadgets[GID_SPEEDB_ST1                    + x] = (struct Gadget*) StringObject,  GA_ID, GID_SPEEDB_ST1                    + x, GA_ReadOnly, TRUE, STRINGA_TextVal, "-",           STRINGA_MinVisible, 7 + stringextra, StringEnd
#define GFGad(x)            LAYOUT_AddChild, gadgets[GID_SPEEDB_IN11                   + x] = (struct Gadget*) IntegerObject, GA_ID, GID_SPEEDB_IN11                   + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_MinVisible, 3 + 1, INTEGER_Maximum, 999, IntegerEnd
#define GAGad(x)            LAYOUT_AddChild, gadgets[GID_SPEEDB_IN11  + 16             + x] = (struct Gadget*) IntegerObject, GA_ID, GID_SPEEDB_IN11  + 16             + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_MinVisible, 3 + 1, INTEGER_Maximum, 999, IntegerEnd
#define MFGad(x)            LAYOUT_AddChild, gadgets[GID_SPEEDB_IN11  + 32             + x] = (struct Gadget*) IntegerObject, GA_ID, GID_SPEEDB_IN11  + 32             + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_MinVisible, 3 + 1, IntegerEnd
#define MAGad(x)            LAYOUT_AddChild, gadgets[GID_SPEEDB_IN11  + 48             + x] = (struct Gadget*) IntegerObject, GA_ID, GID_SPEEDB_IN11  + 48             + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_MinVisible, 3 + 1, IntegerEnd
#define MDGad(x)            LAYOUT_AddChild, gadgets[GID_SPEEDB_IN11  + 64             + x] = (struct Gadget*) IntegerObject, GA_ID, GID_SPEEDB_IN11  + 64             + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_MinVisible, 3 + 1, IntegerEnd
#define PdGad(x)            LAYOUT_AddChild, gadgets[GID_SPEEDB_IN11  + 80             + x] = (struct Gadget*) IntegerObject, GA_ID, GID_SPEEDB_IN11  + 80             + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_MinVisible, 3 + 1, IntegerEnd
#define PtsGad(x)           LAYOUT_AddChild, gadgets[GID_SPEEDB_IN11  + 96             + x] = (struct Gadget*) IntegerObject, GA_ID, GID_SPEEDB_IN11  + 96             + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_MinVisible, 5 + 1, IntegerEnd
#define PlayerNameGad(x)    LAYOUT_AddChild, gadgets[GID_SPEEDB_ST17  +                  x] = (struct Gadget*) StringObject,  GA_ID, GID_SPEEDB_ST17  +                  x, STRINGA_TextVal, "?", GA_ReadOnly, TRUE, STRINGA_MinVisible, 7 + 1, StringEnd
#define PlayerStatGad(a, b) LAYOUT_AddChild, gadgets[GID_SPEEDB_IN123 + (a * STATGADS) + b] = (struct Gadget*) IntegerObject, GA_ID, GID_SPEEDB_IN123 + (a * STATGADS) + b, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Number, player[a].stat[b], INTEGER_Maximum, 255, INTEGER_MinVisible, 3 + 1, IntegerEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void playerswindow(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT FLAG                 cancelling;
IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT LONG                 gamesize;
IMPORT ULONG                game,
                            offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                conference,
                            coins1, coins2,
                            extratime,
                            manager,
                            stamina[2], power[2], skill[2],
                            team1, team2,
                            week, weeks;
MODULE struct List          TeamList[2];
MODULE struct
{   ULONG gf, ga, mf, ma, md, pd, pts;
    TEXT  name[7 + 1];
} table[16];

MODULE const STRPTR ConferenceOptions[2 + 1] =
{ "Western Hemispheric Conference",
  "Eastern Hemispheric Conference",
  NULL
}, GameOptions[2 + 1] =
{ "Speedball 1",
  "Speedball 2",
  NULL
}, TeamOptions[2][3] = {
{ "Verna",   // 0
  "Lacerta", // 1
  "Draco",   // 2
  // no NULL is required
},
{ "Evoski",  // 0
  "Cheobi",  // 1
  "Sastok",  // 2
  // no NULL is required
} }, Speedball2Teams[16] =
{ "Brutal Deluxe",
  "Revolver",
  "Raw Messiahs",
  "Violent Desire",
  "Baroque",
  "The Renegades",
  "Damocles",
  "Steel Fury",
  "Powerhouse",
  "Rage 2100",
  "Mean Machine",
  "Explosive Lords",
  "Lethal Formula",
  "Turbo Hammers",
  "Fatal Justice",
  "Super Nashwan",
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   UBYTE name;
    ULONG stat[STATGADS];
} player[12];

MODULE struct
{   STRPTR name;
    UBYTE  value;
} Speedball2Players[PLAYERNAMES] = {
                     // portrait byte
{ "Jams"   , 0x00 }, // $6A?
{ "Norman" , 0x05 }, // $6D?
{ "Caza"   , 0x0C }, // $70?
{ "Weiss"  , 0x11 }, // $73?
{ "Garrik" , 0x17 }, // $76?
{ "Roscopp", 0x1E }, // $79?
{ "Montez" , 0x26 }, // $A2
{ "Shorn"  , 0x2D }, // $A5
{ "Quiss"  , 0x33 }, // $A8
{ "Quaid"  , 0x39 }, // $AB
{ "Rocco"  , 0x3F }, // $AE
{ "Luthor" , 0x45 }, // $B1
{ "Jenson" , 0x4C }, // $D8
{ "Cooper" , 0x53 }, // $DB
{ "Stavia" , 0x5A }, // $DE
{ "Midia"  , 0x61 }, // $E1
{ "Seline" , 0x67 }, // $E4
{ "Bodini" , 0x6E }, // $E7
{ "Barry"  , 0x75 }, // $00
{ "Colin"  , 0x7B }, // $03
{ "Justin" , 0x81 }, // $06
{ "Nigel"  , 0x88 }, // $09
{ "Darren" , 0x8E }, // $0C
{ "Graham" , 0x95 }, // $0F
{ "Arnold" , 0x9C }, // $36
{ "Robin"  , 0xA3 }, // $39
{ "Trevor" , 0xA9 }, // $3C
{ "Stuart" , 0xB0 }, // $3F
{ "Gordon" , 0xB7 }, // $42
{ "Kevin"  , 0xBE }, // $45
};

// 8. CODE ---------------------------------------------------------------

EXPORT void speedb_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // speedb_preinit()
        NewList(&TeamList[0]);
        NewList(&TeamList[1]);
    }

    tool_open      = speedb_open;
    tool_loop      = speedb_loop;
    tool_save      = speedb_save;
    tool_close     = speedb_close;
    tool_exit      = speedb_exit;
    tool_subgadget = speedb_subgadget;

    if (loaded != FUNC_SPEEDBALL && !speedb_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_SPEEDBALL;

    ch_load_images(348, 350, TeamOptions[conference], &TeamList[0]);
    ch_load_images(377, 379, TeamOptions[conference], &TeamList[1]);
    make_speedbar_list(GID_SPEEDB_SB1);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_SPEEDB_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            AddHLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                AddToolbar(GID_SPEEDB_SB1),
                AddSpace,
                LAYOUT_AddChild,                           gadgets[GID_SPEEDB_CH4] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                 GID_SPEEDB_CH4,
                    GA_Disabled,                           TRUE,
                    CHOOSER_LabelArray,                    &GameOptions,
                ChooserEnd,
                Label("Game:"),
                CHILD_WeightedWidth,                       0,
                AddSpace,
                MaximizeButton(GID_SPEEDB_BU1, "Maximize Game"),
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                LAYOUT_SpaceOuter,                         TRUE,
                AddHLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Player 1 (Green)",
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_SPEEDB_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_SPEEDB_CH1,
                        CHOOSER_Labels,                    &TeamList[0],
                        CHOOSER_AutoFit,                   TRUE,
                    PopUpEnd,
                    Label("Team:"),
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_SPEEDB_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_SPEEDB_IN5,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               255,
                            INTEGER_MinVisible,            3 + 1,
                        IntegerEnd,
                        CHILD_WeightedHeight,              0,
                        Label("Stamina:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_SPEEDB_IN6] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_SPEEDB_IN6,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9, // more probably would work but would not be displayable by game
                                INTEGER_MinVisible,        1 + 1,
                            IntegerEnd,
                            AddLabel("00"),
                            CHILD_WeightedWidth,           0,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        Label("Power:"),
                        LAYOUT_AddChild,                   gadgets[GID_SPEEDB_IN7] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_SPEEDB_IN7,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               256,
                            INTEGER_MinVisible,            3 + 1,
                        IntegerEnd,
                        CHILD_WeightedHeight,              0,
                        Label("Skill:"),
                        LAYOUT_AddChild,                   gadgets[GID_SPEEDB_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_SPEEDB_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0, // maximum is set in writegadgets()
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        CHILD_WeightedHeight,              0,
                        Label("Tokens:"),
                        AddSpace,
                        LAYOUT_AddChild,                   gadgets[GID_SPEEDB_CB2] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_SPEEDB_CB2,
                            GA_Selected,                   manager,
                            GA_Text,                       "Manager?",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_SPEEDB_BU2] = (struct Gadget*)
                        ZButtonObject,
                            GA_ID,                         GID_SPEEDB_BU2,
                            GA_RelVerify,                  TRUE,
                            GA_Text,                       "_Players...",
                        ButtonEnd,
                        CHILD_WeightedHeight,              0,
                    LayoutEnd,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddHLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Player 2 (Red)",
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_SPEEDB_CH2] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_SPEEDB_CH2,
                        CHOOSER_Labels,                    &TeamList[1],
                        CHOOSER_AutoFit,                   TRUE,
                    PopUpEnd,
                    Label("Team:"),
                    AddVLayout,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_AddChild,                   gadgets[GID_SPEEDB_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_SPEEDB_IN8,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               255,
                            INTEGER_MinVisible,            3 + 1,
                        IntegerEnd,
                        Label("Stamina:"),
                        CHILD_WeightedHeight,              0,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_SPEEDB_IN9] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_SPEEDB_IN9,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           9, // more probably would work but would not be displayable by game
                                INTEGER_MinVisible,        1 + 1,
                            IntegerEnd,
                            AddLabel("00"),
                            CHILD_WeightedWidth,           0,
                        LayoutEnd,
                        Label("Power:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_SPEEDB_IN10] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_SPEEDB_IN10,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               256,
                            INTEGER_MinVisible,            3 + 1,
                        IntegerEnd,
                        Label("Skill:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_SPEEDB_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_SPEEDB_IN2,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               255,
                            INTEGER_MinVisible,            3 + 1,
                        IntegerEnd,
                        Label("Tokens:"),
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_AddChild,                           gadgets[GID_SPEEDB_CH3] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                 GID_SPEEDB_CH3,
                    GA_RelVerify,                          TRUE,
                    CHOOSER_LabelArray,                    &ConferenceOptions,
                    CHOOSER_AutoFit,                       TRUE,
                PopUpEnd,
                Label("Conference:"),
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_SPEEDB_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_SPEEDB_IN3,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   1,
                        INTEGER_Maximum,                   100,
                        INTEGER_MinVisible,                3 + 1,
                    IntegerEnd,
                    AddLabel("of"),
                    CHILD_WeightedWidth,                   0,
                    LAYOUT_AddChild,                       gadgets[GID_SPEEDB_IN4] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_SPEEDB_IN4,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   1,
                        INTEGER_Maximum,                   10, // more probably would work but would not be displayable by game
                        INTEGER_MinVisible,                2 + 1,
                    IntegerEnd,
                    AddLabel("0 weeks"),
                    CHILD_WeightedWidth,                   0,
                    LAYOUT_AddChild,                       gadgets[GID_SPEEDB_CB1] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_SPEEDB_CB1,
                        GA_Selected,                       extratime,
                        GA_Text,                           "Playing extra time?",
                    End,
                    CHILD_WeightedWidth,                   0,
                LayoutEnd,
                Label("Round/Week:"),
            LayoutEnd,
            AddLabel(""),
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                LAYOUT_BevelStyle,                         BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "League Table",
                AddVLayout,
                    LAYOUT_HorizAlignment,                 LALIGN_LEFT,
                    AddLabel("Team"),
                    NameGad(0),
                    NameGad(1),
                    NameGad(2),
                    NameGad(3),
                    NameGad(4),
                    NameGad(5),
                    NameGad(6),
                    NameGad(7),
                    NameGad(8),
                    NameGad(9),
                    NameGad(10),
                    ExtraNameGad(11),
                    ExtraNameGad(12),
                    ExtraNameGad(13),
                    ExtraNameGad(14),
                    ExtraNameGad(15),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_HorizAlignment,                 LALIGN_RIGHT,
                    AddLabel("GF"),
                    GFGad(0),
                    GFGad(1),
                    GFGad(2),
                    GFGad(3),
                    GFGad(4),
                    GFGad(5),
                    GFGad(6),
                    GFGad(7),
                    GFGad(8),
                    GFGad(9),
                    GFGad(10),
                    GFGad(11),
                    GFGad(12),
                    GFGad(13),
                    GFGad(14),
                    GFGad(15),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    LAYOUT_HorizAlignment,                 LALIGN_RIGHT,
                    AddLabel("GA"),
                    GAGad(0),
                    GAGad(1),
                    GAGad(2),
                    GAGad(3),
                    GAGad(4),
                    GAGad(5),
                    GAGad(6),
                    GAGad(7),
                    GAGad(8),
                    GAGad(9),
                    GAGad(10),
                    GAGad(11),
                    GAGad(12),
                    GAGad(13),
                    GAGad(14),
                    GAGad(15),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    LAYOUT_HorizAlignment,                 LALIGN_RIGHT,
                    AddLabel("MF"),
                    MFGad(0),
                    MFGad(1),
                    MFGad(2),
                    MFGad(3),
                    MFGad(4),
                    MFGad(5),
                    MFGad(6),
                    MFGad(7),
                    MFGad(8),
                    MFGad(9),
                    MFGad(10),
                    MFGad(11),
                    MFGad(12),
                    MFGad(13),
                    MFGad(14),
                    MFGad(15),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    LAYOUT_HorizAlignment,                 LALIGN_RIGHT,
                    AddLabel("MA"),
                    MAGad(0),
                    MAGad(1),
                    MAGad(2),
                    MAGad(3),
                    MAGad(4),
                    MAGad(5),
                    MAGad(6),
                    MAGad(7),
                    MAGad(8),
                    MAGad(9),
                    MAGad(10),
                    MAGad(11),
                    MAGad(12),
                    MAGad(13),
                    MAGad(14),
                    MAGad(15),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    LAYOUT_HorizAlignment,                 LALIGN_RIGHT,
                    AddLabel("MD"),
                    MDGad(0),
                    MDGad(1),
                    MDGad(2),
                    MDGad(3),
                    MDGad(4),
                    MDGad(5),
                    MDGad(6),
                    MDGad(7),
                    MDGad(8),
                    MDGad(9),
                    MDGad(10),
                    MDGad(11),
                    MDGad(12),
                    MDGad(13),
                    MDGad(14),
                    MDGad(15),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    LAYOUT_HorizAlignment,                 LALIGN_RIGHT,
                    AddLabel("Played"),
                    PdGad(0),
                    PdGad(1),
                    PdGad(2),
                    PdGad(3),
                    PdGad(4),
                    PdGad(5),
                    PdGad(6),
                    PdGad(7),
                    PdGad(8),
                    PdGad(9),
                    PdGad(10),
                    PdGad(11),
                    PdGad(12),
                    PdGad(13),
                    PdGad(14),
                    PdGad(15),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    LAYOUT_HorizAlignment,                 LALIGN_RIGHT,
                    AddLabel("Points"),
                    PtsGad(0),
                    PtsGad(1),
                    PtsGad(2),
                    PtsGad(3),
                    PtsGad(4),
                    PtsGad(5),
                    PtsGad(6),
                    PtsGad(7),
                    PtsGad(8),
                    PtsGad(9),
                    PtsGad(10),
                    PtsGad(11),
                    PtsGad(12),
                    PtsGad(13),
                    PtsGad(14),
                    PtsGad(15),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_SPEEDB_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_SPEEDB_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_SPEEDB_IN1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void speedb_loop(ULONG gid, UNUSED ULONG code)
{   int i, j;

    switch (gid)
    {
    case GID_SPEEDB_BU1:
        readgadgets();

        power[  0] = power[  1]   =     9;
        if (game == SPEEDBALL1)
        {   coins1                =   100;
        } else
        {   coins1                = 30000;
        }
        coins2                    =   100;
        stamina[0] = stamina[1]   =
        skill[  0] = skill[  1]   =   250;

        for (i = 0; i < 12; i++)
        {   for (j = 0; j < STATGADS; j++)
            {   player[i].stat[j] =   250;
        }   }

        writegadgets();
    acase GID_SPEEDB_BU2:
        playerswindow();
    acase GID_SPEEDB_CH3:
        readgadgets();
        writegadgets();
}   }

EXPORT FLAG speedb_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if (gamesize == 5952)
        {   game = SPEEDBALL1;
        } elif (gamesize == 11264)
        {   game = SPEEDBALL2;
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
{   int          i, j;
    struct Node* NodePtr;

    if
    (   page != FUNC_SPEEDBALL
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SPEEDB_CH1], MainWindowPtr, NULL,
        CHOOSER_Labels, ~0,
    TAG_DONE);
    DISCARD SetGadgetAttrs
    (   gadgets[GID_SPEEDB_CH2], MainWindowPtr, NULL,
        CHOOSER_Labels, ~0,
    TAG_DONE);

    for (i = 0; i < 2; i++)
    {   j = 0;
        // Walk the list
        for
        (   NodePtr = TeamList[i].lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   SetChooserNodeAttrs(NodePtr, CNA_Text, TeamOptions[conference][j], TAG_DONE);
            j++;
    }   }

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SPEEDB_CH1], MainWindowPtr, NULL,
        CHOOSER_Labels, &TeamList[0],
    TAG_DONE); // this refreshes automatically
    DISCARD SetGadgetAttrs
    (   gadgets[GID_SPEEDB_CH2], MainWindowPtr, NULL,
        CHOOSER_Labels, &TeamList[1],
    TAG_DONE); // this refreshes automatically

    SetGadgetAttrs(gadgets[GID_SPEEDB_CH4], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) game, TAG_END); // this refreshes automatically

    ghost(   GID_SPEEDB_CH1 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_CH2 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_CH3 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_IN2 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_IN3 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_IN4 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_IN5 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_IN6 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_IN7 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_IN8 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_IN9 , game != SPEEDBALL1);
    ghost(   GID_SPEEDB_IN10, game != SPEEDBALL1);
    ghost(   GID_SPEEDB_BU2 , game != SPEEDBALL2);
    ghost_st(GID_SPEEDB_CB1 , game != SPEEDBALL1);
    ghost_st(GID_SPEEDB_CB2 , game != SPEEDBALL2);

    SetGadgetAttrs(gadgets[GID_SPEEDB_IN1], MainWindowPtr, NULL, INTEGER_Maximum, (game == SPEEDBALL1) ? 255 : 32767, TAG_END);
    for (i = 0; i < 16; i++)
    {   SetGadgetAttrs(gadgets[GID_SPEEDB_IN11 + 32 + i], MainWindowPtr, NULL, INTEGER_Maximum, (game == SPEEDBALL1) ?   255 :  99, TAG_END);
        SetGadgetAttrs(gadgets[GID_SPEEDB_IN11 + 48 + i], MainWindowPtr, NULL, INTEGER_Maximum, (game == SPEEDBALL1) ?   255 :  99, TAG_END);
        SetGadgetAttrs(gadgets[GID_SPEEDB_IN11 + 64 + i], MainWindowPtr, NULL, INTEGER_Maximum, (game == SPEEDBALL1) ?   255 :  99, TAG_END);
        SetGadgetAttrs(gadgets[GID_SPEEDB_IN11 + 80 + i], MainWindowPtr, NULL, INTEGER_Maximum, (game == SPEEDBALL1) ?   255 :  99, TAG_END);
        SetGadgetAttrs(gadgets[GID_SPEEDB_IN11 + 96 + i], MainWindowPtr, NULL, INTEGER_Maximum, (game == SPEEDBALL1) ? 32767 : 999, TAG_END);
    }
    for (i = 0; i < 11; i++)
    {   if (game == SPEEDBALL1)
        {   SetGadgetAttrs(gadgets[GID_SPEEDB_ST1 + i], MainWindowPtr, NULL, STRINGA_TextVal, table[i].name,      GA_Disabled, FALSE, TAG_END);
        } else
        {   SetGadgetAttrs(gadgets[GID_SPEEDB_ST1 + i], MainWindowPtr, NULL, STRINGA_TextVal, Speedball2Teams[i], GA_Disabled, TRUE, TAG_END);
        }
        RefreshGadgets((struct Gadget*) gadgets[GID_SPEEDB_ST1 + i], MainWindowPtr, NULL); // we must explicitly refresh
    }
    for (i = 11; i < 16; i++)
    {   ghost(   GID_SPEEDB_IN11      + i, game != SPEEDBALL2);
        ghost(   GID_SPEEDB_IN11 + 16 + i, game != SPEEDBALL2);
        ghost(   GID_SPEEDB_IN11 + 32 + i, game != SPEEDBALL2);
        ghost(   GID_SPEEDB_IN11 + 48 + i, game != SPEEDBALL2);
        ghost(   GID_SPEEDB_IN11 + 64 + i, game != SPEEDBALL2);
        ghost(   GID_SPEEDB_IN11 + 80 + i, game != SPEEDBALL2);
        ghost(   GID_SPEEDB_IN11 + 96 + i, game != SPEEDBALL2);
        if (game == SPEEDBALL1)
        {   SetGadgetAttrs(gadgets[GID_SPEEDB_ST1 + i], MainWindowPtr, NULL, STRINGA_TextVal, "-",                TAG_END); // this refreshes automatically
        } else
        {   SetGadgetAttrs(gadgets[GID_SPEEDB_ST1 + i], MainWindowPtr, NULL, STRINGA_TextVal, Speedball2Teams[i], TAG_END); // this refreshes automatically
}   }   }

MODULE void eithergadgets(void)
{   int i;

    either_in(GID_SPEEDB_IN1,  &coins1);
    either_in(GID_SPEEDB_IN2,  &coins2);
    either_in(GID_SPEEDB_IN3,  &week);
    either_in(GID_SPEEDB_IN4,  &weeks);
    either_in(GID_SPEEDB_IN5,  &stamina[0]);
    either_in(GID_SPEEDB_IN6,  &power[  0]);
    either_in(GID_SPEEDB_IN7,  &skill[  0]);
    either_in(GID_SPEEDB_IN8,  &stamina[1]);
    either_in(GID_SPEEDB_IN9,  &power[  1]);
    either_in(GID_SPEEDB_IN10, &skill[  1]);

    either_cb(GID_SPEEDB_CB1,  &extratime);
    either_cb(GID_SPEEDB_CB2,  &manager);

    either_ch(GID_SPEEDB_CH1,  &team1);
    either_ch(GID_SPEEDB_CH2,  &team2);
    either_ch(GID_SPEEDB_CH3,  &conference);

    for (i = 0; i < 16; i++)
    {   either_in(GID_SPEEDB_IN11      + i, &table[i].gf);
        either_in(GID_SPEEDB_IN11 + 16 + i, &table[i].ga);
        either_in(GID_SPEEDB_IN11 + 32 + i, &table[i].mf);
        either_in(GID_SPEEDB_IN11 + 48 + i, &table[i].ma);
        either_in(GID_SPEEDB_IN11 + 64 + i, &table[i].md);
        either_in(GID_SPEEDB_IN11 + 80 + i, &table[i].pd);
        either_in(GID_SPEEDB_IN11 + 96 + i, &table[i].pts);
}   }

MODULE void readgadgets(void)
{   int    i;
    STRPTR stringptr;

    gadmode = SERIALIZE_READ;
    eithergadgets();

    if (game == SPEEDBALL1)
    {   for (i = 0; i < 11; i++)
        {   DISCARD GetAttr(STRINGA_TextVal, (Object*) gadgets[GID_SPEEDB_ST1 + i], (ULONG*) &stringptr);
            zstrncpy(table[i].name, stringptr, 7);
}   }   }

MODULE void serialize(void)
{   int i, j;

    switch (game)
    {
    case SPEEDBALL1:
        offset = 0xBF;
        serialize1(&coins1);                //  $BF
        serialize1(&coins2);                //  $C0
        serialize1(&power[0]);              //  $C1
        serialize1(&power[1]);              //  $C2

        offset = 0xD6;
        serialize1(&skill[1]);              //  $D6

        offset = 0xE1;
        serialize1(&skill[0]);              //  $E1

        offset = 0xE3;
        serialize1(&stamina[0]);            //  $E3
        serialize1(&stamina[1]);            //  $E4
        serialize1(&week);                  //  $E5

        offset = 0xEA;
        serialize1(&team1);                 //  $EA

        offset = 0xED;
        if (serializemode == SERIALIZE_WRITE)
        {   serialize1(&week);              //  $ED
        } else
        {   offset++;                       //  $ED
        }
        serialize1(&team2);                 //  $EE

        offset = 0xF5;
        serialize1(&weeks);                 //  $F5

        offset = 0x101;
        serialize1(&extratime);             // $101

        offset = 0x10C;
        serialize1(&conference);            // $10C

        offset = 0x3A0;
        for (i = 0; i < 11; i++)            // $3A0..$4FF
        {   serstring(table[i].name);
            offset += 8;                    // $3A0..$3A7
            serialize2ulong(&table[i].gf);  // $3A8..$3A9
            serialize2ulong(&table[i].ga);  // $3AA..$3AB
            serialize1(     &table[i].pd);  // $3AC
            offset += 7;                    // $3AD..$3B3
            serialize2ulong(&table[i].pts); // $3B4..$3B5
            offset += 2;                    // $3B6..$3B7
            serialize1(     &table[i].mf);  // $3B8
            serialize1(     &table[i].ma);  // $3B9
            serialize1(     &table[i].md);  // $3BA
            offset += 5;                    // $3BB..$3BF
        }

        manager = FALSE;
    acase SPEEDBALL2:
        offset = 4;
        serialize2ulong(&coins1);           //  $4.. $5

        offset += 7;                        //  $6.. $C
        manager += 2;
        serialize1(&manager);               //  $D
        manager -= 2;

        offset += 3;                        //  $E..$10
        for (i = 0; i < 12; i++)
        {   serialize1to1(&player[i].name); // $11
            offset += 2;                    // $12..$13
            for (j = 0; j < 8; j++)
            {   serialize1(&player[i].stat[j]); // $14..$1B
            }
            offset += 3;                    // $1C..$1E
        }

        offset = 0xBB;
        for (i = 0; i < 16; i++)
        {   serialize1(&table[i].pd);       //  $BB
            offset++;                       //  $BC
            serialize1(&table[i].mf);       //  $BD
            offset++;                       //  $BE
            serialize1(&table[i].md);       //  $BF
            offset++;                       //  $C0
            serialize1(&table[i].ma);       //  $C1
            offset++;                       //  $C2
            serialize1(&table[i].gf);       //  $C3
            offset++;                       //  $C4
            serialize1(&table[i].ga);       //  $C5
            offset++;                       //  $C6
            serialize1(&table[i].pts);      //  $C7
            offset += 9;                    //  $C8.. $D0
}   }   }

EXPORT void speedb_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    if (game == SPEEDBALL1)
    {   gamesave("#?knockout.sav#?", "Speedball 1", saveas,  5952, FLAG_S, FALSE);
    } else
    {   // assert(game == SPEEDBALL2);
        gamesave("#?.save",          "Speedball 2", saveas, 11264, FLAG_S, FALSE);
}   }

EXPORT void speedb_exit(void)
{   ch_clearlist(&TeamList[0]);
    ch_clearlist(&TeamList[1]);
}

EXPORT void speedb_close(void) { ; }

MODULE void playerswindow(void)
{   TRANSIENT ULONG          i, j;
    TRANSIENT struct Image*  playerimage[12] = {NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL}; // SAS/C eats arse
    PERSIST   WORD           leftx   = -1,
                             topy    = -1,
                             width   = -1,
                             height  = -1;

    DISCARD SetAttrs(WinObject, WA_BusyPointer, TRUE, TAG_END);
    load_images(BITMAP_OK, BITMAP_CANCEL);
    for (i = 0; i < 12; i++)
    {   for (j = 0; j < PLAYERNAMES; j++)
        {   if (player[i].name == Speedball2Players[j].value)
            {   load_images(699 + j, 699 + j);
                playerimage[i] = image[699 + j];
                break; // for speed
    }   }   }
    DISCARD SetAttrs(WinObject, WA_BusyPointer, FALSE, TAG_END);

    // check for duplicates
    for (i = 0; i < 12; i++)
    {   for (j = 0; j < 12; j++)
        {   if (i != j && playerimage[i] == playerimage[j])
            {   playerimage[i] =
                playerimage[j] = NULL;
    }   }   }

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                             TRUE,
        WA_ThinSizeGadget,                         TRUE,
        WA_Title,                                  "Edit Players",
        (leftx  != -1) ? WA_Left         : TAG_IGNORE, leftx,
        (topy   != -1) ? WA_Top          : TAG_IGNORE, topy,
        (width  != -1) ? WA_Width        : TAG_IGNORE, width,
        (height != -1) ? WA_Height       : TAG_IGNORE, height,
        (leftx  == -1) ? WINDOW_Position : TAG_IGNORE, WPOS_CENTERMOUSE,
        WINDOW_LockHeight,                         TRUE,
        WINDOW_UniqueID,                           "speedb-1",
        WINDOW_ParentGroup,                        gadgets[GID_SPEEDB_LY2] = (struct Gadget*)
        VLayoutObject,
            GA_ID,                                 GID_SPEEDB_LY2,
            LAYOUT_SpaceOuter,                     TRUE,
            AddHLayout,
                AddVLayout,
                    AddLabel(""),
                    CHILD_WeightedHeight,          0,
                    playerimage[ 0] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[ 0],
                    playerimage[ 0] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[ 1] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[ 1],
                    playerimage[ 1] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[ 2] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[ 2],
                    playerimage[ 2] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[ 3] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[ 3],
                    playerimage[ 3] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[ 4] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[ 4],
                    playerimage[ 4] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[ 5] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[ 5],
                    playerimage[ 5] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[ 6] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[ 6],
                    playerimage[ 6] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[ 7] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[ 7],
                    playerimage[ 7] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[ 8] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[ 8],
                    playerimage[ 8] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[ 9] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[ 9],
                    playerimage[ 9] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[10] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[10],
                    playerimage[10] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                    playerimage[11] ? LAYOUT_AddImage : TAG_IGNORE, playerimage[11],
                    playerimage[11] ? CHILD_NoDispose : TAG_IGNORE, TRUE,
                LayoutEnd,
                CHILD_WeightedWidth,               0,
                AddVLayout,
                    LAYOUT_HorizAlignment,         LALIGN_LEFT,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    AddLabel("Player"),
                    CHILD_WeightedHeight,          0,
                    AddVLayout,
                        PlayerNameGad(0),
                        PlayerNameGad(1),
                        PlayerNameGad(2),
                        PlayerNameGad(3),
                        PlayerNameGad(4),
                        PlayerNameGad(5),
                        PlayerNameGad(6),
                        PlayerNameGad(7),
                        PlayerNameGad(8),
                        PlayerNameGad(9),
                        PlayerNameGad(10),
                        PlayerNameGad(11),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_HorizAlignment,         LALIGN_RIGHT,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    AddLabel("AGG"),
                    CHILD_WeightedHeight,          0,
                    AddVLayout,
                        PlayerStatGad( 0, 0),
                        PlayerStatGad( 1, 0),
                        PlayerStatGad( 2, 0),
                        PlayerStatGad( 3, 0),
                        PlayerStatGad( 4, 0),
                        PlayerStatGad( 5, 0),
                        PlayerStatGad( 6, 0),
                        PlayerStatGad( 7, 0),
                        PlayerStatGad( 8, 0),
                        PlayerStatGad( 9, 0),
                        PlayerStatGad(10, 0),
                        PlayerStatGad(11, 0),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_HorizAlignment,         LALIGN_RIGHT,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    AddLabel("ATT"),
                    CHILD_WeightedHeight,          0,
                    AddVLayout,
                        PlayerStatGad( 0, 1),
                        PlayerStatGad( 1, 1),
                        PlayerStatGad( 2, 1),
                        PlayerStatGad( 3, 1),
                        PlayerStatGad( 4, 1),
                        PlayerStatGad( 5, 1),
                        PlayerStatGad( 6, 1),
                        PlayerStatGad( 7, 1),
                        PlayerStatGad( 8, 1),
                        PlayerStatGad( 9, 1),
                        PlayerStatGad(10, 1),
                        PlayerStatGad(11, 1),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_HorizAlignment,         LALIGN_RIGHT,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    AddLabel("DEF"),
                    CHILD_WeightedHeight,          0,
                    AddVLayout,
                        PlayerStatGad( 0, 2),
                        PlayerStatGad( 1, 2),
                        PlayerStatGad( 2, 2),
                        PlayerStatGad( 3, 2),
                        PlayerStatGad( 4, 2),
                        PlayerStatGad( 5, 2),
                        PlayerStatGad( 6, 2),
                        PlayerStatGad( 7, 2),
                        PlayerStatGad( 8, 2),
                        PlayerStatGad( 9, 2),
                        PlayerStatGad(10, 2),
                        PlayerStatGad(11, 2),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_HorizAlignment,         LALIGN_RIGHT,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    AddLabel("SPD"),
                    CHILD_WeightedHeight,          0,
                    AddVLayout,
                        PlayerStatGad( 0, 3),
                        PlayerStatGad( 1, 3),
                        PlayerStatGad( 2, 3),
                        PlayerStatGad( 3, 3),
                        PlayerStatGad( 4, 3),
                        PlayerStatGad( 5, 3),
                        PlayerStatGad( 6, 3),
                        PlayerStatGad( 7, 3),
                        PlayerStatGad( 8, 3),
                        PlayerStatGad( 9, 3),
                        PlayerStatGad(10, 3),
                        PlayerStatGad(11, 3),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_HorizAlignment,         LALIGN_RIGHT,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    AddLabel("THR"),
                    CHILD_WeightedHeight,          0,
                    AddVLayout,
                        PlayerStatGad( 0, 4),
                        PlayerStatGad( 1, 4),
                        PlayerStatGad( 2, 4),
                        PlayerStatGad( 3, 4),
                        PlayerStatGad( 4, 4),
                        PlayerStatGad( 5, 4),
                        PlayerStatGad( 6, 4),
                        PlayerStatGad( 7, 4),
                        PlayerStatGad( 8, 4),
                        PlayerStatGad( 9, 4),
                        PlayerStatGad(10, 4),
                        PlayerStatGad(11, 4),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_HorizAlignment,         LALIGN_RIGHT,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    AddLabel("POW"),
                    CHILD_WeightedHeight,          0,
                    AddVLayout,
                        PlayerStatGad( 0, 5),
                        PlayerStatGad( 1, 5),
                        PlayerStatGad( 2, 5),
                        PlayerStatGad( 3, 5),
                        PlayerStatGad( 4, 5),
                        PlayerStatGad( 5, 5),
                        PlayerStatGad( 6, 5),
                        PlayerStatGad( 7, 5),
                        PlayerStatGad( 8, 5),
                        PlayerStatGad( 9, 5),
                        PlayerStatGad(10, 5),
                        PlayerStatGad(11, 5),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_HorizAlignment,         LALIGN_RIGHT,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    AddLabel("STA"),
                    CHILD_WeightedHeight,          0,
                    AddVLayout,
                        PlayerStatGad( 0, 6),
                        PlayerStatGad( 1, 6),
                        PlayerStatGad( 2, 6),
                        PlayerStatGad( 3, 6),
                        PlayerStatGad( 4, 6),
                        PlayerStatGad( 5, 6),
                        PlayerStatGad( 6, 6),
                        PlayerStatGad( 7, 6),
                        PlayerStatGad( 8, 6),
                        PlayerStatGad( 9, 6),
                        PlayerStatGad(10, 6),
                        PlayerStatGad(11, 6),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_HorizAlignment,         LALIGN_RIGHT,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    AddLabel("INT"),
                    CHILD_WeightedHeight,          0,
                    AddVLayout,
                        PlayerStatGad( 0, 7),
                        PlayerStatGad( 1, 7),
                        PlayerStatGad( 2, 7),
                        PlayerStatGad( 3, 7),
                        PlayerStatGad( 4, 7),
                        PlayerStatGad( 5, 7),
                        PlayerStatGad( 6, 7),
                        PlayerStatGad( 7, 7),
                        PlayerStatGad( 8, 7),
                        PlayerStatGad( 9, 7),
                        PlayerStatGad(10, 7),
                        PlayerStatGad(11, 7),
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            AddHLayout,
                LAYOUT_AddChild,                   gadgets[GID_SPEEDB_BU3] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                         GID_SPEEDB_BU3,
                    GA_RelVerify,                  TRUE,
                    GA_Image,
                    LabelObject,
                        LABEL_Image,               image[BITMAP_OK],
                        CHILD_NoDispose,           TRUE,
                        LABEL_DrawInfo,            DrawInfoPtr,
                        LABEL_Text,                " ",
                        LABEL_Text,                "OK (ENTER)",
                    LabelEnd,
                ButtonEnd,
                LAYOUT_AddChild,                   gadgets[GID_SPEEDB_BU4] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                         GID_SPEEDB_BU4,
                    GA_RelVerify,                  TRUE,
                    GA_Image,
                    LabelObject,
                        LABEL_Image,               image[BITMAP_CANCEL],
                        CHILD_NoDispose,           TRUE,
                        LABEL_DrawInfo,            DrawInfoPtr,
                        LABEL_Text,                " ",
                        LABEL_Text,                "Cancel (Esc)",
                    LabelEnd,
                ButtonEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                  0,
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

    for (i = 0; i < 12; i++)
    {   for (j = 0; j < PLAYERNAMES; j++)
        {   if (player[i].name == Speedball2Players[j].value)
            {   SetGadgetAttrs(gadgets[GID_SPEEDB_ST17 + i], SubWindowPtr, NULL, STRINGA_TextVal, Speedball2Players[j].name, TAG_END);
                break; // for speed
    }   }   }
    DISCARD ActivateLayoutGadget(gadgets[GID_SPEEDB_LY2], SubWindowPtr, NULL, (Object) gadgets[GID_SPEEDB_IN123]);

    cancelling = FALSE;
    subloop();
    if (!cancelling)
    {   for (i = 0; i < 12; i++)
        {   for (j = 0; j < STATGADS; j++)
            {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_SPEEDB_IN123 + (i * STATGADS) + j], (ULONG*) &player[i].stat[j]);
    }   }   }

    leftx  = SubWindowPtr->LeftEdge;
    topy   = SubWindowPtr->TopEdge;
    width  = SubWindowPtr->Width;
    height = SubWindowPtr->Height;

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG speedb_subkey(UWORD code)
{   if (code == SCAN_RETURN || code == SCAN_ENTER)
    {   return TRUE;
    }

    return FALSE;
}

EXPORT FLAG speedb_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_SPEEDB_BU4:
        cancelling = TRUE;
    // -lint fallthrough
    case GID_SPEEDB_BU3:
        return TRUE;
    }

    return FALSE;
}

// 1.  INCLUDES -----------------------------------------------------------

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

// main window
#define GID_SYN_LY1   0 // root layout
#define GID_SYN_SB1   1 // toolbar
#define GID_SYN_BU1   2 // maximize game
#define GID_SYN_ST1   3 // your name
#define GID_SYN_ST2   4 // company name
#define GID_SYN_CH1   5 // item slot #1
#define GID_SYN_CH2   6 // item slot #2
#define GID_SYN_CH3   7 // item slot #3
#define GID_SYN_CH4   8 // item slot #4
#define GID_SYN_CH5   9 // item slot #5
#define GID_SYN_CH6  10 // item slot #6
#define GID_SYN_CH7  11 // item slot #7
#define GID_SYN_CH8  12 // item slot #8
#define GID_SYN_IN1  13 // charges #1
#define GID_SYN_IN2  14 // charges #2
#define GID_SYN_IN3  15 // charges #3
#define GID_SYN_IN4  16 // charges #4
#define GID_SYN_IN5  17 // charges #5
#define GID_SYN_IN6  18 // charges #6
#define GID_SYN_IN7  19 // charges #7
#define GID_SYN_IN8  20 // charges #8
#define GID_SYN_IN9  21 // money
#define GID_SYN_IN10 22 // who
#define GID_SYN_ST3  23 // game name
#define GID_SYN_CH9  24 // sex
#define GID_SYN_BU2  25 // agent name
#define GID_SYN_BU3  26 // maximize man
#define GID_SYN_IN11 27 // brain
#define GID_SYN_IN12 28 // eyes
#define GID_SYN_IN13 29 // heart
#define GID_SYN_IN14 30 // chest
#define GID_SYN_IN15 31 // arms
#define GID_SYN_IN16 32 // legs

// names subwindow
#define GID_SYN_LY2  33
#define GID_SYN_LB1  34

#define GIDS_SYN     GID_SYN_LB1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void maximize_man(void);
MODULE void maximize_game(void);
MODULE void namewindow(void);

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
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SexList,
                            SpeedBarList;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;
#ifndef __MORPHOS__
    IMPORT UWORD*           MouseData;
#endif

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE TEXT                 companyname[16 + 1],
                            gamename[20 + 1],
                            yourname[16 + 1];
MODULE ULONG                agentname[18],
                            legs[18],
                            arms[18],
                            chest[18],
                            heart[18],
                            eyes[18],
                            brain[18],
                            body[18],
                            charges[18][8],
                            item[18][8],
                            money,
                            sex[18],
                            who = 0;
MODULE struct List          ItemsList,
                            NamesList;

MODULE const STRPTR agentnames[68 + 1] = {
"Afshar",     //  0
"Arnold",
"Baird",
"Baldwin",
"Black",
"Boyd",
"Boyesen",
"Brazier",
"Brown",
"Bush",
"Carr",       // 10
"Chrismas",
"Clinton",
"Cooper",
"Corpes",
"Cox",
"Dawson",
"Donkin",
"Diskett",
"Dunne",
"Edgar",      // 20
"Evans",
"Fairley",
"Fawcett",
"Flint",
"Floyd",
"Griffiths",
"Harris",
"Hastings",
"Herbert",
"Hickman",    // 30
"Hicks",
"Hill",
"James",
"Jeffery",
"Joeseph",
"Johnson",
"Johnston",
"Jones",
"Lewis",
"Lindsell",   // 40
"Lockley",
"Martin",
"McEntee",
"McLaughin",
"Molyneux",
"Munro",
"Morris",
"Mumford",
"Nixon",
"Parker",     // 50
"Pratt",
"Reid",
"Rennie",
"Rice",
"Ripley",
"Robertson",
"Romano",
"Seat",
"Sen",
"Shaw",       // 60
"Simmons",
"Snelling",
"Taylor",
"Trowers",
"Webley",
"Wellesley",
"Wild",
"Willis"      // 68
}, ItemOptions[14 + 2] = {
"None",           //  0
"Persuadertron",
"Pistol",
"Gauss Gun",
"Shotgun",
"Uzi",            //  5
"Minigun",
"Laser",
"Flamer",
"Long Range",
"Scanner",        // 10
"Medikit",
"Time Bomb",
"Access Card",
"Energy Shield",  // 14 (17 as far as the game is concerned)
NULL              // 15
};

MODULE const ULONG maxcharges[14 + 1] = {
  0, //  0
 50,
 12,
  2,
 11,
 49, //  5
499,
  4,
999,
 29,
 19, // 10
  0,
199,
  0,
199  // 14
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (11 * 2)] =
{   0x0000, 0x0000, // reserved

/*  KK.. .... .... ....    . = Transparent (%00)
    KWKK .... .... ....    K = Black       (%01)
    .KWW KK.. .... ....    W = White       (%10)
    .KWW WWKK .... ....    - = Unused      (%11)
    ..KW WWWW KK.. ....
    ..KW WWWW WK.. ....
    ...K WWWW K... ....
    ...K WWWW WK.. ....
    .... KWKK WWK. ....
    .... KK.. KWK. ....
    .... .... .K.. ....

    Plane 0 Plane 1 */
    0xC000, 0x0000,
    0xB000, 0x4000,
    0x4C00, 0x3000,
    0x4300, 0x3C00,
    0x20C0, 0x1F00,
    0x2040, 0x1F80,
    0x1080, 0x0F00,
    0x1040, 0x0F80,
    0x0B20, 0x04C0,
    0x0CA0, 0x0040,
    0x0040, 0x0000,

    0x0000, 0x0000  // reserved
};
#endif

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void syn_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // syn_preinit()
        NewList(&ItemsList);
        NewList(&NamesList);

        // syn_init()
        lb_makelist(&NamesList, agentnames, 69);
    }

    tool_open      = syn_open;
    tool_loop      = syn_loop;
    tool_save      = syn_save;
    tool_close     = syn_close;
    tool_exit      = syn_exit;
    tool_subgadget = syn_subgadget;

    if (loaded != FUNC_SYNDICATE && !syn_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_SYNDICATE;

    ch_load_images(202, 216, ItemOptions, &ItemsList);
    make_speedbar_list(GID_SYN_SB1);
    load_aiss_images(10, 10);
    makesexlist();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                 FALSE,
        WA_ThinSizeGadget,                             TRUE,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                            gadgets[GID_SYN_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_DeferLayout,                        TRUE,
            AddHLayout,
                AddToolbar(GID_SYN_SB1),
                AddSpace,
                CHILD_WeightedWidth,                   50,
                AddVLayout,
                    AddSpace,
                    CHILD_WeightedHeight,              50,
                    MaximizeButton(GID_SYN_BU1, "Maximize Game"),
                    CHILD_WeightedHeight,              0,
                    AddSpace,
                    CHILD_WeightedHeight,              50,
                LayoutEnd,
                CHILD_WeightedWidth,                   0,
                AddSpace,
                CHILD_WeightedWidth,                   50,
            LayoutEnd,
            AddVLayout,
                LAYOUT_AddChild,                       gadgets[GID_SYN_ST3] = (struct Gadget*)
                StringObject,
                    GA_ID,                             GID_SYN_ST3,
                    GA_ReadOnly,                       TRUE,
                    STRINGA_TextVal,                   gamename,
                    STRINGA_MinVisible,                20 + stringextra,
                StringEnd,
                Label("Game Name:"),
                LAYOUT_AddChild,                       gadgets[GID_SYN_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                             GID_SYN_ST1,
                    GA_TabCycle,                       TRUE,
                    STRINGA_TextVal,                   yourname,
                    STRINGA_MaxChars,                  16 + 1,
                    STRINGA_MinVisible,                16 + stringextra,
                StringEnd,
                Label("Your Name:"),
                LAYOUT_AddChild,                       gadgets[GID_SYN_ST2] = (struct Gadget*)
                StringObject,
                    GA_ID,                             GID_SYN_ST2,
                    GA_TabCycle,                       TRUE,
                    STRINGA_TextVal,                   companyname,
                    STRINGA_MaxChars,                  16 + 1,
                    STRINGA_MinVisible,                16 + stringextra,
                StringEnd,
                Label("Company Name:"),
                LAYOUT_AddChild,                       gadgets[GID_SYN_IN9] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_SYN_IN9,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   ONE_BILLION - 1,
                    INTEGER_MinVisible,                13 + 1,
                IntegerEnd,
                Label("Money:"),
                AddLabel(""),
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    AddSpace,
                    AddLabel("Agent #:"),
                    LAYOUT_AddChild,                   gadgets[GID_SYN_IN10] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_SYN_IN10,
                        GA_TabCycle,                   TRUE,
                        GA_RelVerify,                  TRUE,
                        INTEGER_Number,                who + 1,
                        INTEGER_Minimum,               1,
                        INTEGER_Maximum,               18,
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    CHILD_WeightedWidth,               0,
                    AddLabel("of 18"),
                    AddSpace,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_SpaceInner,                 TRUE,
                    LAYOUT_AddChild,                   gadgets[GID_SYN_BU2] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                         GID_SYN_BU2,
                        GA_RelVerify,                  TRUE,
                        GA_Text,                       agentname[who] == 255 ? (const STRPTR) "Empty" : agentnames[agentname[who]],
                        BUTTON_Justification,          BCJ_LEFT,
                    ButtonEnd,
                    Label("Name:"),
                    LAYOUT_AddChild,                   gadgets[GID_SYN_CH9] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                         GID_SYN_CH9,
                        CHOOSER_Labels,                &SexList,
                    ChooserEnd,
                    Label("Sex:"),
                    AddHLayout,
                        AddHLayout,
                            LAYOUT_Label,                              "Equipment",
                            LAYOUT_BevelStyle,                         BVS_GROUP,
                            LAYOUT_SpaceOuter,                         TRUE,
                            LAYOUT_SpaceInner,                         TRUE,
                            AddVLayout,
                                LAYOUT_AddChild,                       gadgets[GID_SYN_CH1] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                             GID_SYN_CH1,
                                    GA_RelVerify,                      TRUE,
                                    CHOOSER_Labels,                    &ItemsList,
                                    CHOOSER_MaxLabels,                 18,
                                ChooserEnd,
                                Label("#1:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_CH2] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                             GID_SYN_CH2,
                                    GA_RelVerify,                      TRUE,
                                    CHOOSER_Labels,                    &ItemsList,
                                    CHOOSER_MaxLabels,                 18,
                                ChooserEnd,
                                Label("#2:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_CH3] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                             GID_SYN_CH3,
                                    GA_RelVerify,                      TRUE,
                                    CHOOSER_Labels,                    &ItemsList,
                                    CHOOSER_MaxLabels,                 18,
                                ChooserEnd,
                                Label("#3:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_CH4] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                             GID_SYN_CH4,
                                    GA_RelVerify,                      TRUE,
                                    CHOOSER_Labels,                    &ItemsList,
                                    CHOOSER_MaxLabels,                 18,
                                ChooserEnd,
                                Label("#4:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_CH5] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                             GID_SYN_CH5,
                                    GA_RelVerify,                      TRUE,
                                    CHOOSER_Labels,                    &ItemsList,
                                    CHOOSER_MaxLabels,                 18,
                                ChooserEnd,
                                Label("#5:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_CH6] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                             GID_SYN_CH6,
                                    GA_RelVerify,                      TRUE,
                                    CHOOSER_Labels,                    &ItemsList,
                                    CHOOSER_MaxLabels,                 18,
                                ChooserEnd,
                                Label("#6:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_CH7] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                             GID_SYN_CH7,
                                    GA_RelVerify,                      TRUE,
                                    CHOOSER_Labels,                    &ItemsList,
                                    CHOOSER_MaxLabels,                 18,
                                ChooserEnd,
                                Label("#7:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_CH8] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                             GID_SYN_CH8,
                                    GA_RelVerify,                      TRUE,
                                    CHOOSER_Labels,                    &ItemsList,
                                    CHOOSER_MaxLabels,                 18,
                                ChooserEnd,
                                Label("#8:"),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN1] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN1,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   999,
                                    INTEGER_MinVisible,                3 + 1,
                                IntegerEnd,
                                Label("Charges:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN2] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN2,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   999,
                                    INTEGER_MinVisible,                3 + 1,
                                IntegerEnd,
                                Label("Charges:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN3] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN3,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   999,
                                    INTEGER_MinVisible,                3 + 1,
                                IntegerEnd,
                                Label("Charges:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN4] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN4,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   999,
                                    INTEGER_MinVisible,                3 + 1,
                                IntegerEnd,
                                Label("Charges:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN5] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN5,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   999,
                                    INTEGER_MinVisible,                3 + 1,
                                IntegerEnd,
                                Label("Charges:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN6] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN6,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   999,
                                    INTEGER_MinVisible,                3 + 1,
                                IntegerEnd,
                                Label("Charges:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN7] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN7,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   999,
                                    INTEGER_MinVisible,                3 + 1,
                                IntegerEnd,
                                Label("Charges:"),
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN8] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN8,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   999,
                                    INTEGER_MinVisible,                3 + 1,
                                IntegerEnd,
                                Label("Charges:"),
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedWidth,                           0,
                        AddSpace,
                        AddVLayout,
                            AddSpace,
                            AddVLayout,
                                LAYOUT_Label,                          "Mods",
                                LAYOUT_BevelStyle,                     BVS_GROUP,
                                LAYOUT_SpaceOuter,                     TRUE,
                                LAYOUT_SpaceInner,                     TRUE,
                                AddSpace,
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN11] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN11,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   3,
                                    INTEGER_MinVisible,                1 + 1,
                                IntegerEnd,
                                Label("Brain: V"),
                                CHILD_WeightedHeight,                  0,
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN12] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN12,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   3,
                                    INTEGER_MinVisible,                1 + 1,
                                IntegerEnd,
                                Label("Eyes: V"),
                                CHILD_WeightedHeight,                  0,
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN13] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN13,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   3,
                                    INTEGER_MinVisible,                1 + 1,
                                IntegerEnd,
                                Label("Heart: V"),
                                CHILD_WeightedHeight,                  0,
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN14] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN14,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   3,
                                    INTEGER_MinVisible,                1 + 1,
                                IntegerEnd,
                                Label("Chest: V"),
                                CHILD_WeightedHeight,                  0,
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN15] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN15,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   3,
                                    INTEGER_MinVisible,                1 + 1,
                                IntegerEnd,
                                Label("Arms: V"),
                                CHILD_WeightedHeight,                  0,
                                LAYOUT_AddChild,                       gadgets[GID_SYN_IN16] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                             GID_SYN_IN16,
                                    GA_TabCycle,                       TRUE,
                                    GA_RelVerify,                      TRUE,
                                    INTEGER_Minimum,                   0,
                                    INTEGER_Maximum,                   3,
                                    INTEGER_MinVisible,                1 + 1,
                                IntegerEnd,
                                Label("Legs: V"),
                                CHILD_WeightedHeight,                  0,
                                AddSpace,
                            LayoutEnd,
                            CHILD_WeightedHeight,                      0,
                            AddSpace,
                        LayoutEnd,
                        CHILD_WeightedWidth,                           0,
                        AddSpace,
                    LayoutEnd,
                    MaximizeButton(GID_SYN_BU3, "Maximize Agent"),
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                             TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_SYN_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_SYN_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_SYN_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void syn_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_SYN_BU1:
        readgadgets();
        maximize_game();
        writegadgets();
    acase GID_SYN_BU2:
        namewindow();
    acase GID_SYN_BU3:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_SYN_IN10: // who
        readgadgets();
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_SYN_IN10], (ULONG*) &who);
        who--;
        writegadgets();
    adefault:
        if     (gid >= GID_SYN_CH1 && gid <= GID_SYN_CH8)
        {   readgadgets(); // read CHooser
            charges[who][gid - GID_SYN_CH1] = maxcharges[item[who][gid - GID_SYN_CH1]];
            writegadgets(); // write INteger
        } elif (gid >= GID_SYN_IN1 && gid <= GID_SYN_IN8)
        {   readgadgets(); // read INTEGER
            if (charges[who][gid - GID_SYN_IN1] > maxcharges[item[who][gid - GID_SYN_IN1]])
            {   charges[who][gid - GID_SYN_IN1] = maxcharges[item[who][gid - GID_SYN_IN1]];
                writegadgets(); // write INteger
}   }   }   }

EXPORT FLAG syn_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_SYNDICATE
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;

    eithergadgets();

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SYN_ST3], MainWindowPtr, NULL,
        STRINGA_TextVal, gamename,
    TAG_DONE); // this autorefreshes

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SYN_BU2], MainWindowPtr, NULL,
        GA_Text,     agentname[who] == 255 ? (const STRPTR) "Empty" : agentnames[agentname[who]],
        GA_Disabled, agentname[who] == 255 ? TRUE                   : FALSE,
    TAG_DONE); // this autorefreshes
}

MODULE void eithergadgets(void)
{   int i;

    either_st(GID_SYN_ST1 , yourname);
    either_st(GID_SYN_ST2 , companyname);
    either_in(GID_SYN_IN9 , &money);
    either_in(GID_SYN_IN11, &brain[who]);
    either_in(GID_SYN_IN12, &eyes[who]);
    either_in(GID_SYN_IN13, &heart[who]);
    either_in(GID_SYN_IN14, &chest[who]);
    either_in(GID_SYN_IN15, &arms[who]);
    either_in(GID_SYN_IN16, &legs[who]);
    either_ch(GID_SYN_CH9 , &sex[who]);

    for (i = 0; i < 8; i++)
    {   either_ch(GID_SYN_CH1 + i, &item[who][i]);
        either_in(GID_SYN_IN1 + i, &charges[who][i]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i, j;

    offset = 0;

    if (serializemode == SERIALIZE_READ)
    {   for (i = 0; i < 20; i++)
        {   gamename[i] = IOBuffer[offset++];
        }
        gamename[20] = EOS;
    }

    offset = 0x14;
    serialize4(&money);

    offset = 0x25;
    if (serializemode == SERIALIZE_READ)
    {   for (i = 0; i <= 16; i++)
        {   yourname[i] = IOBuffer[offset++];
        }
        offset = 0x37;
        for (i = 0; i <= 16; i++)
        {   companyname[i] = IOBuffer[offset++];
    }   }
    else
    {   // assert(serializemode == SERIALIZE_WRITE);

        for (i = 0; i <= 16; i++)
        {   IOBuffer[offset++] = yourname[i];
        }
        offset = 0x37;
        for (i = 0; i <= 16; i++)
        {   IOBuffer[offset++] = companyname[i];
    }   }

    offset = 0x132;
    for (i = 0; i < 18; i++)
    {   serialize1(&agentname[i]); // $132
        offset += 3;               // $133..$135
        body[i] &= 0xE000;
        body[i] |= sex[i];
        body[i] |= (legs[ i] <<  1);
        body[i] |= (arms[ i] <<  3);
        body[i] |= (chest[i] <<  5);
        body[i] |= (heart[i] <<  7);
        body[i] |= (brain[i] <<  9);
        body[i] |= (eyes[ i] << 11);
        serialize2ulong(&body[i]); // $136..$137
        sex[  i] =  body[i] & 0x0001;        // %.... .... .... ...#
        legs[ i] = (body[i] & 0x0006) >>  1; // %.... .... .... .##.
        arms[ i] = (body[i] & 0x0018) >>  3; // %.... .... ...# #...
        chest[i] = (body[i] & 0x0060) >>  5; // %.... .... .##. ....
        heart[i] = (body[i] & 0x0180) >>  7; // %.... ...# #... ....
        brain[i] = (body[i] & 0x0600) >>  9; // %.... .##. .... ....
        eyes[ i] = (body[i] & 0x1800) >> 11; // %...# #... .... ....

        offset += 4;          // $138..$13B
        for (j = 0; j < 8; j++)
        {   serialize2ulong(&charges[i][j]); // $13C..$13D
            offset++;                        // $13E
            if (item[i][j] == 14)
            {   item[i][j] = 17;
            }
            serialize1(&item[i][j]);         // $13F
            if (item[i][j] > 14)
            {   item[i][j] = 14;
}   }   }   }

EXPORT void syn_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("0?.gam", "Syndicate", saveas, 10288, FLAG_S, FALSE);
}

MODULE void maximize_man(void)
{   int i;

    for (i = 0; i < 8; i++)
    {   charges[who][i] = maxcharges[item[who][i]];
    }
    legs[ who] =
    arms[ who] =
    chest[who] =
    heart[who] =
    eyes[ who] =
    brain[who] = 3;
}

MODULE void maximize_game(void)
{   int i, j;

    money = 900000000; // nine hundred million

    for (i = 0; i < 18; i++)
    {   for (j = 0; j < 8; j++)
        {   charges[i][j] = maxcharges[item[i][j]];
        }
        legs[ i] =
        arms[ i] =
        chest[i] =
        heart[i] =
        eyes[ i] =
        brain[i] = 3;
}   }

MODULE void namewindow(void)
{   if (agentname[who] == 255) // should never happen
    {   return;
    }

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Choose Name",
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "syn-1",
        WINDOW_ParentGroup,                    gadgets[GID_SYN_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_SYN_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_SYN_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &NamesList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    160,
            CHILD_MinHeight,                   416,
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

    DISCARD SetGadgetAttrs(         gadgets[GID_SYN_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,      ~0,             TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_SYN_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,      &NamesList,     TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_SYN_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    agentname[who], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_SYN_LB1], SubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(         gadgets[GID_SYN_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, agentname[who], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_SYN_LB1], SubWindowPtr, NULL);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG syn_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_SYN_LB1:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_SYN_LB1], (ULONG*) &agentname[who]);
        writegadgets();
        return TRUE;
    }

    return FALSE;
}

EXPORT FLAG syn_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_UP:
        lb_move_up(GID_SYN_LB1, SubWindowPtr, qual, &agentname[who], 0, 5);
        writegadgets();
    acase SCAN_DOWN:
        lb_move_down(GID_SYN_LB1, SubWindowPtr, qual, &agentname[who], 68, 5);
        writegadgets();
    acase NM_WHEEL_UP:
        lb_scroll_up(GID_SYN_LB1, SubWindowPtr, qual);
    acase NM_WHEEL_DOWN:
        lb_scroll_down(GID_SYN_LB1, SubWindowPtr, qual);
    acase SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    }
    return FALSE;
}

EXPORT void syn_exit(void)
{   ch_clearlist(&ItemsList);
    ch_clearlist(&SexList);
}
EXPORT void syn_die(void)
{   lb_clearlist(&NamesList);
}

EXPORT void syn_close(void) { ; }

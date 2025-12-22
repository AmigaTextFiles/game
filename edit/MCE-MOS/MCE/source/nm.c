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

/* 2. DEFINES ------------------------------------------------------------

main window */
#define GID_NM_LY1     0 // root layout
#define GID_NM_SB1     1 // toolbar
#define GID_NM_ST1     2 // name
#define GID_NM_BU1     3 // maximize character
#define GID_NM_BU2     4 // 1st inventory name (read-only)
#define GID_NM_BU33   35 // 32nd inventory name (read-only)
#define GID_NM_BU34   36 // all
#define GID_NM_BU35   37 // invert
#define GID_NM_BU36   38 // none
#define GID_NM_BU37   39 // more
#define GID_NM_IN1    40 // bank money
#define GID_NM_IN2    41 // chip money
#define GID_NM_IN3    42 // cur con
#define GID_NM_IN4    43 // max con
#define GID_NM_IN15   44 // Bargaining skill
#define GID_NM_IN16   45 // CopTalk skill
#define GID_NM_IN17   46 // Cryptology
#define GID_NM_IN18   47 // Debugging
#define GID_NM_IN19   48 // Evasion
#define GID_NM_IN20   49 // Hardware
#define GID_NM_IN21   50 // ICE Breaking skill
#define GID_NM_IN22   51 // Japanese skill
#define GID_NM_IN23   52 // Logic skill
#define GID_NM_IN24   53 // Musicianship skill
#define GID_NM_IN25   54 // Phenomenology skill
#define GID_NM_IN26   55 // Philosophy skill
#define GID_NM_IN27   56 // Psychoanalysis skill
#define GID_NM_IN28   57 // Software Analysis skill
#define GID_NM_IN29   58 // Sophistry skill
#define GID_NM_IN30   59 // Zen skill
#define GID_NM_CB1    60 // Heart
#define GID_NM_CB2    61 // Eyes
#define GID_NM_CB3    62 // Lungs
#define GID_NM_CB4    63 // Stomach
#define GID_NM_CB5    64 // Liver
#define GID_NM_CB6    65 // Kidneys
#define GID_NM_CB7    66 // Gall Bladder
#define GID_NM_CB8    67 // Pancreas
#define GID_NM_CB9    68 // Legs
#define GID_NM_CB10   69 // Arms
#define GID_NM_CB11   70 // Tongue
#define GID_NM_CB12   71 // Larynx
#define GID_NM_CB13   72 // Nose
#define GID_NM_CB14   73 // Ears
#define GID_NM_CB15   74 // Large Intestine
#define GID_NM_CB16   75 // Small Intestine
#define GID_NM_CB17   76 // Spleen
#define GID_NM_CB18   77 // Bone Marrow
#define GID_NM_CB19   78 // Spinal Fluid
#define GID_NM_CB20   79 // Appendix

// more subwindow
#define GID_NM_LY3    80
#define GID_NM_CH1    81 //  1st software
#define GID_NM_CH32  112 // 32nd software
#define GID_NM_IN31  113 //  1st version
#define GID_NM_IN62  144 // 32nd version

// items subsubwindow
#define GID_NM_LY2   145
#define GID_NM_LB1   146
#define GID_NM_IN63  147 // item version

#define GIDS_NM      GID_NM_IN63

#define ITEMS          77

#define ItemButton(x)  LAYOUT_AddChild, gadgets[GID_NM_BU2  + x] = (struct Gadget*) ZButtonObject, GA_ID, GID_NM_BU2  + x, GA_RelVerify, TRUE, BUTTON_Justification, BCJ_LEFT, ButtonEnd
#define SoftwareGad(x) LAYOUT_AddChild, gadgets[GID_NM_CH1  + x] = (struct Gadget*) PopUpObject,   GA_ID, GID_NM_CH1  + x, CHOOSER_LabelArray, &SoftwareOptions, CHOOSER_MaxLabels, 29, PopUpEnd
#define VersionGad(x)  LAYOUT_AddChild, gadgets[GID_NM_IN31 + x] = (struct Gadget*) IntegerObject, GA_ID, GID_NM_IN31 + x, GA_TabCycle,  TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 6, INTEGER_Number, version[x], INTEGER_MinVisible, 1 + 1, IntegerEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(void);
MODULE void eithergadgets(void);
MODULE void itemwindow(void);
MODULE void morewindow(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Library*      TickBoxBase;
IMPORT Object              *aissimage[AISSIMAGES],
                           *image[BITMAPS],
                           *WinObject,
                           *SubWinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
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

MODULE ULONG                bankgp,
                            chipgp,
                            curhp,
                            maxhp,
                            item[32],
                            itemversion[32],
                            skill[16],
                            body[20],
                            software[32],
                            version[32];
MODULE TEXT                 itemdisplay[32][40 + 1],
                            name[8 + 1];
MODULE int                  whichitem;
MODULE struct List          ItemsList;
MODULE struct Window*       SubSubWindowPtr = NULL;

MODULE const STRPTR SoftwareOptions[29 + 1] =
{   "Mimic",        //  0
    "Jammies",
    "ThunderHead",
    "Vaccine",
    "Blammo (virus)",
    "DoorStop",     //  5
    "Decoder",
    "Sequencer",
    "ArmorAll",
    "KGB",
    "Comlink",      // 10
    "BlowTorch",
    "Probe",
    "Drill",
    "Hammer",
    "Python",       // 15
    "Acid",
    "Injector",
    "DepthCharge",
    "Concrete",
    "EasyRider",    // 20
    "LogicBomb",
    "Cyberspace",
    "Slow",
    "BattleChess (non-virus)",
    "BattleChess (virus)", // 25
    "Scout",
    "Hemlock",
    "None",
    NULL            // 29
}, ItemNames[ITEMS] =
{   "None",
    "Mimic",          //  1
    "Jammies",
    "ThunderHead",
    "Vaccine",
    "Blammo",
    "DoorStop",       //  6
    "Decoder",
    "Sequencer",
    "ArmorAll",
    "KGB",
    "Comlink",        // 11
    "BlowTorch",
    "Probe",
    "Drill",
    "Hammer",
    "Python",         // 16
    "Acid",
    "Injector",
    "DepthCharge",
    "Concrete",
    "EasyRider",      // 21
    "LogicBomb",
    "Cyberspace",
    "Slow",
    "BattleChess",
    "BattleChess?",   // 26
    "Scout",
    "Hemlock",
    "Kuang Eleven",
    "Hiki Gaeru",
    "Gaijin",         // 31
    "Bushido",
    "Edokko",
    "Katana",
    "Tofu",
    "Shogun",         // 36
    "188BJB",
    "350SL",
    "UXB",
    "ZXB",            // 40
    "Cyberspace II",
    "Cyberspace III",
    "Cyberspace VII",
    "Ninja 2000",
    "Ninja 3000",     // 45
    "Ninja 4000",
    "Ninja 5000",
    "Blue Light Special",
    "Samurai Seven",
    "Bargaining",     // 50
    "CopTalk",
    "Software Analysis",
    "Debugging",
    "Hardware Repair",
    "ICE Breaking",   // 55
    "Evasion",
    "Cryptology",
    "Japanese",
    "Logic",
    "Psychoanalysis", // 60
    "Phenomenology",
    "Philosophy",
    "Sophistry",
    "Zen",
    "Musicianship",   // 65
    "CyberEyes",
    "Guest pass",
    "Joystick",
    "Caviar",
    "Pawn ticket",    // 70
    "Security pass",
    "Zion ticket",
    "Freeside ticket",
    "Chiba ticket",
    "Gas mask",       // 75
    "Sake"            // 76
};
MODULE const ULONG ItemNumbers[ITEMS] =
{  255,
     0,
     1,
     2,
     3,
     4,
     5,
     6,
     7,
     8,
     9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    40, // 39
    42, // 40
    43, // 41
    44, // 42
    46, // 43
    47, // 44
    48, // 45
    49, // 46
    50, // 47
    51, // 48
    52, // 49
    67, // 50
    68, // 51
    69, // 52
    70, // 53
    71, // 54
    72, // 55
    73,
    74,
    75,
    76,
    77, // 60
    78,
    79,
    80,
    81,
    82, // 65
    83,
    86,
    89,
    94,
    95, // 70
    96,
    97,
    98,
   100,
   101, // 75
   103  // 76
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  .OOO OOOO OOOO O...    . = Transparent (%00)
    OSSS SSSS SSSS SOO.    S = Skin        (%01) ($FCA)
    .OOO OOOO OOSS SSSO    O = Orange      (%10) ($E52)
    .... OSOS SSSS SSSO
    .... OSOS SOOS SSSO
    .... .OOO OSOO OOOO
    .... .OSO SOSS SOO.
    .... ..OO OOOO OO..

          Plane 1                Plane 0
    .OOO OOOO OOOO O...    .... .... .... ....
    O... .... .... .OO.    .SSS SSSS SSSS S...
    .OOO OOOO OO.. ...O    .... .... ..SS SSS.
    .... O.O. .... ...O    .... .S.S SSSS SSS.
    .... O.O. .OO. ...O    .... .S.S S..S SSS.
    .... .OOO O.OO OOOO    .... .... .S.. ....
    .... .O.O .O.. .OO.    .... ..S. S.SS S...
    .... ..OO OOOO OO..    .... .... .... ....
          Orange                  Skin
*/
    0x7FF8, 0x0000,
    0x8006, 0x7FF8,
    0x7FC1, 0x003E,
    0x0A01, 0x05FE,
    0x0A61, 0x059E,
    0x07BF, 0x0040,
    0x0146, 0x02B8,
    0x03FC, 0x0000,

    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,

    0x0000, 0x0000  // reserved
};
#endif

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void nm_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // nm_preinit()
        NewList(&ItemsList);

        // nm_init()
        lb_makelist(&ItemsList, ItemNames, ITEMS);
    }

    tool_open      = nm_open;
    tool_loop      = nm_loop;
    tool_save      = nm_save;
    tool_close     = nm_close;
    tool_exit      = nm_exit;
    tool_subgadget = nm_subgadget;

    if (loaded != FUNC_NEUROMANCER && !nm_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_NEUROMANCER;

    make_speedbar_list(GID_NM_SB1);
    load_aiss_images( 6,  8);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_NM_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddToolbar(GID_NM_SB1),
            AddHLayout,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "General",
                        LAYOUT_AddChild,                   gadgets[GID_NM_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_NM_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               name,
                            STRINGA_MaxChars,              8 + 1,
                        StringEnd,
                        Label("Name:"),
                        AddHLayout,
                            LAYOUT_AddChild,               gadgets[GID_NM_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN3,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           65535,
                                INTEGER_Number,            curhp,
                                INTEGER_MinVisible,        5 + 1,
                            IntegerEnd,
                            LAYOUT_AddChild,               gadgets[GID_NM_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN4,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           65535,
                                INTEGER_Number,            maxhp,
                                INTEGER_MinVisible,        5 + 1,
                            IntegerEnd,
                            Label("of"),
                        LayoutEnd,
                        Label("Constitution:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_NM_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_NM_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99999999,
                            INTEGER_Number,                bankgp,
                            INTEGER_MinVisible,            8 + 1,
                        IntegerEnd,
                        Label("Bank Money:"),
                        LAYOUT_AddChild,                   gadgets[GID_NM_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_NM_IN2,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99999999,
                            INTEGER_Number,                chipgp,
                            INTEGER_MinVisible,            8 + 1,
                        IntegerEnd,
                        Label("Chip Money:"),
                    LayoutEnd,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "Skills",
                            LAYOUT_AddChild,               gadgets[GID_NM_IN15] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN15,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[0],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Bargaining:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN16] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN16,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[1],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("CopTalk:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN17] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN17,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[2],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Cryptology:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN18] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN18,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[3],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Debugging:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN19] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN19,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[4],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Evasion:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN20] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN20,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[5],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Hardware:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN21] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN21,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[6],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("ICE Breaking:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN22] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN22,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[7],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Japanese:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN23] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN23,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[8],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Logic:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN24] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN24,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[9],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Musicianship:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN25] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN25,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[10],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Phenomenology:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN26] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN26,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[11],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Philosophy:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN27] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN27,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[12],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Psychoanalysis:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN28] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN28,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[13],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Software Analysis:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN29] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN29,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[14],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Sophistry:"),
                            LAYOUT_AddChild,               gadgets[GID_NM_IN30] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_NM_IN30,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           99,
                                INTEGER_Number,            skill[15],
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            Label("Zen:"),
                        LayoutEnd,
                    LayoutEnd,
                    LAYOUT_AddChild,                       gadgets[GID_NM_BU37] = (struct Gadget*)
                    ZButtonObject,
                        GA_Text,                           "Items, Software...",
                        GA_ID,                             GID_NM_BU37,
                        GA_RelVerify,                      TRUE,
                    ButtonEnd,
                    MaximizeButton(GID_NM_BU1, "Maximize Character"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Body Parts",
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB1] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB1,
                        GA_Selected,                       body[0],
                        GA_Text,                           "Heart",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB2] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB2,
                        GA_Selected,                       body[1],
                        GA_Text,                           "Eyes",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB3] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB3,
                        GA_Selected,                       body[2],
                        GA_Text,                           "Lungs",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB4] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB4,
                        GA_Selected,                       body[3],
                        GA_Text,                           "Stomach",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB5] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB5,
                        GA_Selected,                       body[4],
                        GA_Text,                           "Liver",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB6] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB6,
                        GA_Selected,                       body[5],
                        GA_Text,                           "Kidneys",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB7] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB7,
                        GA_Selected,                       body[6],
                        GA_Text,                           "Gall Bladder",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB8] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB8,
                        GA_Selected,                       body[7],
                        GA_Text,                           "Pancreas",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB9] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB9,
                        GA_Selected,                       body[8],
                        GA_Text,                           "Legs",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB10] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB10,
                        GA_Selected,                       body[9],
                        GA_Text,                           "Arms",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB11] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB11,
                        GA_Selected,                       body[10],
                        GA_Text,                           "Tongue",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB12] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB12,
                        GA_Selected,                       body[11],
                        GA_Text,                           "Larynx",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB13] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB13,
                        GA_Selected,                       body[12],
                        GA_Text,                           "Nose",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB14] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB14,
                        GA_Selected,                       body[13],
                        GA_Text,                           "Ears",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB15] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB15,
                        GA_Selected,                       body[14],
                        GA_Text,                           "Large Intestine",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB16] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB16,
                        GA_Selected,                       body[15],
                        GA_Text,                           "Small Intestine",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB17] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB17,
                        GA_Selected,                       body[16],
                        GA_Text,                           "Spleen",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB18] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB18,
                        GA_Selected,                       body[17],
                        GA_Text,                           "Bone Marrow",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB19] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB19,
                        GA_Selected,                       body[18],
                        GA_Text,                           "Spinal Fluid",
                    End,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_NM_CB20] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_NM_CB20,
                        GA_Selected,                       body[19],
                        GA_Text,                           "Appendix",
                    End,
                    VTripleButton(GID_NM_BU34, GID_NM_BU35, GID_NM_BU36),
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_NM_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_NM_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_NM_ST1]);

    loop();

    readgadgets();
    closewindow();
}

EXPORT void nm_loop(ULONG gid, UNUSED ULONG code)
{   int i;

    switch (gid)
    {
    case GID_NM_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_NM_BU34: // all
        readgadgets();
        for (i = 0; i < 20; i++)
        {   body[i] = TRUE;
        }
        writegadgets();
    acase GID_NM_BU35: // invert
        readgadgets();
        for (i = 0; i < 20; i++)
        {   body[i] = (body[i] ? FALSE : TRUE);
        }
        writegadgets();
    acase GID_NM_BU36: // none
        readgadgets();
        for (i = 0; i < 20; i++)
        {   body[i] = FALSE;
        }
        writegadgets();
    acase GID_NM_BU37:
        morewindow();
}   }

MODULE void writegadgets(void)
{   if
    (   page != FUNC_NEUROMANCER
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

                             either_st(GID_NM_ST1     ,  name);
    for (i = 0; i < 16; i++) either_in(GID_NM_IN15 + i, &skill[i]);
    for (i = 0; i < 20; i++) either_cb(GID_NM_CB1  + i, &body[i]);
                             either_in(GID_NM_IN1     , &bankgp);
                             either_in(GID_NM_IN2     , &chipgp);
                             either_in(GID_NM_IN3     , &curhp);
                             either_in(GID_NM_IN4     , &maxhp);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   ULONG temp;
    int   i, j;

    offset        = 0x1FE;
    if (serializemode == SERIALIZE_READ)
    {   zstrncpy(name, (char*) &IOBuffer[offset], 8); // $1FE..$205
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        strncpy((char*) &IOBuffer[offset], name, 8);
        // *not* zstrncpy() because we don't want to NUL-terminate it!
    }
    offset        = 0x1DE;
    for (i = 0; i < 16; i++)
    {   if (serializemode == SERIALIZE_READ)
        {   serialize1(&temp);            // $1DE..$1ED
            if (temp == 255)
            {   temp = 0;
            } else
            {   temp++;
            }
            skill[i] = temp;
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            if (skill[i] == 0)
            {   temp = 255;
            } else
            {   temp = skill[i] - 1;
            }
            serialize1(&temp);
    }   }

    offset = 0x15E;
    for (i = 0; i < 32; i++)
    {   if (serializemode == SERIALIZE_READ)
        {   serialize1(&temp);
            for (j = 0; j < ITEMS; j++)
            {   temp = 0; // in case we don't find anything
                if (temp == ItemNumbers[j])
                {   temp = j;
                    break; // for speed
            }   }
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            temp = ItemNumbers[item[i]];
            serialize1(&temp);
        }
        serialize1(&itemversion[i]);
        offset += 2;
    }

    offset        = 0x20A;
    serialize2ulong(&maxhp);
    offset        = 0x20E;
    serialize2ulong(&curhp);
    for (i = 0; i < 20; i++)
    {   body[i] = FALSE;
    }
    offset        = 0x216;
    if (serializemode == SERIALIZE_READ)
    {   serialize1(&temp);                // $216
        if (temp & 0x80) body[ 6] = TRUE; // heart
        if (temp & 0x40) body[ 4] = TRUE; // eyes
        if (temp & 0x20) body[13] = TRUE; // lungs
        if (temp & 0x10) body[18] = TRUE; // stomach
        if (temp &    8) body[12] = TRUE; // liver
        if (temp &    4) body[ 9] = TRUE; // kidneys
        if (temp &    2) body[ 5] = TRUE; // gall bladder
        if (temp &    1) body[15] = TRUE; // pancreas
        serialize1(&temp);                // $217
        if (temp & 0x80) body[11] = TRUE; // legs
        if (temp & 0x40) body[ 1] = TRUE; // arms
        if (temp & 0x20) body[19] = TRUE; // tongue
        if (temp & 0x10) body[10] = TRUE; // larynx
        if (temp &    8) body[14] = TRUE; // nose
        if (temp &    4) body[ 3] = TRUE; // ears
        if (temp &    2) body[ 7] = TRUE; // large intestine
        if (temp &    1) body[ 8] = TRUE; // small intestine
        serialize1(&temp);                // $218
        if (temp & 0x80) body[17] = TRUE; // spleen
        if (temp & 0x40) body[ 2] = TRUE; // bone marrow
        if (temp & 0x20) body[16] = TRUE; // spinal fluid
        if (temp & 0x10) body[ 0] = TRUE; // appendix
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        temp = 0;
        if (!(body[ 6])) temp |= 0x80; // heart
        if (!(body[ 4])) temp |= 0x40; // eyes
        if (!(body[13])) temp |= 0x20; // lungs
        if (!(body[18])) temp |= 0x10; // stomach
        if (!(body[12])) temp |=    8; // liver
        if (!(body[ 9])) temp |=    4; // kidneys
        if (!(body[ 5])) temp |=    2; // gall bladder
        if (!(body[15])) temp |=    1; // pancreas
        serialize1(&temp);
        temp = 0;
        if (!(body[11])) temp |= 0x80; // legs
        if (!(body[ 1])) temp |= 0x40; // arms
        if (!(body[19])) temp |= 0x20; // tongue
        if (!(body[10])) temp |= 0x10; // larynx
        if (!(body[14])) temp |=    8; // nose
        if (!(body[ 3])) temp |=    4; // ears
        if (!(body[ 7])) temp |=    2; // large intestine
        if (!(body[ 8])) temp |=    1; // small intestine
        serialize1(&temp);
        temp = 0;
        if (!(body[17])) temp |= 0x80; // spleen
        if (!(body[ 2])) temp |= 0x40; // bone marrow
        if (!(body[16])) temp |= 0x20; // spinal fluid
        if (!(body[ 0])) temp |= 0x10; // appendix
        serialize1(&temp);
    }

    offset        = 0x21E;
    serialize4(&chipgp); // $21E..$221
    serialize4(&bankgp); // $222..$225
    offset        = 0x254;
    for (i = 0; i < 32; i++)
    {   if (software[i] > 28)
        {   software[i] = 255;
        }
        serialize1(&software[i]);
        if (software[i] > 28)
        {   software[i] = 28;
        }
        serialize1(&version[i]);
        offset += 2;
}   }

EXPORT FLAG nm_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}
EXPORT void nm_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("Game#?", "Neuromancer", saveas, 1564, FLAG_S, FALSE);
}

EXPORT void nm_die(void)
{   lb_clearlist(&ItemsList);
}

EXPORT void nm_close(void) { ; }
EXPORT void nm_exit(void)  { ; }

MODULE void maximize_man(void)
{   int i;

    for (i = 0; i < 16; i++)
    {   skill[i]    = 90;
    }
    for (i = 0; i < 20; i++)
    {   body[i]     = TRUE;
    }
    for (i = 0; i <= 27; i++)
    {   version[i]  =  6;
        software[i] =  i;
    }
    for (i = 28; i <= 31; i++)
    {   version[i]  =  0;
        software[i] = 28;
    }
    curhp           =
    maxhp           =    65000;
    bankgp          =
    chipgp          = 90000000;
}

EXPORT FLAG nm_subgadget(ULONG gid, UNUSED UWORD code)
{   if (gid >= GID_NM_BU2 && gid <= GID_NM_BU33)
    {   whichitem = gid - GID_NM_BU2;
        itemwindow();
    }

    return FALSE;
}

EXPORT FLAG nm_subkey(UWORD code, UWORD qual)
{   if (!(qual & IEQUALIFIER_REPEAT) && !SubSubWindowPtr)
    {   switch (code)
        {
        case SCAN_RETURN:
        case SCAN_ENTER:
            return TRUE;
    }   }

    return FALSE;
}

MODULE void morewindow(void)
{   int i;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                                      "Choose Items & Software",
        WA_SizeGadget,                                 TRUE,
        WA_ThinSizeGadget,                             TRUE,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                               "nm-1",
        WINDOW_ParentGroup,                            gadgets[GID_NM_LY2] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_GROUP,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "Items",
                ItemButton( 0),
                ItemButton( 1),
                ItemButton( 2),
                ItemButton( 3),
                ItemButton( 4),
                ItemButton( 5),
                ItemButton( 6),
                ItemButton( 7),
                ItemButton( 8),
                ItemButton( 9),
                ItemButton(10),
                ItemButton(11),
                ItemButton(12),
                ItemButton(13),
                ItemButton(14),
                ItemButton(15),
                ItemButton(16),
                ItemButton(17),
                ItemButton(18),
                ItemButton(19),
                ItemButton(20),
                ItemButton(21),
                ItemButton(22),
                ItemButton(23),
                ItemButton(24),
                ItemButton(25),
                ItemButton(26),
                ItemButton(27),
                ItemButton(28),
                ItemButton(29),
                ItemButton(30),
                ItemButton(31),
            LayoutEnd,
            CHILD_MinWidth,                            128,
            AddHLayout,
                LAYOUT_BevelStyle,                     BVS_GROUP,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "Software",
                AddVLayout,
                    SoftwareGad(0),
                    SoftwareGad(1),
                    SoftwareGad(2),
                    SoftwareGad(3),
                    SoftwareGad(4),
                    SoftwareGad(5),
                    SoftwareGad(6),
                    SoftwareGad(7),
                    SoftwareGad(8),
                    SoftwareGad(9),
                    SoftwareGad(10),
                    SoftwareGad(11),
                    SoftwareGad(12),
                    SoftwareGad(13),
                    SoftwareGad(14),
                    SoftwareGad(15),
                    SoftwareGad(16),
                    SoftwareGad(17),
                    SoftwareGad(18),
                    SoftwareGad(19),
                    SoftwareGad(20),
                    SoftwareGad(21),
                    SoftwareGad(22),
                    SoftwareGad(23),
                    SoftwareGad(24),
                    SoftwareGad(25),
                    SoftwareGad(26),
                    SoftwareGad(27),
                    SoftwareGad(28),
                    SoftwareGad(29),
                    SoftwareGad(30),
                    SoftwareGad(31),
                LayoutEnd,
                AddVLayout,
                    VersionGad(0),
                    VersionGad(1),
                    VersionGad(2),
                    VersionGad(3),
                    VersionGad(4),
                    VersionGad(5),
                    VersionGad(6),
                    VersionGad(7),
                    VersionGad(8),
                    VersionGad(9),
                    VersionGad(10),
                    VersionGad(11),
                    VersionGad(12),
                    VersionGad(13),
                    VersionGad(14),
                    VersionGad(15),
                    VersionGad(16),
                    VersionGad(17),
                    VersionGad(18),
                    VersionGad(19),
                    VersionGad(20),
                    VersionGad(21),
                    VersionGad(22),
                    VersionGad(23),
                    VersionGad(24),
                    VersionGad(25),
                    VersionGad(26),
                    VersionGad(27),
                    VersionGad(28),
                    VersionGad(29),
                    VersionGad(30),
                    VersionGad(31),
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

    for (i = 0; i < 32; i++)
    {   if (item[i] >= 1 && item[i] <= 28)
        {   sprintf(itemdisplay[i], "%s %d.0", ItemNames[item[i]], (int) itemversion[i]);
        } else
        {   strcpy(itemdisplay[i], ItemNames[item[i]]);
        }
        SetGadgetAttrs(                 gadgets[GID_NM_BU2  + i], SubWindowPtr, NULL, GA_Text,                 itemdisplay[i], TAG_DONE); // autorefreshes
        SetGadgetAttrs(                 gadgets[GID_NM_CH1  + i], SubWindowPtr, NULL, CHOOSER_Selected, (WORD) software[i],    TAG_DONE); // autorefreshes
        RefreshGadgets((struct Gadget*) gadgets[GID_NM_CH1  + i], SubWindowPtr, NULL);
        SetGadgetAttrs(                 gadgets[GID_NM_IN31 + i], SubWindowPtr, NULL, INTEGER_Number,   (WORD) version[i],     TAG_DONE); // autorefreshes
        RefreshGadgets((struct Gadget*) gadgets[GID_NM_IN31 + i], SubWindowPtr, NULL);
    }

    subloop();

    for (i = 0; i < 32; i++)
    {   GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_NM_CH1  + i], (ULONG*) &software[i]);
        GetAttr(INTEGER_Number,   (Object*) gadgets[GID_NM_IN31 + i], (ULONG*) &version[i]);
    }

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE void itemwindow(void)
{   FLAG    done = FALSE;
    UWORD   code;
    ULONG   event,
            LocalSignal,
            qual,
            result;
    Object* SubSubWinObject;

    lockscreen();
    if (!(SubSubWinObject =
    NewSubWindow,
        WA_Title,                              "Choose Item",
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "nm-2",
        WINDOW_ParentGroup,                    gadgets[GID_NM_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_NM_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_NM_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &ItemsList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    128,
            CHILD_MinHeight,                   512 - 64,
            LAYOUT_AddChild,                   gadgets[GID_NM_IN63] = (struct Gadget*)
            IntegerObject,
                GA_ID,                         GID_NM_IN63,
                GA_RelVerify,                  TRUE,
                GA_TabCycle,                   TRUE,
                INTEGER_Minimum,               0,
                INTEGER_Maximum,               6,
                INTEGER_Number,                itemversion[whichitem],
                INTEGER_MinVisible,            1 + 1,
            IntegerEnd,
            Label("_Version:"),
            CHILD_WeightedHeight,              0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubSubWindowPtr = (struct Window*) RA_OpenWindow(SubSubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubSubWindowPtr->Width, SubSubWindowPtr->Height);
#endif
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, SubSubWinObject, SubSubWindowPtr, TRUE);
#endif

    DISCARD SetGadgetAttrs(         gadgets[GID_NM_LB1], SubSubWindowPtr, NULL, LISTBROWSER_Labels,              ~0,              TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_NM_LB1], SubSubWindowPtr, NULL, LISTBROWSER_Labels,              &ItemsList,      TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_NM_LB1], SubSubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) item[whichitem], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_NM_LB1], SubSubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(         gadgets[GID_NM_LB1], SubSubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) item[whichitem], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_NM_LB1], SubSubWindowPtr, NULL);

    GetAttr(INTEGER_Number, (Object*) gadgets[GID_NM_IN63], (ULONG*) &itemversion[whichitem]);
    if (item[whichitem] < 1 || item[whichitem] > 28)
    {   itemversion[whichitem] = 0;
    }
    DISCARD SetGadgetAttrs
    (   gadgets[GID_NM_IN63], SubSubWindowPtr, NULL,
        GA_Disabled,    item[whichitem] < 1 || item[whichitem] > 28,
        INTEGER_Number, itemversion[whichitem],
    TAG_END); // this autorefreshes

    // Obtain the window wait signal mask.
    DISCARD GetAttr(WINDOW_SigMask, SubSubWinObject, (ULONG*) &LocalSignal);

    do
    {   DISCARD Wait(LocalSignal);
        while ((result = DoMethod(SubSubWinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
        {   event = result & WMHI_CLASSMASK;
            switch (event)
            {
            case WMHI_CLOSEWINDOW:
                done = TRUE;
            acase WMHI_RAWKEY:
                GetAttr(WINDOW_Qualifier, SubSubWinObject, &qual);
                if (!(qual & IEQUALIFIER_REPEAT))
                {   switch (code)
                    {
                    case SCAN_RETURN:
                    case SCAN_ENTER:
                        done = TRUE;
                    acase SCAN_UP:
                    case NM_WHEEL_UP:
                        lb_scroll_up(GID_NM_LB1, SubSubWindowPtr, qual);
                    acase SCAN_DOWN:
                    case NM_WHEEL_DOWN:
                        lb_scroll_down(GID_NM_LB1, SubSubWindowPtr, qual);
                    acase SCAN_V:
                        ActivateLayoutGadget(gadgets[GID_NM_LY2], SubSubWindowPtr, NULL, (Object) gadgets[GID_NM_IN63]);
                }   }
            acase WMHI_GADGETUP:
                switch (result & WMHI_GADGETMASK)
                {
                case GID_NM_LB1:
                    DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_NM_LB1],  (ULONG*) &item[whichitem]       );
                    DISCARD GetAttr(INTEGER_Number,       (Object*) gadgets[GID_NM_IN63], (ULONG*) &itemversion[whichitem]);
                    if (item[whichitem] < 1 || item[whichitem] > 28)
                    {   itemversion[whichitem] = 0;
                    } elif (itemversion[whichitem] == 0)
                    {   itemversion[whichitem] = 6;
                    }
                    if (item[whichitem] >= 1 && item[whichitem] <= 28)
                    {   sprintf(itemdisplay[whichitem], "%s %d.0", ItemNames[item[whichitem]], (int) itemversion[whichitem]);
                    } else
                    {   strcpy(itemdisplay[whichitem], ItemNames[item[whichitem]]);
                    }
                    SetGadgetAttrs(                 gadgets[GID_NM_BU2  + whichitem], SubWindowPtr, NULL, GA_Text,                 itemdisplay[whichitem], TAG_DONE); // autorefreshes
                    SetGadgetAttrs(                 gadgets[GID_NM_CH1  + whichitem], SubWindowPtr, NULL, CHOOSER_Selected, (WORD) software[   whichitem], TAG_DONE); // autorefreshes
                    RefreshGadgets((struct Gadget*) gadgets[GID_NM_CH1  + whichitem], SubWindowPtr, NULL);
                    SetGadgetAttrs(                 gadgets[GID_NM_IN31 + whichitem], SubWindowPtr, NULL, INTEGER_Number,   (WORD) version[    whichitem], TAG_DONE); // autorefreshes
                    RefreshGadgets((struct Gadget*) gadgets[GID_NM_IN31 + whichitem], SubWindowPtr, NULL);
                    SetGadgetAttrs
                    (   gadgets[GID_NM_IN63], SubSubWindowPtr, NULL,
                        GA_Disabled,    item[whichitem] < 1 || item[whichitem] > 28,
                        INTEGER_Number, itemversion[whichitem],
                    TAG_END); // this autorefreshes
                    if (item[whichitem] >= 1 && item[whichitem] <= 28)
                    {   DISCARD ActivateLayoutGadget(gadgets[GID_NM_LY2], SubSubWindowPtr, NULL, (Object) gadgets[GID_NM_IN63]);
                    }
                acase GID_NM_IN63:
                    DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_NM_IN63], (ULONG*) &itemversion[whichitem]);
                    if (item[whichitem] >= 1 && item[whichitem] <= 28)
                    {   sprintf(itemdisplay[whichitem], "%s %d.0", ItemNames[item[whichitem]], (int) itemversion[whichitem]);
                    } else
                    {   strcpy(itemdisplay[whichitem], ItemNames[item[whichitem]]);
                    }
                    SetGadgetAttrs(                 gadgets[GID_NM_BU2  + whichitem], SubWindowPtr, NULL, GA_Text,                 itemdisplay[whichitem], TAG_DONE); // autorefreshes
                    SetGadgetAttrs(                 gadgets[GID_NM_CH1  + whichitem], SubWindowPtr, NULL, CHOOSER_Selected, (WORD) software[   whichitem], TAG_DONE); // autorefreshes
                    RefreshGadgets((struct Gadget*) gadgets[GID_NM_CH1  + whichitem], SubWindowPtr, NULL);
                    SetGadgetAttrs(                 gadgets[GID_NM_IN31 + whichitem], SubWindowPtr, NULL, INTEGER_Number,   (WORD) version[    whichitem], TAG_DONE); // autorefreshes
                    RefreshGadgets((struct Gadget*) gadgets[GID_NM_IN31 + whichitem], SubWindowPtr, NULL);
    }   }   }   }
    while (!done);
  
    GetAttr(INTEGER_Number, (Object*) gadgets[GID_NM_IN63], (ULONG*) &itemversion[whichitem]);

    clearkybd();

    DisposeObject(SubSubWinObject);
    // SubSubWinObject = NULL;
    SubSubWindowPtr = NULL;
}

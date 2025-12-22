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

#define GID_PSYG_LY1   0 // root layout
#define GID_PSYG_SB1   1 // toolbar
#define GID_PSYG_BU1   2 // maximize
#define GID_PSYG_CH4   3 // sound
// GID_PSYG_RA1 is spare (unused)
#define GID_PSYG_RA2   4 // pistol  flag
#define GID_PSYG_RA3   5 // rifle   flag
#define GID_PSYG_RA4   6 // blaster flag
#define GID_PSYG_RA5   7 // bazooka flag
#define GID_PSYG_IN1   8 // score
#define GID_PSYG_IN2   9 // pistol  ammo
#define GID_PSYG_IN3  10 // rifle   ammo
#define GID_PSYG_IN4  11 // blaster ammo
#define GID_PSYG_IN5  12 // bazooka ammo
#define GID_PSYG_CB1  13
#define GID_PSYG_CB2  14
#define GID_PSYG_CB3  15
#define GID_PSYG_CB4  16
#define GID_PSYG_CB5  17

#define GID_PSYG_CH1  18 // game

#define GID_PSYG_SL1  19 // slot
#define GID_PSYG_IN6  20 // slot
#define GID_PSYG_IN7  21 // gold
#define GID_PSYG_IN8  22 // bolts
#define GID_PSYG_IN9  23 // arrows
#define GID_PSYG_IN10 24 // keys
#define GID_PSYG_IN11 25 // holding strength
#define GID_PSYG_IN12 26 // left    strength
#define GID_PSYG_IN13 27 // right   strength
#define GID_PSYG_IN14 28 // energy
#define GID_PSYG_IN15 29 // area
#define GID_PSYG_CH2  30 // facing
#define GID_PSYG_CH3  31 // holding
#define GID_PSYG_CH5  32 // left  inventory
#define GID_PSYG_CH6  33 // right inventory

#define GIDS_PSYG     GID_PSYG_CH6

#define NOTGOT      0
#define CARRIED     1
#define HELD        2

#define BARBARIAN2  0
#define OBLITERATOR 1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT LONG                 gamesize;
IMPORT ULONG                game,
                            offset,
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
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;
#ifndef __MORPHOS__
    IMPORT UWORD*           MouseData;
#endif

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                // Obliterator
                            ammo_pistol,
                            ammo_rifle,
                            ammo_blaster,
                            ammo_bazooka,
                            component[5],
                            flag_pistol,
                            flag_rifle,
                            flag_blaster,
                            flag_bazooka,
                            score,
                            sound,
                            // Barbarian 2
                            area[10],
                            arrows[10],
                            bolts[10],
                            energy[10],
                            facing[10],
                            gold[10],
                            holding[10],
                            holding_str[10],
                            left[10],
                            left_str[10],
                            keys[10],
                            right[10],
                            right_str[10],
                            slot = 0;
MODULE struct List          FacingList;

MODULE const STRPTR GameOptions[2 + 1] =
{   "Barbarian 2",    // 0
    "Obliterator",    // 1
    NULL              // 2
}, SoundOptions[2 + 1] =
{   "Music",          // 0
    "Effects",        // 1
    NULL              // 2
}, WeaponOptions[3 + 1] =
{   "Not possessed",  // 0 $0000
    "Carried",        // 1 $0001
    "Held",           // 2 $FFFF
    NULL              // 3
}, FacingOptions[2 + 1] =
{   "Left",           // 0 $FFFF
    "Right",          // 1 $0000
    NULL
}, HoldingOptions[9 + 1] =
{   "Nothing",        // 0
    "Sword",          // 1
    "Dagger",         // 2
    "Axe",            // 3
    "Halberd",        // 4
    "Elfin Bow",      // 5
    "Crossbow",       // 6
    "Grapple & Hook", // 7
    "Spear",          // 8
    NULL              // 9
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  ..22 2... .... ....    . = Transparent (%00)
    ..23 2... .... ....    1 = dark  brown (%01) ($532)
    ..23 2... .... ....    2 = med.  brown (%10) ($643)
    ..23 2222 22.. ....    3 = light brown (%11) ($7A4)
    .233 1313 132. ....
    2133 3333 332. ....
    .233 3333 332. ....
    ..21 1111 12.. ....

          Plane 1                Plane 0
    ..22 2... .... ....    .... .... .... ....
    ..23 2... .... ....    ...3 .... .... ....
    ..23 2... .... ....    ...3 .... .... ....
    ..23 2222 22.. ....    ...3 .... .... ....
    .233 .3.3 .32. ....    ..33 1313 13.. ....
    2.33 3333 332. ....    .133 3333 33.. ....
    .233 3333 332. ....    ..33 3333 33.. ....
    ..2. .... .2.. ....    ...1 1111 1... ....
      Medium & Light           Dark & Light
*/
    0x3800, 0x0000,
    0x3800, 0x1000,
    0x3800, 0x1000,
    0x3FC0, 0x1000,
    0x7560, 0x3FC0,
    0xBFE0, 0x7FC0,
    0x7FE0, 0x3FC0,
    0x2040, 0x1F80,

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

(None)

8. CODE --------------------------------------------------------------- */

EXPORT void psyg_main(void)
{   TRANSIENT int                 i;
    TRANSIENT struct ChooserNode* ChooserNodePtr;
    PERSIST   FLAG                first = TRUE;

    if (first)
    {   first = FALSE;

        // psyg_preinit()
        NewList(&FacingList);
    }

    tool_open  = psyg_open;
    tool_loop  = psyg_loop;
    tool_save  = psyg_save;
    tool_close = psyg_close;
    tool_exit  = psyg_exit;

    if (loaded != FUNC_PSYGNOSIS && !psyg_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_PSYGNOSIS;

    make_speedbar_list(GID_PSYG_SB1);
    load_fimage(FUNC_PSYGNOSIS);
    load_images(352, 360);
    load_aiss_images(10, 10);
    load_aiss_images(12, 12); // east
    load_aiss_images(14, 14); // west
    load_aiss_images(82, 82); // sound

    for (i = 0; i < 2; i++)
    {   if (!(ChooserNodePtr = (struct ChooserNode*) AllocChooserNode
        (   CNA_Text,  FacingOptions[i],
            CNA_Image, aissimage[14 - (i * 2)],
        TAG_DONE)))
        {   rq("Can't create chooser.gadget node(s)!");
        }
        AddTail(&FacingList, (struct Node*) ChooserNodePtr); // AddTail() has no return code
    }

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                           WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                        gadgets[GID_PSYG_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                     TRUE,
            AddHLayout,
                AddToolbar(GID_PSYG_SB1),
                AddSpace,
                AddVLayout,
                    AddSpace,
                    LAYOUT_AddChild,               gadgets[GID_PSYG_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                     GID_PSYG_CH1,
                        GA_Disabled,               TRUE,
                        CHOOSER_LabelArray,        &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,          0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,               0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                  0,
            AddHLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,             BVS_GROUP,
                    LAYOUT_SpaceOuter,             TRUE,
                    LAYOUT_Label,                  "Barbarian 2",
                    AddHLayout,
                        LAYOUT_AddChild,           gadgets[GID_PSYG_SL1] = (struct Gadget*)
                        SliderObject,
                            GA_ID,                 GID_PSYG_SL1,
                            GA_RelVerify,          TRUE,
                            SLIDER_Min,            0,
                            SLIDER_Max,            9,
                            SLIDER_KnobDelta,      1,
                            SLIDER_Orientation,    SLIDER_HORIZONTAL,
                            SLIDER_Ticks,          10,
                        SliderEnd,
                        LAYOUT_AddChild,           gadgets[GID_PSYG_IN6] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                 GID_PSYG_IN6,
                            GA_TabCycle,           TRUE,
                            GA_RelVerify,          TRUE,
                            INTEGER_Minimum,       0,
                            INTEGER_Maximum,       9,
                            INTEGER_MinVisible,    1 + 1,
                        IntegerEnd,
                        CHILD_WeightedWidth,       0,
                    LayoutEnd,
                    Label("Slot:"),
                    AddVLayout,
                        LAYOUT_BevelStyle,         BVS_GROUP,
                        LAYOUT_SpaceOuter,         TRUE,
                        LAYOUT_Label,              "Slot",
                        LAYOUT_AddChild,           gadgets[GID_PSYG_IN14] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                 GID_PSYG_IN14,
                            GA_TabCycle,           TRUE,
                            INTEGER_Minimum,       1,
                            INTEGER_Maximum,       640,
                            INTEGER_MinVisible,    3 + 1,
                        IntegerEnd,
                        Label("Energy:"),
                        LAYOUT_AddChild,           gadgets[GID_PSYG_IN7] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                 GID_PSYG_IN7,
                            GA_TabCycle,           TRUE,
                            INTEGER_Minimum,       0,
                            INTEGER_Maximum,       999,
                            INTEGER_MinVisible,    3 + 1,
                        IntegerEnd,
                        Label("Gold:"),
                        LAYOUT_AddChild,           gadgets[GID_PSYG_IN10] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                 GID_PSYG_IN10,
                            GA_TabCycle,           TRUE,
                            INTEGER_Minimum,       0,
                            INTEGER_Maximum,       3,
                            INTEGER_MinVisible,    1 + 1,
                        IntegerEnd,
                        Label("Keys:"),
                        LAYOUT_AddChild,           gadgets[GID_PSYG_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                 GID_PSYG_IN8,
                            GA_TabCycle,           TRUE,
                            INTEGER_Minimum,       0,
                            INTEGER_Maximum,       256,
                            INTEGER_MinVisible,    3 + 1,
                        IntegerEnd,
                        Label("Bolts:"),
                        LAYOUT_AddChild,           gadgets[GID_PSYG_IN9] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                 GID_PSYG_IN9,
                            GA_TabCycle,           TRUE,
                            INTEGER_Minimum,       0,
                            INTEGER_Maximum,       256,
                            INTEGER_MinVisible,    3 + 1,
                        IntegerEnd,
                        Label("Arrows:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            LAYOUT_AddChild,       gadgets[GID_PSYG_CH3] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,             GID_PSYG_CH3,
                                CHOOSER_LabelArray,&HoldingOptions,
                            ChooserEnd,
                            AddLabel("Strength:"),
                            LAYOUT_AddChild,       gadgets[GID_PSYG_IN11] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,             GID_PSYG_IN11,
                                GA_TabCycle,       TRUE,
                                INTEGER_Minimum,   0,
                                INTEGER_Maximum,   127,
                                INTEGER_MinVisible,3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Holding:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            LAYOUT_AddChild,       gadgets[GID_PSYG_CH5] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,             GID_PSYG_CH5,
                                CHOOSER_LabelArray,&HoldingOptions,
                            ChooserEnd,
                            AddLabel("Strength:"),
                            LAYOUT_AddChild,       gadgets[GID_PSYG_IN12] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,             GID_PSYG_IN12,
                                GA_TabCycle,       TRUE,
                                INTEGER_Minimum,   0,
                                INTEGER_Maximum,   127,
                                INTEGER_MinVisible,3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Left inventory:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,  LALIGN_CENTER,
                            LAYOUT_AddChild,       gadgets[GID_PSYG_CH6] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,             GID_PSYG_CH6,
                                CHOOSER_LabelArray,&HoldingOptions,
                            ChooserEnd,
                            AddLabel("Strength:"),
                            LAYOUT_AddChild,       gadgets[GID_PSYG_IN13] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,             GID_PSYG_IN13,
                                GA_TabCycle,       TRUE,
                                INTEGER_Minimum,   0,
                                INTEGER_Maximum,   127,
                                INTEGER_MinVisible,3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Right inventory:"),
                        LAYOUT_AddChild,           gadgets[GID_PSYG_CH2] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                 GID_PSYG_CH2,
                            CHOOSER_Labels,        &FacingList,
                        ChooserEnd,
                        Label("Facing:"),
                        LAYOUT_AddChild,           gadgets[GID_PSYG_IN15] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                 GID_PSYG_IN15,
                            GA_TabCycle,           TRUE,
                            INTEGER_Minimum,       0,
                            INTEGER_Maximum,       15,
                            INTEGER_MinVisible,    2 + 1,
                        IntegerEnd,
                        Label("Area:"),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    AddSpace,
                    AddFImage(FUNC_PSYGNOSIS),
                    CHILD_WeightedHeight,          0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,               0,
            LayoutEnd,
            AddLabel(""),
            CHILD_WeightedHeight,                  0,
            AddVLayout,
                LAYOUT_BevelStyle,                 BVS_GROUP,
                LAYOUT_SpaceOuter,                 TRUE,
                LAYOUT_Label,                      "Obliterator",
                AddHLayout,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    LAYOUT_AddChild,               gadgets[GID_PSYG_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                     GID_PSYG_IN1,
                        GA_TabCycle,               TRUE,
                        INTEGER_Minimum,           0,
                        INTEGER_Maximum,           999999,
                        INTEGER_MinVisible,        6 + 1,
                    IntegerEnd,
                    Label("Score:"),
                    AddLabel(" "),
                    LAYOUT_AddImage,
                    LabelObject,
                        LABEL_Image,               aissimage[82],
                        CHILD_NoDispose,           TRUE,
                        LABEL_DrawInfo,            DrawInfoPtr,
                    LabelEnd,
                    LAYOUT_AddChild,               gadgets[GID_PSYG_CH4] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                     GID_PSYG_CH4,
                        CHOOSER_LabelArray,        &SoundOptions,
                    ChooserEnd,
                    Label("Sound:"),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Guns",
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_BevelStyle,         BVS_GROUP,
                            LAYOUT_SpaceOuter,         TRUE,
                            LAYOUT_Label,              "Pistol",
                            AddImage(352),
                            LAYOUT_AddChild,           gadgets[GID_PSYG_IN2] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_PSYG_IN2,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       0,
                                INTEGER_Maximum,       99,
                                INTEGER_MinVisible,    2 + 1,
                            IntegerEnd,
                            LAYOUT_AddChild,           gadgets[GID_PSYG_RA2] = (struct Gadget*)
                            RadioButtonObject,
                                GA_ID,                 GID_PSYG_RA2,
                                GA_RelVerify,          TRUE,
                                GA_Text,               WeaponOptions,
                            RadioButtonEnd,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_BevelStyle,         BVS_GROUP,
                            LAYOUT_SpaceOuter,         TRUE,
                            LAYOUT_Label,              "Rifle",
                            AddImage(353),
                            LAYOUT_AddChild,           gadgets[GID_PSYG_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_PSYG_IN3,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       0,
                                INTEGER_Maximum,       99,
                                INTEGER_MinVisible,    2 + 1,
                            IntegerEnd,
                            LAYOUT_AddChild,           gadgets[GID_PSYG_RA3] = (struct Gadget*)
                            RadioButtonObject,
                                GA_ID,                 GID_PSYG_RA3,
                                GA_Text,               WeaponOptions,
                                GA_RelVerify,          TRUE,
                            RadioButtonEnd,
                        LayoutEnd,
                    LayoutEnd,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_BevelStyle,         BVS_GROUP,
                            LAYOUT_SpaceOuter,         TRUE,
                            LAYOUT_Label,              "Blaster",
                            AddImage(354),
                            LAYOUT_AddChild,           gadgets[GID_PSYG_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_PSYG_IN4,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       0,
                                INTEGER_Maximum,       99,
                                INTEGER_MinVisible,    2 + 1,
                            IntegerEnd,
                            LAYOUT_AddChild,           gadgets[GID_PSYG_RA4] = (struct Gadget*)
                            RadioButtonObject,
                                GA_ID,                 GID_PSYG_RA4,
                                GA_Text,               WeaponOptions,
                                GA_RelVerify,          TRUE,
                            RadioButtonEnd,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_BevelStyle,         BVS_GROUP,
                            LAYOUT_SpaceOuter,         TRUE,
                            LAYOUT_Label,              "Bazooka",
                            AddImage(355),
                            LAYOUT_AddChild,           gadgets[GID_PSYG_IN5] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_PSYG_IN5,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       0,
                                INTEGER_Maximum,       9,
                                INTEGER_MinVisible,    1 + 1,
                            IntegerEnd,
                            LAYOUT_AddChild,           gadgets[GID_PSYG_RA5] = (struct Gadget*)
                            RadioButtonObject,
                                GA_ID,                 GID_PSYG_RA5,
                                GA_Text,               WeaponOptions,
                                GA_RelVerify,          TRUE,
                            RadioButtonEnd,
                        LayoutEnd,
                    LayoutEnd,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Components",
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_BevelStyle,         BVS_GROUP,
                            LAYOUT_SpaceOuter,         TRUE,
                            AddImage(356),
                            CHILD_WeightedWidth,       0,
                            LAYOUT_AddChild,           gadgets[GID_PSYG_CB1] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_PSYG_CB1,
                                GA_Text,               "Engine",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_BevelStyle,         BVS_GROUP,
                            LAYOUT_SpaceOuter,         TRUE,
                            AddImage(357),
                            CHILD_WeightedWidth,       0,
                            LAYOUT_AddChild,           gadgets[GID_PSYG_CB2] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_PSYG_CB2,
                                GA_Text,               "Shields",
                            End,
                        LayoutEnd,
                    LayoutEnd,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_BevelStyle,         BVS_GROUP,
                            LAYOUT_SpaceOuter,         TRUE,
                            AddImage(358),
                            CHILD_WeightedWidth,       0,
                            LAYOUT_AddChild,           gadgets[GID_PSYG_CB3] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_PSYG_CB3,
                                GA_Text,               "Weapons",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_BevelStyle,         BVS_GROUP,
                            LAYOUT_SpaceOuter,         TRUE,
                            AddImage(359),
                            CHILD_WeightedWidth,       0,
                            LAYOUT_AddChild,           gadgets[GID_PSYG_CB4] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_PSYG_CB4,
                                GA_Text,               "Shuttle",
                            End,
                        LayoutEnd,
                    LayoutEnd,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_BevelStyle,         BVS_GROUP,
                            LAYOUT_SpaceOuter,         TRUE,
                            AddImage(360),
                            CHILD_WeightedWidth,       0,
                            LAYOUT_AddChild,           gadgets[GID_PSYG_CB5] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_PSYG_CB5,
                                GA_Text,               "Datapack",
                            End,
                        LayoutEnd,
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            MaximizeButton(GID_PSYG_BU1, "Maximize Game"),
        LayoutEnd,
        CHILD_NominalSize,                         TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_PSYG_SB1);
#ifndef __MORPHOS__
    if (game == OBLITERATOR)
    {   MouseData = (UWORD*) LocalMouseData;
        setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
    }
#endif
    writegadgets();

    loop();

    readgadgets();
    closewindow();
}

EXPORT void psyg_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_PSYG_BU1:
        readgadgets();

        switch (game)
        {
        case BARBARIAN2:
            keys[slot]        =   3;
            left[slot]        =   7; // grapple & hook
            right[slot]       =   4; // halberd
            holding[slot]     =   6; // crossbow
            holding_str[slot] =
            left_str[slot]    =
            right_str[slot]   = 127;
            bolts[slot]       =
            arrows[slot]      = 256;
            energy[slot]      = 640;
            gold[slot]        = 900;
        acase OBLITERATOR:
            component[0] =
            component[1] =
            component[2] =
            component[3] =
            component[4] = TRUE;
            ammo_bazooka =      9;
            ammo_pistol  =
            ammo_rifle   =
            ammo_blaster =     99;
            if (flag_pistol  == NOTGOT) flag_pistol  = CARRIED;
            if (flag_rifle   == NOTGOT) flag_rifle   = CARRIED;
            if (flag_blaster == NOTGOT) flag_blaster = CARRIED;
            if (flag_bazooka == NOTGOT) flag_bazooka = CARRIED;
            score        = 990000;
        }

        writegadgets();
    acase GID_PSYG_RA2:
        if (flag_pistol == HELD) // already held, won't let you change it
        {   write_ra(GID_PSYG_RA2, flag_pistol); // set it back
        } else
        {   DISCARD GetAttr(RADIOBUTTON_Selected, (Object*) gadgets[gid], &flag_pistol);
            if (flag_pistol      == HELD)
            {   if (flag_rifle   == HELD) { flag_rifle   = CARRIED; write_ra(GID_PSYG_RA3, flag_rifle  ); }
                if (flag_blaster == HELD) { flag_blaster = CARRIED; write_ra(GID_PSYG_RA4, flag_blaster); }
                if (flag_bazooka == HELD) { flag_bazooka = CARRIED; write_ra(GID_PSYG_RA5, flag_bazooka); }
        }   }
    acase GID_PSYG_RA3:
        if (flag_rifle == HELD) // already held, won't let you change it
        {   write_ra(GID_PSYG_RA3, flag_rifle); // set it back
        } else
        {   DISCARD GetAttr(RADIOBUTTON_Selected, (Object*) gadgets[gid], &flag_rifle);
            if (flag_rifle       == HELD)
            {   if (flag_pistol  == HELD) { flag_pistol  = CARRIED; write_ra(GID_PSYG_RA2, flag_pistol ); }
                if (flag_blaster == HELD) { flag_blaster = CARRIED; write_ra(GID_PSYG_RA4, flag_blaster); }
                if (flag_bazooka == HELD) { flag_bazooka = CARRIED; write_ra(GID_PSYG_RA5, flag_bazooka); }
        }   }
    acase GID_PSYG_RA4:
        if (flag_blaster == HELD) // already held, won't let you change it
        {   write_ra(GID_PSYG_RA4, flag_blaster); // set it back
        } else
        {   DISCARD GetAttr(RADIOBUTTON_Selected, (Object*) gadgets[gid], &flag_blaster);
            if (flag_blaster     == HELD)
            {   if (flag_pistol  == HELD) { flag_pistol  = CARRIED; write_ra(GID_PSYG_RA2, flag_pistol ); }
                if (flag_rifle   == HELD) { flag_rifle   = CARRIED; write_ra(GID_PSYG_RA3, flag_rifle  ); }
                if (flag_bazooka == HELD) { flag_bazooka = CARRIED; write_ra(GID_PSYG_RA5, flag_bazooka); }
        }   }
    acase GID_PSYG_RA5:
        if (flag_bazooka == HELD) // already held, won't let you change it
        {   write_ra(GID_PSYG_RA5, flag_bazooka); // set it back
        } else
        {   DISCARD GetAttr(RADIOBUTTON_Selected, (Object*) gadgets[gid], &flag_bazooka);
            if (flag_bazooka     == HELD)
            {   if (flag_pistol  == HELD) { flag_pistol  = CARRIED; write_ra(GID_PSYG_RA2, flag_pistol ); }
                if (flag_rifle   == HELD) { flag_rifle   = CARRIED; write_ra(GID_PSYG_RA3, flag_rifle  ); }
                if (flag_blaster == HELD) { flag_blaster = CARRIED; write_ra(GID_PSYG_RA4, flag_blaster); }
        }   }
    acase GID_PSYG_SL1:
        readgadgets();
        gadmode = SERIALIZE_READ;
        either_sl(GID_PSYG_SL1, &slot);
        writegadgets();
    acase GID_PSYG_IN6:
        readgadgets();
        gadmode = SERIALIZE_READ;
        either_in(GID_PSYG_IN6, &slot);
        writegadgets();
}   }

EXPORT FLAG psyg_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;

        if (gamesize == 5632)
        {   game = OBLITERATOR;
        } elif (gamesize == 245760)
        {   game = BARBARIAN2;
        } else
        {   say("Unknown file format!", REQIMAGE_WARNING);
            return FALSE;
        }

        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_PSYGNOSIS
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;

    either_ch(GID_PSYG_CH1, &game);
    either_sl(GID_PSYG_SL1, &slot);
    either_in(GID_PSYG_IN6, &slot);

    ghost(   GID_PSYG_IN1,  (game != OBLITERATOR));
    ghost(   GID_PSYG_IN2,  (game != OBLITERATOR));
    ghost(   GID_PSYG_IN3,  (game != OBLITERATOR));
    ghost(   GID_PSYG_IN4,  (game != OBLITERATOR));
    ghost(   GID_PSYG_IN5,  (game != OBLITERATOR));
    ghost(   GID_PSYG_CH4,  (game != OBLITERATOR));
    ghost_st(GID_PSYG_RA2,  (game != OBLITERATOR));
    ghost_st(GID_PSYG_RA3,  (game != OBLITERATOR));
    ghost_st(GID_PSYG_RA4,  (game != OBLITERATOR));
    ghost_st(GID_PSYG_RA5,  (game != OBLITERATOR));
    ghost_st(GID_PSYG_CB1,  (game != OBLITERATOR));
    ghost_st(GID_PSYG_CB2,  (game != OBLITERATOR));
    ghost_st(GID_PSYG_CB3,  (game != OBLITERATOR));
    ghost_st(GID_PSYG_CB4,  (game != OBLITERATOR));
    ghost_st(GID_PSYG_CB5,  (game != OBLITERATOR));

    ghost_st(GID_PSYG_SL1,  (game != BARBARIAN2 ));
    ghost(   GID_PSYG_IN6,  (game != BARBARIAN2 ));
    ghost(   GID_PSYG_IN7,  (game != BARBARIAN2 ));
    ghost(   GID_PSYG_IN8,  (game != BARBARIAN2 ));
    ghost(   GID_PSYG_IN9,  (game != BARBARIAN2 ));
    ghost(   GID_PSYG_IN10, (game != BARBARIAN2 ));
    ghost(   GID_PSYG_IN11, (game != BARBARIAN2 ));
    ghost(   GID_PSYG_IN12, (game != BARBARIAN2 ));
    ghost(   GID_PSYG_IN13, (game != BARBARIAN2 ));
    ghost(   GID_PSYG_IN14, (game != BARBARIAN2 ));
    ghost(   GID_PSYG_IN15, (game != BARBARIAN2 ));
    ghost(   GID_PSYG_CH2,  (game != BARBARIAN2 ));
    ghost(   GID_PSYG_CH3,  (game != BARBARIAN2 ));
    ghost(   GID_PSYG_CH5,  (game != BARBARIAN2 ));
    ghost(   GID_PSYG_CH6,  (game != BARBARIAN2 ));

    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    either_in(GID_PSYG_IN1,  &score);
    either_in(GID_PSYG_IN2,  &ammo_pistol);
    either_in(GID_PSYG_IN3,  &ammo_rifle);
    either_in(GID_PSYG_IN4,  &ammo_blaster);
    either_in(GID_PSYG_IN5,  &ammo_bazooka);
    either_ch(GID_PSYG_CH4,  &sound);
    either_ra(GID_PSYG_RA2,  &flag_pistol);
    either_ra(GID_PSYG_RA3,  &flag_rifle);
    either_ra(GID_PSYG_RA4,  &flag_blaster);
    either_ra(GID_PSYG_RA5,  &flag_bazooka);
    for (i = 0; i < 5; i++)
    {   either_cb(GID_PSYG_CB1 + i, &component[i]);
    }

    either_in(GID_PSYG_IN7,  &gold[slot]);
    either_in(GID_PSYG_IN8,  &bolts[slot]);
    either_in(GID_PSYG_IN9,  &arrows[slot]);
    either_in(GID_PSYG_IN10, &keys[slot]);
    either_in(GID_PSYG_IN11, &holding_str[slot]);
    either_in(GID_PSYG_IN12, &left_str[slot]);
    either_in(GID_PSYG_IN13, &right_str[slot]);
    either_in(GID_PSYG_IN14, &energy[slot]);
    either_in(GID_PSYG_IN15, &area[slot]);
    either_ch(GID_PSYG_CH2,  &facing[slot]);
    either_ch(GID_PSYG_CH3,  &holding[slot]);
    either_ch(GID_PSYG_CH5,  &left[slot]);
    either_ch(GID_PSYG_CH6,  &right[slot]);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   UWORD tt;
    int   i;

    switch (game)
    {
    case BARBARIAN2:
        for (i = 0; i < 10; i++)
        {   offset = (24576 * i) + 0x11;
            serialize1(&area[i]);        // $11

            offset = (24576 * i) + 0x18;
            if (facing[i] == 0) // left
            {   tt = 0xFFFF;
            } else
            {   // assert(facing[i] == 1); // right
                tt = 0;
            }
            serialize2uword(&tt);        // $18
            facing[i] = tt ? 0 : 1;

            offset = (24576 * i) + 0x1F;
            serialize1(&holding[i]);     // $1F

            offset = (24576 * i) + 0x29;
            serialize1(&holding_str[i]); // $29
            offset++;                    // $2A
            serialize1(&left[i]);        // $2B

            offset = (24576 * i) + 0x35;
            serialize1(&left_str[i]);    // $35
            offset++;                    // $36
            serialize1(&right[i]);       // $37

            offset = (24576 * i) + 0x41;
            serialize1(&right_str[i]);   // $41

            offset = (24576 * i) + 0x44;
            serialize2ulong(&energy[i]); // $44

            offset = (24576 * i) + 0x5C;
            serialize2ulong(&gold[i]);   // $5C..$5D
            offset++;                    // $5E
            serialize1(&keys[i]);        // $5F
            serialize2ulong(&arrows[i]); // $60..$61
            serialize2ulong(&bolts[i]);  // $62..$63
        }
    acase OBLITERATOR:
        offset = 0xD68;
        serialize_bcd3(&score);         // $D68..$D6A

        offset = 0xD6E;
        if (flag_pistol  == HELD) flag_pistol = 0xFFFF;
        serialize2ulong(&flag_pistol);  // $D6E..$D6F
        if (flag_pistol == 0xFFFF) flag_pistol = HELD;

        offset = 0xD73;
        serialize_bcd1(&ammo_pistol);   // $D73

        offset = 0xD78;
        if (flag_rifle   == HELD) flag_rifle = 0xFFFF;
        serialize2ulong(&flag_rifle);   // $D78..$D79
        if (flag_rifle == 0xFFFF) flag_rifle = HELD;

        offset = 0xD7D;
        serialize_bcd1(&ammo_rifle);    // $D7D

        offset = 0xD82;
        if (flag_blaster == HELD) flag_blaster = 0xFFFF;
        serialize2ulong(&flag_blaster); // $D82..$D83
        if (flag_blaster == 0xFFFF) flag_blaster = HELD;

        offset = 0xD87;
        serialize_bcd1(&ammo_blaster);  // $D87

        offset = 0xD8C;
        if (flag_bazooka == HELD) flag_bazooka = 0xFFFF;
        serialize2ulong(&flag_bazooka); // $D8C..$D8D
        if (flag_bazooka == 0xFFFF) flag_bazooka = HELD;

        offset = 0xD91;
        serialize_bcd1(&ammo_bazooka);  // $D91

        offset = 0xD97;
        for (i = 0; i < 5; i++)
        {   if (component[i]) component[i] = TRUE;
            serialize1(&component[i]);  // $D97, etc.
            if (component[i]) component[i] = 0x01;
            offset += 7;
        }

        offset = 0xDEC;
        if (sound ==      1) sound = 0xFFFF;
        serialize2ulong(&sound);        // $DEC..$DED
        if (sound == 0xFFFF) sound =      1;
}   }

EXPORT void psyg_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  BARBARIAN2:  gamesave("Barbarian2Psy.save", "Barbarian 2", saveas, 245760, FLAG_S, FALSE);
    acase OBLITERATOR: gamesave("FNIAA"             , "Obliterator", saveas,   5632, FLAG_S, FALSE);
}   }

EXPORT void psyg_close(void) { ; }

EXPORT void psyg_exit(void)
{   ch_clearlist(&FacingList);
}

EXPORT void psyg_key(UBYTE scancode)
{   if (game != BARBARIAN2)
    {   return;
    }

    switch (scancode)
    {
    case SCAN_LEFT:
    case SCAN_N4:
        if (slot == 0)
        {   slot = 9;
        } else
        {   slot--;
        }
    acase SCAN_RIGHT:
    case SCAN_N6:
        if (slot == 9)
        {   slot = 0;
        } else
        {   slot++;
        }
    adefault:
        return;
    }

    writegadgets();
}

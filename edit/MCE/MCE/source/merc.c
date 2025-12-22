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
#include <proto/virtual.h>
#include <clib/alib_protos.h>

#include <gadgets/virtual.h>

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
#define GID_MERC_LY1     0 // root layout
#define GID_MERC_LY2     1 // virtual layout
#define GID_MERC_SB1     2 // toolbar
#define GID_MERC_CB1     3 // dart
#define GID_MERC_SP1     4 // map
#define GID_MERC_VI1     5
#define GID_MERC_BU1     6 // maximize
#define GID_MERC_BU2     7 //  1st inventory slot
#define GID_MERC_BU12   17 // 11th inventory slot
#define GID_MERC_BU13   18 //  1st prop/item slot
#define GID_MERC_BU76   81 // 64th prop/item slot
#define GID_MERC_CH1    82 // game
#define GID_MERC_IN1    83 // credits (money)
#define GID_MERC_IN2    84 // number of items
#define GID_MERC_IN3    85 // coarse X
#define GID_MERC_IN4    86 // fine   X
#define GID_MERC_IN5    87 // coarse Y
#define GID_MERC_IN6    88 // fine   Y
#define GID_MERC_IN258 340 // 64 locations * 4
#define GID_MERC_LY4   341
#define GID_MERC_LY67  404

// items subwindow
#define GID_MERC_LY3   405 // root layout
#define GID_MERC_LB1   406

#define GIDS_MERC      GID_MERC_LB1

#define AddItem(x)                                                       \
LAYOUT_AddChild,            gadgets[GID_MERC_BU2 + x] = (struct Gadget*) \
ZButtonObject,                                                           \
    GA_ID,                  GID_MERC_BU2 + x,                            \
    GA_RelVerify,           TRUE,                                        \
    BUTTON_Justification,   LCJ_LEFT,                                    \
ButtonEnd

#define MAPWIDTH  256
#define MAPHEIGHT 256

#define MERC1       0
#define MERC2       1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void itemwindow(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            screenwidth,
                            serializemode;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT LONG                 pens[PENS];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct RastPort      wpa8rastport[2];
IMPORT UBYTE*               byteptr1[DISPLAY1HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
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

MODULE int                  whichprop;
MODULE SLONG                coarse_X[64], coarse_Y[64];
MODULE ULONG                fine_X[64], fine_Y[64],
                            credits,
                            dart,
                            game,
                            itemslot[11],
                            numitems,
                            whichslot;
MODULE struct List          ItemsList;

MODULE const STRPTR GameOptions[2 + 1] =
{   "Escape from Targ",
    "The Second City",
    NULL
}, itemnames[64] = {
"-",
"Dominion Dart #1",
"Car",
"Vehicle #3",  // "jet with legs": jet car or concorde or pc bil new ship?
"Hexapod #4",
"Vehicle #5",  // "hovercraft"
"Cheese",
"Interstellar ship",
"Cube #8",
"Dominion Dart #9",
"Prestinium (destroyed)",
"Vehicle #11", // dominion dart?
"Mechanoid",
"Vehicle #13", // dominion dart?
"Cube #14",
"Hexapod #15",
"Photon emitter",
"Triangular key",
"Bottom-heavy trapezoidal key",
"Pentagonal key",
"Tombstone key",
"Top-heavy trapezoidal key",
"Hexagonal key",
"Colony Craft key",
"Anti time bomb",
"Novadrive",
"Metal detector",
"Antigrav",
"Poweramp",
"Neutron fuel",
"Antenna",
"Energy crystal",
"Coffin",                 // $20
"Music stand",            // $21
"Large box",              // $22
"Useful armament",        // $23
"Cooker",                 // $24
"Sales forecast",         // $25
"Gold",                   // $26
"Lounge",                 // $27
"Sights",                 // $28
"Medical supplies",       // $29
"Essential 12939 supply", // $2A
"Winchester",             // $2B
"Catering provisions",    // $2C
"Databank",               // $2D
"Pass",                   // $2E
"Kitchen sink",           // $2F
"Cobweb",                 // $30
"Lamp",                   // $31
"Prop #50",               // $32
"Fireplace",              // $33
"TV cabinet",             // $34
"Table",                  // $35
"Chair",                  // $36
"Bed",                    // $37
"Structure #56",          // $38
"Skull & crossbones #57", // $39
"Skull & crossbones #58", // $3A
"Skull & crossbones #59", // $3B
"Skull & crossbones #60", // $3C
"Structure #61",          // $3D
"Structure #62",          // $3E
"Structure #63",          // $3F
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(None)

8. CODE --------------------------------------------------------------- */

EXPORT void merc_main(void)
{   TRANSIENT int  i;
    PERSIST   FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // merc_preinit()
        NewList(&ItemsList);

        // merc_init()
        lb_makelist(&ItemsList, itemnames, 0x40); // elements are 0..$3F
    }

    tool_open      = merc_open;
    tool_loop      = merc_loop;
    tool_save      = merc_save;
    tool_close     = merc_close;
    tool_exit      = merc_exit;
    tool_subgadget = merc_subgadget;

    if (loaded != FUNC_MERCENARY && !merc_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_MERCENARY;

    make_speedbar_list(GID_MERC_SB1);
    load_aiss_images(10, 10);
    merc_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    whichprop = -1;

    for (i = 0; i < 64; i++)
    {   gadgets[GID_MERC_LY4 + i] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_VertAlignment,   LALIGN_CENTER,
            LAYOUT_AddChild,        gadgets[GID_MERC_BU13 + i     ] = (struct Gadget*)
            ZButtonObject,
                GA_ID,              GID_MERC_BU13 + i,
                GA_RelVerify,       TRUE,
                BUTTON_Justification, BCJ_LEFT,
            ButtonEnd,
            LAYOUT_AddChild,        gadgets[GID_MERC_IN3 + (i * 4)] = (struct Gadget*)
            IntegerObject,
                GA_ID,              GID_MERC_IN3 + (i * 4),
                GA_TabCycle,        TRUE,
                GA_RelVerify,       TRUE,
                INTEGER_Minimum,    -128,
                INTEGER_Maximum,    127,
                INTEGER_MinVisible, 4 + 1,
                INTEGER_Arrows,     (screenwidth >= 1024) ? TRUE : FALSE,
            IntegerEnd,
            CHILD_WeightedWidth,    0,
            AddLabel("."),
            CHILD_WeightedWidth,    0,
            LAYOUT_AddChild,        gadgets[GID_MERC_IN4 + (i * 4)] = (struct Gadget*)
            IntegerObject,
                GA_ID,              GID_MERC_IN4 + (i * 4),
                GA_TabCycle,        TRUE,
                INTEGER_Minimum,    0,
                INTEGER_Maximum,    65535,
                INTEGER_MinVisible, 5 + 1,
                INTEGER_Arrows,     (screenwidth >= 1024) ? TRUE : FALSE,
            IntegerEnd,
            CHILD_WeightedWidth,    0,
            AddLabel("-"),
            CHILD_WeightedWidth,    0,
            LAYOUT_AddChild,        gadgets[GID_MERC_IN5 + (i * 4)] = (struct Gadget*)
            IntegerObject,
                GA_ID,              GID_MERC_IN5 + (i * 4),
                GA_TabCycle,        TRUE,
                GA_RelVerify,       TRUE,
                INTEGER_Minimum,    -128,
                INTEGER_Maximum,    127,
                INTEGER_MinVisible, 4 + 1,
                INTEGER_Arrows,     (screenwidth >= 1024) ? TRUE : FALSE,
            IntegerEnd,
            CHILD_WeightedWidth,    0,
            AddLabel("."),
            CHILD_WeightedWidth,    0,
            LAYOUT_AddChild,        gadgets[GID_MERC_IN6 + (i * 4)] = (struct Gadget*)
            IntegerObject,
                GA_ID,              GID_MERC_IN6 + (i * 4),
                GA_TabCycle,        TRUE,
                INTEGER_Minimum,    0,
                INTEGER_Maximum,    65535,
                INTEGER_MinVisible, 5 + 1,
                INTEGER_Arrows,     (screenwidth >= 1024) ? TRUE : FALSE,
            IntegerEnd,
            CHILD_WeightedWidth,    0,
        LayoutEnd;
    }

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   SPECIALWPOS,
        WINDOW_ParentGroup,                                gadgets[GID_MERC_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            AddHLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                AddToolbar(GID_MERC_SB1),
                CHILD_WeightedWidth,                       0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_MERC_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_MERC_CH1,
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
            AddHLayout,
                AddVLayout,
                    AddHLayout,
                        AddSpace,
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "Map",
                            LAYOUT_AddChild,               gadgets[GID_MERC_SP1] = (struct Gadget*)
                            SpaceObject,
                                GA_ID,                     GID_MERC_SP1,
                                SPACE_MinWidth,            MAPWIDTH,
                                SPACE_MinHeight,           MAPHEIGHT,
                                SPACE_BevelStyle,          BVS_NONE,
                                SPACE_Transparent,         TRUE,
                            SpaceEnd,
                        LayoutEnd,
                        CHILD_WeightedWidth,               0,
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "Inventory",
                        LAYOUT_AddChild,                   gadgets[GID_MERC_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_MERC_IN2,
                            GA_RelVerify,                  TRUE,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               11,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Number of items:"),
                        AddItem( 0),
                        AddItem( 1),
                        AddItem( 2),
                        AddItem( 3),
                        AddItem( 4),
                        AddItem( 5),
                        AddItem( 6),
                        AddItem( 7),
                        AddItem( 8),
                        AddItem( 9),
                        AddItem(10),
                        AddLabel(""),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_MERC_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_MERC_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99999999,
                            INTEGER_MinVisible,            8 + 1,
                        IntegerEnd,
                        Label("Credits:"),
                        LAYOUT_AddChild,                   gadgets[GID_MERC_CB1] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_MERC_CB1,
                            GA_Selected,                   dart,
                            GA_Text,                       "Dominion Dart owned?",
                        End,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                    MaximizeButton(GID_MERC_BU1, "Maximize Game"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
            //  LAYOUT_WeightBar,                          TRUE,
                AddHLayout,
                    LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                    LAYOUT_Label,                          "Locations",
                    LAYOUT_AddChild,                       gadgets[GID_MERC_VI1] = (struct Gadget*)
                    NewObject(VIRTUAL_GetClass(), NULL,
                        GA_ID,                             GID_MERC_VI1,
                        GA_RelVerify,                      TRUE,
                        VIRTUALA_Contents,                 gadgets[GID_MERC_LY2] = (struct Gadget*)
                        VLayoutObject,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 +  0],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 +  1],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 +  2],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 +  3],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 +  4],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 +  5],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 +  6],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 +  7],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 +  8],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 +  9],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 10],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 11],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 12],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 13],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 14],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 15],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 16],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 17],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 18],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 19],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 20],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 21],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 22],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 23],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 24],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 25],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 26],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 27],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 28],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 29],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 30],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 31],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 32],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 33],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 34],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 35],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 36],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 37],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 38],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 39],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 40],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 41],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 42],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 43],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 44],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 45],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 46],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 47],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 48],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 49],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 50],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 51],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 52],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 53],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 54],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 55],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 56],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 57],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 58],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 59],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 60],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 61],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 62],
                            LAYOUT_AddChild,               gadgets[GID_MERC_LY4 + 63],
                        LayoutEnd,
                    End,
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_MERC_SB1);

    setup_bm(0, MAPWIDTH, MAPHEIGHT, MainWindowPtr);

    writegadgets(); // calls merc_drawmap()
 // ActivateLayoutGadget(gadgets[GID_MERC_LY2], MainWindowPtr, NULL, (Object) gadgets[GID_MERC_VI1]);

    loop();

    readgadgets();
    closewindow();
}

EXPORT void merc_loop(ULONG gid, UNUSED ULONG code)
{   int i;

    switch (gid)
    {
    case GID_MERC_BU1:
        readgadgets();

        dart    = TRUE;
        credits = 90000000;

        writegadgets();
    acase GID_MERC_IN2:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_MERC_IN2], (ULONG*) &numitems);
        writegadgets();
    adefault:
        if (gid >= GID_MERC_BU2 && gid <= GID_MERC_BU12)
        {   whichslot = gid - GID_MERC_BU2;
            itemwindow();
        } elif (gid >= GID_MERC_BU13 && gid <= GID_MERC_BU76)
        {   if (whichprop != -1)
            {   SetGadgetAttrs
                (   gadgets[GID_MERC_BU13 + whichprop], MainWindowPtr, NULL,
                    GA_Selected, FALSE,
                TAG_END); // this autorefreshes
            }
            whichprop = gid - GID_MERC_BU13;
            SetGadgetAttrs
            (   gadgets[gid], MainWindowPtr, NULL,
                GA_Selected, TRUE,
            TAG_END); // this autorefreshes
            merc_drawmap();
        } else
        {   for (i = 0; i < 64; i++)
            {   if ((int) gid == GID_MERC_IN3 + (i * 4))
                {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_MERC_IN3 + (i * 4)], (ULONG*) &coarse_X[i]);
                    merc_drawmap();
                    return; // for speed
                }
                if ((int) gid == GID_MERC_IN5 + (i * 4))
                {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_MERC_IN5 + (i * 4)], (ULONG*) &coarse_Y[i]);
                    merc_drawmap();
                    return; // for speed
}   }   }   }   }

EXPORT FLAG merc_open(FLAG loadas)
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
    (   page != FUNC_MERCENARY
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    either_in(    GID_MERC_IN1,                    &credits);
    either_in(    GID_MERC_IN2,                    &numitems);

    for (i = 0; i < 64; i++)
    {   either_in(GID_MERC_IN3 + (i * 4), (ULONG*) &coarse_X[i]);
        either_in(GID_MERC_IN4 + (i * 4),          &fine_X[  i]);
        either_in(GID_MERC_IN5 + (i * 4), (ULONG*) &coarse_Y[i]);
        either_in(GID_MERC_IN6 + (i * 4),          &fine_Y[  i]);
    }

    either_cb(    GID_MERC_CB1,                    &dart);

    if (gadmode == SERIALIZE_WRITE)
    {   either_ch(GID_MERC_CH1, &game);

        for (i = 0; i < 11; i++)
        {   SetGadgetAttrs
            (   gadgets[GID_MERC_BU2 + i], MainWindowPtr, NULL,
                GA_Text,         itemnames[itemslot[i]],
                GA_Disabled,     ((int) numitems <= i) ? TRUE : FALSE,
            TAG_END); // this autorefreshes
        }

        SetGadgetAttrs
        (   gadgets[GID_MERC_BU13], MainWindowPtr, NULL,
            GA_Text, "You",
        TAG_END); // this autorefreshes
        for (i = 1; i < 64; i++)
        {   SetGadgetAttrs
            (   gadgets[GID_MERC_BU13 + i], MainWindowPtr, NULL,
                GA_Text, itemnames[i],
            TAG_END); // this autorefreshes
        }

        merc_drawmap();
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    if (serializemode == SERIALIZE_READ)
    {   offset = 0;
        if (IOBuffer[0] == 0x32)
        {   // assert(IOBuffer[1] == 0x30);
            // assert(IOBuffer[2] == 0x12);
            // assert(IOBuffer[3] == 0x53);
            game = MERC1;
        } elif (IOBuffer[0] == 0x70)
        {   // assert(IOBuffer[1] == 0x91);
            // assert(IOBuffer[2] == 0x5B);
            // assert(IOBuffer[3] == 0x41);
            game = MERC2;
        } else
        {   rq("Unknown file format!");
    }   }

    offset = 0x49D;
    serialize1s(&coarse_X[0]);       //  $49D
    serialize2ulong(&fine_X[0]);     //  $49E.. $49F

    offset = 0x4A5;
    serialize1s(&coarse_Y[0]);       //  $4A5
    serialize2ulong(&fine_Y[0]);     //  $4A6.. $4A7

    offset = 0x573;
    serialize1(&numitems);           //  $573

    offset = 0x5A3;
    dart = dart ? 0x81 : 0x80;
    serialize1(&dart);               //  $5A3
    dart = (dart == 0x81) ? TRUE : FALSE;

    offset = 0xDE7;
    for (i = 0; i < 11; i++)
    {   serialize1(&itemslot[i]);    //  $DE7..$ DF1
    }

    for (i = 1; i < 64; i++)
    {   offset =  0xF27 + (i * 4);
        serialize1s(&coarse_X[i]);   //  $F2B
        serialize2ulong(&fine_X[i]); //  $F28.. $F29

        offset = 0x1127 + (i * 4);
        serialize1s(&coarse_Y[i]);   // $1127
        serialize2ulong(&fine_Y[i]); // $1128..$1129
    }

    offset = 0x1406;
    serialize_bcd4(&credits);        // $1406..$1409
}

EXPORT void merc_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("Mercenary?.save?", "Mercenary", saveas, 5162, FLAG_S, FALSE);
}

EXPORT void merc_close(void) { ; }
EXPORT void merc_exit(void)  { ; }

EXPORT void merc_drawmap(void)
{   int i,
        x, xx, y, yy;

    for (y = 0; y < MAPHEIGHT; y++)
    {   for (x = 0; x < MAPWIDTH; x++)
        {   DRAWPOINT(x, y, game); // memset() would be quicker
    }   }

    for (i = 63; i >= 0; i--) // so player is drawn last (ie. on top)
    {   x = coarse_X[i] + 128;
        y = coarse_Y[i] + 128;
        if (whichprop == i)
        {   for (xx = 0; xx < MAPWIDTH; xx++)
            {   DRAWPOINT(xx, y, (i == 0) ? 3 : 2);
            }
            for (yy = 0; yy < MAPHEIGHT; yy++)
            {   DRAWPOINT(x, yy, (i == 0) ? 3 : 2);
        }   }
        else
        {   DRAWPOINT(x, y, (i == 0) ? 3 : 2);
    }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_MERC_SP1]->LeftEdge,
        gadgets[GID_MERC_SP1]->TopEdge,
        gadgets[GID_MERC_SP1]->LeftEdge + MAPWIDTH  - 1,
        gadgets[GID_MERC_SP1]->TopEdge  + MAPHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );
}

EXPORT void merc_getpens(void)
{   lockscreen();

    pens[0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x88888888, 0x00000000, -1); // green
    pens[1] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x00000000, 0x00000000, -1); // red
    pens[2] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1); // white
    pens[3] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1); // black

    unlockscreen();
}

EXPORT void merc_uniconify(void)
{   merc_getpens();
    merc_drawmap();
}

MODULE void itemwindow(void)
{   InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Choose Item",
        WA_IDCMP,                              IDCMP_RAWKEY,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "merc-1",
        WINDOW_ParentGroup,                    gadgets[GID_MERC_LY3] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_AddChild,                   gadgets[GID_MERC_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_MERC_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &ItemsList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    208,
            CHILD_MinHeight,                   528,
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

    DISCARD SetGadgetAttrs(gadgets[GID_MERC_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) itemslot[whichslot], TAG_END);
    DISCARD SetGadgetAttrs(gadgets[GID_MERC_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) itemslot[whichslot], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_MERC_LB1], SubWindowPtr, NULL);

    subloop();

    DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_MERC_LB1], (ULONG*) &itemslot[whichslot]);

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG merc_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        lb_move_up(  GID_MERC_LB1, SubWindowPtr, qual, &itemslot[whichslot],    0, 5);
        writegadgets(); // this is overkill
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_move_down(GID_MERC_LB1, SubWindowPtr, qual, &itemslot[whichslot], 0x3F, 5);
        writegadgets(); // this is overkill
    }

    return FALSE;
}

EXPORT FLAG merc_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_MERC_LB1:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_MERC_LB1], (ULONG*) &itemslot[whichslot]);
        writegadgets();
        return TRUE;
    }

    return FALSE;
}

EXPORT void merc_die(void)
{   lb_clearlist(&ItemsList);
}

EXPORT void merc_key(UBYTE scancode, UWORD qual)
{   switch (scancode)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        vi_scroll_up(   GID_MERC_VI1, MainWindowPtr, qual);
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        vi_scroll_down( GID_MERC_VI1, MainWindowPtr, qual);
    acase SCAN_LEFT:
        vi_scroll_left( GID_MERC_VI1, MainWindowPtr, qual);
    acase SCAN_RIGHT:
        vi_scroll_right(GID_MERC_VI1, MainWindowPtr, qual);
}   }

EXPORT void merc_lmb(SWORD mousex, SWORD mousey, UWORD code)
{   if
    (   code      != SELECTDOWN
     || mousex    <  gadgets[GID_MERC_SP1]->LeftEdge
     || mousey    <  gadgets[GID_MERC_SP1]->TopEdge
     || mousex    >  gadgets[GID_MERC_SP1]->LeftEdge + MAPWIDTH  - 1
     || mousey    >  gadgets[GID_MERC_SP1]->TopEdge  + MAPHEIGHT - 1
     || whichprop == -1
    )
    {   return;
    }

    coarse_X[whichprop] = mousex - gadgets[GID_MERC_SP1]->LeftEdge - 128;
    coarse_Y[whichprop] = mousey - gadgets[GID_MERC_SP1]->TopEdge  - 128;
    writegadgets(); // this is overkill
}

EXPORT void merc_tick(SWORD mousex, SWORD mousey)
{   if (mouseisover(GID_MERC_SP1, mousex, mousey))
    {   setpointer(TRUE , WinObject, MainWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
}   }

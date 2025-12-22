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

#define GID_LN_LY1   0 // root layout
#define GID_LN_SB1   1 // toolbar
#define GID_LN_BU1   2 // maximize game
#define GID_LN_CH1   3
#define GID_LN_IN1   4
#define GID_LN_IN2   5
#define GID_LN_IN3   6
#define GID_LN_CB1   7
#define GID_LN_CB2   8
#define GID_LN_CB3   9
#define GID_LN_CB4  10
#define GID_LN_CB5  11
#define GID_LN_CB6  12
#define GID_LN_CB7  13
#define GID_LN_CB8  14
#define GID_LN_CB9  15
#define GID_LN_CB10 16
#define GID_LN_CB11 17
#define GID_LN_CB12 18
#define GID_LN_CB13 19
#define GID_LN_CB14 20
#define GID_LN_CB15 21
#define GIDS_LN     GID_LN_CB15

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void maximize_man(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
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
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE       ULONG          object[15],
                            ammo[2],
                            level,
                            lives;
MODULE const STRPTR         LevelOptions[7 + 1] =
{ "1 (the Wastelands)",
  "2 (the Wilderness)",
  "3 (Palace Gardens)",
  "4 (the Dungeons)",
  "5 (the Palace)",
  "6 (the Inner Sanctum)",
  "End of game",
  NULL
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void ln_main(void)
{   tool_open  = ln_open;
    tool_loop  = ln_loop;
    tool_save  = ln_save;
    tool_close = ln_close;
    tool_exit  = ln_exit;

    if (loaded != FUNC_LASTNINJA && !ln_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_LASTNINJA;

    load_images(187, 201);
    make_speedbar_list(GID_LN_SB1);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                            gadgets[GID_LN_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_DeferLayout,                        TRUE,
            AddToolbar(GID_LN_SB1),
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_GROUP,
                LAYOUT_SpaceOuter,                     TRUE,
                AddHLayout,
                    LAYOUT_SpaceOuter,                 TRUE,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_Label,                  "Objects",
                        AddHLayout,
                            AddImage(187),
                            LAYOUT_AddChild,           gadgets[GID_LN_CB1] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_LN_CB1,
                                GA_Selected,           object[0],
                                GA_Text,               "Pouch",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            AddImage(188),
                            LAYOUT_AddChild,           gadgets[GID_LN_CB2] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_LN_CB2,
                                GA_Selected,           object[1],
                                GA_Text,               "Key",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            AddImage(189),
                            LAYOUT_AddChild,           gadgets[GID_LN_CB3] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_LN_CB3,
                                GA_Selected,           object[2],
                                GA_Text,               "Apple",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            AddImage(190),
                            LAYOUT_AddChild,           gadgets[GID_LN_CB4] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_LN_CB4,
                                GA_Selected,           object[3],
                                GA_Text,               "Claw",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            AddImage(191),
                            LAYOUT_AddChild,           gadgets[GID_LN_CB5] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_LN_CB5,
                                GA_Selected,           object[4],
                                GA_Text,               "Glove",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            AddImage(192),
                            LAYOUT_AddChild,           gadgets[GID_LN_CB6] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_LN_CB6,
                                GA_Selected,           object[5],
                                GA_Text,               "Amulet",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            AddImage(193),
                            LAYOUT_AddChild,           gadgets[GID_LN_CB7] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_LN_CB7,
                                GA_Selected,           object[6],
                                GA_Text,               "Flower",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            AddImage(194),
                            LAYOUT_AddChild,           gadgets[GID_LN_CB8] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_LN_CB8,
                                GA_Selected,           object[7],
                                GA_Text,               "Rope",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            AddImage(195),
                            LAYOUT_AddChild,           gadgets[GID_LN_CB9] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_LN_CB9,
                                GA_Selected,           object[8],
                                GA_Text,               "Bottle",
                            End,
                        LayoutEnd,
                        AddHLayout,
                            AddImage(196),
                            LAYOUT_AddChild,           gadgets[GID_LN_CB10] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                 GID_LN_CB10,
                                GA_Selected,           object[9],
                                GA_Text,               "Scrolls",
                            End,
                        LayoutEnd,
                    LayoutEnd,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,         BVS_GROUP,
                            LAYOUT_Label,              "Weapons",
                            AddHLayout,
                                AddImage(197),
                                LAYOUT_AddChild,       gadgets[GID_LN_CB11] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,             GID_LN_CB11,
                                    GA_Selected,       object[10],
                                    GA_Text,           "Sword",
                                End,
                            LayoutEnd,
                            AddHLayout,
                                AddImage(198),
                                LAYOUT_AddChild,       gadgets[GID_LN_CB12] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,             GID_LN_CB12,
                                    GA_Selected,       object[11],
                                    GA_Text,           "Nunchakus",
                                End,
                            LayoutEnd,
                            AddHLayout,
                                AddImage(199),
                                LAYOUT_AddChild,       gadgets[GID_LN_CB13] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,             GID_LN_CB13,
                                    GA_Selected,       object[12],
                                    GA_Text,           "Staff",
                                End,
                            LayoutEnd,
                            AddHLayout,
                                AddImage(200),
                                LAYOUT_AddChild,       gadgets[GID_LN_CB14] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,             GID_LN_CB14,
                                    GA_RelVerify,      TRUE,
                                    GA_Selected,       object[13],
                                    GA_Text,           "Shuriken(s)",
                                End,
                                LAYOUT_AddChild,       gadgets[GID_LN_IN2] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,             GID_LN_IN2,
                                    GA_TabCycle,       TRUE,
                                    INTEGER_Minimum,   0,
                                    INTEGER_Maximum,   32767,
                                    INTEGER_MinVisible,5 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            AddHLayout,
                                AddImage(201),
                                LAYOUT_AddChild,       gadgets[GID_LN_CB15] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,             GID_LN_CB15,
                                    GA_RelVerify,      TRUE,
                                    GA_Selected,       object[14],
                                    GA_Text,           "Smoke bomb(s)",
                                End,
                                LAYOUT_AddChild,       gadgets[GID_LN_IN3] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,             GID_LN_IN3,
                                    GA_TabCycle,       TRUE,
                                    INTEGER_Minimum,   0,
                                    INTEGER_Maximum,   32767,
                                    INTEGER_MinVisible,5 + 1,
                                IntegerEnd,
                            LayoutEnd,
                        LayoutEnd,
                        AddVLayout,
                            AddSpace,
                            LAYOUT_AddChild,           gadgets[GID_LN_CH1] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                 GID_LN_CH1,
                                CHOOSER_LabelArray,    &LevelOptions,
                                CHOOSER_Selected,      (WORD) level,
                            PopUpEnd,
                            CHILD_WeightedHeight,      0,
                            Label("Level:"),
                            LAYOUT_AddChild,           gadgets[GID_LN_IN1] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_LN_IN1,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       1,
                                INTEGER_Maximum,       11,
                                INTEGER_MinVisible,    2 + 1,
                            IntegerEnd,
                            CHILD_WeightedHeight,      0,
                            Label("Lives:"),
                        LayoutEnd,
                    LayoutEnd,
                LayoutEnd,
                MaximizeButton(GID_LN_BU1, "Maximize Game"),
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                             TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_LN_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_LN_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_LN_IN1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void ln_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_LN_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_LN_CB14:
    case GID_LN_CB15:
        readgadgets();
        writegadgets();
}   }

EXPORT FLAG ln_open(FLAG loadas)
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
    (   page != FUNC_LASTNINJA
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    ghost(GID_LN_IN2, object[13] == 0);
    ghost(GID_LN_IN3, object[14] == 0);
}

MODULE void eithergadgets(void)
{   int i;

    for (i = 0; i < 15; i++)
    {   either_cb(GID_LN_CB1 + i, &object[i]);
    }
    either_in(GID_LN_IN1, &lives);
    for (i = 0; i <  2; i++)
    {   either_in(GID_LN_IN2 + i, &ammo[i]);
    }
    either_ch(GID_LN_CH1, &level);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    IOBuffer[0x61800] = 0x01;

    offset = 0x61801;

    for (i = 0; i < 15; i++)
    {   serialize1(&object[i]);
    }

    if (serializemode == SERIALIZE_WRITE)
    {   lives--;
    }
    serialize2ulong(&lives);
    lives++;

    serialize2ulong(&ammo[1]);
    serialize2ulong(&ammo[0]);

    if (serializemode == SERIALIZE_WRITE)
    {   level++; // 0..6 -> 1..7
    }
    serialize2ulong(&level);
    if (level >= 1)
    {   level--;
}   }

EXPORT void ln_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?Disk.1#?", "Last Ninja Remix", saveas, 819200, FLAG_S, FALSE);
}

EXPORT void ln_close(void) { ; }
EXPORT void ln_exit(void)  { ; }

MODULE void maximize_man(void)
{   int i;

    for (i = 0; i < 15; i++)
    {   object[i] = 1;
    }
    ammo[0] = ammo[1] = 30000;
    lives = 9;
}

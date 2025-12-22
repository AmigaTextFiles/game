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

// main window
#define GID_PANZA_LY1    0 // root layout
#define GID_PANZA_SB1    1 // toolbar
#define GID_PANZA_ST1    2 // name
#define GID_PANZA_BU1    3 // maximize
#define GID_PANZA_IN1    4 // strength
#define GID_PANZA_IN2    5 // resistance
#define GID_PANZA_IN3    6 // reflexes
#define GID_PANZA_BU2    7 // blow "A"
#define GID_PANZA_BU3    8 // blow "B"
#define GID_PANZA_BU4    9 // blow "C"
#define GID_PANZA_BU5   10 // blow "D"
#define GID_PANZA_BU6   11 // blow "E"
#define GID_PANZA_BU7   12 // blow "F"
#define GID_PANZA_BU8   13 // blow "G"
#define GID_PANZA_BU9   14 // blow "H"
#define GID_PANZA_BU10  15 // blow "I"
#define GID_PANZA_BU11  16 // blow "J"
#define GID_PANZA_BU12  17 // blow "K"
#define GID_PANZA_BU13  18 // blow "L"
#define GID_PANZA_BU14  19 // blow "M"
#define GID_PANZA_CH1   20 // game

// blows subwindow
#define GID_PANZA_LY2   21
#define GID_PANZA_LB1   22

#define GIDS_PANZA      GID_PANZA_LB1

#define BlowButton(x)   LAYOUT_AddChild, gadgets[GID_PANZA_BU2 + x] = (struct Gadget*) ZButtonObject, GA_ID, GID_PANZA_BU2 + x, GA_RelVerify, TRUE, GA_Text, "  ", ButtonEnd

#define PANZA1           0
#define PANZA2           1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void blowwindow(void);

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
IMPORT ULONG                offset,
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
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
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

MODULE struct List          BlowsList;
MODULE ULONG                game;

MODULE struct
{  TEXT  name[12 + 1];
   ULONG str, resist, reflex, value,
         blow[13];
} man;

MODULE TEXT BlowAbbrev[13][2 + 1];
MODULE int  whichmove;

MODULE const STRPTR GameOptions[2 + 1] =
{ "Panza Kickboxing 1",
  "Panza Kickboxing 2", // aka Best of the Best Championship Karate
  NULL
};
MODULE const STRPTR BlowNames[55 + 1] = {
"00: Parry",
"01: Rear leg high back round kick",
"02: Rear leg low back round kick",
"03: Rear leg middle back round kick",
"04: Rear leg high jumping back side kick",
"05: Rear leg high jumping back round kick",
"06: Rear leg high jumping back round kick (facing hips)",
"07: Rear leg low front kick",
"08: Rear leg middle front kick",
"09: Rear leg high front kick",
"10: Rear leg axe kick",
"11: Rear leg jumping axe kick",
"12: Rear leg middle jumping front kick",
"13: Rear leg jumping side kick",
"14: Rear leg high hook kick",
"15: Rear leg 'going up' kick",
"16: Rear leg low round kick",
"17: Rear leg middle round kick",
"18: Rear leg high round kick",
"19: Rear leg middle jumping round kick",
"20: Rear leg high jumping round kick",
"21: Rear leg high side kick",
"22: Rear leg middle side kick",
"23: Rear leg low side kick",
"24: Plunging hook",
"25: Uppercut",
"26: Straight right to the face",
"27: Middle straight right",
"28: Middle straight right straight left",
"29: Right hook to the face",
"30: Straight left to the face",
"31: Left hook to the face",
"32: Back fist",
"33: Left swing right swing, with back fist",
"34: Front leg back round kick (facing hips)",
"35: Front leg middle back side kick",
"36: Front leg jumping axe kick",
"37: Front leg middle jumping front kick",
"38: Front leg low front kick",
"39: Front leg middle front kick",
"40: Front leg high front kick",
"41: Front leg middle round kick",
"42: Front leg hook kick to the face",
"43: Front leg 'going up' kick to the face",
"44: Front leg jumping 'going up' kick to the face",
"45: Front leg jumping round kick",
"46: Front leg low round kick",
"47: Front leg high round kick",
"48: Front leg middle round kick",
"49: Front leg high round kick with change of parry position",
"50: Front leg middle round kick with change of parry position",
"51: Front leg low round kick with change of parry position",
"52: Front leg middle side kick",
"53: Front leg low side kick",
"54: Front leg high side kick",
"55: Front leg middle side kick while moving"
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void panza_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // panza_preinit()
        NewList(&BlowsList);
    }

    tool_open      = panza_open;
    tool_loop      = panza_loop;
    tool_save      = panza_save;
    tool_close     = panza_close;
    tool_exit      = panza_exit;
    tool_subgadget = panza_subgadget;

    if (loaded != FUNC_PANZA && !panza_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_PANZA;

    make_speedbar_list(GID_PANZA_SB1);
    load_fimage(FUNC_PANZA);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                 TRUE,
        WA_ThinSizeGadget,                             TRUE,
        WINDOW_LockHeight,                             TRUE,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                            gadgets[GID_PANZA_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_DeferLayout,                        TRUE,
            AddHLayout,
                AddToolbar(GID_PANZA_SB1),
                AddSpace,
                CHILD_WeightedWidth,                   50,
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_PANZA_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                         GID_PANZA_CH1,
                        GA_Disabled,                   TRUE,
                        CHOOSER_LabelArray,            &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,              0,
                LayoutEnd,
                CHILD_WeightedWidth,                   0,
                AddSpace,
                CHILD_WeightedWidth,                   50,
            LayoutEnd,
            AddHLayout,
                LAYOUT_AddChild,                       gadgets[GID_PANZA_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                             GID_PANZA_ST1,
                    GA_TabCycle,                       TRUE,
                    GA_RelVerify,                      TRUE,
                    STRINGA_TextVal,                   man.name,
                    STRINGA_MaxChars,                  12 + 1,
                StringEnd,
                Label("Name:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_PANZA_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_PANZA_IN1,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    AddLabel("%"),
                LayoutEnd,
                Label("Strength:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_PANZA_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_PANZA_IN2,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    AddLabel("%"),
                LayoutEnd,
                Label("Resistance:"),
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_PANZA_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_PANZA_IN3,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    AddLabel("%"),
                LayoutEnd,
                Label("Reflexes:"),
            LayoutEnd,
            AddLabel(""),
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_PANZA),
                CHILD_WeightedWidth,                   0,
                AddSpace,
            LayoutEnd,
            AddLabel(""),
            AddHLayout,
                LAYOUT_BevelStyle,                     BVS_GROUP,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "Blows",
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "No button",
                    AddHLayout,
                       BlowButton(0),
                       BlowButton(1),
                       BlowButton(2),
                    LayoutEnd,
                    AddSpace,
                    AddHLayout,
                       BlowButton(3),
                       AddSpace,
                       BlowButton(4),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "With button",
                    AddHLayout,
                       BlowButton(5),
                       BlowButton(6),
                       BlowButton(7),
                    LayoutEnd,
                    AddHLayout,
                       BlowButton(8),
                       AddSpace,
                       BlowButton(9),
                    LayoutEnd,
                    AddHLayout,
                       BlowButton(10),
                       BlowButton(11),
                       BlowButton(12),
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            MaximizeButton(GID_PANZA_BU1, "Maximize Character"),
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_PANZA_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_PANZA_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_PANZA_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void panza_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_PANZA_BU1:
        readgadgets();

        man.str       =
        man.resist    =
        man.reflex    = 99;

        man.blow[ 0]  = 34;
        man.blow[ 1]  =  5;
        man.blow[ 2]  = 17;
        man.blow[ 3]  = 11;
        man.blow[ 4]  =  8;
        man.blow[ 5]  = 32;
        man.blow[ 6]  =  4;
        man.blow[ 7]  = 33;
        man.blow[ 8]  =  1;
        man.blow[ 9]  = 55;
        man.blow[10]  = 10;
        man.blow[11]  = 25;
        man.blow[12]  = 16;

        writegadgets();
    adefault:
        if (gid >= GID_PANZA_BU2 && gid <= GID_PANZA_BU14)
        {   whichmove = gid - GID_PANZA_BU2;
            blowwindow();
}   }   }

EXPORT FLAG panza_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if     (gamesize == 36)
        {   game = PANZA1;
        } elif (gamesize == 50)
        {   game = PANZA2;
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

MODULE void serialize(void)
{   int i;

    offset = 1;
    serialize1(&man.str   );      //  1
    serialize1(&man.resist);      //  2
    serialize1(&man.reflex);      //  3
    offset = 7;
    if (serializemode == SERIALIZE_READ)
    {   strcpy(man.name, (char*) &IOBuffer[offset]);
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        strcpy((char*) &IOBuffer[offset], man.name);
    }

    if (game == PANZA1)
    {   offset = 22;
        for (i = 0; i < 13; i++)
        {   serialize1(&man.blow[i]); // 22..34
    }   }
    else
    {   // assert(game == PANZA2);
        offset = 25;
        for (i = 0; i < 13; i++)
        {   serialize1(&man.blow[i]); // 25..49
            offset++;
}   }   }

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_PANZA
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    either_ch(GID_PANZA_CH1, &game);
    for (i = 0; i < 13; i++)
    {   if (man.blow[i] > 55)
        {   strcpy( (char*) BlowAbbrev[i], "!!");
        } else
        {   sprintf((char*) BlowAbbrev[i], "%02d", (int) man.blow[i]);
        }
        DISCARD SetGadgetAttrs(gadgets[GID_PANZA_BU2 + i], MainWindowPtr, NULL, GA_Text, BlowAbbrev[i], TAG_END); // this refreshes automatically
}   }

MODULE void eithergadgets(void)
{   either_st(GID_PANZA_ST1,  man.name);
    either_in(GID_PANZA_IN1, &man.str);
    either_in(GID_PANZA_IN2, &man.resist);
    either_in(GID_PANZA_IN3, &man.reflex);
}

EXPORT void panza_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    if (game == PANZA1)
    {   gamesave("BOXER.00?", "Panza Kickboxing 1", saveas, 36, FLAG_C, FALSE);
    } else
    {   gamesave("BOXER.00?", "Panza Kickboxing 2", saveas, 50, FLAG_C, FALSE);
}   }

EXPORT void panza_close(void) { ; }

EXPORT void panza_exit(void)
{   lb_clearlist(&BlowsList);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void blowwindow(void)
{   lb_makelist(&BlowsList, BlowNames, 56);

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                         "Choose Blow",
        WA_SizeGadget,                    TRUE,
        WA_ThinSizeGadget,                TRUE,
        WINDOW_Position,                  WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                  "panza-1",
        WINDOW_ParentGroup,               gadgets[GID_PANZA_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_AddChild,              gadgets[GID_PANZA_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                    GID_PANZA_LB1,
                GA_RelVerify,             TRUE,
                LISTBROWSER_Labels,       (ULONG) &BlowsList,
                LISTBROWSER_MinVisible,   1,
                LISTBROWSER_ShowSelected, TRUE,
                LISTBROWSER_AutoWheel,    FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,               512,
            CHILD_MinHeight,              460,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    DISCARD SetGadgetAttrs(         gadgets[GID_PANZA_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man.blow[whichmove], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_PANZA_LB1], SubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(         gadgets[GID_PANZA_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man.blow[whichmove], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_PANZA_LB1], SubWindowPtr, NULL);

    subloop();

    lb_clearlist(&BlowsList);
    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG panza_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        lb_move_up(  GID_PANZA_LB1, SubWindowPtr, qual, &man.blow[whichmove],  0, 5);
        writegadgets(); // only really need to update BU2+x
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_move_down(GID_PANZA_LB1, SubWindowPtr, qual, &man.blow[whichmove], 55, 5);
        writegadgets(); // only really need to update BU2+x
    }

    return FALSE;
}

EXPORT FLAG panza_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_PANZA_LB1:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_PANZA_LB1], (ULONG*) &man.blow[whichmove]);
        writegadgets();
        return TRUE;
    }

    return FALSE;
}

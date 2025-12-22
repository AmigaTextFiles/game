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
#define GID_SHADOW_LY1   0 // root layout
#define GID_SHADOW_SB1   1 // speedbar
#define GID_SHADOW_ST1   2 // name
#define GID_SHADOW_IN1   3 // cur hp
#define GID_SHADOW_IN2   4 // max hp
#define GID_SHADOW_IN3   5 // cur str
#define GID_SHADOW_IN4   6 // max str
#define GID_SHADOW_IN5   7 // combat
#define GID_SHADOW_IN6   8 // magik
#define GID_SHADOW_IN7   9 // who
#define GID_SHADOW_IN8  10 // food
#define GID_SHADOW_IN9  11 // water
#define GID_SHADOW_IN10 12 // force
#define GID_SHADOW_IN11 13 // X
#define GID_SHADOW_IN12 14 // Y
#define GID_SHADOW_BU1  15 // maximize character
#define GID_SHADOW_BU2  16 // maximize party
#define GID_SHADOW_CH1  17 // game
#define GIDS_SHADOW     GID_SHADOW_CH1

#define GAME_SL          0
#define GAME_SW          1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void eitherman(void);
MODULE void serialize(void);
MODULE void maximize_man(int whichman);
MODULE void addspaces(STRPTR thestring, int howlong);
MODULE void removespaces(STRPTR thestring, int howlong);

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
IMPORT struct Hook          ToolHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
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

MODULE ULONG                game,
                            who;

MODULE const STRPTR GameOptions[2 + 1] =
{ "Shadowlands",
  "Shadoworlds",
  NULL
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   TEXT   name[8 + 1];
    ULONG  curhp,
           maxhp,
           curstr,
           maxstr,
           combat,
           magik,
           food,
           water,
           force,
           x, y;
} man[4];

// 8. EXPORTED CODE ------------------------------------------------------

EXPORT void shadow_main(void)
{   tool_open  = shadow_open;
    tool_loop  = shadow_loop;
    tool_save  = shadow_save;
    tool_close = shadow_close;
    tool_exit  = shadow_exit;

    if (loaded != FUNC_SHADOW && !shadow_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_SHADOW;

    make_speedbar_list(GID_SHADOW_SB1);
    load_fimage(FUNC_SHADOW);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                             TRUE,
        WA_ThinSizeGadget,                         TRUE,
        WINDOW_LockHeight,                         TRUE,
        WINDOW_Position,                           WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                        gadgets[GID_SHADOW_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                     TRUE,
            AddHLayout,
                AddToolbar(GID_SHADOW_SB1),
                AddSpace,
                CHILD_WeightedWidth,               50,
                AddHLayout,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    LAYOUT_AddChild,               gadgets[GID_SHADOW_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                     GID_SHADOW_CH1,
                        GA_Disabled,               TRUE,
                        CHOOSER_LabelArray,        &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,          0,
                LayoutEnd,
                CHILD_WeightedWidth,               0,
                AddSpace,
                CHILD_WeightedWidth,               50,
            LayoutEnd,
            CHILD_WeightedHeight,                  0,
            AddLabel(""),
            CHILD_WeightedHeight,                  0,
            AddHLayout,
                LAYOUT_VertAlignment,              LALIGN_CENTER,
                LAYOUT_AddChild,                   gadgets[GID_SHADOW_IN7] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                         GID_SHADOW_IN7,
                    GA_RelVerify,                  TRUE,
                    GA_TabCycle,                   TRUE,
                    INTEGER_Minimum,               1,
                    INTEGER_Maximum,               4,
                    INTEGER_Number,                who + 1,
                    INTEGER_MinVisible,            2 + 1,
                IntegerEnd,
                Label("_Character #:"),
                AddLabel("of 4"),
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                 BVS_GROUP,
                LAYOUT_SpaceOuter,                 TRUE,
                LAYOUT_Label,                      "Character",
                LAYOUT_AddChild,                   gadgets[GID_SHADOW_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_SHADOW_ST1,
                    GA_TabCycle,                   TRUE,
                    STRINGA_TextVal,               man[who].name,
                    STRINGA_MaxChars,              8 + 1,
                StringEnd,
                Label("_Name:"),
                AddHLayout,
                    LAYOUT_AddChild,               gadgets[GID_SHADOW_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                     GID_SHADOW_IN1,
                        GA_TabCycle,               TRUE,
                        INTEGER_Minimum,           0,
                        INTEGER_Maximum,           999,
                        INTEGER_Number,            man[who].curhp,
                        INTEGER_MinVisible,        3 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,               gadgets[GID_SHADOW_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                     GID_SHADOW_IN2,
                        GA_TabCycle,               TRUE,
                        INTEGER_Minimum,           0,
                        INTEGER_Maximum,           999,
                        INTEGER_Number,            man[who].maxhp,
                        INTEGER_MinVisible,        3 + 1,
                    IntegerEnd,
                    Label("of"),
                LayoutEnd,
                Label("_Health:"),
                AddHLayout,
                    LAYOUT_AddChild,               gadgets[GID_SHADOW_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                     GID_SHADOW_IN3,
                        GA_TabCycle,               TRUE,
                        INTEGER_Minimum,           0,
                        INTEGER_Maximum,           99,
                        INTEGER_Number,            man[who].curstr,
                        INTEGER_MinVisible,        2 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,               gadgets[GID_SHADOW_IN4] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                     GID_SHADOW_IN4,
                        GA_TabCycle,               TRUE,
                        INTEGER_Minimum,           0,
                        INTEGER_Maximum,           99,
                        INTEGER_Number,            man[who].maxstr,
                        INTEGER_MinVisible,        2 + 1,
                    IntegerEnd,
                    Label("of"),
                LayoutEnd,
                Label("_Strength:"),
                LAYOUT_AddChild,                   gadgets[GID_SHADOW_IN5] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                         GID_SHADOW_IN5,
                    GA_TabCycle,                   TRUE,
                    INTEGER_Minimum,               0,
                    INTEGER_Maximum,               99,
                    INTEGER_Number,                man[who].combat,
                    INTEGER_MinVisible,            2 + 1,
                IntegerEnd,
                Label("Com_bat:"),
                LAYOUT_AddChild,                   gadgets[GID_SHADOW_IN6] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                         GID_SHADOW_IN6,
                    GA_TabCycle,                   TRUE,
                    INTEGER_Minimum,               0,
                    INTEGER_Maximum,               99,
                    INTEGER_Number,                man[who].magik,
                    INTEGER_MinVisible,            2 + 1,
                IntegerEnd,
                Label("Magi_k/Tech:"),
                LAYOUT_AddChild,                   gadgets[GID_SHADOW_IN8] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                         GID_SHADOW_IN8,
                    GA_TabCycle,                   TRUE,
                    INTEGER_Minimum,               0,
                    INTEGER_Maximum,               70,
                    INTEGER_Number,                man[who].food,
                    INTEGER_MinVisible,            2 + 1,
                IntegerEnd,
                Label("_Food:"),
                LAYOUT_AddChild,                   gadgets[GID_SHADOW_IN9] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                         GID_SHADOW_IN9,
                    GA_TabCycle,                   TRUE,
                    INTEGER_Minimum,               0,
                    INTEGER_Maximum,               70,
                    INTEGER_Number,                man[who].water,
                    INTEGER_MinVisible,            2 + 1,
                IntegerEnd,
                Label("_Water:"),
                LAYOUT_AddChild,                   gadgets[GID_SHADOW_IN10] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                         GID_SHADOW_IN10,
                    GA_TabCycle,                   TRUE,
                    INTEGER_Minimum,               0,
                    INTEGER_Maximum,               70,
                    INTEGER_Number,                man[who].force,
                    INTEGER_MinVisible,            2 + 1,
                IntegerEnd,
                Label("F_orce:"),
                AddHLayout,
                    LAYOUT_VertAlignment,          LALIGN_CENTER,
                    LAYOUT_AddChild,               gadgets[GID_SHADOW_IN11] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                     GID_SHADOW_IN11,
                        GA_TabCycle,               TRUE,
                        INTEGER_Minimum,           0,
                        INTEGER_Maximum,           65535,
                        INTEGER_Number,            man[who].x,
                        INTEGER_MinVisible,        5 + 1,
                    IntegerEnd,
                    AddLabel("_Y:"),
                    LAYOUT_AddChild,               gadgets[GID_SHADOW_IN12] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                     GID_SHADOW_IN12,
                        GA_TabCycle,               TRUE,
                        INTEGER_Minimum,           0,
                        INTEGER_Maximum,           65535,
                        INTEGER_Number,            man[who].y,
                        INTEGER_MinVisible,        5 + 1,
                    IntegerEnd,
                LayoutEnd,
                Label("_X:"),
                AddHLayout,
                    AddSpace,
                    AddFImage(FUNC_SHADOW),
                    CHILD_WeightedWidth,           0,
                    AddSpace,
                LayoutEnd,
                MaximizeButton(GID_SHADOW_BU1, "Maximize Character"),
            LayoutEnd,
            MaximizeButton(GID_SHADOW_BU2, "Maximize Party"),
        LayoutEnd,
        CHILD_NominalSize,                         TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_SHADOW_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_SHADOW_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_SHADOW_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void shadow_loop(ULONG gid, UNUSED ULONG code)
{   int whichman;

    switch (gid)
    {
    case GID_SHADOW_IN7:
        readgadgets();
        writegadgets();
    acase GID_SHADOW_BU1:
        readgadgets();
        maximize_man(who);
        writegadgets();
    acase GID_SHADOW_BU2:
        readgadgets();
        for (whichman = 0; whichman < 4; whichman++)
        {   maximize_man(whichman);
        }
        writegadgets();
}   }

EXPORT FLAG shadow_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if   (gamesize ==  63882) game = GAME_SL;
        elif (gamesize == 901120) game = GAME_SW;
        else
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

EXPORT void shadow_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  GAME_SL: gamesave("#?Disk.3#?", "Shadowlands", saveas,  63882, FLAG_S, FALSE);
    acase GAME_SW: gamesave("#?Disk.3#?", "Shadoworlds", saveas, 901120, FLAG_S, FALSE);
}   }

EXPORT void shadow_exit(void)  { ; }
EXPORT void shadow_close(void) { ; }

// 9. MODULE CODE --------------------------------------------------------

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eitherman();

    DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_SHADOW_IN7],  (ULONG*) &who           );
    who--;

    gadmode = SERIALIZE_WRITE;
    eitherman();
}

MODULE void writegadgets(void)
{   if
    (   function != FUNC_SHADOW
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eitherman();

    either_ch(GID_SHADOW_CH1, &game);

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SHADOW_IN7], MainWindowPtr, NULL,
        INTEGER_Maximum, 4,
        INTEGER_Number,  who + 1,
    TAG_END); // autorefreshes
}

MODULE void eitherman(void)
{   either_st(GID_SHADOW_ST1,   man[who].name);
    either_in(GID_SHADOW_IN1,  &man[who].curhp);
    either_in(GID_SHADOW_IN2,  &man[who].maxhp);
    either_in(GID_SHADOW_IN3,  &man[who].curstr);
    either_in(GID_SHADOW_IN4,  &man[who].maxstr);
    either_in(GID_SHADOW_IN5,  &man[who].combat);
    either_in(GID_SHADOW_IN6,  &man[who].magik);
    either_in(GID_SHADOW_IN8,  &man[who].food);
    either_in(GID_SHADOW_IN9,  &man[who].water);
    either_in(GID_SHADOW_IN10, &man[who].force);
    either_in(GID_SHADOW_IN11, &man[who].x);
    either_in(GID_SHADOW_IN12, &man[who].y);
}

MODULE void serialize(void)
{   int gap,
        i;

    if (game == GAME_SL)
    {   gap = 162;
    } else
    {   gap = 182;
    }

    for (i = 0; i < 4; i++)
    {   offset =  0xEEC + (48 * i);
        serialize2ulong(&man[i].x);     // $EEC..$EED
        serialize2ulong(&man[i].y);     // $EEE..$EEF

        offset =  0xF0A + (48 * i);
        serialize2ulong(&man[i].curhp); // $F0A..$F0B

        offset =  0xF0E + (48 * i);
        serialize1(&man[i].combat);     // $F0E

        offset =  0xFE5 + (gap * i);
        serialize1(&man[i].magik);      // $FE5
        serialize1(&man[i].curstr);     // $FE6

        offset =  0xFEA + (gap * i);
        serialize1(&man[i].water);      // $FEA
        serialize1(&man[i].food);       // $FEB

        offset =  0xFF6 + (gap * i);
        serialize1(&man[i].maxstr);     // $FF6

        offset =  0xFFA + (gap * i);
        serialize2ulong(&man[i].maxhp); // $FFA..$FFB
        serialize1(&man[i].force);      // $FFC

        offset = 0x1026 + (gap * i);
        if (serializemode == SERIALIZE_WRITE)
        {   addspaces(man[i].name, 8);
            zstrncpy((char*) &IOBuffer[offset], man[i].name, 8); // $1026..$102D
        }
        if (serializemode == SERIALIZE_READ)
        {   zstrncpy(man[i].name, (char*) &IOBuffer[offset], 8); // $1026..$102D
            removespaces(man[i].name, 8);
}   }   }

// These are general-purpose routines
// that could be used by other modules.
MODULE void addspaces(STRPTR thestring, int howlong)
{   int i,
        length;

    length = strlen(thestring);
    if (length >= howlong)
    {   return;
    }

    for (i = howlong - 1; i >= length; i--)
    {   thestring[i] = ' ';
    }
    thestring[howlong] = EOS;
}
MODULE void removespaces(STRPTR thestring, int howlong)
{   int i;

    // assert(strlen(thestring) == howlong);

    for (i = howlong - 1; i >= 0; i--)
    {   if (thestring[i] == ' ')
        {   thestring[i] = EOS;
        } else
        {   return;
}   }   }

MODULE void maximize_man(int whichman)
{   man[whichman].food     =
    man[whichman].water    =
    man[whichman].force    =   70;
    man[whichman].curstr   =
    man[whichman].maxstr   =
    man[whichman].combat   =
    man[whichman].magik    =   90;
    man[whichman].curhp    =
    man[whichman].maxhp    = 9000;
}

EXPORT void shadow_key(UBYTE scancode)
{   switch (scancode)
    {
    case SCAN_Y:
        DISCARD ActivateLayoutGadget(gadgets[GID_SHADOW_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_SHADOW_IN12]);
}   }

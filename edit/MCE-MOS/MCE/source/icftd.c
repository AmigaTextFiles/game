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
#ifndef __MORPHOS__
    #include <gadgets/clock.h>
#endif

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

#define GID_ICFTD_LY1  0 // root layout
#define GID_ICFTD_SB1  1 // toolbar
#define GID_ICFTD_BU1  2 // maximize
#define GID_ICFTD_IN1  3 // date
#define GID_ICFTD_IN2  4 // hour
#define GID_ICFTD_IN3  5 // minute
#define GID_ICFTD_IN4  6 // a
#define GID_ICFTD_IN5  7 // p
#define GID_ICFTD_IN6  8 // c
#define GID_ICFTD_IN7  9 // t
#define GID_ICFTD_CH1 10 // game
#define GID_ICFTD_ST1 11 // month and year
#define GID_ICFTD_CL1 12 // clock
#define GIDS_ICFTD    GID_ICFTD_CL1

#define ICFTD1         0
#define ICFTD2         1

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
#ifndef __MORPHOS__
    IMPORT struct ClassLibrary* ClockBase;
    IMPORT Class*               ClockClass;
#endif

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                army, police, construction, townsfolk,
                            date, hour, minute,
                            game;

MODULE const STRPTR GameOptions[2 + 1] =
{ "ICFTD 1",
  "ICFTD 2: Antheads",
  NULL
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(None)

8. CODE --------------------------------------------------------------- */

EXPORT void icftd_main(void)
{   tool_open  = icftd_open;
    tool_loop  = icftd_loop;
    tool_save  = icftd_save;
    tool_close = icftd_close;
    tool_exit  = icftd_exit;

    if (loaded != FUNC_ICFTD && !icftd_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_ICFTD;

    make_speedbar_list(GID_ICFTD_SB1);
    getclockpens(); // 0..3
    make_clock(GID_ICFTD_CL1);
    load_fimage(FUNC_ICFTD);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                 TRUE,
        WA_ThinSizeGadget,                             TRUE,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                            gadgets[GID_ICFTD_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_SpaceInner,                         TRUE,
            AddHLayout,
                AddToolbar(GID_ICFTD_SB1),
                AddSpace,
                CHILD_WeightedWidth,                   50,
                AddVLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_ICFTD_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                         GID_ICFTD_CH1,
                        GA_Disabled,                   TRUE,
                        CHOOSER_LabelArray,            &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                LayoutEnd,
                CHILD_WeightedWidth,                   0,
                AddSpace,
                CHILD_WeightedWidth,                   50,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_ICFTD),
                CHILD_WeightedWidth,                   0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "When",
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_ICFTD_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_ICFTD_IN1,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               14,
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    CHILD_WeightedWidth,               0,
                    LAYOUT_AddChild,                   gadgets[GID_ICFTD_ST1] = (struct Gadget*)
                    StringObject,
                        GA_ID,                         GID_ICFTD_ST1,
                        GA_ReadOnly,                   TRUE,
                        STRINGA_MinVisible,            12,
                    StringEnd,
                LayoutEnd,
                Label("Date:"),
                CHILD_WeightedHeight,                  0,
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_ICFTD_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_ICFTD_IN2,
                        GA_RelVerify,                  TRUE,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               23,
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    CHILD_WeightedWidth,               0,
                    AddLabel(":"),
                    CHILD_WeightedWidth,               0,
                    LAYOUT_AddChild,                   gadgets[GID_ICFTD_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_ICFTD_IN3,
                        GA_RelVerify,                  TRUE,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               59,
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
#ifndef __MORPHOS__
                    ClockBase ? LAYOUT_AddChild      : TAG_IGNORE, gadgets[GID_ICFTD_CL1],
                    ClockBase ? CHILD_MinWidth       : TAG_IGNORE,  64,
                    ClockBase ? CHILD_MinHeight      : TAG_IGNORE,  64,
                    ClockBase ? CHILD_WeightedHeight : TAG_IGNORE, 100,
                    ClockBase ? CHILD_WeightedWidth  : TAG_IGNORE, 100,
#endif
                LayoutEnd,
                Label("Time:"),
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "Units",
                LAYOUT_AddChild,                       gadgets[GID_ICFTD_IN4] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_ICFTD_IN4,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   99,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Army:"),
                LAYOUT_AddChild,                       gadgets[GID_ICFTD_IN5] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_ICFTD_IN5,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   99,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Police:"),
                LAYOUT_AddChild,                       gadgets[GID_ICFTD_IN6] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_ICFTD_IN6,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   99,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Construction:"),
                LAYOUT_AddChild,                       gadgets[GID_ICFTD_IN7] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_ICFTD_IN7,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   99,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Townsfolk:"),
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
            MaximizeButton(GID_ICFTD_BU1, "Maximize Game"),
            CHILD_WeightedHeight,                      0,
        LayoutEnd,
        CHILD_NominalSize,                             TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_ICFTD_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_ICFTD_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ICFTD_IN1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void icftd_loop(ULONG gid, UNUSED ULONG code)
{   ULONG seconds;

    switch (gid)
    {
    case GID_ICFTD_BU1:
        readgadgets();

        date         = 1;
        hour         = 9;
        minute       = 0;
        army         =
        police       =
        construction =
        townsfolk    = 99;

        writegadgets();
#ifndef __MORPHOS__
    acase GID_ICFTD_CL1:
        // assert(ClockBase);
        DISCARD GetAttr(CLOCKGA_Time, (Object*) gadgets[GID_ICFTD_CL1], (ULONG*) &seconds);
        seconds %= 86400               ; // seconds in day
        hour    =  seconds / 3600      ; // seconds in hour
        minute  = (seconds % 3600) / 60; // seconds in minute
        DISCARD SetGadgetAttrs(gadgets[GID_ICFTD_IN2], MainWindowPtr, NULL, INTEGER_Number, hour,   TAG_END); // autorefreshes
        DISCARD SetGadgetAttrs(gadgets[GID_ICFTD_IN3], MainWindowPtr, NULL, INTEGER_Number, minute, TAG_END); // autorefreshes
#endif
    acase GID_ICFTD_IN2:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_ICFTD_IN2], (ULONG*) &hour);
#ifndef __MORPHOS__
        if (ClockBase)
        {   SetGadgetAttrs(gadgets[GID_ICFTD_CL1], MainWindowPtr, NULL, CLOCKGA_Time, ((hour * 60) + minute) * 60, TAG_END); // autorefreshes
        }
#endif
    acase GID_ICFTD_IN3:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_ICFTD_IN3], (ULONG*) &minute);
#ifndef __MORPHOS__
        if (ClockBase)
        {   SetGadgetAttrs(gadgets[GID_ICFTD_CL1], MainWindowPtr, NULL, CLOCKGA_Time, ((hour * 60) + minute) * 60, TAG_END); // autorefreshes
        }
#endif
}   }

EXPORT FLAG icftd_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if (gamesize == 12444)
        {   game = ICFTD1;
        } elif (gamesize == 13014)
        {   game = ICFTD2;
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
{   if
    (   page != FUNC_ICFTD
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    SetGadgetAttrs
    (   gadgets[GID_ICFTD_ST1],
        MainWindowPtr, NULL,
        STRINGA_TextVal, (game == ICFTD1) ? (STRPTR) "June 1951" : (STRPTR) "January 1956",
    TAG_END);
    either_ch(GID_ICFTD_CH1, &game);
#ifndef __MORPHOS__
    if (ClockBase)
    {   DISCARD SetGadgetAttrs(gadgets[GID_ICFTD_CL1], MainWindowPtr, NULL, CLOCKGA_Time, ((hour * 60) + minute) * 60, TAG_END); // autorefreshes
    }
#endif
    eithergadgets();
}

MODULE void eithergadgets(void)
{   either_in(GID_ICFTD_IN1, &date);
    either_in(GID_ICFTD_IN2, &hour);
    either_in(GID_ICFTD_IN3, &minute);
    either_in(GID_ICFTD_IN4, &army);
    either_in(GID_ICFTD_IN5, &police);
    either_in(GID_ICFTD_IN6, &construction);
    either_in(GID_ICFTD_IN7, &townsfolk);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   offset = 7;
    if (game == ICFTD2)
    {   offset += 2;
    }

    date = 15 - date; // eg. date of 2nd June becomes 13 days remaining
    serialize1(&date        ); //     7/   $9
    date = 15 - date; // eg. 13 days remaining becomes 2nd of June

    offset = 0xB;
    if (game == ICFTD2)
    {   offset += 2;
    }
    serialize1(&hour        ); //    $B/   $D
    offset++;
    serialize1(&minute      ); //    $D/   $F

    offset = 0x242B;
    if (game == ICFTD2)
    {   offset += 2;
    }
    serialize1(&army        ); // $242B/$242D
    offset++;
    serialize1(&police      ); // $242D/$242F
    offset++;
    serialize1(&construction); // $242F/$2431
    offset++;
    serialize1(&townsfolk   ); // $2431/$2433
}

EXPORT void icftd_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  ICFTD1: gamesave("#?ICFTD#?", "ICFTD 1"          , saveas, 12444, FLAG_S, FALSE);
    acase ICFTD2: gamesave("#?ICFTD#?", "ICFTD 2: Antheads", saveas, 13014, FLAG_S, FALSE);
}   }

EXPORT void icftd_close(void) { ; }
EXPORT void icftd_exit(void)  { ; }

EXPORT void icftd_uniconify(void)
{   getclockpens(); // 0..3

#ifndef __MORPHOS__
    if (ClockBase)
    {   RefreshGList((struct Gadget *) gadgets[GID_ICFTD_CL1], MainWindowPtr, NULL, 1);
    }
#endif
}

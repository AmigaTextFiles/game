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

#define GID_FA18_LY1   0 // root layout
#define GID_FA18_SB1   1 // toolbar
#define GID_FA18_BU1   2 // maximize
#define GID_FA18_IN1   3 // hour
#define GID_FA18_IN2   4 // minute
#define GID_FA18_IN3   5 // second
#define GID_FA18_IN4   6 // missions started
#define GID_FA18_IN5   7 // missions completed
#define GID_FA18_IN6   8 // m61     fired
#define GID_FA18_IN7   9 // m61     hits
#define GID_FA18_IN8  10 // aim-120 fired
#define GID_FA18_IN9  11 // aim-120 hits
#define GID_FA18_IN10 12 // aim-9L  fired
#define GID_FA18_IN11 13 // aim-9L  hits
#define GID_FA18_IN12 14 // crashes
#define GID_FA18_IN13 15 // hits from missiles
#define GID_FA18_IN14 16 // missions available
#define GID_FA18_CL1  17 // clock
#define GID_FA18_CB1  18 // qualified?
#define GID_FA18_ST1  19 // name
#define GID_FA18_CH1  20 // next mission
#define GIDS_FA18     GID_FA18_CH1

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
IMPORT struct Library*      TickBoxBase;
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

MODULE const STRPTR MissionNames[6 + 1] = {
"1: Visual Confirmation Mission",
"2: Emergency Defence Operation",
"3: Intercept Stolen Aircraft",
"4: Search and Rescue Operation",
"5: Intercept Incoming Cruise Missile",
"6: Carrier Sub Mission",
NULL};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE TEXT                 name[11 + 1];
MODULE ULONG                available,
                            completed,
                            crashes,
                            hitsfrommissiles,
                            hour, minute, seconds,
                            nextmission,
                            qualified,
                            started,
                            totalsecs,
                            weapon1_fired, weapon1_hits,
                            weapon2_fired, weapon2_hits,
                            weapon3_fired, weapon3_hits;

// 8. CODE ---------------------------------------------------------------

EXPORT void fa18_main(void)
{   tool_open  = fa18_open;
    tool_loop  = fa18_loop;
    tool_save  = fa18_save;
    tool_close = fa18_close;
    tool_exit  = fa18_exit;

    if (loaded != FUNC_FA18 && !fa18_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_FA18;

    make_speedbar_list(GID_FA18_SB1);
    make_seconds_clock(GID_FA18_CL1);
    load_fimage(FUNC_FA18);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_FA18_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            AddToolbar(GID_FA18_SB1),
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_FA18),
                CHILD_WeightedWidth,                       0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "General",
                LAYOUT_AddChild,                           gadgets[GID_FA18_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                                 GID_FA18_ST1,
                    GA_TabCycle,                           TRUE,
                    STRINGA_MaxChars,                      11 + 1,
                    STRINGA_TextVal,                       name,
                StringEnd,
                Label("Name (callsign):"),
                LAYOUT_AddChild,                           gadgets[GID_FA18_IN4] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_FA18_IN4,
                    GA_TabCycle,                           TRUE,
                    GA_RelVerify,                          TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       65535,
                    INTEGER_MinVisible,                    5 + 1,
                IntegerEnd,
                Label("Missions started:"),
                LAYOUT_AddChild,                           gadgets[GID_FA18_IN5] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_FA18_IN5,
                    GA_TabCycle,                           TRUE,
                    GA_RelVerify,                          TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       65535,
                    INTEGER_MinVisible,                    5 + 1,
                IntegerEnd,
                Label("Missions completed:"),
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_FA18_IN14] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_FA18_IN14,
                        GA_TabCycle,                       TRUE,
                        GA_RelVerify,                      TRUE,
                        INTEGER_Minimum,                   1,
                        INTEGER_Maximum,                   6,
                        INTEGER_MinVisible,                1 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                       gadgets[GID_FA18_CB1] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_FA18_CB1,
                        GA_Selected,                       qualified,
                        GA_Text,                           "Qualified?",
                    End,
                    CHILD_WeightedWidth,                   0,
                LayoutEnd,
                Label("Missions available:"),
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_FA18_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_FA18_IN1,
                        GA_TabCycle,                       TRUE,
                        GA_RelVerify,                      TRUE,
                        INTEGER_Minimum,                   0,
                    IntegerEnd,
                    AddLabel(":"),
                    LAYOUT_AddChild,                       gadgets[GID_FA18_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_FA18_IN2,
                        GA_TabCycle,                       TRUE,
                        GA_RelVerify,                      TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   59,
                        INTEGER_MinVisible,                2 + 1,
                    IntegerEnd,
                    AddLabel(":"),
                    CHILD_WeightedWidth,                   0,
                    LAYOUT_AddChild,                       gadgets[GID_FA18_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_FA18_IN3,
                        GA_TabCycle,                       TRUE,
                        GA_RelVerify,                      TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   59,
                        INTEGER_MinVisible,                2 + 1,
                    IntegerEnd,
                    CHILD_WeightedWidth,                   0,
#ifndef __MORPHOS__
                    ClockBase ? LAYOUT_AddChild : TAG_IGNORE, gadgets[GID_FA18_CL1],
                    ClockBase ? CHILD_MinWidth  : TAG_IGNORE, 64,
                    ClockBase ? CHILD_MinHeight : TAG_IGNORE, 64,
#endif
                LayoutEnd,
                Label("Flight time:"),
                LAYOUT_AddChild,                           gadgets[GID_FA18_IN12] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_FA18_IN12,
                    GA_TabCycle,                           TRUE,
                    GA_RelVerify,                          TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       65535,
                    INTEGER_MinVisible,                    5 + 1,
                IntegerEnd,
                Label("Crashes:"),
                LAYOUT_AddChild,                           gadgets[GID_FA18_IN13] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_FA18_IN13,
                    GA_TabCycle,                           TRUE,
                    GA_RelVerify,                          TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       65535,
                    INTEGER_MinVisible,                    5 + 1,
                IntegerEnd,
                Label("Hits from missiles:"),
                LAYOUT_AddChild,                           gadgets[GID_FA18_CH1] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                 GID_FA18_CH1,
                    GA_RelVerify,                          TRUE,
                    CHOOSER_LabelArray,                    &MissionNames,
                End,
                Label("Next mission:"),
            LayoutEnd,
            AddHLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Weapons",
                AddVLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    AddLabel("M61 cannon rounds:"),
                    AddLabel("AIM-120 AMRAAMS:"),
                    AddLabel("AIM-9L Sidewinders:"),
                LayoutEnd,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    AddVLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        AddLabel("Fired:"),
                        AddLabel("Fired:"),
                        AddLabel("Fired:"),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_FA18_IN6] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_FA18_IN6,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_FA18_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_FA18_IN8,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_FA18_IN10] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_FA18_IN10,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        AddLabel("Hits:"),
                        AddLabel("Hits:"),
                        AddLabel("Hits:"),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    AddVLayout,
                        LAYOUT_AddChild,                   gadgets[GID_FA18_IN7] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_FA18_IN7,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_FA18_IN9] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_FA18_IN9,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_FA18_IN11] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_FA18_IN11,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                    LayoutEnd,
                LayoutEnd,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            MaximizeButton(GID_FA18_BU1, "Maximize Game"),
            CHILD_WeightedHeight,                          0,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_FA18_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_FA18_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_FA18_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void fa18_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_FA18_BU1:
        readgadgets();

        crashes          =
        hitsfrommissiles = 0;
        available        = 6;
        qualified        = TRUE;

        writegadgets();
#ifndef __MORPHOS__
    acase GID_FA18_CL1:
        // assert(ClockBase);
        DISCARD GetAttr(CLOCKGA_Time,     (Object*) gadgets[GID_FA18_CL1], (ULONG*) &totalsecs);
        hour    =  totalsecs / 3600      ;
        minute  = (totalsecs % 3600) / 60;
        seconds =  totalsecs %   60      ;
        DISCARD SetGadgetAttrs(gadgets[GID_FA18_IN1], MainWindowPtr, NULL, INTEGER_Number, hour,    TAG_END); // autorefreshes
        DISCARD SetGadgetAttrs(gadgets[GID_FA18_IN2], MainWindowPtr, NULL, INTEGER_Number, minute,  TAG_END); // autorefreshes
        DISCARD SetGadgetAttrs(gadgets[GID_FA18_IN3], MainWindowPtr, NULL, INTEGER_Number, seconds, TAG_END); // autorefreshes
#endif
    acase GID_FA18_IN1:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_FA18_IN1], (ULONG*) &hour);
        totalsecs = (hour * 3600) + (minute * 60) + seconds;
#ifndef __MORPHOS__
        if (ClockBase)
        {   DISCARD SetGadgetAttrs(gadgets[GID_FA18_CL1], MainWindowPtr, NULL, CLOCKGA_Time, totalsecs, TAG_END); // autorefreshes
        }
#endif
    acase GID_FA18_IN2:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_FA18_IN2], (ULONG*) &minute);
        totalsecs = (hour * 3600) + (minute * 60) + seconds;
#ifndef __MORPHOS__
        if (ClockBase)
        {   DISCARD SetGadgetAttrs(gadgets[GID_FA18_CL1], MainWindowPtr, NULL, CLOCKGA_Time, totalsecs, TAG_END); // autorefreshes
        }
#endif
    acase GID_FA18_IN3:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_FA18_IN3], (ULONG*) &seconds);
        totalsecs = (hour * 3600) + (minute * 60) + seconds;
#ifndef __MORPHOS__
        if (ClockBase)
        {   DISCARD SetGadgetAttrs(gadgets[GID_FA18_CL1], MainWindowPtr, NULL, CLOCKGA_Time, totalsecs, TAG_END); // autorefreshes
        }
#endif
}   }

EXPORT FLAG fa18_open(FLAG loadas)
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
    (   page != FUNC_FA18
     || !MainWindowPtr
    )
    {   return;
    } // implied else

#ifndef __MORPHOS__
    if (ClockBase)
    {   DISCARD SetGadgetAttrs(gadgets[GID_FA18_CL1], MainWindowPtr, NULL, CLOCKGA_Time, totalsecs, TAG_END); // autorefreshes
    }
#endif

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   either_in(GID_FA18_IN1 , &hour);
    either_in(GID_FA18_IN2 , &minute);
    either_in(GID_FA18_IN3 , &seconds);
    either_in(GID_FA18_IN4 , &started);
    either_in(GID_FA18_IN5 , &completed);
    either_in(GID_FA18_IN6 , &weapon1_fired);
    either_in(GID_FA18_IN7 , &weapon1_hits);
    either_in(GID_FA18_IN8 , &weapon2_fired);
    either_in(GID_FA18_IN9 , &weapon2_hits);
    either_in(GID_FA18_IN10, &weapon3_fired);
    either_in(GID_FA18_IN11, &weapon3_hits);
    either_in(GID_FA18_IN12, &crashes);
    either_in(GID_FA18_IN13, &hitsfrommissiles);
    either_in(GID_FA18_IN14, &available);

    either_cb(GID_FA18_CB1 , &qualified);

    either_st(GID_FA18_ST1 ,  name);

    either_ch(GID_FA18_CH1 , &nextmission);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    offset = 0;

    if (qualified)
    {   qualified = 1;
    }
    serialize2ulong(&qualified);        //  $0.. $1
    if (qualified)
    {   qualified = TRUE;
    }

    offset = 0x6;
    nextmission += 2;
    serialize1(&nextmission);           //  $6
    if (nextmission >= 2)
    {   nextmission -= 2;
    } elif (nextmission == 1)
    {   nextmission = 0;
    }
    if (nextmission >= 6)
    {   nextmission = 0;
    }

    offset = 0x8;
    totalsecs = (hour * 3600) + (minute * 60) + seconds;
    serialize4(&totalsecs);          //  $8.. $B
    hour    =  totalsecs / 3600;
    minute  = (totalsecs % 3600) / 60;
    seconds =  totalsecs %   60;

    // offset = 0x14; not needed
    if (serializemode == SERIALIZE_READ)
    {   available = 1;
        for (i = 0; i < 7; i++)
        {   if (IOBuffer[0x14 + i])
            {   available++;
        }   }
        if (available > 6)
        {   available = 6;
    }   }
    else
    {   // assert(serializemode == SERIALIZE_WRITE);
        IOBuffer[0x14] = 0;
        IOBuffer[0x15] = (available >= 2) ? 1 : 0;
        IOBuffer[0x16] = (available >= 3) ? 1 : 0;
        IOBuffer[0x17] = (available >= 4) ? 1 : 0;
        IOBuffer[0x18] = (available >= 5) ? 1 : 0;
        IOBuffer[0x19] = (available >= 6) ? 1 : 0;
        IOBuffer[0x1A] = 0;
    }

    offset = 0x1E;
    DISCARD strupr(name);
    serstring(name); // this doesn't adjust the offset

    offset = 0x36;
    serialize2ulong(&started);          // $36..$37
    serialize2ulong(&completed);        // $38..$39
    serialize2ulong(&weapon1_fired);    // $3A..$3B
    serialize2ulong(&weapon1_hits);     // $3C..$3D
    serialize2ulong(&weapon2_fired);    // $3E..$3F
    serialize2ulong(&weapon2_hits);     // $40..$41
    serialize2ulong(&weapon3_fired);    // $42..$43
    serialize2ulong(&weapon3_hits);     // $44..$45
    serialize2ulong(&crashes);          // $46..$47
    serialize2ulong(&hitsfrommissiles); // $48..$49
}

EXPORT void fa18_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("config", "F/A-18 Interceptor", saveas, 78, FLAG_S, FALSE);

    writegadgets(); // to update name uppercasing
}

EXPORT void fa18_close(void) { ; }
EXPORT void fa18_exit(void)  { ; }

EXPORT void fa18_uniconify(void)
{   getclockpens();
#ifndef __MORPHOS__
    if (ClockBase)
    {   RefreshGList((struct Gadget *) gadgets[GID_FA18_CL1], MainWindowPtr, NULL, 1);
    }
#endif
}

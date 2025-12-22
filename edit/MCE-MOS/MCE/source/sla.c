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

// #define SHOWVALUES
// whether you want the actual values shown in the console window

// main window
#define GID_SLA_LY1    0 // root layout
#define GID_SLA_SB1    1 // toolbar
#define GID_SLA_SP1    2 // map
#define GID_SLA_CH1    3 // facing
#define GID_SLA_IN1    4 // X
#define GID_SLA_IN2    5 // Y
#define GID_SLA_ST1    6 // description
#define GIDS_SLA       GID_SLA_ST1

#define MAPWIDTH     125 // 0..124
#define MAPHEIGHT     61
#define MAPSCALE       4
#define SCALEDWIDTH    (MAPWIDTH  * MAPSCALE)
#define SCALEDHEIGHT   (MAPHEIGHT * MAPSCALE)

#define BLUE        0
#define DARKGREEN   1
#define YELLOW      2
#define WHITE       3
#define BLACK       4
#define RED         5
#define LIGHTGREEN  6
#define GREY        7
#define PURPLE      8
#define DARKGREY    9
#define ORANGE     10
#define CYAN       11
#define PINK       12

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void drawpoint(int x, int y, int colour);
// MODULE FLAG valid(int x, int y);

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
IMPORT LONG                 pens[PENS];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT Object*              WinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT UBYTE*               byteptr1[DISPLAY1HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE];
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

MODULE ULONG                facing,
                            sla_map[MAPHEIGHT][MAPWIDTH];
MODULE int                  location_x, // must be signed!
                            location_y;
MODULE struct List          FacingList;

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  BB.. .... .... ....    . = Transparent  (%00)
    BRB. .... .... ....    R = Red          (%01)
    BRRB .... .... ....    B = Black        (%10)
    BRRR B... .... ....
    BRRR RB.. .... ....
    BRRR RRB. .... ....
    BRRR RRRB .... ....
    BRRR RRRR B... ....
    BRRR RRRR RB.. ....
    BRRR RRBB BBB. ....
    BRRB RRB. .... ....
    BRB. BRRB .... ....
    BB.. BRRB .... ....
    B... .BRR B... ....
    .... .BRR B... ....
    .... ..BB B... ....

          Plane 1                Plane 0
    BB.. .... .... ....    .... .... .... ....
    B.B. .... .... ....    .R.. .... .... ....
    B..B .... .... ....    .RR. .... .... ....
    B... B... .... ....    .RRR .... .... ....
    B... .B.. .... ....    .RRR R... .... ....
    B... ..B. .... ....    .RRR RR.. .... ....
    B... ...B .... ....    .RRR RRR. .... ....
    B... .... B... ....    .RRR RRRR .... ....
    B... .... .B.. ....    .RRR RRRR R... ....
    B... ..BB BBB. ....    .RRR RR.. .... ....
    B..B ..B. .... ....    .RR. RR.. .... ....
    B.B. B..B .... ....    .R.. .RR. .... ....
    BB.. B..B .... ....    .... .RR. .... ....
    B... .B.. B... ....    .... ..RR .... ....
    .... .B.. B... ....    .... ..RR .... ....
    .... ..BB B... ....    .... .... .... ....
           Black                   Red

    Plane 1 Plane 0 */
    0xC000, 0x0000,
    0xA000, 0x4000,
    0x9000, 0x6000,
    0x8800, 0x7000,
    0x8400, 0x7800,
    0x8200, 0x7C00,
    0x8100, 0x7E00,
    0x8080, 0x7F00,
    0x8040, 0x7F80,
    0x83E0, 0x7C00,
    0x9200, 0x6C00,
    0xA900, 0x4600,
    0xC900, 0x0600,
    0x8480, 0x0300,
    0x0480, 0x0300,
    0x0380, 0x0000,

    0x0000, 0x0000  // reserved
};
#endif

MODULE const STRPTR FacingOptions[4 + 1] =
{ "North",
  "East",
  "South",
  "West",
  NULL
};

// 7. MODULE STRUCTURES --------------------------------------------------

#define SQUARETYPES (59 + 1)
MODULE struct
{   ULONG  code;
    STRPTR desc;
    int    colour;
} squares[SQUARETYPES] = {
{ 0x00000000, "Unused in novice mode", GREY       }, //  0
{ 0x39D66F0D, "Unknown"              , GREY       },
{ 0x3F80004B, "Wall"                 , BLACK      },
{ 0x3F800D67, "Power room"           , CYAN       },
{ 0x3F800DBB, "Computer room"        , CYAN       },
{ 0x3F800E63, "Teleporter"           , CYAN       },
{ 0x3F800EB6, "Lobby"                , CYAN       },
{ 0x3F800F5E, "Store room"           , CYAN       },
{ 0x3F800FB2, "Waiting room"         , CYAN       },
{ 0x3F800F0A, "Control room"         , CYAN       },
{ 0x3F801006, "Control room"         , CYAN       }, // 10
{ 0x3FE09121, "Terminal room"        , CYAN       },
{ 0x3FE0B1E6, "Terminal room"        , CYAN       },
{ 0x3FE0D2AA, "Terminal room"        , CYAN       },
{ 0x3FE0F36F, "Terminal room"        , CYAN       },
{ 0x3FE11433, "Terminal room"        , CYAN       },
{ 0x40000026, "Empty corridor"       , DARKGREEN  },
{ 0x400676EE, "Force field"          , ORANGE     },
{ 0x400676EF, "Force field"          , ORANGE     },
{ 0x40068751, "Ionization beam"      , ORANGE     },
{ 0x400697B3, "Proton mine"          , ORANGE     }, // 20
{ 0x401A8F82, "Repair module"        , PINK       },
{ 0x40400026, "Unguarded black door" , DARKGREY   },
{ 0x4040060C, "Guarded black door"   , DARKGREY   },
{ 0x40400636, "Guarded black door"   , DARKGREY   },
{ 0x40400660, "Guarded black door"   , DARKGREY   },
{ 0x4040068A, "Guarded black door"   , DARKGREY   },
{ 0x4040082D, "Unguarded blue door"  , BLUE       },
{ 0x40400857, "Unguarded green door" , LIGHTGREEN },
{ 0x40400881, "Unguarded yellow door", YELLOW     },
{ 0x404008AB, "Unguarded red door"   , RED        }, // 30
{ 0x404008D5, "Unguarded white door" , WHITE      },
{ 0x40800013, "Empty room"           , DARKGREEN  },
{ 0x40868F6F, "Blueprint"            , PINK       },
{ 0x4089E367, "Logic probe"          , PINK       },
{ 0x4089F3C9, "Security pass"        , PINK       },
{ 0x4089FBFA, "Teleport activator"   , PINK       },
{ 0x4089DB36, "Energy syphon"        , PINK       },
{ 0x4089EB98, "Terminal interface"   , PINK       },
{ 0x408D375F, "Locked box"           , PINK       },
{ 0x408D3F90, "Key"                  , PINK       }, // 40
{ 0x408D47C1, "Repair module"        , PINK       },
{ 0x408D4FF2, "Field neutralizer"    , PINK       },
{ 0x408D5823, "De-ionizer rod"       , PINK       },
{ 0x408D6054, "Mine deactivator"     , PINK       },
{ 0x4090A3EA, "Energy disruptor"     , PINK       },
{ 0x4090AC1B, "Photon grenade"       , PINK       },
{ 0x4093E77F, "Blue key card"        , PINK       },
{ 0x4093EFB1, "Green key card"       , PINK       },
{ 0x4093F7E2, "Yellow key card"      , PINK       },
{ 0x40940013, "Red key card"         , PINK       }, // 50
{ 0x40940844, "White key card"       , PINK       },
{ 0x409418A6, "Green lazer pistol"   , PINK       },
{ 0x409420D7, "Red lazer pistol"     , PINK       },
{ 0x4094313A, "Green shield belt"    , PINK       },
{ 0x4094396B, "Red shield belt"      , PINK       },
{ 0x4094419C, "Blue energy pod"      , PINK       },
{ 0x409449CD, "Green energy pod"     , PINK       },
{ 0x409451FE, "Red energy pod"       , PINK       },
{ 0x409451FF, "Red energy pod"       , PINK       }, // 59
};
// 8. CODE ---------------------------------------------------------------

EXPORT void sla_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // sla_preinit()
        NewList(&FacingList);
    }

    tool_open  = sla_open;
    tool_loop  = sla_loop;
    tool_save  = sla_save;
    tool_close = sla_close;
    tool_exit  = sla_exit;

    if (loaded != FUNC_SLAYGON && !sla_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_SLAYGON;

    make_speedbar_list(GID_SLA_SB1);
    ch_load_aiss_images(11, 14, FacingOptions, &FacingList);
    sla_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WINDOW_LockHeight,                     TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                    gadgets[GID_SLA_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            AddToolbar(GID_SLA_SB1),
            AddVLayout,
                LAYOUT_BevelStyle,             BVS_GROUP,
                LAYOUT_Label,                  "Location",
                LAYOUT_SpaceOuter,             TRUE,
                AddHLayout,
                    AddSpace,
                    CHILD_WeightedWidth,       50,
                    LAYOUT_AddChild,           gadgets[GID_SLA_SP1] = (struct Gadget*)
                    SpaceObject,
                        GA_ID,                 GID_SLA_SP1,
                        SPACE_MinWidth,        SCALEDWIDTH,
                        SPACE_MinHeight,       SCALEDHEIGHT,
                        SPACE_BevelStyle,      BVS_FIELD,
                        SPACE_Transparent,     TRUE,
                    SpaceEnd,
                    CHILD_WeightedWidth,       0,
                    AddSpace,
                    CHILD_WeightedWidth,       50,
                LayoutEnd,
                CHILD_WeightedHeight,          0,
                AddHLayout,
                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                    AddLabel("X:"),
                    CHILD_WeightedWidth,       0,
                    LAYOUT_AddChild,           gadgets[GID_SLA_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_SLA_IN1,
                        GA_TabCycle,           TRUE,
                        GA_RelVerify,          TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       MAPWIDTH - 1,
                        INTEGER_Number,        location_x,
                        INTEGER_MinVisible,    2 + 1,
                    IntegerEnd,
                    AddLabel("Y:"),
                    CHILD_WeightedWidth,       0,
                    LAYOUT_AddChild,           gadgets[GID_SLA_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_SLA_IN2,
                        GA_TabCycle,           TRUE,
                        GA_RelVerify,          TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       MAPHEIGHT - 1,
                        INTEGER_Number,        location_y,
                        INTEGER_MinVisible,    2 + 1,
                    IntegerEnd,
                    AddLabel("Facing:"),
                    CHILD_WeightedWidth,       0,
                    LAYOUT_AddChild,           gadgets[GID_SLA_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                 GID_SLA_CH1,
                        CHOOSER_Labels,        &FacingList,
                    PopUpEnd,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                    AddLabel("Contents of square:"),
                    CHILD_WeightedWidth,       0,
                    LAYOUT_AddChild,           gadgets[GID_SLA_ST1] = (struct Gadget*)
                    StringObject,
                        GA_ID,                 GID_SLA_ST1,
                        GA_ReadOnly,           TRUE,
                        STRINGA_TextVal,       "",
                        STRINGA_MaxChars,      32 + 1,
                    StringEnd,
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                     TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_SLA_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif

    setup_bm(0, SCALEDWIDTH, SCALEDHEIGHT, MainWindowPtr);

    // sla_drawmap();
    writegadgets();
    loop();
    readgadgets();
    closewindow();
}

EXPORT void sla_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_SLA_IN1:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_SLA_IN1], (ULONG*) &location_x);
        sla_drawmap();
    acase GID_SLA_IN2:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_SLA_IN2], (ULONG*) &location_y);
        sla_drawmap();
}   }

EXPORT FLAG sla_open(FLAG loadas)
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
    (   page != FUNC_SLAYGON
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
    sla_drawmap();
}

MODULE void eithergadgets(void)
{   either_ch(GID_SLA_CH1, &facing);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int x, y;

    offset = 0x7D27; serialize1((ULONG*) &location_x);
    offset = 0x7D29; serialize1((ULONG*) &location_y);

    facing++;
    offset = 0x7D2B; serialize1((ULONG*) &facing);
    facing--;

    if (serializemode == SERIALIZE_READ)
    {   offset = 0x7DB8;
        for (x = 0; x < MAPWIDTH; x++)
        {   for (y = 0; y < MAPHEIGHT; y++)
            {   serialize4(&sla_map[y][x]);
            }
            offset += 16;
}   }   }

EXPORT void sla_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?slaygon.save#?", "Slaygon", saveas, 64684, FLAG_S, FALSE);
}

EXPORT void sla_close(void) { ; }

EXPORT void sla_exit(void)
{   ch_clearlist(&FacingList);
}

EXPORT void sla_drawmap(void)
{   int  i,
         x, y;
    FLAG ok;

    for (y = 0; y < MAPHEIGHT; y++)
    {   for (x = 0; x < MAPWIDTH; x++)
        {   ok = FALSE;
            for (i = 0; i < SQUARETYPES; i++)
            {   if (sla_map[y][x] == squares[i].code)
                {   drawpoint(x, y, squares[i].colour);
                    ok = TRUE;
                    break; // for speed
            }   }
            if (!ok)
            {   drawpoint(x, y, PURPLE);
    }   }   }

    for (x = 0; x < MAPWIDTH; x++)
    {   if (x != location_x)
        {   drawpoint(x, location_y, 3);
    }   }
    for (y = 0; y < MAPHEIGHT; y++)
    {   if (y != location_y)
        {   drawpoint(location_x, y, 3);
    }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_SLA_SP1]->LeftEdge,
        gadgets[GID_SLA_SP1]->TopEdge,
        gadgets[GID_SLA_SP1]->LeftEdge + SCALEDWIDTH  - 1,
        gadgets[GID_SLA_SP1]->TopEdge  + SCALEDHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SLA_IN1], MainWindowPtr, NULL,
        INTEGER_Number, location_x,
    TAG_END); // this autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_SLA_IN2], MainWindowPtr, NULL,
        INTEGER_Number, location_y,
    TAG_END); // this autorefreshes

#ifdef SHOWVALUES
    i = 0x7DB8 + (location_x * ((MAPHEIGHT * 4) + 16)) + (location_y * 4);
    printf("%d: x %3d, y %2d: %02X %02X %02X %02X.\n", i, location_x, location_y, IOBuffer[i], IOBuffer[i + 1], IOBuffer[i + 2], IOBuffer[i + 3]);
#endif

    ok = FALSE;
    for (i = 0; i < SQUARETYPES; i++)
    {   if (sla_map[location_y][location_x] == squares[i].code)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_SLA_ST1],
                MainWindowPtr, NULL,
                STRINGA_TextVal, squares[i].desc,
            TAG_END);
            ok = TRUE;
            break; // for speed
    }   }
    if (!ok)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_SLA_ST1],
            MainWindowPtr, NULL,
            STRINGA_TextVal, "Unknown",
        TAG_END);
}   }

MODULE void drawpoint(int x, int y, int colour)
{   int xx, yy;

    for (yy = 0; yy < MAPSCALE; yy++)
    {   for (xx = 0; xx < MAPSCALE; xx++)
        {   *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[colour];
}   }   }

EXPORT void sla_lmb(SWORD mousex, SWORD mousey)
{   int temp_x, temp_y;

    if
    (   mousex < gadgets[GID_SLA_SP1]->LeftEdge
     || mousey < gadgets[GID_SLA_SP1]->TopEdge
     || mousex > gadgets[GID_SLA_SP1]->LeftEdge + SCALEDWIDTH  - 1
     || mousey > gadgets[GID_SLA_SP1]->TopEdge  + SCALEDHEIGHT - 1
    )
    {   return;
    }

    temp_x = ((mousex - gadgets[GID_SLA_SP1]->LeftEdge) / MAPSCALE);
    temp_y = ((mousey - gadgets[GID_SLA_SP1]->TopEdge ) / MAPSCALE);
    // if (valid(temp_x, temp_y)) {
    location_x = temp_x;
    location_y = temp_y;
    sla_drawmap();
    // }
}

/* MODULE FLAG valid(int x, int y)
{   return TRUE;
} */

EXPORT void sla_key(UBYTE scancode, UWORD qual)
{   switch (scancode)
    {
    case SCAN_LEFT:
    case SCAN_N4:
        map_leftorup(qual, MAPWIDTH, &location_x, 0, NULL);
        sla_drawmap();
    acase SCAN_RIGHT:
    case SCAN_N6:
        map_rightordown(qual, MAPWIDTH, &location_x, 0, NULL);
        sla_drawmap();
    acase SCAN_UP:
    case SCAN_N8:
    case NM_WHEEL_UP:
        map_leftorup(qual, MAPHEIGHT, &location_y, 0, NULL);
        sla_drawmap();
    acase SCAN_DOWN:
    case SCAN_N5:
    case SCAN_N2:
    case NM_WHEEL_DOWN:
        map_rightordown(qual, MAPHEIGHT, &location_y, 0, NULL);
        sla_drawmap();
    acase SCAN_N1:
        map_leftorup(qual, MAPWIDTH, &location_x, 0, NULL);
        map_rightordown(qual, MAPHEIGHT, &location_y, 0, NULL);
        sla_drawmap();
    acase SCAN_N3:
        map_rightordown(qual, MAPWIDTH, &location_x, 0, NULL);
        map_rightordown(qual, MAPHEIGHT, &location_y, 0, NULL);
        sla_drawmap();
    acase SCAN_N7:
        map_leftorup(qual, MAPWIDTH, &location_x, 0, NULL);
        map_leftorup(qual, MAPHEIGHT, &location_y, 0, NULL);
        sla_drawmap();
    acase SCAN_N9:
        map_rightordown(qual, MAPWIDTH, &location_x, 0, NULL);
        map_leftorup(qual, MAPHEIGHT, &location_y, 0, NULL);
        sla_drawmap();
}   }

EXPORT void sla_getpens(void)
{   lockscreen();

    pens[BLUE      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xFFFFFFFF, -1);
    pens[DARKGREEN ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x88888888, 0x00000000, -1);
    pens[YELLOW    ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, -1);
    pens[WHITE     ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1);
    pens[BLACK     ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1);
    pens[RED       ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1);
    pens[LIGHTGREEN] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xFFFFFFFF, 0x00000000, -1);
    pens[GREY      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0x88888888, -1);
    pens[PURPLE    ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFF, -1);
    pens[DARKGREY  ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x44444444, 0x44444444, 0x44444444, -1);
    pens[ORANGE    ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x88888888, 0x00000000, -1);
    pens[CYAN      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xFFFFFFFF, 0xFFFFFFFF, -1);
    pens[PINK      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x88888888, 0x88888888, -1);

    unlockscreen();
}

EXPORT void sla_uniconify(void)
{   sla_getpens();
    sla_drawmap();
}

EXPORT void sla_tick(SWORD mousex, SWORD mousey)
{   if (mouseisover(GID_SLA_SP1, mousex, mousey))
    {   setpointer(TRUE , WinObject, MainWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
}   }

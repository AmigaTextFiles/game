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

// main window
#define GID_ZERG_LY1    0 // root layout
#define GID_ZERG_SB1    1 // toolbar
#define GID_ZERG_ST1    2 // name
#define GID_ZERG_IN1    3 // gp
#define GID_ZERG_IN2    4 // xp
#define GID_ZERG_IN3    5 // cur hp
#define GID_ZERG_IN4    6 // max hp
#define GID_ZERG_IN5    7 // body count
#define GID_ZERG_IN6    8 // cur mp
#define GID_ZERG_IN7    9 // max mp
#define GID_ZERG_IN8   10 // level
#define GID_ZERG_IN9   11 // str
#define GID_ZERG_IN10  12 // wis
#define GID_ZERG_IN11  13 // turn
#define GID_ZERG_BU1   14 // maximize character
#define GID_ZERG_CH1   15 // armour
#define GID_ZERG_CH2   16 // weapon
#define GID_ZERG_SP1   17 // map
#define GID_ZERG_ST2   18 // contents
#define GIDS_ZERG      GID_ZERG_ST2

#define MAPWIDTH       45
#define MAPHEIGHT      46
#define MAPSCALE        4
#define SCALEDWIDTH    (MAPWIDTH  * MAPSCALE)
#define SCALEDHEIGHT   (MAPHEIGHT * MAPSCALE)

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(void);
MODULE void eithergadgets(void);
MODULE void drawpoint(int x, int y, int colour);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra;
IMPORT LONG                 gamesize,
                            pens[PENS];
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
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT UBYTE*               byteptr1[DISPLAY1HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE];

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                armour,
                            bodycount,
                            gp,
                            xp,
                            level,
                            curhp,
                            maxhp,
                            curmp,
                            maxmp,
                            str,
                            turn,
                            weapon,
                            wis;
MODULE int                  location_x, // must be signed!
                            location_y;
MODULE TEXT                 name[8 + 1];

MODULE const STRPTR ArmourOptions[10 + 1] =
{ "None",
  "Heavy furs",
  "Leather",
  "Studded leather",
  "Scale mail",
  "Chain mail",
  "Full mail",
  "Splint mail",
  "Banded mail",
  "Plate mail",
  NULL
}, WeaponOptions[10 + 1] =
{ "Hands",
  "Dagger",
  "Mace",
  "Spear",
  "Short sword",
  "Flail",
  "Longsword",
  "Morning star",
  "Battle axe",
  "Pike",
  NULL
};

MODULE const STRPTR zerg_map[MAPHEIGHT] = {
".............................................",
".............................................",
".................................--..........",
"....................-..111......---..........",
"....-..----........--111111-.-....--.........",
"...--.-2------....-21111111-.-.....-.........",
"...-..222---2------222111---.................",
"......22---22-22----22--22-..----............",
".....22--*-2--..---------^-.----.............",
"......--^^---..-----.-----------.............",
".........^^^..-222--..-----21---.............",
"..........^.....22.--.----1112---.--.........",
".....--.............-..---1122-----..........",
".......................-2-222-----...........",
"..........--............222------...---......",
".......................22----.----.---.......",
"........................22-...--------.......",
"...............^-.-.........----------.......",
"............-^^11--......--..-----1--........",
".............-221.......---------12--........",
"................--.....--11-----122-^........",
"...............--.....--1111--111122-^.......",
"..........-2...-......-1111----11212-^.......",
"...........--........--1----.1111222--^......",
"......................---...11121222-^^......",
"...............................21222-^.......",
"...............................2212-^........",
"..^^..-.........................122--........",
"...............................-12----.......",
".....-.........^..-...........--22----.......",
"..--..........^^-.--1........---------.......",
".--............22-112........--^^--1--.......",
".-^-.............2...........2---^^1---......",
"..-^2...........2...........22--222----......",
"..---2......................2--....---.......",
"..^^-^..............2-......---....--........",
"...--^.............11.....---2-....-.........",
"....-^^.--......----...-----22------^........",
"....--^-.--.-........---22----222--^.........",
"...-22-^....----2.-----212---211-............",
"....21----.----2222-111+12---21...--.........",
".....-1-1111--211111121112-^..-..^2..........",
"......222^^^.-21111--1112-^.....^^...........",
"......22.....2211..-.^12-^...................",
"..............11......^^^....................",
".............................................",
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void zerg_main(void)
{   tool_open  = zerg_open;
    tool_loop  = zerg_loop;
    tool_save  = zerg_save;
    tool_close = zerg_close;
    tool_exit  = zerg_exit;

    if (loaded != FUNC_ZERG && !zerg_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_ZERG;

    make_speedbar_list(GID_ZERG_SB1);
    load_fimage(FUNC_ZERG);
    load_aiss_images(10, 10);
    zerg_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_ZERG_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            AddToolbar(GID_ZERG_SB1),
            AddHLayout,
                AddSpace,
                AddFImage(FUNC_ZERG),
                CHILD_WeightedWidth,                       0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                AddVLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_Label,                          "General",
                    AddSpace,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_ST1] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_ZERG_ST1,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   name,
                        STRINGA_MaxChars,                  8 + 1,
                    StringEnd,
                    Label("Name:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_IN8] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_ZERG_IN8,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   1,
                        INTEGER_Maximum,                   6,
                        INTEGER_Number,                    level,
                        INTEGER_MinVisible,                1 + 1,
                    IntegerEnd,
                    Label("Level:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_IN9] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_ZERG_IN9,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   75,
                        INTEGER_Number,                    str,
                        INTEGER_MinVisible,                2 + 1,
                    IntegerEnd,
                    Label("Strength/Agility:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_IN10] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_ZERG_IN10,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   75,
                        INTEGER_Number,                    wis,
                        INTEGER_MinVisible,                2 + 1,
                    IntegerEnd,
                    Label("Wisdom:"),
                    CHILD_WeightedHeight,                  0,
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_ZERG_IN3] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ZERG_IN3,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                curhp,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ZERG_IN4] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ZERG_IN4,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                maxhp,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("of"),
                    LayoutEnd,
                    Label("Hit Points:"),
                    CHILD_WeightedHeight,                  0,
                    AddHLayout,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_ZERG_IN6] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ZERG_IN6,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                curmp,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                   gadgets[GID_ZERG_IN7] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_ZERG_IN7,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                maxmp,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("of"),
                    LayoutEnd,
                    Label("Magic Points:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_ZERG_IN1,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   65535,
                        INTEGER_Number,                    gp,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    Label("Gold Pieces:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_ZERG_IN2,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   65535,
                        INTEGER_Number,                    xp,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    Label("Experience Points:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_IN5] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_ZERG_IN5,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   65535,
                        INTEGER_Number,                    bodycount,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    Label("Body Count:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_IN11] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_ZERG_IN11,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   0x7FFFFFFF,
                        INTEGER_Number,                    turn,
                        INTEGER_MinVisible,                13 + 1,
                    IntegerEnd,
                    Label("Turn:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_ZERG_CH1,
                        CHOOSER_LabelArray,                &ArmourOptions,
                    PopUpEnd,
                    Label("Armour:"),
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_CH2] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_ZERG_CH2,
                        CHOOSER_LabelArray,                &WeaponOptions,
                    PopUpEnd,
                    Label("Weapon:"),
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,                       100,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_Label,                          "Location",
                    AddSpace,
                    AddHLayout,
                        AddSpace,
                        LAYOUT_AddChild,                   gadgets[GID_ZERG_SP1] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                         GID_ZERG_SP1,
                            SPACE_MinWidth,                SCALEDWIDTH,
                            SPACE_MinHeight,               SCALEDHEIGHT,
                            SPACE_BevelStyle,              BVS_FIELD,
                            SPACE_Transparent,             TRUE,
                        SpaceEnd,
                        CHILD_WeightedWidth,               0,
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    LAYOUT_AddChild,                       gadgets[GID_ZERG_ST2] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_ZERG_ST2,
                        GA_ReadOnly,                       TRUE,
                        STRINGA_TextVal,                   "-",
                        STRINGA_MaxChars,                  11 + 1,
                        STRINGA_MinVisible,                11 + stringextra,
                    StringEnd,
                    Label("Contents:"),
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
            MaximizeButton(GID_ZERG_BU1, "Maximize Character"),
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_ZERG_SB1);

    setup_bm(0, SCALEDWIDTH, SCALEDHEIGHT, MainWindowPtr);

    // zerg_drawmap();
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_ZERG_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ZERG_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void zerg_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_ZERG_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
}   }

EXPORT FLAG zerg_open(FLAG loadas)
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
    (   page != FUNC_ZERG
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
    zerg_drawmap();
}

MODULE void eithergadgets(void)
{   either_st(GID_ZERG_ST1,   name      );
    either_in(GID_ZERG_IN1,  &gp        );
    either_in(GID_ZERG_IN2,  &xp        );
    either_in(GID_ZERG_IN3,  &curhp     );
    either_in(GID_ZERG_IN4,  &maxhp     );
    either_in(GID_ZERG_IN5,  &bodycount );
    either_in(GID_ZERG_IN6,  &curmp     );
    either_in(GID_ZERG_IN7,  &maxmp     );
    either_in(GID_ZERG_IN8,  &level     );
    either_in(GID_ZERG_IN9,  &str       );
    either_in(GID_ZERG_IN10, &wis       );
    either_in(GID_ZERG_IN11, &turn      );
    either_ch(GID_ZERG_CH1,  &armour    );
    either_ch(GID_ZERG_CH2,  &weapon    );
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   offset = 0;
    if (serializemode == SERIALIZE_READ)
    {   zstrncpy(name, (char*) &IOBuffer[offset], 8); //   0..  8
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        zstrncpy((char*) &IOBuffer[offset], name, 8); //   0..  8
    }
    offset =  13; serialize1((ULONG*) &location_x);
    offset =  17; serialize1((ULONG*) &location_y);
    offset =  21; serialize1(&level);
    offset =  41; serialize1(&str);
    offset =  45; serialize1(&wis);
    offset =  57; serialize1(&curmp);
    offset =  61; serialize1(&maxmp);
    offset =  65; serialize1(&curhp);
    offset =  69; serialize1(&maxhp);
    offset =  72; serialize2ulong(&xp);               //  72.. 73
    offset =  76; serialize2ulong(&gp);               //  76.. 77
    offset =  81; serialize1(&armour);
    offset =  85; serialize1(&weapon);
    offset =  88; serialize2ulong(&bodycount);        //  88.. 89
    offset = 240; serialize2ulong(&turn);             // 240..241
}

EXPORT void zerg_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?SAVE#?", "Zerg", saveas, 2026, FLAG_S, FALSE);
}

EXPORT void zerg_close(void) { ; }
EXPORT void zerg_exit(void)  { ; }

MODULE void maximize_man(void)
{   level     =     6;
    armour    =
    weapon    =     9;
    curhp     =
    maxhp     =
    curmp     =
    maxmp     =    99;
    str       =
    wis       =    75;
    gp        =
    xp        =
    bodycount = 65000;
}

EXPORT void zerg_drawmap(void)
{   int adjusted_x, adjusted_y,
        x, y;

    for (y = 0; y < MAPHEIGHT; y++)
    {   for (x = 0; x < MAPWIDTH; x++)
        {   switch (zerg_map[y][x])
            {
            case  '*':
            case  '+': drawpoint(x, y, 5);
            acase '.': drawpoint(x, y, 0);
            acase '-': drawpoint(x, y, 1);
            acase '1': drawpoint(x, y, 2);
            acase '2': drawpoint(x, y, 3);
            acase '^': drawpoint(x, y, 4);
    }   }   }

    adjusted_x = location_x + 6;
    if (adjusted_x >= MAPWIDTH)
    {   adjusted_x -= MAPWIDTH;
    }
    adjusted_y = location_y + 4;
    if (adjusted_y >= MAPHEIGHT)
    {   adjusted_y -= MAPHEIGHT;
    }

    for (x = 0; x < MAPWIDTH; x++)
    {   if (x != adjusted_x)
        {   drawpoint(x, adjusted_y, 6);
    }   }
    for (y = 0; y < MAPHEIGHT; y++)
    {   if (y != adjusted_y)
        {   drawpoint(adjusted_x, y, 6);
    }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_ZERG_SP1]->LeftEdge,
        gadgets[GID_ZERG_SP1]->TopEdge,
        gadgets[GID_ZERG_SP1]->LeftEdge + SCALEDWIDTH  - 1,
        gadgets[GID_ZERG_SP1]->TopEdge  + SCALEDHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );

    switch (zerg_map[adjusted_y][adjusted_x])
    {
    case  '*': DISCARD SetGadgetAttrs(gadgets[GID_ZERG_ST2], MainWindowPtr, NULL, STRINGA_TextVal, "A castle"    , TAG_END);
    acase '+': DISCARD SetGadgetAttrs(gadgets[GID_ZERG_ST2], MainWindowPtr, NULL, STRINGA_TextVal, "A town"      , TAG_END);
    acase '.': DISCARD SetGadgetAttrs(gadgets[GID_ZERG_ST2], MainWindowPtr, NULL, STRINGA_TextVal, "Water"       , TAG_END);
    acase '1': DISCARD SetGadgetAttrs(gadgets[GID_ZERG_ST2], MainWindowPtr, NULL, STRINGA_TextVal, "Forest"      , TAG_END);
    acase '2': DISCARD SetGadgetAttrs(gadgets[GID_ZERG_ST2], MainWindowPtr, NULL, STRINGA_TextVal, "Light brush" , TAG_END);
    acase '^': DISCARD SetGadgetAttrs(gadgets[GID_ZERG_ST2], MainWindowPtr, NULL, STRINGA_TextVal, "Mountains"   , TAG_END);
    acase '-': DISCARD SetGadgetAttrs(gadgets[GID_ZERG_ST2], MainWindowPtr, NULL, STRINGA_TextVal, "Grass"       , TAG_END);
    adefault : DISCARD SetGadgetAttrs(gadgets[GID_ZERG_ST2], MainWindowPtr, NULL, STRINGA_TextVal, "?"           , TAG_END); // should never happen
}   }

MODULE void drawpoint(int x, int y, int colour)
{   int xx, yy;

    for (yy = 0; yy < MAPSCALE; yy++)
    {   for (xx = 0; xx < MAPSCALE; xx++)
        {   *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[colour];
}   }   }

EXPORT void zerg_lmb(SWORD mousex, SWORD mousey)
{   if (!mouseisover(GID_ZERG_SP1, mousex, mousey))
    {   return;
    }

    location_x = ((mousex - gadgets[GID_ZERG_SP1]->LeftEdge) / MAPSCALE) - 6;
    if (location_x < 0)
    {   location_x += MAPWIDTH;
    }
    location_y = ((mousey - gadgets[GID_ZERG_SP1]->TopEdge ) / MAPSCALE) - 4;
    if (location_y < 0)
    {   location_y += MAPHEIGHT;
    }
    zerg_drawmap();
}

EXPORT void zerg_key(UBYTE scancode, UWORD qual)
{   int temp;

    switch (scancode)
    {
    case SCAN_LEFT:
    case SCAN_N4:
        temp = location_x + 6;
        map_leftorup(qual, MAPWIDTH, &temp, 0, NULL);
        location_x = temp - 6;

        zerg_drawmap();
    acase SCAN_RIGHT:
    case SCAN_N6:
        temp = location_x + 6;
        map_rightordown(qual, MAPWIDTH, &temp, 0, NULL);
        location_x = temp - 6;

        zerg_drawmap();
    acase SCAN_UP:
    case SCAN_N8:
    case NM_WHEEL_UP:
        temp = location_y + 4;
        map_leftorup(qual, MAPHEIGHT, &temp, 0, NULL);
        location_y = temp - 4;

        zerg_drawmap();
    acase SCAN_DOWN:
    case SCAN_N5:
    case SCAN_N2:
    case NM_WHEEL_DOWN:
        temp = location_y + 4;
        map_rightordown(qual, MAPHEIGHT, &temp, 0, NULL);
        location_y = temp - 4;

        zerg_drawmap();
    acase SCAN_N1:
        temp = location_x + 6;
        map_leftorup(qual, MAPWIDTH, &temp, 0, NULL);
        location_x = temp - 6;

        temp = location_y + 4;
        map_rightordown(qual, MAPHEIGHT, &temp, 0, NULL);
        location_y = temp - 4;

        zerg_drawmap();
    acase SCAN_N3:
        temp = location_x + 6;
        map_rightordown(qual, MAPWIDTH, &temp, 0, NULL);
        location_x = temp - 6;

        temp = location_y + 4;
        map_rightordown(qual, MAPHEIGHT, &temp, 0, NULL);
        location_y = temp - 4;

        zerg_drawmap();
    acase SCAN_N7:
        temp = location_x + 6;
        map_leftorup(qual, MAPWIDTH, &temp, 0, NULL);
        location_x = temp - 6;

        temp = location_y + 4;
        map_leftorup(qual, MAPHEIGHT, &temp, 0, NULL);
        location_y = temp - 4;

        zerg_drawmap();
    acase SCAN_N9:
        temp = location_x + 6;
        map_rightordown(qual, MAPWIDTH, &temp, 0, NULL);
        location_x = temp - 6;

        temp = location_y + 4;
        map_leftorup(qual, MAPHEIGHT, &temp, 0, NULL);
        location_y = temp - 4;

        zerg_drawmap();
}   }

EXPORT void zerg_getpens(void)
{   lockscreen();

    pens[0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xFFFFFFFF, -1); // blue
    pens[1] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x88888888, 0x00000000, -1); // dark green
    pens[2] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, -1); // yellow
    pens[3] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xFFFFFFFF, 0x00000000, -1); // light green
    pens[4] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0x88888888, -1); // grey
    pens[5] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFF, -1); // purple
    pens[6] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1); // white

    unlockscreen();
}

EXPORT void zerg_uniconify(void)
{   zerg_getpens();
    zerg_drawmap();
}

EXPORT void zerg_tick(SWORD mousex, SWORD mousey)
{   if (mouseisover(GID_ZERG_SP1, mousex, mousey))
    {   setpointer(TRUE , WinObject, MainWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
}   }

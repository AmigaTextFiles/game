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
#define GID_CE_LY1     0 // root layout
#define GID_CE_SB1     1 // toolbar
#define GID_CE_IN1     2 // population
#define GID_CE_IN2     3 // radiation
#define GID_CE_BU1     4 // maximize NATO
#define GID_CE_BU2     5 // maximize WP
#define GID_CE_BU3     6 // maximize neutrals
#define GID_CE_BU4     7 // clear radiation
#define GID_CE_IN3     8 // 1st army (there are 37 of each)
#define GID_CE_IN40   45 // 1st air
#define GID_CE_IN77   82 // 1st sup
#define GID_CE_IN114 119 // day
#define GID_CE_RA1   120 // map view
#define GID_CE_SP1   121 // map
#define GID_CE_ST1   122 // contents
#define GIDS_CE      GID_CE_ST1

#define MAPWIDTH       34
#define MAPHEIGHT      16
#define MAPSCALE        8
#define SCALEDWIDTH    (MAPWIDTH  * MAPSCALE)
#define SCALEDHEIGHT   (MAPHEIGHT * MAPSCALE)

#define YELLOW       2
#define BLUE         3
#define RED          4
#define ORANGE     255 // not a real colour

#define DEMOGRAPHIC  0
#define GEOGRAPHIC   1
#define RADIOLOGICAL 2

#define GAMEARMIES   0x27
#define EDITORARMIES   37

#define ArmGad(x) LAYOUT_AddChild, gadgets[GID_CE_IN3 + x] = (struct Gadget*) IntegerObject, \
    GA_ID,                     GID_CE_IN3 + x, \
    GA_TabCycle,               TRUE,  \
    GA_RelVerify,              TRUE,  \
    INTEGER_Minimum,           0,     \
    INTEGER_Maximum,           9,     \
    INTEGER_MinVisible,        1 + 1, \
IntegerEnd
#define AirGad(x) LAYOUT_AddChild, gadgets[GID_CE_IN40 + x] = (struct Gadget*) IntegerObject, \
    GA_ID,                     GID_CE_IN40 + x, \
    GA_TabCycle,               TRUE,  \
    GA_RelVerify,              TRUE,  \
    INTEGER_Minimum,           0,     \
    INTEGER_Maximum,           9,     \
    INTEGER_MinVisible,        1 + 1, \
IntegerEnd
#define SupGad(x) LAYOUT_AddChild, gadgets[GID_CE_IN77 + x] = (struct Gadget*) IntegerObject, \
    GA_ID,                     GID_CE_IN77 + x, \
    GA_TabCycle,               TRUE,  \
    GA_RelVerify,              TRUE,  \
    INTEGER_Minimum,           0,     \
    INTEGER_Maximum,           9,     \
    INTEGER_MinVisible,        1 + 1, \
IntegerEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void ce_drawpoint(int x, int y);
MODULE void drawarmy(int x, int y, int colour);
MODULE void drawcity(int x, int y, int colour);
MODULE void serialize_army(int whicharmy);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
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
IMPORT UBYTE*               byteptr1[MAXHEIGHT];
IMPORT __aligned UBYTE      display1[GFXINIT(MAXWIDTH, MAXHEIGHT)];

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                armies[MAPHEIGHT][MAPWIDTH],
                            day,
                            population[MAPHEIGHT][MAPWIDTH],
                            radiation[MAPHEIGHT][MAPWIDTH],
                            mapview = GEOGRAPHIC;
MODULE int                  loc_x = 16, // must be signed!
                            loc_y =  7;

MODULE const int frommap[GAMEARMIES][2] = {
  {  0,  0 }, // $00 Danish
  {  1,  1 }, // $01 Dutch 1
  {  2,  2 }, // $02 Belgian 1
  {  3,  3 }, // $03 British 1
  {  4,  4 }, // $04 German 1
  {  5,  5 }, // $05 German 2
  {  6,  6 }, // $06 German 3
  {  7,  9 }, // $07 US 5            or French 1
  {  8, 10 }, // $08 US 7            or French 2
  {  9, 11 }, // $09 French 1        or Italian 2
  { 10, 12 }, // $0A French 2        or German 4
  { 11, 13 }, // $0B Italian 2       or Italian 5
  { 12, -1 }, // $0C German 4        or unused
  { 13, 14 }, // $0D Italian 5       or 3rd Shock
  { -1, 15 }, // $0E unused          or 1st Guards Tank
  { 14, 16 }, // $0F 3rd Shock       or 3rd Guards Tank
  { 15, 17 }, // $10 1st Guards Tank or 4th Guards Tank
  { 16, 18 }, // $11 3rd Guards Tank or 8th Guards Tank
  { 17, 19 }, // $12 4th Guards Tank or 2nd Guards
  { 18, 20 }, // $13 8th Guards Tank or 8th Guards
  { 19, 21 }, // $14 2nd Guards      or 20th Guards
  { 20, 22 }, // $15 8th Guards      or 10th
  { 21, 23 }, // $16 20th Guards     or 16th
  { 22, 24 }, // $17 10th            or 21st
  { 23, 25 }, // $18 16th            or 28th
  { 24, 26 }, // $19 21st            or 41st
  { 25, 27 }, // $1A 28th            or Airborne
  { 26, 28 }, // $1B 41st            or Amphibious
  { 27, -1 }, // $1C Airborne        or unused
  { 28, 29 }, // $1D Amphibious      or Polish 1
  { 29, 30 }, // $1E Polish 1        or Polish 2
  { 30, 31 }, // $1F Polish 2        or Romanian 2
  { 31, 32 }, // $20 Romanian 2      or Romanian 3
  { 32, 33 }, // $21 Romanian 3      or Swiss
  { -1, 34 }, // $22 unused          or Austrian
  { 33, 35 }, // $23 Swiss           or Yugoslavian 1
  { 34, 36 }, // $24 Austrian        or Yugoslavian 2
  { 35, -1 }, // $25 Yugoslavian 1   or unused
  { 36, -1 }, // $26 Yugoslavian 2   or unused
};

MODULE const STRPTR ce_map[MAPHEIGHT] = { /*
 0         1         2         3  3
 0123456789012345678901234567890123 */
"---.--.......--+-.....-----------+", //  0 copenhagen, moscow
"--..---......-.....---------------", //  1
"--.----......----.----------------", //  2
"...-----...-----------------------", //  3
"...---+-..------+----+------------", //  4 london, berlin, warsaw
"..-----..-------------------------", //  5
".......--+------------------------", //  6 brussels
"....-.------+----+----------------", //  7 bonn, prague
"..------+-------------------------", //  8 paris
"...---------------+------------..-", //  9 vienna
"....-----------------+--------....", // 10 budapest
"....--------+-----------------....", // 11 zurich
"....----------------------+--.....", // 12 bucharest
"....------------.-----+------.....", // 13 belgrade
"----------------...----------.....", // 14
"--------.--...---...----+-----....", // 15 sofia
}, armyname[EDITORARMIES] = {
"Danish 1 Corps",       //  0
"Dutch 1 Corps",      
"Belgian 1 Corps",    
"British 1 Corps",    
"West German 1 Corps",
"West German 2 Corps",  //  5
"West German 3 Corps",  //  6
"US 5 Corps",           //  7
"US 7 Corps",           //  8
"French 1 Corps",       //  9
"French 2 Corps",       // 10
"Italian 2 Corps",
"West German 4 Corps",
"Italian 5 Corps",      // 13
"3rd Shock Army",       // 14
"1st Guards Tank Army", // 15
"3rd Guards Tank Army",
"4th Guards Tank Army",
"8th Guards Tank Army",
"2nd Guards Army",
"8th Guards Army",      // 20
"20th Guards Army",
"10th Army",
"16th Army",
"21st Army",
"28th Army",            // 25
"41st Army",
"1st Airborne Army",
"1st Amphibious Army",  // 28
"1st Polish Army",      // 29
"2nd Polish Army",      // 30
"2nd Romanian Army",
"3rd Romanian Army",    // 32
"Swiss Army",           // 33
"Austrian Army",
"Yugoslavian 1 Corps",  // 35
"Yugoslavian 2 Corps",  // 36
}, ViewOptions[3 + 1] =
{   "Demographic",  // 0
    "Geographic",   // 1
    "Radiological", // 2
    NULL            // 3
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   int x, y,
        arm,
        air,
        sup;
} army[EDITORARMIES];                            

#define CITIES 15
MODULE struct
{   int    x, y;
    STRPTR name;
    int    colour;
} city[CITIES] = {
{ 15,  0, "Copenhagen", BLUE   },
{ 33,  0, "Moscow"    , RED    },
{  6,  4, "London"    , BLUE   },
{ 16,  4, "Berlin"    , RED    },
{ 21,  4, "Warsaw"    , RED    },
{  9,  6, "Brussels"  , BLUE   },
{ 12,  7, "Bonn"      , BLUE   },
{ 17,  7, "Prague"    , RED    },
{  8,  8, "Paris"     , BLUE   },
{ 18,  9, "Vienna"    , YELLOW },
{ 21, 10, "Budapest"  , RED    }, 
{ 12, 11, "Zurich"    , YELLOW },
{ 26, 12, "Bucharest" , RED    },
{ 22, 13, "Belgrade"  , YELLOW },
{ 24, 15, "Sofia"     , RED    },
};

// 8. CODE ---------------------------------------------------------------

EXPORT void ce_main(void)
{   tool_open  = ce_open;
    tool_loop  = ce_loop;
    tool_save  = ce_save;
    tool_close = ce_close;
    tool_exit  = ce_exit;

    if (loaded != FUNC_CE && !ce_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_CE;

    make_speedbar_list(GID_CE_SB1);
    load_fimage(FUNC_CE);
    load_images(343, 347);
    load_aiss_images(9, 10);

    ce_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                         TRUE,
        WA_ThinSizeGadget,                                     TRUE,
        WINDOW_LockHeight,                                     TRUE,
        WINDOW_Position,                                       WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                    gadgets[GID_CE_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                 TRUE,
            LAYOUT_SpaceInner,                                 TRUE,
            AddToolbar(GID_CE_SB1),
            AddHLayout,
                AddVLayout,
                    LAYOUT_SpaceOuter,                         TRUE,
                    AddVLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "NATO Corps",
                        AddHLayout,
                            AddVLayout,
                                AddImage(343),
                                CHILD_WeightedHeight,          0,
                                AddLabel("Danish 1:"),
                                AddLabel("Dutch 1:"),
                                AddLabel("Belgian 1:"),
                                AddLabel("British 1:"),
                                AddLabel("West German 1:"),
                                AddLabel("West German 2:"),
                                AddLabel("West German 3:"),
                                AddLabel("US 5:"),
                                AddLabel("US 7:"),
                                AddLabel("French 1:"),
                                AddLabel("French 2:"),
                                AddLabel("Italian 2:"),
                                AddLabel("West German 4:"),
                                AddLabel("Italian 5:"),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Arm"),
                                ArmGad(0),
                                ArmGad(1),
                                ArmGad(2),
                                ArmGad(3),
                                ArmGad(4),
                                ArmGad(5),
                                ArmGad(6),
                                ArmGad(7),
                                ArmGad(8),
                                ArmGad(9),
                                ArmGad(10),
                                ArmGad(11),
                                ArmGad(12),
                                ArmGad(13),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Air"),
                                AirGad(0),
                                AirGad(1),
                                AirGad(2),
                                AirGad(3),
                                AirGad(4),
                                AirGad(5),
                                AirGad(6),
                                AirGad(7),
                                AirGad(8),
                                AirGad(9),
                                AirGad(10),
                                AirGad(11),
                                AirGad(12),
                                AirGad(13),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Sup"),
                                SupGad(0),
                                SupGad(1),
                                SupGad(2),
                                SupGad(3),
                                SupGad(4),
                                SupGad(5),
                                SupGad(6),
                                SupGad(7),
                                SupGad(8),
                                SupGad(9),
                                SupGad(10),
                                SupGad(11),
                                SupGad(12),
                                SupGad(13),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                        LayoutEnd,
                        MaximizeButton(GID_CE_BU1, "Maximize NATO"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "Neutral Armies/Corps",
                        AddHLayout,
                            AddVLayout,
                                AddImage(345),
                                CHILD_WeightedHeight,          0,
                                AddLabel("Swiss:"),
                                AddLabel("Austrian:"),
                                AddLabel("Yugoslavian 1:"),
                                AddLabel("Yugoslavian 2:"),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Arm"),
                                ArmGad(33),
                                ArmGad(34),
                                ArmGad(35),
                                ArmGad(36),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Air"),
                                AirGad(33),
                                AirGad(34),
                                AirGad(35),
                                AirGad(36),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Sup"),
                                SupGad(33),
                                SupGad(34),
                                SupGad(35),
                                SupGad(36),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                        LayoutEnd,
                        MaximizeButton(GID_CE_BU3, "Maximize Neutrals"),
                    LayoutEnd,
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "Map",
                        LAYOUT_AddChild,                       gadgets[GID_CE_RA1] = (struct Gadget*)
                        RadioButtonObject,
                            GA_ID,                             GID_CE_RA1,
                            GA_RelVerify,                      TRUE,
                            GA_Text,                           ViewOptions,
                            RADIOBUTTON_Selected,              mapview,
                        RadioButtonEnd,
                        CHILD_WeightedHeight,                  0,
                        LAYOUT_AddChild,                       gadgets[GID_CE_SP1] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                             GID_CE_SP1,
                            SPACE_MinWidth,                    SCALEDWIDTH,
                            SPACE_MinHeight,                   SCALEDHEIGHT,
                            SPACE_BevelStyle,                  BVS_FIELD,
                            SPACE_Transparent,                 TRUE,
                        SpaceEnd,
                        CHILD_WeightedWidth,                   0,
                        CHILD_WeightedHeight,                  0,
                        AddVLayout,
                            LAYOUT_AddChild,                   gadgets[GID_CE_ST1] = (struct Gadget*)
                            StringObject,
                                GA_ID,                         GID_CE_ST1,
                                GA_ReadOnly,                   TRUE,
                                STRINGA_TextVal,               "",
                                STRINGA_MaxChars,              34 + 1, // enough for "1st Guards Tank Army in Copenhagen"
                            StringEnd,
                            Label("Contents:"),
                            CHILD_WeightedHeight,              0,
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_CE_IN1] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_CE_IN1,
                                    GA_TabCycle,               TRUE,
                                    GA_RelVerify,              TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           127,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                AddLabel("00,000"),
                                CHILD_WeightedWidth,           0,
                            LayoutEnd,
                            Label("Population:"),
                            CHILD_WeightedHeight,              0,
                            LAYOUT_AddChild,                   gadgets[GID_CE_IN2] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_CE_IN2,
                                GA_TabCycle,                   TRUE,
                                GA_RelVerify,                  TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               127,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            Label("Radiation:"),
                            CHILD_WeightedHeight,              0,
                        LayoutEnd,
                        ClearButton(GID_CE_BU4, "Clear All Radiation"),
                        CHILD_WeightedHeight,                  0,
                    LayoutEnd,
                    AddSpace,
                    AddHLayout,
                        AddSpace,
                        AddFImage(FUNC_CE),
                        CHILD_WeightedWidth,                   0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedHeight,                      0,
                    AddSpace,
                    LAYOUT_AddChild,                           gadgets[GID_CE_IN114] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_CE_IN114,
                        GA_TabCycle,                           TRUE,
                        GA_RelVerify,                          TRUE,
                        INTEGER_Minimum,                       1,
                        INTEGER_Maximum,                       29,
                        INTEGER_MinVisible,                    2 + 1,
                    IntegerEnd,
                    Label("Day:"),
                    CHILD_WeightedHeight,                      0,
                LayoutEnd,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "Warsaw Pact Armies",
                        AddHLayout,
                            AddVLayout,
                                AddImage(344),
                                CHILD_WeightedHeight,          0,
                                AddLabel("3rd Shock:"),
                                AddLabel("1st Guards Tank:"),
                                AddLabel("3rd Guards Tank:"),
                                AddLabel("4th Guards Tank:"),
                                AddLabel("8th Guards Tank:"),
                                AddLabel("2nd Guards:"),
                                AddLabel("8th Guards:"),
                                AddLabel("20th Guards:"),
                                AddLabel("10th:"),
                                AddLabel("16th:"),
                                AddLabel("21st:"),
                                AddLabel("28th:"),
                                AddLabel("41st:"),
                                AddLabel("1st Airborne:"),
                                AddLabel("1st Amphibious:"),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Arm"),
                                ArmGad(14),
                                ArmGad(15),
                                ArmGad(16),
                                ArmGad(17),
                                ArmGad(18),
                                ArmGad(19),
                                ArmGad(20),
                                ArmGad(21),
                                ArmGad(22),
                                ArmGad(23),
                                ArmGad(24),
                                ArmGad(25),
                                ArmGad(26),
                                ArmGad(27),
                                ArmGad(28),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Air"),
                                AirGad(14),
                                AirGad(15),
                                AirGad(16),
                                AirGad(17),
                                AirGad(18),
                                AirGad(19),
                                AirGad(20),
                                AirGad(21),
                                AirGad(22),
                                AirGad(23),
                                AirGad(24),
                                AirGad(25),
                                AirGad(26),
                                AirGad(27),
                                AirGad(28),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Sup"),
                                SupGad(14),
                                SupGad(15),
                                SupGad(16),
                                SupGad(17),
                                SupGad(18),
                                SupGad(19),
                                SupGad(20),
                                SupGad(21),
                                SupGad(22),
                                SupGad(23),
                                SupGad(24),
                                SupGad(25),
                                SupGad(26),
                                SupGad(27),
                                SupGad(28),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                        LayoutEnd,
                        MaximizeButton(GID_CE_BU2, "Maximize Warsaw Pact"),
                    LayoutEnd,
                    CHILD_WeightedHeight,                      0,
                    AddSpace,
                    AddVLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "Warsaw Pact/Neutral Armies",
                        AddHLayout,
                            AddVLayout,
                                AddHLayout,
                                    AddImage(346),
                                    CHILD_WeightedWidth,       0,
                                    AddImage(347),
                                    CHILD_WeightedWidth,       0,
                                    AddSpace,
                                LayoutEnd,
                                CHILD_WeightedHeight,          0,
                                AddLabel("1st Polish:"),
                                AddLabel("2nd Polish:"),
                                AddLabel("2nd Romanian:"),
                                AddLabel("3rd Romanian:"),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Arm"),
                                ArmGad(29),
                                ArmGad(30),
                                ArmGad(31),
                                ArmGad(32),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Air"),
                                AirGad(29),
                                AirGad(30),
                                AirGad(31),
                                AirGad(32),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                AddLabel("Sup"),
                                SupGad(29),
                                SupGad(30),
                                SupGad(31),
                                SupGad(32),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                        LayoutEnd,
                    LayoutEnd,
                    CHILD_WeightedHeight,                      0,
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                     TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_CE_SB1);

    setup_bm(0, SCALEDWIDTH, SCALEDHEIGHT, MainWindowPtr);

    // ce_drawmap();
    writegadgets();
    loop();
    readgadgets();
    closewindow();
}

EXPORT void ce_loop(ULONG gid, ULONG code)
{   int   i,
          x, y;
    ULONG temp;

    switch (gid)
    {
    case GID_CE_BU1:
        readgadgets();
        for (i = 0; i <= 13; i++)
        {   army[i].arm = army[i].air = army[i].sup = 9;
        }
        if (IOBuffer[0x2128] == 0x09)
        {   army[7].arm = army[7].air = army[7].sup =
            army[8].arm = army[8].air = army[7].sup = 0;
        }
        writegadgets();
    acase GID_CE_BU2:
        readgadgets();
        for (i = 14; i <= 28; i++)
        {   army[i].arm = army[i].air = army[i].sup = 9;
        }
        if (IOBuffer[0x2128] != 0x09)
        {   for (i = 29; i <= 32; i++)
            {   army[i].arm = army[i].air = army[i].sup = 9;
        }   }
        writegadgets();
    acase GID_CE_BU3:
        readgadgets();
        if (IOBuffer[0x2128] == 0x09)
        {   for (i = 29; i <= 32; i++)
            {   army[i].arm = army[i].air = army[i].sup = 9;
        }   }
        for (i = 33; i <= 36; i++)
        {   army[i].arm = army[i].air = army[i].sup = 9;
        }
        writegadgets();
    acase GID_CE_BU4:
        readgadgets();
        for (y = 0; y < MAPHEIGHT; y++)
        {   for (x = 0; x < MAPWIDTH; x++)
            {   radiation[y][x] = 0;
        }   }
        ce_drawmap(); // writegadgets(); is not needed
    acase GID_CE_RA1:
        mapview = code;
        ce_drawmap();
    acase GID_CE_IN1:
    case GID_CE_IN2:
        readgadgets();
        ce_drawmap(); // writegadgets(); is not needed
    acase GID_CE_IN114:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_CE_IN114], (ULONG*) &temp);
        if (temp % 2 == 0)
        {   if (temp < day)
            {   temp--;
            } elif (temp > day)
            {   temp++;
        }   }
        if (temp < 1) temp = 1; elif (temp > 29) temp = 29;
        day = temp;
        DISCARD SetGadgetAttrs(gadgets[GID_CE_IN114], MainWindowPtr, NULL, INTEGER_Number, day, TAG_END);
}   }

EXPORT FLAG ce_open(FLAG loadas)
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
    (   page != FUNC_CE
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;

    either_in(GID_CE_IN114, &day);

    eithergadgets();
    ce_drawmap();

    ghost(GID_CE_IN3  + 7, (IOBuffer[0x2128] == 0x09) ? TRUE : FALSE);
    ghost(GID_CE_IN40 + 7, (IOBuffer[0x2128] == 0x09) ? TRUE : FALSE);
    ghost(GID_CE_IN77 + 7, (IOBuffer[0x2128] == 0x09) ? TRUE : FALSE);
    ghost(GID_CE_IN3  + 8, (IOBuffer[0x2128] == 0x09) ? TRUE : FALSE);
    ghost(GID_CE_IN40 + 8, (IOBuffer[0x2128] == 0x09) ? TRUE : FALSE);
    ghost(GID_CE_IN77 + 8, (IOBuffer[0x2128] == 0x09) ? TRUE : FALSE);
}

MODULE void eithergadgets(void)
{   int i;

    either_in(GID_CE_IN1,   &population[loc_y][loc_x]);
    either_in(GID_CE_IN2,   &radiation[ loc_y][loc_x]);

    for (i = 0; i < EDITORARMIES; i++)
    {   either_in(GID_CE_IN3  + i, (ULONG*) &army[i].arm);
        either_in(GID_CE_IN40 + i, (ULONG*) &army[i].air);
        either_in(GID_CE_IN77 + i, (ULONG*) &army[i].sup);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i,
        x, y;

    offset = 0;

    day = (day - 1) / 2;
    serialize1(&day);
    day = 1 + (day * 2);

    offset = 0x13F8;

    for (y = 0; y < MAPHEIGHT; y++)
    {   for (x = 0; x < MAPWIDTH; x++)
        {   serialize1(&radiation[y][x]);
    }   }

    offset = 0x1618;

    for (y = 0; y < MAPHEIGHT; y++)
    {   for (x = 0; x < MAPWIDTH; x++)
        {   serialize1(&population[y][x]);
    }   }

    offset = 0x1BC0;

    for (y = 0; y < MAPHEIGHT; y++)
    {   for (x = 0; x < MAPWIDTH; x++)
        {   serialize1(&armies[y][x]);
    }   }

    offset = 0x2080;

    if (IOBuffer[0x2128] != 0x09) // 1st..4th scenarios
    {   for (i =  0; i <= 13; i++) serialize_army(i); // NATO
        offset += 24;
        for (i = 14; i <= 32; i++) serialize_army(i); // WP
        offset += 24;
        for (i = 33; i <= 36; i++) serialize_army(i); // neutrals
    } else                        // 5th      scenario
    {   for (i =  0; i <=  6; i++) serialize_army(i); // NATO
        army[7].x = army[7].y = army[7].arm = army[7].air = army[7].sup =
        army[8].x = army[8].y = army[8].arm = army[8].air = army[8].sup = 0;
        for (i =  9; i <= 13; i++) serialize_army(i); // NATO
        offset += 24;
        for (i = 14; i <= 28; i++) serialize_army(i); // WP
        offset += 24;
        for (i = 29; i <= 36; i++) serialize_army(i); // neutrals
    }
    // offset += 24;
}

MODULE void serialize_army(int whicharmy)
{   offset++;

    serialize1((ULONG*) &army[whicharmy].x);
    serialize1((ULONG*) &army[whicharmy].y);
    serialize1((ULONG*) &army[whicharmy].arm);
    serialize1((ULONG*) &army[whicharmy].air);
    serialize1((ULONG*) &army[whicharmy].sup);

    offset += 18;
}

EXPORT void ce_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?.gam", "Conflict Europe", saveas, gamesize, FLAG_S, FALSE);
}

EXPORT void ce_close(void) { ; }
EXPORT void ce_exit(void)  { ; }

EXPORT void ce_drawmap(void)
{   STRPTR cityname;
    TEXT   contents[34 + 1]; // enough for "1st Guards Tank Army in Copenhagen"
    int    i,
           x, y;

    for (y = 0; y < MAPHEIGHT; y++)
    {   for (x = 0; x < MAPWIDTH; x++)
        {   ce_drawpoint(x, y);
            if (armies[y][x] != 255)
            {   i = frommap[armies[y][x]][(IOBuffer[0x2128] == 0x09) ? 1 : 0];
                if     (i >= 0 && i <= 14) //  0..14
                {   drawarmy(x, y, BLUE);
                } elif (          i <= 28) // 15..28
                {   drawarmy(x, y, RED);
                } elif (          i <= 32) // 29..32
                {   drawarmy(x, y, ORANGE);
                } elif (          i <= 36) // 33..36
                {   drawarmy(x, y, YELLOW);
            }   }
            else
            {   for (i = 0; i < CITIES; i++)
                {   if (x == city[i].x && y == city[i].y)
                    {   drawcity(x, y, city[i].colour);
                        break; // for speed
    }   }   }   }   }

    // cursor box
    for (x = 0; x < MAPSCALE; x++)
    {   *(byteptr1[(loc_y * MAPSCALE)               ] + (loc_x * MAPSCALE) + x           ) = pens[6];
        *(byteptr1[(loc_y * MAPSCALE) + MAPSCALE - 1] + (loc_x * MAPSCALE) + x           ) = pens[6];
    }
    for (y = 0; y < MAPSCALE; y++)
    {   *(byteptr1[(loc_y * MAPSCALE) + y           ] + (loc_x * MAPSCALE)               ) = pens[6];
        *(byteptr1[(loc_y * MAPSCALE) + y           ] + (loc_x * MAPSCALE) + MAPSCALE - 1) = pens[6];
    }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_CE_SP1]->LeftEdge,
        gadgets[GID_CE_SP1]->TopEdge,
        gadgets[GID_CE_SP1]->LeftEdge + SCALEDWIDTH  - 1,
        gadgets[GID_CE_SP1]->TopEdge  + SCALEDHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );

    cityname = NULL;
    if (ce_map[loc_y][loc_x] == '+')
    {   for (i = 0; i < CITIES; i++)
        {   if (loc_x == city[i].x && loc_y == city[i].y)
            {   cityname = city[i].name;
                break; // for speed
    }   }   }

    if (armies[loc_y][loc_x] == 255)
    {   switch (ce_map[loc_y][loc_x])
        {
        case  '+': DISCARD SetGadgetAttrs(gadgets[GID_CE_ST1], MainWindowPtr, NULL, STRINGA_TextVal, cityname, TAG_END);
        acase '-': DISCARD SetGadgetAttrs(gadgets[GID_CE_ST1], MainWindowPtr, NULL, STRINGA_TextVal, "Land"  , TAG_END);
        acase '.': DISCARD SetGadgetAttrs(gadgets[GID_CE_ST1], MainWindowPtr, NULL, STRINGA_TextVal, "Sea"   , TAG_END);
        adefault : DISCARD SetGadgetAttrs(gadgets[GID_CE_ST1], MainWindowPtr, NULL, STRINGA_TextVal, "?"     , TAG_END); // should never happen
    }   }
    else
    {   strcpy(contents, armyname[frommap[armies[loc_y][loc_x]][(IOBuffer[0x2128] == 0x09) ? 1 : 0]]);
        if (cityname)
        {   strcat(contents, " in ");
            strcat(contents, cityname);
        }
        DISCARD SetGadgetAttrs(gadgets[GID_CE_ST1], MainWindowPtr, NULL, STRINGA_TextVal, contents, TAG_END);
    }

    DISCARD SetGadgetAttrs(gadgets[GID_CE_IN1], MainWindowPtr, NULL, INTEGER_Number, population[loc_y][loc_x], TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_CE_IN2], MainWindowPtr, NULL, INTEGER_Number, radiation[ loc_y][loc_x], TAG_END); // autorefreshes
}

MODULE void ce_drawpoint(int x, int y)
{   int colour,
        xx, yy;

    switch (mapview)
    {
    case DEMOGRAPHIC:
        if   (population[y][x] ==   0) colour =  7;
        elif (population[y][x] <=   4) colour =  8;
        elif (population[y][x] <=   9) colour =  9;
        elif (population[y][x] <=  19) colour = 10;
        elif (population[y][x] <=  49) colour = 11;
        elif (population[y][x] <=  99) colour = 12;
        else                           colour = 13;
    acase RADIOLOGICAL:
        if   ( radiation[y][x] ==   0) colour =  7;
        elif ( radiation[y][x] <=   2) colour = 14;
        elif ( radiation[y][x] <=   4) colour = 15;
        elif ( radiation[y][x] <=   9) colour = 16;
        elif ( radiation[y][x] <=  19) colour = 17;
        elif ( radiation[y][x] <=  49) colour = 18;
        elif ( radiation[y][x] <=  99) colour = 19;
        else                           colour = 20;
    adefault: // ie. GEOGRAPHIC
        if   (    ce_map[y][x] == '.') colour =  0;
        else                           colour =  1;
    }

    for (yy = 0; yy < MAPSCALE; yy++)
    {   for (xx = 0; xx < MAPSCALE; xx++)
        {   *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[colour];
}   }   }

MODULE void drawarmy(int x, int y, int colour)
{   if (colour == ORANGE)
    {   colour = (IOBuffer[0x2128] == 0x09) ? YELLOW : RED;
    }            

    *(byteptr1[(y * MAPSCALE) + 1] + (x * MAPSCALE) + 1           ) = pens[colour];
    *(byteptr1[(y * MAPSCALE) + 1] + (x * MAPSCALE) + 2           ) =
    *(byteptr1[(y * MAPSCALE) + 1] + (x * MAPSCALE) + 3           ) =
    *(byteptr1[(y * MAPSCALE) + 1] + (x * MAPSCALE) + 4           ) =
    *(byteptr1[(y * MAPSCALE) + 1] + (x * MAPSCALE) + 5           ) = pens[6];

    *(byteptr1[(y * MAPSCALE) + 2] + (x * MAPSCALE) + 1           ) =
    *(byteptr1[(y * MAPSCALE) + 2] + (x * MAPSCALE) + 2           ) = pens[colour];
    *(byteptr1[(y * MAPSCALE) + 2] + (x * MAPSCALE) + 3           ) =
    *(byteptr1[(y * MAPSCALE) + 2] + (x * MAPSCALE) + 4           ) =
    *(byteptr1[(y * MAPSCALE) + 2] + (x * MAPSCALE) + 5           ) = pens[6];

    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 1           ) =
    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 2           ) =
    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 3           ) = pens[colour];
    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 4           ) =
    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 5           ) = pens[6];

    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 1           ) =
    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 2           ) =
    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 3           ) =
    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 4           ) = pens[colour];
    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 5           ) = pens[6];

    *(byteptr1[(y * MAPSCALE) + 5] + (x * MAPSCALE) + 1           ) =
    *(byteptr1[(y * MAPSCALE) + 5] + (x * MAPSCALE) + 2           ) =
    *(byteptr1[(y * MAPSCALE) + 5] + (x * MAPSCALE) + 3           ) =
    *(byteptr1[(y * MAPSCALE) + 5] + (x * MAPSCALE) + 4           ) =
    *(byteptr1[(y * MAPSCALE) + 5] + (x * MAPSCALE) + 5           ) = pens[colour];

    *(byteptr1[(y * MAPSCALE) + 6] + (x * MAPSCALE) + 2           ) =
    *(byteptr1[(y * MAPSCALE) + 6] + (x * MAPSCALE) + 3           ) =
    *(byteptr1[(y * MAPSCALE) + 6] + (x * MAPSCALE) + 4           ) =
    *(byteptr1[(y * MAPSCALE) + 6] + (x * MAPSCALE) + 5           ) =
    *(byteptr1[(y * MAPSCALE) + 6] + (x * MAPSCALE) + 6           ) =
    *(byteptr1[(y * MAPSCALE) + 5] + (x * MAPSCALE) + 6           ) =
    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 6           ) =
    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 6           ) =
    *(byteptr1[(y * MAPSCALE) + 2] + (x * MAPSCALE) + 6           ) = pens[5];
}

MODULE void drawcity(int x, int y, int colour)
{   /* if (colour == ORANGE)
    {   colour = (IOBuffer[0x2128] == 0x09) ? YELLOW : RED;
    } */

    *(byteptr1[(y * MAPSCALE) + 1] + (x * MAPSCALE) + 3           ) = pens[colour];

    *(byteptr1[(y * MAPSCALE) + 2] + (x * MAPSCALE) + 3           ) = pens[colour];

    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 1           ) =
    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 2           ) =
    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 3           ) =
    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 4           ) =
    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 5           ) = pens[colour];

    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 3           ) = pens[colour];

    *(byteptr1[(y * MAPSCALE) + 5] + (x * MAPSCALE) + 3           ) = pens[colour];

    *(byteptr1[(y * MAPSCALE) + 1] + (x * MAPSCALE) + 4           ) = pens[5];

    *(byteptr1[(y * MAPSCALE) + 2] + (x * MAPSCALE) + 4           ) = pens[5];

    *(byteptr1[(y * MAPSCALE) + 3] + (x * MAPSCALE) + 6           ) = pens[5];

    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 1           ) =
    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 2           ) =
    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 4           ) =
    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 5           ) =
    *(byteptr1[(y * MAPSCALE) + 4] + (x * MAPSCALE) + 6           ) = pens[5];

    *(byteptr1[(y * MAPSCALE) + 5] + (x * MAPSCALE) + 4           ) = pens[5];

    *(byteptr1[(y * MAPSCALE) + 6] + (x * MAPSCALE) + 3           ) =
    *(byteptr1[(y * MAPSCALE) + 6] + (x * MAPSCALE) + 4           ) = pens[5];
}

EXPORT void ce_lmb(SWORD mousex, SWORD mousey)
{   if (!mouseisover(GID_CE_SP1, mousex, mousey))
    {   return;
    }

    loc_x = ((mousex - gadgets[GID_CE_SP1]->LeftEdge) / MAPSCALE);
    if (loc_x < 0)
    {   loc_x += MAPWIDTH;
    }
    loc_y = ((mousey - gadgets[GID_CE_SP1]->TopEdge ) / MAPSCALE);
    if (loc_y < 0)
    {   loc_y += MAPHEIGHT;
    }
    ce_drawmap();
}

EXPORT void ce_key(UBYTE scancode, UWORD qual)
{   switch (scancode)
    {
    case SCAN_LEFT:
    case SCAN_N4:
        map_leftorup(   qual, MAPWIDTH , &loc_x, 0, NULL);
        ce_drawmap();
    acase SCAN_RIGHT:
    case SCAN_N6:
        map_rightordown(qual, MAPWIDTH , &loc_x, 0, NULL);
        ce_drawmap();
    acase SCAN_UP:
    case SCAN_N8:
    case NM_WHEEL_UP:
        map_leftorup(   qual, MAPHEIGHT, &loc_y, 0, NULL);
        ce_drawmap();
    acase SCAN_DOWN:
    case SCAN_N5:
    case SCAN_N2:
    case NM_WHEEL_DOWN:
        map_rightordown(qual, MAPHEIGHT, &loc_y, 0, NULL);
        ce_drawmap();
    acase SCAN_N1:
        map_leftorup(   qual, MAPWIDTH , &loc_x, 0, NULL);
        map_rightordown(qual, MAPHEIGHT, &loc_y, 0, NULL);
        ce_drawmap();
    acase SCAN_N3:
        map_rightordown(qual, MAPWIDTH , &loc_x, 0, NULL);
        map_rightordown(qual, MAPHEIGHT, &loc_y, 0, NULL);
        ce_drawmap();
    acase SCAN_N7:
        map_leftorup(   qual, MAPWIDTH , &loc_x, 0, NULL);
        map_leftorup(   qual, MAPHEIGHT, &loc_y, 0, NULL);
        ce_drawmap();
    acase SCAN_N9:
        map_rightordown(qual, MAPWIDTH , &loc_x, 0, NULL);
        map_leftorup(   qual, MAPHEIGHT, &loc_y, 0, NULL);
        ce_drawmap();
}   }

EXPORT void ce_getpens(void)
{   lockscreen();

    pens[ 0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x44444444, 0x99999999, 0xDDDDDDDD, -1); // blue
    pens[ 1] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x55555555, 0xAAAAAAAA, 0x77777777, -1); // green
    pens[ 2] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xDDDDDDDD, 0xDDDDDDDD, 0x11111111, -1); // yellow
    pens[ 3] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x22222222, 0x22222222, 0xFFFFFFFF, -1); // blue
    pens[ 4] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xAAAAAAAA, 0x22222222, 0x22222222, -1); // red
    pens[ 5] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1); // black
    pens[ 6] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1); // white

    pens[ 7] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x11111111, 0x00000000, -1); //   0
    pens[ 8] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x55555555, -1); //   1.. 4
    pens[ 9] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x77777777, -1); //   5.. 9
    pens[10] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x99999999, -1); //  10..19
    pens[11] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xBBBBBBBB, -1); //  20..49
    pens[12] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xDDDDDDDD, -1); //  50..99
    pens[13] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xFFFFFFFF, -1); // 100+

    pens[14] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x33333333, 0x00000000, 0x00000000, -1); //   1.. 2
    pens[15] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x55555555, 0x00000000, 0x00000000, -1); //   3.. 4
    pens[16] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x77777777, 0x00000000, 0x00000000, -1); //   5.. 9
    pens[17] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x99999999, 0x00000000, 0x00000000, -1); //  10..19
    pens[18] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xBBBBBBBB, 0x00000000, 0x00000000, -1); //  20..49
    pens[19] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xDDDDDDDD, 0x00000000, 0x00000000, -1); //  50..99
    pens[20] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1); // 100+

    unlockscreen();
}

EXPORT void ce_uniconify(void)
{   ce_getpens();
    ce_drawmap();
}

EXPORT void ce_tick(SWORD mousex, SWORD mousey)
{   if (mouseisover(GID_CE_SP1, mousex, mousey))
    {   setpointer(TRUE , WinObject, MainWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
}   }

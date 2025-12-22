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

// #define VERBOSE
// whether to show information about files as we load/save them

#define ITEMNAMELEN 22 // enough for "Invisibility Ointment*" (does not include NUL terminator)

#define NewItemLabel(a) \
LAYOUT_AddChild, gadgets[GID_KQ_ST4 + a] = (struct Gadget*) \
StringObject, \
    GA_ID,              GID_KQ_ST4 + a, \
    STRINGA_TextVal,    itemname[a], \
    STRINGA_MaxChars,   ITEMNAMELEN + 1, \
    STRINGA_MinVisible, ITEMNAMELEN + stringextra, \
StringEnd
// Unfortunately we can only set STRINGA_MaxChars at OM_NEW

#define NewItem(a) \
LAYOUT_AddChild,        gadgets[GID_KQ_CB4 + a] = (struct Gadget*) \
TickOrCheckBoxObject, \
    GA_ID,              GID_KQ_CB4 + a, \
    GA_RelVerify,       TRUE, \
End

#define AddLocation(x) \
LAYOUT_AddChild,        gadgets[GID_KQ_BU5 + theirs_to_ours(x) - 1] = (struct Gadget*) \
ZButtonObject, \
    GA_ID,              GID_KQ_BU5 + theirs_to_ours(x) - 1, \
    GA_RelVerify,       TRUE, \
    GA_Image,           image[firstimage[game] + theirs_to_ours(x) - 1], \
    GA_Selected,        (you == x) ? TRUE : FALSE, \
    BUTTON_FillPen,     pens[0], \
ButtonEnd, \
CHILD_MinWidth,         80 + 12, \
CHILD_MinHeight,        42 + 12, \
CHILD_WeightedWidth,    0

// main window
#define GID_KQ_LY1     0 // root layout
#define GID_KQ_SB1     1 // toolbar
#define GID_KQ_ST1     2 // name
#define GID_KQ_ST4     3 //  1st item name
#define GID_KQ_ST54   53 // 51st item name
#define GID_KQ_ST55   54 // character name
#define GID_KQ_CB1    55 // sound
#define GID_KQ_CB2    56 // Valanice
#define GID_KQ_CB3    57 // Manannan
#define GID_KQ_CB4    58 //  1st item
#define GID_KQ_CB52  108 // 51st item
#define GID_KQ_CB53  109 // elevator
#define GID_KQ_CH1   110 // game
#define GID_KQ_CH2   111 // platform
#define GID_KQ_CH3   112 // speed
#define GID_KQ_CH4   113 // uniform
#define GID_KQ_IN1   114 // X
#define GID_KQ_IN2   115 // Y
#define GID_KQ_IN3   116 // current score
#define GID_KQ_IN4   117 // maximum score
#define GID_KQ_IN5   118 // days
#define GID_KQ_IN6   119 // hours
#define GID_KQ_IN7   120 // minutes
#define GID_KQ_IN8   121 // seconds
#define GID_KQ_IN9   122 // money
#define GID_KQ_CL1   123 // clock
#define GID_KQ_BU1   124 // maximize
#define GID_KQ_BU2   125 // room image
#define GID_KQ_BU3   126 // room text

// location subwindow
#define GID_KQ_LY2   127
#define GID_KQ_ST2   128 // tooltip
#define GID_KQ_BU4   129 // elsewhere
#define GID_KQ_BU5   130 //  1st location
#define GID_KQ_BU97  222 // 93th location

// location subsubwindow
#define GID_KQ_LY3   223
#define GID_KQ_ST3   224 // tooltip

#define GIDS_KQ      GID_KQ_ST3

#define ITEMS         51
#define ROOMS         93

#define YOU          (-1)
#define NOWHERE        0
#define CARRIED      255

#define KQ1            0
#define KQ2            1
#define KQ3            2
#define SQ1            3
#define GAMES          4

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE FLAG serialize(void);
MODULE void eithergadgets(void);
MODULE void locationwindow(void);
MODULE void getitem(int mode);
MODULE void refreshroom(void);
MODULE int locationwindow2(void);
MODULE void teleport(void);
MODULE int ours_to_theirs(int ours);
MODULE int theirs_to_ours(int theirs);
MODULE int whichwin(int theroom);

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
IMPORT ULONG                game,
                            offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image        *aissimage[AISSIMAGES],
//                         *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT UBYTE*               byteptr1[DISPLAY1HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE];
#ifndef __MORPHOS__
    IMPORT struct ClassLibrary* ClockBase;
    IMPORT Class*               ClockClass;
    IMPORT UWORD*               MouseData;
#endif

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE FLAG                 dosmode;
MODULE UBYTE                flag[256],
                            var[256];
MODULE ULONG                chunksize[5],
                            chunkstart[5],
                            days, hours, mins, secs,
                            elevator,
                            item[ITEMS],
                            itemoffset[ITEMS],
                            itemmax[ITEMS],
                            loc_x, loc_y,
                            manannan,
                            money,
                            platform,
                            curscore, maxscore,
                            speed,
                            sound,
                            uniform,
                            valanice,
                            you, oldyou;
MODULE TEXT                 charname[18 + 1],
                            itemname[ITEMS][ITEMNAMELEN + 1],
                            name[30 + 1],
                            roomstring[40 + 1];
MODULE int                  items[     GAMES] = {   0,  35,  51,    0 }, // set later for KQ1 & SQ1
                            over,
                            roomimage,
                            whichitem;
MODULE const UBYTE          view[5]           = { 1, 0, 166, 169, 187 };
MODULE const int            firstimage[GAMES] = { 819, 899, 992, 1071 },
                            maxscores[ GAMES] = { 158, 185, 210,  202 },
                            rooms[     GAMES] = {  80,  93,  79,   70 };
MODULE struct Window*       SubSubWindowPtr = NULL;
MODULE struct List          UniformList;

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  RYK. .... .... ....    . = Transparent (%00)
    RRYK .... .... ....    R = Red         (%01) ($D22)
    RRRY K... .... ....    K = Black       (%10) ($000)
    RRRR YK.. .... ....    Y = Yellow/bone (%11) ($FCA)
    RRRR RYK. .... ....
    RRRR RRYK .... ....
    R.RR YK.. .... ....
    ...R YK.. .... ....
    ...R RYK. .... ....
    .... RYK. .... ....
    .... RRYK .... ....
    .... .... .... ....
    .... .... .... ....
    .... .... .... ....
    .... .... .... ....
    .... .... .... ....

          Plane 0                Plane 1
    RY.. .... .... ....    .YK. .... .... ....
    RRY. .... .... ....    ..YK .... .... ....
    RRRY .... .... ....    ...Y K... .... ....
    RRRR Y... .... ....    .... YK.. .... ....
    RRRR RY.. .... ....    .... .YK. .... ....
    RRRR RRY. .... ....    .... ..YK .... ....
    R.RR Y... .... ....    .... YK.. .... ....
    ...R Y... .... ....    .... YK.. .... ....
    ...R RY.. .... ....    .... .YK. .... ....
    .... RY.. .... ....    .... .YK. .... ....
    .... RRY. .... ....    .... ..YK .... ....
    .... .... .... ....    .... .... .... ....
    .... .... .... ....    .... .... .... ....
    .... .... .... ....    .... .... .... ....
    .... .... .... ....    .... .... .... ....
    .... .... .... ....    .... .... .... ....
      blacK & Yellow           Red & Yellow

    Plane 0 Plane 1 */
    0xC000, 0x6000,
    0xE000, 0x3000,
    0xF000, 0x1800,
    0xF800, 0x0C00,
    0xFC00, 0x0600,
    0xFE00, 0x0300,
    0xB800, 0x0C00,
    0x1800, 0x0C00,
    0x1C00, 0x0600,
    0x0C00, 0x0600,
    0x0E00, 0x0300,
    0x0000, 0x0000,
    0x0080, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,

    0x0000, 0x0000, // reserved
};
#endif

MODULE const STRPTR GameOptions[GAMES + 1] =
{ "King's Quest 1",
  "King's Quest 2",
  "King's Quest 3",
  "Space Quest 1",
  NULL
}, PlatformOptions[9 + 1] =
{ "IBM PC",
  "IBM PCjr",
  "Tandy 1000",
  "Apple ][",
  "Atari ST",
  "Amiga",
  "Apple Macintosh",
  "Apple ][GS",
  "IBM PS/2",
  NULL
}, SpeedOptions[5 + 1] =
{ "0",
  "1",
  "2 (normal)",
  "3",
  "4 (slow)",
  NULL
}, UniformOptions[5 + 1] =
{ "Casual",
  "Excursion",
  "Excursion + jetpack",
  "Sarien w/ helmet",
  "Sarien w/o helmet",
  NULL
}, LocationName[GAMES][ROOMS + 1] = {
{ "Nowhere",
  "Castle #1",
  "Castle #2",
  "Rock",
  "Lake #4",
  "Lake #5",
  "Log stump",
  "Lake #7",
  "Flowers #8",
  "Fairy godmother",
  "Goat paddock #10",
  "Goat paddock #11",
  "Well",
  "Wolf",
  "Oak tree",
  "Carrot patch #15",
  "Carrot patch #16",
  "Lake #17",
  "Elf",
  "Building",
  "Lake #20",
  "Witch",
  "Cave #22",
  "Lake #23",
  "Clovers",
  "Troll bridge #25",
  "Lake #26",
  "Field #27",
  "Witch's house",
  "Sorcerer",
  "Walnut tree",
  "Bowl",
  "Trees",
  "Lake #33",
  "Beach",
  "Dwarf",
  "Dwarf rock",
  "Swamp lake",
  "Flowers #38",
  "Troll bridge #39",
  "Gnome",
  "Troll bridge #41",
  "Bridge",
  "Lake #43",
  "Woodcutter's cottage #44",
  "Woodcutter's cottage #45",
  "Ogre",
  "Stream",
  "Hole in ground",
  "In well",
  "Cave #50",
  "Cave #51",
  "Underwater",
  "Throne room #53",
  "Hall #54",
  "Hall #55",
  "Clouds #56",
  "Field #57",
  "Giant",
  "Cave #59",
  "Field #60",
  "Field #61",
  "Tree",
  "Up oak tree",
  "Clouds #64",
  "In witch's house",
  "Stairs #66",
  "Stairs #67",
  "Stairs #68",
  "Stairs #69",
  "Bottom of beanstalk",
  "Middle of beanstalk",
  "Top of beanstalk",
  "Cave #73",
  "Cave #74",
  "Cave #75",
  "Cave #76",
  "Throne room #77",
  "Cave #78",
  "In woodcutter's cottage",
  "Sky",
},
{ "Nowhere",
  "Beach #1",
  "LRRH",
  "Cottage",
  "Field #4",
  "Church #5",
  "Church #6",
  "Chasm #7",
  "Beach #8",
  "Lake #9",
  "Poison lake #10",
  "Poison lake #11",
  "Poison lake #12",
  "Brooch",
  "Lake #14",
  "Mermaid",
  "Trees",
  "Poison lake #17",
  "Ghosts",
  "Poison lake #19",
  "Antique shop #20",
  "Antique shop #21",
  "Shell",
  "Stake",
  "Poison lake #24",
  "Bramble",
  "Poison lake #26",
  "Field #27",
  "Cliff",
  "Beach #29",
  "Sign",
  "Poison lake #31",
  "Castle",
  "Poison lake #33",
  "Lake #34",
  "Chasm #35",
  "Trident",
  "Lake #37",
  "Necklace",
  "Field #39",
  "Mallet",
  "Chasm #41",
  "Door",
  "Beach #43",
  "Witch's cave",
  "Field #45",
  "Dwarf's house",
  "Field #47",
  "Bridge",
  "Chasm #49",
  "Ocean #50",
  "Neptune",
  "Underwater #52",
  "Underwater #53",
  "Underwater #54",
  "Mountaintop",
  "Viper",
  "Hole",
  "Gold key",
  "Candle",
  "Spiral stairs #60",
  "Lobby",
  "Tiara",
  "Spiral stairs #63",
  "Ham",
  "Stairs #65",
  "Basement",
  "Coffin",
  "In antique shop",
  "In witch's cave",
  "In Grandma's house",
  "In church",
  "In tree #72",
  "In tree #73",
  "In tree #74",
  "Fish net",
  "Ocean #76",
  "Island #77",
  "Amulet",
  "Island #79",
  "Beach #80",
  "Ocean #81",
  "Island #82",
  "Tower",
  "Island #84",
  "Beach #85",
  "Ocean #86",
  "Island #87",
  "Island #88",
  "Island #89",
  "Valanice",
  "Lion",
  "Stairs #92",
  "Stairs #93",
},
{ "Nowhere",
  "Attic",
  "Manannan's bedroom",
  "Hallway",
  "Gwydion's bedroom",
  "Study",
  "Kitchen",
  "Entry room",
  "Dining room",
  "Stairs #9",
  "Laboratory",
  "Snake skin",
  "Ruins #12",
  "Eagle",
  "Cave #14",
  "Beach #15",
  "Desert #16",
  "Forest #17",
  "Path #18",
  "Stream",
  "Beach #20",
  "Cactus",
  "Walnut tree",
  "Path #23",
  "Town",
  "Dock #25",
  "Desert #26",
  "Forest #27",
  "Bears' house",
  "Mistletoe",
  "Beach #30",
  "Ocean",
  "Desert #32",
  "Path #33",
  "Outside Manannan's house",
  "Inside tree",
  "Oracle's cave",
  "Bandit's hideout",
  "In bandits' hideout",
  "In store",
  "In bar",
  "Downstairs in bears' house",
  "Upstairs in bears' house", // #42
// gap here (#43..#47)
  "Beach #48",
  "Chest",
  "Mountain path #50",
  "Mountain path #51",
  "Forest path",
  "Waterfall",
  "Snow peak #54",
  "Snow peak #55",
  "Snow peak #56",
  "Cave maze",
  "Mountain path #58",
  "Mountain path #59",
  "Abominable snowman",
  "Ruins #61",
  "Stairs #62",
  "Stairs #63",
  "Stairs #64",
  "Clouds",
  "Dragon",
  "Cave #67",
  "Well",
  "Gnome", // #69
// gap here (#70)
  "Castle #71",
  "Castle #72",
  "Hall",
  "Throne room",
  "Dock #75",
  "Dock #76",
// gap here (#77)
  "Ship #78",
  "Ship #79",
  "Ship #80",
  "Ship #81",
  "Ship #82",
  "Ship #83",
  "Ship #84",
  "Ship #85",
  "Ship #86",
}, { // SQ1
  "Nowhere",
  "Arcada #1",
  "Arcada #2",
  "Arcada #3",
  "Arcada #4",
  "Arcada #5",
  "Arcada #6",
  "Arcada #7",
  "Arcada #8",
  "Arcada #9",
  "Arcada shuttle #10",
  "Arcada #11",
  "Near Kerona #12",
  "Near Kerona #13",
  "Arcada shuttle #14",
  "Kerona #15",
  "Kerona #16",
  "Kerona #17",
  "Kerona #18",
  "Kerona #19",
  "Kerona #20",
  "Kerona #21",
  "Kerona #22",
  "Kerona #23",
  "Orat's cave",
  "Cave #25",
  "Cave #26",
  "Cave #27",
  "Cave #28",
  "Cave #29",
  "Desert #30",
  "Cave #31",
  "Cave #32",
  "Desert #33",
  "Ulence Flats #34",
  "Ulence Flats #35",
  "Ulence Flats #36",
  "Ulence Flats #37",
  "Ulence Flats #38",
  "Ulence Flats #39",
// unused #40
  "Ulence Flats shuttle",
  "In space",
  "Near Deltaur #43",
// unused #44
  "Near Deltaur #45",
  "Near Deltaur #46",
  "Deltaur #47",
  "Deltaur #48",
  "Deltaur #49",
  "Deltaur #50",
  "Deltaur #51",
  "Deltaur #52",
  "Deltaur #53",
  "Deltaur #54",
  "Deltaur #55",
  "Deltaur #56",
  "Deltaur #57",
  "Deltaur #58",
  "Deltaur #59",
  "Deltaur #60",
  "Deltaur #61",
  "Deltaur #62",
// unused #63
  "Victory screen",
  "Keypad",
// unused #66
// title screen (#67)
// unused #68
// unused #69
  "Ulence Flats #70",
  "Ulence Flats #71",
// unused #72
  "Daventry",
// unused #74
  "Slot machine",
// unused #76
// kaboom (#77)
// unused #78
// unused #79
  "Arcada #80",
  "Desert #81",
  "Desert #82",
  "Kerona #83",
} };

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void kq_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        NewList(&UniformList);
    }

    tool_open      = kq_open;
    tool_loop      = kq_loop;
    tool_save      = kq_save;
    tool_close     = kq_close;
    tool_exit      = kq_exit;
    tool_subgadget = kq_subgadget;

    if (loaded != FUNC_KQ && !kq_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_KQ;

    refreshroom();

    ch_load_images(1141, 1145, UniformOptions, &UniformList);
    make_speedbar_list(GID_KQ_SB1);
    load_aiss_images(10, 10);
    load_aiss_images(82, 82);
    kq_getpens();
    make_seconds_clock(GID_KQ_CL1); // now that we have clock pens

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_KQ_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            AddHLayout,
                AddToolbar(GID_KQ_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddVLayout,
                    LAYOUT_AddChild,                       gadgets[GID_KQ_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_KQ_CH1,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    LAYOUT_AddChild,                       gadgets[GID_KQ_CH2] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_KQ_CH2,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &PlatformOptions,
                    ChooserEnd,
                    Label("Platform:"),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                CHILD_WeightedHeight,                      0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
                MaximizeButton(GID_KQ_BU1, "Maximize Game"),
                CHILD_WeightedWidth,                       0,
                CHILD_WeightedHeight,                      0,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_Label,                              "General",
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_KQ_ST1] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_KQ_ST1,
                        GA_RelVerify,                      TRUE,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   name,
                        STRINGA_MaxChars,                  30 + 1,
                        STRINGA_MinVisible,                30 + stringextra,
                    StringEnd,
                    AddLabel("Character name:"),
                    CHILD_WeightedWidth,                   0,
                    LAYOUT_AddChild,                       gadgets[GID_KQ_ST55] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_KQ_ST55,
                        GA_RelVerify,                      TRUE,
                        GA_TabCycle,                       TRUE,
                        STRINGA_TextVal,                   charname,
                        STRINGA_MaxChars,                  18 + 1,
                        STRINGA_MinVisible,                18 + stringextra,
                    StringEnd,
                LayoutEnd,
                Label("Save name:"),
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_KQ_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_KQ_IN3,
                        GA_RelVerify,                      TRUE,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Number,                    curscore,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   255,
                    IntegerEnd,
                    AddLabel("of"),
                    LAYOUT_AddChild,                       gadgets[GID_KQ_IN4] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_KQ_IN4,
                        GA_RelVerify,                      TRUE,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Number,                    maxscore,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   255,
                    IntegerEnd,
                LayoutEnd,
                Label("Score:"),
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    AddVLayout,
                        AddSpace,
                        LAYOUT_AddChild,                   gadgets[GID_KQ_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_KQ_IN5,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Number,                days,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               255,
                        IntegerEnd,
                        Label("Day:"),
                        CHILD_WeightedHeight,              0,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_KQ_IN6] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_KQ_IN6,
                                GA_RelVerify,              TRUE,
                                GA_TabCycle,               TRUE,
                                INTEGER_Number,            hours,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           23,
                            IntegerEnd,
                            AddLabel(":"),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_KQ_IN7] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_KQ_IN7,
                                GA_RelVerify,              TRUE,
                                GA_TabCycle,               TRUE,
                                INTEGER_Number,            mins,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           59,
                            IntegerEnd,
                            AddLabel(":"),
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_KQ_IN8] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_KQ_IN8,
                                GA_RelVerify,              TRUE,
                                GA_TabCycle,               TRUE,
                                INTEGER_Number,            secs,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           59,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Time:"),
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
#ifndef __MORPHOS__
                    ClockBase ? LAYOUT_AddChild      : TAG_IGNORE, gadgets[GID_KQ_CL1],
                    ClockBase ? CHILD_MinWidth       : TAG_IGNORE,  64,
                    ClockBase ? CHILD_MinHeight      : TAG_IGNORE,  64,
                    ClockBase ? CHILD_WeightedHeight : TAG_IGNORE, 100,
                    ClockBase ? CHILD_WeightedWidth  : TAG_IGNORE, 100,
#endif
                    AddVLayout,
                        AddSpace,
                        LAYOUT_AddChild,                   gadgets[GID_KQ_IN9] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_KQ_IN9,
                            GA_RelVerify,                  TRUE,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               255,
                        IntegerEnd,
                        Label("Money:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_KQ_CH3] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_KQ_CH3,
                            CHOOSER_LabelArray,            &SpeedOptions,
                        ChooserEnd,
                        Label("Speed:"),
                        CHILD_WeightedHeight,              0,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddImage,
                            LabelObject,
                                LABEL_Image,               aissimage[82],
                                CHILD_NoDispose,           TRUE,
                                LABEL_DrawInfo,            DrawInfoPtr,
                            LabelEnd,
                            LAYOUT_AddChild,               gadgets[GID_KQ_CB1] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                GA_ID,                     GID_KQ_CB1,
                                GA_Text,                   "Sound?",
                            End,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                LayoutEnd,
                Label(""),
                AddHLayout,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_KQ_IN1] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_KQ_IN1,
                                GA_RelVerify,              TRUE,
                                GA_TabCycle,               TRUE,
                                INTEGER_Number,            loc_x,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           159,
                            IntegerEnd,
                            AddLabel("Y:"),
                            LAYOUT_AddChild,               gadgets[GID_KQ_IN2] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_KQ_IN2,
                                GA_RelVerify,              TRUE,
                                GA_TabCycle,               TRUE,
                                INTEGER_Number,            loc_y,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           167,
                            IntegerEnd,
                        LayoutEnd,
                        Label("X:"),
                        CHILD_WeightedHeight,              0,
                        AddHLayout,
                            LAYOUT_AddChild,               gadgets[GID_KQ_BU2] = (struct Gadget*)
                            ZButtonObject,
                                GA_ID,                     GID_KQ_BU2,
                                GA_RelVerify,              TRUE,
                                GA_Image,                  image[roomimage],
                            ButtonEnd,
                            CHILD_WeightedWidth,           0,
                            LAYOUT_AddChild,               gadgets[GID_KQ_BU3] = (struct Gadget*)
                            ZButtonObject,
                                GA_ID,                     GID_KQ_BU3,
                                GA_RelVerify,              TRUE,
                                GA_Text,                   roomstring,
                            ButtonEnd,
                        LayoutEnd,
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_SpaceOuter,                 TRUE,
                        AddSpace,
                        LAYOUT_AddChild,                   gadgets[GID_KQ_CH4] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_KQ_CH4,
                            GA_RelVerify,                  TRUE,
                            CHOOSER_Labels,                &UniformList,
                        ChooserEnd,
                        Label("Uniform:"),
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                LayoutEnd,
                Label("Location:"),
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    LAYOUT_AddChild,                       gadgets[GID_KQ_CB2] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_KQ_CB2,
                        GA_Text,                           "Valanice is in tower?",
                    End,
                    LAYOUT_AddChild,                       gadgets[GID_KQ_CB3] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_KQ_CB3,
                        GA_Text,                           "Manannan is asleep?",
                        GA_RelVerify,                      TRUE,
                    End,
                    LAYOUT_AddChild,                       gadgets[GID_KQ_CB53] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                             GID_KQ_CB53,
                        GA_Text,                           "Elevator is repaired?",
                        GA_RelVerify,                      TRUE,
                    End,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
            LayoutEnd,
            AddHLayout,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_Label,                              "Items",
                AddVLayout,
                    NewItem( 0),
                    NewItem( 3),
                    NewItem( 6),
                    NewItem( 9),
                    NewItem(12),
                    NewItem(15),
                    NewItem(18),
                    NewItem(21),
                    NewItem(24),
                    NewItem(27),
                    NewItem(30),
                    NewItem(33),
                    NewItem(36),
                    NewItem(39),
                    NewItem(42),
                    NewItem(45),
                    NewItem(48),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    NewItemLabel( 0),
                    NewItemLabel( 3),
                    NewItemLabel( 6),
                    NewItemLabel( 9),
                    NewItemLabel(12),
                    NewItemLabel(15),
                    NewItemLabel(18),
                    NewItemLabel(21),
                    NewItemLabel(24),
                    NewItemLabel(27),
                    NewItemLabel(30),
                    NewItemLabel(33),
                    NewItemLabel(36),
                    NewItemLabel(39),
                    NewItemLabel(42),
                    NewItemLabel(45),
                    NewItemLabel(48),
                LayoutEnd,
                AddVLayout,
                    NewItem( 1),
                    NewItem( 4),
                    NewItem( 7),
                    NewItem(10),
                    NewItem(13),
                    NewItem(16),
                    NewItem(19),
                    NewItem(22),
                    NewItem(25),
                    NewItem(28),
                    NewItem(31),
                    NewItem(34),
                    NewItem(37),
                    NewItem(40),
                    NewItem(43),
                    NewItem(46),
                    NewItem(49),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    NewItemLabel( 1),
                    NewItemLabel( 4),
                    NewItemLabel( 7),
                    NewItemLabel(10),
                    NewItemLabel(13),
                    NewItemLabel(16),
                    NewItemLabel(19),
                    NewItemLabel(22),
                    NewItemLabel(25),
                    NewItemLabel(28),
                    NewItemLabel(31),
                    NewItemLabel(34),
                    NewItemLabel(37),
                    NewItemLabel(40),
                    NewItemLabel(43),
                    NewItemLabel(46),
                    NewItemLabel(49),
                LayoutEnd,
                AddVLayout,
                    NewItem( 2),
                    NewItem( 5),
                    NewItem( 8),
                    NewItem(11),
                    NewItem(14),
                    NewItem(17),
                    NewItem(20),
                    NewItem(23),
                    NewItem(26),
                    NewItem(29),
                    NewItem(32),
                    NewItem(35),
                    NewItem(38),
                    NewItem(41),
                    NewItem(44),
                    NewItem(47),
                    NewItem(50),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    NewItemLabel( 2),
                    NewItemLabel( 5),
                    NewItemLabel( 8),
                    NewItemLabel(11),
                    NewItemLabel(14),
                    NewItemLabel(17),
                    NewItemLabel(20),
                    NewItemLabel(23),
                    NewItemLabel(26),
                    NewItemLabel(29),
                    NewItemLabel(32),
                    NewItemLabel(35),
                    NewItemLabel(38),
                    NewItemLabel(41),
                    NewItemLabel(44),
                    NewItemLabel(47),
                    NewItemLabel(50),
                LayoutEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();

    openwindow(GID_KQ_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_KQ_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_KQ_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void kq_loop(ULONG gid, UNUSED ULONG code)
{   ULONG temp;

    switch (gid)
    {
    case GID_KQ_ST1:
        readgadgets();
        writegadgets();
    acase GID_KQ_BU1:
        readgadgets();
        for (whichitem = 0; whichitem < items[game]; whichitem++)
        {   getitem(1);
        }
        if (maxscore < (ULONG) maxscores[game])
        {   maxscore = maxscores[game];
        }
        curscore = maxscore;
        switch (game)
        {
        case KQ2:
            valanice = TRUE;
        acase KQ3:
            manannan = TRUE;
            if (money < 12)
            {   money = 12;
            }
        acase SQ1:
            elevator = TRUE;
            var[144] = var[145] = 1;
            uniform = 3;
            var[16]                      = // ego view
         // IOBuffer[chunkstart[1] + 11] = // this fucks it
            IOBuffer[chunkstart[3] + 37] = view[uniform];
            if (money < 250)
            {   money = 250;
        }   }
        writegadgets();
    acase GID_KQ_BU2:
    case GID_KQ_BU3:
        locationwindow();
    acase GID_KQ_IN6:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_KQ_IN6], (ULONG*) &hours);
#ifndef __MORPHOS__
        if (ClockBase)
        {   SetGadgetAttrs(gadgets[GID_KQ_CL1], MainWindowPtr, NULL, CLOCKGA_Time, (hours * 3600) + (mins * 60) + secs, TAG_END); // autorefreshes
        }
#endif
    acase GID_KQ_IN7:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_KQ_IN7], (ULONG*) &mins);
#ifndef __MORPHOS__
        if (ClockBase)
        {   SetGadgetAttrs(gadgets[GID_KQ_CL1], MainWindowPtr, NULL, CLOCKGA_Time, (hours * 3600) + (mins * 60) + secs, TAG_END); // autorefreshes
        }
#endif
    acase GID_KQ_IN8:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_KQ_IN8], (ULONG*) &secs);
#ifndef __MORPHOS__
        if (ClockBase)
        {   SetGadgetAttrs(gadgets[GID_KQ_CL1], MainWindowPtr, NULL, CLOCKGA_Time, (hours * 3600) + (mins * 60) + secs, TAG_END); // autorefreshes
        }
    acase GID_KQ_CL1:
        // assert(ClockBase);
        DISCARD GetAttr(CLOCKGA_Time, (Object*) gadgets[GID_KQ_CL1], (ULONG*) &secs);
        hours =  secs / 3600      ; // seconds in hour
        mins  = (secs % 3600) / 60; // seconds in minute
        secs  =  secs %   60      ;
        DISCARD SetGadgetAttrs(gadgets[GID_KQ_IN6], MainWindowPtr, NULL, INTEGER_Number, hours, TAG_END); // autorefreshes
        DISCARD SetGadgetAttrs(gadgets[GID_KQ_IN7], MainWindowPtr, NULL, INTEGER_Number, mins,  TAG_END); // autorefreshes
        DISCARD SetGadgetAttrs(gadgets[GID_KQ_IN8], MainWindowPtr, NULL, INTEGER_Number, secs,  TAG_END); // autorefreshes
#endif
    acase GID_KQ_CB3:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_KQ_CB3], &temp);
        if (temp)
        {   var[ 83] =
            var[ 84] = 255;
            var[127] = 4;
            var[128] = 7;
        } else
        {   var[127] = 1; // home, after bed
            var[128] = 0;
        }
    acase GID_KQ_CB53:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_KQ_CB53], &temp);
        if (temp)
        {   elevator = TRUE;
            var[144] = var[145] = 1;
        } else
        {   elevator = FALSE;
            var[144] = var[145] = 0;
        }
    acase GID_KQ_CH4:
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_KQ_CH4], &uniform);
            var[16]                      = // ego view
         // IOBuffer[chunkstart[1] + 11] = // this fucks it
            IOBuffer[chunkstart[3] + 37] = view[uniform];
        if (uniform == 2)
        {   readgadgets();
            whichitem = dosmode ? 8 : 9;
            getitem(1);
            writegadgets();
        }
    acase GID_KQ_IN9:
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_KQ_IN9], &money);
        if (game == SQ1)
        {   readgadgets();
            whichitem = dosmode ? 9 : 10;
            getitem(money ? 1 : 0);
            writegadgets();
        }
    adefault:
        if (gid >= GID_KQ_CB4 && (int) gid < GID_KQ_CB4 + items[game])
        {   whichitem = gid - GID_KQ_CB4;
            GetAttr(GA_Selected, (Object*) gadgets[gid], &temp);
            getitem(temp ? 1 : 0);
}   }   }

EXPORT FLAG kq_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        if (serialize())
        {   writegadgets();
            return TRUE;
        } // implied else
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_KQ
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;

    either_ch(GID_KQ_CH1, &game);
    either_ch(GID_KQ_CH2, &platform);
    either_ch(GID_KQ_CH4, &uniform);

#ifndef __MORPHOS__
    if (ClockBase)
    {   SetGadgetAttrs(gadgets[GID_KQ_CL1], MainWindowPtr, NULL, CLOCKGA_Time, (hours * 3600) + (mins * 60) + secs, TAG_END); // autorefreshes
    }
#endif
    DISCARD SetGadgetAttrs(gadgets[GID_KQ_IN6 ], MainWindowPtr, NULL, INTEGER_Number, hours, TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_KQ_IN7 ], MainWindowPtr, NULL, INTEGER_Number, mins,  TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_KQ_IN8 ], MainWindowPtr, NULL, INTEGER_Number, secs,  TAG_END); // autorefreshes

    either_cb(GID_KQ_CB3 , &manannan);
    either_cb(GID_KQ_CB53, &elevator);

    ghost(   GID_KQ_IN9 , game != KQ3 && game != SQ1);
    ghost_st(GID_KQ_ST55, game != SQ1);
    ghost_st(GID_KQ_CB2 , game != KQ2);
    ghost_st(GID_KQ_CB3 , game != KQ3 || manannan);
    ghost_st(GID_KQ_CB53, game != SQ1 || elevator);
    ghost_st(GID_KQ_CH4 , game != SQ1);

    for (i = 0; i < ITEMS; i++)
    {   ghost_st(GID_KQ_ST4 + i, i >= items[game]);
        SetGadgetAttrs(gadgets[GID_KQ_CB4 + i], MainWindowPtr, NULL, GA_Selected, (item[i] == CARRIED) ? TRUE : FALSE, GA_Disabled, ((i >= items[game]) ? TRUE : FALSE), TAG_DONE); // this needs manual refresh
        RefreshGadgets((struct Gadget*) gadgets[GID_KQ_CB4 + i], MainWindowPtr, NULL);
    }

    refreshroom();
    SetGadgetAttrs(gadgets[GID_KQ_BU2], MainWindowPtr, NULL, GA_Image, image[roomimage], TAG_DONE); // this autorefreshes
    SetGadgetAttrs(gadgets[GID_KQ_BU3], MainWindowPtr, NULL, GA_Text,  roomstring,       TAG_DONE); // this autorefreshes

    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    either_ch(GID_KQ_CH3 , &speed);
    either_st(GID_KQ_ST1 ,  name);
    either_st(GID_KQ_ST55,  charname);
    either_in(GID_KQ_IN1 , &loc_x);
    either_in(GID_KQ_IN2 , &loc_y);
    either_in(GID_KQ_IN3 , &curscore);
    either_in(GID_KQ_IN4 , &maxscore);
    either_in(GID_KQ_IN5 , &days);
    either_in(GID_KQ_IN9 , &money);
    either_cb(GID_KQ_CB1 , &sound);
    either_cb(GID_KQ_CB2 , &valanice);

    for (i = 0; i < ITEMS; i++)
    {   either_st(GID_KQ_ST4 + i, itemname[i]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE FLAG serialize(void)
{   TRANSIENT       UBYTE  t;
    TRANSIENT       int    i;
    PERSIST   const STRPTR decryptor = "Avis Durgan";

    if   (!strcmp((const char*) &IOBuffer[0x21], "KQ1")) game = KQ1;
    elif (!strcmp((const char*) &IOBuffer[0x21], "KQ2")) game = KQ2;
    elif (!strcmp((const char*) &IOBuffer[0x21], "KQ3")) game = KQ3;
    elif (!strcmp((const char*) &IOBuffer[0x21], "SQ" )) game = SQ1;
    else
    {   say("Unsupported game!", REQIMAGE_WARNING);
        return FALSE;
    }

    offset = 0;
    if (serializemode == SERIALIZE_READ)
    {   load_images(firstimage[game], firstimage[game] + rooms[game] - 1);

        zstrncpy(name, (char*) &IOBuffer[offset], 30); //  0..30

        offset = 31;
        serialize2ilong(&chunksize[0]);                    // 31
#ifdef VERBOSE
        printf("1st chunk (saveStart) at $%04X is %4d bytes.\n", (int) offset, (unsigned int) chunksize[0]);
#endif
        chunkstart[0] = offset;
        offset += chunksize[0];
        serialize2ilong(&chunksize[1]);
#ifdef VERBOSE
        printf("2nd chunk (aniObj   ) at $%04X is %4d bytes.\n", (int) offset, (unsigned int) chunksize[1]);
#endif
        chunkstart[1] = offset;
        offset += chunksize[1];
        serialize2ilong(&chunksize[2]);
#ifdef VERBOSE
        printf("3rd chunk (object   ) at $%04X is %4d bytes.\n", (int) offset, (unsigned int) chunksize[2]);
#endif
        chunkstart[2] = offset;
        offset += chunksize[2];
        serialize2ilong(&chunksize[3]);
#ifdef VERBOSE
        printf("4th chunk (script   ) at $%04X is %4d bytes.\n", (int) offset, (unsigned int) chunksize[3]);
#endif
        chunkstart[3] = offset;
        offset += chunksize[3];
        serialize2ilong(&chunksize[4]);
#ifdef VERBOSE
        printf("5th chunk (scanOfs  ) at $%04X is %4d bytes.\n", (int) offset, (unsigned int) chunksize[4]);
#endif
        chunkstart[4] = offset;
        offset += chunksize[4];
#ifdef VERBOSE
        printf("Offset beyond file is at $%04X.\n"             , (int) offset);
#endif
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        zstrncpy((char*) &IOBuffer[offset], name, 30); //  0..30
    }

    if (chunksize[0] >= 1501)
    {   dosmode = TRUE;  // eg. 1503 for KQ2, 1505 for KQ1 & KQ3 & SQ1
        items[KQ1] = 25;
        items[SQ1] = 22;
    } else
    {   dosmode = FALSE; // eg. 1296 for KQ1, 1044 for KQ2, 756 for KQ3 & SQ1
        items[KQ1] = 28;
        items[SQ1] = 23;
    }

    // 1st chunk----------------------------------------------------------

    if (serializemode == SERIALIZE_WRITE)
    {   // var[0] and other location variables have already been set
        var[   3] = (UBYTE) curscore;
        var[   7] = (UBYTE) maxscore;
        var[  10] = (UBYTE) speed;
        var[  11] = (UBYTE) secs;
        var[  12] = (UBYTE) mins;
        var[  13] = (UBYTE) hours;
        var[  14] = (UBYTE) days;
        var[  20] = (UBYTE) platform; // not really needed as we don't allow changing it
        flag[  9] = sound ? 1 : 0;
        switch (game)
        {
        case KQ2:
            flag[ 5] = valanice ? 1 : 0;
        acase KQ3:
            var[ 63] =
            var[221] = (UBYTE) money;
            if (manannan)
            {  var[ 83] =
               var[ 84] = 255;
               var[127] = 4;
               var[128] = 7;
            }
        acase SQ1:
            var[ 81] = (UBYTE) uniform;
            offset = dosmode ? 0x254 : 0x115;
            zstrncpy((char*) &IOBuffer[offset], charname, 18);
            var[124] = (UBYTE) money;
    }   }
    if (dosmode)
    {              offset =  0x28;
    } else
    {   switch (game)
        {
        case  KQ1:
        case  KQ3:
        case  SQ1: offset = 0x1DD;
        acase KQ2: offset = 0x2F3;
    }   }

#ifdef VERBOSE
    printf("Variables are at $%X..$%X.\n", offset, offset + 255);
#endif

    for (i = 0; i < 256; i++)
    {   serialize1to1(&var[i]);                        // $1DD..$2DC
    }

#ifdef VERBOSE
    for (i = 0; i < 256; i++)
    {   if (var[i])
        {   printf("Variable #%d is %d.\n", i, var[i]);
    }   }

    printf("Flags are at $%X..$%X.\n", offset, offset +  31);
#endif

    for (i = 0; i < 32; i++)
    {   if (serializemode == SERIALIZE_WRITE)
        {   if (dosmode)
            {   t = (flag[(i * 8)    ] << 7)
                  + (flag[(i * 8) + 1] << 6)
                  + (flag[(i * 8) + 2] << 5)
                  + (flag[(i * 8) + 3] << 4)
                  + (flag[(i * 8) + 4] << 3)
                  + (flag[(i * 8) + 5] << 2)
                  + (flag[(i * 8) + 6] << 1)
                  + (flag[(i * 8) + 7]     );
/* $128: flags   0..  7
   $129: flags   8.. 15
   $12A: flags  16.. 23
   $12B: flags  24.. 31
   $12C: flags  32.. 39
   $12D: flags  40.. 47
   $12E: flags  48.. 55
   $12F: flags  56.. 63
   $130: flags  64.. 71
   $131: flags  72.. 79
   $132: flags  80.. 87
   $133: flags  88.. 95
   $134: flags  96..103
   $135: flags 104..111
   $136: flags 112..119
   $137: flags 120..127
   $138: flags 128..135
   $139: flags 136..143
   $13A: flags 144..151
   $13B: flags 152..159
    : : :
   $147: flags 248..255 */
            } else
            {   t = (flag[(i * 8) + 7] << 7)
                  + (flag[(i * 8) + 6] << 6)
                  + (flag[(i * 8) + 5] << 5)
                  + (flag[(i * 8) + 4] << 4)
                  + (flag[(i * 8) + 3] << 3)
                  + (flag[(i * 8) + 2] << 2)
                  + (flag[(i * 8) + 1] << 1)
                  + (flag[(i * 8)    ]     );
        }   }
        serialize1to1(&t);                             // $2DD..$2FC
        if (serializemode == SERIALIZE_READ)
        {   if (dosmode)
            {   flag[(i * 8)    ] = (t & 128) >> 7;
                flag[(i * 8) + 1] = (t &  64) >> 6;
                flag[(i * 8) + 2] = (t &  32) >> 5;
                flag[(i * 8) + 3] = (t &  16) >> 4;
                flag[(i * 8) + 4] = (t &   8) >> 3;
                flag[(i * 8) + 5] = (t &   4) >> 2;
                flag[(i * 8) + 6] = (t &   2) >> 1;
                flag[(i * 8) + 7] = (t &   1)     ;
            } else
            {   flag[(i * 8) + 7] = (t & 128) >> 7;
                flag[(i * 8) + 6] = (t &  64) >> 6;
                flag[(i * 8) + 5] = (t &  32) >> 5;
                flag[(i * 8) + 4] = (t &  16) >> 4;
                flag[(i * 8) + 3] = (t &   8) >> 3;
                flag[(i * 8) + 2] = (t &   4) >> 2;
                flag[(i * 8) + 1] = (t &   2) >> 1;
                flag[(i * 8)    ] = (t &   1)     ;
    }   }   }

#ifdef VERBOSE
    for (i = 0; i < 256; i++)
    {   if (flag[i])
        {   printf("Flag #%d is set.\n", i);
    }   }
#endif

    if (serializemode == SERIALIZE_READ)
    {   you       = (ULONG) var[ 0];
        curscore  = (ULONG) var[ 3];
        maxscore  = (ULONG) var[ 7];
        speed     = (ULONG) var[10];
        secs      = (ULONG) var[11];
        mins      = (ULONG) var[12];
        hours     = (ULONG) var[13];
        days      = (ULONG) var[14];
        platform  = (ULONG) var[20];
        sound     = (ULONG) flag[9];
        valanice  =
        manannan  =
        elevator  = FALSE;
        uniform   =
        money     = 0;
        switch (game)
        {
        case KQ1:
            strcpy(charname, "Graham");
        acase KQ2:
            strcpy(charname, "Graham");
            valanice = (ULONG) flag[5];
        acase KQ3:
            strcpy(charname, "Gwydion/Alexander");
            money    = (ULONG) var[63];
            if (var[83] == 255 && var[84] == 255 && var[127] == 4 && var[128] == 7)
            {   manannan = TRUE;
            }
        acase SQ1:
            if (var[144] || var[145])
            {   elevator = TRUE;
            }
            uniform = (ULONG) var[81];
            offset = dosmode ? 0x254 : 0x115;
            zstrncpy(charname, (char*) &IOBuffer[offset], 18);
            money    = (ULONG) var[124];
    }   }

    // 2nd chunk----------------------------------------------------------

    if ((game == KQ1 || game == KQ2 || game == SQ1) && dosmode)
    {   offset = chunkstart[1] + 3;
    } else
    {   offset = chunkstart[1] + 7;
    }

    serialize2ilong(&loc_x);
    serialize2ilong(&loc_y);

    // 3rd chunk----------------------------------------------------------

    offset = chunkstart[2];
    if (serializemode == SERIALIZE_READ && game == KQ2 && !dosmode) // decrypt
    {   i = 0;
        do
        {   IOBuffer[offset + i] ^= decryptor[i % 11];
            i++;
        } while (offset + i < chunkstart[2] + chunksize[2]);
    }

    switch (game)
    {
    case  KQ1: if (dosmode) offset +=   3;
    acase KQ2: if (dosmode) offset += 150;
               else         offset += 200;
    acase KQ3: if (dosmode) offset +=   3;
               else         offset +=   4;
    acase SQ1: if (dosmode) offset +=   3; // skip 1 item ("dummy")
    }

    if (serializemode == SERIALIZE_READ)
    {   for (i = 0; i < items[game]; i++)
        {   serialize2ilong(&itemoffset[i]);
            strcpy((char*) itemname[i], (const char*) &IOBuffer[chunkstart[2] + itemoffset[i]]);
            serialize1(&item[i]);
            if (!dosmode)
            {   offset++; // pad byte
            }

            switch (game)
            {
            case KQ3:
                if (i == 42)
                {   if (dosmode)
                    {   offset += 3 * 3; // skip 3 items
                    } else
                    {   offset += 3 * 4; // skip 3 items
                }   }
            acase SQ1:
                if (dosmode && i == 15)
                {   offset     +=     3; // skip 1 item ("?")
                } elif (!dosmode && i == 17)
                {   offset     +=     4; // skip 1 item ("?")
        }   }   }
        // don't combinese these loops!
        for (i = 0; i < items[game] - 1; i++)
        {   itemmax[i] = itemoffset[i + 1] - itemoffset[i];
            if ((SLONG) itemmax[i] <= 0)
            {   itemmax[i] = strlen(itemname[i]) + 1; // sometimes they have zero or negative length
        }   }
        itemmax[items[game] - 1] = strlen(itemname[items[game] - 1]) + 1;
        if (items[game] < ITEMS)
        {   for (i = items[game]; i < ITEMS; i++)
            {   itemmax[i] = 1; // just NUL terminator
                itemname[i][0] = EOS;
                item[i] = 0;
    }   }   }
    else
    {   // assert(serializemode == SERIALIZE_WRITE);

        for (i = 0; i < items[game]; i++)
        {   serialize2ilong(&itemoffset[i]);
            itemname[i][itemmax[i] - 1] = EOS;
            strcpy((char*) &IOBuffer[chunkstart[2] + itemoffset[i]], itemname[i]);
            serialize1(&item[i]);
            if (!dosmode)
            {   offset++; // pad byte
            }

            if (game == KQ3 && i == 42)
            {   if (dosmode)
                {   offset += 3 * 3; // skip 3 items
                } else
                {   offset += 3 * 4; // skip 3 items
            }   }
            elif (game == SQ1 && i == 17)
            {   if (dosmode)
                {   offset +=     3; // skip 1 item
                } else
                {   offset +=     4; // skip 1 item
    }   }   }   }

    if (serializemode == SERIALIZE_WRITE && game == KQ2 && !dosmode) // encrypt
    {   offset = chunkstart[2];
        i = 0;
        do
        {   IOBuffer[offset + i] ^= decryptor[i % 11];
            i++;
        } while (offset + i < chunkstart[2] + chunksize[2]);
    }

#ifdef VERBOSE
    for (i = 0; i < ITEMS; i++)
    {   printf("Item #%d is \"%s\". Status %d, length limit %d.\n", i, itemname[i], (int) item[i], (int) itemmax[i]);
    }
#endif

    return TRUE;
}

EXPORT void kq_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  KQ1: gamesave("kq1sg.#?", "King's Quest 1", saveas, gamesize, FLAG_S, FALSE);
    acase KQ2: gamesave("kq2sg.#?", "King's Quest 2", saveas, gamesize, FLAG_S, FALSE);
    acase KQ3: gamesave("kq3sg.#?", "King's Quest 3", saveas, gamesize, FLAG_S, FALSE);
    acase SQ1: gamesave( "sqsg.#?", "Space Quest 1" , saveas, gamesize, FLAG_S, FALSE);
    }
    writegadgets(); // so that the user sees any possible truncation of item names
}

EXPORT void kq_close(void) { ; }

EXPORT void kq_exit(void)
{   ch_clearlist(&UniformList);
}

EXPORT void kq_getpens(void)
{   getclockpens();

    lockscreen();

    pens[0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1);

    unlockscreen();
}

EXPORT void kq_uniconify(void)
{   kq_getpens();

#ifndef __MORPHOS__
    if (ClockBase)
    {   RefreshGList((struct Gadget*) gadgets[GID_KQ_CL1], MainWindowPtr, NULL, 1);
    }
#endif
}

MODULE void locationwindow(void)
{   over = -2;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    switch (game)
    {
    case KQ1:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                              "Choose Your Location (KQ1)",
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_GadgetHelp,                     TRUE,
         // WINDOW_HintInfo,                       &ts_hintinfo,
            WINDOW_UniqueID,                       "kq-1",
            WINDOW_ParentGroup,                    gadgets[GID_KQ_LY2] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                AddHLayout,
                    AddLocation(72),
                    AddLocation(56),
                    AddLocation(57),
                    AddLocation(58),
                    AddLocation(59),
                    AddLocation(69),
                    AddLocation(53),
                    AddLocation(54),
                LayoutEnd,
                AddHLayout,
                    AddLocation(71),
                    AddLocation(64),
                    AddLocation(60),
                    AddLocation(61),
                    AddLocation(62),
                    AddLocation(73),
                    AddLocation(68),
                    AddLocation(55),
                LayoutEnd,
                AddHLayout,
                    AddLocation(70),
                    AddLocation(49),
                    AddLocation(80),
                    AddLocation(76),
                    AddLocation(75),
                    AddLocation(74),
                    AddLocation(67),
                    AddLocation(63),
                LayoutEnd,
                AddHLayout,
                    AddLocation(51),
                    AddLocation(52),
                    AddLocation(78),
                    AddLocation(77),
                    AddLocation(79),
                    AddLocation(66),
                    AddLocation(65),
                    AddLocation(50),
                LayoutEnd,
                AddLabel(""),
                AddHLayout,
                    AddLocation(41),
                    AddLocation(42),
                    AddLocation(43),
                    AddLocation(44),
                    AddLocation(45),
                    AddLocation(46),
                    AddLocation(47),
                    AddLocation(48),
                LayoutEnd,
                AddHLayout,
                    AddLocation(40),
                    AddLocation(39),
                    AddLocation(38),
                    AddLocation(37),
                    AddLocation(36),
                    AddLocation(35),
                    AddLocation(34),
                    AddLocation(33),
                LayoutEnd,
                AddHLayout,
                    AddLocation(25),
                    AddLocation(26),
                    AddLocation(27),
                    AddLocation(28),
                    AddLocation(29),
                    AddLocation(30),
                    AddLocation(31),
                    AddLocation(32),
                LayoutEnd,
                AddHLayout,
                    AddLocation(24),
                    AddLocation(23),
                    AddLocation(22),
                    AddLocation(21),
                    AddLocation(20),
                    AddLocation(19),
                    AddLocation(18),
                    AddLocation(17),
                LayoutEnd,
                AddHLayout,
                    AddLocation( 9),
                    AddLocation(10),
                    AddLocation(11),
                    AddLocation(12),
                    AddLocation(13),
                    AddLocation(14),
                    AddLocation(15),
                    AddLocation(16),
                LayoutEnd,
                AddHLayout,
                    AddLocation( 8),
                    AddLocation( 7),
                    AddLocation( 6),
                    AddLocation( 5),
                    AddLocation( 4),
                    AddLocation( 3),
                    AddLocation( 2),
                    AddLocation( 1),
                LayoutEnd,
                AddLabel(""),
                LAYOUT_AddChild,                   gadgets[GID_KQ_ST2] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_KQ_ST2,
                    GA_ReadOnly,                   TRUE,
                    STRINGA_TextVal,               "-",
                StringEnd,
                CHILD_WeightedHeight,              0,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase KQ2:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                              "Choose Your Location (KQ2)",
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_GadgetHelp,                     TRUE,
         // WINDOW_HintInfo,                       &ts_hintinfo,
            WINDOW_UniqueID,                       "kq-2",
            WINDOW_ParentGroup,                    gadgets[GID_KQ_LY2] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation( 1),
                    AddLocation( 2),
                    AddLocation( 3),
                    AddLocation( 4),
                    AddLocation( 5),
                    AddLocation( 6),
                    AddLocation( 7),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation( 8),
                    AddLocation( 9),
                    AddLocation(10),
                    AddLocation(11),
                    AddLocation(12),
                    AddLocation(13),
                    AddLocation(14),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(15),
                    AddLocation(16),
                    AddLocation(17),
                    AddLocation(18),
                    AddLocation(19),
                    AddLocation(20),
                    AddLocation(21),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(22),
                    AddLocation(23),
                    AddLocation(24),
                    AddLocation(25),
                    AddLocation(26),
                    AddLocation(27),
                    AddLocation(28),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(29),
                    AddLocation(30),
                    AddLocation(31),
                    AddLocation(32),
                    AddLocation(33),
                    AddLocation(34),
                    AddLocation(35),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(36),
                    AddLocation(37),
                    AddLocation(38),
                    AddLocation(39),
                    AddLocation(40),
                    AddLocation(41),
                    AddLocation(42),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(43),
                    AddLocation(44),
                    AddLocation(45),
                    AddLocation(46),
                    AddLocation(47),
                    AddLocation(48),
                    AddLocation(49),
                LayoutEnd,
                LAYOUT_AddChild,                   gadgets[GID_KQ_BU4] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                         GID_KQ_BU4,
                    GA_RelVerify,                  TRUE,
                    GA_Text,                       "Elsewhere...",
                    GA_Selected,                   (you == NOWHERE || you >= 50) ? TRUE : FALSE,
                ButtonEnd,
                AddLabel(""),
                LAYOUT_AddChild,                   gadgets[GID_KQ_ST2] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_KQ_ST2,
                    GA_ReadOnly,                   TRUE,
                    STRINGA_TextVal,               "-",
                StringEnd,
                CHILD_WeightedHeight,              0,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase KQ3:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                              "Choose Your Location (KQ3)",
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_GadgetHelp,                     TRUE,
         // WINDOW_HintInfo,                       &ts_hintinfo,
            WINDOW_UniqueID,                       "kq-3",
            WINDOW_ParentGroup,                    gadgets[GID_KQ_LY2] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddSpace,
                    AddLocation(2),
                    AddLocation(1),
                    AddSpace,
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddSpace,
                    AddLocation(3),
                    AddLocation(4),
                    AddLocation(5),
                    AddLocation(6),
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddLocation(38),
                    AddLocation(7),
                    AddSpace,
                    AddSpace,
                    AddLocation(8),
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddLocation(37),
                    AddLocation(34),
                    AddLocation(40),
                    AddLocation(9),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddLocation(35),
                    AddLocation(33),
                    AddLocation(39),
                    AddLocation(10),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddLocation(16),
                    AddLocation(17),
                    AddLocation(18),
                    AddLocation(19),
                    AddLocation(20),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(42),
                    AddLocation(21),
                    AddLocation(22),
                    AddLocation(23),
                    AddLocation(24),
                    AddLocation(25),
                    AddLocation(75),
                    AddLocation(76),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(41),
                    AddLocation(26),
                    AddLocation(27),
                    AddLocation(28),
                    AddLocation(29),
                    AddLocation(30),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(32),
                    AddLocation(11),
                    AddLocation(12),
                    AddLocation(13),
                    AddLocation(14),
                    AddLocation(15),
                    AddLocation(31),
                    AddLocation(36),
                LayoutEnd,
                LAYOUT_AddChild,                   gadgets[GID_KQ_BU4] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                         GID_KQ_BU4,
                    GA_RelVerify,                  TRUE,
                    GA_Text,                       "Elsewhere...",
                    GA_Selected,                   (whichwin(you) == 1) ? FALSE : TRUE,
                ButtonEnd,
                AddLabel(""),
                LAYOUT_AddChild,                   gadgets[GID_KQ_ST2] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_KQ_ST2,
                    GA_ReadOnly,                   TRUE,
                    STRINGA_TextVal,               "-",
                StringEnd,
                CHILD_WeightedHeight,              0,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase SQ1:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                              "Choose Your Location (SQ1)",
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_GadgetHelp,                     TRUE,
         // WINDOW_HintInfo,                       &ts_hintinfo,
            WINDOW_UniqueID,                       "sq-1",
            WINDOW_ParentGroup,                    gadgets[GID_KQ_LY2] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddSpace,
                    AddLocation(11),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(1),
                    AddLocation(2),
                    AddLocation(3),
                    AddLocation(4),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddLocation(5),
                    AddLocation(6),
                    AddLocation(7),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(12),
                    AddLocation(10),
                    AddLocation(80),
                    AddLocation(9),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(13),
                    AddLocation(73),
                    AddLocation(8),
                    AddSpace,
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddLocation(15),
                    AddLocation(16),
                    AddLocation(17),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddLocation(82),
                    AddLocation(18),
                    AddLocation(19),
                    AddLocation(20),
                    AddLocation(24),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(14),
                    AddLocation(30),
                    AddLocation(21),
                    AddLocation(22),
                    AddLocation(23),
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddLocation(81),	
                    AddSpace,
                    AddLocation(83),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                LAYOUT_AddChild,                   gadgets[GID_KQ_BU4] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                         GID_KQ_BU4,
                    GA_RelVerify,                  TRUE,
                    GA_Text,                       "Elsewhere...",
                    GA_Selected,                   (whichwin(you) == 1) ? FALSE : TRUE,
                ButtonEnd,
                AddLabel(""),
                LAYOUT_AddChild,                   gadgets[GID_KQ_ST2] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_KQ_ST2,
                    GA_ReadOnly,                   TRUE,
                    STRINGA_TextVal,               "-",
                StringEnd,
                CHILD_WeightedHeight,              0,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
    }   }

    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubWindowPtr->Width, SubWindowPtr->Height);
#endif

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE int locationwindow2(void)
{   UWORD   code;
    ULONG   event,
            gid,
            LocalSignal,
            qual,
            result;
    int     done;
    Object* SubSubWinObject = NULL;

    over = -2;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    switch (game)
    {
    case KQ2:
        if (!(SubSubWinObject =
        NewSubWindow,
            WA_Title,                              "Choose Your Location (Elsewhere) (KQ2)",
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_GadgetHelp,                     TRUE,
            WINDOW_UniqueID,                       "kq-4",
            WINDOW_ParentGroup,                    gadgets[GID_KQ_LY3] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddLocation(62),
                    AddSpace,
                    AddLocation(72),
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(59),
                    AddSpace,
                    AddLocation(63),
                    AddSpace,
                    AddLocation(73),
                    AddLocation(74),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(60),
                    AddLocation(61),
                    AddLocation(64),
                    AddLocation(65),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddLocation(67),
                    AddLocation(66),
                    AddSpace,
                    AddLocation(90),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(75),
                    AddLocation(76),
                    AddLocation(77),
                    AddLocation(78),
                    AddLocation(79),
                    AddLocation(91),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(80),
                    AddLocation(81),
                    AddLocation(82),
                    AddLocation(83),
                    AddLocation(84),
                    AddLocation(92),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(85),
                    AddLocation(86),
                    AddLocation(87),
                    AddLocation(88),
                    AddLocation(89),
                    AddLocation(93),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(68),
                    AddLocation(69),
                    AddLocation(70),
                    AddLocation(71),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(51),
                    AddLocation(52),
                    AddLocation(53),
                    AddLocation(54),
                    AddLocation(50),
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(55),
                    AddLocation(56),
                    AddLocation(57),
                    AddLocation(58),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddLabel(""),
                LAYOUT_AddChild,                   gadgets[GID_KQ_ST3] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_KQ_ST3,
                    GA_ReadOnly,                   TRUE,
                    STRINGA_TextVal,               "-",
                StringEnd,
                CHILD_WeightedHeight,              0,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase KQ3:
        if (!(SubSubWinObject =
        NewSubWindow,
            WA_Title,                              "Choose Your Location (Elsewhere) (KQ3)",
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_GadgetHelp,                     TRUE,
            WINDOW_UniqueID,                       "kq-5",
            WINDOW_ParentGroup,                    gadgets[GID_KQ_LY3] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddSpace,
                    AddLocation(54),
                    AddLocation(55),
                    AddLocation(56),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddLocation(52),
                    AddLocation(53),
                    AddLocation(60),
                    AddLocation(57),
                    AddLocation(58),
                    AddLocation(59),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddLocation(50),
                    AddLocation(51),
                    AddLocation(65),
                    AddLocation(66),
                    AddLocation(67),
                    AddLocation(64),
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(48),
                    AddLocation(49),
                    AddLocation(78),
                    AddLocation(74),
                    AddLocation(73),
                    AddSpace,
                    AddSpace,
                    AddLocation(63),
                LayoutEnd,
                AddHLayout,
                    AddSpace,
                    AddLocation(79),
                    AddLocation(80),
                    AddLocation(81),
                    AddLocation(71),
                    AddLocation(72),
                    AddLocation(62),
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddLocation(82),
                    AddLocation(83),
                    AddLocation(84),
                    AddLocation(69),
                    AddSpace,
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddLocation(85),
                    AddLocation(86),
                    AddLocation(68),
                    AddLocation(61),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddLabel(""),
                LAYOUT_AddChild,                   gadgets[GID_KQ_ST3] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_KQ_ST3,
                    GA_ReadOnly,                   TRUE,
                    STRINGA_TextVal,               "-",
                StringEnd,
                CHILD_WeightedHeight,              0,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase SQ1:
        if (!(SubSubWinObject =
        NewSubWindow,
            WA_Title,                              "Choose Your Location (Elsewhere) (SQ1)",
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_GadgetHelp,                     TRUE,
            WINDOW_UniqueID,                       "sq-2",
            WINDOW_ParentGroup,                    gadgets[GID_KQ_LY3] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddLocation(48),
                    AddLocation(49),
                    AddLocation(50),
                    AddLocation(51),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(60),
                    AddSpace,
                    AddSpace,
                    AddLocation(62),
                    AddLocation(64),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(52),
                    AddLocation(53),
                    AddLocation(54),
                    AddLocation(55),
                    AddLocation(65),
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(56),
                    AddLocation(57),
                    AddLocation(58),
                    AddLocation(59),
                    AddSpace,
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(47),
                    AddLocation(61),
                    AddLocation(45),
                    AddLocation(46),
                    AddSpace,
                    AddSpace,
                    AddSpace,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddLocation(43),
                    AddLocation(42),
                    AddLocation(41),
                    AddSpace,
                    AddLocation(71),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddLocation(31),
                    AddLocation(33),
                    AddLocation(37),
                    AddLocation(38),
                    AddLocation(39),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddSpace,
                    AddSpace,
                    AddLocation(29),
                    AddLocation(32),
                    AddLocation(34),
                    AddLocation(35),
                    AddLocation(36),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_EvenSize,               TRUE,
                    AddLocation(28),
                    AddLocation(27),
                    AddLocation(26),
                    AddLocation(25),
                    AddSpace,
                    AddLocation(70),
                    AddLocation(75),
                LayoutEnd,
                AddLabel(""),
                LAYOUT_AddChild,                   gadgets[GID_KQ_ST3] = (struct Gadget*)
                StringObject,
                    GA_ID,                         GID_KQ_ST3,
                    GA_ReadOnly,                   TRUE,
                    STRINGA_TextVal,               "-",
                StringEnd,
                CHILD_WeightedHeight,              0,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
    }   }

    unlockscreen();
    if (!(SubSubWindowPtr = (struct Window*) RA_OpenWindow(SubSubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubSubWindowPtr->Width, SubSubWindowPtr->Height);
#endif
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, SubSubWinObject, SubSubWindowPtr, TRUE);
#endif

    // Obtain the window wait signal mask.
    DISCARD GetAttr(WINDOW_SigMask, SubSubWinObject, (ULONG*) &LocalSignal);

    done = 0;
    do
    {   DISCARD Wait(LocalSignal);
        while ((result = DoMethod(SubSubWinObject, WM_HANDLEINPUT, &code)) != WMHI_LASTMSG)
        {   event = result & WMHI_CLASSMASK;
            switch (event)
            {
            case WMHI_CLOSEWINDOW:
                done = TRUE;
            acase WMHI_RAWKEY:
                GetAttr(WINDOW_Qualifier, SubSubWinObject, &qual);
                if (!(qual & IEQUALIFIER_REPEAT))
                {   switch (code)
                    {
                    case SCAN_RETURN:
                    case SCAN_ENTER:
                    case SCAN_ESCAPE:
                        done = 1;
                }   }
            acase WMHI_GADGETUP:
                gid = result & WMHI_GADGETMASK;
                if (gid >= GID_KQ_BU5 && (int) gid <= GID_KQ_BU5 + rooms[game] - 1)
                {   oldyou = you;
                    you = ours_to_theirs(gid - GID_KQ_BU5 + 1);
                    teleport();
                    done = 2;
    }   }   }   }
    while (!done);
  
    clearkybd();

    DisposeObject(SubSubWinObject);
    // SubSubWinObject = NULL;
    SubSubWindowPtr = NULL;

    return done;
}

EXPORT FLAG kq_subgadget(ULONG gid, UNUSED UWORD code)
{   if (gid == GID_KQ_BU4)
    {   if (locationwindow2() == 2)
        {  return TRUE;
    }   }
    elif (gid >= GID_KQ_BU5 && (int) gid <= GID_KQ_BU5 + rooms[game] - 1)
    {   oldyou = you;
        you = ours_to_theirs(gid - GID_KQ_BU5 + 1);
        teleport();
        return TRUE;
    }

    return FALSE;
}

EXPORT void kq_subtick(SWORD mousex, SWORD mousey)
{   int i,
        newover = -1;

    if (!SubWindowPtr)
    {   return;
    }

    if (SubSubWindowPtr)
    {   switch (game)
        {
        case KQ2:
            for (i = 50; i <= rooms[KQ2]; i++)
            {   if
                (   mousex >= gadgets[GID_KQ_BU5 + i - 1]->LeftEdge
                 && mousex <= gadgets[GID_KQ_BU5 + i - 1]->LeftEdge + gadgets[GID_KQ_BU5 + i - 1]->Width  - 1
                 && mousey >= gadgets[GID_KQ_BU5 + i - 1]->TopEdge
                 && mousey <= gadgets[GID_KQ_BU5 + i - 1]->TopEdge  + gadgets[GID_KQ_BU5 + i - 1]->Height - 1
                )
                {   newover = i - 1;
                    break; // for speed
            }   }
        acase KQ3:
        case  SQ1:
            for (i = 1; i <= rooms[game]; i++)
            {   if
                (   whichwin(ours_to_theirs(i)) == 2
                 && mousex >= gadgets[GID_KQ_BU5 + i - 1]->LeftEdge
                 && mousex <= gadgets[GID_KQ_BU5 + i - 1]->LeftEdge + gadgets[GID_KQ_BU5 + i - 1]->Width  - 1
                 && mousey >= gadgets[GID_KQ_BU5 + i - 1]->TopEdge
                 && mousey <= gadgets[GID_KQ_BU5 + i - 1]->TopEdge  + gadgets[GID_KQ_BU5 + i - 1]->Height - 1
                )
                {   newover = i - 1;
                    break; // for speed
        }   }   }

        if (newover != over)
        {   over = newover;
            DISCARD SetGadgetAttrs
            (   gadgets[GID_KQ_ST3], SubSubWindowPtr, NULL,
                STRINGA_TextVal, (over == -1) ? (STRPTR) "Hover over a button for more information." : LocationName[game][over + 1],
            TAG_DONE);
    }   }
    else
    {   switch (game)
        {
        case KQ2:
            for (i = 1; i <= 49; i++)
            {   if
                (   mousex >= gadgets[GID_KQ_BU5 + i - 1]->LeftEdge
                 && mousex <= gadgets[GID_KQ_BU5 + i - 1]->LeftEdge + gadgets[GID_KQ_BU5 + i - 1]->Width  - 1
                 && mousey >= gadgets[GID_KQ_BU5 + i - 1]->TopEdge
                 && mousey <= gadgets[GID_KQ_BU5 + i - 1]->TopEdge  + gadgets[GID_KQ_BU5 + i - 1]->Height - 1
                )
                {   newover = i - 1;
                    break; // for speed
            }   }
        acase KQ3:
        case  SQ1:
            for (i = 1; i <= rooms[game]; i++)
            {   if
                (   whichwin(ours_to_theirs(i)) == 1
                 && mousex >= gadgets[GID_KQ_BU5 + i - 1]->LeftEdge
                 && mousex <= gadgets[GID_KQ_BU5 + i - 1]->LeftEdge + gadgets[GID_KQ_BU5 + i - 1]->Width  - 1
                 && mousey >= gadgets[GID_KQ_BU5 + i - 1]->TopEdge
                 && mousey <= gadgets[GID_KQ_BU5 + i - 1]->TopEdge  + gadgets[GID_KQ_BU5 + i - 1]->Height - 1
                )
                {   newover = i - 1;
                    break; // for speed
            }   }
        adefault: // eg. KQ1
            for (i = 1; i <= rooms[game]; i++)
            {   if
                (   mousex >= gadgets[GID_KQ_BU5 + i - 1]->LeftEdge
                 && mousex <= gadgets[GID_KQ_BU5 + i - 1]->LeftEdge + gadgets[GID_KQ_BU5 + i - 1]->Width  - 1
                 && mousey >= gadgets[GID_KQ_BU5 + i - 1]->TopEdge
                 && mousey <= gadgets[GID_KQ_BU5 + i - 1]->TopEdge  + gadgets[GID_KQ_BU5 + i - 1]->Height - 1
                )
                {   newover = i - 1;
                    break; // for speed
        }   }   }

        if (newover != over)
        {   over = newover;
            DISCARD SetGadgetAttrs
            (   gadgets[GID_KQ_ST2], SubWindowPtr, NULL,
                STRINGA_TextVal, (over == -1) ? (STRPTR) "Hover over a button for more information." : LocationName[game][over + 1],
            TAG_DONE);
}   }   }

EXPORT FLAG kq_subkey(UWORD code)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
    case SCAN_ESCAPE:
        return TRUE;
    }

    return FALSE;
}

MODULE void getitem(int mode)
{   switch (game)
    {
    case KQ1:
        if (dosmode)
        {   switch (whichitem)
            {
            case   0: flag[ 67] = flag[ 69] = mode; // dagger                is/is not in hole
            acase  1: flag[104] =             mode; // chest
            acase  2: flag[ 77] =             mode; // carrot
            acase  3: flag[108] =             mode; // gold walnut
            acase  4: flag[ 84] =             mode; // key
            acase  5: flag[170] =             mode; // note
            acase  6: flag[ 83] = flag[ 82] = mode; // ring                  has not/has been given
            acase  7: flag[ 87] = flag[ 86] = mode; // clover                is/is not in room
            acase  8: flag[ 89] =                   // empty bowl
                      flag[ 90] =             mode; //                       clear: in bowl room; set: not there
                      flag[183] =         1 - mode; //                       on table or not
                      var[  89] =                0; //                       full or not
            acase  9: flag[ 89] =             mode; // full bowl
                      flag[ 90] =             mode; //                       clear: in bowl room; set: not there
                      flag[183] =         1 - mode; //                       on table or not
                      var[  89] =                1; //                       full or not
            acase 10: flag[ 81] = flag[176] = mode; // empty bucket          is at top of well/carried
                      flag[ 88] =                0; //                       full or not
            acase 11: flag[ 81] = flag[176] = mode; // full bucket           is at top of well/carried
                      flag[ 88] =                1; //                       full or not
            acase 12: flag[ 93] = flag[ 92] = mode; // pebbles               is/is not in room
            acase 13: flag[ 97] = flag[ 96] = mode; // slingshot             is/is not in room
            acase 14: flag[106] =             mode; // pouch of diamonds
            acase 15: flag[ 72] =             mode; // pouch
            acase 16: flag[113] =             mode; // sceptre
            acase 17: flag[139] =             mode; // cheese
            acase 18: flag[100] =             mode; // magic mirror
            acase 19: flag[110] =             mode; // gold egg
            acase 20: flag[102] =             mode; // shield
            acase 21: flag[171] = flag[172] = mode; // fiddle                is/is not in room
            acase 22: flag[127] = flag[129] = mode; // plain walnut          is/is not in room
            acase 23: flag[123] = flag[121] = mode; // mushroom              is/is not in room
            acase 24: flag[154] =             mode; // beans
        }   }
        else
        {   switch (whichitem)
            {
            case   0: flag[ 67] = flag[ 69] = mode; // dagger                is/is not in hole
            acase  1: flag[104] =             mode; // chest
            acase  2: flag[ 77] =             mode; // carrot
            acase  3: flag[108] =             mode; // gold walnut
            acase  4: flag[ 84] =             mode; // key
            acase  7: flag[170] =             mode; // note
            acase  9: flag[ 83] = flag[ 82] = mode; // ring                  has not/has been given
            acase 10: flag[ 87] = flag[ 86] = mode; // clover                is/is not in room
            acase 11: flag[ 89] =                   // ceramic bowl
                      flag[ 90] =             mode; //                       clear: in bowl room; set: not there
                      flag[183] =         1 - mode; //                       on table or not
                      var[  89] =                1; //                       full or not
            acase 12: flag[ 81] = flag[176] = mode; // water bucket          is at top of well/carried
            acase 13: flag[ 88] =             mode; // water
            acase 14: flag[ 93] = flag[ 92] = mode; // pebbles               is/is not in room
            acase 15: flag[ 97] = flag[ 96] = mode; // slingshot             is/is not in room
            acase 16: flag[106] =             mode; // pouch of diamonds
            acase 17: flag[ 72] =             mode; // pouch
            acase 18: flag[113] =             mode; // sceptre
            acase 19: flag[139] =             mode; // cheese
            acase 21: flag[100] =             mode; // magic mirror
            acase 22: flag[110] =             mode; // gold egg
            acase 23: flag[102] =             mode; // shield
            acase 24: flag[171] = flag[172] = mode; // fiddle                is/is not in room
            acase 25: flag[127] = flag[129] = mode; // plain walnut          is/is not in room
            acase 26: flag[123] = flag[121] = mode; // mushroom              is/is not in room
            acase 27: flag[154] =             mode; // beans

         /* acase  5:                               // necklace
            case   6:                               // locket
            case   8:                               // glass shoes
            case  20: ;                             // rope
         */ }
        }
    acase KQ2:
        switch (whichitem)
        {
        case   1: flag[ 82] =             mode; // trident               room #36
        acase  2: flag[ 59] =             mode; // bouquet of flowers    from sperm burping gutter slut
        acase  3: flag[ 73] =             mode; // bracelet              room #22
                  flag[ 80] =         1 - mode; //  in chest or not      room #74
        acase  4: flag[ 74] =             mode; // stake                 room #23
        acase  6: flag[143] =             mode; // tiara                 room #62
                  flag[ 79] =         1 - mode; //  in chest or not      room #74
        acase  7: flag[ 83] =             mode; // necklace              room #38
                  flag[ 77] =         1 - mode; //  in chest or not      room #74
        acase  8: flag[133] =             mode; // earrings              room #74
                  flag[ 83] =         1 - mode; //  in chest or not      room #74
        acase  9: flag[ 66] =             mode; // brooch                room #13
                  flag[ 81] =         1 - mode; //  in chest or not      room #74
        acase 10: flag[ 84] =             mode; // mallet                room #40
        acase 11: flag[ 96] =             mode; // 1st gold key          room #51
                  flag[111] =             mode; // 2nd gold key          room #58
                  flag[138] =             mode; // 3rd gold key          room #67
        acase 13: flag[ 65] =             mode; // basket of goodies     room  #3
                  flag[ 57] =         1 - mode; //  mailbox full/empty   room  #3
        acase 14: flag[ 97] =             mode; // bottle                room #51
        acase 16: flag[140] =             mode; // ham                   room #64
        acase 17: flag[112] =             mode; // chicken soup          room #74
        acase 22: flag[101] =             mode; // oil lamp              room #68
        acase 24: flag[137] =             mode; // pillow                room #67
        acase 25: flag[113] =             mode; // fishing net           room #75
        acase 28: flag[141] =             mode; // candle                room #59
        acase 29: flag[110] =             mode; // sugar cube            room #56
        acase 31: flag[122] =             mode; // amulet                room #78
        acase 32: flag[ 72] =             mode; // clamshell             room #22
        acase 33: flag[139] =             mode; // silver key            room #67

     /* acase  5:                               // ruby ring             room #70
        acase 12:                               // empty basket          anywhere
        acase 15:                               // empty bottle          anywhere
        acase 18:                               // black cloak           room #70
        acase 19: flag[  ?] =             mode; // cross                 room #71 (might have a flag, it was corrupt)
        acase 20:                               // caged nightingale     room #69
        acase 21:                               // empty birdcage        anywhere
        acase 23:                               // cloth                 anywhere
        acase 30:                               // gasping fish          room #75
        acase 34: ;                             // dead fish (Amiga only)
     */ }
    acase KQ3:
        switch (whichitem)
        {
        case   0: flag[221] =             mode; // chicken feather       room   #34
        acase  1: flag[128] =             mode; // cat hair              logic #104
        acase  8: flag[191] =         1 - mode; // eagle feather         logic #114 (whether eagle feather is in room)
        acase 13: flag[176] =             mode; // amber stone           room    #6 (whether we have ever gotten it)
        acase 25: flag[102] =             mode; // cup & ocean water     logic #120 (whether we have ever filled cup)
        acase 26: flag[110] =             mode; // spoonful of mud       logic #110
        acase 36: flag[ 94] =             mode; // magic wand            room    #5 (whether we have ever gotten it)
        acase 37: flag[ 92] =             mode; // brass key             room    #2
        acase 44: flag[205] =             mode; // purse & gold coins    room   #38 (whether we have ever gotten it)
        acase 48: flag[186] =             mode; // shovel                logic #108
        acase 49: flag[207] =             mode; // treasure chest        logic #108 (whether we have ever gotten it)
        }

     /* acase  2:                               // dog hair              room   #39
        acase  3: flag[  ?] =             mode; // snake skin            room   #11 (might have a flag, it was corrupt)
        acase  4:                               // fish bone powder      room   #10
        acase  5:                               // thimble               room   #42
        acase  6: flag[  ?] =             mode; // thimble & dew         room   #28 (might have a flag, it was corrupt)
        acase  7:                               // dough in ears         logic #121
        acase  9:                               // fly wings             room    #1
        acase 10:                               // saffron               room   #10
        acase 11:                               // rose essence          room    #2
        acase 12:                   	        // salt                  room   #39
        acase 14:                               // mistletoe             room   #29
        acase 15:                               // magic stone           logic #123
        acase 16:                               // nightshade juice      room   #10
        acase 17:                               // three acorns          room   #22
        acase 18:                               // empty pouch           room   #39
        acase 19:                               // sleep powder          logic #124
        acase 20:                               // mandrake root         room   #10
        acase 21:                               // fish oil              room   #39
        acase 22:                               // cat cookie            logic #125
        acase 23:                               // porridge              room   #41
        acase 24:                               // poisoned porridge     logic   #0
        acase 27:                               // toadstool powder      room   #10
        acase 28:                               // empty jar             logic #125
        acase 29:                               // storm brew            logic #126
        acase 30:                               // toad spittle          room   #10
        acase 31:                               // lard                  room   #39
        acase 32:                               // knife                 room    #6
        acase 33:                               // cactus                room   #21
        acase 34:                               // empty lard jar        logic #127
        acase 35:                               // invisibility ointment logic #127
        acase 38:                               // magic rose essence    logic #122
        acase 39:                               // bowl                  room    #6
        acase 40:                               // spoon                 room    #6
        acase 41:                               // empty cup             logic #126
        acase 42:                               // mirror                room    #2
        acase 43:                               // empty purse           room   #39
        acase 45:                               // bread                 room    #6
        acase 46:                               // fruit                 room    #6
        acase 47:                               // mutton                room    #6
        acase 50: ;                             // magic map             room    #2 */
    }

    if (mode == 1)
    {   switch (game)
        {
        case KQ1:
            switch (whichitem)
            {
            case   1: flag[105] = 0;                // chest             is not stolen
            acase  3: flag[109] = 0;                // gold walnut       is not stolen
            acase 16: flag[107] = 0;                // pouch of diamonds is not stolen
            acase 17: flag[112] = 0;                // pouch             is not stolen
            acase 18: flag[114] = 0;                // sceptre           is not stolen
            acase 19:                  var[87] = 3; // cheese            is carried
            acase 21: flag[101] = 0;                // magic mirror      is not stolen
            acase 22: flag[111] = 0;                // gold egg          is not stolen
            acase 23: flag[103] = 0;                // shield            is not stolen
            }
        acase KQ2:
            switch (whichitem)
            {
            case   0: if (var[87] < 2) var[87] = 2; // sword             (from genie)
            acase 26: if (var[87] < 1) var[87] = 1; // carpet            (from genie)
            acase 27: if (var[87] < 3) var[87] = 3; // bridle            (from genie)
        }   }

        item[whichitem] = CARRIED;
    } else
    {   switch (game)
        {
        case KQ1:
            switch (whichitem)
            {
            case  19:                  var[87] = 1; // cheese            is on shelf
        }   }

        item[whichitem] = NOWHERE;
    }

    if (game == KQ1)
    {   var[74] = 0;
        if (item[ 1] == CARRIED) var[74]++; // chest
        if (item[21] == CARRIED) var[74]++; // magic mirror
        if (item[23] == CARRIED) var[74]++; // shield
}   }

MODULE void refreshroom(void)
{   int closest;

    switch (game)
    {
    case KQ3:
        if (theirs_to_ours(you) == -1)
        {   sprintf(roomstring, "Room #%d", (int) you);
            switch (you)
            {
            case   70: case  87: closest = 65; // clouds
            acase  88:           closest = 66; // dragon
            acase 122:           closest = 22; // walnut
            acase 125: case 175: closest = 75; // docks #75
            acase 148:           closest = 48; // beach #48
            acase 176:           closest = 76; // docks #76
            adefault:            closest = 32; // desert #32
            // ie. 0, 43..47, 88..255
            }
            roomimage = firstimage[game] + theirs_to_ours(closest) - 1;
        } else
        {   strcpy(roomstring, LocationName[game][theirs_to_ours(you)]);
            roomimage = firstimage[game] + theirs_to_ours(you) - 1;
        }
    acase SQ1:
        if (theirs_to_ours(you) == -1)
        {   sprintf(roomstring, "Room #%d", (int) you);
            roomimage = firstimage[game] + theirs_to_ours( 42) - 1; // "space" image
        } else
        {   strcpy(roomstring, LocationName[game][theirs_to_ours(you)]);
            roomimage = firstimage[game] + theirs_to_ours(you) - 1;
        }
    adefault: // eg. KQ1, KQ2
        if ((int) you <= rooms[game])
        {   strcpy(roomstring, LocationName[game][you]);
            if (you == NOWHERE)
            {  roomimage = firstimage[game] + rooms[game] - 1;
            } else
            {  roomimage = firstimage[game] + you         - 1;
        }   }
        else
        {   sprintf(roomstring, "Room #%d", (int) you);
            roomimage    = firstimage[game] + rooms[game] - 1;
}   }   }

MODULE void teleport(void)
{   refreshroom();
    SetGadgetAttrs(gadgets[GID_KQ_BU2], MainWindowPtr, NULL, GA_Image, image[roomimage], TAG_DONE); // this autorefreshes
    SetGadgetAttrs(gadgets[GID_KQ_BU3], MainWindowPtr, NULL, GA_Text,  roomstring,       TAG_DONE); // this autorefreshes

    // 1st chunk----------------------------------------------------------

                                                        // Offset in examples
    if (!dosmode)
    {   IOBuffer[0x40] = you;                           // $ 40/$ 40/$ 40/$ 40/---
    }
    var[        0] = you;                               //           $1DD/$1DD/$28
    if (you != oldyou)
    {   var[    1] = (UBYTE) oldyou;                    //           $1DE/$1DE/$29 starts as $00 (for Amiga KQ3, at least)
    }

    switch (game)
    {
    case KQ1:
        if (dosmode)
        {   return;
        } // implied else
        var[   78] = you;
        if (!dosmode)
        {   // 2nd chunk--------------------------------------------------
            for
            (   offset = chunkstart[1] + 855;
                offset <= (ULONG) (chunkstart[1] + 927);
                offset++
            )                                         // $634..$6C4
            {   IOBuffer[offset] = 0; // seems to hang the game if we don't clear at least some of this area (2nd chunk)
        }   }
    acase KQ2:
        var[   77] = you;                               //      $340
    }

    // 4th chunk----------------------------------------------------------

    offset = chunkstart[3]; // start of 4th chunk payload ($997/$96E/$B33/$998/$A56)
    IOBuffer[    offset +  1] = you;                    // $998/$96F/$B34/$999/$A57

    switch (game)
    {
    case KQ1:
        IOBuffer[offset + 13] =                         // $9A4
        IOBuffer[offset + 15] =                         // $9A6
        IOBuffer[offset + 17] = you;                    // $9A8
    acase KQ2:
        IOBuffer[offset +  7] =                         //      $975
        IOBuffer[offset + 21] = you;                    //      $983
    acase KQ3:
        IOBuffer[offset + 11] =                         //           $B3E
        IOBuffer[offset + 13] =                         //           $B40
        IOBuffer[offset + 15] = you;                    //           $B42 this is what to discard
    }

    // 5th chunk----------------------------------------------------------

    offset = chunkstart[4]; // start of 5th chunk payload ($A61/$9D4/$C33/$9FE/$ABC)
    if (dosmode && game == SQ1)
    {   IOBuffer[offset +  8] = you;                    // ----/----/----/----/$AC4
    } else
    {   IOBuffer[offset +  9] = you;                    // $A6A/$9DD/$C3C/$A07/----
}   }

MODULE int ours_to_theirs(int ours)
{   switch (game)
    {
    case KQ3:
        if   (ours <= 42) return ours;        //  0..42 ->  0..42
        elif (ours <= 64) return ours   +  5; // 43..64 -> 48..69 
        elif (ours <= 70) return ours   +  6; // 65..70 -> 71..76 
        elif (ours <= 79) return ours   +  7; // 71..79 -> 78..86
        else              return -1;
    acase SQ1:
        if   (ours <= 39) return ours;        //  0..39 ->  0..39
        elif (ours <= 42) return ours   +  1; // 40..42 -> 41..43
        elif (ours <= 60) return ours   +  2; // 43..60 -> 45..62
        elif (ours <= 62) return ours   +  3; // 61..62 -> 64..65
        elif (ours <= 64) return ours   +  7; // 63..64 -> 70..71
        elif (ours == 65) return ours   +  8; // 65     -> 73
        elif (ours == 66) return ours   +  9; // 66     -> 75
        elif (ours <= 70) return ours   + 13; // 67..70 -> 80..83
        else              return -1;
    adefault: // eg. KQ1, KQ2
        return ours;
}   }

MODULE int theirs_to_ours(int theirs)
{   switch (game)
    {
    case KQ3:
        if   (                theirs <= 42) return theirs;      //  0..42 ->  0..42
        elif (theirs >= 48 && theirs <= 69) return theirs -  5; // 48..69 -> 43..64
        elif (theirs >= 71 && theirs <= 76) return theirs -  6; // 71..76 -> 65..70
        elif (theirs >= 78 && theirs <= 86) return theirs -  7; // 78..86 -> 71..79
        else                                return -1;
    acase SQ1:
        if   (                theirs <= 39) return theirs;      //  0..39 ->  0..39
        elif (theirs >= 41 && theirs <= 43) return theirs -  1; // 41..43 -> 40..42
        elif (theirs >= 45 && theirs <= 62) return theirs -  2; // 45..62 -> 43..60
        elif (theirs >= 64 && theirs <= 65) return theirs -  3; // 64..65 -> 61..62
        elif (theirs >= 70 && theirs <= 71) return theirs -  7; // 70..71 -> 63..64
        elif (theirs == 73                ) return theirs -  8; // 73     -> 65
        elif (theirs == 75                ) return theirs -  9; // 75     -> 66
        elif (theirs >= 80 && theirs <= 83) return theirs - 13; // 80..83 -> 67..70
        else                                return -1;
    adefault: // eg. KQ1, KQ2
        return theirs;
}   }

MODULE int whichwin(int theroom)
{   switch (game)
    {
    case KQ3:
        if
        (   (theroom >=  1 && theroom <= 47) // Manannan's house, main land
         || (theroom >= 75 && theroom <= 76) // docks
        )
        {   return 1;
        } elif
        (   (theroom >= 48 && theroom <= 74) // mountain & Daventry
         || (theroom >= 78 && theroom <= 86) // ship
        )
        {   return 2;
        } else
        {   return 0;
        }
    acase SQ1:
        if
        (   (theroom >= 25 && theroom <= 29)
         || (theroom >= 31 && theroom <= 39)
         || (theroom >= 41 && theroom <= 43)
         || (theroom >= 45 && theroom <= 62)
         || (theroom >= 64 && theroom <= 65)
         || (theroom >= 70 && theroom <= 71)
         ||  theroom == 75
        )
        {   return 2;
        } elif
        (   (theroom >=  1 && theroom <= 24)
         ||  theroom == 30
         ||  theroom == 73
         || (theroom >= 80 && theroom <= 83)
        )
        {   return 1;
        } else
        {   return 0;
        }
    adefault:
        // assert(0);
        return 0;
}   }

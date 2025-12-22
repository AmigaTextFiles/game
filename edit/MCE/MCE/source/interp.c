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
#define GID_INTERPLAY_LY1    0 // root layout
#define GID_INTERPLAY_SB1    1 // toolbar
#define GID_INTERPLAY_CH1    2 // game
#define GID_INTERPLAY_LB2    3 // main listbrowser
#define GID_INTERPLAY_IN1    4 // money
#define GID_INTERPLAY_IN2    5 // guitar picks

// location subwindow
#define GID_INTERPLAY_LY2    6
#define GID_INTERPLAY_LB1    7

#define GIDS_INTERPLAY       GID_INTERPLAY_LB1

#define MINDSHADOW           0
#define BORROWEDTIME         1
#define TTITT                2

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void locationwindow(void);
MODULE void makemainlist(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
IMPORT LONG                 gamesize,
                            whitepen;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image*        image[BITMAPS];
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
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

MODULE FLAG                 changedgame = FALSE;
MODULE int                  whichitem;
MODULE ULONG                game,
                            itemlocation[24 + 1],
                            money,
                            picks;
MODULE TEXT                 liststring[24+1][60 + 1],
                            substring[ 0x61][60 + 1];
MODULE struct List          MainList,
                            SubList;

MODULE const int    firstimage[3] = {  750,  775,  798 };
MODULE const int    numitems[3]   = {   24,   22,   20 };
MODULE const int    numrooms[3]   = { 0x60, 0x40, 0x60 };
MODULE const STRPTR GameOptions[3 + 1] =
{  "Mindshadow",
   "Borrowed Time",
   "Tass Times in Tonetown",
   NULL
}, ItemNames[3][24 + 1] = { {
"a shell",                  // $61  0
"a rock",                   // $63  1
"a map",                    // $65  2
"some straw",               // $67  3
"a piece of steel",         // $69  4
"a vine",                   // $6B  5
"a bottle of rum",          // $6D  6
"an empty bottle",          // $6F  7
"some canvas",              // $71  8
"a meat-cleaver",           // $73  9
"a fishing pole",           // $75 10
"a newspaper",              // $77 11
"a hat #12",                // $79 12
"a forged ticket",          // $7B 13
"a leaflet",                // $7D 14
"an ID",                    // $7F 15
"a note",                   // $81 16
"a parchment",              // $83 17
"a message",                // $85 18
"some debris",              // $87 19
"a pistol #20",             // $89 20
"a hat #21",                // $8B 21
"a safety deposit box",     // $8D 22
"a pistol #23",             // $8F 23
"You",                      // $9D 24
}, {
"a gun",                    // $41  0
"a pack of matches",        // $43  1
"a wallet",                 // $45  2
"a key",                    // $47  3
"a personal check",         // $49  4
"a shard of glass",         // $4B  5
"a scrap of paper",         // $4D  6
"a candle",                 // $4F  7
"a silver candlestick",     // $51  8
"a white tube",             // $53  9
"a receipt",                // $55 10
"a novel",                  // $57 11
"a claim stub",             // $59 12
"a pair of gloves",         // $5B 13
"three empty cans",         // $5D 14
"a report",                 // $5F 15
"a poem",                   // $61 16
"a shovel",                 // $63 17
"a plaid suitcase",         // $65 18
"a manila folder",          // $67 19
"a bone",                   // $69 20
"a roll of bandages",       // $6B 21
"You",                      // $C1 22
}, {
"a bunch of guitar picks",  // $41  0
"Blobo",                    // $43  1
"a key",                    // $45  2
"a book",                   // $47  3
"a jumpsuit",               // $49  4
"a jar with a devil in it", // $4B  5
"a slippy shirt",           // $4D  6
"a hooplet",                // $4F  7
"a newspaper",              // $51  8
"a press pass",             // $53  9
"an instant camera",        // $55 10
"a photo",                  // $57 11
"a zagtone",                // $59 12
"a debossed metal card",    // $5B 13
"mitts",                    // $5D 14
"a Glo Burger",             // $5F 15
"a black mask",             // $61 16
"a gold mask",              // $63 17
"a silver jar",             // $65 18
"a mushroom",               // $67 19
"You",                      // $C1 20
} }, LocationNames[3][0x61] = { {
"Carried",
"Beach #1",
"Cliff",
"Outside cave",
"Before hut",
"Inside hut",
"Sand",
"Oasis",
"Trail",
"Mountains #9",
"Quicksand #10",
"Mountains #11",
"Beach #12",
"Mountains #13",
"Mountains #14",
"Quicksand #15",
"Mountains #16",
"Quicksand #17",
"Quicksand #18",
"Mountains #19",
"Mountains #20",
"Mountains #21",
"Quicksand #22",
"Mountains #23",
"Quicksand #24",
"Quicksand #25",
"Schooner",
"Starboard #27",
"Starboard #28",
"Deck",
"Port side #30",
"Port side #31",
"Port side #32",
"Stern",
"Sick bay",
"Crew's quarters #35",
"Galley",
"Plank #37",
"Pier",
"Docks",
"Fog",
"Derelict #41",
"Airport",
"Baker Street #43",
"Baker Street #44",
"Beach #45",
"Baker Street #46",
"Store",
"Rick's Cafe",
"Dining room",
"Restroom",
"Alley #51",
"Alley #52",
"Plane",
"Strausbahn #54",
"Inn",
"Strausbahn #56",
"Bank",
"Tourist quarter",
"Wilderness #59",
"Wilderness #60",
"Wilderness #61",
"Wilderness #62",
"Wilderness #63",
"Wilderness #64",
"Wilderness #65",
"Lobby #66",
"Beach #67",
"Elevator #68",
"Elevator #69",
"Hall #70",
"Hall #71",
"Hall #72",
"Hall #73",
"Hall #74",
"Room 202",
"Room 201",
"Room 204",
"Room 203",
"Room 206", 
"Room 205",
"Room 207", 
"Room 208",
"Port bow",
"Starboard bow",
"Port stern",
"Starboard stern",
"Inside cave",
"Lobby #88",
"Second floor",
"Crew's quarters #90",
"Booth #91",
"Booth #92",
"Dead man",
"Beach #94",
"Plank #95",
"Nowhere"
}, {
"Carried",
"Office #1",
"Little room",
"Narrow alley",
"Side of Dixie Arms Hotel",
"Temporarily hidden",
"Base of stairway",
"Attic",
"Office #8",
"Office #9",
"2nd-storey window of bar",
"Bar",
"1st St east of Main St",
"Intersection of 1st & Main Sts",
"Newsstand",
"Townhouse #15",
"Townhouse #16",
"Door of townhouse",
"Lebock's living room",
"Centre of room",
"Lebock's kitchen",
"Polk St",
"Door of Rita's apartment",
"Rita's living room #23",
"Rita's living room #24",
"Rita's kitchen",
"Main St south of 1st St",
"6th & South Main Sts",
"Inside New City Police Station",
"6th St west of Main St",
"Door of Light's place",
"Light's living room #31",
"Light's living room #32",
"Light's living room #33",
"Door of Lafferty's office",
"Lafferty's office",
"Lafferty's study",
"In front of a wooden frame house",
"Corner of Pershing Ave & West 6th",
"Corner of Pershing Ave & West 1st",
"West end of 1st St",
"Shack 960",
"Inside shack 960",
"Office #43",
"Office #44",
"Office #45",
"Office #46",
"Polk St west of Pershing Ave",
"Small apartment",
"South of Stiles Safe Park",
"Carpark #50",
"Carpark #51",
"Carpark #52",
"Before a frame house on West Polk St",
"Inside Jim Shuman's home #54",
"Inside Jim Shuman's home #55",
"In front of Farnham's HQ at 85 West Polk St",
"Farnham's study",
"Marble lobby",
"Hall",
"Centre of park",
"South end of park",
"Stiles Safe Park",
"Attic",
"Nowhere"
}, {
"Carried",
"Main living area #1",
"Kitchen",
"Hallway",
"Bedroom",
"Lab",
"Eastern part of lab",
"Construction site #7",
"N-S sidewalk #8",
"In the Jamac Salon",
"In a clothing boutique",
"On the sidewalk outside the Tonetown Times",
"In the main office of the Tonetown Times",
"Terminal",
"Location #14",
"N-S sidewalk #15",
"Construction site #16",
"Fast Freddy's",
"In the centre of the town square",
"Inside Snarl Pets #19",
"In the Party Supplies shop",
"Location #21",
"Park",
"Trail #23",
"Trail #24",
"Trail #25",
"Trail #26",
"Woods #27",
"Clearing",
"At the bottom of a well",
"Cavern",
"At the southern end of a tunnel",
"N-S tunnel #32",
"N-S tunnel #33",
"At the northern end of a tunnel",
"Behind the bandstand",
"Inside Snarl Pets #36",
"Location #37",
"Gristle",
"Penthouse #39",
"Woods #40",
"Woods #41",
"Woods #42",
"Woods #43",
"Woods #44",
"A high brick wall is directly ahead #45",
"A high brick wall is directly ahead #46",
"A high brick wall is to your left #47",
"A high brick wall is to your left #48",
"On your left is a high wooden gate",
"A high brick wall is to your left #50",
"Large mushroom growths",
"Huge mushroom growths",
"Woods #53",
"Red Devils #54",
"Red Devils #55",
"Path",
"Boat landing",
"Campground",
"River #59",
"River #60",
"River #61",
"River #62",
"River #63",
"Waterfall #64",
"Waterfall #65",
"Main living area #66",
"Shoreline #67",
"Marsh #68",
"Marsh #69",
"Marsh #70",
"Shoreline #71",
"At the entrance of Ennui Estates",
"Directly south of a landing",
"In the boat #74",
"In the boat #75",
"Before the entrance to the Tower",
"Location #77",
"Location #78",
"Inside an office complex",
"Elevator #80",
"Elevator #81",
"Elevator #82",
"Elevator #83",
"Penthouse #84",
"E-W hallway #85",
"E-W hallway #86",
"By a hollow tree",
"SE corner of estate",
"E-W path",
"Middle of estate",
"Lawn #91",
"Lawn #92",
"Lawn #93",
"Franklin Snarl's house",
"Franklin Snarl's laboratory",
"Nowhere"
} };

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct ColumnInfo TheColumnInfo[] =
{ { 0,                 /* WORD   ci_Width */
    "",                /* STRPTR ci_Title */
    CIF_FIXED          /* ULONG  ci_Flags */
  },
  { 0,                 /* WORD   ci_Width */
    NULL,              /* STRPTR ci_Title */
    CIF_FIXED          /* ULONG  ci_Flags */
  },
  { 0,
    NULL,
    CIF_WEIGHTED
  },
  { -1,
    (STRPTR) ~0,
    -1
} };

// 8. CODE ---------------------------------------------------------------

EXPORT void interplay_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // interplay_preinit()
        NewList(&MainList);
        NewList(&SubList);
    }

    tool_open      = interplay_open;
    tool_loop      = interplay_loop;
    tool_save      = interplay_save;
    tool_close     = interplay_close;
    tool_exit      = interplay_exit;
    tool_subgadget = interplay_subgadget;

    if (loaded != FUNC_INTERPLAY && !interplay_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_INTERPLAY;

    make_speedbar_list(GID_INTERPLAY_SB1);
    makemainlist();
    InitHook(&ToolHookStruct, (ULONG (*)()) ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERSCREEN,
        WINDOW_ParentGroup,                                gadgets[GID_INTERPLAY_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddHLayout,
                AddToolbar(GID_INTERPLAY_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_INTERPLAY_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_INTERPLAY_CH1,
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
            AddVLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_Label,                              "Item Locations",
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_SpaceInner,                         TRUE,
                LAYOUT_AddChild,                           gadgets[GID_INTERPLAY_LB2] = (struct Gadget*)
                ListBrowserObject,
                    GA_ID,                                 GID_INTERPLAY_LB2,
                    GA_RelVerify,                          TRUE,
                    LISTBROWSER_ColumnInfo,                (ULONG) &TheColumnInfo,
                    LISTBROWSER_Labels,                    (ULONG) &MainList,
                    LISTBROWSER_MinVisible,                1,
                    LISTBROWSER_ShowSelected,              TRUE,
                    LISTBROWSER_ColumnTitles,              FALSE,
                    LISTBROWSER_AutoFit,                   TRUE,
                    LISTBROWSER_AutoWheel,                 FALSE,
                ListBrowserEnd,
                CHILD_MinWidth,                            400,
                CHILD_MinHeight,                           404,
            LayoutEnd,
            LAYOUT_AddChild,                               gadgets[GID_INTERPLAY_IN1] = (struct Gadget*)
            IntegerObject,
                GA_ID,                                     GID_INTERPLAY_IN1,
                GA_RelVerify,                              TRUE,
                INTEGER_Minimum,                           0,
                INTEGER_Maximum,                           65535,
                INTEGER_MinVisible,                        5 + 1,
            IntegerEnd,
            CHILD_WeightedHeight,                          0,
            Label("Money: £"),
            LAYOUT_AddChild,                               gadgets[GID_INTERPLAY_IN2] = (struct Gadget*)
            IntegerObject,
                GA_ID,                                     GID_INTERPLAY_IN2,
                GA_RelVerify,                              TRUE,
                INTEGER_Minimum,                           0,
                INTEGER_Maximum,                           65535,
                INTEGER_MinVisible,                        5 + 1,
            IntegerEnd,
            CHILD_WeightedHeight,                          0,
            Label("Guitar picks:"),
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_INTERPLAY_SB1);
    writegadgets();
    if (game == MINDSHADOW)
    {   ActivateLayoutGadget(gadgets[GID_INTERPLAY_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_INTERPLAY_IN1]);
    }
    loop();
    readgadgets();
    closewindow();
}

EXPORT void interplay_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_INTERPLAY_LB2:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_INTERPLAY_LB2], (ULONG*) &whichitem);
        locationwindow();
    acase GID_INTERPLAY_IN2:
        // assert(game == TTITT);
        readgadgets();
        if (picks == 0 && itemlocation[0] == 0)
        {   itemlocation[0] = 0x40; // nowhere
            writegadgets();
}   }   }

EXPORT FLAG interplay_open(FLAG loadas)
{   if (gameopen(loadas))
    {   switch (gamesize)
        {
        case 180:
            game = MINDSHADOW;
        acase 202:
            if (ask("Which game is this for?", "Borrowed Time|TTITT") == 0) // Borrowed Time
            {   game = BORROWEDTIME;
            } else
            {   game = TTITT;
            }
        adefault:
            DisplayBeep(NULL);
            return FALSE;
    }   }
    else
    {   return FALSE;
    }

    switch (game)
    {
    case  MINDSHADOW:   load_images(750, 774);
    acase BORROWEDTIME: load_images(775, 797);
    acase TTITT:        load_images(798, 818);
    }
    if (MainWindowPtr)
    {   changedgame = TRUE;
        if (whichitem > numitems[game])
        {   whichitem = numitems[game];
    }   }

    serializemode = SERIALIZE_READ;
    serialize();
    writegadgets();
    return TRUE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_INTERPLAY
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   if (gadmode == SERIALIZE_WRITE)
    {   either_ch(GID_INTERPLAY_CH1, &game); // this autorefreshes

        ghost(    GID_INTERPLAY_IN1, game != MINDSHADOW); // money
        ghost(    GID_INTERPLAY_IN2, game != TTITT || itemlocation[0] != 0); // guitar picks

        SetGadgetAttrs(gadgets[GID_INTERPLAY_LB2], MainWindowPtr, NULL, LISTBROWSER_Labels,  ~0,        TAG_END);
        makemainlist();
        SetGadgetAttrs(gadgets[GID_INTERPLAY_LB2], MainWindowPtr, NULL, LISTBROWSER_Labels,  &MainList, TAG_END);
        if (changedgame)
        {   changedgame = FALSE;
            SetGadgetAttrs(gadgets[GID_INTERPLAY_LB2], MainWindowPtr, NULL, LISTBROWSER_AutoFit, TRUE,      TAG_END);
        }
        RefreshGadgets((struct Gadget*) gadgets[GID_INTERPLAY_LB2], MainWindowPtr, NULL);
    }

    either_in(GID_INTERPLAY_IN1, &money);
    either_in(GID_INTERPLAY_IN2, &picks);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    switch (game)
    {
    case MINDSHADOW:
        offset = 2;
        serialize2ulong(&money);
        picks = 0;

        offset = 0x61;
        for (i = 0; i < numitems[game]; i++)
        {   if (serializemode == SERIALIZE_WRITE && itemlocation[i] == (ULONG) numrooms[game])
            {   itemlocation[i] = 0xFF;
            }
            serialize1(&itemlocation[i]);
            if (serializemode == SERIALIZE_READ  && itemlocation[i] == 0xFF)
            {   itemlocation[i] = numrooms[game];
            }
            offset++;
        }

        offset = 0x9D;
        serialize1(&itemlocation[24]);

        if (serializemode == SERIALIZE_WRITE)
        {   offset = 0xA0;
            for (i = 0; i < 24; i++)
            {   if (itemlocation[i] == 0x00) // carried
                {   IOBuffer[offset++] = 0x00;
                    IOBuffer[offset++] = i;
                }
                if (offset >= 0xB0)
                {   break;
            }   }
            while (offset < 0xB0)
            {   IOBuffer[offset++] = 0xFF;
                IOBuffer[offset++] = 0xFF;
        }   }
    acase BORROWEDTIME:
        money = picks = 0;

        offset = 0x41;
        for (i = 0; i < numitems[game]; i++)
        {   if (serializemode == SERIALIZE_WRITE && itemlocation[i] == (ULONG) numrooms[game])
            {   itemlocation[i] = 0xFF;
            }
            serialize1(&itemlocation[i]);
            if (serializemode == SERIALIZE_READ  && itemlocation[i] == 0xFF)
            {   itemlocation[i] = numrooms[game];
            }
            offset++;
        }

        offset = 0xC1;
        serialize1(&itemlocation[22]);

        if (serializemode == SERIALIZE_WRITE)
        {   // offset = 0xC2;
            for (i = 0; i < 22; i++)
            {   if (itemlocation[i] == 0x00) // carried
                {   IOBuffer[offset++] = i;
                }
                if (offset >= 0xC9)
                {   break;
            }   }
            while (offset < 0xC9)
            {   IOBuffer[offset++] = 0xFF;
        }   }
    acase TTITT:
        money = 0;
        offset = 0x14;
        serialize2ulong(&picks);

        offset = 0x41;
        for (i = 0; i < numitems[game]; i++)
        {   if (serializemode == SERIALIZE_WRITE && itemlocation[i] == (ULONG) numrooms[game])
            {   itemlocation[i] = 0xFF;
            }
            serialize1(&itemlocation[i]);
            if (serializemode == SERIALIZE_READ  && itemlocation[i] == 0xFF)
            {   itemlocation[i] = numrooms[game];
            }
            offset++;
        }

        offset = 0xC1;
        serialize1(&itemlocation[20]);

        if (serializemode == SERIALIZE_WRITE)
        {   // offset = 0xC2;
            for (i = 0; i < 20; i++)
            {   if (itemlocation[i] == 0x00) // carried
                {   IOBuffer[offset++] = i;
                }
                if (offset >= 0xC9)
                {   break;
            }   }
            while (offset < 0xC9)
            {   IOBuffer[offset++] = 0xFF;
}   }   }   }

EXPORT void interplay_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  MINDSHADOW:   gamesave("#?", "Mindshadow"            , saveas, gamesize, FLAG_S, FALSE);
    acase BORROWEDTIME: gamesave("#?", "Borrowed Time"         , saveas, gamesize, FLAG_S, FALSE);
    acase TTITT:        gamesave("#?", "Tass Times in Tonetown", saveas, gamesize, FLAG_S, FALSE);
}   }

EXPORT void interplay_exit(void)
{   lb_clearlist(&MainList);
    lb_clearlist(&SubList);
}

EXPORT void interplay_close(void) { ; }

MODULE void locationwindow(void)
{   int          i;
    struct Node* ListBrowserNodePtr;

    for (i = 0; i <= numrooms[game]; i++)
    {   strcpy(substring[i], LocationNames[game][i]);
        if (!(ListBrowserNodePtr = AllocListBrowserNode
        (   1,              /* columns, */
            (whichitem == numitems[game] && (i == 0 || i == numrooms[game])) ? LBNA_Flags  : TAG_IGNORE, LBFLG_READONLY | LBFLG_CUSTOMPENS,
            LBNA_Column,    0,
            LBNCA_Text,     substring[i],
            (whichitem == numitems[game] && (i == 0 || i == numrooms[game])) ? LBNCA_FGPen : TAG_IGNORE, whitepen,
        TAG_END)))
        {   rq("Can't create listbrowser.gadget node(s)!");
        }
        AddTail(&SubList, ListBrowserNodePtr); /* AddTail() has no return code */
    }

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Choose Location",
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "interp-1",
        WINDOW_ParentGroup,                    gadgets[GID_INTERPLAY_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_INTERPLAY_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_INTERPLAY_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &SubList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    (game == MINDSHADOW) ? 250 : 400,
            CHILD_MinHeight,                   400,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    DISCARD SetGadgetAttrs(         gadgets[GID_INTERPLAY_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    itemlocation[whichitem], TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_INTERPLAY_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, itemlocation[whichitem], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_INTERPLAY_LB1], SubWindowPtr, NULL);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;

    lb_clearlist(&SubList);
}

EXPORT FLAG interplay_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_INTERPLAY_LB1:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_INTERPLAY_LB1], (ULONG*) &itemlocation[whichitem]);
        if (game == TTITT && whichitem == 0)
        {   picks = (itemlocation[0] == 0) ? 3 : 0; // arbitrary
        }
        if
        (   whichitem == numitems[game] // you
         && (   itemlocation[whichitem] == 0 // carried
             || itemlocation[whichitem] == (ULONG) numrooms[game] // nowhere
        )   ) // this shouldn't happen but it can
        {   itemlocation[whichitem] = 1;
        }
        writegadgets();
        return TRUE;
    }

    return FALSE;
}

MODULE void makemainlist(void)
{   int          i;
    struct Node* ListBrowserNodePtr;

    lb_clearlist(&MainList);

    for (i = 0; i <= numitems[game]; i++)
    {   strcpy(liststring[i], LocationNames[game][itemlocation[i]]);
        if (!(ListBrowserNodePtr = AllocListBrowserNode
        (    3,              /* columns, */
             LBNA_Column,    0,
             LBNCA_Image,    image[firstimage[game] + i],
             LBNA_Column,    1,
             LBNCA_CopyText, TRUE,
             LBNCA_Text,     ItemNames[game][i],
             LBNA_Column,    2,
             LBNCA_CopyText, TRUE,
             LBNCA_Text,     liststring[i],
        TAG_END)))
        {   rq("Can't create listbrowser.gadget node(s)!");
        }
        AddTail(&MainList, ListBrowserNodePtr); /* AddTail() has no return code */
}   }

EXPORT FLAG interplay_subkey(UWORD code, UWORD qual)
{   ULONG min, max;

    max = numrooms[game];
    if (whichitem == numitems[game])
    {   max--;
        min = 1;
    } else
    {   min = 0;
    }

    switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        if (lb_move_up(  GID_INTERPLAY_LB1, SubWindowPtr, qual, &itemlocation[whichitem], min, 5))
        {   writegadgets();
        }
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        if (lb_move_down(GID_INTERPLAY_LB1, SubWindowPtr, qual, &itemlocation[whichitem], max, 5))
        {   writegadgets();
    }   }

    return FALSE;
}

EXPORT void interplay_key(UBYTE scancode, UWORD qual)
{   switch (scancode)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        lb_scroll_up(GID_INTERPLAY_LB2, MainWindowPtr, qual);
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_scroll_down(GID_INTERPLAY_LB2, MainWindowPtr, qual);
}   }

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
#define GID_ARAZOK_LY1   0 // root layout
#define GID_ARAZOK_SB1   1 // toolbar
#define GID_ARAZOK_BU1   2 // maximize
#define GID_ARAZOK_BU2   3 //  1st location chooser
#define GID_ARAZOK_BU45 46 // 44th location chooser
#define GID_ARAZOK_IN1  47 // hunger
#define GID_ARAZOK_IN2  48 // moves

// location subwindow
#define GID_ARAZOK_LY2  49 // root layout
#define GID_ARAZOK_ST1  50
#define GID_ARAZOK_BU46 51
#define GID_ARAZOK_BU47 52
#define GID_ARAZOK_BU48 53
#define GID_ARAZOK_BU93 98
#define GIDS_ARAZOK     GID_ARAZOK_BU93

#define LocationButton(x) \
LAYOUT_AddChild, gadgets[GID_ARAZOK_BU2 + x] = (struct Gadget*) \
ZButtonObject, \
    GA_ID,                GID_ARAZOK_BU2 + x, \
    GA_RelVerify,         TRUE, \
    BUTTON_Justification, BCJ_LEFT, \
    BUTTON_FillPen,       pens[0], \
ButtonEnd

#define AddLocation(x)                                           \
LAYOUT_AddChild, gadgets[GID_ARAZOK_BU48 + x] = (struct Gadget*) \
ZButtonObject,                                                    \
    GA_ID,           GID_ARAZOK_BU48 + x,                        \
    GA_RelVerify,    TRUE,                                       \
    GA_Image,        image[454 + x],                             \
    GA_Selected,     (itemloc[gad_to_slot[whichitem]] - 1 == x) ? TRUE : FALSE, \
ButtonEnd,                                                       \
CHILD_MinWidth,      112 + 12,                                   \
CHILD_MinHeight,      50 + 12,                                   \
CHILD_WeightedWidth, 0

#define CARRIED             0

#define YOU                43
#define NOWHERE            47

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE int getpaddednumber(void);
MODULE void putpaddednumber(int whichnum);
MODULE int getcommanumber(void);
MODULE void putcommanumber(int whichnum);
MODULE void locationwindow(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT LONG                 gamesize,
                            pens[PENS];
IMPORT ULONG                offset,
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
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
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

MODULE       int            over,
                            whichitem;
MODULE       ULONG          commanum[17],
                            itemloc[69],
                            hunger, moves;

MODULE const STRPTR LocationNames[] =
{
"Carried",                                     //  0
"In a dense forest",                           //  1
"In a clearing with impenetrable forest",      //  2
"In a chamber illuminated with glowing rocks", //  3
"In a hall that goes north and south",         //  4
"In another dimly lit chamber",                //  5
"In a giant forest",                           //  6
"On the edge of a cliff overlooking an ocean", //  7
"On an island with a path leading up",         //  8
"On a path leading east and west",             //  9
"At a crossroads",                             // 10
"In a giant hall inside the city of Zambambe", // 11
"In a giant hall inside the city of Zenbambe", // 12
"In a hall leading north and south",           // 13
"In a strange view chamber",                   // 14
"In a dusty alchemist's laboratory #15",       // 15
"In an empty room with a hall to the east",    // 16
"In room that is empty except for a strange oak door", // 17
"In a hallway that goes in four directions",   // 18
"In a hall that goes east and west",           // 19
"In a hall that has dead ended",               // 20
"In the warriors' quarters #21",               // 21
"In the computer room #22",                    // 22
"In a red hall",                               // 23
"In the power room for the whole city #24",    // 24
"In a gloomy hall with a ramp leading up #25", // 25
"In a murky chamber",                          // 26
"On a ramp",                                   // 27
"In the travel car inside the tube",           // 28
"In a transport chamber with a travel tube",   // 29
"In a special view screen chamber",            // 30
"In a hall that has a ramp leading down",      // 31
"In a room that appears to be empty",          // 32
"On a ramp that leads up to a blank wall",     // 33
"In a gloomy hall with a ramp leading up #34", // 34
"In a dusty alchemist's laboratory #35",       // 35
"In the warriors' quarters #36",               // 36
"In a room with a locked steel door on the east wall", // 37
"In a hall that heads in four directions",     // 38
"In a hall that heads east and west",          // 39
"At a dead end",                               // 40
"In the computer room #41",                    // 41
"In a green hall",                             // 42
"In the power room for the whole city #43",    // 43
"On a path leading northwest and southeast",   // 44
"On a path leading southeast and northeast",   // 45
"In the castle",                               // 46
"Nowhere",                                     // 47
// NULL is not needed
};

MODULE const int gad_to_slot[44] = {
10, //  0 statue
11,
12,
13,
14,
15,
16,
17,
18,
19,
20, // 10 card
21,
22,
23,
24,
25,
26,
27,
28,
29,
30, // 20 prism
31,
32,
33,
34,
35, // 25 mail
37, // 26 decanter
38, // 27 travel car
39, // 28 transport tube
50, // 29 Zud
51, // 30 Arazok
52, // 31 snake
54, // 32 wall panel
55, // 33 terminal
56, // 34 control panel
57, // 35 polished door
58, // 36 portal
59, // 37 circle
60, // 38 jewel
64, // 39 statue (w/o jewels)
65, // 40 statue (with jewels)
66, // 41 ramp
67, // 42 sign
68, // 43 you
};

MODULE const STRPTR ItemNames[] = {
"Druid-like statue",
"Magic candle",
"Gold flower",
"Elixir",
"Short sword",
"Silver rifle",
"Moldy book",
"Silver whistle",
"Magic key",
"Golden chalice",
"Circuit card",      // 10
"Small statue",
"Strength potion",
"Magic wand",
"Small box",
"Remote control",
"Power pack",
"Burned printout",
"Cloak",
"Pouch",
"Glowing prism",     // 20
"Carloni chips",
"Telanian tostins",
"Portal projector",
"Laser disk",
"Silver chain mail",
"Decanter",
"Travel car",
"Transport tube",
"Zud",
"Arazok",            // 30
"Giant snake",
"Wall panel",
"Computer terminal",
"Control panel",
"Polished door",
"Transport portal",
"Ebony circle",
"Red jewel",
"Statue w/o jewels",
"Statue w/ jewels",  // 40
"Ramp",
"Sign",
"You",               // 43
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(None)

8. CODE --------------------------------------------------------------- */

EXPORT void arazok_main(void)
{   tool_open      = arazok_open;
    tool_loop      = arazok_loop;
    tool_save      = arazok_save;
    tool_close     = arazok_close;
    tool_exit      = arazok_exit;
    tool_subgadget = arazok_subgadget;

    if (loaded != FUNC_ARAZOK && !arazok_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_ARAZOK;

    make_speedbar_list(GID_ARAZOK_SB1);
    load_fimage(FUNC_ARAZOK);
    load_aiss_images(10, 10);
    arazok_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                         TRUE,
        WA_ThinSizeGadget,                                     TRUE,
        WINDOW_Position,                                       SPECIALWPOS,
        WINDOW_ParentGroup,                                    gadgets[GID_ARAZOK_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                 TRUE,
            LAYOUT_SpaceInner,                                 TRUE,
            AddToolbar(GID_ARAZOK_SB1),
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,                         BVS_GROUP,
                    LAYOUT_Label,                              "Items",
                    LAYOUT_SpaceOuter,                         TRUE,
                    LocationButton(0),
                    Label("Druid-like statue:"),
                    LocationButton(1),
                    Label("Magic candle:"),
                    LocationButton(2),
                    Label("Gold flower:"),
                    LocationButton(3),
                    Label("Elixir:"),
                    LocationButton(4),
                    Label("Short sword:"),
                    LocationButton(5),
                    Label("Silver rifle:"),
                    LocationButton(6),
                    Label("Mouldy book:"),
                    LocationButton(7),
                    Label("Silver whistle:"),
                    LocationButton(8),
                    Label("Magic key:"),
                    LocationButton(9),
                    Label("Golden chalice:"),
                    LocationButton(10),
                    Label("Circuit card:"),
                    LocationButton(11),
                    Label("Small statue:"),
                    LocationButton(12),
                    Label("Strength potion:"),
                    LocationButton(13),
                    Label("Magic wand:"),
                    LocationButton(14),
                    Label("Small box:"),
                    LocationButton(15),
                    Label("Remote control:"),
                    LocationButton(16),
                    Label("Power pack:"),
                    LocationButton(17),
                    Label("Burned printout:"),
                    LocationButton(18),
                    Label("Cloak:"),
                    LocationButton(19),
                    Label("Pouch:"),
                    LocationButton(20),
                    Label("Glowing prism:"),
                    LocationButton(21),
                    Label("Carloni chips:"),
                    LocationButton(22),
                    Label("Telanian tostins:"),
                    LocationButton(23),
                    Label("Portal projector:"),
                    LocationButton(24),
                    Label("Laser disk:"),
                    LocationButton(25),
                    Label("Silver chain mail:"),
                    // slot 26 ("S") is not used
                    LocationButton(26),                        // gad 26, affects slot 37
                    Label("Decanter:"),
                LayoutEnd,
                AddVLayout,
                    AddHLayout,
                        LAYOUT_VertAlignment,                  LALIGN_CENTER,
                        AddLabel("Hunger:"),
                        CHILD_WeightedWidth,                   0,
                        LAYOUT_AddChild,                       gadgets[GID_ARAZOK_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                             GID_ARAZOK_IN1,
                            GA_TabCycle,                       TRUE,
                            INTEGER_MinVisible,                5 + 1,
                            INTEGER_Arrows,                    TRUE,
                            INTEGER_Minimum,                   0,
                            INTEGER_Maximum,                   32767,
                        IntegerEnd,
                        AddLabel("Moves:"),
                        CHILD_WeightedWidth,                   0,
                        LAYOUT_AddChild,                       gadgets[GID_ARAZOK_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                             GID_ARAZOK_IN2,
                            GA_TabCycle,                       TRUE,
                            INTEGER_MinVisible,                5 + 1,
                            INTEGER_Arrows,                    TRUE,
                            INTEGER_Minimum,                   0,
                            INTEGER_Maximum,                   32767,
                        IntegerEnd,
                    LayoutEnd,
                    CHILD_WeightedHeight,                      0,
                    AddVLayout,
                        LAYOUT_VertAlignment,                  LALIGN_CENTER,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "Props & Characters",
                        LocationButton(27),                    // gad 27, affects slot 38
                        Label("Travel car:"),
                        LocationButton(28),                    // gad 28, affects slot 39
                        Label("Transport tube:"),
                        // slots 40..49 are not used
                        LocationButton(29),                    // gad 29, affects slot 50
                        Label("Zud:"),
                        LocationButton(30),                    // gad 30, affects slot 51
                        Label("Arazok:"),
                        LocationButton(31),                    // gad 31, affects slot 52
                        Label("Giant snake:"),
                        // slots 53 ("ar") is not used
                        LocationButton(32),                    // gad 32, affects slot 54
                        Label("Wall panel:"),
                        LocationButton(33),                    // gad 33, affects slot 55
                        Label("Computer terminal:"),
                        LocationButton(34),                    // gad 34, affects slot 56
                        Label("Control panel:"),
                        LocationButton(35),                    // gad 35, affects slot 57
                        Label("Polished door:"),
                        LocationButton(36),                    // gad 36, affects slot 58
                        Label("Transport portal:"),
                        LocationButton(37),                    // gad 37, affects slot 59
                        Label("Ebony circle:"),
                        LocationButton(38),                    // gad 38, affects slot 60
                        Label("Red jewel:"),
                        // slots 61..63 are not used
                        LocationButton(39),                    // gad 39, affects slot 64
                        Label("Statue w/o jewels:"),
                        LocationButton(40),                    // gad 40, affects slot 65
                        Label("Statue w/ jewels:"),
                        LocationButton(41),                    // gad 41, affects slot 66
                        Label("Ramp:"),
                        LocationButton(42),                    // gad 42, affects slot 67
                        Label("Sign:"),
                        LocationButton(43),                    // gad 43, affects slot 68
                        Label("You:"),
                    LayoutEnd,
                    AddHLayout,
                        AddSpace,
                        AddFImage(FUNC_ARAZOK),
                        CHILD_WeightedWidth,                   0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedHeight,                      0,
                    MaximizeButton(GID_ARAZOK_BU1, "Maximize Game"),
                    CHILD_WeightedHeight,                      0,
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                     TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_ARAZOK_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_ARAZOK_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ARAZOK_IN1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void arazok_loop(ULONG gid, UNUSED ULONG code)
{   int i;

    switch (gid)
    {
    case GID_ARAZOK_BU1:
        readgadgets();

        hunger = moves = 0;
        for (i = 0; i <= 26; i++)
        {   itemloc[gad_to_slot[i]] = 0; // carried
        }

        writegadgets();
    adefault:
        if (gid >= GID_ARAZOK_BU2 && gid <= GID_ARAZOK_BU45)
        {   whichitem = gid - GID_ARAZOK_BU2;
            locationwindow();
}   }   }

EXPORT FLAG arazok_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_ARAZOK
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    for (i = 0; i < 44; i++)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_ARAZOK_BU2 + i], MainWindowPtr, NULL,
            GA_Text, LocationNames[itemloc[gad_to_slot[i]]],
        TAG_DONE); // this autorefreshes
}   }

MODULE void eithergadgets(void)
{   either_in(GID_ARAZOK_IN1, &hunger);
    either_in(GID_ARAZOK_IN2, &moves);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE int getpaddednumber(void)
{   int  i = 0;
    TEXT numbuffer[13 + 1];

    offset++; // skip leading space
    do
    {   numbuffer[i++] = IOBuffer[offset++];
    } while (IOBuffer[offset] != ' ');
    numbuffer[i] = EOS;
    offset++; // skip trailing space

    return atoi(numbuffer);
}
MODULE void putpaddednumber(int whichnum)
{   IOBuffer[offset++] = ' '; // put leading space
    offset += stcl_d((char*) &IOBuffer[offset], (long) whichnum);
    IOBuffer[offset++] = ' '; // put trailing space
}

MODULE int getcommanumber(void)
{   int  i = 0;
    TEXT numbuffer[13 + 1];

    do
    {   numbuffer[i++] = IOBuffer[offset++];
    } while (IOBuffer[offset] != ',');
    numbuffer[i] = EOS;
    offset++; // skip trailing comma

    return atoi(numbuffer);
}
MODULE void putcommanumber(int whichnum)
{   offset += stcl_d((char*) &IOBuffer[offset], (long) whichnum);
    IOBuffer[offset++] = ','; // put trailing comma
}

MODULE void serialize(void)
{   TRANSIENT int   i;
    PERSIST   LONG  preservesize;
    PERSIST   UBYTE PreserveBuffer[512];

    offset = 0;

    if (serializemode == SERIALIZE_READ)
    {   for (i = 0; i < 68; i++)
        {   itemloc[i] = getpaddednumber();
            if (itemloc[i] == 50) itemloc[i] = 47;
        }
        for (i = 0; i < 17; i++)
        {   commanum[i] = getcommanumber();
        }
        itemloc[68] = commanum[ 0];
        hunger      = commanum[15];
        moves       = commanum[16];
        preservesize = gamesize - offset;
        for (i = 0; i < preservesize; i++)
        {   PreserveBuffer[i] = IOBuffer[offset++];
    }   }
    else
    {   // assert(serializemode == SERIALIZE_WRITE);
        for (i = 0; i < 68; i++)
        {   if (itemloc[i] == 47) itemloc[i] = 50;
            putpaddednumber(itemloc[i]);
            if (itemloc[i] == 50) itemloc[i] = 47;
        }
        commanum[ 0] = itemloc[68];
        commanum[15] = hunger;
        commanum[16] = moves;
        for (i = 0; i < 17; i++)
        {   putcommanumber(commanum[i]);
        }
        for (i = 0; i < preservesize; i++)
        {   IOBuffer[offset++] = PreserveBuffer[i];
        }
        gamesize = offset;
}   }

EXPORT void arazok_save(FLAG saveas)
{   TRANSIENT FLAG  matched;
    TRANSIENT int   i,
                    tomboffset;
    TRANSIENT LONG  tombsize;
    TRANSIENT BPTR  FileHandle /* = ZERO */ ;
    PERSIST   TEXT  filepart[MAX_PATH + 1],
                    tombpathname[MAX_PATH + 1],
                    tombstring[80 + 1];
    PERSIST   UBYTE TombBuffer[2048 + 1];

    readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    if (!gamesave("#?.GAM", "Arazok's Tomb", saveas, gamesize, FLAG_S, TRUE))
    {   return;
    }

    zstrncpy(tombpathname, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
    if (!AddPart(tombpathname, "TOMB", MAX_PATH))
    {   // printf("Error 1 on file %s!\n", tombpathname);
        // maybe we should warn the user
        return;
    }
    tombsize = getsize(tombpathname);
    if (!(FileHandle = (BPTR) Open(tombpathname, MODE_OLDFILE)))
    {   printf("Error 2 on file %s!\n", tombpathname);
        return;
    }
    if (Read(FileHandle, TombBuffer, (LONG) tombsize) != tombsize)
    {   DISCARD Close(FileHandle);
        // FileHandle = ZERO;
        printf("Error 3 on file %s!\n", tombpathname);
        return;
    }
    DISCARD Close(FileHandle);
    // FileHandle = ZERO;

    strcpy(filepart, FilePart(pathname));
    filepart[strlen(filepart) - 4] = EOS; // to chop off ".GAM" suffix

    if (strncmp((char*) TombBuffer, "\"start\"\n\"", 9))
    {   printf("Error 4 on file %s!\n", tombpathname);
        return;
    }
    matched = FALSE;
    tomboffset = 0;
    while (tomboffset < tombsize)
    {   if (TombBuffer[tomboffset] != '\"')
        {   printf("Error 5 on file %s!\n", tombpathname);
            return;
        }
        tomboffset++; // skip first quote
        i = 0;
        while (TombBuffer[tomboffset] != '\"')
        {   tombstring[i++] = TombBuffer[tomboffset++];
        }
        tombstring[i] = EOS;
        if (!stricmp(filepart, tombstring))
        {   matched = TRUE;
        }
        tomboffset++; // skip second quote
        if (TombBuffer[tomboffset] != LF)
        {   printf("Error 6 on file %s!\n", tombpathname);
            return;
        }
        tomboffset++; // skip LF
    }

    if (!matched)
    {   if (!(FileHandle = (BPTR) Open(tombpathname, MODE_NEWFILE)))
        {   printf("Error 7 on file %s!\n", tombpathname);
            return;
        }
        DISCARD Write(FileHandle, TombBuffer,   tombsize - 2); // could just seek instead
        DISCARD Write(FileHandle, filepart,     strlen(filepart));
        DISCARD Write(FileHandle, "\"\n\"\"\n", 5);
        DISCARD Close(FileHandle);
        // FileHandle = ZERO;
    }

    say("Saved files.", REQIMAGE_INFO);
}

EXPORT void arazok_close(void) { ; }
EXPORT void arazok_exit(void)  { ; }

MODULE void locationwindow(void)
{   TEXT hailstring[60 + 1];
    FLAG carryable;
 // int  i;

    over = -2;
    sprintf(hailstring, "Choose Location of %s", ItemNames[whichitem]);

    if (whichitem <= 26)
    {   carryable = TRUE;
    } else
    {   carryable = FALSE;
    }

    load_images(454, 499);

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              hailstring,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_GadgetHelp,                     TRUE,
     // WINDOW_HintInfo,                       &ts_hintinfo,
        WINDOW_UniqueID,                       "arazok-1",
        WINDOW_ParentGroup,                    gadgets[GID_ARAZOK_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            AddHLayout,
                AddLocation( 0),
                AddLocation( 1),
                AddLocation( 2),
                AddLocation( 3),
                AddLocation( 4),
                AddLocation( 5),
                AddLocation( 6),
            LayoutEnd,
            AddHLayout,
                AddLocation( 7),
                AddLocation( 8),
                AddLocation( 9),
                AddLocation(10),
                AddLocation(11),
                AddLocation(12),
                AddLocation(13),
            LayoutEnd,
            AddHLayout,
                AddLocation(14),
                AddLocation(15),
                AddLocation(16),
                AddLocation(17),
                AddLocation(18),
                AddLocation(19),
                AddLocation(20),
            LayoutEnd,
            AddHLayout,
                AddLocation(21),
                AddLocation(22),
                AddLocation(23),
                AddLocation(24),
                AddLocation(25),
                AddLocation(26),
                AddLocation(27),
            LayoutEnd,
            AddHLayout,
                AddLocation(28),
                AddLocation(29),
                AddLocation(30),
                AddLocation(31),
                AddLocation(32),
                AddLocation(33),
                AddLocation(34),
            LayoutEnd,
            AddHLayout,
                AddLocation(35),
                AddLocation(36),
                AddLocation(37),
                AddLocation(38),
                AddLocation(39),
                AddLocation(40),
                AddLocation(41),
            LayoutEnd,
            AddHLayout,
                AddSpace,
                AddLocation(42),
                CHILD_WeightedWidth,           0,
                AddLocation(43),
                CHILD_WeightedWidth,           0,
                AddLocation(44),
                CHILD_WeightedWidth,           0,
                AddLocation(45),
                CHILD_WeightedWidth,           0,
                AddSpace,
            LayoutEnd,
            AddLabel(""),
            LAYOUT_AddChild,                   gadgets[GID_ARAZOK_ST1] = (struct Gadget*)
            StringObject,
                GA_ID,                         GID_ARAZOK_ST1,
                GA_ReadOnly,                   TRUE,
                STRINGA_TextVal,               "-",
            StringEnd,
            CHILD_WeightedHeight,              0,
            AddHLayout,
                LAYOUT_AddChild,               gadgets[GID_ARAZOK_BU46] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                     GID_ARAZOK_BU46,
                    GA_Text,                   "Carried",
                    GA_RelVerify,              TRUE,
                    GA_Disabled,               carryable ? FALSE : TRUE,
                    GA_Selected,               (itemloc[gad_to_slot[whichitem]] == CARRIED) ? TRUE : FALSE,
                ButtonEnd,
                LAYOUT_AddChild,               gadgets[GID_ARAZOK_BU47] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                     GID_ARAZOK_BU47,
                    GA_Text,                   "Nowhere",
                    GA_RelVerify,              TRUE,
                    GA_Disabled,               (whichitem == YOU) ? TRUE : FALSE,
                    GA_Selected,               (itemloc[gad_to_slot[whichitem]] == NOWHERE) ? TRUE : FALSE,
                ButtonEnd,
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }

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

EXPORT FLAG arazok_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_ARAZOK_BU46:
        // assert(carryable);
        itemloc[gad_to_slot[whichitem]] = CARRIED;

        DISCARD SetGadgetAttrs
        (   gadgets[GID_ARAZOK_BU2 + whichitem], MainWindowPtr, NULL,
            GA_Text, LocationNames[itemloc[gad_to_slot[whichitem]]],
        TAG_DONE); // this autorefreshes

        return TRUE;
    acase GID_ARAZOK_BU47:
        assert(whichitem != YOU);
        itemloc[gad_to_slot[whichitem]] = NOWHERE;

        DISCARD SetGadgetAttrs
        (   gadgets[GID_ARAZOK_BU2 + whichitem], MainWindowPtr, NULL,
            GA_Text, LocationNames[itemloc[gad_to_slot[whichitem]]],
        TAG_DONE); // this autorefreshes

        return TRUE;
    adefault:
        if (gid >= GID_ARAZOK_BU48 && gid <= GID_ARAZOK_BU93)
        {   itemloc[gad_to_slot[whichitem]] = gid - GID_ARAZOK_BU48 + 1;

            DISCARD SetGadgetAttrs
            (   gadgets[GID_ARAZOK_BU2 + whichitem], MainWindowPtr, NULL,
                GA_Text, LocationNames[itemloc[gad_to_slot[whichitem]]],
            TAG_DONE); // this autorefreshes

            return TRUE;
    }   }

    return FALSE;
}

EXPORT void arazok_subtick(SWORD mousex, SWORD mousey)
{   int i,
        newover = -1;

    if (!SubWindowPtr)
    {   return;
    }

    for (i = 0; i < 46; i++)
    {   if
        (   mousex >= gadgets[GID_ARAZOK_BU48 + i]->LeftEdge
         && mousex <= gadgets[GID_ARAZOK_BU48 + i]->LeftEdge + gadgets[GID_ARAZOK_BU48 + i]->Width  - 1
         && mousey >= gadgets[GID_ARAZOK_BU48 + i]->TopEdge
         && mousey <= gadgets[GID_ARAZOK_BU48 + i]->TopEdge  + gadgets[GID_ARAZOK_BU48 + i]->Height - 1
        )
        {   newover = i;
            break; // for speed
    }   }

    if (newover != over)
    {   over = newover;
        DISCARD SetGadgetAttrs
        (   gadgets[GID_ARAZOK_ST1], SubWindowPtr, NULL,
            STRINGA_TextVal, (over == -1) ? (STRPTR) "Hover over a button for more information." : LocationNames[over + 1],
        TAG_DONE);
}   }

EXPORT FLAG arazok_subkey(UWORD code)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    }

    return FALSE;
}

EXPORT void arazok_getpens(void)
{   lockscreen();

    pens[0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1);

    unlockscreen();
}

EXPORT void arazok_uniconify(void)
{   arazok_getpens();
}

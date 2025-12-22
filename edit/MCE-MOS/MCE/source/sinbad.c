// 1.  INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #ifndef __USE_INLINE__
        #define __USE_INLINE__ // define this as early as possible
    #endif
#endif
#ifdef __LCLINT__
    typedef char * STRPTR;
    typedef char * CONST_STRPTR;
    typedef char   TEXT;
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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#ifdef LATTICE
    #include <dos.h>
#endif

#include "mce.h"

// 2. DEFINES ------------------------------------------------------------

// main window
#define GID_SB_LY1    0 // root layout
#define GID_SB_SB1    1 // toolbar
#define GID_SB_IN1    2 // idol eyes
#define GID_SB_IN2    3 // men on land
#define GID_SB_IN3    4 // men on ship
#define GID_SB_IN4    5 // 1st army strength
#define GID_SB_IN5    6
#define GID_SB_IN6    7
#define GID_SB_IN7    8
#define GID_SB_IN8    9
#define GID_SB_IN9   10
#define GID_SB_IN10  11
#define GID_SB_IN11  12
#define GID_SB_IN12  13
#define GID_SB_IN13  14 // 10th army strength
#define GID_SB_BU1   15 // maximize
#define GID_SB_BU2   16 // 1st location
#define GID_SB_BU3   17
#define GID_SB_BU4   18
#define GID_SB_BU5   19
#define GID_SB_BU6   20
#define GID_SB_BU7   21
#define GID_SB_BU8   22
#define GID_SB_BU9   23
#define GID_SB_BU10  24
#define GID_SB_BU11  25
#define GID_SB_BU12  26
#define GID_SB_BU13  27
#define GID_SB_BU14  28
#define GID_SB_BU15  29
#define GID_SB_BU16  30
#define GID_SB_BU17  31 // 16th location

// location subwindow
#define GID_SB_LY2   32
#define GID_SB_LB1   33

#define GIDS_SB      GID_SB_LB1

#define PEOPLE            16
#define LOCATIONS         0x59
#define LocationButton(x) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) ZButtonObject, GA_ID, x, GA_RelVerify, TRUE, BUTTON_Justification, BCJ_LEFT, ButtonEnd
#define StrengthButton(x) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) IntegerObject, GA_ID, x, GA_TabCycle,  TRUE, INTEGER_Minimum,      0,        INTEGER_Maximum, 99, INTEGER_Number, strength[x - GID_SB_IN4], INTEGER_MinVisible, 2 + 1, IntegerEnd

#define BLACK             0
#define GREEN             1
#define BLUE              2
#define YELLOW            3
#define LIGHTGREEN        4
#define LIGHTBLUE         5
#define LIGHTYELLOW       6

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(void);
MODULE void eithergadgets(void);
MODULE void locationwindow(void);

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
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *aissimage[AISSIMAGES],
                           *image[BITMAPS],
                           *WinObject,
                           *SubWinObject;

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                eyes,
                            location[PEOPLE],
                            menonland,
                            menonship,
                            strength[10];
MODULE TEXT                 locationdisplay[PEOPLE][40 + 1];
MODULE int                  whichman;
MODULE struct List          LocationList;

MODULE struct
{   const STRPTR name;
    const UBYTE  colour;
} world[LOCATIONS] = {
{ "Abe Sound",                BLUE  }, // $00
{ "Agnis Island",             YELLOW}, // $01
{ "Agor",                     YELLOW}, // $02
{ "Akha's Sea",               BLUE  }, // $03
{ "Ajis",                     GREEN }, // $04
{ "Akisis",                   YELLOW}, // $05
{ "Alkrais",                  GREEN }, // $06
{ "Allapogos Forest, The",    GREEN }, // $07
{ "Allosa",                   GREEN }, // $08
{ "Ardalus Bay",              BLUE  }, // $09
{ "Arghalius Landing",        YELLOW}, // $0A
{ "Arnath",                   GREEN }, // $0B
{ "Atic Island",              YELLOW}, // $0C
{ "Aughyd",                   YELLOW}, // $0D
{ "Bay of Conat",             BLUE  }, // $0E
{ "Bocca",                    GREEN }, // $0F
{ "Cape of Tears, The",       BLUE  }, // $10
{ "Caul",                     GREEN }, // $11
{ "Chaloka",                  YELLOW}, // $12
{ "Chanasta",                 GREEN }, // $13
{ "Chustakis",                GREEN }, // $14
{ "Conat",                    YELLOW}, // $15
{ "Corlis Shoal",             BLUE  }, // $16
{ "Cray's Channel",           BLUE  }, // $17
{ "Cryr",                     GREEN }, // $18
{ "Damaron",                  YELLOW}, // $19
{ "Dendri Bay",               BLUE  }, // $1A
{ "Donis Bay",                BLUE  }, // $1B
{ "Dragon's Mouth, The",      BLUE  }, // $1C
{ "Eka Isle",                 YELLOW}, // $1D
{ "El Shad",                  GREEN }, // $1E
{ "Etich Island",             YELLOW}, // $1F
{ "Fanis Shore",              YELLOW}, // $20
{ "Ghoti",                    YELLOW}, // $21
{ "Ghotin Channel",           BLUE  }, // $22
{ "Isk Bay",                  BLUE  }, // $23
{ "Ivich Isle",               YELLOW}, // $24
{ "Kaerngaard",               GREEN }, // $25
{ "Kail",                     YELLOW}, // $26
{ "Kananuk",                  GREEN }, // $27
{ "Khax Bay",                 BLUE  }, // $28
{ "Konis Isle",               YELLOW}, // $29
{ "Korlish",                  GREEN }, // $2A
{ "Lismit Bay",               BLUE  }, // $2B
{ "Llortl",                   GREEN }, // $2C
{ "Nissi",                    GREEN }, // $2D
{ "Nonestic Ocean, The",      BLUE  }, // $2E
{ "Norgor",                   GREEN }, // $2F
{ "Oknos Landing",            YELLOW}, // $30
{ "Okyros Sea",               BLUE  }, // $31
{ "Ono",                      YELLOW}, // $32
{ "Ootsinian Peninsula, The", GREEN }, // $33
{ "Orgy Island",              YELLOW}, // $34 ;-)
{ "Orphania",                 GREEN }, // $35
{ "Parmalus Bay",             BLUE  }, // $36
{ "Pele Shoals",              BLUE  }, // $37
{ "Pele",                     YELLOW}, // $38
{ "Pert Sea, The",            BLUE  }, // $39
{ "Pofi Bay",                 BLUE  }, // $3A
{ "Pona",                     GREEN }, // $3B
{ "Ritchie Reef",             YELLOW}, // $3C
{ "Sea of Kernighan",         BLUE  }, // $3D
{ "Sea of Mists, The",        BLUE  }, // $3E
{ "Sea of Trents, The",       BLUE  }, // $3F
{ "Sikhimit's Sea",           BLUE  }, // $40
{ "Simit",                    GREEN }, // $41
{ "Skisen",                   YELLOW}, // $42
{ "Stem's Sound",             BLUE  }, // $43
{ "Straits of Damaron, The",  BLUE  }, // $44
{ "Tanastic Currents",        BLUE  }, // $45
{ "Tanis",                    YELLOW}, // $46
{ "Tapasta",                  GREEN }, // $47
{ "Tarkis Bay",               BLUE  }, // $48
{ "Thaktarkis",               GREEN }, // $49
{ "The Moquis",               GREEN }, // $4A
{ "Thyka",                    GREEN }, // $4B
{ "Tim Bay",                  BLUE  }, // $4C
{ "Timon",                    GREEN }, // $4D
{ "Tiw Island",               YELLOW}, // $4E
{ "Tojo Isle",                YELLOW}, // $4F
{ "Torquari Moors, The",      GREEN }, // $50
{ "Tor's Break",              BLUE  }, // $51
{ "Towu Point",               GREEN }, // $52
{ "Vies Sound",               BLUE  }, // $53
{ "Voli Island",              YELLOW}, // $54
{ "Wan",                      GREEN }, // $55
{ "Xoltan Shore",             YELLOW}, // $56
{ "Yolovos Bay",              BLUE  }, // $57
{ "Zaftia",                   GREEN }, // $58
// no NULL is required
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void sb_main(void)
{   TRANSIENT int          i;
    TRANSIENT struct Node* ListBrowserNodePtr;
    PERSIST   FLAG         first = TRUE;

    if (first)
    {   first = FALSE;

        // sb_preinit()
        NewList(&LocationList);

        // sb_init()
        sb_getpens();
        for (i = 0; i < LOCATIONS; i++)
        {   if (!(ListBrowserNodePtr = (struct Node*) AllocListBrowserNode
            (   1,              /* columns, */
                LBNA_Column,    0,
                LBNA_Flags,     LBFLG_CUSTOMPENS,
                LBNCA_FGPen,    pens[BLACK],
                LBNCA_BGPen,    pens[world[i].colour    ],
                LBNCA_FillPen,  pens[world[i].colour + 3],
                LBNCA_CopyText, TRUE,
                LBNCA_Text,     world[i].name,
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&LocationList, ListBrowserNodePtr); /* AddTail() has no return code */
    }   }

    tool_open      = sb_open;
    tool_loop      = sb_loop;
    tool_save      = sb_save;
    tool_close     = sb_close;
    tool_exit      = sb_exit;
    tool_subgadget = sb_subgadget;

    if (loaded != FUNC_SINBAD && !sb_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_SINBAD;

    make_speedbar_list(GID_SB_SB1);
    load_aiss_images(10, 10);
    sb_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_SB_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddToolbar(GID_SB_SB1),
            AddHLayout,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "General",
                        LAYOUT_AddChild,                   gadgets[GID_SB_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_SB_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               3,
                            INTEGER_Number,                eyes,
                            INTEGER_MinVisible,            1 + 1,
                        IntegerEnd,
                        Label("Idol Eyes:"),
                        LAYOUT_AddChild,                   gadgets[GID_SB_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_SB_IN2,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                menonland,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Men on land:"),
                        LAYOUT_AddChild,                   gadgets[GID_SB_IN3] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_SB_IN3,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                menonship,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Men on ship:"),
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "Army Strengths",
                        StrengthButton(GID_SB_IN4),
                        Label("A:"),
                        StrengthButton(GID_SB_IN5),
                        Label("B:"),
                        StrengthButton(GID_SB_IN6),
                        Label("C:"),
                        StrengthButton(GID_SB_IN7),
                        Label("D:"),
                        StrengthButton(GID_SB_IN8),
                        Label("E:"),
                        StrengthButton(GID_SB_IN9),
                        Label("F:"),
                        StrengthButton(GID_SB_IN10),
                        Label("G:"),
                        StrengthButton(GID_SB_IN11),
                        Label("H:"),
                        StrengthButton(GID_SB_IN12),
                        Label("I:"),
                        StrengthButton(GID_SB_IN13),
                        Label("J:"),
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "Locations",
                    LocationButton(GID_SB_BU2),
                    Label("Black Panther:"),
                    LocationButton(GID_SB_BU3),
                    Label("Camaral:"),
                    LocationButton(GID_SB_BU4),
                    Label("Cyclops Darpa:"),
                    LocationButton(GID_SB_BU5),
                    Label("Cyclops Ghent:"),
                    LocationButton(GID_SB_BU6),
                    Label("Cyclops Tor-Ghar:"),
                    LocationButton(GID_SB_BU7),
                    Label("Demon Lynx:"),
                    LocationButton(GID_SB_BU8),
                    Label("Genie:"),
                    LocationButton(GID_SB_BU9),
                    Label("Great Lion:"),
                    LocationButton(GID_SB_BU10),
                    Label("Gypsy:"),
                    LocationButton(GID_SB_BU11),
                    Label("Harun:"),
                    LocationButton(GID_SB_BU12),
                    Label("Libitina:"),
                    LocationButton(GID_SB_BU13),
                    Label("Roc Ghaax:"),
                    LocationButton(GID_SB_BU14),
                    Label("Sabaralus (ship):"),
                    LocationButton(GID_SB_BU15),
                    Label("Shaman:"),
                    LocationButton(GID_SB_BU16),
                    Label("Sinbad (you):"),
                    LocationButton(GID_SB_BU17),
                    Label("Sylphani:"),
                LayoutEnd,
                CHILD_MinWidth,                            256,
            LayoutEnd,
            MaximizeButton(GID_SB_BU1, "Maximize Game"),
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_SB_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_SB_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_SB_IN1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void sb_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_SB_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    adefault:
        if (gid >= GID_SB_BU2 && gid <= GID_SB_BU17)
        {   whichman = gid - GID_SB_BU2;
            locationwindow();
}   }   }

EXPORT FLAG sb_open(FLAG loadas)
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
    (   page != FUNC_SINBAD
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    if (gadmode == SERIALIZE_WRITE)
    {   for (i = 0; i < PEOPLE; i++)
        {   strcpy(locationdisplay[i], world[location[i]].name);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_SB_BU2 + i], MainWindowPtr, NULL,
                GA_Text, locationdisplay[i],
                BUTTON_BackgroundPen, pens[world[location[i]].colour],
            TAG_DONE); // this autorefreshes
    }   }

    either_in(GID_SB_IN1, &eyes);
    either_in(GID_SB_IN2, &menonland);
    either_in(GID_SB_IN3, &menonship);
    for (i = 0; i < 10; i++)
    {    either_in(GID_SB_IN4 + i, &strength[i]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    offset = 0x39E; serialize1(&location[12]); // Sabaralus
                    serialize1(&location[14]); // Sinbad
                    serialize1(&location[15]); // Sylphani
                    serialize1(&location[ 9]); // Harun
                    serialize1(&location[10]); // Libitina
    offset = 0x3A5; serialize1(&location[ 1]); // Camaral
                    serialize1(&location[ 8]); // Gypsy
                    serialize1(&location[13]); // Shaman
                    serialize1(&location[ 6]); // Genie
    offset = 0x3AA; serialize1(&location[11]); // Roc Ghaax
    offset = 0x3AC; serialize1(&location[ 3]); // Cyclops Ghent
                    serialize1(&location[ 4]); // Cyclops Tor-Ghar
                    serialize1(&location[ 2]); // Cyclops Darpa
    offset = 0x3B0; serialize1(&location[ 5]); // Demon Lynx
                    serialize1(&location[ 0]); // Black Panther
                    serialize1(&location[ 7]); // Great Lion

    offset = 0x42E; serialize1(&menonship);
                    serialize1(&menonland);

    offset = 0x454; for (i = 0; i < 10; i++)
                    {   serialize1(&strength[i]); // $454..$45D
                    }

    offset = 0x47B; serialize1(&eyes);
}

EXPORT void sb_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?", "Sinbad", saveas, 1248, FLAG_S, FALSE);
}

EXPORT void sb_die(void)
{   lb_clearlist(&LocationList);
}

EXPORT void sb_close(void) { ; }
EXPORT void sb_exit(void)  { ; }

EXPORT void sb_getpens(void)
{   lockscreen();

    pens[     BLACK ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1);
    pens[     BLUE  ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x44444444, 0x44444444, 0xFFFFFFFF, -1);
    pens[     GREEN ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x88888888, 0x00000000, -1);
    pens[     YELLOW] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xCCCCCCCC, 0xCCCCCCCC, 0x00000000, -1);
    pens[LIGHTBLUE  ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0xFFFFFFFF, -1);
    pens[LIGHTGREEN ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xFFFFFFFF, 0x00000000, -1);
    pens[LIGHTYELLOW] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0x44444444, -1);

    unlockscreen();
}

MODULE void maximize_man(void)
{   int i;

    eyes      = 3;
    menonland =
    menonship = 80; // any more get washed overboard
    for (i = 0; i < 10; i++)
    {   strength[i] = 90;
}   }

MODULE void locationwindow(void)
{   InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              "Choose Location",
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "sinbad-1",
        WINDOW_ParentGroup,                    gadgets[GID_SB_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_SB_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_SB_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &LocationList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    256,
            CHILD_MinHeight,                   384 - 72,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window *) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubWindowPtr->Width, SubWindowPtr->Height);
#endif

    DISCARD SetGadgetAttrs(          gadgets[GID_SB_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,              ~0,                 TAG_END);
    DISCARD SetGadgetAttrs(          gadgets[GID_SB_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,              &LocationList,      TAG_END);
    DISCARD SetGadgetAttrs(          gadgets[GID_SB_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) location[whichman], TAG_END);
    RefreshGadgets((struct Gadget *) gadgets[GID_SB_LB1], SubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(          gadgets[GID_SB_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) location[whichman], TAG_END);
    RefreshGadgets((struct Gadget *) gadgets[GID_SB_LB1], SubWindowPtr, NULL);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG sb_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_SB_LB1:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_SB_LB1], (ULONG *) &location[whichman]);
        writegadgets();
        return TRUE;
    }

    return FALSE;
}

EXPORT FLAG sb_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        lb_scroll_up(GID_SB_LB1, SubWindowPtr, qual);
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_scroll_down(GID_SB_LB1, SubWindowPtr, qual);
    }

    return FALSE;
}

EXPORT void sb_uniconify(void)
{   sb_getpens();
    writegadgets(); // so that buttons are correct colours
}

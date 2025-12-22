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

#define GID_TVS_LY1    0 // root layout
#define GID_TVS_SB1    1 // toolbar
#define GID_TVS_ST1    2 // long  team name
#define GID_TVS_ST2    3 // short team name
#define GID_TVS_ST3    4 // mascot name
#define GID_TVS_BU1    5 //  1st team
#define GID_TVS_BU28  34 // 28th team
#define GID_TVS_BU29  35 // maximize team
#define GID_TVS_CH1   36 // game
#define GID_TVS_CH2   37 // owner
#define GID_TVS_LB1   38 // attributes
#define GID_TVS_PL1   39 // away colours
#define GIDS_TVS     GID_TVS_PL1

#define AddTeam(x)                                                  \
LAYOUT_AddChild,        gadgets[GID_TVS_BU1 + x] = (struct Gadget*) \
ZButtonObject,                                                      \
    GA_ID,              GID_TVS_BU1 + x,                            \
    GA_TabCycle,        TRUE,                                       \
    GA_RelVerify,       TRUE,                                       \
    GA_Text,            teamname_long[x],                           \
    BUTTON_PushButton,  TRUE,                                       \
ButtonEnd

#define BASEBALL   0
#define BASKETBALL 1
#define BOXING     2
#define FOOTBALL   3

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(FLAG full);
MODULE void serialize(void);
MODULE void eithergadgets(FLAG full);
MODULE void maximize_team(void);
MODULE void makemenlist(FLAG full);
MODULE void padspaces(STRPTR thestring, int numchars);
MODULE void remspaces(STRPTR thestring, int numchars);

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
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE UBYTE                hand[7][10],
                            iq[7][10],
                            style[7][10];
MODULE ULONG                age[7][10],
                            colour[28],
                            game,
                            height[7][10],
                            number[28][13],
                            owner[28],
                            pp[7][10][3],
                            reach[7][10],
                            sortcolumn,
                            stat[28][25][11],
                            team          = 0,
                            weight[7][10];
MODULE TEXT                 homename[7][10][16 + 1],
                            playername[28][25][17 + 1],
                            teamname_long[28][19 + 1], // enough for "Amiga Careerists #1"
                            teamname_short[28][4 + 1],
                            mascot[28][10 + 1],
                            SEAS_Buffer[21948],
                            SEAS_Pathname[MAX_PATH + 1];
MODULE       struct List    MenList;
MODULE const int            seas_size[4]  = { 0, 21948, 0, 14998 };
MODULE struct ColumnInfo*   ColumnInfoPtr = NULL;

#ifndef __amigaos4__
MODULE struct ColumnInfo BaseballColumnInfo[] =
{ { 0,
    "Position",
    CIF_WEIGHTED | CIF_SORTABLE
  },
  { 0,                 /* WORD   ci_Width */
    "Name",            /* STRPTR ci_Title */
    CIF_WEIGHTED | CIF_SORTABLE | CIF_DRAGGABLE,
  },
  { 0,
    "Bunt/Curve",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Speed/Skill",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Arm/Fatigue",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Def/Hitting",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE
  },
  { -1,
    (STRPTR) ~0,
    -1
} }, BasketballColumnInfo[] =
{ { 0,
    "Position",
    CIF_WEIGHTED | CIF_SORTABLE
  },
  { 0,                 /* WORD   ci_Width */
    "Name",            /* STRPTR ci_Title */
    CIF_WEIGHTED | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "No.",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE
  },
  { 0,
    "Height",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Shooting",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Passing",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Defence",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Rebounding",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Quickness",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Jumping",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Stamina",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Release",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Arc",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Velocity",
    CIF_WEIGHTED | CIF_RIGHT | CIF_SORTABLE
  },
  { -1,
    (STRPTR) ~0,
    -1
} }, BoxingColumnInfo[] =
{ { 0,
    "H",
    CIF_WEIGHTED | CIF_SORTABLE
  },
  { 0,                 /* WORD   ci_Width */
    "Name",            /* STRPTR ci_Title */
    CIF_WEIGHTED | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,                 /* WORD   ci_Width */
    "Hometown",        /* STRPTR ci_Title */
    CIF_WEIGHTED | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Stamina",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Power",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Defence",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Chin",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Body",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Ftwrk",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "HndSpd",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Cuts",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Instnct",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Cndtng",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Jab",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Hook",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Uprct",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Age",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Ht",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Wt",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Rch",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Style",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Intlgnce",
    CIF_WEIGHTED | CIF_SORTABLE
  },
  { -1,
    (STRPTR) ~0,
    -1
} }, FootballColumnInfo[] =
{ { 0,
    "Position",
    CIF_WEIGHTED | CIF_SORTABLE
  },
  { 0,                 /* WORD   ci_Width */
    "Name",            /* STRPTR ci_Title */
    CIF_WEIGHTED | CIF_SORTABLE | CIF_DRAGGABLE
  },
  { 0,
    "Speed",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Strength",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Handling",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT | CIF_DRAGGABLE
  },
  { 0,
    "Ability",
    CIF_WEIGHTED | CIF_SORTABLE | CIF_RIGHT
  },
  { -1,
    (STRPTR) ~0,
    -1
} };
#endif

MODULE const STRPTR BaseballPosition[25] =
{ "1st base #1",
  "1st base #2",
  "2nd base #1",
  "2nd base #2",
  "Short stop #1",
  "Short stop #2",
  "3rd base #1",
  "3rd base #2",
  "Left field #1",
  "Left field #2",
  "Centre field #1",
  "Centre field #2",
  "Right field #1",
  "Right field #2",
  "Catcher #1",
  "Catcher #2",
  "Pitcher #1",
  "Pitcher #2",
  "Pitcher #3",
  "Pitcher #4",
  "Pitcher #5",
  "Pitcher #6",
  "Pitcher #7",
  "Pitcher #8",
  "Pitcher #9"
}, BasketballPosition[13] =
{ "Guard #1",
  "Guard #2",
  "Guard #3",
  "Guard #4",
  "Guard #5",
  "Forward #1",
  "Forward #2",
  "Forward #3",
  "Forward #4",
  "Forward #5",
  "Centre #1",
  "Centre #2",
  "Coach"
}, FootballPosition[18] =
{ "Quarterback",
  "Left halfback",
  "Right halfback",
  "Fullback",
  "Left wide receiver",
  "Right wide receiver",
  "Left inside linebacker",
  "Right inside linebacker",
  "Left outside linebacker",
  "Right outside linebacker",
  "Left cornerback",
  "Right cornerback",
  "Left safety",
  "Right safety",
  "Punter",
  "Kicker",
  "Defensive line",
  "Offensive line"
}, StyleOptions[4] =
{ "Brawler",
  "Boxer",
  "Dancer",
  "Dodger",
}, IQOptions[5] =
{ "Brilliant",
  "Smart",
  "Average",
  "Dumb",
  "Very dumb"
}, NumberOptions[37] =
{ "00", //  0 (in file)
  " 0", //  1
  " 1", //  2
  " 2", //  3
  " 3", //  4
  " 4", //  5
  " 5", //  6
  "10", //  7
  "11", //  8
  "12", //  9
  "13", // 10
  "14", // 11
  "15", // 12
  "20", // 13
  "21", // 14
  "22", // 15
  "23", // 16
  "24", // 17
  "25", // 18
  "30", // 19
  "31", // 20
  "32", // 21
  "33", // 22
  "34", // 23
  "35", // 24
  "40", // 25
  "41", // 26
  "42", // 27
  "43", // 28
  "44", // 29
  "45", // 30
  "50", // 31
  "51", // 32
  "52", // 33
  "53", // 34
  "54", // 35
  "55", // 36 (in file)
}, GameOptions[4 + 1] =
{ "TV Sports Baseball",
  "TV Sports Basketball",
  "TV Sports Boxing",
  "TV Sports Football",
  NULL
}, OwnerOptions[2 + 1] =
{ "Human",
  "Amiga",
  NULL
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void tvs_main(void)
{   TRANSIENT       int   i;
    TRANSIENT const int   minvis[3] = { 25, 13, 18 };
    PERSIST         FLAG  first     = TRUE;
    PERSIST         UWORD colourtable[6]; // this must stay valid!

    if (first)
    {   first = FALSE;

        // tvs_preinit()
        NewList(&MenList);
    }

    tool_open  = tvs_open;
    tool_loop  = tvs_loop;
    tool_save  = tvs_save;
    tool_close = tvs_close;
    tool_exit  = tvs_exit;

    if (loaded != FUNC_TVS && !tvs_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_TVS;

    tvs_getpens();
    for (i = 0; i < 6; i++)
    {   colourtable[i] = pens[i];
    }
    make_speedbar_list(GID_TVS_SB1);
    load_aiss_images(10, 10);
    makemenlist(TRUE);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   SPECIALWPOS,
        WINDOW_ParentGroup,                                gadgets[GID_TVS_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            AddHLayout,
                AddToolbar(GID_TVS_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_TVS_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_TVS_CH1,
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
            AddHLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Choose Team",
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "NL West/West/NFC #1",
                    AddTeam(0),
                    AddTeam(1),
                    AddTeam(2),
                    AddTeam(3),
                    AddTeam(4),
                    AddTeam(5),
                    AddTeam(6),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "NL East/West/NFC #2",
                    AddTeam(7),
                    AddTeam(8),
                    AddTeam(9),
                    AddTeam(10),
                    AddTeam(11),
                    AddTeam(12),
                    AddTeam(13),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "AL West/East/AFC #1",
                    AddTeam(14),
                    AddTeam(15),
                    AddTeam(16),
                    AddTeam(17),
                    AddTeam(18),
                    AddTeam(19),
                    AddTeam(20),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "AL East/East/AFC #2",
                    AddTeam(21),
                    AddTeam(22),
                    AddTeam(23),
                    AddTeam(24),
                    AddTeam(25),
                    AddTeam(26),
                    AddTeam(27),
                LayoutEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Edit Chosen Team",
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    AddLabel("Long team name:"),
                    LAYOUT_AddChild,                       gadgets[GID_TVS_ST1] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_TVS_ST1,
                        GA_TabCycle,                       TRUE,
                        GA_RelVerify,                      TRUE,
                        STRINGA_TextVal,                   teamname_long[team],
                        STRINGA_MaxChars,                  19 + 1,
                        STRINGA_MinVisible,                13 + stringextra,
                    StringEnd,
                    AddLabel("Short team name:"),
                    LAYOUT_AddChild,                       gadgets[GID_TVS_ST2] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_TVS_ST2,
                        GA_TabCycle,                       TRUE,
                        GA_RelVerify,                      TRUE,
                        STRINGA_TextVal,                   teamname_short[team],
                        STRINGA_MaxChars,                  4 + 1,
                        STRINGA_MinVisible,                4 + stringextra,
                    StringEnd,
                    CHILD_WeightedWidth,                   0,
                    AddLabel("Mascot:"),
                    LAYOUT_AddChild,                       gadgets[GID_TVS_ST3] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_TVS_ST3,
                        GA_TabCycle,                       TRUE,
                        GA_RelVerify,                      TRUE,
                        STRINGA_TextVal,                   mascot[team],
                        STRINGA_MaxChars,                  10 + 1,
                        STRINGA_MinVisible,                10 + stringextra,
                    StringEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    AddLabel("Owner:"),
                    LAYOUT_AddChild,                       gadgets[GID_TVS_CH2] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_TVS_CH2,
                        CHOOSER_LabelArray,                &OwnerOptions,
                    ChooserEnd,
                    CHILD_WeightedWidth,                   0,
                    AddLabel("Away colours:"),
                    LAYOUT_AddChild,                       gadgets[GID_TVS_PL1] = (struct Gadget*)
                    PaletteObject,
                        GA_ID,                             GID_TVS_PL1,
                        PALETTE_NumColours,                6,
                        PALETTE_ColourTable,               colourtable,
                    PaletteEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                LAYOUT_AddChild,                           gadgets[GID_TVS_LB1] = (struct Gadget*)
                ListBrowserObject,
                    GA_ID,                                 GID_TVS_LB1,
                    GA_RelVerify,                          TRUE,
                    LISTBROWSER_ColumnInfo,                (ULONG) ColumnInfoPtr,
                    LISTBROWSER_Labels,                    (ULONG) &MenList,
                    LISTBROWSER_ColumnTitles,              TRUE,
                    LISTBROWSER_TitleClickable,            TRUE,
                    LISTBROWSER_AutoFit,                   TRUE,
                    LISTBROWSER_Editable,                  TRUE,
                    LISTBROWSER_ShowSelected,              TRUE,
                    LISTBROWSER_MinVisible,                minvis[game],
                    LISTBROWSER_HorizontalProp,            TRUE,
                ListBrowserEnd,
                AddHLayout,
                    AddSpace,
                    AddLabel("Double-click on an attribute to edit it."),
                    CHILD_WeightedWidth,                   0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                MaximizeButton(GID_TVS_BU29, "Maximize Team"),
                CHILD_WeightedHeight,                      0,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_TVS_SB1),
    DISCARD SetGadgetAttrs
    (   gadgets[GID_TVS_BU1 + team], MainWindowPtr, NULL,
        GA_Selected, TRUE,
    TAG_DONE); // this autorefreshes
    writegadgets(TRUE);
    if (game != BOXING)
    {   DISCARD ActivateLayoutGadget(gadgets[GID_TVS_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_TVS_ST1]);
    }
    loop();
    readgadgets();
    closewindow();
}

MODULE void maximize_team(void)
{   int i, j;

    switch (game)
    {
    case BASEBALL:
        for (i = 0; i < 25; i++)
        {   stat[team][i][0] =
            stat[team][i][1] =
            stat[team][i][2] =
            stat[team][i][3] = 10;
        }
    acase BASKETBALL:
        for (i = 0; i < 13; i++)
        {   stat[team][i][0] = 90; // >90 might be ok
            for (j = 1; j < 11; j++)
            {   stat[team][i][j] = 8; // 9 might be ok
            }
            // order-dependent!
            stat[team][i][7] = 250; // 255 might be ok
        }
    acase BOXING:
        for (i = 0; i < 10; i++)
        {   iq[    team][i]    =   0;
            pp[    team][i][0] =
            pp[    team][i][1] =
            pp[    team][i][2] = 100;
            height[team][i]    =
            weight[team][i]    =
            reach[ team][i]    = 255;
            for (j = 0; j < 10; j++)
            {   stat[team][i][j] = 9000; // >9000 might be ok
        }   }
    acase FOOTBALL:
        for (i = 0; i < 18; i++)
        {   stat[team][i][0] =
            stat[team][i][1] =
            stat[team][i][2] =
            stat[team][i][3] =
            stat[team][i][4] =
            stat[team][i][5] =  8; // 9 might be ok
}   }   }

EXPORT void tvs_loop(ULONG gid, UNUSED ULONG code)
{   TRANSIENT FLAG              ok;
    TRANSIENT TEXT              amountstring[17 + 1],
                                resultstring[17 + 1];
    TRANSIENT ULONG             event, column, whichman;
    TRANSIENT int               i,
                                length;
    TRANSIENT TEXT*             ptr;
    TRANSIENT struct Node*      NodePtr;
    TRANSIENT struct lbEditNode msg;
    TRANSIENT struct TagItem    tags[5];
    PERSIST   ULONG             reversed;

    switch (gid)
    {
    case GID_TVS_LB1:
        DISCARD GetAttr(LISTBROWSER_RelEvent,     (Object*) gadgets[GID_TVS_LB1], (ULONG*) &event);
        DISCARD GetAttr(LISTBROWSER_RelColumn,    (Object*) gadgets[GID_TVS_LB1], (ULONG*) &column);
        DISCARD GetAttr(LISTBROWSER_Selected,     (Object*) gadgets[GID_TVS_LB1], (ULONG*) &whichman);
        DISCARD GetAttr(LISTBROWSER_SelectedNode, (Object*) gadgets[GID_TVS_LB1], (ULONG*) &NodePtr);

        if (event == LBRE_TITLECLICK)
        {   if (sortcolumn == code)
            {   reversed = (reversed == LBMSORT_FORWARD) ? LBMSORT_REVERSE : LBMSORT_FORWARD;
            } else
            {   reversed = LBMSORT_FORWARD;
                sortcolumn = code;
            }
            DoGadgetMethod
            (   gadgets[GID_TVS_LB1], MainWindowPtr, NULL,
                LBM_SORT,
                NULL,     // gadgetinfo
                code,     // column to sort on
                reversed, // reversed
                NULL      // custom sort hook
            ); // this refreshes automatically
        } elif (event == LBRE_EDIT)
        {   GetListBrowserNodeAttrs(NodePtr, LBNA_Column, column, LBNCA_Text, &ptr, TAG_DONE);
            strcpy(resultstring, ptr);

            if (column == 1) // player name
            {   strcpy(playername[team][whichman], resultstring);
                strupr(playername[team][whichman]);
                strcpy(amountstring, playername[team][whichman]);
            } else
            {   switch (game)
                {
                case BASEBALL:
                    stat[team][whichman][column - 2] = atoi(resultstring);
                    if   (stat[team][whichman][column - 2] <  1) stat[team][whichman][column - 2] =  1;
                    elif (stat[team][whichman][column - 2] > 10) stat[team][whichman][column - 2] = 10;
                    sprintf(amountstring, "%2d", (int) stat[team][whichman][column - 2]);
                acase BASKETBALL:
                    switch (column)
                    {
                    case 2: // number
                        ok = FALSE;
                        length = strlen(resultstring);
                        for (i = 0; i < 37; i++)
                        {   if
                            (   !strcmp(resultstring, NumberOptions[i])
                             || (length == 1 && NumberOptions[i][0] == ' ' && NumberOptions[i][1] == resultstring[0])
                            )
                            {   ok = TRUE;
                                break; // for speed
                        }   }
                        if (ok)
                        {   number[team][whichman] = i;
                        } else
                        {   number[team][whichman] = 0;
                        }
                        strcpy(amountstring, NumberOptions[number[team][whichman]]);
                    acase 3: // height
                        stat[team][whichman][0] = atoi(resultstring);
                        if   (stat[team][whichman][0] < 64) stat[team][whichman][0] = 64;
                        elif (stat[team][whichman][0] > 90) stat[team][whichman][0] = 90;
                        sprintf(amountstring, "%2d", (int) stat[team][whichman][0]);
                    acase  4: // shooting
                    case   5: // passing
                    case   6: // defence
                    case   7: // rebounding
                    case   8: // quickness
                    case   9: // jumping
                    case  11: // release
                    case  12: // arc
                    case  13: // velocity
                        stat[team][whichman][column - 3] = atoi(resultstring);
                        if   (stat[team][whichman][column - 3] < 1) stat[team][whichman][column - 3] = 1;
                        elif (stat[team][whichman][column - 3] > 8) stat[team][whichman][column - 3] = 8;
                        sprintf(amountstring, "%1d", (int) stat[team][whichman][column - 3]);
                    acase 10: // stamina
                        stat[team][whichman][7] = atoi(resultstring);
                        /* if      (stat[team][whichman][7] <   0) stat[team][whichman][7] =   0;
                        else */ if (stat[team][whichman][7] > 255) stat[team][whichman][7] = 255;
                        sprintf(amountstring, "%3d", (int) stat[team][whichman][7]);
                    }
                acase BOXING:
                    if (column == 2)
                    {   strcpy(homename[team][whichman], resultstring);
                        strupr(homename[team][whichman]);
                        strcpy(amountstring, homename[team][whichman]);
                    } elif (column >= 3 && column <= 19)
                    {   if (column <= 12) // 3..12
                        {   stat[team][whichman][column - 3] = atoi(resultstring);
                            sprintf(amountstring, "%5d", (int) stat[team][whichman][column - 3]);
                        } elif (column <= 15) // 13..15
                        {   pp[team][whichman][column - 13] = atoi(resultstring);
                            sprintf(amountstring, "%3d", (int) pp[team][whichman][column - 13]);
                        } elif (column == 16)
                        {   age[team][whichman] = atoi(resultstring);
                            sprintf(amountstring, "%5d", (int) age[team][whichman]);
                        } elif (column == 17)
                        {   height[team][whichman] = atoi(resultstring);
                            sprintf(amountstring, "%3d", (int) height[team][whichman]);
                        } elif (column == 18)
                        {   weight[team][whichman] = atoi(resultstring);
                            sprintf(amountstring, "%3d", (int) weight[team][whichman]);
                        } else
                        {   // assert(column == 19);
                            reach[team][whichman] = atoi(resultstring);
                            sprintf(amountstring, "%3d", (int) reach[team][whichman]);
                    }   }
                acase FOOTBALL:
                    stat[team][whichman][column - 2] = atoi(resultstring);
                    if   (stat[team][whichman][column - 2] < 1) stat[team][whichman][column - 2] = 1;
                    elif (stat[team][whichman][column - 2] > 8) stat[team][whichman][column - 2] = 8;
                    sprintf(amountstring, "%1d", (int) stat[team][whichman][column - 2]);
            }   }
    
            tags[0].ti_Tag  = LBNA_Column;
            tags[0].ti_Data = column;
            tags[1].ti_Tag  = LBNCA_Text;
            tags[1].ti_Data = (ULONG) amountstring;
            tags[2].ti_Tag  = TAG_DONE;

            msg.MethodID = LBM_EDITNODE;
            msg.lbe_Node = (struct Node*) NodePtr;
            msg.lbe_NodeAttrs = (struct TagItem*) &tags;
            DISCARD DoGadgetMethodA(gadgets[GID_TVS_LB1], MainWindowPtr, NULL, (Msg) &msg);

            /* reaction.lib equivalent is:
            LBEditNode(gadgets[GID_TVS_LB1], MainWindowPtr, NULL, NodePtr,
            LBNA_Column,     column,
             LBNCA_Text,     amountstring,
            TAG_DONE); this autorefreshes */
        } elif (event == LBRE_NORMAL)
        {   if (game == BOXING)
            {   FLAG refresh = TRUE;

                switch (column)
                {
                case 0: // handedness
                    if (hand[team][whichman] == 4)
                    {   hand[team][whichman] = 5;
                    } else
                    {   hand[team][whichman] = 4;
                    }
                acase 20:
                    if (style[team][whichman] == 3) style[team][whichman] = 0; else style[team][whichman]++;
                acase 21:
                    if (iq[   team][whichman] == 4) iq[   team][whichman] = 0; else iq[   team][whichman]++;
                adefault:
                    refresh = FALSE;
                }

                if (refresh)
                {   DISCARD SetGadgetAttrs(     gadgets[GID_TVS_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels,     ~0,                    TAG_END);
                    lb_clearlist(&MenList);
                    makemenlist(TRUE);
                    DISCARD SetGadgetAttrs(     gadgets[GID_TVS_LB1], MainWindowPtr, NULL, LISTBROWSER_ColumnInfo, (ULONG) ColumnInfoPtr, TAG_END);
                    // LISTBROWSER_ColumnInfo must be passed *before* LISTBROWSER_Labels!
                    DISCARD SetGadgetAttrs(     gadgets[GID_TVS_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels,     &MenList,              TAG_END);
                    DISCARD SetGadgetAttrs(     gadgets[GID_TVS_LB1], MainWindowPtr, NULL, LISTBROWSER_AutoFit,    TRUE,                  TAG_END);
        }   }   }
    acase GID_TVS_ST1:
        // assert(game != BOXING);
        gadmode = SERIALIZE_READ;
        either_st(GID_TVS_ST1, teamname_long[team]);
        teamname_long[team][13] = EOS;
        strupr(teamname_long[team]);
        gadmode = SERIALIZE_WRITE;
        either_st(GID_TVS_ST1, teamname_long[team]);

        DISCARD SetGadgetAttrs
        (   gadgets[GID_TVS_BU1 + team], MainWindowPtr, NULL,
            GA_Text, teamname_long[team],
        TAG_DONE); // this autorefreshes
     // DISCARD ActivateLayoutGadget(gadgets[GID_TVS_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_TVS_ST1]); messes up tabbing
    acase GID_TVS_ST2:
        gadmode = SERIALIZE_READ;
        either_st(GID_TVS_ST2, teamname_short[team]);
        strupr(teamname_short[team]);
        gadmode = SERIALIZE_WRITE;
        either_st(GID_TVS_ST2, teamname_short[team]);
    acase GID_TVS_ST3:
        gadmode = SERIALIZE_READ;
        either_st(GID_TVS_ST3, mascot[team]);
        strupr(mascot[team]);
        gadmode = SERIALIZE_WRITE;
        either_st(GID_TVS_ST3, mascot[team]);
    acase GID_TVS_BU29:
        readgadgets();
        maximize_team();
        writegadgets(FALSE);
    adefault:
        if (gid >= GID_TVS_BU1 && gid <= GID_TVS_BU28)
        {   if (team == gid - GID_TVS_BU1)
            {   DISCARD SetGadgetAttrs
                (   gadgets[GID_TVS_BU1 + team], MainWindowPtr, NULL,
                    GA_Selected, TRUE,
                TAG_DONE); // this autorefreshes
            } else
            {   DISCARD SetGadgetAttrs
                (   gadgets[GID_TVS_BU1 + team], MainWindowPtr, NULL,
                    GA_Selected, FALSE,
                TAG_DONE); // this autorefreshes
                readgadgets();
                team = gid - GID_TVS_BU1;
                DISCARD SetGadgetAttrs
                (   gadgets[GID_TVS_ST1], MainWindowPtr, NULL,
                    STRINGA_TextVal, teamname_long[team],
                TAG_DONE); // this autorefreshes
                writegadgets(FALSE);
                if (game != BOXING)
                {   DISCARD ActivateLayoutGadget(gadgets[GID_TVS_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_TVS_ST1]);
}   }   }   }   }

EXPORT FLAG tvs_open(FLAG loadas)
{   int  i;
    BPTR FileHandle /* = ZERO */ ;

    if (gameopen(loadas))
    {   switch (gamesize)
        {
        case 12544:
            game = BASKETBALL;
        acase 15624:
            game = FOOTBALL;
        acase 19282:
            game = BOXING;
        acase 120732:
            game = BASEBALL;
        adefault:
            DisplayBeep(NULL);
            return FALSE;
    }   }
    else
    {   return FALSE;
    }

    serializemode = SERIALIZE_READ;
    serialize();

    if (game == BASKETBALL || game == FOOTBALL)
    {   zstrncpy(SEAS_Pathname, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
        if (!AddPart(SEAS_Pathname, "seas", MAX_PATH))
        {   printf("Can't assemble pathname \"%s\"!\n", SEAS_Pathname);
            return FALSE;
        }
        if (!(FileHandle = (BPTR) Open(SEAS_Pathname, MODE_OLDFILE)))
        {   printf("Can't open file \"%s\" for reading!\n", SEAS_Pathname);
            return FALSE;
        }
        if (Read(FileHandle, SEAS_Buffer, seas_size[game]) != seas_size[game])
        {   DISCARD Close(FileHandle);
            // FileHandle = ZERO;
            printf("Can't read file \"%s\"!\n", SEAS_Pathname);
            return FALSE;
        }
        DISCARD Close(FileHandle);
        // FileHandle = ZERO;

        for (i = 0; i < 28; i++)
        {   offset = 34 * (i + 1);
            strcpy(teamname_long[ i], &SEAS_Buffer[offset]);
            offset += 14;
            strcpy(teamname_short[i], &SEAS_Buffer[offset]);
            offset += 5;
            if (game == FOOTBALL)
            {   strcpy(mascot[i],     &SEAS_Buffer[offset]);
            } else
            {   mascot[i][0] = EOS;
            }
            offset += 11;
            if (game == FOOTBALL)
            {   colour[i] = SEAS_Buffer[offset] - 1;
            } else
            {   colour[i] = 0;
            }
            offset++;
            owner[i] = SEAS_Buffer[offset];
    }   }

    writegadgets(TRUE);
    return TRUE;
}

MODULE void writegadgets(FLAG full)
{   if
    (   page != FUNC_TVS
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets(full);
}

MODULE void eithergadgets(FLAG full)
{   ULONG oldgame;
    int   i;

    if (game != BOXING || gadmode == SERIALIZE_WRITE)
    {   either_st(GID_TVS_ST1, teamname_long[team]);
    }
    if (game != BOXING && gadmode == SERIALIZE_READ)
    {   teamname_long[team][13] = EOS;
        strupr(teamname_long[team]);
        gadmode = SERIALIZE_WRITE;
        either_st(GID_TVS_ST1, teamname_long[team]);
        gadmode = SERIALIZE_READ;
    }
    either_st(GID_TVS_ST2, teamname_short[team]);
    either_st(GID_TVS_ST3, mascot[team]);
    either_ch(GID_TVS_CH2, &owner[team]);

    if (gadmode == SERIALIZE_WRITE)
    {   oldgame = game;
        either_ch(GID_TVS_CH1, &game);

        if (full || oldgame != game)
        {   DISCARD SetGadgetAttrs(     gadgets[GID_TVS_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels,     ~0,                    TAG_END);
            lb_clearlist(&MenList);
            makemenlist(TRUE);
            DISCARD SetGadgetAttrs(     gadgets[GID_TVS_LB1], MainWindowPtr, NULL, LISTBROWSER_ColumnInfo, (ULONG) ColumnInfoPtr, TAG_END);
            // LISTBROWSER_ColumnInfo must be passed *before* LISTBROWSER_Labels!
            DISCARD SetGadgetAttrs(     gadgets[GID_TVS_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels,     &MenList,              TAG_END);
            DISCARD SetGadgetAttrs(     gadgets[GID_TVS_LB1], MainWindowPtr, NULL, LISTBROWSER_AutoFit,    TRUE,                  TAG_END);
        } else
        {   DISCARD SetGadgetAttrs(     gadgets[GID_TVS_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels,     ~0,                    TAG_END);
            lb_clearlist(&MenList);
            makemenlist(FALSE);
            DISCARD SetGadgetAttrs(     gadgets[GID_TVS_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels,     &MenList,              TAG_END);
        }
        RefreshGadgets((struct Gadget*) gadgets[GID_TVS_LB1], MainWindowPtr, NULL);

        for (i = 0; i < 28; i++)
        {   DISCARD SetGadgetAttrs(     gadgets[GID_TVS_BU1 + i], MainWindowPtr, NULL,
                GA_Disabled, (game == BOXING && i >= 7) ? TRUE : FALSE,
                GA_Text,     teamname_long[i],
            TAG_DONE); // this autorefreshes
        }

        DISCARD SetGadgetAttrs(         gadgets[GID_TVS_PL1], MainWindowPtr, NULL,
            GA_Disabled,    (game != FOOTBALL) ? TRUE : FALSE,
            PALETTE_Colour, colour[team],
        TAG_END); // this might autorefresh
        RefreshGadgets((struct Gadget*) gadgets[GID_TVS_PL1], MainWindowPtr, NULL);

        DISCARD SetGadgetAttrs(         gadgets[GID_TVS_CH2], MainWindowPtr, NULL,
            GA_Disabled,    (game == BOXING) ? TRUE : FALSE,
        TAG_END); // this autorefreshes

        DISCARD SetGadgetAttrs(         gadgets[GID_TVS_ST1], MainWindowPtr, NULL,
            GA_Disabled,    (game == BOXING) ? TRUE : FALSE,
        TAG_END); // we must explicitly refresh
        RefreshGadgets((struct Gadget*) gadgets[GID_TVS_ST1], MainWindowPtr, NULL);

        DISCARD SetGadgetAttrs(         gadgets[GID_TVS_ST2], MainWindowPtr, NULL,
            GA_Disabled,    (game == BOXING) ? TRUE : FALSE,
        TAG_END); // we must explicitly refresh
        RefreshGadgets((struct Gadget*) gadgets[GID_TVS_ST2], MainWindowPtr, NULL);

        DISCARD SetGadgetAttrs(         gadgets[GID_TVS_ST3], MainWindowPtr, NULL,
            GA_Disabled,    (game != FOOTBALL) ? TRUE : FALSE,
        TAG_END); // we must explicitly refresh
        RefreshGadgets((struct Gadget*) gadgets[GID_TVS_ST3], MainWindowPtr, NULL);
    } else
    {   // assert(gadmode == SERIALIZE_READ);

        DISCARD GetAttr(PALETTE_Colour, (Object*) gadgets[GID_TVS_PL1], (ULONG*) &colour[team]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets(FALSE);
}

MODULE void serialize(void)
{   int i, j, k;

    switch (game)
    {
    case BASEBALL:
        for (i = 0; i < 28; i++)
        {   colour[i]    = 0;
            mascot[i][0] = EOS;

            offset = 0xE6A4 + (i * 2202);
            strcpy(teamname_long[ i], (char*) &IOBuffer[offset]); // $E6A4..$E6B2
            offset += 15;
            strcpy(teamname_short[i], (char*) &IOBuffer[offset]); // $E6B3..$E6B7
            offset += 32;
            serialize1(&owner[i]);                                // $E6D3

            for (j = 0; j < 25; j++)
            {   offset = 0xE6DA + (i * 2202) + (j * 86);

                if (serializemode == SERIALIZE_READ)
                {   strcpy(playername[i][j], (char*) &IOBuffer[offset]);
                } else
                {   strcpy((char*) &IOBuffer[offset], playername[i][j]);
                }
                offset += 20;

                serialize1(&stat[i][j][1]); // $E6EE speed/skill
                serialize1(&stat[i][j][2]); // $E6EF arm  /fatigue
                serialize1(&stat[i][j][0]); // $E6F0 bunt /curve
                serialize1(&stat[i][j][3]); // $E6F1 def  /hitting
        }   }
    acase BASKETBALL:
        for (i = 0; i < 28; i++)
        {   offset = i * 448;

            for (j = 0; j < 13; j++)
            {   if (serializemode == SERIALIZE_READ)
                {   strcpy(playername[i][j], (char*) &IOBuffer[offset]);
                } else
                {   strcpy((char*) &IOBuffer[offset], playername[i][j]);
                }
                offset += 18;
            }

            offset = (i * 448) + 252;
            for (j = 0; j < 13; j++)
            {   offset += 2;                          //  $FC.. $FD
                serialize1(&stat[i][j][ 7]);          //  $FE stamina       (stat  7, column 10)
                if (serializemode == SERIALIZE_WRITE)
                {   stat[i][j][0] -= 64;
                }
                serialize1(&stat[i][j][ 0]);          //  $FF height        (stat  0, column  3)
                stat[i][j][0] += 64;
                serialize1(&number[i][j]);            // $100 jersey number (number , column  2)
                serialize1(&stat[i][j][ 8]);          // $101 release       (stat  8, column 11)
                serialize1(&stat[i][j][ 9]);          // $102 arc           (stat  9, column 12)
                serialize1(&stat[i][j][10]);          // $103 velocity      (stat 10, column 13)
                serialize1(&stat[i][j][ 1]);          // $104 shooting      (stat  1, column  4)
                serialize1(&stat[i][j][ 2]);          // $105 passing       (stat  2, column  5)
                serialize1(&stat[i][j][ 3]);          // $106 defence       (stat  3, column  6)
                serialize1(&stat[i][j][ 4]);          // $107 rebounding    (stat  4, column  7)
                serialize1(&stat[i][j][ 5]);          // $108 quickness     (stat  5, column  8)
                serialize1(&stat[i][j][ 6]);          // $109 jumping       (stat  6, column  9)
        }   }
    acase BOXING:
        if (serializemode == SERIALIZE_READ)
        {   if (team > 6)
            {   team = 6;
            }
            strcpy(teamname_long[0], "Sparring Partners"  );
            strcpy(teamname_long[1], "Specialists"        );
            strcpy(teamname_long[2], "Amiga Careerists #1");
            strcpy(teamname_long[3], "Amiga Careerists #2");
            strcpy(teamname_long[4], "Amiga Careerists #3");
            strcpy(teamname_long[5], "Human Careerists"   );
            strcpy(teamname_long[6], "Open Exhibitioners" );
            for (i = 0; i < 28; i++)
            {   owner[i] = (i == 5 || i == 6) ? 0 : 1;
            }
            for (i = 7; i < 28; i++)
            {   teamname_long[ i][0] = EOS;
            }
            for (i = 0; i < 28; i++)
            {   mascot[        i][0] =
                teamname_short[i][0] = EOS;
        }   }

        offset = 0x4C6;

        for (i = 0; i < 7; i++)
        {   for (j = 0; j < 10; j++)
            {   if (serializemode == SERIALIZE_READ)
                {   strcpy(playername[i][j], (char*) &IOBuffer[offset]);
                } else
                {   strcpy((char*) &IOBuffer[offset], playername[i][j]);
                }
                offset += 19;                         // $4C6..$4D8
                serialize1to1(&hand[i][j]);           // $4D9
                serialize2ulong(&age[i][j]);          // $4DA..$4DB
                serialize1(&height[i][j]);            // $4DC
                serialize1(&weight[i][j]);            // $4DD
                serialize1(&reach[i][j]);             // $4DE
                offset +=  3;                         // $4DF..$4E1
                if (serializemode == SERIALIZE_READ)
                {   strcpy(homename[i][j], (char*) &IOBuffer[offset]);
                } else
                {   strcpy((char*) &IOBuffer[offset], homename[i][j]);
                }
                offset += 26;                         // $4E2..$4FB

                for (k = 0; k < 10; k++)
                {   serialize2ulong(&stat[i][j][k]);  // $4FC..$50F
                }
                offset += 20;                         // $510..$523
                for (k = 0; k < 3; k++)
                {   serialize1(&pp[i][j][k]);         // $524..$526
                }
                offset += 17;                         // $527..$537
                serialize1to1(&style[i][j]);          // $538
                serialize1to1(&iq[i][j]);             // $539
                offset += 24;                         // $53A..$551
        }   }
    acase FOOTBALL:
        for (i = 0; i < 28; i++)
        {   offset = i * 558;

            for (j = 0; j < 18; j++)
            {   if (serializemode == SERIALIZE_READ)
                {   strcpy(playername[i][j], (char*) &IOBuffer[offset]);
                } else
                {   padspaces(playername[i][j], 17);
                    strcpy((char*) &IOBuffer[offset], playername[i][j]);
                }
                remspaces(playername[i][j], 17);
                offset += 25;
            }

            offset = (i * 558) + 450;
            for (j = 0; j < 4; j++)
            {   for (k = 0; k < 18; k++)
                {   serialize1(&stat[i][k][j]);
}   }   }   }   }

EXPORT void tvs_save(FLAG saveas)
{   int  i;
    BPTR FileHandle /* = ZERO */ ;

    readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  BASEBALL:   DISCARD gamesave("seas.blt"    , "TV Sports Baseball"  , saveas, gamesize, FLAG_R, FALSE)        ;
    acase BASKETBALL: if (   !gamesave("#?tdat#?"    , "TV Sports Basketball", saveas, gamesize, FLAG_R, TRUE )) return;
    acase BOXING:     DISCARD gamesave("BOXRDATA.BLT", "TV Sports Boxing"    , saveas, gamesize, FLAG_R, FALSE)        ;
    acase FOOTBALL:   if (   !gamesave("#?tdat#?"    , "TV Sports Foottball" , saveas, gamesize, FLAG_R, TRUE )) return;
    }

    if (game == BASKETBALL || game == FOOTBALL)
    {   for (i = 0; i < 28; i++)
        {   offset = 34 * (i + 1);
            strcpy(&SEAS_Buffer[offset], teamname_long[ i]);
            offset += 14;
            strcpy(&SEAS_Buffer[offset], teamname_short[i]);
            offset += 5;
            if (game == FOOTBALL)
            {   strcpy(&SEAS_Buffer[offset], mascot[    i]);
            }
            offset += 11;
            if (game == FOOTBALL)
            {   SEAS_Buffer[offset] = colour[i] + 1;
            }
            offset++;
            SEAS_Buffer[offset] = owner[i];
        }

        zstrncpy(SEAS_Pathname, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
        if (!AddPart(SEAS_Pathname, "seas", MAX_PATH))
        {   printf("Can't assemble pathname \"%s\"!\n", SEAS_Pathname);
            return;
        }
        if (!(FileHandle = (BPTR) Open(SEAS_Pathname, MODE_NEWFILE)))
        {   printf("Can't open file \"%s\" for writing!\n", SEAS_Pathname);
            return;
        }
        DISCARD Write(FileHandle, SEAS_Buffer, seas_size[game]);
        DISCARD Close(FileHandle);
        // FileHandle = ZERO;
    }

    say("Saved files.", REQIMAGE_INFO);
}

EXPORT void tvs_key(UBYTE scancode)
{   switch (scancode)
    {
    case SCAN_TAB:
        if (game != BOXING)
        {   DISCARD ActivateLayoutGadget(gadgets[GID_TVS_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_TVS_ST1]);
}   }   }

MODULE void makemenlist(FLAG full)
{   int          i, j;
    TEXT         temp[17][5 + 1];
    struct Node* ListBrowserNodePtr;

#ifdef __amigaos4__
    if (full)
    {   if (ColumnInfoPtr)
        {   FreeLBColumnInfo(ColumnInfoPtr);
            // ColumnInfoPtr = NULL;
        }
    
        switch (game)
        {
        case BASEBALL:
            if (!((ColumnInfoPtr = AllocLBColumnInfo(6, // columns
            LBCIA_Column,                 0,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Position",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 1,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Name",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 2,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Bunt/Curve",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 3,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Speed/Skill",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 4,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Arm/Fatigue",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 5,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Def/Hitting",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            TAG_DONE))))
            {   rq("Can't allocate listbrowser column info!");
            }
        acase BASKETBALL:
            if (!((ColumnInfoPtr = AllocLBColumnInfo(14, // columns
            LBCIA_Column,                 0,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Position",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 1,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Name",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 2,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "No.",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 3,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Height",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 4,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Shooting",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 5,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Passing",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 6,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Defence",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 7,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Rebounding",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 8,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Quickness",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 9,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Jumping",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 10,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Stamina",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 11,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Release",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 12,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Arc",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 13,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Velocity",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            TAG_DONE))))
            {   rq("Can't allocate listbrowser column info!");
            }
        acase BOXING:
            if (!((ColumnInfoPtr = AllocLBColumnInfo(22, // columns
            LBCIA_Column,                 0,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "H",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 1,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Name",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 2,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Hometown",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 3,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Stamina",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 4,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Power",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 5,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Defence",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 6,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Chin",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 7,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Body",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 8,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Ftwrk",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 9,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "HndSpd",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 10,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Cuts",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 11,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Instinct",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 12,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Cndtng",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 13,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Jab",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 14,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Hook",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 15,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Uprct",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 16,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Age",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 17,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Height",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 18,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Weight",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 19,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Reach",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 20,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Style",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 21,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Intlgnce",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            TAG_DONE))))
            {   rq("Can't allocate listbrowser column info!");
            }
        acase FOOTBALL:
            if (!((ColumnInfoPtr = AllocLBColumnInfo(6, // columns
            LBCIA_Column,                 0,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Position",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 1,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Name",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 2,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Speed",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            LBCIA_Column,                 3,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Strength",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 4,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Handling",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
             LBCIA_DraggableSeparator,    TRUE,
            LBCIA_Column,                 5,
             LBCIA_Width,                 0,
             LBCIA_Title,                 "Ability",
             LBCIA_Sortable,              TRUE,
             LBCIA_SortArrow,             TRUE,
             LBCIA_SortDirection,         LBMSORT_FORWARD,
            TAG_DONE))))
            {   rq("Can't allocate listbrowser column info!");
    }   }   }
#endif

    switch (game)
    {
    case BASEBALL:
#ifndef __amigaos4__
        ColumnInfoPtr = BaseballColumnInfo;
#endif
        for (i = 0; i < 25; i++)
        {   sprintf(temp[0], "%2d", (int) stat[team][i][0]); // bunt /curve
            sprintf(temp[1], "%2d", (int) stat[team][i][1]); // speed/skill
            sprintf(temp[2], "%2d", (int) stat[team][i][2]); // arm  /fatigue
            sprintf(temp[3], "%2d", (int) stat[team][i][3]); // def  /hitting

            if (!(ListBrowserNodePtr = AllocListBrowserNode
            (   6,                    // columns
                LBNA_Column,          0,
                 LBNCA_Text,          BaseballPosition[i],
                LBNA_Column,          1,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          playername[team][i],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      17 + 1,
                LBNA_Column,          2,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[0],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      2 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          3,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[1],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      2 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          4,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[2],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      2 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          5,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[3],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      2 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&MenList, ListBrowserNodePtr); /* AddTail() has no return code */
        }
    acase BASKETBALL:
#ifndef __amigaos4__
        ColumnInfoPtr = BasketballColumnInfo;
#endif
        for (i = 0; i < 13; i++)
        {   sprintf(temp[ 0], "%2d", (int) stat[team][i][ 0]); // height
            sprintf(temp[ 1], "%1d", (int) stat[team][i][ 1]); // shooting
            sprintf(temp[ 2], "%1d", (int) stat[team][i][ 2]); // passing
            sprintf(temp[ 3], "%1d", (int) stat[team][i][ 3]); // defence
            sprintf(temp[ 4], "%1d", (int) stat[team][i][ 4]); // rebounding
            sprintf(temp[ 5], "%1d", (int) stat[team][i][ 5]); // quickness
            sprintf(temp[ 6], "%1d", (int) stat[team][i][ 6]); // jumping
            sprintf(temp[ 7], "%3d", (int) stat[team][i][ 7]); // stamina
            sprintf(temp[ 8], "%1d", (int) stat[team][i][ 8]); // release
            sprintf(temp[ 9], "%1d", (int) stat[team][i][ 9]); // arc
            sprintf(temp[10], "%1d", (int) stat[team][i][10]); // velocity

            if (!(ListBrowserNodePtr = AllocListBrowserNode // This seems to be causing guru $80000003 sometimes on OS4.1FEu1
            (   14,                   // columns
                LBNA_Column,          0,
                 LBNCA_Text,          BasketballPosition[i],
                LBNA_Column,          1,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          playername[team][i],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      17 + 1,
                LBNA_Column,          2,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          NumberOptions[number[team][i]],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      2 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          3,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[0],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      2 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          4,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[1],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          5,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[2],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          6,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[3],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          7,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[4],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          8,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[5],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          9,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[6],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          10,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[7],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      3 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          11,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[8],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          12,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[9],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          13,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[10],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&MenList, ListBrowserNodePtr); /* AddTail() has no return code */
        }
    acase BOXING:
#ifndef __amigaos4__
        ColumnInfoPtr = BoxingColumnInfo;
#endif
        for (i = 0; i < 10; i++)
        {   for (j = 0; j < 10; j++)
            {   sprintf(temp[j], "%5d", (int) stat[team][i][j]);
            }
            sprintf(temp[10], "%3d", (int) pp[team][i][0]);
            sprintf(temp[11], "%3d", (int) pp[team][i][1]);
            sprintf(temp[12], "%3d", (int) pp[team][i][2]);
            sprintf(temp[13], "%5d", (int) age[team][i]);
            sprintf(temp[14], "%3d", (int) height[team][i]);
            sprintf(temp[15], "%3d", (int) weight[team][i]);
            sprintf(temp[16], "%3d", (int) reach[team][i]);

            if (!(ListBrowserNodePtr = AllocListBrowserNode
            (   22,                   // columns
                LBNA_Column,          0,
                 LBNCA_Text,          (hand[team][i] == 4) ? "R" : "L",
                LBNA_Column,          1,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          playername[team][i],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      16 + 1,
                LBNA_Column,          2,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          homename[team][i],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      16 + 1,
                LBNA_Column,          3,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[0],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          4,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[1],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          5,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[2],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          6,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[3],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          7,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[4],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          8,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[5],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          9,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[6],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          10,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[7],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          11,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[8],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          12,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[9],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          13, // jab
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[10],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      3 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          14, // hook
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[11],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      3 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          15, // uppercut
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[12],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      3 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          16, // age
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[13],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      5 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          17, // height
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[14],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      3 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          18, // weight
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[15],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      3 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          19, // reach
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[16],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      3 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          20,
                 LBNCA_Text,          StyleOptions[style[team][i]],
                LBNA_Column,          21,
                 LBNCA_Text,          IQOptions[iq[team][i]],
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&MenList, ListBrowserNodePtr); /* AddTail() has no return code */
        }
    acase FOOTBALL:
#ifndef __amigaos4__
        ColumnInfoPtr = FootballColumnInfo;
#endif
        for (i = 0; i < 18; i++)
        {   sprintf(temp[0], "%1d", (int) stat[team][i][0]); // speed
            sprintf(temp[1], "%1d", (int) stat[team][i][1]); // strength
            sprintf(temp[2], "%1d", (int) stat[team][i][2]); // handling
            sprintf(temp[3], "%1d", (int) stat[team][i][3]); // ability

            if (!(ListBrowserNodePtr = AllocListBrowserNode
            (   6,                    // columns
                LBNA_Column,          0,
                 LBNCA_Text,          FootballPosition[i],
                LBNA_Column,          1,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          playername[team][i],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      17 + 1,
                LBNA_Column,          2,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[0],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          3,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[1],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          4,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[2],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
                LBNA_Column,          5,
                 LBNCA_CopyText,      TRUE,
                 LBNCA_Text,          temp[3],
                 LBNCA_Editable,      TRUE,
                 LBNCA_MaxChars,      1 + 1,
                 LBNCA_Justification, LCJ_RIGHT,
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&MenList, ListBrowserNodePtr); /* AddTail() has no return code */
    }   }

    sortcolumn = (ULONG) -1;
}

EXPORT void tvs_close(void) { ; }

EXPORT void tvs_exit(void)
{   lb_clearlist(&MenList);

#ifdef __amigaos4__
    if (ColumnInfoPtr)
    {   FreeLBColumnInfo(ColumnInfoPtr);
        ColumnInfoPtr = NULL;
    }
#endif
}

EXPORT void tvs_getpens(void)
{   lockscreen();

    pens[0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0x88888888, -1); // grey
    pens[1] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1); // red
    pens[2] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFF, -1); // purple
    pens[3] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0xFFFFFFFF, -1); // blue
    pens[4] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, -1); // yellow
    pens[5] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x88888888, 0x00000000, -1); // orange

    unlockscreen();
}

EXPORT void tvs_uniconify(void)
{   tvs_getpens();
}

// These are general purpose routines that will probably move to mce.c and be used by the other tools.
MODULE void padspaces(STRPTR thestring, int numchars)
{   int i,
        thelength;

    // numchars doesn't include the NUL terminator (EOS).

    thelength = strlen(thestring);
    if (thelength < numchars)
    {   for (i = thelength; i < numchars; i++)
        {   thestring[i] = ' ';
        }
        thestring[numchars] = EOS;
}   }
MODULE void remspaces(STRPTR thestring, int numchars)
{   int i;

    // numchars doesn't include the NUL terminator (EOS).

    for (i = numchars - 1; i >= 0; i--)
    {   if (thestring[i] == ' ')
        {   thestring[i] = EOS;
        } else
        {   break;
    }   }
    thestring[numchars] = EOS;
}

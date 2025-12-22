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
#define GID_HOL_LY1     0 // root layout
#define GID_HOL_SB1     1 // toolbar
#define GID_HOL_IN1     2 //  1st body count
#define GID_HOL_IN17   18 // 17th body count
#define GID_HOL_IN18   19 // xp
#define GID_HOL_IN19   20 // current hp
#define GID_HOL_IN20   21 // maximum hp
#define GID_HOL_IN21   22 // str
#define GID_HOL_IN22   23 // int
#define GID_HOL_IN23   24 // wis
#define GID_HOL_IN24   25 // dex
#define GID_HOL_IN25   26 // con
#define GID_HOL_IN26   27 // cha
#define GID_HOL_IN27   28 // BCS charges
#define GID_HOL_IN28   29 // SOM charges
#define GID_HOL_IN29   30 // armour class
#define GID_HOL_IN30   31 // 1st high score
#define GID_HOL_IN31   32 // 2nd high score
#define GID_HOL_IN32   33 // 3rd high score
#define GID_HOL_IN33   34 // 4th high score
#define GID_HOL_IN34   35 // 5th high score
#define GID_HOL_BU1    36 // maximize party
#define GID_HOL_BU2    37 // up
#define GID_HOL_BU3    38 // down
#define GID_HOL_BU4    39 // melee weapon
#define GID_HOL_BU5    40 // 1st inventory
#define GID_HOL_BU12   47 // 8th inventory
#define GID_HOL_BU13   48 // ranged weapon
#define GID_HOL_BU14   49 // maximize character
#define GID_HOL_BU15   50 // clear high scores
#define GID_HOL_CH1    51 // game
#define GID_HOL_CH2    52 // character
#define GID_HOL_CH3    53 // filetype
#define GID_HOL_LB1    54 // marching order
#define GID_HOL_ST1    55 // 1st high score
#define GID_HOL_ST2    56 // 2nd high score
#define GID_HOL_ST3    57 // 3rd high score
#define GID_HOL_ST4    58 // 4th high score
#define GID_HOL_ST5    59 // 5th high score
#define GID_HOL_ST6    60 // game slot name
#define GID_HOL_SL1    61 // game slot number

// weapons/inventory subwindow
#define GID_HOL_LY2    62 // root layout
#define GID_HOL_LB2    63 // listbrowser

#define GIDS_HOL       GID_HOL_LB2

#define AddBodyCount(a)   LAYOUT_AddChild, gadgets[GID_HOL_IN1 + a] = (struct Gadget*) IntegerObject, GA_ID, GID_HOL_IN1 + a, GA_TabCycle,  TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 65535, INTEGER_MinVisible, 5 + 1, IntegerEnd
#define AddInventory(a)   LAYOUT_AddChild, gadgets[GID_HOL_BU5 + a] = (struct Gadget*) ZButtonObject, GA_ID, GID_HOL_BU5 + a, GA_RelVerify, TRUE, BUTTON_Justification, LCJ_LEFT, ButtonEnd

#define INVENTORIES    8

#define HOL1           0
#define HOL2           1

#define FT_HISCORES    0
#define FT_SAVEGAME    1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void make_chooser(FLAG detach);
MODULE void make_list(FLAG detach);
MODULE void move_up(void);
MODULE void move_down(void);
MODULE void itemwindow(void);
MODULE void maximize_party(void);
MODULE void maximize_man(int whichman);
MODULE void sortscores(void);
MODULE void clearscores(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra;
IMPORT SWORD                screenheight;
IMPORT LONG                 gamesize;
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
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
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

MODULE FLAG                 slotused[64];
MODULE TEXT                 name[5][16 + 1] = { "", "", "", "", "" },
                            slotname[64][16 + 1];
MODULE ULONG                filetype,
                            score[5],
                            selected = 0,
                            who      = 0;
MODULE int                  items,
                            members,
                            wgs      = 0, // which game slot
                            whichitemslot;
MODULE struct List          ItemsList,
                            MarchingList,
                            NamesList;

MODULE const STRPTR NameOptions[23 + 1] =
{   "Goldmoon",   // 739
    "Sturm",      // 740
    "Caramon",    // 741
    "Raistlin",   // 742
    "Tanis",      // 743
    "Tasslehoff", // 744
    "Riverwind",  // 745
    "Flint",      // 746
    "Gilthanas",
    "Princess Laurana",
    "Eben Shatterstone",
    "Akar",
    "Toragan",
    "Valdor",
    "Cedric",
    "Hanal",
    "Ash",
    "Barac",
    "Gerath",
    "Camar",
    "Garian",
    "Issus",
    "Rencel",
    NULL
}, ItemNames[2][56] =
{ { "Empty",            //  0
    "Blue Crystal Staff",
    "Staff of Magius",
    "Bow #1",
    "Longsword #1",
    "Dagger #1",
    "Sling",
    "Jo stick",
    "Hunting knife #1",
    "Spear",
    "Two-handed sword", // 10
    "Hand axe",
    "Sword #1",
    "Sword #2",
    "Quiver",
    "Red Quiver",
    "Pouch",
    "Bracelet",
    "Shield #1",
    "Shield #2",
    "Shield #3",        // 20
    "Shield #4",
    "Shield #5",
    "Gem #1",
    "Gem #2",
    "Gem #3",
    "Gem #4",
    "Gem #5",
    "Gold Bar",
    "Silver Bar",
    "Gold Chalice",     // 30
    "Silver Chalice",
    "Coins",
    "TBD #1",
    "TBD #2",
    "TBD #3",
    "TBD #4",
    "TBD #5",
    "TBD #6",
    "TBD #7",
    "Bow #2",           // 40
    "Longsword #2",
    "Sword #3",
    "Dagger #2",
    "Hunting knife #2",
    "Scroll #1",
    "Scroll #2",
    "Green Potion",
    "Orange Potion",
    "Red Potion",
    "Blue Potion",      // 50
    "Yellow Potion",
    "Ring",
    "Gem Ring",
    "Wand",
    "Disks of Mishakal" // 55
  },
  { "Empty",            //  0
    "Disks of Mishakal",
    "Staff of Magius",
    "Bow",
    "Longsword",
    "Broadsword +2",
    "Sling",
    "Hoopak +2",
    "2-Handed sword +3",
    "Spear",
    "Longsword +1",     // 10
    "Battle Axe +1",
    "Longsword +2",
    "Quarterstaff +2",
    "Arrows",
    "Arrows +2",
    "Pouch, Bullets +1",
    "Throwing Axe",
    "Battle Axe +3",
    "Wyrmslayer"        // 19
} }, GameOptions[2 + 1] =
{ "Heroes of the Lance",
  "Dragons of Flame",
  NULL
}, FiletypeOptions[2 + 1] =
{ "High score table",
  "Saved game(s)",
  NULL
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct ColumnInfo MarchingColumnInfo[] =
{ { 0,                            // WORD   ci_Width
    "",                           // STRPTR ci_Title
    CIF_FIXED | CIF_NOSEPARATORS  // ULONG  ci_Flags
  },
  { 100,
    "",
    0 /* Last column must not have CIF_DRAGGABLE set (CIF_DRAGGABLE
         applies to the right border of the relevant column). */
  },
  { -1, (STRPTR) ~0, -1
} };

MODULE struct
{   ULONG ac[23],
          bcs, som,
          bodycount[17],
          curhp[23],
          inventory[23][INVENTORIES],
          marching[10],
          maxhp[23],
          melee[23],
          ranged[23],
          stat[23][6],
          xp[23];
} gamedata[64];

// 8. CODE ---------------------------------------------------------------

EXPORT void hol_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // hol_preinit()
        NewList(&ItemsList);
        NewList(&MarchingList);
        NewList(&NamesList);
    }

    tool_open      = hol_open;
    tool_loop      = hol_loop;
    tool_save      = hol_save;
    tool_close     = hol_close;
    tool_exit      = hol_exit;
    tool_subgadget = hol_subgadget;

    if (loaded != FUNC_HOL && !hol_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_HOL;

    load_images(228, 239);
    MarchingColumnInfo[0].ci_Width = image[228]->Width + 6;
    make_speedbar_list(GID_HOL_SB1);
    load_aiss_images(4,  5);
    load_aiss_images(9, 10);

    make_chooser(FALSE);
    make_list(FALSE);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_HOL_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddHLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                AddToolbar(GID_HOL_SB1),
                AddSpace,
                AddVLayout,
                    LAYOUT_AddChild,                       gadgets[GID_HOL_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_HOL_CH1,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedWidth,                   0,
                    LAYOUT_AddChild,                       gadgets[GID_HOL_CH3] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_HOL_CH3,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &FiletypeOptions,
                    ChooserEnd,
                    Label("File type:"),
                LayoutEnd,
                AddSpace,
                MaximizeButton(GID_HOL_BU1, "Maximize Party"),
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddLabel(""),
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                AddLabel("Slot:"),
                CHILD_WeightedWidth,                       0,
                LAYOUT_AddChild,                           gadgets[GID_HOL_SL1] = (struct Gadget*)
                SliderObject,
                    GA_ID,                                 GID_HOL_SL1,
                    GA_RelVerify,                          TRUE,
                    SLIDER_Min,                            0,
                    SLIDER_Max,                            63,
                    SLIDER_KnobDelta,                      1,
                    SLIDER_Orientation,                    SLIDER_HORIZONTAL,
                    SLIDER_Ticks,                          64, // how many ticks to display
                SliderEnd,
                AddLabel("Filename:"),
                CHILD_WeightedWidth,                       0,
                LAYOUT_AddChild,                           gadgets[GID_HOL_ST6] = (struct Gadget*)
                StringObject,
                    GA_ID,                                 GID_HOL_ST6,
                    GA_TabCycle,                           TRUE,
                    STRINGA_MaxChars,                      8 + 1,
                    STRINGA_MinVisible,                    8 + stringextra,
                StringEnd,
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Saved Game",

                AddVLayout,
                    LAYOUT_AddChild,                           gadgets[GID_HOL_CH2] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_HOL_CH2,
                        GA_RelVerify,                          TRUE,
                        CHOOSER_Labels,                        &NamesList,
                        CHOOSER_Selected,                      who,
                        CHOOSER_MaxLabels,                     23,
                    ChooserEnd,
                    Label("Character:"),
                    AddVLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "Character",
                        AddHLayout,
                            LAYOUT_VertAlignment,              LALIGN_CENTER,
                            AddLabel("HP:"),
                            CHILD_WeightedWidth,               0,
                            LAYOUT_AddChild,                   gadgets[GID_HOL_IN19] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_HOL_IN19,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               999,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,               50,
                            AddLabel("of"),
                            CHILD_WeightedWidth,               0,
                            LAYOUT_AddChild,                   gadgets[GID_HOL_IN20] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_HOL_IN20,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               999,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,               50,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        AddHLayout,
                            LAYOUT_VertAlignment,              LALIGN_CENTER,
                            AddLabel("XP:"),
                            CHILD_WeightedWidth,               0,
                            LAYOUT_AddChild,                   gadgets[GID_HOL_IN18] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_HOL_IN18,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               999,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,               50,
                            AddLabel("AC:"),
                            CHILD_WeightedWidth,               0,
                            LAYOUT_AddChild,                   gadgets[GID_HOL_IN29] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_HOL_IN29,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               999,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,               50,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        AddHLayout,
                            LAYOUT_AddChild,                   gadgets[GID_HOL_IN21] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_HOL_IN21,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Minimum,               0,
                            IntegerEnd,
                            Label("STR:"),
                            LAYOUT_AddChild,                   gadgets[GID_HOL_IN22] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_HOL_IN22,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Minimum,               0,
                            IntegerEnd,
                            Label("INT:"),
                            LAYOUT_AddChild,                   gadgets[GID_HOL_IN23] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_HOL_IN23,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Minimum,               0,
                            IntegerEnd,
                            Label("WIS:"),
                            LAYOUT_AddChild,                   gadgets[GID_HOL_IN24] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_HOL_IN24,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Minimum,               0,
                            IntegerEnd,
                            Label("DEX:"),
                            LAYOUT_AddChild,                   gadgets[GID_HOL_IN25] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_HOL_IN25,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Minimum,               0,
                            IntegerEnd,
                            Label("CON:"),
                            LAYOUT_AddChild,                   gadgets[GID_HOL_IN26] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_HOL_IN26,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Minimum,               0,
                            IntegerEnd,
                            Label("CHA:"),
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        AddLabel(""),
                        CHILD_WeightedHeight,                  0,
                        AddHLayout,
                            AddVLayout,
                                LAYOUT_AddChild,               gadgets[GID_HOL_BU13] = (struct Gadget*)
                                ZButtonObject,
                                    GA_ID,                     GID_HOL_BU13,
                                    GA_RelVerify,              TRUE,
                                    BUTTON_Justification,      LCJ_LEFT,
                                ButtonEnd,
                                Label("Ranged Wpn:"),
                                AddInventory(0),
                                Label("Item #1:"),
                                AddInventory(2),
                                Label("Item #3:"),
                                AddInventory(4),
                                Label("Item #5:"),
                                AddInventory(6),
                                Label("Item #7:"),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_AddChild,               gadgets[GID_HOL_BU4] = (struct Gadget*)
                                ZButtonObject,
                                    GA_ID,                     GID_HOL_BU4,
                                    GA_RelVerify,              TRUE,
                                    BUTTON_Justification,      LCJ_LEFT,
                                ButtonEnd,
                                Label("Melee Wpn:"),
                                AddInventory(1),
                                Label("Item #2:"),
                                AddInventory(3),
                                Label("Item #4:"),
                                AddInventory(5),
                                Label("Item #6:"),
                                AddInventory(7),
                                Label("Item #8:"),
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        MaximizeButton(GID_HOL_BU14, "Maximize Character"),
                        CHILD_WeightedHeight,                  0,
                    LayoutEnd,
                    CHILD_WeightedHeight,                      0,
                LayoutEnd,
                CHILD_WeightedHeight,                          0,
                AddLabel(""),
                CHILD_WeightedHeight,                          0,
                AddHLayout,
                    LAYOUT_BevelStyle,                         BVS_GROUP,
                    LAYOUT_SpaceOuter,                         TRUE,
                    LAYOUT_Label,                              "Body Count",
                    AddVLayout,
                        AddBodyCount(0),
                        Label("Baaz:"),
                        AddBodyCount(3),
                        Label("Wraiths:"),
                        AddBodyCount(6),
                        Label("Small Aghars:"),
                        AddBodyCount(9),
                        Label("Hatchlings:"),
                        AddBodyCount(12),
                        Label("Dire Wolves:"),
                        AddBodyCount(15),
                        Label("Goblins:"),
                    LayoutEnd,
                    AddVLayout,
                        AddBodyCount(1),
                        Label("Bozaks:"),
                        AddBodyCount(4),
                        Label("Spectrals:"),
                        AddBodyCount(7),
                        Label("Men:"),
                        AddBodyCount(10),
                        Label("Kapaks:"),
                        AddBodyCount(13),
                        Label("Wild Dogs:"),
                        AddBodyCount(16),
                        Label("Griffons:"),
                    LayoutEnd,
                    AddVLayout,
                        AddBodyCount(2),
                        Label("Trolls:"),
                        AddBodyCount(5),
                        Label("Large Aghars:"),
                        AddBodyCount(8),
                        Label("Spiders:"),
                        AddBodyCount(11),
                        Label("War Dogs:"),
                        AddBodyCount(14),
                        Label("Hobgoblins:"),
                        AddLabel(""),
                    LayoutEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                          0,
                AddHLayout,
                    AddHLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "Marching Order",
                        LAYOUT_AddChild,                       gadgets[GID_HOL_LB1] = (struct Gadget*)
                        ListBrowserObject,
                            GA_ID,                             GID_HOL_LB1,
                            GA_RelVerify,                      TRUE,
                            LISTBROWSER_ColumnInfo,            (ULONG) &MarchingColumnInfo,
                            LISTBROWSER_Labels,                (ULONG) &MarchingList,
                            LISTBROWSER_ColumnTitles,          FALSE,
                            LISTBROWSER_MinVisible,            1,
                            LISTBROWSER_ShowSelected,          TRUE,
                            LISTBROWSER_Selected,              selected,
                            LISTBROWSER_AutoWheel,             FALSE,
                        ListBrowserEnd,
                        AddVLayout,
                            LAYOUT_AddChild,                   gadgets[GID_HOL_BU2] = (struct Gadget*)
                            ZButtonObject,
                                GA_ID,                         GID_HOL_BU2,
                                GA_RelVerify,                  TRUE,
                             // BUTTON_TextPadding,            TRUE,
                                GA_Image,
                                    LabelObject,
                                    LABEL_Image,               aissimage[4],
                                    CHILD_NoDispose,           TRUE,
                                    LABEL_DrawInfo,            DrawInfoPtr,
                                    LABEL_VerticalAlignment,   LVALIGN_BASELINE,
                                    LABEL_Text,                " ",
                                    LABEL_Text,                "Up ",
                                LabelEnd,
                            ButtonEnd,
                            LAYOUT_AddChild,                   gadgets[GID_HOL_BU3] = (struct Gadget*)
                            ZButtonObject,
                                GA_ID,                         GID_HOL_BU3,
                                GA_RelVerify,                  TRUE,
                             // BUTTON_TextPadding,            TRUE,
                                GA_Image,
                                    LabelObject,
                                    LABEL_Image,               aissimage[5],
                                    CHILD_NoDispose,           TRUE,
                                    LABEL_DrawInfo,            DrawInfoPtr,
                                    LABEL_VerticalAlignment,   LVALIGN_BASELINE,
                                    LABEL_Text,                " ",
                                    LABEL_Text,                "Down ",
                                LabelEnd,
                            ButtonEnd,
                        LayoutEnd,
                        CHILD_WeightedWidth,                   0,
                    LayoutEnd,
                    CHILD_WeightedWidth,                       100,
                    CHILD_WeightedHeight,                      100,
                    AddVLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "Charges",
                        LAYOUT_AddChild,                       gadgets[GID_HOL_IN27] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                             GID_HOL_IN27,
                            GA_TabCycle,                       TRUE,
                            INTEGER_Minimum,                   0,
                            INTEGER_Maximum,                   65535,
                            INTEGER_Number,                    gamedata[wgs].bcs,
                            INTEGER_MinVisible,                5 + 1,
                        IntegerEnd,
                        Label("Blue Crystal Staff:"),
                        LAYOUT_AddChild,                       gadgets[GID_HOL_IN28] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                             GID_HOL_IN28,
                            GA_TabCycle,                       TRUE,
                            INTEGER_Minimum,                   0,
                            INTEGER_Maximum,                   65535,
                            INTEGER_Number,                    gamedata[wgs].som,
                            INTEGER_MinVisible,                5 + 1,
                        IntegerEnd,
                        Label("Staff of Magius:"),
                    LayoutEnd,
                    CHILD_WeightedWidth,                       0,
                LayoutEnd,
            LayoutEnd,
            AddLabel(""),
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "High Score Table",
                AddVLayout,
                    LAYOUT_AddChild,                       gadgets[GID_HOL_ST1] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_HOL_ST1,
                        GA_TabCycle,                       TRUE,
                        STRINGA_MaxChars,                  16 + 1,
                        STRINGA_MinVisible,                16 + stringextra,
                    StringEnd,
                    Label("#1:"),
                    LAYOUT_AddChild,                       gadgets[GID_HOL_ST2] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_HOL_ST2,
                        GA_TabCycle,                       TRUE,
                        STRINGA_MaxChars,                  16 + 1,
                        STRINGA_MinVisible,                16 + stringextra,
                    StringEnd,
                    Label("#2:"),
                    LAYOUT_AddChild,                       gadgets[GID_HOL_ST3] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_HOL_ST3,
                        GA_TabCycle,                       TRUE,
                        STRINGA_MaxChars,                  16 + 1,
                        STRINGA_MinVisible,                16 + stringextra,
                    StringEnd,
                    Label("#3:"),
                    LAYOUT_AddChild,                       gadgets[GID_HOL_ST4] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_HOL_ST4,
                        GA_TabCycle,                       TRUE,
                        STRINGA_MaxChars,                  16 + 1,
                        STRINGA_MinVisible,                16 + stringextra,
                    StringEnd,
                    Label("#4:"),
                    LAYOUT_AddChild,                       gadgets[GID_HOL_ST5] = (struct Gadget*)
                    StringObject,
                        GA_ID,                             GID_HOL_ST5,
                        GA_TabCycle,                       TRUE,
                        STRINGA_MaxChars,                  16 + 1,
                        STRINGA_MinVisible,                16 + stringextra,
                    StringEnd,
                    Label("#5:"),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_AddChild,                       gadgets[GID_HOL_IN30] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_HOL_IN30,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                       gadgets[GID_HOL_IN31] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_HOL_IN31,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                       gadgets[GID_HOL_IN32] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_HOL_IN32,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                       gadgets[GID_HOL_IN33] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_HOL_IN33,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                       gadgets[GID_HOL_IN34] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_HOL_IN34,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                LayoutEnd,
                ClearButton(GID_HOL_BU15, "\nClear\nHigh\nScores"),
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_HOL_SB1);
    writegadgets();

    SetGadgetAttrs(                 gadgets[GID_HOL_LB1], MainWindowPtr, NULL, LISTBROWSER_MakeVisible, selected, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_HOL_LB1], MainWindowPtr, NULL);
    if (filetype == FT_SAVEGAME)
    {   ActivateLayoutGadget(gadgets[GID_HOL_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_HOL_IN19]);
    } else
    {   ActivateLayoutGadget(gadgets[GID_HOL_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_HOL_ST1 ]);
    }

    loop();

    readgadgets();
    closewindow();
}

EXPORT void hol_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_HOL_BU1:
        readgadgets();
        maximize_party();
        writegadgets();
    acase GID_HOL_BU2:
        move_up();
    acase GID_HOL_BU3:
        move_down();
    acase GID_HOL_BU4:
        whichitemslot = -1;
        itemwindow();
    acase GID_HOL_BU13:
        whichitemslot = -2;
        itemwindow();
    acase GID_HOL_BU14:
        readgadgets();
        maximize_man(who);
        writegadgets();
    acase GID_HOL_BU15:
        // readgadgets(); is unnecessary
        clearscores();
        writegadgets();
    acase GID_HOL_SL1:
        readgadgets();
        GetAttr(SLIDER_Level,     (Object*) gadgets[GID_HOL_SL1], (ULONG*) &wgs);
        writegadgets();
    acase GID_HOL_CH2:
        readgadgets();
        GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_HOL_CH2], (ULONG*) &who);
        writegadgets();
    acase GID_HOL_LB1:
        // assert(filetype == FT_SAVEGAME);
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_HOL_LB1], (ULONG*) &selected);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_HOL_BU2], SubWindowPtr, NULL,
            GA_Disabled, (selected == 0),
        TAG_DONE); // this autorefreshes
        DISCARD SetGadgetAttrs
        (   gadgets[GID_HOL_BU3], SubWindowPtr, NULL,
            GA_Disabled, ((int) selected == members - 1),
        TAG_DONE); // this autorefreshes
    adefault:
        if (gid >= GID_HOL_BU5 && gid <= GID_HOL_BU12)
        {   whichitemslot = gid - GID_HOL_BU5;
            itemwindow();
}   }   }

EXPORT FLAG hol_open(FLAG loadas)
{   if (gameopen(loadas))
    {   switch (gamesize)
        {
        case 2344:
            game = HOL1;
            filetype = FT_SAVEGAME;
        acase 72704:
            game = HOL1;
            filetype = FT_HISCORES;
        acase 901120:
            if (ask("What kind of file is this?", "High scores|Saved games") == 0) // high scores
            {   filetype = FT_HISCORES;
            } else
            {   filetype = FT_SAVEGAME;
            }
            game = HOL2;
        adefault:
            DisplayBeep(NULL);
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
    (   page != FUNC_HOL
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
    {   SetGadgetAttrs(gadgets[GID_HOL_CH1], MainWindowPtr, NULL, CHOOSER_Selected, game,     TAG_DONE); // this autorefreshes
        SetGadgetAttrs(gadgets[GID_HOL_CH3], MainWindowPtr, NULL, CHOOSER_Selected, filetype, TAG_DONE); // this autorefreshes

        SetGadgetAttrs(gadgets[GID_HOL_SL1], MainWindowPtr, NULL, SLIDER_Level, wgs, GA_Disabled, (filetype == FT_SAVEGAME && game == HOL2) ? FALSE : TRUE, TAG_DONE); // this autorefreshes

        DISCARD SetGadgetAttrs
        (   gadgets[GID_HOL_BU13], MainWindowPtr, NULL,
            GA_Text,     ItemNames[game][gamedata[wgs].ranged[who]],
            GA_Disabled, (filetype == FT_SAVEGAME && game == HOL2 && slotused[wgs]) ? FALSE : TRUE,
        TAG_DONE); // this autorefreshes

        DISCARD SetGadgetAttrs
        (   gadgets[GID_HOL_BU4], MainWindowPtr, NULL,
            GA_Text,     ItemNames[game][gamedata[wgs].melee[who]],
            GA_Disabled, (filetype == FT_SAVEGAME && slotused[wgs]) ? FALSE : TRUE,
        TAG_DONE); // this autorefreshes

        for (i = 0; i < INVENTORIES; i++)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_HOL_BU5 + i], MainWindowPtr, NULL,
                GA_Text,     ItemNames[game][gamedata[wgs].inventory[who][i]],
                GA_Disabled, (filetype == FT_SAVEGAME && game == HOL1 && slotused[wgs]) ? FALSE : TRUE,
            TAG_DONE); // this autorefreshes
        }

        ghost(GID_HOL_BU1 , (filetype == FT_SAVEGAME                 && slotused[wgs]) ? FALSE : TRUE);

        ghost(GID_HOL_IN18, (filetype == FT_SAVEGAME && game == HOL1 && slotused[wgs]) ? FALSE : TRUE);
        ghost(GID_HOL_IN19, (filetype == FT_SAVEGAME                 && slotused[wgs]) ? FALSE : TRUE);
        ghost(GID_HOL_IN20, (filetype == FT_SAVEGAME && game == HOL2 && slotused[wgs]) ? FALSE : TRUE);
        for (i =  0; i <   6; i++)
        {   ghost(GID_HOL_IN21 + i, (filetype == FT_SAVEGAME && game == HOL2 && slotused[wgs]) ? FALSE : TRUE);
        }
        ghost(GID_HOL_IN29, (filetype == FT_SAVEGAME && game == HOL2 && slotused[wgs]) ? FALSE : TRUE);

        for (i =  0; i <=  2; i++) ghost(GID_HOL_IN1  + i, (filetype == FT_SAVEGAME                 && slotused[wgs]) ? FALSE : TRUE);
        for (i =  3; i <=  9; i++) ghost(GID_HOL_IN1  + i, (filetype == FT_SAVEGAME && game == HOL1 && slotused[wgs]) ? FALSE : TRUE);
        for (i = 10; i <= 16; i++) ghost(GID_HOL_IN1  + i, (filetype == FT_SAVEGAME && game == HOL2 && slotused[wgs]) ? FALSE : TRUE);

        ghost(GID_HOL_IN27, (filetype == FT_SAVEGAME && game == HOL1 && slotused[wgs]) ? FALSE : TRUE);
        ghost(GID_HOL_IN28, (filetype == FT_SAVEGAME && game == HOL1 && slotused[wgs]) ? FALSE : TRUE);

        ghost(GID_HOL_BU1,  (filetype == FT_SAVEGAME && slotused[wgs]) ? FALSE : TRUE);
        ghost(GID_HOL_BU14, (filetype == FT_SAVEGAME && slotused[wgs]) ? FALSE : TRUE);

        for (i = 0; i < 5; i++)
        {   ghost_st(GID_HOL_ST1  + i, (filetype == FT_HISCORES) ? FALSE : TRUE);
            ghost(   GID_HOL_IN30 + i, (filetype == FT_HISCORES) ? FALSE : TRUE);
        }
        ghost(       GID_HOL_BU15    , (filetype == FT_HISCORES) ? FALSE : TRUE);

        ghost_st( GID_HOL_ST6, (filetype == FT_SAVEGAME && game == HOL2 && slotused[wgs]) ? FALSE : TRUE);

        make_chooser(TRUE);
        make_list(TRUE);
    }

    either_st(GID_HOL_ST6, slotname[wgs]);

    either_in(GID_HOL_IN18, &gamedata[wgs].xp[who]);
    either_in(GID_HOL_IN19, &gamedata[wgs].curhp[who]);
    either_in(GID_HOL_IN20, &gamedata[wgs].maxhp[who]);
    for (i = 0; i < 6; i++)
    {   either_in(GID_HOL_IN21 + i, &gamedata[wgs].stat[who][i]);
    }
    either_in(GID_HOL_IN29, &gamedata[wgs].ac[who]);

    for (i = 0; i < 17; i++)
    {   either_in(GID_HOL_IN1  + i, &gamedata[wgs].bodycount[i]);
    }
    either_in(GID_HOL_IN27, &gamedata[wgs].bcs);
    either_in(GID_HOL_IN28, &gamedata[wgs].som);

    for (i = 0; i < 5; i++)
    {   either_in(GID_HOL_IN30 + i, &score[i]);
        either_st(GID_HOL_ST1  + i, name[  i]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i, j, k,
        length;
PERSIST const int val_to_position[23] =
{    0, //  0 ->  0 Goldmoon
     5, //  1 ->  5 Sturm
     4, //  2 ->  4 Caramon
     6, //  3 ->  6 Raistlin
     1, //  4 ->  1 Tanis
     2, //  5 ->  2 Tasslehoff
     3, //  6 ->  3 Riverwind
     7, //  7 ->  7 Flint
     8, //  8 ->  8 Gilthanas
     9, //  9 ->  9 Princess Laurana
    10, // 10 -> 10 Eben Shatterstone
    11, // 11 -> 11 Akar
    12, // 12 -> 12 Toragan
    11, // 13 -> 13 Valdor
    12, // 14 -> 14 Cedric
    11, // 15 -> 15 Hanal
    12, // 16 -> 16 Ash
    11, // 17 -> 17 Barac
    12, // 18 -> 18 Gerath
    11, // 19 -> 19 Camar
    12, // 20 -> 20 Garian
    11, // 21 -> 21 Issus
    12, // 22 -> 22 Rencel
};

    if (game == HOL1)
    {   members =  8;
        items   = 56;
        if (who >= 8)
        {   who = 0;
        }
        if (selected >= 8)
        {   selected = 0;
    }   }
    else
    {   // assert(game == HOL2);
        members = 10;
        items   = 20;
    }

    switch (filetype)
    {
    case FT_HISCORES:
        offset = (game == HOL1) ? 0x84BA : 0x104D2;

        if (serializemode == SERIALIZE_READ)
        {   for (i = 0; i < 5; i++)
            {   for (j = 0; j < 16; j++)
                {   name[i][j] = IOBuffer[offset++];
                }
                offset++;
        }   }
        else
        {   // assert(serializemode == SERIALIZE_WRITE);

            sortscores();

            for (i = 0; i < 5; i++)
            {   name[i][16] = EOS;
                length = strlen(name[i]);
                if (length < 16)
                {   for (j = length; j < 16; j++)
                    {   name[i][j] = ' ';
                }   }

                for (j = 0; j < 16; j++)
                {   IOBuffer[offset++] = name[i][j];
                }
                offset++;
        }   }

        for (i = 0; i < 5; i++)
        {   name[i][16] = EOS;
            for (j = 15; j >= 0; j--)
            {   if (name[i][j] == ' ')
                {   name[i][j] = EOS;
                } else
                {   break;
        }   }   }

        offset++;
        for (i = 0; i < 5; i++)
        {   serialize4(&score[i]);
        }

        wgs = 0;

        for (i = 0; i < 23; i++)
        {   gamedata[wgs].curhp[ i] =
            gamedata[wgs].maxhp[ i] =
            gamedata[wgs].xp[    i] =
            gamedata[wgs].ac[    i] =
            gamedata[wgs].ranged[i] =
            gamedata[wgs].melee[ i] = 0;
            for (j = 0; j < INVENTORIES; j++)
            {   gamedata[wgs].inventory[i][j] = 0;
            }
            for (j = 0; j < 6; j++)
            {   gamedata[wgs].stat[i][j] = 0;
        }   }
        for (i = 0; i < 17; i++)
        {   gamedata[wgs].bodycount[i] = 0;
        }
        for (i = 0; i < 10; i++)
        {   gamedata[wgs].marching[i] = 23; // empty
        }
        gamedata[wgs].bcs =
        gamedata[wgs].som = 0;
    acase FT_SAVEGAME:
        switch (game)
        {
        case HOL1:
            offset = 0;
            wgs    = 0;

            for (i = 0; i < 8; i++)
            {   serialize2ulong(&gamedata[wgs].xp[i]); // 0..1
                offset++;                // 2
                serialize1(&gamedata[wgs].curhp[i]);   // 3
                offset++;                // 4
                serialize1(&gamedata[wgs].melee[i]);   // 5
                offset += 4;             // 6..9
            }

            // assert(offset == 0x50);
            for (i = 0; i < 8; i++)
            {   for (j = 0; j < INVENTORIES; j++)
                {   offset++;
                    serialize1(&gamedata[wgs].inventory[i][j]);
            }   }
            // assert(offset == 0xD0);
            serialize2ulong(&gamedata[wgs].bcs);              // $D0..$D1
            serialize2ulong(&gamedata[wgs].som);              // $D2..$D3

            offset = 0xEA;
            for (i = 0; i < 10; i++)
            {   serialize2ulong(&gamedata[wgs].bodycount[i]); // $EA..$FD
            }
            for (i = 10; i <= 16; i++)
            {   gamedata[wgs].bodycount[i] = 0;
            }

            offset = 0x8E7;
            for (i = 0; i < 8; i++)
            {   serialize1(&gamedata[wgs].marching[i]);
                offset += 7;
            }

            for (i = 0; i < 23; i++)
            {   gamedata[wgs].maxhp[i]  = 0;
                gamedata[wgs].ranged[i] = 0;
                gamedata[wgs].ac[i]     = 0;
                for (j = 0; j < 6; j++)
                {   gamedata[wgs].stat[i][j] = 0;
            }   }
            slotused[0] = TRUE;
            for (i = 1; i < 64; i++)
            {   slotused[i] = FALSE;
            }
        acase HOL2:
            offset = 0x400;
            if (serializemode == SERIALIZE_READ)
            {   for (i = 0; i < 64; i++)
                {   strcpy(slotname[i], (char*) &IOBuffer[offset]);
                    slotused[i] = slotname[i][0] ? TRUE : FALSE;
                    offset += 16;
            }   }
            else
            {   // assert(serializemode == SERIALIZE_WRITE);
                for (i = 0; i < 64; i++)
                {   strcpy((char*) &IOBuffer[offset], slotname[i]);
                    length = strlen(slotname[i]);
                    if (length < 8)
                    {   for (j = length; j <= 8; j++)
                        {   IOBuffer[offset + j] = EOS;
                    }   }
                    offset += 16;
            }   }

            for (i = 0; i < 64; i++)
            {   offset = 0x800 + (i * 8704);

                serialize2ulong(&gamedata[i].bodycount[ 0]); // $800..$801 baazes
                serialize2ulong(&gamedata[i].bodycount[ 1]); // $802..$803 bozaks
                serialize2ulong(&gamedata[i].bodycount[10]); // $804..$805 kapaks
                serialize2ulong(&gamedata[i].bodycount[11]); // $806..$807 war dogs
                serialize2ulong(&gamedata[i].bodycount[12]); // $808..$809 dire wolves
                serialize2ulong(&gamedata[i].bodycount[13]); // $80A..$80B wild dogs
                serialize2ulong(&gamedata[i].bodycount[14]); // $80C..$80D hobgoblins
                serialize2ulong(&gamedata[i].bodycount[15]); // $80E..$80F goblins
                serialize2ulong(&gamedata[i].bodycount[ 2]); // $810..$811 trolls
                serialize2ulong(&gamedata[i].bodycount[16]); // $812..$813 griffons
                for (j = 3; j <= 9; j++)
                {   gamedata[i].bodycount[j] = 0;
                }

                offset = 0x8CD + (i * 8704);
                for (j = 0; j < 10; j++)
                {   serialize1(&gamedata[i].marching[j]);
                    offset += 7;
                }

                for (j = 0; j < 23; j++)
                {   offset = 0x25AD + (i * 8704) + (val_to_position[j] * 38);
                    serialize1(&gamedata[i].melee[j]);      // $25AA
                    offset++;                               // $25AB
                    serialize1(&gamedata[i].ranged[j]);     // $25AC
                    serialize2ulong(&gamedata[i].curhp[j]); // $25AD..$25AE
                    serialize2ulong(&gamedata[i].maxhp[j]); // $25AF..$25B0
                    offset += 8;                            // $25B1..$25B8
                    serialize1(&gamedata[i].stat[j][0]);    // $25B9        STR
                    serialize1(&gamedata[i].stat[j][1]);    // $25BA        INT
                    serialize1(&gamedata[i].stat[j][2]);    // $25BB        WIS
                    serialize1(&gamedata[i].stat[j][4]);    // $25BC        CON This is
                    serialize1(&gamedata[i].stat[j][3]);    // $25BD        DEX no mistake
                    serialize1(&gamedata[i].stat[j][5]);    // $25BE        CHA
                    serialize1(&gamedata[i].ac[j]);         // $25BF
                    offset += 16;                           // $25C0..$25CF

                    gamedata[i].xp[j] = 0;
                    for (k = 0; k < INVENTORIES; k++)
                    {   gamedata[i].inventory[j][k] = 0;
                }   }

                gamedata[i].bcs =
                gamedata[i].som = 0;
}   }   }   }

EXPORT void hol_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case HOL1:
        if (filetype == FT_SAVEGAME)
        {   gamesave("D&DDL?.SAV" , "Heroes of the Lance", saveas,   2344, FLAG_S, FALSE);
        } else
        {   gamesave("D&DDL1B.PRG", "Heroes of the Lance", saveas,  72704, FLAG_H, FALSE);
        }
    acase HOL2:
        if (filetype == FT_SAVEGAME)
        {   gamesave("Disk.2"     , "Dragons of Flame"   , saveas, 901120, FLAG_S, FALSE);
        } else
        {   gamesave("Disk.1"     , "Dragons of Flame"   , saveas, 901120, FLAG_H, FALSE);
}   }   }

EXPORT void hol_close(void) { ; }

EXPORT void hol_exit(void)
{   lb_clearlist(&ItemsList);
    lb_clearlist(&MarchingList);
    ch_clearlist(&NamesList);
}

MODULE void make_chooser(FLAG detach)
{   int                 i;
    struct ChooserNode* ChooserNodePtr;

    if (detach)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_HOL_CH2], MainWindowPtr, NULL,
            CHOOSER_Labels, ~0,
        TAG_DONE);
    }
    ch_clearlist(&NamesList);

    switch (game)
    {
    case HOL1:
        load_images(739, 746);
        for (i = 0; i < 8; i++)
        {   if (!(ChooserNodePtr = (struct ChooserNode*) AllocChooserNode
            (   CNA_Text,  NameOptions[i],
                CNA_Image, image[739 + i],
            TAG_DONE)))
            {   rq("Can't create chooser.gadget node(s)!");
            }
            AddTail(&NamesList, (struct Node*) ChooserNodePtr); // AddTail() has no return code
        }
    acase HOL2:
        if (screenheight >= 768)
        {   load_images(739, 749);
            for (i = 0; i <= 22; i++)
            {   if (!(ChooserNodePtr = (struct ChooserNode*) AllocChooserNode
                (   CNA_Text,  NameOptions[i],
                    CNA_Image, image[(i < 10) ? (739 + i) : 749],
                TAG_DONE)))
                {   rq("Can't create chooser.gadget node(s)!");
                }
                AddTail(&NamesList, (struct Node*) ChooserNodePtr); // AddTail() has no return code
        }   }
        else
        {   for (i = 0; i <= 22; i++)
            {   if (!(ChooserNodePtr = (struct ChooserNode*) AllocChooserNode
                (   CNA_Text,  NameOptions[i],
                TAG_DONE)))
                {   rq("Can't create chooser.gadget node(s)!");
                }
                AddTail(&NamesList, (struct Node*) ChooserNodePtr); // AddTail() has no return code
    }   }   }

    if (detach)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_HOL_CH2], MainWindowPtr, NULL,
            CHOOSER_Labels,   (ULONG) &NamesList,
            CHOOSER_Selected, who,
            GA_Disabled,      (filetype == FT_SAVEGAME && slotused[wgs]) ? FALSE : TRUE,
        TAG_DONE); // this refreshes automatically
}   }

MODULE void make_list(FLAG detach)
{   int                     i,
                            marchimage;
    STRPTR                  marchstring;
    struct ListBrowserNode* ListBrowserNodePtr;

    if (detach)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_HOL_LB1], MainWindowPtr, NULL,
            LISTBROWSER_Labels, ~0,
        TAG_DONE);
    }
    lb_clearlist(&MarchingList);

    for (i = 0; i < members; i++)
    {   if (gamedata[wgs].marching[i] == 23)
        {   marchimage  = 11;
            marchstring = "Empty";
        } else
        {   marchstring = NameOptions[gamedata[wgs].marching[i]];
            if (gamedata[wgs].marching[i] >= 10)
            {   marchimage = 10;
            } else
            {   marchimage = gamedata[wgs].marching[i];
        }   }
        if (!(ListBrowserNodePtr = (struct ListBrowserNode*) AllocListBrowserNode
        (   2,                  // columns,
            LBNA_Column,        0,
            LBNCA_Image,        image[228 + marchimage],
            LBNA_Column,        1,
            LBNCA_Text,         (ULONG) marchstring,
	 // LBNCA_VertJustify is "not currently implemented and ignored by the gadget" :-(
        TAG_END)))
        {   rq("Can't create listbrowser.gadget node(s)!");
        }
        AddTail(&MarchingList, (struct Node*) ListBrowserNodePtr); /* AddTail() has no return code */
    }

    if (detach)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_HOL_LB1], MainWindowPtr, NULL,
            LISTBROWSER_Labels,      (ULONG) &MarchingList, // this autorefreshes
            LISTBROWSER_Selected,    selected,              // this autorefreshes
            GA_Disabled,             (filetype == FT_SAVEGAME && slotused[wgs]) ? FALSE : TRUE,
        TAG_DONE);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_HOL_BU2], MainWindowPtr, NULL,
            GA_Disabled, (filetype == FT_SAVEGAME && selected != 0 && slotused[wgs]) ? FALSE : TRUE,
        TAG_DONE); // this autorefreshes
        DISCARD SetGadgetAttrs
        (   gadgets[GID_HOL_BU3], MainWindowPtr, NULL,
            GA_Disabled, (filetype == FT_SAVEGAME && (int) selected != members - 1 && slotused[wgs]) ? FALSE : TRUE,
        TAG_DONE); // this autorefreshes
        DISCARD SetGadgetAttrs(         gadgets[GID_HOL_LB1], MainWindowPtr, NULL, LISTBROWSER_MakeVisible, selected, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_HOL_LB1], MainWindowPtr, NULL);
}   }

MODULE void maximize_party(void)
{   int i;

    for (i = 0; i < 23; i++)
    {   maximize_man(i);
    }

    switch (game)
    {
    case HOL1:
        for (i = 0; i <= 9; i++)
        {   gamedata[wgs].bodycount[i] =    65000;
        }

        gamedata[wgs].bcs              =
        gamedata[wgs].som              =    65000;
    acase HOL2:
        for (i = 0; i <= 16; i++)
        {   if (i <= 2 || i >= 10)
            {   gamedata[wgs].bodycount[i] =  900;
}   }   }   }

MODULE void maximize_man(int whichman)
{   int i;

    switch (game)
    {
    case HOL1:
        gamedata[wgs].curhp[whichman]       =
        gamedata[wgs].xp[whichman]          = 900;
    acase HOL2:
        gamedata[wgs].curhp[whichman]       =
        gamedata[wgs].maxhp[whichman]       = 900;

        for (i = 0; i < 6; i++)
        {   gamedata[wgs].stat[whichman][i] =  20;
        }
        gamedata[wgs].ac[whichman]          =  20;
}   }

MODULE void move_up(void)
{   ULONG temp;

    DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_HOL_LB1], (ULONG*) &selected);
    if (selected > 0)
    {   // swap it with the one above it
        temp                                 = gamedata[wgs].marching[selected];
        gamedata[wgs].marching[selected]     = gamedata[wgs].marching[selected - 1];
        gamedata[wgs].marching[selected - 1] = temp;
        selected--;
        make_list(TRUE);
}   }
MODULE void move_down(void)
{   ULONG temp;

    DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_HOL_LB1], (ULONG*) &selected);
    if ((int) selected < members - 1)
    {   // swap it with the one below it
        temp                                 = gamedata[wgs].marching[selected];
        gamedata[wgs].marching[selected]     = gamedata[wgs].marching[selected + 1];
        gamedata[wgs].marching[selected + 1] = temp;
        selected++;
        make_list(TRUE);
}   }

MODULE void itemwindow(void)
{   int selected;

    lb_makelist(&ItemsList, ItemNames[game], items);

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              ((whichitemslot < 0) ? "Choose Weapon" : "Choose Item"),
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "hol-1",
        WINDOW_ParentGroup,                    gadgets[GID_HOL_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_HOL_LB2] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_HOL_LB2,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &ItemsList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    192,
            CHILD_MinHeight,                   (game == HOL1) ? 384 : 192,
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

    if (whichitemslot == -2)
    {   selected = gamedata[wgs].ranged[who];
    } elif (whichitemslot == 1)
    {   selected = gamedata[wgs].melee[who];
    } else
    {   selected = gamedata[wgs].inventory[who][whichitemslot];
    }

    SetGadgetAttrs(                 gadgets[GID_HOL_LB2], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) selected, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_HOL_LB2], SubWindowPtr, NULL);
    SetGadgetAttrs(                 gadgets[GID_HOL_LB2], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) selected, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_HOL_LB2], SubWindowPtr, NULL);

    subloop();

    if (whichitemslot == -2)
    {   DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_HOL_LB2], (ULONG*) &gamedata[wgs].ranged[who]);
    } elif (whichitemslot == -1)
    {   DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_HOL_LB2], (ULONG*) &gamedata[wgs].melee[who]);
    } else
    {   DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_HOL_LB2], (ULONG*) &gamedata[wgs].inventory[who][whichitemslot]);
    }

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;

    lb_clearlist(&ItemsList);

    writegadgets();
}

EXPORT FLAG hol_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        if (whichitemslot == -2)
        {   lb_move_up(GID_HOL_LB2, SubWindowPtr, qual, (ULONG*) &gamedata[wgs].ranged[who], 0, 5);
        } elif (whichitemslot == -1)
        {   lb_move_up(GID_HOL_LB2, SubWindowPtr, qual, (ULONG*) &gamedata[wgs].melee[who], 0, 5);
        } else
        {   lb_move_up(GID_HOL_LB2, SubWindowPtr, qual, (ULONG*) &gamedata[wgs].inventory[who][whichitemslot], 0, 5);
        }
        writegadgets();
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        if (whichitemslot == -2)
        {   lb_move_down(GID_HOL_LB2, SubWindowPtr, qual, (ULONG*) &gamedata[wgs].ranged[who], items - 1, 5);
        } elif (whichitemslot == -1)
        {   lb_move_down(GID_HOL_LB2, SubWindowPtr, qual, (ULONG*) &gamedata[wgs].melee[who], items - 1, 5);
        } else
        {   lb_move_down(GID_HOL_LB2, SubWindowPtr, qual, (ULONG*) &gamedata[wgs].inventory[who][whichitemslot], items - 1, 5);
        }
        writegadgets();
    }

    return FALSE;
}

EXPORT FLAG hol_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_HOL_LB2:
        return TRUE;
    }

    return FALSE;
}

EXPORT void hol_key(UBYTE scancode)
{   switch (scancode)
    {
    case SCAN_LEFT:
        if (filetype == FT_SAVEGAME && game == HOL2)
        {   readgadgets();
            if (wgs == 0)
            {   wgs = 63;
            } else
            {   wgs--;
            }
            writegadgets();
        }
    acase SCAN_RIGHT:
        if (filetype == FT_SAVEGAME && game == HOL2)
        {   readgadgets();
            if (wgs == 63)
            {   wgs = 0;
            } else
            {   wgs++;
            }
            writegadgets();
        }
    acase SCAN_UP:
    case NM_WHEEL_UP:
        if (filetype == FT_SAVEGAME)
        {   move_up();
        }
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        if (filetype == FT_SAVEGAME)
        {   move_down();
}   }   }

MODULE void sortscores(void)
{   int   i, j;
    TEXT  tempstr[16 + 1];
    ULONG tempnum;

    // This bubble sorts them from highest to lowest.

    for (i = 0; i < 5 - 1; i++)
    {   for (j = 0; j < 5 - i - 1; j++)
        {   if
            (   score[j    ]
              < score[j + 1]
            )
            {   tempnum      = score[j    ];
                score[j    ] = score[j + 1];
                score[j + 1] = tempnum;

                strcpy(tempstr,     name[j    ]);
                strcpy(name[j    ], name[j + 1]);
                strcpy(name[j + 1], tempstr);
    }   }   }

    writegadgets();
}

MODULE void clearscores(void)
{   int i;

    for (i = 0; i < 5; i++)
    {   name[i][0] = EOS;
        score[i]   = 0;
}   }

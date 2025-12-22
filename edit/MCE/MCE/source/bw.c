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
#define GID_BW_LY1    0 // root layout
#define GID_BW_SB1    1
#define GID_BW_LB2    2 // spells
#define GID_BW_CH1    3 // who
#define GID_BW_CH2    4 // p1 facing
#define GID_BW_CH3    5 // p2 facing
#define GID_BW_CH4    6 // game
#define GID_BW_IN1    7 // st
#define GID_BW_IN2    8 // iq
#define GID_BW_IN3    9 // ag
#define GID_BW_IN4   10 // ch
#define GID_BW_IN5   11 // level
#define GID_BW_IN6   12 // coins
#define GID_BW_IN7   13 // normal keys
#define GID_BW_IN8   14 // normal arrows
#define GID_BW_IN9   15 // elf arrows
#define GID_BW_IN10  16 // armour
#define GID_BW_IN11  17 // p1 X
#define GID_BW_IN12  18 // p1 Y
#define GID_BW_IN13  19 // p2 X
#define GID_BW_IN14  20 // p2 Y
#define GID_BW_IN21  21 // food
#define GID_BW_IN22  22 // current hp
#define GID_BW_IN23  23 // maximum hp
#define GID_BW_IN24  24 // current vi
#define GID_BW_IN25  25 // maximum vi
#define GID_BW_IN26  26 // current sp
#define GID_BW_IN27  27 // maximum sp
#define GID_BW_BU1   28 // maximize character
#define GID_BW_BU2   29 // maximize parties
#define GID_BW_BU3   30 // 1st item
#define GID_BW_BU4   31
#define GID_BW_BU5   32
#define GID_BW_BU6   33
#define GID_BW_BU7   34
#define GID_BW_BU8   35
#define GID_BW_BU9   36
#define GID_BW_BU10  37
#define GID_BW_BU11  38
#define GID_BW_BU12  39
#define GID_BW_BU13  40
#define GID_BW_BU14  41 // 12th item
#define GID_BW_BU15  42 // invert selection
#define GID_BW_BU16  43 // all
#define GID_BW_BU17  44 // none

// items subwindow
#define GID_BW_LY2   45
#define GID_BW_LB1   46

#define GIDS_BW      GID_BW_LB1

#define ItemButton(x)   LAYOUT_AddChild, gadgets[x] = (struct Gadget*) ZButtonObject       , GA_ID, x, GA_RelVerify, TRUE, BUTTON_Justification, BCJ_LEFT, ButtonEnd
#define SpellCheck(x,y) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) TickOrCheckBoxObject, GA_ID, x, TAG_DONE), CHILD_WeightedWidth, 0, Label(y)

#define ITEMS        0x6E

#define BW1           0
#define BW2           1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void serialize(void);
MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void readman(void);
MODULE void writeman(void);
MODULE void maximize_man(int whichman);
MODULE void itemwindow(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            loaded,
                            page,
                            serializemode;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
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

MODULE int                  whichitem;
MODULE struct List          Facing1List, Facing2List,
                            ItemsList,
                            NamesList,
                            SpellsList;
MODULE ULONG                facing[2],
                            game,
                            location_x[2],
                            location_y[2],
                            who               = 0;
MODULE TEXT                 itemdisplay[12][40 + 1];
MODULE const STRPTR         ItemNames[ITEMS][2] = {
{ "-"                    , "-"                   }, //   0
{ "Coinage"              , "Coinage"             }, //   1
{ "Key"                  , "Key"                 }, //   2
{ "Normal Arrows"        , "Normal Arrows"       }, //   3
{ "Elf Arrows"           , "Elf Arrows"          }, //   4
{ "1/3 Apple"            , "1/3 Apple"           }, //   5
{ "2/3 Apple"            , "2/3 Apple"           }, //   6
{ "3/3 Apple"            , "3/3 Apple"           }, //   7
{ "1/3 Biscuit"          , "1/3 Biscuit"         }, //   8
{ "2/3 Biscuit"          , "2/3 Biscuit"         }, //   9
{ "3/3 Biscuit"          , "3/3 Biscuit"         }, //  10
{ "1/3 Chicken"          , "1/3 Chicken"         }, //  11
{ "2/3 Chicken"          , "2/3 Chicken"         }, //  12
{ "3/3 Chicken"          , "3/3 Chicken"         }, //  13
{ "1/3 Mead"             , "1/3 Mead"            }, //  14
{ "2/3 Mead"             , "2/3 Mead"            }, //  15
{ "3/3 Mead"             , "3/3 Mead"            }, //  16
{ "1/3 Water"            , "1/3 Water"           }, //  17
{ "2/3 Water"            , "2/3 Water"           }, //  18
{ "3/3 Water"            , "3/3 Water"           }, //  19
{ "N'egg (Green)"        , "N'egg (Green)"       }, //  20
{ "N'egg (Blue)"         , "N'egg (Blue)"        }, //  21
{ "N'egg (Red/Green)"    , "N'egg (Red)"         }, //  22
{ "Serpent Slime"        , "Serpent Slime"       }, //  23
{ "Brimstone Broth"      , "Brimstone Broth"     }, //  24
{ "Dragon Ale"           , "Dragon Ale"          }, //  25
{ "Moon Elixir"          , "Moon Elixir"         }, //  26
{ "Leather Armour"       , "Leather Armour"      }, //  27
{ "Chain Mail"           , "Chain Mail"          }, //  28
{ "Plate Mail"           , "Plate Mail"          }, //  29
{ "Mithril Chain"        , "Mithril Chain"       }, //  30
{ "Mithril Plate"        , "Mithril Plate"       }, //  31
{ "Adamant Chain"        , "Adamant Chain"       }, //  32
{ "Adamant Plate"        , "Adamant Plate"       }, //  33
{ "Crystal Chain"        , "Crystal Chain"       }, //  34
{ "Crystal Plate"        , "Crystal Plate"       }, //  35
{ "Leather Shield"       , "Rune Shield (Red)"   }, //  36 (BW2 is unique)
{ "Buckler"              , "Rune Shield (Green)" }, //  37 (BW2 is unique)
{ "Rune Shield (Classic)", "Rune Shield (Black)" }, //  38 (BW2 is unique)
{ "Large Shield"         , "War Shield"          }, //  39 (BW2 has moved it)
{ "Moon Shield"          , "Demon Scale"         }, //  40 (BW2 is unique)
{ "Dragon Scale"         , "Battle Soul"         }, //  41 (BW2 is unique)
{ "War Shield"           , "Chromatic Plate"     }, //  42 (BW2 is unique)
{ "Chaos Gloves"         , "Chaos Gloves"        }, //  43
{ "Battle Gloves"        , "Battle Gloves"       }, //  44
{ "Mithril Gloves"       , "Mithril Gloves"      }, //  45
{ "Adamant Gloves"       , "Adamant Gloves"      }, //  46
{ "Crystal Gloves"       , "Crystal Gloves"      }, //  47
{ "Dagger"               , "Dagger"              }, //  48
{ "Stealth Blade"        , "Stealth Blade"       }, //  49
{ "Short Sword"          , "Adamant Sword"       }, //  50 (BW2 is unique)
{ "Long Sword"           , "Fleshbane"           }, //  51 (BW2 has moved it)
{ "Mithril Sword"        , "Demon Blade"         }, //  52 (BW2 has moved it)
{ "Fleshbane"            , "Rune Sword"          }, //  53 (BW2 is unique)
{ "Demon Blade"          , "Soul Sucker"         }, //  54 (BW2 is unique)
{ "Ace of Swords"        , "Ace of Swords"       }, //  55
{ "Battle Axe"           , "Adamant Axe"         }, //  56 (BW2 is unique)
{ "Mithril Axe"          , "Ogre's Axe"          }, //  57 (BW2 is unique)
{ "Troll's Axe"          , "Deathbringer"        }, //  58 (BW2 has moved it)
{ "Brainbiter"           , "Dragon Axe"          }, //  59 (BW2 is unique)
{ "Deathbringer"         , "Grey Axe"            }, //  60 (BW2 is unique)
{ "Staff"                , "Staff"               }, //  61
{ "Battle Staff"         , "Battle Staff"        }, //  62
{ "Power Staff"          , "Power Staff"         }, //  63
{ "Blodwyn (RIP)"        , "Blodwyn (RIP)"       }, //  64
{ "Murlock (RIP)"        , "Murlock (RIP)"       }, //  65
{ "Eleanor (RIP)"        , "Eleanor (RIP)"       }, //  66
{ "Rosanne (RIP)"        , "Rosanne (RIP)"       }, //  67
{ "Astroth (RIP)"        , "Astroth (RIP)"       }, //  68
{ "Zothen (RIP)"         , "Zothen (RIP)"        }, //  69
{ "Baldrick (RIP)"       , "Baldrick (RIP)"      }, //  70
{ "Elfric (RIP)"         , "Elfric (RIP)"        }, //  71
{ "Sir Edward (RIP)"     , "Sir Edward (RIP)"    }, //  72
{ "Megrim (RIP)"         , "Megrim (RIP)"        }, //  73
{ "Sethra (RIP)"         , "Sethra (RIP)"        }, //  74
{ "Mr. Flay (RIP)"       , "Mr. Flay (RIP)"      }, //  75
{ "Ulrich (RIP)"         , "Ulrich (RIP)"        }, //  76
{ "Zastaph (RIP)"        , "Zastaph (RIP)"       }, //  77
{ "Hengist (RIP)"        , "Hengist (RIP)"       }, //  78
{ "Thai Chang (RIP)"     , "Thai Chang (RIP)"    }, //  79
{ "Bronze Key"           , "Bronze Key"          }, //  80
{ "Iron Key"             , "Iron Key"            }, //  81
{ "Serpent Key"          , "Serpent Key"         }, //  82
{ "Chaos Key"            , "Chaos Key"           }, //  83
{ "Dragon Key"           , "Dragon Key"          }, //  84
{ "Moon Key"             , "Moon Key"            }, //  85
{ "Chromatic Key"        , "Chromatic Key"       }, //  86
{ "Serpent Wand"         , "Serpent Wand"        }, //  87
{ "Chaos Wand"           , "Chaos Wand"          }, //  88
{ "Dragon Wand"          , "Dragon Wand"         }, //  89
{ "Moon Wand"            , "Moon Wand"           }, //  90
{ "Heal Wand"            , "Heal Wand"           }, //  91
{ "Long Bow"             , "Long Bow"            }, //  92
{ "Frost Bow"            , "Frost Bow"           }, //  93
{ "Cross Bow"            , "Cross Bow"           }, //  94
{ "Permit"               , "Permit"              }, //  95
{ "Serpent Crystal"      , "Serpent Crystal"     }, //  96
{ "Chaos Crystal"        , "Chaos Crystal"       }, //  97
{ "Dragon Crystal"       , "Dragon Crystal"      }, //  98
{ "Moon Crystal"         , "Moon Crystal"        }, //  99
{ "Grey Gem"             , "Grey Gem"            }, // 100
{ "Bluish Gem"           , "Bluish Gem"          }, // 101
{ "Brown Gem"            , "Brown Gem"           }, // 102
{ "Tan Gem"              , "Tan Gem"             }, // 103
{ "Grey Ring"            , "Grey Ring"           }, // 104
{ "Serpent Ring"         , "Serpent Ring"        }, // 105
{ "Chaos Ring"           , "Chaos Ring"          }, // 106
{ "Dragon Ring"          , "Dragon Ring"         }, // 107
{ "Moon Ring"            , "Moon Ring"           }, // 108
{ "Book of Skulls"       , "Book of Skulls"      }, // 109
}, NameOptions[16] =
{ "Blodwyn Stonemaiden",
  "Murlock Darkenheart",
  "Eleanor of Avalon",
  "Rosanne Swifthand",
  "Astroth Slaemwort",
  "Zothen Runecaster",
  "Baldrick the Dung",
  "Elfric Falaendor",
  "Sir Edward Lion",
  "Megrim of Moonwych",
  "Sethra Bhoaghail",
  "Mr. Flay Sepulcrast",
  "Ulrich Sternaxe",
  "Zastaph Mantric",
  "Hengist Meldanash",
  "Thai Chang of Yinn"
  // NULL is not needed here
}, FacingOptions[4] =
{ "North",
  "East",
  "South",
  "West"
}, GameOptions[2 + 1] =
{ "Original Levels",
  "Extended Levels",
  NULL
}, SpellNames[32] =
{ "Armour",
  "Terror",
  "Vitalise",
  "Beguile",
  "Deflect",
  "Magelock",
  "Conceal",
  "Warpower",
  "Missile",
  "Vanish",
  "Paralyze",
  "Alchemy",
  "Confuse",
  "Levitate",
  "Antimage",
  "Recharge",
  "Trueview",
  "Renew",
  "Vivify",
  "Dispell",
  "Firepath",
  "Illusion",
  "Compass",
  "Spelltap",
  "Disrupt",
  "Fireball",
  "Wychwind",
  "Arc Bolt",
  "Formwall",
  "Summon",
  "Blaze",
  "Mindrock"
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   ULONG st,
          iq,
          ag,
          ch,
          level,
          coins,
          keys,
          normalarrows,
          elfarrows,
          food,
          item[12],
          curhp,
          maxhp,
          curvi,
          maxvi,
          cursp,
          maxsp,
          armour,
          spell[32]; // not UWORD!
} man[16];

MODULE struct ColumnInfo TheColumnInfo[] =
{ { 0,                 // WORD   ci_Width
    "",                // STRPTR ci_Title
    CIF_FIXED
  },
  { 100,               // WORD   ci_Width
    "",                // STRPTR ci_Title
    CIF_WEIGHTED
  },
  { -1,
    (STRPTR) ~0,
    -1
} };

// 8. CODE ---------------------------------------------------------------

EXPORT void bw_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // bw_preinit()
        NewList(&Facing1List);
        NewList(&Facing2List);
        NewList(&ItemsList);
        NewList(&NamesList);
        NewList(&SpellsList);

        // bw_init()
        lb_makechecklist(&SpellsList, SpellNames, 32);
    }

    // assert(sizeof(Roster[0]) == 410);

    tool_open      = bw_open;
    tool_loop      = bw_loop;
    tool_save      = bw_save;
    tool_close     = bw_close;
    tool_exit      = bw_exit;
    tool_subgadget = bw_subgadget;

    if (loaded != FUNC_BW && !bw_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_BW;

    ch_load_images(147, 162, NameOptions, &NamesList);
    make_speedbar_list(GID_BW_SB1);
    load_aiss_images( 6,  8);
    load_aiss_images(10, 10);
    ch_load_aiss_images(11, 14, FacingOptions, &Facing1List);
    ch_load_aiss_images(11, 14, FacingOptions, &Facing2List);
    load_fimage(FUNC_BW);
    load_images(670, 685);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                         TRUE,
        WA_ThinSizeGadget,                                     TRUE,
        WINDOW_Position,                                       WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                    gadgets[GID_BW_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                 TRUE,
            AddHLayout,
                LAYOUT_VertAlignment,                          LALIGN_CENTER,
                AddToolbar(GID_BW_SB1),
                AddSpace,
                LAYOUT_AddChild,                               gadgets[GID_BW_CH4] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                     GID_BW_CH4,
                    GA_Disabled,                               TRUE,
                    CHOOSER_LabelArray,                        &GameOptions,
                ChooserEnd,
                Label("Game:"),
                CHILD_WeightedWidth,                           0,
                AddSpace,
                MaximizeButton(GID_BW_BU2, "Maximize Roster"),
                CHILD_WeightedWidth,                           0,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                LAYOUT_VertAlignment,                          LALIGN_CENTER,
                AddLabel("Character:"),
                LAYOUT_AddChild,                               gadgets[GID_BW_CH1] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                     GID_BW_CH1,
                    GA_RelVerify,                              TRUE,
                    CHOOSER_Labels,                            &NamesList,
                    CHOOSER_Selected,                          (WORD) who,
                    CHOOSER_MaxLabels,                         16,
                PopUpEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddVLayout,
                LAYOUT_BevelStyle,                             BVS_GROUP,
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_Label,                                  "Character",
                AddHLayout,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_HorizAlignment,             LALIGN_CENTER,
                            LAYOUT_Label,                      "General",
                            LAYOUT_AddChild,                   gadgets[GID_BW_IN5] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_BW_IN5,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Arrows,                TRUE,
                                INTEGER_Minimum,               1,
                                INTEGER_Maximum,               255,
                                INTEGER_Number,                man[who].level,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            Label("Level:"),
                            LAYOUT_AddChild,                   gadgets[GID_BW_IN21] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_BW_IN21,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Arrows,                TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               255,
                                INTEGER_Number,                man[who].food,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            Label("Food:"),
                            LAYOUT_AddChild,                   gadgets[GID_BW_IN10] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_BW_IN10,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Arrows,                TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               10,
                                INTEGER_Number,                man[who].armour,
                                INTEGER_MinVisible,            2 + 1,
                            IntegerEnd,
                            Label("Base armour class:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_BW_IN22] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BW_IN22,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           (game == BW1) ? 99 : 9999,
                                    INTEGER_Number,            man[who].curhp,
                                    INTEGER_MinVisible,        4 + 1,
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,               gadgets[GID_BW_IN23] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BW_IN23,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           (game == BW1) ? 99 : 9999,
                                    INTEGER_Number,            man[who].maxhp,
                                    INTEGER_MinVisible,        4 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Hit points:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_BW_IN24] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BW_IN24,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            man[who].curvi,
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,               gadgets[GID_BW_IN25] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BW_IN25,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            man[who].maxvi,
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Vitality:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_BW_IN26] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BW_IN26,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            man[who].cursp,
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,               gadgets[GID_BW_IN27] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BW_IN27,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            man[who].maxsp,
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Spell points:"),
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        AddSpace,
                        AddHLayout,
                            AddSpace,
                            AddFImage(FUNC_BW),
                            CHILD_WeightedWidth,               0,
                            AddSpace,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        AddSpace,
                        AddVLayout,
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "Attributes",
                            LAYOUT_AddChild,                   gadgets[GID_BW_IN1] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_BW_IN1,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Arrows,                TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               255,
                                INTEGER_Number,                man[who].st,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            Label("Strength:"),
                            LAYOUT_AddChild,                   gadgets[GID_BW_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_BW_IN3,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Arrows,                TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               255,
                                INTEGER_Number,                man[who].ag,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            Label("Agility:"),
                            LAYOUT_AddChild,                   gadgets[GID_BW_IN2] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_BW_IN2,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Arrows,                TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               255,
                                INTEGER_Number,                man[who].iq,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            Label("Intelligence:"),
                            LAYOUT_AddChild,                   gadgets[GID_BW_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                         GID_BW_IN4,
                                GA_TabCycle,                   TRUE,
                                INTEGER_Arrows,                TRUE,
                                INTEGER_Minimum,               0,
                                INTEGER_Maximum,               255,
                                INTEGER_Number,                man[who].ch,
                                INTEGER_MinVisible,            3 + 1,
                            IntegerEnd,
                            Label("Charisma:"),
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                    LayoutEnd,
                    CHILD_WeightedWidth,                       0,
                    AddVLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_Label,                          "Spells",
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_AddChild,                       gadgets[GID_BW_LB2] = (struct Gadget*)
                        ListBrowserObject,
                            GA_ID,                             GID_BW_LB2,
                            GA_RelVerify,                      TRUE,
                            LISTBROWSER_Labels,                (ULONG) &SpellsList,
                            LISTBROWSER_ShowSelected,          TRUE,
                        ListBrowserEnd,
                        VTripleButton(GID_BW_BU16, GID_BW_BU15, GID_BW_BU17),
                    LayoutEnd,
                    CHILD_MinWidth,                            128,
                    CHILD_WeightedWidth,                       33,
                    LAYOUT_WeightBar,                          TRUE,
                    AddVLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "Items",
                        AddHLayout,
                            AddVLayout,
                                AddImage(670),
                                AddImage(671),
                                AddImage(672),
                                AddImage(673),
                                AddImage(674),
                                AddImage(675),
                                AddImage(676),
                                AddImage(677),
                                AddImage(678),
                                AddImage(679),
                                AddImage(680),
                                AddImage(681),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                            AddVLayout,
                                ItemButton(GID_BW_BU3),
                                Label("Left hand:"),
                                ItemButton(GID_BW_BU4),
                                Label("Right hand:"),
                                ItemButton(GID_BW_BU5),
                                Label("Torso:"),
                                ItemButton(GID_BW_BU6),
                                Label("Shield:"),
                                ItemButton(GID_BW_BU7),
                                Label("Pocket 1:"),
                                ItemButton(GID_BW_BU8),
                                Label("Pocket 2:"),
                                ItemButton(GID_BW_BU9),
                                Label("Pocket 3:"),
                                ItemButton(GID_BW_BU10),
                                Label("Pocket 4:"),
                                ItemButton(GID_BW_BU11),
                                Label("Pocket 5:"),
                                ItemButton(GID_BW_BU12),
                                Label("Pocket 6:"),
                                ItemButton(GID_BW_BU13),
                                Label("Pocket 7:"),
                                ItemButton(GID_BW_BU14),
                                Label("Pocket 8:"),
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        AddSpace,
                        AddHLayout,
                            AddVLayout,
                                AddImage(682),
                                AddImage(683),
                                AddImage(684),
                                AddImage(685),
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                            AddVLayout,
                                LAYOUT_HorizAlignment,         LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_BW_IN6] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BW_IN6,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            man[who].coins,
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                Label("Coins:"),
                                LAYOUT_AddChild,               gadgets[GID_BW_IN7] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BW_IN7,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            man[who].keys,
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                Label("Keys:"),
                                LAYOUT_AddChild,               gadgets[GID_BW_IN8] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BW_IN8,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            man[who].normalarrows,
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                Label("Normal arrows:"),
                                LAYOUT_AddChild,               gadgets[GID_BW_IN9] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_BW_IN9,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            man[who].elfarrows,
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                Label("Elf arrows:"),
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                    LayoutEnd,
                    CHILD_WeightedWidth,                       66,
                LayoutEnd,
                MaximizeButton(GID_BW_BU1, "Maximize Character"),
                CHILD_WeightedHeight,                          0,
            LayoutEnd,
            AddLabel(""),
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                LAYOUT_BevelStyle,                             BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_Label,                                  "Party 1 Location",
                LAYOUT_VertAlignment,                          LALIGN_CENTER,
                LAYOUT_AddChild,                               gadgets[GID_BW_IN11] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_BW_IN11,
                    GA_TabCycle,                               TRUE,
                    INTEGER_Minimum,                           0,
                    INTEGER_Maximum,                           255,
                    INTEGER_Number,                            location_x[0],
                    INTEGER_MinVisible,                        2 + 1,
                IntegerEnd,
                Label("X:"),
                LAYOUT_AddChild,                               gadgets[GID_BW_IN12] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_BW_IN12,
                    GA_TabCycle,                               TRUE,
                    INTEGER_Minimum,                           0,
                    INTEGER_Maximum,                           255,
                    INTEGER_Number,                            location_y[0],
                    INTEGER_MinVisible,                        2 + 1,
                IntegerEnd,
                Label("Y:"),
                LAYOUT_AddChild,                               gadgets[GID_BW_CH2] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                     GID_BW_CH2,
                    CHOOSER_Labels,                            &Facing1List,
                    CHOOSER_Selected,                          (WORD) facing[0],
                PopUpEnd,
                Label("Facing:"),
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                LAYOUT_BevelStyle,                             BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_Label,                                  "Party 2 Location",
                LAYOUT_VertAlignment,                          LALIGN_CENTER,
                LAYOUT_AddChild,                               gadgets[GID_BW_IN13] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_BW_IN13,
                    GA_TabCycle,                               TRUE,
                    INTEGER_Minimum,                           0,
                    INTEGER_Maximum,                           255,
                    INTEGER_Number,                            location_x[1],
                    INTEGER_MinVisible,                        2 + 1,
                IntegerEnd,
                Label("X:"),
                LAYOUT_AddChild,                               gadgets[GID_BW_IN14] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_BW_IN14,
                    GA_TabCycle,                               TRUE,
                    INTEGER_Minimum,                           0,
                    INTEGER_Maximum,                           255,
                    INTEGER_Number,                            location_y[1],
                    INTEGER_MinVisible,                        2 + 1,
                IntegerEnd,
                Label("Y:"),
                LAYOUT_AddChild,                               gadgets[GID_BW_CH3] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                     GID_BW_CH3,
                    CHOOSER_Labels,                            &Facing2List,
                    CHOOSER_Selected,                          (WORD) facing[1],
                PopUpEnd,
                Label("Facing:"),
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
        LayoutEnd,
        CHILD_NominalSize,                                     TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_BW_SB1);
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_BW_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_BW_IN1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void bw_loop(ULONG gid, UNUSED ULONG code)
{   int i,
        whichman;

    switch (gid)
    {
    case GID_BW_CH1:
        readman();
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_BW_CH1], (ULONG*) &who);
        writeman();
    acase GID_BW_BU1:
        readman();
        maximize_man(who);
        writeman();
    acase GID_BW_BU2:
        readman();
        for (whichman = 0; whichman < 16; whichman++)
        {   maximize_man(whichman);
        }
        writeman();
    acase GID_BW_BU15:
        readman();
        for (i = 0; i < 32; i++)
        {   if (man[who].spell[i])
            {   man[who].spell[i] = FALSE;
            } else
            {   man[who].spell[i] = TRUE;
        }   }
        writeman();
    acase GID_BW_BU16:
        readman();
        for (i = 0; i < 32; i++)
        {   man[who].spell[i] = TRUE;
        }
        writeman();
    acase GID_BW_BU17:
        readman();
        for (i = 0; i < 32; i++)
        {   man[who].spell[i] = FALSE;
        }
        writeman();
    adefault:
        if (gid >= GID_BW_BU3 && gid <= GID_BW_BU14)
        {   whichitem = gid - GID_BW_BU3;
            itemwindow();
}   }   }

EXPORT FLAG bw_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        if (!strnicmp(FilePart(pathname), "bextsave", 8))
        {   game = BW2;
        } else
        {   game = BW1;
        }
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   if
    (   function != FUNC_BW
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    SetGadgetAttrs(gadgets[GID_BW_IN11], MainWindowPtr, NULL, INTEGER_Number,          location_x[0], TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN12], MainWindowPtr, NULL, INTEGER_Number,          location_y[0], TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN13], MainWindowPtr, NULL, INTEGER_Number,          location_x[1], TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN14], MainWindowPtr, NULL, INTEGER_Number,          location_y[1], TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_CH1 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) who,           TAG_END);
    SetGadgetAttrs(gadgets[GID_BW_CH2 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) facing[0],     TAG_END);
    SetGadgetAttrs(gadgets[GID_BW_CH3 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) facing[1],     TAG_END);
    SetGadgetAttrs(gadgets[GID_BW_CH4 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) game,          TAG_END);

    RefreshGadgets((struct Gadget*) gadgets[GID_BW_CH1], MainWindowPtr, NULL);
    RefreshGadgets((struct Gadget*) gadgets[GID_BW_CH2], MainWindowPtr, NULL);
    RefreshGadgets((struct Gadget*) gadgets[GID_BW_CH3], MainWindowPtr, NULL);
    RefreshGadgets((struct Gadget*) gadgets[GID_BW_CH4], MainWindowPtr, NULL);

    writeman();
}

MODULE void readgadgets(void)
{   // no need to read CH1

    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN11   ], (ULONG*) &location_x[0]);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN12   ], (ULONG*) &location_y[0]);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN13   ], (ULONG*) &location_x[1]);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN14   ], (ULONG*) &location_y[1]);
    DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_BW_CH2    ], (ULONG*) &facing[0]);
    DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_BW_CH3    ], (ULONG*) &facing[1]);

    readman();
}

MODULE void readman(void)
{   int    i;
    struct Node* NodePtr;

    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN1    ], (ULONG*) &man[who].st);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN2    ], (ULONG*) &man[who].iq);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN3    ], (ULONG*) &man[who].ag);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN4    ], (ULONG*) &man[who].ch);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN5    ], (ULONG*) &man[who].level);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN6    ], (ULONG*) &man[who].coins);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN7    ], (ULONG*) &man[who].keys);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN8    ], (ULONG*) &man[who].normalarrows);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN9    ], (ULONG*) &man[who].elfarrows);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN10   ], (ULONG*) &man[who].armour);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN21   ], (ULONG*) &man[who].food);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN22   ], (ULONG*) &man[who].curhp);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN23   ], (ULONG*) &man[who].maxhp);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN24   ], (ULONG*) &man[who].curvi);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN25   ], (ULONG*) &man[who].maxvi);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN26   ], (ULONG*) &man[who].cursp);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_BW_IN27   ], (ULONG*) &man[who].maxsp);

    // assert(SpellsList->lh_Head->ln_Succ); // the list is non-empty
    i = 0;
    // Walk the list
    for
    (   NodePtr = SpellsList.lh_Head;
        NodePtr->ln_Succ;
        NodePtr = NodePtr->ln_Succ
    )
    {   DISCARD GetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (ULONG*) &man[who].spell[i]);
        i++;
}   }

MODULE void writeman(void)
{   int          i;
    struct Node* NodePtr;

    SetGadgetAttrs(gadgets[GID_BW_IN1 ], MainWindowPtr, NULL, INTEGER_Number,     man[who].st,           TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN2 ], MainWindowPtr, NULL, INTEGER_Number,     man[who].iq,           TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN3 ], MainWindowPtr, NULL, INTEGER_Number,     man[who].ag,           TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN4 ], MainWindowPtr, NULL, INTEGER_Number,     man[who].ch,           TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN5 ], MainWindowPtr, NULL, INTEGER_Number,     man[who].level,        TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN6 ], MainWindowPtr, NULL, INTEGER_Number,     man[who].coins,        TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN7 ], MainWindowPtr, NULL, INTEGER_Number,     man[who].keys,         TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN8 ], MainWindowPtr, NULL, INTEGER_Number,     man[who].normalarrows, TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN9 ], MainWindowPtr, NULL, INTEGER_Number,     man[who].elfarrows,    TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN10], MainWindowPtr, NULL, INTEGER_Number,     man[who].armour,       TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN21], MainWindowPtr, NULL, INTEGER_Number,     man[who].food,         TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN22], MainWindowPtr, NULL, INTEGER_Number,     man[who].curhp,        INTEGER_Maximum, (game == BW1) ? 99 : 9999, TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN23], MainWindowPtr, NULL, INTEGER_Number,     man[who].maxhp,        INTEGER_Maximum, (game == BW1) ? 99 : 9999, TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN24], MainWindowPtr, NULL, INTEGER_Number,     man[who].curvi,        TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN25], MainWindowPtr, NULL, INTEGER_Number,     man[who].maxvi,        TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN26], MainWindowPtr, NULL, INTEGER_Number,     man[who].cursp,        TAG_END); // autorefreshes
    SetGadgetAttrs(gadgets[GID_BW_IN27], MainWindowPtr, NULL, INTEGER_Number,     man[who].maxsp,        TAG_END); // autorefreshes

    SetGadgetAttrs(gadgets[GID_BW_LB2 ], MainWindowPtr, NULL, LISTBROWSER_Labels, ~0,                    TAG_END);
    // assert(SpellsList.lh_Head->ln_Succ); // the list is non-empty
    i = 0;
    // Walk the list
    for
    (   NodePtr = SpellsList.lh_Head;
        NodePtr->ln_Succ;
        NodePtr = NodePtr->ln_Succ
    )
    {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (BOOL) man[who].spell[i], TAG_END);
        i++;
    }
    SetGadgetAttrs(gadgets[GID_BW_LB2], MainWindowPtr, NULL, LISTBROWSER_Labels,  (ULONG) &SpellsList,   TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_BW_LB2], MainWindowPtr, NULL);

    for (i = 0; i < 12; i++)
    {   strcpy(itemdisplay[i], ItemNames[man[who].item[i]][game]);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_BW_BU3 + i], MainWindowPtr, NULL,
            GA_Text, itemdisplay[i],
        TAG_DONE); // this autorefreshes
}   }

EXPORT void bw_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  BW1: gamesave("bloodsave?", "Bloodwych (Original Levels)", saveas, 50688, FLAG_S, FALSE);
    acase BW2: gamesave("bextsave?" , "Bloodwych (Extended Levels)", saveas, 50688, FLAG_S, FALSE);
}   }

EXPORT void bw_exit(void)
{   lb_clearlist(&ItemsList);
    ch_clearlist(&Facing1List);
    ch_clearlist(&Facing2List);
    ch_clearlist(&NamesList);
}

EXPORT void bw_close(void) { ; }

EXPORT void bw_die(void)
{   lb_clearlist(&SpellsList);
}

MODULE void maximize_man(int whichman)
{   int i;

    man[whichman].armour       =   0;

    man[whichman].level        =
    man[whichman].st           =
    man[whichman].iq           =
    man[whichman].ag           =
    man[whichman].ch           =
    man[whichman].coins        =
    man[whichman].keys         =
    man[whichman].normalarrows =
    man[whichman].elfarrows    =
    man[whichman].curhp        =
    man[whichman].maxhp        =
    man[whichman].curvi        =
    man[whichman].maxvi        =
    man[whichman].cursp        =
    man[whichman].maxsp        =  90;

    man[whichman].food         = 250;

    for (i = 0; i < 32; i++)
    {   man[whichman].spell[i] = TRUE;
}   }

MODULE void itemwindow(void)
{   int          i,
                 whichimage;
    struct Node* ListBrowserNodePtr;

    NewList(&ItemsList);
    for (i = 0; i < ITEMS; i++)
    {   if (i == 0)
        {   switch (whichitem)
            {
            case  0:  whichimage = 666; // left hand
            acase 1:  whichimage = 667; // right hand
            acase 2:  whichimage = 668; // torso
            acase 3:  whichimage = 669; // shield
            adefault: whichimage = 556; // pocket
        }   }
        else
        {   if (game == BW2)
            {   switch (i)
                {
                case  36: whichimage = 686     ; // rune shield (red)
                acase 37: whichimage = 687     ; // rune shield (green)
                acase 38: whichimage = 688     ; // rune shield (black)
                acase 39: whichimage = 556 + 42; // war shield
                acase 40: whichimage = 689     ; // demon shield
                acase 41: whichimage = 690     ; // battle soul
                acase 42: whichimage = 691     ; // chromatic plate
                acase 50: whichimage = 692     ; // adamant sword
                acase 51: whichimage = 556 + 53; // fleshbane
                acase 52: whichimage = 556 + 54; // demon blade
                acase 53: whichimage = 693     ; // rune sword
                acase 54: whichimage = 694     ; // soul sucker
                acase 56: whichimage = 695     ; // adamant axe
                acase 57: whichimage = 696     ; // ogre's axe
                acase 58: whichimage = 556 + 60; // deathbringer
                acase 59: whichimage = 697     ; // dragon axe
                acase 60: whichimage = 698     ; // grey axe
                adefault: whichimage = 556 +  i;
            }   }
            else
            {   whichimage = 556 + i;
        }   }
        load_images(whichimage, whichimage);
        if (!(ListBrowserNodePtr = (struct Node*) AllocListBrowserNode
        (   2,              // columns
            LBNA_Column,    0,
             LBNCA_Image,   image[whichimage],
             LBNA_Column,   1,
            LBNCA_CopyText, TRUE,
             LBNCA_Text,    ItemNames[i][game],
        TAG_END)))
        {   rq("Can't create listbrowser.gadget node(s)!");
        }
        AddTail(&ItemsList, ListBrowserNodePtr); /* AddTail() has no return code */
    }

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Choose Item",
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "bw-1",
        WINDOW_ParentGroup,                    gadgets[GID_BW_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_BW_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_BW_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_ColumnInfo,        (ULONG) &TheColumnInfo,
                LISTBROWSER_Labels,            (ULONG) &ItemsList,
                LISTBROWSER_AutoFit,           TRUE,
                LISTBROWSER_VertSeparators,    FALSE,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    192,
            CHILD_MinHeight,                   416,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    DISCARD SetGadgetAttrs(         gadgets[GID_BW_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,              ~0,                       TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_BW_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,              &ItemsList,               TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_BW_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man[who].item[whichitem], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_BW_LB1], SubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(         gadgets[GID_BW_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man[who].item[whichitem], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_BW_LB1], SubWindowPtr, NULL);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;

    lb_clearlist(&ItemsList);
}

EXPORT FLAG bw_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_BW_LB1:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_BW_LB1], (ULONG*) &man[who].item[whichitem]);
        writegadgets();
        return TRUE;
    }

    return FALSE;
}

EXPORT FLAG bw_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        lb_move_up(GID_BW_LB1, SubWindowPtr, qual, &man[who].item[whichitem], 0, 5);
        writegadgets();
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_move_down(GID_BW_LB1, SubWindowPtr, qual, &man[who].item[whichitem], ITEMS - 1, 5);
        writegadgets();
    acase SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    }
    return FALSE;
}

MODULE void serialize(void)
{   int   i, j;
    ULONG t;

    offset = 0;

    for (i = 0; i < 16; i++)
    {   serialize1(&man[i].level);            //  $00      / $00
        if (game == BW2) offset++;            // ----------/ $01
        serialize1(&man[i].st);               //  $01      / $02
        serialize1(&man[i].ag);               //  $02      / $03
        serialize1(&man[i].iq);               //  $03      / $04
        serialize1(&man[i].ch);               //  $04      / $05
        if (game == BW1)
        {   serialize1(&man[i].curhp);        //  $05      / $07
            serialize1(&man[i].maxhp);        //  $06      / $09
        } else
        {   serialize2ulong(&man[i].curhp);   //  $05      / $06..$07
            serialize2ulong(&man[i].maxhp);   //  $06      / $08..$09
        }
        serialize1(&man[i].curvi);            //  $07      / $0A
        serialize1(&man[i].maxvi);            //  $08      / $0B
        serialize1(&man[i].cursp);            //  $09      / $0C
        serialize1(&man[i].maxsp);            //  $0A      / $0D
        man[i].armour = 10 - man[i].armour;
        serialize1(&man[i].armour);           //  $0B      / $0E
        man[i].armour = 10 - man[i].armour;
        if (game == BW2) offset++;            // ----------/ $0F
        if (serializemode == SERIALIZE_READ)
        {   serialize4(&t);                   //  $0C.. $0F/ $10..$13
            for (j = 0; j < 32; j++)
            {   if (t & (1 << (31 - j)))
                {   man[i].spell[j] = TRUE;
                } else
                {   man[i].spell[j] = FALSE;
        }   }   }
        else
        {   // assert(serializemode == SERIALIZE_WRITE);
            t = 0;
            for (j = 0; j < 32; j++)
            {   if (man[i].spell[j])
                {   t |= (1 << (31 - j));
            }   }
            serialize4(&t);                   //  $0C.. $0F/ $10..$13
        }
        serialize1(&man[i].food);             //  $10      / $14
        if (game == BW1)
        {   offset += 15;                     //  $11.. $1F/---------
        } else
        {   offset += 27;                     // ----------/ $15..$2F
            for (j = 0; j < 12; j++)
            {   serialize1(&man[i].item[j]);  // ----------/ $30..$3B
            }
            serialize1(&man[i].coins);        // ----------/ $3C
            serialize1(&man[i].keys);         // ----------/ $3D
            serialize1(&man[i].normalarrows); // ----------/ $3E
            serialize1(&man[i].elfarrows);    // ----------/ $3F
    }   }

    // assert((game == BW1 && offset == 0x200) || (game == BW2 && offset == 0x400));

    if (game == BW1)                          // $200..$2FF/---------
    {   for (i = 0; i < 16; i++)
        {   for (j = 0; j < 12; j++)
            {   serialize1(&man[i].item[j]);  //  $00.. $0B/---------
            }
            serialize1(&man[i].coins);        //  $0C      /---------
            serialize1(&man[i].keys);         //  $0D      /---------
            serialize1(&man[i].normalarrows); //  $0E      /---------
            serialize1(&man[i].elfarrows);    //  $0F      /---------
        }

        // assert(offset = 0x300);
    }

    if (game == BW1) offset = 0x36F; else offset = 0x46F;
    serialize1(&location_x[0]);               // $36F      /$46F
    offset++;                                 // $370      /$470
    serialize1(&location_y[0]);               // $371      /$471
    offset++;                                 // $372      /$472
    serialize1(&facing[0]);                   // $373      /$473

    if (game == BW1) offset = 0x3D1; else offset = 0x4D1;
    serialize1(&location_x[1]);               // $3D1      /$4D1
    offset++;                                 // $3D2      /$4D2
    serialize1(&location_y[1]);               // $3D3      /$4D3
    offset++;                                 // $3D4      /$4D4
    serialize1(&facing[1]);                   // $3D5      /$4D5
}

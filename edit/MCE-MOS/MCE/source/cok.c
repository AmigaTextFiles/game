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

#define GID_COK_LY1    0 // root layout
#define GID_COK_SB1    1 // toolbar
#define GID_COK_ST1    2 // name
#define GID_COK_BU1    3 // maximize
#define GID_COK_BU2    4 // invert selection
#define GID_COK_LB1    5 // spells
#define GID_COK_CH1    6 // sex
#define GID_COK_CH2    7 // alignment
#define GID_COK_CH3    8 // race
#define GID_COK_CH4    9 // class
#define GID_COK_CH5   10 // god
#define GID_COK_CH6   11 // order
#define GID_COK_CH7   12 // robes
#define GID_COK_CH8   13 // status
#define GID_COK_IN1   14 // age
#define GID_COK_IN2   15 // cp
#define GID_COK_IN3   16 // cur hp
#define GID_COK_IN4   17 // max hp
#define GID_COK_IN5   18 // xp
#define GID_COK_IN6   19 // cur str
#define GID_COK_IN7   20 // cur exc str
#define GID_COK_IN8   21 // cur iq
#define GID_COK_IN9   22 // cur wis
#define GID_COK_IN10  23 // cur dex
#define GID_COK_IN11  24 // cur con
#define GID_COK_IN12  25 // cur cha
#define GID_COK_IN13  26 // cleric
#define GID_COK_IN14  27 // fighter
#define GID_COK_IN15  28 // magic-user
#define GID_COK_IN16  29 // thief
#define GID_COK_IN17  30 // knight
#define GID_COK_IN18  31 // paladin
#define GID_COK_IN19  32 // ranger
#define GID_COK_IN20  33 // bp
#define GID_COK_IN21  34 // pp
#define GID_COK_IN22  35 // sp
#define GID_COK_IN23  36 // gems
#define GID_COK_IN24  37 // jewels
#define GID_COK_BU3   38 // all
#define GID_COK_BU4   39 // none
#define GID_COK_CH9   40 // game
#define GID_COK_IN25  41 // max str
#define GID_COK_IN26  42 // max exc str
#define GID_COK_IN27  43 // max iq
#define GID_COK_IN28  44 // max wis
#define GID_COK_IN29  45 // max dex
#define GID_COK_IN30  46 // max con
#define GID_COK_IN31  47 // max cha
#define GIDS_COK      GID_COK_IN31

#define COK1           0
#define COK2           1
#define COK3           2

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void eithergadgets(void);
MODULE void maximize_man(void);
MODULE void serialize(void);

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
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SexList,
                            SpeedBarList;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Hook          ToolHookStruct;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Image*        aissimage[AISSIMAGES];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT Object*              WinObject;
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

MODULE ULONG                game;
MODULE struct List          SpellsList;
MODULE const STRPTR GameOptions[3 + 1] =
{ "Champions of Krynn",
  "Death Knights of Krynn",
  "Dark Queen of Krynn",
  NULL
};

MODULE struct
{  TEXT  name[15 + 1];
   ULONG maxstr, maxexcstr, maxiq, maxwis, maxdex, maxcon, maxcha,
         curstr, curexcstr, curiq, curwis, curdex, curcon, curcha,
         curhp, maxhp, xp, age,
         sex, alignment, race, theclass,
         cleric, fighter, mage, thief,
         order, god, robes,
         spell[80],
         cp, bp, pp, sp, gems, jewels,
         paladin, ranger, knight,
         status;
} man;

MODULE const STRPTR AlignmentOptions[9 + 1] =
{ "Lawful Good",
  "Lawful Neutral",
  "Lawful Evil",
  "Neutral Good",
  "True Neutral",
  "Neutral Evil",
  "Chaotic Good",
  "Chaotic Neutral",
  "Chaotic Evil",
  NULL
}, ClassOptions[17 + 1] =
{ "Cleric",              //  0
  "Druid (COK1&2)/Knight (COK3)",
  "Fighter",
  "Paladin",
  "Ranger",
  "Mage",                //  5
  "Thief",
  "Knight (COK1&2)/Monk (COK3)",
  "Cleric/Fighter",
  "Cleric/Fighter/Mage",
  "Cleric/Ranger",       // 10
  "Cleric/Mage",
  "Cleric/Thief",
  "Fighter/Mage",
  "Fighter/Thief",
  "Fighter/Mage/Thief",  // 15
  "Mage/Thief",
  NULL                   // 17
}, OrderOptions[4 + 1] =
{ "None",
  "Knight of the Crown",
  "Knight of the Sword",
  "Knight of the Rose",
  NULL
}, GodOptions[8 + 1] =
{ "None/Renegade Cleric",
  "Paladine",
  "Majere",
  "Kiri-Solith",
  "Mishakal",
  "Sirrion",
  "Reorx",
  "Shinare",
  NULL
}, RaceOptions[8 + 1] =
{ "Silvanesti Elf",
  "Qualinesti Elf",
  "Half-Elf",
  "Mountain Dwarf",
  "Hill Dwarf",
  "Kender",
  "Human",
  "Monster",
  NULL
}, RobeOptions[5 + 1] =
{ "None",
  "White",
  "Red",
  "Black",
  "Renegade Mage",
  NULL
}, StatusOptions[10 + 1] =
{ "OK",
  "Animated",
  "Temporarily gone",
  "Running",
  "Unconscious",
  "Dying",
  "Dead",
  "Stoned",
  "Permanently gone",
  "Silver (COK1&2)/Blank (COK3)",
  NULL
}, SpellOptions[80] =
{ "Bless",                                    // $66 C1
  "Curse",                                    // $67 C1
  "Cure Light Wounds",                        // $68 C1*
  "Cause Light Wounds",                       // $69 C1
  "Detect Magic (Cleric)",                    // $6A C1*
  "Protection from Evil (Cleric)",            // $6B C1*
  "Protection from Good (Cleric)",            // $6C C1
  "Resist Cold",                              // $6D C1*
  "Burning Hands",                            // $6E R1
  "Charm Person",                             // $6F W1
  "Detect Magic (Mage)",                      // $70 B1
  "Enlarge",                                  // $71 R1
  "Reduce",                                   // $72 R1
  "Friends",                                  // $73 W1
  "Magic Missile",                            // $74 B1
  "Protection from Evil (Mage)",              // $75 W1
  "Protection from Good (Mage)",              // $76 W1
  "Read Magic",                               // $77 B1
  "Shield",                                   // $78 B1
  "Shocking Grasp",                           // $79 R1
  "Sleep",                                    // $7A W1
  "Find Traps",                               // $7B C2
  "Hold Person (Cleric)",                     // $7C C2
  "Resist Fire",                              // $7D C2
  "Silence 15' Radius",                       // $7E C2
  "Slow Poison",                              // $7F C2
  "Snake Charm",                              // $80 C2
  "Spiritual Hammer",                         // $81 C2
  "Detect Invisibility",                      // $82 B2
  "Invisibility",                             // $83 R2
  "Knock",                                    // $84 R2
  "Mirror Image",                             // $85 R2
  "Ray of Enfeeblement",                      // $86 W2
  "Stinking Cloud",                           // $87 B2
  "Strength",                                 // $88 R2
  "Cure Blindness",                           // $8A C3
  "Cause Blindness",                          // $8B C3
  "Cure Disease",                             // $8C C3
  "Cause Disease",                            // $8D C3
  "Dispel Magic (Cleric)",                    // $8E C3
  "Prayer",                                   // $8F C3
  "Remove Curse (Cleric)",                    // $90 C3
  "Bestow Curse",                             // $91 C3
  "Blink",                                    // $92 R3
  "Dispel Magic (Mage)",                      // $93 W3
  "Fireball",                                 // $94 B3
  "Haste",                                    // $95 R3
  "Hold Person (Mage)",                       // $96 W3
  "Invisibility 10' Radius",                  // $97 R3
  "Lightning Bolt",                           // $98 B3
  "Protection from Evil 10' Radius (Mage)",   // $99 W3
  "Protection from Good 10' Radius (Mage)",   // $9A W3
  "Protection from Normal Missiles",          // $9B W3
  "Slow",                                     // $9C R3
  "Restoration",                              // $9D C7
  "Cure Serious Wounds",                      // $9F C4
  "Cause Serious Wounds",                     // $A7 C4
  "Neutralize Poison",                        // $A8 C4
  "Poison",                                   // $A9 C4
  "Protection from Evil 10' Radius (Cleric)", // $AA C4
  "Sticks to Snakes",                         // $AB C4
  "Cure Critical Wounds",                     // $AC C5
  "Cause Critical Wounds",                    // $AD C5
  "Dispel Evil",                              // $AE C5
  "Flame Strike",                             // $AF C5
  "Raise Dead",                               // $B0 C5
  "Slay Living",                              // $B1 C5
  "Charm Monsters",                           // $B6 W4
  "Confusion",                                // $B7 W4
  "Dimension Door",                           // $B8 R4
  "Fear",                                     // $B9 R4
  "Fire Shield",                              // $BA B4
  "Fumble",                                   // $BB W4
  "Ice Storm",                                // $BC B4
  "Minor Globe of Invulnerability",           // $BD W4
  "Remove Curse (Mage)",                      // $BE W4
  "Cloud Kill",                               // $C0 M5
  "Cone of Cold",                             // $C1 M5
  "Feeblemind",                               // $C2 M5
  "Hold Monsters"                             // $C3 M5
  // no NULL is required
};
/* B = White/Red Mage
   C = Cleric
   D = Druid
   M = Mage
   R = Red Mage
   W = White Mage */

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  3... .... .... ....    . = Transparent (%00)
    .3.. .... .... ....    1 = Dark  grey  (%01) ($555)
    ..23 .... .... ....    2 = Light grey  (%10) ($AAA)
    ..12 33.. .... ....    3 = White       (%11) ($FFF)
    ...2 1332 .... ....
    ...1 2133 .... ....
    .... 1213 3... ....
    .... 1121 3... ....
    .... ..12 3... 3...
    .... .... .3.3 2...
    .... .... ..32 ....
    .... .... .221 3333
    .... .... 22.2 332.
    .... .... ...2 22..
    .... .... ...1 2.23
    .... .... ...1 ..12

          Plane 0                Plane 1      
    3... .... .... ....    3... .... .... ....
    .3.. .... .... ....    .3.. .... .... ....
    ...3 .... .... ....    ..23 .... .... ....
    ..1. 33.. .... ....    ...2 33.. .... ....
    .... 133. .... ....    ...2 .332 .... ....
    ...1 .133 .... ....    .... 2.33 .... ....
    .... 1.13 3... ....    .... .2.3 3... ....
    .... 11.1 3... ....    .... ..2. 3... ....
    .... ..1. 3... 3...    .... ...2 3... 3...
    .... .... .3.3 ....    .... .... .3.3 2...
    .... .... ..3. ....    .... .... ..32 ....
    .... .... ...1 3333    .... .... .22. 3333
    .... .... .... 33..    .... .... 22.2 332.
    .... .... .... ....    .... .... ...2 22..
    .... .... ...1 ...3    .... .... .... 2.23
    .... .... ...1 ..1.    .... .... .... ...2
     Dark grey & White     Light grey & White

    Plane 0 Plane 1 */
    0x8000, 0x8000,
    0x4000, 0x4000,
    0x1000, 0x3000,
    0x2C00, 0x1C00,
    0x0E00, 0x1700,
    0x1700, 0x0B00,
    0x0B80, 0x0580,
    0x0D80, 0x0280,
    0x0288, 0x0188,
    0x0050, 0x0058,
    0x0020, 0x0030,
    0x001F, 0x006F,
    0x000C, 0x00DE,
    0x0000, 0x001C,
    0x0011, 0x000B,
    0x0012, 0x0001,

    0x0000, 0x0000, // reserved
};
#endif

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void cok_main(void)
{   TRANSIENT int          i;
    TRANSIENT struct Node* NodePtr;
    PERSIST   FLAG         first = TRUE;

    if (first)
    {   first = FALSE;

        // cok_preinit()
        NewList(&SpellsList);

        // cok_init()
        for (i = 0; i < 80; i++)
        {   NodePtr = (struct Node*) AllocListBrowserNode
            (   1,
                LBNCA_Text,    SpellOptions[i],
                LBNA_CheckBox, TRUE,
            TAG_END);
            // we should check NodePtr is non-zero
            AddTail(&SpellsList, (struct Node*) NodePtr);
    }   }

    tool_open  = cok_open;
    tool_loop  = cok_loop;
    tool_save  = cok_save;
    tool_close = cok_close;
    tool_exit  = cok_exit;

    if (loaded != FUNC_COK && !cok_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_COK;

    make_speedbar_list(GID_COK_SB1);
    load_aiss_images( 6, 8);
    load_aiss_images(10, 10);
    makesexlist();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                 TRUE,
        WA_ThinSizeGadget,                             TRUE,
        WINDOW_LockHeight,                             TRUE,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                            gadgets[GID_COK_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_SpaceInner,                         TRUE,
            LAYOUT_DeferLayout,                        TRUE,
            AddHLayout,
                AddToolbar(GID_COK_SB1),
                AddSpace,
                CHILD_WeightedWidth,                   50,
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_COK_CH9] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                         GID_COK_CH9,
                        GA_Disabled,                   TRUE,
                        CHOOSER_LabelArray,            &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,              0,
                LayoutEnd,
                CHILD_WeightedWidth,                   0,
                AddSpace,
                CHILD_WeightedWidth,                   50,
            LayoutEnd,
            AddHLayout,
                AddHLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "General",
                    AddVLayout,
                        AddLabel("Name:"),
                        AddLabel("Sex:"),
                        AddLabel("Alignment:"),
                        AddLabel("Race:"),
                        AddLabel("Class:"),
                        AddLabel("Condition:"),
                        AddLabel("God:"),
                        AddLabel("Order:"),
                        AddLabel("Robes:"),
                        AddLabel("Age:"),
                        AddLabel("Copper Pieces:"),
                        AddLabel("Bronze Pieces:"),
                        AddLabel("Platinum Pieces:"),
                        AddLabel("Steel Pieces:"),
                        AddLabel("Gems:"),
                        AddLabel("Jewellery:"),
                        AddLabel("Hit Points:"),
                        AddLabel("Experience Points:"),
                    LayoutEnd,
                    CHILD_WeightedWidth,               0,
                    AddVLayout,
                        LAYOUT_AddChild,               gadgets[GID_COK_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                     GID_COK_ST1,
                            GA_TabCycle,               TRUE,
                            GA_RelVerify,              TRUE,
                            STRINGA_TextVal,           man.name,
                            STRINGA_MaxChars,          15 + 1,
                        StringEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_CH1] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                     GID_COK_CH1,
                            CHOOSER_Labels,            &SexList,
                        PopUpEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_CH2] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                     GID_COK_CH2,
                            CHOOSER_LabelArray,        &AlignmentOptions,
                        PopUpEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_CH3] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                     GID_COK_CH3,
                            CHOOSER_LabelArray,        &RaceOptions,
                        PopUpEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_CH4] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                     GID_COK_CH4,
                            CHOOSER_LabelArray,        &ClassOptions,
                            CHOOSER_MaxLabels,         17,
                        PopUpEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_CH8] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                     GID_COK_CH8,
                            CHOOSER_LabelArray,        &StatusOptions,
                        PopUpEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_CH5] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                     GID_COK_CH5,
                            CHOOSER_LabelArray,        &GodOptions,
                        PopUpEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_CH6] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                     GID_COK_CH6,
                            CHOOSER_LabelArray,        &OrderOptions,
                        PopUpEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_CH7] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                     GID_COK_CH7,
                            CHOOSER_LabelArray,        &RobeOptions,
                        PopUpEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN1,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           1000,
                            INTEGER_MinVisible,        4 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN2,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           32767,
                            INTEGER_MinVisible,        5 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN20] = (struct Gadget*)
                            IntegerObject,
                            GA_ID,                     GID_COK_IN20,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           32767,
                            INTEGER_MinVisible,        5 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN21] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN21,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           32767,
                            INTEGER_MinVisible,        5 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN22] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN22,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           32767,
                            INTEGER_MinVisible,        5 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN23] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN23,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           32767,
                            INTEGER_MinVisible,        5 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN24] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN24,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           32767,
                            INTEGER_MinVisible,        5 + 1,
                        IntegerEnd,
                        AddHLayout,
                            LAYOUT_VertAlignment,      LALIGN_CENTER,
                            LAYOUT_AddChild,           gadgets[GID_COK_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_COK_IN3,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       0,
                                INTEGER_Maximum,       254,
                                INTEGER_MinVisible,    3 + 1,
                            IntegerEnd,
                            AddLabel("of"),
                            LAYOUT_AddChild,           gadgets[GID_COK_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_COK_IN4,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       1,
                                INTEGER_Maximum,       254,
                                INTEGER_MinVisible,    3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,          0,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN5,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           SLONG_MAX, // this doesn't seem to work
                            INTEGER_MinVisible,        13 + 1,
                        IntegerEnd,
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Spellbook",
                    LAYOUT_AddChild,                   gadgets[GID_COK_LB1] = (struct Gadget*)
                    ListBrowserObject,
                        GA_ID,                         GID_COK_LB1,
                        GA_RelVerify,                  TRUE,
                        LISTBROWSER_Labels,            (ULONG) &SpellsList,
                        LISTBROWSER_ShowSelected,      TRUE,
                        LISTBROWSER_AutoWheel,         FALSE,
                    ListBrowserEnd,
                    HTripleButton(GID_COK_BU3, GID_COK_BU2, GID_COK_BU4),
                LayoutEnd,
            LayoutEnd,
            AddHLayout,
                AddHLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Attributes",
                    AddVLayout,
                        AddLabel("Strength:"),
                        AddLabel("Intelligence:"),
                        AddLabel("Wisdom:"),
                        AddLabel("Dexterity:"),
                        AddLabel("Constitution:"),
                        AddLabel("Charisma:"),
                    LayoutEnd,
                    CHILD_WeightedWidth,               0,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_VertAlignment,      LALIGN_CENTER,
                            LAYOUT_AddChild,           gadgets[GID_COK_IN6] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_COK_IN6,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       1,
                                INTEGER_Maximum,       25,
                                INTEGER_MinVisible,    2 + 1,
                            IntegerEnd,
                            AddLabel("/"),
                            LAYOUT_AddChild,           gadgets[GID_COK_IN7] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_COK_IN7,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       0,
                                INTEGER_Maximum,       100,
                                INTEGER_MinVisible,    3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,          0,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN8,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           25,
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN9] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN9,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           25,
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN10] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN10,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           25,
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN11] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN11,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           25,
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN12] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN12,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           25,
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                    LayoutEnd,
                    AddVLayout,
                        AddLabel("of"),
                        AddLabel("of"),
                        AddLabel("of"),
                        AddLabel("of"),
                        AddLabel("of"),
                        AddLabel("of"),
                    LayoutEnd,
                    CHILD_WeightedWidth,               0,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_VertAlignment,      LALIGN_CENTER,
                            LAYOUT_AddChild,           gadgets[GID_COK_IN25] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_COK_IN25,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       1,
                                INTEGER_Maximum,       25,
                                INTEGER_MinVisible,    2 + 1,
                            IntegerEnd,
                            AddLabel("/"),
                            LAYOUT_AddChild,           gadgets[GID_COK_IN26] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                 GID_COK_IN26,
                                GA_TabCycle,           TRUE,
                                INTEGER_Minimum,       0,
                                INTEGER_Maximum,       100,
                                INTEGER_MinVisible,    3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,          0,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN27] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN27,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           25,
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN28] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN28,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           25,
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN29] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN29,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           25,
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN30] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN30,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           25,
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN31] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN31,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           1,
                            INTEGER_Maximum,           25,
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                    LayoutEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                  0,
                AddHLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Levels",
                    AddVLayout,
                        AddLabel("Cleric:"),
                        AddLabel("Fighter:"),
                        AddLabel("Paladin:"),
                        AddLabel("Ranger:"),
                        AddLabel("Mage:"),
                        AddLabel("Thief:"),
                        AddLabel("Knight:"),
                    LayoutEnd,
                    CHILD_WeightedWidth,               0,
                    AddVLayout,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN13] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN13,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           127,
                            INTEGER_MinVisible,        3 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN14] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN14,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           127,
                            INTEGER_MinVisible,        3 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN18] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN18,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           127,
                            INTEGER_MinVisible,        3 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN19] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN19,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           127,
                            INTEGER_MinVisible,        3 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN15] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN15,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           127,
                            INTEGER_MinVisible,        3 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN16] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN16,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           127,
                            INTEGER_MinVisible,        3 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_COK_IN17] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_COK_IN17,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           127,
                            INTEGER_MinVisible,        3 + 1,
                        IntegerEnd,
                    LayoutEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                  0,
            LayoutEnd,
            MaximizeButton(GID_COK_BU1, "Maximize Character"),
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_COK_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_COK_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_COK_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void cok_loop(ULONG gid, UNUSED ULONG code)
{   int i;

    switch (gid)
    {
    case GID_COK_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_COK_BU2:
        readgadgets();
        for (i = 0; i < 80; i++)
        {   if (man.spell[i])
            {   man.spell[i] = 0;
            } else
            {   man.spell[i] = 1;
        }   }
        writegadgets();
    acase GID_COK_BU3:
        readgadgets();
        for (i = 0; i < 80; i++)
        {   man.spell[i] = 1;
        }
        writegadgets();
    acase GID_COK_BU4:
        readgadgets();
        for (i = 0; i < 80; i++)
        {   man.spell[i] = 0;
        }
        writegadgets();
}   }

EXPORT FLAG cok_open(FLAG loadas)
{   if (gameopen(loadas))
    {   switch (gamesize)
        {
        case 426:
            game = COK1;
        acase 232:
            game = COK2;
        adefault: // eg. 478, 496
            game = COK3;
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
    (   page != FUNC_COK
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    ghost(GID_COK_IN2,  game == COK3);
    ghost(GID_COK_IN20, game == COK3);
    ghost(GID_COK_IN21, game == COK3);
    ghost(GID_COK_LB1,  game == COK3);
    ghost(GID_COK_BU2,  game == COK3);
    ghost(GID_COK_BU3,  game == COK3);
    ghost(GID_COK_BU4,  game == COK3);
}

MODULE void serialize(void)
{   int i;

    switch (game)
    {
    case COK1:
        offset = 0x10;
        serialize1(&man.maxstr   );    // $10
        serialize1(&man.curstr   );    // $11
        serialize1(&man.maxiq    );    // $12
        serialize1(&man.curiq    );    // $13
        serialize1(&man.maxwis   );    // $14
        serialize1(&man.curwis   );    // $15
        serialize1(&man.maxdex   );    // $16
        serialize1(&man.curdex   );    // $17
        serialize1(&man.maxcon   );    // $18
        serialize1(&man.curcon   );    // $19
        serialize1(&man.maxcha   );    // $1A
        serialize1(&man.curcha   );    // $1B
        serialize1(&man.maxexcstr);    // $1C
        serialize1(&man.curexcstr);    // $1D
        offset = 91;
        serialize1(&man.race);         //  91
        serialize1(&man.theclass);     //  92
        serialize1(&man.order);        //  93
        serialize1(&man.god);          //  94
        serialize1(&man.robes);        //  95
        offset += 2;                   //  96.. 97
        serialize2ulong(&man.age);     //  98.. 99
        serialize1(&man.maxhp);        // 100

        offset++;                      // 101
        for (i = 0; i < 35; i++)
        {   serialize1(&man.spell[i]); // 102..136 ($66..$88)
        }
        offset++;                      // 137      ($89)
        for (i = 36; i < 56; i++)
        {   serialize1(&man.spell[i]); // 138..157 ($8A..$9D)
        }
        offset++;                      // 158      ($9E)
        serialize1(&man.spell[56]);    // 159      ($9F)
        offset += 7;                   // 160..166 ($A0..$A6)
        for (i = 57; i < 68; i++)
        {   serialize1(&man.spell[i]); // 167..177 ($A7..$B1)
        }

        offset += 64;                  // 178..241
        serialize2ulong(&man.cp);      // 242..243
        serialize2ulong(&man.bp);      // 244..245
        serialize2ulong(&man.pp);      // 246..247
        serialize2ulong(&man.sp);      // 248..249
        serialize2ulong(&man.gems);    // 250..251
        serialize2ulong(&man.jewels);  // 252..253
        serialize1(&man.cleric);       // 254
        offset++;                      // 255
        serialize1(&man.fighter);      // 256
        serialize1(&man.paladin);      // 257
        serialize1(&man.ranger);       // 258
        serialize1(&man.mage);         // 259
        serialize1(&man.thief);        // 260
        serialize1(&man.knight);       // 261
        offset += 8;                   // 262..269
        serialize1(&man.sex);          // 270
        serialize1(&man.alignment);    // 271
        offset += 14;                  // 272..285
        serialize4(&man.xp);           // 286..289
        offset += 117;                 // 290..406
        // 335 ($14F) holds the number of items carried
        serialize1(&man.status);       // 407
        offset += 16;                  // 408..423
        serialize1(&man.curhp);        // 424

        offset = 0;
    acase COK2:
        offset = 0x10;
        serialize1(&man.maxstr   );    // $10
        serialize1(&man.curstr   );    // $11
        serialize1(&man.maxiq    );    // $12
        serialize1(&man.curiq    );    // $13
        serialize1(&man.maxwis   );    // $14
        serialize1(&man.curwis   );    // $15
        serialize1(&man.maxdex   );    // $16
        serialize1(&man.curdex   );    // $17
        serialize1(&man.maxcon   );    // $18
        serialize1(&man.curcon   );    // $19
        serialize1(&man.maxcha   );    // $1A
        serialize1(&man.curcha   );    // $1B
        serialize1(&man.maxexcstr);    // $1C
        serialize1(&man.curexcstr);    // $1D
        offset += 3;                   // $1E..$20
        serialize1(&man.race);         // $21
        serialize1(&man.theclass);     // $22
        serialize1(&man.order);        // $23
        serialize1(&man.god);          // $24
        serialize1(&man.robes);        // $25
        offset += 2;                   // $26..$27
        serialize2ulong(&man.age);     // $28..$29
        serialize1(&man.maxhp);        // $2A
        offset = 0x46;
        serialize2ulong(&man.gems);    // $46..$47
        serialize2ulong(&man.jewels);  // $48..$49
        serialize1(&man.cleric);       // $4A
        offset++;
        serialize1(&man.fighter);      // $4C
        serialize1(&man.paladin);      // $4D
        serialize1(&man.ranger);       // $4E
        serialize1(&man.mage);         // $4F
        serialize1(&man.thief);        // $50
        serialize1(&man.knight);       // $51
        offset = 0x5A;
        serialize1(&man.sex);          // $5A
        serialize1(&man.alignment);    // $5B
        offset = 0x6A;
        serialize4(&man.xp);           // $6A..$6D
        offset = 0xC4;
        serialize2ulong(&man.sp);      // $C4..$C5
        offset = 0xD5;
        serialize1(&man.status);       // $D5
        offset = 0xE6;
        serialize1(&man.curhp);        // $E6

        man.cp =
        man.bp =
        man.pp = 0;
        for (i = 0; i < 80; i++)
        {   man.spell[i] = 0;
        }

        offset = 0;
    acase COK3:
        offset = 0x44;
        serialize4(&man.xp);           // $44..$47
        offset = 0x4C;
        serialize2ulong(&man.sp);      // $4C..$4D
        serialize2ulong(&man.gems);    // $4E..$4F
        serialize2ulong(&man.jewels);  // $50..$51
        serialize2ulong(&man.age);     // $52..$53
        offset = 0x58;
        serialize1(&man.race);         // $58
        serialize1(&man.theclass);     // $59
        offset = 0x5C;
        serialize1(&man.sex);          // $5C
        serialize1(&man.alignment);    // $5D
        serialize1(&man.status);       // $5E
        offset = 0x70;
        serialize1(&man.maxstr   );    // $70
        serialize1(&man.curstr   );    // $71
        serialize1(&man.maxiq    );    // $72
        serialize1(&man.curiq    );    // $73
        serialize1(&man.maxwis   );    // $74
        serialize1(&man.curwis   );    // $75
        serialize1(&man.maxdex   );    // $76
        serialize1(&man.curdex   );    // $77
        serialize1(&man.maxcon   );    // $78
        serialize1(&man.curcon   );    // $79
        serialize1(&man.maxcha   );    // $7A
        serialize1(&man.curcha   );    // $7B
        serialize1(&man.maxexcstr);    // $7C
        serialize1(&man.curexcstr);    // $7D
        offset = 0x81;
        serialize1(&man.maxhp );       // $81
        offset = 0x9D;
        serialize1(&man.cleric);       // $9D
        serialize1(&man.knight);       // $9E
        serialize1(&man.fighter);      // $9F
        serialize1(&man.paladin);      // $A0
        serialize1(&man.ranger);       // $A1
        serialize1(&man.mage);         // $A2
        serialize1(&man.thief);        // $A3
        offset = 0x190;
        serialize1(&man.curhp );      // $190
        offset++;
        serialize1(&man.order );      // $192
        serialize1(&man.god   );      // $193
        serialize1(&man.robes );      // $194

        man.cp =
        man.bp =
        man.pp = 0;
        for (i = 0; i < 80; i++)
        {   man.spell[i] = 0;
        }

        offset = 0x60;
    }

    if (serializemode == SERIALIZE_READ)
    {   strcpy(         man.name,         (char*) &IOBuffer[offset]);
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        strcpy((char*) &IOBuffer[offset],          man.name); // 0..15
}   }

EXPORT void cok_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();

    switch (game)
    {
    case  COK1: gamesave("#?.who", "Champions of Krynn"    , saveas,      426, FLAG_C, FALSE);
    acase COK2: gamesave("#?.pch", "Death Knights of Krynn", saveas,      232, FLAG_C, FALSE);
    acase COK3: gamesave("#?.qch", "Dark Queen of Krynn"   , saveas, gamesize, FLAG_C, FALSE);
}   }

EXPORT void cok_close(void) { ; }

EXPORT void cok_exit(void)
{   ch_clearlist(&SexList);
}

EXPORT void cok_die(void)
{   lb_clearlist(&SpellsList);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int          i;
    struct Node* NodePtr;

    if (gadmode == SERIALIZE_READ)
    {   i = 0;
        for
        (   NodePtr = SpellsList.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   DISCARD GetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (ULONG*) &man.spell[i]);
            i++;
    }   }
    else
    {   // assert(gadmode == SERIALIZE_WRITE);

        either_ch(GID_COK_CH9, &game);

        DISCARD SetGadgetAttrs(gadgets[GID_COK_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, ~0,                  TAG_END);
        i = 0;
        for
        (   NodePtr = SpellsList.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (BOOL) man.spell[i], TAG_END);
            i++;
        }
        DISCARD SetGadgetAttrs(gadgets[GID_COK_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, (ULONG) &SpellsList, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_COK_LB1], MainWindowPtr, NULL);
    }

    either_st(GID_COK_ST1,   man.name     );

    either_ch(GID_COK_CH1,  &man.sex      );
    either_ch(GID_COK_CH2,  &man.alignment);
    either_ch(GID_COK_CH3,  &man.race     );
    either_ch(GID_COK_CH4,  &man.theclass );
    either_ch(GID_COK_CH5,  &man.god      );
    either_ch(GID_COK_CH6,  &man.order    );
    either_ch(GID_COK_CH7,  &man.robes    );

    either_in(GID_COK_IN1,  &man.age      );
    either_in(GID_COK_IN2,  &man.cp       );
    either_in(GID_COK_IN3,  &man.curhp    );
    either_in(GID_COK_IN4,  &man.maxhp    );
    either_in(GID_COK_IN5,  &man.xp       );
    either_in(GID_COK_IN6,  &man.curstr   );
    either_in(GID_COK_IN7,  &man.curexcstr);
    either_in(GID_COK_IN8,  &man.curiq    );
    either_in(GID_COK_IN9,  &man.curwis   );
    either_in(GID_COK_IN10, &man.curdex   );
    either_in(GID_COK_IN11, &man.curcon   );
    either_in(GID_COK_IN12, &man.curcha   );
    either_in(GID_COK_IN13, &man.cleric   );
    either_in(GID_COK_IN14, &man.fighter  );
    either_in(GID_COK_IN15, &man.mage     );
    either_in(GID_COK_IN16, &man.thief    );
    either_in(GID_COK_IN17, &man.knight   );
    either_in(GID_COK_IN18, &man.paladin  );
    either_in(GID_COK_IN19, &man.ranger   );
    either_in(GID_COK_IN20, &man.bp       );
    either_in(GID_COK_IN21, &man.pp       );
    either_in(GID_COK_IN22, &man.sp       );
    either_in(GID_COK_IN23, &man.gems     );
    either_in(GID_COK_IN24, &man.jewels   );
    either_in(GID_COK_IN25, &man.maxstr   );
    either_in(GID_COK_IN26, &man.maxexcstr);
    either_in(GID_COK_IN27, &man.maxiq    );
    either_in(GID_COK_IN28, &man.maxwis   );
    either_in(GID_COK_IN29, &man.maxdex   );
    either_in(GID_COK_IN30, &man.maxcon   );
    either_in(GID_COK_IN31, &man.maxcha   );
}

MODULE void maximize_man(void)
{   int i;

    man.maxexcstr =
    man.curexcstr =
    man.status    =           0;
    man.order     =           3;
    man.maxstr    =
    man.maxiq     =
    man.maxwis    =
    man.maxdex    =
    man.maxcon    =
    man.maxcha    =
    man.curstr    =
    man.curiq     =
    man.curwis    =
    man.curdex    =
    man.curcon    =
    man.curcha    =          25;
    man.cleric    =
    man.fighter   =
    man.mage      =
    man.paladin   =
    man.ranger    =
    man.thief     =
    man.knight    =         100;
    man.curhp     =
    man.maxhp     =         250;
    man.sp        =
    man.gems      =
    man.jewels    =       30000;
    man.xp        = ONE_BILLION; // TWO_BILLION is too high for gadget to handle

    if (game == COK1)
    {   man.cp    =
        man.bp    =
        man.pp    =       30000;
        for (i = 0; i < 80; i++)
        {   man.spell[i] = 1;
}   }   }

EXPORT void cok_key(UBYTE scancode, UWORD qual)
{   switch (scancode)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        lb_scroll_up(GID_COK_LB1, MainWindowPtr, qual);
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_scroll_down(GID_COK_LB1, MainWindowPtr, qual);
}   }

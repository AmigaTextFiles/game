// INCLUDES --------------------------------------------------------------

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

#define GID_U_LY_MAIN        0 // root layout
#define GID_U_SB1            1
#define GID_U_IN_MEN         2 // men
#define GID_U_BU2            3 // maximize party
#define GID_U_CH7            4 // game
#define GID_U_BU1            5 // maximize character
#define GID_U_ST1            6 // name
#define GID_U_IN_CURHP       7 // cur hp
#define GID_U_IN_MAXHP       8 // max hp
#define GID_U_IN3            9 // mp
#define GID_U_IN_MAN        10 // man
#define GID_U_IN8           11 // xp
#define GID_U_IN10          12 // str
#define GID_U_IN11          13 // iq
#define GID_U_IN12          14 // dex
#define GID_U345_CH_CLASS   15 // class
#define GID_U_CH2           16 // sex
#define GID_U_CH3           17 // status
#define GID_U34_CH4         18 // armour
#define GID_U34_CH5         19 // weapon
#define GID_U3_IN_FOOD      20 // food (man) (U3)
#define GID_U3_IN_GP        21 // gp   (man) (U3)
#define GID_U3_IN_GEMS      22 // gems (man) (U3)
#define GID_U3_IN_KEYS      23 // keys (man) (U3)
#define GID_U3_IN_POWDERS   24 // powders (U3)
#define GID_U3_IN_TORCHES   25 // torches (man) (U3)
#define GID_U3_IN_WIS       26 // wisdom (U3)
#define GID_U56_IN_LEVEL    27 // level (per man)
#define GID_U3_CH_RACE      28 // race (U3)
#define GID_U3_IN60         29 // 1st armour
#define GID_U3_IN61         30
#define GID_U3_IN62         31
#define GID_U3_IN63         32
#define GID_U3_IN64         33
#define GID_U3_IN65         34
#define GID_U3_IN66         35 // 7th armour
#define GID_U3_IN67         36 // 1st weapon
#define GID_U3_IN68         37
#define GID_U3_IN69         38
#define GID_U3_IN70         39
#define GID_U3_IN71         40
#define GID_U3_IN72         41
#define GID_U3_IN73         42
#define GID_U3_IN74         43
#define GID_U3_IN75         44
#define GID_U3_IN76         45
#define GID_U3_IN77         46
#define GID_U3_IN78         47
#define GID_U3_IN79         48
#define GID_U3_IN80         49
#define GID_U3_IN81         50 // 15th weapon
#define GID_U3_CB17         51 // 1st card
#define GID_U3_CB18         52
#define GID_U3_CB19         53
#define GID_U3_CB20         54 // 4th card
#define GID_U3_CB21         55 // 1st mark
#define GID_U3_CB22         56
#define GID_U3_CB23         57
#define GID_U3_CB24         58 // 4th mark
#define GID_U4_CB17         59 // 1st virtue
#define GID_U4_CB18         60
#define GID_U4_CB19         61
#define GID_U4_CB20         62
#define GID_U4_CB21         63
#define GID_U4_CB22         64
#define GID_U4_CB23         65
#define GID_U4_CB24         66 // 8th virtue

#define GID_U45_BU_MORE     67
#define GID_U45_LY_MORE     68
#define GID_U4_IN26         69 // 1st karma
#define GID_U4_IN27         70 // 2nd karma
#define GID_U4_IN28         71 // 3rd karma
#define GID_U4_IN29         72 // 4th karma
#define GID_U4_IN30         73 // 5th karma
#define GID_U4_IN31         74 // 6th karma
#define GID_U4_IN32         75 // 7th karma
#define GID_U4_IN33         76 // 8th karma
#define GID_U4_CB1          77 // 1st rune
#define GID_U4_CB2          78
#define GID_U4_CB3          79
#define GID_U4_CB4          80
#define GID_U4_CB5          81
#define GID_U4_CB6          82
#define GID_U4_CB7          83
#define GID_U4_CB8          84 // 8th rune
#define GID_U4_CB9          85 // 1st stone
#define GID_U4_CB10         86
#define GID_U4_CB11         87
#define GID_U4_CB12         88
#define GID_U4_CB13         89
#define GID_U4_CB14         90
#define GID_U4_CB15         91
#define GID_U4_CB16         92 // 8th stone
#define GID_U45_IN_FOOD     93 // food     (party) (U4 & U5)
#define GID_U45_IN_GP       94 // gp       (party) (U4 & U5)
#define GID_U45_IN_GEMS     95 // gems     (party) (U4 & U5)
#define GID_U45_IN_KEYS     96 // keys     (party) (U4 & U5)
#define GID_U45_IN_SEXTANTS 97 // sextants (party) (U4 & U5)
#define GID_U45_IN_TORCHES  98 // torches  (party) (U4 & U5)
#define GID_U5_IN_KARMA     99 // karma (party)
#define GID_U45_IN18       100 // 1st reagent
#define GID_U45_IN19       101 // 2nd reagent
#define GID_U45_IN20       102 // 3rd reagent
#define GID_U45_IN21       103 // 4th reagent
#define GID_U45_IN22       104 // 5th reagent
#define GID_U45_IN23       105 // 6th reagent
#define GID_U45_IN24       106 // 7th reagent
#define GID_U45_IN25       107 // 8th reagent
#define GID_U5_IN26        108 // 1st scroll
#define GID_U5_IN27        109 // 2nd scroll
#define GID_U5_IN28        110 // 3rd scroll
#define GID_U5_IN29        111 // 4th scroll
#define GID_U5_IN30        112 // 5th scroll
#define GID_U5_IN31        113 // 6th scroll
#define GID_U5_IN32        114 // 7th scroll
#define GID_U5_IN33        115 // 8th scroll
#define GID_U5_IN34        116 // 1st potion
#define GID_U5_IN35        117
#define GID_U5_IN36        118
#define GID_U5_IN37        119
#define GID_U5_IN38        120
#define GID_U5_IN39        121
#define GID_U5_IN40        122
#define GID_U5_IN41        123 // 8th potion
      
#define GID_U45_BU_ITEMS   124 // items
#define GID_U45_LY_ITEMS   125
#define GID_U45_CB25       126 //  1st item (U4/U5)
#define GID_U45_CB26       127 //  2nd item (U4/U5)
#define GID_U45_CB27       128 //  3rd item (U4/U5)
#define GID_U45_CB28       129 //  4th item (U4/U5)
#define GID_U45_CB29       130 //  5th item (U4/U5)
#define GID_U45_CB30       131 //  6th item (U4/U5)
#define GID_U45_CB31       132 //  7th item (U4/U5)
#define GID_U45_CB32       133 //  8th item (U4/U5)
#define GID_U45_CB33       134 //  9th item (U4/U5)
#define GID_U5_CB34        135 // 10th item (   U5)
#define GID_U5_CB35        136 // 11th item (   U5)
#define GID_U5_CB36        137 // 12th item (   U5)
#define GID_U5_IN16        138 // magic carpets
#define GID_U5_IN17        139 // skull keys
#define GID_U5_IN49        140 // 1st ring
#define GID_U5_IN50        141
#define GID_U5_IN51        142 // 3rd ring
#define GID_U5_IN52        143 // 1st amulet
#define GID_U5_IN53        144
#define GID_U5_IN54        145 // 3rd amulet
#define GID_U5_IN55        146 // 1st shield
#define GID_U5_IN56        147
#define GID_U5_IN57        148
#define GID_U5_IN58        149
#define GID_U5_IN59        150 // 5th shield
#define GID_U45_IN60       151 // 1st armour
#define GID_U45_IN61       152
#define GID_U45_IN62       153
#define GID_U45_IN63       154
#define GID_U45_IN64       155
#define GID_U45_IN65       156
#define GID_U45_IN66       157 // 7th armour
#define GID_U45_IN67       158 // 1st weapon
#define GID_U45_IN68       159
#define GID_U45_IN69       160
#define GID_U45_IN70       161
#define GID_U45_IN71       162
#define GID_U45_IN72       163
#define GID_U45_IN73       164
#define GID_U45_IN74       165
#define GID_U45_IN75       166
#define GID_U45_IN76       167
#define GID_U45_IN77       168
#define GID_U45_IN78       169
#define GID_U45_IN79       170
#define GID_U45_IN80       171
#define GID_U45_IN81       172
#define GID_U45_IN82       173
#define GID_U45_IN83       174
#define GID_U45_IN84       175
#define GID_U45_IN85       176
#define GID_U45_IN86       177
#define GID_U45_IN87       178
#define GID_U45_IN88       179
#define GID_U45_IN89       180
#define GID_U45_IN90       181
#define GID_U45_IN91       182
#define GID_U45_IN92       183 // 26th weapon
#define GID_U5_IN93        184 // 1st helm
#define GID_U5_IN94        185
#define GID_U5_IN95        186
#define GID_U5_IN96        187 // 4th helm

#define GID_U45_BU_SPELLS  188 // spells
#define GID_U45_LY_SPELLS  189
#define GID_U45_IN100      190 //  1st spell
#define GID_U45_IN147      237 // 48th spell
#define GID_U5_LB1         238

#define GID_U5_BU_WHEN     239 // when & where
#define GID_U5_LY_WHEN     240
#define GID_U5_ST1         241 // coords
#define GID_U5_IN_HOUR     242 // hour
#define GID_U5_IN_MINUTE   243 // minute
#define GID_U5_IN_DAY      244 // day
#define GID_U5_IN_MONTH    245 // month
#define GID_U5_IN_YEAR     246 // year
#define GID_U5_IN_X        247
#define GID_U5_IN_Y        248
#define GID_U5_CH_FLOOR    249 // floor
#define GID_U5_LY_CLOCK    250
#define GID_U5_CL1         251

#define GID_U6_BU_AVATAR   252 // avatar
#define GID_U6_LY_AVATAR   253
#define GID_U6_CH1         254 // avatar sex
#define GID_U6_BU1         255 //  1st portrait
#define GID_U6_BU2         256 //  2nd portrait
#define GID_U6_BU3         257 //  3rd portrait
#define GID_U6_BU4         258 //  4th portrait
#define GID_U6_BU5         259 //  5th portrait
#define GID_U6_BU6         260 //  6th portrait
#define GID_U6_BU7         261 //  7th portrait
#define GID_U6_BU8         262 //  8th portrait
#define GID_U6_BU9         263 //  9th portrait
#define GID_U6_BU10        264 // 10th portrait
#define GID_U6_BU11        265 // 11th portrait
#define GID_U6_BU12        266 // 12th portrait

#define GIDS_U             GID_U6_BU12

#define ULTIMA3           0
#define ULTIMA4           1
#define ULTIMA5           2
#define ULTIMA6           3
#define NOGAME            4

#define U3_IMAGE_CLERIC  46
#define U3_IMAGE_FIGHTER 47
#define U3_IMAGE_LARK    48
#define U3_IMAGE_RANGER  49
#define U3_IMAGE_THIEF   50
#define U3_IMAGE_WIZARD  51

#define U5CLASS_AVATAR    0
#define U5CLASS_BARD      1
#define U5CLASS_FIGHTER   2
#define U5CLASS_MAGE      3

#define AddSpell(a, b) LAYOUT_AddChild, gadgets[GID_U45_IN100 + a] = (struct Gadget*) \
IntegerObject, \
    GA_ID,              GID_U45_IN100 + a, \
    GA_TabCycle,        TRUE, \
    INTEGER_Minimum,    0, \
    INTEGER_Maximum,    99, \
    INTEGER_Number,     mixtures[a], \
    INTEGER_MinVisible, 2 + 1, \
IntegerEnd, \
Label(b)

#define AddU4Weapon(a, b) LAYOUT_AddChild, gadgets[GID_U45_IN67 + a] = (struct Gadget*) \
IntegerObject, \
    GA_ID,              GID_U45_IN67 + a, \
    GA_TabCycle,        TRUE, \
    INTEGER_Minimum,    0, \
    INTEGER_Maximum,    99, \
    INTEGER_Number,     weapons[a + 1], \
    INTEGER_MinVisible, 2 + 1, \
IntegerEnd, \
Label(b)

#define AddU5Weapon(a, b) LAYOUT_AddChild, gadgets[GID_U45_IN67 + a] = (struct Gadget*) \
IntegerObject, \
    GA_ID,              GID_U45_IN67 + a, \
    GA_TabCycle,        TRUE, \
    INTEGER_Minimum,    0, \
    INTEGER_Maximum,    99, \
    INTEGER_Number,     weapons[a], \
    INTEGER_MinVisible, 2 + 1, \
IntegerEnd, \
Label(b)

#define AddU4Armour(a, b) LAYOUT_AddChild, gadgets[GID_U45_IN60 + a] = (struct Gadget*) \
IntegerObject, \
    GA_ID,              GID_U45_IN60 + a, \
    GA_TabCycle,        TRUE, \
    INTEGER_Minimum,    0, \
    INTEGER_Maximum,    99, \
    INTEGER_Number,     armour[a + 1], \
    INTEGER_MinVisible, 2 + 1, \
IntegerEnd, \
Label(b)

#define AddU5Armour(a, b) LAYOUT_AddChild, gadgets[GID_U45_IN60 + a] = (struct Gadget*) \
IntegerObject, \
    GA_ID,              GID_U45_IN60 + a, \
    GA_TabCycle,        TRUE, \
    INTEGER_Minimum,    0, \
    INTEGER_Maximum,    99, \
    INTEGER_Number,     armour[a], \
    INTEGER_MinVisible, 2 + 1, \
IntegerEnd, \
Label(b)

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(int whichman);
MODULE void morewindow(void);
MODULE void avatarwindow(void);
MODULE void whenandwhere(void);
MODULE void itemwindow(void);
MODULE void spellwindow(void);
MODULE void do_coords(void);
MODULE int yes(STRPTR abbrevs, int value);
MODULE void load_chooser_images(void);
MODULE void update_portrait(void);
MODULE void change_game(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            loaded,
                            page,
                            serializemode,
                            stringextra;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT LONG                 gamesize;
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Library*      TextFieldBase;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;
#ifndef __MORPHOS__
    IMPORT UWORD*               MouseData;
    IMPORT struct ClassLibrary* ClockBase;
    IMPORT Class*               ClockClass;
#endif

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                game = NOGAME,
                            men,
                            who,
                            armour[8],    // U4 ( 8 elements) & U5 ( 7 elements)
                            food,         // U4               & U5
                            gems,         // U4               & U5
                            gp,           // U4               & U5
                            keys,         // U4               & U5
                            mixtures[48], // U4 (26 elements) & U5 (48 elements)
                            reagents[8],  // U4 ( 8 elements) & U5 ( 8 elements)
                            sextants,     // U4               & U5
                            torches,      // U4               & U5
                            weapons[26],  // U4 (16 elements) & U5 (26 elements)
// U4...
                            u4_item[9],
                            rune[8],
                            stone[8],
                            u4_karma[8],
// U5...
                            u5_item[12],
                            rings[3],
                            scrolls[8],
                            helms[4],
                            shields[5],
                            potions[8],
                            amulets[3],
                            skullkeys,
                            carpets,
                            sextants,
                            u5_karma,
                            floor,
                            location,
                            loc_x,
                            loc_y,
                            minute,
                            hour,
                            day,
                            month,
                            year,
// U6...
                            portrait,
                            sex;
MODULE int                  submode;
MODULE struct List          ClassesList,
                            LocationsList;

/* Submodes are:
0 = items
1 = spells
2 = when & where
3 = more
4 = portrait
*/

MODULE const STRPTR U3ArmourOptions[8 + 1] =
{ "Skin",          //  0
  "Cloth",         //  1
  "Leather",       //  2
  "Chain",         //  3
  "Plate",         //  4
  "+2 Chain",      //  5
  "+2 Plate",      //  6
  "Exotic Armour", //  7
  NULL             //  8
}, U4ArmourOptions[8 + 1] =
{ "Skin",        //  0
  "Cloth",       //  1
  "Leather",     //  2
  "Chain Mail",  //  3
  "Plate Mail",  //  4
  "Magic Chain", //  5
  "Magic Plate", //  6
  "Mystic Robe", //  7
  NULL           //  8
}, U3ClassOptions[11] =
{ "Alchemist",   //  0
  "Barbarian",   //  1
  "Cleric",      //  2
  "Druid",       //  3
  "Fighter",     //  4
  "Illusionist", //  5
  "Lark",        //  6
  "Paladin",     //  7
  "Ranger",      //  8
  "Thief",       //  9
  "Wizard"       // 10
// no NULL is required
}, U4ClassOptions[8] =
{ "Mage",        //  0
  "Bard",        //  1
  "Fighter",     //  2
  "Druid",       //  3
  "Tinker",      //  4
  "Paladin",     //  5
  "Ranger",      //  6
  "Shepherd"     //  7
// no NULL is required
}, U5ClassOptions[4] =
{ "Avatar",
  "Bard",
  "Fighter",
  "Mage"
// no NULL is required
}, U6ClassOptions[1] =
{ "-"
// no NULL is required
}, GameOptions[4 + 1] =
{ "Ultima 3",    //  0
  "Ultima 4",    //  1
  "Ultima 5",    //  2
  "Ultima 6",    //  3
  NULL           //  4
}, RaceOptions[5 + 1] = // U3
{ "Bobbit",
  "Dwarf",
  "Elf",
  "Fuzzy",
  "Human",
  NULL
}, U3SexOptions[3 + 1] =
{ "Male",
  "Female",
  "Other",
  NULL
}, U456SexOptions[3 + 1] =
{ "Male",
  "Female",
  NULL
}, StatusOptions[4 + 1] =
{ "OK", // aka Good
  "Dead",
  "Poisoned",
  "Sleeping",
  NULL
}, U3WeaponOptions[16 + 1] =
{ "Hands",          //  0
  "Dagger",         //  1
  "Mace",           //  2
  "Sling",          //  3
  "Axe",            //  4
  "Bow",            //  5
  "Sword",          //  6
  "2-Handed Sword", //  7
  "+2 Axe",         //  8
  "+2 Bow",         //  9
  "+2 Sword",       // 10
  "Gloves",         // 11
  "+4 Axe",         // 12
  "+4 Bow",         // 13
  "+4 Sword",       // 14
  "Exotic Weapon",  // 15
  NULL              // 16
}, U4WeaponOptions[16 + 1] =
{ "Hands",        //  0
  "Staff",        //  1
  "Dagger",       //  2
  "Sling",        //  3
  "Mace",         //  4
  "Axe",          //  5
  "Sword",        //  6
  "Bow",          //  7
  "Crossbow",     //  8
  "Flaming Oil",  //  9
  "Halberd",      // 10
  "Magic Axe",    // 11
  "Magic Sword",  // 12
  "Magic Bow",    // 13
  "Magic Wand",   // 14
  "Mystic Sword", // 15
  NULL            // 16
}, LocationName[41] =
{ "Britannia/Underworld",  //  0
  "Moonglow",
  "Britain",
  "Jhelom",
  "Yew",
  "Minoc",
  "Trinsic",
  "Skara Brae",
  "New Magincia",
  "Fogsbane",
  "Stormcrow",             // 10
  "Greyhaven",
  "Waveguide",
  "Iolo's Hut",
  "Sutek's Hut",
  "Sin'Vraal's Hut",
  "Grendel's Hut",
  "Lord British's Castle",
  "Blackthorn's Palace",
  "West Britanny",
  "North Britanny",        // 20
  "East Britanny",
  "Paws",
  "Cove",
  "Buccaneer's Den",
  "Ararat",
  "Bordermarch",
  "Farthing",
  "Windemere",
  "Stonegate",
  "Lycaeum",               // 30
  "Empath Abbey",
  "Serpent's Hold",
  "Deceit",
  "Despise",
  "Destard",
  "Wrong",
  "Covetous",
  "Shame",
  "Hythloth",
  "Doom"                   // 40
// no NULL is required
}, FloorOptions[9 + 1] =
{ "Basement/Underworld",    //  0 (stored as -1)
  "Ground/Dungeon level 1", //  1 (stored as  0)
  "1st/Dungeon level 2",    //  2 (stored as  1)
  "2nd/Dungeon level 3",    //  3
  "3rd/Dungeon level 4",    //  4
  "Dungeon level 5",        //  5
  "Dungeon level 6",        //  6
  "Dungeon level 7",        //  7
  "Dungeon level 8",        //  8 (stored as  7)
  NULL                      //  9
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  .1.. .... .... ....    . = Transparent (%00)
    121. .... .... ....    1 = Dark   grey (%01) ($222)
    1231 .... .... ....    2 = Medium grey (%10) ($778)
    1233 1... .... ....    3 = Light  grey (%11) ($CCD)
    1233 31.. .... ....
    1233 331. .... ....
    1233 3331 .... ....
    1233 3333 1... ....
    1232 3333 31.. ....
    1231 2311 1... ....
    .111 2331 .... ....
    ...1 1231 .... ....
    .... 1231 .... ....
    .... .11. .... ....
    .... .... .... ....
    .... .... .... ....

          Plane 0                Plane 1      
    .1.. .... .... ....    .... .... .... ....
    1.1. .... .... ....    .2.. .... .... ....
    1.31 .... .... ....    .23. .... .... ....
    1.33 1... .... ....    .233 .... .... ....
    1.33 31.. .... ....    .233 3... .... ....
    1.33 331. .... ....    .233 33.. .... ....
    1.33 3331 .... ....    .233 333. .... ....
    1.33 3333 1... ....    .233 3333 .... ....
    1.3. 3333 31.. ....    .232 3333 3... ....
    1.31 .311 1... ....    .23. 23.. .... ....
    .111 .331 .... ....    .... 233. .... ....
    ...1 1.31 .... ....    .... .23. .... ....
    .... 1.31 .... ....    .... .23. .... ....
    .... .11. .... ....    .... .... .... ....
    .... .... .... ....    .... .... .... ....
    .... .... .... ....    .... .... .... ....
     D. grey & L. grey      M. grey & L. grey

    Plane 0 Plane 1 */
    0x4000, 0x0000,
    0xA000, 0x4000,
    0xB000, 0x6000,
    0xB800, 0x7000,
    0xBC00, 0x7800,
    0xBE00, 0x7C00,
    0xBF00, 0x7E00,
    0xBF80, 0x7F00,
    0xAFC0, 0x7F80,
    0xB700, 0x6C00,
    0x7700, 0x0E00,
    0x1B00, 0x0600,
    0x0B00, 0x0600,
    0x0600, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,

    0x0000, 0x0000, // reserved
};
#endif

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   TEXT   name[15 + 1];
    ULONG  curhp,
           maxhp,
           mp,
           theclass,
           xp,
           str,
           iq,
           dex,
           weapon,
           armour,
           sex,
           status;
// U3...
    ULONG  card[4],
           mark[4],
           food,
           gems,
           gp,
           keys,
           powders,
           race,
           torches,
           wis,
           armours[8],
           weapons[16];
// U4...
    ULONG  virtue[8];
// U5...
    ULONG  level;
// U6...
    ULONG  code;
} man[20]; // 20 (or 4) for U3, 8 for U4, 16 for U5, 8 for U6

// 8. CODE ---------------------------------------------------------------

EXPORT void ultima_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // ultima_preinit()
        NewList(&ClassesList);
        NewList(&LocationsList);

        // ultima_init()
        lb_makelist(&LocationsList, LocationName, 41);
    }

    tool_open      = ultima_open;
    tool_loop      = ultima_loop;
    tool_save      = ultima_save;
    tool_close     = ultima_close;
    tool_exit      = ultima_exit;
    tool_subgadget = ultima_subgadget;

    if (loaded != FUNC_ULTIMA && !ultima_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_ULTIMA;

    load_chooser_images();
    make_speedbar_list(GID_U_SB1);
    load_aiss_images(10, 10);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                      TRUE,
        WA_ThinSizeGadget,                                  TRUE,
#ifndef __MORPHOS__
        WINDOW_LockHeight,                                  ClockBase ? FALSE : TRUE,
#else
        WINDOW_LockHeight,                                  TRUE,
#endif
        WINDOW_Position,                                    WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                 gadgets[GID_U_LY_MAIN] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                              TRUE,
            AddHLayout,
                AddToolbar(GID_U_SB1),
                AddSpace,
                AddVLayout,
                    AddSpace,
                    LAYOUT_AddChild,                        gadgets[GID_U_CH7] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                              GID_U_CH7,
                        GA_Disabled,                        TRUE,
                        CHOOSER_LabelArray,                 &GameOptions,
                        CHOOSER_Selected,                   (WORD) game,
                    PopUpEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                   0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,                        0,
                AddSpace,
                AddVLayout,
                    AddSpace,
                    CHILD_WeightedHeight,                   50,
                    MaximizeButton(GID_U_BU2, "Maximize Party"),
                    CHILD_WeightedHeight,                   0,
                    AddSpace,
                    CHILD_WeightedHeight,                   50,
                LayoutEnd,
                CHILD_WeightedWidth,                        0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                           0,
            AddVLayout,
                AddHLayout,
                    LAYOUT_VertAlignment,                   LALIGN_CENTER,
                    AddLabel("Character #:"),
                    LAYOUT_AddChild,                        gadgets[GID_U_IN_MAN] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                              GID_U_IN_MAN,
                        GA_RelVerify,                       TRUE,
                        GA_TabCycle,                        TRUE,
                        INTEGER_Minimum,                    1,
                        INTEGER_Maximum,                    men,
                        INTEGER_Number,                     who + 1,
                        INTEGER_MinVisible,                 2 + 1,
                    IntegerEnd,
                    AddLabel("of"),
                    LAYOUT_AddChild,                        gadgets[GID_U_IN_MEN] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                              GID_U_IN_MEN,
                        GA_RelVerify,                       TRUE,
                        INTEGER_Arrows,                     TRUE,
                        INTEGER_Number,                     men,
                        INTEGER_MinVisible,                 2, // enough for "20" (uneditable) or "8" (editable)
                        INTEGER_Minimum,                    1,
                    IntegerEnd,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_BevelStyle,                      BVS_GROUP,
                    LAYOUT_SpaceOuter,                      TRUE,
                    LAYOUT_Label,                           "Character",
                    AddVLayout,
                        LAYOUT_AddChild,                    gadgets[GID_U_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                          GID_U_ST1,
                            GA_TabCycle,                    TRUE,
                            STRINGA_TextVal,                man[who].name,
                            STRINGA_MaxChars,               15 + 1,
                        StringEnd,
                        Label("Name:"),
                        AddHLayout,
                            LAYOUT_AddChild,                gadgets[GID_U_IN_CURHP] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U_IN_CURHP,
                                GA_TabCycle,                TRUE,
                                INTEGER_Number,             man[who].curhp,
                                INTEGER_MinVisible,         4 + 1,
                            IntegerEnd,
                            LAYOUT_AddChild,                gadgets[GID_U_IN_MAXHP] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U_IN_MAXHP,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            9999,
                                INTEGER_Number,             man[who].maxhp,
                                INTEGER_MinVisible,         4 + 1,
                            IntegerEnd,
                            Label("of"),
                        LayoutEnd,
                        Label("Hit Points:"),
                        CHILD_WeightedHeight,               0,
                        LAYOUT_AddChild,                    gadgets[GID_U_IN3] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U_IN3,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Maximum,                99,
                            INTEGER_Number,                 man[who].mp,
                            INTEGER_MinVisible,             2 + 1,
                        IntegerEnd,
                        Label("Magic Points:"),
                        LAYOUT_AddChild,                    gadgets[GID_U3_CH_RACE] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                          GID_U3_CH_RACE,
                            CHOOSER_LabelArray,             &RaceOptions,
                            CHOOSER_Selected,               (WORD) man[who].race,
                        PopUpEnd,
                        Label("Race:"),
                        LAYOUT_AddChild,                    gadgets[GID_U345_CH_CLASS] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                          GID_U345_CH_CLASS,
                            CHOOSER_Labels,                 &ClassesList,
                            CHOOSER_Selected,               (WORD) man[who].theclass,
                        PopUpEnd,
                        Label("Class:"),
                        LAYOUT_AddChild,                    gadgets[GID_U_CH2] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                          GID_U_CH2,
                            CHOOSER_LabelArray,             (game == ULTIMA3) ? (&U3SexOptions)    : (&U456SexOptions),
                            CHOOSER_Selected,               (WORD) man[who].sex,
                        PopUpEnd,
                        Label("Sex:"),
                        LAYOUT_AddChild,                    gadgets[GID_U_CH3] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                          GID_U_CH3,
                            CHOOSER_LabelArray,             &StatusOptions,
                            CHOOSER_Selected,               (WORD) man[who].status,
                        PopUpEnd,
                        Label("Condition:"),
                        LAYOUT_AddChild,                    gadgets[GID_U34_CH4] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                          GID_U34_CH4,
                            CHOOSER_LabelArray,             (game == ULTIMA3) ? (&U3ArmourOptions) : (&U4ArmourOptions),
                            CHOOSER_Selected,               (WORD) man[who].armour,
                        PopUpEnd,
                        Label("Armour:"),
                        LAYOUT_AddChild,                    gadgets[GID_U34_CH5] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                          GID_U34_CH5,
                            CHOOSER_MaxLabels,              16,
                            CHOOSER_LabelArray,             (game == ULTIMA3) ? (&U3WeaponOptions) : (&U4WeaponOptions),
                            CHOOSER_Selected,               (WORD) man[who].weapon,
                        PopUpEnd,
                        Label("Weapon:"),
                        LAYOUT_AddChild,                    gadgets[GID_U56_IN_LEVEL] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U56_IN_LEVEL,
                            GA_TabCycle,                    TRUE,
                            GA_RelVerify,                   TRUE,
                            INTEGER_Minimum,                1,
                            INTEGER_Maximum,                8,
                            INTEGER_Number,                 man[who].level,
                            INTEGER_MinVisible,             1 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                    gadgets[GID_U_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U_IN8,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Number,                 man[who].xp,
                            INTEGER_MinVisible,             5 + 1,
                        IntegerEnd,
                        Label("XP:"),
                        LAYOUT_AddChild,                    gadgets[GID_U_IN10] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U_IN10,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Number,                 man[who].str,
                            INTEGER_MinVisible,             3 + 1,
                            INTEGER_Minimum,                0,
                        IntegerEnd,
                        Label("Strength:"),
                        LAYOUT_AddChild,                    gadgets[GID_U_IN11] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U_IN11,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Number,                 man[who].iq,
                            INTEGER_MinVisible,             3 + 1,
                        IntegerEnd,
                        Label("Intelligence:"),
                        LAYOUT_AddChild,                    gadgets[GID_U3_IN_WIS] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U3_IN_WIS,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Maximum,                99,
                            INTEGER_Number,                 man[who].wis,
                            INTEGER_MinVisible,             2 + 1,
                        IntegerEnd,
                        Label("Wisdom:"),
                        LAYOUT_AddChild,                    gadgets[GID_U_IN12] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U_IN12,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Number,                 man[who].dex,
                            INTEGER_MinVisible,             3 + 1,
                        IntegerEnd,
                        Label("Dexterity:"),
                        LAYOUT_AddChild,                    gadgets[GID_U3_IN_FOOD] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U3_IN_FOOD,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Maximum,                9999,
                            INTEGER_Number,                 man[who].food,
                            INTEGER_MinVisible,             4 + 1,
                        IntegerEnd,
                        Label("Food:"),
                        LAYOUT_AddChild,                    gadgets[GID_U3_IN_GP] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U3_IN_GP,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Maximum,                9999,
                            INTEGER_Number,                 man[who].gp,
                            INTEGER_MinVisible,             4 + 1,
                        IntegerEnd,
                        Label("Gold:"),
                        LAYOUT_AddChild,                    gadgets[GID_U3_IN_GEMS] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U3_IN_GEMS,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Maximum,                99,
                            INTEGER_Number,                 man[who].gems,
                            INTEGER_MinVisible,             2 + 1,
                        IntegerEnd,
                        Label("Gems:"),
                        LAYOUT_AddChild,                    gadgets[GID_U3_IN_KEYS] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U3_IN_KEYS,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Maximum,                99,
                            INTEGER_Number,                 man[who].keys,
                            INTEGER_MinVisible,             2 + 1,
                        IntegerEnd,
                        Label("Keys:"),
                        LAYOUT_AddChild,                    gadgets[GID_U3_IN_POWDERS] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U3_IN_POWDERS,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Maximum,                99,
                            INTEGER_Number,                 man[who].powders,
                            INTEGER_MinVisible,             2 + 1,
                        IntegerEnd,
                        Label("Powders:"),
                        LAYOUT_AddChild,                    gadgets[GID_U3_IN_TORCHES] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                          GID_U3_IN_TORCHES,
                            GA_TabCycle,                    TRUE,
                            INTEGER_Minimum,                0,
                            INTEGER_Maximum,                99,
                            INTEGER_Number,                 man[who].torches,
                            INTEGER_MinVisible,             2 + 1,
                        IntegerEnd,
                        Label("Torches:"),
                    LayoutEnd,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,              BVS_GROUP,
                            LAYOUT_SpaceOuter,              TRUE,
                            LAYOUT_Label,                   "Armour",
                            LAYOUT_AddChild,                gadgets[GID_U3_IN60] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN60,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].armours[1],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Cloths:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN61] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN61,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].armours[2],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Leathers:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN62] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN62,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].armours[3],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Chains:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN63] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN63,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].armours[4],
                            INTEGER_MinVisible,             2 + 1,
                            IntegerEnd,
                            Label("Plates:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN64] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN64,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].armours[5],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("+2 Chains:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN65] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN65,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].armours[6],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("+2 Plates:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN66] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN66,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].armours[7],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Exotic Armour:"),
                        LayoutEnd,
                        AddVLayout,
                            LAYOUT_BevelStyle,              BVS_GROUP,
                            LAYOUT_SpaceOuter,              TRUE,
                            LAYOUT_Label,                   "Weapons",
                            LAYOUT_AddChild,                gadgets[GID_U3_IN67] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN67,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[1],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Daggers:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN68] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN68,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[2],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Maces:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN69] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN69,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[3],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Slings:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN70] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN70,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[4],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Axes:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN71] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN71,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[5],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Bows:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN72] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN72,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[6],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Swords:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN73] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN73,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[7],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("2-Handed Swords:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN74] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN74,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[8],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("+2 Axes:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN75] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN75,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[9],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("+2 Bows:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN76] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN76,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[10],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("+2 Swords:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN77] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN77,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[11],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Gloves:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN78] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN78,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[12],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("+4 Axes:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN79] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN79,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[13],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("+4 Bows:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN80] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN80,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[14],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("+4 Swords:"),
                            LAYOUT_AddChild,                gadgets[GID_U3_IN81] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                      GID_U3_IN81,
                                GA_TabCycle,                TRUE,
                                INTEGER_Minimum,            0,
                                INTEGER_Maximum,            99,
                                INTEGER_Number,             man[who].weapons[15],
                                INTEGER_MinVisible,         2 + 1,
                            IntegerEnd,
                            Label("Exotic Weapons:"),
                        LayoutEnd,
                    LayoutEnd,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,              BVS_GROUP,
                            LAYOUT_SpaceOuter,              TRUE,
                            LAYOUT_Label,                   "Cards",
                            LAYOUT_AddChild,                gadgets[GID_U3_CB17] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U3_CB17,
                                GA_Selected,                man[who].card[0],
                                GA_Text,                    "Moons",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U3_CB18] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U3_CB18,
                                GA_Selected,                man[who].card[1],
                                GA_Text,                     "Death",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U3_CB19] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U3_CB19,
                                GA_Selected,                man[who].card[2],
                                GA_Text,                    "Sol",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U3_CB20] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U3_CB20,
                                GA_Selected,                man[who].card[3],
                                GA_Text,                    "Love",
                            End,
                        LayoutEnd,
                        CHILD_WeightedHeight,               0,
                        AddVLayout,
                            LAYOUT_BevelStyle,              BVS_GROUP,
                            LAYOUT_SpaceOuter,              TRUE,
                            LAYOUT_Label,                   "Marks",
                            LAYOUT_AddChild,                gadgets[GID_U3_CB21] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U3_CB21,
                                GA_Selected,                man[who].mark[0],
                                GA_Text,                    "Snake",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U3_CB22] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U3_CB22,
                                GA_Selected,                man[who].mark[1],
                                GA_Text,                    "Kings",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U3_CB23] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U3_CB23,
                                GA_Selected,                man[who].mark[2],
                                GA_Text,                    "Fire",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U3_CB24] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U3_CB24,
                                GA_Selected,                man[who].mark[3],
                                GA_Text,                    "Force",
                            End,
                        LayoutEnd,
                        CHILD_WeightedHeight,               0,
                        AddVLayout,
                            LAYOUT_BevelStyle,              BVS_GROUP,
                            LAYOUT_SpaceOuter,              TRUE,
                            LAYOUT_Label,                   "Virtues",
                            LAYOUT_AddChild,                gadgets[GID_U4_CB17] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U4_CB17,
                                GA_Selected,                man[who].virtue[0],
                                GA_Text,                    "Honesty",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U4_CB18] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U4_CB18,
                                GA_Selected,                man[who].virtue[1],
                                GA_Text,                    "Compassion",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U4_CB19] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U4_CB19,
                                GA_Selected,                man[who].virtue[2],
                                GA_Text,                    "Valor",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U4_CB20] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U4_CB20,
                                GA_Selected,                man[who].virtue[3],
                                GA_Text,                    "Justice",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U4_CB21] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U4_CB21,
                                GA_Selected,                man[who].virtue[4],
                                GA_Text,                    "Sacrifice",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U4_CB22] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U4_CB22,
                                GA_Selected,                man[who].virtue[5],
                                GA_Text,                    "Honour",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U4_CB23] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U4_CB23,
                                GA_Selected,                man[who].virtue[6],
                                GA_Text,                    "Sprituality",
                            End,
                            LAYOUT_AddChild,                gadgets[GID_U4_CB24] = (struct Gadget*)
                            TickOrCheckBoxObject,
                                GA_ID,                      GID_U4_CB24,
                                GA_Selected,                man[who].virtue[7],
                                GA_Text,                    "Humility",
                            End,
                        LayoutEnd,
                        CHILD_WeightedHeight,               0,
                        AddSpace,
                        LAYOUT_AddChild,                    gadgets[GID_U_BU1] = (struct Gadget*)
                        ZButtonObject,
                            GA_ID,                          GID_U_BU1,
                            GA_RelVerify,                   TRUE,
                            GA_Image,
                            LabelObject,
                                LABEL_Image,                aissimage[10],
                                CHILD_NoDispose,            TRUE,
                                LABEL_DrawInfo,             DrawInfoPtr,
                                LABEL_VerticalAlignment,    LVALIGN_BASELINE,
                                LABEL_Justification,        LJ_CENTRE,
                                LABEL_Text,                 "\nMaximize\nCharacter",
                            LabelEnd,
                        ButtonEnd,
                        CHILD_WeightedHeight,               0,
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            AddHLayout,
                LAYOUT_AddChild,                            gadgets[GID_U45_BU_ITEMS] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                  GID_U45_BU_ITEMS,
                    GA_RelVerify,                           TRUE,
                    GA_Text,                                "Items... (U4/U5)",
                ButtonEnd,
                LAYOUT_AddChild,                            gadgets[GID_U45_BU_SPELLS] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                  GID_U45_BU_SPELLS,
                    GA_RelVerify,                           TRUE,
                    GA_Text,                                "Spells... (U4/U5)",
                ButtonEnd,
                LAYOUT_AddChild,                            gadgets[GID_U45_BU_MORE] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                  GID_U45_BU_MORE,
                    GA_RelVerify,                           TRUE,
                    GA_Text,                                "More... (U4/U5)",
                ButtonEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                           0,
            AddHLayout,
                LAYOUT_AddChild,                            gadgets[GID_U5_BU_WHEN] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                  GID_U5_BU_WHEN,
                    GA_RelVerify,                           TRUE,
                    GA_Text,                                "When & Where... (U5)",
                ButtonEnd,
                LAYOUT_AddChild,                            gadgets[GID_U6_BU_AVATAR] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                  GID_U6_BU_AVATAR,
                    GA_RelVerify,                           TRUE,
                    GA_Text,                                "Avatar... (U6)",
                ButtonEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                           0,
        LayoutEnd,
        CHILD_NominalSize,                                  TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_U_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    change_game();
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_U_LY_MAIN], MainWindowPtr, NULL, (Object) gadgets[GID_U_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void ultima_loop(ULONG gid, UNUSED ULONG code)
{   int i;

    switch (gid)
    {
    case GID_U_BU1:
        readgadgets();
        maximize_man(who);
        writegadgets();
    acase GID_U_BU2:
        readgadgets();
        for (i = 0; i < (int) men; i++)
        {   maximize_man(i);
        }

        switch (game)
        {
        case ULTIMA4:
            for (i = 0; i < 8; i++)
            {   rune[i]         =
                stone[i]        =      1;
                reagents[i]     =
                u4_karma[i]     =     90;
            }
            for (i = 0; i < 9; i++)
            {   u4_item[i]      =      1;
            }
            for (i = 1; i < 8; i++)
            {   armour[i]       =     90;
            }
            for (i = 1; i < 16; i++)
            {   weapons[i]      =     90;
            }
            for (i = 0; i < 26; i++)
            {   mixtures[i]     =     90;
            }
            gems                =
            keys                =
            sextants            =
            torches             =     90;
            food                =
            gp                  =   9000;
        acase ULTIMA5:
            for (i = 0; i < 8; i++)
            {   reagents[i]     =
                scrolls[i]      =
                potions[i]      =     90;
            }
            for (i = 0; i < 48; i++)
            {   mixtures[i]     =     90;
            }
            for (i = 0; i < 4; i++)
            {   helms[i]        =     90;
            }
            for (i = 0; i < 5; i++)
            {   shields[i]      =     90;
            }
            for (i = 0; i < 7; i++)
            {   armour[i]       =     90;
            }
            for (i = 0; i < 26; i++)
            {   weapons[i]      =     90;
            }
            for (i = 0; i < 3; i++)
            {   rings[i]        =
                amulets[i]      =     90;
            }
            for (i = 0; i < 12; i++)
            {   u5_item[i]      =      1;
            }
            gems                =
            u5_karma            =
            keys                =
            sextants            =
            torches             =
            carpets             =
            skullkeys           =     90;
            food                =
            gp                  =   9000;
        }

        writegadgets();
    acase GID_U_IN_MAN:
        readgadgets();
        GetAttr(INTEGER_Number, (Object*) gadgets[GID_U_IN_MAN], (ULONG*) &who);
        who--;
        writegadgets();
    acase GID_U_IN_MEN:
        GetAttr(INTEGER_Number, (Object*) gadgets[GID_U_IN_MEN], (ULONG*) &men);
        writegadgets();
    acase GID_U45_BU_MORE:
        morewindow();
    acase GID_U45_BU_ITEMS:
        itemwindow();
    acase GID_U45_BU_SPELLS:
        spellwindow();
    acase GID_U5_BU_WHEN:
        whenandwhere();
    acase GID_U6_BU_AVATAR:
        avatarwindow();
    acase GID_U56_IN_LEVEL:
        GetAttr(INTEGER_Number, (Object*) gadgets[GID_U56_IN_LEVEL], (ULONG*) &man[who].level);
        man[who].maxhp = man[who].level * 30;
        DISCARD SetGadgetAttrs
        (   gadgets[GID_U_IN_MAXHP], MainWindowPtr, NULL,
            INTEGER_Number, man[who].maxhp,
        TAG_END); // autorefreshes
}   }

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_ULTIMA
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    change_game();

    if (who >= men)
    {   who = men - 1;
    }
    DISCARD SetGadgetAttrs
    (   gadgets[GID_U_IN_MAN], MainWindowPtr, NULL,
        INTEGER_Number,  who + 1,
        INTEGER_Maximum, men,
    TAG_END); // this autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_U_IN_MEN], MainWindowPtr, NULL,
        INTEGER_Number,  men,
    TAG_END); // this autorefreshes

    SetGadgetAttrs(                 gadgets[GID_U_ST1        ], MainWindowPtr, NULL, STRINGA_TextVal,         man[who].name,     TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U_IN_CURHP   ], MainWindowPtr, NULL, INTEGER_Number,          man[who].curhp,    TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U_IN_MAXHP   ], MainWindowPtr, NULL, INTEGER_Number,          man[who].maxhp,    TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U_IN3        ], MainWindowPtr, NULL, INTEGER_Number,          man[who].mp,       TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U_IN8        ], MainWindowPtr, NULL, INTEGER_Number,          man[who].xp,       TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U_IN10       ], MainWindowPtr, NULL, INTEGER_Number,          man[who].str,      TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U_IN11       ], MainWindowPtr, NULL, INTEGER_Number,          man[who].iq,       TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U_IN12       ], MainWindowPtr, NULL, INTEGER_Number,          man[who].dex,      TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U3_IN_FOOD   ], MainWindowPtr, NULL, INTEGER_Number,          man[who].food,     TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U3_IN_GP     ], MainWindowPtr, NULL, INTEGER_Number,          man[who].gp,       TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U3_IN_GEMS   ], MainWindowPtr, NULL, INTEGER_Number,          man[who].gems,     TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U3_IN_KEYS   ], MainWindowPtr, NULL, INTEGER_Number,          man[who].keys,     TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U3_IN_POWDERS], MainWindowPtr, NULL, INTEGER_Number,          man[who].powders,  TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U3_IN_TORCHES], MainWindowPtr, NULL, INTEGER_Number,          man[who].torches,  TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U3_IN_WIS    ], MainWindowPtr, NULL, INTEGER_Number,          man[who].wis,      GA_Disabled, (game == ULTIMA3)                    ? FALSE : TRUE, TAG_END); // autorefreshes
    SetGadgetAttrs(                 gadgets[GID_U345_CH_CLASS], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].theclass, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_U345_CH_CLASS], MainWindowPtr, NULL);
    SetGadgetAttrs(                 gadgets[GID_U_CH2        ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].sex,      TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_U_CH2        ], MainWindowPtr, NULL);
    SetGadgetAttrs(                 gadgets[GID_U_CH3        ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].status,   TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_U_CH3        ], MainWindowPtr, NULL);
    SetGadgetAttrs(                 gadgets[GID_U3_CH_RACE   ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].race,     TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_U3_CH_RACE   ], MainWindowPtr, NULL);
    SetGadgetAttrs(                 gadgets[GID_U34_CH4      ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].armour,   GA_Disabled, (game == ULTIMA3 || game == ULTIMA4) ? FALSE : TRUE, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_U34_CH4      ], MainWindowPtr, NULL);
    SetGadgetAttrs(                 gadgets[GID_U34_CH5      ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[who].weapon,   GA_Disabled, (game == ULTIMA3 || game == ULTIMA4) ? FALSE : TRUE, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_U34_CH5      ], MainWindowPtr, NULL);
    SetGadgetAttrs(                 gadgets[GID_U56_IN_LEVEL ], MainWindowPtr, NULL, INTEGER_Number,          man[who].level,    GA_Disabled, (game == ULTIMA5 || game == ULTIMA6) ? FALSE : TRUE, TAG_END); // autorefreshes

    for (i = 1; i < 8; i++)
    {   SetGadgetAttrs(gadgets[GID_U3_IN60 + i - 1], MainWindowPtr, NULL, INTEGER_Number, man[who].armours[i], TAG_END); // autorefreshes
    }
    for (i = 1; i < 16; i++)
    {   SetGadgetAttrs(gadgets[GID_U3_IN67 + i - 1], MainWindowPtr, NULL, INTEGER_Number, man[who].weapons[i], TAG_END); // autorefreshes
    }
    for (i = 0; i < 4; i++)
    {   SetGadgetAttrs(                 gadgets[GID_U3_CB17 + i], MainWindowPtr, NULL, GA_Selected, man[who].card[i]  , GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_U3_CB17 + i], MainWindowPtr, NULL);
        SetGadgetAttrs(                 gadgets[GID_U3_CB21 + i], MainWindowPtr, NULL, GA_Selected, man[who].mark[i]  , GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_U3_CB21 + i], MainWindowPtr, NULL);
    }
    for (i = 0; i < 8; i++)
    {   SetGadgetAttrs(                 gadgets[GID_U4_CB17 + i], MainWindowPtr, NULL, GA_Selected, man[who].virtue[i], GA_Disabled, (game == ULTIMA4) ? FALSE : TRUE, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_U4_CB17 + i], MainWindowPtr, NULL);
}   }

MODULE void readgadgets(void)
{   int    i;
    STRPTR stringptr;

    GetAttr(STRINGA_TextVal, (Object*) gadgets[GID_U_ST1], (ULONG*) &stringptr);
    strcpy(man[who].name, stringptr);
    switch (game)
    {
    case  ULTIMA3: man[who].name[10] = EOS;
 // acase ULTIMA4: man[who].name[15] = EOS;
    acase ULTIMA5: man[who].name[ 8] = EOS;
    acase ULTIMA6: man[who].name[13] = EOS;
    }
    SetGadgetAttrs(gadgets[GID_U_ST1], MainWindowPtr, NULL, STRINGA_TextVal, man[who].name, TAG_END); // autorefreshes

    GetAttr(INTEGER_Number, (Object*) gadgets[GID_U_IN_CURHP], (ULONG*) &man[who].curhp);
    GetAttr(INTEGER_Number, (Object*) gadgets[GID_U_IN3 ], (ULONG*) &man[who].mp);
    GetAttr(INTEGER_Number, (Object*) gadgets[GID_U_IN8 ], (ULONG*) &man[who].xp);
    GetAttr(INTEGER_Number, (Object*) gadgets[GID_U_IN10], (ULONG*) &man[who].str);
    GetAttr(INTEGER_Number, (Object*) gadgets[GID_U_IN11], (ULONG*) &man[who].iq);
    GetAttr(INTEGER_Number, (Object*) gadgets[GID_U_IN12], (ULONG*) &man[who].dex);

    switch (game)
    {
    case ULTIMA3:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U_IN_MAXHP   ], (ULONG*) &man[who].maxhp   );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U345_CH_CLASS], (ULONG*) &man[who].theclass);
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U_CH2        ], (ULONG*) &man[who].sex     );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U_CH3        ], (ULONG*) &man[who].status  );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U34_CH4      ], (ULONG*) &man[who].armour  );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U34_CH5      ], (ULONG*) &man[who].weapon  );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U3_CH_RACE   ], (ULONG*) &man[who].race    );
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U3_IN_FOOD   ], (ULONG*) &man[who].food    );
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U3_IN_GP     ], (ULONG*) &man[who].gp      );
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U3_IN_GEMS   ], (ULONG*) &man[who].gems    );
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U3_IN_KEYS   ], (ULONG*) &man[who].keys    );
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U3_IN_POWDERS], (ULONG*) &man[who].powders );
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U3_IN_TORCHES], (ULONG*) &man[who].torches );

        for (i = 1; i < 8; i++)
        {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_U3_IN60 + i - 1], (ULONG*) &man[who].armours[i]);
        }
        for (i = 1; i < 16; i++)
        {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_U3_IN67 + i - 1], (ULONG*) &man[who].weapons[i]);
        }
        for (i = 0; i < 4; i++)
        {   DISCARD GetAttr(GA_Selected,  (Object*) gadgets[GID_U3_CB17 + i  ], (ULONG*) &man[who].card[i] );
            DISCARD GetAttr(GA_Selected,  (Object*) gadgets[GID_U3_CB21 + i  ], (ULONG*) &man[who].mark[i] );
        }
    acase ULTIMA4:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U_IN_MAXHP   ], (ULONG*) &man[who].maxhp   );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U345_CH_CLASS], (ULONG*) &man[who].theclass);
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U_CH2        ], (ULONG*) &man[who].sex     );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U_CH3        ], (ULONG*) &man[who].status  );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U34_CH4      ], (ULONG*) &man[who].armour  );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U34_CH5      ], (ULONG*) &man[who].weapon  );

        for (i = 0; i < 8; i++)
        {   DISCARD GetAttr(GA_Selected,  (Object*) gadgets[GID_U4_CB17 + i  ], (ULONG*) &man[who].virtue[i]);
        }
    acase ULTIMA5:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U_IN_MAXHP   ], (ULONG*) &man[who].maxhp   );
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U56_IN_LEVEL ], (ULONG*) &man[who].level   );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U345_CH_CLASS], (ULONG*) &man[who].theclass);
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U_CH2        ], (ULONG*) &man[who].sex     );
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_U_CH3        ], (ULONG*) &man[who].status  );
    acase ULTIMA6:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U56_IN_LEVEL ], (ULONG*) &man[who].level   );
}   }

MODULE void serialize(void)
{   TRANSIENT       ULONG  temp;
    TRANSIENT       int    i, j,
                           length;
    PERSIST         FLAG   highbit_name[8],
                           highbit_cond[8];
    PERSIST         UBYTE  u4_otheritems[2];
    PERSIST   const STRPTR raceletters     = "BDEFH",
                           sexletters      = "MFO",
                           statusletters   = "GDPA",
                           theclassletters = "ABCDFILPRTW";

    offset = 0;

    switch (game)
    {
    case ULTIMA3:
        for (i = 0; i < gamesize / 64; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   strcpy(man[i].name, (char*) &IOBuffer[offset]); //  0..11
                j = 0;
                while (man[i].name[j] != EOS)
                {   man[i].name[j++] -= 0x80;
            }   }
            else
            {   // assert(serializemode == SERIALIZE_WRITE);
                j = 0;
                while (man[i].name[j] != EOS)
                {   man[i].name[j++] += 0x80;
                }
                strcpy((char*) &IOBuffer[offset], man[i].name);
                j = 0;
                while (man[i].name[j] != EOS)
                {   man[i].name[j++] -= 0x80;
            }   }

            offset += 14;                                       // 12..13

            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);                              // 14
                if (temp & 0x80) man[i].mark[0] = 1; else man[i].mark[0] = 0;
                if (temp & 0x40) man[i].mark[1] = 1; else man[i].mark[1] = 0;
                if (temp & 0x20) man[i].mark[2] = 1; else man[i].mark[2] = 0;
                if (temp & 0x10) man[i].mark[3] = 1; else man[i].mark[3] = 0;
                if (temp & 0x08) man[i].card[0] = 1; else man[i].card[0] = 0;
                if (temp & 0x04) man[i].card[1] = 1; else man[i].card[1] = 0;
                if (temp & 0x02) man[i].card[2] = 1; else man[i].card[2] = 0;
                if (temp & 0x01) man[i].card[3] = 1; else man[i].card[3] = 0;
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);

                temp = 0;
                if (man[i].mark[0]) temp |= 0x80;
                if (man[i].mark[1]) temp |= 0x40;
                if (man[i].mark[2]) temp |= 0x20;
                if (man[i].mark[3]) temp |= 0x10;
                if (man[i].card[0]) temp |= 0x08;
                if (man[i].card[1]) temp |= 0x04;
                if (man[i].card[2]) temp |= 0x02;
                if (man[i].card[3]) temp |= 0x01;
                serialize1(&temp);
            }

            serialize_bcd1(&man[i].torches);                    // 15
            offset++;                                           // 16
            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);                              // 17
                man[i].status = yes(statusletters, (TEXT) temp);
            } elif (serializemode == SERIALIZE_WRITE)
            {   temp = statusletters[man[i].status];
                serialize1(&temp);
            }
            serialize_bcd1(&man[i].str   );                     // 18
            serialize_bcd1(&man[i].dex   );                     // 19
            serialize_bcd1(&man[i].iq    );                     // 20
            serialize_bcd1(&man[i].wis   );                     // 21
            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);                              // 22
                man[i].race = yes(raceletters, (TEXT) temp);
                serialize1(&temp);                              // 23
                man[i].theclass = yes(theclassletters, (TEXT) temp);
                serialize1(&temp);                              // 24
                man[i].sex = yes(sexletters, (TEXT) temp);
            } elif (serializemode == SERIALIZE_WRITE)
            {   temp = raceletters[man[i].race];
                serialize1(&temp);
                temp = theclassletters[man[i].theclass];
                serialize1(&temp);
                temp = sexletters[man[i].sex];
                serialize1(&temp);
            }
            serialize_bcd1(&man[i].mp     );                    // 25
            serialize_bcd2(&man[i].curhp  );                    // 26..27
            serialize_bcd2(&man[i].maxhp  );                    // 28..29
            serialize_bcd2(&man[i].xp     );                    // 30..31
            serialize_bcd2(&man[i].food   );                    // 32..33
            offset++;                                           // 34
            serialize_bcd2(&man[i].gp     );                    // 35..36
            serialize_bcd1(&man[i].gems   );                    // 37
            serialize_bcd1(&man[i].keys   );                    // 38
            serialize_bcd1(&man[i].powders);                    // 39
            serialize1(&man[i].armour);                         // 40
            for (j = 1; j < 8; j++)
            {   serialize1(&man[i].armours[j]);                 // 41..47
            }
            serialize1(&man[i].weapon);                         // 48
            for (j = 1; j < 16; j++)
            {   serialize1(&man[i].weapons[j]);                 // 49..63
            }

            man[i].level = 0;
            for (j = 0; j < 8; j++)
            {   man[i].virtue[j] = 0;
        }   }

        for (i = 0; i < 8; i++)
        {   armour[i]   =
            reagents[i] =
            rune[i]     =
            stone[i]    =
            u4_karma[i] = 0;
        }
        for (i = 0; i < 9; i++)
        {   u4_item[i] = 0;
        }
        for (i = 0; i < 26; i++)
        {   weapons[i]  = 0;
        }
        for (i = 0; i < 48; i++)
        {   mixtures[i] = 0;
        }
        food     =
        gems     =
        gp       =
        keys     =
        sextants =
        torches  = 0;
    acase ULTIMA4:
        men = 8;

        for (i = 0; i < 8; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   strcpy(man[i].name, (char*) &IOBuffer[offset]);
                highbit_name[i] = (man[i].name[0] & 0x80) ? TRUE : FALSE;
                if (highbit_name[i])
                {   length = strlen(man[i].name);
                    for (j = 0; j < length; j++)
                    {   man[i].name[j] &= 0x7F;
            }   }   }
            else
            {   // assert(serializemode == SERIALIZE_WRITE);
                strcpy((char*) &IOBuffer[offset], man[i].name);
                if (highbit_name[i])
                {   length = strlen(man[i].name);
                    for (j = 0; j < length; j++)
                    {   IOBuffer[offset + j] |= 0x80;
            }   }   }
            offset += 16;                                    //   0.. 15 $ 0..$ F

            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);                           //  16      $10
                if (temp == 0x5C)
                {   man[i].sex = 0; // male
                } else
                {   // assert(temp == 0x7B);
                    man[i].sex = 1; // female
            }   }
            elif (serializemode == SERIALIZE_WRITE)
            {   if (man[i].sex == 0)
                {   temp = 0x5C; // male
                } else
                {   // assert(man[i].sex == 1);
                    temp = 0x7B; // female
                }
                serialize1(&temp);
            }

            serialize1(&man[i].theclass);                    //  17      $11

            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);                           //  18      $12
                highbit_cond[i] = (temp & 0x80) ? TRUE : FALSE;
                switch (temp & 0x7F)
                {
                case  'G': man[i].status = 0;
                acase 'D': man[i].status = 1;
                acase 'P': man[i].status = 2;
                acase 'S': man[i].status = 3;
                adefault:  man[i].status = 0;
            }   }
            elif (serializemode == SERIALIZE_WRITE)
            {   switch (man[i].status)
                {
                case  0:  temp = 'G';
                acase 1:  temp = 'D';
                acase 2:  temp = 'P';
                acase 3:  temp = 'S';
                adefault: temp = '!'; // should never happen
                }
                if (highbit_cond[i])
                {   temp |= 0x80;
                }
                serialize1(&temp);
            }

            serialize_bcd1(&man[i].str   );                  //  19      $13
            serialize_bcd1(&man[i].dex   );                  //  20      $14
            serialize_bcd1(&man[i].iq    );                  //  21      $15
            serialize_bcd1(&man[i].mp    );                  //  22      $16

            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);                           //  23      $17
                if (temp & 0x80) man[i].virtue[0] = 1; else man[i].virtue[0] = 0;
                if (temp & 0x40) man[i].virtue[1] = 1; else man[i].virtue[1] = 0;
                if (temp & 0x20) man[i].virtue[2] = 1; else man[i].virtue[2] = 0;
                if (temp & 0x10) man[i].virtue[3] = 1; else man[i].virtue[3] = 0;
                if (temp & 0x08) man[i].virtue[4] = 1; else man[i].virtue[4] = 0;
                if (temp & 0x04) man[i].virtue[5] = 1; else man[i].virtue[5] = 0;
                if (temp & 0x02) man[i].virtue[6] = 1; else man[i].virtue[6] = 0;
                if (temp & 0x01) man[i].virtue[7] = 1; else man[i].virtue[7] = 0;
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                temp = 0;
                if (man[i].virtue[0]) temp |= 0x80;
                if (man[i].virtue[1]) temp |= 0x40;
                if (man[i].virtue[2]) temp |= 0x20;
                if (man[i].virtue[3]) temp |= 0x10;
                if (man[i].virtue[4]) temp |= 0x08;
                if (man[i].virtue[5]) temp |= 0x04;
                if (man[i].virtue[6]) temp |= 0x02;
                if (man[i].virtue[7]) temp |= 0x01;
                serialize1(&temp);                           //  23      $17
            }

            serialize_bcd2(&man[i].curhp );                  //  24.. 25 $18..$19
            serialize_bcd2(&man[i].maxhp );                  //  26.. 27 $1A..$1B
            serialize_bcd2(&man[i].xp    );                  //  28.. 29 $1C..$1D
            serialize1(    &man[i].weapon);                  //  30      $1E
            serialize_bcd1(&man[i].armour);                  //  31      $1F

            for (j = 0; j < 4; j++)
            {   man[i].card[j] = man[i].mark[j] = 0;
            }
            man[i].food    =
            man[i].gems    =
            man[i].gp      =
            man[i].keys    =
            man[i].powders =
            man[i].torches =
            man[i].wis     = 0;
            man[i].race    = 4; // human
            for (j = 1; j < 8; j++)
            {   man[i].armours[j] = 0;
            }
            for (j = 1; j < 16; j++)
            {   man[i].weapons[j] = 0;
            }
            man[i].level = 0;
        }

        // assert(offset == 256);

        for (i = 0; i < 8; i++)
        {   serialize_bcd1(&u4_karma[i]);                    // 256..263
        }
        serialize_bcd1(&torches);                            // 264
        serialize_bcd1(&gems);                               // 265
        serialize_bcd1(&keys);                               // 266
        serialize_bcd1(&sextants);                           // 267
        if (serializemode == SERIALIZE_READ)
        {   serialize1(&temp);                               // 268
            if (temp & 0x80) stone[0] = 1; else stone[0] = 0;
            if (temp & 0x40) stone[1] = 1; else stone[1] = 0;
            if (temp & 0x20) stone[2] = 1; else stone[2] = 0;
            if (temp & 0x10) stone[3] = 1; else stone[3] = 0;
            if (temp & 0x08) stone[4] = 1; else stone[4] = 0;
            if (temp & 0x04) stone[5] = 1; else stone[5] = 0;
            if (temp & 0x02) stone[6] = 1; else stone[6] = 0;
            if (temp & 0x01) stone[7] = 1; else stone[7] = 0;
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            temp = 0;
            if (stone[0]) temp |= 0x80;
            if (stone[1]) temp |= 0x40;
            if (stone[2]) temp |= 0x20;
            if (stone[3]) temp |= 0x10;
            if (stone[4]) temp |= 0x08;
            if (stone[5]) temp |= 0x04;
            if (stone[6]) temp |= 0x02;
            if (stone[7]) temp |= 0x01;
            serialize1(&temp);
        }
        if (serializemode == SERIALIZE_READ)
        {   serialize1(&temp);                               // 269
            if (temp & 0x80) rune[0] = 1; else rune[0] = 0;
            if (temp & 0x40) rune[1] = 1; else rune[1] = 0;
            if (temp & 0x20) rune[2] = 1; else rune[2] = 0;
            if (temp & 0x10) rune[3] = 1; else rune[3] = 0;
            if (temp & 0x08) rune[4] = 1; else rune[4] = 0;
            if (temp & 0x04) rune[5] = 1; else rune[5] = 0;
            if (temp & 0x02) rune[6] = 1; else rune[6] = 0;
            if (temp & 0x01) rune[7] = 1; else rune[7] = 0;
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            temp = 0;
            if (rune[0]) temp |= 0x80;
            if (rune[1]) temp |= 0x40;
            if (rune[2]) temp |= 0x20;
            if (rune[3]) temp |= 0x10;
            if (rune[4]) temp |= 0x08;
            if (rune[5]) temp |= 0x04;
            if (rune[6]) temp |= 0x02;
            if (rune[7]) temp |= 0x01;
            serialize1(&temp);
        }
        if (serializemode == SERIALIZE_READ)
        {   serialize1(&temp);                               // 270 $10E losing items here $77->$07
            u4_otheritems[0] = temp & 0xF8;
            if (temp & 0x04) u4_item[5] = 1; else u4_item[5] = 0;
            if (temp & 0x02) u4_item[1] = 1; else u4_item[1] = 0;
            if (temp & 0x01) u4_item[3] = 1; else u4_item[3] = 0;
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            temp = u4_otheritems[0];
            if (u4_item[5]) temp |= 0x04;
            if (u4_item[1]) temp |= 0x02;
            if (u4_item[3]) temp |= 0x01;
            serialize1(&temp);
        }
        if (serializemode == SERIALIZE_READ)
        {   serialize1(&temp);                               // 271 $10F
            u4_otheritems[1] = temp & 0xF8;
            if (temp & 0x04) u4_item[0] = 1; else u4_item[0] = 0;
            if (temp & 0x02) u4_item[2] = 1; else u4_item[2] = 0;
            if (temp & 0x01) u4_item[4] = 1; else u4_item[4] = 0;
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            temp = u4_otheritems[1];
            if (u4_item[0]) temp |= 0x04;
            if (u4_item[2]) temp |= 0x02;
            if (u4_item[4]) temp |= 0x01;
            serialize1(&temp);
        }
        serialize_bcd2(&food);                               // 272..273
        offset++; // fractional part of food                 // 274
        serialize_bcd2(&gp);                                 // 275..276
        serialize1(&u4_item[6]);                             // 277
        serialize1(&u4_item[7]);                             // 278
        serialize1(&u4_item[8]);                             // 279
        for (i = 0; i < 8; i++)
        {   serialize_bcd1(&armour[i]);                      // 280..287
        }
        for (i = 0; i < 16; i++)
        {   serialize_bcd1(&weapons[i]);                     // 288..303
        }
        offset += 8;                                         // 304..311
        for (i = 0; i < 8; i++)
        {   serialize_bcd1(&reagents[i]);                    // 312..319
        }
        for (i = 0; i < 26; i++)
        {   serialize_bcd1(&mixtures[i]);                    // 320..345
        }

        // assert(offset == 346);
        // offset += 166;                                    // 346..511
        // assert(offset == 512);

        u5_karma = 0;
        for (i = 0; i < 8; i++)
        {   potions[i] =
            scrolls[i] = 0;
        }
    acase ULTIMA5:
        offset = 2;

        for (i = 0; i < 16; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   strcpy(man[i].name, (char*) &IOBuffer[offset]); //   2.. 10
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                strcpy((char*) &IOBuffer[offset], man[i].name);
            }
            offset += 9;

            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);                              //  11
                if (temp == 0x0B)
                {   man[i].sex = 0; // male
                } else
                {   // assert(temp == 0x0C);
                    man[i].sex = 1; // female
            }   }
            elif (serializemode == SERIALIZE_WRITE)
            {   if (man[i].sex == 0)
                {   temp = 0x0B; // male
                } else
                {   // assert(man[i].sex == 1);
                    temp = 0x0C; // female
                }
                serialize1(&temp);
            }

            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);                              //  12
                switch (temp)
                {
                case  'A': man[i].theclass = U5CLASS_AVATAR;
                acase 'B': man[i].theclass = U5CLASS_BARD;
                acase 'F': man[i].theclass = U5CLASS_FIGHTER;
                acase 'M': man[i].theclass = U5CLASS_MAGE;
            }   }
            elif (serializemode == SERIALIZE_WRITE)
            {   switch (man[i].theclass)
                {
                case  U5CLASS_AVATAR:  temp = 'A';
                acase U5CLASS_BARD:    temp = 'B';
                acase U5CLASS_FIGHTER: temp = 'F';
                acase U5CLASS_MAGE:    temp = 'M';
                }
                serialize1(&temp);
            }

            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);                              //  13
                switch (temp)
                {
                case  'G': man[i].status = 0;
                acase 'D': man[i].status = 1;
                acase 'P': man[i].status = 2;
                acase 'S': man[i].status = 3;
            }   }
            elif (serializemode == SERIALIZE_WRITE)
            {   switch (man[i].status)
                {
                case  0: temp = 'G';
                acase 1: temp = 'D';
                acase 2: temp = 'P';
                acase 3: temp = 'S';
                }
                serialize1(&temp);
            }

            serialize1(&man[i].str   );                  //  14
            serialize1(&man[i].dex   );                  //  15
            serialize1(&man[i].iq    );                  //  16
            serialize1(&man[i].mp    );                  //  17
            serialize2ulong(&man[i].curhp);              //  18.. 19
            serialize2ulong(&man[i].maxhp);              //  20.. 21
            serialize2ulong(&man[i].xp);                 //  22.. 23
            serialize1(&man[i].level );                  //  24
            offset += 2;                                 //  25.. 26
            offset += 6; // item slots                   //  27.. 32
            offset++;                                    //  33

            for (j = 0; j < 4; j++)
            {   man[i].card[j] = man[i].mark[j] = 0;
            }
            man[i].food    =
            man[i].gems    =
            man[i].gp      =
            man[i].keys    =
            man[i].powders =
            man[i].torches =
            man[i].wis     = 0;
            man[i].race    = 4; // human
            for (j = 1; j < 8; j++)
            {   man[i].armours[j] = 0;
            }
            for (j = 1; j < 16; j++)
            {   man[i].weapons[j] = 0;
            }
            for (j = 0; j < 8; j++)
            {   man[i].virtue[j] = 0;
        }   }

        // assert(offset == 514);

        serialize2ulong(&food);                          // 514..515
        serialize2ulong(&gp);                            // 516..517
        serialize1(&keys);                               // 518
        serialize1(&gems);                               // 519
        serialize1(&torches);                            // 520
        serialize1(&u5_item[0]);                         // $209
        serialize1(&carpets);                            // $20A
        serialize1(&skullkeys);                          // $20B
        offset++;                                        // $20C
        for (i = 0; i < 6; i++)
        {   serialize1(&u5_item[6 + i]);                 // $20D..$212
        }
        offset++;                                        // $213
        serialize1(&u5_item[1]);                         // $214
        serialize1(&u5_item[2]);                         // $215
        serialize1(&sextants);                           // $216
        serialize1(&u5_item[3]);                         // $217
        serialize1(&u5_item[4]);                         // $218
        serialize1(&u5_item[5]);                         // $219
        for (i = 0; i < 4; i++)
        {   serialize1(&helms[i]);                       // $21A..$21D
        }
        for (i = 0; i < 5; i++)
        {   serialize1(&shields[i]);                     // $21E..$222
        }
        for (i = 0; i < 7; i++)
        {   serialize1(&armour[i]);                      // $223..$229
        }
        for (i = 0; i < 26; i++)
        {   serialize1(&weapons[i]);                     // $22A..$243
        }
        for (i = 0; i < 3; i++)
        {   serialize1(&rings[i]);                       // $244..$246
        }
        for (i = 0; i < 3; i++)
        {   serialize1(&amulets[i]);                     // $247..$249
        }
        for (i = 0; i < 48; i++)
        {   serialize1(&mixtures[i]);                    // $24A..$279
        }
        for (i = 0; i < 8; i++)
        {   serialize1(&scrolls[i]);                     // $27A..$281
        }
        for (i = 0; i < 8; i++)
        {   serialize1(&potions[i]);                     // $282..$289
        }
        offset += 32;                                    // $28A..$2A9
        for (i = 0; i < 8; i++)
        {   serialize1(&reagents[i]);                    // $2AA..$2B1
        }
        offset += 3;                                     // $2B2..$2B4
        serialize1(&men);                                // $2B5
        offset += 24;                                    // $2B6..$2CD
        serialize2ulong(&year);                          // $2CE..$2CF
        offset += 11;                                    // $2D0..$2DA
        serialize1(&month);                              // $2DB
        serialize1(&day);                                // $2DC
        serialize1(&hour);                               // $2DD
        offset++;                                        // $2DE
        serialize1(&minute);                             // $2DF
        offset += 6;                                     // $2E0..$2E5
        serialize1(&u5_karma);                           // $2E6
        offset += 10;                                    // $2E7..$2F0
        serialize1(&location);                           // $2F1
        if (serializemode == SERIALIZE_WRITE)
        {   serialize1(&location);                       // $2F2
            if (floor == 0)
            {   floor = 255;
            } else
            {   floor--;
        }   }
        else
        {   offset++;                                    // $2F2
        }
        serialize1(&floor);                              // $2F3
        if (floor == 255)
        {   floor = 0;
        } else
        {   floor++;
        }
        serialize1(&loc_x);                              // $2F4
        serialize1(&loc_y);                              // $2F5

        // more unknown bytes here

        for (i = 0; i < 8; i++)
        {   u4_karma[i] =
            rune[i]     =
            stone[i]    = 0;
        }
    acase ULTIMA6:
        temp = 0xC0; // means OK
        offset = 4080;
        serialize1(&men);                                // 4080

        for (i = 0; i < (int) men; i++)
        {   offset = 4064 + i;
            serialize1(&man[i].code   ); // 4064..4071 (must be done first!)

         // printf("Man #%d's code is %d.\n", i, man[i].code);

            if (serializemode == SERIALIZE_WRITE)
            {   offset = 2048 + man[i].code;
                serialize1(&temp);
            }
            offset = 2304 +   man[i].code;
            serialize1(&man[i].str    );
            offset = 2560 +   man[i].code;
            serialize1(&man[i].dex    );
            offset = 2816 +   man[i].code;
            serialize1(&man[i].iq     );
            offset = 3074 + ((man[i].code - 1) * 2);
            serialize2ulong(&man[i].xp);
            offset = 3584 +   man[i].code;
            serialize1(&man[i].curhp  );

            offset = 3840 + (i * 14);
            if (serializemode == SERIALIZE_READ)
            {   strcpy(man[i].name, (char*) &IOBuffer[offset]); // 3840..3951
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                strcpy((char*) &IOBuffer[offset], man[i].name); // 3840..3951
            }

            offset = 4081 + man[i].code;
            serialize1(&man[i].level  );
            man[i].maxhp = man[i].level * 30;

            offset = 5105 + man[i].code;
            serialize1(&man[i].mp);

            for (j = 0; j < 4; j++)
            {   man[i].card[j] = man[i].mark[j] = 0;
            }
            man[i].food     =
            man[i].gems     =
            man[i].gp       =
            man[i].keys     =
            man[i].powders  =
            man[i].torches  =
            man[i].wis      = 0;
            man[i].race     = 4; // human
            for (j = 1; j < 8; j++)
            {   man[i].armours[j] = 0;
            }
            for (j = 1; j < 16; j++)
            {   man[i].weapons[j] = 0;
            }
            for (j = 0; j < 8; j++)
            {   man[i].virtue[j] = 0;
            }
            man[i].theclass = 0;
        }

        offset = 7281;
        serialize1(&sex);                // 7281

        // assert(offset = 7282);
        if (serializemode == SERIALIZE_WRITE)
        {   portrait++;
        }
        serialize1(&portrait);           // 7282
        portrait--;
}   }

EXPORT FLAG ultima_open(FLAG loadas)
{   ULONG oldgame;

    oldgame = game;
    if (gameopen(loadas))
    {   switch (gamesize)
        {
        case   256: case 1280: game = ULTIMA3; men = gamesize / 64; // 4 or 20
        acase  512:            game = ULTIMA4;
        acase 4838:            game = ULTIMA5;
        adefault:              game = ULTIMA6;
        }
        who = 0;
        serializemode = SERIALIZE_READ;
        serialize();
        if (oldgame != NOGAME && oldgame != game)
        {   SetGadgetAttrs(gadgets[GID_U345_CH_CLASS], MainWindowPtr, NULL, CHOOSER_Labels,     (ULONG) ~0,                                                  TAG_DONE);
            ch_clearlist(&ClassesList);
            load_chooser_images();
            SetGadgetAttrs(gadgets[GID_U345_CH_CLASS], MainWindowPtr, NULL, CHOOSER_Labels,     &ClassesList,                                                TAG_DONE);
            SetGadgetAttrs(gadgets[GID_U34_CH4      ], MainWindowPtr, NULL, CHOOSER_LabelArray, (game == ULTIMA3) ? (&U3ArmourOptions) : (&U4ArmourOptions), TAG_DONE);
            SetGadgetAttrs(gadgets[GID_U34_CH5      ], MainWindowPtr, NULL, CHOOSER_LabelArray, (game == ULTIMA3) ? (&U3WeaponOptions) : (&U4WeaponOptions), TAG_DONE);
            SetGadgetAttrs(gadgets[GID_U_CH2        ], MainWindowPtr, NULL, CHOOSER_LabelArray, (game == ULTIMA3) ? (&U3SexOptions   ) : (&U456SexOptions),  TAG_DONE);
            change_game();
        }
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}
EXPORT void ultima_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  ULTIMA3: gamesave("(PLRS.BIN)|(ROST.BIN)", "Ultima 3", saveas, gamesize, FLAG_S, FALSE);
    acase ULTIMA4: gamesave("#?ROST.BIN#?"         , "Ultima 4", saveas,      512, FLAG_S, FALSE);
    acase ULTIMA5: gamesave("#?saved.gam#?"        , "Ultima 5", saveas,     4838, FLAG_S, FALSE);
    acase ULTIMA6: gamesave("#?objlist#?"          , "Ultima 6", saveas, gamesize, FLAG_S, FALSE);
}   }

EXPORT void ultima_close(void) { ; }

EXPORT void ultima_exit(void)
{   ch_clearlist(&ClassesList);
}
EXPORT void ultima_die(void)
{   lb_clearlist(&LocationsList);
}

MODULE void maximize_man(int whichman)
{   int i;

    switch (game)
    {
    case ULTIMA3:
        man[whichman].status   =      0;
        man[whichman].armour   =      7;
        man[whichman].weapon   =     15;
        man[whichman].str      =
        man[whichman].iq       =
        man[whichman].dex      =
        man[whichman].wis      =
        man[whichman].mp       =     90;
        man[whichman].xp       =
        man[whichman].curhp    =
        man[whichman].maxhp    =   9000;
        for (i = 0; i < 4; i++)
        {   man[whichman].card[i]    =
            man[whichman].mark[i]    =  1;
        }
        for (i = 1; i < 8; i++)
        {   man[whichman].armours[i] = 90;
        }
        for (i = 1; i < 16; i++)
        {   man[whichman].weapons[i] = 90;
        }
        man[whichman].food     =
        man[whichman].gp       =   9000;
        man[whichman].gems     =
        man[whichman].keys     =
        man[whichman].powders  =
        man[whichman].torches  =     90;
    acase ULTIMA4:
        man[whichman].status   =      0;
        man[whichman].armour   =      7;
        man[whichman].weapon   =     15;
        man[whichman].str      =
        man[whichman].iq       =
        man[whichman].dex      =
        man[whichman].mp       =     90;
        man[whichman].xp       =
        man[whichman].curhp    =
        man[whichman].maxhp    =   9000;
        for (i = 0; i < 8; i++)
        {   man[whichman].virtue[i] = 1;
        }
    acase ULTIMA5:
        man[whichman].status =    0;
        man[whichman].str    =
        man[whichman].iq     =
        man[whichman].dex    =
        man[whichman].mp     =   90;
        man[whichman].xp     =
        man[whichman].curhp  =
        man[whichman].maxhp  = 9000;
    acase ULTIMA6:
        man[whichman].level  =     8;
        man[whichman].iq     =
        man[whichman].dex    =   120;
        man[whichman].str    =   200;
        man[whichman].mp     = man[whichman].iq    *  2; // ie. 240
        man[whichman].curhp  =
        man[whichman].maxhp  = man[whichman].level * 30; // ie. 240
        man[whichman].xp     = 30000;
}   }

MODULE void morewindow(void)
{   int i;

    // assert(game == ULTIMA4 || game == ULTIMA5);

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                                      "Choose More",
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                               "ultima-1",
        WINDOW_ParentGroup,                            gadgets[GID_U45_LY_MORE] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                LAYOUT_Label,                          "General",
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_AddChild,                       gadgets[GID_U45_IN_FOOD] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U45_IN_FOOD,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   9999,
                    INTEGER_Number,                    food,
                    INTEGER_MinVisible,                4 + 1,
                IntegerEnd,
                Label("Food:"),
                LAYOUT_AddChild,                       gadgets[GID_U45_IN_GP] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U45_IN_GP,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   9999,
                    INTEGER_Number,                    gp,
                    INTEGER_MinVisible,                4 + 1,
                IntegerEnd,
                Label("Gold:"),
                LAYOUT_AddChild,                       gadgets[GID_U45_IN_GEMS] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U45_IN_GEMS,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   99,
                    INTEGER_Number,                    gems,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Gems:"),
                LAYOUT_AddChild,                       gadgets[GID_U45_IN_KEYS] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U45_IN_KEYS,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   99,
                    INTEGER_Number,                    keys,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Keys:"),
                LAYOUT_AddChild,                       gadgets[GID_U45_IN_SEXTANTS] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U45_IN_SEXTANTS,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   99,
                    INTEGER_Number,                    sextants,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Sextants:"),
                LAYOUT_AddChild,                       gadgets[GID_U45_IN_TORCHES] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U45_IN_TORCHES,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   99,
                    INTEGER_Number,                    torches,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Torches:"),
                LAYOUT_AddChild,                       gadgets[GID_U5_IN_KARMA] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U5_IN_KARMA,
                    GA_TabCycle,                       TRUE,
                    GA_Disabled,                       (game == ULTIMA5) ? FALSE : TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   99,
                    INTEGER_Number,                    u5_karma,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Karma:"),
            LayoutEnd,
            AddHLayout,
                LAYOUT_SpaceOuter,                     TRUE,
                AddHLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Karma and Runes",
                    AddVLayout,
                        LAYOUT_AddChild,               gadgets[GID_U4_IN26] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U4_IN26,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            u4_karma[0],
                            INTEGER_MinVisible,        2 + 1,
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_U4_IN27] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U4_IN27,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            u4_karma[1],
                            INTEGER_MinVisible,        2 + 1,
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_U4_IN28] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U4_IN28,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            u4_karma[2],
                            INTEGER_MinVisible,        2 + 1,
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_U4_IN29] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U4_IN29,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            u4_karma[3],
                            INTEGER_MinVisible,        2 + 1,
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_U4_IN30] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U4_IN30,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            u4_karma[4],
                            INTEGER_MinVisible,        2 + 1,
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_U4_IN31] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U4_IN31,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            u4_karma[5],
                            INTEGER_MinVisible,        2 + 1,
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_U4_IN32] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U4_IN32,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            u4_karma[6],
                            INTEGER_MinVisible,        2 + 1,
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        IntegerEnd,
                        LAYOUT_AddChild,               gadgets[GID_U4_IN33] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U4_IN33,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            u4_karma[7],
                            INTEGER_MinVisible,        2 + 1,
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        IntegerEnd,
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_AddChild,               gadgets[GID_U4_CB1] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U4_CB1,
                            GA_Selected,               rune[0],
                            GA_Text,                   "Honesty",
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U4_CB2] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U4_CB2,
                            GA_Selected,               rune[1],
                            GA_Text,                   "Compassion",
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U4_CB3] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U4_CB3,
                            GA_Selected,               rune[2],
                            GA_Text,                   "Valor",
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U4_CB4] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U4_CB4,
                            GA_Selected,               rune[3],
                            GA_Text,                   "Justice",
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U4_CB5] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U4_CB5,
                            GA_Selected,               rune[4],
                            GA_Text,                   "Sacrifice",
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U4_CB6] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U4_CB6,
                            GA_Selected,               rune[5],
                            GA_Text,                   "Honour",
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U4_CB7] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U4_CB7,
                            GA_Selected,               rune[6],
                            GA_Text,                   "Spirituality",
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U4_CB8] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U4_CB8,
                            GA_Selected,               rune[7],
                            GA_Text,                   "Humility",
                            GA_Disabled,               (game == ULTIMA4) ? FALSE : TRUE,
                        End,
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Stones",
                    LAYOUT_AddChild,                   gadgets[GID_U4_CB9] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                         GID_U4_CB9,
                        GA_Selected,                   stone[0],
                        GA_Text,                       "Blue",
                        GA_Disabled,                   (game == ULTIMA4) ? FALSE : TRUE,
                    End,
                    LAYOUT_AddChild,                   gadgets[GID_U4_CB10] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                         GID_U4_CB10,
                        GA_Selected,                   stone[1],
                        GA_Text,                       "Yellow",
                        GA_Disabled,                   (game == ULTIMA4) ? FALSE : TRUE,
                    End,
                    LAYOUT_AddChild,                   gadgets[GID_U4_CB11] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                         GID_U4_CB11,
                        GA_Selected,                   stone[2],
                        GA_Text,                       "Red",
                        GA_Disabled,                   (game == ULTIMA4) ? FALSE : TRUE,
                    End,
                    LAYOUT_AddChild,                   gadgets[GID_U4_CB12] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                         GID_U4_CB12,
                        GA_Selected,                   stone[3],
                        GA_Text,                       "Green",
                        GA_Disabled,                   (game == ULTIMA4) ? FALSE : TRUE,
                    End,
                    LAYOUT_AddChild,                   gadgets[GID_U4_CB13] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                         GID_U4_CB13,
                        GA_Selected,                   stone[4],
                        GA_Text,                       "Orange",
                        GA_Disabled,                   (game == ULTIMA4) ? FALSE : TRUE,
                    End,
                    LAYOUT_AddChild,                   gadgets[GID_U4_CB14] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                         GID_U4_CB14,
                        GA_Selected,                   stone[5],
                        GA_Text,                       "Purple",
                        GA_Disabled,                   (game == ULTIMA4) ? FALSE : TRUE,
                    End,
                    LAYOUT_AddChild,                   gadgets[GID_U4_CB15] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                         GID_U4_CB15,
                        GA_Selected,                   stone[6],
                        GA_Text,                       "White",
                        GA_Disabled,                   (game == ULTIMA4) ? FALSE : TRUE,
                    End,
                    LAYOUT_AddChild,                   gadgets[GID_U4_CB16] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                         GID_U4_CB16,
                        GA_Selected,                   stone[7],
                        GA_Text,                       "Black",
                        GA_Disabled,                   (game == ULTIMA4) ? FALSE : TRUE,
                    End,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Potions",
                    LAYOUT_AddChild,                   gadgets[GID_U5_IN34] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U5_IN34,
                        GA_TabCycle,                   TRUE,
                        GA_Disabled,                   (game == ULTIMA5) ? FALSE : TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                potions[0],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Blue:"),
                    LAYOUT_AddChild,                   gadgets[GID_U5_IN35] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U5_IN35,
                        GA_TabCycle,                   TRUE,
                        GA_Disabled,                   (game == ULTIMA5) ? FALSE : TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                potions[1],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Yellow:"),
                    LAYOUT_AddChild,                   gadgets[GID_U5_IN36] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U5_IN36,
                        GA_TabCycle,                   TRUE,
                        GA_Disabled,                   (game == ULTIMA5) ? FALSE : TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                potions[2],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Red:"),
                    LAYOUT_AddChild,                   gadgets[GID_U5_IN37] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U5_IN37,
                        GA_TabCycle,                   TRUE,
                        GA_Disabled,                   (game == ULTIMA5) ? FALSE : TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                potions[3],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Green:"),
                    LAYOUT_AddChild,                   gadgets[GID_U5_IN38] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U5_IN38,
                        GA_TabCycle,                   TRUE,
                        GA_Disabled,                   (game == ULTIMA5) ? FALSE : TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                potions[4],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Orange:"),
                    LAYOUT_AddChild,                   gadgets[GID_U5_IN39] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U5_IN39,
                        GA_TabCycle,                   TRUE,
                        GA_Disabled,                   (game == ULTIMA5) ? FALSE : TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                potions[5],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Purple:"),
                    LAYOUT_AddChild,                   gadgets[GID_U5_IN40] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U5_IN40,
                        GA_TabCycle,                   TRUE,
                        GA_Disabled,                   (game == ULTIMA5) ? FALSE : TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                potions[6],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("White:"),
                    LAYOUT_AddChild,                   gadgets[GID_U5_IN41] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U5_IN41,
                        GA_TabCycle,                   TRUE,
                        GA_Disabled,                   (game == ULTIMA5) ? FALSE : TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                potions[7],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Black:"),
                LayoutEnd,
            LayoutEnd,
            AddHLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Reagents",
                    LAYOUT_AddChild,                   gadgets[GID_U45_IN18] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U45_IN18,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                reagents[0],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Sulfurous Ash:"),
                    LAYOUT_AddChild,                   gadgets[GID_U45_IN19] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U45_IN19,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                reagents[1],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Ginseng:"),
                    LAYOUT_AddChild,                   gadgets[GID_U45_IN20] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U45_IN20,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                reagents[2],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Garlic:"),
                    LAYOUT_AddChild,                   gadgets[GID_U45_IN21] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U45_IN21,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                reagents[3],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Spider Silk:"),
                    LAYOUT_AddChild,                   gadgets[GID_U45_IN22] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U45_IN22,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                reagents[4],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Blood Moss:"),
                    LAYOUT_AddChild,                   gadgets[GID_U45_IN23] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U45_IN23,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                reagents[5],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Black Pearl:"),
                    LAYOUT_AddChild,                   gadgets[GID_U45_IN24] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U45_IN24,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                reagents[6],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Nightshade:"),
                    LAYOUT_AddChild,                   gadgets[GID_U45_IN25] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_U45_IN25,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               99,
                        INTEGER_Number,                reagents[7],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("Mandrake Root:"),
                LayoutEnd,
                AddHLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Scrolls",
                    AddVLayout,
                        LAYOUT_AddChild,               gadgets[GID_U5_IN26] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN26,
                            GA_TabCycle,               TRUE,
                            GA_Disabled,               (game == ULTIMA5) ? FALSE : TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            scrolls[0],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Great Light (VL):"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN27] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN27,
                            GA_TabCycle,               TRUE,
                            GA_Disabled,               (game == ULTIMA5) ? FALSE : TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            scrolls[1],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Wind Change (RH):"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN28] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN28,
                            GA_TabCycle,               TRUE,
                            GA_Disabled,               (game == ULTIMA5) ? FALSE : TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            scrolls[2],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Protection (IS):"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN29] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN29,
                            GA_TabCycle,               TRUE,
                            GA_Disabled,               (game == ULTIMA5) ? FALSE : TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            scrolls[3],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Negate Magic (IA):"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN30] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN30,
                            GA_TabCycle,               TRUE,
                            GA_Disabled,               (game == ULTIMA5) ? FALSE : TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            scrolls[4],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Peer (IQW):"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN31] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN31,
                            GA_TabCycle,               TRUE,
                            GA_Disabled,               (game == ULTIMA5) ? FALSE : TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            scrolls[5],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Summon (KXC):"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN32] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN32,
                            GA_TabCycle,               TRUE,
                            GA_Disabled,               (game == ULTIMA5) ? FALSE : TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            scrolls[6],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Resurrect (IMC):"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN33] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN33,
                            GA_TabCycle,               TRUE,
                            GA_Disabled,               (game == ULTIMA5) ? FALSE : TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            scrolls[7],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Time Stop (AT):"),
                    LayoutEnd,
                LayoutEnd,
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

    submode = 3;
    subloop();

    for (i = 0; i < 8; i++)
    {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_U45_IN18 + i], (ULONG*) &reagents[i]);
        GetAttr(INTEGER_Number, (Object*) gadgets[GID_U5_IN26  + i], (ULONG*) &scrolls[ i]);
        GetAttr(INTEGER_Number, (Object*) gadgets[GID_U5_IN34  + i], (ULONG*) &potions[ i]);
        GetAttr(INTEGER_Number, (Object*) gadgets[GID_U4_IN26  + i], (ULONG*) &u4_karma[i]);
        GetAttr(GA_Selected,    (Object*) gadgets[GID_U4_CB1   + i], (ULONG*) &rune[    i]);
        GetAttr(GA_Selected,    (Object*) gadgets[GID_U4_CB9   + i], (ULONG*) &stone[   i]);
    }
    GetAttr(    INTEGER_Number, (Object*) gadgets[GID_U5_IN_KARMA    ], (ULONG*) &u5_karma);
    GetAttr(    INTEGER_Number, (Object*) gadgets[GID_U45_IN_FOOD    ], (ULONG*) &food);
    GetAttr(    INTEGER_Number, (Object*) gadgets[GID_U45_IN_GP      ], (ULONG*) &gp);
    GetAttr(    INTEGER_Number, (Object*) gadgets[GID_U45_IN_GEMS    ], (ULONG*) &gems);
    GetAttr(    INTEGER_Number, (Object*) gadgets[GID_U45_IN_KEYS    ], (ULONG*) &keys);
    GetAttr(    INTEGER_Number, (Object*) gadgets[GID_U45_IN_SEXTANTS], (ULONG*) &sextants);
    GetAttr(    INTEGER_Number, (Object*) gadgets[GID_U45_IN_TORCHES ], (ULONG*) &torches);

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE int yes(STRPTR abbrevs, int value)
{   int i;

    for (i = 0; i < (int) strlen(abbrevs); i++)
    {   if (abbrevs[i] == value)
        {   return i;
    }   }

    return 0; // error! (should never happen)
}

EXPORT FLAG ultima_subkey(UWORD code, UWORD qual)
{   int portraitx,
        portraity,
        oldportrait;

    if (submode == 4)
    {   /* They are arranged like this onscreen:
        6 7 8 9 10 11
        0 1 2 3  4  5 */

        oldportrait = portrait;
        portraitx   = (portrait >= 6) ? (portrait - 6) : portrait;
        portraity   = (portrait >= 6) ?             0  :        1;
    } else
    {   oldportrait =
        portraitx   =
        portraity   = 0; // otherwise the fucking compiler complains
    }

    switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        if (submode == 2)
        {   // assert(SubWindowPtr);
            lb_move_up(GID_U5_LB1, SubWindowPtr, qual, &location, 0, 5);
        } elif (submode == 4)
        {   if (portraity > 0)
            {   portraity--;
        }   }
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        if (submode == 2)
        {   // assert(SubWindowPtr);
            lb_move_down(GID_U5_LB1, SubWindowPtr, qual, &location, 40, 5);
        } elif (submode == 4)
        {   if (portraity < 1)
            {   portraity++;
        }   }
    acase SCAN_LEFT:
        if (submode == 4 && portraitx > 0)
        {   portraitx--;
        }
    acase SCAN_RIGHT:
        if (submode == 4 && portraitx < 5)
        {   portraitx++;
    }   }

    if (submode == 4)
    {   portrait = portraitx;
        if (portraity == 0)
        {   portrait += 6;
        }
        if (oldportrait != (int) portrait) // just to avoid needless refreshes
        {   update_portrait();
    }   }

    return FALSE;
}

MODULE void update_portrait(void)
{   int i;

    for (i = 0; i < 12; i++)
    {   SetGadgetAttrs(gadgets[GID_U6_BU3 + i], SubWindowPtr, NULL, GA_Selected, portrait == (ULONG) i ? TRUE : FALSE, TAG_END); // this autorefreshes
    }

    if (sex == MALE && portrait <= 5)
    {   sex = FEMALE;
        SetGadgetAttrs(gadgets[GID_U6_CH1], SubWindowPtr, NULL, CHOOSER_Selected, (WORD) sex, TAG_END); // we must explicitly refresh
        RefreshGadgets((struct Gadget*) gadgets[GID_U6_CH1], SubWindowPtr, NULL);
    } elif (sex == FEMALE && portrait >= 6)
    {   sex = MALE;
        SetGadgetAttrs(gadgets[GID_U6_CH1], SubWindowPtr, NULL, CHOOSER_Selected, (WORD) sex, TAG_END); // we must explicitly refresh
        RefreshGadgets((struct Gadget*) gadgets[GID_U6_CH1], SubWindowPtr, NULL);
}   }

EXPORT FLAG ultima_subgadget(ULONG gid, UWORD code)
{   ULONG seconds;

    switch (gid)
    {
    case GID_U5_IN_X:
    case GID_U5_IN_Y:
        do_coords();
#ifndef __MORPHOS__
    acase GID_U5_CL1:
        // assert(ClockBase);
        DISCARD GetAttr(CLOCKGA_Time, (Object*) gadgets[GID_U5_CL1], (ULONG*) &seconds);
        seconds %= 86400               ; // seconds in day
        hour    =  seconds / 3600      ; // seconds in hour
        minute  = (seconds % 3600) / 60; // seconds in minute
        DISCARD SetGadgetAttrs(gadgets[GID_U5_IN_HOUR  ], SubWindowPtr, NULL, INTEGER_Number, hour,   TAG_END); // autorefreshes
        DISCARD SetGadgetAttrs(gadgets[GID_U5_IN_MINUTE], SubWindowPtr, NULL, INTEGER_Number, minute, TAG_END); // autorefreshes
#endif
    acase GID_U5_IN_HOUR:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U5_IN_HOUR], (ULONG*) &hour);
#ifndef __MORPHOS__
        if (ClockBase)
        {   DISCARD SetGadgetAttrs(gadgets[GID_U5_CL1], SubWindowPtr, NULL, CLOCKGA_Time, ((hour * 60) + minute) * 60, TAG_END); // autorefreshes
        }
#endif
    acase GID_U5_IN_MINUTE:
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_U5_IN_MINUTE], (ULONG*) &minute);
#ifndef __MORPHOS__
        if (ClockBase)
        {   DISCARD SetGadgetAttrs(gadgets[GID_U5_CL1], SubWindowPtr, NULL, CLOCKGA_Time, ((hour * 60) + minute) * 60, TAG_END); // autorefreshes
        }
#endif
    acase GID_U6_CH1:
        sex = code;
    adefault:
        if (gid >= GID_U6_BU1 && gid <= GID_U6_BU12)
        {   portrait = gid - GID_U6_BU1;
    }   }

    return FALSE;
}

EXPORT void ultima_uniconify(void) { ; }

MODULE void itemwindow(void)
{   int i;

    // assert(game == ULTIMA4 || game == ULTIMA5);

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    switch (game)
    {
    case ULTIMA4:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                                  "Choose Items (U4)",
            WINDOW_Position,                           WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                           "ultima-2",
            WINDOW_ParentGroup,                        gadgets[GID_U45_LY_ITEMS] = (struct Gadget*)
            HLayoutObject,
                LAYOUT_SpaceOuter,                     TRUE,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Armour",
                        AddU4Armour(0, "Cloths:"),
                        AddU4Armour(1, "Leathers:"),
                        AddU4Armour(2, "Chain Mails:"),
                        AddU4Armour(3, "Plate Mails:"),
                        AddU4Armour(4, "Magic Chains:"),
                        AddU4Armour(5, "Magic Plates:"),
                        AddU4Armour(6, "Mystic Robes:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Quest Items",
                        LAYOUT_AddChild,               gadgets[GID_U45_CB25] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U45_CB25,
                            GA_Selected,               u4_item[0],
                            GA_Text,                   "Truth Key",
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U45_CB28] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U45_CB28,
                            GA_Selected,               u4_item[1],
                            GA_Text,                   "Book of Truth",
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U45_CB26] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U45_CB26,
                            GA_Selected,               u4_item[2],
                            GA_Text,                   "Love Key",
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U45_CB29] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U45_CB29,
                            GA_Selected,               u4_item[3],
                            GA_Text,                   "Candle of Love",
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U45_CB27] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U45_CB27,
                            GA_Selected,               u4_item[4],
                            GA_Text,                   "Courage Key",
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U45_CB30] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U45_CB30,
                            GA_Selected,               u4_item[5],
                            GA_Text,                   "Bell of Courage",
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U45_CB31] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U45_CB31,
                            GA_Selected,               u4_item[6],
                            GA_Text,                   "Horn",
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U45_CB32] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U45_CB32,
                            GA_Selected,               u4_item[7],
                            GA_Text,                   "Wheel",
                        End,
                        LAYOUT_AddChild,               gadgets[GID_U45_CB33] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                     GID_U45_CB33,
                            GA_Selected,               u4_item[8],
                            GA_Text,                   "Skull",
                        End,
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Weapons",
                        AddU4Weapon( 0, "Staves:"),
                        AddU4Weapon( 1, "Daggers:"),
                        AddU4Weapon( 2, "Slings:"),
                        AddU4Weapon( 3, "Maces:"),
                        AddU4Weapon( 4, "Axes:"),
                        AddU4Weapon( 5, "Swords:"),
                        AddU4Weapon( 6, "Bows:"),
                        AddU4Weapon( 7, "Crossbows:"),
                        AddU4Weapon( 8, "Flaming Oils:"),
                        AddU4Weapon( 9, "Halberds:"),
                        AddU4Weapon(10, "Magic Axes:"),
                        AddU4Weapon(11, "Magic Swords:"),
                        AddU4Weapon(12, "Magic Bows:"),
                        AddU4Weapon(13, "Magic Wands:"),
                        AddU4Weapon(14, "Mystic Swords:"),
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase ULTIMA5:
        load_fimage(FUNC_ULTIMA);
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                                  "Choose Items (U5)",
            WA_SizeGadget,                             TRUE,
            WA_ThinSizeGadget,                         TRUE,
            WINDOW_Position,                           WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                           "ultima-3",
            WINDOW_ParentGroup,                        gadgets[GID_U45_LY_ITEMS] = (struct Gadget*)
            HLayoutObject,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_DeferLayout,                    TRUE,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Helms",
                        LAYOUT_AddChild,               gadgets[GID_U5_IN93] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN93,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            helms[0],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Leather Helms:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN94] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN94,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            helms[1],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Chain Coifs:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN95] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN95,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            helms[2],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Iron Helms:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN96] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN96,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            helms[3],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Spiked Helms:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Shields",
                        LAYOUT_AddChild,               gadgets[GID_U5_IN55] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN55,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            shields[0],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Small Shields:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN56] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN56,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            shields[1],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Large Shields:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN57] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN57,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            shields[2],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Spiked Shields:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN58] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN58,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            shields[3],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Magic Shields:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN59] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN59,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            shields[4],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Jewelled Shields:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Armour",
                        AddU5Armour(0, "Cloths:"),
                        AddU5Armour(1, "Leathers:"),
                        AddU5Armour(2, "Ring Mails:"),
                        AddU5Armour(3, "Scale Mails:"),
                        AddU5Armour(4, "Chain Mails:"),
                        AddU5Armour(5, "Plate Mails:"),
                        AddU5Armour(6, "Mystic Armours:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Rings",
                        LAYOUT_AddChild,               gadgets[GID_U5_IN49] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN49,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            rings[0],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Invisibility:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN50] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN50,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            rings[1],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Regeneration:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN51] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN51,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            rings[2],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Protection:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,             BVS_GROUP,
                        LAYOUT_SpaceOuter,             TRUE,
                        LAYOUT_Label,                  "Amulets",
                        LAYOUT_AddChild,               gadgets[GID_U5_IN52] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN52,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            amulets[0],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Amulets of Turning:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN53] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN53,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            amulets[1],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Spiked Collars:"),
                        LAYOUT_AddChild,               gadgets[GID_U5_IN54] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                     GID_U5_IN54,
                            GA_TabCycle,               TRUE,
                            INTEGER_Minimum,           0,
                            INTEGER_Maximum,           99,
                            INTEGER_Number,            amulets[2],
                            INTEGER_MinVisible,        2 + 1,
                        IntegerEnd,
                        Label("Ankhs:"),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                 BVS_GROUP,
                    LAYOUT_SpaceOuter,                 TRUE,
                    LAYOUT_Label,                      "Weapons",
                    AddU5Weapon( 0, "Daggers:"),
                    AddU5Weapon( 1, "Slings:"),
                    AddU5Weapon( 2, "Clubs:"),
                    AddU5Weapon( 3, "Flaming Oils:"),
                    AddU5Weapon( 4, "Main Gauches:"),
                    AddU5Weapon( 5, "Spears:"),
                    AddU5Weapon( 6, "Throwing Axes:"),
                    AddU5Weapon( 7, "Short Swords:"),
                    AddU5Weapon( 8, "Maces:"),
                    AddU5Weapon( 9, "Morning Stars:"),
                    AddU5Weapon(10, "Bows:"),
                    AddU5Weapon(11, "Arrows:"),
                    AddU5Weapon(12, "Crossbows:"),
                    AddU5Weapon(13, "Quarrels:"),
                    AddU5Weapon(14, "Long Swords:"),
                    AddU5Weapon(15, "2-Handed Hammers:"),
                    AddU5Weapon(16, "2-Handed Axes:"),
                    AddU5Weapon(17, "2-Handed Swords:"),
                    AddU5Weapon(18, "Halberds:"),
                    AddU5Weapon(19, "Chaos Swords:"),
                    AddU5Weapon(20, "Magic Bows:"),
                    AddU5Weapon(21, "Silver Swords:"),
                    AddU5Weapon(22, "Magic Axes:"),
                    AddU5Weapon(23, "Glass Swords:"),
                    AddU5Weapon(24, "Jewelled Swords:"),
                    AddU5Weapon(25, "Mystic Swords:"),
                LayoutEnd,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "Quest Items",
                        LAYOUT_AddChild,                   gadgets[GID_U5_IN16] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_U5_IN16,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                carpets,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Magic Carpets:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U5_IN17] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_U5_IN17,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               99,
                            INTEGER_Number,                skullkeys,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Skull Keys:"),
                        CHILD_WeightedHeight,              0,
                        AddLabel(""),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U45_CB25] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U45_CB25,
                            GA_Selected,                   u5_item[0],
                            GA_Text,                       "Grapple",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U45_CB26] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U45_CB26,
                            GA_Selected,                   u5_item[1],
                            GA_Text,                       "Spyglasses",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U45_CB27] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U45_CB27,
                            GA_Selected,                   u5_item[2],
                            GA_Text,                       "HMS Cape Plans",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U45_CB28] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U45_CB28,
                            GA_Selected,                   u5_item[3],
                            GA_Text,                       "Pocket Watch",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U45_CB29] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U45_CB29,
                            GA_Selected,                   u5_item[4],
                            GA_Text,                       "Black Badge",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U45_CB30] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U45_CB30,
                            GA_Selected,                   u5_item[5],
                            GA_Text,                       "Sandalwood Box",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U45_CB31] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U45_CB31,
                            GA_Selected,                   u5_item[6],
                            GA_Text,                       "Amulet of Lord British",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U45_CB32] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U45_CB32,
                            GA_Selected,                   u5_item[7],
                            GA_Text,                       "Crown of Lord British",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U45_CB33] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U45_CB33,
                            GA_Selected,                   u5_item[8],
                            GA_Text,                       "Sceptre of Lord British",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U5_CB34] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U5_CB34,
                            GA_Selected,                   u5_item[9],
                            GA_Text,                       "Shard of Falsehood",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U5_CB35] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U5_CB35,
                            GA_Selected,                   u5_item[10],
                            GA_Text,                       "Shard of Hatred",
                        End,
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_U5_CB36] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_U5_CB36,
                            GA_Selected,                   u5_item[11],
                            GA_Text,                       "Shard of Cowardice",
                        End,
                        CHILD_WeightedHeight,              0,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                    AddHLayout,
                        AddSpace,
                        AddFImage(FUNC_ULTIMA),
                        CHILD_WeightedWidth,               0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                LayoutEnd,
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

    DISCARD ActivateLayoutGadget(gadgets[GID_U45_LY_ITEMS], SubWindowPtr, NULL, (Object) gadgets[GID_U45_IN60]);

    submode = 0;
    subloop();

    switch (game)
    {
    case ULTIMA4:
        GetAttr(GA_Selected,        (Object*) gadgets[GID_U45_CB25    ], (ULONG*) &u4_item[0]);
        GetAttr(GA_Selected,        (Object*) gadgets[GID_U45_CB26    ], (ULONG*) &u4_item[2]);
        GetAttr(GA_Selected,        (Object*) gadgets[GID_U45_CB27    ], (ULONG*) &u4_item[4]);
        GetAttr(GA_Selected,        (Object*) gadgets[GID_U45_CB28    ], (ULONG*) &u4_item[1]);
        GetAttr(GA_Selected,        (Object*) gadgets[GID_U45_CB29    ], (ULONG*) &u4_item[3]);
        GetAttr(GA_Selected,        (Object*) gadgets[GID_U45_CB30    ], (ULONG*) &u4_item[5]);
        GetAttr(GA_Selected,        (Object*) gadgets[GID_U45_CB31    ], (ULONG*) &u4_item[6]);
        GetAttr(GA_Selected,        (Object*) gadgets[GID_U45_CB32    ], (ULONG*) &u4_item[7]);
        GetAttr(GA_Selected,        (Object*) gadgets[GID_U45_CB33    ], (ULONG*) &u4_item[8]);

        for (i = 1; i < 8; i++)
        {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_U45_IN60 + i - 1], (ULONG*) &armour[i]);
        }
        for (i = 1; i < 16; i++)
        {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_U45_IN67 + i - 1], (ULONG*) &weapons[i]);
        }
    acase ULTIMA5:
        GetAttr(INTEGER_Number,     (Object*) gadgets[GID_U5_IN16     ], (ULONG*) &carpets);
        GetAttr(INTEGER_Number,     (Object*) gadgets[GID_U5_IN17     ], (ULONG*) &skullkeys);
        for (i = 0; i < 12; i++)
        {   GetAttr(GA_Selected,    (Object*) gadgets[GID_U45_CB25 + i], (ULONG*) &u5_item[i]);
        }
        for (i = 0; i < 4; i++)
        {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_U5_IN93  + i], (ULONG*) &helms[i]);
        }
        for (i = 0; i < 5; i++)
        {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_U5_IN55  + i], (ULONG*) &shields[i]);
        }
        for (i = 0; i < 26; i++)
        {   GetAttr(INTEGER_Number, (Object*) gadgets[GID_U45_IN67 + i], (ULONG*) &weapons[i]);
    }   }

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE void spellwindow(void)
{   int i;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    switch (game)
    {
    case ULTIMA4:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                                      "Spells (U4)",
            WA_SizeGadget,                                 TRUE,
            WA_ThinSizeGadget,                             TRUE,
            WINDOW_Position,                               WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                               "ultima-4",
            WINDOW_ParentGroup,                            gadgets[GID_U45_LY_SPELLS] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                         TRUE,
                AddSpell( 0, "Awaken:"),
                AddSpell( 1, "Blink:"),
                AddSpell( 2, "Cure:"),
                AddSpell( 3, "Dispel:"),
                AddSpell( 4, "Energy Field:"),
                AddSpell( 5, "Fireball:"),
                AddSpell( 6, "Gate Travel:"),
                AddSpell( 7, "Heal:"),
                AddSpell( 8, "Iceball:"),
                AddSpell( 9, "Jinx:"),
                AddSpell(10, "Kill:"),
                AddSpell(11, "Light:"),
                AddSpell(12, "Magic Missile:"),
                AddSpell(13, "Negate:"),
                AddSpell(14, "Open:"),
                AddSpell(15, "Protection:"),
                AddSpell(16, "Quickness:"),
                AddSpell(17, "Resurrect:"),
                AddSpell(18, "Sleep:"),
                AddSpell(19, "Tremor:"),
                AddSpell(20, "Undead:"),
                AddSpell(21, "View:"),
                AddSpell(22, "Wind Change:"),
                AddSpell(23, "Exit:"),
                AddSpell(24, "Up:"),
                AddSpell(25, "Down:"),
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase ULTIMA5:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                                      "Spells (U5)",
            WA_SizeGadget,                                 TRUE,
            WA_ThinSizeGadget,                             TRUE,
            WINDOW_Position,                               WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                               "ultima-5",
            WINDOW_ParentGroup,                            gadgets[GID_U45_LY_SPELLS] = (struct Gadget*)
            HLayoutObject,
                LAYOUT_SpaceOuter,                         TRUE,
                AddVLayout,
                    AddSpell( 0, "Light (IL):"),
                    AddSpell( 1, "Magic Missile (GP):"),
                    AddSpell( 2, "Awaken (AZ):"),
                    AddSpell( 3, "Cure Poison (AN):"),
                    AddSpell( 4, "Heal (M):"),
                    AddSpell( 5, "Vanish (AY):"),
                    AddSpell( 6, "Unlock (AS):"),
                    AddSpell( 7, "Repel Undead (AXC):"),
                    AddSpell( 8, "Wind Change (RH):"),
                    AddSpell( 9, "Locate (IW):"),
                    AddSpell(10, "Call Animal (KX):"),
                    AddSpell(11, "Create Food (IXM):"),
                    AddSpell(12, "Great Light (VL):"),
                    AddSpell(13, "Ball of Flames (VF):"),
                    AddSpell(14, "Wall of Fire (IFG):"),
                    AddSpell(15, "Wall of Poison (ING):"),
                    AddSpell(16, "Wall of Sleep (IZG):"),
                    AddSpell(17, "Blink (IP):"),
                    AddSpell(18, "Dispell Field (AG):"),
                    AddSpell(19, "Protection (IS):"),
                    AddSpell(20, "Protection Field (ISG):"),
                    AddSpell(21, "Upward Move (UP):"),
                    AddSpell(22, "Downward Move (DP):"),
                    AddSpell(23, "Reveal (WQ):"),
                    AddSpell(24, "Insect Swarm (IBX):"),
                LayoutEnd,
                AddVLayout,
                    AddSpell(25, "Magic Lock (AEP):"),
                    AddSpell(26, "Magic Unlock (IEP):"),
                    AddSpell(27, "Great Heal (VM):"),
                    AddSpell(28, "Sleep (IZ):"),
                    AddSpell(29, "Quickness (RT):"),
                    AddSpell(30, "Tremor (IVPY):"),
                    AddSpell(31, "Confuse (QAW):"),
                    AddSpell(32, "Negate Magic (IA):"),
                    AddSpell(33, "X-Ray (WAY):"),
                    AddSpell(34, "Charm (AXE):"),
                    AddSpell(35, "Change to Animal (RXB):"),
                    AddSpell(36, "Invisibility (SL):"),
                    AddSpell(37, "Kill (XC):"),
                    AddSpell(38, "Clone (IQX):"),
                    AddSpell(39, "Peer (IQW):"),
                    AddSpell(40, "Poison Wind (INH):"),
                    AddSpell(41, "Fear (IQC):"),
                    AddSpell(42, "Resurrect (IMC):"),
                    AddSpell(43, "Summon (KXC):"),
                    AddSpell(44, "Cone of Energy (IVGC):"),
                    AddSpell(45, "Flame Wind (IFH):"),
                    AddSpell(46, "Gate Travel (VRP):"),
                    AddSpell(47, "Time Stop (AT):"),
                LayoutEnd,
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

    submode = 1;
    subloop();

    for (i = 0; i < 48; i++)
    {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_U45_IN100 + i], (ULONG*) &mixtures[i]);
    }

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE void do_coords(void)
{   PERSIST TEXT coords[10 + 1];

    DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_U5_IN_X], (ULONG*) &loc_x);
    DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_U5_IN_Y], (ULONG*) &loc_y);
    sprintf
    (   coords,
        "%c'%c\", %c'%c\"",
        (int) ('A' + (loc_y / 16)),
        (int) ('A' + (loc_y % 16)),
        (int) ('A' + (loc_x / 16)),
        (int) ('A' + (loc_x % 16))
    );
    DISCARD SetGadgetAttrs
    (   gadgets[GID_U5_ST1], SubWindowPtr, NULL,
        STRINGA_TextVal, coords,
    TAG_END);
}

MODULE void whenandwhere(void)
{   // assert(game == ULTIMA5);

    make_clock(GID_U5_CL1);
#ifndef __MORPHOS__
    if (ClockBase)
    {   gadgets[GID_U5_LY_CLOCK] = (struct Gadget*)
        HLayoutObject,
            AddSpace,
            LAYOUT_AddChild,       gadgets[GID_U5_CL1],
            CHILD_MinWidth,        64,
            CHILD_MinHeight,       64,
            CHILD_WeightedWidth,    0,
            AddSpace,
        LayoutEnd;
    }
#endif

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                                      "When & Where",
        WA_SizeGadget,                                 TRUE,
        WA_ThinSizeGadget,                             TRUE,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                               "ultima-6",
        WINDOW_ParentGroup,                            gadgets[GID_U5_LY_WHEN] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            AddHLayout,
                LAYOUT_VertAlignment,                  LALIGN_CENTER,
                LAYOUT_AddChild,                       gadgets[GID_U5_IN_HOUR] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U5_IN_HOUR,
                    GA_TabCycle,                       TRUE,
                    GA_RelVerify,                      TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   23,
                    INTEGER_Number,                    hour,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Time:"),
                AddLabel(":"),
                CHILD_WeightedWidth,                   0,
                LAYOUT_AddChild,                       gadgets[GID_U5_IN_MINUTE] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U5_IN_MINUTE,
                    GA_TabCycle,                       TRUE,
                    GA_RelVerify,                      TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   59,
                    INTEGER_Number,                    minute,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                AddLabel(" "),
                CHILD_WeightedWidth,                   0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
            AddHLayout,
                LAYOUT_VertAlignment,                  LALIGN_CENTER,
                LAYOUT_AddChild,                       gadgets[GID_U5_IN_DAY] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U5_IN_DAY,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   31,
                    INTEGER_Number,                    day,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                Label("Date:"),
                AddLabel("/"),
                CHILD_WeightedWidth,                   0,
                LAYOUT_AddChild,                       gadgets[GID_U5_IN_MONTH] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U5_IN_MONTH,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   1,
                    INTEGER_Maximum,                   12,
                    INTEGER_Number,                    month,
                    INTEGER_MinVisible,                2 + 1,
                IntegerEnd,
                AddLabel("/"),
                CHILD_WeightedWidth,                   0,
                LAYOUT_AddChild,                       gadgets[GID_U5_IN_YEAR] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U5_IN_YEAR,
                    GA_TabCycle,                       TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   999,
                    INTEGER_Number,                    year,
                    INTEGER_MinVisible,                3 + 1,
                IntegerEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
#ifndef __MORPHOS__
            ClockBase ? LAYOUT_AddChild      : TAG_IGNORE, gadgets[GID_U5_LY_CLOCK],
            ClockBase ? CHILD_WeightedHeight : TAG_IGNORE, 0,
#endif
            AddLabel(""),
            CHILD_WeightedHeight,                      0,
            AddVLayout,
                LAYOUT_Label,                          "Location",
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_BevelStyle,                     BVS_SBAR_VERT,
                LAYOUT_AddChild,                       gadgets[GID_U5_LB1] = (struct Gadget*)
                ListBrowserObject,
                    GA_ID,                             GID_U5_LB1,
                    GA_RelVerify,                      TRUE,
                    LISTBROWSER_Labels,                (ULONG) &LocationsList,
                    LISTBROWSER_ShowSelected,          TRUE,
                    LISTBROWSER_Selected,              location,
                    LISTBROWSER_AutoWheel,             FALSE,
                ListBrowserEnd,
                CHILD_MinWidth,                        192,
                CHILD_MinHeight,                       256,
            LayoutEnd,
            LAYOUT_AddChild,                           gadgets[GID_U5_CH_FLOOR] = (struct Gadget*)
            PopUpObject,
                GA_ID,                                 GID_U5_CH_FLOOR,
                CHOOSER_LabelArray,                    &FloorOptions,
                CHOOSER_Selected,                      (WORD) floor,
            PopUpEnd,
            Label("Floor:"),
            CHILD_WeightedHeight,                      0,
            AddHLayout,
                LAYOUT_VertAlignment,                  LALIGN_CENTER,
                LAYOUT_AddChild,                       gadgets[GID_U5_IN_X] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U5_IN_X,
                    GA_TabCycle,                       TRUE,
                    GA_RelVerify,                      TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   255,
                    INTEGER_Number,                    loc_x,
                    INTEGER_MinVisible,                3 + 1,
                IntegerEnd,
                Label("X:"),
                CHILD_WeightedWidth,                   0,
                LAYOUT_AddChild,                       gadgets[GID_U5_IN_Y] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_U5_IN_Y,
                    GA_TabCycle,                       TRUE,
                    GA_RelVerify,                      TRUE,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   255,
                    INTEGER_Number,                    loc_y,
                    INTEGER_MinVisible,                3 + 1,
                IntegerEnd,
                Label("Y:"),
                CHILD_WeightedWidth,                   0,
                LAYOUT_AddChild,                       gadgets[GID_U5_ST1] = (struct Gadget*)
                StringObject,
                    GA_ID,                             GID_U5_ST1,
                    GA_ReadOnly,                       TRUE,
                    STRINGA_TextVal,                   "",
                    STRINGA_MinVisible,                10 + stringextra,
                StringEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
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

#ifndef __MORPHOS__
    if (ClockBase)
    {   SetGadgetAttrs(gadgets[GID_U5_CL1], SubWindowPtr, NULL, CLOCKGA_Time, ((hour * 60) + minute) * 60, TAG_END); // autorefreshes
    }
#endif
    SetGadgetAttrs(gadgets[GID_U5_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, location, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_U5_LB1], SubWindowPtr, NULL);
    do_coords();

    submode = 2;
    subloop();

    GetAttr(INTEGER_Number,       (Object*) gadgets[GID_U5_IN_HOUR  ], (ULONG*) &hour);
    GetAttr(INTEGER_Number,       (Object*) gadgets[GID_U5_IN_MINUTE], (ULONG*) &minute);
    GetAttr(INTEGER_Number,       (Object*) gadgets[GID_U5_IN_DAY   ], (ULONG*) &day);
    GetAttr(INTEGER_Number,       (Object*) gadgets[GID_U5_IN_MONTH ], (ULONG*) &month);
    GetAttr(INTEGER_Number,       (Object*) gadgets[GID_U5_IN_YEAR  ], (ULONG*) &year);
    GetAttr(CHOOSER_Selected,     (Object*) gadgets[GID_U5_CH_FLOOR ], (ULONG*) &floor);
    GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_U5_LB1      ], (ULONG*) &location);

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE void avatarwindow(void)
{   int i;

    // assert(game == ULTIMA6);

    load_images(135, 146);

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                                          "Avatar",
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                                   "ultima-7",
        WINDOW_ParentGroup,                                gadgets[GID_U6_LY_AVATAR] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_VertAlignment,                          LALIGN_CENTER,
            LAYOUT_AddChild,                               gadgets[GID_U6_CH1] = (struct Gadget*)
            PopUpObject,
                GA_ID,                                     GID_U6_CH1,
                GA_RelVerify,                              TRUE,
                CHOOSER_LabelArray,                        &U456SexOptions,
                CHOOSER_Selected,                          (WORD) sex,
            PopUpEnd,
            Label("Sex:"),
            AddLabel(""),
            CHILD_WeightedHeight,                          0,
            LAYOUT_AddChild,
            VLayoutObject,
                LAYOUT_BevelStyle,                         BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Portrait",
                AddHLayout,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU7] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU7,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[141],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU8] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU8,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[142],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU9] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU9,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[143],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU10] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU10,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[144],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU11] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU11,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[145],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU12] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU12,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[146],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU1] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU1,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[135],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU2] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU2,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[136],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU3] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU3,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[137],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU4] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU4,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[138],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU5] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU5,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[139],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                    LAYOUT_AddChild,                       gadgets[GID_U6_BU6] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_U6_BU6,
                        GA_RelVerify,                      TRUE,
                        GA_Image,                          image[140],
                        BUTTON_PushButton,                 TRUE,
                    ButtonEnd,
                LayoutEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
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

    for (i = 0; i < 12; i++)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_U6_BU3 + i], SubWindowPtr, NULL,
            GA_Selected, portrait == (ULONG) i ? TRUE : FALSE,
        TAG_END); // this autorefreshes
    }

    submode = 4;
    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE void load_chooser_images(void)
{   TRANSIENT       int           i;
    TRANSIENT struct ChooserNode* ChooserNodePtr;
    PERSIST   const int           u3classimages[11] =
    { U3_IMAGE_WIZARD,  // Alchemist   //  0
      U3_IMAGE_FIGHTER, // Barbarian   //  1
      U3_IMAGE_CLERIC,  // Cleric      //  2
      U3_IMAGE_CLERIC,  // Druid       //  3
      U3_IMAGE_FIGHTER, // Fighter     //  4
      U3_IMAGE_WIZARD,  // Illusionist //  5
      U3_IMAGE_LARK,    // Lark        //  6
      U3_IMAGE_FIGHTER, // Paladin     //  7
      U3_IMAGE_RANGER,  // Ranger"     //  8
      U3_IMAGE_THIEF,   // Thief       //  9
      U3_IMAGE_WIZARD   // Wizard"     // 10
    };

    switch (game)
    {
    case ULTIMA3:
        load_images(46, 51);
        for (i = 0; i < 11; i++)
        {   if (!(ChooserNodePtr = (struct ChooserNode*) AllocChooserNode
            (   CNA_Text,  U3ClassOptions[i],
                CNA_Image, image[u3classimages[i]],
            TAG_DONE)))
            {   rq("Can't create chooser.gadget node(s)!");
            }
            AddTail(&ClassesList, (struct Node*) ChooserNodePtr); /* AddTail() has no return code */
        }
    acase ULTIMA4:
        ch_load_images(  7,  14, U4ClassOptions, &ClassesList);
    acase ULTIMA5:
        ch_load_images( 52,  55, U5ClassOptions, &ClassesList);
    acase ULTIMA6:
        ch_load_images(103, 103, U6ClassOptions, &ClassesList);
}   }

MODULE void change_game(void)
{   int i;

    SetGadgetAttrs(gadgets[GID_U_IN_MEN     ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA5) ? FALSE : TRUE, INTEGER_Maximum, (game == ULTIMA5) ? 8 : 20, TAG_END);
    SetGadgetAttrs(gadgets[GID_U3_IN_FOOD   ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U3_IN_GP     ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U3_IN_GEMS   ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U3_IN_KEYS   ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U3_IN_POWDERS], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U3_IN_TORCHES], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U3_IN_WIS    ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U3_CH_RACE   ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U345_CH_CLASS], MainWindowPtr, NULL, GA_Disabled, (game != ULTIMA6) ? FALSE : TRUE, TAG_END);
    for (i = GID_U3_IN60; i <= GID_U3_IN81; i++)
    {   SetGadgetAttrs(gadgets[i],             MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
    }
    for (i = GID_U3_CB17; i <= GID_U3_CB24; i++)
    {   SetGadgetAttrs(gadgets[i],             MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA3) ? FALSE : TRUE, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[i], MainWindowPtr, NULL);
    }
    for (i = GID_U4_CB17; i <= GID_U4_CB24; i++)
    {   SetGadgetAttrs(gadgets[i],             MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA4) ? FALSE : TRUE, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[i], MainWindowPtr, NULL);
    }
    SetGadgetAttrs(gadgets[GID_U45_BU_MORE  ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA4 || game == ULTIMA5) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U45_BU_ITEMS ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA4 || game == ULTIMA5) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U45_BU_SPELLS], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA4 || game == ULTIMA5) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U5_BU_WHEN   ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA5) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U6_BU_AVATAR ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA6) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U56_IN_LEVEL ], MainWindowPtr, NULL, GA_Disabled, (game == ULTIMA5 || game == ULTIMA6) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U_IN_MAXHP   ], MainWindowPtr, NULL, GA_Disabled, (game != ULTIMA6) ? FALSE : TRUE, TAG_END);
    SetGadgetAttrs(gadgets[GID_U_IN_CURHP   ], MainWindowPtr, NULL, INTEGER_Minimum,  (game == ULTIMA6) ?     1 :    0, INTEGER_Maximum, (game == ULTIMA6) ? 255 : 9999, TAG_END);
    SetGadgetAttrs(gadgets[GID_U_IN8        ], MainWindowPtr, NULL, INTEGER_Maximum,  (game == ULTIMA6) ? 32767 : 9999, TAG_END);
    SetGadgetAttrs(gadgets[GID_U_IN10       ], MainWindowPtr, NULL, INTEGER_Maximum,  (game == ULTIMA6) ?   255 :   99, TAG_END);
    SetGadgetAttrs(gadgets[GID_U_IN11       ], MainWindowPtr, NULL, INTEGER_Maximum,  (game == ULTIMA6) ?   123 :   99, TAG_END);
    SetGadgetAttrs(gadgets[GID_U_IN12       ], MainWindowPtr, NULL, INTEGER_Maximum,  (game == ULTIMA6) ?   123 :   99, TAG_END);
    SetGadgetAttrs(gadgets[GID_U_CH7        ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) game,                      TAG_END);
}

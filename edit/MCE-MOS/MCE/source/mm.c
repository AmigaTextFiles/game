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
#define GID_MM_LY1    0 // root layout
#define GID_MM_SB1    1
#define GID_MM_ST1    2 // name
#define GID_MM_CH1    3 // race
#define GID_MM_CH2    4 // class
#define GID_MM_CH3    5 // sex
#define GID_MM_CH4    6 // city
#define GID_MM_CH5    7 // alignment
#define GID_MM_CH6    8 // game
#define GID_MM_IN1    9 // current hp
#define GID_MM_IN2   10 // maximum hp
#define GID_MM_IN3   11 // current sp
#define GID_MM_IN4   12 // maximum sp
#define GID_MM_IN5   13 // man
#define GID_MM_IN6   14 // men
#define GID_MM_IN7   15 // level
#define GID_MM_IN8   16 // xp
#define GID_MM_IN9   17 // gp
#define GID_MM_IN10  18 // cur str ("might")
#define GID_MM_IN11  19 // max str ("might")
#define GID_MM_IN12  20 // cur iq
#define GID_MM_IN13  21 // max iq
#define GID_MM_IN14  22 // cur pers
#define GID_MM_IN15  23 // max pers
#define GID_MM_IN16  24 // cur endurance
#define GID_MM_IN17  25 // max endurance
#define GID_MM_IN18  26 // cur speed
#define GID_MM_IN19  27 // max speed
#define GID_MM_IN20  28 // cur accuracy
#define GID_MM_IN21  29 // max accuracy
#define GID_MM_IN22  30 // cur luck
#define GID_MM_IN23  31 // max luck
#define GID_MM_IN24  32 // magic  resistance
#define GID_MM_IN25  33 // fire   resistance
#define GID_MM_IN26  34 // elect  resistance
#define GID_MM_IN27  35 // cold   resistance
#define GID_MM_IN28  36 // energy resistance
#define GID_MM_IN29  37 // sleep  resistance
#define GID_MM_IN30  38 // poison resistance
#define GID_MM_IN31  39 // acid   resistance
#define GID_MM_IN32  40 // current spell level
#define GID_MM_IN33  41 // maximum spell level
#define GID_MM_IN34  42 // food
#define GID_MM_IN35  43 // age
#define GID_MM_IN36  44 // gems
#define GID_MM_IN37  45 // ac
#define GID_MM_IN38  46 // birth year
#define GID_MM_IN39  47 // party gems
#define GID_MM_IN40  48 // party gp
#define GID_MM_IN41  49 // party food
#define GID_MM_CB1   50 // 1st status
#define GID_MM_CB2   51 // 2nd status
#define GID_MM_CB3   52 // 3rd status
#define GID_MM_CB4   53 // 4th status
#define GID_MM_CB5   54 // 5th status
#define GID_MM_CB6   55 // 6th status
#define GID_MM_CB7   56 // 7th status
#define GID_MM_CB8   57 // 8th status
#define GID_MM_BU1   58 // maximize man
#define GID_MM_BU2   59 //  1st item
#define GID_MM_BU13  70 // 12th item
#define GID_MM_BU14  71 // 13th item
#define GID_MM_BU19  76 // 18th item
#define GID_MM_BU20  77 // maximize party
#define GID_MM_BU21  78 // invert selection
#define GID_MM_BU22  79 // all
#define GID_MM_BU23  80 // none
#define GID_MM_BU24  81 // awards...
#define GID_MM_BU25  82 // skills...
#define GID_MM_LB1   83 // spells listbrowser

// items subwindow
#define GID_MM_LY2   84
#define GID_MM_LB2   85
#define GID_MM_LB3   86
#define GID_MM_LB4   87
#define GID_MM_LB5   88
#define GID_MM_LB6   89
#define GID_MM_IN43  90 // charges
#define GID_MM_IN44  91 // pluses

// skills subwindow
#define GID_MM_LY3   92
#define GID_MM_CB9   93 //  1st skill
#define GID_MM_CB26 110 // 18th skill
#define GID_MM_CH7  111 //  1st skill
#define GID_MM_CH8  112 //  2nd skill
#define GID_MM_IN42 113 // thievery

// awards subwindow
#define GID_MM_LY4  114
#define GID_MM_CB27 115 //  1st award flag
#define GID_MM_CB39 127 // 13th award flag
#define GID_MM_IN45 128 //  1st award number
#define GID_MM_IN54 137 // 10st award number

#define GIDS_MM     GID_MM_IN54

#define ItemButton(x)     LAYOUT_AddChild, gadgets[GID_MM_BU2  + x] = (struct Gadget*) ZButtonObject,        GA_ID, GID_MM_BU2  + x, GA_RelVerify, TRUE, BUTTON_Justification, BCJ_LEFT, ButtonEnd
#define SkillButton(x, y) LAYOUT_AddChild, gadgets[GID_MM_CB9  + x] = (struct Gadget*) TickOrCheckBoxObject, GA_ID, GID_MM_CB9  + x, GA_Text, y, GA_Selected, man[who].skill[x], End
#define AwardFlag(x, y)   LAYOUT_AddChild, gadgets[GID_MM_CB27 + x] = (struct Gadget*) TickOrCheckBoxObject, GA_ID, GID_MM_CB27 + x, GA_Text, y, GA_Selected, man[who].awardflag[x], End
#define AwardNum(x, y)    AddHLayout, LAYOUT_VertAlignment, LALIGN_CENTER, LAYOUT_AddChild, gadgets[GID_MM_IN45 + x] = (struct Gadget*) IntegerObject, GA_ID, GID_MM_IN45 + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 255, INTEGER_MinVisible, 3 + 1, INTEGER_Number, man[who].awardnum[x], End, CHILD_WeightedWidth, 0, AddLabel(y), CHILD_WeightedWidth, 0, AddSpace, LayoutEnd

#define GAME_MM2     0
#define GAME_MM3     1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void maximize_man(int whichman);
MODULE void itemwindow(void);
MODULE void changespelllist(void);
MODULE void awardswindow(void);
MODULE void skillswindow(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT LONG                 gamesize;
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SexList,
                            SpeedBarList;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;
#ifndef __MORPHOS__
    IMPORT UWORD*           MouseData;
#endif

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE ULONG                food,
                            game,
                            gems,
                            gp,
                            men,
                            who;
MODULE int                  spells,
                            submode,
                            whichitem;
MODULE STRPTR*              ClassOptions;
MODULE struct List          Adj1List,
                            Adj2List,
                            Adj3List,
                            Adj4List,
                            SpellsList;

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  BBB. .... .... ....    . = Transparent  (%00)
    BCCB .... .... ....    B = Blue         (%01)
    BCBC B... .... ....    C = Cyan         (%10)
    BCBB CB.. .... ....
    BCBC BCB. .... ....
    BCBB BBCB .... ....
    BCBB BCBC B... ....
    BCBB BBCB CB.. ....
    BCCC CBBB CB.. ....
    BBBB BCBB CB.. ....
    .... .BCC CB.. ....
    .... ..BB BB.. ....
    .... .... .... ....
    .... .... .... ....
    .... .... .... ....
    .... .... .... ....


          Plane 1                Plane 0
    BBB. .... .... ....    .... .... .... ....
    B..B .... .... ....    .CC. .... .... ....
    B.B. B... .... ....    .C.C .... .... ....
    B.BB .B.. .... ....    .C.. C... .... ....
    B.B. B.B. .... ....    .C.C .C.. .... ....
    B.BB BB.B .... ....    .C.. ..C. .... ....
    B.BB B.B. B... ....    .C.. .C.C .... ....
    B.BB BB.B .B.. ....    .C.. ..C. C... ....
    B... .BBB .B.. ....    .CCC C... C... ....
    BBBB B.BB .B.. ....    .... .C.. C... ....
    .... .B.. .B.. ....    .... ..CC C... ....
    .... ..BB BB.. ....    .... .... .... ....
    .... .... .... ....    .... .... .... ....
    .... .... .... ....    .... .... .... ....
    .... .... .... ....    .... .... .... ....
    .... .... .... ....    .... .... .... ....
           Blue                   Cyan

    Plane 1 Plane 0 */
    0xE000, 0x0000,
    0x9000, 0x6000,
    0xA800, 0x5000,
    0xB400, 0x4800,
    0xAA00, 0x5400,
    0xBD00, 0x4200,
    0xBA80, 0x4500,
    0xBD40, 0x4280,
    0x8740, 0x7880,
    0xFB40, 0x0480,
    0x0440, 0x0380,
    0x03C0, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,
    0x0000, 0x0000,

    0x0000, 0x0000  // reserved
};
#endif

MODULE STRPTR MM2ClassOptions[] =
{ "Knight",
  "Paladin",
  "Archer",
  "Cleric",
  "Sorcerer",
  "Robber",
  "Ninja",
  "Barbarian",
  NULL
}, MM3ClassOptions[] =
{ "Knight",
  "Paladin",
  "Archer",
  "Cleric",
  "Sorcerer",
  "Robber",
  "Ninja",
  "Barbarian",
  "Druid",  // MM3 only
  "Ranger", // MM3 only
  NULL
};

MODULE const STRPTR AlignmentOptions[3 + 1] =
{ "Good",
  "Neutral",
  "Evil",
  NULL
}, CityOptions[5 + 1] =
{ "Middlegate", // stored in file as $01
  "Atlantium",  // stored in file as $02
  "Tundara",    // stored in file as $03
  "Vulcania",   // stored in file as $04
  "Sansobar",   // stored in file as $05
  NULL
}, GameOptions[2 + 1] =
{ "Might & Magic 2",
  "Might & Magic 3",
  NULL
}, MM2ItemNames[256] =
{ "None",               //   0
  "Small Club",         //   1
  "Small Knife",        //   2
  "Large Club",         //   3
  "Short Dagger",       //   4
  "Large Knife",        //   5
  "Hand Axe",           //   6
  "Cudgel",             //   7
  "Spiked Club",        //   8
  "Bull Whip",          //   9
  "Long Dagger",        //  10
  "Maul",               //  11
  "Short Sword",        //  12
  "Nunchakas",          //  13
  "Mace",               //  14
  "Spear",              //  15
  "Cutlass",            //  16
  "Flail",              //  17
  "Sabre",              //  18
  "Long Sword",         //  19
  "Wakizashi",          //  20
  "Scimitar",           //  21
  "Battle Axe",         //  22
  "Broad Sword",        //  23
  "Katana",             //  24
  "Slumber Club",       //  25
  "Power Club",         //  26
  "Lucky Knife",        //  27
  "Looter Knife",       //  28
  "Power Cudgel",       //  29
  "Energy Whip",        //  30
  "Sonic Whip",         //  31
  "Mighty Whip",        //  32
  "Scorch Maul",        //  33
  "Mauler Mace",        //  34
  "Exacto Spear",       //  35
  "Fiery Spear",        //  36
  "Fast Cutlass",       //  37
  "Quick Flail",        //  38
  "Shock Flail",        //  39
  "Sharp Sabre",        //  40
  "Ego Scimitar",       //  41
  "True Axe",           //  42
  "Blazing Axe",        //  43
  "Electric Axe",       //  44
  "Rapid Katana",       //  45
  "Accurate Sword",     //  46
  "Chance Sword",       //  47
  "Speedy Sword",       //  48
  "Flash Sword",        //  49
  "Flaming Sword",      //  50
  "Electric Sword",     //  51
  "Acidic Sword",       //  52
  "Cold Blade",         //  53
  "Sage Dagger",        //  54
  "Holy Cudgel",        //  55
  "Divine Mace",        //  56
  "Ice Scimitar",       //  57
  "Grand Axe",          //  58
  "Swift Axe",          //  59
  "Dyno Katana",        //  60
  "Force Sword",        //  61
  "Magic Sword",        //  62
  "Thunder Sword",      //  63
  "Energy Blade",       //  64
  "Photon Blade",       //  65
  "Staff",              //  66
  "Sickle",             //  67
  "Scythe",             //  68
  "Glaive",             //  69
  "War Hammer",         //  70
  "Trident",            //  71
  "Pike",               //  72
  "Naginata",           //  73
  "Bardiche",           //  74
  "Great Hammer",       //  75
  "Halberd",            //  76
  "Great Axe",          //  77
  "Flamberge",          //  78
  "Wind Staff",         //  79
  "Tri-Sickle",         //  80
  "Ice Sickle",         //  81
  "Fire Glaive",        //  82
  "Harsh Hammer",       //  83
  "Stone Hammer",       //  84
  "Genius Staff",       //  85
  "Wizard Staff",       //  86
  "Soul Staff",         //  87
  "Dark Trident",       //  88
  "Titan's Pike",       //  89
  "Moon Halberd",       //  90
  "Sun Naginata",       //  91
  "Blowpipe",           //  92
  "Sling",              //  93
  "Short Bow",          //  94
  "Crossbow",           //  95
  "Long Bow",           //  96
  "Great Bow",          //  97
  "Shaman Pipe",        //  98
  "Cinder Pipe",        //  99
  "Quiet Sling",        // 100
  "Pirate's Crossbow",  // 101
  "Burning Crossbow",   // 102
  "Fireball Bow",       // 103
  "Voltage Bow",        // 104
  "Giant Sling",        // 105
  "Energy Sling",       // 106
  "Death Bow",          // 107
  "Star Bow",           // 108
  "Meteor Bow",         // 109
  "Ancient Bow",        // 110
  "Green Key",          // 111
  "Yellow Key",         // 112
  "Red Key",            // 113
  "Black Key",          // 114
  "Small Shield",       // 115
  "Large Shield",       // 116
  "Great Shield",       // 117
  "Fire Shield",        // 118
  "Electric Shield",    // 119
  "Acid Shield",        // 120
  "Cold Shield",        // 121
  "Silver Shield",      // 122
  "Bronze Shield",      // 123
  "Iron Shield",        // 124
  "Magic Shield",       // 125
  "Gold Shield",        // 126
  "Padded Armour",      // 127
  "Leather Suit",       // 128
  "Scale Armour",       // 129
  "Ring Mail",          // 130
  "Chain Mail",         // 131
  "Splint Mail",        // 132
  "Plate Mail",         // 133
  "Plate Armour",       // 134
  "Iron Scale Mail",    // 135
  "Bronze Scale Mail",  // 136
  "Silver Scale Mail",  // 137
  "Iron Ring Mail",     // 138
  "Bronze Ring Mail",   // 139
  "Silver Ring Mail",   // 140
  "Iron Chain Mail",    // 141
  "Bronze Chain Mail",  // 142
  "Silver Chain Mail",  // 143
  "Iron Splint Mail",   // 144
  "Bronze Splint Mail", // 145
  "Silver Splint Mail", // 146
  "Iron Plate Mail",    // 147
  "Bronze Plate Mail",  // 148
  "Silver Plate Mail",  // 149
  "Gold Scale Mail",    // 150
  "Gold Ring Mail",     // 151
  "Gold Chain Mail",    // 152
  "Gold Splint Mail",   // 153
  "Gold Plate Mail",    // 154
  "Helm",               // 155
  "Iron Helm",          // 156
  "Bronze Helm",        // 157
  "Silver Helm",        // 158
  "Gold Helm",          // 159
  "Magic Herbs",        // 160
  "Torch",              // 161
  "Lantern",            // 162
  "Thief's Pick",       // 163
  "Rope and Hooks",     // 164
  "Wakeup Horn",        // 165
  "Compass",            // 166
  "Sextant",            // 167
  "Force Potion",       // 168
  "Skill Potion",       // 169
  "Max HP Potion",      // 170
  "Holy Charm",         // 171
  "Herbal Patch",       // 172
  "Hero Medal",         // 173
  "Silent Horn",        // 174
  "Magic Meal",         // 175
  "Antidote Ale",       // 176
  "Super Flare",        // 177
  "Dove's Blood",       // 178
  "Ray Gun",            // 179
  "Magic Charm",        // 180
  "Witch Broom",        // 181
  "Invisocloak",        // 182
  "Storm Wand",         // 183
  "Lava Grenade",       // 184
  "Hourglass",          // 185
  "Instant Keep",       // 186
  "Teleport Orb",       // 187
  "Skeleton Key",       // 188
  "Defence Ring",       // 189
  "Might Gauntlet",     // 190
  "Accuracy Gauntlet",  // 191
  "Stealth Cape",       // 192
  "Admit 8 Pass",       // 193
  "Speed Boots",        // 194
  "Cureall Wand",       // 195
  "Moon Rock",          // 196
  "Ruby Ankh",          // 197
  "Disruptor",          // 198
  "Lich Hand",          // 199
  "Phaser",             // 200
  "Freeze Wand",        // 201
  "Energizer",          // 202
  "Magic Mirror",       // 203
  "Elven Cloak",        // 204
  "Elven Boots",        // 205
  "Sage Robe",          // 206
  "Enchanted Id",       // 207
  "Green Ticket",       // 208
  "Yellow Ticket",      // 209
  "Red Ticket",         // 210
  "Black Ticket",       // 211
  "Fe Farthing",        // 212
  "Castle Key",         // 213
  "Mark's Keys",        // 214
  "Dog Whistle",        // 215
  "Web Caster",         // 216
  "Monster Tome",       // 217
  "Cupie Doll",         // 218
  "Water Talon",        // 219
  "Air Talon",          // 220
  "Fire Talon",         // 221
  "Earth Talon",        // 222
  "Element Orb",        // 223
  "Gold Goblet",        // 224
  "+7 Loincloth",       // 225
  "Valour Sword",       // 226
  "Honour Sword",       // 227
  "Noble Sword",        // 228
  "Corak's Soul",       // 229
  "Emerald Ring",       // 230
  "Water Disc",         // 231
  "Air Disc",           // 232
  "Fire Disc",          // 233
  "Earth Disc",         // 234
  "Sapphire Pin",       // 235
  "Amethyst Box",       // 236
  "Coral Broach",       // 237
  "Lapis Scarab",       // 238
  "Amber Skull",        // 239
  "Quartz Skull",       // 240
  "Agate Grail",        // 241
  "Opal Pendant",       // 242
  "Crystal Vial",       // 243
  "Ruby Amulet",        // 244
  "Ivory Cameo",        // 245
  "Ruby Tiara",         // 246
  "Onyx Effigy",        // 247
  "Pearl Choker",       // 248
  "Topaz Shard",        // 249
  "Sun Crown",          // 250
  "J-26 Fluxer",        // 251
  "M-27 Radicon",       // 252
  "A-1 Todilor",        // 253
  "N-19 Capitor",       // 254
  "Useless Item"        // 255
  // no NULL is required
}, MM3ItemNames[104 + 1] =
{ "None",               //   0
  "Long sword",         //   1
  "Short sword",        //   2
  "Broad sword",        //   3
  "Scimitar",           //   4
  "Cutlass",            //   5
  "Sabre",              //   6
  "Club",               //   7
  "Hand axe",           //   8
  "Katana",             //   9
  "Nunchakas",          //  10
  "Wakazashi",          //  11
  "Dagger",             //  12
  "Mace",               //  13
  "Flail",              //  14
  "Cudgel",             //  15
  "Maul",               //  16
  "Spear",              //  17
  "Bardiche",           //  18
  "Glaive",             //  19
  "Halberd",            //  20
  "Pike",               //  21
  "Flamberge",          //  22
  "Trident",            //  23
  "Staff",              //  24
  "Hammer",             //  25
  "Naginata",           //  26
  "Battle axe",         //  27
  "Grand axe",          //  28
  "Great axe",          //  29
  "Short bow",          //  30
  "Long bow",           //  31
  "Crossbow",           //  32
  "Sling",              //  33
  "Padded armour",      //  34
  "Leather armour",     //  35
  "Scale armour",       //  36
  "Ring mail",          //  37
  "Chain mail",         //  38
  "Splint mail",        //  39
  "Plate mail",         //  40
  "Plate armour",       //  41
  "Shield",             //  42
  "Helm",               //  43
  "Crown",              //  44
  "Tiara",              //  45
  "Gauntlets",          //  46
  "Ring",               //  47
  "Boots",              //  48
  "Cloak",              //  49
  "Robes",              //  50
  "Cape",               //  51
  "Belt",               //  52
  "Broach",             //  53
  "Medal",              //  54
  "Charm",              //  55
  "Cameo",              //  56
  "Scarab",             //  57
  "Pendant",            //  58
  "Necklace",           //  59
  "Amulet",             //  60
  "Rod",                //  61
  "Jewel",              //  62
  "Gem",                //  63
  "Box",                //  64
  "Orb",                //  65
  "Horn",               //  66
  "Coin",               //  67
  "Wand",               //  68
  "Whistle",            //  69
  "Potion",             //  70
  "Scroll",             //  71
  "Torch",              //  72
  "Rope and Hooks",     //  73
  "Useless Item",       //  74
  "Ancient Jewelry",    //  75
  "Green Eyeball Key",  //  76
  "Red Warrior's Key"                 , //  77
  "Sacred Silver Skull"               , //  78
  "Ancient Artifact of Good"          , //  79
  "Ancient Artifact of Neutrality"    , //  80
  "Ancient Artifact of Evil"          , //  81
  "Jewelry"                           , //  82
  "Precious Pearl of Youth and Beauty", //  83
  "Black Terror Key"                  , //  84
  "King's Ultimate Power Orb"         , //  85
  "Ancient Fizbin of Mizfortune"      , //  86
  "Master Key"                        , //  87
  "Quatloo Coin"                      , //  88
  "Hologram Sequencing Card 001"      , //  89
  "Yellow Fortress Key"               , //  90
  "Blue Unholy Key"                   , //  91
  "Hologram Sequencing Card 002"      , //  92
  "Hologram Sequencing Card 003"      , //  93
  "Hologram Sequencing Card 004"      , //  94
  "Hologram Sequencing Card 005"      , //  95
  "Hologram Sequencing Card 006"      , //  96
  "Z Item 23"                         , //  97
  "Blue Priority Pass Card"           , //  98
  "Interspatial Transport Box"        , //  99
  "Might Potion"                      , // 101
  "Gold Pyramid Key Card"             , // 102
  "Alacorn of Icarus"                 , // 103
  "Sea Shell"                         , // 104
  // no NULL is required
}, RaceOptions[5 + 1] =
{ "Human",
  "Elf",
  "Dwarf",
  "Gnome",
  "Half-Orc",
  NULL
}, SpellNames[96] =
{ "Apparition",               // C1  0
  "Awaken (Cleric)",          // C1
  "Bless",                    // C1
  "First Aid",                // C1
  "Light (Cleric)",           // C1
  "Power Cure",               // C1  5
  "Turn Undead",              // C1
  "Cure Wounds",              // C2
  "Heroism",                  // C2
  "Nature's Gate",            // C2
  "Pain",                     // C2 10
  "Protection from Elements", // C2
  "Silence",                  // C2
  "Weaken",                   // C2
  "Cold Ray",                 // C3
  "Create Food",              // C3 15
  "Cure Poison",              // C3
  "Immobilize",               // C3
  "Lasting Light",            // C3
  "Walk on Water",            // C3
  "Acid Spray",               // C4 20
  "Air Transmutation",        // C4
  "Cure Disease",             // C4
  "Restore Alignment",        // C4
  "Surface",                  // C4
  "Holy Bonus",               // C4 25
  "Air Encasement",           // C5
  "Deadly Swarm",             // C5
  "Frenzy",                   // C5
  "Paralyze",                 // C5
  "Remove Condition",         // C5 30
  "Earth Transmutation",      // C6
  "Rejuvenate",               // C6
  "Stone to Flesh",           // C6
  "Water Encasement",         // C6
  "Water Transmutation",      // C6 35
  "Earth Encasement",         // C7
  "Fiery Flail",              // C7
  "Moon Ray",                 // C7
  "Raise Dead",               // C7
  "Fire Encasement",          // C8 40
  "Fire Transmutation",       // C8
  "Mass Distortion",          // C8
  "Town Portal",              // C8
  "Divine Intervention",      // C9
  "Holy Word",                // C9 45
  "Resurrection",             // C9
  "Uncurse Item",             // C9 47
  "Awaken (Sorcerer)",        // S1 48
  "Detect Magic",             // S1
  "Energy Blast",             // S1 50
  "Flame Arrow",              // S1
  "Light (Sorcerer)",         // S1
  "Location",                 // S1
  "Sleep",                    // S1
  "Eagle Eye",                // S2 55
  "Electric Arrow",           // S2
  "Identify Monster",         // S2
  "Jump",                     // S2
  "Levitate",                 // S2
  "Lloyd's Beacon",           // S2 60
  "Protection from Magic",    // S2
  "Acid Stream",              // S3
  "Fly",                      // S3
  "Invisibility",             // S3
  "Lightning Bolt",           // S3 65
  "Web",                      // S3
  "Wizard Eye",               // S3
  "Cold Beam",                // S4
  "Feeble Mind",              // S4
  "Fireball",                 // S4 70
  "Guard Dog",                // S4
  "Shield",                   // S4
  "Time Distortion",          // S4
  "Disrupt",                  // S5
  "Fingers of Death",         // S5 75
  "Sand Storm",               // S5
  "Shelter",                  // S5
  "Teleport",                 // S5
  "Disintegration",           // S6
  "Entrapment",               // S6 80
  "Fantastic Freeze",         // S6
  "Recharge Item",            // S6
  "Super Shock",              // S6
  "Dancing Sword",            // S7
  "Duplication",              // S7 85
  "Etherealize",              // S7
  "Prismatic Light",          // S7
  "Incinerate",               // S8
  "Mega Volts",               // S8
  "Meteor Shower",            // S8 90
  "Power Shield",             // S8
  "Implosion",                // S9
  "Inferno",                  // S9
  "Star Burst",               // S9
  "Enchant Item"              // S9 95
  // no NULL is required
}, MM2SkillOptions[16 + 1] =
{ "None",         //  0
  "Arms Master",
  "Athlete",
  "Cartographer",
  "Crusader",
  "Diplomat",     //  5
  "Gambler",
  "Gladiator",
  "Hero",
  "Linguist",
  "Merchant",     // 10
  "Mountaineer",
  "Navigator",
  "Pathfinder",
  "Pickpocket",
  "Soldier",      // 15
  NULL            // 16
}, Adj1Names[36 + 1] =
{ "Normal",                             //   0
  "Burning",
  "Fiery",
  "Pyric",
  "Fuming",
  "Flaming",
  "Seething",
  "Blazing",
  "Scorching",
  "Flickering",
  "Sparking",                           //  10
  "Static",
  "Flashing",
  "Shocking",
  "Electric",
  "Dyna",
  "Ice",
  "Frost",
  "Freezing",
  "Cold",
  "Cryo",                               //  20
  "Acidic",
  "Venomous",
  "Poisonous",
  "Toxic",
  "Noxious",
  "Glowing",
  "Incandescent",
  "Dense",
  "Sonic",
  "Power",                              //  30
  "Thermal",
  "Radiating",
  "Kinetic",
  "Mystic",
  "Magical",
  "Ectoplasmic"                         //  36
}, Adj2Names[22 + 1] =
{ "Normal",             //   0
  "Wooden",
  "Leather",
  "Brass",
  "Bronze",
  "Iron",
  "Silver",
  "Steel",
  "Gold",
  "Platinum",
  "Glass",              //  10
  "Coral",
  "Crystal",
  "Lapis",
  "Pearl",
  "Amber",
  "Ebony",
  "Quartz",
  "Ruby",
  "Emerald",
  "Sapphire",           //  20
  "Diamond",
  "Obsidian"            //  22
}, Adj3Names[75 + 1] =
{ "Normal",             //   0
  "Might",
  "Strength",
  "Warrior",
  "Ogre",
  "Giant",
  "Thunder",
  "Force",
  "Power",
  "Dragon",
  "Photon",             //  10
  "Clever",
  "Mind",
  "Sage",
  "Thought",
  "Knowledge",
  "Intellect",
  "Wisdom",
  "Genius",
  "Buddy",
  "Friendship",         //  20
  "Charm",
  "Personality",
  "Charisma",
  "Leadership",
  "Ego",
  "Holy",
  "Quick",
  "Swift",
  "Fast",
  "Rapid",              //  30
  "Speed",
  "Wind",
  "Accelerator",
  "Velocity",
  "Sharp",
  "Accurate",
  "Marksman",
  "Precision",
  "True",
  "Exacto",             //  40
  "Clover",
  "Chance",
  "Winner's",
  "Lucky",
  "Gambler's",
  "Leprechaun's",
  "Vigour",
  "Health",
  "Life",
  "Troll",              //  50
  "Vampire",
  "Spell",
  "Castor's",
  "Witch",
  "Mage",
  "Archmage",
  "Arcane",
  "Protection",
  "Armoured",
  "Defender",           //  60
  "Stealth",
  "Divine",
  "Mugger",
  "Burglar",
  "Looter",
  "Brigand",
  "Filch",
  "Thief",
  "Rogue",
  "Plunder",            //  70
  "Criminal",
  "Pirate"              //  72
}, Adj4Names[75 + 1] =
{ "Normal",             //   0
  "of Light",
  "of Awakening",
  "of Magic Detection",
  "of Arrows",
  "of Aid",
  "of Fists",
  "of Energy Blasts",
  "of Sleeping",
  "of Revitalization",
  "of Curing",          //  10
  "of Sparking",
  "of Ropes",
  "of Toxic Clouds",
  "of Elements",
  "of Pain",
  "of Jumping",
  "of Acid Streams",
  "of Undead Turning",
  "of Levitation",
  "of Wizard Eyes",     //  20
  "of Silence",
  "of Blessing",
  "of Identification",
  "of Lightning",
  "of Holy Bonuses",
  "of Power Curing",
  "of Nature",
  "of Beacons",
  "of Shielding",
  "of Heroism",         //  30
  "of Immobilization",
  "of Water Walking",
  "of Frost Biting",
  "of Monster Finding",
  "of Fireballs",
  "of Cold Rays",
  "of Antidotes",
  "of Acid Spraying",
  "of Distortion",
  "of Feeble Minding",  //  40
  "of Vaccination",
  "of Gating",
  "of Teleportation",
  "of Death",
  "of Free Movement",
  "of Paralyzing",
  "of Deadly Swarms",
  "of Sanctuaries",
  "of Dragon Breath",
  "of Feasting",        //  50
  "of Fiery Flails",
  "of Recharging",
  "of Freezing",
  "of Portals",
  "of Stone to Flesh",
  "of Duplication",
  "of Disintegration",
  "of Half for Me",
  "of Raising the Dead",
  "of Etherealization", //  60
  "of Dancing Swords",
  "of Moon Rays",
  "of Mass Distortion",
  "of Prismatic Light",
  "of Enchantment",
  "of Incinerating",
  "of Holy Words",
  "of Resurrection",
  "of Storms",
  "of Megavoltage",     //  70
  "of Infernos",
  "of Sun Rays",
  "of Implosions",
  "of Star Bursts",
  "of the Gods!"        //  75
}, SorcererSpellNames[36] =
{ "Light (sorcerer)",       //  0 $9DE
  "Awaken (sorcerer)",
  "Detect Magic (sorcerer)",
  "Elemental Arrow (sorcerer)",
  "Energy Blast",
  "Sleep (sorcerer)",
  "Create Rope (sorcerer)",
  "Toxic Cloud",
  "Jump",
  "Acid Stream",
  "Levitate",
  "Wizard Eye",
  "Identify Monster (sorcerer)",
  "Lightning Bolt (sorcerer)",
  "Lloyd's Beacon",
  "Power Shield",
  "Detect Monster",
  "Fireball (sorcerer)",
  "Time Distortion",
  "Feeble Mind",
  "Teleport",
  "Finger of Death",
  "Super Shelter",
  "Dragon Breath",
  "Recharge Item",
  "Fantastic Freeze",
  "Duplication",
  "Disintegrate",
  "Etherealize",
  "Dancing Sword",
  "Enchant Item",
  "Incinerate",
  "Megavolts",
  "Inferno",
  "Implosion",
  "Star Burst"          // 35 $A01
  // no NULL is required
}, ClericSpellNames[36] =
{ "Light (cleric)",     //  0 $9DE
  "Awaken (cleric)",
  "First Aid (cleric)",
  "Flying Fist",
  "Revitalize (cleric)",
  "Cure Wounds",
  "Sparks",
  "Prot. from Elements (cleric)",
  "Pain",
  "Suppress Poison (cleric)",
  "Suppress Disease (cleric)",
  "Turn Undead",
  "Silence",
  "Blessed",
  "Holy Bonus",
  "Power Cure",
  "Heroism",
  "Immobilize (cleric)",
  "Cold Ray (cleric)",
  "Cure Poison",
  "Acid Spray (cleric)",
  "Cure Disease",
  "Cure Paralysis (cleric)",
  "Paralyze (cleric)",
  "Create Food (cleric)",
  "Fiery Flail",
  "Town Portal",
  "Stone to Flesh (cleric)",
  "Half for Me",
  "Raise Dead (cleric)",
  "Moon Ray",
  "Mass Distortion",
  "Holy Word",
  "Resurrect",
  "Sun Ray",
  "Divine Intervention" // 35 $A01
  // no NULL is required
}, DruidSpellNames[29] =
{ "Light (druid)",      //  0 $9DE
  "Awaken (druid)",
  "First Aid (druid)",
  "Detect Magic (druid)",
  "Elemental Arrow (druid)",
  "Revitalize (druid)",
  "Create Rope (druid)",
  "Sleep (druid)",
  "Prot. from Elements (druid)",
  "Suppress Poison (druid)",
  "Suppress Disease (druid)",
  "Identify Monster (druid)",
  "Nature's Cure",
  "Immobilize (druid)",
  "Walk on Water",
  "Frost Bite",
  "Lightning Bolt (druid)",
  "Acid Spray (druid)",
  "Cold Ray (druid)",
  "Nature's Gate",
  "Fireball (druid)",
  "Deadly Swarm",
  "Cure Paralysis (druid)",
  "Paralyze (druid)",
  "Create Food (druid)",
  "Stone to Flesh (druid)",
  "Raise Dead (druid)",
  "Prismatic Light",
  "Elemental Storm"     // 28 $9FA
  // no NULL is required
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   TEXT   name[16 + 1];
    ULONG  city,
           curhp,
           maxhp,
           cursp,
           maxsp,
           race,
           level,
           xp,
           gp,
           sex,
           theclass,
           alignment,
           status,
           age,
           armourclass,
           food,
           skill[18],
           thievery,
           gems,
           cur_str,
           cur_iq,
           cur_pers,
           cur_end,
           cur_speed,
           cur_accuracy,
           cur_luck,
           cur_spelllevel,
           max_str,
           max_iq,
           max_pers,
           max_end,
           max_speed,
           max_accuracy,
           max_luck,
           max_spelllevel,
           mr,
           fire,
           elec,
           cold,
           energy,
           sleep,
           poison,
           acid,
           item[18],
           charges[18],
           plus[18],
           spell[96];

    // M&M3 only...
    ULONG  birthyear,
           awardflag[13], awardnum[10],
           adj1[18], adj2[18], adj3[18], adj4[18];
} man[48];

// 8. CODE ---------------------------------------------------------------

EXPORT void mm_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // mm_preinit()
        NewList(&SpellsList);
        NewList(&Adj1List);
        NewList(&Adj2List);
        NewList(&Adj3List);
        NewList(&Adj4List);

        // mm_init()
        lb_makelist(&Adj1List, Adj1Names, 36 + 1);
        lb_makelist(&Adj2List, Adj2Names, 22 + 1);
        lb_makelist(&Adj3List, Adj3Names, 72 + 1);
        lb_makelist(&Adj4List, Adj4Names, 75 + 1);
    }

    tool_open      = mm_open;
    tool_loop      = mm_loop;
    tool_save      = mm_save;
    tool_close     = mm_close;
    tool_exit      = mm_exit;
    tool_subgadget = mm_subgadget;

    if (loaded != FUNC_MM && !mm_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_MM;

    changespelllist();
    make_speedbar_list(GID_MM_SB1);
    load_aiss_images( 6,  8);
    load_aiss_images(10, 10);
    makesexlist();
    if (game == GAME_MM2)
    {   ClassOptions = (STRPTR*) &MM2ClassOptions;
    } else
    {   ClassOptions = (STRPTR*) &MM3ClassOptions;
    }

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                         TRUE,
        WA_ThinSizeGadget,                                     TRUE,
        WINDOW_Position,                                       WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                    gadgets[GID_MM_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                 TRUE,
            LAYOUT_DeferLayout,                                TRUE,
            LAYOUT_AddChild,
            HLayoutObject,
                AddToolbar(GID_MM_SB1),
                AddSpace,
                CHILD_WeightedWidth,                           50,
                LAYOUT_AddChild,
                VLayoutObject,
                    AddSpace,
                    CHILD_WeightedHeight,                      50,
                    LAYOUT_AddChild,                           gadgets[GID_MM_CH6] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_MM_CH6,
                        GA_Disabled,                           TRUE,
                        CHOOSER_LabelArray,                    &GameOptions,
                    PopUpEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                      0,
                    AddSpace,
                    CHILD_WeightedHeight,                      50,
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
                AddSpace,
                CHILD_WeightedWidth,                           50,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                LAYOUT_VertAlignment,                          LALIGN_CENTER,
                AddLabel("Character #:"),
                LAYOUT_AddChild,                               gadgets[GID_MM_IN5] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_MM_IN5,
                    GA_RelVerify,                              TRUE,
                    GA_TabCycle,                               TRUE,
                    INTEGER_Minimum,                           1,
                    INTEGER_Maximum,                           men,
                    INTEGER_Number,                            who + 1,
                    INTEGER_MinVisible,                        2 + 1,
                IntegerEnd,
                AddLabel("of"),
                LAYOUT_AddChild,                               gadgets[GID_MM_IN6] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_MM_IN6,
                    GA_Disabled,                               TRUE,
                    INTEGER_Arrows,                            FALSE,
                    INTEGER_Number,                            men,
                    INTEGER_MinVisible,                        2 + 1,
                IntegerEnd,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddVLayout,
                LAYOUT_BevelStyle,                             BVS_GROUP,
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_Label,                                  "Character",
                AddHLayout,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "General",
                            AddVLayout,
                                AddLabel("Name:"),
                                AddLabel("Hit Points:"),
                                AddLabel("Spell Points:"),
                                AddLabel("Race:"),
                                AddLabel("Class:"),
                                AddLabel("Sex:"),
                                AddLabel("City:"),
                                AddLabel("Alignment:"),
                                AddLabel("Experience Level:"),
                                AddLabel("Experience Points:"),
                                AddLabel("Spell Level:"),
                                AddLabel("Age:"),
                                AddLabel("Birth Year:"),
                                AddLabel("Armour Class:"),
                                AddLabel("Food:"),
                                AddLabel("Gems:"),
                                AddLabel("Gold Pieces:"),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_AddChild,               gadgets[GID_MM_ST1] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                     GID_MM_ST1,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    STRINGA_TextVal,           man[who].name,
                                    STRINGA_MaxChars,          16 + 1,
                                StringEnd,
                                AddHLayout,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN1] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN1,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       65535,
                                        INTEGER_Number,        man[who].curhp,
                                        INTEGER_MinVisible,    5 + 1,
                                    IntegerEnd,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN2] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN2,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       1,
                                        INTEGER_Maximum,       65535,
                                        INTEGER_Number,        man[who].maxhp,
                                        INTEGER_MinVisible,    5 + 1,
                                    IntegerEnd,
                                    Label("of"),
                                LayoutEnd,
                                CHILD_WeightedHeight,          0,
                                AddHLayout,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN3] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN3,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       65535,
                                        INTEGER_Number,        man[who].cursp,
                                        INTEGER_MinVisible,    5 + 1,
                                    IntegerEnd,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN4] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN4,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       65535,
                                        INTEGER_Number,        man[who].maxsp,
                                        INTEGER_MinVisible,    5 + 1,
                                    IntegerEnd,
                                    Label("of"),
                                LayoutEnd,
                                CHILD_WeightedHeight,          0,
                                LAYOUT_AddChild,               gadgets[GID_MM_CH1] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                     GID_MM_CH1,
                                    CHOOSER_LabelArray,        &RaceOptions,
                                PopUpEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_CH2] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                     GID_MM_CH2,
                                    GA_RelVerify,              TRUE,
                                    CHOOSER_LabelArray,        ClassOptions,
                                PopUpEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_CH3] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                     GID_MM_CH3,
                                    CHOOSER_Labels,            &SexList,
                                PopUpEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_CH4] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                     GID_MM_CH4,
                                    CHOOSER_LabelArray,        &CityOptions,
                                PopUpEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_CH5] = (struct Gadget*)
                                PopUpObject,
                                    GA_ID,                     GID_MM_CH5,
                                    CHOOSER_LabelArray,        &AlignmentOptions,
                                PopUpEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN7] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN7,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           255,
                                    INTEGER_Number,            man[who].level,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN8] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN8,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           THIRTYBITS,
                                    INTEGER_Number,            man[who].xp,
                                    INTEGER_MinVisible,        13 + 1,
                                IntegerEnd,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN32] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN32,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       9,
                                        INTEGER_MinVisible,    1 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN33] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN33,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       9,
                                        INTEGER_MinVisible,    1 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                CHILD_WeightedHeight,          0,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN35] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN35,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN38] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN38,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN37] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN37,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN34] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN34,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN36] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN36,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           65535,
                                    INTEGER_MinVisible,        5 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN9] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN9,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           THIRTYBITS,
                                    INTEGER_MinVisible,        13 + 1,
                                IntegerEnd,
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        AddVLayout,
                            LAYOUT_BevelStyle,                 BVS_GROUP,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "Spellbook",
                            LAYOUT_AddChild,                   gadgets[GID_MM_LB1] = (struct Gadget*)
                            ListBrowserObject,
                                GA_ID,                         GID_MM_LB1,
                                GA_RelVerify,                  TRUE,
                                LISTBROWSER_Labels,            (ULONG) &SpellsList,
                                LISTBROWSER_ShowSelected,      TRUE,
                                LISTBROWSER_AutoWheel,         FALSE,
                            ListBrowserEnd,
                            HTripleButton(GID_MM_BU22, GID_MM_BU21, GID_MM_BU23),
                        LayoutEnd,
                    LayoutEnd,
                    AddVLayout,
                        AddHLayout,
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "Attributes",
                            AddVLayout,
                                AddLabel("Might:"),
                                AddLabel("Intelligence:"),
                                AddLabel("Personality:"),
                                AddLabel("Endurance:"),
                                AddLabel("Speed:"),
                                AddLabel("Accuracy:"),
                                AddLabel("Luck:"),
                            LayoutEnd,
                            AddVLayout,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN10] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN10,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN11] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN11,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN12] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN12,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN13] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN13,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN14] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN14,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN15] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN15,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN16] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN16,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN17] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN17,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN18] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN18,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN19] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN19,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN20] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN20,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN21] = (struct Gadget*)
                                    IntegerObject,
                                    GA_ID,                     GID_MM_IN21,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                                AddHLayout,
                                    LAYOUT_VertAlignment,      LALIGN_CENTER,
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN22] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN22,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                    AddLabel("of"),
                                    LAYOUT_AddChild,           gadgets[GID_MM_IN23] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_MM_IN23,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       254,
                                        INTEGER_MinVisible,    3 + 1,
                                    IntegerEnd,
                                LayoutEnd,
                            LayoutEnd,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "Resistances",
                            AddVLayout,
                                AddLabel("Magic:"),
                                AddLabel("Fire:"),
                                AddLabel("Electricity:"),
                                AddLabel("Cold:"),
                                AddLabel("Energy:"),
                                AddLabel("Sleep:"),
                                AddLabel("Poison:"),
                                AddLabel("Acid:"),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN24] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN24,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN25] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN25,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN26] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN26,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN27] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN27,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN28] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN28,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN29] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN29,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN30] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN30,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_MM_IN31] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_MM_IN31,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           255,
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_BevelStyle,                 BVS_GROUP,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "Condition",
                            AddVLayout,
                                LAYOUT_AddChild,               gadgets[GID_MM_CB1] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                     GID_MM_CB1,
                                    GA_Text,                   "Cursed",
                                End,
                                LAYOUT_AddChild,               gadgets[GID_MM_CB2] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                     GID_MM_CB2,
                                    GA_Text,                   "Silenced",
                                End,
                                LAYOUT_AddChild,               gadgets[GID_MM_CB3] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                     GID_MM_CB3,
                                    GA_Text,                   "Diseased",
                                End,
                                LAYOUT_AddChild,               gadgets[GID_MM_CB4] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                     GID_MM_CB4,
                                    GA_Text,                   "Poisoned",
                                End,
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_AddChild,               gadgets[GID_MM_CB5] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                     GID_MM_CB5,
                                    GA_Text,                   "Asleep",
                                End,
                                LAYOUT_AddChild,               gadgets[GID_MM_CB6] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                     GID_MM_CB6,
                                    GA_Text,                   "Paralyzed",
                                End,
                                LAYOUT_AddChild,               gadgets[GID_MM_CB7] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                     GID_MM_CB7,
                                    GA_Text,                   "Unconscious",
                                End,
                                LAYOUT_AddChild,               gadgets[GID_MM_CB8] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                     GID_MM_CB8,
                                    GA_Text,                   "Eradicated",
                                End,
                            LayoutEnd,
                            CHILD_WeightedWidth,               0,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        AddHLayout,
                            LAYOUT_AddChild,                   gadgets[GID_MM_BU24] = (struct Gadget*)
                            ZButtonObject,
                                GA_ID,                         GID_MM_BU24,
                                GA_RelVerify,                  TRUE,
                                GA_Text,                       "Awards...",
                            ButtonEnd,
                            CHILD_WeightedWidth,               50,
                            LAYOUT_AddChild,                   gadgets[GID_MM_BU25] = (struct Gadget*)
                            ZButtonObject,
                                GA_ID,                         GID_MM_BU25,
                                GA_RelVerify,                  TRUE,
                                GA_Text,                       "Skills...",
                            ButtonEnd,
                            CHILD_WeightedWidth,               50,
                        LayoutEnd,
                        MaximizeButton(GID_MM_BU1, "Maximize Character"),
                        CHILD_WeightedHeight,                  0,
                    LayoutEnd,
                    CHILD_WeightedWidth,                       0,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "Equipped Items",
                            ItemButton(0),
                            ItemButton(1),
                            ItemButton(2),
                            ItemButton(3),
                            ItemButton(4),
                            ItemButton(5),
                        LayoutEnd,
                        CHILD_MinWidth,                        128,
                        AddVLayout,
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "Backpack Items",
                            ItemButton(6),
                            ItemButton(7),
                            ItemButton(8),
                            ItemButton(9),
                            ItemButton(10),
                            ItemButton(11),
                        LayoutEnd,
                        CHILD_MinWidth,                        128,
                        AddVLayout,
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "Extra Items",
                            ItemButton(12),
                            ItemButton(13),
                            ItemButton(14),
                            ItemButton(15),
                            ItemButton(16),
                            ItemButton(17),
                        LayoutEnd,
                        CHILD_MinWidth,                        128,
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            AddHLayout,
                LAYOUT_VertAlignment,                          LALIGN_CENTER,
                LAYOUT_AddChild,                               gadgets[GID_MM_IN41] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_MM_IN41,
                    GA_TabCycle,                               TRUE,
                    INTEGER_Minimum,                           0,
                    INTEGER_Maximum,                           65535,
                    INTEGER_Number,                            food,
                    INTEGER_MinVisible,                        5 + 1,
                IntegerEnd,
                CHILD_WeightedHeight,                          0,
                Label("Party Food:"),
                LAYOUT_AddChild,                               gadgets[GID_MM_IN39] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_MM_IN39,
                    GA_TabCycle,                               TRUE,
                    INTEGER_Minimum,                           0,
                    INTEGER_Maximum,                           THIRTYBITS,
                    INTEGER_Number,                            gems,
                    INTEGER_MinVisible,                        10 + 1,
                IntegerEnd,
                CHILD_WeightedHeight,                          0,
                Label("Party Gems:"),
                LAYOUT_AddChild,                               gadgets[GID_MM_IN40] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_MM_IN40,
                    GA_TabCycle,                               TRUE,
                    INTEGER_Minimum,                           0,
                    INTEGER_Maximum,                           THIRTYBITS,
                    INTEGER_Number,                            gp,
                    INTEGER_MinVisible,                        10 + 1,
                IntegerEnd,
                CHILD_WeightedHeight,                          0,
                Label("Party Gold:"),
                MaximizeButton(GID_MM_BU20, "Maximize Party"),
                CHILD_WeightedWidth,                           0,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
        LayoutEnd,
        CHILD_NominalSize,                                     TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_MM_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_MM_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_MM_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void mm_loop(ULONG gid, UNUSED ULONG code)
{   STRPTR stringptr;
    int    i;

    switch (gid)
    {
    case GID_MM_IN5:
        readgadgets();
        writegadgets();
    acase GID_MM_BU1:
        readgadgets();
        maximize_man(who);
        writegadgets();
    acase GID_MM_BU20:
        readgadgets();
        for (i = 0; i < (int) men; i++)
        {   maximize_man(i);
        }
        food = 65000;
        gp   =
        gems = ONE_BILLION;
        writegadgets();
    acase GID_MM_BU21:
        readgadgets();
        for (i = 0; i < spells; i++)
        {   if (man[who].spell[i])
            {   man[who].spell[i] = 0;
            } else
            {   man[who].spell[i] = 1;
        }   }
        writegadgets();
    acase GID_MM_BU22:
        readgadgets();
        for (i = 0; i < spells; i++)
        {   man[who].spell[i] = 1;
        }
        writegadgets();
    acase GID_MM_BU23:
        readgadgets();
        for (i = 0; i < spells; i++)
        {   man[who].spell[i] = 0;
        }
        writegadgets();
    acase GID_MM_BU24:
        awardswindow();
    acase GID_MM_BU25:
        skillswindow();
    acase GID_MM_CH2:
        readgadgets();
        changespelllist();
    acase GID_MM_ST1:
        DISCARD GetAttr(STRINGA_TextVal, (Object*) gadgets[GID_MM_ST1], (ULONG*) &stringptr);
        strcpy(man[who].name, stringptr);
        if (game == GAME_MM2 && strlen(man[who].name) > 10)
        {   man[who].name[10] = EOS;
            DISCARD SetGadgetAttrs
            (   gadgets[GID_MM_ST1], MainWindowPtr, NULL,
                STRINGA_TextVal, man[who].name,
            TAG_END); // this autorefreshes
        }
    adefault:
        if (gid >= GID_MM_BU2 && gid <= GID_MM_BU19)
        {   whichitem = gid - GID_MM_BU2;
            itemwindow();
}   }   }

EXPORT FLAG mm_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if (gamesize == 8320)
        {   game = GAME_MM2;
        } else
        {   game = GAME_MM3;
        }

        serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}
MODULE void writegadgets(void)
{   if
    (   page != FUNC_MM
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   TRANSIENT int          i;
    TRANSIENT ULONG        temp;
    TRANSIENT STRPTR       stringptr;
    TRANSIENT struct Node* NodePtr;
    PERSIST   TEXT         itemtext[18][100 + 1];

    either_in(GID_MM_IN6, &men);

    if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(STRINGA_TextVal, (Object*) gadgets[GID_MM_ST1], (ULONG*) &stringptr);
        strcpy(man[who].name, stringptr);
        if (game == GAME_MM2 && strlen(man[who].name) > 10)
        {   man[who].name[10] = EOS;
            DISCARD SetGadgetAttrs
            (   gadgets[GID_MM_ST1], MainWindowPtr, NULL,
                STRINGA_TextVal, man[who].name,
            TAG_END); // this autorefreshes
        }

        man[who].status = 0;
        for (i = 0; i < 8; i++)
        {   DISCARD GetAttr(GA_Selected, (Object*) gadgets[GID_MM_CB1 + i], &temp);
            if (temp)
            {   man[who].status |= 1 << i;
        }   }

        i = 0;
        for
        (   NodePtr = SpellsList.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   DISCARD GetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (ULONG *) &man[who].spell[i]);
            i++;
    }   }
    else
    {   // assert(gadmode == SERIALIZE_WRITE);

        either_ch(GID_MM_CH6, &game);

        who++;
        either_in(GID_MM_IN5, &who            );
        who--;

        DISCARD SetGadgetAttrs
        (   gadgets[GID_MM_ST1], MainWindowPtr, NULL,
            STRINGA_TextVal, man[who].name,
        TAG_END); // this autorefreshes

        for (i = 0; i < 8; i++)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_MM_CB1 + i], MainWindowPtr, NULL,
                GA_Selected, (man[who].status & (1 << i)) ? TRUE : FALSE,
            TAG_END);
            RefreshGadgets((struct Gadget*) gadgets[GID_MM_CB1 + i], MainWindowPtr, NULL);
        }

        if (game == GAME_MM2)
        {   for (i = 0; i < 12; i++)
            {   DISCARD SetGadgetAttrs
                (   gadgets[GID_MM_BU2 + i], MainWindowPtr, NULL,
                    GA_Text, MM2ItemNames[man[who].item[i]],
                TAG_DONE); // this refreshes automatically
            }
            for (i = 12; i < 18; i++)
            {   DISCARD SetGadgetAttrs
                (   gadgets[GID_MM_BU2 + i], MainWindowPtr, NULL,
                    GA_Text, "-",
                TAG_DONE); // this refreshes automatically
        }   }
        else
        {   // assert(game == GAME_MM3);

            for (i = 0; i < 18; i++)
            {   if (!man[who].adj1[i] && !man[who].adj2[i] && !man[who].adj3[i] && !man[who].item[i] && !man[who].adj4[i])
                {   strcpy(itemtext[i], "-");
                } else
                {   itemtext[i][0] = EOS;
                    if (man[who].adj1[i])
                    {   strcat(itemtext[i], Adj1Names[man[who].adj1[i]]);
                        strcat(itemtext[i], " ");
                    }
                    if (man[who].adj2[i])
                    {   strcat(itemtext[i], Adj2Names[man[who].adj2[i]]);
                        strcat(itemtext[i], " ");
                    }
                    if (man[who].adj3[i])
                    {   strcat(itemtext[i], Adj3Names[man[who].adj3[i]]);
                        strcat(itemtext[i], " ");
                    }
                    strcat(itemtext[i], MM3ItemNames[man[who].item[i]]);
                    if (man[who].adj3[i])
                    {   strcat(itemtext[i], " ");
                        strcat(itemtext[i], Adj4Names[man[who].adj4[i]]);
                }   }
                DISCARD SetGadgetAttrs
                (   gadgets[GID_MM_BU2 + i], MainWindowPtr, NULL,
                    GA_Text, itemtext[i],
                TAG_DONE); // this refreshes automatically
        }   }

        DISCARD SetGadgetAttrs(gadgets[GID_MM_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, ~0,                  TAG_END);
        i = 0;
        for
        (   NodePtr = SpellsList.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (BOOL) man[who].spell[i], TAG_END);
            i++;
        }
        DISCARD SetGadgetAttrs(gadgets[GID_MM_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, (ULONG) &SpellsList, TAG_END);
        RefreshGadgets((struct Gadget *) gadgets[GID_MM_LB1], MainWindowPtr, NULL);

        for (i = 0; i < 6; i++)
        {   ghost(   GID_MM_BU14 + i, game != GAME_MM3); // 13th..18th item slots
        }
        for (i = 0; i < 8; i++)
        {   ghost_st(GID_MM_CB1  + i, game != GAME_MM2); // condition
        }
        ghost(GID_MM_CH4,  game != GAME_MM2); // city
        ghost(GID_MM_IN2,  game != GAME_MM2); // max hp
        ghost(GID_MM_IN4,  game != GAME_MM2); // max sp
        ghost(GID_MM_IN8,  game != GAME_MM2); // xp
        ghost(GID_MM_IN9,  game != GAME_MM2); // gp
        ghost(GID_MM_IN11, game != GAME_MM2); // max str
        ghost(GID_MM_IN13, game != GAME_MM2); // max iq
        ghost(GID_MM_IN15, game != GAME_MM2); // max pers
        ghost(GID_MM_IN19, game != GAME_MM2); // max spd
        ghost(GID_MM_IN21, game != GAME_MM2); // max acc
        ghost(GID_MM_IN23, game != GAME_MM2); // max lk
        ghost(GID_MM_IN29, game != GAME_MM2); // sleep resistance
        ghost(GID_MM_IN31, game != GAME_MM2); // acid  resistance
        ghost(GID_MM_IN32, game != GAME_MM2); // cur spell level
        ghost(GID_MM_IN33, game != GAME_MM2); // max spell level
        ghost(GID_MM_IN34, game != GAME_MM2); // food
        ghost(GID_MM_IN35, game != GAME_MM2); // age
        ghost(GID_MM_IN36, game != GAME_MM2); // gems
        ghost(GID_MM_IN37, game != GAME_MM2); // armour class
        ghost(GID_MM_IN17, game != GAME_MM2); // max end
        ghost(GID_MM_IN38, game != GAME_MM3); // birth year
        ghost(GID_MM_IN39, game != GAME_MM3); // party gems
        ghost(GID_MM_IN40, game != GAME_MM3); // party gp
        ghost(GID_MM_IN41, game != GAME_MM3); // party food
        ghost(GID_MM_BU24, game != GAME_MM3); // awards...

        if (game == GAME_MM2)
        {   ClassOptions = (STRPTR*) &MM2ClassOptions;
        } else
        {   ClassOptions = (STRPTR*) &MM3ClassOptions;
        }
        DISCARD SetGadgetAttrs
        (   gadgets[GID_MM_CH2], MainWindowPtr, NULL,
            CHOOSER_LabelArray, ClassOptions,
        TAG_END);
    }

    either_ch(GID_MM_CH1,  &man[who].race     );
    either_ch(GID_MM_CH2,  &man[who].theclass );
    either_ch(GID_MM_CH3,  &man[who].sex      );
    either_ch(GID_MM_CH4,  &man[who].city     );
    either_ch(GID_MM_CH5,  &man[who].alignment);

    either_in(GID_MM_IN1,  &man[who].curhp    );
    either_in(GID_MM_IN2,  &man[who].maxhp    );
    either_in(GID_MM_IN3,  &man[who].cursp    );
    either_in(GID_MM_IN4,  &man[who].maxsp    );
    either_in(GID_MM_IN7,  &man[who].level    );
    either_in(GID_MM_IN8,  &man[who].xp       );
    either_in(GID_MM_IN9,  &man[who].gp       );
    either_in(GID_MM_IN10, &man[who].cur_str  );
    either_in(GID_MM_IN11, &man[who].max_str  );
    either_in(GID_MM_IN12, &man[who].cur_iq   );
    either_in(GID_MM_IN13, &man[who].max_iq   );
    either_in(GID_MM_IN14, &man[who].cur_pers );
    either_in(GID_MM_IN15, &man[who].max_pers );
    either_in(GID_MM_IN16, &man[who].cur_end  );
    either_in(GID_MM_IN17, &man[who].max_end  );
    either_in(GID_MM_IN18, &man[who].cur_speed);
    either_in(GID_MM_IN19, &man[who].max_speed);
    either_in(GID_MM_IN20, &man[who].cur_accuracy);
    either_in(GID_MM_IN21, &man[who].max_accuracy);
    either_in(GID_MM_IN22, &man[who].cur_luck );
    either_in(GID_MM_IN23, &man[who].max_luck );
    either_in(GID_MM_IN24, &man[who].mr       );
    either_in(GID_MM_IN25, &man[who].fire     );
    either_in(GID_MM_IN26, &man[who].elec     );
    either_in(GID_MM_IN27, &man[who].cold     );
    either_in(GID_MM_IN28, &man[who].energy   );
    either_in(GID_MM_IN29, &man[who].sleep    );
    either_in(GID_MM_IN30, &man[who].poison   );
    either_in(GID_MM_IN31, &man[who].acid     );
    either_in(GID_MM_IN32, &man[who].cur_spelllevel);
    either_in(GID_MM_IN33, &man[who].max_spelllevel);
    either_in(GID_MM_IN34, &man[who].food     );
    either_in(GID_MM_IN35, &man[who].age      );
    either_in(GID_MM_IN36, &man[who].gems     );
    either_in(GID_MM_IN37, &man[who].armourclass);
    either_in(GID_MM_IN38, &man[who].birthyear);

    if (gadmode == SERIALIZE_READ)
    {   either_in(GID_MM_IN5, &who            );
        who--;
    }

    changespelllist();

    if (game == GAME_MM2 && man[who].theclass != 3 && man[who].theclass != 4)
    {   DISCARD SetGadgetAttrs(gadgets[GID_MM_LB1 ], MainWindowPtr, NULL, GA_Disabled, TRUE , TAG_END);
        DISCARD SetGadgetAttrs(gadgets[GID_MM_BU21], MainWindowPtr, NULL, GA_Disabled, TRUE , TAG_END);
        DISCARD SetGadgetAttrs(gadgets[GID_MM_BU22], MainWindowPtr, NULL, GA_Disabled, TRUE , TAG_END);
        DISCARD SetGadgetAttrs(gadgets[GID_MM_BU23], MainWindowPtr, NULL, GA_Disabled, TRUE , TAG_END);
    } else
    {   DISCARD SetGadgetAttrs(gadgets[GID_MM_LB1 ], MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_END);
        DISCARD SetGadgetAttrs(gadgets[GID_MM_BU21], MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_END);
        DISCARD SetGadgetAttrs(gadgets[GID_MM_BU22], MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_END);
        DISCARD SetGadgetAttrs(gadgets[GID_MM_BU23], MainWindowPtr, NULL, GA_Disabled, FALSE, TAG_END);
    }
    RefreshGadgets((struct Gadget *) gadgets[GID_MM_LB1], MainWindowPtr, NULL); // this might autorefresh

    either_in(GID_MM_IN39, &gems              );
    either_in(GID_MM_IN40, &gp                );
    either_in(GID_MM_IN41, &food              );
}

MODULE void serialize(void)
{   int   i, j, k,
          length;
    TEXT  tempstring[10 + 1];
    ULONG temp;


    switch (game)
    {
    case GAME_MM2:
        offset =  0;
        men    = 48;
        spells = 96;

        for (i = 0; i < (int) men; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   zstrncpy(man[i].name, (char*) &IOBuffer[offset], 10);
                for (j = 9; j >= 0; j--)
                {   if (man[i].name[j] == ' ')
                    {   man[i].name[j] = EOS;
                    } else
                    {   break;
            }   }   }
            else
            {   // assert(serializemode == SERIALIZE_WRITE);
                strcpy(tempstring, man[i].name);
                length = strlen(tempstring);
                if (length < 10)
                {   for (j = length; j <= 9; j++)
                    {   tempstring[j] = ' ';
                }   }
                tempstring[10] = EOS;
                strcpy((char*) &IOBuffer[offset], tempstring);
            }
            offset += 11;                                   //   0.. 10

            if (serializemode == SERIALIZE_READ)
            {   serialize1(&man[i].city    );               //  11
                man[i].city--;
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                man[i].city++;
                serialize1(&man[i].city    );
                man[i].city--;
            }
            serialize1(&man[i].sex         );               //  12
            serialize1(&man[i].alignment   );               //  13
            serialize1(&man[i].race        );               //  14
            serialize1(&man[i].theclass    );               //  15
            serialize1(&man[i].max_str     );               //  16
            serialize1(&man[i].max_iq      );               //  17
            serialize1(&man[i].max_pers    );               //  18
            serialize1(&man[i].max_speed   );               //  19
            serialize1(&man[i].max_accuracy);               //  20
            serialize1(&man[i].max_luck    );               //  21
            serialize1(&man[i].mr          );               //  22
            serialize1(&man[i].fire        );               //  23
            serialize1(&man[i].elec        );               //  24
            serialize1(&man[i].cold        );               //  25
            serialize1(&man[i].energy      );               //  26
            serialize1(&man[i].sleep       );               //  27
            serialize1(&man[i].poison      );               //  28
            serialize1(&man[i].acid        );               //  29
            serialize1(&man[i].thievery    );               //  30
            offset += 2;                                    //  31.. 32
            serialize1(&man[i].age         );               //  33
            offset++;                                       //  34
            serialize1(&man[i].max_spelllevel);             //  35
            serialize1(&man[i].armourclass );               //  36
            serialize1(&man[i].food        );               //  37
            serialize1(&man[i].status      );               //  38
            serialize1(&man[i].max_end     );               //  39
            for (j = 0; j < 6; j++)
            {   serialize1(&man[i].item[j]);                //  40.. 45
            }
            for (j = 0; j < 6; j++)
            {   serialize1(&man[i].charges[j]);             //  46.. 51
            }
            for (j = 0; j < 6; j++)
            {   serialize1(&man[i].plus[j]);                //  52.. 57
            }
            for (j = 6; j < 12; j++)
            {   serialize1(&man[i].item[j]);                //  58.. 63
            }
            for (j = 6; j < 12; j++)
            {   serialize1(&man[i].charges[j]);             //  64.. 69
            }
            for (j = 6; j < 12; j++)
            {   serialize1(&man[i].plus[j]);                //  70.. 75
            }
            offset += 4;                                    //  76.. 79
            if (serializemode == SERIALIZE_READ)
            {   serialize1(&temp);                          //  80
                man[i].skill[0] = (temp & 0xF0) >> 4;
                man[i].skill[1] =  temp & 0x0F      ;

                for (j = 0; j < 6; j++)
                {   serialize1(&temp);                      //  81.. 86
                    for (k = 0; k < 8; k++)
                    {   if (temp & (128 >> k))
                        {   man[i].spell[(j * 8) + k] = 1;
                        } else
                        {   man[i].spell[(j * 8) + k] = 0;
            }   }   }   }
            else
            {   // assert(serializemode == SERIALIZE_WRITE);
                temp = (man[i].skill[0] << 4)
                     +  man[i].skill[1];
                serialize1(&temp);

                for (j = 0; j < 6; j++)
                {   temp = 0;
                    for (k = 0; k < 8; k++)
                    {   if (man[i].spell[(j * 8) + k])
                        {   temp |= 128 >> k;
                    }   }
                    serialize1(&temp);
            }   }
            offset++;                                       //  87
            serialize2ilong(&man[i].cursp);                 //  88.. 89
            serialize2ilong(&man[i].maxsp);                 //  90.. 91
            serialize2ilong(&man[i].gems);                  //  92.. 93
            serialize2ilong(&man[i].curhp);                 //  94.. 95
            serialize2ilong(&man[i].maxhp);                 //  96.. 97
            serialize4i(&man[i].xp);                        //  98..101
            serialize4i(&man[i].gp);                        // 102..105
            offset++;                                       // 106
            serialize1(&man[i].cur_str);                    // 107
            serialize1(&man[i].cur_iq);                     // 108
            serialize1(&man[i].cur_pers);                   // 109
            serialize1(&man[i].cur_speed);                  // 110
            serialize1(&man[i].cur_accuracy);               // 111
            serialize1(&man[i].cur_luck);                   // 112
            serialize1(&man[i].level);                      // 113
            serialize1(&man[i].cur_spelllevel);             // 114
            serialize1(&man[i].cur_end);                    // 115
            offset += 14;                                   // 116..129
        }
    acase GAME_MM3:
        men    = 30;
        spells = 36;

        for (i = 0; i < 30; i++)
        {   offset = 0x98B + (304 * i);
            if (serializemode == SERIALIZE_READ)
            {   zstrncpy(man[i].name, (char*) &IOBuffer[offset], 16);
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                strncpy((char*) &IOBuffer[offset], man[i].name, 16);
                // *not* zstrncpy() because we don't want to NUL-terminate it!
            }

            offset = 0x99B + (304 * i);
            serialize1(&man[i].sex);                        // $99B
            serialize1(&man[i].race);                       // $99C
            serialize1(&man[i].alignment);                  // $99D
            serialize1(&man[i].theclass);                   // $99E
            serialize1(&man[i].cur_str);                    // $99F
            offset = 0x9A1 + (304 * i);
            serialize1(&man[i].cur_iq);
            offset = 0x9A3 + (304 * i);
            serialize1(&man[i].cur_pers);
            offset = 0x9A5 + (304 * i);
            serialize1(&man[i].cur_end);
            offset = 0x9A7 + (304 * i);
            serialize1(&man[i].cur_speed);
            offset = 0x9A9 + (304 * i);
            serialize1(&man[i].cur_accuracy);
            offset = 0x9AB + (304 * i);
            serialize1(&man[i].cur_luck);

            offset = 0x9B2 + (304 * i);
            for (j = 0; j < 18; j++)
            {   serialize1(&man[i].skill[j]);
            }

            offset = 0x9C4 + (304 * i);
            serialize1(&man[i].awardflag[ 0]);              // $9C4
            serialize1(&man[i].awardflag[ 1]);              // $9C5
            serialize1(&man[i].awardflag[ 2]);              // $9C6
            serialize1(&man[i].awardflag[ 3]);              // $9C7
            serialize1(&man[i].awardflag[ 4]);              // $9C8
            serialize1(&man[i].awardflag[ 5]);              // $9C9
            serialize1(&man[i].awardflag[ 6]);              // $9CA
            serialize1(&man[i].awardnum[  7]);              // $9CB
            serialize1(&man[i].awardnum[  9]);              // $9CC
            serialize1(&man[i].awardnum[  8]);              // $9CD
            offset++;                                       // $9CE
            serialize1(&man[i].awardnum[  4]);              // $9CF
            serialize1(&man[i].awardnum[  5]);              // $9D0
            serialize1(&man[i].awardnum[  6]);              // $9D1
            serialize1(&man[i].awardnum[  2]);              // $9D2
            serialize1(&man[i].awardflag[ 9]);              // $9D3
            serialize1(&man[i].awardflag[10]);              // $9D4
            serialize1(&man[i].awardflag[11]);              // $9D5
            serialize1(&man[i].awardnum[  1]);              // $9D6
            serialize1(&man[i].awardflag[ 8]);              // $9D7
            serialize1(&man[i].awardflag[ 7]);              // $9D8
            serialize1(&man[i].awardnum[  0]);              // $9D9
            serialize1(&man[i].awardnum[  3]);              // $9DA
            serialize1(&man[i].awardflag[12]);              // $9DB

            offset = 0x9DE + (304 * i);
            for (j = 0; j < 36; j++)
            {   serialize1(&man[i].spell[j]);
            }

            offset = 0xA1B + (304 * i);
            for (j = 0; j < 18; j++)
            {   serialize1(&man[i].charges[j]);
            }

            offset = 0xA2E + (304 * i);
            for (j = 0; j < 18; j++)
            {   serialize1(&man[i].adj1[j]);
            }

            offset = 0xA41 + (304 * i);
            for (j = 0; j < 18; j++)
            {   serialize1(&man[i].adj2[j]);
            }

            offset = 0xA54 + (304 * i);
            for (j = 0; j < 18; j++)
            {   serialize1(&man[i].adj3[j]);
            }

            offset = 0xA67 + (304 * i);
            for (j = 0; j < 18; j++)
            {   serialize1(&man[i].item[j]);
            }

            offset = 0xA7A + (304 * i);
            for (j = 0; j < 18; j++)
            {   serialize1(&man[i].adj4[j]);
            }

            offset = 0xA92 + (304 * i);
            serialize1(&man[i].fire);
            offset = 0xA94 + (304 * i);
            serialize1(&man[i].cold);
            offset = 0xA96 + (304 * i);
            serialize1(&man[i].elec);
            offset = 0xA98 + (304 * i);
            serialize1(&man[i].poison);
            offset = 0xA9A + (304 * i);
            serialize1(&man[i].energy);
            offset = 0xA9C + (304 * i);
            serialize1(&man[i].mr);

            offset = 0xAB1;
            serialize2ulong(&man[i].curhp);                 //  $AB1.. $AB2
            serialize2ulong(&man[i].cursp);                 //  $AB3.. $AB4
            serialize2ulong(&man[i].birthyear);             //  $AB5.. $AB6
        }

        offset = 0x3085;
        serialize2ulong(&food);                             // $3085..$3086
        offset = 0x3095;
        serialize4(&gp);                                    // $3095..$3098
        offset = 0x3099;
        serialize4(&gems);                                  // $3099..$309C
    }

    if (who >= men)
    {   who = men - 1;
}   }

EXPORT void mm_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  GAME_MM2: gamesave("#?ROSTER.DAT#?", "Might & Magic 2", saveas, 8320,     FLAG_S, FALSE);
    acase GAME_MM3: gamesave("SAVE??.MM3",     "Might & Magic 3", saveas, gamesize, FLAG_S, FALSE);
}   }

MODULE void changespelllist(void)
{   TRANSIENT       int          i;
    TRANSIENT       struct Node* NodePtr;
    PERSIST         int          currently     = 0,
                                 currentgame   = -1;
    PERSIST   const int          spelltype[10] =
    { 0, // knight
      3, // paladin (cleric)
      4, // archer (sorcerer)
      3, // cleric
      4, // sorcerer
      0, // robber
      0, // ninja
      0, // barbarian
      8, // druid
      8  // ranger (druid)
    };

    if (currentgame != (int) game)
    {   currentgame = (int) game;
        currently = -1; // force a refresh
    }

    if (game == GAME_MM2)
    {   if
        (   (currently == 0 && man[who].theclass != 3 && man[who].theclass != 4)
         || (currently == 3 && man[who].theclass == 3)
         || (currently == 4 && man[who].theclass == 4)
        )
        {   return;
        }
        if (man[who].theclass == 3 || man[who].theclass == 4)
        {   currently = man[who].theclass;
        } else
        {   currently = 0;
    }   }
    else
    {   // assert(game == GAME_MM3);

        if (currently == spelltype[man[who].theclass])
        {   return;
        }
        currently = spelltype[man[who].theclass];
    }

    if (MainWindowPtr)
    {   DISCARD SetGadgetAttrs(gadgets[GID_MM_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, ~0, TAG_END);
    }

    lb_clearlist(&SpellsList);

    if (game == GAME_MM2)
    {   if (man[who].theclass == 3) // cleric
        {   for (i = 0; i < 48; i++)
            {   NodePtr = (struct Node *) AllocListBrowserNode
                (   1,
                    LBNCA_Text,    SpellNames[i],
                    LBNA_CheckBox, TRUE,
                TAG_END);
                // we should check NodePtr is non-zero
                AddTail(&SpellsList, (struct Node *) NodePtr);
        }   }
        elif (man[who].theclass == 4) // sorcerer
        {   for (i = 48; i < 96; i++)
            {   NodePtr = (struct Node *) AllocListBrowserNode
                (   1,
                    LBNCA_Text,    SpellNames[i],
                    LBNA_CheckBox, TRUE,
                TAG_END);
                // we should check NodePtr is non-zero
                AddTail(&SpellsList, (struct Node *) NodePtr);
    }   }   }
    else
    {   // assert(game == GAME_MM3);

        switch (currently)
        {
        case 3: // cleric
            for (i = 0; i < 36; i++)
            {   NodePtr = (struct Node*) AllocListBrowserNode
                (   1,
                    LBNCA_Text,    ClericSpellNames[i],
                    LBNA_CheckBox, TRUE,
                TAG_END);
                // we should check NodePtr is non-zero
                AddTail(&SpellsList, (struct Node*) NodePtr);
            }
        acase 4: // sorcerer
            for (i = 0; i < 36; i++)
            {   NodePtr = (struct Node*) AllocListBrowserNode
                (   1,
                    LBNCA_Text,    SorcererSpellNames[i],
                    LBNA_CheckBox, TRUE,
                TAG_END);
                // we should check NodePtr is non-zero
                AddTail(&SpellsList, (struct Node*) NodePtr);
            }
        acase 8: // druid
            for (i = 0; i < 29; i++)
            {   NodePtr = (struct Node*) AllocListBrowserNode
                (   1,
                    LBNCA_Text,    DruidSpellNames[i],
                    LBNA_CheckBox, TRUE,
                TAG_END);
                // we should check NodePtr is non-zero
                AddTail(&SpellsList, (struct Node*) NodePtr);
    }   }   }

    i = 0;
    for
    (   NodePtr = SpellsList.lh_Head;
        NodePtr->ln_Succ;
        NodePtr = NodePtr->ln_Succ
    )
    {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (BOOL) man[who].spell[i], TAG_END);
        i++;
    }

    if (MainWindowPtr)
    {   DISCARD SetGadgetAttrs(gadgets[GID_MM_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, &SpellsList, TAG_END);
        RefreshGadgets((struct Gadget *) gadgets[GID_MM_LB1], MainWindowPtr, NULL);
}   }

EXPORT void mm_exit(void)
{   lb_clearlist(&SpellsList);
    ch_clearlist(&SexList);
}
EXPORT void mm_die(void)
{   lb_clearlist(&Adj1List);
    lb_clearlist(&Adj2List);
    lb_clearlist(&Adj3List);
    lb_clearlist(&Adj4List);
}

EXPORT void mm_close(void) { ; }

MODULE void maximize_man(int whichman)
{   int i;

    man[whichman].status         =           0;
    man[whichman].cur_spelllevel =
    man[whichman].max_spelllevel =           9;
    man[whichman].age            =          18;
    man[whichman].food           =
    man[whichman].thievery       =
    man[whichman].level          =
    man[whichman].armourclass    =
    man[whichman].mr             =
    man[whichman].fire           =
    man[whichman].elec           =
    man[whichman].cold           =
    man[whichman].energy         =
    man[whichman].sleep          =
    man[whichman].poison         =
    man[whichman].acid           =
    man[whichman].cur_str        =
    man[whichman].cur_iq         =
    man[whichman].cur_pers       =
    man[whichman].cur_end        =
    man[whichman].cur_speed      =
    man[whichman].cur_accuracy   =
    man[whichman].cur_luck       =
    man[whichman].max_str        =
    man[whichman].max_iq         =
    man[whichman].max_pers       =
    man[whichman].max_end        =
    man[whichman].max_speed      =
    man[whichman].max_accuracy   =
    man[whichman].max_luck       =         250;
    man[whichman].curhp          =
    man[whichman].maxhp          =
    man[whichman].cursp          =
    man[whichman].maxsp          =
    man[whichman].gems           =       65000;
    man[whichman].gp             =
    man[whichman].xp             = ONE_BILLION;

    switch (game)
    {
    case GAME_MM2:
        for (i = 0; i < 96; i++)
        {   man[whichman].spell[i] = 1;
        }
    acase GAME_MM3:
        for (i = 0; i < 18; i++)
        {   man[whichman].skill[i] = 1;
        }
        for (i = 0; i < 36; i++)
        {   man[whichman].spell[i] = 1;
        }
        for (i = 0; i < 13; i++)
        {   man[whichman].awardflag[i] = 1;
        }
        for (i = 0; i < 10; i++)
        {   man[whichman].awardnum[i] = 250;
    }   }

    // we should maybe do items too (at least charges)
}

MODULE void itemwindow(void)
{   struct List ItemsList;

    submode = 0;

    readgadgets();

    NewList(&ItemsList);

    switch (game)
    {
    case GAME_MM2:
        lb_makelist(&ItemsList, MM2ItemNames, 256);

        InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
        lockscreen();

        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                                  "Choose Item",
            WA_SizeGadget,                             TRUE,
            WA_ThinSizeGadget,                         TRUE,
            WINDOW_Position,                           WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                           "mm-1",
            WINDOW_ParentGroup,                        gadgets[GID_MM_LY2] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_AddChild,                       gadgets[GID_MM_LB2] = (struct Gadget*)
                ListBrowserObject,
                    GA_ID,                             GID_MM_LB2,
                    GA_RelVerify,                      TRUE,
                    GA_TabCycle,                       TRUE,
                    LISTBROWSER_Labels,                (ULONG) &ItemsList,
                    LISTBROWSER_MinVisible,            1,
                    LISTBROWSER_ShowSelected,          TRUE,
                    LISTBROWSER_AutoWheel,             FALSE,
                ListBrowserEnd,
                CHILD_MinWidth,                        160,
                CHILD_MinHeight,                       384,
                AddHLayout,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    LAYOUT_AddChild,                   gadgets[GID_MM_IN43] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_MM_IN43,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               255,
                        INTEGER_Number,                man[who].charges[whichitem],
                        INTEGER_MinVisible,            3 + 1,
                    IntegerEnd,
                    Label("Charges:"),
                    LAYOUT_AddChild,                   gadgets[GID_MM_IN44] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_MM_IN44,
                        GA_TabCycle,                   TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               63,
                        INTEGER_Number,                man[who].plus[whichitem],
                        INTEGER_MinVisible,            2 + 1,
                    IntegerEnd,
                    Label("+:"),
                LayoutEnd,
                CHILD_WeightedHeight,                  0,
            LayoutEnd,
        WindowEnd))
        {   lb_clearlist(&ItemsList);
            rq("Can't create gadgets!");
        }
    acase GAME_MM3:
        lb_makelist(&ItemsList, MM3ItemNames, 104 + 1);

        InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
        lockscreen();

        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                                  "Choose Item",
            WA_SizeGadget,                             TRUE,
            WA_ThinSizeGadget,                         TRUE,
            WINDOW_Position,                           WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                           "mm-2",
            WINDOW_ParentGroup,                        gadgets[GID_MM_LY2] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                     TRUE,
                AddHLayout,
                    LAYOUT_AddChild,                   gadgets[GID_MM_LB4] = (struct Gadget*)
                    ListBrowserObject,
                        GA_ID,                         GID_MM_LB4,
                        GA_RelVerify,                  TRUE,
                        LISTBROWSER_Labels,            (ULONG) &Adj1List,
                        LISTBROWSER_MinVisible,        1,
                        LISTBROWSER_ShowSelected,      TRUE,
                        LISTBROWSER_AutoWheel,         FALSE,
                    ListBrowserEnd,
                    CHILD_MinWidth,                    128,
                    CHILD_MinHeight,                   384 - 72,
                    LAYOUT_AddChild,                   gadgets[GID_MM_LB3] = (struct Gadget*)
                    ListBrowserObject,
                        GA_ID,                         GID_MM_LB3,
                        GA_RelVerify,                  TRUE,
                        LISTBROWSER_Labels,            (ULONG) &Adj2List,
                        LISTBROWSER_MinVisible,        1,
                        LISTBROWSER_ShowSelected,      TRUE,
                        LISTBROWSER_AutoWheel,         FALSE,
                    ListBrowserEnd,
                    CHILD_MinWidth,                    128,
                    CHILD_MinHeight,                   384 - 72,
                    LAYOUT_AddChild,                   gadgets[GID_MM_LB5] = (struct Gadget*)
                    ListBrowserObject,
                        GA_ID,                         GID_MM_LB5,
                        GA_RelVerify,                  TRUE,
                        LISTBROWSER_Labels,            (ULONG) &Adj3List,
                        LISTBROWSER_MinVisible,        1,
                        LISTBROWSER_ShowSelected,      TRUE,
                        LISTBROWSER_AutoWheel,         FALSE,
                    ListBrowserEnd,
                    CHILD_MinWidth,                    128,
                    CHILD_MinHeight,                   384 - 72,
                    LAYOUT_AddChild,                   gadgets[GID_MM_LB2] = (struct Gadget*)
                    ListBrowserObject,
                        GA_ID,                         GID_MM_LB2,
                        GA_RelVerify,                  TRUE,
                        LISTBROWSER_Labels,            (ULONG) &ItemsList,
                        LISTBROWSER_MinVisible,        1,
                        LISTBROWSER_ShowSelected,      TRUE,
                        LISTBROWSER_AutoWheel,         FALSE,
                    ListBrowserEnd,
                    CHILD_MinWidth,                    128,
                    CHILD_MinHeight,                   384 - 72,
                    LAYOUT_AddChild,                   gadgets[GID_MM_LB6] = (struct Gadget*)
                    ListBrowserObject,
                        GA_ID,                         GID_MM_LB6,
                        GA_RelVerify,                  TRUE,
                        LISTBROWSER_Labels,            (ULONG) &Adj4List,
                        LISTBROWSER_MinVisible,        1,
                        LISTBROWSER_ShowSelected,      TRUE,
                        LISTBROWSER_AutoWheel,         FALSE,
                    ListBrowserEnd,
                    CHILD_MinWidth,                    128,
                    CHILD_MinHeight,                   384 - 72,
                LayoutEnd,
                LAYOUT_AddChild,                       gadgets[GID_MM_IN43] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                             GID_MM_IN43,
                    INTEGER_Minimum,                   0,
                    INTEGER_Maximum,                   255,
                    INTEGER_Number,                    man[who].charges[whichitem],
                    INTEGER_MinVisible,                3 + 1,
                IntegerEnd,
                Label("Charges:"),
                CHILD_WeightedHeight,                  0,
           LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
    }   }
    
    unlockscreen();
    if (!(SubWindowPtr = (struct Window *) RA_OpenWindow(SubWinObject)))
    {   lb_clearlist(&ItemsList);
        rq("Can't open window!");
    }
#ifdef MEASUREWINDOWS
    printf(" %d×%d\n", SubWindowPtr->Width, SubWindowPtr->Height);
#endif

    DISCARD SetGadgetAttrs(          gadgets[GID_MM_LB2], SubWindowPtr, NULL, LISTBROWSER_Labels,              ~0,                       TAG_END);
    DISCARD SetGadgetAttrs(          gadgets[GID_MM_LB2], SubWindowPtr, NULL, LISTBROWSER_Labels,              &ItemsList,               TAG_END);
    DISCARD SetGadgetAttrs(          gadgets[GID_MM_LB2], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man[who].item[whichitem], TAG_END);
    RefreshGadgets((struct Gadget *) gadgets[GID_MM_LB2], SubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(          gadgets[GID_MM_LB2], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man[who].item[whichitem], TAG_END);
    RefreshGadgets((struct Gadget *) gadgets[GID_MM_LB2], SubWindowPtr, NULL);

    if (game == GAME_MM3)
    {   DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB3], SubWindowPtr, NULL, LISTBROWSER_Labels,              ~0,                           TAG_END);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB3], SubWindowPtr, NULL, LISTBROWSER_Labels,              &Adj2List,                    TAG_END);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB3], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man[who].adj2[whichitem],     TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_MM_LB3], SubWindowPtr, NULL);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB3], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man[who].adj2[whichitem],     TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_MM_LB3], SubWindowPtr, NULL);

        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB4], SubWindowPtr, NULL, LISTBROWSER_Labels,              ~0,                           TAG_END);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB4], SubWindowPtr, NULL, LISTBROWSER_Labels,              &Adj1List,                    TAG_END);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB4], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man[who].adj1[whichitem],     TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_MM_LB4], SubWindowPtr, NULL);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB4], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man[who].adj1[whichitem],     TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_MM_LB4], SubWindowPtr, NULL);

        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB5], SubWindowPtr, NULL, LISTBROWSER_Labels,              ~0,                           TAG_END);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB5], SubWindowPtr, NULL, LISTBROWSER_Labels,              &Adj3List,                    TAG_END);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB5], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man[who].adj3[whichitem],     TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_MM_LB5], SubWindowPtr, NULL);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB5], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man[who].adj3[whichitem],     TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_MM_LB5], SubWindowPtr, NULL);

        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB6], SubWindowPtr, NULL, LISTBROWSER_Labels,              ~0,                           TAG_END);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB6], SubWindowPtr, NULL, LISTBROWSER_Labels,              &Adj4List,                    TAG_END);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB6], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man[who].adj4[whichitem],     TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_MM_LB6], SubWindowPtr, NULL);
        DISCARD SetGadgetAttrs(         gadgets[GID_MM_LB6], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man[who].adj4[whichitem],     TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_MM_LB6], SubWindowPtr, NULL);

        DISCARD ActivateLayoutGadget(gadgets[GID_MM_LY2], SubWindowPtr, NULL, (Object) gadgets[GID_MM_IN43]);
    }

    subloop();

    DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_MM_IN43], (ULONG*) &man[who].charges[whichitem]);
    if (game == GAME_MM2)
    {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_MM_IN44], (ULONG*) &man[who].plus[whichitem]);
    }

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;

    lb_clearlist(&ItemsList);
}

EXPORT void mm_key(UBYTE scancode, UWORD qual)
{   switch (scancode)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        lb_scroll_up(GID_MM_LB1, MainWindowPtr, qual);
        writegadgets();
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_scroll_down(GID_MM_LB1, MainWindowPtr, qual);
        writegadgets();
}   }

EXPORT FLAG mm_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_MM_LB2:
        readgadgets();
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_MM_LB2], (ULONG*) &man[who].item[whichitem]);
        writegadgets();
        DISCARD ActivateLayoutGadget(gadgets[GID_MM_LY2], SubWindowPtr, NULL, (Object) gadgets[GID_MM_IN43]);
    acase GID_MM_LB3:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_MM_LB3], (ULONG*) &man[who].adj2[whichitem]);
        writegadgets();
    acase GID_MM_LB4:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_MM_LB4], (ULONG*) &man[who].adj1[whichitem]);
        writegadgets();
    acase GID_MM_LB5:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_MM_LB5], (ULONG*) &man[who].adj3[whichitem]);
        writegadgets();
    acase GID_MM_LB6:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_MM_LB6], (ULONG*) &man[who].adj4[whichitem]);
        writegadgets();
    }

    return FALSE;
}

EXPORT FLAG mm_subkey(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey)
{   switch (scancode)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        if (game == GAME_MM2)
        {   lb_move_up(GID_MM_LB2, SubWindowPtr, qual, &man[who].item[whichitem], 0, 5);
        } else
        {   if (submode == 0)
            {   if     (mouseisover(GID_MM_LB2, mousex, mousey))
                {   lb_move_up(GID_MM_LB2, SubWindowPtr, qual, &man[who].item[whichitem], 0, 5);
                    writegadgets();
                } elif (mouseisover(GID_MM_LB3, mousex, mousey))
                {   lb_move_up(GID_MM_LB3, SubWindowPtr, qual, &man[who].adj2[whichitem], 0, 5);
                    writegadgets();
                } elif (mouseisover(GID_MM_LB4, mousex, mousey))
                {   lb_move_up(GID_MM_LB4, SubWindowPtr, qual, &man[who].adj1[whichitem], 0, 5);
                    writegadgets();
                } elif (mouseisover(GID_MM_LB6, mousex, mousey))
                {   lb_move_up(GID_MM_LB6, SubWindowPtr, qual, &man[who].adj4[whichitem], 0, 5);
                    writegadgets();
                } else
                {   lb_move_up(GID_MM_LB5, SubWindowPtr, qual, &man[who].adj3[whichitem], 0, 5);
                    writegadgets();
        }   }   }
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        if (game == GAME_MM2)
        {   lb_move_down(GID_MM_LB2, SubWindowPtr, qual, &man[who].item[whichitem], 255, 5);
        } else
        {   if (submode == 0)
            {   if     (mouseisover(GID_MM_LB2, mousex, mousey))
                {   lb_move_down(GID_MM_LB2, SubWindowPtr, qual, &man[who].item[whichitem], 104, 5);
                    writegadgets();
                } elif (mouseisover(GID_MM_LB3, mousex, mousey))
                {   lb_move_down(GID_MM_LB3, SubWindowPtr, qual, &man[who].adj2[whichitem],  22, 5);
                    writegadgets();
                } elif (mouseisover(GID_MM_LB4, mousex, mousey))
                {   lb_move_down(GID_MM_LB4, SubWindowPtr, qual, &man[who].adj1[whichitem],  36, 5);
                    writegadgets();
                } elif (mouseisover(GID_MM_LB6, mousex, mousey))
                {   lb_move_down(GID_MM_LB6, SubWindowPtr, qual, &man[who].adj4[whichitem],  75, 5);
                    writegadgets();
                } else
                {   lb_move_down(GID_MM_LB5, SubWindowPtr, qual, &man[who].adj3[whichitem],  72, 5);
                    writegadgets();
    }   }   }   }

    return FALSE;
}

MODULE void awardswindow(void)
{   int i;

    // assert(game == GAME_MM3);

    submode = 1;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              "Choose Awards",
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "mm-3",
        WINDOW_ParentGroup,                    gadgets[GID_MM_LY4] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            AddVLayout,
                AwardFlag( 0, "Raven's Guild Member"),
                AwardFlag( 1, "Albatross Guild Member"),
                AwardFlag( 2, "Falcon's Guild Member"),
                AwardFlag( 3, "Buzzard's Guild Member"),
                AwardFlag( 4, "Eagle's Guild Member"),
                AwardFlag( 5, "Saved Fountain Head"),
                AwardNum(  0, "Arena Wins"),
                AwardFlag( 6, "Blessed by the Forces"),
                AwardNum(  1, "Skulls Given to Kranion"),
                AwardNum(  2, "Shells Given to Athea"),
                AwardNum(  3, "Pearls to Pirate Queen"),
                AwardFlag( 7, "Freed Princess Trueberry"),
            LayoutEnd,
            AddVLayout,
                AwardFlag( 8, "Icarus Resurrected"),
                AwardFlag( 9, "Greek Brothers Visited"),
                AwardFlag(10, "Greywind Released"),
                AwardFlag(11, "Blackwind Released"),
                AwardNum(  4, "Good Artifacts Recovered"),
                AwardNum(  5, "Evil Artifacts Recovered"),
                AwardNum(  6, "Neut Artifacts Recovered"),
                AwardNum(  7, "Orbs Given to Zealot"),
                AwardNum(  8, "Orbs Given to Tumult"),
                AwardNum(  9, "Orbs Given to Malefactor"),
                AddLabel(""),
                AwardFlag(12, "Ultimate Adventurer"),
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

    DISCARD ActivateLayoutGadget(gadgets[GID_MM_LY4], SubWindowPtr, NULL, (Object) gadgets[GID_MM_IN45]);

    subloop();

    for (i = 0; i < 13; i++)
    {   DISCARD GetAttr(GA_Selected,    (Object*) gadgets[GID_MM_CB27 + i], (ULONG*) &man[who].awardflag[i]);
    }
    for (i = 0; i < 10; i++)
    {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_MM_IN45 + i], (ULONG*) &man[who].awardnum[i]);
    }

    DisposeObject(SubWinObject);
    SubWindowPtr = NULL;
    SubWinObject = NULL;
}

MODULE void skillswindow(void)
{   int i;

    submode = 2;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    switch (game)
    {
    case GAME_MM2:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                              "Choose Skills",
            WA_SizeGadget,                         TRUE,
            WA_ThinSizeGadget,                     TRUE,
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                       "mm-4",
            WINDOW_ParentGroup,                    gadgets[GID_MM_LY3] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                LAYOUT_AddChild,                   gadgets[GID_MM_CH7] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                         GID_MM_CH7,
                    CHOOSER_LabelArray,            &MM2SkillOptions,
                    CHOOSER_MaxLabels,             16,
                    CHOOSER_Selected,              (WORD) man[who].skill[0],
                PopUpEnd,
                Label("1st skill:"),
                LAYOUT_AddChild,                   gadgets[GID_MM_CH8] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                         GID_MM_CH8,
                    CHOOSER_LabelArray,            &MM2SkillOptions,
                    CHOOSER_MaxLabels,             16,
                    CHOOSER_Selected,              (WORD) man[who].skill[1],
                PopUpEnd,
                Label("2nd skill:"),
                LAYOUT_AddChild,                   gadgets[GID_MM_IN42] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                         GID_MM_IN42,
                    GA_TabCycle,                   TRUE,
                    INTEGER_Minimum,               0,
                    INTEGER_Number,                man[who].thievery,
                    INTEGER_Maximum,               255,
                    INTEGER_MinVisible,            3 + 1,
                IntegerEnd,
                Label("Thievery:"),
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
        }
    acase GAME_MM3:
        if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                              "Choose Skills",
            WA_SizeGadget,                         TRUE,
            WA_ThinSizeGadget,                     TRUE,
            WINDOW_Position,                       WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                       "mm-5",
            WINDOW_ParentGroup,                    gadgets[GID_MM_LY3] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                 TRUE,
                SkillButton( 0, "Thievery"),
                SkillButton( 1, "Arms Master"),
                SkillButton( 2, "Astrologer"),
                SkillButton( 3, "Body Builder"),
                SkillButton( 4, "Cartographer"),
                SkillButton( 5, "Crusader"),
                SkillButton( 6, "Direction Sense"),
                SkillButton( 7, "Linguist"),
                SkillButton( 8, "Merchant"),
                SkillButton( 9, "Mountaineer"),
                SkillButton(10, "Navigator"),
                SkillButton(11, "Path Finder"),
                SkillButton(12, "Prayer Master"),
                SkillButton(13, "Prestidigitator"),
                SkillButton(14, "Swimmer"),
                SkillButton(15, "Tracker"),
                SkillButton(16, "Spot Secret Doors"),
                SkillButton(17, "Danger Sense"),
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

    switch (game)
    {
    case GAME_MM2:
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_MM_CH7 ], (ULONG*) &man[who].skill[0]);
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_MM_CH8 ], (ULONG*) &man[who].skill[1]);
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_MM_IN42], (ULONG*) &man[who].thievery);
    acase GAME_MM3:
        for (i = 0; i < 10; i++)
        {   DISCARD GetAttr(GA_Selected, (Object*) gadgets[GID_MM_CB9 + i], (ULONG*) &man[who].skill[i]);
    }   }

    DisposeObject(SubWinObject);
    SubWindowPtr = NULL;
    SubWinObject = NULL;
}

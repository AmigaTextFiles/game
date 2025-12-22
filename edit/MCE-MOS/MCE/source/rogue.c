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

// #define WRITEDECRYPTED
// enable this to write a decrypted copy of encrypted/compressed files
// when serializing them

// main window
#define GID_ROGUE_LY1    0 // root layout
#define GID_ROGUE_SB1    1 // toolbar
#define GID_ROGUE_CH11   2 // game
#define GID_ROGUE_CH12   3 // filetype

// saved games
#define GID_ROGUE_BU1    4 // maximize character
#define GID_ROGUE_BU3    5 // map button
#define GID_ROGUE_IN1    6 // gp
#define GID_ROGUE_IN2    7 // cur hp
#define GID_ROGUE_IN3    8 // max hp
#define GID_ROGUE_IN4    9 // cur STR
#define GID_ROGUE_IN6   10 // moves
#define GID_ROGUE_IN14  11 // experience
#define GID_ROGUE_IN15  12 // cur spell points
#define GID_ROGUE_IN16  13 // max spell points
#define GID_ROGUE_IN17  14 // level
// IN30..IN43 must be consecutive and contiguous.
#define GID_ROGUE_IN30  15 // cur INT
#define GID_ROGUE_IN31  16 // cur WIS
#define GID_ROGUE_IN32  17 // cur DEX
#define GID_ROGUE_IN33  18 // cur CON
#define GID_ROGUE_IN34  19 // cur CHA
#define GID_ROGUE_IN35  20 // max STR
#define GID_ROGUE_IN36  21 // max INT
#define GID_ROGUE_IN37  22 // max WIS
#define GID_ROGUE_IN38  23 // max DEX
#define GID_ROGUE_IN39  24 // max CON
#define GID_ROGUE_IN40  25 // max CHA
#define GID_ROGUE_IN41  26 // age
#define GID_ROGUE_IN42  27 // food
#define GID_ROGUE_IN43  28 // digested
#define GID_ROGUE_ST1   29 // character name
#define GID_ROGUE_ST2   30 // fruit name
#define GID_ROGUE_ST13  31 // 1st history
#define GID_ROGUE_ST14  32 // 2nd history
#define GID_ROGUE_ST15  33 // 3rd history
#define GID_ROGUE_ST16  34 // 4th history
#define GID_ROGUE_CH13  35 // sex

// high score table
#define GID_ROGUE_ST3   36 // 1st name
#define GID_ROGUE_ST7   40 // 5th name
#define GID_ROGUE_ST17  41 // 1st placing
#define GID_ROGUE_ST21  45 // 5th placing
#define GID_ROGUE_IN9   46 // 1st gp
#define GID_ROGUE_IN13  50 // 5th gp
#define GID_ROGUE_IN19  51 // 1st dungeon level reached
#define GID_ROGUE_IN24  55 // 5th dungeon level reached
#define GID_ROGUE_CH1   56 // 1st rank
#define GID_ROGUE_CH5   60 // 5th rank
#define GID_ROGUE_CH14  61 // 1st race
#define GID_ROGUE_CH18  65 // 5th race
#define GID_ROGUE_CH24  66 // 1st class
#define GID_ROGUE_CH28  70 // 5th class
#define GID_ROGUE_CH34  71 // 1st sex
#define GID_ROGUE_CH38  75 // 5th sex
#define GID_ROGUE_BU2   76 // clear high scores
#define GID_ROGUE_BU4   77 // sort scores
#define GID_ROGUE_SC1   78 // vertical scroller

// location subwindow
#define GID_ROGUE_LY2   79 // root layout
#define GID_ROGUE_LY3   80 // dungeon level reached
#define GID_ROGUE_SP1   81 // map
#define GID_ROGUE_IN5   82 // dungeon level now
#define GID_ROGUE_IN7   83 // X
#define GID_ROGUE_IN8   84 // Y
#define GID_ROGUE_IN29  85 // dungeon level reached
#define GID_ROGUE_SC2   86 // horizontal scroller
#define GID_ROGUE_SC3   87 // vertical   scroller
#define GID_ROGUE_BU5   88 // reveal

// ST 8..12                     are spare
// IN18,     IN25..29           are spare
// CH 6..10, CH19..23, CH29..33 are spare

#define GIDS_ROGUE     GID_ROGUE_BU5

#define MAPWIDTH       198 // whichever is biggest
#define MAPHEIGHT       66 // whichever is biggest

#define LEFTX_CENTRED ((198 - 80) / 2)
#define TOPY_CENTRED  (( 66 - 28) / 2)

#define LEFTX_MAX     ( 198 - 80)
#define TOPY_MAX      (  66 - 28)

#define SCALEDWIDTH    640 // whichever is biggest
#define SCALEDHEIGHT   224 // whichever is biggest
/*          Map is 640*224 ( 80*28) for Hack
            Map is 600*189 ( 60*21) for Rogue
     Entire map is 396*132 (198*66) for Moria
    Visible map is 608*216 ( 80*28) for Moria */

#define HISCOREGADS        5

#define MAPTYPE_INTERNAL   0
#define MAPTYPE_CORRIDOR   1
#define MAPTYPE_PLAYER     2

#define NameGad(x)         LAYOUT_AddChild, gadgets[GID_ROGUE_ST3  + x] = (struct Gadget*) StringObject,  GA_ID, GID_ROGUE_ST3  + x, GA_TabCycle, TRUE, STRINGA_TextVal, score[firstplace + x].name, STRINGA_MaxChars, maxhiname[game] + 1, STRINGA_MinVisible, 10 + stringextra, StringEnd
#define GoldGad(x)         LAYOUT_AddChild, gadgets[GID_ROGUE_IN9  + x] = (struct Gadget*) IntegerObject, GA_ID, GID_ROGUE_IN9  + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, maxgp[game], INTEGER_MinVisible, 5 + 1, IntegerEnd
#define LevelGad(x)        LAYOUT_AddChild, gadgets[GID_ROGUE_IN19 + x] = (struct Gadget*) IntegerObject, GA_ID, GID_ROGUE_IN19 + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, maxlevel[game], INTEGER_MinVisible, 2 + 1, IntegerEnd

#define RaceGad(x)                                              \
LAYOUT_AddChild,                                                \
gadgets[GID_ROGUE_CH14 + x] = (struct Gadget*)                  \
PopUpObject,                                                    \
    GA_ID,                 GID_ROGUE_CH14 + x,                  \
    CHOOSER_LabelArray,    &RaceOptions,                        \
ChooserEnd
#define ClassGad(x)                                             \
LAYOUT_AddChild,                                                \
gadgets[GID_ROGUE_CH24 + x] = (struct Gadget*)                  \
PopUpObject,                                                    \
    GA_ID,                 GID_ROGUE_CH24 + x,                  \
    GA_RelVerify,          TRUE,                                \
    CHOOSER_LabelArray,    &HackClassOptions,                   \
ChooserEnd
#define RankGad(x)                                              \
LAYOUT_AddChild, gadgets[GID_ROGUE_CH1 + x] = (struct Gadget*)  \
PopUpObject,                                                    \
    GA_ID,                 GID_ROGUE_CH1 + x,                   \
    CHOOSER_LabelArray,    &RogueRankOptions,                   \
    CHOOSER_MaxLabels,     40,                                  \
ChooserEnd
#define SexGad(x)                                               \
LAYOUT_AddChild, gadgets[GID_ROGUE_CH34 + x] = (struct Gadget*) \
PopUpObject,                                                    \
    GA_ID,                 GID_ROGUE_CH34 + x,                  \
    CHOOSER_Labels,        &SexList,                            \
ChooserEnd
#define PlacingGad(x)                                           \
LAYOUT_AddChild, gadgets[GID_ROGUE_ST17 + x] = (struct Gadget*) \
StringObject,                                                   \
    GA_ID,                 GID_ROGUE_ST17 + x,                  \
    GA_ReadOnly,           TRUE,                                \
    STRINGA_TextVal,       "",                                  \
    STRINGA_MaxChars,      5 + 1,                               \
    STRINGA_MinVisible,    5 + stringextra,                     \
    STRINGA_Justification, GACT_STRINGRIGHT,                    \
StringEnd

#define GAME_HACK          0
#define GAME_ROGUE         1
#define GAME_MORIA         2
#define GAME_LARN          3

#define FT_HISCORES        0
#define FT_SAVEGAME        1

MODULE const int mapwidth[4]    = {    80  , 60   ,      198  ,       67   },
                 mapheight[4]   = {    28  , 21   ,       66  ,       17   },
                 gadwidth[4]    = {    80*8, 60*10,       80*8,       67*8 },
                 gadheight[4]   = {    28*8, 21* 9,       28*8,       17*8 },
                 maxgp[4]       = {   65535, 32767, 0x7FFFFFFF, 0x7FFFFFFF },
                 hplimit[4]     = {   65535,   999,      32767,        999 },
                 attrlimit[4]   = {     127,   999,        255,         99 },
                 maxlevel[4]    = {      26,    26,         40,         13 },
                 maxname[4]     = {      31,    23,         27,          0 },
                 maxhiname[4]   = {      10,    23,         27,         39 },
                 scalex[4]      = {       8,    10,          8,          8 },
                 scaley[4]      = {       8,    9 ,          8,          8 };

#define OPENCURLY  '{'
#define CLOSECURLY '}'

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize_savegame(void);
MODULE void serialize_hiscores(void);
MODULE void maximize_man(void);
MODULE void eithergadgets(void);
MODULE void rogue_ghost(void);
MODULE void sortscores(void);
MODULE void clearscores(void);
MODULE void drawpoint(int x, int y, int colour);
MODULE void drawgfx(int x, int y, int which);
MODULE void mapwindow(void);
MODULE void clearvars(void);
MODULE void larn_changemap(void);
MODULE void larn_reveal(void);
MODULE void swapscores(int first, int second);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT LONG                 gamesize,
                            pens[46];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SexList,
                            SpeedBarList;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT UBYTE*               byteptr1[MAXHEIGHT];
IMPORT __aligned UBYTE      display1[GFXINIT(MAXWIDTH, MAXHEIGHT)];
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

MODULE UBYTE                xor_byte;
MODULE ULONG                ability[9],
                            age,
                            curstr, maxstr,
                            curiq,  maxiq,
                            curwis, maxwis,
                            curdex, maxdex,
                            curcon, maxcon,
                            curcha, maxcha,
                            curhp,  maxhp,
                            cursp,  maxsp,
                            dungeonnow,
                            dungeonreached,
                            experience,
                            filetype,
                            food, digested,
                            game,
                            gp,
                            level, // of experience
                            moves,
                            sex,
                            xpos         = 0,
                            ypos         = 0;
MODULE int                  firstplace   = 0,
                            leftx        = LEFTX_CENTRED,
                            numscores,
                            topy         = TOPY_CENTRED;
MODULE TEXT                 history[4][59 + 1],
                            fruitname[31 + 1],
                            rogue_map[MAPHEIGHT][MAPWIDTH],
                            yourname[31 + 1];

MODULE const STRPTR GameOptions[4 + 1] =
{ "HackLite 2.8.1",
  "Epyx Rogue",
  "UMoria 5.5.0",
  "Larn 12.0B",
  NULL
}, FiletypeOptions[2 + 1] =
{ "High score table",
  "Saved game",
  NULL
}, RaceOptions[] =
{ "Human",
  "Half-Elf",
  "Elf",
  "Halfling",
  "Gnome",
  "Dwarf",
  "Half-Orc",
  "Half-Troll",
  NULL
}, HackClassOptions[13 + 1] =
{ "Archeologist", // must be same spelling as what the game uses!
  "Barbarian",
  "Caveman",
  "Elf",
  "Gangster",
  "Healer",
  "Knight",
  "Ninja",
  "Priest",
  "Samurai",
  "Tourist",
  "Valkyrie",
  "Wizard",
  NULL
}, MoriaClassOptions[] =
{ "Warrior",
  "Mage",
  "Priest",
  "Rogue",
  "Ranger",
  "Paladin",
  NULL
}, RogueRankOptions[24 + 1] =
{ "None #0",           //  0
  "None #1",
  "Guild Novice",
  "Apprentice",
  "Journeyman",
  "Adventurer",
  "Fighter",
  "Warrior",
  "Rogue",
  "Champion",
  "Master Rogue",      // 10
  "Warlord",
  "Hero",
  "Guild Master",
  "Dragonlord",
  "Wizard",
  "Rogue Geek",
  "Rogue Addict",
  "Schmendrick",
  "Gunfighter",
  "Time Waster",       // 20
  "Bug Chaser",
  "Penultimate Rogue",
  "Ultimate Rogue",    // 23
  NULL                 // 24
}, MoriaRankOptions[6][40 + 1] = {
{ "Rookie",            //  0 Warriors
  "Private",
  "Soldier",
  "Mercenary",
  "Veteran(1st)",
  "Veteran(2nd)",
  "Veteran(3rd)",
  "Warrior(1st)",
  "Warrior(2nd)",
  "Warrior(3rd)",
  "Warrior(4th)",      // 10
  "Swordsman-1",
  "Swordsman-2",
  "Swordsman-3",
  "Hero",
  "Swashbuckler",
  "Myrmidon",
  "Champion-1",
  "Champion-2",
  "Champion-3",
  "Superhero",         // 20
  "Knight",
  "Superior Knt",
  "Gallant Knt",
  "Knt Errant",
  "Guardian Knt",
  "Baron",
  "Duke",
  "Lord (1st)",
  "Lord (2nd)",
  "Lord (3rd)",        // 30
  "Lord (4th)",
  "Lord (5th)",
  "Lord (6th)",
  "Lord (7th)",
  "Lord (8th)",
  "Lord (9th)",
  "Lord Gallant",
  "Lord Keeper",
  "Lord Noble",        // 39
  NULL                 // 40
},
{ "Novice",            //  0 Mages
  "Apprentice",
  "Trickster-1",
  "Trickster-2",
  "Trickster-3",
  "Cabalist-1",
  "Cabalist-2",
  "Cabalist-3",
  "Visionist",
  "Phantasmist",
  "Shadowist",         // 10
  "Spellbinder",
  "Illusionist",
  "Evoker (1st)",
  "Evoker (2nd)",
  "Evoker (3rd)",
  "Evoker (4th)",
  "Conjurer",
  "Theurgist",
  "Thaumaturge",
  "Magician",          // 20
  "Enchanter",
  "Warlock",
  "Sorcerer",
  "Necromancer",
  "Mage (1st)",
  "Mage (2nd)",
  "Mage (3rd)",
  "Mage (4th)",
  "Mage (5th)",
  "Wizard (1st)",      // 30
  "Wizard (2nd)",
  "Wizard (3rd)",
  "Wizard (4th)",
  "Wizard (5th)",
  "Wizard (6th)",
  "Wizard (7th)",
  "Wizard (8th)",
  "Wizard (9th)",
  "Wizard Lord",       // 39
  NULL                 // 40
},
{ "Believer",          //  0 Priests
  "Acolyte(1st)",
  "Acolyte(2nd)",
  "Acolyte(3rd)",
  "Adept (1st)",
  "Adept (2nd)",
  "Adept (3rd)",
  "Priest (1st)",
  "Priest (2nd)",
  "Priest (3rd)",
  "Priest (4th)",      // 10
  "Priest (5th)",
  "Priest (6th)",
  "Priest (7th)",
  "Priest (8th)",
  "Priest (9th)",
  "Curate (1st)",
  "Curate (2nd)",
  "Curate (3rd)",
  "Curate (4th)",
  "Curate (5th)",      // 20
  "Curate (6th)",
  "Curate (7th)",
  "Curate (8th)",
  "Curate (9th)",
  "Canon (1st)",
  "Canon (2nd)",
  "Canon (3rd)", 
  "Canon (4th)",
  "Canon (5th)",
  "Low Lama",          // 30
  "Lama-1",
  "Lama-2",
  "Lama-3",
  "High Lama",
  "Great Lama",
  "Patriarch",
  "High Priest",
  "Great Priest",
  "Noble Priest",      // 39
  NULL                 // 40
},
{ "Vagabond",          //  0 Rogues
  "Footpad",
  "Cutpurse",
  "Robber",
  "Burglar",
  "Filcher",
  "Sharper",
  "Magsman",
  "Common Rogue",
  "Rogue (1st)",
  "Rogue (2nd)",       // 10
  "Rogue (3rd)",
  "Rogue (4th)",
  "Rogue (5th)",
  "Rogue (6th)",
  "Rogue (7th)",
  "Rogue (8th)",
  "Rogue (9th)",
  "Master Rogue",
  "Expert Rogue",
  "Senior Rogue",      // 20
  "Chief Rogue",
  "Prime Rogue",
  "Low Thief",
  "Thief (1st)",
  "Thief (2nd)",
  "Thief (3rd)",
  "Thief (4th)",
  "Thief (5th)",
  "Thief (6th)",
  "Thief (7th)",       // 30
  "Thief (8th)",
  "Thief (9th)",
  "High Thief",
  "Master Thief",
  "Executioner",
  "Low Assassin",
  "Assassin",
  "High Assassin",
  "Guildsmaster",
  NULL                 // 40
},
{ "Runner (1st)",      //  0 Rangers
  "Runner (2nd)",
  "Runner (3rd)",
  "Strider (1st)",
  "Strider (2nd)",
  "Strider (3rd)",
  "Scout (1st)",
  "Scout (2nd)",
  "Scout (3rd)",
  "Scout (4th)",
  "Scout (5th)",       // 10
  "Courser (1st)",
  "Courser (2nd)",
  "Courser (3rd)",
  "Courser (4th)",
  "Courser (5th)",
  "Tracker (1st)",
  "Tracker (2nd)",
  "Tracker (3rd)",
  "Tracker (4th)",
  "Tracker (5th)",     // 20
  "Tracker (6th)",
  "Tracker (7th)",
  "Tracker (8th)",
  "Tracker (9th)",
  "Guide (1st)",
  "Guide (2nd)",
  "Guide (3rd)",
  "Guide (4th)",
  "Guide (5th)",
  "Guide (6th)",       // 30
  "Guide (7th)",
  "Guide (8th)",
  "Guide (9th)",
  "Pathfinder-1",
  "Pathfinder-2",
  "Pathfinder-3",
  "Ranger",
  "High Ranger",
  "Ranger Lord",       // 39
  NULL                 // 40
},
{ "Gallant",           //  0 Paladins
  "Keeper (1st)",
  "Keeper (2nd)",
  "Keeper (3rd)",
  "Keeper (4th)",
  "Keeper (5th)",
  "Keeper (6th)",
  "Keeper (7th)",
  "Keeper (8th)",
  "Keeper (9th)",
  "Protector-1",       // 10
  "Protector-2",
  "Protector-3",
  "Protector-4",
  "Protector-5",
  "Protector-6",
  "Protector-7",
  "Protector-8",
  "Defender-1",
  "Defender-2",
  "Defender-3",        // 20
  "Defender-4",
  "Defender-5",
  "Defender-6",
  "Defender-7",
  "Defender-8",
  "Warder (1st)",
  "Warder (2nd)",
  "Warder (3rd)",
  "Warder (4th)",
  "Warder (5th)",      // 30
  "Warder (6th)",
  "Warder (7th)",
  "Warder (8th)",
  "Warder (9th)",
  "Guardian",
  "Chevalier",
  "Justiciar",
  "Paladin",
  "High Lord",         // 39
  NULL                 // 40
}
};

/*
Rogue:
0 = 000 black
1 = 444 dark grey
2 = FE0 yellow
3 = C00 red
4 = 888 medium grey
5 = F60 orange
6 = FFF white
7 = A30 light brown
8 = 720 dark brown
9 = FCA skin
A = F0C pink
B = 090 green
C = 3FB cyan
D = 69F light blue
E = A0F purple
F = 00F dark blue

Hack:
G = DD0 yellow
H = EA0 orange
I = A00 dark red
J = F00 bright red
K = 0D0 bright green
L = 00D blue
M = A49 purple
N = 280 dark green
O = BF6 light green
P = 850 brown
Q = 3BE light blue
R = FFC skin
a = AA8 greyish

Moria:
S = 332 greyish
T = 555 grey
U = C86 bone
V = 843 brown
W = EB0 yellow
X = 800 dark red
Y = 080 dark green
Z = F22 bright red
b = DCA bone
*/

MODULE const STRPTR gfx_rogue[][9] = {
// Rogue
{ "1111111111", // door
  "0466666680", // +
  "4633333378", // 0
  "9333333337",
  "4404444044",
  "3333336603",
  "4404444044",
  "3333333333",
  "0000000000",
},
{ "0466222211", // horizontal wall
  "6422222211", // -{}
  "2411111111", // 1
  "8888888887",
  "8888888887",
  "8585858585",
  "4141414141",
  "1010101010",
  "8888888887",
},
{ "1106AA0161", // player
  "1007970061", // @
  "1009990061", // 2
  "055BCB5060",
  "5555550DDD",
  "9905650090",
  "0008880001",
  "1007070011",
  "0778087700",
},
{ "1111111111", // room
  "1111111111", // .
  "1111111111", // 3
  "1111111111",
  "1111471111",
  "1111111111",
  "1111111111",
  "1111111111",
  "1111111111",
},
{ "0466222211", // vertical wall
  "6422222211", // |<>
  "1111111111", // 4
  "0466222211",
  "6422222211",
  "1111111111",
  "0466222211",
  "6422222211",
  "1111111111",
},
{ "1111211111", // gold
  "1611111161", // *
  "2111111111", // 5
  "1105652012",
  "0256521201",
  "C56565212B",
  "CC6CCBBBBB",
  "0C6CCBBBB0",
  "11CCBBBB00",
},
{ "0000000000", // stairs
  "0014D44100", // %
  "0000000000", // 6
  "014D444410",
  "0000000000",
  "14D4444441",
  "0000000000",
  "4D44444444",
  "4D44444444",
},
{ "1111111111", // scroll
  "8666666007", // ?
  "1091191970", // 7
  "1094949970",
  "1091191970",
  "1099494970",
  "1094911970",
  "8666666007",
  "1111111111",
},
{ "1107778011", // potion
  "1110780111", // !
  "110A9EE011", // 8
  "1110E10111",
  "110A9EE011",
  "10A9EEEE01",
  "0A69EEEEE0",
  "0A99EEEEE0",
  "10AE5EEE01",
},
{ "1111111111", // shield
  "6666644444", // a
  "6777788884", // 9
  "6777788884",
  "6777788884",
  "6677788844",
  "6467788414",
  "0664781440",
  "1106644011",
},
{ "1111111111", // shield
  "6666644444", // b
  "660D0D0D44", // 10
  "66D0D0D044",
  "660D0D0D44",
  "66D0D0D044",
  "660D0D0D44",
  "0660D0D440",
  "1106644011",
},
{ "1111111111", // shield
  "6666644444", // c
  "677D78D884", // 11
  "6D777888D4",
  "6777788884",
  "66D7788D44",
  "6467788414",
  "0664DD1440",
  "1106644011",
},
{ "1111111111", // shield
  "6666644444", // d
  "60DDD0DD44", // 12
  "6D0D0D0D44",
  "6DD0DDD044",
  "660D0D0D44",
  "666DD0D444",
  "06660D4440",
  "1106644011",
},
{ "1111111111", // shield
  "6666644444", // e
  "6DDDDDDDD4", // 13
  "6DD4411DD4",
  "6D4D41D1D4",
  "6D44DD11D4",
  "66DD41DD44",
  "0666DD4440",
  "1106644011",
},
{ "1111111111", // shield
  "6666644444", // f
  "7777788888", // 14
  "6666644444",
  "7777788888",
  "6666644444",
  "7777788888",
  "0666644440",
  "1106644011",
},
{ "1111111111", // shield
  "6666644444", // g
  "DDDDDFFFFF", // 15
  "6666644444",
  "DDDDDFFFFF",
  "6666644444",
  "DDDDDFFFFF",
  "0666644440",
  "1106644011",
},
{ "1111111111", // shield
  "6666644444", // h
  "6666664444", // 16
  "6666664444",
  "6666664444",
  "6666664444",
  "6666664444",
  "0666644440",
  "1106644011",
},
{ "1110001111", // weapon
  "1006119001", // m
  "0021611900", // 17
  "1009119001",
  "1110880111",
  "1110780111",
  "1110780111",
  "1110780111",
  "1110780111",
},
{ "1111001111", // weapon
  "11101D0111", // n
  "11101D0111", // 18
  "11101D0111",
  "11101D0111",
  "11101D0111",
  "1029359201",
  "1110880111",
  "1110780111",
},
{ "1057801111", // weapon
  "1080780111", // o
  "1080078011", // 19
  "1080107801",
  "1070109901",
  "1080107801",
  "1080078011",
  "1080780111",
  "1057801111",
},
{ "1110640111", // weapon
  "1106664011", // p
  "1110880111", // 20
  "1110580111",
  "1110780111",
  "1110780111",
  "1107788011",
  "1075785701",
  "1075785701",
},
{ "1111111111", // weapon
  "1111001111", // q
  "11106D0111", // 21
  "11106D0111",
  "11106D0111",
  "1102525011",
  "1110880111",
  "1110780111",
  "1111111111",
},
{ "11106D0111", // weapon
  "11106D0111", // r
  "11106D0111", // 22
  "11106D0111",
  "09006D0090",
  "02991D9920",
  "1110880111",
  "1110880111",
  "1110780111",
},
{ "1111111111", // weapon
  "1110610111", // s
  "1110610111", // 22
  "110C2BB011",
  "110CBBB011",
  "1110CB0111",
  "110DFFD011",
  "10DFDDFD01",
  "1111111111",
},
{ "1111001111", // weapon
  "1000780001", // t
  "0877977780", // 23
  "7800880078",
  "0080780800",
  "1100780011",
  "1110780111",
  "1110570111",
  "1111001111",
},
{ "1111001111", // weapon
  "1110D40111", // u
  "1110640111", // 24
  "1110780111",
  "1110780111",
  "1110780111",
  "1110780111",
  "1110570111",
  "1110780111",
},
{ "0000111111", // weapon
  "6191011000", // v
  "2619010619", // 25
  "9D90106291",
  "00D01106D9",
  "110DD0DD00",
  "1110780011",
  "1110780111",
  "1110780111",
},
{ "1111111111", // gem
  "1111FF1111", // w
  "11DB33BD11", // 26
  "1FB3223BF1",
  "FDD2AA2DDF",
  "1FB3223BF1",
  "11DB33BD11",
  "1111FF1111",
  "1111111111",
},
{ "1111111111", // gem
  "1111FF1111", // x
  "11ADEEDA11", // 27
  "1FDA22ADF1",
  "FE926629EF",
  "1FDA22ADF1",
  "11ADEEDA11",
  "1111FF1111",
  "1111111111",
},
{ "3333333333", // altar
  "3000550003", // ^
  "3022222203", // 28
  "3000220003",
  "3022222203",
  "3000220003",
  "3002222003",
  "3500000053",
  "3333333333",
},
{ "1111111064", // stick
  "1111110641", // /
  "1111106410", // 29
  "1111064101",
  "1110641011",
  "1106410111",
  "1064101111",
  "0641011111",
  "6410111111",
},
{ "1111111111", // ring
  "1111111111", // =
  "0FD62DDD01", // 30
  "10FD6DF011",
  "1462442541",
  "4650111254",
  "6501111165",
  "4250111254",
  "1142222411",
},
{ "1111111111", // food
  "1087777778", // :
  "0877777788", // 31
  "8999998888",
  "7899988888",
  "7999998880",
  "7999998801",
  "8888888011",
  "1111111111",
},
{ "02D2D2D2D0", // amulet
  "6F00000009", // ,
  "2F01111109", // 32
  "02F011109F",
  "102F0009F0",
  "10FDDDDF01",
  "10D2633001",
  "10D5533001",
  "10DFF0FF01",
} },
gfx_hack[][8] = {
{ "00000000",
  "00000000", // $00
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
},
{ "66666666",
  "60000006", // space
  "60000006", // in-game image is totally black
  "60000006", // we show this instead so the player can see it
  "60000006",
  "60000006",
  "60000006",
  "66666666",
},
{ "44444444", // potion
  "44000044", // !
  "46600664",
  "446JI644",
  "46JMJM64",
  "6JMJMJM6",
  "66666666",
  "44444444",
},
{ "44444444",
  "44G6G644", // "
  "46JLLJ64",
  "GJLOKLJ6",
  "6JLKOLJG",
  "46JLLJ64",
  "446W6W44",
  "44444444",
},
{ "44444444", // corridor
  "44444444", // #
  "44444444",
  "44444444",
  "44444444",
  "44444444",
  "44444444",
  "44444444",
},
{ "44444444", // gold
  "440GH044", // $
  "4HGH0H04",
  "H0HGHGHG",
  "00000000",
  "00000000",
  "00000000",
  "40000004",
},
{ "44444444", // food
  "44444444", // %
  "44444444",
  "4444K444",
  "444JJ444",
  "4JJJJGJ4",
  "4JJIJJJ4",
  "44J6JJ44",
},
{ "44444J44",
  "G4G4JJJ4", // &
  "G4G44J44",
  "GGG4JJJ4",
  "4G4JJJJJ",
  "4GJ4JJJ4",
  "4G44J4J4",
  "4G44J4J4",
},
{ "440II044",
  "00IGGI00", // '
  "G00II00G",
  "0aaaaaa0",
  "40aaaa04",
  "40aaaa04",
  "40I00I04",
  "40I00I04",
},
{ "44444444", // whistle
  "44444444", // (
  "44444444",
  "44444444",
  "GGGGG0G4",
  "000GGGGG",
  "4440GGG0",
  "44440004",
},
{ "44464444", // sword
  "44666444", // )
  "44606444",
  "44606444",
  "44606444",
  "44606444",
  "IJIJIJI4",
  "44JIJ444",
},
{ "44444444",
  "44444444", // *
  "4NOKKON4",
  "NONK6NON",
  "4NONNON4",
  "44NKKNKK",
  "44444444",
  "44444444",
},
{ "44444444",
  "GIIIIII4", // +
  "GIII0II4",
  "GII0II04",
  "GIIII0I4",
  "GII0III4",
  "I6666664",
  "44444444",
},
{ "44444444",
  "44464446", // ,
  "446L6466",
  "66LML6L6",
  "6LMLMLL6",
  "6L6MLML6",
  "6646L664",
  "64446444",
},
{ "6JJJJJJI", // horizontal wall
  "J6JJJJJI", // -
  "JJ6JJJJI",
  "JJJ0IIII",
  "JJJI0III",
  "JJJII0II",
  "JJJIII0I",
  "JJJIIIII",
},
{ "44444444", // room
  "44444444", // .
  "44444444",
  "44444444",
  "44444444",
  "44444444",
  "44444444",
  "44444444",
},
{ "44444444", // wand
  "44444444", // /
  "44444444",
  "4444J444",
  "444G0444",
  "44G04444",
  "4G044444",
  "G0444444",
},
{ "44444444",
  "44444444", // 0
  "44006044",
  "40000604",
  "40000004",
  "44000044",
  "44444444",
  "44444444",
},
{ "444444L4",
  "GG6GG404", // 1
  "46G4400L",
  "6G44460L",
  "G4444L0L",
  "4444GL0G",
  "4444LL0L",
  "444LLG0L",
},
{ "00000000",
  "06666660", // 2
  "06466660",
  "06466660",
  "06466660",
  "0666II60",
  "06666660",
  "00000000",
},
{ "444KK444",
  "44GGGG46", // 3
  "444GG446",
  "4KKKKKK6",
  "K4KKKK4K",
  "44KKKK4I",
  "44K44K44",
  "44044044",
},
{ "4H4444H4",
  "4GH44HG4", // 4
  "4GGGGGG4",
  "GJJGGJJG",
  "GGGGGGGG",
  "4GJJJJG4",
  "4GGGGGG4",
  "44PGGP44",
},
{ "44444444",
  "44JPP444", // 5
  "4J444P44",
  "J4444444",
  "J4444444",
  "4I444IIJ",
  "44J4II66",
  "4I4IIIII",
},
{ "00IIII00", // 6
  "L46JJ64L",
  "4PIHHIP4",
  "40000004",
  "44IHHI44",
  "44000044",
  "44IHI444",
  "40000444",
},
{ "4JGJJGJ4",
  "44666644", // 7
  "60L66L06",
  "L666666L",
  "46G44G64",
  "46LGGL64",
  "44666644",
  "444GG444",
},
{ "4IJIIJI4",
  "IHOGGOHI", // 8
  "GOOOOOOG",
  "600OO006",
  "6KKKKKK6",
  "HKKLLKKH",
  "66KKKK66",
  "P6K44K6P",
},
{ "IIPPP444",
  "04GPG044", // 9
  "64PPI644",
  "46L66L64",
  "44LLLL64",
  "44LLLLJ4",
  "44L44L44",
  "44L44L44",
},
{ "44444444",
  "44JGJ444", // :
  "4GGGGG44",
  "44GGG444",
  "44GGG444",
  "4GGGGG4G",
  "444G444G",
  "4444GGG4",
},
{ "6LLLLLLL",
  "6LLK0KKL", // ;
  "LLLKKK6L",
  "LLLK4KLL",
  "LLKKKLLL",
  "LLK4KLLL",
  "KK4KLL6L",
  "4KLLL6LL",
},
{ "K444444K", // ladder
  "KKKKKKKK", // <
  "K444444K",
  "KKKKKKKK",
  "K444444K",
  "KKKKKKKK",
  "K444444K",
  "K444444K",
},
{ "44444444",
  "44444444", // =
  "44444444",
  "44444444",
  "44466444",
  "444GG044",
  "44G04G04",
  "444GG044",
},
{ "PIPIPIPI", // stairs
  "44444444", // >
  "4IPIPIP4",
  "44444444",
  "44PIPI44",
  "44444444",
  "444IP444",
  "44444444",
},
{ "44000004", // scroll
  "40RRRR00", // ?
  "0RRRR00R",
  "0RRRR000",
  "0RRRRR44",
  "0RRRR000",
  "0RRRR0R0",
  "40000004",
},
{ "OOOHHOOO", // you
  "OOMMMMOO", // @
  "OOOMMOOO",
  "OQQQQQQO",
  "QOHHHHOQ",
  "OOQQQQOO",
  "OOQOOQOO",
  "OMMOOMMO",
},
{ "44J44J44",
  "4J4444J4", // A
  "44J44J44",
  "400JJ004",
  "444JJ444",
  "4JJJJJJ4",
  "444JJ444",
  "4JJ44JJ4",
},
{ "44444444",
  "44444444", // B
  "44444444",
  "40044004",
  "04400440",
  "44444444",
  "44444444",
  "44444444",
},
{ "4444GG64",
  "4444G664", // C
  "44446644",
  "I4446666",
  "IIIIII44",
  "IIIIII44",
  "I4444I44",
  "04444044",
},
{ "44GII444",
  "KKKKKI44", // D
  "444KKII4",
  "44KKKI44",
  "4KKKI444",
  "4KKKKII4",
  "4KKKKKKI",
  "KK44KKKK",
},
{ "44444444",
  "44GGGG44", // E
  "4JG00GG4",
  "JG0000GJ",
  "JJG00GJ4",
  "44GGGG44",
  "44444444",
  "44444444",
},
{ "44444444",
  "44666644", // F
  "46LLLL64",
  "6LLLLLL6",
  "46LLLL64",
  "44666644",
  "44444444",
  "44444444",
},
{ "44444444",
  "44444444", // G
  "44444444",
  "44KK4444",
  "4K00K444",
  "K4KK4K44",
  "4KNNK444",
  "4K44K444",
},
{ "444GG444",
  "446GG644", // H
  "444GG444",
  "GGGGGGGG",
  "G4PPPP4G",
  "44GGGG44",
  "44G44G44",
  "4GG44GG4",
},
{ "440L00L0",
  "0440JLLJ", // I
  "L00LLLL0",
  "LLLLL004",
  "00LLLL04",
  "0LLL00L0",
  "0LLLL00L",
  "0LLLL040",
},
{ "44444444",
  "44444444", // J
  "44444444",
  "4444GGJ4",
  "GG44GGGG",
  "4GGGGG44",
  "4GGGGG44",
  "4G444G44",
},
{ "444LL444",
  "44GLLG44", // K
  "444LL44L",
  "GGLLLLLL",
  "LLLKKL44",
  "L4LLLL44",
  "44L44L44",
  "44L44L44",
},
{ "444KK444",
  "44KKKK44", // L
  "KK0KK0KK",
  "KKKKKKKK",
  "KK0KK0KK",
  "44KKKKG4",
  "444KK44G",
  "444444G4",
},
{ "44444444",
  "44IGHI44", // M
  "4HGHIHI4",
  "HIHGHGHG",
  "I000000I",
  "00K00K00",
  "40000004",
  "40I00I04",
},
{ "44JJJJ44",
  "44J00J44", // N
  "4J4004J4",
  "40000004",
  "04400440",
  "44000044",
  "44044044",
  "40044004",
},
{ "44400044",
  "440G0G04", // O
  "44000004",
  "4JLKLKLJ",
  "4JILKLIJ",
  "404JLJ40",
  "44JJ4JJ4",
  "40004000",
},
{ "44444444",
  "LLML4444", // P
  "M00M4444",
  "4LM44444",
  "4MLM4444",
  "44MLM444",
  "444MLM44",
  "MLMLMM44",
},
{ "44444444",
  "446GG644", // Q
  "4G4LL4G4",
  "64GLLG46",
  "464GG464",
  "64G44G46",
  "4G4444G4",
  "G444444G",
},
{ "44444I44",
  "4444I4I4", // R
  "4444444I",
  "4444444I",
  "44JJJJ4I",
  "4JJJJJJ4",
  "IIGIIGII",
  "II4444II",
},
{ "44444GP4",
  "4444JHR4", // S
  "444GG444",
  "44GJ44I4",
  "444JG444",
  "4444GJ44",
  "44444JG4",
  "GGJJGGG4",
},
{ "44444444",
  "44KKK444", // T
  "4KIJIK44",
  "4KKKKK44",
  "K4KKK4K4",
  "44KKK444",
  "4KK4KK44",
  "KKK4KKK4",
},
{ "4H4444H4",
  "4HHHHHH4", // U
  "4HIPPIH4",
  "4HHHHHH4",
  "HHHHHHHH",
  "44HHHH44",
  "44H44H44",
  "4HH44HH4",
},
{ "44000044",
  "00000000", // V
  "06600660",
  "60066006",
  "66666666",
  "46600664",
  "460JJ064",
  "44J66J44",
},
{ "44666664",
  "46006006", // W
  "44660664",
  "44466644",
  "66666444",
  "46666664",
  "44446666",
  "46666644",
},
{ "I444444I",
  "4I4444I4", // X
  "44I44I44",
  "4PPIIPP4",
  "4IJJJJI4",
  "44IIII44",
  "4II44II4",
  "III44III",
},
{ "44666644",
  "460GG064", // Y
  "46666664",
  "66666666",
  "44666644",
  "46666664",
  "66644666",
  "66444466",
},
{ "44444444",
  "44466444", // Z
  "44466444",
  "46666664",
  "44466444",
  "44466444",
  "44644644",
  "46444464",
},
{ "00044000", // shield
  "06600LL0", // [
  "0666LLL0",
  "0666LLL0",
  "0LLL6660",
  "0LLL6660",
  "40LL6604",
  "44000044",
},
{ "444GG444",
  "GJJIMJJG", // backslash
  "4JIMIMJ4",
  "4JMIMIJ4",
  "4JIMIMJ4",
  "JJKKKKJJ",
  "KKKKKKKK",
  "JJJJJJJJ",
},
{ "00044000", // shield (reversed)
  "0LL00660", // ]
  "0LLL6660",
  "0LLL6660",
  "0666LLL0",
  "0666LLL0",
  "4066LL04",
  "44000044",
},
{ "JJJJJJJJ", // trap
  "J000000J", // ^
  "JGGGGGGJ",
  "J00GG00J",
  "J00GG00J",
  "J00GG00J",
  "J000000J",
  "JJJJJJJJ",
},
{ "40044444",
  "04404444", // _
  "04000444",
  "40040444",
  "44040044",
  "44000404",
  "44404404",
  "44440044",
},
{ "44444444", // boulder
  "444I6444", // `
  "40I0I064",
  "0I0I0I06",
  "I0I0I0I0",
  "0I0I0I0I",
  "40I0I044",
  "44444444",
},
{ "44444444",
  "44444444", // a
  "4444I444",
  "444JNH44",
  "4HJ4KJ44",
  "J4G64KJ4",
  "KGKLKGKJ",
  "JKGKGKJ4",
},
{ "04444404",
  "40444044", // b
  "44JJJ444",
  "40IJI044",
  "0I0JJI04",
  "0JIJ0I04",
  "0I0JJI04",
  "40JIJ044",
},
{ "44444444",
  "44444444", // c
  "444JJ444",
  "466JJ664",
  "4LGGGGL4",
  "4KG00GK4",
  "4ILGGLI4",
  "44444444",
},
{ "44444444", // dog
  "44444444", // d
  "44444444",
  "4LRR444R",
  "RRRR44R4",
  "44RRRRR4",
  "44RRRRR4",
  "44R444R4",
},
{ "4I4444I4",
  "IG644IG6", // e
  "46444644",
  "466I6644",
  "66666664",
  "64666464",
  "44646444",
  "46646644",
},
{ "44446444",
  "46a6L644", // f
  "446a6a6L",
  "446Qa6a4",
  "46a66L64",
  "6aL6aa6 ",
  "466aa6Q6",
  "446Q66aa",
},
{ "44444444",
  "44RRRRRR", // g
  "4RJJJJJR",
  "RRRRRRRJ",
  "RJJJJJRJ",
  "RJJJJJRJ",
  "RJJJJJRR",
  "RRRRRRR4",
},
{ "44444444",
  "44444444", // h
  "44IIII44",
  "44066044",
  "4HLKKLH4",
  "44KIIK44",
  "44H44H44",
  "4II44II4",
},
{ "44444444",
  "44444444", // i
  "444HH444",
  "44LLLL44",
  "464LL464",
  "44LLLL44",
  "44L44L44",
  "44444444",
},
{ "44444444",
  "44444444", // j
  "GG4444GG",
  "4GGGGGG4",
  "GLLGGLLG",
  "GGG00GGG",
  "4G0JJ0G4",
  "44GGGG44",
},
{ "04444404",
  "4G444G44", // k
  "44GGG444",
  "44GGG444",
  "40000044",
  "4GGGGG44",
  "40000044",
  "44GGG444",
},
{ "44444444",
  "J0444444", // l
  "0J000404",
  "0JJJJ0J0",
  "0JJJJJJJ",
  "0J000J00",
  "J040J044",
  "44444444",
},
{ "440G0444",
  "4PGPGP44", // m
  "PHPGPHP4",
  "4PHPHP44",
  "44PJP444",
  "444P4444",
  "444H44P4",
  "4PH4HP44",
},
{ "44444444",
  "66666666", // n
  "666JJ666",
  "666JJ666",
  "JJJJJJJJ",
  "666JJ666",
  "666JJ666",
  "66666666",
},
{ "40JJJ044",
  "JJG0GJJ4", // o
  "JJ000JJ4",
  "JJ0G0JJ4",
  "40JJJ044",
  "0J000J04",
  "JJJ0JJJ0",
  "44444444",
},
{ "44444444",
  "66666664", // p
  "60000064",
  "46000644",
  "46000644",
  "44606444",
  "44606444",
  "44464444",
},
{ "44444444",
  "444GG444", // q
  "44GOKG44",
  "44GKKKG4",
  "4GGKGGO4",
  "4GKKKOG4",
  "44GOKKG4",
  "4GKOOKGG",
},
{ "44I0I444", // rat
  "00000004", // r
  "40000044",
  "00000004",
  "44000444",
  "44404444",
  "44404404",
  "44440044",
},
{ "44444444", // spider
  "04444440", // s
  "404II404",
  "44000044",
  "00000000",
  "44000044",
  "40444404",
  "04444440",
},
{ "44G66G44",
  "46IGGI64", // t
  "J4G66G4J",
  "J44KK44J",
  "IJKKKKJI",
  "J44NN44J",
  "440NN044",
  "40444404",
},
{ "JG444444",
  "4KL4G444", // u
  "46664444",
  "4666444I",
  "46664464",
  "46666644",
  "44644644",
  "44I44I44",
},
{ "44444444",
  "44JJJJ44", // v
  "4JJPPJJ4",
  "444LI444",
  "444ML444",
  "444LI444",
  "44LILI44",
  "4LILILI4",
},
{ "44444666",
  "4444666J", // w
  "44066446",
  "46444444",
  "46666444",
  "44444644",
  "44444464",
  "46666044",
},
{ "44444I44",
  "4444II4I", // x
  "444GGI4I",
  "44GGGGII",
  "GGGGGG44",
  "G444GG44",
  "G444GG44",
  "G444GG44",
},
{ "44444444",
  "44GGGG44", // y
  "4G0GGGG4",
  "4GGGGGG4",
  "44GGGG44",
  "44666644",
  "44466444",
  "44444444",
},
{ "444PI444",
  "44IHHI44", // z
  "P44PI44P",
  "4JPJPJP4",
  "44JPJP44",
  "44PIPI44",
  "44I44P44",
  "44044044",
},
{ "4444LLL4", // fountain
  "444LL44L", // {
  "444LL444",
  "44LLLL44",
  "66666666",
  "44666644",
  "44466444",
  "44666644",
},
{ "IJJJJIII", // vertical wall
  "IJJJJIII", // |
  "I6666III",
  "IJJJJ6II",
  "IJJJJI6I",
  "IJJJJII6",
  "IJJJJIII",
  "IJJJJIII",
},
{ "LLLLLLLL",
  "6LL6LL6L", // }
  "L66L66L6",
  "LLLLLLLL",
  "L6LL6LL6",
  "6L66L66L",
  "LLLLLLLL",
  "LL6LL6LL",
},
{ "44666664",
  "40444444", // ~
  "64460644",
  "46664464",
  "44444604",
  "66466444",
  "44604444",
  "66446660",
},
{ "00000000",
  "00000000", // DEL
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
},
{ "6J444444",
  "J6J44444", // $80
  "4J6J4444",
  "44J6J444",
  "444J6J44",
  "4444J6J4",
  "44444J6J",
  "444444J6",
},
{ "444444J6",
  "44444J6J", // $81
  "4444J6J4",
  "444J6J44",
  "44J6J444",
  "4J6J4444",
  "J6J44444",
  "6J444444",
},
{ "444J6J44",
  "444J6J44", // $82
  "444J6J44",
  "444J6J44",
  "444J6J44",
  "444J6J44",
  "444J6J44",
  "444J6J44",
},
{ "44444444",
  "44444444", // $83
  "JJJJJJJJ",
  "66666666",
  "JJJJJJJJ",
  "44444444",
  "44444444",
  "44444444",
},
{ "00000LLL",
  "000LLLGG", // $84
  "0LLLGG44",
  "LLGG4444",
  "LLG44444",
  "LLG44444",
  "LLG44444",
  "LLG44444",
},
{ "LLLLLLLL",
  "GGGGGGGG", // $85
  "44444444",
  "44444444",
  "44444444",
  "44444444",
  "44444444",
  "44444444",
},
{ "LLL00000",
  "GGLLL000", // $86
  "44GGLLL0",
  "4444GGLL",
  "44444GLL",
  "44444GLL",
  "44444GLL",
  "44444GLL",
},
{ "LLG44444",
  "LLG44444", // $87
  "LLG44444",
  "LLG44444",
  "LLG44444",
  "LLG44444",
  "LLG44444",
  "LLG44444",
},
{ "44444GLL",
  "44444GLL", // $88
  "44444GLL",
  "44444GLL",
  "44444GLL",
  "44444GLL",
  "44444GLL",
  "44444GLL",
},
{ "LLG44444",
  "LLG44444", // $89
  "LLG44444",
  "LLG44444",
  "LLGG4444",
  "0LLLGG44",
  "000LLLGG",
  "00000LLL",
},
{ "44444444",
  "44444444", // $8A
  "44444444",
  "44444444",
  "44444444",
  "44444444",
  "GGGGGGGG",
  "LLLLLLLL",
},
{ "44444GLL",
  "44444GLL", // $8B
  "44444GLL",
  "44444GLL",
  "4444GGLL",
  "44GGLLL0",
  "GGLLL000",
  "LLL00000",
},
{ "0000000J", // top left corner
  "0000JJJJ", // $8C
  "0006JJJJ",
  "0JJJ0III",
  "0JJJI0II",
  "IJJJII0I",
  "IJJJIII0",
  "IJJJIIII",
},
{ "IJJJJIII", // bottom left corner
  "IJJJJIII", // $8D
  "I6666III",
  "IJJJJ6II",
  "IJJJJI6I",
  "0JJJJII6",
  "000JJIII",
  "00000III",
},
{ "I6J00000", // top right corner
  "IJ6JJ000", // $8E
  "IJJ6JJJ0",
  "IJJJ0III",
  "IJJJI0II",
  "IJJJII0I",
  "IJJJIII0",
  "IJJJIIII",
},
{ "IJJJJIII", // bottom right corner
  "IJJJJIII", // $8F
  "I6666III",
  "IJJJJ6II",
  "IJJJJI6I",
  "IJJJJII0",
  "IJJJJ000",
  "IJJ00000",
},
{ "44666644", // door
  "46666664", // $90
  "00000000",
  "60666606",
  "66000066",
  "60666606",
  "00000000",
  "66666666",
},
{ "06600000",
  "60060000", // $91
  "06660000",
  "00060060",
  "06600660",
  "00000060",
  "00000060",
  "00000666",
},
{ "06600000",
  "60060000", // $92
  "06660000",
  "00060660",
  "06600006",
  "00000660",
  "00006000",
  "00006666",
},
{ "40404440",
  "44044404", // $93
  "40404044",
  "04440444",
  "44404040",
  "04044404",
  "40444040",
  "04040444",
},
{ "444JJ444",
  "04JJJJ40", // $94
  "4PIIIIP4",
  "JII0PIIJ",
  "JIIP0IIJ",
  "4PIIIIP4",
  "04JJJJ40",
  "444JJ444",
},
{ "644G6446",
  "4G4GG4G4", // $95
  "64G4IG44",
  "4GI664GG",
  "GG466IG4",
  "44GI4G46",
  "4G4GG4G4",
  "6446G446",
},
{ "44444444",
  "4440JI44", // $96
  "440JI044",
  "40JIJ444",
  "40JIJ444",
  "440JI044",
  "4440JI44",
  "44444444",
},
{ "44444444",
  "44IJ0444", // $97
  "440IJ044",
  "444JIJ04",
  "444JIJ04",
  "440IJ044",
  "44IJ0444",
  "44444444",
},
{ "06600000",
  "60060000", // $98
  "06660000",
  "00060660",
  "06606006",
  "00000660",
  "00006006",
  "00000660",
},
{ "00000000",
  "00066000", // $99+
  "00600600",
  "00000600",
  "00066000",
  "00000000",
  "00060000",
  "00000000",
} },
gfx_moria[][8] = {
{ "00000000", // nothing
  "00000000", // $00
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
},
{ "SSSSSSSS", // dark floor
  "SSSSSSSS", // $01
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
},
{ "SSSSSSSS", // light floor
  "SSSSSSSS", // $02
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
},
{ "S0S0S0S0", // corridor floor
  "0S0S0S0S", // $03
  "S0S0S0S0",
  "0S0S0S0S",
  "S0S0S0S0",
  "0S0S0S0S",
  "S0S0S0S0",
  "0S0S0S0S",
},
{ "SSSSSSSS", // blocked floor
  "SSSSSSSS", // $04
  "SSSSV40S",
  "SSV4V4T0",
  "SV404V4V",
  "S4VTV4TT",
  "4V4V4T0V",
  "V40TV040",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $05
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $06
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $07
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $08
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $09
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $0A
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $0B
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "00000000", // wall
  "00000000", // $0C
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
},
{ "00000000", // wall
  "00000000", // $0D
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
},
{ "00000000", // wall
  "00000000", // $0E
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
},
{ "00000000", // boundary wall
  "00000000", // $0F
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $10
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $11
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "SSSSSSSS", // light floor
  "SSSSSSSS", // $12
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
},
{ "0UU00000", // open door
  "UVVU0000", // $13
  "UVVU0000",
  "UUUU0000",
  "UVVU0000",
  "UVWU0000",
  "UVVU0000",
  "UUUU0000",
},
{ "0VUUUUV0", // closed door
  "VUVVVVUV", // $14
  "VUVVVVUV",
  "VUUUUUUV",
  "VUVVVVUV",
  "VUVWWVUV",
  "VUVVVVUV",
  "VUUUUUUV",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $15
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $16
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $17
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $18
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $19
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $1A
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $1B
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "T4T4T4TS", // wall
  "4T4T4T4T", // $1C
  "T44T4T4T",
  "4TT44T4T",
  "T4TT44TT",
  "4T44TT4T",
  "T4T4T4TT",
  "ST4T4T4T",
},
{ "T4T4T4TS", // wall
  "4T4T4T4T", // $1D
  "T44T4T4T",
  "4TT44T4T",
  "T4TT44TT",
  "4T44TT4T",
  "T4T4T4TT",
  "ST4T4T4T",
},
{ "T4T4T4TS", // wall
  "4T4T4T4T", // $1E
  "T44T4T4T",
  "4TT44T4T",
  "T4TT44TT",
  "4T44TT4T",
  "T4T4T4TT",
  "ST4T4T4T",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $1F
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $20
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $21
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $22
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $23
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $24
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $25
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $26
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $27
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $28
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $29
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $2A
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $2B
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $2C
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $2D
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $2E
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $2F
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $30
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $31
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $32
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $33
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $34
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $35
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $36
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $37
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $38
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $39
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $3A
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $3B
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $3C
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $3D
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $3E
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $3F
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $40
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "SSSSSSSS", // town ground
  "SSSSSSSS", // $41 (A)
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
  "SSSSSSSS",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $42 (B)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "V0bbbbV0", // shop (there are various shops but they are all numbered $43)
  "0bbVVbbV", // $43 (C)
  "bbbVVbbb",
  "bVVVVVVb",
  "bbbVVbbb",
  "bbbVVbbb",
  "bbbVVbbb",
  "bbbVVbbb",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $44 (D)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $45 (E)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $46 (F)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $47 (G)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $48 (H)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $49 (I)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $4A (J)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $4B (K)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $4C (L)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $4D (M)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "LLLLLLLL",
  "LLLLLLLL", // $4E (N)
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
  "LLLLLLLL",
},
{ "XX000000", // town boundary
  "X0XXXXXX", // $4F (O)
  "0XXXXXXX",
  "X0XXXXXX",
  "XX000000",
  "X0XXXXXX",
  "0XXXXXXX",
  "X0XXXXXX",
},
{ "XX000000", // building
  "X0XXXXXX", // $50 (P)
  "0XXXXXXX",
  "X0XXXXXX",
  "XX000000",
  "X0XXXXXX",
  "0XXXXXXX",
  "X0XXXXXX",
},
{ "bUbUbUVU", // building
  "UbUbUbUV", // $51 (Q)
  "bUbUbUVU",
  "UVUVUVUb",
  "bUbUbUVU",
  "UbUbUbUV",
  "bUbUbUVU",
  "UVUVUVUb",
},
{ "bUVUVUbU", // building
  "VbUbUbVb", // $52 (R)
  "bUbUbUbV",
  "UbUbUbUV",
  "bUVUVUbU",
  "VbUbUbVb",
  "bUbUbUbV",
  "UbUbUbUV",
},
{ "0XXXXXX0", // building
  "0XXXXXX0", // $53 (S)
  "X0XXXX0X",
  "XX0000XX",
  "0XXXXXX0",
  "0XXXXXX0",
  "X0XXXX0X",
  "XX0000XX",
},
{ "SSSVVSSS", // you
  "SSVUUVSS", // $54
  "SSSUUSSS",
  "SXXXXXXS",
  "XSXXXXSX",
  "USYYYYSU",
  "SSYSSYSS",
  "SSYSSYSS",
} },
gfx_larn[][8] = {
{ "00000000", // $00 empty
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
  "00000000",
},
{ "00000000", // $01 altar
  "00000000",
  "00443300",
  "01212420",
  "01121220",
  "01112120",
  "11111222",
  "11112122",
},
{ "00110044", // $02 throne #1
  "77555550",
  "00533350",
  "44555566",
  "05333550",
  "55555050",
  "50005050",
  "50005000",
},
{ "00000000", // $03 orb #1
  "00222200",
  "02210220",
  "22100022",
  "22000022",
  "02200220",
  "00222200",
  "00000000",
},
{ "22222221", // $04 pit
  "10000012",
  "10000102",
  "12222002",
  "12222002",
  "12222002",
  "12222002",
  "11111112",
},
{ "00011111", // $05 stairs up
  "00000111",
  "00011021",
  "01100002",
  "00007777",
  "00007777",
  "27272727",
  "72707072",
},
{ "44444444", // $06 elevator up
  "40000004",
  "43333334",
  "40033004",
  "40033004",
  "40033004",
  "40000004",
  "44444444",
},
{ "00666660", // $07 living fountain
  "06660660",
  "00660000",
  "00066000",
  "22727222",
  "02272220",
  "00027000",
  "27272222",
},
{ "00111000", // $08 statue
  "01111000",
  "11011000",
  "11100110",
  "33111100",
  "33333110",
  "33333310",
  "33303311",
},
{ "44444444", // $09 teleport trap #1
  "40000004",
  "45555554",
  "40055004",
  "40055004",
  "40055004",
  "40000004",
  "44444444",
},
{ "00260000", // $0A college of Larn
  "02666000",
  "26666600",
  "66666660",
  "06656600",
  "00665000",
  "00060500",
  "00055000",
},
{ "22222222", // $0B mirror
  "22221222",
  "22210222",
  "22102222",
  "22022122",
  "22221022",
  "22210222",
  "22202222",
},
{ "11111111", // $0C DND store
  "14444441",
  "14444441",
  "11111111",
  "00022000",
  "00022000",
  "07022070",
  "00777700",
},
{ "11000000", // $0D stairs down
  "00112210",
  "00021110",
  "00111110",
  "44440000",
  "34340000",
  "33333333",
  "33333333",
},
{ "44444444", // $0E elevator down
  "40000004",
  "47777774",
  "40077004",
  "40077004",
  "40077004",
  "40000004",
  "44444444",
},
{ "00025000", // $0F bank of Larn #1
  "02555555",
  "25025000",
  "02555550",
  "00025025",
  "25555550",
  "00025000",
  "00000000",
},
{ "00025000", // $10 bank of Larn #2
  "02555555",
  "25025000",
  "02555550",
  "00025025",
  "25555550",
  "00025000",
  "00000000",
},
{ "00000000", // $11 dead fountain
  "00000000",
  "00000000",
  "00000000",
  "22727222",
  "02272220",
  "00027000",
  "27272222",
},
{ "00000000", // $12 gold #1
  "00455400",
  "05550540",
  "50555555",
  "22222222",
  "22722222",
  "22272222",
  "02222220",
},
{ "22222222", // $13 open door
  "20000441",
  "20004442",
  "20044442",
  "20044442",
  "20014442",
  "20043441",
  "22244422",
},
{ "22222222", // $14 closed door
  "24444441",
  "24444442",
  "21344442",
  "24444442",
  "24444442",
  "24444441",
  "22222222",
},
{ "00000000", // $15 wall ----
  "34443000",
  "34443300",
  "34443330",
  "03330333",
  "00333033",
  "00033303",
  "00000000",
},
{ "00000000", // $16 Eye of Larn
  "00555500",
  "05100150",
  "52066025",
  "52066025",
  "05100150",
  "00555500",
  "00000000",
},
{ "11100111", // $17 plate mail
  "12111121",
  "12556621",
  "12556621",
  "12665521",
  "12665521",
  "01222210",
  "00111100",
},
{ "66000066", // $18 chain mail
  "62666626",
  "61221126",
  "62112216",
  "61221126",
  "62112216",
  "06221160",
  "00666600",
},
{ "33311333", // $19 leather armour
  "32333323",
  "32272223",
  "32722223",
  "32222223",
  "32222223",
  "03222230",
  "00333300",
},
{ "44010000", // $1A sword of slashing
  "44111000",
  "00121000",
  "00124400",
  "00444000",
  "44421000",
  "45555550",
  "00757000",
},
{ "00000000", // $1B flailing hammer
  "44444440",
  "44425044",
  "00025000",
  "00025000",
  "00025000",
  "00025000",
  "00025000",
},
{ "50050050", // $1C sunsword
  "00555000",
  "50515050",
  "00525000",
  "50525050",
  "00525000",
  "77777770",
  "00272000",
},
{ "05000050", // $1D two-handed sword
  "52500525",
  "52500525",
  "52500525",
  "52500525",
  "52500525",
  "33333333",
  "00433400",
},
{ "14000000", // $1E spear
  "41400000",
  "04140000",
  "00414000",
  "00031300",
  "00003434",
  "00004444",
  "00000044",
},
{ "00000000", // $1F dagger
  "00242000",
  "03333300",
  "00525000",
  "00525000",
  "00050000",
  "00000000",
  "00000000",
},
{ "00000000", // $20 ring #1
  "00003000",
  "00344430",
  "00055500",
  "00500050",
  "00055500",
  "00000000",
  "00000000",
},
{ "00000000", // $21 ring #2
  "00006000",
  "00611160",
  "00055500",
  "00500050",
  "00055500",
  "00000000",
  "00000000",
},
{ "00000000", // $22 ring #3
  "00006000",
  "00611160",
  "00066600",
  "00600060",
  "00066600",
  "00000000",
  "00000000",
},
{ "00000000", // $23 ring #4
  "00006000",
  "00611160",
  "00011100",
  "00100010",
  "00011100",
  "00000000",
  "00000000",
},
{ "00000000", // $24 ring #5
  "00006000",
  "00611160",
  "00077700",
  "00700070",
  "00077700",
  "00000000",
  "00000000",
},
{ "00000000", // $25 ring #6
  "00006000",
  "00611160",
  "00044400",
  "00400040",
  "00044400",
  "00000000",
  "00000000",
},
{ "00000000", // $26 ring #7
  "00003000",
  "00344430",
  "00077700",
  "00700070",
  "00077700",
  "00000000",
  "00000000",
},
{ "00000000", // $27 ring #8
  "00003000",
  "00344430",
  "00011100",
  "00100010",
  "00011100",
  "00000000",
  "00000000",
},
{ "00000011", // $28 belt of striking
  "00001150",
  "00115000",
  "00001150",
  "00000011",
  "00000115",
  "00011500",
  "01150000",
},
{ "00202020", // $29 scroll
  "02111122",
  "21111221",
  "21111222",
  "21111200",
  "21111222",
  "21111212",
  "02020220",
},
{ "00000000", // $2A potion
  "02222220",
  "02000020",
  "01100110",
  "00144100",
  "01444410",
  "14444441",
  "11111111",
},
{ "10223200", // $2B book
  "11022222",
  "10110232",
  "11011022",
  "10101022",
  "01111022",
  "00011000",
  "00000000",
},
{ "55555555", // $2C chest
  "56652255",
  "55425525",
  "57552005",
  "56520005",
  "55520055",
  "00525500",
  "00555000",
},
{ "00000000", // $2D amulet
  "00444400",
  "04400340",
  "44000034",
  "34055543",
  "04550040",
  "00444400",
  "00000000",
},
{ "03535031", // $2E orb #2
  "36363513",
  "00033150",
  "00031500",
  "03315000",
  "33133350",
  "31353335",
  "13050033",
},
{ "00000034", // $2F scarab
  "11200343",
  "10113430",
  "11034310",
  "10343210",
  "13431010",
  "34300100",
  "43100110",
},
{ "01111134", // $30 cube
  "12011343",
  "10013431",
  "11134311",
  "10343401",
  "03431410",
  "34311100",
  "43000000",
},
{ "00222200", // $31 device
  "02000020",
  "02000020",
  "12222222",
  "12220122",
  "12200222",
  "01222220",
  "00222200",
},
{ "00000000", // $32 diamond
  "00000000",
  "01111110",
  "11661111",
  "01111210",
  "00112100",
  "00000000",
  "00000000",
},
{ "00000000", // $33 ruby
  "00000000",
  "04444440",
  "43733434",
  "04333340",
  "00444400",
  "00000000",
  "00000000",
},
{ "00000000", // $34 emerald
  "00000000",
  "07777770",
  "77177777",
  "07777070",
  "00770700",
  "00000000",
  "00000000",
},
{ "00000000", // $35 sapphire
  "00000000",
  "06666660",
  "66166666",
  "06666060",
  "00660600",
  "00000000",
  "00000000",
},
{ "00222200", // $36 dungeon entrance
  "02200220",
  "22000022",
  "22000022",
  "22004042",
  "22000022",
  "22000022",
  "22000022",
},
{ "00000000", // $37 top of volcanic shaft
  "00444000",
  "00244000",
  "02432200",
  "02243200",
  "22224320",
  "23443222",
  "33333322",
},
{ "00000000", // $38 base of volcanic shaft
  "00444000",
  "00244000",
  "02432200",
  "02243200",
  "22224320",
  "23443222",
  "33333322",
},
{ "42322220", // $39 battle axe
  "43222222",
  "42325500",
  "00005500",
  "00005500",
  "00005500",
  "00005500",
  "00005500",
},
{ "00050000", // $3A longsword
  "00555000",
  "00525000",
  "00525000",
  "00525000",
  "00525000",
  "33333333",
  "00434000",
},
{ "00000034", // $3B flail
  "40000370",
  "03370077",
  "00007777",
  "40070255",
  "03300250",
  "00002500",
  "00025500",
},
{ "77700777", // $3C ring mail
  "72777727",
  "75225527",
  "72552257",
  "75225527",
  "72552257",
  "07225570",
  "00777700",
},
{ "33300333", // $3D studded leather armour
  "32333323",
  "11272223",
  "32722311",
  "11222223",
  "32222311",
  "03222230",
  "00333300",
},
{ "55500555", // $3E splint mail
  "56555505",
  "56006605",
  "50066005",
  "50660065",
  "56600665",
  "05006650",
  "00555500",
},
{ "11100111", // $3F plate armour
  "15111151",
  "15755251",
  "17552521",
  "15525221",
  "15252221",
  "01522210",
  "00111100",
},
{ "11100111", // $40 stainless plate armour
  "15111151",
  "15555551",
  "15555551",
  "15555551",
  "15555551",
  "01555510",
  "00111100",
},
{ "50222050", // $41 lance of death
  "02010200",
  "52414250",
  "02414200",
  "52414250",
  "02414200",
  "24111420",
  "02414200",
},
{ "44444444", // $42 arrow trap #1
  "40000004",
  "41111114",
  "40011004",
  "40011004",
  "40011004",
  "40000004",
  "44444444",
},
{ "11111111", // $43 arrow trap #2
  "10000001", // we make it visible
  "10000001",
  "10000001",
  "10000001",
  "10000001",
  "10000001",
  "11111111",
},
{ "22200222", // $44 shield
  "21116662",
  "21116662",
  "21116662",
  "26661112",
  "26661112",
  "02661120",
  "00222200",
},
{ "00222300", // $45 your home
  "02222330",
  "22222333",
  "44444030",
  "40044333",
  "40044333",
  "44444333",
  "44444333",
},
{ "00000000", // $46 gold #2
  "00455400",
  "05550540",
  "50555555",
  "22222222",
  "22722222",
  "22272222",
  "02222220",
},
{ "00000000", // $47 gold #3
  "00455400",
  "05550540",
  "50555555",
  "22222222",
  "22722222",
  "22272222",
  "02222220",
},
{ "00000000", // $48 gold #4
  "00455400",
  "05550540",
  "50555555",
  "22222222",
  "22722222",
  "22272222",
  "02222220",
},
{ "11111111", // $49 dart trap #1
  "10000001", // we make it visible
  "10000001",
  "10000001",
  "10000001",
  "10000001",
  "10000001",
  "11111111",
},
{ "44444444", // $4A dart trap #2
  "40000004",
  "46666664",
  "40066004",
  "40066004",
  "40066004",
  "40000004",
  "44444444",
},
{ "44444444", // $4B trapdoor #1
  "40000004",
  "42222224",
  "40022004",
  "40022004",
  "40022004",
  "40000004",
  "44444444",
},
{ "11111111", // $4C trapdoor #2
  "10000001", // we make it visible
  "10000001",
  "10000001",
  "10000001",
  "10000001",
  "10000001",
  "11111111",
},
{ "04400000", // $4D trading post
  "44440000",
  "04400440",
  "00004444",
  "00000440",
  "04400000",
  "44440000",
  "04400000",
},
{ "11111111", // $4E teleport trap #2
  "10000001", // we make it visible
  "10000001",
  "10000001",
  "10000001",
  "10000001",
  "10000001",
  "11111111",
},
{ "00000000", // $4F throne #2
  "00555550",
  "00533350",
  "00555550",
  "05333550",
  "55555050",
  "50005050",
  "50005000",
},
{ "00000000", // $50 sphere
  "00444400",
  "04414340",
  "44143334",
  "34434333",
  "04343340",
  "00444400",
  "00000000",
},
{ "00110044", // $51 throne #3
  "77555550",
  "00533350",
  "44555566",
  "05333550",
  "55555050",
  "50005050",
  "50005000",
},
{ "01000111", // $52 revenue service
  "01000101",
  "01000111",
  "00000000",
  "10100111",
  "11100101",
  "00100111",
  "00000000",
},
{ "00000000", // $53 fortune cookie
  "00000000",
  "05555550",
  "55005555",
  "55555005",
  "55005555",
  "05555550",
  "00000000",
},
{ "34443333", // $54 wall ---N
  "34443333",
  "34443333",
  "34443333",
  "03330333",
  "00333033",
  "00033303",
  "00000000",
},
{ "00000000", // $55 wall --S-
  "34443000",
  "34443300",
  "34443330",
  "34440333",
  "34443033",
  "34443303",
  "34443330",
},
{ "34443333", // $56 wall --SN
  "34443333",
  "34443333",
  "34443333",
  "34440333",
  "34443033",
  "34443303",
  "34443330",
},
{ "00000000", // $57 wall -W--
  "44443000",
  "44443300",
  "44443330",
  "33330333",
  "33333033",
  "33333303",
  "00000000",
},
{ "34443333", // $58 wall -W-N
  "44443333",
  "44443333",
  "44443333",
  "33330333",
  "33333033",
  "33333303",
  "00000000",
},
{ "00000000", // $59 wall -WS-
  "44443000",
  "44443300",
  "44443330",
  "34440333",
  "34443033",
  "34443303",
  "34443330",
},
{ "34443333", // $5A wall -WSN
  "44443333",
  "44443333",
  "44443333",
  "34440333",
  "34443033",
  "34443303",
  "34443330",
},

{ "00000000", // $5B wall E---
  "34444444",
  "34444444",
  "34444444",
  "03330333",
  "00333033",
  "00033303",
  "00000000",
},
{ "34443333", // $5C wall E--N
  "34444444",
  "34444444",
  "34444444",
  "03330333",
  "00333033",
  "00033303",
  "00000000",
},
{ "00000000", // $5D wall E-S-
  "34444444",
  "34444444",
  "34444444",
  "34440333",
  "34443033",
  "34443303",
  "34443330",
},
{ "34443333", // $5E wall E-SN
  "34444444",
  "34444444",
  "34444444",
  "34440333",
  "34443033",
  "34443303",
  "34443330",
},
{ "00000000", // $5F wall EW--
  "44444444",
  "44444444",
  "44444444",
  "33330333",
  "33333033",
  "33333303",
  "00000000",
},
{ "34443333", // $60 wall EW-N
  "44444444",
  "44444444",
  "44444444",
  "33330333",
  "33333033",
  "33333303",
  "33333330",
},
{ "00000000", // $61 wall EWS-
  "44444444",
  "44444444",
  "44444444",
  "34440333",
  "34443033",
  "34443303",
  "34443330",
},
{ "34443333", // $62 wall EWSN
  "44444444",
  "44444444",
  "44444444",
  "34440333",
  "34443033",
  "34443303",
  "34443330",
},
{ "77777777", // $63 you
  "77777777",
  "77777777",
  "77777777",
  "77777777",
  "77777777",
  "77777777",
  "77777777",
},
{ "11111111", // $64 unknowns
  "11000111",
  "11111011",
  "11100111",
  "11101111",
  "11111111",
  "11101111",
  "11111111",
} };

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (15 * 2)] =
{   0x0000, 0x0000, // reserved

/*  LD.. .... .... ....    . = Transparent (%00)
    DLD. .... .... ....    L = Light red   (%01)
    .DLD .... .... ....    D = Dark red    (%10)
    ..DL D... .... ....    B = Bone        (%11)
    ...D LD.. .... ....
    .... DLD. .... ....
    .... .DLD .... ....
    .... ..DL D... B...
    .... ...D LD.. B...
    .... .... DLDB ....
    .... .... .DBB ....
    .... .... .BBB B...
    .... ...B B..B BB..
    .... .... .... BBB.
    .... .... .... .B..

    Plane 0 Plane 1 */
    0x8000, 0x4000, 
    0x4000, 0xA000, 
    0x2000, 0x5000, 
    0x1000, 0x2800, 
    0x0800, 0x1400, 
    0x0400, 0x0A00, 
    0x0200, 0x0500, 
    0x0108, 0x0288, 
    0x0088, 0x0148, 
    0x0050, 0x00B0, 
    0x0030, 0x0070, 
    0x0078, 0x0078, 
    0x019C, 0x019C, 
    0x000E, 0x000E, 
    0x0004, 0x0004, 

    0x0000, 0x0000  // reserved
};
#endif

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   TEXT  name[31 + 1];
    ULONG rank,
          gp,
          cause,
          dungeon_level,
          race,
          class,
          sex;
    UBYTE slot;
/*  ULONG birth_date;
    UWORD maxhp,
          curhp;
    UBYTE lev,
          deepest;
    TEXT  died_from[25 + 1]; */
} score[100];

// 8. CODE ---------------------------------------------------------------

EXPORT void rogue_main(void)
{   tool_open      = rogue_open;
    tool_loop      = rogue_loop;
    tool_save      = rogue_save;
    tool_close     = rogue_close;
    tool_exit      = rogue_exit;
    tool_subgadget = rogue_subgadget;

    if (loaded != FUNC_ROGUE && !rogue_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_ROGUE;

    rogue_getpens();
    make_speedbar_list(GID_ROGUE_SB1);
    load_aiss_images( 9, 10);
    makesexlist();
    load_aiss_images(15, 16);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_ROGUE_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            AddHLayout,
                AddToolbar(GID_ROGUE_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddVLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_ROGUE_CH11] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_ROGUE_CH11,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    LAYOUT_AddChild,                       gadgets[GID_ROGUE_CH12] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_ROGUE_CH12,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &FiletypeOptions,
                    ChooserEnd,
                    Label("File type:"),
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_Label,                              "Hall of Fame (High Score Table)",
                AddHLayout,
                    AddVLayout,
                        LAYOUT_HorizAlignment,             LALIGN_RIGHT,
                        AddLabel(""),
                        PlacingGad(0),
                        PlacingGad(1),
                        PlacingGad(2),
                        PlacingGad(3),
                        PlacingGad(4),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    AddVLayout,
                        LAYOUT_HorizAlignment,             LALIGN_CENTER,
                        AddLabel("Gold/Points"),
                        GoldGad(0),
                        GoldGad(1),
                        GoldGad(2),
                        GoldGad(3),
                        GoldGad(4),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   33,
                    AddVLayout,
                        LAYOUT_HorizAlignment,             LALIGN_CENTER,
                        AddLabel("Character Name"),
                        NameGad(0),
                        NameGad(1),
                        NameGad(2),
                        NameGad(3),
                        NameGad(4),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   66,
                    AddVLayout,
                        LAYOUT_HorizAlignment,             LALIGN_CENTER,
                        AddLabel("Sex"),
                        SexGad(0),
                        SexGad(1),
                        SexGad(2),
                        SexGad(3),
                        SexGad(4),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    AddVLayout,
                        LAYOUT_HorizAlignment,             LALIGN_CENTER,
                        AddLabel("Race"),
                        RaceGad(0),
                        RaceGad(1),
                        RaceGad(2),
                        RaceGad(3),
                        RaceGad(4),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    AddVLayout,
                        LAYOUT_HorizAlignment,             LALIGN_CENTER,
                        AddLabel("Class"),
                        ClassGad(0),
                        ClassGad(1),
                        ClassGad(2),
                        ClassGad(3),
                        ClassGad(4),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    AddVLayout,
                        LAYOUT_HorizAlignment,             LALIGN_CENTER,
                        AddLabel("Rank (Exp Level)"),
                        RankGad(0),
                        RankGad(1),
                        RankGad(2),
                        RankGad(3),
                        RankGad(4),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    AddVLayout,
                        LAYOUT_HorizAlignment,             LALIGN_CENTER,
                        AddLabel("Dgn Lvl"),
                        LevelGad(0),
                        LevelGad(1),
                        LevelGad(2),
                        LevelGad(3),
                        LevelGad(4),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    LAYOUT_AddChild,                       gadgets[GID_ROGUE_SC1] = (struct Gadget*)
                    ScrollerObject,
                        GA_ID,                             GID_ROGUE_SC1,
                        GA_RelVerify,                      TRUE,
                        SCROLLER_Total,                    100,
                        SCROLLER_Visible,                  HISCOREGADS,
                        SCROLLER_Orientation,              SORIENT_VERT,
                        SCROLLER_Arrows,                   TRUE,
                    ScrollerEnd,
                    CHILD_WeightedWidth,                   0,
                LayoutEnd,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    SortButton(GID_ROGUE_BU4, "Sort Scores"),
                    AddSpace,
                    AddLabel("Use the cursor keys to scroll the high score table."),
                    CHILD_WeightedWidth,                   0,
                    AddSpace,
                    ClearButton(GID_ROGUE_BU2, "Clear High Scores"),
                    CHILD_WeightedWidth,                   0,
                LayoutEnd,
            LayoutEnd,
            AddLabel(""),
            AddVLayout,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_Label,                              "Saved Game",
                AddHLayout,
                    AddVLayout,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_Label,                       "General",
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_EvenSize,               TRUE,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_ST1] = (struct Gadget*)
                            StringObject,
                                GA_ID,                     GID_ROGUE_ST1,
                                GA_TabCycle,               TRUE,
                                STRINGA_TextVal,           yourname,
                                STRINGA_MaxChars,          maxname[game] + 1,
                            StringEnd,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("Fruit Name:"),
                                AddSpace,
                            LayoutEnd,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_ST2] = (struct Gadget*)
                            StringObject,
                                GA_ID,                     GID_ROGUE_ST2,
                                GA_TabCycle,               TRUE,
                                STRINGA_TextVal,           fruitname,
                                STRINGA_MaxChars,          maxname[game] + 1,
                            StringEnd,
                        LayoutEnd,
                        Label("_Character Name:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_EvenSize,               TRUE,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN42] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN42,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           32767,
                                INTEGER_Number,            food,
                                INTEGER_MinVisible,        5 + 1,
                            IntegerEnd,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("Digested:"),
                                AddSpace,
                            LayoutEnd,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN43] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN43,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           -32768,
                                INTEGER_Maximum,           32767,
                                INTEGER_Number,            digested,
                                INTEGER_MinVisible,        6 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("_Food:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_EvenSize,               TRUE,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN1] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN1,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           maxgp[game],
                                INTEGER_Number,            gp,
                                INTEGER_MinVisible,        5 + 1,
                            IntegerEnd,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("Moves:"),
                                AddSpace,
                            LayoutEnd,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN6] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN6,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           ONE_BILLION,
                                INTEGER_Number,            moves,
                                INTEGER_MinVisible,        10 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Gold:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_EvenSize,               TRUE,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN41] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN41,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           32767,
                                INTEGER_Number,            age,
                                INTEGER_MinVisible,        5 + 1,
                            IntegerEnd,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("Sex:"),
                                AddSpace,
                            LayoutEnd,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_CH13] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                     GID_ROGUE_CH13,
                                CHOOSER_Labels,            &SexList,
                            ChooserEnd,
                        LayoutEnd,
                        Label("Age:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_EvenSize,               TRUE,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN17] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN17,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           1,
                                INTEGER_Number,            level,
                                INTEGER_Maximum,           99999999,
                                INTEGER_MinVisible,        8 + 1,
                            IntegerEnd,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("Experience:"),
                                AddSpace,
                            LayoutEnd,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN14] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN14,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Number,            experience,
                                INTEGER_MinVisible,        10 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Level:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_ROGUE_ST13] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROGUE_ST13,
                            GA_ReadOnly,                   TRUE,
                            STRINGA_TextVal,               history[0],
                            STRINGA_MaxChars,              59 + 1 + 1,
                        StringEnd,
                        Label("History:"),
                        LAYOUT_AddChild,                   gadgets[GID_ROGUE_ST14] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROGUE_ST14,
                            GA_ReadOnly,                   TRUE,
                            STRINGA_TextVal,               history[1],
                            STRINGA_MaxChars,              59 + 1 + 1,
                        StringEnd,
                        Label(""),
                        LAYOUT_AddChild,                   gadgets[GID_ROGUE_ST15] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROGUE_ST15,
                            GA_ReadOnly,                   TRUE,
                            STRINGA_TextVal,               history[2],
                            STRINGA_MaxChars,              59 + 1 + 1,
                        StringEnd,
                        Label(""),
                        LAYOUT_AddChild,                   gadgets[GID_ROGUE_ST16] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_ROGUE_ST16,
                            GA_ReadOnly,                   TRUE,
                            STRINGA_TextVal,               history[3],
                            STRINGA_MaxChars,              59 + 1 + 1,
                        StringEnd,
                        Label(""),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_Label,                      "Attributes",
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN4,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           attrlimit[game],
                                INTEGER_Number,            curstr,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           50,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("of"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_ROGUE_IN35] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_ROGUE_IN35,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       attrlimit[game],
                                    INTEGER_Number,        maxstr,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,           50,
                        LayoutEnd,
                        Label("Strength:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN30] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN30,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           attrlimit[game],
                                INTEGER_Number,            curiq,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           50,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("of"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_ROGUE_IN36] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_ROGUE_IN36,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       attrlimit[game],
                                    INTEGER_Number,        maxiq,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,           50,
                        LayoutEnd,
                        Label("Intelligence:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN31] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN31,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           attrlimit[game],
                                INTEGER_Number,            curwis,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           50,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("of"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_ROGUE_IN37] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_ROGUE_IN37,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       attrlimit[game],
                                    INTEGER_Number,        maxwis,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,           50,
                        LayoutEnd,
                        Label("Wisdom:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN32] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN32,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           attrlimit[game],
                                INTEGER_Number,            curdex,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           50,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("of"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_ROGUE_IN38] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_ROGUE_IN38,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       attrlimit[game],
                                    INTEGER_Number,        maxdex,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,           50,
                        LayoutEnd,
                        Label("Dexterity:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN33] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN33,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           attrlimit[game],
                                INTEGER_Number,            curcon,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           50,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("of"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_ROGUE_IN39] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_ROGUE_IN39,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       attrlimit[game],
                                    INTEGER_Number,        maxcon,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,           50,
                        LayoutEnd,
                        Label("Constitution:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN34] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN34,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           attrlimit[game],
                                INTEGER_Number,            curcha,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           50,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("of"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_ROGUE_IN40] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_ROGUE_IN40,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       attrlimit[game],
                                    INTEGER_Number,        maxcha,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,           50,
                        LayoutEnd,
                        Label("Charisma:"),
                        AddLabel(""),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN2] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN2,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           hplimit[game],
                                INTEGER_Number,            curhp,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           50,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("of"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_ROGUE_IN3] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_ROGUE_IN3,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       hplimit[game],
                                    INTEGER_Number,        maxhp,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,           50,
                        LayoutEnd,
                        Label("Hit Points:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_ROGUE_IN15] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_ROGUE_IN15,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           125,
                                INTEGER_Number,            cursp,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            CHILD_WeightedWidth,           50,
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                AddLabel("of"),
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_ROGUE_IN16] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_ROGUE_IN16,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       125,
                                    INTEGER_Number,        maxsp,
                                    INTEGER_MinVisible,    3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            CHILD_WeightedWidth,           50,
                        LayoutEnd,
                        Label("Spell Points:"),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                LayoutEnd,
                AddHLayout,
                    MapButton(     GID_ROGUE_BU3, "_Location..."),
                    MaximizeButton(GID_ROGUE_BU1, "Maximize Character"),
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_ROGUE_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();

    loop();

    readgadgets();
    closewindow();
}

EXPORT void rogue_loop(ULONG gid, UNUSED ULONG code)
{   int i;

    switch (gid)
    {
    case GID_ROGUE_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_ROGUE_BU2:
        readgadgets(); // probably unnecessary
        clearscores();
        writegadgets();
    acase GID_ROGUE_BU3:
        mapwindow();
    acase GID_ROGUE_BU4:
        readgadgets();
        sortscores();
        writegadgets();
    acase GID_ROGUE_SC1:
        readgadgets();
        DISCARD GetAttr(SCROLLER_Top, (Object*) gadgets[GID_ROGUE_SC1], (ULONG*) &firstplace);
        writegadgets();
    adefault:
        if (gid >= GID_ROGUE_CH24 && gid <= GID_ROGUE_CH24 + HISCOREGADS - 1)
        {   i = gid - GID_ROGUE_CH24;
            DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[gid], (ULONG*) &score[firstplace + i].class);
            if (game == GAME_MORIA)
            {   DISCARD SetGadgetAttrs
                (   gadgets[GID_ROGUE_CH1 + i], MainWindowPtr, NULL,
                    CHOOSER_LabelArray, &MoriaRankOptions[score[firstplace + i].class],
                TAG_DONE); // autorefreshes
}   }   }   }

EXPORT FLAG rogue_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_ROGUE_IN5:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_ROGUE_IN5], (ULONG*) &dungeonnow);
        if (game == GAME_LARN)
        {   larn_changemap();
        }
        rogue_drawmap();
    acase GID_ROGUE_IN7:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_ROGUE_IN7], (ULONG*) &xpos);
        rogue_drawmap();
    acase GID_ROGUE_IN8:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_ROGUE_IN8], (ULONG*) &ypos);
        rogue_drawmap();
    acase GID_ROGUE_SC2:
        DISCARD GetAttr(SCROLLER_Top,   (Object*) gadgets[GID_ROGUE_SC2], (ULONG*) &leftx);
        rogue_drawmap();
    acase GID_ROGUE_SC3:
        DISCARD GetAttr(SCROLLER_Top,   (Object*) gadgets[GID_ROGUE_SC3], (ULONG*) &topy);
        rogue_drawmap();
    acase GID_ROGUE_BU5:
        larn_reveal();
        larn_changemap();
        rogue_drawmap();
    }

    return FALSE;
}

EXPORT FLAG rogue_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if   (gamesize        ==   460) { game = GAME_ROGUE; filetype = FT_HISCORES; }
        elif (gamesize        ==  1680) { game = GAME_LARN;  filetype = FT_HISCORES; }
        elif (gamesize        == 10000) { game = GAME_ROGUE; filetype = FT_SAVEGAME; }
        elif (gamesize        ==     0)
        {   filetype = FT_HISCORES;
            if (ask("Which game is this for?", "HackLite|Moria") == 0) // HackLite
            {   game = GAME_HACK;
            } else
            {   game = GAME_MORIA;
        }   }
        elif (gamesize %   73 ==     3) { game = GAME_MORIA; filetype = FT_HISCORES; }
        elif
        (   IOBuffer[0] == 5 // major version
         && IOBuffer[1] == 5 // minor version
         && IOBuffer[2] == 0 // patch level
        )                               { game = GAME_MORIA; filetype = FT_SAVEGAME; } // check for this *before* checking for HackLite high scores
        elif (gamesize %  150 ==     0) { game = GAME_HACK;  filetype = FT_HISCORES; }
        elif (gamesize % 9112 ==   787) { game = GAME_LARN;  filetype = FT_SAVEGAME; }
        elif (IOBuffer[0]     ==  0xEF) { game = GAME_HACK;  filetype = FT_SAVEGAME; }
        else return FALSE;

        serializemode = SERIALIZE_READ;
        if (filetype == FT_HISCORES) serialize_hiscores(); else serialize_savegame();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   TRANSIENT int  i;
    PERSIST   TEXT placingstr[10][5 + 1]; // this is not copied! Enough for "#100:"

    if
    (   page != FUNC_ROGUE
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    rogue_ghost();

    gadmode = SERIALIZE_WRITE;
    either_ch(GID_ROGUE_CH11, &game);
    either_ch(GID_ROGUE_CH12, &filetype);

    for (i = 0; i < HISCOREGADS; i++)
    {   switch (game)
        {
        case GAME_ROGUE:
            DISCARD SetGadgetAttrs
            (   gadgets[GID_ROGUE_CH1 + i], MainWindowPtr, NULL,
                CHOOSER_LabelArray, &RogueRankOptions,
            TAG_DONE); // autorefreshes
        acase GAME_MORIA:
            DISCARD SetGadgetAttrs
            (   gadgets[GID_ROGUE_CH1 + i], MainWindowPtr, NULL,
                CHOOSER_LabelArray, &MoriaRankOptions[score[firstplace + i].class],
            TAG_DONE); // autorefreshes
            DISCARD SetGadgetAttrs
            (   gadgets[GID_ROGUE_CH24 + i], MainWindowPtr, NULL,
                CHOOSER_LabelArray, &MoriaClassOptions,
            TAG_DONE); // autorefreshes
        acase GAME_HACK:
            DISCARD SetGadgetAttrs
            (   gadgets[GID_ROGUE_CH24 + i], MainWindowPtr, NULL,
                CHOOSER_LabelArray, &HackClassOptions,
            TAG_DONE); // autorefreshes
        }

        sprintf(placingstr[i], "#%d:", firstplace + i + 1);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_ROGUE_ST17 + i], MainWindowPtr, NULL,
            STRINGA_TextVal, placingstr[i],
        TAG_DONE); // autorefreshes

        // Moria high scores can be at least $7FFFFFFF but cause slight justification issues in-game if > 99,999,999
        DISCARD SetGadgetAttrs
        (   gadgets[GID_ROGUE_IN9 + i], MainWindowPtr, NULL,
            INTEGER_Maximum, maxgp[game],
        TAG_DONE); // autorefreshes
        DISCARD SetGadgetAttrs
        (   gadgets[GID_ROGUE_IN19 + i], MainWindowPtr, NULL,
            INTEGER_Maximum, maxlevel[game],
        TAG_DONE); // autorefreshes
        DISCARD SetGadgetAttrs
        (   gadgets[GID_ROGUE_ST3 + i], MainWindowPtr, NULL,
            STRINGA_MaxChars, maxhiname[game] + 1,
        TAG_DONE); // autorefreshes
    }

    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_ST1], MainWindowPtr, NULL,
        STRINGA_MaxChars, maxname[game] + 1,
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_ST2], MainWindowPtr, NULL,
        STRINGA_MaxChars, maxname[game] + 1,
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN1], MainWindowPtr, NULL,
        INTEGER_Maximum, maxgp[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN2], MainWindowPtr, NULL,
        INTEGER_Maximum, hplimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN3], MainWindowPtr, NULL,
        INTEGER_Maximum, hplimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN4], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN30], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN31], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN32], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN33], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN34], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN35], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN36], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN37], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN38], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN39], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_ROGUE_IN40], MainWindowPtr, NULL,
        INTEGER_Maximum, attrlimit[game],
    TAG_DONE); // autorefreshes

    eithergadgets();
    /* We do that last to avoid this scenario:
       Game was Moria
       Loaded a Hack wizard (class 12)
       Program wrote 12 to the class gadget, but the Moria class list was
        still in use by it, so it was rejected (as the highest Moria class
        is 5).
       Therefore we change the class list first. */
}

MODULE void eithergadgets(void)
{   int i;

    if (gadmode == SERIALIZE_WRITE)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_ROGUE_SC1], MainWindowPtr, NULL,
            SCROLLER_Top, firstplace,
        TAG_END); // this refreshes automatically
    }

    if (filetype == FT_HISCORES)
    {   for (i = 0; i < HISCOREGADS; i++)
        {   either_st(GID_ROGUE_ST3  + i,  score[firstplace + i].name);
            either_in(GID_ROGUE_IN9  + i, &score[firstplace + i].gp);
            either_in(GID_ROGUE_IN19 + i, &score[firstplace + i].dungeon_level);
            either_ch(GID_ROGUE_CH1  + i, &score[firstplace + i].rank);
            either_ch(GID_ROGUE_CH14 + i, &score[firstplace + i].race);
            either_ch(GID_ROGUE_CH24 + i, &score[firstplace + i].class);
            either_ch(GID_ROGUE_CH34 + i, &score[firstplace + i].sex);
    }   }
    else
    {   either_st(GID_ROGUE_ST1 , yourname);
        either_st(GID_ROGUE_ST2 , fruitname);
        either_st(GID_ROGUE_ST13, history[0]);
        either_st(GID_ROGUE_ST14, history[1]);
        either_st(GID_ROGUE_ST15, history[2]);
        either_st(GID_ROGUE_ST16, history[3]);
        either_in(GID_ROGUE_IN1 , &gp);
        either_in(GID_ROGUE_IN2 , &curhp);
        either_in(GID_ROGUE_IN3 , &maxhp);
        either_in(GID_ROGUE_IN4 , &curstr);
        either_in(GID_ROGUE_IN6 , &moves);
        either_in(GID_ROGUE_IN14, &experience);
        either_in(GID_ROGUE_IN15, &cursp);
        either_in(GID_ROGUE_IN16, &maxsp);
        either_in(GID_ROGUE_IN17, &level);
        either_in(GID_ROGUE_IN30, &curiq);
        either_in(GID_ROGUE_IN31, &curwis);
        either_in(GID_ROGUE_IN32, &curdex);
        either_in(GID_ROGUE_IN33, &curcon);
        either_in(GID_ROGUE_IN34, &curcha);
        either_in(GID_ROGUE_IN35, &maxstr);
        either_in(GID_ROGUE_IN36, &maxiq);
        either_in(GID_ROGUE_IN37, &maxwis);
        either_in(GID_ROGUE_IN38, &maxdex);
        either_in(GID_ROGUE_IN39, &maxcon);
        either_in(GID_ROGUE_IN40, &maxcha);
        either_ch(GID_ROGUE_CH13, &sex);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize_hiscores(void)
{   TRANSIENT UBYTE rc;
    TRANSIENT int   i, j;
#ifdef WRITEDECRYPTED
    TRANSIENT BPTR  FileHandle;
    PERSIST   TEXT  tempstring[MAX_PATH + 1]; // PERSISTent so as not to blow the stack
#endif

    // assert(filetype == FT_HISCORES);

    if (serializemode == SERIALIZE_READ)
    {   clearvars();
        clearscores(); // to clear any unused entries
    }

    switch (game)
    {
    case GAME_HACK:
        if (gamesize == 0)
        {   numscores = 0;
            return;
        }

        offset = 4;
        for (i = 0; i < gamesize / 150; i++)
        {   serialize4(&score[i].gp);                 //  4..  7

            offset +=  20;                            //  8.. 27

            score[i].class = (ULONG) HackClassOptions[score[i].class][0];
            serialize1(&score[i].class);              // 28
            for (j = 0; j < 13; j++)
            {   if (score[i].class == HackClassOptions[j][0])
                {   score[i].class = j;
                    break; // for speed
            }   }

            offset +=   2;                            // 29.. 30

            serstring(score[i].name);                 // 31+

            offset += 123;
        }
        numscores = i;
    acase GAME_MORIA:
        if (gamesize == 0)
        {   numscores = 0;
            return;
        }

        // decrypt
        xor_byte = IOBuffer[0];
        offset = 1;
        do
        {   rc = IOBuffer[offset] ^ xor_byte;
            xor_byte = IOBuffer[offset];
            IOBuffer[offset++] = rc;
        } while ((int) offset < gamesize);

#ifdef WRITEDECRYPTED
        // write decrypted file
        strcpy(tempstring, pathname);
        strcat(tempstring, ".decrypted");
        if ((FileHandle = (BPTR) Open(tempstring, MODE_NEWFILE)))
        {   DISCARD Write(FileHandle, IOBuffer, (LONG) gamesize);
            DISCARD Close(FileHandle);
            // FileHandle = ZERO;
        }
#endif

        offset = 4;
        i = 0;
        do
        {   serialize4i(    &score[i].gp);

            offset += 10;
         /* instead of:
            serialize4i(    &score[i].birth_date); // seconds since 1/1/1970 - never shown to user
            serialize2iword(&score[i].uid       ); // UNIX user ID (always 0 on Amiga) - never shown to user
            serialize2iword(&score[i].maxhp     ); // never shown to user
            serialize2iword(&score[i].curhp     ); // never shown to user
         */

            score[i].dungeon_level--;
            serialize1(     &score[i].dungeon_level);
            score[i].dungeon_level++;

            serialize1(     &score[i].rank);

            offset++;;
         /* instead of:
            serialize1to1(  &score[i].deepest   ); // never shown to user
         */

            score[i].sex = (score[i].sex == MALE) ? 'M' : 'F';
            serialize1(     &score[i].sex);
            score[i].sex = (score[i].sex == 'M') ? MALE : FEMALE;

            serialize1(     &score[i].race);

            serialize1(     &score[i].class);

            if (serializemode == SERIALIZE_READ)
            {   zstrncpy(score[i].name, (char*) &IOBuffer[offset],      27);
                offset += 27;
             // zstrncpy(score[i].died_from, (char*) &IOBuffer[offset], 25);
            } else
            {   strncpy((char*) &IOBuffer[offset], score[i].name,       27); // this is no mistake, we don't necessarily want a trailing EOS
                offset += 27;
             // strncpy((char*) &IOBuffer[offset], score[i].died_from,  25); // this is no mistake, we don't necessarily want a trailing EOS
            }

            offset += 25 + 1;

            i++;
        } while ((int) offset < gamesize);
        numscores = i;

        // reencrypt
        xor_byte = IOBuffer[0];
        offset = 1;
        do
        {   xor_byte ^= IOBuffer[offset];
            IOBuffer[offset++] = xor_byte;
        } while ((int) offset < gamesize);
    acase GAME_ROGUE:
        for (i = 0; i < 10; i++)
        {   offset =  46 * i;
            serstring(score[i].name);
            offset = (46 * i) + 0x27;
            serialize1(&score[i].rank);
            serialize2ulong(&score[i].gp);
            offset++;
            serialize1(&score[i].cause);
            offset++;
            serialize1(&score[i].dungeon_level);
        }

        firstplace =  0;
        numscores  = 10;
    acase GAME_LARN:
        if (serializemode == SERIALIZE_READ)
        {   firstplace =  0;
            numscores  = 20;

            // losers table
            for (i = 0; i < 10; i++)
            {   score[10 + i].slot = i;

                offset = 108 * i;
                serialize4(&score[10 + i].gp);                 //  $0..$3
                offset += 6;                                   //  $4..$9
                serialize2ulong(&score[10 + i].dungeon_level); //  $A..$B
                offset += 4;                                   //  $C..$F
                serstring(score[10 + i].name);                 // $10+
            }

            // winners table
            for (i = 0; i < 10; i++)
            {   score[i].slot          = i;
                score[i].dungeon_level = 13;

                offset = 1080 + (60 * i);
                serialize4(&score[i].gp);                      //  $0..$3
                offset += 16;                                  //  $4..$13
                serstring(score[i].name);                      // $14+
            }

            sortscores(); // because the game does not really sort them
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);

            // losers table
            for (i = 0; i < 10; i++)
            {   offset = 108 * score[10 + i].slot;
                serialize4(&score[10 + i].gp);                 //  $0..$3
                offset += 4;                                   //  $4..$7
                if (score[10 + i].gp && IOBuffer[offset] == 0 && IOBuffer[offset + 1] == 0) // cause of death
                {   IOBuffer[offset    ] = 0x01;               //  $8
                    IOBuffer[offset + 1] = 0x0D;               //  $9
                }
                offset += 2;                                   //  $8..$9
                serialize2ulong(&score[10 + i].dungeon_level); //  $A..$B
                offset += 2;                                   //  $C..$D
                serialize2ulong((ULONG*) &i);                  //  $E..$F
                serstring(score[10 + i].name);                 // $10+
            }

            // winners table
            for (i = 0; i < 10; i++)
            {   offset = 1080 + (60 * score[i].slot);
                serialize4(&score[i].gp);                      //  $0..$3
                offset += 14;                                  //  $4..$11
                serialize2ulong((ULONG*) &i);                  // $12..$13
                serstring(score[i].name);                      // $14+
}   }   }   }

MODULE void serialize_savegame(void)
{   TRANSIENT FLAG   ok;
    TRANSIENT UBYTE  rc;
    TRANSIENT int    esize,
                     found,
                     i, j, k,
                     items,
                     length,
                     x, y;
#ifdef WRITEDECRYPTED
    TRANSIENT BPTR   FileHandle;
#endif
    TRANSIENT UBYTE* OtherBuffer;
    PERSIST   TEXT   tempstring[MAX_PATH + 1]; // PERSISTent so as not to blow the stack

    // assert(filetype == FT_SAVEGAME);

    if (serializemode == SERIALIZE_READ)
    {   clearvars();
        clearscores();
    }

    switch (game)
    {
    case GAME_HACK:
        // calculate expanded size
        offset = esize = 0;
        do
        {   if (IOBuffer[offset] == 0xEF)
            {   if (IOBuffer[offset + 1] == 0)
                {   esize++;
                } else
                {   esize += IOBuffer[offset + 1] + 1;
                }
                offset += 2;
            } else
            {   esize++;
                offset++;
        }   }
        while ((int) offset < gamesize);

        if (!(OtherBuffer = calloc(1, esize)))
        {   rq("Out of memory!");
        }
        // now expand into buffer
        OtherBuffer[0] = IOBuffer[0];
        OtherBuffer[1] = IOBuffer[1];
        OtherBuffer[2] = IOBuffer[2];
        OtherBuffer[3] = IOBuffer[3];
        offset = esize = 4;
        do
        {   if (IOBuffer[offset] == 0xEF)
            {   if (IOBuffer[offset + 1] == 0)
                {   OtherBuffer[esize] = 0xEF;
                    esize++;
                } else
                {   esize += IOBuffer[offset + 1] + 1;
                }
                offset += 2;
            } else
            {   OtherBuffer[esize] = IOBuffer[offset];
                esize++;
                offset++;
        }   }
        while ((int) offset < gamesize);

        // now copy back into normal buffer
        for (offset = 0; (int) offset < esize; offset++)
        {   IOBuffer[offset] = OtherBuffer[offset];
        }
        free(OtherBuffer);

#ifdef WRITEDECRYPTED
        // write decrypted file
        strcpy(tempstring, pathname);
        strcat(tempstring, ".decrypted");
        if ((FileHandle = (BPTR) Open(tempstring, MODE_NEWFILE)))
        {   DISCARD Write(FileHandle, IOBuffer, (LONG) esize);
            DISCARD Close(FileHandle);
            // FileHandle = ZERO;
        }
#endif

        offset = 2;
        serialize1(&dungeonnow);

        offset = 0x93;
        for (x = 0; x < mapwidth[GAME_HACK]; x++)
        {   for (y = 0; y < mapheight[GAME_HACK]; y++)
            {   serialize1to1((UBYTE*) &rogue_map[y][x]);
                offset++;
        }   }

        // sniff for class
        offset = esize - 12;
        ok = FALSE;
        do
        {   offset--;
            for (i = 0; i < 13; i++)
            {   if (!strncmp((char*) &IOBuffer[offset], HackClassOptions[i], strlen(HackClassOptions[i])))
                {   ok = TRUE;
                    break;
        }   }   }
        while (!ok && offset >= 1);
        if (!ok)
        {   rq("Save file is corrupt!"); // better if we didn't quit completely
        }

        offset -= 1556;
        serialize4(     &moves );
        serialize1(     &xpos  );
        serialize1(     &ypos  );

        offset +=  382;

        offset +=   13;
        serialize2ulong(&curstr);

        offset +=    7;
        serialize2ulong(&curhp );

        offset +=    2;
        serialize2ulong(&maxhp );

        offset +=  118;
        serialize2ulong(&gp    );

        if (!(OtherBuffer = malloc(esize * 2)))
        {   rq("Out of memory!");
        }
        OtherBuffer[0] = IOBuffer[0];
        OtherBuffer[1] = IOBuffer[1];
        OtherBuffer[2] = IOBuffer[2];
        OtherBuffer[3] = IOBuffer[3];
        j = 4;
        for (i = 4; i < esize; i++)
        {   if (IOBuffer[i] == 0xEF)
            {   OtherBuffer[j    ] = 0xEF;
                OtherBuffer[j + 1] = 0;
                j += 2;
            } elif (IOBuffer[i] == 0)
            {   if (IOBuffer[i + 1] != 0)
                {   OtherBuffer[j    ] = IOBuffer[i];
                    j++;
                } else
                {   k = 0;
                    do
                    {   k++;
                    } while (i + k < esize && k < 256 && IOBuffer[i + k] == 0);
                    OtherBuffer[j    ] = 0xEF;
                    OtherBuffer[j + 1] = k - 1;
                    i += k - 1;
                    j += 2;
            }   }
            else
            {   OtherBuffer[j] = IOBuffer[i];
                j++;
        }   }
        for (offset = 0; (int) offset < j; offset++)
        {   IOBuffer[offset] = OtherBuffer[offset];
        }
        free(OtherBuffer);
        gamesize = j; // important!

        leftx = topy = 0;
    acase GAME_MORIA:
        /* assert
        (   IOBuffer[0] == 5 // major version
         && IOBuffer[1] == 5 // minor version
         && IOBuffer[2] == 0 // patch level
        ); */
    
        // decrypt
        xor_byte = IOBuffer[3];
        offset = 4;
        do
        {   rc = IOBuffer[offset] ^ xor_byte;
            xor_byte = IOBuffer[offset];
            IOBuffer[offset++] = rc;
        } while ((int) offset < gamesize);

#ifdef WRITEDECRYPTED
        strcpy(tempstring, pathname);
        strcat(tempstring, ".decrypted");
        if ((FileHandle = (BPTR) Open(tempstring, MODE_NEWFILE)))
        {   DISCARD Write(FileHandle, IOBuffer, (LONG) gamesize);
            DISCARD Close(FileHandle);
            // FileHandle = ZERO;
        }
#endif

        // sniff for the start of level data
        offset = 4;
        while (IOBuffer[offset] != 0xFF || IOBuffer[offset + 1] != 0xFF)
        {   offset++;
        } 
        offset += 2; // skip sentinel
        offset += 4; // skip flags variable

        serstring(yourname);
        offset += strlen(yourname) + 1;

        sex = (sex == MALE) ? 1 : 0;
        serialize1(&sex);
        sex = sex ? MALE : FEMALE;

        offset += 4;
        serialize4i(&gp);

        offset += 10;
        serialize2ilong(&age);

        offset += 6;
        serialize2ilong(&dungeonreached);

        offset += 10;
        serialize2ilong(&maxhp);

        offset += 32;
        serialize2ilong(&curhp);

        offset += 2;
        for (i = 0; i < 4; i++)
        {   serstring(history[i]);
            offset += strlen(history[i]) + 1;
        }

        serialize1(&maxstr);
        serialize1(&maxiq );
        serialize1(&maxwis);
        serialize1(&maxdex);
        serialize1(&maxcon);
        serialize1(&maxcha);

        if (serializemode == SERIALIZE_WRITE)
        {   // These copies of the stats needs to be updated, otherwise
            // the player's stats are reset the next time they level up.

            serialize1(&curstr);
            serialize1(&curiq );
            serialize1(&curwis);
            serialize1(&curdex);
            serialize1(&curcon);
            serialize1(&curcha);

            serialize2ilong(&curstr);
            serialize2ilong(&curiq );
            serialize2ilong(&curwis);
            serialize2ilong(&curdex);
            serialize2ilong(&curcon);
            serialize2ilong(&curcha);
        } else
        {   offset += 18;
        }

        serialize1(&curstr);
        serialize1(&curiq );
        serialize1(&curwis);
        serialize1(&curdex);
        serialize1(&curcon);
        serialize1(&curcha);

        offset +=  4; // wr_long(f_ptr->status);
        offset +=  2; // wr_short((int16u)f_ptr->rest);
        offset +=  2; // wr_short((int16u)f_ptr->blind);
        offset +=  2; // wr_short((int16u)f_ptr->paralysis);
        offset +=  2; // wr_short((int16u)f_ptr->confused);

        serialize2ilong(&food);
        serialize2ilong(&digested);

        offset +=  2; // wr_short((int16u)f_ptr->protection);
        offset +=  2; // wr_short((int16u)f_ptr->speed);
        offset +=  2; // wr_short((int16u)f_ptr->fast);
        offset +=  2; // wr_short((int16u)f_ptr->slow);
        offset +=  2; // wr_short((int16u)f_ptr->afraid);
        offset +=  2; // wr_short((int16u)f_ptr->poisoned);
        offset +=  2; // wr_short((int16u)f_ptr->image);
        offset +=  2; // wr_short((int16u)f_ptr->protevil);
        offset +=  2; // wr_short((int16u)f_ptr->invuln);
        offset +=  2; // wr_short((int16u)f_ptr->hero);
        offset +=  2; // wr_short((int16u)f_ptr->shero);
        offset +=  2; // wr_short((int16u)f_ptr->blessed);
        offset +=  2; // wr_short((int16u)f_ptr->resist_heat);
        offset +=  2; // wr_short((int16u)f_ptr->resist_cold);
        offset +=  2; // wr_short((int16u)f_ptr->detect_inv);
        offset +=  2; // wr_short((int16u)f_ptr->word_recall);

        serialize2ilong(&ability[8]); // wr_short((int16u)f_ptr->see_infra);

        offset +=  2; // wr_short((int16u)f_ptr->tim_infra);
        offset +=  1; // wr_byte(f_ptr->see_inv);
        offset +=  1; // wr_byte(f_ptr->teleport);
        offset +=  1; // wr_byte(f_ptr->free_act);
        offset +=  1; // wr_byte(f_ptr->slow_digest);
        offset +=  1; // wr_byte(f_ptr->aggravate);
        offset +=  1; // wr_byte(f_ptr->fire_resist);
        offset +=  1; // wr_byte(f_ptr->cold_resist);
        offset +=  1; // wr_byte(f_ptr->acid_resist);
        offset +=  1; // wr_byte(f_ptr->regenerate);
        offset +=  1; // wr_byte(f_ptr->lght_resist);
        offset +=  1; // wr_byte(f_ptr->ffall);
        offset +=  1; // wr_byte(f_ptr->sustain_str); // sustain_foo are flags
        offset +=  1; // wr_byte(f_ptr->sustain_int);
        offset +=  1; // wr_byte(f_ptr->sustain_wis);
        offset +=  1; // wr_byte(f_ptr->sustain_con);
        offset +=  1; // wr_byte(f_ptr->sustain_dex);
        offset +=  1; // wr_byte(f_ptr->sustain_chr);
        offset +=  1; // wr_byte(f_ptr->confuse_monster);
        offset +=  1; // wr_byte(f_ptr->new_spells);
        offset +=  2; // wr_short((int16u)missile_ctr);

        serialize4i(&moves);

        items = IOBuffer[offset] + (256 * IOBuffer[offset + 1]);
        offset += 2;
        for (i = 0; i < items; i++)
        {   offset += 3;
            strcpy(tempstring, (char*) &IOBuffer[offset]);
            offset += strlen(tempstring) + 1;
            offset += 28;
        }

        for (i = 22; i < 34; i++)
        {   offset += 3;
            strcpy(tempstring, (char*) &IOBuffer[offset]);
            offset += strlen(tempstring) + 1;
            offset += 28;
        }        

        offset +=   2; // wr_short((int16u)inven_weight);       
        offset +=   2; // wr_short((int16u)equip_ctr);        
        offset +=   4; // wr_long(spell_learned);        
        offset +=   4; // wr_long(spell_worked);        
        offset +=   4; // wr_long(spell_forgotten);
        offset +=  32; // wr_bytes(spell_order, 32);
        offset += 448; // wr_bytes(object_ident, OBJECT_IDENT_SIZE);
        offset +=   4; // wr_long(randes_seed);
        offset +=   4; // wr_long(town_seed);
        offset +=   2; // wr_short((int16u)last_msg);
        for (i = 0; i < 22; i++)
        {   strcpy(tempstring, (char*) &IOBuffer[offset]);
            offset += strlen(tempstring) + 1;
        }

        offset +=   2; // wr_short((int16u)panic_save);
        offset +=   2; // wr_short((int16u)total_winner);
        offset +=   2; // wr_short((int16u)noscore);
        offset +=  80; // wr_shorts(player_hp, MAX_PLAYER_LEVEL);

        for (i = 0; i < 6; i++)
        {   offset += 4; // wr_long((int32u)st_ptr->store_open);
            offset += 2; // wr_short((int16u)st_ptr->insult_cur);
            offset += 1; // wr_byte(st_ptr->owner);
            items = IOBuffer[offset++];
            offset += 2; // wr_short(st_ptr->good_buy);
            offset += 2; // wr_short(st_ptr->bad_buy);
            for (j = 0; j < items; j++)
            {   offset += 4; // wr_long((int32u)st_ptr->store_inven[j].scost);
                offset += 3;
                strcpy(tempstring, (char*) &IOBuffer[offset]);
                offset += strlen(tempstring) + 1;
                offset += 28;
        }   }

        offset +=   4; // wr_long(l);

        strcpy(tempstring, (char*) &IOBuffer[offset]);
        offset += strlen(tempstring) + 1;

        offset +=   4; // wr_long(l);
        offset +=   4; // wr_long((int32u) birth_date);

        serialize2ilong(&dungeonnow);
        serialize2ilong(&ypos);
        serialize2ilong(&xpos);
        if (serializemode == SERIALIZE_READ)
        {   if (dungeonnow >= 1)
            {   if (xpos > 40)
                {   if (xpos < 198 - 40)
                    {   leftx = xpos - 40;
                    } else
                    {   leftx = 198 - 80;
                }   }
                else
                {   leftx = 0;
                }
                if (ypos > 14)
                {   if (ypos < 66 - 14)
                    {   topy  = ypos - 14;
                    } else
                    {   topy  = 66 - 28;
                }   }
                else
                {   topy  = 0;
            }   }
            else
            {   leftx = topy = 0;
        }   }

        offset +=   2; // wr_short((int16u)mon_tot_mult);
        offset +=   2; // wr_short((int16u)cur_height);
        offset +=   2; // wr_short((int16u)cur_width);
        offset +=   2; // wr_short((int16u)max_panel_rows);
        offset +=   2; // wr_short((int16u)max_panel_cols);

        while (IOBuffer[offset] != 0xFF)
        {   offset += 3;
        }
        offset++;

        while (IOBuffer[offset] != 0xFF)
        {   offset += 3;
        }
        offset++;

        x = y = 0;
        do
        {   rc = IOBuffer[offset++];
            for (i = 0; i < rc; i++) // OK even if rc is 0
            {   rogue_map[y][x] = IOBuffer[offset];
                x++;
                if (x == mapwidth[GAME_MORIA])
                {   x = 0;
                    y++;
                    if (y >= mapheight[GAME_MORIA])
                    {   break;
            }   }   }
            offset += 2;
        } while (y < mapheight[GAME_MORIA]);

        // reencrypt
        xor_byte = IOBuffer[3];
        offset = 4;
        do
        {   xor_byte ^= IOBuffer[offset];
            IOBuffer[offset++] = xor_byte;
        } while ((int) offset < gamesize);
    acase GAME_ROGUE:
        offset =  0x73;
        serstring(yourname);         // $73..$8A
        offset =  0x8B;
        serstring(fruitname);        // $8B..$A2
        offset = 0x6E5;
        serialize1(&dungeonreached); // $6E5
        offset = 0x6EB;
        serialize1(&dungeonnow);     // $6EB
        offset = 0x6EC;
        serialize2ulong(&gp);        // $6EC..$6ED
        offset = 0x6FC;
        serialize4(&moves);          // $6FC..$6FF
    
        offset = 0xCC3;
        // there might be more or less than 45, hard to tell since most
        // of them are normally zeroes.
        for (i = 0; i < 45; i++)
        {   length = IOBuffer[offset++];
            offset += length + 1;
        }
    
        offset += 189;
        serialize2ulong(&xpos);
        serialize2ulong(&ypos);
        offset += 10;
        serialize2ulong(&curstr);
        offset += 8;
        serialize2ulong(&curhp);
        offset += 4;
        serialize2ulong(&maxhp);
    
        // we don't support map editing, so no need to rewrite map data
        if (serializemode == SERIALIZE_WRITE)
        {   return;
        }
    
        offset = 0x1000;
    
        // sniff for the start of level data
        do
        {   if (IOBuffer[offset] == NUL)
            {   ok = TRUE;
                for (y = 1; y < mapheight[GAME_ROGUE]; y++)
                {   if
                    (   IOBuffer[offset + y] != ' ' // probably only spaces are possible
                     && IOBuffer[offset + y] != '<'
                     && IOBuffer[offset + y] != '|'
                     && IOBuffer[offset + y] != OPENCURLY
                     && IOBuffer[offset + y] != '#'
                    )
                    {   ok = FALSE;
                        break; // for speed
            }   }   }
            else
            {   ok = FALSE;
            }
            if (!ok)
            {   offset++;
        }   }
        while (!ok);

        for (x = 0; x < mapwidth[GAME_ROGUE]; x++)
        {   for (y = 0; y < mapheight[GAME_ROGUE]; y++)
            {   rogue_map[y][x] = IOBuffer[offset++];
        }   }
    
     /* for (y = 0; y < mapheight[GAME_ROGUE]; y++)
        {   for (x = 0; x < mapwidth[GAME_ROGUE]; x++)
            {   printf("%c", rogue_map[y][x] ? rogue_map[y][x] : ' ');
            }
            printf("\n");
        } */

        firstplace =
        leftx      =
        topy       = 0;
    acase GAME_LARN:
        dungeonreached = ((gamesize - 787) / 9112) - 1;
        offset = 14 + ((dungeonreached + 1) * 9112); // 9112 is 67 * 17 * 8
        serialize4(&curstr    ); // $23A6..$23A9
        serialize4(&curiq     ); // $23AA..$23AD
        serialize4(&curwis    ); // $23AE..$23B1
        serialize4(&curdex    ); // $23B2..$23B5
        serialize4(&curcon    ); // $23B6..$23B9
        serialize4(&curcha    ); // $23BA..$23BD
        serialize4(&maxhp     ); // $23BE..$23C1
        serialize4(&curhp     ); // $23C2..$23C5
        serialize4(&gp        ); // $23C6..$23C9
        serialize4(&experience); // $23CA..$23CD
        serialize4(&level     ); // $23CE..$23D1
        offset += 16;            // $23D2..$23E1
        serialize4(&maxsp     ); // $23E2..$23E5
        serialize4(&cursp     ); // $23E6..$23E9
        offset += 329;           // $23EA..$2532
        serialize4(&moves     ); // $2533..$2536
        offset += 3;             // $2537..$2539

        found = 0;
        for (i = 0; i < 14; i++)
        {   if (IOBuffer[i])
            {   found++;
                if (found == (int) dungeonnow + 1)
                {   dungeonnow = i;
                    break;
        }   }   }
        serialize1(&dungeonnow); // $253A
        found = 0;
        for (i = 0; i < (int) dungeonnow; i++)
        {   if (IOBuffer[i])
            {   found++;
        }   }
        dungeonnow = found;
        serialize1(&xpos      ); // $253B
        serialize1(&ypos      ); // $253C
}   }

MODULE void clearvars(void)
{   int i;

    for (i = 0; i < 9; i++)
    {   ability[i]  = 0;
    }

    yourname[0]     =
    fruitname[0]    =
    history[0][0]   =
    history[1][0]   =
    history[2][0]   =
    history[3][0]   = EOS;
    maxstr = curstr =
    maxiq  = curiq  =
    maxwis = curwis =
    maxdex = curdex =
    maxcon = curcon =
    maxcha = curcha =
    maxhp  = curhp  =
    maxsp  = cursp  =
    age             =
    food            =
    digested        =
    gp              =
    moves           =
    experience      = 0;
    sex             = MALE;
    dungeonnow      =
    dungeonreached  = 1;
}

EXPORT void rogue_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    if (filetype == FT_HISCORES)
    {   serialize_hiscores();
        switch (game)
        {
        case  GAME_HACK:  gamesave("record"      , "HackLite", saveas, gamesize, FLAG_H, FALSE);
        acase GAME_ROGUE: gamesave("Rogue.score" , "Rogue"   , saveas,      460, FLAG_H, FALSE);
        acase GAME_MORIA: gamesave("scores"      , "Moria"   , saveas, gamesize, FLAG_H, FALSE);
        acase GAME_LARN:  gamesave(".lscore12.0" , "Larn"    , saveas,     1680, FLAG_H, FALSE);
    }   }
    else
    {   // assert(filetype == FT_SAVEGAME);

        serialize_savegame();
        switch (game)
        {
        case  GAME_HACK:  gamesave("#?"          , "HackLite", saveas, gamesize, FLAG_S, FALSE);
        acase GAME_ROGUE: gamesave("#?.save"     , "Rogue"   , saveas,    10000, FLAG_S, FALSE);
        acase GAME_MORIA: gamesave("moria.sav"   , "Moria"   , saveas, gamesize, FLAG_S, FALSE);
        acase GAME_LARN:  gamesave("Larn12.0.sav", "Larn"    , saveas, gamesize, FLAG_S, FALSE);
}   }   }

EXPORT void rogue_close(void) { ; }

EXPORT void rogue_exit(void)
{   ch_clearlist(&SexList);
}

MODULE void maximize_man(void)
{   moves               =       0;

    if (game != GAME_LARN)
    {   dungeonreached  = maxlevel[game];
    }

    switch (game)
    {
    case GAME_ROGUE:
        curstr          =
        maxhp  = curhp  =     900;
        gp              =   30000;
    acase GAME_HACK:
        curstr          =     120;
        maxhp  = curhp  =
        gp              =   60000;
    acase GAME_MORIA:
        maxstr = curstr =
        maxiq  = curiq  =
        maxwis = curwis =
        maxdex = curdex =
        maxcon = curcon =
        maxcha = curcha =     250;
        maxhp  = curhp  =
        food            =   30000;
     // digested        =   30000;
        gp              = 9000000;
    acase GAME_LARN:
        level           = // this can go much higher
        curstr          =
        curiq           =
        curwis          =
        curdex          =
        curcon          =
        curcha          =      90; // game punishes player if any of these are >99
        maxsp  = cursp  =     100; // game punishes player if maxsp >125
        maxhp  = curhp  =     900; // game punishes player if maxhp >999
        gp              =
        experience      = ONE_BILLION;

        larn_reveal();
}   }

MODULE void rogue_ghost(void)
{   int i;

    for (i = 0; i < HISCOREGADS; i++)
    {   ghost_st(GID_ROGUE_ST3  + i, (filetype != FT_HISCORES || numscores <= firstplace + i                                               )); // name
        ghost(   GID_ROGUE_IN9  + i, (filetype != FT_HISCORES || numscores <= firstplace + i                                               )); // points
        ghost(   GID_ROGUE_IN19 + i, (filetype != FT_HISCORES || numscores <= firstplace + i ||  game == GAME_HACK  || (game == GAME_LARN && firstplace + i < 10))); // dungeon level
        ghost(   GID_ROGUE_CH1  + i, (filetype != FT_HISCORES || numscores <= firstplace + i || (game != GAME_ROGUE &&  game != GAME_MORIA))); // rank
        ghost(   GID_ROGUE_CH14 + i, (filetype != FT_HISCORES || numscores <= firstplace + i ||                         game != GAME_MORIA )); // race
        ghost(   GID_ROGUE_CH34 + i, (filetype != FT_HISCORES || numscores <= firstplace + i ||                         game != GAME_MORIA )); // sex
        ghost(   GID_ROGUE_CH24 + i, (filetype != FT_HISCORES || numscores <= firstplace + i || (game != GAME_HACK  &&  game != GAME_MORIA))); // class
    }
    ghost(       GID_ROGUE_BU2     , (filetype != FT_HISCORES                      ));
    ghost(       GID_ROGUE_BU4     , (filetype != FT_HISCORES                      ));

    // Rogue only
    ghost_st(    GID_ROGUE_ST1     , (filetype != FT_SAVEGAME ||  game != GAME_ROGUE)); // character name
    ghost_st(    GID_ROGUE_ST2     , (filetype != FT_SAVEGAME ||  game != GAME_ROGUE)); // fruit name

    // Moria only
    ghost_st(    GID_ROGUE_ST13    , (filetype != FT_SAVEGAME ||  game != GAME_MORIA));
    ghost_st(    GID_ROGUE_ST14    , (filetype != FT_SAVEGAME ||  game != GAME_MORIA));
    ghost_st(    GID_ROGUE_ST15    , (filetype != FT_SAVEGAME ||  game != GAME_MORIA));
    ghost_st(    GID_ROGUE_ST16    , (filetype != FT_SAVEGAME ||  game != GAME_MORIA));
    ghost(       GID_ROGUE_CH13    , (filetype != FT_SAVEGAME ||  game != GAME_MORIA));
    for (i = GID_ROGUE_IN35; i <= GID_ROGUE_IN43; i++)
    {   ghost(   i                 , (filetype != FT_SAVEGAME ||  game != GAME_MORIA));
    }

    // Larn and Moria only
    for (i = GID_ROGUE_IN30; i <= GID_ROGUE_IN34; i++)
    {   ghost(   i                 , (filetype != FT_SAVEGAME || (game != GAME_LARN && game != GAME_MORIA)));
    }

    // Larn only
    ghost(       GID_ROGUE_IN14    , (filetype != FT_SAVEGAME ||  game != GAME_LARN )); // experience
    ghost(       GID_ROGUE_IN15    , (filetype != FT_SAVEGAME ||  game != GAME_LARN )); // cur sp
    ghost(       GID_ROGUE_IN16    , (filetype != FT_SAVEGAME ||  game != GAME_LARN )); // max sp
    ghost(       GID_ROGUE_IN17    , (filetype != FT_SAVEGAME ||  game != GAME_LARN )); // level

    // all
    ghost(       GID_ROGUE_BU1     , (filetype != FT_SAVEGAME                       )); // maximize
    ghost(       GID_ROGUE_BU3     , (filetype != FT_SAVEGAME                       )); // location...
    ghost(       GID_ROGUE_IN1     , (filetype != FT_SAVEGAME                       )); // gold
    ghost(       GID_ROGUE_IN2     , (filetype != FT_SAVEGAME                       )); // cur hp
    ghost(       GID_ROGUE_IN3     , (filetype != FT_SAVEGAME                       )); // max hp
    ghost(       GID_ROGUE_IN4     , (filetype != FT_SAVEGAME                       )); // cur str
    ghost(       GID_ROGUE_IN6     , (filetype != FT_SAVEGAME                       )); // moves
}

MODULE void sortscores(void)
{   int i, j;

    if (game == GAME_LARN)
    {    for (i = 0; i < 10 - 1; i++)
        {   for (j = 0; j < 10 - i - 1; j++)
            {   // winners table
                if
                (   score[j    ].gp
                  < score[j + 1].gp
                )
                {   swapscores(j, j + 1);
                }
                // losers table
                if
                (   score[j + 10].gp
                  < score[j + 11].gp
                )
                {   swapscores(j + 10, j + 11);
    }   }   }   }
    else
    {   for (i = 0; i < 100 - 1; i++)
        {   for (j = 0; j < 100 - i - 1; j++)
            {   if
                (   score[j    ].gp
                  < score[j + 1].gp
                )
                {   swapscores(j, j + 1);
}   }   }   }   }

MODULE void swapscores(int first, int second)
{   ULONG tempnum;
    TEXT  tempstr[31 + 1];

    tempnum                     = score[first ].gp;
    score[first ].gp            = score[second].gp;
    score[second].gp            = tempnum;

    tempnum                     = score[first ].rank;
    score[first ].rank          = score[second].rank;
    score[second].rank          = tempnum;

    tempnum                     = score[first ].cause;
    score[first ].cause         = score[second].cause;
    score[second].cause         = tempnum;

    tempnum                     = score[first ].dungeon_level;
    score[first ].dungeon_level = score[second].dungeon_level;
    score[second].dungeon_level = tempnum;

    tempnum                     = score[first ].race;
    score[first ].race          = score[second].race;
    score[second].race          = tempnum;

    tempnum                     = score[first ].class;
    score[first ].class         = score[second].class;
    score[second].class         = tempnum;

    tempnum                     = score[first ].sex;
    score[first ].sex           = score[second].sex;
    score[second].sex           = tempnum;

    tempnum                     = score[first ].slot;
    score[first ].slot          = score[second].slot;
    score[second].slot          = tempnum;

    strcpy(tempstr,            score[first ].name);
    strcpy(score[first ].name, score[second].name);
    strcpy(score[second].name, tempstr);
}

MODULE void clearscores(void)
{   int i;

    for (i = 0; i < 100; i++)
    {   score[i].name[0]       = EOS;
        score[i].rank          =
        score[i].gp            =
        score[i].cause         =
        score[i].dungeon_level =
        score[i].race          =
        score[i].class         = 0;
        score[i].sex           = MALE;
}   }

EXPORT void rogue_drawmap(void)
{   FLAG  north, south, west, east;
    UBYTE which;
    int   x, y;

    if (filetype == FT_HISCORES)
    {   return;
    }

    switch (game)
    {
    case GAME_ROGUE:
        for (y = 0; y < mapheight[GAME_ROGUE]; y++)
        {   for (x = 0; x < mapwidth[GAME_ROGUE]; x++)
            {   switch (rogue_map[y][x])
                {
                case  '+':                     drawgfx(  x, y,  0);
                acase '-': case OPENCURLY: case CLOSECURLY: drawgfx(  x, y,  1);
                acase '@':                     drawgfx(  x, y,  2);
                acase '.':                     drawgfx(  x, y,  3);
                acase '|': case '<': case '>': drawgfx(  x, y,  4);
                acase '*':                     drawgfx(  x, y,  5);
                acase '%':                     drawgfx(  x, y,  6);
                acase '?':                     drawgfx(  x, y,  7);
                acase '!':                     drawgfx(  x, y,  8);
                acase 'a':
                case  'b':
                case  'c':
                case  'd':
                case  'e':
                case  'f':
                case  'g':
                case  'h':
                    drawgfx(x, y, rogue_map[y][x] - 'a' + 9);
                acase 'm':
                case  'n':
                case  'o':
                case  'p':
                case  'q':
                case  'r':
                case  's':
                case  't':
                case  'u':
                case  'v':
                case  'w':
                case  'x':
                    drawgfx(x, y, rogue_map[y][x] - 'm' + 17);
                acase '^':                     drawgfx(x, y, 28);
                acase '/':                     drawgfx(x, y, 29);
                acase '=':                     drawgfx(x, y, 30);
                acase ':':                     drawgfx(x, y, 31);
                acase ',':                     drawgfx(x, y, 32);
                acase ' ': case NUL:           drawpoint(x, y,  0); // black (nothing)
                acase '#':                     drawpoint(x, y,  1); // dark grey (corridor)
                adefault:                      drawpoint(x, y,  5); // orange (unknown)
        }   }   }

        drawgfx(xpos, ypos, 2); // you
    acase GAME_HACK:
        for (y = 0; y < mapheight[GAME_HACK]; y++)
        {   for (x = 0; x < mapwidth[GAME_HACK]; x++)
            {   if (rogue_map[y][x] < 32)
                {   drawgfx(x, y, 0);
                } elif (rogue_map[y][x] < 0x99)
                {   drawgfx(x, y, rogue_map[y][x] - 32 + 1);
                } else
                {   drawgfx(x, y, 0x99 - 32 + 1);
        }   }   }

        drawgfx(xpos, ypos, '@' - 32 + 1); // you
    acase GAME_MORIA:
        for (y = 0; y < gadheight[GAME_MORIA] / scalex[GAME_MORIA]; y++)
        {   for (x = 0; x < gadwidth[GAME_MORIA] / scaley[GAME_MORIA]; x++)
            {   which = rogue_map[topy + y][leftx + x];
#ifdef VERBOSE
                printf("%c", which);
#endif
                if (which > 0x54) which = 0x54;
                drawgfx(x, y, which);
            }
#ifdef VERBOSE
            printf("\n");
#endif
        }
        drawgfx(xpos - leftx, ypos - topy, 0x54); // you

        DISCARD SetGadgetAttrs
        (   gadgets[GID_ROGUE_SC2], SubWindowPtr, NULL,
            SCROLLER_Top, leftx,
        TAG_END); // this refreshes automatically
        DISCARD SetGadgetAttrs
        (   gadgets[GID_ROGUE_SC3], SubWindowPtr, NULL,
            SCROLLER_Top, topy,
        TAG_END); // this refreshes automatically
    acase GAME_LARN:
        for (y = 0; y < mapheight[GAME_LARN]; y++)
        {   for (x = 0; x < mapwidth[GAME_LARN]; x++)
            {   which = rogue_map[y][x];
                if (which == 0x15)
                {   north = (y >  0   && rogue_map[y - 1][x    ] == 0x15) ? TRUE : FALSE;
                    south = (y < 17-1 && rogue_map[y + 1][x    ] == 0x15) ? TRUE : FALSE;
                    west  = (x >  0   && rogue_map[y    ][x - 1] == 0x15) ? TRUE : FALSE;
                    east  = (x < 67-1 && rogue_map[y    ][x + 1] == 0x15) ? TRUE : FALSE;
                    if (north || south || west || east)
                    {   which = 0x54 - 1;
                        if (north) which++;
                        if (south) which += 2;
                        if (west ) which += 4;
                        if (east ) which += 8;
                }   }
                elif (which > 0x64)
                {   which = 0x64;
                }
                drawgfx(x, y, which);
        }   }
        drawgfx(xpos, ypos, 0x63);
    }

    DISCARD WritePixelArray8
    (   SubWindowPtr->RPort,
        gadgets[GID_ROGUE_SP1]->LeftEdge,
        gadgets[GID_ROGUE_SP1]->TopEdge,
        gadgets[GID_ROGUE_SP1]->LeftEdge + gadwidth[ game] - 1,
        gadgets[GID_ROGUE_SP1]->TopEdge  + gadheight[game] - 1,
        display1,
        &wpa8rastport[0]
    );
}

MODULE void drawpoint(int x, int y, int colour)
{   int xx, yy;

    // assert(game == GAME_ROGUE);

    for (yy = 0; yy < 9; yy++)
    {   for (xx = 0; xx < 10; xx++)
        {   *(byteptr1[(y * 9) + yy] + (x * 10) + xx) = pens[colour];
}   }   }

MODULE void drawgfx(int x, int y, int which)
{   int xx, yy;

    x *= scalex[game];
    y *= scaley[game];
    if (x < 0 || y < 0 || x >= gadwidth[game] || y >= gadheight[game])
    {   return; // important
    }

    switch (game)
    {
    case GAME_ROGUE:
        for (yy = 0; yy < scaley[game]; yy++)
        {   for (xx = 0; xx < scalex[game]; xx++)
            {   if (gfx_rogue[which][yy][xx] >= 'A' && gfx_rogue[which][yy][xx] <= 'F')
                {   *(byteptr1[y + yy] + x + xx) = pens[gfx_rogue[which][yy][xx] - 'A' + 10];
                } else
                {   *(byteptr1[y + yy] + x + xx) = pens[gfx_rogue[which][yy][xx] - '0'     ];
        }   }   }
    acase GAME_HACK:
        for (yy = 0; yy < scaley[game]; yy++)
        {   for (xx = 0; xx < scalex[game]; xx++)
            {   if (    gfx_hack[which][yy][xx] >= 'A' && gfx_hack[which][yy][xx] <= 'Z')
                {   *(byteptr1[y + yy] + x + xx) = pens[gfx_hack[which][yy][xx] - 'A' + 10];
                } elif (gfx_hack[which][yy][xx] >= 'a' && gfx_hack[which][yy][xx] <= 'z')
                {   *(byteptr1[y + yy] + x + xx) = pens[gfx_hack[which][yy][xx] - 'a' + 36];
                } else
                {   *(byteptr1[y + yy] + x + xx) = pens[gfx_hack[which][yy][xx] - '0'     ];
        }   }   }
    acase GAME_MORIA:
        for (yy = 0; yy < scaley[game]; yy++)
        {   for (xx = 0; xx < scalex[game]; xx++)
            {   if (    gfx_moria[which][yy][xx] >= 'A' && gfx_moria[which][yy][xx] <= 'Z')
                {   *(byteptr1[y + yy] + x + xx) = pens[gfx_moria[which][yy][xx] - 'A' + 10];
                } elif (gfx_moria[which][yy][xx] >= 'a' && gfx_moria[which][yy][xx] <= 'z')
                {   *(byteptr1[y + yy] + x + xx) = pens[gfx_moria[which][yy][xx] - 'a' + 36];
                } else
                {   *(byteptr1[y + yy] + x + xx) = pens[gfx_moria[which][yy][xx] - '0'     ];
        }   }   }
    acase GAME_LARN:
        for (yy = 0; yy < scaley[game]; yy++)
        {   for (xx = 0; xx < scalex[game]; xx++)
            {   *(byteptr1[y + yy] + x + xx) = pens[gfx_larn[which][yy][xx] - '0' + 38];
}   }   }   }

EXPORT void rogue_getpens(void)
{   lockscreen();

    pens[ 0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1); // 0 black
    pens[ 1] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x44444444, 0x44444444, 0x44444444, -1); // 1 dark grey
    pens[ 2] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xEEEEEEEE, 0x00000000, -1); // 2 yellow
    pens[ 3] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xCCCCCCCC, 0x00000000, 0x00000000, -1); // 3 red
    pens[ 4] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0x88888888, -1); // 4 medium grey
    pens[ 5] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x66666666, 0x00000000, -1); // 5 orange
    pens[ 6] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1); // 6 white
    pens[ 7] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xAAAAAAAA, 0x33333333, 0x00000000, -1); // 7 light brown
    pens[ 8] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x77777777, 0x22222222, 0x00000000, -1); // 8 dark brown
    pens[ 9] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xCCCCCCCC, 0xAAAAAAAA, -1); // 9 skin
    pens[10] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0xCCCCCCCC, -1); // A pink
    pens[11] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x99999999, 0x00000000, -1); // B green
    pens[12] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x33333333, 0xFFFFFFFF, 0xBBBBBBBB, -1); // C cyan
    pens[13] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x66666666, 0x99999999, 0xFFFFFFFF, -1); // D light blue
    pens[14] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xAAAAAAAA, 0x00000000, 0xFFFFFFFF, -1); // E purple
    pens[15] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xFFFFFFFF, -1); // F dark blue
    pens[16] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xDDDDDDDD, 0xDDDDDDDD, 0x00000000, -1); // G yellow
    pens[17] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xEEEEEEEE, 0xAAAAAAAA, 0x00000000, -1); // H orange
    pens[18] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xAAAAAAAA, 0x00000000, 0x00000000, -1); // I dark red
    pens[19] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1); // J bright red
    pens[20] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xDDDDDDDD, 0x00000000, -1); // K bright green
    pens[21] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xDDDDDDDD, -1); // L blue
    pens[22] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xAAAAAAAA, 0x44444444, 0x99999999, -1); // M purple
    pens[23] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x22222222, 0x88888888, 0x00000000, -1); // N dark green
    pens[24] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xBBBBBBBB, 0xFFFFFFFF, 0x66666666, -1); // O light green
    pens[25] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x55555555, 0x00000000, -1); // P brown
    pens[26] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x33333333, 0xBBBBBBBB, 0xEEEEEEEE, -1); // Q light blue
    pens[27] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xCCCCCCCC, -1); // R skin
    pens[28] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x33333333, 0x33333333, 0x22222222, -1); // S greyish
    pens[29] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x55555555, 0x55555555, 0x55555555, -1); // T grey
    pens[30] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xCCCCCCCC, 0x88888888, 0x66666666, -1); // U bone
    pens[31] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x44444444, 0x33333333, -1); // V brown
    pens[32] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xEEEEEEEE, 0xBBBBBBBB, 0x00000000, -1); // W yellow
    pens[33] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x00000000, 0x00000000, -1); // X dark red
    pens[34] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x88888888, 0x00000000, -1); // Y dark green
    pens[35] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x22222222, 0x22222222, -1); // Z bright red
    pens[36] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xAAAAAAAA, 0xAAAAAAAA, 0x88888888, -1); // a greyish
    pens[37] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xDDDDDDDD, 0xCCCCCCCC, 0xAAAAAAAA, -1); // b bone

    // Larn
    pens[38] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1); // 0 black
    pens[39] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xEEEEEEEE, 0xFFFFFFFF, -1); // 1 whitish
    pens[40] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x66666666, 0x55555555, 0x66666666, -1); // 2 greyish
    pens[41] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x99999999, 0x00000000, 0x00000000, -1); // 3 dark red
    pens[42] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1); // 4 bright red
    pens[43] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xDDDDDDDD, 0x00000000, -1); // 5 yellow
    pens[44] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xFFFFFFFF, -1); // 6 blue
    pens[45] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x99999999, 0x00000000, -1); // 7 green

    unlockscreen();
}

EXPORT void rogue_uniconify(void)
{   rogue_getpens();
}

EXPORT void rogue_sublmb(SWORD mousex, SWORD mousey)
{   ULONG oldxpos, oldypos;

    if
    (   filetype != FT_SAVEGAME
     || !mouseisover(GID_ROGUE_SP1, mousex, mousey)
    )
    {   return;
    }

    oldxpos = xpos;
    oldypos = ypos;
    xpos = ((mousex - gadgets[GID_ROGUE_SP1]->LeftEdge) / scalex[game]);
    ypos = ((mousey - gadgets[GID_ROGUE_SP1]->TopEdge ) / scaley[game]);
    if (game == GAME_MORIA)
    {   xpos += leftx;
        ypos += topy;
     // printf("That's $%X!\n", rogue_map[ypos][xpos]);
    }

    if (xpos < 1)
    {   xpos = 1;
    } elif ((int) xpos > mapwidth[game] - 2)
    {   xpos = mapwidth[game] - 2;
    }
    if (ypos < 1)
    {   ypos = 1;
    } elif ((int) ypos > mapheight[game] - 2)
    {   ypos = mapheight[game] - 2;
    }
    if (xpos != oldxpos || ypos != oldypos)
    {   DISCARD SetGadgetAttrs(gadgets[GID_ROGUE_IN7], SubWindowPtr, NULL, INTEGER_Number, xpos, TAG_DONE); // autorefreshes
        DISCARD SetGadgetAttrs(gadgets[GID_ROGUE_IN8], SubWindowPtr, NULL, INTEGER_Number, ypos, TAG_DONE); // autorefreshes
        rogue_drawmap();
}   }

EXPORT FLAG rogue_subkey(UBYTE scancode, UWORD qual)
{   int oldx, oldy;

    if (scancode == SCAN_ENTER || scancode == SCAN_RETURN)
    {   return TRUE;
    }

    if (game == GAME_MORIA)
    {   oldx = leftx;
        oldy = topy;

        if
        (   scancode == SCAN_LEFT
         || scancode == SCAN_N7
         || scancode == SCAN_N4
         || scancode == SCAN_N1
        )
        {   MOVE_LEFT( qual, &leftx, 1, 5           );
        } elif
        (   scancode == SCAN_RIGHT
         || scancode == SCAN_N9
         || scancode == SCAN_N6
         || scancode == SCAN_N3
        )
        {   MOVE_RIGHT(qual, &leftx, 1, 5, LEFTX_MAX);
        }

        if
        (   scancode == SCAN_UP
         || scancode == SCAN_N7
         || scancode == SCAN_N8
         || scancode == SCAN_N9
         || scancode == NM_WHEEL_UP
        )
        {   MOVE_UP(   qual, &topy , 1, 5           );
        } elif
        (   scancode == SCAN_DOWN
         || scancode == SCAN_N5
         || scancode == SCAN_N1
         || scancode == SCAN_N2
         || scancode == SCAN_N3
         || scancode == NM_WHEEL_DOWN
        )
        {   MOVE_DOWN( qual, &topy , 1, 5, TOPY_MAX );
        }

        if (leftx != oldx || topy != oldy)
        {   rogue_drawmap();
    }   }
    else
    {   // assert(game == GAME_ROGUE || game == GAME_HACK || game == GAME_LARN);

        /* This conflicts with our shortcut for "Help|Manual..."
        if (game == GAME_LARN)
        {   if (scancode == SCAN_DEL)
            {   if (dungeonnow > 0)
                {   dungeonnow--;
                    larn_changemap();
                    rogue_drawmap();
                    return FALSE; // for speed
            }   }
            elif (scancode == SCAN_HELP)
            {   if (dungeonnow < dungeonreached)
                {   dungeonnow++;
                    larn_changemap();
                    rogue_drawmap();
                    return FALSE; // for speed
        }   }   } */

        oldx = xpos;
        oldy = ypos;

        if
        (   scancode == SCAN_LEFT
         || scancode == SCAN_N7
         || scancode == SCAN_N4
         || scancode == SCAN_N1
        )
        {   map_leftorup(   qual, mapwidth[game] , (int*) &xpos, 0, NULL);
        } elif
        (   scancode == SCAN_RIGHT
         || scancode == SCAN_N9
         || scancode == SCAN_N6
         || scancode == SCAN_N3
        )
        {   map_rightordown(qual, mapwidth[game] , (int*) &xpos, 0, NULL);
        }

        if
        (   scancode == SCAN_UP
         || scancode == SCAN_N7
         || scancode == SCAN_N8
         || scancode == SCAN_N9
         || scancode == NM_WHEEL_UP
        )
        {   map_leftorup(   qual, mapheight[game], (int*) &ypos, 0, NULL);
        } elif
        (   scancode == SCAN_DOWN
         || scancode == SCAN_N5
         || scancode == SCAN_N1
         || scancode == SCAN_N2
         || scancode == SCAN_N3
         || scancode == NM_WHEEL_DOWN
        )
        {   map_rightordown(qual, mapheight[game], (int*) &ypos, 0, NULL);
        }

        if (xpos < 1)
        {   xpos = 1;
        } elif ((int) xpos > mapwidth[game] - 2)
        {   xpos = mapwidth[game] - 2;
        }
        if (ypos < 1)
        {   ypos = 1;
        } elif ((int) ypos > mapheight[game] - 2)
        {   ypos = mapheight[game] - 2;
        }
        if (oldx != (int) xpos || oldy != (int) ypos)
        {   DISCARD SetGadgetAttrs(gadgets[GID_ROGUE_IN7], SubWindowPtr, NULL, INTEGER_Number, xpos, TAG_DONE); // autorefreshes
            DISCARD SetGadgetAttrs(gadgets[GID_ROGUE_IN8], SubWindowPtr, NULL, INTEGER_Number, ypos, TAG_DONE); // autorefreshes
            rogue_drawmap();
    }   }

    return FALSE;
}

MODULE void larn_changemap(void)
{   int x, y;

    // assert(game == GAME_LARN);

    offset = 17 + (dungeonnow * 67 * 17 * 8);
    for (x = 0; x < 67; x++)
    {   for (y = 0; y < 17; y++)
        {   rogue_map[y][x] = IOBuffer[offset];
            offset += 8;
}   }   }

MODULE void mapwindow(void)
{   // assert(filetype == FT_SAVEGAME);

    if (game == GAME_LARN)
    {   larn_changemap();

        load_aiss_images(55, 55);
        
        gadgets[GID_ROGUE_BU5] = (struct Gadget*)
        ZButtonObject,
            GA_ID,                                 GID_ROGUE_BU5,
            GA_RelVerify,                          TRUE,
            GA_Image,
            LabelObject,
                LABEL_Image,                       aissimage[55],
                CHILD_NoDispose,                   TRUE,
                LABEL_DrawInfo,                    DrawInfoPtr,
                LABEL_VerticalAlignment,           LVALIGN_BASELINE,
                LABEL_Text,                        " Reveal All ",
            LabelEnd,
        ButtonEnd;
    } elif (game == GAME_MORIA)
    {   gadgets[GID_ROGUE_SC2] = (struct Gadget*)
        ScrollerObject,
            GA_ID,                                 GID_ROGUE_SC2,
            GA_RelVerify,                          TRUE,
            SCROLLER_Total,                        198,
            SCROLLER_Visible,                      80,
            SCROLLER_Orientation,                  SORIENT_HORIZ,
            SCROLLER_Arrows,                       TRUE,
        ScrollerEnd;
        gadgets[GID_ROGUE_SC3] = (struct Gadget*)
        ScrollerObject,
            GA_ID,                                 GID_ROGUE_SC3,
            GA_RelVerify,                          TRUE,
            SCROLLER_Total,                        66,
            SCROLLER_Visible,                      28,
            SCROLLER_Orientation,                  SORIENT_VERT,
            SCROLLER_Arrows,                       TRUE,
        ScrollerEnd;
    }

    if (game != GAME_HACK)
    {   gadgets[GID_ROGUE_LY3] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_VertAlignment,                  LALIGN_CENTER,
            AddLabel("Dgn level reached:"),
            LAYOUT_AddChild,                       gadgets[GID_ROGUE_IN29] = (struct Gadget*)
            IntegerObject,
                GA_ID,                             GID_ROGUE_IN29,
                GA_TabCycle,                       TRUE,
                GA_Disabled,                       (game == GAME_LARN) ? TRUE : FALSE,
                INTEGER_Minimum,                   (game == GAME_LARN) ?    0 :     1,
                INTEGER_Maximum,                   maxlevel[game],
                INTEGER_Number,                    dungeonreached,
                INTEGER_MinVisible,                2 + 1,
            IntegerEnd,
        LayoutEnd;
    }

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                                  "Location",
        WINDOW_Position,                           WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                           "rogue-1",
        WINDOW_ParentGroup,                        gadgets[GID_ROGUE_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                     TRUE,
            AddHLayout,
                AddSpace,
                LAYOUT_AddChild,                   gadgets[GID_ROGUE_SP1] = (struct Gadget*)
                SpaceObject,
                    GA_ID,                         GID_ROGUE_SP1,
                    SPACE_MinWidth,                gadwidth[game],
                    SPACE_MinHeight,               gadheight[game],
                    SPACE_BevelStyle,              BVS_FIELD,
                    SPACE_Transparent,             TRUE,
                SpaceEnd,
                CHILD_WeightedWidth,               0,
                CHILD_WeightedHeight,              0,
                (game == GAME_MORIA) ? LAYOUT_AddChild     : TAG_IGNORE, gadgets[GID_ROGUE_SC3],
                (game == GAME_MORIA) ? CHILD_WeightedWidth : TAG_IGNORE, 0,
                AddSpace,
            LayoutEnd,
            (game == GAME_MORIA) ? LAYOUT_AddChild : TAG_IGNORE, gadgets[GID_ROGUE_SC2],
            AddHLayout,
                LAYOUT_VertAlignment,              LALIGN_CENTER,
                LAYOUT_SpaceOuter,                 TRUE,
                AddLabel("X:"),
                LAYOUT_AddChild,                   gadgets[GID_ROGUE_IN7] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                         GID_ROGUE_IN7,
                    GA_TabCycle,                   TRUE,
                    GA_RelVerify,                  TRUE,
                    INTEGER_Minimum,               1,
                    INTEGER_Maximum,               mapwidth[game] - 2,
                    INTEGER_Number,                xpos,
                    INTEGER_MinVisible,            3 + 1,
                LayoutEnd,
                AddLabel("Y:"),
                LAYOUT_AddChild,                   gadgets[GID_ROGUE_IN8] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                         GID_ROGUE_IN8,
                    GA_TabCycle,                   TRUE,
                    GA_RelVerify,                  TRUE,
                    INTEGER_Minimum,               1,
                    INTEGER_Maximum,               mapheight[game] - 2,
                    INTEGER_Number,                ypos,
                    INTEGER_MinVisible,            3 + 1,
                LayoutEnd,
                AddLabel("Current dgn level:"),
                LAYOUT_AddChild,                   gadgets[GID_ROGUE_IN5] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                         GID_ROGUE_IN5,
                    GA_TabCycle,                   TRUE,
                    GA_RelVerify,                  TRUE,
                    INTEGER_Minimum,               (game == GAME_LARN) ?              0 :                      1,
                    INTEGER_Maximum,               (game == GAME_LARN) ? dungeonreached : (ULONG) maxlevel[game],
                    INTEGER_Number,                dungeonnow,
                    INTEGER_MinVisible,            2 + 1,
                LayoutEnd,
                (game != GAME_HACK ) ? LAYOUT_AddChild : TAG_IGNORE, gadgets[GID_ROGUE_LY3],
            LayoutEnd,
            (game == GAME_LARN)? LAYOUT_AddChild : TAG_IGNORE, gadgets[GID_ROGUE_BU5],
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

    setup_bm(0, gadwidth[game], gadheight[game], SubWindowPtr);

    rogue_drawmap();

 // DISCARD ActivateLayoutGadget(gadgets[GID_ROGUE_LY2], SubWindowPtr, NULL, (Object) gadgets[GID_ROGUE_IN7]);
    subloop();

    if (game != GAME_HACK)
    {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_ROGUE_IN29], &dungeonreached);
    }

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;

    free_bm(0);
}

EXPORT void rogue_key(UBYTE scancode, UWORD qual)
{   int newplace;

    newplace = firstplace;

    switch (scancode)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        move_leftorup(   qual, &newplace, 1, 4);
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        move_rightordown(qual, &newplace, 1, 4, 100 - HISCOREGADS);
    acase SCAN_C:
        if (filetype == FT_SAVEGAME)
        {   DISCARD ActivateLayoutGadget(gadgets[GID_ROGUE_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_ROGUE_ST1]);
        }
    acase SCAN_L:
        if (filetype == FT_SAVEGAME)
        {   mapwindow();
    }   }

    if (newplace != firstplace)
    {   readgadgets();
        firstplace = newplace;
        writegadgets();
}   }

EXPORT void rogue_subtick(SWORD mousex, SWORD mousey)
{   if (mouseisover(GID_ROGUE_SP1, mousex, mousey))
    {   setpointer(TRUE , SubWinObject, SubWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, SubWinObject, SubWindowPtr, FALSE);
}   }

MODULE void larn_reveal(void)
{   int i,
        x, y;

    // make traps visible
    offset = 17;
    for (i = 0; i < (int) dungeonreached + 1; i++)
    {   for (x = 0; x < 67; x++)
        {   for (y = 0; y < 17; y++)
            {   switch (IOBuffer[offset])
                {
                case  0x43: IOBuffer[offset] = 0x42; // arrow    trap
                acase 0x49: IOBuffer[offset] = 0x4A; // dart     trap
                acase 0x4C: IOBuffer[offset] = 0x4B; // trapdoor
                acase 0x4E: IOBuffer[offset] = 0x09; // teleport trap
                }
                offset += 8;
    }   }   }

    // explore everywhere
    offset = 20;
    for (i = 0; i < (int) dungeonreached + 1; i++)
    {   for (x = 0; x < 67; x++)
        {   for (y = 0; y < 17; y++)
            {   IOBuffer[offset] = 0x01;
                offset += 8;
}   }   }   }

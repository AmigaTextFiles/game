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
#define GID_POR_LY1     0 // root layout
#define GID_POR_SB1     1 // toolbar
#define GID_POR_ST1     2 // name
#define GID_POR_BU1     3 // maximize
#define GID_POR_BU2     4 // invert selection
#define GID_POR_BU3     5 // all
#define GID_POR_BU4     6 // none (for spellbook)
#define GID_POR_BU5     7 // none (for memorized spells)
#define GID_POR_LB1     8 // spellbook
#define GID_POR_LB3     9 // memorized spells
#define GID_POR_CH1    10 // sex
#define GID_POR_CH2    11 // alignment
#define GID_POR_CH3    12 // race
#define GID_POR_CH4    13 // class
#define GID_POR_CH5    14 // status
#define GID_POR_CH6    15 // game
#define GID_POR_IN1    16 // age
#define GID_POR_IN2    17 // movement rate
#define GID_POR_IN3    18 // cur hp
#define GID_POR_IN4    19 // max hp
#define GID_POR_IN5    20 // xp
#define GID_POR_IN6    21 // str
#define GID_POR_IN7    22 // exc str
#define GID_POR_IN8    23 // iq
#define GID_POR_IN9    24 // wis
#define GID_POR_IN10   25 // dex
#define GID_POR_IN11   26 // con
#define GID_POR_IN12   27 // cha
#define GID_POR_IN13   28 // cur cleric
#define GID_POR_IN14   29 // cur druid
#define GID_POR_IN15   30 // cur fighter
#define GID_POR_IN16   31 // cur paladin
#define GID_POR_IN17   32 // cur ranger
#define GID_POR_IN18   33 // cur magic-user
#define GID_POR_IN19   34 // cur thief
#define GID_POR_IN20   35 // cur monk
#define GID_POR_IN21   36 // cp
#define GID_POR_IN22   37 // sp
#define GID_POR_IN23   38 // ep
#define GID_POR_IN24   39 // gp
#define GID_POR_IN25   40 // pp
#define GID_POR_IN26   41 // gems
#define GID_POR_IN27   42 // jewels
#define GID_POR_IN28   43 // damage 1
#define GID_POR_IN29   44 // damage 2
#define GID_POR_IN30   45 // fmr cleric
#define GID_POR_IN31   46 // fmr druid
#define GID_POR_IN32   47 // fmr fighter
#define GID_POR_IN33   48 // fmr paladin
#define GID_POR_IN34   49 // fmr ranger
#define GID_POR_IN35   50 // fmr magic-user
#define GID_POR_IN36   51 // fmr thief
#define GID_POR_IN37   52 // fmr monk

// spells subwindow
#define GID_POR_LY2    53
#define GID_POR_LB2    54

#define GIDS_POR       GID_POR_LB2

#define GAME_POR        0
#define GAME_CAB        1
#define GAME_SSB        2
#define GAME_POD        3

#define SPELLS        116

#define AddLevel(x) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) IntegerObject, GA_ID, x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 127, INTEGER_MinVisible, 3 + 1, IntegerEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void eithergadgets(void);
MODULE void maximize_man(void);
MODULE void serialize(void);
MODULE void spellwindow(void);

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
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SexList,
                            SpeedBarList;
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

MODULE ULONG                game;
MODULE int                  whichslot;
MODULE struct List          SpellsList1,
                            SpellsList2,
                            SpellsList3;

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  DD.. .... .... ....    . = Transparent  (%00)
    LDD. .... .... ....    G = Grey         (%01)
    .LDD .... .... ....    D = Dark yellow  (%10)
    ..LD D... .... ....    L = Light yellow (%11)
    ...L DD.. .... ....
    .... LDD. .... ....
    .... .LDD .... ....
    .... ..LD D... ....
    .... ...L DD.. .DG.
    .... .... LDD. .DG.
    .... .... .LDD DG..
    .... .... ..LD G...
    .... .... ..DD DD..
    .... .... DDG. DDDD
    .... .... GG.. .LD.
    .... .... .... .L..


          Plane 1                Plane 0
    DD.. .... .... ....    .... .... .... ....
    LDD. .... .... ....    L... .... .... ....
    .LDD .... .... ....    .L.. .... .... ....
    ..LD D... .... ....    ..L. .... .... ....
    ...L DD.. .... ....    ...L .... .... ....
    .... LDD. .... ....    .... L... .... ....
    .... .LDD .... ....    .... .L.. .... ....
    .... ..LD D... ....    .... ..L. .... ....
    .... ...L DD.. .D..    .... ...L .... ..G.
    .... .... LDD. .D..    .... .... L... ..G.
    .... .... .LDD D...    .... .... .L.. .G..
    .... .... ..LD ....    .... .... ..L. G...
    .... .... ..DD DD..    .... .... .... ....
    .... .... DD.. DDDD    .... .... ..G. ....
    .... .... .... .LD.    .... .... GG.. .L..
    .... .... .... .L..    .... .... .... .L..
          Yellows          Grey & light yellow


    Plane 1 Plane 0 */
    0xC000, 0x0000,
    0xE000, 0x8000,
    0x7000, 0x4000,
    0x3800, 0x2000,
    0x1C00, 0x1000,
    0x0E00, 0x0800,
    0x0700, 0x0400,
    0x0380, 0x0200,
    0x01C4, 0x0102,
    0x00E4, 0x0082,
    0x0078, 0x0044,
    0x0030, 0x0028,
    0x003C, 0x0000,
    0x00CF, 0x0020,
    0x0006, 0x00C4,
    0x0004, 0x0004,

    0x0000, 0x0000  // reserved
};
#endif

MODULE struct
{   TEXT  name[15 + 1];
    ULONG str, excstr, iq, wis, dex, con, cha,
          curhp, maxhp, xp, age,
          sex, alignment, race, theclass,
          level[2][8],
          spellbook[SPELLS],
          cp, sp, ep, gp, pp, gems, jewels,
          status, movement, damage1, damage2;
    SLONG spellmem[116];
} man;

MODULE const STRPTR GameOptions[4 + 1] =
{ "Pool of Radiance",
  "Curse of the Azure Bonds",
  "Secret of the Silver Blades",
  "Pools of Darkness",
  NULL
}, AlignmentOptions[9 + 1] =
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
{ "Cleric",
  "Druid",
  "Fighter",
  "Paladin",
  "Ranger",
  "Magic-User",
  "Thief",
  "Monk",
  "Cleric/Fighter",
  "Cleric/Fighter/M-U",
  "Cleric/Ranger",
  "Cleric/Magic-User",
  "Cleric/Thief",
  "Fighter/Magic-User",
  "Fighter/Thief",
  "Fighter/M-U/Thief",
  "Magic-User/Thief",
  NULL
}, RaceOptions[9 + 1] =
{ "Dwarf",    // 0
  "Elf",      // 1
  "Gnome",    // 2
  "Half-Elf", // 3
  "Halfling", // 4
  "Half-Orc", // 5
  "Human",    // 6
  "Monster",  // 7
  "Tribble",  // 8
  NULL
}, StatusOptions[9 + 1] =
{ "OK",
  "Animated",
  "Temporarily gone",
  "Running",
  "Unconscious",
  "Dying",
  "Dead",
  "Stoned",
  "Permanently gone",
  NULL
};

MODULE const SBYTE race_file_to_gad[4][8] = {
{ 7, 0, 1, 2, 3,  4, 5, 6     }, // POR
{ 7, 0, 1, 2, 3,  4, 5, 6     }, // CAB
{ 8, 1, 3, 0, 2,  4, 6, 7     }, // SSB
{ 1, 3, 0, 2, 4,  6, 7, 6     }  // POD
}, race_gad_to_file[4][9] = {
{ 1, 2, 3, 4, 5,  6, 7, 0, -1 }, // POR
{ 1, 2, 3, 4, 5,  6, 7, 0, -1 }, // CAB
{ 3, 1, 4, 2, 5, -1, 6, 7,  0 }, // SSB
{ 2, 0, 3, 1, 4, -1, 5, 6, -1 }  // POD
};

MODULE const UBYTE memslots[4] =
{    21, // $17..$ 2D POR
     84, // $1E..$ 71 CAB
     75, // $1E..$ 68 SSB
    116  // $CC..$13F POD
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   SWORD  byte[4];
    UBYTE  bit,
           value[4];
    STRPTR code,
           name;
} spellinfo[SPELLS] = {
//   POR   CAB   SSB    POD   POD    POR   CAB   SSB   POD
{ { 0x33, 0x79, 0x71, 0x159 }, 0, { 0x01, 0x01, 0x01, 0x01 }, "C1", "Bless"                            }, //   0
{ { 0x34, 0x7A, 0x72, 0x159 }, 1, { 0x02, 0x02, 0x02, 0x02 }, "C1", "Curse"                            },
{ { 0x35, 0x7B, 0x73, 0x159 }, 2, { 0x03, 0x03, 0x03, 0x03 }, "C1", "Cure Light Wounds (Cleric)"       },
{ { 0x36, 0x7C, 0x74, 0x159 }, 3, { 0x04, 0x04, 0x04, 0x04 }, "C1", "Cause Light Wounds"               },
{ { 0x37, 0x7D, 0x75, 0x159 }, 4, { 0x05, 0x05, 0x05, 0x05 }, "C1", "Detect Magic (Cleric)"            },
{ { 0x38, 0x7E, 0x76, 0x159 }, 5, { 0x06, 0x06, 0x06, 0x06 }, "C1", "Protection from Evil (Cleric)"    },
{ { 0x39, 0x7F, 0x77, 0x159 }, 6, { 0x07, 0x07, 0x07, 0x07 }, "C1", "Protection from Good (Cleric)"    },
{ { 0x3A, 0x80, 0x78, 0x159 }, 7, { 0x08, 0x08, 0x08, 0x08 }, "C1", "Resist Cold"                      },
{ { 0x48, 0x8E, 0x86, 0x15B }, 5, { 0x16, 0x16, 0x16, 0x16 }, "C2", "Find Traps"                       },
{ { 0x49, 0x8F, 0x87, 0x15B }, 6, { 0x17, 0x17, 0x17, 0x17 }, "C2", "Hold Person (Cleric)"             },
{ { 0x4A, 0x90, 0x88, 0x15B }, 7, { 0x18, 0x18, 0x18, 0x18 }, "C2", "Resist Fire"                      }, //  10
{ { 0x4B, 0x91, 0x89, 0x15C }, 0, { 0x19, 0x19, 0x19, 0x19 }, "C2", "Silence, 15' Radius"              },
{ { 0x4C, 0x92, 0x8A, 0x15C }, 1, { 0x1A, 0x1A, 0x1A, 0x1A }, "C2", "Slow Poison"                      },
{ { 0x4D, 0x93, 0x8B, 0x15C }, 2, { 0x1B, 0x1B, 0x1B, 0x1B }, "C2", "Snake Charm"                      },
{ { 0x4E, 0x94, 0x8C, 0x15C }, 3, { 0x1C, 0x1C, 0x1C, 0x1C }, "C2", "Spiritual Hammer"                 },
{ { 0x56,   -1,   -1,    -1 }, 8, { 0x24,    0,    0,    0 }, "C3", "Animate Dead"                     },
{ { 0x57, 0x9D, 0x95, 0x15D }, 4, { 0x25, 0x25, 0x25, 0x25 }, "C3", "Cure Blindness"                   },
{ { 0x58, 0x9E, 0x96, 0x15D }, 5, { 0x26, 0x26, 0x26, 0x26 }, "C3", "Cause Blindness"                  },
{ { 0x59, 0x9F, 0x97, 0x15D }, 6, { 0x27, 0x27, 0x27, 0x27 }, "C3", "Cure Disease (Cleric)"            },
{ { 0x5A, 0xA0, 0x98, 0x15D }, 7, { 0x28, 0x28, 0x28, 0x28 }, "C3", "Cause Disease"                    },
{ { 0x5B, 0xA1, 0x99, 0x15E }, 0, { 0x29, 0x29, 0x29, 0x29 }, "C3", "Dispel Magic (Cleric)"            }, //  20
{ { 0x5C, 0xA2, 0x9A, 0x15E }, 1, { 0x2A, 0x2A, 0x2A, 0x2A }, "C3", "Prayer"                           },
{ { 0x5D, 0xA3, 0x9B, 0x15E }, 2, { 0x2B, 0x2B, 0x2B, 0x2B }, "C3", "Remove Curse (Cleric)"            },
{ { 0x5E, 0xA4, 0x9C, 0x15E }, 3, { 0x2C, 0x2C, 0x2C, 0x2C }, "C3", "Bestow Curse (Cleric)"            },
{ {   -1, 0xB2, 0xAA, 0x160 }, 1, {    0, 0x3A, 0x3A, 0x3A }, "C4", "Cure Serious Wounds"              },
{ {   -1, 0xBA, 0xB2, 0x161 }, 1, {    0, 0x42, 0x42, 0x42 }, "C4", "Cause Serious Wounds"             },
{ {   -1, 0xBB, 0xB3, 0x161 }, 2, {    0, 0x43, 0x43, 0x43 }, "C4", "Neutralize Poison (Cleric)"       },
{ {   -1, 0xBC, 0xB4, 0x161 }, 3, {    0, 0x44, 0x44, 0x44 }, "C4", "Poison"                           },
{ {   -1, 0xBD, 0xB5, 0x161 }, 4, {    0, 0x45, 0x45, 0x45 }, "C4", "Protection from Evil, 10' Radius" },
{ {   -1, 0xBE, 0xB6, 0x161 }, 5, {    0, 0x46, 0x46, 0x46 }, "C4", "Sticks to Snakes"                 },
{ {   -1, 0xBF, 0xB7, 0x161 }, 6, {    0, 0x47, 0x47, 0x47 }, "C5", "Cure Critical Wounds"             }, //  30
{ {   -1, 0xC0, 0xB8, 0x161 }, 7, {    0, 0x48, 0x48, 0x48 }, "C5", "Cause Critical Wounds"            },
{ {   -1, 0xC1, 0xB9, 0x162 }, 0, {    0, 0x49, 0x49, 0x49 }, "C5", "Dispel Evil"                      },
{ {   -1, 0xC2, 0xBA, 0x162 }, 1, {    0, 0x4A, 0x4A, 0x4A }, "C5", "Flame Strike"                     },
{ {   -1, 0xC3, 0xBB, 0x162 }, 2, {    0, 0x4B, 0x4B, 0x4B }, "C5", "Raise Dead"                       },
{ {   -1, 0xC4, 0xBC, 0x162 }, 3, {    0, 0x4C, 0x4C, 0x4C }, "C5", "Slay Living"                      },
{ {   -1,   -1, 0x94, 0x15D }, 3, {    0,    0, 0x24, 0x24 }, "C6", "Heal"                             },
{ {   -1,   -1, 0xA8, 0x15F }, 7, {    0,    0, 0x38, 0x38 }, "C6", "Harm"                             },
{ {   -1,   -1,   -1, 0x165 }, 4, {    0,    0,    0, 0x65 }, "C6", "Blade Barrier"                    },
{ {   -1, 0xB0,   -1, 0x165 }, 5, {    0, 0x38,    0, 0x66 }, "C7", "Restoration"                      },
{ {   -1,   -1,   -1, 0x165 }, 6, {    0,    0,    0, 0x67 }, "C7", "Energy Drain"                     }, //  40
{ {   -1,   -1,   -1, 0x165 }, 7, {    0,    0,    0, 0x68 }, "C7", "Destruction"                      },
{ {   -1,   -1,   -1, 0x166 }, 0, {    0,    0,    0, 0x69 }, "C7", "Resurrection"                     },
{ {   -1, 0xC5, 0xBD, 0x162 }, 4, {    0, 0x4D, 0x4D, 0x4D }, "D1", "Detect Magic (Druid)"             },
{ {   -1, 0xC6, 0xBE, 0x162 }, 5, {    0, 0x4E, 0x4E, 0x4E }, "D1", "Entangle"                         },
{ {   -1, 0xC7, 0xBF, 0x162 }, 6, {    0, 0x4F, 0x4F, 0x4F }, "D1", "Faerie Fire"                      },
{ {   -1, 0xC8, 0xC0, 0x162 }, 7, {    0, 0x50, 0x50, 0x50 }, "D1", "Invisibility to Animals"          },
{ {   -1,   -1, 0xCA, 0x164 }, 6, {    0,    0, 0x5F, 0x5F }, "D2", "Barkskin"                         },
{ {   -1,   -1, 0xD0, 0x164 }, 7, {    0,    0, 0x60, 0x60 }, "D2", "Charm Person or Mammal"           },
{ {   -1,   -1, 0xD2, 0x165 }, 1, {    0,    0, 0x62, 0x62 }, "D2", "Cure Light Wounds (Druid)"        },
{ {   -1,   -1,   -1, 0x166 }, 1, {    0,    0,    0, 0x6A }, "D3", "Cure Disease (Druid)"             }, //  50
{ {   -1,   -1,   -1, 0x166 }, 2, {    0,    0,    0, 0x6B }, "D3", "Neutralize Poison (Druid)"        },
{ {   -1,   -1,   -1, 0x166 }, 3, {    0,    0,    0, 0x6C }, "D3", "Hold Animal"                      },
{ {   -1,   -1,   -1, 0x166 }, 4, {    0,    0,    0, 0x6D }, "D3", "Protection from Fire"             },
{ { 0x3B, 0x81, 0x79, 0x15A }, 0, { 0x09, 0x09, 0x09, 0x09 }, "M1", "Burning Hands"                    },
{ { 0x3C, 0x82, 0x7A, 0x15A }, 1, { 0x0A, 0x0A, 0x0A, 0x0A }, "M1", "Charm Person"                     },
{ { 0x3D, 0x83, 0x7B, 0x15A }, 2, { 0x0B, 0x0B, 0x0B, 0x0B }, "M1", "Detect Magic (M-U)"               },
{ { 0x3E, 0x84, 0x7C, 0x15A }, 3, { 0x0C, 0x0C, 0x0C, 0x0C }, "M1", "Enlarge"                          },
{ { 0x3F, 0x85, 0x7D, 0x15A }, 4, { 0x0D, 0x0D, 0x0D, 0x0D }, "M1", "Reduce"                           },
{ { 0x40, 0x86, 0x7E, 0x15A }, 5, { 0x0E, 0x0E, 0x0E, 0x0E }, "M1", "Friends"                          },
{ { 0x41, 0x87, 0x7F, 0x15A }, 6, { 0x0F, 0x0F, 0x0F, 0x0F }, "M1", "Magic Missile"                    }, //  60
{ { 0x42, 0x88, 0x80, 0x15A }, 7, { 0x10, 0x10, 0x10, 0x10 }, "M1", "Protection from Evil (M-U)"       },
{ { 0x43, 0x89, 0x81, 0x15B }, 0, { 0x11, 0x11, 0x11, 0x11 }, "M1", "Protection from Good (M-U)"       },
{ { 0x44, 0x8A, 0x82, 0x15B }, 1, { 0x12, 0x12, 0x12, 0x12 }, "M1", "Read Magic"                       },
{ { 0x45, 0x8B, 0x83, 0x15B }, 2, { 0x13, 0x13, 0x13, 0x13 }, "M1", "Shield"                           },
{ { 0x46, 0x8C, 0x84, 0x15B }, 3, { 0x14, 0x14, 0x14, 0x14 }, "M1", "Shocking Grasp"                   },
{ { 0x47, 0x8D, 0x85, 0x15B }, 4, { 0x15, 0x15, 0x15, 0x15 }, "M1", "Sleep"                            },
{ { 0x4F, 0x95, 0x8D, 0x15C }, 4, { 0x1D, 0x1D, 0x1D, 0x1D }, "M2", "Detect Invisibility"              },
{ { 0x50, 0x96, 0x8E, 0x15C }, 5, { 0x1E, 0x1E, 0x1E, 0x1E }, "M2", "Invisibility"                     },
{ { 0x51, 0x97, 0x8F, 0x15C }, 6, { 0x1F, 0x1F, 0x1F, 0x1F }, "M2", "Knock"                            },
{ { 0x52, 0x98, 0x90, 0x15C }, 7, { 0x20, 0x20, 0x20, 0x20 }, "M2", "Mirror Image"                     }, //  70
{ { 0x53, 0x99, 0x91, 0x15D }, 0, { 0x21, 0x21, 0x21, 0x21 }, "M2", "Ray of Enfeeblement"              },
{ { 0x54, 0x9A, 0x92, 0x15D }, 1, { 0x22, 0x22, 0x22, 0x22 }, "M2", "Stinking Cloud"                   },
{ { 0x55, 0x9B, 0x93, 0x15D }, 2, { 0x23, 0x23, 0x23, 0x23 }, "M2", "Strength"                         },
{ {   -1, 0xA5, 0x9D, 0x15E }, 4, {    0, 0x2D, 0x2D, 0x2D }, "M3", "Blink"                            },
{ { 0x5F, 0xA6, 0x9E, 0x15E }, 5, { 0x2D, 0x2E, 0x2D, 0x2E }, "M3", "Dispel Magic (M-U)"               },
{ { 0x60, 0xA7, 0x9F, 0x15E }, 6, { 0x2E, 0x2F, 0x2E, 0x2F }, "M3", "Fireball"                         },
{ { 0x61, 0xA8, 0xA0, 0x15E }, 7, { 0x2F, 0x30, 0x2F, 0x30 }, "M3", "Haste"                            },
{ { 0x62, 0xA9, 0xA1, 0x15F }, 0, { 0x30, 0x31, 0x30, 0x31 }, "M3", "Hold Person (M-U)"                },
{ { 0x63, 0xAA, 0xA2, 0x15F }, 1, { 0x31, 0x32, 0x31, 0x32 }, "M3", "Invisibility, 10' Radius"         },
{ { 0x64, 0xAB, 0xA3, 0x15F }, 2, { 0x32, 0x33, 0x32, 0x33 }, "M3", "Lightning Bolt"                   }, //  80
{ { 0x65, 0xAC, 0xA4, 0x15F }, 3, { 0x33, 0x34, 0x33, 0x34 }, "M3", "Protection from Evil, 10' Radius" },
{ { 0x66, 0xAD, 0xA5, 0x15F }, 4, { 0x34, 0x35, 0x34, 0x35 }, "M3", "Protection from Good, 10' Radius" },
{ {   -1, 0xAE, 0xA6, 0x15F }, 5, {    0, 0x36, 0x36, 0x36 }, "M3", "Protection from Normal Missiles"  },
{ {   -1, 0xAF, 0xA7, 0x15F }, 6, {    0, 0x37, 0x37, 0x37 }, "M3", "Slow"                             },
{ {   -1, 0xC9, 0xC1, 0x163 }, 0, {    0, 0x51, 0x51, 0x51 }, "M4", "Charm Monsters"                   },
{ {   -1, 0xCA, 0xC2, 0x163 }, 1, {    0, 0x52, 0x52, 0x52 }, "M4", "Confusion"                        },
{ {   -1, 0xCB, 0xC3, 0x163 }, 2, {    0, 0x53, 0x53, 0x53 }, "M4", "Dimension Door"                   },
{ {   -1, 0xCC, 0xC4, 0x163 }, 3, {    0, 0x54, 0x54, 0x54 }, "M4", "Fear"                             },
{ {   -1, 0xCD, 0xC5, 0x163 }, 4, {    0, 0x55, 0x55, 0x55 }, "M4", "Fire Shield"                      },
{ {   -1, 0xCE, 0xC6, 0x163 }, 5, {    0, 0x56, 0x56, 0x56 }, "M4", "Fumble"                           }, //  90
{ {   -1, 0xCF, 0xC7, 0x163 }, 6, {    0, 0x57, 0x57, 0x57 }, "M4", "Ice Storm"                        },
{ {   -1, 0xD0, 0xC8, 0x163 }, 7, {    0, 0x58, 0x58, 0x58 }, "M4", "Minor Globe of Invulnerability"   },
{ {   -1, 0xD1, 0xC9, 0x164 }, 0, {    0, 0x59, 0x59, 0x59 }, "M4", "Remove Curse (M-U)"               },
{ {   -1, 0xDC, 0xD4, 0x165 }, 3, {    0, 0x64, 0x64, 0x64 }, "M4", "Bestow Curse (M-U)"               },
{ {   -1, 0xD3, 0xCB, 0x164 }, 2, {    0, 0x5B, 0x5B, 0x5B }, "M5", "Cloudkill"                        },
{ {   -1, 0xD4, 0xCC, 0x164 }, 3, {    0, 0x5C, 0x5C, 0x5C }, "M5", "Cone of Cold"                     },
{ {   -1, 0xD5, 0xCD, 0x164 }, 4, {    0, 0x5D, 0x5D, 0x5D }, "M5", "Feeblemind"                       },
{ {   -1, 0xD6, 0xCE, 0x164 }, 5, {    0, 0x5E, 0x5E, 0x5E }, "M5", "Hold Monsters"                    },
{ {   -1,   -1,   -1, 0x167 }, 5, {    0,    0,    0, 0x76 }, "M5", "Fire Touch"                       },
{ {   -1,   -1,   -1, 0x167 }, 6, {    0,    0,    0, 0x77 }, "M5", "Iron Skin"                        }, // 100
{ {   -1,   -1, 0xDE, 0x166 }, 5, {    0,    0, 0x6E, 0x6E }, "M6", "Death Spell"                      },
{ {   -1,   -1, 0xDF, 0x166 }, 6, {    0,    0, 0x6F, 0x6F }, "M6", "Disintegrate"                     },
{ {   -1,   -1, 0xE0, 0x166 }, 7, {    0,    0, 0x70, 0x70 }, "M6", "Globe of Invulnerability"         },
{ {   -1,   -1, 0xE1, 0x167 }, 0, {    0,    0, 0x71, 0x71 }, "M6", "Stone to Flesh"                   },
{ {   -1,   -1, 0xE2, 0x167 }, 1, {    0,    0, 0x72, 0x72 }, "M6", "Flesh to Stone"                   },
{ {   -1,   -1, 0xE3, 0x167 }, 2, {    0,    0, 0x73, 0x73 }, "M7", "Delayed Blast Fireball"           },
{ {   -1,   -1, 0xE4, 0x167 }, 3, {    0,    0, 0x74, 0x74 }, "M7", "Mass Invisibility"                },
{ {   -1,   -1, 0xE5, 0x167 }, 4, {    0,    0, 0x75, 0x75 }, "M7", "Power Word, Stun"                 },
{ {   -1,   -1,   -1, 0x167 }, 7, {    0,    0,    0, 0x78 }, "M8", "Mass Charm"                       },
{ {   -1,   -1,   -1, 0x168 }, 0, {    0,    0,    0, 0x79 }, "M8", "Otto's Irresistable Dance"        }, // 110
{ {   -1,   -1,   -1, 0x168 }, 1, {    0,    0,    0, 0x7A }, "M8", "Mind Blank"                       },
{ {   -1,   -1,   -1, 0x168 }, 2, {    0,    0,    0, 0x7B }, "M8", "Power Word, Blind"                },
{ {   -1,   -1,   -1, 0x168 }, 3, {    0,    0,    0, 0x7C }, "M9", "Meteor Swarm"                     },
{ {   -1,   -1,   -1, 0x168 }, 4, {    0,    0,    0, 0x7D }, "M9", "Power Word, Kill"                 },
{ {   -1,   -1,   -1, 0x168 }, 5, {    0,    0,    0, 0x7E }, "M9", "Monster Summoning"                }, // 115
};
/* C = Cleric
   D = Druid
   M = Magic-User */

// "ColumnInfo can NOT be shared amongst other listbrowsers simultaneously."
MODULE struct ColumnInfo ColumnInfo1[] =
{ { 0,
    "",
    CIF_WEIGHTED | CIF_SORTABLE
  },
  { 0,                          // WORD   ci_Width (ignored due to LISTBROWSER_AutoFit)
    "",                         // STRPTR ci_Title
    CIF_WEIGHTED | CIF_SORTABLE // ULONG  ci_Flags
  },
  { -1,
    (STRPTR) ~0,
    -1
} }, ColumnInfo2[] =
{ { 0,
    "",
    CIF_WEIGHTED | CIF_SORTABLE
  },
  { 0,                          // WORD   ci_Width (ignored due to LISTBROWSER_AutoFit)
    "",                         // STRPTR ci_Title
    CIF_WEIGHTED | CIF_SORTABLE // ULONG  ci_Flags
  },
  { -1,
    (STRPTR) ~0,
    -1
} }, ColumnInfo3[] =
{ { 0,
    "",
    CIF_WEIGHTED | CIF_SORTABLE
  },
  { 0,                          // WORD   ci_Width (ignored due to LISTBROWSER_AutoFit)
    "",                         // STRPTR ci_Title
    CIF_WEIGHTED | CIF_SORTABLE // ULONG  ci_Flags
  },
  { -1,
    (STRPTR) ~0,
    -1
} };

// 8. CODE ---------------------------------------------------------------

EXPORT void por_main(void)
{   TRANSIENT int          i;
    TRANSIENT struct Node* NodePtr;
    PERSIST   FLAG         first = TRUE;

    if (first)
    {   first = FALSE;

        // por_preinit()
        NewList(&SpellsList1);
        NewList(&SpellsList2);
        NewList(&SpellsList3);

        // por_init()
        NodePtr = (struct Node*) AllocListBrowserNode
        (   2, // columns
            LBNA_Column,       0,
             LBNCA_Text,       "--",
            LBNA_Column,       1,
             LBNCA_Text,       "None",
        TAG_END);
        // we should check NodePtr is non-zero
        AddTail(&SpellsList2, (struct Node*) NodePtr);
        for (i = 0; i < SPELLS; i++)
        {   NodePtr = (struct Node*) AllocListBrowserNode
            (   2, // columns
                LBNA_CheckBox, TRUE,
                LBNA_Column,   0,
                 LBNCA_Text,   spellinfo[i].code,
                LBNA_Column,   1,
                 LBNCA_Text,   spellinfo[i].name,
            TAG_END);
            // we should check NodePtr is non-zero
            AddTail(&SpellsList1, (struct Node*) NodePtr);
            NodePtr = (struct Node*) AllocListBrowserNode
            (   2, // columns
                LBNA_Column,   0,
                 LBNCA_Text,   spellinfo[i].code,
                LBNA_Column,   1,
                 LBNCA_Text,   spellinfo[i].name,
            TAG_END);
            // we should check NodePtr is non-zero
            AddTail(&SpellsList2, (struct Node*) NodePtr);
    }   }

    tool_open      = por_open;
    tool_loop      = por_loop;
    tool_save      = por_save;
    tool_close     = por_close;
    tool_exit      = por_exit;
    tool_subgadget = por_subgadget;

    if (loaded != FUNC_POR && !por_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_POR;

    make_speedbar_list(GID_POR_SB1);
    load_aiss_images( 6,  8);
    load_aiss_images(10, 10);
    makesexlist();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_POR_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            AddHLayout,
                AddToolbar(GID_POR_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_POR_CH6] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_POR_CH6,
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
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_Label,                      "General",
                        LAYOUT_AddChild,                   gadgets[GID_POR_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_POR_ST1,
                            GA_TabCycle,                   TRUE,
                            GA_RelVerify,                  TRUE,
                            STRINGA_TextVal,               man.name,
                            STRINGA_MaxChars,              15 + 1,
                        StringEnd,
                        Label("Name:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_CH1] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_POR_CH1,
                            CHOOSER_Labels,                &SexList,
                        PopUpEnd,
                        Label("Sex:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_CH2] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_POR_CH2,
                            CHOOSER_LabelArray,            &AlignmentOptions,
                        PopUpEnd,
                        Label("Alignment:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_CH3] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_POR_CH3,
                            CHOOSER_LabelArray,            &RaceOptions,
                        PopUpEnd,
                        Label("Race:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_CH4] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_POR_CH4,
                            CHOOSER_LabelArray,            &ClassOptions,
                            CHOOSER_MaxLabels,             17,
                        PopUpEnd,
                        Label("Class:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_CH5] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_POR_CH5,
                            CHOOSER_LabelArray,            &StatusOptions,
                        PopUpEnd,
                        Label("Condition:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Age:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN2] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN2,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               255,
                            INTEGER_MinVisible,            3 + 1,
                        IntegerEnd,
                        Label("Movement:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_POR_IN28] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_POR_IN28,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           255,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            AddLabel("d"),
                            LAYOUT_AddChild,               gadgets[GID_POR_IN29] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_POR_IN29,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           255,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Damage:"),
                        CHILD_WeightedHeight,              0,
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_POR_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_POR_IN3,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           254,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            AddLabel("of"),
                            LAYOUT_AddChild,               gadgets[GID_POR_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_POR_IN4,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           1,
                                INTEGER_Maximum,           254,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Hit Points:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN5,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               SLONG_MAX,
                            INTEGER_MinVisible,            13 + 1,
                        IntegerEnd,
                        Label("Experience:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_Label,                      "Attributes",
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_POR_IN6] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_POR_IN6,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           1,
                                INTEGER_Maximum,           25,
                                INTEGER_MinVisible,        2 + 1,
                            IntegerEnd,
                            AddLabel("/"),
                            LAYOUT_AddChild,               gadgets[GID_POR_IN7] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_POR_IN7,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Strength:"),
                        CHILD_WeightedHeight,              0,
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN8] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN8,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               25,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Intelligence:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN9] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN9,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               25,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Wisdom:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN10] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN10,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               25,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Dexterity:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN11] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN11,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               25,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Constitution:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN12] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN12,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               1,
                            INTEGER_Maximum,               25,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Charisma:"),
                    LayoutEnd,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_Label,                      "Treasure",
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN21] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN21,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Copper:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN22] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN22,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Silver:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN23] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN23,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Electrum:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN24] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN24,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Gold:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN25] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN25,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Platinum:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN26] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN26,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Gems:"),
                        LAYOUT_AddChild,                   gadgets[GID_POR_IN27] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_POR_IN27,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               65535,
                            INTEGER_MinVisible,            5 + 1,
                        IntegerEnd,
                        Label("Jewels:"),
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_Label,                      "Levels",
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddLevel(GID_POR_IN30),
                            Label("F:"),
                            AddLevel(GID_POR_IN13),
                            Label("C:"),
                        LayoutEnd,
                        Label("Cleric:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddLevel(GID_POR_IN31),
                            Label("F:"),
                            AddLevel(GID_POR_IN14),
                            Label("C:"),
                        LayoutEnd,
                        Label("Druid:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddLevel(GID_POR_IN32),
                            Label("F:"),
                            AddLevel(GID_POR_IN15),
                            Label("C:"),
                        LayoutEnd,
                        Label("Fighter:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddLevel(GID_POR_IN33),
                            Label("F:"),
                            AddLevel(GID_POR_IN16),
                            Label("C:"),
                        LayoutEnd,
                        Label("Paladin:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddLevel(GID_POR_IN34),
                            Label("F:"),
                            AddLevel(GID_POR_IN17),
                            Label("C:"),
                        LayoutEnd,
                        Label("Ranger:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddLevel(GID_POR_IN35),
                            Label("F:"),
                            AddLevel(GID_POR_IN18),
                            Label("C:"),
                        LayoutEnd,
                        Label("M-U:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddLevel(GID_POR_IN36),
                            Label("F:"),
                            AddLevel(GID_POR_IN19),
                            Label("C:"),
                        LayoutEnd,
                        Label("Thief:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            AddLevel(GID_POR_IN37),
                            Label("F:"),
                            AddLevel(GID_POR_IN20),
                            Label("C:"),
                        LayoutEnd,
                        Label("Monk:"),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "Spellbook (Grimoire)",
                        LAYOUT_AddChild,                   gadgets[GID_POR_LB1] = (struct Gadget*)
                        ListBrowserObject,
                            GA_ID,                         GID_POR_LB1,
                            GA_RelVerify,                  TRUE,
                            LISTBROWSER_ColumnInfo,        (ULONG) &ColumnInfo1,
                            LISTBROWSER_Labels,            (ULONG) &SpellsList1,
                            LISTBROWSER_AutoFit,           TRUE,
                            LISTBROWSER_ShowSelected,      TRUE,
                         // LISTBROWSER_AutoWheel,         FALSE, // commented out to work around a bug in OS3.2
                        ListBrowserEnd,
                        HTripleButton(GID_POR_BU3, GID_POR_BU2, GID_POR_BU4),
                    LayoutEnd,
                    LAYOUT_WeightBar,                      TRUE,
                    AddVLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "Memorized Spells",
                        LAYOUT_AddChild,                   gadgets[GID_POR_LB3] = (struct Gadget*)
                        ListBrowserObject,
                            GA_ID,                         GID_POR_LB3,
                            GA_RelVerify,                  TRUE,
                            LISTBROWSER_ColumnInfo,        (ULONG) &ColumnInfo3,
                            LISTBROWSER_Labels,            NULL,
                            LISTBROWSER_AutoFit,           TRUE,
                            LISTBROWSER_ShowSelected,      TRUE,
                         // LISTBROWSER_AutoWheel,         FALSE, // commented out to work around a bug in OS3.2
                        ListBrowserEnd,
                        NoneButton(GID_POR_BU5),
                        CHILD_WeightedHeight,              0,
                    LayoutEnd,
                LayoutEnd,
            LayoutEnd,
            MaximizeButton(GID_POR_BU1, "Maximize Character"),
            CHILD_WeightedHeight,                          0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_POR_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_POR_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_POR_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void por_loop(ULONG gid, UNUSED ULONG code)
{   int i;

    switch (gid)
    {
    case GID_POR_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_POR_BU2:
        readgadgets();
        for (i = 0; i < SPELLS; i++)
        {   if (man.spellbook[i])
            {   man.spellbook[i] = 0;
            } elif (spellinfo[i].byte[game] != -1)
            {   man.spellbook[i] = 1;
        }   }
        writegadgets();
    acase GID_POR_BU3:
        readgadgets();
        for (i = 0; i < SPELLS; i++)
        {   if (spellinfo[i].byte[game] != -1)
            {   man.spellbook[i] = 1;
        }   }
        writegadgets();
    acase GID_POR_BU4:
        readgadgets();
        for (i = 0; i < SPELLS; i++)
        {   man.spellbook[i] = 0;
        }
        writegadgets();
    acase GID_POR_BU5:
        readgadgets();
        for (i = 0; i < 116; i++)
        {   man.spellmem[i] = -1;
        }
        writegadgets();
    acase GID_POR_LB3:
        whichslot = code;
        spellwindow();
}   }

EXPORT FLAG por_open(FLAG loadas)
{   int length;

    if (gameopen(loadas))
    {   length = strlen(pathname);
        if   (gamesize >= 286 && length >= 4 && !stricmp(&pathname[length - 4], ".cha")) game = GAME_POR; // eg. 288
        elif (gamesize >= 426 && length >= 4 && !stricmp(&pathname[length - 4], ".guy")) game = GAME_CAB; // eg. 428, 438, 458, 1428
        elif (gamesize >= 339 && length >= 4 && !stricmp(&pathname[length - 4], ".who")) game = GAME_SSB; // eg. 340
        elif (gamesize >= 402 && length >= 3 && !stricmp(&pathname[length - 3], ".pc" )) game = GAME_POD; // eg. 484
        else
        {   DisplayBeep(NULL);
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
    (   page != FUNC_POR
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void serialize(void)
{   TRANSIENT int   i, j, k;
    TRANSIENT UBYTE t;
    PERSIST   UWORD offsets[][4] = {
    //  POR    CAB    SSB    POD
    {  0x2E,  0x74,  0x6B,  0xAD }, //  0 race
    {  0x30,  0x76,  0x6E,  0xB0 }, //  1 age
    {  0x17,  0x1E,  0x1E,  0xCC }, //  2 first memorized spell
    {  0x66,  0xD6,  0xE5, 0x168 }, //  3 last spell in spellbook ($33..$66/$79..$D6/$71..$E5/$159..$168)
    {   0x0,   0x0,   0x0,  0x60 }, //  4 name
    {  0x10,  0x10,  0x10,  0x70 }, //  5 attributes
    {  0x72,  0xE4,  0x87,  0x88 }, //  6 movement
    {  0x8A,  0xFC,  0x9E,  0x4C }, //  7 treasure
    {  0xA0, 0x11A,  0xBA,  0x5C }, //  8 sex
    {  0xA2, 0x11C,  0xBB,  0x5D }, //  9 alignment
    {  0xAE, 0x128,  0xC8,  0x44 }, // 10 experience
    { 0x10E, 0x19A, 0x143,  0x5E }, // 11 status
    {  0x98, 0x10A,  0xAC,  0x9D }, // 12 levels
    {  0xA5, 0x11F,  0xBE,  0xAD }, // 13 damage
    { 0x11D, 0x1A9, 0x152, 0x191 }, // 14 current hp
    {  0x33,  0x79,  0x71, 0x159 }, // 15 first spell in spellbook
    };

    offset = offsets[4][game];
    if (serializemode == SERIALIZE_READ)
    {   strcpy(man.name,                  (char*) &IOBuffer[offset]);
    } else
    {   // assert(serializemode == SERIALIZE_WRITE);
        strcpy((char*) &IOBuffer[offset], man.name); // $0..$E
    }

    offset = offsets[5][game];
    if (game == GAME_POR)
    {   serialize1(&man.str   );      // $ 10
        serialize1(&man.iq    );      // $ 11
        serialize1(&man.wis   );      // $ 12
        serialize1(&man.dex   );      // $ 13
        serialize1(&man.con   );      // $ 14
        serialize1(&man.cha   );      // $ 15
        serialize1(&man.excstr);      // $ 16
    } else
    {   if (serializemode == SERIALIZE_READ)
        {   serialize1(&man.str   );  // $ 10
            offset += 2;              // $ 11..$12
            serialize1(&man.iq    );  // $ 13
            offset++;                 // $ 14
            serialize1(&man.wis   );  // $ 15
            offset++;                 // $ 16
            serialize1(&man.dex   );  // $ 17
            offset++;                 // $ 18
            serialize1(&man.con   );  // $ 19
            offset++;                 // $ 1A
            serialize1(&man.cha   );  // $ 1B
            serialize1(&man.excstr);  // $ 1C
        } else
        {   serialize1(&man.str   );  // $ 10
            serialize1(&man.str   );  // $ 11
            serialize1(&man.iq    );  // $ 12
            serialize1(&man.iq    );  // $ 13
            serialize1(&man.wis   );  // $ 14
            serialize1(&man.wis   );  // $ 15
            serialize1(&man.dex   );  // $ 16
            serialize1(&man.dex   );  // $ 17
            serialize1(&man.con   );  // $ 18
            serialize1(&man.con   );  // $ 19
            serialize1(&man.cha   );  // $ 1A
            serialize1(&man.cha   );  // $ 1B
            serialize1(&man.excstr);  // $ 1C
            serialize1(&man.excstr);  // $ 1D
    }   }

    offset = offsets[2][game];
    if (serializemode == SERIALIZE_READ)
    {   for (i = 0; i < memslots[game]; i++)
        {   serialize1to1(&t);        // $ 17..$ 2D/$ 1E..$ 71/$ 1E..$ 68/$ CC..$13F
            if (t)
            {   for (j = 0; j < SPELLS; j++)
                {   if (spellinfo[j].value[game] == t)
                    {   man.spellmem[i] = j;
                        break; // for speed
            }   }   }
            else
            {   man.spellmem[i] = -1;
    }   }   }
    else
    {   for (i = 0; i < memslots[game]; i++)
        {   if (man.spellmem[i] == -1)
            {   t = 0;
            } else
            {   t = spellinfo[man.spellmem[i]].value[game];
            }
            serialize1to1(&t);        // $ 17..$ 2D/$ 1E..$ 71/$ 1E..$ 68/$ CC..$13F
    }   }

    offset = offsets[0][game];
    man.race = (ULONG) race_gad_to_file[game][man.race];
    serialize1(&man.race);            // $ 2E      /$ 74      /$ 6B      /$ AD
    man.race = (ULONG) race_file_to_gad[game][man.race];
    serialize1(&man.theclass);        // $ 2F      /$ 75      /$ 6C      /$ AE
    offset = offsets[1][game];
    serialize2ulong(&man.age);        // $ 30..$ 31/$ 76..$ 77/$ 6E..$ 6F/$ B0..$ B1
    serialize1(&man.maxhp);           // $ 32      /$ 78      /$ 70      /$ B2
    offset = offsets[15][game];

    if (serializemode == SERIALIZE_READ)
    {   for (i = 0; i < SPELLS; i++)
        {   man.spellbook[i] = FALSE;
        }

        for (i = offset; i <= offsets[3][game]; i++)
        {   serialize1to1(&t);        // $ 33..$ 66/$ 79..$ D6/$ 71..$ E5/$159..$168
            if (game == GAME_POD)
            {   for (j = 0; j < 8; j++)
                {   if (t & (1 << j))
                    {   for (k = 0; k < SPELLS; k++)
                        {   if (spellinfo[k].byte[game] != -1 && spellinfo[k].byte[game] == (SWORD) offset - 1 && spellinfo[k].bit == j)
                            {   man.spellbook[k] = TRUE;
                                break; // for speed
            }   }   }   }   }
            else
            {   for (j = 0; j < SPELLS; j++)
                {   if (spellinfo[j].byte[game] != -1 && spellinfo[j].byte[game] == (SWORD) offset - 1 && t)
                    {   man.spellbook[j] = TRUE;
                        break; // for speed
    }   }   }   }   }
    else
    {   for (i = 0; i < SPELLS; i++)
        {   if (spellinfo[i].byte[game] != -1)
            {   if (game == GAME_POD)
                {   if (man.spellbook[i])
                    {   IOBuffer[spellinfo[i].byte[game]] |=  (1 << spellinfo[i].bit);
                    } else
                    {   IOBuffer[spellinfo[i].byte[game]] &= ~(1 << spellinfo[i].bit);
                }   }
                else
                {   IOBuffer[spellinfo[i].byte[game]] = man.spellbook[i] ? 1 : 0;
    }   }   }   }

    offset = offsets[6][game];
    serialize1(&man.movement);        // $ 72      /$ E4      /$ 87      /$ 88
    offset = offsets[7][game];
    if (game == GAME_POD)
    {   man.cp = man.sp = man.ep = man.gp = 0;
    } else
    {   serialize2ulong(&man.cp);     // $ 8A..$ 8B/$ FC..$ FD/$ 9E..$ 9F/----
        serialize2ulong(&man.sp);     // $ 8C..$ 8D/$ FE..$ FF/$ A0..$ A1/----
        serialize2ulong(&man.ep);     // $ 8E..$ 8F/$100..$101/$ A2..$ A3/----
        serialize2ulong(&man.gp);     // $ 90..$ 91/$102..$103/$ A4..$ A5/----
    }
    serialize2ulong(&man.pp);         // $ 92..$ 93/$104..$105/$ A6..$ A7/$ 4C..$ 4D
    serialize2ulong(&man.gems);       // $ 94..$ 95/$106..$107/$ A8..$ A9/$ 4E..$ 4F
    serialize2ulong(&man.jewels);     // $ 96..$ 97/$108..$109/$ AA..$ AB/$ 50..$ 51
    offset = offsets[12][game];
    for (i = 0; i < 7; i++)
    {   serialize1(&man.level[1][i]); // $ 98..$ 9E/$10A..$110/$ AC..$ B2/$ 9D..$ A3
    }
    if (game == GAME_POR || game == GAME_CAB)
    {   serialize1(&man.level[1][7]); // $ 9F      /$111      /----      /----
    } else
    {   man.level[1][7] = 0;
    }
    if (game == GAME_POR)
    {   for (i = 0; i < 8; i++)
        {   man.level[0][i] = 0;
    }   }
    else
    {   for (i = 0; i < 7; i++)
        {   serialize1(&man.level[0][i]); // ----  /$112..$118/$ B3..$ B9/$ A4..$ AA
        }
        if (game == GAME_CAB)
        {   serialize1(&man.level[0][7]); // ----  /$119      /----      /----
        } else
        {   man.level[0][7] = 0;
    }   }
    offset = offsets[8][game];
    serialize1(&man.sex);             // $ A0      /$11A      /$ BA      /$ 5C
    offset = offsets[9][game];
    serialize1(&man.alignment);       // $ A2      /$11C      /$ BB      /$ 5D
    offset = offsets[13][game];
    serialize1(&man.damage1);         // $ A5      /$11F      /$ BE      /$ AD
    offset++;                         // $ A6      /$120      /$ BF      /$ AE
    serialize1(&man.damage2);         // $ A7      /$121      /$ C0      /$ AF
    offset = offsets[10][game];
    serialize4(&man.xp);              // $ AE..$ B1/$128..$12B/$ C8..$ CB/$ 44..$ 47
    offset = offsets[11][game];
    serialize1(&man.status);          // $10E      /$19A      /$143      /$ 5E
    offset = offsets[14][game];
    serialize1(&man.curhp);           // $11D      /$1A9      /$152      /$191
}

EXPORT void por_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  GAME_POR: gamesave("#?.cha", "Pool of Radiance"           , saveas, gamesize, FLAG_C, FALSE);
    acase GAME_CAB: gamesave("#?.guy", "Curse of the Azure Bonds"   , saveas, gamesize, FLAG_C, FALSE);
    acase GAME_SSB: gamesave("#?.who", "Secret of the Silver Blades", saveas, gamesize, FLAG_C, FALSE);
    acase GAME_POD: gamesave("#?.pc" , "Pools of Darkness"          , saveas, gamesize, FLAG_C, FALSE);
}   }

EXPORT void por_exit(void)
{   ch_clearlist(&SexList);
    lb_clearlist(&SpellsList3);
}
EXPORT void por_die(void)
{   lb_clearlist(&SpellsList1);
    lb_clearlist(&SpellsList2);
}

EXPORT void por_close(void) { ; }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int          i;
    struct List* ListPtr;
    struct Node* NodePtr;

    if (gadmode == SERIALIZE_READ)
    {   i = 0;
        for
        (   NodePtr = SpellsList1.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   DISCARD GetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (ULONG*) &man.spellbook[i]);
            i++;
    }   }
    else
    {   // assert(gadmode == SERIALIZE_WRITE);

        either_ch(GID_POR_CH6, &game);

        DISCARD GetAttr(CHOOSER_Labels, (Object*) gadgets[GID_POR_CH3], (ULONG*) &ListPtr);
        // assert(ListPtr->lh_Head->ln_Succ); // the list is non-empty
        // walk the list
        i = 0;
        for
        (   NodePtr = (struct Node*) ListPtr->lh_Head;
            NodePtr->ln_Succ;
            NodePtr = (struct Node*) NodePtr->ln_Succ
        )
        {   if (race_gad_to_file[game][i] == -1)
            {   SetChooserNodeAttrs
                (   NodePtr,
                    CNA_ReadOnly, TRUE,
                    CNA_Disabled, TRUE,
                TAG_DONE);
            } else
            {   SetChooserNodeAttrs
                (   NodePtr,
                    CNA_ReadOnly, FALSE,
                    CNA_Disabled, FALSE,
                TAG_DONE);
            }
            i++;
        }

        DISCARD SetGadgetAttrs(gadgets[GID_POR_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, ~0,                   TAG_END);
        i = 0;
        for
        (   NodePtr = SpellsList1.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   if (spellinfo[i].byte[game] == -1)
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, LBFLG_READONLY | LBFLG_CUSTOMPENS, TAG_END);
                DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 0, LBNCA_FGPen, whitepen, LBNA_Column, 1, LBNCA_FGPen, whitepen, TAG_END);
            } else
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, NULL, TAG_END);
            }
            DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (BOOL) man.spellbook[i], TAG_END);
            i++;
        }
        DISCARD SetGadgetAttrs(gadgets[GID_POR_LB1], MainWindowPtr, NULL, LISTBROWSER_Labels, (ULONG) &SpellsList1, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_POR_LB1], MainWindowPtr, NULL);

        DISCARD SetGadgetAttrs(gadgets[GID_POR_LB3], MainWindowPtr, NULL, LISTBROWSER_Labels, ~0,                   TAG_END);
        lb_clearlist(&SpellsList3);
        for (i = 0; i < memslots[game]; i++)
        {   if (man.spellmem[i] == -1)
            {   NodePtr = (struct Node*) AllocListBrowserNode
                (   2, // columns
                    LBNA_Column,   0,
                     LBNCA_Text,   "--",
                    LBNA_Column,   1,
                     LBNCA_Text,   "-",
                TAG_END);
            } else
            {   NodePtr = (struct Node*) AllocListBrowserNode
                (   2, // columns
                    LBNA_Column,   0,
                     LBNCA_Text,   spellinfo[man.spellmem[i]].code,
                    LBNA_Column,   1,
                     LBNCA_Text,   spellinfo[man.spellmem[i]].name,
                TAG_END);
            }
            // we should check NodePtr is non-zero
            AddTail(&SpellsList3, (struct Node*) NodePtr);
        }
        DISCARD SetGadgetAttrs(gadgets[GID_POR_LB3], MainWindowPtr, NULL, LISTBROWSER_Labels, (ULONG) &SpellsList3, LISTBROWSER_AutoFit, TRUE, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_POR_LB3], MainWindowPtr, NULL);

        ghost(GID_POR_IN20, (game == GAME_POR || game == GAME_CAB) ? FALSE : TRUE ); // current monk level
        ghost(GID_POR_IN21, (game == GAME_POD                    ) ? TRUE  : FALSE); // cp
        ghost(GID_POR_IN22, (game == GAME_POD                    ) ? TRUE  : FALSE); // sp
        ghost(GID_POR_IN23, (game == GAME_POD                    ) ? TRUE  : FALSE); // ep
        ghost(GID_POR_IN24, (game == GAME_POD                    ) ? TRUE  : FALSE); // gp
        for (i = 0; i < 7; i++)
        {   ghost(GID_POR_IN30 + i, (game == GAME_POR            ) ? TRUE  : FALSE); // former       levels
        }
        ghost(GID_POR_IN37, (game == GAME_CAB                    ) ? FALSE : TRUE ); // former  monk level
    }

    either_st(GID_POR_ST1,   man.name     );

    either_ch(GID_POR_CH1,  &man.sex      );
    either_ch(GID_POR_CH2,  &man.alignment);
    either_ch(GID_POR_CH3,  &man.race     );
    either_ch(GID_POR_CH4,  &man.theclass );
    either_ch(GID_POR_CH5,  &man.status   );

    either_in(GID_POR_IN1,  &man.age      );
    either_in(GID_POR_IN2,  &man.movement );
    either_in(GID_POR_IN3,  &man.curhp    );
    either_in(GID_POR_IN4,  &man.maxhp    );
    either_in(GID_POR_IN5,  &man.xp       );
    either_in(GID_POR_IN6,  &man.str      );
    either_in(GID_POR_IN7,  &man.excstr   );
    either_in(GID_POR_IN8,  &man.iq       );
    either_in(GID_POR_IN9,  &man.wis      );
    either_in(GID_POR_IN10, &man.dex      );
    either_in(GID_POR_IN11, &man.con      );
    either_in(GID_POR_IN12, &man.cha      );
    for (i = 0; i < 8; i++)
    {   either_in(GID_POR_IN13 + i, &man.level[1][i]);
        either_in(GID_POR_IN30 + i, &man.level[0][i]);
    }
    either_in(GID_POR_IN21, &man.cp       );
    either_in(GID_POR_IN22, &man.sp       );
    either_in(GID_POR_IN23, &man.ep       );
    either_in(GID_POR_IN24, &man.gp       );
    either_in(GID_POR_IN25, &man.pp       );
    either_in(GID_POR_IN26, &man.gems     );
    either_in(GID_POR_IN27, &man.jewels   );
    either_in(GID_POR_IN28, &man.damage1  );
    either_in(GID_POR_IN29, &man.damage2  );
}

MODULE void maximize_man(void)
{   int i;

    man.excstr    =
    man.status    =           0;
    man.damage1   =
    man.damage2   =          20;
    man.str       =
    man.iq        =
    man.wis       =
    man.dex       =
    man.con       =
    man.cha       =          25;
    for (i = 0; i < 7; i++)
    {   man.level[0][i] =     0;
        man.level[1][i] =    50;
    }
    if (game == GAME_POR || game == GAME_CAB)
    {   man.level[0][7] =     0;
        man.level[1][7] =    50;
    }
    man.curhp     =
    man.maxhp     =
    man.movement  =         250;
    if (game != GAME_POD)
    {   man.cp    =
        man.sp    =
        man.ep    =
        man.gp    =       60000;
    }
    man.pp        =
    man.gems      =
    man.jewels    =       60000;
    man.xp        = TWO_BILLION;
    for (i = 0; i < SPELLS; i++)
    {   if (spellinfo[i].byte[game] != -1)
        {   man.spellbook[i] = 1;
}   }   }

MODULE void spellwindow(void)
{   int          i;
    struct Node* NodePtr;

    i = 0;
    for
    (   NodePtr = SpellsList2.lh_Head;
        NodePtr->ln_Succ;
        NodePtr = NodePtr->ln_Succ
    )
    {   if (i == 0)
        {   i++;
            continue;
        } // implied else

        if (spellinfo[i - 1].byte[game] == -1)
        {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, LBFLG_READONLY | LBFLG_CUSTOMPENS, TAG_END);
            DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 0, LBNCA_FGPen, whitepen, LBNA_Column, 1, LBNCA_FGPen, whitepen, TAG_END);
        } else
        {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, NULL, TAG_END);
        }
        i++;
    }

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              "Choose Spell",
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "por-1",
        WINDOW_ParentGroup,                    gadgets[GID_POR_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_POR_LB2] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_POR_LB2,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_ColumnInfo,        (ULONG) &ColumnInfo2,
                LISTBROWSER_Labels,            (ULONG) &SpellsList2,
                LISTBROWSER_AutoFit,           TRUE,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
             // LISTBROWSER_AutoWheel,         FALSE, // commented out to work around a bug in OS3.2
            ListBrowserEnd,
            CHILD_MinWidth,                    320,
            CHILD_MinHeight,                   480,
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

    setpointer(FALSE, SubWinObject, SubWindowPtr, TRUE);

    DISCARD SetGadgetAttrs(         gadgets[GID_POR_LB2], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man.spellmem[whichslot] + 1, TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_POR_LB2], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man.spellmem[whichslot] + 1, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_POR_LB2], SubWindowPtr, NULL);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG por_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_POR_LB2:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_POR_LB2], (ULONG*) &man.spellmem[whichslot]);
        man.spellmem[whichslot]--;
        writegadgets(); // this is overkill

        return TRUE;
    }

    return FALSE;
}

EXPORT FLAG por_subkey(UWORD code, UWORD qual)
{   SLONG old,
          temp,
          vold;

    switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        temp = man.spellmem[whichslot] + 1;
        lb_move_up(  GID_POR_LB2, SubWindowPtr, qual, (ULONG*) &temp, 0,      5);
        temp--;
        old  = temp;
        while (temp >= 0      && spellinfo[temp].byte[game] == -1)
        {   temp--;
        }
        man.spellmem[whichslot] = temp;

        if (man.spellmem[whichslot] != old)
        {   DISCARD SetGadgetAttrs(         gadgets[GID_POR_LB2], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man.spellmem[whichslot] + 1, TAG_END);
            DISCARD SetGadgetAttrs(         gadgets[GID_POR_LB2], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man.spellmem[whichslot] + 1, TAG_END);
            RefreshGadgets((struct Gadget*) gadgets[GID_POR_LB2], SubWindowPtr, NULL);
        }
        writegadgets(); // this is overkill
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        vold = man.spellmem[whichslot];
        temp = man.spellmem[whichslot] + 1;
        lb_move_down(GID_POR_LB2, SubWindowPtr, qual, (ULONG*) &temp, SPELLS, 5);
        temp--;
        old  = temp;
        while (temp < SPELLS && spellinfo[temp].byte[game] == -1)
        {   temp++;
        }
        if (temp < SPELLS)
        {   man.spellmem[whichslot] = temp;
        } else
        {   man.spellmem[whichslot] = vold;
        }

        if (man.spellmem[whichslot] != old)
        {   DISCARD SetGadgetAttrs(         gadgets[GID_POR_LB2], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man.spellmem[whichslot] + 1, TAG_END);
            DISCARD SetGadgetAttrs(         gadgets[GID_POR_LB2], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man.spellmem[whichslot] + 1, TAG_END);
            RefreshGadgets((struct Gadget*) gadgets[GID_POR_LB2], SubWindowPtr, NULL);
        }
        writegadgets(); // this is overkill
    }

    return FALSE;
}

EXPORT void por_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey)
{   switch (scancode)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        if (mouseisover(GID_POR_LB3, mousex, mousey))
        {   lb_scroll_up(GID_POR_LB3, MainWindowPtr, qual);
        } else
        {   lb_scroll_up(GID_POR_LB1, MainWindowPtr, qual);
        }
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        if (mouseisover(GID_POR_LB3, mousex, mousey))
        {   lb_scroll_down(GID_POR_LB3, MainWindowPtr, qual);
        } else
        {   lb_scroll_down(GID_POR_LB1, MainWindowPtr, qual);
}   }   }

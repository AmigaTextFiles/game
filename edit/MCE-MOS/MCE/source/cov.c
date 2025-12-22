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
#define GID_COV_LY1   0 /* root layout */
#define GID_COV_ST1   1 // name
#define GID_COV_IN1   2
#define GID_COV_IN2   3
#define GID_COV_IN3   4
#define GID_COV_IN4   5
#define GID_COV_IN5   6
#define GID_COV_IN6   7
#define GID_COV_IN7   8
#define GID_COV_IN8   9
#define GID_COV_IN9  10
#define GID_COV_IN10 11
#define GID_COV_IN11 12
#define GID_COV_IN12 13
#define GID_COV_IN13 14
#define GID_COV_IN14 15
#define GID_COV_CH1  16
#define GID_COV_BU1  17 // 1st item
#define GID_COV_BU9  25 // 9th item
#define GID_COV_BU10 26 // maximize character
#define GID_COV_BU11 27 // 1st power
#define GID_COV_BU19 35 // 9th power
#define GID_COV_BU20 36 // maximize party
#define GID_COV_IN15 37 // x
#define GID_COV_IN16 38 // y
#define GID_COV_CH3  39 // z
#define GID_COV_IN18 40 // # of items
#define GID_COV_IN19 41 // # of powers
#define GID_COV_CH2  42 // facing
#define GID_COV_SB1  43
#define GID_COV_SP1  44 // map
#define GID_COV_ST2  45 // contents
#define GID_COV_IN17 46 // e
#define GID_COV_IN20 47 // n

// items/spells subwindow
#define GID_COV_LY2  48
#define GID_COV_LB1  49

#define GIDS_COV     GID_COV_LB1

#define ItemButton(x)  LAYOUT_AddChild, gadgets[GID_COV_BU1  + x] = (struct Gadget*) ZButtonObject, GA_ID, GID_COV_BU1  + x, GA_RelVerify, TRUE, GA_Text, ItemNames[man[who].item[x]],   BUTTON_Justification, BCJ_LEFT, ButtonEnd
#define SpellButton(x) LAYOUT_AddChild, gadgets[GID_COV_BU11 + x] = (struct Gadget*) ZButtonObject, GA_ID, GID_COV_BU11 + x, GA_RelVerify, TRUE, GA_Text, SpellNames[man[who].spell[x]], BUTTON_Justification, BCJ_LEFT, ButtonEnd

#define SCALEX       12
#define SCALEY       12
#define SCALEDWIDTH  ((20 * SCALEX) + 1)
#define SCALEDHEIGHT ((20 * SCALEY) + 1)

//      MAZEBLACK       0
//      MAZEWHITE       1
#define GREEN           2
#define RED             3
#define BLUE            4
#define LIGHTCYAN       5
#define ORANGE          6
#define LIGHTPURPLE     7

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void readman(int whichman);
MODULE void writeman(int whichman);
MODULE void serialize(void);
MODULE void itemwindow(void);
MODULE void spellwindow(void);
MODULE void maximize_man(int whichman);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            loaded,
                            n1, n2,
                            page,
                            scalex,
                            scaley,
                            serializemode,
                            xoffset,
                            yoffset;
IMPORT LONG                 pens[PENS];
IMPORT ULONG                offset,
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
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT UBYTE*               byteptr1[MAXHEIGHT];
IMPORT __aligned UBYTE      display1[GFXINIT(MAXWIDTH, MAXHEIGHT)];
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

MODULE UWORD                compass,
                            light,
                            xray;
MODULE ULONG                facing,
                            location_n,
                            location_x,
                            location_y,
                            location_z,
                            men,
                            who;
MODULE int                  submode,
                            whichitem,
                            whichspell;
MODULE struct List          FacingList,
                            ItemsList,
                            RacesList,
                            SpellsList;
MODULE const STRPTR         RaceOptions[6] =
{ "Jedi Knight",
  "Arcturian",
  "Ant Warrior",
  "Denk Mentat",
  "Lamian Elfin",
  "Sirian Lizard",
}, FacingOptions[4] =
{ "North",
  "East",
  "South",
  "West"
}, ItemNames[0x34 + 1] =
{ "SpaceSuit",         // $00
  "Silver Amulet",     // $01
  "Medi-Kit",          // $02
  "Flashlight",        // $03
  "Compass",           // $04
  "Carbal Cloak",      // $05
  "Staff",             // $06
  "Needle Gun",        // $07
  "Sonic Screwdriver", // $08
  "Gyrocompass",       // $09
  "Diamond Saw",       // $0A
  "Ever Glow",         // $0B
  "Plasma Axe",        // $0C
  "Stun Beam",         // $0D
  "Repellor Belt",     // $0E
  "Weird Gadget",      // $0F
  "Mind Shield",       // $10
  "Arc Shield",        // $11
  "Force Shield",      // $12
  "Shimmer Field",     // $13
  "Atomic Laser",      // $14
  "Blaster",           // $15
  "Neuronic Whip",     // $16
  "Sonic Lance",       // $17
  "Mind Probe",        // $18
  "Nuclear Disruptor", // $19
  "Light Sabre",       // $1A
  "VoltBolt",          // $1B
  "Death Ray",         // $1C
  "Giant Hammer",      // $1D
  "Laser Crystal",     // $1E
  "Gold Plate",        // $1F
  "Platinum Bar",      // $20
  "Rhodium Ingot",     // $21
  "Uranium Rod",       // $22
  "Plutonium Rod",     // $23
  "Shatter Ray",       // $24
  "Phase Blur",        // $25
  "Nothing Cloak",     // $26
  "Flame Projector",   // $27
  "Energy Crystal",    // $28
  "Healing Crystal",   // $29
  "Heat Shield",       // $2A
  "Tangle Field",      // $2B
  "Antidote",          // $2C
  "Power Cell",        // $2D
  "Molecular Key",     // $2E
  "Blue Diamond",      // $2F
  "Disintegrator",     // $30
  "Death Ray",         // $31 (again!)
  "Floppy Disk",       // $32
  "Sonic Key",         // $33
  "-"                  // $34+
// it's not used in a chooser gadget so it doesn't need a final NULL
}, SpellNames[0x32 + 1] = {
  "Panic Fear",              // $00 J
  "Freeze Foes",             // $01 J
  "Invisibility",            // $02 J
  "Levitation (Jedi)",       // $03 J
  "Healing 4 (Jedi)",        // $04 J
  "Glance of Death",         // $05 J
  "Gut Wrench",              // $06 J
  "Resurrection (Jedi)",     // $07 J
  "Psychic Shield",          // $08 J
  "Pulverize",               // $09  A
  "ESP (Arcturian)",         // $0A  A
  "Levitation (Arcturian)",  // $0B  A
  "Brain Wash",              // $0C  A
  "Suicidal Gloom",          // $0D  A
  "-",                       // $0E  A
  "-",                       // $0F  A
  "-",                       // $10  A
  "-",                       // $11  A
  "Poison Strike",           // $12   W
  "Blindness (Ant Warrior)", // $13   W
  "Location (Ant Warrior)",  // $14   W
  "Paralysis",               // $15   W
  "Sting of Horb",           // $16   W
  "-",                       // $17   W
  "-",                       // $18   W
  "-",                       // $19   W
  "-",                       // $1A   W
  "Illusions",               // $1B    D
  "Mind Mash",               // $1C    D
  "Sleep",                   // $1D    D
  "Location (Denk)",         // $1E    D
  "Madness",                 // $1F    D
  "Mind Blast",              // $20    D
  "ESP (Denk)",              // $21    D
  "Levitation (Denk)",       // $22    D
  "Brain Block",             // $23    D
  "Healing 1",               // $24     L
  "Healing 2",               // $25     L
  "Healing 3",               // $26     L
  "Healing 4 (Lamian)",      // $27     L
  "Resurrection (Lamian)",   // $28     L
  "Suspend Breath",          // $29     L
  "Energy Drain",            // $2A     L
  "Heal All",                // $2B     L
  "Blindness (Lamian)",      // $2C     L
  "Nerve Pulse",             // $2D      S
  "Inner Fire",              // $2E      S
  "Lightning",               // $2F      S
  "Location (Sirian)",       // $30      S
  "Electrocution",           // $31      S
  "Shock Treatment"          // $32      S
// it's not used in a chooser gadget so it doesn't need a final NULL
};

MODULE const STRPTR LevelOptions[8 + 1] =
{ "1: on Nigris, at ground level",
  "2: on Nigris, 1 level down",
  "3: on Nigris, 2 levels down",
  "4: on Vras, 1 level down",
  "5: on Vras, 2 levels down",
  "6: in the Citadel, 1 level up",
  "7: in the Citadel, 2 levels up",
  "8: in the Citadel, 3 levels up",
  NULL
};

#define SPECIALS 123
MODULE struct
{   int    x, y, z;
    STRPTR desc;
} specials[SPECIALS] = {
{ 10, 4,1, "Sign"                                },
{  4, 5,1, "3 Wurglepups"                        },
{  5, 5,1, "Blaster"                             },
{ 14, 7,1, "Bureau of Advancement"               },
{ 15, 9,1, "Ladder down to X15,Y9,L2"            },
{ 10,10,1, "Nigris Spaceport"                    },
{  6,13,1, "Spacefarer's Store"                  },
{ 10,15,1, "Matter Transmitter Portal"           },
{  6,19,1, "Destination of ladder from 5,19,2"   },
{ 18,19,1, "Matter transmitter destination #1"   },
{  4, 1,2, "Message"                             },
{ 18, 3,2, "Matter transmitter destination #3"   },
{ 11, 8,2, "Ladder down to X18,Y4,L3"            },
{ 15, 9,2, "Destination of ladder from 15,9,1"   },
{  5,11,2, "Remains, Light Sabre"                },
{  5,19,2, "Ladder up to X6,Y19,L1"              },
{  1, 1,3, "Matter transmitter destination #5"   },
{  4, 3,3, "Magazine clipping"                   },
{ 18, 4,3, "Destination of ladder from 11,8,2"   },
{ 14, 5,3, "Matter transmitter destination #4"   },
{  5, 7,3, "Gaping hole opened by 6,7,3"         },
{  6, 7,3, "Gaping hole trigger"                 },
{ 11,10,3, "Old man"                             },
{ 10,11,3, "30 Fungoids, Force Shield"           },
{ 11,11,3, "24 Wurglepups, Neuronic Whip"        },
{ 15,13,3, "Matter transmitter destination #2"   },
{ 13,14,3, "Gaping hole opened by 13,15,3"       },
{ 13,15,3, "Gaping hole trigger"                 },
{  9,16,3, "1 Moonbeast"                         },
{ 11,17,3, "Smell"                               },
{ 18,17,3, "Scrap of paper"                      },
{  1,19,3, "Matter Transmitter Portal"           },
{ 13, 4,4, "Dalek factory"                       },
{ 12, 6,4, "Matter Transmitter Portal"           },
{  7, 8,4, "Old hermit"                          },
{ 15,14,4, "Power Cell"                          },
{ 17,14,4, "Power Cell"                          },
{  8,15,4, "Power Cell"                          },
{  2,18,4, "Power Cell"                          },
{ 19,20,4, "Ladder down to X19,Y20,L5 (south only)"},
{  1, 1,5, "Strange device"                      },
{  2, 2,5, "Gaping hole trigger"                 },
{  3, 2,5, "Gaping hole trigger"                 },
{  4, 2,5, "Gaping hole trigger"                 },
{  5, 2,5, "Gaping hole trigger"                 },
{ 17, 2,5, "Power Cell"                          },
{  2, 3,5, "Gaping hole trigger"                 },
{  3, 3,5, "Gaping hole trigger"                 },
{  4, 3,5, "Gaping hole trigger"                 },
{  5, 3,5, "Gaping hole trigger"                 },
{  8, 3,5, "Power Cell"                          },
{  2, 4,5, "Gaping hole trigger"                 },
{  3, 4,5, "Gaping hole trigger"                 },
{  4, 4,5, "Gaping hole trigger"                 },
{  5, 4,5, "Gaping hole trigger"                 },
{ 11, 4,5, "11 Leucomorphs"                      },
{ 11, 5,5, "VoltBolt"                            },
{  5, 7,5, "Power Cell"                          },
{ 10, 9,5, "Magazine clipping"                   },
{ 10,10,5, "Power Cell"                          },
{ 15,10,5, "Power Cell"                          },
{  6,11,5, "Matter Transmitter Portal"           },
{  2,16,5, "Scrap of paper"                      },
{  6,17,5, "Power Cell"                          },
{ 16,17,5, "Power Cell"                          },
{  1,20,5, "Power Cell"                          },
{ 20,20,5, "Ladder up to X20,Y20,L4"             },
{  1, 1,6, "Ladder up to X1,Y1,L6 (east only)"   },
{  5, 1,6, "Floppy Disk"                         },
{ 15, 1,6, "Scrap of paper"                      },
{ 18, 1,6, "Interdimensional twist to X10,Y12,L6"},
{ 15, 2,6, "1 Shambleau"                         },
{  3, 3,6, "Destination of twist from X4,Y3,L6"  },
{  4, 3,6, "Interdimensional twist to X3,Y3,L6"  },
{  3, 7,6, "5th coordinate"                      },
{  4, 4,6, "1 Shambleau"                         },
{  3, 9,6, "4th coordinate"                      },
{  1, 9,6, "Energy Crystal"                      },
{  8, 9,6, "Message"                             },
{  1,10,6, "1 Shambleau"                         },
{ 10,10,6, "Message"                             },
{  3,11,6, "3rd coordinate"                      },
{  5,12,6, "1 Shambleau"                         },
{ 10,12,6, "Destination of twist from 18,1,6"    },
{  3,13,6, "2nd coordinate"                      },
{  5,13,6, "Heat Shield"                         },
{ 10,14,6, "Matter Transmitter Portal"           },
{ 11,14,6, "Computer"                            },
{  3,15,6, "1st coordinate"                      },
{  8,15,6, "Energy Crystal"                      },
{ 14,15,6, "Message"                             },
{  8,16,6, "1 Shambleau"                         },
{ 18,18,6, "1 Shambleau"                         },
{ 18,19,6, "Energy Crystal"                      },
{  6,20,6, "Matter Transmitter Portal"           },
{  1, 1,7, "Ladder down to X1,Y1,L6 (west only)" },
{  2, 1,7, "Destination of twist and ladder"     }, // twist from X10,Y11,L7 and ladder from X6,Y5,L8
{  9, 2,7, "Blue Diamond (north only)"           },
{  9, 3,7, "1 Dark Jedi (north only)"            },
{ 10, 5,7, "Sign"                                },
{ 11, 6,7, "Interdimensional twist to X10,Y10,L6"},
{ 12, 9,7, "Scrap of paper (south only)"         },
{ 10,10,7, "1 Demon of Fear (south only?)"       },
{ 17,17,7, "Sarkov"                              },
{ 16,10,7, "Energy Crystal (west only)"          },
{ 17,10,7, "5 Galactic Grues (west only)"        },
{ 10,11,7, "Interdimensional twist to X2,Y1,L7"  },
{  3,14,7, "Scrap of paper (east only)"          },
{  9,15,7, "Interdimensional twist to X2,Y16,L7" },
{  2,16,7, "Destination of twist from X9,Y15,L7" },
{ 14,17,7, "Scrap of paper"                      },
{ 20, 2,8, "Interdimensional twist to X18,Y18,L8"},
{  8, 3,8, "Message"                             },
{ 17, 3,8, "Interdimensional twist to X9,Y7,L8"  },
{  6, 5,8, "Ladder down to 2,1,7"                },
{ 16, 6,8, "Game won"                            },
{  9, 7,8, "Destination of twist from X17,Y3,L8" },
{ 18, 8,8, "Shrine"                              },
{ 10,11,8, "Speaking door"                       },
{ 15,14,8, "Interdimensional twist to X11,Y9,L6" },
{ 10,16,8, "Scrap of paper"                      },
{ 15,17,8, "1 Demon of Power"                    },
{ 18,18,8, "Destination of twist from X20,Y2,L8" },
};

MODULE const UBYTE cov_map[8][41][41 + 1] = { {
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+", // Level 1
"|                                       |",
"+ +-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+=+ +",
"| |         =   |       | | | =     | | |",
"+ +=+-+-+-+ +-+ + +-+-+ + + + + +-+ + + +",
"| |       | | | | |   | | | | | | | | | |",
"+ +-+-+-+=+ + + + +=+ + + + + + +=+ + + +",
"| |       | | | | |#| | | | | | | | | | |",
"+ +-+=+-+-+ + + + +-+ + + + + + + + + + +",
"| = |  # #| | = |     | | | | | |   | | |",
"+ + +-+-+-+=+-+ +-+-+-+ + + + + +-+-+ + +",
"| |         | |         | |   |       | |",
"+ +-+-+-+-+-+=+-+-+-+-+-+=+-+ +-+-+-+-+ +",
"|           =             = | |     | | |",
"+ +-+-+-+-+-+ +-+-+-+-+-+ +-+ + + +-+ + +",
"| |     =   | |         | |   | |     | |",
"+ +-+-+ +-+ + +         + + +-+ +-+-+=+ +",
"| |   | | | | |         | | |D=     | | |",
"+ +   + + + + +   +=+   + + +-+-+ +-+ + +",
"| =   | |   | |   =#=   | |       | | | |",
"+ +-+-+ + +-+ +   +=+   + +-+-+-+ + +-+ +",
"| |     | | | |         | |   = |   | | |",
"+ +-+=+ + + + +         + +   + +-+ + + +",
"| |   | |   | |         | |   |       | |",
"+ +   + +=+-+ +-+-+-+-+-+ +-+-+-+-+-+-+ +",
"| =   | | |#=             =             |",
"+ +-+-+ + +-+=+-+-+-+-+-+=+-+-+-+=+-+-+ +",
"| |     |   | |   |   | | | = | | |   | |",
"+ +-+-+ +-+ + + + +-+ + +-+ + +=+ +-+ + +",
"| |   | | | | | | |#| |     | | | |   | |",
"+ +   + + + + + + +-+ + + +-+ + + + +-+ +",
"| =   | |   | | | | | | | |   | | |   | |",
"+ +-+-+ + +-+ +-+=+=+=+-+ +-+ + + +-+ + +",
"| |     |   | =           | | = | |   | |",
"+ +-+-+ +-+ + +-+=+=+=+-+ +=+ + + + +-+ +",
"| |   | |   | | | | | | | |   | | |   | |",
"+ +   + + +-+ + + + + + + + +-+ + +-+ + +",
"| =   | | =#| | | | | |   | | | | |#= | |",
"+ +-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+ +-+-+ +",
"|                                       |",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+",
}, {
"+-+-+-+-+-+-+-+-+-+-+-+-+-+=+   + +=+-+-+", // Level 2
"|   =  #| = = |   |   |     |   | |     |",
"+   +-+-+ + +-+ + + + + +-+-+-+-+ + +-+-+",
"|   |   | | = | | | | | |   |   | |     |",
"+-+-+   + +-+=+ + + + + +   + + + +-+-+=+",
"| | |   | |   | | | | | |   | | | |#= | |",
"+ + +=+=+=+   + + + + + +=+ + + + +-+ + +",
"| | | |   |   = |   |   | | | | | |   | |",
"+ + + +   +   +-+-+-+-+-+-+=+ + + +=+-+ +",
"| | | |   |   | = = = | = = | | | |   | |",
"+ + + +-+-+-+=+=+=+=+=+-+-+ + + + +   + +",
"| | |       | | = | | | = | | | | |   | |",
"+ + +-+-+-+ +-+=+=+-+-+-+=+ + + + +-+=+ +",
"| | |     = | | | = = = = | | | | |   | |",
"+ + +     +-+=+-+=+-+-+-+=+ + + + + +=+ +",
"| | |       | = = | =D| = | | | | | | | |",
"+ + +-+     +=+-+=+-+-+-+=+ + + + +=+-+ +",
"| | = |     | | | = = | = | |#| | |   | |",
"+ +-+ +     +-+ +-+=+-+-+-+ + + + +   + +",
"| | = |       =   | =     |   | | |   | |",
"+ + +-+ +-+   +-+-+ +     +-+-+ + +-+=+ +",
"| | = | =#|   |   | |     |   |   |   | |",
"+ +-+ + + +   + + + +     +=+ +-+-+ +=+ +",
"| | = | | |   | | | |     = | |   | | | |",
"+ + +-+ + +   + + + +-+-+-+-+ + + +=+-+ +",
"| | = |       | | |         | | | |   | |",
"+ +-+ +       + + +-+-+-+-+ + + + +   + +",
"| | = |       | |           | | | |   | |",
"+ +=+-+       +=+-+-+-+-+-+-+ + + +-+=+ +",
"| |   |       |   =   |   = | | | |   | |",
"+ +   +-+-+-+=+   +   +   + + + + +   + +",
"| =   =       |   |   =   | | | | |   = |",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+=+ + + +-+-+-+",
"                |   =   |   | | | |      ",
"+-+-+-+-+-+-+-+ +   +   +   + + + + +-+-+",
"|     |   =   | |   |   =   | | | | |   |",
"+=+=+=+ +-+   + +=+-+-+-+-+-+ + + +=+=+=+",
"| | | | =U|   |   |       = | | | |   | |",
"+=+=+=+=+-+-+=+-+-+       + + + + +-+-+=+",
"| | | =   |   =   =       | | | | |   = |",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+=+ + + +=+-+-+",
}, {
"+-+-+-+-+ + +=+-+-+-+-+-+-+-+-+-+-+-+-+-+", // Level 3
"|#|     | | |       | | =   | = = = = = |",
"+ +     + + + +-+-+ + + +   +=+-+-+-+-+-+",
"| |     | | | |     |   |   |           |",
"+ +     + + +-+=+-+-+-+=+   + +-+-+-+-+ +",
"| |    #| | |   | | =   |   | |       | |",
"+ +=+-+-+ + +=+-+-+-+   +=+-+ +   +-+ + +",
"| | =   | | |   =   =   |   | |   =#| = |",
"+ +-+-+ + + + + +-+-+   +   + +   +-+ + +",
"| |   | | | | | |   =   |  #| |       | |",
"+ + +=+ + + +-+-+-+-+-+-+-+-+ +-+-+-+-+ +",
"| | | | | |                 |           |",
"+ +=+ +=+=+-+-+-+-+-+-+-+-+ +           +",
"|   |   |# #  |       =   | |           |",
"+-+-+-+-+-+-+ + +-+-+-+   + +=+-+-+-+-+-+",
"            | | |     =   | |            ",
"+-+-+-+-+-+ + + + +-+-+-+=+ +-+-+-+-+-+-+",
"            | | | |     | | |            ",
"+-+-+-+-+-+-+ + + + +-+ + + + +-+-+-+-+-+",
"            | | | | =#| | | |            ",
"+-+-+-+-+-+ + + + +=+ + + + +-+-+-+-+-+-+",
"            | | | |# #| | | |            ",
"+-+-+-+-+-+-+ + + +-+=+ + + + +-+-+-+-+-+",
"            | | |     | | | |            ",
"+-+-+-+=+-+-+ + +-+-+-+ + + +-+-+-+-+-+-+",
"|     | |   = |         | | |#= = = = = |",
"+ +-+ + +-+-+=+-+-+-+-+-+=+ +=+=+-+=+-+-+",
"|   | | |   |   | = | = |#| | = = = | = |",
"+ + + +=+ + +   + + + + + + +=+-+=+=+=+=+",
"| | | = | | |   | | = | =#| | = = | | | |",
"+ + +-+-+ + +-+=+ +-+-+-+-+ +=+=+-+=+=+=+",
"| |   | | | |   |#  |       | | | | = | |",
"+ + + + + + +   +   + +-+-+-+=+=+=+-+-+=+",
"|   | | | | |   |   =#| = | = | | |#| | |",
"+-+-+ +=+ + +=+-+-+-+-+ + +=+-+=+=+=+=+=+",
"|   |   | | |         = | | = = | = = | |",
"+-+ +-+ + + +-+-+-+-+-+-+ +=+-+-+-+=+=+=+",
"|#| |   | | |   |   | = | | | = = = = | |",
"+ + + + + + + + + + + + + +=+-+=+-+=+=+ +",
"| |   | | | | |   |   |   | = = | = = | |",
"+-+-+-+-+ + +=+-+-+-+-+-+-+-+-+-+-+-+-+-+",
}, {
"+ +-+-+-+-+-+=+=+-+ + + +   +-+-+-+-+-+ +", // Level 4
"| | =     =   |   | | | |   |           |",
"+ +-+=+-+-+   +   + +-+ +   + +-+-+-+-+-+",
"| | |     |   |   | |   |   | | |       |",
"+ +=+-+-+=+   +-+=+ + +-+   + +=+=+-+-+ +",
"| |   | = |   |   | | | |   | | |     | |",
"+ +-+ + +-+   +   + + + +   + +=+-+-+=+ +",
"| | | |   |   |   = |   =#  | | | = | | |",
"+ +=+ +-+ +   +-+-+ +-+-+-+-+ +=+=+=+ + +",
"| |       |       = |         | = | = | |",
"+ +-+-+-+-+-+-+-+-+=+ +-+-+-+$+-+-+-+-+=+",
"|         $         | |#|     |         |",
"+-+-+-+-+ +-+-+-+-+=+ + +=+-+-+ +-+-+-+-+",
"= | =   | |       | | | |     | |   |   =",
"+ + +-+=+ + +-+   + + +$+-+-+=+ +   +   +",
"| |   | | | |#|   = | | =     | |   =   |",
"+ +-+=+ + + +=+   + + + +-+-+-+ +-+=+-+-+",
"| |   | | |       | | | | =   | =   = = |",
"+ + + + + +-+-+-+-+-+ + + +   + +   + +=+",
"|   | | |             |   |   = =   | | |",
"+-+-+-+-+-+-+-+-+-+   +-+-+-+-+-+-+-+-+-+",
"|   |   | = =     |             |   |   |",
"+ + + + + + +-+-+ + +-+-+-+-+-+ + + + + +",
"| | | | | | |   | | |         | | | | | |",
"+ + + + + + + + + + + +-+-+-+=+ + + + + +",
"| | | | | | | | | | | |       | | | | | |",
"+ + + + + + + + + + + +=+-+-+=+ + + + + +",
"  | | | | | | | | | | | =   |#| |#|   |  ",
"+=+ + + + + + +=+=+ + +-+-+-+-+ +-+-+-+-+",
"| |   |   | = |#| | | |       $         |",
"+=+-+-+-+-+$+-+-+-+ +=+-+-+-+-+-+-+-+-+ +",
"|         |         |   =   |   |     | |",
"+ +-+-+-+ + +-+-+-+-+ +-+-+-+-+=+=+=+-+ +",
"|       | | |   = | | | |   =   | |   | |",
"+ +-+-+ + + +   +-+ + + +   +-+ + +-+=+ +",
"| |#  = | | |   |   |   |   | = | = | | |",
"+ +-+-+ + + +=+-+-+ +-+ +   + +=+ + + + +",
"|         | | |   | | | |   | | | | | | |",
"+ +-+-+-+-+ + +   + + + +   + +-+=+-+=+ +",
"|           | |   | |   |   | =   = |D| |",
"+ +-+-+-+-+-+=+=+-+ + +-+   +-+-+-+-+-+ +",
}, {
"+-+-+-+-+-+-+ + +   +   + + +-+-+ +   +-+", // Level 5
"|#=         | | |   |   | |       |   | |",
"+-+         + + +-+-+ + + + + +-+-+   + +",
"|  # # # #  | |       | |   |    #|     |",
"+           + + + +-+-+ +   +   + +-+-+-+",
"|  # # # #  |  #|           |   |       |",
"+           +-+-+   +=+-+-+ +   +-+-+ +-+",
"|  # # # #  |       |#|         |   |   |",
"+           + +-+-+ + + + +-+   + + +-+-+",
"|           |       |#| |         |     |",
"+-+-+-+-+-+-+   + +-+-+ +   +-+-+ + + + +",
"|       |       |       |       | | | | |",
"+-+-+-+ + +-+-+ +   +   +-+-+ + + + + + +",
"|       |#  |   |   |     |   | |   |   |",
"+   + +-+-+-+-+-+-+ + +-+ +   + + +-+ +-+",
"    | |           | | | |     |   | |    ",
"+-+ + + +=+-+-+-+ + + + +-+ +-+-+-+ + +  ",
"    | | |       | |#  |   |     |   | |  ",
"+ +-+-+ + +-+-+ + +-+-+   +-+ +-+   + + +",
"|     | | |   |   |#  |     |#|     | | |",
"+-+ + + + +=+ + + + + + +-+ +-+ +-+ + + +",
"|   | | | |#| | | | | | | |     | | |   |",
"+ + +-+ + + + + + +-+ + + +-+ +-+ + +-+-+",
"  | | | | | | | | | | | |   | |   | |    ",
"+ + + + + +-+=+ + + + + +   +=+ + + + +-+",
"| |   | |       | |   | |       | | |   |",
"+ + +-+ +-+-+-+-+ +-+ + + +     + + +-+-+",
"|     |           |   | | |     | | |   |",
"+-+ + +-+-+-+-+-+$+ + +-+ + +-+-+ +-+   +",
"    |       |       |     |       |      ",
"    +-+-+ + + +-+-+ +   + +-+-+ + + + +-+",
"   #|   | |         |   |       | | |    ",
"+-+-+ + + + +-+-+ + +   + +-+-+ + + +-+-+",
"|     | | |#      |     |      #|   |   |",
"+ +   + + +-+-+   +-+-+ + + + +-+-+-+ +-+",
"  |   |                   | |            ",
"  + + + +-+-+ +-+-+ + +-+-+ + +   +-+-+  ",
"  | |               |       | |          ",
"+ + +-+-+ +-+-+ +   + +   + + + +-+-+ +=+",
"|#| |           |   | |   |   |       |U|",
"+-+-+-+-+-+-+   +   + +   + +-+-+     +-+",
}, {
"+-+   + +-+=+ + + + + +   + +-+   +-+-+-+", // Level 6
"=U|   | |#| | | | | | |   | |#|   |#=   =",
"+-+=+-+ + + + + + + +-+=+-+ + +   +-+ + +",
"|   |   | | | | | | |   |   |#|   |   | |",
"+   + +-+=+ + + + + +   + +-+=+   + +-+ +",
"|   |#|#| | | | | | |   | |   =   | |   |",
"+=+-+ + + + + + + + +=+-+ +   + +-+ + +-+",
"  |   |#| | | | | | | |   |   | |   | |  ",
"  + +-+=+ + + + + +$+ + +-+-+-+ + +-+ +  ",
"  | |   | | | | | | | | |   =   | |   |  ",
"+-+ +   + +$+ + + + +=+=+   +-+-+ + +-+=+",
"|   |   | | | | | | | | |     |   | |   |",
"+ +-+-+ + + + + + + + + +-+   + +-+ +   +",
"| | |#= | | | | | | | |   |   | |   |   |",
"+ + +-+ + + + + + + + +-+ +-+-+ + +-+=+-+",
"  |     | | | | = | |   |   |   | |   |  ",
"+-+ +-+ + + + +-+-+$+-+ +-+ + +-+ +   + +",
"| | =#| | | | =#|     |   | | |   |   | |",
"+ + +-+ + + +-+-+ +=+ +-+ + + + +-+=+-+ +",
"| |     | | |   = =#= = | | $ | |   |   |",
"+=+ +-+ + + +   + +=+ + + +-+-+ +   + +-+",
"  | |#= |   |   |     | |   |   |   | |  ",
"  + +-+ +=+-+=+-+-+=+-+ +-+ +=+-+=+-+ +  ",
"  |     |#|   | = |#  |   |   |   |   |  ",
"  + +-+ + +   + + +-+ +-+ +-+ +   + +-+  ",
"  | =#| |#|   | | | |   |   | |   | | |  ",
"  + +-+ +-+=+-+ + + +-+ +-+ +-+=+-+ + +  ",
"  |     |   |   | |#|#|   | |   |   | |  ",
"  + +-+ +   + +-+ +=+=+-+ +=+   + +-+ +  ",
"  | |#= |   | |#| | |   |  #|   | |   |  ",
"  + +-+-+=+-+ + + + +   +-+-+=+-+ +   +  ",
"  |   |   |   |#| | |     |   |   |   |  ",
"  +   +   + +-+=+$+$+     +   + +-+   +  ",
"  |   |   | |   | | |     |   | |     |  ",
"+-+$+-+=+-+ + + + + +-+=+-+=+-+ + +=+ +  ",
"    |   |   | | | | |   |   |   | |#| |  ",
"    +   + +-+ + + + +   +   + +-+ + + +=+",
"    |   | | | | | | |   |   | |   |#|    ",
"  +-+=+-+ + + + + + +=+-+=+-+ +   +-+    ",
"  |   |   |#| | | | | |   |   |          ",
"+-+   + +-+=+ + + + + +   + +-+   +-+-+-+",
}, {
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+", // Level 7
"|D=#    |                               |",
"+-+-+-+ + +-+-+-+-+-+-+-+-+-+-+-+-+-+-+ +",
"|       | |   = |#|   =   |   =   |   | |",
"+ +-+-+-+ +   + + +   +   +   +   +   + +",
"|       | |   | |#|   |   =   |   =   | |",
"+-+-+-+ + +   + +=+=+-+-+-+-+-+=+-+-+=+ +",
"|       | |   |       |   |   |   |   | |",
"+ +-+-+-+ +=+-+-+-+-+=+   +   +   +   + +",
"|       | | |   |  #| |   |   |   |   | |",
"+-+-+-+ + + +   +   + +=+$+-+=+-+-+=+-+ +",
"|       | | |   =   |#| | |   |   |   | |",
"+ +-+-+-+ +=+=+-+-+-+-+ + +   +   +   + +",
"|       | |   |         | |   |   =   | |",
"+-+-+-+ + +   + +-+-+-+-+ +=+-+-+-+-+=+ +",
"|       | |   | |       | | | =   |   | |",
"+ +-+-+-+ +=+-+ + +-+-+=+ + + +   +   + +",
"|       | |   | | |   |#| | | |   =   | |",
"+-+-+-+ + +   + + +=+ +-+ +=+ +-+-+   + +",
"=       | $   |   |#|     |   |# #=   | =",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ +",
"|     =   |   |    #|       =         | |",
"+     +-+ +   + +-+-+ +-+-+ + +-+-+-+ + +",
"|     | = |   | |   | |     | |       | |",
"+     + +-+   + + + + +-+-+-+ +-+-+-+-+ +",
"|     |   =   |   |         |           |",
"+=+-+-+-+-+   +-+-+ +-+-+ + +-+-+-+-+-+-+",
"| | =#| = |   |   |   | | | |           |",
"+ + +-+-+-+   + +$+ + + + + +$+-+-+-+-+ +",
"| | = | = |   | |#| | |   | |   $ $   | |",
"+ + +-+-+-+   + +-+ + +-+-+ + +-+-+-+ + +",
"| |#= | = |   |     | | |   | | $ $ | | |",
"+ + +-+-+-+   +-+-+-+ + + +-+$+$+=+$+$+ +",
"| | = | = |   | |       | |#| | |#| | | |",
"+ + +-+-+-+   + + + +-+-+ + +$+$+-+$+$+ +",
"| | = | = |   | | |     | | | | $ $ | | |",
"+ + +-+-+-+   + + +-+-+ +-+ + +-+-+-+ + +",
"| | =   = =   |   |         |   $ $   | |",
"+ +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ +",
"|           $             $             |",
"+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+",
}, {
"+-+ +     +     + +   +   + +   +-+     +", // Level 8
"|   |     |     | |   |   | |   | |     |",
"+ +-+-+=+-+-+=+-+ +-+=+=+-+ +-+=+ +-+=+-+",
"= |   | |   =     |   |         |   | |#=",
"+ + + + +-+-+ +-+-+   +-+-+ +-+-+-+ + +-+",
"| | | |   |   |#  =   |   | |    #| |   |",
"+ + + +-+ +=+ +-+-+   +   + +     + +-+ +",
"|   |   | | |     |   |   = |     |   | |",
"+ +-+-+ + + +-+-+ +-+=+-+-+ +-+=+-+-+ + +",
"| |   = | |D|   |     |   |     |   = | |",
"+-+   +-+=+-+   +-+-+-+   +-+-+-+   +-+=+",
"  =   =     =   =     =   |   =#|   =    ",
"+-+   +-+=+-+   +-+-+-+   + +-+-+   +-+=+",
"| |   |   | |   |#    =   | | | |   |   |",
"+ +-+-+ +-+ +-+-+-+-+-+-+-+$+-+-+=+-+ +-+",
"|     | |   |             | | | | $#| | |",
"+-+=+-+=+-+ + +-+-+-+-+-+ +$+-+-+ +-+=+-+",
"|   |     | | |         | | | | | |     |",
"+   +     + +$+ +-+-+-+ + +$+=+-+ +     +",
"|   |     | | | |     | | | |     |     |",
"+=+-+-+=+-+ +$+ + +-+ + + +$+ +-+-+-+=+-+",
"  =   | |   | | | |#= | | | | |     | |  ",
"  +   + + +-+$+ + + +-+ + +$+ +     + +  ",
"  |   | |   | | | |     | | | |     | |  ",
"+-+=+-+=+-+ +$+ + +-+-+-+ +$+ +-+=+-+=+-+",
"|   |     | | | |         | |   | |     |",
"+   +     + +$+ +-+-+-+-+-+ +=+ + +     +",
"|   |     | | |             |#| | |     |",
"+=+-+-+=+-+ +$+-+-+-+-+-+-+-+-+ + +-+=+-+",
"      | |   |                 | =   | |  ",
"+-+-+ + + +-+-+-+-+-+-+-+-+-+ +-+-+ + + +",
"|   = | | =   =   =#|   =   | |   | | | |",
"+   +-+=+-+   +-+-+-+   +-+-+=+   +-+=+-+",
"=   =     =   =     =   =   |#=   $     =",
"+   +-+=+-+   +-+-+-+   +-+-+-+   +-+=+-+",
"|   | | | |   |     |   |     |   |#| | |",
"+-+-+=+ + +-+-+ +=+ +-+-+ +=+ +-+-+=+ + +",
"      | |       | |       | |       | |  ",
"+ +-+-+=+-+-+-+-+ +-+-+-+-+ +-+-+ +-+ +-+",
"|   |     |     | |   |   | |   | |     |",
"+-+ +     +     + +   +   + +   +-+     +",
} };

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   TEXT   name[14 + 1];
    ULONG  curhp,
           maxhp,
           curpe,
           maxpe,
           slot,
           race,
           level,
           xp,
           gp,
           ws,
           iq,
           dex,
           con,
           luck;
    UWORD  equipped[9],
           item[9],
           items,
           spell[9],
           spells;
} man[14];

// 8. CODE ---------------------------------------------------------------

EXPORT void cov_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // cov_preinit()
        NewList(&FacingList);
        NewList(&ItemsList);
        NewList(&RacesList);
        NewList(&SpellsList);

        // cov_init()
        lb_makelist(&ItemsList,  ItemNames,  0x35); // elements are 0..$34
        lb_makelist(&SpellsList, SpellNames, 0x33); // elements are 0..$32
    }

    tool_open      = cov_open;
    tool_loop      = cov_loop;
    tool_save      = cov_save;
    tool_close     = cov_close;
    tool_exit      = cov_exit;
    tool_subgadget = cov_subgadget;

    if (loaded != FUNC_COV && !cov_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_COV;

    xoffset = yoffset = 0;
    scalex  = scaley  = 12;
    n1      = 4;
    n2      = 9;

    ch_load_images(1, 6, RaceOptions, &RacesList);
    make_speedbar_list(GID_COV_SB1);
    load_aiss_images(10, 10);
    ch_load_aiss_images(11, 14, FacingOptions, &FacingList);
    load_fimage(FUNC_COV);

    cov_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                         TRUE,
        WA_ThinSizeGadget,                                     TRUE,
        WINDOW_LockHeight,                                     TRUE,
        WINDOW_Position,                                       WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                    gadgets[GID_COV_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                 TRUE,
            LAYOUT_DeferLayout,                                TRUE,
            AddHLayout,
                AddToolbar(GID_COV_SB1),
                AddSpace,
                CHILD_WeightedWidth,                           50,
                AddVLayout,
                    AddSpace,
                    CHILD_WeightedHeight,                      50,
                    MaximizeButton(GID_COV_BU20, "Maximize Party"),
                    CHILD_WeightedHeight,                      0,
                    AddSpace,
                    CHILD_WeightedHeight,                      50,
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
                AddSpace,
                CHILD_WeightedWidth,                           50,
            LayoutEnd,
            AddHLayout,
                AddVLayout,
                    AddHLayout,
                        LAYOUT_VertAlignment,                  LALIGN_CENTER,
                        AddLabel("Character #:"),
                        LAYOUT_AddChild,                       gadgets[GID_COV_IN5] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                             GID_COV_IN5,
                            GA_RelVerify,                      TRUE,
                            GA_TabCycle,                       TRUE,
                            INTEGER_Minimum,                   1,
                            INTEGER_Maximum,                   men,
                            INTEGER_Number,                    who + 1,
                            INTEGER_MinVisible,                2 + 1,
                        IntegerEnd,
                        AddLabel("of"),
                        LAYOUT_AddChild,                       gadgets[GID_COV_IN6] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                             GID_COV_IN6,
                            GA_Disabled,                       TRUE,
                            INTEGER_Arrows,                    FALSE,
                            INTEGER_Minimum,                   0,
                            INTEGER_Maximum,                   14,
                            INTEGER_Number,                    men,
                            INTEGER_MinVisible,                2 + 1,
                        IntegerEnd,
                    LayoutEnd,
                    AddVLayout,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_Label,                          "Character",
                        AddHLayout,
                            AddVLayout,
                                AddLabel("Name:"),
                                AddLabel("Hit Points:"),
                                AddLabel("Psychic Energy:"),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_AddChild,               gadgets[GID_COV_ST1] = (struct Gadget*)
                                StringObject,
                                    GA_ID,                     GID_COV_ST1,
                                    GA_TabCycle,               TRUE,
                                    STRINGA_TextVal,           man[who].name,
                                    STRINGA_MaxChars,          14 + 1,
                                StringEnd,
                                AddHLayout,
                                    LAYOUT_AddChild,           gadgets[GID_COV_IN1] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_COV_IN1,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       9999,
                                        INTEGER_Number,        man[who].curhp,
                                        INTEGER_MinVisible,    4 + 1,
                                    IntegerEnd,
                                    LAYOUT_AddChild,           gadgets[GID_COV_IN2] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_COV_IN2,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       9999,
                                        INTEGER_Number,        man[who].maxhp,
                                        INTEGER_MinVisible,    4 + 1,
                                    IntegerEnd,
                                    Label("of"),
                                LayoutEnd,
                                CHILD_WeightedHeight,          0,
                                AddHLayout,
                                    LAYOUT_AddChild,           gadgets[GID_COV_IN3] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_COV_IN3,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       9999,
                                        INTEGER_Number,        man[who].curpe,
                                        INTEGER_MinVisible,    4 + 1,
                                    IntegerEnd,
                                    LAYOUT_AddChild,           gadgets[GID_COV_IN4] = (struct Gadget*)
                                    IntegerObject,
                                        GA_ID,                 GID_COV_IN4,
                                        GA_TabCycle,           TRUE,
                                        INTEGER_Minimum,       0,
                                        INTEGER_Maximum,       9999,
                                        INTEGER_Number,        man[who].maxpe,
                                        INTEGER_MinVisible,    4 + 1,
                                    IntegerEnd,
                                    Label("of"),
                                LayoutEnd,
                                CHILD_WeightedHeight,          0,
                            LayoutEnd,
                        LayoutEnd,
                        AddHLayout,
                            AddVLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                AddLabel("Race:"),
                            LayoutEnd,
                            CHILD_WeightedWidth,               50,
                            LAYOUT_AddChild,                   gadgets[GID_COV_CH1] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                         GID_COV_CH1,
                                CHOOSER_Labels,                &RacesList,
                                CHOOSER_Selected,              (WORD) man[who].race,
                            PopUpEnd,
                            CHILD_WeightedWidth,               50,
                        LayoutEnd,
                        AddHLayout,
                            AddVLayout,
                                AddLabel("Level:"),
                                AddLabel("Experience Points:"),
                                AddLabel("Credits:"),
                                AddLabel("Weapon Skill:"),
                                AddLabel("Intelligence:"),
                                AddLabel("Dexterity:"),
                                AddLabel("Constitution:"),
                                AddLabel("Luck:"),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_AddChild,               gadgets[GID_COV_IN7] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_COV_IN7,
                                    GA_Disabled,               TRUE,
                                 // GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            FALSE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            man[who].level,
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_COV_IN8] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_COV_IN8,
                                    GA_Disabled,               TRUE,
                                 // GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            FALSE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           2000000000,
                                    INTEGER_Number,            man[who].xp,
                                    INTEGER_MinVisible,        10 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_COV_IN9] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_COV_IN9,
                                    GA_Disabled,               TRUE,
                                 // GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            FALSE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           2000000000,
                                    INTEGER_Number,            man[who].gp,
                                    INTEGER_MinVisible,        10 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_COV_IN10] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_COV_IN10,
                                    GA_Disabled,               TRUE,
                                 // GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            FALSE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           9999,
                                    INTEGER_Number,            man[who].ws,
                                    INTEGER_MinVisible,        4 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_COV_IN11] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_COV_IN11,
                                 // GA_Disabled,               TRUE,
                                    GA_TabCycle,               TRUE,
                                 // INTEGER_Arrows,            FALSE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           9999,
                                    INTEGER_Number,            man[who].iq,
                                    INTEGER_MinVisible,        4 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_COV_IN12] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_COV_IN12,
                                 // GA_Disabled,               TRUE,
                                    GA_TabCycle,               TRUE,
                                 // INTEGER_Arrows,            FALSE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           9999,
                                    INTEGER_Number,            man[who].dex,
                                    INTEGER_MinVisible,        4 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_COV_IN13] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_COV_IN13,
                                    GA_Disabled,               TRUE,
                                 // GA_TabCycle,               TRUE,
                                    INTEGER_Arrows,            FALSE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           9999,
                                    INTEGER_Number,            man[who].con,
                                    INTEGER_MinVisible,        4 + 1,
                                IntegerEnd,
                                LAYOUT_AddChild,               gadgets[GID_COV_IN14] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_COV_IN14,
                                 // GA_Disabled,               TRUE,
                                    GA_TabCycle,               TRUE,
                                 // INTEGER_Arrows,            FALSE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           9999,
                                    INTEGER_Number,            man[who].luck,
                                    INTEGER_MinVisible,        4 + 1,
                                IntegerEnd,
                            LayoutEnd,
                        LayoutEnd,
                        AddHLayout,
                            AddVLayout,
                                LAYOUT_BevelStyle,             BVS_GROUP,
                                LAYOUT_SpaceOuter,             TRUE,
                                LAYOUT_Label,                  "Items",
                                LAYOUT_AddChild,               gadgets[GID_COV_IN18] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_COV_IN18,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           9,
                                    INTEGER_Number,            man[who].items,
                                    INTEGER_MinVisible,        1 + 1,
                                IntegerEnd,
                                Label("Number of items:"),
                                ItemButton(0),
                                ItemButton(1),
                                ItemButton(2),
                                ItemButton(3),
                                ItemButton(4),
                                ItemButton(5),
                                ItemButton(6),
                                ItemButton(7),
                                ItemButton(8),
                            LayoutEnd,
                            AddVLayout,
                                LAYOUT_BevelStyle,             BVS_GROUP,
                                LAYOUT_SpaceOuter,             TRUE,
                                LAYOUT_Label,                  "Powers",
                                LAYOUT_AddChild,               gadgets[GID_COV_IN19] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_COV_IN19,
                                    GA_RelVerify,              TRUE,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           9,
                                    INTEGER_Number,            man[who].spells,
                                    INTEGER_MinVisible,        1 + 1,
                                IntegerEnd,
                                Label("Number of powers:"),
                                SpellButton(0),
                                SpellButton(1),
                                SpellButton(2),
                                SpellButton(3),
                                SpellButton(4),
                                SpellButton(5),
                                SpellButton(6),
                                SpellButton(7),
                                SpellButton(8),
                            LayoutEnd,
                        LayoutEnd,
                        MaximizeButton(GID_COV_BU10, "Maximize Character"),
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,                         BVS_GROUP,
                    LAYOUT_SpaceOuter,                         TRUE,
                    LAYOUT_SpaceInner,                         TRUE,
                    LAYOUT_Label,                              "Location",
                    LAYOUT_VertAlignment,                      LALIGN_CENTER,
                    AddHLayout,
                        AddSpace,
                        LAYOUT_AddChild,                       gadgets[GID_COV_SP1] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                             GID_COV_SP1,
                            SPACE_MinWidth,                    SCALEDWIDTH,
                            SPACE_MinHeight,                   SCALEDHEIGHT,
                            SPACE_BevelStyle,                  BVS_FIELD,
                            SPACE_Transparent,                 TRUE,
                        SpaceEnd,
                        CHILD_WeightedWidth,                   0,
                        CHILD_WeightedHeight,                  0,
                        AddSpace,
                    LayoutEnd,
                    AddHLayout,
                        LAYOUT_AddChild,                       gadgets[GID_COV_IN15] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                             GID_COV_IN15,
                            GA_TabCycle,                       TRUE,
                            GA_RelVerify,                      TRUE,
                            INTEGER_Minimum,                   1,
                            INTEGER_Maximum,                   20,
                            INTEGER_Number,                    location_x + 1,
                            INTEGER_MinVisible,                2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                       gadgets[GID_COV_IN16] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                             GID_COV_IN16,
                            GA_TabCycle,                       TRUE,
                            GA_RelVerify,                      TRUE,
                            INTEGER_Minimum,                   1,
                            INTEGER_Maximum,                   20,
                            INTEGER_Number,                    location_y + 1,
                            INTEGER_MinVisible,                2 + 1,
                        IntegerEnd,
                        Label("Y:"),
                    LayoutEnd,
                    Label("X:"),
                    CHILD_WeightedHeight,                      0,
                    AddHLayout,
                        LAYOUT_AddChild,                       gadgets[GID_COV_IN17] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                             GID_COV_IN17,
                            GA_TabCycle,                       TRUE,
                            GA_RelVerify,                      TRUE,
                            INTEGER_Minimum,                   0,
                            INTEGER_Maximum,                   19,
                            INTEGER_Number,                    location_x,
                            INTEGER_MinVisible,                2 + 1,
                        IntegerEnd,
                        LAYOUT_AddChild,                       gadgets[GID_COV_IN20] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                             GID_COV_IN20,
                            GA_TabCycle,                       TRUE,
                            GA_RelVerify,                      TRUE,
                            INTEGER_Minimum,                   0,
                            INTEGER_Maximum,                   19,
                            INTEGER_Number,                    location_n,
                            INTEGER_MinVisible,                2 + 1,
                        IntegerEnd,
                        Label("N:"),
                    LayoutEnd,
                    Label("E:"),
                    CHILD_WeightedHeight,                      0,
                    LAYOUT_AddChild,                           gadgets[GID_COV_CH3] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_COV_CH3,
                        GA_RelVerify,                          TRUE,
                        CHOOSER_LabelArray,                    &LevelOptions,
                    PopUpEnd,
                    Label("Level:"),
                    CHILD_WeightedHeight,                      0,
                    LAYOUT_AddChild,                           gadgets[GID_COV_CH2] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_COV_CH2,
                        GA_RelVerify,                          TRUE,
                        CHOOSER_Labels,                        &FacingList,
                        CHOOSER_Selected,                      (WORD) facing,
                    PopUpEnd,
                    Label("Facing:"),
                    CHILD_WeightedHeight,                      0,
                    LAYOUT_AddChild,                           gadgets[GID_COV_ST2] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_COV_ST2,
                        GA_ReadOnly,                           TRUE,
                        STRINGA_TextVal,                       "-",
                        STRINGA_MaxChars,                      64 + 1,
                    StringEnd,
                    Label("Contents:"),
                    CHILD_WeightedHeight,                      0,
                    AddSpace,
                    AddHLayout,
                        AddSpace,
                        AddFImage(FUNC_COV),
                        CHILD_WeightedWidth,                   0,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedHeight,                      0,
                    AddSpace,
                LayoutEnd,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                     TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_COV_SB1);

    setup_bm(0, SCALEDWIDTH, SCALEDHEIGHT, MainWindowPtr);

    // cov_drawmap();
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_COV_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_COV_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void cov_loop(ULONG gid, UNUSED ULONG code)
{   int whichman;

    switch (gid)
    {
    case GID_COV_IN5:
    case GID_COV_IN18:
    case GID_COV_IN19:
        readgadgets();
        writegadgets();
    acase GID_COV_IN15:
        readgadgets();
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_COV_IN15], (ULONG*) &location_x);
        location_x--;
        writegadgets();
    acase GID_COV_IN16:
        readgadgets();
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_COV_IN16], (ULONG*) &location_y);
        location_y--;
        location_n = 19 - location_y;
        writegadgets();
    acase GID_COV_IN17:
        readgadgets();
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_COV_IN17], (ULONG*) &location_x);
        writegadgets();
    acase GID_COV_IN20:
        readgadgets();
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_COV_IN20], (ULONG*) &location_n);
        location_y = 19 - location_n;
        writegadgets();
    acase GID_COV_BU10:
        readgadgets();
        maximize_man(who);
        writegadgets();
    acase GID_COV_BU20:
        readgadgets();
        for (whichman = 0; whichman < (int) men; whichman++)
        {   maximize_man(whichman);
        }
        writegadgets();
    acase GID_COV_CH2:
        readgadgets();
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_COV_CH2], (ULONG*) &facing);
        cov_drawmap();
    acase GID_COV_CH3:
        readgadgets();
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_COV_CH3], &location_z);
        cov_drawmap();
    adefault:
        if     (gid >= GID_COV_BU1  && gid <= GID_COV_BU9 )
        {   whichitem  = gid - GID_COV_BU1;
            itemwindow();
        } elif (gid >= GID_COV_BU11 && gid <= GID_COV_BU19)
        {   whichspell = gid - GID_COV_BU11;
            spellwindow();
}   }   }

EXPORT FLAG cov_open(FLAG loadas)
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
    (   function != FUNC_COV
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    writeman(who);

    DISCARD SetGadgetAttrs
    (   gadgets[GID_COV_IN5], MainWindowPtr, NULL,
        INTEGER_Maximum, men,
        INTEGER_Number,  who + 1,
    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_COV_IN6], MainWindowPtr, NULL,
        INTEGER_Number, men,
    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_COV_IN15], MainWindowPtr, NULL,
        INTEGER_Number, location_x + 1,
    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_COV_IN16], MainWindowPtr, NULL,
        INTEGER_Number, location_y + 1,
    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_COV_IN17], MainWindowPtr, NULL,
        INTEGER_Number, location_x,
    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_COV_IN20], MainWindowPtr, NULL,
        INTEGER_Number, location_n,
    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_COV_CH3], MainWindowPtr, NULL,
        CHOOSER_Selected, (WORD) location_z,
    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_COV_CH2], MainWindowPtr, NULL,
        CHOOSER_Selected, (WORD) facing,
    TAG_END); // autorefreshes

    cov_drawmap();
}

MODULE void readgadgets(void)
{   DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN6],  (ULONG*) &men           );

    readman(who);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN5],  (ULONG*) &who           );
    who--;
    writeman(who);
}

MODULE void readman(int whichman)
{   ULONG  temp;
    STRPTR stringptr;

    DISCARD GetAttr(STRINGA_TextVal,  (Object*) gadgets[GID_COV_ST1 ], (ULONG*) &stringptr          );
    strcpy(man[whichman].name, stringptr);

    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN1 ], (ULONG*) &man[whichman].curhp);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN2 ], (ULONG*) &man[whichman].maxhp);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN3 ], (ULONG*) &man[whichman].curpe);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN4 ], (ULONG*) &man[whichman].maxpe);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN7 ], (ULONG*) &man[whichman].level);
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN8 ], (ULONG*) &man[whichman].xp   );
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN9 ], (ULONG*) &man[whichman].gp   );
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN10], (ULONG*) &man[whichman].ws   );
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN11], (ULONG*) &man[whichman].iq   );
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN12], (ULONG*) &man[whichman].dex  );
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN13], (ULONG*) &man[whichman].con  );
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN14], (ULONG*) &man[whichman].luck );
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN18], (ULONG*) &temp          );
    man[whichman].items  = (UWORD) temp;
    DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_COV_IN19], (ULONG*) &temp          );
    man[whichman].spells = (UWORD) temp;

    DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_COV_CH1 ], (ULONG*) &man[whichman].race );

    // we don't need to do anything for man[whichman].item[0..8] nor man[whichman].spells[0..8]
}

MODULE void writeman(int whichman)
{   int i;

    DISCARD SetGadgetAttrs(gadgets[GID_COV_ST1 ], MainWindowPtr, NULL, STRINGA_TextVal,         man[whichman].name,  TAG_END); // autorefreshes

    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN1 ], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].curhp, TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN2 ], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].maxhp, TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN3 ], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].curpe, TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN4 ], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].maxpe, TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN7 ], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].level, TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN8 ], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].xp,    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN9 ], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].gp,    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN10], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].ws,    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN11], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].iq,    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN12], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].dex,   TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN13], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].con,   TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_COV_IN14], MainWindowPtr, NULL, INTEGER_Number,          man[whichman].luck,  TAG_END); // autorefreshes

    DISCARD SetGadgetAttrs(gadgets[GID_COV_CH1 ], MainWindowPtr, NULL, CHOOSER_Selected, (WORD) man[whichman].race,  TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_COV_CH1], MainWindowPtr, NULL);

    // items
    DISCARD SetGadgetAttrs
    (   gadgets[GID_COV_IN18], MainWindowPtr, NULL,
        INTEGER_Number, (ULONG) man[whichman].items,
    TAG_END); // autorefreshes
    for (i = 0; i < 9; i++)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_COV_BU1 + i], MainWindowPtr, NULL,
            GA_Text, ItemNames[man[whichman].item[i]],
            GA_Disabled, (man[whichman].items <= i) ? TRUE : FALSE,
        TAG_END); // autorefreshes
    }

    // spells
    DISCARD SetGadgetAttrs
    (   gadgets[GID_COV_IN19], MainWindowPtr, NULL,
        INTEGER_Number, (ULONG) man[whichman].spells,
    TAG_END); // autorefreshes
    for (i = 0; i < 9; i++)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_COV_BU11 + i], MainWindowPtr, NULL,
            GA_Text, SpellNames[man[whichman].spell[i]],
            GA_Disabled, (man[whichman].spells <= i) ? TRUE : FALSE,
        TAG_END); // autorefreshes
}   }

MODULE void serialize(void)
{   int i, j;

// "offset is" assumes 5 characters in roster.
    offset = 0;
                              serialize4(&men);
                              offset += 4; // men in party
    for (i = 0; i < (int) men; i++) offset += 4; // party slot of man
// offset is  28  ($1C)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].race);
// offset is  48  ($30)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].level);
// offset is  68  ($44)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].ws);
// offset is  88  ($58)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].iq);
// offset is 108  ($6C)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].dex);
// offset is 128  ($80)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].con);
// offset is 148  ($94)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].luck);
// offset is 168  ($A8)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].curhp);
// offset is 188  ($BC)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].curpe);
// offset is 208  ($D0)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].maxhp);
// offset is 228  ($E4)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].maxpe);
// offset is 248  ($F8)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].gp);
// offset is 268 ($10C)
    for (i = 0; i < (int) men; i++) serialize4(&man[i].xp);
// offset is 288 ($120)
    for (i = 0; i < (int) men; i++) serialize2uword(&man[i].items);
// offset is 298 ($12A)
    for (i = 0; i < (int) men; i++) serialize2uword(&man[i].spells);
// offset is 308 ($134)
    for (i = 0; i < (int) men; i++)
    {   offset += 12;
    }
// offset is 368 ($170)
    for (i = 0; i < (int) men; i++)
    {   if (serializemode == SERIALIZE_READ)
        {   strcpy(man[i].name, (char*) &IOBuffer[offset]);
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            strcpy((char*) &IOBuffer[offset], man[i].name);
        }
        offset += 15;
    }
// offset is 443 ($1BB)
    for (i = 0; i < (int) men; i++) offset += 8; // "..hits.."
// offset is 483 ($1E3)
    offset += 4;
// offset is 487 ($1E7)
    for (i = 0; i < (int) men; i++) // each man's item/spell data is 60 bytes
    {   for (j = 0; j < 9; j++)
        {   serialize2uword(&man[i].item[j]);
            if (man[i].item[j] > 0x34)
            {   man[i].item[j] = 0x34;
        }   }

        offset += 22; // man[i].equipped[0..8]

        for (j = 0; j < 9; j++)
        {   serialize2uword(&man[i].spell[j]);
            if (serializemode == SERIALIZE_READ && man[i].spell[j] >= 0x32)
            {   man[i].spell[j] = 0x0E;
        }   }

        offset += 2;
    }

/* 1st character's 1st item  is at $1E7.
   1st character's 1st spell is at $20F (+40).
   2nd character's 1st item  is at $223 (+20).
   2nd character's 1st spell is at $24B (+40).
   3rd character's 1st item  is at $25F (+20).
   3rd character's 1st spell is at $287.
   4th character's 1st spell is at $2C3.
   5th character's 1st spell is at $2FF. */

// offset is 787 ($313)
    offset += 210;
// offset is  997 ($3E5)
                              serialize4(&location_z);
// offset is 1001 ($3E9)
                              serialize4(&location_x);
// offset is 1005 ($3ED)
                              serialize4(&location_y);
    location_n = 19 - location_y;
// offset is 1009 ($3F1)
    if (serializemode == SERIALIZE_WRITE)
    {   facing++;
    }
                              serialize4(&facing);
    facing--; // must do this always
// offset is 1013 ($3F5)
    offset +=  8;
// offset is 1021 ($3FD)
                              serialize2uword(&light);
// offset is 1023 ($3FF)
                              serialize2uword(&compass);
// offset is 1025 ($401)
                              serialize2uword(&xray);
// offset is 1027 ($403)
    // offset += 28;
    // now at end of file
// offset is 1055 ($41F)
}

EXPORT void cov_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?savedgame#?", "Citadel of Vras", saveas, (ULONG) (280 + (155 * men)), FLAG_S, FALSE);
}

MODULE void itemwindow(void)
{   ULONG temp;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Choose Item",
        WA_IDCMP,                              IDCMP_RAWKEY,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "cov-1",
        WINDOW_ParentGroup,                    gadgets[GID_COV_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_AddChild,                   gadgets[GID_COV_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_COV_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &ItemsList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    192,
            CHILD_MinHeight,                   512 - 72,
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

    DISCARD SetGadgetAttrs(gadgets[GID_COV_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man[who].item[whichitem], TAG_END);
    DISCARD SetGadgetAttrs(gadgets[GID_COV_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man[who].item[whichitem], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_COV_LB1], SubWindowPtr, NULL);

    submode = 0;
    subloop();

    DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_COV_LB1], (ULONG*) &temp);
    man[who].item[whichitem] = (UWORD) temp;

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE void spellwindow(void)
{   ULONG temp;

    lockscreen();
    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Choose Power",
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "cov-2",
        WINDOW_ParentGroup,                    gadgets[GID_COV_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_COV_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_COV_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &SpellsList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
            ListBrowserEnd,
            CHILD_MinWidth,                    192,
            CHILD_MinHeight,                   512 - 64,
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

    DISCARD SetGadgetAttrs(gadgets[GID_COV_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,              ~0,                         TAG_END);
    DISCARD SetGadgetAttrs(gadgets[GID_COV_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,              &SpellsList,                TAG_END);
    DISCARD SetGadgetAttrs(gadgets[GID_COV_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man[who].spell[whichspell], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_COV_LB1], SubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(gadgets[GID_COV_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man[who].spell[whichspell], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_COV_LB1], SubWindowPtr, NULL);

    submode = 1;
    subloop();

    DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_COV_LB1], (ULONG*) &temp);
    man[who].spell[whichspell] = (UWORD) temp;

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT void cov_die(void)
{   lb_clearlist(&ItemsList);
    lb_clearlist(&SpellsList);
}

EXPORT void cov_exit(void)
{   ch_clearlist(&FacingList);
    ch_clearlist(&RacesList);
}

EXPORT void cov_close(void) { ; }

MODULE void maximize_man(int whichman)
{
 /* man[whichman].ws       =
    man[whichman].con      =   9000;
    man[whichman].gp       =
    man[whichman].xp       = 900000;
    man[whichman].level    =     90; */

    man[whichman].iq       =
    man[whichman].dex      =
    man[whichman].luck     =
    man[whichman].curhp    =
    man[whichman].maxhp    =
    man[whichman].curpe    =
    man[whichman].maxpe    =   9000;

    man[whichman].items    =      9;
    man[whichman].item[0]  =   0x09; // Gyrocompass
    man[whichman].item[1]  =   0x0B; // Ever Glow
    man[whichman].item[2]  =   0x0F; // Weird Gadget
    man[whichman].item[3]  =   0x2E; // Molecular Key
    man[whichman].item[4]  =   0x2F; // Blue Diamond
    man[whichman].item[5]  =   0x26; // Nothing Cloak
    man[whichman].item[6]  =   0x29; // Healing Crystal
    man[whichman].item[7]  =   0x30; // Disintegrator
    man[whichman].item[8]  =   0x33; // Sonic Key
    man[whichman].spells   =      9;
    man[whichman].spell[0] =   0x03; // Levitation    (Jedi)
    man[whichman].spell[1] =   0x06; // Gut Wrench    (Jedi)
    man[whichman].spell[2] =   0x1E; // Location      (Denk)
    man[whichman].spell[3] =   0x20; // Mind Blast    (Denk)
    man[whichman].spell[4] =   0x21; // ESP           (Denk)
    man[whichman].spell[5] =   0x28; // Resurrection  (Lamer)
    man[whichman].spell[6] =   0x2B; // Heal All      (Lamer)
    man[whichman].spell[7] =   0x2C; // Blindness     (Lamer)
    man[whichman].spell[8] =   0x31; // Electrocution (Sirian)
}

EXPORT FLAG cov_subkey(UWORD code, UWORD qual)
{   ULONG temp;

    switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        if (submode == 0)
        {   temp = (ULONG) man[who].item[whichitem];
            lb_move_up(GID_COV_LB1, SubWindowPtr, qual, &temp, 0, 5);
            man[who].item[whichitem] = (UWORD) temp;
        } else
        {   // assert(submode == 1);
            temp = (ULONG) man[who].spell[whichspell];
            lb_move_up(GID_COV_LB1, SubWindowPtr, qual, &temp, 0, 5);
            man[who].spell[whichspell] = (UWORD) temp;
        }
        writegadgets(); // this is overkill
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        if (submode == 0)
        {   temp = (ULONG) man[who].item[whichitem];
            lb_move_down(GID_COV_LB1, SubWindowPtr, qual, &temp, 0x34, 5);
            man[who].item[whichitem] = (UWORD) temp;
        } else
        {   // assert(submode == 1);
            temp = (ULONG) man[who].spell[whichspell];
            lb_move_down(GID_COV_LB1, SubWindowPtr, qual, &temp, 0x32, 5);
            man[who].spell[whichspell] = (UWORD) temp;
        }
        writegadgets(); // this is overkill
    }

    return FALSE;
}

EXPORT FLAG cov_subgadget(ULONG gid, UNUSED UWORD code)
{   ULONG temp;

    switch (gid)
    {
    case GID_COV_LB1:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_COV_LB1], (ULONG*) &temp);
        if (submode == 0)
        {   man[who].item[whichitem] = (UWORD) temp;
        } else
        {   // assert(submode == 1);
            man[who].spell[whichspell] = (UWORD) temp;
        }
        writeman(who);
        return TRUE;
    }

    return FALSE;
}

EXPORT void cov_drawmap(void)
{   int  bgc,
         i,
         x, y;
    FLAG ok;

    if (location_z <= 2)
    {   bgc = LIGHTCYAN;
    } elif (location_z <= 4)
    {   bgc = ORANGE;
    } else
    {   bgc = LIGHTPURPLE;
    }

    for (y = 0; y < SCALEDHEIGHT; y++)
    {   for (x = 0; x < SCALEDWIDTH; x++)
        {   *(byteptr1[y] + x) = pens[bgc];
    }   }

    for (y = 0; y < 20; y++)
    {   for (x = 0; x < 20; x++)
        {   switch (    cov_map[location_z][(y * 2) + 1][(x * 2) + 1])
            {
            case  '#': drawsquare(  x, y,    BLUE);
            acase 'U': drawtriangle(x, y, 0, 0);
            acase 'D': drawtriangle(x, y, 2, 0);
            acase ' ': ;
            adefault : drawsquare(  x, y,    MAZEWHITE); // should never happen
    }   }   }

    for (y = 0; y < 21; y++)
    {   for (x = 0; x < 21; x++)
        {   *(byteptr1[y * SCALEY] + (x * SCALEX)) = pens[MAZEBLACK];
    }   }

    for (y = 0; y < 21; y++)
    {   for (x = 0; x < 21; x++)
        {   if (x < 20)
            {   switch (cov_map[location_z][ y * 2     ][(x * 2) + 1])
                {
                case  '-': drawhoriz(x, y, MAZEBLACK, 19, FALSE);
                acase '=': drawhoriz(x, y, GREEN,     19, TRUE);
                acase '$': drawhoriz(x, y, RED,       19, TRUE);
                acase ' ': ;
                adefault : drawhoriz(x, y, BLUE,      19, FALSE); // should never happen
            }   }

            if (y < 20)
            {   switch (cov_map[location_z][(y * 2) + 1][ x * 2     ])
                {
                case  '|': drawvert( x, y, MAZEBLACK, 19, FALSE);
                acase '=': drawvert( x, y, GREEN,     19, TRUE);
                acase '$': drawvert( x, y, RED,       19, TRUE);
                acase ' ': ;
                adefault : drawvert( x, y, BLUE,      19, FALSE); // should never happen
    }   }   }   }

    drawarrow(location_x, location_y, facing);

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_COV_SP1]->LeftEdge,
        gadgets[GID_COV_SP1]->TopEdge,
        gadgets[GID_COV_SP1]->LeftEdge + SCALEDWIDTH  - 1,
        gadgets[GID_COV_SP1]->TopEdge  + SCALEDHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );

    ok = FALSE;
    for (i = 0; i < SPECIALS; i++)
    {   if
        (   specials[i].x - 1 == (int) location_x
         && specials[i].y - 1 == (int) location_y
         && specials[i].z - 1 == (int) location_z
        )
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_COV_ST2],
                MainWindowPtr, NULL,
                STRINGA_TextVal, specials[i].desc,
            TAG_END);
            ok = TRUE;
            break; // for speed
    }   }
    if (!ok)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_COV_ST2],
            MainWindowPtr, NULL,
            STRINGA_TextVal, "Empty",
        TAG_END);
}   }

EXPORT void cov_getpens(void)
{   lockscreen();

    pens[MAZEBLACK      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0x00000000, -1); // 0
    pens[MAZEWHITE      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1); // 1
    pens[    GREEN      ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xFFFFFFFF, 0x00000000, -1); // 2
    pens[    RED        ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1); // 3
    pens[    BLUE       ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x88888888, 0x88888888, 0xFFFFFFFF, -1); // 4
    pens[    LIGHTCYAN  ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xAAAAAAAA, 0xFFFFFFFF, 0xFFFFFFFF, -1); // 5 (Nigris)
    pens[    ORANGE     ] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xAAAAAAAA, 0x88888888, -1); // 6 (Vras)
    pens[    LIGHTPURPLE] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xBBBBBBBB, 0xFFFFFFFF, -1); // 7 (Citadel)
    
    unlockscreen();
}

EXPORT void cov_uniconify(void)
{   cov_getpens();
    cov_drawmap();
}

EXPORT void cov_lmb(SWORD mousex, SWORD mousey)
{   if (!mouseisover(GID_COV_SP1, mousex, mousey))
    {   return;
    }

    readgadgets(); // important!

    location_x = (mousex - gadgets[GID_COV_SP1]->LeftEdge) / SCALEX;
    if (location_x > 19) // this can happen
    {   location_x = 19;
    }
    location_y = (mousey - gadgets[GID_COV_SP1]->TopEdge ) / SCALEY;
    if (location_y > 19) // this can happen
    {   location_y = 19;
    }

    location_n = 19 - location_y;
    writegadgets();
}

EXPORT void cov_key(UBYTE scancode, UWORD qual)
{   switch (scancode)
    {
    case SCAN_LEFT:
    case SCAN_N4:
        readgadgets(); map_leftorup(   qual, 20, (int*) &location_x, 0, NULL);
    acase SCAN_RIGHT:
    case SCAN_N6:
        readgadgets(); map_rightordown(qual, 20, (int*) &location_x, 0, NULL);
    acase SCAN_UP:
    case SCAN_N8:
    case NM_WHEEL_UP:
        readgadgets(); map_leftorup(   qual, 20, (int*) &location_y, 0, NULL);
    acase SCAN_DOWN:
    case SCAN_N5:
    case SCAN_N2:
    case NM_WHEEL_DOWN:
        readgadgets(); map_rightordown(qual, 20, (int*) &location_y, 0, NULL);
    acase SCAN_N1:
        readgadgets();
        map_leftorup(   qual, 20, (int*) &location_x, 0, NULL);
        map_rightordown(qual, 20, (int*) &location_y, 0, NULL);
    acase SCAN_N3:
        readgadgets();
        map_rightordown(qual, 20, (int*) &location_x, 0, NULL);
        map_rightordown(qual, 20, (int*) &location_y, 0, NULL);
    acase SCAN_N7:
        readgadgets();
        map_leftorup(   qual, 20, (int*) &location_x, 0, NULL);
        map_leftorup(   qual, 20, (int*) &location_y, 0, NULL);
    acase SCAN_N9:
        readgadgets();
        map_rightordown(qual, 20, (int*) &location_x, 0, NULL);
        map_leftorup(   qual, 20, (int*) &location_y, 0, NULL);
    adefault:
        return;
    }

    location_n = 19 - location_y;
    writegadgets();
}

EXPORT void cov_tick(SWORD mousex, SWORD mousey)
{   if (mouseisover(GID_COV_SP1, mousex, mousey))
    {   setpointer(TRUE , WinObject, MainWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
}   }

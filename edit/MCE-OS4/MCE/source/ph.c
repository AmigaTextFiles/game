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

/* 2. DEFINES ------------------------------------------------------------

main window */
#define GID_PH_LY1    0 // root layout
#define GID_PH_SB1    1 // toolbar
#define GID_PH_ST1    2 // name
#define GID_PH_BU2    3 // 1st equipment button
#define GID_PH_BU10  11 // 9th equipment button
#define GID_PH_CH1   12 // origin
#define GID_PH_CH2   13 // class
#define GID_PH_CH4   14 // status
#define GID_PH_CH5   15 // social
#define GID_PH_CB6   16 // purged
#define GID_PH_IN1   17 // gold
#define GID_PH_IN2   18 // cur hit points
#define GID_PH_IN3   19 // max hit points
#define GID_PH_IN4   20 // cur spell points
#define GID_PH_IN5   21 // max spell points
#define GID_PH_IN12  22 // age
#define GID_PH_IN20  23 // man
#define GID_PH_IN21  24 // level
#define GID_PH_IN22  25 // xp
#define GID_PH_IN24  26 // score
#define GID_PH_IN26  27 // party gold
#define GID_PH_IN27  28 // men
#define GID_PH_BU11  29 // maximize man
#define GID_PH_BU12  30 // maximize party
#define GID_PH_BU15  31 //  1st race
#define GID_PH_BU31  47 // 17th race
#define GID_PH_BU32  48 // more...
#define GID_PH_BU33  49 // party location...
#define GID_PH_BU34  50 // character location...

// items subwindow
#define GID_PH_LY2   51 // root layout
#define GID_PH_LB1   52 // items

// more subwindow
#define GID_PH_LY3   53 // root layout
#define GID_PH_BU1   54 // invert spells
#define GID_PH_BU13  55 // all
#define GID_PH_BU14  56 // none
#define GID_PH_LB2   57 // spells
#define GID_PH_CH7   58 // head
#define GID_PH_CH8   59 // left arm
#define GID_PH_CH9   60 // right arm
#define GID_PH_CH10  61 // torso
#define GID_PH_CH11  62 // left leg
#define GID_PH_CH12  63 // right leg
#define GID_PH_CH13  64 // game
#define GID_PH_CB1   65 // air
#define GID_PH_CB2   66 // earth
#define GID_PH_CB3   67 // fire
#define GID_PH_CB4   68 // water
#define GID_PH_CB5   69 // god
#define GID_PH_IN6   70 // str
#define GID_PH_IN7   71 // int
#define GID_PH_IN8   72 // dex
#define GID_PH_IN9   73 // con
#define GID_PH_IN10  74 // cha
#define GID_PH_IN11  75 // luk
#define GID_PH_IN13  76 // attack
#define GID_PH_IN14  77 // parry
#define GID_PH_IN15  78 // find item
#define GID_PH_IN16  79 // find trap
#define GID_PH_IN17  80 // disarm trap
#define GID_PH_IN18  81 // listen
#define GID_PH_IN19  82 // pick lock
#define GID_PH_IN23  83 // swim
#define GID_PH_IN25  84 // fire bow
#define GID_PH_IN30  85 // 3rd quest
#define GID_PH_CH14  86 // 1st quest
#define GID_PH_CH15  87 // 2nd quest

// map subwindow
#define GID_PH_LY4   88 // root layout
#define GID_PH_CH3   89 // party location
#define GID_PH_IN28  90 // X-location
#define GID_PH_IN29  91 // Y-location
#define GID_PH_SP1   92 // map
#define GID_PH_ST2   93 // contents

#define GIDS_PH      GID_PH_ST2

#define ItemButton(x) LAYOUT_AddChild, gadgets[GID_PH_BU2 + x] = (struct Gadget*) ZButtonObject, GA_ID, GID_PH_BU2 + x, GA_RelVerify, TRUE, BUTTON_Justification, LCJ_LEFT, ButtonEnd

#define LISTPOS_ACCURACY          0
#define LISTPOS_AWAKEN            1
#define LISTPOS_BINDING_1         2
#define LISTPOS_BINDING_2         3
#define LISTPOS_BINDING_3         4
#define LISTPOS_BINDING_4         5
#define LISTPOS_CHARM             6
#define LISTPOS_CONFUSION_1       7
#define LISTPOS_CONFUSION_2       8
#define LISTPOS_CONFUSION_3       9
#define LISTPOS_CONFUSION_4      10
#define LISTPOS_DISPEL_UNDEAD    11
#define LISTPOS_DISSOLVE         12
#define LISTPOS_DIVINE_AID       13
#define LISTPOS_FEAR             14
#define LISTPOS_FIREFLASH_1      15
#define LISTPOS_FIREFLASH_2      16
#define LISTPOS_FIREFLASH_3      17
#define LISTPOS_FIREFLASH_4      18
#define LISTPOS_FLAME_ARROW_1    19
#define LISTPOS_FLAME_ARROW_2    20
#define LISTPOS_FLAMEBOLT_1      21
#define LISTPOS_FLAMEBOLT_2      22
#define LISTPOS_FLAMEBOLT_3      23
#define LISTPOS_FLAMEBOLT_4      24
#define LISTPOS_HEALING_1        25
#define LISTPOS_HEALING_2        26
#define LISTPOS_HEALING_3        27
#define LISTPOS_HEALING_4        28
#define LISTPOS_MINDBLAST_1      29
#define LISTPOS_MINDBLAST_2      30
#define LISTPOS_MINDBLAST_3      31
#define LISTPOS_MINDBLAST_4      32
#define LISTPOS_MONSTER_EVALUATE 33
#define LISTPOS_NINJA_1          34
#define LISTPOS_NINJA_2          35
#define LISTPOS_P_FLAME_ARROW_1  36
#define LISTPOS_P_FLAME_ARROW_2  37
#define LISTPOS_PARTY_ACCURACY   38
#define LISTPOS_PROTECTION_1     39
#define LISTPOS_PROTECTION_2     40
#define LISTPOS_PROTECTION_3     41
#define LISTPOS_PROTECTION_4     42
#define LISTPOS_QUICKNESS_1      43
#define LISTPOS_QUICKNESS_2      44
#define LISTPOS_QUICKNESS_3      45
#define LISTPOS_QUICKNESS_4      46
#define LISTPOS_RESURRECTION     47
#define LISTPOS_SLEEP            48
#define LISTPOS_STRENGTH_1       49
#define LISTPOS_STRENGTH_2       50
#define LISTPOS_STRENGTH_3       51
#define LISTPOS_STRENGTH_4       52
#define LISTPOS_SUMMON_ELEMENTAL 53
#define LISTPOS_TELEPORTATION    54
#define LISTPOS_TRANSPORTATION   55
#define LISTPOS_VISION           56
#define LISTPOS_WEAKNESS_1       57
#define LISTPOS_WEAKNESS_2       58
#define LISTPOS_WEAKNESS_3       59
#define LISTPOS_WEAKNESS_4       60
#define TOTALSPELLS              61 // counting from 1

#define CITYPOS_ASMITH        0
#define CITYPOS_DARK          1
#define CITYPOS_DEATH         2
#define CITYPOS_DELTOR        3
#define CITYPOS_FLAGLER       4
#define CITYPOS_LANSING       5
#define CITYPOS_LIGHT         6
#define CITYPOS_PENDLETON     7
#define CITYPOS_PENDRAGON     8
#define CITYPOS_ROCKYHILLS    9
#define CITYPOS_SANDYSHORES  10
#define CITYPOS_SCANPORT     11
#define CITYPOS_SCIATTICA    12
#define CITYPOS_SIERION      13
#define CITYPOS_TIERRIN      14
#define CITYPOS_TIRITH       15
#define CITYPOS_XANADOR      16

#define TOTALITEMS          204 // counting from 1, not including "Nothing"

#define P1SPELLS             43 // counting from 1
#define P3SPELLS             56 // counting from 1

#define P1CLASSES             6
#define P3CLASSES             6
#define TOTALCLASSES          6

#define P1RACES              16
#define P3RACES              18 // includes "random"!
#define TOTALRACES           17

#define CHOOSERPOS_FIGHTER    0
#define CHOOSERPOS_MONK       1
#define CHOOSERPOS_PRIEST     2
#define CHOOSERPOS_RANGER     3
#define CHOOSERPOS_THIEF      4
#define CHOOSERPOS_WIZARD     5

#define CHOOSERPOS_DWARF      0
#define CHOOSERPOS_ELEMENTAL  1
#define CHOOSERPOS_ELF        2
#define CHOOSERPOS_GNOLL      3
#define CHOOSERPOS_GNOME      4
#define CHOOSERPOS_GOBLIN     5
#define CHOOSERPOS_HALFLING   6
#define CHOOSERPOS_HUMAN      7
#define CHOOSERPOS_KOBOLD     8
#define CHOOSERPOS_LIZARDMAN  9
#define CHOOSERPOS_MINOTAUR  10
#define CHOOSERPOS_OGRE      11
#define CHOOSERPOS_ORC       12
#define CHOOSERPOS_PIXIE     13
#define CHOOSERPOS_SPRITE    14
#define CHOOSERPOS_TROLL     15
#define CHOOSERPOS_UNDEAD    16

#define MAPSCALE              5
#define SCALEDWIDTH          (mapwidth  * MAPSCALE)
#define SCALEDHEIGHT         (mapheight * MAPSCALE)

#define RaceButton(x) AddVLayout,                                                                  \
                          LAYOUT_AddChild,             gadgets[GID_PH_BU15 + x] = (struct Gadget*) \
                          ZButtonObject,                                                           \
                              GA_ID,                   GID_PH_BU15 + x,                            \
                              GA_RelVerify,            TRUE,                                       \
                              GA_Image,                image[170 + x],                             \
                              BUTTON_PushButton,       TRUE,                                       \
                          ButtonEnd,                                                               \
                          AddHLayout,                                                              \
                              AddSpace,                                                            \
                              LAYOUT_AddImage,                                                     \
                              LabelObject,                                                         \
                                  LABEL_Text,          RaceOptions[x],                             \
                               /* LABEL_Justification, LJ_CENTRE, has no effect! */                \
                              LabelEnd,                                                            \
                              CHILD_WeightedWidth,     0,                                          \
                              AddSpace,                                                            \
                          LayoutEnd,                                                               \
                      LayoutEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void maximize_man(int whichman);
MODULE void condense(void);
MODULE void refreshitems(void);
MODULE void writespells(void);
MODULE void setlocation(SLONG x, SLONG y);
MODULE void itemwindow(void);
MODULE void morewindow(void);
MODULE void mapwindow(void);
MODULE void drawpoint(int x, int y, int colour);
MODULE STRPTR specialdesc(int x, int y);
MODULE void setpartylocation(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void readspells(void);

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
IMPORT LONG                 pens[PENS];
IMPORT ULONG                game,
                            offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct RastPort      wpa8rastport[2];
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

MODULE ULONG                men = 25,
                            partygold,
                            partylocation,
                            location_x,
                            location_y,
                            who = 0;
MODULE int                  mapwidth,
                            mapheight,
                            submode,
                            whichitem;
MODULE struct List          ItemsList,
                            SpellsList,
                            StatusList;

MODULE const STRPTR BodyOptions[4 + 1] =
{ "OK",
  "Injured",
  "Broken",
  "Gone",
  NULL
}, ClassOptions[6 + 1] =
{ "Fighter",
  "Monk",
  "Priest",
  "Ranger",
  "Thief",
  "Wizard",
  NULL
}, GameOptions[2 + 1] =
{ "Phantasie 1",
  "Phantasie 3",
  NULL
}, LocationOptions[2][17 + 1] = {
{ "Pelnor",     //  0
  "Pineville",  //  1
  "Greenville", //  2
  "Halflingor", //  3
  "Appleton",   //  4
  "Splitwater", //  5
  "Trollport",  //  6
  "Phantasia",  //  7
  "Dragonor",   //  8
  "Northford",  //  9
  "Starville",  // 10
  "Olympia",    // 11
  NULL
},
{ "Asmith",
  "Dark",
  "Death",
  "Deltor",
  "Flagler",
  "Lansing",
  "Light",
  "Pendleton",
  "Pendragon",
  "Rocky Hills",
  "Sandy Shores",
  "Scanport",
  "Sciattica",
  "Sierion",
  "Tierrin",
  "Tirith",
  "Xanador",
  NULL
} }, OriginOptions[6 + 1] =
{ "Gelnor",
  "Ferronrah",
  "Netherworld",
  "Scandor",
  "Light",
  "Darkness",
  NULL
}, RaceOptions[17] =
{ "Dwar",
  "Elem",
  "Elf",
  "Gnol",
  "Gnom",
  "Gobl",
  "Half",
  "Huma",
  "Kobo",
  "Liza",
  "Mino",
  "Ogre",
  "Orc",
  "Pixi",
  "Spri",
  "Trol",
  "Unde"
  // NULL is not needed
}, SocialOptions[6 + 1] =
{ "Peasant",
  "Labourer",
  "Craftsman",
  "Noble",
  "Darklord",
  "Superhero",
  NULL
}, SpellNames[61] =
{ "Accuracy",         //  0
  "Awaken",
  "Binding 1",
  "Binding 2",
  "Binding 3",
  "Binding 4",
  "Charm",
  "Confusion 1",
  "Confusion 2",
  "Confusion 3",
  "Confusion 4",      // 10
  "Dispel Undead",
  "Dissolve",
  "Divine Aid (\"#57\")",
  "Fear",
  "Fireflash 1",
  "Fireflash 2",
  "Fireflash 3",
  "Fireflash 4",
  "Flame Arrow 1",
  "Flame Arrow 2",    // 20
  "Flamebolt 1",
  "Flamebolt 2",
  "Flamebolt 3",
  "Flamebolt 4",
  "Healing 1",
  "Healing 2",
  "Healing 3",
  "Healing 4",
  "Mindblast 1",
  "Mindblast 2",      // 30
  "Mindblast 3",
  "Mindblast 4",
  "Monster Evaluate",
  "Ninja 1",
  "Ninja 2",
  "P.Flame Arrow 1",
  "P.Flame Arrow 2",
  "Party Accuracy",
  "Protection 1",
  "Protection 2",     // 40
  "Protection 3",
  "Protection 4",
  "Quickness 1",
  "Quickness 2",
  "Quickness 3",
  "Quickness 4",
  "Resurrection",
  "Sleep",
  "Strength 1",
  "Strength 2",       // 50
  "Strength 3",
  "Strength 4",
  "Summon Elemental",
  "Teleportation",
  "Transportation",
  "Vision",
  "Weakness 1",
  "Weakness 2",
  "Weakness 3",
  "Weakness 4"        // 60
  // no NULL is required
}, StatusOptions[5] =
{ "Dead",
  "OK",
  "Asleep",
  "Out",
  "Down"
  // no NULL is required
}, QuestOptions[3 + 1] =
{ "Unplayed",
  "Lost",
  "Won"
};

MODULE const UWORD p1class_to_var[P1CLASSES] =
{   CHOOSERPOS_THIEF,
    CHOOSERPOS_MONK,
    CHOOSERPOS_RANGER,
    CHOOSERPOS_FIGHTER,
    CHOOSERPOS_PRIEST,
    CHOOSERPOS_WIZARD
}, p1race_to_var[P1RACES] =
{   CHOOSERPOS_HUMAN,     //  0
    CHOOSERPOS_DWARF,     //  1
    CHOOSERPOS_ELF,       //  2
    CHOOSERPOS_HALFLING,  //  3
    CHOOSERPOS_GNOME,     //  4
    CHOOSERPOS_PIXIE,     //  5
    CHOOSERPOS_SPRITE,    //  6
    CHOOSERPOS_OGRE,      //  7
    CHOOSERPOS_GNOLL,     //  8
    CHOOSERPOS_TROLL,     //  9
    CHOOSERPOS_KOBOLD,    // 10
    CHOOSERPOS_ORC,       // 11
    CHOOSERPOS_GOBLIN,    // 12
    CHOOSERPOS_LIZARDMAN, // 13
    CHOOSERPOS_MINOTAUR,  // 14
    CHOOSERPOS_UNDEAD     // 15
}, p3class_to_var[P3CLASSES] =
{   CHOOSERPOS_FIGHTER,
    CHOOSERPOS_THIEF,
    CHOOSERPOS_PRIEST,
    CHOOSERPOS_RANGER,
    CHOOSERPOS_MONK,
    CHOOSERPOS_WIZARD
}, p3race_to_var[P3RACES] =
{   CHOOSERPOS_HUMAN,     //  0
    CHOOSERPOS_DWARF,     //  1
    CHOOSERPOS_ELF,       //  2
    CHOOSERPOS_GNOME,     //  3
    CHOOSERPOS_HALFLING,  //  4
    CHOOSERPOS_HUMAN,     //  5 (random!)
    CHOOSERPOS_GNOLL,     //  6
    CHOOSERPOS_GOBLIN,    //  7
    CHOOSERPOS_KOBOLD,    //  8
    CHOOSERPOS_LIZARDMAN, //  9
    CHOOSERPOS_MINOTAUR,  // 10
    CHOOSERPOS_OGRE,      // 11
    CHOOSERPOS_ORC,       // 12
    CHOOSERPOS_PIXIE,     // 13
    CHOOSERPOS_SPRITE,    // 14
    CHOOSERPOS_TROLL,     // 15
    CHOOSERPOS_ELEMENTAL, // 16
    CHOOSERPOS_UNDEAD     // 17
}, p3spell_to_var[] =
{   0,                        // $00
    LISTPOS_HEALING_1,
    LISTPOS_HEALING_2,
    LISTPOS_HEALING_3,
    LISTPOS_HEALING_4,
    LISTPOS_FIREFLASH_1,
    LISTPOS_FIREFLASH_2,
    LISTPOS_FIREFLASH_3,
    LISTPOS_FIREFLASH_4,
    LISTPOS_QUICKNESS_1,
    LISTPOS_QUICKNESS_2,
    LISTPOS_QUICKNESS_3,
    LISTPOS_QUICKNESS_4,
    LISTPOS_FLAME_ARROW_1,
    LISTPOS_P_FLAME_ARROW_1,
    LISTPOS_FLAME_ARROW_2,
    LISTPOS_P_FLAME_ARROW_2,  // $10
    LISTPOS_PROTECTION_1,
    LISTPOS_PROTECTION_2,
    LISTPOS_PROTECTION_3,
    LISTPOS_PROTECTION_4,
    LISTPOS_CONFUSION_1,
    LISTPOS_CONFUSION_2,
    LISTPOS_CONFUSION_3,
    LISTPOS_CONFUSION_4,
    LISTPOS_WEAKNESS_1,
    LISTPOS_WEAKNESS_2,
    LISTPOS_WEAKNESS_3,
    LISTPOS_WEAKNESS_4,
    LISTPOS_BINDING_1,
    LISTPOS_BINDING_2,
    LISTPOS_BINDING_3,
    LISTPOS_BINDING_4,        // $20
    LISTPOS_MINDBLAST_1,
    LISTPOS_MINDBLAST_2,
    LISTPOS_MINDBLAST_3,
    LISTPOS_MINDBLAST_4,
    LISTPOS_FLAMEBOLT_1,
    LISTPOS_FLAMEBOLT_2,
    LISTPOS_FLAMEBOLT_3,
    LISTPOS_FLAMEBOLT_4,
    LISTPOS_CHARM,
    LISTPOS_SLEEP,
    LISTPOS_TELEPORTATION,
    LISTPOS_RESURRECTION,
    LISTPOS_NINJA_2,
    LISTPOS_FEAR,
    LISTPOS_DISSOLVE,
    LISTPOS_SUMMON_ELEMENTAL, // $30
    LISTPOS_DISPEL_UNDEAD,
    LISTPOS_NINJA_1,
    LISTPOS_AWAKEN,
    LISTPOS_MONSTER_EVALUATE,
    LISTPOS_VISION,
    LISTPOS_TRANSPORTATION,
    LISTPOS_ACCURACY,
    LISTPOS_PARTY_ACCURACY,
    LISTPOS_DIVINE_AID        // $39
}, p3location_to_var[] =
{   0,                   // 0
    CITYPOS_PENDRAGON,   // 1
    CITYPOS_SANDYSHORES, // 2
    CITYPOS_PENDLETON,   // 3
    CITYPOS_ROCKYHILLS,  // 4
    CITYPOS_DELTOR,      // 5
    CITYPOS_TIRITH,      // 6
    CITYPOS_TIERRIN,     // 7
    CITYPOS_ASMITH,      // 8
    CITYPOS_SIERION,     // 9
    CITYPOS_XANADOR,     // 10
    CITYPOS_FLAGLER,     // 11
    CITYPOS_LANSING,     // 12
    CITYPOS_SCANPORT,    // 13
    CITYPOS_SCIATTICA,   // 14
    CITYPOS_LIGHT,       // 15
    CITYPOS_DARK,        // 16
    CITYPOS_DEATH        // 17
}, var_to_p1class[TOTALCLASSES] =
{   3, // fighter
    1, // monk
    4, // priest
    2, // ranger
    0, // thief
    5  // wizard
}, var_to_p1race[TOTALRACES] =
{   1, // dwarf
    0, // elemental (not allowed!)
    2, // elf
    8, // gnoll
    4, // gnome
   12, // goblin
    3, // halfling
    0, // human
   10, // kobold
   13, // lizard man
   14, // minotaur
    7, // ogre
   11, // orc
    5, // pixie
    6, // sprite
    9, // troll
   15, // undead
}, var_to_p3class[TOTALCLASSES] =
{   0, // fighter
    4, // monk
    2, // priest
    3, // ranger
    1, // thief
    5  // wizard
}, var_to_p3race[TOTALRACES] =
{   1, // dwarf
   16, // elemental
    2, // elf
    6, // gnoll
    3, // gnome
    7, // goblin
    4, // halfling
    0, // human
    8, // kobold
    9, // lizard man
   10, // minotaur
   11, // ogre
   12, // orc
   13, // pixie
   14, // sprite
   15, // troll
   17, // undead
}, var_to_p3location[] =
{   8, // Asmith
   16, // Dark
   17, // Death
    5, // Deltor
   11, // Flagler
   12, // Lansing
   15, // Light
    3, // Pendleton
    1, // Pendragon
    4, // Rocky Hills
    2, // Sandy Shores
   13, // Scanport
   14, // Sciattica
    9, // Sierion
    7, // Tierrin
    6, // Tirith
   10  // Xanador
};

MODULE struct
{   UBYTE x, y;
} p1towns[12] = {
{ 88, 15 }, // Pelnor
{ 69,  5 }, // Pineville
{ 38,  8 }, // Greenville
{ 39, 25 }, // Halflingor
{ 16, 19 }, // Appleton
{ 30, 49 }, // Splitwater
{ 45, 65 }, // Trollport
{  4, 31 }, // Phantasia
{ 17, 77 }, // Dragonor
{ 67, 75 }, // Northford
{ 95, 55 }, // Starville
{  0,  0 }, // Olympia
}, p3towns[17] = {
{ 25, 27 }, //  0 Asmith
{  0,  0 }, //  1 Dark
{  0,  0 }, //  2 Death
{ 43, 52 }, //  3 Deltor
{ 44,  5 }, //  4 Flagler
{ 22, 12 }, //  5 Lansing
{  0,  0 }, //  6 Light
{  5, 35 }, //  7 Pendleton
{ 24, 37 }, //  8 Pendragon
{ 35, 42 }, //  9 Rocky Hills
{ 15, 39 }, // 10 Sandy Shores
{  8,  9 }, // 11 Scanport
{ 15, 22 }, // 12 Sciattica
{  5, 51 }, // 13 Sierion
{ 11, 69 }, // 14 Tierrin
{ 22, 65 }, // 15 Tirith
{ 44, 66 }, // 16 Xanador
};

MODULE TEXT p1_map[80][100 + 1] = { /*
 0    0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8    8    9    9   9
 0    5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0    5   9 */
",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,", //  0
",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,",
",.............%%%%.................................................................................,",
",.......%%%%%%%%%%%%%-----#######.....#########........^^^^^^................................####..,",
",...%%%%%%%%%%%%%%%%%-----#####################------^^^^^^^^^^^^^^^^.........---^^.........######.,",
",...%%%%%%%%%%%%%%%-------#####################------^^^^^^^^^^^^^^^^*^^---------^^^^.......##!###.,", //  5
",..%%%%%%%%%%%%%%%%-------######^^#############------^^^^^^^^^^^^^^^^+^^---------^^^^.......######.,",
",..%%%%%%%%%%%%%----------#####^^^^############------^^^^^^^^^^^^^^^^+^-----------^^^.......######.,",
",..%%%%%%%%%%%------------#####^^^^###*########------^^^^^^^^^++++++++++++++++++--^!^.......######.,",
",..%%%%%%%%%--------------#####^^^^####++++++++++++++++++++++++^^^^^-----------+--^^^^.....########,",
",..%%%%%%%%%------^^------####^^^^^####+########-----!^^^^^^^^^^^^^--------#---+--^^^^-...#########,", // 10
",.%%%%%%%---------^^-------###^^^######+########------^^^^^^^^^^^^---------##--+---^^-----#########,",
",.%%%-----------^^^^^^-----############+########------^^^^^^^^^^-----------###-++++^^-------#######,",
",.--------------^^^^^^-----############+#######--------^^^^^^^---.---------###---!+^^-------#######,",
",.!---------------^^^^^-----########-!#+######----------^^^^---------------####---+-----------#####,",
",.----------------^^^^^-----########---+-####------------------------------####---++++++*------####,", // 15
",.----++++++--------^^------########---+---#..-----------!---.......-------#####---------------###.,",
",.---------++++-----^^------###+++++++++!---........----..........................-------------##..,",
",..-----------++++++++++++++++++###----+--...........................................-------.......,",
",....-----------*----------#######-----+--.........................................................,",
",....----------------------#######-----+--........................................................,,", // 20
",.......-------------------#######-----+--........................................................,,",
",...........----------------#####------+----.........^^......................................^^^^.,,",
",................-----------###--------+------.......^^..^^............^^^^^^^^^.............^^^^.,,",
",....................-------####-------+------..^^...^^^^^^...........^^^^^^^^^^^^^^^^........^^^.,,",
",,,,,,,,,,,,,,,,,........----###-------*^^^^^^..^^..^^^^^^^.......^^^^^^^^^^^^^^^^^^^^^^....^^^^^.,,", // 25
"...--...........,....%%...------------^^^^^^^^^.^...^^^^^^^.....^^^^^^^^^^^^^^^^^^^^^^^^....^^^^..,,",
".------.......-.,...%.....---------^^^^^^^^^^^^.^......^^^......^^^^^^^^^^^^^^^^^^^^^^^^^...^^^!..,,",
".--...-......---,.........-----^^^^^^^^^^^^^^^^........^^!...^^^^^^^^^^^^^^^^^^^^^^^^^^^^.....^^..,,",
".......--....---,...........^^^^^^^^^^^^^^^^^^^..............^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.......,,",
"...^^........-..,...^^......^^^^^^^^^^^^^^^^^^^..............^^^^^^^^^^^^^^^^^^^^%%%%%%^^^^^......,,", // 30
"...^*.......-...,...^^......^^^^^^^^^^.^^^^^^^^............//^^^///^^^%%%%%%%%^^^%%%%%%%%%%%......,,",
".^^^^^..........,..^^^^^...^^^^..^^^!^.^^^^^^^^............//////////%%%%%%%%%%%%%%%%%%%%%%%%%%...,,",
".^^^^^....--....,..^^^^^...^^^^^.^^^^..^^^^----............//////////%%%%%%%%%%%%%%%%%%^^%%%%%%...,,",
"..^^^...........,....^^...^^^^^^......^^^------...........////////////%%%%%%%%%%%%%%%%%^^%%%%%%...,,",
"..^^^,,,,,,,,,,,,.........^^^^^^^^^^^.^--------...........--//////////%%%///%%%%%%%%%%%^^%%%%%%%..,,", // 35
"....,.............^^^^^^^^^^^^^^^^^--.---------...........----////////////////%%%%%%%%%^^^%%%%%%..,,",
"....,........^^^^^^^^^^^^^^^^-------..!--------..........-------//////////////%%%%%%%%%^^^%%%%%%..,,",
"....,...^^^^^^^^^^^^^^^-------------.----------..........-------/////////////////%%%%%%%%%%%%%%%..,,",
"....,^^^^^^^^^^^^^^^^---------------.----------..........--------/////////////////%%%%%%%%%%%%%%..,,",
",,,,,^^^^^^^^^^^^^^^^---------------.----------..........--------/////////////////%%%%%%%%%%%%%%..,,", // 40
",....^^^^^^^^^^^^^------------------.----------.........---------///////////////////%%%%%%%%%%%%..,,",
",....^^^^^^^^^^--------------------..----------.........---------/////////////////////%%%%%%%%%%..,,",
",....!^^^^^^-----------------------.-----------.........----------////////////////////%%%%%%%%%%..,,",
",...^^^^------------------------....-----------........-----------//////////////////////%%%%%%%%%.,,",
",...--------------------------...--------^^----........-----------////////////////////////%%%%%%%.,,", // 45
",...--------------------------.--------^^^^----........-----------/////////////////////////%%%%%%.,,",
",...--------------------------.--------^^^^----.......----###------/////////////////////////%%%%%.,,",
",...--------------.............-------^^^^^---........----#####----///////////////////////////%%%.,,",
",..-------.........----------.*++++---^^^^^^--.......------#####---//////////////---////////////..,,",
",..........------------------.----+----^^^^^--.......!-----#####----///////////-------//////////..,,", // 50
",......----------------------..---+----^^^^---.......------#####----/////////-----------////////..,,",
",..---------------------------.---+---^^^-----.......-------#####---//////----------------//////..,,",
",..---------------------------.---+---^^^-----.......-------#####----/////-----------------/////..,,",
",..^^^^^^-------------^^^^^^--.---+-----------.......--------#####---////-------------------////..,,",
",..^^^^^^^^^^^----^^^^^^^^^^^^.---+++++++++---......---------#####----///-----------------+++++*..,,", // 55
",..^^^^^^^^^^^^^^^^^^^^^^^^^^^.----------!+---......---------######!----------------------+----...,,",
",...!-^^^^^^^^^^^^^^^^^^^^^^^^.^----------+--.......---------######-----------------------+----...,,",
",...---^^^^^^^^^^^^^^^^^^^^^^^.^----------+--.......---------######-----------------------+----...,,",
",...---^^^^^^^^^^^^^^^^^^^^^^^.^^^--------+--.......---------######-----------------------+---....,,",
",...---^^^^^^^^^^^^^^^^^^^^^^^.^^^--------+--.......---------######-----------------------+---....,,", // 60
",...----^^^^^^^^^^^^^^^^^^^^...^^^--------+--......-----------#########---------+++++++++++---....,,",
",...-------^^^^^^^^^^^^^^^^^^^...^--------+--......------------############-----+!------------....,,",
",...-----------^^^^^^^#######^^^.^--------+---.....------------#############----+-------------....,,",
",...-------------!#############^^^^-------+---....-----------..###############--+------------.....,,",
",...--------------#############^^^^-------+++*--------------....##############--+------------.....,,", // 65
",....-------------#############^^^^----------+--------------....################+------------.....,,",
",....--------------#############^^^^---------+---------------..#################+##--------.......,,",
",....--------------#############^^^^^--------+---------------.##################+#####-----....--.,,",
",....--------------#############^^^^^^^------+++++++++++-----...#####++++++++++++#######....------,,",
",....---------------############^^^^^^^^^-------------!+-------.#####+##################.......---,,", // 70
",....---------------##############^^^^^^^^^^^----------+++++++++++++++###############.............,,",
",....---------------##############^^^^^^^^^^^^^^^^^^-----------.###+#################...........%.,,",
",.....-------------##################^^^^^^^^^^^^^^^^^---------...#+###############............%%.,,",
",..%%.-------------#################.###^^^^^^^^^^^^^^-----------.#+###############.......-....%%.,,",
",.%%..-------------######################^^^^^^^^^^^^^^^---------..*#########..........%%.--....%%,,", // 75
",..%%.....--------#######################^^,,,,,,,........--------....................%%...--...%%,,",
",...%%........---*###....,,,,#########,,,,,,,,,,,,....................................%%....---.%.,,",
",........................,,,,,,,,,,,,,,,,,,,,,,,,,.....................................!%.........,,",
",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"  // 79
}, p3_map[75][51 + 1] = {
"...................................................",
"....---....%%......................................",
"...--...%%.......................%%%%%........&&...",
"...--...%%%.......---...........%%%%.........&&&...",
"............%%..------#.........%%%%%.......&&&&...",
".........--%%%%-------##..........%%%.......!&&-...",
".......-----%%%%------###..................&&&--...",
".....--------%%%%------###.................&&---...",
".....--------%%%%%-----##*##....##-......&&&&---...",
".....---!-----%%%%------##########---....&&&&-*....",
"....---..-----%%%%%------########----&&&&&&&&&.....",
"....--...------%%%^^^---------------&&&&&&&&&......",
".......&.------%^^^^^^!-------------&&&&&&&&.......",
"....&&&&--------^^^^^^^^-------------&&&&&&&.......",
"....&&&&---------^^^^^^^^------------&&&&&&&&......",
"....&&&&------------^^^^^------------&&&&&&&&......",
".....&&&------------^^^^^^^^---------&&&&&&&&......",
"....&&&&&-----------^^^^^^^^^--------&&&&&&&&......",
"....&&&&&-----------^^^....^^^^-------&&&&&&&&.....",
"...&&&&&------------^^....^^^^^-------&&&&&&&&.....",
"...&&&--------------^^..$.^^^^^-------------&&.....",
"..$&&&--------------^^^....^^^^^--------------$....",
"..-------------!##--.^^....^^^^^---------------....",
"..-----------#####--.^^^^^^^^^^^----------------...",
"...-----.....#$####-.^^^^^^^^^^^^---------------...",
"....---........#######^^^^^^^^^^^------####-----...",
"...............#######^^^^^^^^^^^---##########.....",
".%%%%......&&&..#########!^^^^^^##############.....",
"..%%.......&&...#########+###################......",
"............&...#########+###################......",
"............&...#########+###################......",
"...---.-...&&...#########+##################..&&...",
"......-....&&&...#######$+#################..&&&...",
"...........&.&...#######++###############--...&....",
"...%%......&.....------#+###########-------$..&&...",
"..*%%!+%.........-------+--######-----------..&&...",
"..%%%%+%%--.....--------+--###-----%%%%-----...&*..",
"..%%%%+%%----...--++++++!---------%%%%%------..&&..",
"..%%%-+-------..--+-----+---------%%*%%------...&..",
"...%%-+++------!+++-----+*-------%%%%%%-------.....",
"...-----++++++++-----&&-+-------%%%%%%------###....",
"...---------------&&&&&-++++++++++%%%%-----####....",
"......------------&&&&&-+--------++!%%%----#####...",
"......--------&&&&&&&&--+-------%%++%%%----#####...",
"......-------&&&&&&&&&--+-------%%%+%%%------###...",
".......------&&&&&&&&&&-+-------%%%+%%%------###...",
".%..%..-------&&&&&-&&--+-------%%%+%%%------###...",
".%%%%.----------&-------+-------%%%+%%---------....",
".%%%..---------------++++--------%%+%%---------....",
".%%...--------.------+------####---+++++++++--.....",
".%...---------...----+$-----####-----------+%%.....",
".%...!----------.----+---#........-------%%+%%.....",
".....-----------.----+--##.#####-.----%%%%%!.......",
".....-----------.----+--##.#####-.----%%%%%........",
".&&...######----.....=.-##.####--...%%%%%%.........",
".&&...######----.----+.....####--.--%%%%%%.........",
"..&&..#######---.----+--.######-..-%%%%%%%%........",
"...&..#######--------+--.######----%%%%%%%%........",
".......######--------+--.-######----%%%%%%%%.......",
".......######--------+--.---####----%%%%%%%%.......",
".......######--------+--.---####------%%%%%%.......",
"......#######----++++++-.---######----%%%%%%.......",
"....#########----+----+-.------###---------........",
"..##########-----+----+-.------------------........",
"..##########--++++----+-.------------------........",
"..$---###-----+-------!-..----------------...%%%%..",
"..-----*----+++-------.....-----^^--------..!%%%...",
"..----------+---------......*^^^^^-----.....%%%....",
"..----------+-----&&&&......^^^^^^^---....##%%%%...",
"..---------!+---&&&&&&......^^^^^^^.......###%%%%..",
"..---&&&......--&&&&&&&....^^^^^^^........####%%%..",
"...&&&&&..........&&&&&....^^^^^.........#####%....",
"...&&&...................&.^^............#####.....",
".......................&&..................###.....",
"..................................................."
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP Phantasie1MouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

 /* Plane 0 Plane 1
      (r)     (B)   */
    0x0000, 0xF000, // BBBB .... .... ....    . = Transparent (%00)
    0x7000, 0x8800, // Brrr B... .... ....    r = Red         (%01)
    0x5800, 0xA400, // BrBr rB.. .... ....    B = Black       (%10)
    0x4C00, 0xB200, // BrBB rrB. .... ....
    0x2600, 0x5900, // .BrB BrrB .... ....
    0x1300, 0x2C80, // ..Br BBrr B... ....
    0x0980, 0x1658, // ...B rBBr rB.B B...
    0x04C8, 0x0B34, // .... BrBB rrBB rB..
    0x0278, 0x0584, // .... .BrB Brrr rB..
    0x0170, 0x0288, // .... ..Br Brrr B...
    0x00E0, 0x0118, // .... ...B rrrB B...
    0x00C8, 0x0134, // .... ...B rrBB rB..
    0x019C, 0x0262, // .... ..Br rBBr rrB.
    0x000E, 0x0191, // .... ...B B..B rrrB
    0x0004, 0x000A, // .... .... .... BrB.
    0x0000, 0x0004, // .... .... .... .B..

    0x0000, 0x0000  // reserved
};
#endif

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   const UBYTE  p1,
                 p3;
    const STRPTR name;
} items[TOTALITEMS + 1] =
{ { 0x00, 0x00, "Nothing"          },
  {    0, 0xA6, "Amethyst"         },
  { 0x3A, 0x47, "Axe +0"           },
  { 0x50,    0, "Axe +1"           },
  {    0, 0x96, "Azurite"          },
  { 0x1D, 0x1D, "Banded Mail"      },
  { 0x45, 0x4F, "Bardiche"         },
  {    0, 0x9E, "Black Jar"        },
  {    0, 0xA9, "Black Urn"        },
  {    0, 0xAB, "Black Vase"       },
  {    0, 0xA4, "Blue Opal"        },
  {    0, 0x9B, "Burnt Gem"        },
  { 0x1B, 0x1B, "Chain Mail +0"    },
  { 0x25, 0x25, "Chain Mail +1"    },
  { 0x26, 0x26, "Chain Mail +2"    },
  { 0x15, 0x15, "Clothing"         },
  { 0x1F, 0x1F, "Cloth +1"         },
  { 0x30, 0x3F, "Club"             },
  {    0, 0x53, "Club +1"          },
  {    0, 0x54, "Club +2"          },
  {    0, 0x32, "Compound Bow +0"  },
  {    0, 0x33, "Compound Bow +1"  },
  {    0, 0x34, "Compound Bow +2"  },
  {    0, 0x97, "Coral"            },
  {    0, 0x39, "Crossbow +0"      },
  {    0, 0x3A, "Crossbow +2"      },
  {    0, 0x8F, "Crystal"          },
  { 0x2D, 0x3E, "Dagger +0"        },
  { 0x48, 0x51, "Dagger +1"        },
  { 0x4A, 0x52, "Dagger +2"        },
  { 0x4B,    0, "Dagger +3"        },
  { 0x4D,    0, "Dagger +4"        },
  {    0, 0xAA, "Dark Key"         },
  {    0, 0xA4, "Diamond"          },
  {    0, 0xA3, "Emerald"          },
  {    0, 0xA7, "Fire Opal"        },
  { 0x36, 0x44, "Flail +0"         },
  { 0x4E, 0x55, "Flail +1"         },
  {    0, 0x56, "Flail +2"         },
  {    0, 0x9D, "Foul Bottle"      },
  {    0, 0xA8, "Gem of Light"     },
  { 0x01, 0x01, "Glove"            },
  { 0x10, 0x10, "Giant Shield +0"  },
  { 0x11, 0x11, "Giant Shield +1"  },
  { 0x12, 0x12, "Giant Shield +2"  },
  { 0x13, 0x13, "Giant Shield +3"  },
  {    0, 0x35, "Gnome Bow"        },
  {    0, 0xB0, "Golden Belt"      },
  {    0, 0xAD, "Golden Chalice"   },
  {    0, 0x90, "Gold Ore"         },
  { 0x28, 0x28, "God Armour"       },
  { 0x63,    0, "God Axe"          },
  {    0, 0x3C, "God Bow"          },
  { 0x61, 0x62, "God Knife"        },
  { 0x62, 0x63, "God Mace"         },
  { 0x27, 0x27, "God Robes"        },
  { 0x14, 0x14, "God Shield"       },
  { 0x64, 0x64, "God Sword"        },
  { 0x46, 0x50, "Halberd +0"       },
  { 0x58, 0x5D, "Halberd +1"       },
  { 0x5A, 0x5E, "Halberd +2"       },
  { 0x5B,    0, "Halberd +3"       },
  { 0x5D,    0, "Halberd +4"       },
  { 0x5E, 0x60, "Halberd +5"       },
  { 0x5F, 0x61, "Halberd +6"       },
  { 0x60,    0, "Halberd +7"       },
  { 0x37, 0x45, "Hammer"           },
  { 0x18, 0x18, "Hard Leather"     },
  { 0x3C, 0x49, "Heavy Mace"       },
  {    0, 0x65, "Healing Potion 1" },
  {    0, 0x66, "Healing Potion 2" },
  {    0, 0x67, "Healing Potion 3" },
  {    0, 0x68, "Healing Potion 4" },
  {    0, 0x69, "Healing Potion 5" },
  {    0, 0x6A, "Healing Potion 6" },
  {    0, 0x6B, "Healing Potion 7" },
  {    0, 0x6C, "Healing Potion 8" },
  {    0, 0x6D, "Healing Potion 9" },
  {    0, 0x6E, "Healing Potion 10"},
  {    0, 0x9A, "Jacinth"          },
  {    0, 0x92, "Jade"             },
  { 0x2A, 0x3D, "Knife"            },
  { 0x40, 0x4C, "Large Axe +0"     },
  { 0x54,    0, "Large Axe +1"     },
  { 0x0C, 0x0C, "Large Shield +0"  },
  { 0x0D, 0x0D, "Large Shield +1"  },
  { 0x0E, 0x0E, "Large Shield +2"  },
  { 0x0F, 0x0F, "Large Shield +3"  },
  { 0x3F, 0x4B, "Large Spear"      },
  { 0x17, 0x17, "Leather +0"       },
  { 0x21, 0x21, "Leather +1"       },
  { 0x22, 0x22, "Leather +2"       },
  {    0, 0xAC, "Light Key"        },
  {    0, 0x36, "Long Bow +0"      },
  {    0, 0x37, "Long Bow +1"      },
  {    0, 0x38, "Long Bow +2"      },
  { 0x43, 0x4E, "Long Sword"       },
  { 0x31, 0x40, "Mace"             },
  {    0, 0x6F, "Magic Potion 1"   },
  {    0, 0x70, "Magic Potion 2"   },
  {    0, 0x71, "Magic Potion 3"   },
  {    0, 0x72, "Magic Potion 4"   },
  {    0, 0x73, "Magic Potion 5"   },
  {    0, 0x74, "Magic Potion 6"   },
  {    0, 0x75, "Magic Potion 7"   },
  {    0, 0x76, "Magic Potion 8"   },
  {    0, 0x77, "Magic Potion 9"   },
  {    0, 0x78, "Magic Potion 10"  },
  { 0x3D,    0, "Maul"             },
  {    0, 0x2F, "Medium Bow +0"    },
  {    0, 0x30, "Medium Bow +1"    },
  {    0, 0x31, "Medium Bow +2"    },
  { 0x08, 0x08, "Medium Shield +0" },
  { 0x09, 0x09, "Medium Shield +1" },
  { 0x0A, 0x0A, "Medium Shield +2" },
  { 0x0B, 0x0B, "Medium Shield +3" },
  { 0x41,    0, "Morning Star"     },
  {    0, 0xA0, "Nice Gem"         },
  {    0, 0x3B, "Old Bow"          },
  {    0, 0xB2, "Old Coin"         },
  {    0, 0xB1, "Old Crown"        },
  {    0, 0xB3, "Old Wine"         },
  {    0, 0x93, "Onyx"             },
  {    0, 0xA1, "Opal"             },
  {    0, 0xAF, "Painting"         },
  {    0, 0x8E, "Pearl"            },
  { 0x42, 0x4D, "Pike"             },
  { 0x38,    0, "Pitchfork"        },
  { 0x1E, 0x1E, "Plate Mail"       },
  {    0, 0x8D, "Quartz"           },
  { 0x19, 0x19, "Ring Mail +0"     },
  { 0x23, 0x23, "Ring Mail +1"     },
  { 0x24, 0x24, "Ring Mail +2"     },
  { 0x16, 0x16, "Robes +0"         },
  { 0x20, 0x20, "Robes +1"         },
  {    0, 0x9F, "Ruby"             },
  {    0, 0x95, "Sapphire"         },
  { 0x1A, 0x1A, "Scale Mail"       },
  {    0, 0x79, "Scroll 1"         },
  {    0, 0x7A, "Scroll 2"         },
  {    0, 0x7B, "Scroll 3 (1)"     },
  {    0, 0x7C, "Scroll 3 (2)"     },
  {    0, 0x7D, "Scroll 3 (3)"     },
  {    0, 0x7E, "Scroll 4"         },
  {    0, 0x7F, "Scroll 5"         },
  {    0, 0x80, "Scroll 6"         },
  {    0, 0x81, "Scroll 7 (1)"     },
  {    0, 0x82, "Scroll 7 (2)"     },
  {    0, 0x83, "Scroll 7 (3)"     },
  {    0, 0x84, "Scroll 8"         },
  {    0, 0x85, "Scroll 9"         },
  {    0, 0x86, "Scroll 10"        },
  {    0, 0x87, "Scroll 11"        },
  {    0, 0x88, "Scroll 12"        },
  {    0, 0x89, "Scroll 13"        },
  {    0, 0x8A, "Scroll 14"        },
  {    0, 0x8B, "Scroll 15"        },
  {    0, 0x8C, "Scroll 16"        },
  {    0, 0x29, "Self Bow +0"      },
  {    0, 0x2A, "Self Bow +1"      },
  {    0, 0x2B, "Self Bow +2"      },
  {    0, 0x2C, "Short Bow +0"     },
  {    0, 0x2D, "Short Bow +1"     },
  {    0, 0x2E, "Short Bow +2"     },
  {    0, 0x43, "Short Sword"      },
  {    0, 0xAE, "Silk Tapestry"    },
  { 0x33, 0x41, "Small Axe"        },
  { 0x2B,    0, "Small Club"       },
  { 0x2F,    0, "Small Flail"      },
  { 0x32,    0, "Small Hammer"     },
  { 0x2D,    0, "Small Mace +0"    },
  { 0x47,    0, "Small Mace +1"    },
  { 0x49,    0, "Small Mace +2"    },
  { 0x2C,    0, "Small Staff"      },
  { 0x04, 0x04, "Small Shield +0"  },
  { 0x05, 0x05, "Small Shield +1"  },
  { 0x06, 0x06, "Small Shield +2"  },
  { 0x07, 0x07, "Small Shield +3"  },
  { 0x35,    0, "Small Sword"      },
  { 0x39, 0x46, "Spear +0"         },
  { 0x4F, 0x57, "Spear +1"         },
  { 0x44,    0, "Spetum"           },
  { 0x1C, 0x1C, "Splint Mail"      },
  {    0, 0xA2, "Star Ruby"        },
  { 0x34, 0x42, "Staff +0"         },
  { 0x4C,    0, "Staff +1"         },
  {    0, 0x94, "Statue"           },
  {    0, 0x91, "Statuette"        },
  { 0x29,    0, "Stick"            },
  {    0, 0x9C, "Sweet Bottle"     },
  { 0x3B, 0x48, "Sword +0"         },
  { 0x51, 0x58, "Sword +1"         },
  { 0x52, 0x59, "Sword +2"         },
  { 0x53,    0, "Sword +3"         },
  { 0x55, 0x5A, "Sword +4"         },
  { 0x56, 0x5B, "Sword +5"         },
  { 0x57, 0x5C, "Sword +6"         },
  { 0x59,    0, "Sword +7"         },
  { 0x5C, 0x5F, "Sword +10"        },
  { 0x3E, 0x4A, "Trident"          },
  {    0, 0x99, "Topaz"            },
  {    0, 0x98, "Turquoise"        },
  {    0, 0xB4, "Wand of Nikademus"},
  { 0x02, 0x02, "Wooden Shield +0" } ,
  { 0x03, 0x03, "Wooden Shield +1" }
};

MODULE struct
{  TEXT  name[10 + 1];
   ULONG race, theclass,
         str, iq, dex, con, cha, luk,
         level,
         maxhp, curhp, maxsp, cursp,
         gp, xp, score, age,
         social, origin, status, location,
         head, leftarm, rightarm, torso, leftleg, rightleg,
         attack, parry, finditem, findtrap,
         disarmtrap, listen, picklock, swim, firebow,
         air, earth, fire, water, god,
         purged,
         spell[TOTALSPELLS],
         equip[9],
         quest[3];
} man[32];

#define TOWNS    14
#define NONTOWNS 16
#define DESCS    (TOWNS + NONTOWNS)
    PERSIST   struct
    {   int    x, y;
        STRPTR desc;
        int    pos;
    } specialdescs[DESCS] = {
// 14 towns
{ 24, 37, "Pendragon"                  , CITYPOS_PENDRAGON   },
{ 15, 39, "Sandy Shores"               , CITYPOS_SANDYSHORES },
{  5, 35, "Pendleton"                  , CITYPOS_PENDLETON   },
{ 35, 42, "Rocky Hills"                , CITYPOS_ROCKYHILLS  },
{ 43, 52, "Deltor"                     , CITYPOS_DELTOR      },
{ 22, 65, "Tirith"                     , CITYPOS_TIRITH      },
{ 11, 69, "Tierrin"                    , CITYPOS_TIERRIN     },
{ 25, 27, "Asmith"                     , CITYPOS_ASMITH      },
{  5, 51, "Sierion"                    , CITYPOS_SIERION     },
{ 44, 66, "Xanador"                    , CITYPOS_XANADOR     },
{ 44,  5, "Flagler"                    , CITYPOS_FLAGLER     },
{ 22, 12, "Lansing"                    , CITYPOS_LANSING     },
{  8,  9, "Scanport"                   , CITYPOS_SCANPORT    },
{ 15, 22, "Sciattica"                  , CITYPOS_SCIATTICA   },
// 8 dungeons and 8 inns (16 non-towns)
{ 25,  8, "Many men guard a tent here" , 0                   },
{ 46,  9, "A very small straw hut"     , 0                   },
{ 24, 20, "The Mystic Inn"             , 0                   },
{  2, 21, "The Desert Inn"             , 0                   },
{ 46, 21, "The Portal Inn"             , 0                   },
{ 14, 24, "The Kanpai Inn"             , 0                   },
{ 24, 32, "The Jolly Inn"              , 0                   },
{ 43, 34, "The Crown Inn"              , 0                   },
{  2, 35, "The Dwarven burial grounds" , 0                   },
{ 48, 36, "A large crystal building"   , 0                   },
{ 25, 39, "The Pendragon town archives", 0                   },
{ 36, 38, "A large cavern starts here" , 0                   },
{ 22, 50, "The Royal Inn"              , 0                   },
{  2, 65, "The Deadly Inn"             , 0                   },
{  7, 66, "A cave smelling of sulphur" , 0                   },
{ 28, 67, "A giant wooden building"    , 0                   },
};

// 8. CODE ---------------------------------------------------------------

EXPORT void ph_main(void)
{   TRANSIENT int                 i;
    TRANSIENT struct ChooserNode* ChooserNodePtr;
    TRANSIENT struct Node*        NodePtr;
    PERSIST   FLAG                first = TRUE;

    if (first)
    {   first = FALSE;

        // ph_preinit()
        NewList(&ItemsList);
        NewList(&SpellsList);
        NewList(&StatusList);

        // ph_init()
        for (i = 0; i <= TOTALITEMS; i++)
        {   NodePtr = (struct Node*) AllocListBrowserNode
            (   1,
                LBNCA_Text,    items[i].name,
            TAG_END);
            // we should check NodePtr is non-zero
            AddTail(&ItemsList, (struct Node*) NodePtr);
        }
        lb_makechecklist(&SpellsList, SpellNames, 61);
    }

    tool_open      = ph_open;
    tool_loop      = ph_loop;
    tool_save      = ph_save;
    tool_close     = ph_close;
    tool_exit      = ph_exit;
    tool_subgadget = ph_subgadget;

    if (loaded != FUNC_PHANTASIE && !ph_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_PHANTASIE;

    ph_getpens();
    load_images(170, 186);
    make_speedbar_list(GID_PH_SB1);
    load_aiss_images( 6,  8);
    load_aiss_images(10, 10);
    load_aiss_images(16, 16);
    load_aiss_images(78, 78);
    for (i = 0; i < 5; i++)
    {   if (!(ChooserNodePtr = (struct ChooserNode*) AllocChooserNode
        (   CNA_Text, StatusOptions[i],
        TAG_DONE)))
        {   rq("Can't create chooser.gadget node(s)!");
        }
        AddTail(&StatusList, (struct Node*) ChooserNodePtr); /* AddTail() has no return code */
    }

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_PH_LY1] = (struct Gadget*)
        VLayoutObject,
            GA_ID,                                         GID_PH_LY1,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddHLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                AddToolbar(GID_PH_SB1),
                AddSpace,
                LAYOUT_AddChild,                           gadgets[GID_PH_CH13] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                 GID_PH_CH13,
                    GA_Disabled,                           TRUE,
                    CHOOSER_LabelArray,                    &GameOptions,
                ChooserEnd,
                Label("Game:"),
                CHILD_WeightedWidth,                       0,
                AddSpace,
                MaximizeButton(GID_PH_BU12, "Maximize Party"),
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddLabel(""),
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                AddSpace,
                AddLabel("Character #:"),
                CHILD_WeightedWidth,                       0,
                LAYOUT_AddChild,                           gadgets[GID_PH_IN20] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_PH_IN20,
                    GA_RelVerify,                          TRUE,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       1,
                    INTEGER_Maximum,                       32,
                    INTEGER_MinVisible,                    2 + 1,
                IntegerEnd,
                CHILD_WeightedWidth,                       0,
                AddLabel("of"),
                LAYOUT_AddChild,                           gadgets[GID_PH_IN27] = (struct Gadget*)
                IntegerObject,
                    GA_ReadOnly,                           TRUE,
                    INTEGER_Arrows,                        FALSE,
                    INTEGER_MaxChars,                      2,
                IntegerEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_Label,                              "Character",
                AddHLayout,
                    AddVLayout,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_Label,                      "General",
                        LAYOUT_VertAlignment,              LALIGN_CENTER,
                        LAYOUT_AddChild,                   gadgets[GID_PH_ST1] = (struct Gadget*)
                        StringObject,
                            GA_ID,                         GID_PH_ST1,
                            GA_TabCycle,                   TRUE,
                            STRINGA_TextVal,               man[who].name,
                            STRINGA_MaxChars,              10 + 1,
                        StringEnd,
                        Label("Name:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_PH_IN2] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_PH_IN2,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            AddLabel("of"),
                            LAYOUT_AddChild,               gadgets[GID_PH_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_PH_IN3,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Hit Points:"),
                        AddHLayout,
                            LAYOUT_VertAlignment,          LALIGN_CENTER,
                            LAYOUT_AddChild,               gadgets[GID_PH_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_PH_IN4,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            AddLabel("of"),
                            LAYOUT_AddChild,               gadgets[GID_PH_IN5] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_PH_IN5,
                                GA_TabCycle,               TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           999,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                        LayoutEnd,
                        Label("Spell Points:"),
                        LAYOUT_AddChild,                   gadgets[GID_PH_CH2] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_PH_CH2,
                            CHOOSER_LabelArray,            &ClassOptions,
                        PopUpEnd,
                        Label("Class:"),
                        LAYOUT_AddChild,                   gadgets[GID_PH_IN21] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_PH_IN21,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               21,
                            INTEGER_MinVisible,            2 + 1,
                        IntegerEnd,
                        Label("Level:"),
                        LAYOUT_AddChild,                   gadgets[GID_PH_IN22] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_PH_IN22,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999999,
                            INTEGER_MinVisible,            9 + 1,
                        IntegerEnd,
                        Label("Experience Pts:"),
                        LAYOUT_AddChild,                   gadgets[GID_PH_IN24] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_PH_IN24,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999,
                            INTEGER_MinVisible,            3 + 1,
                        IntegerEnd,
                        Label("Score:"),
                        LAYOUT_AddChild,                   gadgets[GID_PH_IN1] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_PH_IN1,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               999999999,
                            INTEGER_MinVisible,            9 + 1,
                        IntegerEnd,
                        Label("Gold:"),
                        LAYOUT_AddChild,                   gadgets[GID_PH_IN12] = (struct Gadget*)
                        IntegerObject,
                            GA_ID,                         GID_PH_IN12,
                            GA_TabCycle,                   TRUE,
                            INTEGER_Minimum,               0,
                            INTEGER_Maximum,               1260,
                            INTEGER_MinVisible,            4 + 1,
                        IntegerEnd,
                        Label("Age:"),
                        LAYOUT_AddChild,                   gadgets[GID_PH_CH4] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_PH_CH4,
                            CHOOSER_Labels,                &StatusList,
                        PopUpEnd,
                        Label("Status:"),
                        LAYOUT_AddChild,                   gadgets[GID_PH_CH1] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_PH_CH1,
                            CHOOSER_LabelArray,            &OriginOptions,
                        PopUpEnd,
                        Label("Origin:"),
                        LAYOUT_AddChild,                   gadgets[GID_PH_CH5] = (struct Gadget*)
                        PopUpObject,
                            GA_ID,                         GID_PH_CH5,
                            CHOOSER_LabelArray,            &SocialOptions,
                        PopUpEnd,
                        Label("Social:"),
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    AddVLayout,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_Label,                      "Items",
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
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                AddVLayout,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_Label,                          "Race",
                    AddHLayout,
                        RaceButton(0),
                        RaceButton(1),
                        RaceButton(2),
                        RaceButton(3),
                        RaceButton(4),
                        RaceButton(5),
                        RaceButton(6),
                        RaceButton(7),
                        RaceButton(8),
                    LayoutEnd,
                    AddHLayout,
                        AddSpace,
                        CHILD_WeightedWidth,               50,
                        RaceButton(9),
                        RaceButton(10),
                        RaceButton(11),
                        RaceButton(12),
                        RaceButton(13),
                        RaceButton(14),
                        RaceButton(15),
                        RaceButton(16),
                        AddSpace,
                        CHILD_WeightedWidth,               50,
                    LayoutEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    MapButton(GID_PH_BU34, "Character Location..."),
                    LAYOUT_AddChild,                       gadgets[GID_PH_BU32] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_PH_BU32,
                        GA_RelVerify,                      TRUE,
                        GA_Text,                           "More...",
                    ButtonEnd,
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
                AddHLayout,
                    LAYOUT_EvenSize,                       TRUE,
                    AddVLayout,
                        AddSpace,
                        LAYOUT_AddChild,                   gadgets[GID_PH_CB6] = (struct Gadget*)
                        TickOrCheckBoxObject,
                            GA_ID,                         GID_PH_CB6,
                            GA_Text,                       "Purged?",
                        End,
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
                    MaximizeButton(GID_PH_BU11, "Maximize Character"),
                LayoutEnd,
                CHILD_WeightedHeight,                      0,
            LayoutEnd,
            AddHLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                AddLabel("Party Gold:"),
                LAYOUT_AddChild,                           gadgets[GID_PH_IN26] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_PH_IN26,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       0,
                    INTEGER_Maximum,                       999999999,
                    INTEGER_MinVisible,                    9 + 1,
                IntegerEnd,
                CHILD_WeightedWidth,                       0,
                MapButton2(GID_PH_BU33, "Party Location..."),
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_PH_SB1);
#ifndef __MORPHOS__
    if (game == PHANTASIE1)
    {   MouseData = (UWORD*) Phantasie1MouseData;
        setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
    } else
    {   westwood();
    }
#endif
    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_PH_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_PH_ST1]);
    loop();
    readgadgets();
    closewindow();
}

EXPORT void ph_loop(ULONG gid, UNUSED ULONG code)
{   int i;

    switch (gid)
    {
    case GID_PH_IN20: // who
        readgadgets();
        DISCARD GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN20], (ULONG*) &who);
        who--;
        writegadgets();
    acase GID_PH_BU11:
        readgadgets();
        maximize_man(who);
        writegadgets();
    acase GID_PH_BU12:
        readgadgets();
        for (i = 0; i < (int) men; i++)
        {   maximize_man(i);
        }
        partygold = 900000000; // nine hundred million
        writegadgets();
    acase GID_PH_BU32:
        morewindow();
    acase GID_PH_BU33:
        submode = 2;
        mapwindow();
    acase GID_PH_BU34:
        submode = 3;
        mapwindow();
    adefault:
        if     (gid >= GID_PH_BU2  && gid <= GID_PH_BU10)
        {   whichitem = gid - GID_PH_BU2;
            itemwindow();
        } elif (gid >= GID_PH_BU15 && gid <= GID_PH_BU31)
        {   readgadgets();
            man[who].race = gid - GID_PH_BU15;
            writegadgets();
}   }   }

EXPORT FLAG ph_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if (gamesize == 7050 || gamesize == 7062)
        {   game = PHANTASIE1;
        } elif (gamesize == 11812) // (262 * 25) + 5262 == 11812
        {   game = PHANTASIE3;
        } else
        {   DisplayBeep(NULL);
            return FALSE;
    }   }
    else
    {   return FALSE;
    }

    serialize();

    if (game == PHANTASIE1)
    {   mapwidth  = 100;
        mapheight =  80;
    } else
    {   mapwidth  =  51;
        mapheight =  75;
    }

#ifndef __MORPHOS__
    if (MainWindowPtr)
    {   if (game == PHANTASIE1)
        {   MouseData = (UWORD*) Phantasie1MouseData;
            setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
        } else
        {   westwood();
    }   }
#endif
    writegadgets();

    return TRUE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_PHANTASIE
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   ULONG        i;
    struct Node* NodePtr;

    // general

    if (gadmode == SERIALIZE_WRITE)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_PH_IN20], MainWindowPtr, NULL,
            INTEGER_Number,  who + 1,
            INTEGER_Maximum, men,
        TAG_END);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_PH_IN27], MainWindowPtr, NULL,
            INTEGER_Number,  men,
        TAG_END);

        either_ch(GID_PH_CH13, &game);

        DISCARD SetGadgetAttrs
        (   gadgets[GID_PH_CH4], MainWindowPtr, NULL,
            CHOOSER_Labels, ~0,
        TAG_END);
        i = 0;
        // Walk the list
        for
        (   NodePtr = StatusList.lh_Head;
            NodePtr->ln_Succ;
            NodePtr = NodePtr->ln_Succ
        )
        {   if (game == PHANTASIE1 && i > 2)
            {   SetChooserNodeAttrs(NodePtr, CNA_Disabled, TRUE,  TAG_END);
            } else
            {   SetChooserNodeAttrs(NodePtr, CNA_Disabled, FALSE, TAG_END);
            }

            i++;
        }
        DISCARD SetGadgetAttrs
        (   gadgets[GID_PH_CH4], MainWindowPtr, NULL,
            CHOOSER_Labels, (ULONG) &StatusList,
        TAG_END);

        for (i = 0; i < 17; i++)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_PH_BU15 + i], MainWindowPtr, NULL,
                GA_Selected, (man[who].race == (ULONG) i)   ? TRUE : FALSE,
                GA_Disabled, (game == PHANTASIE1 && i == 1) ? TRUE : FALSE,
            TAG_END); // this autorefreshes
        }

        ghost(   GID_PH_CH1 , game != PHANTASIE3);
        ghost(   GID_PH_CH5 , game != PHANTASIE3);
        ghost(   GID_PH_IN26, game != PHANTASIE3);
        ghost(   GID_PH_BU33, game != PHANTASIE3);
        ghost_st(GID_PH_CB6 , game != PHANTASIE1);

        refreshitems();
    }

    either_st(GID_PH_ST1 ,  man[who].name);

    either_ch(GID_PH_CH1 , &man[who].origin);
    either_ch(GID_PH_CH2 , &man[who].theclass);
    either_ch(GID_PH_CH4 , &man[who].status);
    either_ch(GID_PH_CH5 , &man[who].social);

    either_in(GID_PH_IN1 , &man[who].gp);
    either_in(GID_PH_IN2 , &man[who].curhp);
    either_in(GID_PH_IN3 , &man[who].maxhp);
    either_in(GID_PH_IN4 , &man[who].cursp);
    either_in(GID_PH_IN5 , &man[who].maxsp);
    either_in(GID_PH_IN12, &man[who].age);
    either_in(GID_PH_IN21, &man[who].level);
    either_in(GID_PH_IN22, &man[who].xp);
    either_in(GID_PH_IN24, &man[who].score);
    either_in(GID_PH_IN26, &partygold);

    either_cb(GID_PH_CB6 , &man[who].purged);
}

EXPORT void ph_save(FLAG saveas)
{   ULONG i, j;
    UBYTE count;
    TEXT  saystring[80 + 1];

    readgadgets();
    condense();
    serializemode = SERIALIZE_WRITE;
    serialize();
    if (game == PHANTASIE1)
    {   gamesave("#?", "Phantasie 1", saveas, gamesize, FLAG_S, FALSE);
    } else
    {   // assert(game == PHANTASIE3);
        for (i = 0; i < 32; i++)
        {   count = 0;
            for (j = 0; j < TOTALSPELLS; j++)
            {   if (j != LISTPOS_DIVINE_AID && man[i].spell[j])
                {   count++;
            }   }
            if (count > 32)
            {   sprintf
                (   saystring,
                    "Can't save, because %s has >32 spells!",
                    man[i].name
                );
                say(saystring, REQIMAGE_WARNING);
                return;
        }   }
        gamesave("#?", "Phantasie 3", saveas, gamesize, FLAG_S, FALSE);
}   }

MODULE void serialize(void)
{   UBYTE value;
    int   count,
          i, j, k,
          spelloffset;
PERSIST const ULONG toquest[6] =
{ 0x00,
  0x01,
  0x03,
  0x43,
  0xC3,
  0xE3
};

    offset = 0;

    switch (game)
    {
    case PHANTASIE1:
        men = 25;

        for (i = 0; i < 25; i++)
        {   serialize2ulong(&man[i].str);                                   //   0..  1
            serialize2ulong(&man[i].iq);                                    //   2..  3
            serialize2ulong(&man[i].dex);                                   //   4..  5
            serialize2ulong(&man[i].con);                                   //   6..  7
            serialize2ulong(&man[i].cha);                                   //   8..  9
            serialize2ulong(&man[i].luk);                                   //  10.. 11
            offset += 4;                                                    //  12.. 15
            serialize2ulong(&man[i].maxsp);                                 //  16.. 17
            serialize2ulong(&man[i].cursp);                                 //  18.. 19
            serialize2ulong(&man[i].maxhp);                                 //  20.. 21
            serialize2ulong(&man[i].curhp);                                 //  22.. 23
            offset++;                                                       //  24
            serialize1(&man[i].status);                                     //  25
            offset += 4;                                                    //  26.. 29
            serialize2ulong(&man[i].attack);                                //  30.. 31
            serialize2ulong(&man[i].parry);                                 //  32.. 33
            serialize2ulong(&man[i].finditem);                              //  34.. 35
            serialize2ulong(&man[i].findtrap);                              //  36.. 37
            serialize2ulong(&man[i].disarmtrap);                            //  38.. 39
            serialize2ulong(&man[i].listen);                                //  40.. 41
            offset += 2;                                                    //  42.. 43
            serialize2ulong(&man[i].picklock);                              //  44.. 45
            offset += 2;                                                    //  46.. 47
            serialize2ulong(&man[i].swim);                                  //  48.. 49
            offset += 20;                                                   //  50.. 69
            serialize2ulong(&man[i].score);                                 //  70.. 71
            offset++;                                                       //  72
            serialize1(&man[i].air);                                        //  73
            offset++;                                                       //  74
            serialize1(&man[i].earth);                                      //  75
            offset++;                                                       //  76
            serialize1(&man[i].fire);                                       //  77
            offset++;                                                       //  78
            serialize1(&man[i].water);                                      //  79
            offset++;                                                       //  80
            serialize1(&man[i].god);                                        //  81
            offset++;                                                       //  82

            if (serializemode == SERIALIZE_READ)
            {   serialize1(&man[i].equip[2]);                               //  83
                offset++;                                                   //  84
                serialize1(&man[i].equip[1]);                               //  85
                offset++;                                                   //  86
                serialize1(&man[i].equip[0]);                               //  87
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                IOBuffer[offset++] = (UBYTE) items[man[i].equip[2]].p1;     //  83
                offset++;                                                   //  84
                IOBuffer[offset++] = (UBYTE) items[man[i].equip[1]].p1;     //  85
                offset++;                                                   //  86
                IOBuffer[offset++] = (UBYTE) items[man[i].equip[0]].p1;     //  87
            }

            serialize2ulong(&man[i].level);                                 //  88.. 89
            offset++;                                                       //  90
            serialize1(&man[i].purged);                                     //  91
            offset += 5;                                                    //  92.. 96

            serialize1(&man[i].spell[LISTPOS_HEALING_1    ]);               //  97
            offset++;                                                       //  98
            serialize1(&man[i].spell[LISTPOS_HEALING_2    ]);               //  99
            offset++;                                                       // 100
            serialize1(&man[i].spell[LISTPOS_HEALING_3    ]);               // 101
            offset++;                                                       // 102
            serialize1(&man[i].spell[LISTPOS_HEALING_4    ]);               // 103
            offset++;                                                       // 104
            serialize1(&man[i].spell[LISTPOS_FIREFLASH_1  ]);               // 105
            offset++;                                                       // 106
            serialize1(&man[i].spell[LISTPOS_FIREFLASH_2  ]);               // 107
            offset++;                                                       // 108
            serialize1(&man[i].spell[LISTPOS_FIREFLASH_3  ]);               // 109
            offset++;                                                       // 110
            serialize1(&man[i].spell[LISTPOS_FIREFLASH_4  ]);               // 111
            offset++;                                                       // 112
            serialize1(&man[i].spell[LISTPOS_QUICKNESS_1  ]);               // 113
            offset++;                                                       // 114
            serialize1(&man[i].spell[LISTPOS_QUICKNESS_2  ]);               // 115
            offset++;                                                       // 116
            serialize1(&man[i].spell[LISTPOS_QUICKNESS_3  ]);               // 117
            offset++;                                                       // 118
            serialize1(&man[i].spell[LISTPOS_QUICKNESS_4  ]);               // 119
            offset++;                                                       // 120
            serialize1(&man[i].spell[LISTPOS_STRENGTH_1   ]);               // 121
            offset++;                                                       // 122
            serialize1(&man[i].spell[LISTPOS_STRENGTH_2   ]);               // 123
            offset++;                                                       // 124
            serialize1(&man[i].spell[LISTPOS_STRENGTH_3   ]);               // 125
            offset++;                                                       // 126
            serialize1(&man[i].spell[LISTPOS_STRENGTH_4   ]);               // 127
            offset++;                                                       // 128
            serialize1(&man[i].spell[LISTPOS_PROTECTION_1 ]);               // 129
            offset++;                                                       // 130
            serialize1(&man[i].spell[LISTPOS_PROTECTION_2 ]);               // 131
            offset++;                                                       // 132
            serialize1(&man[i].spell[LISTPOS_PROTECTION_3 ]);               // 133
            offset++;                                                       // 134
            serialize1(&man[i].spell[LISTPOS_PROTECTION_4 ]);               // 135
            offset++;                                                       // 136
            serialize1(&man[i].spell[LISTPOS_CONFUSION_1  ]);               // 137
            offset++;                                                       // 138
            serialize1(&man[i].spell[LISTPOS_CONFUSION_2  ]);               // 139
            offset++;                                                       // 140
            serialize1(&man[i].spell[LISTPOS_CONFUSION_3  ]);               // 141
            offset++;                                                       // 142
            serialize1(&man[i].spell[LISTPOS_CONFUSION_4  ]);               // 143
            offset++;                                                       // 144
            serialize1(&man[i].spell[LISTPOS_WEAKNESS_1   ]);               // 145
            offset++;                                                       // 146
            serialize1(&man[i].spell[LISTPOS_WEAKNESS_2   ]);               // 147
            offset++;                                                       // 148
            serialize1(&man[i].spell[LISTPOS_WEAKNESS_3   ]);               // 149
            offset++;                                                       // 150
            serialize1(&man[i].spell[LISTPOS_WEAKNESS_4   ]);               // 151
            offset++;                                                       // 152
            serialize1(&man[i].spell[LISTPOS_BINDING_1    ]);               // 153
            offset++;                                                       // 154
            serialize1(&man[i].spell[LISTPOS_BINDING_2    ]);               // 155
            offset++;                                                       // 156
            serialize1(&man[i].spell[LISTPOS_BINDING_3    ]);               // 157
            offset++;                                                       // 158
            serialize1(&man[i].spell[LISTPOS_BINDING_4    ]);               // 159
            offset++;                                                       // 160
            serialize1(&man[i].spell[LISTPOS_MINDBLAST_1  ]);               // 161
            offset++;                                                       // 162
            serialize1(&man[i].spell[LISTPOS_MINDBLAST_2  ]);               // 163
            offset++;                                                       // 164
            serialize1(&man[i].spell[LISTPOS_MINDBLAST_3  ]);               // 165
            offset++;                                                       // 166
            serialize1(&man[i].spell[LISTPOS_MINDBLAST_4  ]);               // 167
            offset++;                                                       // 168
            serialize1(&man[i].spell[LISTPOS_FLAMEBOLT_1  ]);               // 169
            offset++;                                                       // 170
            serialize1(&man[i].spell[LISTPOS_FLAMEBOLT_2  ]);               // 171
            offset++;                                                       // 172
            serialize1(&man[i].spell[LISTPOS_FLAMEBOLT_3  ]);               // 173
            offset++;                                                       // 174
            serialize1(&man[i].spell[LISTPOS_FLAMEBOLT_4  ]);               // 175
            offset++;                                                       // 176
            serialize1(&man[i].spell[LISTPOS_CHARM        ]);               // 177
            offset++;                                                       // 178
            serialize1(&man[i].spell[LISTPOS_SLEEP        ]);               // 179
            offset++;                                                       // 180
            serialize1(&man[i].spell[LISTPOS_TELEPORTATION]);               // 181
            offset++;                                                       // 182
            serialize1(&man[i].spell[LISTPOS_RESURRECTION ]);               // 183
            offset++;                                                       // 184
            serialize1(&man[i].spell[LISTPOS_NINJA_2      ]);               // 185
            offset++;                                                       // 186
            serialize1(&man[i].spell[LISTPOS_FEAR         ]);               // 187
            offset++;                                                       // 188
            serialize1(&man[i].spell[LISTPOS_DISSOLVE     ]);               // 189
            offset++;                                                       // 190
            serialize1(&man[i].spell[LISTPOS_SUMMON_ELEMENTAL]);            // 191
            offset++;                                                       // 192
            serialize1(&man[i].spell[LISTPOS_DISPEL_UNDEAD]);               // 193
            offset++;                                                       // 194
            serialize1(&man[i].spell[LISTPOS_NINJA_1      ]);               // 195
            offset++;                                                       // 196
            serialize1(&man[i].spell[LISTPOS_AWAKEN       ]);               // 197
            offset++;                                                       // 198
            serialize1(&man[i].spell[LISTPOS_MONSTER_EVALUATE]);            // 199
            offset++;                                                       // 200
            serialize1(&man[i].spell[LISTPOS_VISION       ]);               // 201
            offset++;                                                       // 202
            serialize1(&man[i].spell[LISTPOS_TRANSPORTATION]);              // 203

            offset += 17;                                                   // 204..220
            man[i].location++;
            if (serializemode == SERIALIZE_READ)
            {   man[i].theclass = p1class_to_var[getubyte()];               // 221
                offset += 33;                                               // 222..254
                serialize1(&man[i].location);                               // 255
                offset++;                                                   // 256
                man[i].race     = p1race_to_var[ getubyte()];               // 257
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                IOBuffer[offset++] = (UBYTE) var_to_p1class[man[i].theclass]; // 221
                offset += 33;                                               // 222..254
                serialize1(&man[i].location);                               // 255
                offset++;                                                   // 256
                IOBuffer[offset++] = (UBYTE) var_to_p1race[ man[i].race];   // 257
            }
            man[i].location--;

            offset += 4;                                                    // 258..261
            serialize2ulong(&man[i].gp );                                   // 262..263
            man[i].age *= 26;
            serialize2ulong(&man[i].age);                                   // 264..265
            man[i].age /= 26;
            serialize4(     &man[i].xp );                                   // 266..269

            if (serializemode == SERIALIZE_READ)
            {   for (j = 0; j < 10; j++)
                {   man[i].name[j] = getubyte();                            // 270..279
                }
                man[i].name[10] = EOS;
                offset += 2;                                                // 280..281

                man[i].spell[LISTPOS_ACCURACY] =
                man[i].spell[LISTPOS_AWAKEN]           =
                man[i].spell[LISTPOS_DISPEL_UNDEAD]    =
                man[i].spell[LISTPOS_DISSOLVE]         =
                man[i].spell[LISTPOS_DIVINE_AID]       =
                man[i].spell[LISTPOS_FEAR]             =
                man[i].spell[LISTPOS_FLAME_ARROW_1]    =
                man[i].spell[LISTPOS_FLAME_ARROW_2]    =
                man[i].spell[LISTPOS_MONSTER_EVALUATE] =
                man[i].spell[LISTPOS_NINJA_1]          =
                man[i].spell[LISTPOS_NINJA_2]          =
                man[i].spell[LISTPOS_P_FLAME_ARROW_1]  =
                man[i].spell[LISTPOS_P_FLAME_ARROW_2]  =
                man[i].spell[LISTPOS_PARTY_ACCURACY]   =
                man[i].spell[LISTPOS_RESURRECTION]     =
                man[i].spell[LISTPOS_SUMMON_ELEMENTAL] =
                man[i].spell[LISTPOS_TRANSPORTATION]   =
                man[i].spell[LISTPOS_VISION]           = 0;

                for (j = 0; j <= 2; j++)
                {   value = 0; // not really necessary
                    for (k = 0; k <= TOTALITEMS; k++)
                    {   if (items[k].p1 == man[i].equip[j])
                        {   value = k;
                            break;
                    }   }
                    man[i].equip[j] = value;
            }   }
            else
            {   // assert(serializemode == SERIALIZE_WRITE);
                strcpy((char*) &IOBuffer[offset], man[i].name);
                offset += 12;                                               // 270..281
        }   }

        if (who > 24)
        {   who = 24;
        }
    acase PHANTASIE3:
        men = 32;

        for (i = 0; i < 32; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   for (j = 0; j <= 6; j++)
                {   man[i].name[j] = getubyte();                            //    0..   6
                }
                man[i].name[ 7] =
                man[i].name[ 8] =
                man[i].name[ 9] =
                man[i].name[10] = EOS;
                offset += 3;                                                //    7..   9
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                man[i].name[8] = EOS;
                strcpy((char*) &IOBuffer[offset], man[i].name);
                if (strlen(man[i].name) < 7)
                {   for (j = strlen(man[i].name); j <= 6; j++)
                    {   IOBuffer[offset + j] = EOS;
                }   }
                offset += 10;                                               //    0..   9
            }

            serialize2ulong(&man[i].str  );                                 //   10..  11
            serialize2ulong(&man[i].iq   );                                 //   12..  13
            serialize2ulong(&man[i].dex  );                                 //   14..  15
            serialize2ulong(&man[i].con  );                                 //   16..  17
            serialize2ulong(&man[i].cha  );                                 //   18..  19
            serialize2ulong(&man[i].luk  );                                 //   20..  21
            offset += 2;                                                    //   22..  23
            if (man[i].quest[1] == 2)
            {   man[i].quest[1] = 200;
            }
            serialize2ulong(&man[i].quest[1]);                              //   24..  25
            if (man[i].quest[1] >= 200)
            {   man[i].quest[1] = 2;
            } elif (man[i].quest[1] != 0)
            {   man[i].quest[1] = 1;
            }
            offset += 2;                                                    //   26..  27
            serialize2ulong(&man[i].maxsp);                                 //   28..  29
            serialize2ulong(&man[i].cursp);                                 //   30..  31
            serialize2ulong(&man[i].maxhp);                                 //   32..  33
            serialize2ulong(&man[i].curhp);                                 //   34..  35

            if (serializemode == SERIALIZE_READ)
            {   offset += 4;                                                //   36..  39
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                offset += 3;                                                //   36..  38
                count = 0;
                for (j = 0; j <= 8; j++)
                {   if (man[i].equip[j])
                    {   count++;
                }   }
                IOBuffer[offset++] = (UBYTE) count;                         //   39
            }

            man[i].age *= 26;
            serialize2ulong(&man[i].age);                                   //   40..  41
            man[i].age /= 26;
            offset += 3;                                                    //   42..  44
            serialize1(&man[i].status);                                     //   45
            offset += 2;                                                    //   46..  47
            serialize2ulong(&man[i].attack);                                //   48..  49
            offset += 2;                                                    //   50..  51
            serialize2ulong(&man[i].parry);                                 //   52..  53
            offset += 2;                                                    //   54..  55
            serialize2ulong(&man[i].finditem);                              //   56..  57
            offset += 2;                                                    //   58..  59
            serialize2ulong(&man[i].findtrap);                              //   60..  61
            offset += 2;                                                    //   62..  63
            serialize2ulong(&man[i].disarmtrap);                            //   64..  65
            offset += 2;                                                    //   66..  67
            serialize2ulong(&man[i].listen);                                //   68..  69
            offset += 2;                                                    //   70..  71
            serialize2ulong(&man[i].firebow);                               //   72..  73
            offset += 2;                                                    //   74..  75
            serialize2ulong(&man[i].picklock);                              //   76..  77
            offset += 2;                                                    //   78..  79
            serialize2ulong(&man[i].swim);                                  //   80..  81

            if (serializemode == SERIALIZE_READ)
            {   offset += 7;                                                //   82..  88
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                offset += 5;                                                //   82..  86
                count = 0;
                for (j = 0; j < TOTALSPELLS; j++)
                {   if (j != LISTPOS_DIVINE_AID && man[i].spell[j])
                    {   count++;
                }   }
                IOBuffer[offset++] = (UBYTE) count;                         //   87
                offset++;                                                   //   88
            }

            serialize1(&man[i].origin);                                     //   89
            offset += 2;                                                    //   90..  91
            if (man[i].quest[0] == 2)
            {   man[i].quest[0] = 100;
            }
            serialize2ulong(&man[i].quest[0]);                              //   92..  93
            if (man[i].quest[0] >= 100)
            {   man[i].quest[0] = 2;
            } elif (man[i].quest[0] != 0)
            {   man[i].quest[0] = 1;
            }
            offset++;                                                       //   94

            if (serializemode == SERIALIZE_READ)
            {   man[i].location = p3location_to_var[getubyte()];            //   95
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                IOBuffer[offset++] = (UBYTE) var_to_p3location[man[i].location]; // 95
            }

            offset += 20;                                                   //   96.. 115
            serialize2ulong(&man[i].level);                                 //  116.. 117
            offset += 12;                                                   //  118.. 129
            serialize2ulong(&man[i].score);                                 //  130.. 131
            offset += 6;                                                    //  132.. 137
            man[i].quest[2] = toquest[man[i].quest[2]];
            serialize2ulong(&man[i].quest[2]);                              //  138.. 139
            if   (!(man[i].quest[2] &    1)) man[i].quest[2] = 0;
            elif (!(man[i].quest[2] &    2)) man[i].quest[2] = 1;
            elif (  man[i].quest[2] & 0x20 ) man[i].quest[2] = 5;
            elif (!(man[i].quest[2] & 0x40)) man[i].quest[2] = 2;
            elif (!(man[i].quest[2] & 0x80)) man[i].quest[2] = 3;
            else                             man[i].quest[2] = 4;
            offset += 3;                                                    //  140.. 142
            serialize1(&man[i].social);                                     //  143
            offset += 5;                                                    //  144.. 148

            if (serializemode == SERIALIZE_READ)
            {   man[i].theclass = p3class_to_var[getubyte()];               //  149
                offset++;                                                   //  150

                for (j = 0; j <= 8; j++)
                {   man[i].equip[j] = getubyte();                           //  151/153/155/157/159/161/163/165/167
                    offset++;                                               //  152/154/156/158/160/162/164/166/168
                }
                man[i].race = p3race_to_var[getubyte()];                    //  169

                offset += 7;                                                //  170.. 176
                for (j = 0; j < TOTALSPELLS; j++)
                {   man[i].spell[j] = FALSE;
                }
                for (j = 177; j <= 241; j += 2)                             //  177.. 242
                {   value = getubyte();
                    if (value >= 1 && value <= 0x39)
                    {   man[i].spell[p3spell_to_var[value]] = TRUE;
                    }
                    offset++;
            }   }
            else
            {   // assert(serializemode == SERIALIZE_WRITE);
                IOBuffer[offset++] = (UBYTE) var_to_p3class[man[i].theclass]; // 149
                offset++;                                                   //  150

                for (j = 0; j <= 8; j++)
                {   IOBuffer[offset++] = (UBYTE) items[man[i].equip[j]].p3; //  151/153/155/157/159/161/163/165/167
                    offset++;                                               //  152/154/156/158/160/162/164/166/168
                }
                IOBuffer[offset++] = (UBYTE) var_to_p3race[man[i].race];    //  169

                offset += 7;                                                //  170.. 176
                spelloffset = offset;
                if (man[i].spell[LISTPOS_PARTY_ACCURACY  ]) { IOBuffer[spelloffset] = 0x38; spelloffset += 2; }
                if (man[i].spell[LISTPOS_ACCURACY        ]) { IOBuffer[spelloffset] = 0x37; spelloffset += 2; }
                if (man[i].spell[LISTPOS_TRANSPORTATION  ]) { IOBuffer[spelloffset] = 0x36; spelloffset += 2; }
                if (man[i].spell[LISTPOS_VISION          ]) { IOBuffer[spelloffset] = 0x35; spelloffset += 2; }
                if (man[i].spell[LISTPOS_MONSTER_EVALUATE]) { IOBuffer[spelloffset] = 0x34; spelloffset += 2; }
                if (man[i].spell[LISTPOS_AWAKEN          ]) { IOBuffer[spelloffset] = 0x33; spelloffset += 2; }
                if (man[i].spell[LISTPOS_NINJA_1         ]) { IOBuffer[spelloffset] = 0x32; spelloffset += 2; }
                if (man[i].spell[LISTPOS_DISPEL_UNDEAD   ]) { IOBuffer[spelloffset] = 0x31; spelloffset += 2; }
                if (man[i].spell[LISTPOS_SUMMON_ELEMENTAL]) { IOBuffer[spelloffset] = 0x30; spelloffset += 2; }
                if (man[i].spell[LISTPOS_DISSOLVE        ]) { IOBuffer[spelloffset] = 0x2F; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FEAR            ]) { IOBuffer[spelloffset] = 0x2E; spelloffset += 2; }
                if (man[i].spell[LISTPOS_NINJA_2         ]) { IOBuffer[spelloffset] = 0x2D; spelloffset += 2; }
                if (man[i].spell[LISTPOS_RESURRECTION    ]) { IOBuffer[spelloffset] = 0x2C; spelloffset += 2; }
                if (man[i].spell[LISTPOS_TELEPORTATION   ]) { IOBuffer[spelloffset] = 0x2B; spelloffset += 2; }
                if (man[i].spell[LISTPOS_SLEEP           ]) { IOBuffer[spelloffset] = 0x2A; spelloffset += 2; }
                if (man[i].spell[LISTPOS_CHARM           ]) { IOBuffer[spelloffset] = 0x29; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FLAMEBOLT_4     ]) { IOBuffer[spelloffset] = 0x28; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FLAMEBOLT_3     ]) { IOBuffer[spelloffset] = 0x27; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FLAMEBOLT_2     ]) { IOBuffer[spelloffset] = 0x26; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FLAMEBOLT_1     ]) { IOBuffer[spelloffset] = 0x25; spelloffset += 2; }
                if (man[i].spell[LISTPOS_MINDBLAST_4     ]) { IOBuffer[spelloffset] = 0x24; spelloffset += 2; }
                if (man[i].spell[LISTPOS_MINDBLAST_3     ]) { IOBuffer[spelloffset] = 0x23; spelloffset += 2; }
                if (man[i].spell[LISTPOS_MINDBLAST_2     ]) { IOBuffer[spelloffset] = 0x22; spelloffset += 2; }
                if (man[i].spell[LISTPOS_MINDBLAST_1     ]) { IOBuffer[spelloffset] = 0x21; spelloffset += 2; }
                if (man[i].spell[LISTPOS_BINDING_4       ]) { IOBuffer[spelloffset] = 0x20; spelloffset += 2; }
                if (man[i].spell[LISTPOS_BINDING_3       ]) { IOBuffer[spelloffset] = 0x1F; spelloffset += 2; }
                if (man[i].spell[LISTPOS_BINDING_2       ]) { IOBuffer[spelloffset] = 0x1E; spelloffset += 2; }
                if (man[i].spell[LISTPOS_BINDING_1       ]) { IOBuffer[spelloffset] = 0x1D; spelloffset += 2; }
                if (man[i].spell[LISTPOS_WEAKNESS_4      ]) { IOBuffer[spelloffset] = 0x1C; spelloffset += 2; }
                if (man[i].spell[LISTPOS_WEAKNESS_3      ]) { IOBuffer[spelloffset] = 0x1B; spelloffset += 2; }
                if (man[i].spell[LISTPOS_WEAKNESS_2      ]) { IOBuffer[spelloffset] = 0x1A; spelloffset += 2; }
                if (man[i].spell[LISTPOS_WEAKNESS_1      ]) { IOBuffer[spelloffset] = 0x19; spelloffset += 2; }
                if (man[i].spell[LISTPOS_CONFUSION_4     ]) { IOBuffer[spelloffset] = 0x18; spelloffset += 2; }
                if (man[i].spell[LISTPOS_CONFUSION_3     ]) { IOBuffer[spelloffset] = 0x17; spelloffset += 2; }
                if (man[i].spell[LISTPOS_CONFUSION_2     ]) { IOBuffer[spelloffset] = 0x16; spelloffset += 2; }
                if (man[i].spell[LISTPOS_CONFUSION_1     ]) { IOBuffer[spelloffset] = 0x15; spelloffset += 2; }
                if (man[i].spell[LISTPOS_PROTECTION_4    ]) { IOBuffer[spelloffset] = 0x14; spelloffset += 2; }
                if (man[i].spell[LISTPOS_PROTECTION_3    ]) { IOBuffer[spelloffset] = 0x13; spelloffset += 2; }
                if (man[i].spell[LISTPOS_PROTECTION_2    ]) { IOBuffer[spelloffset] = 0x12; spelloffset += 2; }
                if (man[i].spell[LISTPOS_PROTECTION_1    ]) { IOBuffer[spelloffset] = 0x11; spelloffset += 2; }
                if (man[i].spell[LISTPOS_P_FLAME_ARROW_2 ]) { IOBuffer[spelloffset] = 0x10; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FLAME_ARROW_2   ]) { IOBuffer[spelloffset] = 0x0F; spelloffset += 2; }
                if (man[i].spell[LISTPOS_P_FLAME_ARROW_1 ]) { IOBuffer[spelloffset] = 0x0E; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FLAME_ARROW_1   ]) { IOBuffer[spelloffset] = 0x0D; spelloffset += 2; }
                if (man[i].spell[LISTPOS_QUICKNESS_4     ]) { IOBuffer[spelloffset] = 0x0C; spelloffset += 2; }
                if (man[i].spell[LISTPOS_QUICKNESS_3     ]) { IOBuffer[spelloffset] = 0x0B; spelloffset += 2; }
                if (man[i].spell[LISTPOS_QUICKNESS_2     ]) { IOBuffer[spelloffset] = 0x0A; spelloffset += 2; }
                if (man[i].spell[LISTPOS_QUICKNESS_1     ]) { IOBuffer[spelloffset] = 0x09; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FIREFLASH_4     ]) { IOBuffer[spelloffset] = 0x08; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FIREFLASH_3     ]) { IOBuffer[spelloffset] = 0x07; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FIREFLASH_2     ]) { IOBuffer[spelloffset] = 0x06; spelloffset += 2; }
                if (man[i].spell[LISTPOS_FIREFLASH_1     ]) { IOBuffer[spelloffset] = 0x05; spelloffset += 2; }
                if (man[i].spell[LISTPOS_HEALING_4       ]) { IOBuffer[spelloffset] = 0x04; spelloffset += 2; }
                if (man[i].spell[LISTPOS_HEALING_3       ]) { IOBuffer[spelloffset] = 0x03; spelloffset += 2; }
                if (man[i].spell[LISTPOS_HEALING_2       ]) { IOBuffer[spelloffset] = 0x02; spelloffset += 2; }
                if (man[i].spell[LISTPOS_HEALING_1       ]) { IOBuffer[spelloffset] = 0x01; spelloffset += 2; }

                // clear empty spots
                while (spelloffset < (int) offset + 64)
                {   IOBuffer[spelloffset] = 0;
                    spelloffset += 2;
                }

                offset += 64;                                               //  177.. 240
                if (man[i].spell[LISTPOS_DIVINE_AID])
                {   IOBuffer[offset++] = 0x39;                              //  241
                } else
                {   IOBuffer[offset++] = 0;                                 //  241
                }
                offset++;                                                   //  242
            }

            serialize1(&man[i].head);                                       //  243
            offset++;                                                       //  244
            serialize1(&man[i].leftarm);                                    //  245
            offset++;                                                       //  246
            serialize1(&man[i].rightarm);                                   //  247
            offset++;                                                       //  248
            serialize1(&man[i].torso);                                      //  249
            offset++;                                                       //  250
            serialize1(&man[i].leftleg);                                    //  251
            offset++;                                                       //  252
            serialize1(&man[i].rightleg);                                   //  253
            serialize4(&man[i].gp);                                         //  254.. 257
            serialize4(&man[i].xp);                                         //  258.. 261

            if (serializemode == SERIALIZE_READ)
            {   man[i].purged =
                man[i].air    =
                man[i].earth  =
                man[i].fire   =
                man[i].water  =
                man[i].god    = FALSE;

                for (j = 0; j <= 8; j++)
                {   value = 0; // not really necessary
                    for (k = 0; k <= TOTALITEMS; k++)
                    {   if (items[k].p3 == man[i].equip[j])
                        {   value = k;
                            break;
                    }   }
                    man[i].equip[j] = value;
        }   }   }

        offset = 8510;
        serialize4(&partygold);                                             // 8510..8513

        offset = 8519;
        serialize1(&location_x);                                            // 8519

        offset = 8521;
        serialize1(&location_y);                                            // 8521

        offset = 8547;
        if (serializemode == SERIALIZE_READ)
        {   partylocation    =         p3location_to_var[getubyte()];       // 8547
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            IOBuffer[8527  ] = (UBYTE) location_x;                          // 8527
            IOBuffer[8529  ] = (UBYTE) location_y;                          // 8529

            IOBuffer[offset] = (UBYTE) var_to_p3location[partylocation];    // 8547

}   }   }

EXPORT void ph_die(void)
{   lb_clearlist(&ItemsList);
    lb_clearlist(&SpellsList);
}

MODULE void writespells(void)
{   ULONG        i;
    struct Node* NodePtr;

    // spells list
    SetGadgetAttrs
    (   gadgets[GID_PH_LB2],
        SubWindowPtr,
        NULL,
        LISTBROWSER_Labels, ~0,
    TAG_END);
    i = 0;
    for
    (   NodePtr = SpellsList.lh_Head;
        NodePtr->ln_Succ;
        NodePtr = NodePtr->ln_Succ
    )
    {   if
        (   (   game == PHANTASIE1 &&
                (   i == LISTPOS_ACCURACY
                 || i == LISTPOS_DIVINE_AID
                 || i == LISTPOS_FLAME_ARROW_1
                 || i == LISTPOS_FLAME_ARROW_2
                 || i == LISTPOS_P_FLAME_ARROW_1
                 || i == LISTPOS_P_FLAME_ARROW_2
                 || i == LISTPOS_PARTY_ACCURACY
            )   )
         || (   game == PHANTASIE3 &&
                (   i == LISTPOS_STRENGTH_1
                 || i == LISTPOS_STRENGTH_2
                 || i == LISTPOS_STRENGTH_3
                 || i == LISTPOS_STRENGTH_4
        )   )   )
        {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, LBFLG_READONLY | LBFLG_CUSTOMPENS, TAG_END);
            DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 0, LBNCA_FGPen, whitepen, TAG_END);
        } else
        {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags, NULL, TAG_END);
        }
        DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (BOOL) man[who].spell[i], TAG_END);
        i++;
    }
    SetGadgetAttrs
    (   gadgets[GID_PH_LB2], SubWindowPtr, NULL,
        LISTBROWSER_Labels, &SpellsList,
    TAG_END);
}

MODULE void refreshitems(void)
{   ULONG i;

    // items
    for (i = 0; i < 9; i++)
    {   if (man[who].equip[i] != 0)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_PH_BU2 + i], MainWindowPtr, NULL,
                GA_Text,     items[man[who].equip[i]].name,
                GA_Disabled, (game == PHANTASIE1 && i > 2),
            TAG_END); // this refreshes automatically
        } else
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_PH_BU2 + i], MainWindowPtr, NULL,
                GA_Text,     "-",
                GA_Disabled, (game == PHANTASIE1 && i > 2),
            TAG_END); // this refreshes automatically
}   }   }

MODULE void itemwindow(void)
{   int          i,
                 ordinal = 0;
    struct Node* NodePtr;

    submode = 0;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              "Choose Item",
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "ph-1",
        WINDOW_ParentGroup,                    gadgets[GID_PH_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_PH_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_PH_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &ItemsList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    160,
            CHILD_MinHeight,                   256,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    DISCARD SetGadgetAttrs(          gadgets[GID_PH_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,   ~0,         TAG_END);
    DISCARD SetGadgetAttrs(          gadgets[GID_PH_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,   &ItemsList, TAG_END);
    for (i = 0; i <= TOTALITEMS; i++)
    {   if (man[who].equip[whichitem] == (ULONG) i)
        {   DISCARD SetGadgetAttrs(  gadgets[GID_PH_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected, i,          TAG_END);
            ordinal = i;
            break;
    }   }
    RefreshGadgets((struct Gadget*)  gadgets[GID_PH_LB1], SubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(          gadgets[GID_PH_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,   ~0,         TAG_END);
    // assert(ItemsList.lh_Head->ln_Succ); // the list is non-empty
    i = 0;
    // Walk the list
    for
    (   NodePtr = ItemsList.lh_Head;
        NodePtr->ln_Succ;
        NodePtr = NodePtr->ln_Succ
    )
    {   if (game == PHANTASIE1)
        {   if (i == 0 || items[i].p1)
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags,  NULL, TAG_END);
            } else
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags,  LBFLG_READONLY | LBFLG_CUSTOMPENS, TAG_END);
                DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 0, LBNCA_FGPen, whitepen, TAG_END);
        }   }
        else
        {   // assert(game == PHANTASIE3);
            if (i == 0 || items[i].p3)
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags,  NULL, TAG_END);
            } else
            {   DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Flags,  LBFLG_READONLY | LBFLG_CUSTOMPENS, TAG_END);
                DISCARD SetListBrowserNodeAttrs(NodePtr, LBNA_Column, 0, LBNCA_FGPen, whitepen, TAG_END);
        }   }

        i++;
    }
    DISCARD SetGadgetAttrs(gadgets[GID_PH_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,      &ItemsList, TAG_END);
    DISCARD SetGadgetAttrs(gadgets[GID_PH_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, ordinal,    TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_PH_LB1], SubWindowPtr, NULL);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE void morewindow(void)
{   int statmax;

    submode = 1;

    if (game == PHANTASIE1)
    {   statmax  = 999;
    } else
    {   // assert(game == PHANTASIE3);
        statmax  =  22;
    }

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              "More",
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "ph-2",
        WINDOW_ParentGroup,                    gadgets[GID_PH_LY3] = (struct Gadget*)
        HLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            AddVLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,         BVS_SBAR_VERT,
                    LAYOUT_SpaceOuter,         TRUE,
                    LAYOUT_Label,              "Attributes",
                    LAYOUT_AddChild,           gadgets[GID_PH_IN6] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN6,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       statmax,
                        INTEGER_MinVisible,    2 + 1,
                        INTEGER_Number,        man[who].str,
                    IntegerEnd,
                    Label("Strength:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN7] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN7,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       statmax,
                        INTEGER_MinVisible,    2 + 1,
                        INTEGER_Number,        man[who].iq,
                    IntegerEnd,
                    Label("Intelligence:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN8] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN8,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       statmax,
                        INTEGER_MinVisible,    2 + 1,
                        INTEGER_Number,        man[who].dex,
                    IntegerEnd,
                    Label("Dexterity:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN9] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN9,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       statmax,
                        INTEGER_MinVisible,    2 + 1,
                        INTEGER_Number,        man[who].con,
                    IntegerEnd,
                    Label("Constitution:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN10] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN10,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       statmax,
                        INTEGER_MinVisible,    2 + 1,
                        INTEGER_Number,        man[who].cha,
                    IntegerEnd,
                    Label("Charisma:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN11] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN11,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       statmax,
                        INTEGER_MinVisible,    2 + 1,
                        INTEGER_Number,        man[who].luk,
                    IntegerEnd,
                    Label("Luck:"),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,         BVS_SBAR_VERT,
                    LAYOUT_SpaceOuter,         TRUE,
                    LAYOUT_Label,              "Skills",
                    LAYOUT_AddChild,           gadgets[GID_PH_IN13] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN13,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       999,
                        INTEGER_MinVisible,    3 + 1,
                        INTEGER_Number,        man[who].attack,
                    IntegerEnd,
                    Label("Attack:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN14] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN14,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       999,
                        INTEGER_MinVisible,    3 + 1,
                        INTEGER_Number,        man[who].parry,
                    IntegerEnd,
                    Label("Parry:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN15] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN15,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       999,
                        INTEGER_MinVisible,    3 + 1,
                        INTEGER_Number,        man[who].finditem,
                    IntegerEnd,
                    Label("Find Item:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN16] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN16,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       999,
                        INTEGER_MinVisible,    3 + 1,
                        INTEGER_Number,        man[who].findtrap,
                    IntegerEnd,
                    Label("Find Trap:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN17] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN17,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       999,
                        INTEGER_MinVisible,    3 + 1,
                        INTEGER_Number,        man[who].disarmtrap,
                    IntegerEnd,
                    Label("Disarm Trap:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN18] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN18,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       999,
                        INTEGER_MinVisible,    3 + 1,
                        INTEGER_Number,        man[who].listen,
                    IntegerEnd,
                    Label("Listen:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN19] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN19,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       999,
                        INTEGER_MinVisible,    3 + 1,
                        INTEGER_Number,        man[who].picklock,
                    IntegerEnd,
                    Label("Pick Lock:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN23] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN23,
                        GA_TabCycle,           TRUE,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       999,
                        INTEGER_MinVisible,    3 + 1,
                        INTEGER_Number,        man[who].swim,
                    IntegerEnd,
                    Label("Swim:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN25] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN25,
                        GA_TabCycle,           TRUE,
                        GA_Disabled,           game != PHANTASIE3,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       999,
                        INTEGER_MinVisible,    3 + 1,
                        INTEGER_Number,        man[who].firebow,
                    IntegerEnd,
                    Label("Fire Bow:"),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,         BVS_SBAR_VERT,
                    LAYOUT_SpaceOuter,         TRUE,
                    LAYOUT_Label,              "Body",
                    LAYOUT_AddChild,           gadgets[GID_PH_CH7] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                 GID_PH_CH7,
                        GA_Disabled,           game != PHANTASIE3,
                        CHOOSER_LabelArray,    &BodyOptions,
                        CHOOSER_Selected,      man[who].head,
                    PopUpEnd,
                    Label("Head:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_CH8] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                 GID_PH_CH8,
                        GA_Disabled,           game != PHANTASIE3,
                        CHOOSER_LabelArray,    &BodyOptions,
                        CHOOSER_Selected,      man[who].leftarm,
                    PopUpEnd,
                    Label("Left Arm:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_CH9] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                 GID_PH_CH9,
                        GA_Disabled,           game != PHANTASIE3,
                        CHOOSER_LabelArray,    &BodyOptions,
                        CHOOSER_Selected,      man[who].rightarm,
                    PopUpEnd,
                    Label("Right Arm:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_CH10] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                 GID_PH_CH10,
                        GA_Disabled,           game != PHANTASIE3,
                        CHOOSER_LabelArray,    &BodyOptions,
                        CHOOSER_Selected,      man[who].torso,
                    PopUpEnd,
                    Label("Torso:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_CH11] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                 GID_PH_CH11,
                        GA_Disabled,           game != PHANTASIE3,
                        CHOOSER_LabelArray,    &BodyOptions,
                        CHOOSER_Selected,      man[who].leftleg,
                    PopUpEnd,
                    Label("Left Leg:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_CH12] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                 GID_PH_CH12,
                        GA_Disabled,           game != PHANTASIE3,
                        CHOOSER_LabelArray,    &BodyOptions,
                        CHOOSER_Selected,      man[who].rightleg,
                    PopUpEnd,
                    Label("Right Leg:"),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_BevelStyle,         BVS_SBAR_VERT,
                    LAYOUT_SpaceOuter,         TRUE,
                    LAYOUT_Label,              "Runes",
                    LAYOUT_AddChild,           gadgets[GID_PH_CB1] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                 GID_PH_CB1,
                        GA_Selected,           (BOOL) man[who].air,
                        GA_Disabled,           game != PHANTASIE1,
                        GA_Text,               "Air",
                    End,
                    LAYOUT_AddChild,           gadgets[GID_PH_CB2] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                 GID_PH_CB2,
                        GA_Selected,           (BOOL) man[who].earth,
                        GA_Disabled,           game != PHANTASIE1,
                        GA_Text,               "Earth",
                    End,
                    LAYOUT_AddChild,           gadgets[GID_PH_CB3] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                 GID_PH_CB3,
                        GA_Selected,           (BOOL) man[who].fire,
                        GA_Disabled,           game != PHANTASIE1,
                        GA_Text,               "Fire",
                    End,
                    LAYOUT_AddChild,           gadgets[GID_PH_CB4] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                 GID_PH_CB4,
                        GA_Selected,           (BOOL) man[who].water,
                        GA_Disabled,           game != PHANTASIE1,
                        GA_Text,               "Water",
                    End,
                    LAYOUT_AddChild,           gadgets[GID_PH_CB5] = (struct Gadget*)
                    TickOrCheckBoxObject,
                        GA_ID,                 GID_PH_CB5,
                        GA_Selected,           (BOOL) man[who].god,
                        GA_Disabled,           game != PHANTASIE1,
                        GA_Text,               "God",
                    End,
                LayoutEnd,
            LayoutEnd,
            CHILD_WeightedWidth,               0,
            AddVLayout,
                AddVLayout,
                    LAYOUT_SpaceOuter,         TRUE,
                    LAYOUT_BevelStyle,         BVS_GROUP,
                    LAYOUT_Label,              "Quests",
                    LAYOUT_AddChild,           gadgets[GID_PH_CH14] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                 GID_PH_CH14,
                        GA_RelVerify,          TRUE,
                        GA_Disabled,           game != PHANTASIE3,
                        CHOOSER_LabelArray,    &QuestOptions,
                        CHOOSER_Selected,      man[who].quest[0],
                    ChooserEnd,
                    Label("Gelnor:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_CH15] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                 GID_PH_CH15,
                        GA_RelVerify,          TRUE,
                        GA_Disabled,           game != PHANTASIE3,
                        CHOOSER_LabelArray,    &QuestOptions,
                        CHOOSER_Selected,      man[who].quest[1],
                    ChooserEnd,
                    Label("Ferronrah:"),
                    LAYOUT_AddChild,           gadgets[GID_PH_IN30] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                 GID_PH_IN30,
                        GA_RelVerify,          TRUE,
                        GA_Disabled,           game != PHANTASIE3,
                        INTEGER_Minimum,       0,
                        INTEGER_Maximum,       5,
                        INTEGER_Number,        man[who].quest[2],
                    IntegerEnd,
                    Label("Scandor:"),
                LayoutEnd,
                CHILD_WeightedHeight,          0,
                AddVLayout,
                    LAYOUT_SpaceOuter,         TRUE,
                    LAYOUT_BevelStyle,         BVS_GROUP,
                    LAYOUT_Label,              "Spells",
                    LAYOUT_AddChild,           gadgets[GID_PH_LB2] = (struct Gadget*)
                    ListBrowserObject,
                        GA_ID,                 GID_PH_LB2,
                        LISTBROWSER_Labels,    (ULONG) &SpellsList,
                        LISTBROWSER_ShowSelected, TRUE,
                        LISTBROWSER_AutoWheel, FALSE,
                    ListBrowserEnd,
                    CHILD_MinWidth,            192,
                    HTripleButton(GID_PH_BU13, GID_PH_BU1, GID_PH_BU14),
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

    writespells();
    DISCARD ActivateLayoutGadget(gadgets[GID_PH_LY3], SubWindowPtr, NULL, (Object) gadgets[GID_PH_IN6]);

    subloop();

    GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_PH_CH7],  (ULONG*) &man[who].head);
    GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_PH_CH8],  (ULONG*) &man[who].leftarm);
    GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_PH_CH9],  (ULONG*) &man[who].rightarm);
    GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_PH_CH10], (ULONG*) &man[who].torso);
    GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_PH_CH11], (ULONG*) &man[who].leftleg);
    GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_PH_CH12], (ULONG*) &man[who].rightleg);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN6],  (ULONG*) &man[who].str);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN7],  (ULONG*) &man[who].iq);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN8],  (ULONG*) &man[who].dex);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN9],  (ULONG*) &man[who].con);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN10], (ULONG*) &man[who].cha);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN11], (ULONG*) &man[who].luk);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN13], (ULONG*) &man[who].attack);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN14], (ULONG*) &man[who].parry);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN15], (ULONG*) &man[who].finditem);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN16], (ULONG*) &man[who].findtrap);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN17], (ULONG*) &man[who].disarmtrap);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN18], (ULONG*) &man[who].listen);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN19], (ULONG*) &man[who].picklock);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN23], (ULONG*) &man[who].swim);
    GetAttr(INTEGER_Number,   (Object*) gadgets[GID_PH_IN25], (ULONG*) &man[who].firebow);
    GetAttr(GA_Selected,      (Object*) gadgets[GID_PH_CB1],  (ULONG*) &man[who].air);
    GetAttr(GA_Selected,      (Object*) gadgets[GID_PH_CB2],  (ULONG*) &man[who].earth);
    GetAttr(GA_Selected,      (Object*) gadgets[GID_PH_CB3],  (ULONG*) &man[who].fire);
    GetAttr(GA_Selected,      (Object*) gadgets[GID_PH_CB4],  (ULONG*) &man[who].water);
    GetAttr(GA_Selected,      (Object*) gadgets[GID_PH_CB5],  (ULONG*) &man[who].god);
    readspells();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG ph_subgadget(ULONG gid, UWORD code)
{   int i;

    switch (gid)
    {
    case GID_PH_LB1:
        man[who].equip[whichitem] = (ULONG) code;
        refreshitems();
        return TRUE;
    acase GID_PH_CH3:
        if (submode == 2)
        {   GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_PH_CH3], (ULONG*) &partylocation);
            if   (partylocation == CITYPOS_PENDRAGON  ) setlocation(24, 37);
            elif (partylocation == CITYPOS_SANDYSHORES) setlocation(15, 39);
            elif (partylocation == CITYPOS_PENDLETON  ) setlocation( 5, 35);
            elif (partylocation == CITYPOS_ROCKYHILLS ) setlocation(36, 42);
            elif (partylocation == CITYPOS_DELTOR     ) setlocation(44, 52);
            elif (partylocation == CITYPOS_TIRITH     ) setlocation(23, 65);
            elif (partylocation == CITYPOS_TIERRIN    ) setlocation(11, 69);
            elif (partylocation == CITYPOS_ASMITH     ) setlocation(25, 27);
            elif (partylocation == CITYPOS_SIERION    ) setlocation( 5, 51);
            elif (partylocation == CITYPOS_XANADOR    ) setlocation(45, 66);
            elif (partylocation == CITYPOS_FLAGLER    ) setlocation(45,  5);
            elif (partylocation == CITYPOS_LANSING    ) setlocation(21, 11);
            elif (partylocation == CITYPOS_SCANPORT   ) setlocation( 9,  9);
            elif (partylocation == CITYPOS_SCIATTICA  ) setlocation(15, 22);
        } else
        {   GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_PH_CH3], (ULONG*) &man[who].location);
            ph_drawmap();
        }
    acase GID_PH_IN28:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_PH_IN28], (ULONG*) &location_x);
        ph_drawmap();
    acase GID_PH_IN29:
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_PH_IN29], (ULONG*) &location_y);
        ph_drawmap();
    acase GID_PH_BU1:
        readspells();
        for (i = 0; i < TOTALSPELLS; i++)
        {   if (man[who].spell[i])
            {   man[who].spell[i] = FALSE;
            } else
            {   man[who].spell[i] = TRUE;
        }   }
        if (game == PHANTASIE1)
        {   man[who].spell[LISTPOS_ACCURACY]         =
            man[who].spell[LISTPOS_AWAKEN]           =
            man[who].spell[LISTPOS_DISPEL_UNDEAD]    =
            man[who].spell[LISTPOS_DISSOLVE]         =
            man[who].spell[LISTPOS_DIVINE_AID]       =
            man[who].spell[LISTPOS_FEAR]             =
            man[who].spell[LISTPOS_FLAME_ARROW_1]    =
            man[who].spell[LISTPOS_FLAME_ARROW_2]    =
            man[who].spell[LISTPOS_MONSTER_EVALUATE] =
            man[who].spell[LISTPOS_NINJA_1]          =
            man[who].spell[LISTPOS_NINJA_2]          =
            man[who].spell[LISTPOS_P_FLAME_ARROW_1]  =
            man[who].spell[LISTPOS_P_FLAME_ARROW_2]  =
            man[who].spell[LISTPOS_PARTY_ACCURACY]   =
            man[who].spell[LISTPOS_RESURRECTION]     =
            man[who].spell[LISTPOS_SUMMON_ELEMENTAL] =
            man[who].spell[LISTPOS_TRANSPORTATION]   =
            man[who].spell[LISTPOS_VISION]           = 0;
        } else
        {   // assert(game == PHANTASIE3);

            man[who].spell[LISTPOS_STRENGTH_1]       =
            man[who].spell[LISTPOS_STRENGTH_2]       =
            man[who].spell[LISTPOS_STRENGTH_3]       =
            man[who].spell[LISTPOS_STRENGTH_4]       = 0;
        }
        writespells();
    acase GID_PH_BU13:
    case GID_PH_BU14:
        readspells();
        for (i = 0; i < TOTALSPELLS; i++)
        {   man[who].spell[i] = ((gid == GID_PH_BU13) ? TRUE : FALSE);
        }
        if (game == PHANTASIE1)
        {   man[who].spell[LISTPOS_ACCURACY]         =
            man[who].spell[LISTPOS_AWAKEN]           =
            man[who].spell[LISTPOS_DISPEL_UNDEAD]    =
            man[who].spell[LISTPOS_DISSOLVE]         =
            man[who].spell[LISTPOS_DIVINE_AID]       =
            man[who].spell[LISTPOS_FEAR]             =
            man[who].spell[LISTPOS_FLAME_ARROW_1]    =
            man[who].spell[LISTPOS_FLAME_ARROW_2]    =
            man[who].spell[LISTPOS_MONSTER_EVALUATE] =
            man[who].spell[LISTPOS_NINJA_1]          =
            man[who].spell[LISTPOS_NINJA_2]          =
            man[who].spell[LISTPOS_P_FLAME_ARROW_1]  =
            man[who].spell[LISTPOS_P_FLAME_ARROW_2]  =
            man[who].spell[LISTPOS_PARTY_ACCURACY]   =
            man[who].spell[LISTPOS_RESURRECTION]     =
            man[who].spell[LISTPOS_SUMMON_ELEMENTAL] =
            man[who].spell[LISTPOS_TRANSPORTATION]   =
            man[who].spell[LISTPOS_VISION]           = 0;
        } else
        {   // assert(game == PHANTASIE3);

            man[who].spell[LISTPOS_STRENGTH_1]       =
            man[who].spell[LISTPOS_STRENGTH_2]       =
            man[who].spell[LISTPOS_STRENGTH_3]       =
            man[who].spell[LISTPOS_STRENGTH_4]       = 0;
        }
        writespells();
    }

    return FALSE;
}

EXPORT FLAG ph_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_LEFT:
    case SCAN_N4:
        if (submode == 2)
        {   map_leftorup(qual, mapwidth, (int*) &location_x, GID_PH_IN28, SubWindowPtr);
            setpartylocation();
            ph_drawmap();
        }
    acase SCAN_RIGHT:
    case SCAN_N6:
        if (submode == 2)
        {   map_rightordown(qual, mapwidth, (int*) &location_x, GID_PH_IN28, SubWindowPtr);
            setpartylocation();
            ph_drawmap();
        }
    acase SCAN_UP:
    case SCAN_N8:
    case NM_WHEEL_UP:
        if (submode == 0)
        {   lb_scroll_up(  GID_PH_LB1, SubWindowPtr, qual);
        } elif (submode == 2)
        {   map_leftorup(qual, mapheight, (int*) &location_y, GID_PH_IN29, SubWindowPtr);
            setpartylocation();
            ph_drawmap();
        }
    acase SCAN_DOWN:
    case SCAN_N5:
    case SCAN_N2:
    case NM_WHEEL_DOWN:
        if (submode == 0)
        {   lb_scroll_down(GID_PH_LB1, SubWindowPtr, qual);
        } elif (submode == 2)
        {   map_rightordown(qual, mapheight, (int*) &location_y, GID_PH_IN29, SubWindowPtr);
            setpartylocation();
            ph_drawmap();
        }
    acase SCAN_N1:
        if (submode == 2)
        {   map_leftorup(qual, mapwidth, (int*) &location_x, GID_PH_IN28, SubWindowPtr);
            map_rightordown(qual, mapheight, (int*) &location_y, GID_PH_IN29, SubWindowPtr);
            setpartylocation();
            ph_drawmap();
        }
    acase SCAN_N3:
        if (submode == 2)
        {   map_rightordown(qual, mapwidth, (int*) &location_x, GID_PH_IN28, SubWindowPtr);
            map_rightordown(qual, mapheight, (int*) &location_y, GID_PH_IN29, SubWindowPtr);
            setpartylocation();
            ph_drawmap();
        }
    acase SCAN_N7:
        if (submode == 2)
        {   map_leftorup(qual, mapwidth, (int*) &location_x, GID_PH_IN28, SubWindowPtr);
            map_leftorup(qual, mapheight, (int*) &location_y, GID_PH_IN29, SubWindowPtr);
            setpartylocation();
            ph_drawmap();
        }
    acase SCAN_N9:
        if (submode == 2)
        {   map_rightordown(qual, mapwidth, (int*) &location_x, GID_PH_IN28, SubWindowPtr);
            map_leftorup(qual, mapheight, (int*) &location_y, GID_PH_IN29, SubWindowPtr);
            setpartylocation();
            ph_drawmap();
    }   }

    return FALSE;
}

MODULE void setlocation(SLONG x, SLONG y)
{   location_x = x;
    location_y = y;

    DISCARD SetGadgetAttrs
    (   gadgets[GID_PH_IN28], SubWindowPtr, NULL,
        INTEGER_Number, location_x,
    TAG_END);
    DISCARD SetGadgetAttrs
    (   gadgets[GID_PH_IN29], SubWindowPtr, NULL,
        INTEGER_Number, location_y,
    TAG_END);

    ph_drawmap();
}

MODULE void condense(void)
{   ULONG i, j,
          chars,
          slots,
          which;

    if (game == PHANTASIE1)
    {   slots = 3;
        chars = 25;
    } else
    {   // assert(game == PHANTASIE3);
        slots = 9;
        chars = 32;
    }

    for (i = 0; i < chars; i++)
    {   which = 0;
        for (j = 0; j < slots; j++)
        {   if (which < slots)
            {   while (man[i].equip[which] == 0 && which < slots)
                {   which++;
                }
                man[i].equip[j] = man[i].equip[which];
                which++;
            } else
            {   man[i].equip[j] = 0;
    }   }   }

    refreshitems();
}

MODULE void maximize_man(int whichman)
{   int i;

    man[whichman].air   =
    man[whichman].earth =
    man[whichman].fire  =
    man[whichman].water =
    man[whichman].god   = TRUE;

    for (i = 0; i < TOTALSPELLS; i++)
    {   man[whichman].spell[i] = FALSE;
    }
    if (game == PHANTASIE1)
    {   man[whichman].spell[LISTPOS_BINDING_1]        =
        man[whichman].spell[LISTPOS_BINDING_2]        =
        man[whichman].spell[LISTPOS_BINDING_3]        =
        man[whichman].spell[LISTPOS_BINDING_4]        =
        man[whichman].spell[LISTPOS_CHARM]            =
        man[whichman].spell[LISTPOS_CONFUSION_1]      =
        man[whichman].spell[LISTPOS_CONFUSION_2]      =
        man[whichman].spell[LISTPOS_CONFUSION_3]      =
        man[whichman].spell[LISTPOS_CONFUSION_4]      =
        man[whichman].spell[LISTPOS_FIREFLASH_1]      =
        man[whichman].spell[LISTPOS_FIREFLASH_2]      =
        man[whichman].spell[LISTPOS_FIREFLASH_3]      =
        man[whichman].spell[LISTPOS_FIREFLASH_4]      =
        man[whichman].spell[LISTPOS_FLAMEBOLT_1]      =
        man[whichman].spell[LISTPOS_FLAMEBOLT_2]      =
        man[whichman].spell[LISTPOS_FLAMEBOLT_3]      =
        man[whichman].spell[LISTPOS_FLAMEBOLT_4]      =
        man[whichman].spell[LISTPOS_HEALING_1]        =
        man[whichman].spell[LISTPOS_HEALING_2]        =
        man[whichman].spell[LISTPOS_HEALING_3]        =
        man[whichman].spell[LISTPOS_HEALING_4]        =
        man[whichman].spell[LISTPOS_MINDBLAST_1]      =
        man[whichman].spell[LISTPOS_MINDBLAST_2]      =
        man[whichman].spell[LISTPOS_MINDBLAST_3]      =
        man[whichman].spell[LISTPOS_MINDBLAST_4]      =
        man[whichman].spell[LISTPOS_PROTECTION_1]     =
        man[whichman].spell[LISTPOS_PROTECTION_2]     =
        man[whichman].spell[LISTPOS_PROTECTION_3]     =
        man[whichman].spell[LISTPOS_PROTECTION_4]     =
        man[whichman].spell[LISTPOS_QUICKNESS_1]      =
        man[whichman].spell[LISTPOS_QUICKNESS_2]      =
        man[whichman].spell[LISTPOS_QUICKNESS_3]      =
        man[whichman].spell[LISTPOS_QUICKNESS_4]      =
        man[whichman].spell[LISTPOS_SLEEP]            =
        man[whichman].spell[LISTPOS_STRENGTH_1]       =
        man[whichman].spell[LISTPOS_STRENGTH_2]       =
        man[whichman].spell[LISTPOS_STRENGTH_3]       =
        man[whichman].spell[LISTPOS_STRENGTH_4]       =
        man[whichman].spell[LISTPOS_TELEPORTATION]    =
        man[whichman].spell[LISTPOS_WEAKNESS_1]       =
        man[whichman].spell[LISTPOS_WEAKNESS_2]       =
        man[whichman].spell[LISTPOS_WEAKNESS_3]       =
        man[whichman].spell[LISTPOS_WEAKNESS_4]       = TRUE;
    } else
    {   // assert(game == PHANTASIE3);
        man[whichman].spell[LISTPOS_ACCURACY]         = //  0
        man[whichman].spell[LISTPOS_AWAKEN]           =
        man[whichman].spell[LISTPOS_BINDING_4]        =
        man[whichman].spell[LISTPOS_CHARM]            =
        man[whichman].spell[LISTPOS_CONFUSION_4]      =
        man[whichman].spell[LISTPOS_DISPEL_UNDEAD]    =
        man[whichman].spell[LISTPOS_DISSOLVE]         =
        man[whichman].spell[LISTPOS_DIVINE_AID]       =
        man[whichman].spell[LISTPOS_FEAR]             =
        man[whichman].spell[LISTPOS_FIREFLASH_3]      =
        man[whichman].spell[LISTPOS_FIREFLASH_4]      = // 10
        man[whichman].spell[LISTPOS_FLAME_ARROW_2]    =
        man[whichman].spell[LISTPOS_FLAMEBOLT_3]      =
        man[whichman].spell[LISTPOS_FLAMEBOLT_4]      =
        man[whichman].spell[LISTPOS_HEALING_3]        =
        man[whichman].spell[LISTPOS_HEALING_4]        =
        man[whichman].spell[LISTPOS_MINDBLAST_3]      =
        man[whichman].spell[LISTPOS_MINDBLAST_4]      =
        man[whichman].spell[LISTPOS_MONSTER_EVALUATE] =
        man[whichman].spell[LISTPOS_NINJA_2]          =
        man[whichman].spell[LISTPOS_PARTY_ACCURACY]   = // 20
        man[whichman].spell[LISTPOS_P_FLAME_ARROW_2]  =
        man[whichman].spell[LISTPOS_PROTECTION_3]     =
        man[whichman].spell[LISTPOS_PROTECTION_4]     =
        man[whichman].spell[LISTPOS_QUICKNESS_4]      =
        man[whichman].spell[LISTPOS_RESURRECTION]     =
        man[whichman].spell[LISTPOS_SLEEP]            =
        man[whichman].spell[LISTPOS_SUMMON_ELEMENTAL] =
        man[whichman].spell[LISTPOS_TELEPORTATION]    =
        man[whichman].spell[LISTPOS_TRANSPORTATION]   =
        man[whichman].spell[LISTPOS_VISION]           = // 30
        man[whichman].spell[LISTPOS_WEAKNESS_4]       = TRUE; // 31
    }

    man[whichman].head       =
    man[whichman].leftarm    =
    man[whichman].rightarm   =
    man[whichman].torso      =
    man[whichman].leftleg    =
    man[whichman].rightleg   =         0;

    man[whichman].status     =         1; // OK

    man[whichman].quest[0]   =
    man[whichman].quest[1]   =         2; // won

    man[whichman].quest[2]   =
    man[whichman].social     =         5; // superhero

    man[whichman].level      =        21;

    man[whichman].str        =
    man[whichman].iq         =
    man[whichman].dex        =
    man[whichman].con        =
    man[whichman].cha        =
    man[whichman].luk        =        22;

    man[whichman].score      =
    man[whichman].maxhp      =
    man[whichman].curhp      =
    man[whichman].maxsp      =
    man[whichman].cursp      =
    man[whichman].attack     =
    man[whichman].parry      =
    man[whichman].finditem   =
    man[whichman].findtrap   =
    man[whichman].disarmtrap =
    man[whichman].listen     =
    man[whichman].picklock   =
    man[whichman].swim       =
    man[whichman].firebow    =       900;

    man[whichman].gp         =
    man[whichman].xp         = 900000000;

    // we should do items too
}

EXPORT void ph_exit(void)
{   ch_clearlist(&StatusList);
}

EXPORT void ph_key(UBYTE scancode, UWORD qual)
{   int i,
        oldrace;

    oldrace = man[who].race;

    switch (scancode)
    {
    case SCAN_LEFT:
    case NM_WHEEL_UP:
        if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT) || (qual & IEQUALIFIER_CONTROL))
        {   man[who].race = 0;
        } elif (game == PHANTASIE1 && man[who].race == 2)
        {   man[who].race = 0;
        } elif (man[who].race > 0)
        {   man[who].race--;
        }
    acase SCAN_RIGHT:
    case NM_WHEEL_DOWN:
        if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT) || (qual & IEQUALIFIER_CONTROL))
        {   man[who].race = 16;
        } elif (game == PHANTASIE1 && man[who].race == 0)
        {   man[who].race = 2;
        } elif (man[who].race < 16)
        {   man[who].race++;
    }   }

    if (man[who].race != (ULONG) oldrace)
    {   for (i = 0; i < 17; i++)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_PH_BU15 + i], MainWindowPtr, NULL,
                GA_Selected, (man[who].race == (ULONG) i)   ? TRUE : FALSE,
            TAG_END);
}   }   }

EXPORT void ph_close(void) { ; }

MODULE void mapwindow(void)
{   // assert(submode == 2 || submode == 3);

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (submode == 2)
    {   if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                                  "Party Location",
            WINDOW_Position,                           WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                           "ph-3",
            WINDOW_ParentGroup,                        gadgets[GID_PH_LY4] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                     TRUE,
                AddHLayout,
                    AddSpace,
                    LAYOUT_AddChild,                   gadgets[GID_PH_SP1] = (struct Gadget*)
                    SpaceObject,
                        GA_ID,                         GID_PH_SP1,
                        SPACE_MinWidth,                SCALEDWIDTH,
                        SPACE_MinHeight,               SCALEDHEIGHT,
                        SPACE_BevelStyle,              BVS_FIELD,
                        SPACE_Transparent,             TRUE,
                    SpaceEnd,
                    CHILD_WeightedWidth,               0,
                    CHILD_WeightedHeight,              0,
                    AddSpace,
                LayoutEnd,
                LAYOUT_AddChild,                       gadgets[GID_PH_ST2] = (struct Gadget*)
                StringObject,
                    GA_ID,                             GID_PH_ST2,
                    GA_ReadOnly,                       TRUE,
                    STRINGA_TextVal,                   "",
                    STRINGA_MaxChars,                  40 + 1,
                StringEnd,
                Label("Contents:"),
                AddHLayout,
                    LAYOUT_HorizAlignment,             LALIGN_CENTER,
                    LAYOUT_VertAlignment,              LALIGN_CENTER,
                    AddLabel("X:"),
                    LAYOUT_AddChild,                   gadgets[GID_PH_IN28] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_PH_IN28,
                        GA_TabCycle,                   TRUE,
                        GA_RelVerify,                  TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               mapwidth - 1,
                        INTEGER_MinVisible,            2 + 1,
                        INTEGER_Number,                location_x,
                    IntegerEnd,
                    AddLabel("Y:"),
                    LAYOUT_AddChild,                   gadgets[GID_PH_IN29] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                         GID_PH_IN29,
                        GA_TabCycle,                   TRUE,
                        GA_RelVerify,                  TRUE,
                        INTEGER_Minimum,               0,
                        INTEGER_Maximum,               mapheight - 1,
                        INTEGER_MinVisible,            2 + 1,
                        INTEGER_Number,                location_y,
                    IntegerEnd,
                    AddLabel("Town:"),
                    LAYOUT_AddChild,                   gadgets[GID_PH_CH3] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                         GID_PH_CH3,
                        GA_RelVerify,                  TRUE,
                        CHOOSER_LabelArray,            &LocationOptions[game],
                        CHOOSER_MaxLabels,             17,
                        CHOOSER_Selected,              partylocation,
                    PopUpEnd,
                LayoutEnd,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
    }   }
    else
    {   if (!(SubWinObject =
        NewSubWindow,
            WA_Title,                                  "Character Location",
            WINDOW_Position,                           WPOS_CENTERMOUSE,
            WINDOW_UniqueID,                           "ph-4",
            WINDOW_ParentGroup,                        gadgets[GID_PH_LY3] = (struct Gadget*)
            VLayoutObject,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_AddChild,                       gadgets[GID_PH_SP1] = (struct Gadget*)
                SpaceObject,
                    GA_ID,                             GID_PH_SP1,
                    SPACE_MinWidth,                    SCALEDWIDTH,
                    SPACE_MinHeight,                   SCALEDHEIGHT,
                    SPACE_BevelStyle,                  BVS_NONE,
                    SPACE_Transparent,                 TRUE,
                SpaceEnd,
                LAYOUT_AddChild,                       gadgets[GID_PH_CH3] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                             GID_PH_CH3,
                    GA_RelVerify,                      TRUE,
                    CHOOSER_LabelArray,                &LocationOptions[game],
                    CHOOSER_MaxLabels,                 17,
                    CHOOSER_Selected,                  man[who].location,
                PopUpEnd,
                Label("Town:"),
                CHILD_WeightedHeight,                  0,
            LayoutEnd,
        WindowEnd))
        {   rq("Can't create gadgets!");
    }   }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    setup_bm(0, SCALEDWIDTH, SCALEDHEIGHT, SubWindowPtr);
    ph_drawmap();

 // DISCARD ActivateLayoutGadget(gadgets[GID_PH_LY4], SubWindowPtr, NULL, (Object) gadgets[GID_PH_IN28]);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;

    free_bm(0);
}

EXPORT void ph_drawmap(void)
{   TRANSIENT int  x, y;
    PERSIST   TEXT desc[40 + 1];

    if (game == PHANTASIE1)
    {   for (y = 0; y < mapheight; y++)
        {   for (x = 0; x < mapwidth; x++)
            {   switch (p1_map[y][x])
                {
                case  '.': drawpoint(x, y,  0); // blue
                acase ',': drawpoint(x, y, 11); // dark blue
                acase '#': drawpoint(x, y,  1); // dark green
                acase '-': drawpoint(x, y,  3); // light green
                acase '%': drawpoint(x, y,  7); // orange
                acase '*': drawpoint(x, y,  5); // purple
                acase '!': drawpoint(x, y,  9); // red
                acase '+': drawpoint(x, y,  4); // dark grey
                acase '^': drawpoint(x, y,  8); // light grey
                acase '/': drawpoint(x, y,  2); // yellow
        }   }   }

        if (man[who].location != 11) // ie. not Olympia
        {   for (x = 0; x < mapwidth; x++)
            {   if (x != (int) p1towns[man[who].location].x)
                {   drawpoint(x, p1towns[man[who].location].y, 6);
            }   }
            for (y = 0; y < mapheight; y++)
            {   if (y != (int) p1towns[man[who].location].y)
                {   drawpoint(p1towns[man[who].location].x, y, 6);
    }   }   }   }
    else
    {   for (y = 0; y < mapheight; y++)
        {   for (x = 0; x < mapwidth; x++)
            {   switch (p3_map[y][x])
                {
                case  '.': drawpoint(x, y,  0); // blue
                acase '#': drawpoint(x, y,  1); // dark green
                acase '&': drawpoint(x, y,  2); // yellow
                acase '-': drawpoint(x, y,  3); // light green
                acase '%': drawpoint(x, y,  4); // dark grey
                acase '*': drawpoint(x, y,  5); // purple
                acase '+':
                case  '=': drawpoint(x, y,  7); // orange
                acase '^': drawpoint(x, y,  8); // light grey
                acase '!': drawpoint(x, y,  9); // red
                acase '$': drawpoint(x, y, 10); // cyan
        }   }   }

        if (submode == 3)
        {   if (man[who].location != 1 && man[who].location != 2 && man[who].location != 6)
            {   for (x = 0; x < mapwidth; x++)
                {   if (x != (int) p3towns[man[who].location].x)
                    {   drawpoint(x, p3towns[man[who].location].y, 6);
                }   }
                for (y = 0; y < mapheight; y++)
                {   if (y != (int) p3towns[man[who].location].y)
                    {   drawpoint(p3towns[man[who].location].x, y, 6);
        }   }   }   }
        else
        {   // assert(submode == 2);
            for (x = 0; x < mapwidth; x++)
            {   if (x != (int) location_x)
                {   drawpoint(x, location_y, 6);
            }   }
            for (y = 0; y < mapheight; y++)
            {   if (y != (int) location_y)
                {   drawpoint(location_x, y, 6);
            }   }

            switch (p3_map[location_y][location_x])
            {
            case  '.': strcpy( desc, "Water");
            acase '#': strcpy( desc, "Forest");
            acase '&': strcpy( desc, "Desert");
            acase '-': strcpy( desc, "Meadows");
            acase '%': strcpy( desc, "Hills");
            acase '*': sprintf(desc, "Dungeon (%s)", specialdesc(location_x, location_y));
            acase '+': strcpy( desc, "Pathway");
            acase '=': strcpy( desc, "Bridge");
            acase '^': strcpy( desc, "Mountains");
            acase '!': sprintf(desc, "Town (%s)", specialdesc(location_x, location_y));
            acase '$': sprintf(desc, "Inn (%s)", specialdesc(location_x, location_y));
            }
            DISCARD SetGadgetAttrs
            (   gadgets[GID_PH_ST2],
                SubWindowPtr, NULL,
                STRINGA_TextVal, desc,
            TAG_END); // this autorefreshes
    }   }

    DISCARD WritePixelArray8
    (   SubWindowPtr->RPort,
        gadgets[GID_PH_SP1]->LeftEdge,
        gadgets[GID_PH_SP1]->TopEdge,
        gadgets[GID_PH_SP1]->LeftEdge + SCALEDWIDTH  - 1,
        gadgets[GID_PH_SP1]->TopEdge  + SCALEDHEIGHT - 1,
        display1,
        &wpa8rastport[0]
    );
}

MODULE void drawpoint(int x, int y, int colour)
{   int xx, yy;

    for (yy = 0; yy < MAPSCALE; yy++)
    {   for (xx = 0; xx < MAPSCALE; xx++)
        {   *(byteptr1[(y * MAPSCALE) + yy] + (x * MAPSCALE) + xx) = pens[colour];
}   }   }

EXPORT void ph_getpens(void)
{   lockscreen();

    pens[ 0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xFFFFFFFF, -1); // blue
    pens[ 1] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x88888888, 0x00000000, -1); // dark green
    pens[ 2] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, -1); // yellow
    pens[ 3] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xFFFFFFFF, 0x00000000, -1); // light green
    pens[ 4] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x55555555, 0x55555555, 0x55555555, -1); // dark grey
    pens[ 5] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFF, -1); // purple
    pens[ 6] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1); // white
    pens[ 7] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x88888888, 0x00000000, -1); // orange
    pens[ 8] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xBBBBBBBB, 0xBBBBBBBB, 0xBBBBBBBB, -1); // light grey
    pens[ 9] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0x00000000, 0x00000000, -1); // red
    pens[10] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0xFFFFFFFF, 0xFFFFFFFF, -1); // cyan
    pens[11] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x00000000, 0x00000000, 0xAAAAAAAA, -1); // dark blue

    unlockscreen();
}

EXPORT void ph_sublmb(SWORD mousex, SWORD mousey)
{   if
    (   submode != 2
     || mousex < gadgets[GID_PH_SP1]->LeftEdge
     || mousey < gadgets[GID_PH_SP1]->TopEdge
     || mousex > gadgets[GID_PH_SP1]->LeftEdge + SCALEDWIDTH  - 1
     || mousey > gadgets[GID_PH_SP1]->TopEdge  + SCALEDHEIGHT - 1
    )
    {   return;
    }

    location_x = (mousex - gadgets[GID_PH_SP1]->LeftEdge) / MAPSCALE;
    location_y = (mousey - gadgets[GID_PH_SP1]->TopEdge ) / MAPSCALE;
    DISCARD SetGadgetAttrs(gadgets[GID_PH_IN28], SubWindowPtr, NULL, INTEGER_Number, location_x, TAG_END); // this autorefreshes
    DISCARD SetGadgetAttrs(gadgets[GID_PH_IN29], SubWindowPtr, NULL, INTEGER_Number, location_y, TAG_END); // this autorefreshes

    setpartylocation();
    ph_drawmap();
}

MODULE STRPTR specialdesc(int x, int y)
{   int i;

    for (i = 0; i < DESCS; i++)
    {   if
        (   x == specialdescs[i].x
         && y == specialdescs[i].y
        )
        {   return specialdescs[i].desc;
    }   }

    return "unknown"; // should never happen
}

MODULE void setpartylocation(void)
{   int i;

    // assert(SubWindowPtr);
    // assert(submode == 2);
    // assert(game == PHANTASIE3);

    for (i = 0; i < TOWNS; i++)
    {   if
        (   location_x == (ULONG) specialdescs[i].x
         && location_y == (ULONG) specialdescs[i].y
        )
        {   partylocation = specialdescs[i].pos;
            DISCARD SetGadgetAttrs
            (   gadgets[GID_PH_CH3], SubWindowPtr, NULL,
                CHOOSER_Selected, partylocation,
            TAG_END); // we must explicitly refresh
            RefreshGadgets((struct Gadget*) gadgets[GID_PH_CH3], SubWindowPtr, NULL);
            return; // for speed
}   }   }

EXPORT void ph_subtick(SWORD mousex, SWORD mousey)
{   if (submode == 2 && mouseisover(GID_PH_SP1, mousex, mousey))
    {   setpointer(TRUE , SubWinObject, SubWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, SubWinObject, SubWindowPtr, FALSE);
}   }

MODULE void readspells(void)
{   int          i = 0;
    struct Node* NodePtr;

    for
    (   NodePtr = SpellsList.lh_Head;
        NodePtr->ln_Succ;
        NodePtr = NodePtr->ln_Succ
    )
    {   DISCARD GetListBrowserNodeAttrs(NodePtr, LBNA_Checked, (ULONG*) &man[who].spell[i]);
        i++;
}   }

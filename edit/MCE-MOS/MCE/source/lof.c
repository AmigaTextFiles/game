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
#define GID_LOF_LY1    0 // root layout
#define GID_LOF_ST1    1 // string 1
#define GID_LOF_IN1    2 // str
#define GID_LOF_IN2    3 // int
#define GID_LOF_IN3    4 // wis
#define GID_LOF_IN4    5 // dex
#define GID_LOF_IN5    6 // man
#define GID_LOF_IN6    7 // men
#define GID_LOF_IN7    8 // level
#define GID_LOF_IN8    9 // con
#define GID_LOF_IN9   10 // 1st ability
#define GID_LOF_IN10  11
#define GID_LOF_IN11  12
#define GID_LOF_IN12  13
#define GID_LOF_IN13  14
#define GID_LOF_IN14  15
#define GID_LOF_IN15  16
#define GID_LOF_IN16  17
#define GID_LOF_IN17  18 // 9th ability
#define GID_LOF_IN18  19 // XP
#define GID_LOF_IN19  20 // gold carried
#define GID_LOF_IN20  21 // gold in bank
#define GID_LOF_IN21  22 // food
#define GID_LOF_CH1   23 // race
#define GID_LOF_CH2   24 // trade
#define GID_LOF_CH3   25 // sex
#define GID_LOF_CH4   26 // alignment
#define GID_LOF_BU1   27 // maximize character
#define GID_LOF_BU2   28 // maximize party
#define GID_LOF_BU3   29 // 1st item
#define GID_LOF_BU4   30
#define GID_LOF_BU5   31
#define GID_LOF_BU6   32
#define GID_LOF_BU7   33
#define GID_LOF_BU8   34
#define GID_LOF_BU9   35
#define GID_LOF_BU10  36
#define GID_LOF_BU11  37
#define GID_LOF_BU12  38
#define GID_LOF_BU13  39
#define GID_LOF_BU14  40
#define GID_LOF_BU15  41
#define GID_LOF_BU16  42
#define GID_LOF_BU17  43
#define GID_LOF_BU18  44
#define GID_LOF_BU19  45
#define GID_LOF_BU20  46
#define GID_LOF_BU21  47
#define GID_LOF_BU22  48
#define GID_LOF_BU23  49
#define GID_LOF_BU24  50
#define GID_LOF_BU25  51
#define GID_LOF_BU26  52
#define GID_LOF_BU27  53
#define GID_LOF_BU28  54
#define GID_LOF_BU29  55
#define GID_LOF_BU30  56
#define GID_LOF_BU31  57
#define GID_LOF_BU32  58
#define GID_LOF_BU33  59
#define GID_LOF_BU34  60
#define GID_LOF_BU35  61
#define GID_LOF_BU36  62
#define GID_LOF_BU37  63
#define GID_LOF_BU38  64
#define GID_LOF_BU39  65
#define GID_LOF_BU40  66
#define GID_LOF_BU41  67
#define GID_LOF_BU42  68
#define GID_LOF_BU43  69
#define GID_LOF_BU44  70
#define GID_LOF_BU45  71
#define GID_LOF_BU46  72
#define GID_LOF_BU47  73
#define GID_LOF_BU48  74
#define GID_LOF_BU49  75
#define GID_LOF_BU50  76 // 48th item
#define GID_LOF_SB1   77
#define GID_LOF_CB1   78 // 1st language
#define GID_LOF_CB2   79
#define GID_LOF_CB3   80
#define GID_LOF_CB4   81
#define GID_LOF_CB5   82
#define GID_LOF_CB6   83
#define GID_LOF_CB7   84
#define GID_LOF_CB8   85 // 8th language
#define GID_LOF_CB9   86 // 1st item
#define GID_LOF_CB10  87
#define GID_LOF_CB11  88
#define GID_LOF_CB12  89
#define GID_LOF_CB13  90
#define GID_LOF_CB14  91
#define GID_LOF_CB15  92
#define GID_LOF_CB16  93
#define GID_LOF_CB17  94
#define GID_LOF_CB18  95
#define GID_LOF_CB19  96
#define GID_LOF_CB20  97
#define GID_LOF_CB21  98
#define GID_LOF_CB22  99
#define GID_LOF_CB23 100
#define GID_LOF_CB24 101
#define GID_LOF_CB25 102
#define GID_LOF_CB26 103
#define GID_LOF_CB27 104
#define GID_LOF_CB28 105
#define GID_LOF_CB29 106
#define GID_LOF_CB30 107
#define GID_LOF_CB31 108
#define GID_LOF_CB32 109
#define GID_LOF_CB33 110
#define GID_LOF_CB34 111
#define GID_LOF_CB35 112
#define GID_LOF_CB36 113
#define GID_LOF_CB37 114
#define GID_LOF_CB38 115
#define GID_LOF_CB39 116
#define GID_LOF_CB40 117
#define GID_LOF_CB41 118
#define GID_LOF_CB42 119
#define GID_LOF_CB43 120
#define GID_LOF_CB44 121
#define GID_LOF_CB45 122
#define GID_LOF_CB46 123
#define GID_LOF_CB47 124
#define GID_LOF_CB48 125
#define GID_LOF_CB49 126
#define GID_LOF_CB50 127
#define GID_LOF_CB51 128
#define GID_LOF_CB52 129
#define GID_LOF_CB53 130
#define GID_LOF_CB54 131
#define GID_LOF_CB55 132
#define GID_LOF_CB56 133 // 48th item
#define GID_LOF_IN22 134 // current hp
#define GID_LOF_IN23 135 // maximum hp

// items subwindow
#define GID_LOF_LY2  136
#define GID_LOF_LB1  137

#define GIDS_LOF     GID_LOF_LB1

#define ItemButton(x)    LAYOUT_AddChild, gadgets[x] = (struct Gadget*) ZButtonObject,        GA_ID, x, GA_RelVerify, TRUE, BUTTON_Justification, BCJ_LEFT, ButtonEnd
#define EquippedCheck(x) LAYOUT_AddChild, gadgets[x] = (struct Gadget*) TickOrCheckBoxObject, GA_ID, x, End

#define ITEMS        0xBA

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void writegadgets(void);
MODULE void readman(void);
MODULE void writeman(void);
MODULE void maximize_man(int whichman);
MODULE LONG CheckSum(UBYTE* Block, int Length);
MODULE void olaf_to_ra(void);
MODULE void ra_to_olaf(void);
MODULE void itemwindow(void);
MODULE void eithergadgets(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
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
IMPORT struct List          SexList,
                            SpeedBarList;
IMPORT struct Menu*         MenuPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
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

MODULE int                  whichitem;
MODULE struct List          ItemsList;
MODULE ULONG                men,
                            who;
MODULE TEXT                 itemdisplay[48][40 + 1];
MODULE const STRPTR         TradeOptions[] =
{ "Warrior",
  "Barbarian",
  "Rogue",
  "Smith",
  "Scout",
  "Priest",
  "Druid",
  "Magician",
  "Illusionist",
  "Paladin",
  "Ranger",
  "Healer",
  "Monk",
  NULL
}, RaceOptions[] =
{ "Human",
  "Half-Elf",
  "Elf",
  "Halfling",
  "Dwarf",
  "Half-Orc",
  NULL
}, AlignmentOptions[] =
{ "Lawful",
  "Chaotic",
  NULL
}, ItemNames[ITEMS] =
{ "-",
  "Club",             //  10#
  "War scythe",       //   7#
  "Hand axe",         //   5#
  "Footman's flail",  //   8#
  "Footman's mace",   //   8#
  "Trident",          //   4#
  "Quarterstaff",
  "Warhammer",
  "Morning star",
  "Battle axe",
  "Battle flail",
  "Rapier",
  "Short sword",
  "Broadsword",
  "Bardiche",
  "Bastard sword",    //  12#
  "Two-handed sword", //  45#
  "Sling",            //   1#
  "Bullets",          //   1#
  "Short bow",        //   6#
  "Short arrows",     //   1#
  "Long bow",         //  12#
  "Long arrows",      //   1#
  "Crossbow",         //  10#
  "Bolts",            //   1#
  "Robe",
  "Leather armour",
  "Studded leather",  //  20#
  "Scale mail",       //  40#
  "Chain mail",       //  30#
  "Ring mail",        //  35#
  "Plate mail",       //  45#
  "Full plate",       //  65#
  "Small shield",
  "Large shield",     //   9#
  "Tinderbox",        //   1#
  "Torch",            //   4#
  "Flask of oil",     //   1#
  "Lantern",          //   1#
  "Spellbook",
  "Holy symbol",      //   1#
  "Thieves' picks",   //   1#
  "Anvil",
  "Sledgehammer",
  "Barbarian axe",    //  47#
  "Potion #1",        //   1#
  "Potion #2",        //   1#
  "Potion #3",        //   1#
  "Potion #4",        //   2#
  "Shield ring",      //   1#
  "Elven chain",      //  15#
  "Potion #5",        //   1#
  "Potion #6",        //   1#
  "Potion #7",        //   2#
  "Protecting ring",  //   1#
  "Potion #8",        //   1#
  "Potion #9",        //   1#
  "Potion #10",       //   1#
  "Potion #11",       //   1#
  "Scroll #1",        //   1#
  "Friendship ring",  //   1#
  "Scroll #2",        //   1#
  "Ring of Kybol",    //   1#
  "Striking staff",
  "Polymorph wand",
  "Scroll #3",
  "Potion #12",
  "Strength ring",
  "Healers' staff",
  "Rod of fear",
  "Potion #13",
  "Potion #14",
  "Lightbringer",
  "Staff of sun",
  "Blade of power",
  "Storm sceptre",
  "Catchpole's hlt",
  "Staff of age",
  "Staff of death",
  "Ring of shelter",  //   1#
  "Antimagic ring",   //   1#
  "Staff of life",    //   1#
  "Inquisitor",       //   6#
  "Stonesword",       //  25#
  "Crystal sword",    //  12#
  "Gods' hammer",     //  10#
  "Elven bow",        //   8#
  "David's sling",    //   1#
  "Crystal ball",     //   2#
  "Elven cloak",      //   4#
  "Drum of fear",     //   4#
  "1st Bookhalf",     //   1#
  "2nd Bookhalf",     //   1#
  "The Emerald",      //   1#
  "The Corona",       //   1#
  "The Keystaff",     //   1#
  "Papyrus scroll",   //   1#
  "Mithril ball",     //   1#
  "Death mask",       //   1#
  "Sarcophagus",      // 300#
  "Pergament",        //   1#
  "Scroll #4",        //   1#
  "Shaolinstaff",     //   4#
  "Dragon chain",     //  30#
  "Dragon plate",     //  40#
  "Dragon leather",   //   8#
  "Book of herbs",    //   3#
  "Book of stars",    //   3#
  "Crafts",           //   3#
  "Lord of rinse",    //   7#
  "Orthografy",       //   3#
  "Spade",            //   7#
  "Gunpowder",        //   1#
  "Leather pouch",    //   1#
  "Small shield +1",  //   4#
  "Broadsword +2 #1", //   8#
  "Rope",             //   1#
  "Large shield +1",  //  10#
  "Scroll #5",        //   1#
  "The Amulet",       //   1#
  "Broadsword +1",    //   8#
  "Broadsword +2 #2", //   8#
  "Long arrows +2",   //   1#
  "Talisman",         //   1#
  "Crystal wedge",    //   1#
  "Scroll #6",        //   1#
  "Potion #15",       //   1#
  "Quarterstaff +1",  //   4#
  "Staff of light",   //   1#
  "Document",         //   1#
  "Full plate",       //  60#
  "Bucket of sand",   //   1#
  "Golden key",       //   1#
  "12 rations",       //   6#
  "Count Dracula",    //   7#
  "The capital",      //   7#
  "Golden casket",    //  20#
  "Chest",            //  35#
  "Nugget",           //   1#
  "Big Nugget",       //   7#
  "Lump of Adamit #1",//   5#
  "Blue map",         //   1#
  "Small map",        //   1#
  "Strange map",      //   1#
  "Map scrap",        //   1#
  "Old map",          //   1#
  "Boring map",       //   1#
  "Lump of Adamit #2",//   3#
  "Stone key",        //   1#
  "Mirrorshield",     //   7#
  "Steel key",        //   1#
  "Copper key",       //   1#
  "Coal sack",        //  15#
  "Iron key",         //   1#
  "Ring key",         //   1#
  "Ruby key",         //   1#
  "Sacred dagger",    //   2#
  "Key of fire",      //   1#
  "Key of water",     //   1#
  "Key of air",       //   1#
  "Key of earth",     //   1#
  "Key of light",     //   1#
  "True scroll",      //   1#
  "Glassy key",       //   1#
  "Bone key",         //   1#
  "Dry clay",         //   1#
  "Some water",       //   1#
  "Lump of clay",     //   1#
  "Dry clay key",     //   1#
  "Wet clay key",     //   1#
  "Golden sword",     //   8#
  "Golden figurine",  //   1#
  "Diadem",           //   1#
  "Crank-handle",     //   1#
  "Seal ring",        //   1#
  "Bird's nest",      //   1#
  "Ladle",            //   1#
  "Caught vampire",   //  60#
  "Tin key",          //   1#
  "Water jug",        //   1#
  "Bone",             //   1#
  "Door key",         //   1#
  "Ugly map",         //   1#
  "The Ring",         //   1#
  "The Staff"         //   2# $B9
};

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  L... .... .... ....    . = Transparent  (%00)
    DDD. .... .... ....    L = Light grey   (%01)
    .DMM D... .... ....    M = Medium grey  (%10)
    .DDM MD.. .... ....    D = Dark grey    (%11)
    ..DD MM.. ...D ....
    ..DD DM.. .DM. ....
    M... .DD. .MD. ....
    L... ..DM D... ....
    LDMD ..DD M... ....
    LMDD MMDD DM.. ....
    MLDD DDD. .DM. ....
    .LMD DDD. ..DM ....
    .MLM DDDD ...D M...
    ..ML MDDD .... DM..
    ...M LLMD .... .DM.
    .... .MLL LM.. ..DM

          Plane 1                Plane 0
    .... .... .... ....    L... .... .... ....
    DDD. .... .... ....    DDD. .... .... ....
    .DMM D... .... ....    .D.. D... .... ....
    .DDM MD.. .... ....    .DD. .D.. .... ....
    ..DD MM.. ...D ....    ..DD .... ...D ....
    ..DD DM.. .DM. ....    ..DD D... .D.. ....
    M... .DD. .MD. ....    .... .DD. ..D. ....
    .... ..DM D... ....    L... ..D. D... ....
    .DMD ..DD M... ....    LD.D ..DD .... ....
    .MDD MMDD DM.. ....    L.DD ..DD D... ....
    M.DD DDD. .DM. ....    .LDD DDD. .D.. ....
    ..MD DDD. ..DM ....    .L.D DDD. ..D. ....
    .M.M DDDD ...D M...    ..L. DDDD ...D ....
    ..M. MDDD .... DM..    ...L .DDD .... D...
    ...M ..MD .... .DM.    .... LL.D .... .D..
    .... .M.. .M.. ..DM    .... ..LL L... ..D.
    Medium & Dark Grey      Light & Dark Grey 

    Plane 1 Plane 0 */
    0x0000, 0x8000,
    0xE000, 0xE000,
    0x7800, 0x4800,
    0x7C00, 0x6400,
    0x3C10, 0x3010,
    0x3C60, 0x3840,
    0x8660, 0x0620,
    0x0380, 0x8280,
    0x7380, 0xD300,
    0x7FC0, 0xB380,
    0xBE60, 0x7E40,
    0x3E30, 0x5E20,
    0x5F18, 0x2F10,
    0x2F0C, 0x1708,
    0x1306, 0x0D04,
    0x0443, 0x0382,

    0x0000, 0x0000  // reserved
};
#endif

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   TEXT  name[10 + 1];
    ULONG str,
          iq,
          wis,
          dex,
          con,
          level,
          race,
          trade,
          sex,
          alignment,
          xp,
          goldcarried,
          goldinbank,
          food,
          ability[9],
          item[48],
          equipped[48],
          curhp,
          maxhp,
          curmp,
          maxmp,
          language[8]; // not UWORD!
} man[32];

MODULE struct                // -----Structure----- -------File--------
{   UBYTE   Enabled;         //  $00         0       $00         0
    char    Name[10 + 1];    //  $01.. $0B   1.. 11  $01.. $0B   1.. 11
    BYTE    Caught,          //  $0C        12       $0C        12
            Target;          //  $0D        13       $0D        13
    UBYTE   Magic;           //  $0E        14       $0E        14
    BYTE    NextAction;      //  $0F        15       $0F        15
    WORD    SpecialChar,     //  $10.. $11  16.. 17  $10.. $11  16.. 17
            MaxSpecialRound, //  $12.. $13  18.. 19  $12.. $13  18.. 19
            Damage;          //  $14.. $15  20.. 21  $14.. $15  20.. 21
    BYTE    HiddenAt;        //  $16        22       $16        22
    UBYTE   Level,           //  $17        23       $17        23
            Sex,             //  $18        24       $18        24
            Align,           //  $19        25       $19        25
            Race,            //  $1A        26       $1A        26
            Class,           //  $1B        27       $1B        27
            Thaco,           //  $1C        28       $1C        28
            ACa,             //  $1D        29       $1D        29
            ACr,             //  $1E        30       $1E        30
            Health;          //  $1F        31       $1F        31
    WORD    StHits,          //  $20.. $21  32.. 33  $20.. $21  32.. 33
            CnHits;          //  $22.. $23  34.. 35  $22.. $23  34.. 35
    UBYTE   Position,        //  $24        36       $24        36
            Negotiate,       //  $25        37       $25        37
            LastNego,        //  $26        38       $26        38
            Attack,          //  $27        39       $27        39
            Defend,          //  $28        40       $28        40
            LastPhys,        //  $29        41       $29        41
            LastMagi,        //  $2A        42       $2A        42
            Concentration,   //  $2B        43       $2B        43
            LastSpell,       //  $2C        44       $2C        44
            PickPockets,     //  $2D        45       $2D        45
            LastFail,        //  $2E        46       $2E        46
            LastSucc,        //  $2F        47       $2F        47
            Stalk,           //  $30        48       $30        48
            LastStal,        //  $31        49       $31        49
            FindTrap,        //  $32        50       $32        50
            LastFind,        //  $33        51       $33        51
            DisarmTrap,      //  $34        52       $34        52
            LastDisa,        //  $35        53       $35        53
            OpenDoor,        //  $36        54       $36        54
            Revive,          //  $37        55       $37        55
            Location[13],    //  $38.. $44  56.. 68  $38.. $44  56.. 68
            Con,             //  $45        69       $45        69
            Str,             //  $46        70       $46        70
            Dex,             //  $47        71       $47        71
            Int,             //  $48        72       $48        72
            Wis;             //  $49        73       $49        73
    BYTE    DoesNotMove,     //  $4A        74       ---       ---
            AntiMagic;       //  $4B        75       ---       ---
    BOOL    NeedsRescue,     //  $4C.. $4D  76.. 77  ---       ---
            NoMagic;         //  $4E.. $4F  78.. 79  ---       ---
    LONG    Speed;           //  $50.. $53  80.. 83  ---       ---
    BOOL    Dragon,          //  $54.. $55  84.. 85  ---       ---
            Healer,          //  $56.. $57  86.. 87  ---       ---
            WereWolf;        //  $58.. $59  88.. 89  ---       ---
    BYTE    HalfVal,         //  $5A        90       ---       ---
            NumAttacks,      //  $5B        91       ---       ---
            PoisonSpeed,     //  $5C        92       ---       ---
            Phases,          //  $5D        93       ---       ---
            HitsUpPerPhase,  //  $5E        94       ---       ---
            RescueUp,        //  $5F        95       ---       ---
            ACUp,            //  $60        96       ---       ---
            ThacoUp,         //  $61        97       ---       ---
            AttacksUp,       //  $62        98       ---       ---
            StrUp,           //  $63        99       ---       ---
            LevelUp,         //  $64       100       ---       ---
            OldCon;          //  $65       101       ---       ---
    WORD    StrengthDrain;   //  $66.. $67 102..103  ---       ---
 // UWORD   MaxLoad,         //  $68.. $69 104..105  ---       ---
 //         CurLoad;         //  $6A.. $6B 106..107  ---       ---
    UBYTE   Spells,          //  $6C       108       $68       104
            NumSpells,       //  $6D       109       $69       105
            ListSpell,       //  $6E       110       $6A       106
            NumItems;        //  $6F       111       $6B       107
    ULONG   Experience;      //  $70.. $73 112..115  $6C.. $6F 108..111
    UBYTE   Rations,         //  $74       116       $70       112
            Pad;             //  $75       117       $71       113
    LONG    Gold,            //  $76.. $79 118..121  $72.. $75 114..117
            Account;         //  $7A.. $7D 122..125  $76.. $79 118..121
    UBYTE   Language[8],     //  $7E.. $85 126..133  $7A.. $81 122..129
            Items[48][4],    //  $86..$145 134..325  $82..$141 130..321
            Spell[34][2],    // $146..$189 326..393 $142..$185 322..389
            Identified[20];  // $18A..$19D 394..413 $186..$199 390..409
 // ULONG   Sum;             // $19E..$1A1 414..417 $19A..$19D 410..413
} Roster[32];

// 8. CODE ---------------------------------------------------------------

EXPORT void lof_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // lof_preinit()
        NewList(&ItemsList);

        // lof_init()
        lb_makelist(&ItemsList, ItemNames, ITEMS);
    }

    // assert(sizeof(Roster[0]) == 410);

    tool_open      = lof_open;
    tool_loop      = lof_loop;
    tool_save      = lof_save;
    tool_close     = lof_close;
    tool_exit      = lof_exit;
    tool_subgadget = lof_subgadget;

    if (loaded != FUNC_LOF && !lof_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_LOF;

    load_fimage(FUNC_LOF);
    make_speedbar_list(GID_LOF_SB1);
    load_aiss_images(10, 10);
    makesexlist();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_LOF_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            AddHLayout,
                AddToolbar(GID_LOF_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddVLayout,
                    AddSpace,
                    CHILD_WeightedHeight,                  50,
                    MaximizeButton(GID_LOF_BU2, "Maximize Party"),
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                    CHILD_WeightedHeight,                  50,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            AddHLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                AddLabel("Character #:"),
                LAYOUT_AddChild,                           gadgets[GID_LOF_IN5] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_LOF_IN5,
                    GA_RelVerify,                          TRUE,
                    GA_TabCycle,                           TRUE,
                    INTEGER_Minimum,                       1,
                    INTEGER_Maximum,                       men,
                    INTEGER_Number,                        who + 1,
                    INTEGER_MinVisible,                    2 + 1,
                IntegerEnd,
                AddLabel("of"),
                LAYOUT_AddChild,                           gadgets[GID_LOF_IN6] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                 GID_LOF_IN6,
                    GA_Disabled,                           TRUE,
                    INTEGER_Arrows,                        FALSE,
                    INTEGER_Number,                        men,
                    INTEGER_MinVisible,                    2,
                IntegerEnd,
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "Character",
                AddHLayout,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "General",
                            LAYOUT_AddChild,               gadgets[GID_LOF_ST1] = (struct Gadget*)
                            StringObject,
                                GA_ID,                     GID_LOF_ST1,
                                GA_TabCycle,               TRUE,
                                STRINGA_TextVal,           man[who].name,
                                STRINGA_MaxChars,          10 + 1,
                            StringEnd,
                            Label("Name:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_CH3] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                     GID_LOF_CH3,
                                CHOOSER_Labels,            &SexList,
                                CHOOSER_Selected,          (WORD) man[who].sex,
                            PopUpEnd,
                            Label("Sex:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_CH1] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                     GID_LOF_CH1,
                                CHOOSER_LabelArray,        &RaceOptions,
                                CHOOSER_Selected,          (WORD) man[who].race,
                            PopUpEnd,
                            Label("Race:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_CH2] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                     GID_LOF_CH2,
                                CHOOSER_LabelArray,        &TradeOptions,
                                CHOOSER_Selected,          (WORD) man[who].trade,
                            PopUpEnd,
                            Label("Trade:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_CH4] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                     GID_LOF_CH4,
                                CHOOSER_LabelArray,        &AlignmentOptions,
                                CHOOSER_Selected,          (WORD) man[who].alignment,
                            PopUpEnd,
                            Label("Alignment:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN7] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN7,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           1,
                                INTEGER_Maximum,           255,
                                INTEGER_Number,            man[who].level,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Level:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN18] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN18,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Number,            man[who].xp,
                                INTEGER_MinVisible,        10 + 1,
                            IntegerEnd,
                            Label("Experience:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN19] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN19,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Number,            man[who].goldcarried,
                                INTEGER_MinVisible,        10 + 1,
                            IntegerEnd,
                            Label("Gold carried:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN20] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN20,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Number,            man[who].goldinbank,
                                INTEGER_MinVisible,        10 + 1,
                            IntegerEnd,
                            Label("Gold in bank:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN21] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN21,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           255,
                                INTEGER_Number,            man[who].food,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Food:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,      LALIGN_CENTER,
                                LAYOUT_AddChild,           gadgets[GID_LOF_IN22] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_LOF_IN22,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Arrows,        TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       9999,
                                    INTEGER_Number,        man[who].curhp,
                                    INTEGER_MinVisible,    4 + 1,
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,           gadgets[GID_LOF_IN23] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                 GID_LOF_IN23,
                                    GA_TabCycle,           TRUE,
                                    INTEGER_Arrows,        TRUE,
                                    INTEGER_Minimum,       0,
                                    INTEGER_Maximum,       9999,
                                    INTEGER_Number,        man[who].maxhp,
                                    INTEGER_MinVisible,    4 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Hit points:"),
                        LayoutEnd,
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "Attributes",
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN1] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN1,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           255,
                                INTEGER_Number,            man[who].str,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Strength:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN2] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN2,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           255,
                                INTEGER_Number,            man[who].iq,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Intelligence:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN3] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN3,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           255,
                                INTEGER_Number,            man[who].wis,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Wisdom:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN4] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN4,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           255,
                                INTEGER_Number,            man[who].dex,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Dexterity:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN8] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN8,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           255,
                                INTEGER_Number,            man[who].con,
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Constitution:"),
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                        AddHLayout,
                            AddSpace,
                            AddFImage(FUNC_LOF),
                            CHILD_WeightedWidth,           0,
                            AddSpace,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "Abilities",
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN9] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN9,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            man[who].ability[0],
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Negotiation:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN10] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN10,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            man[who].ability[1],
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Attack:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN11] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN11,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            man[who].ability[2],
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Defence:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN12] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN12,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            man[who].ability[3],
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Concentration:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN13] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN13,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            man[who].ability[4],
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Pickpocketing:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN14] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN14,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            man[who].ability[5],
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Stalking:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN15] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN15,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            man[who].ability[6],
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Trap detection:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN16] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN16,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            man[who].ability[7],
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Trap disarming:"),
                            LAYOUT_AddChild,               gadgets[GID_LOF_IN17] = (struct Gadget*)
                            IntegerObject,
                                GA_ID,                     GID_LOF_IN17,
                                GA_TabCycle,               TRUE,
                                INTEGER_Arrows,            TRUE,
                                INTEGER_Minimum,           0,
                                INTEGER_Maximum,           100,
                                INTEGER_Number,            man[who].ability[8],
                                INTEGER_MinVisible,        3 + 1,
                            IntegerEnd,
                            Label("Lockpicking:"),
                        LayoutEnd,
                        AddHLayout,
                            LAYOUT_BevelStyle,             BVS_GROUP,
                            LAYOUT_SpaceOuter,             TRUE,
                            LAYOUT_Label,                  "Languages",
                            AddVLayout,
                                LAYOUT_AddChild,           gadgets[GID_LOF_CB1] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_LOF_CB1,
                                    GA_Text,               "Common",
                                End,
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_LOF_CB2] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_LOF_CB2,
                                    GA_Text,               "Animal",
                                End,
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_LOF_CB3] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_LOF_CB3,
                                    GA_Text,               "Orc",
                                End,
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_LOF_CB4] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_LOF_CB4,
                                    GA_Text,               "Lizard",
                                End,
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_LOF_CB5] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_LOF_CB5,
                                    GA_Text,               "Dwarven",
                                End,
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_LOF_CB6] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_LOF_CB6,
                                    GA_Text,               "Elven",
                                End,
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_LOF_CB7] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_LOF_CB7,
                                    GA_Text,               "Dark",
                                End,
                                CHILD_WeightedWidth,       0,
                                LAYOUT_AddChild,           gadgets[GID_LOF_CB8] = (struct Gadget*)
                                TickOrCheckBoxObject,
                                    GA_ID,                 GID_LOF_CB8,
                                    GA_Text,               "Magic",
                                End,
                                CHILD_WeightedWidth,       0,
                            LayoutEnd,
                            CHILD_WeightedHeight,          0,
                        LayoutEnd,
                        CHILD_WeightedHeight,              0,
                        AddSpace,
                    LayoutEnd,
                    AddHLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "Items",
                        AddVLayout,
                            EquippedCheck(GID_LOF_CB9),
                            Label("1:"),
                            EquippedCheck(GID_LOF_CB10),
                            Label("2:"),
                            EquippedCheck(GID_LOF_CB11),
                            Label("3:"),
                            EquippedCheck(GID_LOF_CB12),
                            Label("4:"),
                            EquippedCheck(GID_LOF_CB13),
                            Label("5:"),
                            EquippedCheck(GID_LOF_CB14),
                            Label("6:"),
                            EquippedCheck(GID_LOF_CB15),
                            Label("7:"),
                            EquippedCheck(GID_LOF_CB16),
                            Label("8:"),
                            EquippedCheck(GID_LOF_CB17),
                            Label("9:"),
                            EquippedCheck(GID_LOF_CB18),
                            Label("10:"),
                            EquippedCheck(GID_LOF_CB19),
                            Label("11:"),
                            EquippedCheck(GID_LOF_CB20),
                            Label("12:"),
                            EquippedCheck(GID_LOF_CB21),
                            Label("13:"),
                            EquippedCheck(GID_LOF_CB22),
                            Label("14:"),
                            EquippedCheck(GID_LOF_CB23),
                            Label("15:"),
                            EquippedCheck(GID_LOF_CB24),
                            Label("16:"),
                            EquippedCheck(GID_LOF_CB25),
                            Label("17:"),
                            EquippedCheck(GID_LOF_CB26),
                            Label("18:"),
                            EquippedCheck(GID_LOF_CB27),
                            Label("19:"),
                            EquippedCheck(GID_LOF_CB28),
                            Label("20:"),
                            EquippedCheck(GID_LOF_CB29),
                            Label("21:"),
                            EquippedCheck(GID_LOF_CB30),
                            Label("22:"),
                            EquippedCheck(GID_LOF_CB31),
                            Label("23:"),
                            EquippedCheck(GID_LOF_CB32),
                            Label("24:"),
                        LayoutEnd,
                        CHILD_WeightedWidth,               0,
                        AddVLayout,
                            ItemButton(GID_LOF_BU3 ),
                            ItemButton(GID_LOF_BU4 ),
                            ItemButton(GID_LOF_BU5 ),
                            ItemButton(GID_LOF_BU6 ),
                            ItemButton(GID_LOF_BU7 ),
                            ItemButton(GID_LOF_BU8 ),
                            ItemButton(GID_LOF_BU9 ),
                            ItemButton(GID_LOF_BU10),
                            ItemButton(GID_LOF_BU11),
                            ItemButton(GID_LOF_BU12),
                            ItemButton(GID_LOF_BU13),
                            ItemButton(GID_LOF_BU14),
                            ItemButton(GID_LOF_BU15),
                            ItemButton(GID_LOF_BU16),
                            ItemButton(GID_LOF_BU17),
                            ItemButton(GID_LOF_BU18),
                            ItemButton(GID_LOF_BU19),
                            ItemButton(GID_LOF_BU20),
                            ItemButton(GID_LOF_BU21),
                            ItemButton(GID_LOF_BU22),
                            ItemButton(GID_LOF_BU23),
                            ItemButton(GID_LOF_BU24),
                            ItemButton(GID_LOF_BU25),
                            ItemButton(GID_LOF_BU26),
                        LayoutEnd,
                        CHILD_MinWidth,                    128,
                        AddVLayout,
                            EquippedCheck(GID_LOF_CB33),
                            Label("25:"),
                            EquippedCheck(GID_LOF_CB34),
                            Label("26:"),
                            EquippedCheck(GID_LOF_CB35),
                            Label("27:"),
                            EquippedCheck(GID_LOF_CB36),
                            Label("28:"),
                            EquippedCheck(GID_LOF_CB37),
                            Label("29:"),
                            EquippedCheck(GID_LOF_CB38),
                            Label("30:"),
                            EquippedCheck(GID_LOF_CB39),
                            Label("31:"),
                            EquippedCheck(GID_LOF_CB40),
                            Label("32:"),
                            EquippedCheck(GID_LOF_CB41),
                            Label("33:"),
                            EquippedCheck(GID_LOF_CB42),
                            Label("34:"),
                            EquippedCheck(GID_LOF_CB43),
                            Label("35:"),
                            EquippedCheck(GID_LOF_CB44),
                            Label("36:"),
                            EquippedCheck(GID_LOF_CB45),
                            Label("37:"),
                            EquippedCheck(GID_LOF_CB46),
                            Label("38:"),
                            EquippedCheck(GID_LOF_CB47),
                            Label("39:"),
                            EquippedCheck(GID_LOF_CB48),
                            Label("40:"),
                            EquippedCheck(GID_LOF_CB49),
                            Label("41:"),
                            EquippedCheck(GID_LOF_CB50),
                            Label("42:"),
                            EquippedCheck(GID_LOF_CB51),
                            Label("43:"),
                            EquippedCheck(GID_LOF_CB52),
                            Label("44:"),
                            EquippedCheck(GID_LOF_CB53),
                            Label("45:"),
                            EquippedCheck(GID_LOF_CB54),
                            Label("46:"),
                            EquippedCheck(GID_LOF_CB55),
                            Label("47:"),
                            EquippedCheck(GID_LOF_CB56),
                            Label("48:"),
                        LayoutEnd,
                        CHILD_WeightedWidth,               0,
                        AddVLayout,
                            ItemButton(GID_LOF_BU27),
                            ItemButton(GID_LOF_BU28),
                            ItemButton(GID_LOF_BU29),
                            ItemButton(GID_LOF_BU30),
                            ItemButton(GID_LOF_BU31),
                            ItemButton(GID_LOF_BU32),
                            ItemButton(GID_LOF_BU33),
                            ItemButton(GID_LOF_BU34),
                            ItemButton(GID_LOF_BU35),
                            ItemButton(GID_LOF_BU36),
                            ItemButton(GID_LOF_BU37),
                            ItemButton(GID_LOF_BU38),
                            ItemButton(GID_LOF_BU39),
                            ItemButton(GID_LOF_BU40),
                            ItemButton(GID_LOF_BU41),
                            ItemButton(GID_LOF_BU42),
                            ItemButton(GID_LOF_BU43),
                            ItemButton(GID_LOF_BU44),
                            ItemButton(GID_LOF_BU45),
                            ItemButton(GID_LOF_BU46),
                            ItemButton(GID_LOF_BU47),
                            ItemButton(GID_LOF_BU48),
                            ItemButton(GID_LOF_BU49),
                            ItemButton(GID_LOF_BU50),
                        LayoutEnd,
                        CHILD_MinWidth,                    128,
                    LayoutEnd,
                LayoutEnd,
                MaximizeButton(GID_LOF_BU1, "Maximize Character"),
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_LOF_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif

    writegadgets();
    DISCARD ActivateLayoutGadget(gadgets[GID_LOF_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_LOF_ST1]);
    loop();
    readman();
    closewindow();
}

EXPORT void lof_loop(ULONG gid, UNUSED ULONG code)
{   int whichman;

    switch (gid)
    {
    case GID_LOF_IN5:
        readman();
        DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_LOF_IN5], (ULONG*) &who);
        who--;
        writeman();
    acase GID_LOF_BU1:
        readman();
        maximize_man(who);
        writegadgets();
    acase GID_LOF_BU2:
        readman();
        for (whichman = 0; whichman < (int) men; whichman++)
        {   maximize_man(whichman);
        }
        writegadgets();
    adefault:
        if (gid >= GID_LOF_BU3 && gid <= GID_LOF_BU50)
        {   whichitem = gid - GID_LOF_BU3;
            itemwindow();
}   }   }

EXPORT FLAG lof_open(FLAG loadas)
{   FILE* RosterFile;
    LONG  Sum;
    int   i;

    if (gameopen(loadas))
    {   if ((getsize(pathname) - 1) % 414 != 0)
        {   return FALSE;
        } // implied else

        if (!(RosterFile = fopen(pathname, "rb")))
        {   return FALSE;
        } // implied else

        men = fgetc(RosterFile);
        if (!men)
        {   fclose(RosterFile);
            return FALSE;
        } // implied else

        for (i = 0; i < (int) men; i++)
        {   fread(&Roster[i], 410, 1, RosterFile);
            Roster[i].Caught = 0;
            fread(&Sum, 4, 1, RosterFile);
        }
        fclose(RosterFile);

        olaf_to_ra();
        if (who >= men)
        {   who = 0;
        }

        writegadgets();

        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   if
    (   function != FUNC_LOF
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    DISCARD SetGadgetAttrs
    (   gadgets[GID_LOF_IN5], MainWindowPtr, NULL,
        INTEGER_Maximum, men,
        INTEGER_Number,  who + 1,
    TAG_END); // autorefreshes
    DISCARD SetGadgetAttrs
    (   gadgets[GID_LOF_IN6], MainWindowPtr, NULL,
        INTEGER_Number, men,
    TAG_END); // autorefreshes

    writeman();
}

MODULE void readman(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void writeman(void)
{   int i;

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    for (i = 0; i < 48; i++)
    {   strcpy(itemdisplay[i], ItemNames[man[who].item[i]]);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_LOF_BU3 + i], MainWindowPtr, NULL,
            GA_Text, itemdisplay[i],
        TAG_DONE); // this autorefreshes
}   }

MODULE void eithergadgets(void)
{   int i;

    either_st(GID_LOF_ST1,   man[who].name);
    either_in(GID_LOF_IN1,  &man[who].str);
    either_in(GID_LOF_IN2,  &man[who].iq);        
    either_in(GID_LOF_IN3,  &man[who].wis);
    either_in(GID_LOF_IN4,  &man[who].dex);
    either_in(GID_LOF_IN7,  &man[who].level);
    either_in(GID_LOF_IN8,  &man[who].con);
    for (i = 0; i < 9; i++)
    {   either_in(GID_LOF_IN9 + i, &man[who].ability[i]);
    }
    either_in(GID_LOF_IN18, &man[who].xp);
    either_in(GID_LOF_IN19, &man[who].goldcarried);
    either_in(GID_LOF_IN20, &man[who].goldinbank);
    either_in(GID_LOF_IN21, &man[who].food);
    either_in(GID_LOF_IN22, &man[who].curhp);
    either_in(GID_LOF_IN23, &man[who].maxhp);
    either_ch(GID_LOF_CH1,  &man[who].race);
    either_ch(GID_LOF_CH2,  &man[who].trade);
    either_ch(GID_LOF_CH3,  &man[who].sex);
    either_ch(GID_LOF_CH4,  &man[who].alignment);
    for (i = 0; i < 8; i++)
    {   either_cb(GID_LOF_CB1 + i, &man[who].language[i]);
    }
    for (i = 0; i < 48; i++)
    {   either_cb(GID_LOF_CB9 + i, &man[who].equipped[i]);
}   }

EXPORT void lof_save(FLAG saveas)
{   FILE* RosterFile;
    LONG  Sum;
    int   i;

    readman();
    ra_to_olaf();
    if (!gamesave("#?ROST#?", "Legend of Faerghail", saveas, (ULONG) (1 + (414 * men)), FLAG_S, TRUE)) // this doesn't actually write the file
    {   return;
    }

    if (!(RosterFile = fopen(pathname, "wb")))
    {   return;
    } // implied else
    DISCARD fputc(men, RosterFile);
    for (i = 0; i < (int) men; i++)
    {   fwrite(&Roster[i], 410, 1, RosterFile);
        Sum = CheckSum((UBYTE*) &Roster[i], 410);
        fwrite(&Sum, 4, 1, RosterFile);
    }
    fclose(RosterFile);

    say("Saved file.", REQIMAGE_INFO); // "file" not "files"!
}

EXPORT void lof_exit(void)
{   ch_clearlist(&SexList);
}
EXPORT void lof_die(void)
{   lb_clearlist(&ItemsList);
}

EXPORT void lof_close(void) { ; }

MODULE void maximize_man(int whichman)
{   int i;

    man[whichman].level       =
    man[whichman].str         =
    man[whichman].iq          =
    man[whichman].wis         =
    man[whichman].dex         =
    man[whichman].con         =
    man[whichman].food        =      90;
    man[whichman].curhp       =
    man[whichman].maxhp       =    9000;
    man[whichman].goldcarried =
    man[whichman].goldinbank  =
    man[whichman].xp          = 2000000;

    for (i = 0; i < 9; i++)
    {   man[whichman].ability[i]  = 100;
    }
    for (i = 0; i < 8; i++)
    {   man[whichman].language[i] = TRUE;
}   }

MODULE LONG CheckSum(UBYTE* Block, int Length)
{   int   i;
    LONG  Sum = 1;
    UBYTE Tmp;

    for (i = 0; i < Length; i++)
    {  if (!(Tmp = Block[i]))
       {   Tmp = 1;
       }
       if (!(i % 2))
       {   Sum += Tmp;
       } else
       {   Sum ^= Tmp;
    }  }

    return Sum;
}

MODULE void olaf_to_ra(void)
{   int i, j;

    for (i = 0; i < (int) men; i++)
    {   strcpy(man[i].name, Roster[i].Name);

        man[i].str         = Roster[i].Str;
        man[i].iq          = Roster[i].Int;
        man[i].wis         = Roster[i].Wis;
        man[i].dex         = Roster[i].Dex;
        man[i].con         = Roster[i].Con;
        man[i].level       = Roster[i].Level;
        man[i].race        = Roster[i].Race;
        man[i].trade       = Roster[i].Class;
        man[i].sex         = (Roster[i].Sex == 0) ? 1 : 0;
        man[i].alignment   = Roster[i].Align;
        man[i].xp          = Roster[i].Experience;
        man[i].goldcarried = Roster[i].Gold;
        man[i].goldinbank  = Roster[i].Account;
        man[i].food        = Roster[i].Rations;
        man[i].maxhp       = Roster[i].StHits;
        man[i].curhp       = Roster[i].CnHits;

        man[i].ability[0]  = Roster[i].Negotiate;
        man[i].ability[1]  = Roster[i].Attack;
        man[i].ability[2]  = Roster[i].Defend;
        man[i].ability[3]  = Roster[i].Concentration;
        man[i].ability[4]  = Roster[i].PickPockets;
        man[i].ability[5]  = Roster[i].Stalk;
        man[i].ability[6]  = Roster[i].FindTrap;
        man[i].ability[7]  = Roster[i].DisarmTrap;
        man[i].ability[8]  = Roster[i].OpenDoor;

        for (j = 0; j < 8; j++)
        {   man[i].language[j] = Roster[i].Language[j] ? TRUE : FALSE;
        }
        for (j = 0; j < 48; j++)
        {   if (j < Roster[i].NumItems)
            {   man[i].item[j]     = Roster[i].Items[j][0];
                man[i].equipped[j] = Roster[i].Items[j][1] & 1 ? TRUE : FALSE;
            } else
            {   man[i].item[j]     = 0;
                man[i].equipped[j] = FALSE;
}   }   }   }

MODULE void ra_to_olaf(void)
{   int i, j;

    for (i = 0; i < (int) men; i++)
    {   strcpy(Roster[i].Name, man[i].name);

        Roster[i].Str           = man[i].str;
        Roster[i].Int           = man[i].iq;
        Roster[i].Wis           = man[i].wis;
        Roster[i].Dex           = man[i].dex;
        Roster[i].Con           = man[i].con;
        Roster[i].Level         = man[i].level;
        Roster[i].Race          = man[i].race;
        Roster[i].Class         = man[i].trade;
        Roster[i].Sex           = (man[i].sex == 0) ? 1 : 0;
        Roster[i].Align         = man[i].alignment;
        Roster[i].Experience    = man[i].xp;
        Roster[i].Gold          = man[i].goldcarried;
        Roster[i].Account       = man[i].goldinbank;
        Roster[i].Rations       = man[i].food;
        Roster[i].StHits        = man[i].maxhp;
        Roster[i].CnHits        = man[i].curhp;

        Roster[i].Negotiate     = man[i].ability[0];
        Roster[i].Attack        = man[i].ability[1];
        Roster[i].Defend        = man[i].ability[2];
        Roster[i].Concentration = man[i].ability[3];
        Roster[i].PickPockets   = man[i].ability[4];
        Roster[i].Stalk         = man[i].ability[5];
        Roster[i].FindTrap      = man[i].ability[6];
        Roster[i].DisarmTrap    = man[i].ability[7];
        Roster[i].OpenDoor      = man[i].ability[8];

        Roster[i].NumItems      = 0;
        for (j = 0; j < 48; j++)
        {   if (man[i].item[j])
            {   if (man[i].equipped[j])
                {   Roster[i].Items[j][1] = 1;
                } else
                {   Roster[i].Items[j][1] = 0;
                }
                Roster[i].Items[j][3] = 100;
            } else
            {   Roster[i].Items[j][1] =
                Roster[i].Items[j][3] = 0;
            }
            Roster[i].NumItems = j + 1;
        }

        for (j = 0; j < 8; j++)
        {   Roster[i].Language[j] = man[i].language[j] ? 2 : 0;
        }
        for (j = 0; j < 48; j++)
        {   Roster[i].Items[j][0] = man[i].item[j];
}   }   }

MODULE void itemwindow(void)
{   InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              "Choose Item",
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "lof-1",
        WINDOW_ParentGroup,                    gadgets[GID_LOF_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_LOF_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_LOF_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &ItemsList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    128,
            CHILD_MinHeight,                   416,
            CHILD_WeightedHeight,              0,
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

    DISCARD SetGadgetAttrs(         gadgets[GID_LOF_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,              ~0,                       TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_LOF_LB1], SubWindowPtr, NULL, LISTBROWSER_Labels,              &ItemsList,               TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_LOF_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) man[who].item[whichitem], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_LOF_LB1], SubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(         gadgets[GID_LOF_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) man[who].item[whichitem], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_LOF_LB1], SubWindowPtr, NULL);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG lof_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_LOF_LB1:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_LOF_LB1], (ULONG*) &man[who].item[whichitem]);
        writegadgets();
        return TRUE;
    }

    return FALSE;
}

EXPORT FLAG lof_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        lb_move_up(GID_LOF_LB1, SubWindowPtr, qual, &man[who].item[whichitem], 0, 5);
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_move_down(GID_LOF_LB1, SubWindowPtr, qual, &man[who].item[whichitem], ITEMS - 1, 5);
    }

    return FALSE;
}

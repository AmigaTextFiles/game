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
#include <proto/virtual.h>
#include <clib/alib_protos.h>

#include <gadgets/virtual.h>

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
#define GID_EOB_LY1     0 // root layout
#define GID_EOB_SB1     1 // toolbar
#define GID_EOB_ST1     2 // character name
#define GID_EOB_ST2     3 // game name
#define GID_EOB_IN1     4 // character #
#define GID_EOB_IN2     5 // 1st level
#define GID_EOB_IN3     6 // 2nd level
#define GID_EOB_IN4     7 // 3rd level
#define GID_EOB_IN5     8 // 1st xp
#define GID_EOB_IN6     9 // 2nd xp
#define GID_EOB_IN7    10 // 3rd xp
#define GID_EOB_IN8    11 // current STR
#define GID_EOB_IN9    12 // maximum STR
#define GID_EOB_IN10   13 // current INT
#define GID_EOB_IN11   14 // maximum INT
#define GID_EOB_IN12   15 // current WIS
#define GID_EOB_IN13   16 // maximum WIS
#define GID_EOB_IN14   17 // current DEX
#define GID_EOB_IN15   18 // maximum DEX
#define GID_EOB_IN16   19 // current CON
#define GID_EOB_IN17   20 // maximum CON
#define GID_EOB_IN18   21 // current CHA
#define GID_EOB_IN19   22 // maximum CHA
#define GID_EOB_IN20   23 // food
#define GID_EOB_IN21   24 // current exceptional STR
#define GID_EOB_IN22   25 // maximum exceptional STR
#define GID_EOB_IN23   26 // current hit points
#define GID_EOB_IN24   27 // maximum hit points
#define GID_EOB_BU1    28 // maximize character
#define GID_EOB_CH1    29 // game
#define GID_EOB_CH2    30 // race
#define GID_EOB_CH3    31 // class
#define GID_EOB_CH4    32 // sex
#define GID_EOB_CH5    33 // alignment
#define GID_EOB_BU2    34 //  1st inventory slot
#define GID_EOB_BU28   62 // 27th inventory slot
#define GID_EOB_BU29   63 //  1st mage spell slot
#define GID_EOB_BU82  116 // 54th mage spell slot
#define GID_EOB_BU83  117 //  1st cleric spell slot
#define GID_EOB_BU136 170 // 54th cleric spell slot
#define GID_EOB_VI1   171

// items subwindow
#define GID_EOB_LY2   172
#define GID_EOB_LB1   173

// spells subwindow
#define GID_EOB_LY3   174
#define GID_EOB_LB2   175

#define GIDS_EOB      GID_EOB_LB2

#define EOB1           0
#define EOB2           1

#define EOB1ITEMS    447 // last item has this index (ie. counting from 0)
#define EOB2ITEMS    458 // last item has this index

#define AddItem(x)                                               \
AddHLayout,                                                      \
    LAYOUT_VertAlignment,     LALIGN_CENTER,                     \
    LAYOUT_AddChild, gadgets[GID_EOB_BU2 + x] = (struct Gadget*) \
    ZButtonObject,                                               \
        GA_ID,                GID_EOB_BU2 + x,                   \
        GA_RelVerify,         TRUE,                              \
        BUTTON_Justification, BCJ_LEFT,                          \
        GA_Text,              "-",                               \
    ButtonEnd,                                                   \
LayoutEnd
#define AddMSpell(x)                                          \
LAYOUT_AddChild, gadgets[GID_EOB_BU29 + x] = (struct Gadget*) \
ZButtonObject,                                                \
    GA_ID,                GID_EOB_BU29 + x,                   \
    GA_RelVerify,         TRUE,                               \
    BUTTON_Justification, BCJ_LEFT,                           \
    GA_Text,              "-",                                \
ButtonEnd
#define AddCSpell(x)                                          \
LAYOUT_AddChild, gadgets[GID_EOB_BU83 + x] = (struct Gadget*) \
ZButtonObject,                                                \
    GA_ID,                GID_EOB_BU83 + x,                   \
    GA_RelVerify,         TRUE,                               \
    BUTTON_Justification, BCJ_LEFT,                           \
    GA_Text,              "-",                                \
ButtonEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void maximize_man(void);
MODULE void eithergadgets(void);
MODULE void eitherman(void);
MODULE void itemwindow(void);
MODULE void spellwindow(void);
MODULE void enforce(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(None)

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
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *fimage[FUNCTIONS + 1],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT const STRPTR         SexOptions[2];
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

MODULE ULONG                xp1[6],
                            xp2[6],
                            xp3[6],
                            level1[6],
                            level2[6],
                            level3[6],
                            curstr[6], maxstr[6],
                            curexc[6], maxexc[6],
                            curint[6], maxint[6],
                            curwis[6], maxwis[6],
                            curdex[6], maxdex[6],
                            curcon[6], maxcon[6],
                            curcha[6], maxcha[6],
                            inventory[6][27],
                            spellslot[6][2][54],
                            race[6],
                            theclass[6],
                            sex[6],
                            alignment[6],
                            food[6],
                            who;
MODULE SLONG                curhp[6],  maxhp[6];
MODULE TEXT                 name[6][10 + 1],
                            gamename[19 + 1];
MODULE ULONG                game;
MODULE int                  submode,
                            whichslot;
MODULE struct List          ItemsList[2],
                            SpellsList[2][2];

#ifndef __MORPHOS__
MODULE const UWORD CHIP LocalMouseData[4 + (16 * 2)] =
{   0x0000, 0x0000, // reserved

/*  ..L. .... .... ....    . = Transparent  (%00)
    B.DL .... .... ....    B = Black        (%01)
    BBDL L... .... ....    D = Dark red     (%10)
    BBDD LL.. .... ....    L = Light red    (%11)
    BBDD LLL. .... ....
    BBDD DLLL .... ....
    BBDD DLLL L... ....
    BBDD DDLL LL.. ....
    BBDD DDL. .... ....
    BBDB BDDL .... ....
    B..B BBDL .... ....
    .... BBDD L... ....
    .... BBBD L... ....
    .... .BBD DL.. ....
    .... .BBB DL.. ....
    .... ..BB .... ....

          Plane 1                Plane 0
    ..L. .... .... ....    ..L. .... .... ....
    ..DL .... .... ....    B..L .... .... ....
    ..DL L... .... ....    BB.L L... .... ....
    ..DD LL.. .... ....    BB.. LL.. .... ....
    ..DD LLL. .... ....    BB.. LLL. .... ....
    ..DD DLLL .... ....    BB.. .LLL .... ....
    ..DD DLLL L... ....    BB.. .LLL L... ....
    ..DD DDLL LL.. ....    BB.. ..LL LL.. ....
    ..DD DDL. .... ....    BB.. ..L. .... ....
    ..D. .DDL .... ....    BB.B B..L .... ....
    .... ..DL .... ....    B..B BB.L .... ....
    .... ..DD L... ....    .... BB.. L... ....
    .... ...D L... ....    .... BBB. L... ....
    .... ...D DL.. ....    .... .BB. .L.. ....
    .... .... DL.. ....    .... .BBB .L.. ....
    .... .... .... ....    .... ..BB .... ....
    Dark red & Light rd     Black & Light red

    Plane 1 Plane 0 */
    0x2000, 0x2000,
    0x3000, 0x9000,
    0x3800, 0xD800,
    0x3C00, 0xCC00,
    0x3E00, 0xCE00,
    0x3F00, 0xC700,
    0x3F80, 0xC780,
    0x3FC0, 0xC3C0,
    0x3E00, 0xC200,
    0x2700, 0xD900,
    0x0300, 0x9D00,
    0x0380, 0x0C80,
    0x0180, 0x0E80,
    0x01C0, 0x0640,
    0x00C0, 0x0740,
    0x0000, 0x0300,

    0x0000, 0x0000  // reserved
};
#endif

MODULE const int classes[15] =
{ 1, //  0
  1,
  1,
  1,
  1,
  1, //  5
  2,
  2,
  2,
  3,
  2, // 10
  2,
  3,
  2,
  2  // 14
};

MODULE const STRPTR RaceOptions[6 + 1] =
{ "Human",              //  0
  "Elf",
  "Half-Elf",
  "Dwarf",
  "Gnome",
  "Halfling",           //  5
  NULL                  //  6
}, ClassOptions[15 + 1] =
{ "Fighter",            //  0
  "Ranger",
  "Paladin",
  "Mage",
  "Cleric",
  "Thief",              //  5
  "Fighter/Cleric",
  "Fighter/Thief",
  "Fighter/Mage",
  "Fighter/Mage/Thief",
  "Thief/Mage",         // 10
  "Cleric/Thief",
  "Fighter/Cleric/Mage",
  "Ranger/Cleric",
  "Cleric/Mage",        // 14
  NULL                  // 15
}, AlignmentOptions[9 + 1] =
{ "Lawful Good",        //  0
  "Neutral Good",
  "Chaotic Good",
  "Lawful Neutral",
  "True Neutral",
  "Chaotic Neutral",    //  5
  "Lawful Evil",
  "Neutral Evil",
  "Chaotic Evil",       //  8
  NULL                  //  9
}, GameOptions[2 + 1] =
{ "Eye of the Beholder 1",
  "Eye of the Beholder 2",
  NULL
}, EOB1ItemNames[EOB1ITEMS + 1] =
{
"-",
"Leather armour #1",
"Robe #2",
"Staff #3",
"Dagger #4",
"Short sword #5",
"Lock picks #6",
"Spell book #7",
"Cleric holy symbol",
"Leather boots #9",
"Iron rations #10",
"Commission & Letter of Marque #11",
"#12",
"#13",
"#14",
"#15",
"#16",
"Jewelled key #17",
"Potion of giant strength #18",
"Gem #19",
"Skull key #20",
"Wand #21",
"Scroll #22",
"Ring #23",
"Ring #24",
"Ring #25",
"Adamantite dart #26",
"Scroll #27",
"Scroll #28",
"Scroll #29",
"Iron rations #30",
"Paladin holy symbol #31",
"Wand of Slivias",
"Dwarf bones",
"Key #34",
"Commission & Letter of Marque #35",
"Axe #36",
"Dagger #37",
"Dart #38",
"Adamantite dart #39",
"Halberd",
"Chainmail #41",
"Helmet #42",
"Dwarf helmet", // (sic)
"Silver key #44",
"Adamantite longsword",
"Mace #46",
"Long sword #47",
"Potion of healing #48",
"'Guinsoo'",
"Gem #50",
"Orb of power #51",
"Dwarven healing potion",
"Rock #53",
"Potion of extra healing #54",
"Rations #55",
"Fancy robe",
"Rock #57",
"Igneous rock",
"Mage scroll of detect magic #59",
"Spear #60",
"Staff #61",
"Stone medallion #62",
"Rations #63",
"Halfling bones",
"Lock picks #65",
"Rock #66",
"Dart #67",
"Rations #68",
"Rations #69",
"Cleric scroll of bless #70",
"Rock #71",
"Mage scroll of armour #72",
"Arrow #73",
"Shield #74",
"Arrow #75",
"Rations #76",
"Rations #77",
"Leather boots #78",
"Potion of healing #79",
"Silver key #80",
"Potion of giant strength #81",
"Gold key",
"Rock #83",
"Silver key #84",
"Bow",
"Stone dagger #86",
"Silver key #87",
"Mage scroll of invisibility #88",
"Rations #89",
"Rations #90",
"Mage scroll of shield #91",
"Sling #92",
"Arrow #93",
"Silver key #94",
"Potion of healing #95",
"Rock #96",
"Gem #97",
"Gem #98",
"Arrow #99",
"Chainmail #100",
"Shield #101",
"Arrow #102",
"Iron rations #103",
"Iron rations #104",
"Silver key #105",
"Gem #106",
"Gem #107",
"Arrow #108",
"Potion of healing #109",
"Potion of extra healing #110",
"Mage scroll of detect magic #111",
"'Backstabber'",
"Rations #113",
"Shield #114",
"Rations #115",
"Potion of healing #116",
"Rock #117",
"Cleric scroll of flame blade #118",
"Rock #119",
"Mage scroll of fireball #120",
"Cleric scroll of cause light wounds",
"Gem #122",
"Arrow #123",
"Rock #124",
"Long sword #125",
"Wand #126",
"Arrow #127",
"Mace #128",
"Ring #129",
"Dwarven key #130",
"Arrow #131",
"Ring #132",
"Rock #133",
"Potion of healing #134",
"Mace #135",
"Potion of cure poison #136",
"Potion of cure poison #137",
"Medallion #138",
"Robe #139",
"'Drow Cleaver'",
"Stone sceptre #141",
"Wand #142",
"Potion of healing #143",
"Mage scroll of flame arrow",
"Cleric scroll of slow poison #145",
"Iron rations #146",
"Iron rations #147",
"Iron rations #148",
"Dwarven helmet",
"Dwarven shield #150",
"Rock #151",
"Arrow #152",
"Dwarven key #153",
"Rock #154",
"Cleric scroll of hold person #155",
"Iron rations #156",
"Spear #157",
"Stone necklace #158",
"Cleric scroll of aid",
"Mage scroll of haste",
"Iron rations #161",
"Cleric scroll of detect magic #162",
"Iron rations #163",
"Long sword #164",
"Iron rations #165",
"Iron rations #166",
"Potion of poison #167",
"Iron rations #168",
"Mage scroll of dispel magic",
"Rock #170",
"Plate mail #171",
"Dwarven key #172",
"Scale mail",
"Axe #174",
"Sling #175",
"Key #176",
"Ring #177",
"Mage scroll of invisiblity 10' #178",
"Key #179",
"Cleric scroll of prayer",
"Boots",
"Kenku egg #182",
"Kenku egg #183",
"Kenku egg #184",
"Kenku egg #185",
"Kenku egg #186",
"Kenku egg #187",
"Kenku egg #188",
"Kenku egg #189",
"Kenku egg #190",
"Kenku egg #191",
"Dwarven key #192",
"Dwarven key #193",
"Mage scroll of hold person",
"Stone ring #195",
"Rock #196",
"Cleric scroll of dispel magic #197",
"Cleric scroll of cure serious wounds #198",
"Key #199",
"#200",
"#201",
"#202",
"#203",
"#204",
"#205",
"Dwarven shield #206",
"Rock #207",
"Mace +3",
"Bracers #209",
"Wand #210",
"Dwarven key #211",
"Ring #212",
"Cleric scroll of flame blade #213",
"Mage scroll of fireball #214",
"Chieftain halberd",
"Iron rations #216",
"Necklace #217",
"Cleric scroll of bless #218",
"Arrow #219",
"Cleric scroll of protect-evil 10' #220",
"Cleric scroll of remove paralysis #221",
"Cleric scroll of slow poison #222",
"Cleric scroll of create food",
"Key #224",
"Medallion #225",
"Ring #226",
"Arrow #227",
"Arrow #228",
"Arrow #229",
"Arrow #230",
"Slicer +3",
"Bracers #232",
"Ring #233",
"Mage scroll of fear",
"Jewelled key #235",
"Banded armour #236",
"Arrow #237",
"Arrow #238",
"Arrow #239",
"Drow key #240",
"Mage scroll of lightning bolt",
"Key #242",
"Potion of healing #243",
"Drow key #244",
"Cleric scroll of cure light wounds",
"Jewelled key #246",
"Ruby key #247",
"Rock #248",
"Wand #249",
"Shield #250",
"Cleric scroll of prayer",
"Cleric scroll of neutralize poison #252",
"Cleric scroll of cure critical wounds #253",
"Medallion #254",
"Ring #255",
"Ring #256",
"'Night Stalker'",
"Cleric scroll of hold person #258",
"Rock #259",
"Ruby key #260",
"Mage scroll of invisibility 10' #261",
"Drow bow",
"Drow key #263",
"Cleric scroll of protection from evil",
"Drow boots #265",
"Potion of extra healing #266",
"Cleric scroll of raise dead #267",
"Ruby key #268",
"Drow key #269",
"Jewelled key #270",
"Mage scroll of shield #271",
"Wand #272",
"Plate mail of great beauty",
"Flail",
"Drow key #275",
"Robe #276",
"Sceptre of kingly might",
"Mage scroll of ice storm",
"Lock picks #279",
"Drow key #280",
"Cleric scroll of detect magic #281",
"Potion of poison #282",
"Mage scroll of stoneskin",
"Arrow #284",
"Arrow #285",
"Arrow #286",
"Drow key #287",
"Cleric scroll of dispel magic #288",
"Cleric scroll of cure serious wounds #289",
"Mage scroll of invisibility #290",
"Cleric scroll of flame blade #291",
"Cleric scroll of protect-evil 10' #292",
"Mage scroll of armour #293",
"Drow shield",
"Cleric scroll of raise dead #295",
"Drow boots #296",
"Potion of extra healing #297",
"Spear #298",
"Wand #299",
"Cleric scroll of raise dead #300",
"Chainmail #301",
"Rock #302",
"Dwarven key #303",
"Plate mail #304",
"Potion of poison #305",
"Wand #306",
"Cleric scroll of flame blade #307",
"Cleric scroll of cure critical wounds #308",
"Wand #309",
"Stone holy symbol #310",
"Arrow #311",
"Arrow #312",
"Skull key #313",
"Ring #314",
"Potion of giant strength #315",
"Cleric scroll of flame blade #316",
"Cleric scroll of remove paralysis #317",
"Cleric scroll of neutralize poison #318",
"Mage scroll of cone of cold",
"Wand #320",
"Medallion #321",
"Cleric scroll of raise dead #322",
"Stone orb #323",
"Drow key #324",
"Orb of power #325",
"Cleric scroll of raise dead #326",
"Rock #327",
"Rock #328",
"'Slasher'",
"Banded armour #330",
"Ring #331",
"Mage scroll of hold monster",
"Cleric scroll of cure serious wounds #333",
"Short sword #334",
"Robe #335",
"'Flicka'",
"Drow key #337",
"Human bones #338",
"Human bones #339",
"Human bones #340",
"Human bones #341",
"Human bones #342",
"Ring #343",
"Bracers #344",
"Leather armour #345",
"Spear #346",
"Plate mail #347",
"Shield #348",
"'Severious'",
"Helmet #350",
"Paladin holy symbol #351",
"Leather boots #352",
"Leather armour #353",
"#354",
"Iron rations #355",
"Short sword #356",
"Leather boots #357",
"Leather armour #358",
"#359",
"Iron rations #360",
"Short sword #361",
"Leather boots #362",
"Leather armour #363",
"#364",
"Iron rations #365",
"Short sword #366",
"Leather boots #367",
"Leather armour #368",
"#369",
"#370",
"#371",
"Potion of speed #372",
"Arrow #373",
"Arrow #374",
"Arrow #375",
"Dwarven key #376",
"Rock #377",
"Rock #378",
"Potion of extra healing #379",
"Adamantite dart #380",
"Dagger #381",
"Orb of power #382",
"Orb of power #383",
"Orb of power #384",
"Gem #385",
"Potion of extra healing #386",
"Ring #387",
"Necklace #388",
"Wand #389",
"Orb of power #390",
"Potion of speed #391",
"Orb of power #392",
"Orb of power #393",
"Orb of power #394",
"Iron rations #395",
"Iron rations #396",
"Iron rations #397",
"Iron rations #398",
"Iron rations #399",
"Skull key #400",
"Potion of invisibility #401",
"Potion of invisibility #402",
"Potion of vitality #403",
"Potion of vitality #404",
"Potion of invisibility #405",
"Potion of invisibility #406",
"Wand #407",
"#408",
"Stone sceptre #409",
"Stone dagger #410",
"Stone medallion #411",
"Stone necklace #412",
"Stone ring #413",
"Stone holy symbol #414",
"Stone orb #415",
"Rations #416",
"Rations #417",
"Rations #418",
"Iron rations #419",
"Rations #420",
"Potion of extra healing #421",
"#422",
"#423",
"#424",
"#425",
"#426",
"#427",
"#428",
"#429",
"Potion of cure poison #430",
"Potion of cure poison #431",
"Potion of cure poison #432",
"Potion of cure poison #433",
"Holy symbol", // (sic)
"Spell book #435",
"Adamantite dart #436",
"Adamantite dart #437",
"Adamantite dart #438",
"Adamantite dart #439",
"Adamantite dart #440",
"Adamantite dart #441",
"Adamantite dart #442",
"Adamantite dart #443",
"Adamantite dart #444",
"Adamantite dart #445",
"Potion",
"Mage scroll of vampiric touch", // 447
}, EOB2ItemNames[EOB2ITEMS + 1] =
{
"-",
"Leather armour #1",
"Robe #2",
"Staff #3",
"Dagger #4",
"Short sword #5",
"Lock picks #6",
"Spellbook #7",
"Cleric holy symbol",
"Leather boots #9",
"Iron rations #10",
"#11",
"#12",
"#13",
"#14",
"#15",
"Rock #16",
"Grey key #17",
"Copper key #18",
"Set of bones #19",
"#20",
"#21",
"Axe #22",
"Chainmail #23",
"Potion of giant strength",
"Rations #25",
"Mace #26",
"Paladin's holy symbol #27",
"Parchment #28",
"Skull key #29",
"Dark moon key #30",
"Shield #31",
"Skull #32",
"Femur #33",
"Long sword #34",
"Helmet #35",
"Plate mail #36",
"Sling #37",
"Spider key #38",
"Stone gem #39",
"Stone dagger #40",
"Stone sphere",
"Stone cross",
"Stone necklace",
"Horn",
"Ring #45",
"Ring #46",
"Ring of adornment #47",
"Glass sphere #48",
"Dart #49",
"Bow #50",
"Bow #51",
"Arrow #52",
"Bracers of protection #53",
"Amulet #54",
"Cloak",
"Scale mail",
"Tome",
"Flail",
"Wand #59",
"#60",
"Two handed sword #61",
"#62",
"#63",
"Bone key #64",
"Tuning fork",
"Vial",
"Trident",
"Red gem #68",
"Green gem #69",
"Blue gem #70",
"Purple gem",
"Mantis key #72",
"Mantis idol #73",
"Polished shield #74",
"Amulet #75",
"Eye of Talon #76",
"Crystal key #77",
"Shell key #78",
"Tooth #79",
"Crystal key #80",
"Talon's tongue",
"Hilt of Talon #82",
"Crystal hammer #83",
"Starfire #84",
"Jhonas' cloak #85",
"Crimson ring #86",
"Spear",
"Banded armour #88",
"Ring of protection",
"Necklace",
"Polearm #91",
"Sceptre of kingly might",
"Khelben's coin #93",
"Coin",
"Amulet of life #95",
"Wand #96",
"Sticky paper #97",
"Amulet of life #98",
"Amulet of death #99",
"Rock #100",
"Rock #101",
"Rock #102",
"Rock #103",
"Rock #104",
"Rock #105",
"Rock #106",
"Rock #107",
"Rock #108",
"Iron rations #109",
"Iron rations #110",
"Grey key #111",
"Copper key #112",
"Mage scroll of magic missile",
"Parchment #114",
"Cleric scroll of neutralize poison #115",
"Set of bones #116",
"Cleric scroll of raise dead #117",
"Sling #118",
"North wind",
"Parchment #120",
"Mace \"Thumper\"",
"Long sword #122",
"Dagger \"Yargon\"",
"Rotten food #124",
"Leather armour #125",
"Mage scroll of blur #126",
"Magic dust #127",
"Magic dust #128",
"Magic dust #129",
"Skull key #130",
"Dagger #131",
"Robe #132",
"Axe \"The Bait\"",
"Short sword \"Sting\"",
"Leather boots #135",
"Helmet #136",
"Cleric scroll of cure serious wounds #137",
"Cleric scroll of cure serious wounds #138",
"Iron rations #139",
"Iron rations #140",
"Dark moon key #141",
"Cleric scroll of neutralize poison #142",
"Potion of cure poison #143",
"Potion of vitality #144",
"Skull #145",
"Femur #146",
"A complete set of elf bones #147",
"Spellbook #148",
"Plate mail #149",
"Shield #150",
"Long sword #151",
"Helmet #152",
"Iron rations #153",
"East wind",
"Parchment #155",
"Parchment #156",
"Parchment #157",
"Potion of speed",
"Potion of healing #159",
"Potion of healing #160",
"Rock #161",
"Mace #162",
"Skull #163",
"Mage scroll of lightning bolt #164",
"Cleric scroll of neutralize poison #165",
"A complete set of dwarf bones",
"Skull #167",
"Skull #168",
"Femur #169",
"Femur #170",
"Rock #171",
"Spider key #172",
"Skull #173",
"Femur #174",
"Rock #175",
"Rock #176",
"Dagger \"Sa Shull\"",
"Femur #178",
"Femur #179",
"Potion of cure poison #180",
"Plate mail #181",
"Long sword #182",
"Helmet #183",
"Leather boots #184",
"West wind",
"Dart #186",
"Dart #187",
"Dart #188",
"Dagger #189",
"Dagger #190",
"Leather boots #191",
"Femur #192",
"Shield #193",
"Femur #194",
"Dagger #195",
"Chainmail #196",
"Long sword #197",
"Dark moon key #198",
"Helmet #199",
"Skull #200",
"Potion of healing #201",
"Skull #202",
"Staff #203",
"Skull #204",
"Long sword \"Hath Kull\"",
"Bracers of protection #206",
"Shield #207",
"Mage scroll of haste",
"Amulet #209",
"Robe #210",
"Spider key #211",
"Iron rations #212",
"Iron rations #213",
"Iron rations #214",
"Axe #215",
"Stone gem #216",
"Spider key #217",
"Glass sphere #218",
"Glass sphere #219",
"Dark moon key #220",
"Arrow #221",
"Arrow #222",
"Potion of extra healing #223",
"Potion of healing #224",
"Dark moon key #225",
"South wind",
"Cleric scroll of raise dead #227",
"Mage scroll of detect magic",
"Mage scroll of shocking grasp",
"Mage scroll of fireball #230",
"Cloak \"Moonshade\"",
"Arrow #232",
"Arrow #233",
"Arrow #234",
"Arrow #235",
"Arrow #236",
"Arrow #237",
"Arrow #238",
"Arrow #239",
"Bow #240",
"Mage scroll of remove curse",
"Rusty dagger",
"Arrow #243",
"Arrow #244",
"Rock #245",
"Rock #246",
"Rock #247",
"Rock #248",
"Mage scroll of true seeing",
"Talon",
"Cleric scroll of create food #251",
"Cleric scroll of create food #252",
"Rations #253",
"Rations #254",
"Copper key #255",
"Mage scroll of improved identify",
"Blue gem #257",
"Green gem #258",
"Red gem #259",
"Tropelet seed #260",
"Tropelet seed #261",
"Tropelet seed #262",
"Tropelet seed #263",
"Iron rations #264",
"Iron rations #265",
"Iron rations #266",
"Iron rations #267",
"Iron rations #268",
"Iron rations #269",
"Iron rations #270",
"Iron rations #271",
"Two handed sword #272",
"Potion of healing #273",
"Potion of extra healing #274",
"Potion of vitality #275",
"Potion of extra healing #276",
"Mage scroll of lightning bolt #277",
"Wand #278",
"Copper key #279",
"Two handed sword #280",
"Cleric scroll of raise dead #281",
"Femur #282",
"Skull #283",
"Paladin's holy symbol #284",
"Ring #285",
"Parchment #286",
"Plate mail #287",
"Spellbook #288",
"Lock picks #289",
"Magic dust #290",
"Parchment #291",
"A complete set of elf bones #292",
"Magic dust #293",
"Magic dust #294",
"Mage scroll of invisibility",
"Axe #296",
"Wand #297",
"Long sword \"Hunger\"",
"Mantis key #299",
"Mage scroll of blur #300",
"Mage scroll of dispel magic",
"Iron rations #302",
"Copper key #303",
"Glass sphere #304",
"Mantis idol #305",
"Copper key #306",
"Femur #307",
"Potion of cure poison #308",
"Polearm #309",
"Shield #310",
"Short sword #311",
"Femur #312",
"Skull #313",
"Red gem #314",
"Rotten food #315",
"Rotten food #316",
"Bone key #317",
"Potion of cure poison #318",
"Potion of cure poison #319",
"Potion of cure poison #320",
"Short sword #321",
"Polearm \"Leech\"",
"Banded armour #323",
"Leather boots #324",
"Shield #325",
"Plate mail #326",
"Helmet #327",
"Potion of healing #328",
"Bracers of protection #329",
"Amulet #330",
"Glass sphere #331",
"Glass sphere #332",
"Glass sphere #333",
"Bow #334",
"Arrow #335",
"Arrow #336",
"Arrow #337",
"Arrow #338",
"Arrow #339",
"Parchment #340",
"Potion of extra healing #341",
"Cleric scroll of raise dead #342",
"Potion of cure poison #343",
"Potion of cure poison #344",
"Potion of vitality #345",
"Mage scroll of disintegrate",
"Dark moon key #347",
"Dark moon key #348",
"Dark moon key #349",
"Dark moon key #350",
"Femur #351",
"Potion of healing #352",
"Potion of healing #353",
"Potion of healing #354",
"Femur #355",
"Dagger #356",
"Femur #357",
"Femur #358",
"Bracers of protection #359",
"Robe #360",
"Leather boots #361",
"Staff #362",
"Dagger #363",
"Dagger #364",
"Potion of healing #365",
"Halberd",
"Crystal hammer #367",
"Shield #368",
"Iron rations #369",
"Rotten rations",
"Femur #371",
"Mage scroll of fireball #372",
"Mace #373",
"Short sword #374",
"Dragon skin armour",
"Wand #376",
"Skull #377",
"Femur #378",
"Rations #379",
"Chainmail #380",
"Ring #381",
"Mage scroll of hold monster",
"Polished shield #383",
"Soul gem",
"Heart gem",
"Body gem",
"Mage scroll of improved invisibility",
"Shell key #388",
"Amulet of life #389",
"Polished shield #390",
"Polished shield #391",
"Eye of Talon #392",
"Crimson key",
"Mage scroll of stone to flesh",
"Starfire #395",
"Shell key #396",
"Crystal key #397",
"Ring #398",
"Mage scroll of ice storm",
"Brahma's boots",
"Jhonas' cloak #401",
"Parchment #402",
"Polished shield #403",
"Polished shield #404",
"Polished shield #405",
"Rock #406",
"Amulet of resurrection",
"Sling #408",
"Mage scroll of wall of force",
"Stone dagger #410",
"Mage scroll of invisibility 10' radius",
"Hilt of Talon #412",
"Mage scroll of flesh to stone",
"Tooth #414",
"Femur #415",
"Femur #416",
"Skull #417",
"Femur #418",
"Femur #419",
"Femur #420",
"Skull #421",
"Rock #422",
"Mage scroll of cone of cold",
"Mapaj",
"The Shall Rejoice",
"Crimson ring #426",
"Crimson ring #427",
"Robe #428",
"Sticky paper #429",
"Mage scroll of fear",
"Plate mail #431",
"Amulet of life #432",
"Amulet of death #433",
"+1 scale mail #434",
"Shield #435",
"Long sword #436",
"Iron rations #437",
"Iron rations #438",
"Potion of extra healing #439",
"Khelben's coin #440",
"+1 scale mail #441",
"Shield #442",
"+1 short sword #443",
"Iron rations #444",
"Iron rations #445",
"Potion of extra healing #446",
"+1 scale mail #447",
"Shield #448",
"+1 short sword #449",
"Iron rations #450",
"Iron rations #451",
"Potion of extra healing #452",
"+1 scale mail #453",
"Shield #454",
"Long sword #455",
"Iron rations #456",
"Iron rations #457",
"Potion of extra healing #458",
}, EOB1MSpells[24] = {
"-",
"Armour",
"Burning Hands",
"Detect Magic",
"Magic Missile",
"Shield",
"Shocking Grasp",
"Invisibility",
"Melf's Acid Arrow",
"Stinking Cloud",
"Dispel Magic",
"Fireball",
"Flame Arrow",
"Haste",
"Hold Person",
"Invisibility 10' Radius",
"Lightning Bolt",
"Vampiric Touch",
"Fear",
"Ice Storm",
"Stoneskin",
"Cloud Kill",
"Cone of Cold",
"Hold Monster",
}, EOB2MSpells[33] = {
"-",
"Armour",
"Burning Hands",
"Detect Magic",
"Magic Missile",
"Shield",
"Shocking Grasp",
"Blur",
"Improved Identify",
"Invisibility",
"Melf's Acid Arrow",
"Dispel Magic",
"Fireball",
"Haste",
"Hold Person",
"Invisibility 10' Radius",
"Lightning Bolt",
"Vampiric Touch",
"Fear",
"Ice Storm",
"Improved Invisibility",
"Remove Curse",
"Cone of Cold",
"Hold Monster",
"Wall of Force",
"Disintegrate",
"Flesh to Stone",
"Stone to Flesh",
"True Seeing",
"Finger of Death",
"Power Word Stun",
"Bigby's Clenched Fist",
}, EOB1CSpells[25] = {
"-",
"Bless",
"Cure Light Wounds",
"Cause Light Wounds",
"Detect Magic",
"Protection From Evil",
"Aid",
"Flame Blade",
"Hold Person",
"Slow Poison",
"Create Food",
"Dispel Magic",
"Magical Vestment",
"Prayer",
"Remove Paralysis",
"Cure Serious Wounds",
"Cause Serious Wounds",
"Neutralize Poison",
"Protection From Evil 10'",
"Protection From Lightning",
"Cure Critical Wounds",
"Cause Critical Wounds",
"Flame Strike",
"Raise Dead",
"Lay on Hands",
}, EOB2CSpells[30] = {
"-",
"Bless",
"Cause Light Wounds",
"Cure Light Wounds",
"Detect Magic",
"Protection From Evil",
"Aid",
"Flame Blade",
"Hold Person",
"Slow Poison",
"Create Food & Water",
"Dispel Magic",
"Magical Vestment",
"Prayer",
"Remove Paralysis",
"Cause Serious Wounds",
"Cure Serious Wounds",
"Neutralize Poison",
"Protection From Evil 10'",
"Cause Critical Wounds",
"Cure Critical Wounds",
"Flame Strike",
"Raise Dead",
"Slay Living",
"True Seeing",
"Harm",
"Heal",
"Resurrection",
"Lay on Hands",
"Turn Undead", // 29 ($1D)
};

// 7. MODULE STRUCTURES --------------------------------------------------

EXPORT struct HintInfo eob_hintinfo[] = {
{ GID_EOB_SB1     ,  1, "Open (Amiga-O)"   , 0},
{ GID_EOB_SB1     ,  2, "Save (Amiga-S)"   , 0},
{ GID_EOB_BU2     , -1, "Left hand"        , 0},
{ GID_EOB_BU2 +  1, -1, "Right hand"       , 0},
{ GID_EOB_BU2 +  2, -1, "Backpack slot #1" , 0},
{ GID_EOB_BU2 +  3, -1, "Backpack slot #2" , 0},
{ GID_EOB_BU2 +  4, -1, "Backpack slot #3" , 0},
{ GID_EOB_BU2 +  5, -1, "Backpack slot #4" , 0},
{ GID_EOB_BU2 +  6, -1, "Backpack slot #5" , 0},
{ GID_EOB_BU2 +  7, -1, "Backpack slot #6" , 0},
{ GID_EOB_BU2 +  8, -1, "Backpack slot #7" , 0},
{ GID_EOB_BU2 +  9, -1, "Backpack slot #8" , 0},
{ GID_EOB_BU2 + 10, -1, "Backpack slot #9" , 0},
{ GID_EOB_BU2 + 11, -1, "Backpack slot #10", 0},
{ GID_EOB_BU2 + 12, -1, "Backpack slot #11", 0},
{ GID_EOB_BU2 + 13, -1, "Backpack slot #12", 0},
{ GID_EOB_BU2 + 14, -1, "Backpack slot #13", 0},
{ GID_EOB_BU2 + 15, -1, "Backpack slot #14", 0},
{ GID_EOB_BU2 + 16, -1, "Quiver"           , 0},
{ GID_EOB_BU2 + 17, -1, "Torso"            , 0},
{ GID_EOB_BU2 + 18, -1, "Wrist"            , 0},
{ GID_EOB_BU2 + 19, -1, "Head"             , 0},
{ GID_EOB_BU2 + 20, -1, "Neck"             , 0},
{ GID_EOB_BU2 + 21, -1, "Feet"             , 0},
{ GID_EOB_BU2 + 22, -1, "Belt slot #1"     , 0},
{ GID_EOB_BU2 + 23, -1, "Belt slot #2"     , 0},
{ GID_EOB_BU2 + 24, -1, "Belt slot #3"     , 0},
{ GID_EOB_BU2 + 25, -1, "Left finger"      , 0},
{ GID_EOB_BU2 + 26, -1, "Right finger"     , 0},
{               -1, -1, NULL               , 0}  // terminator
};

// 8. CODE ---------------------------------------------------------------

EXPORT void eob_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // eob_preinit()
        NewList(&ItemsList[0]);
        NewList(&ItemsList[1]);
        NewList(&SpellsList[0][0]);
        NewList(&SpellsList[0][1]);
        NewList(&SpellsList[1][0]);
        NewList(&SpellsList[1][1]);
    }

    tool_open      = eob_open;
    tool_loop      = eob_loop;
    tool_save      = eob_save;
    tool_close     = eob_close;
    tool_exit      = eob_exit;
    tool_subgadget = eob_subgadget;

    if (loaded != FUNC_EOB && !eob_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_EOB;

    make_speedbar_list(GID_EOB_SB1);
    HintInfoPtr = (struct HintInfo*) &eob_hintinfo;
    load_fimage(FUNC_EOB);
    load_aiss_images(10, 10);
    makesexlist();

    lb_makelist(&ItemsList[0],     EOB1ItemNames, EOB1ITEMS);
    lb_makelist(&SpellsList[0][0], EOB1MSpells,   24);
    lb_makelist(&SpellsList[0][1], EOB1CSpells,   25);
    lb_makelist(&ItemsList[1],     EOB2ItemNames, EOB2ITEMS);
    lb_makelist(&SpellsList[1][0], EOB2MSpells,   33);
    lb_makelist(&SpellsList[1][1], EOB2CSpells,   30);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                         TRUE,
        WA_ThinSizeGadget,                                     TRUE,
        WINDOW_Position,                                       SPECIALWPOS,
        WINDOW_ParentGroup,                                    gadgets[GID_EOB_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                 TRUE,
            LAYOUT_DeferLayout,                                TRUE,
            AddHLayout,
                AddToolbar(GID_EOB_SB1),
                AddSpace,
                CHILD_WeightedWidth,                           50,
                AddHLayout,
                    LAYOUT_VertAlignment,                      LALIGN_CENTER,
                    LAYOUT_AddChild,                           gadgets[GID_EOB_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_EOB_CH1,
                        GA_Disabled,                           TRUE,
                        CHOOSER_LabelArray,                    &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                      0,
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
                AddSpace,
                CHILD_WeightedWidth,                           50,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            LAYOUT_AddChild,                                   gadgets[GID_EOB_ST2] = (struct Gadget*)
            StringObject,
                GA_ID,                                         GID_EOB_ST2,
                GA_TabCycle,                                   TRUE,
                STRINGA_TextVal,                               gamename,
                STRINGA_MaxChars,                              19 + 1,
            StringEnd,
            Label("Saved game name:"),
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                LAYOUT_VertAlignment,                          LALIGN_CENTER,
                LAYOUT_AddChild,                               gadgets[GID_EOB_IN1] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_EOB_IN1,
                    GA_RelVerify,                              TRUE,
                    GA_TabCycle,                               TRUE,
                    INTEGER_Minimum,                           1,
                    INTEGER_Maximum,                           6,
                    INTEGER_Number,                            who + 1,
                    INTEGER_MinVisible,                        1 + 1,
                IntegerEnd,
                AddLabel("of 6"),
            LayoutEnd,
            Label("Character #:"),
            CHILD_WeightedHeight,                              0,
            AddVLayout,
                LAYOUT_BevelStyle,                             BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_Label,                                  "Character",
                AddHLayout,
                    AddVLayout,
                        AddVLayout,
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "General",
                            LAYOUT_AddChild,                   gadgets[GID_EOB_ST1] = (struct Gadget*)
                            StringObject,
                                GA_ID,                         GID_EOB_ST1,
                                GA_TabCycle,                   TRUE,
                                STRINGA_TextVal,               name[who],
                                STRINGA_MaxChars,              10 + 1,
                            StringEnd,
                            Label("Name:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN8] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN8,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            curstr[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("/"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN21] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN21,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           100,
                                    INTEGER_Number,            curexc[who],
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN9] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN9,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            maxstr[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("/"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN22] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN22,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           100,
                                    INTEGER_Number,            maxexc[who],
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Strength:"),
                            CHILD_WeightedHeight,              0,
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN10] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN10,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            curint[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN11] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN11,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            maxint[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Intelligence:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN12] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN12,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            curwis[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN13] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN13,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            maxwis[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Wisdom:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN14] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN14,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            curdex[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN15] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN15,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            maxdex[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Dexterity:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN16] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN16,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            curcon[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN17] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN17,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            maxcon[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Constitution:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN18] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN18,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            curcha[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN19] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN19,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           25,
                                    INTEGER_Number,            maxcha[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Charisma:"),
                            LAYOUT_AddChild,                   gadgets[GID_EOB_CH2] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                         GID_EOB_CH2,
                                CHOOSER_LabelArray,            &RaceOptions,
                            ChooserEnd,
                            Label("Race:"),
                            LAYOUT_AddChild,                   gadgets[GID_EOB_CH3] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                         GID_EOB_CH3,
                                GA_RelVerify,                  TRUE,
                                CHOOSER_LabelArray,            &ClassOptions,
                            ChooserEnd,
                            Label("Class:"),
                            LAYOUT_AddChild,                   gadgets[GID_EOB_CH4] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                         GID_EOB_CH4,
                                CHOOSER_Labels,                &SexList,
                            ChooserEnd,
                            Label("Sex:"),
                            LAYOUT_AddChild,                   gadgets[GID_EOB_CH5] = (struct Gadget*)
                            PopUpObject,
                                GA_ID,                         GID_EOB_CH5,
                                CHOOSER_LabelArray,            &AlignmentOptions,
                            ChooserEnd,
                            Label("Alignment:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN2] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN2,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            level1[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("/"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN3] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN3,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            level2[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                                AddLabel("/"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN4] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN4,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           99,
                                    INTEGER_Number,            level3[who],
                                    INTEGER_MinVisible,        2 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("Level:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN5] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN5,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           9999999,
                                    INTEGER_Number,            xp1[who],
                                    INTEGER_MinVisible,        7 + 1,
                                IntegerEnd,
                                AddLabel("/"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN6] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN6,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           9999999,
                                    INTEGER_Number,            xp2[who],
                                    INTEGER_MinVisible,        7 + 1,
                                IntegerEnd,
                                AddLabel("/"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN7] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN7,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           9999999,
                                    INTEGER_Number,            xp3[who],
                                    INTEGER_MinVisible,        7 + 1,
                                IntegerEnd,
                            LayoutEnd,
                            Label("XP:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN20] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN20,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           0,
                                    INTEGER_Maximum,           100,
                                    INTEGER_Number,            food[who],
                                    INTEGER_MinVisible,        3 + 1,
                                IntegerEnd,
                                AddLabel("%"),
                                CHILD_WeightedWidth,           0,
                            LayoutEnd,
                            Label("Food:"),
                            AddHLayout,
                                LAYOUT_VertAlignment,          LALIGN_CENTER,
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN23] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN23,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           -10,
                                    INTEGER_Maximum,           (game == EOB1) ?    127  :  32767 ,
                                    INTEGER_Number,            curhp[who],
                                    INTEGER_MinVisible,        (game == EOB1) ? (3 + 1) : (5 + 1),
                                IntegerEnd,
                                AddLabel("of"),
                                LAYOUT_AddChild,               gadgets[GID_EOB_IN24] = (struct Gadget*)
                                IntegerObject,
                                    GA_ID,                     GID_EOB_IN24,
                                    GA_TabCycle,               TRUE,
                                    INTEGER_Minimum,           1,
                                    INTEGER_Maximum,           (game == EOB1) ?    127  :  32767 ,
                                    INTEGER_Number,            maxhp[who],
                                    INTEGER_MinVisible,        (game == EOB1) ? (3 + 1) : (5 + 1),
                                IntegerEnd,
                            LayoutEnd,
                            Label("Hit points:"),
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        AddSpace,
                        CHILD_WeightedHeight,                  50,
                        AddHLayout,
                           AddSpace,
                           AddFImage(FUNC_EOB),
                           CHILD_WeightedWidth,                0,
                           AddSpace,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                        AddSpace,
                        CHILD_WeightedHeight,                  50,
                        AddVLayout,
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            LAYOUT_Label,                      "Items", // or perhaps "Inventory"
                            AddHLayout,
                                LAYOUT_EvenSize,               TRUE,
                                AddItem( 2), // 1st backpack
                                AddItem( 3), // 2nd backpack
                                AddSpace,
                                AddSpace,
                                AddSpace,
                                AddSpace,
                                AddSpace,
                                AddSpace,
                            LayoutEnd,
                            AddHLayout,
                                LAYOUT_EvenSize,               TRUE,
                                AddItem( 4), // 3rd backpack
                                AddItem( 5), // 4th backpack
                                AddSpace,
                                AddItem(16), // quiver
                                AddSpace,
                                AddItem(19), // head
                                AddSpace,
                                AddSpace,
                            LayoutEnd,
                            AddHLayout,
                                LAYOUT_EvenSize,               TRUE,
                                AddItem( 6), // 5th backpack
                                AddItem( 7), // 6th backpack
                                AddSpace,
                                AddSpace,
                                AddSpace,
                                AddItem(20), // neck
                                AddSpace,
                                AddSpace,
                            LayoutEnd,
                            AddHLayout,
                                LAYOUT_EvenSize,               TRUE,
                                AddItem( 8), // 7th backpack
                                AddItem( 9), // 8th backpack
                                AddSpace,
                                AddItem(18), // wrist
                                AddSpace,
                                AddItem(17), // torso
                                AddSpace,
                                AddSpace,
                            LayoutEnd,
                            AddHLayout,
                                LAYOUT_EvenSize,               TRUE,
                                AddItem(10), //  9th backpack
                                AddItem(11), // 10th backpack
                                AddSpace,
                                AddItem( 0), // left hand
                                AddItem(22), //  1st belt
                                AddItem(23), //  2nd belt
                                AddItem(24), //  3rd belt
                                AddItem( 1), // right hand
                            LayoutEnd,
                            AddHLayout,
                                LAYOUT_EvenSize,               TRUE,
                                AddItem(12), // 11th backpack
                                AddItem(13), // 12th backpack
                                AddSpace,
                                AddItem(25), // left  finger
                                AddSpace,
                                AddItem(21), // feet
                                AddSpace,
                                AddItem(26), // right finger
                            LayoutEnd,
                            AddHLayout,
                                LAYOUT_EvenSize,               TRUE,
                                AddItem(14), // 13th backpack
                                AddItem(15), // 14th backpack
                                AddSpace,
                                AddSpace,
                                AddSpace,
                                AddSpace,
                                AddSpace,
                                AddSpace,
                            LayoutEnd,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  0,
                    LayoutEnd,
                    LAYOUT_AddChild,                           gadgets[GID_EOB_VI1] = (struct Gadget*)
                    NewObject(VIRTUAL_GetClass(), NULL,
                        GA_ID,                                 GID_EOB_VI1,
                        GA_RelVerify,                          TRUE,
                        VIRTUALA_Contents,
                        HLayoutObject,
                            LAYOUT_Label,                      "Memorized Spells",
                            LAYOUT_BevelStyle,                 BVS_SBAR_VERT,
                            LAYOUT_SpaceOuter,                 TRUE,
                            AddVLayout,
                                LAYOUT_BevelStyle,             BVS_SBAR_VERT,
                                LAYOUT_SpaceOuter,             TRUE,
                                LAYOUT_Label,                  "Mage",
                                AddMSpell( 0),
                                AddMSpell( 1),
                                AddMSpell( 2),
                                AddMSpell( 3),
                                AddMSpell( 4),
                                AddMSpell( 5),
                                AddMSpell( 6),
                                AddMSpell( 7),
                                AddMSpell( 8),
                                AddMSpell( 9),
                                AddMSpell(10),
                                AddMSpell(11),
                                AddMSpell(12),
                                AddMSpell(13),
                                AddMSpell(14),
                                AddMSpell(15),
                                AddMSpell(16),
                                AddMSpell(17),
                                AddMSpell(18),
                                AddMSpell(19),
                                AddMSpell(20),
                                AddMSpell(21),
                                AddMSpell(22),
                                AddMSpell(23),
                                AddMSpell(24),
                                AddMSpell(25),
                                AddMSpell(26),
                                AddMSpell(27),
                                AddMSpell(28),
                                AddMSpell(29),
                                AddMSpell(30),
                                AddMSpell(31),
                                AddMSpell(32),
                                AddMSpell(33),
                                AddMSpell(34),
                                AddMSpell(35),
                                AddMSpell(36),
                                AddMSpell(37),
                                AddMSpell(38),
                                AddMSpell(39),
                                AddMSpell(40),
                                AddMSpell(41),
                                AddMSpell(42),
                                AddMSpell(43),
                                AddMSpell(44),
                                AddMSpell(45),
                                AddMSpell(46),
                                AddMSpell(47),
                                AddMSpell(48),
                                AddMSpell(49),
                                AddMSpell(50),
                                AddMSpell(51),
                                AddMSpell(52),
                                AddMSpell(53),
                            LayoutEnd,
                         // LAYOUT_WeightBar,                  TRUE, // this shouldn't cause a guru but does
                            AddVLayout,
                                LAYOUT_BevelStyle,             BVS_SBAR_VERT,
                                LAYOUT_SpaceOuter,             TRUE,
                                LAYOUT_Label,                  "Cleric",
                                AddCSpell( 0),
                                AddCSpell( 1),
                                AddCSpell( 2),
                                AddCSpell( 3),
                                AddCSpell( 4),
                                AddCSpell( 5),
                                AddCSpell( 6),
                                AddCSpell( 7),
                                AddCSpell( 8),
                                AddCSpell( 9),
                                AddCSpell(10),
                                AddCSpell(11),
                                AddCSpell(12),
                                AddCSpell(13),
                                AddCSpell(14),
                                AddCSpell(15),
                                AddCSpell(16),
                                AddCSpell(17),
                                AddCSpell(18),
                                AddCSpell(19),
                                AddCSpell(20),
                                AddCSpell(21),
                                AddCSpell(22),
                                AddCSpell(23),
                                AddCSpell(24),
                                AddCSpell(25),
                                AddCSpell(26),
                                AddCSpell(27),
                                AddCSpell(28),
                                AddCSpell(29),
                                AddCSpell(30),
                                AddCSpell(31),
                                AddCSpell(32),
                                AddCSpell(33),
                                AddCSpell(34),
                                AddCSpell(35),
                                AddCSpell(36),
                                AddCSpell(37),
                                AddCSpell(38),
                                AddCSpell(39),
                                AddCSpell(40),
                                AddCSpell(41),
                                AddCSpell(42),
                                AddCSpell(43),
                                AddCSpell(44),
                                AddCSpell(45),
                                AddCSpell(46),
                                AddCSpell(47),
                                AddCSpell(48),
                                AddCSpell(49),
                                AddCSpell(50),
                                AddCSpell(51),
                                AddCSpell(52),
                                AddCSpell(53),
                            LayoutEnd,
                        LayoutEnd,
                    End,
                LayoutEnd,
                MaximizeButton(GID_EOB_BU1, "Maximize Character"),
                CHILD_WeightedHeight,                          0,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                     TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_EOB_SB1);
#ifndef __MORPHOS__
    MouseData = (UWORD*) LocalMouseData;
    setpointer(FALSE, WinObject, MainWindowPtr, TRUE);
#endif

    writegadgets();
 // DISCARD ActivateLayoutGadget(gadgets[GID_EOB_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_EOB_ST1]); // problematic with tooltips
    loop();
    readgadgets();
    closewindow();
}

EXPORT void eob_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_EOB_BU1:
        readgadgets();
        maximize_man();
        writegadgets();
    acase GID_EOB_IN1:
        readgadgets();
        writegadgets();
     // DISCARD ActivateLayoutGadget(gadgets[GID_EOB_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_EOB_ST1]); // problematic with tooltips
    acase GID_EOB_CH3:
        ghost(GID_EOB_IN3, classes[theclass[who]] < 2);
        ghost(GID_EOB_IN4, classes[theclass[who]] < 3);
        ghost(GID_EOB_IN6, classes[theclass[who]] < 2);
        ghost(GID_EOB_IN7, classes[theclass[who]] < 3);
    adefault:
        if (gid >= GID_EOB_BU2 && gid <= GID_EOB_BU28)
        {   whichslot = gid - GID_EOB_BU2;
            itemwindow();
        } elif (gid >= GID_EOB_BU29 && gid <= GID_EOB_BU82)
        {   whichslot = gid - GID_EOB_BU29;
            submode = 0;
            spellwindow();
        } elif (gid >= GID_EOB_BU83 && gid <= GID_EOB_BU136)
        {   whichslot = gid - GID_EOB_BU83;
            submode = 1;
            spellwindow();
}   }   }

EXPORT FLAG eob_open(FLAG loadas)
{   if (gameopen(loadas))
    {   if     (gamesize == 33107)
        {   game = EOB1;
        } elif (gamesize == 46897)
        {   game = EOB2;
        } else
        {   DisplayBeep(NULL);
            return FALSE;
    }   }
    else
    {   return FALSE;
    }

    who = 0;
    serializemode = SERIALIZE_READ;
    serialize();
    writegadgets();
    return TRUE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_EOB
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   eitherman();

    either_st(GID_EOB_ST2, gamename);

    if (gadmode == SERIALIZE_READ)
    {   DISCARD GetAttr(INTEGER_Number, (Object*) gadgets[GID_EOB_IN1], (ULONG*) &who);
        who--;
        gadmode = SERIALIZE_WRITE;
        eitherman();
    } else
    {   // assert(gadmode == SERIALIZE_WRITE);

        DISCARD SetGadgetAttrs
        (   gadgets[GID_EOB_ST2], MainWindowPtr, NULL,
            GA_Disabled,     game != EOB2,
        TAG_DONE);
        RefreshGadgets((struct Gadget*) gadgets[GID_EOB_ST2], MainWindowPtr, NULL); // this needs an explicit refresh

        either_ch(GID_EOB_CH1, &game);
}   }

MODULE void eitherman(void)
{   int i;

    either_st(GID_EOB_ST1,            name[who]);
    either_in(GID_EOB_IN2,           &level1[who]);
    either_in(GID_EOB_IN3,           &level2[who]);
    either_in(GID_EOB_IN4,           &level3[who]);
    either_in(GID_EOB_IN5,           &xp1[who]);
    either_in(GID_EOB_IN6,           &xp2[who]);
    either_in(GID_EOB_IN7,           &xp3[who]);
    either_in(GID_EOB_IN8,           &curstr[who]);
    either_in(GID_EOB_IN9,           &maxstr[who]);
    either_in(GID_EOB_IN10,          &curint[who]);
    either_in(GID_EOB_IN11,          &maxint[who]);
    either_in(GID_EOB_IN12,          &curwis[who]);
    either_in(GID_EOB_IN13,          &maxwis[who]);
    either_in(GID_EOB_IN14,          &curdex[who]);
    either_in(GID_EOB_IN15,          &maxdex[who]);
    either_in(GID_EOB_IN16,          &curcon[who]);
    either_in(GID_EOB_IN17,          &maxcon[who]);
    either_in(GID_EOB_IN18,          &curcha[who]);
    either_in(GID_EOB_IN19,          &maxcha[who]);
    either_in(GID_EOB_IN20,          &food[who]);
    either_in(GID_EOB_IN21,          &curexc[who]);
    either_in(GID_EOB_IN22,          &maxexc[who]);
    either_in(GID_EOB_IN23, (ULONG*) &curhp[who]);
    either_in(GID_EOB_IN24, (ULONG*) &maxhp[who]);
    either_ch(GID_EOB_CH2,           &race[who]);
    either_ch(GID_EOB_CH3,           &theclass[who]);
    either_ch(GID_EOB_CH4,           &sex[who]);
    either_ch(GID_EOB_CH5,           &alignment[who]);

    if (gadmode == SERIALIZE_WRITE)
    {   ghost(GID_EOB_IN3, classes[theclass[who]] < 2);
        ghost(GID_EOB_IN4, classes[theclass[who]] < 3);
        ghost(GID_EOB_IN6, classes[theclass[who]] < 2);
        ghost(GID_EOB_IN7, classes[theclass[who]] < 3);

        for (i = 0; i < 27; i++)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_EOB_BU2 + i], MainWindowPtr, NULL,
                GA_Text, (game == EOB1) ? EOB1ItemNames[inventory[who][i]] : EOB2ItemNames[inventory[who][i]],
            TAG_DONE); // refreshes automatically
        }
        for (i = 0; i < 54; i++)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_EOB_BU29 + i], MainWindowPtr, NULL,
                GA_Text,     (game == EOB1           ) ? EOB1MSpells[spellslot[who][0][i]] : EOB2MSpells[spellslot[who][0][i]],
                GA_Disabled, (game == EOB1 && i >= 30) ? TRUE                              : FALSE,
            TAG_DONE); // refreshes automatically
        }
        for (i = 0; i < 54; i++)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_EOB_BU83 + i], MainWindowPtr, NULL,
                GA_Text,     (game == EOB1           ) ? EOB1CSpells[spellslot[who][1][i]] : EOB2CSpells[spellslot[who][1][i]],
                GA_Disabled, (game == EOB1 && i >= 30) ? TRUE                              : FALSE,
            TAG_DONE); // refreshes automatically
}   }   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
    if (game == EOB1)
    {   enforce();
        writegadgets();
}   }

MODULE void serialize(void)
{   ULONG temp;
    int   i, j, k;

    if (game == EOB1)
    {   gamename[0] = EOS;                                    // EOB1     EOB2
        offset = 2;                                           // $0..$1
    } else
    {   // assert(game == EOB2);
        offset = 0;
        if (serializemode == SERIALIZE_READ)
        {   zstrncpy(gamename, (char*) &IOBuffer[offset], 19);        //   $0.. $13
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            zstrncpy((char*) &IOBuffer[offset], gamename, 19);        //   $0.. $13
        }
        offset = 0x16;
    }

    for (i = 0; i < 6; i++)
    {   if (serializemode == SERIALIZE_READ)
        {   zstrncpy(name[i], (char*) &IOBuffer[offset], 10); // $2..$C   $16.. $20
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            zstrncpy((char*) &IOBuffer[offset], name[i], 10); // $2..$C   $16.. $20
        }
        offset += 11;

        serialize1(&curstr[i]);                               // $D        $21
        serialize1(&maxstr[i]);                               // $E        $22
        serialize1(&curexc[i]);                               // $F        $23
        serialize1(&maxexc[i]);                               // $10       $24
        serialize1(&curint[i]);                               // $11       $25
        serialize1(&maxint[i]);                               // $12       $26
        serialize1(&curwis[i]);                               // $13       $27
        serialize1(&maxwis[i]);                               // $14       $28
        serialize1(&curdex[i]);                               // $15       $29
        serialize1(&maxdex[i]);                               // $16       $2A
        serialize1(&curcon[i]);                               // $17       $2B
        serialize1(&maxcon[i]);                               // $18       $2C
        serialize1(&curcha[i]);                               // $19       $2D
        serialize1(&maxcha[i]);                               // $1A       $2E
        if (game == EOB1)
        {   serialize1s(&curhp[i]);                           // $1B
            serialize1s(&maxhp[i]);                           // $1C
        } else
        {   // assert(game == EOB2);
            offset++;                                         //           $2F
            serialize2ulong((ULONG*) &curhp[i]);              //           $30.. $31
            serialize2ulong((ULONG*) &maxhp[i]);              //           $32.. $33
        }
        offset += 2;                                          // $1D..$1E  $34.. $35
        if (serializemode == SERIALIZE_READ)
        {   serialize1(&temp);                                // $1F       $36
            race[i] = temp / 2;
            sex[i]  = temp % 2;
        } else
        {   // assert(serializemode == SERIALIZE_WRITE);
            temp = sex[i] + (race[i] * 2);
            serialize1(&temp);                                // $1F       $36
        }
        serialize1(&theclass[i]);                             // $20       $37
        serialize1(&alignment[i]);                            // $21       $38
        offset++;                                             // $22       $39
        serialize1(&food[i]);                                 // $23       $3A
        serialize1(&level1[i]);                               // $24       $3B
        serialize1(&level2[i]);                               // $25       $3C
        serialize1(&level3[i]);                               // $26       $3D
        if (game == EOB1)
        {   offset++;                                         // $27
        }
        serialize4(&xp1[i]);                                  // $28..$2B  $3E.. $41
        serialize4(&xp2[i]);                                  // $2C..$2F  $42.. $45
        serialize4(&xp3[i]);                                  // $30..$33  $46.. $49
        offset += 4;                                          // $34..$37  $4A.. $4D

        if (game == EOB1)
        {   for (j = 0; j < 30; j++)
            {   serialize1(&spellslot[i][0][j]);              // $38..$55
            }
            for (j = 0; j < 30; j++)
            {   serialize1(&spellslot[i][1][j]);              // $56..$73
            }
            for (j = 30; j < 54; j++)
            {   spellslot[i][0][j] = spellslot[i][1][j] = 0;
            }
            offset += 4;                                      // $74..$77
        } else
        {   for (j = 0; j < 6; j++)                           //           $4E.. $89
            {   for (k = 0; k < 9; k++)
                {   serialize1(&spellslot[i][0][(j * 9) + k]);
                }
                offset++;
            }
            offset += 20;                                     //           $8A.. $9D
            for (j = 0; j < 6; j++)                           //           $9E.. $D9
            {   for (k = 0; k < 9; k++)
                {   serialize1(&spellslot[i][1][(j * 9) + k]);
                }
                offset++;
            }
            offset += 24;                                     //           $DA.. $F1
        }

        for (j = 0; j < 27; j++)
        {   serialize2ulong(&inventory[i][j]);                // $78..$AD  $F2..$127
        }
        offset += (game == EOB1) ? 0x48 :  72;                // $AE..$F5 $128..$16F
}   }

EXPORT void eob_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  EOB1:
        gamesave("EOBDATA#?.SAV", "EOB1", saveas, gamesize, FLAG_S, FALSE);
    acase EOB2:
        gamesave("EOBDATA#?.SAV", "EOB2", saveas, gamesize, FLAG_S, FALSE);
}   }

EXPORT void eob_close(void) { ; }

EXPORT void eob_exit(void)
{   lb_clearlist(&ItemsList[0]);
    lb_clearlist(&ItemsList[1]);
    lb_clearlist(&SpellsList[0][0]);
    lb_clearlist(&SpellsList[0][1]);
    lb_clearlist(&SpellsList[1][0]);
    lb_clearlist(&SpellsList[1][1]);
    ch_clearlist(&SexList);
}

MODULE void maximize_man(void)
{   food[who]                               =     100;
    curhp[who]  = maxhp[who]                =     100;

    level1[who]                             =      90;
    xp1[who]                                = 9000000;
    if (theclass[who] >= 6) // double- or triple-classed
    {   level2[who]                         =      90;
        xp2[who]                            = 9000000;

        if (theclass[who] == 9 || theclass[who] == 12) // triple-classed
        {   level3[who]                     =      90;
            xp3[who]                        = 9000000;
    }   }
    enforce();

    curstr[who] = maxstr[who] =
    curint[who] = maxint[who] =
    curwis[who] = maxwis[who] =
    curdex[who] = maxdex[who] =
    curcon[who] = maxcon[who] =
    curcha[who] = maxcha[who] =  25;
    curexc[who] = maxexc[who] =   0;
}

MODULE void enforce(void)
{   int limit,
        whichman;

    if (game == EOB2)
    {   return;
    }

    for (whichman = 0; whichman < 6; whichman++)
    {   if   (theclass[whichman] ==  2) limit = 22; // paladin
        elif (theclass[whichman] ==  3) limit = 11; // mage
        elif (theclass[whichman] ==  4
         ||   theclass[whichman] == 11
         ||   theclass[whichman] == 14) limit = 10; // C or C/T or C/M
        else                            limit = 99;
        if (level1[whichman] > (ULONG) limit)
        {   level1[whichman] = (ULONG) limit;
        }

        if (theclass[whichman] <= 5) // single-classed
        {   level2[whichman] = 0;
        } else
        {   if  ((theclass[whichman] >= 8 && theclass[whichman] <= 10)
             ||   theclass[whichman] == 14) limit = 11; // F/M or F/M/T or T/M or C/M
            elif (theclass[whichman] ==  6
             ||   theclass[whichman] == 12
             ||   theclass[whichman] == 13) limit = 10; // F/C or F/C/M or R/C
            else                            limit = 99;
            if (level2[whichman] > (ULONG) limit)
            {   level2[whichman] = (ULONG) limit;
        }   }

        if (theclass[whichman] != 9 && theclass[whichman] != 12)
        {   level3[whichman] = 0;
        } else
        {   if   (theclass[whichman] == 12) limit = 11; // F/C/M
            else                            limit = 99; // F/M/T
            if (level3[whichman] > (ULONG) limit)
            {   level3[whichman] = (ULONG) limit;
}   }   }   }

MODULE void itemwindow(void)
{   PERSIST WORD leftx  = -1,
                 topy   = -1,
                 width  = -1,
                 height = -1;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Choose Item",
        (leftx  != -1) ? WA_Left         : TAG_IGNORE, leftx,
        (topy   != -1) ? WA_Top          : TAG_IGNORE, topy,
        (width  != -1) ? WA_Width        : TAG_IGNORE, width,
        (height != -1) ? WA_Height       : TAG_IGNORE, height,
        (leftx  == -1) ? WINDOW_Position : TAG_IGNORE, WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "eob-1",
        WINDOW_ParentGroup,                    gadgets[GID_EOB_LY2] = (struct Gadget*)
        VLayoutObject,
            GA_ID,                             GID_EOB_LY2,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_SpaceInner,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_EOB_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_EOB_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &ItemsList[game],
                LISTBROWSER_Selected,          inventory[who][whichslot],
                LISTBROWSER_MakeVisible,       inventory[who][whichslot],
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    240,
            CHILD_MinHeight,                   440,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    submode = 2;
    subloop();

    leftx  = SubWindowPtr->LeftEdge;
    topy   = SubWindowPtr->TopEdge;
    width  = SubWindowPtr->Width;
    height = SubWindowPtr->Height;

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

MODULE void spellwindow(void)
{   PERSIST WORD leftx  = -1,
                 topy   = -1,
                 width  = -1,
                 height = -1;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Choose Spell",
        (leftx  != -1) ? WA_Left         : TAG_IGNORE, leftx,
        (topy   != -1) ? WA_Top          : TAG_IGNORE, topy,
        (width  != -1) ? WA_Width        : TAG_IGNORE, width,
        (height != -1) ? WA_Height       : TAG_IGNORE, height,
        (leftx  == -1) ? WINDOW_Position : TAG_IGNORE, WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "eob-2",
        WINDOW_ParentGroup,                    gadgets[GID_EOB_LY3] = (struct Gadget*)
        VLayoutObject,
            GA_ID,                             GID_EOB_LY3,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_SpaceInner,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_EOB_LB2] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_EOB_LB2,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &SpellsList[game][submode],
                LISTBROWSER_Selected,          spellslot[who][submode][whichslot],
                LISTBROWSER_MakeVisible,       spellslot[who][submode][whichslot],
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    240,
            CHILD_MinHeight,                   240,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    subloop();

    leftx  = SubWindowPtr->LeftEdge;
    topy   = SubWindowPtr->TopEdge;
    width  = SubWindowPtr->Width;
    height = SubWindowPtr->Height;

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG eob_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        if (submode == 2)
        {   if (lb_move_up(GID_EOB_LB1, SubWindowPtr, qual, &inventory[who][whichslot], 0, 5))
            {   writegadgets(); // overkill
        }   }
        else
        {   if (lb_move_up(GID_EOB_LB2, SubWindowPtr, qual, &spellslot[who][submode][whichslot], 0, 5))
            {   writegadgets(); // overkill
        }   }
    acase NM_WHEEL_DOWN:
    case SCAN_DOWN:
        switch (submode)
        {
        case 0:
            if (lb_move_down(GID_EOB_LB2, SubWindowPtr, qual, &spellslot[who][0][whichslot], (game == EOB1) ? (24-1) : (33-1), 5))
            {   writegadgets(); // overkill
            }
        acase 1:
            if (lb_move_down(GID_EOB_LB2, SubWindowPtr, qual, &spellslot[who][1][whichslot], (game == EOB1) ? (25-1) : (30-1), 5))
            {   writegadgets(); // overkill
            }
        acase 2:
            if (lb_move_down(GID_EOB_LB1, SubWindowPtr, qual, &inventory[who][whichslot], (game == EOB1) ? EOB1ITEMS : EOB2ITEMS, 5))
            {   writegadgets(); // overkill
    }   }   }

    return FALSE;
}

EXPORT FLAG eob_subgadget(ULONG gid, UWORD code)
{   switch (gid)
    {
    case GID_EOB_LB1:
        inventory[who][whichslot] = code;
        writegadgets(); // overkill
    return TRUE;
    case GID_EOB_LB2:
        spellslot[who][submode][whichslot] = code;
        writegadgets(); // overkill
    return TRUE;
    }

    return FALSE;
}

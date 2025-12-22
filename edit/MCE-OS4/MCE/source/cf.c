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

#define EDITRESERVES
// enable this if you want to allow editing of friendly reserves

#define GID_CF_LY1   0 // root layout
#define GID_CF_SB1   1 // toolbar
#define GID_CF_BU1   2 // maximize
// GID_CF_IN1 is spare
#define GID_CF_CH14  3 // next mission
#define GID_CF_IN2   4 // friendly reserves
#define GID_CF_IN3   5 // friendlies killed ("Home")
#define GID_CF_IN4   6 // enemies killed ("Away")
#define GID_CF_IN5   7 // 1st hero kills
#define GID_CF_IN6   8 // 2nd hero kills
#define GID_CF_IN7   9 // 3rd hero kills
#define GID_CF_IN8  10 // 4th hero kills
#define GID_CF_IN9  11 // 5th hero kills
#define GID_CF_IN10 12 // 1st squad kills
#define GID_CF_IN11 13 // 2nd squad kills
#define GID_CF_IN12 14 // 3rd squad kills
#define GID_CF_IN13 15 // 4th squad kills
#define GID_CF_IN14 16 // 5th squad kills
#define GID_CF_IN15 17 // 6th squad kills
#define GID_CF_CH1  18 // 1st hero rank
#define GID_CF_CH2  19 // 2nd hero rank
#define GID_CF_CH3  20 // 3rd hero rank
#define GID_CF_CH4  21 // 4th hero rank
#define GID_CF_CH5  22 // 5th hero rank
#define GID_CF_CH6  23 // 1st squad rank
#define GID_CF_CH7  24 // 2nd squad rank
#define GID_CF_CH8  25 // 3rd squad rank
#define GID_CF_CH9  26 // 4th squad rank
#define GID_CF_CH10 27 // 5th squad rank
#define GID_CF_CH11 28 // 6th squad rank
#define GID_CF_BU2  29 // 1st hero name
#define GID_CF_BU3  30 // 2nd hero name
#define GID_CF_BU4  31 // 3rd hero name
#define GID_CF_BU5  32 // 4th hero name
#define GID_CF_BU6  33 // 5th hero name
#define GID_CF_BU7  34 // 1st squad name
#define GID_CF_BU8  35 // 2nd squad name
#define GID_CF_BU9  36 // 3rd squad name
#define GID_CF_BU10 37 // 4th squad name
#define GID_CF_BU11 38 // 5th squad name
#define GID_CF_BU12 39 // 6th squad name
// GID_CF_BU13..14 are spare
#define GID_CF_BU15 40 // sort heroes
#define GID_CF_BU16 41 // next phase
#define GID_CF_RA1  42 // view as

#define GID_CF_LY2  43
#define GID_CF_LB1  44

#define GID_CF_LY3  45
#define GID_CF_LB2  46

#define GIDS_CF    GID_CF_LB2

#define MISSIONS    24
#define NAMES      360
#define PHASES      72

#define RankGadget(x)  LAYOUT_AddChild, gadgets[GID_CF_CH1 + x] = (struct Gadget*) PopUpObject,   GA_ID, GID_CF_CH1 + x, CHOOSER_Labels, &RankList, CHOOSER_MaxLabels, 17, End
#define NameGadget(x)  LAYOUT_AddChild, gadgets[GID_CF_BU2 + x] = (struct Gadget*) ZButtonObject, GA_ID, GID_CF_BU2 + x, GA_RelVerify, TRUE, BUTTON_Justification, BCJ_LEFT, ButtonEnd
#define KillsGadget(x) LAYOUT_AddChild, gadgets[GID_CF_IN5 + x] = (struct Gadget*) IntegerObject, GA_ID, GID_CF_IN5 + x, GA_TabCycle, TRUE, INTEGER_Minimum, 0, INTEGER_Maximum, 65535, INTEGER_MinVisible, 5 + 1, IntegerEnd

#define GAME_CF1     0
#define GAME_CF2     1

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void namewindow(void);
MODULE void sortscores(void);
MODULE void phasewindow(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            propfontx;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
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

MODULE int                  whichman,
                            whichwin;
MODULE UBYTE                heroflag[5];
// MODULE UWORD             grave[NAMES];
MODULE ULONG                enemieskilled,
                            friendlieskilled,
                            kills[11],
                            name[11],
                            phasesleft,
                            rank[11],
                            nextmission,
                            nextphase,
                            sparemen,
                            viewas            = GAME_CF1;
MODULE struct List          NamesList1,
                            NamesList2,
                            PhaseList1,
                            PhaseList2,
                            RankList;

MODULE const STRPTR GameOptions[2 + 1] =
{   "Cannon Fodder 1",
    "Cannon Fodder 2",
    NULL
}, RankOptions[16] = {
"Private",               //  $0 >
"Corporal",              //  $1 >>
"Sergeant",              //  $2 >>>
"Staff Sergeant",        //  $3
"Sergeant 1st Class",    //  $4
"Master Sergeant",       //  $5
"Sergeant Major",        //  $6
"Specialist 4",          //  $7
"Specialist 6",          //  $8
"Warrant Officer",       //  $9
"Chief Warrant Officer", //  $A
"Captain",               //  $B
"Major",                 //  $C
"Colonel",               //  $D
"Brigadier-General",     //  $E
"General",               //  $F
// no NULL is required
}, Names1[NAMES + 1] = {
"Jools",       //    0
"Jops",        //    1
"Stoo",        //    2
"RJ",          //    3
"Ubik",        //    4
"CJ",          //    5
"Chris",       //    6
"Pete",        //    7
"Tadger",      //    8
"Hector",      //    9
"Elroy",       //   $A
"Softy",       //   $B
"Mac",         //   $C
"Bomber",      //   $D
"Stan",        //   $E
"Tosh",        //   $F
"Brains",      //  $10
"Norm",        //  $11
"Buster",      //  $12
"Spike",       //  $13
"Browny",      //  $14
"Murphy",      //  $15
"Killer",      //  $16
"Abdul",       //  $17
"Spotty",      //  $18
"Goofy",       //  $19
"Donald #26",  //  $1A
"Windy",       //  $1B
"Nifta",       //  $1C
"Denzil",      //  $1D
"Cedric",      //  $1E
"Alf #31",     //  $1F
"Marty",       //  $20
"Cecil",       //  $21
"Wally",       //  $22
"Pervy",       //  $23
"Jason",       //  $24
"Roy",         //  $25
"Peewee",      //  $26
"Arnie",       //  $27
"Lofty",       //  $28
"Tubby",       //  $29
"Porky",       //  $2A
"Norris",      //  $2B
"Bugsy",       //  $2C
"Greg",        //  $2D
"Gus",         //  $2E
"Ginger",      //  $2F
"Eddy",        //  $30
"Steve",       //  $31
"Hugo",        //  $32
"Zippy",       //  $33
"Sonny",       //  $34
"Willy #53",   //  $35
"Mario",       //  $36
"Luigi",       //  $37
"Bo",          //  $38
"Johan",       //  $39
"Colin",       //  $3A
"Queeny",      //  $3B
"Morgan",      //  $3C
"Reg",         //  $3D
"Peter",       //  $3E
"Brett",       //  $3F
"Matt",        //  $40
"Vic",         //  $41
"Hut",         //  $42
"Bud",         //  $43
"Brad",        //  $44
"Ashley",      //  $45
"Les",         //  $46
"Rex",         //  $47
"Louis",       //  $48
"Pedro",       //  $49
"Marco",       //  $4A
"Leon",        //  $4B
"Ali",         //  $4C
"Tyson",       //  $4D
"Tiger",       //  $4E
"Frank",       //  $4F
"Reuben",      //  $50
"Leyton",      //  $51
"Josh",        //  $52
"Judas",       //  $53
"AJ",          //  $54
"Lex",         //  $55
"Butch",       //  $56
"Bison",       //  $57
"Gary #88",    //  $58
"Luther",      //  $59
"Kermit",      //  $5A
"Brian",       //  $5B
"Ray",         //  $5C
"Freak",       //  $5D
"Leroy",       //  $5E
"Lee",         //  $5F
"Banjo",       //  $60
"Beaker",      //  $61
"Basil",       //  $62
"Bonzo",       //  $63
"Kelvin",      //  $64
"Ronnie #101", //  $65
"Rupert",      //  $66
"Roo",         //  $67
"Dan",         //  $68
"Jimmy",       //  $69
"Ronnie #106", //  $6A
"Bob",         //  $6B
"Don #108",    //  $6C
"Tommy",       //  $6D
"Eddie",       //  $6E
"Ozzy",        //  $6F
"Mark #112",   //  $70
"Paddy",       //  $71
"Arnold",      //  $72
"Tony",        //  $73
"Teddy",       //  $74
"Don #117",    //  $75
"Theo",        //  $76
"Martin",      //  $77
"Chunky",      //  $78
"Jon",         //  $79
"Ben #122",    //  $7A
"Girly",       //  $7B
"Julian",      //  $7C
"Gary #125",   //  $7D
"Pizza",       //  $7E
"Mark #127",   //  $7F
"Ciaran",      //  $80
"Jock",        //  $81
"Gravy",       //  $82
"Trendy",      //  $83
"Neil",        //  $84
"Derek",       //  $85
"Ed",          //  $86
"Steve #135",  //  $87
"Biff",        //  $88
"Steve #137",  //  $89
"Paul",        //  $8A
"Stuart",      //  $8B
"Randy",       //  $8C
"Loreta",      //  $8D
"Suzie",       //  $8E
"Pumpy",       //  $8F
"Urmer",       //  $90
"Roger",       //  $91
"Pussy",       //  $92
"Meat",        //  $93
"Beefy",       //  $94
"Harry",       //  $95
"Tiny",        //  $96
"Howard",      //  $97
"Morris",      //  $98
"Thor",        //  $99
"Rev",         //  $9A
"Duke",        //  $9B
"Willy #156",  //  $9C
"Micky",       //  $9D
"Chas",        //  $9E
"Melony",      //  $9F
"Craig",       //  $A0
"Sidney",      //  $A1
"Parson",      //  $A2
"Rowan",       //  $A3
"Smelly",      //  $A4
"Dok",         //  $A5
"Stew",        //  $A6
"Donald #167", //  $A7
"Adrian",      //  $A8
"Pat",         //  $A9
"Iceman",      //  $AA
"Goose",       //  $AB
"Dippy",       //  $AC
"Viv",         //  $AD
"Fags",        //  $AE
"Bunty",       //  $AF
"Noel",        //  $B0
"Bono",        //  $B1
"Edge",        //  $B2
"Robbie",      //  $B3
"Sean",        //  $B4
"Miles",       //  $B5
"Jimi",        //  $B6
"Gordon",      //  $B7
"Val",         //  $B8
"Hobo",        //  $B9
"Fungus",      //  $BA
"Toilet",      //  $BB
"Lampy",       //  $BC
"Marcus",      //  $BD
"Pele",        //  $BE
"Hubert",      //  $BF
"James",       //  $C0
"Tim #193",    //  $C1
"Saul #194",   //  $C2
"Andy",        //  $C3
"Alf #196",    //  $C4
"Silky",       //  $C5
"Simon",       //  $C6
"Handy",       //  $C7
"Sid",         //  $C8
"George",      //  $C9
"Joff",        //  $CA
"Barry",       //  $CB
"Dick",        //  $CC
"Gil",         //  $CD
"Nick",        //  $CE
"Ted",         //  $CF
"Phil",        //  $D0
"Woody",       //  $D1
"Wynn",        //  $D2
"Alan",        //  $D3
"Pip",         //  $D4
"Mickey",      //  $D5
"Justin",      //  $D6
"Karl",        //  $D7
"MadDog",      //  $D8
"Horace",      //  $D9
"Harold",      //  $DA
"Gazza",       //  $DB
"Spiv",        //  $DC
"Foxy",        //  $DD
"Ned",         //  $DE
"Bazil",       //  $DF
"Oliver",      //  $E0
"Rett",        //  $E1
"Scot",        //  $E2
"Darren",      //  $E3
"Edwin #228",  //  $E4
"Moses",       //  $E5
"Noah",        //  $E6
"Seth",        //  $E7
"Buddah",      //  $E8
"Mary",        //  $E9
"Pilot",       //  $EA
"McBeth",      //  $EB
"McDuff",      //  $EC
"Belly",       //  $ED
"Mathew",      //  $EE
"Mark #239",   //  $EF
"Luke",        //  $F0
"John",        //  $F1
"Aslan",       //  $F2
"Ham",         //  $F3
"Shem",        //  $F4
"Joshua",      //  $F5
"Jacob",       //  $F6
"Esaw",        //  $F7
"Omar",        //  $F8
"Saul #249",   //  $F9
"Enoch",       //  $FA
"Obadia",      //  $FB
"Daniel",      //  $FC
"Samuel",      //  $FD
"Ben #254",    //  $FE
"Robbo",       //  $FF
"Joebed",      // $100
"Ismael",      // $101
"Isreal",      // $102
"Isabel",      // $103
"Isarat",      // $104
"Monk",        // $105
"Blip",        // $106
"Bacon",       // $107
"Danube",      // $108
"Friend",      // $109
"Darryl",      // $10A
"Izzy",        // $10B
"Crosby",      // $10C
"Stills",      // $10D
"Nash",        // $10E
"Young",       // $10F
"Cheese",      // $110
"Salami",      // $111
"Prawn",       // $112
"Radish",      // $113
"Edbert",      // $114
"Edwy",        // $115
"Edgar",       // $116
"Edwin #279",  // $117
"Edred",       // $118
"Eggpie",      // $119
"Bros",        // $11A
"Sonic",       // $11B
"Ziggy",       // $11C
"Alfred",      // $11D
"Siggy",       // $11E
"Hilda",       // $11F
"Smell",       // $120
"Sparks",      // $121
"Spook",       // $122
"TopCat",      // $123
"Benny",       // $124
"Dibble",      // $125
"Benker",      // $126
"Dosey",       // $127
"Beaky",       // $128
"Joist",       // $129
"Pivot",       // $12A
"Tree",        // $12B
"Bush",        // $12C
"Grass",       // $12D
"Seedy",       // $12E
"Tim #303",    // $12F
"Rollo",       // $130
"Zippo",       // $131
"Nancy",       // $132
"Larry",       // $133
"Iggy",        // $134
"Nigel",       // $135
"Jamie",       // $136
"Jesse",       // $137
"Leo",         // $138
"Virgo",       // $139
"Garth",       // $13A
"Fidel",       // $13B
"Idi",         // $13C
"Che",         // $13D
"Kirk",        // $13E
"Spock",       // $13F
"MacCoy",      // $140
"Chekov",      // $141
"Uhura",       // $142
"Bones",       // $143
"Vulcan",      // $144
"Fester",      // $145
"Jethro",      // $146
"Jimbob",      // $147
"Declan",      // $148
"Dalek",       // $149
"Hickey",      // $14A
"Chocco",      // $14B
"Goch",        // $14C
"Pablo",       // $14D
"Renoir",      // $14E
"Rolf",        // $14F
"Dali",        // $150
"Monet",       // $151
"Manet",       // $152
"Gaugin",      // $153
"Chagal",      // $154
"Kid",         // $155
"Hully",       // $156
"Robert",      // $157
"Piers",       // $158
"Raith",       // $159
"Jeeves",      // $15A
"Paster",      // $15B
"Adolf",       // $15C
"Deiter",      // $15D
"Demi",        // $15E
"Zark",        // $15F
"Wizkid",      // $160
"Wizard",      // $161
"Iain",        // $162
"Kitten",      // $163
"Gonner",      // $164
"Waster",      // $165
"Loser",       // $166
"Fodder",      // $167
"-"            // $168
}, Names2[NAMES + 1] = {
"Jools",       //    0
"Jops",        //    1
"Stu",         //    2
"JL",          //    3
"RJ",          //    4
"Jonny",       //    5
"Ace",         //    6
"Bill",        //    7
"Cam",         //    8
"Dave",        //    9
"Eric",        //   $A
"Frank",       //   $B
"Gary",        //   $C
"Hicky",       //   $D
"Iain",        //   $E
"James",       //   $F
"Ken",         //  $10
"Les",         //  $11
"Matt",        //  $12
"Wutts",       //  $13
"OJ",          //  $14
"Paul #21",    //  $15
"Quinn",       //  $16
"Roger",       //  $17
"Steve #24",   //  $18
"Tim",         //  $19
"Ulric",       //  $1A
"Vern",        //  $1B
"Will",        //  $1C
"Xerxes",      //  $1D
"Yehudi",      //  $1E
"Zippy",       //  $1F
"Tucker",      //  $20
"Mucker",      //  $21
"Ducker",      //  $22
"Lucker",      //  $23
"Bingo",       //  $24
"Bongo",       //  $25
"Lance",       //  $26
"Brett",       //  $27
"Duglas",      //  $28
"Liam",        //  $29
"Noel",        //  $2A
"Poppy",       //  $2B
"Barney",      //  $2C
"Daniel",      //  $2D
"Burton",      //  $2E
"Rohan",       //  $2F
"Ryan",        //  $30
"Philip",      //  $31
"Edward",      //  $32
"Boothy",      //  $33
"Mitch",       //  $34
"Humpy",       //  $35
"Tracey",      //  $36
"Wicksy",      //  $37
"Pridd",       //  $38
"Witton",      //  $39
"Ian",         //  $3A
"Oscar #59",   //  $3B
"Louis",       //  $3C
"Simon",       //  $3D
"Shane",       //  $3E
"Holly",       //  $3F
"Paul #64",    //  $40
"Pedro",       //  $41
"Washer",      //  $42
"Mark",        //  $43
"Cliff",       //  $44
"Woody",       //  $45
"Sam",         //  $46
"Yuri",        //  $47
"Neil",        //  $48
"Buzz",        //  $49
"Friday",      //  $4A
"Steve #75",   //  $4B
"Mick #76",    //  $4C
"Chris",       //  $4D
"Stoo",        //  $4E
"Chip",        //  $4F
"John",        //  $50
"CD",          //  $51
"Cheesy",      //  $52
"Helmut",      //  $53
"Susan",       //  $54
"Ivor",        //  $55
"Thomas",      //  $56
"Bod",         //  $57
"Rod",         //  $58
"Jane",        //  $59
"Freddy",      //  $5A
"Jason",       //  $5B
"Norman",      //  $5C
"Burke",       //  $5D
"Hare",        //  $5E
"Reuben",      //  $5F
"Calvin",      //  $60
"Hobbes",      //  $61
"Alex",        //  $62
"Kenny",       //  $63
"Gordon",      //  $64
"Jinky",       //  $65
"Archie",      //  $66
"Willie",      //  $67
"Jock",        //  $68
"Orange",      //  $69
"White",       //  $6A
"Pink",        //  $6B
"Blonde",      //  $6C
"Blue",        //  $6D
"Brown",       //  $6E
"Eddie",       //  $6F
"Joe",         //  $70
"Vic",         //  $71
"Bob",         //  $72
"Stan",        //  $73
"Ollie",       //  $74
"Derek",       //  $75
"Clive",       //  $76
"Tarby",       //  $77
"Brucie",      //  $78
"Curly",       //  $79
"Larry",       //  $7A
"Moe",         //  $7B
"Wolf",        //  $7C
"Trojan",      //  $7D
"Shadow",      //  $7E
"Cobra",       //  $7F
"Ulrika",      //  $80
"Fash",        //  $81
"Steve #130",  //  $82
"Jimbob",      //  $83
"Henry",       //  $84
"Nigel",       //  $85
"Sean",        //  $86
"Flynn",       //  $87
"Ernie",       //  $88
"Bert",        //  $89
"Benny",       //  $8A
"Martyn",      //  $8B
"Albert",      //  $8C
"Harold",      //  $8D
"Ringo",       //  $8E
"Gomez",       //  $8F
"Fester",      //  $90
"Lurch",       //  $91
"Thing",       //  $92
"Tom",         //  $93
"Jerry",       //  $94
"Butch",       //  $95
"Spike",       //  $96
"Sticky",      //  $97
"Justin",      //  $98
"Dustin",      //  $99
"Edmond",      //  $9A
"Jethro",      //  $9B
"Lucy",        //  $9C
"Stinky",      //  $9D
"Wayne",       //  $9E
"Garth",       //  $9F
"Darth",       //  $A0
"Kirk",        //  $A1
"Scotty",      //  $A2
"Bones",       //  $A3
"Wesley",      //  $A4
"Gyles",       //  $A5
"Steve #166",  //  $A6
"Brian",       //  $A7
"Ted",         //  $A8
"Humpty",      //  $A9
"Hamble",      //  $AA
"Richey",      //  $AB
"Nelson",      //  $AC
"Plug",        //  $AD
"Wilbur",      //  $AE
"Fatty",       //  $AF
"Wakko",       //  $B0
"Yakko",       //  $B1
"Dot",         //  $B2
"Boo",         //  $B3
"Slappy",      //  $B4
"Brain",       //  $B5
"Pinky",       //  $B6
"Porky",       //  $B7
"Daffy",       //  $B8
"Taz",         //  $B9
"Hugh",        //  $BA
"Jake",        //  $BB
"Molly",       //  $BC
"Bull",        //  $BD
"Axel",        //  $BE
"Elmer",       //  $BF
"Tweety",      //  $C0
"Roggy",       //  $C1
"Compo",       //  $C2
"Clegg",       //  $C3
"Shaggy",      //  $C4
"Scooby",      //  $C5
"Velma",       //  $C6
"Daphne",      //  $C7
"Fred",        //  $C8
"Dougal",      //  $C9
"Hector",      //  $CA
"Dylan",       //  $CB
"Benito",      //  $CC
"Joseph",      //  $CD
"Adolf",       //  $CE
"Idi",         //  $CF
"Nero",        //  $D0
"Pol",         //  $D1
"Bomber",      //  $D2
"Arnie",       //  $D3
"Rutger",      //  $D4
"Sly",         //  $D5
"Clint",       //  $D6
"Dennis",      //  $D7
"Harvey",      //  $D8
"Keanu",       //  $D9
"Claude",      //  $DA
"Kylie",       //  $DB
"Bjork",       //  $DC
"Eimar",       //  $DD
"Conan",       //  $DE
"Mary",        //  $DF
"Mungo",       //  $E0
"Midge",       //  $E1
"Cagney",      //  $E2
"Lacey",       //  $E3
"Bodie",       //  $E4
"Doyle",       //  $E5
"Regan",       //  $E6
"Carter",      //  $E7
"Tosh",        //  $E8
"Fitz",        //  $E9
"Dixon",       //  $EA
"Holmes",      //  $EB
"Watson",      //  $EC
"Purdey",      //  $ED
"Gambit",      //  $EE
"Steed",       //  $EF
"David",       //  $F0
"Maddie",      //  $F1
"Terry",       //  $F2
"Arthur",      //  $F3
"Del",         //  $F4
"Rodney",      //  $F5
"Buddy",       //  $F6
"Glenn",       //  $F7
"Kurt",        //  $F8
"Phil",        //  $F9
"Marc",        //  $FA
"River",       //  $FB
"Janis",       //  $FC
"Sid",         //  $FD
"Nancy",       //  $FE
"Jamie",       //  $FF
"Keith",       // $100
"Dexter",      // $101
"Rocky",       // $102
"Burt",        // $103
"Ripley",      // $104
"Parker",      // $105
"Ash",         // $106
"Dallas",      // $107
"Cain",        // $108
"Jones",       // $109
"Hicks",       // $10A
"Hudson",      // $10B
"Bishop",      // $10C
"Newt",        // $10D
"Romeo",       // $10E
"Juliet",      // $10F
"Tony",        // $110
"Cleo",        // $111
"Bonnie",      // $112
"Clyde",       // $113
"Ike",         // $114
"Tina",        // $115
"Sonny",       // $116
"Cher",        // $117
"Donny",       // $118
"Marie",       // $119
"Rene",        // $11A
"Renato",      // $11B
"Peters",      // $11C
"Lee",         // $11D
"Adam",        // $11E
"Eve",         // $11F
"Fink",        // $120
"Ratty",       // $121
"Mean",        // $122
"Link",        // $123
"Jesse",       // $124
"Bo",          // $125
"Luke",        // $126
"Virgil",      // $127
"Scott",       // $128
"Alan",        // $129
"Troy",        // $12A
"PJ",          // $12B
"Duncan",      // $12C
"Robin",       // $12D
"Marion",      // $12E
"Rico",        // $12F
"Mike",        // $130
"Andy",        // $131
"Johnny",      // $132
"Steve #307",  // $133
"Craig",       // $134
"Fletch",      // $135
"Goober",      // $136
"MacKay",      // $137
"Grouty",      // $138
"Paddy",       // $139
"Taffy",       // $13A
"Mick #315",   // $13B
"Pele",        // $13C
"Zico",        // $13D
"Falcao",      // $13E
"Bebeto",      // $13F
"Cafu",        // $140
"Branco",      // $141
"Careca",      // $142
"Junior",      // $143
"Cesar",       // $144
"Ryu",         // $145
"Cammy",       // $146
"Bison",       // $147
"Honda",       // $148
"Vega",        // $149
"Blanka",      // $14A
"Cage",        // $14B
"Kano",        // $14C
"Rayden",      // $14D
"Sonya",       // $14E
"Goro",        // $14F
"Shang",       // $150
"Sonic",       // $151
"Tails",       // $152
"Zool",        // $153
"Putty",       // $154
"Wizkid",      // $155
"PacMan",      // $156
"Bubsy",       // $157
"Oscar #344",  // $158
"Wario",       // $159
"Yoshi",       // $15A
"Max",         // $15B
"Akira",       // $15C
"Tetsuo",      // $15D
"Bozo",        // $15E
"Heidi",       // $15F
"Odie",        // $160
"Rebel",       // $161
"Shep",        // $162
"Fire",        // $163
"Fear",        // $164
"Mortis",      // $165
"Death",       // $166
"Custer",      // $167
"-"            // $168
}, MissionNames[2][MISSIONS + 1] = { {
"1: The Sensible Initiation" ,
"2: Onward Virgin Soldiers"  ,
"3: Antarctic Adventure"     ,
"4: Super Smashing Namtastic",
"5: Those Vicious Vikings"   ,
"6: Westward Ho"             ,
"7: Greenland Redblood"      ,
"8: Guerilla Warfare"        ,
"9: Great Scott Good Shot"   ,
"10: One Gigantic Dust Bowl" ,
"11: Jungle Bloody Jungle"   ,
"12: Chiller Thriller Killer",
"13: Moors Murderers"        ,
"14: Bomb Alley"             ,
"15: Get Orf Moi Laand"      ,
"16: Going Underground"      ,
"17: The Moor the Merrier"   ,
"18: Underpants Electric"    ,
"19: Diablo Downstairs"      ,
"20: Moors the Pity"         ,
"21: Explore my Hole"        ,
"22: Desert Disaster"        ,
"23: Moors et Mortem"        ,
"24: Bomb the Base"          ,
NULL
}, {
"1: This is How it Begins"   ,
"2: My Love has got a Gun"   ,
"3: I Want to Kill Somebody" ,
"4: I Believe in Space"      ,
"5: Lady Love your Country"  ,
"6: The Swords of 1000 Men"  ,
"7: Ticky Ticky Timebomb"    ,
"8: 1 2 X U"                 ,
"9: All This and More"       ,
"10: Ooh, Faye Dunaway"      ,
"11: Smile with Mr Ukelele"  ,
"12: IDontMindBeingOnMyOwn"  ,
"13: New Guys in Town"       ,
"14: Freak You Melon Farmer" ,
"15: Between Planets"        ,
"16: Been Drivin' for Days Now",
"17: Kasimir S Pulaski Day"  ,
"18: Travel's in my Blood"   ,
"19: Forest Butcher Boy"     ,
"20: Look at that Ugly Moon" ,
"21: Shocker in Gloomtown"   ,
"22: A Star for Everyone"    ,
"23: Eve of Destruction"     ,
"24: Wish them all Dead"     ,
NULL
} },
PhaseNames[2][PHASES] = { {
"1.1: It's a Jungle Out There"  , 
"2.1: Bridge over the River Pie", 
"2.2: Trash Enemy HQ"           , 
"3.1: Bugger Me It's Cold"      , 
"4.1: Beachy Head"              , 
"4.2: Pier Pressure"            , 
"4.3: Village People"           , 
"4.4: Quicksand"                , 
"5.1: The Valley of Ice"        , 
"5.2: A Nice Set of Bazookas"   , 
"5.3: My Beautiful Skidoo"      , 
"6.1: The Grand Canyon"         , 
"6.2: Trigger Happy"            , 
"7.1: The Slippery Stairway"    , 
"7.2: Return to Reykjavik"      , 
"7.3: Evil Knievel"             , 
"8.1: Have a Nice Trip"         , 
"8.2: Bang Bang You're Dead"    , 
"8.3: Deliverance"              , 
"8.4: Jeep Jump"                , 
"9.1: Round the Garden"         , 
"9.2: In at the Deep End"       , 
"10.1: Square Dance"            , 
"10.2: Penny for the Guy"       , 
"10.3: Tanky in the Middle"     , 
"10.4: If It Moves Kill It"     , 
"10.5: A Good Hard Tank"        , 
"11.1: Lord of the Flies"       , 
"11.2: Whopper Chopper"         , 
"11.3: Donkeytastic"            , 
"12.1: An Icicle Made for Two"  , 
"12.2: Tank You Very Much"      , 
"12.3: Death and Glory"         , 
"12.4: North Face of the Eiger" , 
"12.5: Rescue El Presidente"    , 
"12.6: Chill Out Iceman"        , 
"13.1: Much Much Moor"          , 
"14.1: It's all Mine"           , 
"14.2: Sandy Crack"             , 
"14.3: Airlift"                 , 
"15.1: Sheep Dip"               , 
"15.2: Chocs Away Chappies"     , 
"15.3: A Bridge too Far"        , 
"16.1: Eton Rifles"             , 
"16.2: Sewers Canal"            , 
"17.1: No Way In"               , 
"18.1: Take your Partners"      , 
"18.2: The Scroungers"          , 
"18.3: Plenty of Room"          , 
"18.4: Franz Klammer"           , 
"18.5: The Doors"               , 
"19.1: Look Out"                , 
"20.1: Tank Top"                , 
"20.2: Tanktastic"              , 
"20.3: The Great Escape"        , 
"20.4: Whoopeee"                , 
"21.1: Too Many Man"            , 
"22.1: Rocket Man"              , 
"22.2: Running out of Ideas"    , 
"22.3: And They're Off"         , 
"22.4: Go for It"               , 
"23.1: Sheep Shearer's Delight" , 
"23.2: Ireland Records"         , 
"23.3: Gawd Help Me"            , 
"23.4: Chopper Crazy"           , 
"23.5: Stop the Pigeon"         , 
"24.1: Save that Scumbag"       , 
"24.2: One Man Three Choppers"  , 
"24.3: A Watery Grave"          , 
"24.4: System Off"              , 
"24.5: Stick em up Cod Breath"  , 
"24.6: DeathtasticElastic"      , 
// no NULL is required
}, {
"1.1: Happy Days are Here Again", //  1
"2.1: Boom Bang a Bang"         , //  2
"2.2: This ain't Pizmo Beach"   ,
"2.3: Take me I'm Yours"        , 
"3.1: Compound Fracture"        , //  5 
"3.2: Say it with Rockets"      , 
"3.3: Tipper Topper"            , 
"3.4: Is it a Bird?"            , 
"4.1: T'm going out of my Way"  , //  9
"4.2: Hang with me Joe"         , 
"4.3: Uh Oh, We're in Trouble"  , 
"5.1: A Bit of Bully"           , // 12
"5.2: Wizard Pranks"            , 
"6.1: An Englishman's Home"     , // 14
"6.2: Assault and Battering"    , 
"6.3: Back to the Future"       ,
"7.1: Feersum Endjinn"          , // 17
"7.2: Never Saw it Coming"      , 
"7.3: In the Middle with You"   , 
"7.4: Just this one to Go"      , 
"8.1: Terminal Beach"           , // 21
"8.2: Desert Eagles"            , 
"9.1: Choppa Stoppa"            , // 23
"9.2: A Dip in the Pool"        , 
"9.3: Collateral Damage"        , 
"9.4: You can Run"              , 
"9.5: Don't wanna get Stoned"   , 
"10.1: Watusi Rodeo"            , // 28
"10.2: A Knight on the Town"    , 
"11.1: Vegetable Men"           , // 30
"12.1: Lost in a Forest"        , // 31
"12.2: Speedway Star"           ,
"12.3: Idiot Country"           ,
"12.4: Wish the Lads were Here" ,
"12.5: Someone Give her a Gun"  ,
"12.6: eretuF eht ot kcaB"      ,
"13.1: Mean Streets"            , // 37
"13.2: The Old Main Drag"       , 
"14.1: A Rain's gonna Come"     , // 39 
"14.2: William Tell Me"         , 
"14.3: Freeway Enterprise"      , 
"14.4: Ambush City Limits"      , 
"15.1: Quarantine"              , // 43
"15.2: Unchained Melodies"      , 
"16.1: Gridlock"                , // 45
"16.2: Sidewalking"             , 
"16.3: Right Across the Street" , 
"17.1: I Wish I could Fly"      , // 48
"18.1: Lover's Leap"            , // 49
"18.2: The Road from Hell"      , 
"19.1: F Klammer Strikes Again" , // 51
"19.2: All the Same to Me"      , 
"19.3: Two's Company"           , 
"19.4: Charlie Whiskey"         , 
"20.1: The Web in Front"        , // 55
"21.1: There's a Riot Goin' On" , // 56
"21.2: Shopper's Paradise"      , 
"21.3: Cheddington"             , 
"21.4: Kiss Kiss Molly's Lips"  , 
"22.1: Take it to the Bridge"   , // 60
"22.2: No Quarters Given"       , 
"22.3: Feel the Pain"           , 
"22.4: Gary Gilmore's Eyes"     , 
"22.5: Closing in on Death"     , 
"23.1: Six Million and Four"    , // 65
"23.2: Places not to Go To"     , 
"24.1: Faraway but too Close"   , // 67
"24.2: Return to Bloody Dove"   , 
"24.3: Hotdogs with Everything" , 
"24.4: Jesus had a Twin"        , 
"24.5: A Sea with Three Stars"  , 
"24.6: Catch 23"                ,
// no NULL is required
} };

MODULE const int mission_to_phase[2][MISSIONS] = { {
 1,
 2,
 4,
 5,
 9,
12,
14,
17,
21,
23,
28,
31,
37,
38,
41,
44,
46,
47,
52,
53,
57,
58,
62,
67
}, {
 1,
 2,
 5,
 9,
12,
14,
17,
21,
23,
28,
30,
31,
37,
39,
43,
45,
48,
49,
51,
55,
56,
60,
65,
67
} };

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   int mission,
        phasesleft;
} phases[2][PHASES] = { {
{ 1, 1 }, //  1
{ 2, 2 }, //  2
{ 2, 1 },
{ 3, 1 }, //  4
{ 4, 4 }, //  5
{ 4, 3 },
{ 4, 2 },
{ 4, 1 },
{ 5, 3 }, //  9
{ 5, 2 },
{ 5, 1 },
{ 6, 2 }, // 12
{ 6, 1 },
{ 7, 3 }, // 14
{ 7, 2 },
{ 7, 1 },
{ 8, 4 }, // 17
{ 8, 3 },
{ 8, 2 },
{ 8, 1 },
{ 9, 2 }, // 21
{ 9, 1 },
{10, 5 }, // 23
{10, 4 },
{10, 3 },
{10, 2 },
{10, 1 },
{11, 3 }, // 28
{11, 2 },
{11, 1 },
{12, 6 }, // 31
{12, 5 },
{12, 4 },
{12, 3 },
{12, 2 },
{12, 1 },
{13, 1 }, // 37
{14, 3 }, // 38
{14, 2 },
{14, 1 },
{15, 3 }, // 41
{15, 2 },
{15, 1 },
{16, 2 }, // 44
{16, 1 },
{17, 1 }, // 46
{18, 5 }, // 47
{18, 4 },
{18, 3 },
{18, 2 },
{18, 1 },
{19, 1 }, // 52
{20, 4 }, // 53
{20, 3 },
{20, 2 },
{20, 1 },
{21, 1 }, // 57
{22, 4 }, // 58
{22, 3 },
{22, 2 },
{22, 1 },
{23, 5 }, // 62
{23, 4 },
{23, 3 },
{23, 2 },
{23, 1 },
{24, 6 }, // 67
{24, 5 },
{24, 4 },
{24, 3 },
{24, 2 },
{24, 1 }  // 72
}, {
{ 1, 1 }, //  1
{ 2, 3 }, //  2
{ 2, 2 },
{ 2, 1 },
{ 3, 4 }, //  5
{ 3, 3 },
{ 3, 2 },
{ 3, 1 },
{ 4, 3 }, //  9
{ 4, 2 },
{ 4, 1 },
{ 5, 2 }, // 12
{ 5, 1 },
{ 6, 3 }, // 14
{ 6, 2 },
{ 6, 1 },
{ 7, 4 }, // 17
{ 7, 3 },
{ 7, 2 },
{ 7, 1 },
{ 8, 2 }, // 21
{ 8, 1 },
{ 9, 5 }, // 23
{ 9, 4 },
{ 9, 3 },
{ 9, 2 },
{ 9, 1 },
{10, 2 }, // 28
{10, 1 },
{11, 1 }, // 30
{12, 6 }, // 31
{12, 5 },
{12, 4 },
{12, 3 },
{12, 2 },
{12, 1 },
{13, 2 }, // 37
{13, 1 },
{14, 4 }, // 39
{14, 3 },
{14, 2 },
{14, 1 },
{15, 2 }, // 43
{15, 1 },
{16, 3 }, // 45
{16, 2 },
{16, 1 },
{17, 1 }, // 48
{18, 2 }, // 49
{18, 1 },
{19, 4 }, // 51
{19, 3 },
{19, 2 },
{19, 1 },
{20, 1 }, // 55
{21, 4 }, // 56
{21, 3 },
{21, 2 },
{21, 1 },
{22, 5 }, // 60
{22, 4 },
{22, 3 },
{22, 2 },
{22, 1 },
{23, 2 }, // 65
{23, 1 },
{24, 6 }, // 67
{24, 5 },
{24, 4 },
{24, 3 },
{24, 2 },
{24, 1 }  // 72
} };

// 8. CODE ---------------------------------------------------------------

EXPORT void cf_main(void)
{   TRANSIENT struct ChooserNode* ChooserNodePtr;
    PERSIST   FLAG                first = TRUE;

    if (first)
    {   first = FALSE;

        // cf_preinit();
        NewList(&NamesList1);
        NewList(&NamesList2);
        NewList(&PhaseList1);
        NewList(&PhaseList2);
        NewList(&RankList);

        // cf_init()
        lb_makelist(&NamesList1, Names1,        NAMES + 1);
        lb_makelist(&NamesList2, Names2,        NAMES + 1);
        lb_makelist(&PhaseList1, PhaseNames[0], PHASES);
        lb_makelist(&PhaseList2, PhaseNames[1], PHASES);
    }

    tool_open      = cf_open;
    tool_loop      = cf_loop;
    tool_save      = cf_save;
    tool_close     = cf_close;
    tool_exit      = cf_exit;
    tool_subgadget = cf_subgadget;

    if (loaded != FUNC_CF && !cf_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_CF;

    make_speedbar_list(GID_CF_SB1);
    ch_load_images(361, 376, RankOptions, &RankList);
    if (!(ChooserNodePtr = (struct ChooserNode*) AllocChooserNode // the 17th node
    (   CNA_Text, "-",
    TAG_DONE)))
    {   rq("Can't create chooser.gadget node(s)!");
    }
    AddTail(&RankList, (struct Node*) ChooserNodePtr); // AddTail() has no return code
    load_aiss_images(10, 10);
    load_aiss_images(15, 15);

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_LockHeight,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_CF_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_SpaceInner,                             TRUE,
            AddToolbar(GID_CF_SB1),
            AddHLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,                     BVS_GROUP,
                    LAYOUT_SpaceOuter,                     TRUE,
                    LAYOUT_Label,                          "General",
                    LAYOUT_AddChild,                       gadgets[GID_CF_CH14] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_CF_CH14,
                        GA_RelVerify,                      TRUE,
                        CHOOSER_LabelArray,                &MissionNames[viewas],
                        CHOOSER_MaxLabels,                 24,
                    End,
                    Label("Next mission:"),
                    LAYOUT_AddChild,                       gadgets[GID_CF_BU16] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                             GID_CF_BU16,
                        GA_RelVerify,                      TRUE,
                        BUTTON_Justification,              BCJ_LEFT,
                    ButtonEnd,
                    Label("Next phase:"),
                    LAYOUT_AddChild,                       gadgets[GID_CF_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_CF_IN2,
#ifdef EDITRESERVES
                        GA_TabCycle,                       TRUE,
                        INTEGER_MinVisible,                3 + 1,
#else
                        GA_ReadOnly,                       TRUE,
                        GA_Disabled,                       TRUE,
                        INTEGER_Arrows,                    FALSE,
                        INTEGER_MinVisible,                3,
#endif
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   (nextmission + 1) * 15,
                    IntegerEnd,
                    Label("Friendlies in reserve:"),
                    LAYOUT_AddChild,                       gadgets[GID_CF_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_CF_IN3,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   360,
                        INTEGER_MinVisible,                3 + 1,
                    IntegerEnd,
                    Label("Friendlies killed:"),
                    LAYOUT_AddChild,                       gadgets[GID_CF_IN4] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                             GID_CF_IN4,
                        GA_TabCycle,                       TRUE,
                        INTEGER_Minimum,                   0,
                        INTEGER_Maximum,                   32767,
                        INTEGER_MinVisible,                5 + 1,
                    IntegerEnd,
                    Label("Enemies killed:"),
                LayoutEnd,
                AddVLayout,
                    AddSpace,
                    AddHLayout,
                        LAYOUT_BevelStyle,                 BVS_GROUP,
                        LAYOUT_SpaceOuter,                 TRUE,
                        LAYOUT_Label,                      "View/edit as",
                        LAYOUT_AddChild,                   gadgets[GID_CF_RA1] = (struct Gadget*)
                        RadioButtonObject,
                            GA_ID,                         GID_CF_RA1,
                            GA_RelVerify,                  TRUE,
                            GA_Text,                       GameOptions,
                            RADIOBUTTON_Selected,          (WORD) viewas,
                        RadioButtonEnd,
                    LayoutEnd,
                    CHILD_WeightedHeight,                  0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
            AddVLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "(Dead) Heroes",
                AddHLayout,
                    AddVLayout,
                        RankGadget(0),
                        Label("1st:"),
                        RankGadget(1),
                        Label("2nd:"),
                        RankGadget(2),
                        Label("3rd:"),
                        RankGadget(3),
                        Label("4th:"),
                        RankGadget(4),
                        Label("5th:"),
                    LayoutEnd,
                    AddVLayout,
                        NameGadget(0),
                        NameGadget(1),
                        NameGadget(2),
                        NameGadget(3),
                        NameGadget(4),
                    LayoutEnd,
                    CHILD_MinWidth,                        propfontx * (11 + 2),
                    AddVLayout,
                        KillsGadget(0),
                        Label("Kills:"),
                        KillsGadget(1),
                        Label("Kills:"),
                        KillsGadget(2),
                        Label("Kills:"),
                        KillsGadget(3),
                        Label("Kills:"),
                        KillsGadget(4),
                        Label("Kills:"),
                    LayoutEnd,
                LayoutEnd,
                SortButton(GID_CF_BU15, "Sort Heroes"),
            LayoutEnd,
            AddHLayout,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_Label,                              "(Living) Squad",
                AddVLayout,
                    RankGadget(5),
                    Label("1st:"),
                    RankGadget(6),
                    Label("2nd:"),
                    RankGadget(7),
                    Label("3rd:"),
                    RankGadget(8),
                    Label("4th:"),
                    RankGadget(9),
                    Label("5th:"),
                    RankGadget(10),
                    Label("6th:"),
                LayoutEnd,
                AddVLayout,
                    NameGadget(5),
                    NameGadget(6),
                    NameGadget(7),
                    NameGadget(8),
                    NameGadget(9),
                    NameGadget(10),
                LayoutEnd,
                CHILD_MinWidth,                            propfontx * (11 + 2),
                AddVLayout,
                    KillsGadget(5),
                    Label("Kills:"),
                    KillsGadget(6),
                    Label("Kills:"),
                    KillsGadget(7),
                    Label("Kills:"),
                    KillsGadget(8),
                    Label("Kills:"),
                    KillsGadget(9),
                    Label("Kills:"),
                    KillsGadget(10),
                    Label("Kills:"),
                LayoutEnd,
            LayoutEnd,
            MaximizeButton(GID_CF_BU1, "Maximize Game"),
        LayoutEnd,
        CHILD_NominalSize,                                 TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_CF_SB1);
    writegadgets();
#ifdef EDITRESERVES
    DISCARD ActivateLayoutGadget(gadgets[GID_CF_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_CF_IN2]);
#else
    DISCARD ActivateLayoutGadget(gadgets[GID_CF_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_CF_IN3]);
#endif
    loop();
    readgadgets();
    closewindow();
}

EXPORT void cf_loop(ULONG gid, UNUSED ULONG code)
{   int i;

    switch (gid)
    {
    case GID_CF_BU1:
        readgadgets();

        friendlieskilled =                      0;
     // sparemen         = (nextmission + 1) * 15;
        for (i = 5; i < 11; i++)
        {   rank[i] = 0xF; // general
        }

        writegadgets();
    acase GID_CF_BU15:
        sortscores();
    acase GID_CF_BU16:
        readgadgets();
        phasewindow();
        nextmission = phases[viewas][nextphase].mission - 1;
        phasesleft = phases[viewas][nextphase].phasesleft;
        writegadgets();
    acase GID_CF_RA1:
        DISCARD GetAttr(RADIOBUTTON_Selected, (Object*) gadgets[GID_CF_RA1 ], (ULONG*) &viewas);
        DISCARD SetGadgetAttrs
        (   gadgets[GID_CF_CH14], MainWindowPtr, NULL,
            CHOOSER_LabelArray, &MissionNames[viewas],
        TAG_DONE); // this autorefreshes
        writegadgets();
    acase GID_CF_CH14:
        DISCARD GetAttr(CHOOSER_Selected,     (Object*) gadgets[GID_CF_CH14], (ULONG*) &nextmission);
        nextphase = mission_to_phase[viewas][nextmission] - 1;
        phasesleft = phases[viewas][nextphase].phasesleft;
        writegadgets();
    adefault:
        if (gid >= GID_CF_BU2 && gid <= GID_CF_BU12)
        {   whichman = gid - GID_CF_BU2;
            readgadgets();
            namewindow();
            writegadgets();
}   }   }

MODULE void sortscores(void)
{   int   i, j;
    ULONG tempnum;

    // This bubble sorts them from highest to lowest.

    readgadgets();

    for (i = 0; i < 5 - 1; i++)
    {   for (j = 0; j < 5 - i - 1; j++)
        {   if
            (   kills[j    ]
              < kills[j + 1]
            )
            {   tempnum          = kills[j    ];
                kills[j    ] = kills[j + 1];
                kills[j + 1] = tempnum;

                tempnum          = name[j    ];
                name[j    ]  = name[j + 1];
                name[j + 1]  = tempnum;

                tempnum          = rank[j    ];
                rank[j    ]  = rank[j + 1];
                rank[j + 1]  = tempnum;
    }   }   }

    writegadgets();
}

EXPORT FLAG cf_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_CF
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();

    for (i = 0; i < 11; i++)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_CF_BU2 + i], MainWindowPtr, NULL,
            GA_Text, (viewas == GAME_CF1) ? Names1[name[i]] : Names2[name[i]],
        TAG_DONE); // this autorefreshes        
    }
    DISCARD SetGadgetAttrs
    (   gadgets[GID_CF_BU16], MainWindowPtr, NULL,
        GA_Text, PhaseNames[viewas][nextphase],
    TAG_DONE); // this autorefreshes        
    DISCARD SetGadgetAttrs
    (   gadgets[GID_CF_IN2], MainWindowPtr, NULL,
        INTEGER_Maximum, (nextmission + 1) * 15,
    TAG_DONE); // this autorefreshes
}

MODULE void eithergadgets(void)
{   int i;

    either_in(GID_CF_IN2,  &sparemen);
    either_in(GID_CF_IN3,  &friendlieskilled);
    either_in(GID_CF_IN4,  &enemieskilled);

    either_ch(GID_CF_CH14, &nextmission);

    for (i = 0; i < 11; i++)
    {   either_in(GID_CF_IN5 + i, &kills[i]);
        either_ch(GID_CF_CH1 + i, &rank[i]);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    offset = 0x1;
    serialize1(&nextphase);          //   $1

    offset = 0xD;
    nextmission++;
    serialize1(&nextmission);        //   $D
    nextmission--;

    offset = 0x12;
    serialize2ulong(&sparemen);      //  $12.. $13

    offset = 0x35;
    serialize1(&phasesleft);         //  $35

    offset = 0x3E;
    for (i = 5; i < 11; i++)
    {   if (name[i] == NAMES)
        {   name[i] = 0xFFFF;
        }
        serialize2ulong(&name[i]);   //  $3E.. $3F
        if (name[i] == 0xFFFF)
        {   name[i] = NAMES;
        }

        if (rank[i] == 0x10)
        {   rank[i] = 0xFF;
        }
        serialize1(&rank[i]);        //  $40
        if (rank[i] == 0xFF)
        {   rank[i] = 0x10;
        }

        offset += 7;                 //  $41.. $47

        if (name[i] == NAMES)
        {   kills[i] = 65535; // unused heroes have $FFFF kills
        }
        serialize2ulong(&kills[i]);  //  $48.. $49
        if (name[i] == NAMES)
        {   kills[i] = 0;
    }   }

 /* offset = 0x116;
    for (i = 0; i < NAMES; i++)
    {   serialize2uword(&grave[i]);  // $116..$3E5
    } */

    offset = 0x6D2;
    for (i = 0; i < 5; i++)
    {   if (rank[i] == 0x10)
        {   rank[i] = 0xFF;
        }
        serialize1(&rank[i]);        // $6D2
        if (rank[i] == 0xFF)
        {   rank[i] = 0x10;
        }

        heroflag[i] = (rank[i] < 0x10) ? 0x00 : 0xFF; // is there something similar for squad members?
        serialize1to1(&heroflag[i]); // $6D3

        if (name[i] == NAMES)
        {   name[i] = 0xFFFF;
        }
        serialize2ulong(&name[i]);   // $6D4..$6D5
        if (name[i] == 0xFFFF)
        {   name[i] = NAMES;
        }

        if (name[i] == NAMES)
        {   kills[i] = 0; // unused squaddies have $0000 kills
        }
        serialize2ulong(&kills[i]);  // $6D6..$6D7
        if (name[i] == NAMES)
        {   kills[i] = 0;
    }   }

    offset = 0x6F7;
    serialize1(&friendlieskilled);   // $6F7
    offset++;                        // $6F8
    serialize1(&enemieskilled);      // $6F9
}

EXPORT void cf_save(FLAG saveas)
{   int i, j;

    readgadgets();

    for (i = 0; i < 11; i++)
    {   for (j = 0; j < 11; j++)
        {   if (i != j && name[i] < NAMES && name[i] == name[j])
            {   say("Can't save, because there are duplicated soldiers!", REQIMAGE_WARNING);
                return;
    }   }   }

    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?", "Cannon Fodder 1/2", saveas, 1832, FLAG_S, FALSE);
}

EXPORT void cf_close(void) { ; }

EXPORT void cf_exit(void)
{   ch_clearlist(&RankList);
}
EXPORT void cf_die(void)
{   lb_clearlist(&NamesList1);
    lb_clearlist(&NamesList2);
    lb_clearlist(&PhaseList1);
    lb_clearlist(&PhaseList2);
}

MODULE void namewindow(void)
{   whichwin = 0;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              "Choose Name",
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "cf-1",
        WINDOW_ParentGroup,                    gadgets[GID_CF_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_CF_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_CF_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (viewas == GAME_CF1) ? ((ULONG) &NamesList1) : ((ULONG) &NamesList2),
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    propfontx * (11 + 2) + 16, // extra width is for scroller
            CHILD_MinHeight,                   384,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    DISCARD SetGadgetAttrs(         gadgets[GID_CF_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) name[whichman], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_CF_LB1], SubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(         gadgets[GID_CF_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) name[whichman], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_CF_LB1], SubWindowPtr, NULL);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

EXPORT FLAG cf_subgadget(ULONG gid, UNUSED UWORD code)
{   switch (gid)
    {
    case GID_CF_LB1:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_CF_LB1], (ULONG*) &name[whichman]);
        return TRUE;
    acase GID_CF_LB2:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_CF_LB2], (ULONG*) &nextphase);
        return TRUE;
    }

    return FALSE;
}

EXPORT FLAG cf_subkey(UWORD code, UWORD qual)
{   switch (code)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        lb_scroll_up(  (whichwin == 0) ? GID_CF_LB1 : GID_CF_LB2, SubWindowPtr, qual);
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_scroll_down((whichwin == 0) ? GID_CF_LB1 : GID_CF_LB2, SubWindowPtr, qual);
    }

    return FALSE;
}

MODULE void phasewindow(void)
{   whichwin = 1;

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_Title,                              "Choose Phase",
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "cf-2",
        WINDOW_ParentGroup,                    gadgets[GID_CF_LY3] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_CF_LB2] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_CF_LB2,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (viewas == GAME_CF1) ? ((ULONG) &PhaseList1) : ((ULONG) &PhaseList2),
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    propfontx * (25 + 2) + 16, // extra width is for scroller
            CHILD_MinHeight,                   384,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    DISCARD SetGadgetAttrs(         gadgets[GID_CF_LB2], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) nextphase, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_CF_LB2], SubWindowPtr, NULL);
    DISCARD SetGadgetAttrs(         gadgets[GID_CF_LB2], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) nextphase, TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_CF_LB2], SubWindowPtr, NULL);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;
}

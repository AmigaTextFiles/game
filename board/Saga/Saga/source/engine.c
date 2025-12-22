// 1. INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#else
    #define ZERO (BPTR) NULL
#endif

#include <exec/types.h>

#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <proto/locale.h>

#include <graphics/gels.h>

#include <stdio.h>                     // sprintf()
#include <stdlib.h>                    // rand()
#include <string.h>                    // strcpy(), strcat()
// #define ASSERT
#include <assert.h>

#include "shared.h"
#include "saga.h"

#define CATCOMP_NUMBERS
#include "saga_strings.h"

#ifdef EXTRAVERBOSE
    #include <clib/alib_protos.h>      // Printf()
#endif

// 2. DEFINES ------------------------------------------------------------

#define NORMAL  0
#define GOOD    1
#define BAD     2

#define HAGALL  1
#define IS      2
#define JARA    3
#define NIED    4
#define WYNN    5
#define YR      6

#define DRAGON  0
#define DROW    1
#define GIANT   2
#define GHOST   3
#define TROLL   4
#define WITCH   5
#define HYDRA   6
#define SERPENT 7
#define KRAKEN  8

// 3. EXPORTED VARIABLES -------------------------------------------------

EXPORT struct RuneStruct rune[RUNES + 1] =
{ { "Amsir", ""},
  { "Eon"  , ""},
  { "Geofu", ""},
  { "Ing"  , ""},
  { "Ogal" , ""},
  { "Sygil", ""}
};
EXPORT struct JarlStruct jarl[JARLS + 1] =
{ { 2, 3, "Amleth"    },
  { 3, 3, "Bjarki"    },
  { 3, 3, "Erik"      },
  { 2, 2, "Eyjolf"    },
  { 3, 2, "Gretter"   },
  { 2, 2, "Hagen"     },
  { 2, 3, "Harald"    },
  { 2, 3, "Helgi"     },
  { 2, 2, "Hengist"   },
  { 2, 2, "Horsi"     },
  { 4, 2, "Hrolfwulf" },
  { 4, 2, "Ivar"      },
  { 4, 3, "Kari"      },
  { 2, 3, "Skallagrim"},
  { 3, 3, "Thorolf"   },
  { 2, 3, "Thorvald"  },
  { 3, 3, "Welland"   },
  { 3, 3, "Wiglar"    }
};

/* 1 x 4-3 .
   2 x 4-2 ..
   5 x 3-3 .....
   1 x 3-2 .
   5 x 2-3 .....
   4 x 2-2 ....

                   11 have move   of 3, 7 have move   of 2.
3 have attack of 4, 6 have attack of 3, 9 have attack of 2. */

EXPORT struct HeroStruct hero[HEROES + 1];
EXPORT struct SordStruct sord[SORDS + 1] =
{ { "Balmung (+1)"    ,   7},
  { "Dragvendill (+2)",  77},
  { "Gram (+2)"       , 107},
  { "Hrunting (+1)"   , 137},
  { "Lovi (+1)"       , 180},
  { "Tyrfing (+2)"    , 237}
};

EXPORT struct TreasureStruct treasure[TREASURES + 1] =
{ {""         ,   7},
  {"Frey Faxi",  97},
  {""         , 147},
  {""         , 197},
  {""         , 247},
  {""         , 297},
  {""         , 347},
  {""         , 397}
};

EXPORT struct MonsterStruct monster[MONSTERS + 1] =
{ { DRAGON,  10, 1, "Aludreng" , 6, 5 },
  { DRAGON,  11, 2, "Fafnir"   , 6, 5 },
  { DRAGON,  10, 2, "Glerion"  , 6, 5 },
  { DRAGON,  10, 2, "Hallbjorn", 6, 5 },
  { DRAGON,   9, 3, "Istvan"   , 6, 5 },
  { DRAGON,  11, 2, "Stigandi" , 6, 5 },
  { DROW,     2, 2, "Atli"     , 3, 2 },
  { DROW,     3, 1, "Gizur"    , 3, 2 },
  { DROW,     3, 1, "Hallgerd" , 3, 2 },
  { GHOST,    4, 2, "Gizar"    , 2, 2 },
  { GHOST,    4, 1, "Glam"     , 2, 2 },
  { GHOST,    4, 0, "Gunnar"   , 2, 2 },
  { GHOST,    4, 0, "Hrap"     , 2, 2 },
  { GHOST,    4, 1, "Mord"     , 2, 2 },
  { GHOST,    4, 1, "Trogrier" , 2, 2 },
  { GIANT,    7, 0, "Angantyr" , 4, 3 },
  { GIANT,    6, 1, "Hall"     , 4, 3 },
  { GIANT,    8, 1, "Storvick" , 4, 3 },
  { TROLL,    6, 2, "Grendall" , 3, 3 },
  { TROLL,    5, 2, "Hallbjorn", 3, 3 },
  { TROLL,    5, 1, "Hauk"     , 3, 3 },
  { TROLL,    6, 1, "Hogshead" , 3, 3 },
  { TROLL,    5, 3, "Onund"    , 3, 3 },
  { TROLL,    5, 2, "Svinafell", 3, 3 },
  { WITCH,    3, 4, "Gerdrak"  , 5, 4 },
  { WITCH,    3, 5, "Grunhild" , 5, 4 },
  { WITCH,    4, 4, "Hedin"    , 5, 4 },
  { HYDRA,   12, 1, "Anschar"  , 7, 5 },
  { HYDRA,   13, 1, "Hardrada" , 7, 5 },
  { SERPENT, 12, 2, "Olaf"     , 7, 5 },
  { SERPENT, 13, 1, "Petro"    , 7, 5 },
  { KRAKEN,  14, 4, "Irving"   , 8, 5 },
};

/* These are the statistical distribution of the taxation factors:
    4×  2 tax
   10×  3 tax
    3x  4 tax
    3x  5 tax
    6x  6 tax
    4x  7 tax
    1x  8 tax
    2x  9 tax
    3x 10 tax */

EXPORT struct WorldStruct world[36 + 30] =
{   {590, 11 +  39,  3, LAND,      "Finmark"  ,      { 1, -1, -1, -1, -1, -1, -1, -1} }, // 1:1 ( 0) (inland)
    {584, 11 + 104,  3, LAND,      "Trondheim",      { 0,  2,  3, 60, -1, -1, -1, -1} }, // 1:2 ( 1)
    {489, 11 + 102,  6, LAND,      "Mordaland",      { 1,  3,  4, 55, 59, 60, -1, -1} }, // 1:3 ( 2)
    {573, 11 + 173,  2, LAND,      "Upland",         { 1,  2,  4,  5,  6, -1, -1, -1} }, // 1:4 ( 3) (inland)
    {451, 11 + 176,  5, LAND,      "Agdar",          { 2,  3,  5, 48, 49, 54, 55, -1} }, // 1:5 ( 4)
    {514, 11 + 201,  3, LAND,      "Romeirt",        { 3,  4,  6,  7, 47, 48, -1, -1} }, // 1:6 ( 5)
    {569, 11 + 233,  7, LAND,      "Jamtland",       { 3,  5,  7,  8, 65, -1, -1, -1} }, // 2:1 ( 6)
    {512, 11 + 262,  6, LAND,      "Vester Gotland", { 5,  6,  8,  9, 47, -1, -1, -1} }, // 2:2 ( 7)
    {549, 11 + 305,  7, LAND,      "Oster Gotland",  { 6,  7,  9, 63, 65, -1, -1, -1} }, // 2:3 ( 8)
    {502, 11 + 323,  4, LAND,      "Suder Gotland",  { 7,  8, 11, 47, 63, -1, -1, -1} }, // 2:4 ( 9)
    {420, 11 + 287,  6, LAND,      "Juteland",       {11, 14, 46, 47, 48, 49, -1, -1} }, // 2:5 (10)
    {441, 11 + 344,  3, ISLE,      "Scandia",        { 9, 10, 12, 13, 14, 47, 63, -1} }, // 2:6 (11)
    {522, 11 + 442,  4, LAND,      "Pomerania",      {11, 13, 63, 64, -1, -1, -1, -1} }, // 3:1 (12)
    {393, 11 + 421,  6, LAND,      "Saxony",         {11, 12, 14, 15, 16, 46, -1, -1} }, // 3:2 (13)
    {392, 11 + 372,  7, LAND,      "Anglia",         {10, 11, 13, 46, -1, -1, -1, -1} }, // 3:3 (14)
    {305, 11 + 383,  7, LAND,      "Fenland",        {13, 16, 17, 44, 45, 46, -1, -1} }, // 3:4 (15)
    {305, 11 + 434, 10, LAND,      "Rhineland",      {13, 15, 17, -1, -1, -1, -1, -1} }, // 3:5 (16) (inland)
    {242, 11 + 428,  9, LAND,      "Frisia",         {15, 16, 18, 44, -1, -1, -1, -1} }, // 3:6 (17)
    {175, 11 + 438,  3, LAND,      "Frankland",      {17, 19, 43, 44, -1, -1, -1, -1} }, // 4:1 (18)
    { 97, 11 + 439, 10, LAND,      "Armorica",       {18, 42, 43, -1, -1, -1, -1, -1} }, // 4:2 (19)
    { 75, 11 + 318,  2, LAND,      "Cornwall",       {21, 42, 43, -1, -1, -1, -1, -1} }, // 4:3 (20)
    {109, 11 + 333, 10, LAND,      "Wessex",         {20, 22, 23, 24, 25, 42, 43, -1} }, // 4:4 (21)
    {153, 11 + 354,  9, LAND,      "Sussex",         {21, 23, 24, 43, 44, -1, -1, -1} }, // 4:5 (22)
    {190, 11 + 329,  6, LAND,      "East Anglia",    {22, 24, 44, 45, -1, -1, -1, -1} }, // 4:6 (23)
    {148, 11 + 313,  3, LAND,      "Mercia",         {21, 22, 23, 25, 26, 27, 45, 51} }, // 5:1 (24)
    {108, 11 + 287,  3, LAND,      "Daffyd",         {21, 24, 26, 41, 42, -1, -1, -1} }, // 5:2 (25)
    {145, 11 + 268,  2, LAND,      "Gwynedd",        {24, 25, 27, 41, -1, -1, -1, -1} }, // 5:3 (26)
    {186, 11 + 217,  8, LAND,      "Northumberland", {24, 26, 28, 41, 51, 52, -1, -1} }, // 5:4 (27)
    {178, 11 + 157,  3, LAND,      "Dalriada",       {27, 29, 30, 40, 41, 52, -1, -1} }, // 5:5 (28)
    {222, 11 + 130,  5, LAND,      "Caledonia",      {28, 30, 52, 57, -1, -1, -1, -1} }, // 5:6 (29)
    {230, 11 +  85,  2, PENINSULA, "Pictland",       {28, 29, 31, 40, 57, 58, 61, 62} }, // 6:1 (30)
    {167, 11 +  66,  3, ISLE,      "Hebrides",       {30, 36, 39, 40, 62, -1, -1, -1} }, // 6:2 (31)
    { 62, 11 +  40,  3, LAND,      "Thule",          {36, 37, -1, -1, -1, -1, -1, -1} }, // 6:3 (32)
    { 54, 11 + 162,  5, LAND,      "Connacht",       {34, 35, 38, 39, -1, -1, -1, -1} }, // 6:4 (33)
    {109, 11 + 162,  4, LAND,      "Ulster",         {33, 35, 39, 40, 41, -1, -1, -1} }, // 6:5 (34)
    { 60, 11 + 203,  6, LAND,      "Leinster",       {33, 34, 41, -1, -1, -1, -1, -1} }, // 6:6 (35)
    {134, 11 +  32,  0, SEA,       "",               {31, 32, 37, 39, -1, -1, -1, -1} }, //     (36)
    { 52, 11 +  94,  0, SEA,       "",               {32, 36, 38, 39, -1, -1, -1, -1} }, //     (37)
    { 53, 11 + 130,  0, SEA,       "",               {33, 37, 39, -1, -1, -1, -1, -1} }, //     (38)
    { 82, 11 + 118,  0, SEA,       "",               {31, 33, 34, 36, 37, 38, 40, -1} }, //     (39)
    {137, 11 + 165,  0, SEA,       "",               {28, 30, 31, 34, 39, 41, -1, -1} }, //     (40)
    {116, 11 + 225,  0, SEA,       "",               {25, 26, 27, 28, 34, 35, 40, 42} }, //     (41)
    { 57, 11 + 292,  0, SEA,       "",               {19, 20, 21, 25, 41, 43, -1, -1} }, //     (42)
    {127, 11 + 389,  0, SEA,       "",               {18, 19, 20, 21, 22, 42, 44, -1} }, //     (43)
    {217, 11 + 370,  0, SEA,       "",               {15, 17, 18, 22, 23, 43, 45, -1} }, //     (44)
    {261, 11 + 328,  0, SEA,       "",               {15, 23, 24, 44, 46, 50, 51, -1} }, //     (45)
    {343, 11 + 334,  0, SEA,       "",               {10, 13, 14, 15, 45, 49, 50, -1} }, //     (46)
    {467, 11 + 282,  0, SEA,       "Kategatt",       { 5,  7,  9, 10, 11, 48, -1, -1} }, //     (47)
    {445, 11 + 229,  0, SEA,       "Skagerrak",      { 4,  5, 10, 47, 49, -1, -1, -1} }, //     (48)
    {376, 11 + 270,  0, SEA,       "",               { 4, 10, 48, 46, 50, 54, -1, -1} }, //     (49)
    {311, 11 + 268,  0, SEA,       "",               {45, 46, 49, 51, 53, 54, -1, -1} }, //     (50) (deep waters)
    {240, 11 + 258,  0, SEA,       "",               {24, 27, 45, 50, 52, 53, -1, -1} }, //     (51)
    {248, 11 + 193,  0, SEA,       "",               {27, 28, 29, 51, 53, 56, 57, -1} }, //     (52)
    {324, 11 + 196,  0, SEA,       "",               {50, 51, 52, 54, 55, 56, -1, -1} }, //     (53) (deep waters)
    {379, 11 + 186,  0, SEA,       "",               { 4, 49, 50, 53, 55, -1, -1, -1} }, //     (54)
    {386, 11 + 124,  0, SEA,       "",               { 2,  4, 53, 54, 56, 58, 59, -1} }, //     (55)
    {318, 11 + 134,  0, SEA,       "",               {52, 53, 55, 57, 58, -1, -1, -1} }, //     (56) (deep waters)
    {267, 11 + 133,  0, SEA,       "",               {29, 30, 52, 56, 58, -1, -1, -1} }, //     (57)
    {338, 11 +  90,  0, SEA,       "",               {30, 55, 56, 57, 59, 60, 61, -1} }, //     (58)
    {427, 11 +  73,  0, SEA,       "",               { 2, 55, 58, 60, -1, -1, -1, -1} }, //     (59)
    {456, 11 +  27,  0, SEA,       "",               { 1,  2, 58, 59, 61, -1, -1, -1} }, //     (60)
    {341, 11 +  47,  0, SEA,       "",               {30, 58, 60, 62, -1, -1, -1, -1} }, //     (61)
    {257, 11 +  44,  0, SEA,       "",               {30, 31, 61, -1, -1, -1, -1, -1} }, //     (62)
    {509, 11 + 385,  0, SEA,       "",               { 8,  9, 11, 12, 64, 65, -1, -1} }, //     (63)
    {587, 11 + 404,  0, SEA,       "",               {12, 63, 65, -1, -1, -1, -1, -1} }, //     (64)
    {587, 11 + 345,  0, SEA,       "",               { 6,  8, 63, 64, -1, -1, -1, -1} }  //     (65)
};

// 4. IMPORTED VARIABLES -------------------------------------------------

IMPORT FLAG                  watchamiga;
IMPORT TEXT                  onekey[ONEKEYS + 1],
                             saystring[256 + 1],
                             saystring2[256 + 1],
                             numberstring[13 + 1],
                             label[17 + 1][40 + 1],
                             line[2][MAXLINES + 1][80 + 1];
IMPORT STRPTR                monstertypes[8];
IMPORT SLONG                 countertype,
                             faxirides,
                             monsters,
                             treasures,
                             turn,
                             turns;
IMPORT struct Catalog*       CatalogPtr;

// 5. MODULE VARIABLES ---------------------------------------------------

MODULE SLONG                 order[HEROES + 1],
                             rider,
                             ridertype,
                             whichmove,
                             whichrealmove,
                             movearray[66];
MODULE FLAG                  freemove;

// 6. MODULE STRUCTURES --------------------------------------------------

// (none)

// 7. MODULE FUNCTIONS ---------------------------------------------------

MODULE void callforaid(SLONG passedtype, SLONG passed);
MODULE FLAG recruit(SLONG recruited, SLONG recruiterhero);
MODULE void flee(SLONG routertype, SLONG router, SLONG routerhero, SLONG routedtype, SLONG routed, SLONG routedhero);
MODULE void wound(SLONG woundertype, SLONG wounder, SLONG wounderhero, SLONG woundedtype, SLONG wounded, SLONG woundedhero);
MODULE void thekill(SLONG killertype, SLONG killer, SLONG killerhero, SLONG killedtype, SLONG killed, SLONG killedhero);
MODULE void dobattle(SLONG defendtype, SLONG defender, SLONG attackhero);
MODULE SLONG d6(void);
MODULE void attack(SLONG whichhero);
MODULE void gain(SLONG whichhero, SLONG glory, SLONG luck);
MODULE void move(SLONG whichhero);
MODULE SLONG getluck(SLONG whichhero);
MODULE void amiga_rout(SLONG routed, SLONG routedtype);
MODULE void human_rout(SLONG routedtype, SLONG routed, SLONG routerhero);
MODULE SLONG getmoves(SLONG countertype, SLONG whichcounter, FLAG freyfaxi);
MODULE void thor(SLONG whichhero);
MODULE void cast(SLONG caster, SLONG whichspell);
MODULE void getdefender(SLONG attackhero, SLONG here);
MODULE void needsord(SLONG countertype, SLONG counter, SLONG whichcountry, SLONG control);
MODULE void brosung(SLONG countertype, SLONG whichcounter, SLONG control);
MODULE void needtreasure(SLONG countertype, SLONG counter, SLONG whichcountry, SLONG control);
MODULE void amiga_attack(SLONG attackhero, SLONG defendtype, SLONG defender, SLONG whichcountry);
MODULE FLAG ask_treasure(SLONG countertype, SLONG whichcounter, SLONG whichtreasure);
MODULE FLAG attackersleft(void);
MODULE void dospell(SLONG spell, SLONG caster);
MODULE SLONG getattackers(SLONG whichhero, SLONG whichcountry, FLAG real);
MODULE SLONG odin_tyr(SLONG whichhero, FLAG attacking);
MODULE void gods(SLONG whichhero);
MODULE void pray(SLONG whichhero);
MODULE void conquer(SLONG conquerortype, SLONG conqueror, SLONG conquerorhero, SLONG whichcountry);
MODULE void findtreasure(SLONG victortype, SLONG victor, SLONG victorhero, SLONG whichmonster);
MODULE void drop(SLONG droppertype, SLONG dropper, SLONG whichcountry);
MODULE FLAG islegal(SLONG movertype, SLONG mover, SLONG whichcountry, FLAG human);
MODULE FLAG checkfree(SLONG whichhero, FLAG* freemove);
MODULE FLAG needitem(SLONG countertype, SLONG counter, SLONG whichcountry);
MODULE FLAG autosense(SLONG player);
MODULE FLAG findattackers(SLONG player, SLONG whichcountry, SLONG victimtype, SLONG victim);
MODULE void deselect_combatants(SLONG attackhero, SLONG defendtype, SLONG defendhero, SLONG defender);
MODULE SLONG assess_hero(SLONG whichhero, SLONG whichcountry);
MODULE SLONG assess_jarl(SLONG whichjarl, SLONG whichcountry);
MODULE SLONG countjarls(SLONG whichhero);
MODULE void onemove_hero(SLONG whichhero, SLONG whichcountry);
MODULE void onemove_jarl(SLONG whichjarl, SLONG whichcountry);
MODULE SLONG checkdefenders_hero(SLONG whichhero, SLONG whichcountry);
MODULE SLONG checkdefenders_jarl(SLONG whichhero, SLONG whichcountry);
MODULE void givegold(SLONG whichhero, SLONG whichjarl);
MODULE void get_passengers(void);
MODULE FLAG wear_ring(SLONG possessortype, SLONG possessor, SLONG possessorhero);

// 8. CODE ---------------------------------------------------------------

EXPORT void place_monsters(void)
{   /* .taken = FALSE: the monster is in the "pile of monsters" (spare).
                TRUE : the monster is either on the board or dead. */

    SLONG whichhero, whichmonster, whichtreasure;
    FLAG  available, ok;

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if (hero[whichhero].alive)
        {   available = FALSE;
            for (whichmonster = 0; whichmonster <= monsters; whichmonster++)
            {   if (!monster[whichmonster].taken)
                {   available = TRUE;
                    break;
            }   }
            if (available)
            {   do
                {   whichmonster = goodrand() % (monsters + 1);
                } while (monster[whichmonster].taken);
                monster[whichmonster].taken    =
                monster[whichmonster].alive    = TRUE;

                if
                (   monster[whichmonster].species == SERPENT
                 || monster[whichmonster].species == KRAKEN
                )
                {   monster[whichmonster].where    = (goodrand() % 30) + 36;
                } else
                {   monster[whichmonster].where    = goodrand() % 36;
                }

                monster[whichmonster].sea      = NORMAL;
                monster[whichmonster].hagall   = FALSE;

                if
                (   monster[whichmonster].species == DRAGON
                 || monster[whichmonster].species == HYDRA
                )
                {   ok = FALSE;
                    for (whichtreasure = 0; whichtreasure <= treasures; whichtreasure++)
                    {   if (!treasure[whichtreasure].taken)
                        {   ok = TRUE; // at least one treasure is available
                            break; // for speed
                    }   }
                    if (ok)
                    {   do
                        {   whichtreasure = goodrand() % (treasures + 1);
                        } while (treasure[whichtreasure].taken);
                        treasure[whichtreasure].taken         = TRUE;
                        treasure[whichtreasure].possessortype = MONSTER;
                        treasure[whichtreasure].possessor     = whichmonster;
                        treasure[whichtreasure].where         = -1;

                        monster[whichmonster].wealth = 0;
                    } else
                    {   monster[whichmonster].wealth = 20;
                }   }
                else
                {   monster[whichmonster].wealth = 0;
                }
                // we don't unslot newborn counters
                move_monster(whichmonster, FALSE);
}   }   }   }

EXPORT void place_jarls(void)
{   FLAG  available;
    SLONG whichhero, whichjarl;

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if (hero[whichhero].alive)
        {   available = FALSE;
            for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
            {   if (!jarl[whichjarl].taken)
                {   available = TRUE;
                    break;
            }   }
            if (available)
            {   do
                {   whichjarl = goodrand() % (JARLS + 1);
                } while (jarl[whichjarl].taken);
                jarl[whichjarl].taken     =
                jarl[whichjarl].alive     = TRUE;
                jarl[whichjarl].wealth    = 0;
                jarl[whichjarl].where     =
                jarl[whichjarl].homewhere = goodrand() % 36;
                jarl[whichjarl].hero      = -1;
                jarl[whichjarl].sea       = NORMAL;
                jarl[whichjarl].hagall    =
                jarl[whichjarl].loseturn  = FALSE;
                hidejarl(whichjarl, FALSE);
                // we don't unslot newborn counters
                move_jarl(whichjarl, FALSE);
}   }   }   }

MODULE void callforaid(SLONG passedtype, SLONG passed)
{   SLONG passedhero, passedwhere, whichjarl;

    if (passedtype == HERO)
    {   passedhero = passed;
        passedwhere = hero[passed].where;
    } else
    {   // assert(passedtype == JARL);
        // assert(jarl[passed].hero != -1);
        passedhero = jarl[passed].hero;
        passedwhere = jarl[passed].where;
    }

    if (passedtype == JARL && hero[passedhero].where == passedwhere)
    {   hero[passedhero].defending = TRUE;
        select_hero(passedhero, FALSE);
    }

    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if
        (   jarl[whichjarl].hero == passedhero
         && jarl[whichjarl].where == passedwhere
         && !jarl[whichjarl].defending
        )
        {   jarl[whichjarl].defending = TRUE;
            select_jarl(whichjarl, FALSE);
    }   }

    updatescreen();
}

MODULE void dobattle(SLONG defendtype, SLONG defender, SLONG attackhero)
{   SLONG decision,
          result,
          attackluck     = 0,
          attackstrength = 0,
          attacktype,
          attacker       = -1, // to avoid spurious compiler warnings
          defendluck     = 0,
          defendstrength = 0,
          defendhero     = -1, // to avoid spurious compiler warnings
          whichhero,
          whichjarl,
          whichsord;

    /* defendtype: type of defender, one of HERO, JARL, MONSTER or KINGDOM.
       defender: ordinal number of defender. */

    switch (defendtype)
    {
    case HERO:
        defendhero = defender;
        hero[defender].defending = TRUE;
        select_hero(defender, FALSE);

        if (wear_ring(HERO, defender, defendhero))
        {   goto ESCAPED;
        }

        callforaid(HERO, defender);
    acase JARL:
        defendhero = jarl[defender].hero;
        jarl[defender].defending = TRUE;
        select_jarl(defender, TRUE);

        if (wear_ring(JARL, defender, defendhero))
        {   goto ESCAPED;
        }

        if (defendhero != -1)
        {   callforaid(JARL, defender);
        }
    acase MONSTER:
        select_monster(defender, TRUE);
        defendstrength = monster[defender].strength;
        defendhero = -1;
    acase KINGDOM:
        defendstrength = world[defender].tax;
        defendhero = -1; // even if it already has a king it makes no difference to the combat
    }

    // "II. ROLL FOR DROW, WITCH, OR GHOST MAGIC SPELLS (IF APPLICABLE)."

    if (defendtype == MONSTER)
    {   switch (monster[defender].species)
        {
        case GHOST:
            decision = d6();
            if (decision <= 3)
            {   cast(defender, decision);
            }
        acase DROW:
            cast(defender, d6());
        acase WITCH:
            cast(defender, d6());
            if (attackersleft())
            {   cast(defender, d6());
    }   }   }

    if (!attackersleft())
    {   // no attackers, abort combat
        deselect_combatants(attackhero, defendtype, defendhero, defender);
        return;
    }

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if (hero[whichhero].attacking)
        {   attackstrength += hero[whichhero].strength;
        } elif (hero[whichhero].defending)
        {   defendstrength += hero[whichhero].strength;
    }   }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].attacking)
        {   attackstrength += jarl[whichjarl].strength;
        } elif (jarl[whichjarl].defending)
        {   defendstrength += jarl[whichjarl].strength;
    }   }

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if (hero[whichhero].attacking && hero[whichhero].hagall)
        {   attackstrength--;
        } elif (hero[whichhero].defending && hero[whichhero].hagall)
        {   defendstrength--;
    }   }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].attacking && jarl[whichjarl].hagall)
        {   attackstrength--;
        } elif (jarl[whichjarl].defending && jarl[whichjarl].hagall)
        {   defendstrength--;
    }   }
    if (defendtype == MONSTER && monster[defender].hagall)
    {   defendstrength--;
    }

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if (hero[whichhero].alive && hero[whichhero].rune == OGAL)
        {   if (hero[whichhero].attacking)
            {   attackstrength++;
            } elif (hero[whichhero].defending)
            {   defendstrength++;
    }   }   }

    for (whichsord = 0; whichsord <= SORDS; whichsord++)
    {   if
        (   (   sord[whichsord].possessortype == HERO
             && hero[sord[whichsord].possessor].attacking
            )
         || (   sord[whichsord].possessortype == JARL
             && jarl[sord[whichsord].possessor].attacking
        )   )
        {   if (whichsord == BALMUNG || whichsord == HRUNTING)
            {   attackstrength++;
            } elif (whichsord == DRAGVENDILL || whichsord == GRAM || whichsord == TYRFING)
            {   attackstrength += 2;
            } elif (whichsord == LOVI)
            {   attackstrength++;
                for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                {   if (jarl[whichjarl].defending)
                    {   attackstrength += 2;
                        break;
        }   }   }   }
        elif
        (   (   sord[whichsord].possessortype == HERO
             && hero[sord[whichsord].possessor].defending
            )
         || (   sord[whichsord].possessortype == JARL
             && jarl[sord[whichsord].possessor].defending
        )   )
        {   if (whichsord == BALMUNG || whichsord == HRUNTING)
            {   defendstrength++;
            } elif (whichsord == DRAGVENDILL || whichsord == GRAM || whichsord == TYRFING)
            {   defendstrength += 2;
            } elif (whichsord == LOVI)
            {   defendstrength++;
                for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                {   if (jarl[whichjarl].attacking)
                    {   defendstrength += 2;
                        break;
    }   }   }   }   }

    /* "III. MODIFY THE DIE ROLL WITH LUCK. Before the die is rolled,
    heroes who are involved in the battle (or who have jarls involved in
    the battle) may modify the die roll up or down one with each point of
    luck expended before the die is rolled. If there are two or more
    heroes involved in the battle they should each write how much luck
    they are using to modify the die roll and how before revealing the
    amounts simultaneously." */

    if (hero[attackhero].control == HUMAN)
    {   if (hero[attackhero].luck >= 1)
        {   strcpy(saystring, LLL(MSG_ATTACKING, "Attacking"));
            DISCARD saywho(HERO, attackhero, FALSE, TRUE);
            strcat(saystring, ", ");
            strcat(saystring, LLL(MSG_USE_LUCK, "use luck"));
            strcat(saystring, " (0-");
            if (hero[attackhero].luck >= 9)
            {   strcat(saystring, "9");
            } else
            {   stcl_d(numberstring, hero[attackhero].luck);
                strcat(saystring, numberstring);
            }
            strcat(saystring, ")?");
            say(LOWER, FIRSTHEROCOLOUR + attackhero);
            attackluck = getluck(attackhero);
    }   }
    else
    {   // assert(hero[attackhero].control == CONTROL_AMIGA);
        if (attackstrength < defendstrength && hero[attackhero].luck > 1)
        {   attackluck = defendstrength - attackstrength;
            if (attackluck > hero[attackhero].luck - 1)
            {   attackluck = hero[attackhero].luck - 1;
            }
            hero[attackhero].luck -= attackluck;

            strcpy(saystring, LLL(MSG_ATTACKING, "Attacking"));
            DISCARD saywho(HERO, attackhero, FALSE, FALSE);
            strcat(saystring, LLL(MSG_USED, "used"));
            strcat(saystring, " ");
            stcl_d(numberstring, attackluck);
            strcat(saystring, numberstring);
            strcat(saystring, " ");
            strcat(saystring, LLL(MSG_LUCK2, "luck"));
            strcat(saystring, ".");
            say(LOWER, FIRSTHEROCOLOUR + attackhero);
            anykey();
    }   }

    if (defendhero != -1)
    {   if (hero[defendhero].control == HUMAN)
        {   if (hero[defendhero].luck >= 1)
            {   strcpy(saystring, LLL(MSG_DEFENDING, "Defending"));
                DISCARD saywho(defendtype, defender, FALSE, TRUE);
                strcat(saystring, ", ");
                strcat(saystring, LLL(MSG_USE_LUCK, "use luck"));
                strcat(saystring, " (0-");
                if (hero[defendhero].luck >= 9)
                {   strcat(saystring, "9");
                } else
                {   stcl_d(numberstring, hero[defendhero].luck);
                    strcat(saystring, numberstring);
                }
                strcat(saystring, ")?");
                say(LOWER, FIRSTHEROCOLOUR + defendhero);
                defendluck = getluck(defendhero);
        }   }
        else
        {   // assert(hero[defendhero].control == CONTROL_AMIGA);
            if (defendstrength < attackstrength && hero[defendhero].luck > 1)
            {   defendluck = attackstrength - defendstrength;
                if (defendluck > hero[defendhero].luck - 1)
                {   defendluck = hero[defendhero].luck - 1;
                }
                hero[defendhero].luck -= defendluck;
                strcpy(saystring, LLL(MSG_DEFENDING, "Defending"));
                DISCARD saywho(HERO, defendhero, FALSE, FALSE);
                strcat(saystring, LLL(MSG_USED, "used"));
                strcat(saystring, " ");
                stcl_d(numberstring, defendluck);
                strcat(saystring, numberstring);
                strcat(saystring, " ");
                strcat(saystring, LLL(MSG_LUCK2, "luck"));
                strcat(saystring, ".");
                say(LOWER, FIRSTHEROCOLOUR + defendhero);
                anykey();
    }   }   }

    attackstrength += attackluck;
    defendstrength += defendluck;

    if (hero[attackhero].attacking)
    {   attackstrength += odin_tyr(attackhero, TRUE);
        if (attackstrength < 0)
        {   attackstrength = 0;
    }   }
    if (defendhero != -1 && hero[defendhero].defending)
    {   defendstrength += odin_tyr(defendhero, FALSE);
        if (defendstrength < 0)
        {   defendstrength = 0;
    }   }

    if
    (   (   sord[BALMUNG].possessortype == HERO
         && hero[sord[BALMUNG].possessor].attacking
        )
     || (   sord[BALMUNG].possessortype == JARL
         && jarl[sord[BALMUNG].possessor].attacking
    )   )
    {   ; // one of the attackers is wielding Balmung
        // assert(sord[BALMUNG].where == -1);
    } else
    {   if
        (   (   treasure[MAGICSHIRT].possessortype == HERO
             && hero[treasure[MAGICSHIRT].possessor].defending
            )
         || (   treasure[MAGICSHIRT].possessortype == JARL
             && jarl[treasure[MAGICSHIRT].possessor].defending
        )   )
        {   // one of the defenders is wearing the Magic Shirt
            // assert(treasure[MAGICSHIRT].where == -1);

            defendstrength++;
        }

        if
        (   (   treasure[MAILCOAT].possessortype == HERO
             && hero[treasure[MAILCOAT].possessor].defending
            )
         || (   treasure[MAILCOAT].possessortype == JARL
             && jarl[treasure[MAILCOAT].possessor].defending
        )   )
        {   // one of the defenders is wearing the Mail Coat
            // assert(treasure[MAILCOAT].where == -1);

            defendstrength += 2;
    }   }

    /* "V. ROLL ONE DIE AND CHECK THE COMBAT RESULTS TABLE TO DETERMINE
    THE OUTCOME OF THE BATTLE AFTER ADDING ALL MODIFIERS TO THE DIE ROLL.
    After all modifications to the combat strengths of both sides have
    been made, subtract the defender's strength from the attacker's and
    consult the COMBAT RESULTS TABLE...to determine the results
    according to a die roll and modifications due to luck." */

#ifdef EXTRAVERBOSE
Printf("Involved in this combat are:\n");
Printf(" Attackers:\n");
for (whichhero = 0; whichhero <= HEROES; whichhero++)
{   if (hero[whichhero].attacking)
    {   Printf("  Hero %s!\n", hero[attackhero].name);
}   }
for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
{   if (jarl[whichjarl].attacking)
    {   Printf("  Jarl %s!\n", jarl[whichjarl].name);
}   }
Printf(" Defenders:\n");
if (defendhero != -1)
{   if (hero[defendhero].defending)
    {   Printf("  Hero %s!\n", hero[defendhero].name);
}   }
for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
{   if (jarl[whichjarl].defending)
    {   Printf("  Jarl %s!\n", jarl[whichjarl].name);
}   }
if (defendhero == -1)
{   if (defendtype == KINGDOM)
    {   Printf("  Kingdom %s!\n", world[defender].name);
    } elif (defendtype == MONSTER)
    {   Printf("  %s %s!\n", monstertypes[monster[defender].species], monster[defender].name);
}   }
#endif

    result = d6();
    sprintf
    (   saystring, "%s: %ld. %s: %ld. %s: %ld. ",
        LLL(MSG_ATTACKERS, "Attackers"),
        attackstrength,
        LLL(MSG_DEFENDERS, "Defenders"),
        defendstrength,
        LLL(MSG_ROLL     , "Roll"     ),
        result
    );
    result += attackstrength - defendstrength;
    if (result <= 2)
    {   strcat(saystring, LLL(MSG_ATTACKERS_KILLED,  "Attackers killed" ));
        strcat(saystring, ".");
    } elif (result == 3)
    {   strcat(saystring, LLL(MSG_ATTACKERS_WOUNDED, "Attackers wounded"));
        strcat(saystring, ".");
    } elif (result == 4)
    {   strcat(saystring, LLL(MSG_ATTACKERS_FLEE,    "Attackers flee"   ));
        strcat(saystring, ".");
    } elif (result == 5)
    {   strcat(saystring, LLL(MSG_NO_RESULT,         "No result"        ));
        strcat(saystring, ".");
    } elif (result == 6)
    {   strcat(saystring, LLL(MSG_DEFENDERS_FLEE,    "Defenders flee"   ));
        strcat(saystring, ".");
    } elif (result == 7)
    {   strcat(saystring, LLL(MSG_DEFENDERS_WOUNDED, "Defenders wounded"));
        strcat(saystring, ".");
    } else
    {   // assert(result >= 8);
        strcat(saystring, LLL(MSG_DEFENDERS_KILLED,  "Defenders killed" ));
        strcat(saystring, ".");
    }

    say(LOWER, FIRSTHEROCOLOUR + attackhero);
    anykey();

    if (result == 4) // attacker flees
    {   if (sord[HRUNTING].possessortype == HERO)
        {   if (hero[sord[HRUNTING].possessor].attacking)
            {   result = 6; // defender flees
        }   }
        elif (sord[HRUNTING].possessortype == JARL)
        {   if (jarl[sord[HRUNTING].possessor].attacking)
            {   result = 6; // defender flees
    }   }   }
    elif (result == 6) // defender flees
    {   if (sord[HRUNTING].possessortype == HERO)
        {   if (hero[sord[HRUNTING].possessor].defending)
            {   result = 4; // attacker flees
        }   }
        elif (sord[HRUNTING].possessortype == JARL)
        {   if (jarl[sord[HRUNTING].possessor].defending)
            {   result = 4; // attacker flees
    }   }   }

    /* "VI. APPLY THE COMBAT RESULT." */

    if (hero[attackhero].attacking)
    {   attacktype = HERO;
        attacker   = attackhero;
    } else
    {   attacktype = JARL; // uses the first jarl found
        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if (jarl[whichjarl].attacking)
            {   attacker = whichjarl;
                break;
    }   }   }

    if (result <= 2) // attackers killed
    {   if (hero[attackhero].attacking)
        {   thekill(defendtype, defender, defendhero, HERO, attackhero, attackhero);
        }
        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if (jarl[whichjarl].attacking)
            {   thekill(defendtype, defender, defendhero, JARL, whichjarl, attackhero);
    }   }   }
    elif (result == 3) // attackers wounded
    {   if (hero[attackhero].attacking)
        {   wound(defendtype, defender, defendhero, HERO, attackhero, attackhero);
        }
        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if (jarl[whichjarl].attacking)
            {   wound(defendtype, defender, defendhero, JARL, whichjarl, attackhero);
    }   }   }
    elif (result == 4) // attackers flee
    {   if (hero[attackhero].attacking)
        {   flee(defendtype, defender, defendhero, HERO, attackhero, attackhero);
        }
        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if (jarl[whichjarl].attacking)
            {   flee(defendtype, defender, defendhero, JARL, whichjarl, attackhero);
    }   }   }
    elif (result == 5) // no result
    {   strcpy(saystring, LLL(MSG_NO_RESULT, "No result"));
        strcat(saystring, ".");
        say(LOWER, WHITE);
        anykey();
    } elif (result == 6) // defenders flee
    {   if (defendtype == MONSTER || defendtype == KINGDOM)
        {   flee(attacktype, attacker, attackhero, defendtype, defender, -1);
        } else
        {   // assert(defendtype == HERO || defendtype == JARL);
            if (defendhero != -1 && hero[defendhero].defending)
            {   flee(attacktype, attacker, attackhero, HERO, defendhero, defendhero);
            }
            for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
            {   if (jarl[whichjarl].defending)
                {   flee(attacktype, attacker, attackhero, JARL, whichjarl, defendhero);
    }   }   }   }
    elif (result == 7) // defenders wounded
    {   if (defendtype == MONSTER || defendtype == KINGDOM)
        {   wound(attacktype, attacker, attackhero, defendtype, defender, -1);
        } else
        {   // assert(defendtype == HERO || defendtype == JARL);
            if (defendhero != -1 && hero[defendhero].defending)
            {   wound(attacktype, attacker, attackhero, HERO, defendhero, defendhero);
            }
            for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
            {   if (jarl[whichjarl].defending)
                {   wound(attacktype, attacker, attackhero, JARL, whichjarl, defendhero);
    }   }   }   }
    else // defenders killed
    {   // assert(result >= 8);
        if (defendtype == MONSTER || defendtype == KINGDOM)
        {   thekill(attacktype, attacker, attackhero, defendtype, defender, -1);
        } else
        {   // assert(defendtype == HERO || defendtype == JARL);
            if (defendhero != -1 && hero[defendhero].defending)
            {   thekill(attacktype, attacker, attackhero, HERO, defendhero, defendhero);
            }
            for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
            {   if (jarl[whichjarl].defending)
                {   thekill(attacktype, attacker, attackhero, JARL, whichjarl, defendhero);
    }   }   }   }

    if (hero[attackhero].attacking)
    {   thor(attackhero);
    }
    if (defendhero != -1 && hero[defendhero].defending && hero[defendhero].alive)
    {   thor(defendhero);
    }

    if (hero[attackhero].attacking)
    {   pray(attackhero);
    }
    if (defendhero != -1 && hero[defendhero].defending && hero[defendhero].alive)
    {   pray(defendhero);
    }

ESCAPED:
    deselect_combatants(attackhero, defendtype, defendhero, defender);
}

MODULE void flee(SLONG routertype, SLONG router, SLONG routerhero, SLONG routedtype, SLONG routed, SLONG routedhero)
{   if (routedtype == HERO)
    {   hero[routed].glory -= 2;
        if (hero[routed].glory < 0)
        {   hero[routed].glory = 0;
    }   }

    if
    (   routertype == HERO
     && routedtype == JARL
    )
    {   if (recruit(routed, routerhero))
        {   return;
    }   }
    elif (routedtype == KINGDOM)
    {   conquer(routertype, router, routerhero, routed);
        return;
    }

    DISCARD saywho(routedtype, routed, FALSE, FALSE);
    strcat(saystring, LLL(MSG_IS_ROUTED, "is routed"));
    strcat(saystring, "!");
    if (routedhero == -1)
    {   say(LOWER, WHITE);
    } else
    {   say(LOWER, FIRSTHEROCOLOUR + routedhero);
    }
    anykey();

    if
    (   (routertype == HERO && hero[router].control == CONTROL_AMIGA)
     || (routertype == JARL && (jarl[router].hero == -1 || hero[jarl[router].hero].control == CONTROL_AMIGA))
     ||  routertype == MONSTER
     ||  routertype == KINGDOM
    )
    {   amiga_rout(routedtype, routed);
    } else
    {   human_rout(routedtype, routed, routerhero);
}   }

MODULE void wound(SLONG woundertype, SLONG wounder, SLONG wounderhero, SLONG woundedtype, SLONG wounded, SLONG woundedhero)
{   SLONG glory = 0,
          luck  = 0;

    /* WOUNDED. Heroes on the wounded side are wounded.
    Jarls on the wounded side are removed from the board and placed,
    upside down, in their respective piles, from which they will reenter
    play normally. There is no further effect from being wounded, except
    that jarls that reenter play after being wounded are to be considered
    unrecruited jarls. */

    if
    (   woundertype == HERO
     && woundedtype == JARL
    )
    {   if (recruit(wounded, wounderhero))
        {   return;
    }   }
    elif (woundedtype == HERO && hero[wounded].wounded)
    {   thekill(woundertype, wounder, wounderhero, woundedtype, wounded, woundedhero);
        return;
    } elif (woundedtype == KINGDOM)
    {   conquer(woundertype, wounder, wounderhero, wounded);
        return;
    }

    DISCARD saywho(woundedtype, wounded, FALSE, FALSE);
    strcat(saystring, LLL(MSG_IS_WOUNDED, "is wounded"));
    strcat(saystring, "!");
    if (woundedhero == -1)
    {   say(LOWER, WHITE);
    } else
    {   say(LOWER, FIRSTHEROCOLOUR + woundedhero);
    }
    anykey();

    if (woundedtype == HERO)
    {   if (hero[wounded].maidens)
        {   hero[wounded].maidens--;
            hero[wounded].wounded = FALSE;

            sprintf
            (   saystring,
                "Frey %s %s%s.",
                LLL(MSG_SENDS_A_MAIDEN_TO_HEAL_HERO, "sends a maiden to heal hero"),
                hero[wounded].name,
                LLL(MSG_S_WOUND, "'s wound")
            );
            say(LOWER, FIRSTHEROCOLOUR + wounded);
            anykey();
        } else hero[wounded].wounded = TRUE;

        if (wounderhero != -1)
        {   gain(wounderhero, hero[woundedhero].strength / 2 / 2, hero[woundedhero].strength / 2 / 2);
    }   }
    elif (woundedtype == JARL)
    {   jarl[wounded].alive  = FALSE;
        jarl[wounded].taken  = FALSE;
        jarl[wounded].hero   = -1;
        jarl[wounded].wealth = 0; // this is actually an ambiguity in the rules
        remove_jarl(wounded, TRUE);

        drop(JARL, wounded, jarl[wounded].where); // should really be done before anykey()

        if (wounderhero != -1)
        {   gain(wounderhero, jarl[wounded].strength / 2 / 2, jarl[wounded].strength / 2 / 2); // not the same as / 4 due to rounding
    }   }
    elif (woundedtype == MONSTER)
    {   monster[wounded].alive = FALSE;
        monster[wounded].taken = FALSE;
        remove_monster(wounded, TRUE);

        switch (monster[wounded].species)
        {
        case DRAGON:
            glory = 6;
            luck  = 5;
        acase DROW:
            glory = 3;
            luck  = 2;
        acase GHOST:
            glory = 2;
            luck  = 2;
        acase GIANT:
            glory = 4;
            luck  = 3;
        acase TROLL:
            glory = 3;
            luck  = 3;
        acase WITCH:
            glory = 5;
            luck  = 4;
        acase HYDRA:
        case SERPENT:
            glory = 7;
            luck  = 5;
        acase KRAKEN:
            glory = 8;
            luck  = 5;
        }
        glory /= 2;
        luck  /= 2;

        // assert(wounderhero != -1);
        gain(wounderhero, glory, luck);
}   }

// kill() is reserved under OS4! (sys/signal.h)
MODULE void thekill(SLONG killertype, SLONG killer, SLONG killerhero, SLONG killedtype, SLONG killed, SLONG killedhero)
{   SLONG result, whichjarl;

    if (killedtype == HERO)
    {   hero[killed].alive     =
        hero[killed].attacking =
        hero[killed].defending = FALSE;
        remove_hero(killed, TRUE);

        drop(HERO, killed, hero[killed].where);

        DISCARD saywho(HERO, killed, FALSE, FALSE);
        strcat(saystring, LLL(MSG_IS_KILLED, "is killed"));
        strcat(saystring, "!");
        if (killedhero == -1)
        {   say(LOWER, WHITE);
        } else
        {   say(LOWER, FIRSTHEROCOLOUR + killedhero);
        }
        anykey();

        if (killerhero != -1)
        {   gain(killerhero, hero[killedhero].strength / 2, hero[killedhero].strength / 2);
    }   }
    elif (killedtype == JARL)
    {   if
        (   killerhero == -1
         || hero[killerhero].where != jarl[killed].where
         || !recruit(killed, killerhero)
        )
        {   jarl[killed].alive     =
            jarl[killed].attacking =
            jarl[killed].defending = FALSE;
            remove_jarl(killed, TRUE);

            drop(JARL, killed, jarl[killed].where);

            DISCARD saywho(JARL, killed, FALSE, FALSE);
            strcat(saystring, LLL(MSG_IS_KILLED, "is killed"));
            strcat(saystring, "!");
            say(LOWER, FIRSTHEROCOLOUR + killedhero);
            anykey();

            if (killerhero != -1 && killedtype == JARL)
            {   if (hero[killerhero].where == jarl[killed].where)
                {   if (jarl[killed].wealth)
                    {   hero[killerhero].wealth += jarl[killed].wealth;
                        DISCARD saywho(HERO, killerhero, FALSE, FALSE);
                        strcat(saystring, LLL(MSG_TAKES, "takes"));
                        strcat(saystring, " ");
                        stcl_d(numberstring, jarl[killed].wealth);
                        strcat(saystring, numberstring);
                        strcat(saystring, " ");
                        strcat(saystring, LLL(MSG_GOLDEN_MARKS, "golden marks"));
                        strcat(saystring, " ");
                        strcat(saystring, LLL(MSG_FROM, "from"));
                        strcat(saystring, " ");
                        DISCARD saywho(JARL, killed, FALSE, TRUE);
                        strcat(saystring, ".");
                        say(LOWER, FIRSTHEROCOLOUR + killerhero);
                        anykey();
                }   }
                else
                {   for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                    {   if
                        (   jarl[whichjarl].alive
                         && jarl[whichjarl].hero == killerhero
                         && jarl[whichjarl].where == jarl[killed].where
                        )
                        {   // assert(whichjarl != killed);

                            if (jarl[killed].wealth)
                            {   jarl[whichjarl].wealth += jarl[killed].wealth;
                                DISCARD saywho(JARL, whichjarl, FALSE, FALSE);
                                strcat(saystring, LLL(MSG_TAKES, "takes"));
                                strcat(saystring, " ");
                                stcl_d(numberstring, jarl[killed].wealth);
                                strcat(saystring, " ");
                                strcat(saystring, LLL(MSG_GOLDEN_MARKS, "golden marks"));
                                strcat(saystring, " ");
                                strcat(saystring, LLL(MSG_FROM, "from"));
                                strcat(saystring, " ");
                                DISCARD saywho(JARL, killed, FALSE, TRUE);
                                strcat(saystring, ".");
                                say(LOWER, FIRSTHEROCOLOUR + killerhero);
                                anykey();
            }   }   }   }   }

            if (killedhero != -1)
            {   if (hero[killedhero].control == HUMAN)
                {   if (hero[killedhero].glory > 0 || hero[killedhero].luck > 0)
                    {   DISCARD saywho(HERO, killedhero, TRUE, FALSE);
                        sprintf
                        (   saystring2,
                            "%s %ld (%s)%s %s %ld (%s)%s?",
                            LLL(MSG_LOSE, "lose"),
                            jarl[killed].strength / 2,
                            LLL(MSG_CHAR_GLORY, "G"),
                            LLL(MSG_UNCHAR_GLORY, "lory"),
                            LLL(MSG_OR, "or"),
                            jarl[killed].strength / 2,
                            LLL(MSG_CHAR_LUCK, "L"),
                            LLL(MSG_UNCHAR_LUCK, "uck")
                        );
                        strcat(saystring, saystring2);
                        say(LOWER, FIRSTHEROCOLOUR + killedhero);
                        do
                        {   result = getevent(GLKEYBOARD, FIRSTHEROCOLOUR + killedhero);
                        } while (result != onekey[ONEKEY_GLORY] && result != onekey[ONEKEY_LUCK]);
                        if (result == onekey[ONEKEY_GLORY])
                        {   hero[killedhero].glory -= jarl[killed].strength / 2;
                            if (hero[killedhero].glory < 0)
                            {   hero[killedhero].glory = 0;
                        }   }
                        else
                        {   // assert(result == onekey[ONEKEY_LUCK]);
                            hero[killedhero].luck  -= jarl[killed].strength / 2;
                            if (hero[killedhero].luck < 0)
                            {   hero[killedhero].luck = 0;
                }   }   }   }
                else
                {   // assert(hero[killedhero].control == CONTROL_AMIGA);
                    hero[killedhero].glory -= jarl[killed].strength / 2;
                    if (hero[killedhero].glory < 0)
                    {   hero[killedhero].glory = 0;
            }   }   }
            if (killerhero != -1)
            {   gain(killerhero, jarl[killed].strength / 2, jarl[killed].strength / 2);
    }   }   }
    elif (killedtype == KINGDOM)
    {   conquer(killertype, killer, killerhero, killed);
        return;
    } elif (killedtype == MONSTER)
    {   monster[killed].alive = FALSE;
        remove_monster(killed, TRUE);

        strcpy(saystring, monstertypes[monster[killed].species]);
        strcat(saystring, " ");
        strcat(saystring, monster[killed].name);
        strcat(saystring, " ");
        strcat(saystring, LLL(MSG_IS_KILLED, "is killed"));
        strcat(saystring, "!");
        say(LOWER, FIRSTHEROCOLOUR + killerhero);
        anykey();

        findtreasure(killertype, killer, killerhero, killed);

        // assert(killerhero != -1);
        gain(killerhero, monster[killed].glory, monster[killed].luck);

        // check if hero was present at the combat
        if
        (   killerhero != -1
         && hero[killerhero].attacking
        )
        {   if
            (   (   monster[killed].species == DROW
                 || monster[killed].species == GHOST
                 || monster[killed].species == WITCH
                )
             && hero[killer].rune == -1
            )
            {   hero[killer].rune = goodrand() % (RUNES + 1);
                DISCARD saywho(HERO, killer, FALSE, FALSE);
                strcat(saystring, LLL(MSG_LEARNS_THE_RUNE, "learns the rune"));
                strcat(saystring, " ");
                strcat(saystring, rune[hero[killer].rune].name);
                strcat(saystring, ", ");
                strcat(saystring, rune[hero[killer].rune].desc);
                strcat(saystring, ".");
                say(LOWER, FIRSTHEROCOLOUR + killerhero);
                anykey();
}   }   }   }

MODULE FLAG recruit(SLONG recruited, SLONG recruiterhero)
{   SLONG result;

    if
    (   jarl[recruited].hero == -1
     && hero[recruiterhero].luck >= 1
     && jarl[recruited].recruitable
    )
    {   jarl[recruited].recruitable = FALSE;
        if (countjarls(recruiterhero) < 4)
        {   if (hero[recruiterhero].control == HUMAN)
            {   DISCARD saywho(HERO, recruiterhero, TRUE, FALSE);
                strcat(saystring, LLL(MSG_RECRUIT_JARL, "recruit jarl"));
                strcat(saystring, " ");
                strcat(saystring, jarl[recruited].name);
                strcat(saystring, " (");
                strcat(saystring, LLL(MSG_CHAR_YES, "Y"));
                strcat(saystring, "/");
                strcat(saystring, LLL(MSG_CHAR_NO, "N"));
                strcat(saystring, ")?");
                say(LOWER, FIRSTHEROCOLOUR + recruiterhero);
                do
                {   result = getevent(YNKEYBOARD, FIRSTHEROCOLOUR + recruiterhero);
                } while (result != onekey[ONEKEY_YES] && result != onekey[ONEKEY_NO]);
                if (result == onekey[ONEKEY_YES])
                {   hero[recruiterhero].luck--;
                    gain(recruiterhero, jarl[recruited].strength / 2, jarl[recruited].strength / 2);
                    jarl[recruited].hero = recruiterhero;
                    return TRUE;
                } else
                {   // assert(result == onekey[ONEKEY_NO]);
            }   }
            else
            {   // assert(hero[recruiterhero].control == CONTROL_AMIGA);
                hero[recruiterhero].luck--;
                gain(recruiterhero, jarl[recruited].strength / 2, jarl[recruited].strength / 2);
                jarl[recruited].hero = recruiterhero;

                DISCARD saywho(HERO, recruiterhero, FALSE, FALSE);
                strcat(saystring, LLL(MSG_RECRUITS_JARL, "recruits jarl"));
                strcat(saystring, " ");
                strcat(saystring, jarl[recruited].name);
                strcat(saystring, ".");
                say(LOWER, FIRSTHEROCOLOUR + recruiterhero);
                anykey();

                return TRUE;
    }   }   }

    return FALSE;
}

MODULE SLONG d6(void)
{   return((goodrand() % 6) + 1);
}
EXPORT void newhero(SLONG whichhero, FLAG givesord)
{   SLONG whichjarl, whichsord;

    hero[whichhero].where     =
    hero[whichhero].homewhere = goodrand() % 36;
    hero[whichhero].glory     =
    hero[whichhero].wealth    = 0;
    hero[whichhero].luck      = 3;
    hero[whichhero].alive     = TRUE;
    hero[whichhero].verydead  =
    hero[whichhero].wounded   =
    hero[whichhero].hagall    =
    hero[whichhero].attacking =
    hero[whichhero].defending =
    hero[whichhero].loseturn  = FALSE;
    hero[whichhero].rune      =
    hero[whichhero].god       = -1;
    hero[whichhero].sea       = NORMAL;
    hero[whichhero].maidens   = 0;
    if (givesord)
    {   hero[whichhero].promoted = -1;
    }

    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].hero == whichhero)
        {   jarl[whichjarl].hero = -1;
    }   }

    deselect_hero(whichhero, FALSE);
    move_hero(whichhero, TRUE);
    // we don't unslot newborn counters

    if (!givesord)
    {   return;
    }

    // at least one sword should should always be available
    do
    {   whichsord = goodrand() % 6;
    } while (sord[whichsord].taken);
    sord[whichsord].taken         = TRUE;
    sord[whichsord].possessortype = HERO;
    sord[whichsord].possessor     = whichhero;
    sord[whichsord].where         = -1;

    sprintf
    (   saystring,
        "%s %s %s.",
        hero[whichhero].name,
        LLL(MSG_HAS_THE_SWORD, "has the sword"),
        sord[whichsord].name
    );
    say(LOWER, FIRSTHEROCOLOUR + whichhero);
    border(whichhero);
    anykey();
}
EXPORT void showcountry(SLONG country)
{   if (country >= 0 && country <= 65)
    {   strcpy(saystring, world[country].name);
        if (country <= 35)
        {   strcat(saystring, " (");
            stcl_d(numberstring, world[country].tax);
            strcat(saystring, numberstring);
            strcat(saystring, ")");
        }
        if (world[country].hero == -1)
        {   say(UPPER, WHITE);
        } else
        {   say(UPPER, FIRSTHEROCOLOUR + world[country].hero);
    }   }
    else
    {   strcpy(saystring, "-");
        say(UPPER, WHITE);
}   }

MODULE void attack(SLONG whichhero)
{   SLONG attackers,
          country,
          totalstrength,
          weakestmonster = -1, // to avoid spurious compiler warnings
          weakeststrength,
          whichattack,
          whichcountry,
          whichjarl,
          whichmonster,
          whichmonster2,
          whichrivalhero;
    FLAG  must           = FALSE;

    if (hero[whichhero].alive)
    {   for (whichmonster = 0; whichmonster <= monsters; whichmonster++)
        {   if (monster[whichmonster].alive && monster[whichmonster].where == hero[whichhero].where)
            {   must = TRUE;
                weakeststrength = 99;
                for (whichmonster2 = 0; whichmonster2 <= monsters; whichmonster2++)
                {   if (monster[whichmonster2].alive && monster[whichmonster2].where == hero[whichhero].where && monster[whichmonster2].strength < weakeststrength)
                    {   weakeststrength = monster[whichmonster2].strength;
                        weakestmonster  = whichmonster2;
                }   }
                break;
        }   }

        if (hero[whichhero].control == HUMAN)
        {   while (autosense(whichhero))
            {   DISCARD saywho(HERO, whichhero, TRUE, FALSE);
                strcat(saystring, LLL(MSG_SELECT_ATTACKERS, "select attackers"));
                strcat(saystring, "?");
                say(LOWER, FIRSTHEROCOLOUR + whichhero);
                hint
                (   (STRPTR) LLL(MSG_SELECT, "Select"),
                    (STRPTR) LLL(MSG_CANCEL, "Cancel")
                );
                country = getevent(COUNTRY, FIRSTHEROCOLOUR + whichhero);

                if (country >= 0)
                {   if (hero[whichhero].alive && hero[whichhero].where == country && !hero[whichhero].routed && !hero[whichhero].loseturn)
                    {   attackers = 1;
                        select_hero(whichhero, FALSE);
                        hero[whichhero].attacking = TRUE;
                    } else
                    {   attackers = 0;
                    }
                    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                    {   if (jarl[whichjarl].alive && jarl[whichjarl].where == country && jarl[whichjarl].hero == whichhero && !jarl[whichjarl].routed && !jarl[whichjarl].loseturn)
                        {   attackers++;
                            select_jarl(whichjarl, FALSE);
                            jarl[whichjarl].attacking = TRUE;
                    }   }
                    if (attackers)
                    {   updatescreen();
                        getdefender(whichhero, country);
                }   }
                elif (country == -3)
                {   if (must && hero[whichhero].alive && !hero[whichhero].routed)
                    {   // check whether the hero has fought a monster
                        for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
                        {   if (hero[whichhero].attacktype[whichattack] == MONSTER)
                            {   return;
                        }   }
                        DISCARD saywho(HERO, whichhero, TRUE, FALSE);
                        strcat(saystring, LLL(MSG_YOU_MUST_FIGHT_A_MONSTER, "you must fight a monster"));
                        strcat(saystring, ".");
                        say(LOWER, FIRSTHEROCOLOUR + whichhero);
                        anykey();
                    } else
                    {   if (hero[whichhero].attacking)
                        {   deselect_hero(whichhero, FALSE);
                        }
                        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                        {   if (jarl[whichjarl].alive && jarl[whichjarl].attacking)
                            {   deselect_jarl(whichjarl, FALSE);
                        }   }
                        updatescreen();
                        return;
        }   }   }   }
        elif (hero[whichhero].control == CONTROL_AMIGA)
        {   DISCARD saywho(HERO, whichhero, FALSE, FALSE);
            strcat(saystring, LLL(MSG_CONSIDERS_ATTACKS, "considers attacks"));
            strcat(saystring, "...");
            say(LOWER, FIRSTHEROCOLOUR + whichhero);

            for (whichcountry = 0; whichcountry <= 65; whichcountry++)
            {   // check for possible enemies

                if (!(totalstrength = getattackers(whichhero, whichcountry, FALSE)))
                {   continue;
                }
                for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                {   if
                    (   jarl[whichjarl].alive
                     && jarl[whichjarl].hero != whichhero
                     && jarl[whichjarl].where == whichcountry
                     && (   (jarl[whichjarl].face == FACEDOWN && hero[whichhero].luck >= 1)
                         || totalstrength >= checkdefenders_jarl(whichjarl, whichcountry)
                    )   )
                    {   amiga_attack(whichhero, JARL, whichjarl, whichcountry);
                }   }

                if (!(totalstrength = getattackers(whichhero, whichcountry, FALSE)))
                {   continue;
                }
                for (whichrivalhero = 0; whichrivalhero <= HEROES; whichrivalhero++)
                {   if
                    (   whichhero != whichrivalhero
                     && hero[whichrivalhero].alive
                     && hero[whichrivalhero].where == whichcountry
                     && totalstrength + 1 >= checkdefenders_hero(whichrivalhero, whichcountry) + hero[whichrivalhero].luck
                    )
                    {   amiga_attack(whichhero, HERO, whichrivalhero, whichcountry);
                }   }

                if (!(totalstrength = getattackers(whichhero, whichcountry, FALSE)))
                {   continue;
                }
                for (whichmonster = 0; whichmonster <= monsters; whichmonster++)
                {   if
                    (   monster[whichmonster].alive
                     && monster[whichmonster].where == whichcountry
                     && (   (must && weakestmonster == whichmonster)
                         || totalstrength >= monster[whichmonster].strength
                    )   )
                    {   amiga_attack(whichhero, MONSTER, whichmonster, whichcountry);
                }   }

                if (!(totalstrength = getattackers(whichhero, whichcountry, FALSE)))
                {   continue;
                }
                if

                (   whichcountry <= 35
                 && world[whichcountry].hero != whichhero
                 && !world[whichcountry].is
                 && totalstrength > world[whichcountry].tax
                )
                {   amiga_attack(whichhero, KINGDOM, whichcountry, whichcountry);
            }   }

            deselect_hero(whichhero, FALSE);
            for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
            {   if (jarl[whichjarl].attacking)
                {   deselect_jarl(whichjarl, FALSE);
            }   }
            updatescreen();
}   }   }

MODULE void gain(SLONG whichhero, SLONG glory, SLONG luck)
{   SLONG result;

    if (glory == 0 && luck == 0)
    {   return;
    }

    if (hero[whichhero].control == HUMAN)
    {   DISCARD saywho(HERO, whichhero, TRUE, FALSE);
        sprintf
        (   saystring2,
            "%s %ld (%s)%s %s %ld (%s)%s?",
            LLL(MSG_GAIN,         "gain"),
            glory,
            LLL(MSG_CHAR_GLORY,   "G"),
            LLL(MSG_UNCHAR_GLORY, "lory"),
            LLL(MSG_OR,           "or"),
            luck,
            LLL(MSG_CHAR_LUCK,    "L"),
            LLL(MSG_UNCHAR_LUCK,  "uck")
        );
        strcat(saystring, saystring2);
        say(LOWER, FIRSTHEROCOLOUR + whichhero);

        do
        {   result = getevent(GLKEYBOARD, FIRSTHEROCOLOUR + whichhero);
        } while (result != onekey[ONEKEY_GLORY] && result != onekey[ONEKEY_LUCK]);
        if (result == onekey[ONEKEY_GLORY])
        {   hero[whichhero].glory += glory;
        } else
        {   // assert(result == onekey[ONEKEY_LUCK]);
            hero[whichhero].luck  += luck;
    }   }
    else
    {   if (goodrand() % 2)
        {   hero[whichhero].luck += luck;
        } else
        {   hero[whichhero].glory += glory;
}   }   }

MODULE void move(SLONG whichhero)
{   SLONG assessment[CONNECTIONS + 2],
          bestassessment = 0, // to avoid spurious compiler warnings
          bestcountry,
          bestmove,
          country,
          i,
          moves,
          oldcountry,
          whichconnection,
          whichotherjarl,
          whichjarl;
    FLAG  legal;

    // HEROES

    ridertype = -1;
    for (i = 0; i <= HEROES; i++)
    {   hero[i].passenger = FALSE;
    }
    for (i = 0; i <= JARLS; i++)
    {   jarl[i].passenger = FALSE;
    }

    if (hero[whichhero].alive)
    {   select_hero(whichhero, (watchamiga || hero[whichhero].control == HUMAN) ? TRUE : FALSE);

        moves = getmoves(HERO, whichhero, FALSE);
        movearray[0] = hero[whichhero].where;
        whichrealmove =
        whichmove     = 1;
        oldcountry = hero[whichhero].where;
        freemove   = FALSE;

        for (i = 0; i <= 65; i++)
        {   world[i].visited = FALSE;
        }
        world[hero[whichhero].where].visited = TRUE;

        if (moves < 1)
        {   goto HEROMOVE_END;
        }

        if (hero[whichhero].control == HUMAN)
        {   if
            (   treasure[FREYFAXI].possessortype == HERO
             && treasure[FREYFAXI].possessor     == whichhero
            )
            {   // assert(treasure[FREYFAXI].where == -1);
                // assert(faxirides >= 1);

                if (ask_treasure(HERO, whichhero, FREYFAXI))
                {   treasure_disappear(FREYFAXI);
                    moves = getmoves(HERO, whichhero, TRUE);
            }   }
            elif
            (   treasure[FREYFAXI].possessortype == JARL
             && jarl[treasure[FREYFAXI].possessor].hero == whichhero
            )
            {   // assert(treasure[FREYFAXI].where == -1);
                // assert(faxirides >= 1);

                if (ask_treasure(JARL, treasure[FREYFAXI].possessor, FREYFAXI))
                {   treasure_disappear(FREYFAXI);
            }   }

            if
            (   treasure[TELEPORTSCROLL].possessortype == HERO
             && treasure[TELEPORTSCROLL].possessor     == whichhero
            )
            {   // assert(treasure[TELEPORTSCROLL].where == -1);

                if (ask_treasure(HERO, whichhero, TELEPORTSCROLL))
                {   treasure_disappear(TELEPORTSCROLL);

                    DISCARD saywho(HERO, whichhero, TRUE, FALSE);
                    strcat(saystring, LLL(MSG_SELECT_DESTINATION, "select destination"));
                    strcat(saystring, "?");
                    say(LOWER, FIRSTHEROCOLOUR + whichhero);
                    hint
                    (   (STRPTR) LLL(MSG_SELECT, "Select"),
                        "-"
                    );

                    do
                    {   country = getevent(COUNTRY, FIRSTHEROCOLOUR + whichhero);
                    } while (country < 0 || country > 65);
                    onemove_hero(whichhero, country);
                    goto HEROMOVE_CONTINUE;
            }   }

            do
            {   DISCARD saywho(HERO, whichhero, FALSE, FALSE);
                if (whichmove >= 2)
                {   sprintf
                    (   saystring2,
                        "%s %s, %s %ld %s %ld? (%s)",
                        LLL(MSG_IN,        "in"),
                        world[hero[whichhero].where].name,
                        LLL(MSG_MOVE,      "move"),
                        whichmove,
                        LLL(MSG_OF,        "of"),
                        moves,
                        LLL(MSG_BACKSPACE, "Backspace to redo")
                    );
                } else
                {   sprintf
                    (   saystring2,
                        "%s %s, %s %ld %s %ld?",
                        LLL(MSG_IN,        "in"),
                        world[hero[whichhero].where].name,
                        LLL(MSG_MOVE,      "move"),
                        whichmove,
                        LLL(MSG_OF,        "of"),
                        moves
                    );
                }
                strcat(saystring, saystring2);
                say(LOWER, FIRSTHEROCOLOUR + whichhero);
                hint
                (   (STRPTR) LLL(MSG_MOVE2,  "Move"),
                    (STRPTR) LLL(MSG_FINISH, "Finish")
                );

                do
                {   country = getevent(COUNTRY, FIRSTHEROCOLOUR + whichhero);
                } while ((country < -3 || country > 65) || country == -1);
                if (country == -3)
                {   break;
                } elif (country == -2)
                {   whichmove     =
                    whichrealmove = 1;

                    unslot_hero(whichhero);
                    hero[whichhero].where = oldcountry;
                    move_hero(whichhero, TRUE);
                    if (ridertype == HERO)
                    {   // assert(rider == whichhero);
                        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                        {   if (jarl[whichjarl].passenger)
                            {   // assert(jarl[whichjarl].hero == whichhero);
                                unslot_jarl(whichjarl);
                                jarl[whichjarl].where = oldcountry;
                                move_jarl(whichjarl, TRUE);
                    }   }   }

                    freemove = FALSE;
                } else
                {   legal = FALSE;
                    for (whichconnection = 0; whichconnection <= CONNECTIONS; whichconnection++)
                    {   if (world[hero[whichhero].where].connection[whichconnection] == country)
                        {   legal = TRUE;
                            break; // for speed
                    }   }
                    if (legal && islegal(HERO, whichhero, country, TRUE))
                    {   onemove_hero(whichhero, country);
                }   }
            } while (whichmove <= moves);

HEROMOVE_CONTINUE:
            ;

        } else
        {   // assert(hero[whichhero].control == CONTROL_AMIGA);

            if
            (   treasure[FREYFAXI].possessortype == HERO
             && treasure[FREYFAXI].possessor     == whichhero
            )
            {   // assert(treasure[FREYFAXI].where == -1);
                // assert(faxirides >= 1);

                if
                (   turn > turns - faxirides
                 || (   !hero[whichhero].hagall
                     && goodrand() % 6 == 0
                )   )
                {   treasure_disappear(FREYFAXI);
                    moves = getmoves(HERO, whichhero, TRUE);

                    DISCARD saywho(HERO, whichhero, FALSE, FALSE);
                    sprintf
                    (   saystring2,
                        "%s %s.",
                        LLL(MSG_RIDES_THE, "rides the"),
                        treasure[FREYFAXI].name
                    );
                    strcat(saystring, saystring2);
                    say(LOWER, FIRSTHEROCOLOUR + whichhero);
                    anykey();
            }   }
            elif
            (   treasure[FREYFAXI].possessortype == JARL
             && jarl[treasure[FREYFAXI].possessor].hero == whichhero
            )
            {   // assert(treasure[FREYFAXI].where == -1);
                // assert(faxirides >= 1);

                if
                (   turn > turns - faxirides
                 || (   !jarl[treasure[FREYFAXI].possessor].hagall
                     && goodrand() % 8 == 0
                )   )
                {   treasure_disappear(FREYFAXI);

                    DISCARD saywho(JARL, treasure[FREYFAXI].possessor, FALSE, FALSE);
                    sprintf
                    (   saystring2,
                        "%s %s.",
                        LLL(MSG_RIDES_THE, "rides the"),
                        treasure[FREYFAXI].name
                    );
                    strcat(saystring, saystring2);
                    say(LOWER, FIRSTHEROCOLOUR + whichhero);
                    anykey();
            }   }

            DISCARD saywho(HERO, whichhero, FALSE, FALSE);
            strcat(saystring, LLL(MSG_IS_MOVING, "is moving"));
            strcat(saystring, "...");
            say(LOWER, FIRSTHEROCOLOUR + whichhero);

            if
            (   hero[whichhero].wounded
             && (   hero[whichhero].rune == ING
                 || hero[whichhero].where == hero[whichhero].homewhere
            )   )
            {   goto HEROMOVE_END; // rest to heal
            }

            do
            {   assessment[CONNECTIONS + 1] = assess_hero(whichhero, hero[whichhero].where) - 1;
                for (i = 0; i <= CONNECTIONS; i++)
                {   assessment[i] = assess_hero(whichhero, world[hero[whichhero].where].connection[i]);
                }
                bestmove = -100;
                for (i = 0; i <= CONNECTIONS + 1; i++)
                {   if
                    (    assessment[i] >  bestmove
                     || (assessment[i] == bestmove && !(goodrand() % 2))
                    )
                    {   bestassessment = i;
                        bestmove       = assessment[i];
                }   }
                if (bestassessment == CONNECTIONS + 1)
                {   bestcountry = hero[whichhero].where;
                } else
                {   bestcountry = world[hero[whichhero].where].connection[bestassessment];
                }
                // assert(bestcountry >= 0 && bestcountry <= 65);

                if
                (   bestcountry != hero[whichhero].where // if moving
                 && !(world[bestcountry].visited)
                 && islegal(HERO, whichhero, bestcountry, FALSE)
                )
                {   onemove_hero(whichhero, bestcountry);
                } else
                {   break;
            }   }
            while (whichmove <= moves);
        }

HEROMOVE_END:

        /* For humans and Amiga */

        for (i = 0; i < whichrealmove; i++)
        {   for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
            {   if (movearray[i] == jarl[whichjarl].where && jarl[whichjarl].hero == whichhero)
                {   // hero moved past jarl during move
                    givegold(whichhero, whichjarl);
        }   }   }

        needtreasure(HERO, whichhero, hero[whichhero].where, hero[whichhero].control);
        needsord(HERO, whichhero, hero[whichhero].where, hero[whichhero].control);
        brosung(HERO, whichhero, hero[whichhero].control);

        // check healing

        if
        (   whichmove == 1
         && hero[whichhero].wounded
         && (   hero[whichhero].where == hero[whichhero].homewhere
             || hero[whichhero].rune  == ING
        )   )
        {   hero[whichhero].wounded = FALSE;
            DISCARD saywho(HERO, whichhero, FALSE, FALSE);
            strcat(saystring, LLL(MSG_HEALS, "heals"));
            strcat(saystring, ".");
            say(LOWER, FIRSTHEROCOLOUR + whichhero);
            anykey();
        } elif
        (   treasure[HEALINGPOTION].possessortype == HERO
         && treasure[HEALINGPOTION].possessor     == whichhero
         && hero[whichhero].wounded
        )
        {   if (hero[whichhero].control == CONTROL_AMIGA)
            {   hero[whichhero].wounded = FALSE;
                treasure_disappear(HEALINGPOTION);

                DISCARD saywho(HERO, whichhero, FALSE, FALSE);
                sprintf
                (   saystring2,
                    "%s %s.",
                    LLL(MSG_DRINKS_THE, "drinks the"),
                    treasure[HEALINGPOTION].name
                );
                strcat(saystring, saystring2);
                say(LOWER, FIRSTHEROCOLOUR + whichhero);
                anykey();
            } else
            {   // assert(hero[whichhero].control == HUMAN);

                if (ask_treasure(HERO, whichhero, HEALINGPOTION))
                {   hero[whichhero].wounded = FALSE;
                    treasure_disappear(HEALINGPOTION);
        }   }   }

        if (watchamiga || hero[whichhero].control == HUMAN)
        {   deselect_hero(whichhero, TRUE);
        }

        // JARLS

        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if (jarl[whichjarl].alive && jarl[whichjarl].hero == whichhero)
            {   // note that whichrealmove and freemove are not used for jarls

                select_jarl(whichjarl, (watchamiga || hero[whichhero].control == HUMAN) ? TRUE : FALSE);

                if (ridertype == JARL && rider == whichjarl)
                {   moves = getmoves(JARL, whichjarl, TRUE);
                } else
                {   moves = getmoves(JARL, whichjarl, FALSE);
                }
                movearray[0] = jarl[whichjarl].where;
                whichmove = 1;
                oldcountry = jarl[whichjarl].where;

                for (i = 0; i <= 65; i++)
                {   world[i].visited = FALSE;
                }
                world[jarl[whichjarl].where].visited = TRUE;

                if (moves < 1 || jarl[whichjarl].passenger)
                {   goto JARLMOVE_END;
                }

                if (hero[whichhero].control == HUMAN)
                {   if
                    (   treasure[TELEPORTSCROLL].possessortype == JARL
                     && treasure[TELEPORTSCROLL].possessor     == whichjarl
                    )
                    {   // assert(treasure[TELEPORTSCROLL].where == -1);

                        if (ask_treasure(JARL, whichjarl, TELEPORTSCROLL))
                        {   treasure_disappear(TELEPORTSCROLL);

                            DISCARD saywho(JARL, whichjarl, TRUE, FALSE);
                            strcat(saystring, LLL(MSG_SELECT_DESTINATION, "select destination"));
                            strcat(saystring, "?");
                            say(LOWER, FIRSTHEROCOLOUR + whichhero);
                            hint
                            (   (STRPTR) LLL(MSG_SELECT, "Select"),
                                "-"
                            );

                            do
                            {   country = getevent(COUNTRY, FIRSTHEROCOLOUR + whichhero);
                            } while (country < 0 || country > 65);
                            onemove_jarl(whichjarl, country);
                            goto JARLMOVE_CONTINUE;
                    }   }

                    do
                    {   DISCARD saywho(JARL, whichjarl, FALSE, FALSE);
                        if (whichmove >= 2)
                        {   sprintf
                            (   saystring2,
                                "%s %s, %s %ld %s %ld? (%s)",
                                LLL(MSG_IN,        "in"),
                                world[jarl[whichjarl].where].name,
                                LLL(MSG_MOVE,      "move"),
                                whichmove,
                                LLL(MSG_OF,        "of"),
                                moves,
                                LLL(MSG_BACKSPACE, "Backspace to redo")
                            );
                        } else
                        {   sprintf
                            (   saystring2,
                                "%s %s, %s %ld %s %ld?",
                                LLL(MSG_IN,        "in"),
                                world[jarl[whichjarl].where].name,
                                LLL(MSG_MOVE,      "move"),
                                whichmove,
                                LLL(MSG_OF,        "of"),
                                moves
                            );
                        }
                        strcat(saystring, saystring2);
                        say(LOWER, FIRSTHEROCOLOUR + whichhero);
                        hint
                        (   (STRPTR) LLL(MSG_MOVE2,  "Move"),
                            (STRPTR) LLL(MSG_FINISH, "Finish")
                        );

                        do
                        {   country = getevent(COUNTRY, FIRSTHEROCOLOUR + whichhero);
                        } while ((country < -3 || country > 65) || country == -1);
                        if (country == -3)
                        {   break;
                        } elif (country == -2)
                        {   whichmove = 1;

                            unslot_jarl(whichjarl);
                            jarl[whichjarl].where = oldcountry;
                            move_jarl(whichjarl, TRUE);
                            if (ridertype == JARL && rider == whichjarl)
                            {   if (hero[whichhero].passenger)
                                {   unslot_hero(whichhero);
                                    hero[whichhero].where = oldcountry;
                                    move_hero(whichhero, TRUE);
                                }
                                for (whichotherjarl = 0; whichotherjarl <= JARLS; whichotherjarl++)
                                {   if (jarl[whichotherjarl].passenger)
                                    {   // assert(jarl[whichotherjarl].hero == whichhero);
                                        unslot_jarl(whichotherjarl);
                                        jarl[whichotherjarl].where = oldcountry;
                                        move_jarl(whichotherjarl, TRUE);
                        }   }   }   }
                        else
                        {   legal = FALSE;
                            for (whichconnection = 0; whichconnection <= CONNECTIONS; whichconnection++)
                            {   if (world[jarl[whichjarl].where].connection[whichconnection] == country)
                                {   legal = TRUE;
                                    break; // for speed
                            }   }
                            if (legal && islegal(JARL, whichjarl, country, TRUE))
                            {   onemove_jarl(whichjarl, country);
                        }   }
                    } while (whichmove <= moves);

JARLMOVE_CONTINUE:
                    ;

                } elif (hero[whichhero].control == CONTROL_AMIGA)
                {   DISCARD saywho(JARL, whichjarl, FALSE, FALSE);
                    strcat(saystring, LLL(MSG_IS_MOVING, "is moving"));
                    strcat(saystring, "...");
                    say(LOWER, FIRSTHEROCOLOUR + whichhero);

                    do
                    {   assessment[CONNECTIONS + 1] = assess_jarl(whichjarl, jarl[whichjarl].where) - 1;
                        for (i = 0; i <= CONNECTIONS; i++)
                        {   assessment[i] = assess_jarl(whichjarl, world[jarl[whichjarl].where].connection[i]);
                        }
                        bestmove = -100;
                        for (i = 0; i <= CONNECTIONS + 1; i++)
                        {   if
                            (    assessment[i] >  bestmove
                             || (assessment[i] == bestmove && !(goodrand() % 2))
                            )
                            {   bestassessment = i;
                                bestmove       = assessment[i];
                        }   }

                        if (bestassessment == CONNECTIONS + 1)
                        {   bestcountry = jarl[whichjarl].where;
                        } else
                        {   bestcountry = world[jarl[whichjarl].where].connection[bestassessment];
                        }
                        // assert(bestcountry >= 0 && bestcountry <= 65);

                        if
                        (   bestcountry != jarl[whichjarl].where // if moving
                         && !(world[bestcountry].visited)
                         && islegal(JARL, whichjarl, bestcountry, FALSE)
                        )
                        {   onemove_jarl(whichjarl, bestcountry);
                        } else
                        {   break;
                    }   }
                    while (whichmove <= moves);
                }

JARLMOVE_END:

                /* For humans and Amiga */

                for (i = 0; i < whichmove; i++)
                {   if (movearray[i] == hero[whichhero].where)
                    {   // jarl moved past hero during move
                        givegold(whichhero, whichjarl);
                }   }

                needtreasure(JARL, whichjarl, jarl[whichjarl].where, hero[whichhero].control);
                needsord(JARL, whichjarl, jarl[whichjarl].where, hero[whichhero].control);
                brosung(JARL, whichjarl, hero[whichhero].control);

                if (watchamiga || hero[whichhero].control == HUMAN)
                {   deselect_jarl(whichjarl, TRUE);
        }   }   }

        if (!watchamiga && hero[whichhero].control == CONTROL_AMIGA)
        {   updatescreen();
            Delay(5);
            deselect_hero(whichhero, FALSE);
            for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
            {   if (jarl[whichjarl].alive && jarl[whichjarl].hero == whichhero)
                {   deselect_jarl(whichjarl, FALSE);
            }   }
            updatescreen();
    }   }

    ridertype = -1;
    for (i = 0; i <= HEROES; i++)
    {   hero[i].passenger = FALSE;
    }
    for (i = 0; i <= JARLS; i++)
    {   jarl[i].passenger = FALSE;
}   }

EXPORT void anykey(void)
{   DISCARD getevent(ANYKEY, WHITE);
}

MODULE SLONG getluck(SLONG whichhero)
{   SLONG result;

    hint("0", "0");

    for (;;)
    {   do
        {   result = getevent(MULTIKEYBOARD, FIRSTHEROCOLOUR + whichhero);
        } while (result < '0' || result > '9');

        result -= '0';

        if (result <= hero[whichhero].luck)
        {   hero[whichhero].luck -= result;
            return result;
        } else
        {   return 0;
}   }   }

MODULE void amiga_rout(SLONG routedtype, SLONG routed)
{   SLONG decision,
          i,
          whichmove,
          moves;
    FLAG  freemove,
          stop;
    UBYTE whichcolour;

    if (routedtype == HERO)
    {   hero[routed].routed = TRUE;
    } elif (routedtype == JARL)
    {   jarl[routed].routed = TRUE;
    }

    moves = getmoves(routedtype, routed, FALSE);
    if (moves < 1)
    {   return;
    }

    whichcolour = saywho(routedtype, routed, FALSE, FALSE);
    strcat(saystring, LLL(MSG_IS_BEING_ROUTED, "is being routed"));
    strcat(saystring, "...");
    say(LOWER, whichcolour);

    for (i = 0; i <= 65; i++)
    {   world[i].visited = FALSE;
    }

    if (routedtype == HERO)
    {   world[hero[routed].where].visited = TRUE;
        freemove = FALSE;

        for (whichmove = 1; whichmove <= moves; whichmove++)
        {   stop = TRUE;
            for (i = 0; i <= CONNECTIONS; i++)
            {   if
                (   world[hero[routed].where].connection[i] != -1
                 && world[world[hero[routed].where].connection[i]].visited == FALSE
                 && islegal(HERO, routed, world[hero[routed].where].connection[i], FALSE)
                )
                {   stop = FALSE;
                    break;
            }   }
            if (stop)
            {   break;
            }
            do
            {   decision = goodrand() % (CONNECTIONS + 1);
            } while
            (   world[hero[routed].where].connection[decision] == -1
             || world[world[hero[routed].where].connection[decision]].visited == TRUE
             || !islegal(HERO, routed, world[hero[routed].where].connection[decision], FALSE)
            );

            unslot_hero(routed);
            hero[routed].where = world[hero[routed].where].connection[decision];
            move_hero(routed, TRUE);
            if (checkfree(routed, &freemove))
            {   whichmove--;
    }   }   }
    elif (routedtype == JARL)
    {   world[jarl[routed].where].visited = TRUE;

        for (whichmove = 1; whichmove <= moves; whichmove++)
        {   stop = TRUE;
            for (i = 0; i <= CONNECTIONS; i++)
            {   if
                (   world[jarl[routed].where].connection[i] != -1
                 && world[world[jarl[routed].where].connection[i]].visited == FALSE
                 && islegal(JARL, routed, world[jarl[routed].where].connection[i], FALSE)
                )
                {   stop = FALSE;
                    break;
            }   }
            if (stop)
            {   break;
            }
            do
            {   decision = goodrand() % (CONNECTIONS + 1);
            } while
            (   world[jarl[routed].where].connection[decision] == -1
             || world[world[jarl[routed].where].connection[decision]].visited == TRUE
             || !islegal(JARL, routed, world[jarl[routed].where].connection[decision], FALSE)
            );

            unslot_jarl(routed);
            jarl[routed].where = world[jarl[routed].where].connection[decision];
            move_jarl(routed, TRUE);
    }   }
    elif (routedtype == MONSTER)
    {   world[monster[routed].where].visited = TRUE;

        for (whichmove = 1; whichmove <= moves; whichmove++)
        {   stop = TRUE;
            for (i = 0; i <= CONNECTIONS; i++)
            {   if
                (   world[monster[routed].where].connection[i] != -1
                 && world[world[monster[routed].where].connection[i]].visited == FALSE
                 && islegal(MONSTER, routed, world[monster[routed].where].connection[i], FALSE)
                )
                {   stop = FALSE;
                    break;
            }   }
            if (stop)
            {   break;
            }
            do
            {   decision = goodrand() % (CONNECTIONS + 1);
            } while
            (   world[monster[routed].where].connection[decision] == -1
             || world[world[monster[routed].where].connection[decision]].visited == TRUE
             || !islegal(MONSTER, routed, world[monster[routed].where].connection[decision], FALSE)
            );

            unslot_monster(routed);
            monster[routed].where = world[monster[routed].where].connection[decision];
            move_monster(routed, TRUE);
}   }   }

MODULE void human_rout(SLONG routedtype, SLONG routed, SLONG routerhero)
{   SLONG country,
          oldcountry = -1,
          moves,
          whichconnection,
          whichmove;
    FLAG  legal, freemove;

    moves = getmoves(routedtype, routed, FALSE);

    if (moves == 0)
    {   return;
    }

    whichmove = 1;
    freemove = FALSE;
    do
    {   DISCARD saywho(HERO, routerhero, TRUE, FALSE);
        sprintf
        (   saystring2,
            "%s %ld %s %ld %s",
            LLL(MSG_ROUT, "rout"),
            whichmove,
            LLL(MSG_OF,   "of"),
            moves,
            LLL(MSG_FOR,  "for")
        );
        strcat(saystring, saystring2);
        DISCARD saywho(routedtype, routed, FALSE, TRUE);
        strcat(saystring, "?");
        say(LOWER, FIRSTHEROCOLOUR + routerhero);

        do
        {   country = getevent(COUNTRY, FIRSTHEROCOLOUR + routerhero);
        } while ((country < -3 || country > 65) || country == -1);
        if (country == -3)
        {   break;
        } elif (country == -2)
        {   whichmove = 1;
            if (routedtype == HERO)
            {   unslot_hero(routed);
                hero[routed].where = oldcountry;
                move_hero(routed, TRUE);
                freemove = FALSE;
            } elif (routedtype == JARL)
            {   unslot_jarl(routed);
                jarl[routed].where = oldcountry;
                move_jarl(routed, TRUE);
            } else
            {   // assert(routedtype == MONSTER);
                unslot_monster(routed);
                monster[routed].where = oldcountry;
                move_monster(routed, TRUE);
        }   }
        else
        {   legal = FALSE;
            for (whichconnection = 0; whichconnection <= CONNECTIONS; whichconnection++)
            {   if
                (   (routedtype == HERO    && world[hero[routed].where].connection[whichconnection] == country)
                 || (routedtype == JARL    && world[jarl[routed].where].connection[whichconnection] == country)
                 || (routedtype == MONSTER && world[monster[routed].where].connection[whichconnection] == country)
                )
                {   legal = TRUE;
                    break; // for speed
            }   }
            if (legal && islegal(routedtype, routed, country, TRUE))
            {   if (routedtype == HERO)
                {   unslot_hero(routed);
                    hero[routed].where = country;
                    move_hero(routed, TRUE);

                    if (checkfree(routed, &freemove))
                    {   whichmove--;
                }   }
                elif (routedtype == JARL)
                {   unslot_jarl(routed);
                    jarl[routed].where = country;
                    move_jarl(routed, TRUE);
                } else
                {   // assert(routedtype == MONSTER);
                    unslot_monster(routed);
                    monster[routed].where = country;
                    move_monster(routed, TRUE);
                }
                whichmove++;
        }   }
    } while (whichmove <= moves);
}

MODULE SLONG getmoves(SLONG countertype, SLONG whichcounter, FLAG freyfaxi)
{   SLONG moves;

    switch (countertype)
    {
    case HERO:
        moves = hero[whichcounter].moves;
    acase MONSTER:
        // assert(!freyfaxi);
        moves = monster[whichcounter].moves;
    acase JARL:
        moves = jarl[whichcounter].moves;
    adefault:
        moves = 0; // to avoid spurious SAS/C compiler warnings
    }

    if (freyfaxi)
    {   moves *= 2;
    }

    if
    (   countertype != MONSTER // so dragons don't use magic treasures
     && treasure[MAGICSHIRT].possessortype == countertype
     && treasure[MAGICSHIRT].possessor     == whichcounter
    )
    {   // assert(treasure[MAGICSHIRT].where == -1);
        moves++;
    }

    if (countertype == HERO && hero[whichcounter].rune == EON)
    {   moves++;
    }

    if
    (   (countertype == HERO && hero[whichcounter].loseturn)
     || (countertype == JARL && jarl[whichcounter].loseturn)
    )
    {   moves = 0;
    }

    /* If you are stuck at sea or on an island, and can't travel
       by sea, then you can't move at all that turn. */
    if
    (   (countertype == HERO    && !islegal(HERO,    whichcounter, hero[whichcounter].where,    FALSE))
     || (countertype == JARL    && !islegal(JARL,    whichcounter, jarl[whichcounter].where,    FALSE))
     || (countertype == MONSTER && !islegal(MONSTER, whichcounter, monster[whichcounter].where, FALSE))
    )
    {   moves = 0;
    }

    return moves;
}

EXPORT void treasure_disappear(SLONG whichtreasure)
{   if (whichtreasure == FREYFAXI && faxirides >= 1)
    {   faxirides--;
    }
    if (whichtreasure != FREYFAXI || faxirides == 0)
    {   treasure[whichtreasure].possessortype = -1; // noone
        treasure[whichtreasure].possessor     = -1; // noone
        treasure[whichtreasure].where         = -1; // nowhere
        if (whichtreasure == FREYFAXI)
        {   faxirides = -1; // so it only disappears once
    }   }
    // the treasure in question won't be on the board at the moment anyway
}

MODULE void thor(SLONG whichhero)
{   SLONG whichprayer;

    if (hero[whichhero].god == THOR)
    {   hero[whichhero].god = -1;
        whichprayer = d6();

        if (whichprayer >= 1 && whichprayer <= 3)
        {   sprintf
            (   saystring,
                "Thor %s %s %s.",
                LLL(MSG_DECIDES_THAT_HERO,  "decides that hero"),
                hero[whichhero].name,
                LLL(MSG_DESERVES_NO_REWARD, "deserves no reward")
            );
        } elif (whichprayer == 4 || whichprayer == 5)
        {   hero[whichhero].glory++;

            sprintf
            (   saystring,
                "Thor %s %s %s.",
                LLL(MSG_REWARDS_HERO,       "rewards hero"),
                hero[whichhero].name,
                LLL(MSG_B_S_T_H_G_1_G,      "by speaking to him, granting 1 glory")
            );
        } else
        {   // assert(whichprayer == 6);

            hero[whichhero].glory += 2;

            sprintf
            (   saystring,
                "Thor %s %s %s.",
                LLL(MSG_HONOURS_HERO,       "honours hero"),
                hero[whichhero].name,
                LLL(MSG_B_E_W_H_G_2_G,      "by eating with him, granting 2 glory")
            );
        }

        say(LOWER, FIRSTHEROCOLOUR + whichhero);
        anykey();
}   }

MODULE void dospell(SLONG spell, SLONG caster)
{   SLONG whichhero, whichjarl, whichmonster;

    if (spell == HAGALL || spell == JARA || d6() <= 3) // if it's a spell which doesn't have a saving throw, or the saving throw is missed
    {   strcat(saystring, ".");
        say(LOWER, WHITE);
        anykey();

        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   if
            (   hero[whichhero].control != NONE
             && hero[whichhero].alive
             && hero[whichhero].where == monster[caster].where
            )
            {   if (hero[whichhero].rune == SYGIL && d6() <= 3)
                {   strcpy(saystring, LLL(MSG_HERO, "Hero"));
                    strcat(saystring, " ");
                    strcat(saystring, hero[whichhero].name);
                    strcat(saystring, LLL(MSG_S_RUNE_PROTECTS_HIM, "'s rune protects him"));
                    strcat(saystring, ".");
                    say(LOWER, FIRSTHEROCOLOUR + whichhero);
                    anykey();
                } else
                {   if (spell == HAGALL)
                    {   hero[whichhero].hagall = TRUE;
                        hero[whichhero].sea    = BAD;
                    } elif (spell == JARA)
                    {   hero[whichhero].loseturn = TRUE;
                    } elif (spell == NIED)
                    {   hero[whichhero].loseturn = TRUE;
                        hero[whichhero].attacking = FALSE;
                        deselect_hero(whichhero, TRUE);
                    } elif (spell == WYNN)
                    {   hero[whichhero].glory -= 2;
                        if (hero[whichhero].glory < 0)
                        {   hero[whichhero].glory = 0;
                        }
                        amiga_rout(HERO, whichhero);
                        hero[whichhero].attacking = FALSE;
                        deselect_hero(whichhero, TRUE);
                    } elif (spell == YR)
                    {   wound(MONSTER, caster, -1, HERO, whichhero, whichhero);
                        hero[whichhero].attacking = FALSE;
                        deselect_hero(whichhero, TRUE);
        }   }   }   }
        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if
            (   jarl[whichjarl].alive
             && jarl[whichjarl].where == monster[caster].where
            )
            {   if (spell == HAGALL)
                {   jarl[whichjarl].hagall = TRUE;
                    jarl[whichjarl].sea    = BAD;
                } elif (spell == JARA)
                {   jarl[whichjarl].loseturn = TRUE;
                } elif (spell == NIED)
                {   jarl[whichjarl].loseturn = TRUE;
                    jarl[whichjarl].attacking = FALSE;
                    deselect_jarl(whichjarl, TRUE);
                } elif (spell == WYNN)
                {   amiga_rout(JARL, whichjarl);
                    jarl[whichjarl].attacking = FALSE;
                    deselect_jarl(whichjarl, TRUE);
                } elif (spell == YR)
                {   if (jarl[whichjarl].face == FACEUP)
                    {   wound(MONSTER, caster, -1, JARL, whichjarl, jarl[whichjarl].hero);
                        jarl[whichjarl].attacking = FALSE;
                        deselect_jarl(whichjarl, TRUE);
        }   }   }   }

        if (spell == HAGALL)
        {   for (whichmonster = 0; whichmonster <= monsters; whichmonster++)
            {   if
                (   monster[whichmonster].alive
                 && monster[whichmonster].where == monster[caster].where
                )
                {   monster[whichmonster].hagall = TRUE;
                    monster[whichmonster].sea    = BAD;
    }   }   }   }
    else
    {   strcat(saystring, ", ");
        strcat(saystring, LLL(MSG_BUT_IT_FIZZLES, "but it fizzles"));
        strcat(saystring, "!");
        say(LOWER, WHITE);
        anykey();
}   }

MODULE void cast(SLONG caster, SLONG whichspell)
{   sprintf
    (   saystring,
        "%s %s %s ",
        monstertypes[monster[caster].species],
        monster[caster].name,
        LLL(MSG_CASTS, "casts")
    );

    switch (whichspell)
    {
    case HAGALL:
        strcat(saystring, "Hagall (");
        strcat(saystring, LLL(MSG_HAIL, "hail"));
        strcat(saystring, ")");

        dospell(HAGALL, caster);
    acase IS:
        world[monster[caster].where].is = TRUE;
        darken();

        strcat(saystring, "Is (");
        strcat(saystring, LLL(MSG_ICE, "ice"));
        strcat(saystring, ").");

        say(LOWER, WHITE);
        anykey();
    acase JARA:
        strcat(saystring, "Jara (");
        strcat(saystring, LLL(MSG_LOSE_NEXT_TURN, "lose next turn"));
        strcat(saystring, ")");

        dospell(JARA, caster);
    acase NIED:
        strcat(saystring, "Nied (");
        strcat(saystring, LLL(MSG_N_R_A_L_N_T, "no result and lose next turn"));
        strcat(saystring, ")");

        dospell(NIED, caster);
    acase WYNN:
        strcat(saystring, "Wynn (");
        strcat(saystring, LLL(MSG_FLEEING, "fleeing"));
        strcat(saystring, ")");

        dospell(WYNN, caster);
    acase YR:
        strcat(saystring, "Yr (");
        strcat(saystring, LLL(MSG_WOUNDING, "wounding"));
        strcat(saystring, ")");

        dospell(YR, caster);
}   }

MODULE void getdefender(SLONG attackhero, SLONG here)
{   FLAG  done = FALSE;
    SLONG counter, whichattack, whichjarl;

    do
    {   DISCARD saywho(HERO, attackhero, TRUE, FALSE);
        strcat(saystring, LLL(MSG_SELECT_DEFENDER, "select defender"));
        strcat(saystring, "?");
        say(LOWER, FIRSTHEROCOLOUR + attackhero);
        hint
        (   (STRPTR) LLL(MSG_SELECT, "Select"),
            (STRPTR) LLL(MSG_CANCEL, "Cancel")
        );

        counter = getevent(COUNTER, FIRSTHEROCOLOUR + attackhero);
        if (counter == -2 || counter == -3)
        {   // user wants to quit (back to `select attacker')
            if (hero[attackhero].attacking)
            {   deselect_hero(attackhero, TRUE);
                hero[attackhero].attacking = FALSE;
            }
            for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
            {   if (jarl[whichjarl].alive && jarl[whichjarl].attacking)
                {   deselect_jarl(whichjarl, TRUE);
                    jarl[whichjarl].attacking = FALSE;
            }   }
            return;
        } elif (countertype == HERO) // if an enemy hero
        {   if (counter != attackhero && hero[counter].where == here)
            {   done = TRUE;
        }   }
        elif (countertype == JARL) // if an enemy jarl
        {   if (jarl[counter].hero != attackhero && jarl[counter].where == here)
            {   done = TRUE;
        }   }
        elif (countertype == MONSTER) // if a monster
        {   if (monster[counter].where == here)
            {   done = TRUE;
        }   }
        elif (countertype == KINGDOM)
        {   if
            (   world[counter].hero != attackhero
             && counter <= 35
             && counter == here
            )
            {   if (world[counter].is)
                {   DISCARD saywho(KINGDOM, counter, FALSE, FALSE);
                    strcat(saystring, LLL(MSG_IS_COVERED_WITH_ICE, "is covered with ice"));
                    strcat(saystring, ".");
                    say(LOWER, WHITE);
                    anykey();
                } else
                {   done = TRUE;
        }   }   }

        if (done)
        {   if (hero[attackhero].attacking)
            {   // check if the hero has already fought this
                for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
                {   if
                    (   hero[attackhero].attacktype[whichattack] == countertype
                     && hero[attackhero].attacked[whichattack]   == counter
                    )
                    {   done = FALSE;

                        DISCARD saywho(HERO, attackhero, FALSE, FALSE);
                        strcat(saystring, LLL(MSG_H_A_F, "has already fought"));
                        DISCARD saywho(countertype, counter, FALSE, TRUE);
                        strcat(saystring, " ");
                        strcat(saystring, LLL(MSG_THIS_TURN, "this turn"));
                        strcat(saystring, ".");
                        say(LOWER, FIRSTHEROCOLOUR + attackhero);
                        anykey();
                        break; // for speed
            }   }   }
            for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
            {   if (jarl[whichjarl].attacking)
                {   for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
                    {   if
                        (   jarl[whichjarl].attacktype[whichattack] == countertype
                         && jarl[whichjarl].attacked[whichattack]   == counter
                        )
                        {   done = FALSE;

                            DISCARD saywho(JARL, whichjarl, FALSE, FALSE);
                            strcat(saystring, LLL(MSG_H_A_F, "has already fought"));
                            DISCARD saywho(countertype, counter, FALSE, TRUE);
                            strcat(saystring, " ");
                            strcat(saystring, LLL(MSG_THIS_TURN, "this turn"));
                            strcat(saystring, ".");
                            say(LOWER, FIRSTHEROCOLOUR + attackhero);
                            anykey();
                            break; // for speed
    }   }   }   }   }   }
    while (!done);

    // ok, going ahead with the battle
    if (countertype == JARL && jarl[counter].face == FACEDOWN)
    {   revealjarl(counter, TRUE);
    }
    if (hero[attackhero].attacking)
    {   for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
        {   if (hero[attackhero].attacktype[whichattack] == -1)
            {   hero[attackhero].attacktype[whichattack] = countertype;
                hero[attackhero].attacked[whichattack]   = counter;
                break;
    }   }   }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].attacking)
        {   for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
            {   if (jarl[whichjarl].attacktype[whichattack] == -1)
                {   jarl[whichjarl].attacktype[whichattack] = countertype;
                    jarl[whichjarl].attacked[whichattack]   = counter;
                    break;
    }   }   }   }

    dobattle(countertype, counter, attackhero);
}

MODULE void needsord(SLONG countertype, SLONG counter, SLONG whichcountry, SLONG control)
{   SLONG result = -1, // to avoid spurious compiler warnings
          whichsord;
    UBYTE whichcolour;

    for (whichsord = 0; whichsord <= SORDS; whichsord++)
    {   if
        (   sord[whichsord].possessortype == countertype
         && sord[whichsord].possessor     == counter
        )
        {   return;
    }   }

    for (whichsord = 0; whichsord <= SORDS; whichsord++)
    {   if
        (   sord[whichsord].possessortype == KINGDOM
         && sord[whichsord].where == whichcountry
        )
        {   // assert(sord[whichsord].possessor = -1);

            whichcolour = saywho(countertype, counter, FALSE, FALSE);

            if (control == HUMAN)
            {   sprintf
                (   saystring2,
                    "%s %s, %s %s (%s/%s)?",
                    LLL(MSG_IN,         "in"),
                    world[whichcountry].name,
                    LLL(MSG_TAKE_SWORD, "take sword"),
                    sord[whichsord].name,
                    LLL(MSG_CHAR_YES,   "Y"),
                    LLL(MSG_CHAR_NO,    "N")
                );
                strcat(saystring, saystring2);
                say(LOWER, whichcolour);
                do
                {   result = getevent(YNKEYBOARD, whichcolour);
                } while (result != onekey[ONEKEY_YES] && result != onekey[ONEKEY_NO]);
            }

            if (control == CONTROL_AMIGA || result == onekey[ONEKEY_YES])
            {   remove_sord(whichsord, TRUE);
                sord[whichsord].possessortype = countertype;
                sord[whichsord].possessor     = counter;
                sord[whichsord].where         = -1;
            }
            if (control == CONTROL_AMIGA)
            {   sprintf
                (   saystring2,
                    "%s %s.",
                    LLL(MSG_TAKES_SWORD, "takes sword"),
                    sord[whichsord].name
                );
                strcat(saystring, saystring2);
                say(LOWER, whichcolour);
                anykey();
            }
            if (result == onekey[ONEKEY_YES] || control == CONTROL_AMIGA)
            {   return;
}   }   }   }

MODULE void brosung(SLONG countertype, SLONG whichcounter, SLONG control)
{   SLONG result, whichconnection, whichmonster, whichtreasure, where;
    UBYTE whichcolour;

    if
    (   control == CONTROL_AMIGA
     || treasure[BROSUNGNECKLACE].possessortype != countertype
     || treasure[BROSUNGNECKLACE].possessor     != whichcounter
    )
    {   return;
    }

    for (whichconnection = 0; whichconnection <= CONNECTIONS; whichconnection++)
    {   if (countertype == HERO)
        {   where = world[hero[whichcounter].where].connection[whichconnection];
        } else
        {   // assert(countertype == JARL);
            where = world[jarl[whichcounter].where].connection[whichconnection];
        }
        if (where == -1)
        {   break;
        }
        for (whichmonster = 0; whichmonster <= monsters; whichmonster++)
        {   if
            (   monster[whichmonster].alive
             && monster[whichmonster].species == DRAGON
             && monster[whichmonster].where == where
            )
            {   // there is a dragon here
                for (whichtreasure = 0; whichtreasure <= treasures; whichtreasure++)
                {   if
                    (   treasure[whichtreasure].possessortype == MONSTER
                     && treasure[whichtreasure].possessor == whichmonster
                    )
                    {   whichcolour = saywho(countertype, whichcounter, TRUE, FALSE);
                        sprintf
                        (   saystring2,
                            "%s %s %s %s %s (%s/%s)?",
                            LLL(MSG_EXCHANGE_THE, "exchange the"),
                            treasure[BROSUNGNECKLACE].name,
                            LLL(MSG_WITH,         "with"),
                            monstertypes[DRAGON],
                            monster[whichmonster].name,
                            LLL(MSG_CHAR_YES,     "Y"),
                            LLL(MSG_CHAR_NO,      "N")
                        );
                        strcat(saystring, saystring2);
                        say(LOWER, whichcolour);

                        do
                        {   result = getevent(YNKEYBOARD, whichcolour);
                        } while (result != onekey[ONEKEY_YES] && result != onekey[ONEKEY_NO]);
                        if (result == onekey[ONEKEY_YES])
                        {   // give the dragon's treasure to the hero/jarl
                            treasure[whichtreasure].possessortype   = countertype;
                            treasure[whichtreasure].possessor       = whichcounter;

                            whichcolour = saywho(countertype, whichcounter, FALSE, FALSE);
                            strcat(saystring, LLL(MSG_TAKES_THE, "takes the"));
                            strcat(saystring, " ");
                            strcat(saystring, treasure[whichtreasure].name);
                            strcat(saystring, ".");
                            say(LOWER, whichcolour);

                            // give the hero/jarl's treasure to the dragon
                            treasure[BROSUNGNECKLACE].possessortype = MONSTER;
                            treasure[BROSUNGNECKLACE].possessor     = whichmonster;
                            break;
}   }   }   }   }   }   }

EXPORT void promote(SLONG whichhero, SLONG whichjarl)
{   remove_jarl(whichjarl, TRUE);
    jarl[whichjarl].alive     =
    hero[whichhero].wounded   = FALSE;
    hero[whichhero].alive     = TRUE;
    hero[whichhero].promoted  = whichjarl;
    hero[whichhero].name      = jarl[whichjarl].name;
    hero[whichhero].moves     = jarl[whichjarl].moves;
    hero[whichhero].strength  = jarl[whichjarl].strength;
    hero[whichhero].where     = jarl[whichjarl].where;
    hero[whichhero].homewhere = jarl[whichjarl].homewhere;
    hero[whichhero].hagall    = jarl[whichjarl].hagall;
    hero[whichhero].loseturn  = jarl[whichjarl].loseturn;
    hero[whichhero].wealth    = jarl[whichjarl].wealth;
    hero[whichhero].god       =
    hero[whichhero].rune      = -1;
    hero[whichhero].maidens   =
    hero[whichhero].glory     = 0;
    deselect_hero(whichhero, TRUE);
    move_hero(whichhero, TRUE);
}

EXPORT void withdraw(SLONG whichhero)
{   SLONG whichcountry, whichjarl;

    hero[whichhero].verydead = TRUE;

    // all the jarls of the dead hero are freed
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].alive && jarl[whichjarl].hero == whichhero)
        {   jarl[whichjarl].hero = -1;
    }   }

    // all the kingdoms of the dead hero declare independence
    for (whichcountry = 0; whichcountry <= 35; whichcountry++)
    {   if (world[whichcountry].hero == whichhero)
        {   world[whichcountry].hero = -1;
    }   }

    darken();
}

MODULE void needtreasure(SLONG countertype, SLONG counter, SLONG whichcountry, SLONG control)
{   SLONG result = -1, // to avoid spurious compiler warnings
          whichtreasure;
    UBYTE whichcolour;

    for (whichtreasure = 0; whichtreasure <= treasures; whichtreasure++)
    {   if
        (   treasure[whichtreasure].possessortype == KINGDOM
         && treasure[whichtreasure].where == whichcountry
        )
        {   // assert(treasure[whichtreasure].possessor = -1);

            whichcolour = saywho(countertype, counter, FALSE, FALSE);
            if (control == HUMAN)
            {   sprintf
                (   saystring2,
                    "%s %s, %s %s (%s/%s)?",
                    LLL(MSG_IN,         "in"),
                    world[whichcountry].name,
                    LLL(MSG_TAKE_THE,   "take the"),
                    treasure[whichtreasure].name,
                    LLL(MSG_CHAR_YES,   "Y"),
                    LLL(MSG_CHAR_NO,    "N")
                );
            } else
            {   sprintf
                (   saystring2,
                    "%s %s.",
                    LLL(MSG_TAKES_THE, "takes the"),
                    treasure[whichtreasure].name
                );
            }
            strcat(saystring, saystring2);
            say(LOWER, whichcolour);

            if (control == HUMAN)
            {   do
                {   result = getevent(YNKEYBOARD, whichcolour);
                } while (result != onekey[ONEKEY_YES] && result != onekey[ONEKEY_NO]);
            } else
            {   anykey();
            }

            if (control == CONTROL_AMIGA || result == onekey[ONEKEY_YES])
            {   remove_treasure(whichtreasure, TRUE);
                treasure[whichtreasure].possessortype = countertype;
                treasure[whichtreasure].possessor     = counter;
                treasure[whichtreasure].where         = -1;
}   }   }   }

EXPORT void pad(STRPTR thestring)
{   SLONG i, length;

    length = (SLONG) strlen(thestring);

    if (length < 22)
    {   for (i = length; i <= 22; i++)
        {   strcat(thestring, " ");
}   }   }

EXPORT void print_location(SLONG whichcountry, SLONG index)
{   sprintf(label[index], "%s:", LLL(MSG_LOCATION, "Location"));
    sprintf
    (   line[LEFTSIDE][index],
        "%s (%ld)",
        world[whichcountry].name,
        world[whichcountry].tax
    );
}
EXPORT void print_sea(SLONG sea_value, SLONG index)
{   sprintf(label[index], "%s?", LLL(MSG_MOVE_BY_SEA, "Move by sea"));
    if (sea_value == NORMAL)
    {   strcpy(line[LEFTSIDE][index], LLL(MSG_YES, "Yes"));
    } elif (sea_value == BAD)
    {   strcpy(line[LEFTSIDE][index], LLL(MSG_NO, "No"));
    } else
    {   // assert(sea_value == GOOD);
        strcpy(line[LEFTSIDE][index], LLL(MSG_SPECIAL, "Special"));
}   }
EXPORT void print_hagall(SLONG hagall_value, SLONG index)
{   strcpy(label[index], "Hagall (");
    strcat(label[index], LLL(MSG_HAIL, "hail"));
    strcat(label[index], ")?");
    if (hagall_value)
    {   strcpy(line[LEFTSIDE][index], LLL(MSG_YES, "Yes"));
    } else
    {   strcpy(line[LEFTSIDE][index], LLL(MSG_NO, "No"));
}   }
EXPORT void print_paralyzed(SLONG loseturn_value, SLONG index)
{   sprintf(label[index], "Jara (%s)?", LLL(MSG_LOSE_TURN, "lose turn"));
    if (loseturn_value)
    {   strcpy(line[LEFTSIDE][index], LLL(MSG_YES, "Yes"));
    } else
    {   strcpy(line[LEFTSIDE][index], LLL(MSG_NO, "No"));
}   }
EXPORT void print_routed(SLONG routed_value, SLONG index)
{   sprintf(label[index], "%s?", LLL(MSG_ROUTED, "Routed"));
    if (routed_value)
    {   strcpy(line[LEFTSIDE][index], LLL(MSG_YES, "Yes"));
    } else
    {   strcpy(line[LEFTSIDE][index], LLL(MSG_NO, "No"));
}   }

MODULE void amiga_attack(SLONG attackhero, SLONG defendtype, SLONG defender, SLONG whichcountry)
{   SLONG whichattack, whichjarl;

    // OK, going ahead with the battle

    DISCARD getattackers(attackhero, whichcountry, TRUE);
    if (defendtype == JARL && jarl[defender].face == FACEDOWN)
    {   revealjarl(defender, TRUE);
    }
    if (hero[attackhero].attacking)
    {   for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
        {   if (hero[attackhero].attacktype[whichattack] == -1)
            {   hero[attackhero].attacktype[whichattack] = defendtype;
                hero[attackhero].attacked[whichattack]   = defender;
                break;
    }   }   }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].attacking)
        {   for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
            {   if (jarl[whichjarl].attacktype[whichattack] == -1)
                {   jarl[whichjarl].attacktype[whichattack] = defendtype;
                    jarl[whichjarl].attacked[whichattack]   = defender;
                    break;
    }   }   }   }

    DISCARD saywho(HERO, attackhero, FALSE, FALSE);
    strcat(saystring, LLL(MSG_ATTACKS, "attacks"));
    DISCARD saywho(defendtype, defender, FALSE, TRUE);
    strcat(saystring, ".");
    say(LOWER, FIRSTHEROCOLOUR + attackhero);
    anykey();

    dobattle(defendtype, defender, attackhero);
}

MODULE FLAG ask_treasure(SLONG countertype, SLONG whichcounter, SLONG whichtreasure)
{   SLONG result;
    UBYTE whichcolour;

    whichcolour = saywho(countertype, whichcounter, TRUE, FALSE);
    switch (whichtreasure)
    {
    case FREYFAXI:
        sprintf
        (   saystring2,
            "%s %s (%ld %s) (%s/%s)?",
            LLL(MSG_RIDE_THE,  "ride the" ),
            treasure[FREYFAXI].name,
            faxirides,
            LLL(MSG_RIDES2,    "rides"    ),
            LLL(MSG_CHAR_YES,  "Y"        ),
            LLL(MSG_CHAR_NO,   "N"        )
        );
    acase HEALINGPOTION:
        sprintf
        (   saystring2,
            "%s %s (%s/%s)?",
            LLL(MSG_DRINK_THE, "drink the"),
            treasure[HEALINGPOTION].name,
            LLL(MSG_CHAR_YES,  "Y"        ),
            LLL(MSG_CHAR_NO,   "N"        )
        );
    acase INVISIBILITYRING:
        sprintf
        (   saystring2,
            "%s %s (%s/%s)?",
            LLL(MSG_WEAR_THE,  "wear the" ),
            treasure[INVISIBILITYRING].name,
            LLL(MSG_CHAR_YES,  "Y"        ),
            LLL(MSG_CHAR_NO,   "N"        )
        );
    acase TELEPORTSCROLL:
        sprintf
        (   saystring2,
            "%s %s (%s/%s)?",
            LLL(MSG_READ_THE,  "read the" ),
            treasure[TELEPORTSCROLL].name,
            LLL(MSG_CHAR_YES,  "Y"        ),
            LLL(MSG_CHAR_NO,   "N"        )
        );
    }
    strcat(saystring, saystring2);
    say(LOWER, whichcolour);

    do
    {   result = getevent(YNKEYBOARD, whichcolour);
    } while (result != onekey[ONEKEY_YES] && result != onekey[ONEKEY_NO]);
    if (result == onekey[ONEKEY_YES])
    {   if (whichtreasure == FREYFAXI)
        {   ridertype = countertype;
            rider = whichcounter;
            get_passengers();
        }
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void get_passengers(void)
{   FLAG  done = FALSE,
          ok   = FALSE;
    SLONG here,
          i,
          passenger,
          player;
    UBYTE whichcolour;

    if (ridertype == HERO)
    {   player = rider;
        here = hero[rider].where;
        select_hero(rider, TRUE);
    } else
    {   // assert(ridertype == JARL);
        player = jarl[rider].hero;
        here = jarl[rider].where;
        select_jarl(rider, TRUE);
    }

    if (ridertype == HERO)
    {   for (i = 0; i <= JARLS; i++)
        {   if (jarl[i].where == here && jarl[i].hero == player && !jarl[i].passenger)
            {   ok = TRUE;
                break;
    }   }   }
    else
    {   if (hero[player].where == here && !hero[player].passenger)
        {   ok = TRUE;
        } else
        {   for (i = 0; i <= JARLS; i++)
            {   if (i != rider && jarl[i].where == here && jarl[i].hero == player && !jarl[i].passenger)
                {   ok = TRUE;
                    break;
    }   }   }   }
    if (!ok)
    {   return;
    }

    whichcolour = saywho(ridertype, rider, TRUE, FALSE);
    sprintf
    (   saystring2,
        "%s?",
        LLL(MSG_SELECT_PASSENGERS, "select passengers")
    );
    strcat(saystring, saystring2);
    say(LOWER, whichcolour);
    hint
    (   (STRPTR) LLL(MSG_SELECT, "Select"),
        (STRPTR) LLL(MSG_FINISH, "Finish")
    );

    while (!done)
    {   passenger = getevent(COUNTER, whichcolour);
        if (passenger == -2 || passenger == -3)
        {   done = TRUE;
        } elif (countertype == HERO)
        {   if (ridertype == JARL && passenger == player && hero[passenger].where == here)
            {   if (hero[passenger].passenger)
                {   hero[passenger].passenger = FALSE;
                    deselect_hero(passenger, TRUE);
                } else
                {   hero[passenger].passenger = TRUE;
                    select_hero(passenger, TRUE);
        }   }   }
        elif (countertype == JARL)
        {   if ((ridertype == HERO || passenger != rider) && jarl[passenger].hero == player && jarl[passenger].where == here)
            {   if (jarl[passenger].passenger)
                {   jarl[passenger].passenger = FALSE;
                    deselect_jarl(passenger, TRUE);
                } else
                {   jarl[passenger].passenger = TRUE;
                    select_jarl(passenger, TRUE);
}   }   }   }   }

EXPORT UBYTE saywho(SLONG countertype, SLONG counter, FLAG comma, FLAG lowercase)
{   UBYTE whichcolour = WHITE;

    if (!lowercase)
    {   saystring[0] = EOS;
    } else
    {   strcat(saystring, " ");
    }

    switch (countertype)
    {
    case HERO:
        if (!lowercase)
        {   strcat(saystring, LLL(MSG_HERO, "Hero"));
        } else
        {   strcat(saystring, LLL(MSG_HERO2, "hero"));
        }
        strcat(saystring, " ");
        strcat(saystring, hero[counter].name);
        whichcolour = FIRSTHEROCOLOUR + counter;
    acase JARL:
        if (jarl[counter].hero != -1)
        {   if (!lowercase)
            {   strcat(saystring, LLL(MSG_HERO, "Hero"));
            } else
            {   strcat(saystring, LLL(MSG_HERO2, "hero"));
            }
            strcat(saystring, " ");
            strcat(saystring, hero[jarl[counter].hero].name);
            strcat(saystring, LLL(MSG_S_JARL, "'s jarl"));
            whichcolour = FIRSTHEROCOLOUR + jarl[counter].hero;
        } else
        {   if (!lowercase)
            {   strcat(saystring, LLL(MSG_JARL, "Jarl"));
            } else
            {   strcat(saystring, LLL(MSG_JARL2, "jarl"));
        }   }
        strcat(saystring, " ");
        strcat(saystring, jarl[counter].name);
    acase MONSTER:
        strcat(saystring, monstertypes[monster[counter].species]);
        strcat(saystring, " ");
        strcat(saystring, monster[counter].name);
    acase KINGDOM:
        if (world[counter].hero != -1)
        {   if (!lowercase)
            {   strcat(saystring, LLL(MSG_HERO, "Hero"));
            } else
            {   strcat(saystring, LLL(MSG_HERO2, "hero"));
            }
            strcat(saystring, " ");
            strcat(saystring, hero[world[counter].hero].name);
            strcat(saystring, LLL(MSG_S_KINGDOM, "'s kingdom"));
        } else
        {   if (!lowercase)
            {   strcat(saystring, LLL(MSG_KINGDOM, "Kingdom"));
            } else
            {   strcat(saystring, LLL(MSG_KINGDOM2, "kingdom"));
        }   }
        strcat(saystring, " ");
        strcat(saystring, world[counter].name);
        strcat(saystring, " (");
        stcl_d(numberstring, world[counter].tax);
        strcat(saystring, numberstring);
        strcat(saystring, ")");
    }

    if (!lowercase)
    {   if (comma)
        {   strcat(saystring, ",");
        }
        strcat(saystring, " ");
    }

    return whichcolour;
}

MODULE FLAG attackersleft(void)
{   SLONG whichhero, whichjarl;

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if (hero[whichhero].attacking)
        {   return TRUE;
    }   }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].attacking)
        {   return TRUE;
    }   }
    return FALSE;
}

MODULE SLONG getattackers(SLONG whichhero, SLONG whichcountry, FLAG real)
{   SLONG whichjarl,
          totalstrength = 0;
    FLAG  ok            = FALSE;

    if
    (   hero[whichhero].alive
     && !hero[whichhero].routed
     && hero[whichhero].where == whichcountry
    )
    {   if (real)
        {   hero[whichhero].attacking = TRUE;
            select_hero(whichhero, FALSE);
        }
        ok = TRUE;
        totalstrength += hero[whichhero].strength;
    }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if
        (   jarl[whichjarl].alive
         && jarl[whichjarl].hero == whichhero
         && !jarl[whichjarl].routed
         && jarl[whichjarl].where == whichcountry
        )
        {   if (real)
            {   jarl[whichjarl].attacking = TRUE;
                select_jarl(whichjarl, FALSE);
            }
            ok = TRUE;
            totalstrength += jarl[whichjarl].strength;
    }   }
    if (ok && real)
    {   updatescreen();
    }
    return totalstrength;
}

EXPORT void phase1(void)
{   SLONG besthero = -1,
          glory,
          whichattack,
          whichhero,
          whichjarl,
          whichmonster,
          whichorder;
    FLAG  done;

   /* "1. MOVEMENT. All heroes and jarls move. The hero with the most
        glory and his or her jarls move first. In cases of ties the heroes
        roll dice to see who goes first, with the highest roll going
        first.

        A counter may move as many areas as its movement factor. Each area
        is defined by colour or, in the case of sea areas, by dividing
        lines. Counters may move and remain in sea areas just as if they
        were on land. There is no difference between land movement and sea
        movement." */

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   hero[whichhero].moved  =
        hero[whichhero].hagall =
        hero[whichhero].routed = FALSE;
        for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
        {   hero[whichhero].attacked[whichattack]   = -1;
            hero[whichhero].attacktype[whichattack] = -1;
    }   }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   jarl[whichjarl].hagall =
        jarl[whichjarl].routed = FALSE;
        for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
        {   jarl[whichjarl].attacked[whichattack]   = -1;
            jarl[whichjarl].attacktype[whichattack] = -1;
    }   }
    for (whichmonster = 0; whichmonster <= monsters; whichmonster++)
    {   monster[whichmonster].hagall = FALSE;
    }

    for (whichorder = 0; whichorder <= HEROES; whichorder++)
    {   glory = -1;
        done = TRUE;
        for (whichhero = 0; whichhero <= HEROES; whichhero++)
        {   if (hero[whichhero].alive && !hero[whichhero].moved)
            {   done = FALSE;
                if
                (   hero[whichhero].glory > glory
                 || (hero[whichhero].glory == glory && !(goodrand() % 2))
                )
                {   besthero = whichhero;
                    glory    = hero[whichhero].glory;
        }   }   }
        if (done)
        {   order[whichorder] = -1;
        } else
        {   order[whichorder] = besthero;
            hero[besthero].moved = TRUE;
    }   }

    for (whichorder = 0; whichorder <= HEROES; whichorder++)
    {   if (order[whichorder] == -1)
        {   break;
        } else
        {   border(order[whichorder]);
            move(order[whichorder]);
    }   }

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   hero[whichhero].sea       = NORMAL;
        hero[whichhero].loseturn  = FALSE;
    }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   jarl[whichjarl].sea       = NORMAL;
        jarl[whichjarl].loseturn  = FALSE;
    }
    for (whichmonster = 0; whichmonster <= monsters; whichmonster++)
    {   monster[whichmonster].sea = NORMAL;
}   }

EXPORT void phase2(void)
{   SLONG whichorder;

    /* "2. COMBAT AND JARLS. Combat occurs in the same sequence as
        movement; jarls are recruited after combat.

        Heroes *must* attack at least one monster (if there is a monster)
        in the area they are in during the combat portion of the turn. If
        there is more than one monster they may choose which one they wish
        to fight. They may attack more than one monster in an area." */

    for (whichorder = 0; whichorder <= HEROES; whichorder++)
    {   if (order[whichorder] == -1)
        {   break;
        } else
        {   border(order[whichorder]);
            attack(order[whichorder]);
}   }   }

EXPORT void phase3(void)
{   FLAG  ok;
    SBYTE whichhero, whichcountry, whichjarl;

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if (hero[whichhero].control != NONE && !(hero[whichhero].verydead))
        /* Note that we even do this for dead heroes: they can keep their
           kingdoms (for now) where they have jarls, as they may be
           promoting a jarl, in which case they are allowed to keep their
           kingdoms. */
        {   for (whichcountry = 0; whichcountry <= 35; whichcountry++)
            {   if (world[whichcountry].hero == whichhero)
                {   // determine whether the hero or one of his jarls is there

                    if (!world[whichcountry].is)
                    {   if
                        (   (   (treasure[MAGICCROWN].possessortype == HERO && treasure[MAGICCROWN].possessor            == whichhero)
                             || (treasure[MAGICCROWN].possessortype == JARL && jarl[treasure[MAGICCROWN].possessor].hero == whichhero)
                            )
                         && d6() >= 4
                        )
                        {   ok = TRUE;
                        } else
                        {   ok = FALSE;
                        }

                        if (hero[whichhero].where == whichcountry)
                        {   ok = TRUE;
                            hero[whichhero].wealth += world[whichcountry].tax;
                            if (hero[whichhero].rune == GEOFU)
                            {   hero[whichhero].wealth++;
                        }   }
                        else
                        {   for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                            {   if
                                (   jarl[whichjarl].alive
                                 && jarl[whichjarl].hero == whichhero
                                 && jarl[whichjarl].where == whichcountry
                                ) // taxes are given to the first friendly jarl found
                                {   ok = TRUE;
                                    jarl[whichjarl].wealth += world[whichcountry].tax;
                                    if (hero[whichhero].rune == GEOFU)
                                    {   jarl[whichjarl].wealth++;
                                    }
                                    break;
                        }   }   }

                        if (!ok)
                        {   DISCARD saywho(KINGDOM, whichcountry, FALSE, FALSE); // order-dependent
                            strcat(saystring, LLL(MSG_HAS_BEEN_OVERRUN, "has been overrun"));
                            strcat(saystring, ".");
                            say(LOWER, FIRSTHEROCOLOUR + whichhero);
                            world[whichcountry].hero = -1;
                            darken();
                            border(whichhero);
                            anykey();
}   }   }   }   }   }   }

MODULE SLONG odin_tyr(SLONG whichhero, FLAG attacking)
{   SLONG whichjarl, whichprayer;
    SLONG adjustment;

    if (hero[whichhero].god == ODIN)
    {   hero[whichhero].god = -1;
        whichprayer = d6();

        if (whichprayer == 1)
        {   adjustment = -3;

            sprintf
            (   saystring,
                "Odin %s %s%s.",
                LLL(MSG_AIDS_HERO,                   "aids hero"),
                hero[whichhero].name,
                LLL(MSG_S_E_B_A_3_T_T_S,             "'s enemy by adding 3 to their strength")
            );
        } elif (whichprayer == 2)
        {   adjustment = -1;

            sprintf
            (   saystring,
                "Odin %s %s%s.",
                LLL(MSG_SENDS_A_WOLF_TO_AID_HERO,    "sends a wolf to aid hero"),
                hero[whichhero].name,
                LLL(MSG_S_ENEMY,                     "'s enemy")
            );
        } elif (whichprayer == 3)
        {   adjustment = 0;

            sprintf
            (   saystring,
                "Odin%s.",
                LLL(MSG_S_R_A_S_B_H_T_O_T_B,         "'s ravens are sent by him to observe the battle")
            );
        } elif (whichprayer == 4)
        {   adjustment = 1;

            sprintf
            (   saystring,
                "Odin %s %s.",
                LLL(MSG_SENDS_A_WOLF_TO_AID_HERO,    "sends a wolf to aid hero"),
                hero[whichhero].name
            );
        } elif (whichprayer == 5)
        {   adjustment = 3;

            sprintf
            (   saystring,
                "Odin %s %s %s.",
                LLL(MSG_AIDS_HERO,                   "aids hero"),
                hero[whichhero].name,
                LLL(MSG_BY_ADDING_3_TO_HIS_STRENGTH, "by adding 3 to his strength")
            );
        } else
        {   // assert(whichprayer == 6);

            adjustment = 5;
            hero[whichhero].glory += 3;

            sprintf
            (   saystring,
                "Odin %s!",
                LLL(MSG_INTERVENES_PERSONALLY,       "intervenes personally")
            );
        }
        say(LOWER, FIRSTHEROCOLOUR + whichhero);
        anykey();
    } elif (hero[whichhero].god == TYR)
    {   hero[whichhero].god = -1;
        whichprayer = d6();

        if (whichprayer == 1)
        {   adjustment = -1;

            sprintf
            (   saystring,
                "Tyr %s %s%s.",
                LLL(MSG_AIDS_HERO,                   "aids hero"),
                hero[whichhero].name,
                LLL(MSG_S_E_B_A_1_T_T_S,             "'s enemy by adding 1 to their strength")
            );
        } elif (whichprayer == 2 || whichprayer == 3)
        {   adjustment = 0;

            sprintf
            (   saystring,
                "Tyr %s.",
                LLL(MSG_D_T_T_F_I_B_F,               "decides that the fight is balanced fairly")
            );
        } elif (whichprayer == 4)
        {   adjustment = 1;

            sprintf
            (   saystring,
                "Tyr %s %s %s.",
                LLL(MSG_AIDS_HERO,                   "aids hero"),
                hero[whichhero].name,
                LLL(MSG_BY_ADDING_1_TO_HIS_STRENGTH, "by adding 1 to his strength")
            );
        } elif (whichprayer == 5)
        {   adjustment = 2;

            sprintf
            (   saystring,
                "Tyr %s %s %s.",
                LLL(MSG_AIDS_HERO,                   "aids hero"),
                hero[whichhero].name,
                LLL(MSG_BY_ADDING_2_TO_HIS_STRENGTH, "by adding 2 to his strength")
            );
        } else
        {   // assert(whichprayer == 6);

            adjustment = 1; // for the hero himself
            if (attacking)
            {   for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                {   if (jarl[whichjarl].attacking)
                    {   adjustment++;
            }   }   }
            else
            {   for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
                {   if (jarl[whichjarl].defending)
                    {   adjustment++;
            }   }   }

            sprintf
            (   saystring,
                "Tyr %s %s %s.",
                LLL(MSG_AIDS_HERO,                   "aids hero"),
                hero[whichhero].name,
                LLL(MSG_B_A_1_T_T_S_O_E_P_O_H_S,     "by adding 1 to the strength of each person on his side")
            );
        }
        say(LOWER, FIRSTHEROCOLOUR + whichhero);
        anykey();
    } else
    {   adjustment = 0;
    }
    return adjustment;
}

MODULE void pray(SLONG whichhero)
{   SLONG decision;

    decision = d6();
    if (decision == 1 || (hero[whichhero].rune == AMSIR && decision == 2))
    {   gods(whichhero);
}   }

MODULE void gods(SLONG whichhero)
{   SLONG whichgod, whichprayer, decision;
    FLAG  heard = FALSE;

    whichgod    = goodrand() % 6;
    whichprayer = d6();

    switch (whichgod)
    {
    case FREY:
        strcpy(saystring, "Frey ");
        if (whichprayer <= 4)
        {   // assert(whichprayer >= 1);
            hero[whichhero].maidens++;

            strcat(saystring, LLL(MSG_W_S_A_M_T_H_H, "will send a maiden to heal hero"));
            strcat(saystring, " ");
            strcat(saystring, hero[whichhero].name);
            strcat(saystring, LLL(MSG_S_NEXT_WOUND, "'s next wound"));
            strcat(saystring, ".");
        } else
        {   // assert(whichprayer == 5 || whichprayer == 6);
            hero[whichhero].maidens += 2;

            strcat(saystring, LLL(MSG_W_S_A_M_T_H_H, "will send a maiden to heal hero"));
            strcat(saystring, " ");
            strcat(saystring, hero[whichhero].name);
            strcat(saystring, LLL(MSG_S_NEXT_TWO_WOUNDS, "'s next two wounds"));
            strcat(saystring, ".");
        }
    acase LOKI:
        strcpy(saystring, "Loki ");
        if (whichprayer <= 3)
        {   // assert(whichprayer >= 0);

            hero[whichhero].luck--;
            if (hero[whichhero].luck < 0)
            {   hero[whichhero].luck = 0;
            }

            strcat(saystring, LLL(MSG_S_A_P_O_L_F_H, "steals a point of luck from hero"));
            strcat(saystring, " ");
            strcat(saystring, hero[whichhero].name);
            strcat(saystring, ".");
        } else
        {   // assert(whichprayer >= 4 && whichprayer <= 6);

            hero[whichhero].luck++;

            strcat(saystring, LLL(MSG_GRANTS_HERO, "grants hero"));
            strcat(saystring, " ");
            strcat(saystring, hero[whichhero].name);
            strcat(saystring, " ");
            strcat(saystring, LLL(MSG_A_P_O_L_F_H_D, "a point of luck for his daring"));
            strcat(saystring, ".");
        }
    acase NJORD:
        if (whichprayer == 1 || whichprayer == 2)
        {   hero[whichhero].sea = GOOD;

            sprintf
            (   saystring,
                "Njord %s %s %s.",
                LLL(MSG_AIDS_HERO, "aids hero"),
                hero[whichhero].name,
                LLL(MSG_TO_MOVE_BY_SEA_NEXT_TURN, "to move by sea next turn")
            );
        } elif (whichprayer == 3 || whichprayer == 4)
        {   decision = d6();
            hero[whichhero].wealth += decision;

            sprintf
            (   saystring,
                "Njord %s %ld %s %s %s.",
                LLL(MSG_GIVES, "gives"),
                decision,
                LLL(MSG_GOLDEN_MARKS_TO_HERO, "golden marks to hero"),
                hero[whichhero].name,
                LLL(MSG_AS_A_GIFT, "as a gift")
            );
        } elif (whichprayer == 5)
        {   decision = d6();
            if (decision > hero[whichhero].wealth)
            {   decision = hero[whichhero].wealth;
            }
            hero[whichhero].wealth -= decision;

            sprintf
            (   saystring,
                "Njord %s %ld %s %s %s.",
                LLL(MSG_TAKES, "takes"),
                decision,
                LLL(MSG_GOLDEN_MARKS_FROM_HERO, "golden marks from hero"),
                hero[whichhero].name,
                LLL(MSG_AS_DUE_TRIBUTE, "as due tribute")
            );
        } else
        {   // assert(whichprayer == 6);
            hero[whichhero].sea = BAD;

            sprintf
            (   saystring,
                "Njord %s %s %s.",
                LLL(MSG_PREVENTS_HERO, "prevents hero"),
                hero[whichhero].name,
                LLL(MSG_F_T_B_S_N_T, "from travelling by sea next turn")
            );
        }
    acase ODIN:
        hero[whichhero].god = ODIN;
        heard = TRUE;
        strcpy(saystring, "Odin ");
    acase THOR:
        hero[whichhero].god = THOR;
        heard = TRUE;
        strcpy(saystring, "Thor ");
    acase TYR:
        hero[whichhero].god = TYR;
        heard = TRUE;
        strcpy(saystring, "Tyr ");
    }
    if (heard)
    {   strcat(saystring, LLL(MSG_HEARD_THE_PRAYER_OF_HERO, "heard the prayer of hero"));
        strcat(saystring, " ");
        strcat(saystring, hero[whichhero].name);
        strcat(saystring, ".");
    }

    say(LOWER, FIRSTHEROCOLOUR + whichhero);
    anykey();
}

MODULE void conquer(SLONG conquerortype, SLONG conqueror, SLONG conquerorhero, SLONG whichcountry)
{   /* This is order-dependent. We should say the message first before
    adjusting the world[] structure, otherwise we will get eg. "Hero
    Ragnar has conquered hero Ragnar's kingdom Upland (3).". */

    DISCARD saywho(conquerortype, conqueror, FALSE, FALSE);
    strcat(saystring, LLL(MSG_HAS_CONQUERED_KINGDOM, "has conquered"));
    DISCARD saywho(KINGDOM, whichcountry, FALSE, TRUE);
    strcat(saystring, ".");

    world[whichcountry].hero = conquerorhero;
    darken();

    say(LOWER, FIRSTHEROCOLOUR + conquerorhero);
    anykey();
}

MODULE void findtreasure(SLONG victortype, SLONG victor, SLONG victorhero, SLONG whichmonster)
{   SLONG whichtreasure;

    for (whichtreasure = 0; whichtreasure <= treasures; whichtreasure++)
    {   if
        (   treasure[whichtreasure].possessortype == MONSTER
         && treasure[whichtreasure].possessor     == whichmonster
        )
        {   // give the treasure to the victor
            treasure[whichtreasure].possessortype = victortype;
            treasure[whichtreasure].possessor     = victor;
            treasure[whichtreasure].where         = -1;

            DISCARD saywho(victortype, victor, FALSE, FALSE);
            sprintf
            (   saystring2,
                "%s %s!",
                LLL(MSG_FINDS_THE, "finds the"),
                treasure[whichtreasure].name
            );
            strcat(saystring, saystring2);
            say(LOWER, FIRSTHEROCOLOUR + victorhero);
            anykey();
    }   }

    if (monster[whichmonster].wealth > 0)
    {   hero[victorhero].wealth += monster[whichmonster].wealth;

        DISCARD saywho(victortype, victor, FALSE, FALSE);
        sprintf
        (   saystring2,
            "%s %ld %s.",
            LLL(MSG_FINDS, "finds"),
            monster[whichmonster].wealth,
            LLL(MSG_GOLDEN_MARKS, "golden marks")
        );
        strcat(saystring, saystring2);

        monster[whichmonster].wealth = 0;

        say(LOWER, FIRSTHEROCOLOUR + victorhero);
        anykey();
}   }

MODULE void drop(SLONG droppertype, SLONG dropper, SLONG whichcountry)
{   SLONG whichsord, whichtreasure;

    for (whichtreasure = 0; whichtreasure <= treasures; whichtreasure++)
    {   if
        (   treasure[whichtreasure].possessortype == droppertype
         && treasure[whichtreasure].possessor     == dropper
        )
        {   // drop the treasure
            treasure[whichtreasure].possessortype = KINGDOM;
            treasure[whichtreasure].possessor     = -1;
            treasure[whichtreasure].where         = whichcountry;
            move_treasure(whichtreasure, TRUE);
    }   }
    for (whichsord = 0; whichsord <= SORDS; whichsord++)
    {   if
        (   sord[whichsord].possessortype == droppertype
         && sord[whichsord].possessor     == dropper
        )
        {   // drop the sword
            sord[whichsord].possessortype = KINGDOM;
            sord[whichsord].possessor     = -1;
            sord[whichsord].where         = whichcountry;
            move_sord(whichsord, TRUE);
}   }   }

MODULE FLAG islegal(SLONG movertype, SLONG mover, SLONG whichcountry, FLAG human)
{   UBYTE whichcolour;

    // assert(whichcountry != -1);

    if
    (   (   (movertype == HERO    && hero[mover].sea    == BAD)
         || (movertype == JARL    && jarl[mover].sea    == BAD)
         || (movertype == MONSTER && monster[mover].sea == BAD)
        )
     && (   world[whichcountry].type == SEA
         || world[whichcountry].type == ISLE
    )   )
    {   if (human)
        {   whichcolour = saywho(movertype, mover, FALSE, FALSE);
            strcat(saystring, LLL(MSG_M_N_T_B_S_T_T, "may not travel by sea this turn"));
            strcat(saystring, ".");
            say(LOWER, whichcolour);
            anykey();
        }
        return FALSE;
    } elif
    (   movertype                  == MONSTER
     && (   monster[mover].species == SERPENT
         || monster[mover].species == KRAKEN
        )
     && world[whichcountry].type == LAND
    )
    {   return FALSE;
    } else return TRUE;
}

MODULE FLAG checkfree(SLONG whichhero, FLAG* freemove)
{   if (hero[whichhero].sea == GOOD)
    {   if (!(*(freemove)))
        {   if
            (   world[hero[whichhero].where].type == SEA
             || world[hero[whichhero].where].type == ISLE
            )
            {   *(freemove) = TRUE;
        }   }
        else
        {   if
            (   world[hero[whichhero].where].type == LAND
            )
            {   *(freemove) = FALSE;
            } else
            {   return TRUE;
    }   }   }
    return FALSE;
}

MODULE FLAG needitem(SLONG countertype, SLONG counter, SLONG whichcountry)
{   FLAG  needed = TRUE;
    SLONG which;

    for (which = 0; which <= SORDS; which++)
    {   if
        (   sord[which].possessortype == countertype
         && sord[which].possessor     == counter
        )
        {   needed = FALSE;
            break;
    }   }
    if (needed)
    {   for (which = 0; which <= SORDS; which++)
        {   if
            (   sord[which].possessortype == -1
             && sord[which].where         == whichcountry
            )
            {   return TRUE;
    }   }   }

    for (which = 0; which <= treasures; which++)
    {   if
        (   treasure[which].possessortype == -1
         && treasure[which].where         == whichcountry
        )
        {   return TRUE;
    }   }

    return FALSE;
}

EXPORT SLONG getstrength(SLONG countertype, SLONG counter, FLAG defending)
{   SLONG strength = 0, // to avoid spurious compiler warnings,
          which;

    if (countertype == HERO)
    {   strength = hero[counter].strength;
    } elif (countertype == JARL)
    {   strength = jarl[counter].strength;
    } elif (countertype == MONSTER)
    {   strength = monster[counter].strength;
    } else // assert(0);

    for (which = 0; which <= SORDS; which++)
    {   if
        (   sord[which].possessortype == countertype
         && sord[which].possessor     == counter
        )
        {   if (which == BALMUNG || which == HRUNTING || which == LOVI)
            {   strength++;
            } else
            {   strength += 2;
            }
            break; // for speed
    }   }

    if (countertype != MONSTER && defending)
    {   for (which = 0; which <= treasures; which++)
        {   if
            (   treasure[which].possessortype == countertype
             && treasure[which].possessor     == counter
            )
            {   if (which == MAGICSHIRT)
                {   strength++;
                } elif (which == MAILCOAT)
                {   strength += 2;
    }   }   }   }

    if (countertype == HERO && hero[counter].rune == OGAL)
    {   strength++;
    }

    if
    (   (countertype == HERO    &&    hero[counter].hagall)
     || (countertype == JARL    &&    jarl[counter].hagall)
     || (countertype == MONSTER && monster[counter].hagall)
    )
    {   strength--;
    }

    return strength;
}
EXPORT SLONG getusualmoves(SLONG countertype, SLONG whichcounter)
{   SLONG moves = 0, // to avoid spurious compiler warnings
          which;

    if (countertype == HERO)
    {   moves = hero[whichcounter].moves;
    } elif (countertype == JARL)
    {   moves = jarl[whichcounter].moves;
    } elif (countertype == MONSTER)
    {   moves = monster[whichcounter].moves;
    } else // assert(0);

    if (countertype == HERO && hero[whichcounter].rune == EON)
    {   moves++;
    }

    if (countertype != MONSTER)
    {   for (which = 0; which <= treasures; which++)
        {   if
            (   treasure[which].possessortype == countertype
             && treasure[which].possessor     == whichcounter
            )
            {   if (which == MAGICSHIRT)
                {   moves++;
                    break;
    }   }   }   }

    return moves;
}

MODULE FLAG autosense(SLONG player)
{   SLONG whichcountry, i;
    FLAG  can = FALSE;

    /* For each country,
           For each possible defender in that country,
               Check for possible attackers.

       Possible optimization: as soon as we find any possible
       attacker-defender combination we can return TRUE immediately,
       as we normally only need to ascertain whether an attack is
       possible, not list every possible attacker-defender
       combination. */

    for (whichcountry = 0; whichcountry <= 65; whichcountry++)
    {   // check for possible attacks against this kingdom
        if
        (   world[whichcountry].hero != player
         && world[whichcountry].tax
         && !world[whichcountry].is
        )
        {   if (findattackers(player, whichcountry, KINGDOM, whichcountry))
            {   can = TRUE;

#ifdef EXTRAVERBOSE
                Printf("Player %s can attack kingdom %s.\n", hero[player].name, world[whichcountry].name);
#endif

        }   }

        // check for possible attacks against monsters
        for (i = 0; i <= monsters; i++)
        {   if
            (   monster[i].alive
             && monster[i].where == whichcountry
            )
            {   if (findattackers(player, whichcountry, MONSTER, i))
                {   can = TRUE;

#ifdef EXTRAVERBOSE
                    Printf("Player %s can attack %s %s.\n", hero[player].name, monstertypes[monster[i].species], monster[i].name);
#endif

        }   }   }

        // check for possible attacks against heroes
        for (i = 0; i <= HEROES; i++)
        {   if
            (   player != i
             && hero[i].alive
             && hero[i].where == whichcountry
            )
            {   if (findattackers(player, whichcountry, HERO, i))
                {   can = TRUE;

#ifdef EXTRAVERBOSE
                    Printf("Player %s can attack hero %s.\n", hero[player].name, hero[i].name);
#endif

        }   }   }

        // check for possible attacks against jarls
        for (i = 0; i <= JARLS; i++)
        {   if
            (   jarl[i].alive
             && jarl[i].where == whichcountry
             && jarl[i].hero != player
            )
            {   if (findattackers(player, whichcountry, JARL, i))
                {   can = TRUE;

#ifdef EXTRAVERBOSE
                    Printf("Player %s can attack jarl %s.\n", hero[player].name, jarl[i].name);
#endif

    }   }   }   }

#ifdef EXTRAVERBOSE
    if (!can)
    {   Printf("No possible attacks for player %s.\n", hero[player].name);
    }
#endif

    return can;
}

MODULE FLAG findattackers(SLONG player, SLONG whichcountry, SLONG victimtype, SLONG victim)
{   FLAG  can = FALSE;
    SLONG whichattack, whichjarl;

    // Possible optimization: as soon as we find any possible
    // attacker we can return TRUE immediately, as we normally
    // only need to ascertain whether an attack is possible, not
    // list every possible attacker.

    if
    (   hero[player].alive
     && hero[player].where == whichcountry
     && !hero[player].routed
    )
    {   can = TRUE;

        for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
        {   if
            (   hero[player].attacktype[whichattack] == victimtype
             && hero[player].attacked[whichattack]   == victim
            )
            {   can = FALSE;

#ifdef EXTRAVERBOSE
                Printf("Hero %s has already fought victim %ld (type %ld).\n", hero[player].name, victim, victimtype);
#endif

                break; // for speed
        }   }

#ifdef EXTRAVERBOSE
        if (can)
        {   Printf("Hero %s has not yet fought victim %ld (type %ld).\n", hero[player].name, victim, victimtype);
        }
#endif

    }

    // the hero can't fight this enemy, so let's see if a jarl can
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if
        (   jarl[whichjarl].alive
         && jarl[whichjarl].hero == player
         && jarl[whichjarl].where == whichcountry
         && !jarl[whichjarl].routed
        )
        {   can = TRUE;

            for (whichattack = 0; whichattack <= ATTACKS; whichattack++)
            {   if
                (   jarl[whichjarl].attacktype[whichattack] == victimtype
                 && jarl[whichjarl].attacked[whichattack]   == victim
                )
                {   can = FALSE;

#ifdef EXTRAVERBOSE
                    Printf("Hero %s's jarl %s has already fought victim %ld (type %ld).\n", hero[player].name, jarl[whichjarl].name, victim, victimtype);
#endif

                    break; // for speed
            }   }

#ifdef EXTRAVERBOSE
            if (can)
            {   Printf("Hero %s's jarl %s has not yet fought victim %ld (type %ld).\n", hero[player].name, jarl[whichjarl].name, victim, victimtype);
            }
#endif

    }   }

    return can;
}

MODULE void deselect_combatants(SLONG attackhero, SLONG defendtype, SLONG defendhero, SLONG defender)
{   SLONG whichjarl;

    if (hero[attackhero].attacking)
    {   deselect_hero(attackhero, FALSE);
        hero[attackhero].attacking = FALSE;
    }
    if (defendhero != 1 && hero[defendhero].defending)
    {   deselect_hero(defendhero, FALSE);
        hero[defendhero].defending = FALSE;
    }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].attacking)
        {   deselect_jarl(whichjarl, FALSE);
            jarl[whichjarl].attacking   =
            jarl[whichjarl].recruitable = FALSE;
        } elif (jarl[whichjarl].defending)
        {   deselect_jarl(whichjarl, FALSE);
            jarl[whichjarl].defending   =
            jarl[whichjarl].recruitable = FALSE;
    }   }
    if (defendtype == MONSTER)
    {   deselect_monster(defender, FALSE);
    }
    updatescreen();
}

MODULE SLONG assess_hero(SLONG whichhero, SLONG whichcountry)
{   SLONG good = 0,
          strength,
          whichjarl,
          whichmonster,
          whichrivalhero;
    FLAG  ok;

    if (whichcountry == -1)
    {   return -100;
    }

    strength = getstrength(HERO, whichhero, TRUE);

    if (needitem(HERO, whichhero, whichcountry))
    {   good += 9; // gettable sword and/or treasure
    }

    if (countjarls(whichhero) < 4)
    {   for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if
            (   jarl[whichjarl].alive
             && jarl[whichjarl].hero  == -1
             && jarl[whichjarl].where == whichcountry
             && jarl[whichjarl].face  == FACEDOWN
             && hero[whichhero].luck  >= 1
            )
            {   good += 6; // recruitable jarl
    }   }   }

    for (whichrivalhero = 0; whichrivalhero <= HEROES; whichrivalhero++)
    {   if
        (   whichhero != whichrivalhero
         && hero[whichrivalhero].alive
         && hero[whichrivalhero].where == whichcountry
        )
        {   if (strength > checkdefenders_hero(whichrivalhero, whichcountry) + hero[whichrivalhero].luck)
            {   good += 5; // weak enemy hero
            } else
            {   good -= checkdefenders_hero(whichrivalhero, whichcountry); // strong enemy hero
    }   }   }

    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].alive)
        {   if
            (    jarl[whichjarl].face == FACEUP
             &&  jarl[whichjarl].hero != whichhero
             && (jarl[whichjarl].hero == -1 || hero[jarl[whichjarl].hero].where != whichcountry)
             &&  jarl[whichjarl].where == whichcountry
            )
            {   if (strength > checkdefenders_jarl(whichjarl, whichcountry) + 1)
                {   good += 3; // weak enemy jarl
                } else
                {   good -= checkdefenders_jarl(whichjarl, whichcountry); // strong enemy jarl
            }   }
            elif (jarl[whichjarl].hero == whichhero)
            {   good += getstrength(JARL, whichjarl, TRUE); // encourage hero to stay with friendly jarls
    }   }   }

    for (whichmonster = 0; whichmonster <= monsters; whichmonster++)
    {   if
        (   monster[whichmonster].alive
         && monster[whichmonster].where == whichcountry
        )
        {   if (strength > monster[whichmonster].strength + 1)
            {   good += 4; // weak monster
            } else
            {   good -= monster[whichmonster].strength; // strong monster
    }   }   }

    if (whichcountry <= 35 && !world[whichcountry].is)
    {   if
        (   world[whichcountry].hero != whichhero
         && strength > world[whichcountry].tax + 2
        )
        {   good += 3; // weak kingdom
        } /* strong kingdom can't attack us, and we won't attack it, so no problem */

        if (world[whichcountry].hero == whichhero)
        {   // see whether we have any jarls here to run the kingdom for us
            ok = FALSE;
            for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
            {   if
                (   jarl[whichjarl].alive
                 && jarl[whichjarl].hero  == whichhero
                 && jarl[whichjarl].where == whichcountry
                )
                {   ok = TRUE;
                    break; // for speed
            }   }
            if (!ok)
            {   good += world[whichcountry].tax; // encourage the hero to run his kingdom
    }   }   }

    good += (goodrand() % 4);
    return good;
}

MODULE SLONG assess_jarl(SLONG whichjarl, SLONG whichcountry)
{   SLONG good = 0,
          strength,
          whichhero,
          whichmonster,
          whichrivalhero,
          whichrivaljarl;
    FLAG  ok;

    if (whichcountry == -1)
    {   return -100;
    }

    whichhero = jarl[whichjarl].hero;
    strength = getstrength(JARL, whichjarl, TRUE);

    if (needitem(JARL, whichjarl, whichcountry))
    {   good += 9; // gettable sword and/or treasure
    }

    for (whichrivalhero = 0; whichrivalhero <= HEROES; whichrivalhero++)
    {   if
        (   hero[whichrivalhero].alive
         && hero[whichrivalhero].where == whichcountry
        )
        {   if (whichhero == whichrivalhero)
            {   good += getstrength(HERO, whichhero, TRUE); // encourage jarl to stay with friendly hero
            } else
            {   if (strength > checkdefenders_hero(whichrivalhero, whichcountry) + hero[whichrivalhero].luck)
                {   good += 5; // weak enemy hero
                } else
                {   good -= checkdefenders_hero(whichrivalhero, whichcountry); // strong enemy hero
    }   }   }   }

    for (whichrivaljarl = 0; whichrivaljarl <= JARLS; whichrivaljarl++)
    {   if (whichrivaljarl != whichjarl && jarl[whichrivaljarl].alive)
        {   if
            (    jarl[whichrivaljarl].face == FACEUP
             &&  jarl[whichrivaljarl].hero != whichhero
             && (jarl[whichrivaljarl].hero == -1 || hero[jarl[whichrivaljarl].hero].where != whichcountry)
             &&  jarl[whichrivaljarl].where == whichcountry
            )
            {   if (strength > checkdefenders_jarl(whichrivaljarl, whichcountry) + 1)
                {   good += 3; // weak enemy jarl
                } else
                {   good -= checkdefenders_jarl(whichrivaljarl, whichcountry); // strong enemy jarl
            }   }
            elif (jarl[whichrivaljarl].hero == whichhero)
            {   good += getstrength(JARL, whichrivaljarl, TRUE); // encourage jarl to stay with friendly jarls
    }   }   }

    for (whichmonster = 0; whichmonster <= monsters; whichmonster++)
    {   if
        (   monster[whichmonster].alive
         && monster[whichmonster].where == whichcountry
        )
        {   if (strength > monster[whichmonster].strength + 1)
            {   good += 4; // weak monster
            } else
            {   good -= monster[whichmonster].strength; // strong monster
    }   }   }

    if (whichcountry <= 35 && !world[whichcountry].is)
    {   if
        (   world[whichcountry].hero != whichhero
         && strength > world[whichcountry].tax + 2
        )
        {   good += 3; // weak kingdom
        } /* strong kingdom can't attack us, and we won't attack it, so no problem */

        if (world[whichcountry].hero == whichhero)
        {   // see whether we have a hero here to run the kingdom for us
            if (hero[whichhero].where == whichcountry)
            {   ok = TRUE;
            } else
            {   // see whether we have any other jarls here to run the kingdom for us
                ok = FALSE;
                for (whichrivaljarl = 0; whichrivaljarl <= JARLS; whichrivaljarl++)
                // they are actually allies, not rivals, of course, but this is more efficient
                {   if
                    (   whichrivaljarl != whichjarl
                     && jarl[whichrivaljarl].alive
                     && jarl[whichrivaljarl].hero  == whichhero
                     && jarl[whichrivaljarl].where == whichcountry
                    )
                    {   ok = TRUE;
                        break; // for speed
            }   }   }
            if (!ok)
            {   good += world[whichcountry].tax; // encourage the jarl to run his hero's kingdom
    }   }   }

    good += (goodrand() % 4);
    return good;
}

MODULE SLONG countjarls(SLONG whichhero)
{   SLONG jarls = 0,
          whichjarl;

    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].alive && jarl[whichjarl].hero == whichhero)
        {   {   jarls++;
    }   }   }
    return jarls;
}

MODULE void onemove_hero(SLONG whichhero, SLONG whichcountry)
{   SLONG whichjarl;

    unslot_hero(whichhero);
    hero[whichhero].where = whichcountry;

    if (ridertype == HERO)
    {   // assert(rider == whichhero);
        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if (jarl[whichjarl].passenger)
            {   // assert(jarl[whichjarl].hero == whichhero);
                unslot_jarl(whichjarl);
                jarl[whichjarl].where = whichcountry;
    }   }   }

    move_hero(whichhero, FALSE);
    if (ridertype == HERO)
    {   for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if (jarl[whichjarl].passenger)
            {   move_jarl(whichjarl, FALSE);
    }   }   }

    if (watchamiga || hero[whichhero].control == HUMAN)
    {   updatescreen();
    }
    if (watchamiga && hero[whichhero].control == CONTROL_AMIGA)
    {   Delay(25);
    }

    world[hero[whichhero].where].visited = TRUE;
    if (whichrealmove <= 65)
    {   movearray[whichrealmove++] = hero[whichhero].where;
    }
    if (!(checkfree(whichhero, &freemove)))
    {   whichmove++;
}   }
MODULE void onemove_jarl(SLONG whichjarl, SLONG whichcountry)
{   SLONG whichotherjarl;

    unslot_jarl(whichjarl);
    jarl[whichjarl].where = whichcountry;

    if (ridertype == JARL && rider == whichjarl)
    {   if (hero[jarl[whichjarl].hero].passenger)
        {   unslot_hero(jarl[whichjarl].hero);
            hero[jarl[whichjarl].hero].where = whichcountry;
        }
        for (whichotherjarl = 0; whichotherjarl <= JARLS; whichotherjarl++)
        {   if (jarl[whichotherjarl].passenger)
            {   // assert(jarl[whichotherjarl].hero == jarl[whichjarl].hero);
                unslot_jarl(whichotherjarl);
                jarl[whichotherjarl].where = whichcountry;
    }   }   }

    move_jarl(whichjarl, FALSE);
    if (ridertype == JARL && rider == whichjarl)
    {   if (hero[jarl[whichjarl].hero].passenger)
        {   move_hero(jarl[whichjarl].hero, FALSE);
        }
        for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
        {   if (jarl[whichjarl].passenger)
            {   move_jarl(whichjarl, FALSE);
    }   }   }

    if (watchamiga || hero[jarl[whichjarl].hero].control == HUMAN)
    {   updatescreen();
    }
    if (watchamiga && hero[jarl[whichjarl].hero].control == CONTROL_AMIGA)
    {   Delay(25);
    }

    world[jarl[whichjarl].where].visited = TRUE;
    movearray[whichmove++] = jarl[whichjarl].where;
}

MODULE SLONG checkdefenders_hero(SLONG whichhero, SLONG whichcountry)
{   SLONG strength,
          whichjarl;

    strength = getstrength(HERO, whichhero, TRUE);
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if
        (   jarl[whichjarl].hero  == whichhero
         && jarl[whichjarl].where == whichcountry
        )
        {   strength += getstrength(JARL, whichjarl, TRUE);
    }   }

    return strength;
}
MODULE SLONG checkdefenders_jarl(SLONG whichjarl, SLONG whichcountry)
{   SLONG strength,
          whichalliedjarl,
          whichhero;

    strength  = getstrength(JARL, whichjarl, TRUE);
    whichhero = jarl[whichjarl].hero;
    if (whichhero != -1)
    {   if (hero[whichhero].where == whichcountry)
        {   strength += getstrength(HERO, whichhero, TRUE);
        }
        for (whichalliedjarl = 0; whichalliedjarl <= JARLS; whichalliedjarl++)
        {   if
            (   whichjarl != whichalliedjarl
             && jarl[whichalliedjarl].hero  == whichhero
             && jarl[whichalliedjarl].where == whichcountry
            )
            {   strength += getstrength(JARL, whichjarl, TRUE);
    }   }   }

    return strength;
}

MODULE void givegold(SLONG whichhero, SLONG whichjarl)
{   if (jarl[whichjarl].wealth)
    {   DISCARD saywho(JARL, whichjarl, FALSE, FALSE);
        if (hero[whichhero].where == jarl[whichjarl].where)
        {   strcat(saystring, LLL(MSG_GIVES, "gives"));
        } else
        {   strcat(saystring, LLL(MSG_GAVE, "gave"));
        }
        strcat(saystring, " ");
        stcl_d(numberstring, jarl[whichjarl].wealth);
        strcat(saystring, numberstring);
        strcat(saystring, " ");
        strcat(saystring, LLL(MSG_GOLDEN_MARKS_TO_HERO, "golden marks to hero"));
        strcat(saystring, " ");
        strcat(saystring, hero[whichhero].name);
        strcat(saystring, ".");

        hero[whichhero].wealth += jarl[whichjarl].wealth;
        jarl[whichjarl].wealth = 0;

        say(LOWER, FIRSTHEROCOLOUR + whichhero);
        anykey();
}   }

EXPORT int calcscore(int whichhero)
{   int score,
        whichjarl;

    score =  hero[whichhero].glory
          + (hero[whichhero].wealth / 10)
          + (hero[whichhero].luck   /  3);
    if
    (   treasure[BROSUNGNECKLACE].possessortype == HERO
     && treasure[BROSUNGNECKLACE].possessor     == whichhero
    )
    {   score += 2; // because it is worth 20 gp
    }

    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if (jarl[whichjarl].alive && jarl[whichjarl].hero == whichhero)
        {   score += jarl[whichjarl].strength / 2;
            if
            (   treasure[BROSUNGNECKLACE].possessortype == JARL
             && treasure[BROSUNGNECKLACE].possessor     == whichjarl
            )
            {   score += 2; // because it is worth 20 gp
    }   }   }

    return score;
}

MODULE FLAG wear_ring(SLONG possessortype, SLONG possessor, SLONG possessorhero)
{   FLAG escaped = FALSE,
         ring    = FALSE;

    if
    (   treasure[INVISIBILITYRING].possessortype == possessortype
     && treasure[INVISIBILITYRING].possessor == possessor
    )
    {   if (hero[possessorhero].control == CONTROL_AMIGA)
        {   DISCARD saywho(possessortype, possessor, FALSE, FALSE);
            sprintf
            (   saystring2,
                "%s %s.",
                LLL(MSG_WEARS_THE, "wears the"),
                treasure[INVISIBILITYRING].name
            );
            strcat(saystring, saystring2);
            say(LOWER, FIRSTHEROCOLOUR + possessorhero);
            ring = TRUE;
        } elif
        (   hero[possessorhero].control == HUMAN
         && ask_treasure(possessortype, possessor, INVISIBILITYRING)
        )
        {   ring = TRUE;
        }

        if (!ring)
        {   DISCARD saywho(possessortype, possessor, FALSE, FALSE);
            if (d6() >= 4)
            {   strcat(saystring, LLL(MSG_ESCAPES,         "escapes"        ));
                escaped = TRUE;
            } else
            {   strcat(saystring, LLL(MSG_FAILS_TO_ESCAPE, "fails to escape"));
            }
            strcat(saystring, "!");
            say(LOWER, FIRSTHEROCOLOUR + possessorhero);
            anykey();
    }   }

    return escaped;
}

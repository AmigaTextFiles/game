// 1. INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#endif
#ifdef AMIGA
    #include <exec/types.h>
    #include "amiga.h"
    #include <proto/locale.h>
#endif
#ifdef WIN32
    #include "ibm.h"
    #define EXEC_TYPES_H
#endif
#ifdef GBA
    #include "gba.h"
#endif

#include <string.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h> /* EXIT_SUCCESS, EXIT_FAILURE */

#ifdef AMIGA
    #include "shared.h"
#endif
#include "ww.h"
#include "engine.h"
#ifdef ANDROID
    #include "levelset.h"
#endif

#if !defined(ANDROID) && !defined(GBA)
    #define CATCOMP_NUMBERS
    #define CATCOMP_BLOCK
    #include "ww_strings.h"
#endif

// #define ASSERT
#include <assert.h>

/* Conventions for variable types:

int   is used for field coordinates
SBYTE is used for queue indices
int   is used for player (ie. worm) numbers
UWORD is used for contents
UBYTE is used for creature numbers
SWORD is used for frequencies
SLONG is used for scores
Other types as required by host operating system */

// 2. DEFINES ------------------------------------------------------------

#define PATIENCE     200
#define PERLEVEL     922
#define FREQFACTOR     3 // commonest creature should be at least MAXLEVELS * FREQFACTOR

// MSG_INSTRUCTIONSx -> level number
//      #         Level
#define INTRO_1   1 // "Collect or shoot numbers 1-9 to clear level."
#define INTRO_3   2 // "Jump further when moving faster."
#define INTRO_4   3 // "Some obstacles can be shot."
#define INTRO_7   4 // "Monkeys throw bananas; catch them for points."
#define INTRO_2   5 // "Make square enclosures to kill creatures."
#define INTRO_9   6 // "You can also make diagonal enclosures."
#define INTRO_5   7 // "These are teleports."
#define INTRO_6   8 // "Extra life every 1,000 points."
#define INTRO_8   9 // "Go under clouds to catch rain."
#define INTRO_10 10 // "Prefer your own colour for more points."
#define INTRO_11 11 // "Fragments bounce off metal."
#define INTRO_12 12 // "Worms can't turn while traversing frost."
// #define TUTORIALS 12 (defined in ww.h)

// 3. EXPORTED VARIABLES -------------------------------------------------

EXPORT FLAG   aborted,
#ifdef GBA
              anims           = FALSE,
#else
              anims           = TRUE,
#endif
              autosave        = TRUE,
              banging         = FALSE,
              enclosed        = FALSE,
              engraved        = TRUE,
              isfruit,
              isometric       = FALSE,
              levels_modified = FALSE,
              quitting        = FALSE,
              scores_modified = FALSE,
              shuffle         = FALSE,
              superturbo      = FALSE,
              turbo           = FALSE;
EXPORT EWUNINIT FLAG randomarray[MAXLEVELS + 1];
EXPORT UBYTE  engraving,
              ice,
              whichfruit;
EXPORT EWUNINIT UWORD field[MAXFIELDX + 1][MAXFIELDY + 1],
              otherfield[MAXFIELDX + 1][MAXFIELDY + 1],
              gfxfield[MAXFIELDX + 1][MAXFIELDY + 1];
EXPORT SBYTE  a          = GAMEOVER,
              level      = 1,
              levels,
              players,
              reallevel,
              sourcelevel,
              number,
              treasurer;
EXPORT EWUNINIT SBYTE startx[MAXLEVELS + 1], starty[MAXLEVELS + 1];
EXPORT SWORD  fieldx, fieldy,
              secondsleft,
              secondsperlevel;
EXPORT EWUNINIT TEXT   pathname[MAX_PATH + 1],
              date[DATELENGTH + 1],
              times[TIMELENGTH + 1],
              stattext[7 + 1];
EXPORT ULONG  delay,
#ifdef GBA
              difficulty = DIFFICULTY_NORMAL,
#else
              difficulty = DIFFICULTY_EASY,
#endif
              quantity[5][3],
              r;
EXPORT int    bonustype,
              introframe,
              lighter,
              numberx, numbery,
              showing    = 4; /* 0..3 are rundown, 4 is  normal, 5 is intro */

#ifndef GBA
EXPORT EWUNINIT UWORD board[MAXLEVELS + 1][MINFIELDX + 1][MINFIELDY + 1];
EXPORT EWUNINIT STRPTR fruitname[LASTFRUIT - FIRSTFRUIT + 1];
#endif

#if !defined(ANDROID) && !defined(GBA)
EXPORT EWUNINIT struct HiScoreStruct   hiscore[4][HISCORES + 1];
#endif
EXPORT EWUNINIT struct WormStruct      worm[4];
EXPORT EWUNINIT struct PointStruct     point[POINTSLOTS];
EXPORT EWUNINIT struct ProtectorStruct protector[4][PROTECTORS + 1];
EXPORT EWUNINIT struct CreatureStruct  creature[CREATURES + 1];
EXPORT EWUNINIT struct TeleportStruct  teleport[2];

EXPORT EWINIT struct ObjectInfoStruct objectinfo[LASTOBJECT + 1] =
{ { 2300, 15 }, //  0 AFFIXER
  {  295,  3 }, //  1 AMMO
  {  495,  4 }, //  2 ARMOUR
  { 1490, 16 }, //  3 AUTOJUMP
  { 1420, 37 }, //  4 AUTOTURN
  {  955, 34 }, //  5 BACKWARDS
  {  300,  5 }, //  6 BONUS
  { 1020, 17 }, //  7 BRAKES
  {  875, 14 }, //  8 CUTTER
  {  865, 29 }, //  9 CYCLONE
  {  885, 18 }, // 10 ENCLOSER
  {  955, 33 }, // 11 FORWARDS
  {  300,  6 }, // 12 GLOW
  { 2990, 32 }, // 13 GRABBER
  {  985, 36 }, // 14 GRENADE
  {  585,  7 }, // 15 GROWER
  { 1530, 13 }, // 16 ICE
  {  595, 25 }, // 17 LIGHTNING
  {  245,  1 }, // 18 MINIBOMB
  {  895,  2 }, // 19 MINIHEALER
  {  655, 19 }, // 20 MINIPULSE
  {  675,  8 }, // 21 MISSILE_O
  { 1090, 28 }, // 22 MULTIPLIER
  {  660,  9 }, // 23 POWERUP
  {  335, 10 }, // 24 PROTECTOR
  {  845, 11 }, // 25 PUSHER
  {  990, 12 }, // 26 REMNANTS
  {  935, 20 }, // 27 SIDESHOT
  { 1290, 26 }, // 28 SLAYER
  { 1590, 21 }, // 29 SLOWER
  {  405, 22 }, // 30 SUPERBOMB
  { 7080, 27 }, // 31 SUPERHEALER
  {  765, 24 }, // 32 SUPERPULSE
  { 1675, 23 }, // 33 SWITCHER
  { 1390, 35 }, // 34 TAMER
  { 3130, 30 }, // 35 TREASURE
  { 6255, 31 }  // 36 UMBRELLA
};

EXPORT EWINIT struct CreatureInfoStruct creatureinfo[SPECIES + 1] =
{ { ANT,        FALSE,  300,  13,  50, "",  3, TRUE  }, //  0
  { BEAR,       TRUE,   780,  10,  50, "", 16, TRUE  },
  { BIRD,       FALSE,  510,  12,  50, "", 23, TRUE  },
  { BULL,       FALSE,  600,   3,  50, "", 26, TRUE  },
  { BUTTERFLY,  FALSE,  440,   1,  25, "",  6, TRUE  },
  { CAMEL,      FALSE, 1100,  16, 100, "",  8, TRUE  },
  { CHICKEN,    FALSE,  540,   5,  50, "", 17, TRUE  },
  { CLOUD,      FALSE,  400,   8,  50, "",  9, TRUE  },
  { CYCLONE_C,  FALSE,    0,   1, 100, "",  0, TRUE  },
  { DOG,        FALSE,  350,   3,  50, "", 22, TRUE  },
  { EEL,        FALSE,  520,  11,  50, "", 19, TRUE  }, // 10
  { ELEPHANT,   FALSE,  400,  18,  50, "", 28, TRUE  },
  { FISH,       TRUE,   410,   9,  50, "",  2, TRUE  },
  { FRAGMENT,   FALSE,    0,   3,   0, "",  0, FALSE },
  { FROG,       FALSE,  610,   4,  50, "", 27, TRUE  },
  { GIRAFFE,    FALSE,  420, 255,  50, "",  5, TRUE  },
  { GOOSE,      FALSE,  990,  25, 100, "", 14, TRUE  },
  { HORSE,      FALSE,  500,   7,  50, "", 15, TRUE  },
  { KANGAROO,   FALSE,  440,   9, 100, "", 31, TRUE  },
  { KOALA,      FALSE,  255,  30,  50, "", 20, TRUE  },
  { LEMMING,    FALSE,  290,  30,  50, "", 33, TRUE  }, // 20
  { MISSILE_C,  FALSE,    0,   6,  50, "",  0, FALSE },
  { MONKEY,     FALSE,  455,   7, 100, "",  4, TRUE  },
  { MOUSE,      FALSE,  330,   9,  50, "", 24, TRUE  },
  { OCTOPUS,    TRUE,   345,  14,  50, "", 25, TRUE  },
  { ORB,        FALSE,  190,   5,  50, "",  1, TRUE  },
  { OTTER,      TRUE,     0,  10, 100, "",  0, TRUE  },
  { PANDA,      FALSE,  790,  13,  50, "", 10, TRUE  },
  { PORCUPINE,  FALSE,  525,   8, 200, "", 34, TRUE  },
  { RABBIT,     FALSE,  500,   2, 200, "", 11, TRUE  },
  { RAIN,       FALSE,    0,   4,  50, "",  0, FALSE }, // 30
  { RHINOCEROS, FALSE,  435,  10,  50, "", 29, TRUE  },
  { SALAMANDER, FALSE,  320,   9,  50, "", 12, TRUE  },
  { SNAIL,      FALSE,  260,  50,  50, "",  7, TRUE  },
  { SNAKE,      FALSE,  600,   9,  50, "", 30, TRUE  },
  { SPIDER,     FALSE,  630,   8, 100, "", 13, TRUE  },
  { SQUID,      FALSE,  300,  12,  50, "", 21, TRUE  },
  { TERMITE,    FALSE,  560,  18,  50, "", 35, TRUE  },
  { TURTLE,     FALSE,  250,  20, 100, "", 32, TRUE  },
  { ZEBRA,      FALSE,  690,   8, 100, "", 18, TRUE  }, // 39
}; //           wall    freq spd  pts      lev user
#define LASTNEWLEVEL 37 // last level in which a new creature, object or fruit is introduced

/* In easy mode, creatures are introduced on these levels:
   0: cyclone, fragment, missile, otter, rain
   1: orb          21: squid
   2: fish         22: dog
   3: ant          23: bird
   4: monkey       24: mouse
   5: giraffe      25: octopus
   6: butterfly    26: bull
   7: snail        27: frog
   8: camel        28: elephant
   9: cloud        29: rhinoceros
  10: panda        30: snake
  11: rabbit       31: kangaroo
  12: salamander   32: turtle
  13: spider       33: lemming
  14: goose        34: porcupine
  15: horse        35: termite
  16: bear
  17: chicken
  18: zebra
  19: eel
  20: koala */

EXPORT const int sortcreatures[SPECIES + 1] = // index in graphics table -> index in creatureinfo table
{  0, // ant
   2, // bird
   3, // bull
   5, // camel
   7, // cloud
   8, // cyclone
   9, // dog
  12, // fish
  13, // fragment
  14, // frog
  15, // giraffe
  18, // kangaroo
  21, // missile
  22, // monkey
  23, // mouse
  24, // octopus
  25, // orb
  26, // otter
  29, // rabbit
  30, // rain
  32, // salamander
  33, // snail
  35, // spider
  16, // goose
  17, // horse
   1, // bear
  11, // elephant
   6, // chicken
  39, // zebra
  31, // rhinoceros
  34, // snake
  27, // panda
  10, // eel
   4, // butterfly
  19, // koala
  36, // squid
  38, // turtle
  20, // lemming
  28, // porcupine
  37, // termite
};

EXPORT EWINIT UWORD eachworm[4][2][9] =
{ { { GREENHEAD_NW,  GREENHEADUP,   GREENHEAD_NE,
      GREENHEADLEFT, ANYTHING,      GREENHEADRIGHT,
      GREENHEAD_SW,  GREENHEADDOWN, GREENHEAD_SE
    },
    { GREENGLOW_NW,  GREENGLOWUP,   GREENGLOW_NE,
      GREENGLOWLEFT, ANYTHING,      GREENGLOWRIGHT,
      GREENGLOW_SW,  GREENGLOWDOWN, GREENGLOW_SE
  } },
  { { REDHEAD_NW,    REDHEADUP,     REDHEAD_NE,
      REDHEADLEFT,   ANYTHING,      REDHEADRIGHT,
      REDHEAD_SW,    REDHEADDOWN,   REDHEAD_SE
    },
    { REDGLOW_NW,    REDGLOWUP,     REDGLOW_NE,
      REDGLOWLEFT,   ANYTHING,      REDGLOWRIGHT,
      REDGLOW_SW,    REDGLOWDOWN,   REDGLOW_SE
  } },
  { { BLUEHEAD_NW,   BLUEHEADUP,    BLUEHEAD_NE,
      BLUEHEADLEFT,  ANYTHING,      BLUEHEADRIGHT,
      BLUEHEAD_SW,   BLUEHEADDOWN,  BLUEHEAD_SE
    },
    { BLUEGLOW_NW,   BLUEGLOWUP,    BLUEGLOW_NE,
      BLUEGLOWLEFT,  ANYTHING,      BLUEGLOWRIGHT,
      BLUEGLOW_SW,   BLUEGLOWDOWN,  BLUEGLOW_SE
  } },
  { { YELLOWHEAD_NW, YELLOWHEADUP,  YELLOWHEAD_NE,
      YELLOWHEADLEFT,ANYTHING,      YELLOWHEADRIGHT,
      YELLOWHEAD_SW, YELLOWHEADDOWN,YELLOWHEAD_SE
    },
    { YELLOWGLOW_NW, YELLOWGLOWUP,  YELLOWGLOW_NE,
      YELLOWGLOWLEFT,ANYTHING,      YELLOWGLOWRIGHT,
      YELLOWGLOW_SW, YELLOWGLOWDOWN,YELLOWGLOW_SE
} } };

// 4. IMPORTED VARIABLES -------------------------------------------------

IMPORT UWORD bananaframes[4][BANANAFRAMES],
             eachtail[4][2][9][9];
#ifdef AMIGA
    IMPORT struct Catalog* CatalogPtr;
#endif
#ifdef WIN32
    IMPORT FLAG            ignorepaint;
    IMPORT int             CatalogPtr;
    IMPORT HCURSOR         hArrow,
                           hPointer;
#endif
#ifdef ANDROID
    IMPORT int             startedsounds1,
                           startedsounds2,
                           rivals;
    IMPORT UBYTE           IOBuffer[LSETSIZE];
    IMPORT ULONG           millielapsed;
#endif

// 5. MODULE VARIABLES ---------------------------------------------------

MODULE       FLAG   wasfruit,
                    teleports,
                    trainer;
MODULE       int    fruity;
MODULE const int    lifemodulo[4] = { 1000, 2000, 5000, 5000 };
MODULE       EWUNINIT TEXT   bonustext[BONUSLEVELS][80 + 1],
                    leveltext[80 + 1];
#if defined(ANDROID) || defined(GBA)
MODULE       UBYTE* thefile;
#else
MODULE       UBYTE  thefile[PERLEVEL];
#endif

/* 6. MODULE STRUCTURES --------------------------------------------------

(None)

7. MODULE FUNCTIONS --------------------------------------------------- */

MODULE void death(void);
MODULE void fastloop(void);
MODULE void killall(void);
MODULE void slowloop(void);
MODULE void ReadGameports(void);
MODULE void endoflevel(void);
MODULE void newlevel(int player);
MODULE void ramming(int player);
MODULE void wormworm(int x, int y, int player1, int player2);
MODULE SWORD atleast(SWORD value, SWORD minimum);
MODULE FLAG findempty(int* x, int* y);
MODULE FLAG findwall(int* x, int* y);
MODULE UBYTE slowdown(UBYTE speed, int player, FLAG brakes, FLAG stoppable);
MODULE FLAG checkautojump(int player);
MODULE void createcloud(void);
MODULE void createrabbit(void);
#if !defined(ANDROID) && !defined(GBA)
    MODULE void newhiscores(void);
#endif

// 8. CODE ---------------------------------------------------------------

EXPORT FLAG blockedtel(UBYTE which, int deltax, int deltay)
{   if (blockedsquare(xwrap(teleport[partner(which)].x + deltax), ywrap(teleport[partner(which)].y + deltay)))
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT void bombblast(UBYTE triggerer, int player, int centrex, int centrey, FLAG superbomb, int strength)
{   int counter,
           uppy,   uppymax,
          downy,  downymax,
          leftx,  leftxmax,
         rightx, rightxmax,
              x,      y;

    effect(FXUSE_BOMB);

    if (!strength)
    {   if (superbomb)
        {   strength = ADD_SUPERBOMB + arand(RAND_SUPERBOMB);
        } else
        {   strength = ADD_MINIBOMB  + arand(RAND_MINIBOMB );
    }   }
    leftxmax = centrex - strength;
    if (leftxmax < 0)
        leftxmax = 0;
    rightxmax = centrex + strength;
    if (rightxmax > fieldx)
        rightxmax = fieldx;
    uppymax = centrey - strength;
    if (uppymax < 0)
        uppymax = 0;
    downymax = centrey + strength;
    if (downymax > fieldy)
        downymax = fieldy;

    leftx = centrex;
    rightx = centrex;
    uppy = centrey;
    downy = centrey;
    for (counter = 1; counter <= strength; counter++)
    {   if (leftx > leftxmax)
        {   leftx--;
            for (y = uppy; y <= downy; y++)
                squareblast(triggerer, player, field[leftx][y],  leftx,  y,     FALSE, superbomb);
        }
        if (uppy > uppymax)
        {   uppy--;
            for (x = leftx; x <= rightx; x++)
                squareblast(triggerer, player, field[x][uppy],   x,      uppy,  FALSE, superbomb);
        }
        if (rightx < rightxmax)
        {   rightx++;
            for (y = downy; y >= uppy; y--)
                squareblast(triggerer, player, field[rightx][y], rightx, y,     FALSE, superbomb);
        }
        if (downy < downymax)
        {   downy++;
            for (x = rightx; x >= leftx; x--)
                squareblast(triggerer, player, field[x][downy],  x,      downy, FALSE, superbomb);
}   }   }

EXPORT int isign(int value)
{   if (value < 0)
    {   return -1;
    } elif (value > 0)
    {   return 1;
    } else
    {   return 0;
}   }

EXPORT void changefield(void)
{   int x, y;
#ifndef GBA
    int gap,
        xx, yy;
#endif

    if (shuffle && a == PLAYGAME && level)
    {   do
        {    sourcelevel = (SBYTE) arand((ULONG) levels - 1) + 1;
        } while (randomarray[sourcelevel]);
        randomarray[sourcelevel] = TRUE;
    } else sourcelevel = level;

#ifdef GBA
    if (sourcelevel == 0)
    {   for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   field[x][y] = gfxfield[x][y] = SILVER;
        }   }
        return;
    }
#endif

    for (x = 0; x <= fieldx; x++)
    {   for (y = 0; y <= fieldy; y++)
        {   field[x][y] = gfxfield[x][y] = EMPTY;
    }   }

#ifndef GBA
    if (fieldx < MINFIELDX || fieldy < MINFIELDY)
    {   if (fieldx < MINFIELDX)
        {   gap = MINFIELDX - fieldx;
            xx = gap / 2;
            if (gap % 2) xx++;
        } else
        {   xx = 0;
        }
        if (fieldy < MINFIELDY)
        {   gap = MINFIELDY - fieldy;
            yy = gap / 2;
            if (gap % 2) yy++;
        } else
        {   yy = 0;
        }
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   field[x][y] = gfxfield[x][y] = board[sourcelevel][xx + x][yy + y];
    }   }   }
    else
    {   for (x = 0; x <= MINFIELDX; x++)
        {   for (y = 0; y <= MINFIELDY; y++)
            {   field[x + WW_LEFTGAP][y + WW_TOPGAP] = gfxfield[x + WW_LEFTGAP][y + WW_TOPGAP] = board[sourcelevel][x][y];
    }   }   }
#endif
}

#ifndef GBA
#ifdef ANDROID
EXPORT int loadfields(void)
#else
EXPORT int loadfields(STRPTR pathname)
#endif
{   SBYTE i, j, k,
          x, y;
    ULONG thecursor;
#ifndef ANDROID
    UBYTE IOBuffer[NAMELENGTH + 1];
    FILE* LocalHandle /* = NULL */ ;
#endif

    /* This routine is not entirely robust, especially regarding
    failures part way through reading. It is very trusting of its data;
    ie. it doesn't do any sanity checking.

    Provided that the fieldset was created with Worm Wars's built-in level
    editor, and the file is not corrupt, these failures should never
    happen anyway.

    open file */

    // say("Opening...", WHITE);

#ifndef ANDROID
    if (!(LocalHandle = fopen(pathname, "rb")))
    {   return 1; /* no harm done */
    }
    // say("Reading header...", WHITE);
    if (fread(IOBuffer, 10, 1, LocalHandle) != 1)
    {   fclose(LocalHandle); // LocalHandle = NULL;
        return 2; /* no harm done */
    }
#endif
    if (strcmp((STRPTR) IOBuffer, "LSET 9.2"))
    {
#ifndef ANDROID
        fclose(LocalHandle); // LocalHandle = NULL;
#endif
        return 3; /* no harm done */
    }
    levels = (SBYTE) IOBuffer[9];
    // say("Reading high score table...", WHITE);
#ifndef ANDROID
    for (i = 0; i < 4; i++)
    {   for (j = 0; j <= HISCORES; j++)
        {   if (fread(IOBuffer, 6, 1, LocalHandle) != 1)
            {   fclose(LocalHandle); // LocalHandle = NULL;
                return 4; /* incorrect levels */
            }
            hiscore[i][j].fresh  = FALSE;
            hiscore[i][j].player = (SBYTE) IOBuffer[0];
            hiscore[i][j].level  = (SBYTE) IOBuffer[1];
            hiscore[i][j].score  = (IOBuffer[2] * 16777216)
                                 + (IOBuffer[3] * 65536)
                                 + (IOBuffer[4] * 256)
                                 +  IOBuffer[5];

            if (fread(IOBuffer, NAMELENGTH + 1, 1, LocalHandle) != 1)
            {   fclose(LocalHandle); // LocalHandle = NULL;
                return 5; /* incorrect levels, corrupted high scores */
            }
            for (k = 0; k <= NAMELENGTH; k++)
            {   hiscore[i][j].name[k] = (TEXT) IOBuffer[k];
            }
            if (fread(IOBuffer, TIMELENGTH + 1, 1, LocalHandle) != 1)
            {   fclose(LocalHandle); // LocalHandle = NULL;
                return 6; /* incorrect levels, corrupted high scores */
            }
            for (k = 0; k <= TIMELENGTH; k++)
            {   hiscore[i][j].time[k] = (TEXT) IOBuffer[k];
            }
            if (fread(IOBuffer, DATELENGTH + 1, 1, LocalHandle) != 1)
            {   fclose(LocalHandle); // LocalHandle = NULL;
                return 7; /* incorrect levels, corrupted high scores */
            }
            for (k = 0; k <= DATELENGTH; k++)
            {   hiscore[i][j].date[k] = (TEXT) IOBuffer[k];
    }   }   }
#endif

    // say("Reading level data...", WHITE);
    for (i = 0; i <= levels; i++)
    {
#ifdef ANDROID
        thefile = IOBuffer + 10 + (4 * (HISCORES + 1) * (6 + NAMELENGTH + 1 + DATELENGTH + 1 + TIMELENGTH + 1)) + (PERLEVEL * i);
#else
        if (fread((UBYTE *) thefile, PERLEVEL, 1, LocalHandle) != 1)
        {   fclose(LocalHandle); // LocalHandle = NULL;
            return 11;
            /* incorrect levels, corrupted high scores,
            incorrect startx/y, field data */
        }
#endif

        startx[i] = (SBYTE) thefile[0];
        starty[i] = (SBYTE) thefile[1];

        thecursor = 2;
        for (y = 0; y <= MINFIELDY; y++)
        {   for (x = 0; x <= MINFIELDX; x += 2)
            {   switch (thefile[thecursor] & 0xF0)
                {
                case   1 * 16: board[i][x][y] = EMPTY;
                acase  2 * 16: board[i][x][y] = SILVER;
                acase  3 * 16: board[i][x][y] = GOLD;
                acase  4 * 16: board[i][x][y] = DYNAMITE;
                acase  5 * 16: board[i][x][y] = WOOD;
                acase  6 * 16: board[i][x][y] = STONE;
                acase  7 * 16: board[i][x][y] = METAL;
                acase  8 * 16: board[i][x][y] = FROST;
                acase  9 * 16: board[i][x][y] = ARROWUP;
                acase 10 * 16: board[i][x][y] = ARROWDOWN;
                acase 11 * 16: board[i][x][y] = SLIME;
                }
                if (x < MINFIELDX)
                {   switch (thefile[thecursor] & 0x0F)
                    {
                    case   1: board[i][x + 1][y] = EMPTY;
                    acase  2: board[i][x + 1][y] = SILVER;
                    acase  3: board[i][x + 1][y] = GOLD;
                    acase  4: board[i][x + 1][y] = DYNAMITE;
                    acase  5: board[i][x + 1][y] = WOOD;
                    acase  6: board[i][x + 1][y] = STONE;
                    acase  7: board[i][x + 1][y] = METAL;
                    acase  8: board[i][x + 1][y] = FROST;
                    acase  9: board[i][x + 1][y] = ARROWUP;
                    acase 10: board[i][x + 1][y] = ARROWDOWN;
                    acase 11: board[i][x + 1][y] = SLIME;
                }   }
                thecursor++;
    }   }   }

    // say("Open done.", WHITE);
    // no need to read version string

#ifndef ANDROID
    fclose(LocalHandle); // LocalHandle = NULL;
#endif
    levels_modified = scores_modified = FALSE;
    return 0;
}
#endif

#if !defined(ANDROID) && !defined(GBA)
EXPORT FLAG hiscoresareclear(void)
{   int i, j;

    for (i = 0; i <= 3; i++)
    {   for (j = 0; j <= HISCORES; j++)
        {   if (hiscore[i][j].player != -1)
            {   return FALSE;
    }   }   }

    return TRUE;
}
EXPORT void clearhiscores(void)
{   int i, j;

    for (i = 0; i <= 3; i++)
    {   for (j = 0; j <= HISCORES; j++)
        {   hiscore[i][j].player  = -1;
            hiscore[i][j].level   = 0;
            hiscore[i][j].score   = 0;
            hiscore[i][j].fresh   = FALSE;
            hiscore[i][j].name[0] =
            hiscore[i][j].time[0] =
            hiscore[i][j].date[0] = EOS;
}   }   }
#endif

MODULE void death(void)
{   SBYTE pain, player;
    UBYTE which;
    int   x, y;

    for (player = 0; player <= 3; player++)
    {   if (worm[player].lives)
        {   if (!worm[player].alive)
            {   pain = 0;
                if (worm[player].cause >= FIRSTTAIL && worm[player].cause <= LASTTAIL)
                {   if (player == worm[player].cause - FIRSTTAIL)
                    {   pain = PAIN_FRIENDLYTAIL;
                    } else
                    {   pain = PAIN_ENEMYTAIL;
                }   }
                elif   (worm[player].cause >= FIRSTGLOW      && worm[player].cause <= LASTGLOW)
                {   pain = PAIN_GLOW;
                } elif (worm[player].cause >= FIRSTFIRE      && worm[player].cause <= LASTFIRE)
                {   pain = PAIN_WORMFIRE;
                } elif (worm[player].cause >= FIRSTHEAD      && worm[player].cause <= LASTHEAD)
                {   pain = PAIN_HEAD;
                } elif (worm[player].cause >= FIRSTPROTECTOR && worm[player].cause <= LASTPROTECTOR)
                {   pain = PAIN_PROTECTOR;
                } elif
                (   (worm[player].cause >= FIRSTCREATURE && worm[player].cause <= LASTCREATURE)
                 || (worm[player].cause >= FIRSTMISSILE  && worm[player].cause <= LASTMISSILE )
                )
                {   pain = PAIN_CREATURE;
                } else switch (worm[player].cause)
                {
                case METAL:
                    pain = PAIN_METAL;
                acase SLIME:
                    pain = PAIN_SLIME;
                acase STONE:
                    pain = PAIN_STONE;
                acase TELEPORT:
                    pain = PAIN_TELEPORT;
                acase WOOD:
                    pain = PAIN_WOOD;
                acase MINIBOMB:
                case SUPERBOMB:
                    pain = PAIN_BOMB;
                acase SLAYER:
                    pain = PAIN_SLAYER;
                acase LIGHTNING:
                    pain = PAIN_LIGHTNING;
                }
#ifndef TESTING
                if (pain > worm[player].lives)
                {   worm[player].lives = 0;
                } else
                {   worm[player].lives -= pain;
                }
#endif
                draw(worm[player].x, worm[player].y, (UWORD) (FIRSTPAIN + player));
                stat(player, MINIHEALER);
                if (level)
                {   worm[player].levelreached = level;
                } else
                {   worm[player].levelreached = reallevel;
                }
                if (worm[player].lives)
                {   effect((UBYTE) (FXPAIN + player));
                } else
                {   /* kill worm */
                    effect(FXDEATH_WORM);
                    change1(worm[player].x, worm[player].y, (UWORD) (FIRSTGRAVE + player));
                    for (x = 0; x <= fieldx; x++)
                    {   for (y = 0; y <= fieldy; y++)
                        {   if (field[x][y] == FIRSTTAIL + player)
                            {   change1(x, y, SILVER);
                            } elif (field[x][y] == FIRSTGLOW + player)
                            {   change1(x, y, GOLD);
                    }   }   }
                    updatearrow(worm[player].y);
                    for (which = 0; which <= PROTECTORS; which++)
                    {   if (protector[player][which].alive && protector[player][which].visible)
                        {   change1(protector[player][which].x, protector[player][which].y, EMPTY);
                    }   }
                    if (worm[player].score >= worm[player].hiscore)
                    {   worm[player].hiscore = worm[player].score;
    }   }   }   }   }

#ifdef GBA
    if (quitting)
    {   quitting = FALSE;
        a = GAMEOVER;
        return;
    }
#endif

#if defined(ANDROID) || defined(GBA)
    if (!worm[0].lives)
#else
    if
    (   (worm[0].control == NONE || !worm[0].lives)
     && (worm[1].control == NONE || !worm[1].lives)
     && (worm[2].control == NONE || !worm[2].lives)
     && (worm[3].control == NONE || !worm[3].lives)
    )
#endif
    {   turbo = superturbo = FALSE;

#if !defined(ANDROID) && !defined(GBA)
        for (player = 0; player <= 3; player++)
        {   if (worm[player].control != NONE && worm[player].score >= worm[player].hiscore)
            {   worm[player].hiscore = worm[player].score;
        }   }
        newhiscores();
#endif

        a = GAMEOVER;
        effect(FXGAMEOVER);
        playsong(SONG_GAMEOVER);
        say((STRPTR) GetCatalogStr(CatalogPtr, MSG_GAMEOVER, "Game over!"), WHITE);
        waitasec();
        anykey(FALSE, FALSE);
}   }

EXPORT void enginesetup(void)
{   worm[0].statx = worm[0].staty = worm[1].staty = worm[2].statx = 0;
    worm[1].statx = worm[2].staty = worm[3].statx = worm[3].staty = 1;
    worm[0].colour = GREEN;
    worm[1].colour = RED;
    worm[2].colour = BLUE;
    worm[3].colour = YELLOW;
    worm[0].dimcolour = DARKGREEN;
    worm[1].dimcolour = DARKRED;
    worm[2].dimcolour = DARKBLUE;
    worm[3].dimcolour = DARKYELLOW;
    worm[0].port = 2;
    worm[1].port = 3;
    worm[2].port = 1;
    worm[3].port = 0;
#if defined(ANDROID) || defined(GBA)
    worm[0].control = KEYBOARD;
    worm[1].control =
    worm[2].control =
    worm[3].control = NONE;
#else
    worm[0].control = NONE;
    worm[1].control = KEYBOARD;
    worm[2].control = NONE;
    worm[3].control = THEAMIGA;
#endif
    strcpy(pathname, DEFAULTSET);
    engraving = 0; // you can't use rand() in this function, it is called too early in the startup by SAS/C.

    systemsetup();
}

EXPORT void enginesetup2(void)
{
#ifdef GBA
    ;
#else
    int i;

    fruitname[ 0]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_APPLE           , "Apple"                               );
    fruitname[ 1]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_ORANGE          , "Orange"                              );
    fruitname[ 2]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_CARROT          , "Carrot"                              );
    fruitname[ 3]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_LEMON           , "Lemon"                               );
    fruitname[ 4]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_RADISH          , "Radish"                              );
    fruitname[ 5]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_PINEAPPLE       , "Pineapple"                           );
    fruitname[ 6]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_LIME            , "Lime"                                );
    fruitname[ 7]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_PASSIONFRUIT    , "Passionfruit"                        );
    fruitname[ 8]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_WATERMELON      , "Watermelon"                          );
    fruitname[ 9]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_COCONUT         , "Coconut"                             );
    fruitname[10]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_PEAR            , "Pear"                                );
    fruitname[11]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_CORN            , "Corn"                                );
    fruitname[12]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_BLACKBERRY      , "Blackberry"                          );
    fruitname[13]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_BLUEBERRY       , "Blueberry"                           );
    fruitname[14]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_STRAWBERRY      , "Strawberry"                          );
    fruitname[15]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_CELERY          , "Celery"                              );
    fruitname[16]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_TURNIP          , "Turnip"                              );
    fruitname[17]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_KIWIFRUIT       , "Kiwifruit"                           );
    fruitname[18]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_MANGO           , "Mango"                               );
    fruitname[19]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_LETTUCE         , "Lettuce"                             );
    fruitname[20]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_SOFTDRINK       , "Soft drink");
    fruitname[21]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_PIZZA           , "Pizza");
    fruitname[22]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_FRIES           , "Chips");
    fruitname[23]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_ICECREAM        , "Ice cream");
    fruitname[24]                = (STRPTR) GetCatalogStr(CatalogPtr, MSG_HAMBURGER       , "Hamburger");

    objectinfo[ 0].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_AFFIXER    , "AFFIXER: Stops protectors rotating.");
    objectinfo[ 1].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_AMMO,        "AMMO: 5 bullets.");
    objectinfo[ 2].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_ARMOUR,      "ARMOUR: Immune to most damage.");
    objectinfo[ 3].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_AUTOJUMP,    "AUTOJUMP: Automagically jump.");
    objectinfo[ 4].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_AUTOTURN,    "AUTOTURN: Automagically turn.");
    objectinfo[ 5].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_BACKWARDS,   "BACKWARDS: Shoot diagonally backwards.");
    objectinfo[ 6].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_BONUS,       "BONUS: Awards the next number.");
    objectinfo[ 7].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_BRAKES,      "BRAKES: Allows stopping.");
    objectinfo[ 8].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_CUTTER,      "CUTTER: Cuts a tunnel through tail.");
    objectinfo[ 9].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_CYCLONE,     "CYCLONE: Unleashes a cyclone.");
    objectinfo[10].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_ENCLOSER,    "ENCLOSER: Rectangular enclosure.");
    objectinfo[11].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_FORWARDS,    "FORWARDS: Shoot diagonally forwards.");
    objectinfo[12].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_GLOW,        "GLOW: Leaves a glowing tail.");
    objectinfo[13].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_GRABBER,     "GRABBER: Grabs all objects.");
    objectinfo[14].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_GRENADE,     "GRENADE: Super bomb when shooting.");
    objectinfo[15].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_GROWER,      "GROWER: Enlarges silver, gold, etc.");
    objectinfo[16].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_ICE,         "ICE: Freezes enemies.");
    objectinfo[17].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_LIGHTNING,   "LIGHTNING: Flashes around tail.");
    objectinfo[18].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_MINIBOMB,    "MINI BOMB: A minor explosion.");
    objectinfo[19].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_MINIHEALER,  "MINI HEALER: 5 lives.");
    objectinfo[20].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_MINIPULSE,   "MINI PULSE: A minor fragment burst.");
    objectinfo[21].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_MISSILE,     "MISSILE: Launches a guided missile.");
    objectinfo[22].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_MULTIPLIER,  "MULTIPLIER: Double points.");
    objectinfo[23].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_POWER,       "POWERUP: Thicker bullets.");
    objectinfo[24].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_PROTECTOR,   "PROTECTOR: An orbiting companion.");
    objectinfo[25].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_PUSHER,      "PUSHER: Lets you push things.");
    objectinfo[26].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_REMNANTS,    "REMNANTS: Bullets leave a trail.");
    objectinfo[27].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_SIDESHOT,    "SIDESHOT: Shoot sideways.");
    objectinfo[28].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_SLAYER,      "SLAYER: Smart bomb.");
    objectinfo[29].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_SLOWER,      "SLOWER: Slows creatures down.");
    objectinfo[30].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_SUPERBOMB,   "SUPER BOMB: A major explosion.");
    objectinfo[31].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_SUPERHEALER, "SUPER HEALER: 10 lives.");
    objectinfo[32].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_SUPERPULSE,  "SUPER PULSE: A major fragment burst.");
    objectinfo[33].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_SWITCHER,    "SWITCHER: Changes tail colours.");
    objectinfo[34].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_TAMER,       "TAMER: Changes evil creatures to good.");
    objectinfo[35].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_TREASURE,    "TREASURE: Treasure level.");
    objectinfo[36].desc          = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DESC_UMBRELLA,    "UMBRELLA: Skips 2-3 levels.");

    creatureinfo[ 0].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_ANT,              "Ant");
    creatureinfo[ 1].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_BEAR,             "Bear");
    creatureinfo[ 2].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_BIRD,             "Bird");
    creatureinfo[ 3].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_BULL,             "Bull");
    creatureinfo[ 4].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_BUTTERFLY,        "Butterfly");
    creatureinfo[ 5].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_CAMEL,            "Camel");
    creatureinfo[ 6].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_CHICKEN,          "Chicken");
    creatureinfo[ 7].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_CLOUD,            "Cloud");
    creatureinfo[ 8].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_CYCLONE,          "Cyclone");
    creatureinfo[ 9].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_DOG,              "Dog");
    creatureinfo[10].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_EEL,              "Eel");
    creatureinfo[11].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_ELEPHANT,         "Elephant");
    creatureinfo[12].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_FISH,             "Fish");
    creatureinfo[13].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_FRAGMENT,         "Fragment");
    creatureinfo[14].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_FROG,             "Frog");
    creatureinfo[15].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_GIRAFFE,          "Giraffe");
    creatureinfo[16].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_GOOSE,            "Goose");
    creatureinfo[17].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_HORSE,            "Horse");
    creatureinfo[18].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_KANGAROO,         "Kangaroo");
    creatureinfo[19].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_KOALA,            "Koala");
    creatureinfo[20].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_LEMMING,          "Lemming");
    creatureinfo[21].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_MISSILE,          "Missile");
    creatureinfo[22].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_MONKEY,           "Monkey");
    creatureinfo[23].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_MOUSE,            "Mouse");
    creatureinfo[24].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_OCTOPUS,          "Octopus");
    creatureinfo[25].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_ORB,              "Orb");
    creatureinfo[26].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_OTTER,            "Otter");
    creatureinfo[27].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_PANDA,            "Panda");
    creatureinfo[28].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_PORCUPINE,        "Porcupine");
    creatureinfo[29].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_RABBIT,           "Rabbit");
    creatureinfo[30].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_RAIN,             "Rain");
    creatureinfo[31].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_RHINOCEROS,       "Rhinoceros");
    creatureinfo[32].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_SALAMANDER,       "Salamander");
    creatureinfo[33].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_SNAIL,            "Snail");
    creatureinfo[34].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_SNAKE,            "Snake");
    creatureinfo[35].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_SPIDER,           "Spider");
    creatureinfo[36].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_SQUID,            "Squid");
    creatureinfo[37].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_TERMITE,          "Termite");
    creatureinfo[38].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_TURTLE,           "Turtle");
    creatureinfo[39].name        = (STRPTR) GetCatalogStr(CatalogPtr, MSG_ZEBRA,            "Zebra");

    strcpy(worm[0].name, (STRPTR) GetCatalogStr(CatalogPtr, MSG_GREEN,  "(Green)" ));
    strcpy(worm[1].name, (STRPTR) GetCatalogStr(CatalogPtr, MSG_RED,    "(Red)"   ));
    strcpy(worm[2].name, (STRPTR) GetCatalogStr(CatalogPtr, MSG_BLUE,   "(Blue)"  ));
    strcpy(worm[3].name, (STRPTR) GetCatalogStr(CatalogPtr, MSG_YELLOW, "(Yellow)"));

    for (i = 0; i < BONUSLEVELS; i++)
    {   sprintf
        (   bonustext[i],
            "%s: ",
            (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUSLEVEL, "Bonus Level")
        );
    }

    strcat(bonustext[ 0], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_ORBS       , "Capture the Orbs"     ));
    strcat(bonustext[ 1], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_BANANAS    , "Eat the Bananas"      ));
    strcat(bonustext[ 2], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_RAIN       , "Drink the Rain"       ));
    strcat(bonustext[ 3], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_OBJECTS    , "Grab the Objects"     ));
    strcat(bonustext[ 4], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_BUTTERFLIES, "Touch the Butterflies"));
    strcat(bonustext[ 5], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_RABBITS    , "Hunt the Rabbits"     ));
    strcat(bonustext[ 6], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_ENCLOSE    , "Make Enclosures"      ));
    strcat(bonustext[ 7], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_CHERRIES   , "Eat the Cherries"     ));
    strcat(bonustext[ 8], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_PATH       , "Follow the Path"      ));
    strcat(bonustext[ 9], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_DOGS       , "Flee the Dogs"        ));
    strcat(bonustext[10], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_SNAKES     , "Survive the Snakes"   ));
    strcat(bonustext[11], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_BULLS      , "Enrage the Bulls"     ));
    strcat(bonustext[12], (STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUS_JUMP       , "Jump the Walls"       ));
#endif
}

MODULE void fastloop(void)
{   UWORD c;
    int   i,
          player,
          x, y;

    if (lighter >= 0)
    {   lighter = -1;
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   if (otherfield[x][y] == TEMPLIGHTNING)
                {   c = field[x][y];
                    if (c >= FIRSTCREATURE && c <= LASTCREATURE)
                    {   i = (int) whichcreature(x, y, c, 255);
                        if
                        (   c == BIRD
                         || c == DOG
                         || lighter != creature[i].player
                        )
                        {   wormkillcreature(lighter, (UBYTE) i, TRUE);
                    }   }
                    else
                    {   change1(x, y, EMPTY);
    }   }   }   }   }

    // decrement score if stopped
    if (!(r % 4))
    {   for (player = 0; player <= 3; player++)
        {   if (worm[player].lives && worm[player].speed == SPEED_STOPPED)
            {   if (worm[player].score >= players)
                {   wormscore((SBYTE) player, -1);
                } else
                {   worm[player].speed = SPEED_SLOW;
                    stat(player, BRAKES);
    }   }   }   }

    // animate
    if (anims)
    {   for (i = 0; i <= CREATURES; i++)
        {   if (creature[i].alive && creature[i].visible)
            {   if (creature[i].species == BIRD)
                {   if (!(r % ANIMSPEED_BIRD))
                    {   creature[i].frame += creature[i].dir;
                        drawcreature(i);
                        if (creature[i].frame == 0)
                        {   creature[i].dir = 1;
                        } elif (creature[i].frame == 4)
                        {   creature[i].dir = -1;
                }   }   }
                elif (creature[i].species == EEL)
                {   if (!(r % ANIMSPEED_EEL))
                    {   if (creature[i].frame == 3)
                        {   creature[i].frame = 0;
                        } else creature[i].frame++;
                        drawcreature(i);
                }   }
                elif (creature[i].species == MISSILE_C)
                {   if (!(r % ANIMSPEED_MISSILE))
                    {   drawcreature(i);
                        if (++creature[i].frame > MISSILEFRAMES)
                        {   creature[i].frame = 0;
                }   }   }
                elif (creature[i].species == FRAGMENT && creature[i].subspecies == BANANA)
                {   if (!(r % ANIMSPEED_BANANA))
                    {   if (creature[i].frame == 0 && creature[i].dir == -1)
                        {   creature[i].frame = 7;
                        } elif (creature[i].frame == 7 && creature[i].dir == 1)
                        {   creature[i].frame = 0;
                        } else creature[i].frame += creature[i].dir;
                        drawcreature(i);
                }   }
                elif (creature[i].species == SQUID && creature[i].deltax == 0)
                {   if (!(r % ANIMSPEED_SQUID))
                    {   if (creature[i].frame == SQUIDFRAMES)
                        {   creature[i].frame = 0;
                        } else
                        {   creature[i].frame++;
                        }
                        drawcreature(i);
    }   }   }   }   }

    if (banging)
    {   banging = FALSE;
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   if (field[x][y] == BANGEDDYNAMITE)
                {   change1(x, y, SILVER);
                    bangdynamite(x, y);
        }   }   }
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   if (field[x][y] == BANGINGDYNAMITE)
                {   banging = TRUE;
                    field[x][y] = BANGEDDYNAMITE;
    }   }   }   }

    // flash number
    if (level)
    {   assert(number >= 1 && number <= 9);
        if (r % 16 == 8)
        {   change2(numberx, numbery, (UWORD) (FIRSTNUMBER + number - 1), (UWORD) (FIRSTREVNUMBER + number - 1));
        } elif (r % 16 == 0)
        {   change1(numberx, numbery, (UWORD) (FIRSTNUMBER + number - 1));
        } // else no need to draw
    }

    // flash icons
    for (player = 0; player <= 3; player++)
    {   if (worm[player].control != NONE)
        {   icon(player, GLOW);
            icon(player, CUTTER);
            icon(player, ARMOUR);
}   }   }

MODULE FLAG findempty(int* x, int* y)
{   int   i,
          xx, yy;
    UWORD c;

    for (i = 0; i < PATIENCE; i++)
    {   xx = arand((ULONG) fieldx);
        yy = arand((ULONG) fieldy);
        c  = field[xx][yy];
        if (c >= FIRSTEMPTY && c <= LASTEMPTY)
        {   *x = xx;
            *y = yy;
            return TRUE;
    }   }

    return FALSE;
}

MODULE FLAG findwall(int* x, int* y)
{   int   i,
          xx, yy;
    UWORD c;

    for (i = 0; i < PATIENCE; i++)
    {   xx = arand((ULONG) fieldx);
        yy = arand((ULONG) fieldy);
        c  = field[xx][yy];
        if
        (    c == SLIME
         ||  c == WOOD
         ||  c == STONE
         ||  c == METAL
         || (c >= FIRSTTAIL && c <= LASTTAIL)
        )
        {   *x = xx;
            *y = yy;
            return TRUE;
    }   }

    return FALSE;
}

#ifdef ANDROID
JNIEXPORT void JNICALL Java_com_amigan_wormwars_GameActivity_gameloop(JNIEnv* env, jobject this)
#else
EXPORT void gameloop(void)
#endif
{   int i,
        player;

#ifdef ANDROID
    startedsounds1 = startedsounds2 = 0;
#endif

    if (a != PLAYGAME) return;

#ifdef ANDROID
    millielapsed += delay / 1000;
    secondsleft = secondsperlevel - (millielapsed / 1000); // secondsleft can be negative in some instances
    r++;
    timeloop();
#endif

    if (showing >= 0 && showing <= 3)
    {   newlevel(showing);
        showing = 4;
    }

    for (player = 0; player <= 3; player++)
    {   if (worm[player].control != NONE && worm[player].lives >= 1)
        {   worm[player].alive = TRUE;
    }   }

    ReadGameports();
#ifdef WIN32
    readibmgameport(0);
    readibmgameport(1);
#endif
    fastloop();
    gameinput();

    for (player = 0; player < 4; player++)
    {    if (worm[player].lives)
        {   if (worm[player].speed)
            {   if (!(r % worm[player].speed))
                {   if (worm[player].wait)
                    {   worm[player].wait = FALSE;
                    } else
                    {   wormloop(player);
            }   }   }
            else
            {   stoppedwormloop((SBYTE) player);
    }   }   }

    if (!ice)
    {   for (i = 0; i <= CREATURES; i++)
        {   if (creature[i].alive)
            {   if (creature[i].species == BULL && creature[i].deltax == 0)
                {   for (player = 0; player <= 3; player++)
                    {   if (worm[player].lives && worm[player].y == creature[i].y)
                        {   if (creature[i].dir == -1)
                            {   if (worm[player].x < creature[i].x)
                                {   effect(FXBORN_BULL);
                                    creature[i].deltax = -1;
                                    creature[i].player = player;
                            }   }
                            else
                            {   assert(creature[i].dir == 1);
                                if (worm[player].x > creature[i].x)
                                {   effect(FXBORN_BULL);
                                    creature[i].deltax = 1;
                                    creature[i].player = player;
                }   }   }   }   }
                if (!(r % creature[i].speed))
                {   creatureloop((UBYTE) i);
    }   }   }   }

    death();
    if (a != PLAYGAME)
    {   return;
    }

    if (!(r % SPEED_VERYSLOW))
    {   slowloop();
}   }

MODULE void killall(void)
{   int i;

    for (i = 0; i <= CREATURES; i++)
    {   creature[i].alive = FALSE;
    }
    teleports =
    wasfruit  =
    isfruit   = FALSE;
}

EXPORT void newfield(void)
{
#ifdef GBA
    ;
#else
    int x, y;

    startx[level] = fieldx / 2;
    starty[level] = fieldy / 2;

    if (level)
    {   for (x = 0; x <= MINFIELDX; x++)
        {   for (y = 0; y <= MINFIELDY; y++)
            {   board[level][x][y] = EMPTY;
    }   }   }
    else
    {   for (x = 0; x <= MINFIELDX; x++)
        {   for (y = 0; y <= MINFIELDY; y++)
            {   board[0][x][y] = SILVER;
    }   }   }
#endif
}

EXPORT void newfields(void)
{
#ifdef ANDROID
    memcpy(IOBuffer, levelset, 70942);
    loadfields();
#else
    if (verify())
    {   pathname[0] = EOS;
        levels = DEFAULTLEVELS;
        for (level = 0; level <= levels; level++)
        {   newfield();
        }
#ifndef GBA
        clearhiscores();
#endif
        levels_modified = scores_modified = FALSE;
        level = 1;
        if (a == LEVELEDIT)
        {   le_drawfield();
        } else
        {   renderhiscores_amiga();
        }
        updatemenu();
    }
#endif
}

#ifdef ANDROID
JNIEXPORT void JNICALL Java_com_amigan_wormwars_GameActivity_newgame(JNIEnv* env, jobject this)
#else
EXPORT void newgame(void)
#endif
{   int i, player;

#ifdef WIN32
    hPointer = hArrow;
    SetCursor(hPointer);
#endif
#ifdef ANDROID
    worm[0].control = KEYBOARD;
    worm[1].control = (rivals >= 1) ? THEAMIGA : NONE;
    worm[2].control = (rivals >= 2) ? THEAMIGA : NONE;
    worm[3].control = (rivals >= 3) ? THEAMIGA : NONE;
#endif

    players = 0;
    for (player = 0; player <= 3; player++)
    {   if (worm[player].control != NONE)
        {   players++;
        }
        worm[player].lives    = 0;
        worm[player].speed    = SPEED_NORMAL;
        worm[player].nextlife = lifemodulo[difficulty];
        worm[player].score    =
        worm[player].hiscore  = 0;
    }
    for (i = 1; i <= MAXLEVELS; i++)
    {   randomarray[i] = FALSE;
    }

    r           = -1;
    trainer     =
#ifdef TESTING
    turbo       =
    superturbo  = TRUE;
#else
    turbo       =
    superturbo  = FALSE;
#endif
    ice         = 0;
    reallevel   = 0;
    level       = 1;
    a           = PLAYGAME;
    aborted     = FALSE;
    lighter     = -1;

    clearscreen();
    newlevel(arand(3));
    timing();
}

#if !defined(ANDROID) && !defined(GBA)
MODULE void newhiscores(void)
{   PERSIST   TEXT  amiganame[4][NAMELENGTH + 1] = {"Jay Miner", "Carl Sassenrath", "R.J. Mical", "Dave Morse"};
    TRANSIENT SBYTE i, j, player;

    if (!aborted)
    {   datestamp();
        for (player = 0; player <= 3; player++)
        {   for (i = 0; i <= HISCORES; i++)
            {   if (worm[player].control != NONE && worm[player].hiscore >= hiscore[difficulty][i].score)
                {   /* push all worse hiscores down */

                    if (i < HISCORES)
                    {   for (j = HISCORES; j >= i + 1; j--)
                        {   hiscore[difficulty][j].player     = hiscore[difficulty][j - 1].player;
                            hiscore[difficulty][j].level      = hiscore[difficulty][j - 1].level;
                            hiscore[difficulty][j].score      = hiscore[difficulty][j - 1].score;
                            hiscore[difficulty][j].fresh      = hiscore[difficulty][j - 1].fresh;
                            strcpy(hiscore[difficulty][j].name, hiscore[difficulty][j - 1].name);
                            strcpy(hiscore[difficulty][j].date, hiscore[difficulty][j - 1].date);
                            strcpy(hiscore[difficulty][j].time, hiscore[difficulty][j - 1].time);
                    }   }

                    scores_modified = TRUE;
                    hiscore[difficulty][i].player = player;
                    hiscore[difficulty][i].level  = worm[player].levelreached;
                    hiscore[difficulty][i].score  = worm[player].hiscore;
                    if (worm[player].control == THEAMIGA)
                    {   strcpy(hiscore[difficulty][i].name, amiganame[player]);
                        hiscore[difficulty][i].fresh = FALSE;
                    } else
                    {   strcpy(hiscore[difficulty][i].name, worm[player].name);
                        hiscore[difficulty][i].fresh = TRUE;
                    }
                    strcpy(hiscore[difficulty][i].time, times);
                    strcpy(hiscore[difficulty][i].date, date);
                    break; /* vital */
}   }   }   }   }
#endif

MODULE void newlevel(int player)
{   int deltax, deltay,
        i, j,
        patience,
        x, y;

    // clear input queue
    for (i = 0; i <= 3; i++)
    {   worm[i].queuepos = -1;
    }

    if (!level || !shuffle)
    {   sourcelevel = level;
    }
    changefield();

    if
    (   difficulty == DIFFICULTY_EASY
     && level      >= 1
     && level      <= levels
     && level      <= LASTNEWLEVEL
    )
    {   if (level != 1)
        {   clearscreen();
        }
        intro();
        if (level <= TUTORIALS)
        {
#ifdef WIN32
            ignorepaint = TRUE;
#endif
            introanim();
        } else
        {   anykey(FALSE, FALSE);
        }
        if (isometric)
        {   clearscreen();
    }   }

    showing = 4;

    if (a == PLAYGAME)
    {   say("", BLACK);

        if (engraving == 0)
        {   engraving = ENGRAVINGS - 1;
        } else
        {   engraving--;
        }

        // assert(level <= levels);
        saylevel(WHITE);
        for (i = 0; i <= 3; i++)
        {   if (worm[i].multi > 1)
            {   worm[i].multi /= 2;
        }   }
        killall();
        for (i = 0; i < POINTSLOTS; i++)
        {   point[i].time = 0;
        }
        turborender();

        if (level == 0)
        {   playsong(SONG_BONUS);
        } else
        {   playsong((UBYTE) (SONG_GAME + ((level - 1) % 5))); // 3..7
        }
        for (i = 0; i <= 3; i++)
        {   if (difficulty == DIFFICULTY_EASY)
            {   worm[i].speed = SPEED_SLOW;
            } else
            {   worm[i].speed = SPEED_NORMAL;
            }
            if (worm[i].lives)
            {   stat(i, BRAKES);
            }
            worm[i].moved = FALSE;
            worm[i].numbers = 0;
#ifdef GBA
            worm[i].x = fieldx / 2;
            worm[i].y = fieldy / 2;
#else
            worm[i].x = startx[sourcelevel] + WW_LEFTGAP;
            worm[i].y = starty[sourcelevel] + WW_TOPGAP;
            if (worm[i].x < 0) worm[i].x = 0; elif (worm[i].x > fieldx) worm[i].x = fieldx;
            if (worm[i].y < 0) worm[i].y = 0; elif (worm[i].y > fieldy) worm[i].y = fieldy;
#endif
            worm[i].arrowy = worm[i].y;
            switch (i)
            {
            case 0:
                worm[0].deltax = -1;
                worm[0].deltay = 0;
            acase 1:
                worm[1].deltax = 1;
                worm[1].deltay = 0;
            acase 2:
                worm[2].deltax = 0;
                worm[2].deltay = -1;
            acase 3:
                worm[3].deltax = 0;
                worm[3].deltay = 1;
        }   }
        if
        (   (worm[0].control != NONE && worm[0].control != THEAMIGA)
         || (worm[1].control != NONE && worm[1].control != THEAMIGA)
         || (worm[2].control != NONE && worm[2].control != THEAMIGA)
         || (worm[3].control != NONE && worm[3].control != THEAMIGA)
        )
        {   turbo = superturbo = FALSE;
        }

        delay = DELAY * 1000;
        if (difficulty == DIFFICULTY_HARD)
        {   delay = delay * 4 / 5; // 80.0 % (125% speed)
        } elif (difficulty == DIFFICULTY_VERYHARD)
        {   delay = delay * 2 / 3; // 66.6'% (150% speed)
        }

        if (level)
        {   delay -= (delay / 100) * level; // remove level% of delay
            secondsperlevel = SECONDSPERLEVEL;

            number = 1;
            putnumber();
            for (i = 0; i <= 3; i++)
            {   if (!worm[i].lives && worm[i].control != NONE)
                {   /* create (or resurrect) a worm */
                    worm[i].lives      = (difficulty == DIFFICULTY_EASY) ? STARTLIVES_EASY : STARTLIVES_NORMAL;
                    worm[i].alive      = TRUE;
                    worm[i].multi      = 1;
                    worm[i].last       = FIRSTTAIL + i;
                    worm[i].nextlife   = lifemodulo[difficulty];

                    worm[i].affixer    =
                    worm[i].autojump   =
                    worm[i].autoturn   =
                    worm[i].brakes     =
                    worm[i].backwards  =
                    worm[i].encloser   =
                    worm[i].flashed    =
                    worm[i].forwards   =
                    worm[i].frosted    =
                    worm[i].grenade    =
                    worm[i].pusher     =
                    worm[i].rammed     =
                    worm[i].remnants   =
                    worm[i].sideshot   =
                    worm[i].wait       = FALSE;

                    worm[i].score      =
                    worm[i].oldscore   = 0; // SLONGs
                    worm[i].armour     =
                    worm[i].glow       =
                    worm[i].cutter     = 0; // SWORDs
                    worm[i].ammo       =
                    worm[i].power      = 0; // UBYTEs
                    worm[i].olddeltax  =
                    worm[i].olddeltay  = 0; // SBYTEs

                    for (j = 0; j <= PROTECTORS; j++)
                    {   protector[i][j].alive = FALSE;
                    }
                    for (j = 0; j <= LASTOBJECT; j++)
                    {   stat(i, j);
        }   }   }   }
        for (i = 0; i <= 3; i++)
        {   if (worm[i].control != NONE)
            {   for (j = 0; j <= LASTOBJECT; j++)
                {   icon(i, j);
    }   }   }   }

    if (level == 0)
    {   switch (bonustype)
        {
        case BONUSLEVEL_PATH:
            for (i = 0; i <= 3; i++)
            {   x = worm[i].x;
                y = worm[i].y;
                for (j = 0; j < 5; j++)
                {   x += worm[i].deltax;
                    y += worm[i].deltay;
                    change1(x, y, GOLD);
                }
                for (;;)
                {   patience = 0;
                    do
                    {   deltax = arand(2) - 1; // -1..+2
                        deltay = arand(2) - 1; // -1..+2
                    } while
                    (   (   (deltax ==  0              && deltay ==  0                             )
                         || (deltax == -worm[i].deltax && deltay == -worm[i].deltay                )
                         || (valid(x, y)               && field[x + deltax][y + deltay] == TEMPGOLD)
                        )
                     && ++patience < 50
                    );
                    if (patience >= 50)
                    {   break;
                    }
                    x += deltax;
                    y += deltay;
                    if (!valid(x, y))
                    {   break;
                    }
                    field[x][y] = TEMPGOLD;
            }   }
            for (x = 0; x <= fieldx; x++)
            {   for (y = 0; y <= fieldy; y++)
                {   if (field[x][y] == TEMPGOLD)
                    {   change1(x, y, GOLD);
            }   }   }
        acase BONUSLEVEL_JUMP:
            x = fieldx / 4;
            for (y = 0; y <= fieldy; y++)
            {   x += (arand(2) - 1);
                if (x < 0) x = 0; elif (x > fieldx) x = fieldx;
                change1(x, y, STONE);
            }
            x = fieldx / 4 * 3;
            for (y = 0; y <= fieldy; y++)
            {   x += (arand(2) - 1);
                if (x < 0) x = 0; elif (x > fieldx) x = fieldx;
                change1(x, y, STONE);
    }   }   }

    stopfx();
    clearkybd();
    resettime();
}

EXPORT UBYTE partner(UBYTE which)
{   if (which == 0)
    {   return 1;
    } else
    {   assert(which == 1);
        return 0;
}   }

EXPORT void putnumber(void)
{   int oldnumbery = numbery;

    do
    {   ;
    } while
    (   !findempty(&numberx, &numbery)
     && !findempty(&numberx, &numbery)
     && !findempty(&numberx, &numbery)
     && !findempty(&numberx, &numbery)
     && !findempty(&numberx, &numbery)
     && !findwall( &numberx, &numbery)
    );
    change1(numberx, numbery, (UWORD) (FIRSTNUMBER + number - 1));
    updatearrow(oldnumbery);
    updatearrow(numbery);
}

#if !defined(ANDROID) && !defined(GBA)
EXPORT FLAG savefields(STRPTR pathname)
{   SBYTE i, j, k,
          x, y;
    UBYTE IOBuffer[NAMELENGTH + 1];
    ULONG thecursor;
    FILE* LocalHandle /* = NULL */ ;

    if (!(LocalHandle = fopen(pathname, "wb")))
    {   return FALSE;
    }

    /* write header */

    strcpy((STRPTR) IOBuffer, "LSET 9.2");
    IOBuffer[9] = (UBYTE) levels;
    DISCARD fwrite(IOBuffer, 10, 1, LocalHandle);

    /* write high score table */

    for (i = 0; i <= 3; i++)
    {   for (j = 0; j <= HISCORES; j++)
        {   IOBuffer[0]     = (UBYTE)   hiscore[i][j].player;
            IOBuffer[1]     = (UBYTE)   hiscore[i][j].level;
            IOBuffer[2]     = (UBYTE)  (hiscore[i][j].score / 16777216);
            IOBuffer[3]     = (UBYTE) ((hiscore[i][j].score % 16777216) / 65536);
            IOBuffer[4]     = (UBYTE) ((hiscore[i][j].score %    65536) /   256);
            IOBuffer[5]     = (UBYTE)  (hiscore[i][j].score %      256);
            DISCARD fwrite(IOBuffer, 6, 1, LocalHandle);
            for (k = 0; k <= NAMELENGTH; k++)
            {   IOBuffer[k] = (UBYTE) hiscore[i][j].name[k];
            }
            DISCARD fwrite(IOBuffer, NAMELENGTH + 1, 1, LocalHandle);
            for (k = 0; k <= TIMELENGTH; k++)
            {   IOBuffer[k] = (UBYTE) hiscore[i][j].time[k];
            }
            DISCARD fwrite(IOBuffer, TIMELENGTH + 1, 1, LocalHandle);
            for (k = 0; k <= DATELENGTH; k++)
            {   IOBuffer[k] = (UBYTE) hiscore[i][j].date[k];
            }
            DISCARD fwrite(IOBuffer, DATELENGTH + 1, 1, LocalHandle);
    }   }

    /* write level data */

    for (i = 0; i <= levels; i++)
    {   thefile[0] = (UBYTE) startx[i];
        thefile[1] = (UBYTE) starty[i];

        thecursor = 2;
        for (y = 0; y <= MINFIELDY; y++)
        {   for (x = 0; x <= MINFIELDX; x += 2)
            {   switch (board[i][x][y])
                {
                case  EMPTY:     thefile[thecursor] = (UBYTE)  1 * 16;
                acase SILVER:    thefile[thecursor] = (UBYTE)  2 * 16;
                acase GOLD:      thefile[thecursor] = (UBYTE)  3 * 16;
                acase DYNAMITE:  thefile[thecursor] = (UBYTE)  4 * 16;
                acase WOOD:      thefile[thecursor] = (UBYTE)  5 * 16;
                acase STONE:     thefile[thecursor] = (UBYTE)  6 * 16;
                acase METAL:     thefile[thecursor] = (UBYTE)  7 * 16;
                acase FROST:     thefile[thecursor] = (UBYTE)  8 * 16;
                acase ARROWUP:   thefile[thecursor] = (UBYTE)  9 * 16;
                acase ARROWDOWN: thefile[thecursor] = (UBYTE) 10 * 16;
                acase SLIME:     thefile[thecursor] = (UBYTE) 11 * 16;
                adefault:        thefile[thecursor] = (UBYTE)  0 * 16;
                }
                if (x < MINFIELDX)
                {   switch (board[i][x + 1][y])
                    {
                    case  EMPTY:     thefile[thecursor] +=  1;
                    acase SILVER:    thefile[thecursor] +=  2;
                    acase GOLD:      thefile[thecursor] +=  3;
                    acase DYNAMITE:  thefile[thecursor] +=  4;
                    acase WOOD:      thefile[thecursor] +=  5;
                    acase STONE:     thefile[thecursor] +=  6;
                    acase METAL:     thefile[thecursor] +=  7;
                    acase FROST:     thefile[thecursor] +=  8;
                    acase ARROWUP:   thefile[thecursor] +=  9;
                    acase ARROWDOWN: thefile[thecursor] += 10;
                    acase SLIME:     thefile[thecursor] += 11;
                    adefault:   ; // thefile[thecursor] +=  0;
                }   }
                thecursor++;
        }   }

        assert(thecursor == PERLEVEL);
        DISCARD fwrite((UBYTE *) thefile, thecursor, 1, LocalHandle);
    }

    /* write version string */
    DISCARD fwrite((UBYTE *) VERSION, strlen(VERSION), 1, LocalHandle);
    fclose(LocalHandle); // LocalHandle = NULL;

    levels_modified = scores_modified = FALSE;
    return TRUE;
}
#endif

EXPORT void saylevel(COLOUR colour)
{   if (level > 0)
    {   sprintf
        (   leveltext,
            (STRPTR) GetCatalogStr
            (   CatalogPtr,
                MSG_LEVEL,
                "Level %d of %d"
            ),
            level,
            levels
        );
        say(leveltext, colour);
    } elif (a == LEVELEDIT)
    {   say((STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUSLEVEL, "Bonus Level"), colour);
    } else
    {   say(bonustext[bonustype], colour);
}   }

MODULE UBYTE slowdown(UBYTE speed, int player, FLAG brakes, FLAG stoppable)
{   if (speed < 64)
    {   speed *= 2;
    } else speed = 127;
    if (player != -1 && speed > SPEED_SLOW)
    {   if (worm[player].score >= players && (brakes || (difficulty == DIFFICULTY_EASY && stoppable)))
        {   speed = 0;
        } else speed = SPEED_SLOW;
    }
    return speed;
}

MODULE void slowloop(void)
{   FLAG  ok;
    SBYTE i;
    UBYTE which;
    UWORD chance;
    int   player,
          x, xx, y, yy;

    if (ice)
    {   ice--;
    }

    // decrement worm strength
    for (player = 0; player <= 3; player++)
    {   if (worm[player].lives)
        {   if (worm[player].cutter > 0)
            {   worm[player].cutter--;
                icon(player, CUTTER);
            }
            if (worm[player].glow > 0)
            {   worm[player].glow--;
                icon(player, GLOW);
            }
            if (worm[player].armour > 0)
            {   worm[player].armour--;
                icon(player, ARMOUR);
    }   }   }

    for (i = 0; i < POINTSLOTS; i++)
    {   if (point[i].time)
        {   point[i].time--;
            if (point[i].time == 0)
            {   draw(point[i].x, point[i].y, point[i].final);
        }   }
        else
        {   break; // for speed
    }   }

    if (!ice)
    {   if (level)
        {   for (i = 0; i <= SPECIES; i++)
            {   if (creatureinfo[sortcreatures[i]].freq == 0 || (difficulty == DIFFICULTY_EASY && level < creatureinfo[sortcreatures[i]].introlevel))
                {   continue;
                }

                if (creatureinfo[sortcreatures[i]].freq - (level * FREQFACTOR) > 20)
                {   chance = creatureinfo[sortcreatures[i]].freq - (level * FREQFACTOR);
                } else
                {   chance = 20;
                }
                if
                (   (   difficulty == DIFFICULTY_EASY
                     && level      == creatureinfo[sortcreatures[i]].introlevel
                    )
                 ||     difficulty == DIFFICULTY_HARD
                )
                {   chance /= 3;
                } elif (difficulty == DIFFICULTY_VERYHARD)
                {   chance /= 4;
                }

                if (!arand(chance))
                {   switch (creatureinfo[sortcreatures[i]].symbol)
                    {
                    case BIRD:
                        if (findempty(&x, &y))
                        {   // check whether this location is far enough away from the worms
                            ok = TRUE;
                            for (player = 0; player <= 3; player++)
                            {   if
                                (   worm[player].lives
                                 && abs(worm[player].x - x) < DISTANCE_BIRD * 2
                                 && abs(worm[player].y - y) < DISTANCE_BIRD * 2
                                )
                                {   ok = FALSE;
                                    break;
                            }   }
                            if (ok)
                            {   for (which = 0; which <= CREATURES; which++)
                                {   if (!creature[which].alive)
                                    {   createcreature(BIRD, which, x, y, 0, 0, -1, ANYTHING, ANYTHING);
                                        break;
                        }   }   }   }
                    acase CLOUD:
                        createcloud();
                    acase RABBIT:
                        createrabbit();
                    acase SPIDER:
                        x = arand((ULONG) fieldx);
                        if (isempty(x, 0))
                        {   for (which = 0; which <= CREATURES; which++)
                            {   if (!creature[which].alive)
                                {   createcreature(SPIDER, which, x, 0, 0, 0, -1, ANYTHING, ANYTHING);
                                    break;
                        }   }   }
                    adefault:
                        if
                        (   ( creatureinfo[sortcreatures[i]].wall && findwall( &x, &y))
                         || (!creatureinfo[sortcreatures[i]].wall && findempty(&x, &y))
                        )
                        {   for (which = 0; which <= CREATURES; which++)
                            {   if (!creature[which].alive)
                                {   createcreature(creatureinfo[sortcreatures[i]].symbol, which, x, y, 0, 0, -1, ANYTHING, ANYTHING);
                                    break;
            }   }   }   }   }   }

            /* create slime */
            if (!arand(FREQ_SLIME) && findempty(&x, &y))
            {   change1(x, y, SLIME);
            }
            /* grow slime */
            if (!arand(FREQ_SLIMEGROW))
            {   for (x = 0; x <= fieldx; x++)
                {   for (y = 0; y <= fieldy; y++)
                    {   if (field[x][y] == SLIME)
                        {   for (xx = x - 1; xx <= x + 1; xx++)
                            {   for (yy = y - 1; yy <= y + 1; yy++)
                                {   if (valid(xx, yy) && field[xx][yy] == EMPTY && !arand(1))
                                    {   field[xx][yy] = TEMPSLIME;
                }   }   }   }   }   }
                for (x = 0; x <= fieldx; x++)
                {   for (y = 0; y <= fieldy; y++)
                    {   if (field[x][y] == TEMPSLIME)
                        {   change1(x, y, SLIME);
        }   }   }   }   }
        else
        {   switch (bonustype)
            {
            case BONUSLEVEL_BANANAS:
                if (!arand(3) && findempty(&x, &y))
                {   for (which = 0; which <= CREATURES; which++)
                    {   if (!creature[which].alive)
                        {   createcreature(MONKEY, which, x, y, 0, 0, -1, ANYTHING, ANYTHING);
                            break;
                }   }   }
            acase BONUSLEVEL_RAIN:
                if (!arand(3))
                {   createcloud();
                }
            acase BONUSLEVEL_ORBS:
                if (!arand(3) && findempty(&x, &y))
                {   for (which = 0; which <= CREATURES; which++)
                    {   if (!creature[which].alive)
                        {   createcreature(ORB, which, x, y, 0, 0, -1, ANYTHING, ANYTHING);
                            break;
                }   }   }
            acase BONUSLEVEL_BUTTERFLIES:
                if (!arand(3) && findempty(&x, &y))
                {   for (which = 0; which <= CREATURES; which++)
                    {   if (!creature[which].alive)
                        {   createcreature(BUTTERFLY, which, x, y, 0, 0, -1, ANYTHING, ANYTHING);
                            break;
                }   }   }
            acase BONUSLEVEL_RABBITS:
                if (!arand(3))
                {   createrabbit();
                }
            acase BONUSLEVEL_DOGS:
                if (!arand(3) && findempty(&x, &y))
                {   for (which = 0; which <= CREATURES; which++)
                    {   if (!creature[which].alive)
                        {   createcreature(DOG, which, x, y, 0, 0, -1, ANYTHING, ANYTHING);
                            break;
                }   }   }
            acase BONUSLEVEL_SNAKES:
                if (!arand(3) && findempty(&x, &y))
                {   for (which = 0; which <= CREATURES; which++)
                    {   if (!creature[which].alive)
                        {   createcreature(SNAKE, which, x, y, 0, 0, -1, ANYTHING, ANYTHING);
                            break;
                }   }   }
            acase BONUSLEVEL_BULLS:
                if (!arand(3) && findempty(&x, &y))
                {   for (which = 0; which <= CREATURES; which++)
                    {   if (!creature[which].alive)
                        {   createcreature(BULL, which, x, y, 0, 0, -1, ANYTHING, ANYTHING);
                            break;
        }   }   }   }   }

        /* create objects */
        for (which = 0; which <= LASTOBJECT; which++)
        {   if ((level || which == TREASURE) && (difficulty != DIFFICULTY_EASY || level >= objectinfo[which].introlevel))
            {   if  (difficulty == DIFFICULTY_VERYHARD)
                {   chance = objectinfo[which].freq * 2 / 5; // 40%
                } elif
                (   (difficulty == DIFFICULTY_EASY && level == objectinfo[which].introlevel)
                 ||  difficulty == DIFFICULTY_HARD
                )
                {   chance = objectinfo[which].freq / 2; // 50%
                } else
                {   chance = objectinfo[which].freq;
                }
                if (!arand(chance) && findempty(&x, &y))
                {   change1(x, y, which);
            }   }
            elif
            (   which != UMBRELLA
             && bonustype == BONUSLEVEL_TREASURY
             && !arand(objectinfo[which].freq / 5)
             && findempty(&x, &y)
            )
            {   change1(x, y, which);
        }   }

        // create cherries
        if (!level && bonustype == BONUSLEVEL_CHERRIES)
        {   if (!arand(3) && findempty(&x, &y))
            {   change1(x, y, (UWORD) (FIRSTCHERRY + arand(3)));
        }   }

        // create fruit
        if
        (   level >= 1
         && !wasfruit
         && !arand(FREQ_FRUIT)
         && findempty(&x, &fruity)
        )
        {   wasfruit = isfruit = TRUE;
            whichfruit = (UBYTE) arand((ULONG) level - 1);
            if (whichfruit > LASTFRUIT - FIRSTFRUIT)
            {   whichfruit = LASTFRUIT - FIRSTFRUIT;
            }
            whichfruit += FIRSTFRUIT;
            change1(x, fruity, whichfruit);
            updatearrow(fruity);
        }

        /* create teleports */
        if
        (   !arand(FREQ_TELEPORT)
         && !teleports
         && findempty(&teleport[0].x, &teleport[0].y)
         && findempty(&teleport[1].x, &teleport[1].y)
         && (teleport[0].x != teleport[1].x || teleport[0].y != teleport[1].y)
        )
        {   teleports = TRUE;
            change1(teleport[0].x, teleport[0].y, TELEPORT);
            change1(teleport[1].x, teleport[1].y, TELEPORT);
}   }   }

EXPORT UBYTE speedup(UBYTE speed, int player)
{   if (speed == SPEED_STOPPED)
    {   speed = SPEED_SLOW;
    } elif (speed >= 2)
    {   speed /= 2;
    }
    if (player != -1)
    {   if (difficulty == DIFFICULTY_EASY && speed < SPEED_NORMAL)
        {   speed = SPEED_NORMAL;
        } elif (speed < SPEED_FAST)
        {   speed = SPEED_FAST;
    }   }

    return speed;
}

EXPORT void squareblast(UBYTE triggerer, int player, UWORD c, int x, int y, FLAG cutter, FLAG superbomb)
{   UBYTE which;
    UBYTE filler;

    if (superbomb)
    {   assert(!cutter);
        filler = DYNAMITE;
    } else filler = EMPTY;

    if (c <= LASTOBJECT)
    {   if (!cutter)
        {   change1(x, y, filler);
    }   }
    elif
    (   (c >= FIRSTTAIL && c <= LASTTAIL)
     ||  c == WOOD
     ||  c == SLIME
     ||  c == FROST
     || (superbomb && c >= FIRSTGLOW && c <= LASTGLOW)
    )
    {   change1(x, y, filler);
    } elif (!cutter && c >= FIRSTFRUIT && c <= LASTFRUIT)
    {   isfruit = FALSE;
        change1(x, y, filler);
        updatearrow(y);
    } elif (c >= FIRSTHEAD && c <= LASTHEAD)
    {   if (!cutter && (triggerer != HEAD || player != c - FIRSTHEAD))
        {   if (worm[c - FIRSTHEAD].armour == 0)
            {   if (superbomb)
                {   worm[c - FIRSTHEAD].cause = SUPERBOMB;
                } else
                {   worm[c - FIRSTHEAD].cause = MINIBOMB;
                }
                worm[c - FIRSTHEAD].alive = FALSE;
            } else
            {   effect(FXUSE_ARMOUR);
    }   }   }
    elif (c == MISSILE_C)
    {   which = whichcreature(x, y, MISSILE_C, 255);
        if (!cutter)
        {   if (triggerer == HEAD)
            {   if (player != c - FIRSTMISSILE)
                {   wormkillcreature(player, which, TRUE);
        }   }   }
        else
        {   creature[which].alive = FALSE;
            change1(x, y, filler);
    }   }
    elif (c >= FIRSTCREATURE && c <= LASTCREATURE && !cutter)
    {   which = whichcreature(x, y, c, 255);
        if (creature[which].player != player)
        {   if (triggerer == HEAD)
            {   wormkillcreature(player, which, TRUE);
            } else
            {   creature[which].alive = FALSE;
                change1(x, y, filler);
}   }   }   }

EXPORT void timeloop(void)
{   TRANSIENT UBYTE i;
    TRANSIENT int   patience,
                    x, y;
    PERSIST   FLAG  expired = FALSE;

    secondsleft = atleast(secondsleft, 0);

    if (!level)
    {   if (secondsleft <= 2 || !(secondsleft % 2))
        {   sprintf
            (   leveltext,
                "%d:%02d",
                secondsleft / 60,
                secondsleft % 60
            );
            say(leveltext, worm[treasurer].colour);
        } else
        {   say(bonustext[bonustype], worm[treasurer].colour);
        }
        if (!secondsleft)
        {   level = reallevel + 1;
            secondsleft = SECONDSPERLEVEL;
            newlevel(treasurer);
    }   }
    elif (!secondsleft)
    {   if (!expired)
        {   effect(FXSIREN);
            say((STRPTR) GetCatalogStr(CatalogPtr, MSG_TIMEEXPIRED, "Time expired!"), WHITE);
            expired = TRUE;

            delay = delay * 3 / 4;

            if (difficulty != DIFFICULTY_VERYHARD)
            {   assert(players >= 1 && players <= 4);
                for (i = 1; i <= players; i++)
                {   patience = 0;
                    do
                    {   x = (SBYTE) (arand((ULONG) fieldx - 10)) + 5; // not too close to x-edges
                        y = (SBYTE)  arand((ULONG) fieldy);
                    } while ((field[x][y] < FIRSTEMPTY || field[x][y] > LASTEMPTY) && ++patience < PATIENCE);
                    if (patience < PATIENCE)
                    {   change1(x, y, START);
            }   }   }

            // create otters
            for (i = 0; i <= CREATURES; i++)
            {   if (!creature[i].alive)
                {   for (y = 0; y <= fieldy - 1; y++)
                    {   if (field[0][y] >= FIRSTEMPTY && field[0][y] <= LASTEMPTY)
                        {   createcreature(OTTER, i, 0,      y, 0,  1, -1, ANYTHING, ANYTHING);
                            break;
                    }   }
                    break;
            }   }
            for (i = 0; i <= CREATURES; i++)
            {   if (!creature[i].alive)
                {   for (y = fieldy; y >= 1; y--)
                    {   if (field[fieldx][y] >= FIRSTEMPTY && field[fieldx][y] <= LASTEMPTY)
                        {   createcreature(OTTER, i, (SBYTE) fieldx, y, 0, -1, -1, ANYTHING, ANYTHING);
                            break;
                    }   }
                    break;
    }   }   }   }
    else
    {   if (secondsleft <= 5)
        {   effect(FXSIREN);
        }
        expired = FALSE;

        sprintf
        (   leveltext,
            GetCatalogStr(CatalogPtr, MSG_LEVEL, "Level %d of %d"),
            level,
            levels
        );
        sprintf
        (   ENDOF(leveltext),
            " - %d:%02d",
            secondsleft / 60,
            secondsleft % 60
        );
        say(leveltext, WHITE);
}   }

EXPORT void train(SCANCODE scancode)
{
#if defined(ANDROID) || defined(GBA)
    ;
#else
    int i,
        x, y;

    switch (scancode)
    {
    case SCAN_HELP:
        trainer = trainer ? FALSE : TRUE;
    acase SCAN_NUMERICSLASH:
        if (trainer)
        {   trainer = FALSE;
            endoflevel();
        }
    acase SCAN_NUMERICASTERISK:
        // field[][] dump, for debugging purposes
        if (trainer)
        {   trainer = FALSE;
            say("Field...", PURPLE);
            for (x = 0; x <= fieldx; x++)
            {   for (y = 0; y <= fieldy; y++)
                {   draw(x, y, field[x][y]);
            }   }
            anykey(FALSE, FALSE);
            say("Graphics...", PURPLE);
            for (x = 0; x <= fieldx; x++)
            {   for (y = 0; y <= fieldy; y++)
                {   draw(x, y, gfxfield[x][y]);
            }   }
            anykey(FALSE, FALSE);
        }
    acase SCAN_NUMERICMINUS:
        if (trainer)
        {   trainer = FALSE;
            say("Tiyla rules!", PURPLE);
            for (i = 0; i <= ARRAYSIZE; i++)
            {   draw((SBYTE) (i % 16), (SBYTE) (i / 16), (UWORD) i);
            }
            anykey(FALSE, FALSE);
        }
    acase SCAN_NUMERICPLUS:
        if (trainer)
        {   trainer = FALSE;
            if (worm[1].lives)
            {   say("Xenia rules!", PURPLE);
                anykey(FALSE, FALSE);

                worm[1].lives = LIVESLIMIT;
                stat(1, MINIHEALER);
                worm[1].ammo = AMMOLIMIT;
                stat(1, AMMO);
                worm[1].power = POWERLIMIT;
                stat(1, POWER);
                worm[1].brakes = TRUE;
                stat(1, BRAKES);

                worm[1].affixer   =
                worm[1].backwards =
                worm[1].forwards  =
                worm[1].grenade   =
                worm[1].remnants  =
                worm[1].sideshot  =
                worm[1].pusher    =
                worm[1].encloser  =
                worm[1].autojump  =
                worm[1].autoturn  = TRUE;

                worm[1].armour    = ARMOURLIMIT;
                worm[1].glow      = GLOWLIMIT;
                worm[1].cutter    = CUTTERLIMIT;

                for (i = 0; i <= LASTOBJECT; i++)
                {   icon(1, i);
    }   }   }   }
#endif
}

EXPORT void turnworm(int player, int deltax, int deltay)
{   // assert(player >= 0 && player <= 3);

    if (worm[player].deltax == deltax && worm[player].deltay == deltay)
    {   worm[player].speed = speedup(worm[player].speed, player);
        stat(player, BRAKES);
    } elif (worm[player].deltax == -deltax && worm[player].deltay == -deltay)
    {   worm[player].speed = slowdown(worm[player].speed, player, worm[player].brakes, FALSE);
        stat(player, BRAKES);
    } else
    {   worm[player].deltax = deltax;
        worm[player].deltay = deltay;
}   }

EXPORT FLAG valid(int x, int y)
{   if (x < 0 || y < 0)
    {   return FALSE;
    } elif (a == LEVELEDIT)
    {   if (x > MINFIELDX || y > MINFIELDY)
        {   return FALSE;
        } else return TRUE;
    } else
    {   assert(a != LEVELEDIT);
        if (x > fieldx || y > fieldy)
        {   return FALSE;
        } else return TRUE;
}   }

EXPORT void wormscore(int player, SLONG score)
{   if (score >= 0)
    {   worm[player].score += score * players * worm[player].multi;
    } else
    {   worm[player].score += score * players;
    }
    stat(player, BONUS);
}
EXPORT void wormscore_unscaled(int player, SLONG score)
{   if (score >= 0)
    {   worm[player].score += score;
    } else
    {   worm[player].score += score;
    }
    stat(player, BONUS);
}

EXPORT int xwrap(int x)
{   if (x < 0)
    {   x += fieldx + 1;
    } elif (x > fieldx)
    {   x -= fieldx + 1;
    }
    return x;
}
EXPORT int ywrap(int y)
{   if (y < 0)
    {   y += fieldy + 1;
    } elif (y > fieldy)
    {   y -= fieldy + 1;
    }
    return y;
}

MODULE void ramming(int player)
{   SBYTE i;

    worm[player].rammed = TRUE;
    worm[player].x = xwrap(worm[player].x - worm[player].deltax);
    worm[player].y = ywrap(worm[player].y - worm[player].deltay);
    for (i = 0; i <= PROTECTORS; i++)
    {   /* no point checking whether the protectors are alive or dead */
        protector[player][i].x -= worm[player].deltax;
        protector[player][i].y -= worm[player].deltay;
    }
    worm[player].speed = slowdown(worm[player].speed, player, worm[player].brakes, TRUE);
    stat(player, BRAKES);
}

MODULE SWORD atleast(SWORD value, SWORD minimum)
{   if (value < minimum)
        return minimum;
    else return value;
}

EXPORT void change1(int x, int y, UWORD image)
{   // assert(valid(x, y));
    field[x][y] = gfxfield[x][y] = image;
    draw(x, y, image);
}

EXPORT void change2(int x, int y, UWORD real, UWORD gfximage)
{   // assert(valid(x, y));
    field[x][y] = real;
    gfxfield[x][y] = gfximage;
    draw(x, y, gfximage);
}

/* header
    TEXT[] "LSET 9.2" (NULL-terminated)
    SBYTE  levels;
high score table
    for (difficulty = 0; difficulty <= 3; difficulty++)
    {   for (slot = 0; slot <= HISCORES; slot++)
        {   SBYTE  hiscore[difficulty][slot].player,
                   hiscore[difficulty][slot].level;
            SLONG  hiscore[difficulty][slot].score;
            TEXT[] hiscore[difficulty][slot].name (NULL-terminated)
            TEXT[] hiscore[difficulty][slot].time (NULL-terminated)
            TEXT[] hiscore[difficulty][slot].date (NULL-terminated)
    }   }
level data
    for (level = 0; level <= levels; level++)
    {   SBYTE startx[level],
              starty[level];

        for (y = 0; y <= MINFIELDY; y++)
        {   for (x = 0; x <= MINFIELDX; x += 2)
            {   bits 31..16: board[level][x][y];
                bits 15.. 0: board[level][x + 1][y];
    }   }   }
version string
   TEXT[]         "$VER: Worm Wars x.x (dd.mm.yy)" (NULL-terminated) */

MODULE void wormworm(int x, int y, int player1, int player2)
{   if (worm[player1].armour == 0 && worm[player2].armour == 0)
    {   /* both worms die */
        worm[player1].cause  = FIRSTHEAD + player2;
        worm[player1].alive  = FALSE;
        worm[player2].cause  = FIRSTHEAD + player1;
        worm[player2].alive  = FALSE;
    } elif (worm[player1].armour > 0 && worm[player2].armour == 0)
    {   /* 1st worm lives, 2nd worm dies  */
        worm[player2].cause  = FIRSTHEAD + player1;
        worm[player2].alive  = FALSE;
    } elif (worm[player1].armour == 0 && worm[player2].armour > 0)
    {   /* 1st worm dies, 2nd worm lives */
        worm[player1].cause  = FIRSTHEAD + player2;
        worm[player1].alive  = FALSE;
}   }

EXPORT void protworm(int x, int y, int player1, int player2)
{   SBYTE i, j = -1; // to prevent spurious warnings

    for (i = 0; i <= PROTECTORS; i++)
    {    if (protector[player1][i].alive && protector[player1][i].x == x && protector[player1][i].y == y)
         {    j = i;
              break;
    }    }

    if (player1 != player2)
    {   if (worm[player2].armour == 0)
        {   effect(FXBORN_PROTECTOR);
            worm[player2].cause  = FIRSTPROTECTOR + player1;
            worm[player2].alive  = FALSE;
        } else
        {   effect(FXUSE_ARMOUR);
            protector[player1][j].visible = FALSE;
    }   }
    else
    {   /* protector is over worm's own head; caused by ramming */
        protector[player1][j].visible = FALSE;
}   }

EXPORT void icon(int player, int image)
{
#if defined(ANDROID) || defined(GBA)
    int  theval;
#endif
#ifdef ANDROID
    FLAG started;
#endif
    int  x = -3,
         y = (player * 10) + 5;

/*  x-2      x-1      x         x+1       x+2
 y  Affixer  Grenade  Forwards  Autojump  Glow
y+1 Encloser Remnants Sideshot  Autoturn  Armour
y+2 Pusher            Backwards           Cutter
*/

#ifdef GBA
    // assert(player == 0);
    switch (image)
    {
    case BONUS:
        theval = worm[player].score % 10000000; // ten million
        draw(ARROWX, 0, getdigit(theval /  1000000)); // one million
        theval %=  1000000; // one million
        draw(ARROWX, 1, getdigit(theval /   100000)); // one hundred thousand
        theval %=   100000; // one hundred thousand
        draw(ARROWX, 2, getdigit(theval /    10000)); // ten thousand
        theval %=    10000; // ten thousand
        draw(ARROWX, 3, getdigit(theval /     1000)); // one thousand
        theval %=     1000; // one thousand
        draw(ARROWX, 4, getdigit(theval /      100));
        theval %=      100;
        draw(ARROWX, 5, getdigit(theval /       10));
        theval %=       10;
        draw(ARROWX, 6, getdigit(theval));
    acase MINIHEALER:
        theval = worm[player].lives;
        draw(ARROWX, 11, getdigit(theval / 10));
        theval %= 10;
        draw(ARROWX, 12, getdigit(theval));
    }
    return;
#else
    switch (image)
    {
    // quantities
#ifdef ANDROID
    case  BONUS:
        theval = worm[player].score % 10000000; // ten million
        if (theval >= 1000000) // one million
        {   drawstat(0, 0, getdigit(theval /  1000000), player); // one million
            started = TRUE;
        } else
        {   drawstat(0, 0, BONUS, player);
            started = FALSE;
        }
        theval %=  1000000; // one million
        if (started || theval >=  100000) // one hundred thousand
        {   drawstat(1, 0, getdigit(theval /   100000), player); // one hundred thousand
            started = TRUE;
        } else
        {   drawstat(1, 0, BLACKENED, player);
        }
        theval %=   100000; // one hundred thousand
        if (started || theval >=   10000) // ten thousand
        {   drawstat(2, 0, getdigit(theval /    10000), player); // ten thousand
            started = TRUE;
        } else
        {   drawstat(2, 0, BLACKENED, player);
        }
        theval %=    10000; // ten thousand
        if (started || theval >=    1000) // one thousand
        {   drawstat(3, 0, getdigit(theval /     1000), player); // one thousand
            started = TRUE;
        } else
        {   drawstat(3, 0, BLACKENED, player);
        }
        theval %=     1000; // one thousand
        if (started || theval >=     100)
        {   drawstat(4, 0, getdigit(theval /      100), player);
            started = TRUE;
        } else
        {   drawstat(4, 0, BLACKENED, player);
        }
        theval %=      100;
        if (started || theval >=      10)
        {   drawstat(5, 0, getdigit(theval /       10), player);
            // started = TRUE;
        } else
        {   drawstat(5, 0, BLACKENED, player);
        }
        theval %=       10;
        drawstat(6, 0, getdigit(theval), player);
    acase MINIHEALER:
        drawstat(0, 1, MINIHEALER, player);
        theval = worm[0].lives;
        if (theval >= 10)
        {   drawstat(5, 1, getdigit(theval / 10), player);
            theval %= 10;
        } else
        {   drawstat(5, 1, BLACKENED, player);
        }
        drawstat(6, 1, getdigit(theval), player);
    acase BRAKES:
        drawstat(0, 2, BRAKES, player);
        if (worm[player].speed >  SPEED_STOPPED) drawstat(6, 2, BRAKES, player); else drawstat(6, 2, BLACKENED, player);
        if (worm[player].speed <= SPEED_SLOW   ) drawstat(5, 2, BRAKES, player); else drawstat(5, 2, BLACKENED, player);
        if (worm[player].speed <= SPEED_NORMAL ) drawstat(4, 2, BRAKES, player); else drawstat(4, 2, BLACKENED, player);
        if (worm[player].speed <= SPEED_FAST   ) drawstat(3, 2, BRAKES, player); else drawstat(3, 2, BLACKENED, player);
    acase AMMO:
        drawstat(0, 3, AMMO, player);
        theval = worm[player].ammo;
        if (theval >= 10)
        {   drawstat(5, 3, getdigit(theval / 10), player);
            theval %= 10;
        } else
        {   drawstat(5, 3, BLACKENED, player);
        }
        drawstat(6, 3, getdigit(theval), player);
    acase POWER:
        drawstat(0, 4, POWER, player);
        drawstat(6, 4, POWER, player);
        if (worm[player].power >= 3) drawstat(5, 4, POWER, player); else drawstat(5, 4, BLACKENED, player);
        if (worm[player].power >= 5) drawstat(4, 4, POWER, player); else drawstat(4, 4, BLACKENED, player);
        if (worm[player].power >= 7) drawstat(3, 4, POWER, player); else drawstat(3, 4, BLACKENED, player);
    // booleans
    acase AFFIXER:    drawstat(1, 6, (UWORD) (worm[player].affixer   ? AFFIXER   : GHOSTAFFIXER  ), player);
    acase ENCLOSER:   drawstat(1, 7, (UWORD) (worm[player].encloser  ? ENCLOSER  : GHOSTENCLOSER ), player);
    acase PUSHER:     drawstat(1, 8, (UWORD) (worm[player].pusher    ? PUSHER    : GHOSTPUSHER   ), player);
    acase GRENADE:    drawstat(2, 6, (UWORD) (worm[player].grenade   ? GRENADE   : GHOSTGRENADE  ), player);
    acase REMNANTS:   drawstat(2, 7, (UWORD) (worm[player].remnants  ? REMNANTS  : GHOSTREMNANTS ), player);
    acase FORWARDS:   drawstat(3, 6, (UWORD) (worm[player].forwards  ? FORWARDS  : GHOSTFORWARDS ), player);
    acase SIDESHOT:   drawstat(3, 7, (UWORD) (worm[player].sideshot  ? SIDESHOT  : GHOSTSIDESHOT ), player);
    acase BACKWARDS:  drawstat(3, 8, (UWORD) (worm[player].backwards ? BACKWARDS : GHOSTBACKWARDS), player);
    acase AUTOJUMP:   drawstat(4, 6, (UWORD) (worm[player].autojump  ? AUTOJUMP  : GHOSTAUTOJUMP ), player);
    acase AUTOTURN:   drawstat(4, 7, (UWORD) (worm[player].autoturn  ? AUTOTURN  : GHOSTAUTOTURN ), player);
    // decrementors
    acase GLOW:       if (worm[player].glow   > 10 || (worm[player].glow   && (!worm[player].lives || r % 4 <= 1))) drawstat(5, 6, GLOW  , player); else drawstat(5, 6, GHOSTGLOW  , player);
    acase ARMOUR:     if (worm[player].armour > 10 || (worm[player].armour && (!worm[player].lives || r % 4 <= 1))) drawstat(5, 7, ARMOUR, player); else drawstat(5, 7, GHOSTARMOUR, player);
    acase CUTTER:     if (worm[player].cutter > 10 || (worm[player].cutter && (!worm[player].lives || r % 4 <= 1))) drawstat(5, 8, CUTTER, player); else drawstat(5, 8, GHOSTCUTTER, player);
#else
    case  BONUS:      draw(x - 3, y - 5, BONUS);
    acase MINIHEALER: draw(x - 3, y - 4, MINIHEALER);
    acase BRAKES:     draw(x - 3, y - 3, BRAKES);
    acase AMMO:       draw(x - 3, y - 2, AMMO);
    acase POWER:      draw(x - 3, y - 1, POWER);
    // booleans
    acase AFFIXER:    draw(x - 2, y    , (UWORD) (worm[player].affixer   ? AFFIXER   : GHOSTAFFIXER  ));
    acase ENCLOSER:   draw(x - 2, y + 1, (UWORD) (worm[player].encloser  ? ENCLOSER  : GHOSTENCLOSER ));
    acase PUSHER:     draw(x - 2, y + 2, (UWORD) (worm[player].pusher    ? PUSHER    : GHOSTPUSHER   ));
    acase GRENADE:    draw(x - 1, y    , (UWORD) (worm[player].grenade   ? GRENADE   : GHOSTGRENADE  ));
    acase REMNANTS:   draw(x - 1, y + 1, (UWORD) (worm[player].remnants  ? REMNANTS  : GHOSTREMNANTS ));
    acase FORWARDS:   draw(x    , y    , (UWORD) (worm[player].forwards  ? FORWARDS  : GHOSTFORWARDS ));
    acase SIDESHOT:   draw(x    , y + 1, (UWORD) (worm[player].sideshot  ? SIDESHOT  : GHOSTSIDESHOT ));
    acase BACKWARDS:  draw(x    , y + 2, (UWORD) (worm[player].backwards ? BACKWARDS : GHOSTBACKWARDS));
    acase AUTOJUMP:   draw(x + 1, y    , (UWORD) (worm[player].autojump  ? AUTOJUMP  : GHOSTAUTOJUMP ));
    acase AUTOTURN:   draw(x + 1, y + 1, (UWORD) (worm[player].autoturn  ? AUTOTURN  : GHOSTAUTOTURN ));
    // decrementors
    acase ARMOUR:
        if
        (    worm[player].armour > 10
         || (worm[player].armour && (!worm[player].lives || r % 4 <= 1))
        )
        {   draw(          x + 2, y + 1, ARMOUR);
        } else draw(       x + 2, y + 1, GHOSTARMOUR);
    acase CUTTER:
        if
        (    worm[player].cutter > 10
         || (worm[player].cutter && (!worm[player].lives || r % 4 <= 1))
        )
        {   draw(          x + 2, y + 2, CUTTER);
        } else draw(       x + 2, y + 2, GHOSTCUTTER);
    acase GLOW:
        if
        (    worm[player].glow   > 10
         || (worm[player].glow   && (!worm[player].lives || r % 4 <= 1))
        )
        {   draw(          x + 2, y    , GLOW);
        } else draw(       x + 2, y    , GHOSTGLOW);
#endif
    }
#endif
}

EXPORT void updatearrow(int arrowy)
{   UWORD image;

#ifdef GBA
    ;
#else
    image = getarrowimage(arrowy);
    draw(ARROWX, arrowy, image);
#endif
}

EXPORT UWORD getarrowimage(int arrowy)
{   UWORD rc;
    int   i,
          var = -1; // needs to hold negatives and all possible squares

    /* var of:    -2         : many there
                  -1         : nothing there
                 0-3         : just that worm
       FIRSTNUMBER-LASTNUMBER: just that number
       FIRSTFRUIT -LASTFRUIT : just that fruit */

    for (i = 0; i <= 3; i++)
    {   if
        (    worm[i].control != NONE
         &&  worm[i].y == arrowy
         && (worm[i].lives || field[worm[i].x][worm[i].y] == FIRSTGRAVE + i)
        )
        {   if (var == -1)
            {   var = (SWORD) i;
            } else
            {   var = -2;
    }   }   }
    if (level != 0 && numbery == arrowy)
    {   if (var == -1)
        {   var = (SWORD) FIRSTNUMBER + number - 1;
        } else
        {   var = -2;
    }   }
    if (isfruit && fruity == arrowy)
    {   if (var == -1)
        {   var = (SWORD) whichfruit;
        } else
        {   var = -2;
    }   }

    if   (    var == -2                                 ) rc = ALL;
    elif (    var == -1 || var == (SWORD) LASTNUMBER + 1) rc = BLACKARROW; // var may equal LASTNUMBER + 1 at end of level
    elif (   (var >= FIRSTNUMBER && var <= LASTNUMBER)
          || (var >= FIRSTFRUIT  && var <= LASTFRUIT )
         )                                                rc = var;
    else
    {   assert(var >= 0 && var <= 3);
        if (worm[var].lives)                              rc = FIRSTARROW + var;
        else                                              rc = FIRSTGRAVE + var;
    }

    return rc;
}

EXPORT void bangdynamite(int x, int y)
{   int xx, yy;

    // Infects (turns to bang-dynamite) all surrounding dynamite.

    for (xx = x - 1; xx <= x + 1; xx++)
    {   for (yy = y - 1; yy <= y + 1; yy++)
        {   if (valid(xx, yy) && field[xx][yy] == DYNAMITE)
            {   field[xx][yy] = BANGINGDYNAMITE;
}   }   }   }

EXPORT ULONG arand(ULONG number)
{   ULONG result;

    result = (ULONG) (rand() % (number + 1));
    return result;
}

/* NAME     align -- right-justify a string within another string
SYNOPSIS    align(STRPTR, SBYTE, TEXT);
FUNCTION    Moves all text in a string to the right, padding with
            spaces. Does not itself add a null terminator.
INPUTS      string - pointer to the string of text
              size - size in characters of the containing string
            filler - what to pad the left of the string with
NOTE        Null terminators are written over by this function, but that
            does not matter, because calling functions use Text() with an
            explicit length. This function only works with monospaced
            fonts. */

EXPORT void align(STRPTR string, SBYTE size, TEXT filler)
{   SBYTE i, theshift, length;

    length = (SBYTE) strlen((const char*) string);
    theshift = size - length;
    for (i = 1; i <= length; i++)
    {   *(string + size - i) = *(string + size - i - theshift);
    }
    for (i = 0; i <= theshift - 1; i++)
    {   *(string + i) = filler;
    }
    *(string + size) = EOS;
}

MODULE void ReadGameports(void)
{   ReadStandardJoystick(0);
    ReadStandardJoystick(1);
    ReadAdapterJoystick(2);
    ReadAdapterJoystick(3);
    ReadGamepads();
}

EXPORT FLAG getnumber(int player)
{   int x, y;

    /* This function returns TRUE if the final number (ie. 9) was gotten,
    otherwise FALSE.

    The calling function is responsible for calling putnumber() if it
    wants a new number to appear. */

    effect(FXDING);
    wormscore(player, POINTS_NUMBER * number);
    worm[player].numbers++;
    number++;

    if (number == 10)
    {   endoflevel();
        return TRUE;
    } // else
    if (findempty(&x, &y))
    {   change1(x, y, (UWORD) (FIRSTCHERRY + player));
    }
    return FALSE;
}

EXPORT SLONG wormobject(int player, int x, int y)
{   UWORD c = field[x][y],
          d;
    UBYTE i,
          generated = 0;
    int   rc,
          multiplier = 1,
          xx, xxx,
          yy, yyy;

    if (!valid(x, y)) // defensive programming
    {   return 0;

        /* AUTO TEXT temp1[SAYLIMIT + 1], temp2[8];

        strcpy(temp1, "BAD OBJECT AT x: ");
        stcl_d(temp2, x);
        strcat(temp1, temp2);
        strcat(temp1, ", y: ");
        stcl_d(temp2, y);
        strcat(temp1, temp2);
        strcat(temp1, "!");
        say(temp1, worm[player].colour);
        draw(fieldx + 1, 0, c); // indicates which object
        Delay(250);
        clearkybd();
        anykey(FALSE, FALSE); */
    }

    switch (c)
    {
    case BONUS:
        if (level != 0)
        {   getnumber(player);
            change1(numberx, numbery, (UWORD) (FIRSTNUMBER + number - 1));
            updatearrow(numbery);
        }
    acase AMMO:
        effect(FXGET_AMMO);
        worm[player].ammo += ADD_AMMO;
        if (worm[player].ammo > AMMOLIMIT)
        {   worm[player].ammo = AMMOLIMIT;
            multiplier = 2;
        }
        stat(player, AMMO);
    acase ARMOUR:
        effect(FXGET_OBJECT);
        worm[player].armour += ADD_ARMOUR + arand(RAND_ARMOUR);
        if (worm[player].armour > ARMOURLIMIT)
        {   worm[player].armour = ARMOURLIMIT;
            multiplier = 2;
        }
        icon(player, ARMOUR);
    acase BRAKES:
        effect(FXGET_OBJECT);
        if (worm[player].brakes)
        {   multiplier = 2;
        } else
        {   worm[player].brakes = TRUE;
            stat(player, BRAKES);
        }
    acase GRENADE:
        effect(FXGET_POWERUP);
        if (worm[player].grenade)
        {   multiplier = 2;
        } else
        {   worm[player].grenade = TRUE;
            icon(player, GRENADE);
        }
    acase MINIBOMB:
        draw(worm[player].x, worm[player].y, getimage_head(player));
        bombblast(HEAD, player, worm[player].x, worm[player].y, FALSE, 0);
    acase SUPERBOMB:
        draw(worm[player].x, worm[player].y, getimage_head(player));
        bombblast(HEAD, player, worm[player].x, worm[player].y, TRUE, 0);
    acase POWER:
        effect(FXGET_POWERUP);
        if (worm[player].power < POWERLIMIT)
        {   worm[player].power += 2;
            stat(player, POWER);
        } else
        {   multiplier = 2;
        }
    acase SLAYER:
        for (i = 0; i <= CREATURES; i++)
        {   if (creature[i].alive)
            {   wormkillcreature(player, i, TRUE);
        }   }
        for (i = 0; i <= 3; i++)
        {   if (player != (SBYTE) i && worm[i].armour == 0)
            {   worm[i].alive = FALSE;
                worm[i].cause = SLAYER;
        }   }
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   if (field[x][y] == SLIME)
                {   change1(x, y, DYNAMITE);
        }   }   }
    acase PROTECTOR:
        do
        {   rc = createprotector(player, (arand(1) * 2) - 1, (arand(1) * 2) - 1);
        } while (rc == 1);
        if (rc == 0)
        {   multiplier = 2;
        }
    acase MISSILE_O:
        for (i = 0; i <= CREATURES; i++)
        {   if (!creature[i].alive)
            {   createcreature(MISSILE_C, i, worm[player].x, worm[player].y, 0, 0, player, ANYTHING, ANYTHING);
                break;
        }   }
    acase MINIHEALER:
        effect(FXGET_OBJECT);
        worm[player].lives += ADD_MINIHEALER;
        if (worm[player].lives > LIVESLIMIT)
        {   worm[player].lives = LIVESLIMIT;
            multiplier = 2;
        }
        stat(player, MINIHEALER);
    acase MULTIPLIER:
        effect(FXGET_OBJECT);
        if (worm[player].multi < MULTILIMIT)
        {   worm[player].multi *= 2;
        } else
        {   multiplier = 2;
        }
    acase ICE:
        effect(FXGET_OBJECT);
        ice += ADD_ICE + arand(RAND_ICE);
    acase GROWER:
        effect(FXGET_GROWER);

        /* grow friendly glow */
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   if (field[x][y] == FIRSTGLOW + player)
                {   for (xx = x - 1; xx <= x + 1; xx++)
                    {   for (yy = y - 1; yy <= y + 1; yy++)
                        {   if
                            (   valid(xx, yy)
                             && field[xx][yy] == EMPTY
                            )
                            {   field[xx][yy] = TEMPGLOW;
        }   }   }   }   }   }

        /* grow dynamite */
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   if (field[x][y] == DYNAMITE)
                {   for (xx = x - 1; xx <= x + 1; xx++)
                    {   for (yy = y - 1; yy <= y + 1; yy++)
                        {   if
                            (   valid(xx, yy)
                             && (field[xx][yy] == EMPTY || field[xx][yy] == TEMPGLOW)
                            )
                            {   field[xx][yy] = TEMPDYNAMITE;
        }   }   }   }   }   }

        /* grow silver */
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   if (field[x][y] == SILVER)
                {   for (xx = x - 1; xx <= x + 1; xx++)
                    {   for (yy = y - 1; yy <= y + 1; yy++)
                        {   if
                            (   valid(xx, yy)
                             && (field[xx][yy] == EMPTY || field[xx][yy] == TEMPGLOW || field[xx][yy] == TEMPDYNAMITE)
                            )
                            {   field[xx][yy] = TEMPSILVER;
        }   }   }   }   }   }

        /* grow gold */
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   if (field[x][y] == GOLD)
                {   for (xx = x - 1; xx <= x + 1; xx++)
                    {   for (yy = y - 1; yy <= y + 1; yy++)
                        {   if
                            (   valid(xx, yy)
                             && (field[xx][yy] == EMPTY || field[xx][yy] == TEMPGLOW || field[xx][yy] == TEMPDYNAMITE || field[xx][yy] == TEMPSILVER)
                            )
                            {   field[xx][yy] = TEMPGOLD;
        }   }   }   }   }   }

        /* update field */
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   switch (field[x][y])
                {
                case  TEMPGOLD:     change1(x, y, GOLD);
                acase TEMPSILVER:   change1(x, y, SILVER);
                acase TEMPDYNAMITE: change1(x, y, DYNAMITE);
                acase TEMPGLOW:     change2(x, y, (UWORD) (FIRSTGLOW + player), (UWORD) (GG_ALL + (player * 58)));
        }   }   }
    acase TAMER:
        for (i = 0; i <= CREATURES; i++)
        {   if
            (   creature[i].alive
             && creature[i].species != ANT
             && creature[i].species != BUTTERFLY
             && creature[i].species != CAMEL
             && creature[i].species != FISH
             && creature[i].species != GOOSE
             && creature[i].species != MONKEY
             && creature[i].species != PANDA
            )
            {   creature[i].alive = FALSE;
                change1(creature[i].x, creature[i].y, EMPTY);
                switch (arand(6))
                {
                case 0:
                    createcreature(ANT,       i, creature[i].x, creature[i].y, 0, 0, -1, ANT,       0);
                acase 1:
                    createcreature(BUTTERFLY, i, creature[i].x, creature[i].y, 0, 0, -1, BUTTERFLY, 0);
                acase 2:
                    createcreature(CAMEL,     i, creature[i].x, creature[i].y, 0, 0, -1, CAMEL,     0);
                acase 3:
                    createcreature(FISH,      i, creature[i].x, creature[i].y, 0, 0, -1, FISH,      0);
                acase 4:
                    createcreature(GOOSE,     i, creature[i].x, creature[i].y, 0, 0, -1, GOOSE,     0);
                acase 5:
                    createcreature(MONKEY,    i, creature[i].x, creature[i].y, 0, 0, -1, MONKEY,    0);
                acase 6:
                    createcreature(PANDA,     i, creature[i].x, creature[i].y, 0, 0, -1, PANDA,     0);
        }   }   }
    acase TREASURE:
        treasurer = player;
        if (level)
        {   secondsperlevel = 0;
            say((STRPTR) GetCatalogStr(CatalogPtr, MSG_BONUSLEVEL, "Bonus Level"), worm[treasurer].colour);
        }
        secondsperlevel += ADD_TREASURE + arand(RAND_TREASURE);
        if (secondsperlevel > TIMELIMIT)
        {   secondsperlevel = TIMELIMIT;
        }
        if (level)
        {   stat(player, BONUS);
            reallevel = level;
            level = 0;
            do
            {   bonustype = rand() % BONUSLEVELS;
            } while (difficulty == DIFFICULTY_EASY && bonustype == BONUSLEVEL_SNAKES);
            newlevel(player);

            if (bonustype == BONUSLEVEL_RABBITS)
            {   effect(FXGET_AMMO);
                for (i = 0; i < 4; i++)
                {   if (worm[player].lives)
                    {   worm[player].ammo += ADD_AMMO;
                        stat(player, AMMO);
        }   }   }   }
    acase AFFIXER:
        effect(FXGET_OBJECT);
        if (worm[player].affixer)
        {   multiplier = 2;
        } else
        {   worm[player].affixer = TRUE;
            icon(player, AFFIXER);
        }
    acase BACKWARDS:
        effect(FXGET_POWERUP);
        if (worm[player].backwards)
        {   multiplier = 2;
        } else
        {   worm[player].backwards = TRUE;
            icon(player, BACKWARDS);
        }
    acase FORWARDS:
        effect(FXGET_POWERUP);
        if (worm[player].forwards)
        {   multiplier = 2;
        } else
        {   worm[player].forwards = TRUE;
            icon(player, FORWARDS);
        }
    acase SWITCHER:
        effect(FXGET_OBJECT);
        for (x = 0; x <= fieldx; x++)
        {   for (y = 0; y <= fieldy; y++)
            {   d = field[x][y];
                if (d >= FIRSTTAIL && d <= LASTTAIL)
                {   if (d == FIRSTTAIL + player) // it's our dim tail, make it glow
                    {   change2(x, y, (UWORD) (FIRSTGLOW + player), (UWORD) (gfxfield[x][y] + 29));
                    } else // it's an enemy dim tail, make it friendly dim tail
                    {   change2(x, y, (UWORD) (FIRSTTAIL + player), (UWORD) (((gfxfield[x][y] - TAILSOFFSET) % 58) + (player * 58) + TAILSOFFSET));
                }   }
                elif   (d >= FIRSTGLOW && d <= LASTGLOW && d != FIRSTGLOW + player) // it's an enemy glow tail, make it friendly dim tail
                {   change2(x, y, (UWORD) (FIRSTGLOW + player), (UWORD) (((gfxfield[x][y] - TAILSOFFSET) % 58) - 29 + (player * 58) + TAILSOFFSET));
                } elif (d == SLIME)
                {   change1(x, y, DYNAMITE);
                } elif (d >= FIRSTCHERRY && d <= LASTCHERRY && d != (UWORD) (FIRSTCHERRY + player))
                {   change1(x, y, (UWORD) (FIRSTCHERRY + player));
                } elif (d >= FIRSTFLOWER && d <= LASTFLOWER && d != (UWORD) (FIRSTFLOWER + player))
                {   change1(x, y, (UWORD) (FIRSTFLOWER + player));
        }   }   }
    acase SUPERHEALER:
        effect(FXGET_OBJECT);
        worm[player].lives += ADD_SUPERHEALER;
        if (worm[player].lives > LIVESLIMIT)
        {   worm[player].lives = LIVESLIMIT;
            multiplier = 2;
        }
        stat(player, MINIHEALER);
    acase UMBRELLA:
        level += arand(1) + 1;
        if (level >= levels)
        {   level = levels;
        }
        endoflevel();
    acase AUTOJUMP:
        effect(FXGET_OBJECT);
        if (worm[player].autojump)
        {   multiplier = 2;
        } else
        {   worm[player].autojump = TRUE;
            icon(player, AUTOJUMP);
        }
    acase AUTOTURN:
        effect(FXGET_OBJECT);
        if (worm[player].autoturn)
        {   multiplier = 2;
        } else
        {   worm[player].autoturn = TRUE;
            icon(player, AUTOTURN);
        }
    acase SLOWER:
        effect(FXGET_OBJECT);
        for (i = 0; i <= CREATURES; i++)
        {   if
            (   creature[i].alive
             && creature[i].species != MISSILE_C
            )
            {   creature[i].speed = slowdown(creature[i].speed, -1, FALSE, FALSE);
        }   }
    acase MINIPULSE:
    case SUPERPULSE:
        if (c == MINIPULSE)
        {   effect(FXUSE_BOMB);
        } else
        {   effect(FXBORN_MISSILE);
        }
        for (i = 0; i <= CREATURES; i++)
        {   if (!creature[i].alive && generated <= 7)
            {   switch (generated)
                {
                case  0:                   xx =  0; yy = -1;
                acase 1:                   xx =  1; yy = -1;
                acase 2:                   xx =  1; yy =  0;
                acase 3:                   xx =     yy =  1;
                acase 4:                   xx =  0; yy =  1;
                acase 5:                   xx = -1; yy =  1;
                acase 6:                   xx = -1; yy =  0;
                acase 7:                   xx =     yy = -1;
                adefault: /* assert(0); */ xx =     yy =  0; // to avoid spurious warnings
                }

                generated++;
                if (valid(x + xx, y + yy) && (xx != worm[player].deltax || yy != worm[player].deltay))
                {   d = field[x + xx][y + yy];
                    if
                    (   (d >= FIRSTEMPTY && d <= LASTEMPTY)
                     || (d >= FIRSTTAIL  && d <= LASTTAIL )
                     ||  d <= LASTOBJECT
                    )
                    {   createcreature(FRAGMENT, i, (SBYTE) (x + xx), (SBYTE) (y + yy), (SBYTE) xx, (SBYTE) yy, -1, c, FRAGMENT);
        }   }   }   }
    acase REMNANTS:
        effect(FXGET_OBJECT);
        if (worm[player].remnants)
        {   multiplier = 2;
        } else
        {   worm[player].remnants = TRUE;
            icon(player, REMNANTS);
        }
    acase SIDESHOT:
        effect(FXGET_POWERUP);
        if (worm[player].sideshot)
        {   multiplier = 2;
        } else
        {   worm[player].sideshot = TRUE;
            icon(player, SIDESHOT);
        }
    acase CUTTER:
        effect(FXGET_OBJECT);
        worm[player].cutter += ADD_CUTTER + arand(RAND_CUTTER);
        if (worm[player].cutter > CUTTERLIMIT)
        {   worm[player].cutter = CUTTERLIMIT;
            multiplier = 2;
        }
        icon(player, CUTTER);
    acase CYCLONE_O:
        /* create cyclone */
        do
        {   x = arand(fieldx - 10) + 5;
            y = arand(fieldy - 5) + 5;
            d = field[x][y];
        } while (d < FIRSTEMPTY || d > LASTEMPTY);
        for (i = 0; i <= CREATURES; i++)
        {   if (!creature[i].alive)
            {   createcreature(CYCLONE_C, i, x, y, 0, 0, -1, ANYTHING, ANYTHING);
                break;
        }   }
    acase LIGHTNING:
        effect(FXGET_LIGHTNING);
        for (xx = 0; xx <= fieldx; xx++)
        {   for (yy = 0; yy <= fieldy; yy++)
            {   otherfield[xx][yy] = EMPTY;
        }   }
        for (xx = 0; xx <= fieldx; xx++)
        {   for (yy = 0; yy <= fieldy; yy++)
            {   if
                (   field[xx][yy] == FIRSTTAIL + player
                 || field[xx][yy] == FIRSTGLOW + player
                )
                {   for (xxx = xx - 1; xxx <= xx + 1; xxx++)
                    {   for (yyy = yy - 1; yyy <= yy + 1; yyy++)
                        {   if (valid(xxx, yyy))
                            {   d = field[xxx][yyy];
                                if
                                (   (d >= FIRSTTAIL     && d <= LASTTAIL  && d != FIRSTTAIL + player)
                                 || (d >= FIRSTGLOW     && d <= LASTGLOW  && d != FIRSTGLOW + player)
                                 ||  d == EMPTY
                                 ||  d <= LASTOBJECT
                                 || (d >= FIRSTCREATURE && d <= LASTCREATURE)
                                )
                                {   otherfield[xxx][yyy] = TEMPLIGHTNING;
                                    if (anims)
                                    {   draw((SBYTE) xxx, (SBYTE) yyy, LIGHTNING);
                                }   }
                                elif (d >= FIRSTFRUIT && d <= LASTFRUIT)
                                {   isfruit = FALSE;
                                    updatearrow((SBYTE) yyy);
                                    otherfield[xxx][yyy] = TEMPLIGHTNING;
                                    if (anims)
                                    {   draw((SBYTE) xxx, (SBYTE) yyy, LIGHTNING);
        }   }   }   }   }   }   }   }
        lighter = player;
    acase PUSHER:
        effect(FXGET_OBJECT);
        if (worm[player].pusher)
        {   multiplier = 2;
        } else
        {   worm[player].pusher = TRUE;
            icon(player, PUSHER);
        }
    acase GLOW:
        effect(FXGET_OBJECT);
        worm[player].glow += ADD_GLOW + arand(RAND_GLOW);
        if (worm[player].glow > GLOWLIMIT)
        {   worm[player].glow = GLOWLIMIT;
            multiplier = 2;
        }
        icon(player, GLOW);
    acase ENCLOSER:
        effect(FXGET_OBJECT);
        if (worm[player].encloser)
        {   multiplier = 2;
        } else
        {   worm[player].encloser = TRUE;
            icon(player, ENCLOSER);
        }
    acase GRABBER:
        for (xx = 0; xx <= fieldx; xx++)
        {   for (yy = 0; yy <= fieldy; yy++)
            {   if
                (   field[xx][yy] <= LASTOBJECT
                 && field[xx][yy] != GRABBER
                 && field[xx][yy] != MINIBOMB
                 && field[xx][yy] != SUPERBOMB
                 && field[xx][yy] != TREASURE
                 && field[xx][yy] != UMBRELLA
                )
                {   wormscore(player, wormobject(player, (SBYTE) xx, (SBYTE) yy));
                    if (field[xx][yy] != CYCLONE_C)
                    {   change1(xx, yy, (UWORD) (FIRSTCHERRY + player));
        }   }   }   }
        for (xx = 0; xx <= fieldx; xx++)
        {   for (yy = 0; yy <= fieldy; yy++)
            {   if
                (   field[xx][yy] == SUPERBOMB
                 || field[xx][yy] == MINIBOMB
                )
                {   wormscore(player, wormobject(player, (SBYTE) xx, (SBYTE) yy));
                    change1(xx, yy, (UWORD) (FIRSTCHERRY + player));
    }   }   }   }

    return POINTS_OBJECT * multiplier;
}

EXPORT void wormcol(int player, int x, int y)
{   FLAG  flag;
    UWORD c = field[x][y],
          d;
    UBYTE i;
    int   xx, yy;

    switch (c)
    {
    case  BANGINGDYNAMITE:
    acase BANGEDDYNAMITE:
        return; // important!
    acase EMPTY:
        switch (worm[player].speed)
        {
        case  SPEED_FAST:   wormscore(player, POINTS_EMPTY * 3);
        acase SPEED_NORMAL: wormscore(player, POINTS_EMPTY * 2);
        adefault:           wormscore(player, POINTS_EMPTY    );
        }
    acase SPIDERSILK:
        if (worm[player].armour == 0)
        {   worm[player].cause = SPIDER;
            worm[player].alive = FALSE;
        }
    acase FROGTONGUE:
        if (worm[player].armour == 0)
        {   worm[player].cause = FROG;
            worm[player].alive = FALSE;
        }
    acase ARROWUP:
        worm[player].speed = speedup(worm[player].speed, player);
        worm[player].last = ARROWUP;
        stat(player, BRAKES);
    acase ARROWDOWN:
        if (worm[player].speed < SPEED_SLOW) // so that the worm cannot be involuntarily brought to a total stop
        {    worm[player].speed = slowdown(worm[player].speed, player, worm[player].brakes, FALSE);
        }
        worm[player].last = ARROWDOWN;
        stat(player, BRAKES);
    acase FROST:
        worm[player].frosted = TRUE;
        worm[player].last = FROST;
    acase START:
        level++;
        if (level > levels)
        {   level = levels;
        }
        endoflevel();
    acase SLIME:
        if (worm[player].armour == 0)
        {   worm[player].cause = c;
            worm[player].alive = FALSE;
        }
    acase TELEPORT:
        i = whichteleport(x, y);
        if (blockedtel(i, worm[player].deltax, worm[player].deltay))
        {   worm[player].cause = TELEPORT;
            worm[player].alive = FALSE;
            ramming(player);
        } else
        {   effect(FXUSE_TELEPORT);
            worm[player].x = xwrap(teleport[partner(i)].x + worm[player].deltax);
            worm[player].y = ywrap(teleport[partner(i)].y + worm[player].deltay);
        }
    adefault:
        if (c >= FIRSTHEAD && c <= LASTHEAD)
        {   wormworm(x, y, player, (int) (c - FIRSTHEAD));
        } elif (c >= FIRSTPROTECTOR && c <= LASTPROTECTOR)
        {   protworm(x, y, (int) (c - FIRSTPROTECTOR), player);
        } elif
        (   c == STONE
         || c == METAL
         || c == WOOD
         || (c >= FIRSTCREATURE && c <= LASTCREATURE && creatureinfo[sortcreatures[c - FIRSTCREATURE]].wall)
         || (c >= FIRSTTAIL     && c <= LASTTAIL)
         || (c >= FIRSTGLOW     && c <= LASTGLOW)
        ) // if you've hit something that is pushable
        {   flag = TRUE; // flag is whether you deserve to be in pain
            if (worm[player].pusher)
            {   xx = x + worm[player].deltax;
                yy = y + worm[player].deltay;
                if (valid(xx, yy))
                {   d = field[xx][yy];
                    if
                    (    d <= LASTOBJECT
                     || (d >= FIRSTEMPTY && d <= LASTEMPTY)
                    )
                    // if pushing the square into a square which
                    // has an object or is empty/silver/gold
                    {   flag = FALSE; // then worm doesn't die
                        if (c >= FIRSTCREATURE && c <= LASTCREATURE)
                        {   assert(creatureinfo[sortcreatures[c - FIRSTCREATURE]].wall);
                            i = whichcreature(x, y, c, 255);
                            creature[i].x = xx;
                            creature[i].y = yy;
                            drawcreature((int) i);
                        } elif
                        (   (c >= FIRSTTAIL && c <= LASTTAIL)
                         || (c >= FIRSTGLOW && c <= LASTGLOW)
                        )
                        {   change2(xx, yy, c, gfxfield[x][y]);
                        } else
                        {   change1(xx, yy, c);
                }   }   }
                else // if pushing off the field edges
                {   flag = FALSE; // then worm doesn't die
                    if (c >= FIRSTCREATURE && c <= LASTCREATURE && creatureinfo[sortcreatures[c - FIRSTCREATURE]].wall)
                    {   wormkillcreature(player, whichcreature(x, y, c, 255), FALSE);
            }   }   }
            if (flag) // if not pushing successfully
            {   if
                (   (c >= FIRSTTAIL && c <= LASTTAIL)
                 || (c >= FIRSTGLOW && c <= LASTGLOW)
                )
                {   if (worm[player].armour > 0)
                    {   if (players > 1)
                        {   if
                            (   (c >= FIRSTTAIL && c <= LASTTAIL && player == c - FIRSTTAIL)
                             || (c >= FIRSTGLOW && c <= LASTGLOW && player == c - FIRSTGLOW)
                            )
                            {   worm[player].last = SILVER;
                            } else
                            {   worm[player].last = GOLD;
                    }   }   }
                    elif (!enclosed)
                    {   if
                        (   (c >= FIRSTTAIL && c <= LASTTAIL)
                         ||  player != c - FIRSTGLOW
                        )
                        {   if (!checkautojump(player))
                            {   worm[player].cause = c;
                                worm[player].alive = FALSE;
                                if (c >= FIRSTGLOW && c <= LASTGLOW)
                                {   ramming(player);
                }   }   }   }   }
                elif (c >= FIRSTCREATURE && c <= LASTCREATURE)
                {   assert(creatureinfo[sortcreatures[c - FIRSTCREATURE]].wall);
                    if (!checkautojump(player))
                    {   i = whichcreature(x, y, c, 255);
                        wormcreature(player, i);
                }   }
                else
                {   if (!checkautojump(player))
                    {   worm[player].cause = c;
                        worm[player].alive = FALSE;
                        ramming(player);
        }   }   }   }
        elif (c >= FIRSTCREATURE && c <= LASTCREATURE)
        {   assert(!creatureinfo[sortcreatures[c - FIRSTCREATURE]].wall);
            i = whichcreature(x, y, c, 255);
            wormcreature(player, i);
        } elif (c >= FIRSTGLOW && c <= LASTGLOW)
        {   if (player != c - FIRSTGLOW)
            {   if (worm[player].armour == 0)
                {   worm[player].cause = GLOW;
                    worm[player].alive = FALSE;
                }
                ramming(player);
        }   }
        else
        {   bothcol(player, x, y);
}   }   }

EXPORT UWORD getimage_head(int player)
{   int image;

    if (worm[player].alive)
    {   if (worm[player].glow == 0 && worm[player].cutter == 0 && worm[player].armour == 0)
        {   image = eachworm[player][0][worm[player].deltax + 1 + (worm[player].deltay + 1) * 3];
        } else
        {   if
            (   (worm[player].glow   > 0 && worm[player].glow   < 10)
             || (worm[player].cutter > 0 && worm[player].cutter < 10)
             || (worm[player].armour > 0 && worm[player].armour < 10)
            )
            {   if (worm[player].flashed)
                {   image = WHITENED;
                } else
                {   image = eachworm[player][1][worm[player].deltax + 1 + (worm[player].deltay + 1) * 3];
            }   }
            else
            {   image = eachworm[player][1][worm[player].deltax + 1 + (worm[player].deltay + 1) * 3];
    }   }   }
    else
    {   image = FIRSTPAIN + player;
    }

    return (UWORD) image;
}

EXPORT UBYTE whichteleport(int x, int y)
{   UBYTE which;

    assert(teleports);

    for (which = 0; which <= 1; which++)
    {   if (teleport[which].x == x && teleport[which].y == y)
        {    return which;
    }   }

    assert(0); /* panic */
    return 0; // to avoid spurious Visual C++ warnings
}

EXPORT void stat(int player, int image)
{   FLAG print = TRUE;
    int  i,
         theline;

    if (player >= 4)
    {   return;
    }

#if defined(ANDROID) || defined(GBA)
    icon(player, image);
#else
    strcpy(stattext, "       "); /* 7 spaces */
    switch (image)
    {
    case BONUS:
        while (worm[player].score >= worm[player].nextlife)
        {   worm[player].lives++;
            worm[player].nextlife += lifemodulo[difficulty];
            stat(player, MINIHEALER);
        };
        if (worm[player].multi > 1)
            whiteline();
        else colourline(player);
        stcl_d(stattext, (long int) worm[player].score);
        theline = 0;
        for (i = 0; i <= 6; i++)
            if (!stattext[i])
                stattext[i] = ' ';
        // score can't reach 10 million
    acase MINIHEALER:
        if (worm[player].lives > LIVESLIMIT)
            worm[player].lives = LIVESLIMIT;
        colourline(player);
        stcl_d(stattext, worm[player].lives);
        for (i = 0; i <= 6; i++)
            if (!stattext[i])
                stattext[i] = ' ';
        theline = 1;
    acase BRAKES:
        if (worm[player].brakes)
            whiteline();
        else colourline(player);
        switch (worm[player].speed)
        {
        case SPEED_FAST:
            sprintf
            (   stattext,
                "%-7s",
                (STRPTR) GetCatalogStr(CatalogPtr, MSG_FAST,    "Fast"   )
            );
        acase SPEED_NORMAL:
            sprintf
            (   stattext,
                "%-7s",
                (STRPTR) GetCatalogStr(CatalogPtr, MSG_NORMAL2, "Normal" )
            );
        acase SPEED_SLOW:
            sprintf
            (   stattext,
                "%-7s",
                (STRPTR) GetCatalogStr(CatalogPtr, MSG_SLOW,    "Slow"   )
            );
        acase SPEED_STOPPED:
            sprintf
            (   stattext,
                "%-7s",
                (STRPTR) GetCatalogStr(CatalogPtr, MSG_STOPPED, "Stopped")
            );
        }
        theline = 2;
    acase AMMO:
        if (worm[player].ammo > 0)
        {   if (worm[player].ammo > AMMOLIMIT)
            {   worm[player].ammo = AMMOLIMIT;
            }
            whiteline();
        } else
        {   colourline(player);
        }
        stcl_d(stattext, worm[player].ammo);
        for (i = 0; i <= 6; i++)
        {   if (!stattext[i])
            {   stattext[i] = ' ';
        }   }
        theline = 3;
    acase POWER:
        switch (worm[player].power)
        {
        case 0:
            colourline(player);
            sprintf
            (   stattext,
                "%-7s",
                GetCatalogStr(CatalogPtr, MSG_SINGLE,    "Single")
            );
        acase 2:
            whiteline();
            sprintf
            (   stattext,
                "%-7s",
                GetCatalogStr(CatalogPtr, MSG_TRIPLE,    "Triple")
            );
        acase 4:
            whiteline();
            sprintf
            (   stattext,
                "%-7s",
                GetCatalogStr(CatalogPtr, MSG_QUINTUPLE, "Quint.")
            );
        acase 6:
            whiteline();
            sprintf
            (   stattext,
                "%-7s",
                GetCatalogStr(CatalogPtr, MSG_SEPTUPLE,  "Sept." )
            );
        }
        theline = 4;
    adefault:
        print = FALSE;
        /* This next line is just to prevent spurious compiler
        warnings about possibly uninitialized variables */
        theline = 0;
    }

    if (print)
    {   printstat(player, theline);
    }
#endif
}

MODULE FLAG checkautojump(int player)
{   int deltax1, deltax2,
        deltay1, deltay2,
        distance,
        index1, index2,
        xx, x1, x2,
        yy, y1, y2;

    if (worm[player].autojump)
    {   if (worm[player].speed == SPEED_FAST)
            distance = DISTANCE_FAST - 1;
        elif (worm[player].speed == SPEED_NORMAL)
            distance = DISTANCE_NORMAL - 1;
        else
        {   assert(worm[player].speed == SPEED_SLOW);
            distance = DISTANCE_SLOW - 1;
        }
        xx = xwrap(worm[player].x + (worm[player].deltax * distance));
        yy = ywrap(worm[player].y + (worm[player].deltay * distance));
        if
        (   (field[xx][yy] >= FIRSTEMPTY && field[xx][yy] <= LASTEMPTY)
         || field[xx][yy] <= LASTOBJECT
        )
        {   worm[player].x = xx;
            worm[player].y = yy;
            wormcol(player, xx, yy);
            return TRUE;
    }   }

    if (worm[player].autoturn)
    {   xx = xwrap(worm[player].x - worm[player].deltax);
        yy = ywrap(worm[player].y - worm[player].deltay);
        if     (worm[player].deltax == 0 && (worm[player].deltay == -1 || worm[player].deltay == 1)) // going due north or due south
        {   deltax1 = -1;
            deltax2 =  1;
            deltay1 = deltay2 = 0;
        } elif (worm[player].deltay == 0 && (worm[player].deltax == -1 || worm[player].deltax == 1)) // going due west  or due east
        {   deltax1 = deltax2 = 0;
            deltay1 = -1;
            deltay2 =  1;
        } elif
        (   (worm[player].deltax == -1 && worm[player].deltay == -1) // going northwest
         || (worm[player].deltax ==  1 && worm[player].deltay ==  1) // or    southeast
        ) // check northeast and southwest
        {   deltax1 =  1;
            deltay1 = -1;
            deltax2 = -1;
            deltay2 =  1;
        } elif
        (   (worm[player].deltax ==  1 && worm[player].deltay == -1) // going northeast
         || (worm[player].deltax == -1 && worm[player].deltay ==  1) // or    southwest
        ) // check northwest and southeast
        {   deltax1 = -1;
            deltay1 = -1;
            deltax2 =  1;
            deltay2 =  1;
        } else
        {   return FALSE;
        }
        x1 = xwrap(xx + deltax1);
        x2 = xwrap(xx + deltax2);
        y1 = ywrap(yy + deltay1);
        y2 = ywrap(yy + deltay2);

        if
        (   (field[x1][y1] >= FIRSTEMPTY && field[x1][y1] <= LASTEMPTY)
         || field[x1][y1] <= LASTOBJECT
        )
        {   worm[player].olddeltax = worm[player].deltax;
            worm[player].olddeltay = worm[player].deltay;
            worm[player].deltax = deltax1;
            worm[player].deltay = deltay1;
            worm[player].x = x1;
            worm[player].y = y1;
            index1 =       worm[player].olddeltax + 1 + (      (worm[player].olddeltay + 1) * 3);
            index2 = isign(worm[player].deltax)   + 1 + ((isign(worm[player].deltay)   + 1) * 3);
            if (worm[player].last == FIRSTTAIL + player)
            {   draw(xx, yy, eachtail[player][0][index1][index2]);
                gfxfield[xx][yy] = eachtail[player][0][index1][index2];
            } elif (worm[player].last == FIRSTGLOW + player)
            {   draw(xx, yy, eachtail[player][1][index1][index2]);
                gfxfield[xx][yy] = eachtail[player][1][index1][index2];
            }
            worm[player].olddeltax = worm[player].deltax;
            worm[player].olddeltay = worm[player].deltay;
            wormcol(player, x1, y1);
            return TRUE;
        }
        if
        (   (field[x2][y2] >= FIRSTEMPTY && field[x2][y2] <= LASTEMPTY)
         || field[x2][y2] <= LASTOBJECT
        )
        {   worm[player].olddeltax = worm[player].deltax;
            worm[player].olddeltay = worm[player].deltay;
            worm[player].deltax = deltax2;
            worm[player].deltay = deltay2;
            worm[player].x = x2;
            worm[player].y = y2;
            index1 =       worm[player].olddeltax + 1 + (      (worm[player].olddeltay + 1) * 3);
            index2 = isign(worm[player].deltax)   + 1 + ((isign(worm[player].deltay)   + 1) * 3);
            if (worm[player].last == FIRSTTAIL + player)
            {   draw(xx, yy, eachtail[player][0][index1][index2]);
                gfxfield[xx][yy] = eachtail[player][0][index1][index2];
            } elif (worm[player].last == FIRSTGLOW + player)
            {   draw(xx, yy, eachtail[player][1][index1][index2]);
                gfxfield[xx][yy] = eachtail[player][1][index1][index2];
            }
            worm[player].olddeltax = worm[player].deltax;
            worm[player].olddeltay = worm[player].deltay;
            wormcol(player, x1, y1);
            return TRUE;
    }   }

    return FALSE;
}

EXPORT void teleportcreature(UBYTE i, UBYTE which)
{   creature[which].x = teleport[partner(i)].x + creature[which].deltax;
    creature[which].y = teleport[partner(i)].y + creature[which].deltay;
}

MODULE void createcloud(void)
{   int   i,
          x, y,
          which;
    UWORD c;

    for (i = 0; i < PATIENCE; i++)
    {   x = (SBYTE) arand(fieldx - 10) + 5;
        y = (SBYTE) arand(fieldy / 2);
        c = field[x][y];
        if (c >= FIRSTEMPTY && c <= LASTEMPTY)
        {   for (which = 0; which <= CREATURES; which++)
            {   if (!creature[which].alive)
                {   if (x < fieldx / 2)
                    {   createcreature(CLOUD, (UBYTE) which, x, y, -1, 0, -1, ANYTHING, ANYTHING);
                    } else
                    {   createcreature(CLOUD, (UBYTE) which, x, y,  1, 0, -1, ANYTHING, ANYTHING);
                    }
                    return;
}   }   }   }   }

EXPORT int createprotector(int player, int x, int y)
{   int i, j;

    for (i = 0; i <= PROTECTORS; i++)
    {   if (!protector[player][i].alive)
        {   protector[player][i].relx = x;
            protector[player][i].rely = y;
            for (j = 0; j <= PROTECTORS; j++)
            {   if
                (   i == NOSE
                 || !protector[player][j].alive
                 ||  protector[player][j].x != xwrap(worm[player].x + protector[player][i].relx)
                 ||  protector[player][j].y != ywrap(worm[player].y + protector[player][i].rely)
                ) // if we can find an area without a preexisting protector
                {   effect(FXBORN_PROTECTOR);
                    protector[player][i].alive = TRUE;
                    protector[player][i].visible = FALSE;
                    protector[player][i].last = EMPTY;
                    if (i == NOSE)
                    {   worm[player].position = -1;
                    }
                    if
                    (   (protector[player][i].relx == -1 && protector[player][i].rely == -1)
                     || (protector[player][i].relx ==  0 && protector[player][i].rely == -1)
                    )
                    {   protector[player][i].deltax = 1;
                        protector[player][i].deltay = 0;
                    } elif
                    (   (protector[player][i].relx ==  1 && protector[player][i].rely == -1)
                     || (protector[player][i].relx ==  1 && protector[player][i].rely ==  0)
                    )
                    {   protector[player][i].deltax = 0;
                        protector[player][i].deltay = 1;
                    } elif
                    (   (protector[player][i].relx ==  1 && protector[player][i].rely ==  1)
                     || (protector[player][i].relx ==  0 && protector[player][i].rely ==  1)
                    )
                    {   protector[player][i].deltax = -1;
                        protector[player][i].deltay = 0;
                    } else
                    {   protector[player][i].deltax = 0;
                        protector[player][i].deltay = -1;
                    }
                    return 2;
            }   }
            return 1;
    }   }
    return 0;
}

EXPORT void dosidebar(void)
{   int player;

    if (a == LEVELEDIT)
    {   return;
    }

    for (player = 0; player <= 3; player++)
    {   if (worm[player].control != NONE)
        {   icon(player, BONUS);
            icon(player, MINIHEALER);
            icon(player, BRAKES);
            icon(player, AMMO);
            icon(player, POWER);

            stat(player, BONUS);
            stat(player, MINIHEALER);
            stat(player, BRAKES);
            stat(player, AMMO);
            stat(player, POWER);

            icon(player, AFFIXER  );
            icon(player, ARMOUR   );
            icon(player, AUTOJUMP );
            icon(player, AUTOTURN );
            icon(player, BACKWARDS);
            icon(player, FORWARDS );
            icon(player, CUTTER   );
            icon(player, ENCLOSER );
            icon(player, GLOW     );
            icon(player, GRENADE  );
            icon(player, PUSHER   );
            icon(player, REMNANTS );
            icon(player, SIDESHOT );
}   }   }

MODULE void createrabbit(void)
{   int   x, y,
          deltax;
    UBYTE which;

    if (!arand(1))
    {   x      = 0;
        deltax = 1;
    } else

    {   x      = fieldx;
        deltax = -1;
    }
    y = (SBYTE) arand((ULONG) fieldy);

    for (;;)
    {   if (!valid(x, y))
        {   return;
        } elif
        (    field[x][y] <= LASTOBJECT
         || (field[x][y] >= FIRSTEMPTY && field[x][y] <= LASTEMPTY)
        )
        {   for (which = 0; which <= CREATURES; which++)
            {   if (!creature[which].alive)
                {   createcreature(RABBIT, which, x, y, deltax, 0, -1, ANYTHING, ANYTHING);
                    break;
            }   }
            return;
        } // implied else
        x += deltax;
}   }

#if !defined(ANDROID) && !defined(GBA)
EXPORT void introanim_engine(int introframe)
{   int x, y;

    switch (introframe)
    {
    case 0:
        switch (level)
        {
        case  INTRO_1:
            for (x = -5; x <= 5; x++)
            {   for (y = 0; y <= 4; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            intro_draw( 0, 1, FIRSTNUMBER );
            intro_draw( 0, 4, BLUEHEADUP  );
        acase INTRO_2:
            for (x = -2; x <= 2; x++)
            {   for (y = 0; y <= 4; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            intro_draw(-2, 0, BLUEHEADRIGHT);
            intro_draw( 0, 2, MOUSE       );
        acase INTRO_3:
            for (x = -5; x <= 5; x++)
            {   for (y = 0; y <= 4; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            intro_draw( 0, 0, STONE       );
            intro_draw( 0, 1, STONE       );
            intro_draw( 0, 2, STONE       );
            intro_draw( 0, 3, STONE       );
            intro_draw( 0, 4, STONE       );
            intro_draw(-1, 2, STONE       );
            intro_draw(-1, 3, STONE       );
            intro_draw(-1, 4, STONE       );
            intro_draw(-5, 1, BLUEHEADRIGHT);
        acase INTRO_4:
            for (x = -7; x <= 7; x++)
            {   for (y = 0; y <= 4; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            for (y = 0; y <= 4; y++)
            {   intro_draw( 3, y, GN_N_S  );
                intro_draw( 4, y, RN_N_S  );
                intro_draw( 5, y, BN_N_S  );
                intro_draw( 6, y, YN_N_S  );
                intro_draw( 7, y, WOOD    );
            }
            intro_draw(-7, 2, BLUEHEADRIGHT);
        acase INTRO_5:
            for (x = -5; x <= 5; x++)
            {   for (y = 0; y <= 4; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            intro_draw(-2, 1, TELEPORT    );
            intro_draw( 2, 3, TELEPORT    );
            intro_draw(-5, 1, BLUEHEADRIGHT);
        acase INTRO_6:
            for (x = -7; x <= 7; x++)
            {   for (y = 0; y <= 4; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            intro_draw(-6, 1, GREENGLOWDOWN);
            intro_draw(-4, 1, REDGLOWDOWN );
            intro_draw( 0, 1, BLUEGLOWDOWN);
            intro_draw( 4, 1, YELLOWGLOWDOWN    );
        acase INTRO_7:
            for (x = -7; x <= 7; x++)
            {   for (y = 0; y <= 4; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            intro_draw(-7, 2, BLUEHEADRIGHT);
            intro_draw( 7, 4, MONKEY      );
        acase INTRO_8:
            for (x = -3; x <= 3; x++)
            {   for (y = -1; y <= 5; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            intro_draw( 3,-1, CLOUD       );
            intro_draw(-3, 5, BLUEHEADRIGHT);
        acase INTRO_9:
            for (x = -2; x <= 2; x++)
            {   for (y = 0; y <= 4; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            intro_draw(-2, 2, BLUEHEAD_NE );
            intro_draw( 0, 2, MOUSE       );
        acase INTRO_10:
            for (x = -4; x <= 0; x++)
            {   for (y = 0; y <= 3; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            intro_draw( 2, 0, FIRSTCHERRY );
            intro_draw( 3, 0, FIRSTFLOWER );
            intro_draw( 4, 0, FIRSTRAIN   );
            intro_draw( 2, 1, FIRSTCHERRY + 1   );
            intro_draw( 3, 1, FIRSTFLOWER + 1   );
            intro_draw( 4, 1, FIRSTRAIN   + 1   );
            intro_draw( 2, 2, FIRSTCHERRY + 2   );
            intro_draw( 3, 2, FIRSTFLOWER + 2   );
            intro_draw( 4, 2, FIRSTRAIN   + 2   );
            intro_draw( 2, 3, FIRSTCHERRY + 3   );
            intro_draw( 3, 3, FIRSTFLOWER + 3   );
            intro_draw( 4, 3, FIRSTRAIN   + 3   );
            intro_draw(-4, 3, BLUEHEADRIGHT);
            intro_draw( 1, 0, bananaframes[0][0]);
            intro_draw( 1, 1, bananaframes[1][0]);
            intro_draw( 1, 2, bananaframes[2][0]);
            intro_draw( 1, 3, bananaframes[3][0]);
        acase INTRO_11:
            for (x = -4; x <= 4; x++)
            {   for (y = 0; y <= 4; y++)
                {   intro_draw(x, y, EMPTY);
            }   }
            intro_draw(-4, 1, STONE       );
            intro_draw(-4, 2, METAL       );
            intro_draw( 4, 1, METAL       );
            intro_draw( 4, 2, METAL       );
            intro_draw(-3, 1, FRAGMENT    );
            intro_draw( 3, 2, FRAGMENT    );
            intro_draw(-4, 4, BLUEHEADRIGHT);
        acase INTRO_12:
            for (y = 0; y <= 4; y++)
            {   intro_draw(-4, y, EMPTY   );
                intro_draw( 4, y, EMPTY   );
            }
            for (x = -3; x <= 3; x++)
            {   for (y = 0; y <= 4; y++)
                {   intro_draw(x, y, FROST);
            }   }
            intro_draw(-4, 3, BLUEHEADRIGHT);
            intro_draw( 4, 1, YELLOWHEADLEFT    );
        }
    acase 1:
        switch (level)
        {
        case  INTRO_1:
            intro_draw( 0, 3, BLUEHEADUP  );
            intro_draw( 0, 4, BN_N_S      );
        acase INTRO_2:
            intro_draw(-1, 0, BLUEHEADRIGHT);
            intro_draw(-2, 0, BN_W_E      );
        acase INTRO_4:
            intro_draw(-6, 2, BLUEHEADRIGHT);
            intro_draw(-7, 2, BN_W_E      );
        acase INTRO_5:
            intro_draw(-4, 1, BLUEHEADRIGHT);
            intro_draw(-5, 1, BN_W_E      );
        acase INTRO_6:
            intro_draw(-4, 2, REDGLOWDOWN );
            intro_draw( 0, 2, BLUEGLOWDOWN);
            intro_draw( 4, 2, YELLOWGLOWDOWN    );
            intro_draw(-4, 1, RG_N_S      );
            intro_draw( 0, 1, BG_N_S      );
            intro_draw( 4, 1, YG_N_S      );
        acase INTRO_7:
            intro_draw(-6, 2, BLUEHEADRIGHT);
            intro_draw(-7, 2, BN_W_E      );
            intro_draw( 7, 4, EMPTY       );
            intro_draw( 6, 3, MONKEY      );
        acase INTRO_8:
            intro_draw( 2,-1, CLOUD       );
            intro_draw( 3,-1, EMPTY       );
            intro_draw(-2, 5, BLUEHEADRIGHT);
            intro_draw(-3, 5, BN_W_E      );
        acase INTRO_9:
            intro_draw(-1, 1, BLUEHEAD_NE );
            intro_draw(-2, 2, BN_NE_SW    );
        acase INTRO_10:
            intro_draw(-3, 3, BLUEHEADRIGHT);
            intro_draw(-4, 3, BN_W_E      );
            intro_draw( 1, 0, bananaframes[0][1]);
            intro_draw( 1, 1, bananaframes[1][1]);
            intro_draw( 1, 2, bananaframes[2][1]);
            intro_draw( 1, 3, bananaframes[3][1]);
        acase INTRO_11:
            intro_draw(-3, 1, EMPTY       );
            intro_draw(-2, 1, FRAGMENT    );
            intro_draw( 3, 2, EMPTY       );
            intro_draw( 2, 2, FRAGMENT    );
            intro_draw(-4, 4, BN_W_E      );
            intro_draw(-3, 4, BLUEHEADRIGHT);
        }
    acase 2:
        switch (level)
        {
        case  INTRO_1:
            intro_draw( 0, 2, BLUEHEADUP  );
            intro_draw( 0, 3, BN_N_S      );
            intro_draw( 0, 1, FIRSTREVNUMBER    );
        acase INTRO_2:
            intro_draw( 0, 0, BLUEHEADRIGHT);
            intro_draw(-1, 0, BN_W_E      );
        acase INTRO_3:
            intro_draw(-4, 1, BLUEHEADRIGHT);
            intro_draw(-5, 1, BN_W_E      );
        acase INTRO_4:
            intro_draw(-5, 2, BLUEHEADRIGHT);
            intro_draw(-6, 2, BN_W_E      );
        acase INTRO_5:
            intro_draw(-3, 1, BLUEHEADRIGHT);
            intro_draw(-4, 1, BN_W_E      );
        acase INTRO_6:
            intro_draw(-6, 2, GREENGLOWDOWN);
            intro_draw(-4, 3, REDGLOWDOWN );
            intro_draw( 0, 3, BLUEGLOWDOWN);
            intro_draw( 4, 3, YELLOWGLOWDOWN    );
            intro_draw(-6, 1, GG_N_S      );
            intro_draw(-4, 2, RG_N_S      );
            intro_draw( 0, 2, BG_N_S      );
            intro_draw( 4, 2, YG_N_S      );
        acase INTRO_7:
            intro_draw(-5, 2, BLUEHEADRIGHT);
            intro_draw(-6, 2, BN_W_E      );
            intro_draw( 4, 2, bananaframes[2][0]);
            intro_draw( 6, 3, EMPTY       );
            intro_draw( 5, 2, MONKEY      );
        acase INTRO_8:
            intro_draw( 1,-1, CLOUD       );
            intro_draw( 2,-1, EMPTY       );
            intro_draw(-1, 5, BLUEHEADRIGHT);
            intro_draw(-2, 5, BN_W_E      );
        acase INTRO_9:
            intro_draw( 0, 0, BLUEHEAD_NE );
            intro_draw(-1, 1, BN_NE_SW    );
        acase INTRO_10:
            intro_draw(-2, 3, BLUEHEADRIGHT);
            intro_draw(-3, 3, BN_W_E      );
            intro_draw( 1, 0, bananaframes[0][2]);
            intro_draw( 1, 1, bananaframes[1][2]);
            intro_draw( 1, 2, bananaframes[2][2]);
            intro_draw( 1, 3, bananaframes[3][2]);
        acase INTRO_11:
            intro_draw(-2, 1, EMPTY       );
            intro_draw(-1, 1, FRAGMENT    );
            intro_draw( 2, 2, EMPTY       );
            intro_draw( 1, 2, FRAGMENT    );
            intro_draw(-3, 4, BN_W_E      );
            intro_draw(-2, 4, BLUEHEADRIGHT);
        acase INTRO_12:
            intro_draw(-4, 3, BN_W_E      );
            intro_draw(-3, 3, BLUEHEADRIGHT);
            intro_draw( 4, 1, YN_W_E      );
            intro_draw( 3, 1, YELLOWHEADLEFT    );
        }
    acase 3:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 0, 1, BLUEHEADUP  );
            intro_draw( 0, 2, BN_N_S      );
            intro_draw( 2, 1, FIRSTNUMBER    + 1);
        acase INTRO_2:
            intro_draw( 1, 0, BLUEHEADRIGHT);
            intro_draw( 0, 0, BN_W_E      );
        acase INTRO_4:
            intro_draw(-4, 2, BLUEHEADRIGHT);
            intro_draw(-5, 2, BN_W_E      );
        acase INTRO_5:
            intro_draw( 3, 3, BLUEHEADRIGHT);
            intro_draw(-3, 1, BN_W_E      );
        acase INTRO_6:
            intro_draw(-6, 3, GREENGLOWDOWN);
            intro_draw(-3, 3, REDGLOWRIGHT);
            intro_draw( 1, 3, BLUEGLOWRIGHT);
            intro_draw( 5, 3, YELLOWGLOWRIGHT   );
            intro_draw(-6, 2, GG_N_S      );
            intro_draw(-4, 3, RG_N_E      );
            intro_draw( 0, 3, BG_N_E      );
            intro_draw( 4, 3, YG_N_E      );
        acase INTRO_7:
            intro_draw(-4, 2, BLUEHEADRIGHT);
            intro_draw(-5, 2, BN_W_E      );
            intro_draw( 4, 2, EMPTY       );
            intro_draw( 3, 2, bananaframes[2][1]);
            intro_draw( 5, 2, EMPTY       );
            intro_draw( 4, 1, MONKEY      );
        acase INTRO_8:
            intro_draw( 0,-1, CLOUD       );
            intro_draw( 1,-1, EMPTY       );
            intro_draw( 0, 0, FIRSTRAIN + 2);
            intro_draw( 0, 4, BLUEHEAD_NE );
            intro_draw(-1, 5, BN_W_NE     );
        acase INTRO_9:
            intro_draw( 1, 1, BLUEHEAD_SE );
            intro_draw( 0, 0, BN_SE_SW    );
        acase INTRO_10:
            intro_draw(-1, 2, BLUEHEAD_NE );
            intro_draw(-2, 3, BN_W_NE     );
            intro_draw( 1, 0, bananaframes[0][3]);
            intro_draw( 1, 1, bananaframes[1][3]);
            intro_draw( 1, 2, bananaframes[2][3]);
            intro_draw( 1, 3, bananaframes[3][3]);
        acase INTRO_11:
            intro_draw(-1, 1, EMPTY       );
            intro_draw( 0, 1, FRAGMENT    );
            intro_draw( 1, 2, EMPTY       );
            intro_draw( 0, 2, FRAGMENT    );
            intro_draw(-2, 4, BN_W_E      );
            intro_draw(-1, 4, BLUEHEADRIGHT);
        }
    acase 4:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 1, 1, BLUEHEADRIGHT);
            intro_draw( 0, 1, BN_S_E      );
            intro_draw( 2, 1, FIRSTREVNUMBER + 1);
        acase INTRO_2:
            intro_draw( 2, 0, BLUEHEADRIGHT);
            intro_draw( 1, 0, BN_W_E      );
        acase INTRO_3:
            intro_draw(-3, 1, BLUEHEADRIGHT);
            intro_draw(-4, 1, BN_W_E      );
        acase INTRO_4:
            intro_draw(-3, 2, BLUEHEADRIGHT);
            intro_draw(-4, 2, BN_W_E      );
        acase INTRO_5:
            intro_draw( 4, 3, BLUEHEADRIGHT);
            intro_draw( 3, 3, BN_W_E      );
        acase INTRO_6:
            intro_draw(-2, 3, REDGLOWRIGHT);
            intro_draw( 2, 3, BLUEGLOWRIGHT);
            intro_draw( 6, 3, YELLOWGLOWRIGHT   );
            intro_draw(-3, 3, RG_W_E      );
            intro_draw( 1, 3, BG_W_E      );
            intro_draw( 5, 3, YG_W_E      );
        acase INTRO_7:
            intro_draw(-3, 2, BLUEHEADRIGHT);
            intro_draw(-4, 2, BN_W_E      );
            intro_draw( 3, 2, EMPTY       );
            intro_draw( 2, 2, bananaframes[2][2]);
            intro_draw( 4, 1, EMPTY       );
            intro_draw( 5, 2, MONKEY      );
        acase INTRO_8:
            intro_draw(-1,-1, CLOUD       );
            intro_draw( 0,-1, EMPTY       );
            intro_draw( 0, 1, FIRSTRAIN + 2);
            intro_draw( 0, 0, EMPTY       );
            intro_draw( 0, 3, BLUEHEADUP  );
            intro_draw( 0, 4, BN_N_SW     );
        acase INTRO_9:
            intro_draw( 2, 2, BLUEHEAD_SE );
            intro_draw( 1, 1, BN_NW_SE    );
        acase INTRO_10:
            intro_draw( 0, 2, BLUEHEADRIGHT);
            intro_draw(-1, 2, BN_SW_E     );
            intro_draw( 1, 0, bananaframes[0][4]);
            intro_draw( 1, 1, bananaframes[1][4]);
            intro_draw( 1, 2, bananaframes[2][4]);
            intro_draw( 1, 3, bananaframes[3][4]);
        acase INTRO_11:
            intro_draw( 0, 1, EMPTY       );
            intro_draw( 1, 1, FRAGMENT    );
            intro_draw( 0, 2, EMPTY       );
            intro_draw(-1, 2, FRAGMENT    );
            intro_draw(-1, 4, BN_W_E      );
            intro_draw( 0, 4, BLUEHEADRIGHT);
        acase INTRO_12:
            intro_draw(-3, 3, BN_W_E      );
            intro_draw(-2, 3, BLUEHEADRIGHT);
            intro_draw( 3, 1, YN_W_E      );
            intro_draw( 2, 1, YELLOWHEADLEFT    );
        }
    acase 5:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 2, 1, BLUEHEADRIGHT);
            intro_draw( 1, 1, BN_W_E      );
            intro_draw( 2, 3, FIRSTNUMBER    + 2);
        acase INTRO_2:
            intro_draw( 2, 1, BLUEHEADDOWN);
            intro_draw( 2, 0, BN_W_S      );
        acase INTRO_4:
            intro_draw(-2, 2, BLUEHEADRIGHT);
            intro_draw(-3, 2, BN_W_E      );
        acase INTRO_5:
            intro_draw( 4, 2, BLUEHEADUP  );
            intro_draw( 4, 3, BN_W_N      );
        acase INTRO_6:
            intro_draw(-2, 2, REDGLOWUP   );
            intro_draw( 2, 2, BLUEGLOWUP  );
            intro_draw( 6, 2, YELLOWGLOWUP);
            intro_draw(-2, 3, RG_W_N      );
            intro_draw( 2, 3, BG_W_N      );
            intro_draw( 6, 3, YG_W_N      );
        acase INTRO_7:
            intro_draw(-2, 2, BLUEHEADRIGHT);
            intro_draw(-3, 2, BN_W_E      );
            intro_draw( 2, 2, EMPTY       );
            intro_draw( 1, 2, bananaframes[2][3]);
            intro_draw( 5, 2, EMPTY       );
            intro_draw( 6, 3, MONKEY      );
        acase INTRO_8:
            intro_draw(-2,-1, CLOUD       );
            intro_draw(-1,-1, EMPTY       );
            intro_draw( 0, 1, EMPTY       );
            intro_draw( 0, 2, BLUEHEADUP  );
            intro_draw( 0, 3, BN_N_S      );
        acase INTRO_9:
            intro_draw( 1, 3, BLUEHEAD_SW );
            intro_draw( 2, 2, BN_NW_SW    );
        acase INTRO_10:
            intro_draw( 1, 2, BLUEHEADRIGHT);
            intro_draw( 0, 2, BN_W_E      );
            intro_draw( 1, 0, bananaframes[0][5]);
            intro_draw( 1, 1, bananaframes[1][5]);
            intro_draw( 1, 3, bananaframes[3][5]);
        acase INTRO_11:
            intro_draw( 1, 1, EMPTY       );
            intro_draw( 2, 1, FRAGMENT    );
            intro_draw(-1, 2, EMPTY       );
            intro_draw(-2, 2, FRAGMENT    );
            intro_draw( 0, 4, BN_W_E      );
            intro_draw( 1, 4, BLUEHEADRIGHT);
        }
    acase 6:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 2, 2, BLUEHEADDOWN);
            intro_draw( 2, 1, BN_W_S      );
            intro_draw( 2, 3, FIRSTREVNUMBER + 2);
        acase INTRO_3:
            intro_draw(-2, 1, BLUEHEADRIGHT);
            intro_draw(-3, 1, BN_W_E      );
        acase INTRO_4:
            intro_draw(-1, 2, BLUEHEADRIGHT);
            intro_draw(-2, 2, BN_W_E      );
        acase INTRO_7:
            intro_draw(-1, 2, BLUEHEADRIGHT);
            intro_draw(-2, 2, BN_W_E      );
            intro_draw( 1, 2, EMPTY       );
            intro_draw( 0, 2, bananaframes[2][4]);
            intro_draw( 6, 3, EMPTY       );
            intro_draw( 7, 4, MONKEY      );
        acase INTRO_2:
            intro_draw( 2, 2, BLUEHEADDOWN);
            intro_draw( 2, 1, BN_N_S      );
        acase INTRO_5:
            intro_draw( 4, 1, BLUEHEADUP  );
            intro_draw( 4, 2, BN_N_S      );
        acase INTRO_6:
            intro_draw(-2, 1, REDGLOWUP   );
            intro_draw( 2, 1, BLUEGLOWUP  );
            intro_draw( 6, 1, YELLOWGLOWUP);
            intro_draw(-2, 2, RG_N_S      );
            intro_draw( 2, 2, BG_N_S      );
            intro_draw( 6, 2, YG_N_S      );
        acase INTRO_8:
            intro_draw(-3,-1, CLOUD       );
            intro_draw(-2,-1, EMPTY       );
            intro_draw( 1, 1, BLUEHEAD_NE );
            intro_draw( 0, 2, BN_NE_S     );
        acase INTRO_9:
            intro_draw( 0, 4, BLUEHEAD_SW );
            intro_draw( 1, 3, BN_NE_SW    );
        acase INTRO_10:
            intro_draw( 2, 2, BLUEHEADRIGHT);
            intro_draw( 1, 2, BN_W_E      );
            intro_draw( 1, 0, bananaframes[0][6]);
            intro_draw( 1, 1, bananaframes[1][6]);
            intro_draw( 1, 3, bananaframes[3][6]);
        acase INTRO_11:
            intro_draw( 2, 1, EMPTY       );
            intro_draw( 3, 1, FRAGMENT    );
            intro_draw(-2, 2, EMPTY       );
            intro_draw(-3, 2, FRAGMENT    );
            intro_draw( 1, 4, BN_W_E      );
            intro_draw( 2, 4, BLUEHEADRIGHT);
        acase INTRO_12:
            intro_draw(-2, 3, BN_W_E      );
            intro_draw(-1, 3, BLUEHEADRIGHT);
            intro_draw( 2, 1, YN_W_E      );
            intro_draw( 1, 1, YELLOWHEADLEFT    );
        }
    acase 7:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 2, 3, BLUEHEADDOWN);
            intro_draw( 2, 2, BN_N_S      );
            intro_draw( 4, 3, FIRSTNUMBER    + 3);
        acase INTRO_2:
            intro_draw( 2, 3, BLUEHEADDOWN);
            intro_draw( 2, 2, BN_N_S      );
        acase INTRO_4:
            intro_draw( 0, 2, BLUEHEADRIGHT);
            intro_draw(-1, 2, BN_W_E      );
        acase INTRO_5:
            intro_draw( 3, 1, BLUEHEADLEFT);
            intro_draw( 4, 1, BN_W_S      );
        acase INTRO_6:
            intro_draw(-3, 1, REDGLOWLEFT );
            intro_draw( 1, 1, BLUEGLOWLEFT);
            intro_draw( 5, 1, YELLOWGLOWLEFT    );
            intro_draw(-2, 1, RG_W_S      );
            intro_draw( 2, 1, BG_W_S      );
            intro_draw( 6, 1, YG_W_S      );
        acase INTRO_7:
            intro_draw( 0, 2, BLUEHEADRIGHT);
            intro_draw(-1, 2, BN_W_E      );
            intro_draw( 1, 2, EMPTY       );
            intro_draw( 7, 4, EMPTY       );
        acase INTRO_8:
            intro_draw(-2,-1, CLOUD       );
            intro_draw(-3,-1, EMPTY       );
            intro_draw( 2, 0, BLUEHEAD_NE );
            intro_draw( 1, 1, BN_NE_SW    );
        acase INTRO_9:
            intro_draw(-1, 3, BLUEHEAD_NW );
            intro_draw( 0, 4, BN_NE_NW    );
        acase INTRO_10:
            intro_draw( 3, 2, BLUEHEADRIGHT);
            intro_draw( 2, 2, BN_W_E      );
            intro_draw( 1, 0, bananaframes[0][7]);
            intro_draw( 1, 1, bananaframes[1][7]);
            intro_draw( 1, 3, bananaframes[3][7]);
        acase INTRO_11:
            intro_draw( 3, 1, EMPTY       );
            intro_draw( 2, 1, FRAGMENT    );
            intro_draw(-3, 2, EMPTY       );
            intro_draw(-2, 2, FRAGMENT    );
            intro_draw( 2, 4, BN_W_E      );
            intro_draw( 3, 4, BLUEHEADRIGHT);
        }
    acase 8:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 3, 3, BLUEHEADRIGHT);
            intro_draw( 2, 3, BN_N_E      );
            intro_draw( 4, 3, FIRSTREVNUMBER + 3);
        acase INTRO_3:
            intro_draw(-1, 1, BLUEHEADRIGHT);
            intro_draw(-2, 1, BN_W_E      );
        acase INTRO_4:
            intro_draw( 1, 2, BLUEHEADRIGHT);
            intro_draw( 0, 2, BN_W_E      );
        acase INTRO_7:
            intro_draw( 1, 2, BLUEHEADRIGHT);
            intro_draw( 0, 2, BN_W_E      );
        acase INTRO_2:
            intro_draw( 2, 4, BLUEHEADDOWN);
            intro_draw( 2, 3, BN_N_S      );
        acase INTRO_5:
            intro_draw( 2, 1, BLUEHEADLEFT);
            intro_draw( 3, 1, BN_W_E      );
        acase INTRO_6:
            intro_draw(-4, 1, REDGLOWLEFT );
            intro_draw( 0, 1, BLUEGLOWLEFT);
            intro_draw( 4, 1, YELLOWGLOWLEFT    );
            intro_draw(-3, 1, RG_W_E      );
            intro_draw( 1, 1, BG_W_E      );
            intro_draw( 5, 1, YG_W_E      );
        acase INTRO_8:
            intro_draw(-1,-1, CLOUD       );
            intro_draw(-2,-1, EMPTY       );
            intro_draw( 3,-1, BLUEHEAD_NE );
            intro_draw( 2, 0, BN_NE_SW    );
        acase INTRO_9:
            intro_draw(-2, 2, BLUEHEAD_NW );
            intro_draw(-1, 3, BN_SE_NW    );
            intro_draw( 0, 1, FIRSTGLOW      + 2);
            intro_draw(-1, 2, FIRSTGLOW      + 2);
            intro_draw( 1, 2, FIRSTGLOW      + 2);
            intro_draw( 0, 3, FIRSTGLOW      + 2);
            intro_draw( 0, 2, FIRST50POINTS  + 2);
        acase INTRO_10:
            intro_draw( 4, 2, BLUEHEADRIGHT);
            intro_draw( 3, 2, BN_W_E      );
        acase INTRO_11:
            intro_draw( 2, 1, EMPTY       );
            intro_draw( 1, 1, FRAGMENT    );
            intro_draw(-2, 2, EMPTY       );
            intro_draw(-1, 2, FRAGMENT    );
            intro_draw( 3, 4, BN_W_E      );
            intro_draw( 4, 4, BLUEHEADRIGHT);
        acase INTRO_12:
            intro_draw(-1, 3, BN_W_E      );
            intro_draw( 0, 3, BLUEHEADRIGHT);
            intro_draw( 1, 1, YN_W_E      );
            intro_draw( 0, 1, YELLOWHEADLEFT    );
        }
    acase 9:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 4, 3, BLUEHEADRIGHT);
            intro_draw( 3, 3, BN_W_E      );
            intro_draw( 4, 1, FIRSTNUMBER    + 4);
        acase INTRO_4:
            intro_draw( 2, 2, BLUEHEADRIGHT);
            intro_draw( 1, 2, BN_W_E      );
            intro_draw( 3, 2, FIRSTFIRE + 2);
            intro_draw( 4, 2, FIRSTFIRE + 2);
            intro_draw( 5, 2, FIRSTFIRE + 2);
            intro_draw( 6, 2, FIRSTFIRE + 2);
            intro_draw( 7, 2, FIRSTFIRE + 2);
            intro_draw( 3, 2, EMPTY       );
            intro_draw( 4, 2, EMPTY       );
            intro_draw( 5, 2, EMPTY       );
            intro_draw( 6, 2, EMPTY       );
            intro_draw( 7, 2, EMPTY       );
        acase INTRO_7:
            intro_draw( 2, 2, BLUEHEADRIGHT);
            intro_draw( 1, 2, BN_W_E      );
        acase INTRO_2:
            intro_draw( 1, 4, BLUEHEADLEFT);
            intro_draw( 2, 4, BN_N_W      );
        acase INTRO_5:
            intro_draw( 2, 2, BLUEHEADDOWN);
            intro_draw( 2, 1, BN_S_E      );
        acase INTRO_11:
            intro_draw( 1, 1, EMPTY       );
            intro_draw( 0, 1, FRAGMENT    );
            intro_draw(-1, 2, EMPTY       );
            intro_draw( 0, 2, FRAGMENT    );
            intro_draw( 4, 4, BN_W_N      );
            intro_draw( 4, 3, BLUEHEADUP  );
        }
    acase 10:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 4, 2, BLUEHEADUP  );
            intro_draw( 4, 3, BN_N_W      );
            intro_draw( 4, 1, FIRSTREVNUMBER + 4);
        acase INTRO_3:
            intro_draw( 1, 1, BLUEHEADRIGHT);
            intro_draw(-1, 1, BN_W_E      );
        acase INTRO_4:
            intro_draw( 3, 2, BLUEHEADRIGHT);
            intro_draw( 2, 2, BN_W_E      );
        acase INTRO_7:
            intro_draw( 3, 2, BLUEHEADRIGHT);
            intro_draw( 2, 2, BN_W_E      );
        acase INTRO_2:
            intro_draw( 0, 4, BLUEHEADLEFT);
            intro_draw( 1, 4, BN_W_E      );
        acase INTRO_5:
            intro_draw(-2, 2, BLUEHEADDOWN);
            intro_draw( 2, 2, BN_N_S      );
        acase INTRO_11:
            intro_draw( 0, 1, EMPTY       );
            intro_draw(-1, 1, FRAGMENT    );
            intro_draw( 0, 2, EMPTY       );
            intro_draw( 1, 2, FRAGMENT    );
            intro_draw( 4, 3, BN_W_S      );
            intro_draw( 3, 3, BLUEHEADLEFT);
        acase INTRO_12:
            intro_draw( 0, 3, BN_W_E      );
            intro_draw( 1, 3, BLUEHEADRIGHT);
            intro_draw( 0, 1, YN_W_E      );
            intro_draw(-1, 1, YELLOWHEADLEFT    );
        }
    acase 11:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 4, 1, BLUEHEADUP  );
            intro_draw( 4, 2, BN_N_S      );
            intro_draw( 0, 0, FIRSTNUMBER    + 5);
        acase INTRO_4:
            intro_draw( 4, 2, BLUEHEADRIGHT);
            intro_draw( 3, 2, BN_W_E      );
        acase INTRO_7:
            intro_draw( 4, 2, BLUEHEADRIGHT);
            intro_draw( 3, 2, BN_W_E      );
        acase INTRO_2:
            intro_draw(-1, 4, BLUEHEADLEFT);
            intro_draw( 0, 4, BN_W_E      );
        acase INTRO_5:
            intro_draw(-2, 3, BLUEHEADDOWN);
            intro_draw(-2, 2, BN_N_S      );
        acase INTRO_9:
            intro_draw( 0, 2, FIRSTFLOWER    + 2);
        acase INTRO_11:
            intro_draw(-1, 1, EMPTY       );
            intro_draw(-2, 1, FRAGMENT    );
            intro_draw( 1, 2, EMPTY       );
            intro_draw( 2, 2, FRAGMENT    );
            intro_draw( 3, 3, BN_W_E      );
            intro_draw( 2, 3, BLUEHEADLEFT);
        }
    acase 12:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 3, 0, BLUEHEAD_NW );
            intro_draw( 4, 1, BN_NW_S     );
            intro_draw( 0, 0, FIRSTREVNUMBER + 5);
        acase INTRO_3:
            intro_draw( 2, 1, BLUEHEADRIGHT);
            intro_draw( 1, 1, BN_W_E      );
        acase INTRO_4:
            intro_draw( 5, 2, BLUEHEADRIGHT);
            intro_draw( 4, 2, BN_W_E      );
        acase INTRO_7:
            intro_draw( 5, 2, BLUEHEADRIGHT);
            intro_draw( 4, 2, BN_W_E      );
        acase INTRO_2:
            intro_draw(-2, 4, BLUEHEADLEFT);
            intro_draw(-1, 4, BN_W_E      );
        acase INTRO_5:
            intro_draw(-2, 4, BLUEHEADDOWN);
            intro_draw(-2, 3, BN_N_S      );
        acase INTRO_11:
            intro_draw(-2, 1, EMPTY       );
            intro_draw(-3, 1, FRAGMENT    );
            intro_draw( 2, 2, EMPTY       );
            intro_draw( 3, 2, FRAGMENT    );
            intro_draw( 2, 3, BN_W_E      );
            intro_draw( 1, 3, BLUEHEADLEFT);
        acase INTRO_12:
            intro_draw( 1, 3, BN_W_E      );
            intro_draw( 2, 3, BLUEHEADRIGHT);
            intro_draw(-1, 1, YN_W_E      );
            intro_draw(-2, 1, YELLOWHEADLEFT    );
        }
    acase 13:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 2, 0, BLUEHEADLEFT);
            intro_draw( 3, 0, BN_W_SE     );
            intro_draw( 0, 0, FIRSTNUMBER    + 5);
        acase INTRO_4:
            intro_draw( 6, 2, BLUEHEADRIGHT);
            intro_draw( 5, 2, BN_W_E      );
        acase INTRO_7:
            intro_draw( 6, 2, BLUEHEADRIGHT);
            intro_draw( 5, 2, BN_W_E      );
        acase INTRO_2:
            intro_draw(-2, 3, BLUEHEADUP  );
            intro_draw(-2, 4, BN_N_E      );
        acase INTRO_11:
            intro_draw(-3, 1, EMPTY       );
            intro_draw( 3, 2, EMPTY       );
            intro_draw( 2, 2, FRAGMENT    );
            intro_draw( 1, 3, BN_NW_E     );
            intro_draw( 0, 2, BLUEHEAD_NW );
        }
    acase 14:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 1, 0, BLUEHEADLEFT);
            intro_draw( 2, 0, BN_W_E      );
            intro_draw( 0, 0, FIRSTREVNUMBER + 5);
        acase INTRO_3:
            intro_draw( 3, 1, BLUEHEADRIGHT);
            intro_draw( 2, 1, BN_W_E      );
        acase INTRO_4:
            intro_draw( 7, 2, BLUEHEADRIGHT);
            intro_draw( 6, 2, BN_W_E      );
        acase INTRO_7:
            intro_draw( 7, 2, BLUEHEADRIGHT);
            intro_draw( 6, 2, BN_W_E      );
        acase INTRO_2:
            intro_draw(-2, 2, BLUEHEADUP  );
            intro_draw(-2, 3, BN_N_S      );
        acase INTRO_11:
            intro_draw( 2, 2, EMPTY       );
            intro_draw( 1, 2, FRAGMENT    );
            intro_draw( 0, 2, BN_NW_SE    );
            intro_draw(-1, 1, BLUEHEAD_NW );
        acase INTRO_12:
            intro_draw( 2, 3, BN_W_E      );
            intro_draw( 3, 3, BLUEHEADRIGHT);
            intro_draw(-2, 1, YN_W_E      );
            intro_draw(-3, 1, YELLOWHEADLEFT    );
        }
    acase 15:
        switch (level)
        {
        case INTRO_1:
            intro_draw( 0, 0, BLUEHEADLEFT);
            intro_draw( 1, 0, BN_W_E      );
            intro_draw(-2, 2, FIRSTNUMBER    + 6);
        acase INTRO_2:
            intro_draw(-2, 1, BLUEHEADUP  );
            intro_draw(-2, 2, BN_N_S      );
        acase INTRO_11:
            intro_draw( 1, 2, EMPTY       );
            intro_draw( 0, 2, FRAGMENT    );
            intro_draw(-1, 1, BN_NW_SE    );
            intro_draw(-2, 0, BLUEHEAD_NW );
        }
    acase 16:
        switch (level)
        {
        case INTRO_1:
            intro_draw(-1, 1, BLUEHEAD_SW );
            intro_draw( 0, 0, BN_E_SW     );
            intro_draw(-2, 2, FIRSTREVNUMBER + 6);
        acase INTRO_3:
            intro_draw( 4, 1, BLUEHEADRIGHT);
            intro_draw( 3, 1, BN_W_E      );
        acase INTRO_2:
            intro_draw(-2, 0, BLUEHEADUP  );
            intro_draw(-2, 1, BN_N_S      );
            intro_draw(-1, 1, FIRSTGLOW      + 2);
            intro_draw( 0, 1, FIRSTGLOW      + 2);
            intro_draw( 1, 1, FIRSTGLOW      + 2);
            intro_draw(-1, 2, FIRSTGLOW      + 2);
            intro_draw( 1, 2, FIRSTGLOW      + 2);
            intro_draw(-1, 3, FIRSTGLOW      + 2);
            intro_draw( 0, 3, FIRSTGLOW      + 2);
            intro_draw( 1, 3, FIRSTGLOW      + 2);
            intro_draw( 0, 2, FIRST50POINTS  + 2);
        acase INTRO_11:
            intro_draw( 0, 2, EMPTY       );
            intro_draw(-1, 2, FRAGMENT    );
            intro_draw(-2, 0, BN_E_SE     );
            intro_draw(-1, 0, BLUEHEADRIGHT);
        acase INTRO_12:
            intro_draw( 3, 3, BN_W_E      );
            intro_draw( 4, 3, BLUEHEADRIGHT);
            intro_draw(-3, 1, YN_W_E      );
            intro_draw(-4, 1, YELLOWHEADLEFT    );
        }
    acase 17:
        if (level == INTRO_1)
        {   intro_draw(-2, 2, BLUEHEAD_SW );
            intro_draw(-1, 1, BN_NE_SW    );
            intro_draw(-4, 0, FIRSTNUMBER    + 7);
        } elif (level == INTRO_11)
        {   intro_draw(-1, 2, EMPTY       );
            intro_draw(-2, 2, FRAGMENT    );
            intro_draw(-1, 0, BN_W_E      );
            intro_draw( 0, 0, BLUEHEADRIGHT);
        }
    acase 18:
        switch (level)
        {
        case INTRO_1:
            intro_draw(-3, 1, BLUEHEAD_NW );
            intro_draw(-2, 2, BN_NE_NW    );
            intro_draw(-4, 0, FIRSTREVNUMBER + 7);
        acase INTRO_3:
            intro_draw( 5, 1, BLUEHEADRIGHT);
            intro_draw( 4, 1, BN_W_E      );
        acase INTRO_11:
            intro_draw(-2, 2, EMPTY       );
            intro_draw(-3, 2, FRAGMENT    );
            intro_draw( 0, 0, BN_W_E      );
            intro_draw( 1, 0, BLUEHEADRIGHT);
        acase INTRO_12:
            intro_draw( 4, 3, BN_S_W      );
            intro_draw( 4, 4, BLUEHEADDOWN);
            intro_draw(-4, 1, YN_N_E      );
            intro_draw(-4, 0, YELLOWHEADUP);
        }
    acase 19:
        if (level == INTRO_1)
        {   intro_draw(-4, 0, BLUEHEAD_NW );
            intro_draw(-3, 1, BN_NW_SE    );
            intro_draw(-4, 4, FIRSTNUMBER    + 8);
        } elif (level == INTRO_2)
        {   intro_draw( 0, 2, FIRSTFLOWER    + 2);
        } elif (level == INTRO_11)
        {   intro_draw(-3, 2, EMPTY       );
            intro_draw(-2, 2, FRAGMENT    );
            intro_draw( 1, 0, BN_W_E      );
            intro_draw( 2, 0, BLUEHEADRIGHT);
        }
    acase 20:
        if (level == INTRO_1)
        {   intro_draw(-4, 1, BLUEHEADDOWN);
            intro_draw(-4, 0, BN_SE_S     );
            intro_draw(-4, 4, FIRSTREVNUMBER + 8);
        } elif (level == INTRO_3)
        {   intro_draw( 5, 2, BLUEHEADDOWN);
            intro_draw( 5, 1, BN_W_S      );
        } elif (level == INTRO_11)
        {   intro_draw(-2, 2, EMPTY       );
            intro_draw(-1, 2, FRAGMENT    );
            intro_draw( 2, 0, BN_W_E      );
            intro_draw( 3, 0, BLUEHEADRIGHT);
        }
    acase 21:
        if (level == INTRO_1)
        {   intro_draw(-4, 2, BLUEHEADDOWN);
            intro_draw(-4, 1, BN_N_S      );
            intro_draw(-4, 4, FIRSTNUMBER    + 8);
        } elif (level == INTRO_11)
        {   intro_draw(-1, 2, EMPTY       );
            intro_draw( 0, 2, FRAGMENT    );
            intro_draw( 3, 0, BN_W_E      );
            intro_draw( 4, 0, BLUEHEADRIGHT);
        }
    acase 22:
        if (level == INTRO_1)
        {   intro_draw(-4, 3, BLUEHEADDOWN);
            intro_draw(-4, 2, BN_N_S      );
            intro_draw(-4, 4, FIRSTREVNUMBER + 8);
        } elif (level == INTRO_3)
        {   intro_draw( 5, 3, BLUEHEADDOWN);
            intro_draw( 5, 2, BN_N_S      );
        }
    acase 23:
        if (level == INTRO_1)
        {   intro_draw(-4, 4, BLUEHEADDOWN);
            intro_draw(-4, 3, BN_N_S      );
        }
    acase 24:
        if (level == INTRO_3)
        {   intro_draw( 4, 3, BLUEHEADLEFT);
            intro_draw( 5, 3, BN_W_N      );
        }
    acase 25:
        if (level == INTRO_3)
        {   intro_draw( 3, 3, BLUEHEADLEFT);
            intro_draw( 4, 3, BN_W_E      );
        }
    acase 26:
        if (level == INTRO_3)
        {   intro_draw( 2, 3, BLUEHEADLEFT);
            intro_draw( 3, 3, BN_W_E      );
        }
    acase 27:
        if (level == INTRO_3)
        {   intro_draw( 1, 3, BLUEHEADLEFT);
            intro_draw( 2, 3, BN_W_E      );
        }
    acase 28:
        if (level == INTRO_3)
        {   intro_draw(-2, 3, BLUEHEADLEFT);
            intro_draw( 1, 3, BN_W_E      );
        }
    acase 29:
        if (level == INTRO_3)
        {   intro_draw(-3, 3, BLUEHEADLEFT);
            intro_draw(-2, 3, BN_W_E      );
        }
    acase 30:
        if (level == INTRO_3)
        {   intro_draw(-4, 3, BLUEHEADLEFT);
            intro_draw(-3, 3, BN_W_E      );
        }
    acase 31:
        if (level == INTRO_3)
        {   intro_draw(-5, 3, BLUEHEADLEFT);
            intro_draw(-4, 3, BN_W_E      );
}   }   }

EXPORT STRPTR getintrotext(void)
{   switch (level)
    {
    case  INTRO_1:  return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS,   "Collect or shoot numbers 1-9 to clear level.");
    acase INTRO_2:  return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS2,  "Make square enclosures to kill creatures.");
    acase INTRO_3:  return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS3,  "Jump further when moving faster.");
    acase INTRO_4:  return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS4,  "Some obstacles can be shot.");
    acase INTRO_5:  return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS5,  "These are teleports.");
    acase INTRO_6:  return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS6,  "Extra life every 1,000 points.");
    acase INTRO_7:  return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS7,  "Monkeys throw bananas; catch them for points.");
    acase INTRO_8:  return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS8,  "Go under clouds to catch rain.");
    acase INTRO_9:  return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS9,  "You can also make diagonal enclosures.");
    acase INTRO_10: return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS10, "Prefer your own colour for more points.");
    acase INTRO_11: return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS11, "Fragments bounce off metal.");
    acase INTRO_12: return (STRPTR) GetCatalogStr(CatalogPtr, MSG_INSTRUCTIONS12, "Worms can't turn while traversing frost.");
    adefault:       return "";
}   }
#endif

EXPORT FLAG isempty(int x, int y)
{   // assert(isvalid(x, y));

    if
    (   field[x][y] >= FIRSTEMPTY
     && field[x][y] <= LASTEMPTY
    )
    {   return TRUE;
    } else
    {   return FALSE;
}   }
EXPORT FLAG iswall(int x, int y)
{   // assert(isvalid(x, y));

    if
    (    field[x][y] == SLIME
     ||  field[x][y] == WOOD
     ||  field[x][y] == STONE
     ||  field[x][y] == METAL
    )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT void drawcreature(int which)
{   draw(creature[which].x, creature[which].y, getimage_creature(which));
    field[creature[which].x][creature[which].y] = creature[which].species;
}

EXPORT UWORD getdigit(int number)
{   if (number < 0 || number > 9)
    {   return MULTIPLICATION;
    } elif (number == 0)
    {   return ZERONUMBER;
    } else
    {   return (UWORD) ((FIRSTNUMBER) + number - 1);
}   }

MODULE void endoflevel(void)
{   UWORD counter[4] = {0, 0, 0, 0};
    int   i,
          player,
          x, y;

#ifndef TESTING
    turbo      = FALSE;
    superturbo = FALSE;
#endif

    for (player = 0; player <= 3; player++)
    {   if (worm[player].lives)
        {   for (x = 0; x <= fieldx; x++)
            {   for (y = 0; y <= fieldy; y++)
                {   if
                    (   field[x][y] == FIRSTTAIL + player
                     || field[x][y] == FIRSTGLOW + player
                    )
                    {   counter[player]++;
    }   }   }   }   }
    if   (counter[0] >= counter[1] && counter[0] >= counter[2] && counter[0] >= counter[3]) showing = 0;
    elif (counter[1] >= counter[0] && counter[1] >= counter[2] && counter[1] >= counter[3]) showing = 1;
    elif (counter[2] >= counter[0] && counter[2] >= counter[1] && counter[2] >= counter[3]) showing = 2;
    else                                                                                    showing = 3;

    quantity[0][0] = (ULONG) level;
    quantity[0][1] = (ULONG) BONUS_LEVEL * worm[showing].multi * players;
    quantity[0][2] = quantity[0][0] * quantity[0][1];

    quantity[1][0] = (ULONG) worm[showing].numbers;
    quantity[1][1] = (ULONG) BONUS_NUMBER * worm[showing].multi * players;
    quantity[1][2] = quantity[1][0] * quantity[1][1];

    quantity[2][0] = (ULONG) secondsleft;
    quantity[2][1] = (ULONG) BONUS_TIME * worm[showing].multi * players;
    quantity[2][2] = quantity[2][0] * quantity[2][1];

    quantity[3][0] = 0;
    for (x = 0; x <= fieldx; x++)
    {   for (y = 0; y <= fieldy; y++)
        {   if (field[x][y] == FIRSTTAIL + showing)
            {   quantity[3][0]++;
    }   }   }
    quantity[3][1] = (ULONG) BONUS_TAIL * worm[showing].multi * players;
    quantity[3][2] = quantity[3][0] * quantity[3][1];

    quantity[4][0] = 0;
    for (x = 0; x <= fieldx; x++)
    {   for (y = 0; y <= fieldy; y++)
        {   if (field[x][y] == FIRSTGLOW + showing)
            {   quantity[4][0]++;
    }   }   }
    quantity[4][1] = (ULONG) BONUS_GLOW * worm[showing].multi * players;
    quantity[4][2] = quantity[4][0] * quantity[4][1];

#ifndef AMIGA
    for (i = 0; i <= 4; i++)
    {   wormscore_unscaled(showing, quantity[i][2]);
    }
#endif

    if (level == 0)
    {   level = reallevel + 1;
        reallevel = 0;
    } else
    {   level++;
    }

    clearkybd();
    stopfx();
    effect(FXUSE_TELEPORT);
    clearscreen();
    outro();
#ifdef ANDROID
    credrawscreen();
#endif
    waitasec();
    anykey(FALSE, FALSE);

    if (level > levels)
    {   for (i = 0; i <= 3; i++)
        {   if (worm[i].lives)
            {   worm[i].levelreached = -1;
            }
#if !defined(ANDROID) && !defined(GBA)
            if (worm[player].control != NONE && worm[player].score >= worm[player].hiscore)
            {   worm[player].hiscore = worm[player].score;
            }
#endif
        }
        celebrate();
#if !defined(ANDROID) && !defined(GBA)
        newhiscores();
#endif
}   }

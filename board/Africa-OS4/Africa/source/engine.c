// INCLUDES---------------------------------------------------------------

#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#endif

#include <exec/types.h>

#include <proto/locale.h>
#include <proto/dos.h> // for Printf()

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <assert.h>

#include "shared.h"
#include "africa.h"

#define CATCOMP_NUMBERS
#include "africa_strings.h"

// DEFINES----------------------------------------------------------------

#define BATTLE_NR 0
#define BATTLE_AE 1
#define BATTLE_AR 2
#define BATTLE_DR 3
#define BATTLE_DE 4

/* EXPORTED VARIABLES-----------------------------------------------------

(None)

IMPORTED VARIABLES----------------------------------------------------- */

IMPORT struct AfroStruct  a[RAFRICANS];
IMPORT struct BoxStruct   box[6];
IMPORT struct EuroStruct  e[EUROPEANS];
IMPORT struct SetupStruct setup[RAFRICANS];
IMPORT struct CityStruct  city[CITIES];
IMPORT struct OrderStruct order[EUROPEANS][MAX_ORDERS];
IMPORT UBYTE              remapit[64];
IMPORT BOOL               autosetup,
                          colonial,
                          endless,
                          maintain,
                          ukiu;
IMPORT TEXT               saystring[256 + 1],
                          WhoTitle[80 + 1];
IMPORT FLAG               escaped,
                          fallen[RAFRICANS],
                          fresh[RAFRICANS],
                          ingame,
                          watchamiga;
IMPORT SLONG              xhex,
                          yhex,
                          players,
                          eattack_country,
                          eattack_army,
                          aattack_country[MAX_ARMIES],
                          aattack_army[MAX_ARMIES],
                          hexowner[MAPROWS][MAPCOLUMNS],
                          theround,
                          rounds,
                          score[EUROPEANS][MAX_ROUNDS + 1];
IMPORT ULONG              enabled[EUROPEANS + RAFRICANS];
IMPORT struct Catalog*    CatalogPtr;

// MODULE VARIABLES-------------------------------------------------------

MODULE FLAG               eattacking,
                          aattacking[MAX_ARMIES];
MODULE SLONG              cash,
                          emoves,
                          amoves[MAX_ARMIES],
                          ret_country,
                          ret_army;

MODULE SLONG cityflag[MAPROWS][MAPCOLUMNS] =
{ { NON, NON, NON,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0      },
  {     1,   0,   0,   0,   0,   1,   0,   0,   1,   0,   0,   0    , NON},
  {   0,   0,   0,   0,   0,   0,   0,   0,   0, NON,   1,   0,   0      },
  {     0,   1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1    , NON},
  { NON,   0,   1,   0,   0,   0,   0,   0,   1,   0,   0,   0, NON      },
  {   NON,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1, NON    , NON},
  { NON, NON,   1,   0,   0,   0,   1,   0,   0,   0,   0,   0, NON      },
  {   NON,   0,   0,   0,   0,   0,   0,   1,   0,   0,   0,   0    , NON},
  { NON, NON,   1,   0,   0,   0,   0,   0,   0,   0,   0,   1, NON      },
  {   NON,   0,   0,   0,   0,   0,   1,   0,   0,   1,   0, NON    , NON},
  { NON, NON,   0,   0,   0,   0,   0,   0,   1,   1,   0, NON, NON      },
  {   NON,   0,   0,   0,   0,   0,   1,   0,   0, NON, NON, NON    , NON},
  { NON, NON,   1,   1,   0,   1,   0,   0,   0,   0, NON, NON, NON      },
  {   NON, NON,   0,   0,   0,   0,   1,   0,   0, NON, NON, NON    , NON},
  { NON, NON, NON,   0,   0,   0,   0,   0,   0, NON, NON, NON, NON      },
  {   NON, NON, NON,   0,   0,   1,   0,   1, NON, NON, NON, NON    , NON},
  { NON, NON, NON, NON,   0,   0,   0,   0, NON, NON, NON, NON, NON      },
  {   NON, NON, NON,   1,   0, NON, NON, NON, NON, NON, NON, NON    , NON}
};

MODULE UBYTE neighbours[LAFRICANS][LAFRICANS] =
{
// SAF NAM BOT RHO MOZ ANG ZAM MAL GAB CON ZAI TAN UGA KEN
  { 2,  1,  1,  1,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0 }, // SAF
  { 1,  2,  1,  0,  0,  1,  0,  0,  0,  0,  0,  0,  0,  0 }, // NAM
  { 1,  1,  2,  1,  0,  1,  1,  0,  0,  0,  0,  0,  0,  0 }, // BOT
  { 1,  0,  1,  2,  1,  0,  1,  0,  0,  0,  0,  0,  0,  0 }, // RHO
  { 1,  0,  0,  1,  2,  0,  1,  1,  0,  0,  0,  1,  0,  0 }, // MOZ
  { 0,  1,  1,  0,  0,  2,  1,  0,  0,  0,  1,  0,  0,  0 }, // ANG
  { 0,  0,  1,  1,  1,  1,  2,  1,  0,  0,  1,  1,  0,  0 }, // ZAM
  { 0,  0,  0,  0,  1,  0,  1,  2,  0,  0,  0,  1,  0,  0 }, // MAL
  { 0,  0,  0,  0,  0,  0,  0,  0,  2,  1,  0,  0,  0,  0 }, // GAB
  { 0,  0,  0,  0,  0,  0,  0,  0,  1,  2,  1,  0,  0,  0 }, // CON
  { 0,  0,  0,  0,  0,  1,  1,  0,  0,  1,  2,  1,  1,  0 }, // ZAI
  { 0,  0,  0,  0,  1,  0,  1,  1,  0,  0,  1,  2,  1,  1 }, // TAN
  { 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  1,  2,  1 }, // UGA
  { 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  1,  2 }  // KEN
};

MODULE SLONG xcoords[2][6] = { {-1,  0, -1,  1, -1,  0},   // even rows
                               { 0,  1, -1,  1,  0,  1} }, // odd rows
             ycoords[6]    =   {-1, -1,  0,  0,  1,  1};
/* Arranged thus:  0 1
                  2 * 3
                   4 5 */

// MODULE FUNCTIONS-------------------------------------------------------

MODULE void place_army(SLONG we, SLONG wa, SLONG war);
MODULE void place_govt(SLONG we, SLONG wa, SLONG govt);
MODULE void readorders(void);
MODULE void assassinate(void);
MODULE SLONG die(void);
MODULE FLAG vacant(SLONG x, SLONG y);
MODULE void africans(void);
MODULE void dobattles(SLONG we, SLONG  wa);
MODULE FLAG zoc(SLONG wa, SLONG x, SLONG y);
MODULE void emove_human(SLONG we, FLAG rout);
MODULE void amove_human(SLONG we, SLONG wa, SLONG war, FLAG rout);
MODULE void eattack_amiga(SLONG we);
MODULE void aattack_amiga(SLONG wa, SLONG war);
MODULE void place_amiga(SLONG wa);
MODULE void adie(SLONG wa, SLONG war, FLAG refresh);
MODULE void edie(SLONG we, FLAG refresh);
MODULE FLAG nexttoourcity(SLONG wa, SLONG x, SLONG y);
MODULE SLONG movable(SLONG wa, SLONG x, SLONG y);
MODULE void erout_amiga(SLONG we);
MODULE void arout_amiga(SLONG wa, SLONG war);
MODULE void emove_amiga(SLONG we);
MODULE void amove_amiga(SLONG wa, SLONG war);
MODULE FLAG evaluate(SLONG wa, SLONG x, SLONG y);
MODULE void advance(SLONG we, SLONG wa, SLONG x, SLONG y);
MODULE void eincome(void);
MODULE void writeorders_amiga(SLONG we);
MODULE void checkowners(void);
MODULE FLAG hate(SLONG wa, SLONG we);
MODULE void deselect_combatants(SLONG we, SLONG wa, SLONG victimcountry, SLONG victimarmy);
MODULE FLAG takecity(SLONG wa, SLONG wc);
MODULE SLONG whichcity(SLONG x, SLONG y);
MODULE FLAG selectmover(SLONG we, SLONG wa);
MODULE void notwar(int first, int second);
MODULE FLAG canflee_euro(SLONG we);
MODULE FLAG canflee_afro(SLONG wa, SLONG war);
MODULE FLAG addorder(int we, int wo, int command, int dest, int fee, int data1);

// CODE-------------------------------------------------------------------

EXPORT SLONG govtx(SLONG wa)
{   if (a[wa].govt == OTHER)
    {   return -1;
    }

    return a[wa].army[a[wa].govtarmy].x;
}

EXPORT SLONG govty(SLONG wa)
{   if (a[wa].govt == OTHER)
    {   return -1;
    }

    return a[wa].army[a[wa].govtarmy].y;
}

MODULE void adie(SLONG wa, SLONG war, FLAG refresh)
{   // coon cheese factory

    a[wa].army[war].alive = FALSE;
    if
    (   a[wa].govt != OTHER
     && govtx(wa) == a[wa].army[war].x
     && govty(wa) == a[wa].army[war].y
    )
    {   a[wa].govt = OTHER;
        killgovt(a[wa].aruler, a[wa].govtarmy, FALSE); // this is needed, for next time the counter is used?
    }
    remove_army(wa, war, refresh);
    if (a[wa].is > 0)
    {   a[wa].is--;
        drawtables();
}   }

MODULE void edie(SLONG we, FLAG refresh)
{   e[we].iu = FALSE;
    remove_iu(we, refresh);
}

EXPORT SLONG whosehex(SLONG x, SLONG y)
{   // SLONG wc;

    if (!valid(x, y) || hexowner[y][x] == NON)
    {   return -1;
    }

/*  for (wc = 0; wc < CITIES; wc++)
    {   if (city[wc].x == x && city[wc].y == y)
        {   return city[wc].aruler;
    }   } */

    return a[hexowner[y][x]].aruler;
}

MODULE SLONG whichcity(SLONG x, SLONG y)
{   SLONG wc;

    for (wc = 0; wc < CITIES; wc++)
    {   if (city[wc].x == x && city[wc].y == y)
        {   return wc;
    }   }

    return -1;
}

MODULE FLAG nexttoourcity(SLONG wa, SLONG x, SLONG y)
{   SLONG wc,
          xx,
          yy;

    // answers the question: "are we next to a home/conquered city?"

    // assert(valid(x, y));

    // look at central hex
    if (whosehex(x, y) == wa % LAFRICANS && cityflag[y][x] == 1)
    {   wc = whichcity(x, y);
        if (wc != -1)
        {   if (city[wc].aruler == wa)
            {   return TRUE; // in a city
        }   }
        else
        {   ; // assert(0);
    }   }

    // look at northwest hex
    if (y % 2 == 0)
    {   xx = x - 1;
    } else
    {   xx = x;
    }
    yy = y - 1;
    if (valid(xx, yy) && whosehex(xx, yy) == wa % LAFRICANS && cityflag[yy][xx] == 1)
    {   wc = whichcity(xx, yy);
        if (wc != -1)
        {   if (city[wc].aruler == wa)
            {   return TRUE; // in our city
        }   }
        else
        {   ; // assert(0);
    }   }

    // look at northeast hex
    if (y % 2 == 0)
    {   xx = x;
    } else
    {   xx = x + 1;
    }
    // yy = y - 1;
    if (valid(xx, yy) && whosehex(xx, yy) == wa % LAFRICANS && cityflag[yy][xx] == 1)
    {   wc = whichcity(xx, yy);
        if (wc != -1)
        {   if (city[wc].aruler == wa)
            {   return TRUE; // in our city
        }   }
        else
        {   ; // assert(0);
    }   }

    // look at west hex
    xx = x - 1;
    yy = y;
    if (valid(xx, yy) && whosehex(xx, yy) == wa % LAFRICANS && cityflag[yy][xx] == 1)
    {   wc = whichcity(xx, yy);
        if (wc != -1)
        {   if (city[wc].aruler == wa)
            {   return TRUE; // in our city
        }   }
        else
        {   ; // assert(0);
    }   }

    // look at east hex
    xx = x + 1;
    // yy = y;
    if (valid(xx, yy) && whosehex(xx, yy) == wa % LAFRICANS && cityflag[yy][xx] == 1)
    {   wc = whichcity(xx, yy);
        if (wc != -1)
        {   if (city[wc].aruler == wa)
            {   return TRUE; // in our city
        }   }
        else
        {   ; // assert(0);
    }   }

    // look at southwest hex
    if (y % 2 == 0)
    {   xx = x - 1;
    } else
    {   xx = x;
    }
    yy = y + 1;
    if (valid(xx, yy) && whosehex(xx, yy) == wa % LAFRICANS && cityflag[yy][xx] == 1)
    {   wc = whichcity(xx, yy);
        if (wc != -1)
        {   if (city[wc].aruler == wa)
            {   return TRUE; // in our city
        }   }
        else
        {   ; // assert(0);
    }   }

    // look at southeast hex
    if (y % 2 == 0)
    {   xx = x;
    } else
    {   xx = x + 1;
    }
    // yy = y + 1;
    if (valid(xx, yy) && whosehex(xx, yy) == wa % LAFRICANS && cityflag[yy][xx] == 1)
    {   wc = whichcity(xx, yy);
        if (wc != -1)
        {   if (city[wc].aruler == wa)
            {   return TRUE; // in our city
        }   }
        else
        {   ; // assert(0);
    }   }

    return FALSE;
}

MODULE SLONG movable(SLONG wa, SLONG x, SLONG y)
{   /* We can move there if it is:
        (a) our country (home or conquered);
        (b) under military control by the same european; or
        (c) we have declared war on it.

    wa is OUR (the mover's) wa.
    x, y are the DESTINATION x, y (ie. where we want to go).

    return code of 0 means: can't move there
                   1        can move there because it is us
                   2        can move there because enemy
                   3        can move there because friendly

    Note that it doesn't call nextto()!

    Note also that it is order-dependent. */

    if
    (   whosehex(x, y) == wa // we own this hex
    )
    {   return 1;
    }

    if
    (   a[wa].pi >= 1
     && a[wa].eruler == a[whosehex(x, y)].eruler
     && a[whosehex(x, y)].pi >= MILITARY_CONTROL
    ) // this hex is under a friendly military control
    {   return 3;
    }

    if
    (   a[wa].declared[             whosehex(x, y) % LAFRICANS ]
     || a[wa].declared[LAFRICANS + (whosehex(x, y) % LAFRICANS)]
    )
    {   return 2;
    }

    return 0;
}

EXPORT FLAG checkattack(SLONG wa, SLONG wa2, SLONG x, SLONG y, FLAG human)
{   /* wa is the attacker
       wa2 is the defender
       x, y are coordinates of the defending army */

    if (wa == wa2)
    {   return FALSE;
    }

    if
    (   !a[wa].declared[wa2] // we're not at war with them
     && whosehex(x, y) != wa // and this isn't our country
    )
    {   if (human)
        {   notwar(wa, wa2);
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
        }
        return FALSE;
    }

    if
    (   wa  == LAFRICANS + wa2           // if loyalists fighting rebels
     || wa2 == LAFRICANS + wa            // or rebels fighting loyalists
     || whosehex(x, y) == wa             // or we are loyalists fighting a foreign power in our homeland
     || whosehex(x, y) == LAFRICANS + wa // or we are rebels    fighting a foreign power in our homeland
    )
    {   if (a[wa].pi < POLITICAL_CONTROL)
        {   if (human)
            {   if (wa < LAFRICANS)
                {   sprintf
                    (   saystring,
                        LLL(MSG_IS_NUPC, "%s is not under political control."),
                        a[wa].name
                    );
                } else
                {   sprintf
                    (   saystring,
                        LLL(MSG_ARE_NUPC, "%s are not under political control."),
                        a[wa].name
                    );
                }
                say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                anykey();
            }
            return FALSE;
    }   }
    else
    {   if (a[wa].pi < MILITARY_CONTROL)
        {   if (human)
            {   if (wa < LAFRICANS)
                {   sprintf
                    (   saystring,
                        LLL(MSG_IS_NUMC, "%s is not under military control."),
                        a[wa].name
                    );
                } else
                {   sprintf
                    (   saystring,
                        LLL(MSG_ARE_NUMC, "%s are not under military control."),
                        a[wa].name
                    );
                }
                say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                anykey();
            }
            return FALSE;
    }   }

    return TRUE;
}

MODULE void advance(SLONG we, SLONG wa, SLONG x, SLONG y)
{   SLONG eventresult,
          war;

    if (!movable(wa, x, y)) // if we aren't allowed to move into this hex
    {   return;
    }

    // select attackers
    if (eattacking)
    {   select_iu(we, FALSE);
    }
    for (war = 0; war < setup[wa].maxarmies; war++)
    {   if (aattacking[war])
        {   select_army(wa, war, FALSE);
    }   }
    updatescreen();

    if (e[we].control == CONTROL_HUMAN)
    {   sprintf
        (   saystring,
            LLL(MSG_ADVANCE, "%s, advance which IU/army into conquered hex (Esc for none)?"),
            e[we].name
        );
        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_ARMY, "Army"), (STRPTR) LLL(MSG_NONE, "None"));

        for (;;)
        {   escaped = FALSE;
            eventresult = getevent(HEX);
            if (escaped)
            {   goto ADVANCE_DONE;
            } elif (eventresult != -1)
            {   if
                (   eattacking
                 && e[we].iux == xhex
                 && e[we].iuy == yhex
                )
                {   // assert(e[we].iu);

                    // move the European IU into the conquered hex

                    e[we].iux = x;
                    e[we].iuy = y;
                    move_iu(we, TRUE);

                    goto ADVANCE_DONE;
                } else
                {   for (war = 0; war < setup[wa].maxarmies; war++)
                    {   if
                        (   aattacking[war]
                         && a[wa].army[war].x == xhex
                         && a[wa].army[war].y == yhex
                        )
                        {   // assert(a[wa].army[war].alive);

                            // move the African army into the conquered hex

                            a[wa].army[war].x = x;
                            a[wa].army[war].y = y;
                            move_army(wa, war, TRUE);

                            goto ADVANCE_DONE;
    }   }   }   }   }   }
    else
    {   // assert(e[we].control == CONTROL_AMIGA);

        if (eattacking)
        {   // assert(e[we].iu);

            e[we].iux = x;
            e[we].iuy = y;
            move_iu(we, TRUE);

            goto ADVANCE_DONE;
        }

        for (war = 0; war < setup[wa].maxarmies; war++)
        {   if (aattacking[war])
            {   // assert(a[wa].army[war].alive);

                a[wa].army[war].x = x;
                a[wa].army[war].y = y;
                move_army(wa, war, TRUE);

                goto ADVANCE_DONE;
    }   }   }

ADVANCE_DONE:
    // deselect attackers
    if (eattacking)
    {   deselect_iu(we, FALSE);
    }
    for (war = 0; war < setup[wa].maxarmies; war++)
    {   if (aattacking[war])
        {   deselect_army(wa, war, FALSE);
    }   }
    updatescreen();
}

MODULE FLAG evaluate(SLONG wa, SLONG x, SLONG y)
{   SLONG we,
          wa2,
          war;

    // look for an enemy in this hex

    for (we = 0; we < players; we++)
    {   if
        (   we != a[wa].eruler
         && e[we].iu
         && e[we].iux == x
         && e[we].iuy == y
        )
        {   if (checkattack(wa, e[we].iuhost, x, y, FALSE))
            {   ret_country = we;
                ret_army = -1;
                return TRUE;
    }   }   }

    for (wa2 = 0; wa2 < RAFRICANS; wa2++)
    {   if (wa != wa2)
        {   war = ourarmy(wa2, x, y);
            if (war != -1)
            {   if (checkattack(wa, wa2, x, y, FALSE))
                {   ret_country = EUROPEANS + wa2;
                    ret_army = war;
                    return TRUE;
    }   }   }   }

    // if a European: ret_country = European, ret_army = -1
    // if an African: ret_country = African,  ret_army >= 0

    return FALSE;
}

MODULE void arout_amiga(SLONG wa, SLONG war)
{   SLONG i,
          wh;

    /* Amiga only ever bothers to rout itself by one hex, this is usually
    better strategically anyway. */

    select_army(wa, war, TRUE);
    wh = die() - 1;

    for (i = 0; i <= 5; i++)
    {   if (wh == 5)
        {   wh = 0;
        } else wh++;

        xhex = a[wa].army[war].x + xcoords[a[wa].army[war].y % 2][wh];
        yhex = a[wa].army[war].y + ycoords[wh];

        if
        (   valid(xhex, yhex)
         && vacant(xhex, yhex)
         && nextto(a[wa].army[war].x, a[wa].army[war].y, xhex, yhex)
         && movable(wa, xhex, yhex)
         && !zoc(wa, xhex, yhex)
        )
        {   // assert(nextto(a[wa].army[war].x, a[wa].army[war].y, xhex, yhex));

            a[wa].army[war].x = xhex;
            a[wa].army[war].y = yhex;
            move_army(wa, war, TRUE);
            deselect_army(wa, war, TRUE);
            return;
    }   }

    sprintf
    (   saystring,
        LLL(MSG_UNABLEARMY, "%s's army is unable to escape."),
        a[wa].name
    );
    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
    anykey();

    adie(wa, war, TRUE); // no escape possible, give up
}

MODULE void emove_human(SLONG we, FLAG rout)
{   SLONG moves,
          oldx    = -1,
          oldy    = -1,
          result,
          startx,
          starty;
    int   wb;

    select_iu(we, TRUE);

    startx = e[we].iux;
    starty = e[we].iuy;

    if (rout) moves = 2; else moves = 5;

    // assert(emoves < 5);
    for (;;)
    {
EMOVE_DO:
        if (rout)
        {   if (emoves == 0)
            {   if (canflee_euro(we))
                {   sprintf
                    (   saystring,
                        LLL(MSG_ROUTIU1, "%s, rout 1 of 2 for IU attached to %s (Esc to surrender)..."),
                        e[we].name,
                        a[e[we].iuhost].name
                    );
                    say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_HEX, "Hex"), (STRPTR) LLL(MSG_SURRENDER, "Surrender"));
                } else
                {   sprintf
                    (   saystring,
                        LLL(MSG_UNABLEIU, "%s's IU is unable to escape."),
                        e[we].name
                    );
                    say(UPPER, AFROCOLOUR + e[we].iuhost, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
                    goto EMOVE_DONE;
            }   }
            else
            {   // assert(emoves == 1);
                sprintf
                (   saystring,
                    LLL(MSG_ROUTIU2, "%s, rout 2 of 2 for IU attached to %s (Backspace to undo, Esc to stay)..."),
                    e[we].name,
                    a[e[we].iuhost].name
                );
                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_HEX, "Hex"), (STRPTR) LLL(MSG_STAY, "Stay"));
        }   }
        else
        {   if (oldx == -1)
            {   sprintf
                (   saystring,
                    LLL(MSG_MOVEIU,  "%s, move %d of 5 for IU attached to %s (Esc to stay)..."),
                    e[we].name,
                    emoves + 1,
                    a[e[we].iuhost].name
                );
            } else
            {   sprintf
                (   saystring,
                    LLL(MSG_MOVEIU2, "%s, move %d of 5 for IU attached to %s (Backspace to undo, Esc to stay)..."),
                    e[we].name,
                    emoves + 1,
                    a[e[we].iuhost].name
                );
            }
            say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_HEX, "Hex"), (STRPTR) LLL(MSG_STAY, "Stay"));
        }

        for (wb = 0; wb < 6; wb++)
        {   xhex = e[we].iux + xcoords[e[we].iuy % 2][wb];
            yhex = e[we].iuy + ycoords               [wb];
            if
            (   valid(xhex, yhex)
             && vacant(xhex, yhex)
             && movable(e[we].iuhost, xhex, yhex)
             && (!rout || ((xhex != startx || yhex != starty) && !zoc(e[we].iuhost, xhex, yhex)))
            )
            {   box[wb].x = xhex;
                box[wb].y = yhex;
                if (zoc(e[we].iuhost, xhex, yhex))
                {   box[wb].kind = 1;
                } else
                {   box[wb].kind = 0;
            }   }
            else
            {   box[wb].x =
                box[wb].y = -1;
        }   }

        escaped = FALSE;
        result = getevent(HEX);

        if (result == -1)
        {   if (escaped)
            {   goto EMOVE_DONE;
            } else
            {   goto EMOVE_DO;
        }   }
        if (result == -2)
        {   if (oldx != -1)
            {   // assert(oldy != -1);
                e[we].iux = oldx;
                e[we].iuy = oldy;
                oldx =
                oldy = -1;
                move_iu(we, TRUE);
                emoves--;
                goto EMOVE_DO;
            } else
            {   // assert(oldy == -1);
                goto EMOVE_DO;
        }   }
        if (!valid(xhex, yhex))
        {   /* strcpy(saystring, "Not a valid hex.");
            say(UPPER, AFROCOLOUR + e[we].iuhost, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey(); */
            goto EMOVE_DO;
        }
        if (!vacant(xhex, yhex))
        {   strcpy(saystring, LLL(MSG_NOTEMPTY, "Hex is not empty."));
            say(UPPER, AFROCOLOUR + e[we].iuhost, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            goto EMOVE_DO;
        }
        if (!nextto(e[we].iux, e[we].iuy, xhex, yhex))
        {   strcpy(saystring, LLL(MSG_NOTADJACENT, "Not an adjacent hex."));
            say(UPPER, AFROCOLOUR + e[we].iuhost, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            goto EMOVE_DO;
        }
        if (!movable(e[we].iuhost, xhex, yhex))
        {   strcpy(saystring, LLL(MSG_NOTATWAR, "Not at war with or allied to this country."));
            say(UPPER, AFROCOLOUR + e[we].iuhost, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            goto EMOVE_DO;
        }
        if (rout && xhex == startx && yhex == starty)
        {   strcpy(saystring, LLL(MSG_JUSTMOVED, "Just moved from there."));
            say(UPPER, AFROCOLOUR + e[we].iuhost, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            goto EMOVE_DO;
        }
        if (rout && zoc(e[we].iuhost, xhex, yhex))
        {   strcpy(saystring, LLL(MSG_ZOC, "Hex is in enemy Zone of Control."));
            say(UPPER, AFROCOLOUR + e[we].iuhost, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            goto EMOVE_DO;
        }

        oldx = e[we].iux;
        oldy = e[we].iuy;
        e[we].iux = xhex;
        e[we].iuy = yhex;
        move_iu(we, TRUE);
        emoves++;
        if (zoc(e[we].iuhost, xhex, yhex))
        {   // assert(!rout);
            emoves = 5;
            goto EMOVE_DONE;
        }
        if (emoves == moves)
        {   goto EMOVE_DONE;
    }   }

EMOVE_DONE:
    if (rout && emoves == 0)
    {   edie(we, TRUE);
    } else
    {   deselect_iu(we, TRUE);
}   }

MODULE void amove_human(SLONG we, SLONG wa, SLONG war, FLAG rout)
{   SLONG moves,
          oldx    = -1,
          oldy    = -1,
          result,
          startx,
          starty;
    int   wb;

    select_army(wa, war, TRUE);

    startx = a[wa].army[war].x;
    starty = a[wa].army[war].y;

    if (rout) moves = 2; else moves = 5;

    // assert(amoves[war] < 5);
    for (;;)
    {
AMOVE_DO:
        if (rout)
        {   if (amoves[war] == 0)
            {   if (canflee_afro(wa, war))
                {   sprintf
                    (   saystring,
                        LLL(MSG_ROUTARMY1, "%s, rout 1 of 2 for %s's army (Esc to surrender)..."),
                        e[we].name,
                        a[wa].name
                    );
                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_HEX, "Hex"), (STRPTR) LLL(MSG_SURRENDER, "Surrender"));
                } else
                {   sprintf
                    (   saystring,
                        LLL(MSG_UNABLEARMY, "%s's army is unable to escape."),
                        a[wa].name
                    );
                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
                    goto AMOVE_DONE;
            }   }
            else
            {   // assert(amoves[war] == 1);
                sprintf
                (   saystring,
                    LLL(MSG_ROUTARMY2, "%s, rout 2 of 2 for %s's army (Backspace to undo, Esc to stay)..."),
                    e[we].name,
                    a[wa].name
                );
                say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_HEX, "Hex"), (STRPTR) LLL(MSG_STAY, "Stay"));
        }   }
        else
        {   if (oldx == -1)
            {   sprintf
                (   saystring,
                    LLL(MSG_MOVEARMY,  "%s, move %d of 5 for %s's army (Esc to stay)..."),
                    e[we].name,
                    amoves[war] + 1,
                    a[wa].name
                );
            } else
            {   sprintf
                (   saystring,
                    LLL(MSG_MOVEARMY2, "%s, move %d of 5 for %s's army (Backspace to undo, Esc to stay)..."),
                    e[we].name,
                    amoves[war] + 1,
                    a[wa].name
                );
            }
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_HEX, "Hex"), (STRPTR) LLL(MSG_STAY, "Stay"));
        }

        for (wb = 0; wb < 6; wb++)
        {   xhex = a[wa].army[war].x + xcoords[a[wa].army[war].y % 2][wb];
            yhex = a[wa].army[war].y + ycoords                       [wb];
            if
            (   valid(xhex, yhex)
             && vacant(xhex, yhex)
             && movable(wa, xhex, yhex)
             && (!rout || ((xhex != startx || yhex != starty) && !zoc(wa, xhex, yhex)))
            )
            {   box[wb].x = xhex;
                box[wb].y = yhex;
                if (zoc(wa, xhex, yhex))
                {   box[wb].kind = 1;
                } else
                {   box[wb].kind = 0;
            }   }
            else
            {   box[wb].x =
                box[wb].y = -1;
        }   }

        escaped = FALSE;
        result = getevent(HEX);

        if (result == -1)
        {   if (escaped)
            {   goto AMOVE_DONE;
            } else
            {   goto AMOVE_DO;
        }   }
        if (result == -2)
        {   if (oldx != -1)
            {   // assert(oldy != -1);
                a[wa].army[war].x = oldx;
                a[wa].army[war].y = oldy;
                oldx =
                oldy = -1;
                move_army(wa, war, TRUE);
                amoves[war]--;
                goto AMOVE_DO;
            } else
            {   // assert(oldy == -1);
                goto AMOVE_DO;
        }   }
        if (!valid(xhex, yhex))
        {   /* strcpy(saystring, "Not a valid hex.");
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey(); */
            goto AMOVE_DO;
        }
        if (!vacant(xhex, yhex))
        {   strcpy(saystring, LLL(MSG_NOTEMPTY, "Hex is not empty."));
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            goto AMOVE_DO;
        }
        if (!nextto(a[wa].army[war].x, a[wa].army[war].y, xhex, yhex))
        {   strcpy(saystring, LLL(MSG_NOTADJACENT, "Not an adjacent hex."));
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            goto AMOVE_DO;
        }
        if (!movable(wa, xhex, yhex))
        {   strcpy(saystring, LLL(MSG_NOTATWAR, "Not at war with or allied to this country."));
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            goto AMOVE_DO;
        }
        if (rout && xhex == startx && yhex == starty)
        {   strcpy(saystring, LLL(MSG_JUSTMOVED, "Just moved from there."));
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            goto AMOVE_DO;
        }
        if (rout && zoc(wa, xhex, yhex))
        {   strcpy(saystring, LLL(MSG_ZOC, "Hex is in enemy Zone of Control."));
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            goto AMOVE_DO;
        }

        oldx = a[wa].army[war].x;
        oldy = a[wa].army[war].y;
        a[wa].army[war].x = xhex;
        a[wa].army[war].y = yhex;
        move_army(wa, war, TRUE);
        amoves[war]++;
        if (zoc(wa, xhex, yhex))
        {   // assert(!rout);
            amoves[war] = 5;
            goto AMOVE_DONE;
        }
        if (amoves[war] == moves)
        {   goto AMOVE_DONE;
    }   }

AMOVE_DONE:
    if (rout && amoves[war] == 0)
    {   adie(wa, war, TRUE);
    } else
    {   deselect_army(wa, war, TRUE);
}   }

MODULE void dobattles(SLONG we, SLONG wa)
{   SLONG attackstrength,
          battle           = -1, // to avoid spurious compiler warnings
          defendstrength,
          odds,
          roll,
          victimcountry,
          victimarmy,
          victimx,
          victimy,
          war;
    TEXT  oddstring[4 + 1];

    for (;;)
    {   eattacking = FALSE;
        for (war = 0; war < setup[wa].maxarmies; war++)
        {   aattacking[war] = FALSE;
        }

        victimcountry =
        victimarmy    = -1;
        // find "lead attacker"
        if (e[we].iu && eattack_country != -1)
        {   victimcountry = eattack_country;
            victimarmy    = eattack_army;
        } else
        {   for (war = 0; war < setup[wa].maxarmies; war++)
            {   if (a[wa].army[war].alive && aattack_country[war] != -1)
                {   victimcountry = aattack_country[war];
                    victimarmy    = aattack_army[war];
                    break;
        }   }   }
        if (victimcountry == -1) // no further attacks to carry out
        {   return;
        }
#ifdef EXTRAVERBOSE
        Printf("Victim country is %ld. Victim army is %ld.\n", victimcountry, victimarmy);
#endif
        // find and select all attackers
        if
        (   e[we].iu
         && e[we].iuhost == wa
         && eattack_country == victimcountry
         && eattack_army    == victimarmy
        )
        {   eattacking = TRUE;
            select_iu(we, FALSE);
        }
        for (war = 0; war < setup[wa].maxarmies; war++)
        {   if
            (   a[wa].army[war].alive
             && aattack_country[war] == victimcountry
             && aattack_army[war]    == victimarmy
            )
            {   aattacking[war] = TRUE;
                select_army(wa, war, FALSE);
        }   }

        // select defender
        if (victimcountry < EUROPEANS)
        {   select_iu(victimcountry, FALSE);
            sprintf
            (   saystring,
                (wa < LAFRICANS) ? LLL(MSG_ATTACKS, "%s attacks %s.") : LLL(MSG_ATTACK, "%s attack %s."),
                a[wa].name,
                a[e[victimcountry].iuhost].name
            );
        } else
        {   select_army(victimcountry - EUROPEANS, victimarmy, FALSE);
            sprintf
            (   saystring,
                (wa < LAFRICANS) ? LLL(MSG_ATTACKS, "%s attacks %s.") : LLL(MSG_ATTACK, "%s attack %s."),
                a[wa].name,
                a[victimcountry - EUROPEANS].name
            );
        }

        // updatescreen() not needed as say() does it
        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey();

        // determine attacking strength
        attackstrength = 0;
        if (eattacking)
        {   if (we == USA || we == USSR)
            {   attackstrength += 200;
            } else
            {   attackstrength += 100;
        }   }
        for (war = 0; war < setup[wa].maxarmies; war++)
        {   if (aattacking[war])
            {   if (a[wa].is <= 6)
                {   attackstrength += 50;
                } else
                {   attackstrength += 100;
        }   }   }

        // determine defending strength
        if (victimcountry < EUROPEANS)
        {   if (victimcountry == USA || victimcountry == USSR)
            {   defendstrength = 20;
            } else
            {   defendstrength = 10;
            }
            if (cityflag[e[victimcountry].iuy][e[victimcountry].iux] == 1)
            {   defendstrength *= 2;
        }   }
        else
        {   if (a[victimcountry - EUROPEANS].is <= 6)
            {   defendstrength = 5;
            } else
            {   defendstrength = 10;
            }
            if (cityflag[a[victimcountry - EUROPEANS].army[victimarmy].y][a[victimcountry - EUROPEANS].army[victimarmy].x] == 1)
            {   defendstrength *= 2;
        }   }

        // assert(attackstrength);
        // assert(defendstrength);
        // determine odds and outcome
        odds = attackstrength / defendstrength;

        roll = die();

        if (odds < 5)
        {   strcpy(oddstring, "<1:2");

            battle = BATTLE_NR;
        } elif (odds < 10)
        {   strcpy(oddstring, "1:2");
            switch (roll)
            {
            case 1:
            case 2:
                battle = BATTLE_AE;
            acase 3:
            case 4:
                battle = BATTLE_AR;
            acase 5:
            case 6:
                battle = BATTLE_DR;
        }   }
        elif (odds < 20)
        {   strcpy(oddstring, "1:1");
            switch (roll)
            {
            case 1:
                battle = BATTLE_AE;
            acase 2:
            case 3:
                battle = BATTLE_AR;
            acase 4:
            case 5:
                battle = BATTLE_DR;
            acase 6:
                battle = BATTLE_DE;
        }   }
        elif (odds < 30)
        {   strcpy(oddstring, "2:1");
            switch (roll)
            {
            case 1:
            case 2:
                battle = BATTLE_AR;
            acase 3:
            case 4:
                battle = BATTLE_DR;
            acase 5:
            case 6:
                battle = BATTLE_DE;
        }   }
        elif (odds < 40)
        {   strcpy(oddstring, "3:1");
            switch (roll)
            {
            case 1:
            case 2:
                battle = BATTLE_DR;
            acase 3:
            case 4:
            case 5:
            case 6:
                battle = BATTLE_DE;
        }   }
        else
        {   strcpy(oddstring, "4:1");
            battle = BATTLE_DE;
        }

        switch (battle)
        {
        case BATTLE_NR:
            strcpy(saystring, LLL(MSG_NOTSTRONG, "Not strong enough!"));
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
            deselect_combatants(we, wa, victimcountry, victimarmy);
        acase BATTLE_AE:
            if (eattacking)
            {   edie(we, FALSE);
            }
            for (war = 0; war < setup[wa].maxarmies; war++)
            {   if (aattacking[war])
                {   adie(wa, war, FALSE);
            }   }

            // updatescreen() not needed as say() does it
            sprintf
            (   saystring,
                LLL(MSG_ATTELI, "Odds are %s. Roll is %d. Result is attackers eliminated."),
                oddstring,
                roll
            );
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();

            deselect_combatants(we, wa, victimcountry, victimarmy);
        acase BATTLE_AR:
            sprintf
            (   saystring,
                LLL(MSG_ATTROU, "Odds are %s. Roll is %d. Result is attackers routed."),
                oddstring,
                roll
            );
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();

            deselect_combatants(we, wa, victimcountry, victimarmy);

            if (eattacking)
            {   if (e[we].control == CONTROL_HUMAN)
                {   emoves = 0;
                    emove_human(we, TRUE);
                } else
                {   // assert(e[we].control == CONTROL_AMIGA);
                    erout_amiga(we);
            }   }
            for (war = 0; war < setup[wa].maxarmies; war++)
            {   if (aattacking[war])
                {   if (e[we].control == CONTROL_HUMAN)
                    {   amoves[war] = 0;
                        amove_human(we, wa, war, TRUE);
                    } else
                    {   // assert(e[we].control == CONTROL_AMIGA);
                        arout_amiga(wa, war);
            }   }   }
        acase BATTLE_DR:
            sprintf
            (   saystring,
                LLL(MSG_DEFROU, "Odds are %s. Roll is %d. Result is defender routed."),
                oddstring,
                roll
            );
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();

            deselect_combatants(we, wa, victimcountry, victimarmy);

            if (victimcountry < EUROPEANS)
            {   victimx = e[victimcountry].iux;
                victimy = e[victimcountry].iuy;
            } else
            {   victimx = a[victimcountry - EUROPEANS].army[victimarmy].x;
                victimy = a[victimcountry - EUROPEANS].army[victimarmy].y;
            }

            if (victimcountry < EUROPEANS)
            {   // defending IU routed
                if (e[victimcountry].control == CONTROL_HUMAN)
                {   emoves = 0;
                    emove_human(victimcountry, TRUE);
                } else
                {   // assert(e[victimcountry].control == CONTROL_AMIGA);
                    erout_amiga(victimcountry);
            }   }
            else
            {   // defending African army routed
                if
                (   a[victimcountry - EUROPEANS].pi >= 1
                 && a[victimcountry - EUROPEANS].eruler < players
                 && e[a[victimcountry - EUROPEANS].eruler].control == CONTROL_HUMAN
                )
                {   amoves[victimarmy] = 0;
                    amove_human(a[victimcountry - EUROPEANS].eruler, victimcountry - EUROPEANS, victimarmy, TRUE);
                } else
                {   arout_amiga(victimcountry - EUROPEANS, victimarmy);
            }   }

            advance(we, wa, victimx, victimy);
        acase BATTLE_DE:
            sprintf
            (   saystring,
                LLL(MSG_DEFELI, "Odds are %s. Roll is %d. Result is defender eliminated."),
                oddstring,
                roll
            );
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();

            deselect_combatants(we, wa, victimcountry, victimarmy);

            if (victimcountry < EUROPEANS)
            {   victimx = e[victimcountry].iux;
                victimy = e[victimcountry].iuy;

                // defending IU killed

                edie(victimcountry, TRUE);
            } else
            {   victimx = a[victimcountry - EUROPEANS].army[victimarmy].x;
                victimy = a[victimcountry - EUROPEANS].army[victimarmy].y;

                // defending African army killed

                adie(victimcountry - EUROPEANS, victimarmy, TRUE);
            }

            advance(we, wa, victimx, victimy);
}   }   }

MODULE FLAG zoc(SLONG wa, SLONG x, SLONG y)
{   SLONG we,
          wa2,
          war;

    /* This routine tells you whether a coordinate is in the zone of
    control of any enemy. */

    for (we = 0; we < players; we++)
    {   if
        (   we != a[wa].eruler
         && e[we].iu
         && nextto
            (   x,
                y,
                e[we].iux,
                e[we].iuy
            )
         && (movable(e[we].iuhost, x, y) == 1 || movable(e[we].iuhost, x, y) == 2)
        )
        {   return TRUE;
    }   }

    for (wa2 = 0; wa2 < RAFRICANS; wa2++)
    {   if
        (   wa != wa2                         // not us
         && a[wa2].aruler == wa2              // independent
         && (   a[wa].eruler != a[wa2].eruler // not allied
             || a[wa2].pi < POLITICAL_CONTROL
        )   )
        {   for (war = 0; war < setup[wa2].maxarmies; war++)
            {   if (a[wa2].army[war].alive)
                {   if
                    (   nextto
                        (   x,
                            y,
                            a[wa2].army[war].x,
                            a[wa2].army[war].y
                        )
                     && (movable(wa2, x, y) == 1 || movable(wa2, x, y) == 2)
                    )
                    {   return TRUE;
    }   }   }   }   }

    return FALSE;
}

MODULE FLAG canflee_euro(SLONG we)
{   int wh;

    for (wh = 0; wh <= 5; wh++)
    {   xhex = e[we].iux + xcoords[e[we].iuy % 2][wh];
        yhex = e[we].iuy + ycoords[wh];

        if
        (   valid(xhex, yhex)
         && vacant(xhex, yhex)
         && nextto(e[we].iux, e[we].iuy, xhex, yhex)
         && movable(e[we].iuhost, xhex, yhex)
         && !zoc(e[we].iuhost, xhex, yhex)
        )
        {   return TRUE;
    }   }

    return FALSE;
}
MODULE FLAG canflee_afro(SLONG wa, SLONG war)
{   int wh;

    for (wh = 0; wh <= 5; wh++)
    {   xhex = a[wa].army[war].x + xcoords[a[wa].army[war].y % 2][wh];
        yhex = a[wa].army[war].y + ycoords[wh];

        if
        (   valid(xhex, yhex)
         && vacant(xhex, yhex)
         && nextto(a[wa].army[war].x, a[wa].army[war].y, xhex, yhex)
         && movable(wa, xhex, yhex)
         && !zoc(wa, xhex, yhex)
        )
        {   return TRUE;
    }   }

    return FALSE;
}

MODULE void erout_amiga(SLONG we)
{   SLONG i,
          wh;

    /* Amiga only ever bothers to rout itself by one hex, this is usually
    better strategically anyway. */

    select_iu(we, TRUE);
    wh = die() - 1;

    for (i = 0; i <= 5; i++)
    {   if (wh == 5)
        {   wh = 0;
        } else wh++;

        xhex = e[we].iux + xcoords[e[we].iuy % 2][wh];
        yhex = e[we].iuy + ycoords[wh];

        if
        (   valid(xhex, yhex)
         && vacant(xhex, yhex)
         && nextto(e[we].iux, e[we].iuy, xhex, yhex)
         && movable(e[we].iuhost, xhex, yhex)
         && !zoc(e[we].iuhost, xhex, yhex)
        )
        {   e[we].iux = xhex;
            e[we].iuy = yhex;
            move_iu(we, TRUE);
            deselect_iu(we, TRUE);
            return;
    }   }

    sprintf
    (   saystring,
        LLL(MSG_UNABLEIU, "%s's IU is unable to escape."),
        e[we].name
    );
    say(UPPER, AFROCOLOUR + e[we].iuhost, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
    anykey();

    edie(we, TRUE);
}

MODULE void emove_amiga(SLONG we)
{   TRANSIENT SLONG i,
                    move,
                    wh,
                    x, y;
    PERSIST   FLAG  been[MAPROWS][MAPCOLUMNS];

    for (y = 0; y < MAPROWS; y++)
    {   for (x = 0; x < MAPCOLUMNS; x++)
        {   been[y][x] = FALSE;
    }   }

    if (watchamiga) select_iu(we, TRUE);

    for (move = 0; move <= 4; move++)
    {   wh = die() - 1;
        for (i = 0; i <= 5; i++)
        {   if (wh == 5)
            {   wh = 0;
            } else wh++;

            xhex = e[we].iux + xcoords[e[we].iuy % 2][wh];
            yhex = e[we].iuy + ycoords[wh];

            if
            (   valid(xhex, yhex)
             && vacant(xhex, yhex)
             && nextto(e[we].iux, e[we].iuy, xhex, yhex)
             && movable(e[we].iuhost, xhex, yhex)
             && !been[yhex][xhex]
            )
            {   been[e[we].iuy][e[we].iux] = TRUE;
                e[we].iux = xhex;
                e[we].iuy = yhex;
                if (watchamiga) move_iu(we, TRUE);

                if (zoc(e[we].iuhost, xhex, yhex))
                {   if (watchamiga) deselect_iu(we, TRUE); else move_iu(we, FALSE);
                    return;

                }
                if (cityhere(xhex, yhex))
                {   if (watchamiga) deselect_iu(we, TRUE); else move_iu(we, FALSE);
                    return;
                }

                goto NEXTMOVE_E;
        }   }

NEXTMOVE_E:
        ;
    }

    if (watchamiga) deselect_iu(we, TRUE); else move_iu(we, FALSE);
}

MODULE void amove_amiga(SLONG wa, SLONG war)
{   TRANSIENT SLONG i,
                    move,
                    wh,
                    x, y;
    PERSIST   FLAG  been[MAPROWS][MAPCOLUMNS];

    for (y = 0; y < MAPROWS; y++)
    {   for (x = 0; x < MAPCOLUMNS; x++)
        {   been[y][x] = FALSE;
    }   }

    if (watchamiga) select_army(wa, war, TRUE);

    for (move = 0; move <= 4; move++)
    {   wh = die() - 1;
        for (i = 0; i <= 5; i++)
        {   if (wh == 5)
            {   wh = 0;
            } else wh++;

            xhex = a[wa].army[war].x + xcoords[a[wa].army[war].y % 2][wh];
            yhex = a[wa].army[war].y + ycoords[wh];

            if
            (   valid(xhex, yhex)
             && vacant(xhex, yhex)
             && nextto(a[wa].army[war].x, a[wa].army[war].y, xhex, yhex)
             && movable(wa, xhex, yhex)
             && !been[yhex][xhex]
            )
            {   been[a[wa].army[war].y][a[wa].army[war].x] = TRUE;
                a[wa].army[war].x = xhex;
                a[wa].army[war].y = yhex;
                if (watchamiga) move_army(wa, war, TRUE);

                if (zoc(wa, xhex, yhex))
                {   if (watchamiga) deselect_army(wa, war, TRUE); else move_army(wa, war, FALSE);
                    return;
                }
                if (cityhere(xhex, yhex))
                {   if (watchamiga) deselect_army(wa, war, TRUE); else move_army(wa, war, FALSE);
                    return;
                }

                goto NEXTMOVE_A;
        }   }

NEXTMOVE_A:
        ;
    }

    if (watchamiga) deselect_army(wa, war, TRUE); else move_army(wa, war, FALSE);
}

MODULE void eattack_amiga(SLONG we)
{   SLONG i,
          wh;

    wh = die() - 1;
    for (i = 0; i <= 5; i++)
    {   if (wh == 5)
        {   wh = 0;
        } else wh++;

        xhex = e[we].iux + xcoords[e[we].iuy % 2][wh];
        yhex = e[we].iuy + ycoords[wh];

        if
        (   valid(xhex, yhex)
         && evaluate(e[we].iuhost, xhex, yhex)
         && hate(e[we].iuhost, ret_country)
        )
        {   eattack_country = ret_country;
            eattack_army    = ret_army;
            return;
}   }   }

MODULE void aattack_amiga(SLONG wa, SLONG war)
{   SLONG i,
          war2,
          wh;

    // try to do a group attack
    wh = die() - 5;
    for (i = 0; i <= 5; i++)
    {   if (wh == 5)
        {   wh = 0;
        } else wh++;

        xhex = a[wa].army[war].x + xcoords[a[wa].army[war].y % 2][wh];
        yhex = a[wa].army[war].y + ycoords[wh];

        if
        (   valid(xhex, yhex)
         && evaluate(wa, xhex, yhex)
         && hate(wa, ret_country)
        )
        {   // found a potential victim
            // see whether any of our other armies are attacking him

            if
            (   e[a[wa].eruler].iu
             && eattack_country           == ret_country
             && eattack_army              == ret_army
            )
            {   aattack_country[war]      =  ret_country;
                aattack_army[war]         =  ret_army;
                return;
            } // implied else

            for (war2 = 0; war2 < setup[wa].maxarmies; war2++)
            {   if
                (   war != war2
                 && a[wa].army[war2].alive
                 && aattack_country[war2] == ret_country
                 && aattack_army[war2]    == ret_army
                )
                {   aattack_country[war]  =  ret_country;
                    aattack_army[war]     =  ret_army;
                    return;
    }   }   }   }

    // try to do a solo attack
    wh = die() - 5;
    for (i = 0; i <= 5; i++)
    {   if (wh == 5)
        {   wh = 0;
        } else wh++;

        xhex = a[wa].army[war].x + xcoords[a[wa].army[war].y % 2][wh];
        yhex = a[wa].army[war].y + ycoords[wh];

        if
        (   valid(xhex, yhex)
         && evaluate(wa, xhex, yhex)
         && hate(wa, ret_country)
        )
        {   aattack_country[war] = ret_country;
            aattack_army[war]    = ret_army;
            return;
}   }   }

EXPORT FLAG canattack(SLONG wa, SLONG x, SLONG y)
{   SLONG wh,
          xx,
          yy;

    for (wh = 0; wh <= 5; wh++)
    {   xx = x + xcoords[y % 2][wh];
        yy = y + ycoords[wh];

        if
        (   valid(xx, yy)
         && evaluate(wa, xx, yy)
        )
        {   return TRUE;
    }   }

    return FALSE;
}

MODULE void place_army(SLONG we, SLONG wa, SLONG war)
{   FLAG  good;
    SLONG result,
          we2,
          wa2,
          war2;

    do
    {   sprintf
        (   saystring,
            LLL(MSG_PLACEARMY, "%s, place army #%d of %d for %s."),
            e[we].name,
            war + 1,
            setup[wa].initarmies,
            a[wa].name
        );
        say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_HEX, "Hex"), "-");
        result = getevent(HEX);
        good = TRUE;
        if (result == NON)
        {   good = FALSE;
            /* strcpy(saystring, "Not a valid hex.");
            say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey(); */
            goto PLACEARMY_DONE; // not really needed
        } else
        {   for (wa2 = 0; wa2 < RAFRICANS; wa2++)
            {   for (war2 = 0; war2 < setup[wa2].maxarmies; war2++)
                {   if (a[wa2].army[war2].alive && a[wa2].army[war2].x == xhex && a[wa2].army[war2].y == yhex)
                    {   good = FALSE;
                        strcpy(saystring, LLL(MSG_NOTEMPTY, "Hex is not empty."));
                        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                        anykey();
                        goto PLACEARMY_DONE;
            }   }   }
            if (whosehex(xhex, yhex) != wa)
            {   good = FALSE;
                strcpy(saystring, LLL(MSG_FOREIGN, "This is a foreign hex."));
                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                anykey();
                goto PLACEARMY_DONE;
            }
            for (we2 = 0; we2 < players; we2++)
            {   if (e[we2].iu && e[we2].iux == xhex && e[we2].iuy == yhex)
                {   good = FALSE;
                    strcpy(saystring, LLL(MSG_NOTEMPTY, "Hex is not empty."));
                    say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
                    goto PLACEARMY_DONE;
        }   }   }

PLACEARMY_DONE:
        ;

    } while (!good);

    a[wa].army[war].alive = TRUE;
    a[wa].army[war].x = xhex;
    a[wa].army[war].y = yhex;
    if (wa == GABON)
    {   // assert(war == 0);
        move_army(GABON, 0, FALSE);
    } else
    {   move_army(wa, war, TRUE);
}   }

MODULE void place_govt(SLONG we, SLONG wa, SLONG govt)
{   FLAG  good;
    SLONG result,
          war = -1; // to avoid spurious compiler warnings

    if (wa == GABON)
    {   // assert(govt == JUNTA);
        a[GABON].govtarmy = 0; // which army the leader is attached to
        makejunta(GABON, 0, TRUE);
        return;
    }

    do
    {   if (govt == LEADER)
        {   sprintf(saystring, LLL(MSG_PLACELEADER, "%s, place leader in %s."), e[we].name, a[wa].name);
        } else
        {   // assert(govt == JUNTA);
            sprintf(saystring, LLL(MSG_PLACEJUNTA,  "%s, place junta in %s." ), e[we].name, a[wa].name);
        }
        say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_ARMY, "Army"), "-");

        result = getevent(HEX);
        if (result != NON)
        {   war = ourarmy(wa, xhex, yhex);
            if (war == -1)
            {   good = FALSE;
                sprintf
                (   saystring,
                    LLL(MSG_MUSTPLACE, "Must place government on one of %s's armies."),
                    a[wa].name
                );
                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                anykey();
            } else
            {   good = TRUE;
        }   }
        else
        {   good = FALSE;
    }   }
    while (!good);

    a[wa].govtarmy = war; // which army the leader is attached to

    if (govt == LEADER)
    {   makeleader(wa, war, TRUE);
    } else
    {   // assert(govt == JUNTA);
        makejunta(wa, war, TRUE);
}   }

EXPORT void oneround(void)
{   SLONG we,
          wa,
          wa2;

    eincome();

    for (we = 0; we < players; we++)
    {   if (e[we].control == CONTROL_HUMAN)
        {   writeorders_human(we);
        } else
        {   // assert(e[we].control == CONTROL_AMIGA);
            writeorders_amiga(we);
    }   }

    readorders();

    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (a[wa].aruler == wa && a[wa].pi < MILITARY_CONTROL)
        {   for (wa2 = 0; wa2 < RAFRICANS; wa2++)
            {   if
                (   a[wa2].aruler == wa2
                 && a[wa].declared[wa2]
                 && wa  != wa2
                 && wa  != wa2 + LAFRICANS
                 && wa2 != wa  + LAFRICANS
                )
                {   a[wa].declared[wa2] = FALSE;
                    sprintf
                    (   saystring,
                        LLL(MSG_MAKESPEACE, "%s makes peace with %s."),
                        a[wa].name,
                        a[wa2].name
                    );
                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
    }   }   }   }

    africans();

    assassinate();
}

MODULE void readorders(void)
{   SLONG armies,
          i,
          we,
          wa,
          war,
          war2 = -1, // to prevent spurious compiler warnings
          wo,
          old,
          olderuler[RAFRICANS],
          oldis[RAFRICANS],
          oldpi[RAFRICANS],
          result,
          tries;
    FLAG  good,
          iumaintained[EUROPEANS];

    // 4.1.3. Order reading and application.

    for (wa = 0; wa < RAFRICANS; wa++)
    {   oldis[wa]     = a[wa].is;
        olderuler[wa] = a[wa].eruler;
        oldpi[wa]     = a[wa].pi;
    }

    for (we = 0; we < players; we++)
    {   iumaintained[we] = FALSE;

        wo = 0;
        while (order[we][wo].command != ORDER_DONE)
        {   e[we].treasury -= order[we][wo].fee;
            switch (order[we][wo].command)
            {
            case ORDER_PI:
                for (i = 1; i <= order[we][wo].data1; i++)
                {   if (a[order[we][wo].dest].pi == 0)
                    {   if (a[order[we][wo].dest].govt != OTHER && a[order[we][wo].dest].eruler != we)
                        {   sprintf
                            (   saystring,
                                LLL(MSG_GOVTPREVENTS, "%s prevents %s from changing the allegiance of %s."),
                                (a[order[we][wo].dest].govt == LEADER) ? LLL(MSG_LEADER2, "Leader") : LLL(MSG_JUNTA2, "Junta"),
                                e[we].name,
                                a[order[we][wo].dest].name
                            );
                            say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                            anykey();
                        } else
                        {   a[order[we][wo].dest].eruler = we;
                            a[order[we][wo].dest].pi     = 1;
                    }   }
                    elif (a[order[we][wo].dest].eruler == we)
                    {   a[order[we][wo].dest].pi++;
                    } else
                    {   // other player has PI
                        a[order[we][wo].dest].pi--;
                }   }
                if (order[we][wo].data1 == 1)
                {   sprintf
                    (   saystring,
                        LLL(MSG_APPLIES1PI, "%s applies 1 point of Political Influence to %s."),
                        e[we].name,
                        a[order[we][wo].dest].name
                    );
                } else
                {   sprintf
                    (   saystring,
                        LLL(MSG_APPLIESPI, "%s applies %d points of Political Influence to %s."),
                        e[we].name,
                        order[we][wo].data1,
                        a[order[we][wo].dest].name
                    );
                }
                drawtables();
            acase ORDER_RAISE_IS:
                a[order[we][wo].dest].is += order[we][wo].data1;
                sprintf
                (   saystring,
                    LLL(MSG_RAISESIS, "%s raises the Internal Stability of %s by %d."),
                    e[we].name,
                    a[order[we][wo].dest].name,
                    order[we][wo].data1
                );
                drawtables();
            acase ORDER_LOWER_IS:
                a[order[we][wo].dest].is -= order[we][wo].data1;
                sprintf
                (   saystring,
                    LLL(MSG_LOWERSIS, "%s lowers the Internal Stability of %s by %d."),
                    e[we].name,
                    a[order[we][wo].dest].name,
                    order[we][wo].data1
                );
                drawtables();
            acase ORDER_INSTALL_LEADER:
            case ORDER_INSTALL_JUNTA:
                if (e[we].control == CONTROL_HUMAN)
                {   do
                    {   armies = 0;
                        for (war = 0; war < setup[order[we][wo].dest].maxarmies; war++)
                        {   if (a[order[we][wo].dest].army[war].alive)
                            {   armies++;
                                war2 = war;
                        }   }
                        if (armies == 1)
                        {   xhex = a[order[we][wo].dest].army[war2].x;
                            yhex = a[order[we][wo].dest].army[war2].y;
                            escaped = TRUE;
                            if (order[we][wo].command == ORDER_INSTALL_LEADER)
                            {   a[order[we][wo].dest].govt = LEADER;
                            } else
                            {   // assert(order[we][wo].command == ORDER_INSTALL_JUNTA);
                                a[order[we][wo].dest].govt = JUNTA;
                            }
                            a[order[we][wo].dest].govtarmy = war2;
                            // assert(a[order[we][wo].dest].govtarmy != -1);

                            if (order[we][wo].command == ORDER_INSTALL_LEADER)
                            {   makeleader(order[we][wo].dest, a[order[we][wo].dest].govtarmy, TRUE);
                            } else
                            {   // assert(order[we][wo].command == ORDER_INSTALL_JUNTA);
                                makejunta(order[we][wo].dest, a[order[we][wo].dest].govtarmy, TRUE);
                            }
                            sprintf
                            (   saystring,
                                LLL(MSG_INSTALLSGOVT, "%s installs a %s in %s."),
                                e[we].name,
                                (order[we][wo].command == ORDER_INSTALL_LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta"),
                                a[order[we][wo].dest].name
                            );
                            goto INSTALL_DONE;
                        }

                        sprintf
                        (   saystring,
                            LLL(MSG_PLACEGOVT, "%s, place a %s in %s (or Esc to abort)."),
                            e[we].name,
                            (order[we][wo].command == ORDER_INSTALL_LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta"),
                            a[order[we][wo].dest].name
                        );
                        say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_ARMY, "Army"), (STRPTR) LLL(MSG_ABORT, "Abort"));
                        escaped = FALSE;
                        DISCARD getevent(HEX);
                        if (!escaped)
                        {   if (!valid(xhex, yhex))
                            {   ; /* strcpy(saystring, "Not a valid hex.");
                                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                anykey(); */
                            } elif (ourarmy(order[we][wo].dest, xhex, yhex) == -1)
                            {   sprintf
                                (   saystring,
                                    LLL(MSG_MUSTPLACE, "Must place government on one of %s's armies."),
                                    a[order[we][wo].dest].name
                                );
                                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                anykey();
                            } else
                            {   escaped = TRUE;
                                if (order[we][wo].command == ORDER_INSTALL_LEADER)
                                {   a[order[we][wo].dest].govt = LEADER;
                                } else
                                {   // assert(order[we][wo].command == ORDER_INSTALL_JUNTA);
                                    a[order[we][wo].dest].govt = JUNTA;
                                }
                                a[order[we][wo].dest].govtarmy = ourarmy(order[we][wo].dest, xhex, yhex);
                                // assert(a[order[we][wo].dest].govtarmy != -1);

                                if (order[we][wo].command == ORDER_INSTALL_LEADER)
                                {   makeleader(order[we][wo].dest, a[order[we][wo].dest].govtarmy, TRUE);
                                } else
                                {   // assert(order[we][wo].command == ORDER_INSTALL_JUNTA);
                                    makejunta(order[we][wo].dest, a[order[we][wo].dest].govtarmy, TRUE);
                    }   }   }   }
                    while (!escaped);
                    saystring[0] = EOS;
INSTALL_DONE:
                    ;
                } else
                {   // assert(e[we].control == CONTROL_AMIGA);

                    tries = 0;
                    do
                    {   xhex = goodrand() % MAPCOLUMNS;
                        yhex = goodrand() % MAPROWS;
                    } while
                    (   (   !valid(xhex, yhex)
                         || ourarmy(order[we][wo].dest, xhex, yhex) == -1
                        )
                     && tries++ < 500
                    );

                    if (tries < 500)
                    {   if (order[we][wo].command == ORDER_INSTALL_LEADER)
                        {   a[order[we][wo].dest].govt = LEADER;
                        } else
                        {   // assert(order[we][wo].command == ORDER_INSTALL_JUNTA);
                            a[order[we][wo].dest].govt = JUNTA;
                        }
                        a[order[we][wo].dest].govtarmy = ourarmy(order[we][wo].dest, xhex, yhex);
                        // assert(a[order[we][wo].dest].govtarmy != -1);

                        if (order[we][wo].command == ORDER_INSTALL_LEADER)
                        {   makeleader(order[we][wo].dest, a[order[we][wo].dest].govtarmy, TRUE);
                        } else
                        {   // assert(order[we][wo].command == ORDER_INSTALL_JUNTA);
                            makejunta(order[we][wo].dest, a[order[we][wo].dest].govtarmy, TRUE);
                        }
                        sprintf
                        (   saystring,
                            LLL(MSG_INSTALLSGOVT, "%s installs a %s in %s."),
                            e[we].name,
                            (order[we][wo].command == ORDER_INSTALL_LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta"),
                            a[order[we][wo].dest].name
                        );
                    } else
                    {   sprintf
                        (   saystring,
                            LLL(MSG_CANCELSGOVT, "%s cancels the %s in %s."),
                            e[we].name,
                            (order[we][wo].command == ORDER_INSTALL_LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta"),
                            a[order[we][wo].dest].name
                        );
                }   }
            acase ORDER_BUILD_IU:
                if (e[we].control == CONTROL_HUMAN)
                {   do
                    {   sprintf
                        (   saystring,
                            LLL(MSG_PLACEIU, "%s, place your IU in %s (or Esc to abort)."),
                            e[we].name,
                            a[order[we][wo].dest].name
                        );
                        say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_HEX, "Hex"), (STRPTR) LLL(MSG_ABORT, "Abort"));
                        escaped = FALSE;
                        result = getevent(HEX);
                        if (result != -1 && !escaped)
                        {   if (!valid(xhex, yhex))
                            {   ; /* strcpy(saystring, "Not a valid hex.");
                                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                anykey(); */
                            } elif (!vacant(xhex, yhex))
                            {   strcpy(saystring, LLL(MSG_NOTEMPTY, "Hex is not empty."));
                                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                anykey();
                            } elif (order[we][wo].dest % LAFRICANS != hexowner[yhex][xhex] % LAFRICANS)
                            {   strcpy(saystring, LLL(MSG_NOTHOME, "This is not a home hex."));
                                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                anykey();
                            } elif (zoc(order[we][wo].dest, xhex, yhex))
                            {   strcpy(saystring, LLL(MSG_ZOC, "Hex is in enemy Zone of Control."));
                                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                anykey();
                            } elif (!nexttoourcity(order[we][wo].dest, xhex, yhex))
                            {   strcpy(saystring, LLL(MSG_IUBUILD, "IUs must be built in or next to controlled cities."));
                                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                anykey();
                            } else
                            {   escaped = TRUE;
                                e[we].iu           =
                                iumaintained[we]   = TRUE;
                                e[we].iux          = xhex;
                                e[we].iuy          = yhex;
                                e[we].iuhost       = order[we][wo].dest;
                                move_iu(we, TRUE);
                    }   }   }
                    while (!escaped);
                    saystring[0] = EOS;
                } else
                {   // assert(e[we].control == CONTROL_AMIGA);

                    tries = 0;
                    do
                    {   do
                        {   xhex = goodrand() % MAPCOLUMNS;
                            yhex = goodrand() % MAPROWS;
                        } while
                        (   !valid(xhex, yhex)
                         || (hexowner[yhex][xhex] % LAFRICANS != order[we][wo].dest % LAFRICANS)
                        );

                        if (vacant(xhex, yhex) && !zoc(order[we][wo].dest, xhex, yhex))
                        {   good               =
                            e[we].iu           =
                            iumaintained[we]   = TRUE;
                            e[we].iux          = xhex;
                            e[we].iuy          = yhex;
                            e[we].iuhost       = order[we][wo].dest;
                            move_iu(we, TRUE);
                        } else
                        {   good = FALSE;
                            tries++;
                    }   }
                    while (!good && tries < 200);
                    if (good)
                    {   sprintf
                        (   saystring,
                            LLL(MSG_BUILDSIU, "%s builds an Intervention Unit for %s."),
                            e[we].name,
                            a[order[we][wo].dest].name
                        );
                    } else
                    {   sprintf
                        (   saystring,
                            LLL(MSG_CANCELSIU, "%s cancels the Intervention Unit for %s."),
                            e[we].name,
                            a[order[we][wo].dest].name
                        );
                }   }
            acase ORDER_MAINTAIN_IU:
                iumaintained[we] = TRUE;
                sprintf
                (   saystring,
                    LLL(MSG_MAINTAINSIU, "%s maintains its existing Intervention Unit."),
                    e[we].name
                );
            acase ORDER_GIVE_MONEY:
                if (order[we][wo].dest < EUROPEANS)
                {   e[order[we][wo].dest].treasury += order[we][wo].data1;
                    sprintf
                    (   saystring,
                        LLL(MSG_GIVES, "%s gives $%d to %s."),
                        e[we].name,
                        order[we][wo].data1,
                        e[order[we][wo].dest].name
                    );
                    if (e[order[we][wo].dest].treasury > 24)
                    {   e[order[we][wo].dest].treasury = 24;
                }   }
                else
                {   a[order[we][wo].dest - EUROPEANS].treasury += order[we][wo].data1;
                    sprintf
                    (   saystring,
                        LLL(MSG_GIVES, "%s gives $%d to %s."),
                        e[we].name,
                        order[we][wo].data1,
                        a[order[we][wo].dest - EUROPEANS].name
                    );
                    if (a[order[we][wo].dest - EUROPEANS].treasury > 24)
                    {   a[order[we][wo].dest - EUROPEANS].treasury = 24;
                }   }
                drawtables();
            }

            drawtables();
            if (saystring[0])
            {   if (watchamiga)
                {   say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
            }   }
            wo++;
        }

        if (e[we].iu && !iumaintained[we])
        {   edie(we, TRUE);
            sprintf
            (   saystring,
                LLL(MSG_NOTMAINTAINED, "%s has not maintained its Intervention Unit."),
                e[we].name
            );
            say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
    }   }

    for (wa = 0; wa < RAFRICANS; wa++)
    {   old = a[wa].is;
        if (a[wa].is > 10)
            a[wa].is = 10;
        elif (a[wa].is < 0)
            a[wa].is = 0;
        if (a[wa].is > oldis[wa] + 3)
            a[wa].is = oldis[wa] + 3;
        elif (a[wa].is < oldis[wa] - 3)
            a[wa].is = oldis[wa] - 3;
        if (old != a[wa].is)
        {   drawtables();
            sprintf
            (   saystring,
                LLL(MSG_ISADJUSTED, "The Internal Stability of %s has been adjusted."),
                a[wa].name
            );
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
        }

        // assert(a[wa].pi >= 0);
        old = a[wa].pi;
        if (a[wa].pi > 10)
            a[wa].pi = 10;
        if (a[wa].pi > oldpi[wa] + 3)
        {   a[wa].pi = oldpi[wa] + 3;
        } elif (a[wa].pi < oldpi[wa] - 3)
        {   a[wa].pi = oldpi[wa] - 3;
        }
        if (a[wa].eruler != olderuler[wa])
        {   if (oldpi[wa] == 2 && a[wa].pi > 1)
            {   a[wa].pi = 1;
            } elif (oldpi[wa] == 1 && a[wa].pi > 2)
            {   a[wa].pi = 2;
        }   }
        if (old != a[wa].pi)
        {   drawtables();
            sprintf
            (   saystring,
                LLL(MSG_PIADJUSTED, "The Political Influence of %s has been adjusted."),
                a[wa].name
            );
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
    }   }

    for (we = 0; we < players; we++)
    {   if
        (   e[we].iu
         && (   a[e[we].iuhost].eruler != we
             || a[e[we].iuhost].pi < MILITARY_CONTROL
        )   )
        {   edie(we, TRUE);
            sprintf
            (   saystring,
                LLL(MSG_IUEXPELLED, "%s's IU has been expelled from %s."),
                e[we].name,
                a[e[we].iuhost].name
            );
            say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
}   }   }

MODULE void assassinate(void)
{   SLONG i,
          we,
          we2,
          wa,
          thewho;

    for (we = 0; we < players; we++)
    {   if (e[we].control == CONTROL_HUMAN)
        {   for (we2 = 0; we2 < EUROPEANS; we2++)
            {   enabled[we2] = FALSE;
            }
            for (wa = 0; wa < RAFRICANS; wa++)
            {   if (a[wa].aruler == wa && a[wa].govt != OTHER)
                {   enabled[EUROPEANS + wa] = TRUE;
                } else
                {   enabled[EUROPEANS + wa] = FALSE;
            }   }

            setbarcolour(we);

            sprintf
            (   saystring,
                LLL(MSG_ASSASSINATE, "%s, assassinate leader or junta in..."),
                e[we].name
            );
            say(UPPER, EUROCOLOUR + we, "-", "-");
            strcpy(WhoTitle, LLL(MSG_HAIL_ASSASSINATE, "Assassinate..."));
            thewho = dowho(we, FALSE, NULL, 0);
        } else
        {   thewho = -1;
            wa = goodrand() % RAFRICANS;
            for (i = 0; i < RAFRICANS; i++)
            {   if (wa == RAFRICANS)
                {   wa = 0;
                } else wa++;

                if
                (   a[wa].aruler == wa
                 && a[wa].govt   != OTHER
                 && a[wa].eruler != we
                )
                {   thewho = EUROPEANS + wa;
                    break;
            }   }

            if (thewho == -1)
            {   sprintf
                (   saystring,
                    LLL(MSG_NOATTEMPT, "%s does not attempt an assassination this round."),
                    e[we].name
                );
                say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                anykey();
        }   }

        if (thewho != -1) // ie. not "None"
        {   if
            (   (a[thewho - EUROPEANS].govt == JUNTA  && die() == 6)
             || (a[thewho - EUROPEANS].govt == LEADER && die() >= 5)
            )
            {   sprintf
                (   saystring,
                    LLL(MSG_SUCCESS, "%s successfully assassinates %s's %s in %s."),
                    e[we].name,
                    e[a[thewho - EUROPEANS].eruler].name,
                    (a[thewho - EUROPEANS].govt == LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta"),
                    a[thewho - EUROPEANS].name
                );
                a[thewho - EUROPEANS].govt = OTHER;
                killgovt(thewho - EUROPEANS, a[thewho - EUROPEANS].govtarmy, TRUE);
            } else
            {   sprintf
                (   saystring,
                    LLL(MSG_FAILURE, "%s fails to assassinate %s's %s in %s."),
                    e[we].name,
                    e[a[thewho - EUROPEANS].eruler].name,
                    (a[thewho - EUROPEANS].govt == LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta"),
                    a[thewho - EUROPEANS].name
                );
            }
            say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
}   }   }

MODULE void eincome(void)
{   SLONG we,
          income;

    for (we = 0; we < players; we++)
    {   income = 15 - we + die();
        e[we].treasury += income;
        if (e[we].treasury > 24)
        {   e[we].treasury = 24;
        }

        /* drawtables();
        sprintf
        (   saystring,
            "%s receives income of $%d, and now has $%d in the treasury.",
            e[we].name,
            income,
            e[we].treasury
        );
        say(UPPER, EUROCOLOUR + we, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey(); */
    }

    drawtables();
}

MODULE SLONG die(void)
{   return (SLONG) ((goodrand() % 6) + 1);
}

MODULE void writeorders_amiga(SLONG we)
{   SLONG wa,
          wo = 0,
          tries = 0;
    FLAG  ok;

#ifdef EXTRAVERBOSE
    Printf("Starting to write orders for %s...\n", e[we].name);
#endif

    cash = e[we].treasury;

    // assert(cash >= 4);
    if (e[we].iu)
    {   order[we][wo].command = ORDER_MAINTAIN_IU;
        if (we == USA || we == USSR)
        {   order[we][wo].fee = 4;
        } else
        {   order[we][wo].fee = 2;
        }
        cash -= order[we][wo].fee;
        wo++;
    } elif (ukiu || we != UK)
    {   for (wa = 0; wa < RAFRICANS; wa++)
        {   if
            (   a[wa].aruler == wa
             && a[wa].eruler == we
             && a[wa].pi >= MILITARY_CONTROL
            )
            {   order[we][wo].command = ORDER_BUILD_IU;
                order[we][wo].dest    = wa;
                if (we == USA || we == USSR)
                {   order[we][wo].fee = 4;
                } else
                {   order[we][wo].fee = 2;
                }
                cash -= order[we][wo].fee;
                wo++;
                break;
    }   }   }

    while (cash)
    {   // assert(wo < MAX_ORDERS);

        order[we][wo].command = ORDER_DONE; // usually gets changed
        switch (goodrand() % 15)
        {
        case 0: // lower stability
#ifdef EXTRAVERBOSE
            Printf("%s wants to lower IS...\n", e[we].name);
#endif
            if (cash < 4)
            {
#ifdef EXTRAVERBOSE
                Printf("...but is too poor!\n");
#endif
                break;
            }

            do
            {   wa = rand() % RAFRICANS;
            } while (a[wa].aruler != wa);
            if (a[wa].pi == 0 || a[wa].eruler == we)
            {
#ifdef EXTRAVERBOSE
                Printf("...but does not find a suitable candidate!\n");
#endif
                break;
            }

            if (addorder(we, wo, ORDER_LOWER_IS, wa, 4, 1)) wo++;
#ifdef EXTRAVERBOSE
            Printf("...and succeeds!\n");
#endif
        acase 1:
        case 2: // raise stability
        case 3:
#ifdef EXTRAVERBOSE
            Printf("%s wants to raise IS...\n", e[we].name);
#endif
            if (cash < 4)
            {
#ifdef EXTRAVERBOSE
                Printf("...but is too poor!\n");
#endif
                break;
            }

            ok = FALSE;
            for (wa = 0; wa < RAFRICANS; wa++)
            {   if (a[wa].aruler == wa && a[wa].eruler == we && a[wa].is < 9)
                {   ok = TRUE;
                    break; // for speed
            }   }

            if (!ok)
            {
#ifdef EXTRAVERBOSE
                Printf("...but does not find a suitable candidate!\n");
#endif
                break;
            }

            do
            {   wa = rand() % RAFRICANS;
            } while (a[wa].aruler != wa || a[wa].eruler != we || a[wa].is >= 9);

            if (addorder(we, wo, ORDER_RAISE_IS, wa, 4, 1)) wo++;
#ifdef EXTRAVERBOSE
            Printf("...and succeeds!\n");
#endif
        acase 4: // apply PI, preferably to our country
        case 5:
        case 6:
        case 7:
        case 8:
#ifdef EXTRAVERBOSE
            Printf("%s wants to apply PI...\n", e[we].name);
#endif
            if (cash < 4)
            {
#ifdef EXTRAVERBOSE
                Printf("...but is too poor!\n");
#endif
                break;
            }

            ok = FALSE;
            for (wa = 0; wa < RAFRICANS; wa++)
            {   if (a[wa].aruler == wa && a[wa].eruler == we && a[wa].pi < 9)
                {   ok = TRUE;
                    break; // for speed
            }   }

            do
            {   wa = rand() % RAFRICANS;
            } while (a[wa].aruler != wa || (ok && (a[wa].eruler != we || a[wa].pi >= 9)));

            if (addorder(we, wo, ORDER_PI, wa, 4, 1)) wo++;
#ifdef EXTRAVERBOSE
            Printf("...and succeeds!\n");
#endif
        acase 9: // apply PI to any country
#ifdef EXTRAVERBOSE
            Printf("%s wants to apply PI...\n", e[we].name);
#endif
            if (cash < 4)
            {
#ifdef EXTRAVERBOSE
                Printf("...but is too poor!\n");
#endif
                break;
            }

            do
            {   wa = rand() % RAFRICANS;
            } while (a[wa].aruler != wa);

            if (addorder(we, wo, ORDER_PI, wa, 4, 1)) wo++;
#ifdef EXTRAVERBOSE
            Printf("...and succeeds!\n");
#endif
        acase 10: // install leader
#ifdef EXTRAVERBOSE
            Printf("%s wants to install leader...\n", e[we].name);
#endif
            if (cash < 2 || !spareleader(we))
            {
#ifdef EXTRAVERBOSE
                Printf("...but is too poor!\n");
#endif
                break;
            }

            do
            {   wa = rand() % RAFRICANS;
            } while (a[wa].aruler != wa);

            if
            (   a[wa].eruler != we
             || a[wa].pi < POLITICAL_CONTROL
             || a[wa].govt != OTHER
             || !hasarmy(wa)
            )
            {
#ifdef EXTRAVERBOSE
                Printf("...but does not find a suitable candidate!\n");
#endif
                break;
            }

            order[we][wo].command = ORDER_INSTALL_LEADER;
            order[we][wo].dest    = wa;
            order[we][wo].fee     = 2;
#ifdef EXTRAVERBOSE
            Printf("...and succeeds!\n");
#endif
        acase 11: // install junta
#ifdef EXTRAVERBOSE
            Printf("%s wants to install junta...\n", e[we].name);
#endif
            if (cash < 2 || !sparejunta(we))
            {
#ifdef EXTRAVERBOSE
                Printf("...but is too poor!\n");
#endif
                break;
            }

            do
            {   wa = rand() % RAFRICANS;
            } while (a[wa].aruler != wa);

            if
            (   a[wa].eruler != we
             || a[wa].pi < POLITICAL_CONTROL
             || a[wa].govt != OTHER
             || !hasarmy(wa)
            )
            {
#ifdef EXTRAVERBOSE
                Printf("...but does not find a suitable candidate!\n");
#endif
                break;
            }

            order[we][wo].command = ORDER_INSTALL_JUNTA;
            order[we][wo].dest    = wa;
            order[we][wo].fee     = 2;
#ifdef EXTRAVERBOSE
            Printf("...and succeeds!\n");
#endif
        acase 12:
        case 13:
        case 14:
#ifdef EXTRAVERBOSE
            Printf("%s wants to give money...\n", e[we].name);
#endif
            do
            {   wa = rand() % RAFRICANS;
            } while (a[wa].aruler != wa);
            if (a[wa].eruler != we || a[wa].treasury >= 8)
            {
#ifdef EXTRAVERBOSE
                Printf("...but does not find a suitable candidate!\n");
#endif
                if (++tries > 100)
                {
#ifdef EXTRAVERBOSE
    Printf("Finished writing orders for %s (kept some money).\n", e[we].name);
#endif
                    return;

                    /* this is needed because if the player has $1-$3,
                    then giving money may be the only possible action. If
                    there are no countries we want to give any money to
                    (ie. they are all enemy countries) then we save the
                    "change" to spend next round. */
                }
                break;
            }

            if (addorder(we, wo, ORDER_GIVE_MONEY, EUROPEANS + wa, 1, 1)) wo++;
#ifdef EXTRAVERBOSE
            Printf("...and succeeds!\n");
#endif
    }   }

    order[we][wo].command = ORDER_DONE;
    // wo++;

#ifdef EXTRAVERBOSE
    Printf("Finished writing orders for %s (spent all money).\n", e[we].name);
#endif
}

EXPORT FLAG valid(SLONG x, SLONG y)
{   if
    (   y < 0
     || y >= MAPROWS
     || x < 0
     || x >= MAPCOLUMNS
     || hexowner[y][x] == NON
    )
    {   return FALSE;
    }

    return TRUE;
}

MODULE void africans(void)
{   SLONG besteuro              = -1, // to avoid spurious compiler warnings
          bestresult,
          chance,
          cost,
          govtcity              = -1, // to avoid spurious compiler warnings
          inflation[RAFRICANS],
          movables,
          result,
          thewho,
          tries,
          wa,
          wa2,
          wa3,
          we,
          we2,
          war,
          war2,
          wc;
    FLAG  ok,
          tied,
          revolted;

    for (wa = 0; wa < RAFRICANS; wa++)
    {   we = a[wa].eruler; // for convenience
        setbarcolour(we);

        inflation[wa] = 1;

#ifdef EXTRAVERBOSE
        Printf("%s is/are controlled by %s!\n", a[wa].name, a[a[wa].aruler].name);
#endif

        if (a[wa].aruler == wa)
        {   checkowners();
            we = a[wa].eruler; // for convenience

            if (wa < LAFRICANS)
            {   // 4.2.1. Random Event

                if (die() == 6)
                {   switch (die()) // switch() only evaluates its argument once presumably
                    {
                    case 1:
                        if (a[wa].pi != 0 && a[wa].pi != 10)
                        {   a[wa].pi++;
                            sprintf
                            (   saystring,
                                LLL(MSG_PIINCREASED, "%s's political influence over %s has increased to %d."),
                                e[we].name,
                                a[wa].name,
                                a[wa].pi
                            );
                            drawtables();
                        } else saystring[0] = EOS;
                    acase 2:
                        if (a[wa].pi != 0)
                        {   a[wa].pi--;
                            sprintf
                            (   saystring,
                                LLL(MSG_PIDECREASED, "%s's political influence over %s has decreased to %d."),
                                e[we].name,
                                a[wa].name,
                                a[wa].pi
                            );
                            drawtables();
                        } else saystring[0] = EOS;
                    acase 3:
                        if (a[wa].is != 10)
                        {   a[wa].is++;
                            sprintf
                            (   saystring,
                                LLL(MSG_ISINCREASED, "%s's stability has increased to %d."),
                                a[wa].name,
                                a[wa].is
                            );
                            drawtables();
                        } else saystring[0] = EOS;
                    acase 4:
                        if (a[wa].is != 0)
                        {   a[wa].is--;
                            sprintf
                            (   saystring,
                                LLL(MSG_ISDECREASED, "%s's stability has decreased to %d."),
                                a[wa].name,
                                a[wa].is
                            );
                            drawtables();
                        } else saystring[0] = EOS;
                    acase 5:
                        inflation[wa] = 2;
                        sprintf
                        (   saystring,
                            LLL(MSG_PAYSDOUBLE, "%s pays double to build/maintain armies and declare war."),
                            a[wa].name
                        );
                    acase 6:
                        if (a[wa].govt != OTHER)
                        {   sprintf
                            (   saystring,
                                LLL(MSG_GOVTDIED, "%s's %s has died in %s."),
                                e[we].name,
                                (a[wa].govt == LEADER) ? LLL(MSG_LEADER, "leader") : LLL(MSG_JUNTA, "junta"),
                                a[wa].name
                            );
                            a[wa].govt = OTHER;
                            killgovt(wa, a[wa].govtarmy, TRUE);
                        } else saystring[0] = EOS;
                    }
                    if (saystring[0])
                    {   say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                        anykey();
            }   }   }

            // 4.2.2. Nation Income

            if (!fresh[wa])
            {   for (wc = 0; wc < CITIES; wc++)
                {   if (wa == city[wc].aruler) // if we rule this city
                    {   a[wa].treasury += city[wc].worth;
#ifdef EXTRAVERBOSE
                        Printf
                        (   "%s gets $%ld from %s.\n",
                            a[wa].name,
                            city[wc].worth,
                            colonial ? city[wc].oname : city[wc].nname
                        );
#endif
                    }
                }
            }
            fresh[wa] = FALSE;

            if (a[wa].treasury > 24)
            {   a[wa].treasury = 24;
            }
            drawtables();

            // 4.2.3.1. Maintenance of National Forces

            cost = 0;
            for (war = 0; war < setup[wa].maxarmies; war++)
            {   if (a[wa].army[war].alive)
                {   if (whosehex(a[wa].army[war].x, a[wa].army[war].y) % LAFRICANS == wa % LAFRICANS)
                    {   cost += 1 * inflation[wa]; // $1 or $2
                    } else // army is in foreign country
                    {   cost += 2 * inflation[wa]; // $2 or $4
            }   }   }
            if (maintain && a[wa].treasury >= cost)
            {   a[wa].treasury -= cost;
                drawtables();
            } else
            {   for (war = 0; war < setup[wa].maxarmies; war++)
                {   if (a[wa].army[war].alive)
                    {   if (whosehex(a[wa].army[war].x, a[wa].army[war].y) % LAFRICANS == wa % LAFRICANS)
                        {   cost = 1 * inflation[wa]; // $1 or $2
                        } else // army is in foreign country
                        {   cost = 2 * inflation[wa]; // $2 or $4
                        }

                        if (a[wa].treasury >= cost)
                        {   if (a[wa].pi < POLITICAL_CONTROL || e[we].control == CONTROL_AMIGA || we >= players)
                            {   a[wa].treasury -= cost;
                                drawtables(); // calling too often!
                            } else
                            {   select_army(wa, war, TRUE);
                                sprintf
                                (   saystring,
                                    LLL(MSG_MAINTAINARMY, "%s, maintain %s's army in %s for $%d?"),
                                    e[we].name,
                                    a[wa].name,
                                    a[whosehex(a[wa].army[war].x, a[wa].army[war].y) % LAFRICANS].name,
                                    cost
                                );
                                say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_YES, "Yes"), (STRPTR) LLL(MSG_NO, "No"));
                                if (getevent(YESNO) == YES)
                                {   deselect_army(wa, war, TRUE);
                                    a[wa].treasury -= cost;
                                    drawtables();
                                } else
                                {   // hopefully(result == NO); but we can't assert it, as we didn't save the return code into a variable!
                                    adie(wa, war, TRUE);
                        }   }   }
                        else
                        {   adie(wa, war, TRUE);
                            sprintf
                            (   saystring,
                                LLL(MSG_CANTMAINTAINARMY, "%s was unable to maintain army #%d."),
                                a[wa].name,
                                war + 1
                            );
                            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                            anykey();
            }   }   }   }

            // 4.2.3.2. Raising New Forces

            if (we < players)
            {   if (a[wa].pi >= POLITICAL_CONTROL)
                {   cost = 2 * inflation[wa];

                    for (war = 0; war < setup[wa].maxarmies; war++)
                    {   if (!a[wa].army[war].alive && a[wa].treasury >= cost)
                        {   if (e[we].control == CONTROL_HUMAN)
                            {   ok = FALSE;
                                while (!ok)
                                {   sprintf
                                    (   saystring,
                                        LLL(MSG_BUILDARMIES, "%s, build armies at $%d per army (Esc when done)..."),
                                        a[wa].name,
                                        cost
                                    );
                                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_HEX, "Hex"), (STRPTR) LLL(MSG_DONE, "Done")); // but it doesn't really need to be resaid each time
                                    escaped = FALSE;
                                    result = getevent(HEX);
                                    if (escaped)
                                    {   goto BUILDARMIES_DONE; // eat shit Edgar Djicklicker! :-)
                                    } elif (result == -1)
                                    {   ; /* strcpy(saystring, "Not a valid hex.");
                                        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                        anykey(); */
                                    } elif (hexowner[yhex][xhex] % LAFRICANS != wa % LAFRICANS)
                                    {   strcpy(saystring, LLL(MSG_NOTHOME, "This is not a home hex."));
                                        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                        anykey();
                                    } elif (!vacant(xhex, yhex))
                                    {   strcpy(saystring, LLL(MSG_NOTEMPTY, "Hex is not empty."));
                                        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                        anykey();
                                    } elif (zoc(wa, xhex, yhex))
                                    {   strcpy(saystring, LLL(MSG_ZOC, "Hex is in enemy Zone of Control."));
                                        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                        anykey();
                                    } elif (!nexttoourcity(wa, xhex, yhex))
                                    {   strcpy(saystring, LLL(MSG_ARMYBUILD, "Armies must be built in or next to controlled cities."));
                                        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                        anykey();
                                    } else
                                    {   a[wa].treasury -= cost;
                                        drawtables();

                                        a[wa].army[war].alive = TRUE;
                                        a[wa].army[war].x = xhex;
                                        a[wa].army[war].y = yhex;
                                        move_army(wa, war, TRUE);

                                        ok = TRUE;
                            }   }   }
                            else
                            {   // assert(e[we].control == CONTROL_AMIGA);
                                tries = 0;
                                do
                                {   do
                                    {   xhex = goodrand() % MAPCOLUMNS;
                                        yhex = goodrand() % MAPROWS;
                                    } while
                                    (   !valid(xhex, yhex)
                                     || (hexowner[yhex][xhex] % LAFRICANS != wa % LAFRICANS)
                                    );

                                    if (vacant(xhex, yhex) && !zoc(wa, xhex, yhex))
                                    {   ok = TRUE;
                                        a[wa].treasury -= cost;
                                        drawtables();

                                        a[wa].army[war].alive = TRUE;
                                        a[wa].army[war].x = xhex;
                                        a[wa].army[war].y = yhex;
                                        move_army(wa, war, TRUE);
                                    } else
                                    {   ok = FALSE;
                                        tries++;
                                }   }
                                while (!ok && tries < 200);

                                if (ok)
                                {   sprintf
                                    (   saystring,
                                        LLL(MSG_BUILDSARMY, "%s builds an army."),
                                        a[wa].name
                                    );
                                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                    anykey();
                }   }   }   }   }

BUILDARMIES_DONE:
                // 4.2.3.3. Declaring War

                if (a[wa].pi >= MILITARY_CONTROL)
                {   cost = 3 * inflation[wa];

                    if (e[we].control == CONTROL_HUMAN)
                    {   thewho = 0;
                        while (a[wa].treasury >= cost && thewho != -1)
                        {   sprintf
                            (   saystring,
                                LLL(MSG_DECLAREWARS, "%s, declare wars for %s against ($%d per war)..."),
                                e[we].name,
                                a[wa].name,
                                cost
                            );
                            say(UPPER, AFROCOLOUR + wa, "-", "-");
                            for (we2 = 0; we2 < EUROPEANS; we2++)
                            {   enabled[we2] = FALSE;
                            }
                            for (wa2 = 0; wa2 < RAFRICANS; wa2++)
                            {   if
                                (   a[wa2].aruler == wa2
                                 && !a[wa].declared[wa2]
                                 && wa != wa2
                                )
                                {   enabled[EUROPEANS + wa2] = TRUE;
                                } else
                                {   enabled[EUROPEANS + wa2] = FALSE;
                            }   }

                            strcpy(WhoTitle, LLL(MSG_HAIL_DECLAREWAR, "Declare war on..."));
                            thewho = dowho(we, FALSE, NULL, 0);
                            if (thewho != -1)
                            {   a[wa].declared[thewho - EUROPEANS] = TRUE;
                                a[wa].treasury -= cost;
                                drawtables();
                    }   }   }
                    else
                    {   // assert(e[we].control == CONTROL_AMIGA);

                        // this always prefers to declare war against lower-numbered nations.

                        for (wa2 = 0; wa2 < RAFRICANS; wa2++)
                        {   if
                            (   a[wa].treasury >= cost
                             && a[wa2].aruler == wa2    // if it is a sovereign (independent) country
                             && !a[wa].declared[wa2]    // and we have not already declared war on them
                             && (   a[wa2].pi == 0      // and they are politically neutral
                                 || a[wa2].eruler != we // or politically unfriendly
                                )
                             && neighbours[wa % LAFRICANS][wa2 % LAFRICANS] == 1
                            )
                            {   a[wa].declared[wa2] = TRUE;
                                a[wa].treasury -= cost;
                                drawtables();

                                sprintf
                                (   saystring,
                                    LLL(MSG_DECLARESWAR, "%s declares war on %s."),
                                    a[wa].name,
                                    a[wa2].name
                                );
                                say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                anykey();
                }   }   }   }

                // 4.2.4. Movement

                if (a[wa].pi >= POLITICAL_CONTROL)
                {   if (e[we].control == CONTROL_AMIGA)
                    {   if (wa < LAFRICANS)
                        {   sprintf
                            (   saystring,
                                LLL(MSG_IS_MOVING, "%s is moving..."),
                                a[wa].name
                            );
                        } else
                        {   sprintf
                            (   saystring,
                                LLL(MSG_ARE_MOVING, "%s are moving..."),
                                a[wa].name
                            );
                        }
                        say(UPPER, AFROCOLOUR + wa, "-", "-");

                        if (e[we].iu && e[we].iuhost == wa)
                        {   emove_amiga(we);
                        }

                        for (war = 0; war < setup[wa].maxarmies; war++)
                        {   if (a[wa].army[war].alive)
                            {   amove_amiga(wa, war);
                    }   }   }
                    else
                    {   // assert(e[we].control == CONTROL_HUMAN);

                        emoves = 0;
                        for (war = 0; war < setup[wa].maxarmies; war++)
                        {   amoves[war] = 0;
                        }

                        for (;;)
                        {   if (e[we].iu && e[we].iuhost == wa && emoves < 5)
                            {   movables = 1;
                            } else
                            {   movables = 0;
                            }
                            for (war = 0; war < setup[wa].maxarmies; war++)
                            {   if (a[wa].army[war].alive && amoves[war] < 5)
                                {   movables++;
                            }   }

                            if (movables == 0)
                            {   break;
                            } elif (movables == 1)
                            {   if (e[we].iu && e[we].iuhost == wa && emoves < 5)
                                {   emove_human(we, FALSE);
                                } else
                                {   for (war = 0; war < setup[wa].maxarmies; war++)
                                    {   if (a[wa].army[war].alive && amoves[war] < 5)
                                        {   amove_human(we, wa, war, FALSE);
                                            break; // for speed
                                }   }   }
                                break;
                            } elif (movables >= 2)
                            {   if (selectmover(we, wa))
                                {   break;
                }   }   }   }   }

                checkowners();
                we = a[wa].eruler; // for convenience

                // 4.2.5. Attacks

                if (a[wa].pi >= POLITICAL_CONTROL)
                {   eattack_country =
                    eattack_army    = -1;
                    for (war = 0; war < setup[wa].maxarmies; war++)
                    {   aattack_country[war] =
                        aattack_army[war]    = -1;
                    }

                    if (e[we].iu && e[we].iuhost == wa)
                    {   if (e[we].control == CONTROL_HUMAN)
                        {   eattack_human(we);
                        } else
                        {   // assert(e[we].control == CONTROL_AMIGA);
                            eattack_amiga(we);
                    }   }

                    for (war = 0; war < setup[wa].maxarmies; war++)
                    {   if (a[wa].army[war].alive)
                        {   if (e[we].control == CONTROL_HUMAN)
                            {   aattack_human(wa, war);
                            } else
                            {   // assert(e[we].control == CONTROL_AMIGA);
                                aattack_amiga(wa, war);
                    }   }   }

                    dobattles(we, wa);
                }

                checkowners();
                we = a[wa].eruler; // for convenience
            }

            // 4.2.6. Supply

            // 4.2.7. Revolution

            if
            (   wa < LAFRICANS
             && a[LAFRICANS + wa].aruler == wa
             && a[wa].is <= 3
            )
            {   if (a[wa].govt == LEADER)
                {   chance = 4 - a[wa].pi;
                } elif (a[wa].govt == JUNTA)
                {   chance = 5 - a[wa].pi;
                } else
                {   chance = 6 - a[wa].pi;
                }
                revolted = FALSE;

                for (war = 0; war < setup[wa].maxarmies; war++)
                {   if
                    (   a[wa].army[war].alive
                     && (a[wa].govt == OTHER || a[wa].govtarmy != war)
                     && die() <= chance
                    )
                    {   // it's a rebel army now, so find a spare army
                        for (war2 = 0; war2 < setup[LAFRICANS + wa].maxarmies; war2++)
                        {   if (!a[LAFRICANS + wa].army[war2].alive)
                            {   revolted = TRUE;
                                a[LAFRICANS + wa].army[war2].x = a[wa].army[war].x;
                                a[LAFRICANS + wa].army[war2].y = a[wa].army[war].y;
                                a[LAFRICANS + wa].army[war2].alive = TRUE;
                                a[wa].army[war].alive = FALSE;
                                remove_army(wa, war, FALSE);
                                move_army(LAFRICANS + wa, war2, FALSE);
                                select_army(LAFRICANS + wa, war2, FALSE);
                                // updatescreen() not needed as say() does it
                                for (wc = 0; wc < CITIES; wc++)
                                {   if (ourarmy(LAFRICANS + wa, city[wc].x, city[wc].y) != -1)
                                    {   city[wc].aruler = LAFRICANS + wa;
                                        break;
                                }   }
                                sprintf
                                (   saystring,
                                    LLL(MSG_ARMYREBELLED, "This army has rebelled against %s."),
                                    a[wa].name
                                );
                                say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                anykey();
                                deselect_army(LAFRICANS + wa, war2, TRUE);
                                break;
                }   }   }   }

                if (a[wa].govt != OTHER)
                {   for (wc = 0; wc < CITIES; wc++)
                    {   if
                        (   govtx(wa) == city[wc].x
                         && govty(wa) == city[wc].y
                        )
                        {   govtcity = wc;
                            break;
                }   }   }
                else
                {   govtcity = -1;
                }

                for (wc = 0; wc < CITIES; wc++)
                {   if
                    (   city[wc].aruler == wa // any ruled (controlled) city can rebel
                     && die() <= chance
                     && wc != govtcity
                     && ourarmy(wa, city[wc].x, city[wc].y) == -1
                    )
                    {   revolted = TRUE;
                        city[wc].aruler = LAFRICANS + wa;
                        sprintf
                        (   saystring,
                            LLL(MSG_CITYREBELLED, "%s has become a rebel city."),
                            colonial ? city[wc].oname : city[wc].nname
                        );
                        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                        anykey();
                }   }

                ok = FALSE;
                for (wc = 0; wc < CITIES; wc++)
                {   if (city[wc].aruler == LAFRICANS + wa)
                    {   ok = TRUE;
                        break;
                }   }
                if (ok)
                {   a[wa].declared[LAFRICANS + wa] =
                    a[LAFRICANS + wa].declared[wa] = TRUE;

                    // decide who has Political Influence over the rebels

                    bestresult = 0;
                    do
                    {   tied = FALSE;
                        for (we2 = 0; we2 < players; we2++)
                        {   if (we != we2)
                            {   result = die();
                                if (result > bestresult)
                                {   bestresult = result;
                                    besteuro = we2;
                                } elif (result == bestresult)
                                {   tied = TRUE;
                    }   }   }   }
                    while (tied);

                    a[LAFRICANS + wa].eruler   = besteuro;
                    a[LAFRICANS + wa].aruler   = LAFRICANS + wa;
                    a[LAFRICANS + wa].pi       = bestresult;
                    a[LAFRICANS + wa].is       = a[wa].is;
                    a[LAFRICANS + wa].treasury = 0;

                    drawtables(); // calls afrocolours() automatically

                    sprintf
                    (   saystring,
                        LLL(MSG_VIABLE, "%s are viable."),
                        a[LAFRICANS + wa].name
                    );
                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
                } elif (revolted)
                {   // kill all rebel armies
                    for (war = 0; war < setup[LAFRICANS + wa].maxarmies; war++)
                    {   if (a[LAFRICANS + wa].army[war].alive)
                        {   adie(LAFRICANS + wa, war, FALSE);
                    }   }
                    // all rebel cities become loyal
                    for (wc = 0; wc < CITIES; wc++)
                    {   if (city[wc].aruler == LAFRICANS + wa)
                        {   city[wc].aruler = wa;
                    }   }

                    // updatescreen() not needed as say() does it
                    sprintf
                    (   saystring,
                        LLL(MSG_NOTVIABLE, "%s are not viable."),
                        a[LAFRICANS + wa].name
                    );
                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
            }   }

            // 4.2.8. Recreation of nations

            if
            (   we < players
             && wa < LAFRICANS
             && a[wa].pi >= POLITICAL_CONTROL
            )
            {   for (wa2 = 0; wa2 < LAFRICANS; wa2++)
                {   if (wa != wa2 && a[wa2].aruler == wa)
                    {   if (e[we].control == CONTROL_HUMAN)
                        {   sprintf
                            (   saystring,
                                LLL(MSG_GRANT, "%s, shall %s grant independence to %s?"),
                                e[we].name,
                                a[wa].name,
                                a[wa2].name
                            );
                            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_YES, "Yes"), (STRPTR) LLL(MSG_NO, "No"));
                            if (getevent(YESNO) == YES)
                            {   a[wa2].aruler = wa2;
                                a[wa2].eruler = we;
                                a[wa2].pi = a[wa].pi;
                                a[wa2].is = a[wa].is;
                                a[wa2].treasury = 0;
                                a[wa].declared[wa2] =
                                a[wa2].declared[wa] = FALSE;
                                fallen[wa2] = FALSE;
                                fresh[wa2] = TRUE;

                                for (wc = 0; wc < CITIES; wc++)
                                {   if (city[wc].aruler == wa && city[wc].oaruler == wa2)
                                    {   city[wc].aruler = wa2;
                                }   }
                                for (wa3 = 0; wa3 < RAFRICANS; wa3++)
                                {   a[wa2].declared[wa3] = FALSE;
                                }
                                drawtables();
                        }   }
                        else
                        {   // assert(e[we].control == CONTROL_AMIGA);
                            if
                            (   (a[wa].pi >= 7 && a[wa].is >= 7)
                             || theround == rounds
                            )
                            {   a[wa2].aruler = wa2;
                                a[wa2].eruler = we;
                                a[wa2].pi = a[wa].pi;
                                a[wa2].is = a[wa].is;
                                a[wa2].treasury = 0;
                                a[wa].declared[wa2] =
                                a[wa2].declared[wa] = FALSE;
                                fallen[wa2] = FALSE;
                                fresh[wa2] = TRUE;

                                for (wc = 0; wc < CITIES; wc++)
                                {   if (city[wc].aruler == wa && city[wc].oaruler == wa2)
                                    {   city[wc].aruler = wa2;
                                }   }
                                for (wa3 = 0; wa3 < RAFRICANS; wa3++)
                                {   a[wa2].declared[wa3] = FALSE;
                                }
                                drawtables();

                                sprintf
                                (   saystring,
                                    LLL(MSG_GRANTS, "%s has granted independence to %s."),
                                    a[wa].name,
                                    a[wa2].name
                                );
                                say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                                anykey();
}   }   }   }   }   }   }   }

EXPORT FLAG nextto(SLONG sourcex, SLONG sourcey, SLONG destx, SLONG desty)
{   SLONG xx, yy;

    // Answers the question, "is the destination hex adjacent to the
    // source hex?" Doesn't look at the central hex.

    // look at northwest hex
    if (sourcey % 2 == 0)
    {   xx = sourcex - 1;
    } else
    {   xx = sourcex;
    }
    yy = sourcey - 1;
    if
    (   valid(xx, yy) // make sure it was really possible to move there, eg. not Lake Victoria (although valid() should sort this out for us)!
     && destx == xx // if what you clicked equals the northwest possibility for this army
     && desty == yy
    )
    {   return TRUE;
    }

    // look at northeast hex
    if (sourcey % 2 == 0)
    {   xx = sourcex;
    } else
    {   xx = sourcex + 1;
    }
    yy = sourcey - 1;
    if
    (   valid(xx, yy) // make sure it was really possible to move there, eg. not Lake Victoria (although valid() should sort this out for us)!
     && destx == xx // if what you clicked equals the northwest possibility for this army
     && desty == yy
    )
    {   return TRUE;
    }

    // look at west hex
    xx = sourcex - 1;
    yy = sourcey;
    if
    (   valid(xx, yy) // make sure it was really possible to move there, eg. not Lake Victoria (although valid() should sort this out for us)!
     && destx == xx // if what you clicked equals the northwest possibility for this army
     && desty == yy
    )
    {   return TRUE;
    }

    // look at east hex
    xx = sourcex + 1;
    yy = sourcey;
    if
    (   valid(xx, yy) // make sure it was really possible to move there, eg. not Lake Victoria (although valid() should sort this out for us)!
     && destx == xx // if what you clicked equals the northwest possibility for this army
     && desty == yy
    )
    {   return TRUE;
    }

    // look at southwest hex
    if (sourcey % 2 == 0)
    {   xx = sourcex - 1;
    } else
    {   xx = sourcex;
    }
    yy = sourcey + 1;
    if
    (   valid(xx, yy) // make sure it was really possible to move there, eg. not Lake Victoria (although valid() should sort this out for us)!
     && destx == xx // if what you clicked equals the northwest possibility for this army
     && desty == yy
    )
    {   return TRUE;
    }

    // look at southeast hex
    if (sourcey % 2 == 0)
    {   xx = sourcex;
    } else
    {   xx = sourcex + 1;
    }
    yy = sourcey + 1;
    if
    (   valid(xx, yy) // make sure it was really possible to move there, eg. not Lake Victoria (although valid() should sort this out for us)!
     && destx == xx // if what you clicked equals the northwest possibility for this army
     && desty == yy
    )
    {   return TRUE;
    }

    return FALSE;
}

EXPORT FLAG spareleader(SLONG we)
{   // answers the question 'does this player have a spare (ie. unused,
    // not in play) leader counter?'

    SLONG leaders = 0,
          wa;

    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (a[wa].aruler == wa && a[wa].eruler == we && a[wa].govt == LEADER)
        {   leaders++;
    }   }
    if (leaders < e[we].maxleaders)
    {   return TRUE;
    } else
    {   return FALSE;
}   }
EXPORT FLAG sparejunta(SLONG we)
{   // answers the question 'does this player have a spare (ie. unused,
    // not in play) junta counter?'

    SLONG juntas = 0,
          wa;

    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (a[wa].aruler == wa && a[wa].eruler == we && a[wa].govt == JUNTA)
        {   juntas++;
    }   }
    if (juntas < e[we].maxjuntas)
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT SLONG ourarmy(SLONG wa, SLONG x, SLONG y)
{   SLONG war;

    for (war = 0; war < setup[wa].maxarmies; war++)
    {   if
        (   a[wa].army[war].alive
         && a[wa].army[war].x == x
         && a[wa].army[war].y == y
        )
        return war;
    }

    return -1;
}
EXPORT int cityhere(SLONG x, SLONG y)
{   SLONG wc;

    for (wc = 0; wc < CITIES; wc++)
    {   if
        (   city[wc].x == x
         && city[wc].y == y
        )
        {   return city[wc].worth;
    }   }

    return 0;
}

MODULE void place_amiga(SLONG wa)
{   SLONG donecities = 0,
          war;

    for (war = 0; war < setup[wa].initarmies; war++)
    {   do
        {   xhex = goodrand() % MAPCOLUMNS;
            yhex = goodrand() % MAPROWS   ;
        } while
        (    !valid(xhex, yhex)
          || !vacant(xhex, yhex)
          || wa != a[hexowner[yhex][xhex]].aruler
          || (donecities < setup[wa].cities && !cityhere(xhex, yhex))
        );

        a[wa].army[war].alive = TRUE;
        a[wa].army[war].x = xhex;
        a[wa].army[war].y = yhex;
        move_army(wa, war, FALSE);
        donecities++;
    }

    if (a[wa].govt != OTHER)
    {   do
        {   xhex = goodrand() % MAPCOLUMNS;
            yhex = goodrand() % MAPROWS   ;
        } while
        (    !valid(xhex, yhex)
          || vacant(xhex, yhex)
          || wa != a[hexowner[yhex][xhex]].aruler
          || !cityhere(xhex, yhex)
        );

        a[wa].govtarmy = ourarmy(wa, xhex, yhex);
        // assert(a[wa].govtarmy != -1);

        if (a[wa].govt == LEADER)
        {   makeleader(wa, a[wa].govtarmy, FALSE);
        } else
        {   // assert(a[wa].govt == JUNTA);
            makejunta(wa, a[wa].govtarmy, FALSE);
    }   }

    updatescreen();
}

EXPORT void engine_newgame(void)
{   SLONG wa,
          we,
          war;
    int   i;

    ingame = TRUE;
    for (we = 0; we < EUROPEANS; we++)
    {   for (i = 0; i <= MAX_ROUNDS; i++)
        {   score[we][i] = 0;
    }   }
    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (a[wa].aruler == wa) // if country is independent (ie. not conquered)
        {   if (a[wa].eruler < players)
            {   // African is controlled by a European that is indeed playing

                if (e[a[wa].eruler].control == CONTROL_HUMAN && !autosetup)
                {   for (war = 0; war < setup[wa].initarmies; war++)
                    {   place_army(a[wa].eruler, wa, war);
                    }

                    if (a[wa].govt != OTHER)
                    {   place_govt(a[wa].eruler, wa, a[wa].govt);
                }   }
                else
                {   sprintf
                    (   saystring,
                        LLL(MSG_EUROSETUP, "%s is setting up %s..."),
                        e[a[wa].eruler].name,
                        a[wa].name
                    );
                    say(UPPER, EUROCOLOUR + a[wa].eruler, "-", "-");
                    place_amiga(wa);
            }   }
            else
            {   sprintf
                (   saystring,
                    LLL(MSG_AFROSETUP, "%s is setting up..."),
                    a[wa].name
                );
                say(UPPER, AFROCOLOUR + wa, "-", "-");
                place_amiga(wa);
}   }   }   }

MODULE void checkowners(void)
{   SLONG wc,
          whose,
          we,
          wa,
          wa2,
          wa3,
          war;
    FLAG  ok;

    for (wc = 0; wc < CITIES; wc++)
    {   ok = FALSE;
        for (we = 0; we < players; we++)
        {   if
            (   e[we].iu
             && e[we].iux == city[wc].x
             && e[we].iuy == city[wc].y
            )
            {   takecity(e[we].iuhost, wc);
                ok = TRUE;
                break;
        }   }

        if (!ok)
        {   for (wa = 0; wa < RAFRICANS; wa++)
            {   if (ourarmy(wa, city[wc].x, city[wc].y) != -1)
                {   takecity(wa, wc);
                    ok = TRUE;
                    break;
        }   }   }

        if (!ok)
        {   whose = -1;

            for (we = 0; we < players; we++)
            {   if
                (   e[we].iu
                 && nextto(city[wc].x, city[wc].y, e[we].iux, e[we].iuy)
                 && movable(e[we].iuhost, city[wc].x, city[wc].y)
                )
                {   if (whose == -1 || whose == e[we].iuhost)
                    {   whose = e[we].iuhost;
                    } else
                    {   whose = -2;
            }   }   }

            for (wa = 0; wa < RAFRICANS; wa++)
            {   for (war = 0; war < setup[wa].maxarmies; war++)
                {   if
                    (   a[wa].army[war].alive
                     && nextto(city[wc].x, city[wc].y, a[wa].army[war].x, a[wa].army[war].y)
                     && movable(wa, city[wc].x, city[wc].y)
                    )
                    {   if (whose == -1 || whose == wa)
                        {   whose = wa;
                        } else
                        {   whose = -2;
            }   }   }   }

            if (whose >= 0)
            {   takecity(whose, wc);
    }   }   }

    for (wa3 = 0; wa3 < RAFRICANS; wa3++)
    {   if (wa3 < LAFRICANS)
        {   wa = wa3 + LAFRICANS;
        } else
        {   wa = wa3 - LAFRICANS;
        }
        if (a[wa].aruler == wa)
        {   ok = FALSE;
            for (war = 0; war < setup[wa].maxarmies; war++)
            {   if (a[wa].army[war].alive)
                {   ok = TRUE;
                    break; // for speed
            }   }

            if (!ok)
            {   // nation has no armies

                for (wc = 0; wc < CITIES; wc++)
                {   if (city[wc].aruler == wa)
                    {   ok = TRUE;
                        break; // for speed
            }   }   }

            if (!ok)
            {   // nation has neither armies nor cities.

                // any IU attached to the conquered nation is destroyed
                if
                (   e[a[wa].eruler].iu
                 && e[a[wa].eruler].iuhost == wa
                )
                {   edie(a[wa].eruler, TRUE);
                }

                // If the loyal nation has fallen, the rebels
                // take control of that country. No matter whether it
                // was the rebels or a foreign power that destroyed
                // the loyal nation.

                if (wa < LAFRICANS && a[LAFRICANS + wa].aruler == LAFRICANS + wa)
                {   // loyal government has been overrun, revolution succeeded

                    if (e[a[wa].eruler].iu && e[a[wa].eruler].iuhost == LAFRICANS + wa)
                    {   e[a[wa].eruler].iuhost = wa;
                    }
                    a[wa].eruler   = a[LAFRICANS + wa].eruler;
                    a[wa].pi       = a[LAFRICANS + wa].pi;
                    a[wa].is       = a[LAFRICANS + wa].is;
                    a[wa].treasury = a[LAFRICANS + wa].treasury;
                    a[wa].govt     = a[LAFRICANS + wa].govt;
                    a[wa].govtarmy = a[LAFRICANS + wa].govtarmy;

                    for (war = 0; war < setup[LAFRICANS + wa].maxarmies; war++)
                    {   a[wa].army[war].alive = a[LAFRICANS + wa].army[war].alive;
                        a[wa].army[war].x     = a[LAFRICANS + wa].army[war].x;
                        a[wa].army[war].y     = a[LAFRICANS + wa].army[war].y;
                        a[LAFRICANS + wa].army[war].alive = FALSE;
                        remove_army(LAFRICANS + wa, war, FALSE);
                        if (a[wa].army[war].alive)
                        {   move_army(wa, war, FALSE);
                    }   }

                    a[LAFRICANS + wa].aruler = wa;
                    for (wc = 0; wc < CITIES; wc++)
                    {   if (city[wc].aruler == LAFRICANS + wa)
                        {   city[wc].aruler = wa;
                    }   }
                    for (wa2 = 0; wa2 < RAFRICANS; wa2++)
                    {   a[wa].declared[wa2] = a[LAFRICANS + wa].declared[wa2]; // new loyalists have same declared wars as old rebels
                        a[wa2].declared[wa] = a[wa2].declared[LAFRICANS + wa]; // other countries have same declared war against new loyalists as they had against old rebels
                        if (a[wa2].aruler == LAFRICANS + wa)
                        {   a[wa2].aruler = wa;
                    }   }
                    // The (former) rebels now are conquerors of all
                    // nations the loyal government had conquered, plus
                    // whatever they had themselves conquered.

                    if (a[wa].govt == LEADER)
                    {   makeleader(wa, a[wa].govtarmy, FALSE);
                    } elif (a[wa].govt == JUNTA)
                    {   makejunta(wa, a[wa].govtarmy, FALSE);
                    }

                    drawtables();
                    sprintf
                    (   saystring,
                        LLL(MSG_OVERTHROWN, "Loyalists have been overthrown in %s."),
                        a[wa].name
                    );
                    say(UPPER, AFROCOLOUR + LAFRICANS + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
                } else
                {   // If a single nation controls all the cities,
                    // that nation is the conqueror.

                    whose = -1;
                    for (wc = 0; wc < CITIES; wc++)
                    {   if (city[wc].oaruler == wa % LAFRICANS) // it is a city of the nation in question
                        {   if (whose == -1 || whose == city[wc].aruler)
                            {   whose = city[wc].aruler;
                            } else
                            {   whose = -2;
                    }   }   }
                    if (whose >= 0)
                    {   for (wa2 = 0; wa2 < RAFRICANS; wa2++)
                        {   if (a[wa2].aruler == wa)
                            {   a[wa2].aruler = whose;
                        }   }

                        drawtables();
                        sprintf
                        (   saystring,
                            LLL(MSG_CONQUERED, "%s has been conquered by %s."),
                            a[wa].name,
                            a[whose].name
                        );
                        say(UPPER, AFROCOLOUR + whose, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                        anykey();
                    } elif (!fallen[wa])
                    {   fallen[wa] = TRUE;

                        drawtables();
                        sprintf
                        (   saystring,
                            LLL(MSG_FALLEN, "%s has fallen!"),
                            a[wa].name
                        );
                        say(UPPER, WHITE, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                        anykey();
}   }   }   }   }   }

MODULE FLAG vacant(SLONG x, SLONG y)
{   SLONG we,
          wa;

    for (we = 0; we < players; we++)
    {   if (e[we].iu && e[we].iux == x && e[we].iuy == y)
        {   return FALSE;
    }   }

    for (wa = 0; wa < RAFRICANS; wa++)
    {   if (ourarmy(wa, x, y) != -1)
        {   return FALSE;
    }   }

    return TRUE;
}

EXPORT FLAG hasarmy(SLONG wa)
{   SLONG war;

    for (war = 0; war < setup[wa].maxarmies; war++)
    {   if (a[wa].army[war].alive)
        {   return TRUE;
    }   }

    return FALSE;
}

MODULE FLAG hate(SLONG wa, SLONG we)
{   SLONG wa2;

    // determines whether this African country hates this European country
    // wa2 is African version of we
    if (we < EUROPEANS)
    {   wa2 = e[we].iuhost;
    } else
    {   wa2 = we - EUROPEANS;
    }

    if
    (   a[wa2].eruler != a[wa].eruler
     || (a[wa2].pi == 0 && a[wa2].govt == OTHER)
    )
    {   return TRUE;
    }

    return FALSE;
}

MODULE void deselect_combatants(SLONG we, SLONG wa, SLONG victimcountry, SLONG victimarmy)
{   SLONG war;

    // deselect attackers
    if (eattacking)
    {   eattack_country =
        eattack_army    = -1;
        deselect_iu(we, FALSE);
    }
    for (war = 0; war < setup[wa].maxarmies; war++)
    {   if (aattacking[war])
        {   aattack_country[war] =
            aattack_army[war]    = -1;
            deselect_army(wa, war, FALSE);
    }   }

    // deselect defender
    if (victimcountry < EUROPEANS)
    {   deselect_iu(victimcountry, FALSE);
    } else
    {   deselect_army(victimcountry - EUROPEANS, victimarmy, FALSE);
    }

    updatescreen();
}

MODULE FLAG takecity(SLONG wa, SLONG wc)
{   if
    (   city[wc].aruler != wa
     && (   a[wa].declared[city[wc].aruler]
         || whosehex(city[wc].x, city[wc].y) == wa
    )   )
    {   city[wc].aruler = wa;

        sprintf
        (   saystring,
            LLL(MSG_TAKESCONTROL, "%s takes control of %s."),
            a[wa].name,
            colonial ? city[wc].oname : city[wc].nname
        );
        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey();

        return TRUE;
    }

    return FALSE;
}

MODULE FLAG selectmover(SLONG we, SLONG wa)
{   SLONG war;

SELECTMOVER_START:
    sprintf
    (   saystring,
        LLL(MSG_SELECTMOVER, "%s, move for %s; select mover (Esc when done)..."),
        e[we].name,
        a[wa].name
    );
    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_ARMY, "Army"), (STRPTR) LLL(MSG_DONE, "Done"));

    escaped = FALSE;
    if (getevent(HEX) == -1)
    {   if (escaped)
        {   return TRUE;
        } else
        {   goto SELECTMOVER_START;
    }   }

    // let's see what the user clicked on

    if
    (   e[we].iu
     && e[we].iux == xhex
     && e[we].iuy == yhex
     && e[we].iuhost == wa
    )
    {   if (emoves == 5)
        {   strcpy(saystring, LLL(MSG_IULIMIT, "Your IU has already moved its limit this round."));
            say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
            anykey();
        } else
        {   // assert(emoves < 5);
            emove_human(we, FALSE);
    }   }
    else
    {   war = ourarmy(wa, xhex, yhex);
        if (war != -1)
        {   if (amoves[war] == 5)
            {   strcpy(saystring, LLL(MSG_ARMYLIMIT, "This army has already moved its limit this round."));
                say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                anykey();
            } else
            {   // assert(amoves[war] < 5);
                amove_human(we, wa, war, FALSE);
    }   }   }

    return FALSE;
}

EXPORT FLAG calcscores(void)
{   FLAG  won = FALSE;
    SLONG wa,
          we;

    for (we = 0; we < players; we++)
    {   // calculate score

        score[we][theround] = 0;
        // rebels do contribute to score
        for (wa = 0; wa < RAFRICANS; wa++)
        {   if (a[wa].eruler == we && a[wa].aruler == wa)
            {   score[we][theround] += a[wa].pi;
        }   }

        // assert(players);
        if ((score[we][theround] >= 120 / players && (theround > 1 || we != USA)) && !endless)
        {   won = TRUE; // don't break, we still want to calculate all scores
    }   }

    return won;
}

EXPORT void eattack_human(SLONG we)
{   FLAG  ok;
    SLONG wa,
          wa2,
          war2,
          wb,
          we2;

    wa = e[we].iuhost; // for convenience

    if (!canattack(wa, e[we].iux, e[we].iuy))
    {   return;
    }

    select_iu(we, TRUE);

EATTACK_DO:
    sprintf
    (   saystring,
        LLL(MSG_IUATTACK, "%s, attack with IU attached to %s (Esc to pass)..."),
        e[we].name,
        a[wa].name
    );
    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_HEX, "Hex"), (STRPTR) LLL(MSG_PASS, "Pass"));

    for (wb = 0; wb < 6; wb++)
    {   xhex = e[we].iux + xcoords[e[we].iuy % 2][wb];
        yhex = e[we].iuy + ycoords               [wb];

        ok = FALSE;
        if (valid(xhex, yhex))
        {   // find out whose army this is
            for (we2 = 0; we2 < players; we2++)
            {   if
                (   e[we2].iu
                 && e[we2].iux == xhex
                 && e[we2].iuy == yhex
                 && checkattack(wa, e[we2].iuhost, xhex, yhex, TRUE)
                )
                {   box[wb].x    = xhex;
                    box[wb].y    = yhex;
                    box[wb].kind = 2;
                    ok = TRUE;
                    break;
            }   }
            if (!ok)
            {   for (wa2 = 0; wa2 < RAFRICANS; wa2++)
                {   war2 = ourarmy(wa2, xhex, yhex);
                    if (war2 != -1 && checkattack(wa, wa2, xhex, yhex, TRUE))
                    {   box[wb].x    = xhex;
                        box[wb].y    = yhex;
                        box[wb].kind = 2;
                        ok = TRUE;
                        break;
        }   }   }   }
        if (!ok)
        {   box[wb].x = box[wb].y = -1;
    }   }

    escaped = FALSE;
    DISCARD getevent(HEX);
    if (escaped)
    {   deselect_iu(we, TRUE);
        return;
    }

    if (!valid(xhex, yhex))
    {   /* strcpy(saystring, "Not a valid hex.");
        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey(); */
        goto EATTACK_DO;
    } elif (!nextto(e[we].iux, e[we].iuy, xhex, yhex))
    {   strcpy(saystring, LLL(MSG_NOTADJACENT, "Not an adjacent hex."));
        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey();
        goto EATTACK_DO;
    } else
    {   // find out whose army this is
        for (we2 = 0; we2 < players; we2++)
        {   if
            (   e[we2].iu
             && e[we2].iux == xhex
             && e[we2].iuy == yhex
            )
            {   if (checkattack(wa, e[we2].iuhost, xhex, yhex, TRUE))
                {   eattack_country = we2;
                    eattack_army    = -1;
                    deselect_iu(we, TRUE);
                    return;
                } else
                {   notwar(wa, e[we2].iuhost);
                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
                    goto EATTACK_DO;
        }   }   }
        for (wa2 = 0; wa2 < RAFRICANS; wa2++)
        {   war2 = ourarmy(wa2, xhex, yhex);
            if (war2 != -1)
            {   if (checkattack(wa, wa2, xhex, yhex, TRUE))
                {   eattack_country = EUROPEANS + wa2;
                    eattack_army    = war2;
                    deselect_iu(we, TRUE);
                    return;
                } else
                {   notwar(wa, wa2);
                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
                    goto EATTACK_DO;
        }   }   }

        strcpy(saystring, LLL(MSG_EMPTY, "Hex is empty!"));
        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey();
        goto EATTACK_DO;
}   }

EXPORT void aattack_human(SLONG wa, SLONG war)
{   FLAG  ok;
    SLONG wb,
          we2,
          wa2,
          war2;

    if (!canattack(wa, a[wa].army[war].x, a[wa].army[war].y))
    {   return;
    }

    select_army(wa, war, TRUE);

AATTACK_DO:
    sprintf
    (   saystring,
        LLL(MSG_ARMYATTACK, "%s, attack with %s's army (Esc to pass)..."),
        e[a[wa].eruler].name,
        a[wa].name
    );
    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_HEX, "Hex"), (STRPTR) LLL(MSG_PASS, "Pass"));

    for (wb = 0; wb < 6; wb++)
    {   xhex = a[wa].army[war].x + xcoords[a[wa].army[war].y % 2][wb];
        yhex = a[wa].army[war].y + ycoords                       [wb];

        ok = FALSE;
        if (valid(xhex, yhex))
        {   // find out whose army this is
            for (we2 = 0; we2 < players; we2++)
            {   if
                (   e[we2].iu
                 && e[we2].iux == xhex
                 && e[we2].iuy == yhex
                 && checkattack(wa, e[we2].iuhost, xhex, yhex, TRUE)
                )
                {   box[wb].x    = xhex;
                    box[wb].y    = yhex;
                    box[wb].kind = 2;
                    ok = TRUE;
                    break;
            }   }
            if (!ok)
            {   for (wa2 = 0; wa2 < RAFRICANS; wa2++)
                {   war2 = ourarmy(wa2, xhex, yhex);
                    if (war2 != -1 && checkattack(wa, wa2, xhex, yhex, TRUE))
                    {   box[wb].x    = xhex;
                        box[wb].y    = yhex;
                        box[wb].kind = 2;
                        ok = TRUE;
                        break;
        }   }   }   }
        if (!ok)
        {   box[wb].x = box[wb].y = -1;
    }   }

    escaped = FALSE;
    DISCARD getevent(HEX);
    if (escaped)
    {   deselect_army(wa, war, TRUE);
        return;
    }

    if (!valid(xhex, yhex))
    {   /* strcpy(saystring, "Not a valid hex.");
        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey(); */
        goto AATTACK_DO;
    } elif (!nextto(a[wa].army[war].x, a[wa].army[war].y, xhex, yhex))
    {   strcpy(saystring, LLL(MSG_NOTADJACENT, "Not an adjacent hex."));
        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey();
        goto AATTACK_DO;
    } else
    {   // find out whose army this is

        for (we2 = 0; we2 < players; we2++)
        {   if
            (   e[we2].iu
             && e[we2].iux == xhex
             && e[we2].iuy == yhex
            )
            {   if (checkattack(wa, e[we2].iuhost, xhex, yhex, TRUE))
                {   aattack_country[war] = we2;
                    aattack_army[war]    = -1;
                    deselect_army(wa, war, TRUE);
                    return;
                } else
                {   notwar(wa, e[we2].iuhost);
                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
                    goto AATTACK_DO;
        }   }   }

        for (wa2 = 0; wa2 < RAFRICANS; wa2++)
        {   war2 = ourarmy(wa2, xhex, yhex);
            if (war2 != -1)
            {   if (checkattack(wa, wa2, xhex, yhex, TRUE))
                {   aattack_country[war] = EUROPEANS + wa2;
                    aattack_army[war]    = war2;
                    deselect_army(wa, war, TRUE);
                    return;
                } else
                {   notwar(wa, wa2);
                    say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
                    anykey();
                    goto AATTACK_DO;
        }   }   }

        strcpy(saystring, LLL(MSG_EMPTY, "Hex is empty!"));
        say(UPPER, AFROCOLOUR + wa, (STRPTR) LLL(MSG_OK, "OK"), (STRPTR) LLL(MSG_OK, "OK"));
        anykey();
        goto AATTACK_DO;
}   }

MODULE void notwar(int first, int second)
{   if (first < LAFRICANS)
    {   sprintf
        (   saystring,
            LLL(MSG_IS_NOT_AT_WAR, "%s is not at war with %s!"),
            a[first].name,
            a[second].name
        );
    } else
    {   sprintf
        (   saystring,
            LLL(MSG_ARE_NOT_AT_WAR, "%s are not at war with %s!"),
            a[first].name,
            a[second].name
        );
}   }

MODULE FLAG addorder(int we, int wo, int command, int dest, int fee, int data1)
{   int wo2;

    if (wo > 0)
    {   for (wo2 = 0; wo2 < wo; wo2++)
        {   if
            (   order[we][wo2].command == command
             && order[we][wo2].dest    == dest
            )
            {   order[we][wo2].fee   += fee;
                order[we][wo2].data1 += data1;
                cash -= fee;

                return FALSE;
    }   }   }

    order[we][wo].command = command;
    order[we][wo].dest    = dest;
    order[we][wo].fee     = fee;
    order[we][wo].data1   = data1;
    cash -= fee;

    return TRUE;
}

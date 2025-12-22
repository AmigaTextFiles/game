// 1. INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#else
    #define ZERO (BPTR) NULL
#endif

#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/graphics.h>

#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfx.h>
#include <graphics/displayinfo.h>
#include <graphics/view.h>

#include <stdio.h>
#include <stdlib.h>

#include "shared.h"
#include "saga.h"
#include "counters.h"

/* 2. DEFINES ------------------------------------------------------------

(none)

3. EXPORTED VARIABLES ----------------------------------------------------

(none)

4. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT struct Custom         custom;
IMPORT struct Window        *MainWindowPtr,
                            *InfoWindowPtr;
IMPORT struct WorldStruct    world[36 + 30];
IMPORT struct HeroStruct     hero[HEROES + 1];
IMPORT struct JarlStruct     jarl[JARLS + 1];
IMPORT struct MonsterStruct  monster[MONSTERS + 1];
IMPORT struct TreasureStruct treasure[TREASURES + 1];
IMPORT struct SordStruct     sord[SORDS + 1];
IMPORT struct Image          Counter;
IMPORT UBYTE                 remapit[128];
IMPORT UWORD                 DisplayDepth;
IMPORT UWORD                *CounterData[COUNTERIMAGES],
                            *SelectedCounterData[SELCOUNTERIMAGES];
IMPORT SLONG                 countertype,
                             treasures;
IMPORT ULONG                 DisplayWidth,
                             DisplayHeight;
IMPORT int                   xoffset,
                             yoffset;
IMPORT struct RastPort       OffScreenRastPort;
IMPORT struct Screen*        ScreenPtr;

/* 5. MODULE VARIABLES ---------------------------------------------------

(none)

6. MODULE STRUCTURES -----------------------------------------------------

(none)

7. MODULE FUNCTIONS --------------------------------------------------- */

MODULE void shadowcounter(SWORD x, SWORD y);

// 8. CODE ---------------------------------------------------------------

EXPORT void unslot_hero(SLONG whichhero)
{   if (hero[whichhero].slot != -1)
    {   world[hero[whichhero].where].slot[hero[whichhero].slot] = FALSE;
        hero[whichhero].slot = -1;
}   }
EXPORT void unslot_jarl(SLONG whichjarl)
{   if (jarl[whichjarl].slot != -1)
    {   world[jarl[whichjarl].where].slot[jarl[whichjarl].slot] = FALSE;
        jarl[whichjarl].slot = -1;
}   }
EXPORT void unslot_monster(SLONG whichmonster)
{   if (monster[whichmonster].slot != -1)
    {   world[monster[whichmonster].where].slot[monster[whichmonster].slot] = FALSE;
        monster[whichmonster].slot = -1;
}   }
EXPORT void unslot_treasure(SLONG whichtreasure)
{   if (treasure[whichtreasure].slot != -1)
    {   world[treasure[whichtreasure].where].slot[treasure[whichtreasure].slot] = FALSE;
        treasure[whichtreasure].slot = -1;
}   }
EXPORT void unslot_sord(SLONG whichsord)
{   if (sord[whichsord].slot != -1)
    {   world[sord[whichsord].where].slot[sord[whichsord].slot] = FALSE;
        sord[whichsord].slot = -1;
}   }

EXPORT void move_hero(SLONG whichhero, FLAG display)
{   SLONG whichslot;

    // This assumes the counter has already been unslotted from its old
    // location.
    for (whichslot = 0; whichslot <= SLOTS; whichslot++)
    {   if (!(world[hero[whichhero].where].slot[whichslot]))
        {   hero[whichhero].slot = whichslot;
            break;
    }   }
    world[hero[whichhero].where].slot[whichslot] = TRUE;

    hero[whichhero].xpixel = (WORD) world[hero[whichhero].where].centrex - 12;
    hero[whichhero].ypixel = (WORD) world[hero[whichhero].where].centrey - 12 - (whichslot * 7);
    if (display)
    {   updatescreen();
}   }
EXPORT void move_monster(SLONG whichmonster, FLAG display)
{   SLONG whichslot;

    // This assumes the counter has already been unslotted from its old
    // location.
    for (whichslot = 0; whichslot <= SLOTS; whichslot++)
    {   if (!(world[monster[whichmonster].where].slot[whichslot]))
        {   monster[whichmonster].slot = whichslot;
            break;
    }   }
    world[monster[whichmonster].where].slot[whichslot] = TRUE;

    monster[whichmonster].xpixel = (WORD) world[monster[whichmonster].where].centrex - 12;
    monster[whichmonster].ypixel = (WORD) world[monster[whichmonster].where].centrey - 12 - (whichslot * 7);
    if (display)
    {   updatescreen();
}   }
EXPORT void move_jarl(SLONG whichjarl, FLAG display)
{   SLONG whichslot;

    // This assumes the counter has already been unslotted from its old
    // location.
    for (whichslot = 0; whichslot <= SLOTS; whichslot++)
    {   if (!(world[jarl[whichjarl].where].slot[whichslot]))
        {   jarl[whichjarl].slot = whichslot;
            break;
    }   }
    world[jarl[whichjarl].where].slot[whichslot] = TRUE;

    jarl[whichjarl].xpixel = (WORD) world[jarl[whichjarl].where].centrex - 12;
    jarl[whichjarl].ypixel = (WORD) world[jarl[whichjarl].where].centrey - 12 - (whichslot * 7);
    if (display)
    {   updatescreen();
}   }
EXPORT void move_treasure(SLONG whichtreasure, FLAG display)
{   SLONG whichslot;

    // This assumes the counter has already been unslotted from its old
    // location.
    for (whichslot = 0; whichslot <= SLOTS; whichslot++)
    {   if (!(world[treasure[whichtreasure].where].slot[whichslot]))
        {   treasure[whichtreasure].slot = whichslot;
            break;
    }   }
    world[treasure[whichtreasure].where].slot[whichslot] = TRUE;

    treasure[whichtreasure].xpixel = (WORD) world[treasure[whichtreasure].where].centrex - 12;
    treasure[whichtreasure].ypixel = (WORD) world[treasure[whichtreasure].where].centrey - 12 - (whichslot * 7);
    if (display)
    {   updatescreen();
}   }
EXPORT void move_sord(SLONG whichsord, FLAG display)
{   SLONG whichslot;

    // This assumes the counter has already been unslotted from its old
    // location.
    for (whichslot = 0; whichslot <= SLOTS; whichslot++)
    {   if (!(world[sord[whichsord].where].slot[whichslot]))
        {   sord[whichsord].slot = whichslot;
            break;
    }   }
    world[sord[whichsord].where].slot[whichslot] = TRUE;

    sord[whichsord].xpixel = (WORD) world[sord[whichsord].where].centrex - 12;
    sord[whichsord].ypixel = (WORD) world[sord[whichsord].where].centrey - 12 - (whichslot * 7);
    if (display)
    {   updatescreen();
}   }

EXPORT void init_counters(void)
{   SLONG whichhero, whichjarl, whichmonster, whichtreasure, whichsord;

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   hero[whichhero].slot = -1;
    }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   jarl[whichjarl].slot = -1;
    }
    for (whichmonster = 0; whichmonster <= MONSTERS; whichmonster++)
    {   monster[whichmonster].slot = -1;
    }
    for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
    {   treasure[whichtreasure].slot = -1;
    }
    for (whichsord = 0; whichsord <= SORDS; whichsord++)
    {   sord[whichsord].slot = -1;
}   }

EXPORT void revealjarl(SLONG whichjarl, FLAG display)
{   jarl[whichjarl].face        = FACEUP;
    jarl[whichjarl].recruitable = TRUE;
    jarl[whichjarl].image       = (UWORD*) CounterData[FIRSTIMAGE_JARL + whichjarl];
    if (display)
    {   updatescreen();
}   }

EXPORT void hidejarl(SLONG whichjarl, FLAG display)
{   jarl[whichjarl].face        = FACEDOWN;
    jarl[whichjarl].recruitable = FALSE;
    jarl[whichjarl].image       = (UWORD*) CounterData[FIRSTIMAGE_JARL + JARLS + 1];
    if (display)
    {   updatescreen();
}   }

EXPORT SLONG checkcounters(SWORD mousex, SWORD mousey)
{   SLONG foundy,
          whichhero,
          whichcounter = -1,
          whichjarl,
          whichmonster,
          whichtreasure, whichsord;
    FLAG  found = FALSE;

    countertype = -1;
    mousex -= LEFTGAP;
    mousey -= TOPGAP;

    /* This assumes that counters with higher y-values (ie. lower on the
    screen) have higher priority than those with lower y-values. */

    // find all counters lying under the pointer
    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if
        (   mousex >= hero[whichhero].xpixel
         && mousex <= hero[whichhero].xpixel + 24 - 1
         && mousey >= hero[whichhero].ypixel
         && mousey <= hero[whichhero].ypixel + 24 - 1
        )
        {   hero[whichhero].foundbob = TRUE;
            found = TRUE;
    }   }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if
        (   mousex >= jarl[whichjarl].xpixel
         && mousex <= jarl[whichjarl].xpixel + 24 - 1
         && mousey >= jarl[whichjarl].ypixel
         && mousey <= jarl[whichjarl].ypixel + 24 - 1
        )
        {   jarl[whichjarl].foundbob = TRUE;
            found = TRUE;
    }   }
    for (whichmonster = 0; whichmonster <= MONSTERS; whichmonster++)
    {   if
        (   mousex >= monster[whichmonster].xpixel
         && mousex <= monster[whichmonster].xpixel + 24 - 1
         && mousey >= monster[whichmonster].ypixel
         && mousey <= monster[whichmonster].ypixel + 24 - 1
        )
        {   monster[whichmonster].foundbob = TRUE;
            found = TRUE;
    }   }
    for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
    {   if
        (   mousex >= treasure[whichtreasure].xpixel
         && mousex <= treasure[whichtreasure].xpixel + 24 - 1
         && mousey >= treasure[whichtreasure].ypixel
         && mousey <= treasure[whichtreasure].ypixel + 24 - 1
        )
        {   treasure[whichtreasure].foundbob = TRUE;
            found = TRUE;
    }   }
    for (whichsord = 0; whichsord <= SORDS; whichsord++)
    {   if
        (   mousex >= sord[whichsord].xpixel
         && mousex <= sord[whichsord].xpixel + 24 - 1
         && mousey >= sord[whichsord].ypixel
         && mousey <= sord[whichsord].ypixel + 24 - 1
        )
        {   sord[whichsord].foundbob = TRUE;
            found = TRUE;
    }   }

    if (!found)
    {   return(-1);
    }

    // determine which counter is topmost (ie. which is lower on the screen)
    foundy = -1;
    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   if
        (   hero[whichhero].foundbob
         && hero[whichhero].ypixel > (WORD) foundy
        )
        {   whichcounter = whichhero;
            countertype = HERO;
            foundy = hero[whichhero].ypixel;
        }
        hero[whichhero].foundbob = FALSE;
    }
    for (whichjarl = 0; whichjarl <= JARLS; whichjarl++)
    {   if
        (   jarl[whichjarl].foundbob
         && jarl[whichjarl].ypixel > (WORD) foundy
        )
        {   whichcounter = whichjarl;
            countertype = JARL;
            foundy = jarl[whichjarl].ypixel;
        }
        jarl[whichjarl].foundbob = FALSE;
    }
    for (whichmonster = 0; whichmonster <= MONSTERS; whichmonster++)
    {   if
        (   monster[whichmonster].foundbob
         && monster[whichmonster].ypixel > (WORD) foundy
        )
        {   whichcounter = whichmonster;
            countertype = MONSTER;
            foundy = monster[whichmonster].ypixel;
        }
        monster[whichmonster].foundbob = FALSE;
    }
    for (whichtreasure = 0; whichtreasure <= TREASURES; whichtreasure++)
    {   if
        (   treasure[whichtreasure].foundbob
         && treasure[whichtreasure].ypixel > (WORD) foundy
        )
        {   whichcounter = whichtreasure;
            countertype = TREASURE;
            foundy = treasure[whichtreasure].ypixel;
        }
        treasure[whichtreasure].foundbob = FALSE;
    }
    for (whichsord = 0; whichsord <= SORDS; whichsord++)
    {   if
        (   sord[whichsord].foundbob
         && sord[whichsord].ypixel > (WORD) foundy
        )
        {   whichcounter = whichsord;
            countertype = SORD;
            foundy = sord[whichsord].ypixel;
        }
        sord[whichsord].foundbob = FALSE;
    }

    return(whichcounter);
}

EXPORT void select_hero(SLONG whichhero, FLAG display)
{   if (hero[whichhero].promoted != -1)
    {   hero[whichhero].image = (UWORD*) SelectedCounterData[FIRSTIMAGE_JARL + hero[whichhero].promoted];
    } else
    {   hero[whichhero].image = (UWORD*) SelectedCounterData[FIRSTIMAGE_HERO + whichhero];
    }

    if (display)
    {   updatescreen();
}   }
EXPORT void deselect_hero(SLONG whichhero, FLAG display)
{   if (hero[whichhero].promoted != -1)
    {   hero[whichhero].image = (UWORD*) CounterData[FIRSTIMAGE_JARL + hero[whichhero].promoted];
    } else
    {   hero[whichhero].image = (UWORD*) CounterData[FIRSTIMAGE_HERO + whichhero];
    }

    if (display)
    {   updatescreen();
}   }
EXPORT void select_jarl(SLONG whichjarl, FLAG display)
{   jarl[whichjarl].image = (UWORD*) SelectedCounterData[FIRSTIMAGE_JARL + whichjarl];

    if (display)
    {   updatescreen();
}   }
EXPORT void deselect_jarl(SLONG whichjarl, FLAG display)
{   jarl[whichjarl].image = (UWORD*) CounterData[FIRSTIMAGE_JARL + whichjarl];

    if (display)
    {   updatescreen();
}   }
EXPORT void select_monster(SLONG whichmonster, FLAG display)
{   monster[whichmonster].image = (UWORD*) SelectedCounterData[FIRSTIMAGE_MONSTER + whichmonster];

    if (display)
    {   updatescreen();
}   }
EXPORT void deselect_monster(SLONG whichmonster, FLAG display)
{   monster[whichmonster].image = (UWORD*) CounterData[FIRSTIMAGE_MONSTER + whichmonster];

    if (display)
    {   updatescreen();
}   }

EXPORT void remove_hero(SLONG whichhero, FLAG display)
{   unslot_hero(whichhero);
    hero[whichhero].xpixel = HIDDEN_X;
    hero[whichhero].ypixel = HIDDEN_Y;
    if (display)
    {   updatescreen();
}   }
EXPORT void remove_jarl(SLONG whichjarl, FLAG display)
{   unslot_jarl(whichjarl);
    jarl[whichjarl].xpixel = HIDDEN_X;
    jarl[whichjarl].ypixel = HIDDEN_Y;
    if (display)
    {   updatescreen();
}   }
EXPORT void remove_monster(SLONG whichmonster, FLAG display)
{   unslot_monster(whichmonster);
    monster[whichmonster].xpixel = HIDDEN_X;
    monster[whichmonster].ypixel = HIDDEN_Y;
    if (display)
    {   updatescreen();
}   }
EXPORT void remove_treasure(SLONG whichtreasure, FLAG display)
{   unslot_treasure(whichtreasure);
    treasure[whichtreasure].xpixel = HIDDEN_X;
    treasure[whichtreasure].ypixel = HIDDEN_Y;
    if (display)
    {   updatescreen();
}   }
EXPORT void remove_sord(SLONG whichsord, FLAG display)
{   unslot_sord(whichsord);
    sord[whichsord].xpixel = HIDDEN_X;
    sord[whichsord].ypixel = HIDDEN_Y;
    if (display)
    {   updatescreen();
}   }

EXPORT void reset_images(void)
{   SLONG whichhero;

    for (whichhero = 0; whichhero <= HEROES; whichhero++)
    {   hero[whichhero].image = (UWORD*) CounterData[FIRSTIMAGE_HERO + whichhero];
}   }

EXPORT void info(SLONG counter)
{   SLONG infobobs = 0,
          which;

    for (which = 0; which <= TREASURES; which++)
    {   if
        (   treasure[which].possessortype == countertype
         && treasure[which].possessor     == counter
        )
        {   Counter.ImageData  = (UWORD*) CounterData[FIRSTIMAGE_TREASURE + which];
            shadowcounter(568 + ((which / 4) * (24 + 4)), 7 + ((infobobs % 4) * (24 + 4)));
            infobobs++;
    }   }

    infobobs = 0;
    for (which = 0; which <= SORDS; which++)
    {   if
        (   sord[which].possessortype == countertype
         && sord[which].possessor     == counter
        )
        {   Counter.ImageData = (UWORD*) CounterData[FIRSTIMAGE_SORD + which];
            shadowcounter(540, 7);
            infobobs = 1;
            break;
    }   }
    if (countertype == HERO)
    {   for (which = 0; which <= JARLS; which++)
        {   if
            (   jarl[which].alive
             && jarl[which].hero == counter
            )
            {   Counter.ImageData = (UWORD*) CounterData[FIRSTIMAGE_JARL + which];
                shadowcounter(540, 7 + (infobobs * (24 + 4)));
                infobobs++;
}   }   }   }

MODULE void shadowcounter(SWORD x, SWORD y)
{   DrawImage(InfoWindowPtr->RPort, &Counter, x, y);

    SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
    Move(InfoWindowPtr->RPort, x + 24, y +  1);
    Draw(InfoWindowPtr->RPort, x + 24, y + 24);
    Draw(InfoWindowPtr->RPort, x +  1, y + 24);
}

EXPORT void doc(SLONG number)
{   SLONG which;

    SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
    if (number == 3) // swords
    {   for (which = 0; which <= SORDS; which++)
        {   Counter.ImageData = (UWORD*) CounterData[FIRSTIMAGE_SORD + which];
            shadowcounter(12, sord[which].y);
        }
    } elif (number == 4) // treasures
    {   for (which = 0; which <= treasures; which++)
        {   Counter.ImageData = (UWORD*) CounterData[FIRSTIMAGE_TREASURE + which];
            shadowcounter(12, treasure[which].y);
}   }   }

EXPORT void print_monster(SLONG x, SLONG y, SLONG which)
{   SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
    Counter.ImageData  = (UWORD*) CounterData[FIRSTIMAGE_MONSTER + which];
    DrawImage(InfoWindowPtr->RPort, &Counter, x, y);
}
EXPORT void print_jarl(SLONG x, SLONG y, SLONG which)
{   SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
    Counter.ImageData  = (UWORD*) CounterData[FIRSTIMAGE_JARL + JARLS + 1];
    DrawImage(InfoWindowPtr->RPort, &Counter, x, y);
}
EXPORT void print_treasure(SLONG x, SLONG y, SLONG which)
{   SetAPen(InfoWindowPtr->RPort, remapit[BLACK]);
    Counter.ImageData  = (UWORD*) CounterData[FIRSTIMAGE_TREASURE + TREASURES + 1];
    DrawImage(InfoWindowPtr->RPort, &Counter, x, y);
}

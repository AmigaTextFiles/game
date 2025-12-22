// 1. INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#endif

#include <exec/types.h>
#include <exec/alerts.h>
#include <intuition/intuition.h>
#include <graphics/gfx.h>
#include <graphics/displayinfo.h>
#include <graphics/view.h>

#include <proto/graphics.h>
#include <proto/intuition.h>

#include <stdlib.h>
// #define ASSERT
#include <assert.h>

#include "shared.h"
#include "africa.h"
#include "counters.h"

/* 2. DEFINES ------------------------------------------------------------

(none)

3. EXPORTED VARIABLES ----------------------------------------------------

(none)

4. IMPORTED VARIABLES ------------------------------------------------- */

#ifndef __amigaos4__
    IMPORT struct GfxBase*   GfxBase;
#endif
IMPORT FLAG                  morphos;
IMPORT UBYTE                 remapit[64];
IMPORT UWORD                 DisplayDepth;
IMPORT SLONG                 hexowner[MAPROWS][MAPCOLUMNS];
IMPORT ULONG                 DisplayWidth,
                             DisplayHeight;
IMPORT UWORD                *AfroData[6][RAFRICANS],
                            *EuroData[2][EUROPEANS];
IMPORT struct AfroStruct     a[RAFRICANS];
IMPORT struct BoxStruct      box[6];
IMPORT struct EuroStruct     e[EUROPEANS];
IMPORT struct SetupStruct    setup[RAFRICANS];
IMPORT struct Image          Counter,
                             MapImage;
IMPORT struct RastPort       OffScreenRastPort;
IMPORT struct Screen*        ScreenPtr;
IMPORT struct Window*        MainWindowPtr;

/* 5. MODULE VARIABLES ---------------------------------------------------

(none)

6. MODULE STRUCTURES -----------------------------------------------------

(none)

7. MODULE FUNCTIONS ------------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void init_counters(void)
{   SLONG we,
          wa,
          war;

    for (wa = 0; wa < RAFRICANS; wa++)
    {   for (war = 0; war < setup[wa].maxarmies; war++)
        {   a[wa].army[war].xpixel = HIDDEN_X;
            a[wa].army[war].ypixel = HIDDEN_Y;
    }   }
    for (we = 0; we < EUROPEANS; we++)
    {   e[we].iuxpixel             = HIDDEN_X;
        e[we].iuypixel             = HIDDEN_Y;
}   }

EXPORT void move_army(SLONG wa, SLONG war, FLAG display)
{   if (a[wa].army[war].y % 2)
    {   a[wa].army[war].xpixel = (WORD) 640 -  4 - MapImage.Width  + 20 + (a[wa].army[war].x * 30);
    } else
    {   a[wa].army[war].xpixel = (WORD) 640 -  4 - MapImage.Width  +  5 + (a[wa].army[war].x * 30);
    }
    a[wa].army[war].ypixel     = (WORD) 512 - 20 - MapImage.Height +  8 + (a[wa].army[war].y * 26);

    a[wa].army[war].oldx = a[wa].army[war].x;
    a[wa].army[war].oldy = a[wa].army[war].y;

    if (display)
    {   updatescreen();
}   }
EXPORT void move_iu(SLONG we, FLAG display)
{   if (e[we].iuy % 2)
    {   e[we].iuxpixel         = (WORD) 640 -  4 - MapImage.Width  + 20 + (e[we].iux * 30);
    } else
    {   e[we].iuxpixel         = (WORD) 640 -  4 - MapImage.Width  +  5 + (e[we].iux * 30);
    }
    e[we].iuypixel             = (WORD) 512 - 20 - MapImage.Height +  8 + (e[we].iuy * 26);

    e[we].iuoldx = e[we].iux;
    e[we].iuoldy = e[we].iuy;

    if (display)
    {   updatescreen();
}   }

EXPORT void remove_army(SLONG wa, SLONG war, FLAG display)
{   a[wa].army[war].xpixel = HIDDEN_X;
    a[wa].army[war].ypixel = HIDDEN_Y;
    a[wa].army[war].state  = STATE_NORMAL;

    if (display)
    {   updatescreen();
}   }
EXPORT void remove_iu(SLONG we, FLAG display)
{   e[we].iuxpixel         = HIDDEN_X;
    e[we].iuypixel         = HIDDEN_Y;
    e[we].iustate          = STATE_NORMAL;

    if (display)
    {   updatescreen();
}   }

EXPORT void makeleader(SLONG wa, SLONG war, FLAG display)
{   a[wa].army[war].state = STATE_LEADER;

    if (display)
    {   updatescreen();
}   }

EXPORT void makejunta(SLONG wa, SLONG war, FLAG display)
{   a[wa].army[war].state = STATE_JUNTA;

    if (display)
    {   updatescreen();
}   }

EXPORT void select_army(SLONG wa, SLONG war, FLAG display)
{   if
    (   a[wa].govt == LEADER
     && govtx(wa) == a[wa].army[war].x
     && govty(wa) == a[wa].army[war].y
    )
    {   a[wa].army[war].state = STATE_SELLEADER;
    } elif
    (   a[wa].govt == JUNTA
     && govtx(wa) == a[wa].army[war].x
     && govty(wa) == a[wa].army[war].y
    )
    {   a[wa].army[war].state = STATE_SELJUNTA;
    } else
    {   a[wa].army[war].state = STATE_SELECTED;
    }

    if (display)
    {   updatescreen();
}   }
EXPORT void deselect_army(SLONG wa, SLONG war, FLAG display)
{   int wb;

    if
    (   a[wa].govt == LEADER
     && govtx(wa) == a[wa].army[war].x
     && govty(wa) == a[wa].army[war].y
    )
    {   a[wa].army[war].state = STATE_LEADER;
    } elif
    (   a[wa].govt == JUNTA
     && govtx(wa) == a[wa].army[war].x
     && govty(wa) == a[wa].army[war].y
    )
    {   a[wa].army[war].state = STATE_JUNTA;
    } else
    {   a[wa].army[war].state = STATE_NORMAL;
    }

    for (wb = 0; wb < 6; wb++)
    {   box[wb].x = box[wb].y = -1;
    }

    if (display)
    {   updatescreen();
}   }
EXPORT void select_iu(SLONG we, FLAG display)
{   e[we].iustate = STATE_SELECTED;

    if (display)
    {   updatescreen();
}   }
EXPORT void deselect_iu(SLONG we, FLAG display)
{   int wb;

    e[we].iustate = STATE_NORMAL;

    for (wb = 0; wb < 6; wb++)
    {   box[wb].x = box[wb].y = -1;
    }

    if (display)
    {   updatescreen();
}   }

EXPORT void killgovt(SLONG wa, SLONG war, FLAG display)
{   a[wa].army[war].state = STATE_NORMAL;

    if (display)
    {   updatescreen();
}   }

EXPORT void shadowcounter_afro(struct Window* WindowPtr, int x, int y, int wa, int war)
{   Counter.ImageData = (UWORD*) AfroData[a[wa].army[war].state][wa];
    DrawImage(WindowPtr->RPort, &Counter, x, y);

    SetAPen(WindowPtr->RPort, remapit[BLACK]);
    Move(WindowPtr->RPort, x + 21, y +  1);
    Draw(WindowPtr->RPort, x + 21, y + 21);
    Draw(WindowPtr->RPort, x +  1, y + 21);
}
EXPORT void shadowcounter_euro(struct Window* WindowPtr, int x, int y, int we)
{   Counter.ImageData = (UWORD*) EuroData[e[we].iustate][we];
    DrawImage(WindowPtr->RPort, &Counter, x, y);

    SetAPen(WindowPtr->RPort, remapit[BLACK]);
    Move(WindowPtr->RPort, x + 21, y +  1);
    Draw(WindowPtr->RPort, x + 21, y + 21);
    Draw(WindowPtr->RPort, x +  1, y + 21);
}

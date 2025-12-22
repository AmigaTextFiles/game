// 1.  INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#endif

#ifdef AMIGA
    #include <exec/types.h>
    #include <exec/memory.h>
    #include <exec/alerts.h>
    #include <intuition/intuition.h> // for struct Window, etc.
    #include <libraries/gadtools.h>  // for GT_VisualInfo, etc.

    #include <proto/exec.h>
    #include <proto/graphics.h>
    #include <proto/intuition.h>
    #include <proto/gadtools.h>
    #include <proto/locale.h>

    #include <stdlib.h>              // size_t

    #include "shared.h"
    #include "amiga.h"
#endif
#ifdef WIN32
    #include "ibm.h"
    #define EXEC_TYPES_H
#endif

#include "ww.h"

#define CATCOMP_NUMBERS
#define CATCOMP_BLOCK
#include "ww_strings.h"

#include <stdlib.h> // for EXIT_SUCCESS, etc.

// 2. DEFINES ------------------------------------------------------------

// #define SOUNDTEST
// enable this to play sound effects by using alphanumeric keys

#define ALTJUMP 5

// 3. EXPORTED VARIABLES -------------------------------------------------

EXPORT FLAG                clipboarded = FALSE,
                           sticky      = FALSE;
EXPORT int                 fex         = MINFIELDX / 2,
                           fey         = MINFIELDY / 2,
                           pseudotop[PSEUDOGADGETS];
EXPORT UWORD               brush       = STONE;

// 4. IMPORTED VARIABLES -------------------------------------------------

IMPORT int                 fontx,
                           xoffset,
                           yoffset;
IMPORT struct LocaleInfo   li;
IMPORT struct Window*      MainWindowPtr;
IMPORT struct Menu*        MenuPtr;
IMPORT struct VisualInfo*  VisualInfoPtr;
IMPORT struct timerequest* TimerRqPtr;
IMPORT struct InputEvent   GameEvent;
IMPORT struct Screen*      ScreenPtr;
IMPORT FLAG                alt,
                           anims,
                           ctrl,
                           createicons,
                           levels_modified,
                           morphos,
                           pointer,
                           scores_modified,
                           shift,
                           titlebar;
IMPORT SBYTE               a,
                           startx[MAXLEVELS + 1],
                           starty[MAXLEVELS + 1],
                           level, levels;
IMPORT SWORD               fieldx, fieldy;
IMPORT UWORD               board[MAXLEVELS + 1][MINFIELDX + 1][MINFIELDY + 1],
                           PointerData[6];
IMPORT ULONG               WindowWidth,
                           WindowHeight;
#ifdef AMIGA
    IMPORT struct Catalog* CatalogPtr;
#endif
#ifdef WIN32
    IMPORT int             CatalogPtr;
    IMPORT HCURSOR         hPointer,
                           pointers[10];
#endif

// 5. MODULE VARIABLES ---------------------------------------------------

MODULE UBYTE               clipboard[MINFIELDX + 1][MINFIELDY + 1];

/* 6. MODULE STRUCTURES --------------------------------------------------

(none)

7. MODULE FUNCTIONS --------------------------------------------------- */

MODULE void copyfield(int source, int destination);
MODULE int fexwrap(int x);
MODULE int feywrap(int y);
MODULE int hittest(int mousex, int mousey);
MODULE void movedot(int deltax, int deltay);

// 8. CODE ---------------------------------------------------------------

EXPORT void fieldedit(void)
{   if (level > levels)
    {   level = levels;
    }
    if (!valid(fex, fey))
    {   fex = startx[level];
        fey = starty[level];
    }

    updatemenu();
    clearscreen();
#ifdef AMIGA
    le_dosidebar();
    le_drawfield();
#endif
#ifdef WIN32
    switch (brush)
    {
    case  EMPTY:     hPointer = pointers[0];
    acase SILVER:    hPointer = pointers[1];
    acase GOLD:      hPointer = pointers[2];
    acase DYNAMITE:  hPointer = pointers[3];
    acase WOOD:      hPointer = pointers[4];
    acase STONE:     hPointer = pointers[5];
    acase METAL:     hPointer = pointers[6];
    acase FROST:     hPointer = pointers[7];
    acase ARROWUP:   hPointer = pointers[8];
    acase ARROWDOWN: hPointer = pointers[9];
    }
    SetCursor(hPointer);
#endif
    clearkybd();
    playsong(SONG_EDITOR);

    le_loop();

#ifdef WIN32
    releasepointer();
#endif
    if (levels_modified)
    {   clearhiscores();
        scores_modified = TRUE;
}   }

EXPORT void stamp(UWORD square)
{   if (square != START && fex == startx[level] && fey == starty[level])
    {   dot();
        return;
    }

    if (square == START)
    {   le_draw(startx[level], starty[level], EMPTY);
        board[level][startx[level]][starty[level]] = EMPTY;
        startx[level] = fex;
        starty[level] = fey;
        board[level][fex][fey] = EMPTY;
        le_draw(fex, fey, START);
    } else
    {   board[level][fex][fey] = square;
        le_draw(fex, fey, square);
    }

    dot();
    levels_modified = TRUE;
}

EXPORT void undot(void)
{   if (startx[level] == fex && starty[level] == fey)
    {   le_draw(fex, fey, START);
    } else
    {   le_draw(fex, fey, board[level][fex][fey]);
}   }

EXPORT void fillfield(UBYTE which)
{   int x, y;

    for (x = 0; x <= MINFIELDX; x++)
    {   for (y = 0; y <= MINFIELDY; y++)
        {   board[level][x][y] = which;
    }   }
    board[level][startx[level]][starty[level]] = EMPTY;
    le_drawfield();
}

EXPORT void setbrush(UWORD newbrush)
{   int   which = 0;
    SBYTE where = EMPTYGADGET;

    switch (brush)
    {
    case  EMPTY:     which = 0; where =    EMPTYGADGET;
    acase SILVER:    which = 1; where =   SILVERGADGET;
    acase GOLD:      which = 2; where =     GOLDGADGET;
    acase DYNAMITE:  which = 3; where = DYNAMITEGADGET;
    acase WOOD:      which = 4; where =     WOODGADGET;
    acase STONE:     which = 5; where =    STONEGADGET;
    acase METAL:     which = 6; where =    METALGADGET;
    acase FROST:     which = 7; where =    FROSTGADGET;
    acase ARROWUP:   which = 8; where =       UPGADGET;
    acase ARROWDOWN: which = 9; where =     DOWNGADGET;
    }
    rectfill_grey
    (   PSEUDOLEFT + 1,
        pseudotop[which] + 1,
        PSEUDOLEFT + SQUAREX + 7,
        pseudotop[which] + SQUAREY + 7
    );
    draw(GADGETX, where, brush);

    brush = newbrush;

    switch (brush)
    {
    case  EMPTY:     which = 0; where =    EMPTYGADGET;
    acase SILVER:    which = 1; where =   SILVERGADGET;
    acase GOLD:      which = 2; where =     GOLDGADGET;
    acase DYNAMITE:  which = 3; where = DYNAMITEGADGET;
    acase WOOD:      which = 4; where =     WOODGADGET;
    acase STONE:     which = 5; where =    STONEGADGET;
    acase METAL:     which = 6; where =    METALGADGET;
    acase FROST:     which = 7; where =    FROSTGADGET;
    acase ARROWUP:   which = 8; where =       UPGADGET;
    acase ARROWDOWN: which = 9; where =     DOWNGADGET;
    }
    if (sticky)
    {   rectfill_red
        (   PSEUDOLEFT + 1,
            pseudotop[which] + 1,
            PSEUDOLEFT + SQUAREX + 7,
            pseudotop[which] + SQUAREY + 7
        );
    } else
    {   rectfill_white
        (   PSEUDOLEFT + 1,
            pseudotop[which] + 1,
            PSEUDOLEFT + SQUAREX + 7,
            pseudotop[which] + SQUAREY + 7
        );
    }

    draw(GADGETX, where, brush);

#ifdef WIN32
    hPointer = pointers[which];
    SetCursor(hPointer);
#endif
}

EXPORT int xpixeltosquare(int x)
{   if (x >= STARTXPIXEL)
    {   return ((x - STARTXPIXEL) / SQUAREX) - WW_LEFTGAP;
    } else
    {   return -1;
}   }
EXPORT int ypixeltosquare(int y)
{   if (y >= STARTYPIXEL)
    {   return ((y - STARTYPIXEL) / SQUAREY) - WW_TOPGAP;
    } else
    {   return -1;
}   }

EXPORT void le_append(void)
{   SBYTE oldlevel;

    if (levels >= MAXLEVELS)
    {   return;
    }

    oldlevel = level;
    levels++;
    level = levels;
    newfield();
    level = oldlevel;
    saylevel(WHITE);
    updatemenu();
}
EXPORT void le_delete(void)
{   SBYTE i;

    if (levels <= 1)
    {   return;
    }

    if (level < levels)
    {   for (i = level; i < levels; i++)
        {   copyfield(i + 1, i);
    }   }
    else
    {   level--;
    }
    levels--;
    le_drawfield();
    updatemenu();
}
EXPORT void le_erase(void)
{   newfield();
    le_drawfield();
    // no need for updatemenu()
}
EXPORT void le_insert(void)
{   int i;

    if (levels >= MAXLEVELS)
    {   return;
    }

    for (i = levels; i >= level; i--)
    {   copyfield((UBYTE) i, (UBYTE) i + 1);
    }
    levels++;
    newfield();
    le_drawfield();
    updatemenu();
}

MODULE void copyfield(int source, int destination)
{   int x, y;

    for (x = 0; x <= MINFIELDX; x++)
    {   for (y = 0; y <= MINFIELDY; y++)
        {   board[destination][x][y] = board[source][x][y];
    }   }
    startx[destination] = startx[source];
    starty[destination] = starty[source];
}
MODULE int fexwrap(int x)
{   if (x < 0)
    {   x += MINFIELDX + 1;
    } elif (x > MINFIELDX)
    {   x -= MINFIELDX + 1;
    }
    return x;
}
MODULE int feywrap(int y)
{   if (y < 0)
    {   y += MINFIELDY + 1;
    } elif (y > MINFIELDY)
    {   y -= MINFIELDY + 1;
    }
    return y;
}

EXPORT void le_dosidebar(void)
{   int i,
        which = 0;

    switch (brush)
    {
    case  EMPTY:     which = 0;
    acase SILVER:    which = 1;
    acase GOLD:      which = 2;
    acase DYNAMITE:  which = 3;
    acase WOOD:      which = 4;
    acase STONE:     which = 5;
    acase METAL:     which = 6;
    acase FROST:     which = 7;
    acase ARROWUP:   which = 8;
    acase ARROWDOWN: which = 9;
    }

    for (i = 0; i < PSEUDOGADGETS; i++)
    {   ami_drawbox
        (   PSEUDOLEFT,
            pseudotop[i],
            SQUAREX + 9,
            SQUAREY + 9
        );

        if (i == which)
        {   if (sticky)
            {   rectfill_red
                (   PSEUDOLEFT + 1,
                    pseudotop[i] + 1,
                    PSEUDOLEFT + SQUAREX + 7,
                    pseudotop[i] + SQUAREY + 7
                );
            } else
            {   rectfill_white
                (   PSEUDOLEFT + 1,
                    pseudotop[i] + 1,
                    PSEUDOLEFT + SQUAREX + 7,
                    pseudotop[i] + SQUAREY + 7
                );
        }   }
        else
        {   rectfill_grey
            (   PSEUDOLEFT + 1,
                pseudotop[i] + 1,
                PSEUDOLEFT + SQUAREX + 7,
                pseudotop[i] + SQUAREY + 7
            );
    }   }

    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 60, STARTYPIXEL + 9 + (   EMPTYGADGET * SQUAREY), WHITE,  "F1:");
    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 60, STARTYPIXEL + 9 + (  SILVERGADGET * SQUAREY), WHITE,  "F2:");
    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 60, STARTYPIXEL + 9 + (    GOLDGADGET * SQUAREY), WHITE,  "F3:");
    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 60, STARTYPIXEL + 9 + (DYNAMITEGADGET * SQUAREY), WHITE,  "F4:");
    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 60, STARTYPIXEL + 9 + (    WOODGADGET * SQUAREY), WHITE,  "F5:");
    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 60, STARTYPIXEL + 9 + (   STONEGADGET * SQUAREY), WHITE,  "F6:");
    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 60, STARTYPIXEL + 9 + (   METALGADGET * SQUAREY), WHITE,  "F7:");
    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 60, STARTYPIXEL + 9 + (   FROSTGADGET * SQUAREY), WHITE,  "F8:");
    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 60, STARTYPIXEL + 9 + (      UPGADGET * SQUAREY), WHITE,  "F9:");
#if defined(WIN32) || defined(__amigaos4__)
    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 60, STARTYPIXEL + 9 + (    DOWNGADGET * SQUAREY), WHITE, "F10:");
#else
    writetext(STARTXPIXEL + (SQUAREX * WW_LEFTGAP) - 68, STARTYPIXEL + 9 + (    DOWNGADGET * SQUAREY), WHITE, "F10:");
#endif

    draw(GADGETX, (SBYTE)    EMPTYGADGET,     EMPTY);
    draw(GADGETX, (SBYTE)   SILVERGADGET,    SILVER);
    draw(GADGETX, (SBYTE)     GOLDGADGET,      GOLD);
    draw(GADGETX, (SBYTE) DYNAMITEGADGET,  DYNAMITE);
    draw(GADGETX, (SBYTE)     WOODGADGET,      WOOD);
    draw(GADGETX, (SBYTE)    STONEGADGET,     STONE);
    draw(GADGETX, (SBYTE)    METALGADGET,     METAL);
    draw(GADGETX, (SBYTE)    FROSTGADGET,     FROST);
    draw(GADGETX, (SBYTE)       UPGADGET,   ARROWUP);
    draw(GADGETX, (SBYTE)     DOWNGADGET, ARROWDOWN);
}

EXPORT void le_drawfield(void)
{   int x, y;

    saylevel(WHITE); // do this first so they can read it while the field is drawn

    for (x = 0; x <= MINFIELDX; x++)
    {   for (y = 0; y <= MINFIELDY; y++)
        {   le_draw(x, y, board[level][x][y]);
    }   }

    ami_draw
    (   STARTXPIXEL + (  WW_LEFTGAP * SQUAREX)    ,
        ENDYPIXEL   - (WW_BOTTOMGAP * SQUAREY) + 1,
        ENDXPIXEL   - ( WW_RIGHTGAP * SQUAREX)    ,
        ENDYPIXEL   - (WW_BOTTOMGAP * SQUAREY) + 1,
        MEDIUMGREY
    );
    ami_draw
    (   ENDXPIXEL   - ( WW_RIGHTGAP * SQUAREX) + 1,
        STARTYPIXEL + (   WW_TOPGAP * SQUAREY)    ,
        ENDXPIXEL   - ( WW_RIGHTGAP * SQUAREX) + 1,
        ENDYPIXEL   - (WW_BOTTOMGAP * SQUAREY) + 1,
        MEDIUMGREY
    );
    ami_draw
    (   STARTXPIXEL + (  WW_LEFTGAP * SQUAREX) + 1,
        ENDYPIXEL   - (WW_BOTTOMGAP * SQUAREY) + 2,
        ENDXPIXEL   - ( WW_RIGHTGAP * SQUAREX) + 1,
        ENDYPIXEL   - (WW_BOTTOMGAP * SQUAREY) + 2,
        BLACK
    );
    ami_draw
    (   ENDXPIXEL   - ( WW_RIGHTGAP * SQUAREX) + 2,
        STARTYPIXEL + (   WW_TOPGAP * SQUAREY) + 1,
        ENDXPIXEL   - ( WW_RIGHTGAP * SQUAREX) + 2,
        ENDYPIXEL   - (WW_BOTTOMGAP * SQUAREY) + 2,
        BLACK
    );

    le_draw(startx[level], starty[level], START);
    dot();
}

EXPORT void le_handlekybd(SCANCODE scancode)
{
#ifdef SOUNDTEST
    switch (scancode)
    {
    case SCAN_A:  effect( 0); return;
    case SCAN_B:  effect( 1); return;
    case SCAN_C:  effect( 2); return;
    case SCAN_D:  effect( 3); return;
    case SCAN_E:  effect( 4); return;
    case SCAN_F:  effect( 5); return;
    case SCAN_G:  effect( 6); return;
    case SCAN_H:  effect( 7); return;
    case SCAN_I:  effect( 8); return;
    case SCAN_J:  effect( 9); return;
    case SCAN_K:  effect(10); return;
    case SCAN_L:  effect(11); return;
    case SCAN_M:  effect(12); return;
    case SCAN_N:  effect(13); return;
    case SCAN_O:  effect(14); return;
    case SCAN_P:  effect(15); return;
    case SCAN_Q:  effect(16); return;
    case SCAN_R:  effect(17); return;
    case SCAN_S:  effect(18); return;
    case SCAN_T:  effect(19); return;
    case SCAN_U:  effect(20); return;
    case SCAN_V:  effect(21); return;
    case SCAN_W:  effect(22); return;
    case SCAN_X:  effect(23); return;
    case SCAN_Y:  effect(24); return;
    case SCAN_Z:  effect(25); return;
    case SCAN_A1: effect(26); return;
    case SCAN_A2: effect(27); return;
    case SCAN_A3: effect(28); return;
    case SCAN_A4: effect(29); return;
    case SCAN_A5: effect(30); return;
    case SCAN_A6: effect(31); return;
    case SCAN_A7: effect(32); return;
    case SCAN_A8: effect(33); return;
    case SCAN_A9: effect(34); return;
    case SCAN_A0: effect(35); return;
    case SCAN_SLASH: effect(36); return;
    }
#endif

    switch (scancode)
    {
    case SCAN_ESCAPE:
        if (shift)
        {   if (verify())
            {   cleanexit(EXIT_SUCCESS);
        }   }
        else
        {   a = GAMEOVER;
        }
    acase SCAN_F1:
        if (shift)
        {   fillfield(EMPTY);
        } else setbrush(EMPTY);
    acase SCAN_F2:
        if (shift)
        {   fillfield(SILVER);
        } else setbrush(SILVER);
    acase SCAN_F3:
        if (shift)
        {   fillfield(GOLD);
        } else setbrush(GOLD);
    acase SCAN_F4:
        if (shift)
        {   fillfield(DYNAMITE);
        } else setbrush(DYNAMITE);
    acase SCAN_F5:
        if (shift)
        {   fillfield(WOOD);
        } else setbrush(WOOD);
    acase SCAN_F6:
        if (shift)
        {   fillfield(STONE);
        } else setbrush(STONE);
    acase SCAN_F7:
        if (shift)
        {   fillfield(METAL);
        } else setbrush(METAL);
    acase SCAN_F8:
        if (shift)
        {   fillfield(FROST);
        } else setbrush(FROST);
    acase SCAN_F9:
        if (shift)
        {   fillfield(ARROWUP);
        } else setbrush(ARROWUP);
    acase SCAN_F10:
        if (shift)
        {   fillfield(ARROWDOWN);
        } else setbrush(ARROWDOWN);
    acase SCAN_F:
    case SCAN_M:
        toggle((SBYTE) scancode);
    acase SCAN_SPACEBAR:
    case SCAN_RETURN:
    case SCAN_ENTER:
        a = GAMEOVER;
    acase SCAN_N0:
        if (!sticky)
        {   sticky = TRUE;
            say((STRPTR) GetCatalogStr(CatalogPtr, MSG_STICKYON,  "Sticky mode on" ), RED);
            stamp(brush);
            setbrush(brush);
        } else
        {   sticky = FALSE;
            say((STRPTR) GetCatalogStr(CatalogPtr, MSG_STICKYOFF, "Sticky mode off"), WHITE);
            dot();
            setbrush(brush);
        }
    acase SCAN_NUMERICDOT:
        stamp(brush);
    acase SCAN_N4:
    case SCAN_LEFT:
        movedot(-1, 0);
    acase SCAN_N6:
    case SCAN_RIGHT:
        movedot(1, 0);
    acase SCAN_N8:
    case SCAN_UP:
        movedot(0, -1);
    acase SCAN_N5:
    case SCAN_DOWN:
        movedot(0, 1);
    acase SCAN_N2:
        movedot(0, 1);
    acase SCAN_N7:
        movedot(-1, -1);
    acase SCAN_N9:
        movedot(1, -1);
    acase SCAN_N1:
        movedot(-1, 1);
    acase SCAN_N3:
        movedot(1, 1);
#ifdef AMIGA
    acase SCAN_DEL:
#endif
#ifdef WIN32
    acase SCAN_PGUP:
#endif
        if (shift)
        {   level = 1;
        } elif (level == 0)
        {   level = levels;
        } else level--;
        le_drawfield();
#ifdef AMIGA
    acase SCAN_HELP:
#endif
#ifdef WIN32
    acase SCAN_PGDN:
#endif
        if (shift)
        {   level = levels;
        } elif (level == levels)
        {   level = 0;
        } else level++;
        le_drawfield();
    acase SCAN_C:
        undot();
        fex = MINFIELDX / 2;
        fey = MINFIELDY / 2;
        dot();
    acase SCAN_E:
        le_erase();
    acase SCAN_I:
        stamp(SLIME);
    acase SCAN_S:
        stamp(START);
    acase SCAN_X:
        undot();
        fex = MINFIELDX - fex;
        dot();
    acase SCAN_Y:
        undot();
        fey = MINFIELDY - fey;
        dot();
    acase SCAN_A1:
        stamp(EMPTY);
    acase SCAN_A2:
        stamp(SILVER);
    acase SCAN_A3:
        stamp(GOLD);
    acase SCAN_A4:
        stamp(DYNAMITE);
    acase SCAN_A5:
        stamp(WOOD);
    acase SCAN_A6:
        stamp(STONE);
    acase SCAN_A7:
        stamp(METAL);
    acase SCAN_A8:
        stamp(FROST);
    acase SCAN_A9:
        stamp(ARROWUP);
    acase SCAN_A0:
        stamp(ARROWDOWN);
}   }

MODULE void movedot(int deltax, int deltay)
{   undot();
    if (shift || ctrl)
    {   if (deltax < 0) fex = 0; elif (deltax > 0) fex = MINFIELDX;
        if (deltay < 0) fey = 0; elif (deltay > 0) fey = MINFIELDY;
    } elif (alt)
    {   fex = fexwrap(fex + (deltax * ALTJUMP));
        fey = feywrap(fey + (deltay * ALTJUMP));
    } else
    {   fex = fexwrap(fex + deltax);
        fey = feywrap(fey + deltay);
    }
    if (sticky)
    {   stamp(brush);
    } else
    {   dot();
}   }

EXPORT void le_cut(void)
{   int x, y;

    clipboarded = levels_modified = TRUE; // must be done before updatemenu()
    for (x = 0; x <= MINFIELDX; x++)
    {   for (y = 0; y <= MINFIELDY; y++)
        {   clipboard[x][y] = board[level][x][y];
    }   }
    le_delete(); // this calls updatemenu()
}
EXPORT void le_copy(void)
{   int x, y;

    for (x = 0; x <= MINFIELDX; x++)
    {   for (y = 0; y <= MINFIELDY; y++)
        {   clipboard[x][y] = board[level][x][y];
    }   }
    clipboarded = TRUE;
    updatemenu();
}
EXPORT void le_paste(void)
{   int x, y;

    if (!clipboarded)
    {   return;
    }

    for (x = 0; x <= MINFIELDX; x++)
    {   for (y = 0; y <= MINFIELDY; y++)
        {   board[level][x][y] = clipboard[x][y];
    }   }
    le_drawfield();
    levels_modified = TRUE;
    // no need for updatemenu()
}

EXPORT void le_leftdown(int mousex, int mousey)
{   int pointerx, pointery;

    switch (hittest(mousex, mousey))
    {
    case 0:
        setbrush(EMPTY);
    acase 1:
        setbrush(SILVER);
    acase 2:
        setbrush(GOLD);
    acase 3:
        setbrush(DYNAMITE);
    acase 4:
        setbrush(WOOD);
    acase 5:
        setbrush(STONE);
    acase 6:
        setbrush(METAL);
    acase 7:
        setbrush(FROST);
    acase 8:
        setbrush(ARROWUP);
    acase 9:
        setbrush(ARROWDOWN);
    acase -1:
        pointerx = xpixeltosquare(mousex);
        pointery = ypixeltosquare(mousey);
        if (valid(pointerx, pointery))
        {   undot();
            fex = pointerx;
            fey = pointery;
            stamp(brush);
}   }   }

EXPORT void le_rightdown(int mousex, int mousey)
{   int pointerx, pointery;

    pointerx = xpixeltosquare(mousex);
    pointery = ypixeltosquare(mousey);
    if (valid(pointerx, pointery))
    {   undot();
        fex = pointerx;
        fey = pointery;
        stamp(EMPTY);
}   }

MODULE int hittest(int mousex, int mousey)
{   int which;

    if
    (   mousex < PSEUDOLEFT
     || mousex > PSEUDOLEFT + SQUAREX + 8
    )
    {   return -1;
    }

    for (which = 0; which < PSEUDOGADGETS; which++)
    {   if
        (   mousey >= pseudotop[which]
         && mousey <= pseudotop[which] + SQUAREY + 8
        )
        {   return which;
    }   }

    return -1;
}

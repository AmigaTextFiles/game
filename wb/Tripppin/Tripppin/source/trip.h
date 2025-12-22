/* a few global definitions for the game Trippin. */


#include <Paul.h>

	    /* a bit of libraries/dos.h: */
#ifndef SIGBREAKB_CTRL_C
#define SIGBREAKB_CTRL_C 12L
#define SIGBREAKB_CTRL_D 13L
#define SIGBREAKB_CTRL_E 14L
#define SIGBREAKB_CTRL_F 15L
#endif


#define HISTORY 40

typedef struct {
    short top, count;
    ubyte hx[HISTORY + 1], hy[HISTORY + 1], madegoal[HISTORY + 1];
} history;		/* the +1 is just for safety pad */


typedef struct _pIeCe {
    short x, y, goalx, goaly;
    bool machine;
    ubyte reached, allowed;
    struct Bob *face;
    struct _pIeCe *other;
    history *hist;
} piece;


#define sigdie   SIGBREAKB_CTRL_C
#define sigtof   SIGBREAKB_CTRL_E
#define sigthink SIGBREAKB_CTRL_F

#asm
sigf_tof	equ	$00004000
#endasm


#define SQIZE 22

#define IMHITE 13
#define IMWID  22

#define BLUE   0L
#define WHITE  1L
#define BLACK  2L
#define ORANGE 3L
/* ... if workbench colors have default pre-2.0 settings */


#define MARGINWID 160

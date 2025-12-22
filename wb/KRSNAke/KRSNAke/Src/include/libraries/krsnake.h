#ifndef LIBRARIES_KRSNAKE_H
#define LIBRARIES_KRSNAKE_H

/*
** KRSNAke.h
**
** - includes for KRSNAke.library 1.11
**
*/

#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif

/* event codes */

#define SNAKE_QUIT          23
#define SNAKE_NEWSCORE      24
#define SNAKE_GAMEOVER      25
#define SNAKE_NEWGAME       26
#define SNAKE_PAUSED        27
#define SNAKE_RESTARTED     28
#define SNAKE_EATEN         29
#define SNAKE_MOVES         30
#define SNAKE_NEWCHUNK      31
#define SNAKE_HIDEINTERFACE 32
#define SNAKE_SHOWINTERFACE 33
#define SNAKE_NEWPREFS      34

/* fill type description */

struct FillDesc {
    WORD Type;
    LONG DriPen, Red, Green, Blue;
    UBYTE File[256];
    UBYTE Graphic[256];
};

#define FILLTYPE_RGB        0   /* rgb value */
#define FILLTYPE_DATATYPE   1   /* bitmap, loaded with datatypes */
#define FILLTYPE_GRAPHIC    2   /* several bitmaps */
#define FILLTYPE_DRIPEN     3   /* dripen */

#define FILL_BACK   0   /* the playing field */
#define FILL_LINK   1   /* each link of the snake */
#define FILL_HEAD   2   /* the snake's head */
#define FILL_FRUIT  3
#define FILL_FRUIT1 3   /* fruit type 1 */
#define FILL_FRUIT2 4   /* fruit type 2 */
#define FILL_FRUIT3 5   /* fruit type 3 */
#define FILL_FRUIT4 6   /* fruit type 4 */

/* preferences */

struct KPrefs {
    LONG Priority;
    ULONG Flags;
    UBYTE PubScreen[64];
    ULONG StartGameSound[256];
    ULONG EatFruitSound[256];
    ULONG CrashSound[256];
    struct FillDesc Fill[7];
    UBYTE PopKey[128];
};

#define KPF_LETHAL180   1   /* 180° turns fatal (if not set, 180° turns not possible) */
#define KPB_LETHAL180   0
#define KPF_APPICON     2   /* create appicon when hidden */
#define KPB_APPICON     1
#define KPF_APPMENU     4   /* create appmenuitem when hidden */
#define KPB_APPMENU     2
#define KPF_FREESOUNDS  8   /* free sound buffers when hidden */
#define KPB_FREESOUNDS  3
#define KPF_CONTSOUND  16   /* play start game sound all the time */
#define KPB_CONTSOUND   4

#endif


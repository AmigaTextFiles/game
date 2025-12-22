/*
 * CClock.h V1.1
 *
 * header file
 *
 * (c) 1992-1993 Holger Brunst
 */

/* System includes */
#include <exec/types.h>
#include <exec/memory.h>
#include <intuition/screens.h>
#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>
#include <graphics/view.h>
#include <libraries/dos.h>
#include <libraries/gadtools.h>

/* System function prototypes */
#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/dos_protos.h>
#include <clib/diskfont_protos.h>
#include <clib/alib_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/timer_protos.h>

/* ANSI C prototypes */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Global defines */
#define GAME_NAME   "Crazy Clock"
#define VERSION     "1"
#define REVISION    "1"
#define DATE        "12.10.93"
#define CYEARS      "1992-1993"

#define PIC_NAME    "CCElements"

#define HIGH_NAME   "CCHighscore"
#define HIGH_STRLEN 32

/* Structures */
struct GadgetData {
                   char           *name;
                   ULONG           type;
                   ULONG           flags;
                   struct TagItem *tags;
                   UWORD           left;
                   UWORD           top;
                   UWORD           width;
                   UWORD           height;
                   struct Gadget  *gadget;
                  };

/* Function types */
typedef BOOL    OpenWinFunc(void);
typedef void   *HandleIDCMPFunc(struct IntuiMessage *);
typedef void    UpdateWinFunc(void *);

/* Clock window function prototypes */
ULONG           OpenClockWindow(void);
void            CloseClockWindow(void);
HandleIDCMPFunc HandleClockWindowIDCMP;
UpdateWinFunc   UpdateClockWindow;

/* Name window function prototypes */
OpenWinFunc     OpenNameWindow;
HandleIDCMPFunc HandleNameWindowIDCMP;

/* Highscore window functions prototypes */
OpenWinFunc     OpenHighWindow;
HandleIDCMPFunc HandleHighWindowIDCMP;
void            LoadHighScore(void);
void            SaveHighScore(void);
void            InsertHighScore(char *, ULONG);
BOOL            AskHighScore(ULONG);

/* Misceallaneous function prototypes */
void    DisableWindow(struct Window *);
void    EnableWindow(struct Window *, ULONG);
void    CloseWindowSafely(struct Window *);
struct Gadget *CreateGadgetList(struct GadgetData *, ULONG, ULONG);
struct BitMap *OpenILBM(UBYTE *);
void    CloseILBM(struct BitMap *);
void    Zoom(struct Screen *, USHORT *, short);

/* Global data */
extern struct MsgPort   *IDCMPPort;
extern struct Screen 	*Screen;
extern APTR				*ScreenVI;
extern struct TextAttr  GrntAttr;
extern UpdateWinFunc    *UpdateWindow;

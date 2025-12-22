/*******************************************************/
/*                                                     */
/* GWIN INCLUDE FILE                                   */
/*                                                     */
/*******************************************************/
#define _USEOLDEXEC_
#include <exec/types.h>
#include <proto/exec.h>
#include <graphics/gfxbase.h>
#include <graphics/display.h>
#include <graphics/regions.h>
#include <graphics/gfx.h>
#include <graphics/gfxmacros.h>
#include <intuition/intuitionbase.h>
#include <intuition/intuition.h>
#include <exec/memory.h>
#include <hardware/custom.h>
#include <hardware/dmabits.h>
#include <libraries/dos.h>
#include <libraries/diskfont.h>
#include <devices/audio.h>
#include <math.h>

#define SCR_MAX 1
#define WIN_MAX 1
#define MAXVECTORS 1000
/* 640 x 400 / 8  (page 230 Mortimore) */
#define RASTERSIZE 32000

#define USTART(a,b,c,d,e)  { if(!OpenGWINBase()) {                     \
                                printf("Can't open GWIN.library.\n");  \
                                printf("Exiting.\n");                  \
                                exit(1);                               \
                             }                                         \
                             G = ustart( (a),(b),(c),(d),(e) );        \
                             GfxBase = G->GfxBase;                     \
                             IntuitionBase = G->IntuitionBase;         \
                             DiskfontBase = G->DiskfontBase;           \
                             rport1 = G->rport1;                       \
                             win[0] = G->win[0];                       \
                             scr[0] = G->scr[0];                       }

#define UEND()             { uend(G);                                  \
                             CloseGWINBase();                          }
/*

extern short Enable_Abort;

*/

/*******************************************************/
/*                                                     */
/* GLOBAL VARIABLES                                    */
/*                                                     */
/*******************************************************/

struct G_user_subset {
   struct RastPort *rport1;
   struct Window *win[WIN_MAX];
   struct Screen *scr[SCR_MAX];

   struct GfxBase *GfxBase;
   struct IntuitionBase *IntuitionBase;
   struct DiskfontBase *DiskfontBase;
} *G;

struct RastPort *rport1;
struct Window *win[WIN_MAX];
struct Screen *scr[SCR_MAX];

struct GfxBase *GfxBase;
struct IntuitionBase *IntuitionBase;
struct DiskfontBase *DiskfontBase;


/*******************************************************/
/*                                                     */
/* STRUCTURE DEFINITIONS                               */
/*                                                     */
/*******************************************************/

struct G_user_subset *ustart(char *c, float x1, float x2,
                                      float y1, float y2);

struct GWINBase *GWINBase = 0L;

BOOL OpenGWINBase(void)
{
        GWINBase=(struct GWINBase *)OpenLibrary("GWIN.library",1L);
        if(GWINBase) {
         return(TRUE);
         }
        else {
         return(FALSE);
         }
}

void CloseGWINBase(void)
{
        if(GWINBase) CloseLibrary((struct Library *)GWINBase);
        GWINBase=0L;
}

struct uuevent {
   ULONG event;
   char key;
} uuev;

/*******************************************************/
/*                                                     */
/* FUNCTION PROTOTYPES                                 */
/*                                                     */
/*******************************************************/

extern struct G_user_subset *ustart(char *c, float x1, float x2,
                                                float y1, float y2);
extern int udarea(struct G_user_subset *G, float x1, float x2,
                                           float y1, float y2);
extern int uwindo(struct G_user_subset *G, float xmin, float xmax,
                                           float ymin, float ymax);
extern int uoutln(struct G_user_subset *G);
extern int uerase(struct G_user_subset *G);
extern int uflush(struct G_user_subset *G);
extern int uwhere(struct G_user_subset *G, float *x, float *y);
extern int uadjust(struct G_user_subset *G, float x, float y,
                                            float *xa, float *ya);
extern int urotate(struct G_user_subset *G, float x, float y, float theta);
extern int ugrin(struct G_user_subset *G, float *x, float *y);
extern int ugrinc(struct G_user_subset *G, float *x, float *y,
                                           struct uuevent *uuev);
extern int ugrinl(struct G_user_subset *G, float *x, float *y,
                                           struct uuevent *uuev);
extern int ugrina(struct G_user_subset *G, float *x, float *y,
                                           struct uuevent *uuev);
extern int uigrina(struct G_user_subset *G, int *ix, int *iy,
                                           struct uuevent *uuev);
extern int uyorn(struct G_user_subset *G, char *bodytext,
                 char *positivetext, char *negativetext, float width,
                 float height);
extern int uimove(struct G_user_subset *G, int ix, int iy);
extern int uidraw(struct G_user_subset *G, int ix, int iy);
extern int umove(struct G_user_subset *G, float x, float y);
extern int udraw(struct G_user_subset *G, float x, float y);
extern int urect(struct G_user_subset *G, float x1, float y1,
                                          float x2, float y2);
extern int uplygn(struct G_user_subset *G, float x, float y,
                                           float n, float r);
extern int ucrcle(struct G_user_subset *G, float x, float y, float r);
extern int uamenu(struct G_user_subset *G, int gwinmenu0,
                  int gwinmenu1, int gwinmenu2, char* text,
                  char comchr, int mutex, USHORT flags, int (*routine)() );

extern int upset(struct G_user_subset *G, char *text, float value);
extern int uset(struct G_user_subset *G, char *text);
extern int usetrgb(struct G_user_subset *G, float colorindex,
                   float redvalue, float greenvalue, float bluevalue);
extern int ugetrgb(struct G_user_subset *G, float colorindex,
                   float *redvalue, float *greenvalue, float *bluevalue);
extern int ugetstring(struct G_user_subset *G, float x1, float y1,
                      float width, char *text, char *prompt);
extern int ufont(struct G_user_subset *G, char *name, float size);
extern int uprint(struct G_user_subset *G, float x, float y, char *line);
extern int uprnt1(struct G_user_subset *G, char *option, char *line);

extern int uprscr(struct G_user_subset *G);
extern int usetcleanup(struct G_user_subset *G, int (*cleanup_routine)() );
extern int uend(struct G_user_subset *G);


/*******************************************************/
/*                                                     */
/* PRAGMAS                                             */
/*                                                     */
/*******************************************************/

/*------ normal functions ---------------------------------------------*/
#pragma libcall GWINBase ustart 1E 3210805
#pragma libcall GWINBase udarea 24 3210805
#pragma libcall GWINBase uwindo 2A 3210805
#pragma libcall GWINBase uoutln 30 801
#pragma libcall GWINBase uerase 36 801
#pragma libcall GWINBase uflush 3C 801
#pragma libcall GWINBase uwhere 42 A9803
#pragma libcall GWINBase uadjust 48 A910805
#pragma libcall GWINBase urotate 4E 210804
#pragma libcall GWINBase ugrin 54 A9803
#pragma libcall GWINBase ugrinc 5A BA9804
#pragma libcall GWINBase ugrinl 60 BA9804
#pragma libcall GWINBase ugrina 66 BA9804
#pragma libcall GWINBase uigrina 6C BA9804
#pragma libcall GWINBase uyorn 72 10BA9806
#pragma libcall GWINBase uimove 78 10803
#pragma libcall GWINBase uidraw 7E 10803
#pragma libcall GWINBase umove 84 10803
#pragma libcall GWINBase udraw 8A 10803
#pragma libcall GWINBase urect 90 3210805
#pragma libcall GWINBase uplygn 96 3210805
#pragma libcall GWINBase ucrcle 9C 210804
#pragma libcall GWINBase uamenu A2 A5439210809
#pragma libcall GWINBase upset A8 09803
#pragma libcall GWINBase uset AE 9802
#pragma libcall GWINBase usetrgb B4 3210805
#pragma libcall GWINBase ugetrgb BA BA90805
#pragma libcall GWINBase ugetstring C0 A9210806
#pragma libcall GWINBase ufont C6 9803
#pragma libcall GWINBase uprint CC 910804
#pragma libcall GWINBase uprnt1 D2 A9803
#pragma libcall GWINBase uprscr D8 801
#pragma libcall GWINBase usetcleanup DE 9802
#pragma libcall GWINBase uend E4 801
#pragma libcall GWINBase uzvtodconv EA BA910807
#pragma libcall GWINBase uzdtovconv F0 A910805


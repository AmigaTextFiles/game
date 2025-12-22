/*
 * snake.c - a simple Amiga game
 *
 * Bruno Costa - 30 apr 89
 *
 */

#include <exec/types.h>
#include <intuition/intuition.h>
#include <functions.h>

int retcode = 0;
struct Library *IntuitionBase = NULL;
struct Library *GfxBase = NULL;
struct Window *wd = NULL;
struct RastPort *rp = NULL;

#define XSIZE 140
#define YSIZE 88
#define XPIX 3
#define YPIX 2
#define NPOINTS 50
#define MAXLEN 120
#define GROWTHSPEED 7
#define DOTCOL 2
#define SNKCOL 1
#define AIMCOL 3
#define BKGCOL 0

struct NewWindow wdattr = {
 0, 11, XPIX*XSIZE + 8, YPIX*YSIZE + 13,
 2, 1, CLOSEWINDOW,
 WINDOWDEPTH | WINDOWDRAG | WINDOWCLOSE | GIMMEZEROZERO |
 SMART_REFRESH | ACTIVATE | NOCAREREFRESH,
 NULL, NULL, NULL, NULL, NULL,
 0, 0, 0, 0,
 WBENCHSCREEN
};

struct {int x, y;} sn[MAXLEN];
int snhead, sntail, sndir, snlen;
int sndx[4] = {-1, 0, 1, 0 };
int sndy[4] = { 0,-1, 0, 1 };
int score;

#define random(max) (rand()%max)

Abort(code)
int code;
{
 if (wd)
   CloseWindow(wd);
 if (IntuitionBase)
   CloseLibrary(IntuitionBase);
 if (GfxBase)
   CloseLibrary(GfxBase);
 exit (code);
}

setdisplay()
{
 GfxBase = OpenLibrary("graphics.library",0L);
 IntuitionBase = OpenLibrary("intuition.library",0L);
 wd = OpenWindow(&wdattr);
 if (!wd)
   Abort(30);
 rp = wd->RPort;
}

plot (x,y,c)
int x,y,c;
{
 register int i, yc;
 int xi, xf;

 xi = x * XPIX;
 xf = xi + XPIX - 1;
 yc = y * YPIX;
 SetAPen (rp, (long)c);
 for (i = 0; i < YPIX; yc++, i++)
 {
   Move (rp, (long)xi, (long)yc);
   Draw (rp, (long)xf, (long)yc);
 }
}

int rdpix(x,y)
int x,y;
{
 return (ReadPixel(rp, (long)(x * XPIX), (long)(y * YPIX)));
}

int plotaim()
{
 int x, y;
 do
 {
   x = random(XSIZE);
   y = random(YSIZE);
 } while (rdpix(x, y) != BKGCOL);
 plot(x, y, AIMCOL);
}

dispscore()
{
 char str[20];
 sprintf(str, " Score: %d ", score);
 SetWindowTitles(wd, str, "Snake  v 1.0  - \xa9 1989 Bruno Costa");
}

initscreen()
{
 int i;

 SetRast(rp,(long)BKGCOL);

 for (i = 0; i < XSIZE; i++)
 {
   plot (i, 0, DOTCOL);
   plot (i, YSIZE-1, DOTCOL);
 }
 for (i = 0; i < YSIZE; i++)
 {
   plot (0, i, DOTCOL);
   plot (XSIZE-1, i, DOTCOL);
 }

 for (i = 0; i < NPOINTS; i++)
   plot (random(XSIZE),random(YSIZE),DOTCOL);
}

initsnake()
{
 snhead = sntail = sndir = 0;
 snlen = 1;
 sn[0].x = XSIZE/2;
 sn[0].y = YSIZE/2;
 plot (sn[0].x, sn[0].y, SNKCOL);
}

/* joystick reading routines */
#define JPORT 2
#define JOYADDR (short *)(0xdff008 + 2 * JPORT)
#define CIAADDR (char *)(0xbfe001)

int fire()
{
 return (!(*CIAADDR & (64 * JPORT)));
}

int joydx()
{
 int t = *JOYADDR;

 if (t & 2)
   return 1;
 if (t & 512)
   return -1;
 return 0;
}

int joydy()
{
 int t = *JOYADDR >> 1 ^ *JOYADDR;

 if (t & 1)
   return 1;
 if (t & 256)
   return -1;
 return 0;
}

int testbreak()
{
 struct Message *msg;

 if (msg = GetMsg(wd->UserPort))
 {
   ReplyMsg(msg);
   return (1);
 }
 else
   return (0);
}

waitbutton()
{
 while(!fire())
 {
   Delay(10L);
   if (testbreak())
     Abort(1);
 }
}

play()
{
 int cx, cy;
 int time = 0;

 score = 0;
 dispscore();
 initsnake();
 plotaim();

 cx = sn[snhead].x;
 cy = sn[snhead].y;

 for (;;)
 {
   if (joydx() || joydy())	/* true if joystick moved */
   {
     int dx = joydx();
     int dy = joydy();
     if (!(dx && dy))		/* diagonals are discarded */
       if (dx != -sndx[sndir] || dy != -sndy[sndir])
         if (dx == 1)		sndir = 2;
         else if (dx == -1)	sndir = 0;
         else if (dy == 1)	sndir = 3;
         else			sndir = 1;
   }
   cx += sndx[sndir];
   cy += sndy[sndir];
   if (rdpix(cx,cy))		/* true if collision happened */
   {
     if (rdpix(cx,cy) == AIMCOL)
     {
       score++;
       dispscore();
       plotaim();
     }
     else
       return;
   }
   plot (cx, cy, SNKCOL);
   snhead = (snhead + 1) % MAXLEN;
   if (snlen < MAXLEN && !(time % GROWTHSPEED))
     snlen++;
   else
   {
     plot (sn[sntail].x, sn[sntail].y, BKGCOL);
     sntail = (sntail + 1) % MAXLEN;
   }
   sn[snhead].x = cx;
   sn[snhead].y = cy;
   if (testbreak())
     Abort(1);
   Delay(1L);
   time++;
 }
}

main()
{
 setdisplay();
 for (;;)
 {
   initscreen();
   play();
   dispscore();
   waitbutton();
 }
}

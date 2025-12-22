
/* is your mouse pointer feeling lonely ? try this little program to
   help him out... */


#include <functions.h>
#include <exec/memory.h>
#include <graphics/gfxbase.h>
#include <graphics/sprite.h>

#define AllocChip(size) AllocMem((ULONG)size,(ULONG)(MEMF_CHIP|MEMF_CLEAR))
#define DataBytes       (height*2+4)*2
#define prec 8

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;

/* my control window... */

struct NewWindow newwin = 
{ 0, 30, 160, 10, -1, -1,
  CLOSEWINDOW,
  WINDOWCLOSE | WINDOWDRAG | WINDOWDEPTH | 
  SMART_REFRESH,
  NULL, NULL, (UBYTE *)" Friends!  ", NULL, NULL,
  0, 0, 0, 0,
  WBENCHSCREEN };
struct IntuiMessage *msg;
struct Window *win;


struct Screen *wb;            /* workbench screen */
struct ViewPort *vp;          /* screen's viewport */
USHORT *clrs;                 /* viewport's colour table */
struct SimpleSprite ss[8];    /* only use 1 to 7 */
struct SimpleSprite *ptr;     /* a copy of pointer sprite */
short height;                 /* pointer height */
short which[8]                /* which sprites i'm using */
  = { 0,0,0,0,0,0,0,0 };
long px[8],py[8];             /* fixed point sprite positions */
long rate = 100;                    /* scale factor for moving */
long rnd = 100;               /* randomness factor */

long fixmult(a,b)       /* fixed point multiply */
  long a,b;
{ return( a>>(prec/2) * b>>(prec/2) ); }
long tofix(a)        /* convert short a to fixed point */
  short a;
{ return( ((long)a) << (prec/2) ); }
short toint(a)       /* convert fixed point a to short */
  long a;
{ return( (short)(a>>(prec/2)) ); }


void init()    /* set up sprite system */
{
  short i,j,any;
  
  IntuitionBase = (void *)OpenLibrary("intuition.library",0L);
  GfxBase = (void *)OpenLibrary("graphics.library",0L);
  wb = IntuitionBase->ActiveWindow->WScreen;
  vp = &wb->ViewPort;
  clrs = (USHORT *)(vp->ColorMap->ColorTable);   /* base of colour table */
  ptr = *GfxBase->SimpleSprites;                 /* get pointer to ptr */
  height = ptr->height;                         /* pointer height */

  any = FALSE;
  for (i=1; i<8; i++) {     /* set up sprites */
    if (any |= which[i] = ~GetSprite(&ss[i],(long)i)) {
      ss[i].height = height;
      if (!(ss[i].posctldata = AllocChip(DataBytes))) exit(0);  /* data */
      movmem(ptr->posctldata,ss[i].posctldata,DataBytes);
      ss[i].posctldata[1] = ss[i].posctldata[0] = 0;
      ss[i].posctldata[DataBytes/2-2] = ss[i].posctldata[DataBytes/2-1]
      = 0xffff;
      px[i] = tofix(ss[i].x = (short)RangeRand(640L));    /* set position */
      py[i] = tofix(ss[i].y = (short)RangeRand(200L));
    }
  }
  if (!any) exit(0);       /* stingy bloody user! */

  for (i=1; i<=3; i++)
    movmem(&clrs[16],&clrs[16+i*4],4*2);   /* set all sprite colours same */
  LoadRGB4(vp,clrs,32L);

  if (!(win=OpenWindow(&newwin))) exit(0);     /* open window */
}


void move()        /* move all ptr's friends */
{
  static long vx[8] = { 0,0,0,0,0,0,0,0 };
  static long vy[8] = { 0,0,0,0,0,0,0,0 };
  long ax,ay;           /* x and y acceleration (fixed point) */
  long mx,my;           /* mouse x and y (fixed point) */
  short i;

  mx = tofix(wb->MouseX); my = tofix(wb->MouseY);
  for (i=1; i<8; i++) {
    if (which[i]) {
      ax = (mx-px[i]) - 2*vx[i] + tofix((short)(RangeRand(3*rnd)-3*rnd/2));
      ay = (my-py[i]) - 2*vy[i] + tofix((short)(RangeRand(rnd)-rnd/2));
      vx[i] += ax/rate;
      vy[i] += ay/rate;
      px[i] += vx[i]; py[i] += vy[i];                /* position */
      if (toint(px[i])<0)   { px[i]=-px[i]; vx[i]=-vx[i]; }
      if (toint(px[i])>639) { px[i]=tofix(639*2)-px[i]; vx[i]=-vx[i]; }
      if (toint(py[i])<0)   { py[i]=-py[i]; vy[i]=-vy[i]; }
      if (toint(py[i])>199) { py[i]=tofix(199*2)-py[i]; vy[i]=-vy[i]; }
      MoveSprite(vp,&ss[i],
                 (long)toint(px[i]),
                 (long)toint(py[i]));
    }
  }
}    


main(argc,argv)
  int argc; char *argv[];
{
  short i;

  if (argv[1]) {
    rate = atol(argv[1]);
    if (argv[2]) rnd  = atol(argv[2]);
  }
  init();
  while (!(msg=(void *)GetMsg(win->UserPort))) {
   WaitTOF();
   move();
  }
  ReplyMsg(msg);

  for (i=1; i<8; i++) {
    if (which[i]) {
      FreeSprite((long)i);
      if (ss[i].posctldata)
        FreeMem(ss[i].posctldata,(long)DataBytes);
    }
  }
  CloseWindow(win);
  CloseLibrary(GfxBase);
  CloseLibrary(IntuitionBase);
}
  
  

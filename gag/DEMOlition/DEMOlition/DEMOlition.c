/*	:ts=8

	DEMOlition - A display hack inspired by a demo seen on a BBC micro,
		     a long time ago.
	This program uses Stephen Coy's "Melt" demo as a template, to make
	a copy of the Workbench screen and handle the close gadget. Only
	the action code is different. Stephen placed no restriction on the
	usage of his code, so it is only fair that I should not place any
	restrictions in mine. Use, abuse, modify or mutilate it as you
	see fit.
			Kriton Kyrimis (princeton!kyrimis)
*/
	
#include <exec/types.h>
#include <intuition/intuition.h>

#define DEPTH	(SHORT) 2

#define NE 0
#define SE 1
#define SW 2
#define NW 3

#define rndcol(c)	SetRGB4 (vp, (long)(c), (long)(RangeRand(16)-1), \
						(long)(RangeRand(16)-1), \
						(long)(RangeRand(16)-1))

extern void	*OpenLibrary(), *OpenWindow(), *OpenScreen(), *GetMsg();
extern long RangeRand(), ReadPixel();

struct NewScreen scrdef = {
	(SHORT)0, (SHORT)0, (SHORT)0, (SHORT)0, DEPTH,
	(UBYTE)0, (UBYTE)1,
	(USHORT) 0,
	CUSTOMSCREEN,
	NULL,
	(UBYTE *) "FooBar",
	NULL,
	NULL
};

struct NewWindow windef = {
	(SHORT) 0, (SHORT) 30,
	(SHORT) 180, (SHORT) 10,
	(UBYTE) -1, (UBYTE) -1,
	CLOSEWINDOW,
	WINDOWCLOSE | WINDOWDRAG | WINDOWDEPTH |  SMART_REFRESH | ACTIVATE,
	NULL,
	NULL,
	(UBYTE *) "DEMOlition",
	NULL,
	NULL,
	(SHORT) 0, (SHORT) 0,
	(SHORT) 0, (SHORT) 0,
	WBENCHSCREEN
};

struct Screen	*scr;
struct Window	*win;
struct TmpRas	tmpras;
struct RastPort	*rp;
struct ViewPort *vp;
void		*IntuitionBase, *GfxBase;
int		x, y,
		dx, dy,
		newx, newy,
		maxx, maxy;

main()
{
	struct Screen	*wb;
	struct BitMap	*wbm, *mbm;
	long		x, y, n;
	register int	i;

	openstuff();

	wb = win->WScreen;
	scrdef.LeftEdge  = wb->LeftEdge;
	scrdef.TopEdge   = wb->TopEdge;
	scrdef.Width     = wb->Width;
	scrdef.Height    = wb->Height;
	scrdef.ViewModes = wb->ViewPort.Modes;
	if(!(scr = OpenScreen(&scrdef)))
	  die("Screen open failed!");
	ScreenToBack(scr);

	rp = &scr->RastPort;
	vp = &scr->ViewPort;
	mbm = rp->BitMap;
	wbm = win->WScreen->RastPort.BitMap;
	BltBitMap(wbm, 0L, 0L, mbm, 0L, 0L,
		  (long)scrdef.Width, (long)scrdef.Height,
		  0xc0L, 0xffL, NULL);
	ScreenToFront(scr);
	demo();
	closestuff();
}

demo()
{
	int	class;
	struct	IntuiMessage	*message;
	int	dir;
	int	c;

	maxx = scr->Width - 2;
	maxy = scr->Height - 2;
	x = newx = RangeRand((long)(maxx));
	y = newy = RangeRand((long)(maxy));
	dir = RangeRand(3L);
	dx = 1;
	dy = 1;
	SetAPen(rp, 3L);
	show();

	FOREVER {
	  message = (struct IntuiMessage *)GetMsg(win->UserPort);
	  if(message != (struct IntuiMessage *)NULL) {
	    class = message->Class;
	    ReplyMsg(message);
	    if(class == CLOSEWINDOW) {
	      return;
	    }
	  }

	  hide();
	  switch (dir) {
	    case NE:
	      newx = x + dx;
	      newy = y - dy;
	      if (newx > maxx){
		dir = NW;
		rndcol(0);
	      }
	      else
		if (newy < 0){
		  dir = SE;
		  rndcol(0);
		}
		else
		  if( (c = ReadPixel(rp, (long)newx, (long)newy)) != 0L) {
		    explode(c);
		    rndcol(c);
		    dir = NW;
		  }
	      break;
	    case SE:
	      newx = x + dx;
	      newy = y + dy;
	      if (newx > maxx){
	        dir = SW;
		rndcol(0);
	      }
	      else
	        if (newy > maxy){
		  dir = NE;
		  rndcol(0);
		}
		else
		  if( (c = ReadPixel(rp, (long)newx, (long)newy)) != 0L) {
		    explode(c);
		    rndcol(c);
		    dir = NE;
		  }
	      break;
	    case SW:
	      newx = x - dx;
	      newy = y + dy;
	      if (newx < 0){
	        dir = SE;
		rndcol(0);
	      }
	      else
	        if (newy > maxy){
		  dir = NW;
		  rndcol(0);
		}
		else
		  if( (c = ReadPixel(rp, (long)newx, (long)newy)) != 0L) {
		    explode(c);
		    rndcol(c);
		    dir = SE;
		  }
	      break;
	    case NW:
	      newx = x - dx;
	      newy = y - dy;
	      if (newx < 0){
	        dir = NE;
		rndcol(0);
	      }
	      else
	        if (newy < 0){
		  dir = SW;
		  rndcol(0);
		}
		else
		  if( (c = ReadPixel(rp, (long)newx, (long)newy)) != 0L) {
		    explode(c);
		    rndcol(c);
		    dir = SW;
		  }
	      break;
	  }
	  show();
	}
}

show()
{
  static int do_delay = 0;
  x = newx;
  y = newy;

  SetAPen(rp, 3L);
  SetDrMd(rp, JAM1);
  WritePixel(rp, (long)x    , (long)y);

  SetDrMd(rp, COMPLEMENT);
  WritePixel(rp, (long)(x+1), (long)y);
  WritePixel(rp, (long)x    , (long)(y+1));
  WritePixel(rp, (long)(x+1), (long)(y+1));

  if (do_delay) {
    Delay(1L);
    do_delay = 0;
  }else{
    do_delay = 1;
  }
}

hide()
{
  SetAPen(rp, 0L);
  SetDrMd(rp, JAM1);
  WritePixel(rp, (long)x    , (long)y);

  SetDrMd(rp, COMPLEMENT);
  WritePixel(rp, (long)(x+1), (long)y);
  WritePixel(rp, (long)x    , (long)(y+1));
  WritePixel(rp, (long)(x+1), (long)(y+1)); 
}

#define DELIM 0xff

explode(c)
  int c;
{
  static int ex[] = {-3,  0,  1,  4,		DELIM,
		     -2,  0,  1,  3,		DELIM,
		     -1,  0,  1,  2,		DELIM,
		     -3, -2, -1,  0,  1,	DELIM,
		      0,  1,  2,  3,  4,	DELIM,
		     -1,  0,  1,  2,		DELIM,
		     -2,  0,  1,  3,		DELIM,
		     -3,  0,  1,  4,		DELIM};
  int ey;
  int i;
  int xx, yy;

  SetAPen(rp, 0L);
  SetDrMd(rp, JAM1);

  ey = -3;
  i = 0;
  while (ey < 5) {
    if( ex[i] == DELIM) {
      i++;
      ey++;
      continue;
    }
    xx = newx + ex[i];
    yy = newy + ey;
    if( (xx >= 0) && (yy >= 0) && (xx <= maxx) && (yy <= maxy) )
      WritePixel(rp, (long)(xx), (long)yy);
    i++;
  }
  SetRGB4 (vp, (long)c, (long)(RangeRand(16)-1),
			(long)(RangeRand(16)-1),
			(long)(RangeRand(16)-1));
}

openstuff()
{
	if(!(IntuitionBase = OpenLibrary("intuition.library", 0L))) {
	  puts("Intuition missing.");
	  exit(100);
	}

	if(!(GfxBase = OpenLibrary("graphics.library", 0L))) {
	  puts("Art shop clode.");
	  exit(100);
	}

	if(!(win = OpenWindow(&windef))) {
	  puts("Window painted shut.");
	  closestuff();
	  exit(100);
	}
}

die(str)
char	*str;
{
	puts(str);
	closestuff();
	exit(100);
}

closestuff()
{
	if(tmpras.RasPtr) FreeRaster(tmpras.RasPtr, 320L, 200L);
	if(scr)           CloseScreen(scr);
	if(win)           CloseWindow(win);
	if(GfxBase)       CloseLibrary(GfxBase);
	if(IntuitionBase) CloseLibrary(IntuitionBase);
}

/*
*	A Simple program to display colorful blocks on a custom screen.
*	Compiles with no errors under Lattice 3.10, However, it passes ints to
*	some subroutines and does structure assignments, so manx users will
*	probably have to do a little work.
*			Linesdemo original by	Paul Jatkowski
*	Block rendering, PAL tests, windowsize checking by Gary Walker		
*/
#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxbase.h>
#include <graphics/gfx.h>
#include <graphics/gfxmacros.h>
#include <graphics/view.h>
extern struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;

struct Point {
	int x;
	int y;
};

#define Q 5
#define N (Q*12)	/* N is the number of blocks displayed on the screen */
			/* change the value of Q to change the number of    */
			/* blocks so that it is evenly divisible by the      */
			/* number of color registers used		    */

int	curcolor;
Point	from[N], to[N];
Point	dfrom, dto;
long	i,j;
int	minx,maxx,miny,maxy;


struct TextAttr MyFont = {
   "topaz.font",           /* Font Name */
   TOPAZ_SIXTY,            /* Font Height */
   FS_NORMAL,              /* Style */
   FPF_ROMFONT             /* Preferences */
};


struct NewScreen NewScreen = {
   0,             /* left edge */
   0,             /* top edge */
   640,           /* Width (high res) */
   512,           /* Height (interlace + PAL overscan) */
   4,             /* Depth */
   0,1,           /* Detail and Block Pen Specification */
   HIRES|LACE,	  /* Hires Interlaced screen */
   CUSTOMSCREEN,  /* The Screen Type */
   &MyFont,       /* our font */
   "My Own Screen", /* title */
   NULL,          /* no special gadgets */
   NULL           /* no special custom BitMap */
};


struct   Window   *Window;
struct   Screen   *Screen;
struct   RastPort  *RP;

main()
{

	struct   NewWindow NewWindow;
	struct   ViewPort  *VP;
	int	notdone = 1;
	struct	IntuiMessage *msg , *GetMsg();
	int	my_rgbi,my_rgb[3];
	int	inc,colorok;
	int	lc = -1;
	int 	Ht;

	/* open intuition library */
	IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library",0);
	if (IntuitionBase == NULL)
		exit(FALSE);
	GfxBase = (struct GfxBase *)OpenLibrary("graphics.library",0);
	if (GfxBase == NULL)
		exit (FALSE);
	  if ((*GfxBase).DisplayFlags & PAL)
		Ht = 512 ;
		
	  else  Ht = 400 ;
		

	if ((Screen = (struct Screen *)OpenScreen(&NewScreen)) == NULL)
		exit(FALSE);
	
	/* set up new window structure */
	NewWindow.LeftEdge = 0;
	NewWindow.TopEdge = 0;
	NewWindow.Width = 640;
	NewWindow.Height = Ht;
	NewWindow.DetailPen = 0;
	NewWindow.BlockPen = 1;
	NewWindow.Title = "A Simple Window";
	NewWindow.Flags = WINDOWCLOSE | SMART_REFRESH |
				WINDOWDRAG | WINDOWSIZING;
	NewWindow.IDCMPFlags = CLOSEWINDOW | NEWSIZE ;
	NewWindow.Type = CUSTOMSCREEN;
	NewWindow.FirstGadget = NULL;
	NewWindow.CheckMark = NULL;
	NewWindow.Screen = Screen;
	NewWindow.BitMap = NULL;
	NewWindow.MinWidth = 160;
	NewWindow.MinHeight = 100;
	NewWindow.MaxWidth = 640;
	NewWindow.MaxHeight = Ht;

	/* try to open the window */
	if ((Window = (struct Window *)OpenWindow(&NewWindow)) == NULL)
		exit(FALSE);
   
	RP = Window->RPort;
	VP = (struct ViewPort *) ViewPortAddress(Window);
   

	SetAPen(RP,14);
	SetBPen(RP,0);
	SetWindowTitles(Window,"Blocks V2.0 - by Gary Walker","");
	SetDrMd(RP,JAM1);
	SetAPen(RP,15);

	init();
	SetRGB4(VP,0,0,0,0);     
	SetRGB4(VP,1,1,6,12);     
	SetRGB4(VP,2,5,0,8);  
	SetRGB4(VP,3,0,8,5);     

	my_rgb[0] = rand() % 16;
	my_rgb[1] = rand() % 16;
	my_rgb[2] = rand() % 16;
	SetRGB4(VP,curcolor,my_rgb[0],my_rgb[1],my_rgb[2]);
	SetDrMd(RP,JAM1);			
	while(notdone)
	{
		j = i;
		if (++i >= N)
			i = 0;

		SetAPen(RP,0);			/* erase old block */
		RectFill(RP, from[i].x, from[i].y, from[i].x + 20, from[i].y + 20);
		from[i] = from[j];		/* structure assignment */
		mv_point(&from[i], &dfrom);
		to[i] = to[j];			/* structure assignment */
		mv_point(&to[i], &dto);

		SetAPen(RP,curcolor);		/* draw a new block */
		RectFill(RP, from[i].x, from[i].y, from[i].x + 20, from[i].y + 20);
				
		if ( (i % Q) == 0)
		{
			if (++curcolor > 15)
				curcolor = 4;
			colorok = 0;
			while (!colorok)
			{
				inc = 1;
				if (rand() & 8 )
					inc = -1;
				my_rgbi = rand() % 3;
				inc += my_rgb[my_rgbi];
				/* make sure that the color register
				   doesn't wrap and we don't change the same
				   color twice in a row
				*/
				if (inc <= 15 && inc >= 0 && lc != my_rgbi)
				{
					my_rgb[my_rgbi] = inc;
					colorok++;
					lc = my_rgbi;
				}
			}
			SetRGB4(VP,curcolor,my_rgb[0],my_rgb[1],my_rgb[2]);
		}
		if ( (rand() % 20) == 1)
		{
			if (rand() & 2)
			{
				newdelta(&to[i],&dto);
			}
			else
			{
				newdelta(&from[i],&dfrom);
			}
		}

		while ((msg = GetMsg(Window->UserPort)) != 0)
		{
			switch(msg->Class)
			{

			case CLOSEWINDOW:	/* that's all folks */
				notdone = 0;
				ReplyMsg(msg);
				continue;
			case NEWSIZE:
				ReplyMsg(msg);			
				init();
				break;			
			default:
				ReplyMsg(msg);
			}
		}
	}
	

	/* close the window and  exit */
	CloseWindow(Window);
	CloseScreen(Screen);
	exit(TRUE);
}


init()
{
	ULONG	seconds,micros;
	
	miny = Window->BorderTop;
	maxy = (Window->Height - Window->BorderBottom) - 20;
	minx = Window->BorderLeft;
	maxx = (Window->Width - Window->BorderRight) - 5;

	for (j=0 ; j <N ; j++)
	{
		from[j].x = 20; from[j].y = 20;
		to[j].x = 0; to[j].y = 0;
	}
	/* attempt to ramdomize the random number generator */
	CurrentTime(&seconds,&micros);
	srand(micros);
	
	from[0].x = range_rand(minx,maxx);
	from[0].y = range_rand(miny,maxy);
	from[1] = from[0];
	
	to[0].x = range_rand(minx,maxx);
	to[0].y = range_rand(miny,maxy);
	to[1] = to[0];

	newdelta(&from[0],&dfrom);
	newdelta(&to[0],&dto);	
	i = 0;
	curcolor = 4;
	
	/* clear the screen */
	SetAPen(RP,0);
	SetOPen(RP,0);
	RectFill(RP, minx, miny, maxx + 5, maxy + 20);
}

range_rand(minv,maxv)
{
	register int i1;
	
	i1 = minv + (rand() % (maxv - minv));
}

mv_point(p,dp)
register Point *p, *dp;
{
	if ((p->x += dp->x) > maxx || p->x < minx)
	{
		dp->x = -dp->x;
		p->x += dp->x;
	}
	if ((p->y += dp->y) > maxy || p->y < miny)
	{
		dp->y = -dp->y;
		p->y += dp->y;
	}
}
newdelta(p,dp)
register Point *p, *dp;
{
	for (dp->x = getdelta() ;
			((p->x + dp->x) > maxx) || ((p->x + dp->x) < minx) ;
			dp->x = getdelta())
		;
	for (dp->y = getdelta() ;
			((p->y + dp->y) > maxy) || ((p->y + dp->y) < miny) ;
			dp->y = getdelta() )
		;
}

getdelta()
{
	register int x;

	x = (8 - (rand() % 16));
}



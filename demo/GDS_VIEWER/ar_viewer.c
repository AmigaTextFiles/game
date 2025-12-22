/*******************************************************************************************

This quick & dirty picture viewer was put together for Amiga Report online magazine, a not-
for-profit organization.  It makes use of the GameSmith ILBM picture loader.  For more
information about the GameSmith Development System, contact:

	Bithead Technologies
	8085 North Raleigh Place
	Westminster, Colorado 80030-4316
	USA
	(303) 427-9521

This source code is hereby placed in the public domain.

USAGE: ar_viewer (filename) [X offset] [Y offset] [Workbench]

*******************************************************************************************/

#include <stdio.h>
#include <stdlib.h>

#include <exec/types.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>
#include <graphics/gfx.h>
#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <pragmas/exec_sysbase_pragmas.h>
#include <pragmas/intuition_pragmas.h>
#include <pragmas/graphics_pragmas.h>

#include "GameSmith:include/libraries/libptrs.h"
#include "GameSmith:GameSmith.h"

#define FONT_WIDTH	8
#define FONT_HEIGHT	8

#define CUSTOM_FLAGS	(BORDERLESS|SUPER_BITMAP|ACTIVATE|NOCAREREFRESH|GIMMEZEROZERO|WINDOWCLOSE)
#define WB_FLAGS		(SUPER_BITMAP|ACTIVATE|WINDOWSIZING|WINDOWDEPTH|WINDOWCLOSE|WINDOWDRAG|GIMMEZEROZERO|NOCAREREFRESH)

#define CUSTOM_SCREEN	0
#define WB_SCREEN			1

/* ----------------------------------------------------------------------- */
/* Function prototypes:                                                    */

int get_wb_info(void);
int load_image(char *);
int display_image(char *,int);
int display_image_window(char *);
int display_image_screen(char *);

/* ----------------------------------------------------------------------- */

int left,right,top,bottom,barheight,width,height,depth;
unsigned long color[256];			/* color table */

char screen_title[]="GameSmith® IFF ILBM Loader";

char topaz8_text[]="topaz.font";

struct TextAttr topaz8 =
	{
	topaz8_text,						/* Addr of ASCIIZ string containing font name */
	8,										/* font YSize (height) */
	FS_NORMAL,							/* style flags */
	FPF_DESIGNED|FPF_ROMFONT		/* flags */
	};

unsigned short pens[] = {0xffff};	/* needed for new (3d) look */

struct TagItem tags[] = {
	{
	SA_Pens,
	(unsigned long)pens
	},
	{
	SA_Width,
	STDSCREENWIDTH
	},
	{
	SA_Height,
	STDSCREENHEIGHT
	},
	{
	SA_Depth,
	0L
	},
	{
	SA_AutoScroll,
	1L
	},
	{
	SA_Type,
	CUSTOMSCREEN
	},
	{
	SA_Quiet,
	1L
	},
	{
	SA_Overscan,
	OSCAN_TEXT
	},
	{
	TAG_DONE,
	0L
	}
	};

struct ExtNewScreen newscreen =
	{
	0,0,									/* left & top edges */
	0,0,0,								/* width, height, & depth (filled) */
	1,2,									/* detail & block pens */
	0,										/* view modes (filled) */
	CUSTOMSCREEN|SCREENQUIET|AUTOSCROLL|
	NS_EXTENDED,						/* type */
	&topaz8,								/* text attribute for font */
	NULL,									/* screen title */
	NULL,									/* ptr to gadgets */
	NULL,									/* ptr to bitmap */
	tags									/* addr of screen tags for V6 and later */
	};

char custom_text[]="Custom Screen";
char wb_text[]="WorkBench Window";
char quit_text[]="Quit";

struct IntuiText item1b_it =
	{
	1,0,								/* Front & Back pens (color reg #) */
	JAM1,								/* Draw mode */
	0,1,								/* left & top edge offsets */
	&topaz8,							/* ptr to font desc. (ROM font) */
	quit_text,						/* addr of actual text string */
	NULL								/* ptr to next intuitext struct */
	};

struct MenuItem item1b = 
	{
	NULL,								/* ptr to next menu item */
	0,									/* left edge */
	FONT_HEIGHT+2,					/* top edge */
	17*FONT_WIDTH,					/* width (# chars * width of font) */
	FONT_HEIGHT+2,					/* height */
	ITEMTEXT|
	ITEMENABLED|HIGHCOMP,		/* flags */
	0,									/* mutual exclusion indicator (none) */
	(APTR)&item1b_it,				/* ptr to item fill */
	NULL,								/* select fill (don't change, just highlight) */
	0,									/* command, or hotkey */
	NULL,								/* ptr to 1st subitem */
	NULL								/* ptr to next selected item (system filled) */
	};

struct IntuiText item1a_it =
	{
	1,0,								/* Front & Back pens (color reg #) */
	JAM1,								/* Draw mode */
	0,1,								/* left & top edge offsets */
	&topaz8,							/* ptr to font desc. (ROM font) */
	custom_text,					/* addr of actual text string */
	NULL								/* ptr to next intuitext struct */
	};

struct MenuItem item1a = 
	{
	&item1b,							/* ptr to next menu item */
	0,									/* left edge */
	0,									/* top edge */
	17*FONT_WIDTH,					/* width (# chars * width of font) */
	FONT_HEIGHT+2,					/* height */
	ITEMTEXT|
	ITEMENABLED|HIGHCOMP,		/* flags */
	0,									/* mutual exclusion indicator (none) */
	(APTR)&item1a_it,				/* ptr to item fill */
	NULL,								/* select fill (don't change, just highlight) */
	0,									/* command, or hotkey */
	NULL,								/* ptr to 1st subitem */
	NULL								/* ptr to next selected item (system filled) */
	};

char menu1_text[]="Display";

struct Menu menu1 =
	{
	NULL,						/* ptr to next menu struct */
	0,0,						/* left edge, top edge */
	8*FONT_WIDTH,			/* width ((# chars + 1) * width of font) */
	FONT_HEIGHT,			/* height (ignored by intuition) */
	MENUENABLED,			/* flags */
	menu1_text,				/* ptr to ASCIIZ name string */
	&item1a					/* ptr to 1st menu item */
	};

BitMapHeader bmh;

struct loadILBM_struct loadimg = 
	{
	NULL,					/* ptr to picture name string */
	NULL,					/* ptr to 1st bitmap */
	NULL,					/* ptr to 2nd bitmap (if any) */
	color,				/* ptr to color table array */
	256,					/* # colors in color table */
	NULL,					/* height of image in pixels (filled by load call) */
	NULL,					/* width of image in pixels (filled) */
	NULL,					/* x display offset (filled) */
	NULL,					/* y display offset (filled) */
	NULL,					/* pic mode (filled) */
	0,						/* x load offset (from left) in bytes */
	0,						/* y load offset (from top) in rows */
	ILBM_ALLOC1|ILBM_COLOR,	/* flags (alloc 1 bitmap, fill color table) */
	0xff,					/* bitplane fill mask */
	0xff,					/* bitplane load mask */
	&bmh					/* address of BitMapHeader to fill (optional) */
	};

struct NewWindow pic_win=
	{
	0,0,0,0,				/* left edge, top edge, width, height */
	1,2,					/* detail & block pens */
	CLOSEWINDOW|MENUPICK,	/* IDCMP flags */
	WB_FLAGS,			/* window flags */
	NULL,					/* ptr to 1st gadget */
	NULL,					/* ptr to checkmark image */
	NULL,					/* window title */
	NULL,					/* ptr to screen */
	NULL,					/* ptr to bitmap to use for refresh */
	30,30,0,0,			/* min width & height, max width & height */
	WBENCHSCREEN		/* window type */
	};

struct NewWindow pic_win2=
	{
	0,0,0,0,				/* left edge, top edge, width, height */
	1,2,					/* detail & block pens */
	CLOSEWINDOW|MENUPICK,	/* IDCMP flags */
	CUSTOM_FLAGS,		/* window flags */
	NULL,					/* ptr to 1st gadget */
	NULL,					/* ptr to checkmark image */
	NULL,					/* window title */
	NULL,					/* ptr to screen */
	NULL,					/* ptr to bitmap to use for refresh */
	0,0,0,0,				/* min width & height, max width & height */
	CUSTOMSCREEN		/* window type */
	};

/***************************************************************************/

main(argc,argv)
int argc;
char *argv[];

{
	int err;

	if (gs_open_libs(INTUITION|DOS|GRAPHICS,0))
		exit(-99);								/* open necessary Amiga libs */
	if (argc < 2)								/* check # command line arguements */
		{
		DisplayBeep(NULL);					/* if error, flash the screen */
		gs_close_libs();						/* close Amiga libs */
		exit(-98);								/* 1st arg has to be name of file to display */
		}
	if (err=get_wb_info())					/* get workbench size, depth, & window border info */
		{
		DisplayBeep(NULL);					/* if error, flash the screen */
		gs_close_libs();						/* close Amiga libs */
		exit(err);
		}
	if (argc >= 3)
		pic_win.LeftEdge=atoi(argv[2]);	/* set left edge of window */
	if (argc >= 4)
		pic_win.TopEdge=atoi(argv[3]);	/* set top edge of window */
	if (err=load_image(argv[1]))			/* load image into it's own bitmap */
		{
		DisplayBeep(NULL);					/* if error, flash the screen */
		gs_close_libs();						/* close Amiga libs */
		exit(err);
		}
/*	printf("\n%d x %d x %d\n",bmh.w,bmh.h,bmh.nPlanes); */	/* print dimensions */
	if (argc >= 5)								/* if 5th arguement */
		err=display_image(argv[1],WB_SCREEN);	/* show on WB screen */
	else
		err=display_image(argv[1],CUSTOM_SCREEN);	/* else show on custom screen */
	if (err)										/* if display error */
		{
		DisplayBeep(NULL);					/* flash the screen */
		gs_free_bitmap(loadimg.bitmap1);	/* free up bitmap we alloced by image load */
		gs_close_libs();						/* close Amiga libs */
		exit(err);
		}
	gs_free_bitmap(loadimg.bitmap1);		/* free up bitmap we alloced by image load */
	gs_close_libs();							/* close Amiga libs */
	exit(err);
}

/***************************************************************************/

int get_wb_info()

{
	struct Screen *s,screen13;		/* for polling WB attributes */

	if (IntuitionBase->LibNode.lib_Version >= 36)	/* if OS 2.0 or above */
		{									/* get info about workbench screen */
		if (!(s=LockPubScreen("Workbench")))
			return(-97);
		left=s->WBorLeft;
		right=s->WBorRight;
		top=s->WBorTop;
		bottom=s->WBorBottom;
		barheight=s->BarHeight;
		width=s->Width;
		height=s->Height;
		depth=s->BitMap.Depth;
		UnlockPubScreen(NULL,s);
		}
	else		/* else use old 1.3 method of polling WB attributes */
		{
		if (!GetScreenData(&screen13,sizeof(struct Screen),WBENCHSCREEN,NULL))
			return(-97);
		left=screen13.WBorLeft;
		right=screen13.WBorRight;
		top=screen13.WBorTop;
		bottom=screen13.WBorBottom;
		barheight=screen13.BarHeight;
		width=screen13.Width;
		height=screen13.Height;
		depth=screen13.BitMap.Depth;
		}
	return(0);
}

/***************************************************************************/

int load_image(file)
char *file;

{
	loadimg.file=file;
	return(gs_loadILBM(&loadimg));		/* load the ILBM file */
}

/***************************************************************************/

int display_image(file,target)
char *file;
int target;

{
	int retcode=1;
	
	if (target == WB_SCREEN)
		{
		while (retcode > 0)
			{
			retcode=display_image_window(file);
			if (retcode > 0)
				retcode=display_image_screen(file);
			}
		}
	else
		{
		while (retcode > 0)
			{
			retcode=display_image_screen(file);
			if (retcode > 0)
				retcode=display_image_window(file);
			}
		}
	return(retcode);
}

/***************************************************************************/

int display_image_window(file)
char *file;

{
	int done=0,retcode=0,right_edge,bottom_edge;
	struct IntuiMessage *msg;
	struct Window *win;
	struct ExecBase *SysBase=*(struct ExecBase **)4;

													/* now set window width & height */
	pic_win.Width=bmh.w+left+right+14;
	pic_win.Height=bmh.h+top+bottom+9;
	pic_win.MaxWidth=pic_win.Width;		/* set maximum window width & height */
	pic_win.MaxHeight=pic_win.Height;
	pic_win.TopEdge+=barheight+1;
	pic_win.BitMap=loadimg.bitmap1;		/* ptr to refresh bitmap */
	if ((pic_win.Width+pic_win.LeftEdge) > width) /* make sure window fits in WB */
		pic_win.Width=width-pic_win.LeftEdge;
	if ((pic_win.Height+pic_win.TopEdge) > height)
		pic_win.Height=height-pic_win.TopEdge;
	pic_win.Title=file;						/* title is name of file */
	if (!(win=OpenWindow(&pic_win)))
		return(-96);							/* unable to open window */
	if ((win->BorderRight != 18) || (win->BorderTop != 11) ||
		(win->BorderLeft != 4) || (win->BorderBottom != 2))
		{											/* make sure we got window borders correct */
		right_edge=bmh.w+win->BorderLeft+win->BorderRight;
		bottom_edge=bmh.h+win->BorderTop+win->BorderBottom;
		WindowLimits(win,30,30,right_edge,bottom_edge);
		SizeWindow(win,right_edge-win->Width,bottom_edge-win->Height);
		}
	SetWindowTitles(win,(UBYTE *)-1,screen_title);
	item1a_it.IText=custom_text;
	SetMenuStrip(win,&menu1);				/* tack on the menu */
	while (!done)
		{
		WaitPort(win->UserPort);			/* wait for Intuition message */
		msg=(struct IntuiMessage *)GetMsg(win->UserPort);
		switch (msg->Class)
			{
			case CLOSEWINDOW:
				done=1;
				break;
			case MENUPICK:
				switch (ITEMNUM(msg->Code))
					{
					case 0:
						retcode=1;
					case 1:
						done=1;
						break;
					default:
						break;
					}
				break;
			default:
				break;
			}
		ReplyMsg((struct Message *)msg);	/* tell Intuition we're done with msg, thanx */
		}
	SetWindowTitles(win,(UBYTE *)-1,NULL);
	ClearMenuStrip(win);						/* remove menu strip */
	CloseWindow(win);
	pic_win.TopEdge-=barheight+1;
	return(retcode);
}

/***************************************************************************/

int display_image_screen(file)
char *file;

{
	int done=0,retcode=0,cnt,colors,r,g,b;
	struct IntuiMessage *msg;
	struct Screen *screen;
	struct Window *win;
	struct ExecBase *SysBase=*(struct ExecBase **)4;

													/* now set window width & height */
	tags[1].ti_Data=bmh.w;
	tags[2].ti_Data=bmh.h+barheight;
	tags[3].ti_Data=loadimg.bitmap1->Depth;
	newscreen.Width = bmh.w;
	newscreen.Height = bmh.h+barheight;
	newscreen.Depth = loadimg.bitmap1->Depth;
	newscreen.ViewModes = loadimg.modes;
	if (!(screen=(struct Screen *)OpenScreen((struct NewScreen *)&newscreen)))
		{
		DisplayBeep(NULL);
		return(1);								/* if can't open screen, go back to WB window */
		}
	pic_win2.Width=bmh.w;
	pic_win2.Height=bmh.h+barheight;
	pic_win2.Screen = screen;
	pic_win2.BitMap=loadimg.bitmap1;		/* ptr to refresh bitmap */
	if (!(win=OpenWindow(&pic_win2)))
		{
		CloseScreen(screen);
		DisplayBeep(NULL);
		return(1);								/* unable to open window */
		}
	colors=1<<loadimg.bitmap1->Depth;
	if (IntuitionBase->LibNode.lib_Version >= 39)	/* if OS 3.0 or above */
		{
		for (cnt=0; cnt < colors; cnt++)
			{
			r=(color[cnt]&0x00ff0000)<<8;
			g=(color[cnt]&0x0000ff00)<<16;
			b=(color[cnt]&0x000000ff)<<24;
			SetRGB32(&screen->ViewPort,cnt,r,g,b);
			}
		}
	else
		{
		for (cnt=0; cnt < colors; cnt++)
			{
			r=(color[cnt]>>20)&0xf;
			g=(color[cnt]>>12)&0xf;
			b=(color[cnt]>>4)&0xf;
			SetRGB4(&screen->ViewPort,cnt,r,g,b);
			}
		}
	SetWindowTitles(win,screen_title,(UBYTE *)-1);
	item1a_it.IText=wb_text;
	SetMenuStrip(win,&menu1);				/* tack on the menu */
	while (!done)
		{
		WaitPort(win->UserPort);			/* wait for Intuition message */
		msg=(struct IntuiMessage *)GetMsg(win->UserPort);
		switch (msg->Class)
			{
			case CLOSEWINDOW:
				done=1;
				break;
			case MENUPICK:
				switch (ITEMNUM(msg->Code))
					{
					case 0:
						retcode=1;
					case 1:
						done=1;
						break;
					default:
						break;
					}
				break;
			default:
				break;
			}
		ReplyMsg((struct Message *)msg);	/* tell Intuition we're done with msg, thanx */
		}
	SetWindowTitles(win,(UBYTE *)-1,NULL);
	ClearMenuStrip(win);						/* remove menu strip */
	CloseWindow(win);
	CloseScreen(screen);
	return(retcode);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <exec/types.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>

#include <proto/exec.h>
#include <proto/graphics.h>

#include "GameSmith:GameSmith.h"
#include "GameSmith:include/libraries/libptrs.h"

/*-------------------------------------------------------------------------*/

#define VIDEO_STEPS		30
#define COLOR_GRADIENT	0x100				/* color change amount */
#define VIDEO_REG			0x180				/* address of bg color reg */
#define BGCOLOR			0xf00				/* max color value (bright red) */
#define BGCOLOR_LONG		0x00ff0000		/* 8 bit color entry (bright red) */

#define THRESHOLD			1000				/* number of lines before clear screen */

/*-------------------------------------------------------------------------*/
/* Function Prototypes																	   */

void parser(int,char **);
int setup(void);
void build_copper(void);
void draw_vector(void);
void clear_bitmap(struct BitMap *);
int check_close(void);
void cleanup(void);

/*-------------------------------------------------------------------------*/
/* some global variables                                                   */

int swidth,sheight,smode;

/*-------------------------------------------------------------------------*/

unsigned short copper_list[256];	/* enough for our custom copper list */

struct copper_struct copper = 
	{
	copper_list,
	NULL,
	NULL
	};

unsigned long ctbl[2] = {BGCOLOR_LONG,0x00ffff00};

struct gs_viewport vp =
	{
	NULL,									/* ptr to next viewport */
	ctbl,									/* ptr to color table */
	2,										/* number of colors in table */
	&copper,								/* ptr to user copper list */
	0,0,0,0,0,							/* height, width, depth, bmheight, bmwidth */
	0,0,									/* top & left viewport offsets */
	0,0,									/* X & Y bitmap offsets */
	GSVP_ALLOCBM,						/* flags (alloc bitmap) */
	NULL,NULL,							/* 2.xx & above compatibility stuff */
	NULL,NULL,							/* bitmap pointers */
	NULL,									/* future expansion */
	0,0,0,0								/* display clip (use nominal) */
	};

struct display_struct vector_display =
	{
	NULL,									/* ptr to previous display view */
	NULL,NULL,							/* 2.xx & above compatibility stuff */
	0,0,									/* X and Y display offsets */
	0,										/* display mode ID */
	0,										/* flags */
	&vp,									/* ptr to 1st viewport */
	NULL									/* future expansion */
	};

/***************************************************************************/

main(argc,argv)
int argc;
char *argv[];

{
	int err,end=0;

	if (gs_open_libs(GRAPHICS,0))	/* open AmigaDOS libs */
		exit(01);					/* if can't open libs, abort */
	parser(argc,argv);			/* parse command line args */
	if (err=setup())				/* if couldn't get set up... abort program */
		{
		printf("\nSetup error: %d\n",err);
		gs_close_libs();			/* close all libraries */
		exit(02);
		}
	Forbid();						/* take over the entire machine */
	while (!end)					/* this shows off speed */
		{
		draw_vector();
		gs_show_display(&vector_display,1);	/* don't let mouse blanker mess us up */
		end=check_close();		/* end when user hits left mouse button */
		}
	Permit();						/* OK, let other things run while we clean up */
	cleanup();						/* close & deallocate everything */
	gs_close_libs();				/* close all libraries */
}

/***************************************************************************/

void parser(argc,argv)
int argc;
char *argv[];

{
	swidth=320;						/* default width & height */
	sheight=200;
	smode=0;							/* default mode of lores no lace */
	if ((argc >= 2) && (!(strcmp(argv[1],"?"))))
		{
		printf("\nUSAGE: vector [HIRES] [SUPER]\n");
		return;
		}
	else if (argc >= 2)
		{
		if (!(stricmp(argv[1],"HIRES")))	/* check for hires spec */
			{
			swidth=640;
			sheight=400;
			if (GfxBase->LibNode.lib_Version >= 36)
				{
				if (ModeNotAvailable(DBLNTSCHIRESFF_KEY))
					smode=HIRES|LACE;
				else
					smode=DBLNTSCHIRESFF_KEY;
				}
			else
				smode=HIRES|LACE;
			}
		else if (!(stricmp(argv[1],"SUPER")))	/* check for superhires */
			{
			if (GfxBase->LibNode.lib_Version >= 36)
				{
				if (ModeNotAvailable(SUPER72_MONITOR_ID | SUPERLACE_KEY))
					{
					swidth=640;
					sheight=400;
					smode=HIRES|LACE;
					}
				else
					{
					smode=SUPER72_MONITOR_ID | SUPERLACE_KEY;
					swidth=800;
					sheight=600;
					}
				}
			else
				{
				swidth=640;
				sheight=400;
				smode=HIRES|LACE;
				}
			}
		}
}

/***************************************************************************/

int setup()

{
	vp.height = sheight;					/* set up display dimensions */
	vp.width = swidth;
	vp.depth = 1;
	vp.bmheight = sheight;
	vp.bmwidth = swidth;
	vector_display.modes = smode;
	build_copper();						/* build custom copper list */
	if (gs_create_display(&vector_display))
		{
		return(-1);
		}
	gs_show_display(&vector_display,1);
	return(0);
}

/***************************************************************************/

void build_copper()

/* build a custom copper list of background color changes */

{
	int cnt,cnt2=0,video_gradient;
	short bgcolor,gradient;

	bgcolor=BGCOLOR;
	gradient=0;
	video_gradient=(sheight/3)/15;
	copper_list[cnt2++]=UC_NOSPRITES;		/* turn off sprites */
	for (cnt=0; cnt < 16; cnt++)				/* build copper list */
		{
		if (cnt)
			{
			copper_list[cnt2++]=UC_WAIT;		/* copper wait instruction */
			copper_list[cnt2++]=gradient;		/* y coord to wait on */
			copper_list[cnt2++]=0;				/* x coord to wait on */
			}
		copper_list[cnt2++]=UC_MOVE;			/* copper move instruct */
		copper_list[cnt2++]=VIDEO_REG;		/* register to affect */
		copper_list[cnt2++]=bgcolor;			/* value for register */
		gradient+=video_gradient;
		bgcolor-=COLOR_GRADIENT;
		if (bgcolor < 0)
			bgcolor=0;
		}
	gradient=(sheight/3)*2;						/* build bottom color gradient */
	bgcolor+=COLOR_GRADIENT;
	for (cnt=0; cnt < 15; cnt++)				/* build copper list */
		{
		copper_list[cnt2++]=UC_WAIT;			/* copper wait instruction */
		copper_list[cnt2++]=gradient;			/* y coord to wait on */
		copper_list[cnt2++]=0;					/* x coord to wait on */
		copper_list[cnt2++]=UC_MOVE;			/* copper move instruct */
		copper_list[cnt2++]=VIDEO_REG;		/* register to affect */
		copper_list[cnt2++]=bgcolor;			/* value for register */
		gradient+=video_gradient;
		bgcolor+=COLOR_GRADIENT;
		if (gradient > sheight)
			gradient=sheight;
		if (bgcolor > BGCOLOR)
			bgcolor=BGCOLOR;
		}
	copper_list[cnt2++]=UC_END;				/* end coppper list */
}

/***************************************************************************/

void draw_vector()

/* draw a line on the screen */

{
	static int line_count=0;
	int x1,y1,cnt;

	for (cnt=0; cnt < 100; cnt++)
		{
		x1=gs_random(swidth);
		y1=gs_random(sheight);
		gs_init_vector(0,x1,y1,gs_random(swidth),gs_random(sheight));
		while (x1|y1)
			{
			gs_plot(vp.bitmap1,x1,y1,1);
			gs_step_vector(0,1,&x1,&y1);		/* next point on line */
			}
		}
	line_count+=100;
	if (line_count >= THRESHOLD)
		{
		clear_bitmap(vp.bitmap1);
		line_count=0;
		}
}

/***************************************************************************/

void clear_bitmap(bitmap)
struct BitMap *bitmap;

{
	int cnt;

	for (cnt=0; cnt < bitmap->Depth; cnt++)
		{			/* clear each plane, wait for blitter to finish */
		BltClear(bitmap->Planes[cnt],(bitmap->Rows*bitmap->BytesPerRow),1);
		}
}

/***************************************************************************/

int check_close()

/* check for user input */

{
	if (gs_joystick(0) & JOY_BUTTON1)
		return(1);
	return(0);
}

/***************************************************************************/

void cleanup()

/* release all resources and memory */

{
	gs_remove_display(&vector_display);
}

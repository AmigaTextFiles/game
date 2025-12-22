#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <exec/memory.h>
#include <exec/types.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>

#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>

#include "GameSmith:GameSmith.h"
#include "GameSmith:include/libraries/libptrs.h"

#define WORDS			30
#define RECTANGLES	100

#define BMWIDTH	1024
#define BMHEIGHT	800

#define X_SPEED	7
#define Y_SPEED	5

/*-------------------------------------------------------------------------*/
/* Function Prototypes																	   */

void scan_copper(void);

void scroll(void);
void parser(int,char **);
int setup(void);
void rastport_demo(struct BitMap *);
void copy_bitmap(struct BitMap *,struct BitMap *);
void move_image(void);
void check_bounds(void);
void collision1(struct anim_struct *,struct anim_struct *,
	  struct collision_struct *,struct collision_struct *);
int check_close(void);
void cleanup(void);
void free_arrays(void);

/*-------------------------------------------------------------------------*/
/* some global variables                                                   */

int bubble_cnt,swidth,sheight,smode=0,delay=0,random_x=11,random_y=9;
int *x=NULL,*y=NULL,*speedx=NULL,*speedy=NULL,*reset=NULL,*last=NULL;
int dlist;

struct anim_struct *bubble;
struct Interrupt *scroller=NULL;

/*-------------------------------------------------------------------------*/

unsigned short copper_list[]=		/* custom copper list */
	{
	UC_NOSPRITES,						/* turn off sprite DMA */
	UC_END								/* end of user copper list */
	};

struct copper_struct copper = 
	{
	copper_list,
	NULL,
	NULL
	};

struct gs_viewport vp =
	{
	NULL,									/* ptr to next viewport */
	NULL,									/* ptr to color table */
	0,										/* number of colors in table */
	&copper,								/* ptr to user copper list */
	0,0,0,BMHEIGHT,BMWIDTH,			/* height, width, depth, bmheight, bmwidth */
	0,0,									/* top & left viewport offsets */
	128,50,								/* X & Y bitmap offsets */
	GSVP_ALLOCBM|GSVP_DCLIP,		/* flags (alloc bitmaps, use display clip) */
	NULL,NULL,							/* 2.xx & above compatibility stuff */
	NULL,NULL,							/* bitmap pointers */
	NULL,									/* future expansion */
	0,0,0,0								/* display clip (use nominal) */
	};

struct display_struct bubble_display =
	{
	NULL,									/* ptr to previous display view */
	NULL,NULL,							/* 2.xx & above compatibility stuff */
	0,0,									/* X and Y display offsets (1.3 style) */
	0,										/* display mode ID */
	GSV_DOUBLE|GSV_SCROLLABLE,		/* flags (double buffered, scrollable) */
	&vp,									/* ptr to 1st viewport */
	NULL									/* future expansion */
	};

/***************************************************************************/

main(argc,argv)
int argc;
char *argv[];

{
	int err,end=0;

	if (argc < 2)
		{
		printf("\nUSAGE: bubbles [number of bubbles] [HIRES] [SUPER] [VB delay intervals] [X speed] [Y speed]\n");
		exit(01);
		}
	if (gs_open_libs(DOS|GRAPHICS,0))	/* open AmigaDOS libs */
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
		move_image();				/* move them bubbles around */
		end=check_close();		/* end when user hits left mouse button */
		}
	Permit();						/* OK, let other things run while we clean up */
	cleanup();						/* close & deallocate everything */
	gs_close_libs();				/* close all libraries */
}

/***************************************************************************/

void __interrupt __saveds scroll()

{
	int stick,x=0,y=0,velocity=2,move;
	static unsigned long timeout=0;
	static int x_dir=0, y_dir=0;

	stick = gs_joystick(1);
	if (stick & (JOY_LEFT|JOY_RIGHT|JOY_UP|JOY_DOWN))
		{
		if (stick & JOY_LEFT)
			x=(velocity+1)*-1;
		else if (stick & JOY_RIGHT)
			x=velocity+1;
		if (stick & JOY_UP)
			y=velocity*-1;
		else if (stick & JOY_DOWN)
			y=velocity;
		if (stick & JOY_BUTTON1)
			gs_scroll_vp_pf1(&bubble_display,0,x,y,1);/* scroll viewport 0, playefield 1, sync */
		else
			gs_scroll_vp(&bubble_display,0,x,y,1);		/* scroll viewport 0, synchronize */
		timeout=0;
		}
	else
		{
		if (timeout++ >= (60*5))						/* 5 second time out */
			{
			if (!x_dir)
				{
				x_dir=gs_random(X_SPEED)+1;
				if (gs_random(100) < 50)
					x_dir*=-1;
				}
			if (!y_dir)
				{
				y_dir=gs_random(Y_SPEED);
				if (gs_random(100) < 50)
					y_dir*=-1;
				}
			move=gs_scroll_vp(&bubble_display,0,x_dir,y_dir,1); /* scroll viewport 0, synchronize */
			if (move & GSVP_PF1_RIGHT)
				x_dir=(gs_random(X_SPEED)+1)*-1;
			else if (move & GSVP_PF1_LEFT)
				x_dir=(gs_random(X_SPEED)+1);
			if (move & GSVP_PF1_BOTTOM)
				y_dir=(gs_random(Y_SPEED)+1)*-1;
			else if (move & GSVP_PF1_TOP)
				y_dir=(gs_random(Y_SPEED)+1);
			}
		}
}

/***************************************************************************/

void parser(argc,argv)
int argc;
char *argv[];

{
	bubble_cnt=atoi(argv[1]);	/* # anims to place on the screen */
	swidth=320;						/* default width & height */
	sheight=200;
/*	smode=0;			*/				/* default mode of lores no lace */
	#ifdef NTSC_MONITOR_ID
	smode=NTSC_MONITOR_ID;
	#endif
	if (argc >= 3)
		{
		if (!(stricmp(argv[2],"HIRES")))	/* check for hires spec */
			{
			swidth=640;
			sheight=400;
			smode|=HIRES|LACE;
			}
		else if (!(stricmp(argv[2],"SUPER")))	/* check for superhires */
			{
			if (GfxBase->LibNode.lib_Version >= 36)
				{
				#ifdef SUPER72_MONITOR_ID
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
				#else
				swidth=640;
				sheight=400;
				smode=HIRES|LACE;
				#endif
				}
			else
				{
				swidth=640;
				sheight=400;
				smode=HIRES|LACE;
				}
			}
		}
	if (argc >= 4)
		{
		delay=atoi(argv[3]);		/* delay value in vertical blank intervals */
		}
	if (argc >= 5)					/* new random X speed range */
		{
		random_x=atoi(argv[4]);
		if (random_x < 2)
			random_x=2;
		}
	if (argc >= 6)					/* new random Y speed range */
		{
		random_y=atoi(argv[5]);
		if (random_y < 2)
			random_y=2;
		}
}

/***************************************************************************/

int setup()

{
	int cnt,depth=0,diff;
	struct blit_struct *img;
	struct anim_load_struct load;
	struct DimensionInfo dim;

	if (!(x=(int *)malloc(bubble_cnt*sizeof(int))))
		return(-1);
	if (!(y=(int *)malloc(bubble_cnt*sizeof(int))))
		{
		free_arrays();
		return(-1);
		}
	if (!(speedx=(int *)malloc(bubble_cnt*sizeof(int))))
		{
		free_arrays();
		return(-1);
		}
	if (!(speedy=(int *)malloc(bubble_cnt*sizeof(int))))
		{
		free_arrays();
		return(-1);
		}
	if (!(last=(int *)malloc(bubble_cnt*sizeof(int))))
		{
		free_arrays();
		return(-1);
		}
	if (!(reset=(int *)malloc(bubble_cnt*sizeof(int))))
		{
		free_arrays();
		return(-1);
		}
	load.filename="bubble2";			/* name of anim file */
	load.cmap_size=8;						/* number of bits per color value */
	load.array_elements=bubble_cnt;	/* number of array elements desired */
	load.flags=0L;							/* no special load flags */
	if (gs_load_anim(&load))			/* load the anim object */
		{
		free_arrays();
		return(-2);
		}
	bubble=load.anim_ptr.anim;			/* ptr to bubble anim */
	if (load.type)							/* make sure it's an anim type */
		{
		FreeMem(load.cmap,load.cmap_entries*sizeof(long));
		free_arrays();
		if (load.type = 1)
			gs_free_cplx((struct anim_cplx *)bubble,bubble_cnt);
		return(-3);
		}
	img = bubble[0].list;				/* ptr to 1st image in anim sequence */
	while (img)								/* find max depth of anim */
		{
		if (img->depth > depth)
			depth = img->depth;
		if (img->next == img)			/* avoid infinite loop */
			img=NULL;						/* if single shot anim */
		else
			img=img->next;
		}
	vp.height = sheight;					/* set up display dimensions */
	vp.width = swidth;
	vp.depth = depth;
	bubble_display.modes = smode;
	vp.num_colors=load.cmap_entries;
	vp.color_table=load.cmap;			/* addr of color table */
//	vp.dclip.MaxX=swidth;				/* set display clip */
//	vp.dclip.MaxY=sheight;
	if (GfxBase->LibNode.lib_Version >= 36)
		{										/* set up display clip */
		if (!GetDisplayInfoData(NULL,(UBYTE *)&dim,sizeof(struct DimensionInfo),
			DTAG_DIMS,smode))
			{
			FreeMem(load.cmap,load.cmap_entries*sizeof(long));
			free_arrays();
			gs_free_anim(bubble,bubble_cnt);
			return(-5);
			}
		if (swidth > dim.TxtOScan.MaxX)
			{
			vp.dclip.MinX=dim.TxtOScan.MinX;
			vp.dclip.MaxX=dim.TxtOScan.MaxX;
			}
		else
			{
			diff=dim.TxtOScan.MaxX-dim.TxtOScan.MinX;
			diff-=swidth;
			vp.dclip.MinX=dim.TxtOScan.MinX+(diff>>1);
			vp.dclip.MaxX=dim.TxtOScan.MaxX-(diff>>1);;
			}
		if (sheight > dim.TxtOScan.MaxY)
			{
			vp.dclip.MinY=dim.TxtOScan.MinY;
			vp.dclip.MaxY=dim.TxtOScan.MaxY;
			}
		else
			{
			diff=dim.TxtOScan.MaxY-dim.TxtOScan.MinY;
			diff-=sheight;
			vp.dclip.MinY=dim.TxtOScan.MinY+(diff>>1);
			vp.dclip.MaxY=dim.TxtOScan.MaxY-(diff>>1);;
			}
		}
	if (gs_create_display(&bubble_display))
		{
		FreeMem(load.cmap,load.cmap_entries*sizeof(long));
		free_arrays();
		gs_free_anim(bubble,bubble_cnt);
		return(-6);
		}
	scroller=gs_add_vb_server(&scroll,0);
	if (!scroller)
		{
		FreeMem(load.cmap,load.cmap_entries*sizeof(long));
		free_arrays();
		gs_free_anim(bubble,bubble_cnt);
		return(-7);
		}
	FreeMem(load.cmap,load.cmap_entries*sizeof(long));	/* done with color table */
	if ((dlist=gs_get_display_list()) < 0)
		{
		free_arrays();
		gs_free_anim(bubble,bubble_cnt);
		return(-8);
		}
	gs_init_anim(dlist,vp.bitmap1,vp.bitmap2);	/* tell anim system about bitmaps */
	gs_random(0);							/* seed random function */
	gs_set_anim_bounds(dlist,0,0,BMWIDTH-1,BMHEIGHT-1);	/* set bounds for anim objects */
	gs_set_collision(dlist,&collision1);	/* set ptr to collision handler */
	for (cnt=0; cnt < bubble_cnt; cnt++)
		{										/* add all bubbles to a display list */
		reset[cnt]=0;
		last[cnt]=-1;
		x[cnt] = gs_random(BMWIDTH);	/* random X,Y coords */
		y[cnt] = gs_random(BMHEIGHT);
		while ((speedx[cnt] = gs_random(random_x)) == 0);
		while ((speedy[cnt] = gs_random(random_y)) == 0);
		if (cnt&1)
			{
			speedx[cnt]=-speedx[cnt];
			speedy[cnt]=-speedy[cnt];
			}
		if (gs_add_anim(dlist,&bubble[cnt],x[cnt],y[cnt]))
			{
			cleanup();						/* release everything */
			return(-8);						/* return failure */
			}
		gs_set_anim_cell(&bubble[cnt],gs_random(bubble[cnt].count));
		}
	rastport_demo(vp.bitmap1);			/* alloc rastport & draw some stuff */
	copy_bitmap(vp.bitmap1,vp.bitmap2);	/* copy bitmap 1 to bitmap 2 */
	gs_draw_anims(dlist);
	check_bounds();
	gs_next_anim_page(dlist);
	gs_show_display(&bubble_display,1);
	gs_flip_display(&bubble_display,1);
	gs_open_vb_timer();
	return(0);
}

/***************************************************************************/

void rastport_demo(bitmap)
struct BitMap *bitmap;

{
	struct RastPort rastport = {0};
	int cnt,x,y,width,height;

	InitRastPort(&rastport);			/* initialize rastport */
	rastport.BitMap=bitmap;				/* tell rastport to use our bitmap */
	SetDrMd(&rastport,JAM1);
	for (cnt=0; cnt < RECTANGLES; cnt++)
		{
		SetAPen(&rastport,gs_random(1<<bitmap->Depth)+1);	/* select pen color */
		width=gs_random(BMWIDTH/2);
		height=gs_random(BMHEIGHT/2);
		x=gs_random(BMWIDTH-width);
		y=gs_random(BMHEIGHT-height);
		RectFill(&rastport,x,y,x+width,y+height);
		}
	for (cnt=0; cnt < WORDS; cnt++)
		{
		SetAPen(&rastport,gs_random(1<<bitmap->Depth)+1);	/* select pen color */
		/*
		NOTE: below you should replace "80" with the width of the font times the
		width of the string (10 chars in this case).  Then you should replace the
		"16" with the font height, and the "15" with the font height - 1.
		*/
		Move(&rastport,gs_random(BMWIDTH-80),gs_random(BMHEIGHT-16)+15); /* position drawing pen */
		Text(&rastport,"GameSmith!",10);	/* print some text */
		}
}

/***************************************************************************/

void copy_bitmap(bm1,bm2)
struct BitMap *bm1,*bm2;

{
	int cnt;

/* 
	NOTE: gs_blit_memcopy is the only "blit" function that DOESN'T have a
   CPU version.  A memory copy operation using the CPU is obviously an
	incredibly trivial task.  The gs_blit_memcopy function can only operate
	on Chip RAM since it uses the blitter chip.
*/

	for (cnt=0; cnt < bm1->Depth; cnt++)
		{
		gs_blit_memcopy(bm1->Planes[cnt],bm2->Planes[cnt],
			(bm1->BytesPerRow/2)*bm1->Rows);
		}
}

/***************************************************************************/

void move_image()

/* move and animate the graphic objects on the screen */

{
	int cnt;

	if (gs_vb_time() < delay)
		return;
	gs_vb_timer_reset();
	for (cnt=0; cnt < bubble_cnt; cnt++)
		{
		x[cnt]+=speedx[cnt];				/* move the object */
		y[cnt]+=speedy[cnt];
		gs_anim_obj(&bubble[cnt],x[cnt],y[cnt]);
		if (reset[cnt])					/* since anim doesn't loop, must reset */
			{									/* the sequence in the event of collision */
			reset[cnt]=0;					/* start at 1st cell in anim sequence */
			gs_set_anim_cell(&bubble[cnt],0);
			}
		if (!bubble[cnt].collide)		/* if not colliding, clear last ptr */
			last[cnt]=-1;
		}
	while (bubble_display.flags & GSV_FLIP);	/* while page not flipped yet */
	gs_draw_anims(dlist);				/* draw them anim objects! */
	check_bounds();						/* bounce off of outer bitmap bounds */
	gs_next_anim_page(dlist);			/* tell anim sys to use other bitmap */
	gs_flip_display(&bubble_display,1);	/* switch to other display, sync */
}

/***************************************************************************/

void check_bounds()

{
	int cnt;

	for (cnt=0; cnt < bubble_cnt; cnt++)
		{
		if (bubble[cnt].flags & (ANIM_BOUNDS_X1|ANIM_BOUNDS_X2))
			{
			x[cnt]=bubble[cnt].x;	/* keep track of current location */
			speedx[cnt]=-speedx[cnt];	/* reverse X direction */
			reset[cnt]=1;				/* make bubble warp */
			last[cnt]=-1;				/* no colliding */
			}
		if (bubble[cnt].flags & (ANIM_BOUNDS_Y1|ANIM_BOUNDS_Y2))
			{
			y[cnt]=bubble[cnt].y;
			speedy[cnt]=-speedy[cnt];	/* reverse Y direction */
			reset[cnt]=1;
			last[cnt]=-1;
			}
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

void collision1(anim1,anim2,coll1,coll2)
struct anim_struct *anim1;
struct anim_struct *anim2;
struct collision_struct *coll1;
struct collision_struct *coll2;

/*

This is the collision handler which makes the bubbles "bounce" off of
each other.

*/

{
	int temp;

	if (last[anim1->array_num] != anim2->array_num)		/* if not same object */
		{
		last[anim1->array_num] = anim2->array_num;		/* remember last collision */
		last[anim2->array_num] = anim1->array_num;
		reset[anim1->array_num]=1;								/* reset anim cell */
		reset[anim2->array_num]=1;
		temp=speedy[anim2->array_num];						/* swap values */
		speedy[anim2->array_num]=speedy[anim1->array_num];
		speedy[anim1->array_num]=temp;
		temp=speedx[anim2->array_num];
		speedx[anim2->array_num]=speedx[anim1->array_num];
		speedx[anim1->array_num]=temp;
		}
}

/***************************************************************************/

void cleanup()

/* release all resources and memory */

{
	if (scroller)
		gs_remove_vb_server(scroller);
	free_arrays();
	gs_free_anim(bubble,bubble_cnt);
	gs_remove_display(&bubble_display);
	gs_free_display_list(dlist);
	gs_close_vb_timer();
}

/***************************************************************************/

void free_arrays()

/* release memory used by control arrays */

{
	if (x)
		free(x);
	if (y)
		free(y);
	if (speedx)
		free(speedx);
	if (speedy)
		free(speedy);
	if (last)
		free(last);
	if (reset)
		free(reset);
}

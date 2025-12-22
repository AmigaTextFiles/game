#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>

#include <exec/memory.h>
#include <exec/types.h>
#include <graphics/gfxbase.h>

#include <clib/exec_protos.h>
#include <clib/graphics_protos.h>

#include "GameSmith:include/libraries/libraries.h"
#include "GameSmith:include/libraries/libptrs.h"
#include "GameSmith:GameSmith.h"

#include "elf.h"

/*-------------------------------------------------------------------------*/
/* Function Prototypes																	   */

void parser(int,char **);
int setup(void);
void move_image(void);
void check_bounds(void);
int check_close(void);
void cleanup(void);
void free_arrays(void);

/*-------------------------------------------------------------------------*/

int elf_cnt,swidth=320,sheight=200,smode=0;
int *x=NULL,*y=NULL,*speedx=NULL,*speedy=NULL;
int dlist=-1;

struct anim_cplx *elf;

struct display_struct *display;

/*-------------------------------------------------------------------------*/

main(argc,argv)
int argc;
char *argv[];

{
	int err,end=0;

	if (argc < 2)
		{
		printf("\nUSAGE: Elves [number of elves] [HIRES] [LACE]\n");
		exit(01);
		}
	if (gs_open_libs(DOS|GRAPHICS,0))
		exit(02);					/* if can't open libs, abort */
	parser(argc,argv);			/* parse command line args */
	if (err=setup())				/* if couldn't get set up... abort program */
		{
		printf("\nsetup error %d\n",err);
		gs_close_libs();			/* close all libraries */
		exit(03);
		}
	Forbid();
	while (!end)
		{
		move_image();
		end=check_close();		/* end when user hits left mouse */
		}
	Permit();
	cleanup();						/* close & deallocate everything */
	gs_close_libs();				/* close all libraries */
}

/***************************************************************************/

void parser(argc,argv)
int argc;
char *argv[];

{
	elf_cnt=atoi(argv[1]);		/* number of complexes running around screen */
	if (argc >= 3)
		{
		if (!(stricmp(argv[2],"HIRES")))	/* check for hires spec */
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
		else if (!(stricmp(argv[2],"SUPER")))	/* check for superhires */
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

setup()

{
	int cnt,seq,depth=0;
	struct anim_struct *anim;
	struct blit_struct *img;

	struct anim_load_struct load =
		{
		"elf",								/* name of anim file to load */
		NULL,									/* ptr to anim upon return */
		NULL,									/* ptr to attachment array specification upon return */
		NULL,									/* ptr to color map upon return */
		0,										/* # entries in the color map */
		8,										/* # bits per color map entry */
		0,										/* type (filled). 0 = anim, 1 = complex */
		1,										/* # elfs to allocate in array */
		0										/* flags */
		};

	if (!(x=(int *)malloc(elf_cnt*sizeof(int))))
		return(-1);
	if (!(y=(int *)malloc(elf_cnt*sizeof(int))))
		{
		free_arrays();
		return(-1);
		}
	if (!(speedx=(int *)malloc(elf_cnt*sizeof(int))))
		{
		free_arrays();
		return(-1);
		}
	if (!(speedy=(int *)malloc(elf_cnt*sizeof(int))))
		{
		free_arrays();
		return(-1);
		}
	load.array_elements=elf_cnt;		/* user specified # elves */
	if (gs_load_anim(&load))
		{
		free_arrays();
		return(-1);
		}
	elf=load.anim_ptr.cplx;				/* ptr to elf complex */
	if (load.type != 1)					/* make sure it's an anim complex */
		{
		free_arrays();
		if (load.type == 0)
			gs_free_anim((struct anim_struct *)elf,elf_cnt);
		return(-2);
		}
	anim = elf[0].list;					/* ptr to 1st anim in complex */
	while (anim)
		{
		img = anim->list;					/* ptr to 1st image in anim sequence */
		while (img)							/* find max depth of anim */
			{
			if (img->depth > depth)
				depth = img->depth;
			if (img->next == img)		/* avoid infinite loop */
				img=NULL;
			else
				img=img->next;
			}
		anim=anim->cplx_next;			/* next anim in complex */
		}
	if (!(display=gs_display(swidth,sheight,depth,smode,GSV_DOUBLE,load.cmap)))
		{
		free_arrays();
		FreeMem(load.cmap,load.cmap_entries*sizeof(long));
		gs_free_cplx(elf,elf_cnt);
		return(-3);
		}
	FreeMem(load.cmap,load.cmap_entries*sizeof(long));
	if ((dlist=gs_get_display_list()) < 0)
		{
		cleanup();
		return(-4);
		}
	gs_init_anim(dlist,display->vp->bitmap1,display->vp->bitmap2);
	gs_set_anim_bounds(dlist,0,0,swidth-1,sheight-1);
	gs_random(0);								/* seed random function */
	for (cnt=0; cnt < elf_cnt; cnt++)
		{
		x[cnt] = gs_random(swidth);			/* random X,Y coords */
		y[cnt] = gs_random(sheight);
		while ((speedx[cnt] = gs_random(11)) < 3);
		while ((speedy[cnt] = gs_random(4)) == 0);
		if (cnt&1)
			{
			speedx[cnt]=-speedx[cnt];
			speedy[cnt]=-speedy[cnt];
			seq=ELF_LEFT;
			}
		else
			seq=ELF_RIGHT;
		if (gs_add_anim_cplx(dlist,&elf[cnt],x[cnt],y[cnt],seq,elf[cnt].list->prio))
			{
			cleanup();						/* release everything */
			return(-5);						/* return failure */
			}
		}
	gs_draw_anims(dlist);
	check_bounds();
	gs_next_anim_page(dlist);
	gs_show_display(display,1);
	gs_flip_display(display,1);
	return(0);
}

/***************************************************************************/

void move_image()

/* move and animate the graphic objects on the screen */

{
	int cnt;

	for (cnt=0; cnt < elf_cnt; cnt++)
		{
		x[cnt]+=speedx[cnt];
		y[cnt]+=speedy[cnt];
		gs_anim_cplx(&elf[cnt],x[cnt],y[cnt]);
		}
	while (display->flags & GSV_FLIP);	/* while display not flipped */
	gs_draw_anims(dlist);					/* draw them anim objects! */
	check_bounds();						/* keep a watch on them pesky keeblers */
	gs_next_anim_page(dlist);			/* tell anim sys to use other bitmap */
	gs_flip_display(display,1);		/* switch to other display, sync */
}

/***************************************************************************/

void check_bounds()

{
	int cnt;

	for (cnt=0; cnt < elf_cnt; cnt++)
		{
		if (elf[cnt].anim->flags & ANIM_BOUNDS_X1)
			{
			x[cnt]=elf[cnt].anim->x;
			speedx[cnt]=-speedx[cnt];
			gs_set_cplx_seq(&elf[cnt],ELF_RIGHT,x[cnt],y[cnt]);
			}
		else if (elf[cnt].anim->flags & ANIM_BOUNDS_X2)
			{
			x[cnt]=elf[cnt].anim->x;
			speedx[cnt]=-speedx[cnt];
			gs_set_cplx_seq(&elf[cnt],ELF_LEFT,x[cnt],y[cnt]);
			}
		if (elf[cnt].anim->flags & (ANIM_BOUNDS_Y1|ANIM_BOUNDS_Y2))
			{
			y[cnt]=elf[cnt].anim->y;
			speedy[cnt]=-speedy[cnt];
			}
		}
}

/***************************************************************************/

int check_close()

/* check for user input */

{
	if (gs_joystick(0) & JOY_BUTTON1)	/* IF (mouse button pressed) */
		return(1);							/* ..time to wrap up */
	return(0);								/* ELSE (keep going) */
}

/***************************************************************************/

void cleanup()

/* release all resources and memory */

{
	free_arrays();
	gs_free_cplx(elf,elf_cnt);
	if (dlist >= 0)
		gs_free_display_list(dlist);
	gs_remove_display(display);
}

/***************************************************************************/

void free_arrays()

{
	if (x)
		free(x);							/* free up control arrays */
	if (y)
		free(y);
	if (speedx)
		free(speedx);
	if (speedy)
		free(speedy);
}

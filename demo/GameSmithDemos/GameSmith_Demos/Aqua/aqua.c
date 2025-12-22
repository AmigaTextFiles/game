/* Aqua demo by John Enright.  Graphics (c) Mike Alkan */

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
#include "GameSmith:include/proto/all_regargs.h"
#include "GameSmith:include/libraries/libptrs.h"

#define DISPLAY_SIZE   320            /* lores display resolution horizontal */

#define PAGE_SIZE   (DISPLAY_SIZE*4)   /* actual scrollable bitmap size */

#define BMDEPTH   4                  /* depth of bitmap (16 color) */
#define BMOFFSET   48         /* buffer amount (in pixels) for anims & display offset */
#define BMWIDTH   (PAGE_SIZE+(BMOFFSET*2))   /* actual width of bitmap */
#define BMHEIGHT   192               /* height of bitmap.  All of this is visible */

#define VS_X         (PAGE_SIZE*10)   /* width of virtual space for object traversal */
#define LEFT_BOUNDS   BMOFFSET         /* left boundary for anim objects */
#define RIGHT_BOUNDS   (VS_X+BMOFFSET)   /* right boundary for anim objects */
#define TOP_BOUNDS   16               /* top boundary for anim objects */
#define BOTTOM_BOUNDS 184            /* bottom boundary for anim objects */
#define BOTTOM_SPACE   16         /* vertical rows on sea bottom for obj placement */

#define ANIM_SPEED   4         /* pixel speed for object movement */

#define ANIM_COUNT   18         /* number of objects in each array */

#define VB_DELAY      5         /* the fastest objects are allowed to animate */

#define FRAME_RATE   1         /* scroll rate in vertical blank intervals */

/*-------------------------------------------------------------------------*/
/* Function Prototypes                                                      */

void scroll(void);
int setup(void);
int place_anim_bottom(struct anim_struct *);
int place_cplx_bottom(struct anim_cplx *);
int place_cplx(struct anim_cplx *);
void move_creatures(void);
void move_anim(struct anim_struct *);
void move_cplx(struct anim_cplx *);
void check_bounds(void);
void check_anim_bounds(struct anim_struct *);
void check_cplx_bounds(struct anim_cplx *);
int check_close(void);
void cleanup(void);

/*-------------------------------------------------------------------------*/
/* some global variables                                                   */

struct Interrupt *scroller=NULL;
unsigned long color[1<<BMDEPTH];   /* color table with 2 to the power of BMDEPTH entries */
int dlist=-1;                     /* display list handle for anims */

int rs_offset=0,window,reset=0;

/* ---- the anim object array pointers ---- */

struct anim_struct *rollcrab=NULL,*coral1=NULL,*coral2=NULL,*coral3=NULL;
struct anim_cplx *fish1=NULL,*fish2=NULL,*fish3=NULL;
struct anim_cplx *aquadino=NULL;

/*-------------------------------------------------------------------------*/

BitMapHeader bmh;

struct loadILBM_struct loadpic =
   {
   "gfx/aqua.pic",   /* ptr to picture name string */
   NULL,               /* ptr to 1st bitmap */
   NULL,               /* ptr to 2nd bitmap (if any) */
   color,            /* ptr to color table array */
   (1<<BMDEPTH),      /* # colors in color table */
   NULL,               /* height of image in pixels (filled by load call) */
   NULL,               /* width of image in pixels (filled) */
   NULL,               /* x display offset (filled) */
   NULL,               /* y display offset (filled) */
   NULL,               /* pic mode (filled) */
   BMOFFSET/8,         /* x load offset (from left) in bytes */
   0,                  /* y load offset (from top) in rows */
   ILBM_COLOR,         /* flags (fill color table) */
   0xff,               /* bitplane fill mask */
   0xff,               /* bitplane load mask */
   &bmh               /* address of BitMapHeader to fill */
   };

struct gs_viewport vp =
   {
   NULL,                           /* ptr to next viewport */
   color,                        /* ptr to color table */
   (1<<BMDEPTH),                  /* number of colors in table */
   NULL,                           /* ptr to user copper list */
   BMHEIGHT,DISPLAY_SIZE,BMDEPTH,BMHEIGHT,BMWIDTH, /* height, width, depth, bmheight, bmwidth */
   0,0,                           /* top & left viewport offsets */
   BMOFFSET,0,                     /* X & Y bitmap offsets */
   GSVP_ALLOCBM,                  /* flags (allocate bitmaps) */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   NULL,NULL,                     /* bitmap pointers */
   NULL,                           /* future expansion */
   0,0,0,0                        /* display clip (MinX,MinY,MaxX,MaxY) */
   };

struct display_struct display =
   {
   NULL,                           /* ptr to previous display view */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   0,0,                           /* X and Y display offsets (1.3 style) */
   0,                              /* display mode ID */
   4,4,                           /* sprite priorities */
   GSV_DOUBLE|GSV_SCROLLABLE|
   GSV_HARDX,                     /* flags (scrollable double buffered) */
   &vp,                           /* ptr to 1st viewport */
   NULL                           /* future expansion */
   };

/***************************************************************************/

main(argc,argv)
int argc;
char *argv[];

{
   int err,end=0;

   if (gs_open_libs(DOS|GRAPHICS,0))   /* open AmigaDOS libs, latest versions */
      exit(01);               /* if can't open libs, abort */
   if (err=setup())            /* if couldn't get set up... abort program */
      {
      printf("\nSetup error: %d\n",err);
      gs_close_libs();         /* close all libraries */
      exit(02);
      }
   Forbid();                  /* take over the entire machine */
   while (!end)               /* this shows off speed */
      {
      move_creatures();         /* animate everything */
      end=check_close();      /* end when user hits left mouse button */
      }
   Permit();                  /* OK, let other things run while we clean up */
   cleanup();                  /* close & deallocate everything */
   gs_close_libs();            /* close all libraries */
}

/***************************************************************************/
/*
   This is the scroll handler which runs as a vertical blank server routine
   and handles scrolling of the bitmap.  This is the reason for its ultra-
   smooth performance, regardless of what the animation system is doing.

   The "__interrupt" is a SAS convention used to make sure that the function
   does NOT do stack checking.  The "__saveds" is also a SAS convention, and
   loads the near data pointer at the beginning of the function.

*/

void __interrupt __saveds scroll()

{
   int stick,x=0,diff,velocity=1,shift=0;
   static int x_offset=0,dir_right=1,flop=0,page=0;

   flop++;
   if (flop < FRAME_RATE)         /* check against frame rate */
      return;                     /* if not time to scroll, abort */
   flop=0;
   stick = _gs_joystick(1);      /* poll joystick */
   if (stick & (JOY_LEFT|JOY_RIGHT|JOY_BUTTON1))
      {                           /* if joystick value we're concerned with */
      velocity*=3;               /* increase velocity */
      if (stick & JOY_BUTTON1)   /* button holds display */
         velocity=0;
      if (stick & JOY_LEFT)
         x=-velocity;
      else if (stick & JOY_RIGHT)
         x=velocity;
      }
   else
      {
      if (dir_right)      /* if scrolling right */
         {
         x=velocity;
         }
      else               /* else scrolll left */
         {
         x=-velocity;
         }
      }
   x_offset+=x;
   if ((x_offset + DISPLAY_SIZE) >= VS_X)      /* check against scroll boundaries */
      {                                       /* don't go past virtual space used by anims */
      dir_right=0;
      x_offset=VS_X-DISPLAY_SIZE;;
      x=0;
      }
   else if (x_offset < 0)
      {
      dir_right=1;
      x_offset=0;
      x=0;
      }
   if (x)
      {
      diff=vp.xoff+x-BMOFFSET;
      if (diff < 0)                           /* if past beginning of actual bitmap */
         {
         x=(PAGE_SIZE-DISPLAY_SIZE)+x;         /* shift to end of bitmap & keep scrolling */
         shift=1;                              /* this provides a seemless transition, and */
         if (!page)
            {
            reset=1;
            rs_offset-=PAGE_SIZE-DISPLAY_SIZE;
            window=PAGE_SIZE-DISPLAY_SIZE;   /* adjust real space window */
            }
         page=0;
         }                                    /* gives the illusion of an infinite horizon */
      else if (((diff-velocity) < 0))         /* early warning system. :) */
         {                                    /* notify main program of upcoming bitmap shift */
         if ((x_offset-velocity) > 0)
            {
            rs_offset-=PAGE_SIZE-DISPLAY_SIZE;
            window=PAGE_SIZE-DISPLAY_SIZE;   /* adjust real space window */
            reset=1;                           /* flag to reset bitmap pointers */
            page=1;
            }
         }
      else if (diff >= (PAGE_SIZE-DISPLAY_SIZE))
         {
         x=-((PAGE_SIZE-DISPLAY_SIZE)-x);
         shift=1;
         if (!page)
            {
            reset=1;
            rs_offset+=PAGE_SIZE-DISPLAY_SIZE;
            window=0;                        /* adjust real space window */
            }
         page=0;
         }
      else if ((diff+velocity) >= (PAGE_SIZE-DISPLAY_SIZE))
         {                                    /* notify main program of upcoming bitmap shift */
         if ((x_offset+velocity+DISPLAY_SIZE) < VS_X)
            {
            rs_offset+=PAGE_SIZE-DISPLAY_SIZE;
            window=0;                        /* adjust real space window */
            reset=1;                           /* flag to reset bitmap pointers */
            page=1;
            }
         }
      if (!shift)
         gs_rs_window(dlist,diff,0);         /* scroll real space window over bitmap */
      gs_scroll_vp(&display,0,x,0,1);         /* scroll the display during next VB */
      }
}

/***************************************************************************/
/*
   This function creates the display, loads the background picture, loads
   all anim objects, allocates a display list for the animation system,
   adds all objects to the list, draws the objects in the display, shows
   the GDS display, and then installs the scroller.
*/

int setup()

{
   int cnt=0;
   struct anim_load_struct load;

   switch (gs_chiprev())   /* set hard left display offset depending on chipset */
      {
      case AGA_CHIPREV:
         if (GfxBase->LibNode.lib_Version >= 36)   /* if WB 2.0 or higher */
            display.DxOffset=0x87;
         else
            display.DxOffset=0;
         break;
      default:
         if (GfxBase->LibNode.lib_Version >= 36)   /* if WB 2.0 or higher */
            display.DxOffset=0x77;
         else
            display.DxOffset=0;
         break;
      }
   gs_get_ILBM_bm(&loadpic);         /* load color table from picture file */
   #ifdef NTSC_MONITOR_ID
      if (GfxBase->LibNode.lib_Version >= 36)   /* if WB 2.0 or higher */
         {               /* this defeats mode promotion on AGA machines */
         if (ModeNotAvailable(NTSC_MONITOR_ID))
            {
            display.modes = PAL_MONITOR_ID;
            }
         else
            {
            display.modes = NTSC_MONITOR_ID;
            }
         }
   #endif
   if (gs_create_display(&display))
      {
      return(-1);
      }
   loadpic.bitmap1=vp.bitmap1;      /* tell picture loader where to put picture */
   loadpic.bitmap2=vp.bitmap2;      /* fill both bitmaps with background picture */
   while (cnt < PAGE_SIZE)      /* stagger the picture continously across bitmap width */
      {
      loadpic.loadx=(BMOFFSET+cnt)/8;
      if (gs_loadILBM(&loadpic))
         {
         gs_remove_display(&display);
         return(-2);
         }
      cnt+=bmh.w;                     /* add width of picture to load offset */
      }
   load.flags=ANIMLOAD_NOCOLOR;      /* don't allocate a color table */
   load.cmap_size=8;                  /* number of bits per color value */
   load.array_elements=ANIM_COUNT;   /* number of array elements desired */
   load.filename="anim/rollcrab.anim";   /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(-3);
      }
   rollcrab=load.anim_ptr.anim;      /* ptr to anim object */
   load.filename="anim/coral1.anim";   /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(-3);
      }
   coral1=load.anim_ptr.anim;         /* ptr to anim object */
   load.filename="anim/coral2.anim";   /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(-3);
      }
   coral2=load.anim_ptr.anim;         /* ptr to anim object */
//   load.filename="anim/coral3.anim";   /* name of anim file */
//   if (gs_load_anim(&load))         /* load the anim object */
//      {
//      cleanup();
//      return(-3);
//      }
//   coral3=load.anim_ptr.anim;         /* ptr to anim object */
   load.filename="cplx/fish1.cplx";   /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(-4);
      }
   fish1=load.anim_ptr.cplx;         /* ptr to anim object */
   load.filename="cplx/fish2.cplx";   /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(-5);
      }
   fish2=load.anim_ptr.cplx;         /* ptr to anim object */
   load.filename="cplx/fish3.cplx";   /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(-6);
      }
   fish3=load.anim_ptr.cplx;         /* ptr to anim object */
   load.filename="cplx/aquadino.cplx";   /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(-7);
      }
   aquadino=load.anim_ptr.cplx;         /* ptr to anim object */
   if ((dlist=gs_get_display_list()) < 0)   /* allocate a display list for anims */
      {
      cleanup();
      return(-8);
      }
   gs_init_anim(dlist,vp.bitmap1,vp.bitmap2,NULL);   /* tell anim system about bitmaps */
   gs_rs_dim(dlist,DISPLAY_SIZE+(BMOFFSET*2),BMHEIGHT);   /* set new real space dimensions */
         /* define area in which anim objects will be allowed to wander */
   gs_set_anim_bounds(dlist,LEFT_BOUNDS,TOP_BOUNDS,RIGHT_BOUNDS,BOTTOM_BOUNDS);
   if (place_anim_bottom(rollcrab))   /* now place all anim objects in the virtual area */
      {
      cleanup();
      return(-10);
      }
   if (place_anim_bottom(coral1))
      {
      cleanup();
      return(-11);
      }
   if (place_anim_bottom(coral2))
      {
      cleanup();
      return(-12);
      }
//   if (place_anim_bottom(coral3))
//      {
//      cleanup();
//      return(-13);
//      }
   if (place_cplx_bottom(aquadino))
      {
      cleanup();
      return(-14);
      }
   if (place_cplx(fish1))
      {
      cleanup();
      return(-15);
      }
   if (place_cplx(fish2))
      {
      cleanup();
      return(-16);
      }
   if (place_cplx(fish3))
      {
      cleanup();
      return(-17);
      }
   gs_draw_anims(dlist);            /* actually draw anims in 2nd bitmap */
   check_bounds();                  /* check to see if any need to turn around */
   gs_next_anim_page(dlist);         /* tell animation system to use other bitmap next time */
   gs_show_display(&display,1);      /* show the display */
   gs_flip_display(&display,1);      /* flip to next bitmap page during next vertical blank */
   gs_open_vb_timer();               /* open the super efficient GDS vertical blank timer */
   gs_vb_timer_reset();
   while (!gs_vb_time());            /* sync gfx with display */
   gs_vb_timer_reset();               /* reset counter to zero */
   scroller=gs_add_vb_server(&scroll,0);   /* add scroller function to vertical blank server chain */
   if (!scroller)
      {
      cleanup();
      return(-9);
      }
   return(0);                        /* all went well */
}

/***************************************************************************/
/*
   Place a simple anim object on the see bottom
*/

int place_anim_bottom(anim)
struct anim_struct *anim;

{
   int cnt;

   for (cnt=0; cnt < ANIM_COUNT; cnt++)
      {
      anim[cnt].x = gs_random(VS_X);   /* random X,Y coords */
      anim[cnt].y = gs_random(BOTTOM_SPACE)+(BOTTOM_BOUNDS-BOTTOM_SPACE)-anim[cnt].height;
      anim[cnt].xa = gs_random(ANIM_SPEED) +1;   /* use xa field for object speed */
                                       /* we can do this since object is not attached to */
                                       /* anything, and the field would go unused otherwise */
      if (cnt&1)
         {
         anim[cnt].xa=-anim[cnt].xa;
         }
      anim[cnt].prio = anim[cnt].y+anim[cnt].height;   /* obj priority setting */
      if (gs_add_anim(dlist,(struct anim_struct *)&anim[cnt],anim[cnt].x,anim[cnt].y))
         {                           /* if can't add object to display list */
         return(-1);                  /* return failure */
         }
      gs_set_anim_cell((struct anim_struct *)&anim[cnt],gs_random(anim[cnt].count));
      }
   return(0);
}

/***************************************************************************/

int place_cplx_bottom(cplx)
struct anim_cplx *cplx;

{
   int cnt,seq,x,y;

   for (cnt=0; cnt < ANIM_COUNT; cnt++)
      {
      x = gs_random(VS_X);            /* random X,Y coords */
      y = gs_random(BOTTOM_SPACE)+(BOTTOM_BOUNDS-BOTTOM_SPACE)
         -cplx[cnt].height;
      seq=1;
      cplx[cnt].list->xa = gs_random(ANIM_SPEED) +1;   /* use xa field for object speed */
      if (cnt&1)
         {
         seq=0;
         cplx[cnt].list->xa=-cplx[cnt].list->xa;
         }
      if (gs_add_anim_cplx(dlist,(struct anim_cplx *)&cplx[cnt],x,y,seq,y+cplx[cnt].height))
         {                           /* if can't add object to display list */
         return(-1);                  /* return failure */
         }
      gs_set_cplx_cell((struct anim_cplx *)&cplx[cnt],
         gs_random(cplx[cnt].list->count));
      }
   return(0);
}

/***************************************************************************/

int place_cplx(cplx)
struct anim_cplx *cplx;

{
   int cnt,seq,x,y,pre_y;

   pre_y = BOTTOM_BOUNDS-TOP_BOUNDS+12-cplx->height;
   for (cnt=0; cnt < ANIM_COUNT; cnt++)
      {
      x = gs_random(VS_X);            /* random X,Y coords */
      y = gs_random(pre_y)+TOP_BOUNDS;
      seq=1;
      cplx[cnt].list->xa = gs_random(ANIM_SPEED) +1;   /* use xa field for object speed */
      if (cnt&1)
         {
         seq=0;
         cplx[cnt].list->xa=-cplx[cnt].list->xa;
         }
      if (gs_add_anim_cplx(dlist,(struct anim_cplx *)&cplx[cnt],x,y,seq,y+cplx[cnt].height))
         {                           /* if can't add object to display list */
         return(-1);                  /* return failure */
         }
      gs_set_cplx_cell((struct anim_cplx *)&cplx[cnt],
         gs_random(cplx[cnt].list->count));
      }
   return(0);
}

/***************************************************************************/
/*
   This handles movement & animation of all objects.  It also continuously
   redraws all objects in case the bitmap pointers have been reset (see the
   scroll routine).
*/

void move_creatures()

/* move & animate everything */

{
   unsigned long time;

   if (reset)                           /* if bitmap pointers being reset */
      {
      reset=0;
      gs_rs_offset(dlist,rs_offset,0);   /* adjust real space offset for anims */
      gs_rs_window(dlist,window,0);      /* adjust real space window over bitmap */
      }
   time = gs_vb_time();                  /* get value of vertical blank timer */
   if (time >= VB_DELAY)               /* don't go too fast */
      {
      gs_vb_timer_reset();               /* reset vertical blank timer */
      move_anim(rollcrab);
      move_cplx(aquadino);
      move_cplx(fish1);
      move_cplx(fish2);
      move_cplx(fish3);
      while (display.flags & GSV_FLIP); /* while page not flipped yet */
      gs_draw_anims(dlist);            /* draw them anim objects! */
      gs_flip_display(&display,1);      /* switch to other display, sync */
      gs_next_anim_page(dlist);         /* tell anim sys to use other bitmap */
      check_bounds();                  /* turn around at virtual space bounds */
      }
   else
      {
      while (display.flags & GSV_FLIP); /* while page not flipped yet */
      gs_draw_anims(dlist);            /* draw them anim objects! */
      gs_flip_display(&display,1);      /* switch to other display, sync */
      gs_next_anim_page(dlist);         /* tell anim sys to use other bitmap */
      }
}

/***************************************************************************/

void move_anim(anim)
struct anim_struct *anim;

{
   int cnt;

   for (cnt=0; cnt < ANIM_COUNT; cnt++)
      {
      anim[cnt].y+=anim[cnt].xa;
      gs_anim_obj((struct anim_struct *)&anim[cnt],anim[cnt].x,anim[cnt].y);
      }
}

/***************************************************************************/

void move_cplx(cplx)
struct anim_cplx *cplx;

{
   int cnt,x;

   for (cnt=0; cnt < ANIM_COUNT; cnt++)
      {
      x=cplx[cnt].anim->x+cplx[cnt].list->xa;   /* move the object */
      gs_anim_cplx((struct anim_cplx *)&cplx[cnt],x,cplx[cnt].anim->y);
      }
}

/***************************************************************************/

void check_bounds()

{
   check_anim_bounds(rollcrab);
   check_cplx_bounds(aquadino);
   check_cplx_bounds(fish1);
   check_cplx_bounds(fish2);
   check_cplx_bounds(fish3);
}

/***************************************************************************/
/*
   This function checks against top & bottom boundaries for the rollcrab, and
   reverses direction accordingly.
*/

void check_anim_bounds(anim)
struct anim_struct *anim;

{
   int cnt;

   for (cnt=0; cnt < ANIM_COUNT; cnt++)
      {
      if (anim[cnt].flags & (ANIM_BOUNDS_Y1|ANIM_BOUNDS_Y2))
         {
         anim[cnt].xa=-anim[cnt].xa;   /* reverse X direction */
         }
      }
}

/***************************************************************************/
/*
   This function checks against left & right boundaries for all other
   creatures, and reverses direction accordingly.
*/

void check_cplx_bounds(cplx)
struct anim_cplx *cplx;

{
   int cnt;

   for (cnt=0; cnt < ANIM_COUNT; cnt++)
      {
      if (cplx[cnt].anim->flags & (ANIM_BOUNDS_X1|ANIM_BOUNDS_X2))
         {
         cplx[cnt].list->xa=-cplx[cnt].list->xa;   /* reverse X direction */
         gs_set_cplx_seq((struct anim_cplx *)&cplx[cnt],cplx[cnt].seq^1,
            cplx[cnt].anim->x,cplx[cnt].anim->y);
         }
      }
}

/***************************************************************************/

int check_close()

/* check for left mouse button click */

{
   if (gs_joystick(0) & (JOY_BUTTON1|JOY_BUTTON2))
      return(1);
   return(0);
}

/***************************************************************************/

void cleanup()

/* release all resources and memory */

{
   gs_close_vb_timer();
   if (dlist > -1)
      gs_free_display_list(dlist);
   if (scroller)
      gs_remove_vb_server(scroller);
   if (rollcrab)
      gs_free_anim(rollcrab,ANIM_COUNT);
   if (coral1)
      gs_free_anim(coral1,ANIM_COUNT);
   if (coral2)
      gs_free_anim(coral2,ANIM_COUNT);
   if (coral3)
      gs_free_anim(coral3,ANIM_COUNT);
   if (fish1)
      gs_free_cplx(fish1,ANIM_COUNT);
   if (fish2)
      gs_free_cplx(fish2,ANIM_COUNT);
   if (fish3)
      gs_free_cplx(fish3,ANIM_COUNT);
   if (aquadino)
      gs_free_cplx(aquadino,ANIM_COUNT);
   gs_remove_display(&display);
}

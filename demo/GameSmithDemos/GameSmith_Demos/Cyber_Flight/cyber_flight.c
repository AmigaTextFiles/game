/* Circuit Shootem Up - a GameSmith Demo.  AGA Enhanced! */
/*
   This program demonstrates use of AGA 7 bitplane dual playfield independent
   scrolling (4 planes for playfield 1, and 3 for playfield 2).  I was gonna
   use 8 bitplanes total, but any colors I added to the 2nd playfield just
   detracted from the graphics.  I guess that's why I'm a programmer and
   not a graphic artist. <grin>  The demo also uses a split screen as is
   commonly found in many shoot'em up type games.  The bottom panel doesn't
   do anything.  It's just there as an example.  -John Enright 4-15-94

   8-24-94 Enhanced to automatically scale down the 1st playfield so that the
   demo will actually run on older machines.  The 1st playfield looks a little
   goofy, but it does work.

*/

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

#define BMWIDTH   640
#define BMHEIGHT   400

#define PF1_PLANES   0x55;
#define PF2_PLANES   0xaa;
#define ALL_PLANES   0xff;

/*-------------------------------------------------------------------------*/
/* Function Prototypes                                                      */

void scroll(void);
int setup(void);
int check_close(void);
void cleanup(void);

/*-------------------------------------------------------------------------*/
/* some global variables                                                   */

struct Interrupt *scroller=NULL;
unsigned long color[48];

/*-------------------------------------------------------------------------*/

struct loadILBM_struct loadpic =
   {
   NULL,               /* ptr to picture name string */
   NULL,               /* ptr to 1st bitmap */
   NULL,               /* ptr to 2nd bitmap (if any) */
   color,            /* ptr to color table array */
   16,               /* # colors in color table */
   NULL,               /* height of image in pixels (filled by load call) */
   NULL,               /* width of image in pixels (filled) */
   NULL,               /* x display offset (filled) */
   NULL,               /* y display offset (filled) */
   NULL,               /* pic mode (filled) */
   0,                  /* x load offset (from left) in bytes */
   0,                  /* y load offset (from top) in rows */
   ILBM_COLOR,         /* flags (fill color table) */
   0xff,               /* bitplane fill mask */
   0xff,               /* bitplane load mask */
   NULL               /* address of BitMapHeader to fill (none) */
   };

struct gs_viewport vp2 =
   {
   NULL,                           /* ptr to next viewport */
   &color[32],                     /* ptr to color table */
   16,                           /* number of colors in table */
   NULL,                           /* ptr to user copper list */
   47,320,4,47,320,               /* height, width, depth, bmheight, bmwidth */
   153,0,                        /* top & left viewport offsets */
   0,0,                           /* X & Y bitmap offsets */
   GSVP_ALLOCBM,                  /* flags (alloc bitmaps) */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   NULL,NULL,                     /* bitmap pointers */
   NULL,                           /* future expansion */
   0,0,0,0                        /* display clip (MinX,MinY,MaxX,MaxY) */
   };

struct gs_viewport vp =
   {
   &vp2,                           /* ptr to next viewport */
   color,                        /* ptr to color table */
   32,                           /* number of colors in table */
   NULL,                           /* ptr to user copper list */
   150,320,7,BMHEIGHT,BMWIDTH,   /* height, width, depth, bmheight, bmwidth */
   0,0,                           /* top & left viewport offsets */
   0,0,                           /* X & Y bitmap offsets */
   GSVP_DPF|GSVP_ALLOCBM,          /* flags (dual playfield,alloc bitmaps) */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   NULL,NULL,                     /* bitmap pointers */
   NULL,                           /* future expansion */
   0,0,0,0                        /* display clip (MinX,MinY,MaxX,MaxY) */
   };

struct display_struct display =
   {
   NULL,                           /* ptr to previous display view */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   0x87,0,                        /* X and Y display offsets (fix left offset) */
   0,                              /* display mode ID */
   4,4,                           /* sprite priorities */
   GSV_SCROLLABLE|GSV_HARDX,      /* flags (scrollable) */
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
      end=check_close();      /* end when user hits left mouse button */
      }
   Permit();                  /* OK, let other things run while we clean up */
   cleanup();                  /* close & deallocate everything */
   gs_close_libs();            /* close all libraries */
}

/***************************************************************************/

void __interrupt __saveds scroll()

{
   int stick,x=0,y=0,diff,velocity=2,x2,y2;
   static int timer=0;
   static int x_save=0,y_save=0;

   stick = _gs_joystick(1);
   if (stick & (JOY_LEFT|JOY_RIGHT|JOY_UP|JOY_DOWN))
      {
      if (stick & JOY_BUTTON1)
         velocity<<=1;
      if (stick & JOY_LEFT)
         x=velocity*-1;
      else if (stick & JOY_RIGHT)
         x=velocity;
      if (stick & JOY_UP)
         y=velocity*-1;
      else if (stick & JOY_DOWN)
         y=velocity;
      timer=0;
      }
   else if (timer++ >= (60*5))               /* 5 second timeout */
      {
      x=x_save;
      y=y_save;
      if (!x_save)
         {
         x=_gs_random(3)+2;
         if (_gs_random(100) < 50)
            x*=-1;
         x_save=x;
         }
      else if (_gs_random(1000) < 10)
         {
         x=_gs_random(3)+2;
         if (_gs_random(100) < 50)
            x*=-1;
         x_save=x;
         }
      if (!y_save)
         {
         y=_gs_random(2)+2;
         if (_gs_random(100) < 50)
            y*=-1;
         y_save=y;
         }
      else if (_gs_random(1000) < 10)
         {
         y=_gs_random(2)+2;
         if (_gs_random(100) < 50)
            y*=-1;
         y_save=y;
         }
      }
   if (x || y)
      {
      x2=x;
      y2=y;
      diff=vp.xoff+x;
      if (diff < 0)
         x=(BMWIDTH>>1)+x;
      else if ((diff+vp.width) >= BMWIDTH)
         x=-((BMWIDTH>>1)-x);
      diff=vp.yoff+y;
      if (diff < 0)
         y=(BMHEIGHT>>1)+y;
      else if ((diff+vp.height) >= BMHEIGHT)
         y=-((BMHEIGHT>>1)-y);
      gs_scroll_vp_pf1(&display,0,x,y,1);   /* scroll viewport 0, synchronize */
      x=x2>>1;
      y=y2>>1;
      diff=vp.xoff2+x;
      if (diff < 0)
         x=(BMWIDTH>>1)+x;
      else if ((diff+vp.width) >= BMWIDTH)
         x=-((BMWIDTH>>1)-x);
      diff=vp.yoff2+y;
      if (diff < 0)
         y=(BMHEIGHT>>1)+y;
      else if ((diff+vp.height) >= BMHEIGHT)
         y=-((BMHEIGHT>>1)-y);
      gs_scroll_vp_pf2(&display,0,x,y,1);   /* scroll viewport 0, synchronize */
      }
}

/***************************************************************************/

int setup()

{
   int chipset;

   chipset=gs_chiprev();
   switch (chipset)         /* set hard left display offset depending on chipset */
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
         vp.depth=6;       /* if not AGA, max depth of 6 bitplanes */
         break;
      }
   loadpic.bitmap1=NULL;   /* no bitmap to fill.  NOTE: this will cause an error return */
   loadpic.bitmap2=NULL;   /* but the color table is still filled */
   loadpic.file="gfx/pf1.pic";
   gs_get_ILBM_bm(&loadpic);         /* get color table */
   loadpic.file="gfx/pf2.pic";
   if (chipset == AGA_CHIPREV)
      loadpic.color_table=&color[16];   /* load 2nd playfield colors */
   else
      loadpic.color_table=&color[8];   /* load 2nd playfield colors */
   loadpic.num_colors=16;            /* must reset after each load */
   gs_get_ILBM_bm(&loadpic);         /* get color table */
   loadpic.file="gfx/dashboard.brush";
   loadpic.color_table=&color[32];   /* load 2nd viewport colors */
   loadpic.num_colors=16;            /* must reset after each load */
   gs_get_ILBM_bm(&loadpic);         /* get color table */
   #ifdef NTSC_MONITOR_ID
      display.modes = NTSC_MONITOR_ID;
   #endif
   if (gs_create_display(&display))
      {
      return(-1);
      }
   loadpic.flags=0;                  /* don't load color table */
   loadpic.file="gfx/pf1.pic";
   loadpic.bitmap1=vp.bitmap1;      /* address of bitmap to fill */
   loadpic.fill=PF1_PLANES;
   gs_loadILBM(&loadpic);            /* load the picture! */
   loadpic.file="gfx/pf2.pic";
   loadpic.fill=PF2_PLANES;
   gs_loadILBM(&loadpic);            /* load the picture! */
   loadpic.file="gfx/dashboard.brush";
   loadpic.bitmap1=vp2.bitmap1;      /* address of bitmap to fill */
   loadpic.fill=ALL_PLANES;;
   gs_loadILBM(&loadpic);            /* load the picture! */
   scroller=gs_add_vb_server(&scroll,0);
   if (!scroller)
      {
      gs_remove_display(&display);
      return(-2);
      }
   gs_show_display(&display,1);      /* show the display */
   return(0);
}

/***************************************************************************/

int check_close()

/* check for user input */

{
   if (gs_joystick(0) & (JOY_BUTTON1|JOY_BUTTON2))
      return(1);
   return(0);
}

/***************************************************************************/

void cleanup()

/* release all resources and memory */

{
   if (scroller)
      gs_remove_vb_server(scroller);
   gs_remove_display(&display);
}

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

#define PVP_FIELDS   8      /* 7 parallax viewport fields */
#define CLOUDS         5      /* 1st 5 parallax fields are clouds */
#define SPVP_HEIGHT   40      /* height of bottom field */
#define COLOR_STEPS   26      /* number of color changes to background */
#define SCROLL_SPEED   2      /* number of pixels to scroll foreground playfield */
#define BOTTOM_SPEED 8      /* scroll speed at bottom of display */

#define SHEIGHT   200      /* screen height */
#define SWIDTH      320      /* screen width */

/*-------------------------------------------------------------------------*/
/* Function Prototypes                                                      */

void scan_copper(void);

int setup(void);
int load_gfx(void);
void build_copper(void);
void user_input(void);
int check_close(void);
void cleanup(void);
void dealloc(void);

/*-------------------------------------------------------------------------*/
/* some global variables                                                   */

int smode,copheight=200,red=16,green=96,blue=255,chipset,left,right;

unsigned char cloud_move[CLOUDS]={1,1,1,1,1};
unsigned char cloud_rate[CLOUDS]={0,1,2,3,4};
unsigned char cloud_count[CLOUDS]={0,0,0,0,0};

unsigned short copper_list[2048];

unsigned long color[PVP_FIELDS][8];

unsigned char *pic_names[]={         /* names of gfx files to load */
   "gfx/cloud1.brush",
   "gfx/cloud2.brush",
   "gfx/cloud3.brush",
   "gfx/cloud4.brush",
   "gfx/cloud5.brush",
   "gfx/mtn.brush",
   "gfx/fence.brush",
   "gfx/marsh.brush"
   };

BitMapHeader bmh;

struct loadILBM_struct loadpic =
   {
   NULL,               /* ptr to picture name string */
   NULL,               /* ptr to 1st bitmap */
   NULL,               /* ptr to 2nd bitmap (if any) */
   NULL,               /* ptr to color table array */
   0,                  /* # colors in color table */
   NULL,               /* height of image in pixels (filled by load call) */
   NULL,               /* width of image in pixels (filled) */
   NULL,               /* x display offset (filled) */
   NULL,               /* y display offset (filled) */
   NULL,               /* pic mode (filled) */
   0,                  /* x load offset (from left) in bytes */
   0,                  /* y load offset (from top) in rows */
   ILBM_COLOR|ILBM_ALLOC1,   /* flags (fill color table, alloc 1 bitmap) */
   0xff,               /* bitplane fill mask */
   0xff,               /* bitplane load mask */
   &bmh               /* address of BitMapHeader to fill */
   };

struct gs_pvp pvp[PVP_FIELDS-1];

long scolor[8*SPVP_HEIGHT];
unsigned short clist[]={0,9,10,11,12,13,14,15};      /* color reg list for reload */

struct gs_spvp spvp =         /* sliced parallax viewport */
   {
   1,3,                        /* top & bottom scroll rates */
   0,0,0,                     /* height, width, depth */
   PVP_DPF|PVP_DPF2,          /* flags (dual playfield, only load & scroll pf2) */
   NULL,NULL,                  /* ptr to bitmap(s) */
   NULL,                        /* ptr to color table of values to modify each line */
   clist,                     /* ptr to list of regs to modify each line */
   8,                           /* number of regs in list */
   0,                           /* scroll type */
   0,0,                        /* system stuff */
   NULL                        /* no parallax viewports in list yet */
   };

struct gs_spvp spvp2 =         /* sliced parallax viewport */
   {
   3,BOTTOM_SPEED,            /* top & bottom scroll rates */
   0,0,0,                     /* height, width, depth */
   PVP_DPF|PVP_DPF2,          /* flags (dual playfield, only load & scroll pf2) */
   NULL,NULL,                  /* ptr to bitmap(s) */
   NULL,                        /* ptr to color table of values to modify each line */
   clist,                     /* ptr to list of regs to modify each line */
   8,                           /* number of regs in list */
   0,                           /* scroll type */
   0,0,                        /* system stuff */
   NULL                        /* no parallax viewports in list yet */
   };

unsigned long fore_color[8];

struct gs_viewport vp =
   {
   NULL,                           /* ptr to next viewport */
   fore_color,                     /* ptr to color table */
   8,                              /* number of colors in table */
   copper_list,                  /* ptr to user copper list (none) */
   SHEIGHT,SWIDTH,6,0,0,         /* height, width, depth, bmheight, bmwidth */
   0,0,                           /* top & left viewport offsets */
   0,0,                           /* X & Y bitmap offsets */
   GSVP_DPF|GSVP_NOWAIT,         /* flags */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   NULL,NULL,                     /* bitmap pointers */
   NULL,                           /* future expansion */
   0,0,0,0                        /* display clip (use nominal) */
   };

struct display_struct display =
   {
   NULL,                           /* ptr to previous display view */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   0,0,                           /* X and Y display offsets (1.3 style) */
   0,                              /* display mode ID */
   4,4,                           /* sprite priorities (sprites in front of playfields) */
   GSV_SCROLLABLE|GSV_HARDX|     /* flags (double buffered, scrollable, hard X, */
   GSV_BRDRBLNK,                  /* blank borders) */
   &vp,                           /* ptr to 1st viewport */
   NULL                           /* future expansion */
   };

/***************************************************************************/

main(argc,argv)
int argc;
char *argv[];

{
   int err,end=0;

   if (gs_open_libs(DOS|GRAPHICS,0))   /* open AmigaDOS libs */
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
      user_input();            /* check user input & handle it */
      end=check_close();      /* end when user hits left mouse button */
      }
   Permit();                  /* OK, let other things run while we clean up */
   cleanup();                  /* close & deallocate everything */
   gs_close_libs();            /* close all libraries */
}

/***************************************************************************/

int setup()

{
   smode=0;               /* default mode of lores no lace, dual playfield */
   #ifdef NTSC_MONITOR_ID
      if (GfxBase->LibNode.lib_Version >= 36)   /* if WB 2.0 or higher */
         {               /* this defeats mode promotion on AGA machines */
         /* hardware doesn't allow dual playfield under double scanned display */
         if (ModeNotAvailable(NTSC_MONITOR_ID))
            {
            smode = PAL_MONITOR_ID;
            }
         else
            {
            smode = NTSC_MONITOR_ID;
            }
         }
   #endif
   chipset=gs_chiprev();
   switch (chipset)         /* set hard left display offset depending on chipset */
      {
      case AGA_CHIPREV:
         if (GfxBase->LibNode.lib_Version >= 36)   /* if WB 2.0 or higher */
            display.DxOffset=0x85;
         else
            display.DxOffset=0;
         break;
      default:
         if (GfxBase->LibNode.lib_Version >= 36)   /* if WB 2.0 or higher */
            display.DxOffset=0x77;
         else
            display.DxOffset=0;
         left=0x39;
         right=0xdf;
         break;
      }
   if (load_gfx())
      {
      dealloc();
      printf("\nError loading graphics\n");
      return(-1);
      }
   if (gs_alloc_spvp(&spvp))
      {
      dealloc();
      printf("\nInsufficient Memory for Sliced Parallax Viewport\n");
      return(-2);
      }
   if (gs_alloc_spvp(&spvp2))
      {
      printf("\nInsufficient Memory for Sliced Parallax Viewport\n");
      dealloc();
      return(-3);
      }
   display.modes = smode;
   build_copper();
   if (gs_create_display(&display))
      {
      dealloc();
      printf("\nUnable to Set Up Display\n");
      return(-3);
      }
   gs_open_vb_timer();
   gs_show_display(&display,1);      /* show display, sync */
   return(0);
}

/***************************************************************************/

int load_gfx()

{
   int cnt,cnt2,cnt3=0,r,g,b;
   static struct BitMap bm;

   loadpic.file="gfx/forest.brush";      /* name of file to load */
   loadpic.color_table=fore_color;      /* ptr to color table to fill */
   loadpic.num_colors=8;               /* each field is 3 bitplanes deep maximum */
   if (gs_loadILBM(&loadpic))
      {
      return(-1);
      }
   vp.bitmap1=loadpic.bitmap1;
   vp.bitmap1->Planes[5]=vp.bitmap1->Planes[0];
   vp.bitmap1->Planes[4]=vp.bitmap1->Planes[2];   /* readjust for dual playfield */
   vp.bitmap1->Planes[3]=vp.bitmap1->Planes[0];
   vp.bitmap1->Planes[2]=vp.bitmap1->Planes[1];
   vp.bitmap1->Depth=6;
   vp.bmwidth=bmh.w;                     /* actual width of bitmap */
   for (cnt=0; cnt < PVP_FIELDS; cnt++)
      {
      loadpic.file=pic_names[cnt];         /* name of file to load */
      loadpic.color_table=&color[cnt][0];   /* ptr to color table to fill */
      loadpic.num_colors=8;               /* each field is 3 bitplanes deep maximum */
      if (gs_loadILBM(&loadpic))
         {
         return(-1);
         }
      if ((cnt+1) < PVP_FIELDS)
         {
         pvp[cnt].bitmap[0]=loadpic.bitmap1;
         pvp[cnt].bitmap[1]=loadpic.bitmap1;
         pvp[cnt].depth=loadpic.bitmap1->Depth;
         pvp[cnt].height=bmh.h;
         pvp[cnt].width=bmh.w;
         pvp[cnt].flags=PVP_DPF|PVP_DPF2;
         }
      else                                 /* last field is the sliced parallax viewport */
         {                                 /* we need to split it & squeeze in fence reload */
         spvp.bitmap[0]=loadpic.bitmap1;
         spvp.bitmap[1]=loadpic.bitmap1;
         spvp.depth=loadpic.bitmap1->Depth;
         spvp.height=14;
         spvp.width=bmh.w;
         bm.Depth=loadpic.bitmap1->Depth;   /* pick up where previous spvp left off */
         bm.Flags=loadpic.bitmap1->Flags;   /* (continue spvp below top of fence) */
         bm.Rows=25;                        /* 40 - height1 - 1 line for fence load */
         bm.BytesPerRow=loadpic.bitmap1->BytesPerRow;
         bm.Planes[0]=loadpic.bitmap1->Planes[0]+(bm.BytesPerRow*15);
         bm.Planes[1]=loadpic.bitmap1->Planes[1]+(bm.BytesPerRow*15);
         bm.Planes[2]=loadpic.bitmap1->Planes[2]+(bm.BytesPerRow*15);
         bm.Planes[3]=loadpic.bitmap1->Planes[3]+(bm.BytesPerRow*15);
         bm.Planes[4]=loadpic.bitmap1->Planes[4]+(bm.BytesPerRow*15);
         bm.Planes[5]=loadpic.bitmap1->Planes[5]+(bm.BytesPerRow*15);
         bm.Planes[6]=loadpic.bitmap1->Planes[6]+(bm.BytesPerRow*15);
         bm.Planes[7]=loadpic.bitmap1->Planes[7]+(bm.BytesPerRow*15);
         spvp2.bitmap[0]=&bm;
         spvp2.bitmap[1]=&bm;
         spvp2.depth=loadpic.bitmap1->Depth;
         spvp2.height=25;
         spvp2.width=bmh.w;
         }
      }
   pvp[PVP_FIELDS-2].flags = PVP_DPF|PVP_DPF1;   /* fence is in playfield 1 (foreground) */
   spvp.ctable=(unsigned long *)scolor;   /* pointer to color table */
   spvp2.ctable=(unsigned long *)&scolor[15*8];
   for (cnt=0; cnt < SPVP_HEIGHT; cnt++)   /* dim the grass color from bottom to top */
      {
      for (cnt2=0; cnt2 < 8; cnt2++)
         {
         r=(color[PVP_FIELDS-1][cnt2]>>20)&0x0f;
         g=(color[PVP_FIELDS-1][cnt2]>>12)&0x0f;
         b=(color[PVP_FIELDS-1][cnt2]>>4)&0x0f;
         r-=cnt/6;
         g-=cnt/6;
         b-=cnt/6;
         if (r < 0)
            r=0;
         if (g < 0)
            g = 0;
         if (b < 0)
            b=0;
         scolor[cnt3++]=(r<<20)|(g<<12)|(b<<4);
         }
      }
   return(0);
}

/***************************************************************************/
/* NOTE: The AGA and ECS chipset can blank the border area, but the OCS
   chipset cannot.  In this case, we must turn color 0 on and off every line
   in sync with the display window (sigh). */

void build_copper()

/* build a custom copper list of background color changes */

{
   int cnt,cnt2=0,top=0,cnt3=0,cnt4,height,change=0;
   unsigned char line=0,do_color=0;
   struct BitMap *bm;

   height=SHEIGHT-spvp.height-spvp2.height-1; /* height of copper background color change area */
   copper_list[cnt2++]=UC_PVP;         /* add parallax viewport */
   copper_list[cnt2++]=top;            /* y coord to wait on */
   copper_list[cnt2++]=(unsigned long)&pvp[cnt3]>>16;   /* address of parallax viewport */
   copper_list[cnt2++]=(unsigned short)&pvp[cnt3];
   if (chipset == OCS_CHIPREV)         /* delay if OCS */
      {                                 /* need to sync with left of display */
      copper_list[cnt2++]=UC_WAIT;
      copper_list[cnt2++]=0;            /* y coord to wait on */   
      copper_list[cnt2++]=left;         /* x coord */
      }
   copper_list[cnt2++]=UC_SETCOLOR;
   copper_list[cnt2++]=0;
   copper_list[cnt2++]=((red&0xf0)<<4)|(green&0xf0)|((blue&0xf0)>>4);
   bm=pvp[cnt3].bitmap[0];
   for (cnt=1; cnt < (1<<bm->Depth); cnt++)
      {
      copper_list[cnt2++]=UC_SETCOLOR;
      copper_list[cnt2++]=cnt+8;
      copper_list[cnt2++]=((color[cnt3][cnt]>>12)&0x0f00)|((color[cnt3][cnt]>>8)&0x00f0)|
         ((color[cnt3][cnt]>>4)&0x0f);   /* 24 bit color value to old 12 bit color value */
      }
   top+=pvp[cnt3++].height;
   for (cnt4=0; cnt4 < height; cnt4++)
      {
      if (change > (height/COLOR_STEPS))
         {
         change=0;
         line++;
         if (line < 15)
            {
            red+=16;
            blue-=16;
            }
         else
            {
            green+=16;
            }
         do_color=1;
         }
      change++;
      if (cnt4 == top) /* a PVP event *MUST* come before anything else on the line!!!! */
         {
         copper_list[cnt2++]=UC_PVP;      /* add parallax viewport */
         copper_list[cnt2++]=top;         /* y coord to wait on */
         copper_list[cnt2++]=(unsigned long)&pvp[cnt3]>>16;   /* address of parallax viewport */
         copper_list[cnt2++]=(unsigned short)&pvp[cnt3];
         if (chipset == OCS_CHIPREV)      /* delay if OCS */
            {                              /* need to sync with left of display */
            copper_list[cnt2++]=UC_WAIT;
            copper_list[cnt2++]=cnt4;      /* y coord to wait on */   
            copper_list[cnt2++]=left;      /* x coord */
            }
         copper_list[cnt2++]=UC_SETCOLOR;
         copper_list[cnt2++]=0;
         copper_list[cnt2++]=((red&0xf0)<<4)|(green&0xf0)|((blue&0xf0)>>4);
         bm=pvp[cnt3].bitmap[0];
         for (cnt=1; cnt < (1<<bm->Depth); cnt++)
            {
            copper_list[cnt2++]=UC_SETCOLOR;
            copper_list[cnt2++]=cnt+8;
            copper_list[cnt2++]=((color[cnt3][cnt]>>12)&0x0f00)|((color[cnt3][cnt]>>8)&0x00f0)|
               ((color[cnt3][cnt]>>4)&0x0f);   /* 24 bit color value to old 12 bit color value */
            }
         top+=pvp[cnt3++].height;
         }
      else
         {
         switch (chipset)
            {
            case AGA_CHIPREV:         /* borders are blanked under AGA/ECS, so don't worry */
            case ECS_CHIPREV:       /* about color 0 overrun in border. :) */
               if (do_color)
                  {
                  copper_list[cnt2++]=UC_WAIT;
                  copper_list[cnt2++]=cnt4;         /* y coord to wait on */   
                  copper_list[cnt2++]=0;            /* x coord */
                  }
               break;
            default:                  /* for OCS, need to turn background color */
               do_color=1;            /* on & off at start & end of each line! (ugh) */
               copper_list[cnt2++]=UC_WAIT;
               copper_list[cnt2++]=cnt4;         /* y coord to wait on */   
               copper_list[cnt2++]=left;         /* x coord */
               break;
            }
         if (do_color)
            {
            copper_list[cnt2++]=UC_SETCOLOR;
            copper_list[cnt2++]=0;
            copper_list[cnt2++]=((red&0xf0)<<4)|(green&0xf0)|((blue&0xf0)>>4);
            do_color=0;
            }
         }
      if (chipset == OCS_CHIPREV)
         {
         copper_list[cnt2++]=UC_WAIT;
         copper_list[cnt2++]=cnt4;         /* y coord to wait on */   
         copper_list[cnt2++]=right;         /* x coord */
         copper_list[cnt2++]=UC_SETCOLOR;
         copper_list[cnt2++]=0;
         copper_list[cnt2++]=0;
         }
      }
   copper_list[cnt2++]=UC_SPVP;      /* add sliced parallax viewport */
   copper_list[cnt2++]=top;         /* y coord to wait on */
   copper_list[cnt2++]=(unsigned long)&spvp>>16;   /* address of parallax viewport */
   copper_list[cnt2++]=(unsigned short)&spvp;
   top+=spvp.height;
   copper_list[cnt2++]=UC_PVP;      /* add parallax viewport */
   copper_list[cnt2++]=top;         /* y coord to wait on */
   copper_list[cnt2++]=(unsigned long)&pvp[cnt3]>>16;   /* address of parallax viewport */
   copper_list[cnt2++]=(unsigned short)&pvp[cnt3];
   bm=pvp[cnt3].bitmap[0];
   for (cnt=1; cnt < (1<<bm->Depth); cnt++)
      {
      copper_list[cnt2++]=UC_SETCOLOR;
      copper_list[cnt2++]=cnt;
      copper_list[cnt2++]=((color[cnt3][cnt]>>12)&0x0f00)|((color[cnt3][cnt]>>8)&0x00f0)|
         ((color[cnt3][cnt]>>4)&0x0f);   /* 24 bit color value to old 12 bit color value */
      }
   top+=1;
   copper_list[cnt2++]=UC_SPVP;      /* add sliced parallax viewport */
   copper_list[cnt2++]=top;         /* y coord to wait on */
   copper_list[cnt2++]=(unsigned long)&spvp2>>16;   /* address of parallax viewport */
   copper_list[cnt2++]=(unsigned short)&spvp2;
   copper_list[cnt2++]=UC_SETCOLOR;
   copper_list[cnt2++]=0;
   copper_list[cnt2++]=0;
   copper_list[cnt2++]=UC_END;      /* end coppper list */
}

/***************************************************************************/

void user_input()

{
   int cnt,stick,x,x2,diff,temp;
   static char flop=0;

   if (!gs_vb_time())
      return;
   gs_vb_timer_reset();
   for (cnt=0; cnt < CLOUDS; cnt++)
      {
      if (cloud_count[cnt] == cloud_rate[cnt])
         {
         cloud_count[cnt]=0;
         gs_scroll_pvp(&display,&pvp[cnt],cloud_move[cnt],0);
         }
      else
         cloud_count[cnt]++;
      }
   stick = gs_joystick(1);
   if (stick & (JOY_LEFT|JOY_RIGHT))
      {
      if (stick & JOY_LEFT)
         {
         x=-1;
         x2=-SCROLL_SPEED;
         }
      else if (stick & JOY_RIGHT)
         {
         x=1;
         x2=SCROLL_SPEED;
         }
      diff=vp.xoff+x2;
      temp=vp.bmwidth-vp.width;
      if (diff < 0)
         x2=temp+x2;                           /* shift to end of bitmap */
      else if (diff > temp)
         x2=-(temp-x2);                        /* shift to beginning of bitmap */
      gs_scroll_vp_pf1(&display,0,x2,0,1);   /* scroll viewport 0, sync with VB */
      if (flop)
         gs_scroll_pvp(&display,&pvp[CLOUDS],x,0);   /* scroll mountains */
      flop^=1;
      if (x > 0)
         {
         gs_scroll_pvp(&display,&pvp[CLOUDS+1],BOTTOM_SPEED,0);   /* scroll fence */
         gs_spvp_right(&display,&spvp);
         gs_spvp_right(&display,&spvp2);
         }
      else
         {
         gs_scroll_pvp(&display,&pvp[CLOUDS+1],-BOTTOM_SPEED,0);   /* scroll fence */
         gs_spvp_left(&display,&spvp);
         gs_spvp_left(&display,&spvp2);
         }
      }
}

/***************************************************************************/

int check_close()

/* check for user input */

{
   if (gs_joystick(0) & (JOY_BUTTON1|JOY_BUTTON2))
      return(1);            /* either mouse button exits */
   return(0);
}

/***************************************************************************/

void cleanup()

/* release all resources and memory */

{
   dealloc();
   gs_remove_display(&display);
   gs_close_vb_timer();
}

/***************************************************************************/

void dealloc()

/* release gfx & other memory */

{
   int cnt;

   if (vp.bitmap1)
      {
      vp.bitmap1->Planes[2]=vp.bitmap1->Planes[4];   /* fix bitmap again */
      vp.bitmap1->Planes[5]=NULL;
      vp.bitmap1->Planes[4]=NULL;
      vp.bitmap1->Planes[3]=NULL;
      vp.bitmap1->Depth=3;
      gs_free_bitmap(vp.bitmap1);
      }
   for (cnt=0; cnt < (PVP_FIELDS-1); cnt++)
      {
      if (pvp[cnt].bitmap[0])
         gs_free_bitmap(pvp[cnt].bitmap[0]);
      }
   if (spvp.bitmap[0])
      gs_free_bitmap(spvp.bitmap[0]);
   if (spvp.list)
      gs_free_spvp(&spvp);
   if (spvp2.list)
      gs_free_spvp(&spvp2);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <exec/memory.h>
#include <exec/types.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>

#include <proto/exec.h>
#include <proto/graphics.h>

#include "GameSmith:GameSmith.h"
#include "GameSmith:include/libraries/libptrs.h"
#include "bubble.h"

/*-------------------------------------------------------------------------*/
/* Function Prototypes                                                      */

void parser(int,char **);
int setup(void);
void color_cycle(void);
void build_copper(struct anim_load_struct *);
void move_image(void);
void check_bounds(void);
__stdargs void collision(struct anim_struct *,struct anim_struct *,
     struct collision_struct *,struct collision_struct *);
int check_close(void);
void cleanup(void);
void free_arrays(void);

/*-------------------------------------------------------------------------*/
/* some global variables                                                   */

int bubble_cnt,swidth,sheight,smode,delay=0,random_x=11,random_y=9;
int *x=NULL,*y=NULL,*speedx=NULL,*speedy=NULL,*reset=NULL,*last=NULL;
int dlist;                        /* display list handle for anims */

int break_offset=-1,palette_size;
int copheight;                     /* height of copper screen */
short red,green,blue;            /* background copper colors */
unsigned short chipset;            /* chiset version */

struct BitMap *bm3=NULL;

struct anim_struct *bubble;

struct Interrupt *cycle=NULL;

/*-------------------------------------------------------------------------*/

unsigned short copper_list[4096];   /* enough for our custom user copper list */

struct gs_viewport vp =
   {
   NULL,                           /* ptr to next viewport */
   NULL,                           /* ptr to color table */
   0,                              /* number of colors in table */
   NULL,                           /* ptr to user copper list (none yet) */
   0,0,0,0,0,                     /* height, width, depth, bmheight, bmwidth */
   0,0,                           /* top & left viewport offsets */
   0,0,                           /* X & Y bitmap offsets */
   GSVP_ALLOCBM|GSVP_NOCOLOR|GSVP_NOWAIT,   /* flags */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   NULL,NULL,                     /* bitmap pointers */
   NULL,                           /* future expansion */
   0,0,0,0                        /* display clip (use nominal) */
   };

struct display_struct bubble_display =
   {
   NULL,                           /* ptr to previous display view */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   0,0,                           /* X and Y display offsets */
   0,                              /* display mode ID */
   4,4,                           /* sprite priorities (sprites in front of playfields) */
   GSV_DOUBLE,                     /* flags */
   &vp,                           /* ptr to 1st viewport */
   NULL                           /* future expansion */
   };

struct hard_copper hc =
   {
   &bubble_display,               /* addr of target display */
   copper_list,                  /* addr of pnemonic copper list */
   UCF_DOUBLE,                     /* flags (double buffered display) */
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
   if (gs_open_libs(DOS|GRAPHICS,0))   /* open AmigaDOS libs */
      exit(01);               /* if can't open libs, abort */
   parser(argc,argv);         /* parse command line args */
   chipset=gs_chiprev();      /* find out what machine we're running on */
   if (err=setup())            /* if couldn't get set up... abort program */
      {
      printf("\nSetup error: %d\n",err);
      gs_close_libs();         /* close all libraries */
      exit(02);
      }
   cycle=gs_add_vb_server(&color_cycle,0); /* add color cycle to vertical blank server chain */
   if (!cycle)
      {
      cleanup();                  /* close & deallocate everything */
      printf("\nUnable to add vertical blank server\n");
      gs_close_libs();         /* close all libraries */
      exit(03);
      }
   Forbid();                  /* take over the entire machine */
   while (!end)               /* this shows off speed */
      {
      move_image();            /* move them bubbles around */
      end=check_close();      /* end when user hits left mouse button */
      }
   Permit();                  /* OK, let other things run while we clean up */
   cleanup();                  /* close & deallocate everything */
   gs_close_libs();            /* close all libraries */
}

/***************************************************************************/

void parser(argc,argv)
int argc;
char *argv[];

{
   bubble_cnt=atoi(argv[1]);   /* # anims to place on the screen */
   swidth=320;                  /* default width & height */
   sheight=200;
   copheight=200;
   smode=0;                     /* default mode of lores no lace */
   #ifdef NTSC_MONITOR_ID
      if (GfxBase->LibNode.lib_Version >= 36)   /* if WB 2.0 or higher */
         {               /* this defeats mode promotion on AGA machines */
         if (ModeNotAvailable(NTSC_MONITOR_ID))
            {
            smode = PAL_MONITOR_ID;
            sheight=256;
            copheight=256;
            }
         else
            {
            smode = NTSC_MONITOR_ID;
            }
         }
   #endif
   if (argc >= 3)
      {
      if (!(stricmp(argv[2],"DBL")))   /* check for double scan */
         {
         #ifdef DBLNTSC_MONITOR_ID
         if (GfxBase->LibNode.lib_Version >= 39)   /* if WB 3.0 or higher */
            {               /* try for mode promoted AGA display */
            if (!ModeNotAvailable(DBLNTSC_MONITOR_ID))
               {
               smode = DBLNTSC_MONITOR_ID;
               copheight=400;
               }
            else if (!ModeNotAvailable(DBLPAL_MONITOR_ID))
               {
               smode = DBLPAL_MONITOR_ID;
               sheight=256;
               copheight=512;
               }
            }
         #endif
         }
      else if (!(stricmp(argv[2],"DBLHIRES")))   /* check for hires double scan */
         {
         #ifdef DBLNTSC_MONITOR_ID
         if (GfxBase->LibNode.lib_Version >= 39)   /* if WB 3.0 or higher */
            {               /* try for mode promoted AGA display */
            if (!ModeNotAvailable(DBLNTSC_MONITOR_ID))
               {
               swidth=640;
               smode = DBLNTSC_MONITOR_ID;
               copheight=400;
               sheight=400;
               }
            else if (!ModeNotAvailable(DBLPAL_MONITOR_ID))
               {
               swidth=640;
               smode = DBLPAL_MONITOR_ID;
               sheight=256;
               copheight=512;
               }
            smode|=HIRES|LACE;
            }
         #endif
         }
      else if (!(stricmp(argv[2],"HIRES")))   /* check for hires spec */
         {
         swidth=640;
         sheight=400;
         smode|=HIRES|LACE;
         }
      else if (!(stricmp(argv[2],"SUPER")))   /* check for superhires72 */
         {
         #ifdef SUPER72_MONITOR_ID
         if (GfxBase->LibNode.lib_Version >= 36)
            {
            if (!ModeNotAvailable(SUPER72_MONITOR_ID | SUPERLACE_KEY))
               {
               smode=SUPER72_MONITOR_ID | SUPERLACE_KEY;
               swidth=800;
               sheight=600;
               copheight=300;
               }
            }
         #endif
         }
      }
   if (argc >= 4)
      {
      delay=atoi(argv[3]);      /* delay value in vertical blank intervals */
      }
   if (argc >= 5)               /* new random X speed range */
      {
      random_x=atoi(argv[4]);
      if (random_x < 2)
         random_x=2;
      }
   if (argc >= 6)               /* new random Y speed range */
      {
      random_y=atoi(argv[5]);
      if (random_y < 2)
         random_y=2;
      }
}

/***************************************************************************/

int setup()

{
   int cnt,depth=0;
   struct blit_struct *img;
   struct anim_load_struct load;

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
   load.filename="bubble";            /* name of anim file */
   load.cmap_size=8;                  /* number of bits per color value */
   load.array_elements=bubble_cnt;   /* number of array elements desired */
   load.flags=0L;                     /* no special load flags */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      free_arrays();
      return(-1);
      }
   bubble=load.anim_ptr.anim;         /* ptr to bubble anim */
   if (load.type)                     /* make sure it's an anim type */
      {
      FreeMem(load.cmap,load.cmap_entries*sizeof(long));
      free_arrays();
      if (load.type = 1)
         gs_free_cplx((struct anim_cplx *)bubble,bubble_cnt);
      return(-2);
      }
   img = bubble[0].list;            /* ptr to 1st image in anim sequence */
   while (img)                        /* find max depth of anim */
      {
      if (img->depth > depth)
         depth = img->depth;
      if (img->next == img)         /* avoid infinite loop */
         img=NULL;                  /* if single shot anim */
      else
         img=img->next;
      }
   vp.height = sheight;               /* set up display dimensions */
   vp.width = swidth;
   vp.depth = depth;
   vp.bmheight = sheight;
   vp.bmwidth = swidth;
   bubble_display.modes = smode;
   if (gs_create_display(&bubble_display))
      {
      FreeMem(load.cmap,load.cmap_entries*sizeof(long));
      free_arrays();
      gs_free_anim(bubble,bubble_cnt);
      return(-2);
      }
   build_copper(&load);                     /* build custom copper list */
   FreeMem(load.cmap,load.cmap_entries*sizeof(long));   /* done with color table */
   if ((dlist=gs_get_display_list()) < 0)   /* allocate a display list for anims */
      {
      free_arrays();
      gs_free_anim(bubble,bubble_cnt);
      return(-3);
      }
   bm3=gs_get_bitmap(vp.depth,vp.bmwidth,vp.bmheight,0);
   gs_init_anim(dlist,vp.bitmap1,vp.bitmap2,bm3);   /* tell anim system about bitmaps */
   gs_set_anim_bounds(dlist,0,0,swidth-1,sheight-1);   /* set bounds for anim objects */
   gs_set_collision(dlist,&collision);   /* set ptr to collision handler */
   for (cnt=0; cnt < bubble_cnt; cnt++)
      {                              /* add all bubbles to a display list */
      reset[cnt]=0;
      last[cnt]=-1;
      x[cnt] = gs_random(swidth);   /* random X,Y coords */
      y[cnt] = gs_random(sheight);
      while ((speedx[cnt] = gs_random(random_x)) == 0);
      while ((speedy[cnt] = gs_random(random_y)) == 0);
      if (cnt&1)
         {
         speedx[cnt]*=-1;
         speedy[cnt]*=-1;
         }
      if (bm3)                        /* if restore bitmap */
         {
         bubble[cnt].flags|=ANIM_SAVE_BG;   /* use fastest display method (next to simple copy) */
         if (bubble[cnt].flags & ANIM_CLEAR)
            bubble[cnt].flags ^= ANIM_CLEAR;
         if (bubble[cnt].flags & ANIM_COPY)
            bubble[cnt].flags ^= ANIM_COPY;
         }
      if (gs_add_anim(dlist,(struct anim_struct *)&bubble[cnt],x[cnt],y[cnt]))
         {
         cleanup();                  /* release everything */
         return(-4);                  /* return failure */
         }
      gs_set_anim_cell((struct anim_struct *)&bubble[cnt],gs_random(bubble[cnt].count));
      }
   gs_draw_anims(dlist);
   check_bounds();
   gs_next_anim_page(dlist);
   gs_show_display(&bubble_display,1);
   gs_flip_display(&bubble_display,1);
   gs_open_vb_timer();
   return(0);
}

/***************************************************************************/

void __interrupt __saveds color_cycle()

{
/* THIS IS THE ULTRA SPEEDY WAY TO UPDATE THE COPPER LIST!  RIGHT TO THE HARDWARE! */
/* We'll put this routine in the vertical blank for automatic color cycling.       */

   static int cnt=0,cnt3=0,cnt2=0;
   unsigned short rgb_high,rgb_low;
   static unsigned short *cop1=NULL,*cop2,*cop3,*cop4;

   if (!cop1)         /* if 1st time */
      {
      cop1=vp.LOF_ucop1+palette_size+1;   /* remember, these are WORD pointers */
      cop4=cop3=cop2=cop1;
      if (vp.SHF_ucop1)
         cop2=vp.SHF_ucop1+palette_size+1;
      if (vp.LOF_ucop2)
         cop3=vp.LOF_ucop2+palette_size+1;
      if (vp.SHF_ucop2)
         cop4=vp.SHF_ucop2+palette_size+1;
      if (chipset == AGA_CHIPREV)
         {
         cop1+=2;
         cop2+=2;
         cop3+=2;
         cop4+=2;
         }
      }
   rgb_high=((red&0xf0)<<4)|(green&0xf0)|((blue&0xf0)>>4);
   rgb_low=((red&0x0f)<<8)|((green&0x0f)<<4)|(blue&0x0f);
   red++;
   green++;
   blue++;
   if ((red > 255) || (green > 255) || (blue > 255))
      {
      red=gs_random(128);         /* random starting colors */
      green=gs_random(128);
      blue=gs_random(128);
      }
   if (cnt3 == break_offset)      /* skip wait break-over point for copper */
      {
      cnt2+=2;                     /* this gets past line 256 (copper vertical res = 8 bit) */
      }                           /* now modify hardware list directly */
   cop1[cnt2]=rgb_high;            /* set high order color bits */
   cop2[cnt2]=rgb_high;
   cop3[cnt2]=rgb_high;
   cop4[cnt2]=rgb_high;
   cnt2+=4;                        /* skip over bank/low-order select */
   if (chipset == AGA_CHIPREV)
      {
      cop1[cnt2]=rgb_low;         /* set low order color bits */
      cop2[cnt2]=rgb_low;
      cop3[cnt2]=rgb_low;
      cop4[cnt2]=rgb_low;
      cnt2+=6;                     /* skip over next wait and bank/high-order select */
      }
   cnt++;
   cnt3++;
   if (cnt >= copheight)         /* if reached end of list, start over */
      {
      cnt=cnt2=cnt3=0;
      }
}

/***************************************************************************/

void build_copper(load)
struct anim_load_struct *load;

/* build a custom copper list of background color changes */

{
   int cnt,cnt2=0,copbreak=0;

   for (cnt=1; cnt < load->cmap_entries; cnt++)   /* set color table except color 0 */
      {
      if (chipset == AGA_CHIPREV)
         {
         copper_list[cnt2++]=UC_SETCOLORAGA;   /* set AGA color register */
         copper_list[cnt2++]=cnt;            /* register number */
         copper_list[cnt2++]=(load->cmap[cnt]>>16)&0xff;      /* red color value */
         copper_list[cnt2++]=(load->cmap[cnt]>>8)&0xff;      /* green color value */
         copper_list[cnt2++]=load->cmap[cnt]&0xff;            /* blue color value */
         }
      else
         {
         copper_list[cnt2++]=UC_SETCOLOR;   /* set color register */
         copper_list[cnt2++]=cnt;         /* register number */
         copper_list[cnt2++]=((load->cmap[cnt]>>12)&0x0f00)|
            ((load->cmap[cnt]>>8)&0xf0)|((load->cmap[cnt]>>4)&0x0f);
         }
      }
   if (chipset == AGA_CHIPREV)
      palette_size=(load->cmap_entries-1)*8;   /* remember how many words to skip */
   else
      palette_size=(load->cmap_entries-1)*2;   /* remember how many words to skip */
   red=gs_random(128);                     /* random initial colors */
   green=gs_random(128);
   blue=gs_random(128);
   for (cnt=0; cnt < copheight; cnt++)      /* build copper list */
      {
      if (cnt)
         {
         copper_list[cnt2++]=UC_WAIT;      /* copper wait instruction */
         copper_list[cnt2++]=cnt;         /* y coord to wait on */
         copper_list[cnt2++]=0;            /* x coord to wait on */
         }
      if (chipset == AGA_CHIPREV)
         {
         copper_list[cnt2++]=UC_SETCOLORAGA;   /* set AGA color register */
         copper_list[cnt2++]=0;               /* register number */
         copper_list[cnt2++]=red++;            /* red color value */
         copper_list[cnt2++]=green++;         /* green color value */
         copper_list[cnt2++]=blue++;         /* blue color value */
         }
      else
         {
         copper_list[cnt2++]=UC_SETCOLOR;   /* set color register */
         copper_list[cnt2++]=0;            /* register number */
         copper_list[cnt2++]=((red++<<4)&0x0f00)|
            (green++&0xf0)|((blue++>>4)&0x0f);
         }
      if ((red > 255) || (green > 255) || (blue > 255))
         {
         red=gs_random(128);         /* random starting colors */
         green=gs_random(128);
         blue=gs_random(128);
         }
      if (((cnt+bubble_display.LOF_top) >= 256) && (!copbreak))
         {
         break_offset=cnt;   /* remember when we pass copper line 256 (hardware limitation) */
         copbreak=1;
         }
      }
   copper_list[cnt2++]=UC_END;            /* end coppper list */
   if (gs_hard_copper(&hc,&vp))
      return;
   gs_replace_ucop(&bubble_display,&vp,&hc);
   gs_free_hard_copper(&hc);
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
      x[cnt]+=speedx[cnt];            /* move the object */
      y[cnt]+=speedy[cnt];
      gs_anim_obj((struct anim_struct *)&bubble[cnt],x[cnt],y[cnt]);
      if (reset[cnt])               /* since anim doesn't loop, must reset */
         {                           /* the sequence in the event of collision */
         reset[cnt]=0;               /* start at 1st cell in anim sequence */
         gs_set_anim_cell((struct anim_struct *)&bubble[cnt],0);
         }
      if (!bubble[cnt].collide)      /* if not colliding, clear last ptr */
         last[cnt]=-1;
      }
   while (bubble_display.flags & GSV_FLIP);   /* while page not flipped yet */
   gs_draw_anims(dlist);            /* draw them anim objects! */
   check_bounds();                  /* bounce off of outer bitmap bounds */
   gs_next_anim_page(dlist);         /* tell anim sys to use other bitmap */
   gs_flip_display(&bubble_display,1);   /* switch to other display, sync */
}

/***************************************************************************/

void check_bounds()

{
   int cnt;

   for (cnt=0; cnt < bubble_cnt; cnt++)
      {
      if (bubble[cnt].flags & (ANIM_BOUNDS_X1|ANIM_BOUNDS_X2))
         {
         x[cnt]=bubble[cnt].x;   /* keep track of current location */
         speedx[cnt]=-speedx[cnt];   /* reverse X direction */
         reset[cnt]=1;            /* make bubble warp */
         last[cnt]=-1;            /* no colliding */
         }
      if (bubble[cnt].flags & (ANIM_BOUNDS_Y1|ANIM_BOUNDS_Y2))
         {
         y[cnt]=bubble[cnt].y;
         speedy[cnt]=-speedy[cnt];   /* reverse Y direction */
         reset[cnt]=1;
         last[cnt]=-1;
         }
      }
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

__stdargs void collision(anim1,anim2,coll1,coll2)
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

   if (last[anim1->array_num] != anim2->array_num)      /* if not same object */
      {
      last[anim1->array_num] = anim2->array_num;      /* remember last collision */
      last[anim2->array_num] = anim1->array_num;
      reset[anim1->array_num]=1;                        /* reset anim cell */
      reset[anim2->array_num]=1;
      temp=speedy[anim2->array_num];                  /* swap values */
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
   if (cycle)
      gs_remove_vb_server(cycle);
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
   if (bm3)
      gs_free_bitmap(bm3);
}

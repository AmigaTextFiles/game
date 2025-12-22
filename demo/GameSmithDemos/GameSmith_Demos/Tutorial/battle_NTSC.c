/****************************************************************************

Note: This demo calls GameSmith functions via registerized parameters.  If
your 'C' compiler does not support the passing of parameters in CPU registers,
then you will need to delete the "_" (underscore) character in front of all
GameSmith calls before compiling.

This demo was written with SAS/C version 6.3 by John Enright, and is hereby
placed in the public domain. :)  Do with it what you will, as long as no
profit is gained by any persons.  This demo and the accompanying tutorial
are included with the GameSmith Development System by Bithead Technologies.

Contact Oregon Research for information about obtaining a copy of GDS.

****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <exec/memory.h>
#include <exec/types.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <proto/intuition.h>

#include "GameSmith:GameSmith.h"
#include "GameSmith:include/proto/all_regargs.h"
#include "GameSmith:include/libraries/libptrs.h"

#include "gfx/tank_blue.h"   /* need collision table defines */

#define TURN_RATE   4      /* number of vertical blanks before allowing next turn */
#define PLAYERS   2        /* number of players */
#define FLICKER_DELAY   (50*2)   /* invulnerable period after being shot (in seconds) */

#define MAX_SPEED   4   /* maximum bullet speed (n * tank speed) */

#define SOUNDS 5      /* five different sounds per player */

#define SHOOT  0      /* bullet shot sound */
#define HIT    1      /* tank hit sound */
#define MISS   2      /* bullet missed & exploded */
#define BOUNCE 3      /* bullet bounced */
#define MOVE   4      /* tank movement */

#define GAME_SCORE   21      /* score to reach in order to win, must win by 2 */

#define SCORE_BG     0x00000044   /* color used for score area background */
#define SCORE_TEXT   0x00ff1122   /* color used for score text */

#define OPTIONS   5       /* number of options */
#define OPT_TOP   50      /* Y coord for top option line */
#define OPT_SPACING   25  /* number of lines between option text baselines */

#define RELOAD_DELAY  25  /* delay time before tank can reshoot */

/*-------------------------------------------------------------------------*/
/* error return codes:                                                      */

#define ERR_DISPLAY       -1      /* can't open GameSmith display */
#define ERR_BATTLEFIELD   -2      /* can't load battlefield pic */
#define ERR_GOLDTANK      -3      /* can't load gold tank anim obj */
#define ERR_BLUETANK      -4      /* can't load blue tank anim obj */
#define ERR_PTR           -5      /* can't load pointer anim obj */
#define ERR_BULLET        -6      /* can't load bullet anim obj */
#define ERR_EXPLODE       -7      /* can't load explosion anim obj */
#define ERR_ANIMLIST      -8      /* can't allocate anim display list */
#define ERR_SOUNDLOAD     -9      /* can't load one or more sound samples */
#define ERR_SOUNDOPEN     -10     /* can't open/allocate sound system */
#define ERR_ANIMADD       -11     /* can't add object to display list */
#define ERR_INTUITION     -12     /* can't open Intuition screen & window */

/*-------------------------------------------------------------------------*/
/* Function Prototypes                                                      */

int setup(void);
int get_sounds(void);
int intui_happy(void);
void error_display(int);
int options(void);
void draw_options(void);
void draw_optptr(int);
void reset(void);
int fight(void);
int show_scores(void);
void wait_winner(int);
void clear_bitmap(struct BitMap *);
void copy_bitmap(struct BitMap *,struct BitMap *);
__stdargs void collision(struct anim_struct *,struct anim_struct *,
     struct collision_struct *,struct collision_struct *);
__stdargs void collision_bg(struct anim_struct *,struct coll_bg_struct *,int);
void bounce_em(struct anim_cplx *,int,int);
int check_abort(void);
void pause_game(void);
void cleanup(void);

/*-------------------------------------------------------------------------*/
/* some global variables                                                   */

unsigned long color2[2]={SCORE_BG,SCORE_TEXT};
unsigned long color[64];
int dlist=-1;                  /* display list handle for anims */
int dlist2=-1;                 /* display list handle for anims */

         /* BAD PRACTICE ALERT! ptr to hardware keyboard reg */
unsigned char *keybrd=(unsigned char *)0xbfec01;

int move_x[12]={0,1,2,2,2,1,0,-1,-2,-2,-2,-1};   /* x direction movement rate in pixels */
int move_y[12]={-2,-2,-1,0,1,2,2,2,1,0,-1,-2};   /* y direction movement rate in pixels */
int bmove_x[12];               /* bullet x direction movement rate in pixels */
int bmove_y[12];               /* bullet y direction movement rate in pixels */
int bullet_speed=MAX_SPEED;    /* bullet moves n times as fast as tanks */
int bounce=1;                  /* bullet bounce option */
int turn[PLAYERS]={0,0};
int bdelay[PLAYERS]={0,0};
int fire[PLAYERS]={0,0};
int boom[PLAYERS]={0,0};
int score[PLAYERS]={0,0};
int bmove[PLAYERS][2];         /* movement for bullets in flight (x & y) */
int bdirect[PLAYERS];          /* bullet direction (0 - 11) */
int bump[PLAYERS][2];          /* indicators for tanks bumping into walls */
int gotcha[PLAYERS]={0,0};     /* player has been hit */
int flicker[PLAYERS]={0,0};    /* invulnerability count down after being shot */
struct anim_cplx *blowup[PLAYERS]={NULL,NULL};   /* ptrs to bullets on impact */

struct BitMap *bm3=NULL;       /* ptr to spare bitmap for background restoration */

int page=0;                    /* current display page */
int game_in_progress=0;        /* flag allows resume game from options screen */
int multitask=1;               /* flag to allow multitasking during game play */
int frame_rate;                /* vertical blank intervals per second */

struct RastPort rp1 = {0};     /* for printing player scores (page 1) */
struct RastPort rp2 = {0};     /* for printing player scores (page 2) */
struct RastPort rp3 = {0};     /* for printing options */

struct sound_struct shoot,explode_hit,explode_miss,bounce1,bounce2,move;

/* the following array defines the activity sounds for each player */

struct sound_struct *sound[PLAYERS][SOUNDS]={
   {&shoot,&explode_hit,&explode_miss,&bounce1,&move},   /* player 1 sounds */
   {&shoot,&explode_hit,&explode_miss,&bounce2,&move}    /* player 2 sounds */
   };

/* the following defines on what channel the above sounds will play for each player */

int channel[PLAYERS][SOUNDS]={
   {CHANNEL0,CHANNEL0,CHANNEL2,CHANNEL2,CHANNEL0},  /* sound channels for player 1 */
   {CHANNEL1,CHANNEL1,CHANNEL3,CHANNEL3,CHANNEL1}   /* sound channels for player 2 */
   };

/* ---- the anim object array pointers ---- */

struct anim_struct *tank[PLAYERS]={NULL,NULL};
struct anim_struct *explode=NULL;
struct anim_struct *ptr=NULL;
struct anim_cplx *bullet=NULL;

/*-------------------------------------------------------------------------*/
/* Intuition screen and window structs to keep WB safe from input.device   */

unsigned char title[]="GameSmith Tank Battle";
unsigned char pause_title[]="<-- Close to Unpause Tank Battle ";

static char topaz8_text[]="topaz.font";

static struct TextAttr topaz8 =
   {
   topaz8_text,                  /* Addr of ASCIIZ string containing font name */
   8,                            /* font YSize (height) */
   FS_NORMAL,                    /* style flags */
   FPF_DESIGNED|FPF_ROMFONT      /* flags */
   };

struct NewScreen dummy_screen =
   {
   0,0,                          /* left & top edges */
   320,40,1,                     /* width, height, & depth (filled) */
   1,2,                          /* detail & block pens */
   0,                            /* display mode */
   CUSTOMSCREEN,                 /* type */
   &topaz8,                      /* text attribute for font */
   NULL,                         /* screen title */
   NULL,                         /* ptr to gadgets */
   NULL,                         /* ptr to bitmap */
   };

struct NewWindow dummy_window =
   {
   0,0,320,40,                           /* left edge, top edge, width, height */
   1,2,                                  /* detail & block pens */
   0,                                    /* IDCMP flags */
   SIMPLE_REFRESH|BORDERLESS|ACTIVATE|
   NOCAREREFRESH|RMBTRAP,                /* window flags */
   NULL,                                 /* ptr to 1st gadget */
   NULL,                                 /* ptr to checkmark image */
   title,                                /* window title */
   0,                                    /* ptr to screen */
   NULL,                                 /* ptr to bitmap to use for refresh */
   0,0,0,0,                              /* min width & height, max width & height */
   CUSTOMSCREEN                          /* window type */
   };

struct NewWindow pause_window =
   {
   0,40,400,40,                          /* left edge, top edge, width, height */
   1,2,                                  /* detail & block pens */
   CLOSEWINDOW,                          /* IDCMP flags */
   WINDOWSIZING|WINDOWDEPTH|
   WINDOWCLOSE|WINDOWDRAG|NOCAREREFRESH|
   SIMPLE_REFRESH|ACTIVATE,              /* window flags */
   NULL,                                 /* ptr to 1st gadget */
   NULL,                                 /* ptr to checkmark image */
   pause_title,                          /* window title */
   0,                                    /* ptr to screen */
   NULL,                                 /* ptr to bitmap to use for refresh */
   0,0,400,40,                           /* min width & height, max width & height */
   WBENCHSCREEN                          /* window type */
   };

struct Screen *screen=NULL;
struct Window *window=NULL;
struct TextFont *font=NULL;

/*-------------------------------------------------------------------------*/

struct loadILBM_struct loadpic =
   {
   "gfx/battlefield.pic",   /* ptr to picture name string */
   NULL,               /* ptr to 1st bitmap */
   NULL,               /* ptr to 2nd bitmap (if any) */
   color,              /* ptr to color table array */
   64,                 /* # colors in color table */
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
   NULL                /* address of BitMapHeader to fill */
   };

struct gs_viewport vp2 =
   {
   NULL,                          /* ptr to next viewport */
   color2,                        /* ptr to color table */
   2,                             /* number of colors in table */
   NULL,                          /* ptr to user copper list */
   18,320,1,18,320,               /* height, width, depth, bmheight, bmwidth */
   238,0,                         /* top & left viewport offsets */
   0,0,                           /* X & Y bitmap offsets */
   GSVP_ALLOCBM,                  /* flags (allocate bitmaps) */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   NULL,NULL,                     /* bitmap pointers */
   NULL,                          /* future expansion */
   0,0,0,0                        /* display clip (MinX,MinY,MaxX,MaxY) */
   };

struct gs_viewport vp =
   {
   &vp2,                          /* ptr to next viewport */
   color,                         /* ptr to color table */
   64,                            /* number of colors in table */
   NULL,                          /* ptr to user copper list */
   236,320,6,236,320+8,           /* height, width, depth, bmheight, bmwidth */
   0,0,                           /* top & left viewport offsets */
   0,0,                           /* X & Y bitmap offsets */
   GSVP_ALLOCBM,                  /* flags (allocate bitmaps) */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   NULL,NULL,                     /* bitmap pointers */
   NULL,                          /* future expansion */
   0,0,0,0                        /* display clip (MinX,MinY,MaxX,MaxY) */
   };

struct display_struct display =
   {
   NULL,                          /* ptr to previous display view */
   NULL,NULL,                     /* 2.xx & above compatibility stuff */
   0,0,                           /* X and Y display offsets (1.3 style) */
   EXTRAHALFBRITE_KEY,            /* display mode ID */
   4,4,                           /* sprite priorities */
   GSV_DOUBLE|GSV_BRDRBLNK,       /* flags (double buffered & blanked borders) */
   &vp,                           /* ptr to 1st viewport */
   NULL                           /* future expansion */
   };

/***************************************************************************/

main(argc,argv)
int argc;
char *argv[];

{
   int err,end,winner;

   if (gs_open_libs(DOS|GRAPHICS|INTUITION,0))   /* open AmigaDOS libs, latest versions */
      exit(01);                /* if can't open libs, abort */
   if (err=setup())            /* if couldn't get set up... abort program */
      {
      error_display(err);      /* tell user why we're aborting */
      gs_close_libs();         /* close all libraries */
      exit(02);
      }
   end=options();              /* show game options */
   while (!end)
      {
      if (check_abort())       /* if user hits the Esc key */
         end=options();        /* bring up the options screen */
      else if (winner=fight()) /* game control */
         {
         wait_winner(winner-1);
         end=options();
         }
      }
   cleanup();                  /* close & deallocate everything */
   gs_close_libs();            /* close all libraries */
   return(0);                  /* all went well */
}

/***************************************************************************/
/*
   This function creates the display, loads the background picture, loads
   all anim objects, allocates two display lists for the animation system,
   adds all objects to the appropriate lists, and shows the display.
*/

int setup()

{
   int cnt;
   struct anim_load_struct load;

   gs_get_ILBM_bm(&loadpic);         /* load color table from picture file */
   #ifdef PAL_MONITOR_ID
      if (GfxBase->LibNode.lib_Version >= 36)   /* if WB 2.0 or higher */
         {                           /* select display mode.  Try for PAL */
         if (ModeNotAvailable(PAL_MONITOR_ID))
            {   /* if not PAL, use NTSC & drop vertical resolution */
            display.modes |= NTSC_MONITOR_ID;
            vp.height = 180;
            vp.bmheight = 180;
            vp2.top = 182;
            frame_rate=60;          /* display refresh rate */
            dummy_screen.Height=180;
            }
         else
            {
            display.modes |= PAL_MONITOR_ID;
            frame_rate=50;          /* display refresh rate */
            }
         }
      else  /* This is the NTSC version, so we'll default to NTSC with WB 1.3 */
         {
         display.modes |= NTSC_MONITOR_ID;
         vp.height = 180;
         vp.bmheight = 180;
         vp2.top = 182;
         frame_rate=60;          /* display refresh rate */
         dummy_screen.Height=180;
         }
   #endif
   if (gs_create_display(&display)) /* create the GameSmith display */
      {
      return(ERR_DISPLAY);
      }
   InitRastPort(&rp1);              /* initialize rastport for text output */
   InitRastPort(&rp2);              /* initialize rastport */
   InitRastPort(&rp3);              /* initialize rastport */
   rp1.BitMap=vp2.bitmap1;          /* tell rastport to use our bitmap (page 1) */
   rp2.BitMap=vp2.bitmap2;          /* tell rastport to use our bitmap (page 2) */
   rp3.BitMap=vp.bitmap1;           /* tell rastport to use our bitmap (options screen) */
   SetDrMd(&rp1,JAM2);              /* drawing mode */
   SetDrMd(&rp2,JAM2);
   SetDrMd(&rp3,JAM2);
   SetAPen(&rp1,1);                 /* select pen color (white) */
   SetAPen(&rp2,1);                 /* select pen color (white) */
   SetAPen(&rp3,11);                /* select pen color for options screen */
   font=OpenFont(&topaz8);          /* open the font we'll use (ugly ROM font) */
   if (font)
      {
      SetFont(&rp1,font);           /* allow gfx lib to use our font with Text() */
      SetFont(&rp2,font);
      SetFont(&rp3,font);
      }
   loadpic.bitmap1=vp.bitmap2;      /* tell picture loader where to put picture */
   if (gs_loadILBM(&loadpic))       /* only need to load 1 bitmap because */
      {                             /* we'll put options screen on other page */
      gs_remove_display(&display);  /* and copy background imagery when done. */
      return(ERR_BATTLEFIELD);
      }
   gs_open_vb_timer();              /* open fast vertical blank counter */
   load.flags=ANIMLOAD_NOCOLOR;     /* don't allocate a color table */
   load.array_elements=1;           /* number of array elements desired */
   load.filename="gfx/tank_gold.anim";   /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(ERR_GOLDTANK);
      }
   tank[0]=load.anim_ptr.anim;      /* ptr to anim object */
   load.filename="gfx/tank_blue.anim";   /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(ERR_BLUETANK);
      }
   tank[1]=load.anim_ptr.anim;      /* ptr to anim object */
   load.filename="gfx/pointer.anim";   /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(ERR_PTR);
      }
   ptr=load.anim_ptr.anim;          /* ptr to anim object */
   load.array_elements=PLAYERS;     /* number of array elements desired (2 bullets) */
   load.filename="gfx/bullet.cplx"; /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(ERR_BULLET);
      }
   bullet=load.anim_ptr.cplx;       /* ptr to anim object */
   load.filename="gfx/explode.anim"; /* name of anim file */
   if (gs_load_anim(&load))         /* load the anim object */
      {
      cleanup();
      return(ERR_EXPLODE);
      }
   explode=load.anim_ptr.anim;      /* ptr to anim object */
   if ((dlist=gs_get_display_list()) < 0) /* allocate a display list for game anims */
      {
      cleanup();
      return(ERR_ANIMLIST);
      }
   if ((dlist2=gs_get_display_list()) < 0)
      {                             /* allocate a display list for options pointer */
      cleanup();
      return(ERR_ANIMLIST);
      }
   if (get_sounds())                /* load all of our sound efx */
      {
      cleanup();
      return(ERR_SOUNDLOAD);
      }
   if (gs_open_sound(1,0,0,(4096/2)))   /* open sound system, OS friendly */
      {
      cleanup();
      return(ERR_SOUNDOPEN);
      }
   bm3=gs_get_bitmap(vp.depth,vp.bmwidth,vp.bmheight,0);
   if (bm3)              /* try to get "spare" bitmap for faster obj display */
      copy_bitmap(vp.bitmap2,bm3); /* set up spare bitmap for background restore */
   gs_init_anim(dlist,vp.bitmap1,vp.bitmap2,bm3);   /* tell anim system about bitmaps */
   
   /* dlist2 will use the same bitmap areas, but contains the animated pointer for */
   /* the options screen.  We'll only call gs_draw_anims(dlist2) when the options */
   /* are displayed.  This is an easy way to keep the anim objects separate, while */
   /* using the same bitmaps for display. */

   gs_init_anim(dlist2,vp.bitmap1,vp.bitmap2,NULL);

   gs_set_anim_bounds(dlist,0,0,vp.width+8-1,vp.height-1);
   gs_set_collision(dlist,&collision);   /* set ptr to collision handler */
   gs_set_collision_bg(dlist,&collision_bg);   /* set ptr to background collision handler */
   if (gs_add_anim(dlist,tank[0],0,0))
      {                          /* if can't add object to display list */
      cleanup();
      return(ERR_ANIMADD);       /* return failure */
      }
   
   /* The "label" area of an anim object is for user consumption.  We're gonna */
   /* reassign its value so that it corresponds to an array index instead of the */
   /* unique ID number it was given by CITAS.  This will make using our objects */
   /* easier for this game.  The label will now contain the player number (0 or 1). */
   
   tank[0]->label=0;             /* reassign label value to array index */

   if (gs_add_anim(dlist,tank[1],0,0))
      {                          /* if can't add object to display list */
      cleanup();
      return(ERR_ANIMADD);       /* return failure */
      }
   tank[1]->label=1;             /* reassign label value to array index */
   for (cnt=0; cnt < PLAYERS; cnt++)
      {
      bullet[cnt].label=cnt;     /* re-assign label to correspond to array value */
      if (gs_add_anim_cplx(dlist,&bullet[cnt],0,0,0,bullet[0].list->prio))
         {
         cleanup();
         return(ERR_ANIMADD);
         }
      if (gs_add_anim(dlist,&explode[cnt],0,0))
         {
         cleanup();
         return(ERR_ANIMADD);
         }
      }

   /* the following function call can't fail since the object doesn't require */
   /* a background save area (it uses the "erase" display method). */
   
   gs_add_anim(dlist2,ptr,0,0);  /* add pointer to 2nd display list (for options) */
   
   if (intui_happy())            /* open screen & window to trap mouse events */
      {
      cleanup();
      return(ERR_INTUITION);
      }
   gs_show_display(&display,1);  /* show the display */
   return(0);                    /* all went well */
}

/***************************************************************************/
/* load all the sound samples.  GameSmith sound handling is very easy.     */

int get_sounds()

{
   int err;
   
   shoot.data=NULL;            /* no sounds loaded yet */
   explode_hit.data=NULL;
   explode_miss.data=NULL;
   bounce1.data=NULL;
   bounce2.data=NULL;
   move.data=NULL;
   shoot.flags=SND_FAST;      /* load sound samples to Fast RAM if available */
   explode_hit.flags=SND_FAST;
   explode_miss.flags=SND_FAST;
   bounce1.flags=SND_FAST;
   bounce2.flags=SND_FAST;
   move.flags=SND_FAST;
   if (err=gs_load_iff_sound(&shoot,0L,"snd/shot"))
      return(err);
   if (err=gs_load_iff_sound(&explode_hit,0L,"snd/explosion1"))
      return(err);
   if (err=gs_load_iff_sound(&explode_miss,0L,"snd/explosion2"))
      return(err);
   if (err=gs_load_iff_sound(&bounce1,0L,"snd/click"))
      return(err);
   if (err=gs_load_iff_sound(&bounce2,0L,"snd/tick"))
      return(err);
   if (err=gs_load_iff_sound(&move,0L,"snd/tank_roll"))
      return(err);
   return(0);
}

/***************************************************************************/

int intui_happy()

{
   if (!(screen=(struct Screen *)OpenScreen((struct NewScreen *)&dummy_screen)))
      {                 /* open our stubby 1 bitplane little screen */
      return(-1);
      }
   dummy_window.Screen = screen;
   if (!(window=(struct Window *)OpenWindow(&dummy_window)))
      {
      CloseScreen(screen);
      return(-1);
      }
   return(0);
}

/***************************************************************************/
/* this function is called in the event of a setup error.                  */

void error_display(err)
int err;

{
   switch (err)
      {
      case ERR_DISPLAY:
         printf("\nError opening GameSmith display\n\n");
         break;
      case ERR_BATTLEFIELD:
         printf("\nCan't load battlefield picture\n\n");
         break;
      case ERR_GOLDTANK:
         printf("\nCan't load gold tank anim object\n\n");
         break;
      case ERR_BLUETANK:
         printf("\nCan't load blue tank anim object\n\n");
         break;
      case ERR_PTR:
         printf("\nCan't load pointer anim object\n\n");
         break;
      case ERR_BULLET:
         printf("\nCan't load bullet anim object\n\n");
         break;
      case ERR_EXPLODE:
         printf("\nCan't load explosion anim object\n\n");
         break;
      case ERR_ANIMLIST:
         printf("\nCan't allocate animation display list\n\n");
         break;
      case ERR_SOUNDLOAD:
         printf("\nCan't load one or more sound samples\n\n");
         break;
      case ERR_SOUNDOPEN:
         printf("\nCan't open/allocate GameSmith sound system\n\n");
         break;
      case ERR_ANIMADD:
         printf("\nError adding anim object to display list\n\n");
         break;
      case ERR_INTUITION:
         printf("\nError opening Intuition screen and/or window\n\n");
         break;
      default:
         printf("\nUnknown Error %d\n\n",err);
         break;
      }
}

/***************************************************************************/

int options()

{
   int cnt,opt=0,status=0,done=0,stick;

   gs_restore_anim_bg(dlist);    /* restore background behind objects.  This is because */
                                 /* we need to copy the bitmap (minus objects) later. */
   gs_next_anim_page(dlist2);    /* single page operation */
   if (page)                     /* clear current display page for option display */
      {
      clear_bitmap(vp.bitmap2);
      rp3.BitMap=vp.bitmap2;     /* assign bitmap for RastPort drawing of options */
      }
   else
      {
      clear_bitmap(vp.bitmap1);
      rp3.BitMap=vp.bitmap1;     /* assign bitmap for RastPort drawing */
      }
   clear_bitmap(vp2.bitmap1);    /* clear score area */
   clear_bitmap(vp2.bitmap2);
   gs_SetRGB(&display,1,0,0);    /* change score area background to black */
   draw_options();
   draw_optptr(opt);             /* draw options ptr */
   while (!done)
      {
      _gs_draw_anims(dlist2);    /* draw pointer anim */
      gs_vb_timer_reset();
      while (gs_vb_time() < 5)   /* wait n vertical blank periods */
         check_abort();            /* allow pause from within options screen */
      _gs_anim_obj(ptr,ptr->x,ptr->y);   /* animate the pointer */
      stick=gs_joystick(1);      /* poll joyport 1 */
      if (stick & JOY_UP)
         {
         opt--;
         if (opt < 0)
            {
            opt=OPTIONS-1;
            if (game_in_progress)
               opt++;
            }
         draw_optptr(opt);
         _gs_start_sound(sound[0][BOUNCE],channel[0][BOUNCE]);
         }
      else if (stick & JOY_DOWN)
         {
         opt++;
         if (opt >= OPTIONS)
            {
            if (opt > OPTIONS)
               opt=0;
            else if (!game_in_progress)
               opt=0;
            }
         draw_optptr(opt);
         _gs_start_sound(sound[0][BOUNCE],channel[0][BOUNCE]);
         }
      else if (stick & (JOY_RIGHT|JOY_LEFT|JOY_BUTTON1))
         {
         switch (opt)
            {
            case 0:
               if ((stick & JOY_RIGHT) && (bullet_speed < MAX_SPEED))
                  {
                  bullet_speed++;
                  draw_options();
                  _gs_start_sound(sound[1][BOUNCE],channel[1][BOUNCE]);
                  }
               else if ((stick & JOY_LEFT) && (bullet_speed > 1))
                  {
                  bullet_speed--;
                  draw_options();
                  _gs_start_sound(sound[1][BOUNCE],channel[1][BOUNCE]);
                  }
               break;
            case 1:
               bounce^=1;            /* flip bounce status */
               draw_options();      /* show change */
               _gs_start_sound(sound[1][BOUNCE],channel[1][BOUNCE]);
               break;
            case 2:
               multitask^=1;         /* flip multitasking status */
               if (multitask)
                  Permit();         /* let other tasks run */
               else
                  Forbid();         /* take over entire machine */
               draw_options();      /* show change */
               _gs_start_sound(sound[1][BOUNCE],channel[1][BOUNCE]);
               break;
            case 3:
               if (stick & JOY_BUTTON1)
                  {
                  done=1;            /* start a new game.  Let 'er rip! */
                  reset();            /* reset object positions */
                  game_in_progress=1; /* flag new game started */
                  }
               break;
            case 4:
               if (stick & JOY_BUTTON1)
                  done=status=1;      /* quit back to WorkBench */
               break;
            case 5:
               if (stick & JOY_BUTTON1)
                  done=1;            /* resume game */
               break;
            default:
               break;
            }
         }
      }
   if (!status)
      {
      if (page)
         copy_bitmap(vp.bitmap1,vp.bitmap2);
      else
         copy_bitmap(vp.bitmap2,vp.bitmap1);
      gs_SetRGB(&display,1,0,SCORE_BG); /* change score area background to correct color */
      for (cnt=0; cnt < PLAYERS; cnt++)
         _gs_enable_anim(tank[cnt]);   /* show tanks */
      show_scores();
      for (cnt=0; cnt < 12; cnt++)   /* build bullet speed table */
         {
         bmove_x[cnt]=move_x[cnt]*bullet_speed;
         bmove_y[cnt]=move_y[cnt]*bullet_speed;
         }
      gs_vb_timer_reset();
      while (gs_vb_time() < 25);      /* delay a bit before starting new game */
      }
   gs_next_anim_page(dlist2);      /* sync back to game anims */
   return(status);               /* play the game! (or quit) */
}

/***************************************************************************/

void draw_options()

{
   int line=OPT_TOP;
   char text[64];

   strcpy(text,"Esc for options, 'P' to pause");
   Move(&rp3,50,line-OPT_SPACING);
   Text(&rp3,text,strlen(text));
   sprintf(text,"BULLET SPEED : %d",bullet_speed);
   Move(&rp3,100,line);
   Text(&rp3,text,strlen(text));
   if (bounce)
      strcpy(text,"BULLET BOUNCE: YES");
   else
      strcpy(text,"BULLET BOUNCE: NO ");
   line+=OPT_SPACING;            /* space between option lines */
   Move(&rp3,100,line);
   Text(&rp3,text,strlen(text));
   if (multitask)
      strcpy(text,"MULTITASKING: YES");
   else
      strcpy(text,"MULTITASKING: NO ");
   line+=OPT_SPACING;            /* space between option lines */
   Move(&rp3,100,line);
   Text(&rp3,text,strlen(text));
   strcpy(text,"NEW GAME");
   line+=OPT_SPACING;            /* space between option lines */
   Move(&rp3,100,line);
   Text(&rp3,text,strlen(text));
   strcpy(text,"QUIT");
   line+=OPT_SPACING;            /* space between option lines */
   Move(&rp3,100,line);
   Text(&rp3,text,strlen(text));
   if (game_in_progress)
      {
      strcpy(text,"RESUME GAME");
      line+=OPT_SPACING;            /* space between option lines */
      Move(&rp3,100,line);
      Text(&rp3,text,strlen(text));
      }
}

/***************************************************************************/

void draw_optptr(opt)
int opt;

{
   _gs_move_anim(ptr,70,OPT_TOP+(opt*OPT_SPACING)-ptr->height+3);
}

/***************************************************************************/
/* reset all variables, place anims, & get everything ready for battle.    */

void reset()

{
   int cnt;

   for (cnt=0; cnt < PLAYERS; cnt++)
      {
      score[cnt]=0;        /* no scores yet */
      flicker[cnt]=0;      /* not invulnerable */
      boom[cnt]=0;         /* no ongoing explosions */
      blowup[cnt]=NULL;    /* no bullets even on screen */
      gotcha[cnt]=0;       /* nobody has been hit yet */
      fire[cnt]=0;         /* no bullets have been fired */
      turn[cnt]=0;         /* no turn delay yet */
      bump[cnt][0]=bump[cnt][1]=0;   /* not bumping into anything yet */
      _gs_clear_cplx(&bullet[cnt]);  /* make sure bullets aren't displayed */
      _gs_clear_anim(&explode[cnt]); /* make sure explosions are invisible */
      _gs_clear_anim(tank[cnt]);     /* clear tank from screen */
      _gs_clear_anim_flicker(tank[cnt]);   /* make sure not flickering */
      }                     /* randomly place both tanks */
   _gs_move_anim(tank[0],_gs_random(vp.width/4),_gs_random(vp.height/4));
   _gs_set_anim_cell(tank[0],_gs_random(tank[0]->count));  /* random direction for tank */
   _gs_move_anim(tank[1],vp.width-_gs_random(vp.width/4),
      vp.height-_gs_random(vp.height/4));
   _gs_set_anim_cell(tank[1],_gs_random(tank[1]->count));  /* random direction for tank */
   gs_draw_anims(dlist);            /* draw anims to make sure they're erased */
   gs_next_anim_page(dlist);        /* tell animation system to use other bitmap next time */
   gs_next_anim_page(dlist2);       /* sync options ptr to correct page */
   gs_flip_display(&display,1);     /* flip to next bitmap page during next vertical blank */
   page^=1;                         /* keep track of display page */
   while (display.flags & GSV_FLIP);/* while page not flipped yet */
   gs_draw_anims(dlist);            /* draw anims to make sure they're erased */
   gs_next_anim_page(dlist);        /* tell animation system to use other bitmap next time */
   gs_next_anim_page(dlist2);       /* sync options ptr to correct page */
   gs_flip_display(&display,1);     /* flip to next bitmap page during next vertical blank */
   page^=1;                         /* keep track of display page */
}

/***************************************************************************/

void wait_winner(winner)
int winner;

{
   char win_text[16];

   game_in_progress=0;             /* flag game over */
   clear_bitmap(vp2.bitmap1);      /* clear score area */
   clear_bitmap(vp2.bitmap2);
   if (winner)
      strcpy(win_text,"Blue Tank WINS!");
   else
      strcpy(win_text,"Gold Tank WINS!");
   Move(&rp1,100,12);
   Text(&rp1,win_text,15);
   Move(&rp2,100,12);
   Text(&rp2,win_text,15);
   gs_vb_timer_reset();
   while (gs_vb_time() < (frame_rate*2))  /* delay 2 seconds */
      {  /* delay at end (in case winner is still holding button down) */
/*      winner_efx();   */         /* nice special efx for winner */
      }
   while (!(_gs_joystick(winner) & JOY_BUTTON1)); /* wait for winner to press button */
   clear_bitmap(vp2.bitmap1);      /* clear score area */
   clear_bitmap(vp2.bitmap2);
   gs_vb_timer_reset();
   while (gs_vb_time() < (frame_rate/2)); /* delay a bit before starting new game */
}

/***************************************************************************/

void clear_bitmap(bitmap)
struct BitMap *bitmap;

{
   int cnt;

   for (cnt=0; cnt < bitmap->Depth; cnt++)   /* clear each plane */
      {         
      gs_blit_fill((unsigned short *)bitmap->Planes[cnt],
         bitmap->Rows*(bitmap->BytesPerRow/2),0);
      }
}

/***************************************************************************/

void copy_bitmap(src,dest)
struct BitMap *src,*dest;

{
   int cnt;

   for (cnt=0; cnt < src->Depth; cnt++)
      {
      gs_blit_memcopy(src->Planes[cnt],dest->Planes[cnt],
         (src->BytesPerRow/2)*src->Rows);
      }
}

/***************************************************************************/
/*
   This handles movement & animation of all objects.
*/

int fight()

/* move & animate everything */

{
   int player,stick,status=0;

   for (player=0; player < PLAYERS; player++)
      {
      if (flicker[player]) /* if tank flickering after being hit */
         {
         flicker[player]--;
         if (!flicker[player])
            _gs_clear_anim_flicker(tank[player]);
         }
      if (boom[player])    /* if bullet exploding */
         {
          if ((explode[player].cell+1) == explode[player].count)
            {
            _gs_clear_anim(&explode[player]);
            _gs_set_anim_cell(&explode[player],0);
            boom[player]=0;
            }
         else
            _gs_anim_obj(&explode[player],explode[player].x,explode[player].y);
         }
      if (blowup[player])  /* if bullet should start exploding */
         {
         fire[player]=0;
         boom[player]=1;            /* flag explosion anim */
         _gs_move_anim(&explode[player],blowup[player]->anim->x+
            blowup[player]->anim->list->x_off - explode[player].width,
            blowup[player]->anim->y+blowup[player]->anim->list->y_off -
            (explode[player].height/2));
         _gs_enable_anim(&explode[player]); /* show explosion */
         _gs_clear_cplx(blowup[player]);    /* make bullet invisible again */
         blowup[player]=NULL;
         }
      if (gotcha[player])  /* if a player was hit */
         {
         _gs_set_anim_flicker(tank[player]);
         gotcha[player]=0;
         flicker[player]=FLICKER_DELAY;
         status = show_scores();      /* update scores, check end of game */
         }
      if (fire[player])    /* if player has a shot in the air */
         {
         if (bullet[player].anim->flags & (ANIM_BOUNDS_X1|ANIM_BOUNDS_X2|
            ANIM_BOUNDS_Y1|ANIM_BOUNDS_Y2))   /* if bullet hit edge of bitmap */
            {
            if (bounce) /* if bouncing bullets option */
               {
               if (bullet[player].anim->flags & (ANIM_BOUNDS_X1|ANIM_BOUNDS_X2))
                  bounce_em(&bullet[player],bullet[player].label,1);   /* hit vertical wall */
               else
                  bounce_em(&bullet[player],bullet[player].label,0);   /* hit horizontal wall */
               _gs_anim_cplx(&bullet[player],bullet[player].anim->x+bmove[player][0],
                  bullet[player].anim->y+bmove[player][1]);
               }
            else        /* else blow up bullet */
               {
               fire[player]=0;
               boom[player]=1;         /* flag explosion anim */
               _gs_move_anim(&explode[player],bullet[player].anim->x+
                  bullet[player].anim->list->x_off -
                  explode[player].width,bullet[player].anim->y+
                  bullet[player].anim->list->y_off -
                  (explode[player].height/2));
               _gs_enable_anim(&explode[player]);   /* show explosion */
               _gs_clear_cplx(&bullet[player]);   /* make bullet invisible again */
               _gs_start_sound(sound[player][MISS],channel[player][MISS]);
               }
            }
         else                        /* else move & animate bullet */
            _gs_anim_cplx(&bullet[player],bullet[player].anim->x+bmove[player][0],
               bullet[player].anim->y+bmove[player][1]);
         }
      if (turn[player])    /* don't turn too fast, else uncontrollable */
         turn[player]--;
      if (bdelay[player])  /* counter lets player shoot again before bullet exploded */
         bdelay[player]--;
      if (stick=_gs_joystick(player))  /* check if player leaning on 'da stick */
         {
         if ((stick & JOY_LEFT) && (!turn[player]))
            {
            if (tank[player]->cell)
               _gs_set_anim_cell(tank[player],tank[player]->cell-1);   /* turn left */
            else
               _gs_set_anim_cell(tank[player],tank[player]->count-1);  /* turn left */
            if (!(_gs_sound_check() & channel[player][MOVE]))
               _gs_start_sound(sound[player][MOVE],channel[player][MOVE]);
            turn[player]=TURN_RATE;
            }
         else if ((stick & JOY_RIGHT) && (!turn[player]))
            {
            if (tank[player]->cell < (tank[player]->count-1))
               _gs_set_anim_cell(tank[player],tank[player]->cell+1);   /* turn right */
            else
               _gs_set_anim_cell(tank[player],0);                      /* turn right */
            if (!(_gs_sound_check() & channel[player][MOVE]))
               _gs_start_sound(sound[player][MOVE],channel[player][MOVE]);
            turn[player]=TURN_RATE;
            }
         if ((stick & JOY_UP)&&(!bump[player][0])) /* move forward in current direction */
            {
            tank[player]->x+=move_x[tank[player]->cell];
            tank[player]->y+=move_y[tank[player]->cell];
            if (!(_gs_sound_check() & channel[player][MOVE]))
               _gs_start_sound(sound[player][MOVE],channel[player][MOVE]);
            }
         else if ((stick & JOY_DOWN)&&(!bump[player][1])) /* back up */
            {
            tank[player]->x-=move_x[tank[player]->cell];
            tank[player]->y-=move_y[tank[player]->cell];
            if (!(_gs_sound_check() & channel[player][MOVE]))
               _gs_start_sound(sound[player][MOVE],channel[player][MOVE]);
            }
         if ((stick & JOY_BUTTON1) && (!bdelay[player]))
            {                        /* if fire button pressed */
            fire[player]=1;
            _gs_enable_cplx(&bullet[player]);   /* make bullet visible */
            _gs_set_cplx_seq(&bullet[player],tank[player]->cell,
               tank[player]->x,tank[player]->y); /* set proper anim & placement */
                                    /* remember bullet movement */
            bmove[player][0]=move_x[tank[player]->cell]*bullet_speed;
            bmove[player][1]=move_y[tank[player]->cell]*bullet_speed;
            bdirect[player]=tank[player]->cell;   /* remember bullet direction */
            _gs_start_sound(sound[player][SHOOT],channel[player][SHOOT]);
            bdelay[player]=RELOAD_DELAY;
            blowup[player]=NULL;
            }
         bump[player][0]=bump[player][1]=0;   /* clear bump indicators */
         }
      }
   if ((display.flags & GSV_FLIP) && multitask)
      WaitTOF();                     /* give up CPU if multitasking */
   while (display.flags & GSV_FLIP); /* while page not flipped yet */
   _gs_draw_anims(dlist);            /* draw them anim objects! */
   gs_flip_display(&display,1);      /* switch to other display, sync */
   _gs_next_anim_page(dlist);         /* tell anim sys to use other bitmap */
   _gs_next_anim_page(dlist2);      /* sync options ptr to correct page */
   page^=1;                           /* keep track of display page */
   return(status);
}

/***************************************************************************/

int show_scores()

{
   char temp[40];

   sprintf(temp,"Gold Tank: %d ",score[0]);
   Move(&rp1,0,12);
   Text(&rp1,temp,13);
   Move(&rp2,0,12);
   Text(&rp2,temp,13);
   sprintf(temp,"Blue Tank: %d ",score[1]);
   Move(&rp1,216,12);
   Text(&rp1,temp,13);
   Move(&rp2,216,12);
   Text(&rp2,temp,13);
   if ((score[0] >= GAME_SCORE) || (score[1] >= GAME_SCORE))
      {
      if (score[0] > (score[1]+1))
         return(1);                     /* return player number + 1 */
      else if (score[1] > (score[0]+1))
         return(2);
      }
   return(0);
}

/***************************************************************************/

__stdargs void collision(anim1,anim2,coll1,coll2)
struct anim_struct *anim1;
struct anim_struct *anim2;
struct collision_struct *coll1;
struct collision_struct *coll2;

/*

This is the collision handler which gets called when objects bump into each
other (bullet to bullet, or bullet to tank).

*/

{
   if (coll1->type == TANK_BATTLE_TANK)   /* if object 1 is a tank */
      {
      if (!flicker[anim1->label])
         {
         gotcha[anim1->label]=1;   /* flag tank as hit */
         if (anim1->label != anim2->cplx->label)   /* if someone else shot it */
            score[anim2->cplx->label]++;           /* add one to opponent's score */
         else if (score[anim1->label])             /* else if shot himself */
            score[anim1->label]--;                 /* decrease his own score! */
         blowup[anim2->cplx->label]=anim2->cplx;   /* remove appropriate bullet */
         _gs_start_sound(sound[anim1->label][HIT],channel[anim1->label][HIT]);
         }
      }
   else if (coll2->type == TANK_BATTLE_TANK) /* if object 2 is a tank */
      {
      if (!flicker[anim2->label])
         {
         gotcha[anim2->label]=1;   /* flag tank as hit */
         if (anim2->label != anim1->cplx->label)   /* if someone else shot it */
            score[anim1->cplx->label]++;           /* add one to opponent's score */
         else if (score[anim2->label])             /* else if shot himself */
            score[anim2->label]--;                 /* decrease his own score! */
         blowup[anim1->cplx->label]=anim1->cplx;   /* remove appropriate bullet */
         _gs_start_sound(sound[anim2->label][HIT],channel[anim2->label][HIT]);
         }
      }
   else      /* else bullet to bullet impact, remove both bullets */
      {
      blowup[anim1->cplx->label]=anim1->cplx;
      blowup[anim2->cplx->label]=anim2->cplx;
      _gs_start_sound(sound[anim1->cplx->label][MISS],channel[anim1->cplx->label][MISS]);
      _gs_start_sound(sound[anim2->cplx->label][MISS],channel[anim2->cplx->label][MISS]);
      }
}

/***************************************************************************/

__stdargs void collision_bg(anim,coll,color)
struct anim_struct *anim;
struct coll_bg_struct *coll;
int color;

/*

This is the collision handler which gets called when objects collide with
certain background colors (walls & steel plates).

*/

{
   if (anim->img->collision->type == TANK_BATTLE_TANK)
      {
      if ((color == 16) || (color == 29) || (color == 28))
         {                               /* if tank to background collision */
         if (coll->area < 3)
            bump[anim->label][0]=1;      /* front is blocked */
         else
            bump[anim->label][1]=1;      /* rear is blocked */
         }
      }
   else if (color == 16)
      {
      blowup[anim->cplx->label]=anim->cplx;
      _gs_start_sound(sound[anim->cplx->label][MISS],channel[anim->cplx->label][MISS]);
      }
   else if ((color == 29) || (color == 28))
      {
      if (!bounce)
         {
         blowup[anim->cplx->label]=anim->cplx;
         _gs_start_sound(sound[anim->cplx->label][MISS],channel[anim->cplx->label][MISS]);
         }
      else if (color == 28)              /* vertical wall */
         bounce_em(anim->cplx,anim->cplx->label,1);
      else                               /* horizontal wall */
         bounce_em(anim->cplx,anim->cplx->label,0);
      }
}

/***************************************************************************/

void bounce_em(cplx,index,dir)
struct anim_cplx *cplx;
int index,dir;

{
   int snd=BOUNCE;

   switch (bdirect[index])
      {
      case 0:                  /* up */
         blowup[index]=cplx;
         snd=MISS;
         break;
      case 1:                  /* 30 degrees */
         if (dir)
            {
            bdirect[index]=11;
            bmove[index][0]=bmove_x[11];
            bmove[index][1]=bmove_y[11];
            }
         else
            {
            bdirect[index]=5;
            bmove[index][0]=bmove_x[5];
            bmove[index][1]=bmove_y[5];
            }
         break;
      case 2:                  /* 60 degrees */
         if (dir)
            {
            bdirect[index]=10;
            bmove[index][0]=bmove_x[10];
            bmove[index][1]=bmove_y[10];
            }
         else
            {
            bdirect[index]=4;
            bmove[index][0]=bmove_x[4];
            bmove[index][1]=bmove_y[4];
            }
         break;
      case 3:                  /* right */
         blowup[index]=cplx;
         snd=MISS;
         break;
      case 4:                  /* 120 degrees */
         if (dir)
            {
            bdirect[index]=8;
            bmove[index][0]=bmove_x[8];
            bmove[index][1]=bmove_y[8];
            }
         else
            {
            bdirect[index]=2;
            bmove[index][0]=bmove_x[2];
            bmove[index][1]=bmove_y[2];
            }
         break;
      case 5:                  /* 150 degrees */
         if (dir)
            {
            bdirect[index]=7;
            bmove[index][0]=bmove_x[7];
            bmove[index][1]=bmove_y[7];
            }
         else
            {
            bdirect[index]=1;
            bmove[index][0]=bmove_x[1];
            bmove[index][1]=bmove_y[1];
            }
         break;
      case 6:                  /* down */
         blowup[index]=cplx;
         snd=MISS;
         break;
      case 7:                  /* 210 degrees */
         if (dir)
            {
            bdirect[index]=5;
            bmove[index][0]=bmove_x[5];
            bmove[index][1]=bmove_y[5];
            }
         else
            {
            bdirect[index]=11;
            bmove[index][0]=bmove_x[11];
            bmove[index][1]=bmove_y[11];
            }
         break;
      case 8:                  /* 240 degrees */
         if (dir)
            {
            bdirect[index]=4;
            bmove[index][0]=bmove_x[4];
            bmove[index][1]=bmove_y[4];
            }
         else
            {
            bdirect[index]=10;
            bmove[index][0]=bmove_x[10];
            bmove[index][1]=bmove_y[10];
            }
         break;
      case 9:                  /* left */
         blowup[index]=cplx;
         snd=MISS;
         break;
      case 10:                  /* 300 degrees */
         if (dir)
            {
            bdirect[index]=2;
            bmove[index][0]=bmove_x[2];
            bmove[index][1]=bmove_y[2];
            }
         else
            {
            bdirect[index]=8;
            bmove[index][0]=bmove_x[8];
            bmove[index][1]=bmove_y[8];
            }
         break;
      case 11:                  /* 330 degrees */
         if (dir)
            {
            bdirect[index]=1;
            bmove[index][0]=bmove_x[1];
            bmove[index][1]=bmove_y[1];
            }
         else
            {
            bdirect[index]=7;
            bmove[index][0]=bmove_x[7];
            bmove[index][1]=bmove_y[7];
            }
         break;
      }
   _gs_start_sound(sound[index][snd],channel[index][snd]);
}

/***************************************************************************/
/* BAD PRACTICE ALERT! ptr to hardware keyboard reg used here!!            */
/* This is used because it's the fastest way to read keyboard values.      */

int check_abort()

{
   unsigned char key;

   key=*keybrd;
   if (key == 0x75)                  /* if user hits Esc key */
      return(1);                     /* abort positive */
   else if (key == 205)
      pause_game();                  /* pause game if user hit 'p' */
   return(0);
}

/***************************************************************************/

void pause_game()

{
   int done=0;
   struct IntuiMessage *msg;
   struct Window *pwindow;

   if (!multitask)
      Permit();
   ScreenToBack(screen);
   gs_old_display(&display);      /* show intuition display */
   if (!(pwindow=(struct Window *)OpenWindow(&pause_window)))
      {
      return;
      }
   while (!done)
      {
      WaitPort(pwindow->UserPort);
      while (msg=(struct IntuiMessage *)GetMsg(pwindow->UserPort))
         {
         if (msg->Class == CLOSEWINDOW)
            done=1;
         ReplyMsg((struct Message *)msg);
         }
      }
   CloseWindow(pwindow);
   ScreenToFront(screen);
   ActivateWindow(window);        /* reactivate tank window to trap keyboard hits */
   gs_show_display(&display,1);   /* show our display again */
   if (!multitask)
      Forbid();
}

/***************************************************************************/

void cleanup()

/* release all resources and memory */

{
   if (!multitask)
      Permit();               /* multitasking on while we clean up (no need for it off) */
   gs_close_vb_timer();
   gs_close_sound();          /* shut down sound system */
   if (shoot.data)
      gs_free_sound(&shoot);
   if (explode_hit.data)
      gs_free_sound(&explode_hit);
   if (explode_miss.data)
      gs_free_sound(&explode_miss);
   if (bounce1.data)
      gs_free_sound(&bounce1);
   if (bounce2.data)
      gs_free_sound(&bounce2);
   if (move.data)
      gs_free_sound(&move);
   if (dlist > -1)
      gs_free_display_list(dlist);
   if (dlist2 > -1)
      gs_free_display_list(dlist2);
   if (tank[0])
      gs_free_anim(tank[0],1);
   if (tank[1])
      gs_free_anim(tank[1],1);
   if (ptr)
      gs_free_anim(ptr,1);
   if (bullet)
      gs_free_cplx(bullet,PLAYERS);
   if (explode)
      gs_free_anim(explode,PLAYERS);
   if (bm3)
      gs_free_bitmap(bm3);
   gs_remove_display(&display);
   WaitTOF();
   WaitTOF();                 /* give Intuition time to process Esc chars */
   if (window)
      CloseWindow(window);
   if (screen)
      CloseScreen(screen);
   if (font)
      CloseFont(font);
}

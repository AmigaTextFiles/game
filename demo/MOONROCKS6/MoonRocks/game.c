/*
 * MOON ROCKS by Alan Bland.  This is an example game using the
 * GameSmith Development System.  You are free to use portions of
 * this source code for any purpose whatsoever.  This isn't
 * necessarily the best way to use GDS for this type of game,
 * but it shows usage of many of the components of GDS (anims,
 * anim complexes, sounds, scrolling background, multiple viewports,
 * RastPort usage, background collision detection).
 *
 * This game won't work on an OCS Amiga because of the large
 * scrolling superbitmap.  It may also require 1 meg of chip ram.
 *
 * The elvis animation is based on the "tiny elvis" public domain
 * screen hack for Microsoft Windows.  I changed it around quite
 * a bit to reduce the color palette and to make different dancing
 * motions from the original.
 *
 * Call CYBERMIGA BBS at 1-303-939-9923.  Lots of Amiga files!
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <math.h>
#include <intuition/intuition.h>
#include <exec/memory.h>
#include <exec/types.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>

#include <clib/exec_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>

#include "GameSmith:GameSmith.h"
#include "GameSmith:include/libraries/libptrs.h"
#include "GameSmith:include/proto/all_regargs.h"

/* header file for anim complexes */
#include "lc.h"
#include "rs.h"

#define DDEPTH  3
#define NUM_COLORS 8

#define VP2_HEIGHT 19
#define VP2_DEPTH 3
#define VP2_NUM_COLORS 8

#define DWIDTH 320
#define DHEIGHT (200-VP2_HEIGHT-3)
#define DISP_MODE 0

#define X_SCROLLPOS (DWIDTH/3)
#define Y_SCROLLTOP (DHEIGHT/4)
#define Y_SCROLLBOT (DHEIGHT/2)

/* this defines the vertical position below which the spacecraft
 * can collide with background objects.  see main loop comments.
 */
#define GROUND_THRESHOLD (bmheight-52)

/* this is how close (pixels) we must land to the target to win the game */
#define CLOSE_ENOUGH 250

#define MAX_FUEL 3000
#define LOW_FUEL 300

/* physical constants */
#define MAX_ALTITUDE 70000.0
#define MAX_RANGE 50000.0
#define GRAVITY 5.0
#define THRUST 10.0
#define SAFE_SPEED 200.0

/* To be strictly accurate, I think this should be 60 for NTSC, 50 for PAL */
#define TICKS_PER_SEC 60

/* joystick responsiveness - set to 0 for fastest */
#define JOY_INTERVAL 3

/* how often to animate the rock star */
#define DANCE_DELAY 5
unsigned char time_to_dance;
short dance_time;
unsigned char rockstar_visible;   /* is he visible? */
unsigned long rockstar_time;      /* next time that he changes animation */
unsigned char allow_rockstar;     /* allow him to materialize */
/*
 * The VP2 bitmap has several different control panel images which we
 * scroll into view as necessary.  The top image is the normal panel.
 * These constants define the scroll offset for each image.
 */
#define VP_PAUSED  VP2_HEIGHT
#define VP_NOWHERE (VP2_HEIGHT*2)
#define VP_VISIBLE (VP2_HEIGHT*3)
#define VP_CRASHED (VP2_HEIGHT*4)
#define VP_SUCCESS (VP2_HEIGHT*5)


unsigned long lunar_cmap[NUM_COLORS];
unsigned long vp2_cmap[VP2_NUM_COLORS];

/* need a copper list to turn off sprites */
unsigned short copper_list[] = {
    UC_WAIT, 0, 0, UC_NOSPRITES, UC_END
};

struct copper_struct copper = 
	{
	copper_list,
	NULL,
	NULL
	};
/*
 * vp is the viewport for the main viewing area.
 * vp2 is the control panel at the bottom of the screen.
 */

struct gs_viewport vp2 = {
    NULL,				/* ptr to next viewport */
    vp2_cmap,				/* ptr to color table */
    VP2_NUM_COLORS,			/* number of colors in table */
    &copper,				/* ptr to user copper list */
    VP2_HEIGHT,DWIDTH,VP2_DEPTH,	/* height, width, depth */
    0,0,				/* bmheight, bmwidth */
    DHEIGHT+2,0,			/* top & left viewport offsets */
    0,0,				/* X & Y bitmap offsets */
    0,					/* flags */
    NULL,NULL,				/* 2.xx & above compatibility stuff */
    NULL,NULL,				/* bitmap pointers */
    NULL,				/* future expansion */
    0,0,0,0				/* display clip (use nominal) */
};

struct gs_viewport vp = {
    &vp2,				/* ptr to next viewport */
    lunar_cmap,				/* ptr to color table */
    NUM_COLORS,				/* number of colors in table */
    NULL,				/* ptr to user copper list */
    DHEIGHT,DWIDTH,DDEPTH,		/* height, width, depth */
    0,0,				/* bmheight, bmwidth */
    0,0,				/* top & left viewport offsets */
    0,0,				/* X & Y bitmap offsets */
    0,					/* flags */
    NULL,NULL,				/* 2.xx & above compatibility stuff */
    NULL,NULL,				/* bitmap pointers */
    NULL,				/* future expansion */
    0,0,0,0				/* display clip (use nominal) */
};

struct display_struct lunar_display = {
    NULL,				/* ptr to previous display view */
    NULL,NULL,				/* 2.xx & above compatibility stuff */
    0,0,				/* X and Y display offsets (1.3 style) */
    DISP_MODE,				/* display mode ID */
    GSV_DOUBLE|GSV_SCROLLABLE,		/* flags (double buffered, scrollable) */
    &vp,				/* ptr to 1st viewport */
    NULL				/* future expansion */
};

struct anim_cplx *lem;			/* the spacecraft anim complex */
struct anim_cplx *rockstar;             /* the rock star anim complex */
struct display_struct *display;		/* points at lunar_display if it got created ok */
struct Interrupt *scroller=NULL;	/* interrupt handler for smooth scrolling */
int dlist=-1;				/* display list used with anim system */
int bmwidth;
int bmheight;
struct RastPort rp;			/* RastPort for writing text to the control panel */
struct BitMap *cp_bitmaps[2];		/* need to double-buffer bitmaps for RastPort */
struct TextAttr sysfont = {		/* control panel will be topaz.8 */
   "topaz.font", 8, 0, 0
};
struct TextFont *myfont;

short elapsed_mins;
short elapsed_secs;
short elapsed_ticks;

/*
 * The MED module uses channels 0 and 1.  Sound effects are on 2 and 3
 * except for the PING sound, which is only played without music so it's
 * on one of the music channels.
 */
#include "libproto.h"
struct MMD0 *tune;
struct Library *MEDPlayerBase;
   
/*
 * structures and channel assignments for each sound.
 */
#define THRUST_CHANNEL CHANNEL2
#define WHOOP_CHANNEL  CHANNEL3
#define PING_CHANNEL   CHANNEL1
#define FILL_CHANNEL   CHANNEL3
#define KABOOM_CHANNEL CHANNEL2
#define LANDED_CHANNEL CHANNEL3

struct sound_struct thrust;
struct sound_struct whoop;
struct sound_struct kaboom;
struct sound_struct landed;
struct sound_struct ping;
struct sound_struct fill;

/* the "lc" anim complex contains zillions of short anims showing the
   spacecraft at various rotation angles (increments of 15 degrees),
   with and without flames. the "lc_flame" array lists the anims with
   flames in clockwise rotation order.  "lc_noflame" lists the anims
   without flames. */

#define LC_ANIM_COUNT 24

short lc_flame[LC_ANIM_COUNT] = {
FLAME00, FLAME15, FLAME30, FLAME45, FLAME60, FLAME75,
FLAME90, FLAME105, FLAME120, FLAME135, FLAME150, FLAME165,
FLAME180, FLAME195, FLAME210, FLAME225, FLAME240, FLAME255,
FLAME270, FLAME285, FLAME300, FLAME315, FLAME330, FLAME345
};
short lc_noflame[LC_ANIM_COUNT] = {
LEM00, LEM15, LEM30, LEM45, LEM60, LEM75,
LEM90, LEM105, LEM120, LEM135, LEM150, LEM165,
LEM180, LEM195, LEM210, LEM225, LEM240, LEM255,
LEM270, LEM285, LEM300, LEM315, LEM330, LEM345
};

/* sines and cosines are pre-computed for each 15 degree rotational
   position.  this makes the game fast enough to run on an old
   68000 Amiga without a math chip. */

double sinval[LC_ANIM_COUNT] = {
-1.000000, -0.966168, -0.866519, -0.707840, -0.500941, -0.259916,
0.000000, 0.258771, 0.499914, 0.707002, 0.865927, 0.965862,
1.000000, 0.966015, 0.866223, 0.707421, 0.500428, 0.259344,
0.000593, -0.258199, -0.499401, -0.706583, -0.865630, -0.965708
};

double cosval[LC_ANIM_COUNT] = {
-0.000889, 0.257913, 0.499144, 0.706373, 0.865482, 0.965631,
1.000000, 0.965939, 0.866075, 0.707212, 0.500171, 0.259058,
0.000296, -0.258485, -0.499658, -0.706792, -0.865778, -0.965785,
-1.000000, -0.966092, -0.866371, -0.707630, -0.500684, -0.259630
};


/* The "craft" structure defines the current physical attributes of
   the spacecraft. */

struct {
    int fuel;        /* fuel remaining */
    int index;       /* array index into lc_flame/lc_noflame which indicates
			the current rotation of the spacecraft */
    int collision;   /* did the craft collide with something */
    double altitude; /* altitude above surface */
    double range;    /* position along surface */
    double vel_x;    /* velocity x component */
    double vel_y;    /* velocity y component */
    double vel;      /* velocity vector */
    double prev_vel; /* previous velocity - need for landing speed */
} craft;

/*
 * calculate the new position of the spacecraft.  "burn" is 1 if we are
 * currently burning fuel, 0 if not.  we maintain a coordinate system
 * using altitude and range, and convert to screen x,y coordinates.
 * return value indicates whether we actually burned any fuel.
 * you could probably make this function faster...
 */

int compute_pos(int burn)
{
    double v0;
    double x0;
    double accel_x;
    double accel_y;
    int did_burn;
    
    /* burn some fuel if there's any left */
    if (burn && craft.fuel) {
	accel_x = (THRUST - GRAVITY) * cosval[craft.index];
	accel_y = -(THRUST - GRAVITY) * sinval[craft.index];
	--craft.fuel;
	did_burn = 1;
    } else {
	accel_x = 0;
	accel_y = -GRAVITY;
	did_burn = 0;
    }
    
    v0 = craft.vel_x;
    craft.vel_x = v0 + accel_x;
    x0 = craft.range;
    craft.range = x0 + v0 + (accel_x/2);
    if (craft.range < 0) {
	/* bounce off the edge of the moon (lose some velocity) */
	craft.range = 0;
	craft.vel_x = -craft.vel_x/3;
	accel_x = -accel_x/3;
    }
    else if (craft.range >= MAX_RANGE) {
	craft.range = MAX_RANGE;
	craft.vel_x = -craft.vel_x/3;
	accel_x = -accel_x/3;
    }

    v0 = craft.vel_y;
    craft.vel_y = v0 + accel_y;
    x0 = craft.altitude;
    craft.altitude = x0 + v0 + (accel_y/2);
    if (craft.altitude < 0) {
	craft.altitude = 0;
	craft.vel_y = 0;
	accel_y = 0;
    }
    else if (craft.altitude >= MAX_ALTITUDE) {
	craft.altitude = MAX_ALTITUDE;
	craft.vel_y = 0;
    }

    /* calculate velocity vector */
    craft.prev_vel = craft.vel;
    craft.vel = sqrt(craft.vel_x * craft.vel_x + craft.vel_y * craft.vel_y);

    /* convert lunar position to bitmap coordinates */
    lem->anim->x = craft.range * bmwidth / MAX_RANGE;
    lem->anim->y = (bmheight-30) - (craft.altitude * (bmheight-30) / MAX_ALTITUDE);

    return did_burn;
}

/*
 * collision handler for craft-to-background checks.  the pallete has been
 * created such that the background colors of interest are in the third
 * bitplane (colors 4,5,6,7).  we want to ignore the mountains but collide
 * with the rocks on the ground, so the collision handler is enabled only
 * below a certain altitude.  see the main loop for where we enable and
 * disable the collision handler.
 */
void grounded(struct anim_struct *anim, struct coll_bg_struct *point, int color)
{
    craft.collision = color;
}

/*
 * show current stats on the control panel
 */
void show_stats(void)
{
    char cpbuf[30];
    
    /* update current information on the control panel */
    SetAPen(&rp, 3); /* green */

    /* divide altitude and velocity by 10 for a more reasonable output */
    sprintf(cpbuf, "%05d", (int)craft.altitude / 10);
    Move(&rp, 22, 12);
    Text(&rp, cpbuf, 5);
    sprintf(cpbuf, "%05d", (int)craft.vel / 10);
    Move(&rp, 85, 12);
    Text(&rp, cpbuf, 5);
    if (craft.fuel <= LOW_FUEL) {
	SetAPen(&rp, 2); /* red */
    }
    sprintf(cpbuf, "%05d", (int)craft.fuel);
    Move(&rp, 153, 12);
    Text(&rp, cpbuf, 5);

    SetAPen(&rp, 3); /* green */
    sprintf(cpbuf, "%02d:%02d", elapsed_mins, elapsed_secs);
    Move(&rp, 219, 12);
    Text(&rp, cpbuf, 5);
}

/*
 * VB interrupt handler: scroll the display when the spacecraft
 * gets near one of the edges.
 */

unsigned long vbcounter;

void __interrupt __saveds scroll(void)
{
    int dx, dy;

    ++vbcounter;
    
    /* keep track of elapsed time */
    if (++elapsed_ticks == TICKS_PER_SEC) {
	elapsed_ticks = 0;
	if (++elapsed_secs == 60) {
	    elapsed_secs = 0;
	    ++elapsed_mins;
	}
    }
    
    /* keep track of when it's ok for the rock star to dance */
    if (--dance_time <= 0) {
	time_to_dance = 1;
	dance_time = DANCE_DELAY;
    }

    /* don't scroll if showing the explosion */
    if (lem->seq == BOOM) {
	return;
    }
    
    if (lem->anim->x < vp.xoff + X_SCROLLPOS) {
	dx = vp.xoff + X_SCROLLPOS - lem->anim->x;
    } else if (lem->anim->x > vp.xoff + DWIDTH - X_SCROLLPOS) {
	dx = vp.xoff + DWIDTH - X_SCROLLPOS - lem->anim->x;
    } else {
	dx = 0;
    }

    if (lem->anim->y < vp.yoff + Y_SCROLLTOP) {
	dy = vp.yoff + Y_SCROLLTOP - lem->anim->y;
    } else if (lem->anim->y > vp.yoff + DHEIGHT - Y_SCROLLBOT) {
	dy = vp.yoff + DHEIGHT - Y_SCROLLBOT - lem->anim->y;
    } else {
	dy = 0;
    }

    if (dx != 0 || dy != 0) {
	gs_scroll_vp(display, 0, -dx, -dy, 1);
    }
}


/*
 * delay specified number of vb ticks, sync with display
 */
void mydelay(int vbticks)
{
    int n = vbcounter + vbticks;
    while (vbcounter < n);
    while (display->flags & GSV_FLIP);	/* while page not flipped yet */
}

/*
 * display an error message (we should never need this)
 */

struct IntuiText hdrtext = { 1,0,JAM2,10,16,NULL,NULL,NULL };
struct IntuiText fataltext = { 2,0,JAM2,10,32,NULL,NULL,&hdrtext };
struct IntuiText canceltext = { 1,0,JAM2,7,3,NULL,"Cancel",NULL };

void myerror(char *text)
{
    hdrtext.IText = "Bad news from the moon...";
    fataltext.IText = text;
    AutoRequest(NULL, &fataltext, NULL, &canceltext, 0, 0, 600, 90);
}

/*
 *  cleanup all resources and exit
 */

void cleanup(void)
{
    gs_close_sound();
    gs_free_sound(&thrust);
    gs_free_sound(&whoop);
    gs_free_sound(&ping);
    gs_free_sound(&fill);
    gs_free_sound(&kaboom);
    gs_free_sound(&landed);
    
    if (dlist > -1) _gs_free_display_list(dlist);
    if (scroller) _gs_remove_vb_server(scroller);
    if (lem) gs_free_cplx(lem, 1);
    if (rockstar) gs_free_cplx(rockstar, 1);
    if (display) gs_remove_display(display);
    /* since we allocated our own bitmaps we must free them */
    if (vp.bitmap1) gs_free_bitmap(vp.bitmap1);
    if (vp.bitmap2) gs_free_bitmap(vp.bitmap2);
    if (vp2.bitmap1) gs_free_bitmap(vp2.bitmap1);
    if (vp2.bitmap2) gs_free_bitmap(vp2.bitmap2);

    /* free up MED stuff */
    if (tune) {
	StopPlayer();
	UnLoadModule(tune);
	FreePlayer();
    }
    if (MEDPlayerBase) CloseLibrary(MEDPlayerBase);
    
    gs_close_libs();
    exit(0);
}


/*
 * setup all game data
 */

int setup(void)
{
    struct anim_load_struct load = {
	"lc.cplx", 0, 0, 0, 0, 8, 0, 1, ANIMLOAD_NOCOLOR
    };
    struct anim_load_struct loadrs = {
	"rs.cplx", 0, 0, 0, 0, 8, 0, 1, ANIMLOAD_NOCOLOR
    };
    struct loadILBM_struct loadimg = {
	"landscape.iff", 0, 0, lunar_cmap, NUM_COLORS, 0, 0, 0, 0, 0, 0, 0,
	ILBM_COLOR | ILBM_ALLOC2, 0xff, 0xff
    };
    struct loadILBM_struct loadimg2 = {
	"panel.iff", 0, 0, vp2_cmap, VP2_NUM_COLORS, 0, 0, 0, 0, 0, 0, 0,
	ILBM_COLOR | ILBM_ALLOC2, 0xff, 0xff
    };

    int result;
    int page;
    
    /* open amiga libraries */
    if (gs_open_libs(DOS|GRAPHICS|INTUITION|MATHDBLB|MATHDBLT|MATHTRANS,0)) {
	exit(1);
    }

    /* Open the MEDplayer library */
    MEDPlayerBase=(struct Library *)OpenLibrary("medplayer.library",0);
    if (!MEDPlayerBase) {
	myerror("Need medplayer.library");
	return -1;
    }
    
    /* Load the mod */
    tune = LoadModule("mod.MoonRocks");
    if (!tune) {
	myerror("Couldn't load mod.MoonRocks");
	return -1;
    }

    /* Initialize the MED player */
    if (GetPlayer(0)) {
	myerror("Can't Initialize MED player!");
    }
	
    /*
     * load the lunar landscape. this creates two superbitmaps for the
     * double-buffered scrolling viewport, and fills in the color table
     * used by all game objects.
     */
    result = gs_loadILBM(&loadimg);
    if (result) {
	myerror(loadimg.file);
	return result;
    }

    /* viewport will use the bitmaps just allocated */
    vp.bitmap1 = loadimg.bitmap1;
    vp.bitmap2 = loadimg.bitmap2;
    bmwidth=vp.bitmap1->BytesPerRow*8;
    bmheight=vp.bitmap1->Rows;

    /* load the control panel image */
    result = gs_loadILBM(&loadimg2);
    if (result) {
	myerror(loadimg.file);
	return result;
    }
    vp2.bitmap1 = loadimg2.bitmap1;
    vp2.bitmap2 = loadimg2.bitmap2;
    cp_bitmaps[0] = vp2.bitmap1;
    cp_bitmaps[1] = vp2.bitmap2;
    
    /* control panel needs a RastPort so we can draw text to it */
    InitRastPort(&rp);
    rp.BitMap = vp2.bitmap1;
    SetDrMd(&rp, JAM2);
    SetBPen(&rp, 0); /* black */
    
    /* force topaz.8 in the control panel */
    myfont = OpenFont(&sysfont);
    if (!myfont) {
	myerror("Can't open topaz.8 font");
	return -1;
    }
    SetFont(&rp, myfont);

    /* load the spacecraft anim */
    if (result = gs_load_anim(&load)) {
	myerror(load.filename);
	return result;
    }
    
    /* get pointer to the loaded anim */
    lem = load.anim_ptr.cplx;

    /* load the rock star anim */
    if (result = gs_load_anim(&loadrs)) {
	myerror(loadrs.filename);
	return result;
    }
    
    /* get pointer to the loaded anim */
    rockstar = loadrs.anim_ptr.cplx;

    /* create the display */
	#ifdef NTSC_MONITOR_ID
		if (GfxBase->LibNode.lib_Version >= 36)	/* if WB 2.0 or higher */
			{					/* this defeats mode promotion on AGA machines */
			if (ModeNotAvailable(NTSC_MONITOR_ID))
				{
				lunar_display.modes = PAL_MONITOR_ID;
				}
			else
				{
				lunar_display.modes = NTSC_MONITOR_ID;
				}
			}
	#endif
    result = gs_create_display(&lunar_display);
    if (result) {
	myerror("gs_create_display failed");
	return result;
    }
    display = &lunar_display;
    
    if ((dlist=_gs_get_display_list()) < 0) {
	myerror("gs_get_display_list failed");
	return result;
    }

    /* perform other anim initialization */
    gs_init_anim(dlist,display->vp->bitmap1, display->vp->bitmap2);
    gs_set_anim_bounds(dlist,0, 0, bmwidth-1, bmheight-1);
    gs_random(0);

    /* setup the sound system and load the sounds */
    if (gs_open_sound(0,1,-10,2560)) {
	myerror("gs_open_sound failed");
	return -1;
    }

    /* sound of the thrusters */
    thrust.flags = SND_FAST;
    if (result=gs_load_iff_sound(&thrust,0,"thrust.snd")) {
	myerror("cannot load thrust.snd");
	return result;
    }
    thrust.repeat = 0; /* loop forever */
    
    /* low fuel alert */
    whoop.flags = SND_FAST;
    if (result=gs_load_iff_sound(&whoop,0,"whoop.snd")) {
	myerror("cannot load whoop.snd");
	return result;
    }
    whoop.repeat = 0; /* loop forever */
    
    /* a nice explosion */
    kaboom.flags = SND_FAST;
    if (result=gs_load_raw_sound(&kaboom,"kaboom.snd")) {
	myerror("cannot load kaboom.snd");
	return result;
    }

    /* startrek bridge sound */
    ping.flags = SND_FAST;
    if (result=gs_load_raw_sound(&ping,"ping.snd")) {
	myerror("cannot load ping.snd");
	return result;
    }
    ping.repeat = 0; /* loop forever */
    
    /* sound played when filling the gas tank */
    fill.flags = SND_FAST;
    if (result=gs_load_iff_sound(&fill,0,"fill.snd")) {
	myerror("cannot load fill.snd");
	return result;
    }
    fill.repeat = 0; /* loop forever */

    /* sound played when landing is successful */
    landed.flags = SND_FAST;
    if (result=gs_load_iff_sound(&landed,0,"landed.snd")) {
	myerror("cannot load landed.snd");
	return result;
    }

    /* add the anims to the display */
    if (result = gs_add_anim_cplx(dlist,lem, 0, 0, lc_noflame[craft.index], 0)) {
	myerror("gs_add_anim_cplx failed");
	return result;
    }
    if (result = gs_add_anim_cplx(dlist,rockstar, 0, 0, DANCE1, 0)) {
	myerror("gs_add_anim_cplx failed");
	return result;
    }

    gs_draw_anims(dlist);
    page = gs_next_anim_page(dlist);
    rp.BitMap = cp_bitmaps[page];

    /* even more anim initialization */
    gs_show_display(display,1);
    gs_flip_display(display,1);
    
    /* setup the scrolling routine */
    scroller = gs_add_vb_server(&scroll, 0);
    if (!scroller) {
	myerror("gs_add_vb_server failed");
	return -5;
    }
    
    /* setup collision handler for things on the ground */
    gs_set_collision_bg(dlist, grounded);

    return 0;
}

/*
 * flip to the next display page, making sure that the
 * rastport bitmap for the control panel is in sync.
 */
void flipper(void)
{
    int page;

    gs_draw_anims(dlist);
    page = gs_next_anim_page(dlist);
    rp.BitMap = cp_bitmaps[page];
    gs_flip_display(display,1);
}

/*
 * Start background noise - depending on whether the rock star is
 * visible, it's either the startrek bridge sound, or some music.
 */
void start_background_noise(void)
{
    if (rockstar_visible) {
	/* Continue playing the mod */
	ContModule(tune);
    } else {
	gs_start_sound(&ping, PING_CHANNEL);
    }
}

/*
 * Stop whichever background noise is playing.
 */
void stop_background_noise(void)
{
    if (rockstar_visible) {
	/* Stop playing the mod */
	StopPlayer();
    } else {
	gs_stop_sound(PING_CHANNEL);
    }
}

/*
 * animate the dancing rock star.  time_to_dance is set in the vb interrupt
 * when enough time has elapsed to do the next dance frame.  rockstar_time is
 * when it's time to switch to a different dance, or when to make him
 * materialize if he's currently invisible.
 */
void dance(void)
{
    if (rockstar_visible) {
	/* switch to a different dance animation every once in awhile */
	if (vbcounter >= rockstar_time) {
	    if (rockstar->seq == DANCE1) {
		gs_set_cplx_seq(rockstar, DANCE2, rockstar->anim->x, rockstar->anim->y);
	    } else {
		gs_set_cplx_seq(rockstar, DANCE1, rockstar->anim->x, rockstar->anim->y);
	    }
	    
	    /* switch again at a random time */
	    rockstar_time = vbcounter + (gs_random(5) + 5) * TICKS_PER_SEC;
	}
	if (time_to_dance) {
	    time_to_dance = 0;
	    gs_anim_cplx(rockstar, rockstar->anim->x, rockstar->anim->y);
	}
    }
    else if (vbcounter >= rockstar_time && allow_rockstar) {

	/* time for him to materialize */
	gs_enable_cplx(rockstar);
	rockstar_visible = 1;

	/* he materializes in the reclining position and must stand up */
	gs_set_cplx_seq(rockstar, STANDUP, rockstar->anim->x, rockstar->anim->y);
	gs_set_cplx_cell(rockstar, 0);

	/* he'll start dancing in three seconds */
	rockstar_time = vbcounter + 3 * TICKS_PER_SEC;

	/* stop the ping and start the music he'll be dancing to */
	gs_stop_sound(PING_CHANNEL);
	PlayModule(tune);
    }
}

void show_panel(int offset)
{
    gs_scroll_vp(display, 1, 0, offset, 1);
}

/*
 * user paused the game
 */
void pause_game(int current_panel)
{
    /* user pressed LMB to get here, wait for it to be released */
    while (gs_joystick(0)&JOY_BUTTON1) {}

    /* scroll the control panel to show the pause display */
    show_panel(VP_PAUSED - current_panel);
    
    /* wait for response */
    while (1) {
	if (gs_joystick(0) & JOY_BUTTON1) {
	    /* mouse button - resume game */
	    /* but wait for LMB to be released first */
	    while (gs_joystick(0)&JOY_BUTTON1) {}

	    /* scroll the control panel to return to the game display */
	    show_panel(-VP_PAUSED + current_panel);
	    return;
	}
	if (gs_joystick(1) & JOY_BUTTON1) {
	    /* joystick button - quit game */
	    Permit();
	    cleanup();
	}

	/* dance continues even while paused */
	dance();
	mydelay(1);
	flipper();
    }
}

/*
 * landed at fuel station
 */
void refuel(void)
{
    stop_background_noise();
    mydelay(25);
    gs_start_sound(&fill, FILL_CHANNEL);

    craft.vel_x = 0;
    craft.vel_y = 0;
    craft.index = 0;
    gs_set_cplx_seq(lem, LEM00, lem->anim->x, lem->anim->y);

    /* fill the tank */
    while (craft.fuel < MAX_FUEL) {
		
	craft.fuel += 3;
	if (craft.fuel > MAX_FUEL) {
	    craft.fuel = MAX_FUEL;
	}

	if (gs_joystick(0)&JOY_BUTTON1) {

	    pause_game(0);
	}

	show_stats();
	gs_anim_cplx(lem, lem->anim->x, lem->anim->y);
	dance();

	mydelay(1);
	flipper();
    }
    gs_stop_sound(FILL_CHANNEL);
    mydelay(25);
    start_background_noise();

    /* wait for liftoff */
    while (1) {

	if (gs_joystick(0)&JOY_BUTTON1) {

	    pause_game(0);
	}

	if (gs_joystick(1) & JOY_BUTTON1) {

	    /* need to give the craft a good kick to get it away from the
	     * fuel platform.  otherwise the collision detection in the
	     * main loop will bring us right back here.
	     */
	    craft.altitude += 500;
	    craft.collision = 0;
	    return;
	}

	/* continue page-flipping to show the clock ticking */
	show_stats();
	gs_anim_cplx(lem, lem->anim->x, lem->anim->y);
	dance();
	mydelay(1);
	flipper();
    }
	    
}

/*
 * spacecraft crashed into something
 */
void crash(void)
{
    int i;
    
    stop_background_noise();
    gs_stop_sound(THRUST_CHANNEL);
    gs_stop_sound(WHOOP_CHANNEL);
    gs_start_sound(&kaboom, KABOOM_CHANNEL);

    /* show the crashed control panel */
    show_panel(VP_CRASHED);
    
    /* adjust anim position because explosion is bigger than craft */
    lem->anim->x -= 40;
    lem->anim->y -= 20;
    gs_set_cplx_seq(lem, BOOM, lem->anim->x, lem->anim->y);
    gs_set_cplx_cell(lem, 0);

    /* animate the explosion for a few seconds */
    for (i = 0; i < 90; i++) {
		
	if (gs_joystick(0)&JOY_BUTTON1) {

	    pause_game(VP_CRASHED);
	}
	show_stats();
	gs_anim_cplx(lem, lem->anim->x, lem->anim->y);
	dance();
	    
	/* explosion sequence is slower than main animation */
	mydelay(5);
	flipper();
    }

    /* restore the main control panel */
    show_panel(-VP_CRASHED);

    /* in case he appeared while we crashed... */
    stop_background_noise();
}

/*
 * successful landing.  returns non-zero if won the game, else 0.
 */
int safe_landing(void)
{
    int panel;
    int dist;
    
    /* wait for joystick button to be released */
    while (gs_joystick(1)&JOY_BUTTON1) {}

    gs_stop_sound(THRUST_CHANNEL);
    craft.vel_x = 0;
    craft.vel_y = 0;
    craft.index = 0;
    gs_set_cplx_seq(lem, LEM00, lem->anim->x, lem->anim->y);

    /* did we land near the rock star? */
    if (rockstar_visible) {

	dist = abs(rockstar->anim->x - lem->anim->x);
	if (dist <= CLOSE_ENOUGH) {

	    /* we have a winner! */
	    panel = VP_SUCCESS;
	    show_panel(panel);

	    gs_stop_sound(WHOOP_CHANNEL);

	    /* Stop playing the mod */
	    StopPlayer();
	    mydelay(5);
	    gs_start_sound(&landed, LANDED_CHANNEL);
	    mydelay(5);

	    /* what for congrats to finish, then restart the mod */
	    while (gs_sound_check() & LANDED_CHANNEL) {}
	    PlayModule(tune);
	    
	} else {

	    /* didn't land close enough */
	    panel = VP_VISIBLE;
	    show_panel(panel);
	}
	
    } else {
	/* he's not even visible yet! */
	panel = VP_NOWHERE;
	show_panel(panel);
    }


    /* wait for liftoff */
    while (1) {

	if (gs_joystick(0)&JOY_BUTTON1) {

	    pause_game(panel);
	}

	if (gs_joystick(1) & JOY_BUTTON1) {

	    craft.altitude += 300;
	    craft.collision = 0;

	    /* flip back to the main control panel */
	    show_panel(-panel);

	    /* return result of landing close */
	    if (panel == VP_SUCCESS) {
		stop_background_noise();
		return 1;
	    } else {
		start_background_noise();
		return 0;
	    }
	}

	show_stats();
	gs_anim_cplx(lem, lem->anim->x, lem->anim->y);
	dance();
	mydelay(5);
	flipper();
    }
}

/*
 * main program:  set everything up and then play the game (duh...)
 */

void main(void)
{
    int result;
    unsigned char joy;
    int burn;
    int thrusting = 0;
    int joycount;
    
    /* setup the animation system */
    if ((result = setup()) != 0) {
	char err[60];
	sprintf(err, "setup failed (%d)", result);
	myerror(err);
	cleanup();
    }

    /* play multiple times until mouse button is pressed */
    Forbid();
    while (1) {
	
	/*
	 * spacecraft begins with a full tank, at a random position and
	 * velocity.  what's really cool about this is that the scroll
	 * interrupt will automatically reposition the superbitmap so
	 * that the spacecraft is visible.  the main loop never has
	 * to care what the physical display looks like!
	 */
	craft.fuel = MAX_FUEL;
	craft.altitude = MAX_ALTITUDE;
	craft.range = (gs_random(bmwidth - 200) + 100) * MAX_RANGE / bmwidth;
	craft.vel_x = gs_random(200) - 100;
	if (craft.vel_x > 0) {
	    craft.index = LC_ANIM_COUNT-1;
	} else {
	    craft.index = 1;
	}
	craft.vel_y = 0;
	craft.collision = 0;
	compute_pos(0);

	/* reset the elapsed time counter */
	elapsed_mins = 0;
	elapsed_secs = 0;
	elapsed_ticks = 0;
	
	/* place rock star at a random ground position */
	rockstar->anim->x = gs_random(bmwidth - 100) + 50;
	rockstar->anim->y = bmheight-30;
    
	/* but he's invisible for awhile */
	gs_clear_cplx(rockstar);
	rockstar_visible = 0;
	allow_rockstar = 1;
	
	/* he will materialize at a random time at least 40 seconds after
	   the start of the game. */
	rockstar_time = vbcounter + (40 + gs_random(90)) * TICKS_PER_SEC;
	
	joycount = JOY_INTERVAL;

	show_stats();
	
	start_background_noise();
	
	/*
	 * Here is the main game loop.  Simply watch the joystick and move
	 * the anim around appropriately.  We continue in this inner loop
	 * until we land near the target or we crash.
	 */
	while (1) {

	    if (gs_joystick(0)&JOY_BUTTON1) {

		pause_game(0);
	    }

	    /*
	     * Check the joystick.  Left and right will rotate the spacecraft
	     * 15 degrees in either direction.  Button will burn some fuel.
	     */
	    joy = gs_joystick(1);
	    
	    /*
	     * Check rotational motion every JOY_INTERVAL times through this
	     * loop.  If we check it too often, the spacecraft rotates too
	     * fast to be playable.  Thrust button is checked every time.
	     */
	    if (--joycount <= 0) {
		joycount = JOY_INTERVAL;
		
		if (joy & JOY_RIGHT) {
		    /* rotate clockwise */
		    if (++craft.index == LC_ANIM_COUNT) craft.index = 0;
		} else if (joy & JOY_LEFT) {
		    /* rotate counter-clockwise */
		    if (--craft.index < 0) craft.index = LC_ANIM_COUNT-1;
		}	    
	    }
	    
	    if (joy & JOY_BUTTON1) {
		/* calculate the next spacecraft position with full throttle */
		burn = compute_pos(1);
	    } else {
		/* calculate the next spacecraft position with no throttle */
		burn = compute_pos(0);
	    }
	    
	    /* show the spacecraft with or without flame depending on whether
	       we burned any fuel */
	    if (burn) {

		/* we burned fuel this time.  show the spacecraft with flame */
		gs_set_cplx_seq(lem, lc_flame[craft.index], lem->anim->x, lem->anim->y);
		/* turn on the thrust sound if it's not already on */
		if (!thrusting) {
		    thrusting = 1;
		    gs_start_sound(&thrust, THRUST_CHANNEL);
		}

		if (craft.fuel == LOW_FUEL) {
		    /* we're running on fumes! */
		    gs_start_sound(&whoop, WHOOP_CHANNEL);
		} else if (craft.fuel == 0) {
		    /* not even any fumes left! */
		    gs_stop_sound(WHOOP_CHANNEL);
		    gs_stop_sound(THRUST_CHANNEL);
		    stop_background_noise();
		    thrusting = 0;
		}
	    
	    } else {
		/* no fuel burned this time, show spacecraft without flame */
		gs_set_cplx_seq(lem, lc_noflame[craft.index], lem->anim->x, lem->anim->y);
		/* turn off thrust sound if necessary */
		if (thrusting) {
		    gs_stop_sound(THRUST_CHANNEL);
		    thrusting = 0;
		}
	    }
	
	    /* we want background collision checking to occur only when the
	     * spacecraft is near the bottom of the bitmap (i.e. it can crash
	     * into the rocks on the ground but not the mountains in the
	     * distance).  we check the ANIM_COLLISION_BG bit in the flags
	     * so that we enable or disable collision checking only once
	     * each time we cross the threshold.
	     */
	    if (lem->anim->y > GROUND_THRESHOLD && !(lem->anim->flags & ANIM_COLLISION_BG)) {
		gs_enable_cplx_collision_bg(lem);
	    } else if (lem->anim->y <= GROUND_THRESHOLD && (lem->anim->flags & ANIM_COLLISION_BG)) {
		gs_disable_cplx_collision_bg(lem);
	    }

	    /* show current stats */
	    show_stats();

	    /* show the next spacecraft animation frame as determined above */
	    gs_anim_cplx(lem, lem->anim->x, lem->anim->y);
	    
	    /* rock star is dancing */
	    dance();
	    
	    /* update the off-screen bitmap, then display it */
	    mydelay(1);
	    flipper();

	    /* if we landed on the fuel platform, fill 'er up */
	    /* this happens if collide with background color white or yellow */
	    /* make sure landed slowly and more-or-less upright */
	    if (craft.collision == 5 || craft.collision == 6) {

		if (craft.prev_vel <= SAFE_SPEED &&
		    (craft.index == 0 || craft.index == 1 || craft.index == LC_ANIM_COUNT-1)) {
		    /* landed on platform ok */
		    if (craft.fuel < MAX_FUEL) {
			gs_stop_sound(THRUST_CHANNEL);
			thrusting = 0;
			refuel();
		    }
		} else {
		    /* crashed on platform */
		    crash();
		    break;
		}
	    } else if (craft.collision) {
		/* collided with a rock */
		crash();
		break;
	    } else if (craft.altitude == 0) {
		/* on the ground, let's see how we landed */
		gs_stop_sound(THRUST_CHANNEL);
		gs_stop_sound(WHOOP_CHANNEL);

		/* don't let rock star appear nearby if he's not visible yet */
		if (!rockstar_visible) {
		    gs_stop_sound(PING_CHANNEL);
		    allow_rockstar = 0;
		}
		
		craft.vel = 0;
		mydelay(2);

		if (craft.prev_vel <= SAFE_SPEED &&
		    (craft.index == 0 || craft.index == 1 || craft.index == LC_ANIM_COUNT-1)) {
		    /* a gentle upright landing! */
		    thrusting = 0;
		    if (safe_landing()) {
			/* won the game, start over */
			break;
		    }
		    /* otherwise continue the search */
		    allow_rockstar = 1;

		    /* if we sat on the ground waiting for him to appear,
		       don't let him appear right away */
		    if (!rockstar_visible) {
			rockstar_time = vbcounter + (gs_random(5) + 20) * TICKS_PER_SEC;
		    }
		} else {
		    /* too fast or tilted or hit a rock */
		    crash();
		    break;
		}
	    }
	}
    }
}


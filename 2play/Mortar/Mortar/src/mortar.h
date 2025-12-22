/*
 * MORTAR
 * 
 * -- declarations, definitions and classes / structures
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */

#ifndef __MORTAR_H
#define __MORTAR_H

/* only places for platform specific stuff is here, in
 * win-*.c, snd-*.c files and in frame.c.
 */
#ifdef AMIGA
# include "amiga.h"   /* emulated function */
#else
# include <unistd.h>
# include <sys/time.h>
# include <sys/stat.h>    /*  only needed by message.c */
#endif

/* If this is defined, users can't change game config filename, image path
 * or the language filename.  Using bogus values for them can chrash Mortar.
 * Check the default configuration file for more settings.
 */
#undef DEFAULT_PATH

/* default configuration file name */
#define CONFIG_FILE "config.def"


/* Mortar allocates memory when game is initialized.  These tell how
 * much is needed.
 */
#define MAX_PLAYERS 6 /* max number of players, see game_init() */

#define MAX_ITEMS 32  /* number of different items / player */
#define MAX_SHOTS 32  /* max shots flying at the same time */

#define MAX_TYPELEN 32  /* max shot type name lenght */


#define DEF_SHOTS 5000  /* number of basic shots at startup */

#define DEF_ANGLE 90  /* player cannon direction at start */
#define DEF_POWER 50  /* startup power, percentage of max */

#define FIXBITS   8 /* fixed point accuracy */


/* do not use ESC as for example arrow keys output escape sequences... */
#define GAME_EXIT(key)  (key == 'q' || key == 'Q')

/* NOTE: if you want to change these, rebind them in win_getkey() rather than
 * here, especially if you're mapping them to terminal/OS specific keys
 * like arrow keys
 */

/* use keypad for power/angle selection */
#define KEY_UP    '8'
#define KEY_DOWN  '2'
#define KEY_LEFT  '4'
#define KEY_RIGHT '6'
#define KEY_HOME  '7'
#define KEY_CENTER  '5'
#define KEY_END   '1'
#define KEY_PGUP  '9'
#define KEY_PGDOWN  '3'
#define KEY_SELECT  ' '
#define KEY_ACCEPT1 '\r'
#define KEY_ACCEPT2 '\n'


#ifndef SRND
#define SRND(x) (srand(x))
#endif
#ifndef RND
#define RND(x)  (rand() % (x))
#endif


typedef unsigned char m_uchar;

typedef struct {
  m_uchar r;
  m_uchar g;
  m_uchar b;
} m_rgb_t;

typedef struct {
  m_uchar *data;
  m_rgb_t *palette;
  int wd, ht;
  int colors;
} m_image_t;


typedef struct _m_list_t {
  struct _m_list_t *prev;
  struct _m_list_t *next;

  int count;
  int type;
} m_list_t;

typedef struct {
  int count;    /* how many pixels were affected */
  int type;   /* what was hit */
} m_hit_t;


struct m_ammo_t;    /* forward declaration */

/* these are allocated in the course of action */
typedef struct {
  struct m_ammo_t *type;  /* shot type */

  int x, y;   /* position */
  int dx, dy;   /* speed vector */
  int z;      /* type specific */
} m_shot_t;

/* and these are predefined */
struct m_ammo_t {

  m_uchar *name;    /* shot name */

  int (*fly)(m_shot_t *);     /* flight handler */
  int (*hit)(m_shot_t *, m_hit_t *type);  /* collision handler */

  int weight;   /* shot weight (down force) */
  int radius;   /* explosion radius */
  int damage;   /* destruction factor inside radius */
  int price;

  int ok;     /* bg type that doesn't explode bomb */
};


typedef struct {
  int x;
  int y;
} m_pos_t;


typedef struct _m_player_t {

  /* player name */
  m_uchar *name;

  /* player hilite color */
  m_rgb_t *color;

  /* player's possessions */
  m_list_t *items;

  /* alive / my turn flags */
  int alive;
  int current;

  /* tank properties */
  m_pos_t pos;  /* tank middle */
  int energy; /* how much power is available (zero => kaboom) */
  int shield; /* after shield's gone, energy decreases at every hit */

  /* contact shield, deals with *direct* hits (if 'shield' is true) */
  int shield_type;

  /* drop properties (fixed point) */
  m_pos_t speed;
  m_pos_t drop;
  int dropping;

  /* current shot attributes */
  int angle;
  int power;

  /* statictics */
  int money;
  int shots;
  int hits;
  int wins;
  int lost;
} m_player_t;


/* Collision type identifiers.
 */
enum {
  /* special values */
  NO_HIT = -11,   /* hit array terminator */
  HIT_EDGE,   /* player hits ground */
  HIT_OUT,    /* out of screen */

  /* image.c/Image[] indeces */
  HIT_MASK = 0,   /* mask index */
  HIT_BG,     /* didn't hit anything */
  HIT_GROUND,   /* hit ground */
  IMAGE_COUNT,    /* number of def. images */

  /* player IDs in mask */
  HIT_PLAYER = IMAGE_COUNT,
  MAX_HITS = HIT_PLAYER + MAX_PLAYERS
};


/* In-game string/message/object indentifiers. If their order is changed
 * it has to be changed also in the respective array and the language
 * files!
 */
enum {
  /* array in ammo.c */
  AMMO_BASIC,
  AMMO_STONE,
  AMMO_FLOAT,
  AMMO_BOOMERANG,
  AMMO_ROLL,
  AMMO_BACK,
  AMMO_BOUNCE,
  AMMO_DIG,
  AMMO_TIMER,
  AMMO_TRIPLE,
  AMMO_BIGGIE,
  AMMO_NUKE,
  AMMO_SURPRISE,
  AMMO_TYPES,

  /* auxiliary types don't show in item list (strings) -> they can
   * overlap with others
   */
  AMMO_FLOAT2,
  AMMO_ROLL2,
  AMMO_DIG2,
  AMMO_TYPES_ALL,

  /* array in shield.c */
  SHIELD_FIRST = AMMO_TYPES,
  SHIELD_REPULSER = SHIELD_FIRST,
  SHIELD_DAMPER1,
  SHIELD_DAMPER2,
  SHIELD_DAMPER3,
  SHIELD_PASSER,
  SHIELD_TELEPORTER,
  SHIELD_BOUNCER,
  SHIELD_PAYBACKER,
  SHIELD_TYPES,

  SHIELD_DUMMY,   /* no shield */

  /* array in util.c */
  UTIL_FIRST = SHIELD_TYPES,
  UTIL_PARACHUTE = UTIL_FIRST,
  UTIL_POWERUP,
  UTIL_SUICIDE,
  UTIL_TYPES,

  /* all the user selectable types */
  USER_TYPES = UTIL_TYPES,

  /* those below are only in the language files */

  STR_ANYKEY = USER_TYPES,
  STR_START,    /* two startup message strings */
  STR_MONEY,
  STR_WINS,
  STR_HITS,
  STRINGS,

  /* above strings are drawn *in* game and ones below printed
   * when initializing and on error
   */

  ERR_FATAL = STRINGS,  /* prefix for errors */
  ERR_CONFIG,   /* configuration file reading failed */
  ERR_VARS,   /* missing configuration variable(s) */
  ERR_PLAYERS,    /* illegal number of players */
  ERR_ROUNDS,   /* illegal number of rounds */
  ERR_LOADING,    /* image loading failed */
  ERR_WINIT,    /* screen initalization error */
  ERR_OPEN,   /* file open failure */
  ERR_IMAGE,    /* image type error */
  ERR_READ,   /* file reading failure */
  ERR_ALLOC,    /* memory allocation failure */
  ERR_COLORS,   /* illegal number of colors */
  ERR_MAPPING,    /* illegal color (value) mapping */
  ERR_SAVE,   /* file save failed */
  ERRORS,

  MSG_WELCOME = ERRORS, /* game startup greeting */
  MSG_LANGUAGE,   /* which language selected */
  MSG_INIT,   /* screen init done */
  MSG_READ,   /* reading... */
  MSG_DONE,   /* -"- done */
  MSG_BYE,    /* game exit message */
  MSG_USAGE,    /* game usage (has to be last item) */
  MESSAGES
};

#define IS_SHOT(x)  ((x) >= 0 && (x) < AMMO_TYPES)
#define IS_SHIELD(x)  ((x) >= AMMO_TYPES && (x) < SHIELD_TYPES)
#define IS_UTIL(x)  ((x) >= SHIELD_TYPES && (x) < UTIL_TYPES)
#define IS_STRING(x)  ((x) >= 0 && (x) < STRINGS)
#define IS_ERROR(x) ((x) >= STRINGS && (x) < ERRORS)
#define IS_MESSAGE(x) ((x) >= ERRORS && (x) < MESSAGES)
#define ALL_STRINGS MESSAGES


/* sound effect identifiers */
enum {
  SND_BUY,  /* buy item */
  SND_SELL, /* sell item */
  SND_ACCEPT, /* accept items */
  SND_SHOOT,  /* tank shooting */
  SND_PING, /* shield bouncing */
  SND_WHOOSH, /* shield teleporting */
  SND_SUCK, /* shield sucking */
  SND_DAMP, /* shield damper */
  SND_CLICK,  /* shot flight event */
  SND_BOUNCE, /* shot bounce from ground */
  SND_THUMP,  /* shot splat against ground */
  SND_BOOM, /* shot explosion */
  SND_DIE,  /* tank deathcry */
  SOUNDS
};

/* song identifiers */
enum {
  SONG_INTRO,
  SONG_MENU,
  SONG_BATTLE,
  SONG_OVER,
  SONGS
};


/* functions return something for success and zero/NULL for failure */

/* main.c */
extern m_image_t *Screen;   /* play area image */
extern int    Makemono;   /* fix palette for monochrome toggle */
extern int    TimeFrame, TimeInput;
extern int    CycleColor;

/* intro.c */
extern int  do_intro(void);
extern int  do_gameover(void);

/* game.c */
extern int  game_init(int count, char *name[]);
extern void game_suicide(m_player_t *player);
extern int  game_damage(m_player_t *, m_shot_t *, int damage, int pixels);
extern int  game_hit(m_hit_t *hit, m_shot_t *shot, int power);
extern int  game_energy(int percentage);
extern void game_results(void);
extern void game_reset(void);
extern int  game_drop(void);
extern int  do_game(void);

/* list.c */
extern int  list_init(void);
extern m_list_t *list_add(m_list_t *list, int type);
extern m_list_t *list_search(m_list_t *list, int type);
extern m_list_t *list_free(m_list_t *item);

/* user.c */
extern void user_init(void);
extern int  user_power(int percentage);
extern int  user_input(m_player_t *player);
extern int  user_shopping(m_player_t *player);

/* image.c */
extern int  img_init(int wd, int ht); /* read images */
extern void img_clear(m_image_t *bm, int x, int y);
extern m_hit_t  *img_copy(m_image_t *bm, int x, int y);
extern m_hit_t  *img_blit(m_image_t *bm, int xoff, int yoff, int wd, int ht, int x, int y);
extern void img_clblit(m_image_t *bm, int xoff, int yoff, int wd, int ht, int x, int y);
extern void img_setmask(m_image_t *bm, int xoff, int yoff, int wd, int ht, int x, int y, int value);
extern m_hit_t  *img_circle(int x, int y, int r, m_uchar index, m_uchar masked);
extern void img_nocircle(int x, int y, int r);
extern int  img_drop(int x, int y, int r, m_pos_t *speed, m_pos_t *move);
extern int  img_ground(void);
extern void img_bg(int y, int ht);
extern void img_cls(void);

/* range.c */
extern short  *range_create(int wd, int ht);
extern void range_straights(int value);
extern void range_offset(int value);
extern short  *range_ground(void);
extern int  range_level(int x);

/* tank.c */
extern int  tank_init(m_image_t *bm, m_image_t *hilite);
extern void tank_positions(int players, m_player_t *player);
extern int  tank_angled(m_player_t *player, int angle);
extern void tank_setmask(m_player_t *player, int idx);
extern void tank_unhilite(m_player_t *player);
extern void tank_hilite(m_player_t *player);
extern m_pos_t  *tank_checkdrop(m_player_t *player, int dx, int dy);
extern void tank_drop(m_player_t *player, int idx);
extern void tank_shoot(m_player_t *player, int type);
extern int  tank_pixels(m_player_t *player);
extern int  tank_height(void);
extern int  tank_size(void);

/* shot.c */
extern int  shot_init(m_image_t *bm);
extern void shot_reset(void);
extern int  shot_wind(int *max);
extern int  shot_radius(void);
extern m_shot_t *shot_spawn(m_shot_t *shot);
extern void shot_free(m_shot_t *shot);
extern void shot_explosion(int x, int y, int radius, int power, int mask);
extern void shot_drawme(m_shot_t *shot);
extern void shot_clearme(m_shot_t *shot);
extern void shot_draw(int x, int y);
extern void shot_clear(int x, int y);
extern int  do_shot(void);

/* ammo.c */
extern struct m_ammo_t *Ammo;
extern int  ammo_init(int height, int pixels);
extern int  ammo_price(int type);
extern m_uchar  *ammo_name(int type);
extern int  ammo_gravity(void);
extern int  ammo_damage(void);

/* shield.c */
extern int  shield_init(void);
extern void shield_reset(void);
extern m_uchar  *shield_name(int type);
extern int  shield_price(int type);
extern void shield_remove(m_player_t *player);
extern void shield_add(m_player_t *player, int type);
extern int  shield_hit(m_player_t *player, m_shot_t *shot, int *damage);
extern m_pos_t  *do_shields(int x, int y);

/* util.c */
extern int  util_init(void);
extern int  util_price(int type);
extern m_uchar  *util_name(int type);
extern int  util_do(m_player_t *player, int type);

/* font.c */
extern int  font_init(m_image_t *bm);
extern int  font_width(void);
extern int  font_height(void);
extern int  font_strlen(m_uchar *s);
extern void font_print(m_uchar *s, int x, int y);
extern void font_clear(m_uchar *s, int x, int y);

/* scale.c */
extern m_image_t  *bm_scale(m_image_t *bm, int wd, int ht);
extern m_image_t  *bm_copy(m_image_t *bm);

/* pbm.c */
extern void   bm_free(m_image_t *bm);
extern m_image_t  *bm_alloc(int wd, int ht, int colors);
extern m_image_t  *bm_read(char *name);
extern void   bm_write(char *name, m_image_t *bm);
extern void   ppm_write(char *name, m_image_t *bm);

/* screen.c */
extern int  screen_init(int wd, int ht, int colors);
extern int  screen_clip(int x, int y, int w, int h);
extern int  screen_rect(int *x, int *y, int *w, int *h);
extern void screen_box(int x, int y, int wd, int ht, int color);
extern void screen_dirty(int x, int y, int w, int h);
extern void screen_update(m_image_t *dest);

/* color.c */
extern void color_init(int first, int start, int cnt);
extern int  color_cycle(int index, int counter);
extern void color_invert(int index, m_rgb_t *rgb);
extern int  color_cyclecount(void);
extern void color_set(m_rgb_t *rgb);
extern m_uchar  *color_range(int *lenght);
extern int  color_white(void);
extern int  color_black(void);
extern int  color_gray(void);

/* map.c */
extern m_uchar  *map_get(void);
extern void map_colors(m_image_t *bm);
extern void map_offset(m_image_t *bm, int offset);
extern void map_palette(m_image_t *bm);

/* frame.c */
extern void frame_start(long ms);
extern long frame_end(void);

/* message.c */
extern int  msg_language(char *lang); /* set msg language */
extern m_uchar  *msg_string(int msg);   /* get string */
extern void msg_print(int msg);   /* print message(s) */

/* config.c */
extern int  read_config(char *config);
extern char *get_string(char *variable);
extern float  get_float(char *variable);
extern int  get_value(char *variable);

/* qtrig.c */
extern float  qsin(float angle);
extern float  qcos(float angle);

/* win-*.c */
extern int  win_init(int *wd, int *ht);
extern void win_changecolor(int index, m_rgb_t *rgb);
extern int  win_setpalette(int colors, m_rgb_t *pal);
extern void win_mapcolors(m_image_t *bm);
extern void win_sync(void);     /* flush graphics to screen */
extern int  win_getkey(long timeout);
extern void win_exit(void);

/* snd-*.c */
extern void snd_init(void);
extern void snd_play(int idx);
extern void snd_flush(void);
extern void snd_sync(void);
extern void snd_exit(void);
extern void song_play(int idx, int times);
extern void song_stop(void);

#endif  /* __MORTAR_H */

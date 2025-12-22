/***************************************************************************
 *
 * common.h -- Common structures needed in several files.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

#ifndef __COMMON_H__
#define __COMMON_H__

#include "defs.h"
#include "map.h"
#include "prefs.h"

/* Force use of new variable names to help prevent errors  */
#define INTUI_V36_NAMES_ONLY

/* Use lowest non-obsolete version that supplies the functions needed. */
#define INTUITION_REV 39
#define GRAPHICS_REV  39

struct Coordinates {
  int x;
  int y;
};

typedef struct _AFuelPod {
  struct _AFuelPod *next;
  struct Coordinates mapos;    /* Map coordinates for this fuelpod.         */
  struct Coordinates pos;      /* Position of center of fuelpod.            */
  int    fuelcount;          
  int    p_fuel[MY_BUFFERS];   /* For double buffering...                   */
  int    fuel;                 /* Amount of fuel left in this fuelpod.      */
} AFuelPod;

typedef enum { C_UP, C_DN, C_LF, C_RG, C_NONE } cdir_t;
typedef enum { INACTIVE, ACTIVE, DEAD } cstate_t;

typedef struct _ACannon {
  struct   _ACannon *next;
  struct   Coordinates mapos;  /* Map coordinates for this cannon.          */
  struct   Coordinates pos;    /* Position of center of cannon.             */
  cdir_t   cdir;               /* Cannon direction.                         */
  cstate_t cstate;             /* Cannon state.                             */
  int    deadcount;            /* For how many frames will this c. be dead  */
  int    firedelay;            /* How many frames before next shot.         */
} ACannon;  

typedef enum { EXPLOSION, BULLET, EXHAUST, CANNON_SHOT } ptype;
typedef enum { RED, BLUE, WHITE } col_t;

typedef struct _APoint {
  struct _APoint *next;      /* Next & prev point in chain                */
  struct _APoint *prev;      
  struct Coordinates p_pos[MY_BUFFERS];  /* Prev. point positions         */
  struct Coordinates pos;    /* Current point position                    */
  ptype  type;               /* Type of point.                            */
  col_t  color;              /* Color of point.                           */
  BOOL   draw_it;            /* True if this point is inside scrn limits  */
  int    mass;               /* Mass, used in collisions.                 */
  int    xcount;
  int    ycount;
  int    xvel;
  int    yvel;
  int    life;               /* Point life, decreases every frame         */
  UWORD drawn;               /* The bits in this variable tells us in     */
                             /* which buffers this point has been drawn   */
                             /* so that we can remove it later.           */
  cdir_t lastmap;            /* For better collision detection on cannons.*/
  struct Coordinates lpos;   /* Used in conjunction with lastmap.         */
} APoint;

typedef enum { NO, YES, LEFT, RIGHT } turn_t;

typedef struct _AShip {
  struct   _AShip *next;       /* Next & prev ship in chain                 */
  struct   _Aship *prev;
  int      shapesize;          /* How many points in shape                  */
  struct   Coordinates *shape; /* Defines the shape                         */
  struct   Coordinates *currc; /* Rotated coordinates                       */
  struct   Coordinates **prevc;/* Previous coordinates for double-buffering */
  struct   Coordinates pos;    /* Current position                          */
  struct   Coordinates p_pos[MY_BUFFERS];  /* For double-buffering          */
  struct   Coordinates base;   /* Base position in real coordinates.        */
  BOOL     s_drawn[MY_BUFFERS];       /* For double-buffering...(ship)      */
  BOOL     draw_it;            /* Used for non-local ships.                 */
  int      mass;               /* Mass, used in collisions.                 */
  BOOL     fueling;            /* True when ship is fueling from a fuelpod. */
  AFuelPod *fpod;              /* The pod we are currently fueling from.    */
  BOOL     f_drawn[MY_BUFFERS];       /* Double buffering..aagh.(fuelline)  */ 
  struct   Coordinates fuell[MY_BUFFERS];  /* The fuelline is stored here.  */
  int      fuel;               /* Gots to have fuel to move.                */
  int      fuelcount;          /* Used with integer math.                   */
  int      status;             /* What this player is doing right now.      */
  int      xcount;             /* Counters for position incr/decr           */ 
  int      ycount;
  int      xvel;               /* Velocity x-dir                            */
  int      yvel;               /* Velocity y-dir                            */
  BOOL     local;              /* Ship is controlled from this computer?    */
  BOOL     shields;            /* True if shields are up.                   */
  BOOL     fireing;            /* True if fireing                           */
  int      bul_life;           /* Bullet life                               */
  int      buldist;            /* Distance for bullets from ship center     */
  int      fw_nbul;            /* Number of forward bullets                 */
  int      bw_nbul;            /* Number of backward bullets                */
  BOOL     thrusting;          /* True if thrusting                         */
  int      exhcount;           /* How many particles/thrust sequence < 5    */
  int      exhwidth;           /* Width of the exhaust                      */
  int      exhdist;            /* Distance for exhaust from ship center     */
  int      exhlife;            /* How many frames the avg. 'fume' will live */                
  int      power;              /* Thrust power                              */
  turn_t   turning;            /* Is the ship turning?.                     */ 
  int      rotspeed;           /* Rotation speed                            */
  int      angle;              /* Ship angle in degrees                     */
} AShip;

typedef struct _ABase {
  struct _ABase *next;
  struct Coordinates mapos;    /* Map coordinates of this base.            */
  AShip  *owner;               /* Owner of this base.                      */
} ABase;

/*
 * This will be a common structure in most of the files, through this
 * structure all important game parameters can then be accessed.
 */
typedef struct _AWorld {
  int       Width, Height;     /* Width and height of our world.           */
  int       gravity; 
  AShip     *players;
  ABase     *bases;
  APoint    *points;
  ACannon   *cannons;
  AFuelPod  *fuelpods;
  MAP_Point **map_points;
  /*---- Local stuff after this ----*/
  UWORD     framerate;      /* Current framerate */
  AShip     *local_ship;
  BOOL      hudon;          /* True everytime the hud should be turned on. */
  struct    Coordinates p_sv[MY_BUFFERS]; /* Prev. speed vector positions  */
  struct    BitMap *shld_bm;              /* Bitmap of shield.             */
} AWorld;

#endif

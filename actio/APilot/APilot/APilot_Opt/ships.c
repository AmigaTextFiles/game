/****************************************************************************
 *
 * Ships.c -- Functions used for calculations and displaying of ships.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
 *
 */

#include <stdlib.h>
#include <math.h>
#include <exec/types.h>             /* The Amiga data types file.         */
#include <libraries/dos.h>          /* Official return codes defined here */

#include <proto/intuition.h>
#include <proto/graphics.h>

#include "main_protos.h"
#include "points_protos.h"
#include "ships_protos.h"
#include "lists_protos.h"
#include "fuelpod_protos.h"

#include "common.h"
#include "defs.h"
#include "map.h"
#include "prefs.h"
#include "ships.h"

/*---------------------------------------------------------------------------*/

extern int sina[];
extern int cosa[];

extern AWorld World;

struct Coordinates triangle[] = {
  { 0,-11},
  { 7,  7},
  {-7,  7},
  {0, -11}
};

static int animno = 0; /* Need this for shield animation */

/*---------------------------------------------------------------------------*/

/*
 * init_ship -- Inizialize ship parameterers. (May be changed to accept
 *              parameters as function arguments later...)
 *
 */

void
init_ship( AShip *aShip )
{
  int i, j;
  ABase *shipbase;

  shipbase = get_base();
  /*
   * Should be made to handle out-of-bases situations more gracefully
   * in the future.
   */ 
  if (shipbase == NULL)
    cleanExit( RETURN_WARN, "** Out of bases for new ship." );

  shipbase->owner = aShip;
  aShip->base.x = shipbase->mapos.x * MAP_BLOCKSIZE + MAP_BLOCKSIZE/2;
  aShip->base.y = shipbase->mapos.y * MAP_BLOCKSIZE + MAP_BLOCKSIZE/2;

  aShip->shape     = triangle;  
  aShip->shapesize = sizeof(triangle)/sizeof(struct Coordinates);
  aShip->mass      = SHP_MASS;
  aShip->draw_it   = FALSE;
  aShip->fueling   = FALSE;
  aShip->fuel      = MAXFUEL/5;
  aShip->fuelcount = 0;

  for (i = 0; i < MY_BUFFERS; i++) {
    aShip->s_drawn[i] = FALSE;
    aShip->f_drawn[i] = FALSE;
  }

  aShip->pos.x     = aShip->base.x;
  aShip->pos.y     = aShip->base.y;
  aShip->xvel      = aShip->yvel   = 0;
  aShip->xcount    = aShip->ycount = 0;
  aShip->status    = 0;
  aShip->shields   = TRUE;
  aShip->power     = THR_POWER * PRECS;
  aShip->exhcount  = EXH_COUNT; 
  aShip->exhwidth  = EXH_WIDTH;
  aShip->exhdist   = EXH_DIST;
  aShip->exhlife   = 25;   /* 50 = one second on 50fps */
  aShip->rotspeed  = ROT_SPEED;
  aShip->angle     = 0;
  aShip->local     = TRUE;
  aShip->fireing   = FALSE;
  aShip->buldist   = BUL_DIST;
  aShip->bul_life  = BUL_LIFE;
  aShip->fw_nbul   = 3;
  aShip->bw_nbul   = 1;
  aShip->thrusting = FALSE;

  aShip->currc     = (struct Coordinates *) 
                      malloc( aShip->shapesize * sizeof(struct Coordinates) );
  if (aShip->currc == NULL)
    cleanExit( RETURN_WARN, "** Unable to allocate space for ship structure.\n" );

  aShip->prevc     = (struct Coordinates **)
                      malloc( MY_BUFFERS * sizeof(struct Coordinates) );
  if (aShip->prevc == NULL)
    cleanExit( RETURN_WARN, "** Unable to allocate space for ship structure.\n" );

  for (i = 0; i < MY_BUFFERS; i++) {
    if ( (aShip->prevc[i] = 
          (struct Coordinates *)
           malloc( aShip->shapesize * sizeof(struct Coordinates) )) == NULL )
      cleanExit( RETURN_WARN, "** Unable to allocate space for ship structure.\n" );
  }     

  /* Copy the shape into current coordinates */
  for(i = 0; i < aShip->shapesize; i++) {
    aShip->currc[i].x = aShip->shape[i].x;
    aShip->currc[i].y = aShip->shape[i].y;
  }
  for(i = 0; i < MY_BUFFERS; i++) {
    aShip->p_pos[i].x = aShip->p_pos[i].y = 0;
    for(j = 0; j < aShip->shapesize; j++) {
      aShip->prevc[i][j].x = aShip->shape[j].x;
      aShip->prevc[i][j].y = aShip->shape[j].y;
    }
  }

}

/*---------------------------------------------------------------------------*/

/*
 * landing -- Returns TRUE if the ship is in a landing configuration,
 *            ie. nose up, slow speed.
 *
 */
BOOL
landing( AShip *ship )
{
  if (ship->angle < 15 || ship->angle > 345)
    if (ship->yvel <= PRECS && ship->yvel >= 0)
      return TRUE;

  return FALSE;
}

/*---------------------------------------------------------------------------*/

/*
 * update_ship -- Updates the ship position, angle, fireing and exhaust. Checks
 *                for ship out of window range etc. etc..
 */
void
update_ship( AShip *aShip, UWORD buf, UWORD nframes )
{
  int i;
  int isin, icos;

  /*
   * Check if ship exploded 
   */
  if (aShip->status > 0)
    return;

  if (aShip->turning != NO || aShip->thrusting || aShip->fireing) {

    if (aShip->turning == RIGHT) {
      aShip->angle = (aShip->angle + aShip->rotspeed * nframes) % 360;
    } else if (aShip->turning == LEFT) {
      aShip->angle = (aShip->angle - aShip->rotspeed * nframes) % 360;
     }

    if (aShip->angle < 0)
      aShip->angle = 360 + aShip->angle;

    isin = sina[aShip->angle];
    icos = cosa[aShip->angle];

    if (aShip->turning != NO) {
      if (aShip->turning == YES) aShip->turning = NO;
      /* Rotate the points */
      for(i = 0; i < aShip->shapesize; i++) {
        aShip->currc[i].x = (aShip->shape[i].x * icos - aShip->shape[i].y * isin) >> SHFTPR;
        aShip->currc[i].y = (aShip->shape[i].x * isin + aShip->shape[i].y * icos) >> SHFTPR;
      }
    }
  }

  for (i = nframes; i > 0; i--) {
    if (aShip->thrusting && aShip->fuel > 0) {
      aShip->xvel += (isin * aShip->power) >> SHFTPR;
      aShip->yvel -= (icos * aShip->power) >> SHFTPR;
    }
    aShip->yvel += World.gravity;
    aShip->xcount += aShip->xvel;
    aShip->ycount += aShip->yvel;
  }

  /* Store old positions 
  aShip->p_pos[buf].x = aShip->pos.x;
  aShip->p_pos[buf].y = aShip->pos.y;
  */

  /* Move ship */
  aShip->pos.x  += (aShip->xcount < 0) ? -((-aShip->xcount) >> SHFTPR) : (aShip->xcount >> SHFTPR);
  aShip->xcount  = aShip->xcount % PRECS;
  aShip->pos.y  += (aShip->ycount < 0) ? -((-aShip->ycount) >> SHFTPR) : (aShip->ycount >> SHFTPR);
  aShip->ycount  = aShip->ycount % PRECS;

  if (aShip->thrusting && aShip->fuel > 0) {
    add_exhaust(aShip, isin, icos, nframes);
    aShip->fuelcount += 2*nframes;
  }

  if (aShip->fireing) {
    aShip->fireing = FALSE;
    if (!aShip->shields && aShip->fuel > 0) {
      /* Every bullet grabs one fuel */
      aShip->fuel -= aShip->fw_nbul + aShip->bw_nbul;
      add_bullets(aShip, isin, icos);
    }
  }

  if (aShip->shields)
    aShip->fuelcount += nframes;
  if (aShip->fuelcount >= 50) {
    aShip->fuelcount = 0;
    aShip->fuel--;
  }
  if (aShip->fuel <= 0) {
    aShip->shields = FALSE;
    aShip->fuel = 0;
  }

  if (aShip->fueling)
    fuel_ship(aShip);

  if (aShip->pos.x >= MAP_BLOCKSIZE*World.Width) {
    aShip->pos.x = MAP_BLOCKSIZE*World.Width-1;
    aShip->xvel  = -(aShip->xvel >> 1);
  } else if (aShip->pos.x < 0) {
    aShip->pos.x = 0;
    aShip->xvel  = -(aShip->xvel >> 1);
  }
  if (aShip->pos.y >= MAP_BLOCKSIZE*World.Height) {
    aShip->pos.y = MAP_BLOCKSIZE*World.Height-1;
    aShip->yvel  = -(aShip->yvel >> 1);
  } else if (aShip->pos.y < 0) {
    aShip->pos.y = 0;
    aShip->yvel  = -(aShip->yvel >> 1);
  }
}

/*---------------------------------------------------------------------------*/

/*
 * draw_ship.c -- Draws a ship on the display
 *
 */
void
draw_ship( AShip *aShip, struct RastPort *rp, UWORD buf )
{
  int bp_x, bp_y, i;
  int pos_x, pos_y;
  struct Coordinates *prevc;
  struct Coordinates *currc;

  prevc = aShip->prevc[buf];
  currc = aShip->currc;

  SetWriteMask(rp, 3l);
  SetAPen(rp, 0);

  /* Remove ship */
  if (aShip->local) {
    Move(rp, LOCL_X+prevc[0].x, LOCL_Y+prevc[0].y);
    for (i = 1; i < aShip->shapesize; i++) {
      Draw(rp, LOCL_X+prevc[i].x, LOCL_Y+prevc[i].y);
      /* Store new coordinates */
      prevc[i].x = currc[i].x;
      prevc[i].y = currc[i].y;
    }
    prevc[0].x = currc[0].x;
    prevc[0].y = currc[0].y;
   
    /*
     * Last shield image is the circle-mask for clearing.
     * Should try to find some condition where this clearing
     * is not necessary. As it is now, some CPU might get wasted...
     */
    BltBitMap(World.shld_bm, (SHL_SIZE*2+1)*(SHL_ANIM-1), 0, rp->BitMap, 
	      LOCL_X-SHL_SIZE, LOCL_Y-SHL_SIZE,
	      SHL_SIZE*2+1, SHL_SIZE*2+1, 0x22, 0x03, NULL);
    
    if (aShip->f_drawn[buf]) {
      aShip->f_drawn[buf] = FALSE;  
      Move(rp, LOCL_X, LOCL_Y);
      Draw(rp, aShip->fuell[buf].x, aShip->fuell[buf].y);
    }
  } else { 
    if (aShip->s_drawn[buf]) {
      pos_x = aShip->p_pos[buf].x;
      pos_y = aShip->p_pos[buf].y;
      
      Move(rp, pos_x+prevc[0].x, pos_y+prevc[0].y);
      for (i = 1; i < aShip->shapesize; i++) {
        Draw(rp, pos_x+prevc[i].x, pos_y+prevc[i].y);
      }

      aShip->s_drawn[buf] = FALSE;
    }      
  }

  /*
   * Check if our ship is dead
   */
  if (aShip->status > 0) {
    aShip->status -= (World.framerate * 2);
    if (aShip->status <= 0) {
      /*
       * Been dead long enough, restore default values...
       */
      if (aShip->local)
        World.hudon = TRUE;
      aShip->fuel    = MAXFUEL/5;
      aShip->fueling = FALSE;
      aShip->fpod    = NULL;
      /* ** Only during testing ** */
      if (aShip->local)
        aShip->shields = TRUE;
      aShip->angle   = 0;
      aShip->turning = YES;
      aShip->pos.x = aShip->base.x;
      aShip->pos.y = aShip->base.y;
      aShip->xvel = aShip->xcount = 0;
      aShip->yvel = aShip->ycount = 0;
    }
    return;
  }

  SetAPen(rp, 3);

  /* Draw ship */
  if (aShip->local) {
    if (aShip->shields) {

      /* Animate the shield */
      if (animno >= SHL_ANIM-1)
        animno -= SHL_ANIM-1;
      BltBitMap(World.shld_bm, (SHL_SIZE*2+1)*animno, 0, rp->BitMap, 
                LOCL_X-SHL_SIZE, LOCL_Y-SHL_SIZE,
                SHL_SIZE*2+1, SHL_SIZE*2+1, 0xEE, 0x03, NULL);
      animno +=  World.framerate; 
    }
    if (aShip->fueling) {
      bp_x = World.local_ship->pos.x-(SCR_WIDTH+MAP_BLOCKSIZE*2)/2;
      bp_y = World.local_ship->pos.y-(SCR_HEIGHT+MAP_BLOCKSIZE*2)/2;
      Move(rp, LOCL_X, LOCL_Y);
      aShip->fuell[buf].x = aShip->fpod->pos.x-bp_x;
      aShip->fuell[buf].y = aShip->fpod->pos.y-bp_y;
      Draw(rp, aShip->fuell[buf].x, aShip->fuell[buf].y);
      aShip->f_drawn[buf] = TRUE;
    }

    Move(rp, LOCL_X+currc[0].x, LOCL_Y+currc[0].y);
    for (i = 1; i < aShip->shapesize; i++)
      Draw(rp, LOCL_X+currc[i].x, LOCL_Y+currc[i].y);
  } else {
    if (aShip->draw_it) {
      bp_x = World.local_ship->pos.x-(SCR_WIDTH+MAP_BLOCKSIZE*2)/2;
      bp_y = World.local_ship->pos.y-(SCR_HEIGHT+MAP_BLOCKSIZE*2)/2;
      pos_x = aShip->pos.x-bp_x;
      pos_y = aShip->pos.y-bp_y;

      aShip->p_pos[buf].x = pos_x;
      aShip->p_pos[buf].y = pos_y;

      Move(rp, pos_x+currc[0].x, pos_y+currc[0].y);
      for (i = 1; i < aShip->shapesize; i++) {
        Draw(rp, pos_x+currc[i].x, pos_y+currc[i].y);
        prevc[i].x = currc[i].x;
        prevc[i].y = currc[i].y;
      }
      prevc[0].x = currc[0].x;
      prevc[0].y = currc[0].y;

      aShip->s_drawn[buf] = TRUE;
    }
  }
}

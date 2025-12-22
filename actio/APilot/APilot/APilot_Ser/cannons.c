/*************************************************************************
 * 
 * cannon.c -- Cannon handling functions.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
 *
 */

/*--------------------------------------------------------------------------*/

#include <stdlib.h>
#include <exec/types.h>
#include <libraries/dos.h>

#include "common.h"

#include "main_protos.h"
#include "lists_protos.h"
#include "points_protos.h"
#include "cannon_protos.h"

/*--------------------------------------------------------------------------*/

#define IN_RANGE(o1, o2, r) (abs((o1)->pos.x-(o2)->pos.x)<(r)     \
                             && abs((o1)->pos.y-(o2)->pos.y)<(r))

extern int sina[];
extern int cosa[];

extern AWorld World;

/*--------------------------------------------------------------------------*/

/*
 * alloc_cannon -- Allocate a new cannon and add it to the world cannon list.
 *
 */                 
ACannon *
alloc_cannon(int map_x, int map_y, cdir_t direction)
{
  ACannon *cannon;

  if ( (cannon = (ACannon *) malloc(sizeof(ACannon))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for cannons.\n" );

  switch (direction) {
    case C_UP:
      cannon->pos.x = MAP_BLOCKSIZE * map_x + MAP_BLOCKSIZE/2;
      cannon->pos.y = MAP_BLOCKSIZE * map_y + MAP_BLOCKSIZE - CAN_HEIGHT/2;
      break;
    case C_DN:    
      cannon->pos.x = MAP_BLOCKSIZE * map_x + MAP_BLOCKSIZE/2;
      cannon->pos.y = MAP_BLOCKSIZE * map_y + CAN_HEIGHT/2;
      break;
    case C_LF:    
      cannon->pos.x = MAP_BLOCKSIZE * map_x + MAP_BLOCKSIZE - CAN_HEIGHT/2; 
      cannon->pos.y = MAP_BLOCKSIZE * map_y + MAP_BLOCKSIZE/2;
      break;
    case C_RG:    
      cannon->pos.x = MAP_BLOCKSIZE * map_x + CAN_HEIGHT/2; 
      cannon->pos.y = MAP_BLOCKSIZE * map_y + MAP_BLOCKSIZE/2;
      break;
    default:
      /* NOTREACHED */
      break;
  }  

  cannon->mapos.x   = map_x;
  cannon->mapos.y   = map_y;
  cannon->cdir      = direction;
  cannon->cstate    = INACTIVE;
  cannon->deadcount = 0;
  cannon->firedelay = 0;

  /*
   * Add cannon to the world cannon list.
   */
  cannon->next = World.cannons->next;
  World.cannons->next = cannon;
    
  return cannon;
}

/*--------------------------------------------------------------------------*/

/*
 * Kills a cannon.
 *
 */
void
kill_cannon( ACannon *cannon )
{
  cannon->cstate    = DEAD;
  cannon->deadcount = CAN_DEDTIME;

  add_explosion(cannon->pos.x, cannon->pos.y);
}

/*--------------------------------------------------------------------------*/

/*
 * update_cannons -- Checks on dead cannons and makes active cannons
 *                   fire at player.
 */
void
update_cannons( AShip *ship, UWORD nframes )
{
  ACannon *cannon = World.cannons->next;

  while (cannon->next != cannon)
  {
    switch (cannon->cstate) {
      case DEAD:
        cannon->deadcount -= nframes;
        if (cannon->deadcount <= 0)
          cannon->cstate = INACTIVE;
        break;
      case ACTIVE:
        if (!IN_RANGE(ship, cannon, 300)) {
          cannon->cstate = INACTIVE;       
          break;
        } 
        cannon->firedelay -= nframes;
        if (cannon->firedelay <= 0) {
          cannon->firedelay = CAN_FIREDELAY + 
                              ((rand()%(CAN_FDSPREAD*2))-CAN_FDSPREAD);
          fire_cannon(cannon);
          break;
        }
        break;
      case INACTIVE:
        if (IN_RANGE(ship, cannon, 300))
          cannon->cstate = ACTIVE;
        break;
      default:
        /* NOTREACHED */
        break;
    }
    cannon = cannon->next;
  }
}

/*--------------------------------------------------------------------------*/

/*
 * fire_cannon -- Fires the cannon in a random direction.
 *
 */
void
fire_cannon( ACannon *cannon )
{
  int pos_x, pos_y;
  int angle, speed;

  APoint *shot;

  if ((shot = alloc_point()) == NULL)
    return;

  pos_x = cannon->pos.x;  
  pos_y = cannon->pos.y;
  angle = (rand() % (CAN_FIREANGLE*2)) - CAN_FIREANGLE;
  speed = PRECS*2 + (rand()%(PRECS + PRECS/2));
  switch (cannon->cdir) {
    case C_UP:
      pos_y -= CAN_HEIGHT/2 + 2;
      angle = (180 + angle) % 360;
      break;
    case C_DN:
      pos_y += CAN_HEIGHT/2 + 2;
      angle = (360 + angle) % 360;      
      break;
    case C_LF:
      pos_x -= CAN_HEIGHT/2 + 2;
      angle = (270 + angle) % 360;
      break;
    case C_RG:
      pos_x += CAN_HEIGHT/2 + 2;
      /*
       * 360 + 90 -> just to be sure we won't get negative values if
       * CAN_FIREANGLE happens to be big.
       */
      angle = (360+90 + angle) % 360;
      break;
    default:
      /* NOTREACHED */
      break;
  }

  shot->pos.x = pos_x;
  shot->pos.y = pos_y;
  shot->xvel  = (speed * sina[angle]) >> SHFTPR;
  shot->yvel  = (speed * cosa[angle]) >> SHFTPR;
  shot->life  = CAN_SHOTLIFE + ((rand() % 20) - 10);
  shot->type  = CANNON_SHOT;
  shot->mass  = CAN_SHOTMASS;
  shot->color = WHITE;

}
  
/*--------------------------------------------------------------------------*/

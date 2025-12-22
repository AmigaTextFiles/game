/*************************************************************************
 *
 * collision.c -- Routines for collision detection...
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
 * 
 */

/*-------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <exec/types.h>

#include "map.h"
#include "common.h"
#include "prefs.h"

#include "ships_protos.h"
#include "points_protos.h"
#include "cannon_protos.h"
#include "collision_protos.h"

/*-------------------------------------------------------------------------*/

#define CHECK_DEAD_CANNON if( ((ACannon *) \
                               map_points[mapp_y][mapp_x].objectptr) \
                               ->cstate == DEAD ) \
                            break

#define KILL_PLAYER player->status = 100; \
                    add_explosion(player->pos.x, player->pos.y)

#define IN_RANGE(o1, o2, r) (abs((o1)->pos.x-(o2)->pos.x)<(r)     \
                             && abs((o1)->pos.y-(o2)->pos.y)<(r))

extern AWorld World;

/*-------------------------------------------------------------------------*/

void 
check_collisions( void )
{
  AShip *player = World.players->next;

  check_points();

  while (player->next != player) {
    check_ships( player );
    check_player2points( player );
    check_player2player( player );
    player = player->next;
  }

}

/*-------------------------------------------------------------------------*/

/*
 * check_player2player -- Checks player collisions between this player
 *                        and the following players in the player list.
 */
void
check_player2player( AShip *player )
{
  AShip *other_player = player->next;

  if (player->status > 0)
    return;

  while (other_player->next != other_player) {
    if (IN_RANGE(player, other_player, SHL_SIZE-3)) {
      /*
       * Add ship2ship bouncing etc. here later...
       */
      if (!other_player->shields) {
        other_player->status = 100;
        add_explosion(other_player->pos.x, other_player->pos.y);
      }      
      if (!player->shields) {
        player->status = 100;
        add_explosion(player->pos.x, player->pos.y);
      }
      return;
    }
    other_player = other_player->next;
  }
}

/*-------------------------------------------------------------------------*/

/*
 * check_ships -- Goes through every point in the ship shape and checks
 *                it's not inside something it shouldn't be, like a wall
 *                or cannon..
 */
void
check_ships( AShip *player )
{
  int i;
  int bp_x, bp_y;
  int cu_x, cu_y;
  int mapp_x, mapp_y;      /* The map block we currently are inside */
  int pos_x, pos_y;        /* The players current position          */
  int point_x, point_y;    /* Points of the ship.                   */

  BOOL is_landing = FALSE; /* Is the ship landing or not.           */

  struct Coordinates *currc;
  MAP_Point **map_points = World.map_points;

  currc = player->currc;
  pos_x = player->pos.x;
  pos_y = player->pos.y;

  if (player->status > 0)
    return;

  if ( map_points[pos_y / MAP_BLOCKSIZE]
                 [pos_x / MAP_BLOCKSIZE].blocktype == BLOCK_BASE )
    is_landing = landing(player);

  for (i = 1; i < player->shapesize; i++) {
    point_x = pos_x + currc[i].x;
    point_y = pos_y + currc[i].y;

    mapp_x = point_x / MAP_BLOCKSIZE;
    mapp_y = point_y / MAP_BLOCKSIZE;

    if (mapp_x >= World.Width || mapp_y >= World.Width ||
        mapp_x < 0 || mapp_y < 0)
      continue;

    switch (map_points[mapp_y][mapp_x].blocktype) {
      case BLOCK_EMPTY:
        break;
      case BLOCK_FILLED:
      case BLOCK_FILLED_ND:
      case BLOCK_FUEL:
        if (is_landing) {
          player->pos.y = map_points[mapp_y][mapp_x].edge_y - currc[i].y - 1;
          player->yvel  = -(player->yvel >> 1);
          player->xvel  = (player->xvel >> 1);
          player->angle = 0;
          player->turning = YES;
          return;
        }
        KILL_PLAYER;
        return; 
        break;
      case BLOCK_LU:
        if ( (point_x - map_points[mapp_y][mapp_x].edge_x) +
             (point_y - map_points[mapp_y][mapp_x].edge_y)
              < MAP_BLOCKSIZE) {
          KILL_PLAYER;
          return;
        }
        break;
      case BLOCK_RD:
        if ( (point_x - map_points[mapp_y][mapp_x].edge_x) +
             (point_y - map_points[mapp_y][mapp_x].edge_y)
              > MAP_BLOCKSIZE) {
          KILL_PLAYER;
          return;
        }
        break;      
      case BLOCK_RU:
        if ( (point_x - map_points[mapp_y][mapp_x].edge_x) +
             (map_points[mapp_y][mapp_x].edge_y + MAP_BLOCKSIZE - point_y) 
              > MAP_BLOCKSIZE) {
          KILL_PLAYER;
          return;
        }
        break;
      case BLOCK_LD:
        if ( (point_x - map_points[mapp_y][mapp_x].edge_x) +
             (map_points[mapp_y][mapp_x].edge_y + MAP_BLOCKSIZE - point_y) 
              < MAP_BLOCKSIZE) {
          KILL_PLAYER;
          return;
        }
        break;
      case BLOCK_CU:
        CHECK_DEAD_CANNON;
        if ( (point_y - map_points[mapp_y][mapp_x].edge_y) >
             (MAP_BLOCKSIZE-(CAN_HEIGHT - 
               (((PRECS * CAN_HEIGHT)/(MAP_BLOCKSIZE/2) * 
                 abs(point_x -
                     map_points[mapp_y][mapp_x].edge_x -
                     MAP_BLOCKSIZE/2)) >> SHFTPR))) ) {
          kill_cannon( (ACannon *)map_points[mapp_y][mapp_x].objectptr );
          KILL_PLAYER;
          return;
        }
        break;
      case BLOCK_CD:
        CHECK_DEAD_CANNON;
        if ( (point_y - map_points[mapp_y][mapp_x].edge_y) <
             (CAN_HEIGHT - 
               (((PRECS * CAN_HEIGHT)/(MAP_BLOCKSIZE/2) * 
                 abs(point_x -
                     map_points[mapp_y][mapp_x].edge_x -
                     MAP_BLOCKSIZE/2)) >> SHFTPR)) ) {
          kill_cannon( (ACannon *)map_points[mapp_y][mapp_x].objectptr );
          KILL_PLAYER;
          return;
        }
        break;
      case BLOCK_CL:
        CHECK_DEAD_CANNON;
        if ( (point_x - map_points[mapp_y][mapp_x].edge_x) >
             (MAP_BLOCKSIZE-(CAN_HEIGHT - 
               (((PRECS * CAN_HEIGHT)/(MAP_BLOCKSIZE/2) * 
                 abs(point_y -
                     map_points[mapp_y][mapp_x].edge_y -
                     MAP_BLOCKSIZE/2)) >> SHFTPR))) ) {
          kill_cannon( (ACannon *)map_points[mapp_y][mapp_x].objectptr );
          KILL_PLAYER;
          return;
        }
        break;
      case BLOCK_CR:
        CHECK_DEAD_CANNON;
        if ( (point_x - map_points[mapp_y][mapp_x].edge_x) <
             (CAN_HEIGHT - 
               (((PRECS * CAN_HEIGHT)/(MAP_BLOCKSIZE/2) * 
                 abs(point_y -
                     map_points[mapp_y][mapp_x].edge_y -
                     MAP_BLOCKSIZE/2)) >> SHFTPR)) ) {
          kill_cannon( (ACannon *)map_points[mapp_y][mapp_x].objectptr );
          KILL_PLAYER;
          return;
        }
        break;
      default:
        break;
    }
  }

  if (!player->local) {
    player->draw_it = FALSE;
    bp_x = World.local_ship->pos.x-(SCR_WIDTH+MAP_BLOCKSIZE*2)/2;
    bp_y = World.local_ship->pos.y-(SCR_HEIGHT+MAP_BLOCKSIZE*2)/2;
    cu_x = player->pos.x-bp_x;
    cu_y = player->pos.y-bp_y;

    if ( cu_x > MAP_BLOCKSIZE )
      if ( cu_x < MAP_BLOCKSIZE+SCR_WIDTH )
        if ( cu_y > MAP_BLOCKSIZE )
          if ( cu_y < MAP_BLOCKSIZE+SCR_HEIGHT )
            player->draw_it = TRUE;
  }
}

/*-------------------------------------------------------------------------*/

/*
 * check_points -- Goes through every point and checks if it hit any
 *                 stationary object like a cannon or a wall etc..
 *                 Also checks if point inside display area and
 *                 playing area.
 */
void
check_points()
{
  int bp_x, bp_y;
  int cu_x, cu_y;
  int mapp_x, mapp_y;
  int w_width, w_height;

  AShip      *current_player = World.local_ship;
  APoint     *point          = World.points->next;  
  MAP_Point **map_points     = World.map_points;

  bp_x     = current_player->pos.x-(SCR_WIDTH+MAP_BLOCKSIZE*2)/2;
  bp_y     = current_player->pos.y-(SCR_HEIGHT+MAP_BLOCKSIZE*2)/2;
  w_width  = World.Width;
  w_height = World.Height;

  while (point->next != point) {
  
    if (point->life <= 0) {
      point = point->next;
      continue;
    }
  
    mapp_x = point->pos.x / MAP_BLOCKSIZE;
    mapp_y = point->pos.y / MAP_BLOCKSIZE;

    if (mapp_x >= w_width) {
      point->draw_it = FALSE;
      point->life    = 0;
      point = point->next;
      continue;
    } else if (point->pos.x <= 0) {
      point->draw_it = FALSE;
      point->life    = 0;
      point = point->next;
      continue;
    }

    if (mapp_y >= w_height) {
      point->draw_it = FALSE;
      point->life    = 0;
      point = point->next;
      continue;
    } else if (point->pos.y <= 0) {
      point->draw_it = FALSE;
      point->life    = 0;
      point = point->next;
      continue;
    }

    /*
     * This should improve bullets->cannons collsion detection
     * somewhat. Simply checks if the last square was a cannon square
     * and if the bullet passed right 'through' the cannon then explode the
     * cannon and kill the point..Should make the check the other
     * way around too (if someone fires at the back of a cannon),
     * but it is less probable...
     */
    if (point->lastmap != C_NONE) {
      switch (point->lastmap) {
        case C_UP:
          if (mapp_y - point->lpos.y == 1 &&
              mapp_x - point->lpos.x == 0) {
            if( ((ACannon *) 
                 map_points[mapp_y-1][mapp_x].objectptr)->cstate == DEAD )
              break;
            kill_cannon( (ACannon *)map_points[mapp_y-1][mapp_x].objectptr );
            point->draw_it = FALSE;
            point->life    = 0;
            point = point->next;
            continue;
          }
          break;
        case C_DN:          
          if (point->lpos.y - mapp_y == 1 &&
              mapp_x - point->lpos.x == 0) {
            if( ((ACannon *) 
                 map_points[mapp_y+1][mapp_x].objectptr)->cstate == DEAD )
              break;
            kill_cannon( (ACannon *)map_points[mapp_y+1][mapp_x].objectptr );
            point->draw_it = FALSE;
            point->life    = 0;
            point = point->next;
            continue;
          }
          break;
        case C_LF:
          if (mapp_x - point->lpos.x == 1 &&
              mapp_y - point->lpos.y == 0) {
            if( ((ACannon *) 
                 map_points[mapp_y][mapp_x-1].objectptr)->cstate == DEAD )
              break;
            kill_cannon( (ACannon *)map_points[mapp_y][mapp_x-1].objectptr );
            point->draw_it = FALSE;
            point->life    = 0;
            point = point->next;
            continue;
          }
          break;
        case C_RG:
          if (point->lpos.x - mapp_x == 1 &&
              mapp_y - point->lpos.y == 0) {
            if( ((ACannon *) 
                 map_points[mapp_y][mapp_x+1].objectptr)->cstate == DEAD )
              break;
            kill_cannon( (ACannon *)map_points[mapp_y][mapp_x+1].objectptr );
            point->draw_it = FALSE;
            point->life    = 0;
            point = point->next;
            continue;
          }
          break;
        default:
          break;
      }
    }

    switch (map_points[mapp_y][mapp_x].blocktype) {
      case BLOCK_EMPTY:
        point->lastmap = C_NONE;
        break;
      case BLOCK_FILLED:
      case BLOCK_FILLED_ND:
      case BLOCK_FUEL:
        point->draw_it = FALSE;
        point->life    = 0;
        point = point->next;
        continue;
        break;
      case BLOCK_LU:
        if ( (point->pos.x - map_points[mapp_y][mapp_x].edge_x) +
             (point->pos.y - map_points[mapp_y][mapp_x].edge_y)
              < MAP_BLOCKSIZE) {
          point->draw_it = FALSE;
          point->life    = 0;
          point = point->next;
          continue;
        }
        point->lastmap = C_NONE;
        break;
      case BLOCK_RD:
        if ( (point->pos.x - map_points[mapp_y][mapp_x].edge_x) +
             (point->pos.y - map_points[mapp_y][mapp_x].edge_y)
              > MAP_BLOCKSIZE) {
          point->draw_it = FALSE;
          point->life    = 0;
          point = point->next;
          continue;
        }
        point->lastmap = C_NONE;
        break;      
      case BLOCK_RU:
        if ( (point->pos.x - map_points[mapp_y][mapp_x].edge_x) +
             (map_points[mapp_y][mapp_x].edge_y + MAP_BLOCKSIZE - point->pos.y) 
              > MAP_BLOCKSIZE) {
          point->draw_it = FALSE;
          point->life    = 0;
          point = point->next;
          continue;
        }
        point->lastmap = C_NONE;
        break;
      case BLOCK_LD:
        if ( (point->pos.x - map_points[mapp_y][mapp_x].edge_x) +
             (map_points[mapp_y][mapp_x].edge_y + MAP_BLOCKSIZE - point->pos.y) 
              < MAP_BLOCKSIZE) {
          point->draw_it = FALSE;
          point->life    = 0;
          point = point->next;
          continue;
        }
        point->lastmap = C_NONE;
        break;
      case BLOCK_CU:
        CHECK_DEAD_CANNON;
        if ( (point->pos.y - map_points[mapp_y][mapp_x].edge_y) >
             (MAP_BLOCKSIZE-(CAN_HEIGHT - 
               (((PRECS * CAN_HEIGHT)/(MAP_BLOCKSIZE/2) * 
                 abs(point->pos.x -
                     map_points[mapp_y][mapp_x].edge_x -
                     MAP_BLOCKSIZE/2)) >> SHFTPR))) ) {
          if (point->type == BULLET)
            kill_cannon( (ACannon *)map_points[mapp_y][mapp_x].objectptr );
          point->draw_it = FALSE;
          point->life    = 0;
          point = point->next;
          continue;
        } else {
          if (point->type == BULLET) {
            point->lastmap = C_UP;
            point->lpos.x = mapp_x;
            point->lpos.y = mapp_y;
          }
        }
        break;
      case BLOCK_CD:
        CHECK_DEAD_CANNON;
        if ( (point->pos.y - map_points[mapp_y][mapp_x].edge_y) <
             (CAN_HEIGHT - 
               (((PRECS * CAN_HEIGHT)/(MAP_BLOCKSIZE/2) * 
                 abs(point->pos.x -
                     map_points[mapp_y][mapp_x].edge_x -
                     MAP_BLOCKSIZE/2)) >> SHFTPR)) ) {
          if (point->type == BULLET)
            kill_cannon( (ACannon *)map_points[mapp_y][mapp_x].objectptr );
          point->draw_it = FALSE;
          point->life    = 0;
          point = point->next;
          continue;
        } else {
          if (point->type == BULLET) {
            point->lastmap = C_DN;
            point->lpos.x = mapp_x;
            point->lpos.y = mapp_y;
          }
        }
        break;
      case BLOCK_CL:
        CHECK_DEAD_CANNON;
        if ( (point->pos.x - map_points[mapp_y][mapp_x].edge_x) >
             (MAP_BLOCKSIZE-(CAN_HEIGHT - 
               (((PRECS * CAN_HEIGHT)/(MAP_BLOCKSIZE/2) * 
                 abs(point->pos.y -
                     map_points[mapp_y][mapp_x].edge_y -
                     MAP_BLOCKSIZE/2)) >> SHFTPR))) ) {
          if (point->type == BULLET)
            kill_cannon( (ACannon *)map_points[mapp_y][mapp_x].objectptr );
          point->draw_it = FALSE;
          point->life    = 0;
          point = point->next;
          continue;
        } else {
          if (point->type == BULLET) {
            point->lastmap = C_LF;
            point->lpos.x = mapp_x;
            point->lpos.y = mapp_y;
          }
        }
        break;
      case BLOCK_CR:
        CHECK_DEAD_CANNON;
        if ( (point->pos.x - map_points[mapp_y][mapp_x].edge_x) <
             (CAN_HEIGHT - 
               (((PRECS * CAN_HEIGHT)/(MAP_BLOCKSIZE/2) * 
                 abs(point->pos.y -
                     map_points[mapp_y][mapp_x].edge_y -
                     MAP_BLOCKSIZE/2)) >> SHFTPR)) ) {
          if (point->type == BULLET)
            kill_cannon( (ACannon *)map_points[mapp_y][mapp_x].objectptr );
          point->draw_it = FALSE;
          point->life    = 0;
          point = point->next;
          continue;
        } else {
          if (point->type == BULLET) {
            point->lastmap = C_RG;
            point->lpos.x = mapp_x;
            point->lpos.y = mapp_y;
          }
        }
        break;
      default:
        break;
    }
    
    /* 
     * Check if point inside screen boudaries 
     */
    point->draw_it = FALSE;
    cu_x = point->pos.x-bp_x;
    cu_y = point->pos.y-bp_y;

    if ( cu_x > MAP_BLOCKSIZE )
      if ( cu_x < MAP_BLOCKSIZE+SCR_WIDTH )
        if ( cu_y > MAP_BLOCKSIZE )
          if ( cu_y < MAP_BLOCKSIZE+SCR_HEIGHT )
            point->draw_it = TRUE;

    point = point->next;
  }
}

/*-------------------------------------------------------------------------*/

/*
 * check_player2points -- Checks if a player has been hit by a point and
 *                        if hit acts accordingly.
 */
void
check_player2points( AShip *player )
{
  int tot_mass;

  APoint *point = World.points->next;

  if (player->status > 0)
    return;

  while (point->next != point) {

    if (point->life <= 0) {
      point = point->next;
      continue;
    }

    if (IN_RANGE(player, point, SHL_SIZE-3)) {
      switch (point->type) {
        case EXHAUST:
        case EXPLOSION:
          if (player == World.remote_ship)
            break;
          point->life = 0;
          point->draw_it = FALSE;

          /*
           * Check that it's the local ship. Remote ship handles
           * its own collisions.
           */
          if (player != World.remote_ship) {
            tot_mass = point->mass + player->mass;
            player->xvel = (player->xvel * player->mass + 
                            point->xvel * point->mass) / tot_mass;
            player->yvel = (player->yvel * player->mass + 
                            point->yvel * point->mass) / tot_mass;
          }
          break;
        case BULLET:
        case CANNON_SHOT:
          point->life = 0;
          point->draw_it = FALSE;
          player->fuel -= 5;
          if (!player->shields) {
            KILL_PLAYER;
            return;
          }
          break;
        default:
          break;
      }
    }
    point = point->next;
  }
}


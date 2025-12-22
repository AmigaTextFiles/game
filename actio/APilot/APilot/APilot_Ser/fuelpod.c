/***************************************************************************
 *
 * fuelpod.c -- Functions for handling fuelpods.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
 *
 */

/*--------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <exec/types.h>
#include <libraries/dos.h>

#include "common.h"
#include "fuelpod.h"

#include "main_protos.h"

/*--------------------------------------------------------------------------*/

#define OBJ_RANGE(o1, o2)       ( (((o1)->pos.x-(o2)->pos.x) *   \
                                   ((o1)->pos.x-(o2)->pos.x)) +  \
                                  (((o1)->pos.y-(o2)->pos.y) *   \
                                   ((o1)->pos.y-(o2)->pos.y)) ) 

extern AWorld World;

/*--------------------------------------------------------------------------*/

/*
 * alloc_fuelpod -- Allocate a new pod and at it to the world fuelpod list.
 *
 */                 
AFuelPod *
alloc_fuelpod(int map_x, int map_y)
{
  AFuelPod *pod;

  if ( (pod = (AFuelPod *) malloc(sizeof(AFuelPod))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for fuelpods.\n" );

  pod->mapos.x = map_x;
  pod->mapos.y = map_y;
  pod->pos.x   = map_x * MAP_BLOCKSIZE + MAP_BLOCKSIZE / 2;
  pod->pos.y   = map_y * MAP_BLOCKSIZE + MAP_BLOCKSIZE / 2;
  pod->fuel    = 0;
  pod->fuelcount = 0;

  pod->next = World.fuelpods->next;
  World.fuelpods->next = pod;
    
  return pod;
}

/*--------------------------------------------------------------------------*/

/*
 * fuel_ship -- If the ship tries to fuel check if there are some nearby
 *              fuelpods; and if there are start fueling the ship.
 */
void
fuel_ship( AShip *ship )
{
  int minrange = 0;
  int fuelreq, fueltrans;
  int range, x, y;
  int mapp_x, mapp_y;
  int start_x, end_x, start_y, end_y;
  AFuelPod  *fuelpod;
  MAP_Point **map_points = World.map_points;

  /*
   * Check if the ship already is fueling.
   */
  if (ship->fpod != NULL) {
    if (OBJ_RANGE(ship, ship->fpod) > 
        (2 * ((MAP_BLOCKSIZE+MAP_BLOCKSIZE/3+MAP_BLOCKSIZE) * 
              (MAP_BLOCKSIZE+MAP_BLOCKSIZE/3+MAP_BLOCKSIZE))) ) {
      ship->fpod    = NULL;
      ship->fueling = FALSE;
      return;
    } else {
      fuelreq   = min(MAXFUEL-ship->fuel, FUELSPEED);
      fueltrans = min(fuelreq, ship->fpod->fuel);
      ship->fpod->fuel -= fueltrans;
      ship->fuel       += fueltrans;
      if (ship->fpod->fuel == 0) {
        ship->fpod    = NULL;
        ship->fueling = FALSE;
      }
      return;
    }
  }
  
  /*
   * Ship is not fueling, find a suitable fuelpod (the closest in range)..
   */
  mapp_x = ship->pos.x / MAP_BLOCKSIZE;
  mapp_y = ship->pos.y / MAP_BLOCKSIZE;
  
  start_x = max(0, mapp_x-1);
  start_y = max(0, mapp_y-1);
  end_x   = min(World.Width-1, mapp_x+1);
  end_y   = min(World.Height-1, mapp_y+1);

  for (x = start_x; x <= end_x; x++) {
    for (y = start_y; y <= end_y; y++) {
      if (map_points[y][x].blocktype == BLOCK_FUEL) {
        range = OBJ_RANGE(ship, (AFuelPod *)map_points[y][x].objectptr);
        if (range < minrange || minrange == 0) {
          minrange = range;
          fuelpod = (AFuelPod *) map_points[y][x].objectptr;
        }
      }

    }
  }

  if (minrange != 0) {
    ship->fueling = TRUE;
    ship->fpod = fuelpod;
  } else {
    ship->fueling = FALSE;
    ship->fpod = NULL;
  }
}

/*--------------------------------------------------------------------------*/

/*
 * update_fuelpods -- Goes through the whole fuelpod list and adds fuel
 *                    to every pod.
 */
void
update_fuelpods( UWORD nframes )
{
  AFuelPod *pod = World.fuelpods->next;

  while (pod->next != pod)
  {
    pod->fuelcount += nframes;

    if (pod->fuelcount >= FILLSPEED) {
      pod->fuelcount = 0;
      pod->fuel++;
    }
    if (pod->fuel > MAX_PODFUEL)
      pod->fuel = MAX_PODFUEL;

    pod = pod->next;
  }
}

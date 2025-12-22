/****************************************************************************
 *
 * lists.c -- Handling of list structures..
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
 *
 */

#include <stdlib.h>
#include <exec/types.h>
#include <libraries/dos.h>          /* Official return codes defined here */

#include "main_protos.h"

#include "common.h"
#include "defs.h"

#include "lists.h"

/*-------------------------------------------------------------------------*/

extern AWorld World;

/*-------------------------------------------------------------------------*/

/*
 * init_points -- Allocate a chuck of memory for points moving on the
 *                screen and initialize the list structure.
 */
void
init_points(void)
{
  int i;
  APoint *pointail;

  World.points = (APoint *) malloc(sizeof(APoint));
  pointail  = (APoint *) malloc(sizeof(APoint));
  free_point_head = (APoint *) malloc (sizeof (APoint) * POINT_CHUNK_SIZE);
  
  if ((World.points == NULL) || (pointail == NULL) || (free_point_head == NULL))
    cleanExit( RETURN_WARN, "** Failed to allocate space for points.\n" );

  for (i = 0; i < (POINT_CHUNK_SIZE - 1); i++)
      free_point_head[i].next = &free_point_head[i + 1];
  free_point_head[POINT_CHUNK_SIZE - 1].next = NULL;

  World.points->next = pointail;
  World.points->prev = World.points;
  pointail->next  = pointail;
  pointail->prev  = World.points;
}

/*-------------------------------------------------------------------------*/

/*
 * alloc_point -- Allocate space for a point from the free_point list.
 *
 */
APoint *
alloc_point (void)
{
  int i;
  APoint *newPoint;

  if (free_point_head == NULL)
    return NULL;

  newPoint = free_point_head;
  free_point_head = newPoint->next;

  newPoint->next  = World.points->next;
  newPoint->prev  = World.points;
  World.points->next->prev = newPoint;
  World.points->next = newPoint;
  
  for (i = 0; i < MY_BUFFERS; i++)
    newPoint->p_pos[i].x = newPoint->p_pos[i].y = 0;
  newPoint->drawn   = 0;
  newPoint->xcount  = newPoint->ycount = 0;
  newPoint->draw_it = FALSE;
  newPoint->lastmap = C_NONE;
  return newPoint;
}

/*-------------------------------------------------------------------------*/

/*
 * free_point -- Frees a point from the active-points list and puts it in
 *               the free_point list.
 */
void
free_point (APoint *aPoint)
{
  aPoint->prev->next = aPoint->next;
  aPoint->next->prev = aPoint->prev;
  aPoint->next = free_point_head;
  free_point_head = aPoint;
  return;
}

/*-------------------------------------------------------------------------*/

/*
 * alloc_base -- Adds a base to the base list.
 *
 */
ABase *
alloc_base(int map_x, int map_y)
{
  ABase *base;

  if ( (base = (ABase *) malloc(sizeof(ABase))) == NULL )
    cleanExit( RETURN_WARN, "** Unable to get memory for bases.\n" );

  base->mapos.x = map_x;
  base->mapos.y = map_y;
  base->owner   = NULL;

  base->next = World.bases->next;
  World.bases->next = base;

  return base;
}

/*-------------------------------------------------------------------------*/

/*
 * get_base -- Gets the next free base from the base-list.
 *
 */
ABase *
get_base(void)
{
  ABase *base      = World.bases->next;
  ABase *free_base = NULL;

  while (base->next != base && free_base == NULL) {
    if (base->owner == NULL) {
      /* Found an empty base */
      free_base = base;
      break;
    }
    base = base->next;
  }  
  return free_base;
}

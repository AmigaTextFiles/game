/***************************************************************************
 *
 * Points.c -- Functions used for calculations and displaying of points.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <exec/types.h>
#include <intuition/intuition.h>    /* Intuition data strucutres, etc.    */
#ifdef PURE_OS
#include <proto/graphics.h>
#endif

#include "lists_protos.h"
#include "misc_protos.h"
#include "points_protos.h"
#include "prefs.h"
#include "common.h"
#include "defs.h"
#include "map.h"

/*--------------------------------------------------------------------------*/

extern int sina[];
extern int cosa[];
extern int atana[];

extern AWorld World;

APoint explosion_point[EXP_MAXSIZE];

/*--------------------------------------------------------------------------*/

/*
 * init_explosion -- Precalculate a nice big eye-catching random explosion.
 */
void
init_explosion( void )
{
  int i;
  int expangle, expmult;

  for (i = 0; i < EXP_MAXSIZE; i++) {
    rand();  /* Why not? We wan't it REAL random don't we? :-) */
    rand();
    explosion_point[i].life = EXP_LIFE + ((rand() % EXP_LIFESPREAD*2)
                              - EXP_LIFESPREAD);
    expmult  = (int) ( (((float)(rand() % 10) + 8.0)/4.0) * (float)PRECS);
    expangle = rand() % 360;      

    explosion_point[i].xvel =  (sina[expangle] * expmult) / PRECS;    
    explosion_point[i].yvel =  (cosa[expangle] * expmult) / PRECS;
  }
}

/*--------------------------------------------------------------------------*/

/*
 * add_bullets -- Adds bullet to the world from the ship aShip.
 *
 */
void
add_bullets( AShip *aShip, int isin, int icos )
{
  int i, j;
  int nbull;
  int sinval, cosval;
  int spreadangle, shangle, bulangle;
  APoint *bullet;

  shangle = aShip->angle;
  spreadangle = BUL_ANGLE;
  
  nbull= aShip->fw_nbul;

  /* Do this only two times; once for forward bullets and once for backward */
  for (j = 0; j < 2; j++) {
    /* Check if we have a bullet in the same direction as the ship */
    if ( nbull & 1 ) {
      if ((bullet = alloc_point()) == NULL)
        return;
      bullet->type = BULLET;
      bullet->mass = BUL_MASS;
      bullet->xvel = aShip->xvel + isin * BUL_SPEED;    
      bullet->yvel = aShip->yvel - icos * BUL_SPEED;
      bullet->life = BUL_LIFE;
      bullet->color = WHITE;
      bullet->pos.x = (aShip->pos.x + ((aShip->buldist * isin) >> SHFTPR));
      bullet->pos.y = (aShip->pos.y - ((aShip->buldist * icos) >> SHFTPR));
      nbull--;
    }
    for (i = 1; i <= nbull; i++) {
      if ((bullet = alloc_point()) == NULL)
        return;
      if (i & 1) {
        bulangle = (shangle - i * spreadangle) % 360;
        if (bulangle < 0)
          bulangle = bulangle + 360;
        sinval = sina[bulangle];
        cosval = cosa[bulangle];
      } else {
        bulangle = (shangle + (i-1) * spreadangle) % 360;
        if (bulangle < 0)
          bulangle = bulangle + 360;
        sinval = sina[bulangle];
        cosval = cosa[bulangle];
      }
      bullet->type = BULLET;
      bullet->mass = BUL_MASS;
      bullet->xvel = aShip->xvel + sinval * BUL_SPEED;    
      bullet->yvel = aShip->yvel - cosval * BUL_SPEED;
      bullet->life = BUL_LIFE;
      bullet->color = WHITE;
      bullet->pos.x = (aShip->pos.x + ((aShip->buldist * sinval) >> SHFTPR));
      bullet->pos.y = (aShip->pos.y - ((aShip->buldist * cosval) >> SHFTPR));
    }
    /* Switch to backward bullets */
    nbull = aShip->bw_nbul;
    shangle = (shangle + 180) % 360;
    isin *= -1;
    icos *= -1;
  }
}

/*--------------------------------------------------------------------------*/

/*
 * add_explosion -- Add an explosion at the specified coordinates. Copies the
 *                  precalculated explosion parameters into the list of points
 *                  moving on screen.
 */
void
add_explosion( int x, int y )
{
  int i;

  APoint *expPoint;

  /* Copy precalc explosion to screen-points */
  for (i = 0; i < EXP_MAXSIZE; i++) {
    if ((expPoint = alloc_point()) == NULL)
      return;
    expPoint->type  = EXPLOSION;
    expPoint->mass  = EXP_MASS;
    expPoint->color = RED;
    expPoint->pos.x = x;
    expPoint->pos.y = y;
    expPoint->xvel = explosion_point[i].xvel;
    expPoint->yvel = explosion_point[i].yvel;
    expPoint->life = explosion_point[i].life;
  }
}

/*--------------------------------------------------------------------------*/

/*
 * add_exhaust -- Adds exhaust to a ship. shsin, shcos and shangle provided to
 *                minimize time spent on calculations.
 */
void
add_exhaust(AShip *aShip, int isin, int icos, UWORD nframes)
{
  int i, xoffset, xoffsign, edist;
  int exhmult, exhangle;

  APoint *exhPoint;
  
  for (i = 0; i < (aShip->exhcount * nframes); i++) {
    if ((exhPoint = alloc_point()) == NULL)
      return;

    exhPoint->type  = EXHAUST;
    exhPoint->mass  = EXH_MASS;
    exhPoint->color = RED;
    exhPoint->life = aShip->exhlife + ((rand() % EXH_LIFESPREAD*2)
                     - EXH_LIFESPREAD);
    xoffset  = (rand() % aShip->exhwidth) - (aShip->exhwidth-1)/2;
    xoffsign = (xoffset == 0) ? 0 : xoffset/abs(xoffset);
    exhmult  = (((rand() % 20) + 8) << SHFTPR)/10;
    
    exhangle = (aShip->angle - xoffsign * atana[((xoffsign*xoffset) << SHFTPR)
                /aShip->exhdist]) % 360;
    if (exhangle < 0)
      exhangle += 360;

    /*
     * This is so that we won't get a line of collected points at exhdist;
     * if for example nframes = 3 we would get aShip->exhcount * 3 number
     * of points at exhdist from ship center..Doesn't look nice..
     */
    edist = aShip->exhdist + (rand() % 5);

    /* Rotate the starting point */ 
    exhPoint->pos.x = aShip->pos.x + 
                      ((xoffset * icos - edist * isin) >> SHFTPR);
    exhPoint->pos.y = aShip->pos.y + 
                      ((xoffset * isin + edist * icos) >> SHFTPR);

    /* Set exhaust vels */
    exhPoint->xvel = aShip->xvel - ((sina[exhangle] * exhmult) >> SHFTPR);    
    exhPoint->yvel = aShip->yvel + ((cosa[exhangle] * exhmult) >> SHFTPR);
  }
}

/*--------------------------------------------------------------------------*/

/*
 * move_points -- Moves all the points to their next positions.
 *
 */
void
move_points( UWORD buf, UWORD nframes )
{
  APoint *point = World.points->next;  

  while (point->next != point) {
    if (point->life > 0) {
      point->xcount += point->xvel * nframes;
      point->ycount += point->yvel * nframes;
      point->pos.x += (point->xcount < 0) ? -((-point->xcount) >> SHFTPR) 
                                          :     (point->xcount >> SHFTPR);
      point->pos.y += (point->ycount < 0) ? -((-point->ycount) >> SHFTPR) 
                                          :     (point->ycount >> SHFTPR);
      point->ycount = point->ycount % PRECS;
      point->xcount = point->xcount % PRECS;
    }
    point = point->next;
  }
}

/*--------------------------------------------------------------------------*/

/*
 * draw_points -- Removes previous points, checks if points life has
 *                run out and draws new points.
 */
void
#ifdef PURE_OS
draw_points( AShip *player, struct RastPort *rp, UWORD buf, UWORD nframes )
#else
draw_points( AShip *player, struct BitMap *bm, UWORD buf, UWORD nframes )
#endif
{
  int bp_x, bp_y;
  int cu_x, cu_y;
  APoint *point = World.points->next;  
  APoint *after_delete;

#ifndef PURE_OS
  PLANEPTR plane0 = bm->Planes[0];
  PLANEPTR plane1 = bm->Planes[1];
#endif

  bp_x = player->pos.x-(SCR_WIDTH+MAP_BLOCKSIZE*2)/2;
  bp_y = player->pos.y-(SCR_HEIGHT+MAP_BLOCKSIZE*2)/2;

  /*
   * Remove points...
   */
#ifdef PURE_OS
  SetAPen(rp,0); /* Want to erase pixels */
#endif
  while (point->next != point) {
    if (point->drawn != 0) {
      point->drawn &= ~(1 << buf);
#ifdef PURE_OS
      WritePixel(rp, point->p_pos[buf].x,point->p_pos[buf].y);
#else
      myWritePixel(plane0, point->p_pos[buf].x, point->p_pos[buf].y, 0);
      if (point->color == WHITE)
        myWritePixel(plane1, point->p_pos[buf].x, point->p_pos[buf].y, 0);
#endif
    }      

    /* 
     * Check if the point's life has run out...
     */
    if ((point->life -= nframes) <= 0) {
      point->draw_it = FALSE;
      if (point->drawn == 0) {
        after_delete = point->next;
        free_point(point);
        point = after_delete;
        continue;
      }
      point = point->next;
      continue;
    }
    point = point->next;
  }

  /*
   * Draw points...
   */
  point = World.points->next;  
  while (point->next != point) {
    if (point->draw_it && point->life > 0) {
      point->drawn |= (1 << buf);
      cu_x = point->p_pos[buf].x = point->pos.x-bp_x;
      cu_y = point->p_pos[buf].y = point->pos.y-bp_y;

#ifdef PURE_OS
      if (point->color == WHITE) {
	SetAPen(rp,3);
	WritePixel(rp, cu_x, cu_y);
      } else {
	SetAPen(rp,1);
	WritePixel(rp, cu_x, cu_y);
      }
#else
      myWritePixel(plane0, cu_x, cu_y, 1);
      if (point->color == WHITE)
    	  myWritePixel(plane1, cu_x, cu_y, 1);
#endif
    }
    point = point->next;
  }
}


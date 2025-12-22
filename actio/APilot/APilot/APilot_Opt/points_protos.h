/**************************************************************************
 *
 * points_protos.h -- Protos for points.c
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

#include "common.h"

void init_explosion( void );
void add_bullets( AShip *aShip, int isin, int icos );
void add_explosion( int x, int y );
void add_exhaust(  AShip *aShip, int isin, int icos, UWORD nframes );
void move_points( UWORD buf, UWORD nframes );
#ifdef PURE_OS
void draw_points( AShip *player, struct RastPort *rp, UWORD buf, UWORD nframes );
#else
void draw_points( AShip *player, struct BitMap *bm, UWORD buf, UWORD nframes );
#endif

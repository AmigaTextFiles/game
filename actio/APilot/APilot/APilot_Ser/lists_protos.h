/***************************************************************************
 *
 * lists_protos.h -- Protos for lists.c
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

#include "common.h"

void init_points( void );
APoint *alloc_point( void );
void free_point( APoint *aPoint );
ABase *alloc_base(int map_x, int map_y);
ABase *get_base(AShip *ship);

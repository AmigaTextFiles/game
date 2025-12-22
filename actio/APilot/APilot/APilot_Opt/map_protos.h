/***************************************************************************
 *
 * map_protos.h -- Protos for map.c
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

#include <intuition/intuition.h>

#include "common.h"

void init_map( void );
void init_maptables( BOOL u_tbl[], BOOL d_tbl[], BOOL l_tbl[], BOOL r_tbl[] );
void prepare_map( void );
void optimize_map(void);
void draw_map( struct RastPort *wRp, AShip *local_ship, 
               UWORD buf, UWORD nframes );

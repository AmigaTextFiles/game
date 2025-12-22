/**************************************************************************
 * 
 * cannon_protos.h
 *
 *-------------------------------------------------------------------------
 * Authors:  Casper Gripenberg  (casper@alpha.hut.fi)
 *           Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

#include "common.h"

ACannon *alloc_cannon( int map_x, int map_y, cdir_t direction );
void kill_cannon( ACannon *cannon );
void update_cannons( AShip *ship, UWORD nframes );
void fire_cannon( ACannon *cannon );

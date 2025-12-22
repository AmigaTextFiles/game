/*************************************************************************
 *
 * collision_protos.h
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

#include "common.h"

void check_collisions( void );
void check_ships( AShip *player );
void check_points( void );
void check_player2player( AShip *player );
void check_player2points( AShip *player );

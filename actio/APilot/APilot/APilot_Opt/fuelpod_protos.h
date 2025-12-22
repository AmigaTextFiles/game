/**************************************************************************
 *
 * fuelpod_protos.h
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

AFuelPod *alloc_fuelpod(int map_x, int map_y);
void fuel_ship( AShip *ship );
void update_fuelpods( UWORD nframes );

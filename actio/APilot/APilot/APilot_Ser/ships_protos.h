/***************************************************************************
 *
 * ships_protos.h -- Protos for ships.c
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

void init_ship( AShip *aShip );
BOOL landing( AShip *ship );
void update_ship( AShip *aShip, UWORD buf, UWORD nframes );
void draw_ship( AShip *aShip, struct RastPort *rp, UWORD buf );

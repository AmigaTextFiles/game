/***************************************************************************
 *
 * hrzline_protos.h -- Protos for our external asm line drawer.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

#include <graphics/gfx.h>

extern void __asm HorizontalLine (register __a0 PLANEPTR bpl,
                                  register __d2 int x,
                                  register __d1 int y,
                                  register __d3 int length,
                                  register __d4 int onoff);

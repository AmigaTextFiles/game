/***************************************************************************
 *
 * misc_protos.h -- Protos for misc.c
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

void init_sctables( void );
#ifndef PURE_OS
void init_writepixel( int bytesPerRow );
void myWritePixel( PLANEPTR thePlane, int x, int y, int mode );
void VerticalLine( PLANEPTR thePlane, int x, int y, int length, int onoff );
#endif
void draw_hud( struct RastPort *rp, UWORD buf, UWORD nframes );

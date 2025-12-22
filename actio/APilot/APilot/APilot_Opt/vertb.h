/****************************************************************************
 *
 * vertb.h
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

struct VertBData {
  struct Task *maintask;   /* Task to signal           */
  ULONG mainsig;           /* Allocated signal         */
  UWORD sigframe;          /* Which frame to signal on */
  APTR  nframes;           /* Increases every frame    */
};

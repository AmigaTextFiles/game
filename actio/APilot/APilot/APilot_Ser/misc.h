/***************************************************************************
 *
 * misc.h -- Defs for misc.c
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */
#include "prefs.h"
#include "map.h"

/*
 * For myWritePixel precalculation tables
 * Make sure this is bigger than the larger
 * of screen bitmap width or height.       
 */
#if MAXResX > MAXResY 
#define WP_TABLESIZE    MAXResX + MAP_BLOCKSIZE*2 + 5
#else
#define WP_TABLESIZE    MAXResY + MAP_BLOCKSIZE*2 + 5
#endif

/*
 * Some drawing primitives
 */
#ifdef PURE_OS
#define VLINE(RP,X,Y,LEN)  { Move(RP,X,Y); Draw(RP,X,(Y+LEN-1)); }
#define HLINE(RP,X,Y,LEN)  { Move(RP,X,Y); Draw(RP,(X+LEN-1),Y); }
#endif

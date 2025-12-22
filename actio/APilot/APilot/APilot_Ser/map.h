/***************************************************************************
 *
 * map.h -- Map specific definitions.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

#ifndef __MAP_H__
#define __MAP_H__

#define MAPFILE "APilot.mapfile"      /* Name of the mapfile         */

#define MAXLINE         400           /* Maximum length of a mapline */

#define MAP_BLOCKSIZE   32            /* Number of pixels on-screen  */
                                      /* occupied by one block       */

/* These define the different blocktypes */
typedef enum { 
  BLOCK_EMPTY,
  BLOCK_FILLED_ND,  /* Filled but No Draw (Don't draw it) */
  BLOCK_FILLED,     /*   x   */
  BLOCK_RU,         /*   a   */       
  BLOCK_LU,         /*   s   */
  BLOCK_RD,         /*   q   */
  BLOCK_LD,         /*   w   */
  BLOCK_CU,         /*   r   */
  BLOCK_CD,         /*   c   */
  BLOCK_CL,         /*   d   */
  BLOCK_CR,         /*   f   */
  BLOCK_FUEL,       /*   #   */
  BLOCK_BASE,       /*   _   */
} btype;

/* And these define which lines to draw in each block */
#define DRAW_UP         1
#define DRAW_DOWN       2
#define DRAW_LEFT       4
#define DRAW_RIGHT      8

typedef struct _map_point {
  APTR   objectptr;           /* This points to the object at this location. */
                              /* Used for cannons, fueltanks etc..           */
  UWORD  edge_x;              /* Coordinates of the upper left edge */
  UWORD  edge_y;
  btype  blocktype;
  USHORT draw_flags;          /* Only for BLOCK_FILLED */
} MAP_Point;

#endif

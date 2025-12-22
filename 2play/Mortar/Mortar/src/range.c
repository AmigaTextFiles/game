/* 
 * MORTAR
 * 
 * -- ground elevation calculation
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */

#include <stdlib.h>
#include "mortar.h"

/* ground elevation */
static short *Ground;

static int Straights;
static float Jaggedness = 1;

static int Offset;    /* min elevation */
static int Elevation;   /* max elevation */


void range_straights(int value)   { Straights = value; }
void range_offset(int value)    { Offset = value; }
short *range_ground(void)   { return Ground; }


/* iterate into smaller ranges until the whole range is filled
 */
static void range_do(int a, int b)
{
  short d, h, j;

  /* distance half and middle heigth */
  d = (b - a) >> 1;
  h = (Ground[b] + Ground[a]) >> 1;

  /* not too small distance?
  */
  if (d >= Straights) {

    j = d * Jaggedness;

    /* add some random to the height
     */
    h += RND(j) - (j >> 1);

    /* limit to the range */
    if (h < Offset) {
      h = Offset;
    } else {
      if(h > Elevation) {
        h = Elevation;
      }
    }
  }

  d += a;

  /* new midpoint height */
  Ground[d] = h;

  /* range still divisable? */
  if(b - a > 2) {

    /* iterate new ranges at both sides of midpoint */
    range_do(a, d);
    range_do(d, b);
  }
}


short *range_create(int wd, int ht)
{ 
  static int size;
  int range, half;

  if (size && wd != size) {
    free(Ground);
    Ground = NULL;
  }

  if (!Ground) {
    size = wd;
    Ground = calloc(1, size * sizeof(*Ground));
    if (!Ground) {
      msg_print(ERR_ALLOC);
      return NULL;
    }
    Jaggedness = get_float("jaggedness");
  }
  Elevation = ht - 1;
  range = Elevation - Offset;

  half = --wd / 2;

  /* ground initilization */
  Ground[0]    = RND(range) + Offset;
  Ground[half] = RND(range) + Offset;
  Ground[wd]   = RND(range) + Offset;

  range_do(0, half);
  range_do(half, wd);

  return Ground;
}


int range_level(int x)
{
  int h, idx;

  h = Ground[x];
  idx = Straights;
  x -= idx / 2;

  /* should keep within range (pun intended ;-)) */
  while (--idx >= 0) {
    Ground[x++] = h;
  }
  return h;
}

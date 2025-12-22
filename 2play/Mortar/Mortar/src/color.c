/* 
 * MORTAR
 * 
 * -- hightlight color calculation and setting
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include "mortar.h"

static int black, white, offset, colors;


void color_init(int first, int start, int cols)
{
  black = first;
  white =  start>first ? start-1 : first;
  offset = start;
  colors = cols;
}

m_uchar *color_range(int *lenght)
{
  *lenght = colors;
  return &(map_get()[offset]);
}

int color_white(void)
{
  return map_get()[white];
}
int color_black(void)
{
  return map_get()[black];
}
int color_gray(void)
{
  return map_get()[(white - black + 1) >> 1];
}


void color_invert(int index, m_rgb_t *color)
{
  m_rgb_t rgb;
  rgb.r = 0xff - color->r;
  rgb.g = 0xff - color->g;
  rgb.b = 0xff - color->b;
  win_changecolor(index, &rgb);
}


/* sets colors from black through 'rgb' to white for the color index range
 * given to color_init()
 */
void color_set(m_rgb_t *color)
{
  int idx, val, mid, off;
  m_uchar *map, r, g, b;
  m_rgb_t rgb;

  r = color->r;
  g = color->g;
  b = color->b;

  map = map_get();

#ifdef DEBUG
  if (offset + colors >= Screen->colors) {
    win_exit();
    fprintf(stderr, "hilite.c/do_hilite(): offset+count off limits!\n");
    exit(1);
  }
#endif

  /* we'll have 'idx' starting from 1 as we don't change black
   */
  off = offset - 1;
  mid = (colors+1) >> 1;
  for (idx = 1; idx <= colors; idx++) {
    if (idx > mid) {
      val = (idx - mid) * 0xff / (colors - mid);
      rgb.r = r < 0xff ? val : 0xff;
      rgb.g = g < 0xff ? val : 0xff;
      rgb.b = b < 0xff ? val : 0xff;
    } else {
      rgb.r = r * idx / mid;
      rgb.g = g * idx / mid;
      rgb.b = b * idx / mid;
    }
    win_changecolor(map[off + idx], &rgb);
  }
}


#define CYCLE_COUNT 31

int color_cyclecount(void)
{
  return 2 * CYCLE_COUNT;
}

/* cycles last color by 'ping-ponging' it between 'src' and 'dst' */
int color_cycle(int color, int counter)
{
  m_rgb_t src = { 0x80, 0x00, 0x00 };
  m_rgb_t dst = { 0xff, 0xff, 0x80 };
  m_rgb_t rgb;
  int value;

  if (counter < 0 || counter > 2 * CYCLE_COUNT) {
    counter = 0;
  }
  if (counter > CYCLE_COUNT) {
    value = 2 * CYCLE_COUNT - counter;
  } else {
    value = counter;
  }
  rgb.r = src.r + (long)(dst.r - src.r) * value / CYCLE_COUNT;
  rgb.g = src.g + (long)(dst.g - src.g) * value / CYCLE_COUNT;
  rgb.b = src.b + (long)(dst.b - src.b) * value / CYCLE_COUNT;

  win_changecolor(color, &rgb);
  return counter + 1;
}

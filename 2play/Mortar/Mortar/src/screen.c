/* 
 * MORTAR
 * 
 * -- double-buffer / 'dirty rectangle' updating
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero tamminen
 *
 * NOTES:
 * - Adding code for Screen offsets into screen_update(), we could have
 *   (scrollable) larger than screen playing areas.
 */

#include <stdlib.h>
#include "mortar.h"


static struct {
  int x1, y1;
  int x2, y2;
  int dirty;
} Update;

static void clean_update(void)
{
  Update.x2 = 0;
  Update.y2 = 0;
  Update.x1 = Screen->wd;
  Update.y1 = Screen->ht;
  Update.dirty = 0;
}


int screen_init(int wd, int ht, int colors)
{
  Screen = bm_alloc(wd, ht, colors);
  if (!Screen) {
    return 0;
  }
  clean_update();
  return 1;
}


/* set which part of screen was drawn into
 */
void screen_dirty(int x, int y, int w, int h)
{
  w += x;
  h += y;

  /* completely outside screen? */
  if (w < 0 || h < 0 || x >= Screen->wd || y >= Screen->ht) {
    return;
  }

  if (x < Update.x1) {
    Update.x1 = x;
  }
  if (y < Update.y1) {
    Update.y1 = y;
  }
  if (w > Update.x2) {
    Update.x2 = w;
  }
  if (h > Update.y2) {
    Update.y2 = h;
  }
  Update.dirty = 1;
}


/* get the dirty Screen area 
 */
int screen_rect(int *x, int *y, int *w, int *h)
{
  if (!Update.dirty) {
    return 0;
  }

  /* limit inside screen */
  *x = (Update.x1 < 0 ? 0 : Update.x1);
  *y = (Update.y1 < 0 ? 0 : Update.y1);
  *w = (Update.x2 < Screen->wd ? Update.x2 : Screen->wd);
  *h = (Update.y2 < Screen->ht ? Update.y2 : Screen->ht);

  *w -= *x;
  *h -= *y;

  clean_update();
  return 1;
}


#if 0   /* currrently not needed */

/* if given co-ordinates would need clipping, return true,
 * else (everything completely inside Screen) return false.
 */
int screen_clip(int x, int y, int w, int h)
{
  w += x;
  h += y;

  if (x < 0 || y < 0 || w >= Screen->wd || h >= Screen->ht) {
    return 1;
  }
  return 0;
}

#include <string.h>

/* currently expects 'dest' to be same size as 'Screen'...
 */
void screen_update(m_image_t *dest)
{
  int x, y, w, h, line;
  m_uchar *src, *dst;
  long offset;

  if (!screen_rect(&x, &y, &w, &h)) {
    return;
  }

  line = Screen->wd;
  offset = line * y + x;
  src = Screen->data + offset;
  dst = dest->data + offset;

  line -= w;
  while (--h >= 0) {
    memcpy(dst, src, w);
    dst += line;
    src += line;
  }
}

#endif


void screen_box(int x, int y, int wd, int ht, int color)
{
  m_uchar *ptr;
  int swd, off;

  screen_dirty(x, y, wd, ht);

  swd = Screen->wd;
  ptr = Screen->data + y * swd + x;
  off = swd - wd;

  while (--ht >= 0) {
    x = wd;
    while (--x >= 0) {
      *ptr++ = color;
    }
    ptr += off;
  }
}


/* 
 * MORTAR
 * 
 * -- bitmap mapping functions
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include "mortar.h"

static m_uchar Mapping[256];


m_uchar *map_get(void)
{
  return Mapping;
}

/* remap/limit image color indexes
 */
void map_colors(m_image_t *bm)
{
  int max, idx, wd, ht;
  m_uchar *data;

  data = bm->data;
  max = Screen->colors;

  ht = bm->ht;
  while (--ht >= 0) {
    wd = bm->wd;
    while (--wd >= 0) {
      idx = *data;
      if (!idx) {
        data++;
        continue;
      }
      if (idx >= max) {
        idx = max - 1;
      }
      *data++ = Mapping[idx];
    }
  }
}


/* offset image values to correct places in the global
 * palette
 */
void map_offset(m_image_t *bm, int offset)
{
  m_uchar *data;
  int wd, ht;
#ifdef DEBUG
  int max = bm->colors;

  if (max + offset > 255) {
    fprintf(stderr,
      "map.c/map_offset(): illegal offset (%d)!\n",offset);
    return;
  }
#endif
  data = bm->data;

  ht = bm->ht;
  while (--ht >= 0) {
    wd = bm->wd;
    while (--wd >= 0) {
      if (!*data) {
        data++;
        continue;
      }
#ifdef DEBUG
      if (*data >= max) {
        fprintf(stderr,
          "map.c/map_offset(): illegal color value (%d,%d)!\n",*data,max);
        data++;
        continue;
      }
#endif
      *data += offset;
      data++;
    }
  }
}


void map_palette(m_image_t *bm)
{
  m_rgb_t *pal, *rgb;
  int colors, size;

  colors = bm->colors;
  size = colors * sizeof(m_rgb_t);

  pal = bm->palette;
  rgb = malloc(colors * size);
  memcpy(rgb, pal, size);

  while (--colors >= 0) {
    pal[Mapping[colors]] = rgb[colors];
  }
  free(rgb);
}

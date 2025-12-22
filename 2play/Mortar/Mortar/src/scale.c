/*
 * MORTAR
 *
 * -- scale and copy Mortar images
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */

#include <string.h>
#include "mortar.h"


m_image_t *
bm_scale(m_image_t *bm, int to_wd, int to_ht)
{
  int x, y, xoff, yoff, from_wd, from_ht;
  m_uchar *from, *to, *start_from, *start_to;
  m_image_t *ret;

  if (!bm) {
    return NULL;
  }

  if (to_wd < 1) {
    to_wd = bm->wd;
  }
  if (to_ht < 1) {
    to_ht = bm->ht;
  }

  from_wd = bm->wd;
  from_ht = bm->ht;

  if (to_wd == from_wd && to_ht == from_ht) {
    return bm;
  }

  ret = bm_alloc(to_wd, to_ht, bm->colors);
  if (!ret) {
    return NULL;
  }
  memcpy(ret->palette, bm->palette, sizeof(m_rgb_t) * bm->colors);

  start_to = ret->data;
  start_from = bm->data;

  /* (copy with) shrink / enlarge */
  yoff = y = to_ht - 1;
  while (y >= 0) {
    to = start_to;
    from = start_from;
    xoff = x = to_wd - 1;
    while (x >= 0) {
      while (xoff >= 0) {
        *to++ = *from;
        xoff -= from_wd;
        x--;
      }
      do {
        from++;
        xoff += to_wd;
      } while(xoff < 0);
    }
    while (--y >= 0) {
      yoff -= from_ht;
      start_to += to_wd;
      if (yoff < 0) {
        break;
      }
      memcpy(start_to, start_to - to_wd, to_wd);
    }
    do {
      yoff += to_ht;
      start_from += from_wd;
    } while (yoff < 0);
  }

  bm_free(bm);
  return ret;
}

m_image_t *
bm_copy(m_image_t *bm)
{
  m_image_t *ptr;

  ptr = bm_alloc(bm->wd, bm->ht, bm->colors);
  if (ptr) {
    memcpy(ptr->palette, bm->palette, bm->colors * sizeof(m_rgb_t));
    memcpy(ptr->data, bm->data, bm->wd * bm->ht);
  }
  return ptr;
}

/* 
 * MORTAR
 * 
 * -- font related functions
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */

#include "mortar.h"

static m_image_t *Font;
static int first, last, cols, wd, ht;


int font_init(m_image_t *bm)
{
  int rows;

  first = get_value("first");
  cols = get_value("columns");
  rows = get_value("rows");

  if (!(cols && rows)) {
    msg_print(ERR_VARS);
    return 0;
  }

  last = first + rows * cols - 1;
  wd = bm->wd / cols;
  ht = bm->ht / rows;
  Font = bm;

  return 1;
}


int font_height(void)  { return ht; }
int font_width(void)   { return wd; }

int font_strlen(m_uchar *s)
{
  int len;

  len = 0;
  while(*s++) {
    len += wd;
  }
  return len;
}


void font_print(m_uchar *s, int x, int y)
{
  int xoff, yoff;
  m_uchar c;

  screen_dirty(x, y, font_strlen(s), ht);

  while((c = *s++)) {

    if (c >= first && c <= last) {
      c -= first;
    } else {
      c = first;
    }
    yoff = c / cols * ht;
    xoff = c % cols * wd;
    img_blit(Font, xoff, yoff, wd, ht, x, y);

    x += wd;
  }
}


void font_clear(m_uchar *s, int x, int y)
{
  int xoff, yoff;
  m_uchar c;

  screen_dirty(x, y, font_strlen(s), ht);

  while((c = *s++)) {

    if (c >= first && c <= last) {
      c -= first;
    } else {
      c = first;
    }
    yoff = c / cols * ht;
    xoff = c % cols * wd;
    img_clblit(Font, xoff, yoff, wd, ht, x, y);

    x += wd;
  }
}

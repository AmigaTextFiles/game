/* 
 * MORTAR
 * 
 * -- screen access functions for W window system
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * NOTES
 * - works both in mono and mapped color resolutions.  On latter the
 *   palette is mapped here and on first Wlib dithers the image.
 * - window is opened at first screen update.
 */

#include <stdio.h>
#include <stdlib.h>
#include <Wlib.h>
#include "mortar.h"

#define WIN_PROPERTIES  (W_MOVE | W_TITLE | W_CLOSE | EV_KEYS)

static m_uchar Grayscale[256];
static WSERVER *Wserver;
static WWIN *Win;


int win_init(int *wd, int *ht)
{
  int colors, idx;
  m_uchar *map;

  Wserver = w_init();
  if (!Wserver) {
    return 0;
  }

  if (Wserver->type == BM_PACKEDMONO) {

    Makemono = 1;

    w_ditherOptions(Grayscale, 1);
    idx = colors = 256;
    map = map_get();

    /* use direct mapping */
    while (--idx >= 0) {
      map[idx] = idx;
    }

    /* assert correct width alignment */
    *wd = (*wd + 31) & ~31;

  } else {
    colors = 1 << Wserver->planes;
    *wd = (*wd + 15) & ~15;
  }

  if (!*wd || !*ht) {
    *wd = 320;
    *ht = 200;
  }

  if (!screen_init(*wd, *ht, colors)) {
    w_exit();
    return 0;
  }

  Win = w_create(*wd, *ht, WIN_PROPERTIES);
  if (!Win) {
    w_exit();
    return 0;
  }

  return 1;
}

void win_exit(void)
{
  if (Win) {
    w_delete(Win);  /* workaround for GSI 0.7 bug */
    w_exit();
  }
}


void win_changecolor(int index, m_rgb_t *rgb)
{
  if (Makemono) {
    Grayscale[index] = (rgb->r * 307UL + rgb->g * 599UL + rgb->b * 118UL) >> 10;
  } else {
    w_changeColor(Win, index, rgb->r, rgb->g, rgb->b);
  }
  /* have to update for image saving */
  Screen->palette[index] = *rgb;
}


/* set / map window palette.  index 0 is left for transparency.
 * should be called only once at program start
 */
int win_setpalette(int colors, m_rgb_t *pal)
{
  static uchar *map = NULL;
  m_uchar *use;
  long value;
  int idx;

  memcpy(Screen->palette, pal, colors * sizeof(m_rgb_t));

  use = map_get();
#ifdef DEBUG
  if (map) {
    win_exit();
    fprintf(stderr,
      "win-w.c/win_setpalette(): palette already set!\n");
    exit(-1);;
  }
#endif

  if (Makemono) {

    pal += colors;
    idx = colors;
    while (--idx >= 0) {
      --pal;
      value =  pal->r * 307UL;
      value += pal->g * 599UL;
      value += pal->b * 118UL;
      Grayscale[idx] = value >> 10;
    }
    return 1;
  }

  /* get mapping */
  map = w_allocMap(Win, colors, (rgb_t *)pal, NULL);
  if (!map) {
    msg_print(ERR_MAPPING);
    return 0;
  }
  memcpy(use, map, colors);
  free(map);

  map_palette(Screen);
  return 1;
}


void win_sync(void)
{
  static int open = 0;
  static BITMAP bm;
  int x, y, w, h;

  snd_flush();

  if (!screen_rect(&x, &y, &w, &h)) {
    /* nothing to update */
    return;
  }

  if (!open) {
    bm.type  = BM_DIRECT8;
    bm.width = Screen->wd;
    w_bmheader(&bm);

    bm.palette = (rgb_t *)Screen->palette;
  }

  /* update only the changed lines */
  bm.data   = Screen->data + Screen->wd * y;
  bm.height = h;

  w_putblock(&bm, Win, 0, y);

  if (!open) {
    w_open(Win, UNDEF, UNDEF);
    open = 1;
  }
}


int win_getkey(long timeout)
{
  WEVENT *ev;
  char *name;
  int key = 0;

  win_sync();

  ev = w_queryevent(NULL, NULL, NULL, timeout);
  if (ev) {
    switch (ev->type) {

    case EVENT_GADGET:
      if (ev->key == GADGET_EXIT) {
        fprintf(stderr, "mortar: server exit!\n");
        w_exit();
        exit(1);
      }
      /* GADGET_CLOSE */
      return 'q';

    case EVENT_KEY:
      switch(ev->key) {

        /* special keys */
        case WKEY_UP:     return KEY_UP;
        case WKEY_DOWN:   return KEY_DOWN;
        case WKEY_LEFT:   return KEY_LEFT;
        case WKEY_RIGHT:  return KEY_RIGHT;
        case WKEY_HOME:   return KEY_HOME;
        case WKEY_END:    return KEY_END;
        case WKEY_PGUP:   return KEY_PGUP;
        case WKEY_PGDOWN: return KEY_PGDOWN;

        default:
          key = ev->key & 0xff;
      }

      if (key == 's' || key == 'S') {

        name = get_string("snapshot");
        if (name) {
          int colors = Screen->colors;
          if (!Makemono) {
            /* mapped... */
            Screen->colors = 1 << Wserver->planes;
          }
          bm_write(name, Screen);
          Screen->colors = colors;
        }
        while (win_getkey(0));
        key = 0;
      }
      break;
    }
  }

  return key;
}

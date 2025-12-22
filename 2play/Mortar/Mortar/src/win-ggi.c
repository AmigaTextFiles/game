/* 
 * MORTAR
 * 
 * -- screen access functions for LibGGI
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Andrew Apted <andrew.apted@ggi-project.org>
 *
 * Osku Salerma <osku@iki.fi>, 13.5.1999:
 * - Fix for 15 and 32 bpp modes.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

#include "mortar.h"

#include <ggi/ggi.h>


struct ggi_screen_info {

  ggi_visual_t vis;
  ggi_mode mode;
  ggi_pixel lookup[256];

  int bytes_pp;   /* 0 for GT_INDEXED modes */
  int exposed;

} ggi_screen;


int win_init(int *wd, int *ht)
{
  int i;
  m_uchar *map;

  ggi_graphtype gt;


  if (ggiInit() != 0) {
    return 0;
  }

  ggi_screen.vis = ggiOpen(NULL);

  if (ggi_screen.vis == NULL) {
    ggiExit();
    return 0;
  }

  /* set everything to GGI_AUTO */
  ggiParseMode("", &ggi_screen.mode);

        if (*wd) ggi_screen.mode.visible.x = *wd;
        if (*ht) ggi_screen.mode.visible.y = *ht;

  ggi_screen.exposed = 0;


  /* force target to update the mode to something it can handle */
  ggiCheckMode(ggi_screen.vis, &ggi_screen.mode);

  *wd = ggi_screen.mode.visible.x;
  *ht = ggi_screen.mode.visible.y;

  gt = ggi_screen.mode.graphtype;

  if ((gt & GT_SCHEME_MASK) == GT_PALETTE) {

    ggi_screen.bytes_pp = 0;

    if ((gt & GT_DEPTH_MASK) < 4) {
      fprintf(stderr, "Target has too few colors "
        "(%d).\n", 1 << (gt & GT_DEPTH_MASK));
      ggiClose(ggi_screen.vis);
      ggiExit();
      return 0;
    }

  } else if ((gt & GT_SCHEME_MASK) == GT_TRUECOLOR) {

    ggi_screen.bytes_pp = GT_SIZE(gt) / 8;

  } else {
    fprintf(stderr, "Target mode is not supported.\n");
    ggiClose(ggi_screen.vis);
    ggiExit();
    return 0;
  }

  /* now set the mode */
  if (ggiSetMode(ggi_screen.vis, &ggi_screen.mode) != 0) {
    fprintf(stderr, "Failed to set mode.\n");
    ggiClose(ggi_screen.vis);
    ggiExit();
    return 0;
  }

  ggiSetFlags(ggi_screen.vis, GGIFLAG_ASYNC);

  if (! screen_init(*wd, *ht, 256)) {
    ggiClose(ggi_screen.vis);
    ggiExit();
    return 0;
  }

  /* use direct mapping */

  map = map_get();

  for (i=0; i < 256; i++) {
    map[i] = i;
  }

  return 1;
}


void win_exit(void)
{
  ggiSetGCForeground(ggi_screen.vis, 0);
  ggiFillscreen(ggi_screen.vis);

  ggiClose(ggi_screen.vis);
  ggiExit();
}


void win_changecolor(int index, m_rgb_t *rgb)
{
  ggi_color col;

  col.r = rgb->r << 8;
  col.g = rgb->g << 8;
  col.b = rgb->b << 8;

  ggiSetPalette(ggi_screen.vis, index, 1, &col);

  ggi_screen.lookup[index] = ggiMapColor(ggi_screen.vis, &col);
  
  /* have to update for image saving */
  Screen->palette[index] = *rgb;
}


/* set / map window palette.  index 0 is left for transparency.
 * should be called only once at program start
 */
int win_setpalette(int colors, m_rgb_t *pal)
{
  pal += colors;
  while (colors > 0) {
    win_changecolor(--colors, --pal);
  }
  return 1;
}


static void win_translate_hline(int x, int y, int w, m_uchar *data)
{
  static uint8 trans_buffer[8192];
  uint8  *buf1 = (uint8  *) trans_buffer;
  uint16 *buf2 = (uint16 *) trans_buffer;
  uint32 *buf4 = (uint32 *) trans_buffer;
  int ww = w;

  switch (ggi_screen.bytes_pp) {

  case 1:
    for (; ww > 0; ww--) {
      *buf1++ = ggi_screen.lookup[*data++];
    }
    break;

  case 2:
    for (; ww > 0; ww--) {
      *buf2++ = ggi_screen.lookup[*data++];
    }
    break;

  case 3:
    for (; ww > 0; ww--) {
      ggi_pixel pix = ggi_screen.lookup[*data++];

      *buf1++ = pix; pix >>= 8;
      *buf1++ = pix; pix >>= 8;
      *buf1++ = pix;
    }
    break;

  case 4:
    for (; ww > 0; ww--) {
      *buf4++ = ggi_screen.lookup[*data++];
    }
    break;
  }
  
  ggiPutHLine(ggi_screen.vis, x, y, w, trans_buffer);
}


void win_sync(void)
{
  m_uchar *data;
  
  int x, y, w, h;
  int y2, h2;

  snd_flush();

  /* need to redraw screen? */
  if (ggi_screen.exposed) {

    x = 0; y = 0;
    w = ggi_screen.mode.visible.x;
    h = ggi_screen.mode.visible.y;
    
    ggi_screen.exposed = 0;

  } else if (! screen_rect(&x, &y, &w, &h)) {
    /* nothing to update */
    return;
  }

  y2 = y; h2 = h;

  /* update only the changed lines */

  data = Screen->data + Screen->wd * y + x;

  if (ggi_screen.bytes_pp == 0) {
  
    for (; h2 > 0; h2--, y2++, data += Screen->wd) {
      ggiPutHLine(ggi_screen.vis, x, y2, w, data);
    }
  } else {
    for (; h2 > 0; h2--, y2++, data += Screen->wd) {
      win_translate_hline(x, y2, w, data);
    }
  }

  ggiFlushRegion(ggi_screen.vis, x, y, w, h);
}


static void win_flushkeys(void)
{
  ggi_event ev;

  struct timeval tv;

  tv.tv_sec  = 0;
  tv.tv_usec = 0;

  while (ggiEventPoll(ggi_screen.vis, emKey, &tv) != 0) {
    ggiEventRead(ggi_screen.vis, &ev, emKey);
  }
}


int win_getkey(long timeout)
{
  ggi_event ev;

  struct timeval tv;

  win_sync();

  usleep(timeout * 1000);

  tv.tv_sec  = 0;
  tv.tv_usec = 0;

  #define WANTED_EVENTS  (emKeyPress | emKeyRepeat | emExpose)

  if (ggiEventPoll(ggi_screen.vis, WANTED_EVENTS, &tv) == 0) {
    return 0;
  }

  /* Hmm... Actually the returned key should be the last one...
   * ++eero
   */
  ggiEventRead(ggi_screen.vis, &ev, WANTED_EVENTS);

  win_flushkeys();

  if (ev.any.type == evExpose) {
    ggi_screen.exposed = 1;
    win_sync();
    return 0;
  }
  
        if ((ev.any.type != evKeyPress) &&
            (ev.any.type != evKeyRepeat)) {
    return 0;
  }
  
  if ((ev.key.sym == 's') || (ev.key.sym == 'S')) {

    char *name = get_string("snapshot");

    if (name) {
      bm_write(name, Screen);
    }

    return 0;
  }

  if (GII_KTYP(ev.key.sym) == GII_KT_LATIN1) {
    return GII_KVAL(ev.key.sym);
  }

  switch (ev.key.sym) {
    case GIIK_Enter:  return KEY_ACCEPT1;
    
    case GIIK_Up:     return KEY_UP;
    case GIIK_Down:   return KEY_DOWN;
    case GIIK_Left:   return KEY_LEFT;
    case GIIK_Right:  return KEY_RIGHT;

    case GIIK_PageUp:   return KEY_PGUP;
    case GIIK_PageDown:   return KEY_PGDOWN;
    case GIIK_Home:   return KEY_HOME;
    case GIIK_End: return KEY_END;
  }

  return 0;
}


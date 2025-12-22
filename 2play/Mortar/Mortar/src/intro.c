/* 
 * MORTAR
 * 
 * -- intro and game over screens
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */


#include <stdio.h>
#include <stdlib.h>
#include "mortar.h"

#define BORDER  20
#define POINTS  256 /* max. rockets/particles flying at the same time */

/* approx. 'ticks' before: */
#define NEXT  48  /* approx. time to next rocket */
#define BURN  40  /* approx. particles burn off time */


/* flags */
#define PARTICLE  1
#define ROCKET    2
#define MOVED   4

typedef struct {
  long x, y;
  short dx, dy;
  short timer;
  short type;
} point_t;


typedef struct {
  char **map;
  int wd, ht, count;
} map_t;


static void init_image(map_t *map)
{
  char **line, *c;
  int w;

  if (map->count) {
    /* already initialized */
    return;
  }

  line = map->map;
  while ((c = *line++)) {

    w = 0;
    while (*c) {

      if (*c++ != ' ') {
        map->count++;
      }
      w++;
    }
    if (w > map->wd) {
      map->wd = w;
    }
    map->ht++;
  }
}


static void explode(point_t *rocket, int *used, point_t *points, map_t *map)
{
  int burn, count;
  point_t *particle;
  long pdx = 0, pdy = 0;
  char **line = NULL, *c = NULL;

  count = map->count;
  if (*used + count > POINTS) {
    return;
  }
  *used += count;

  pdx -= map->wd << (FIXBITS-3);
  pdy -= map->ht << (FIXBITS-3);
  line = map->map;
  c = *line++;

  burn = BURN + RND(BURN/2);

  while(--count >= 0) {

    particle = points++;
    particle->type = PARTICLE;
    particle->timer = burn;

    /* interpret image */
    for (;;) {
      if (!*c) {
#ifdef DEBUG
        if (!line) {
          win_exit();
fprintf(stderr, "intro.c/explode: wrong map particle count!\n");
          exit(-1);
        }
#endif
        pdx = -(map->wd << (FIXBITS-3));
        pdy += 1<<(FIXBITS-2);
        c = *line++;
        continue;
      }
      pdx += 1<<(FIXBITS-2);
      if (*c++ == ' ') {
        continue;
      }
      break;
    }

    particle->dx = rocket->dx + pdx;
    particle->dy = rocket->dy + pdy;
    particle->x = rocket->x + 2*pdx;
    particle->y = rocket->y + 2*pdy;
  }
}


static void shoot_rocket(point_t *point)
{
  int xsize = Screen->wd - (2*BORDER);
  int ysize = Screen->ht - BORDER;
  int value = RND(ysize>>1);

  point->type = ROCKET;

  point->x = (RND(xsize) + BORDER) << FIXBITS;
  point->y = ysize << FIXBITS;

  point->dx = ((xsize<<FIXBITS)>>9) - RND(xsize>>1) + (xsize>>2);
  if ((point->x >> (FIXBITS-1)) > xsize+BORDER) {
    point->dx = -point->dx;
  }
  point->dy = value - (ysize>>2) - ((ysize<<FIXBITS)>>7);

  point->timer = ((ysize>>1) + value) >> 1;
}


/* similar to do_shot() */
static int pyro(map_t *fig, m_rgb_t *rgb, void (*on_top)(void))
{
  /* particle image */
  static m_uchar _data[] = {
    0x00,0x00,0xff,0x00,0x00,
    0x00,0xff,0xff,0xff,0x00,
    0xff,0xff,0xff,0xff,0xff,
    0x00,0xff,0xff,0xff,0x00,
    0x00,0x00,0xff,0x00,0x00
  };
  static m_image_t bm = {
    _data, NULL, 5, 5, 0
  };
  static point_t *points;
  /* 'used' is index to first free point */
  int grav, key, idx, oldx, oldy, used = 0, timer = 1;
  point_t tmp, *current;
  m_uchar *map;

  if (!points) {
    if (!(points = malloc(POINTS*sizeof(point_t)))) {
      msg_print(ERR_ALLOC);
      return 0;
    }
    map_colors(&bm);
  }
  init_image(fig);

  grav = Screen->ht * 3 >> FIXBITS;
  map = map_get();

  /* pyro bm values are always mapped to last color index
   */

  if (Makemono) {
    rgb->r = 0xff;
    rgb->g = 0xff;
    rgb->b = 0xff;
    win_changecolor(CycleColor, rgb);
  } else {
    win_changecolor(CycleColor, rgb);
  }

  /* clear key buffer */
  while (win_getkey(0));

  for (;;) {

    frame_start(TimeFrame);

    /* clear / move rockets */
    for (idx = 0; idx < used; idx++) {

      current = &points[idx];
      oldx = current->x >> FIXBITS;
      oldy = current->y >> FIXBITS;

      current->x += current->dx;
      current->y += current->dy;

      /* timer / gravity */
      current->timer -= 1;
      current->dy += grav;

      if ((current->x >> FIXBITS) != oldx ||
          (current->y >> FIXBITS) != oldy ||
          !current->timer) {

        img_clear(&bm, oldx, oldy);

        if (current->timer) {
          continue;
        }
        /* timer expired, remove */

        /* move latest to current */
        tmp = *current;
        *current = points[--used];
        idx--;
        
        if (tmp.type & ROCKET) {
          /* create new points */
          explode(&tmp, &used, &points[used], fig);
        }
        continue;
      }
    }

    /* shoot new rocket? */
    if (!--timer) {
      timer = RND(NEXT) + NEXT/2;
      if (used < POINTS) {
        shoot_rocket(&points[used]);
        used++;
      }
    }

    /* draw rockets */
    current = &points[used];
    while (--current >= points) {

      oldx = current->x >> FIXBITS;
      oldy = current->y >> FIXBITS;
      img_copy(&bm, oldx, oldy);
    }

    if (on_top) {
      /* draw other stuff on top */
      on_top();
    }

    key = win_getkey(frame_end());
    if (key) {
      break;
    }
  }

  if (GAME_EXIT(key)) {
    return 0;
  }
  return 1;
}


static m_uchar *line1, *line2;
static int x1, y1, x2, y2;

static void draw_start(void)
{
  font_print(line1, x1, y1);
  font_print(line2, x2, y2);

}

int do_intro(void)
{
  static char *M[] = {
    "mm    mm",
    " mm  mm",
    " m mm m",
    " m    m",
    "mmm  mmm",
    NULL
  };
  m_rgb_t color = { 0xff, 0x00, 0x00 };
  map_t figure = { M };

  /* set background image */
  img_cls();

  /* startup msg variables
   */
  line1 = msg_string(STR_ANYKEY);
  line2 = msg_string(STR_START);
  x1 = (Screen->wd - font_strlen(line1)) / 2;
  y1 = (Screen->ht - font_height() * 2) / 2;
  x2 = (Screen->wd - font_strlen(line2)) / 2;
  y2 = y1 + font_height();

  return pyro(&figure, &color, draw_start);
}

int do_gameover(void)
{
  static char *game_over[] = {
    " mm   mm  m  m mmmm   mm  m  m mmmm mmm",
    "m    m  m mmmm m     m  m m  m m    m  m",
    "m mm mmmm m  m mmm   m  m m  m mmm  mmm",
    "m  m m  m m  m m     m  m m m  m    m m",
    " mm  m  m m  m mmmm   mm   m   mmmm m  m",
    NULL
  };
  m_rgb_t color = { 0x40, 0x00, 0xf0 };
  map_t figure = { game_over };

  return pyro(&figure, &color, NULL);
}

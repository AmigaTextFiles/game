/* 
 * MORTAR
 * 
 * -- shooting related functions
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * NOTES
 * - x and y positions are for middle of the shot image.
 * - all explosions touching some player are counted as hits.
 * - if player interrupts shot flying with the SELECT key, it will finish
 *   it's flight on next round.
 */

#include <stdio.h>
#include <stdlib.h>
#include "mortar.h"


typedef struct {
  int x, y, r;
  int timer;
  int power;
  int mask;
} m_boom_t;     /* shot explosion */

static int TimeOut, Booms;
static m_boom_t *Boom;


static int Shots;
static m_shot_t *Shot;

static int wd, ht, wd2, ht2;
static m_image_t *Bitmap;

static int Wind, MaxWind;


int shot_init(m_image_t *bm)
{
  int h, w, count;
  m_uchar *data;

  Shot = malloc(MAX_SHOTS * sizeof(m_shot_t));
  if (!Shot) {
    msg_print(ERR_ALLOC);
    return 0;
  }

  Boom = malloc(MAX_SHOTS * sizeof(m_boom_t));
  if (!Boom) {
    msg_print(ERR_ALLOC);
    return 0;
  }

  MaxWind = get_value("max_wind");
  TimeOut = color_cyclecount();

  wd = bm->wd;
  ht = bm->ht;
  wd2 = wd >> 1;
  ht2 = ht >> 1;
  Bitmap = bm;

  /* count pixels in shot */
  data = bm->data;
  count = 0;
  h = ht;
  while (--h >= 0) {
    w = wd;
    while (--w >= 0) {
      if (*data++) {
        count++;
      }
    }
  }

  if (!(ammo_init(ht, count) && shield_init() && util_init())) {
    return 0;
  }

  return 1;
}

int shot_radius(void)
{
  return wd2 > ht2 ? wd2 : ht2;
}


void shot_reset(void)
{
  Shots = Booms = 0;
}

m_shot_t *shot_spawn(m_shot_t *shot)
{
  m_shot_t *ptr;
#ifdef DEBUG
  if (Shots < 0 || Shots >= MAX_SHOTS) {
    win_exit();
    fprintf(stderr, "shot.c:shot_spawn(): no shots available!\n");
    exit(-1);
  }
#endif
  ptr = &Shot[Shots++];

  if (shot) {
    *ptr = *shot;
  }
  ptr->z = 0;

  return ptr;
}


/* create explosion */
void shot_explosion(int x, int y, int r, int power, int mask)
{
  m_boom_t *boom;
#ifdef DEBUG
  if (Booms < 0 || Booms >= MAX_SHOTS) {
    win_exit();
    fprintf(stderr, "shot.c:shot_explosion(): too many explosions!\n");
    exit(-1);
  }
#endif
  boom = &Boom[Booms++];

  boom->x = x;
  boom->y = y;
  boom->r = r;
  boom->timer = 0;
  boom->power = power;
  boom->mask = mask;
}

static int clear_explosions(void)
{
  static long counter;
  int x, y, r, gray;
  m_boom_t *boom;
  
  if (!Booms) {
    /* no need to cycle */
    return 0;
  }
  counter = color_cycle(CycleColor, counter);

  gray = color_gray();

  boom = Boom + Booms;
  while (--boom >= Boom) {

    x = boom->x;
    y = boom->y;
    r = boom->r;

    if (--boom->timer > 0) {

      /* for systems where palette is emulated,
       * we have to tell which part of screen
       * has changed (colors).
       */
      screen_dirty(boom->x - r, boom->y - r, 2*r, 2*r);
    } else {

      if (boom->mask == HIT_BG) {
        /* remove explosion */
        img_nocircle(x, y, r);
      } else {
        /* cast explosion in stone */
        img_circle(x, y, r, gray, boom->mask);
      }
      *boom = Boom[--Booms];
    }
  }
  return 1;
}

/* draw and manage explosions */
static int draw_explosions(void)
{
  int hits, idx, kaboom;
  m_boom_t *boom;
  m_hit_t *hit;

  /* note: game_hit() may create more explosions
   */
  kaboom = idx = hits = 0;
  while (idx < Booms) {

    boom = &Boom[idx++];

    /* already drawn? */
    if (boom->timer) {
      continue;
    }
    boom->timer = TimeOut;

    /* draw and change mask */
    hit = img_circle(boom->x, boom->y, boom->r,
        CycleColor, boom->mask);

    /* make damage */
    for(; hit->type != NO_HIT; hit++) {
#ifdef DEBUG
      if (hit->type == HIT_OUT) {
        fprintf(stderr, "shot.c/draw_explosion(): explosion out of screen!\n");
      }
#endif
      if (hit->type >= HIT_PLAYER) {
        game_hit(hit, NULL, boom->power);
        hits++;
      }
    }
    /* regular explosion? */
    if (boom->mask == HIT_BG) {
      kaboom = 1;
    }
  }
  if (kaboom) {
    snd_play(SND_BOOM);
  }
  return hits;
}

int shot_wind(int *max)
{
  int change;

  change = (MaxWind >> 3) | 1;
  Wind += RND(change) - (change >> 1);

  if (Wind > MaxWind) {
    Wind = MaxWind;
  } else {
    if (-Wind > MaxWind) {
      Wind = -MaxWind;
    }
  }
  if (max) {
    *max = MaxWind;
  }
  return Wind;
}


/* position for shot *image* */
static inline int shot_x(m_shot_t *shot)
{ return (shot->x >> FIXBITS) - wd2;
}
static inline int shot_y(m_shot_t *shot)
{ return (shot->y >> FIXBITS) - ht2;
}

static int shot_hit(m_shot_t *shot, struct m_ammo_t *type, m_hit_t *hit)
{
  int mask, boom;

  if (hit->type == HIT_OUT) {
    /* out of screen */
    return 1;
  }

  /* handle hits */
  boom = 0;
  mask = HIT_BG;
  while (hit->type != NO_HIT) {

    /* explosion takes predecence over shield checks done in
     * game_hit() because otherwise shields work too
     * efficiently.
     */
    if (hit->type >= HIT_PLAYER) {

      boom |= game_hit(hit, shot, type->damage);
    } else {

      if (hit->type != type->ok) {

        if (type->hit) {
          /* mask tells whether explosion
           * clears or stones...
           */
          mask = (*type->hit)(shot, hit);
        }
        /* ...or whether it's just a regular
         * explosion.
         */
        if (mask != NO_HIT) {
          boom = 1;
          break;
        }
      }
    }
    hit++;
  }

  /* explode shot? */
  if (boom) {
    shot_explosion( shot->x >> FIXBITS,
        shot->y >> FIXBITS,
        type->radius,
        type->damage,
        mask);
    return 1;
  }
  return 0;
}


/* returns number of 'hits' */
int do_shot(void)
{
  int key, shown, drops, idx, hits, wind;
  struct m_ammo_t *type;
  m_shot_t *shot;
  m_hit_t *hit;
  m_pos_t *pos;
  long time;

  wind = shot_wind(NULL);

  frame_start(TimeFrame);

  key = shown = hits = 0;
  do {

    /* Move and draw shots to screen while checking whether they
     * hit something.  Called functions may create new shots so
     * while() has to check for shot count.
     */
    idx = 0;
    while(idx < Shots) {

      shot = &Shot[idx];
      type = shot->type;

      /* flight path modifications / events */
      if (type->fly) {
        if ((*type->fly)(shot)) {
          /* explode in flight */
          shot_explosion( shot->x >> FIXBITS,
              shot->y >> FIXBITS,
              type->radius,
              type->damage,
              HIT_BG);
          *shot = Shot[--Shots];
          continue;
        }
      }

      /* flight modifications by shields */
      pos = do_shields(shot_x(shot), shot_y(shot));
      shot->dx += pos->x;
      shot->dy += pos->y;

      /* new place */
      shot->x += shot->dx + wind;
      shot->y += shot->dy;

      /* gravity */
      shot->dy += type->weight;

      /* draw */
      hit = img_copy(Bitmap, shot_x(shot), shot_y(shot));

      if (shot_hit(shot, type, hit)) {
        *shot = Shot[--Shots];
      } else {
        shown++;
        idx++;
      }
    }

    /* lower dropping players */
    drops = game_drop();

    hits += draw_explosions();

    if (shown || drops) {
      /* wait until next frame only if there are either
       * shot(s), explosion(s) or dropping player(s) shown
       * on screen.
       */
      time = frame_end();
    } else {
      time = 0;
    }
    /* init next frame */
    frame_start(TimeFrame);

    /* flush graphics and check input */
    key = win_getkey(time);

    shown = clear_explosions();

    /* clear shots from screen
     */
    shot = Shot + Shots;
    while (--shot >= Shot) {
      img_clear(Bitmap, shot_x(shot), shot_y(shot));
    }
  } while ((drops || Shots || Booms) && key != KEY_SELECT);

  win_getkey(0);
  return hits;
}


/* for using shot as the shop list 'pointer' */
void shot_drawme(m_shot_t *shot)
{
  img_copy(Bitmap, shot_x(shot), shot_y(shot));
}
void shot_clearme(m_shot_t *shot)
{
  img_clear(Bitmap, shot_x(shot), shot_y(shot));
}

/* for using shot as the shop list 'pointer' */
void shot_draw(int x, int y)
{
  img_copy(Bitmap, x - wd2, y - ht2);
}
void shot_clear(int x, int y)
{
  img_clear(Bitmap, x - wd2, y - ht2);
}

/* 
 * MORTAR
 * 
 * -- tank / cannon related functions
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * NOTES
 * - Player x,y position is for middle of the player image.
 *
 * TODO
 * - Add cursor for more accurate cannon heading setting.
 */

#include <stdlib.h>
#include "mortar.h"

static m_image_t *Tank, *Hilite;
static int Offset, Frames, wd, ht, wd2, ht2, *Pixels;

#define FRAME(angle)  (Frames * (angle + Offset) / 180)


/* calculate how many set pixels each frame has */
static void count_pixels(m_uchar *data, int *pixels, int wd, int ht, int frames)
{
  int w, h, count;

  while (--frames >= 0) {
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
    *pixels++ = count;
  } 
}


int tank_init(m_image_t *bm, m_image_t *hi)
{
  Frames = get_value("frames");
  if (!Frames) {
    msg_print(ERR_VARS);
    return 0;
  }

  Pixels = malloc(sizeof(*Pixels) * Frames);
  if (!Pixels) {
    msg_print(ERR_ALLOC);
    return 0;
  }

  wd  = bm->wd;
  wd2 = wd >> 1;
  ht  = bm->ht / Frames;
  ht2 = ht >> 1;

  Offset = 90 / --Frames;
  Hilite = hi;
  Tank = bm;

  count_pixels(bm->data, Pixels, wd, ht, Frames + 1);

  range_straights(wd);
  return 1;
}

int tank_height(void)
{
  return ht;
}

int tank_size(void)
{
  return wd > ht ? wd : ht;
}

int tank_pixels(m_player_t *p)
{
  /* how many pixels current tank frame has
   */
  return Pixels[FRAME(p->angle)];
}


/* position tanks onto range/screen
 */
void tank_positions(int players, m_player_t *player)
{
  int x, dist, diff, idx, pl, quarter;

  quarter = (Screen->wd >> 1) / players;
  dist = (Screen->wd - quarter - wd) / (players-1);
  x = (wd + quarter) >> 1;

  diff = (quarter - wd) >> 1;
  if (diff <= 0) {
    diff = 1;
  }

  /* position players at slightly randomized intervals
   */
  idx = players;
  while (--idx >= 0) {
    player[idx].pos.x = x + RND(diff) - (diff >> 1);
    x += dist;
  }

  /* switch player positions randomly
   */
  idx = players;
  while (--idx >= 0) {
    pl = RND(players);
    x = player[idx].pos.x;
    player[idx].pos.x = player[pl].pos.x;
    player[pl].pos.x = x;
  }

  /* make range accommodate players
   */
  idx = players;
  while (--idx >= 0) {
    player[idx].pos.y = range_level(player[idx].pos.x) - ht2;
  }
}


/* called to change the angle of a highlighted tank
 */
int tank_angled(m_player_t *p, int angle)
{
  int x, y, old, now;

  if (angle < 0) {
    angle = 0;
  } else {
    if (angle > 180) {
      angle = 180;
    }
  }

  old = FRAME(p->angle);
  now = FRAME(angle);

  if (old != now) {
    x = p->pos.x - wd2;
    y = p->pos.y - ht2;

    img_clblit(Hilite, 0, old * ht, wd, ht, x, y);
    img_blit(Hilite, 0, now * ht, wd, ht, x, y);
  }
  p->angle = angle;

  return angle;
}


static inline m_hit_t *tank_draw(m_player_t *p, m_image_t *bm)
{
  int off, x, y;

  x = p->pos.x - wd2;
  y = p->pos.y - ht2;

  off = FRAME(p->angle);

  return img_blit(bm, 0, off * ht, wd, ht, x, y);
}

static inline void tank_clear(m_player_t *p, m_image_t *bm)
{
  int off, x, y;

  x = p->pos.x - wd2;
  y = p->pos.y - ht2;

  off = FRAME(p->angle);

  img_clblit(bm, 0, off * ht, wd, ht, x, y);
}

void tank_unhilite(m_player_t *player)
{
  tank_draw(player, Tank);
}

void tank_hilite(m_player_t *player)
{
  tank_draw(player, Hilite);
}


void tank_setmask(m_player_t *p, int idx)
{
  int off, x, y;

  x = p->pos.x - wd2;
  y = p->pos.y - ht2;

  off = FRAME(p->angle);

  img_setmask(Tank, 0, off * ht, wd, ht, x, y, idx);
}


m_pos_t *tank_checkdrop(m_player_t *p, int dx, int dy)
{
  static m_pos_t move;
  m_shot_t dummy;
  int hit, count;

  dummy.type = &Ammo[AMMO_BASIC];

  move.x = dx;
  move.y = dy;
  hit = img_drop(p->pos.x, p->pos.y + ht2, wd2-1, &p->speed, &move);

  switch(hit) {

  case HIT_BG:
    /* through the air */
    break;

  case HIT_GROUND:
    /* dropping? */
    if (p->dropping) {
      /* landed */
      if (!list_search(p->items, UTIL_PARACHUTE)) {
        game_damage(p, &dummy, p->dropping, tank_pixels(p));
      }
      p->dropping = 0;
    }
    return &move;

  case HIT_EDGE:
    /* bounced against ground */
    count = move.x;
    if (count < 0) {
      count = -count;
    }
    game_damage(p, &dummy, dummy.type->damage, count);
    break;

  default:
    /* dropped out of screen
     */
    game_suicide(p);
    return NULL;
  }

  if (!p->dropping) {
    p->dropping = 1;
    p->drop.x = p->pos.x << FIXBITS;
    p->drop.y = p->pos.y << FIXBITS;
    p->speed.x = 0;
    p->speed.y = 0;
  }
  return &move;
}

void tank_drop(m_player_t *p, int idx)
{
  m_pos_t *move;
  m_hit_t *hit;
  int dx, dy;

  dx = (p->drop.x >> FIXBITS) - p->pos.x;
  dy = (p->drop.y >> FIXBITS) - p->pos.y;

  if (dx || dy) {
    move = tank_checkdrop(p, dx, dy);

    if (move && (move->x || move->y)) {

      tank_setmask(p, HIT_BG);
      tank_clear(p, Tank);

      p->pos.x += move->x;
      p->pos.y += move->y;

      hit = tank_draw(p, Tank);
      while(hit->type != NO_HIT) {

        if (hit->type >= HIT_PLAYER) {
          /* chrashed to another player */
          game_suicide(p);
          return;
        }
        hit++;
      }
      tank_setmask(p, idx);

      p->drop.x += (move->x - dx) << FIXBITS;
      p->drop.y += (move->y - dy) << FIXBITS;
    }
  }

  if (p->speed.x) {
    p->drop.x += p->speed.x;
    if (p->speed.x < 0) {
      p->speed.x++;
    } else {
      p->speed.x--;
    }
  }
  p->drop.y += p->speed.y;
  /* use same gravity for tank as for (hevier) shots */
  p->speed.y += ammo_gravity();
}


void tank_shoot(m_player_t *p, int type)
{
  m_shot_t *shot;
  float sin, cos;
  int r;

  cos =  qcos(p->angle);
  sin = -qsin(p->angle);
  r = (wd2 > ht2 ? wd2 : ht2) + shot_radius() + 1;

  shot = shot_spawn(NULL);

  shot->x = (p->pos.x + cos * r) * (1 << FIXBITS);
  shot->y = (p->pos.y + sin * r) * (1 << FIXBITS);

  shot->dx = p->power * cos * 2;
  shot->dy = p->power * sin * 2;

  shot->type = &Ammo[type];
}

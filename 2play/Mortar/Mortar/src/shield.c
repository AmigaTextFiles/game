/* 
 * MORTAR
 * 
 * -- shield implementations
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * NOTES
 * - If you modify shot x and y co-ordinates, you need to call
 *   shot_clearme() before and shot_drawme() afterwards.
 * - There's only one shield active / player at the time.
 */

#include <stdio.h>
#include <stdlib.h>
#include "mortar.h"


/* -------- shot flight shield-effects ----------- */

static void repulse(m_pos_t *pos, int x, int y, m_pos_t *speed)
{
  m_uchar table[] = { 0, 1, 3, 6 };
  unsigned long dist;

  x -= pos->x;
  y -= pos->y;
  dist = (long)x*x + (long)y*y;

  x = 0;
  while ((dist >>= 3)) {
    x++;
  }
  /* effect extent: ~50 pixels */
  if (x < sizeof(table)) {
    speed->y -= (1 << 9) >> table[x];
  }
}


/* ----------- shot hit shield-effects ----------- */

static int damp1(m_shot_t *shot, int *damage)
{
  *damage >>= 1;
  snd_play(SND_DAMP);
  return 1;
}
static int damp2(m_shot_t *shot, int *damage)
{
  *damage >>= 2;
  snd_play(SND_DAMP);
  return 1;
}
static int damp3(m_shot_t *shot, int *damage)
{
  *damage >>= 3;
  snd_play(SND_DAMP);
  return 1;
}

static int pass(m_shot_t *shot, int *damage)
{
  *damage = 0;
  return 0;
}

static int bounce(m_shot_t *shot, int *damage)
{
  /* decrease momentum 1/4 */
  shot->dx -= shot->dx >> 2;
  shot->dy -= shot->dy >> 2;

  shot_clearme(shot);
  shot->x -= shot->dx >> 1;
  shot->y -= shot->dy >> 1;
  shot_drawme(shot);

  if (shot->dy >= 0) {
    shot->dy = -shot->dy;
  } else {
    shot->dx = -shot->dx;
  }

  *damage = 1;
  snd_play(SND_PING);
  return 0;
}

static int teleport(m_shot_t *shot, int *damage)
{
  int x, y;

  y = (shot->y >> FIXBITS) + 1;
  x = shot->x >> FIXBITS;

  /* not out of screen */
  if (x+x > Screen->wd) {
    x = Screen->wd - x;
  }
  /* at leat 1 for RND() */
  x = (x >> 1) + 1;

  shot_clearme(shot);
  /* move somewhere above the hit point */
  shot->x += (RND(x) - (x>>1)) << FIXBITS;
  shot->y -= (RND(y) + 1) << FIXBITS;
  shot_drawme(shot);

  /* not so fast... */
  shot->dy >>= 1;

  *damage = 1;
  snd_play(SND_WHOOSH);
  return 0;
}

static int payback(m_shot_t *shot, int *damage)
{
  shot->dx = RND(3)-1 - shot->dx;
  shot->dy = RND(3)-1 - shot->dy;

  shot_clearme(shot);
  shot->x += shot->dx >> 1;
  shot->y += shot->dy >> 1;
  shot_drawme(shot);

  *damage = 1;
  snd_play(SND_PING);
  return 0;
}


typedef struct {
  char *name;
  void (*fly)(m_pos_t *pos, int x, int y, m_pos_t *speed);
  int (*hit)(m_shot_t *shot, int *damage);
  int strength;
  int price;
  int all;  /* handles both shots and explosions */
} m_shield_t;


static m_shield_t shield_array[SHIELD_TYPES+1-SHIELD_FIRST] = {

  /* name, shot flight-h, hit-h, strength, price, all */
  { NULL, repulse, NULL,     1, 1, 0 }, /* repulse */
  { NULL, NULL,    damp1,    1, 1, 1 }, /* damp-1 */
  { NULL, NULL,    damp2,    1, 2, 1 }, /* damp-2 */
  { NULL, NULL,    damp3,    1, 4, 1 }, /* damp-3 */
  { NULL, NULL,    pass,     1, 1, 0 }, /* unsolidifier */
  { NULL, NULL,    teleport, 1, 2, 0 }, /* teleport */
  { NULL, NULL,    bounce,   1, 2, 0 }, /* bounce */
  { NULL, NULL,    payback,  1, 4, 0 }, /* pay-back */
  { NULL, NULL,    NULL,     0, 0, 0 }  /* dummy */
};


int shield_init(void)
{
  int price, idx, x;
  m_shield_t *ptr;

  x = get_value("shield");
  if (!x) {
    msg_print(ERR_VARS);
    return 0;
  }

  price = get_value("shield_price");

  ptr = &shield_array[SHIELD_TYPES-SHIELD_FIRST];
  idx = SHIELD_TYPES;
  while (--idx >= SHIELD_FIRST) {
    (--ptr)->name = msg_string(idx);
    ptr->price *= price;
    ptr->strength *= x;
  }
  return 1;
}

/* --------- shield list handling ----------- */

typedef struct {
  m_player_t *player; /* points to player owning the shield */
  m_shield_t *shield;
} m_shlist_t;

static int Shields;
/* active shields: only one shield / player can be used at the time */
static m_shlist_t Shield[MAX_PLAYERS];


void shield_reset(void)
{
  Shields = 0;
}

m_uchar *shield_name(int type)
{
  return shield_array[type-SHIELD_FIRST].name;
}

int shield_price(int type)
{
  return shield_array[type-SHIELD_FIRST].price;
}

static m_shlist_t *shield_find(m_player_t *p)
{
  m_shlist_t *ptr;
  int idx;

  idx = Shields;
  ptr = &Shield[Shields];
  while (--idx >= 0) {
    --ptr;
    if (ptr->player == p) {
      return ptr;
    }
  }
#ifdef DEBUG
  /* shields should always be found */
  win_exit();
  fprintf(stderr, "shield.c/shield_found(): player shield not found!\n");
  exit(-1);
#endif
  return 0;
}

void shield_remove(m_player_t *p)
{
  /* find player's shield in the Shields stack, replace it with the
   * one on top ('Stacks' points to first free shield position) and
   * remove top shield.
   */
  m_shlist_t *sh = shield_find(p);
  *sh = Shield[--Shields];
  p->shield = 0;
}

void shield_add(m_player_t *p, int type)
{
  m_shlist_t *ptr;

#ifdef DEBUG
  if (!IS_SHIELD(type)) {
    win_exit();
    fprintf(stderr, "shield.c/shield_add(): type out of range!\n");
    exit(-1);
  }
  if (Shields >= MAX_PLAYERS) {
    fprintf(stderr, "shield.c/shield_add(): Shield > MAX_PLAYERS!\n");
    return;
  }
#endif
  ptr = &Shield[Shields++];
  ptr->player = p;

  ptr->shield = &shield_array[type-SHIELD_FIRST];
  p->shield = ptr->shield->strength;
  p->shield_type = type;
}

/* returns true for explosion & modifies damage */
int shield_hit(m_player_t *p, m_shot_t *shot, int *damage)
{
  m_shield_t *ptr;

  ptr = &shield_array[p->shield_type-SHIELD_FIRST];

  /* a contact shield? */
  if (ptr->hit) {
    if (shot || ptr->all) {
      return (*ptr->hit)(shot, damage);
    }
  }
  return 1;
}

m_pos_t *do_shields(int x, int y)
{
  static m_pos_t dd;
  m_shlist_t *ptr;
  int idx;

  dd.x = dd.y = 0;

  idx = Shields;
  ptr = &Shield[Shields];
  while (--idx >= 0) {
    --ptr;
    /* shield doesn't affect own shots' flying */
    if (ptr->shield->fly && !ptr->player->current) {
      (*ptr->shield->fly)(&(ptr->player->pos), x, y, &dd);
    }
  }
  return &dd;
}

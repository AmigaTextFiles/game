/* 
 * MORTAR
 * 
 * -- tank utilities
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * NOTES
 * - Utility 'use' callback returns true if utility is manually usable.
 *   It also signifies that user can't shoot on the same round.
 */

#include <stdio.h>
#include <stdlib.h>
#include "mortar.h"


static int parachute(m_player_t *p)
{
  /* used only/automatically when shot drops player */
  return 0;
}

static int powerup(m_player_t *p)
{
  /* add 20% of the full power */
  p->energy += game_energy(20);
  snd_play(SND_BUY);
  return 1;
}

static int suicide(m_player_t *p)
{
  p->angle = 90;
  tank_shoot(p, AMMO_SURPRISE);
  game_suicide(p);
  return 1;
}


typedef struct {
  m_uchar *name;
  int (*use)(m_player_t *player);
  int price;
} m_util_t;

static m_util_t util_array[UTIL_TYPES-UTIL_FIRST] = {
  { NULL, parachute, 200 },
  { NULL, powerup,   50 },
  { NULL, suicide,   50 }
};


int util_init(void)
{
  m_util_t *ptr;
  int idx;

  ptr = &util_array[UTIL_TYPES-UTIL_FIRST];
  idx = UTIL_TYPES;
  while (--idx >= UTIL_FIRST) {
    (--ptr)->name = msg_string(idx);
  }
  return 1;
}

int util_price(int type)
{
  return util_array[type-UTIL_FIRST].price;
}

m_uchar *util_name(int type)
{
  return util_array[type-UTIL_FIRST].name;
}

int util_do(m_player_t *player, int type)
{
  return (*util_array[type-UTIL_FIRST].use)(player);
}

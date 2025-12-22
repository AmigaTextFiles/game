/* 
 * MORTAR
 * 
 * -- game loop, player handling
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * NOTES
 * - wins/shots/hits/lost persist through everything, money is reset
 *   everytime new game begins and rest are reset at every round start.
 * - lost counts both how many times and how much player lost for the
 *   winner.  Players are sorted by most wins, least losts, most money left.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mortar.h"

static m_player_t *Player, *Current;
static int Maxlen, Players, Alive;

/* configuration variables */
static int Reverse, Energy, Money;

/* bonus variables */
static int KillBonus, HitBonus, MinBonus, AddBonus, Bonus;


#define COLORS  6


int game_init(int count, char *name[])
{
  /* player colors */
  static m_rgb_t colors[COLORS] = {
    { 0x00, 0x00, 0xff },
    { 0x00, 0xff, 0x00 },
    { 0xff, 0x00, 0x00 },
    { 0xff, 0x00, 0xff },
    { 0x00, 0xff, 0xff },
    { 0xff, 0xff, 0x00 }
  };
  int bonus, len;
  m_player_t *p;

  if (!list_init()) {
    return 0;
  }

  Player = calloc(1, sizeof(m_player_t) * count);
  if (!Player) {
    msg_print(ERR_ALLOC);
    return 0;
  }

  p = Player;
  while (--count >= 0) {

    /* p->lost = p->wins = p->shots = p->hits = 0; */

    p->color = &colors[Players++ % COLORS];
    p->name = *name;
    p++;

    len = strlen(*name++);
    if (len > Maxlen) {
      Maxlen = len;
    }
  }

  /* Game variables */
  Reverse = get_value("reverse");
  Energy  = get_value("energy");

  if (!Energy) {
    msg_print(ERR_VARS);
    return 0;
  }

  /* money matters? */
  Money     = get_value("money");
  bonus     = get_value("winner_bonus");
  KillBonus = get_value("kill_bonus");
  HitBonus  = get_value("hit_bonus");

  AddBonus  = bonus / Players;
  MinBonus  = bonus - AddBonus * Players;

  return 1;
}


static int ascending(const void *c, const void *d)
{
  const m_player_t *a = c, *b = d;

  if (a->wins > b->wins)    return 1;
  if (a->wins < b->wins)    return -1;

  if (a->lost < b->lost)    return 1;
  if (a->lost > b->lost)    return -1;

  if (a->money > b->money)  return 1;
  if (a->money < b->money)  return -1;

  return 0;
}

static int descending(const void *c, const void *d)
{
  const m_player_t *a = c, *b = d;

  if (a->wins > b->wins)    return -1;
  if (a->wins < b->wins)    return 1;

  if (a->lost < b->lost)    return -1;
  if (a->lost > b->lost)    return 1;

  if (a->money > b->money)  return -1;
  if (a->money < b->money)  return 1;

  return 0;
}


void game_reset(void)
{
  m_player_t *p;
  int idx;

  p = Player;
  idx = Players;
  while (--idx >= 0) {

    p->money = Money;
    p->angle = DEF_ANGLE;
    p->items = list_add(NULL, AMMO_BASIC);
    p->items->count = DEF_SHOTS;
    p++;
  }
}

int game_energy(int percentage)
{
  return Energy * percentage / 100;
}

static void round_init(void)
{
  m_player_t *p;
  int idx;

  Bonus = MinBonus;

  /* needs to be done after 'Screen' is initialized, but before
   * user_power() is called.
   */
  user_init();

  idx = Players;
  p = Player + idx;
  while (--idx >= 0) {
    --p;
    p->alive = 1;
    p->current = 0;
    p->dropping = 0;

    p->shield = 0;
    p->energy = Energy;
    p->power = user_power(DEF_POWER);

    tank_unhilite(p);
    tank_setmask(p, HIT_PLAYER + idx);
  }
}


void game_suicide(m_player_t *p)
{
  /* just in case... */
  if (p->shield) {
    shield_remove(p);
  }

  /* The later you die, the better bonus you got
  */
  Bonus += AddBonus;
  p->money += Bonus;
  p->lost += --Alive;
  p->alive = p->power = 0;
  shot_explosion(p->pos.x, p->pos.y, tank_size(), ammo_damage(), HIT_BG);

  snd_play(SND_DIE);
  snd_sync();
}

/* args:  hit player, shot type (if shot, not explosion) and power
 * returns: true if hit should behave (explode) as normal
 */
int game_damage(m_player_t *p, m_shot_t *shot, int damage, int count)
{
  int bonus, harm, explosion;

  /* hit damage is according to shot damage and how much of the tank
   * explosion covers
   */
  harm = (long)damage * count / tank_pixels(p);
  if (!harm) {
    /* every hit counts... */
    harm = 1;
  }

  if (p->shield) {
    explosion = shield_hit(p, shot, &harm);
    p->shield -= harm;
    if (p->shield <= 0) {
      p->energy += p->shield;
      shield_remove(p);
    }
  } else {
    explosion = 1;
    p->energy -= harm;
  }

  if (p->energy <= 0) {
    game_suicide(p);
    bonus = KillBonus;
  } else {
    if (!shot || !explosion) {
      /* won't be called again, so need to redraw tank now
       */
      tank_unhilite(p);
      if (!shot) {
        /* explosion cleared a lot, redraw mask */
        tank_setmask(p, HIT_PLAYER + (p-Player) / sizeof(m_player_t));

        /* if 'on the air', start dropping... */
        tank_checkdrop(p, 0, 1);
      }
    }
    bonus = HitBonus;
  }

  if (p->current) {
    /* clumsiness is a punishable offence
     */
    if (bonus > p->money) {
      bonus = -p->money;
    } else {
      bonus = -bonus;
    }
  }
  Current->money += bonus;
  return explosion;
}

int game_hit(m_hit_t *hit, m_shot_t *shot, int damage)
{
  m_player_t *p;
  int idx;

  idx = hit->type - HIT_PLAYER;
#ifdef DEBUG
  if (idx < 0 || idx >= Players) {
    win_exit();
    fprintf(stderr, "game.c/game_hit(): illegal player index!\n");
    exit(-1);
  }
#endif

  p = &Player[idx];
  if (!p->alive) {
    /* suicided or being grilled I guess... */
    return 0;
  }
  if (shot) {
    /* we don't use hit damage (count), a shot 'touch' is enough */
    return game_damage(p, shot, damage, 1);
  }
  return game_damage(p, shot, damage, hit->count);
}


int game_drop(void)
{
  int idx, dropping;
  m_player_t *p;

  p = Player + Players;
  idx = Players;
  dropping = 0;

  while (--idx >= 0) {
    --p;

    /* do tank dropping */
    if (p->alive && p->dropping) {
      tank_drop(p, HIT_PLAYER + idx);
      dropping++;
    }
  }
  return dropping;
}

static void round_end(void)
{
  m_player_t *p;
  int idx;

  Bonus += AddBonus;

  p = Player;
  idx = Players;
  while (--idx >= 0) {

    /* get the winner */
    if (p->alive) {
      p->money += Bonus;
      p->wins++;
      break;
    }
    p++;
  }
}

int do_game(void)
{
  int (*sort)(const void *, const void *);
  m_player_t *p;
  int idx;

  /* sort players into playing order
   */
  if (Reverse) {
    sort = descending;
  } else {
    sort = ascending;
  }
  qsort(Player, Players, sizeof(m_player_t), sort);

  if (!range_create(Screen->wd, Screen->ht)) {
    return 0;
  }
  tank_positions(Players, Player);
  shield_reset();
  shot_reset();

  song_play(SONG_MENU, 0);

  idx = Players;
  p = Player + idx;
  while (--idx >= 0) {
    --p;
    color_set(p->color);
    if (!user_shopping(p)) {
      /* interrupt */
      return 0;
    }
  }

  img_ground();
  round_init();

  song_play(SONG_BATTLE, 0);

  /* repeat until only one player (or none) remains
   */
  Alive = Players;
  while (Alive > 1) {

    idx = Players;
    p = Player + idx;
    while (--idx >= 0 && Alive > 1) {

      if ((--p)->alive) {

        color_set(p->color);
        tank_setmask(p, HIT_BG);
        tank_hilite(p);

        if (!user_input(p)) {
          return 0;
        }

        tank_unhilite(p);
        tank_setmask(p, HIT_PLAYER + idx);

        Current = p;
        p->current = 1;
        p->hits += do_shot();
        p->current = 0;
      }
    }
  }
  round_end();

  return 1;
}


/* sort players according to results and show the statistics on screen
 */
void game_results(void)
{
  int x, y, wd, ht, idx, rate;
  m_uchar *line;
  m_player_t *p;

  if (!(line = malloc(Maxlen+20))) {
#ifdef DEBUG
    fprintf(stderr, "game.c/game_results(): malloc(%d) failed!\n",
      Maxlen+20);
#endif
    return;
  }
  wd = font_width();
  ht = font_height();
  x = (Screen->wd - (Maxlen + 9) * wd) >> 1;
  y = (Screen->ht - (Players + 1) * ht) >> 1;

  qsort(Player, Players, sizeof(m_player_t), descending);

  sprintf(line, "%*s  %s%%",
    Maxlen + 4, msg_string(STR_WINS),
    msg_string(STR_HITS));

  img_cls();
  font_print(line, x, y);
  y += ht;

  p = Player;
  idx = Players;
  while (--idx >= 0) {

    if (p->shots) {
      /* shot can hit several players so it's
       * possible hit-% is over 100. :-)
       */
      rate = p->hits * 100 / p->shots;
    } else {
      rate = 0;
    }
    sprintf(line, "%*s %3d  %3d%%", -Maxlen,
      p->name, p->wins, rate);

    font_print(line, x, y);
    y += ht;
    p++;
  }

  /* clear key buffer */
  while (win_getkey(0));

  /* wait a key (in 1sec time blocks) */
  for (;;) {
    if (win_getkey(1000L)) {
      break;
    }
  }

  free(line);
}

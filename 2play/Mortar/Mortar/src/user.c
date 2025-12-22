/* 
 * MORTAR
 * 
 * -- user input
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * NOTES
 * - Added a couple of win_sync()s to speed up dirty rectangle refresh
 *   on really slow machines.
 *
 * TODO
 * - Change user_input() to work like Worms GUI does:  Direction is
 *   indicated by a cursor rotating around cannon, item is selected from a
 *   popup toolbar and wind / power are indicated by relative color bars.
 * - Optionally get/send values from/to a Mortar server over network.
 *   Server will just broadcast it's input to all other clients.
 */

#include <stdio.h>
#include <string.h>
#include "mortar.h"


int PowerMax, PowerInc, Discount;


int user_power(int percentage)
{
  return ((Screen->wd + Screen->ht) * percentage / 200) & ~PowerInc;
}

void user_init(void)
{
  PowerInc = get_value("power_inc");
  PowerMax = user_power(100);
  if (!PowerInc) {
    PowerInc = 1;
  }
  Discount = get_value("discount");
}


static m_uchar *item_name(int type)
{
  if (IS_SHOT(type)) {
    return ammo_name(type);
  }
  if (IS_SHIELD(type)) {
    return shield_name(type);
  }
  if (IS_UTIL(type)) {
    return util_name(type);
  }
#ifdef DEBUG
  win_exit();
  fprintf(stderr, "user.c/item_name(): illegal item type!\n");
  exit(-1);
#endif
  return NULL;
}

static int item_price(int type)
{
  if (IS_SHOT(type)) {
    return ammo_price(type);
  }
  if (IS_SHIELD(type)) {
    return shield_price(type);
  }
  if (IS_UTIL(type)) {
    return util_price(type);
  }
#ifdef DEBUG
  win_exit();
  fprintf(stderr, "user.c/item_price(): illegal item type!\n");
  exit(-1);
#endif
  return 0;
}


static void string(m_uchar *buf, int value, int count)
{
  m_uchar sp = ' ';
  int digit, div;

  digit = 1;
  div = --count;
  while (--div >= 0) {
    digit *= 10;
  }

  while (--count >= 0) {
    div = value / digit;
    if (div) {
      *buf++ = '0' + (div % 10);
      sp = '0';
    } else {
      *buf++ = sp;
    }
    value %= digit;
    digit /= 10;
  }
  *buf++ = '0' + value % 10;
}


/* show user name and remaining energy */
static void user_show(char *name, int energy, int ht)
{
  int max, colors, idx, wd, x1, x2;
  m_uchar *val;

  val = color_range(&colors);

  wd = Screen->wd;
  max = wd * energy / game_energy(100);

  for (idx = 0; idx < colors; idx++) {

    x1 = wd * idx / colors;
    x2 = wd * (idx+1) / colors;
    if (x2 > max) {
      x2 = max - x2;
      idx = colors;
    }
    screen_box(x1, 0, x2 - x1, ht, val[idx]);
  }

  x1 = shot_wind(&x2);
  x1 = x1 * (wd>>2) / x2;
  if (x1 >= 0) {
    screen_box(0, 0, x1, ht, color_white());
  } else {
    screen_box(wd + x1, 0, -x1, ht, color_white());
  }
  font_print(name, (wd - font_strlen(name)) >> 1, 0);
  screen_dirty(0, 0, wd, ht);
}

#define POS_POWER 0
#define POS_ANGLE 4
#define POS_TYPE  9
#define MSG_LEN   (3+1+3+1+1+MAX_TYPELEN)


int user_input(m_player_t *p)
{
  int type, key, wd2, ht, power, angle;
  m_uchar msg[MSG_LEN+1];
  m_list_t *item;

  /* first lucky shot could end game with this...
   *int energy = p->energy;
   *if (p->power > energy) {
   *  p->power = energy;
   *}
  */
  power = p->power;
  angle = p->angle;

  ht = font_height();
  wd2 = font_width() >> 1;

  memset(msg, ' ', MSG_LEN);
  if (p->shield) {
    msg[POS_POWER+3] = 's'; /* shield on */
  } else {
    msg[POS_POWER+3] = '*'; /* shield off */
  }
  msg[POS_ANGLE+3] = 176;   /* ISO-latin1 degree */
  msg[MSG_LEN] = 0;

  user_show(p->name, p->energy, ht);

  /*  clear key buffer */
  while (win_getkey(0));

  /* get user input */
  item = p->items;
  for (;;) {

    /* show current values */

    string(&msg[POS_POWER], power, 3);
    string(&msg[POS_ANGLE], angle, 3);
    strcpy(&msg[POS_TYPE], item_name(item->type));
    font_print(msg, wd2, ht);

    /* get new ones */

    do {
      key = win_getkey(TimeInput);
    } while (!key);

    if (GAME_EXIT(key)) {

      img_bg(0, 2*ht);
      return 0;
    }

    switch (key) {

      case KEY_LEFT:
        angle = tank_angled(p, angle + 1);
        win_sync();
        break;

      case KEY_RIGHT:
        angle = tank_angled(p, angle - 1);
        win_sync();
        break;

      case KEY_UP:
        power += PowerInc;
        if (power > PowerMax) {
          power = PowerMax;
        }
        break;

      case KEY_DOWN:
        power -= PowerInc;
        if (power < 0) {
          power = 0;
        }
        break;

      case KEY_CENTER:
        item = p->items;
        break;

      case KEY_END:
        item = item->prev;
        break;

      case KEY_PGDOWN:
      case KEY_SELECT:
        item = item->next;
        break;

      /* accept values
       */
      case KEY_ACCEPT1:
      case KEY_ACCEPT2:

        p->power = power;
        type = item->type;

        if (IS_UTIL(type)) {
          /* use an utility? */
          if (!util_do(p, type)) {
            break;
          }
        }
        if (IS_SHIELD(type)) {
          /* can't have two shields */
          if (p->shield) {
            break;
          }
          /* activate shield */
          shield_add(p, type);
          snd_play(SND_SUCK);
        }
        if (IS_SHOT(type)) {
          /* tank_angle() already set the angle
           */
          tank_shoot(p, type);
          snd_play(SND_SHOOT);
          p->shots++;
        }

        p->items = list_free(item);
        img_bg(0, 2*ht);
        return 1;
    }

    font_clear(msg, wd2, ht);
  }
}


#define FIRST_POS 1 /* first line for item */
#define POS_POINT 1 /* column for marker */
#define POS_COUNT 2 /* column for item count */
#define LEN_COUNT 2 /* digits for item count */
#define POS_NAME  5 /* column for item name */
#define LEN_PRICE 4 /* digits for item price */
#define LEN_MONEY 5 /* digits for player money */


static void show_types(m_player_t *player, int y, int top, int lines,
           int wd, int ht)
{
  char msg[(LEN_PRICE > LEN_COUNT ? LEN_PRICE : LEN_COUNT) + 1];
  int count, name, price;
  m_list_t *item;

  img_bg(y, lines * ht);

  price = Screen->wd - (LEN_PRICE+1) * wd;
  count = POS_COUNT * wd;
  name  = POS_NAME * wd;

  if (top + lines > USER_TYPES) {
    lines = USER_TYPES - top;
  }
  while (--lines >= 0) {

    item = list_search(player->items, top);
    if (item) {
      string(msg, item->count, LEN_COUNT);
    } else {
      string(msg, 0, LEN_COUNT);
    }
    msg[LEN_COUNT] = 0;

    font_print(msg, count, y);
    font_print(item_name(top), name, y);

    string(msg, item_price(top), LEN_PRICE);
    msg[LEN_PRICE] = 0;
    font_print(msg, price, y);

    y += ht;
    top++;
  }
}

static void show_count(int old, int now, int y, int wd, int ht)
{
  char msg[LEN_COUNT+1];

  wd *= POS_COUNT;
  msg[LEN_COUNT] = 0;

  string(msg, old, LEN_COUNT);
  font_clear(msg, wd, y);

  string(msg, now, LEN_COUNT);
  font_print(msg, wd, y);
}

static void show_money(int old, int now, int y, int wd)
{
  char msg[LEN_MONEY+1];

  wd = Screen->wd - (LEN_MONEY+1) * wd;
  msg[LEN_MONEY] = 0;

  string(msg, old, LEN_MONEY);
  font_clear(msg, wd, y);

  string(msg, now, LEN_MONEY);
  font_print(msg, wd, y);
}


int user_shopping(m_player_t *player)
{
  int d, count, px, py, y, idx, top, lines, bottom, wd, ht, key, price;
  m_list_t *item;

  img_cls();

  wd = font_width();
  ht = font_height();

  idx = 0;        /* current from shown */
  top = AMMO_BASIC+1;     /* first show type */
  y = FIRST_POS * ht;
  lines = Screen->ht / ht - (2 + FIRST_POS);
  bottom = Screen->ht - 2 * ht;

  font_print(player->name, wd, bottom);
  show_money(0, player->money, bottom, wd);
  show_types(player, y, top, lines, wd, ht);

  /* I use shot as the item marker */
  px = POS_POINT * wd + (wd>>1);
  py = y + (ht>>1);
  shot_draw(px, py);

  for (;;) {
    key = win_getkey(TimeInput);

    if (GAME_EXIT(key)) {
      return 0;
    }

    switch (key) {
      case KEY_LEFT:
        /* buy */
        d = top + idx;
        price = item_price(d);
        if (player->money < price) {
          break;
        }
        item = list_add(player->items, d);
        count = item->count;

        show_count(count-1, count, y + idx*ht, wd, ht);
        win_sync();

        count = player->money;
        player->money -= price;
        show_money(count, player->money, bottom, wd);

        snd_play(SND_BUY);
        break;

      case KEY_RIGHT:
        /* sell */
        d = top + idx;
        item = list_search(player->items, d);
        if (!item) {
          break;
        }
        count = item->count;
        if (item == player->items) {
          player->items = list_free(item);
        } else {
          list_free(item);
        }
        show_count(count, count-1, y + idx*ht, wd, ht);
        win_sync();

        count = item_price(d);
        count -= count * Discount / 100;
        count += player->money;
        show_money(player->money, count, bottom, wd);
        player->money = count;

        snd_play(SND_SELL);
        break;

      case KEY_UP:
        if (--idx < 0) {
          if (top - lines <= AMMO_BASIC) {
            idx++;
            break;
          }
          top -= lines;
          show_types(player, y, top, lines, wd, ht);
          py += lines * ht;
          idx += lines;
        } else {
          shot_clear(px, py);
        }
        py -= ht;
        shot_draw(px, py);
        break;

      case KEY_DOWN:
        if (++idx + top >= USER_TYPES) {
          idx--;
          break;
        }
        if (idx >= lines) {
          top += lines;
          show_types(player, y, top, lines, wd, ht);
          py -= lines * ht;
          idx -= lines;
        } else {
          shot_clear(px, py);
        }
        py += ht;
        shot_draw(px, py);
        break;

      case KEY_ACCEPT1:
      case KEY_ACCEPT2:
        snd_play(SND_ACCEPT);
        return 1;
    }
  }
}

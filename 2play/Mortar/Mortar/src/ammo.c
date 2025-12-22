/* 
 * MORTAR
 * 
 * -- different shot types
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * NOTES
 * - If you modify shot x and y co-ordinates, you need to call
 *   shot_clearme() before and shot_drawme() afterwards.
 * - When shots are created, 'z' variable is zeroed.  It can
 *   be used for keeping count of the shot type state.
 * - Convention is that if type has multiple phases, their callback
 *   function names are all prefixed with a number.
 * - Gravity is actually just a shot weight multiplier :-).
 */

#include <stdlib.h>
#include "mortar.h"


/* shot statistics */
static int Height, Pixels;


/*** FLIGHT handlers ***/

static int float1(m_shot_t *shot)
{
  if (shot->dy >= 0) {
    shot->type = &Ammo[AMMO_FLOAT2];
  }
  shot->z++;
  return 0;
}

static int float2(m_shot_t *shot)
{
  if (!shot->z--) {
    shot->type = &Ammo[AMMO_BASIC];
    shot->dx = 0;

    snd_play(SND_CLICK);
  }
  return 0;
}

static int brang(m_shot_t *shot)
{
  /* if some other new type needs additional variables,
   * add a new shot structure member.  Static variables wouldn't
   * work if there were multiple shots flying at the time...
   */
  static init = 0;

  if (shot->dy >= 0) {
    if (!init) {
      if (shot->z) {
        shot->z = 2 * shot->dx / shot->z;
      }
      init = 1;
    }
    shot->dx -= shot->z;
  } else {
    init = 0;
    shot->z++;
  }
  return 0;
}

static int timer(m_shot_t *shot)
{
  if (++shot->z > 50) {
    return 1;
  }
  return 0;
}

static int triple(m_shot_t *shot)
{
  /* at top of it's flight? */
  if (shot->dy >= 0) {

    /* change shot to basic type and triple it
     * with 1/4 pixel speed change
     */
    shot->type = &Ammo[AMMO_BASIC];
    shot_spawn(shot)->dx -= 1 << (FIXBITS - 2);
    shot_spawn(shot)->dx += 1 << (FIXBITS - 2);

    snd_play(SND_CLICK);
  }
  return 0;
}

static int roll2(m_shot_t *shot)
{ 
  /* back in the air -> start falling again */
  shot->type = &Ammo[AMMO_ROLL];
  return 0;
}


/*** HIT handlers: return NO_HIT or mask index (HIT_BG) for explosion ***/


static int roll1(m_shot_t *shot, m_hit_t *hit)
{
  if (hit->type != HIT_GROUND) {
    return HIT_BG;
  }
  if (hit->count < Pixels) {
    /* remove weight */
    shot->type = &Ammo[AMMO_ROLL2];
    shot->dy = 0;
    if (shot->z < hit->count) {
      snd_play(SND_BOUNCE);
    }
    shot->z = hit->count;

    return NO_HIT;
  }
  /* buried into ground -> boom */
  return HIT_BG;
}

static int back(m_shot_t *shot, m_hit_t *hit)
{
  shot->dx = -shot->dx;
  return roll1(shot, hit);
}

static int roll3(m_shot_t *shot, m_hit_t *hit)
{
  if (hit->type != HIT_GROUND) {
    return HIT_BG;
  }
  /* not stopped nor deeper into ground? -> continue */
  if (shot->dx && shot->z >= hit->count) {
    shot->z = hit->count;
    return NO_HIT;
  }
  /* uphill -> boom */
  return HIT_BG;
}

static int bounce(m_shot_t *shot, m_hit_t *hit)
{
  if (hit->type != HIT_GROUND) {
    /* three bounces and boom */
    return HIT_BG;
  }
  if (shot->z++ >= 2 || hit->count >= Pixels) {
    /* bounced twice or buried */
    return HIT_BG;
  }

  shot_clearme(shot);
  shot->x -= shot->dx >> 1;
  shot->y -= shot->dy >> 1;
  shot_drawme(shot);

  /* decrease momentum 1/4 */
  shot->dx -= shot->dx >> 2;
  shot->dy -= shot->dy >> 2;

  /* reverse direction either horizontally or vertically */
  if (shot->dy >= 0) {
    shot->dy = -shot->dy;
  } else {
    shot->dx = -shot->dx;
  }
  snd_play(SND_BOUNCE);
  return NO_HIT;
}

static int dig(m_shot_t *shot, m_hit_t *hit)
{
  if (hit->type != HIT_GROUND) {
    return HIT_BG;
  }
  /* dig a little deeper until completely buried... */
  if (hit->count < Pixels) {

    if (hit->count < shot->z) {
      /* less ground -> boom */
      return HIT_BG;
    }
    shot->z = hit->count;
    return NO_HIT;
  }
  /* ...and then send upwards */
  shot->type = &Ammo[AMMO_DIG2];
  snd_play(SND_SUCK);
  return NO_HIT;
}

static int cement(m_shot_t *shot, m_hit_t *hit)
{
  snd_play(SND_THUMP);
  return HIT_GROUND;
}

static int spread(m_shot_t *shot, m_hit_t *hit)
{
  m_shot_t *old;
  int idx;

  if (hit->type != HIT_GROUND) {
    return HIT_BG;
  }
  /* change to basic type and multiply */
  shot->type = &Ammo[AMMO_BASIC];
  shot->x -= shot->dx;
  shot->y -= shot->dy;
  if (shot->dy < 2 && shot->dy > -2) {
    shot->dy = 2;
  }
  old = shot;

  idx = 4;
  while (--idx >= 0) {
    shot = shot_spawn(old);
    shot->dx = RND(1<<FIXBITS) - (1<<(FIXBITS-1));
    shot->dy = RND(shot->dy >> 1) - shot->dy;
  }

  old->x += old->dx;
  old->y += old->dy;
  old->dy = -(old->dy >> 1);
  old->dx = old->dx >> 1;

  snd_play(SND_BOUNCE);
  return NO_HIT;
}


static struct m_ammo_t ammo_array[AMMO_TYPES_ALL] =
{
  /* name, fly-h, hit-h, weight, radius, damage, price, bg */
  { NULL, NULL,   NULL,   4,  8, 16,   0, HIT_BG }, /* basic */
  { NULL, NULL,   cement, 4,  8,  1, 100, HIT_BG }, /* stone */
  { NULL, float1, NULL,   4,  8, 16, 100, HIT_BG }, /* float */
  { NULL, brang,  NULL,   4,  8, 16, 100, HIT_BG }, /* boomerang */
  { NULL, NULL,   roll1,  4,  8, 16, 200, HIT_BG }, /* roll */
  { NULL, NULL,   back,   4,  8, 16, 200, HIT_BG }, /* roll-back */
  { NULL, NULL,   bounce, 4,  8, 16, 200, HIT_BG }, /* bounce */
  { NULL, NULL,   dig,    4,  8, 16, 200, HIT_BG }, /* dig */
  { NULL, timer,  NULL,   0,  8, 16, 200, HIT_BG }, /* timer */
  { NULL, triple, NULL,   4,  8, 16, 300, HIT_BG }, /* triple */
  { NULL, NULL,   NULL,   4, 16, 16, 300, HIT_BG }, /* big */
  { NULL, NULL,   NULL,   8, 16, 32, 400, HIT_BG }, /* nuke */
  { NULL, NULL,   spread, 4,  8, 16, 500, HIT_BG }, /* surprise */
  { },
  { NULL, float2, NULL,   0,  8, 16,   0, HIT_BG }, /* float2 */
  { NULL, roll2,  roll3,  0,  8, 16,   0, HIT_BG }, /* roll2 */
  { NULL, NULL,   NULL,  -4,  8, 16,   0, HIT_GROUND }  /* dig2 */
};


struct m_ammo_t *Ammo = &ammo_array[0];


int ammo_init(int ht, int count)
{
  static struct m_ammo_t *ptr;
  int radius, damage, idx;
  float gravity;

  gravity = get_float("gravity");
  radius  = get_value("radius");
  damage  = get_value("damage");

  if (gravity <= 0.0 || radius < 1 || damage < 1) {
    msg_print(ERR_VARS);
    return 0;
  }

  /* calibrate for different shot types the shot explosion radius,
   * shot damage and weight.
   */
  ptr = Ammo + AMMO_TYPES_ALL;
  while (--ptr >= Ammo) {
    ptr->radius *= radius;
    ptr->damage *= damage;
    ptr->weight *= gravity;
  }

  /* get the names in currently selected language for user selectable
   * shot types
   */
  idx = AMMO_TYPES;
  ptr = Ammo + AMMO_TYPES;
  while (--idx >= 0) {
    --ptr;
    ptr->name = msg_string(idx);
  }

  Height = ht;
  Pixels = count;
  return 1;
}

m_uchar *ammo_name(int type)
{
  return Ammo[type].name;
}

int ammo_price(int type)
{
  return Ammo[type].price;
}

/* functions below return values which will be used for tank / cannon */

int ammo_gravity(void)
{
  /* heviest weight */
  return Ammo[AMMO_NUKE].weight;
}

int ammo_damage(void)
{
  /* slightest damage */
  return Ammo[AMMO_BASIC].damage;
}

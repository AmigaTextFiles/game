#include <stdio.h>

#include "world.h"
#include "dungeon.h"
#include "creature.h"
#include "creature-detail.h"
#include "enchantment-detail.h"
#include "monster.h"

#include "magic-device.h"

static const char *potion_name(int type);
static int explosion(world *wp, int z, int x, int y);

static const char *
potion_name(int type)
{
  switch (type)
  {
  case POTION_HEALING:
    return "healing";
    break;
  case POTION_SPEED:
    return "speed";
    break;
  default:
    return "undefined";
    break;
  }

  return "should not happen";
}

/*
 * these functions assume that only the player can use magic devices
 *
 */

int
quaff_potion_bag(world *wp, int type)
{
  struct creature_detail crd;
  char buf[128];
  creature *player = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "quaff_potion_bag: wp is NULL\n");
    return 1;
  }

  if (creature_is_dead(wp, wp->player_id))
  {
    fprintf(stderr, "quaff_potion_bag: player is dead\n");
    return 1;
  }
  player = wp->cr[wp->player_id];
  creature_detail_get(player->type, &crd);

  if (wp->player_shield <= 0)
  {
    sprintf(buf, "it fails to work because %s does't have shield", crd.name);
    add_log(wp, buf);
    return 0;
  }

  sprintf(buf, "%s quaffs potion of %s", crd.name, potion_name(type));
  add_log(wp, buf);

  switch (type)
  {
  case POTION_HEALING:
    creature_heal_hp(wp, player->id, -1, 1);
    break;
  case POTION_SPEED:
    /* the duration will be decremented this turn */
    creature_add_enchantment(wp, player->id, ENC_FAST, 8 + 1);
    break;
  default:
    add_log(wp, "nothing happens");
    break;
  }

  wp->player_shield = 0;

  return 0;
}

int
read_spellbook_swap_position(world *wp, int target_x, int target_y)
{
  int i;
  int found;
  struct creature_detail crd;
  char buf[128];
  creature *player = NULL;
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "read_spellbook_swap_position: wp is NULL\n");
    return 1;
  }

  if (creature_is_dead(wp, wp->player_id))
  {
    fprintf(stderr, "read_spellbook_swap_position: player is dead\n");
    return 1;
  }
  player = wp->cr[wp->player_id];
  creature_detail_get(player->type, &crd);

  if (wp->player_shield <= 0)
  {
    sprintf(buf, "it fails to work because %s does't have shield", crd.name);
    add_log(wp, buf);
    return 0;
  }

  sprintf(buf, "%s reads spellbook of swap position", crd.name);
  add_log(wp, buf);

  if ((player->x == target_x) && (player->y == target_y))
  {
    add_log(wp, "target must be different position");
    return 0;
  }
  if (distance(player->x, player->y,
               target_x, target_y) > 8)
  {
    add_log(wp, "target is too far");
    return 0;
  }

  found = 0;
  for (i = 0; i < wp->cr_size; i++)
  {
    if (creature_is_dead(wp, i))
      continue;
    who = wp->cr[i];

    if (who->id == player->id)
      continue;
    if (who->z != player->z)
      continue;
    if (who->x != target_x)
      continue;
    if (who->y != target_y)
      continue;

    found = 1;
    who->x = player->x;
    who->y = player->y;
    monster_set_attitude(wp, who, ATTITUDE_MONSTER_LOST);
  }

  if (found)
  {
    add_log(wp, "position is swapped");
    player->x = target_x;
    player->y = target_y;
    wp->camera_z = player->z;
    wp->camera_x = player->x;
    wp->camera_y = player->y;
    wp->player_shield = 0;
  }
  else
  {
    add_log(wp, "nothing is there");
    (wp->player_shield)--;
  }

  return 0;
}

static int
explosion(world *wp, int z, int x, int y)
{
  int i;
  int dx;
  int dy;
  int dist;

  if (wp == NULL)
    return 1;

  /* this is very stupid
   * a pre-calculated iterator will be better
   */
  for (dist = 0; dist <= 1; dist++)
  {
    for (dx = -1; dx <= 1; dx++)
    {
      for (dy = -1; dy <= 1; dy++)
      {
        if (distance(dx, dy, 0, 0) != dist)
          continue;
        if (grid_is_illegal(wp, z, x + dx, y + dy))
          continue;
        /* LOS must be checked here if dist >= 2 */
        for (i = 0; i < wp->cr_size; i++)
        {
          if (creature_is_dead(wp, i))
            continue;
          if (i == wp->player_id)
            continue;
          if (wp->cr[i]->z != z)
            continue;
          if (wp->cr[i]->x != x + dx)
            continue;
          if (wp->cr[i]->y != y + dy)
            continue;

          /* set attacker id to -1 --- no recharge-by-kill here */
          creature_take_damage(wp, i, 18,
                               -1, 1, 0);
        }
      }
    }
  }

  return 0;
}

int
zap_rod_mana_ball(world *wp, int dx, int dy)
{
  int i;
  int target_x;
  int target_y;
  struct creature_detail crd;
  char buf[128];
  creature *player = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "zap_rod_mana_ball: wp is NULL\n");
    return 1;
  }

  if (creature_is_dead(wp, wp->player_id))
  {
    fprintf(stderr, "zap_rod_mana_ball: player is dead\n");
    return 1;
  }
  player = wp->cr[wp->player_id];
  creature_detail_get(player->type, &crd);

  if (wp->player_shield <= 0)
  {
    sprintf(buf, "it fails to work because %s does't have shield", crd.name);
    add_log(wp, buf);
    return 0;
  }
  if ((dx < -1) || (dx > 1)
      || (dy < -1) || (dy > 1))
  {
    add_log(wp, "it doesn't work in that direction");
    return 0;
  }

  sprintf(buf, "%s zaps rod of mana ball", crd.name);
  add_log(wp, buf);

  target_x = player->x;
  target_y = player->y;
  if ((dx != 0) || (dy != 0))
  {
    for (i = 1; i <= 7; i++)
    {
      target_x = player->x + dx * i;
      target_y = player->y + dy * i;
      if (grid_has_creature(wp, player->z, target_x, target_y))
        break;
      if (grid_blocks_beam(wp, player->z, target_x, target_y))
        break;
    }
  }

  wp->player_shield = 0;
  explosion(wp, player->z, target_x, target_y);

  for (i = 0; i < wp->cr_size; i++)
  {
    if (creature_is_dead(wp, i))
      continue;
    if (i == wp->player_id)
      continue;
    if (wp->cr[i]->z != player->z)
      continue;
    if (distance(wp->cr[i]->x, wp->cr[i]->y,
                 target_x, target_y) > 5)
      continue;

    monster_set_attitude(wp, wp->cr[i], ATTITUDE_MONSTER_LOST);
  }

  return 0;
}

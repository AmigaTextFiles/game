#include <stdio.h>
/* realloc, abs, rand */
#include <stdlib.h>

#include "world.h"
#include "creature.h"
#include "util.h"
#include "creature-detail.h"
#include "grid-detail.h"
#include "digital-fov.h"
#include "array.h"
#include "monster.h"
#include "action.h"
#include "item.h"
#include "name.h"

#include "dungeon.h"

int
distance(int ax, int ay, int bx, int by)
{
  int dx;
  int dy;

  dx = bx - ax;
  dy = by - ay;

  if (abs(dx) > abs(dy))
    return abs(dx);
  
  return abs(dy);
}

/* return:
 *   0 if not in a cardinal direction
 *   1 if in a diagonal direction
 *   2 if in a horizontal or vertical direction
 *   3 if (ax, ay) and (bx, by) are same
 */
int
cardinal_direction(int ax, int ay, int bx, int by)
{
  int dx;
  int dy;

  dx = bx - ax;
  dy = by - ay;

  if ((dx == 0) && (dy == 0))
    return 3;

  if (dx == 0)
    return 2;
  if (dy == 0)
    return 2;

  if (abs(dx) == abs(dy))
    return 1;

  return 0;
}

/* this does _not_ consider distance */
int
has_los_from_player(world *wp, int z, int x, int y)
{
  int u;
  int v;

  if (wp == NULL)
    return 0;

  /* no need to call grid_is_illegal() here because
   * digital_los/fov() calls it
   */

  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size))
    return 0;
  if (wp->cr[wp->player_id] == NULL)
    return 0;

  if (z != wp->cr[wp->player_id]->z)
    return 0;

  u = x - wp->cr[wp->player_id]->x + wp->pcache->map_fov_radius;
  v = y - wp->cr[wp->player_id]->y + wp->pcache->map_fov_radius;

  if ((update_player_cache(wp) != 0)
      || (u < 0) || (u >= 2 * wp->pcache->map_fov_radius + 1)
      || (v < 0) || (v >= 2 * wp->pcache->map_fov_radius + 1))
  {
    return digital_los(wp, z, x, y,
                       wp->cr[wp->player_id]->z,
                       wp->cr[wp->player_id]->x,
                       wp->cr[wp->player_id]->y);
  }

  return wp->pcache->map_fov[u][v];
}

int
move_item(world *wp, int item_id, int dest_where, int dest_owner,
          int dest_z, int dest_x, int dest_y, int dest_slot,
          int verbose)
{
  int i;
  int did_wield;
  item *what = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "move_item: wp is NULL\n");
    return 1;
  }
  if ((item_id < 0) || (item_id >= wp->itm_size))
  {
    fprintf(stderr, "move_item: strange item_id (%d)\n", item_id);
    return 1;
  }

  /* dead or alive */
  what = wp->itm[item_id];
  if (what == NULL)
  {
    fprintf(stderr, "move_item: what is NULL\n");
    return 1;
  }

  switch (what->where)
  {
  case ITEM_NOWHERE:
    /* do nothing */;
    break;
  case ITEM_FLOOR:
    /* do nothing */;
    break;
  case ITEM_SHEATH:
    if ((what->owner < 0) || (what->owner >= wp->cr_size))
    {
      fprintf(stderr, "move_item: strange what->owner (%d)\n", what->owner);
      return 1;
    }
    if (wp->cr[what->owner] == NULL)
    {
      fprintf(stderr, "move_item: wp->cr[%d] (what->owner) is NULL\n",
              what->owner);
      return 1;
    }

    if ((dest_where == ITEM_SHEATH) && (dest_owner == what->owner))
      return 0;

    if (what->owner == wp->player_id)
    {
      for (i = 0; i < 4; i++)
      {
        if (wp->player_sheath[i] == what->id)
        {
          wp->player_sheath[i] = -1;
        }
      }
    }

    if (wp->cr[what->owner]->weapon_id == what->id)
    {
      wp->cr[what->owner]->weapon_id = -1;

      if (verbose)
      {
        add_wield_message(wp, what->owner);
      }
    }

    what->where = ITEM_NOWHERE;
    break;
  default:
    fprintf(stderr, "move_item: undefined what->where (%d)\n", what->where);
    return 1;
    break;
  }

  did_wield = 0;
  switch (dest_where)
  {
  case ITEM_NOWHERE:
    /* do nothing */;
    break;
  case ITEM_FLOOR:
    if (grid_is_illegal(wp, dest_z, dest_x, dest_y))
    {
      fprintf(stderr, "move_item: destination grid is illegal "
              "(%d, %d, %d)\n", dest_z, dest_x, dest_y);
      return 1;
    }
    break;
  case ITEM_SHEATH:
    if ((dest_owner < 0) || (dest_owner >= wp->cr_size))
    {
      fprintf(stderr, "move_item: strange dest_owner (%d)\n", dest_owner);
      return 1;
    }
    if (wp->cr[dest_owner] == NULL)
    {
      fprintf(stderr, "move_item: wp->cr[%d] is NULL\n", dest_owner);
      return 1;
    }
    if (what->type != ITEM_TYPE_WEAPON)
    {
      fprintf(stderr, "move_item: only a weapon can be put in a sheath\n");
      return 1;
    }

    if (dest_owner == wp->player_id)
    {
      if ((dest_slot < 0) || (dest_slot >= 4))
      {
        fprintf(stderr, "move_item: strange dest_slot (%d)\n", dest_slot);
        return 1;
      }
      if (wp->player_sheath[dest_slot] >= 0)
      {
        fprintf(stderr, "move_item: wp->player_sheath[%d] is already used\n",
                dest_slot);
        return 1;
      }

      wp->player_sheath[dest_slot] = what->id;
      if (dest_slot == wp->player_weapon_slot)
      {
        wp->cr[dest_owner]->weapon_id = what->id;
        did_wield = 1;
      }
    }
    else
    {
      if (wp->cr[dest_owner]->weapon_id >= 0)
      {
        fprintf(stderr, "move_item: wp->cr[%d]->weapon_id is already used\n",
                dest_owner);
        return 1;
      }
      wp->cr[dest_owner]->weapon_id = what->id;
      did_wield = 1;
    }
    break;
  default:
    fprintf(stderr, "move_item: undefined dest_where (%d)\n", dest_where);
    return 1;
    break;
  }

  what->where = dest_where;
  what->owner = dest_owner;
  what->z = dest_z;
  what->x = dest_x;
  what->y = dest_y;

  if ((did_wield) && (verbose))
  {
    add_wield_message(wp, what->owner);
  }

  return 0;
}

int
destroy_item(world *wp, int item_id, int verbose)
{
  char *item_name = NULL;
  char buf[128];

  if (wp == NULL)
  {
    fprintf(stderr, "destroy_item: wp is NULL\n");
    return 1;
  }
  if ((item_id < 0) || (item_id >= wp->itm_size))
  {
    fprintf(stderr, "destroy_item: strange item_id (%d)\n", item_id);
    return 1;
  }

  if (item_is_dead(wp, item_id))
  {
    return 0;
  }

  if (verbose)
  {
    item_name = get_item_name(wp, item_id, 0);
    if (item_name == NULL)
    {
      sprintf(buf, "NULL is destroyed");
    }
    else
    {
      sprintf(buf, "%s is destroyed", item_name);
    }
    add_log(wp, buf);

    if (item_name != NULL)
    {
      free(item_name);
      item_name = NULL;
    }
  }

  move_item(wp, item_id, ITEM_NOWHERE, -1,
            -1, -1, -1, -1,
            1);
  wp->itm[item_id]->quantity = 0;

  return 0;
}

int
creature_is_dead(world *wp, int creature_id)
{
  if (wp == NULL)
  {
    fprintf(stderr, "creature_is_dead: wp is NULL\n");
    return 1;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "creature_is_dead: strange creature_id (%d)\n",
            creature_id);
    return 1;
  }

  if (wp->cr[creature_id] == NULL)
    return 1;
  if (wp->cr[creature_id]->hp < 0)
    return 1;

  return 0;
}

/* this considers the distance as well as LOS
 * return:
 *   0 if the creature doesn't see the grid
 *   a positive value if the creature see the grid
 *     (a greater value means that the creature sees more clearly)
 */
int
creature_sees_grid(world *wp, int creature_id, int z, int x, int y)
{
  int d;
  int has_los;
  creature *who = NULL;
  creature *player = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "creature_sees_grid: wp is NULL\n");
    return 0;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "creature_sees_grid: strange creature_id (%d)\n",
            creature_id);
    return 0;
  }

  /* dead or alive */
  who = wp->cr[creature_id];
  if (who == NULL)
  {
    fprintf(stderr, "creature_sees_grid: who is NULL\n");
    return 0;
  }

  if (grid_is_illegal(wp, z, x, y))
    return 0;

  d = distance(x, y, who->x, who->y);

  if (z != who->z)
    return 0;

  if (who->id == wp->player_id)
  {
    if (d > PLAYER_SIGHT_RANGE)
      return 0;
    if (has_los_from_player(wp, z, x, y))
      return 99;
    return 0;
  }

  player = wp->cr[wp->player_id];
  if (player == NULL)
  {
    fprintf(stderr, "creature_sees_grid: player is NULL\n");
    return 0;
  }

  if (d > 7)
    return 0;

  if ((z == player->z)
      && (x == player->x)
      && (y == player->y))
    has_los = has_los_from_player(wp, who->z, who->x, who->y);
  else if (who->id == wp->player_id)
    has_los = has_los_from_player(wp, z, x, y);
  else
    has_los = digital_los(wp,
                          z, x, y,
                          who->z, who->x, who->y);

  if (has_los)
  {
    return 1;
  }

  return 0;
}

int
player_searches_grid(world *wp, int z, int x, int y)
{
  if (wp == NULL)
  {
    fprintf(stderr, "player_searches_grid: wp is NULL\n");
    return 0;
  }

  if (creature_is_dead(wp, wp->player_id))
  {
    /* reveal monsters to the dead player */
    return 1;
  }

  if (z != wp->camera_z)
    return 0;
  if (distance(x, y, wp->camera_x, wp->camera_y) > PLAYER_SEARCH_RANGE)
    return 0;

  return 1;
}

int
creature_is_wielding_weapon(world *wp, int creature_id)
{
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "creature_is_wielding_weapon: wp is NULL\n");
    return 1;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "creature_is_wielding_weapon: strange creature_id "
            "(%d)\n", creature_id);
    return 1;
  }

  if (creature_is_dead(wp, creature_id))
    return 0;
  who = wp->cr[creature_id];

  if ((who->weapon_id < 0) || (who->weapon_id >= wp->itm_size))
    return 0;
  if (item_is_dead(wp, who->weapon_id))
    return 0;
  if (wp->itm[who->weapon_id]->type != ITEM_TYPE_WEAPON)
    return 0;

  return 1;
}

/* Identify Friend or Foe */
int
get_creature_iff(world *wp, int creature_id)
{
  if (wp == NULL)
  {
    fprintf(stderr, "get_creature_iff: wp is NULL\n");
    return CREATURE_IFF_UNKNOWN;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "get_creature_iff: strange creature_id (%d)\n",
            creature_id);
    return CREATURE_IFF_UNKNOWN;
  }

  if (creature_id == wp->player_id)
    return CREATURE_IFF_FRIENDLY;
  if (wp->cr[creature_id] == NULL)
    return CREATURE_IFF_UNKNOWN;

  return CREATURE_IFF_HOSTILE;
}

int
creature_take_damage(world *wp, int target_id, int dam,
                     int attacker_id, int verbose)
{
  char *target_name = NULL;
  char buf[128];

  if (wp == NULL)
  {
    fprintf(stderr, "creature_take_damage: wp is NULL\n");
    return 1;
  }
  if ((target_id < 0) || (target_id >= wp->cr_size))
  {
    fprintf(stderr, "creature_take_damage: strange target_id (%d)\n",
            target_id);
    return 1;
  }
  if (dam <= 0)
  {
    fprintf(stderr, "creature_take_damage: dam is non-positive (%d)\n",
            dam);
    return 1;
  }

  if (creature_is_dead(wp, target_id))
    return 0;

  target_name = get_creature_name(wp, target_id);
  if (verbose)
  {
    if (target_name == NULL)
      sprintf(buf, "NULL is damaged");
    else
      sprintf(buf, "%s is damaged", target_name);
    add_log(wp, buf);
  }

  wp->cr[target_id]->hp -= dam;

  if (creature_is_dead(wp, target_id))
  {
    credit_kill(wp, target_id, attacker_id);
    creature_die(wp, target_id);

    return 0;
  }
  else
  {
    /* we are damaged and survived, see if the player is in sight */
    if ((target_id != wp->player_id)
        && (wp->cr[target_id]->attitude != ATTITUDE_MONSTER_ACTIVE))
    {
      if (creature_sees_grid(wp, target_id,
                             wp->cr[wp->player_id]->z,
                             wp->cr[wp->player_id]->x,
                             wp->cr[wp->player_id]->y) > 0)
      {
        monster_set_attitude(wp, wp->cr[target_id], ATTITUDE_MONSTER_ACTIVE);
      }
      else
      {
        /* notice anyway  */
        monster_set_attitude(wp, wp->cr[target_id], ATTITUDE_MONSTER_ACTIVE);
      }
    }
  }

  if (target_name != NULL)
  {
    free(target_name);
    target_name = NULL;
  }

  return 0;
}

int
credit_kill(world *wp, int target_id, int attacker_id)
{
  int target_iff;
  int attacker_iff;
  char *target_name = NULL;
  char *attacker_name = NULL;
  char buf[128];

  if (wp == NULL)
  {
    fprintf(stderr, "credit_kill: wp is NULL\n");
    return 1;
  }
  if ((target_id < 0) || (target_id >= wp->cr_size))
  {
    fprintf(stderr, "credit_kill: strange target_id (%d)\n", target_id);
    return 1;
  }
  if (wp->cr[target_id] == NULL)
  {
    fprintf(stderr, "credit_kill: target (%d) is NULL\n", target_id);
    return 1;
  }

  target_iff = get_creature_iff(wp, target_id);
  target_name = get_creature_name(wp, target_id);
  /* attacker_id can be negative */
  if ((attacker_id < 0) || (attacker_id >= wp->cr_size))
  {
    attacker_iff = CREATURE_IFF_UNKNOWN;
  }
  else
  {
    attacker_iff = get_creature_iff(wp, attacker_id);
  }
  attacker_name = NULL;

  if ((attacker_id < 0)
      || (attacker_id >= wp->cr_size)
      || (wp->cr[attacker_id] == NULL))
  {
    if (target_name == NULL)
      sprintf(buf, "NULL dies");
    else
      sprintf(buf, "%s dies", target_name);
    add_log(wp, buf);
  }
  else
  {
    attacker_name = get_creature_name(wp, attacker_id);
    if (attacker_name == NULL)
    { 
      sprintf(buf, "NULL kills something");
    }
    else if (target_name == NULL)
    { 
      sprintf(buf, "%s kills NULL",
              attacker_name);
    }
    else
    { 
      sprintf(buf, "%s kills %s",
              attacker_name, target_name);
    }
    add_log(wp, buf);

    if ((attacker_iff == CREATURE_IFF_FRIENDLY)
        && (target_iff != CREATURE_IFF_FRIENDLY)
        && (!creature_is_dead(wp, wp->player_id)))
    {
      /* kill-and-heal */
      creature_heal_hp(wp, wp->player_id, -1, 0);
      /* remember the last kill */
      wp->last_kill_type = wp->cr[target_id]->type;
      if ((target_id == wp->ancient_dragon_id)
          || (target_id == wp->mature_dragon_id)
          || (target_id == wp->baby_dragon_id))
      {
        (wp->cr[wp->player_id]->level)++;
        (wp->cr[wp->player_id]->hp)++;
      }
    }
  }

  if (target_name != NULL)
  {
    free(target_name);
    target_name = NULL;
  }
  if (attacker_name != NULL)
  {
    free(attacker_name);
    attacker_name = NULL;
  }

  return 0;
}

/* set amount (arg 3) to negative for full healing
 * set amount (arg 3) to 0 to check max hp
 */
int
creature_heal_hp(world *wp, int target_id, int amount, int verbose)
{
  int max_hp;
  char *creature_name = NULL;
  struct creature_detail crd;
  char buf[128];

  if (wp == NULL)
  {
    fprintf(stderr, "creature_heal_hp: wp is NULL\n");
    return 1;
  }
  if ((target_id < 0) || (target_id >= wp->cr_size))
  {
    fprintf(stderr, "creature_heal_hp: strange target_id (%d)\n",
            target_id);
    return 1;
  }

  if (creature_is_dead(wp, target_id))
    return 0;

  creature_detail_get(wp->cr[target_id]->type, &crd);
  max_hp = crd.max_hp;
  max_hp += wp->cr[target_id]->level;

  if (amount < 0)
    wp->cr[target_id]->hp = max_hp;
  else
    wp->cr[target_id]->hp += amount;

  if (wp->cr[target_id]->hp > max_hp)
    wp->cr[target_id]->hp = max_hp;

  if ((verbose) && (amount != 0))
  {
    creature_name = get_creature_name(wp, target_id);
    if (creature_name == NULL)
      sprintf(buf, "NULL feels better");
    else
      sprintf(buf, "%s feels better", creature_name);
    add_log(wp, buf);

    if (creature_name != NULL)
    {
      free(creature_name);
      creature_name = NULL;
    }
  }

  return 0;
}

int
creature_change_xy(world *wp, int creature_id, int x, int y)
{
  creature *who = NULL;
  if (wp == NULL)
  {
    fprintf(stderr, "creature_change_xy: wp is NULL\n");
    return 1;
  }
  if ((x < 0) || (x >= wp->size_x))
  {
    fprintf(stderr, "creature_change_xy: strange x (%d)\n", x);
    return 1;
  }
  if ((y < 0) || (y >= wp->size_y))
  {
    fprintf(stderr, "creature_change_xy: strange y (%d)\n", x);
    return 1;
  }

  if (wp->cr[creature_id] == NULL)
  {
    fprintf(stderr, "creature_change_xy: wp->cr[%d] is NULL\n",
            creature_id);
    return 1;
  }
  who = wp->cr[creature_id];

  if (who->id == wp->player_id)
  {
    wp->camera_x = x;
    wp->camera_y = y;
  }
  if ((who->z == wp->camera_z)
      && (who->x == wp->cursor_x)
      && (who->y == wp->cursor_y)
      && ((creature_is_dead(wp, wp->player_id))
          || (creature_sees_grid(wp, wp->player_id,
                                 who->z, who->x, who->y) > 0)
          || (player_searches_grid(wp, who->z, who->x, who->y))))
  {
    wp->cursor_x = x;
    wp->cursor_y = y;
  }
  who->x = x;
  who->y = y;

  return 0;
}

int
creature_change_z(world *wp, int creature_id, int z)
{
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "creature_change_z: wp is NULL\n");
    return 1;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "creature_change_z: strange creature_id (%d)\n",
            creature_id);
    return 1;
  }
  if ((z < 0) || (z >= wp->size_z))
  {
    fprintf(stderr, "creature_change_z: strange z (%d)\n", z);
    return 1;
  }

  if (wp->cr[creature_id] == NULL)
  {
    fprintf(stderr, "creature_change_z: wp->cr[%d] is NULL\n",
            creature_id);
    return 1;
  }
  who = wp->cr[creature_id];

  if (z == who->z)
    return 0;

  if (who->id == wp->player_id)
  {
    wp->camera_z = z;
    wp->camera_x = who->x;
    wp->camera_y = who->y;
    wp->cursor_x = who->x;
    wp->cursor_y = who->y;
  }
  who->z = z;

  /* descend-and-gain-level */
  if (who->id == wp->player_id)
  {
    while (wp->player_z_max < z)
    {
      (who->level)++;
      (who->hp)++;
      wp->player_z_max += 2;
    }
  }

  return 0;
}

int
creature_teleport(world *wp, int creature_id)
{
  int i;
  int x;
  int y;
  int found;
  char buf[128];
  creature *who = NULL;
  char *creature_name = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "creature_teleport: wp is NULL\n");
    return 1;
  }

  if (creature_is_dead(wp, creature_id))
    return 0;
  who = wp->cr[creature_id];

  found = 0;
  for (i = 0; i < 100; i++)
  {
    x = 1 + (rand() % (wp->size_x - 2));
    y = 1 + (rand() % (wp->size_y - 2));
    if ((i < 50)
        && (distance(x, y, who->x, who->y)))
      continue;
    if ((!grid_blocks_creature(wp, who->z, x, y))
        && (!grid_has_creature(wp, who->z, x, y)))
    {
      found = 1;
      break;
    }
  }

  if (!found)
  {
    add_log(wp, "teleport doesn't work in such a narrow space");
    return 0;
  }

  creature_name = get_creature_name(wp, creature_id);
  if (creature_name == NULL)
    sprintf(buf, "NULL teleports");
  else
    sprintf(buf, "%s teleports", creature_name);
  add_log(wp, buf);

  if (creature_name != NULL)
  {
    free(creature_name);
    creature_name = NULL;
  }

  creature_change_xy(wp, who->id, x, y);

  return 0;
}

int
creature_die(world *wp, int creature_id)
{
  int item_id;
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "creature_die: wp is NULL\n");
    return 1;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "creature_die: strange creature_id (%d)\n", creature_id);
    return 1;
  }
  if (wp->cr[creature_id] == NULL)
  {
    fprintf(stderr, "creature_die: wp->cr[%d] is NULL\n", creature_id);
    return 1;
  }

  if (!creature_is_dead(wp, creature_id))
  {
    fprintf(stderr, "creature_die: creature %d is not dead\n",
            creature_id);
    return 1;
  }
  who = wp->cr[creature_id];

  if (who->id == wp->player_id)
    return 0;

  if ((who->weapon_id >= 0) && (who->weapon_id < wp->itm_size)
      && (!item_is_dead(wp, who->weapon_id)))
  {
    /* creature_drop_item() sets who->weapon_id to -1 */
    item_id = who->weapon_id;
    creature_drop_item(wp, who->id, item_id,
                       0);
    if (wp->itm[item_id]->thrown)
    {
      destroy_item(wp, item_id, 1);
    }
  }

  return 0;
}

int
creature_drop_item(world *wp, int creature_id, int item_id,
                   int verbose)
{
  creature *who = NULL;
  char *creature_name = NULL;
  char *item_name = NULL;
  char buf[128];

  if (wp == NULL)
  {
    fprintf(stderr, "creature_drop_item: wp is NULL\n");
    return 1;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "creature_drop_item: strange creature_id (%d)\n",
            creature_id);
    return 1;
  }
  if (wp->cr[creature_id] == NULL)
  {
    fprintf(stderr, "creature_drop_item: wp->cr[%d] is NULL\n",
            creature_id);
    return 1;
  }
  if ((item_id < 0) || (item_id >= wp->itm_size))
  {
    fprintf(stderr, "creature_drop_item: strange item_id (%d)\n",
            item_id);
    return 1;
  }
  if (wp->itm[item_id] == NULL)
  {
    fprintf(stderr, "creature_drop_item: wp->itm[%d] is NULL\n",
            item_id);
    return 1;
  }

  if ((wp->itm[item_id]->where != ITEM_SHEATH)
      || (wp->itm[item_id]->owner != creature_id))
  {
    fprintf(stderr, "creature_drop_item: creature %d doesn't have item %d\n",
            creature_id, item_id);
    return 1;
  }

  who = wp->cr[creature_id];

  if ((verbose)
      && (wp->player_id >= 0) && (wp->player_id < wp->cr_size)
      && (creature_sees_grid(wp, wp->player_id, who->z, who->x, who->y) > 0))
  {
    creature_name = get_creature_name(wp, who->id);
    item_name = get_item_name(wp, item_id, 0);
    if (creature_name == NULL)
    {
      sprintf(buf, "NULL drops something");
    }
    else if (item_name == NULL)
    {
      sprintf(buf, "%s drops NULL", creature_name);
    }
    else
    {
      sprintf(buf, "%s drops %s", creature_name, item_name);
    }
    add_log(wp, buf);

    if (creature_name != NULL)
    {
      free(creature_name);
      creature_name = NULL;
    }
    if (item_name != NULL)
    {
      free(item_name);
      item_name = NULL;
    }
  }

  move_item(wp, item_id, ITEM_FLOOR, -1,
            who->z, who->x, who->y, -1,
            verbose);

  return 0;
}

/* weapon_id must be set to a new value before calling this */
int
add_wield_message(world *wp, int creature_id)
{
  creature *who = NULL;
  char *creature_name = NULL;
  char *item_name = NULL;
  char buf[128];

  if (wp == NULL)
  {
    fprintf(stderr, "add_wield_message: wp is NULL\n");
    return 1;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "add_wield_message: strange creature_id (%d)\n",
            creature_id);
    return 1;
  }
  if (creature_is_dead(wp, creature_id))
  {
    fprintf(stderr, "add_wield_message: creature %d is dead\n",
            creature_id);
    return 1;
  }
  who = wp->cr[creature_id];
  creature_name = get_creature_name(wp, who->id);

  if ((wp->player_id >= 0) && (wp->player_id < wp->cr_size)
      && (creature_sees_grid(wp, wp->player_id,
                             who->z, who->x, who->y) > 0))
  {
    if ((who->weapon_id < 0) || (who->weapon_id >= wp->itm_size))
    {
      if (creature_name == NULL)
        sprintf(buf, "NULL is now empty-handed");
      else
        sprintf(buf, "%s is now empty-handed", creature_name);
    }
    else
    { 
      item_name = get_item_name(wp, who->weapon_id, 0);
      if (creature_name == NULL)
        sprintf(buf, "NULL wields something");
      if (item_name == NULL)
        sprintf(buf, "%s wields NULL", creature_name);
      else
        sprintf(buf, "%s wields %s", creature_name, item_name);
    }
    add_log(wp, buf);

    if (creature_name != NULL)
    {
      free(creature_name);
      creature_name = NULL;
    }
    if (item_name != NULL)
    {
      free(item_name);
      item_name = NULL;
    }
  }

  return 0;
}

int
item_is_dead(world *wp, int item_id)
{
  if (wp == NULL)
  {
    fprintf(stderr, "item_is_dead: wp is NULL\n");
    return 1;
  }
  if ((item_id < 0) || (item_id >= wp->itm_size))
  {
    fprintf(stderr, "item_is_dead: strange item_id (%d)\n", item_id);
    return 1;
  }

  if (wp->itm[item_id] == NULL)
    return 1;
  if (wp->itm[item_id]->quantity <= 0)
    return 1;

  return 0;
}

int
grid_is_illegal(world *wp, int z, int x, int y)
{
  if (wp == NULL)
  {
    fprintf(stderr, "grid_is_illegal: wp is NULL\n");
    return 1;
  }

  if ((z < 0) || (z >= wp->size_z))
    return 1;
  if ((x < 0) || (x >= wp->size_x))
    return 1;
  if ((y < 0) || (y >= wp->size_y))
    return 1;

  return 0;
}

int
grid_blocks_creature(world *wp, int z, int x, int y)
{
  if (wp == NULL)
  {
    fprintf(stderr, "grid_block_creature: wp is NULL\n");
    return 1;
  }

  if (grid_is_illegal(wp, z, x, y))
    return 1;

  switch (wp->grid[z][x][y] & GRID_TERRAIN_MASK)
  {
  case GR_WALL:
  case GR_GLASS_WALL:
    return 1;
    break;
  default:
    break;
  }

  return 0;
}

int
grid_has_creature(world *wp, int z, int x, int y)
{
  int i;

  if (wp == NULL)
  {
    fprintf(stderr, "grid_has_creature: wp is NULL\n");
    return 1;
  }

  if (grid_is_illegal(wp, z, x, y))
    return 1;

  for (i = 0; i < wp->cr_size; i++)
  {
    if (creature_is_dead(wp, i))
      continue;
    if ((wp->cr[i]->z == z)
        && (wp->cr[i]->x == x)
        && (wp->cr[i]->y == y))
    {
      return 1;
    }
  }

  return 0;
}

int
grid_has_enemy(world *wp, int z, int x, int y, int attacker_id)
{
  int i;

  if (wp == NULL)
  {
    fprintf(stderr, "grid_has_enemy: wp is NULL\n");
    return 1;
  }

  for (i = 0; i < wp->cr_size; i++)
  {
    if (i == attacker_id)
      continue;
    if (creature_is_dead(wp, i))
      continue;
    if (wp->cr[i]->z != z)
      continue;
    if (wp->cr[i]->x != x)
      continue;
    if (wp->cr[i]->y != y)
      continue;
    if (get_creature_iff(wp, i) == get_creature_iff(wp, attacker_id))
      continue;

    return 1;
  }

  return 0;
}

int
grid_blocks_los(world *wp, int z, int x, int y)
{
  if (wp == NULL)
  {
    fprintf(stderr, "grid_blocks_los: wp is NULL\n");
    return 1;
  }

  if (grid_is_illegal(wp, z, x, y))
    return 1;

  switch (wp->grid[z][x][y] & GRID_TERRAIN_MASK)
  {
  case GR_WALL:
    return 1;
    break;
  default:
    break;
  }

  return 0;
}

int
grid_blocks_beam(world *wp, int z, int x, int y)
{
  if (wp == NULL)
  {
    fprintf(stderr, "grid_blocks_beam: wp is NULL\n");
    return 1;
  }

  if (grid_is_illegal(wp, z, x, y))
    return 1;

  switch (wp->grid[z][x][y] & GRID_TERRAIN_MASK)
  {
  case GR_WALL:
  case GR_GLASS_WALL:
    return 1;
    break;
  default:
    break;
  }

  return 0;
}

int
grid_is_stair(world *wp, int z, int x, int y)
{
  if (wp == NULL)
  {
    fprintf(stderr, "grid_is_stair: grid is NULL\n");
    return 0;
  }

  if (grid_is_illegal(wp, z, x, y))
    return 0;

  switch (wp->grid[z][x][y] & GRID_TERRAIN_MASK)
  {
  case GR_STAIR_DOWN_0:
  case GR_STAIR_DOWN_1:
  case GR_STAIR_DOWN_2:
  case GR_STAIR_DOWN_3:
  case GR_STAIR_UP_0:
  case GR_STAIR_UP_1:
  case GR_STAIR_UP_2:
  case GR_STAIR_UP_3:
    return 1;
    break;
  default:
    break;
  }

  return 0;
}

/* return 1 if the destination is found, 0 otherwise */
int
find_stair_destination(world *wp,
                       int from_z, int from_x, int from_y,
                       int *dest_z, int *dest_x, int *dest_y)
{
  int dz;
  int target;
  int z;
  int x;
  int y;

  if (wp == NULL)
  {
    fprintf(stderr, "find_stair_destination: wp is NULL\n");
    return 0;
  }
  if (grid_is_illegal(wp, from_z, from_x, from_y))
  {
    fprintf(stderr, "find_stair_destination: grid is illegal "
            "(%d, %d, %d)\n",
            from_z, from_x, from_y);
    return 0;
  }

  if (dest_z != NULL)
    *dest_z = from_z;
  if (dest_x != NULL)
    *dest_x = from_x;
  if (dest_y != NULL)
    *dest_y = from_y;

  dz = 0;
  target = -1;
  switch (wp->grid[from_z][from_x][from_y] & GRID_TERRAIN_MASK)
  {
  case GR_STAIR_DOWN_0:
    dz = 1;
    target = GR_STAIR_UP_0;
    break;
  case GR_STAIR_DOWN_1:
    dz = 1;
    target = GR_STAIR_UP_1;
    break;
  case GR_STAIR_DOWN_2:
    dz = 1;
    target = GR_STAIR_UP_2;
    break;
  case GR_STAIR_DOWN_3:
    dz = 1;
    target = GR_STAIR_UP_3;
    break;
  case GR_STAIR_UP_0:
    dz = -1;
    target = GR_STAIR_DOWN_0;
    break;
  case GR_STAIR_UP_1:
    dz = -1;
    target = GR_STAIR_DOWN_1;
    break;
  case GR_STAIR_UP_2:
    dz = -1;
    target = GR_STAIR_DOWN_2;
    break;
  case GR_STAIR_UP_3:
    dz = -1;
    target = GR_STAIR_DOWN_3;
    break;
  default:
    break;
  }

  if ((dz == 0) || (target < 0))
    return 0;

  z = from_z + dz;
  if ((z < 0) || (z >= wp->size_z))
  {
    fprintf(stderr, "find_stair_destination: stair points to outside\n");
    return 0;
  }
  for (x = 0; x < wp->size_x; x++)
  {
    for (y = 0; y < wp->size_y; y++)
    {
      if ((wp->grid[z][x][y] & GRID_TERRAIN_MASK) == target)
      {
        if (dest_z != NULL)
          *dest_z = z;
        if (dest_x != NULL)
          *dest_x = x;
        if (dest_y != NULL)
          *dest_y = y;
        return 1;
      }
    }
  }

  return 0;
}

int
find_item_on_floor(world *wp, int z, int x, int y,
                   int known_item_id, int dir, int only_weapon)
{
  int i;
  int i_start;
  int item_id;
  int item_id0;
  int item_id_found;
  item *what = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "find_weapon_on_floor: wp is NULL\n");
    return -1;
  }
  if (grid_is_illegal(wp, z, x, y))
  {
    fprintf(stderr, "find_weapon_on_floor: (%d, %d, %d) is illegal\n",
            z, x, y);
    return -1;
  }
  if (known_item_id >= wp->itm_size)
  {
    fprintf(stderr, "find_weapon_on_floor: strange known_item_id (%d)\n",
            known_item_id);
    return -1;
  }
  if ((dir != 1) && (dir != -1))
  {
    fprintf(stderr, "find_weapon_on_floor: dir must be 1 or -1\n");
    return -1;
  }

  if (known_item_id < 0)
  {
    item_id0 = 0;
    i_start = 0;
    item_id_found = -1;
  }
  else
  {
    item_id0 = known_item_id;
    i_start = 1;
    item_id_found = known_item_id;
  }

  for (i = i_start; i < wp->itm_size; i++)
  {
    item_id = (item_id0 + i * dir + wp->itm_size) % wp->itm_size;
    if (item_is_dead(wp, item_id))
      continue;
    what = wp->itm[item_id];
    if (what->where != ITEM_FLOOR)
      continue;
    if (what->z != z)
      continue;
    if (what->x != x)
      continue;
    if (what->y != y)
      continue;
    if ((only_weapon) && (what->type != ITEM_TYPE_WEAPON))
      continue;

    item_id_found = item_id;
    break;
  }
  
  return item_id_found;
}

/* known_weapon_order starts at 1 */
int
count_item_on_floor(world *wp, int z, int x, int y,
                    int known_item_id, int *known_item_order,
                    int only_weapon)
{
  int i;
  int count;
  item *what = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "count_item_on_floor: wp is NULL\n");
    return 0;
  }
  if (grid_is_illegal(wp, z, x, y))
  {
    fprintf(stderr, "count_item_on_floor: (%d, %d, %d) is illegal\n",
            z, x, y);
    return 0;
  }

  count = 0;
  if (known_item_order != NULL)
    (*known_item_order) = 0;
  for (i = 0; i < wp->itm_size; i++)
  {
    if (item_is_dead(wp, i))
      continue;
    what = wp->itm[i];
    if (what->where != ITEM_FLOOR)
      continue;
    if (what->z != z)
      continue;
    if (what->x != x)
      continue;
    if (what->y != y)
      continue;
    if ((only_weapon) && (what->type != ITEM_TYPE_WEAPON))
      continue;

    count++;
    if (i == known_item_id)
    { 
      if (known_item_order != NULL)
        (*known_item_order) = count;
    }
  }

  return count;
}

int
find_open_floor(world *wp, int z, int *result_x, int *result_y)
{
  int x;
  int y;

  if (wp == NULL)
  {
    fprintf(stderr, "find_open_floor: wp is NULL\n");
    return 1;
  }
  if ((z < 0) || (z >= wp->size_z))
  {
    fprintf(stderr, "find_open_floor: strange z (%d)\n", z);
    return 1;
  }

  /* assumes that there are many open floors
   * this is a problem (an infinite loop) if there is no open floor
   */
  do
  {
    x = rand() % wp->size_x;
    y = rand() % wp->size_y;
  } while (((wp->grid[z][x][y] & GRID_TERRAIN_MASK) != GR_FLOOR)
           || (grid_has_creature(wp, z, x, y)));
  /* grid_blocks_creature() is not enough here */

  *result_x = x;
  *result_y = y;

  return 0;
}

/* step_map (arg 2) must be an array of size (wp->size_x, wp->size_y) */
int
get_step_map(world *wp, int **step_map,
             int from_z, int from_x, int from_y,
             int dest_x, int dest_y,
             int max_step)
{
  int i;
  int x;
  int y;
  int dx;
  int dy;
  int step;
  int found;
  int queue_num;
  int queue_next_num;
  int **queue = NULL;
  int **queue_next = NULL;
  int **queue_temp = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "get_step_map: wp is NULL\n");
    return 1;
  }
  if (step_map == NULL)
  {
    fprintf(stderr, "get_step_map: step_map is NULL\n");
    return 1;
  }
  if (grid_is_illegal(wp, from_z, from_x, from_y))
  {
    fprintf(stderr, "get_step_map: (%d, %d, %d) is illegal\n",
            from_z, from_x, from_y);
    return 1;
  }

  queue = wp->step_map_queue[0];
  queue_next = wp->step_map_queue[1];

  for (x = 0; x < wp->size_x; x++)
  {
    for (y = 0; y < wp->size_y; y++)
    {
      step_map[x][y] = -1;
    }
  }
  step_map[from_x][from_y] = 0;
  queue_num = 0;
  if ((from_x != dest_x) || (from_y != dest_y))
  { 
    queue[queue_num][0] = from_x;
    queue[queue_num][1] = from_y;
    queue_num++;
  }
  step = 1;
  found = 0;

  while ((!found) && (queue_num > 0)
         && ((max_step < 0) || (step <= max_step)))
  {
    queue_next_num = 0;
    for (i = 0; i < queue_num; i++)
    {
      for (dx = -1; dx <= 1; dx++)
      {
        for (dy = -1; dy <= 1; dy++)
        {
          if ((dx == 0) && (dy == 0))
            continue;
          x = queue[i][0] + dx;
          y = queue[i][1] + dy;
          if (grid_is_illegal(wp, from_z, x, y))
            continue;
          if (step_map[x][y] >= 0)
            continue;
          if (grid_blocks_creature(wp, from_z, x, y))
            continue;
          step_map[x][y] = step;
          queue_next[queue_next_num][0] = x;
          queue_next[queue_next_num][1] = y;
          queue_next_num++;
          if ((x == dest_x) && (y == dest_y))
            found = 1;
        }
      }
    }
    queue_temp = queue;
    queue = queue_next;
    queue_next = queue_temp;
    queue_num = queue_next_num;
    step++;
  }

  return 0;
}

int
add_log(world *wp, const char *str)
{
  char *s;

  if (wp == NULL)
  {
    fprintf(stderr, "add_log: wp is NULL\n");
    return 1;
  }

  if (str == NULL)
    return 0;

  s = concat_string(1, str);
  if (s == NULL)
  {
    fprintf(stderr, "add_log: concat_string failed\n");
    return 1;
  }

  if ((wp->log_head < 0) || (wp->log_head >= wp->log_size))
  {
    fprintf(stderr, "add_log: strange log_head (%d)\n", wp->log_head);
    free(s);
    s = NULL;
    return 1;
  }
  if (wp->log[wp->log_head] != NULL)
  {
    free(wp->log[wp->log_head]);
    wp->log[wp->log_head] = NULL;
  }
  wp->log[wp->log_head] = s;
  wp->log_head = (wp->log_head + 1) % wp->log_size;

  return 0;
}

int
update_player_cache(world *wp)
{
  creature *player = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "update_player_cache: wp is NULL\n");
    return 1;
  }

  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size))
    return 1;
  player = wp->cr[wp->player_id];
  if (player == NULL)
    return 1;

  if ((wp->pcache->z == player->z)
      && (wp->pcache->x == player->x)
      && (wp->pcache->y == player->y))
    return 0;

  if (digital_fov(wp,
                  wp->pcache->map_fov,
                  player->z, player->x, player->y,
                  wp->pcache->map_fov_radius) != 0)
  {
    fprintf(stderr, "update_player_cache: digital_fov failed\n");
    return 1;
  }

  wp->pcache->z = player->z;
  wp->pcache->x = player->x;
  wp->pcache->y = player->y;

  return 0;
}

creature *
find_creature_under_cursor(world *wp)
{
  int i;
  creature *who = NULL;

  if (wp == NULL)
    return NULL;

  who = NULL;
  for (i = wp->cr_size - 1; i >= 0; i--)
  {
    if (creature_is_dead(wp, i))
      continue;
    if (wp->cr[i]->z != wp->camera_z)
      continue;
    if (wp->cr[i]->x != wp->cursor_x)
      continue;
    if (wp->cr[i]->y != wp->cursor_y)
      continue;

    who = wp->cr[i];
  }

  return who;
}

#include <stdio.h>

#include "world.h"
#include "dungeon.h"
#include "creature.h"
#include "action.h"
#include "monster.h"
#include "grid-detail.h"
#include "item.h"
#include "dungeon-add-remove.h"

#include "loop-action.h"

static int remove_dead(world *wp);
static int check_victory(world *wp);
static int player_remember_map(world *wp);
static int forget_old_last_known(world *wp);
static int loop_upkeep_action(world *wp);
static int loop_upkeep_turn(world *wp, int creature_id);
static int loop_upkeep_ut(world *wp, int ut);
static int loop_action_iterate(world *wp);

static int
remove_dead(world *wp)
{
  int i;

  if (wp == NULL)
    return 1;

  for (i = 0; i < wp->cr_size; i++)
  {
    /* this is necessary because NULL creature is considered dead */
    if (wp->cr[i] == NULL)
      continue;
    if (i == wp->player_id)
      continue;
    if (i == wp->ancient_dragon_id)
      continue;
    if (i == wp->mature_dragon_id)
      continue;
    if (i == wp->baby_dragon_id)
      continue;
    if (creature_is_dead(wp, i))
    {
      remove_creature(wp, i);
    }
  }

  for (i = 0; i < wp->itm_size; i++)
  {
    /* this is necessary because NULL item is considered dead */
    if (wp->itm[i] == NULL)
      continue;
    if (item_is_dead(wp, i))
    {
      remove_item(wp, i);
    }
  }

  return 0;
}

static int
check_victory(world *wp)
{
  if (wp == NULL)
    return 1;

  if (creature_is_dead(wp, wp->player_id))
    return 0;
  if (wp->victory)
    return 0;

  if ((wp->ancient_dragon_id >= 0) && (wp->ancient_dragon_id < wp->cr_size)
      && (creature_is_dead(wp, wp->ancient_dragon_id)))
    wp->victory = 1;
  if (wp->cr[wp->player_id]->z == 0)
  {    
    if ((wp->mature_dragon_id >= 0) && (wp->mature_dragon_id < wp->cr_size)
        && (creature_is_dead(wp, wp->mature_dragon_id)))
      wp->victory = 1;
    if ((wp->baby_dragon_id >= 0) && (wp->baby_dragon_id < wp->cr_size)
        && (creature_is_dead(wp, wp->baby_dragon_id)))
      wp->victory = 1;
  }

  return 0;
}

/* optimized under the assumptions that:
 * * the map never changes during the game
 * * the sight of the player is the square of size PLAYER_SIGHT_RANGE
 */
static int
player_remember_map(world *wp)
{
  int z;
  int x;
  int y;
  int dx;
  int dy;
  int dx_min;
  int dx_max;
  int dy_min;
  int dy_max;
  int dest_z;
  int dest_x;
  int dest_y;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size))
    return 1;
  if (wp->cr[wp->player_id] == NULL)
    return 1;
  player = wp->cr[wp->player_id];

  z = player->z;
  x = player->x;
  y = player->y;

  if ((z == wp->remember_map_from_z)
      && (x == wp->remember_map_from_x)
      && (y == wp->remember_map_from_y))
    return 0;
  wp->remember_map_from_z = z;
  wp->remember_map_from_x = x;
  wp->remember_map_from_y = y;

  if (grid_is_illegal(wp, z, x, y))
    return 1;

  dx_min = -PLAYER_SIGHT_RANGE;
  dx_max = PLAYER_SIGHT_RANGE;
  dy_min = -PLAYER_SIGHT_RANGE;
  dy_max = PLAYER_SIGHT_RANGE;
  if (x + dx_min < 0)
    dx_min = -x;
  if (x + dx_max >= wp->size_x)
    dx_max = wp->size_x - 1 - x;
  if (y + dy_min < 0)
    dy_min = -y;
  if (y + dy_max >= wp->size_y)
    dy_max = wp->size_y - 1 - y;

  for (dx = dx_min; dx <= dx_max; dx++)
  {
    for (dy = dy_min; dy <= dy_max; dy++)
    {
      /* LOS is expensive and should not be called unless necessary */
      if ((wp->grid[z][x + dx][y + dy] & GRID_PLAYER_SEEN)
          == GRID_PLAYER_SEEN)
        continue;
      if (creature_sees_grid(wp, wp->player_id,
                             z, x + dx, y + dy) <= 0)
        continue;

      wp->grid[z][x + dx][y + dy] |= GRID_PLAYER_SEEN;

      if (grid_is_stair(wp, z, x + dx, y + dy))
      {
        if (find_stair_destination(wp,
                                   z, x + dx, y + dy,
                                   &dest_z, &dest_x, &dest_y))
        {
          wp->grid[dest_z][dest_x][dest_y] |= GRID_PLAYER_SEEN;
        }
      }
    }
  }

  return 0;
}

static int
forget_old_last_known(world *wp)
{
  int i;

  if (wp == NULL)
    return 1;

  if (grid_is_illegal(wp,
                      wp->last_known_z,
                      wp->last_known_x,
                      wp->last_known_y))
    return 0;

  for (i = 0; i < wp->cr_size; i++)
  {
    if (i == wp->player_id)
      continue;
    if (creature_is_dead(wp, i))
      continue;
    if (wp->cr[i]->attitude == ATTITUDE_MONSTER_ACTIVE)
      return 0;
  }

  /* no active monster found --- probably all of them are killed */
  monster_forget_last_known(wp);

  return 0;
}

/* this must be idempotent; it must not do anything if no new action
 * is done before it is called
 */
static int
loop_upkeep_action(world *wp)
{
  if (wp == NULL)
    return 1;

  player_remember_map(wp);
  check_victory(wp);

  return 0;
}

static int
loop_upkeep_turn(world *wp, int creature_id)
{
  if (wp == NULL)
    return 1;
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
    return 1;
  if (wp->cr[creature_id] == NULL)
    return 1;

  wp->turn_state = TURN_STATE_NORMAL;

  return 0;
}

static int
loop_upkeep_ut(world *wp, int ut)
{
  if (wp == NULL)
    return 1;

  remove_dead(wp);
  forget_old_last_known(wp);

  wp->ut += ut;
  /* avoid overflow */
  if (wp->ut > 10000000)
    wp->ut = 10000000;

  return 0;
}

static int
loop_action_iterate(world *wp)
{
  int i;
  int ut;
  int found;

  if (wp == NULL)
    return 1;

  while ((wp->priority_now == NULL)
         || (wp->tor[wp->priority_now->n] == NULL)
         || (wp->tor[wp->priority_now->n]->wait > 0))
  {
    if (wp->priority_now == NULL)
    { 
      found = 0;
      ut = 0;
      for (i = 0; i < wp->tor_size; i++)
      {
        if (wp->tor[i] == NULL)
          continue;
        if ((!found) || (wp->tor[i]->wait < ut))
          ut = wp->tor[i]->wait;
        found = 1;
      }

      if (!found)
        return 1;

      for (i = 0; i < wp->tor_size; i++)
      {
        if (wp->tor[i] == NULL)
          continue;
        wp->tor[i]->wait -= ut;
      }

      loop_upkeep_ut(wp, ut);

      if (wp->priority_first == NULL)
        return 1;
      wp->priority_now = wp->priority_first;
    }
    else
    { 
      wp->priority_now = wp->priority_now->next;
    }
  }

  return 0;
}

/* the turn order handling is optimized under the assumption that
 * most of the entries have the same wait
 */
int
loop_action(world *wp)
{
  int ut;
  int turn_order_id;
  creature *who = NULL;

  if (wp == NULL)
    return 1;

  do
  {
    if (creature_is_dead(wp, wp->player_id))
      break;
    if (wp->victory)
      break;

    /* we need a valid entry */
    if (loop_action_iterate(wp) != 0)
      return 1;
    turn_order_id = wp->priority_now->n;

    loop_upkeep_action(wp);

    /* skip the turn of a dead monster */
    if (creature_is_dead(wp, wp->tor[turn_order_id]->which))
    {
      /* don't skip the dead player
       * note that loop_upkeep_action() may kill the player
       */
      if (wp->tor[turn_order_id]->which == wp->player_id)
        return 0;

      wp->tor[turn_order_id]->wait += 9999;
      continue;
    }

    who = wp->cr[wp->tor[turn_order_id]->which];
    if (who == NULL)
    {
      fprintf(stderr, "loop_action: who is NULL\n");
      return 1;
    }

    if (who->id != wp->player_id)
    {
      if (action_decide_monster(wp, who->id) != 0)
      {
        fprintf(stderr, "loop_action: action_decide_monster failed\n");
        return 1;
      }
    }

    ut = action_exec(wp, who->id);
    if (ut > 0)
    {
      loop_upkeep_turn(wp, who->id);
      wp->tor[turn_order_id]->wait += ut;
    }

    /* loop_action_iterate() must be called here again
     * --- the end condition of the loop depends on it
     * turn_order_id must be updated
     */
    if (loop_action_iterate(wp) != 0)
      return 1;
    turn_order_id = wp->priority_now->n;

  } while ((wp->tor[turn_order_id]->type != TURN_ORDER_CREATURE)
           || (wp->tor[turn_order_id]->which != wp->player_id));

  /* call loop_upkeep_action() once more to handle the last action */
  loop_upkeep_action(wp);

  return 0;
}

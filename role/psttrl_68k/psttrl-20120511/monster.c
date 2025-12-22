#include <stdio.h>
/* rand, abs */
#include <stdlib.h>

#include "world.h"
#include "action.h"
#include "dungeon.h"
#include "creature-detail.h"
#include "array.h"
#include "creature.h"
#include "grid-detail.h"

#include "monster.h"

static int monster_do_nothing(world *wp, creature *who);
static int monster_set_path_1(world *wp, creature *who,
                              int dest_z, int dest_x, int dest_y);
static int monster_set_path(world *wp, creature *who,
                            int dest_z, int dest_x, int dest_y);
static int monster_alert_here(world *wp,
                              int target_z, int target_x, int target_y);
static int monster_wander(world *wp, creature *who);
static int action_decide_monster_1(world *wp, creature *who);

static int
monster_do_nothing(world *wp, creature *who)
{
  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  who->act[0] = ACTION_WALK;
  who->act[1] = 0;
  who->act[2] = 0;

  return 0;
}

int
monster_has_path(world *wp, creature *who,
                 int anywhere,
                 int dest_z, int dest_x, int dest_y)
{
  if (wp == NULL)
    return 0;
  if (who == NULL)
    return 0;

  if (who->path_num <= 0)
    return 0;
  if ((who->path_now < 0) || (who->path_now + 1 >= who->path_num))
    return 0;
  if (who->path_z != who->z)
    return 0;
  if (who->path_x[who->path_now] != who->x)
    return 0;
  if (who->path_y[who->path_now] != who->y)
    return 0;

  if (anywhere)
    return 1;

  if (who->z != dest_z)
    return 0;
  if (who->path_x[who->path_num - 1] != dest_x)
    return 0;
  if (who->path_y[who->path_num - 1] != dest_y)
    return 0;

  return 1;
}

/* the destination must be the same floor
 * assumes that the current floor does not block a creature
 * return:
 *   0 if a path is found
 *   1 if the destination can not be reached
 *   2 on error
 */
static int
monster_set_path_1(world *wp, creature *who,
                   int dest_z, int dest_x, int dest_y)
{
  int x;
  int y;
  int n;
  int x0;
  int y0;
  int dx;
  int dy;
  int c_old;
  int c_new;
  int step;
  int next_x;
  int next_y;
  int found;
  int **step_map = NULL;

  if (wp == NULL)
    return 2;
  if (who == NULL)
    return 2;

  if ((dest_z == who->z)
      && (dest_x == who->x)
      && (dest_y == who->y))
    return 0;

  if (grid_is_illegal(wp, who->z, dest_x, dest_y))
  {
    fprintf(stderr, "monster_set_path_1: (%d, %d, %d) is illegal\n",
            who->z, dest_x, dest_y);
    return 2;
  }

  if (dest_z != who->z)
  {
    fprintf(stderr, "monster_set_path_1: not the same floor "
            "(dest_z = %d, who->z = %d)\n",
            dest_z, who->z);
    return 2;
  }

  step_map = wp->step_map_result;

  if (get_step_map(wp, step_map,
                   who->z, dest_x, dest_y,
                   who->x, who->y,
                   -1) != 0)
  {
    fprintf(stderr, "monster_set_path_1: get_step_map failed\n");
    return 2;
  }

  /* this fails if the current grid blocks a creature */
  if (step_map[who->x][who->y] < 0)
  {
    /* the destination can not be reached */
    return 1;
  }

  if (creature_append_path(who, who->x, who->y) != 0)
  {
    fprintf(stderr, "monster_set_path_1: creature_append_path "
            "before the loop failed\n");
    return 2;
  }

  found = 0;
  while (!found)
  {
    n = 0;
    x0 = who->path_x[who->path_num - 1];
    y0 = who->path_y[who->path_num - 1];
    step = step_map[x0][y0];
    next_x = x0;
    next_y = y0;
    for (dx = -1; dx <= 1; dx++)
    {
      for (dy = -1; dy <= 1; dy++)
      {
        if ((dx == 0) && (dy == 0))
          continue;
        if (found)
          break;
        x = x0 + dx;
        y = y0 + dy;
        if ((x == dest_x) && (y == dest_y))
        {
          found = 1;
          next_x = x;
          next_y = y;
          break;
        }
        if (step_map[x][y] < 0)
          continue;
        if (step_map[x][y] >= step)
          continue;
        n++;
        if (n >= 2)
        {
          /* avoid cardinal directions if possible */
          c_old = cardinal_direction(next_x, next_y, dest_x, dest_y);
          c_new = cardinal_direction(x, y, dest_x, dest_y);

          /* the exception is when we are very close
           * --- we want to fill all 8 adjacent grids
           */
          if (distance(x0, y0, dest_x, dest_y) <= 2)
          {
            /* let c_new == c_old to choose the next grid randomly
             * the value used here is arbitrary
             */
            c_old = -1;
            c_new = -1;
          }

          if (c_new > c_old)
            continue;
          if ((c_new == c_old) && (rand() % n != 0))
            continue;
        }
        next_x = x;
        next_y = y;
      }
    }
    /* found must be checked here because the destination does not
     * increment n
     */
    if ((!found) && (n == 0))
      break;
    if (creature_append_path(who, next_x, next_y) != 0)
    {
      fprintf(stderr, "monster_set_path_1: creature_append_path failed\n");
      return 2;
    }
  }

  if (!found)
  {
    fprintf(stderr, "monster_set_path_1: not found\n");
    return 2;
  }

  /* we have found a path to a new grid, consider climbimg the stair
   * at the destination
   * this is necessary when we are on some stair and the next stair is
   * adjacent to us
   */
  who->decision_flag &= ~DCSN_NO_MORE_STAIR;
  who->timer_stuck = 5;

  return 0;
}

/* if the destination is on the current floor, set the path to it
 * otherwise, set the path to an appropriate stair
 * assumes that the current floor does not block a creature
 * return:
 *   0 if a path is found
 *   1 if the destination can not be reached
 *   2 on error
 */
static int
monster_set_path(world *wp, creature *who,
                 int dest_z, int dest_x, int dest_y)
{
  int x;
  int y;
  int n;
  int good;
  int stair_x;
  int stair_y;

  if (wp == NULL)
    return 2;
  if (who == NULL)
    return 2;
  if ((who->z < 0) || (who->z >= wp->size_z))
    return 2;

  who->path_z = who->z;
  who->path_num = 0;
  who->path_now = 0;

  if (dest_z == who->z)
    return monster_set_path_1(wp, who,
                              dest_z, dest_x, dest_y);

  /* the destination is not the current floor, find a stair */

  /* no need to find another stair if we are on a good stair
   * do not remove DCSN_NO_MORE_STAIR here, or we climb the same
   * stair every turn if the last known position is a stair
   */
  switch (wp->grid[who->z][who->x][who->y] & GRID_TERRAIN_MASK)
  {
  case GR_STAIR_DOWN_0:
  case GR_STAIR_DOWN_1:
  case GR_STAIR_DOWN_2:
  case GR_STAIR_DOWN_3:
    if (dest_z > who->z)
    {
      return 0;
    }
    break;
  case GR_STAIR_UP_0:
  case GR_STAIR_UP_1:
  case GR_STAIR_UP_2:
  case GR_STAIR_UP_3:
    if (dest_z < who->z)
    {
      return 0;
    }
    break;
  default:
    break;
  }

  n = 0;
  stair_x = who->x;
  stair_y = who->y;
  for (x = 0; x < wp->size_x; x++)
  {
    for (y = 0; y < wp->size_y; y++)
    {
      good = 0;
      switch (wp->grid[who->z][x][y] & GRID_TERRAIN_MASK)
      {
      case GR_STAIR_DOWN_0:
      case GR_STAIR_DOWN_1:
      case GR_STAIR_DOWN_2:
      case GR_STAIR_DOWN_3:
        if (dest_z > who->z)
          good = 1;
        break;
      case GR_STAIR_UP_0:
      case GR_STAIR_UP_1:
      case GR_STAIR_UP_2:
      case GR_STAIR_UP_3:
        if (dest_z < who->z)
          good = 1;
        break;
      default:
        break;
      }
      if (!good)
        continue;

      n++;
      if (rand() % n == 0)
      {
        stair_x = x;
        stair_y = y;
      }
    }
  }

  if (n <= 0)
    return 1;

  return monster_set_path_1(wp, who,
                            who->z, stair_x, stair_y);
}

int
monster_shout(world *wp, creature *who)
{
  int i;
  struct creature_detail crd;
  char buf[128];

  if (wp == NULL)
  {
    fprintf(stderr, "monster_shout: wp is NULL\n");
    return 1;
  }
  if (who == NULL)
  {
    fprintf(stderr, "monster_shout: who is NULL\n");
    return 1;
  }

  if (creature_is_dead(wp, wp->player_id))
    return 0;

  creature_detail_get(who->type, &crd);
  sprintf(buf, "%s shouts", crd.name);
  add_log(wp, buf);

  for (i = 0; i < wp->cr_size; i++)
  {
    if (i == wp->player_id)
      continue;
    if (creature_is_dead(wp, i))
      continue;
    if (wp->cr[i]->z != who->z)
      continue;
    if (distance(wp->cr[i]->x, wp->cr[i]->y,
                 who->x, who->y) > 10)
      continue;

    monster_set_attitude(wp, wp->cr[i], ATTITUDE_MONSTER_ACTIVE);
  }

  /* update the last known position even if we don't see the player */
  monster_update_last_known(wp);

  return 0;
}

int
monster_set_attitude(world *wp, creature *who, int attitude)
{
  if (wp == NULL)
  {
    fprintf(stderr, "monster_set_attitude: wp is NULL\n");
    return 1;
  }
  if (who == NULL)
  {
    fprintf(stderr, "monster_set_attitude: who is NULL\n");
    return 1;
  }

  if (who->id == wp->player_id)
  {
    fprintf(stderr, "monster_set_attitude: who is player\n");
    return 1;
  }

  switch (attitude)
  {
  case ATTITUDE_MONSTER_UNINTERESTED:
    who->timer_attitude = 5 + (rand() % 5);
    break;
  case ATTITUDE_MONSTER_ACTIVE:
    who->timer_attitude = rand() % 5;
    break;
  default:
    fprintf(stderr, "monster_set_attitude: unknown attitude (%d)\n",
            attitude);
    return 1;
    break;
  }

  who->attitude = attitude;

  return 0;
}

int
monster_update_last_known(world *wp)
{
  creature *player = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "monster_update_last_known: wp is NULL\n");
    return 1;
  }

  if (creature_is_dead(wp, wp->player_id))
    return 0;
  player = wp->cr[wp->player_id];

  wp->last_known_z = player->z;
  wp->last_known_x = player->x;
  wp->last_known_y = player->y;

  return 0;
}

int
monster_forget_last_known(world *wp)
{
  int i;

  if (wp == NULL)
  {
    fprintf(stderr, "monster_forget_last_known: wp is NULL\n");
    return 1;
  }

  for (i = 0; i < wp->cr_size; i++)
  {
    if (i == wp->player_id)
      continue;
    if (creature_is_dead(wp, i))
      continue;

    if (wp->cr[i]->attitude == ATTITUDE_MONSTER_ACTIVE)
    {
      monster_set_attitude(wp, wp->cr[i], ATTITUDE_MONSTER_UNINTERESTED);
    }
  }

  wp->last_known_z = -1;
  wp->last_known_x = -1;
  wp->last_known_y = -1;

  return 0;
}

static int
monster_alert_here(world *wp,
                   int target_z, int target_x, int target_y)
{
  int i;

  if (wp == NULL)
    return 1;

  for (i = 0; i < wp->cr_size; i++)
  {
    if (i == wp->player_id)
      continue;
    if (creature_is_dead(wp, i))
      continue;
    if (wp->cr[i]->z != target_z)
      continue;
    if (wp->cr[i]->x != target_x)
      continue;
    if (wp->cr[i]->y != target_y)
      continue;

    monster_set_attitude(wp, wp->cr[i], ATTITUDE_MONSTER_ACTIVE);
  }

  return 0;
}

static int
monster_wander(world *wp, creature *who)
{
  int x;
  int y;
  int dx;
  int dy;
  int n;
  int found;
  int target_x;
  int target_y;
  int **step_map = NULL;

  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  step_map = wp->step_map_result;

  if (get_step_map(wp, step_map,
                   who->z, who->x, who->y,
                   -1, -1,
                   3) != 0)
  {
    fprintf(stderr, "monster_wander: get_step_map failed\n");
    array2_delete(step_map, wp->size_x, wp->size_y);
    step_map = NULL;
    return 1;
  }

  n = 0;
  found = 0;
  target_x = -1;
  target_y = -1;
  for (dx = -3; dx <= 3; dx++)
  {
    for (dy = -3; dy <= 3; dy++)
    {
      if ((dx == 0) && (dy == 0))
        continue;

      x = who->x + dx;
      y = who->y + dy;

      if (grid_is_illegal(wp, who->z, x, y))
        continue;
      if (grid_blocks_creature(wp, who->z, x, y))
        continue;
      if (step_map[x][y] < 0)
        continue;

      found = 1;
      n++;
      if (rand() % n == 0)
      {
        target_x = x;
        target_y = y;
      }
    }
  }

  if (found)
  {
    if (monster_set_path(wp, who,
                         who->z, target_x, target_y) == 0)
    {
      /* do not climb stair when wandering */
      who->decision_flag |= DCSN_NO_MORE_STAIR;

      monster_set_attitude(wp, who, ATTITUDE_MONSTER_UNINTERESTED);
    }
    else
    {
      who->timer_attitude = 9999;
    }

    /* skip this turn */
    monster_do_nothing(wp, who);
  }
  else
  {
    who->timer_attitude = 9999;
  }

  return 0;
}

static int
action_decide_monster_1(world *wp, creature *who)
{
  int i;
  int clearness;
  int on_stair;
  int target_x;
  int target_y;
  struct creature_detail crd;
  creature *player = NULL;

  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  creature_detail_get(who->type, &crd);

  /* if the player is dead, do nothing */
  if (creature_is_dead(wp, wp->player_id))
  {
    monster_do_nothing(wp, who);
    return 0;
  }
  player = wp->cr[wp->player_id];

  /* if the player wins the game, do nothing */
  if (wp->victory)
  {
    monster_do_nothing(wp, who);
    return 0;
  }

  /* if we are in an illegal grid, do nothing */
  if (grid_is_illegal(wp, who->z, who->x, who->y))
  {
    monster_do_nothing(wp, who);
    return 0;
  }

  /* if we begin post-move attack, we have little choice */
  if (wp->turn_state != TURN_STATE_NORMAL)
  {
    if ((who->z == player->z)
        && distance(who->x, who->y, player->x, player->y) <= 1)
    {
      who->act[0] = ACTION_WALK;
      who->act[1] = player->x - who->x;
      who->act[2] = player->y - who->y;
      return 0;
    }

    monster_do_nothing(wp, who);
    return 0;
  }

  /* see if we are on a stair */
  on_stair = grid_is_stair(wp, who->z, who->x, who->y);

  /* no need to climb stair if we are wandering */
  if (who->attitude != ATTITUDE_MONSTER_UNINTERESTED)
  {  
    if (!on_stair)
    {
      /* not on a stair, consider climbing later */
      who->decision_flag &= ~DCSN_NO_MORE_STAIR;
    }
  }

  /* Do we see the player? */
  clearness = creature_sees_grid(wp, who->id,
                                 player->z, player->x, player->y);

  /* update the last known position */
  switch (who->attitude)
  {
  case ATTITUDE_MONSTER_UNINTERESTED:
    if (clearness > 0)
    {
      who->attitude = ATTITUDE_MONSTER_ACTIVE;
      monster_update_last_known(wp);
    }
    break;
  case ATTITUDE_MONSTER_ACTIVE:
    if (clearness > 0)
    { 
      monster_update_last_known(wp);
    }
    break;
  default:
    break;
  }

  /* if an action is already ordered, do it */
  if (who->act[0] != 0)
  {
    if (action_check(wp, who->id, who->act))
      return 0;

    /* not a valid order, forget it */
    for (i = 0; i < ACT_SIZE; i++)
      who->act[i] = 0;
  }

  /* if we are active, update the path to the last known position
   * if the last known position is not on the current floor,
   * we choose a random stair and sticks to it
   */
  if ((who->attitude == ATTITUDE_MONSTER_ACTIVE)
      && (!grid_is_illegal(wp,
                           wp->last_known_z,
                           wp->last_known_x,
                           wp->last_known_y))
      && (!monster_has_path(wp, who,
                            0,
                            wp->last_known_z,
                            wp->last_known_x,
                            wp->last_known_y))
      && ((who->z == wp->last_known_z)
          || (!monster_has_path(wp, who,
                            1, -1, -1, -1))))
  {
    if (monster_set_path(wp, who,
                         wp->last_known_z,
                         wp->last_known_x,
                         wp->last_known_y) == 2)
    {
      fprintf(stderr, "action_decide_monster_1: monster_set_path failed\n");
      /* continue anyway */
    }
  }

  /* if we are active too long, stay sometimes */
  if (who->attitude == ATTITUDE_MONSTER_ACTIVE)
  {
    /* note that a combat against the player resets who->timer_attitude */
    (who->timer_attitude)++;
    if (who->timer_attitude > 10000001)
      who->timer_attitude = 10000001;
    /* we don't stay if the player is adjacent to us */
    if ((who->timer_attitude >= 20)
        && (who->timer_attitude % 2 == 0)
        && ((wp->last_known_z != who->z)
            || (distance(wp->last_known_x, wp->last_known_y,
                         who->x, who->y) > 1)))
    {
      monster_do_nothing(wp, who);
      return 0;
    }
  }

  /* if we have a path, follow it */
  if (monster_has_path(wp, who,
                       1,
                       -1, -1, -1))
  {
    target_x = who->path_x[who->path_now + 1];
    target_y = who->path_y[who->path_now + 1];

    who->act[0] = ACTION_WALK;
    who->act[1] = target_x - who->x;
    who->act[2] = target_y - who->y;

    if (action_check(wp, who->id, who->act))
    {
      /* This will break the path if we are still in the old position
       * after the action.  In this case, we have attacked the player,
       * we are now active and the path will be updated.
       */
      (who->path_now)++;

      who->timer_stuck = 5;

      return 0;
    }
    else
    {
      /* if we are active, the blocking monster becomes active */
      if (who->attitude == ATTITUDE_MONSTER_ACTIVE)
        monster_alert_here(wp,
                           who->z, target_x, target_y);

      /* if we are waiting too long, forget the path */
      (who->timer_stuck)--;
      if (who->timer_stuck <= 0)
      {
        who->timer_stuck = 0;

        who->path_num = 0;
        who->path_now = 0;

        who->decision_flag |= DCSN_NO_MORE_STAIR;

        /* If we are active, keep active.  Probably the player is
         * completely surrounded by us.
         */
      }

      /* probably the path is blocked by other monsters
       * wait until they move
       */
      monster_do_nothing(wp, who);
      return 0;
    }
  }

  /* the path is not valid or we are at the destination
   * forget the path
   * don't set DCSN_NO_MORE_STAIR here
   */
  who->path_num = 0;
  who->path_now = 0;

  /* if we are on a stair, climb it if not tried yet */
  if (on_stair)
  {
    if ((who->decision_flag & DCSN_NO_MORE_STAIR) == 0)
    {  
      who->act[0] = ACTION_CLIMB_STAIR;
      if (action_check(wp, who->id, who->act))
      {
        /* note that DCSN_NO_MORE_STAIR may be removed
         * in action_exec_climb_stair() if the stair is blocked
         */
        who->decision_flag |= DCSN_NO_MORE_STAIR;

        return 0;
      }
      /* should not happen, continue anyway */
      for (i = 0; i < ACT_SIZE; i++)
        who->act[i] = 0;
    }
  }

  /* if we reach here, get bored */
  switch (who->attitude)
  {
  case ATTITUDE_MONSTER_UNINTERESTED:
    /* we want to move to another grid if we are on a stair */
    if (on_stair)
      who->timer_attitude = 0;

    (who->timer_attitude)--;
    if (who->timer_attitude <= 0)
    {
      who->timer_attitude = 0;

      /* if we are far from the home position, sometimes return
       * if we are are not on the home floor and we are on a stair,
       * don't consider returning because maybe we have just climbed
       * the stair
       */
      if (((who->decision_flag & DCSN_NO_MORE_HOME) == 0)
          && (((who->z != who->home_z) && (!on_stair))
              || ((who->z == who->home_z)
                  && (distance(who->x, who->y,
                               who->home_x, who->home_y) > 12)))
          && (rand() % 2 == 0))
      {
        if (monster_set_path(wp, who,
                             who->home_z, who->home_x, who->home_y) != 0)
          who->decision_flag |= DCSN_NO_MORE_HOME;

        /* skip this turn */
        monster_do_nothing(wp, who);
        return 0;
      }

      /* sometimes wander */
      /* no need to wander if we are far from player */
      if ((who->z >= player->z - 1) && (who->z <= player->z + 1))
      {
        monster_wander(wp, who);
        return 0;
      }

      monster_do_nothing(wp, who);
      return 0;
    }
    break;
  case ATTITUDE_MONSTER_ACTIVE:
    monster_forget_last_known(wp);
    /* skip this turn */
    monster_do_nothing(wp, who);
    return 0;
    break;
  default:
    break;
  }

  /* if we reach here, we have nothing to do */
  monster_do_nothing(wp, who);

  return 0;
}

int
action_decide_monster(world *wp, int creature_id)
{
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "action_decide_monster: wp is NULL\n");
    return 1;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "action_decide_monster: strange creature_id (%d)\n",
            creature_id);
    return 1;
  }
  if (creature_id == wp->player_id)
  {
    fprintf(stderr, "action_decide_monster: creature %d is player\n",
            creature_id);
    return 1;
  }

  if (creature_is_dead(wp, creature_id))
    return 0;
  who = wp->cr[creature_id];

  action_decide_monster_1(wp, who);
  
  if (!action_check(wp, who->id, who->act))
  {
    monster_do_nothing(wp, who);
  }

  return 0;
}

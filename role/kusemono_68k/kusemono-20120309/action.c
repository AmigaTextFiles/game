#include <stdio.h>
/* free */
#include <stdlib.h>

#include "world.h"
#include "creature.h"
#include "dungeon.h"
#include "save.h"
#include "creature-detail.h"
#include "enchantment-detail.h"
#include "grid-detail.h"
#include "monster.h"
#include "magic-device.h"

#include "action.h"

static int attack_creature_here(world *wp, int attacker_id,
                                int z, int x, int y);
static int action_exec_walk(world *wp, creature *who);
static int action_exec_save(world *wp, creature *who);
static int action_exec_climb_stair(world *wp, creature *who);
static int action_exec_toggle_search_run(world *wp, creature *who);
static int action_exec_quaff_potion_bag(world *wp, creature *who);
static int action_exec_read_spellbook_swap_position(world *wp,
                                                    creature *who);
static int action_exec_zap_rod_mana_ball(world *wp, creature *who);

/* return the number of free runs allowed */
int
successive_run_max(world *wp, int creature_id)
{
  struct creature_detail crd;
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "successive_run_max: wp is NULL\n");
    return 0;
  }

  if (creature_is_dead(wp, creature_id))
    return 0;
  who = wp->cr[creature_id];
  creature_detail_get(who->type, &crd);

  if (who->id == wp->player_id)
  {
    if (wp->player_is_damaged)
      return 0;
    if (who->attitude == ATTITUDE_PLAYER_RUNNING)
      return 2;

    return 0;
  }

  if ((who->attitude == ATTITUDE_MONSTER_ACTIVE)
      && (who->hp >= crd.max_hp))
    return 1;

  return 0;
}

/* return 0 on success, 1 on error */
static int
attack_creature_here(world *wp, int attacker_id,
                     int z, int x, int y)
{
  int i;
  int dam;
  struct creature_detail crd_attacker;
  struct creature_detail crd_target;
  char buf[128];

  if (wp == NULL)
    return 1;
  if ((attacker_id < 0) || (attacker_id >= wp->cr_size))
    return 1;
  if (wp->cr[attacker_id] == NULL)
    return 1;
  if (grid_is_illegal(wp, z, x, y))
    return 1;

  creature_detail_get(wp->cr[attacker_id]->type, &crd_attacker);

  /* if we are trying to attack the player, notice the player */
  if ((attacker_id != wp->player_id)
      && (!creature_is_dead(wp, wp->player_id))
      && (wp->cr[wp->player_id]->z == z)
      && (wp->cr[wp->player_id]->x == x)
      && (wp->cr[wp->player_id]->y == y))
  {
    monster_set_attitude(wp, wp->cr[attacker_id], ATTITUDE_MONSTER_ACTIVE);

    monster_update_last_known(wp);
  }

  dam = crd_attacker.power_melee;

  if (dam <= 0)
    return 0;

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

    creature_detail_get(wp->cr[i]->type, &crd_target);

    if ((attacker_id == wp->player_id)
        && (wp->cr[i]->attitude != ATTITUDE_MONSTER_ACTIVE))
    {
      sprintf(buf, "%s stabs %s",
              crd_attacker.name,
              crd_target.name);
      add_log(wp, buf);
      creature_take_damage(wp, i, wp->cr[i]->hp, attacker_id, 0, 1);
    }
    else
    {  
      sprintf(buf, "%s hits %s",
              crd_attacker.name,
              crd_target.name);
      add_log(wp, buf);
      creature_take_damage(wp, i, dam, attacker_id, 0, 0);
    }
  }

  return 0;
}

/* return 1 if the action is legal, 0 otherwise */
int
action_check(world *wp, int creature_id, int *act)
{
  int x;
  int y;
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "action_check: wp is NULL\n");
    return 0;
  }
  if (act == NULL)
  {
    fprintf(stderr, "action_check: act is NULL\n");
    return 0;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "action_check: strange creature_id (%d)\n",
            creature_id);
    return 0;
  }

  if (creature_is_dead(wp, creature_id))
    return 0;
  who = wp->cr[creature_id];

  if (act[0] == 0)
    return 0;

  switch(act[0])
  {
  case ACTION_STAY:
    if (who->successive_run > 0)
      return 0;
    return 1;
    break;
  case ACTION_WALK:
    /* act
     * [1]: dx
     * [2]: dy
     */
    if ((act[1] == 0) && (act[2] == 0))
      return 1;
    if ((act[1] < -1) || (act[1] > 1))
      return 0;
    if ((act[2] < -1) || (act[2] > 1))
      return 0;
    x = who->x + act[1];
    y = who->y + act[2];
    if (grid_is_illegal(wp, who->z, x, y))
      return 0;
    if ((grid_blocks_creature(wp, who->z, x, y))
        && (!grid_has_enemy(wp, who->z, x, y, who->id)))
      return 0;
    /* do not check who->successive_run here --- a creature
     * can change its mode while running
     */
    return 1;
    break;
  case ACTION_SAVE:
    if (who->id == wp->player_id)
      return 1;
    return 0;
    break;
  case ACTION_CLIMB_STAIR:
    if (!find_stair_destination(wp,
                                who->z, who->x, who->y,
                                NULL, NULL, NULL))
      return 0;
    /* assumes that there is no friendly non-player creature */
    return 1;
    break;
  case ACTION_TOGGLE_SEARCH_RUN:
    if (who->id == wp->player_id)
      return 1;
    return 0;
    break;
  case ACTION_QUAFF_POTION_BAG:
    /* act
     * [1] potion type
     */
    if (who->id != wp->player_id)
      return 0;
    if (wp->player_shield <= 0)
      return 0;
    return 1;
    break;
  case ACTION_READ_SPELLBOOK_SWAP_POTISION:
    /* act
     * [1] target x
     * [2] target y
     */
    if (who->id != wp->player_id)
      return 0;
    if (wp->player_shield <= 0)
      return 0;
    if ((who->x == act[1]) && (who->y == act[2]))
      return 0;
    return 1;
    break;
  case ACTION_ZAP_ROD_MANA_BALL:
    /* act
     * [1] dx
     * [2] dy
     */
    if (who->id != wp->player_id)
      return 0;
    if (wp->player_shield <= 0)
      return 0;
    if ((act[1] < -1) || (act[1] > 1)
        || (act[2] < -1) || (act[2] > 1))
      return 0;
    return 1;
    break;
  default:
    return 0;
    break;
  }

  fprintf(stderr, "action_check: should not reach here\n");
  return 0;
}

/*
 * these action_exec_* functions assume that the action is legal
 *
 */

/* return:
 *   0 if you attack or skip your turn
 *   1 if you actually walk
 *   2 on error
 */
static int
action_exec_walk(world *wp, creature *who)
{
  int x;
  int y;
  int occupied;

  if (wp == NULL)
    return 2;
  if (who == NULL)
    return 2;

  if ((who->act[1] == 0) && (who->act[2] == 0))
  {
    return 0;
  }

  x = who->x + who->act[1];
  y = who->y + who->act[2];

  occupied = 0;
  if (grid_blocks_creature(wp, who->z, x, y))
    occupied = 1;
  if (grid_has_creature(wp, who->z, x, y))
    occupied = 1;

  if (!occupied)
  {
    creature_change_xy(wp, who->id, x, y);
    return 1;
  }
  else
  {
    attack_creature_here(wp, who->id, who->z, x, y);
    return 0;
  }

  /* should not reach here */
  return 0;
}

static int
action_exec_save(world *wp, creature *who)
{
  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  if (save_game(wp) == 0)
  {
    add_log(wp, "game saved successfully");
    wp->should_quit = 1;
  }
  else
  {
    add_log(wp, "game save FAILED");
  }

  return 0;
}

static int
action_exec_climb_stair(world *wp, creature *who)
{
  int i;
  int found_player;
  int found_us;
  int dest_z;
  int dest_x;
  int dest_y;
  int player_know;
  int player_see;
  struct creature_detail crd_you;
  char buf[128];
  const char *s = NULL;

  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  if (!find_stair_destination(wp,
                              who->z, who->x, who->y,
                              &dest_z, &dest_x, &dest_y))
    return 1;

  creature_detail_get(who->type, &crd_you);

  player_know = 0;
  player_see = 0;
  if (creature_is_dead(wp, wp->player_id))
  {
    player_know = 1;
    player_see = 1;
  }
  else
  {
    if ((creature_sees_grid(wp, wp->player_id,
                            who->z, who->x, who->y))
        || (creature_sees_grid(wp, wp->player_id,
                               dest_z, dest_x, dest_y)))
    {
      player_know = 1;
      player_see = 1;
    }
    if ((player_searches_grid(wp, who->z, who->x, who->y))
        || (player_searches_grid(wp, dest_z, dest_x, dest_y)))
    {
      player_know = 1;
    }
  }

  if (grid_has_creature(wp, dest_z, dest_x, dest_y))
  {
    if ((player_know) || (player_see))
    {
      s = crd_you.name;
      if (!player_see)
        s = "something";

      sprintf(buf, "%s tries to climb stair, but it is blocked", s);
      add_log(wp, buf);
    }

    if (who->id != wp->player_id)
    {
      /* assumes that the player is the only enemy */
      found_player = 0;
      if ((!creature_is_dead(wp, wp->player_id))
          && (wp->cr[wp->player_id]->z == dest_z)
          && (wp->cr[wp->player_id]->x == dest_x)
          && (wp->cr[wp->player_id]->y == dest_y))
        found_player = 1;

      /* see if others are also trying to climb this stair */
      found_us = 0;
      for (i = 0; i < wp->cr_size; i++)
      {
        if (creature_is_dead(wp, i))
          continue;
        if (i == wp->player_id)
          continue;
        if (wp->cr[i]->z != dest_z)
          continue;
        if (wp->cr[i]->x != dest_x)
          continue;
        if (wp->cr[i]->y != dest_y)
          continue;
        if (monster_has_path(wp, wp->cr[i],
                             1, -1, -1, -1))
          continue;
        if ((wp->cr[i]->decision_flag & DCSN_NO_MORE_STAIR)
            == DCSN_NO_MORE_STAIR)
          continue;
        found_us = 1;
        break;
      }
      if ((found_player) || (!found_us))
      { 
        /* consider climbing this stair again */
        who->decision_flag &= ~DCSN_NO_MORE_STAIR;
      }

      attack_creature_here(wp, who->id,
                           dest_z, dest_x, dest_y);
    }

    return 0;
  }

  if ((player_know) || (player_see))
  {
    s = crd_you.name;
    if (!player_see)
      s = "something";

    sprintf(buf, "%s enters B%dF", s, dest_z);
    add_log(wp, buf);
  }

  creature_change_z(wp, who->id, dest_z);
  creature_change_xy(wp, who->id, dest_x, dest_y);

  return 0;
}

static int
action_exec_toggle_search_run(world *wp, creature *who)
{
  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  if (who->attitude == ATTITUDE_PLAYER_SEARCHING)
    who->attitude = ATTITUDE_PLAYER_RUNNING;
  else
    who->attitude = ATTITUDE_PLAYER_SEARCHING;

  return 0;
}

static int
action_exec_quaff_potion_bag(world *wp, creature *who)
{
  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  quaff_potion_bag(wp, who->act[1]);

  return 0;
}

static int
action_exec_read_spellbook_swap_position(world *wp,
                                         creature *who)
{
  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  read_spellbook_swap_position(wp, who->act[1], who->act[2]);

  return 0;
}

static int
action_exec_zap_rod_mana_ball(world *wp, creature *who)
{
  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  zap_rod_mana_ball(wp, who->act[1], who->act[2]);

  return 0;
}

/* return the amount of time taken by the action */
int
action_exec(world *wp, int creature_id)
{
  int ut;
  int ut_taken;
  int i;
  int ret;
  struct creature_detail crd;
  char buf[128];
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "action_exec: wp is NULL\n");
    return 0;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "action_exec: strange creature_id (%d)\n",
            creature_id);
    return 0;
  }

  if (creature_is_dead(wp, creature_id))
    return 0;
  who = wp->cr[creature_id];
  creature_detail_get(who->type, &crd);

  ut = 2;
  ut_taken = 0;

  if (who->enchant_duration > 0)
  {
    switch (who->enchant_type)
    {
    case ENC_FAST:
      ut = (ut + 1) / 2;
      break;
    case ENC_SLOW:
      ut *= 2;
      break;
    default:
      break;
    }
  }

  if (ut < 1)
    ut = 1;

  if (who->act[0] == 0)
  {
    if (who->id == wp->player_id)
      return 0;

    sprintf(buf, "%s stops thinking", crd.name);
    add_log(wp, buf);
    return ut;
  }

  if (!action_check(wp, who->id, who->act))
  {
    sprintf(buf, "%s tries something illegal", crd.name);
    add_log(wp, buf);
    return ut;
  }

  switch(who->act[0])
  {
  case ACTION_STAY:
    ut_taken = ut;
    break;
  case ACTION_WALK:
    ut_taken = ut * 2;
    ret = action_exec_walk(wp, who);
    if ((ret == 1)
        && (who->successive_run < successive_run_max(wp, who->id)))
    {   
      ut_taken = 0;
      (who->successive_run)++;
      if (who->id == wp->player_id)
        who->timer_attitude = 0;
    }
    break;
  case ACTION_SAVE:
    ut_taken = 0;
    action_exec_save(wp, who);
    break;
  case ACTION_CLIMB_STAIR:
    ut_taken = ut * 2;
    action_exec_climb_stair(wp, who);
    break;
  case ACTION_TOGGLE_SEARCH_RUN:
    ut_taken = 0;
    action_exec_toggle_search_run(wp, who);
    break;
  case ACTION_QUAFF_POTION_BAG:
    ut_taken = ut * 2;
    action_exec_quaff_potion_bag(wp, who);
    break;
  case ACTION_READ_SPELLBOOK_SWAP_POTISION:
    ut_taken = ut;
    action_exec_read_spellbook_swap_position(wp, who);
    break;
  case ACTION_ZAP_ROD_MANA_BALL:
    ut_taken = ut * 2;
    action_exec_zap_rod_mana_ball(wp, who);
    break;
  default:
    sprintf(buf, "%s tries something undefined", crd.name);
    add_log(wp, buf);
    ut_taken = ut;
    break;
  }

  for (i = 0; i < 4; i++)
    who->act[i] = 0;

  return ut_taken;
}

#include <stdio.h>
/* free, abs */
#include <stdlib.h>

#include "world.h"
#include "creature.h"
#include "dungeon.h"
#include "save.h"
#include "creature-detail.h"
#include "grid-detail.h"
#include "monster.h"
#include "name.h"
#include "combat.h"
#include "util.h"
#include "post-move.h"

#include "action.h"

static int attack_creature_here(world *wp, int attacker_id,
                                int z, int x, int y);
static int prepare_post_move_attack(world *wp, creature *who);
static int action_exec_walk(world *wp, creature *who);
static int action_exec_save(world *wp, creature *who);
static int action_exec_climb_stair(world *wp, creature *who);
static int action_exec_pickup_weapon(world *wp, creature *who);
static int action_exec_drop_weapon(world *wp, creature *who);
static int action_exec_change_weapon(world *wp, creature *who);
static int action_exec_throw_weapon(world *wp, creature *who);
static int action_exec_polymorph_self(world *wp, creature *who);

/* return 0 on success, 1 on error */
static int
attack_creature_here(world *wp, int attacker_id,
                     int z, int x, int y)
{
  int i;

  if (wp == NULL)
    return 1;
  if ((attacker_id < 0) || (attacker_id >= wp->cr_size))
    return 1;
  if (creature_is_dead(wp, attacker_id))
    return 1;
  if (grid_is_illegal(wp, z, x, y))
    return 1;

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

    combat_exec(wp, attacker_id, i);
  }

  return 0;
}

/* return 1 if you begin post-move attack, 0 otherwise */
static int
prepare_post_move_attack(world *wp, creature *who)
{
  int i;
  int found;

  if (wp == NULL)
    return 0;
  if (who == NULL)
    return 0;

  if (!creature_can_post_move_attack(wp, who->id))
    return 0;
  if (wp->turn_state != TURN_STATE_NORMAL)
    return 0;

  found = 0;
  for (i = 0; i < wp->cr_size; i++)
  {
    if (creature_is_dead(wp, i))
      continue;
    if (wp->cr[i]->z != who->z)
      continue;
    if (abs(wp->cr[i]->x - who->x) > 1)
      continue;
    if (abs(wp->cr[i]->y - who->y) > 1)
      continue;
    if (get_creature_iff(wp, i) == get_creature_iff(wp, who->id))
      continue;

    found = 1;
    break;
  }

  if (found)
  {
    wp->turn_state = TURN_STATE_POST_MOVE;
    return 1;
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
    /* only the player can do this short stay
     * non-player creature must use ACTION_WALK (0, 0) instead
     */
    if (who->id != wp->player_id)
      return 0;
    if (wp->turn_state != TURN_STATE_NORMAL)
      return 0;
    return 1;
    break;
  case ACTION_WALK:
    /* act
     * [1] dx
     * [2] dy
     */
    /* you can always end your turn */
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
    if ((wp->turn_state != TURN_STATE_NORMAL)
        && (!grid_has_enemy(wp, who->z, x, y, who->id)))
      return 0;
    return 1;
    break;
  case ACTION_SAVE:
    if (who->id != wp->player_id)
      return 0;
    /* assumes that:
     * + the game begins with MODE_WAITING_FOR_ACTION
     * + post-move attack is done in MODE_WAITING_FOR_ACTION
     */
    return 1;
    break;
  case ACTION_CLIMB_STAIR:
    if (wp->turn_state != TURN_STATE_NORMAL)
      return 0;
    if (!find_stair_destination(wp,
                                who->z, who->x, who->y,
                                NULL, NULL, NULL))
      return 0;
    /* assumes that there is no friendly non-player creature */
    return 1;
    break;
  case ACTION_PICKUP_WEAPON:
    /* act
     * [1] weapon id
     * [2] dest_slot of player_sheath
     */
    if (wp->turn_state != TURN_STATE_NORMAL)
      return 0;
    if ((act[1] < 0) || (act[1] >= wp->itm_size))
      return 0;
    if (item_is_dead(wp, act[1]))
      return 0;
    if (wp->itm[act[1]]->where != ITEM_FLOOR)
      return 0;
    if (wp->itm[act[1]]->z != who->z)
      return 0;
    if (wp->itm[act[1]]->x != who->x)
      return 0;
    if (wp->itm[act[1]]->y != who->y)
      return 0;
    if (wp->itm[act[1]]->type != ITEM_TYPE_WEAPON)
      return 0;
    if (who->id == wp->player_id)
    {
      if ((act[2] < 0) || (act[2] >= 4))
        return 0;
      /* the player can drop a weapon and pick up another weapon
       * in one turn
       */
    }
    else
    {
      /* a monster must drop a weapon first before picking up
       * another weapon
       */
      if (who->weapon_id >= 0)
        return 0;
    }
    return 1;
    break;
  case ACTION_DROP_WEAPON:
    /* act
     * [1] weapon id
     */
    if (wp->turn_state != TURN_STATE_NORMAL)
      return 0;
    if ((act[1] < 0) || (act[1] >= wp->itm_size))
      return 0;
    if (item_is_dead(wp, act[1]))
      return 0;
    if (wp->itm[act[1]]->where != ITEM_SHEATH)
      return 0;
    if (wp->itm[act[1]]->owner != who->id)
      return 0;
    if (wp->itm[act[1]]->type != ITEM_TYPE_WEAPON)
      return 0;
    return 1;
    break;
  case ACTION_CHANGE_WEAPON:
    /* act
     * [1] new wielding slot
     */
    if (wp->turn_state != TURN_STATE_NORMAL)
      return 0;
    if (who->id != wp->player_id)
      return 0;
    /* if you change the wielding slot, you must choose a different slot
     * use ACTION_STAY or ACTION_WALK (0, 0) to do nothing and end your turn
     */
    if (act[1] == wp->player_weapon_slot)
      return 0;
    return 1;
    break;
  case ACTION_THROW_WEAPON:
    /* act
     * [1] weapon id
     * [2] dx
     * [3] dy
     */
    if (wp->turn_state != TURN_STATE_NORMAL)
      return 0;
    if (who->id != wp->player_id)
      return 0;
    if ((act[1] < 0) || (act[1] >= wp->itm_size))
      return 0;
    if (item_is_dead(wp, act[1]))
      return 0;
    if (wp->itm[act[1]]->type != ITEM_TYPE_WEAPON)
      return 0;
    if (wp->itm[act[1]]->where != ITEM_SHEATH)
      return 0;
    if (wp->itm[act[1]]->owner != who->id)
      return 0;
    if ((act[2] < -1) || (act[2] > 1))
      return 0;
    if ((act[3] < -1) || (act[3] > 1))
      return 0;
    if ((act[2] == 0) && (act[3] == 0))
      return 0;
    return 1;
    break;
  case ACTION_POLYMORPH_SELF:
    if (wp->turn_state != TURN_STATE_NORMAL)
      return 0;
    if (who->id != wp->player_id)
      return 0;
    if ((wp->last_kill_type < 0) || (wp->last_kill_type >= NUM_CREATURE))
      return 0;
    if (who->level < 0)
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
 *   0 if you skip your turn
 *   1 if you actually walk
 *   2 if you actually attack
 *   3 on error
 */
static int
action_exec_walk(world *wp, creature *who)
{
  int x;
  int y;
  int occupied;

  if (wp == NULL)
    return 3;
  if (who == NULL)
    return 3;

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
    return 2;
  }

  /* should not reach here */
  return 3;
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
  char *creature_name = NULL;
  char buf[128];

  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  if (!find_stair_destination(wp,
                              who->z, who->x, who->y,
                              &dest_z, &dest_x, &dest_y))
    return 1;

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
                            who->z, who->x, who->y) > 0)
        || (creature_sees_grid(wp, wp->player_id,
                               dest_z, dest_x, dest_y) > 0))
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
      if (!player_see)
        creature_name = concat_string(1, "something");
      else
        creature_name = get_creature_name(wp, who->id);

      if (creature_name == NULL)
      { 
        sprintf(buf, "NULL tries to climb stair, but it is blocked");
      }
      else
      { 
        sprintf(buf, "%s tries to climb stair, but it is blocked",
                creature_name);
      }
      add_log(wp, buf);

      if (creature_name != NULL)
      {
        free(creature_name);
        creature_name = NULL;
      }
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
    }

    attack_creature_here(wp, who->id,
                         dest_z, dest_x, dest_y);

    return 0;
  }

  if ((player_know) || (player_see))
  {
    if (!player_see)
      creature_name = concat_string(1, "something");
    else
      creature_name = get_creature_name(wp, who->id);

    if (creature_name == NULL)
      sprintf(buf, "NULL enters B%dF", dest_z);
    else
      sprintf(buf, "%s enters B%dF", creature_name, dest_z);
    add_log(wp, buf);

    if (creature_name != NULL)
    {
      free(creature_name);
      creature_name = NULL;
    }
  }

  creature_change_z(wp, who->id, dest_z);
  creature_change_xy(wp, who->id, dest_x, dest_y);

  return 0;
}

static int
action_exec_pickup_weapon(world *wp, creature *who)
{
  char *creature_name = NULL;
  char *weapon_name = NULL;
  char buf[128];

  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  if (who->id == wp->player_id)
  {
    if (wp->player_sheath[who->act[2]] >= 0)
    {
      creature_drop_item(wp, who->id, wp->player_sheath[who->act[2]], 1);
    }
  }

  if ((wp->player_id >= 0) && (wp->player_id < wp->cr_size)
      && (creature_sees_grid(wp, wp->player_id, who->z, who->x, who->y) > 0))
  {
    creature_name = get_creature_name(wp, who->id);
    weapon_name = get_item_name(wp, who->act[1], 0);
    if (creature_name == NULL)
    {
      sprintf(buf, "NULL picks up something");
    }
    else if (weapon_name == NULL)
    {
      sprintf(buf, "%s picks up NULL", creature_name);
    }
    else
    {
      sprintf(buf, "%s picks up %s", creature_name, weapon_name);
    }
    add_log(wp, buf);

    if (creature_name != NULL)
    {
      free(creature_name);
      creature_name = NULL;
    }
    if (weapon_name != NULL)
    {
      free(weapon_name);
      weapon_name = NULL;
    }
  }

  move_item(wp, who->act[1], ITEM_SHEATH, who->id,
            -1, -1, -1, who->act[2],
            1);

  return 0;
}

static int
action_exec_drop_weapon(world *wp, creature *who)
{
  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  creature_drop_item(wp, who->id, who->act[1], 1);

  return 0;
}

static int
action_exec_change_weapon(world *wp, creature *who)
{
  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  wp->player_weapon_slot = who->act[1];
  if ((wp->player_weapon_slot >= 0) && (wp->player_weapon_slot < 4))
  {
    wp->cr[wp->player_id]->weapon_id
      = wp->player_sheath[wp->player_weapon_slot];
  }
  else
  {
    wp->cr[wp->player_id]->weapon_id = -1;
  }
  add_wield_message(wp, who->id);

  return 0;
}

static int
action_exec_throw_weapon(world *wp, creature *who)
{
  int i;
  int j;
  int x;
  int y;
  int hit_something;
  item *what = NULL;
  creature *target = NULL;
  char *creature_name = NULL;
  char *item_name = NULL;
  char buf[128];

  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  what = wp->itm[who->act[1]];

  creature_name = get_creature_name(wp, who->id);
  item_name = get_item_name(wp, what->id, 0);

  if (creature_name == NULL)
  { 
    sprintf(buf, "NULL throws something");
  }
  else if (item_name == NULL)
  { 
    sprintf(buf, "%s throws NULL",
            creature_name);
  }
  else
  { 
    sprintf(buf, "%s throws %s",
            creature_name, item_name);
  }
  add_log(wp, buf);

  move_item(wp, what->id, ITEM_NOWHERE, -1,
            -1, -1, -1, -1,
            1);

  hit_something = 0;
  for (i = 1; i <= 8; i++)
  {
    x = who->x + who->act[2] * i;
    y = who->y + who->act[3] * i;
    for (j = 0; j < wp->cr_size; j++)
    {
      if (j == wp->player_id)
        continue;
      if (creature_is_dead(wp, j))
        continue;
      if (wp->cr[j]->z != who->z)
        continue;
      if (wp->cr[j]->x != x)
        continue;
      if (wp->cr[j]->y != y)
        continue;

      target = wp->cr[j];
      if ((target->weapon_id >= 0) && (target->weapon_id < wp->itm_size)
          && (!item_is_dead(wp, target->weapon_id)))
      {
        destroy_item(wp, target->weapon_id, 1);
      }
      move_item(wp, what->id, ITEM_SHEATH, target->id,
            -1, -1, -1, -1,
            1);
      what->thrown = 1;

      /* if we are hit by a thrown weapon, notice the player
       * note that the player may be out of our sight
       */
      if (target->id != wp->player_id)
        monster_set_attitude(wp, target, ATTITUDE_MONSTER_ACTIVE);

      hit_something = 1;
      break;
    }
    if (hit_something)
      break;

    if (grid_blocks_beam(wp, who->z, x, y))
      break;
  }

  if (!hit_something)
  {    
    i--;
    move_item(wp, what->id, ITEM_FLOOR, -1,
              who->z, who->x + who->act[2] * i, who->y + who->act[3] * i, -1,
              0);
  }

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

  return 0;
}

static int
action_exec_polymorph_self(world *wp, creature *who)
{
  struct creature_detail crd;
  char buf[128];

  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  creature_detail_get(wp->last_kill_type, &crd);
  sprintf(buf, "you change into %+d %s",
          who->level - POLYMORPH_SELF_LEVEL_COST,
          crd.name);
  add_log(wp, buf);

  who->type = wp->last_kill_type;
  who->level -= POLYMORPH_SELF_LEVEL_COST;
  wp->last_kill_type = -1;
  creature_heal_hp(wp, who->id, -1, 0);

  return 0;
}

/* return the amount of time taken by the action */
int
action_exec(world *wp, int creature_id)
{
  int ut;
  int ut_taken;
  int i;
  creature *who = NULL;
  char *creature_name = NULL;
  char buf[128];

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
  creature_name = get_creature_name(wp, who->id);

  ut = 2;
  ut_taken = 0;

  switch (who->type)
  {
  case CR_LEAD_GOLEM:
    ut *= 2;
    break;
  default:
    break;
  }

  if (ut < 1)
    ut = 1;

  if (who->act[0] == 0)
  {
    if (who->id == wp->player_id)
    {
      if (creature_name != NULL)
      {
        free(creature_name);
        creature_name = NULL;
      }
      return 0;
    }

    if (creature_name == NULL)
      sprintf(buf, "NULL stops thinking");
    else
      sprintf(buf, "%s stops thinking", creature_name);
    add_log(wp, buf);

    if (creature_name != NULL)
    {
      free(creature_name);
      creature_name = NULL;
    }
    return ut;
  }

  if (!action_check(wp, who->id, who->act))
  {
    if (creature_name == NULL)
      sprintf(buf, "NULL tries something illegal");
    else
      sprintf(buf, "%s tries something illegal", creature_name);
    add_log(wp, buf);

    if (creature_name != NULL)
    {
      free(creature_name);
      creature_name = NULL;
    }
    return ut;
  }

  switch(who->act[0])
  {
  case ACTION_STAY:
    ut_taken = ut;
    break;
  case ACTION_WALK:
    ut_taken = ut * 2;
    if (action_exec_walk(wp, who) == 1)
    {
      if (prepare_post_move_attack(wp, who) == 1)
      {
        ut_taken = 0;
      }
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
  case ACTION_PICKUP_WEAPON:
    ut_taken = ut * 2;
    action_exec_pickup_weapon(wp, who);
    break;
  case ACTION_DROP_WEAPON:
    ut_taken = ut * 2;
    action_exec_drop_weapon(wp, who);
    break;
  case ACTION_CHANGE_WEAPON:
    ut_taken = 0;
    action_exec_change_weapon(wp, who);
    break;
  case ACTION_THROW_WEAPON:
    ut_taken = ut * 2;
    action_exec_throw_weapon(wp, who);
    break;
  case ACTION_POLYMORPH_SELF:
    ut_taken = ut * 2;
    action_exec_polymorph_self(wp, who);
    break;
  default:
    if (creature_name == NULL)
      sprintf(buf, "NULL tries something undefined");
    else
      sprintf(buf, "%s tries something undefined", creature_name);
    add_log(wp, buf);
    ut_taken = ut;
    break;
  }

  for (i = 0; i < ACT_SIZE; i++)
    who->act[i] = 0;

  if (creature_name != NULL)
  {
    free(creature_name);
    creature_name = NULL;
  }

  return ut_taken;
}

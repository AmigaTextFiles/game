#include <stdio.h>
/* realloc, abs, rand */
#include <stdlib.h>

#include "world.h"
#include "creature.h"
#include "turn-order.h"
#include "util.h"
#include "creature-detail.h"
#include "grid-detail.h"
#include "digital-fov.h"
#include "enchantment-detail.h"
#include "array.h"
#include "monster.h"
#include "action.h"

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
add_priority_last(world *wp, int turn_order_id)
{
  list_int *pri = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "add_priority_last: wp is NULL\n");
    return 1;
  }
  if ((turn_order_id < 0) || (turn_order_id >= wp->tor_size))
  {
    fprintf(stderr, "add_priority_last: turn_order_id is out of range "
            "(%d)\n", turn_order_id);
    return 1;
  }

  pri = list_int_new(turn_order_id);
  if (pri == NULL)
  {
    fprintf(stderr, "add_priority_last: list_int_new failed\n");
    return 1;
  }
  pri->prev = NULL;
  pri->next = NULL;

  if (wp->priority_last == NULL)
  {
    if (wp->priority_first != NULL)
    {
      fprintf(stderr, "add_priority_last: wp->priority_first is not NULL\n");
      return 1;
    }

    wp->priority_first = pri;
    wp->priority_last = pri;

    return 0;
  }

  if (wp->priority_last->next != NULL)
  {
    fprintf(stderr, "add_priority_last: "
            "wp->priority_last->next is not NULL\n");
    return 1;
  }

  wp->priority_last->next = pri;
  pri->prev = wp->priority_last;

  wp->priority_last = pri;

  return 0;
}

/* this must not be called during a turn */
int
remove_priority(world *wp, list_int *pri)
{
  if (wp == NULL)
  {
    fprintf(stderr, "remove_priority: wp is NULL\n");
    return 1;
  }

  if (pri == NULL)
    return 0;

  if (pri == wp->priority_first)
  {
    wp->priority_first = pri->next;
  }
  if (pri == wp->priority_last)
  {
    wp->priority_last = pri->prev;
  }

  if (pri == wp->priority_now)
  {
    wp->priority_now = pri->next;
  }

  if (pri->next != NULL)
  {
    pri->next->prev = pri->prev;
  }
  if (pri->prev != NULL)
  {
    pri->prev->next = pri->next;
  }

  pri->next = NULL;
  pri->prev = NULL;

  list_int_delete_all(pri);
  pri = NULL;

  return 0;
}

/* this does _not_ add a corresponding priority */
int
add_turn_order_here(world *wp, turn_order *what, int n)
{
  if (wp == NULL)
  {
    fprintf(stderr, "add_turn_order_here: wp is NULL\n");
    return -1;
  }
  if (what == NULL)
  {
    fprintf(stderr, "add_turn_order_here: what is NULL\n");
    return -1;
  }
  if (n < 0)
  {
    fprintf(stderr, "add_turn_order_here: strange n (%d)\n", n);
    return -1;
  }

  while (n >= wp->tor_size)
  {
    if (world_expand_tor(wp) != 0)
    {
      fprintf(stderr, "add_turn_order_here: world_expand_tor failed\n");
      return -1;
    }
  }

  if (wp->tor[n] != NULL)
  {
    fprintf(stderr, "add_turn_order_here: tor[%d] is already used\n", n);
    return -1;
  }

  what->id = n;
  wp->tor[n] = what;

  return n;
}

/* this does _not_ add a corresponding priority */
int
add_turn_order(world *wp, turn_order *what)
{
  int i;
  int n;

  if (wp == NULL)
  {
    fprintf(stderr, "add_turn_order: wp is NULL\n");
    return -1;
  }
  if (what == NULL)
  {
    fprintf(stderr, "add_turn_order: what is NULL\n");
    return -1;
  }

  for (i = 0; i < wp->tor_size; i++)
  {
    if (wp->tor[i] == NULL)
      break;
  }

  n = add_turn_order_here(wp, what, i);
  if (n < 0)
  {
    fprintf(stderr, "add_turn_order: add_turn_order_here failed\n");
    return -1;
  }

  return n;
}

/* this does _not_ add a corresponding priority */
int
add_new_turn_order(world *wp, int type, int which, int wait)
{
  int n;
  turn_order *what = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "add_new_turn_order: wp is NULL\n");
    return -1;
  }
  if (wait < 0)
  {
    fprintf(stderr, "add_new_turn_order: wait is negative (%d)\n", wait);
    return -1;
  }

  what = turn_order_new();
  if (what == NULL)
  {
    fprintf(stderr, "add_new_turn_order: turn_order_new failed\n");
    return -1;
  }

  what->id = -1;
  what->type = type;
  what->which = which;
  what->wait = wait;

  n = add_turn_order(wp, what);
  if (n < 0)
  {
    fprintf(stderr, "add_new_turn_order: add_turn_order failed\n");
    turn_order_delete(what);
    what = NULL;
    return -1;
  }
  
  return n;
}

int
remove_turn_order(world *wp, int turn_order_id)
{
  turn_order *what = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "remove_turn_order: wp is NULL\n");
    return 1;
  }
  if ((turn_order_id < 0) || (turn_order_id >= wp->tor_size))
  {
    fprintf(stderr, "remove_turn_order: strange turn_order_id (%d)\n",
            turn_order_id);
    return 1;
  }
  if (wp->tor[turn_order_id] == NULL)
  {
    fprintf(stderr, "remove_turn_order: wp->tor[%d] is NULL\n",
            turn_order_id);
    return 1;
  }

  what = wp->tor[turn_order_id];

  wp->tor[turn_order_id] = NULL;
  what->id = -1;
  turn_order_delete(what);
  what = NULL;

  return 0;
}

/* this does _not_ add a corresponding turn order */
int
add_creature_here(world *wp, creature *who, int n)
{
  if (wp == NULL)
  {
    fprintf(stderr, "add_creature_here: wp is NULL\n");
    return -1;
  }
  if (who == NULL)
  {
    fprintf(stderr, "add_creature_here: who is NULL\n");
    return -1;
  }
  if (n < 0)
  {
    fprintf(stderr, "add_creature_here: strange n (%d)\n", n);
    return -1;
  }
  if (n == wp->player_id)
  {
    fprintf(stderr, "add_creature_here: n (%d) is for player\n", n);
    return -1;
  }

  while (n >= wp->cr_size)
  {
    if (world_expand_cr(wp) != 0)
    {  
      fprintf(stderr, "add_creature_here: world_expand_cr failed\n");
      return -1;
    }
  }

  if (wp->cr[n] != NULL)
  {
    fprintf(stderr, "add_creature_here: cr[%d] is already used\n", n);
    return -1;
  }

  who->id = n;
  wp->cr[n] = who;

  return n;
}

/* this does _not_ add a corresponding turn order */
int
add_creature(world *wp, creature *who)
{
  int i;

  if (wp == NULL)
  {
    fprintf(stderr, "add_creature: wp is NULL\n");
    return -1;
  }
  if (who == NULL)
  {
    fprintf(stderr, "add_creature: who is NULL\n");
    return -1;
  }

  for (i = 0; i < wp->cr_size; i++)
  {
    if ((i != wp->player_id) && (wp->cr[i] == NULL))
      break;
  }

  return add_creature_here(wp, who, i);
}

/* this does _not_ check if the creature can enter (z, x, y)
 * this also add a turn order and a priority for the creature
 * return
 *   the id of the creature (not the turn order) on success
 *   a negative value on error
 */
int
add_new_creature(world *wp, int type, int z, int x, int y, int wait)
{
  int creature_id;
  int turn_order_id;
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "add_new_creature: wp is NULL\n");
    return -1;
  }
  if (grid_is_illegal(wp, z, x, y))
  {
    fprintf(stderr, "add_new_creature: grid is illegal "
            "(%d, %d, %d)\n", z, x, y);
    return -1;
  }
  if (wait < 0)
  {
    fprintf(stderr, "add_new_creature: wait is negative (%d)\n", wait);
    return -1;
  }

  who = creature_new();
  if (who == NULL)
  {
    fprintf(stderr, "add_new_creature: creature_new failed\n");
    return -1;
  }

  who->id = -1;
  who->type = type;
  who->z = z;
  who->x = x;
  who->y = y;
  /* modified by creature_heal_hp() below */
  who->hp = 1;

  who->home_z = z;
  who->home_x = x;
  who->home_y = y;

  creature_id = add_creature(wp, who);
  if (creature_id < 0)
  {
    fprintf(stderr, "add_new_creature: add_creature failed\n");
    creature_delete(who);
    who = NULL;
    return -1;
  }

  turn_order_id = add_new_turn_order(wp, TURN_ORDER_CREATURE, who->id, wait);
  if (turn_order_id < 0)
  {
    fprintf(stderr, "add_creature: add_new_turn_order failed\n");
    remove_creature(wp, creature_id);
    return -1;
  }

  if (add_priority_last(wp, turn_order_id) != 0)
  {
    fprintf(stderr, "add_priority_last failed\n");
    remove_creature(wp, creature_id);
    return -1;
  }

  creature_heal_hp(wp, creature_id, -1, 0);

  return creature_id;
}

/* this also removes the corresponding turn order */
int
remove_creature(world *wp, int creature_id)
{
  int i;
  creature *who = NULL;
  list_int *pri = NULL;
  list_int *pri_next = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "remove_creature: wp is NULL\n");
    return 1;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "remove_creature: strange creature_id (%d)\n",
            creature_id);
    return 1;
  }
  if (wp->cr[creature_id] == NULL)
  {
    fprintf(stderr, "remove_creature: wp->cr[%d] is NULL\n", creature_id);
    return 1;
  }

  who = wp->cr[creature_id];

  pri = wp->priority_first;
  while (pri != NULL)
  {
    pri_next = pri->next;

    if ((wp->tor[pri->n] != NULL)
        && (wp->tor[pri->n]->type == TURN_ORDER_CREATURE)
        && (wp->tor[pri->n]->which == who->id))
    {
      remove_priority(wp, pri);
      pri = NULL;
    }

    pri = pri_next;
  }

  for (i = 0; i < wp->tor_size; i++)
  {
    if (wp->tor[i] == NULL)
      continue;
    if (wp->tor[i]->type != TURN_ORDER_CREATURE)
      continue;
    if (wp->tor[i]->which == who->id)
      remove_turn_order(wp, i);
  }

  wp->cr[creature_id] = NULL;
  who->id = -1;
  creature_delete(who);
  who = NULL;

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
  if (wp->cr[creature_id]->hp <= 0)
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
  int c;
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
  c = cardinal_direction(x, y, who->x, who->y);

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
  if ((c <= 0) && (d > 5))
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
    if (c > 0)
    {
      if (d <= 5)
        return 3;
      return 2;
    }
    if (d <= 3)
      return 2;
    return 1;
  }

  return 0;
}

int
player_searches_grid(world *wp, int z, int x, int y)
{
  int d;
  creature *player = NULL;

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
  player = wp->cr[wp->player_id];

  if (player->attitude != ATTITUDE_PLAYER_SEARCHING)
    return 0;

  if (z != wp->camera_z)
    return 0;

  d = distance(x, y, wp->camera_x, wp->camera_y);
  if ((d > 8) || (d > player->timer_attitude * 2))
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
  if (creature_is_dead(wp, creature_id))
    return CREATURE_IFF_UNKNOWN;

  return CREATURE_IFF_HOSTILE;
}

int
creature_take_damage(world *wp, int target_id, int dam,
                     int attacker_id, int verbose, int ignore_shield)
{
  int d;
  int target_iff;
  int attacker_iff;
  struct creature_detail crd_target;
  struct creature_detail crd_attacker;
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

  creature_detail_get(wp->cr[target_id]->type, &crd_target);
  /* get_creature_iff() must be called before the damage is dealt
   * because a dead non-player creature can never be friendly
   */
  target_iff = get_creature_iff(wp, target_id);
  /* attacker_id can be negative */
  if ((attacker_id < 0) || (attacker_id >= wp->cr_size))
  {
    attacker_iff = CREATURE_IFF_UNKNOWN;
  }
  else
  {
    attacker_iff = get_creature_iff(wp, attacker_id);
  }

  if (verbose)
  {
    sprintf(buf, "%s is damaged", crd_target.name);
    add_log(wp, buf);
  }

  if (target_id == wp->player_id)
    wp->player_is_damaged = 1;

  d = dam;

  if ((!ignore_shield)
      && (target_id == wp->player_id))
  {
    if (wp->player_shield >= d)
    {
      wp->player_shield -= d;
      d = 0;
    }
    else if (wp->player_shield > 0)
    {
      d -= wp->player_shield;
      wp->player_shield = 0;
    }
  }

  if (d > 0)
    wp->cr[target_id]->hp -= d;

  if (creature_is_dead(wp, target_id))
  {
    if ((attacker_id < 0)
        || (attacker_id >= wp->cr_size)
        || (wp->cr[attacker_id] == NULL))
    {
      sprintf(buf, "%s dies", crd_target.name);
      add_log(wp, buf);
    }
    else
    {
      creature_detail_get(wp->cr[attacker_id]->type, &crd_attacker);
      sprintf(buf, "%s kills %s",
              crd_attacker.name, crd_target.name);
      add_log(wp, buf);

      if ((attacker_iff == CREATURE_IFF_FRIENDLY)
          && (!target_iff != CREATURE_IFF_FRIENDLY))
      {
        /* recharge by kill */
        wp->player_shield = PLAYER_SHIELD_MAX;
      }
    }

    if (target_id != wp->player_id)
    {
      /* we can be killed while we are concerned */
      wp->global_decision_flag &= ~GLOBAL_DSCN_NO_MORE_SEARCH;
    }
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
        monster_shout(wp, wp->cr[target_id]);
      }
      else
      {
        monster_set_attitude(wp, wp->cr[target_id], ATTITUDE_MONSTER_LOST);
      }
    }
  }

  return 0;
}

/* set amount (arg 3) to negative for full healing */
int
creature_heal_hp(world *wp, int target_id, int amount, int verbose)
{
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

  if (amount < 0)
    wp->cr[target_id]->hp = crd.max_hp;
  else
    wp->cr[target_id]->hp += amount;

  if (wp->cr[target_id]->hp > crd.max_hp)
    wp->cr[target_id]->hp = crd.max_hp;

  if (verbose)
  {
    sprintf(buf, "%s feels better", crd.name);
    add_log(wp, buf);
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
                                 who->z, who->x, who->y))
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

  return 0;
}

int
creature_teleport(world *wp, int creature_id)
{
  int i;
  int x;
  int y;
  int found;
  struct creature_detail crd;
  char buf[128];
  creature *who = NULL;

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

  creature_detail_get(who->type, &crd);
  sprintf(buf, "%s teleports", crd.name);
  add_log(wp, buf);

  creature_change_xy(wp, who->id, x, y);

  return 0;
}

int
creature_add_enchantment(world *wp, int creature_id,
                         int type, int duration)
{
  struct creature_detail crd;
  char buf[128];
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "creature_add_enchantment: wp is NULL\n");
    return 1;
  }

  if (creature_is_dead(wp, creature_id))
    return 0;
  who = wp->cr[creature_id];
  creature_detail_get(who->type, &crd);

  if (who->enchant_type == type)
  {
    if (who->enchant_duration < duration)
      who->enchant_duration = duration;
    return 0;
  }

  sprintf(buf, "%s gets enchantment of %s", crd.name,
          enchantment_name(type));
  add_log(wp, buf);
  who->enchant_type = type;
  who->enchant_duration = duration;

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

  queue = array2_new(wp->size_x * wp->size_y, 2);
  if (queue == NULL)
  {
    fprintf(stderr, "get_step_map: array2_new(queue) failed\n");
    return 1;
  }
  queue_next = array2_new(wp->size_x * wp->size_y, 2);
  if (queue_next == NULL)
  {
    fprintf(stderr, "get_step_map: array2_new(queue_next) failed\n");
    array2_delete(queue, wp->size_x * wp->size_y, 2);
    queue = NULL;
    return 1;
  }

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

  array2_delete(queue, wp->size_x * wp->size_y, 2);
  queue = NULL;
  array2_delete(queue_next, wp->size_x * wp->size_y, 2);
  queue_next = NULL;

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

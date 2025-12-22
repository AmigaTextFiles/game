#include <stdio.h>
/* realloc, abs, rand */
#include <stdlib.h>

#include "world.h"
#include "creature.h"
#include "turn-order.h"
#include "list-int.h"
#include "dungeon.h"

#include "dungeon-add-remove.h"

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
add_new_creature(world *wp, int type, int z, int x, int y, int level,
                 int wait)
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
  who->level = level;
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

/* this also removes the corresponding turn order and priority
 * this moves the weapon to ITEM_NOWHERE
 * this does not remove a weapon in player_sheath unless the player is
 * wielding it
 */
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

  if (who->weapon_id >= 0)
    move_item(wp, who->weapon_id, ITEM_NOWHERE, -1,
              -1, -1, -1, -1,
              0);

  wp->cr[creature_id] = NULL;
  who->id = -1;
  creature_delete(who);
  who = NULL;

  return 0;
}

int
add_item_here(world *wp, item *what, int n)
{
  if (wp == NULL)
  {
    fprintf(stderr, "add_item_here: wp is NULL\n");
    return -1;
  }
  if (what == NULL)
  {
    fprintf(stderr, "add_item_here: what is NULL\n");
    return -1;
  }
  if (n < 0)
  {
    fprintf(stderr, "add_item_here: strange n (%d)\n", n);
    return -1;
  }

  while (n >= wp->itm_size)
  {
    if (world_expand_itm(wp) != 0)
    {
      fprintf(stderr, "add_item_here: world_expand_itm failed\n");
      return -1;
    }
  }

  if (wp->itm[n] != NULL)
  {
    fprintf(stderr, "add_item_here: itm[%d] is already used\n", n);
    return -1;
  }

  what->id = n;
  wp->itm[n] = what;

  return n;
}

int
add_item(world *wp, item *what)
{
  int i;
  int n;

  if (wp == NULL)
  {
    fprintf(stderr, "add_item: wp is NULL\n");
    return -1;
  }
  if (what == NULL)
  {
    fprintf(stderr, "add_item: what is NULL\n");
    return -1;
  }

  for (i = 0; i < wp->itm_size; i++)
  {
    if (wp->itm[i] == NULL)
      break;
  }

  n = add_item_here(wp, what, i);
  if (n < 0)
  {
    fprintf(stderr, "add_item: add_item_here failed\n");
    return -1;
  }

  return n;
}

int
add_new_item(world *wp, int type, int which, int quantity)
{
  int n;
  item *what = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "add_new_item: wp is NULL\n");
    return -1;
  }
  if (quantity <= 0)
  {
    fprintf(stderr, "add_new_item: quantity is non-positive (%d)\n",
            quantity);
    return -1;
  }

  what = item_new();
  if (what == NULL)
  {
    fprintf(stderr, "add_new_item: item_new failed\n");
    return -1;
  }

  what->id = -1;
  what->type = type;
  what->which = which;
  what->quantity = quantity;
  what->where = ITEM_NOWHERE;
  what->owner = -1;
  what->z = -1;
  what->x = -1;
  what->y = -1;

  n = add_item(wp, what);
  if (n < 0)
  {
    fprintf(stderr, "add_new_item: add_item failed\n");
    item_delete(what);
    what = NULL;
    return -1;
  }

  return n;
}

int
remove_item(world *wp, int item_id)
{
  item *what = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "remove_item: wp is NULL\n");
    return 1;
  }
  if ((item_id < 0) || (item_id >= wp->itm_size))
  {
    fprintf(stderr, "remove_item: strange item_id (%d)\n", item_id);
    return 1;
  }
  if (wp->itm[item_id] == NULL)
  {
    fprintf(stderr, "remove_item: wp->itm[%d] is NULL\n", item_id);
    return 1;
  }

  what = wp->itm[item_id];

  move_item(wp, item_id, ITEM_NOWHERE, -1,
            -1, -1, -1, -1,
            0);

  wp->itm[item_id] = NULL;
  what->id = -1;
  item_delete(what);
  what = NULL;

  return 0;
}

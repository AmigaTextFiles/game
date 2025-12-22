#ifndef __KSMN_DUNGEON_ADD_REMOVE_H__
#define __KSMN_DUNGEON_ADD_REMOVE_H__

#include "world.h"
#include "creature.h"
#include "turn-order.h"
#include "item.h"
#include "list-int.h"

int add_priority_last(world *wp, int turn_order_id);
int remove_priority(world *wp, list_int *pri);
int add_turn_order_here(world *wp, turn_order *what, int n);
int add_turn_order(world *wp, turn_order *what);
int add_new_turn_order(world *wp, int type, int which, int wait);
int remove_turn_order(world *wp, int turn_order_id);
int add_creature_here(world *wp, creature *who, int n);
int add_creature(world *wp, creature *who);
int add_new_creature(world *wp, int type, int z, int x, int y, int level,
                     int wait);
int remove_creature(world *wp, int creature_id);
int add_item_here(world *wp, item *what, int n);
int add_item(world *wp, item *what);
int add_new_item(world *wp, int type, int which, int quantity);
int remove_item(world *wp, int item_id);

#endif /* not __KSMN_DUNGEON_ADD_REMOVE_H__ */

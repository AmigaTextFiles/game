#ifndef __KSMN_DUNGEON_H__
#define __KSMN_DUNGEON_H__

#include "world.h"
#include "creature.h"
#include "turn-order.h"

#define PLAYER_SIGHT_RANGE 8

#define CREATURE_IFF_UNKNOWN 0
#define CREATURE_IFF_FRIENDLY 1
#define CREATURE_IFF_HOSTILE 2

int distance(int ax, int ay, int bx, int by);
int cardinal_direction(int ax, int ay, int bx, int by);
int has_los_from_player(world *wp, int z, int x, int y);
int add_priority_last(world *wp, int turn_order_id);
int remove_priority(world *wp, list_int *pri);
int add_turn_order_here(world *wp, turn_order *what, int n);
int add_turn_order(world *wp, turn_order *what);
int add_new_turn_order(world *wp, int type, int which, int wait);
int remove_turn_order(world *wp, int turn_order_id);
int add_creature_here(world *wp, creature *who, int n);
int add_creature(world *wp, creature *who);
int add_new_creature(world *wp, int type, int z, int x, int y, int wait);
int remove_creature(world *wp, int creature_id);
int creature_is_dead(world *wp, int creature_id);
int creature_sees_grid(world *wp, int creature_id, int z, int x, int y);
int player_searches_grid(world *wp, int z, int x, int y);
int get_creature_iff(world *wp, int creature_id);
int creature_take_damage(world *wp, int target_id, int dam,
                         int attacker_id, int verbose, int ignore_shield);
int creature_heal_hp(world *wp, int target_id, int amount, int verbose);
int creature_change_xy(world *wp, int creature_id, int x, int y);
int creature_change_z(world *wp, int creature_id, int z);
int creature_teleport(world *wp, int creature_id);
int creature_add_enchantment(world *wp, int creature_id,
                             int type, int duration);
int grid_is_illegal(world *wp, int z, int x, int y);
int grid_blocks_creature(world *wp, int z, int x, int y);
int grid_has_creature(world *wp, int z, int x, int y);
int grid_has_enemy(world *wp, int z, int x, int y, int attacker_id);
int grid_blocks_los(world *wp, int z, int x, int y);
int grid_blocks_beam(world *wp, int z, int x, int y);
int grid_is_stair(world *wp, int z, int x, int y);
int find_stair_destination(world *wp,
                           int from_z, int from_x, int from_y,
                           int *dest_z, int *dest_x, int *dest_y);
int get_step_map(world *wp, int **step_map,
                 int from_z, int from_x, int from_y,
                 int dest_x, int dest_y,
                 int max_step);
int add_log(world *wp, const char *str);
int update_player_cache(world *wp);

#endif /* not __KSMN_DUNGEON_H__ */

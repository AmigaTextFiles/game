#ifndef __KSMN_DUNGEON_H__
#define __KSMN_DUNGEON_H__

#include "world.h"
#include "creature.h"
#include "turn-order.h"
#include "item.h"

#define CREATURE_IFF_UNKNOWN 0
#define CREATURE_IFF_FRIENDLY 1
#define CREATURE_IFF_HOSTILE 2

int distance(int ax, int ay, int bx, int by);
int cardinal_direction(int ax, int ay, int bx, int by);
int has_los_from_player(world *wp, int z, int x, int y);
int move_item(world *wp, int item_id, int dest_where, int dest_owner,
              int dest_z, int dest_x, int dest_y, int dest_slot,
              int verbose);
int destroy_item(world *wp, int item_id, int verbose);
int creature_is_dead(world *wp, int creature_id);
int creature_sees_grid(world *wp, int creature_id, int z, int x, int y);
int player_searches_grid(world *wp, int z, int x, int y);
int creature_is_wielding_weapon(world *wp, int creature_id);
int get_creature_iff(world *wp, int creature_id);
int creature_take_damage(world *wp, int target_id, int dam,
                         int attacker_id, int verbose);
int credit_kill(world *wp, int target_id, int attacker_id);
int creature_heal_hp(world *wp, int target_id, int amount, int verbose);
int creature_change_xy(world *wp, int creature_id, int x, int y);
int creature_change_z(world *wp, int creature_id, int z);
int creature_teleport(world *wp, int creature_id);
int creature_die(world *wp, int creature_id);
int creature_drop_item(world *wp, int creature_id, int item_id,
                       int verbose);
int add_wield_message(world *wp, int creature_id);
int item_is_dead(world *wp, int item_id);
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
int find_item_on_floor(world *wp, int z, int x, int y,
                       int known_item_id, int dir, int only_weapon);
int count_item_on_floor(world *wp, int z, int x, int y,
                        int known_item_id, int *known_item_order,
                        int only_weapon);
int find_open_floor(world *wp, int z, int *result_x, int *result_y);
int get_step_map(world *wp, int **step_map,
                 int from_z, int from_x, int from_y,
                 int dest_x, int dest_y,
                 int max_step);
int add_log(world *wp, const char *str);
int update_player_cache(world *wp);
creature *find_creature_under_cursor(world *wp);

#endif /* not __KSMN_DUNGEON_H__ */

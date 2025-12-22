#ifndef __KSMN_WORLD_H__
#define __KSMN_WORLD_H__

#include <pdcurses/curses.h>

#include "creature.h"
#include "turn-order.h"
#include "player-cache.h"
#include "list-int.h"
#include "item.h"
#include "judge.h"

/* values for mode[0] */
#define MODE_WAITING_FOR_ACTION 0
#define MODE_EXAMINE_SURROUNDING 1
#define MODE_FULL_SCREEN_LOG 2
#define MODE_DESCRIBE_CREATURE 3
#define MODE_FULL_SCREEN_MAP 4
#define MODE_CONFIRM_RESIGN 5
#define MODE_PICKUP_WEAPON 6
#define MODE_DROP_WEAPON 7
#define MODE_CHANGE_WEAPON_SLOT 8
#define MODE_VIEW_PLAYER 9
#define MODE_THROW_WEAPON 10
#define MODE_POLYMORPH_SELF 11

/* values for turn_state */
#define TURN_STATE_NORMAL 0
#define TURN_STATE_POST_MOVE 1

#define PLAYER_SIGHT_RANGE 8
#define PLAYER_SEARCH_RANGE 8
#define DRAW_SURROUNDINGS_RANGE 8

struct _world
{
  /* should be saved */
  /* cr_size is not saved */
  int cr_size;
  creature **cr;
  int size_z;
  int size_x;
  int size_y;
  int ***grid;
  /* tor_size is not saved */
  int tor_size;
  turn_order **tor;
  list_int *priority_first;
  list_int *priority_last;
  list_int *priority_now;
  /* itm_size is not saved */
  int itm_size;
  item **itm;
  int player_id;
  int ancient_dragon_id;
  int mature_dragon_id;
  int baby_dragon_id;
  int *player_sheath;
  int player_weapon_slot;
  int last_kill_type;
  int player_z_max;
  int turn_state;
  int camera_z;
  int camera_x;
  int camera_y;
  int last_known_z;
  int last_known_x;
  int last_known_y;
  int remember_map_from_z;
  int remember_map_from_x;
  int remember_map_from_y;
  int victory;
  int ut;
  int cheat_color_by_threat;

  /* not saved */
  WINDOW *scr;
  char *save_dir;
  int should_quit;
  int *mode;
  int cursor_x;
  int cursor_y;
  int force_cursor_target;
  int log_size;
  char **log;
  int log_head;
  player_cache *pcache;
  int scr_size_x;
  int scr_size_y;
  int **step_map_result;
  int ***step_map_queue;
  int (**creature_effect_func)(struct _world *, combat_judge *, int);
  int (**weapon_effect_func)(struct _world *, combat_judge *, int);
};
typedef struct _world world;

world *world_new(void);
void world_delete(world *wp);
int world_init_curses(world *wp);
void world_reset_game(world *wp);
int world_expand_cr(world *wp);
int world_expand_tor(world *wp);
int world_expand_itm(world *wp);

#endif /* not __KSMN_WORLD_H__ */

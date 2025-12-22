#ifndef __KSMN_WORLD_H__
#define __KSMN_WORLD_H__

#include <pdcurses/curses.h>

#include "creature.h"
#include "turn-order.h"
#include "player-cache.h"
#include "list-int.h"

#define PLAYER_SHIELD_MAX 10

/* values for mode[0] */
#define MODE_WAITING_FOR_ACTION 0
#define MODE_EXAMINE_SURROUNDING 1
#define MODE_FULL_SCREEN_LOG 2
#define MODE_DESCRIBE_CREATURE 3
#define MODE_FULL_SCREEN_MAP 4
#define MODE_CONFIRM_RESIGN 5
#define MODE_QUAFF 6
#define MODE_SWAP_POSITION 7
#define MODE_ZAP 8

/* global_decision_flag
 * these values must be one of 2^n
 */
#define GLOBAL_DSCN_NO_MORE_SEARCH 1

struct _world
{
  /* should be saved */
  int cr_size;
  creature **cr;
  int size_z;
  int size_x;
  int size_y;
  int ***grid;
  int tor_size;
  turn_order **tor;
  list_int *priority_first;
  list_int *priority_last;
  list_int *priority_now;
  int player_id;
  int queen_id;
  int camera_z;
  int camera_x;
  int camera_y;
  int last_known_z;
  int last_known_x;
  int last_known_y;
  int global_decision_flag;
  int player_shield;
  int player_is_damaged;
  int remember_map_from_z;
  int remember_map_from_x;
  int remember_map_from_y;
  int victory;
  int ut;

  /* not saved */
  WINDOW *scr;
  char *save_dir;
  int should_quit;
  int *mode;
  int cursor_x;
  int cursor_y;
  int log_size;
  char **log;
  int log_head;
  player_cache *pcache;
  int scr_size_x;
  int scr_size_y;
};
typedef struct _world world;

world *world_new(void);
void world_delete(world *wp);
int world_init_curses(world *wp);
void world_reset_game(world *wp);
int world_expand_cr(world *wp);
int world_expand_tor(world *wp);

#endif /* not __KSMN_WORLD_H__ */

/*

Mures
Copyright (C) 2001 Adam D'Angelo

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Contact information:

Adam D'Angelo
dangelo@ntplx.net
P.O. Box 1155
Redding, CT 06875-1155
USA

*/

#ifndef SIM_H
#define SIM_H

#include "SDL.h"
#include "types.h"
#include "map.h"

typedef struct _creature
{
  bool exists;
  creature_type type;
  direction dir;
  grid_float_position pos;
} creature;

typedef struct _float_creature
{
  bool exists;
  direction old_dir;
  creature_type type;
  grid_int_position target;
  grid_float_position pos;
} float_creature;

typedef struct _arrow_type
{
  bool exists;
  Uint16 age;
  Uint32 time_left; /*ms*/
  Uint8 health;
  grid_int_position pos;
  direction dir;
} arrow_type;

typedef struct _sim_player
{
  bool exists;
  Uint16 score;
  player_id team_leader;
  Uint8 current_rocket;
  Uint8 last_rocket;
  arrow_type arrow[MAX_ARROW];
} sim_player;

enum
{
  NORMAL,
  MODE_INTRO,
  MOUSE_MANIA,
  CAT_MANIA,
  SPEED_UP,
  SLOW_DOWN,
  MOUSE_MONOPOLY,
  CAT_ATTACK,
  EVERYBODY_MOVE,
  PLACE_ARROWS_AGAIN
};

typedef Uint8 mode_type;

enum
{
  Q_MOUSE_MANIA,
  Q_CAT_MANIA,
  Q_SPEED_UP,
  Q_SLOW_DOWN,
  Q_MOUSE_MONOPOLY,
  Q_CAT_ATTACK,
  Q_EVERYBODY_MOVE,
  Q_PLACE_ARROWS_AGAIN,
  MAX_QMOUSE_TYPE
};

typedef Uint8 qmouse_type;

#define MOUSE_MANIA_P 30
#define CAT_MANIA_P 20
#define SPEED_UP_P 10
#define SLOW_DOWN_P 3.33
#define CAT_ATTACK_P 3.33
#define EVERYBODY_MOVE_P 20
#define MOUSE_MONOPOLY_P 3.33
#define PLACE_ARROWS_AGAIN_P 15

#define MODE_INTRO_L 1000
#define MOUSE_MANIA_L 12000
#define CAT_MANIA_L 11000
#define SPEED_UP_L 10000
#define SLOW_DOWN_L 10000
#define CAT_ATTACK_L 800
#define MOUSE_MONOPOLY_L 7000
#define EVERYBODY_MOVE_L 1000
#define PLACE_ARROWS_AGAIN_L 1800

enum
{
  NOT_STARTED,
  PLAYING,
  PAUSED,

  /* time for ending animations to take effect */
  POST_GAME,

  /* ready to go back to the start screen */
  FINISHED
};

typedef Uint8 state_type;

typedef struct _sim sim;

struct _sim
{
  /* options used for client/server */
  bool authority;

  bool export_net_events;
  bool export_output_events;
  game *game;
  
  /* sim data */
  
  Uint32 clock; /* time left in ms */
  Uint32 elapsed;

  Uint8 type;

  Uint8 state;
  Uint32 state_timer;

  map map;

  /* +50 or -XXX from 50-mouse or cat */
  Sint16 score_change[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  Uint32 score_change_timer[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  
  mode_type mode;
  qmouse_type next_mode;
  Uint32 mode_timer;
  player_id mode_player;
  
  creature creature[MAX_CREATURE];
  float_creature floater[MAX_CREATURE]; /* used in mouse monopoly */

  sim_player player[MAX_PLAYER];

  direction turn[NUM_BLOCKS_X][NUM_BLOCKS_Y][MAX_DIR];
};

typedef struct _input_type
{
  int player_num;
  direction dir;
  grid_int_position pos;
} input_type;

/* event types */
#define ADD_CREATURE 100
#define PLAYER_UPDATE 101
#define MODE_UPDATE 102
#define STATE_UPDATE 103

typedef struct _net_event
{
  Uint32 time;
  Uint8 type;

  union
  {
    struct {
      int index;
      creature creature;
    } add_creature;

    sim_player player_update[MAX_PLAYER];

    struct {
      mode_type mode;
      qmouse_type next_mode;
      Uint32 mode_timer;
      player_id mode_player;
    } mode_update;

    struct {
      state_type state;
      Uint32 state_timer;
    } state_update;
  } data;

} net_event;

/* output events */
enum {
  GET_MOUSE,
  GET_MOUSE_50,
  GET_MOUSE_Q,
  GET_CAT,
  START_GAME,
  PAUSE_GAME,
  MOUSE_DEATH
};

grid_int_position grid_int_pos(grid_int x, grid_int y);
grid_float_position grid_float_pos(grid_float x, grid_float y);
bool valid_grid_int(grid_int_position ongrid);

void sim_clear(sim *s);
void sim_use_map(sim *s, map *m);
void sim_new_game(sim *s);

void calculate_turn(sim *s, grid_int x, grid_int y, direction dir);
void calculate_turn_square(sim *s, grid_int x, grid_int y);
void calculate_all_turns(sim *s);

int free_for_arrow(sim *s, grid_int_position p, int player);
int arrow_dir_count(sim *s, direction dir);

void sim_process_net_event(sim *s, net_event e);
void process_input(sim *s, input_type input);

void add_generator(sim *s, grid_int_position pos, direction dir);
void add_creature(sim *s, creature to_add);

void sim_step(sim *s, Uint32 ms);
void sim_start(sim *s);
void sim_toggle_pause(sim *s);

int sim_rocket_owner(sim *s, Uint8 x, Uint8 y);
int sim_last_rocket_owner(sim *s, Uint8 x, Uint8 y);
void sim_translate(sim *s, int tx, int ty);

#endif


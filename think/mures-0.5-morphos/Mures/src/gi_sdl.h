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

#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "types.h"
#include "game.h"

typedef enum _input_action_type {
  POINTER_ACCEL,
  POINTER_DECEL,
  POINTER_SET,
  PLACE_ARROW,
  DRAG_START,
  DRAG_STOP,
  INPUT_ACTION_MAX
} input_action_type;

typedef struct _input_action {
  int exists;
  int player;
  input_action_type type;
  direction dir;
  int x,y;
} input_action;

enum {
  SET_POS,
  SET_VEL
};

typedef struct _input_scale {
  int exists;
  int type;
  int min_x;
  int max_x;
  int min_y;
  int max_y;
  int player;
} input_scale;

#define MAX_JOY_BUTTON 30
#define MAX_JOY        MAX_PLAYER
#define MAX_MOUSE_BUTTON 10

typedef struct _gi_sdl_settings
{
  input_action key_up_action[SDLK_EURO+1];
  input_action key_down_action[SDLK_EURO+1];

  input_action joy_up_action[MAX_JOY][MAX_JOY_BUTTON];
  input_action joy_down_action[MAX_JOY][MAX_JOY_BUTTON];

  input_action mouse_up_action[MAX_MOUSE_BUTTON];
  input_action mouse_down_action[MAX_MOUSE_BUTTON];

  input_scale joy_axis_scale[MAX_JOY];
  input_scale mouse_scale;

  int joy_x[MAX_JOY];
  int joy_y[MAX_JOY];
} gi_sdl_settings;  

gi_sdl_settings ks;

int gi_sdl_player_exists(game *g, int p);
grid_int_position gi_sdl_player_grid_pos(game *g, int p);
vector gi_sdl_player_pointer(game *g, int p);


/* called when program starts */
int gi_sdl_init();
/* called when program exits */
void gi_sdl_exit();

/* called when game starts */
void gi_sdl_start(game *g);
/* called when output changes */
void gi_sdl_changed_output(game *g);
/* called when game stops */
void gi_sdl_stop(game *g);

void gi_sdl_step(game *g, int ms);
int gi_sdl_handle_event(game *g, SDL_Event e);

#endif

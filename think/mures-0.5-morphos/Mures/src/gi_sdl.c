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

#include <stdlib.h>
#include "SDL.h"

#include "sim.h"
#include "input_queue.h"
#include "gi_sdl.h"
#include "game_output.h"
#include "lib.h"
#include "main.h"
#include "game.h"
#include "lua.h"
#include "lua_keys.h"
#include "output.h"

typedef struct _gi_sdl_player
{
  int exists;
  vector pointer;
  vector pointer_vel;
  vector pointer_max_vel;
  vector pointer_accel;
  vector pointer_from;
  grid_int_position grid_pos;
} gi_sdl_player;

typedef struct _gi_sdl_data
{
  gi_sdl_player player[MAX_PLAYER];
} gi_sdl_data;

#define GI (*(gi_sdl_data*)g->input)

SDL_Joystick *js;

int gi_sdl_player_exists(game *g, int p)
{
  return GI.player[p].exists;
}

grid_int_position gi_sdl_player_grid_pos(game *g, int p)
{
  return GI.player[p].grid_pos;
}

vector gi_sdl_player_pointer(game *g, int p)
{
  return GI.player[p].pointer;
}

grid_int_position vector2grid(vector c)
{
  grid_int_position p;
  
  c.x *= NUM_BLOCKS_X;
  c.y *= NUM_BLOCKS_Y;
  
  p.x = (int)c.x;
  p.y = (int)c.y;
  
  if(p.x == NUM_BLOCKS_X)
    p.x--;
  
  if(p.y == NUM_BLOCKS_Y)
    p.y--;
  
  return p;
}

/* centers too */
vector grid2vector(grid_int_position p)
{
  vector v;
  
  v.x = p.x;
  v.y = p.y;
  
  v.x += .5;
  v.y += .5;
  
  v.x /= NUM_BLOCKS_X;
  v.y /= NUM_BLOCKS_Y;

  return v;
}

int local_player_count(game *g)
{
  int i, count=0;
  
  for(i=0; i<MAX_PLAYER; i++)
    if(g->have_local_player[i])
      if(g->local_player_type[i] == KEYBOARD_PLAYER)
	count++;

  return count;
}

int local_player(game *g, int n)
{
  int i,count=0;

  for(i=0; i<MAX_PLAYER; i++)
    if(g->have_local_player[i])
      if(g->local_player_type[i] == KEYBOARD_PLAYER) {
	if(count==n)
	  return i;
	count++;
      }

  return -1;
}

void gi_sdl_data_clear(gi_sdl_data *data)
{
  int i;
  
  for(i=0; i<MAX_PLAYER; i++) {
    data->player[i].exists = 0;
    
    data->player[i].pointer.x = 0;
    data->player[i].pointer.y = 0;
    data->player[i].pointer_vel.x = 0;
    data->player[i].pointer_vel.y = 0;
    data->player[i].pointer_max_vel.x = 1;
    data->player[i].pointer_max_vel.y = 1;
    data->player[i].pointer_accel.x = 0;
    data->player[i].pointer_accel.y = 0;
  }
}

void handle_scale(game *g, input_scale scale, int x, int y)
{
  int p = local_player(g, scale.player);
  gi_sdl_data *data = &GI;
  float xper, yper;
  
  if(p == -1 || p >= local_player_count(g))
    return;
  
  if(!data->player[p].exists)
    return;
  
  xper = (x-scale.min_x)/((float)scale.max_x-scale.min_x+1);
  yper = (y-scale.min_y)/((float)scale.max_y-scale.min_y+1);
  
  if(scale.type == SET_POS) {
    data->player[p].pointer.x = xper;
    data->player[p].pointer.y = yper;
  }
  
  if(scale.type == SET_VEL) {
    data->player[p].pointer_vel.x = (xper-.5)*1.5;
    data->player[p].pointer_vel.y = (yper-.5)*1.5;
    
    data->player[p].pointer_max_vel.x = (xper-.5)*4;
    data->player[p].pointer_max_vel.y = (yper-.5)*4;
    
    data->player[p].pointer_accel.x = (xper-.5)*.002;
    data->player[p].pointer_accel.y = (yper-.5)*.002;
  }
}

float float_abs(float x)
{
  return x>0?x:-x;
}

void handle_action(game *g, input_action action)
{
  int p = local_player(g, action.player);
  gi_sdl_data *data = &GI;
  input_queue *q = &g->local_input;
  float x, y, fx, fy;
  direction dir;
  
  if(p == -1 || p >= local_player_count(g))
    return;

  if(!data->player[p].exists)
    return;

  switch(action.type) {
  case PLACE_ARROW:
    if(free_for_arrow(&g->sim, data->player[p].grid_pos, action.player))
	input_enqueue(q, p, action.dir, data->player[p].grid_pos);
    break;
  case POINTER_DECEL:
    switch(action.dir) {
    case UP: data->player[p].pointer_vel.y++; break;
    case DOWN: data->player[p].pointer_vel.y--; break;
    case LEFT: data->player[p].pointer_vel.x++; break;
    case RIGHT: data->player[p].pointer_vel.x--; break;
    default: break;
    }
    break;
  case POINTER_ACCEL:
    switch(action.dir) {
    case UP: data->player[p].pointer_vel.y--; break;
    case DOWN: data->player[p].pointer_vel.y++; break;
    case LEFT: data->player[p].pointer_vel.x--; break;
    case RIGHT: data->player[p].pointer_vel.x++; break;
    default: break;
    }
    break;
  case POINTER_SET:
    data->player[p].pointer.x = action.x;
    data->player[p].pointer.y = action.y;
    data->player[p].grid_pos = vector2grid(data->player[p].pointer);
    break;
  case DRAG_START:
    data->player[p].pointer_from = data->player[p].pointer;
    break;
  case DRAG_STOP:
    x = data->player[p].pointer.x;
    y = data->player[p].pointer.y;
    fx = data->player[p].pointer_from.x;
    fy = data->player[p].pointer_from.y;
    
    if(float_abs(fx-x) > float_abs(fy-y)) {
      if(x>fx)
	dir = RIGHT;
      else
	dir = LEFT;
    }
    else {
      if(y>fy)
	dir = DOWN;
      else
	dir = UP;
    }

    if(free_for_arrow(&g->sim, vector2grid(data->player[p].pointer_from), p))
      input_enqueue(&g->local_input, p, dir, vector2grid(data->player[p].pointer_from));
    break;

  default:
    fprintf(stderr, "Unknown action type: %d\n", action.type);
    break;
  }

  /*  
  if(data->player[p].pointer_vel.y < -1)
    data->player[p].pointer_vel.y = -1;
  if(data->player[p].pointer_vel.y > 1)
    data->player[p].pointer_vel.y = 1;

  if(data->player[p].pointer_vel.x < -1)
    data->player[p].pointer_vel.x = -1;
  if(data->player[p].pointer_vel.x > 1)
    data->player[p].pointer_vel.x = 1;
  */

  return;
}

void set_key_action(SDLKey key, int player, input_action_type type, direction dir)
{
  ks.key_down_action[key].exists = 1;
  ks.key_down_action[key].player = player;
  ks.key_down_action[key].type = type;
  ks.key_down_action[key].dir = dir;

  if(type==POINTER_ACCEL) {
    ks.key_up_action[key] = ks.key_down_action[key];
    ks.key_up_action[key].type = POINTER_DECEL;
  }

  if(type == DRAG_START) {
    ks.key_up_action[key] = ks.key_down_action[key];
    ks.key_up_action[key].type = DRAG_STOP;
  }
}

static int lua_set_key(lua_State *L)
{
  if(lua_gettop(L) != 4)
    lua_error(L, "setkey takes 4 arguments.");
  
  if(!lua_isnumber(L, 1))
    lua_error(L, "setkey arg 1 is number.");
  if(!lua_isnumber(L, 2))
    lua_error(L, "setkey arg 2 is number.");
  if(!lua_isnumber(L, 3))
    lua_error(L, "setkey arg 3 is number.");
  if(!lua_isnumber(L, 4))
    lua_error(L, "setkey arg 4 is number.");
  
  set_key_action((int)lua_tonumber(L, 1), (int)lua_tonumber(L, 2), (int)lua_tonumber(L, 3), (int)lua_tonumber(L, 4));
  
  return 0;
}

void set_mouse_button_action(int button, int player, input_action_type type, direction dir)
{
  ks.mouse_down_action[button].exists = 1;
  ks.mouse_down_action[button].player = player;
  ks.mouse_down_action[button].type = type;
  ks.mouse_down_action[button].dir = dir;
  
  if(type==POINTER_ACCEL) {
    ks.mouse_up_action[button] = ks.mouse_down_action[button];
    ks.mouse_up_action[button].type = POINTER_DECEL;
  }
  
  if(type == DRAG_START) {
    ks.mouse_up_action[button] = ks.mouse_down_action[button];
    ks.mouse_up_action[button].type = DRAG_STOP;
  }
}

static int lua_set_mouse_button(lua_State *L)
{
  if(lua_gettop(L) != 4)
    lua_error(L, "setmousebutton takes 4 arguments.");
  
  if(!lua_isnumber(L, 1))
    lua_error(L, "setmousebutton arg 1 is number.");
  if(!lua_isnumber(L, 2))
    lua_error(L, "setmousebutton arg 2 is number.");
  if(!lua_isnumber(L, 3))
    lua_error(L, "setmousebutton arg 3 is number.");
  if(!lua_isnumber(L, 4))
    lua_error(L, "setmousebutton arg 4 is number.");
  
  set_mouse_button_action((int)lua_tonumber(L, 1), (int)lua_tonumber(L, 2), (int)lua_tonumber(L, 3), (int)lua_tonumber(L, 4));
  
  return 0;
}

void set_joy_button_action(int joy, int button, int player, input_action_type type, direction dir)
{
  ks.joy_down_action[joy][button].exists = 1;
  ks.joy_down_action[joy][button].player = player;
  ks.joy_down_action[joy][button].type = type;
  ks.joy_down_action[joy][button].dir = dir;

  if(type==POINTER_ACCEL) {
    ks.joy_up_action[joy][button] = ks.joy_down_action[joy][button];
    ks.joy_up_action[joy][button].type = POINTER_DECEL;
  }

  if(type == DRAG_START) {
    ks.joy_up_action[joy][button] = ks.joy_down_action[joy][button];
    ks.joy_up_action[joy][button].type = DRAG_STOP;
  }
}

static int lua_set_joy_button(lua_State *L)
{
  if(lua_gettop(L) != 5)
    lua_error(L, "setjoybutton takes 5 arguments.");
  
  if(!lua_isnumber(L, 1))
    lua_error(L, "setjoybutton arg 1 is number.");
  if(!lua_isnumber(L, 2))
    lua_error(L, "setjoybutton arg 2 is number.");
  if(!lua_isnumber(L, 3))
    lua_error(L, "setjoybutton arg 3 is number.");
  if(!lua_isnumber(L, 4))
    lua_error(L, "setjoybutton arg 4 is number.");
  if(!lua_isnumber(L, 5))
    lua_error(L, "setjoybutton arg 5 is number.");
  
  set_joy_button_action((int)lua_tonumber(L, 1), (int)lua_tonumber(L, 2), (int)lua_tonumber(L, 3), (int)lua_tonumber(L, 4), (int)lua_tonumber(L, 5));
  
  return 0;
}

void set_joy_axis_scale(int joy, int player, int min, int max)
{
  ks.joy_axis_scale[joy].exists = 1;
  ks.joy_axis_scale[joy].type = SET_VEL;
  ks.joy_axis_scale[joy].player = player;
  ks.joy_axis_scale[joy].min_x = min;
  ks.joy_axis_scale[joy].min_y = min;
  ks.joy_axis_scale[joy].max_x = max;
  ks.joy_axis_scale[joy].max_y = max;
}

static int lua_set_joy_axis(lua_State *L)
{
  if(lua_gettop(L) != 4)
    lua_error(L, "setjoyaxis takes 4 arguments.");
  
  if(!lua_isnumber(L, 1))
    lua_error(L, "setjoyaxis arg 1 is number.");
  if(!lua_isnumber(L, 2))
    lua_error(L, "setjoyaxis arg 2 is number.");
  if(!lua_isnumber(L, 3))
    lua_error(L, "setjoyaxis arg 3 is number.");
  if(!lua_isnumber(L, 4))
    lua_error(L, "setjoyaxis arg 4 is number.");
  
  set_joy_axis_scale((int)lua_tonumber(L, 1), (int)lua_tonumber(L, 2), (int)lua_tonumber(L, 3), (int)lua_tonumber(L, 4));
  
  return 0;
}

void set_mouse_scale(int player)
{
  ks.mouse_scale.exists = 1;
  ks.mouse_scale.type = SET_POS;
  ks.mouse_scale.player = player;
  ks.mouse_scale.min_x = 0;
  ks.mouse_scale.min_y = 0;

  /* these get set later by keyboard_update */
  ks.mouse_scale.max_x = 0;
  ks.mouse_scale.max_y = 0;
}

static int lua_set_mouse(lua_State *L)
{
  if(lua_gettop(L) != 1)
    lua_error(L, "setmouse takes 1 argument.");
  
  if(!lua_isnumber(L, 1))
    lua_error(L, "setmouse arg 1 is number.");
  
  set_mouse_scale((int)lua_tonumber(L, 1));
  
  return 0;
}

int gi_sdl_init()
{
  int i, j;

  for(i=0; i<SDLK_LAST; i++) {
    ks.key_up_action[i].exists = 0;
    ks.key_down_action[i].exists = 0;
  }
  
  for(i=0; i<MAX_MOUSE_BUTTON; i++) {
    ks.mouse_up_action[i].exists = 0;
    ks.mouse_down_action[i].exists = 0;
  }
  
  for(i=0; i<MAX_JOY; i++) {
    for(j=0; j<MAX_JOY_BUTTON; j++) {
      ks.joy_up_action[i][j].exists = 0;
      ks.joy_down_action[i][j].exists = 0;
    }
    ks.joy_axis_scale[i].exists = 0;
  }
  
  ks.mouse_scale.exists = 0;
  
  printf("See %d joystick%s.\n", SDL_NumJoysticks(), SDL_NumJoysticks()==1?"":"s");
  
  SDL_JoystickEventState(SDL_ENABLE);

  /* TODO: this is sloppy - need to at least close joysticks */
  
  for(i=0; i<SDL_NumJoysticks(); i++)
    js = SDL_JoystickOpen(i);

  lua_register(L, "setjoybutton", lua_set_joy_button);
  lua_register(L, "setjoyaxis", lua_set_joy_axis);
  lua_register(L, "setmouse", lua_set_mouse);
  lua_register(L, "setmousebutton", lua_set_mouse_button);
  lua_register(L, "setkey", lua_set_key);

  for(i=0; i<sizeof(soft_key)/sizeof(soft_key_type); i++) {
    lua_pushnumber(L, soft_key[i].number);
    lua_setglobal(L, soft_key[i].name);
  }

  lua_pushnumber(L, POINTER_ACCEL);
  lua_setglobal(L, "POINTER_ACCEL");
  lua_pushnumber(L, POINTER_SET);
  lua_setglobal(L, "POINTER_SET");
  lua_pushnumber(L, PLACE_ARROW);
  lua_setglobal(L, "PLACE_ARROW");
  lua_pushnumber(L, DRAG_START);
  lua_setglobal(L, "DRAG_START");
  lua_pushnumber(L, UP);
  lua_setglobal(L, "UP");
  lua_pushnumber(L, DOWN);
  lua_setglobal(L, "DOWN");
  lua_pushnumber(L, LEFT);
  lua_setglobal(L, "LEFT");
  lua_pushnumber(L, RIGHT);
  lua_setglobal(L, "RIGHT");

  /* run input script */

  if(lua_dofile(L, "input.lua") != 0) {
    fprintf(stderr, "Couldn't execute input config script \"input.lua\".\n");
    return 0;
  }

  return 1;
}

void gi_sdl_exit()
{
  return;
}

void keyboard_update()
{
  ks.mouse_scale.max_x = output_screen_w();
  ks.mouse_scale.max_y = output_screen_h();
}

void gi_sdl_start(game *g)
{
  int i;

  keyboard_update();
  
  g->input = malloc(sizeof(gi_sdl_data));
  gi_sdl_data_clear(&GI);
  
  printf("got this far.\n");
  
  for(i=0; i<MAX_PLAYER; i++) {
    if(g->have_local_player[i]) {
      if(g->local_player_type[i] == KEYBOARD_PLAYER)
	GI.player[i].exists = 1;
    }
    else
      GI.player[i].exists = 0;
  }

}

void gi_sdl_stop(game *g)
{
  return;
}



#define MIN_VAL .0001

void gi_sdl_step(game *g, int ms)
{
  int i;
  gi_sdl_data *data = &GI;

  for(i=0; i<MAX_PLAYER; i++)
    if(data->player[i].exists) {
      
      if(abs2(data->player[i].pointer_vel.x) > MIN_VAL)
	data->player[i].pointer.x += data->player[i].pointer_vel.x*ms/1000;
      if(abs2(data->player[i].pointer_vel.y) > MIN_VAL)
	data->player[i].pointer.y += data->player[i].pointer_vel.y*ms/1000;

      if(abs2(data->player[i].pointer_accel.x) > MIN_VAL)
	data->player[i].pointer_vel.x += data->player[i].pointer_accel.x*ms/1000;
      if(abs2(data->player[i].pointer_accel.y) > MIN_VAL)
	data->player[i].pointer_vel.y += data->player[i].pointer_accel.y*ms/1000;

      if(abs(data->player[i].pointer_vel.x) > abs(data->player[i].pointer_max_vel.x))
	data->player[i].pointer_vel.x = data->player[i].pointer_max_vel.x;
      
      if(abs(data->player[i].pointer_vel.y) > abs(data->player[i].pointer_max_vel.y))
	data->player[i].pointer_vel.y = data->player[i].pointer_max_vel.y;

      if(data->player[i].pointer.x > 1)
	data->player[i].pointer.x = 1;
      if(data->player[i].pointer.y > 1)
	data->player[i].pointer.y = 1;

      if(data->player[i].pointer.x < 0)
	data->player[i].pointer.x = 0;
      if(data->player[i].pointer.y < 0)
	data->player[i].pointer.y = 0;

      data->player[i].grid_pos = vector2grid(data->player[i].pointer);
    }
}

int gi_sdl_handle_event(game *g, SDL_Event e)
{
  int i,found;
  gi_sdl_data *data = &GI;

  switch(e.type) {

  case SDL_JOYAXISMOTION:
    if(e.jaxis.axis == 0)
      ks.joy_x[e.jaxis.which] = e.jaxis.value;
    else
      ks.joy_y[e.jaxis.which] = e.jaxis.value;
    
    if(ks.joy_axis_scale[e.jaxis.which].exists)
      handle_scale(g, ks.joy_axis_scale[e.jaxis.which], ks.joy_x[e.jaxis.which], ks.joy_y[e.jaxis.which]);
    break;

  case SDL_MOUSEMOTION:
    if(ks.mouse_scale.exists)
      handle_scale(g, ks.mouse_scale, e.motion.x, e.motion.y);
    break;

  case SDL_JOYBUTTONDOWN:
    if(ks.joy_down_action[e.jbutton.which][e.jbutton.button].exists)
      handle_action(g, ks.joy_down_action[e.jbutton.which][e.jbutton.button]);
    break;

  case SDL_JOYBUTTONUP:
    if(ks.joy_up_action[e.jbutton.which][e.jbutton.button].exists)
      handle_action(g, ks.joy_up_action[e.jbutton.which][e.jbutton.button]);
    break;

  case SDL_MOUSEBUTTONDOWN:
    if(ks.mouse_down_action[e.button.button].exists)
      handle_action(g, ks.mouse_down_action[e.button.button]);
    break;
    
  case SDL_MOUSEBUTTONUP:
    if(ks.mouse_up_action[e.button.button].exists)
      handle_action(g, ks.mouse_up_action[e.button.button]);
    break;

  case SDL_KEYUP:
    if(ks.key_up_action[e.key.keysym.sym].exists)
      handle_action(g, ks.key_up_action[e.key.keysym.sym]);
    if(e.key.keysym.sym == SDLK_BACKSPACE || e.key.keysym.sym == SDLK_ESCAPE)
      game_exit(g);
    break;

  case SDL_KEYDOWN:
    if(ks.key_down_action[e.key.keysym.sym].exists)
      handle_action(g, ks.key_down_action[e.key.keysym.sym]);
    else
      switch(e.key.keysym.sym) {
      case SDLK_MINUS:
      case SDLK_PLUS:
	g->sim.map.hwall[data->player[0].grid_pos.x][data->player[0].grid_pos.y] = g->sim.map.hwall[data->player[0].grid_pos.x][data->player[0].grid_pos.y]?0:1;
	calculate_all_turns(&g->sim);
	break;
      case SDLK_BACKSLASH:
	g->sim.map.vwall[data->player[0].grid_pos.x][data->player[0].grid_pos.y] = g->sim.map.vwall[data->player[0].grid_pos.x][data->player[0].grid_pos.y]?0:1;
	calculate_all_turns(&g->sim);
	break;
      case SDLK_0:
	g->sim.map.hole[data->player[0].grid_pos.x][data->player[0].grid_pos.y] = g->sim.map.hole[data->player[0].grid_pos.x][data->player[0].grid_pos.y]?0:1;
	game_output_bigchange(g);
	break;
      case SDLK_F10:
	g->sim.map.rocket[data->player[0].grid_pos.x][data->player[0].grid_pos.y]+=2;
	g->sim.map.rocket[data->player[0].grid_pos.x][data->player[0].grid_pos.y] %= (MAX_PLAYER+1);
	g->sim.map.rocket[data->player[0].grid_pos.x][data->player[0].grid_pos.y]--;
	break;
      case SDLK_F9:
	found = 0;
	for(i=0; i<g->sim.map.max_generator; i++)
	  if(g->sim.map.generator[i].pos.x == data->player[0].grid_pos.x && g->sim.map.generator[i].pos.y == data->player[0].grid_pos.y) {
	    found = 1;
	    break;
	  }
	if(found) {
	  while(i+1 < g->sim.map.max_generator) {
	    g->sim.map.generator[i] = g->sim.map.generator[i+1];
	    i++;
	  }
	  
	  g->sim.map.max_generator--;
	}
	else {
	  if(g->sim.map.max_generator < MAX_GENERATOR) {
	    g->sim.map.generator[g->sim.map.max_generator].pos = data->player[0].grid_pos;
	    g->sim.map.generator[g->sim.map.max_generator].dir = rand()%4;
	    
	    g->sim.map.max_generator++;
	  }
	}
	break;
      case SDLK_F7:
	sim_translate(&g->sim, 1, 0);
	break;
      case SDLK_F8:
	sim_translate(&g->sim, 0, 1);
	break;
      case SDLK_BREAK:
      case SDLK_p:
	if(g->sim.authority)
	  sim_toggle_pause(&g->sim);
	break;
      case SDLK_RETURN:
	if(g->sim.authority)
	  sim_start(&g->sim);
	break;
      case SDLK_F6:
	map_save(&g->sim.map, "saved.mus");
	break;
      case SDLK_F1:
	game_restart(g);
	break;
      default:
	break;
      }
    break;
  default:
/*      printf("Unhandled event: %d\n", e.type); */
    break;
  }

  return 1;
}  

void update_mouse(game *g, int i)
{
  SDL_WarpMouse(output_screen_w()*GI.player[i].pointer.x,
		output_screen_h()*GI.player[i].pointer.y);
}

void gi_sdl_changed_output(game *g)
{
  int i,x,y;
  
  /* because this depends on things like screen size for mouse speed */
  keyboard_update();
  
  printf("Centering pointers.\n");
  
  if(g->type == BATTLE) {
    for(i=0; i<MAX_PLAYER; i++)
      if(GI.player[i].exists) {
	for(x=0; x<NUM_BLOCKS_X; x++)
	  for(y=0; y<NUM_BLOCKS_Y; y++) {
	    if(sim_rocket_owner(&g->sim, x, y) == i) {
	      
	      GI.player[i].pointer = grid2vector(grid_int_pos(x, y));
	      
	      if(i==ks.mouse_scale.player)
		update_mouse(g, i);
	      
	      goto OUTSIDE;
	    }
	  }
      OUTSIDE:
	i++; i--;
      }
  }
  else
    for(i=0; i<MAX_PLAYER; i++)
      if(GI.player[i].exists) {
	GI.player[i].pointer = grid2vector(grid_int_pos((NUM_BLOCKS_X+1)/2, (NUM_BLOCKS_Y+1)/2));
	if(i == local_player(g, 0))
	  update_mouse(g, i);
      }
  
}



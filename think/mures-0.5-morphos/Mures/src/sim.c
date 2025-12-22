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

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include "SDL.h"
#include "protocol.h"
#include "sim.h"
#include "map.h"
#include "server.h"
#include "game_output.h"
#include "lib.h"

#define MOUSE_SPEED 5
#define CAT_SPEED (((float)MOUSE_SPEED)*2/3)
#define FATNESS (((float)1)/8)

/* absolute min 0.6 */
/* probably max 0.65 */
/* absolute max 0.7 */

void sim_translate(sim *s, int tx, int ty)
{
  int p, i, x, y;
  bool old_hwall[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  bool old_vwall[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  bool old_hole[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  Sint8 old_rocket[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  
  printf("translating.\n");
  
  for(i=0; i<MAX_GENERATOR; i++) {
    s->map.generator[i].pos.x += tx + NUM_BLOCKS_X;
    s->map.generator[i].pos.x %= NUM_BLOCKS_X;
    
    s->map.generator[i].pos.y += ty + NUM_BLOCKS_Y;
    s->map.generator[i].pos.y %= NUM_BLOCKS_Y;
  }
  
  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++) {
      old_hwall[x][y] = s->map.hwall[x][y];
      old_vwall[x][y] = s->map.vwall[x][y];
      old_hole[x][y]  = s->map.hole[x][y];
      old_rocket[x][y]  = s->map.rocket[x][y];
    }
  
  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++) {
      s->map.hwall[(x+tx+NUM_BLOCKS_X)%NUM_BLOCKS_X][(y+ty+NUM_BLOCKS_Y)%NUM_BLOCKS_Y] = old_hwall[x][y];
      s->map.vwall[(x+tx+NUM_BLOCKS_X)%NUM_BLOCKS_X][(y+ty+NUM_BLOCKS_Y)%NUM_BLOCKS_Y] = old_vwall[x][y];
      s->map.hole[(x+tx+NUM_BLOCKS_X)%NUM_BLOCKS_X][(y+ty+NUM_BLOCKS_Y)%NUM_BLOCKS_Y] = old_hole[x][y];
      s->map.rocket[(x+tx+NUM_BLOCKS_X)%NUM_BLOCKS_X][(y+ty+NUM_BLOCKS_Y)%NUM_BLOCKS_Y] = old_rocket[x][y];
    }

  for(p=0; p<MAX_PLAYER; p++)
    for(i=0; i<MAX_ARROW; i++) {
      s->player[p].arrow[i].pos.x += tx + NUM_BLOCKS_X;
      s->player[p].arrow[i].pos.x %= NUM_BLOCKS_X;
      
      s->player[p].arrow[i].pos.y += ty + NUM_BLOCKS_Y;
      s->player[p].arrow[i].pos.y %= NUM_BLOCKS_Y;
    }
  
  for(i=0; i<MAX_CREATURE; i++) {
    s->creature[i].pos.x += tx + NUM_BLOCKS_X;
    while(s->creature[i].pos.x > NUM_BLOCKS_X-.5)
      s->creature[i].pos.x -= NUM_BLOCKS_X;
    
    s->creature[i].pos.y += ty + NUM_BLOCKS_Y;
    while(s->creature[i].pos.y > NUM_BLOCKS_Y-.5)
      s->creature[i].pos.y -= NUM_BLOCKS_Y;
  }
  
  printf("almost done translating.\n");
  
  calculate_all_turns(s);
  game_output_bigchange(s->game);

  printf("done translating.\n");

}

float hypot2(float x, float y)
{
  return sqrt(x*x + y*y);
}

int sim_rocket_owner(sim *s, Uint8 x, Uint8 y)
{
  int i;
  for(i=0; i<MAX_PLAYER; i++)
    if(s->player[i].exists)
      if(s->player[i].current_rocket == s->map.rocket[x][y])
	return i;

  return -1;
}

int sim_last_rocket_owner(sim *s, Uint8 x, Uint8 y)
{
  int i;
  for(i=0; i<MAX_PLAYER; i++)
    if(s->player[i].exists)
      if(s->player[i].last_rocket == s->map.rocket[x][y])
	return i;

  return -1;
}


void export_net_event(net_event e)
{
  /*
  printf("sending out event of type %d\n", e.type);
  printf("add creature %d\n", e.data.add_creature.index);
  */
  server_broadcast_event(e);
}

void send_out_player_update(sim *s)
{
  net_event e;

  if(s->export_net_events) {
    e.type = PLAYER_UPDATE;
    e.time = s->elapsed;
    memcpy(e.data.player_update, s->player, sizeof(e.data.player_update));
    export_net_event(e);
  }
}  

void sim_handle_output_event(sim *s, int event, float x, float y, direction dir)
{
  if(s->export_output_events)
    game_output_handle_event(s->game, event, x, y, dir);
}

void sim_process_net_event(sim *s, net_event e)
{
  switch(e.type) {
  case ADD_CREATURE:
    s->creature[e.data.add_creature.index] = e.data.add_creature.creature;
    break;
  case PLAYER_UPDATE:
    memcpy(s->player, e.data.player_update, sizeof(s->player));
    calculate_all_turns(s);
    break;
  case MODE_UPDATE:
    s->mode = e.data.mode_update.mode;
    s->next_mode = e.data.mode_update.next_mode;
    s->mode_timer = e.data.mode_update.mode_timer;
    s->mode_player = e.data.mode_update.mode_player;
    if(s->next_mode == MODE_INTRO)
      sim_handle_output_event(s, GET_MOUSE_Q, 0, 0, 0);

    break;
  case STATE_UPDATE:
    s->state = e.data.state_update.state;
    s->state_timer = e.data.state_update.state_timer;
    break;
  default:
    printf("Net event type %d not processed - unknown.\n", e.type);
  }
}

grid_int_position grid_int_pos(grid_int x, grid_int y)
{
  grid_int_position temp;
  temp.x = x;
  temp.y = y;
  return temp;
}

grid_float_position grid_float_pos(grid_float x, grid_float y)
{
  grid_float_position temp;
  temp.x = x;
  temp.y = y;
  return temp;
}

bool valid_grid_int(grid_int_position ongrid)
{
  /* don't need to check <0 because unsigned */
  if(ongrid.x >= NUM_BLOCKS_X || ongrid.y >= NUM_BLOCKS_Y)
    return 0;
  else
    return 1;
}

/* game-dependent functions */

void clear_sim_map(sim *s)
{
  int i;

  calculate_all_turns(s);

  for(i=0; i<MAX_CREATURE; i++) {
    s->creature[i].exists = 0;
    s->floater[i].exists = 0;
  }
}  

void sim_clear(sim *s)
{
  int i,j,x,y;

  for(i=0; i<MAX_PLAYER; i++) {
    s->player[i].exists = 0;
    s->player[i].team_leader = i;
    for(j=0; j<MAX_ARROW; j++)
      s->player[i].arrow[j].exists = 0;
  }

  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++)
      s->score_change_timer[x][y] = 0;

  s->export_net_events = 0;
  s->export_output_events = 0;
  s->authority = 0;
  s->type = 0;

  clear_sim_map(s);
}

void sim_use_map(sim *s, map *m)
{
  int i, j;

  clear_sim_map(s);

  for(i=0; i<m->max_player; i++) {
    s->player[i].exists = 1;
    s->player[i].current_rocket = i;
    s->player[i].score = 0;
    for(j=0; j<MAX_ARROW; j++)
      s->player[i].arrow[j].exists = 0;
  }

  for(i=0; i<m->max_creature; i++) {
    s->creature[i].exists = 1;
    s->creature[i].type = m->creature[i].type;
    s->creature[i].dir = m->creature[i].dir;
    s->creature[i].pos.x = m->creature[i].pos.x;
    s->creature[i].pos.y = m->creature[i].pos.y;
  }

  s->map = *m;

  calculate_all_turns(s);
}

/* there shouldn't be any output until this is called */
void sim_new_game(sim *s)
{
  s->state = NOT_STARTED;
  s->mode = NORMAL;
  s->elapsed = 0;

  if(s->type == BATTLE)
    s->clock = BATTLE_LENGTH*1000;
}

void sim_start(sim *s)
{
  net_event e;

  if(s->state != NOT_STARTED) {
    fprintf(stderr, "Game already started.\n");
    return;
  }

  if(s->authority) {
    s->state = PLAYING;

    if(s->export_net_events) {
      e.type = STATE_UPDATE;
      e.time = s->elapsed;
      e.data.state_update.state = s->state;
      e.data.state_update.state_timer = s->state_timer;
      export_net_event(e);
    }
    
    sim_handle_output_event(s, START_GAME, 0, 0, 0);
    
    printf("Starting game.\n");

  }
  else
    fprintf(stderr, "Couldn't start sim: not local authority. Keyboard should have stopped this.\n");
}

void sim_toggle_pause(sim *s)
{
  net_event e;

  if(s->authority) {
    if(s->state == PLAYING)
      s->state = PAUSED;
    else if(s->state == PAUSED)
      s->state = PLAYING;
    else {
      fprintf(stderr, "Game isn't playing or paused, can't toggle.\n");
      return;
    }

    if(s->export_net_events) {
      e.type = STATE_UPDATE;
      e.time = s->elapsed;
      e.data.state_update.state = s->state;
      export_net_event(e);
    }

    sim_handle_output_event(s, PAUSE_GAME, 0, 0, 0);
  }
  else
    fprintf(stderr, "Couldn't pause sim: not local authority. Keyboard should have stopped this.\n");
}


int creature_count(sim *s, creature_type type)
{
  int i;
  int count=0;

  for(i=0; i<MAX_CREATURE; i++)
    if(s->creature[i].exists)
      if(s->creature[i].type == type)
	count++;
  return count;
}

int free_for_arrow(sim *s, grid_int_position p, int player)
{
  int i, j;

  if(!valid_grid_int(p))
    return 0;
  if(s->map.hole[p.x][p.y])
    return 0;
  
  if(s->map.rocket[p.x][p.y] >= 0)
    return 0;

  for(i=0; i<s->map.max_generator; i++)
    if(s->map.generator[i].pos.x == p.x && s->map.generator[i].pos.y == p.y)
      return 0;

  if(s->type != PUZZLE) {
    for(i=0; i<MAX_PLAYER; i++)
      if(s->player[i].exists) {
	for(j=0; j<MAX_ARROW; j++)
	  if(s->player[i].arrow[j].exists)
	    if(s->player[i].arrow[j].pos.x == p.x && s->player[i].arrow[j].pos.y == p.y)
	      return 0;
      }
  }

  return 1;
}

int arrow_dir_count(sim *s, direction dir)
{
  int i,p;
  int count = 0;
  
  for(p=0; p<MAX_PLAYER; p++)
    if(s->player[p].exists)
      for(i=0; i<MAX_ARROW; i++)
	if(s->player[p].arrow[i].exists)
	  if(s->player[p].arrow[i].dir == dir)
	    count++;
  
  return count;
}

void process_input(sim *s, input_type input)
{
  int i, age=0;
  arrow_type a;
  int p, bestp=input.player_num, best=0;

  if(!s->player[input.player_num].exists) {
    fprintf(stderr, "got input from a player not in the game: %d\n", input.player_num);
    return;
  }

  if(s->type == BATTLE) {
    if(s->state != PLAYING) {
      fprintf(stderr, "%d tried to place arrow in battle while state not playing.\n", input.player_num);
      return;
    }

    if(s->mode == EVERYBODY_MOVE || s->mode == CAT_ATTACK || s->mode == MODE_INTRO) {
      fprintf(stderr, "%d Tried to place arrow while EVERYBODY_MOVE or CAT_ATTACK or MODE_INTRO dir.\n", input.player_num);
      return;
    }
  }

  if(s->type == PUZZLE) {
    if(s->state != NOT_STARTED) {
      fprintf(stderr, "%d tried to place arrow in puzzle while already started.\n", input.player_num);
      return;
    }
  }

  if(!free_for_arrow(s, input.pos, input.player_num))
    return;

  if(s->type == BATTLE) {
    
    /* find the oldest arrow to replace */
    for(i=0; i<BATTLE_MAX_ARROW; i++)
      if(s->player[input.player_num].arrow[i].exists) {
	if(s->player[input.player_num].arrow[i].age > age) {
	  age = s->player[input.player_num].arrow[i].age;
	  best = i;
	}
      }
      else { /* that arrow isn't in use */
	age = -1;
	best = i;
	break;
      }
  }
  else if(s->type == PUZZLE) {

    if(s->map.max_arrow[input.dir] < 1)
      return;

    /* check removal */
    for(p=0; p<MAX_PLAYER; p++)
      if(s->player[p].exists)
	for(i=0; i<MAX_ARROW; i++)
	  if(s->player[p].arrow[i].exists)
	    if(s->player[p].arrow[i].pos.x == input.pos.x &&
	       s->player[p].arrow[i].pos.y == input.pos.y &&
	       s->player[p].arrow[i].dir == input.dir
	       ) {
	      s->player[p].arrow[i].exists = 0;
	      calculate_turn_square(s, s->player[p].arrow[i].pos.x, s->player[p].arrow[i].pos.y);
	      return;
	    }

    /* switching */
    for(p=0; p<MAX_PLAYER; p++)
      if(s->player[p].exists)
	for(i=0; i<MAX_ARROW; i++)
	  if(s->player[p].arrow[i].pos.x == input.pos.x &&
	     s->player[p].arrow[i].pos.y == input.pos.y
	     ) {
	    s->player[p].arrow[i].exists = 0;
	    calculate_turn_square(s, s->player[p].arrow[i].pos.x, s->player[p].arrow[i].pos.y);
	  }
    
    /* find the oldest arrow to replace */
    for(p=0; p<MAX_PLAYER; p++)
      if(s->player[p].exists) {
	for(i=0; i<MAX_ARROW; i++)
	  if(s->player[p].arrow[i].exists) {
	    if(s->player[p].arrow[i].dir == input.dir) {
	      if(s->player[p].arrow[i].age > age) {
		age = s->player[p].arrow[i].age;
		best = i;
		bestp = p;
	      }
	    }
	  }
	  else if(arrow_dir_count(s, input.dir) + 1 <= s->map.max_arrow[input.dir]){ /* that arrow isn't in use */
	    age = -1;
	    best = i;
	    goto DONE;
	  }
      }
    
  }

 DONE:


  if(age >= 0) { /* we're replacing an old one */
    s->player[bestp].arrow[best].exists = 0;

    calculate_turn_square(s, s->player[bestp].arrow[best].pos.x, s->player[bestp].arrow[best].pos.y);
  }

  a.exists = 1;
  a.health = ARROW_TOUGHNESS-1;
  a.dir = input.dir;
  a.pos = input.pos;
  a.age = 0;
  a.time_left = ARROW_DURATION*1000;

  s->player[input.player_num].arrow[best] = a;

  calculate_turn_square(s, a.pos.x, a.pos.y);

  /* keep track of which is oldest */

  for(p=0; p<MAX_PLAYER; p++)
    if(s->player[p].exists)
      for(i=0; i<MAX_ARROW; i++)
	if(s->player[p].arrow[i].exists)
	  s->player[p].arrow[i].age++;

  send_out_player_update(s);
}

void add_creature(sim *s, creature to_add)
{
  int i=0;
  net_event e;

  while(s->creature[i].exists)
    i++;
  if(i>=MAX_CREATURE)
    return;
  to_add.exists = 1;
  s->creature[i] = to_add;

  if(s->export_net_events) {
    e.type = ADD_CREATURE;
    e.time = s->elapsed;
    e.data.add_creature.creature = s->creature[i];
    e.data.add_creature.index = i;
    export_net_event(e);
  }
}

/* the following two functions are used in move_forward */

int nextf(float x)
{
  if(x==ceil(x))
    return (int)x+1;
  else
    return (int)ceil(x);
}

int nextb(float x)
{
  if(x==floor(x))
    return (int)x-1;
  else
    return (int)floor(x);
}
  
void move_forward(creature *guy, float * step)
{
  int top;
  switch(guy->dir) {
  case RIGHT:
    top = nextf(guy->pos.x);
    if(guy->pos.x + *step < top) {
      guy->pos.x += *step;
      *step = 0;
    }
    else {
      *step -= top - guy->pos.x;
      guy->pos.x = top;
    }
    break;
  case LEFT:
    top = nextb(guy->pos.x);
    if(guy->pos.x - *step > top) {
      guy->pos.x -= *step;
      *step = 0;
    }
    else {
      *step -= guy->pos.x - top;
      guy->pos.x = top;
    }
    break;
  case DOWN:
    top = nextf(guy->pos.y);
    if(guy->pos.y + *step < top) {
      guy->pos.y += *step;
      *step = 0;
    }
    else {
      *step -= top - guy->pos.y;
      guy->pos.y = top;
    }
    break;
  case UP:
    top = nextb(guy->pos.y);
    if(guy->pos.y - *step > top) {
      guy->pos.y -= *step;
      *step = 0;
    }
    else {
      *step -= guy->pos.y - top;
      guy->pos.y = top;
    }
    break;
  }
}

float qmouse_type_chance(int type)
{
  switch(type) {
  case Q_MOUSE_MANIA: return MOUSE_MANIA_P; break;
  case Q_CAT_MANIA: return CAT_MANIA_P; break;
  case Q_SPEED_UP: return SPEED_UP_P; break;
  case Q_SLOW_DOWN: return SLOW_DOWN_P; break;
  case Q_MOUSE_MONOPOLY: return MOUSE_MONOPOLY_P; break;
  case Q_CAT_ATTACK: return CAT_ATTACK_P; break;
  case Q_EVERYBODY_MOVE: return EVERYBODY_MOVE_P; break;
  case Q_PLACE_ARROWS_AGAIN: return PLACE_ARROWS_AGAIN_P; break;
  default: fprintf(stderr, "no such qmouse type.\n"); return 0; break;
  }
}

int pick_qmouse_type()
{
  float roll = ((float)(rand()%(100*100)))/100;
  float sum=0;
  int i;

  /*  return Q_MOUSE_MONOPOLY;*/
  
  for(i=0; i<MAX_QMOUSE_TYPE; i++) {
    sum += qmouse_type_chance(i);
    if(roll < sum)
      return i;
  }

  fprintf(stderr, "qmouse types mustn't have added to 100%%\n");
  return Q_MOUSE_MANIA;
}

void set_next_rockets(sim *s)
{
  int i,j;
  int new_spot[MAX_PLAYER];
  int goodspot, good;

  /* TODO: this is dir lock up with only one player */

  for(i=0; i<MAX_PLAYER; i++)
    if(s->player[i].exists)
      s->player[i].last_rocket = s->player[i].current_rocket;

  do {
    for(i=0; i<MAX_PLAYER; i++)
      if(s->player[i].exists) {
	do {
	  new_spot[i] = rand()%MAX_PLAYER;
	  goodspot = 1;

	  if(new_spot[i] == i)
	    goodspot = 0;

	  if(!s->player[new_spot[i]].exists)
	    goodspot = 0;

	} while(!goodspot);
      }  
    
    good = 1;

    /* make sure no two players have the same new spot */
    
    for(i=0; i<MAX_PLAYER; i++)
      if(s->player[i].exists)
	for(j=0; j<MAX_PLAYER; j++)
	  if(s->player[j].exists)
	    if(j != i && new_spot[j] == new_spot[i])
	      good = 0;
    
  } while(!good);

  for(i=0; i<MAX_PLAYER; i++)
    if(s->player[i].exists)
      s->player[i].current_rocket = s->player[new_spot[i]].last_rocket;
}

void handle_qmouse(sim *s, int player, int type)
{
  int i,j;

  /* so that things like everybody move cancel it */
  s->mode = NORMAL;

  switch(type) {
  case Q_MOUSE_MANIA:
    s->mode = MOUSE_MANIA;
    s->mode_timer = MOUSE_MANIA_L;

    /* get rid of cats */
    for(i=0; i<MAX_CREATURE; i++)
      if(s->creature[i].type == cat)
	s->creature[i].exists = 0;
    break;
  case Q_CAT_MANIA:
    s->mode = CAT_MANIA;
    s->mode_timer = CAT_MANIA_L;

    for(i=0; i<MAX_CREATURE; i++)
      s->creature[i].exists = 0;
    break;
  case Q_SPEED_UP:
    s->mode = SPEED_UP;
    s->mode_timer = SPEED_UP_L;
    break;
  case Q_SLOW_DOWN:
    s->mode = SLOW_DOWN;
    s->mode_timer = SLOW_DOWN_L;
    break;
  case Q_MOUSE_MONOPOLY:
    s->mode = MOUSE_MONOPOLY;
    s->mode_timer = MOUSE_MONOPOLY_L;
    s->mode_player = player;
    break;
  case Q_CAT_ATTACK:
    s->mode = CAT_ATTACK;
    s->mode_timer = CAT_ATTACK_L;
    s->mode_player = player;
    break;
  case Q_EVERYBODY_MOVE:
    s->mode = EVERYBODY_MOVE;
    s->mode_timer = EVERYBODY_MOVE_L;

    set_next_rockets(s);
    send_out_player_update(s);
    break;
  case Q_PLACE_ARROWS_AGAIN:

    s->mode = PLACE_ARROWS_AGAIN;
    s->mode_timer = PLACE_ARROWS_AGAIN_L;

    for(i=0; i<MAX_PLAYER; i++)
      if(s->player[i].exists)
	for(j=0; j<MAX_ARROW; j++)
	  if(s->player[i].arrow[j].exists) {
	    s->player[i].arrow[j].exists = 0;
	    calculate_turn_square(s, s->player[i].arrow[j].pos.x, s->player[i].arrow[j].pos.y);
	  }

    break;
  default:
    fprintf(stderr, "No such qmouse type: %d\n", type);
  }
}

void apply_creature(sim *s, int player, creature_type creature, int x, int y)
{
  int old;
  int rocket;
  net_event e;

  rocket = player;
  player = s->player[player].team_leader;

  switch(creature) {
  case cat:
    old = s->player[player].score;
    s->player[player].score = s->player[player].score*2/3;
    s->score_change[x][y] = s->player[player].score;
    s->score_change[x][y] -= old;
    s->score_change_timer[x][y] = SCORE_CHANGE_L;

    if(s->type == PUZZLE) {
      s->state = POST_GAME;
      s->state_timer = POST_GAME_LENGTH;
    }

    sim_handle_output_event(s, GET_CAT, x, y, 0);
    break;
  case mouse:
    s->player[player].score++;

    if(s->type == PUZZLE && s->player[player].score == map_creature_count(&s->map, mouse)) {
      s->state = POST_GAME;
      s->state_timer = POST_GAME_LENGTH;
    }

    sim_handle_output_event(s, GET_MOUSE, x, y, 0);
    break;
  case mouse50:
    s->player[player].score += 50;
    s->score_change[x][y] = 50;
    s->score_change_timer[x][y] = SCORE_CHANGE_L;
    sim_handle_output_event(s, GET_MOUSE_50, x, y, 0);
    break;
  case mouseq:
    if(s->authority) {
      sim_handle_output_event(s, GET_MOUSE_Q, x, y, 0);
      
      s->mode = MODE_INTRO;
      s->mode_timer = MODE_INTRO_L;
      s->mode_player = player;
      s->next_mode = pick_qmouse_type();

      switch(s->next_mode) {
      case Q_EVERYBODY_MOVE:
	printf("Everybody move!\n");
	break;
      case Q_MOUSE_MONOPOLY:
	printf("Mouse monopoly!\n");
	break;
      case Q_MOUSE_MANIA:
	printf("Mouse mania!\n");
	break;
      case Q_CAT_MANIA:
	printf("Cat mania!\n");
	break;
      case Q_SLOW_DOWN:
	printf("Slow down!\n");
	break;
      case Q_SPEED_UP:
	printf("Speed up!\n");
	break;
      case Q_CAT_ATTACK:
	printf("Cat attack!\n");
	break;
      case Q_PLACE_ARROWS_AGAIN:
	printf("Place arrows again!\n");
	break;
      }

      if(s->export_net_events) {
	e.type = MODE_UPDATE;
	e.time = s->elapsed;
	e.data.mode_update.mode = s->mode;
	e.data.mode_update.next_mode = s->next_mode;
	e.data.mode_update.mode_timer = s->mode_timer;
	e.data.mode_update.mode_player = s->mode_player;
	export_net_event(e);
      }

    }
    break;
  default:
    printf("unknown creature type: %d.\n", creature);
    break;
  }

  if(s->player[player].score > MAX_SCORE)
    s->player[player].score = MAX_SCORE;

}  
    

void check_collisions(sim *s, creature *guy) /* guy is at a square */
{
  int i,x,y;
  x = (int)floor(guy->pos.x+.5);
  y = (int)floor(guy->pos.y+.5);

  if(s->map.rocket[x][y] >= 0) {
    i = sim_rocket_owner(s, x, y);
    if(i >= 0) {
      apply_creature(s, i, guy->type, x, y);
      guy->exists = 0;
    }
  }

}

void leave_mode(sim *s)
{
  int i;
  int x,y;

  switch(s->mode) {
  case MODE_INTRO:
    handle_qmouse(s, s->mode_player, s->next_mode);
    break;
  case CAT_MANIA:
    for(i=0; i<MAX_CREATURE; i++)
      s->creature[i].exists = 0;
    s->mode = NORMAL;
    break;
  case CAT_ATTACK:
    for(i=0; i<MAX_PLAYER; i++)
      if(s->player[i].exists && s->player[i].team_leader!= s->mode_player)
	for(x=0; x<NUM_BLOCKS_X; x++)
	  for(y=0; y<NUM_BLOCKS_Y; y++)
	    if(sim_rocket_owner(s, x, y) == i)
	      apply_creature(s, i, cat, x, y);
    s->mode = NORMAL;
    break;
  default:
    s->mode = NORMAL;
    break;
  }
}


direction turn_from_arrows(sim *s, int dir, int x, int y)
{
  int i, j;

  for(i=0; i<MAX_PLAYER; i++)
    if(s->player[i].exists)
      for(j=0; j<MAX_ARROW; j++)
	if(s->player[i].arrow[j].exists)
	  if(s->player[i].arrow[j].pos.x == x && s->player[i].arrow[j].pos.y == y)
	    return s->player[i].arrow[j].dir;

  return dir;
}

int blocked_in_dir(sim *s, direction dir, int x, int y)
{
  switch(dir) {
  case RIGHT:
    if(s->map.vwall[(x+1)%NUM_BLOCKS_X][y])
      return 1;
    break;
  case LEFT:
    if(s->map.vwall[x][y])
      return 1;
    break;
  case DOWN:
    if(s->map.hwall[x][(y+1)%NUM_BLOCKS_Y])
      return 1;
    break;
  case UP:
    if(s->map.hwall[x][y])
      return 1;
    break;
  }

  return 0;
}  

direction turn_from_walls(sim *s, direction dir, int x, int y)
{
  if(blocked_in_dir(s, dir, x, y)) {
    /* try turning right */
    if(!blocked_in_dir(s, (dir+1)%MAX_DIR, x, y))
      return (dir+1)%MAX_DIR;

    /* then try left */
    if(!blocked_in_dir(s, (dir-1+MAX_DIR)%MAX_DIR, x, y))
      return (dir-1+MAX_DIR)%MAX_DIR;
    
    /* otherwise turn around */
    return (dir+2)%MAX_DIR;
  }
  else
    return dir;
}

void calculate_turn(sim *s, grid_int x, grid_int y, direction dir)
{
  int i;
  direction start = dir;

  if(x>=NUM_BLOCKS_X || y>=NUM_BLOCKS_Y || start >= MAX_DIR) {
    fprintf(stderr, "out of bounds for turn!\n");
    return;
  }

  dir = turn_from_arrows(s, dir, x, y);

  for(i=0; i<3; i++) /* apply up to three walls */
    dir = turn_from_walls(s, dir, x, y);

  s->turn[x][y][start] = dir;
}

void calculate_turn_square(sim *s, grid_int x, grid_int y)
{
  direction dir;
  for(dir=0; dir<MAX_DIR; dir++)
    calculate_turn(s, x, y, dir);
}

void calculate_all_turns(sim *s)
{
  int x, y;

  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++)
      calculate_turn_square(s, x, y);
}

direction turn(sim *s, int x, int y, direction dir)
{
  return s->turn[x][y][dir];
}

void turn7(sim *s, int i)
{
  int x, y, p, j, old_dir;

  check_collisions(s, &s->creature[i]);

  if(s->creature[i].exists) {

    x = (int)floor(s->creature[i].pos.x+.5);
    y = (int)floor(s->creature[i].pos.y+.5);

    old_dir = s->creature[i].dir;

    s->creature[i].dir = turn(s, x, y, s->creature[i].dir);

    /* cats hurt arrows */
    if(s->creature[i].type == cat)
      for(p=0; p<MAX_PLAYER; p++)
	if(s->player[p].exists)
	  for(j=0; j<MAX_ARROW; j++)
	    if(s->player[p].arrow[j].exists)
	      if(s->player[p].arrow[j].pos.x == x &&
		 s->player[p].arrow[j].pos.y == y)
		if((old_dir+2)%MAX_DIR == s->player[p].arrow[j].dir) {
		  if(s->player[p].arrow[j].health == 0) {
		    s->player[p].arrow[j].exists = 0;
		    calculate_turn_square(s, x, y);
		  }
		  s->player[p].arrow[j].health--;
		}
    
  }
}

int on_square(grid_float_position pos)
{
  return pos.x == floor(pos.x) && pos.y == floor(pos.y);
}

void add_floater(sim *s, int type, float px, float py, int target, direction dir)
{
  int i;

  int x, y;

  float mindist = NUM_BLOCKS_X + NUM_BLOCKS_Y;
  int minx=0, miny=0;

  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++)
      if(sim_rocket_owner(s, x, y) == target)
	if(hypot2(x - px, y - py) < mindist) {
	  mindist = hypot2(x - px, y - py);
	  minx = x;
	  miny = y;
	}

  for(i=0; i<MAX_CREATURE; i++) {
    if(!s->floater[i].exists) {
      s->floater[i].type = type;
      s->floater[i].pos.x = px;
      s->floater[i].pos.y = py;
      s->floater[i].target.x = minx;
      s->floater[i].target.y = miny;
      s->floater[i].old_dir = dir;
      s->floater[i].exists = 1;
      return;
    }
  }
}

int sign(float x)
{
  return x>0?1:-1;
}

int sim_generation_freq(sim *s)
{
  return GENERATION_FREQ/(s->mode==MOUSE_MANIA ? 2 : 1);
}

void sim_small_step(sim *s, int ms)
{
  int i,j,x,y;
  int old;

  float step_size;
  float oldx, oldy;
  float x_per, xv, yv;

  creature guy;

  creature ctemp;

  /* float mice in mouse monopoly */
  if(s->mode == MOUSE_MONOPOLY)
    for(i=0; i<MAX_CREATURE; i++)
      if(s->creature[i].exists && s->creature[i].type != cat) {
	s->creature[i].exists = 0;
	add_floater(s, s->creature[i].type, s->creature[i].pos.x, s->creature[i].pos.y, s->mode_player, s->creature[i].dir);
      }

  /* move floaters */
  for(i=0; i<MAX_CREATURE; i++)
    if(s->floater[i].exists) {
      oldx = s->floater[i].pos.x;
      oldy = s->floater[i].pos.y;
      
#define FLOAT_SLOWDOWN 500
#define PLUS_FACTOR .003
      
      xv = (s->floater[i].target.x - s->floater[i].pos.x)/FLOAT_SLOWDOWN;
      yv = (s->floater[i].target.y - s->floater[i].pos.y)/FLOAT_SLOWDOWN;
      
      x_per = abs2(xv)/(abs2(xv) + abs2(yv));
      
      xv += sign(xv)*x_per*PLUS_FACTOR;
      yv += sign(yv)*(1-x_per)*PLUS_FACTOR;

      s->floater[i].pos.x += xv * ms;
      s->floater[i].pos.y += yv * ms;

      /* if it switches sides */
      if((oldx - s->floater[i].target.x) *
	 (s->floater[i].pos.x - s->floater[i].target.x)
	 < 0
	 ||
	 (oldy - s->floater[i].target.y) *
	 (s->floater[i].pos.y - s->floater[i].target.y)
	 < 0
	 )
	{
	  guy.exists = 1;
	  guy.pos.x = s->floater[i].target.x;
	  guy.pos.y = s->floater[i].target.y;
	  guy.type = s->floater[i].type;

	  check_collisions(s, &guy);

	  s->floater[i].exists = 0;
	}
    }

  /* if we're in a 'clock ticking' mode */
  if((s->type == BATTLE && s->mode != PLACE_ARROWS_AGAIN && s->mode != EVERYBODY_MOVE && s->mode != CAT_ATTACK && s->mode != MODE_INTRO) ||
     (s->type == PUZZLE)) {

    /* arrow timeouts */
    if(s->type == BATTLE)
      for(i=0; i<MAX_PLAYER; i++)
	if(s->player[i].exists)
	  for(j=0; j<MAX_ARROW; j++)
	    if(s->player[i].arrow[j].exists) {
	      if(ms > s->player[i].arrow[j].time_left) {
		s->player[i].arrow[j].time_left = 0;
		s->player[i].arrow[j].exists = 0;
		calculate_turn_square(s, s->player[i].arrow[j].pos.x, s->player[i].arrow[j].pos.y);
	      }
	      else
		s->player[i].arrow[j].time_left -= ms;
	    }

    /* move creatures forward */
    for(i=0; i<MAX_CREATURE; i++)
      if(s->creature[i].exists) {
	step_size = ((float)ms)/1000;

	if(s->mode==SPEED_UP)
	  step_size*=2;
	if(s->mode==SLOW_DOWN)
	  step_size/=2;

	switch(s->creature[i].type) {
	case cat:
	  step_size *= CAT_SPEED;
	  break;
	case mouse:
	case mouse50:
	default:
	  step_size *= MOUSE_SPEED;
	  break;
	}

	if(on_square(s->creature[i].pos))
	  turn7(s, i);

	while(step_size > 0 && s->creature[i].exists) {

	  move_forward(&s->creature[i], &step_size);
	  
	  /* handle wrapping */
	  
	  if(s->creature[i].pos.x > NUM_BLOCKS_X-.5)
	    s->creature[i].pos.x -= NUM_BLOCKS_X;
	  if(s->creature[i].pos.x < -.5)
	    s->creature[i].pos.x += NUM_BLOCKS_X;

	  if(s->creature[i].pos.y > NUM_BLOCKS_Y-.5)
	    s->creature[i].pos.y -= NUM_BLOCKS_Y;
	  if(s->creature[i].pos.y < -.5)
	    s->creature[i].pos.y += NUM_BLOCKS_Y;
	  
	  if(on_square(s->creature[i].pos))
	    if(s->map.hole[(int)s->creature[i].pos.x][(int)s->creature[i].pos.y]) {
	      if(s->type == PUZZLE && s->creature[i].type == mouse) {
		s->state = POST_GAME;
		s->state_timer = POST_GAME_LENGTH;
	      }

	      s->creature[i].exists = 0;
	    }

	  if(step_size > 0)
	    turn7(s, i);
	}
      }

    /* check cat collisions w/ mice */
    for(i=0; i<MAX_CREATURE; i++)
      if(s->creature[i].exists && s->creature[i].type == cat)
	for(j=0; j<MAX_CREATURE; j++)
	  if(s->creature[j].exists && s->creature[j].type != cat) {
	    
	    if(hypot2(s->creature[i].pos.x - s->creature[j].pos.x, s->creature[i].pos.y - s->creature[j].pos.y) < .5) {
	      s->creature[j].exists = 0;
	      
	      if(s->type == PUZZLE) {
		s->state = POST_GAME;
		s->state_timer = POST_GAME_LENGTH;
	      }
	      
	      sim_handle_output_event(s, MOUSE_DEATH, s->creature[j].pos.x, s->creature[j].pos.y, s->creature[j].dir);
	    }
	  }

  }

  /* this has to be in here for timing purposes */

  /* update mode timer */
  if(s->mode != NORMAL) {
    if(ms >= s->mode_timer) {
      s->mode_timer = 0;
      leave_mode(s);
    }
    else
      s->mode_timer -= ms;
  }

  /* update elapsed */
  old = s->elapsed;
  s->elapsed += ms;



  if(s->mode != PLACE_ARROWS_AGAIN && s->mode != EVERYBODY_MOVE && s->mode != CAT_ATTACK && s->mode != MODE_INTRO) {
    /* generate */
    if(s->authority)
      if(s->map.max_generator > 0)
	if(s->elapsed%(sim_generation_freq(s)/s->map.max_generator) < old%(sim_generation_freq(s)/s->map.max_generator)) {
	  for(i=0; i<s->map.max_generator; i++) {
	    if(i == s->elapsed/(sim_generation_freq(s)/s->map.max_generator)%s->map.max_generator) {
	      ctemp.pos.x = s->map.generator[i].pos.x;
	      ctemp.pos.y = s->map.generator[i].pos.y;
	      ctemp.dir = s->map.generator[i].dir;
	      ctemp.type = -1;
	    
	      if(s->mode == CAT_MANIA && creature_count(s, cat) < MAX_CAT)
		ctemp.type = cat;
	      else if(s->mode != CAT_MANIA) {
		if(creature_count(s, cat) < 1 && s->mode != MOUSE_MANIA)
		  ctemp.type = cat;
		else {
		  if(rand()%MOUSE50_FREQ==0)
		    ctemp.type = mouse50;
		  else {
		    if( creature_count(s, mouseq) < 1 &&
			(s->mode == NORMAL ||
			 s->mode == SPEED_UP ||
			 s->mode == SLOW_DOWN)
			&& rand()%MOUSEQ_FREQ==0 )
		      ctemp.type = mouseq;
		    else
		      ctemp.type = mouse;
		  }
		}
	      }

	      if(ctemp.type == cat || s->mode != CAT_MANIA)
		add_creature(s, ctemp);
	    
	    }
	  }
	}

    if(s->type == BATTLE) {
      /* update clock */
      if(ms >= s->clock) {
	s->clock = 0;
	s->state = POST_GAME;
	s->state_timer = POST_GAME_LENGTH;
      }
      else
	s->clock -= ms;
    }
    else
      s->clock += ms;
  }

  /* lower score change timers */
  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++) {
      if(s->score_change_timer[x][y] > 0) {
	if(s->score_change_timer[x][y] < ms) {
	  s->score_change_timer[x][y] = 0;
	}
	else
	  s->score_change_timer[x][y] -= ms;
      }
    }
  
}

void sim_step(sim *s, Uint32 ms)
{
  if(ms<0) {
    fprintf(stderr, "Trying to step negatively\n");
    return;
  }

  if(s->state == POST_GAME) {
    if(s->state_timer <= ms) {
      s->state_timer = 0;
      s->state = FINISHED;
    }
    else
      s->state_timer -= ms;
  }

  if(s->state != PLAYING)
    return;

  if(s->type == BATTLE)
    if(s->mode != MODE_INTRO && s->mode != CAT_ATTACK && s->mode != EVERYBODY_MOVE && s->mode != PLACE_ARROWS_AGAIN)
      if(ms > s->clock) /* don't go past zero */
	ms = s->clock;

  while(ms > MAX_STEP_SIZE) {
    sim_small_step(s, MAX_STEP_SIZE);
    ms -= MAX_STEP_SIZE;
  }
  
  sim_small_step(s, ms);
}


    

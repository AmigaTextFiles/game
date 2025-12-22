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

#include <stdio.h>
#include <time.h>
#include <math.h>
#include "SDL.h" /* for timing */

#include "protocol.h"
#include "sim.h"
#include "input_queue.h"
#include "ai.h"

double best, startvalue;
input_type bestmove;

int at_x[MAX_PLAYER], at_y[MAX_PLAYER], at_dir[MAX_PLAYER];

time_t stoptime;
sim pred;

double get_value(sim *s, int player)
{
  int i;
  int nextbest = 0;
  int othersum = 0;
  int enemy_count = 0;
  for(i=0; i<MAX_PLAYER; i++)
    if(s->player[i].exists) {
      if(i!=s->player[i].team_leader)
	continue;
      if(i==player)
	continue;

      enemy_count++;
      
      if(s->player[i].score > nextbest)
	nextbest = s->player[i].score;

      othersum += s->player[i].score;
    }

  return s->player[s->player[player].team_leader].score*(enemy_count+1) - nextbest - othersum;
}

void finish(input_queue *q)
{
  if(best-.1 > startvalue)
    input_enqueue(q, bestmove.player_num, bestmove.dir, bestmove.pos);
}

int try(sim *s, input_queue *q, int player, int x, int y, direction dir, int look_for)
{
  grid_int_position pos;
  input_type move;
  int value;

  pos.x = x;
  pos.y = y;

  if(!free_for_arrow(s, pos, player))
    return 0;
  
  pred = *s;
  pred.authority = 0;
  pred.export_net_events = 0;
  pred.export_output_events = 0;
  
  move.player_num = player;
  move.dir = dir;
  move.pos = pos;
  
  process_input(&pred, move);
  
  sim_step(&pred, LOOKAHEAD);
  
  value = get_value(&pred, player);
  
  if(value > best) {
    best = value;
    bestmove = move;
  }
  
  if(SDL_GetTicks() > stoptime) {
    finish(q);
    return 1;
  }
  
  return 0;
}
  

void ai_go(sim *s, input_queue *q, int player, int time)
{
  direction dir;
  grid_int_position pos;
 
  int x, y, i, factor;

  int guy_at[NUM_BLOCKS_X+1][NUM_BLOCKS_Y+1];

  if(s->state != PLAYING)
    return;

  if(s->mode == EVERYBODY_MOVE || s->mode == CAT_ATTACK || s->mode == MODE_INTRO)
    return;

  stoptime = SDL_GetTicks() + time;

  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++)
      guy_at[x][y] = 0;

  for(i=0; i<MAX_CREATURE; i++)
    if(s->creature[i].exists) {
      guy_at[(int)s->creature[i].pos.x][(int)s->creature[i].pos.y] = 1;
      /*
      if((int)s->creature[i].x > 0)
	guy_at[(int)s->creature[i].x-1][(int)s->creature[i].y] = 1;
      if((int)s->creature[i].y > 0)
	guy_at[(int)s->creature[i].x][(int)s->creature[i].y-1] = 1;
      guy_at[(int)s->creature[i].x+1][(int)s->creature[i].y] = 1;
      guy_at[(int)s->creature[i].x][(int)s->creature[i].y+1] = 1;
      */
    }

  pred = *s;
  pred.authority = 0;
  pred.export_net_events = 0;
  pred.export_output_events = 0;
  sim_step(&pred, LOOKAHEAD);
  startvalue = get_value(&pred, player);
  best = startvalue;

  x = at_x[player];
  y = at_y[player];
  dir = at_dir[player];
  
  for(factor=1; factor<=2; factor++) {
    for(; x<NUM_BLOCKS_X; x++) {
      for(; y<NUM_BLOCKS_Y; y++) {
	if(guy_at[x][y]) {
	  pos.x = x;
	  pos.y = y;
      
	  if(free_for_arrow(s, pos, player)) {
	    for(; dir<4; dir++) {
	      if(try(s, q, player, x, y, dir, LOOKAHEAD*factor)) {
		at_x[player] = x;
		at_y[player] = y;
		at_dir[player] = dir+1;

		return;
	      }
	    }
	    dir = 0;
	  }
	}
      }
      y = 0;
    }
    x = 0;
  }
}
	

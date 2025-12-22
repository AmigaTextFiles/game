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

#include "sim.h"
#include "game.h"
#include "input_queue.h"
#include "game_input.h"
#include "output.h"
#include "ai.h"
#include "client.h"
#include "server.h"
#include "protocol.h"
#include "game_output.h"
#include "main.h"

void add_local_players(game *g)
{
  int i,j;

  for(i=0; i<g->local_player_count; i++)
    for(j=0; j<MAX_PLAYER; j++)
      if(g->have_local_player[j])
	if(g->local_player_type[j] == UNKNOWN_PLAYER) {
	  g->local_player_type[j] = KEYBOARD_PLAYER;
	  break;
	}

  for(i=0; i<g->local_ai_count; i++)
    for(j=0; j<MAX_PLAYER; j++)
      if(g->have_local_player[j])
	if(g->local_player_type[j] == UNKNOWN_PLAYER) {
	  g->local_player_type[j] = AI_PLAYER;
	  break;
	}
}

void game_clear(game *g)
{
  int i;

  for(i=0; i<MAX_PLAYER; i++)
    g->have_local_player[i] = 0;
  
  g->okay_to = 0;
  g->finished = 0;
  g->restart = 0;

  sim_clear(&g->sim);
}

void game_start(game *g, game_settings *gs)
{
  int i;

  fprintf(stderr, "Starting game.\n");

  game_clear(g);

  g->okay_to = 0;

  if(gs->teams) {
    g->sim.player[1].team_leader = 0;
    g->sim.player[3].team_leader = 2;
  }

  g->type = gs->type;

  g->local_player_count = gs->local_player_count;
  g->local_ai_count     = gs->local_ai_count;
  g->option.client = gs->client;
  g->option.server = gs->server;
  g->option.daemon = gs->daemon;

  for(i=0; i<MAX_PLAYER; i++) {
    g->have_local_player[i] = gs->have_local_player[i];
    g->local_player_type[i] = UNKNOWN_PLAYER;
  }
  
  sim_use_map(&g->sim, &gs->map);
  g->sim.type = g->type;
  
  /* . */
  
  if(g->option.server) {
    g->sim.export_net_events = 1;
  }
  
  if(g->option.client)
    g->sim.authority = 0;
  else
    g->sim.authority = 1;
  
  add_local_players(g);
  
  g->sim.export_output_events = 1;
  g->sim.game = g;
  
  sim_new_game(&g->sim);
  
  /* need to init game input before output because output can tell input output changed */
  game_input_start(g);
  
  /* need to init game output before sim_start because sim_start can trigger output events */
  
  if(!g->option.daemon)
    game_output_init(g, opengl?GL:SDL);
  
  if(g->type == BATTLE)
    if(!g->option.client && !g->option.server)
      sim_start(&g->sim);
  
}

void game_restart(game *g)
{
  game_output_exit(g);
  game_input_exit(g);
  g->restart = 1;
}

void game_exit(game *g)
{
  game_output_exit(g);
  game_input_exit(g);
  g->finished = 1;
}

void game_step(game *g, int ms)
{
  int i;
  input_type temp_input;
  
  if(!g->option.daemon)
    game_input_step(g, ms);
  
  for(i=0; i<MAX_PLAYER; i++)
    if(g->have_local_player[i])
      if(g->local_player_type[i] == AI_PLAYER)
	ai_go(&g->sim, &g->local_input, i, 1);
  
  while(g->local_input.head != g->local_input.tail) {
    temp_input = input_dequeue(&g->local_input);
    
    if(g->option.client)
      client_send(C_PROCESS_INPUT, temp_input);
    else
      process_input(&g->sim, temp_input);
  }
  
  if(g->option.client) {
    if(!client_step(g, ms))
      game_exit(g);
  }
  else {
    sim_step(&g->sim, ms);
    
    if(g->option.server)
      server_broadcast_okay_to(g->sim.elapsed);
    
    if(g->option.server)
      server_step(g, ms);
  }
  
  if(g->sim.state == FINISHED)
    game_exit(g);
}
  
int game_handle_event(game *g, SDL_Event e)
{
  return game_input_handle_event(g, e);
}


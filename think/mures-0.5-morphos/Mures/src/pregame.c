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
#include <stdio.h>
#include "pregame.h"
#include "game.h"
#include "client.h"
#include "server.h"
#include "gui.h"

void pregame_start(pregame *p, pregame_settings *ps)
{
  int i;

  printf("Starting pregame.\n");

  p->finished = 0;
  
  p->gs.server = ps->server;
  p->gs.daemon = ps->daemon;
  p->gs.type = ps->type;
  
  /* TODO: make client get teams value from server */
  p->gs.teams  = ps->teams;
  
  p->gs.local_player_count = ps->local_player_count;
  p->gs.local_ai_count     = ps->local_ai_count;
  
  /* game_client_connect gets the following:
       map
       have_local_player
     and requires
       local_ai_count
       local_player_count
  */
  
  if(ps->client) {
    p->gs.client = 1;
    
    if(!game_client_connect(ps->host, &p->gs)) {
      fprintf(stderr, "Couldn't start client, quitting.\n");
      exit(1);
    }
  }
  else {
    p->gs.client = 0;
    
    /* insert local player slots */
    for(i=0; i<ps->local_player_count+ps->local_ai_count && i<MAX_PLAYER; i++)
      p->gs.have_local_player[i] = 1;
    for(; i<MAX_PLAYER; i++)
      p->gs.have_local_player[i] = 0;
    
    p->gs.map = *(ps->map);
  }
  
  if(ps->server) {
    if(!server_listen()) {
      fprintf(stderr, "Couldn't start server, quitting.\n");
      exit(1);
    }
  }
  
  p->finished = 1;
}


void pregame_step(pregame *p, int diff)
{
  /* if server and full start
     if client and we get start msg, start
     etc
  */
  
}



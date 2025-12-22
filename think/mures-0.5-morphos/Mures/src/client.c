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
#include "SDL_net.h"
#include "net_common.h"
#include "protocol.h"
#include "sim.h"
#include "main.h"
#include "lib.h"
#include "output.h"
#include "game.h"

int client_initialized = 0;
UDPsocket local_socket = NULL;
UDPpacket *packet;

#define PACKET_POOL_SIZE 20

struct
{
  int exists;
  Uint32 time;
  UDPpacket *packet;
} local_pool[PACKET_POOL_SIZE];

IPaddress server_ip;

void client_send(packet_type type, input_type input)
{
  int d=0;

  /*  printf("sending input to server for player %d.\n", input.player_num);*/

  PUSH(type);

  switch(type) {
  case C_PROCESS_INPUT:
    PUSH(input);
    break;

  case C_QUIT:
    /* no explanation necessary :) */
    break;

  default:
    fprintf(stderr, "Unknown type to send to server.\n");
    break;
  }

  packet->len = d;

  /*  printf(" len %d\n", d);*/

  packet->address = server_ip;

  if(!SDLNet_UDP_Send(local_socket, 0, packet)) {
    fprintf(stderr, "Sending packet to server failed.\n");
  }
}

void handle_packet(sim *s, UDPpacket *p)
{
  packet_type type;
  UDPpacket *temp = packet;
  net_event e;

  int d=0;

  packet = p;
  
  PULL(type);

  switch(type) {

  case S_GAME_EVENT:
    PULL(e);
    sim_process_net_event(s, e);
    break;

  case S_PLAYER_UPDATE:
    printf("got player update!\n");
    PULL(s->player);
    break;

  case S_OKAY_TO:
    printf("here.\n");
    break;

  default:
    printf("Unknown command: %d (%d) %d.\n", *(packet->data), type, d);
    break;
  }

  packet = temp;

}


int client_step(game *g, int ms)
{
  int count;
  packet_type type;
  int i,d,next;
  Uint32 time;
  int soonest, soonest_time;

  while(1) {
    d=0;
    count = SDLNet_UDP_Recv(local_socket, packet);
  
    if(count==0)
      break;

    if(count==-1)
      fprintf(stderr, "Socket error.\n");

    if(packet->channel != 0) {
      printf("Got packet from unknown place.\n");
    }
    else {
      if(packet->len==0)
	return 1;

      PULL(type);

      if(type != S_PLAYER_UPDATE) {
	PULL(time);
	if(time > g->okay_to)
	  g->okay_to = time;
	
	if(type == S_OKAY_TO)
	  continue;
	
	for(i=0; i<PACKET_POOL_SIZE; i++)
	  if(!local_pool[i].exists) {
	    local_pool[i].exists = 1;
	    local_pool[i].time = time;
	    
	    memcpy(&local_pool[i].packet->data[0], &packet->data[0], packet->maxlen);
	    
	    break;
	  }
      }
    }
  }

  next = g->sim.elapsed + ms;

  if(next > g->okay_to) {
/*      printf("getting ahead.\n"); */
    next = g->okay_to;
  }
  
  if(next+MAX_CLIENT_DELAY < g->okay_to) {
/*      printf("getting behind.\n"); */
    next = g->okay_to-MAX_CLIENT_DELAY/2;
  }

/*    printf("%d ms behind, %d elapsed.\n", g->okay_to-next, g->sim.elapsed); */

  while(1) {
    soonest = -1;
    soonest_time = next;
    
    for(i=0; i<PACKET_POOL_SIZE; i++)
      if(local_pool[i].exists) {
	if(local_pool[i].time <= soonest_time) {
	  soonest = i;
	  soonest_time = local_pool[i].time;
	}
      }

    if(soonest == -1)
      break;

    sim_step(&g->sim, soonest_time - g->sim.elapsed);

    handle_packet(&g->sim, local_pool[soonest].packet);

/*      printf("done handling packet %d.\n", soonest); */

    local_pool[soonest].exists = 0;
  }

/*    printf("stepping %d.\n", next-g->sim.elapsed); */

  sim_step(&g->sim, next - g->sim.elapsed);

  return 1;
}

void client_cleanup()
{
  input_type temp;

  /* TODO: fix this */
  printf("Disconnecting... this shouldn't be done here.\n");
  
  if(local_socket != NULL) {
    client_send(C_QUIT, temp);
    
    SDLNet_UDP_Close(local_socket);
  }
  
  printf("Freeing client network resources.\n");

  SDLNet_FreePacket(packet);
  
  SDLNet_Quit();
}

int client_init()
{
  int i;

  if(client_initialized) {
    fprintf(stderr, "Initializing client twice? this shouldn't happen.\n");
    return 0;
  }

  printf("Initializing client.\n");

  if(SDLNet_Init() < 0) {
    fprintf(stderr, "Couldn't initialize SDLNet: %s\n", SDLNet_GetError());
    exit(1);
  }

  printf("Allocating packets...\n");
  packet = SDLNet_AllocPacket(MAX_PACKET_SIZE);

  for(i=0; i<PACKET_POOL_SIZE; i++) {
    local_pool[i].exists = 0;
    local_pool[i].packet = SDLNet_AllocPacket(MAX_PACKET_SIZE);
  }

  atexit(client_cleanup);

  client_initialized = 1;

  return 1;
}  


int game_client_connect(char *host, game_settings *gs)
{
  int count, i, stoptime;
  int d;
  packet_type type;
  map m;
  Uint8 total_local;

  if(!client_initialized)
    client_init();
  
  printf("Connecting to %s.\n", host);
  
  local_socket = SDLNet_UDP_Open(1333);
  
  if(local_socket == NULL) {
    fprintf(stderr, "Couldn't open a local connection.\n");
    exit(1);
  }

  printf("Looking up host %s...\n", host);

  if(SDLNet_ResolveHost(&server_ip, host, DEFAULT_PORT) != 0) {
    fprintf(stderr, "Couldn't resolve an ip address: %s\n", SDLNet_GetError());
    exit(1);
  }

  printf("Resolved %s to %s\n", host, ip_string(server_ip));

  printf("Binding...\n");
  SDLNet_UDP_Bind(local_socket, 0, &server_ip);

  /* start connecting */
  
  printf("Probing server.\n");

  d=0;
  type = C_PROBE;

  PUSH(type);

  packet->len = d;

  if(!SDLNet_UDP_Send(local_socket, 0, packet)) {
    fprintf(stderr, "Couldn't send probe packet to server.\n");
    exit(1);
  }

  printf("Sent probe, waiting for response...\n");

  stoptime = SDL_GetTicks()+2000;

  while(1) {
    if(SDL_GetTicks() > stoptime) {
      fprintf(stderr, "Timed out.\n");
      return 0;
    }

    count = SDLNet_UDP_Recv(local_socket, packet);
  
    if(count==0)
      continue;

    if(count==-1) {
      fprintf(stderr, "Socket error.\n");
      return 0;
    }

    if(packet->channel != 0) {
      printf("Got packet from unknown place.\n");
      return 0;
    }
    else {
      if(packet->len==0)
	return 0;
      
      if(packet->data[0] == S_WELCOME) {
	printf("Got welcome.\n");
	if(packet->data[1] != PROTOCOL_VERSION) {
	  fprintf(stderr, "Couldn't connect to server: your version is not up to date.\n");
	  return 0;
	}
	break;
      }
      else if(packet->data[0] == S_NOT_WELCOME) {
	printf("Server isn't accepting connections (probably already started), try later.\n");
	return 0;
      }
      else /* a stray packet */
	continue;
    }

  }

  total_local = gs->local_player_count + gs->local_ai_count;

  printf("Wanting %d local players to join.\n", total_local);

  d=0;
  type = C_JOIN;
  PUSH(type);
  PUSH(total_local);

  packet->len = d;
  if(!SDLNet_UDP_Send(local_socket, 0, packet)) {
    fprintf(stderr, "Couldn't send probe packet to server.\n");
    exit(1);
  }

  printf("Sent join request, waiting for response...\n");

  stoptime = SDL_GetTicks()+1000;

  while(1) {
    if(SDL_GetTicks() > stoptime) {
      fprintf(stderr, "Timed out.\n");
      return 0;
    }

    count = SDLNet_UDP_Recv(local_socket, packet);

    if(count==0)
      continue;

    if(count==-1) {
      fprintf(stderr, "Socket error.\n");
      return 0;
    }

    if(packet->channel != 0) {
      printf("Got packet from unknown place.\n");
      continue;
    }
    else {
      if(packet->len==0)
	return 0;

      d=0;
      PULL(type);
      
      if(type == S_JOINED) {
	printf("Got joined.\n");
	PULL(gs->have_local_player);
	break;
      }
      else {
	if(type == S_NOT_JOINED) {
	  printf("Couldn't join.\n");
	  return 0;
	}
	else {
	  /* got a stray packet, probably thought us already in */
	  continue;
	}
      }
    }

  }

  for(i=0; i<MAX_PLAYER; i++)
    if(gs->have_local_player[i])
      printf("Have local player %d.\n", i);

  /* get map */

  stoptime = SDL_GetTicks()+5000;

  while(1) {
    if(SDL_GetTicks() > stoptime) {
      fprintf(stderr, "Timed out.\n");
      return 0;
    }

    count = SDLNet_UDP_Recv(local_socket, packet);

    if(count==0)
      continue;

    if(count==-1) {
      fprintf(stderr, "Socket error.\n");
      return 0;
    }

    if(packet->channel != 0) {
      printf("Got packet from unknown place.\n");
      continue;
    }
    else {
      if(packet->len==0)
	return 0;

      d=0;
      PULL(type);
      
      if(type == S_MAP) {
	printf("Got map.\n");
	PULL(m);
	gs->map = m;
	break;
      }
      else
	continue;
    }
  }



  return 1;
}

  

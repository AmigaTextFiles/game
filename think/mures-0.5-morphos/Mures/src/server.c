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

#include "protocol.h"
#include "sim.h"
#include "server.h"
#include "net_common.h"
#include "game.h"

static UDPsocket local_socket = NULL;

static SDLNet_SocketSet socketset = NULL;

int server_initialized=0;

UDPpacket *packet;

typedef struct _client_type {
  int exists;
  IPaddress peer;
  char has_player[MAX_PLAYER];
  int ready;
} client_type;

client_type client[MAX_CLIENT];

int server_full(game *g)
{
  int taken[MAX_PLAYER];
  int full=1,i,j;
  
  for(i=0; i<MAX_PLAYER; i++)
    taken[i] = 0;

  for(i=0; i<MAX_CLIENT; i++)
    if(client[i].exists)
      for(j=0; j<MAX_PLAYER; j++)
	if(client[i].has_player[j])
	  taken[j] = 1;

  for(i=0; i<MAX_PLAYER; i++)
    if(g->have_local_player[i])
      taken[i] = 1;
  
  for(i=0; i<MAX_PLAYER; i++)
    if(g->sim.player[i].exists && !taken[i])
      full = 0;

  return full;

}

void server_broadcast_packet()
{
  int i;

  for(i=0; i<MAX_CLIENT; i++)
    if(client[i].exists)
      if(client[i].ready) {
	
	packet->address = client[i].peer;
	
	if(!SDLNet_UDP_Send(local_socket, i, packet)) {
	  fprintf(stderr, "sending packet to %d failed.\n", i);
	}
      }
}

void server_broadcast_event(net_event e)
{
  int d=0;
  packet_type type = S_GAME_EVENT;

  PUSH(type);
  PUSH(e);

  packet->len = d;

  server_broadcast_packet();
}

void server_broadcast_okay_to(Uint32 elapsed)
{
  int d=0;
  packet_type type = S_OKAY_TO;
  
  PUSH(type);
  PUSH(elapsed);
  
  packet->len = d;
  
  server_broadcast_packet();
}

/* for when people join, before the game starts */
void server_broadcast_player_update(sim *s)
{
  int d=0;
  packet_type type = S_PLAYER_UPDATE;
  
  PUSH(type);
  PUSH(s->player);
  
  packet->len = d;
  server_broadcast_packet();
}

/* returns the channel number used, -1 for failure */
int new_client(IPaddress ip)
{
  int i,j;

  for(i=0; i<MAX_CLIENT; i++)
    if(!client[i].exists)
      break;

  if(i==MAX_CLIENT) { /* all full */
    printf("Refused a connection cause all slots were full. Increase MAX_CLIENTS\n");
    /* need to send something telling it's full */
    /*  SDLNet_TCP_Send(sock, newsock, &data, 1); */
    return -1;
  }

  client[i].peer = ip;
  client[i].exists = 1;
  client[i].ready = 0;

  for(j=0; j<MAX_PLAYER; j++)
    client[i].has_player[j] = 0;
  
  /* we don't want more than one player on a channel */
  SDLNet_UDP_Unbind(local_socket, i);
  SDLNet_UDP_Bind(local_socket, i, &client[i].peer);
  
  printf("New connection from %s, using slot %d.\n", ip_string(client[i].peer), i);

  return i;
}

void send_welcome(int i)
{
  /* send welcome message to connection i */

  packet->len = 2;
  packet->data[0] = S_WELCOME;
  packet->data[1] = PROTOCOL_VERSION;
  
  if(!SDLNet_UDP_Send(local_socket, i, packet)) {
    fprintf(stderr, "Sending welcome to %d failed.\n", i);
  }
}

void send_unwelcome(int i)
{
  /* send unwelcome message to connection i */

  packet->len = 1;
  packet->data[0] = S_NOT_WELCOME;
  
  if(!SDLNet_UDP_Send(local_socket, i, packet)) {
    fprintf(stderr, "Sending welcome to %d failed.\n", i);
  }
}

int handle_join(game *g, int channel, int players)
{
  int i, j, found;
  int taken[MAX_PLAYER];

  printf("Handling join of %d players from %d\n", players, channel);
  
  for(i=0; i<MAX_PLAYER; i++)
    taken[i] = 0;

  for(i=0; i<MAX_CLIENT; i++)
    if(client[i].exists)
      for(j=0; j<MAX_PLAYER; j++)
	if(client[i].has_player[j])
	  taken[j] = 1;

  for(i=0; i<MAX_PLAYER; i++)
    if(g->have_local_player[i])
      taken[i] = 1;
  
  for(i=0; i<MAX_PLAYER; i++)
    client[channel].has_player[i] = 0;
  
  for(i=0; i<players; i++) {
    found = 0;
    for(j=0; j<MAX_PLAYER; j++)
      if(g->sim.player[j].exists && !taken[j]) {
	client[channel].has_player[j] = 1;
	taken[j] = 1;
	found = 1;
	break;
      }
    
    if(!found) {
      printf("We don't have room for all players in this connection.\n");
      return 0;
    }
  }

  return 1;
}	

void send_full(int channel)
{
  printf("sending full msg.\n");

  packet->len = 1;
  packet->data[0] = S_NOT_JOINED;
  
  if(!SDLNet_UDP_Send(local_socket, channel, packet)) {
    fprintf(stderr, "Sending not joined to %d failed.\n", channel);
  }
}

void send_joined(int channel)
{
  int d=0;
  packet_type id = S_JOINED;

  printf("Sending joined msg.\n");
  
  PUSH(id);
  PUSH(client[channel].has_player);

  packet->len = d;
  
  if(!SDLNet_UDP_Send(local_socket, channel, packet)) {
    fprintf(stderr, "Sending joined to %d failed.\n", channel);
  }
}

void send_map(sim *s, int channel)
{
  int d=0;
  packet_type id = S_MAP;

  printf("Sending map.\n");

  if(sizeof(s->map) + sizeof(id) > MAX_PACKET_SIZE) {
    fprintf(stderr, "Max packet size too small!");
    exit(1);
  }
  
  PUSH(id);
  PUSH(s->map);

  packet->len = d;
  
  if(!SDLNet_UDP_Send(local_socket, channel, packet)) {
    fprintf(stderr, "Sending map to %d failed.\n", channel);
  }

  client[channel].ready = 1;
}

void server_step(game *g, int ms)
{
  int count;
  int d;
  input_type input;
  packet_type type;

  SDLNet_CheckSockets(socketset, 0);

  count = SDLNet_UDP_Recv(local_socket, packet);
  
  if(count==0)
    return;

  if(count==-1) {
    fprintf(stderr, "Socket error.\n");
    return;
  }

  if(packet->data[0] == C_PROBE) {
    if(packet->channel != -1)
      client[packet->channel].exists = 0;
    packet->channel = new_client(packet->address);
    printf("Client %d connected.\n", packet->channel);
    if(packet->channel == -1)
      return; /* all full or something */
  }

  /*  printf("Got msg from client %d len %d\n", packet->channel, packet->len);*/

  if(packet->len==0)
    return;

  if(packet->channel < 0)
    return;

  d=0;

  PULL(type);

  switch(type) {
  case C_PROBE:
    if(g->sim.state == NOT_STARTED) {
      printf("Handling probe from %d\n", packet->channel);
      send_welcome(packet->channel);
    }
    else
      send_unwelcome(packet->channel);
    break;

  case C_JOIN:
    if(handle_join(g, packet->channel, packet->data[1])) {
      send_joined(packet->channel);
      send_map(&g->sim, packet->channel);
      server_broadcast_player_update(&g->sim);
      if(server_full(g))
	sim_start(&g->sim);
    }
    else {
      printf("%d couldn't join.\n", packet->channel);
      send_full(packet->channel);
    }
    break;
	  
  case C_PROCESS_INPUT:
    PULL(input);
    
    if(client[packet->channel].has_player[input.player_num])
      process_input(&g->sim, input);
    break;
  case C_QUIT:
    printf("Client %d quit.\n", packet->channel);

    client[packet->channel].exists = 0;
    break;
    
  default:
    printf("Unknown command: %d.\n", *(packet->data));
    break;
  }

}

void server_cleanup(void)
{
  printf("Closing sockets...\n");

  if(local_socket != NULL)
    SDLNet_UDP_Close(local_socket);

  if( socketset != NULL ) {
    SDLNet_FreeSocketSet(socketset);
    socketset = NULL;
  }

  SDLNet_FreePacket(packet);

  /* TODO: send out closing msgs to clients */

  SDLNet_Quit();
  printf("done.\n");
}

int server_init()
{
  printf("Initializing server...\n");

  if(SDLNet_Init() < 0) {
    fprintf(stderr, "Couldn't initialize SDLNet: %s\n", SDLNet_GetError());
    return 0;
  }
  atexit(server_cleanup);

  printf("Allocating packet...\n");
  packet = SDLNet_AllocPacket(MAX_PACKET_SIZE);

  printf("Server initialized successfully.\n");

  server_initialized = 1;

  return 1;
}

int server_listen()
{
  IPaddress host_ip;

  if(!server_initialized)
    if(!server_init()) {
      fprintf(stderr, "Server init failed.\n");
      return 0;
    }

  printf("Starting server listening...\n");


  if(SDLNet_ResolveHost(&host_ip, NULL, DEFAULT_PORT) != 0) {
    fprintf(stderr, "Couldn't resolve an ip address: %s\n", SDLNet_GetError());
    exit(1);
  }

  printf("Local IP resolved to %s\n", ip_string(host_ip));
    
  socketset = SDLNet_AllocSocketSet(1);
  if ( socketset == NULL ) {
    fprintf(stderr, "Couldn't create socket set: %s\n", SDLNet_GetError());
    exit(1);
  }
    
  local_socket = SDLNet_UDP_Open(DEFAULT_PORT);
  if ( local_socket == NULL ) {
    fprintf(stderr, "Couldn't create server socket %s: %s\n", ip_string(host_ip), SDLNet_GetError());
    exit(1);
  }
  
  SDLNet_UDP_AddSocket(socketset, local_socket);

  printf("Listening on port %d.\n", SDL_SwapBE16(host_ip.port));
  
  return 1;
}

  

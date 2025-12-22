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

#ifndef GAME_H
#define GAME_H

#include "SDL.h"
#include "input_queue.h"
#include "sim.h"
#include "game_output.h"

typedef struct _game_settings
{
  bool client, server;
  bool daemon;
  bool teams;
  
  Uint8 local_player_count;
  Uint8 local_ai_count;
  
  bool have_local_player[MAX_PLAYER];

  Uint8 type;
  map map;
} game_settings;

enum
{
  BATTLE,
  PUZZLE,
  CHALLENGE,
  EDIT
};

struct _game
{
  struct
  {
    bool client;
    bool server;
    bool daemon;
  } option;

  Uint8 type;

  Uint8 local_player_count;
  Uint8 local_ai_count;

  bool have_local_player[MAX_PLAYER];

  enum {
    UNKNOWN_PLAYER,
    KEYBOARD_PLAYER,
    AI_PLAYER
  } local_player_type[MAX_PLAYER];
  
  Uint32 okay_to;
  bool finished;
  bool restart;
  
  sim sim;
  input_queue local_input;
  void *input;
  void *output;
};

void game_start(game *g, game_settings *gs);
void game_step(game *g, int ms);
int game_handle_event(game *g, SDL_Event e);
void game_exit(game *g);
void game_restart(game *g);

#endif

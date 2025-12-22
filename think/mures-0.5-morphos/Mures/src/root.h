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

#ifndef ROOT_H
#define ROOT_H

#include "pregame.h"
#include "game.h"
#include "menu.h"
#include "sim.h"

typedef struct _root_type
{
  struct
  {
    bool server;
    bool daemon;
    Uint8 local_player_count;
    Uint8 local_ai_count;
    bool client;
    bool fullscreen;
    bool teams;
    char *host;
  } arg_option;

  struct
  {
    bool daemon;
    bool fullscreen;
  } option;

  Uint8 state;
  menu menu;
  pregame pregame;
  game game;
  bool finished;

} root_type;

/* root states */
#define MENU 0
#define PREGAME 1
#define GAME 2

#endif

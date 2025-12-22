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

#ifndef GAME_OUTPUT_H
#define GAME_OUTPUT_H

#include "SDL.h"
#include "types.h"

enum {
  SDL,
  GL
};

void (*game_output_handle_event)(game *g, int event, float x, float y, direction dir);
void (*game_output_refresh)(game *g, SDL_Surface *out);
void (*game_output_bigchange)(game *g);
void (*game_output_exit)(game *g);

void game_output_init(game *g, int type);

#endif


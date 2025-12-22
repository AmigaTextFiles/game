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

#ifndef GAME_INPUT_H
#define GAME_INPUT_H

int game_input_player_exists(game *g, int p);
grid_int_position game_input_player_grid_pos(game *g, int p);
vector game_input_player_pointer(game *g, int p);

/* called when program starts */
int game_input_init();
/* called when program exits */
void game_input_exit();

/* called when game starts */
void game_input_start(game *g);
/* called when output changes */
void game_input_changed_output(game *g);
/* called when game stops */
void game_input_stop(game *g);

void game_input_step(game *g, int ms);
int game_input_handle_event(game *g, SDL_Event e);

#endif

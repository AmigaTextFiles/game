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

#ifndef MAP_H
#define MAP_H

#include "types.h"

typedef struct _map_creature
{
  creature_type type;
  direction dir;
  grid_int_position pos;
} map_creature;

typedef struct _map_generator
{
  grid_int_position pos;
  direction dir;
} map_generator;

typedef struct _map {
  Uint8 type;
  
  Uint8 max_generator;
  map_generator generator[MAX_GENERATOR];
  Uint8 max_player;

  /* max arrow per type in puzzle mode */
  Uint8 max_arrow[MAX_DIR];
  
  /* -1 for no rocket, otherwise player number of owner */
  Sint8 rocket[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  
  bool hwall[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  bool vwall[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  bool hole[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  
  /* for puzzle maps */
  Uint16 max_creature;
  map_creature creature[MAX_CREATURE];
} map;


typedef struct _map_entry map_entry;

struct _map_entry
{
  map map;
  map_entry *next;
};

int map_init();
void map_exit();

int map_save(map *m, char *location);

int load_maps();
int map_count(int map_type);

map_entry *first_map(int map_type);
int map_creature_count(map *m, creature_type type);

#endif

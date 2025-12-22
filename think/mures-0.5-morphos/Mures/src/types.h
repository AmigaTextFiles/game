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

#ifndef TYPES_H

#define TYPES_H

#include "defines.h"

typedef unsigned char creature_type;

typedef Uint8 direction;
typedef Uint8 bool;
typedef Uint8 player_id;

typedef Uint8 grid_int;
typedef float grid_float;

enum
{
  mouse,
  cat,
  mouse50,
  mouseq
};

enum
{
  UP,
  RIGHT, /* set up so that you can add one, mod MAX_DIR to turn right */
  DOWN,
  LEFT,
  MAX_DIR
};

typedef struct _grid_int_position
{
  grid_int x, y;
} grid_int_position;

typedef struct _grid_float_position
{
  grid_float x, y;
} grid_float_position;

typedef struct _screen_position
{
  Sint16 x, y;
} screen_position;

typedef struct _vector
{
  float x, y;
} vector;

typedef struct _game game;

#endif


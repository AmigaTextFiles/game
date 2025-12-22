/* 
 * Copyright (C) 2009  Sean McKean
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DRAW_H
#define DRAW_H

#include "main.h"
#include "types.h"


/* Function prototypes */
Uint32 GetPixel_24bit( SDL_Surface *, int, int );
Uint8 GetPixel_8bit( SDL_Surface *, int, int );
void SetPixel_24bit( SDL_Surface *, int, int, Uint32 );
void SetPixel_8bit( SDL_Surface *, int, int, Uint8 );
void DrawLine_8bit( SDL_Surface *, Coord_t *, Coord_t *, Uint8 );
void DrawWideLineWOffset_8bit( SDL_Surface *, Coord_t *, Coord_t *, SDL_Rect *,
                               Uint8 );
void DrawRect_8bit( SDL_Surface *, int, int, int, int, int, Uint8 );

#endif  /* DRAW_H */

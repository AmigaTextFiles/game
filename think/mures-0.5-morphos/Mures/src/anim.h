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

#ifndef ANIM_H
#define ANIM_H

#include "SDL.h"
#include "types.h"

typedef struct _frame frame;

struct _frame
{
  SDL_Surface *s;
  /* center */
  int cx, cy;
  int length;
  frame *next;
};

typedef struct _anim
{
  int length;
  frame *first_frame;
} anim;


SDL_Surface *image_load(char *datafile, int transparent);
void image_show(SDL_Surface *src, SDL_Surface *dest, screen_position p);

void frame_show(frame *f, SDL_Surface *out, screen_position p);

anim *anim_load(char *file, float factor);
anim *make_anim_from_s(SDL_Surface *s);

SDL_Surface *anim_current_surface(anim *a, int time);
SDL_Surface *anim_first_surface(anim *a);

void anim_show(anim *a, SDL_Surface *out, screen_position p, int time);

void anim_close(anim *a);

#endif




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

#ifndef GUI_H
#define GUI_H

#include "SDL.h"
#include "sim.h"

void gui_background(SDL_Surface *out);
void gui_refresh(SDL_Surface *out);
int gui_handle_event(SDL_Event e);
int gui_init();
void gui_exit();

int gui_add_text(float x, float y, char *text);
int gui_add_button(float x, float y, float w, float h, char *text, void (*callback)(void *v), void *param);
int gui_add_map(float x, float y, float w, map *m, void (*callback2)(void *v, map *m), void *param);
int gui_add_number(float x, float y, int *number, void (*callback)(void *v), void *param);
int gui_add_checkbox(float x, float y, bool *boolp, char *text, void (*callback)(void *v), void *param);
void gui_remove_object(int i);
void gui_clear();

int factor_h, factor_w;

#endif

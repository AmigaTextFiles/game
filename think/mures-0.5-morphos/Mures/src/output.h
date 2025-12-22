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

#ifndef OUTPUT_H
#define OUTPUT_H
#include "root.h"
#include "SDL_ttf.h"

/* screen resolution to use */
#define SCREEN_WIDTH 640
#define SCREEN_HEIGHT 480
#define BPP 16

void output_resize_command(root_type *r, int width, int height);

void change_screen(int new_width, int new_height, int use_opengl);

void color_rect(SDL_Surface *dest, int x, int y, int w, int h, SDL_Color c);

void center_text(SDL_Surface *out, int x, int y, char *text, SDL_Color fg, SDL_Color bg);
SDL_Surface *render_text(TTF_Font *font, char *text, SDL_Color fg, SDL_Color bg);

int output_screen_w();
int output_screen_h();

int output_init(int fs);
void output_refresh(root_type *r);
int output_exit();

void output_screenshot();
void output_toggle_fs();

#endif

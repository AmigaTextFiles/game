/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  textures.h: abstraction layer between image files and OpenGL
 *  textures.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be entertaining,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.  A copy of the
 *  General Public License is included in the file COPYING.
 */


#ifndef _TEXTURE_H_
#define _TEXTURE_H_

#include "sable.h"

typedef enum {
	LOGO_TEX,
	GROUND_TEX,
	FONT_TEX,
	MENU_TEX,
	NUM_TEXTURES
} TEXTURE_INDEX;

void load_textures(void);
void select_texture (TEXTURE_INDEX index);

/* Displays a chunk of a mosaiced 256x256 texture at the appropriate 
 * location.  sx and sy are the screen-x and screen-y coordinates for 
 * the lower-left hand corner; x1, y1, x2, y2 are the edges (inclusive).
 * For a single character, x1 == x2 and y1 == y2.  These vary from 0-7. */

/* Note that you must be in a GL_QUADS block to call this method. */
void draw_mosaic (GLfloat sx, GLfloat sy, int x1, int y1, int x2, int y2);

void draw_number (GLfloat sx, GLfloat sy, int digits, long value);

#endif

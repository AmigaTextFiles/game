/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  textures.cpp: routines for turning image files into OpenGL textures.
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

#include "sable.h"

#include <SDL.h>
#include <SDL_image.h>
#include <stdlib.h>

#include "textures.h"

static SDL_Surface *surfaces[NUM_TEXTURES];
static GLuint textures[NUM_TEXTURES];
static const char *global_texture_files[] = {
	SABLE_RESOURCEDIR "textures/logo.png",
	SABLE_RESOURCEDIR "textures/ground.png",
	SABLE_RESOURCEDIR "textures/font.png",
	SABLE_RESOURCEDIR "textures/menu.png"
};
static const char *local_texture_files[] = {
	"textures/logo.png",
	"textures/ground.png",
	"textures/font.png",
	"textures/menu.png"
};

void 
load_textures(void)
{
	/* TODO: Make this handle Big/Little endian right */
	SDL_Surface *reference = SDL_CreateRGBSurface (SDL_SWSURFACE, 256, 256, 32, 0xff, 0xff00, 0xff0000, 0xff000000);
	glPixelStorei (GL_UNPACK_ALIGNMENT, 1);
	glGenTextures (NUM_TEXTURES, textures);
	for (int i = 0; i < NUM_TEXTURES; i++) {
		/* Prepare textures */
		SDL_Surface *base = IMG_Load(global_texture_files[i]);
		if (!base) {
			base = IMG_Load(local_texture_files[i]);
			if (!base) {
				fprintf (stderr, "Could not open %s!\n",local_texture_files[i]);
				exit (1);
			}
		}
		surfaces[i] = SDL_ConvertSurface (base, reference->format, SDL_SWSURFACE);
		if (!surfaces[i]) {
			fprintf (stderr, "Could not convert %s!\n", local_texture_files[i]);
		}

		SDL_FreeSurface (base);
		glBindTexture (GL_TEXTURE_2D, textures[i]);
		glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
		glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
		glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR_MIPMAP_LINEAR);
		gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGBA, 256, 256, GL_RGBA, GL_UNSIGNED_BYTE, surfaces[i]->pixels);
	}
	SDL_FreeSurface (reference);
}

void
select_texture (TEXTURE_INDEX index)
{
	glBindTexture (GL_TEXTURE_2D, textures[index]);
}

void
draw_mosaic (GLfloat sx, GLfloat sy, int x1, int y1, int x2, int y2)
{
	GLfloat x1_tex = (0.125f) * x1;
	GLfloat y1_tex = (0.125f) * y1;
	GLfloat x2_tex = (0.125f) * (x2 + 1);
	GLfloat y2_tex = (0.125f) * (y2 + 1);
	GLfloat sx2 = sx + (32 * (x2-x1 + 1));
	GLfloat sy2 = sy + (32 * (y2-y1 + 1));

	glTexCoord2f (x1_tex, y2_tex); glVertex2f (sx, sy);
	glTexCoord2f (x2_tex, y2_tex); glVertex2f (sx2, sy);
	glTexCoord2f (x2_tex, y1_tex); glVertex2f (sx2, sy2);
	glTexCoord2f (x1_tex, y1_tex); glVertex2f (sx, sy2);
}

void
draw_number (GLfloat sx, GLfloat sy, int digits, long value)
{
	while (digits > 0) {
		digits--;
		int digit = value % 10;
		int tx = (digit % 5), ty = (digit > 4) ? 2 : 1;
		draw_mosaic (sx+16*digits, sy, tx, ty, tx, ty);
		value /= 10;
	}
}

/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  initCursor function by Anonymous from man SDL_CreateCursor
 *
 *  file: pointer.c
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software Foundation,
 *  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 */

#include <stdlib.h>

#include "SDL_image.h"
#include "SDL.h"

#include "pointer.h"

static SDL_Cursor * handCursor  = 0;
static SDL_Cursor * arrowCursor = 0;

static const char * hand[] = {
	"32 32 3 1",
	"x c #000000",
	". c #ffffff",
	"  c None",
	"     xx                         ",
	"    x..x                        ",
	"    x..x                        ",
	"    x..x                        ",
	"    x..xxx x                    ",
	"    x..x..x.xx                  ",
	" xx x..x..x.x.x                 ",
	"x..xx.........x                 ",
	"x...x.........x                 ",
	" x.....x.x.x..x                 ",
	"  x....x.x.x..x                 ",
	"  x....x.x.x.x                  ",
	"   x.........x                  ",
	"    x.......x                   ",
	"     x....x.x                   ",
	"      xxxx x                    ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"0,0"
};

static const char * arrow[] = {
	"32 32 3 1",
	"x c #000000",
	". c #ffffff",
	"  c None",
	".                               ",
	"..                              ",
	".x.                             ",
	".xx.                            ",
	".xxx.                           ",
	".xxxx.                          ",
	".xxxxx.                         ",
	".xxxxxx.                        ",
	".xxxxxxx.                       ",
	".xxxxxxxx.                      ",
	".xxxxx.....                     ",
	".xx.xx.                         ",
	".x. .xx.                        ",
	"..  .xx.                        ",
	".    .xx.                       ",
	"     .xx.                       ",
	"      .x..                      ",
	"      ...                       ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"                                ",
	"0,0"
};

/*****************************************************
 ****************************************************/
SDL_Cursor * initCursor(const char * image[])
{
#ifdef __MORPHOS__
#define MOUSESIZE 16
#else
#define MOUSESIZE 32
#endif

	int i, row, col, hot_x, hot_y;
	Uint8 data[4 * MOUSESIZE];
	Uint8 mask[4 * MOUSESIZE];

	i = -1;
	for (row = 0;row < 32; ++row) {
		for (col = 0; col < MOUSESIZE; ++col) {
			if (col % 8) {
				data[i] <<= 1;
				mask[i] <<= 1;
			} else {
				++i;
				data[i] = mask[i] = 0;
			}
			switch (image[4 + row][col]) {
			case 'x':
				data[i] |= 0x01;
				mask[i] |= 0x01;
				break;
			case '.':
				mask[i] |= 0x01;
				break;
			case ' ':
				break;
			}
		}
	}
	sscanf(image[4 + row], "%d,%d", &hot_x, &hot_y);
	return SDL_CreateCursor(data, mask, MOUSESIZE, MOUSESIZE, hot_x, hot_y);
}


/*****************************************************
 ****************************************************/
SDL_Cursor * getHandCursor()
{
	if(!handCursor)
		handCursor = initCursor(hand);
	return handCursor;
}

/*****************************************************
 ****************************************************/
SDL_Cursor * getArrowCursor()
{
	if(!arrowCursor)
		arrowCursor = initCursor(arrow);
	return arrowCursor;
}


/*****************************************************
 from http://sdldoc.csn.ul.ie/guidevideo.php
****************************************************/
static Uint32 getpixel(SDL_Surface *surface, int x, int y)
{
	int bpp = surface->format->BytesPerPixel;
	/* Here p is the address to the pixel we want to retrieve */
	Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

	switch(bpp) {
	case 1:
		return *p;

	case 2:
		return *(Uint16 *)p;

	case 3:
		if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
			return p[0] << 16 | p[1] << 8 | p[2];
		else
			return p[0] | p[1] << 8 | p[2] << 16;

	case 4:
		return *(Uint32 *)p;

	default:
		return 0;       /* shouldn't happen, but avoids warnings */
	}
}

/*****************************************************
 ****************************************************/
static void putpixel(SDL_Surface * surface, int x, int y, Uint32 pixel)
{
	int bpp = surface->format->BytesPerPixel;
	/* Here p is the address to the pixel we want to set */
	Uint8 * p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

	switch(bpp) {
	case 1:
		*p = pixel;
		break;

	case 2:
		*(Uint16 *)p = pixel;
		break;

	case 3:
		if(SDL_BYTEORDER == SDL_BIG_ENDIAN) {
			p[0] = (pixel >> 16) & 0xff;
			p[1] = (pixel >> 8) & 0xff;
			p[2] = pixel & 0xff;
		} else {
			p[0] = pixel & 0xff;
			p[1] = (pixel >> 8) & 0xff;
			p[2] = (pixel >> 16) & 0xff;
		}
		break;

	case 4:
		*(Uint32 *)p = pixel;
		break;
	}
}

/*****************************************************
 ****************************************************/
SDL_Cursor * surfaceToCursor(SDL_Surface *image, int hx, int hy) 
{
	int             w, x, y;
	Uint8           *data, *mask, *d, *m, r, g, b;
	Uint32          color;
	 
	w = (image->w + 7) / 8;
	data = (Uint8 *)calloc(w * image->h * 2, 1);
	if (data == NULL)
		return NULL;

	mask = data + w * image->h;
	if (SDL_MUSTLOCK(image))
		SDL_LockSurface(image);
	for (y = 0; y < image->h; y++) {
		d = data + y * w;
		m = mask + y * w;
		for (x = 0; x < image->w; x++) {
			color = getpixel(image, x, y);
			if ((image->flags & SDL_SRCCOLORKEY) == 0 || color != image->format->colorkey) {
				SDL_GetRGB(color, image->format, &r, &g, &b);
				color = (r + g + b) / 3;
				m[x / 8] |= 128 >> (x & 7);
				if (color < 128)
					d[x / 8] |= 128 >> (x & 7);
			}
		}
	}
	if (SDL_MUSTLOCK(image))
		SDL_UnlockSurface(image);

	return SDL_CreateCursor(data, mask, w, image->h, hx, hy);
}

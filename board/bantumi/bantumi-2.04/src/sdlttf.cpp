/*
    Bantumi
    Copyright 2005 - 2007 Martin Storsjö

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Martin Storsjö
    martin@martin.st
*/

#include "glfont.h"
#include <SDL.h>
#include <SDL_ttf.h>

GLFont *makeGLFont(const char *name, int size, int w, int h, unsigned char first, unsigned char last, unsigned char skipstart, unsigned char skiplast) {
	int offset = first;
	int n = last - offset + 1;
	TexGLFont *f = new TexGLFont(offset, n);

#if SDL_BYTEORDER == SDL_LIL_ENDIAN
	SDL_Surface *surf = SDL_CreateRGBSurface(SDL_SWSURFACE, w, h, 32, 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000);
#else   
	SDL_Surface *surf = SDL_CreateRGBSurface(SDL_SWSURFACE, w, h, 32, 0xFF000000, 0x00FF0000, 0x0000FF00, 0x000000FF);
#endif
	SDL_FillRect(surf, NULL, 0);
	TTF_Init();
	TTF_Font *font = TTF_OpenFont(name, size);
	if (font == NULL) {
		fprintf(stderr, "%s\n", TTF_GetError());
		return NULL;
	}

	int margin = 1;

	int cury = 0;
	int curx = 0;
	int nexty = cury;
	for (int c = offset; c < offset+n; c++) {
		if (c >= skipstart && c <= skiplast)
			continue;
		int minx, maxx, miny, maxy, adv;
		TTF_GlyphMetrics(font, c, &minx, &maxx, &miny, &maxy, &adv);
		SDL_Color color = { 255, 255, 255, 0 };
		SDL_Surface *csurf = TTF_RenderGlyph_Blended(font, c, color);
		if ((curx + csurf->w + margin > surf->w && nexty + csurf->h + margin > surf->h) || cury + csurf->h + margin > surf->h)
			break;
		if (curx + csurf->w + margin > surf->w) {
			curx = 0;
			cury = nexty;
		}
		SDL_SetAlpha(csurf, 0, 255);
		SDL_Rect dst = { curx, cury, 0, 0 };
		SDL_BlitSurface(csurf, NULL, surf, &dst);
		f->setParams(c, curx, cury, csurf->w, csurf->h, adv, minx, miny);

		if (cury + csurf->h + margin > nexty)
			nexty = cury + csurf->h + margin;
		curx += csurf->w + margin;

		SDL_FreeSurface(csurf);
	}

	f->setImage(surf->pixels, w, h);

//	SDL_SaveBMP(surf, "test.bmp");

	TTF_CloseFont(font);
	TTF_Quit();
	SDL_FreeSurface(surf);

	return f;
}


/*
    Copyright (c) 2004-2005 Markus Kettunen

    This file is part of Blobtrix.

    Blobtrix is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Blobtrix is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Blobtrix; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


#include "graphics.h"
#include "SDL.h"

graphics::graphics(){
}

graphics::~graphics(){}

SDL_Surface * graphics::LoadPicture(char *file)
{
	SDL_Surface *picture;
	picture=IMG_Load(file);
	if (picture <= 0) {
		fprintf(stderr, "Couldn't load file \"%s\" .. \n", file);
		exit (1);
	}
	picture = SDL_DisplayFormat(picture);
	if (picture==NULL) {
		fprintf(stderr, "Out of memory!\n");
		exit(1);
	}

	fprintf (stderr, "Loaded file \"%s\" .. \n", file);

	return picture;
}

void graphics::DrawIMG(SDL_Surface *destsurface, SDL_Surface *img, int x, int y)
{
	SDL_Rect dest;
	dest.x = x;
	dest.y = y;
	SDL_BlitSurface(img, NULL, destsurface, &dest);
}

void graphics::DrawPartOfIMG(SDL_Surface *destsurface, SDL_Surface *img, int x, int y, int w, int h, int x2, int y2)
{
	SDL_Rect dest;
	SDL_Rect dest2;
	dest.x = x;
	dest.y = y;
	dest2.x = x2;
	dest2.y = y2;
	dest2.w = w;
	dest2.h = h;
	SDL_BlitSurface(img, &dest2, destsurface, &dest);
}

void graphics::SetTransparentColor(SDL_Surface *image, Uint8 r, Uint8 g, Uint8 b) {
	SDL_SetColorKey(image, SDL_SRCCOLORKEY|SDL_RLEACCEL, MapRGB(image, r, g, b));
}

void graphics::RemoveTransparentColor(SDL_Surface *image, Uint8 r, Uint8 g, Uint8 b) {
	SDL_SetColorKey(image, 0, 0);
}

Uint32 graphics::MapRGB(SDL_Surface *image, Uint8 r, Uint8 g, Uint8 b) {
	return SDL_MapRGB(image->format, r, g, b);
}

void graphics::GetRGB(Uint32 pixel, SDL_PixelFormat *fmt, Uint8 *r, Uint8 *g, Uint8 *b) {
	return SDL_GetRGB(pixel, fmt, r, g, b);
}

void graphics::FadeOut(SDL_Surface * screen)
{
}


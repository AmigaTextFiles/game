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


#ifndef _GRAPHICS_H_
#define _GRAPHICS_H_

#include <stdlib.h>

#include "SDL.h"
#include "SDL_image.h"

#include "config.h"

class graphics
{
	public:
		graphics();
		~graphics();

		SDL_Surface * LoadPicture(char *file);
		SDL_Surface * LoadPicture_NoExit(char *file);
		void DrawIMG(SDL_Surface *destsurface, SDL_Surface *img, int x, int y);
		void DrawPartOfIMG(SDL_Surface *destsurface, SDL_Surface *img, int x, int y, int w, int h, int x2, int y2);
		void SetTransparentColor(SDL_Surface *image, Uint8 r, Uint8 g, Uint8 b);
		
		void RemoveTransparentColor(SDL_Surface *image, Uint8 r, Uint8 g, Uint8 b);
      void FadeOut(SDL_Surface * screen);
		Uint32 MapRGB(SDL_Surface *image, Uint8 r, Uint8 g, Uint8 b);
		void GetRGB(Uint32 pixel, SDL_PixelFormat *fmt, Uint8 *r, Uint8 *g, Uint8 *b);

	private:
};

#endif

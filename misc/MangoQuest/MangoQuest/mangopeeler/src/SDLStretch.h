/***************************************************************************
                          SDLStretch.h  -  description
                             -------------------
    begin                : Fri Jan 14 2000
    copyright            : (C) 2000 by Alexander Pipelka
    email                : pipelka@teleweb.at
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef SDL_STRETCHSURFACE
#define SDL_STRETCHSURFACE

#include <SDL/SDL.h>

bool SDL_StretchSurface(SDL_Surface * dst_surface, long xd1, long yd1,
                        long xd2, long yd2, SDL_Surface * src_surface,
                        long xs1, long ys1, long xs2, long ys2);

#endif

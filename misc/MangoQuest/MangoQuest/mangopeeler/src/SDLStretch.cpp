/***************************************************************************
                          SDLStretch.cpp  -  description
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

#include "SDLStretch.h"
#include <math.h>
#include <stdlib.h>

#define sign(x) ((x)>0 ? 1:-1)

// declarations

void Stretch8(SDL_Surface * src_surface, SDL_Surface * dst_surface, long x1,
              long x2, long y1, long y2, long yr, long yw);
void Stretch16(SDL_Surface * src_surface, SDL_Surface * dst_surface, long x1,
               long x2, long y1, long y2, long yr, long yw);
void Stretch24(SDL_Surface * src_surface, SDL_Surface * dst_surface, long x1,
               long x2, long y1, long y2, long yr, long yw);
void Stretch32(SDL_Surface * src_surface, SDL_Surface * dst_surface, long x1,
               long x2, long y1, long y2, long yr, long yw);

// SDL_StretchSurface

bool SDL_StretchSurface(SDL_Surface * dst_surface, long xd1, long yd1,
                        long xd2, long yd2, SDL_Surface * src_surface,
                        long xs1, long ys1, long xs2, long ys2)
{
  register long dx, dy, e, d, dx2;
  register short sx, sy;

  dx = abs((int) (yd2 - yd1));
  dy = abs((int) (ys2 - ys1));
  sx = sign(yd2 - yd1);
  sy = sign(ys2 - ys1);
  e = (dy << 1) - dx;
  dx2 = dx << 1;
  dy <<= 1;

  if (dst_surface->format->BytesPerPixel !=
      src_surface->format->BytesPerPixel)
    return false;

  if (dst_surface->format->BytesPerPixel == 1)
    SDL_SetColors(dst_surface, src_surface->format->palette->colors, 0, 256);

  if (SDL_MUSTLOCK(dst_surface))
  {
    if (SDL_LockSurface(dst_surface) < 0)
      return false;
  }

  for (d = 0; d < dx; d++)
  {
    switch (src_surface->format->BytesPerPixel)
    {
    case 1:
      Stretch8(src_surface, dst_surface, xd1, xd2, xs1, xs2, ys1, yd1);
      break;

    case 2:
      Stretch16(src_surface, dst_surface, xd1, xd2, xs1, xs2, ys1, yd1);
      break;

    case 3:
      Stretch24(src_surface, dst_surface, xd1, xd2, xs1, xs2, ys1, yd1);
      break;

    case 4:
      Stretch32(src_surface, dst_surface, xd1, xd2, xs1, xs2, ys1, yd1);
      break;
    }

    while (e >= 0)
    {
      ys1++;
      e -= dx2;
    }
    yd1++;
    e += dy;
  }

  if (SDL_MUSTLOCK(dst_surface))
  {
    SDL_UnlockSurface(dst_surface);
  }

  return true;
}

inline void Stretch8(SDL_Surface * src_surface, SDL_Surface * dst_surface,
                     long x1, long x2, long y1, long y2, long yr, long yw)
{
  register long dx, dy, e, d, dx2;

  if (yw >= dst_surface->h)
    return;

  dx = (x2 - x1);
  dy = (y2 - y1);

  dy <<= 1;
  e = dy - dx;
  dx2 = dx << 1;

  register Uint16 src_pitch = src_surface->pitch;
  register Uint16 dst_pitch = dst_surface->pitch;

  register Uint8 *src_pixels =
    (Uint8 *) ((long) src_surface->pixels + yr * src_pitch + y1);
  register Uint8 *dst_pixels =
    (Uint8 *) ((long) dst_surface->pixels + yw * dst_pitch + x1);

  for (d = 0; d <= dx; d++)
  {
    *dst_pixels = *src_pixels;

    while (e >= 0)
    {
      src_pixels++;
      e -= dx2;
    }

    dst_pixels++;
    e += dy;
  }
}

inline void Stretch16(SDL_Surface * src_surface, SDL_Surface * dst_surface,
                      long x1, long x2, long y1, long y2, long yr, long yw)
{
  register long dx, dy, e, d, dx2;

  if (yw >= dst_surface->h)
    return;

  dx = (x2 - x1);
  dy = (y2 - y1);

  dy <<= 1;
  e = dy - dx;
  dx2 = dx << 1;

  register Uint16 src_pitch = src_surface->pitch;
  register Uint16 dst_pitch = dst_surface->pitch;

  register Uint16 *src_pixels =
    (Uint16 *) ((long) src_surface->pixels + yr * src_pitch + y1 * 2);
  register Uint16 *dst_pixels =
    (Uint16 *) ((long) dst_surface->pixels + yw * dst_pitch + x1 * 2);

  for (d = 0; d <= dx; d++)
  {
    *dst_pixels = *src_pixels;

    while (e >= 0)
    {
      src_pixels++;
      e -= dx2;
    }

    dst_pixels++;
    e += dy;
  }
}

inline void Stretch24(SDL_Surface * src_surface, SDL_Surface * dst_surface,
                      long x1, long x2, long y1, long y2, long yr, long yw)
{
  register long dx, dy, e, d, dx2;
  int i;

  if (yw >= dst_surface->h)
    return;

  dx = (x2 - x1);
  dy = (y2 - y1);

  dy <<= 1;
  e = dy - dx;
  dx2 = dx << 1;

  register Uint16 src_pitch = src_surface->pitch;
  register Uint16 dst_pitch = dst_surface->pitch;

  register Uint8 *src_pixels =
    (Uint8 *) ((long) src_surface->pixels + yr * src_pitch + y1 * 3);
  register Uint8 *dst_pixels =
    (Uint8 *) ((long) dst_surface->pixels + yw * dst_pitch + x1 * 3);

  for (d = 0; d <= dx; d++)
  {
    for (i = 0; i < 3; i++)
      *(dst_pixels + i) = *(src_pixels + i);

    while (e >= 0)
    {
      src_pixels += 3;
      e -= dx2;
    }

    dst_pixels += 3;
    e += dy;
  }
}

inline void Stretch32(SDL_Surface * src_surface, SDL_Surface * dst_surface,
                      long x1, long x2, long y1, long y2, long yr, long yw)
{
  register long dx, dy, e, d, dx2;

  if (yw >= dst_surface->h)
    return;

  dx = (x2 - x1);
  dy = (y2 - y1);

  dy <<= 1;
  e = dy - dx;
  dx2 = dx << 1;

  register Uint16 src_pitch = src_surface->pitch;
  register Uint16 dst_pitch = dst_surface->pitch;

  register Uint32 *src_pixels =
    (Uint32 *) ((long) src_surface->pixels + yr * src_pitch + y1 * 4);
  register Uint32 *dst_pixels =
    (Uint32 *) ((long) dst_surface->pixels + yw * dst_pitch + x1 * 4);

  for (d = 0; d <= dx; d++)
  {
    *dst_pixels++ = *src_pixels++;

    while (e >= 0)
    {
      src_pixels++;
      e -= dx2;
    }

    dst_pixels++;
    e += dy;
  }
}

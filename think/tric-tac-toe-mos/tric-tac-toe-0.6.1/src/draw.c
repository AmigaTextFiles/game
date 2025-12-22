/* 
 * Copyright (C) 2009  Sean McKean
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "draw.h"


Uint32
GetPixel_24bit(SDL_Surface *sfc, int x, int y)
{
    Uint8 *p = (Uint8 *)sfc->pixels;

    if (x < 0 || x >= sfc->w || y < 0 || y >= sfc->h)
        return 0;  /* Pixel is out of surface bounds. */

    return *((Uint32 *)(p + x * 3 + y * sfc->pitch)) & 0xffffff;
}


Uint8
GetPixel_8bit(SDL_Surface *sfc, int x, int y)
{
    if (x < 0 || x >= sfc->w || y < 0 || y >= sfc->h)
        return 0;  /* Pixel is out of surface bounds. */

    return ((Uint8 *)sfc->pixels)[x + y * sfc->pitch];
}


void
SetPixel_24bit(SDL_Surface *sfc, int x, int y, Uint32 color)
{
    int index = 0;
    SDL_PixelFormat *fmt = sfc->format;
    Uint8 r, g, b;

    if (x < 0 || x >= sfc->w || y < 0 || y >= sfc->h)
        return;  /* Pixel is out of surface bounds. */

    index = x * 3 + y * sfc->pitch;
    r = (color & fmt->Rmask) >> fmt->Rshift << fmt->Rloss;
    g = (color & fmt->Gmask) >> fmt->Gshift << fmt->Gloss;
    b = (color & fmt->Bmask) >> fmt->Bshift << fmt->Bloss;
    if (SDL_MUSTLOCK(sfc))
        SDL_LockSurface(sfc);
    ((Uint8 *)sfc->pixels)[index + 2] = r;
    ((Uint8 *)sfc->pixels)[index + 1] = g;
    ((Uint8 *)sfc->pixels)[index] = b;
    if (SDL_MUSTLOCK(sfc))
        SDL_UnlockSurface(sfc);
}


void
SetPixel_8bit(SDL_Surface *sfc, int x, int y, Uint8 color)
{
    if (x < 0 || x >= sfc->w || y < 0 || y >= sfc->h)
        return;  /* Pixel is out of surface bounds. */

    if (SDL_MUSTLOCK(sfc))
        SDL_LockSurface(sfc);
    ((Uint8 *)sfc->pixels)[x + y * sfc->pitch / sfc->format->BytesPerPixel] =
        color;
    if (SDL_MUSTLOCK(sfc))
        SDL_UnlockSurface(sfc);
}


void
DrawLine_8bit( SDL_Surface *sfc, Coord_t *coord_a, Coord_t *coord_b,
               Uint8 color )
{
    int dx = coord_b->x - coord_a->x,
        dy = coord_b->y - coord_a->y,
        q = 0,
        w = 0;

    if (abs(dx) > abs(dy))
    {
        for (q = 0; abs(q) < abs(dx); q += SIGN(dx))
        {
            w = (int)((double)q * (dy + SIGN(dy)) / dx);
            SetPixel_8bit(sfc, coord_a->x + q, coord_a->y + w, color);
        }
    }
    else
    {
        for (q = 0; abs(q) < abs(dy); q += SIGN(dy))
        {
            w = (int)((double)q * (dx + SIGN(dx)) / dy);
            SetPixel_8bit(sfc, coord_a->x + w, coord_a->y + q, color);
        }
    }
    SetPixel_8bit(sfc, coord_b->x, coord_b->y, color);
}


void
DrawWideLineWOffset_8bit( SDL_Surface *sfc, Coord_t *coord_a, Coord_t *coord_b,
                          SDL_Rect *offset, Uint8 color )
{
    int dx = coord_b->x - coord_a->x,
        dy = coord_b->y - coord_a->y,
        q = 0,
        w = 0;
    SDL_Rect r = { 0, 0, 3, 3 };

    if (abs(dx) > abs(dy))
    {
        for (q = 0; abs(q) < abs(dx); q += SIGN(dx))
        {
            w = (int)((double)q * (dy + SIGN(dy)) / dx);
            r.x = coord_a->x + q + offset->x - 1;
            r.y = coord_a->y + w + offset->y - 1;
            SDL_FillRect(sfc, &r, color);
        }
    }
    else
    {
        for (q = 0; abs(q) < abs(dy); q += SIGN(dy))
        {
            w = (int)((double)q * (dx + SIGN(dx)) / dy);
            r.x = coord_a->x + w + offset->x - 1;
            r.y = coord_a->y + q + offset->y - 1;
            SDL_FillRect(sfc, &r, color);
        }
    }
    r.x = coord_b->x + offset->x - 1;
    r.y = coord_b->y + offset->y - 1;
    SDL_FillRect(sfc, &r, color);
}


void
DrawRect_8bit( SDL_Surface *sfc, int x, int y, int w, int h,
               int thickness, Uint8 color )
{
    SDL_Rect rect;

    if (thickness == 0)
    {
        rect.x = x;
        rect.y = y;
        rect.w = w;
        rect.h = h;
        SDL_FillRect(sfc, &rect, color);
        return;
    }

    rect.x = x;
    rect.y = y;
    rect.w = w;
    rect.h = thickness;
    SDL_FillRect(sfc, &rect, color);
    rect.w = thickness;
    rect.h = h;
    SDL_FillRect(sfc, &rect, color);
    rect.x = x + w - thickness;
    SDL_FillRect(sfc, &rect, color);
    rect.x = x;
    rect.y = y + h - thickness;
    rect.w = w;
    rect.h = thickness;
    SDL_FillRect(sfc, &rect, color);
    return;
}

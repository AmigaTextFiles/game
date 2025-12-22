
/**
 *
 * Tennix! SDL Port
 * Copyright (C) 2003, 2007, 2008 Thomas Perl <thp@perli.net>
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
 * MA  02110-1301, USA.
 *
 **/

#ifndef __TENNIX_H
#define __TENNIX_H

#include <sys/param.h>

#include "SDL.h"


#define COPYRIGHT "Copyright 2003, 2007, 2008 Thomas Perl"
#define URL "http://icculus.org/tennix/"

#define WIDTH 640
#define HEIGHT 480

#define M_POS_XPOS(x) (x>WIDTH/2-150&&x<WIDTH/2+150)

#define M_POS_START_GAME(x,y)  (M_POS_XPOS(x) && y>120 && y<160)
#define M_POS_START_MULTI(x,y) (M_POS_XPOS(x) && y>170 && y<200)
#define M_POS_CREDITS(x,y)     (M_POS_XPOS(x) && y>210 && y<250)
#define M_POS_QUIT(x,y)        (M_POS_XPOS(x) && y>280 && y<320)

#define HIGHLIGHT_X 420

#define HIGHLIGHT_START_GAME 145
#define HIGHLIGHT_START_MULTI 190
#define HIGHLIGHT_CREDITS 235
#define HIGHLIGHT_QUIT 305

extern SDL_Surface *screen;

typedef struct {
    const char* data;
    unsigned int size;
} ResourceData;

#define RESOURCE(x) ((ResourceData){ x, sizeof( x) })

typedef struct {
    int x;
    int y;
    float current_x;
    float current_y;
    int new_x;
    int new_y;
    int w;
    int h;
    float phase;
    int r;
    int g;
    int b;
    int size;
    int new_size;
} Point;

#define ELEKTRONS_WIDTH 65
#define ELEKTRON_LAZYNESS 30.0
#define ELEKTRONS 50

#endif

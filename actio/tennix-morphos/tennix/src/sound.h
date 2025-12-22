
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

#ifndef __SOUND_H
#define __SOUND_H

#include "SDL_mixer.h"

#define FADE_OUT_MS 500
#define FADE_IN_MS 3000

typedef unsigned char sound_id;
enum {
    SOUND_RACKET1 = 0,
    SOUND_RACKET2,
    SOUND_GROUND1,
    SOUND_GROUND2,
    SOUND_AUDIENCE,
    SOUND_APPLAUSE,
    SOUND_OUT,
    SOUND_BACKGROUND,
    SOUND_MAX,
};

#define SOUND_RACKET_FIRST SOUND_RACKET1
#define SOUND_RACKET_LAST SOUND_RACKET2
#define SOUND_GROUND_FIRST SOUND_GROUND1
#define SOUND_GROUND_LAST SOUND_GROUND2

#define SOUND_GROUND (SOUND_GROUND_FIRST + rand()%(SOUND_GROUND_LAST-SOUND_GROUND_FIRST))
#define SOUND_RACKET (SOUND_RACKET_FIRST + rand()%(SOUND_RACKET_LAST-SOUND_RACKET_FIRST))

typedef struct {
    Mix_Chunk* data;
} Sound;

void init_sound();

void play_sample_n(sound_id id, int n);
#define play_sample(id) play_sample_n(id,0)
#define play_sample_loop(id) play_sample_n(id,-1)
#define play_sample_background(id) play_sample_n(id,-2)
void stop_sample(sound_id id);
void pan_sample(sound_id id, float position);
#define unpan_sample(id) pan_sample(id,0.5)

#endif

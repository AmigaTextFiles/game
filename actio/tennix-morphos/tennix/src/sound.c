
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

#include "tennix.h"
#include "sound.h"

static Sound* sounds;

#include "data/sounds_data.c"
static const ResourceData samples[] = {
    RESOURCE(racket1),
    RESOURCE(racket2),
    RESOURCE(ground1),
    RESOURCE(ground2),
    RESOURCE(audience),
    RESOURCE(applause),
    RESOURCE(out),
    RESOURCE(background)
};

void init_sound() {
    int i;
    Mix_Chunk* data;

    if( Mix_OpenAudio( 22050, AUDIO_S16SYS, 2, 1024) < 0) {
        fprintf( stderr, "Error initializing SDL_mixer: %s\n", Mix_GetError());
    }

    sounds = (Sound*)calloc(SOUND_MAX, sizeof(Sound));

    for( i=0; i<SOUND_MAX; i++) {
        data = Mix_LoadWAV_RW(SDL_RWFromMem(samples[i].data, samples[i].size), 1);
        if( !data) {
            fprintf( stderr, "Error: %s\n", SDL_GetError());
            continue;
        }

        sounds[i].data = data;
    }

}

void play_sample_n(sound_id id, int n)
{
    if (id >= SOUND_MAX) {
        fprintf(stderr, "Cannot play sound #%d.\n", id);
        return;
    }

    if (n == -2) {
        Mix_FadeInChannel(id, sounds[id].data, -1, FADE_IN_MS);
    } else {
        Mix_PlayChannel(id, sounds[id].data, n);
    }

    if (id == SOUND_RACKET) {
        stop_sample(SOUND_APPLAUSE);
    }
}

void stop_sample(sound_id id)
{
    Mix_FadeOutChannel(id, FADE_OUT_MS);
}

void pan_sample(sound_id id, float position)
{
    if (position == 0.5) {
        Mix_SetPanning(id, 255, 255);
    }
    else {
        Mix_SetPanning(id, 255*(1.0-position), 255*(position));
    }
}


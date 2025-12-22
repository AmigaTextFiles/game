/*
 *  SABLE
 *  Copyright (C) 2003-5 Michael C. Martin.
 *
 *  sound.cpp: The sound implementation
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be entertaining,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.  A copy of the
 *  General Public License is included in the file COPYING.
 */

#include "sable.h"
#include "sound.h"

#include <stdlib.h>
#include <SDL_mixer.h>

static Mix_Music *music[NUM_MUSIC];
static Mix_Chunk *sfx[NUM_SOUND];
static int sound_on;

#define safe_loadMUS(lval, fname) lval = Mix_LoadMUS(SABLE_RESOURCEDIR fname); if (!lval) lval = Mix_LoadMUS(fname);
#define safe_loadWAV(lval, fname) lval = Mix_LoadWAV(SABLE_RESOURCEDIR fname); if (!lval) lval = Mix_LoadWAV(fname);

void free_sound (void)
{
	int i;
	for (i = 0; i < NUM_MUSIC; i++)
	{
		if (music[i])
		{
			Mix_FreeMusic(music[i]);
		}
	}
	for (i = 0; i < NUM_SOUND; i++)
	{
		if (sfx[i])
		{
			Mix_FreeChunk(sfx[i]);
		}
	}
}

void load_sound (void)
{
	if(Mix_OpenAudio(22050, AUDIO_S16SYS, 1, 2048) < 0)
	{
		int i;
		printf("Warning: Couldn't set 22050 Hz 16-bit audio\n- Reason: %s\n",
		       SDL_GetError());
		for (i = 0; i < NUM_MUSIC; i++)
		{
			music[i] = NULL;
		}
		sound_on = 0;
	}
	else
	{
		sound_on = 1;
		safe_loadMUS(music[MENU_MUSIC], "music/menu.mod");
		safe_loadMUS(music[GAME_MUSIC], "music/game.mod");
		safe_loadMUS(music[GAME_OVER_MUSIC], "music/gameover.mod");
		safe_loadWAV(sfx[PLAYER_SHOT_SOUND], "sfx/pl_fire.wav");
		safe_loadWAV(sfx[SMALL_EXPLOSION_SOUND], "sfx/expl_s.wav");
		safe_loadWAV(sfx[MEDIUM_EXPLOSION_SOUND], "sfx/expl_m.wav");
		safe_loadWAV(sfx[LARGE_EXPLOSION_SOUND], "sfx/expl_l.wav");
		Mix_AllocateChannels (NUM_SOUND);
		Mix_Volume (PLAYER_SHOT_SOUND, 64);
		Mix_Volume (SMALL_EXPLOSION_SOUND, 32);
		Mix_Volume (MEDIUM_EXPLOSION_SOUND, 64);
		Mix_Volume (LARGE_EXPLOSION_SOUND, 128);
	}
}

void play_music (MUSIC_TYPE m)
{
	if (!sound_on) return;
	if (Mix_PlayingMusic())
	{
		Mix_HaltMusic();
	}
	if (music[m])
	{
		Mix_PlayMusic (music[m], -1);
		Mix_VolumeMusic (128);
	}
}

void play_music_once (MUSIC_TYPE m)
{
	if (!sound_on) return;
	if (Mix_PlayingMusic())
	{
		Mix_HaltMusic();
	}
	if (music[m])
	{
		Mix_PlayMusic (music[m], 1);
		Mix_VolumeMusic (128);
	}
}

void stop_music (void)
{
	if (!sound_on) return;
	Mix_HaltMusic();
}

void fade_music (void)
{
	if (!sound_on) return;
	Mix_FadeOutMusic (2000);
}

void play_sfx (SFX_TYPE s)
{
	if (!sound_on) return;
	if (sfx[s])
		Mix_PlayChannel (s, sfx[s], 0);
}

void stop_sfx (void)
{
	if (!sound_on) return;
	Mix_HaltChannel (-1);
}

/*
  Diamond Girl - Game where player collects diamonds.
  Copyright (C) 2005  Joni Yrjana
  
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
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


  Complete license can be found in the LICENSE file.
*/

#include <SDL/SDL_mixer.h>
#include "diamond_girl.h"


static Mix_Chunk * sounds[SFX_SIZEOF_];
static Mix_Music * musics[MUSIC_SIZEOF_];
static int init_mix;

static void load_sfx(enum SFX sfx_id);
static void load_music(enum MUSIC music_id);

void sfx_initialize(void)
{
  init_mix = 0;

  for(int i = 0; i < SFX_SIZEOF_; i++)
    sounds[i] = NULL;
  for(int i = 0; i < MUSIC_SIZEOF_; i++)
    musics[i] = NULL;

  if(SDL_InitSubSystem(SDL_INIT_AUDIO) == 0)
    {
      if(Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 1, 512) == 0)
	{
	  init_mix = 1;
	  for(int i = 0; i < SFX_SIZEOF_; i++)
	    load_sfx((enum SFX)i);
	  for(int i = 0; i < MUSIC_SIZEOF_; i++)
	    load_music((enum MUSIC)i);
	  Mix_AllocateChannels(SFX_SIZEOF_);
	  Mix_Volume(-1, MIX_MAX_VOLUME);
	  Mix_VolumeMusic(SDL_MIX_MAXVOLUME / 2);
	}
      else
	fprintf(stderr, "Failed to initialize audio: %s\n", Mix_GetError());
    }
  else
    fprintf(stderr, "Failed to initialize audio: %s\n", SDL_GetError());
}

void sfx_cleanup(void)
{
  if(init_mix)
    {
      for(int i = 0; i < SFX_SIZEOF_; i++)
	if(sounds[i] != NULL)
	  {
	    Mix_FreeChunk(sounds[i]);
	    sounds[i] = NULL;
	  }
      for(int i = 0; i < MUSIC_SIZEOF_; i++)
	if(musics[i] != NULL)
	  {
	    Mix_FreeMusic(musics[i]);
	    musics[i] = NULL;
	  }
      Mix_CloseAudio();
    }
  SDL_QuitSubSystem(SDL_INIT_AUDIO);
}

static void load_sfx(enum SFX sfx_id)
{
  const char * fn_boulder_fall    = "sfx/boulder_fall.wav";
  const char * fn_boulder_move    = "sfx/boulder_move.wav";
  const char * fn_diamond_fall    = "sfx/diamond_fall.wav";
  const char * fn_diamond_collect = "sfx/diamond_collect.wav";
  const char * fn_move_empty      = "sfx/move_empty.wav";
  const char * fn_move_sand       = "sfx/move_sand.wav";
  const char * fn_ameba           = "sfx/ameba.wav";
  const char * fn_explosion       = "sfx/explosion.wav";
  const char * fn_small_explosion = "sfx/small_explosion.wav";
  const char * fn_time            = "sfx/time.wav";
  const char * fn;

  fn = NULL;
  switch(sfx_id)
    {
    case SFX_BOULDER_FALL:
      fn = fn_boulder_fall;
      break;
    case SFX_BOULDER_MOVE:
      fn = fn_boulder_move;
      break;
    case SFX_DIAMOND_FALL:
      fn = fn_diamond_fall;
      break;
    case SFX_DIAMOND_COLLECT:
      fn = fn_diamond_collect;
      break;
    case SFX_MOVE_EMPTY:
      fn = fn_move_empty;
      break;
    case SFX_MOVE_SAND:
      fn = fn_move_sand;
      break;
    case SFX_AMEBA:
      fn = fn_ameba;
      break;
    case SFX_EXPLOSION:
      fn = fn_explosion;
      break;
    case SFX_SMALL_EXPLOSION:
      fn = fn_small_explosion;
      break;
    case SFX_TIME:
      fn = fn_time;
      break;
    case SFX_SIZEOF_:
      fn = NULL;
      break;
    }

  if(fn != NULL)
    {
      sounds[sfx_id] = Mix_LoadWAV(get_data_filename(fn));
      if(sounds[sfx_id] == NULL)
	fprintf(stderr, "Failed to load sound effect '%s': %s\n", get_data_filename(fn), Mix_GetError());
    }
}

static void load_music(enum MUSIC music_id)
{
  const char * fn_title = "sfx/title.xm";
  const char * fn_start = "sfx/start.xm";
  const char * fn;

  fn = NULL;
  switch(music_id)
    {
    case MUSIC_TITLE:
      fn = fn_title;
      break;
    case MUSIC_START:
      fn = fn_start;
      break;
    case MUSIC_SIZEOF_:
      fn = NULL;
      break;
    }

  if(fn != NULL)
    {
      musics[music_id] = Mix_LoadMUS(get_data_filename(fn));
      if(musics[music_id] == NULL)
	fprintf(stderr, "Failed to load music '%s': %s\n", get_data_filename(fn), Mix_GetError());
    }
}


void sfx(enum SFX sfx_id)
{
  if(sounds[sfx_id] != NULL)
    {
      int channel, loops;

      loops = 0;
      channel = -1;
      switch(sfx_id)
	{
	case SFX_BOULDER_FALL:
	  channel = 0;
	  break;
	case SFX_DIAMOND_FALL:
	  channel = 1;
	  break;
	case SFX_MOVE_EMPTY:
	case SFX_MOVE_SAND:
	  channel = 2;
	  break;
	case SFX_AMEBA:
	  channel = 3;
	  loops = -1;
	  break;
	case SFX_EXPLOSION:
	case SFX_SMALL_EXPLOSION:
	  channel = 4;
	  break;
	case SFX_TIME:
	  channel = 5;
	  break;
	case SFX_DIAMOND_COLLECT:
	  channel = 6;
	  break;
	case SFX_BOULDER_MOVE:
	  channel = 7;
	  break;
	case SFX_SIZEOF_:
	  channel = -1;
	  break;
	}

      if(Mix_PlayChannel(channel, sounds[sfx_id], loops) == -1)
	fprintf(stderr, "Failed to play sound effect %d: %s\n", (int) sfx_id, Mix_GetError());
    }
}

void sfx_stop(enum SFX sfx_id)
{
  if(init_mix)
    if(sfx_id == SFX_AMEBA)
      Mix_HaltChannel(3);
}

void sfx_music(enum MUSIC music_id, int loop_forever)
{
  if(init_mix)
    if(musics[music_id] != NULL)
      Mix_FadeInMusic(musics[music_id], loop_forever ? -1 : 0, 100);
}

void sfx_music_stop(void)
{
  if(init_mix)
    if(Mix_PlayingMusic())
      Mix_FadeOutMusic(1000);
}


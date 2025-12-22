/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  sound.h: Interface for music and sound effects
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

#ifndef _SOUND_H_
#define _SOUND_H_

typedef enum { 
	MENU_MUSIC, 
	GAME_MUSIC, 
	GAME_OVER_MUSIC,
	NUM_MUSIC
} MUSIC_TYPE;

typedef enum {
	PLAYER_SHOT_SOUND,
	SMALL_EXPLOSION_SOUND,
	MEDIUM_EXPLOSION_SOUND,
	LARGE_EXPLOSION_SOUND,
	NUM_SOUND
} SFX_TYPE;

void load_sound (void);
void free_sound (void);
void play_music (MUSIC_TYPE m);
void play_music_once (MUSIC_TYPE m);
void play_sfx (SFX_TYPE s);
void stop_music (void);
void stop_sfx (void);
void fade_music (void);

#endif

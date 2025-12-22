/***************************************************************************
                        SdlZombies - Simple zombies game
                             -------------------
    begin                : Sun Apr 15 16:55:07 CEST 2001
    copyright            : (C) 2001 by Philippe Brochard
    email                : hocwp@free.fr
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
 
#include "sdl_util.h"
#include "global.h"


SDL_Surface * screen;

SDLKey key_quit;

int use_sound = 1;
int sound_volume = 2;
int use_map = 1;
int use_keyboard = 1;
int fullscreen = 0;


static const char * images_names[NUM_IMAGES] = {
	/*	Letters and Numbers	*/
	 "data/status/letters.png", 
	 "data/status/letters_small.png", 
	 "data/status/letters_small_2.png", 
	"data/status/numbers-0.png", 
	"data/status/numbers-1.png",
	"data/status/numbers_small.png",
	"data/status/numbers_small_2.png",
	
	/*	Penguin_t	*/
	 "data/penguin/penguin.png",
	 "data/penguin/penguin_stop.png",
	 "data/penguin/penguin_45.png",
	 "data/penguin/penguin_45_stop.png",

	/*	Zombies_t	*/
	 "data/zombies/zombies.png",
	 "data/zombies/zombies_stop.png",
	 "data/zombies/zombies_45.png",
	 "data/zombies/zombies_45_stop.png",
	 "data/zombies/zombies_start.png",
	
	/*	Backgrounds	*/
	 "data/background/back_1.png",
	 "data/background/back_2.png",
	 "data/background/back_3.png",
	 "data/background/back_4.png",
	 "data/background/back_5.png",
	 "data/background/back_6.png",
	 "data/background/back_7.png",
	 "data/background/back_8.png",
	 "data/background/back_9.png",
	 "data/background/back_10.png",
	
	/*	Environment	*/
	 "data/environ/hole.png",
	 "data/environ/map.png",
	 "data/environ/map_2.png",
	 "data/environ/hole_small.png",
	 "data/environ/penguin_small.png",
	 "data/environ/zombies_small.png",

	/* Main Menu */
	 "data/menu/back.png",
	 "data/menu/title.png",
	 "data/menu/play.png",
	 "data/menu/play_s.png",
	 "data/menu/option.png",
	 "data/menu/option_s.png",
	 "data/menu/quit.png",
	 "data/menu/quit_s.png",

	/* Menu Options */
	 "data/menu_opt/level.png",
	 "data/menu_opt/level_s.png",
	
	 "data/menu_opt/no_sound.png",
	 "data/menu_opt/no_sound_s.png",
	 "data/menu_opt/low_sound.png",
	 "data/menu_opt/low_sound_s.png",
	 "data/menu_opt/med_sound.png",
	 "data/menu_opt/med_sound_s.png",
	 "data/menu_opt/hig_sound.png",
	 "data/menu_opt/hig_sound_s.png",
	
	 "data/menu_opt/no_map.png",
	 "data/menu_opt/no_map_s.png",
	 "data/menu_opt/map_trans.png",
	 "data/menu_opt/map_trans_s.png",
	 "data/menu_opt/map_und.png",
	 "data/menu_opt/map_und_s.png",
	 "data/menu_opt/map_ov.png",
	 "data/menu_opt/map_ov_s.png",
	
	 "data/menu_opt/fullscreen.png",
	 "data/menu_opt/fullscreen_s.png",
	 "data/menu_opt/window.png",
	 "data/menu_opt/window_s.png",
	
	 "data/menu_opt/quit.png",
	 "data/menu_opt/quit_s.png",


	/* Nothing */
	 "data/background/carre.png"
};

/* Sprites */
SDL_Surface * images[NUM_IMAGES];

#ifndef NOSOUND
Mix_Chunk * sounds[NUM_SOUNDS];
#endif


static const char * sounds_names[NUM_SOUNDS] = {
	 "data/sounds/menu_val.wav",
	 "data/sounds/menu.wav",
	
	 "data/sounds/intro.wav",
	 "data/sounds/final.wav",
	 "data/sounds/eat.wav",
	 "data/sounds/fall.wav",
	 "data/sounds/evil.wav",
	 "data/sounds/arise.wav"
};




static void LoadImages(void);
static void LoadSounds(void);



void InitGlobalVar(void)
{
	key_quit = SDLK_ESCAPE;

	LoadImages();

	LoadSounds();
}


void CloseGlobalVar(void)
{
	int i;

	for(i = 0; i < NUM_IMAGES; i++)
	{
		if ( images[i] != NULL) SDL_FreeSurface(images[i]);
	}

#ifndef NOSOUND
	for(i = 0; i < NUM_SOUNDS; i++)
	{
		if (sounds[i] != NULL) Mix_FreeChunk(sounds[i]);
	}
#endif
}

/* Sound section */

void PlaySound(int snd)
{
#ifndef NOSOUND
	if (use_sound == 1) {
		Mix_PlayChannel(-1, sounds[snd], 0);
	}
#endif
}

void HaltSound(void)
{
#ifndef NOSOUND
	if (use_sound == 1) {
		Mix_HaltChannel(-1);
	}
#endif
}

void SetSoundVolume(int volume)
{
#ifndef NOSOUND
	if (use_sound == 1) {
		Mix_Volume(-1, volume * MIX_MAX_VOLUME / 3);
	}
#endif
}



/* Load Section */

static SDL_Surface * LoadImageFromFile(const char * name)
{
	SDL_Surface * image;
	SDL_Surface * image_res;

	image = IMG_Load(name);

	if (image == NULL)
	{
		fprintf(stderr,
			"\nError: I couldn't load a graphics file:\n"
			"%s\n"
			"The Simple DirectMedia error that occured was:\n"
			"%s\n\n", name, SDL_GetError());
		exit(1);
	}

	/* Set transparency: */

	if (SDL_SetColorKey(image, (SDL_SRCCOLORKEY | SDL_RLEACCEL),
			SDL_MapRGB(image -> format, 0x80, 0x80, 0x80)) == -1)
	{
		fprintf(stderr,
			"\nError: I could not set the color key for the file:\n"
			"%s\n"
			"The Simple DirectMedia error that occured was:\n"
			"%s\n\n", name, SDL_GetError());
		exit(1);
	}

	image_res = SDL_DisplayFormat(image);
	if (image_res == NULL)
	{
		fprintf(stderr,
			"\nError: I couldn't convert a file to the display format:\n"
			"%s\n"
			"The Simple DirectMedia error that occured was:\n"
			"%s\n\n", name, SDL_GetError());
		exit(1);
	}

	SDL_FreeSurface(image);

	return image_res;
}




static void LoadImages(void)
{
	int i;

	for(i = 0; i < NUM_IMAGES; i++)
		images[i]=LoadImageFromFile(images_names[i]);
}

static void LoadSounds(void)
{
	int i;

#ifndef NOSOUND
	if (use_sound == 1)
	{
		/* Load sounds: */
		for (i = 0; i < NUM_SOUNDS; i++)
		{
			sounds[i] = Mix_LoadWAV(sounds_names[i]);
			if (sounds[i] == NULL)
			{
				fprintf(stderr,
					"\nError: I could not load the sound file:\n"
					"%s\n"
					"The Simple DirectMedia error that occured was:\n"
					"%s\n\n", sounds_names[i], SDL_GetError());
				exit(1);
			}
		}
	}
#endif
}

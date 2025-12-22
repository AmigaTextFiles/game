/* MoleInvasion 0.1 - Copyright (C) 2004 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#define MIXER_C
#include "mixer.h"

/* static global vars */
static Mix_Music *music = NULL;
static int musicInit=0;
static myList* snd_list;

typedef struct {
	char* file;
	Mix_Chunk *sound;
}sound_struct;

int initTheMusic()
{	int audio_rate = 44100;
	Uint16 audio_format = AUDIO_S16SYS;
	int audio_channels = 2;
	int audio_buffers = 4096;
	
	if(SDL_Init(SDL_INIT_AUDIO)!=0)
		return -1;
	
	snd_list=InitList();

	if(Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_buffers))
	{	return -1;
	}
	musicInit=1;
	return 0;
}

int stopTheMusic()
{	if(!g_activate_music)
		return 0;
	if(!music)
		return 0;
	Mix_HaltMusic();
	Mix_FreeMusic(music);
	music = NULL;
	return 0;
}

int startTheMusic(char * file)
{	if(!g_activate_music)
		return 0;
	if(!musicInit)
	{	if(initTheMusic()!=0)
		{	g_activate_music=0;
			return 0;
		}
	}
	if(music)
		stopTheMusic();
        music = Mix_LoadMUS(file);
	if(!music)
	{	printf("Cannot load :%s\n",file);
		return -1;
	}
        Mix_PlayMusic(music, -1);
        Mix_HookMusicFinished((void(*)())stopTheMusic);
	return 0;
}

int searchSound(char * file)
{	int i;
	for(i=0;i<snd_list->size;i++)
		if(strcmp(((sound_struct*)GetPosList(snd_list,i))->file,file)==0)
			return i;
	return -1;
}

int startTheSound(char * file)
{	int pos;
	sound_struct the_sound;
	Mix_Chunk * chunk;

	if(!g_activate_sound)
		return 0;
	
	if(!musicInit)
	{	if(initTheMusic()!=0)
		{	g_activate_sound=0;
			return 0;
		}
	}
	pos=searchSound(file);
	if(pos<0)
	{	the_sound.sound = Mix_LoadWAV(file);
		if(!the_sound.sound)
		{	printf("Cannot load :%s\n",file);
			return -1;
		}
		the_sound.file = (char*)malloc(strlen(file)+1);
		strcpy(the_sound.file,file);
		AddToList(snd_list,&the_sound,sizeof(sound_struct));
		chunk=the_sound.sound;
	}
	else
	{	chunk=((sound_struct*)GetPosList(snd_list,pos))->sound;
	}
	pos=Mix_PlayChannel(-1, chunk, 0);
/*	printf("playing %s  on :%d\n",file,pos);*/
	return pos;
}

#ifdef NO_DEF

void handleKey(SDL_KeyboardEvent key);

int main(void) {

  SDL_Surface *screen;
  SDL_Event event;
  int done = 0;

  /* Same setup as before */

  SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO);

  screen = SDL_SetVideoMode(320, 240, 0, 0);

  while(!done) {
    while(SDL_PollEvent(&event)) {
      switch(event.type) {
      case SDL_QUIT:
        done = 1;
        break;
      case SDL_KEYDOWN:
      case SDL_KEYUP:
        handleKey(event.key);
        break;
      }
    }
    SDL_Delay(50);
  }

  Mix_CloseAudio();
  SDL_Quit();

}

void handleKey(SDL_KeyboardEvent key) {
  switch(key.keysym.sym) {
  case SDLK_a:
    if(key.type == SDL_KEYDOWN)
	startTheSound("../SDLmix/tintopi.wav");
    break;
  case SDLK_z:
    if(key.type == SDL_KEYDOWN)
	startTheSound("../SDLmix/spark.wav");
    break;
  case SDLK_e:
    if(key.type == SDL_KEYDOWN)
	startTheSound("../SDLmix/trance02.wav");
    break;
  case SDLK_m:
    if(key.type == SDL_KEYDOWN)
        startTheMusic("../SDLmix/Lenvoleespatiale.ogg");
	break;
  case SDLK_l:
    if(key.type == SDL_KEYDOWN)
        stopTheMusic();
	break;
  }
}

#endif

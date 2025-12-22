/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: sound.c
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software Foundation,
 *  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 */

#include "ShiftyEngine.h"
#include <SDL/SDL.h>

static int channel;
static int disabled;

#ifndef sg_data_path
#define sg_data_path ""
#endif

/*****************************************************
 ****************************************************/
void playSound(Mix_Chunk * e)
{
	if(disabled || !e)
		return;

	Mix_PlayChannel(channel, e , 0);
	if(++channel >= 8) 
		channel = 0;
}

/*****************************************************
 ****************************************************/
Mix_Chunk * loadSound(const char * name)
{
	char * newname;

	Mix_Chunk * temp;
	int len1 = strlen(sg_data_path), len2 = strlen(name);

	if(disabled)
		return NULL;

	newname = (char*)malloc(len1 + len2 + 1);
	if(newname == NULL) {
		fprintf(stderr, "Out of memory!\n");
		exit(1);
	}
	strcpy(newname, sg_data_path);
	strcat(newname, name);

	temp = Mix_LoadWAV(newname);
	if(!temp)
		fprintf(stderr, "Could not load sound file: %s.\n", newname);

	free(newname);
	return temp;
}

/*****************************************************
 ****************************************************/
void setVolume(const int v)
{
	if(disabled)
		return;

	Mix_Volume(-1, v);
}

/*****************************************************
 ****************************************************/
void initMixer()
{
	channel = 0;

	disabled = Mix_OpenAudio(22050, AUDIO_S16SYS, 2, 2048);
	
	if(disabled)
		fprintf(stderr, "Could not initialize SDL_Mixer: %s.\n", SDL_GetError());

}


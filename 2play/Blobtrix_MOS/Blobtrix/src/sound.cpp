/*
    Copyright (c) 2004-2005 Markus Kettunen

    This file is part of Blobtrix.

    Blobtrix is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Blobtrix is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Blobtrix; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


#include "sound.h"

#ifndef NOSOUND

#include <iostream>

static int _channels=0;

int sound::Start() {
	if (Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2 /* mono */, 4096)==-1) {
		fprintf(stderr, "Mix_OpenAudio: %s\n", Mix_GetError());
		exit(2);
	}

	fprintf (stderr, "Started sound system.\n");

	return 1;
}

int sound::Stop() {
	Mix_CloseAudio();
	fprintf (stderr, "Stopped sound system.\n");
	return 1;
}

Mix_Chunk *sound::LoadWAV(char *filename) {
	Mix_Chunk *sample;
	sample=Mix_LoadWAV(filename);
	if(!sample) {
		printf("Mix_LoadWAV: %s\n", Mix_GetError());
		exit(1);
	}
	fprintf (stderr, "Sample \"%s\" loaded.\n", filename);
	return sample;
}

void sound::FreeChunk(Mix_Chunk *chunk) {
	Mix_FreeChunk(chunk);
}

int sound::ChunkVolume(Mix_Chunk *chunk, int volume) {
	return Mix_VolumeChunk(chunk, volume);
}


void sound::SoundVolume(int volume) {
	for (int i=0; i<_channels; i++) {
		ChannelVolume(i, volume);
	}
}


void sound::SetChannels(int channels) {
	Mix_AllocateChannels(channels);
	_channels=channels;
}

int sound::ChannelVolume(int channel, int volume) {
	return Mix_Volume(channel, volume);
}

void sound::PauseChannel(int channel) {
	Mix_Pause(channel);
}
void sound::ResumeChannel(int channel) {
	Mix_Resume(channel);
}
void sound::HaltChannel(int channel) {
	Mix_HaltChannel(channel);
}

int sound::PlayChunk(int channel, Mix_Chunk *chunk, int loops) {
	return Mix_PlayChannel(channel, chunk, loops);
}

Mix_Music *sound::LoadMusic(char *filename) {
	Mix_Music *music;
	music = Mix_LoadMUS(filename);
	if (!music) {
		fprintf (stderr, "Mix_LoadMUS(\"%s\"): %s\n", filename, Mix_GetError());
		exit(1);
	}
	return music;
}

void sound::FreeMusic(Mix_Music *music) {
	Mix_FreeMusic(music);
	music=NULL;
}

int sound::PlayMusic(Mix_Music *music, int loops) {
	if (Mix_PlayMusic(music, loops)==-1) {
		fprintf(stderr, "Mix_PlayMusic: %s\n", Mix_GetError());
		return 0;
 	}
	return 1;
}

int sound::FadeInMusic(Mix_Music *music, int loops, int ms) {
	return Mix_FadeInMusic(music, loops, ms);
}

int sound::MusicVolume(int volume) {
	return Mix_VolumeMusic(volume);
}

void sound::PauseMusic() {
	Mix_PauseMusic();
}

void sound::ResumeMusic() {
	Mix_ResumeMusic();
}

int sound::HaltMusic() {
	return Mix_HaltMusic();
}

int sound::FadeOutMusic(int ms) {
	return Mix_FadeOutMusic(ms);
}

int sound::MusicPlaying() {
	return Mix_PlayingMusic();
}

#endif

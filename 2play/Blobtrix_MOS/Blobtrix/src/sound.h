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


#ifndef _SOUND_H_
#define _SOUND_H_

#include "config.h"

#ifndef NOSOUND

#include "SDL_mixer.h"

#include <stdlib.h>
#include <stdio.h>

namespace sound {
		int Start();
		int Stop();	
		Mix_Chunk *LoadWAV(char *filename);
		void FreeChunk(Mix_Chunk *chunk);
	
		int ChunkVolume(Mix_Chunk *chunk, int volume);
		void SoundVolume(int volume);

		void SetChannels(int channels);
		int ChannelVolume(int channel, int volume);
		void PauseChannel(int channel);
		void ResumeChannel(int channel);
		void HaltChannel(int channel);
	
		int PlayChunk(int channel, Mix_Chunk *chunk, int loops);
	
		Mix_Music *LoadMusic(char *filename);
		void FreeMusic(Mix_Music *music);
	
		int PlayMusic(Mix_Music *music, int loops);
		int FadeInMusic(Mix_Music *music, int loops, int ms);
	
		int MusicVolume(int volume);
		void PauseMusic();
		void ResumeMusic();
		int HaltMusic();
	
		int FadeOutMusic(int ms);
	
		int MusicPlaying();
};



#endif
#endif


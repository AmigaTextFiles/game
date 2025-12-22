/*

Mures
Copyright (C) 2001 Adam D'Angelo

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Contact information:

Adam D'Angelo
dangelo@ntplx.net
P.O. Box 1155
Redding, CT 06875-1155
USA

*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "SDL.h"

#define NUM_SOUNDS 16
struct sample {
  Uint8 *data;
  Uint32 dpos;
  Uint32 dlen;
  char *file;
} sound[NUM_SOUNDS];

void mixaudio(void *unused, Uint8 *stream, int len)
{
    int i;
    Uint32 amount;

    for(i=0; i<NUM_SOUNDS; i++) {
      amount = (sound[i].dlen-sound[i].dpos);
      if(amount > len)
	amount = len;

      SDL_MixAudio(stream, &sound[i].data[sound[i].dpos], amount, SDL_MIX_MAXVOLUME);
      sound[i].dpos += amount;
    }
}

void PlaySound(char *file)
{
  int index;
  SDL_AudioSpec wave;
  Uint8 *data;
  Uint32 dlen;
  SDL_AudioCVT cvt;

  /* Look for an empty (or finished) sound slot */
  for (index=0; index<NUM_SOUNDS; ++index ) {
    if ( sound[index].dpos == sound[index].dlen ||
	 strcmp(sound[index].file, file)==0) {
      break;
    }
  }
  if ( index == NUM_SOUNDS ) {
    /*fprintf(stderr, "out of sound spots.\n");*/

    /* TODO: make this replace the oldest one */
    return;
  }

  /* Load the sound file and convert it to 16-bit stereo at 22kHz */
  if (SDL_LoadWAV(file, &wave, &data, &dlen) == NULL ) {
    fprintf(stderr, "Couldn't load %s: %s\n", file, SDL_GetError());
    return;
  }
  SDL_BuildAudioCVT(&cvt, wave.format, wave.channels, wave.freq,
		    AUDIO_S16,   2,             22050);
  cvt.buf = malloc(dlen*cvt.len_mult);
  memcpy(cvt.buf, data, dlen);
  cvt.len = dlen;
  SDL_ConvertAudio(&cvt);
  SDL_FreeWAV(data);

  /* Put the sound data in the slot (it starts playing immediately) */
  if (sound[index].data)
    free(sound[index].data);

  SDL_LockAudio();
  sound[index].data = cvt.buf;
  sound[index].dlen = cvt.len_cvt;
  sound[index].dpos = 0;
  sound[index].file = file;
  SDL_UnlockAudio();
}

void play_sound(char *file)
{
  /* later preload sounds */
  PlaySound(file);
}

int audio_init()
{
  SDL_AudioSpec fmt;

  printf("Initializing audio...\n");
  

    /* Set 16-bit stereo audio at 22Khz */
  fmt.freq = 22050;
  fmt.format = AUDIO_S16;
  fmt.channels = 2;
  fmt.samples = 512;        /* A good value for games */
  fmt.callback = mixaudio;
  fmt.userdata = NULL;
  
  /* Open the audio device and start playing sound! */
  if(SDL_OpenAudio(&fmt, NULL) < 0) {
    fprintf(stderr, "Unable to open audio: %s\n", SDL_GetError());
    return 0;
  }

  SDL_PauseAudio(0);

  return 1;
}

void audio_exit()
{
  SDL_CloseAudio();
}  

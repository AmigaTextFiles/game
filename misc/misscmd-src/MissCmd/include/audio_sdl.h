#ifndef AUDIO_H
#define AUDIO_H

#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>

typedef Mix_Chunk sound;

/* audio.c */
int InitAudio ();
void CleanupAudio ();
sound **LoadSndArray (char **filenames);
void FreeSndArray (sound **array);

#define LoadSnd(name) Mix_LoadWAV(name)
#define FreeSnd(snd) Mix_FreeChunk(snd);
#define PlaySnd(snd,chan,loops) Mix_PlayChannel(chan,snd,loops)

#endif

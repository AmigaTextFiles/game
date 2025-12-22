#ifndef AUDIO_AHI_H
#define AUDIO_AHI_H

#include <devices/ahi.h>

typedef struct {
	void *samples;
	uint32 type;
	int32 length, freq;
	int32 samplesize, channels;
} sound;

/* audio_io.c */
sound *LoadSnd_WAV (char *name);

/* audio_ahi.c */
int InitAudioEngine ();
void CleanupAudioEngine ();
sound *LoadSnd (char *name);
void FreeSnd (sound *snd);
sound **LoadSndArray (char **names);
void FreeSndArray (sound **array);
void PlaySnd (sound *snd, int32 volume, int32 position);
void StopSnd ();

#endif /* AUDIO_AHI_H */

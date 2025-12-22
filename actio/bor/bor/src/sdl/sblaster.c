// A soundblaster interface. No bugs?

#include "sblaster.h"
#include <SDL.h>

static SDL_AudioSpec cspec;
static int dmapos;
static int sample_per_byte;
// The interface
static int voicevol = 15; //0..15

static int buffsize;
static char* buffer;

static void callback(void *userdata, Uint8 *stream, int len)
{
//	printf("callback(%p,%p,%d)\n",userdata,stream,len);
	update_sample(stream,len);
}

void * SB_init(int port, int dma, int hdma, int irq, int buffersize)
{
	buffsize = buffersize;
	buffer = malloc(buffsize);
	return buffer;
}

static int started;

int SB_playstart(int stereo, int bits, int samplerate)
{
	SDL_AudioSpec spec;

//	if (started) return 0;

	spec.channels = stereo+1;
	spec.format = bits==16?AUDIO_U16SYS /*U16LSB*/:AUDIO_U8;
	spec.freq = samplerate;

  //printf("playstart(%d,%d,%d)\n",stereo,bits,samplerate);

	sample_per_byte = 16/bits*spec.channels;

	spec.samples =
    buffsize/sample_per_byte/2;
	spec.userdata = NULL;
	spec.callback = callback;

	SDL_PauseAudio(1);
	if (SDL_OpenAudio(&spec,&cspec)<0) return 0;

//	printf("%d %d %d\n",cspec.channels, cspec.format,cspec.freq);
	SDL_PauseAudio(0);
	started = 1;
	return 1;
}

/*
int SB_getpos()
{
	return 0;
}
*/

void SB_playstop()
{
	SDL_PauseAudio(1);
}

void SB_exit()
{
}

void SB_hook(void (*func)())
{
}

void getSBvars(int *a, int *i, int *d, int *h, int *type)
{
}

char SB_getvolume(char dev)
{
}

char SB_setvolume(char dev, char volume)
{
	if (dev == SB_VOICEVOL) voicevol = volume;
}


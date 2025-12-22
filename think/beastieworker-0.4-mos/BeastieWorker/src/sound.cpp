#include "sound.h"


#define _NUMBER_SOUNDS 3
struct struct_sound
{
	Uint8 *data;
	Uint32 dpos;
	Uint32 dlen;
}	sounds[_NUMBER_SOUNDS];

bool soundInit= false;
//----------------------------------------------//
void MixAudio (void *unused, Uint8 *stream, int len)
{
	int i;
	Uint32 amount;
	for (i= 0; i < _NUMBER_SOUNDS; ++i)
	{
		amount= (sounds[i].dlen - sounds[i].dpos);
		if (amount > (Uint32)len)
			amount= len;
		SDL_MixAudio(stream, &sounds[i].data[sounds[i].dpos], amount, SDL_MIX_MAXVOLUME);
		sounds[i].dpos+= amount;
   }
}
//----------------------------------------------//
int checkAudioDevice ()
{
	SDL_AudioSpec wanted;
	wanted.freq= 22050;
	wanted.format= AUDIO_S16SYS;
	wanted.channels= 2;
	wanted.samples= 1024;
	wanted.callback= MixAudio;
	wanted.userdata= NULL;
	if (SDL_OpenAudio (&wanted, NULL) < 0)
	{
		printf ("ERROR: couldn't open audio\n");
		return (-1);
	}
	SDL_PauseAudio (0);
	soundInit= true;
	return 0;
}
//----------------------------------------------//
void soundPlay (char *input_file)
{
	if (!soundInit)
		return;
	SDL_AudioSpec wave;
	Uint8 *data;
	Uint32 dlen;
	SDL_AudioCVT cvt;
	int i;
	for (i= 0; i < _NUMBER_SOUNDS; ++i)
		if (sounds[i].dpos == sounds[i].dlen )
			break;
	if (i == _NUMBER_SOUNDS)
		return;
	if (SDL_LoadWAV (input_file, &wave, &data, &dlen) == NULL)
		return;
	SDL_BuildAudioCVT (&cvt, wave.format, wave.channels, wave.freq, AUDIO_S16SYS, 2, 22050);
	cvt.buf= new Uint8 [dlen * cvt.len_mult];
	memcpy (cvt.buf, data, dlen);
	cvt.len= dlen;
	SDL_ConvertAudio (&cvt);
	SDL_FreeWAV (data);
	if (sounds[i].data)
		delete sounds[i].data;
	SDL_LockAudio();
	sounds[i].data= cvt.buf;
	sounds[i].dlen= cvt.len_cvt;
	sounds[i].dpos= 0;
	SDL_UnlockAudio();
}
//----------------------------------------------//

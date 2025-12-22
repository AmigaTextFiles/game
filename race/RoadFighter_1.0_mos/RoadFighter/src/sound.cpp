#include "SDL.h"
#include "SDL_mixer.h"
#include "SDL_sound.h"
#include "sound.h"
#include "stdio.h"
#include "string.h"
#include "stdlib.h"

#define AUDIO_BUFFER	2048


int music_volume=127;

bool sound_enabled=false;

bool playing_music=false;
Sound_Sample *music_sound=0;
int music_loops=0;
int current_music_loop=0;

void myMusicPlayer(void *udata, Uint8 *stream, int len);


bool Sound_initialization(void)
{
    char SoundcardName[256];
	int audio_rate = 44100;
	int audio_channels = 2;
	int audio_bufsize = AUDIO_BUFFER;
#ifdef __MORPHOS__
	Uint16 audio_format = AUDIO_S16MSB;
#else
	Uint16 audio_format = AUDIO_S16;
#endif
	SDL_version compile_version;

	sound_enabled=true;
	fprintf (stderr, "Initializing SDL_mixer.\n");
	if (Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_bufsize))  {
	  fprintf (stderr, "Unable to open audio: %s\n", Mix_GetError());
	  sound_enabled=false;
	  fprintf (stderr, "Running the game without audio.\n");
	  return false;	
	} /* if */ 

	SDL_AudioDriverName (SoundcardName, sizeof (SoundcardName));
	Mix_QuerySpec (&audio_rate, &audio_format, &audio_channels);
	fprintf (stderr, "    opened %s at %d Hz %d bit %s, %d bytes audio buffer\n",
			 SoundcardName, audio_rate, audio_format & 0xFF,
			 audio_channels > 1 ? "stereo" : "mono", audio_bufsize);
	MIX_VERSION (&compile_version);
	fprintf (stderr, "    compiled with SDL_mixer version: %d.%d.%d\n",
			 compile_version.major,
			 compile_version.minor,
			 compile_version.patch);
	fprintf (stderr, "    running with SDL_mixer version: %d.%d.%d\n",
			 Mix_Linked_Version()->major,
			 Mix_Linked_Version()->minor,
			 Mix_Linked_Version()->patch);

	Sound_Init();
	Mix_HookMusic(myMusicPlayer, 0);

	return true;
} /* Sound_init */ 

void Sound_release(void)
{
	Sound_release_music();
	if (sound_enabled) {
		Sound_Quit();
		Mix_CloseAudio();
	} /* if */ 
	sound_enabled=false;
} /* Sound_release */ 


void Stop_playback(void)
{
	Sound_pause_music();
	Mix_HookMusic(0, 0);
	Mix_CloseAudio();
	sound_enabled=false;
} /* Stop_playback */ 

void Resume_playback(void)
{
    char SoundcardName[256];
	int audio_rate = 44100;
	int audio_channels = 2;
	int audio_bufsize = AUDIO_BUFFER;
#ifdef __MORPHOS__
	Uint16 audio_format = AUDIO_S16MSB;
#else
	Uint16 audio_format = AUDIO_S16;
#endif
	SDL_version compile_version;

	sound_enabled=true;
	fprintf (stderr, "Initializing SDL_mixer.\n");
	if (Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_bufsize))  {
	  fprintf (stderr, "Unable to open audio: %s\n", Mix_GetError());
	  sound_enabled=false;
	  fprintf (stderr, "Running the game without audio.\n");
	  return;	
	} /* if */ 

	SDL_AudioDriverName (SoundcardName, sizeof (SoundcardName));
	Mix_QuerySpec (&audio_rate, &audio_format, &audio_channels);
	fprintf (stderr, "    opened %s at %d Hz %d bit %s, %d bytes audio buffer\n",
			 SoundcardName, audio_rate, audio_format & 0xFF,
			 audio_channels > 1 ? "stereo" : "mono", audio_bufsize);
	MIX_VERSION (&compile_version);
	fprintf (stderr, "    compiled with SDL_mixer version: %d.%d.%d\n",
			 compile_version.major,
			 compile_version.minor,
			 compile_version.patch);
	fprintf (stderr, "    running with SDL_mixer version: %d.%d.%d\n",
			 Mix_Linked_Version()->major,
			 Mix_Linked_Version()->minor,
			 Mix_Linked_Version()->patch);

	Mix_HookMusic(myMusicPlayer, 0);
	Sound_unpause_music();
} /* Resume_playback */ 


/* a check to see if file is readable and greater than zero */
int file_check(char *fname)
{
	FILE *fp;

	if ((fp=fopen(fname,"r"))!=NULL) {
		if (fseek(fp,0L, SEEK_END)==0 && ftell(fp)>0) {
  			fclose(fp);
			return true;
		} /* if */ 
		/* either the file could not be read (==-1) or size was zero (==0) */ 
		fprintf(stderr,"ERROR in file_check(): the file %s is corrupted.\n", fname);
		fclose(fp);
		exit(1);
	} /* if */ 
	return false;
} /* file_check */ 



SOUNDT Sound_create_sound(char *file)
{
	int n_ext=6;
	char *ext[6]={".WAV",".OGG",".MP3",".wav",".ogg",".mp3"};
	char name[256];
	int i;

	if (sound_enabled) {
		for(i=0;i<n_ext;i++) {
			strcpy(name,file);
			strcat(name,ext[i]);
			if (file_check(name)) return Mix_LoadWAV(name);
		} /* for */ 

		fprintf(stderr,"ERROR in Sound_create_sound(): Could not load sound file: %s.(wav|ogg|mp3)\n",file);
		exit(1);
	} else {
		return 0;
	} /* if */ 
} /* Sound_create_sound */ 


void Sound_delete_sound(SOUNDT s)
{
	if (sound_enabled) Mix_FreeChunk(s);
} /* Sound_delete_sound */ 


void Sound_play(SOUNDT s)
{
	if (sound_enabled) Mix_PlayChannel(-1,s,0);
} /* Sound_play */ 


Sound_Sample *Sound_create_stream(char *file)
{
	int n_ext=6;
	char *ext[6]={".WAV",".OGG",".MP3",".wav",".ogg",".mp3"};
	char name[256];
	int i;

	Sound_AudioInfo inf;

#ifdef __MORPHOS__
	inf.format=AUDIO_S16MSB;
#else
	inf.format=AUDIO_S16;
#endif
	inf.channels=2;
	inf.rate=44100;

	if (sound_enabled) {
		for(i=0;i<n_ext;i++) {
			strcpy(name,file);
			strcat(name,ext[i]);
			if (file_check(name)) return Sound_NewSampleFromFile(name,&inf,AUDIO_BUFFER);
		} /* for */ 
		
		fprintf(stderr,"ERROR in Sound_create_stream(): Could not load sound file: %s.(wav|ogg|mp3)\n", file);
		exit(1);
	} else {
		return 0;
	} /* if */ 
} /* Sound_create_stream */ 


void Sound_create_music(char *f1,int loops)
{
	int seq_len=0;

	if (sound_enabled) {
		if (f1!=0) {
			music_sound=Sound_create_stream(f1);
			music_loops=loops;
			current_music_loop=0;
		} else {
			music_sound=0;
			music_loops=0;
			current_music_loop=0;
		} /* if */ 

		playing_music=true;
	} /* if */ 
} /* Sound_create_music */ 


void Sound_release_music(void)
{
	if (sound_enabled) {
		playing_music=false;
		if (music_sound!=0) Sound_FreeSample(music_sound);
		music_sound=0;
	} /* if */ 
} /* Sound_release_music */ 



void Sound_pause_music(void)
{
	playing_music=false;
} /* Sound_pause_music */ 


void Sound_unpause_music(void)
{
	playing_music=true;
} /* Sound_unpause_music */ 



void myMusicPlayer(void *udata, Uint8 *stream, int len)
{
	int i,act=0;
	Sint16 *ptr2;

	if (stream!=0) {
		ptr2=(Sint16 *)stream;
		if (playing_music) {
			while(act<len) {
				if (music_sound!=0) {
					/* Play a music file: */ 

					if ((music_sound->flags&SOUND_SAMPLEFLAG_EOF)) {
						/* End of file: */ 
						if (music_loops!=-1) {
							current_music_loop++;
							if (current_music_loop>music_loops) {
								playing_music=false;
								if (music_sound!=0) Sound_FreeSample(music_sound);								
								music_sound=0;
							} else {
								Sound_Rewind(music_sound);
							} /* if */ 
						} else {
								Sound_Rewind(music_sound);
						} /* if */ 
					} else {
						/* In the middle of the file: */ 
						int decoded=0;
						Sint16 *ptr;

						Sound_SetBufferSize(music_sound, len-act);
						
						decoded=Sound_Decode(music_sound);
						ptr=(Sint16 *)music_sound->buffer;
						for(i=0;i<decoded;i+=2,ptr++,ptr2++) {
							*ptr2=((Sint32(*ptr)*Sint32(music_volume))/127);
						} /* for */ 
						act+=decoded;
					} /* if */ 
				} else {
					/* No music file loaded: */ 
					for(i=act;i<len;i++) stream[i]=0;
					act=len;
				} /* if */ 
			} /* while */ 
		} else {
			/* No music to play: */ 
			for(i=0;i<len;i++) stream[i]=0;
		} /* if */ 
	} else {
		fprintf(stderr,"ERROR in myMusicPlayer(): null music stream!!\n");
	} /* if */ 
} /* myMusicPlayer */ 


void Sound_music_volume(int volume)
{
	if (volume<0) volume=0;
	if (volume>127) volume=127;
	music_volume=volume;
} /* Sound_music_volume */ 

#ifndef __BRAIN_SDL_SOUND
#define __BRAIN_SDL_SOUND

typedef Mix_Chunk * SOUNDT;

bool Sound_initialization(void);
void Sound_release(void);

SOUNDT Sound_create_sound(char *file);
void Sound_delete_sound(SOUNDT s);
void Sound_play(SOUNDT s);

void Sound_create_music(char *f1,int times);
void Sound_release_music(void);
void Sound_pause_music(void);
void Sound_unpause_music(void);

void Sound_music_volume(int volume);

/* These functions are AGRESIVE! (i.e. they actually STOP SDL_mixer and restart it) */
void Stop_playback(void);
void Resume_playback(void);

#endif


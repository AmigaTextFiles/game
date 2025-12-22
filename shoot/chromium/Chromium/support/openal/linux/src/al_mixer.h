/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_mixer.h
 *
 * Prototypes, macros and definitions related to the control and
 * execution of the mixing "thread".
 *
 * The mixing "thread" is responsible for managing playing sources,
 * applying the requisite filters, mixing in audio data from said sources,
 * etc.
 *
 */
#ifndef _AL_MIXER_H_
#define _AL_MIXER_H_

#include <AL/altypes.h>

#define MAXMIXSOURCES    64

/* our main mixing function */
extern int (*mixer_iterate)(void *dummy);        

/* is openal finished yet? */
extern volatile ALboolean time_for_mixer_to_die;

/* Initialize mixer specific data */
ALboolean _alInitMixer(void); 

/* Set the mixer based on the default context */
void _alSetMixer(ALboolean synchronous);

/* Destroy mixer specific data.  Time to die! */
void _alDestroyMixer(void);

/* "play" a source */
void _alAddSourceToMixer(ALuint sid);

/* "stop" a source */
ALboolean _alRemoveSourceFromMixer(ALuint sid);

/* "start" a capture */
void _alAddCaptureToMixer(ALuint cpid);

/* "stop" a capture */
void _alRemoveCaptureFromMixer(ALuint cpid);

void FL_alLockMixBuf(const char *fn, int ln);
void FL_alUnlockMixBuf(const char *fn, int ln);

/* functions to pause async mixer.  Oy Vey */
void _alLockMixerPause(void);
void _alUnlockMixerPause(void);

/* macro madness */
#define _alLockMixBuf()   FL_alLockMixBuf(__FILE__, __LINE__)
#define _alUnlockMixBuf() FL_alUnlockMixBuf(__FILE__, __LINE__)

#endif

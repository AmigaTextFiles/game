/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_mixmanager.h
 *
 * Interface to the mixmanager.  The mix manager is an abstraction such
 * that repeated calls to mix audio data can be collected into one set,
 * so that optimizations can be performed based on the number of data
 * streams that need to be mixed simultaneously.
 *
 */
#ifndef _AL_MIXMANAGER_H_
#define _AL_MIXMANAGER_H_

#include "al_types.h"
#include "al_mixfunc.h"

/*
 * Our mix manager.
 *
 * By using a mix manager, I hope to pool together the calls to
 * mix audio, in essence loop unrolling on the fly.  Instead of
 * mixing each source's outdata directly onto the mix buffer, we
 * add an entry to the MixManager, which after it has collected
 * all sources for the mixer_iteration interval uses a MixAudio
 * call optimized for the number of sources present.
 *
 * Used in conjunction with MixFuncs
 */
typedef struct _AL_MixManager {
	alMixEntry *pool;
	ALuint size;
	ALuint index;
} ALMixManager;

/* Mix manager funcs */
ALboolean _alMixManagerInit(ALMixManager *mixman, ALuint size);
void _alMixManagerAdd(ALMixManager *mixman, void *dataptr, int bytes_to_write);
void _alMixManagerMix(ALMixManager *mixman, ALMixFunc *mf, void *dataptr);
void _alMixManagerDestroy(ALMixManager *mixman);

#endif /* _AL_MIXMANAGER_H_ */

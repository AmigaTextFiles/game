/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_buffer.h
 *
 * Prototypes, macros and definitions related to the creation and
 * management of buffers.
 *
 */
#ifndef _AL_BUFFER_H_
#define _AL_BUFFER_H_

#include "al_types.h"

ALboolean _alInitBuffers(void);
void _alDestroyBuffers(void);

AL_buffer *_alGetBuffer(ALuint id);
AL_buffer *_alGetBufferFromSid(ALuint cid, ALuint sid);

/*
 * _alIsBuffer does not lock the buffers, so is safe to use in
 * calls which do.
 */
ALboolean _alIsBuffer(ALuint bid);

/* more refcount stuff */
ALenum _alGetBidState(ALuint bid);
ALenum _alGetBufferState(AL_buffer *buffer);

void _alBidAddQueueRef(ALuint bid, ALuint sid);
void _alBidAddCurrentRef(ALuint bid, ALuint sid);
void _alBidRemoveCurrentRef(ALuint bid, ALuint sid);
void _alBidRemoveQueueRef(ALuint bid, ALuint sid);


ALboolean _alBidIsStreaming(ALuint bid);
ALboolean _alBidIsCallback(ALuint bid);

ALboolean _alBufferIsCallback(AL_buffer *buf);

void _alNumBufferHint(ALuint nb);

/*
 * sigh.  callbacks in alut don't know when sources or buffers are deleted,
 * so they have to be explicitly told.
 */
void _alBufferDataWithCallback_LOKI(ALuint bid,
					int (*callback)(ALuint sid, 
							ALuint bid,
							ALshort *outdata,
							ALenum format,
							ALint freq,
							ALint samples),
					DestroyCallback_LOKI source_destroyer,
					DestroyCallback_LOKI buffer_destroyer);
void _alBidCallDestroyCallbackSource(ALuint sid);

ALboolean FL_alLockBuffer(const char *fn, int ln);
ALboolean FL_alUnlockBuffer(const char *fn, int ln);

/*
 * convert data passed into the correct format, return result.
 *
 * If should_use_passed_data is AL_TRUE, then the conversion happens
 * in-place, and the return value is equal to data.  Otherwise, a
 * new memory region is alloced, and it is the responsibility of the
 * caller to free it.
 */
void *_alBufferCanonizeData(ALenum format, void *data, ALuint size, ALuint freq,
			    ALenum tformat, ALuint tfreq, ALuint *retsize,
			    ALenum should_use_passed_data);

/* macros */
#define _alLockBuffer()       FL_alLockBuffer(__FILE__, __LINE__)
#define _alUnlockBuffer()     FL_alUnlockBuffer(__FILE__, __LINE__)

#define _alDCGetBufferFromSid(x)                                    \
	_alGetBufferFromSid((ALuint) _alcCCId, x)

#endif

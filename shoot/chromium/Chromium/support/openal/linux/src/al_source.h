/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_source.h
 *
 * Prototypes, macros and definitions related to the creation and
 * management of sources.
 *
 */
#ifndef _AL_SOURCE_H_
#define _AL_SOURCE_H_

#include <stdio.h>

#include "al_types.h"

AL_source *_alInitSources(ALuint id);
void *     _alGetSourceParam(AL_source *source, ALenum pid);
void *     _alDefaultSourceParam(ALenum pid);

void _alSplitSources(ALuint cid, ALuint sid,
		     ALint nc, ALuint len,
		     AL_buffer *buf, ALshort **buffs);

void _alCollapseSource(ALuint cid, ALuint sid,
		       ALuint nc, ALuint mixbuflen,
		       ALshort **buffers);

AL_source *_alGetSource(ALuint cid, ALuint sourceid);

/*
 * _alIsSource does not do any context locking, so is safe to use 
 * in functions which do.
 */
ALboolean _alIsSource(ALuint sid);

void _alDestroySource(void *src);
void _alDestroySources(spool_t *spool);

/* rewind source with id sid from context with id cid */
void _alSidRewind(ALuint cid, ALuint sid, ALuint sindex);

/* translate source by delta */
void _alSourceTranslate(AL_source *src, ALfloat *delta);

/* reset srcParam settings */
void _alSourceParamReset(AL_source *src); 

/* apply srcParam settings */
void _alSourceParamApply(AL_source *src, ALuint nc, ALuint len, ALshort **buffers);

ALboolean _alSourceShouldIncrement(AL_source *src);

ALint _alSourceGetPendingBids(AL_source *src);

void _alMonoifyOffset(ALshort **dstref, ALuint offset, ALvoid *src, ALuint ssize, ALuint dc, ALuint sc);

void _alSourceIncrement(AL_source *src, ALuint bytes);

ALint _alSourceBytesLeft(AL_source *src, AL_buffer *samp);
ALint _alSourceBytesLeftByChannel(AL_source *src, AL_buffer *samp);

void _alChannelifyOffset(ALshort *dst, ALuint offset, ALshort **srcs, ALuint size, ALuint nc);

ALboolean _alSourceIsLooping( AL_source *src );

/* macros */
#define _alDCGetSource(i)    _alGetSource(_alcCCId, i)
#define _alDCSidRewind(s, i) _alSidRewind(_alcCCId, s, i)
#define _alChannelify(d,srcs,size,nc) _alChannelifyOffset(d, 0, srcs, size, nc)
#define _alMonoify(d, s, size, dc, sc) _alMonoifyOffset(d, 0, s, size, dc, sc)

#ifdef PARANOID_LOCKING
#define SOURCELOCK()   _alcDCLockContext()
#define SOURCEUNLOCK() _alcDCUnlockContext()
#else
#define SOURCELOCK()
#define SOURCEUNLOCK()
#endif

#define AL_FIRST_SOURCE_ID  0x4000

#endif /* _AL_SOURCE_H_ */

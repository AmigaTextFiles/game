/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_source.c
 *
 * Contains the implementation for source related functions like
 * GenSource, DeleteSource, SourcePlay, etc, as well as internal
 * use functions intended to manage the source structure.
 *
 */
#include "al_siteconfig.h"

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#include <AL/al.h>
#include <AL/alc.h>
#include <AL/alkludge.h>
#include <AL/alut.h>

#include "al_buffer.h"
#include "al_config.h"
#include "al_debug.h"
#include "al_error.h"
#include "al_main.h"
#include "al_mixer.h"
#include "al_spool.h"
#include "al_source.h"
#include "al_queue.h"
#include "al_types.h"
#include "alc/alc_context.h"
#include "alc/alc_speaker.h"

/* static function prototypes */
static void _alInitSource(ALuint sid);

static void _alMonoifyOffset1to2(ALshort **dstref, ALuint offset, ALvoid *src, ALuint ssize);
static void _alMonoifyOffset2to2(ALshort **dstref, ALuint offset, ALvoid *src, ALuint ssize);

static void _alChannelify1to2Offset(ALshort *dst, ALuint offset, ALshort **srcs, ALuint size);

/* static data */
static ALshort *stereoptr = NULL; /*
				   * scratch space for splitting multichannels
				   * sources.
				   */
				   
/*
 * special split source to handle callbacks
 */
static void _alSplitSourceCallback(ALuint cid,
		     ALuint sourceid,
		     ALint nc, ALuint len,
		     AL_buffer *samp,
		     ALshort **buffers);
/*
 * special split source to handle looping end case (wrap-around).
 */
static void _alSplitSourceLooping(ALuint cid,
		     ALuint sourceid,
		     ALint nc, ALuint len,
		     AL_buffer *samp,
		     ALshort **buffers);

/*
 * special split source to handle buffer queue transitions
 * (wrap-around).
 */
static void _alSplitSourceQueue(ALuint cid,
		     ALuint sourceid,
		     ALint nc, ALuint len,
		     AL_buffer *samp,
		     ALshort **buffers);

void *_alSourceGetBufptr(AL_source *src, AL_buffer *buf, ALuint index);

/*
 * alIsSource
 *
 * Returns AL_TRUE if sid is a currently valid source id, 
 * AL_FALSE otherwise.
 */
ALboolean alIsSource( ALuint sid ) {
	ALboolean retval = AL_FALSE;

	_alcDCLockContext();

	retval = _alIsSource(sid);

	_alcDCUnlockContext();

	return retval;
}

/*
 * _alIsSource
 *
 * Returns AL_TRUE if sid is a currently valid source id, 
 * AL_FALSE otherwise.
 *
 * Assumes locked context
 */
ALboolean _alIsSource( ALuint sid ) {
	AL_source *src;
	ALboolean retval = AL_TRUE;

	src = _alDCGetSource(sid);
	if(src == NULL) {
		retval = AL_FALSE;
	}

	return retval;
}

/*
 * alGenSources
 *
 * Generate n sources, with sids in buffer[0..(n-1)].  Only
 * full allocation is performed, with error being set otherwise.
 *
 * If n is 0, this is a legal nop.  If n < 0, INVALID_VALUE is
 * set and this is a nop.
 */
void alGenSources(ALsizei n, ALuint *buffer) {
	AL_context *cc;
	ALint sindex;
	ALuint *temp;
	int i;

	if(n == 0) {
		/* with n == 0, we NOP */
		return;
	}

	if(n < 0) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "alGenSources: illegal n value %d\n", n);

		_alDCSetError(AL_INVALID_VALUE);
		return;
	}

	temp = malloc(n * sizeof *temp);
	if(temp == NULL) {
		/*
		 * Could not reserve memory for temporary
		 * ALuint *buffer.
		 */
		_alDCSetError(AL_OUT_OF_MEMORY);
		return;
	}

	_alcDCLockContext();
 	cc = _alcDCGetContext();

	for(i = 0; i < n; i++) {
		sindex = spool_alloc(&cc->source_pool);
		if(sindex == -1) {
			/* We ran into a problem somewhere in
			 * allocing a set of source ids.  Run
			 * through the ones we did alloc, 
			 * realloc them, set error and return.
			 *
			 * FIXME: Should unlock, or have a non-locking
			 * version of alDelSources called inside
			 * the current lock?
			 */
			_alcDCUnlockContext();

			if(i > 0) {
				/*
				 *  We delete i sources, and not i + 1, because
				 *  the last alloc did not happen.  And only
				 *  if i > 0.
				 */
				alDeleteSources(i, temp);
			}

			free(temp);

			_alDCSetError(AL_OUT_OF_MEMORY);

			return;
		}

		temp[i] = sindex;
		_alInitSource(temp[i]);
	}

	_alcDCUnlockContext();

	/*
	 * temp[0...n-1] now contains the generated buffers.  Copy them
	 * to the user data.
	 */
	memcpy(buffer, temp, n * sizeof *buffer);

	free(temp);

	return;
}

void alSourcei(ALuint sid, ALenum param, ALint i1) {
	ALboolean inrange = AL_TRUE;
	AL_source *src;
	AL_sourcestate *srcstate;

	SOURCELOCK();

	src = _alDCGetSource(sid);
	if(src == NULL) {
		/*
		 * sid is invalid.
		 */
		debug(ALD_SOURCE, __FILE__, __LINE__,
			"alSourcei: source id %d is not valid", sid);
		
		_alDCSetError(AL_INVALID_NAME);
		
		SOURCEUNLOCK();
		return;
	}

	/*
	 * all calls to alSourcei specify ALboolean parameters,
	 * which means that i1 is either AL_TRUE, AL_FALSE, or
	 * not valid.  So check for validity of i1 first, and
	 * set error if that's the case.
	 */
	switch(param) {
		case AL_LOOPING:
		case AL_STREAMING:
		case AL_SOURCE_RELATIVE:
		  inrange = _alCheckRangeb(i1);
		  break;
		case AL_BUFFER:
		  inrange = alIsBuffer( i1 );

		  if( i1 == 0 ) {
		  	/*
			 * i1 == 0 has the special semantic that we
			 * unset the buffer id.
			 */
		  	inrange = AL_TRUE;
		  } 
		  break;
		default:
		  /* invalid param,  error below. */
		  break;
	}

	if(inrange == AL_FALSE) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "alSourcei(%d, 0x%x, ...) called with invalid value %d",
		      sid, param, i1);

		_alDCSetError(AL_INVALID_VALUE);
		
		SOURCEUNLOCK();
		return;
	}

	srcstate = _alSourceQueueGetCurrentState(src);
	ASSERT(srcstate);

	switch(param) {
		case AL_BUFFER:
		  if(src->state == AL_PLAYING) {
			debug(ALD_SOURCE, __FILE__, __LINE__,
				"alSourcei(%d): source is playing, AL_BUFFER invalid",
				sid);
			_alDCSetError( AL_ILLEGAL_COMMAND );
		  } else {
		  	_alSourceQueueHead( src, i1 );
		  }
		  break;
		case AL_LOOPING:
		  srcstate->islooping.isset = AL_TRUE;
		  srcstate->islooping.data  = i1;
		  break;
		case AL_SOURCE_RELATIVE:
		  src->isrelative.isset = AL_TRUE;
		  src->isrelative.data  = i1;
		  break;
		case AL_STREAMING:
		  src->isstreaming.isset = AL_TRUE;
		  src->isstreaming.data  = i1;
		  break;
		default:
		  debug(ALD_SOURCE, __FILE__, __LINE__,
			"alSourcei: invalid or stubbed source param 0x%x",
			param);
			
		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	SOURCEUNLOCK();

	return;
}

void alSourcef(ALuint sid, ALenum param, ALfloat f1) {
	AL_source *source;
	ALboolean inrange = AL_TRUE;
	AL_sourcestate *srcstate = NULL;

	SOURCELOCK();
	source = _alDCGetSource(sid);

	if(source == NULL) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
			"alSourcef: invalid source id %d", sid);

		_alDCSetError(AL_INVALID_NAME);

		SOURCEUNLOCK();

		return;
	}

	/* check to see if we are in range, first */
	switch(param) {
		case AL_MIN_GAIN:
		  inrange = _alCheckRangef(f1, 0.0, 1.0);
		  break;
		case AL_MAX_GAIN:
		  inrange = _alCheckRangef(f1, 0.0, 1.0);
		  break;
		case AL_CONE_INNER_ANGLE:
		  inrange = _alCheckRangef(f1, 0.0, 360.0);
		  break;
		case AL_CONE_OUTER_ANGLE:
		  inrange = _alCheckRangef(f1, 0.0, 360.0);
		  break;
		case AL_PITCH:
		  /* FIXME: deviates from spec */
		  inrange = _alCheckRangef(f1, 0.0, 2.0);
		  break;
		case AL_GAIN:
		  inrange = _alCheckRangef(f1, 0.0, 1.0);
		  break;
		case AL_GAIN_LINEAR:
		  inrange = _alCheckRangef(f1, 0.0, 1.0);
		  break;
		default:
		  /* invalid param. error below */
		  break;
	}

	/*
	 *  If we have a range error, exit early.
	 */
	if(inrange == AL_FALSE) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "alSourcef(%d, 0x%x,...): %f out of range",
		      sid, param, f1);

		_alDCSetError(AL_INVALID_VALUE);

		SOURCEUNLOCK();
		return;
	}

	srcstate = _alSourceQueueGetCurrentState(source);
	ASSERT(srcstate);

	/* actually set the param value */
	switch(param) {
		case AL_MIN_GAIN:
		  source->attenuationmin.isset = AL_TRUE;
		  source->attenuationmin.data  = f1;
		  break;
		case AL_MAX_GAIN:
		  source->attenuationmax.isset = AL_TRUE;
		  source->attenuationmax.data  = f1;
		  break;
		case AL_CONE_INNER_ANGLE:
		  source->coneinnerangle.isset = AL_TRUE;
		  source->coneinnerangle.data  = f1;
		  break;
		case AL_CONE_OUTER_ANGLE:
		  source->coneouterangle.isset = AL_TRUE;
		  source->coneouterangle.data  = f1;
		  break;
		case AL_PITCH:
		  /* only set pitch if it differs from 1.0 */
		  if(f1 == 1.0) {
			source->pitch.isset = AL_FALSE;
			source->pitch.data  = 1.0;

			source->flags &= ~ALS_NEEDPITCH;
		  } else {
		  	source->pitch.isset = AL_TRUE;
		  	source->pitch.data  = f1;
#ifdef FFT
			source->flags |= ALS_NEEDFFT;
#else
			/* tpitch messes with soundpos */
			source->flags |= ALS_NEEDPITCH;
#endif /* FFT */
		  }
		  break;
		case AL_GAIN:
		  source->gain.isset = AL_TRUE;
		  source->gain.data = _alDBToLinear(f1);
		  break;
		case AL_GAIN_LINEAR:
		  source->gain.isset = AL_TRUE;
		  source->gain.data = f1;
		  break;
		default:
		  debug(ALD_SOURCE, __FILE__, __LINE__,
			  "alSourcef(%d) invalid or unsupported param 0x%x",
			  sid, param);

		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	SOURCEUNLOCK();
	return;
}

void alSource3f(ALuint id, ALenum pid,
				ALfloat f1,
				ALfloat f2,
				ALfloat f3) {
	ALfloat fv[3];

	fv[0] = f1;
	fv[1] = f2;
	fv[2] = f3;

	alSourcefv(id, pid, fv);

	return;
}

void alSourcefv(ALuint id, ALenum pid, float *fv1) {
	AL_source *source;
	AL_sourcestate *srcstate;

	SOURCELOCK();
	source = _alDCGetSource(id);

	if(source == NULL) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
			"alSourcefv: %d is an invalid source id", id);

		_alDCSetError(AL_INVALID_NAME);

		SOURCEUNLOCK();
		return;
	}

	if(fv1 == NULL) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
			"alSourcefv: values NULL is not valid");

		_alDCSetError(AL_INVALID_NAME);

		SOURCEUNLOCK();
		return;
	}

	srcstate = _alSourceQueueGetCurrentState(source);

	switch(pid) {
		case AL_POSITION:
		  source->position.isset = AL_TRUE;
		  memcpy(&source->position.data, fv1, SIZEOFVECTOR);
		  break;
		case AL_DIRECTION:
		  /*
		   * The zero vector will make a directional sound
		   * non-directional.
		   */
		  if(_alIsZeroVector(fv1) == AL_TRUE) {
			  /* clear DIRECTION flag */
			  source->direction.isset = AL_FALSE;
		  } else {
			  source->direction.isset = AL_TRUE;
			  memcpy(&source->direction.data, fv1, SIZEOFVECTOR);
		  }
		  break;
		case AL_VELOCITY:
		  source->velocity.isset = AL_TRUE;
		  memcpy(&source->velocity.data, fv1, SIZEOFVECTOR);

#ifndef FFT
		  /*
		   * velocity means doppler, which means that we
		   * need pitch, which means alf_tpitch takes care of
		   * incrementing soundpos.  Very kludgey, I'll admit.
		   *
		   */
		  source->flags      |= ALS_NEEDPITCH;
		  source->pitch.isset = AL_TRUE;
#endif /* FFT */
		  break;
		default:
		  debug(ALD_SOURCE, __FILE__, __LINE__,
			  "alSourcefv(%d): param 0x%x not valid", id, pid);
		  
		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	SOURCEUNLOCK();

	return;
}

/*
 *  This returns NULL if the paramater specified by pid hasn't
 *  been set, so that the calling function can determine what it
 *  thinks a sensible default should be.  Perhaps it would be
 *  best to have a set of default variables here and return their
 *  value when need be?
 */
void *_alGetSourceParam(AL_source *als, ALenum pid) {
	AL_sourcestate *srcstate;

	srcstate = _alSourceQueueGetCurrentState(als);
	ASSERT(srcstate);

	switch(pid) {
		case AL_BUFFER:
		  if(als->bid_queue.size > 0) {
			  int index = als->bid_queue.read_index;

			  return &als->bid_queue.queue[index];
		  } else {
			  debug(ALD_SOURCE, __FILE__, __LINE__,
			  	"_alGetSourceState: bid_queue.size == %d",
				als->bid_queue.size);
		  }
		  break;
		case AL_CONE_INNER_ANGLE:
		  if(als->coneinnerangle.isset == AL_TRUE) {
		  	return &als->coneinnerangle.data;
		  }
		  break;
		case AL_CONE_OUTER_ANGLE:
		  if(als->coneouterangle.isset == AL_TRUE) {
		  	return &als->coneouterangle.data;
		  }
		  break;
		case AL_DIRECTION:
		  if(als->direction.isset == AL_TRUE) {
		  	return &als->direction.data;
		  }
		  break;
		case AL_GAIN_LINEAR:
		  if(als->gain.isset == AL_TRUE) {
		  	return &als->gain.data;
		  }
		  break;
		case AL_LOOPING:
		  /* AL_LOOPING means infinite loop */

		  return &srcstate->islooping.data;
		  break;
		case AL_PITCH:
		  if(als->pitch.isset == AL_TRUE) {
		  	return &als->pitch.data;
		  }
		  break;
		case AL_POSITION:
		  if(als->position.isset == AL_TRUE) {
			return &als->position.data;
		  }
		  break;
		case AL_SOURCE_RELATIVE:
		  if(als->isrelative.isset == AL_TRUE) {
		  	return &als->isrelative.data;
		  }
		  break;
		case AL_STREAMING:
		  if(als->isstreaming.isset == AL_TRUE) {
		  	return &als->isstreaming.data;
		  }
		  break;
		case AL_VELOCITY:
		  if(als->velocity.isset == AL_TRUE) {
		  	return &als->velocity.data;
		  }
		  break;
		case AL_MIN_GAIN:
		 if(als->attenuationmin.isset == AL_TRUE) {
		 	return &als->attenuationmin.data;
		 }
		 break;
		case AL_MAX_GAIN:
		 if(als->attenuationmax.isset == AL_TRUE) {
		 	return &als->attenuationmax.data;
		 }
		 break;
		case AL_SOURCE_STATE:
		  return &als->state;
		  break;
		default:
		  debug(ALD_SOURCE, __FILE__, __LINE__,
		  	"unknown source param 0x%x", pid);
		  break;
	}

	return NULL;
}

/*
 * _alGetSource
 *
 * Returns the address of the source sid from the 
 * context cid, or NULL if the cid or sid is 
 * invalid.
 *
 * Assumes locked context
 */
AL_source *_alGetSource(ALuint cid, ALuint sid) {
	AL_context *cc;
	
	cc  = _alcGetContext(cid);
	if(cc == NULL) {
		/*
		 * FIXME: Where, if at all, should be set the error?
		 */
		return NULL;
	}

	return spool_index(&cc->source_pool, sid);
}

/*
 * _alSplitSources is called from the ApplyFilters function, and
 * populated the passed buffers[0..nc-1] with the current fragment
 * of PCM data, ie the associated buf with the source's offset.
 *
 * assumes locked context
 *
 * FIXME: what an ugly mess
 */
void _alSplitSources(ALuint cid,
		     ALuint sourceid,
		     ALint nc, ALuint len,
		     AL_buffer *samp,
		     ALshort **buffers) {
	AL_source *src;
	AL_sourcestate *srcstate;
	ALuint i;
	char *bufptr   = NULL;
	static ALuint buflen = 0;

	src = _alGetSource(cid, sourceid);
	if(src == NULL) {
		/* bad mojo */
		return;
	}

	/*
	 * if buflen is less that the passed len, this is probably
	 * the first initialization and we need to allocate the
	 * monoptr (monoptr being that buffer where we mix this
	 * sort of thing.
	 */
	if(buflen < len) {
		buflen = len;

		stereoptr = realloc(stereoptr, buflen * 2);

		memset(stereoptr, 0, buflen * 2);
	}

	if(stereoptr == NULL) {
		/* at this point, we're dead and don't know it. */
		return;
	}

	/* Shouldn't happen. */
	if(len == 0) {
		debug(ALD_SOURCE,
			__FILE__, __LINE__,
			"wtf? size = 0!!!!!!");
		debug(ALD_SOURCE,
			__FILE__, __LINE__,
			"Expect SIGSEGV soon");
		return;
	}


	srcstate = _alSourceQueueGetCurrentState(src);

	/*
	 *  If we have a callback function, read from it.
	 */
	if(samp->flags & ALB_CALLBACK) {
		srcstate->flags |= ALQ_CALLBACKBUFFER;

		_alSplitSourceCallback(cid, sourceid, nc, len, samp, buffers);
		return;
	} else {
		/* make sure we mark this as a normal buffer */
		srcstate->flags &= ~ALQ_CALLBACKBUFFER;
	}

	/* if((len * bufchannels + src->srcParams.soundpos) > samp->size) { */
	if(_alSourceBytesLeftByChannel(src, samp) < (ALint) len) {
		if(_alSourceIsLooping(src) == AL_TRUE ) {
			/*
			 * looping sources, when they need to wrap,
			 * are handled via SplitSourceLooping.
			 */
			_alSplitSourceLooping(cid, sourceid,
		     			nc, len,
		     			samp,
		     			buffers);

			return;
		}

		if(_alSourceGetPendingBids(src) > 0) {
			/*
			 * There are more buffers in the queue, so
			 * do the wrapping.
			 */
			_alSplitSourceQueue(cid, sourceid, nc, len, samp, buffers);

			return;
		}

		len = _alSourceBytesLeftByChannel(src, samp);

		if((len <= 0) || (len > samp->size)) {
			/* really short sound */
			len = samp->size;

			return;
		}
	}
	
	for(i = 0; i < _alcGetNumSpeakers(cid); i++) {
		bufptr = _alSourceGetBufptr(src, samp, i);

		memcpy(buffers[i], bufptr, len);
	}

	return;
}

/*
 *  Special SplitSource for callback sources, which need to have their
 *  data populated not from the buffer's original data, but from the
 *  callback.
 */
static void _alSplitSourceCallback(ALuint cid,
		     ALuint sourceid,
		     ALint nc, ALuint len,
		     AL_buffer *samp,
		     ALshort **buffers) {
	AL_source *src      = NULL;
	int *bid            = NULL;
	unsigned int nsamps = 0;
	int resultsamps     = -1;
	int bufchannels     = _al_ALCHANNELS(samp->format);

	src = _alGetSource(cid, sourceid);
	if(src == NULL) {
		/*
		 * Should we really be setting the error here?
		 */
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "_alSplitSourceCallback: invalid source id %d",
		      sourceid);

		_alSetError(cid, AL_INVALID_NAME);
		return;
	}

 	bid = (int *) _alGetSourceParam(src, AL_BUFFER);
	if(bid == NULL) {
		return;
	}

	nsamps = bufchannels * len / sizeof **buffers;

	resultsamps = samp->callback(sourceid, *bid,
				     stereoptr,
				     samp->format,
				     samp->freq,
				     nsamps);

	if(resultsamps < 0) {
		/* callback problem */
		debug(ALD_STREAMING, __FILE__, __LINE__,
			"%d callback returned -1", sourceid);

		memset(stereoptr, 0, len);

		_alRemoveSourceFromMixer(sourceid);

		return;
	}

	if(resultsamps < (ALint) nsamps) {
		/* source is over */
		debug(ALD_STREAMING, __FILE__, __LINE__,
			"time for %d to die", sourceid);

		/* FIXME:
		 *
		 * offset memset at resultsamps / width to end
		 
		 memset(stereoptr, 0, len);
		 */

		/*
		 * we want this to end.  please.
		 * What a cheat.
		 */

		src->srcParams.soundpos = samp->size + nc * resultsamps * sizeof **buffers;
	}

	/* set len to the number of bytes we actually got back
	 * from the callback.
	 */
	len = resultsamps * sizeof **buffers / bufchannels;

	/*
	 * since we're decoding it, copy it to the orig_buffers so we only
	 * have to do it once.
	 */
	_alMonoify(buffers, stereoptr, len, samp->num_buffers, bufchannels);

	samp->size += nc * resultsamps * sizeof **buffers;

	return;
}

/*
 *
 * _alSplitSourceLooping is called to split a looping source that
 * has reached the loop point (ie, point where it needs to wrap around.
 *
 * This is very ugly, and needs to be cleaned up.  I'd prefer not to
 * have a special case so if you're looking to contribute, please
 * consider redoing this.
 *
 * assumes locked context
 *
 * FIXME: this is so ugly.
 */
static void _alSplitSourceLooping(ALuint cid,
		     ALuint sourceid,
		     ALint nc, ALuint len,
		     AL_buffer *samp,
		     ALshort **buffers) {
	AL_source *src;
	long mixable;
	long remaining;
	char *bufptr;
	int i;
	int bi;
	int bufchannels = _al_ALCHANNELS(samp->format);
	char *mdp;

	src = _alGetSource(cid, sourceid);
	if(src == NULL) {
		/*
		 * Should we really be setting the error here?
		 */
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "_alSplitSourceLooping: invalid source id %d",
		      sourceid);

		_alSetError(cid, AL_INVALID_NAME);
		return;
	}

	mixable    = _alSourceBytesLeftByChannel(src, samp);
	remaining  = 0;

	ASSERT(mixable >= 0);

	/* in case samp->size < len, we don't want
	 * to overwrite with the memcpy
	 */
	if(len * bufchannels <= samp->size) {
		/* normal case */
		remaining = (len * bufchannels) - mixable;

		for(i = 0; i < nc; i++) {
			bufptr = _alSourceGetBufptr(src, samp, i);

			memcpy(buffers[i], bufptr, mixable);
			memcpy(buffers[i] + mixable/2, samp->orig_buffers[i],
				remaining);
		}

		return;
	} else {
		/* really small looping sample */
		if(mixable < 0) {
			/* we loop sound in monoptr */
			mixable = src->srcParams.soundpos % len;
		}

		for(bi = 0; bi < nc; bi++) {
			mdp = (char *) buffers[bi];

			/* copy samp again and again */
			for(i = mixable; i < (signed int) len; i += samp->size) {
				int copylen;
				
				if(i + samp->size < len) {
					copylen = samp->size;
				} else {
					copylen = len - i;
				}

				memcpy(&mdp[i],	samp->orig_buffers[bi], copylen);
			}

			for(i = 0; i < mixable; i += samp->size) {
				int copylen;
				
				if(i + samp->size < (unsigned int) mixable) {
					copylen = samp->size;
				} else {
					copylen = mixable - i;
				}

				memcpy(&mdp[i],
					samp->orig_buffers[bi],
					copylen);
			}
		}

		return;

		debug(ALD_LOOP, __FILE__, __LINE__, "handle size");
	}

	for(i = 0; i < nc; i++) {
		bufptr = _alSourceGetBufptr(src, samp, i);

		memcpy(buffers[i], bufptr, len);
	}

	return;
}

/*
 *
 * _alSplitSourceQueue is called to ease the transition between
 * buffers in a source's queue.
 *
 * This is very ugly, and needs to be cleaned up.  I'd prefer not to
 * have a special case so if you're looking to contribute, please
 * consider redoing this.
 *
 * assumes locked context
 *
 * FIXME: this is so ugly.
 */
static void _alSplitSourceQueue(ALuint cid,
				ALuint sourceid,
				ALint nc, ALuint len,
				AL_buffer *samp,
				ALshort **buffers) {
	AL_source *src;
	long mixable;
	long remaining;
	char *bufptr;
	int i;
	int bufchannels = _al_ALCHANNELS(samp->format);
	ALuint nextbid;
	AL_buffer *nextsamp;
	void *nextpcm;

	debug(ALD_QUEUE, __FILE__, __LINE__, "_alSplitSourceQueue: foo");
		     
	src = _alGetSource(cid, sourceid);
	if(src == NULL) {
		/*
		 * Should we really be setting the error here?
		 */
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "_alSplitSourceQueue: invalid source id %d",
		      sourceid);

		_alSetError(cid, AL_INVALID_NAME);
		return;
	}

	nextbid = src->bid_queue.queue[src->bid_queue.read_index + 1];

	nextsamp = _alGetBuffer(nextbid);
	if(nextsamp == NULL) {
		/*
		 * Should we really be setting the error here?
		 */
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "_alSplitSourceQueue: shouldn't happen");
		return;
	}

	mixable    = _alSourceBytesLeftByChannel(src, samp);
	remaining  = 0;

	/* in case samp->size < len, we don't want
	 * to overwrite with the memcpy
	 */
	if(len * bufchannels <= samp->size) {
		/* normal case */
		remaining = (len * bufchannels) - mixable;

		for(i = 0; i < nc; i++) {
			bufptr = _alSourceGetBufptr(src, samp, i);
			nextpcm = nextsamp->orig_buffers[i];

			memcpy(buffers[i], bufptr, mixable);
			memcpy(buffers[i] + mixable/2, nextpcm, remaining);
		}

		return;
	}

	for(i = 0; i < nc; i++) {
		bufptr = _alSourceGetBufptr(src, samp, i);

		memcpy(buffers[i], bufptr, len);
	}

	return;
}

/*
 * _alMonoifyOffset
 *
 * assumes locked context
 */
void _alMonoifyOffset(ALshort **dstref, ALuint offset,
		      ALvoid *srcp, ALuint size, ALuint dc, ALuint sc) {
	switch(dc) {
		case 2:
		  switch(sc) {
			  case 1:
				_alMonoifyOffset1to2(dstref, offset, srcp, size);
				break;
			  case 2:
				_alMonoifyOffset2to2(dstref, offset, srcp, size);
				break;
			  default:
			  	fprintf(stderr, "unhandled Monoify (dc %d sc %d)\n",
					dc, sc);
				break;
		  }
		  break;
		case 1:
		  switch(sc) {
			  case 1:
		    		memcpy((char *) *dstref + offset, srcp, size);
				break;
			  default:
			  	fprintf(stderr, "unhandled Monoify (dc %d sc %d)\n",
					dc, sc);
			  	break;
		  }
		  break;
		default:
		  debug(ALD_SOURCE, __FILE__, __LINE__,
			"Unhandled dc %d", dc);
		  break;
	}

	return;
}

/*
 * convert from mono to 2 channels of buffer data.
 */
static void _alMonoifyOffset1to2(ALshort **dsts, ALuint offset, void *srcp, ALuint size) {
	ALshort *src = (ALshort *) srcp;
	ALshort *dst0 = dsts[0];
	ALshort *dst1 = dsts[1];
	int len      = size / sizeof *src;
        int i;

	offset /= sizeof **dsts;
	dst0 += offset;
	dst1 += offset;

	for(i = 0; i < len; i++) {
		dst0[i] = src[0];
		dst1[i] = src[0];

		src++;
	}

        return;
}

/*
 * convert from stereo to 2 channels of buffer data.
 */
static void _alMonoifyOffset2to2(ALshort **dsts, ALuint offset, void *srcp, ALuint size) {
	ALshort *src = (ALshort *) srcp;
	ALshort *dst0 = dsts[0];
	ALshort *dst1 = dsts[1];
	int len      = size / sizeof *src;
        int i;

	offset /= sizeof **dsts;

	dst0 += offset;
	dst1 += offset;

	for(i = 0; i < len; i++) {
		dst0[i] = src[0];
		dst1[i] = src[1];

		src += 2;
	}

        return;
}

/*
 *  FIXME: handle cases with > 2 channels
 */
void _alChannelifyOffset(ALshort *dst, ALuint offset, ALshort **srcs, ALuint size, ALuint nc){
	switch(nc) {
		case 2:
		  _alChannelify1to2Offset(dst, offset, srcs, size);
		  break;
		case 1:
		  memcpy((char *) dst, srcs[0] + offset/sizeof *srcs, size);
		  break;
		default:
		  break;
	}

	return;
}

/*
 * _alChannelify takes a series of 16 bit mono buffers (srcs) and 
 * interleaves them into a destination buffer.
 *
 * assumes locked context
 */
void _alChannelify1to2Offset(ALshort *dst, ALuint offset, ALshort **srcs, ALuint size) {
	ALuint k;

	size /= sizeof *dst; /* we need sample offsets */
	offset /= sizeof *srcs; /* we need sample offsets */

	for(k = 0; k < size; k++) {
		dst[0] = srcs[0][k + offset];
		dst[1] = srcs[1][k + offset];

		dst += 2;
	}

	return;
}

/*
 * alDeleteSources
 *
 * Delete n sources, with sids located in sources[0..n-1].  Only full
 * deallocations are possible, and if one of sources[0..n-1] is not a
 * valid source id (or is currently in an active state), and error is
 * set and no deallocation occurs.
 *
 * If n is 0, this is a legal nop.  If n < 0, INVALID_VALUE is set
 * and this is a nop.
 */
void alDeleteSources( ALsizei n, ALuint *sources ) {
	AL_source *src;
	AL_context *cc;
	int i;

	if(n == 0) {
		/* silently return */
		return;
	}

	if(n < 0) {
		debug(ALD_BUFFER, __FILE__, __LINE__,
		      "alDeleteSources: invalid n %d\n", n);

		_alDCSetError(AL_INVALID_VALUE);
		return;
	}

	_alcDCLockContext();

	cc = _alcDCGetContext();
        if(cc == NULL) {
		/*
		 * No current context with which to evaluate the 
		 * validity of the sources
		 */
		_alcDCUnlockContext();
		return;
	}

	if(n < 0) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "alDeleteSources: illegal n value %d", n);

		_alDCSetError(AL_INVALID_VALUE);
		_alcDCUnlockContext();
		return;
	}

	for(i = 0; i < n; i++) {
		src = _alDCGetSource(sources[i]);
		if(src == NULL) {
			/* invalid source id, return. */
			debug(ALD_SOURCE, __FILE__, __LINE__,
			      "alDeleteSources: invalid source %d",
			      sources[i]);

			_alDCSetError(AL_INVALID_NAME);
			_alcDCUnlockContext();

			return;
		}

		if(src->state == AL_PLAYING) {
			/* 
			 * FIXME: illegal to delete playing source?
			 */
			debug(ALD_SOURCE, __FILE__, __LINE__,
			      "alDeleteSources: tried to del playing source %d",
			      sources[i]);

			_alDCSetError(AL_ILLEGAL_COMMAND);
			_alcDCUnlockContext();
			return;
		}

	}

	for(i = 0; i < n; i++) {
		src = _alDCGetSource(sources[i]);
		if(src == NULL) {
			debug(ALD_SOURCE, __FILE__, __LINE__,
			      "alDeleteSources: invalid source %d",
			      sources[i]);

			_alDCSetError(AL_INVALID_NAME);
			continue;
		}

		if(src->state == AL_PLAYING) {
			/* 
			 * FIXME: illegal to delete playing source?
			 */
			debug(ALD_SOURCE, __FILE__, __LINE__,
			      "alDeleteSources: tried to del playing source %d",
			      sources[i]);

			_alDCSetError(AL_ILLEGAL_COMMAND);
			continue;
		}

		spool_dealloc(&cc->source_pool, sources[i],
						_alDestroySource);
	}

	_alcDCUnlockContext();
	return;
}

/*
 * _alDestroySources
 *
 * This destructor is responsible for deallocating source data structures
 * after openal has finished.
 */
void _alDestroySources(spool_t *spool) {
	spool_free(spool, _alDestroySource);

	if(stereoptr != NULL) {
		free(stereoptr);
		stereoptr = NULL;
	}

	return;
}

/*
 * _alDestroySource
 *
 * Deallocates the memory associated with an AL_source, passed as a void *
 * to this function.
 *
 * assumes locked context
 */
void _alDestroySource(void *srcp) {
	AL_source *src = (AL_source *) srcp;
	ALuint *bidp;
	int i;

	/*
	 * if we have a callback buffer, call the
	 * destructor with the "free one source" args
	 */
	bidp = _alGetSourceParam(src, AL_BUFFER);
	if(bidp != NULL) {
		if(_alBidIsCallback(*bidp) == AL_TRUE) {
			_alBidCallDestroyCallbackSource(src->sid);
		}
	}

	/* deallocation per source scratch space */
	free(src->srcParams.outbuf);
	src->srcParams.outbuf = NULL;

	for(i = _alcDCGetNumSpeakers() - 1; i >= 0; i--) {
		/* deallocation reverb scratch space */
		if(src->reverb_buf[i] != NULL) {
			free(src->reverb_buf[i]);
			src->reverb_buf[i] = NULL;
		}
	}

	free(src->bid_queue.queuestate);
	free(src->bid_queue.queue);

	src->bid_queue.queue = NULL;
	src->bid_queue.queuestate = NULL;
	src->bid_queue.size = 0;

	return;
}

void _alSidRewind(ALuint cid, ALuint sid, ALuint sindex) {
	AL_source *src = _alGetSource(cid, sid);
	
	if(src != NULL) {
		src->srcParams.soundpos = sindex;
	}

	return;
}

void alSourcePause( ALuint sid ) {
	AL_source *src;

	SOURCELOCK();

	src = _alDCGetSource(sid);
	if(src == NULL) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "alSourcePause: source id %d is invalid",
		      sid);

		_alDCSetError(AL_INVALID_NAME);

		SOURCEUNLOCK();
		return;
	}

	_alLockMixBuf();

	/*
	 * If source is active, set it to be paused.  Otherwise,
	 * it's a legal NOP.
	 */
	if(src->state == AL_PLAYING) {
		src->state = AL_PAUSED;
	}

	_alUnlockMixBuf();

	SOURCEUNLOCK();

	return;
}


void alSourcePlay(ALuint sid) {
	SOURCELOCK();

	if(alIsSource(sid) == AL_FALSE) {
		debug(ALD_SOURCE,
			__FILE__, __LINE__,
			"alSourcePlay: invalid source id %d", sid);

		_alDCSetError(AL_INVALID_NAME);

		SOURCEUNLOCK();
		return;
	}

	_alLockMixBuf();
	_alAddSourceToMixer(sid);
	_alUnlockMixBuf();

	SOURCEUNLOCK();

	return;
}

void alSourceStop(ALuint sid) {
	SOURCELOCK();

	if(alIsSource(sid) == AL_FALSE) {
		debug(ALD_SOURCE,
			__FILE__, __LINE__,
			"alSourceStop: invalid source id %d", sid);

		_alDCSetError(AL_INVALID_NAME);

		SOURCEUNLOCK();
		return;
	}

	_alLockMixBuf();
	_alRemoveSourceFromMixer(sid);
	_alUnlockMixBuf();

	SOURCEUNLOCK();
	return;
}

void alSourceStopv(ALuint numsources, ALuint *sids) {
	int i;

	if(numsources == 0) {
		return;
	}

	_alLockMixBuf();

	for(i = 0; i < (int) numsources; i++) {
		_alRemoveSourceFromMixer(sids[i]);
	}

	_alUnlockMixBuf();

	return;
}

void alSourcePlayv(ALuint numsources, ALuint *sids) {
	int i;

	if(numsources == 0) {
		/* set error? */
		return;
	}

	SOURCELOCK();
	_alLockMixBuf();

	for(i = 0; i < (int) numsources; i++) {
		_alAddSourceToMixer(sids[i]);
	}

	_alUnlockMixBuf();
	SOURCEUNLOCK();

	return;
}

/*
 * assumes locked context
 *
 * FIXME: should return something.
 */
void _alCollapseSource(ALuint cid, ALuint sid,
		       ALuint nc, ALuint mixbuflen,
		       ALshort **buffers) {
	AL_source *src;
	AL_buffer *smp;
	unsigned int len;
	ALuint bufchannels;

	len = mixbuflen / sizeof **buffers;

	src = _alGetSource(cid, sid);
	if(src == NULL) {
		_alSetError(cid, AL_INVALID_NAME);
		return;
	}

	smp = _alGetBufferFromSid(cid, sid);
	if(smp == NULL) {
		_alSetError(cid, AL_INVALID_NAME);
		return;
	}

	bufchannels = _al_ALCHANNELS(smp->format);

	if(src->srcParams.outbuf == NULL) {
		src->srcParams.outbuf = malloc(mixbuflen);
		if(src->srcParams.outbuf == NULL) {
			_alSetError(cid, AL_OUT_OF_MEMORY);
			return;
		}
	}

	memset(src->srcParams.outbuf, 0, mixbuflen);

	if(len > bufchannels * (smp->size - src->srcParams.soundpos)) {
		/* kludge.  dc->silence? */
		memset(src->srcParams.outbuf, 0, mixbuflen);

		if( _alSourceIsLooping(src) == AL_FALSE ) {
			/*
			 * Non looping source get f_buffer truncated because
			 * they don't (potentially) posses enough data.
			 */
			len = bufchannels * (smp->size - src->srcParams.soundpos);
		}
	}

	_alChannelify(src->srcParams.outbuf, buffers, len, nc);

	return;
}

/** Get an integer parameter for a Source object.
 */
void alGetSourcei(ALuint sid, ALenum pname, ALint *retref) {
	AL_source *src;
	AL_sourcestate *srcstate;
	ALint *temp;

	SOURCELOCK();
	src = _alDCGetSource(sid);

	if(src == NULL) {
		/*
		 * Invalid source id
		 */
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "alGetSourcei: invalid source id %d",
		      sid);

		_alDCSetError(AL_INVALID_NAME);

		SOURCEUNLOCK();
		return;
	}

	if(retref == NULL) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "alGetSourcei(%d): NULL value",
		      sid);

		_alDCSetError(AL_INVALID_VALUE);

		SOURCEUNLOCK();
		return;
	}

	/*
	 * get param value, and store it in temp.  We need it
	 * more most, but not all, of the following params enums.
	 */
	temp = _alGetSourceParam(src, pname);
	if(temp != NULL) {
		/* If temp is not NULL, then there is a value set,
		 * and we don't have to slog through the defaults
		 * below.
		 */
		*retref = *temp;

		SOURCEUNLOCK();

		return;
	}

	srcstate = _alSourceQueueGetCurrentState(src);
	ASSERT(srcstate);

	switch(pname) {
		case AL_BUFFERS_QUEUED:
		  /* AL_BUFFERS_QUEUED is not setable, and has no default. */
		  *retref = src->bid_queue.size - src->bid_queue.read_index;
		  break;
		case AL_BUFFERS_USED:
		  /* AL_BUFFERS_USED is not setable, and has no default. */
		  *retref = src->bid_queue.read_index - 1;
		  break;
		case AL_BYTE_LOKI:
		  /* AL_BYTE_LOKI is not setable, and has no default. */
		  switch(src->state) {
			  case AL_PLAYING:
			  case AL_PAUSED:
			    *retref = src->srcParams.soundpos;
			    break;
			  default:
			    *retref = -1;
			    break;
		  }
		  break;
		case AL_SOURCE_LOOPING:
		  /* AL_SOURCE_LOOPING default is AL_FALSE. */

		  *retref = AL_FALSE;
		  break;
		case AL_STREAMING:
		  *retref = AL_FALSE;
		  break;
		case AL_SOURCE_RELATIVE:
		  /* AL_SOURCE_RELATIVE default is AL_FALSE. */
		  
		  *retref = AL_FALSE;
		  break;
		case AL_SOURCE_STATE:
		  *retref = src->state;
		  break;

		case AL_BUFFER: /* no default */
		default:
		  debug(ALD_SOURCE, __FILE__, __LINE__,
		        "alGetSourcei: invalid or unsupported param 0x%x",
			pname);

		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	SOURCEUNLOCK();
	return;
}

/*
 * FIXME: parts are unimplemented
 */
void alGetSourcef(ALuint sid,  ALenum pname, ALfloat *retref) {
	AL_source *src;
	ALfloat *srcval;

	SOURCELOCK();
	src = _alDCGetSource(sid);

	if(src == NULL) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
			"alGetSourcef: invalid source id %d",
			sid);
		
		_alDCSetError(AL_INVALID_NAME);

		SOURCEUNLOCK();
		return;
	}

	if(retref == NULL) {
       		debug(ALD_SOURCE, __FILE__, __LINE__,
			"alGetSourcef(%d): values is NULL");

		_alDCSetError(AL_INVALID_VALUE);
		SOURCEUNLOCK();
		return;
	}

	/* get param */
	srcval = _alGetSourceParam(src, pname);
	if(srcval != NULL) {
		/*
		 * If srcval is not NULL, the param in question has
		 * been explicitly set, which means that we don't need to
		 * set it to defaults below.
		 */
		*retref = *srcval;
		SOURCEUNLOCK();
		return;
	}

	/*
	 * the paramater is not set, so return default
	 */
	switch(pname) {
		case AL_GAIN:
		  /* AL_GAIN reflects the dB of AL_GAIN_LINEAR, so
		   * we compute this from AL_GAIN_LINEAR.
		   */
		  srcval = _alGetSourceParam(src, AL_GAIN_LINEAR);
		  if(srcval != NULL) {
			/*
			 * If srcval is not NULL, the param in question has
			 * been explicitly set, which means that we don't
			 * need to set it to defaults below.
			 */
			*retref = _alLinearToDB(*srcval);

			SOURCEUNLOCK();
			return;
		  }

		  /* AL_GAIN_LINEAR was not set, so we set default */

		  *retref = 1.0;
		  break;
		case AL_GAIN_LINEAR:
		  *retref = 1.0;
		  break;
		case AL_CONE_INNER_ANGLE:
		  *retref = 360.0;
		  break;
		case AL_CONE_OUTER_ANGLE:
		  *retref = 360.0;
		  break;
		case AL_PITCH:
		 *retref = 1.0;
		 break;
		default:
		  debug(ALD_SOURCE, __FILE__, __LINE__,
			  "alGetSourcef: illegal param 0x%x",
			  pname);

		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	SOURCEUNLOCK();

	return;
}

/*
 * FIXME: mostly unimplemented
 */
void alGetSourcefv(ALuint sid, ALenum pname, ALfloat *values) {
	AL_source *src;
	ALfloat *srcvals;
	ALfloat zeros[] = { 0.0, 0.0, 0.0 };

	SOURCELOCK();
	src = _alDCGetSource(sid);

	if(src == NULL) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
			"alGetSourcefv: source id %d is invalid", sid);
		
		_alDCSetError(AL_INVALID_NAME);

		SOURCEUNLOCK();
		return;
	}

	if(values == NULL) {

		debug(ALD_SOURCE, __FILE__, __LINE__,
			"alGetSourcefv: values passed is NULL", values);
		
		_alDCSetError(AL_INVALID_VALUE)

		SOURCEUNLOCK();
		return;
	}

	srcvals = _alGetSourceParam(src, pname);
	if(srcvals != NULL) {
		memcpy(values, srcvals, SIZEOFVECTOR);

		SOURCEUNLOCK();
		return;
	}

	/* If we are at this point, srcvals is NULL, which means
	 * that either pname is an invalid param, or that the value
	 * is not set.  Check for a valid param, in which case we
	 * set the default, or set error.
	 */
	switch(pname) {
		case AL_VELOCITY:
		  /*
		   * Default velocity: 0.0, 0.0, 0.0
		   */
		  memcpy(values, zeros, SIZEOFVECTOR);
		  break;
		case AL_POSITION:
		  /*
		   * Default position: 0.0, 0.0, 0.0
		   */
		  memcpy(values, zeros, SIZEOFVECTOR);
		  break;
		case AL_DIRECTION:
		  /*
		   * Default direction: 0.0, 0.0, 0.0 ?
		   */
		  memcpy(values, zeros, SIZEOFVECTOR);
		  break;
		default:
		  debug(ALD_SOURCE, __FILE__, __LINE__,
			"alGetSourcefv: param 0x%x either invalid or unset",
			pname);
		  break;
	}

	_alDCSetError(AL_ILLEGAL_ENUM);
	SOURCEUNLOCK();

	return;
}

/*
 *  Initialized source to defaults.
 *
 *  FIXME: cache this first time, and reuse values?
 */
static void _alInitSource(ALuint sid) {
	AL_source *src;
	AL_sourcestate *srcstate;
	ALboolean err;
	ALboolean tempbool;
	ALfloat tempfv[6];
	ALfloat tempf1;
	int i;
	
	src = _alDCGetSource(sid);
	if(src == NULL) {
		/* sid is invalid */
		return;
	}

	/* set state */
	src->state = AL_INITIAL;

	/* set identifier */
	src->sid = sid;

	/* set data values */
	src->srcParams.outbuf   = NULL;
	src->srcParams.soundpos = 0;
	src->flags              = ALS_NONE;
	src->reverbpos          = 0;

	for(i = 0; i < _ALC_MAX_CHANNELS; i++) {
		src->reverb_buf[i] = NULL;
	}

	/* Initialize the buffer queue */
	_alSourceQueueInit(src);

	srcstate = _alSourceQueueGetCurrentState(src);
	ASSERT(srcstate);

	_alSourceStateInit(srcstate);

	/*
	 * if there is a setting for source position, use it.  Otherwise,
	 * set to all 0s
	 */
	err = _alGetGlobalVector("source-position", ALRC_FLOAT, 3, tempfv);
	if(err == AL_FALSE) {
		/* no preset position */
		for(i = 0; i < 3; i++) {
			src->position.data[i] = 0;
		}
		src->position.isset = AL_FALSE;
	} else {
		memcpy(src->position.data, tempfv, SIZEOFVECTOR);
		src->position.isset = AL_TRUE;
	}

	/*
	 * if there is a setting for source direction, use it.  Otherwise,
	 * set to all 0s
	 */
	err = _alGetGlobalVector("source-direction", ALRC_FLOAT, 3, tempfv);
	if(err == AL_FALSE) {
		/* no preset position */
		for(i = 0; i < 3; i++) {
			src->direction.data[i] = 0;
		}
		src->direction.isset = AL_FALSE;
	} else {
		memcpy(src->direction.data, tempfv, SIZEOFVECTOR);
		src->direction.isset = AL_TRUE;
	}

	/*
	 * if there is a setting for source velocity, use it.  Otherwise,
	 * set to all 0s
	 */
	err = _alGetGlobalVector("source-velocity", ALRC_FLOAT, 3, tempfv);
	if(err == AL_FALSE) {
		/* no preset position */
		for(i = 0; i < 3; i++) {
			src->velocity.data[i] = 0;
		}
		src->velocity.isset = AL_FALSE;
	} else {
		memcpy(src->velocity.data, tempfv, SIZEOFVECTOR);
		src->velocity.isset = AL_TRUE;
	}

	/*
	 * if there is a setting for source reverb scale, use it.  Otherwise,
	 * set to all 0s
	 *
	 * reverb scale is a kludge, so it's not a param, so we don't
	 * test to see whether it's been set or not.  This will change.
	 */
	err = _alGetGlobalScalar("source-reverb-scale", ALRC_FLOAT, tempfv);
	if(err == AL_FALSE) {
		/* no preset reverb scale */
		src->reverb_scale = 0.25;
	} else {
		memcpy(&src->reverb_scale, tempfv, sizeof *tempfv);
	}

	/*
	 * if there is a setting for source reverb delay, use it.  Otherwise,
	 * set to all 0s
	 *
	 * reverb delay is a kludge, so it's not a param, so we don't
	 * test to see whether it's been set or not.  This will change.
	 */
	err = _alGetGlobalScalar("source-reverb-delay", ALRC_FLOAT, tempfv);
	if(err == AL_FALSE) {
		/* no preset reverb scale */
		src->reverb_delay = 0.00;
	} else {
		memcpy(&src->reverb_delay, tempfv, sizeof *tempfv);
	}

	/*
	 * if there is a setting for source gain, use it.  Otherwise,
	 * set to all 0s
	 */
	err = _alGetGlobalScalar("source-gain", ALRC_FLOAT, tempfv);
	if(err == AL_FALSE) {
		/* no preset pitch */
		src->gain.data = 1.0;
		src->gain.isset = AL_FALSE;
	} else {
		memcpy(&src->gain.data, tempfv, sizeof *tempfv);
		src->gain.isset = AL_TRUE;
	}

	/*
	 * if there is a setting for source cone innerangle, use it.
	 * Otherwise, set to defaults.
	 */
	err = _alGetGlobalScalar("source-cone-angle-inner", ALRC_FLOAT,tempfv);
	if(err == AL_FALSE) {
		/* no preset pitch */
		src->coneinnerangle.data = 2 * M_PI;
		src->coneinnerangle.isset = AL_FALSE;
	} else {
		memcpy(&src->coneinnerangle.data, tempfv, sizeof *tempfv);
		src->coneinnerangle.isset = AL_TRUE;
	}

	/*
	 * if there is a setting for source cone outerangle, use it.
	 * Otherwise, set to defaults.
	 */
	err = _alGetGlobalScalar("source-cone-angle-outer", ALRC_FLOAT,tempfv);
	if(err == AL_FALSE) {
		/* no preset pitch */
		src->coneouterangle.data = 2 * M_PI;
		src->coneouterangle.isset = AL_FALSE;
	} else {
		memcpy(&src->coneouterangle.data, tempfv, sizeof *tempfv);
		src->coneouterangle.isset = AL_TRUE;
	}

	/*
	 * if there is a setting for isambient, use it.
	 * Otherwise, set to defaults.
	 */
	err = _alGetGlobalScalar("source-streaming", ALRC_BOOL, &tempbool);
	if(err == AL_FALSE) {
		/* no preset streaming */
		src->isstreaming.data   = AL_FALSE;
		src->isstreaming.isset   = AL_FALSE;
	} else {
		memcpy(&src->isstreaming.data, &tempbool, sizeof tempbool);
		src->isstreaming.isset   = AL_TRUE;
	}
 
	/*
	 * if there is a setting for isrelative, use it.
	 * Otherwise, set to defaults.
	 */
	err = _alGetGlobalScalar("source-relative", ALRC_BOOL, &tempbool);
	if(err == AL_FALSE) {
		/* relative positioning not set*/
		src->isrelative.data   = AL_FALSE;
		src->isrelative.isset  = AL_FALSE;
	} else {
		memcpy(&src->isrelative.data, &tempbool, sizeof tempbool);
		src->isrelative.isset   = AL_TRUE;
	}

	/*
	 * if there is a setting for minattenuation, use it.
	 * Otherwise, ignore.
	 */
	err = _alGetGlobalScalar("source-attenuation-min", ALRC_BOOL, &tempf1);
	if(err == AL_FALSE) {
		/* min not set */
		src->attenuationmin.data   = 0.0;
		src->attenuationmin.isset  = AL_FALSE;
	} else {
		memcpy(&src->attenuationmin.data, &tempf1, sizeof tempf1);
		src->attenuationmin.isset   = AL_TRUE;
	}

	/*
	 * if there is a setting for maxattenuation, use it.
	 * Otherwise, ignore.
	 */
	err = _alGetGlobalScalar("source-attenuation-max", ALRC_BOOL, &tempf1);
	if(err == AL_FALSE) {
		/* max not set*/
		src->attenuationmax.data   = 0.0;
		src->attenuationmax.isset  = AL_FALSE;
	} else {
		memcpy(&src->attenuationmax.data, &tempf1, sizeof tempf1);
		src->attenuationmax.isset   = AL_TRUE;
	}

	/*
	 * if there is a setting for source pitch, use it.  Otherwise,
	 * set to all 0s
	 */
	err = _alGetGlobalScalar("source-pitch", ALRC_FLOAT, tempfv);
	if(err == AL_FALSE) {
		/* no preset pitch */
		src->pitch.data = 1.0;
		src->pitch.isset = AL_FALSE;
	} else {
		memcpy(&src->pitch.data, tempfv, sizeof *tempfv);
		src->pitch.isset = AL_TRUE;
	}

	return;
}

/* assumes locked context */
void _alSourceTranslate(AL_source *src, ALfloat *delta) {
	ALfloat *opos; /* original source position */

	opos = _alGetSourceParam(src, AL_POSITION);
	if(opos == NULL) {
		/* no translation possible or needed */
		return;
	}

	vector_translate(opos, opos, delta);

	return;
}

/*
 * resets srcParam settings
 * assumes locked context
 */
void _alSourceParamReset(AL_source *src) {
	AL_listener *lis;
	int i;

	lis = _alcDCGetListener();

	if(src == NULL) {
		return;
	}

	for(i = 0; i < _ALC_MAX_CHANNELS; i++) {
		src->srcParams.delay[i] = 0;
		src->srcParams.gain[i]  = 1.0;
	}

	return;
}

/*
 * _alSourceParamApply
 *
 * applies srcParam settings
 * assumes locked context
 *
 * This function should be called before a source is collapsed, in
 * ApplyFilters.
 *
 * FIXME: ignores delay
 */
void _alSourceParamApply(AL_source *src,
			ALuint nc, ALuint len, ALshort **buffers) {
	ALuint sampLen;
	ALuint i;
	ALfloat gain;
 
	sampLen = len / sizeof(ALshort); /* we pass sample length */

	for(i = 0; i < nc; i++) {
		gain = src->srcParams.gain[i];

		if(gain == 1.0) {
			/* don't floatmul when gain is 1.0 */
			continue;
		}

		float_mul(buffers[i], gain, sampLen, canon_min, canon_max);
	}

	return;
}

/*
 * _alSourceShouldIncrement
 *
 * assumes locked context
 */
ALboolean _alSourceShouldIncrement(AL_source *src) {
	AL_sourcestate *srcstate;

	srcstate =_alSourceQueueGetCurrentState(src);
	ASSERT(srcstate);

#if 0
	/* If this is a pitched source or uses a callback
	 * buffer, then it shouldn't be incremented.
	 */
	if(srcstate->flags & ALQ_CALLBACKBUFFER) {
		return AL_FALSE;
	}
#endif

	if(src->flags & ALS_NEEDPITCH) {
		return AL_FALSE;
	}

	return AL_TRUE;
}

void _alSourceStateInit(AL_sourcestate *srcstate) {
	ALboolean tempbool;
	ALboolean err;

	srcstate->flags = ALQ_NONE;

	/*
	 * if there is a setting for islooping, use it.
	 * Otherwise, set to defaults.
	 */
	err = _alGetGlobalScalar("source-looping", ALRC_BOOL, &tempbool);
	if(err == AL_FALSE) {
		/* no preset looping */
		srcstate->islooping.data   = AL_FALSE;
		srcstate->islooping.isset  = AL_FALSE;
	} else {
		srcstate->islooping.data  = tempbool;
		srcstate->islooping.isset = AL_TRUE;
	}

	return;
}

ALint _alSourceGetPendingBids(AL_source *src) {
	ALint retval =  (src->bid_queue.size - 1) - src->bid_queue.read_index;

	return retval;
}

void _alSourceIncrement(AL_source *src, ALuint bytes) {
	src->srcParams.soundpos += bytes;

	return;
}

/*
 * _alSourceGetBufptr
 *
 * assumes locked context
 */
void *_alSourceGetBufptr(AL_source *src, AL_buffer *buf, ALuint index) {
	ALbyte *retval;
	ALuint pos = src->srcParams.soundpos;

	retval = buf->orig_buffers[index];

	return retval + pos;
}

ALint _alSourceBytesLeft(AL_source *src, AL_buffer *samp) {
	ALuint nc = samp->num_buffers;

	return nc * _alSourceBytesLeftByChannel(src, samp);
}

ALint _alSourceBytesLeftByChannel(AL_source *src, AL_buffer *samp) {
	return samp->size - src->srcParams.soundpos;
}

ALboolean _alSourceIsLooping( AL_source *src ) {
	ALboolean *boo = _alGetSourceParam( src, AL_LOOPING );

	if( boo == NULL ) {
		return AL_FALSE;
	}

	return *boo;
}

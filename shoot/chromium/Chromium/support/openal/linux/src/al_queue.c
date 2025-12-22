/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_queue.c
 *
 * Stuff related to the management and use of buffer queue.
 *
 * FIXME: clean this mess up
 */
#include <AL/al.h>

#include "al_buffer.h"
#include "al_debug.h"
#include "al_error.h"
#include "al_main.h"
#include "al_source.h"
#include "al_queue.h"
#include "al_types.h"
#include "al_siteconfig.h"

#include "alc/alc_context.h"
#include "al_siteconfig.h"

#include <stdlib.h>

void alQueuei(ALuint sid, ALenum param, ALint i1) {
	AL_source *src;
	ALboolean inrange = AL_FALSE;

	SOURCELOCK();
	src = _alDCGetSource(sid);
	if(src == NULL) {
		_alDCSetError(AL_INVALID_NAME);
		SOURCEUNLOCK();

		return;
	}

	/*
	 * all calls to alQueuei specify either ALboolean parameters,
	 * which means that i1 is either AL_TRUE, AL_FALSE, or
	 * a buffer id.  So check for validity of i1 first, and
	 * set error if that's the case.
	 */
	switch(param) {
		case AL_LOOPING:
		case AL_SOURCE_RELATIVE:
		  inrange = _alCheckRangeb(i1);
		  break;
		case AL_BUFFER:
		  inrange = alIsBuffer(i1);
		  break;
		default:
		  /* invalid param,  error below. */
		  break;
	}

	if(inrange == AL_FALSE) {
		debug(ALD_SOURCE, __FILE__, __LINE__,
		      "alQueuei(%d, 0x%x, ...) called with invalid value %d",
		      sid, param, i1);

		_alDCSetError(AL_INVALID_VALUE);
		
		SOURCEUNLOCK();
		return;
	}

	switch(param) {
		/* FIXME: add loop count */
		case AL_BUFFER:
		  /* Append bid to end */
		  _alSourceQueueAppend(src, i1);
		  break;
		default:
		  debug(ALD_SOURCE, __FILE__, __LINE__,
			"alQueuei: invalid or stubbed source param 0x%x",
			param);
			
		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	SOURCEUNLOCK();

	return;
}

AL_sourcestate *_alSourceQueueGetCurrentState(AL_source *src) {
	int index = src->bid_queue.read_index;

	return &src->bid_queue.queuestate[index];
}

/*
 * _alSourceQueueInit
 *
 * assumes locked context
 */
void _alSourceQueueInit(AL_source *src) {
	src->bid_queue.queue       = NULL;
	src->bid_queue.queuestate  = NULL;
	src->bid_queue.size        = 0;

	_alSourceQueueClear(src);

	return;
}

/*
 * _alSourceQueueClear
 *
 * assumes locked context
 */
void _alSourceQueueClear(AL_source *src) {
	ALuint bid;
	int i;

	for(i = 0; i < src->bid_queue.size; i++) {
		bid = src->bid_queue.queue[i];

		if(bid != 0) {
			_alBidRemoveQueueRef(bid, src->sid);
		}
	}

	src->bid_queue.read_index  = 0;
	src->bid_queue.write_index = 0;
	src->bid_queue.size        = 0;

	_alSourceQueueAppend(src, 0);

	return;
}

/*
 * _alSourceQueueAppend
 *
 * assumes locked context
 */
void _alSourceQueueAppend(AL_source *src, ALuint bid) {
	int size    = src->bid_queue.size;
	int newsize = size + 1;
	int windex  = src->bid_queue.write_index;
	void *temp;

	if(src->bid_queue.size > 0) {
		if(src->bid_queue.queue[windex] == 0) {
			/*
			 * special case.  bid == 0 is the "no bid"
			 * bid, which means that it's just a place
			 * holder to allow buffer specific source
			 * parameters to be set.
			 *
			 * Don't bother to resize, just overwrite.
			 */
			src->bid_queue.queue[windex] = bid;

			return;
		}
	}

	temp = realloc(src->bid_queue.queue,
		       newsize * sizeof *src->bid_queue.queue);
	if(temp == NULL) {
		return;
	}
	src->bid_queue.queue = temp;
	src->bid_queue.queue[size] = 0;

	temp = realloc(src->bid_queue.queuestate,
		       newsize * sizeof *src->bid_queue.queuestate);
	if(temp == NULL) {
		return;
	}
	src->bid_queue.queuestate = temp;

	/*
	 * If this is a "real" append operation, ie not bid == NONE,
	 * then increment the write index so that buffer specific
	 * source setting operations take place.
	 */
	if(bid != 0) {
		windex++;
		src->bid_queue.write_index++;
	}

	/*
	 * Initialize sourcestate flags.
	 */
	_alSourceStateInit(&src->bid_queue.queuestate[windex]);

	/*
	 * Set bid and new size.
	 */
	src->bid_queue.queue[windex] = bid;
	src->bid_queue.size = newsize;


	return;
}

/*
 * _alSourceQueueHead
 *
 * assumes locked context
 */
void _alSourceQueueHead(AL_source *src, ALuint bid) {
	_alSourceQueueClear(src);

	src->bid_queue.queue[0]    = bid;
	src->bid_queue.write_index = 0;
	src->bid_queue.read_index  = 0;
	src->bid_queue.size        = 1;

	return;
}


void alUnqueue(ALuint sid, ALsizei n, ALuint *bids) {
	_alcDCLockContext();

	_alUnqueue(sid, n, bids);

	_alcDCUnlockContext();

	return;
}

/*
 *
 * assumes locked context
 *
 * FIXME: replace O(n^2) with merge-sort type iteration
 *        ugly
 *        completly untested
 */
void _alUnqueue(ALuint sid, ALsizei n, ALuint *bids) {
	AL_source *src = NULL;
	ALuint *biditr;
	int i;
	int j;
	int newsize;
	ALuint *tempqueue;
	AL_sourcestate *tempstate;

	if(n < 0) {
		/* bad n */
		_alDCSetError(AL_INVALID_VALUE);
		return;
	}

	if(n == 0) {
		/* legal nop */
		return;
	}

	src = _alDCGetSource(sid);
	if(src == NULL) {
		_alDCSetError(AL_INVALID_NAME);
		return;
	}

	if(n >= src->bid_queue.read_index) {
		/* User has requested too many buffers unqueued */
		_alDCSetError(AL_INVALID_VALUE);
		return;
	}

	/* mark */
	biditr = bids;
	newsize = src->bid_queue.size;
	for(i = 0, j = 0; i < n; i++) {
		while((j < n) && (src->bid_queue.queue[j] != *biditr)) {
			j++;
		}

		if(src->bid_queue.queue[j] == *biditr) {
			_alBidRemoveQueueRef(*biditr, src->sid);

			src->bid_queue.queue[j] = 0;
		}

		biditr++;
		newsize--;
	}

	tempqueue = malloc(newsize * sizeof *tempqueue);
	if(tempqueue == NULL) {
		/* too late
		 *
		 * FIXME: re-add queuerefs removed above */
		_alDCSetError(AL_INVALID_VALUE);
		return;

	}

	tempstate = malloc(newsize * sizeof *tempstate);
	if(tempstate == NULL) {
		/* too late
		 *
		 * FIXME: re-add queuerefs removed above */
		_alDCSetError(AL_INVALID_VALUE);
		return;

	}

	/* sweep and compact */
	for(i = 0; i < n; i++) {
		while(src->bid_queue.queue[i] == 0) {
			/* skip bid 0 */

			if(src->bid_queue.read_index >= i) {
				src->bid_queue.read_index--;
			}
			if(src->bid_queue.write_index >= i) {
				src->bid_queue.write_index--;
			}

			continue;
		}

		tempqueue[i] = src->bid_queue.queue[i];
		tempstate[i] = src->bid_queue.queuestate[i];
	}

	/* assign and free */
	free(src->bid_queue.queue);
	src->bid_queue.queue      = tempqueue;

	free(src->bid_queue.queuestate);
	src->bid_queue.queuestate = tempstate;

	src->bid_queue.size = newsize;

	return;
}

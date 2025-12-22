/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_queue.h
 *
 * Stuff related to the alQueue.
 *
 */
#ifndef AL_QUEUE_H_

#include "al_types.h"

AL_sourcestate *_alSourceQueueGetCurrentState(AL_source *src);

/* truncate a source's queue with a single entry of bid */
void _alSourceQueueHead(AL_source *src, ALuint bid);

/* initialize a source's queue */
void _alSourceQueueInit(AL_source *src);

/* clear a source's queue */
void _alSourceQueueClear(AL_source *src);

/* append bid to source's queue */
void _alSourceQueueAppend(AL_source *src, ALuint bid);

void _alSourceStateInit(AL_sourcestate *srcstate);

/* non locking version */
void _alUnqueue(ALuint sid, ALsizei n, ALuint *bids);

#endif /* AL_QUEUE_H_ */

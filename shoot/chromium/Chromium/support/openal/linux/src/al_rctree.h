/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_rctree.h
 *
 * Stuff related to the rctree data structure
 *
 */
#ifndef AL_RCTREE_H_
#define AL_RCTREE_H_

#define ALRC_MAXSTRLEN 90
#define ALRC_TAG       0xDEADDEAD

#include "al_rcvar.h"

/* values */
typedef struct _AL_rctree {
	ALuint tag; /* must always be set to ALRC_TAG_MAGIC */
	ALRcEnum type;
	ALboolean isquoted;

	union {
		ALint   i;
		ALfloat f;
		ALuint ui;
		struct {
			char c_str[ALRC_MAXSTRLEN];
			int len;
		} str;
		void *misc;
	} data;

	struct _AL_rctree *args;
	struct _AL_rctree *next; /* in list */
} AL_rctree;

/* alloc and init an rctree */
AL_rctree *_alRcTreeAlloc(void);

/* destroy ALrctree, including arguements, but not following ->next */
void _alRcTreeFree(AL_rctree *node);

/* destroy a list's arguements, when passed the first argument */
void _alRcTreeDestroyListArgs(AL_rctree *node);

/* called when openal quits */
void _alRcTreeDestroyAll(void);

#endif /* AL_RCTREE_H_ */

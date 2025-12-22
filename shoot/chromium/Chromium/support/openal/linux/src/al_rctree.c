/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_rctree.h
 *
 * Stuff related to the rctree data structure.
 */
#include "al_debug.h"
#include "al_config.h"
#include "al_rctree.h"
#include "al_siteconfig.h"

#include <stdio.h>
#include <stdlib.h>

typedef struct _AL_RcTreeNode {
	ALuint size;
	ALuint freeslots;
	AL_rctree **data;
} AL_RcTreeNode;

static AL_RcTreeNode rlist = { 0, 0, NULL };

static void rlist_add_rctree(AL_rctree *node);
static void rlist_delete_rctree(AL_rctree *node);
static void rlist_realloc(void);

AL_rctree *_alRcTreeAlloc(void) {
	AL_rctree *retval;

	retval = malloc(sizeof *retval);
	if(retval == NULL) {
		/* _alDCSetError(AL_NO_MEMORY); */
		return NULL;
	}

	rlist_add_rctree(retval);

	retval->tag       = ALRC_TAG;
	retval->type      = ALRC_INVALID;
	retval->isquoted  = AL_FALSE;
	retval->data.misc = 0;
	retval->args      = NULL;
	retval->next      = NULL;

	return retval;
}

void _alRcTreeFree(AL_rctree *node) {
	if(node == NULL) {
		return;
	}

	_alRcTreeDestroyListArgs(node->args);

	/* remove reference from our list */
	rlist_delete_rctree(node);

	free(node);

	return;
}

/*
 * _alRcTreeDestroyListArgs frees the data structures and associated
 * memory from the passed AL_rctree and any ->next siblings it has.
 * 
 * It derives its name from the fact that lists have the following
 * representation:
 *
 * (list-item args: next:)
 *             |     |
 *             |     \-> NULL
 *             |
 *             \-> (item args: next:)
 *                        |     |
 *                        |     \-> (item args: next:)
 *                        |                |     |
 *                        |                |     \-> (...)
 *                        |                |
 *                        |                \-> probably NULL
 *                        |
 *                        |
 *                        \-> probably NULL
 */
void _alRcTreeDestroyListArgs(AL_rctree *rootnode) {
	if(rootnode == NULL) {
		return;
	}

	_alRcTreeDestroyListArgs(rootnode->next);

	rootnode->next = NULL;

	_alRcTreeFree(rootnode);

	return;
}

static void rlist_add_rctree(AL_rctree *node) {
	ALuint i;

	if(rlist.freeslots <= 0) {
		rlist_realloc();
	}

	for(i = 0; i < rlist.size; i++) {
		if(rlist.data[i] == NULL) {
			rlist.freeslots--;
			rlist.data[i] = node;

			return;
		}
	}

	/* weird.  Do something here. */
	ASSERT(0);

	return;
}

static void rlist_delete_rctree(AL_rctree *node) {
	ALuint i;

	for(i = 0; i < rlist.size; i++) {
		if(rlist.data[i] == node) {
			rlist.freeslots++;
			rlist.data[i] = NULL;

			return;
		}
	}

	/* not found */

	return;
}

void _alRcTreeDestroyAll(void) {
	ALuint i;

	for(i = 0; i < rlist.size; i++) {
		if(rlist.data[i] == NULL) {
			continue;
		}

		free(rlist.data[i]);
	}

	free(rlist.data);

	rlist.data      = NULL;
	rlist.size      = 0;
	rlist.freeslots = 0;

	return;
}

static void rlist_realloc(void) {
	ALuint newsize = rlist.size * 2 + 1;
	ALuint i;
	void *temp;

	temp = realloc(rlist.data, newsize * sizeof *rlist.data);
	if(temp == NULL) {
		ASSERT(0);
		return;
	}

	rlist.data = temp;

	for(i = rlist.size; i < newsize; i++) {
		rlist.data[i] = NULL;
	}

	rlist.freeslots += newsize - rlist.size;

	rlist.size = newsize;

	return;
}

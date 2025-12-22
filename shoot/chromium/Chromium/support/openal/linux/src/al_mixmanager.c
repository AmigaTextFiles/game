/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_mixmanager.c
 *
 * Definition and manipulated of ALMixManager objects.
 */
#include "al_siteconfig.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "al_types.h"
#include "al_mixmanager.h"

#include "mixaudio16.h"

/*
 * assumes locked mixer
 * FIXME: sort by bytes?
 */
void _alMixManagerAdd(ALMixManager *mixman, void *dataptr, int bytes_to_write) {
	if(mixman->index >= mixman->size) {
		/* time to resize */
		int newsize = mixman->size * 2;
		void *temp;

		temp = realloc(mixman->pool, newsize * sizeof *mixman->pool);
		if(temp == NULL) {
			/* oh dear */
			return;
		}

		mixman->pool = temp;
		mixman->size = newsize;
	}

	mixman->pool[mixman->index].data  = dataptr;
	mixman->pool[mixman->index].bytes = bytes_to_write;

	mixman->index++;

	return;
}

/*
 *  assumes locked mixer
 */
void _alMixManagerMix(ALMixManager *mixman, ALMixFunc *mf, void *dataptr) {
	if(mixman == NULL) {
		return;
	}

	if(mf == NULL) {
		return;
	}

	if(mixman->index >= mf->max) {
		/* bite the bullet and do it the long way */
		MixAudio16_n(dataptr, mixman->pool, mixman->index);
	} else {
		/* do the mixing */
		mf->funcs[mixman->index](dataptr, mixman->pool);
	}

	/* reset index */
	mixman->index = 0;

	return;
}

void _alMixManagerDestroy(ALMixManager *mixman) {
	if(mixman->pool != NULL) {
		free(mixman->pool);
		mixman->pool = NULL;
	}

	mixman->index = 0;
	mixman->size  = 0;

	/* let caller free */

	return;
}

ALboolean _alMixManagerInit(ALMixManager *mixman, ALuint size) {
	void *temp;

	if(size == 0) {
		return AL_FALSE;
	}

	if(size > MAXMIXSOURCES) {
		return AL_FALSE;
	}

	mixman->size = size;
	mixman->index = 0;

	temp = realloc(mixman->pool, size * sizeof *mixman->pool);
	if(temp == NULL) {
		perror("malloc");
		return AL_FALSE;
	}
	mixman->pool = temp;

	memset(mixman->pool, 0, size * sizeof *mixman->pool);

	return AL_TRUE;
}

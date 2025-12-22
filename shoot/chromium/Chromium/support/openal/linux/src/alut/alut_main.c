/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * alut_main.c
 *
 * Top level functions for alut stuff.
 */
#include <AL/al.h>
#include <AL/alc.h>
#include <AL/alut.h>

#include "al_types.h"
#include "al_main.h"
#include "al_siteconfig.h"

#include "alc/alc_error.h"

#include <stdio.h>

/* FIXME: thread safe? */
static void *alut_context_id = NULL;

void alutInit(UNUSED(int *argc), UNUSED(char *argv[])) {
	alut_context_id = alcCreateContext(NULL);

	if(alut_context_id == NULL) {
		_alcSetError(ALC_INVALID_DEVICE);
	}

	return;
}

void alutExit(void) {
	if(alut_context_id == NULL) {
		_alcSetError(ALC_INVALID_CONTEXT);
		return;
	}

	alcDestroyContext(alut_context_id);

	return;
}

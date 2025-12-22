/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_distance.c
 *
 * Distance tweakage.
 */
#include <AL/al.h>

#include "al_distance.h"
#include "al_error.h"
#include "al_main.h"
#include "alc/alc_context.h"
#include "al_siteconfig.h"

#include <stdlib.h>

#define MIN_DISTANCE 0.001
#define MAX_DISTANCE 40000

void alDistanceScale(ALfloat value) {
	_alcDCLockContext();

	_alDistanceScale(value);

	_alcDCUnlockContext();

	return;
}

/*
 * Assumes locked context.
 */
void _alDistanceScale(ALfloat value) {
	AL_context *cc;
	ALboolean inrange;

	inrange = _alCheckRangef(value, MIN_DISTANCE, MAX_DISTANCE);
	if(inrange == AL_FALSE) {
		_alDCSetError(AL_INVALID_VALUE);
		return;
	}

	cc = _alcDCGetContext();
	if(cc == NULL) {
		return;
	}

	cc->distance_scale = value;

	return;
}

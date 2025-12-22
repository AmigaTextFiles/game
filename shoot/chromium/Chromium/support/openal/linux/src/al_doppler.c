/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_doppler.c
 *
 * Doppler tweakage.
 */
#include <AL/al.h>

#include "al_doppler.h"
#include "al_error.h"
#include "al_main.h"
#include "alc/alc_context.h"
#include "al_siteconfig.h"

#include <stdlib.h>

#define MIN_DOPPLER 0.001
#define MAX_DOPPLER 40000

void alDopplerScale(ALfloat value) {
	_alcDCLockContext();

	_alDopplerScale(value);

	_alcDCUnlockContext();

	return;
}

/*
 * Assumes locked context.
 */
void _alDopplerScale(ALfloat value) {
	AL_context *cc;
	ALboolean inrange;

	inrange = _alCheckRangef(value, MIN_DOPPLER, MAX_DOPPLER);
	if(inrange == AL_FALSE) {
		_alDCSetError(AL_INVALID_VALUE);
		return;
	}

	cc = _alcDCGetContext();
	if(cc == NULL) {
		return;
	}

	cc->doppler_factor = value;

	return;
}

/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_able.c
 *
 * Handles Enable / Disable stuff.
 *
 */
#include <stdio.h>

#include <AL/al.h>
#include <AL/alexttypes.h>

#include "al_able.h"
#include "al_types.h"
#include "al_error.h"
#include "al_main.h"

#include "alc/alc_context.h"
#include "al_siteconfig.h"

/** Enable/Disable mojo. */

void alEnable(ALenum param) {
	_alcDCLockContext();

	_alEnable(param);

	_alcDCUnlockContext();

	return;
}

void alDisable(ALenum param) {
	_alcDCLockContext();

	_alDisable(param);

	_alcDCUnlockContext();

	return;
}

ALboolean alIsEnabled(ALenum param) {
	ALboolean retval;

	_alcDCLockContext();

	retval = _alIsEnabled(param);

	_alcDCUnlockContext();

	return retval;
}

/*
 * assumes locked context
 */
ALboolean _alIsEnabled(ALenum param) {
	AL_context *cc;

	cc = _alcDCGetContext();
	if(cc == NULL) {
		return AL_FALSE;
	}

	switch(param) {
		case AL_DOPPLER_SHIFT:
		  return cc->enable_flags & ALE_DOPPLER_SHIFT;
		  break;
		case AL_DISTANCE_ATTENUATION:
		  return cc->enable_flags & ALE_DISTANCE_ATTENUATION;
		default:
		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	return AL_FALSE;
}

/*
 * assumes locked context
 */
void _alEnable(ALenum param) {
	AL_context *cc;
	ALboolean err;

	cc = _alcDCGetContext();
	if(cc == NULL) {
		return;
	}

	switch(param) {
		case AL_DOPPLER_SHIFT:
		  cc->enable_flags |= ALE_DOPPLER_SHIFT;
		  break;
		case AL_DISTANCE_ATTENUATION:
		  cc->enable_flags |= ALE_DISTANCE_ATTENUATION;
		  break;
		case AL_CAPTURE_EXT:
		  err = _alcDCEnableCapture();

		  if(err == AL_TRUE) {
		  	cc->enable_flags |= ALE_CAPTURE_EXT;
		  }
		  break;
		default:
		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	return;
}

void _alDisable(ALenum param) {
	AL_context *cc;

	cc = _alcDCGetContext();
	if(cc == NULL) {
		return;
	}

	switch(param) {
		case AL_DOPPLER_SHIFT:
		  cc->enable_flags &= ~ALE_DOPPLER_SHIFT;
		  break;
		case AL_DISTANCE_ATTENUATION:
		  cc->enable_flags &= ~ALE_DISTANCE_ATTENUATION;
		  break;
		case AL_CAPTURE_EXT:
		  _alcDCDisableCapture();

		  cc->enable_flags &= ~ALE_CAPTURE_EXT;
		  break;
		default:
		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	return;
}


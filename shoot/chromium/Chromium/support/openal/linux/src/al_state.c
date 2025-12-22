/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_state.c
 *
 * State management.  Mainly stubbed.
 *
 */
#include <stdio.h>
#include <math.h>

#include <AL/al.h>
#include <AL/alkludge.h>

#include "al_types.h"
#include "al_error.h"
#include "al_main.h"
#include "al_state.h"
#include "al_siteconfig.h"
#include "al_ext.h"

/** State retrieval. */

ALfloat alGetFloat(ALenum param) {
	ALfloat retval = 0.0;

	_alcDCLockContext();

	retval = _alGetFloat(param);

	_alcDCUnlockContext();

	return retval;
}

ALfloat _alGetFloat(ALenum param) {
	AL_context *cc;
	ALfloat retval = 0.0;

	cc = _alcDCGetContext();

	switch(param) {
		case AL_DOPPLER_SCALE:
		  retval = cc->doppler_factor;
		  break;
		case AL_PROPAGATION_SPEED:
		  retval = cc->propagation_speed;
		  break;
		case AL_DISTANCE_SCALE:
		  retval = cc->distance_scale;
		  break;
		default:
		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	return retval;
}

ALboolean alGetBoolean(ALenum param) {
	ALboolean retval = AL_FALSE;

	_alcDCLockContext();

	retval = _alGetBoolean(param);

	_alcDCUnlockContext();

	return AL_FALSE;
}

ALint alGetInteger(ALenum param) {
	ALint retval = 0;

	_alcDCLockContext();

	retval = _alGetInteger(param);

	_alcDCUnlockContext();

	return retval;
}

ALdouble alGetDouble(ALenum param) {
	ALdouble retval = 0.0;

	_alcDCLockContext();

	retval = _alGetDouble(param);

	_alcDCUnlockContext();

	return retval;
}

ALboolean _alGetBoolean(UNUSED(ALenum param)) {
	_alStub("alGetBoolean");

	return AL_FALSE;
}

ALint _alGetInteger(UNUSED(ALenum param)) {
	_alStub("alGetInteger");

	return 0;
}

ALdouble _alGetDouble(UNUSED(ALenum param)) {
	_alStub("alGetDouble");

	return 0.0;
}

void alGetBooleanv(ALenum param, ALboolean* data) {
	*data = alGetBoolean(param);

	return;
}

void alGetIntegerv(ALenum param, ALint* data) {
	*data = alGetInteger(param);

	return;
}

void alGetFloatv(ALenum param, ALfloat* data) {
	*data = alGetFloat(param);

	return;
}

void alGetDoublev(ALenum param, ALdouble* data) {
	*data = alGetDouble(param);

	return;
}

const ALubyte *alGetString(ALenum param) {
	static ALubyte extensions[4096];

	/*
	 * First, we check to see if the param corresponds to an
	 * error, in which case we return the value from _alGetErrorString.
	 */
	if(_alIsError(param) == AL_TRUE) {
		return _alGetErrorString(param);
	}

	switch(param) {
		case AL_VENDOR:
			return (const ALubyte *) "Loki Software";
		case AL_VERSION:
			return (const ALubyte *) LAL_VERSION;
		case AL_RENDERER:
			return (const ALubyte *) "Software";
		case AL_EXTENSIONS:
			_alGetExtensionStrings( extensions, sizeof( extensions ) );
			return extensions;
		default:
		  break;
	}

	return NULL;
}

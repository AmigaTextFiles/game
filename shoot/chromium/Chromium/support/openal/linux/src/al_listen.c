
/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 * 
 * al_listen.c
 *
 * Functions related to management and use of listeners.
 */
#include "al_siteconfig.h"

#include "../include/AL/al.h"
#include "../include/AL/alkludge.h"

#include "al_debug.h"
#include "al_error.h"
#include "al_types.h"
#include "al_listen.h"
#include "al_main.h"
#include "al_error.h"
#include "al_config.h"
#include "alc/alc_context.h"
#include "alc/alc_speaker.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 *  PARAMS: Gain.
 */
void alListenerf( ALenum param, ALfloat value) {
	AL_context *dc;
	ALboolean inrange = AL_TRUE;

	_alcDCLockContext();
	dc = _alcDCGetContext();
	if(dc == NULL) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
		      "alListenerf: no current context\n");

		_alcDCUnlockContext();

		return;
	}

	/* check range */
	switch(param) {
		case AL_GAIN_LINEAR:
		  inrange = _alCheckRangef(value, 0.0, 1.0);
		  break;
		case AL_GAIN:
		  inrange = _alCheckRangef(value, 0.0, 1.0);
		  break;
		default:
		  /*
		   * Unknown param, error below.
		   */
		  break;
	}

	if(inrange == AL_FALSE) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
		      "alListenerf(0x%x): value %f out of range",
		      param, value);

		_alDCSetError(AL_INVALID_VALUE);
		_alcDCUnlockContext();

		return;
	}

	switch(param) {
		case AL_GAIN_LINEAR:
		  dc->listener.Gain = value;
		  break;
		case AL_GAIN:
		  dc->listener.Gain = _alDBToLinear(value);
		  break;
		default:
		  debug(ALD_CONTEXT, __FILE__, __LINE__,
			"alListenerf: invalid param 0x%x.",
			param);
		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	_alcDCUnlockContext();

	return;
}

/*
 *  PARAMS: Position, velocity
 */
void alListener3f( ALenum pname, ALfloat p1, ALfloat p2, ALfloat p3) {
	ALfloat fv[3];

	fv[0] = p1;
	fv[1] = p2;
	fv[2] = p3;

	alListenerfv(pname, fv);

	return;
}

/*
 *  PARAMS: Position, velocity, orientation
 */
void alListenerfv( ALenum pname, ALfloat *pv) {
	AL_context *dc;

	_alcDCLockContext();

	if(pv == NULL) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
		      "alListenerfv: invalid values NULL\n");

		_alDCSetError(AL_INVALID_VALUE);
		_alcDCUnlockContext();

		return;
	}

	dc = _alcDCGetContext();
	if(dc == NULL) {
		/* okay, this is weird */
		_alcDCUnlockContext();

		return;
	}

	switch(pname) {
		case AL_POSITION:
		  dc->listener.Position[0] = pv[0];
		  dc->listener.Position[1] = pv[1];
		  dc->listener.Position[2] = pv[2];

		  _alcDCSpeakerMove();
		  break;
		case AL_VELOCITY:
		  dc->listener.Velocity[0] = pv[0];
		  dc->listener.Velocity[1] = pv[1];
		  dc->listener.Velocity[2] = pv[2];
		  break;
		case AL_ORIENTATION:
		  dc->listener.Orientation[0] = pv[0]; /* at */
		  dc->listener.Orientation[1] = pv[1];
		  dc->listener.Orientation[2] = pv[2];

		  dc->listener.Orientation[3] = pv[3]; /* up */
		  dc->listener.Orientation[4] = pv[4];
		  dc->listener.Orientation[5] = pv[5];

		  _alcDCSpeakerMove();
		  break;
		default:
		  debug(ALD_CONTEXT, __FILE__, __LINE__,
			"alListenerfv: param 0x%x in not valid.",
			  pname);
		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	_alcDCUnlockContext();

	return;
}

void _alDestroyListener(UNUSED(AL_listener *ls)) {
	/* nothing needed */
	return;
}

/* assumes locked context
 *
 * FIXME: add case statements for other params
 */
void *_alGetListenerParam(ALuint cid, ALenum param) {
	AL_context *cc;
	AL_listener *list;

	cc = _alcGetContext(cid);
	if(cc == NULL) {
		/* 
		 * cid is an invalid context.  We can't set an error
		 * here because this requires a valid context.
		 */

		debug(ALD_CONTEXT, __FILE__, __LINE__,
			"_alGetListenerParam: called with invalid context %d",
			cid);

		_alDCSetError(AL_ILLEGAL_COMMAND);

		return NULL;
	}

	list = &cc->listener;

	switch(param) {
		case AL_GAIN_LINEAR:
		  return &list->Gain;
		  break;
		case AL_VELOCITY:
		  return &list->Velocity;
		  break;
		case AL_POSITION:
		  return &list->Position;
		case AL_ORIENTATION:
		  return &list->Orientation;
		default:
		  debug(ALD_CONTEXT, __FILE__, __LINE__,
		  	"_alGetListenerParam(%d, ...) passed bad param 0x%x",
			param);

		  _alSetError(cid, AL_ILLEGAL_ENUM);
		  break;
	}

	return NULL;
}

/*
 *  Initialize already alloced listener
 */
void _alInitListener(AL_listener *listener) {
	ALfloat tempfv[6];
	ALboolean err;
	int i;

	err = _alGetGlobalVector("listener-position", ALRC_FLOAT, 3, tempfv);
	if(err == AL_FALSE) {
		/* no preset position */
		for(i = 0; i < 3; i++) {
			listener->Position[i] = 0.0;
		}
	} else {
		memcpy((void *) listener->Position,
		       (void *) tempfv, SIZEOFVECTOR);
	}

	err = _alGetGlobalVector("listener-velocity", ALRC_FLOAT, 3, tempfv);
	if(err == AL_FALSE) {
		/* no preset velocity */
		for(i = 0; i < 3; i++) {
			listener->Velocity[i] = 0.0;
		}
	} else {
		memcpy((void *) listener->Velocity,
		       (void *) tempfv, SIZEOFVECTOR);
	}

	err = _alGetGlobalVector("listener-orientation", ALRC_FLOAT, 6, tempfv);
	if(err == AL_FALSE) {
		/* no preset orientation */

		/* at */
		listener->Orientation[0] = 0.0;
		listener->Orientation[1] = 0.0;
		listener->Orientation[2] = -1.0;

		/* up */
		listener->Orientation[3] = 0.0;
		listener->Orientation[4] = 1.0;
		listener->Orientation[5] = 0.0;
	} else {
		memcpy((void *) listener->Orientation,
		       (void *) tempfv, 2 * SIZEOFVECTOR);
	}

	/*
	 * FIXME: listener gain now only reading one channel's
	 * worth of stuff
	 *
	 * So kludgey!
	 */
	listener->Gain = 1.0;

	return;
}

void alGetListeneri(ALenum pname, ALint *value) {
	AL_context *cc;
	ALint *temp;

	_alcDCLockContext();

	if(value == NULL) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
		      "alGetListeneri: invalid values NULL\n");

		_alDCSetError(AL_INVALID_VALUE);
		_alcDCUnlockContext();

		return;
	}

	cc = _alcDCGetContext();
	if(cc == NULL) {
		/* 
		 * There is no current context, which means that
		 * we cannot set the error.  But if there is no
		 * current context we should not have been able
		 * to get here, since we've already locked the
		 * default context.  So this is weird.
		 *
		 * In any case, set and error, unlock, and pray.
		 */ 
		_alDCSetError(AL_ILLEGAL_COMMAND);
		_alcDCUnlockContext();
		return;
	}

	temp = _alDCGetListenerParam(pname);
	if(temp == NULL) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
			"alGetListeneri: param 0x%x not valid", pname);

		_alDCSetError(AL_ILLEGAL_ENUM);
		_alcDCUnlockContext();
		return;
	}

	*value = *temp;

	_alcDCUnlockContext();

	return;
}

void alGetListenerf( ALenum pname, ALfloat *value) {
	AL_context *cc;
	ALfloat *temp;

	_alcDCLockContext();

	if(value == NULL) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
		      "alGetListenerf: invalid values NULL\n");

		_alDCSetError(AL_INVALID_VALUE);
		_alcDCUnlockContext();

		return;
	}

	cc = _alcDCGetContext();
	if(cc == NULL) {
		/* 
		 * There is no current context, which means that
		 * we cannot set the error.  But if there is no
		 * current context we should not have been able
		 * to get here, since we've already locked the
		 * default context.  So this is weird.
		 *
		 * In any case, set and error, unlock, and pray.
		 */ 

		_alDCSetError(AL_ILLEGAL_COMMAND);
		_alcDCUnlockContext();
		return;
	}

	temp = _alDCGetListenerParam(pname);
	if(temp == NULL) {
		/* The listener param is not set, so we set defaults,
		 * except in the case of AL_GAIN, for which we convert
		 * from AL_GAIN_LINEAR.
		 */
		switch(pname) {
			case AL_GAIN_LINEAR:
			  *value = 1.0;
			  break;
			case AL_GAIN:
			  temp = _alDCGetListenerParam(AL_GAIN_LINEAR);
			  if(temp == NULL) {
				  *value = 1.0;
			  } else {
		  		  *value = _alLinearToDB(*temp);
			  }
			  break;
			default:
			  debug(ALD_CONTEXT, __FILE__, __LINE__,
				"alGetListenerf 0x%x stubbed or unsupported",
				pname);

			  _alDCSetError(AL_ILLEGAL_ENUM);
			  _alcDCUnlockContext();
			return;
		}
	} else {
		*value = *temp;
	}

	_alcDCUnlockContext();

	return;
}

void alGetListenerfv( ALenum param, ALfloat* values) {
	AL_context *cc;
	ALfloat *fv;

	_alcDCLockContext();

	if(values == NULL) {
		debug(ALD_CONTEXT, __FILE__, __LINE__,
		      "alGetListenerfv: invalid values NULL\n");

		_alDCSetError(AL_INVALID_VALUE);
		_alcDCUnlockContext();

		return;
	}

	cc = _alcDCGetContext();

	if(cc == NULL) {
		/* 
		 * There is no current context, which means that
		 * we cannot set the error.  But if there is no
		 * current context we should not have been able
		 * to get here, since we've already locked the
		 * default context.  So this is weird.
		 *
		 * In any case, set and error, unlock, and pray.
		 */ 

		_alDCSetError(AL_ILLEGAL_COMMAND);
		_alcDCUnlockContext();
		return;
	}

	fv = _alDCGetListenerParam(param);
	if(fv == NULL) {
		/* 
		 * This is different from buffer and source, because
		 * we should never had NULL values here.  If we do,
		 * it is because the param is invalid.
		 */
		debug(ALD_CONTEXT, __FILE__, __LINE__,
			"alGetListenerfv: param 0x%x not valid",
			param);

		_alDCSetError(AL_ILLEGAL_ENUM);
		_alcDCUnlockContext();

		return;
	}

	switch(param) {
		case AL_POSITION:
		case AL_VELOCITY:
	 	  memcpy(values, fv, SIZEOFVECTOR);
		  break;
		case AL_ORIENTATION:
		  memcpy(values, fv, 2 * SIZEOFVECTOR);
		  break;
		default:
		  debug(ALD_CONTEXT, __FILE__, __LINE__,
		        "alGetListenerfv: param 0x%x not valid",
			param);

		  _alDCSetError(AL_ILLEGAL_ENUM);
		  break;
	}

	_alcDCUnlockContext();

	return;
}

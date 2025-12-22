/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * alc_error.c
 *
 * openal error reporting.
 *
 */
#include <AL/al.h>
#include <AL/alc.h>

#include <stdio.h>

#include "al_debug.h"
#include "alc/alc_error.h"
#include "al_siteconfig.h"

static int alcErrorIndex = 0;

/*
 * 0 -> ALC_NO_ERROR
 * 1 -> ALC_INVALID_DEVICE
 * 2 -> ALC_INVALID_CONTEXT
 */
static const char *_alcErrorStr[] = {
	"No alc error.",
	"There is no accessible sound device/driver/server",
	"The Context argument does not name a valid context"
};

static int ErrorNo2index(ALenum error_number) {
	switch(error_number) {
		case ALC_NO_ERROR:
		  return 0;
		  break;
		case ALC_INVALID_DEVICE:
		  return 1;
		  break;
		case ALC_INVALID_CONTEXT:
		  return 2;
		  break;
		default:
		  debug(ALD_ERROR, __FILE__, __LINE__,
		  	"Unknown error condition: 0x%x", error_number);
		  return -1;
		  break;
	}

	return -1;
}

static int index2ErrorNo(int index) {
	switch(index) {
 		case 0:
		  return ALC_NO_ERROR;
		  break;
		case 1:
		  return ALC_INVALID_DEVICE;
		  break;
		case 2:
		  return ALC_INVALID_CONTEXT;
		  break;
		default:
		  debug(ALD_ERROR, __FILE__, __LINE__,
		  	"Unknown error index: %d", index);
		  break;
	}

	return -1;
}

/**
 * Error support.
 * Obtain the most recent error generated in the AL state machine,
 * but for alc.
 */
ALCenum alcGetError( void ) {
	ALCenum retval;
	
	
	retval = index2ErrorNo(alcErrorIndex);

	/*
	 * In deference to the new spec, GetError clears the error
	 * after reading it.
	 */
	alcErrorIndex = 0;
	
	return retval;
}

/*
 * I'm inclined to go with an implementation that preserves
 * errors, but for now we're just overwriting unnoticed errors
 */
void _alcSetError(ALenum param) {
	int setval;

	setval = ErrorNo2index(param);
	if(setval == -1) {
		/* invalid param*/
		return;
	}

	if(alcErrorIndex == 0) {
		/*
		 * Only set error if no previous error has been recorded.
		 */
		
		alcErrorIndex = setval;
	}
		
	return;
}

/*
 * This function returns the string corresponding to the
 * error in question.  It doesn't validate that the passed
 * param, so calling functions should ensure that _alIsError(param)
 * return AL_TRUE before passing it to this function.
 */
const ALubyte *alcGetErrorString(ALenum param) {
	int offset;

	offset = ErrorNo2index(param);

	if(offset >= 0) {
		return (const ALubyte *) _alcErrorStr[offset];
	}

	return NULL;
}

/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_error.h
 *
 * openal error reporting.
 */
#ifndef _AL_ERROR_H_
#define _AL_ERROR_H_

#include <AL/altypes.h>
#include "alc/alc_context.h"

/*
 * Are errors fatal?  Setting this to AL_TRUE will make them so.
 */
extern ALboolean _alShouldBombOnError_LOKI;

void _alSetError(ALuint cid, ALenum param);

ALboolean _alIsError(ALenum param);

/* returns error string associated with errno */
const ALubyte *_alGetErrorString(ALenum param);

/* Macros to handle default context */
#define _alDCSetError(p) _alSetError(_alcCCId, p)

#endif /* _AL_ERROR_H_ */

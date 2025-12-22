/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_ext_capture.h
 *
 * Prototypes for audio recording extension
 */
#ifndef AL_EXT_CAPTURE_H_
#define AL_EXT_CAPTURE_H_

#include "al_ext_needed.h"
#include "al_types.h"

#include <AL/alext.h>

/* functions needed by the regular library implementing extensions. */
void FL_alLockCapture(const char *fn, int ln);
void FL_alUnlockCapture(const char *fn, int ln);
#define _alLockCapture()       FL_alLockCapture(__FILE__, __LINE__)
#define _alUnlockCapture()     FL_alUnlockCapture(__FILE__, __LINE__)

ALboolean _alIsCapture(ALuint cpid);
AL_capture *_alGetCapture(ALuint cpid);
void _alCaptureAppendData(AL_capture *cap, ALvoid *capture_buffer, ALuint bytes);

void alInitCapture(void);
void alFiniCapture(void);

#ifndef OPENAL_EXTENSION

/*
 * we are being built into the standard library, so inform
 * the extension registrar
 */
#define BUILTIN_EXT_CAPTURE                                        \
	AL_EXT_PAIR(alGenCaptures_EXT),                            \
	AL_EXT_PAIR(alDeleteCaptures_EXT),                         \
	AL_EXT_PAIR(alCapturei_EXT),                               \
	AL_EXT_PAIR(alCaptureStart_EXT),                           \
	AL_EXT_PAIR(alCaptureStop_EXT),                            \
	AL_EXT_PAIR(alIsCapture_EXT),                              \
	AL_EXT_PAIR(alBufferRetrieveData_EXT)

/* initialization and destruction functions */

#define BUILTIN_EXT_CAPTURE_INIT  alInitCapture()
#define BUILTIN_EXT_CAPTURE_FINI  alFiniCapture()

#else

#define BUILTIN_EXT_CAPTURE_INIT
#define BUILTIN_EXT_CAPTURE_FINI

#endif /* OPENAL_EXTENSION */

#endif /* AL_EXT_CAPTURE_H_ */

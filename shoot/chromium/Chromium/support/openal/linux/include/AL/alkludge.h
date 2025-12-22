/*
 *  alkludge.h 
 *
 *  This contains stuff that either should be removed, deprecated or
 *  moved somewhere else.  If it's to be removed or deprecated you're
 *  SOL if you include it.  If it's to be moved somewhere else, including
 *  the standard al header files should enable your safety.
 */

#ifndef _AL_KLUDGE_H
#define _AL_KLUDGE_H

#ifdef __cplusplus
extern "C" {
#endif

#ifdef _WIN32
#define ALAPI        __declspec(dllexport)
#define ALAPIENTRY   __cdecl
#define AL_CALLBACK 
#else
#define ALAPI
#define ALAPIENTRY
#define AL_CALLBACK 
#endif /* _WIN32 */

#include "AL/alkludgetypes.h"

ALAPI void ALAPIENTRY alGenStreamingBuffers(ALsizei n, ALuint *samples );

ALAPI ALboolean ALAPIENTRY alutLoadRAW_ADPCMData_LOKI(ALuint bid,
				ALvoid *data, ALuint size, ALuint freq,
				ALenum format);

ALAPI ALboolean ALAPIENTRY alutLoadIMA_ADPCMData_LOKI(ALuint bid,
				ALvoid *data, ALuint size,
				alIMAADPCM_state_LOKI *ias);

ALAPI ALboolean ALAPIENTRY alutLoadMS_ADPCMData_LOKI(ALuint bid,
				void *data, int size,
				alMSADPCM_state_LOKI *mss);

#ifdef __cplusplus
}
#endif

#endif /* _AL_KLUDGE_H_ */

#ifndef _LAL_EXT_H_
#define _LAL_EXT_H_

#include "AL/altypes.h"
#include "alexttypes.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef ALAPI
#define ALAPI extern
#endif

/* loki */

ALAPI ALfloat alcGetAudioChannel_LOKI(ALuint channel);
typedef ALfloat (*PFNALCGETAUDIOCHANNELPROC)(ALuint channel);

ALAPI void alcSetAudioChannel_LOKI(ALuint channel, ALfloat volume);
typedef void (*PFNALCSETAUDIOCHANNELPROC)(ALuint channel, ALfloat volume);

ALAPI ALboolean alutBufferAndConvertData_LOKI(ALuint bid, void *data,
				   ALboolean dummy, ALuint size);
typedef ALboolean (*PFNALUTBUFFERANDCONVERTDATAPROC)(ALuint bid, void *data,
				   ALboolean dummy, ALuint size);

ALAPI void alAttenuationScale_LOKI(ALfloat param);
typedef void (*PFNALATTENUATIONSCALEPROC)(ALfloat param);

ALAPI void alBombOnError_LOKI(void);
typedef void (*PFNALBOMBONERRORPROC)(void);

ALAPI void alBufferi_LOKI(ALuint bid, ALenum param, ALint value);
typedef void (*PFNALBUFFERIPROC)(ALuint bid, ALenum param, ALint value);

ALAPI void alBufferDataWithCallback_LOKI(ALuint bid,
		int (*Callback)(ALuint, ALuint, ALshort *, ALenum, ALint, ALint));
typedef void (*PFNALBUFFERDATAWITHCALLBACKPROC)(ALuint bid,
		int (*Callback)(ALuint, ALuint, ALshort *, ALenum, ALint, ALint));

ALAPI void alBufferWriteData_LOKI( ALuint   buffer,
                   ALenum   format,
                   ALvoid*  data,
                   ALsizei  size,
                   ALsizei  freq,
                   ALenum   internalFormat );
typedef void (*PFNALBUFFERWRITEDATAPROC)( ALuint   buffer,
                   ALenum   format,
                   ALvoid*  data,
                   ALsizei  size,
                   ALsizei  freq,
                   ALenum   internalFormat );

ALAPI ALsizei alBufferAppendData_LOKI( ALuint   buffer,
                            ALenum   format,
                            ALvoid*    data,
                            ALsizei  size,
                            ALsizei  freq );

typedef ALsizei (*PFNALBUFFERAPPENDDATAPROC)( ALuint   buffer,
                            ALenum   format,
                            ALvoid*    data,
                            ALsizei  size,
                            ALsizei  freq );

ALAPI ALsizei alBufferAppendWriteData_LOKI( ALuint   buffer,
                            ALenum   format,
                            ALvoid*  data,
                            ALsizei  size,
                            ALsizei  freq,
			    ALenum internalFormat );

typedef ALsizei (*PFNALBUFFERAPPENDWRITEDATAPROC)( ALuint   buffer,
                            ALenum   format,
                            ALvoid*  data,
                            ALsizei  size,
                            ALsizei  freq,
			    ALenum internalFormat );

/* captures */

ALAPI void alDeleteCaptures_EXT(ALsizei n, ALuint *cpids);
typedef void (*PFNALDELETECAPTURESPROC)(ALsizei n, ALuint *cpids);

ALAPI void alGenCaptures_EXT(ALsizei n, ALuint *cpids);
typedef void (*PFNALGENCAPTURESPROC)(ALsizei n, ALuint *cpids);

ALAPI void alCapturei_EXT(ALuint cpid, ALenum param, ALint value);
typedef void (*PFNALCAPTUREIPROC)(ALuint cpid, ALenum param, ALint value);

ALAPI void alCaptureStart_EXT(ALuint cpid);
typedef void (*PFNALCAPTURESTARTPROC)(ALuint cpid);

ALAPI ALuint alBufferRetrieveData_EXT(ALuint cpid, ALenum format, ALvoid *buffer, ALsizei samples, ALuint freq);
typedef ALuint (*PFNALBUFFERRETRIEVEDATAPROC)(ALuint cpid, ALenum format, ALvoid *buffer, ALsizei samples, ALuint freq);

ALAPI void alCaptureStop_EXT(ALuint cpid);
typedef void (*PFNALCAPTURESTOPPROC)(ALuint cpid);

ALAPI ALboolean alIsCapture_EXT(ALuint cpid);
typedef ALboolean (*PFNALISCAPTUREPROC)(ALuint cpid);

/* vorbis */
ALAPI ALboolean alutLoadVorbis_LOKI(ALuint bid, ALvoid *data, ALint size);
typedef  ALboolean (*PFNALUTLOADVORBISPROC)(ALuint bid, ALvoid *data, ALint size);

#ifdef __cplusplus
}
#endif

#endif /* _LAL_EXT_H_ */

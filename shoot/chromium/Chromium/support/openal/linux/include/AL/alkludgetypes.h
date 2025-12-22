#ifndef AL_KLUDGE_TYPES_H
#define AL_KLUDGE_TYPES_H

#include "AL/altypes.h"

#define ALMAXDISTANCE 60

#define AL_SOURCE_ATTENUATION_MIN       AL_GAIN_MIN
#define AL_SOURCE_ATTENUATION_MAX       AL_GAIN_MAX

#ifdef AL_SOURCE_LOOPING
#undef AL_SOURCE_LOOPING
#endif

#ifdef AL_SOURCE_LOOPING_LOKI
#undef AL_SOURCE_LOOPING_LOKI
#endif

#ifdef AL_LOOP_COUNT
#undef AL_LOOP_COUNT
#endif

#ifdef AL_PLAY_COUNT
#undef AL_PLAY_COUNT
#endif

#define AL_SOURCE_LOOPING		AL_LOOPING
#define AL_LOOP_COUNT                   AL_LOOPING
#define AL_PLAY_COUNT                   AL_LOOPING
#define AL_SOURCE_LOOPING_LOKI          AL_LOOPING

/*
 *  Channel operations are probably a big no-no and destined
 *  for obsolesence.
 */
#define	ALC_CHAN_MAIN_LOKI      0x500001
#define	ALC_CHAN_PCM_LOKI       0x500002
#define	ALC_CHAN_CD_LOKI        0x500003

typedef struct WaveFMT {
        ALushort encoding;
	ALushort channels;               /* 1 = mono, 2 = stereo */
	ALuint frequency;              /* One of 11025, 22050, or 44100 Hz */
	ALuint byterate;               /* Average bytes per second */
	ALushort blockalign;             /* Bytes per sample block */
	ALushort bitspersample;
} alWaveFMT_LOKI;

typedef struct _MS_ADPCM_decodestate {
	ALubyte hPredictor;
	ALushort iDelta;
	ALshort iSamp1;
	ALshort iSamp2;
} alMSADPCM_decodestate_LOKI;

typedef struct MS_ADPCM_decoder {
	alWaveFMT_LOKI wavefmt;
	ALushort wSamplesPerBlock;
	ALushort wNumCoef;
	ALshort aCoeff[7][2];
	/* * * */
	alMSADPCM_decodestate_LOKI state[2];
} alMSADPCM_state_LOKI;

typedef struct IMA_ADPCM_decodestate_s {
	ALint valprev;	/* Previous output value */
	ALbyte index;		/* Index into stepsize table */
} alIMAADPCM_decodestate_LOKI;

typedef struct IMA_ADPCM_decoder {
	alWaveFMT_LOKI wavefmt;
	ALushort wSamplesPerBlock;
	/* * * */
	alIMAADPCM_decodestate_LOKI state[2];
} alIMAADPCM_state_LOKI;

#endif /* AL_KLUDGE_TYPES_H */

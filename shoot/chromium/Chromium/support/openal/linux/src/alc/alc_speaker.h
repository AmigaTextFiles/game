#ifndef ALC_SPEAKER_H_
#define ALC_SPEAKER_H_

#include "alc_context.h"
#include "AL/altypes.h"

#define _ALC_SPEAKER_DISTANCE 5

typedef enum {
	ALS_LEFT,
	ALS_RIGHT,
	ALS_LEFTS,
	ALS_RIGHTS
} _alcSpeakerEnum;

void         _alcSpeakerInit(ALuint cid);
void         _alcSpeakerMove(ALuint cid);
ALfloat     *_alcGetSpeakerPosition(ALuint cid, ALuint speaker_num);
ALuint       _alcGetNumSpeakers(ALuint cid);

#define _alcDCSpeakerMove()     _alcSpeakerMove(_alcCCId)
#define _alcDCSpeakerInit()     _alcSpeakerInit(_alcCCId)
#define _alcDCGetNumSpeakers()  _alcGetNumSpeakers(_alcCCId)

#endif /* _ALC_SPEAKERS_H_ */

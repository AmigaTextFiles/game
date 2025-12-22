#ifndef _AL_LISTENER_H_
#define _AL_LISTENER_H_

#include "al_types.h"
#include "alc/alc_context.h"

#define _alDCGetListenerParam(p) _alGetListenerParam(_alcCCId, p)

void _alInitListener(AL_listener *listener);
void _alDestroyListener(AL_listener *listener);

void *_alGetListenerParam(ALuint cid, ALenum param);

#endif /* _AL_LISTENER_H_ */

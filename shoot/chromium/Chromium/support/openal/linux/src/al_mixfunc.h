#ifndef _AL_MIXFUNC_H_
#define _AL_MIXFUNC_H_

#include "al_types.h"
#include "al_mixer.h"

typedef struct _AL_MixFunc {
	void (*funcs[MAXMIXSOURCES+1])(ALshort *dst, alMixEntry *entries);
	ALuint max;
} ALMixFunc;

ALboolean _alMixFuncInit(ALMixFunc *mf, ALuint size);
void _alMixFuncDestroy(ALMixFunc *mf);

#endif /* _AL_MIXFUNC_H_ */

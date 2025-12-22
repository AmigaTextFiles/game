#ifndef _AL_FILTER_H_
#define _AL_FILTER_H_

#include <AL/al.h>
#include "al_types.h"
#include "al_complex.h"

void _alApplyFilters(ALuint c, ALuint sid);
void _alDestroyFilters(void);

/* time domain filters */
time_filter alf_reverb;
time_filter alf_coning;
time_filter alf_da;
time_filter alf_gain;
time_filter alf_tpitch;
time_filter alf_tdoppler;
time_filter alf_minmax;
time_filter alf_listenergain;

/* frequency based filters */
freq_filter alf_doppler;
freq_filter alf_pitch;
freq_filter alf_lowp;

void _alInitTimeFilters(time_filter_set *tf_ptr_ref);
void _alInitFreqFilters(freq_filter_set *ff_ptr_ref);

/* macros */
#define _alDCApplyFilters(s) 	_alApplyFilters(_alcCCId, s)

#endif

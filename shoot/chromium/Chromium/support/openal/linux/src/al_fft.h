/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * al_fft.h
 *
 * prototype et al for the fft
 *
 */
#ifndef _AL_FFT_H_
#define _AL_FFT_H_

#include "al_types.h"
#include "al_complex.h"

void _alFFTSources(int mc, int len, ALshort **pcmdata, ALcomplex **retref);
void _alDeFFTSources(int mc, int len, ALcomplex **fftdata, ALshort **retref);


void _alFFTSources_Windowed(int mc, int len, int offset,
			ALshort **pcmdata, ALcomplex **retref);
void _alDeFFTSources_Windowed(int mc, int len, int offset,
	ALcomplex **fftdata, ALshort **retref);

#endif

/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 *  al_fft.c
 *
 * fft mojo.
 *
 */
#include <math.h>
#include <stdio.h>
#include <sys/types.h>

#include "AL/altypes.h"
#include "al_main.h"
#include "al_fft.h"
#include "al_complex.h"
#include "al_siteconfig.h"

static void fft(unsigned int numsamps, int Inverse, ALcomplex *InOut );

/*
 *   fill len bytes retref[0..mc] with fft output of pcmdata[0..mc]
 *
 *   len needs to be a power of 2... so we should check that...right?
 */
void _alFFTSources(int mc, int len, ALshort **pcmdata, ALcomplex **retref) {
	int i, j;

	/* initialize real to pcmdata, imaginary to 0 */
	for(i = 0; i < mc; i++) {
		for(j = 0; j < len; j++) {
			retref[i][j].r = pcmdata[i][j];
			retref[i][j].i = 0;
		}

		fft(len, 0, retref[i]);
	}

	return;
}

void _alDeFFTSources(int mc, int len, ALcomplex **fftdata, ALshort **retref) {
	int i, j;

	/* initialize real to pcmdata, imaginary to 0 */
	for(j = 0; j < mc; j++) {
		fft(len, 1, fftdata[j]);

		for(i = 0; i < len; i++) {
			retref[j][i] = fftdata[j][i].r;
		}
	}

	return;
}

/*
 *
 * Based on a couple of different fft implementations.
 *
 * Mostly Don Cross's implementation of the Numerical Recipies
 * fft.  See http://www.intersrv.com/~dcross/fft.html for
 * his very informative page on fft mojo.
 *
 * Bit reversal portions from int_fft.c
 *  Written by:  Tom Roberts  11/8/89
 *  Made portable:  Malcolm Slaney 12/15/94 malcolm@interval.com
 *
 * FIXME: write integer only version
 */
static void fft(unsigned NumSamples,
    		       int InverseTransform,
                       ALcomplex *inout) {
    unsigned i, j, k, n;
    unsigned BlockSize, BlockEnd;
    double angle_numerator = 2.0 * M_PI;
    ALcomplex temp;

    unsigned int m, l, nn;

    if(InverseTransform) {
        angle_numerator = -angle_numerator;
    }

    /* decimation in time - re-order data */
    for(m = 1, j = 0, nn = NumSamples - 1; m <= NumSamples; m++) {
            l = NumSamples;
            do {
                    l >>= 1;
            } while(j + l > nn);
            j = (j & (l-1)) + l;

            if(j <= m) {
		    continue;
	    }

	    temp = inout[m];
	    inout[m] = inout[j];
	    inout[j] = temp;
    }

    /*
    **   Do the FFT itself...
    */

    BlockEnd = 1;
    for ( BlockSize = 2; BlockSize <= NumSamples; BlockSize <<= 1 )
    {
        double delta_angle = angle_numerator / (double)BlockSize;
        double sm2 = sin ( -2 * delta_angle );
        double sm1 = sin ( -delta_angle );
        double cm2 = cos ( -2 * delta_angle );
        double cm1 = cos ( -delta_angle );
        double w = 2 * cm1;
        double ar[3];
        double ai[3];

        for(i = 0; i < NumSamples; i += BlockSize ) {
            ar[2] = cm2;
            ar[1] = cm1;

            ai[2] = sm2;
            ai[1] = sm1;

            for(j = i, n = 0; n < BlockEnd; j++, n++ ) {
                ar[0] = w*ar[1] - ar[2];
                ar[2] = ar[1];
                ar[1] = ar[0];

                ai[0] = w*ai[1] - ai[2];
                ai[2] = ai[1];
                ai[1] = ai[0];

                k = j + BlockEnd;
                temp.r = ar[0]*inout[k].r - ai[0]*inout[k].i;
                temp.i = ar[0]*inout[k].i + ai[0]*inout[k].r;

		complex_sub(&inout[k], &inout[j], &temp);
		complex_add(&inout[j], &inout[j], &temp);
            }
        }

        BlockEnd = BlockSize;
    }

    /*
    **   Need to normalize if inverse transform...
    */

    if(InverseTransform) {
	double denom = 1 / (double)NumSamples;

        for(i = 0; i < NumSamples; i++ ) {
		complex_scale(&inout[i], denom);
        }
    } 
}


void _alFFTSources_Windowed(int mc, int len, int offset,
			ALshort **pcmdata, ALcomplex **retref) {
	int i, j;

	/* initialize real to pcmdata, imaginary to 0 */
	for(i = 0; i < mc; i++) {
		for(j = 0; j < len - 2 * offset; j++) {
			retref[i][j + offset].r = pcmdata[i][j];
			retref[i][j + offset].i = 0;
		}

		fft(len, 0, retref[i]);
	}

	return;

}

void _alDeFFTSources_Windowed(int mc, int len, int offset,
	ALcomplex **fftdata, ALshort **retref) {
	int i, j;

	/* initialize real to pcmdata, imaginary to 0 */
	for(j = 0; j < mc; j++) {
		fft(len, 1, fftdata[j]);

		for(i = 0; i < len - 2 * offset; i++) {
			retref[j][i] = fftdata[j][i + offset].r;
		}
	}

	return;
}

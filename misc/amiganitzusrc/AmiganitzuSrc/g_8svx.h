// g_8svx.h

#ifndef _G_8SVX_H
#define _G_8SVX_H

#include <exec/types.h>

struct sample_struct
{
	UWORD	sample_rate;
	BYTE	*data;
	ULONG	data_size;
};

struct VHDR_struct
{
	ULONG oneShotHiSamples, /* # samples in the high octave 1-shot part */
          repeatHiSamples,  /* # samples in the high octave repeat part */
          samplesPerHiCycle;/* # samples/cycle in high octave, else 0   */
    UWORD samplesPerSec;    /* data sampling rate                       */
    UBYTE ctOctave,         /* # octaves of waveforms                   */
          sCompression;     /* data compression technique used          */
    LONG volume;           /* playback volume from 0 to Unity (full
                             * volume). Map this value into the output
                             * hardware's dynamic range.  */
};

void free_sample(struct sample_struct *);
int load_sample(char *fname, struct sample_struct *);


#endif


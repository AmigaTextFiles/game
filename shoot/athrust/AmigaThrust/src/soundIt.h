/*
 * Paula SoundIt library V0.1
 * Written by Frank Wille, frank@phoenix.owl.de
 *
 * Amiga specific sound routines for Thrust,
 * based on SoundIt library 0.04,
 * Copyright 1994 Brad Pitzel  pitzel@cs.sfu.ca
 *
 */

#ifndef SOUNDIT_VERS
#define SOUNDIT_VERS "0.1 (Amiga/Paula)"


/*==========================================================================*/
typedef struct {
  unsigned char *data;  /* unsigned 8-bit raw samples (intel format) */
  int len;              /* length of sample in bytes  */
  int loop;             /* loop=0 : play sample once, */
                        /* loop=1 : loop sample       */
  unsigned char *cdata; /* signed 8-bit raw samples in Chip-RAM (Amiga) */
} Sample;


/*==========================================================================*/
/* given the name of a .raw sound file, load it into the Sample struct */ 
/* pointed to by 'sample'                                              */
int Snd_loadRawSample(const char *file, Sample *sample, int loop);


/*==========================================================================*/
/* init sound device, etc..                                                 */
/* num_snd  = the number of samples in the sample array *sa                 */
/* sa       = the sample array                                              */
/* freq     = the rate (Hz) to play back the samples                        */
/* channels = # of channels to mix (no mixing on Amiga, max. 4 channels)    */
/* sound_device = (ignored for Amiga version, always use audio.device)      */
/* returns: 0=success, -1=failure.*/
int Snd_init(int num_snd, Sample *sa, int freq, 
             int channels, const char *sound_device);


/* shutdown sample player, free mem, etc/etc..*/
int Snd_restore(void);


/* play a sound effect in the given channel 1..n*/
/* volume = integers from 0 (off) to 100 (full volume)*/
int Snd_effect(int nr, int channel);


#endif

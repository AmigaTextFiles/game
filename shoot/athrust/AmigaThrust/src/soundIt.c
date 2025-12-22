/*
 * Paula SoundIt library V0.1
 * Written by Frank Wille, frank@phoenix.owl.de
 *
 * Amiga specific sound routines for Thrust,
 * based on SoundIt library 0.04,
 * Copyright 1994 Brad Pitzel  pitzel@cs.sfu.ca
 *
 */

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include <stdio.h>
#include <stdlib.h>

#include <exec/types.h>
#include <exec/memory.h>
#include <exec/errors.h>
#include <graphics/gfxbase.h>
#include <devices/audio.h>
#include <proto/exec.h>
#include <clib/alib_protos.h>
#ifdef __PPC__
#ifdef WOS
#include <clib/powerpc_protos.h>
#else
#include <powerup/gcclib/powerup_protos.h>
#endif
#endif

#include "soundIt.h"


struct Channel {
  struct MsgPort *audmp;
  struct IOAudio *audio;
};


static Sample *sounds = NULL;         /* ptr to array of samples */
static int num_sounds = 0;            /* number of sounds in array above */
static struct Channel chans[ADHARD_CHANNELS] = { 0 };
static int num_chans = 0;
static UWORD playback_period;
static UBYTE chmask;
static struct IOAudio *aud_io = NULL;
static int audio_dev = -1;            /* 0 if audio.device is open */



static void free_chip_sample(Sample *s)
/* free Chip RAM for a single sample */
{
  if (s->cdata) {
#ifdef __PPC__
#ifdef WOS
    FreeVecPPC(s->cdata);
#else
    PPCFreeVec(s->cdata);
#endif
#else
    FreeVec(s->cdata);
#endif
    s->cdata = NULL;
  }
}


static void free_chip(void)
/* free Chip RAM for Amiga samples */
{
  int i;

  if (sounds) {
    for (i=0; i<num_sounds; free_chip_sample(&sounds[i++]));
    sounds = NULL;
    num_sounds = 0;
  }
}


static void free_sample(Sample *s)
/* free all sample buffers, remove it completely */
{
  if (s->data) {
#if 0  /* dangerous, if buffer was not assigned by Snd_loadRawSample() */
    free(s->data);
#endif
    s->data = NULL;
  }
  free_chip_sample(s);
  s->len = s->loop = 0;
}


static unsigned char *get_chip_sample(Sample *s)
/* allocate enough Chip-RAM, then convert sample to Amiga format. */
{
  unsigned char *dest,*src=s->data,*buf=NULL;
  int i = s->len;

  if (i <= 0)
    return (NULL);
#ifdef __PPC__
#ifdef WOS
  if (buf = (unsigned char *)AllocVecPPC(i,MEMF_CHIP|MEMF_PUBLIC,0)) {
#else
  if (buf = (unsigned char *)PPCAllocVec(i,MEMF_CHIP|MEMF_PUBLIC)) {
#endif
#else /* M68k */
  if (buf = (unsigned char *)AllocVec(i,MEMF_CHIP|MEMF_PUBLIC)) {
#endif
    dest = buf;
    do
      *dest++ = (*src++)-0x80;
    while (--i);
  }
  return (buf);
}


static struct IOAudio *alloc_ioaudio(void)
{
#ifdef __PPC__
#ifdef WOS
  return ((struct IOAudio *)AllocVecPPC(sizeof(struct IOAudio),
                                        MEMF_PUBLIC,0));
#else
  return ((struct IOAudio *)PPCAllocVec(sizeof(struct IOAudio),
                                        MEMF_PUBLIC));
#endif
#else /* M68k */
  return ((struct IOAudio *)AllocVec(sizeof(struct IOAudio),
                                     MEMF_PUBLIC));
#endif
}


static void free_ioaudio(struct IOAudio *ioa)
{
  int i=-1;

  if (ioa) {
    ioa->ioa_Request.io_Message.mn_Node.ln_Type = i;
    ioa->ioa_Request.io_Device = (struct Device *)i;
    ioa->ioa_Request.io_Unit = (struct Unit *)i;
#ifdef __PPC__
#ifdef WOS
    FreeVecPPC(ioa);
#else
    PPCFreeVec(ioa);
#endif
#else
    FreeVec(ioa);
#endif
  }
}


static void freechans(void)
/* free MsgPorts and IOAudios of alls channels, close audio.device */
{
  int i;

  if (audio_dev==0 && aud_io) {
    aud_io->ioa_Request.io_Unit = (struct Unit *)((1<<num_chans)-1);
    CloseDevice((struct IORequest *)aud_io);
    audio_dev = -1;
  }
  for (i=0; i<ADHARD_CHANNELS; i++) {
    if (chans[i].audio) {
      free_ioaudio(chans[i].audio);
      chans[i].audio = NULL;
    }
    if (chans[i].audmp) {
      DeletePort(chans[i].audmp);
      chans[i].audmp = NULL;
    }
  }
  num_chans = 0;
  if (aud_io) {
    free_ioaudio(aud_io);
    aud_io = NULL;
  }
}


static void stop_channel(int ch)
/* stop audio output for this channel */
{
  if (audio_dev == 0) {
    if (chans[ch].audio) {
      if (!(chans[ch].audio->ioa_Request.io_Message.mn_Node.ln_Type))
        return;
      if (!CheckIO((struct IORequest *)chans[ch].audio))
        AbortIO((struct IORequest *)chans[ch].audio);
      WaitPort(chans[ch].audmp);
      while (GetMsg(chans[ch].audmp));
    }
  }
}


/*
 * ================== PUBLIC FUNCTIONS =====================
 */


int Snd_init(int num_snd,Sample *sa,int frequency,
             int channels, const char *dev)
/* Set up sound system with number of channels and number of samples. */
/* The Sample structure must have already been initialized. */
{
  char *snderr = "Snd_init: ";
  struct GfxBase *gfxb;
  long clock;
  int i,success=0;

  Snd_restore();
  if (channels > ADHARD_CHANNELS) {
    fprintf(stderr,"%sPaula doesn't support more than %d channels.\n",
            snderr,ADHARD_CHANNELS);
    return (0);
  }
  else if (channels==0 || num_snd==0)
    return (1);
  for (i=0; i<num_snd; sa[i++].cdata = NULL);

  /* determine clock constant */
  if (gfxb = (struct GfxBase *)OpenLibrary("graphics.library",36)) {
    clock = (gfxb->DisplayFlags & PAL) ? 3546895 : 3579545;
    CloseLibrary((struct Library *)gfxb);
  }
  else {
    fprintf(stderr,"%sgraphics.library V36 required!\n",snderr);
    return (0);
  }
  playback_period = (UWORD)(clock/(long)frequency);

  for (i=0; i<channels; i++) {
    if (!(chans[i].audmp = CreatePort(NULL,0))) {
      fprintf(stderr,"%sCan't create MsgPort for channel %d.\n",snderr,i);
      freechans();
      return (0);
    }
  }
  if (aud_io = alloc_ioaudio()) {
    chmask = (1<<channels)-1;
    aud_io->ioa_Request.io_Message.mn_ReplyPort = chans[0].audmp;
    aud_io->ioa_Request.io_Message.mn_Node.ln_Pri = ADALLOC_MAXPREC;
    aud_io->ioa_Request.io_Command = ADCMD_ALLOCATE;
    aud_io->ioa_Request.io_Flags = ADIOF_NOWAIT;
    aud_io->ioa_AllocKey = 0;
    aud_io->ioa_Data = &chmask;
    aud_io->ioa_Length = 1;

    if (!(audio_dev = OpenDevice(AUDIONAME,0,
                                 (struct IORequest *)aud_io,0))) {
      success = 1;
      for (i=0; i<channels; i++) {
        /* allocate audio channels */
        if (chans[i].audio = alloc_ioaudio()) {
          *chans[i].audio = *aud_io;
          chans[i].audio->ioa_Request.io_Message.mn_ReplyPort =
                                                 chans[i].audmp;
          chans[i].audio->ioa_Request.io_Message.mn_Node.ln_Type = 0;
          chans[i].audio->ioa_Request.io_Unit = (struct Unit *)(1 << i);
        }
        else {
          fprintf(stderr,"%sCan't alloc IOAudio for channel %d.\n",snderr,i);
          success = 0;
          break;
        }
      }

      if (success) {
        num_chans = channels;
        sounds = sa;
        num_sounds = num_snd;
        for (i=0; i<num_snd; i++) {
          /* convert and allocate samples for all sounds */
          if (!(sa[i].cdata = get_chip_sample(&sa[i]))) {
            fprintf(stderr,"%sCan't alloc Chip RAM for sample %d.\n",
                    snderr,i);
            success = 0;
            break;
          }
        }
      }
    }
    else
      fprintf(stderr,"%sCan't access %s for %d channels.\n",
              snderr,AUDIONAME,channels);
  }
  else
    fprintf(stderr,"%sCan't alloc first IOAudio.\n",snderr);

  if (!success) {
    free_chip();
    freechans();
    return (0);
  }
  return (1);
}


int Snd_restore(void)
{
  int i;

  for (i=0; i<ADHARD_CHANNELS; stop_channel(i++));
  free_chip();
  freechans();
  return (0);
}


int Snd_effect(int sound_num, int channel)
{
  struct IOAudio *ioa;
  Sample *s;

  if (channel<0 || channel>=ADHARD_CHANNELS || sound_num < 0
      || sound_num >= num_sounds || audio_dev)
    return (1);
  if (sounds[sound_num].data == NULL || sounds[sound_num].cdata == NULL) {
    fprintf(stderr,"Snd_effect: Referencing NULL sound entry in "
                   "sound #%d.\n",sound_num);
    return (1);
  }

  stop_channel(channel);
  ioa = chans[channel].audio;
  s = &sounds[sound_num];
  ioa->ioa_Request.io_Command = CMD_WRITE;
  ioa->ioa_Request.io_Flags = ADIOF_PERVOL;
  ioa->ioa_Data = (UBYTE *)s->cdata;
  ioa->ioa_Length = (ULONG)s->len;
  ioa->ioa_Period = playback_period;
  ioa->ioa_Volume = 64;
  ioa->ioa_Cycles = s->loop ? 0 : 1;

  BeginIO((struct IORequest *)ioa);
  return (0);
}


int Snd_loadRawSample(const char *file, Sample *sample, int loop)
/* given the name of a .raw sound file, load it into the Sample struct */ 
/* pointed to by 'sample'                                              */
/* Returns -1 couldn't open/read file                                  */
/*         -2 couldn't alloc memory)                                   */
{
  int ret = 0;
  FILE *fp;

  free_sample(sample);
  sample->loop = loop;
  if (fp = fopen(file,"r")) {
    fseek(fp,0,SEEK_END);
    sample->len = (int)ftell(fp);
    fseek(fp,0,SEEK_SET);
    if (sample->data = (unsigned char *)malloc(sample->len)) {
      fread(sample->data,1,sample->len,fp);
      if (!(sample->cdata = get_chip_sample(sample)))
        ret = -2;
    }
    else
      ret = -2;
    fclose(fp);
  }
  else
    ret = -1;
  if (ret)
    free_sample(sample);
  return (ret);
}

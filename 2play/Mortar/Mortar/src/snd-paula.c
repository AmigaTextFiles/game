/* 
 * MORTAR
 * 
 * -- sound functions for Amiga's Paula-chip via audio.device
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1999 by Frank Wille <frank@phoenix.owl.de>
 *
 * NOTES
 * - uses only a single channel for sound samples
 * - MIDI support is missing
 * - prepared for PPC support
 */

#include <stdio.h>
#include <string.h>
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
#include "mortar.h"


struct SoundInfo {
  UBYTE *data;      /* converted data in Chip-RAM */
  ULONG length;     /* must be an even number */
  UWORD period;     /* playback period = system-clock / frequency */
  UBYTE loaded;     /* 1, when loaded */
  UBYTE reserved;
};

/* table to convert ULAW-samples into Amiga native signed 8-bit format */
static UBYTE ulaw2signed8[256] = {
  0x82,0x86,0x8a,0x8e,0x92,0x96,0x9a,0x9e,
  0xa2,0xa6,0xaa,0xae,0xb2,0xb6,0xba,0xbe,
  0xc1,0xc3,0xc5,0xc7,0xc9,0xcb,0xcd,0xcf,
  0xd1,0xd3,0xd5,0xd7,0xd9,0xdb,0xdd,0xdf,
  0xe1,0xe2,0xe3,0xe4,0xe5,0xe6,0xe7,0xe8,
  0xe9,0xea,0xeb,0xec,0xed,0xee,0xef,0xf0,
  0xf0,0xf1,0xf1,0xf2,0xf2,0xf3,0xf3,0xf4,
  0xf4,0xf5,0xf5,0xf6,0xf6,0xf7,0xf7,0xf8,
  0xf8,0xf8,0xf9,0xf9,0xf9,0xf9,0xfa,0xfa,
  0xfa,0xfa,0xfb,0xfb,0xfb,0xfb,0xfc,0xfc,
  0xfc,0xfc,0xfc,0xfc,0xfd,0xfd,0xfd,0xfd,
  0xfd,0xfd,0xfd,0xfd,0xfe,0xfe,0xfe,0xfe,
  0xfe,0xfe,0xfe,0xfe,0xfe,0xfe,0xfe,0xfe,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,
  0x7d,0x79,0x75,0x71,0x6d,0x69,0x65,0x61,
  0x5d,0x59,0x55,0x51,0x4d,0x49,0x45,0x41,
  0x3e,0x3c,0x3a,0x38,0x36,0x34,0x32,0x30,
  0x2e,0x2c,0x2a,0x28,0x26,0x24,0x22,0x20,
  0x1e,0x1d,0x1c,0x1b,0x1a,0x19,0x18,0x17,
  0x16,0x15,0x14,0x13,0x12,0x11,0x10,0x0f,
  0x0f,0x0e,0x0e,0x0d,0x0d,0x0c,0x0c,0x0b,
  0x0b,0x0a,0x0a,0x09,0x09,0x08,0x08,0x07,
  0x07,0x07,0x06,0x06,0x06,0x06,0x05,0x05,
  0x05,0x05,0x04,0x04,0x04,0x04,0x03,0x03,
  0x03,0x03,0x03,0x03,0x02,0x02,0x02,0x02,
  0x02,0x02,0x02,0x02,0x01,0x01,0x01,0x01,
  0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
};

static struct MsgPort *audport = NULL;
static struct IOAudio *audio = NULL;
static int audio_dev = -1;  /* 0, when audio.device was openend */
static long sysclock;  /* PAL or NTSC system clock */
static struct SoundInfo sound[SOUNDS];



static struct IOAudio *create_ioaudio(struct MsgPort *port)
{
  struct IOAudio *ioa = NULL;

  if (port) {
#ifdef __PPC__
#ifdef WOS
    ioa = (struct IOAudio *)AllocVecPPC(sizeof(struct IOAudio),
                                        MEMF_CLEAR|MEMF_PUBLIC,0);
#else
    ioa = (struct IOAudio *)PPCAllocVec(sizeof(struct IOAudio),
                                        MEMF_CLEAR|MEMF_PUBLIC);
#endif
#else /* M68k */
    ioa = (struct IOAudio *)AllocVec(sizeof(struct IOAudio),
                                     MEMF_CLEAR|MEMF_PUBLIC);
#endif

/*    ioa->ioa_Request.io_Message.mn_Node.ln_Type = NT_MESSAGE;*/
    ioa->ioa_Request.io_Message.mn_ReplyPort = port;
    ioa->ioa_Request.io_Message.mn_Length = sizeof(struct IOAudio);
  }
  return ioa;
}


static void delete_ioaudio(struct IOAudio *ioa)
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


static void stop_ioaudio(void)
{
  if (audio_dev==0 && audio!=NULL) {
    if (audio->ioa_Request.io_Message.mn_Node.ln_Type) {
      if (!CheckIO((struct IORequest *)audio))
        AbortIO((struct IORequest *)audio);
      WaitIO((struct IORequest *)audio);
    }
  }
}


static int alloc_sound(struct SoundInfo *snd)
{
  if (snd) {
#ifdef __PPC__
#ifdef WOS
    if (!(snd->data = (UBYTE *)AllocVecPPC(snd->length,
                                           MEMF_CHIP|MEMF_PUBLIC,0))) {
#else
    if (!(snd->data = (UBYTE *)PPCAllocVec(snd->length,
                                           MEMF_CHIP|MEMF_PUBLIC))) {
#endif
#else /* M68k */
    if (!(snd->data = (UBYTE *)AllocVec(snd->length,
                                        MEMF_CHIP|MEMF_PUBLIC))) {
#endif
      fprintf(stderr,"snd-paula.c/alloc_sound(): "
                     "Failed to allocate %lu bytes Chip RAM\n",snd->length);
    }
    else
      return 1;
  }
  return 0;
}


static void free_sound(struct SoundInfo *snd)
{
  if (snd) {
    if (snd->loaded!=0 && snd->data!=NULL && snd->length>0) {
#ifdef __PPC__
#ifdef WOS
      FreeVecPPC(snd->data);
#else
      PPCFreeVec(snd->data);
#endif
#else
      FreeVec(snd->data);
#endif
      memset(snd,0,sizeof(struct SoundInfo));
    }
  }
}


static void load_au_sample(struct SoundInfo *snd,char *name)
{
  static const char *fn = "snd-paula.c/load_au_sample(): ";
  unsigned long header[8];
  FILE *fh;

  free_sound(snd);
  if (fh = fopen(name,"r")) {
    /* read au-header */
    if (fread(header,sizeof(unsigned long),8,fh) == 8) {
      if (header[0] == 0x2e736e64) {  /* ".snd" */
        snd->period = (UWORD)(sysclock / (long)header[4]);

        /* there seem to be some au-files with wrong size information, */
        /* so better depend on real file size */
        fseek(fh,0,SEEK_END);
        snd->length = (int)ftell(fh) - 32;
        fseek(fh,32,SEEK_SET);

        if (alloc_sound(snd)) {
          /* read and convert sample data into Chip-RAM buffer */
          UBYTE idx, *p = snd->data;
          ULONG len = snd->length;

          fread(p,1,len,fh);
          while (len-- != 0) {
            idx = *p;
            *p++ = ulaw2signed8[idx];  /* convert */
          }
          snd->loaded = 1;
        }
      }
      else
        fprintf(stderr,"%s%s is no au-file in ulaw-format\n",fn,name);
    }
    else
      fprintf(stderr,"%sRead error in header of %s\n",fn,name);

    fclose(fh);
  }
  else
    fprintf(stderr,"%sCan't open %s\n",fn,name);
}


void snd_init(void)
{
  static const char *fn = "snd-paula.c/snd_init(): ";
  static UBYTE chmask[4] = { 1,2,4,8 };  /* try one of these channels */
  struct GfxBase *gfxb;
  int i;

  /* clear sound info */
  memset(sound,0,sizeof(struct SoundInfo)*SOUNDS);

  /* determine clock constant */
  if (gfxb = (struct GfxBase *)OpenLibrary("graphics.library",36)) {
    sysclock = (gfxb->DisplayFlags & PAL) ? 3546895 : 3579545;
    CloseLibrary((struct Library *)gfxb);
  }
  else {
    fprintf(stderr,"%sCan't determine clock constant,"
                   " graphics.library V36 required!\n",fn);
    return;
  }

  if (audport = CreatePort(NULL,0)) {
    if (audio = create_ioaudio(audport)) {
      audio->ioa_Request.io_Message.mn_Node.ln_Pri = ADALLOC_MAXPREC;
      audio->ioa_Request.io_Command = ADCMD_ALLOCATE;
      audio->ioa_Request.io_Flags = ADIOF_NOWAIT;
      audio->ioa_AllocKey = 0;
      audio->ioa_Data = chmask;
      audio->ioa_Length = 4;
      audio_dev = OpenDevice(AUDIONAME,0,(struct IORequest *)audio,0);
    }
    else {
      fprintf(stderr,"%sCan't allocate audio I/O block\n",fn);
      return;
    }
  }

  if (!audio_dev) {
    /* audio.device opened, load and convert samples */
    char path[256], name[] = "sample_a", *str;

    audio->ioa_Request.io_Message.mn_Node.ln_Type = 0;
    printf("%s initialized, loading sounds\n",AUDIONAME);
    for (i=0; i<SOUNDS; i++) {
      name[7] = 'a' + i;
      if (str = get_string(name)) {
        sprintf(path,"snd/%s",str);
        load_au_sample(&sound[i],path);
      }
    }
  }
  else {
    fprintf(stderr,"%sUnable to get a free channel from %s\n",fn,AUDIONAME);
    return;
  }
}


void snd_exit(void)
{
  int i;

  if (audio) {
    if (!audio_dev) {
      stop_ioaudio();
      CloseDevice((struct IORequest *)audio);
      audio_dev = -1;
    }
    delete_ioaudio(audio);
  }
  if (audport) {
    DeletePort(audport);
    audport = NULL;
  }

  for (i=0; i<SOUNDS; i++)
    free_sound(&sound[i]);
}


void snd_play(int idx)
{
  struct SoundInfo *snd;

#ifdef DEBUG
  if (idx < 0 || idx >= SOUNDS) {
    snd_exit();
    win_exit();
    fprintf(stderr, "snd-paula.c/snd_play(): illegal sound ID!\n");
    exit(-1);
  }
#endif

  snd = &sound[idx];
  if (snd->loaded) {
    stop_ioaudio();
    audio->ioa_Request.io_Command = CMD_WRITE;
    audio->ioa_Request.io_Flags = ADIOF_PERVOL;
    audio->ioa_Data = snd->data;
    audio->ioa_Length = snd->length;
    audio->ioa_Period = snd->period;
    audio->ioa_Volume = 64;
    audio->ioa_Cycles = 1;
    BeginIO((struct IORequest *)audio);
  }
}


void snd_flush(void)
{
  /* called every frame */
}


void snd_sync(void)
{
  /* wait for sounds to end */
  if (audio_dev==0 && audio!=NULL) {
    if (audio->ioa_Request.io_Message.mn_Node.ln_Type) {
      WaitIO((struct IORequest *)audio);
    }
  }
}


void song_play(int idx, int times)
{
}

void song_stop(void)
{
}

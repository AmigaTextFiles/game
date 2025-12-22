/* Amiga Sound Interface for Battalion */
/* Written by Frank Wille <frank@phoenix.owl.de> in 1999 */

#include <stdio.h>
#include <string.h>
#include <exec/memory.h>
#include <exec/errors.h>
#include <graphics/gfxbase.h>
#include <devices/audio.h>
#include <proto/exec.h>
#include <clib/alib_protos.h>
#ifdef __PPC__
#include <clib/powerpc_protos.h>
#endif
#include "amigasnd.h"


struct Channel {
  struct MsgPort *audmp;
  struct IOAudio *audio;
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

static struct Channel chans[ADHARD_CHANNELS] = { 0 };
static struct IOAudio *aud_io = NULL;
static int audio_dev = -1;  /* 0, when audio.device was openend */
static long sysclock;  /* PAL or NTSC system clock */
static int chidx = 1;  /* next free channel, max is ADHARD_CHANNELS-1 */
static struct SoundInfo *playing[ADHARD_CHANNELS] = { NULL };



static struct IOAudio *create_ioaudio(struct MsgPort *port)
{
  struct IOAudio *ioa = NULL;

#ifdef __PPC__
  ioa = (struct IOAudio *)AllocVecPPC(sizeof(struct IOAudio),
                                        MEMF_CLEAR|MEMF_PUBLIC,0);
#else /* M68k */
  ioa = (struct IOAudio *)AllocVec(sizeof(struct IOAudio),
                                     MEMF_CLEAR|MEMF_PUBLIC);
#endif

/*  ioa->ioa_Request.io_Message.mn_Node.ln_Type = NT_MESSAGE;*/
  ioa->ioa_Request.io_Message.mn_ReplyPort = port;
  ioa->ioa_Request.io_Message.mn_Length = sizeof(struct IOAudio);
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
    FreeVecPPC(ioa);
#else
    FreeVec(ioa);
#endif
  }
}


static int alloc_sound(struct SoundInfo *snd)
{
  if (snd) {
#ifdef __PPC__
    if (!(snd->data = (UBYTE *)AllocVecPPC(snd->length,
                                           MEMF_CHIP|MEMF_PUBLIC,0))) {
#else /* M68k */
    if (!(snd->data = (UBYTE *)AllocVec(snd->length,
                                        MEMF_CHIP|MEMF_PUBLIC))) {
#endif
      printf("alloc_sound(): Failed to allocate %lu bytes Chip RAM\n",
             snd->length);
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
      FreeVecPPC(snd->data);
#else
      FreeVec(snd->data);
#endif
      memset(snd,0,sizeof(struct SoundInfo));
    }
  }
}


static void stop_channel(int ch)
/* stop audio output for this channel */
{
  if (audio_dev == 0) {
    if (chans[ch].audio) {
      if (chans[ch].audio->ioa_Request.io_Message.mn_Node.ln_Type) {
        if (!CheckIO((struct IORequest *)chans[ch].audio))
          AbortIO((struct IORequest *)chans[ch].audio);
        WaitIO((struct IORequest *)chans[ch].audio);
      }
    }
  }
}


static void freechans(void)
/* free MsgPorts and IOAudios of alls channels, close audio.device */
{
  int i;

  if (audio_dev==0 && aud_io) {
    aud_io->ioa_Request.io_Unit = (struct Unit *)((1<<ADHARD_CHANNELS)-1);
    CloseDevice((struct IORequest *)aud_io);
    audio_dev = -1;
  }
  for (i=0; i<ADHARD_CHANNELS; i++) {
    if (chans[i].audio) {
      delete_ioaudio(chans[i].audio);
      chans[i].audio = NULL;
    }
    if (chans[i].audmp) {
      DeletePort(chans[i].audmp);
      chans[i].audmp = NULL;
    }
  }
  if (aud_io) {
    delete_ioaudio(aud_io);
    aud_io = NULL;
  }
}


/*
** PUBLIC FUNCTIONS
*/

int amigasnd_init(void)
{
  static const char *fn = "amigasnd_init(): ";
  static UBYTE chmask = (1<<ADHARD_CHANNELS)-1;
  struct GfxBase *gfxb;
  int i;

  /* determine clock constant */
  if (gfxb = (struct GfxBase *)OpenLibrary("graphics.library",36)) {
    sysclock = (gfxb->DisplayFlags & PAL) ? 3546895 : 3579545;
    CloseLibrary((struct Library *)gfxb);
  }
  else {
    printf("%sCan't determine clock constant,"
           " graphics.library V36 required!\n",fn);
    return (0);
  }

  /* create MsgPorts */
  for (i=0; i<ADHARD_CHANNELS; i++) {
    if (!(chans[i].audmp = CreatePort(NULL,0))) {
      printf("%sCan't create MsgPort for channel %d.\n",fn,i);
      freechans();
      return (0);
    }
  }

  if (aud_io = create_ioaudio(chans[0].audmp)) {
    aud_io->ioa_Request.io_Message.mn_Node.ln_Pri = ADALLOC_MAXPREC;
    aud_io->ioa_Request.io_Command = ADCMD_ALLOCATE;
    aud_io->ioa_Request.io_Flags = ADIOF_NOWAIT;
    aud_io->ioa_AllocKey = 0;
    aud_io->ioa_Data = &chmask;
    aud_io->ioa_Length = 1;
    audio_dev = OpenDevice(AUDIONAME,0,(struct IORequest *)aud_io,0);
  }
  else {
    printf("%sCan't allocate audio I/O block\n",fn);
    freechans();
    return (0);
  }
  if (audio_dev) {
    printf("%sUnable to get all channels from %s\n",fn,AUDIONAME);
    freechans();
    return (0);
  }

  for (i=0; i<ADHARD_CHANNELS; i++) {
    /* allocate audio channels */
    if (chans[i].audio = create_ioaudio(NULL)) {
      *chans[i].audio = *aud_io;
      chans[i].audio->ioa_Request.io_Message.mn_ReplyPort = chans[i].audmp;
      chans[i].audio->ioa_Request.io_Message.mn_Node.ln_Type = 0;
      chans[i].audio->ioa_Request.io_Unit = (struct Unit *)(1 << i);
      playing[i] = NULL;  /* sound, which is currently played here */
    }
    else {
      printf("%sCan't alloc IOAudio for channel %d.\n",fn,i);
      freechans();
      return (0);
    }
  }

  return (1);
}


void amigasnd_exit(void)
{
  int i;

  for (i=0; i<ADHARD_CHANNELS; stop_channel(i++));
  freechans();
}


void amigasnd_loadau(struct SoundInfo *snd,char *name)
{
  static const char *fn = "amigasnd_loadau: ";
  unsigned long header[8];
  FILE *fh;

  free_sound(snd);
  if (fh = fopen(name,"r")) {
    /* read au-header */
    if (fread(header,sizeof(unsigned long),8,fh) == 8) {
      if (header[0] == 0x2e736e64) {  /* ".snd" */
        snd->period = (UWORD)(sysclock / (long)header[4]);
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
        printf("%s%s is no au-file in ulaw-format\n",fn,name);
    }
    else
      printf("%sRead error in header of %s\n",fn,name);

    fclose(fh);
  }
  else
    printf("%sCan't open %s\n",fn,name);
}


void amigasnd_free(struct SoundInfo *snd)
{
  int i;

  for (i=0; i<ADHARD_CHANNELS; i++) {
    if (playing[i] == snd)
      stop_channel(i);
  }
  free_sound(snd);
}


void amigasnd_play(struct SoundInfo *snd,int ch)
{
  struct IOAudio *ioa;

  if (ch>=0 && ch<ADHARD_CHANNELS && snd->loaded) {
    stop_channel(ch);
    ioa = chans[ch].audio;
    ioa->ioa_Request.io_Command = CMD_WRITE;
    ioa->ioa_Request.io_Flags = ADIOF_PERVOL;
    ioa->ioa_Data = snd->data;
    ioa->ioa_Length = snd->length;
    ioa->ioa_Period = snd->period;
    ioa->ioa_Volume = 64;
    ioa->ioa_Cycles = 1;
    BeginIO((struct IORequest *)ioa);
  }
}


int amigasnd_getchannels(void)
{
  return (ADHARD_CHANNELS);
}


#if 0
void snd_sync(void)
{
  /* wait for sounds to end */
  if (audio_dev==0 && audio!=NULL) {
    if (audio->ioa_Request.io_Message.mn_Node.ln_Type) {
      WaitIO((struct IORequest *)audio);
    }
  }
}
#endif

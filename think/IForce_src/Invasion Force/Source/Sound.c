/****************************   Sound.c   *********************************

    Sound is copyright (c) 1988 by Richard Lee Stockton, 21305 60th Ave W.,
Mountlake Terrace, Washington 98043, 206/776-1253(voice), but may be freely
distributed as long as no profit is made from its distribution or sale
without my written permission. I call this concept 'FreeWare', you can
call it whatcha want.

Hacked to death by Alan Bland, bears little resemblance to the original
sound.c.

Extensively modified by Tony Belding for use with linked samples.

**************************************************************************/

#include <exec/types.h>
#include <exec/memory.h>
#include <libraries/dosextens.h>
#include <devices/audio.h>
#include <string.h>

#include <proto/exec.h>

#include "Sound.H"
#include "sound_protos.h"
#include "main_menu_protos.h"  /* for print() prototype */
#include "Utils_protos.h"      /* for FLength() */

#define BUFSIZE 1024L

/* This array defines all the possible sounds */

struct SoundData sdata[MAX_SOUNDS];

struct IOAudio  *sound[4] = {NULL,NULL,NULL,NULL};
UBYTE   sunit[4]={12,10,5,3};
BOOL    device_open=FALSE;

BOOL toggle=FALSE;
unsigned short playflags=0;

/*
   The flag value "device_open" tracks the status of the audio
   device.  This can also be used by the application to determine
   whether the audio channels were successfully opened.
*/

/*********** quit, give-up, go home, finish... Neatness counts! ******/

void freeSounds()
{
   short k;

   /*
      The flag "device_open" is a kluge value which lets me know if
      the device was ever successfully opened.  If it was, the first
      order of business here is to close it.  If it was not opened,
      however, trying to close it would GURU us!
   */
   if (device_open) {
      if(sound[0]) {    /* This cleans up the audio device stuff */
         for(k=3;k>(-1);k--)
            if(sound[k])
               AbortIO((struct IORequest *)sound[k]);

         if(sound[0]->ioa_Request.io_Device)
            CloseDevice((struct IORequest *)sound[0]);
         device_open = FALSE;
      }

      for(k=3;k>(-1);k--) {
         if(sound[k]->ioa_Request.io_Message.mn_ReplyPort)
            DeletePort(sound[k]->ioa_Request.io_Message.mn_ReplyPort);
      }

      for(k=3;k>(-1);k--) {
         if(sound[k])
            FreeMem(sound[k],(long)sizeof(struct IOAudio));
      }
      sound[0]=NULL;
   }

   /* Unload all sounds. */
   for (k=0; k<MAX_SOUNDS; k++)
      if (sdata[k].iffraw) {
         FreeVec(sdata[k].iffraw);
         sdata[k].iffraw = NULL;
      }

   return;
}


/*  Don't Allocate if Low Mem - by Bryce Nesbitt  */
/* Aberations by RLS. 4096 should be fudge enough */

char *SafeAllocMem(size,flags)
long size, flags;
{
   register char *p;

   if(p=(char *)AllocMem(size,flags))
      if(AvailMem(MEMF_CHIP)<4096L)
         { FreeMem(p,size);  return(NULL); }
   return(p);
}


/******** pre-parses IFF data ********/


/*
   Load IFF-8SVX data from a file and pre-parse it.
   The input "source" is the filename to read data from,
   and the input "sd" is a pointer to the SoundData
   structure that needs to be filled in..
*/

void loadSound(source, sd)
char *source;
struct SoundData *sd;
{
   long i, j, sstart;
   char string[5];
   char *raw=NULL;

   /* If there's a sound already loaded here, we'll unload it first. */
   if (sd->iffraw) {
      FreeVec(sd->iffraw);
      sd->iffraw = NULL;
   }

   /* Now do all the file-reading stuff. */
   {
      long flen;
      BPTR infile;

      /* See if the file is present, and how big. */
      flen = FLength(source);
      if (flen<0)
         return;  /* no file found */

      /* Allocate chip RAM for it. */
      raw = AllocVec(flen,MEMF_CHIP);
      if (raw==NULL)
         return;  /* no chip RAM available for us */

      /* Read the file. */
      infile = Open(source,MODE_OLDFILE);
      if (infile==NULL)
         return;  /* for some reason we couldn't open it */
      if (Read(infile,raw,flen)!=flen) {
         Close(infile);
         return;  /* unable to read file correctly */
      }
      Close(infile);
   }

   /* remember location of "raw" so it can be de-allocated later */
   sd->iffraw = raw;

   /* Set defaults if not found in IFF file */
   sd->stereo = FALSE;
   sd->sactual = 0L;

   /* Check for and parse IFF data in first 256 bytes of file */
   for(sstart=0L, sd->sps=0L, i=0L; i<252L; i+=4L) {
      strncpy(string,raw+i,4);
      string[4]=NULL;
      if(!(strcmp(string,"VHDR"))) {    /* get samples per second */
         for(j=0; j<(long)((UBYTE)raw[i+20]); j++)
            sd->sps += 256L;
         sd->sps += ((UBYTE)raw[i+21L]);
      }
      if(!(strcmp(string,"CHAN"))) {    /* Channel Assignment */
         if((raw[i+7]==6)||(raw[i+11]==6))
            sd->stereo = TRUE;
      }
      if(!(strcmp(string,"BODY"))) {    /* get size of sound data */
         for(j=0; j<4; j++)
            sd->sactual += (((UBYTE)raw[i+7L-j])<<(8*j));
         sstart = i+8L;   i = 252L;
      }

      /* set beginning of sample location */
      sd->sbuffer = raw+sstart;
   }
}


void initSoundMem()
{
   short  k;

   /* Allocate the needed device structures.  Ports and   */
   /* Audio Request Structures do NOT require CHIP memory */
   for(k=0;k<4;k++) {

      if(!(sound[k]=(struct IOAudio *)SafeAllocMem((long)sizeof(struct IOAudio),MEMF_CLEAR|MEMF_PUBLIC))) {
         freeSounds();    /* No IOA Memory! */
         return;
      }
   }
   if(
       (!(sound[0]->ioa_Request.io_Message.mn_ReplyPort =
           (struct MsgPort *) CreatePort("Sound0",0L))) ||
       (!(sound[1]->ioa_Request.io_Message.mn_ReplyPort =
           (struct MsgPort *) CreatePort("Sound1",0L))) ||
       (!(sound[2]->ioa_Request.io_Message.mn_ReplyPort =
           (struct MsgPort *) CreatePort("Sound2",0L))) ||
       (!(sound[3]->ioa_Request.io_Message.mn_ReplyPort =
           (struct MsgPort *) CreatePort("Sound3",0L))) ) {
                freeSounds();  /* No Port Memory! */
                return;
   }

   /* Open Audio using the first IOAudio as the 'initializer' request */
   sound[0]->ioa_Request.io_Message.mn_Node.ln_Pri = 20;
   sound[0]->ioa_Data   = &sunit[0];
   sound[0]->ioa_Length = 4L;
   if((OpenDevice(AUDIONAME,0L,(struct IORequest *)sound[0],0L))!=NULL) {
      freeSounds();  /* Unable to open audio device. */
      return;
   }
   device_open = TRUE;

   /* Set all IOAudios. */
   for(k=0;k<4;k++) {
      sound[k]->ioa_Request.io_Message.mn_Node.ln_Pri = 20;
      sound[k]->ioa_Request.io_Command = CMD_WRITE;
      sound[k]->ioa_Request.io_Flags   = ADIOF_PERVOL;

      /* Note copies of Device & AllocKey from initializer. */
      sound[k]->ioa_Request.io_Device  = sound[0]->ioa_Request.io_Device;
      sound[k]->ioa_AllocKey  = sound[0]->ioa_AllocKey;

      /* One time through this BUFSIZE (or smaller) part of the whole */
      sound[k]->ioa_Cycles = 1L;
   }

   /* The compiler wants 'Unit' to be a structure, we just want to mask */
   /* into the allocated left/right channels. left=1 or 8, right=2 or 4 */
   /*        ...zap! You're a Unit structure! Feel any different?       */

   for(k=2;k>(-1);k-=2) {
      sound[k+1]->ioa_Request.io_Unit = (struct Unit *)
         ((ULONG)(sound[0]->ioa_Request.io_Unit)&6L);
      sound[k]->ioa_Request.io_Unit  = (struct Unit *)
         ((ULONG)(sound[0]->ioa_Request.io_Unit)&9L);
   }
}


/*****************  make a noise ******************/
/*             volume range  0 to 64              */

void playSound(snum, volume)
int snum, volume;
{
   LONG    dactual, dlength, remaining;
   short   k;
   int set;

   /* don't do sound if not loaded */
   if (sdata[snum].iffraw==NULL || sdata[snum].sbuffer==NULL)
      return;

   /* watch out for a volume of zero */
   if (volume==0)
      return;

   /* if device was never successfully opened, abort */
   if (device_open==FALSE)
      return;

   /*
      Decide which channels to use for this sound.
      A sound always uses two channels, one left and one right, no matter
      if it's mono or stereo.  If it's mono, it just plays the same sound
      on both channels.  The program tries to alternate between the two sets
      of left-right channels so sounds don't "stomp" upon one another.
   */
   if (toggle) {
      set = 0;
      toggle = FALSE;
   } else {
      set = 2;
      toggle = TRUE;
   }

   for (k=set; k<=(set+1); k++) {
      /* 3579547 divided by 55 = 65083, nearly the maximum Period (65535) */
      sound[k]->ioa_Period = 3579547L/sdata[snum].sps;

      /* set volume level */
      sound[k]->ioa_Volume = (long)volume;
   }

   /* If in STEREO, split file. If in MONO, 'b' buffers use 'a' data */
   if(sdata[snum].stereo)
      remaining = (sdata[snum].sactual/2L)-(sdata[snum].sactual&1L);
   else {
      remaining = sdata[snum].sactual;
      sound[set]->ioa_Data = sdata[snum].sbuffer;
      sound[set+1]->ioa_Data = sdata[snum].sbuffer;
   }

   /* dactual is the length of one channel's complete data */
   dactual = remaining;

   /* be CERTAIN ioa_Length is an even number & set datalength */
   dlength = remaining;   dlength -= (dlength&1L);

   /* Left and Right Lengths are the same, no matter what! */
   sound[set]->ioa_Length = sound[set+1]->ioa_Length = dlength;

   /* make sure there's not already a sound playing on these channels */
   if (playflags & (1<<set)) {
      WaitPort(sound[set]->ioa_Request.io_Message.mn_ReplyPort);
      (void)GetMsg(sound[set]->ioa_Request.io_Message.mn_ReplyPort);
      playflags &= ~(1<<set);
   }
   if (playflags & (1<<(set+1))) {
      WaitPort(sound[set+1]->ioa_Request.io_Message.mn_ReplyPort);
      (void)GetMsg(sound[set+1]->ioa_Request.io_Message.mn_ReplyPort);
      playflags &= ~(1<<(set+1));
   }

   /* Start one set of Left/Right Channels. */
   BeginIO((struct IORequest *)sound[set]);
   BeginIO((struct IORequest *)sound[set+1]);
   playflags |= (1<<set);
   playflags |= (1<<(set+1));
}


/******** initialize everything ********/

void initSounds()
{
   int k=0;

   /* Load 'em up! */
   for (;k<MAX_SOUNDS;k++)
      loadSound(current_sound[k],&sdata[k]);

   /* Setup chip buffers and I/O structures */
   initSoundMem();
}

/* END OF LISTING */

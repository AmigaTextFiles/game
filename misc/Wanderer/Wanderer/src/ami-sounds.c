#ifdef AMIGA

/****************************   Sound.c   *********************************

    Sound is copyright (c) 1988 by Richard Lee Stockton, 21305 60th Ave W.,
Mountlake Terrace, Washington 98043, 206/776-1253(voice), but may be freely
distributed as long as no profit is made from its distribution or sale
without my written permission. I call this concept 'FreeWare', you can
call it whatcha want.

Hacked to death by Alan Bland, bears little resemblance to the original
sound.c.

**************************************************************************/

#include <exec/types.h>
#include <exec/memory.h>
#include <libraries/dosextens.h>
#include <devices/audio.h>
#include <string.h>
#include "sounds.h"

/* We'll need 4 buffers in CHIP memory, all else in FAST, if ya got it */

#define  BUFSIZE  1024L

/* This array defines all the possible sounds */

struct SoundData {
	long	sps;
	BOOL	stereo;
	long	sactual;
	char	*sbuffer;
} sdata[MAX_SOUNDS];

struct IOAudio	*sound[4]={NULL,NULL,NULL,NULL};
UBYTE	sunit[4]={12,10,5,3};
long	templength;
char	*tempbuffer=NULL, *cbuf[4]={NULL,NULL,NULL,NULL};

/*********** quit, give-up, go home, finish... Neatness counts! ******/

void freeSounds(string)
char    *string;
{
   short   k;

   if(sound[0])      /* This cleans up the audio device stuff */
   {
      for(k=3;k>(-1);k--)    if(sound[k]) AbortIO(sound[k]);
      if(sound[0]->ioa_Request.io_Device) CloseDevice(sound[0]);
      for(k=3;k>(-1);k--)
      {
         if(sound[k]->ioa_Request.io_Message.mn_ReplyPort)
            DeletePort(sound[k]->ioa_Request.io_Message.mn_ReplyPort);
      }
      for(k=3;k>(-1);k--)
      {
         if(sound[k]) FreeMem(sound[k],(long)sizeof(struct IOAudio));
         if(cbuf[k])  FreeMem(cbuf[k],BUFSIZE);
      }
      sound[0]=NULL;
   }

  if (string != NULL)
  {
	fatal(string);
  }

/* Get rid of all the sound data */
   for(k=0; k<MAX_SOUNDS; k++)
   {
	if (sdata[k].sbuffer)
	    FreeMem(sdata[k].sbuffer, sdata[k].sactual);
   }

/* Clean up everything else */

   if(tempbuffer)          FreeMem(tempbuffer,templength);

/* and return, caller will exit */
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


/******** Load SoundFile 'sPath' ********/

void loadSound(sPath, sd)
char    *sPath;
struct SoundData *sd;
{
   struct FileHandle    *sFile=NULL;
   struct FileInfoBlock *finfo=NULL;
   struct FileLock      *lock=NULL;
          long          i, j, sstart;
          char          string[5];

/* Set defaults if not found in IFF file */
   sd->stereo = FALSE;
   sd->sactual = 0L;

/* Allocate 256 bytes as work memory */

   if(!(tempbuffer=SafeAllocMem(256L,MEMF_CLEAR|MEMF_PUBLIC)))
        freeSounds("No Work Memory!");

/* Check for and parse IFF data in first 256 bytes of file */

   if(!(sFile=(struct FileHandle *)Open(sPath,MODE_OLDFILE)))
   {
/*
      char errmsg[80];
      templength=256L;
      strcpy(errmsg, "Can't open ");
      strcat(errmsg, sPath);
      freeSounds(errmsg);
*/
      /* ignore if sound file not found */
      sd->sbuffer = NULL;
      FreeMem(tempbuffer,256L); tempbuffer=NULL;
      return;
   }
   Read(sFile,tempbuffer,256L);              /* load the 1st 256 bytes */
   for(sstart=0L, sd->sps=0L, i=0L; i<252L; i+=4L)
   {
      strncpy(string,tempbuffer+i,4);   string[4]=NULL;
      if(!(strcmp(string,"VHDR")))        /* get samples per second */
      {
         for(j=0;j<(long)((UBYTE)tempbuffer[i+20]);j++) sd->sps+=256L;
         sd->sps += ((UBYTE)tempbuffer[i+21L]);
      }
      if(!(strcmp(string,"CHAN")))            /* Channel Assignment */
      {
         if((tempbuffer[i+7]==6)||(tempbuffer[i+11]==6)) sd->stereo=TRUE;
      }
      if(!(strcmp(string,"BODY")))        /* get size of sound data */
      {
         for(j=0;j<4;j++) sd->sactual+=(((UBYTE)tempbuffer[i+7L-j])<<(8*j));
         sstart = i+8L; i=252L;
      }
   }

/* if not in IFF format, get filesize from FileInfoBlock */

   if(!sd->sactual)
   {

/* Allocate a file info block, get size from it, and de-allocate */

      if((!(finfo=(struct FileInfoBlock *)
         SafeAllocMem((long)sizeof(struct FileInfoBlock),MEMF_CLEAR)))
       ||(!(lock=(struct FileLock *)Lock(sPath,ACCESS_READ)))||(!(Examine(lock,finfo))) )
                    freeSounds("FileInfoBlock Problem!");
      sd->sactual = finfo->fib_Size;      if(lock) UnLock(lock);
      if(finfo) FreeMem(finfo,(long)sizeof(struct FileInfoBlock));

/* default for non-IFF sample */
      sd->sps = 20000L;
   }

/* clean up work area */

   FreeMem(tempbuffer,256L); tempbuffer=NULL;

/* Allocate _contiguous_ memory for SOUND data. */
/* We'll transfer in BUFSIZE chunks to CHIP memory a little later. */
/* We have to do the contiguity(?) check since AllocMem() does not. */

   if((AvailMem(MEMF_LARGEST) < sd->sactual) ||
     (!(sd->sbuffer=SafeAllocMem(sd->sactual,MEMF_CLEAR|MEMF_PUBLIC))))
        { Close(sFile); freeSounds("Need Contiguous Memory!"); }

/* Load the data into sbuffer */

   Seek(sFile,sstart,OFFSET_BEGINNING);
   if((Read(sFile,sd->sbuffer,sd->sactual)) == -1L)
      { Close(sFile); freeSounds("Read Error!");}
   Close(sFile);
}

void initSoundMem()
{
    short  k;

/* Allocate sound data buffers from CHIP memory. Ports and */
/* Audio Request Structures do NOT require CHIP memory */

   for(k=0;k<4;k++)
   {
     if(!(cbuf[k]=SafeAllocMem(BUFSIZE,
           MEMF_CHIP|MEMF_CLEAR|MEMF_PUBLIC))) freeSounds("No CHIP Memory!");
     if(!(sound[k]=(struct IOAudio *)SafeAllocMem((long)sizeof(struct IOAudio),
                     MEMF_CLEAR|MEMF_PUBLIC))) freeSounds("No IOA Memory!");
   }
   if( (!(sound[0]->ioa_Request.io_Message.mn_ReplyPort =
           (struct MsgPort *) CreatePort("Sound0",0L))) ||
       (!(sound[1]->ioa_Request.io_Message.mn_ReplyPort =
           (struct MsgPort *) CreatePort("Sound1",0L))) ||
       (!(sound[2]->ioa_Request.io_Message.mn_ReplyPort =
           (struct MsgPort *) CreatePort("Sound2",0L))) ||
       (!(sound[3]->ioa_Request.io_Message.mn_ReplyPort =
           (struct MsgPort *) CreatePort("Sound3",0L))) )
		freeSounds("No Port Memory!");
   

/* Open Audio using the first IOAudio as the 'initializer' request */

   sound[0]->ioa_Request.io_Message.mn_Node.ln_Pri = 20;
   sound[0]->ioa_Data   = &sunit[0];
   sound[0]->ioa_Length = 4L;
   if((OpenDevice(AUDIONAME,0L,sound[0],0L))!=NULL)
      freeSounds("No Audio Device!");

/* Set all IOAudios. */

   for(k=0;k<4;k++)
   {
      sound[k]->ioa_Request.io_Message.mn_Node.ln_Pri = 20;
      sound[k]->ioa_Request.io_Command = CMD_WRITE;
      sound[k]->ioa_Request.io_Flags   = ADIOF_PERVOL;

/* Note copies of Device & AllocKey from initializer. */

      sound[k]->ioa_Request.io_Device  = sound[0]->ioa_Request.io_Device;
      sound[k]->ioa_AllocKey  = sound[0]->ioa_AllocKey;

/* Each IOAudio has its own CHIP buffer, Port, and Unit (left/right) */

      sound[k]->ioa_Data   = (UBYTE *)cbuf[k];

/* One time through this BUFSIZE (or smaller) part of the whole */

      sound[k]->ioa_Cycles = 1L;
   }

/* The compiler wants 'Unit' to be a structure, we just want to mask */
/* into the allocated left/right channels. left=1 or 8, right=2 or 4 */
/*        ...zap! You're a Unit structure! Feel any different?       */

   for(k=2;k>(-1);k-=2)
   {
      sound[k+1]->ioa_Request.io_Unit = (struct Unit *)
                      ((ULONG)(sound[0]->ioa_Request.io_Unit)&6L);
      sound[k]->ioa_Request.io_Unit  = (struct Unit *)
                      ((ULONG)(sound[0]->ioa_Request.io_Unit)&9L);
   }

}

/*****************  make a noise ******************/

void playSound(snum)
int snum;
{
    LONG    dactual, dlength, remaining;
    USHORT  count;
    short   k;
    long    cycles = 1;

/* don't do sound if not loaded */
    if (sdata[snum].sbuffer == NULL) return;

    for (k=0; k<4; k++)
    {

/* 3579547 divided by 55 = 65083, nearly the maximum Period (65535) */

      sound[k]->ioa_Period = 3579547L/sdata[snum].sps;

/* As LOUD as possible. Use your monitor/stereo volume. Rock 'n Roll! */

      sound[k]->ioa_Volume = 64L;
    }

/* If in STEREO, split file. If in MONO, 'b' buffers use 'a' data */

   if(sdata[snum].stereo) remaining=(sdata[snum].sactual/2L)-(sdata[snum].sactual&1L);
   else
   {
      remaining=sdata[snum].sactual;
      sound[1]->ioa_Data   = (UBYTE *)cbuf[0];
      sound[3]->ioa_Data   = (UBYTE *)cbuf[2];
   }

/* dactual is the length of one channel's complete data */

   dactual=remaining;     k=count=0;

/* we be doing loops here */

   do
   {

/* be CERTAIN ioa_Length is an even number & set datalength */

      if(remaining>BUFSIZE) dlength=BUFSIZE;
       else  { dlength=remaining;  dlength-=(dlength&1L); }

/* Move the data into the proper CHIP buffer of BUFSIZE */

      movmem(sdata[snum].sbuffer+(dactual-remaining),cbuf[k],(int)dlength);

/* Don't load or use the right CHIP buffers if MONO. Saves time. */

      if(sdata[snum].stereo) movmem(sdata[snum].sbuffer+(sdata[snum].sactual-remaining),
                        cbuf[k+1],(int)dlength);

/* Data has been moved, so adjust 'remaining' */

      remaining-=dlength;

/* Left and Right Lengths are the same, no matter what! */

      sound[k]->ioa_Length = sound[k+1]->ioa_Length = dlength;

/* Start one set of Left/Right Channels. */
      BeginIO(sound[k]);      BeginIO(sound[k+1]);

/* Is this the last time AND the last cycle? If yes & no, reset. */

      if(remaining<2L) if(--cycles!=0L)
         { remaining=dactual;   dlength=BUFSIZE; }

/* Is this the last time, or what? */

      if(remaining<2L)  WaitIO(sound[k+1]);   /* wait for LAST request */
      else
      {
         if(k) k=0; else k=2;    /* switch buffers & wait for PREVIOUS */
         if(count++)  WaitIO(sound[k+1]);
      }

/* Keep going until we run out of data */

   } while(remaining>1L);                   /* End of Loop */
}

/******** initialize everything ********/

void initSounds()
{

/* Load 'em up! */

    loadSound("sounds/death",	&sdata[DEATH_SOUND]);
    loadSound("sounds/arrow",	&sdata[ARROW_SOUND]);
    loadSound("sounds/boulder",	&sdata[BOULDER_SOUND]);
    loadSound("sounds/clock",	&sdata[CLOCK_SOUND]);
    loadSound("sounds/diamond",	&sdata[DIAMOND_SOUND]);
    loadSound("sounds/deadmonster", &sdata[DEADMONSTER_SOUND]);
    loadSound("sounds/kaboom",	&sdata[KABOOM_SOUND]);
    loadSound("sounds/exit",	&sdata[EXIT_SOUND]);
    loadSound("sounds/teleport",&sdata[TELEPORT_SOUND]);
    loadSound("sounds/munch",	&sdata[MUNCH_SOUND]);
    loadSound("sounds/step",	&sdata[STEP_SOUND]);
    loadSound("sounds/cage",	&sdata[CAGE_SOUND]);
    loadSound("sounds/push",	&sdata[PUSH_SOUND]);

/* Setup chip buffers and I/O structures */

    initSoundMem();
}

#endif

/*
   Auto: cc -ps -safnps <path><file>
  */
/****************************   Sound.c   *********************************

    Sound is copyright (c) 1988 by Richard Lee Stockton, 21305 60th Ave W.,
Mountlake Terrace, Washington 98043, 206/776-1253(voice), but may be freely
distributed as long as no profit is made from its distribution or sale
without my written permission. I call this concept 'FreeWare', you can
call it whatcha want.

    I also include the source code, (Manx Aztec 5.0a), in the hope that it
will be of benefit to someone in the Amiga programming community. Feel free
to alter it at will, (but at your own risk!). I _would_ appreciate
receiving a copy of whatever it may become and it is always nice to receive
credit, (perhaps just a few lines of glowing tribute.^)

               Long Live Leo and All the Little Schwabies!

                     To Manufacture with Manx 5.0a

                        cc -ps -safnps Sound.c
                        ln +cdb Sound.o -lc16


**************************************************************************/

#include <exec/memory.h>
#include <workbench/startup.h>
#include <workbench/workbench.h>
#include <workbench/icon.h>
#include <libraries/dosextens.h>
#include <graphics/gfxbase.h>
#include <devices/audio.h>
#include <string.h>
#include <functions.h>

/* Less than WorkBench 1.2 need not apply. That's nobody, right? ;-> */

#define  REVISION   33L

/* We'll need 4 buffers in CHIP memory, all else in FAST, if ya got it */

long  BUFSIZE = 1024L;

/* A pretty little HELP message showing valid variable ranges */

/* Probably more GLOBALS than are required. 'C' is funny stuff. */
extern struct   GfxBase       *GfxBase=NULL;
       struct   IOAudio       *sound[4]={NULL,NULL,NULL,NULL};
       struct   Filehandle    *sFile=NULL;
       struct   FileLock      *lock=NULL, *savelock=NULL;
                long          sactual=0L, sstart=0L, vol=64L, fade=0L,
                               atol(), sps=0L, cycles=1L, startvol=64L,
                               endvol=64L, fadevol=0L;
                short         k=0, stereo=0, left=1, right=1, compflag=0,
                               statusline=1, direct=0;
                UBYTE         sunit[4]={12,10,5,3},
                               sunitL[2]={1,8}, sunitR[2]={2,4};
                BOOL          help=FALSE;
                char          *sbuffer=NULL,
                               *cbuf[4]={NULL,NULL,NULL,NULL},
                               *SafeAllocMem(),
                               *portname[4]={"Snd0","Snd1","Snd2","Snd3"};
                USHORT         loadSound(), soundSound();
                void           cleanup();

/*********** quit, give-up, go home, finish... Neatness counts! ******/

/* void quit(qstring)
char    *qstring;
{
   cleanup(); 
}
*/
void cleanup()
{
   if(sound[0])      /* This cleans up the audio device stuff */
   {
      for(k=3;k>(-1);k--)
      {
         if((sound[k])&&(sound[k]->ioa_Request.io_Device))
            AbortIO((struct IORequest *)sound[k]);
      }
      if(sound[0]->ioa_Request.io_Device)
         CloseDevice((struct IORequest *)sound[0]);
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
      sound[0]=sound[1]=sound[2]=NULL;
   }


/* Write any message to out. May be error or could be samples/second */
/* You'll be sorry if you try to Write(Output()) to WorkBench!  8-)  */


/* Clean up everything else */

   if(sFile)            Close((BPTR)sFile); 
   if(sbuffer)          FreeMem(sbuffer,sactual);
   if(!sound[3])        exit();
   sbuffer=NULL;   
   sactual=0L; sstart=0L; savelock=NULL; sps=0L; cycles=1L;
   lock=0L; k=0; stereo=0; left=1; right=1; startvol=endvol=vol=64L;
}

VOID
cleanupsome()
{
   if(sbuffer)          FreeMem(sbuffer,sactual);
}
/*  Don't Allocate if Low Mem - by Bryce Nesbitt  */
/* Aberations by RLS. 4096 should be fudge enough */

char *SafeAllocMem(size,flags)
long size, flags;
{
   register char *p;
   
   if(p=(char *)AllocMem(size,flags))
      if(AvailMem(MEMF_CHIP)<4096L) {FreeMem(p,size); return(NULL);}
   return(p);
}


/******** Load SoundFile 'sPath' & set cycles-sps-stereo *******/

USHORT loadSound(sPa)
char    *sPa;
{
   struct FileInfoBlock *finfo=NULL;
   struct FileLock      *lock=NULL;
          long          i, j;
          char          string[5], sPath[80];
          short         x, y, z;
/* Allocate 256 bytes as work memory */
   strcpy(sPath,sPa);
   if(!(sbuffer=SafeAllocMem(256L,MEMF_CLEAR|MEMF_PUBLIC)))
        return (20);

/* Check for and parse IFF data in first 256 bytes of file */

   if(!(sFile=(struct Filehandle *)Open(sPath,MODE_OLDFILE)))
   {
      FreeMem(sbuffer,256L);
      sactual=256L; 
      return (20);
   }
   Read((BPTR)sFile,sbuffer,256L);        /* load the 1st 256 bytes */
   for(sstart=0L, sps=0L, i=0L; i<252L; i+=4L)
   {
      strncpy(string,sbuffer+i,4);   string[4]=NULL;
      if(!(strcmp(string,"VHDR")))        /* get samples per second */
      {
         for(j=0L;j<(long)((UBYTE)sbuffer[i+20]);j++) sps+=256L;
         sps += (long)((UBYTE)sbuffer[i+21L]);
         if(sbuffer[i+23L]==1) compflag=1;
         if(sbuffer[i+27L]!=1)
            startvol=(64L*(long)(sbuffer[i+28L]*10+sbuffer[i+29L]))/100L;
      }
      if(!(strcmp(string,"CHAN")))            /* Channel Assignment */
      {
         if((sbuffer[i+7L]==6)||(sbuffer[i+11L]==6)) stereo=1;
      }
      if(!(strcmp(string,"BODY")))        /* get size of sound data */
      {
         for(j=0L;j<4L;j++)
            sactual+=(((long)((UBYTE)sbuffer[i+7L-j]))<<(8L*j));
         sstart = i+8L; i=252L;
      }
   }


   FreeMem(sbuffer,256L); sbuffer=NULL;

/* Allocate memory for SOUND data. */
/* Later we'll transfer in BUFSIZE chunks to contiguous CHIP memory. */

   if(AvailMem(MEMF_LARGEST)<(sactual+16384L)) direct=1;
   if(direct) return(0);
   if(!(sbuffer=SafeAllocMem(sactual,MEMF_CLEAR|MEMF_PUBLIC)))
        return (20);

/* Load the data into sbuffer */

   Seek((BPTR)sFile,sstart,OFFSET_BEGINNING);
   if((Read((BPTR)sFile,sbuffer,sactual)) == -1L) 
     return (20);
   Close((BPTR)sFile);  sFile=NULL;
   return (0);

}


/*****************  make a noise ******************/

USHORT soundSound()
{
    ULONG   class;
    LONG    h, i, j, dactual, dlength, remaining;
    USHORT  code, count;
    short   z;

/* Make sure we have valid values before 'sounding' */

    if(left==right) left=right=1;
    if((sps<56L)||(sps>65534L)) sps=10000L;
    if((startvol<1L)||(startvol>64L)) startvol=64L;
    vol=startvol;
    if((endvol<1L)||(endvol>64L)) endvol=64L;
    if(direct)
    {
       BUFSIZE=AvailMem(MEMF_CHIP|MEMF_LARGEST)/6L;
       if(BUFSIZE>64000L) BUFSIZE=64000L;
       BUFSIZE-=(BUFSIZE%8L);
    }

    cycles = 1;
/* Put up a 'status' window on the top line. */

/* Allocate sound data buffers from CHIP memory. Ports and */
/* Audio Request Structures do NOT require CHIP memory */

   for(k=0;k<4;k++)
   {
     if(!(cbuf[k]=SafeAllocMem(BUFSIZE,
           MEMF_CHIP|MEMF_CLEAR|MEMF_PUBLIC))) 
           return (20);
     if(!(sound[k]=(struct IOAudio *)SafeAllocMem((long)sizeof(struct IOAudio),
                     MEMF_CLEAR|MEMF_PUBLIC))) 
                     return (20);
     if(!(sound[k]->ioa_Request.io_Message.mn_ReplyPort =
                  CreatePort(portname[k],0L))) 
                     return (20);
   }

/* Open Audio using the first IOAudio as the 'initializer' request */

   sound[0]->ioa_Request.io_Message.mn_Node.ln_Pri = 114;
   if(!right) sound[0]->ioa_Data   = &sunitL[0];
   else if(!left) sound[0]->ioa_Data   = &sunitR[0];
   else sound[0]->ioa_Data   = &sunit[0];
   sound[0]->ioa_Length = 4L;
   if((OpenDevice(AUDIONAME,0L,(struct IORequest *)sound[0],0L))!=NULL)
   {
      sound[0]->ioa_Request.io_Device=NULL;  /* don't AbortIO if no open */
      return (20);
   }

/* Set all IOAudios. */

   for(k=0;k<4;k++)
   {
      sound[k]->ioa_Request.io_Message.mn_Node.ln_Pri = 114;
      sound[k]->ioa_Request.io_Command = CMD_WRITE;
      sound[k]->ioa_Request.io_Flags   = ADIOF_PERVOL;

/* Note copies of Device & AllocKey from initializer. */

      sound[k]->ioa_Request.io_Device  = sound[0]->ioa_Request.io_Device;
      sound[k]->ioa_AllocKey  = sound[0]->ioa_AllocKey;

/* Each IOAudio has its own CHIP buffer, Port, and Unit (left/right) */

      sound[k]->ioa_Data   = (UBYTE *)cbuf[k];

/* 3579547 divided by 55 = 65083, nearly the maximum Period (65535)  */
/* changing this 'magic' number is all we need to make it 'European' */

      if(GfxBase->DisplayFlags&PAL) sound[k]->ioa_Period=3546895L/sps;
                               else sound[k]->ioa_Period=3579547L/sps;

/* allow for volume setting. gives us effect possibilities in a script */

      sound[k]->ioa_Volume = startvol;

/* One time through this BUFSIZE (or smaller) part of the whole */

      sound[k]->ioa_Cycles = 1L;
   }

/* The compiler wants 'Unit' to be a structure, we just want to mask */
/* into the allocated left/right channels. left=1 or 8, right=2 or 4 */
/*        ...zap! You're a Unit structure! Feel any different?       */

   for(k=2;k>(-1);k-=2)
   {
      if(right) sound[k+1]->ioa_Request.io_Unit = (struct Unit *)
                      ((ULONG)(sound[0]->ioa_Request.io_Unit)&6L);
      if(left)    sound[k]->ioa_Request.io_Unit  = (struct Unit *)
                      ((ULONG)(sound[0]->ioa_Request.io_Unit)&9L);
   }

/* If in STEREO, split file. If in MONO, 'b' buffers use 'a' data */

   if(stereo) remaining=(sactual/2L)-(sactual&1L);
   else
   {
      remaining=sactual;
      sound[1]->ioa_Data   = (UBYTE *)cbuf[0];
      sound[3]->ioa_Data   = (UBYTE *)cbuf[2];
   }

/* dactual is the length of one channel's complete data */

   dactual=remaining;     k=count=0;

/* if DIRECT_FROM_DISK, start at the beginning of the sample */


/* we be doing loops here */

   do
   {

/* be CERTAIN ioa_Length is an even number & set datalength */

      if(remaining>BUFSIZE) dlength=BUFSIZE;
      else {dlength=remaining; dlength-=(dlength&1L);}

/* Move the data into the proper CHIP buffer of BUFSIZE */

    movmem(sbuffer+(dactual-remaining),cbuf[k],(int)dlength);

/* Don't load or use the right CHIP buffers if MONO. Saves time. */

      if(stereo)
         movmem(sbuffer+(sactual-remaining),cbuf[k+1],(int)dlength);

/* Data has been moved, so adjust 'remaining' */

      remaining-=dlength;

/* Left and Right Lengths are the same, no matter what! */

      sound[k]->ioa_Length = sound[k+1]->ioa_Length = dlength;

/* Start one set of Left/Right Channels. */

      if(left)  BeginIO((struct IORequest *)sound[k]);
      if(right) BeginIO((struct IORequest *)sound[k+1]);


/* Is this the last time AND the last cycle? If yes & no, reset. */

      if(remaining<2L)
      {
         cycles--;
         if(cycles!=0L)
         {
            if(direct) Seek((BPTR)sFile,sstart,OFFSET_BEGINNING);
            remaining=dactual; dlength=BUFSIZE;
            if(fadevol!=0L)
            {
               vol=vol+fadevol;
            }
         }
      }
      if(vol>64L) vol=64L;  if(vol<1L) vol=1L;
      for(i=0L;(i<4L)&&(vol>=0L);i++) sound[i]->ioa_Volume = vol;

/* Is this the last time, or what? */

      if(remaining<2L)
         WaitIO((struct IORequest *)sound[k+right]); /* wait for LAST request */
      else
      {
         if(k) k=0; else k=2;    /* switch buffers & wait for PREVIOUS */
         if(count++) WaitIO((struct IORequest *)sound[k+right]);
      }

/* Keep going until we run out of data */

   }   while(remaining>1L); 
      for(k=3;k>(-1);k--)
      {
         if((sound[k])&&(sound[k]->ioa_Request.io_Device))
            AbortIO((struct IORequest *)sound[k]);
      }
      if(sound[0]->ioa_Request.io_Device)
         CloseDevice((struct IORequest *)sound[0]);
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
      sound[0]=sound[1]=sound[2]=NULL;
      return (0);
}


/************************** end of Sound.c ******************************/

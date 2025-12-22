/* 
Copyright (C) 1996-1997 Id Software, Inc. 
 
This program is free software; you can redistribute it and/or 
modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation; either version 2 
of the License, or (at your option) any later version. 
 
This program is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   
 
See the GNU General Public License for more details. 
 
You should have received a copy of the GNU General Public License 
along with this program; if not, write to the Free Software 
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA. 
 
*/ 

/*
**  snd_amiga.c
**
**  Paula sound driver
**
**  Written by Frank Wille <frank@phoenix.owl.de>
**
*/

#include "quakedef.h"

#pragma amiga-align
#include <exec/memory.h>
#include <exec/tasks.h>
#include <exec/interrupts.h>
#include <exec/libraries.h>
#include <devices/audio.h>
#include <clib/exec_protos.h>
#include <clib/alib_protos.h>
#include <clib/dos_protos.h>
#ifdef __PPC__
#include <clib/timer_protos.h>
#ifdef WOS
#include <clib/powerpc_protos.h>
#else
#include <powerup/gcclib/powerup_protos.h>
#endif
#endif
#pragma default-align


#define NSAMPLES 0x4000

extern long sysclock;
extern int desired_speed;
extern int FirstTime2;
extern struct Library *TimerBase;

static UBYTE *dmabuf = NULL;
static UWORD period;
static BYTE audio_dev = -1;
static float speed;
static struct MsgPort *audioport1=NULL,*audioport2=NULL;
static struct IOAudio *audio1=NULL,*audio2=NULL;
static struct Interrupt AudioInt;
static struct Interrupt *OldInt;
static short OldINTENA = 0;
struct Library *AudioBase;
static int SyncCounter=0;
static double timediff;

static struct {
  struct Library *TimerBase;
  int *FirstTime2;
  double *aud_start_time;
#ifdef __PPC__
  struct Library *MathIeeeDoubBasBase; /* offset 12 */
#endif
} IntData;

#ifdef __PPC__
extern struct Library *MathIeeeDoubBasBase;
extern qboolean no68kFPU; /* for LC040/LC060 systems */
extern void AudioIntCodeNoFPU(void);
#endif
extern void AudioIntCode(void);
void (*audintptr)(void) = AudioIntCode;


void SNDDMA_Shutdown(void)
{
  if (OldINTENA)
        *(short *)0xdff09a = (OldINTENA | 0x8000);
  if (OldInt)
        SetIntVector(7,OldInt);
  if (audio_dev == 0) {
    if (!CheckIO((struct IORequest *)audio1)) {
      AbortIO((struct IORequest *)audio1);
      WaitPort(audioport1);
      while (GetMsg(audioport1));
    }
    if (!CheckIO((struct IORequest *)audio2)) {
      AbortIO((struct IORequest *)audio2);
      WaitPort(audioport2);
      while (GetMsg(audioport2));
    }
    CloseDevice((struct IORequest *)audio1);
  }
  if (audio2)
#ifdef __PPC__
#ifdef WOS
    FreeVecPPC(audio2);
#else
    PPCFreeVec(audio2);
#endif
#else
    FreeMem(audio2,sizeof(struct IOAudio));
#endif

  if (audio1)
    DeleteIORequest((struct IORequest *)audio1);
  if (audioport2)
    DeleteMsgPort(audioport2);
  if (audioport1)
    DeleteMsgPort(audioport1);
  if (IntData.aud_start_time)
    FreeMem((void*)(IntData.aud_start_time),sizeof(double));

  if (shm)
#ifdef __PPC__
#ifdef WOS
    FreeVecPPC((void*)shm);
#else
    PPCFreeVec((void*)shm);
#endif
#else
    FreeMem((void*)shm,sizeof(dma_t));
#endif

  if (dmabuf)
    FreeMem(dmabuf,NSAMPLES);
}


qboolean SNDDMA_Init(void)
{
  int i;
  UBYTE channelalloc[2] = { 1|2, 4|8 };  /* first try ch. 0/1, then 2/3 */
  int channelnr;

  /* evaluate parameters */
  if (i = COM_CheckParm("-audspeed")) {
    period = (UWORD)(sysclock / Q_atoi(com_argv[i+1]));
  }
  else
    period = (UWORD)(sysclock / desired_speed);

#ifdef __PPC__
  if (no68kFPU)
    audintptr = AudioIntCodeNoFPU; /* use mathieeedoubbas.library */
#endif

  /* allocate dma buffer and sound structure */
  if (!(dmabuf = AllocMem(NSAMPLES,MEMF_CHIP|MEMF_PUBLIC|MEMF_CLEAR))) {
    Con_Printf("Can't allocate Paula DMA buffer");
    return (false);
  }
#ifdef __PPC__
#ifdef WOS
  if (!(shm = AllocVecPPC(sizeof(dma_t),MEMF_ANY|MEMF_CLEAR,0))) {
#else
  if (!(shm = PPCAllocVec(sizeof(dma_t),MEMF_ANY|MEMF_CLEAR))) {
#endif
#else
  if (!(shm = AllocMem(sizeof(dma_t),MEMF_ANY|MEMF_CLEAR))) {
#endif
    Con_Printf("Failed to allocate shm");
    return (false);
  }
  if (!(IntData.aud_start_time = AllocMem(sizeof(double),MEMF_CHIP|MEMF_CLEAR))) {
    Con_Printf("Failed to allocate 8 bytes of CHIP-RAM buffer");
    return (false);
  }

  /* init shm */
  shm->buffer = (unsigned char *)dmabuf;
  shm->channels = 1;
  shm->speed = sysclock/(long)period;
  shm->samplebits = 8;
  shm->samples = NSAMPLES;
  shm->submission_chunk = 1;
  speed = (float)shm->speed;


  /* open audio.device */
  if (audioport1 = CreateMsgPort()) {
    if (audioport2 = CreateMsgPort()) {
        if (audio1 = (struct IOAudio *)CreateIORequest(audioport1,
                      sizeof(struct IOAudio))) {
#ifdef __PPC__
#ifdef WOS
          if (audio2 = (struct IOAudio *)AllocVecPPC(sizeof(struct IOAudio),
                        MEMF_PUBLIC,0)) {
#else
          if (audio2 = (struct IOAudio *)PPCAllocVec(sizeof(struct IOAudio),
                        MEMF_PUBLIC)) {
#endif
#else
          if (audio2 = (struct IOAudio *)AllocMem(sizeof(struct IOAudio),
                        MEMF_PUBLIC)) {
#endif
              audio1->ioa_Request.io_Message.mn_Node.ln_Pri = ADALLOC_MAXPREC;
              audio1->ioa_Request.io_Command = ADCMD_ALLOCATE;
              audio1->ioa_Request.io_Flags = ADIOF_NOWAIT;
              audio1->ioa_AllocKey = 0;
              audio1->ioa_Data = channelalloc;
              audio1->ioa_Length = sizeof(channelalloc);
              audio_dev = OpenDevice(AUDIONAME,0,
                                     (struct IORequest *)audio1,0);
          }
        }
    }
  }

  if (audio_dev == 0) {
    /* set up audio io blocks */
    AudioBase = (struct Library *)audio1->ioa_Request.io_Device;
    audio1->ioa_Request.io_Command = CMD_WRITE;
    audio1->ioa_Request.io_Flags = ADIOF_PERVOL;
    audio1->ioa_Data = dmabuf;
    audio1->ioa_Length = NSAMPLES;
    audio1->ioa_Period = period;
    audio1->ioa_Volume = 64;
    audio1->ioa_Cycles = 0;  /* loop forever */
    *audio2 = *audio1;
    audio2->ioa_Request.io_Message.mn_ReplyPort = audioport2;
    audio1->ioa_Request.io_Unit = (struct Unit *)
                                   ((ULONG)audio1->ioa_Request.io_Unit & 9);
    audio2->ioa_Request.io_Unit = (struct Unit *)
                                   ((ULONG)audio2->ioa_Request.io_Unit & 6);

  }
  else {
    Con_Printf("Couldn't open audio.device");
    return (false);
  }
  IntData.TimerBase = TimerBase;
  IntData.FirstTime2 = &FirstTime2;
  AudioInt.is_Node.ln_Type = NT_INTERRUPT;
  AudioInt.is_Node.ln_Pri = 0;
  AudioInt.is_Data = &IntData;
  AudioInt.is_Code = (void(*)())audintptr;
  switch ((ULONG)audio1->ioa_Request.io_Unit) {
    case 1: channelnr = 0;break;
    case 2: channelnr = 1;break;
    case 4: channelnr = 2;break;
    case 8: channelnr = 3;break;
  }
  BeginIO((struct IORequest *)audio1);
  BeginIO((struct IORequest *)audio2);
  while (*(short *)0xdff01c & (0x0080 << channelnr));
  OldInt = SetIntVector(channelnr+7,&AudioInt);
  OldINTENA = *(short *)0xdff01c;
  *IntData.aud_start_time = 0;
  *(short *)0xdff09a = OldINTENA | (0xc000 | (0x0080 << channelnr));
  return (true);
}


int SNDDMA_GetDMAPos(void)
{
  int pos;
#ifdef __PPC__
  static struct timeval tv;
  double time;

  while (!(*IntData.aud_start_time));
  if (SyncCounter == 0)
  {
    GetSysTime(&tv);
    time = ((double)(tv.tv_secs-FirstTime2) + 
            (((double)tv.tv_micro) / 1000000.0));
    timediff = (Sys_DoubleTime()) - time;
  }
  SyncCounter = (SyncCounter + 1) % 50;
  pos = (int)((Sys_DoubleTime()-(*IntData.aud_start_time+timediff))*speed);

#else
  while (!(*IntData.aud_start_time));
  pos = (int)((Sys_DoubleTime()-*IntData.aud_start_time)*speed);
#endif

  if (pos >= NSAMPLES)
        pos = 0;
  return (shm->samplepos = pos);
}


void SNDDMA_Submit(void)
{
}

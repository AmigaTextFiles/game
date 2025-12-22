/*
**  AudioTest.c 0.0 (4.1.96)
*/
#include <math.h>
#include <stdio.h>

#include <exec/types.h>
#include <exec/memory.h>
#include <devices/audio.h>

#ifdef __GNUC__
extern struct Library *SysBase,*DOSBase;
#include <inline/exec.h>
#include <inline/dos.h>
#endif

struct MsgPort *AudioPort;
struct IOAudio *AudioIO,*AudioCtrl;
struct Sample { APTR Data; ULONG Length;UWORD Period; } smp;

void InitAudio()
{
 int error;
 AudioPort=CreateMsgPort();
 AudioIO=CreateIORequest(AudioPort,sizeof(struct IOAudio));

 error=OpenDevice("audio.device",0,AudioIO,0);
 Printf("OpenDevice() Error %ld\n",error);

}
void FreeAudio()
{
 if (AudioIO->ioa_Request.io_Unit!=NULL)
 {
  if(CheckIO(AudioIO))
  {
   AbortIO(AudioIO);
   WaitIO(AudioIO);
  }
  AudioIO->ioa_Request.io_Command= ADCMD_FREE;
  DoIO(AudioIO);
 }
}
void ExitAudio()
{
 FreeAudio();
 CloseDevice(AudioIO);
 DeleteIORequest(AudioIO);
 DeleteMsgPort(AudioPort);
}

UBYTE channels[]={2,4,1,8 };
void PlayAudio(struct Sample *s)
{
 APTR  *unit=&(AudioIO->ioa_Request.io_Unit);
 if(*unit==NULL)
 {
  AudioIO->ioa_Request.io_Command= ADCMD_ALLOCATE;
  AudioIO->ioa_Request.io_Flags=ADIOF_NOWAIT|IOF_QUICK;
  AudioIO->ioa_Data=channels;
  AudioIO->ioa_Length=4;

  BeginIO(AudioIO);
  WaitIO(AudioIO);
/*  DoIO(AudioIO);*/
  if(*unit==NULL)
  {
   Printf("ADCMD_ALLOCATE: Error %ld",AudioIO->ioa_Request.io_Error);
   return;
  }
 }
 AudioIO->ioa_Request.io_Command= CMD_WRITE;
 AudioIO->ioa_Request.io_Flags= ADIOF_PERVOL;

 AudioIO->ioa_Data=s->Data;
 AudioIO->ioa_Length=s->Length;
 AudioIO->ioa_Period=s->Period;
 AudioIO->ioa_Cycles=1;
 AudioIO->ioa_Volume=48;
 BeginIO(AudioIO);
}

int main(void)
{
 int i,waitmask,sig;
 BYTE *p=AllocVec(4000,MEMF_CHIP|MEMF_PUBLIC);

 smp.Data=p;
 smp.Length=4000;
 smp.Period=456;

 for(i=0;i<4000;i++) *p++= (BYTE) (( (LONG) ((double)i*sin((double)i*113)) & 0xff) -128);  /*getchar();*/
 InitAudio();
 PlayAudio(&smp);
 Printf("Blah Blah\n");
 waitmask=(1<<AudioPort->mp_SigBit) | (15 << 12);
 Printf("waitmask is %08lx\n",waitmask);
 sig=Wait(waitmask);
 Printf("got signalmask %08lx\n",sig);
 FreeAudio();
 Printf("psst\n");
 ExitAudio();
 FreeVec(smp.Data);
}

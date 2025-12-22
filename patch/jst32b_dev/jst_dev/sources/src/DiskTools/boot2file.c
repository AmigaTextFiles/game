#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

#include <dos/dos.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <exec/execbase.h>
#include <exec/libraries.h>
#include <exec/memory.h>
#include <pragmas/dos_pragmas.h>
#include <string.h>


extern struct ExecBase *SysBase;

extern APTR InitTrackDisk(ULONG);
extern void ShutTrackDisk(void);
extern void ReadDosTrack(ULONG,APTR);
extern ULONG CheckDiskIn (void);

APTR trackBuffer=0L;
FILE *f=0L;
char *charunit="DF0:";
int allocated=0,diskinit=0;

void CloseAll(char *mess)

{
if (mess) printf("** %s\n",mess);

if (diskinit) ShutTrackDisk();
if (allocated) Inhibit(charunit,FALSE);
if (trackBuffer) FreeMem(trackBuffer,512*11);
if (f) fclose(f);
exit(0);
}

void BreakHandle(int code)

{
CloseAll("User break");
}


int findArg(unsigned int argc,char ** argv,char * argstr)
{
  int argl,i;

  argl=strlen(argstr);

  for (i=0;i<argc;i++)
    if (!strncmp(argv[i],argstr,argl)) return i;

  return 0;
}


main(unsigned int argc,char ** argv)


{
  ULONG i;
  ULONG diskunit;

  signal(SIGINT,BreakHandle);

  if (argc<3) {printf("Boot2File V1.1, a boot image maker by Jean-François Fabre\nUsage : boot2file <unit number> <filename>\n");if (!argc) Delay(200);exit(0);}

  
  diskunit=(ULONG)argv[1][0]-'0';

  if ((diskunit>3)||(diskunit<0)) {printf("** Unit %d unavailable\n",diskunit);CloseAll(0);}

  charunit[2]=diskunit+'0';

  if (SysBase->LibNode.lib_Version>36)
    {
    if(Inhibit(charunit,DOSTRUE)==FALSE) CloseAll("Can't allocate device !");
    allocated=1;
    }

  InitTrackDisk(diskunit);
  diskinit=1;
  if (CheckDiskIn()) {printf("** No disk in unit %d !\n",diskunit);CloseAll(NULL);}

  f=fopen(argv[2],"wb");

  if (f==0L) {printf("Can't create file !\n");CloseAll(0);}

  trackBuffer=AllocMem(512*11,MEMF_CHIP|MEMF_CLEAR);  
  if (trackBuffer==0L) CloseAll("Can't allocate memory.");

  for (i=0;i<2;i++)
  {
    ReadDosTrack(i,trackBuffer);
    if (fwrite(trackBuffer,1,512*11,f)!=512*11) CloseAll("** Disk full !");
  }

  CloseAll(NULL);
}

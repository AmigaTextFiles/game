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
extern ULONG ReadDosTrack(ULONG,APTR);
extern ULONG CheckDiskIn (void);

APTR trackBuffer=0L;
FILE *f=0L;
char *charunit="DF0:";
int allocated=0,diskinit=0;

#define READ_DOS_TRACK(trackno) if (ReadDosTrack(trackno,trackBuffer)) printf("Warning: error track %d\n",trackno);

void CloseAll(char *mess)

{
if (mess!=NULL) printf("** %s\n",mess);

if (diskinit) ShutTrackDisk();
if (allocated) Inhibit(charunit,FALSE);
if (trackBuffer!=NULL) FreeMem(trackBuffer,512*11);
if (f!=NULL) fclose(f);
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
  ULONG i,skiprob=0;
  ULONG diskunit;
  UBYTE *sptr;
  int srarg=0,starttrack=0,endtrack=159,trackok=1;

  signal(SIGINT,BreakHandle);

  printf("\2331;37;40mDisk2File V1.3\2330;31;40m - a disk image maker by Jean-François Fabre\n");

  if (argc<3) {printf("Usage : disk2file <unit number> <filename> [starttrack] [endtrack] <SKIPROB>\n");if (!argc) Delay(200);exit(0);}

  if ((argc>3)&&(!strnicmp(argv[3],"SKIPROB",7))) {skiprob=2;srarg=3;}
  if ((argc>4)&&(!strnicmp(argv[4],"SKIPROB",7))) {skiprob=2;srarg=4;}
  if ((argc>5)&&(!strnicmp(argv[5],"SKIPROB",7))) {skiprob=2;srarg=5;}

  switch(srarg)
  {
    case 0:
		if (argc>3) starttrack=atoi(argv[3]);
		if (argc>4) endtrack=atoi(argv[4]);
	break;
    
	case 5:
		endtrack=atoi(argv[4]);
	case 4:
		starttrack=atoi(argv[3]);
		break;

   }

   if (starttrack>endtrack) trackok=0;
   if (starttrack<0) trackok=0;
   if (endtrack>159) trackok=0;

  if (!trackok) CloseAll("Bad start/end track settings!");

  diskunit=(ULONG)argv[1][0]-'0';

  if ((diskunit>3)||(diskunit<0)) {printf("** Unit %d unavailable\n",diskunit);CloseAll(0);}

  charunit[2]=diskunit+'0';

  if (SysBase->LibNode.lib_Version>36)
    {
    printf("Allocating drive...\n");
    if (Inhibit(charunit,DOSTRUE)==FALSE) CloseAll("Can't allocate device !");
    allocated=1;
    }

  if ((ULONG)InitTrackDisk(diskunit)<0) {printf("** Can't open unit %d !",diskunit);CloseAll(0);}
  diskinit=1;
  if (CheckDiskIn()) {printf("** No disk in unit %d !\n",diskunit);CloseAll(NULL);}

  f=fopen(argv[2],"wb");

  if (f==0L) {printf("Can't create file !\n");CloseAll(0);}

  trackBuffer=AllocMem(512*11,MEMF_CHIP|MEMF_CLEAR);  
  if (trackBuffer==0L) CloseAll("Can't allocate memory.");

  if (skiprob<starttrack) skiprob=starttrack;

  printf("Reading from track %d to track %d (included)...\n",starttrack,endtrack);

  if (skiprob && (starttrack<2) )
      {
        /** reads boot block **/

		READ_DOS_TRACK(0);
		
        if (fwrite(trackBuffer,1,512*11,f)!=512*11) CloseAll("Disk full !");
		printf("Skipping Track 0 Head 1\n");

	sptr=(UBYTE *)trackBuffer;

	for (i=0;i<512*11;sptr[i++]=0);

        if (fwrite(trackBuffer,1,512*11,f)!=512*11) CloseAll("Disk full !");
      }

  for (i=skiprob;i<=endtrack;i++)
      {
		READ_DOS_TRACK(i)
        if (fwrite(trackBuffer,1,512*11,f)!=512*11) CloseAll("Disk full !");
      }

  printf("Disk image successfuly written\n");
  CloseAll(NULL);
}

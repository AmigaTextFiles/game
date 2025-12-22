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

#define RAWTRACK_LEN 0x8000
#define TRACK_LEN 0x1800
#define START_TRACK 0x2
#define END_TRACK 0x2

extern struct ExecBase *SysBase;

extern APTR InitTrackDisk(ULONG);
extern void ShutTrackDisk(void);
extern ULONG CheckDiskIn (void);

extern ULONG ReadRawTrackIndex(ULONG,UBYTE *);
extern ULONG DecodeTrack(UBYTE *, UBYTE *);

UBYTE *rawTrackBuffer=0L;
UBYTE *decTrackBuffer=0L;
FILE *f=0L;
char *charunit="DF0:";
int allocated=0,diskinit=0;

void CloseAll(char *mess)

{
if (mess) printf("** %s\n",mess);

if (diskinit) ShutTrackDisk();
if (allocated) Inhibit(charunit,FALSE);
if (rawTrackBuffer) FreeMem((APTR)rawTrackBuffer,RAWTRACK_LEN);
if (decTrackBuffer) FreeMem((APTR)decTrackBuffer,TRACK_LEN);
if (f) fclose(f);
exit(0);
}

void BreakHandle(int code)

{
CloseAll("User break");
}


main(unsigned int argc,char ** argv)


{
  ULONG diskunit;
  int i,readok,retries,dcrslt;

  signal(SIGINT,BreakHandle);

  if (argc<3) {printf("PsyDir V2.1, a directory image maker by Jean-François Fabre\nUsage : psydir <unit number> <filename>\n");if (!argc) Delay(200);exit(0);}

  
  diskunit=(ULONG)argv[1][0]-'0';

  if ((diskunit>3)||(diskunit<0)) {printf("** Unit %d unavailable\n",diskunit);CloseAll(0);}

  charunit[2]=diskunit+'0';

  if (SysBase->LibNode.lib_Version>36)
    {
    if(Inhibit(charunit,DOSTRUE)==FALSE) CloseAll("Can't allocate device !");
    allocated=1;
    }

  if ((ULONG)InitTrackDisk(diskunit)<0) {printf("** Can't open unit %d !",diskunit);CloseAll(0);}
  diskinit=1;
  if (CheckDiskIn()) {printf("** No disk in unit %d !\n",diskunit);CloseAll(NULL);}

  decTrackBuffer=(char *)AllocMem(TRACK_LEN,MEMF_CLEAR);
  if (decTrackBuffer==0L) CloseAll("Can't allocate memory.");

  rawTrackBuffer=(char *)AllocMem(RAWTRACK_LEN,MEMF_CHIP|MEMF_CLEAR);
  if (rawTrackBuffer==0L) CloseAll("Can't allocate chip memory.");

  printf("Reading disk data...\n");

  f=fopen(argv[2],"wb");

  if (f==0L) {printf("Can't create file !\n");CloseAll(0);}

  for (i=START_TRACK;i<END_TRACK+1;i++)
	{
	retries=0;
	readok=0;

		do
		{
     		if (ReadRawTrackIndex(i,rawTrackBuffer))
			{
				if (retries>2) CloseAll("Low level disk read error!");
			}

	 		else
	 		{
     			dcrslt=DecodeTrack(rawTrackBuffer,decTrackBuffer);

	 			if (!dcrslt)
					{
						if (fwrite(decTrackBuffer,1,0x1000,f)!=0x1000) CloseAll("Disk full !");
						readok=1;	/* OK, next track */
					}
				else
					{
						if (retries>2)

							switch(dcrslt)
							{	
							case -1: printf("** Error Track %d\n",i);CloseAll("Decode disk read error!");
							default: printf("** Error Track %d\n",i);CloseAll("No sync found!");
							}
					}

     		}
 
	retries++;
	}
	while (!readok);


    }

 
  CloseAll(NULL);
}

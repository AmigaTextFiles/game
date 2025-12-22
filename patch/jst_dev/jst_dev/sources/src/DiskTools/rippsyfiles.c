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
#define START_TRACK 2
#define END_TRACK 159
#define NB_TRACKS END_TRACK-START_TRACK+1

extern struct ExecBase *SysBase;

extern APTR InitTrackDisk(ULONG);
extern void ShutTrackDisk(void);
extern ULONG CheckDiskIn (void);

extern ULONG ReadRawTrackIndex(ULONG,UBYTE *);
extern ULONG DecodeTrack(UBYTE *, UBYTE *);
extern ULONG WriteFiles(UBYTE *);

UBYTE *rawTrackBuffer=0L;
UBYTE *decTrackBuffer=0L;
char *charunit="DF0:";
int allocated=0,diskinit=0;
BPTR oldlock,newlock;


void CloseAll(char *mess)

{
if (mess) printf("** %s\n",mess);

if (diskinit) ShutTrackDisk();
if (allocated) Inhibit(charunit,FALSE);
if (rawTrackBuffer) FreeMem((APTR)rawTrackBuffer,RAWTRACK_LEN);
if (decTrackBuffer) FreeMem((APTR)decTrackBuffer,TRACK_LEN*NB_TRACKS);

if (newlock)
  {
  CurrentDir(oldlock);
  UnLock(newlock);
  }

exit(0);
}

void BreakHandle(int code)

{
CloseAll("User break");
}


main(unsigned int argc,char ** argv)


{
  ULONG diskunit,numid,readid;
  char strid[10];
  int i,readok,retries,dcrslt;
  char *trkptr;

  printf("RipPsyFiles V2.1, the Psygnosis disk file ripper by Jean-François Fabre\n");

  switch(argc)
   {
   case 0:
   case 1:
   case 2:
	printf("Usage : rippsyfiles <unit number> <destination-dir> [<diskid>]\n");
	if (!argc) Delay(200);
	exit(0);

   default:
	/* Try to lock the specified directory */

	newlock = Lock(argv[2],ACCESS_READ);
	if (!newlock) CloseAll("Couldn't lock destination directory");

	/* Save current directory lock */
	/* And change directory */

	oldlock = CurrentDir(newlock);
	break;
   }

  signal(SIGINT,BreakHandle);
  
  diskunit=(ULONG)argv[1][0]-'0';

  if ((diskunit>3)||(diskunit<0)) {printf("** Unit %d unavailable\n",diskunit);CloseAll(0);}

  charunit[2]=diskunit+'0';

  if (SysBase->LibNode.lib_Version>36)
    {
    if(Inhibit(charunit,DOSTRUE)==FALSE) CloseAll("Can't allocate device !");
    allocated=1;
    }

  if (argc<4) numid=0; /* no ID check */

  else
     {
     strncpy(strid,argv[3],8);
     switch(strid[0])
	{
	case '\'':
		numid=(((int)(strid[1]))<<24)+(((int)(strid[2]))<<16)+
		      (((int)(strid[3]))<<8)+((int)(strid[4]));
		break;

	default: sscanf(strid,"%x",&numid);break;

	}
     }

  if ((ULONG)InitTrackDisk(diskunit)<0) {printf("** Can't open unit %d !",diskunit);CloseAll(0);}
  diskinit=1;
  if (CheckDiskIn()) {printf("** No disk in unit %d !\n",diskunit);CloseAll(NULL);}

  decTrackBuffer=(char *)AllocMem(TRACK_LEN*NB_TRACKS,MEMF_CLEAR);
  if (decTrackBuffer==0L) CloseAll("Can't allocate memory.");

  rawTrackBuffer=(char *)AllocMem(RAWTRACK_LEN,MEMF_CHIP|MEMF_CLEAR);
  if (rawTrackBuffer==0L) CloseAll("Can't allocate chip memory.");

  trkptr=decTrackBuffer;

  printf("Reading disk data...\n");

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
     			dcrslt=DecodeTrack(rawTrackBuffer,trkptr);

	 			if (!dcrslt)
					{
						if (i==2)
						{
							/* disk ID check if specified */

							readid=(((int)(trkptr[0x10]))<<24)+(((int)(trkptr[1+0x10]))<<16)+
							      (((int)(trkptr[2+0x10]))<<8)+((int)(trkptr[3+0x10]));

							if (numid)
								{
								 if (readid!=numid) 
									CloseAll("Disk ID does not match");
								}
							else printf("DiskID : %X\n",readid);
						}

						readok=1;
						trkptr+=TRACK_LEN;
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

    switch(WriteFiles(decTrackBuffer))

	{
	case 0 : printf("Disk read successfuly!\n");CloseAll(NULL);
	case -1: CloseAll("File Creation Error");
	case -3: CloseAll("Directory Structure Error");
	case -5: CloseAll("Memory Allocation Error");
	default: CloseAll("Unknown error");
    }

}

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
#define TRACK_LEN 0x1838
#define TRACK_LEN_ALLOC 0x1850

extern struct ExecBase *SysBase;

extern APTR InitTrackDisk(ULONG);
extern void ShutTrackDisk(void);
extern ULONG CheckDiskIn (void);

extern ULONG ReadRawTrackIndex(ULONG,UBYTE *);
extern ULONG DecodeTrack(UBYTE *, UBYTE *);
UBYTE *rawTrackBuffer=0L;
UBYTE *decTrackBuffer=0L;
char *charunit="DF0:";
int allocated=0,diskinit=0;
FILE *f;

void CloseAll(char *mess)

{
if (f) fclose(f);

if (mess) printf("** %s\n",mess);

if (diskinit) ShutTrackDisk();
if (allocated) Inhibit(charunit,FALSE);
if (rawTrackBuffer) FreeMem((APTR)rawTrackBuffer,RAWTRACK_LEN);
if (decTrackBuffer) FreeMem((APTR)decTrackBuffer,TRACK_LEN_ALLOC);


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
  ULONG diskunit=0,starttrack=1,endtrack=158; /* default values */
  int i,retries,readok,dcrslt;
  char filename[108]="";

  signal(SIGINT,BreakHandle); /* CTRL-C caught */

  printf("\2331;37;40mMenace disk imager\2330;31;40m - by JF Fabre\n");

  switch(argc)

     {

	case 5:
		endtrack=atoi(argv[4]);
		if ((endtrack>159)||(endtrack<0))
			  CloseAll("StartTrack must be between 0 and 159\n");
	case 4:
		starttrack=atoi(argv[3]);
		if ((starttrack>endtrack)||(starttrack<0))
			  CloseAll("StartTrack must be between 0 and 159\n");

	case 3:
		strcpy(filename,argv[2]);
		diskunit=(ULONG)argv[1][0]-'0';
		break;
		
	default:
		printf("\nUsage : rippmdisk <unit> <filename> [<starttrack>] [<endtrack>]\n");
		printf("Defaults are:\n  StartTrack: 1\n  EndTrack: 159\n\nYou must specify a filename for the destination\n");
		if (!argc) Delay(200);
		CloseAll(0);
	}


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

  decTrackBuffer=(char *)AllocMem(TRACK_LEN_ALLOC,MEMF_CLEAR);
  if (decTrackBuffer==0L) CloseAll("Can't allocate memory.");

  rawTrackBuffer=(char *)AllocMem(RAWTRACK_LEN,MEMF_CHIP|MEMF_CLEAR);
  if (rawTrackBuffer==0L) CloseAll("Can't allocate chip memory.");

  f=fopen(filename,"wb");

  if (f==NULL) CloseAll("Can't create destination file!");

  printf("Reading disk from track %d to track %d (included)\n",starttrack,endtrack);
 
  printf("Side %d...\n",starttrack % 2);

  for (i=starttrack;i<endtrack+1;i+=2)
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
						readok=1;
						if (fwrite(decTrackBuffer,1,TRACK_LEN,f)!=TRACK_LEN) CloseAll("Disk full !");
					}

			else
					{
						if (retries>2)

							switch(dcrslt)
							{	
							case 1: printf("** Error Track %d\n",i);CloseAll("Decode disk read error!");
							case 2: printf("** Error Track %d\n",i);CloseAll("No sync found!");
							}
					}

			}

	retries++;
	}
	while (!readok);
	}

  printf("Side %d...\n",(starttrack+1) % 2);

  for (i=starttrack+1;i<endtrack+1;i+=2)
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
						readok=1;
						if (fwrite(decTrackBuffer,1,TRACK_LEN,f)!=TRACK_LEN) CloseAll("Disk full !");
					}

			else
					{
						if (retries>2)

							switch(dcrslt)
							{	
							case 1: printf("** Error Track %d\n",i);CloseAll("Decode disk read error!");
							case 2: printf("** Error Track %d\n",i);CloseAll("No sync found!");
							}
					}

			}

	retries++;
	}
	while (!readok);
	}

	printf("Disk image done\n");

	CloseAll(0);
}


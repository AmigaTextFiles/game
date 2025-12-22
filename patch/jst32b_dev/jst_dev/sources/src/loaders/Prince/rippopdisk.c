#include <stdio.h>
#include <stdlib.h>
#include <dos/dos.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <pragmas/dos_pragmas.h>

#include <exec/types.h>
#include <exec/memory.h>

extern ULONG ReadPOPSectors(char *,ULONG,ULONG);

#define Erreur() {printf("** Something went wrong !!\n");exit(1);}
#define NB_SECTORS 0x53
#define DISK_SIZE 0x1800*NB_SECTORS

main(unsigned int argc,char **argv)

{
char *buffer;
FILE *f;

if (argc==0) exit(0);

printf("Prince of Persia (shitty) disk reader (but the only one)\nCoded by JF Fabre © 1997\n");
if (argc<2) {printf("** Usage readpop <filename>\n");exit(0);}

buffer=(char *)AllocMem(DISK_SIZE,MEMF_CLEAR);

if (!buffer) {printf("** Unable to allocate memory\n");exit(1);}

printf("Reading disk. Please wait...\n");
if (ReadPOPSectors(buffer,0x1,NB_SECTORS)!=0) Erreur();
printf("Disk read\n");

if (!(f=fopen(argv[1],"wb"))) {FreeMem((APTR)buffer,DISK_SIZE);printf("** Unable to open destination file\n");exit(1);}

printf("Writing disk image...");fflush(stdout);
fwrite(buffer,DISK_SIZE,1,f);
printf("Done.\n");

fclose(f);

FreeMem((APTR)buffer,DISK_SIZE);

}

#include <exec/exec.h>
#include <dos/dos.h>
#include <powerup/gcclib/powerup_protos.h>
#include "power.h"

void *PLoadFile(char *name,unsigned int req)
{
	BPTR file;
	int length;
	APTR p;
	if(!(file=PPCOpen(name,MODE_OLDFILE)))
		return 0L;
	PPCSeek(file,0,OFFSET_END);
	length=PPCSeek(file,0,OFFSET_BEGINNING);
	if(!(p=PAllocMem(length,req)))
	{
		PPCClose(file);
		return 0L;
	}
	PPCRead(file,p,length);
	PPCClose(file);
	return p;
}

#include <exec/exec.h>
#include <powerup/gcclib/powerup_protos.h>
#include <powerup/ppclib/memory.h>
#include "power.h"

void *PAllocMem(int size,unsigned int req)
{
	unsigned int flags=MEMF_CLEAR;
	if(req&PMEMF_NOCACHE)
		flags|=MEMF_NOCACHESYNCPPC;
	return (PPCAllocVec(size,flags));
}

void PFreeMem(void *p)
{
	PPCFreeVec(p);
}

#include <exec/exec.h>
#include <powerup/ppcproto/exec.h>
#include "power.h"
#include <string.h>

//struct ExecBase *SysBase=0L;
struct IntuitionBase *IntuitionBase=0L;
struct GfxBase *GfxBase=0L;
struct Library *CyberGfxBase=0L;

int PInit(int argc,char *argv[])
{
	int i;
	//SysBase=*(struct ExecBase **)4L;
	if(!(IntuitionBase=(struct IntuitionBase *)OpenLibrary("intuition.library",39L)))
		return -1;
	if(!(GfxBase=(struct GfxBase *)OpenLibrary("graphics.library",39L)))
		return -1;
	CyberGfxBase=(struct Library *)OpenLibrary("cybergraphics.library",41L);
	for(i=1;i<argc;i++)
		if(stricmp(argv[i],"WINDOW")==0)
			PWindowMode=1L;
	return 0;
}

void PDeinit()
{
	if(IntuitionBase)
		CloseLibrary(IntuitionBase);
	if(GfxBase)
		CloseLibrary(GfxBase);
	if(CyberGfxBase)
		CloseLibrary(CyberGfxBase);
}

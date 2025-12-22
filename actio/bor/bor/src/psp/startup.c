#include "syscall.h"

extern int pgMain(int argc,char *argv);

int _start(int argc,char* argv)
{
	int tid = sceKernelCreateThread("main",pgMain,0x20,0x40000,0x80000000,0);
	sceKernelStartThread(tid,argc,argv);
	return 0;
}

#include "timer.h"
#include "syscall.h"

static int prevtick;
void timer_init(void)
{
}
void timer_exit(void)
{
}
//unsigned timer_gettime(void);
unsigned timer_getinterval(unsigned freq)
{
#define	TICKFREQ 1000000
	unsigned now = sceKernelLibcClock();
	unsigned diff = now - prevtick;
	prevtick = now;
	return diff/(TICKFREQ/freq);
}

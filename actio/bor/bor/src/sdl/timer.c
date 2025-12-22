#include "timer.h"

static long prevtick;
void timer_init(void)
{
	prevtick = SDL_GetTicks();
}
void timer_exit(void)
{
}
//unsigned timer_gettime(void);
unsigned long timer_getinterval(unsigned freq)
{
	// gettick = 1/1000
	unsigned long now = SDL_GetTicks();
	unsigned long diff = now - prevtick;
	prevtick = now;
	return diff*freq/1000;
}

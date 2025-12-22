#include "robot.h"

static Uint32 next_time = 0;

void timer_start(void)
{
	next_time = SDL_GetTicks() + TICK_INTERVAL;
}

static Sint32 time_left(void)
{
	Uint32 now;
	now = SDL_GetTicks();
	if (next_time < now)
		return -(Sint32) (now - next_time);
	else
		return (Sint32) (next_time - now);
}

int time_wait(void)
{
	Sint32 left;
	left = time_left();
	if (left < 0)
	{
		timer_start();
		return (-left + TICK_INTERVAL/2) / TICK_INTERVAL; /* ticks missed */
	}
#ifdef __WIN32
	if (left > 10) /* this is known to work on Win32 */
#else
	if (left > 20)
#endif
	{
		SDL_Delay(left);
		left = time_left();
	}
	if (left > 0)
		while (time_left() > 0) { }
	timer_start();
	return 0; /* no ticks were missed */
}

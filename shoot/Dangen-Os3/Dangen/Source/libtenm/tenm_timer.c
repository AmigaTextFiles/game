/* $Id: tenm_timer.c,v 1.64 2003/01/11 19:12:33 oohara Exp $ */

#include <stdio.h>
/* exit */
#include <stdlib.h>
#include <SDL.h>

#include "tenm_sdl_init.h"

#include "tenm_timer.h"

/* The problem of SDL timer is that its granularity is 10 ms, that is,
 * if the machine doesn't have a good hardware clock, whenever SDL_Delay()
 * returns, (SDL_GetTicks() % 10) is always same.  In this case,
 * a simple SDL_Delay(delay - (now - past)) is not enough.
 */

static Uint32 tick = 0;
static Uint32 tick_master = 0;
static int number_wait = 0;
static int clock_inaccurate = 0;

/* return 0 on success, 1 on error */
int
tenm_timer_init(int num_wait)
{
  int i;
  Uint32 tick_temp;
  Uint32 tick_now;

  /* sanity check */
  if (num_wait <= 0)
  {
    fprintf(stderr, "tenm_timer_init: strange num_wait (%d)\n", num_wait);
    return 1;
  }

  if (tenm_sdl_init(SDL_INIT_TIMER) != 0)
  {
    fprintf(stderr, "tenm_timer_init: cannot initialize SDL timer\n");
    return 1;
  }

  number_wait = num_wait;
  /* jump to another 10 ms */
  SDL_Delay(10);

  /* clock accuracy tests */
  tick_temp = SDL_GetTicks();
  SDL_Delay(1);
  tick_now  = SDL_GetTicks();
  if (tick_now < tick_temp)
  {
    fprintf(stderr, "tenm_timer_init: SDL_GetTicks ticks backward!\n");
    return 1;
  }
  if (tick_now >= tick_temp + 3)
  {
   clock_inaccurate = 1;
   tenm_timer_reset();
   return 0;
  }

  tick_temp = SDL_GetTicks();
  for (i = 0; i < 5; i++)
    SDL_Delay(1);
  tick_now  = SDL_GetTicks();
  if (tick_now < tick_temp)
  {
    fprintf(stderr, "tenm_timer_init: SDL_GetTicks ticks backward!\n");
    return 1;
  }
  if (tick_now >= tick_temp + 7)
  {
   clock_inaccurate = 1;
   tenm_timer_reset();
   return 0;
  }

  tick_temp = SDL_GetTicks();
  for (i = 0; i < 50; i++)
    SDL_Delay(1);
  tick_now  = SDL_GetTicks();
  if (tick_now < tick_temp)
  {
    fprintf(stderr, "tenm_timer_init: SDL_GetTicks ticks backward!\n");
    return 1;
  }
  if (tick_now >= tick_temp + 52)
  {
   clock_inaccurate = 1;
   tenm_timer_reset();
   return 0;
  }

  clock_inaccurate = 0;
  tenm_timer_reset();
  return 0;
}

void
tenm_timer_reset(void)
{
  tick_master = SDL_GetTicks();
  tick = tick_master;
}

/* return 0 on success, 1 on error */
int
tenm_wait_next_frame(void)
{
  Uint32 tick_now;

  tick_now = SDL_GetTicks();
  if (tick_now < tick)
  {
    fprintf(stderr, "tenm_wait_next_frame: SDL_GetTicks ticks backward!\n");
    return 1;
  }

  if (clock_inaccurate)
  {
    /* use 9 instrad of 10 here because the SDL timer is not very accurate */
    while ((tick_now < tick + number_wait * 9)
           || (tick_now + 9 < tick + number_wait * 10))
    {
      /* yes, this is stupid, but it offers maximum accuracy */
      SDL_Delay(1);
      tick_now = SDL_GetTicks();
    }
  }
  else
  {
    while (tick_now < tick + number_wait * 10)
    {
      SDL_Delay(1);
      tick_now = SDL_GetTicks();
    }
  }
  
  tick = SDL_GetTicks();

  return 0;
}

/* return average number of frames per second since tenm_timer_init() or
 * tenm_timer_reset() is called
 * return -1.0 on error */
double
tenm_calculate_fps(int frame_passed)
{
  Uint32 time_passed;

  /* sanity check */
  if (frame_passed < 0)
  {
    fprintf(stderr, "tenm_calculate_fps: "
            "negative frame_passed\n");
    return -1.0;
  }

  time_passed = SDL_GetTicks();
  if (time_passed < tick_master)
  {
    fprintf(stderr, "tenm_calculate_fps: "
            "SDL_GetTicks ticks backward!\n");
    return -1.0;
  }
  if (time_passed == tick_master)
  {
    fprintf(stderr, "tenm_calculate_fps: "
            "no time passed\n");
    return -1.0;
  }

  time_passed -= tick_master;
  return 1000.0 * ((double) frame_passed) / ((double) time_passed);
}

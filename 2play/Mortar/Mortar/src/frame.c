/* 
 * MORTAR
 * 
 * -- time frame set / get functions
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * NOTES
 * - Atari:  with MiNTlib <= PL46 you'll need to link with Kay Roemer's
 *   portlib to get sensible gettimeofday() resolution[1].  AFAIK newer
 *   versions should work better so you could just remove the ifdefs below.
 *   [1] You don't want to wait 2secs for shot to move a pixel, would you?
 */

#ifdef AMIGA
#include <devices/timer.h>
#include <proto/timer.h>
#else /* Unix */
#include <sys/time.h>
#endif
#include "mortar.h"

static struct timeval Next;

/* called to store time for frame end (= now + ms)
 */
void frame_start(long ms)
{
  int secs;

#ifdef AMIGA
  GetSysTime(&Next);
  if (ms >= 1000) {
    secs = ms / 1000;
    Next.tv_secs += (ULONG)secs;
    ms -= secs * 1000;
  }
  Next.tv_micro += (ULONG)ms * 1000L;
  if (Next.tv_micro >= 1000000L) {
    Next.tv_micro -= 1000000L;
    Next.tv_secs++;
  }
#else /* Unix */

# if defined(__atari_st__) || defined(__MINT__)
  __5ms_gettimeofday(&Next, 0);
# else
  gettimeofday(&Next, 0);
# endif
  if (ms >= 1000) {
    secs = ms / 1000;
    Next.tv_sec += secs;
    ms -= secs * 1000;
  }
  Next.tv_usec += ms * 1000L;
  if (Next.tv_usec >= 1000000L) {
    Next.tv_usec -= 1000000L;
    Next.tv_sec++;
  }
#endif
}

/* called to query how much time (ms) is left of the frame
 */
long frame_end(void)
{
  struct timeval now;
  long ms;

#ifdef AMIGA
  GetSysTime(&now);
  ms = (long)Next.tv_secs - (long)now.tv_secs;
  if (ms < 0) {
    return 0;
  }
  ms *= 1000;
  ms += ((long)Next.tv_micro - (long)now.tv_micro) / 1000;
  if (ms < 0) {
    return 0;
  }
#else /* Unix */

# if defined(__atari_st__) || defined(__MINT__)
  __5ms_gettimeofday(&now, 0);
# else
  gettimeofday(&now, 0);
# endif
  ms = Next.tv_sec - now.tv_sec;
  if (ms < 0)  {
    return 0;
  }
  ms *= 1000;
  ms += (Next.tv_usec - now.tv_usec) / 1000;
  if (ms < 0)  {
    return 0;
  }
#endif
  return ms;
}

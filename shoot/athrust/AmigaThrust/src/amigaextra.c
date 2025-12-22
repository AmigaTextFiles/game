/*
 * amigaextra.c
 * Some Unix functions emulated under AmigaOS/WarpOS
 * Written by Frank Wille, frank@phoenix.owl.de
 *
 */

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include <stdlib.h>
#include <ctype.h>

#ifdef M68k
#include <proto/dos.h>
#endif
#ifdef WOS
#include <clib/powerpc_protos.h>
#endif

static unsigned int rnd = 1;


int strcasecmp(char *str1,char *str2)
{
  while(tolower((unsigned char)*str1) == tolower((unsigned char)*str2)) {
    if(!*str1) return(0);
    str1++;str2++;
  }
  return(tolower(*(unsigned char *)str1)-tolower(*(unsigned char *)str2));
}


void usleep(unsigned long time)
{
#ifdef WOS
  WaitTime(0,time);
#else
  Delay((time+10000)/20000);
#endif
}


int random(void)
{
  return (rnd=rnd*1103515245+12345)%RAND_MAX;
}


void srandom(unsigned int seed)
{
  rnd = seed;
}

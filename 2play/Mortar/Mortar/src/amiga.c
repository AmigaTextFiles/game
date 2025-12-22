/*
 * MORTAR
 *
 * -- emulates required unix functions missing from Amiga
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1999 by Frank Wille, Eero Tamminen
 *
 * random() and srandom() are:
 * Copyright (c) 1983 Regents of the University of California.
 *
 * NOTES:
 * - implemented function:
 *   + usleep()
 *   + sleep()
 *   + chdir()
 *   + stat()
 * - init_amiga() should be called before using above functions
 *   and exit_amiga() should be called before exiting the program.
 * - maybe the required functions could check whether the initializations
 *   have been done, and if not, do them?  that way init_amiga() could
 *   be local to this file, but that wouldn't work if exit stuff
 *   is absolutely required (well, then there's the atexit()
 *   function)... ++eero
 * - (phx) init_amiga() must be called by main(), because there are other
 *   functions, which need TimerBase as well, e.g. GetSysTime().
 *   exit_amiga() will be called through atexit(), though.
 * - (phx) A better random() function (taken from NetBSD and simplified).
 */

#include <stdio.h>
#include <stdlib.h>
#include <exec/devices.h>
#include <dos/dos.h>
#include <devices/timer.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/timer.h>

#include "amiga.h"

struct Library *TimerBase = NULL;  /* timer.device */
static struct timerequest *timerio;
static struct MsgPort *timerport;
static BPTR origlock = 0;  /* original work directory's lock */



/* remove timer etc */
static int exit_amiga(void)
{
  BPTR old;

  if (TimerBase) {
    if (!CheckIO((struct IORequest *)timerio)) {
      AbortIO((struct IORequest *)timerio);
      WaitIO((struct IORequest *)timerio);
    }
    CloseDevice((struct IORequest *)timerio);
    DeleteMsgPort(timerport);
    DeleteIORequest((struct IORequest *)timerio);
  }

  if (origlock) {
    /* restore original work directory */
    if (old = CurrentDir(origlock)) {
      UnLock(old);
    }
  }
  return 1;
}


/*  initialize timer etc */
int init_amiga(void)
{
  /* initialize timer i/o */
  if (timerport = CreateMsgPort()) {
    if (timerio = (struct timerequest *)
                   CreateIORequest(timerport,sizeof(struct timerequest))) {
      if (OpenDevice(TIMERNAME,UNIT_MICROHZ,
                     (struct IORequest *)timerio,0) == 0) {
        TimerBase = (struct Library *)timerio->tr_node.io_Device;
      }
      else {
        DeleteIORequest((struct IORequest *)timerio);
        DeleteMsgPort(timerport);
      }
    }
    else
      DeleteMsgPort(timerport);
  }
  if (!TimerBase) {
    fprintf(stderr,"Can't open timer.device!\n");
    return 0;
  }
  atexit((void (*))exit_amiga);
  return 1;
}


void usleep(unsigned long timeout)
{
  timerio->tr_node.io_Command = TR_ADDREQUEST;
  timerio->tr_time.tv_secs = timeout / 1000000;
  timerio->tr_time.tv_micro = timeout % 1000000;
  SendIO((struct IORequest *)timerio);
  WaitIO((struct IORequest *)timerio);
}


unsigned int sleep(unsigned int seconds)
{
  Delay(seconds * 50);
  return 0;
}


int stat(char *name,struct stat *st)
{
  static struct FileInfoBlock fib;  /* longword aligned! */
  int rc = -1;
  BPTR lck;

  if (lck = Lock((STRPTR)name,ACCESS_READ)) {
    if (Examine(lck,&fib)) {
      st->st_size = (size_t)fib.fib_Size;
      rc = 0;
    }
    UnLock(lck);
  }
  return rc;
}


int chdir(char *path)
{
  BPTR newlock,oldlock;

  if (newlock = Lock((STRPTR)path,ACCESS_READ)) {
    if (oldlock = CurrentDir(newlock)) {
      if (!origlock)
        origlock = oldlock;
      else
        UnLock(oldlock);
    }
  }
  return 0;
}


static long randtbl[] = {
  0x9a319039, 0x32d9c024, 0x9b663182, 0x5da1f342, 0xde3b81e0, 0xdf0a6fb5,
  0xf103bc02, 0x48f340fb, 0x7449e56b, 0xbeb1dbb0, 0xab5c5918, 0x946554fd,
  0x8c2e680f, 0xeb3d799f, 0xb11ee0b7, 0x2d436b86, 0xda672e2a, 0x1588ca88,
  0xe369735d, 0x904f35f7, 0xd7158fd6, 0x6fa6f051, 0x616e6b96, 0xac94efdc,
  0x36413f93, 0xc622c298, 0xf5a42ab8, 0x8a88d77b, 0xf5ad9d0e, 0x8999220b,
  0x27fb47b9,
};
static long *fptr = &randtbl[3];
static long *rptr = &randtbl[0];
static long *state = &randtbl[0];
static long *end_ptr = &randtbl[31];


void srandom(unsigned int x)
{
  register int i, j=1;

  state[0] = x;
  for (i = 1; i < 31; i++)
    state[i] = 1103515245 * state[i - 1] + 12345;
  fptr = &state[3];
  rptr = &state[0];
  for (i = 0; i < 310; i++)
    (void)random();
}


long random(void)
{
  long i;

  *fptr += *rptr;
  i = (*fptr >> 1) & 0x7fffffff;
  if (++fptr >= end_ptr) {
    fptr = state;
    ++rptr;
  }
  else if (++rptr >= end_ptr)
    rptr = state;
  return(i);
}

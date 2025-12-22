/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * windowsthreads.h
 *
 * Windows thread backend prototypes.
 */
#ifndef WINDOWS_THREADS_H_
#define WINDOWS_THREADS_H_

#include <windows.h>

typedef HANDLE ThreadID;

extern ThreadID Windows_CreateThread(int (*fn)(void *), void *data);
extern int Windows_WaitThread(ThreadID waitfor);
extern int Windows_KillThread(ThreadID killit);
extern unsigned int Windows_SelfThread(void);
extern void Windows_ExitThread(int retval);

#endif

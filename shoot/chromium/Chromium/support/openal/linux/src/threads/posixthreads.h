/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * posixthreads.h
 *
 * Posix thread backend prototypes.
 */
#ifndef POSIX_THREADS_H_
#define POSIX_THREADS_H_

#include <pthread.h>

typedef pthread_t *ThreadID;

extern pthread_t *Posix_CreateThread(int (*fn)(void *), void *data);
extern int Posix_WaitThread(pthread_t *waitfor);
extern int Posix_KillThread(pthread_t *killit);
extern unsigned int Posix_SelfThread(void);
extern void Posix_ExitThread(int retval);
extern int Posix_AtForkThread(void (*prepare)(void),
			  void (*parent)(void),
			  void (*child)(void));
#endif

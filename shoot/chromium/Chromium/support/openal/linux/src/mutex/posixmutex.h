/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * posixmutex.h
 *
 * Header of posix mutex implementation.
 */
#ifndef POSIX_MUTEXS_H_
#define POSIX_MUTEXS_H_

#include <pthread.h>

typedef pthread_mutex_t *MutexID;

MutexID Posix_CreateMutex(void);
void Posix_DestroyMutex(MutexID mutex);
void Posix_LockMutex(MutexID mutex);
int  Posix_TryLockMutex(MutexID mutex);
void Posix_UnlockMutex(MutexID mutex);

#endif


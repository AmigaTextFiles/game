/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * windowsmutex.h
 *
 * Header of windows mutex implementation.
 */
#ifndef WINDOWS_MUTEXS_H_
#define WINDOWS_MUTEXS_H_

#include <windows.h>

typedef CRITICAL_SECTION *MutexID;

MutexID Windows_CreateMutex(void);
void Windows_DestroyMutex(MutexID mutex);
void Windows_LockMutex(MutexID mutex);
int  Windows_TryLockMutex(MutexID mutex);
void Windows_UnlockMutex(MutexID mutex);

#endif


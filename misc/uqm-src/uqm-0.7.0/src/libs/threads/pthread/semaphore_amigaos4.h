#ifndef SEMAPHORE_H
#define SEMAPHORE_H

#include <limits.h>

#define SEM_VALUE_MAX UINT_MAX

typedef struct sem_t_ *sem_t;

int sem_init(sem_t *sem, int pshared, unsigned int value);
int sem_destroy(sem_t *sem);
int sem_wait(sem_t *sem);
int sem_post(sem_t *sem);
int sem_getvalue(sem_t *sem, int *sval);

#endif


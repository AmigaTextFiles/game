#include "semaphore_amigaos4.h"
#include <pthread.h>
#include <stdlib.h>
#include <errno.h>

struct sem_t_ {
	int value;
	pthread_mutex_t mutex;
	pthread_cond_t cond;
};

int sem_init(sem_t *sem, int pshared, unsigned int value) {
	sem_t s;

	if (pshared != 0) {
		errno = EPERM;
		return -1;
	}

	if (value > (unsigned int)SEM_VALUE_MAX) {
		errno =  EINVAL;
		return -1;
	}

	s = calloc(1, sizeof(*s));
	if (s == NULL) {
		errno = ENOMEM;
		return -1;
	}

	s->value = value;

	if (pthread_mutex_init(&s->mutex, NULL) != 0) {
		free(s);
		errno = ENOMEM;
		return -1;
	}

	if (pthread_cond_init(&s->cond, NULL) != 0) {
		pthread_mutex_destroy(&s->mutex);
		free(s);
		errno = ENOMEM;
		return -1;
	}

	*sem = s;

	return 0;
}

int sem_destroy(sem_t *sem) {
	sem_t s = *sem;
	int res;

	if (s == NULL) {
		errno = EINVAL;
		return -1;
	}

	if ((res = pthread_mutex_lock(&s->mutex)) != 0) {
		errno = res;
		return -1;
	}

	if (s->value < 0) {
		pthread_mutex_unlock(&s->mutex);
		errno = EBUSY;
		return -1;
	}

	if ((res = pthread_cond_destroy(&s->cond)) != 0) {
		pthread_mutex_unlock(&s->mutex);
		errno = res;
		return -1;
	}

	*sem = NULL;
	s->value = SEM_VALUE_MAX;

	pthread_mutex_unlock(&s->mutex);

	pthread_mutex_destroy(&s->mutex);

	free(s);

	return 0;
}

int sem_wait(sem_t *sem) {
	sem_t s = *sem;
	int res;

	if (s == NULL) {
		errno = EINVAL;
		return -1;
	}

	if ((res = pthread_mutex_lock(&s->mutex)) != 0) {
		errno = res;
		return -1;
	}

	if (*sem == NULL) {
		pthread_mutex_unlock(&s->mutex);
		errno = EINVAL;
		return -1;
	}

	if (--s->value < 0 && (res = pthread_cond_wait(&s->cond, &s->mutex)) != 0) {
		pthread_mutex_unlock(&s->mutex);
		errno = res;
		return -1;
	}

	pthread_mutex_unlock(&s->mutex);

	return 0;
}

int sem_post(sem_t *sem) {
	sem_t s = *sem;
	int res;

	if (s == NULL) {
		errno = EINVAL;
		return -1;
	}

	if ((res = pthread_mutex_lock(&s->mutex)) != 0) {
		errno = res;
		return -1;
	}

	if (*sem == NULL) {
		pthread_mutex_unlock(&s->mutex);
		errno = EINVAL;
		return -1;
	}

	if (s->value >= SEM_VALUE_MAX) {
		pthread_mutex_unlock(&s->mutex);
		errno = ERANGE;
		return -1;
	}

	if (++s->value <= 0 && (res = pthread_cond_signal(&s->cond)) != 0) {
		s->value--;
		pthread_mutex_unlock(&s->mutex);
		errno = res;
		return -1;
	}

	pthread_mutex_unlock(&s->mutex);

	return 0;
}

int sem_getvalue(sem_t *sem, int *sval) {
	sem_t s = *sem;

	if (s == NULL) {
		errno = EINVAL;
		return -1;
	}

	*sval = s->value;

	return 0;
}


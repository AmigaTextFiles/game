#ifndef _AL_SPOOL_H_
#define _AL_SPOOL_H_

#include "al_types.h"

#include <sys/types.h>

/* spool stuff */
int spool_alloc(spool_t *spool);
AL_source *spool_index(spool_t *spool, ALuint sindex);
ALboolean spool_dealloc(spool_t *spool, ALuint sid,
				void (*freer_func)(void *));
void spool_free(spool_t *spool, void (*freer_func)(void *));
int spool_first_free_index(spool_t *spool);

ALuint spool_next_id(void);
int spool_sid_to_index(spool_t *spool, ALuint sid);

void spool_init(spool_t *spool);
ALboolean spool_resize(spool_t *spool, size_t size);


#endif

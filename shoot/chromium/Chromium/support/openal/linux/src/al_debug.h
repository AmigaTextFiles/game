#ifndef AL_DEBUG_H_
#define AL_DEBUG_H_

#include "al_siteconfig.h"

#include <assert.h>

#if defined(DEBUG)        || defined(DEBUG_LOOP) || defined(DEBUG_STUB)    || \
    defined(DEBUG_CONFIG) || defined(DEBUG_LOCK) || defined(DEBUG_CONVERT) || \
    defined(DEBUG_EXT)    || defined(DEBUG_SOURCE) || defined(DEBUG_STREAMING)\
    || defined(DEBUG_MATH) || defined(DEBUG_MEM) || defined(DEBUG_CONTEXT)    \
    || defined(DEBUG_MAXIMUS) || defined(DEBUG_BUFFER)                        \
    || defined(DEBUG_LISTENER) || defined(DEBUG_QUEUE)

#define NEED_DEBUG
#define ASSERT(p) assert(p)
#else 
#define ASSERT(p) 
#endif /* debug stuff */

#ifdef DEBUG_MAXIMUS
#define DEBUG
#endif /* DEBUG_MAXIMUS */

typedef enum _aldEnum {
	ALD_INVALID,
	ALD_CONVERT,
	ALD_CONFIG,
	ALD_SOURCE,
	ALD_LOOP,
	ALD_STUB,
	ALD_CONTEXT,
	ALD_MATH,
	ALD_MIXER,
	ALD_ERROR,
	ALD_EXT,
	ALD_LOCK,
	ALD_STREAMING,
	ALD_MEM,
	ALD_MAXIMUS,
	ALD_BUFFER,
	ALD_LISTENER,
	ALD_QUEUE
} aldEnum;

int debug(aldEnum level, const char *fn, int ln, const char *format, ...);

#endif

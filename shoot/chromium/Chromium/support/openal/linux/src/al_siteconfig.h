#ifndef AL_SITECONFIG_H_
#define AL_SITECONFIG_H_

/*
 * Wrap site specific config stuff
 */

#include "../config.h"

#ifdef DMALLOC
/* do nothing */
#undef malloc
#undef calloc
#undef realloc
#undef new
#undef free
#undef strspn
#include <stdlib.h>
#include <string.h>
#undef malloc
#undef calloc
#undef realloc
#undef new
#undef free
#undef strspn
#elif defined(JLIB) && !defined(NOJLIB)
#include <stdlib.h>
#endif

#ifdef DMALLOC
#include "/usr/local/include/dmalloc.h"
#endif

#if defined(JLIB) && !defined(NOJLIB)
#include "../include/jlib.h"
#endif

#endif /* AL_SITE_CONFIG_H_ */

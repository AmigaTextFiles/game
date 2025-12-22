#ifndef _AL_EXT_H_
#define _AL_EXT_H_

#define LAL_EXT_SUFFIX		03282000
#define LAL_EXT_TABLE		alExtension
#define LAL_EXT_INIT		alExtInit
#define LAL_EXT_FINI		alExtFini

#define LAL_EXT_TABLE_STR	PASTE(LAL_EXT_TABLE, LAL_EXT_SUFFIX)
#define LAL_EXT_INIT_STR	PASTE(LAL_EXT_INIT, LAL_EXT_SUFFIX)
#define LAL_EXT_FINI_STR	PASTE(LAL_EXT_FINI, LAL_EXT_SUFFIX)

#define PASTE__(a1)             #a1
#define PASTE_(a1, a2)          PASTE__(a1 ## _ ## a2)
#define PASTE(a1, a2)           PASTE_(a1, a2)


#include "al_types.h"
#include "al_filter.h"
#include "al_config.h"

/* bookkeeping stuff */
ALboolean _alInitExtensions(void);
void _alDestroyExtensions(void);

/* register extension group */
ALboolean _alRegisterExtensionGroup( const ALubyte* );
/* free list of extensions */
void _alDestroyExtensionGroups( void );

/* get a list of extension groups registered */
ALboolean _alGetExtensionStrings( ALubyte* buffer, int size );

/* register extension (function) */
ALboolean _alRegisterExtension(const ALubyte *name, void *addr);

/*
 * dlopens a shared object, gets the extension table from it, and
 * the runs _alRegisterExtension on each extension pair in it.
 */
ALboolean _alLoadDL(const char *fname);

/*
 *  Functions that extensions can call to add functionality.
 */

/*
 * add a filter by name, replacing if already there.  Returns
 * AL_TRUE if function was added or replaced, AL_FALSE if that
 * wasn't possible.
 */
ALboolean lal_addTimeFilter(const char *name, time_filter *addr);
ALboolean lal_addFreqFilter(const char *name, freq_filter *addr);

/*
 *  look up bindings for symbols.
 */
#define lal_GetGlobalScalar(s,t,r) _alGetGlobalScalar(s,t,r)
#define lal_GetGlobalVector(s,t,n,r) _alGetGlobalScalar(s,t,n,r)

/* dummy test one */
void alLokiTest(void *dummy);

#endif /* _AL_EXT_H_ */ 

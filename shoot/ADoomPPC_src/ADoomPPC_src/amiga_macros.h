#ifndef _AMIGA_MACROS_H
#define _AMIGA_MACROS_H

/*
 *  amiga_macros.h - small macros for compiler specific stuff
 *  This file is public domain.
 */

#include <exec/types.h>

/*
 * macros for function definitions and declarations
 */

#if defined(__VBCC__)
#define INLINE

#elif defined(__SASC)
#define INLINE __inline

#elif defined(__GNUC__)
#define INLINE __inline

#else
#define INLINE

#endif

#endif /* _AMIGA_MACROS_H */

/*
*	SDL Graphics Extension
*	SGE internal header
*
*	Started 000627
*
*	License: LGPL v2+ (see the file LICENSE)
*	(c)2000-2001 Anders Lindström
*/

/*********************************************************************
 *  This library is free software; you can redistribute it and/or    *
 *  modify it under the terms of the GNU Library General Public      *
 *  License as published by the Free Software Foundation; either     *
 *  version 2 of the License, or (at your option) any later version. *
 *********************************************************************/

#ifndef sge_internal_H
#define sge_internal_H

/* This header is included in all sge_*.h files */

/*
*  C compatibility
*/
#ifndef __cplusplus
	#define sge_C_ONLY
#endif
#ifdef _SGE_C
	#define sge_C_ONLY
#endif


/*
*  Bit flags
*/
#define SGE_FLAG1 0x01
#define SGE_FLAG2 0x02
#define SGE_FLAG3 0x04
#define SGE_FLAG4 0x08
#define SGE_FLAG5 0x10
#define SGE_FLAG6 0x20
#define SGE_FLAG7 0x40
#define SGE_FLAG8 0x80

/*
*  Hacks for SDL 1.1.5+
*/
#ifndef SDL_ALPHA_OPAQUE
	#define SDL_ALPHA_OPAQUE 0
#endif
#ifndef SDL_ALPHA_TRANSPARENT
	#define SDL_ALPHA_TRANSPARENT 255
#endif

/*
*  Some compilers use a special export keyword
*  Thanks to Seung Chan Lim (limsc@maya.com or slim@djslim.com) to pointing this out
*  (From SDL)
*/
#ifndef DECLSPEC
	#ifdef __BEOS__
		#if defined(__GNUC__)
			#define DECLSPEC __declspec(dllexport)
		#else
			#define DECLSPEC __declspec(export)
		#endif
	#else
	#ifdef WIN32
		#define DECLSPEC __declspec(dllexport)
	#else
		#define DECLSPEC
	#endif
	#endif
#endif

#endif /* sge_internal_H */

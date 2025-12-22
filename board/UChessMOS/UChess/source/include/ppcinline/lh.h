/* Automatically generated header! Do not edit! */

#ifndef _PPCINLINE_LH_H
#define _PPCINLINE_LH_H

#ifndef __PPCINLINE_MACROS_H
#include <ppcinline/macros.h>
#endif /* !__PPCINLINE_MACROS_H */

#ifndef LH_BASE_NAME
#define LH_BASE_NAME LhBase
#endif /* !LH_BASE_NAME */

#define LhDecode(__p0) \
	LP1(48, ULONG , LhDecode, \
		struct LhBuffer *, __p0, a0, \
		, LH_BASE_NAME, 0, 0, 0, 0, 0, 0)

#define LhEncode(__p0) \
	LP1(42, ULONG , LhEncode, \
		struct LhBuffer *, __p0, a0, \
		, LH_BASE_NAME, 0, 0, 0, 0, 0, 0)

#define DeleteBuffer(__p0) \
	LP1NR(36, DeleteBuffer, \
		struct LhBuffer *, __p0, a0, \
		, LH_BASE_NAME, 0, 0, 0, 0, 0, 0)

#define CreateBuffer(__p0) \
	LP1(30, struct LhBuffer *, CreateBuffer, \
		LONG , __p0, d0, \
		, LH_BASE_NAME, 0, 0, 0, 0, 0, 0)

#endif /* !_PPCINLINE_LH_H */

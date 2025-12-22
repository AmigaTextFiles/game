/* libvstring.h */

#ifndef __NOLIBBASE__
#define __NOLIBBASE__
#endif

#include <exec/types.h>
#include <stdarg.h>

extern struct Library *SysBase;

ULONG FmtLen(STRPTR fmt, ...);
void FmtPut(STRPTR dest, STRPTR fmt, ...);
LONG FmtNPut(STRPTR dest, STRPTR fmt, LONG maxlen, ...);
STRPTR VFmtNew(STRPTR fmt, va_list args);
STRPTR FmtNew(STRPTR fmt, ...);
ULONG StrLen(STRPTR str);
STRPTR StrCopy(STRPTR src, STRPTR dest);
STRPTR StrNCopy(STRPTR src, STRPTR dest, LONG maxlen);
STRPTR StrNew(STRPTR str);
STRPTR* CloneStrArray(STRPTR *array);
VOID FreeStrArray(STRPTR *array);
ULONG StrArrayLen(STRPTR *array);
void StrFree(STRPTR str);
BOOL StrEqu(STRPTR s1, STRPTR s2);

/* memory alloc and free functions must be a matched pair */

#define StrFree(s) FreeVecTaskPooled(s)
#define FmtFree(s) FreeVecTaskPooled(s)
#define internal_alloc(l) AllocVecTaskPooled(l)


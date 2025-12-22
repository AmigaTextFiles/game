#if !defined(OS4_TYPES_H) && !defined(__amigaos4__)
#define OS4_TYPES_H 1

#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif

typedef signed long long int int64;
typedef unsigned long long int uint64;
typedef LONG int32;
typedef ULONG uint32;
typedef WORD int16;
typedef UWORD uint16;
typedef BYTE int8;
typedef UBYTE uint8;

#endif

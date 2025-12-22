#ifndef _PROTO_TITLEBARIMAGE_H
#define _PROTO_TITLEBARIMAGE_H

#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif
#if !defined(CLIB_TITLEBARIMAGE_PROTOS_H) && !defined(__GNUC__)
#include <clib/titlebarimage_protos.h>
#endif

#ifndef __NOLIBBASE__
extern struct Library *TitlebarImageBase;
#endif

#ifdef __GNUC__
#include <inline/titlebarimage.h>
#elif defined(__VBCC__)
#include <inline/titlebarimage_protos.h>
#else
#include <pragma/titlebarimage_lib.h>
#endif

#endif	/*  _PROTO_TITLEBARIMAGE_H  */

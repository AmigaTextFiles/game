/*****************************************************************************
 * ChessBase Companion -  Copyright (c)1993 Andy Duplain
 *
 * File:        global.h
 *
 * Description: Common header file.
 *
 *****************************************************************************/

#ifndef __GLOBAL_H__
#define __GLOBAL_H__

#ifdef DEBUG
#define KEY_DEBUG
#endif

#include "machine.h"

/* standard includes */

#include <sys/types.h>
#include <stdio.h>

#ifdef BSD
#include <strings.h>
#else
#include <string.h>
#endif

#ifdef HAVE_STDLIB_H
#include <stdlib.h>
#endif

#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif

#ifdef HAVE_MALLOC_H
#include <malloc.h>
#endif

#ifdef HAVE_MEMORY_H
#ifdef AMIGA
#include <exec/memory.h>
#else
#include <memory.h>
#endif			/* AMIGA */
#endif

/* include Amiga filecontrol header file */

#ifdef AMIGA
#include <fcntl.h>
#endif			/* AMIGA */

/* macro to protect ANSI C function prototypes */

#if defined(__STDC__) || defined(__GNUC__) || defined(__TURBOC__)
#define P__(s) s
#define ANSI_C
#else
#define P__(s) ()
#undef ANSI_C
#endif

/* pointer type */

#ifdef MSDOS
#ifdef ANSI_C
typedef void __far *PTR;
#else
typedef char __far *PTR;
#endif
#else                                  /* MSDOS */
#ifdef ANSI_C
typedef void *PTR;
#else
typedef char *PTR;
#endif
#endif                                 /* MSDOS */

/* types */

#ifndef BSD
typedef unsigned char u_char;
typedef unsigned short u_short;
typedef unsigned long u_long;
#define index(s,c) strchr(s,c)
#define rindex(s,c) strrchr(s,c)
#define bcopy(a,b,l) memcpy(b,a,l)
#define bzero(a,l) memset(a,0,l)
#define bcmp(a,b,l) memcmp(a,b,l)
#endif                                 /* !BSD */

#ifdef AMIGA
#define index(s,c) strchr(s,c)
#define rindex(s,c) strrchr(s,c)
#define bcopy(a,b,l) memcpy(b,a,l)
#define bzero(a,l) memset(a,0,l)
#define bcmp(a,b,l) memcmp(a,b,l)
#endif

#ifndef HAVE_STRERROR
extern char *sys_errlist[];
#define strerror(e) sys_errlist[e]
#endif                                 /* !HAVE_STRERROR */

#ifndef min
#define min(x,y) ((x) < (y) ? x : y)
#endif

/* structure to encapsulate a filename and its file pointer */

struct file {
    char *name;
    int fd, mode;
};

typedef struct file *File;

#ifndef msc
extern int errno;
#endif

#include "cb.h"
#include "extern.h"
#ifdef ANSI_C
#include <stdarg.h>
#else
#include <varargs.h>
#endif

#endif                                 /* __GLOBAL_H__ */

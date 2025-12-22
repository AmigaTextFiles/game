/*****************************************************************************
 * ChessBase Companion -  Copyright (c)1993 Andy Duplain 
 *				       1996 Amiga Version Dr Ortwin Paetzold
 * File:        machine.h
 *
 * Description: Machine-specific defines.
 *
 *****************************************************************************/

#ifndef __MACHINE_H__
#define __MACHINE_H__

/***************************************************************************/
#ifdef AMIGA                          /* AMIGA */
#define HAVE_STDLIB_H
#define HAVE_MEMORY_H
#define BSD
#define PATHSEP '/'
#define MAX_FNAMELEN    256
#define OPENMODE 0644

/*
#define HAVE_UNISTD_H
#define HAVE_STRERROR
#define UNIX
#define BSD43
*/

#endif                                 /* AMIGA */

/***************************************************************************/
#ifdef sunos4                          /* SunOS 4 */

#define HAVE_STDLIB_H
#define HAVE_UNISTD_H
#define HAVE_MEMORY_H
#define HAVE_STRERROR
#define UNIX
#define BSD
#define BSD43

#endif                                 /* sunos4 */

/***************************************************************************/
#ifdef sequent                         /* Sequent Dynix 3 */

#define UNIX
#define BSD
#define BSD42

#endif                                 /* sequent */

/***************************************************************************/
#ifdef sco				/* SCO UNIX */

#define UNIX
#define SYSV
#define HAVE_STDLIB_H
#define HAVE_UNISTD_H
#define HAVE_MEMORY_H
#define const /**/

#endif					/* SCO UNIX */

/***************************************************************************/
#ifdef UNIX                            /* generic UNIX */

#define PATHSEP '/'
#define MAX_FNAMELEN    256
#define OPENMODE 0644

#endif                                 /* UNIX */

/***************************************************************************/
#if defined(msc) && !defined(MSDOS)
#define MSDOS
#endif

#ifdef borlandc
#define turboc
#endif

#ifdef turboc
#define MSDOS
#endif

#ifdef MSDOS                           /* MS-DOS 4, 5, 6 (and maybe 3) */

#include <io.h>

#define HAVE_STDLIB_H
#define HAVE_MALLOC_H
#define PATHSEP '\\'
#define MAX_FNAMELEN    12
#define unlink(f) remove(f)

#ifdef msc
#define stat _stat
#define fstat _fstat
#define S_IFREG _S_IFREG
#define S_IFDIR _S_IFDIR
#define open _open
#define close _close
#define read _read
#define write _write
#define lseek _lseek
#define strdup _strdup
#define O_APPEND _O_APPEND
#define O_BINARY _O_BINARY
#define O_CREAT _O_CREAT
#define O_EXCL _O_EXCL
#define O_RDONLY _O_RDONLY
#define O_RDWR _O_RDWR
#define O_TEXT _O_TEXT
#define O_TRUNC _O_TRUNC
#define O_WRONLY _O_WRONLY
#define OPENMODE (_S_IWRITE|_S_IREAD)
#define HAVE_STRERROR
#endif

#endif                                 /* MSDOS */

#endif                                 /* __MACHINE_H__ */

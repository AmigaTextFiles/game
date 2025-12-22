/*
The following declarations are used in most every program written by Paul
Kienitz.  Generally, I use a symbol table file which includes exec/exec.h,
libraries/dosextens.h, stdio.h, string.h, and this, which pulls in
functions.h.  I have a separate symbol file for intuition/intuitionbase.h,
which pulls in all the other intuition/ files.
*/

#ifndef PAUL_DOT_AITCH
#define PAUL_DOT_AITCH

#ifdef _STDIO_H			/* aztec 3.6 version */
#define __STDIO_H
#endif

#ifdef __STDIO_H		/* ansi version */
#define put(S) fputs(S, stdout)
#endif


#define null   ((void *) 0L)
#define maxint 0x7fffffffL
#define minint 0x80000000L
/* uppercase is a pain in the wazoo */

#define bip(T, B) ((T *) (B << 2))
#define gbip(B)   bip(void, B)
/* B is expected to be of type BPTR or BSTR. */

typedef short bool;
#define false ((bool) 0)
#define true  ((bool) 1)

typedef unsigned short ushort;
typedef unsigned long  ulong;
typedef unsigned char  ubyte;

typedef void *adr;
typedef char *str;


#define bit(B) (1L << (B))

#define import  extern
#define PUBLIC

#ifndef private
#define private static
#else
#undef  private
#define private PUBLIC
#endif


#ifndef _SIZE_T
#define _SIZE_T
typedef unsigned long size_t;
#endif


#if __STDC__
#define _ANSI_C
#else
#ifdef AZTEC_C
#ifdef __STDC__
#define _ANSI_C
#endif
#endif
#endif
/* the above is BOGUS!!  We need a way to KNOW if it's ansi or not!  The
above assumes that it's always ansi if it's aztec 5.0, regardless of whether
the compiler has been told to not use ansi features!  The compiler normally
defines __STDC__ as zero, not one, unless you use the -at option to turn on
useless "trigraph" parsing. */


#ifdef _ANSI_C
#define _PROTO(X) X
#define VOLATILE volatile
#define CONST const
#else
#define _PROTO(X) ()
#define VOLATILE 
#define CONST
#endif

#define pro(X) _PROTO(x)
/* dunno if I'll use that or not */



#ifdef AZTEC_C

#ifndef _ANSI_C

/******
Under Aztec 3.6, we have to monkey with functions.h.  The problem is that many
of the functions in there are incorrectly declared.  First, CreateProc and
DeviceProc are declared as returning struct Process pointers when they in
fact return struct MsgPort pointers.  Secondly, all of the DOS functions that
return BPTRs are declared as returning pointers.  And they define
OpenWorkBench as returning a short!  And they mistakenly have OpenFont and
OpenDiskFont returning "struct Font" (which is not defined) instead of struct
TextFont.  Some of these functions can be fixed by #defining Blah as _Blah,
when the glue routine provides both names, and declaring _Blah properly.  For
the others, we use a #define before functions.h to prevent it from defining
them at all.  In 5.0 these problems no longer exist.
*/

#define CreateProc    ___n_O_ne_XI__st_EN_t____1
#define DeviceProc    ___n_O_ne_XI__st_EN_t____2
#define CreateDir     ___n_O_ne_XI__st_EN_t____3
#define ParentDir     ___n_O_ne_XI__st_EN_t____4
#define DupLock       ___n_O_ne_XI__st_EN_t____5
#define LoadSeg       ___n_O_ne_XI__st_EN_t____6
#define OpenWorkBench ___n_O_ne_XI__st_EN_t____7

#define Font TextFont

#include <functions.h>

#undef CreateProc
#undef DeviceProc
#undef CreateDir
#undef ParentDir
#undef DupLock
#undef LoadSeg
#undef OpenWorkBench

#undef Font


#ifndef LIBRARIES_DOS_H
#define BPTR long
#endif

import BPTR CreateDir(), ParentDir(), DupLock(), LoadSeg();

import struct MsgPort *CreateProc(), *DeviceProc();

import struct Screen *OpenWorkBench();

/* the autodocs say don't use the return of OpenWorkBench as a screen pointer
because it might change as soon as you get it.  But sometimes it's useful... */

import BPTR _Lock(), _Open(), _Input(), _Output(), _CurrentDir();

#define Lock       _Lock
#define Open       _Open
#define Input      _Input
#define Output     _Output
#define CurrentDir _CurrentDir

/*
What we really need is different BPTR types that are incompatible for
assignment without casts, yet refuse to be dereferenced as pointers.  Like
FileLockBPTR, SegListBPTR, etc.  But what would these be defined as?
*/

#else  /* aztec 5.0 and newer */

#include <functions.h>		/* define inline calls of rom functions */

#endif


/* AND NOW, convenience stuff:::::::::::::::::::: */
#ifndef _ANSI_C
#ifdef SAVE_ONE_MEASLY_INSTRUCTION_PER_CALL

import struct Message *_GetMsg();
import void            _ReplyMsg();
import struct Message *_WaitPort();
import struct Task    *_FindTask();
import void           *_AllocMem();
import void            _FreeMem();

#define GetMsg   _GetMsg
#define ReplyMsg _ReplyMsg
#define WaitPort _WaitPort
#define FindTask _FindTask
#define AllocMem _AllocMem

/*
There are probably a few other glue routines with two names and wasted
instructions.  (It's like, GetMsg is a jump to _GetMsg.  Why didn't they just
put the two symbols at the same address??  Bozos...)
*/
#endif 
#endif ! _ANSI_C

#endif AZTEC_C


#ifdef EXEC_MEMORY_H

#define Alloc(S)    AllocMem((long) (S), 0L)
#define AllocC(S)   AllocMem((long) (S), MEMF_CHIP)
#define AllocP(S)   AllocMem((long) (S), MEMF_PUBLIC)
#define AllocZ(S)   AllocMem((long) (S), MEMF_CLEAR)
#define AllocCP(S)  AllocMem((long) (S), MEMF_CHIP | MEMF_PUBLIC)
#define AllocCZ(S)  AllocMem((long) (S), MEMF_CHIP | MEMF_CLEAR)
#define AllocPZ(S)  AllocMem((long) (S), MEMF_PUBLIC | MEMF_CLEAR)
#define AllocCPZ(S) AllocMem((long) (S), MEMF_CHIP | MEMF_PUBLIC | MEMF_CLEAR)
#define NewR(T, R)  ((T *) AllocMem((long) sizeof(T), R))
#define New(T)      NewR(T, 0L)
#define MewC(T)     NewR(T, MEMF_CHIP)
#define NewP(T)     NewR(T, MEMF_PUBLIC)
#define NewZ(T)     NewR(T, MEMF_CLEAR)
#define NewCP(T)    NewR(T, MEMF_CHIP | MEMF_PUBLIC)
#define NewCZ(T)    NewR(T, MEMF_CHIP | MEMF_CLEAR)
#define NewPZ(T)    NewR(T, MEMF_PUBLIC | MEMF_CLEAR)
#define NewCPZ(T)   NewR(T, MEMF_CHIP | MEMF_PUBLIC | MEMF_CLEAR)

#endif

#define Free(T, A)    FreeMem(A, (long) sizeof(T))


#ifdef LIBRARIES_DOS_H

#define RLock(F) Lock(F, (long) ACCESS_READ)
#define WLock(F) Lock(F, (long) ACCESS_WRITE)
#define OOpen(F) Open(F, (long) MODE_OLDFILE)
#define NOpen(F) Open(F, (long) MODE_NEWFILE)

#endif


#define Forbid() ((*((ubyte **) 4))[295]++)
/* as efficient as assembly; Aztec turns that into two instructions. */


#ifdef LIBRARIES_DOSEXTENS_H

#define ThisProcess() ((*((struct Process ***) 4))[69])
/* equivalent to (struct Process *) SysBase->ThisTask, two instructions. */

/** the cowardly safe alternative:
#define ThisProcess() ((struct Process *) FindTask(null))
import struct Task *FindTask _PROTO((const char *name));
*/

#endif


#ifdef AZTEC_C	 /* remove this for old v3.4 aztec */
#define strcpy _BUILTIN_strcpy
#define strcmp _BUILTIN_strcmp
#define strlen _BUILTIN_strlen
#endif

#endif PAUL_DOT_AITCH

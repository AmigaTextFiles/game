
/* Copyright (c) 1991 by Michael J. Roberts.  All Rights Reserved. */
/*
Name
	osamiga.h - Amiga operating system definitions
Function
	Definitions that vary by operating system
Notes
	None
Modified
	04/15/98 DKinder     - creation
*/

#define USE_STDARG
#include <stdarg.h>             /* get native stdargs */
#include <stdio.h>
#include <stdlib.h>

#define OS_SYSTEM_NAME "MorpOS"
#define OS_SYSTEM_LDESC "MorphOS G4"

#define TADS_OEM_NAME "Jan-Erik Karlsson"

#define TCD_SETTINGS_DEFINED
#define TCD_POOLSIZ  (24 * 1024)
#define TCD_LCLSIZ   (16 * 1024)
#define TCD_HEAPSIZ  65535
#define TCD_STKSIZ   512
#define TCD_LABSIZ   8192

#define TCD_POOLSIZ_MSG \
				"  -mp size      parse node pool size (default 24 Kb)"
#define TCD_LCLSIZ_MSG \
				"  -ml size      local symbol table size (default 16 Kb)"
#define TCD_HEAPSIZ_MSG "  -mh size      heap size (default 65535 bytes)"
#define TCD_STKSIZ_MSG "  -ms size      stack size (default 512 elements)"
#define TCD_LABSIZ_MSG \
				"  -mg size      goto label table size (default 8192 bytes)"

#define TRD_SETTINGS_DEFINED
#define TRD_HEAPSIZ  65535
#define TRD_STKSIZ   512
#define TRD_UNDOSIZ  60000

#define TRD_HEAPSIZ_MSG "  -mh size      heap size (default 65535 bytes)"
#define TRD_STKSIZ_MSG  "  -ms size      stack size (default 512 elements)"
#define TRD_UNDOSIZ_MSG \
				"  -u size       set undo to size (0 to disable; default 60000)"

#define TDD_SETTINGS_DEFINED
#define TDD_HEAPSIZ  65535
#define TDD_STKSIZ   512
#define TDD_UNDOSIZ  60000
#define TDD_POOLSIZ  (24 * 1024)
#define TDD_LCLSIZ   0

#define TDD_HEAPSIZ_MSG "  -mh size      heap size (default 65535 bytes)"
#define TDD_STKSIZ_MSG  "  -ms size      stack size (default 512 elements)"
#define TDD_UNDOSIZ_MSG \
				"  -u size       set undo to size (0 to disable; default 60000)"
#define TDD_POOLSIZ_MSG "  -mp size      parse pool size (default 24 Kb)"

/* maximum width (in characters) of a line of text */
#define OS_MAXWIDTH  255

/* far pointer type qualifier (null on most platforms) */
#define osfar_t
#define far

/* maximum theoretical size of malloc argument */
#define OSMALMAX ((size_t)0xffffffff)

/* cast an expression to void */
#define DISCARD (void)

/*
 * Some machines are missing memmove, so we use our own memcpy/memmove 
 * routine instead.
 */
void *our_memcpy(void *dst, const void *src, size_t size); 
#define memcpy our_memcpy
#define memmove our_memcpy

/*
 *   If long cache-manager macros are NOT allowed, define
 *   OS_MCM_NO_MACRO.  This forces certain cache manager operations to be
 *   functions, which results in substantial memory savings.  
 */
#define OS_MCM_NO_MACRO 1

/* likewise for the error handling subsystem */
#define OS_ERR_NO_MACRO 1

/*
 *   If error messages are to be included in the executable, define
 *   OS_ERR_LINK_MESSAGES.  Otherwise, they'll be read from an external
 *   file that is to be opened with oserrop().
 */
#define OS_ERR_LINK_MESSAGES
#define ERR_LINK_MESSAGES

/* round a size to worst-case alignment boundary */
#define osrndsz(s) (((s)+3) & ~3)

/* round a pointer to worst-case alignment boundary */
#define osrndpt(p) ((uchar *)((((ulong)(p)) + 3) & ~3))

/* void pointer type */
typedef void dvoid;

/* offset of a member inside a structure */
#ifndef offsetof
#define offsetof(typ, mem) ((uint)&(((typ *)0)->mem))
#endif

#define osc2u(p, i) ((uint)(((uchar *)(p))[i]))
#define osc2l(p, i) ((ulong)(((uchar *)(p))[i]))

/* read unaligned portable 2-byte value, returning int */
#define osrp2(p) (osc2u(p, 0) + (osc2u(p, 1) << 8))

/* write int to unaligned portable 2-byte value */
#define oswp2(p, i) ((((uchar *)(p))[1] = (i)>>8), (((uchar *)(p))[0] = (i)&255))

/* read unaligned portable 4-byte value, returning long */
#define osrp4(p) \
 (osc2l(p, 0) + (osc2l(p, 1) << 8) + (osc2l(p, 2) << 16) + (osc2l(p, 3) << 24))

/* write long to unaligned portable 4-byte value */
#define oswp4(p, i) \
 ((((uchar *)(p))[0] = (i)), (((uchar *)(p))[1] = (i)>>8),\
	(((uchar *)(p))[2] = (i)>>16, (((uchar *)(p))[3] = (i)>>24)))

/* allocate storage - malloc where supported */
/* dvoid *osmalloc(size_t siz); */
#define osmalloc malloc

/* free storage allocated with osmalloc */
/* void osfree(dvoid *block); */
#define osfree free

/* copy a structure - dst and src are structures, not pointers */
#define OSCPYSTRUCT(dst, src) ((dst) = (src))

/* is a full ANSI compiler */
#define OSANSI

/* maximum length of a filename */
#define OSFNMAX 255

/* normal path separator character */
#define OSPATHCHAR '/'

/* alternate path separator characters */
#define OSPATHALT "/"
#define OSPATHSEP ":"

/* os file structure */
typedef FILE osfildef;

/* main program exit codes */
#define OSEXSUCC 0                                 /* successful completion */
#define OSEXFAIL 1                                        /* error occurred */

/* open text file for reading; returns NULL on error */
/* osfildef *osfoprt(char *fname, int typ); */
#define osfoprt(fname, typ) fopen(fname, "r")

/* open text file for writing; returns NULL on error */
/* osfildef *osfopwt(char *fname, int typ); */
#define osfopwt(fname, typ) fopen(fname, "w")

/* open binary file for writing; returns NULL on error */
/* osfildef *osfopwb(char *fname, int typ); */
#define osfopwb(fname, typ) fopen(fname, "wb")

/* open SOURCE file for reading - use appropriate text/binary mode */
/* osfildef *osfoprs(char *fname, int typ); */
#define osfoprs(fname, typ) fopen(fname, "rb")

/* open binary file for reading; returns NULL on erorr */
/* osfildef *osfoprb(char *fname, int typ); */
#define osfoprb(fname, typ) fopen(fname, "rb")

/* get a line of text from a text file (fgets semantics) */
/* char *osfgets(char *buf, size_t len, osfildef *fp); */
char *osfgets(char *buf, int len, osfildef *fp);

/* open binary file for reading/writing; don't truncate */
osfildef *osfoprwb(char *fname, int typ);

/* open binary file for reading/writing; truncate; returns NULL on error */
/* osfildef *osfoprwtb(char *fname, int typ); */
#define osfoprwtb(fname, typ) fopen(fname, "w+b")

/* write bytes to file; TRUE ==> error */
int osfwb(osfildef *fp, unsigned char *buf, int bufl);

/* read bytes from file; TRUE ==> error */
int osfrb(osfildef *fp, unsigned char *buf, int bufl);

/* size_t osfrbc(osfildef *fp, unsigned char *buf, size_t bufl); */
#define osfrbc(fp, buf, bufl) fread(buf, 1, bufl, fp)

/* get position in file */
/* long osfpos(osfildef *fp); */
#define osfpos(fp) ftell(fp)

/* seek position in file; TRUE ==> error */
/* int osfseek(osfildef *fp, long pos, int mode); */
#define osfseek(fp, pos, mode) fseek(fp, pos, mode)
#define OSFSK_SET  SEEK_SET
#define OSFSK_CUR  SEEK_CUR
#define OSFSK_END  SEEK_END

/* close a file */
/* void osfcls(osfildef *fp); */
#define osfcls(fp) fclose(fp)

/* delete a file - TRUE if error */
/* int osfdel(char *fname); */
#define osfdel(fname) remove(fname)

/* access a file - 0 if file exists */
/* int osfacc(char *fname) */
#define osfacc(fname) access(fname, 0)

/* get a character from a file */
/* int osfgetc(osfildef *fp); */
#define osfgetc(fp) fgetc(fp)

/* open error file, returning file handle, or null if not found */
osfildef *oserrop(/*_ void _*/);

#define os_csr_busy(show_as_busy)

#define osfputs(s,fp) fputs(s,fp)

/*
 *   os_settype(file, type) sets a file to the given type.  This is
 *   required for certain operating systems which like to classify
 *   their files through these type identifiers.  The OSFTxxx constants
 *   are the abstract types we use; the os_settype implementation must
 *   translate to an appropriate OS type.  (This routine is a no-op on
 *   many systems.)
 */

#define OSFTLOG  0
#define OSFTGAME 1
#define OSFTSAVE 2
#define OSFTSWAP 3

/* ignore OS_LOADDS definitions */
#define OS_LOADDS

/* file types - not used by DOS */

#define OSFTGAME 0                               /* a game data file (.gam) */
#define OSFTSAVE 1                                   /* a saved game (.sav) */
#define OSFTLOG  2                               /* a transcript (log) file */
#define OSFTSWAP 3                                             /* swap file */

#define OSFTDATA 4      /* user data file (used with the TADS fopen() call) */
#define OSFTCMD  5                                   /* QA command/log file */
#define OSFTERRS 6                                    /* error message file */
#define OSFTTEXT 7                     /* text file - used for source files */
#define OSFTBIN  8          /* binary file of unknown type - resources, etc */

/* update progress display with linfdef info, if appropriate */
#define os_progress(fname,linenum)

#define STD_OSCLS
#define STD_OS_HILITE

/*
 *   Single/double quote matching macros.  Used to allow systems with
 *   extended character codes with weird quote characters (such as Mac) to
 *   match the weird characters. 
 */
#define os_squote(c) ((c) == '\'')
#define os_dquote(c) ((c) == '"')
#define os_qmatch(a, b) ((a) == (b))

/*
 *   Options for this operating system
 */
# define USE_MORE        /* assume more-mode is desired (undef if not true) */
# define USE_NULLPAUSE
# define USE_TIMERAND
# define USE_NULLSTYPE
# define USE_PATHSEARCH

#ifdef  USE_STDIO
#define USE_NULLSTAT
#define USE_NULLSCORE
#define USE_NULLINIT
#define STD_ASKFILE
#else
#define RUNTIME
#define USE_STATLINE
#define USE_HISTORY
#define USE_SCROLLBACK
#endif

#define OS_USHORT_DEFINED 1
#define OS_UINT_DEFINED 1
//#define OS_UINT_DEFINED 1

#ifdef USE_SCROLLBACK
#define OS_SBSTAT "(Review Mode)  Shift Cursor Up=Page Up  Shift Cursor Down=Page Down  F1=Exit"
#endif /* USE_SCROLLBACK */

#ifdef USE_HISTORY
#define HISTBUFSIZE 4096
#endif /* USE_HISTORY */

#define USE_STDIO_INPDLG

/*
 *   Some global variables needed for console implementation
 */
#ifdef OSGEN_INIT
#define E
#define I(a) =(a)
#else /* OSGEN_INIT */
#define E extern
#define I(a)
#endif /* OSGEN_INIT */

E sdesc_color I(23);
E int text_color I(7);
E int status_mode;
E int debug_color I(0xe);

#ifdef USE_GRAPH
void ossdsp();
E void (*os_dspptr)() I(ossdsp);
#define ossdsp (*os_dspptr)
#endif /* USE_GRAPH */

#undef E
#undef I

#define ARG0 ("")

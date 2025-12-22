#ifndef DEF_H
#define DEF_H

//---------------------------------------------------------------
// Test if the makefile correctly defines all the operating
// system (one of the OS_ flags), the compiler (one of the
// COMP_ flags) and the processor (one of the PROC_ flags).
//---------------------------------------------------------------

#if !defined(OS_SOLARIS) && !defined(OS_LINUX) && !defined(OS_DOS) && !defined(OS_UNIX) && !defined(OS_MACOS) && !defined(OS_AMIGAOS)
#  error "Please specify the operating system in the makefile! (one of OS_...)"
#endif

#if !defined(COMP_GCC) && !defined(COMP_DJGPP) && !defined(COMP_WCC) && !defined(COMP_UNKNOWN) && !defined(COMP_MWERKS)
#  error "Please specify the compiler in the makefile! (one of COMP_...)"
#endif

#if !defined(PROC_INTEL) && !defined(PROC_SPARC) && !defined(PROC_UNKNOWN) && !defined(PROC_POWERPC) && !defined(PROC_M68K)
#  error "Please specify the processor in the makefile! (one of PROC_...)"
#endif

#if defined(OS_SOLARIS) && !defined(DO_X11)
#  error "You need X Windows support on a Solaris machine!"
#endif

#if defined(OS_LINUX) && !defined(DO_X11)
#  error "Currently you need X Windows support on a Linux machine!"
#endif

#if defined(OS_UNIX) && !defined(DO_X11)
#  error "Currently you need X Windows support on a Unix machine!"
#endif

#if defined(OS_AMIGAOS) && !defined(DO_AMIGAOS)
#  error "Currently you need AmigaOS support on an Amiga machine!"
#endif

#if defined(DO_SHM) && !defined(DO_X11)
#  error "The shared memory extension only works in X Windows!"
#endif

#if defined(DO_SVGALIB)
#  error "Support for SVGALIB is currently not implemented!"
#endif

//---------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <signal.h>
#include <errno.h>
#include <string.h>

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef MIN
#define MIN(a,b) ((a)<(b)?(a):(b))
#endif

#ifndef MAX
#define MAX(a,b) ((a)>(b)?(a):(b))
#endif

#ifndef ABS
#define ABS(x) ((x)<0?-(x):(x))
#endif

#if !defined(SIGN) && !defined(DO_AMIGAOS)
#define SIGN(x) ((x)<0?-1:((x)>0?1:0))
#endif

#define EPSILON 0.001           /* Small value */
#define SMALL_EPSILON 0.000001  /* Very small value */
#define INFINITE 999999000      /* Very large number */
#ifndef PI
#define PI 3.14159265358979323  /* You know this number, don't you? */
#endif
#ifndef M_PI
#define M_PI PI
#endif

#define DEBUG 0
//vonmir
//#define VERBOSE 1
#define VERBOSE 0
//
#if DEBUG
#define PRINTF(x) dprintf##x
#else
#define PRINTF(x)
#endif


#if VERBOSE
#define MSG(x) dprintf##x
#else
#define MSG(x)
#endif

#ifdef PROC_INTEL
/*
//#pragma aux RoundToInt=\
//        "fistp DWORD [eax]"\
//        parm nomemory [eax] [8087]\
//        modify exact [8087];
*/

// This is 'stolen' from someone (I don't remember who anymore). It
// is a nice and fast way to convert a floating point number to int
// (only works on a i386 type processor).
// It is equivalent to 'i=(int)(f+.5)'. 
#define FIST_MAGIC ((((65536.0 * 65536.0 * 16)+(65536.0 * 0.5))* 65536.0))
inline long QuickRound (float inval)
{
  double dtemp = FIST_MAGIC + inval;
  return ((*(long *)&dtemp) - 0x80000000);
}

inline long QuickInt (float inval)
{
  double dtemp = FIST_MAGIC + (inval-.4999);
  return ((*(long *)&dtemp) - 0x80000000);
}

// This is my own invention derived from the previous one. This converts
// a floating point number to a 16.16 fixed point integer. It is
// equivalent to 'i=(int)(f*65536.)'.
#define FIST_MAGIC2 ((((65536.0 * 16)+(0.5))* 65536.0))
inline long QuickInt16 (float inval)
{
  double dtemp = FIST_MAGIC2 + inval;
  return ((*(long *)&dtemp) - 0x80000000);
}
#endif

#ifdef PROC_M68K

#define FIST_MAGIC ((((65536.0 * 65536.0 * 16)+(65536.0 * 0.5))* 65536.0))
inline long QuickRound (float inval)
{
  double dtemp = FIST_MAGIC + inval;
  return (*(((long *)&dtemp) + 1)) - 0x80000000;
}
    
inline long QuickInt (float inval)
{
  double dtemp = FIST_MAGIC + (inval-.4999);
  return (*(((long *)&dtemp) + 1)) - 0x80000000;
}
        
#define FIST_MAGIC2 ((((65536.0 * 16)+(0.5))* 65536.0))
inline long QuickInt16 (float inval)
{
  double dtemp = FIST_MAGIC2 + inval;
  return (*(((long *)&dtemp) + 1)) - 0x80000000;
}
#endif
            
#if defined(PROC_INTEL) || defined(PROC_M68K)
#  define QRound(x) QuickRound(x)
#  define QInt(x) QuickInt(x)
#  define QInt16(x) QuickInt16(x)
#else
#  define QRound(x) ((int)((x)+.5))
#  define QInt(x) ((int)(x))
#  define QInt16(x) ((int)((x)*65536.))
#endif

#define ASPECT FRAME_HEIGHT

//#define SMALL_Z .01
#define SMALL_Z .1

#define USE_OCCLUSION 0 // Experimental feature, will not work in this version.

#endif /*DEF_H*/

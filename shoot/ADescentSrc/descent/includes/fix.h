/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
/*
 * $Source: /usr/CVS/descent/includes/fix.h,v $
 * $Revision: 1.9 $
 * $Author: nobody $
 * $Date: 1999/03/10 23:26:48 $
 *
 * FIX.H - prototypes and macros for fixed-point functions
 *
 * Copyright (c) 1993  Matt Toschlog & Mike Kulas
 *
 * $Log: fix.h,v $
 * Revision 1.9  1999/03/10 23:26:48  nobody
 * Warp3D V2 adaption
 *
 * Revision 1.8  1998/03/31 14:29:16  tfrieden
 * inserted a missing extern
 *
 * Revision 1.7  1998/03/28 23:06:55  tfrieden
 * fixmulaccum moved to assembler, now function pointer
 *
 * Revision 1.6  1998/03/27 00:55:00  tfrieden
 * Got rid of this monster overkill fixdivquadlong
 *
 * Revision 1.5  1998/03/25 21:59:20  tfrieden
 * Removed the long int stuff for now
 *
 * Revision 1.4  1998/03/22 19:21:33  tfrieden
 * added new command line arguments for fix point math
 *
 * Revision 1.3  1998/03/22 01:50:34  tfrieden
 * Changes for function pointer stuff
 *
 * Revision 1.2  1998/03/18 23:20:15  tfrieden
 * Bugfixes
 *
 * Revision 1.1.1.1  1998/03/03 15:11:54  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:17  hfrieden
 * Initial Import
 */

#ifndef _FIX_H
#define _FIX_H

#ifndef WANT_FPU

//#define USE_INLINE 1

#include "types.h"

typedef long fix;               //16 bits int, 16 bits frac
typedef short fixang;       //angles

typedef struct quad {
	ulong low;
	long high;
} quad;

//Convert an int to a fix
#define i2f(i) ((i)<<16)

//Get the int part of a fix
#define f2i(f) ((f)>>16)

//Get the int part of a fix, with rounding
#define f2ir(f) (((f)+f0_5)>>16)

//Convert fix to float and float to fix
#define f2fl(f) (((float) (f)) / 65536.0)
#define fl2f(f) ((fix) ((f) * 65536))

//Some handy constants
#define f0_0    0
#define f1_0    0x10000
#define f2_0    0x20000
#define f3_0    0x30000
#define f10_0   0xa0000

#define f0_5 0x8000
#define f0_1 0x199a

#define F0_0    f0_0
#define F1_0    f1_0
#define F2_0    f2_0
#define F3_0    f3_0
#define F10_0   f10_0

#define F0_5    f0_5
#define F0_1    f0_1

void fix_init(void);

//multiply two fixes, return a fix
//fix fixmul(fix a,fix b);
#define fixmul(a,b) (*fixmul_func)((a),(b))
extern fix (*fixmul_func)(fix a __asm("d0"), fix b __asm("d1"));

//divide two fixes, return a fix
#define fixdiv(a,b) (*fixdiv_func)((a),(b))
extern fix (*fixdiv_func)(fix a __asm("d0"), fix b __asm("d1"));

//multiply two fixes, then divide by a third, return a fix
#define fixmuldiv(a,b,c) (*fixmuldiv_func)((a),(b),(c))
extern fix (*fixmuldiv_func)(fix a __asm("d0"), fix b __asm("d1"), fix c __asm("d2"));

//multiply two fixes, and add 64-bit product to a quad
#define fixmulaccum(a,b,c) (*fixmulaccum_func)((a),(b),(c))
extern void (*fixmulaccum_func)(quad *q __asm("a0"),fix a __asm("d0"),fix b __asm("d1"));


//extract a fix from a quad product
fix fixquadadjust(quad *q);

//divide a quad by a long
#define fixdivquadlong(a,b,c) (*fixdivquadlong_func)((a),(b),(c))
extern long (*fixdivquadlong_func)(ulong qlow __asm("d0"),ulong qhigh __asm("d1"),ulong d __asm("d2"));

//negate a quad
void fixquadnegate(quad *q);

//computes the square root of a long, returning a short
ushort long_sqrt(long a);

//computes the square root of a quad, returning a long
ulong quad_sqrt(long low,long high);

//computes the square root of a fix, returning a fix
fix fix_sqrt(fix a);

//compute sine and cosine of an angle, filling in the variables
//either of the pointers can be NULL
void fix_sincos(fix a,fix *s,fix *c);       //with interpolation
void fix_fastsincos(fix a,fix *s,fix *c);   //no interpolation

//compute inverse sine & cosine
fixang fix_asin(fix v); 
fixang fix_acos(fix v); 

//given cos & sin of an angle, return that angle.
//parms need not be normalized, that is, the ratio of the parms cos/sin must
//equal the ratio of the actual cos & sin for the result angle, but the parms 
//need not be the actual cos & sin.  
//NOTE: this is different from the standard C atan2, since it is left-handed.
fixang fix_atan2(fix cos,fix sin); 

//for passed value a, returns 1/sqrt(a) 
fix fix_isqrt( fix a );

#else


//#define USE_INLINE 1

#include "types.h"

typedef float fix;               //16 bits int, 16 bits frac
typedef float fixang;       //angles

typedef struct quad {
	ulong low;
	long high;
} quad;

//Convert an int to a fix
#define i2f(i) (float)i

//Get the int part of a fix
#define f2i(f) (int)f

//Get the int part of a fix, with rounding
#define f2ir(f) (int)f

//Convert fix to float and float to fix
#define f2fl(f) (f)
#define fl2f(f) (f)

//Some handy constants
#define f0_0    0
#define f1_0    1.0
#define f2_0    2.0
#define f3_0    3.0
#define f10_0   10.0

#define f0_5 0.5
#define f0_1 0.1

#define F1_0    f1_0
#define F2_0    f2_0
#define F3_0    f3_0
#define F10_0   f10_0

#define F0_5    f0_5
#define F0_1    f0_1

void fix_init(void);

//multiply two fixes, return a fix
//fix fixmul(fix a,fix b);
#define fixmul(a,b) (a)*(b)

//divide two fixes, return a fix
#define fixdiv(a,b) (a)/(b)

//multiply two fixes, then divide by a third, return a fix
#define fixmuldiv(a,b,c) (((a)*(b))/(c))

//multiply two fixes, and add 64-bit product to a quad
#define fixmulaccum(a,b,c) *a = ((b)*(c))


//extract a fix from a quad product
#define fixquadadjust(a)    (a/65536.0)

//divide a quad by a long
#define fixdivquadlong(a,b,c) fixdivquadlong_double(a,b,c)

//negate a quad
void fixquadnegate(quad *q);

//computes the square root of a long, returning a short
ushort long_sqrt(long a);

//computes the square root of a quad, returning a long
ulong quad_sqrt(long low,long high);

//computes the square root of a fix, returning a fix
#define fix_sqrt(a) sqrt(a)

//compute sine and cosine of an angle, filling in the variables
//either of the pointers can be NULL
#define fix_sincos(a, s, c) \
	*s = sin(a);            \
	*c = cos(a);

#define fix_fastsincos(a, s, c) \
	*s = sin(a);                \
	*c = cos(a);

//compute inverse sine & cosine
#define fix_asin(v) asin(v)
#define fix_acos(v) acos(v)

//given cos & sin of an angle, return that angle.
//parms need not be normalized, that is, the ratio of the parms cos/sin must
//equal the ratio of the actual cos & sin for the result angle, but the parms
//need not be the actual cos & sin.
//NOTE: this is different from the standard C atan2, since it is left-handed.
fixang fix_atan2(fix cos,fix sin);

//for passed value a, returns 1/sqrt(a)
#define fix_isqrt(a)    1.0/sqrt(a)


#endif
#endif

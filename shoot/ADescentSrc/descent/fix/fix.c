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
 * $Source: /usr/CVS/descent/fix/fix.c,v $
 * $Revision: 1.7 $
 * $Author: tfrieden $
 * $Date: 1998/03/28 23:06:13 $
 * 
 * C version of fixed point library
 * 
 * $Log: fix.c,v $
 * Revision 1.7  1998/03/28 23:06:13  tfrieden
 * fixmulaccum moved to assembler, now function pointer
 *
 * Revision 1.6  1998/03/27 00:54:37  tfrieden
 * Got rid of this monster overkill fixdivquadlong
 *
 * Revision 1.5  1998/03/25 21:59:02  tfrieden
 * Removed the long int stuff for now
 *
 * Revision 1.4  1998/03/22 19:21:19  tfrieden
 * added new command line arguments for fix point math
 *
 * Revision 1.3  1998/03/22 15:21:53  tfrieden
 * function pointers finally work
 *
 * Revision 1.2  1998/03/22 01:49:47  tfrieden
 * Inserted function pointer for fixmul
 *
 * Revision 1.1.1.1  1998/03/03 15:11:50  nobody
 * reimport after crash from backup
 *
 * Revision 1.2  1998/02/28 01:14:24  tfrieden
 * Don`t really know what changed
 *
 * Revision 1.1.1.1  1998/02/13  20:20:12  hfrieden
 * Initial Import
 */


#pragma off (unreferenced)
static char rcsid[] = "$Id: fix.c,v 1.7 1998/03/28 23:06:13 tfrieden Exp $";
#pragma on (unreferenced)

#include <stdlib.h>
#include <math.h>

#include "error.h"
#include "fix.h"

extern ubyte guess_table[];
extern short sincos_table[];
extern ushort asin_table[];
extern ushort acos_table[];
extern fix isqrt_guess_table[];

// stuff for fixpoint arithemtic pointers
// standard stuff
fix fixmul_double(fix a __asm("d0"), fix b __asm("d1"));
fix fixdiv_double(fix a __asm("d0"), fix b __asm("d1"));
fix fixmuldiv_double(fix a __asm("d0"), fix b __asm("d1"), fix c __asm("d2"));
long fixdivquadlong_double(ulong nl __asm("d0"),ulong nh __asm("d1"),ulong d __asm("d2"));
// integer versions using long instructions
extern fix fixmul_int(fix a __asm("d0"), fix b __asm("d1"));
extern fix fixdiv_int(fix a __asm("d0"), fix b __asm("d1"));
extern long fixdivquadlong_int(ulong nl __asm("d0"),ulong nh __asm("d1"),ulong d __asm("d2"));
void fixmulaccum_int(quad *q __asm("a0"),fix a __asm("d0"),fix b __asm("d1"));
// obsolete
// extern fix fixmul_short(fix a __asm("d0"), fix b __asm("d1"));
// FPU versions
extern fix fixmul_fpu(fix a __asm("d0"), fix b __asm("d1"));
extern fix fixdiv_fpu(fix a __asm("d0"), fix b __asm("d1"));
extern fix fixmuldiv_fpu(fix a __asm("d0"), fix b __asm("d1"), fix c __asm("d2"));
extern long fixdivquadlong_fpu(ulong nl __asm("d0"),ulong nh __asm("d1"),ulong d __asm("d2"));
void fixmulaccum_fpu(quad *q __asm("a0"),fix a __asm("d0"),fix b __asm("d1"));
// Function pointers for the above functions
fix (*fixmul_func)(fix a __asm("d0"), fix b __asm("d1"));
fix (*fixdiv_func)(fix a __asm("d0"), fix b __asm("d1"));
fix (*fixmuldiv_func)(fix a __asm("d0"), fix b __asm("d1"), fix c __asm("d2"));
long (*fixdivquadlong_func)(ulong nl __asm("d0"),ulong nh __asm("d1"),ulong d __asm("d2"));
void (*fixmulaccum_func)(quad *q __asm("a0"),fix a __asm("d0"),fix b __asm("d1"));


#undef DEBUG_PROFILE
#ifdef DEBUG_PROFILE
extern fix profile_fa2_time, profile_fd_time, profile_fm_time, profile_fmd_time;
extern int profile_fa2_called, profile_fd_called, profile_fm_called, profile_fmd_called;
#endif

void fix_init(void)
{

	fixmul_func         = fixmul_int;
	fixdiv_func         = fixdiv_int;
	fixmuldiv_func      = fixmuldiv_double;
	fixdivquadlong_func = fixdivquadlong_int;
	fixmulaccum_func    = fixmulaccum_int;

	if (FindArg("-fpu")) {
		fixmul_func     = fixmul_fpu;
		fixdiv_func     = fixdiv_fpu;
		fixmuldiv_func  = fixmuldiv_fpu;
		fixdivquadlong_func = fixdivquadlong_fpu;
		fixmulaccum_func    = fixmulaccum_fpu;
	}

}

//negate a quad
void fixquadnegate(quad *q)
{
	q->low  = 0 - q->low;
	q->high = 0 - q->high - (q->low != 0);
}

//multiply two ints & add 64-bit result to 64-bit sum
//void fixmulaccum_old(quad *q __asm("a0"),fix a __asm("d0"),fix b __asm("d1"))
void fixmulaccum_old(quad *q, fix a,fix b)
{
	ulong aa,bb;
	ulong ah,al,bh,bl;
	ulong t,c=0,old;
	int neg;

	neg = ((a^b) < 0);

	aa = labs(a); bb = labs(b);

	ah = aa>>16;  al = aa&0xffff;
	bh = bb>>16;  bl = bb&0xffff;

	t = ah*bl + bh*al;

	if (neg)
		fixquadnegate(q);

	old = q->low;
	q->low += al*bl;
	if (q->low < old) q->high++;
	
	old = q->low;
	q->low += (t<<16);
	if (q->low < old) q->high++;
	
	q->high += ah*bh + (t>>16) + c;
	
	if (neg)
		fixquadnegate(q);

}

//extract a fix from a quad product
fix fixquadadjust(quad *q)
{
	return (q->high<<16) + (q->low>>16);
}


#define EPSILON (F1_0/100)

fix fixmul_double(fix a __asm("d0"), fix b __asm("d1"))
{
	return (fix)(((double)a*(double)b)/65536.0);
}

fix fixdiv_double(fix a __asm("d0"), fix b __asm("d1"))
{
	return (fix)(((double)a * 65536.0) / (double)b);
}

fix fixmuldiv_double(fix a __asm("d0"), fix b __asm("d1"), fix c __asm("d2"))
{
	double d;

	d = (double)a * (double) b;
	return (fix)(d / (double) c);

}

//given cos & sin of an angle, return that angle.
//parms need not be normalized, that is, the ratio of the parms cos/sin must
//equal the ratio of the actual cos & sin for the result angle, but the parms 
//need not be the actual cos & sin.  
//NOTE: this is different from the standard C atan2, since it is left-handed.

fixang fix_atan2(fix cos,fix sin)
{
	double d, dsin, dcos;
	fix m,t;

	//Assert(!(cos==0 && sin==0));

	//find smaller of two

	dsin = (double)sin;
	dcos = (double)cos;
	d = sqrt((dsin * dsin) + (dcos * dcos));

	if (d==0.0) {
		return 0;
	}

	if (labs(sin) < labs(cos)) {                //sin is smaller, use arcsin
		t = fix_asin((fix)((dsin / d) * 65536.0));
		if (cos<0)
			t = 0x8000 - t;
		return t;
	}
	else {
		t = fix_acos((fix)((dcos / d) * 65536.0));
		if (sin<0)
			t = -t;
		return t;
	}

}

//divide a quad by a fix, returning a fix
long fixdivquadlong_double(ulong nl __asm("d0"),ulong nh __asm("d1"),ulong d __asm("d2"))
{
	int i;
	ulong tmp0;
	ubyte tmp1;
	ulong r;
	ubyte T,Q,M;

	r = 0;

	Q = ((nh&0x80000000)!=0);
	M = ((d&0x80000000)!=0);
	T = (M!=Q);

	if (M == 0)
	{
		for (i=0; i<32; i++ )   {
	
			r <<= 1;
			r |= T;
			T = ((nl&0x80000000L)!=0);
			nl <<= 1;
	
			switch( Q ) {
		
			case 0:
				Q = (unsigned char)((0x80000000L & nh) != 0 );
				nh = (nh << 1) | (unsigned long)T;

				tmp0 = nh;
				nh -= d;
				tmp1 = (nh>tmp0);
				if (Q == 0)
					Q = tmp1;
				else
					Q = (unsigned char)(tmp1 == 0);
				break;
			case 1:
				Q = (unsigned char)((0x80000000L & nh) != 0 );
				nh = (nh << 1) | (unsigned long)T;

				tmp0 = nh;
				nh += d;
				tmp1 = (nh<tmp0);
				if (Q == 0)
					Q = tmp1;
				else
					Q = (unsigned char)(tmp1 == 0);
				break;
			}
			T = (Q==M);
		}
	}
	else
	{
		for (i=0; i<32; i++ )   {
	
			r <<= 1;
			r |= T;
			T = ((nl&0x80000000L)!=0);
			nl <<= 1;
	
			switch( Q ) {
		
			case 0:
				Q = (unsigned char)((0x80000000L & nh) != 0 );
				nh = (nh << 1) | (unsigned long)T;

				tmp0 = nh;
				nh += d;
				tmp1 = (nh<tmp0);
				if (Q == 1)
					Q = tmp1;
				else
					Q = (unsigned char)(tmp1 == 0);
				break;
			case 1: 
				Q = (unsigned char)((0x80000000L & nh) != 0 );
				nh = (nh << 1) | (unsigned long)T;

				tmp0 = nh;
				nh = nh - d;
				tmp1 = (nh>tmp0);
				if (Q == 1)
					Q = tmp1;
				else
					Q = (unsigned char)(tmp1 == 0);
				break;
			}
			T = (Q==M);
		}
	}

	r = (r << 1) | T;

	return r;
}

ulong quad_sqrt(long low,long high)
{
	long cnt,r,old_r,t;
	quad tq;

	if (high<0)
		return 0;

	if (high==0 && low>=0)
		return long_sqrt(low);

	if (high & 0xff000000)
		cnt=12+16;
	else if (high & 0xff0000)
		cnt=8+16;
	else if (high & 0xff00)
		cnt=4+16;
	else
		cnt=0+16;
	
	r = guess_table[(high>>cnt)&0xff]<<cnt;

	//quad loop usually executed 4 times

	r = (fixdivquadlong(low,high,r)+r)/2;
	r = (fixdivquadlong(low,high,r)+r)/2;
	r = (fixdivquadlong(low,high,r)+r)/2;

	do {

		old_r = r;
		t = fixdivquadlong(low,high,r);

		if (t==r)   //got it!
			return r;
 
		r = (t+r)/2;

	} while (!(r==t || r==old_r));

	t = fixdivquadlong(low,high,r);
	tq.low=tq.high;
	fixmulaccum(&tq,r,t);
	if (tq.low!=low || tq.high!=high)
		r++;

	return r;
}

//computes the square root of a long, returning a short
ushort long_sqrt(long a)
{
	int cnt,r,old_r,t;

	if (a<=0)
		return 0;

	if (a & 0xff000000)
		cnt=12;
	else if (a & 0xff0000)
		cnt=8;
	else if (a & 0xff00)
		cnt=4;
	else
		cnt=0;
	
	r = guess_table[(a>>cnt)&0xff]<<cnt;

	//the loop nearly always executes 3 times, so we'll unroll it 2 times and
	//not do any checking until after the third time.  By my calcutations, the
	//loop is executed 2 times in 99.97% of cases, 3 times in 93.65% of cases, 
	//four times in 16.18% of cases, and five times in 0.44% of cases.  It never
	//executes more than five times.  By timing, I determined that is is faster
	//to always execute three times and not check for termination the first two
	//times through.  This means that in 93.65% of cases, we save 6 cmp/jcc pairs,
	//and in 6.35% of cases we do an extra divide.  In real life, these numbers
	//might not be the same.

	r = ((a/r)+r)/2;
	r = ((a/r)+r)/2;

	do {

		old_r = r;
		t = a/r;

		if (t==r)   //got it!
			return r;
 
		r = (t+r)/2;

	} while (!(r==t || r==old_r));

	if (a % r)
		r++;

	return r;
}

//computes the square root of a fix, returning a fix
fix fix_sqrt(fix a)
{
	return ((fix) long_sqrt(a)) << 8;
}


//compute sine and cosine of an angle, filling in the variables
//either of the pointers can be NULL
//with interpolation
void fix_sincos(fix a,fix *s,fix *c)
{
	int i,f;
	fix ss,cc;

	i = (a>>8)&0xff;
	f = a&0xff;

	ss = sincos_table[i];
	if (s) *s = (ss + (((sincos_table[i+1] - ss) * f)>>8))<<2;

	cc = sincos_table[i+64];
	if (c) *c = (cc + (((sincos_table[i+64+1] - cc) * f)>>8))<<2;
}

//compute sine and cosine of an angle, filling in the variables
//either of the pointers can be NULL
//no interpolation
void fix_fastsincos(fix a,fix *s,fix *c)
{
	int i;

	i = (a>>8)&0xff;

	if (s) *s = sincos_table[i] << 2;
	if (c) *c = sincos_table[i+64] << 2;
}

//compute inverse sine
fixang fix_asin(fix v)
{
	fix vv;
	int i,f,aa;

	vv = labs(v);

	if (vv >= f1_0)     //check for out of range
		return 0x4000;

	i = (vv>>8)&0xff;
	f = vv&0xff;

	aa = asin_table[i];
	aa = aa + (((asin_table[i+1] - aa) * f)>>8);

	if (v < 0)
		aa = -aa;

	return aa;
}

//compute inverse cosine
fixang fix_acos(fix v)
{
	fix vv;
	int i,f,aa;

	vv = labs(v);

	if (vv >= f1_0)     //check for out of range
		return 0;

	i = (vv>>8)&0xff;
	f = vv&0xff;

	aa = acos_table[i];
	aa = aa + (((acos_table[i+1] - aa) * f)>>8);

	if (v < 0)
		aa = 0x8000 - aa;

	return aa;
}

#define TABLE_SIZE 1024

//for passed value a, returns 1/sqrt(a) 
fix fix_isqrt( fix a )
{
	int i, b = a;
	int cnt = 0;
	int r;

	if ( a == 0 ) return 0;

	while( b >= TABLE_SIZE )    {
		b >>= 1;
		cnt++;
	}

	//printf( "Count = %d (%d>>%d)\n", cnt, b, (cnt+1)/2 );
	r = isqrt_guess_table[b] >> ((cnt+1)/2);

	//printf( "Initial r = %d\n", r );

	for (i=0; i<3; i++ )    {
		int old_r = r;
		r = fixmul( ( (3*65536) - fixmul(fixmul(r,r),a) ), r) / 2;
		//printf( "r %d  = %d\n", i, r );
		if ( old_r >= r ) return (r+old_r)/2;
	}

	return r;   
}


// Emacs style mode select   -*- C++ -*-
//-----------------------------------------------------------------------------
//
// $Id: m_fixed.h,v 1.5 1998/05/10 23:42:22 killough Exp $
//
//  BOOM, a modified and improved DOOM engine
//  Copyright (C) 1999 by
//  id Software, Chi Hoang, Lee Killough, Jim Flynn, Rand Phares, Ty Halderman
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 
//  02111-1307, USA.
//
// DESCRIPTION:
//      Fixed point arithemtics, implementation.
//
//-----------------------------------------------------------------------------

#ifndef __M_FIXED__
#define __M_FIXED__

#ifdef __GNUG__
#pragma interface
#endif

#include "i_system.h"



//
// Fixed point, 32bit as 16.16.
//

#define FRACBITS 16
#define FRACUNIT (1<<FRACBITS)

typedef int fixed_t;



#define version060 1


static __inline__ fixed_t FixedMul(fixed_t eins,fixed_t zwei)
{
	
#ifndef version060

	__asm __volatile
	("muls.l %1,%1:%0 \n\t"
	 "move %1,%0 \n\t"
	 "swap %0 "
					 
	  : "=d" (eins), "=d" (zwei)
	  : "0" (eins), "1" (zwei)
	);

	return eins;

#else
	__asm __volatile
	("fmove.l	%0,fp0 \n\t"
	 "fmul.l	%2,fp0 \n\t"
	 "fmul.x	fp7,fp0 \n\t"

/*	 "fintrz.x	fp0,fp0 \n\t"*/
	 "fmove.l	fp0,%0"
					 
	  : "=d" (eins)
	  : "0" (eins), "d" (zwei)
	  : "fp0"
	);

	return eins;

#endif

}


static __inline__ fixed_t FixedDiv(fixed_t eins,fixed_t zwei)
{
	__asm __volatile

#ifndef version060
	("move.l	%0,d3\n\t"
	 "swap      %0\n\t"
	 "move.w    %0,d2\n\t"
	 "ext.l		d2\n\t"
	 "clr.w		%0\n\t"
	 "tst.l		%1\n\t"
	 "jeq		3f\n\t"
	 "divs.l	%1,d2:%0\n\t"
	 "jvc		1f\n"

	 "3: eor.l %1,d3\n\t"
	 "jmi       2f\n\t"
	 "move.l	#0x7FFFFFFF,%0\n\t"
	 "jra		1f\n"

	 "2: move.l #0x80000000,%0\n"
	 "1:\n"
	 
	 : "=d" (eins), "=d" (zwei)
	 : "0" (eins), "1" (zwei)
	 : "d2","d3"
	);
#else
	("tst.l		%1\n\t"
	 "jne		1f\n\t"

	 "eor.l		 %1,%0\n\t"
	 "jmi       2f\n\t"
	 "move.l	#0x7FFFFFFF,%0\n\t"
	 "jra		9f\n"

	 "2: move.l #0x80000000,%0\n\t"
     "jra		9f\n"
     
	 "1: fmove.l %0,fp0 \n\t"
	 "fdiv.l	%2,fp0 \n\t"
	 "fmul.x		fp6,fp0 \n\t"
/*	 "fintrz.x  fp0\n\t"*/
	 "fmove.l	fp0,%0\n"

	 "9:\n"
	 
	 : "=d" (eins)
	 : "0" (eins), "d" (zwei)
	 : "fp0"
	);
#endif
	return eins;
}



#endif




//----------------------------------------------------------------------------
//
// $Log: m_fixed.h,v $
// Revision 1.5  1998/05/10  23:42:22  killough
// Add inline assembly for djgpp (x86) target
//
// Revision 1.4  1998/04/27  01:53:37  killough
// Make gcc extensions #ifdef'ed
//
// Revision 1.3  1998/02/02  13:30:35  killough
// move fixed point arith funcs to m_fixed.h
//
// Revision 1.2  1998/01/26  19:27:09  phares
// First rev with no ^Ms
//
// Revision 1.1.1.1  1998/01/19  14:02:53  rand
// Lee's Jan 19 sources
//
//----------------------------------------------------------------------------
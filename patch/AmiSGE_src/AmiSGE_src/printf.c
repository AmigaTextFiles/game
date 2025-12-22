//========================================================================
//========================================================================
//
//  AmiSGE - formatted output functions
//
//	(c) 1999 John Girvin/Halibut Software, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//========================================================================
//========================================================================

#include	"printf.h"

//=========================================================================
// Tiny sprintf replacement
//=========================================================================
VOID gfSprintf(
				      UBYTE * const a_to,
				const UBYTE * const a_fmt,
				...
			  )
{
	static ULONG fmtfunc = 0x16C04E75;
 	RawDoFmt(a_fmt, &a_fmt + 1, (APTR)&fmtfunc, a_to);
}

//=========================================================================
// Tiny printf replacement
//=========================================================================
VOID gfPrintf(
				const UBYTE * const a_fmt,
				...
			 )
{
	static UBYTE buf[1024];
	static ULONG fmtfunc = 0x16C04E75;

 	RawDoFmt(a_fmt, &a_fmt + 1, (APTR)&fmtfunc, buf);
	PutStr(buf);
}

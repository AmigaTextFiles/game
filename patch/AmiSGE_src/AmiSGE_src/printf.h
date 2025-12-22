//========================================================================
//========================================================================
//
//  AmiSGE - formatted output functions, header file
//
//	(c) 1999 John Girvin/Halibut Software, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//========================================================================
//========================================================================

#include	<exec/types.h>
#include	<pragmas/dos_pragmas.h>
#include	<pragmas/exec_pragmas.h>
#include	<clib/dos_protos.h>
#include	<clib/exec_protos.h>

//=========================================================================
// External references
//=========================================================================
extern struct Library *DOSBase;

//=========================================================================
// Function prototypes
//=========================================================================
VOID gfSprintf(UBYTE * const, const UBYTE * const, ...);
VOID gfPrintf(const UBYTE * const, ...);

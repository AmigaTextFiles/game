//=========================================================================
//=========================================================================
//
//	AmiSGE - file access functions, header file
// 
//	(c) 1999 John Girvin/Halibut Software, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================

#include <dos.h>
#include <exec/types.h>
//#include <exec/memory.h>

#include <clib/dos_protos.h>
//#include <clib/exec_protos.h>
#include <pragmas/dos_pragmas.h>
//#include <pragmas/exec_pragmas.h>

//#include <stdio.h>
//#include <stdlib.h>
//#include <string.h>
//#include <ctype.h>

//=========================================================================
// External references
//=========================================================================
extern struct Library *DOSBase;

//=========================================================================
// Function prototypes
//=========================================================================
BOOL gfReadFile(STRPTR, APTR, ULONG *);
BOOL gfWriteFile(STRPTR, APTR, ULONG);

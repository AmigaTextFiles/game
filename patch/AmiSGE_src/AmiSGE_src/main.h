//=========================================================================
//=========================================================================
//
//	AmiSGE - main header file
//
//	(c) 1999 John Girvin/Halibut Software, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================

#include	<exec/types.h>

//=========================================================================
// Version and ID strings
//=========================================================================
#define	APPNAME			"AmiSGE"
#define	APPVERSION		"v1.00"
#define COPYSTRING		"© 1999 John Girvin/Halibut Software"
#define VERSIONSTRING	"$VER: " APPNAME " " APPVERSION " " __AMIGADATE__
#define FULLIDSTRING	APPNAME " " APPVERSION " (" __DATE__ " "  __TIME__ ") " COPYSTRING

//=========================================================================
// Miscellaneous defines
//=========================================================================
#define	BUFFER_LENGTH	65536

//=========================================================================
// Structures
//=========================================================================

//=========================================================================
// External function prototypes
//=========================================================================
__asm ULONG gfMakeClearBuffer(register __a0 UBYTE *, register __a1 UBYTE *, register __d1 ULONG);
__asm ULONG gfMakeCloudBuffer(register __a0 UBYTE *, register __a1 UBYTE *);

//=========================================================================
// External references
//=========================================================================
extern struct Library *DOSBase;
extern struct Library *IntuitionBase;
extern struct Library *SysBase;

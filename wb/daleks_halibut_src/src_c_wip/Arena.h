//=========================================================================
//=========================================================================
//
//	Daleks Arena MUI Custom Class - header file
//
//	Copyright 1998 Halibut Software/John Girvin, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================
#include	<exec/types.h>
#include	<exec/libraries.h>

//=========================================================================
// Attributes
//=========================================================================
#define	MUIA_DaleksArena_Width	(TAG_USER|(960<<16)|0x0000)
#define	MUIA_DaleksArena_Height	(TAG_USER|(960<<16)|0x0001)

//=========================================================================
// Dispatcher interface
//=========================================================================

extern __asm __saveds ULONG
DaleksArena_dispatcher(	register __a0 struct IClass *,
						register __a2 Object *,
						register __a1 Msg
					);

struct DaleksArena_Data
{
	ULONG	Height;		// Height in pixels
	ULONG	Width;		// Width in pixels
};

extern struct Library *MUIMasterBase;
extern struct Library *DataTypesBase;
extern struct Library *IntuitionBase;
extern struct Library *UtilityBase;

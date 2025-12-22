//=========================================================================
//=========================================================================
//
//	Timer MUI Custom Class - header file
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
#ifndef		LIBRARIES_MUI_H
#include	<libraries/mui.h>
#endif

//=========================================================================
// Attributes & methods
//=========================================================================
#define MUIM_DaleksTimer_SecTrigger	(TAG_USER|(960<<16)|0x1000)

#define MUIA_DaleksTimer_TickValue	(TAG_USER|(960<<16)|0x1001)
#define MUIV_DaleksTimer_Tick		(TAG_USER|(960<<16)|0x1002)

//=========================================================================
// Dispatcher interface
//=========================================================================
extern __asm __saveds
ULONG DaleksTimer_dispatcher(	register __a0 struct IClass *,
								register __a2 Object *,
								register __a1 Msg
							);

struct DaleksTimer_Data
{
	struct MUI_InputHandlerNode IHNode;
	ULONG Tick;
};

extern struct Library *MUIMasterBase;
extern struct Library *DataTypesBase;
extern struct Library *IntuitionBase;
extern struct Library *UtilityBase;

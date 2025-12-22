//=========================================================================
//=========================================================================
//
//	Daleks Arena MUI Custom Class - main file
//
//	Copyright 1998 Halibut Software/John Girvin, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================

#ifndef		LIBRARIES_MUI_H
#include	<libraries/mui.h>
#endif
#include	"Arena.h"

// Headers
#include	<datatypes/datatypes.h>
#include	<graphics/gfx.h>
#include	<utility/utility.h>
#include	<utility/tagitem.h>

// Prototypes
#include	<clib/alib_protos.h>
#include	<clib/intuition_protos.h>
#include	<clib/datatypes_protos.h>
#include	<clib/graphics_protos.h>
#include	<clib/muimaster_protos.h>
#include	<clib/utility_protos.h>

// pragmas
#include	<pragmas/intuition_pragmas.h>
#include	<pragmas/datatypes_pragmas.h>
#include	<pragmas/graphics_pragmas.h>
#include	<pragmas/muimaster_pragmas.h>
#include	<pragmas/utility_pragmas.h>

// ANSI C
#include	<stdlib.h>
#include	<string.h>
#include	<stdio.h>

//=========================================================================
// new method
//=========================================================================
static
ULONG DaleksArena_new(
					struct IClass	*cl,
					Object			*obj,
					struct opSet	*msg
				   )
{
	struct DaleksArena_Data *Data;

    if (!(obj=(Object *)DoSuperMethodA(cl, obj, (Msg)msg)))
	{
        return(0);
	}

    Data = INST_DATA(cl, obj);

	// Get the height and width attributes
	Data->Height = GetTagData(MUIA_DaleksArena_Height, 1, msg->ops_AttrList);
	Data->Width  = GetTagData(MUIA_DaleksArena_Width , 1, msg->ops_AttrList);

    return((ULONG)obj);
}


//=========================================================================
// setup method
//=========================================================================
static
ULONG DaleksArena_setup(
						struct IClass	*cl,
						Object			*obj,
						struct MUIP_Setup *msg
					 )
{
    return(DoSuperMethodA(cl,obj,(Msg)msg));
}


//=========================================================================
// cleanup method
//=========================================================================
static
ULONG DaleksArena_cleanup(
						struct IClass	*cl,
						Object			*obj,
						Msg				msg
					   )
{
	return(DoSuperMethodA(cl,obj,msg));
}


//=========================================================================
// MUI AskMinMax method
//=========================================================================
static
ULONG DaleksArena_askMinMax(
							struct IClass	*cl,
							Object			*obj,
							struct MUIP_AskMinMax *msg
						 )
{
	struct DaleksArena_Data	*Data = INST_DATA(cl, obj);
	struct MUI_MinMax		*MinMax;

	DoSuperMethodA(cl,obj,(Msg)msg);

	MinMax = msg -> MinMaxInfo;

	if (Data && Data->Height >= 1 && Data->Width >= 1)
	{
		MinMax -> MinWidth  += Data->Width;
		MinMax -> MinHeight += Data->Height;
		MinMax -> DefWidth  += Data->Width;
		MinMax -> DefHeight += Data->Height;
		MinMax -> MaxWidth  += Data->Width;
		MinMax -> MaxHeight += Data->Height;
	}

    return(0);
}


//=========================================================================
// draw method
//=========================================================================
static
ULONG DaleksArena_draw(
						struct IClass	*cl,
						Object			*obj,
						struct MUIP_Draw *msg
					)
{
	DoSuperMethodA(cl,obj,(Msg)msg);

	if (msg->flags & MADF_DRAWOBJECT)
	{
	}

    return(0);
}


//=========================================================================
//=========================================================================
// THE DISPATCHER
//=========================================================================
//=========================================================================
__saveds __asm
ULONG DaleksArena_dispatcher(
							register __a0 struct IClass	*cl,
							register __a2 Object		*obj,
							register __a1 Msg			msg
						  )
{
	switch (msg->MethodID)
	{
        case OM_NEW:
			return(DaleksArena_new(cl, obj, (APTR)msg));
			break;

		case MUIM_Setup:
			return(DaleksArena_setup(cl, obj, (APTR)msg));
			break;

		case MUIM_Cleanup:
			return(DaleksArena_cleanup(cl, obj, (APTR)msg));
			break;

		case MUIM_AskMinMax:
			return(DaleksArena_askMinMax(cl, obj, (APTR)msg));
			break;

		case MUIM_Draw:
			return(DaleksArena_draw(cl, obj, (APTR)msg));
			break;
	}

	return(DoSuperMethodA(cl,obj,msg));
}

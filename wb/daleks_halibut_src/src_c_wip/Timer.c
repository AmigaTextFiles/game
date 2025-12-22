//=========================================================================
//=========================================================================
//
//	Timer MUI Custom Class - main file
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
#include	<exec/types.h>
#include	<exec/libraries.h>
#include	"Timer.h"

// Headers
#include	<utility/utility.h>
#include	<utility/tagitem.h>

// Prototypes
#include	<clib/alib_protos.h>
#include	<clib/muimaster_protos.h>
#include	<clib/utility_protos.h>

// pragmas
#include	<pragmas/intuition_pragmas.h>
#include	<pragmas/muimaster_pragmas.h>
#include	<pragmas/utility_pragmas.h>

// ANSI C
//#include	<stdlib.h>
//#include	<string.h>
#include	<stdio.h>


//=========================================================================
// new method
//=========================================================================
static
ULONG DaleksTimer_new(
						struct IClass	*cl,
						Object			*obj,
						struct opSet	*msg
					 )
{
	struct DaleksTimer_Data *Data;

    obj = (Object *)DoSuperMethod(cl,obj, OM_NEW, msg->ops_AttrList);

	if (obj)
	{
		Data = (struct DaleksTimer_Data *)INST_DATA(cl,obj);

		Data->IHNode.ihn_Object  = obj;
		Data->IHNode.ihn_Method  = MUIM_DaleksTimer_SecTrigger;
		Data->IHNode.ihn_Flags   = MUIIHNF_TIMER;
		Data->IHNode.ihn_Millis  = 1000;

		Data->Tick = 0;
	}

	SetAttrs(obj, MUIA_ShowMe, FALSE, TAG_DONE);
    return((ULONG)obj);
}

//=========================================================================
// dispose method
//=========================================================================
static
ULONG DaleksTimer_dispose(
							struct IClass	*cl,
							Object			*obj,
							Msg				msg
					 	)
{
    return(DoSuperMethodA(cl,obj,msg));
}


//=========================================================================
// setup method
//=========================================================================
static
ULONG DaleksTimer_setup(
						struct IClass	*cl,
						Object			*obj,
						struct MUIP_Setup *msg
					   )
{
	struct DaleksTimer_Data *Data = INST_DATA(cl, obj);

    if (!DoSuperMethodA(cl,obj,(Msg)msg))
	{
        return(FALSE);
	}

    DoMethod(_app(obj), MUIM_Application_AddInputHandler, &Data->IHNode);
    return(TRUE);
}


//=========================================================================
// cleanup method
//=========================================================================
static
ULONG DaleksTimer_cleanup(
						struct IClass	*cl,
						Object			*obj,
						Msg				msg
					   )
{
	struct DaleksTimer_Data *Data = INST_DATA(cl, obj);

    DoMethod(_app(obj), MUIM_Application_RemInputHandler, &Data->IHNode);

	return(DoSuperMethodA(cl,obj,msg));
}


//=========================================================================
// MUI AskMinMax method
//=========================================================================
static
ULONG DaleksTimer_askMinMax(
							struct IClass	*cl,
							Object			*obj,
							struct MUIP_AskMinMax *msg
						 )
{
	DoSuperMethodA(cl,obj,(Msg)msg);
    return(0);
}


//=========================================================================
// draw method
//=========================================================================
static
ULONG DaleksTimer_draw(
						struct IClass	*cl,
						Object			*obj,
						struct MUIP_Draw *msg
					)
{
	DoSuperMethodA(cl,obj,(Msg)msg);
    return(0);
}

//=========================================================================
// MUIM_DaleksTimer_SecTrigger
// Called every second
//=========================================================================
static __saveds
ULONG DaleksTimer_secTrigger(
								struct IClass	*cl,
								Object			*obj,
								Msg				msg
							)
{
	struct DaleksTimer_Data *Data = (struct DaleksTimer_Data *)INST_DATA(cl, obj);

	Data->Tick++;

	DoMethod(_app(obj), MUIM_Application_ReturnID, MUIV_DaleksTimer_Tick);

    return(FALSE);
}

//=========================================================================
// set method
//=========================================================================
static __saveds
ULONG DaleksTimer_set(
						struct IClass	*cl,
						Object			*obj,
						struct opSet	*msg
					 )
{
	struct DaleksTimer_Data *Data;
    struct TagItem *TickTag = FindTagItem(MUIA_DaleksTimer_TickValue, msg -> ops_AttrList);

    if (TickTag)
	{
		Data =  (struct DaleksTimer_Data *)INST_DATA(cl, obj);
		Data->Tick = TickTag->ti_Data;
    }

    return(DoSuperMethodA(cl,obj,(Msg)msg));
}


//=========================================================================
// get method
//=========================================================================
static __saveds
ULONG DaleksTimer_get(
						struct IClass	*cl,
						Object			*obj,
						struct opGet	*msg
					 )
{
	struct DaleksTimer_Data *Data = (struct DaleksTimer_Data *)INST_DATA(cl, obj);

	switch (msg->opg_AttrID)
	{
		case MUIA_DaleksTimer_TickValue:
			*(msg->opg_Storage) = Data->Tick;
			break;
	}

    return(DoSuperMethodA(cl,obj,(Msg)msg));
}


//=========================================================================
//=========================================================================
// THE DISPATCHER
//=========================================================================
//=========================================================================
__saveds __asm
ULONG DaleksTimer_dispatcher(
							register __a0 struct IClass	*cl,
							register __a2 Object		*obj,
							register __a1 Msg			msg
						  )
{
	switch (msg->MethodID)
	{
        case OM_NEW:
			return(DaleksTimer_new(cl, obj, (struct opSet *)msg));
			break;

        case OM_DISPOSE:
			return(DaleksTimer_dispose(cl, obj, (APTR)msg));
			break;

		case MUIM_Setup:
			return(DaleksTimer_setup(cl, obj, (APTR)msg));
			break;

		case MUIM_Cleanup:
			return(DaleksTimer_cleanup(cl, obj, (APTR)msg));
			break;

		case MUIM_AskMinMax:
			return(DaleksTimer_askMinMax(cl, obj, (APTR)msg));
			break;

		case MUIM_Draw:
			return(DaleksTimer_draw(cl, obj, (APTR)msg));
			break;

		case MUIM_DaleksTimer_SecTrigger:
			return(DaleksTimer_secTrigger(cl, obj, (APTR)msg));
			break;

        case OM_SET:
			return(DaleksTimer_set(cl, obj, (struct opSet *)msg));
			break;

        case OM_GET:
			return(DaleksTimer_get(cl, obj, (struct opGet *)msg));
			break;
	}

	return(DoSuperMethodA(cl,obj,msg));
}

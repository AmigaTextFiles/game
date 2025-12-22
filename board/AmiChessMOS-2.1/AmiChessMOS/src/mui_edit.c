#include <clib/alib_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>
#include <clib/muimaster_protos.h>
#include <clib/utility_protos.h>
#include <stdlib.h>
#include <emul/emulregs.h>
#include "common.h"

extern Object *piecesedit;
extern struct BitMap *pieces_edit_bm;
extern APTR pieces_edit_mask;

struct Data
{
int num;
};

struct MUI_CustomClass *MUI_Edit_Class;

static ULONG mNew(struct IClass *cl,Object *obj,struct opSet *msg)
{
obj=DoSuperNew(cl,obj,
        ImageButtonFrame,
        MUIA_FixWidth,45,
        MUIA_FixHeight,45,
        MUIA_Draggable,1,
TAG_MORE,msg->ops_AttrList);
if(obj)
        {
        struct Data *data=(struct Data *)INST_DATA(cl,obj);
        data->num=GetTagData(MUIA_UserData,0,msg->ops_AttrList);
        }
return(ULONG)obj;
}

static ULONG mAskMinMax(struct IClass *cl,Object *obj,struct MUIP_AskMinMax *msg)
{
struct MUI_MinMax *mm;
DoSuperMethodA(cl,obj,(Msg)msg);
mm=msg->MinMaxInfo;
mm->MinWidth+=45;
mm->MinHeight+=45;
mm->MaxWidth+=45;
mm->MaxHeight+=45;
mm->DefWidth+=45;
mm->DefHeight+=45;
return 0;
}

static ULONG mDraw(struct IClass *cl,Object *obj,Msg msg)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
DoSuperMethodA(cl,obj,msg);
BltMaskBitMapRastPort(pieces_edit_bm,(data->num-100)*45,0,_rp(obj),_mleft(obj),_mtop(obj)+1,45,43,ANBC|ABNC|ABC,pieces_edit_mask);
return 0;
}

static ULONG Dispatcher(void)
{
Class *cl = (Class*)REG_A0;
Object *obj = (Object*)REG_A2;
Msg msg = (Msg)REG_A1;
ULONG retval = 0;
switch(msg->MethodID)
        {
        case OM_NEW:
                retval=mNew(cl,obj,(struct opSet *)msg);
                break;
        case MUIM_AskMinMax:
                retval=mAskMinMax(cl,obj,(struct MUIP_AskMinMax *)msg);
                break;
        case MUIM_Draw:
                retval=mDraw(cl,obj,msg);
                break;
        default:
                retval=DoSuperMethodA(cl,obj,msg);
        }
return retval;
}

struct EmulLibEntry MUIEditGate = {TRAP_LIB, 0, (void(*)(void))Dispatcher};

void INIT_6_MUI_Edit_Class(void)
{
if(!(MUI_Edit_Class=MUI_CreateCustomClass(0,MUIC_Area,0,sizeof(struct Data),(APTR)&MUIEditGate))) exit(20);
}

void EXIT_6_MUI_Edit_Class(void)
{
if(MUI_Edit_Class) MUI_DeleteCustomClass(MUI_Edit_Class);
}


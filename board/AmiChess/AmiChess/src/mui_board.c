#include <clib/alib_protos.h>
#include <clib/intuition_protos.h>
#include <clib/muimaster_protos.h>
#include <stdlib.h>
#include "common.h"

extern struct MUI_CustomClass *MUI_Field_Class;
extern ULONG pix_x;

struct MUI_CustomClass *MUI_Board_Class;

struct Data
{
Object *field[64];
Object *texta[8],*text1[8];
APTR font;
};

static ULONG mNew(struct IClass *cl,Object *obj,struct opSet *msg)
{
obj=DoSuperNew(cl,obj,
	MUIA_Group_Columns,9,
	MUIA_Group_Spacing,0,
TAG_MORE,msg->ops_AttrList);
if(obj)
	{
	struct Data *data=(struct Data *)INST_DATA(cl,obj);
	ULONG i;
	for(i=0;i<64;i++)
		{
		if(i%8==0) DoMethod(obj,OM_ADDMEMBER,data->text1[i/8]=TextObject,MUIA_FixWidthTxt,"W",MUIA_Font,MUIV_Font_Big,MUIA_Text_PreParse,MUIX_B,End);
		DoMethod(obj,OM_ADDMEMBER,data->field[i]=NewObject(MUI_Field_Class->mcc_Class,0,MUIA_UserData,i,TAG_END));
		}
	DoMethod(obj,OM_ADDMEMBER,HVSpace);
	for(i=0;i<8;i++) DoMethod(obj,OM_ADDMEMBER,data->texta[i]=TextObject,MUIA_Font,MUIV_Font_Big,MUIA_Text_PreParse,"\033c\033b",MUIA_FixWidthTxt,"W",End);
	}
return (ULONG)obj;
}

static void	mChessShowBoard(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
char t[2];
int i;
t[1]=0;
for(i=0;i<8;i++)
	{
	if(flags&REVERSEBOARD) t[0]='h'-i;
	else t[0]='a'+i;
	SetAttrs(data->texta[i],MUIA_Text_Contents,t,TAG_END);
	if(flags&REVERSEBOARD) t[0]='1'+i;
	else t[0]='8'-i;
	SetAttrs(data->text1[i],MUIA_Text_Contents,t,TAG_END);
	}
MUI_Redraw(obj,MADF_DRAWOBJECT);
}

static ULONG Dispatcher(struct IClass *cl __asm("a0"),Object *obj  __asm("a2"),Msg msg  __asm("a1"))
{
ULONG retval;
switch(msg->MethodID)
	{
	case OM_NEW:
		retval=mNew(cl,obj,(struct opSet *)msg);
		break;
	case MUIM_Chess_ShowBoard:
		mChessShowBoard(cl,obj);
		break;
	default:
		retval=DoSuperMethodA(cl,obj,msg);
	}
return retval;
}

void INIT_6_MUI_Board_Class(void)
{
if(!(MUI_Board_Class=MUI_CreateCustomClass(0,MUIC_Group,0,sizeof(struct Data),(APTR)Dispatcher))) exit(20);
}

void EXIT_6_MUI_Board_Class(void)
{
if(MUI_Board_Class) MUI_DeleteCustomClass(MUI_Board_Class);
}


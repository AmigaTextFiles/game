/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 30.09.98 16:22                               */
/************************************************/

#include <proto/utility.h>

/* Mastermind */
#include "GUI.h"
#include "Locale.h"

/* Functions */
ULONG        PopSymbol_New(struct IClass *cl, Object *obj, struct opSet *msg);
ULONG        PopSymbol_Set(struct IClass *cl, Object *obj, struct opSet *msg);
ULONG        PopSymbol_Get(struct IClass *cl, Object *obj, struct opGet *msg);
ULONG        PopSymbol_NeuesBT   (struct IClass *cl, Object *obj, Msg msg);
ULONG        PopSymbol_DragQuery (struct IClass *cl, Object *obj, struct MUIP_DragQuery *msg);
ULONG        PopSymbol_DragDrop  (struct IClass *cl, Object *obj, struct MUIP_DragDrop *msg);
ULONG SAVEDS PopSymbol_Dispatcher(REG(a0) struct IClass *cl, REG(a2) Object *obj, REG(a1) Msg msg);

/* Structures */
extern struct ObjApp *App;     /* Application object */
struct MUIS_ImageButton_Image EingabeStruct;


ULONG PopSymbol_New(struct IClass *cl, Object *obj, struct opSet *msg)
{
   APTR IB_Palette[6], GR_Palette; //, PopupString;

   struct PopSymbol_Data *Data;
//   struct TagItem *tags, *tag;

   if (!(obj = (Object *)DoSuperMethodA(cl, obj, (Msg)msg)))
      return(0);

   Data = INST_DATA(cl, obj);

   /* parse initial taglist */
/*   for (tags = msg->ops_AttrList; tag = NextTagItem(&tags); )
      {
         switch (tag->ti_Tag)
            {
               case MUIA_PopSymbol_EingabeID:
                  Data->EingabeID = tag->ti_Data;
                  break;
            }
      }
*/
   Data->PaletteID = 0;

   EingabeStruct.ibi_ImageType       = MUIV_ImageButton_ImageType_Image;
   EingabeStruct.ibi_FontMatchWidth  = FALSE;
   EingabeStruct.ibi_FontMatchHeight = FALSE;
   EingabeStruct.ibi_FreeHoriz       = TRUE;
   EingabeStruct.ibi_FreeVert        = TRUE;
   EingabeStruct.ibi_OldImage        = NULL;
   EingabeStruct.ibi_State           = 0;

   // Symbolwahl Gruppe

   EingabeStruct.ibi_Spec = App->STR_SymbolBild[0];
   IB_Palette[0] = ImageButtonObject,
      MUIA_ImageButton_Image, &EingabeStruct,
      MUIA_ImageButton_Label, App->STR_SymbolText[0],
      MUIA_ImageButton_LabelPos, MUIV_ImageButton_LabelPos_Bottom,
      MUIA_CycleChain, 1,
   End,

   EingabeStruct.ibi_Spec = App->STR_SymbolBild[1];
   IB_Palette[1] = ImageButtonObject,
      MUIA_ImageButton_Image, &EingabeStruct,
      MUIA_ImageButton_Label, App->STR_SymbolText[1],
      MUIA_ImageButton_LabelPos, MUIV_ImageButton_LabelPos_Bottom,
      MUIA_CycleChain, 1,
   End,

   EingabeStruct.ibi_Spec = App->STR_SymbolBild[2];
   IB_Palette[2] = ImageButtonObject,
      MUIA_ImageButton_Image, &EingabeStruct,
      MUIA_ImageButton_Label, App->STR_SymbolText[2],
      MUIA_ImageButton_LabelPos, MUIV_ImageButton_LabelPos_Bottom,
      MUIA_CycleChain, 1,
   End,

   EingabeStruct.ibi_Spec = App->STR_SymbolBild[3];
   IB_Palette[3] = ImageButtonObject,
      MUIA_ImageButton_Image, &EingabeStruct,
      MUIA_ImageButton_Label, App->STR_SymbolText[3],
      MUIA_ImageButton_LabelPos, MUIV_ImageButton_LabelPos_Bottom,
      MUIA_CycleChain, 1,
   End,

   EingabeStruct.ibi_Spec = App->STR_SymbolBild[4];
   IB_Palette[4] = ImageButtonObject,
      MUIA_ImageButton_Image, &EingabeStruct,
      MUIA_ImageButton_Label, App->STR_SymbolText[4],
      MUIA_ImageButton_LabelPos, MUIV_ImageButton_LabelPos_Bottom,
      MUIA_CycleChain, 1,
   End,

   EingabeStruct.ibi_Spec = App->STR_SymbolBild[5];
   IB_Palette[5] = ImageButtonObject,
      MUIA_ImageButton_Image, &EingabeStruct,
      MUIA_ImageButton_Label, App->STR_SymbolText[5],
      MUIA_ImageButton_LabelPos, MUIV_ImageButton_LabelPos_Bottom,
      MUIA_CycleChain, 1,
   End,

   GR_Palette = ColGroup(2),
      MUIA_Background, MUII_GroupBack,
      MUIA_Frame, MUIV_Frame_Group,
      MUIA_FrameTitle, GetString(LBL_SYMBOLE),
      MUIA_ShortHelp, GetString(BBL_GR_PALETTE),
      Child, IB_Palette[0],
      Child, IB_Palette[1],
      Child, IB_Palette[2],
      Child, IB_Palette[3],
      Child, IB_Palette[4],
      Child, IB_Palette[5],
   End;

   // Popup Knopf

   EingabeStruct.ibi_Spec = App->STR_SymbolBild[0];
   SetAttrs(obj,
            MUIA_ImageButton_Image, &EingabeStruct,
            MUIA_ImageButton_Label, App->STR_SymbolText[0],
            MUIA_ImageButton_LabelPos, MUIV_ImageButton_LabelPos_Bottom,
            MUIA_CycleChain, 1,
            MUIA_Dropable, TRUE,
            MUIA_Draggable, TRUE,
            TAG_DONE
           );

/*   PopupString = StringObject,
      MUIA_String_Contents, "",
      MUIA_ShowMe, FALSE,
   End;
*/
   Data->POP_Popup = PopobjectObject,
//      MUIA_Popstring_String, PopupString,
      MUIA_Popstring_Button, obj,
      MUIA_Popobject_Object, GR_Palette,
   End;


   if (!Data->POP_Popup)
      return(NULL);

   DoMethod(IB_Palette[0],
            MUIM_Notify, MUIA_Pressed, FALSE,
            Data->POP_Popup,
            3,
            MUIM_Set, MUIA_PopSymbol_PaletteID, 0
           );

   DoMethod(IB_Palette[1],
            MUIM_Notify, MUIA_Pressed, FALSE,
            Data->POP_Popup,
            3,
            MUIM_Set, MUIA_PopSymbol_PaletteID, 1
           );

   DoMethod(IB_Palette[2],
            MUIM_Notify, MUIA_Pressed, FALSE,
            Data->POP_Popup,
            3,
            MUIM_Set, MUIA_PopSymbol_PaletteID, 2
           );

   DoMethod(IB_Palette[3],
            MUIM_Notify, MUIA_Pressed, FALSE,
            Data->POP_Popup,
            3,
            MUIM_Set, MUIA_PopSymbol_PaletteID, 3
           );

   DoMethod(IB_Palette[4],
            MUIM_Notify, MUIA_Pressed, FALSE,
            Data->POP_Popup,
            3,
            MUIM_Set, MUIA_PopSymbol_PaletteID, 4
           );

   DoMethod(IB_Palette[5],
            MUIM_Notify, MUIA_Pressed, FALSE,
            Data->POP_Popup,
            3,
            MUIM_Set, MUIA_PopSymbol_PaletteID, 5
           );

   DoMethod(Data->POP_Popup,
            MUIM_Notify, MUIA_PopSymbol_PaletteID, MUIV_EveryTime,
            Data->POP_Popup,
            1,
            MUIM_PopSymbol_NeuesBT
           );

   return((ULONG)Data->POP_Popup);
}

ULONG PopSymbol_Set(struct IClass *cl, Object *obj, struct opSet *msg)
{
   struct PopSymbol_Data *Data = INST_DATA(cl, obj);
   struct TagItem *tags, *tag;

   for (tags = msg->ops_AttrList; tag = NextTagItem(&tags); )
      {
         switch (tag->ti_Tag)
            {
               case MUIA_PopSymbol_PaletteID:
                  DoMethod(Data->POP_Popup, MUIM_Popstring_Close, TRUE);
                  Data->PaletteID = tag->ti_Data;
                  break;
            }
      }

   return(DoSuperMethodA(cl, obj, (Msg)msg));
}

ULONG PopSymbol_Get(struct IClass *cl, Object *obj, struct opGet *msg)
{
   struct PopSymbol_Data *Data = INST_DATA(cl, obj);

   switch (msg->opg_AttrID)
      {
         case MUIA_PopSymbol_PaletteID:
            *(msg->opg_Storage) = Data->PaletteID;
            return(TRUE);
      }

   return(DoSuperMethodA(cl, obj, (Msg)msg));
}

ULONG PopSymbol_NeuesBT(struct IClass *cl, Object *obj, Msg msg)
{
   struct PopSymbol_Data *Data = INST_DATA(cl, obj);

   EingabeStruct.ibi_Spec = App->STR_SymbolBild[Data->PaletteID];
   set(Data->POP_Popup, MUIA_ImageButton_Image, &EingabeStruct);
   set(Data->POP_Popup, MUIA_ImageButton_Label, App->STR_SymbolText[Data->PaletteID]);

   return(0);
}

ULONG PopSymbol_DragQuery(struct IClass *cl, Object *obj, struct MUIP_DragQuery *msg)
{
   LONG ID;

   if (msg->obj == obj)
      return(MUIV_DragQuery_Refuse);

   else if (get(msg->obj, MUIA_PopSymbol_PaletteID, &ID))
      return(MUIV_DragQuery_Accept);

   else
      return(MUIV_DragQuery_Refuse);
}

ULONG PopSymbol_DragDrop(struct IClass *cl, Object *obj, struct MUIP_DragDrop *msg)
{
   LONG ID;

   get(msg->obj, MUIA_PopSymbol_PaletteID, &ID);
   set(obj, MUIA_PopSymbol_PaletteID, ID);

   return(0);
}

ULONG SAVEDS PopSymbol_Dispatcher(REG(a0) struct IClass *cl, REG(a2) Object *obj, REG(a1) Msg msg)
{
   switch (msg->MethodID)
      {
         case OM_NEW: return(PopSymbol_New(cl, obj, (APTR)msg));
         case OM_SET: return(PopSymbol_Set(cl, obj, (APTR)msg));
         case OM_GET: return(PopSymbol_Get(cl, obj, (APTR)msg));
         case MUIM_DragQuery           : return(PopSymbol_DragQuery (cl, obj, (APTR)msg));
         case MUIM_DragDrop            : return(PopSymbol_DragDrop  (cl, obj, (APTR)msg));
         case MUIM_PopSymbol_NeuesBT   : return(PopSymbol_NeuesBT   (cl, obj, (APTR)msg));
      }

   return(DoSuperMethodA(cl, obj, msg));
}


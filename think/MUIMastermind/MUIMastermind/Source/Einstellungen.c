/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 19.10.98 09:54                               */
/************************************************/

#ifndef MAKE_ID
   #define MAKE_ID(a,b,c,d) ((ULONG) (a)<<24 | (ULONG) (b)<<16 | (ULONG) (c)<<8 | (ULONG) (d))
#endif

/* Mastermind */
#include "GUI.h"
#include "Locale.h"

/* Protos */
#include <proto/utility.h>

/* Functions */
ULONG        Einstellungen_New       (struct IClass *cl, Object *obj, struct opSet *msg);
ULONG        Einstellungen_Set       (struct IClass *cl, Object *obj, struct opSet *msg);
ULONG        Einstellungen_Benutzen  (struct IClass *cl, Object *obj, struct opSet *msg);
ULONG SAVEDS Einstellungen_Dispatcher(REG(a0) struct IClass *cl, REG(a2) Object *obj, REG(a1) Msg msg);

ULONG        DoSuperNew(struct IClass *cl, Object *obj, ULONG tag1, ...);

/* Structures */
extern struct ObjApp *App;     /* Application object */

ULONG Einstellungen_New(struct IClass *cl, Object *obj, struct opSet *msg)
{
   APTR GR_Basis, LBL_Zugzahl, SL_Zugzahl, GR_Zugzahl, BT_Speichern,
        BT_Benutzen, BT_Abbruch, GR_SpBeAb;

   struct Einstellungen_Data *Data;

   LBL_Zugzahl = Label1(GetString(LBL_ANZAHL_ZUEGE));

   SL_Zugzahl = Slider(3, 16, 8);
   if (SL_Zugzahl)
      set(SL_Zugzahl, MUIA_CycleChain, 1);

   GR_Zugzahl = ColGroup(2),
      Child, LBL_Zugzahl,
      Child, SL_Zugzahl,
   End;

   BT_Speichern = SimpleButton(GetString(LBL_SPEICHERN));
   if (BT_Speichern)
      SetAttrs(BT_Speichern,
               MUIA_ShortHelp, GetString(BBL_BT_SPEICHERN),
               MUIA_CycleChain, 1,
               MUIA_Disabled, TRUE,
               TAG_DONE
              );

   BT_Benutzen  = SimpleButton(GetString(LBL_BENUTZEN));
   if (BT_Benutzen)
      SetAttrs(BT_Benutzen,
               MUIA_ShortHelp, GetString(BBL_BT_BENUTZEN),
               MUIA_CycleChain, 1,
               TAG_DONE
              );

   BT_Abbruch   = SimpleButton(GetString(LBL_ABBRUCH));
   if (BT_Abbruch)
      SetAttrs(BT_Abbruch,
               MUIA_ShortHelp, GetString(BBL_BT_ABBRUCH),
               MUIA_CycleChain, 1,
               TAG_DONE
              );

   GR_SpBeAb = GroupObject,
      MUIA_Group_Horiz, TRUE,
      Child, BT_Speichern,
      Child, BT_Benutzen,
      Child, BT_Abbruch,
   End;

   GR_Basis = GroupObject,
      MUIA_Group_Horiz, FALSE,
      Child, GR_Zugzahl,
      Child, GR_SpBeAb,
   End;

   obj = (APTR)DoSuperNew(cl, obj,
                          MUIA_Window_Title, GetString(TITLE_EINSTELLUNGEN),
                          MUIA_Window_ID, MAKE_ID('E', 'I', 'N', 'S'),
                          MUIA_Window_CloseGadget, FALSE,
                          WindowContents, GR_Basis
                         );

   if (!obj)
      return(NULL);


   Data = INST_DATA(cl, obj);
   Data->SL_Zugzahl = SL_Zugzahl;

   DoMethod(SL_Zugzahl,
            MUIM_Notify, MUIA_Numeric_Value, MUIV_EveryTime,
            obj,
            3,
            MUIM_Set, MUIA_Einstellungen_Zugzahl, MUIV_TriggerValue
           );

   DoMethod(BT_Benutzen,
            MUIM_Notify, MUIA_Pressed, FALSE,
            obj,
            1,
            MUIM_Einstellungen_Benutzen
           );

   DoMethod(BT_Abbruch,
            MUIM_Notify, MUIA_Pressed, FALSE,
            obj,
            3,
            MUIM_Set, MUIA_Window_Open, FALSE
           );


   return((ULONG)obj);
}

ULONG Einstellungen_Set(struct IClass *cl, Object *obj, struct opSet *msg)
{
   struct Einstellungen_Data *Data = INST_DATA(cl, obj);
   struct TagItem *tags, *tag;

   for (tags = msg->ops_AttrList; tag = NextTagItem(&tags); )
      {
         switch (tag->ti_Tag)
            {
               case MUIA_Einstellungen_Zugzahl:
                  Data->Zugzahl = tag->ti_Data;
                  set(Data->SL_Zugzahl, MUIA_Numeric_Value, Data->Zugzahl);
                  break;
            }
      }

   return(DoSuperMethodA(cl, obj, (Msg)msg));
}

ULONG Einstellungen_Benutzen(struct IClass *cl, Object *obj, struct opSet *msg)
{
   struct Einstellungen_Data *Data = INST_DATA(cl, obj);

   set(App->WI_Hauptfenster, MUIA_Mastermind_Zugzahl, Data->Zugzahl);


   set(obj, MUIA_Window_Open, FALSE);

   return(0);
}

ULONG SAVEDS Einstellungen_Dispatcher(REG(a0) struct IClass *cl, REG(a2) Object *obj, REG(a1) Msg msg)
{
   switch (msg->MethodID)
      {
         case OM_NEW: return(Einstellungen_New(cl, obj, (APTR)msg));
         case OM_SET: return(Einstellungen_Set(cl, obj, (APTR)msg));
         case MUIM_Einstellungen_Benutzen: return(Einstellungen_Benutzen(cl, obj, (APTR)msg));
      }

   return(DoSuperMethodA(cl, obj, msg));
}



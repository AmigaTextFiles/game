/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 19.10.98 09:55                               */
/************************************************/

#ifndef MAKE_ID
   #define MAKE_ID(a,b,c,d) ((ULONG) (a)<<24 | (ULONG) (b)<<16 | (ULONG) (c)<<8 | (ULONG) (d))
#endif

/* Ansi */
#include <stdio.h>

/* Mastermind */
#include "GUI.h"
#include "Locale.h"
#include "Version.h"

/* stormamiga.lib */
#ifdef __STORM__
   #define STORMAMIGA
   #include <stormamiga.h>
   #define sprintf SPRINTF
#endif

/* Protos */
#include <proto/timer.h>
#include <proto/utility.h>

#include <utility/hooks.h>

/* Global Variables */
LONG a[4], I[4], Zug;

/* Functions */
ULONG        Mastermind_New(struct IClass *cl, Object *obj, struct opSet *msg);
ULONG        Mastermind_Set(struct IClass *cl, Object *obj, struct opSet *msg);
ULONG        Mastermind_Bewerten     (struct IClass *cl, Object *obj, Msg msg);
ULONG        Mastermind_Einstellungen(struct IClass *cl, Object *obj, Msg msg);
ULONG        Mastermind_NeuesSpiel   (struct IClass *cl, Object *obj, Msg msg);
ULONG        Mastermind_ZeigeAbout   (struct IClass *cl, Object *obj, Msg msg);
ULONG SAVEDS Mastermind_Dispatcher(REG(a0) struct IClass *cl, REG(a2) Object *obj, REG(a1) Msg msg);
ULONG        DoSuperNew(struct IClass *cl, Object *obj, ULONG tag1, ...);

void         Bewerten(struct Mastermind_Data *Data, Object *obj);
APTR  SAVEDS ConstructFunc(REG(a0) struct Hook *hook, REG(a2) APTR pool   , REG(a1) struct AusgabefeldNode *an);
void  SAVEDS DestructFunc (REG(a0) struct Hook *hook, REG(a2) APTR pool   , REG(a1) struct AusgabefeldNode *an);
ULONG SAVEDS DisplayFunc  (REG(a0) struct Hook *hook, REG(a2) char **array, REG(a1) struct AusgabefeldNode *an);

/* Structures */
extern STRPTR AppStrings[];
extern struct ObjApp *App;     /* Application object */
static const struct Hook ConstructHook = { {0, 0}, (HOOKFUNC)ConstructFunc, NULL, NULL };
static const struct Hook DestructHook  = { {0, 0}, (HOOKFUNC)DestructFunc , NULL, NULL };
static const struct Hook DisplayHook   = { {0, 0}, (HOOKFUNC)DisplayFunc  , NULL, NULL };


ULONG Mastermind_New(struct IClass *cl, Object *obj, struct opSet *msg)
{
   APTR GR_Basis, BT_NeuesSpiel, GR_Eingabe, BT_Bewerten, LV_Ausgabefeld,
        POP_Eingabe[4], BT_Einstellungen;

   struct Mastermind_Data *Data;

   LV_Ausgabefeld = ListObject,
      MUIA_Background, MUII_ListBack,
      MUIA_Frame, MUIV_Frame_ReadList,
      MUIA_List_ConstructHook, &ConstructHook,
      MUIA_List_DestructHook, &DestructHook,
      MUIA_List_DisplayHook, &DisplayHook,
      MUIA_List_Title, TRUE,
      MUIA_List_Format, "BAR,BAR,BAR",
      MUIA_ShortHelp, GetString(BBL_LV_AUSGABEFELD),
      MUIA_List_MinLineHeight, 15,
   End;

   LV_Ausgabefeld = ListviewObject,
      MUIA_Listview_Input, FALSE,
      MUIA_Listview_List, LV_Ausgabefeld,
      MUIA_CycleChain, 1,
   End;

   POP_Eingabe[0] = PopSymbolObject,
   End;

   POP_Eingabe[1] = PopSymbolObject,
   End;

   POP_Eingabe[2] = PopSymbolObject,
   End;

   POP_Eingabe[3] = PopSymbolObject,
   End;

   GR_Eingabe = GroupObject,
      MUIA_Background, MUII_GroupBack,
      MUIA_Frame, MUIV_Frame_Group,
      MUIA_FrameTitle, GetString(LBL_EINGABE),
      MUIA_ShortHelp, GetString(BBL_GR_EINGABE),
      MUIA_Group_Horiz, TRUE,
      MUIA_VertWeight, 0,
      Child, POP_Eingabe[0],
      Child, POP_Eingabe[1],
      Child, POP_Eingabe[2],
      Child, POP_Eingabe[3],
   End;

   BT_Bewerten = SimpleButton(GetString(LBL_BEWERTEN));
   if (BT_Bewerten)
      SetAttrs(BT_Bewerten,
               MUIA_ShortHelp, GetString(BBL_BT_BEWERTEN),
               MUIA_CycleChain, 1,
               TAG_DONE
              );

   BT_NeuesSpiel = SimpleButton(GetString(LBL_NEUES_SPIEL));
   if (BT_NeuesSpiel)
      SetAttrs(BT_NeuesSpiel,
               MUIA_ShortHelp, GetString(BBL_BT_NEUESSPIEL),
               MUIA_CycleChain, 1,
               TAG_DONE
              );

   BT_Einstellungen = SimpleButton(GetString(LBL_EINSTELLUNGEN));
   if (BT_Einstellungen)
      SetAttrs(BT_Einstellungen,
               MUIA_ShortHelp, GetString(BBL_BT_EINSTELLUNGEN),
               MUIA_CycleChain, 1,
               TAG_DONE
              );

   GR_Basis = GroupObject,
      MUIA_Group_Horiz, FALSE,
      Child, LV_Ausgabefeld,
      Child, GR_Eingabe,
      Child, BT_Bewerten,
      Child, BT_NeuesSpiel,
      Child, BT_Einstellungen,
   End;

   obj = (APTR)DoSuperNew(cl, obj,
                          MUIA_Window_Title, "MUI-Mastermind",
                          MUIA_Window_DefaultObject, LV_Ausgabefeld,
                          MUIA_Window_ID, MAKE_ID('M', 'A', 'I', 'N'),
                          WindowContents, GR_Basis
                         );

   if (!obj)
      return(NULL);


   Data = INST_DATA(cl, obj);
   Data->LV_Ausgabefeld  = LV_Ausgabefeld;
   Data->POP_Eingabe[0]  = POP_Eingabe[0];
   Data->POP_Eingabe[1]  = POP_Eingabe[1];
   Data->POP_Eingabe[2]  = POP_Eingabe[2];
   Data->POP_Eingabe[3]  = POP_Eingabe[3];
   Data->GR_Eingabe      = GR_Eingabe;
   Data->BT_Bewerten     = BT_Bewerten;

   Data->Zugzahl = 8;

   DoMethod(Data->BT_Bewerten,
            MUIM_Notify, MUIA_Pressed, FALSE,
            obj,
            1,
            MUIM_Mastermind_Bewerten
           );

   DoMethod(BT_NeuesSpiel,
            MUIM_Notify, MUIA_Pressed, FALSE,
            obj,
            1,
            MUIM_Mastermind_NeuesSpiel
           );

   DoMethod(BT_Einstellungen,
            MUIM_Notify, MUIA_Pressed, FALSE,
            obj,
            1,
            MUIM_Mastermind_Einstellungen
           );

   return((ULONG)obj);
}

ULONG Mastermind_Set(struct IClass *cl, Object *obj, struct opSet *msg)
{
   struct Mastermind_Data *Data = INST_DATA(cl, obj);
   struct TagItem *tags, *tag;

   for (tags = msg->ops_AttrList; tag = NextTagItem(&tags); )
      {
         switch (tag->ti_Tag)
            {
               case MUIA_Mastermind_SpielLaeuft:
                  Data->SpielLaeuft = tag->ti_Data;
                  DoMethod(obj, MUIM_MultiSet,
                           MUIA_Disabled, !(Data->SpielLaeuft),
                           Data->GR_Eingabe, Data->BT_Bewerten, NULL
                          );
                  break;

               case MUIA_Mastermind_Zugzahl:
                  Data->Zugzahl = tag->ti_Data;
                  break;
            }
      }

   return(DoSuperMethodA(cl, obj, (Msg)msg));
}

ULONG Mastermind_Bewerten(struct IClass *cl, Object *obj, Msg msg)
{
   struct Mastermind_Data *Data = INST_DATA(cl, obj);

   Bewerten(Data, obj);

   return(0);
}

ULONG Mastermind_Einstellungen(struct IClass *cl, Object *obj, Msg msg)
{
   struct Mastermind_Data *Data = INST_DATA(cl, obj);

   SetAttrs(App->WI_Einstellungen,
            MUIA_Einstellungen_Zugzahl, Data->Zugzahl,
            MUIA_Window_Open, TRUE,
            TAG_DONE
           );

   return(0);
}

ULONG Mastermind_NeuesSpiel(struct IClass *cl, Object *obj, Msg msg)
{
   int i;

   struct Mastermind_Data *Data = INST_DATA(cl, obj);
   extern struct timeval *TimeStruct;

   Zug = 0;

   DoMethod(Data->LV_Ausgabefeld, MUIM_List_Clear);

   DoMethod(obj, MUIM_MultiSet,
            MUIA_PopSymbol_PaletteID, 0,
            Data->POP_Eingabe[0], Data->POP_Eingabe[1],
            Data->POP_Eingabe[2], Data->POP_Eingabe[3], NULL
           );

   for (i = 0; i <= 3; i++)
      {
         GetSysTime(TimeStruct);
         a[i] = TimeStruct->tv_micro % 6;
      }

   #ifndef NDEBUG
      for (i = 0; i <= 3; i++)
         printf("%d ", a[i]);
      printf("\n");
   #endif

   set(obj, MUIA_Mastermind_SpielLaeuft, TRUE);

   return(0);
}

ULONG Mastermind_ZeigeAbout(struct IClass *cl, Object *obj, Msg msg)
{
   TEXT TempText[150];

   struct Mastermind_Data *Data = INST_DATA(cl, obj);

   sprintf(TempText, GetString(MSG_ABOUT), VERSION);
   MUI_Request(_app(obj),
               obj,
               0,
               GetString(MSG_UEBER_MUI_MASTERMIND),
               GetString(LBL_OK),
               TempText
              );

   return(0);
}

ULONG SAVEDS Mastermind_Dispatcher(REG(a0) struct IClass *cl, REG(a2) Object *obj, REG(a1) Msg msg)
{
   switch (msg->MethodID)
      {
         case OM_NEW: return(Mastermind_New(cl, obj, (APTR)msg));
         case OM_SET: return(Mastermind_Set(cl, obj, (APTR)msg));
         case MUIM_Mastermind_Bewerten     : return(Mastermind_Bewerten     (cl, obj, (APTR)msg));
         case MUIM_Mastermind_Einstellungen: return(Mastermind_Einstellungen(cl, obj, (APTR)msg));
         case MUIM_Mastermind_NeuesSpiel   : return(Mastermind_NeuesSpiel   (cl, obj, (APTR)msg));
         case MUIM_Mastermind_ZeigeAbout   : return(Mastermind_ZeigeAbout   (cl, obj, (APTR)msg));
      }

   return(DoSuperMethodA(cl, obj, msg));
}

ULONG DoSuperNew(struct IClass *cl, Object *obj, ULONG tag1, ...)
{
   return(DoSuperMethod(cl, obj, OM_NEW, &tag1, NULL));
}


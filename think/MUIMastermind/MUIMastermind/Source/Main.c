/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 02.11.98 18:21                               */
/************************************************/

/* Libraries */
#include <libraries/locale.h>

/* Protos */
#include <proto/muimaster.h>
#include <proto/locale.h>
#include <proto/timer.h>
#include <proto/exec.h>

#include <exec/memory.h>

/* Ansi */
#include <stdio.h>

/* Mastermind */
#include "GUI.h"
#include "Locale.h"

/* stormamiga.lib */
#ifdef __STORM__
   #define STORMAMIGA
   #define STORMAMIGA_STACK 15000
   #include <stormamiga.h>
   #define main main__
   char __stdiowin[] = "CON:0/11/400/100/MUIMastermind/AUTO/CLOSE/WAIT";
#endif

/* Functions */
STRPTR GetString(enum AppStringsID id);
  BOOL InitClasses();
  void ExitClasses();
  void Ende(STRPTR Meldung, int Code);

  BOOL        CreateApp();
 ULONG SAVEDS Einstellungen_Dispatcher(REG(a0) struct IClass *cl, REG(a2) Object *obj, REG(a1) Msg msg);
 ULONG SAVEDS Mastermind_Dispatcher   (REG(a0) struct IClass *cl, REG(a2) Object *obj, REG(a1) Msg msg);
 ULONG SAVEDS PopSymbol_Dispatcher    (REG(a0) struct IClass *cl, REG(a2) Object *obj, REG(a1) Msg msg);

/* Structures */
struct ObjApp  *App;          /* Application object */
struct Catalog *Catalog;
struct Library *LocaleBase;
struct Library *MUIMasterBase;
struct timeval *TimeStruct;


/* main function */
void main()
{
   ULONG Sigs = 0UL;
   LONG Test;

   /* Program initialisation */
   if (!(App = AllocVec(sizeof(struct ObjApp), MEMF_PUBLIC|MEMF_CLEAR)))
      Ende("Out of Memory", 20);

   if (!(TimeStruct = AllocVec(sizeof(struct timeval), MEMF_PUBLIC|MEMF_CLEAR)))
      Ende("Out of Memory", 20);

   if (!(MUIMasterBase = OpenLibrary(MUIMASTER_NAME, 14)))
      Ende("Failed to open muimaster.library V14+", 20);

   if (LocaleBase = OpenLibrary("locale.library", 38))
      {
         Catalog = OpenCatalog(NULL,
                               "MUIMastermind.catalog",
                               OC_BuiltInLanguage, "deutsch",
                               TAG_DONE
                              );
      }

   if (!InitClasses())
      Ende("Failed to init Classes\n"
           "Probably you didn't install ImageButton.mcc\n"
           "Read the Guide!", 20
          );

   /* Create Application */
   if (CreateApp())
      {
         DoMethod(App->WI_Hauptfenster, MUIM_Mastermind_NeuesSpiel);

         set(App->WI_Hauptfenster, MUIA_Window_Open, TRUE);
         get(App->WI_Hauptfenster, MUIA_Window_Open, &Test);
         if (!Test)
            {
               MUI_DisposeObject(App->App);
               Ende("Failed to open Window", 20);
            }

         while (DoMethod(App->App, MUIM_Application_NewInput, &Sigs)
                != MUIV_Application_ReturnID_Quit)
            {
               if (Sigs)
                  {
                     Sigs = Wait(Sigs | SIGBREAKF_CTRL_C);
                     if (Sigs & SIGBREAKF_CTRL_C)
                        break;
                  }
            }

         set(App->WI_Hauptfenster, MUIA_Window_Open, FALSE);
         MUI_DisposeObject(App->App);
         Ende(NULL, 0);
      }
   else
      Ende("Failed to create Application", 20);
}

STRPTR GetString(enum AppStringsID id)
{
   extern STRPTR AppStrings[];

   if (LocaleBase)
      return(GetCatalogStr(Catalog, id, AppStrings[id]));

   return(AppStrings[id]);
}

BOOL InitClasses()
{
   App->CL_Einstellungen = MUI_CreateCustomClass(NULL,
                                                 MUIC_Window, NULL,
                                                 sizeof(struct Einstellungen_Data),
                                                 Einstellungen_Dispatcher
                                                );

   App->CL_Mastermind    = MUI_CreateCustomClass(NULL,
                                                 MUIC_Window, NULL,
                                                 sizeof(struct Mastermind_Data),
                                                 Mastermind_Dispatcher
                                                );

   App->CL_PopSymbol     = MUI_CreateCustomClass(NULL,
                                                 MUIC_ImageButton, NULL,
                                                 sizeof(struct PopSymbol_Data),
                                                 PopSymbol_Dispatcher
                                                );

   if (App->CL_Einstellungen && App->CL_Mastermind && App->CL_PopSymbol)
      return(TRUE);

   ExitClasses();
   return(FALSE);
}

void ExitClasses()
{
   if (App->CL_PopSymbol)
      {
         MUI_DeleteCustomClass(App->CL_PopSymbol);
         App->CL_PopSymbol = NULL;
      }

   if (App->CL_Mastermind)
      {
         MUI_DeleteCustomClass(App->CL_Mastermind);
         App->CL_Mastermind = NULL;
      }

   if (App->CL_Einstellungen)
      {
         MUI_DeleteCustomClass(App->CL_Einstellungen);
         App->CL_Einstellungen = NULL;
      }
}

void Ende(STRPTR Meldung, int Code)
{
   ExitClasses();

   if (LocaleBase)
      {
         CloseCatalog(Catalog);
         CloseLibrary(LocaleBase);
      }

   if (MUIMasterBase)
      CloseLibrary(MUIMasterBase);

   if (TimeStruct)
      FreeVec(TimeStruct);

   if (App)
      FreeVec(App);

   if (Meldung)
      puts(Meldung);

   exit(Code);
}


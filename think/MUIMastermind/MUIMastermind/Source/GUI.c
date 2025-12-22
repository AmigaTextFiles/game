/************************************************/
/* MUI-Mastermind                               */
/* Freeware                                     */
/* © 1998 Christian Hattemer                    */
/* email: chris@mail.riednet.wh.tu-darmstadt.de */
/* 22.09.98 22:38                               */
/************************************************/

/* Ansi */
#include <string.h>

/* Mastermind */
#include "GUI.h"
#include "Locale.h"
#include "Locale-Strings.h"
#include "Version.h"

/* Functions */
BOOL CreateApp();


BOOL CreateApp()
{
   APTR MN_Projekt, MN_Projekt_ueber, MN_Projekt_ueberMUI, MN_Projekt_Beenden;

   extern struct ObjApp *App;     /* Application object */

   strcpy(App->STR_SymbolText[0], GetString(MSG_SYMBOL0));
   strcpy(App->STR_SymbolText[1], GetString(MSG_SYMBOL1));
   strcpy(App->STR_SymbolText[2], GetString(MSG_SYMBOL2));
   strcpy(App->STR_SymbolText[3], GetString(MSG_SYMBOL3));
   strcpy(App->STR_SymbolText[4], GetString(MSG_SYMBOL4));
   strcpy(App->STR_SymbolText[5], GetString(MSG_SYMBOL5));

   strcpy(App->STR_SymbolBild[0], "6:23");
   strcpy(App->STR_SymbolBild[1], "6:22");
   strcpy(App->STR_SymbolBild[2], "6:24");
   strcpy(App->STR_SymbolBild[3], "6:25");
   strcpy(App->STR_SymbolBild[4], "6:26");
   strcpy(App->STR_SymbolBild[5], "6:28");

   strcpy(App->STR_BewertungS[0], "");
   strcpy(App->STR_BewertungS[1], "\33I[5:Images/S-1.iff]");
   strcpy(App->STR_BewertungS[2], "\33I[5:Images/S-2.iff]");
   strcpy(App->STR_BewertungS[3], "\33I[5:Images/S-3.iff]");
   strcpy(App->STR_BewertungS[4], "\33I[5:Images/S-4.iff]");

   strcpy(App->STR_BewertungW[0], "");
   strcpy(App->STR_BewertungW[1], "\33I[5:Images/W-1.iff]");
   strcpy(App->STR_BewertungW[2], "\33I[5:Images/W-2.iff]");
   strcpy(App->STR_BewertungW[3], "\33I[5:Images/W-3.iff]");
   strcpy(App->STR_BewertungW[4], "\33I[5:Images/W-4.iff]");

   // Einstellungsfenster

   App->WI_Einstellungen = EinstellungenObject,
   End;

   // Hauptfenster

   App->WI_Hauptfenster = MastermindObject,
   End;

   // Menus Hauptfenster

   MN_Projekt_ueber = MenuitemObject,
      MUIA_Menuitem_Title, GetString(LBL_MN_ABOUT),
      MUIA_Menuitem_Shortcut, GetString(KEY_MN_ABOUT),
   End;

   MN_Projekt_ueberMUI = MenuitemObject,
      MUIA_Menuitem_Title, GetString(LBL_MN_ABOUT_MUI),
   End;

   MN_Projekt_Beenden = MenuitemObject,
      MUIA_Menuitem_Title, GetString(LBL_MN_BEENDEN),
      MUIA_Menuitem_Shortcut, GetString(KEY_MN_BEENDEN),
   End;

   MN_Projekt = MenuitemObject,
      MUIA_Menuitem_Title, GetString(LBL_MN_PROJEKT),
      MUIA_Family_Child, MN_Projekt_ueber,
      MUIA_Family_Child, MN_Projekt_ueberMUI,
      MUIA_Family_Child, MN_Projekt_Beenden,
   End;

   App->MN_Root = MenustripObject,
      MUIA_Family_Child, MN_Projekt,
   End;


   App->App = ApplicationObject,
      MUIA_Application_Author, "Christian Hattemer",
      MUIA_Application_Menustrip, App->MN_Root,
      MUIA_Application_Base, "MUIMASTERMIND",
      MUIA_Application_Title, "MUI-Mastermind",
      MUIA_Application_Version, VERSIONSTRING,
      MUIA_Application_Copyright, "© 1998 Christian Hattemer",
      MUIA_Application_Description, GetString(MSG_MASTERMIND_SPIEL),
      MUIA_Application_SingleTask, TRUE,
      SubWindow, App->WI_Einstellungen,
      SubWindow, App->WI_Hauptfenster,
   End;


   if (!App->App)
      return(FALSE);

   // Notify Hauptfenster

   DoMethod(App->WI_Hauptfenster,
            MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
            App->App,
            2,
            MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit
           );

   // Notify Menu Hauptfenster

   DoMethod(MN_Projekt_ueber,
            MUIM_Notify, MUIA_Menuitem_Trigger, MUIV_EveryTime,
            App->WI_Hauptfenster,
            1,
            MUIM_Mastermind_ZeigeAbout
           );

   DoMethod(MN_Projekt_ueberMUI,
            MUIM_Notify, MUIA_Menuitem_Trigger, MUIV_EveryTime,
            App->App,
            2,
            MUIM_Application_AboutMUI, App->WI_Hauptfenster
           );

   DoMethod(MN_Projekt_Beenden,
            MUIM_Notify, MUIA_Menuitem_Trigger, MUIV_EveryTime,
            App->App,
            2,
            MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit
           );


   return(TRUE);
}


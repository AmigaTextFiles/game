/*  Chaos:                  The Chess HAppening Organisation System     V5.3
    Copyright (C)   1993    Jochen Wiedmann

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


    $RCSfile: MainAmi.c,v $
    $Revision: 3.4 $
    $Date: 1994/11/19 19:32:01 $

    This file contains the system dependent functions to initialize the
    main window and other global stuff. Highly system dependent.

    Computer:   Amiga 1200                  Compiler:   Dice 2.07.54 (3.0)

    Author:     Jochen Wiedmann
                Am Eisteich 9
          72555 Metzingen
                Tel. 07123 / 14881
                Internet: jochen.wiedmann@zdv.uni-tuebingen.de
*/


#ifndef CHAOS_H
#include "chaos.h"
#endif

#ifdef AMIGA
#include <workbench/startup.h>
#include <libraries/gadtools.h>
#include <dos/dostags.h>
#include <proto/icon.h>
#endif  /*  AMIGA   */





/*
    CloseLibs() closes the libraries.
*/
#ifdef AMIGA
struct Library *MUIMasterBase   = NULL;
struct Library *IFFParseBase    = NULL;
#endif  /*  AMIGA   */

void CloseLibs(void)

#ifdef AMIGA
{
  if (MUIMasterBase != NULL)
  { CloseLibrary(MUIMasterBase);
  }
  if (IFFParseBase != NULL)
  { CloseLibrary(IFFParseBase);
  }
}
#endif  /*  AMIGA   */


/*
    DoStartup() processes the arguments (either from workbench or from
    CLI). Note, that this is called before InitMain(). ShowError() probably
    doesn't do its job, if it's called.
*/
#ifdef AMIGA
int MakeIcons;
int NoWindow;
char IconName[TRNFILENAME_LEN+1] = "s/Chaos_Project";
char MenuName[TRNFILENAME_LEN+1] = "s/Chaos_Menu";
char ProgName[TRNFILENAME_LEN+1];
Object *MainMenu;
#endif  /*  AMIGA   */

void DoStartup(int argc, char *argv[])

#ifdef AMIGA
{ struct
  { char *name;
    long makeicons;
    char *deficon;
    char *menufile;
    char *language;
    long nowindow;
    long *winnerpoints;
    long *drawpoints;
  } args;
  void *key = NULL;

  args.name = NULL;
  args.makeicons = (argc == 0);
  args.deficon = NULL;
  args.menufile = NULL;
  args.language = NULL;
  args.nowindow = FALSE;
  args.winnerpoints = NULL;
  args.drawpoints = NULL;

  if (argc == 0)  /*  Workbench-Programm  */
  { struct WBStartup *WBenchMsg = (struct WBStartup *) argv;
    struct WBArg *wbarg;
    struct DiskObject *dobj;
    char **toolarray;
    char *ptr;
    BPTR olddir;
    int i;

    AllowErrorMessage = FALSE;
    for (i = 0,  wbarg = WBenchMsg->sm_ArgList;
         i < ((2 < WBenchMsg->sm_NumArgs) ? 2 : WBenchMsg->sm_NumArgs);
         i++, wbarg++)
    { olddir = -1;
      if (wbarg->wa_Lock  &&  *wbarg->wa_Name != '\0')
      { olddir = CurrentDir(wbarg->wa_Lock);
      }
      if (*wbarg->wa_Name != '\0'  &&
          (dobj = GetDiskObject((STRPTR) wbarg->wa_Name))  !=  NULL)
      { toolarray = (char **) dobj->do_ToolTypes;

        if ((ptr = (char *) FindToolType((STRPTR *) toolarray,
                                                 (STRPTR) "NOICONS"))
                 !=  NULL)
        { args.makeicons = FALSE;
        }
        if ((ptr = (char *) FindToolType((STRPTR *) toolarray,
                                                 (STRPTR) "DEFICON"))
                 !=  NULL)
        { args.deficon = GetStringMem(&key, ptr);
          args.makeicons = TRUE;
        }
        if ((ptr = (char *) FindToolType((STRPTR *) toolarray,
                                                 (STRPTR) "MENUFILE"))
                 !=  NULL)
        { args.deficon = GetStringMem(&key, ptr);
          args.makeicons = TRUE;
        }
        if ((ptr = (char *) FindToolType((STRPTR *) toolarray,
                                                 (STRPTR) "LANGUAGE"))
                 != NULL)
        { args.language = GetStringMem(&key, ptr);
        }
        if ((ptr = (char *) FindToolType((STRPTR *) toolarray,
                                         (STRPTR) "WINNERPOINTS"))
                 != NULL)
        { DefaultWinnerPoints = atol(ptr);
        }
        if ((ptr = (char *) FindToolType((STRPTR *) toolarray,
                                         (STRPTR) "DRAWPOINTS"))
                 != NULL)
        { DefaultDrawPoints = atol(ptr);
        }

        FreeDiskObject(dobj);
      }
      if (i == 0)
      { /*  Get program's pathname
        */
        if (!NameFromLock(wbarg->wa_Lock, (STRPTR) ProgName,
                          sizeof(ProgName)-strlen(wbarg->wa_Name)-1))
        { *ProgName = '\0';
        }
        AddPart((STRPTR) ProgName,
                (STRPTR) wbarg->wa_Name, sizeof(ProgName));
      }
      else
      { /* Get filename to load
        */
        char filename[TRNFILENAME_LEN+1];

        if (NameFromLock(wbarg->wa_Lock, (STRPTR) filename,
                         sizeof(filename)-strlen(wbarg->wa_Name)-1))
        { AddPart((STRPTR) filename, (STRPTR) wbarg->wa_Name,
                  sizeof(filename));
          args.name = GetStringMem(&key, filename);
        }
      }
      if (olddir != -1)
      { CurrentDir(olddir);
      }
    }
  }
  else            /*  CLI program       */
  { struct RDArgs *rdargs;

    if ((rdargs = ReadArgs((STRPTR)
                            "FILE,MAKEICONS/S,DEFICON/K,MENUFILE/K,"
                            "LANGUAGE/K,NOWINDOW/S,WINNERPOINTS/K/N,"
                            "DRAWPOINTS/K/N",
                           (LONG *) &args, NULL))
                ==  NULL)
    { PrintFault(IoErr(), NULL);
      exit(10);
    }
    if (args.name)
    { args.name = GetStringMem(&key, args.name);
    }
    if (args.language)
    { args.language = GetStringMem(&key, args.language);
    }
    if (args.deficon)
    { args.deficon = GetStringMem(&key, args.deficon);
    }
    if (args.menufile)
    { args.menufile = GetStringMem(&key, args.menufile);
    }
    if (args.winnerpoints)
    { DefaultWinnerPoints = *args.winnerpoints;
    }
    if (args.drawpoints)
    { DefaultDrawPoints = *args.drawpoints;
    }
    FreeArgs(rdargs);

    /*  Pfadnamen des Programms bestimmen.
    */
    if (!NameFromLock(((struct Process *) FindTask(NULL))->pr_HomeDir,
                      (STRPTR) ProgName,
                      sizeof(ProgName)-strlen(argv[0])-1))
    { *ProgName = '\0';
    }
    AddPart((STRPTR) ProgName, (STRPTR) argv[0], sizeof(ProgName));
  }

  MakeIcons = args.makeicons;
  NoWindow = args.nowindow;
  if (args.deficon != NULL)
  { MakeIcons = TRUE;
    strcpy(IconName, args.deficon);
  }
  if (args.menufile != NULL)
  { strcpy(MenuName, args.menufile);
  }



  InitChaosCatalog((STRPTR) args.language);
  if (args.name != NULL)
  { LoadTournament(args.name, NULL, NULL);
  }
  PutMemList(&key);
}
#endif  /*  AMIGA   */




/*
    This initializes the libraries.
*/
void OpenLibs(void)

#ifdef AMIGA
{ /*  Not all of the above are really needed. Without iffparse.library
      we read the preferences like we did in 1.3 and use the english
      strings on 2.0. Without locale.library we use the english strings
      on 2.1 and above.
  */
  if ((MUIMasterBase = OpenLibrary((STRPTR) "muimaster.library", 8))
                     ==  NULL)
  { ShowError("Cannot open 'mui.library' V8 or higher!");
    exit(10);
  }
  IFFParseBase = OpenLibrary((STRPTR) "iffparse.library", 37);
}
#endif  /*  AMIGA   */



/*
    The InitRandom() function initializes the random number generator.
*/
void InitRandom(void)

#ifdef AMIGA
{ int i;
  struct DateStamp ds;
  extern ULONG RangeSeed;

  DateStamp(&ds);
  RangeSeed = ds.ds_Days + ds.ds_Minute + ds.ds_Tick/2;
  for (i = 0;  i < ds.ds_Minute;  i++)
  { RangeRand(ds.ds_Tick);
  }
}
#endif  /*  AMIGA   */



/*
    TerminateWnd() closes the main window.
*/
#ifdef AMIGA
APTR App = NULL;                                /*  Application object      */
struct DiskObject *AppDiskObject    = NULL;     /*  Icon in iconified state */
#endif  /*  AMIGA   */

void TerminateMainWnd(void)

#ifdef AMIGA
{
  if (App)
  { MUI_DisposeObject(App);
    App = NULL;
  }
  if (AppDiskObject)
  { FreeDiskObject(AppDiskObject);
  }
}
#endif  /*  AMIGA   */




/*
    The InitMainWnd() function brings up the main window. The program is
    terminated, if an error occurs.
*/
#ifdef AMIGA
APTR MainWnd;               /*  Main window                         */
static APTR TrnFileGad;     /*  Tournament file name                */
static APTR TrnNameGadOut;  /*  Tournament name (output)            */
static APTR TrnModeGad;     /*  Tournament mode                     */
static APTR NumPlayersGad;  /*  Number of players                   */
static APTR NumRoundsGad;   /*  Number of rounds                    */


#define ID_MenuAction                       1
#define ID_Project_New                      1001
#define ID_Project_Load                     1002
#define ID_Project_Save                     1003
#define ID_Project_SaveAs                   1004
#define ID_Project_About                    1005
#define ID_Project_Quit                     1006
#define ID_Players_Add                      1007
#define ID_Players_Import                   1008
#define ID_Players_Modify                   1009
#define ID_Players_Delete                   1010
#define ID_Round_Pairings                   1011
#define ID_Round_Pairings_SwissPairing      1012
#define ID_Round_Pairings_RoundRobin        1013
#define ID_Round_Pairings_RoundRobinShift   1014
#define ID_Round_Results                    1015
#define ID_Round_Results_Sub                1016
#define ID_Output_PlayerList                1017
#define ID_Output_PlayerList_Short          1018
#define ID_Output_PlayerList_Long           1019
#define ID_Output_Rankings                  1020
#define ID_Output_Round                     1021
#define ID_Output_Round_Sub                 1022
#define ID_Output_Table                     1023
#define ID_Output_Table_All                 1024
#define ID_Output_Table_Seniors             1025
#define ID_Output_Table_Juniors             1026
#define ID_Output_Table_Women               1027
#define ID_Output_Table_JuniorsA            1028
#define ID_Output_Table_JuniorsB            1029
#define ID_Output_Table_JuniorsC            1030
#define ID_Output_Table_JuniorsD            1031
#define ID_Output_Table_JuniorsE            1032
#define ID_Output_TableProgress             1033
#define ID_Output_DWZReport                 1034
#define ID_Output_CrossTable                1035
#define ID_Output_CrossTable_Ascii          1036
#define ID_Output_CrossTable_TeX            1037
#define ID_Output_PlayerCards               1038
#define ID_Output_PlayerCards_Ascii         1039
#define ID_Output_PlayerCards_TeX           1040
#define ID_Prefs_Scoring                    1041
#define ID_Prefs_Scoring_Simple             1042
#define ID_Prefs_Scoring_Buchholz           1043
#define ID_Prefs_Scoring_ExtBuchholz        1044
#define ID_Prefs_Scoring_SonnebornBerger    1045
#define ID_Prefs_Device                     1046
#define ID_Prefs_Device_Screen              1047
#define ID_Prefs_Device_PrinterDraft        1048
#define ID_Prefs_Device_PrinterLQ           1049
#define ID_Prefs_Device_File                1050
#define ID_Prefs_SetGames                   1051
#define ID_Prefs_MakeIcons                  1052
#endif  /*  Amiga   */

void InitMainWnd(void)

#ifdef AMIGA
{ int open;
  extern void MakeDisplay(void);
  extern struct MUI_Command ARexxCommands[];

  static struct NewMenu MainNewMenu[] = {
    NM_TITLE, (STRPTR) _MSG_TOURNAMENT_MENU,                NULL,                           0,                  NULL, NULL,
    NM_ITEM,  (STRPTR) _MSG_TOURNAMENT_NEW_ITEM,            NULL,                           0,                  0L, (APTR)ID_Project_New,
    NM_ITEM,  (STRPTR) _MSG_TOURNAMENT_LOAD_ITEM,           (STRPTR) _KEY_PROJECT_LOAD,     0,                  0L, (APTR)ID_Project_Load,
    NM_ITEM,  (STRPTR) _MSG_TOURNAMENT_SAVE_ITEM,           (STRPTR) _KEY_PROJECT_SAVE,     0,                  0L, (APTR)ID_Project_Save,
    NM_ITEM,  (STRPTR) _MSG_TOURNAMENT_SAVEAS_ITEM,         (STRPTR) _KEY_PROJECT_SAVE_AS,  0,                  0L, (APTR)ID_Project_SaveAs,
    NM_ITEM,  (STRPTR) _MSG_TOURNAMENT_ABOUT_ITEM,          (STRPTR) _KEY_PROJECT_ABOUT,    0,                  0L, (APTR)ID_Project_About,
    NM_ITEM,  (STRPTR) _MSG_TOURNAMENT_QUIT_ITEM,           NULL,                           0,                  0L, (APTR)ID_Project_Quit,
    NM_TITLE, (STRPTR) _MSG_PLAYER_MENU,                    NULL,                           0,                  NULL, NULL,
    NM_ITEM,  (STRPTR) _MSG_PLAYER_ADD_ITEM,                (STRPTR) _KEY_PLAYERS_NEW,      0,                  0L, (APTR)ID_Players_Add,
    NM_ITEM,  (STRPTR) _MSG_PLAYER_IMPORT_ITEM,             NULL,                           0,                  0L, (APTR)ID_Players_Import,
    NM_ITEM,  (STRPTR) _MSG_PLAYER_MODIFY_ITEM,             (STRPTR) _KEY_PLAYERS_MODIFY,   0,                  0L, (APTR)ID_Players_Modify,
    NM_ITEM,  (STRPTR) _MSG_PLAYER_DELETE_ITEM,             NULL,                           0,                  0L, (APTR)ID_Players_Delete,
    NM_TITLE, (STRPTR) _MSG_ROUND_MENU,                     NULL,                           0,                  NULL, NULL,
    NM_ITEM,  (STRPTR) _MSG_ROUND_PAIRINGS_ITEM,            NULL,                           0,                  0L, (APTR)ID_Round_Pairings,
    NM_SUB,   (STRPTR) _MSG_ROUND_PAIRINGS_SWISS_SUB,       NULL,                           0,                  0L, (APTR)ID_Round_Pairings_SwissPairing,
    NM_SUB,   (STRPTR) _MSG_ROUND_PAIRINGS_RROBIN_SUB,      NULL,                           0,                  0L, (APTR)ID_Round_Pairings_RoundRobin,
    NM_SUB,   (STRPTR) _MSG_ROUND_PAIRINGS_SLIDE_SUB,       NULL,                           0,                  0L, (APTR)ID_Round_Pairings_RoundRobinShift,
    NM_ITEM,  (STRPTR) _MSG_ROUND_RESULTS_ITEM,             NULL,                           0,                  0L, (APTR)ID_Round_Results,
    NM_TITLE, (STRPTR) _MSG_OUTPUT_MENU,                    NULL,                           0,                  NULL, NULL,
    NM_ITEM,  (STRPTR) _MSG_OUTPUT_PLAYERS_ITEM,            NULL,                           0,                  0L, (APTR)ID_Output_PlayerList,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_PLAYERS_SHORT_SUB,       NULL,                           0,                  0L, (APTR)ID_Output_PlayerList_Short,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_PLAYERS_LONG_SUB,        NULL,                           0,                  0L, (APTR)ID_Output_PlayerList_Long,
    NM_ITEM,  (STRPTR) _MSG_OUTPUT_RANKINGS_ITEM,           NULL,                           0,                  0L, (APTR)ID_Output_Rankings,
    NM_ITEM,  (STRPTR) _MSG_OUTPUT_ROUND_ITEM,              NULL,                           0,                  0L, (APTR)ID_Output_Round,
    NM_ITEM,  (STRPTR) _MSG_OUTPUT_TABLE_ITEM,              NULL,                           0,                  0L, (APTR)ID_Output_Table,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_TABLE_ALL_SUB,           NULL,                           0,                  0L, (APTR)ID_Output_Table_All,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_TABLE_SENIORS_SUB,       NULL,                           0,                  0L, (APTR)ID_Output_Table_Seniors,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_TABLE_JUNIORS_SUB,       NULL,                           0,                  0L, (APTR)ID_Output_Table_Juniors,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_TABLE_WOMEN_SUB    ,     NULL,                           0,                  0L, (APTR)ID_Output_Table_Women,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_TABLE_JUNIORSA_SUB,      NULL,                           0,                  0L, (APTR)ID_Output_Table_JuniorsA,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_TABLE_JUNIORSB_SUB,      NULL,                           0,                  0L, (APTR)ID_Output_Table_JuniorsB,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_TABLE_JUNIORSC_SUB,      NULL,                           0,                  0L, (APTR)ID_Output_Table_JuniorsC,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_TABLE_JUNIORSD_SUB,      NULL,                           0,                  0L, (APTR)ID_Output_Table_JuniorsD,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_TABLE_JUNIORSE_SUB,      NULL,                           0,                  0L, (APTR)ID_Output_Table_JuniorsE,
    NM_ITEM,  (STRPTR) _MSG_OUTPUT_PROGRESSTABLE_ITEM,      NULL,                           0,                  0L, (APTR)ID_Output_TableProgress,
    NM_ITEM,  (STRPTR) _MSG_OUTPUT_DWZ_ITEM,                NULL,                           0,                  0L, (APTR)ID_Output_DWZReport,
    NM_ITEM,  (STRPTR) _MSG_OUTPUT_CROSSTABLE_ITEM,         NULL,                           0,                  0L, (APTR)ID_Output_CrossTable,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_CROSSTABLE_ASC_SUB,      NULL,                           0,                  0L, (APTR)ID_Output_CrossTable_Ascii,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_CROSSTABLE_TEX_SUB,      NULL,                           0,                  0L, (APTR)ID_Output_CrossTable_TeX,
    NM_ITEM,  (STRPTR) _MSG_OUTPUT_PLAYERCARDS_ITEM,        NULL,                           0,                  0L, (APTR)ID_Output_PlayerCards,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_PLAYERCARDS_ASC_SUB,     NULL,                           0,                  0L, (APTR)ID_Output_PlayerCards_Ascii,
    NM_SUB,   (STRPTR) _MSG_OUTPUT_PLAYERCARDS_TEX_SUB,     NULL,                           0,                  0L, (APTR)ID_Output_PlayerCards_TeX,
    NM_TITLE, (STRPTR) _MSG_PREFS_MENU,                     NULL,                           0,                  NULL, NULL,
    NM_ITEM,  (STRPTR) _MSG_PREFS_TMODE_ITEM,               NULL,                           0,                  0L, (APTR)ID_Prefs_Scoring,
    NM_SUB,   (STRPTR) _MSG_PREFS_TMODE_SIMPLE_SUB,         NULL,                           CHECKIT|CHECKED,    14L, (APTR)ID_Prefs_Scoring_Simple,
    NM_SUB,   (STRPTR) _MSG_PREFS_TMODE_BUCHHOLZ_SUB,       NULL,                           CHECKIT,            13L, (APTR)ID_Prefs_Scoring_Buchholz,
    NM_SUB,   (STRPTR) _MSG_PREFS_TMODE_EXTBCHHLZ_SUB,      NULL,                           CHECKIT,            11L, (APTR)ID_Prefs_Scoring_ExtBuchholz,
    NM_SUB,   (STRPTR) _MSG_PREFS_TMODE_SONNEBORN_SUB,      NULL,                           CHECKIT,            7L, (APTR)ID_Prefs_Scoring_SonnebornBerger,
    NM_ITEM,  (STRPTR) _MSG_PREFS_OUT_ITEM,                 NULL,                           0,                  0L, (APTR)ID_Prefs_Device,
    NM_SUB,   (STRPTR) _MSG_PREFS_OUT_SCREEN_SUB,           NULL,                           CHECKIT|CHECKED,    14L, (APTR)ID_Prefs_Device_Screen,
    NM_SUB,   (STRPTR) _MSG_PREFS_OUT_PRTDRAFT_SUB,         NULL,                           CHECKIT,            13L, (APTR)ID_Prefs_Device_PrinterDraft,
    NM_SUB,   (STRPTR) _MSG_PREFS_OUT_PRTLQ_SUB,            NULL,                           CHECKIT,            11L, (APTR)ID_Prefs_Device_PrinterLQ,
    NM_SUB,   (STRPTR) _MSG_PREFS_OUT_FILE_SUB,             NULL,                           CHECKIT,            7L, (APTR)ID_Prefs_Device_File,
    NM_ITEM,  (STRPTR) _MSG_PREFS_SETGAMES,                 NULL,                           CHECKIT|MENUTOGGLE, 0L, (APTR)ID_Prefs_SetGames,
    NM_ITEM,  (STRPTR) _MSG_PREFS_MAKEICONS_ITEM,           NULL,                           CHECKIT|MENUTOGGLE, 0L, (APTR)ID_Prefs_MakeIcons,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    /*
        32 empty entries are following here. The 'special' menu will be
        probably put in here.
    */
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL,
    NM_END,   NULL, NULL, 0, 0L, NULL
  };

  /*
      Localize the menu
  */
  { struct NewMenu *nm;

    for(nm = MainNewMenu;  nm->nm_Type != NM_END;  nm++)
    { if (nm->nm_Label  &&  nm->nm_Label != NM_BARLABEL)
      { nm->nm_Label = ((struct FC_String *) nm->nm_Label)->msg;
      }
      if (nm->nm_CommKey)
      { nm->nm_CommKey = ((struct FC_String *) nm->nm_CommKey)->msg;
      }
    }
  }

  /*
      Reading the menu file.
  */
  { FILE *fh;

    if ((fh = fopen(MenuName, "r"))  !=  NULL  ||
        (fh = fopen("s:Chaos_Menu", "r"))  !=  NULL)
    { int size;
      char *menufile;

      fseek(fh, 0, SEEK_END);
      size = ftell(fh);
      if ((menufile = malloc(size+1))  ==  NULL)
      { ShowError("Cannot read menufile, ignoring.");
      }
      else
      { fseek(fh, 0, SEEK_SET);
        if (fread(menufile, size, 1, fh)  !=  1)
        { ShowError("Cannot read menufile, ignoring.");
        }
        else
        { int NumLines = 0;
          struct NewMenu *nm = MainNewMenu;

          /*
              Look, where to put in the special menu.
          */
          while (nm->nm_Type != NM_END)
          { nm++;
          }

          /*
              Creating the menu header
          */
          nm->nm_Type = NM_TITLE;
          nm->nm_Label = MSG_SPECIAL_MENU;

          /*
              Scanning the menu file
          */
          menufile[size] = '\0';
          while(*menufile != 0  &&  NumLines < 31)
          { ++nm;
            ++NumLines;
            nm->nm_Type = NM_ITEM;
            nm->nm_Label = (STRPTR) menufile;
            while(*menufile != '\n'  &&  *menufile != '\0')
            { ++menufile;
            }
            if (*menufile != '\0')
            { *menufile = '\0';
              nm->nm_UserData = (APTR) ++menufile;
              while(*menufile != '\n'  &&  *menufile != '\0')
              { ++menufile;
              }
              if (*menufile != '\0')
              { *(menufile++) = '\0';
              }
            }
          }
        }
      }
      fclose(fh);
    }
  }

  /*
      Get the programs icon to show it in iconified state.
  */
  AppDiskObject = GetDiskObject((STRPTR) ProgName);

  /*
      Creating the GUI
  */
  App = ApplicationObject,
            MUIA_Application_Title,         "Chaos",
            MUIA_Application_Version,       VERVERSION,
            MUIA_Application_Copyright,     "© 1993, Jochen Wiedmann",
            MUIA_Application_Author,        "Jochen Wiedmann",
            MUIA_Application_Description,   "The Chess HAppening Organisation System",
            MUIA_Application_Base,          "CHAOS",
            MUIA_Application_Commands,      ARexxCommands,
            AppDiskObject ? MUIA_Application_DiskObject : TAG_IGNORE,
                                            AppDiskObject,
            SubWindow, MainWnd = WindowObject,
                MUIA_Window_ID, MAKE_ID('M','A','I','N'),
                MUIA_Window_Title, AVERSION,
                MUIA_Window_Menustrip, MainMenu = MUI_MakeObject(MUIO_MenustripNM, MainNewMenu, 0),
                WindowContents, VGroup,
                    Child, TextObject,
                        GroupFrame,
                        MUIA_Background, MUII_FILLBACK2,
                        MUIA_Text_Contents, "\033cC h a o s\n"
                                            "\033cThe Chess HAppening Organisation System\n"
                                            "Copyright © 1993,      Jochen Wiedmann",
                    End,
                    Child, ColGroup(2),
                        Child, Label2(MSG_TOURNAMENT_FILE_OUTPUT),
                        Child, TrnFileGad = TextObject,
                        End,
                        Child, Label2(MSG_TOURNAMENT_NAME_OUTPUT),
                        Child, TrnNameGadOut = TextObject,
                        End,
                        Child, Label2(MSG_TOURNAMENT_MODE_OUTPUT),
                        Child, TrnModeGad = TextObject,
                        End,
                    End,
                    Child, HGroup,
                        Child, Label2(MSG_NUM_PLAYERS_OUTPUT),
                        Child, NumPlayersGad = TextObject,
                        End,
                        Child, HSpace(0),
                        Child, Label2(MSG_NUM_ROUNDS_OUTPUT),
                        Child, NumRoundsGad = TextObject,
                        Child, HSpace(0),
                        End,
                    End,
                End,
            End,
        End;

  /*
      Successfull?
  */
  if (App == NULL)
  { ShowError(MSG_MEMORY_ERROR);
    exit(10);
  }

  /*
      Setting up the notification events for the main window
  */
  DoMethod(MainWnd, MUIM_Notify, MUIA_Window_CloseRequest, TRUE, App, 2,
           MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);
  DoMethod(App, MUIM_Notify, MUIA_Application_MenuAction, MUIV_EveryTime,
           App, 2, MUIM_Application_ReturnID, ID_MenuAction);



  /*
      Opening the main window and checking for success
  */
  if (!NoWindow)
  { set (MainWnd, MUIA_Window_Open, TRUE);
    MakeDisplay();
    get (MainWnd, MUIA_Window_Open, &open);
    if (!open)
    { MUIError((char *) ERRMSG_CANNOT_OPEN_WINDOW);
      TerminateMainWnd();
    }
  }
}
#endif  /*  AMIGA   */




/*
    The ShowError() function should bring up a requester telling an error.
*/
void ShowError(char *msg, ...)

#ifdef AMIGA
{
  if (App)
  { MUI_RequestA(App, MainWnd, 0, (char *) MSG_ERROR_REQUEST,
               (char *) MSG_OK, msg, (&msg)+1);
  }
  else if (IntuitionBase)
  { struct EasyStruct es;

    es.es_StructSize = sizeof(es);
    es.es_Flags = 0;
    es.es_Title = MSG_ERROR_REQUEST;
    es.es_TextFormat = (STRPTR) msg;
    es.es_GadgetFormat = MSG_OK;
    EasyRequestArgs(NULL, &es, NULL, (&msg)+1);
  }
  else if (AllowErrorMessage)
  { printf("%s\n", msg);
  }
}
#endif  /*  AMIGA   */



#ifdef AMIGA
/*
    The following function gets called, if an MUI command fails.

*/
void MUIError(char *msg)
{ char *errmsg;

  switch (MUI_Error())
  { case MUIE_OK:
      errmsg = (char *) MUIERR_OK;
      break;
    case MUIE_OutOfMemory:
      errmsg = (char *) MUIERR_OutOfMemory;
      break;
    case MUIE_OutOfGfxMemory:
      errmsg = (char *) MUIERR_OutOfGfxMemory;
      break;
    case MUIE_InvalidWindowObject:
      errmsg = (char *) MUIERR_InvalidWindowObject;
      break;
    case MUIE_MissingLibrary:
      errmsg = (char *) MUIERR_MissingLibrary;
      break;
    case MUIE_NoARexx:
      errmsg = (char *) MUIERR_NoARexx;
      break;
    case MUIE_SingleTask:
      errmsg = (char *) MUIERR_SingleTask;
      break;
    default:
      errmsg = (char *) MUIERR_Unknown;
  }

  ShowError(msg, errmsg);
}
#endif  /*  AMIGA   */




/*
    MemError() gets called, when memory is missing.
*/
void MemError(void)

{ ShowError((char *) MSG_MEMORY_ERROR);
}




/*
    MakeDisplay() refreshs the information gadgets, enables or disables the
    menuitems and looks for the menu preferences.
*/
void MakeDisplay(void)

#ifdef AMIGA
{ char numrounds[10], numplayers[10];
  Object *menuObj;

  /*
      Information gadgets
  */
  set(TrnFileGad, MUIA_Text_Contents, TrnFileName);
  set (TrnNameGadOut, MUIA_Text_Contents, TrnName);
  switch (TrnMode &
          (TNMODEF_SWISS_PAIRING|TNMODEF_ROUND_ROBIN|TNMODEF_SHIFT_SYSTEM))
  { case 0:
      set(TrnModeGad, MUIA_Text_Contents, NULL);
      break;
    case TNMODEF_SWISS_PAIRING:
      set(TrnModeGad, MUIA_Text_Contents, MSG_SWISS_PAIRING);
      break;
    case TNMODEF_ROUND_ROBIN:
      set(TrnModeGad, MUIA_Text_Contents, MSG_RUNDENTURNIER);
      break;
    default:
      set(TrnModeGad, MUIA_Text_Contents, MSG_RUTSCHSYSTEM);
      break;
  }
  sprintf(numrounds, "%d", NumRounds);
  set(NumRoundsGad, MUIA_Text_Contents, numrounds);
  sprintf(numplayers, "%d", NumPlayers);
  set(NumPlayersGad, MUIA_Text_Contents, numplayers);


  /*
      Enabling and disabling menu items
  */
#define SetMenu(id, flag)                                                   \
    if ((menuObj = (Object *) DoMethod(MainMenu, MUIM_FindUData, (id))))    \
    { set(menuObj, MUIA_Menuitem_Enabled, (flag));                          \
    }

  SetMenu(ID_Players_Add,
          !((RoundRobinTournament  &&  NumRounds > 0)  ||
            (SwissPairingTournament  &&  NumRounds > 1)));
  SetMenu(ID_Players_Import,
          !((RoundRobinTournament  &&  NumRounds > 0)  ||
            (SwissPairingTournament  &&  NumRounds > 1)));
  SetMenu(ID_Players_Modify, NumPlayers > 0);
  SetMenu(ID_Players_Delete,
          (NumRounds == 0  &&  NumPlayers > 0)  || SwissPairingTournament);

  SetMenu(ID_Round_Pairings,
          (NumRounds == 0  &&  NumPlayers > 0)  || SwissPairingTournament);
  SetMenu(ID_Round_Pairings_SwissPairing,
          (NumRounds == 0  &&  NumPlayers > 0)  ||
          (SwissPairingTournament  &&  NumGamesMissing == 0));
  SetMenu(ID_Round_Pairings_RoundRobin, NumRounds == 0  &&  NumPlayers > 0);
  SetMenu(ID_Round_Pairings_RoundRobinShift,
          NumRounds == 0  &&  NumPlayers > 0);
  SetMenu(ID_Round_Results, NumRounds > 0);

  SetMenu(ID_Output_PlayerList, NumPlayers > 0);
  SetMenu(ID_Output_Rankings, NumPlayers > 0);
  SetMenu(ID_Output_Round, NumRounds > 0);
  SetMenu(ID_Output_Table, NumRounds > 0);
  SetMenu(ID_Output_TableProgress, SwissPairingTournament);
  SetMenu(ID_Output_CrossTable, RoundRobinTournament);
  SetMenu(ID_Output_PlayerCards,
          (NumPlayers > 0  &&  NumRounds == 0)  ||  SwissPairingTournament);
  SetMenu(ID_Output_DWZReport, NumRounds > 0);

  SetMenu(ID_Prefs_Scoring, NumRounds > 0);
  SetMenu(ID_Prefs_Scoring_Buchholz, SwissPairingTournament);
  SetMenu(ID_Prefs_Scoring_ExtBuchholz, SwissPairingTournament);
  SetMenu(ID_Prefs_Scoring_SonnebornBerger, RoundRobinTournament);

  /*
      Finally let the items of the preferences menu reflect the current
      settings
  */
#define SetMenuCheck(id, flag)                                              \
    if ((menuObj = (Object *) DoMethod(MainMenu, MUIM_FindUData, (id))))    \
    { set(menuObj, MUIA_Menuitem_Checked, (flag));                          \
    } 

  switch(TrnMode & TNMODE_TABMASK)
  { case 0:
      SetMenuCheck(ID_Prefs_Scoring_Simple, TRUE);
      SetMenuCheck(ID_Prefs_Scoring_Buchholz, FALSE);
      SetMenuCheck(ID_Prefs_Scoring_ExtBuchholz, FALSE);
      SetMenuCheck(ID_Prefs_Scoring_SonnebornBerger, FALSE);
      break;
    case TNMODEF_BUCHHOLZ:
      SetMenuCheck(ID_Prefs_Scoring_Simple, FALSE);
      SetMenuCheck(ID_Prefs_Scoring_Buchholz, TRUE);
      SetMenuCheck(ID_Prefs_Scoring_ExtBuchholz, FALSE);
      SetMenuCheck(ID_Prefs_Scoring_SonnebornBerger, FALSE);
      break;
    case TNMODEF_EXT_BUCHHOLZ:
      SetMenuCheck(ID_Prefs_Scoring_Simple, FALSE);
      SetMenuCheck(ID_Prefs_Scoring_Buchholz, FALSE);
      SetMenuCheck(ID_Prefs_Scoring_ExtBuchholz, TRUE);
      SetMenuCheck(ID_Prefs_Scoring_SonnebornBerger, FALSE);
      break;
    case TNMODEF_SONNEBORN_BERGER:
      SetMenuCheck(ID_Prefs_Scoring_Simple, FALSE);
      SetMenuCheck(ID_Prefs_Scoring_Buchholz, FALSE);
      SetMenuCheck(ID_Prefs_Scoring_ExtBuchholz, FALSE);
      SetMenuCheck(ID_Prefs_Scoring_SonnebornBerger, TRUE);
      break;
  }
  switch (OutputDevice)
  { case DEVICE_Screen:
      SetMenuCheck(ID_Prefs_Device_Screen, TRUE);
      SetMenuCheck(ID_Prefs_Device_PrinterDraft, FALSE);
      SetMenuCheck(ID_Prefs_Device_PrinterLQ, FALSE);
      SetMenuCheck(ID_Prefs_Device_File, FALSE);
      break;
    case DEVICE_PrinterDraft:
      SetMenuCheck(ID_Prefs_Device_Screen, FALSE);
      SetMenuCheck(ID_Prefs_Device_PrinterDraft, TRUE);
      SetMenuCheck(ID_Prefs_Device_PrinterLQ, FALSE);
      SetMenuCheck(ID_Prefs_Device_File, FALSE);
      break;
    case DEVICE_PrinterLQ:
      SetMenuCheck(ID_Prefs_Device_Screen, FALSE);
      SetMenuCheck(ID_Prefs_Device_PrinterDraft, FALSE);
      SetMenuCheck(ID_Prefs_Device_PrinterLQ, TRUE);
      SetMenuCheck(ID_Prefs_Device_File, FALSE);
      break;
    case DEVICE_FileAscii:
      SetMenuCheck(ID_Prefs_Device_Screen, FALSE);
      SetMenuCheck(ID_Prefs_Device_PrinterDraft, FALSE);
      SetMenuCheck(ID_Prefs_Device_PrinterLQ, FALSE);
      SetMenuCheck(ID_Prefs_Device_File, TRUE);
      break;
  }
  SetMenuCheck(ID_Prefs_MakeIcons, MakeIcons);
}
#endif  /*  AMIGA   */




/*
    ProcessMainWnd() waits for user actions like selecting a menu or
    messages from the ARexx-port and processes them in an endless loop.
*/
int EnableARexx = TRUE;
static int GamesToBeSet = FALSE;
void ProcessMainWnd(void)

#ifdef AMIGA
{ ULONG Signal, open, ID;
  APTR UserData;
  int round, initMenu;

  for (;;)
  { /*
        Disable the menus, so the window is sleeping for our purposes.
    */
    set (MainWnd, MUIA_Window_NoMenus, TRUE);

    /*
        Check for user actions
    */
    ID = DoMethod(App, MUIM_Application_Input, &Signal);
    EnableARexx = FALSE;
    initMenu = FALSE;
    switch(ID)
    { case MUIV_Application_ReturnID_Quit:
        if (TestSaved())
        { exit(0);
        }
        break;
      case ID_MenuAction:
        get(App, MUIA_Application_MenuAction, &UserData);
        switch((ULONG) UserData)
        { case ID_Project_Quit:
            if (TestSaved())
            { exit(0);
            }
            break;
          case ID_Project_New:
            if (TestSaved())
            { NewTournament();
              initMenu = TRUE;
            }
            break;
          case ID_Project_Load:
            if (TestSaved())
            { LoadTournament(NULL, NULL, NULL);
              initMenu = TRUE;
            }
            break;
          case ID_Project_Save:
            SaveTournament(TrnFileName);
            break;
          case ID_Project_SaveAs:
            SaveTournament(NULL);
            initMenu = TRUE;
            break;
          case ID_Project_About:
            About();
            break;
          case ID_Players_Add:
            AddPlayers();
            initMenu = TRUE;
            break;
          case ID_Players_Import:
            ImportPlayers();
            initMenu = TRUE;
            break;
          case ID_Players_Modify:
            ModifyPlayers();
            initMenu = TRUE;
            break;
          case ID_Players_Delete:
            DeletePlayers();
            initMenu = TRUE;
            break;
          case ID_Round_Pairings_SwissPairing:
            DoPairings(TNMODEF_SWISS_PAIRING, TRUE, GamesToBeSet);
            initMenu = TRUE;
            break;
          case ID_Round_Pairings_RoundRobin:
            DoPairings(TNMODEF_ROUND_ROBIN, TRUE, FALSE);
            initMenu = TRUE;
            break;
          case ID_Round_Pairings_RoundRobinShift:
            DoPairings(TNMODEF_ROUND_ROBIN | TNMODEF_SHIFT_SYSTEM, TRUE, FALSE);
            initMenu = TRUE;
            break;
          case ID_Round_Results:
            if ((round = GetRoundNr()) != 0)
            { EnterResults(round);
              initMenu = TRUE;
            }
            break;
          case ID_Output_PlayerList_Short:
            OutPlayerList(NULL, OutputDevice, FALSE);
            break;
          case ID_Output_PlayerList_Long:
            OutPlayerList(NULL, OutputDevice, TRUE);
            break;
          case ID_Output_Rankings:
            OutInternalRankings(NULL, OutputDevice);
            break;
          case ID_Output_Round:
            if ((round = GetRoundNr()) != 0)
            { OutRound(NULL, OutputDevice, round);
            }
            break;
          case ID_Output_Table_All:
            OutTable(NULL, OutputDevice, 0, TrnMode);
            break;
          case ID_Output_Table_Seniors:
            OutTable(NULL, OutputDevice, TNFLAGSF_SENIOR, TrnMode);
            break;
          case ID_Output_Table_Juniors:
            OutTable(NULL, OutputDevice, TNFLAGSF_JUNIOR, TrnMode);
            break;
          case ID_Output_Table_Women:
            OutTable(NULL, OutputDevice, TNFLAGSF_WOMAN, TrnMode);
            break;
          case ID_Output_Table_JuniorsA:
            OutTable(NULL, OutputDevice, TNFLAGSF_JUNIORA, TrnMode);
            break;
          case ID_Output_Table_JuniorsB:
            OutTable(NULL, OutputDevice, TNFLAGSF_JUNIORB, TrnMode);
            break;
          case ID_Output_Table_JuniorsC:
            OutTable(NULL, OutputDevice, TNFLAGSF_JUNIORC, TrnMode);
            break;
          case ID_Output_Table_JuniorsD:
            OutTable(NULL, OutputDevice, TNFLAGSF_JUNIORD, TrnMode);
            break;
          case ID_Output_Table_JuniorsE:
            OutTable(NULL, OutputDevice, TNFLAGSF_JUNIORE, TrnMode);
            break;
          case ID_Output_TableProgress:
            OutTableProgress(NULL, OutputDevice, TrnMode);
            break;
          case ID_Output_DWZReport:
            OutDWZReport(NULL, OutputDevice);
            break;
          case ID_Output_CrossTable_Ascii:
            OutCrossTable(NULL, OutputDevice);
            break;
          case ID_Output_CrossTable_TeX:
            OutCrossTable(NULL, DEVICE_FileTeX);
            break;
          case ID_Output_PlayerCards_Ascii:
            OutPlayerCards(NULL, OutputDevice);
            break;
          case ID_Output_PlayerCards_TeX:
            OutPlayerCards(NULL, DEVICE_FileTeX);
            break;
          case ID_Prefs_Scoring_Simple:
            TrnMode &= ~TNMODE_TABMASK;
            initMenu = TRUE;
            break;
          case ID_Prefs_Scoring_Buchholz:
            TrnMode = (TrnMode & ~TNMODE_TABMASK) | TNMODEF_BUCHHOLZ;
            initMenu = TRUE;
            break;
          case ID_Prefs_Scoring_ExtBuchholz:
            TrnMode = (TrnMode & ~TNMODE_TABMASK) | TNMODEF_EXT_BUCHHOLZ;
            initMenu = TRUE;
            break;
          case ID_Prefs_Scoring_SonnebornBerger:
            TrnMode = (TrnMode & ~TNMODE_TABMASK) | TNMODEF_SONNEBORN_BERGER;
            initMenu = TRUE;
            break;
          case ID_Prefs_Device_Screen:
            OutputDevice = DEVICE_Screen;
            initMenu = TRUE;
            break;
          case ID_Prefs_Device_PrinterDraft:
            OutputDevice = DEVICE_PrinterDraft;
            initMenu = TRUE;
            break;
          case ID_Prefs_Device_PrinterLQ:
            OutputDevice = DEVICE_PrinterLQ;
            initMenu = TRUE;
            break;
          case ID_Prefs_Device_File:
            OutputDevice = DEVICE_FileAscii;
            initMenu = TRUE;
            break;
          case ID_Prefs_SetGames:
            GamesToBeSet = !GamesToBeSet;
            initMenu = TRUE;
            break;
          case ID_Prefs_MakeIcons:
            MakeIcons = !MakeIcons;
            initMenu = TRUE;
            break;
          default:
            if (UserData != NULL)
            { EnableARexx = TRUE;
              SystemTags(UserData, SYS_UserShell, NULL, TAG_END);
            }
            initMenu = TRUE;
        }
    }
    EnableARexx = TRUE;

    /*
        Let the window awake.
    */
    get(MainWnd, MUIA_Window_Open, &open);
    if (!NoWindow)
    { if (!open)
      { set(MainWnd, MUIA_Window_Open, TRUE);
      }
      if (initMenu)
      { MakeDisplay();
      }
      set(MainWnd, MUIA_Window_NoMenus, FALSE);
    }
    EnableARexx = TRUE;


    /*
        And put the application to sleep, waiting for user actions.
    */
    if(Signal)
    { Wait(Signal);
    }
  }
}
#endif  /*  AMIGA   */




/*
    SetupPrefs() sets up the preferences in a way corresponding to a new
    or loaded tournament.
*/
void SetupPrefs(void)
#ifdef AMIGA
{ switch (TrnMode &= TNMODE_TABMASK)
  { case TNMODEF_BUCHHOLZ:
      DoMethod(MainWnd, MUIM_Window_SetMenuCheck, ID_Prefs_Scoring_Buchholz,
               TRUE);
      break;
    case TNMODEF_EXT_BUCHHOLZ:
      DoMethod(MainWnd, MUIM_Window_SetMenuCheck,
               ID_Prefs_Scoring_ExtBuchholz, TRUE);
      break;
    case TNMODEF_SONNEBORN_BERGER:
      DoMethod(MainWnd, MUIM_Window_SetMenuCheck,
               ID_Prefs_Scoring_SonnebornBerger, TRUE);
      break;
    default:
      DoMethod(MainWnd, MUIM_Window_SetMenuCheck, ID_Prefs_Scoring_Simple,
               TRUE);
      break;
  }
}
#endif  /*  AMIGA   */

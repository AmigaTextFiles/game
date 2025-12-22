/***
***
***  amyboard.c -- Amiga front end for XBoard
***
*** ------------------------------------------------------------------------
*** This program is free software; you can redistribute it and/or modify
*** it under the terms of the GNU General Public License as published by
*** the Free Software Foundation; either version 2 of the License, or
*** (at your option) any later version.
***
*** This program is distributed in the hope that it will be useful,
*** but WITHOUT ANY WARRANTY; without even the implied warranty of
*** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*** GNU General Public License for more details.
***
*** You should have received a copy of the GNU General Public License
*** along with this program; if not, write to the Free Software
*** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*** ------------------------------------------------------------------------
***
**/
/**/


/***  Version information
***/
#define VERSION         330
#define REVISION        5
#define DATE            "12.08.95"
#define NAME            "AmyBoard"
#define VERS            "AmyBoard 330.5"
#define VSTRING         "AmyBoard 330.5 (12.08.95)"
#define VERSTAG         "\0$VER: AmyBoard 330.5 (12.08.95)"
/**/


/***  Include files
***/
#include "amyboard.h"

#include <libraries/gadtools.h>
#include <libraries/asl.h>
#include <libraries/iffparse.h>
/**/


/***  Global variables
***/
char *programName                       = VERS;

AmigaAppData amigaAppData;

Object* xboardApp                           = NULL;
Object* xboardWindow;
Object* xboardChessboard;
Object* xboardMenu;
Object* xboardText;
Object* xboardExtText;
Object* xboardUpperTime;
Object* xboardLowerTime;
Object* editCommentWindow                   = NULL;


void LoadGameProc(void);
void LoadNextGameProc(void);
void LoadPrevGameProc(void);
void ReloadGameProc(void);
void LoadPositionProc(void);
void SaveGameProc(void);
void SavePositionProc(void);
void ReloadCmailMsgProc(void);
void AboutProc(void);
void QuitProc(void);
void AlwaysQueenProc(void);
void AutocommProc(void);
void AutoflagProc(void);
void AutoobsProc(void);
void AutosaveProc(void);
void AutoFlipViewProc(void);
void BellProc(void);
void FlipViewProc(void);
void OldSaveStyleProc(void);
void QuietPlayProc(void);
void ShowCoordsProc(void);
void ShowThinkingProc(void);
void EditGameInfoProc(void);
void EditCommentProc(void);

#define TOGGLE CHECKIT|MENUTOGGLE
static struct NewMenu xboardNewMenu [] =
{ { NM_TITLE,   (STRPTR) "Project",              NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Reset Game",           (STRPTR) "r",  0,        0,   (APTR) ResetGameEvent },
  { NM_ITEM,    (STRPTR) "Load Game",            (STRPTR) "g",  CHECKIT,  0,   (APTR) LoadGameProc },
  { NM_ITEM,    (STRPTR) "Load Next Game",       (STRPTR) "N",  0,        0,   (APTR) LoadNextGameProc },
  { NM_ITEM,    (STRPTR) "Load Previous Game",   (STRPTR) "P",  0,        0,   (APTR) LoadPrevGameProc },
  { NM_ITEM,    (STRPTR) "Reload Same Game",     NULL,          0,        0,   (APTR) ReloadGameProc },
  { NM_ITEM,    (STRPTR) "Load Position",        NULL,          0,        0,   (APTR) LoadPositionProc },
  { NM_ITEM,    NM_BARLABEL,                     NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Save Game",            (STRPTR) "s",  0,        0,   (APTR) SaveGameProc },
  { NM_ITEM,    (STRPTR) "Save Position",        NULL,          0,        0,   (APTR) SavePositionProc },
  { NM_ITEM,    NM_BARLABEL,                     NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Mail Move",            NULL,          0,        0,   (APTR) MailMoveEvent },
  { NM_ITEM,    (STRPTR) "Reload CMail Message", NULL,          0,        0,   (APTR) ReloadCmailMsgProc },
  { NM_ITEM,    NM_BARLABEL,                     NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "About",                NULL,          0,        0,   (APTR) AboutProc },
  { NM_ITEM,    (STRPTR) "Exit",                 (STRPTR) "q",  0,        0,   (APTR) QuitProc },
  { NM_TITLE,   (STRPTR) "Mode",                 NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Machine White",        NULL,          CHECKIT,  496, (APTR) MachineWhiteEvent },
  { NM_ITEM,    (STRPTR) "Machine Black",        NULL,          CHECKIT,  488, (APTR) MachineBlackEvent },
  { NM_ITEM,    (STRPTR) "Two Machines",         NULL,          CHECKIT,  472, (APTR) TwoMachinesEvent },
  { NM_ITEM,    (STRPTR) "ICS Client",           NULL,          CHECKIT,  440, (APTR) IcsClientEvent },
  { NM_ITEM,    (STRPTR) "Edit Game",            NULL,          CHECKIT,  376, (APTR) EditGameEvent },
  { NM_ITEM,    (STRPTR) "Edit Position",        NULL,          CHECKIT,  248, (APTR) EditPositionEvent },
  { NM_ITEM,    NM_BARLABEL,                     NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Show Game List",       NULL,          0,        0,   (APTR) ShowGameListProc },
  { NM_ITEM,    (STRPTR) "Edit Tags",            NULL,          0,        0,   (APTR) EditTagsProc },
  { NM_ITEM,    (STRPTR) "Edit Comment",         NULL,          0,        0,   (APTR) EditCommentProc },
  { NM_ITEM,    (STRPTR) "Pause",                (STRPTR) "p",  CHECKIT,  0,   (APTR) PauseEvent },
  { NM_TITLE,   (STRPTR) "Action",               NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Accept",               NULL,          0,        0,   (APTR) AcceptEvent },
  { NM_ITEM,    (STRPTR) "Decline",              NULL,          0,        0,   (APTR) DeclineEvent },
  { NM_ITEM,    NM_BARLABEL,                     NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Call Flag",            (STRPTR) "t",  0,        0,   (APTR) CallFlagEvent },
  { NM_ITEM,    (STRPTR) "Draw",                 (STRPTR) "d",  0,        0,   (APTR) DrawEvent },
  { NM_ITEM,    (STRPTR) "Adjourn",              NULL,          0,        0,   (APTR) AdjournEvent },
  { NM_ITEM,    (STRPTR) "Abort",                NULL,          0,        0,   (APTR) AbortEvent },
  { NM_ITEM,    (STRPTR) "Resign",               (STRPTR) "R",  0,        0,   (APTR) ResignEvent },
  { NM_ITEM,    NM_BARLABEL,                     NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Stop Observing",       NULL,          0,        0,   (APTR) StopObservingEvent },
  { NM_ITEM,    (STRPTR) "Stop Examining",       NULL,          0,        0,   (APTR) StopExaminingEvent },
  { NM_TITLE,   (STRPTR) "Step",                 NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Backward",             (STRPTR) "b",  0,        0,   (APTR) BackwardEvent },
  { NM_ITEM,    (STRPTR) "Forward",              (STRPTR) "f",  0,        0,   (APTR) ForwardEvent },
  { NM_ITEM,    (STRPTR) "Back to Start",        (STRPTR) "B",  0,        0,   (APTR) ToStartEvent },
  { NM_ITEM,    (STRPTR) "Forward to End",       (STRPTR) "F",  0,        0,   (APTR) ToEndEvent },
  { NM_ITEM,    (STRPTR) "Revert",               NULL,          0,        0,   (APTR) RevertEvent },
  { NM_ITEM,    (STRPTR) "Truncate Game",        NULL,          0,        0,   (APTR) TruncateGameEvent },
  { NM_ITEM,    NM_BARLABEL,                     NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Move Now",             NULL,          0,        0,   (APTR) MoveNowEvent },
  { NM_ITEM,    (STRPTR) "Retract Move",         NULL,          0,        0,   (APTR) RetractMoveEvent },
  { NM_TITLE,   (STRPTR) "Options",              NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Always Queen",         NULL,          TOGGLE,   0,   (APTR) AlwaysQueenProc },
  { NM_ITEM,    (STRPTR) "Auto Comment",         NULL,          TOGGLE,   0,   (APTR) AutocommProc },
  { NM_ITEM,    (STRPTR) "Auto Flag",            NULL,          TOGGLE,   0,   (APTR) AutoflagProc },
  { NM_ITEM,    (STRPTR) "Auto Observe",         NULL,          TOGGLE,   0,   (APTR) AutoobsProc },
  { NM_ITEM,    (STRPTR) "Auto Save",            NULL,          TOGGLE,   0,   (APTR) AutosaveProc },
  { NM_ITEM,    (STRPTR) "Auto Flip View",       NULL,          TOGGLE,   0,   (APTR) AutoFlipViewProc },
  { NM_ITEM,    (STRPTR) "Bell",                 NULL,          TOGGLE,   0,   (APTR) BellProc },
  { NM_ITEM,    (STRPTR) "Flip View",            NULL,          TOGGLE,   0,   (APTR) FlipViewProc },
  { NM_ITEM,    (STRPTR) "Old Save Style",       NULL,          TOGGLE,   0,   (APTR) OldSaveStyleProc },
  { NM_ITEM,    (STRPTR) "Quiet Play",           NULL,          TOGGLE,   0,   (APTR) QuietPlayProc },
  { NM_ITEM,    (STRPTR) "Show Coords",          NULL,          TOGGLE,   0,   (APTR) ShowCoordsProc },
  { NM_ITEM,    (STRPTR) "Show Thinking",        NULL,          TOGGLE,   0,   (APTR) ShowThinkingProc },
  { NM_TITLE,   (STRPTR) "Help",                 NULL,          0,        0,   NULL },
  { NM_ITEM,    (STRPTR) "Hint",                 NULL,          0,        0,   (APTR) HintEvent },
  { NM_ITEM,    (STRPTR) "Book",                 NULL,          0,        0,   (APTR) BookEvent },
  { NM_ITEM,    (STRPTR) "About Game",           NULL,          0,        0,   (APTR) AboutGameEvent },
  { NM_END,     NULL,                            NULL,          0,        0,   NULL }
};
/**/


/***  Cleanup function
***/
void Cleanup(void)

{ if(xboardApp)
  { MUI_DisposeObject(xboardApp);
  }
  TimeClose();
  PipesClose();
  MuiClassClose();
}
/**/


/***  Argument section
***
***  The following macro consists of a repeated use of the macro
***  XBOARD_ARG, one for each possible argument. The macro's synopsis
***  is
***
***    XBOARD_ARG(argName, type, template, defaultVal, helpString);
***
***  Inputs:
***     argName - the arguments name; an entry of the struct AppData
***         (see common.h)
***     type - the argument type as defined by ParseArgs()
***     template - a template string that may be used by ReadArgs()
***     defaultVal - default value
***     helpString - string to be printed if the user requests help;
***         may be empty in case the argument should not be displayed
***         to the user. (Some arguments are present for source code
***         compatibility only.)
***
***  This file is used from xboard.c by including it repeatedly with
***  different definitions of XBOARD_ARG. For example, to get the
***  defaults we do the following:
***
***   #define XBOARD_ARG(argName, type, template, defaultVal, helpString) \
***     appData.argName = defaultVal;
***   XBOARD_ARGS
***
***************************************************************************/
#define XBOARD_ARGS \
XBOARD_ARG(appData.whitePieceColor,      PARSEARGS_TYPE_INTEGER, "WPP=WHITEPIECEPEN",       -1,                   "\twpp=whitePiecePen/K/N pennumber\n")\
XBOARD_ARG(appData.blackPieceColor,      PARSEARGS_TYPE_INTEGER, "BPP=BLACKPIECEPEN",       -1,                   "\tbpp=blackPiecePen/K/N pennumber\n")\
XBOARD_ARG(appData.lightSquareColor,     PARSEARGS_TYPE_INTEGER, "LSP=LIGHTSQUAREPEN",      -1,                   "\tlsp=lightSquarePen/K/N pennumber\n")\
XBOARD_ARG(appData.darkSquareColor,      PARSEARGS_TYPE_INTEGER, "DSP=DARKSQUAREPEN",       -1,                   "\tdsp=darkSquarePen/K/N pennumber\n")\
XBOARD_ARG(appData.movesPerSession,      PARSEARGS_TYPE_INTEGER, "MP=MOVESPERSESSION",      MOVES_PER_SESSION,    "\tmp=movesPerSession/K/N number\n")\
XBOARD_ARG(appData.initString,           PARSEARGS_TYPE_STRING,  "INITSTRING",              INIT_STRING,          "")\
XBOARD_ARG(appData.whiteString,          PARSEARGS_TYPE_STRING,  "WHITESTRING",             WHITE_STRING,         "")\
XBOARD_ARG(appData.blackString,          PARSEARGS_TYPE_STRING,  "BLACKSTRING",             BLACK_STRING,         "")\
XBOARD_ARG(appData.firstChessProgram,    PARSEARGS_TYPE_STRING,  "FCP=FIRSTCHESSPROGRAM",   "gnuchessx",          "")\
XBOARD_ARG(appData.secondChessProgram,   PARSEARGS_TYPE_STRING,  "SCP=SECONDCHESSPROGRAM",  "gnuchessx",          "")\
XBOARD_ARG(appData.noChessProgram,       PARSEARGS_TYPE_BOOL,    "NCP=NOCHESSPROGRAM",      FALSE,                "\tncp=noChessProgram/T\n")\
XBOARD_ARG(appData.firstHost,            PARSEARGS_TYPE_STRING,  "FIRSTHOST",               FIRST_HOST,           "")\
XBOARD_ARG(appData.secondHost,           PARSEARGS_TYPE_STRING,  "SECONDHOST",              SECOND_HOST,          "")\
XBOARD_ARG(appData.bitmapDirectory,      PARSEARGS_TYPE_STRING,  "BITMAPDIRECTORY",         NULL,                 "\tbmdir=bitmapDirectory/K dirname\n")\
XBOARD_ARG(appData.remoteShell,          PARSEARGS_TYPE_STRING,  "REMOTESHELL",             "",                   "")\
XBOARD_ARG(appData.remoteUser,           PARSEARGS_TYPE_STRING,  "REMOTEUSER",              "",                   "")\
XBOARD_ARG(appData.timeDelay,            PARSEARGS_TYPE_FLOAT,   "TIMEDELAY",               TIME_DELAY,           "")\
XBOARD_ARG(appData.timeControl,          PARSEARGS_TYPE_STRING,  "TIMECONTROL",             TIME_CONTROL,         "\ttc=timeControl/K\n")\
XBOARD_ARG(appData.icsActive,            PARSEARGS_TYPE_BOOL,    "ICS=ICSACTIVE",           FALSE,                "\tics=icsActive/T\n")\
XBOARD_ARG(appData.icsHost,              PARSEARGS_TYPE_STRING,  "ICSHOST",                 ICS_HOST,             "\ticsHost/K hostname\n")\
XBOARD_ARG(appData.icsPort,              PARSEARGS_TYPE_STRING,  "ICSPORT",                 ICS_PORT,             "\ticsPort/K portnumber\n")\
XBOARD_ARG(appData.icsCommPort,          PARSEARGS_TYPE_STRING,  "ICSCOMMPORT",             ICS_COMM_PORT,        "")\
XBOARD_ARG(appData.icsLogon,             PARSEARGS_TYPE_STRING,  "ICSLOGON",                ".icsrc",             "\ticsLogon/K scriptname\n")\
XBOARD_ARG(appData.useTelnet,            PARSEARGS_TYPE_BOOL,    "USETELNET",               TRUE,                 "")\
XBOARD_ARG(appData.telnetProgram,        PARSEARGS_TYPE_STRING,  "TELNETPROGRAM",           "AmiTCP:bin/telnet",  "\ttp=telnetProgram/K programpath\n")\
XBOARD_ARG(appData.gateway,              PARSEARGS_TYPE_STRING,  "GATEWAY",                 "",                   "")\
XBOARD_ARG(appData.loadGameFile,         PARSEARGS_TYPE_STRING,  "LGF=LOADGAMEFILE",        "",                   "\tlgf=loadGameFile/K filename\n")\
XBOARD_ARG(appData.loadGameIndex,        PARSEARGS_TYPE_INTEGER, "LGI=LOADGAMEINDEX",       0,                    "\tlgi=loadGameIndex/K/N gamenumber\n")\
XBOARD_ARG(appData.saveGameFile,         PARSEARGS_TYPE_STRING,  "SGF=SAVEGAMEFILE",        "",                   "\tsgf=saveGameFile/K filename\n")\
XBOARD_ARG(appData.autoSaveGames,        PARSEARGS_TYPE_BOOL,    "AUTOSAVEGAMES",           FALSE,                "\tautoSaveGames/T\n")\
XBOARD_ARG(appData.loadPositionFile,     PARSEARGS_TYPE_STRING,  "LPF=LOADPOSITIONFILE",    "",                   "\tlpf=loadPositionFile/K filename\n")\
XBOARD_ARG(appData.loadPositionIndex,    PARSEARGS_TYPE_INTEGER, "LPI=LOADPOSITIONINDEX",   1,                    "\tlpi=loadPositionIndex/K/N positionnumber\n")\
XBOARD_ARG(appData.savePositionFile,     PARSEARGS_TYPE_STRING,  "SPF=SAVEPOSITIONFILE",    "",                   "\tspf=savePositionFile/K filename\n")\
XBOARD_ARG(appData.matchMode,            PARSEARGS_TYPE_BOOL,    "MM=MATCHMODE",            FALSE,                "\tmm=matchMode/T\n")\
XBOARD_ARG(appData.monoMode,             PARSEARGS_TYPE_BOOL,    "MONO=MONOMODE",           FALSE,                "")\
XBOARD_ARG(appData.debugMode,            PARSEARGS_TYPE_BOOL,    "DEBUG=DEBUGMODE",         FALSE,                "")\
XBOARD_ARG(appData.clockMode,            PARSEARGS_TYPE_BOOL,    "CM=CLOCKMODE",            TRUE,                 "\tcm=clockMode/T\n")\
XBOARD_ARG(appData.boardSize,            PARSEARGS_TYPE_STRING,  "SIZE=BOARDSIZE",          "",                   "\tsize=boardSize/K [small|medium|big]\n")\
XBOARD_ARG(appData.Iconic,               PARSEARGS_TYPE_BOOL,    "ICONIC",                  FALSE,                "")\
XBOARD_ARG(appData.searchTime,           PARSEARGS_TYPE_STRING,  "ST=SEARCHTIME",           "",                   "\tst=searchTime/K minutes:seconds\n")\
XBOARD_ARG(appData.searchDepth,          PARSEARGS_TYPE_INTEGER, "SD=SEARCHDEPTH",          0,                    "\tsd=searchDepth/K/N number\n")\
XBOARD_ARG(appData.showCoords,           PARSEARGS_TYPE_BOOL,    "COORDS=SHOWCOORDS",       FALSE,                "")\
XBOARD_ARG(appData.clockFont,            PARSEARGS_TYPE_STRING,  "CLOCKFONT",               "",                   "")\
XBOARD_ARG(appData.messageFont,          PARSEARGS_TYPE_STRING,  "MESSAGEFONT",             "",                   "")\
XBOARD_ARG(appData.coordFont,            PARSEARGS_TYPE_STRING,  "COORDFONT",               "",                   "")\
XBOARD_ARG(appData.ringBellAfterMoves,   PARSEARGS_TYPE_BOOL,    "BELL=RINGBELLAFTERMOVES", FALSE,                "\tbell=ringBellAfterMoves/T\n")\
XBOARD_ARG(appData.autoCallFlag,         PARSEARGS_TYPE_BOOL,    "CALLFLAG",                FALSE,                "\tcallFlag/T\n")\
XBOARD_ARG(appData.flipView,             PARSEARGS_TYPE_BOOL,    "FLIPVIEW",                FALSE,                "\tflipView/T\n")\
XBOARD_ARG(appData.cmailGameName,        PARSEARGS_TYPE_STRING,  "CMAILGAMENAME",           "",                   "")\
XBOARD_ARG(appData.alwaysPromoteToQueen, PARSEARGS_TYPE_BOOL,    "ALWAYSQUEEN",             FALSE,                "\talwaysQueen/T\n")\
XBOARD_ARG(appData.oldSaveStyle,         PARSEARGS_TYPE_BOOL,    "OLDSAVESTYLE",            FALSE,                "")\
XBOARD_ARG(appData.quietPlay,            PARSEARGS_TYPE_BOOL,    "QUIETPLAY",               FALSE,                "")\
XBOARD_ARG(appData.showThinking,         PARSEARGS_TYPE_BOOL,    "SHOWTHINKING",            FALSE,                "\tshowThinking/T\n")\
XBOARD_ARG(appData.autoObserve,          PARSEARGS_TYPE_BOOL,    "AUTOOBSERVE",             FALSE,                "\tobserve/T\n")\
XBOARD_ARG(appData.autoComment,          PARSEARGS_TYPE_BOOL,    "AUTOCOMMENT",             FALSE,                "")\
XBOARD_ARG(appData.borderXoffset,        PARSEARGS_TYPE_INTEGER, "BORDERXOFFSET",           FALSE,                "")\
XBOARD_ARG(appData.borderYoffset,        PARSEARGS_TYPE_INTEGER, "BORDERYOFFSET",           FALSE,                "")\
XBOARD_ARG(appData.titleInWindow,        PARSEARGS_TYPE_BOOL,    "TITLEINWINDOW",           TRUE,                 "")\
XBOARD_ARG(appData.localEdit,            PARSEARGS_TYPE_BOOL,    "LOCALEDIT",               FALSE,                "")\
XBOARD_ARG(appData.autoFlipView,         PARSEARGS_TYPE_BOOL,    "AUTOFLIPVIEW",            TRUE,                 "")\
XBOARD_ARG(appData.zippyTalk,            PARSEARGS_TYPE_BOOL,    "ZIPPYTALK",               FALSE,                "")\
XBOARD_ARG(appData.zippyPlay,            PARSEARGS_TYPE_BOOL,    "ZIPPYPLAY",               FALSE,                "")\
XBOARD_ARG(amigaAppData.icsWindow,       PARSEARGS_TYPE_STRING,  "ICSWINDOW",               NULL,                 "")\
XBOARD_ARG(amigaAppData.childPriority,   PARSEARGS_TYPE_INTEGER, "CHILDPRIORITY",           0,                    "\tchildPriority/K/N number\n")\
XBOARD_ARG(amigaAppData.childStack,      PARSEARGS_TYPE_INTEGER, "CHILDSTACK",              100000,               "\tchildStack/K/N number\n")




int ProcessArgs(int argc, char *argv[])

{ static const Tag parseArgTags[] =
  {
#undef XBOARD_ARG
#define XBOARD_ARG(argName, type, template, defaultVal, helpString) \
    PARSEARGS_ARGNAME,    (Tag) template,        \
    PARSEARGS_TYPE,       type,                  \
    PARSEARGS_VALPTR,     (Tag) &argName,
    XBOARD_ARGS

#undef XBOARD_ARG
#define XBOARD_ARG(argName, type, template, defaultVal, helpString) \
	helpString
    PARSEARGS_HELPSTRING, (Tag) XBOARD_ARGS,

    PARSEARGS_PREFSFILE,  (Tag) "PROGDIR:lib/amyboard.prefs",
    PARSEARGS_PREFSFILE,  (Tag) "PROGDIR:/lib/amyboard.prefs",
    PARSEARGS_PREFSFILE,  (Tag) "ENV:amyboard.prefs",
    TAG_DONE
  };

#undef XBOARD_ARG
#define XBOARD_ARG(argName, type, template, defaultVal, helpString) \
    argName = defaultVal;
  XBOARD_ARGS

  return(ParseArgsA(argc, argv, (struct TagItem *) parseArgTags));
}
/**/


/***  ICSInitScript function
***/
void ICSInitScript(void)

{ FILE *fp = NULL;
  char buf[MSG_SIZ];
  char **ptr, *fileName;
  static char *searchDirs[] =
  { "",
    "PROGDIR:",
    "PROGDIR:lib",
    "PROGDIR:/lib",
    "ENV:",
    NULL
  };

  for (ptr = searchDirs;  *ptr;  ptr++)
  { if (**ptr)
    { strcpy(buf, *ptr);
      AddPart((STRPTR) buf, (STRPTR) appData.icsLogon, sizeof(buf));
      fileName = buf;
    }
    else
    { fileName = appData.icsLogon;
    }
    if ((fp = fopen(fileName, "r")))
    { break;
    }
  }

  if (fp)
  { ProcessICSInitScript(fp);
  }
}
/**/


/***  main() function
***
***  Initializing and main loop.
**/
void CreateMUIApp(void);
int main(int argc, char *argv[])

{ ULONG signalmask;

  /**
  ***  Get stderr, if running from Workbench.
  **/
  if (!argc)
  { if (!freopen("CON:////amyboard stderr/AUTO", "w", stderr))
    { exit(10);
    }
  }
  debugFP = stderr;
  toUserFP = stderr;

  if (atexit(Cleanup))
  { exit(10);
  }

  MuiClassInit();
  PipesInit();
  TimeInit();


  if (!(ProcessArgs(argc, argv)))
  { fprintf(stderr, "Error %ld while parsing arguments.\n", IoErr());
    exit(10);
  }

  InitBackEnd1();

  CreateMUIApp();

  InitBackEnd2();

  if (appData.icsActive)
  { ICSInitScript();
  }

  signalmask = timeSignals |
	       SIGBREAKF_CTRL_C | SIGBREAKF_CTRL_C;

  for(;;)
  { ULONG receivedsigs;
    ULONG muisigs;
    LONG id;

    while ((id = DoMethod(xboardApp, MUIM_Application_Input, &muisigs)))
    { switch (id)
      { case MUIV_Application_ReturnID_Quit:
	  ExitEvent(0);
	  break;
      }
    }

    receivedsigs = Wait(muisigs | pipeSignals | signalmask);

    if (receivedsigs & (SIGBREAKF_CTRL_C|SIGBREAKF_CTRL_D))
    { ExitEvent(0);
    }
    if (receivedsigs & timeSignals)
    { TimeCallback(receivedsigs);
    }
    if (receivedsigs & pipeSignals)
    { DoInputCallback(receivedsigs);
    }
  }
}
#if defined(_DCC)
int wbmain(struct WBStartup *wbs){return(main(0, (char **)wbs));}
#endif
/**/


/***  ResetFrontEnd() function
***
***  Called from backend.
**/
void CommentPopDown(void);
void EditCommentPopDown(void);
APTR ProcToMenuitem(APTR);
void ResetFrontEnd()

{ CommentPopDown();
  EditCommentPopDown();
  TagsPopDown();
  DrawPosition(TRUE, NULL);
}
/**/


/***  Menuitem section
***
***  The following structures define, which menuitems are enabled
***  or disabled in different program modes.
**/
typedef struct
{ APTR Proc;
  Boolean value;
} Sensitivity;


APTR ProcToMenuitem(APTR proc)

{ if (!proc)
  { return(NULL);
  }
  return((APTR) DoMethod(xboardMenu, MUIM_FindUData, proc));
}

void SetMenuSensitivity(Sensitivity *sens)

{ APTR obj;

  while(sens->Proc != NULL)
  { if ((obj = ProcToMenuitem(sens->Proc)))
    { set(obj, MUIA_Menuitem_Enabled, sens->value);
    }
    ++sens;
  }
}

Sensitivity icsSensitivity[] =
{ { (APTR) MailMoveEvent,          FALSE },
  { (APTR) ReloadCmailMsgProc,     FALSE },
  { (APTR) MachineBlackEvent,      FALSE },
  { (APTR) MachineWhiteEvent,      FALSE },
  { (APTR) TwoMachinesEvent,       FALSE },
#ifndef ZIPPY
  { (APTR) HintEvent,              FALSE },
  { (APTR) BookEvent,              FALSE },
  { (APTR) MoveNowEvent,           FALSE },
  { (APTR) ShowThinkingProc,       FALSE },
#endif
  { NULL,                   FALSE }
};
void SetICSMode(void)

{ SetMenuSensitivity(icsSensitivity);
}


Sensitivity ncpSensitivity[] =
{ { (APTR) MailMoveEvent,          FALSE },
  { (APTR) ReloadCmailMsgProc,     FALSE },
  { (APTR) MachineBlackEvent,      FALSE },
  { (APTR) MachineWhiteEvent,      FALSE },
  { (APTR) TwoMachinesEvent,       FALSE },
  { (APTR) IcsClientEvent,         FALSE },

  /**
  ***  The original xboard has an

  { (APTR) ActionProc,             FALSE },

  ***  here. As this would require to separate between menuitems
  ***  ans menustrips in SetMenuSensitivity(), we better disable
  ***  any menuitem instead of the menustrip below.
  **/
  { (APTR) AcceptEvent,            FALSE },
  { (APTR) DeclineEvent,           FALSE },
  { (APTR) CallFlagEvent,          FALSE },
  { (APTR) DrawEvent,              FALSE },
  { (APTR) AdjournEvent,           FALSE },
  { (APTR) AbortEvent,             FALSE },
  { (APTR) ResignEvent,            FALSE },
  { (APTR) StopObservingEvent,     FALSE },
  { (APTR) StopExaminingEvent,     FALSE },


  { (APTR) RevertEvent,            FALSE },
  { (APTR) MoveNowEvent,           FALSE },
  { (APTR) RetractMoveEvent,       FALSE },
  { (APTR) AutoflagProc,           FALSE },
  { (APTR) AutoobsProc,            FALSE },
  { (APTR) BellProc,               FALSE },
  { (APTR) QuietPlayProc,          FALSE },
  { (APTR) ShowThinkingProc,       FALSE },
  { (APTR) HintEvent,              FALSE },
  { (APTR) BookEvent,              FALSE },
  { NULL,                   FALSE }
};
void SetNCPMode(void)

{ SetMenuSensitivity(ncpSensitivity);
}


Sensitivity gnuSensitivity[] =
{ { (APTR) IcsClientEvent,         FALSE },
  { (APTR) AcceptEvent,            FALSE },
  { (APTR) DeclineEvent,           FALSE },
  { (APTR) DrawEvent,              FALSE },
  { (APTR) AdjournEvent,           FALSE },
  { (APTR) StopExaminingEvent,     FALSE },
  { (APTR) StopObservingEvent,     FALSE },
  { (APTR) RevertEvent,            FALSE },
  { (APTR) AutoflagProc,           FALSE },
  { (APTR) AutoobsProc,            FALSE },
  { (APTR) QuietPlayProc,          FALSE },
  { (APTR) MailMoveEvent,          FALSE },
  { (APTR) ReloadCmailMsgProc,     FALSE },
  { NULL,                   FALSE }
};
void SetGNUMode(void)

{ SetMenuSensitivity(gnuSensitivity);
}


Sensitivity cmailSensitivity[] =
{ /**
  ***  The original xboard has an

  { (APTR) ActionProc,             TRUE },

  ***  here. As this would require to separate between menuitems
  ***  ans menustrips in SetMenuSensitivity(), we better disable
  ***  any menuitem instead of the menustrip below.
  **/
  { (APTR) AcceptEvent,            TRUE },
  { (APTR) DeclineEvent,           TRUE },
  { (APTR) CallFlagEvent,          FALSE },
  { (APTR) DrawEvent,              FALSE },
  { (APTR) AdjournEvent,           FALSE },
  { (APTR) AbortEvent,             FALSE },
  { (APTR) ResignEvent,            TRUE },
  { (APTR) StopObservingEvent,     FALSE },
  { (APTR) StopExaminingEvent,     FALSE },

  { (APTR) MailMoveEvent,          FALSE },
  { (APTR) ReloadCmailMsgProc,     FALSE },
  { NULL,                   FALSE }
};
void SetCmailMode(void)

{ SetMenuSensitivity(cmailSensitivity);
}
/**/


/***  DrawPosition() function
***
***  takes advantage of the MUI chessboard gadget.
**/
void DrawPosition(int fullRedraw, Board board)

{ static int oldFlipView = -1;

  if (flipView != oldFlipView)
  { set(xboardChessboard, MUIA_XBoard_FlipView, flipView);
    oldFlipView = flipView;
    fullRedraw = TRUE;
    set(ProcToMenuitem((APTR) FlipViewProc), MUIA_Menuitem_Checked, flipView);
  }

  DoMethod(xboardChessboard, MUIM_XBoard_DrawPosition, fullRedraw, board);
}
/**/


/***  ModeToObject() function
***
***  Converts gamemodes into functions that initialize them
**/
APTR *ModeToObject(GameMode mode)

{ APTR proc;

  switch(mode)
  { case BeginningOfGame:
      if (appData.icsActive)
      { proc = (APTR) IcsClientEvent;
      }
      else if (appData.noChessProgram  ||
	       *appData.cmailGameName != NULLCHAR)
      { proc = (APTR) EditGameEvent;
      }
      else
      { proc = (APTR) MachineBlackEvent;
      }
      break;
    case MachinePlaysBlack:
      proc = (APTR) MachineBlackEvent;
      break;
    case MachinePlaysWhite:
      proc = (APTR) MachineWhiteEvent;
      break;
    case TwoMachinesPlay:
      proc = (APTR) TwoMachinesEvent;
      break;
    case EditGame:
      proc = (APTR) EditGameEvent;
      break;
    case PlayFromGameFile:
      proc = (APTR) LoadGameProc;
      break;
    case EditPosition:
      proc = (APTR) EditPositionEvent;
      break;
    case IcsPlayingWhite:
    case IcsPlayingBlack:
    case IcsObserving:
    case IcsIdle:
    case IcsExamining:
      proc = (APTR) IcsClientEvent;
      break;
    default:
      return(NULL);
  }

  return(ProcToMenuitem(proc));
}
/**/


/***  ModeHighlight() function
***
**/
void ModeHighlight(void)

{ static int oldPausing = FALSE;
  static int oldEditPositionMode = -1;
  int editPositionMode;
  static GameMode oldmode = (GameMode) -1;
  APTR menuitemObject;

  if (pausing != oldPausing)
  { menuitemObject = ProcToMenuitem((APTR) PauseEvent);
    oldPausing = pausing;
    if (menuitemObject)
    { if (pausing)
      { set(menuitemObject, MUIA_Menuitem_Checked, TRUE);
      }
      else
      { set(menuitemObject, MUIA_Menuitem_Checkit, FALSE);
      }
    }
  }

  if (oldmode != gameMode  &&  (menuitemObject = ModeToObject(oldmode)))
  { set(menuitemObject, MUIA_Menuitem_Checked, FALSE);
  }
  if ((menuitemObject = ModeToObject(gameMode)))
  { set(menuitemObject, MUIA_Menuitem_Checked, TRUE);
  }
  oldmode = gameMode;

  editPositionMode = (gameMode == EditPosition)  ||
		     (gameMode == IcsExamining);
  if (editPositionMode != oldEditPositionMode)
  { set(xboardChessboard, MUIA_XBoard_EditPosition, editPositionMode);
    oldEditPositionMode = editPositionMode;
  }
}
/**/


/***  FileNameAction() function
***
***  Brings up a file requester.
**/
int LoadGamePopUp(FILE *, int, char *);

typedef int (*FileProc)(FILE*, int, char*);

void FileNameAction(FileProc proc, char *openMode, char *filename)

{
    FILE *fp;
    int index;
    char *p;

    if ((p = strchr(filename, ','))) {
	*p++ = NULLCHAR;
	index = atoi(p);
    } else {
	index = 0;
    }

    if (!(fp = fopen(filename, openMode))) {
	DisplayError("Failed to open file", errno);
    } else {
	(void) (*proc)(fp, index, filename);
    }
    ModeHighlight();
}
/**/


/***  FileNamePopUp() function
***
***  Creates an ASL requester.
**/
void FileNamePopUp(char *title, char *deflt, char *pattern,
		   FileProc proc, char *openMode)

{ struct FileRequester *requester;
  struct Window *window;
  UBYTE parsedPattern[20];
  char filename[MSG_SIZ];

  if (!(requester = (struct FileRequester *) MUI_AllocAslRequest(ASL_FileRequest, NULL)))
  { return;
  }
  ParsePatternNoCase((UBYTE *) pattern, parsedPattern, sizeof(parsedPattern));
  strcpy(filename, deflt);
  *PathPart((STRPTR) filename) = NULLCHAR;

  get(xboardWindow, MUIA_Window_Window, &window);

  if (MUI_AslRequestTags(requester,
			 ASLFR_Window, window,
			 ASLFR_PrivateIDCMP, TRUE,
			 ASLFR_SleepWindow, TRUE,
			 ASLFR_TitleText, title,
			 ASLFR_InitialFile, FilePart((STRPTR) deflt),
			 ASLFR_InitialDrawer, filename,
			 ASLFR_InitialPattern, pattern,
			 ASLFR_DoSaveMode, strcmp(openMode, "w") == 0,
			 ASLFR_RejectIcons, TRUE,
			 ASLFR_AcceptPattern, parsedPattern,
			 TAG_DONE))
  { if (*requester->fr_File != NULLCHAR)
    { strcpy(filename, (char *) requester->fr_Drawer);
      AddPart((STRPTR) filename, requester->fr_File, sizeof(filename));
      FileNameAction(proc, openMode, filename);
    }
  }

  MUI_FreeAslRequest(requester);
}
/**/


/***  Button/menu procedures
**/
void ResetProc(void)

{ ResetGameEvent();
}

int LoadGamePopUp(FILE *f, int gameNumber, char *title)

{
    cmailMsgLoaded = FALSE;
    if (gameNumber == 0) {
	int error = GameListBuild(f);

	if (error) {
	    DisplayError("Cannot build game list", error);
	} else if (!ListEmpty(&gameList) &&
		   ((ListGame *) gameList.tailPred)->number > 1) {
	    GameListPopUp(f, title);
	    return TRUE;
	}
	GameListDestroy();
	gameNumber = 1;
    }
    return(LoadGame(f, gameNumber, title, FALSE));
}

void LoadGameProc(void)

{
    FileNamePopUp("Load game file name?", "",
		  appData.oldSaveStyle ? "#?.game" : "#?.pgn",
		  LoadGamePopUp, "r");
}

void LoadNextGameProc(void)

{ ReloadGame(1);
}

void LoadPrevGameProc(void)

{ ReloadGame(-1);
}

void ReloadGameProc(void)

{ ReloadGame(0);
}


void LoadPositionProc(void)

{ FileNamePopUp("Load position file name?", "",
		appData.oldSaveStyle ? "#?.pos" : "#?.fen",
		LoadPosition, "r");
}

void SaveGameProc(void)

{ FileNamePopUp("Save game file name?",
		DefaultFileName(appData.oldSaveStyle ? ".game" : ".pgn"),
		appData.oldSaveStyle ? "#?.game" : "#?.pgn",
		SaveGame, "a");
}

void AutoSaveGame(void)

{ SaveGameProc();
}

void SavePositionProc(void)

{ FileNamePopUp("Save position file name",
		DefaultFileName(appData.oldSaveStyle ? ".pos" : ".fen"),
		appData.oldSaveStyle ? "#?.pos" : "#?.fen",
		SavePosition, "a");
}

void ReloadCmailMsgProc(void)

{ ReloadCmailMsgEvent(FALSE);
}

void QuitProc(void)

{ ExitEvent(0);
}

void EditCommentProc(void)

{
    if (editCommentWindow) {
	EditCommentPopDown();
    } else {
	EditCommentEvent();
    }
}


void AlwaysQueenProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) AlwaysQueenProc)))
  { get(obj, MUIA_Menuitem_Checked, &appData.alwaysPromoteToQueen);
    set(xboardChessboard, MUIA_XBoard_AlwaysPromoteToQueen,
	appData.alwaysPromoteToQueen);
  }
}

void AutoflagProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) AutoflagProc)))
  { get(obj, MUIA_Menuitem_Checked, &appData.autoCallFlag);
  }
}

void AutoFlipViewProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) AutoFlipViewProc)))
  { get(obj, MUIA_Menuitem_Checked, &appData.autoFlipView);
  }
}

void AutoobsProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) AutoobsProc)))
  { get(obj, MUIA_Menuitem_Checked, &appData.autoObserve);
  }
}

void AutocommProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) AutocommProc)))
  { get(obj, MUIA_Menuitem_Checked, &appData.autoComment);
  }
}

void AutosaveProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) AutosaveProc)))
  { get(obj, MUIA_Menuitem_Checked, &appData.autoSaveGames);
  }
}

void BellProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) BellProc)))
  { get(obj, MUIA_Menuitem_Checked, &appData.ringBellAfterMoves);
  }
}

void FlipViewProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) FlipViewProc)))
  { get(obj, MUIA_Menuitem_Checked, &flipView);
    DrawPosition(TRUE, NULL);
  }
}

void OldSaveStyleProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) OldSaveStyleProc)))
  { get(obj, MUIA_Menuitem_Checked, &appData.oldSaveStyle);
  }
}

void QuietPlayProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) QuietPlayProc)))
  { get(obj, MUIA_Menuitem_Checked, appData.quietPlay);
  }
}

void ShowCoordsProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) ShowCoordsProc)))
  { get(obj, MUIA_Menuitem_Checked, &appData.showCoords);
    set(xboardChessboard, MUIA_XBoard_ShowCoords, appData.showCoords);
  }
}

void ShowThinkingProc(void)

{ APTR obj;

  if ((obj = ProcToMenuitem((APTR) ShowThinkingProc)))
  { ULONG show;

    get(obj, MUIA_Menuitem_Checked, &show);
    ShowThinkingEvent(show);
  }
}


void ErrorPopUp(char *, char *);
void AboutProc(void)

{ char buf[MSG_SIZ*2];

  sprintf(buf, "%s\n\n%s\n%s\n%s\n\n%s\n%s",
	  programName,
	  "Copyright 1991 Digital Equipment Corporation",
	  "Enhancements Copyright 1992-94 Free Software Foundation",
	  "Amiga version copyright 1995 Jochen Wiedmann",
	  "This program is free software and carries NO WARRANTY;",
	  "see the file COPYING for more information.");
  ErrorPopUp("About AmyBoard", buf);
}
/**/




     
/***  Display functions
***
***  Error messages and similar
**/
void ErrorPopUp(char *title, char *label)

{ MUI_RequestA(xboardApp, xboardWindow, 0, title, "Ok", label, NULL);
}

void DisplayMessage(char *message, char *extMessage)

{ set(xboardText, MUIA_Text_Contents, message);
  set(xboardExtText, MUIA_Floattext_Text, extMessage);
}

void DisplayTitle(char *text)

{ char title[MSG_SIZ];
  char *icon;

  if (text == NULL)
  { text = "";
  }

  /*
  if (appData.titleInWindow)
  {
  }
  */
  if (*text != NULLCHAR)
  { sprintf(title, "%s: %s", programName, text);
  }
  else if (appData.icsActive)
  { sprintf(title, "%s: %s", programName, appData.icsHost);
  }
  else if (*appData.cmailGameName != NULLCHAR)
  { sprintf(title, "%s: CMail", programName);
  }
  else if (appData.noChessProgram)
  { sprintf(title, "%s", programName);
  }
  else
  { if (StrStr(appData.firstChessProgram, "gnuchess"))
    { sprintf(title, "%s: GNU Chess", programName);
    }
    else
    { sprintf(title, "%s: %s", programName,
	      FilePart((STRPTR) appData.firstChessProgram));
    }
  }

  get(xboardWindow, MUIA_Window_Title, &icon);
  if (strcmp(title, icon) != 0)
  { if ((icon = strdup(title)))
    { set(xboardWindow, MUIA_Window_Title, icon);
    }
  }
}

void DisplayError(char *message, int error)

{ char buf[MSG_SIZ];

  if (error == 0)
  { if (appData.debugMode || appData.matchMode)
    { fprintf(stderr, "%s: %s\n", programName, message);
    }
    ErrorPopUp("Error", message);
  }
  else
  { if (appData.debugMode  ||  appData.matchMode)
    { fprintf(stderr, "%s: %s: %s\n",
	      programName, message, strerror(error));
    }
    sprintf(buf, "%s: %s", message, strerror(error));
    ErrorPopUp("Error", buf);
  }
}

void DisplayFatalError(char *message, int error, int status)

{ char buf[MSG_SIZ];

  if (error == 0)
  { fprintf(stderr, "%s: %s\n", programName, message);
    ErrorPopUp("Fatal Error", message);
  }
  else
  { fprintf(stderr, "%s: %s: %s\n",
	    programName, message, strerror(error));
    sprintf(buf, "%s: %s", message, strerror(error));
    ErrorPopUp("Fatal Error", buf);
  }
  ExitEvent(status);
}

void DisplayInformation(char *message)

{ ErrorPopUp("Information", message);
}

void RingBell(void)

{ struct Screen *scrn;

  get(xboardWindow, MUIA_Window_Screen, &scrn);
  DisplayBeep(scrn);
}

void EchoOn(void)

{ /* not implemented */
}

void EchoOff(void)

{ /* not implemented */
}

void Raw(void)

{ /* not implemented */
}
/**/


/***  UserName() function
**/
char *UserName(void)

{ char *ptr;

  if ((ptr = getenv("USERNAME")))
  { return(ptr);
  }
  return("Unknown user");
}
/**/


/***  HostName() function
***/
char *HostName(void)

{ char *ptr;

  if ((ptr = getenv("HOSTNAME")))
  { return(ptr);
  }
  return("Unknown host");
}
/**/


/***  CreateMUIApp() function
***
***  Creates the GUI.
**/
typedef void (*menuEventFunc) (void);
_HOOK_FUNC(VOID, menuCallback, struct Hook *hook,
			       Object *obj,
			       menuEventFunc *func)
{ if (func)
  { (*func)();
  }
}

struct Hook menuCallbackHook =
{ { NULL, NULL },
  (HOOKFUNC) menuCallback,
  NULL,
  NULL
};


void CreateMUIApp(void)

{ int squareSize = 0;
  APTR lowerButton, llowerButton, higherButton, hhigherButton, pauseButton;

  if (StrCaseCmp((STRPTR) appData.boardSize, (STRPTR) "small") == 0)
  { squareSize = 40;
  }
  else if (StrCaseCmp((STRPTR) appData.boardSize, (STRPTR) "medium") == 0)
  { squareSize = 64;
  }
  else if (StrCaseCmp((STRPTR) appData.boardSize, (STRPTR) "large") == 0)
  { squareSize = 80;
  }

  xboardApp = ApplicationObject,
	    MUIA_Application_Title,       "AmyBoard",
	    MUIA_Application_Version,     VERSTAG,
	    MUIA_Application_Copyright,   "© 1995, Jochen Wiedmann",
	    MUIA_Application_Author,      "Jochen Wiedmann",
	    MUIA_Application_Description, "The GNU chess interface for the Amiga",
	    MUIA_Application_Base,        "AmyBoard",
	    SubWindow, xboardWindow = WindowObject,
		MUIA_Window_Title,  programName,
		MUIA_Window_ID,     MAKE_ID('M','A','I','N'),
		MUIA_Window_Menustrip, xboardMenu = MUI_MakeObject(MUIO_MenustripNM, xboardNewMenu, 0),
		WindowContents, HGroup,
		    Child, xboardChessboard = XBoardObject(
			MUIA_Frame, MUIV_Frame_InputList,
			MUIA_Weight, 400,
			MUIA_XBoard_SquareWidth, squareSize,
			MUIA_XBoard_SquareHeight, squareSize,
			MUIA_XBoard_FlipView, appData.flipView,
			MUIA_XBoard_ShowCoords, appData.showCoords,
			MUIA_XBoard_LightSquarePen, appData.lightSquareColor,
			MUIA_XBoard_DarkSquarePen, appData.darkSquareColor,
			MUIA_XBoard_WhitePiecePen, appData.whitePieceColor,
			MUIA_XBoard_BlackPiecePen, appData.blackPieceColor,
			MUIA_XBoard_BitmapDirectory, appData.bitmapDirectory,
		    End,
		    Child, VGroup,
			MUIA_Weight, 100,
			Child, HGroup,
			    Child, llowerButton = SimpleButton("<<"),
			    Child, lowerButton = KeyButton("<", "<"),
			    Child, pauseButton = KeyButton("P", "p"),
			    Child, higherButton = KeyButton(">", ">"),
			    Child, hhigherButton = SimpleButton(">>"),
			End,
			Child, xboardUpperTime = TextObject,
			    TextFrame,
			End,
			Child, HGroup,
			    Child, HSpace(0),
			    Child, TextObject,
				MUIA_Text_Contents, ":",
			    End,
			    Child, HSpace(0),
			End,
			Child, xboardLowerTime = TextObject,
			    TextFrame,
			End,
			Child, xboardText = TextObject,
			    TextFrame,
			End,
			Child, xboardExtText = FloattextObject,
			    TextFrame,
			End,
			Child, VSpace(0),
		    End,
		End,
	    End,
	End;

  if (!xboardApp)
  { DisplayFatalError("Can't create application.", 0, 10);
  }

  set(ProcToMenuitem((APTR) AlwaysQueenProc), MUIA_Menuitem_Checked,
      appData.alwaysPromoteToQueen);
  set(ProcToMenuitem((APTR) AutoflagProc), MUIA_Menuitem_Checked,
      appData.autoCallFlag);
  set(ProcToMenuitem((APTR) AutoFlipViewProc), MUIA_Menuitem_Checked,
      appData.autoFlipView);
  set(ProcToMenuitem((APTR) AutoobsProc), MUIA_Menuitem_Checked,
      appData.autoObserve);
  set(ProcToMenuitem((APTR) AutocommProc), MUIA_Menuitem_Checked,
      appData.autoComment);
  set(ProcToMenuitem((APTR) AutosaveProc), MUIA_Menuitem_Checked,
      appData.autoSaveGames);
  set(ProcToMenuitem((APTR) BellProc), MUIA_Menuitem_Checked,
      appData.ringBellAfterMoves);
  set(ProcToMenuitem((APTR) OldSaveStyleProc), MUIA_Menuitem_Checked,
      appData.oldSaveStyle);
  set(ProcToMenuitem((APTR) QuietPlayProc), MUIA_Menuitem_Checked,
      appData.quietPlay);
  set(ProcToMenuitem((APTR) ShowCoordsProc), MUIA_Menuitem_Checked,
      appData.showCoords);
  set(ProcToMenuitem((APTR) ShowThinkingProc), MUIA_Menuitem_Checked,
      appData.showThinking);

  { ULONG open;

    set(xboardWindow, MUIA_Window_Open, TRUE);

    get(xboardWindow, MUIA_Window_Open, &open);
    if (!open)
    { DisplayFatalError("Can't open window.", 0, 10);
    }
  }

  DoMethod(xboardWindow, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
	   xboardApp, 2, MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);
  DoMethod(xboardWindow, MUIM_Notify, MUIA_Window_MenuAction, MUIV_EveryTime,
	   xboardApp, 3, MUIM_CallHook, &menuCallbackHook, MUIV_TriggerValue);
  DoMethod(llowerButton, MUIM_Notify, MUIA_Pressed, FALSE,
	   xboardApp, 3, MUIM_CallHook, &menuCallbackHook, ToStartEvent);
  DoMethod(lowerButton, MUIM_Notify, MUIA_Pressed, FALSE,
	   xboardApp, 3, MUIM_CallHook, &menuCallbackHook, BackwardEvent);
  DoMethod(pauseButton, MUIM_Notify, MUIA_Pressed, FALSE,
	   xboardApp, 3, MUIM_CallHook, &menuCallbackHook, PauseEvent);
  DoMethod(higherButton, MUIM_Notify, MUIA_Pressed, FALSE,
	   xboardApp, 3, MUIM_CallHook, &menuCallbackHook, ForwardEvent);
  DoMethod(hhigherButton, MUIM_Notify, MUIA_Pressed, FALSE,
	   xboardApp, 3, MUIM_CallHook, &menuCallbackHook, ToEndEvent);
  DoMethod(xboardLowerTime, MUIM_Notify, MUIA_Pressed, FALSE,
	   xboardApp, 3, MUIM_CallHook, &CallFlagEvent);
  DoMethod(xboardUpperTime, MUIM_Notify, MUIA_Pressed, FALSE,
	   xboardApp, 3, MUIM_CallHook, &CallFlagEvent);
}
/**/


/***  Timer display functions
**/
void DisplayTimerLabel(Boolean white, LONG timer, int highlight)

{ APTR obj;
  char buf[MSG_SIZ];
  char *ptr;

  if ((white && !flipView)  ||
      (!white  &&  flipView))
  { obj = xboardLowerTime;
  }
  else
  { obj = xboardUpperTime;
  }

  ptr = buf;
  if (highlight)
  { *ptr++ = '\033';
    *ptr++ = 'b';
  }

  if (appData.clockMode)
  { sprintf(ptr, "%s", TimeString(timer));
  }
  else
  { *ptr++ = '-';
    *ptr++ = NULLCHAR;
  }
  set(obj, MUIA_Text_Contents, buf);
}

void DisplayWhiteClock(LONG timeRemaining, int highlight)

{ DisplayTimerLabel(TRUE, timeRemaining, highlight);
}

void DisplayBlackClock(LONG timeRemaining, int highlight)

{ DisplayTimerLabel(FALSE, timeRemaining, highlight);
}
/**/


/***  Comment section
***
***  Functions to display and edit a comment.
***
***  We open a separate MUI window for comments and add it to the
***  application object. Pressing a button within the window or
***  closing it will result in calling a hook. (CommentCallback or
***  EditCommentCallback, respectively.)
***
**/
APTR CommentCreate(STRPTR name, STRPTR text,
		   ULONG mutable, struct Hook *hook, ULONG index)

{ APTR commentWindow;
  /* Suppress warnings on uninitialized variables. */
  APTR okButton = NULL, cancelButton = NULL, editButton = NULL,
       clearButton = NULL, textObject = NULL;
  STRPTR title;

  if (!(title = (STRPTR) strdup((char *) name)))
  { return(NULL);
  }

  if (mutable)
  { commentWindow = WindowObject,
	    MUIA_Window_ID, MAKE_ID('C','M','N','T'),
	    MUIA_Window_Title, title,
	    WindowContents, VGroup,
		Child, textObject = String(text, 4096),
		Child, HGroup,
		    Child, okButton = KeyButton("ok", "o"),
		    Child, clearButton = KeyButton("clear", "c"),
		    Child, cancelButton = KeyButton("abort", "a"),
		End,
	    End,
	End;
  }
  else
  { commentWindow = WindowObject,
	    MUIA_Window_ID, MAKE_ID('C','M','N','T'),
	    MUIA_Window_Title, title,
	    WindowContents, VGroup,
		Child, textObject = TextObject,
		    MUIA_Text_Contents, text,
		    TextFrame,
		End,
		Child, HGroup,
		    Child, editButton = KeyButton("edit", "e"),
		    Child, cancelButton = KeyButton("close", "c"),
		End,
	    End,
	End;
  }


  if (commentWindow)
  { ULONG open;

    DoMethod(xboardApp, OM_ADDMEMBER, commentWindow);
    set(commentWindow, MUIA_Window_Open, TRUE);
    get(commentWindow, MUIA_Window_Open, &open);
    if (!open)
    { DoMethod(xboardApp, OM_REMMEMBER, commentWindow);
      MUI_DisposeObject(commentWindow);
      commentWindow = NULL;
    }
    else
    { DoMethod(commentWindow, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
	       commentWindow, 3, MUIM_CallHook, hook, (LONG) 0);
      if (mutable)
      { DoMethod(okButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 textObject, 4, MUIM_CallHook, hook, (LONG) 1, (ULONG) index);
	DoMethod(clearButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 textObject, 3, MUIM_CallHook, hook, (LONG) -1);
	DoMethod(cancelButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 textObject, 3, MUIM_CallHook, hook, (LONG) 0);
      }
      else
      { DoMethod(editButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 commentWindow, 3, MUIM_CallHook, hook, (LONG) 1);
	DoMethod(cancelButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 commentWindow, 3, MUIM_CallHook, hook, (LONG) 0);
      }
    }
  }

  return(commentWindow);
}

_HOOK_FUNC(VOID, CommentCallback, struct Hook *Hook,
				  APTR obj,
				  va_list args)

{ ULONG edit;

  edit = va_arg(args, ULONG);
  if (edit)
  { EditCommentProc();
  }
  CommentPopDown();
}
const struct Hook commentCallbackHook =
{ { NULL, NULL },
  (HOOKFUNC) CommentCallback,
  NULL,
  NULL
};

APTR commentWindow  = NULL;
void CommentPopUp(char *title, char *text)

{ CommentPopDown();
  commentWindow = CommentCreate((STRPTR) title, (STRPTR) text, FALSE,
				(struct Hook *) &commentCallbackHook, 0);
}

void CommentPopDown(void)

{ if (commentWindow)
  { CloseMuiWindow(commentWindow);
    commentWindow = NULL;
  }
}

_HOOK_FUNC(VOID, EditCommentCallback, struct Hook *hook,
				      APTR obj,
				      va_list args)

{ LONG done;

  done = va_arg(args, LONG);
  switch(done)
  { case 1:
      { STRPTR val;
	ULONG index;

	index = va_arg(args, ULONG);
	get(obj, MUIA_String_Contents, &val);
	ReplaceComment(index, (char *) val);
	EditCommentPopDown();
      }
      break;
    case -1:
      set(obj, MUIA_String_Contents, NULL);
      break;
    default:
      EditCommentPopDown();
      break;
  }
}
const struct Hook editCommentCallbackHook =
{ { NULL, NULL },
  (HOOKFUNC) EditCommentCallback,
  NULL,
  NULL
};

void EditCommentPopUp(int index, char *title, char *text)

{ EditCommentPopDown();
  editCommentWindow = CommentCreate((STRPTR) title, (STRPTR) text, TRUE,
				    (struct Hook *) &editCommentCallbackHook,
				    index);
}

void EditCommentPopDown(void)

{ if (editCommentWindow)
  { CloseMuiWindow(editCommentWindow);
    editCommentWindow = NULL;
  }
}
/**/


/*** CmailSigHandlerCallBack() function
**/
void CmailSigHandlerCallBack(InputSourceRef isr, char *message, int count, int error)

{ ReloadCmailMsgEvent(TRUE);
}
/**/

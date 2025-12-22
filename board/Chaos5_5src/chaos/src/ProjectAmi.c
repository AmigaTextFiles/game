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


    $RCSfile: ProjectAmi.c,v $
    $Revision: 3.4 $
    $Date: 1994/11/19 19:32:01 $

    This file contains the system dependent functions that support the
    Project menu.

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
#include <libraries/asl.h>
#include <libraries/gadtools.h>
#include <libraries/dos.h>
#include <proto/asl.h>
#include <proto/icon.h>
#endif  /*  AMIGA   */




/*
    FileRequest() creates a file requester which reads a file name.

    Inputs: defaultfile a pointer to a string containing the default name
	    title       a pointer to a string containing the requester's
			title. This may be NULL, in which case
			MSG_CDAT_SELECTION is assumed.
	    ending      a pointer to a string containing the default ending.
			This may be NULL, in which case "#?.cdat" is assumed.
			Note, that this MUST be something like "#?.xxx" on
			the Amiga!
	    savemode    TRUE, if non-existing files may be selected.

    Result: Full path name of the file, that was selected or NULL, if the
	    user cancelled.
*/
char *FileRequest(char *defaultfile, char *title, char *ending, int savemode)

#ifdef AMIGA
{ struct FileRequester *requester;
  char pattern[20];
  char *result = NULL;
  char *filename, *pathname, *endptr;
  BPTR dir;
  static char FileRequestName[TRNFILENAME_LEN+1];
  static char PathName[TRNFILENAME_LEN+1];
  struct Window *window;


  /*
      Bring up default settings, if needed.
  */
  if (title == NULL)
  { title = (char *) MSG_CDAT_SELECTION;
  }
  if (ending == NULL)
  { ending = "#?.cdat";
  }


  /*
      Get Intuition window pointer from MUI window, allocate Filerequester
      and parse the ending for wildcards.
  */
  get(MainWnd, MUIA_Window_Window, &window);
  if ((requester = (struct FileRequester *)
		   MUI_AllocAslRequest(ASL_FileRequest, NULL))  ==  NULL)
  { MemError();
    return(NULL);
  }
  ParsePatternNoCase((UBYTE *) ending, (UBYTE *) pattern, sizeof(pattern));


  /*
      Get default file- and drawername.
  */
  if (defaultfile  &&  *defaultfile != '\0')
  { strcpy(FileRequestName, defaultfile);
  }
  else
  { if (TrnFileName != '\0')
    { strcpy(FileRequestName, TrnFileName);
    }
    else
    { sprintf(FileRequestName, savemode ? "chaos.%d.cdat" : "", NumRounds);
    }
  }
  filename = (char *) FilePart((STRPTR) FileRequestName);
  strcpy(PathName, FileRequestName);
  *(pathname = (char *) PathPart((STRPTR) PathName)) = '\0';


  /*
      Make the drawername absolute.
  */
  dir = Lock((STRPTR) PathName, SHARED_LOCK);
  NameFromLock(dir, (STRPTR) PathName, sizeof(PathName));
  UnLock(dir);

  /*
     Ensure, that the default filename has the right ending.
  */
  if (ending != NULL  &&  (endptr = strrchr(filename, '.')) != NULL)
  { strcpy(endptr, ending+2);
  }


  /*
      Bring up the requester
  */
#ifdef V39_INCLUDES
  if (MUI_AslRequestTags(requester,
			 ASLFR_Window, window,
			 ASLFR_PrivateIDCMP, TRUE,
			 ASLFR_SleepWindow, TRUE,
			 ASLFR_TitleText, title,
			 ASLFR_InitialFile, filename,
			 ASLFR_InitialDrawer, PathName,
			 ASLFR_InitialPattern, ending,
			 ASLFR_DoSaveMode, savemode,
			 ASLFR_RejectIcons, TRUE,
			 ASLFR_AcceptPattern, pattern,
			 TAG_DONE)  !=  FALSE   &&
      requester->fr_File != NULL  &&  requester->fr_File != '\0')
  { strcpy(FileRequestName, (char *) requester->fr_Drawer);
    AddPart((STRPTR) FileRequestName, requester->fr_File,
	    sizeof(FileRequestName));
    result = FileRequestName;
  }
#else
  if (MUI_AslRequestTags(requester,
			 ASL_Window, window,
			 ASL_Hail, title
			 ASL_File, filename,
			 ASL_Dir, PathName,
			 TAG_DONE)  ==  FALSE   &&
      requester->rf_File != NULL  &&  requester->rf_File != '\0')
  { strcpy(FileRequestName, (char *) requester->rf_Dir);
    AddPart((STRPTR) FileRequestName, (STRPTR) requester->rf_File,
	    sizeof(FileRequestName));
    result = FileRequestName;
  }
#endif
  MUI_FreeAslRequest((APTR) requester);
  return (result);
}
#endif  /*  AMIGA   */




/*
    CreateIcon() puts an icon to a recently saved file.

    Inputs: name of the file just created; must not be NULL
*/
void CreateIcon(char *name)

#ifdef AMIGA
{ extern int MakeIcons;

  /*
      Does the user want to have an icon?
  */
  if (MakeIcons)
  { /*
	Yes, get a diskobject
    */
    struct DiskObject *dobj;
    char *olddeftool;
    int len = strlen(IconName);

    /*
	Icon.library doesn't like a trailing ".info" when calling
	GetDiskObject().
    */
    if (len >= 5  &&
	Stricmp((STRPTR) IconName+len-5, (STRPTR) ".info") == 0)
    { IconName[len-5] = '\0';
    }

    if ((dobj = GetDiskObject((STRPTR) IconName))  !=  NULL  ||
	(dobj = GetDiskObject((STRPTR) "s:Chaos_Project"))  !=  NULL  ||
	(dobj = GetDefDiskObject(WBPROJECT))  !=  NULL)
    { /*
	  Put the right settings into the diskobject and save it.
      */
      dobj->do_Type = WBPROJECT;
      olddeftool = dobj->do_DefaultTool;
      dobj->do_DefaultTool = ProgName;
      dobj->do_CurrentX = dobj->do_CurrentY = NO_ICON_POSITION;
      if (dobj->do_StackSize < 20000)
      { dobj->do_StackSize = 20000;
      }
      PutDiskObject((STRPTR) name, dobj);
      dobj->do_DefaultTool = olddeftool;
      FreeDiskObject(dobj);
    }
  }
}
#else   /*  !AMIGA  */
{   /*
	There is nothing to be done on other systems.
    */
}
#endif  /*  !AMIGA  */




/*
    AskSave brings up a requester asking the user, if he wants to save
    first.
*/
int AskSave(void)

#ifdef AMIGA
{
  switch (MUI_RequestA(App, MainWnd, 0,
		       (char *) MSG_ATTENTION,
		       (char *) MSG_YES_NO_CANCEL,
		       (char *) MSG_CHANGES_MADE, NULL))
  { case 2:
      return(TRUE);
    case 1:
      return(SaveTournament(NULL));
  }
  return(FALSE);
}
#endif  /*  AMIGA   */




/*
    The TerminateTrnWnd() function closes the tournament input window.
*/
#ifdef AMIGA
static APTR TrnWnd = NULL; /*  Tournament window                   */
static APTR TrnOkGad;      /*  Ok gadget (tournament window)       */
static APTR TrnCancelGad;  /*  Cancel gadget (tournament window)   */
static APTR TrnNameGad;    /*  Tournament name gadget              */
static APTR WinnerPointsGad; /* Winner points gadget               */
static APTR DrawPointsGad;   /* Draw points gadget                 */

void TerminateTrnWnd(void)

{ if (TrnWnd)
  { set(TrnWnd, MUIA_Window_Open, FALSE);
    DoMethod(App, OM_REMMEMBER, TrnWnd);
    MUI_DisposeObject(TrnWnd);
    TrnWnd = NULL;
  }
}
#endif  /*  AMIGA   */




/*
    The InitTrnWnd() function brings up a window, that allows to input
    tournament data.

    Inputs: name    pointer to a buffer, that can hold the tournament name
	    winnerpoints    current number of points for winning a game
	    drawpoints      current number of points for a draw

    Results: TRUE, if successfull, FALSE otherwise
*/
#ifdef AMIGA
#define ID_TrnWnd_Cancel    201
#define ID_TrnWnd_Ok        202
int InitTrnWnd(char *buffer, int winnerpoints, int drawpoints)

{ ULONG open;
  int OK_SC = *MSG_OK_SC;
  int Cancel_SC = *MSG_CANCEL_SC;

  /*
      Open the window and check for success.
  */
  TrnWnd = WindowObject,
	    MUIA_Window_ID, MAKE_ID('T','R','N','I'),
	    MUIA_Window_Title, MSG_TOURNAMENT_INPUT_TITLE,
	    MUIA_Window_Width, MUIV_Window_Width_MinMax(40),
	    WindowContents, VGroup,
		Child, HGroup,
		    Child, Label2(MSG_TOURNAMENT_NAME_OUTPUT),
		    Child, TrnNameGad = StringObject,
			StringFrame,
			MUIA_String_MaxLen, TRNNAME_LEN+1,
			MUIA_String_Contents, buffer,
		    End,
		End,
		Child, VSpace(0),
		Child, HGroup,
		    Child, VGroup,
			Child, Label2(MSG_WINNERPOINTS),
			Child, Label2(MSG_DRAWPOINTS),
		    End,
		    Child, VGroup,
			Child, WinnerPointsGad = StringObject,
			    StringFrame,
			    MUIA_String_MaxLen, 3,
			    MUIA_String_Accept, "0123456789 ",
			    MUIA_String_Integer, winnerpoints,
			End,
			Child, DrawPointsGad = StringObject,
			    StringFrame,
			    MUIA_String_MaxLen, 3,
			    MUIA_String_Accept, "0123456789 ",
			    MUIA_String_Integer, drawpoints,
			End,
		    End,
		    Child, HSpace(0),
		End,
		Child, VSpace(0),
		Child, HGroup,
		    MUIA_Group_SameSize, TRUE,
		    Child, TrnOkGad = KeyButton(MSG_OK, OK_SC),
		    Child, HSpace(0),
		    Child, TrnCancelGad = KeyButton(MSG_CANCEL_INPUT, Cancel_SC),
		End,
	    End,
	End;
  if (!TrnWnd)
  { return(FALSE);
  }
  DoMethod(App, OM_ADDMEMBER, TrnWnd);
  DoMethod(TrnWnd, MUIM_Window_SetCycleChain, TrnNameGad, TrnOkGad,
	   TrnCancelGad, NULL);
  set(TrnWnd, MUIA_Window_ActiveObject, TrnNameGad);


  /*
      Setting up the notification events for the tournament input window:
      CloseWindow, Ok- and Cancel Gadget
  */
  DoMethod(TrnWnd, MUIM_Notify, MUIA_Window_CloseRequest, TRUE, App, 2,
	   MUIM_Application_ReturnID, ID_TrnWnd_Cancel);
  DoMethod(TrnWnd, MUIM_Notify, MUIA_Window_InputEvent, "ctrl return",
	   App, 2, MUIM_Application_ReturnID, ID_TrnWnd_Ok);
  DoMethod(TrnOkGad, MUIM_Notify, MUIA_Pressed, FALSE, App, 2,
	   MUIM_Application_ReturnID, ID_TrnWnd_Ok);
  DoMethod(TrnCancelGad, MUIM_Notify, MUIA_Pressed, FALSE, App, 2,
	   MUIM_Application_ReturnID, ID_TrnWnd_Cancel);
  DoMethod(TrnWnd, MUIM_Window_SetCycleChain,
	   TrnNameGad, WinnerPointsGad, DrawPointsGad, TrnOkGad, TrnCancelGad,
	   NULL);
  DoMethod(TrnNameGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   TrnWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, WinnerPointsGad);
  DoMethod(WinnerPointsGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   TrnWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, DrawPointsGad);
  DoMethod(DrawPointsGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   TrnWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, TrnNameGad);


  set(TrnWnd, MUIA_Window_Open, TRUE);
  get(TrnWnd, MUIA_Window_Open, &open);
  if (!open)
  { MUIError((char *) ERRMSG_CANNOT_OPEN_WINDOW);
    TerminateTrnWnd();
    return(FALSE);
  }
  set(TrnWnd, MUIA_Window_ActiveObject, TrnNameGad);

  set(MainWnd, MUIA_Window_Open, FALSE);
  return(TRUE);
}
#endif  /*  AMIGA   */




/*
    The ProcessTrnWnd() function waits for user actions concerning
    the tournament input window.

    Inputs: buffer  pointer to a string, that holds the users input.
		    (Not needed on the Amiga.)
	    winnerpoints    pointer to an int where to store the
			    number of points for winning a game
			    game
	    drawpoints      pointer to an int where to store the
			    number of points for a draw

    Results:    0   Indicates, that the user has cancelled.
		1   Indicates, that this has to be called again.
		-1  Terminating via Ok-Gadget, okay
*/
int ProcessTrnWnd(char *buffer, int *winnerpoints, int *drawpoints)

#ifdef AMIGA
{ ULONG Signal;
  char *name;

  /*
      Check for user actions
  */
  switch (DoMethod(App, MUIM_Application_Input, &Signal))
  { case MUIV_Application_ReturnID_Quit:
      if (TestSaved())
      { exit(0);
      }
      break;
    case ID_TrnWnd_Cancel:
      return(0);
    case ID_TrnWnd_Ok:
      /*
	  Get the final state of the tournament name gadget.
      */
      if (buffer)
      { get(TrnNameGad, MUIA_String_Contents, &name);
	strcpy (buffer, name);
	get(WinnerPointsGad, MUIA_String_Integer, winnerpoints);
	get(DrawPointsGad, MUIA_String_Integer, drawpoints);
      }
      return(-1);
  }
  if (Signal)
  { Wait(Signal);
  }
  return(1);
}
#endif

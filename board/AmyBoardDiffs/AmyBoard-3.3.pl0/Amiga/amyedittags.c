/***
 *
 * amyedittags.c -- Tags edit window, part of Amiga front end for XBoard
 * $Id: xedittags.c,v 1.1 1995/06/26 04:22:13 mann Exp $
 *
 * Copyright 1995 Free Software Foundation, Inc.
 *
 * The following terms apply to the enhanced version of XBoard distributed
 * by the Free Software Foundation:
 * ------------------------------------------------------------------------
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 * ------------------------------------------------------------------------
 *
 * See the file ChangeLog for a revision history.
 */
/**/

#include "AmyBoard.h"
#ifndef LIRARIES_IFFPARSE_H
#include <libraries/iffparse.h>
#endif



Object* tagsUp      = NULL;
Object* editTagsUp  = NULL;





/***  EditTagsPopUp() function
*/
_HOOK_FUNC(void, EditTagsCallback, struct Hook *hook,
				   Object *win,
				   va_list args)
{
    Object* eventStr;

    if ((eventStr = va_arg(args, Object*))) {
	char *ptr;
	int result, success = TRUE;
	GameInfo newGameInfo;
	Object *siteStr, *dateStr, *roundStr, *whiteStr, *blackStr;
	Object *resultCycle, *detailStr;

	siteStr = va_arg(args, Object *);
	dateStr = va_arg(args, Object *);
	roundStr = va_arg(args, Object *);
	whiteStr = va_arg(args, Object *);
	blackStr = va_arg(args, Object *);
	resultCycle = va_arg(args, Object *);
	detailStr = va_arg(args, Object *);

	GameListInitGameInfo(&newGameInfo);

	get(eventStr, MUIA_String_Contents, &ptr);
	if (*ptr && !(newGameInfo.event = StrSave(ptr))) success = FALSE;
	get(siteStr, MUIA_String_Contents, &ptr);
	if (*ptr && !(newGameInfo.site = StrSave(ptr))) success = FALSE;
	get(dateStr, MUIA_String_Contents, &ptr);
	if (*ptr && !(newGameInfo.date = StrSave(ptr))) success = FALSE;
	get(roundStr, MUIA_String_Contents, &ptr);
	if (*ptr && !(newGameInfo.round = StrSave(ptr))) success = FALSE;
	get(whiteStr, MUIA_String_Contents, &ptr);
	if (*ptr && !(newGameInfo.white = StrSave(ptr))) success = FALSE;
	get(blackStr, MUIA_String_Contents, &ptr);
	if (*ptr && !(newGameInfo.black = StrSave(ptr))) success = FALSE;
	get(detailStr, MUIA_String_Contents, &ptr);
	if (*ptr && !(newGameInfo.resultDetails = StrSave(ptr))) success = FALSE;
	get(resultCycle, MUIA_Cycle_Active, &result);
	switch(result) {
	    case 0:
		newGameInfo.result = WhiteWins;
		break;
	    case 1:
		newGameInfo.result = GameIsDrawn;
		break;
	    case 2:
		newGameInfo.result = BlackWins;
		break;
	    default:
		newGameInfo.result = GameUnfinished;
		break;
	}

	if (success) {
	    ClearGameInfo(&gameInfo);
	  gameInfo = newGameInfo;
	} else {
	    DisplayError("Cannot init game info: ", ENOMEM);
	}
    }

    TagsPopDown();
}
struct Hook editTagsCallbackHook =
{ { NULL, NULL },
  (HOOKFUNC) EditTagsCallback,
  NULL,
  NULL
};


void EditTagsPopUp(char* tags)

{ static char *resultStrings[] =
  { "White wins", "Drawn", "Black wins", "Unfinished", NULL
  };
  int result;
  Object *okButton, *cancelButton;
  Object *eventStr, *siteStr, *dateStr, *roundStr, *whiteStr, *blackStr;
  Object *resultCycle, *detailStr;
  GameInfo gameInfo;

  TagsPopDown();

  GameListInitGameInfo(&gameInfo);
  ReplaceTags(tags, &gameInfo);

  switch (gameInfo.result)
  { case WhiteWins:
      result = 0;
      break;
    case BlackWins:
      result = 1;
      break;
    case GameIsDrawn:
      result = 2;
      break;
    default:
      result = 3;
      break;
  }


  /* Create window */
  editTagsUp = WindowObject,
		MUIA_Window_ID, MAKE_ID('I','N','F','E'),
		MUIA_Window_Title, "Edit Game Info",
		MUIA_Window_RefWindow, xboardWindow,
		WindowContents, VGroup,
		    Child, ColGroup(2),
			GroupFrameT("Game Info"),
			Child, Label2("Event:"),
			Child, eventStr = StringObject,
			    StringFrame,
			    MUIA_String_Contents, gameInfo.event,
			    MUIA_String_MaxLen, MSG_SIZ,
			End,
			Child, Label2("Site:"),
			Child, siteStr = StringObject,
			    StringFrame,
			    MUIA_String_Contents, gameInfo.site,
			    MUIA_String_MaxLen, MSG_SIZ,
			End,
			Child, Label2("Date:"),
			Child, dateStr = StringObject,
			    StringFrame,
			    MUIA_String_Contents, gameInfo.date,
			    MUIA_String_MaxLen, MSG_SIZ,
			End,
			Child, Label2("Round:"),
			Child, roundStr = StringObject,
			    StringFrame,
			    MUIA_String_Contents, gameInfo.round,
			    MUIA_String_MaxLen, MSG_SIZ,
			End,
			Child, Label2("White:"),
			Child, whiteStr = StringObject,
			    StringFrame,
			    MUIA_String_Contents, gameInfo.white,
			    MUIA_String_MaxLen, MSG_SIZ,
			End,
			Child, Label2("Black:"),
			Child, blackStr = StringObject,
			    StringFrame,
			    MUIA_String_Contents, gameInfo.black,
			    MUIA_String_MaxLen, MSG_SIZ,
			End,
			Child, Label2("Result:"),
			Child, resultCycle = MUI_MakeObject(MUIO_Cycle, NULL, resultStrings),
			Child, Label2("Details:"),
			Child, detailStr = StringObject,
			    StringFrame,
			    MUIA_String_Contents, gameInfo.resultDetails,
			    MUIA_String_MaxLen, MSG_SIZ,
			End,
		    End,
		    Child, HGroup,
			Child, okButton = MUI_MakeObject(MUIO_Button, "Ok"),
			Child, HSpace(0),
			Child, cancelButton = MUI_MakeObject(MUIO_Button, "Cancel"),
		    End,
		End,
	    End;


  if (editTagsUp)
  { int open;

    DoMethod(xboardApp, OM_ADDMEMBER, editTagsUp);

    /* Setup hooks to call, if user closes window or hits a button.
     */
    DoMethod(editTagsUp, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
	     editTagsUp, 3, MUIM_CallHook, &editTagsCallbackHook,
	     /* Hook arguments */
	     NULL);
    DoMethod(cancelButton, MUIM_Notify, MUIA_Pressed, FALSE,
	     editTagsUp, 3, MUIM_CallHook, &editTagsCallbackHook,
	     /* Hook arguments */
	     NULL);
    DoMethod(okButton, MUIM_Notify, MUIA_Pressed, FALSE,
	     editTagsUp, 10, MUIM_CallHook, &editTagsCallbackHook,
	     /* Hook arguments */
	     eventStr, siteStr, dateStr, roundStr, whiteStr, blackStr,
	     resultCycle, detailStr);

    DoMethod(editTagsUp, MUIM_Window_SetCycleChain, eventStr,
	     siteStr, dateStr, roundStr, whiteStr, blackStr,
	     resultCycle, detailStr, NULL);
    DoMethod(eventStr, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	     editTagsUp, 3,
	     MUIM_Set, MUIA_Window_ActiveObject, siteStr);
    DoMethod(siteStr, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	     editTagsUp, 3,
	     MUIM_Set, MUIA_Window_ActiveObject, dateStr);
    DoMethod(dateStr, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	     editTagsUp, 3,
	     MUIM_Set, MUIA_Window_ActiveObject, roundStr);
    DoMethod(roundStr, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	     editTagsUp, 3,
	     MUIM_Set, MUIA_Window_ActiveObject, whiteStr);
    DoMethod(whiteStr, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	     editTagsUp, 3,
	     MUIM_Set, MUIA_Window_ActiveObject, blackStr);
    DoMethod(blackStr, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	     editTagsUp, 3,
	     MUIM_Set, MUIA_Window_ActiveObject, detailStr);
    DoMethod(detailStr, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	     editTagsUp, 3,
	     MUIM_Set, MUIA_Window_ActiveObject, eventStr);
    set(editTagsUp, MUIA_Window_Open, TRUE);
    get(editTagsUp, MUIA_Window_Open, &open);
    if (open) {
	return;
    }


    CloseMuiWindow(editTagsUp);
  }

  DisplayError("Cannot open window: ", ENOMEM);
}
/**/


/***  TagsPopUp() function
*/
_HOOK_FUNC(void, tagsCallback, struct Hook* hook,
			       Object* tagsWin,
			       va_list args)
{
    if (va_arg(args, int)) {
	EditTagsProc();
    } else {
	TagsPopDown();
    }
}
static struct Hook tagsCallbackHook = {
    { NULL, NULL },
    (HOOKFUNC) tagsCallback,
    NULL,
    NULL
};


void TagsPopUp(char* tags, char* msg)

{
    Object* editButton;
    Object* cancelButton;

    TagsPopDown();

    tagsUp = WindowObject,
		    MUIA_Window_Title, msg,
		    MUIA_Window_ID, MAKE_ID('T','A','G','S'),
		    MUIA_Window_RefWindow, xboardWindow,
		    WindowContents, VGroup,
			Child, TextObject,
			    TextFrame,
			    MUIA_Text_Contents, tags,
			    MUIA_Text_SetMax, TRUE,
			    MUIA_Text_SetMin, TRUE,
			End,
			Child, HGroup,
			    Child, editButton = MUI_MakeObject(MUIO_Button, "Edit"),
			    Child, HSpace(0),
			    Child, cancelButton = MUI_MakeObject(MUIO_Button, "Cancel"),
			End,
		    End,
		End;

    if (tagsUp) {
	int open;

	DoMethod(xboardApp, OM_ADDMEMBER, tagsUp);

	DoMethod(tagsUp, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
		 tagsUp, 3, MUIM_CallHook, &tagsCallbackHook,
		 /*  Hook arguments  */
		 FALSE);
	DoMethod(cancelButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 tagsUp, 3, MUIM_CallHook, &tagsCallbackHook,
		 /*  Hook arguments  */
		 FALSE);
	DoMethod(editButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 tagsUp, 3, MUIM_CallHook, &tagsCallbackHook,
		 /*  Hook arguments  */
		 TRUE);

	set(tagsUp, MUIA_Window_Open, TRUE);
	get(tagsUp, MUIA_Window_Open, &open);
	if (!open) {
	    DoMethod(xboardApp, OM_REMMEMBER, tagsUp);
	    CloseMuiWindow(tagsUp);
	    tagsUp = NULL;
	    DisplayError("Cannot open tags window.", 0);
	}
    }
}
/**/


/***  TagsPopDown() function
*/
void TagsPopDown(void)

{
    if (tagsUp) {
	CloseMuiWindow(tagsUp);
	tagsUp = NULL;
    }
    if (editTagsUp) {
	CloseMuiWindow(editTagsUp);
	editTagsUp = NULL;
    }
}
/**/


/***  EditTagsProc() function
*/
void EditTagsProc(void)

{
    if (tagsUp) TagsPopDown();
    if (editTagsUp) {
	TagsPopDown();
    } else {
	EditTagsEvent();
    }
}
/**/

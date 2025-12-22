/*
 * amygamelist.c -- Game list window, part of Amiga front end for XBoard
 * $Id: xgamelist.c,v 1.2 1995/06/26 04:22:40 mann Exp $
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

#include "AmyBoard.h"

#ifndef LIBRARIES_IFFPARSE_H
#include <libraries/iffparse.h>
#endif



Object* gameListUp = NULL;      /*  game list window    */
Object* gameListList = NULL;    /*  list object         */


/***  Game List callback
***
***  Called from the game list window, if user selects a game or
***  hits a window.
***
***  Inputs:    hook - pointer to gameListCallbackHook
***             win - gamelist window
***             args - va_list with following arguments:
***
***                 action - one of the following constants:
***                     GAMELIST_LOAD
***                     GAMELIST_NEXT
***                     GAMELIST_PREV
***                     GAMELIST_CLOSE
***                 listObj - pointer to list object
***                 fp - FILE pointer to open file
***                 fileName - string with name of open file
***
**/
#define GAMELIST_LOAD   0
#define GAMELIST_NEXT   1
#define GAMELIST_PREV   -1
#define GAMELIST_CLOSE  2

_HOOK_FUNC(VOID, gameListCallback, struct Hook *hook,
				   Object *gameListUp,
				   va_list args)
{
    int index;
    int offset;
    ListGame* lg;
    FILE* fp;
    char* fileName;

    if ((offset = va_arg(args, int))  ==  GAMELIST_CLOSE) {
	GameListPopDown();
	return;
    }
    fp = va_arg(args, FILE*);
    fileName = va_arg(args, char*);

    get(gameListList, MUIA_List_Active, &index);
    if (index == MUIV_List_Active_Off) {
	DisplayError("No game selected", 0);
	return;
    }

    DoMethod(gameListList, MUIM_List_GetEntry, index+offset, &lg);
    if (!lg) {
	if (offset == GAMELIST_NEXT) {
	    DisplayError("Can't go forward any further", 0);
	} else if (offset == GAMELIST_PREV) {
	    DisplayError("Can't back up any further", 0);
	}
    }

    set(gameListList, MUIA_List_Active, index+offset);

    if (cmailMsgLoaded) {
	CmailLoadGame(fp, lg->number, fileName, TRUE);
    } else {
	LoadGame(fp, lg->number, fileName, TRUE);
    }
}
struct Hook gameListCallbackHook = {
    { NULL, NULL },
    (HOOKFUNC) gameListCallback,
    NULL,
    NULL
};
/**/


/***  GameListPopUp() function
***
***  Brings up a requester with the list of games. Receives following
***  arguments:
***
***     proc    Function to call, if user has selected a game
***     fp      File to load the game from; will be closed, if the
***             user cancels.
***     title   title to display
**/

_HOOK_FUNC(ULONG, gameListDisp, struct Hook *hook,  /*  Called to display  */
				char **strArray,    /*  one game           */
				ListGame *lg)
{
    static char buf[20];

    sprintf(buf, "%d", lg->number);
    *strArray++ = buf;
    *strArray++ = lg->gameInfo.event;
    *strArray++ = lg->gameInfo.white;
    *strArray++ = lg->gameInfo.black;

    return(0);
}
struct Hook gameListDispHook = {
    { NULL, NULL },
    (HOOKFUNC) gameListDisp,
    NULL,
    NULL
};


void GameListPopUp(FILE *fp, char *fileName)

{
    Object* loadButton;
    Object* nextButton;
    Object* prevButton;
    Object* cancelButton;
    char *file;
    int open;

    if (!(file = strdup(fileName))) {
	DisplayError("Cannot open file.", 0);
	return;
    }

    if (!gameListUp) {
	/* Create window. */
	gameListUp = WindowObject,
		    MUIA_Window_ID, MAKE_ID('G','L','S','T'),
		    MUIA_Window_Title, "Game list requester",
		    MUIA_Window_RefWindow, xboardWindow,
		    WindowContents, VGroup,
			Child, gameListList = ListviewObject,
			    MUIA_Listview_List, ListObject,
				MUIA_List_DisplayHook, &gameListDispHook,
				/* Display 4 columns, the second one (event)
				 * is the most important.
				 */
				MUIA_List_Format, "WEIGHT=25,WEIGHT=200,WEIGHT=100,WEIGHT=100",
				InputListFrame,
			    End,
			End,
			Child, HGroup,
			    Child, loadButton = MUI_MakeObject(MUIO_Button, "Ok"),
			    Child, HSpace(0),
			    Child, nextButton = MUI_MakeObject(MUIO_Button, "Next"),
			    Child, HSpace(0),
			    Child, prevButton = MUI_MakeObject(MUIO_Button, "Prev"),
			    Child, HSpace(0),
			    Child, cancelButton = MUI_MakeObject(MUIO_Button, "Close"),
			End,
		    End,
		End;

	if (!gameListUp) {
	    DisplayError("Cannot open window", ENOMEM);
	    return;
	}


	DoMethod(xboardApp, OM_ADDMEMBER, gameListUp);

	/* Setup hooks to call, if user closes window, selects game or hits
	 * a button.
	 */
	DoMethod(gameListUp, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
		 gameListUp, 3, MUIM_CallHook, &gameListCallbackHook,
		 /* Hook arguments */
		 GAMELIST_CLOSE);
	DoMethod(gameListList, MUIM_Notify, MUIA_Listview_DoubleClick, TRUE,
		 gameListUp, 5, MUIM_CallHook, &gameListCallbackHook,
		 /* Hook arguments */
		 GAMELIST_LOAD, fp, file);
	DoMethod(loadButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 gameListUp, 5, MUIM_CallHook, &gameListCallbackHook,
		 /* Hook arguments */
		 GAMELIST_LOAD, fp, file);
	DoMethod(nextButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 gameListUp, 5, MUIM_CallHook, &gameListCallbackHook,
		 /* Hook arguments */
		 GAMELIST_NEXT, fp, file);
	DoMethod(prevButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 gameListUp, 5, MUIM_CallHook, &gameListCallbackHook,
		 /* Hook arguments */
		 GAMELIST_PREV, fp, file);
	DoMethod(cancelButton, MUIM_Notify, MUIA_Pressed, FALSE,
		 gameListUp, 3, MUIM_CallHook, &gameListCallbackHook,
		 /* Hook arguments */
		 GAMELIST_CLOSE);
    }

    set(gameListList, MUIA_List_Quiet, TRUE);
    DoMethod(gameListList, MUIM_List_Clear);
    {
	ListGame *lg;

	for (lg = (ListGame *) gameList.head;
	     lg->node.succ;
	     lg = (ListGame *) lg->node.succ) {
	    DoMethod(gameListList, MUIM_List_InsertSingle, lg, MUIV_List_Insert_Bottom);
	}
    }
    set(gameListList, MUIA_List_Quiet, FALSE);
    set(gameListUp, MUIA_Window_Open, TRUE);
    get(gameListUp, MUIA_Window_Open, &open);

    if (!open) {
	DisplayError("Cannot open window: ", ENOMEM);
    }
}
/**/


/***  ShowGameListProc() function
***
***  Called from the menu, if user selects the "Show Game List" item.
**/
void ShowGameListProc(void)

{
    int open;

    if (!gameListUp) {
	DisplayError("There is no game list", 0);
	return;
    }

    get(gameListUp, MUIA_Window_Open, &open);
    set(gameListUp, MUIA_Window_Open, !open);
}
/**/


/***  GameListPopDown() function
***
***  Removes the game list window temporarily.
**/
void GameListPopDown(void)

{
    if (!gameListUp) {
	return;
    }
    set(gameListUp, MUIA_Window_Open, FALSE);
}
/**/


/***  GameListDestroy() function
***
***  Removes the game list window finally.
**/
void GameListDestroy(void)

{
    if (!gameListUp) {
	return;
    } else {
	CloseMuiWindow(gameListUp);
	gameListUp = NULL;
    }
}
/**/


/***  GameListHighLight() function
***
***  Highlights a certain entry in the game list.
***
***  Inputs:    index - number of entry to highlight
**/
void GameListHighlight(int index)

{
    if (gameListUp) {
	set(gameListList, MUIA_List_Active, index-1);
    }
}

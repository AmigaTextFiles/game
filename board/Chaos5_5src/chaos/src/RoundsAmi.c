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


    $RCSfile: RoundsAmi.c,v $
    $Revision: 3.2 $
    $Date: 1994/11/19 19:32:01 $

    This file contains the system dependent part of the functions to enter
    results.

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




/*
    GetRoundNr() allows the user to select a round.

    Result: round number or 0, if the user cancels
*/
#define ID_RndSelWnd_Ok         20
#define ID_RndSelWnd_Cancel     21
#define ID_RndselWnd_Rnd        22


int GetRoundNr(void)

#ifdef AMIGA
{ ULONG open, signal;
  int round = 0;
  APTR RndSelWnd;           /*  round select window                 */
  APTR RndSelWnd_Ok;        /*  Ok button (round select window)     */
  APTR RndSelWnd_Cancel;    /*  Cancel button (round select window) */
  APTR RndSelWnd_Rnd;       /*  round number gadget                 */
  int Ok_SC = *MSG_OK_SC;
  int Cancel_SC = *MSG_CANCEL_SC;

  if (NumRounds == 1)
  { return(1);
  }

  RndSelWnd_Rnd = SliderObject,
	MUIA_Slider_Max, NumRounds,
	MUIA_Slider_Level, NumRounds,
	MUIA_Slider_Min, 1,
    End;

  RndSelWnd = WindowObject,
		MUIA_Window_ID, MAKE_ID('R','N','D','S'),
		MUIA_Window_Title, WND_RNDSEL_TITLE,
		MUIA_Window_DefaultObject, RndSelWnd_Rnd,
		WindowContents, VGroup,
		    Child, TextObject,
			MUIA_Text_Contents, WND_RNDSEL_TEXT,
		    End,
		    Child, RndSelWnd_Rnd,
		    Child, HGroup,
			Child, RndSelWnd_Ok = KeyButton(MSG_OK, Ok_SC),
			Child, RndSelWnd_Cancel = KeyButton(MSG_CANCEL_INPUT, Cancel_SC),
		    End,
		End,
	    End;

  if (!RndSelWnd)
  { return(0);
  }
  DoMethod(App, OM_ADDMEMBER, RndSelWnd);
  DoMethod(RndSelWnd, MUIM_Window_SetCycleChain, RndSelWnd_Rnd,
	   RndSelWnd_Ok, RndSelWnd_Cancel, NULL);

  /*
      Setting up the notification events for the round select window:
      CloseWindow, Ok-, and Cancel-button and the round number gadget.
  */
  DoMethod(RndSelWnd, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
	   App, 2, MUIM_Application_ReturnID, ID_RndSelWnd_Cancel);
  DoMethod(RndSelWnd_Cancel, MUIM_Notify, MUIA_Pressed, FALSE, App, 2,
	   MUIM_Application_ReturnID, ID_RndSelWnd_Cancel);
  DoMethod(RndSelWnd, MUIM_Notify, MUIA_Window_InputEvent, "ctrl return",
	   App, 2, MUIM_Application_ReturnID, ID_RndSelWnd_Ok);
  DoMethod(RndSelWnd_Ok, MUIM_Notify, MUIA_Pressed, FALSE,
	   App, 2, MUIM_Application_ReturnID, ID_RndSelWnd_Ok);

  set(MainWnd, MUIA_Window_Open, FALSE);
  set(RndSelWnd, MUIA_Window_Open, TRUE);
  get(RndSelWnd, MUIA_Window_Open, &open);
  if (!open)
  { MUIError((char *) ERRMSG_CANNOT_OPEN_WINDOW);
    DoMethod(App, OM_REMMEMBER, RndSelWnd);
    MUI_DisposeObject(RndSelWnd);
    return(0);
  }

  for(;;)
  { switch(DoMethod(App, MUIM_Application_Input, &signal))
    { case MUIV_Application_ReturnID_Quit:
	if (TestSaved())
	{ exit(0);
	}
	break;
      case ID_RndSelWnd_Ok:
	get(RndSelWnd_Rnd, MUIA_Slider_Level, &round);
      case ID_RndSelWnd_Cancel:
	set(RndSelWnd, MUIA_Window_Open, FALSE);
	DoMethod(App, OM_REMMEMBER, RndSelWnd);
	MUI_DisposeObject(RndSelWnd);
	return(round);
    }

    if (signal)
    { Wait(signal);
    }
  }
}
#endif  /*  AMIGA   */




/*
    TerminateRsltWnd() closes the result window.
*/
#ifdef AMIGA
static APTR RsltWnd = NULL;     /*  Result window                       */
static APTR RsltWnd_OkGad;      /*  Ok button (result window)           */
static APTR RsltWnd_CancelGad;  /*  Cancel button (result window)       */
static APTR RsltWnd_GmLV;       /*  game listview gadget (result window)*/
static APTR RsltWnd_Rslt;       /*  result radio gadget                 */
static APTR RsltWnd_Mode;       /*  result mode radio gadget            */

void TerminateRsltWnd(void)

{ if (RsltWnd)
  { set(RsltWnd, MUIA_Window_Open, FALSE);
    DoMethod(App, OM_REMMEMBER, RsltWnd);
    MUI_DisposeObject(RsltWnd);
    RsltWnd = NULL;
  }
}
#endif  /*  AMIGA   */




#ifdef AMIGA
/*
    This is the MUI-displayhook. The following function gets called, when
    a game is displayed.
*/
SAVEDS ASM static LONG DispRsltFunc(REG(a1) struct GameNode *gn,
				    REG(a2) char **array)

{
  *array++ = gn->Text;
  *array++ = gn->White->Name;
  *array++ = ": ";
  *array++ = gn->Black->Name;
  *array   = gn->Text + strlen(gn->Text) + 1;
  return(0);
}
#ifdef AZTEC_C
extern LONG MyDispRsltFunc (struct GameNode *gn, char **array);
#asm
		xref    _geta4
_MyDispRsltFunc:
		move.l  a4,-(sp)
		jsr     _geta4
		move.l  a2,-(sp)
		move.l  a1,-(sp)
		jsr     _DispRsltFunc
		add.l   #8,sp
		move.l  (sp)+,a4
		rts
#endasm
#define DispRsltFunc MyDispRsltFunc
#endif  /*  AZTEC_C */
struct Hook RsltWnd_GmListDispHook =
{ NULL, NULL, (void *) DispRsltFunc, NULL, NULL
};
#endif  /*  AMIGA   */




/*
    InitRsltWnd() initializes the window to enter results.

    Inputs: title   - window title
	    rlist   - list of GameNode structures created using GetRound()

    Result: TRUE, if successfull, FALSE otherwise
*/
#ifdef AMIGA
#define ID_RsltWnd_Ok           14
#define ID_RsltWnd_Cancel       15
#define ID_RsltWnd_Rslt         16
#define ID_RsltWnd_Mode         17
#define ID_RsltWnd_GmLV         18
#define ID_RsltWnd_White        23
#define ID_RsltWnd_Draw         24
#define ID_RsltWnd_Black        25
#define ID_RsltWnd_Missing      26
#define ID_RsltWnd_Played       27
#define ID_RsltWnd_NotPlayed    28
#define ID_RsltWnd_Down         29

int InitRsltWnd(char *title, struct MinList *rlist)

{ ULONG open;
  struct GameNode *gn;
  static STRPTR RsltWnd_Rslt_Entries[5];
  static STRPTR RsltWnd_Mode_Entries[3];
  int Ok_SC = *MSG_OK_SC;
  int Cancel_SC = *MSG_CANCEL_SC;

  RsltWnd_Rslt_Entries[0] = MSG_WHITE_WINS_INPUT;
  RsltWnd_Rslt_Entries[1] = MSG_DRAW_INPUT;
  RsltWnd_Rslt_Entries[2] = MSG_BLACK_WINS_INPUT;
  RsltWnd_Rslt_Entries[3] = MSG_RESULT_MISSING_INPUT;
  RsltWnd_Rslt_Entries[4] = NULL;
  RsltWnd_Mode_Entries[0] = MSG_AUSGETRAGEN_INPUT;
  RsltWnd_Mode_Entries[1] = MSG_KAMPFLOS_INPUT;
  RsltWnd_Mode_Entries[2] = NULL;

  RsltWnd = WindowObject,
		MUIA_Window_ID, MAKE_ID('R','S','L','T'),
		MUIA_Window_Title, title,
		MUIA_Window_DefaultObject, RsltWnd_GmLV,
		WindowContents, VGroup,
		    Child, RsltWnd_GmLV = ListviewObject,
			MUIA_Listview_List, ListObject,
			    MUIA_List_Format, ",,,,",
			    MUIA_List_DisplayHook, &RsltWnd_GmListDispHook,
			    InputListFrame,
			End,
		    End,
		    Child, HGroup,
			Child, RsltWnd_OkGad = KeyButton(MSG_OK, Ok_SC),
			Child, HSpace(10),
			Child, RsltWnd_Rslt = Radio(RADIO_RESULT_TITLE,
						    RsltWnd_Rslt_Entries),
			Child, RsltWnd_Mode = Radio(RADIO_MODE_TITLE,
						    RsltWnd_Mode_Entries),
			Child, HSpace(10),
			Child, RsltWnd_CancelGad = KeyButton(MSG_CANCEL_INPUT, Cancel_SC),
		    End,
		End,
	    End;

  if (!RsltWnd)
  { return(FALSE);
  }
  DoMethod(App, OM_ADDMEMBER, RsltWnd);
  DoMethod(RsltWnd, MUIM_Window_SetCycleChain, RsltWnd_GmLV, RsltWnd_OkGad,
	   RsltWnd_Rslt, RsltWnd_Mode, RsltWnd_CancelGad, NULL);

  /*
      Setting up the notification events for the result window:
      CloseWindow, Ok-, and Cancel-button, the result and result-mode
      gadgets and the result keys.
  */
  DoMethod(RsltWnd, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Cancel);
  DoMethod(RsltWnd, MUIM_Notify, MUIA_Window_InputEvent, "esc",
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Cancel);
  DoMethod(RsltWnd_CancelGad, MUIM_Notify, MUIA_Pressed, FALSE,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Cancel);
  DoMethod(RsltWnd, MUIM_Notify, MUIA_Window_InputEvent, "ctrl return",
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Ok);
  DoMethod(RsltWnd_OkGad, MUIM_Notify, MUIA_Pressed, FALSE,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Ok);
  DoMethod(RsltWnd_Rslt, MUIM_Notify, MUIA_Radio_Active, MUIV_EveryTime,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Rslt);
  DoMethod(RsltWnd_Mode, MUIM_Notify, MUIA_Radio_Active, MUIV_EveryTime,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Mode);
  DoMethod(RsltWnd_GmLV, MUIM_Notify, MUIA_List_Active, MUIV_EveryTime,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_GmLV);
  DoMethod(RsltWnd, MUIM_Notify, MUIA_Window_InputEvent,
	   KEY_RESULT_WHITE,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_White);
  DoMethod(RsltWnd, MUIM_Notify, MUIA_Window_InputEvent,
	   KEY_RESULT_BLACK,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Black);
  DoMethod(RsltWnd, MUIM_Notify, MUIA_Window_InputEvent,
	   KEY_RESULT_MISSING,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Missing);
  DoMethod(RsltWnd, MUIM_Notify, MUIA_Window_InputEvent,
	   KEY_RESULT_DRAW,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Draw);
  DoMethod(RsltWnd, MUIM_Notify, MUIA_Window_InputEvent,
	   KEY_RESULT_PLAYED,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_Played);
  DoMethod(RsltWnd, MUIM_Notify, MUIA_Window_InputEvent,
	   KEY_RESULT_NPLAYED,
	   App, 2, MUIM_Application_ReturnID, ID_RsltWnd_NotPlayed);

  /*
      Initialize the window settings
  */
  gn = (struct GameNode *) rlist->mlh_Head;
  for (gn = (struct GameNode *) rlist->mlh_Head;
       gn->gn_Node.mln_Succ != NULL;
       gn = (struct GameNode *) gn->gn_Node.mln_Succ)
  { DoMethod(RsltWnd_GmLV, MUIM_List_Insert, &gn, 1,
	     MUIV_List_Insert_Bottom);
  }
  set(RsltWnd_GmLV, MUIA_List_Active, MUIV_List_Active_Top);


  set(RsltWnd, MUIA_Window_Open, TRUE);
  get(RsltWnd, MUIA_Window_Open, &open);
  if (!open)
  { MUIError((char *) ERRMSG_CANNOT_OPEN_WINDOW);
    return(FALSE);
  }
  return(TRUE);
}
#endif




/*
    ProcessRsltWnd() allows the user to enter the results.

    Input: rlist    - A list of GameNode structures created using
		      GetRound(). The function may modify the contents.

    Result: -1  - The user has selected the Ok button, process the changes
	    1   - Indicates, that ProcessRsltWnd() wants to be called again
	    0   - The user has terminated via Cancel button
*/
int ProcessRsltWnd(struct MinList *rlist)

#ifdef AMIGA
{ ULONG Signal, id;
  struct GameNode *gn;
  LONG result, mode;
  extern struct Library *MUIMasterBase;

  /*
      Check for user actions
  */
  switch (id = DoMethod(App, MUIM_Application_Input, &Signal))
  { case MUIV_Application_ReturnID_Quit:
      if (TestSaved())
      { exit(0);
      }
      break;
    case ID_RsltWnd_Cancel:
      return(0);
    case ID_RsltWnd_Ok:
      return(-1);
    case ID_RsltWnd_Rslt:
    case ID_RsltWnd_White:
    case ID_RsltWnd_Draw:
    case ID_RsltWnd_Black:
    case ID_RsltWnd_Missing:
      DoMethod(RsltWnd_GmLV, MUIM_List_GetEntry, MUIV_List_GetEntry_Active,
	       &gn);
      if (gn != NULL)
      { if (id == ID_RsltWnd_Rslt)
	{ get(RsltWnd_Rslt, MUIA_Radio_Active, &result);
	}
	else
	{ result = id - ID_RsltWnd_White;
	}
	gn->Result = 2-result;
	FormatGame(gn, 2);
	DoMethod(RsltWnd_GmLV, MUIM_List_Redraw, MUIV_List_Redraw_Active);
	if (MUIMasterBase->lib_Version >= 7)
	{ SetAttrs(RsltWnd_GmLV, MUIA_NoNotify, TRUE, MUIA_List_Active,
		   MUIV_List_Active_Down, TAG_DONE);
	}
      }
    case ID_RsltWnd_GmLV:
      DoMethod(RsltWnd_GmLV, MUIM_List_GetEntry, MUIV_List_GetEntry_Active,
	       &gn);
      if (gn != NULL)
      { SetAttrs(RsltWnd_Rslt, MUIA_NoNotify, TRUE,
			       MUIA_Radio_Active, 2-gn->Result,
			       TAG_DONE);
	SetAttrs(RsltWnd_Mode, MUIA_NoNotify, TRUE,
			       MUIA_Radio_Active,
				    (gn->Flags & GMFLAGSF_NOFIGHT) ? 1 : 0,
			       TAG_DONE);
      }
      if (id != ID_RsltWnd_Rslt  &&  id != ID_RsltWnd_GmLV  &&
	  MUIMasterBase->lib_Version < 7)
      { DoMethod(App, MUIM_Application_ReturnID, ID_RsltWnd_Down);
      }
      break;
    case ID_RsltWnd_Down:
      set(RsltWnd_GmLV, MUIA_List_Active, MUIV_List_Active_Down);
      break;
    case ID_RsltWnd_Mode:
    case ID_RsltWnd_Played:
    case ID_RsltWnd_NotPlayed:
      DoMethod(RsltWnd_GmLV, MUIM_List_GetEntry, MUIV_List_GetEntry_Active,
	       &gn);
      if (gn != NULL)
      { if (id == ID_RsltWnd_Mode)
	  { get(RsltWnd_Mode, MUIA_Radio_Active, &mode);
	  }
	else
	  { mode = id - ID_RsltWnd_Played;
	  }
	gn->Flags = (gn->Flags & ~GMFLAGSF_NOFIGHT) |
		    (mode ? GMFLAGSF_NOFIGHT : 0);
	FormatGame(gn, 2);
	DoMethod(RsltWnd_GmLV, MUIM_List_Redraw, MUIV_List_Redraw_Active);
      }
      break;
  }
  if (Signal)
  { Wait(Signal);
  }
  return(1);
}
#endif  /*  AMIGA   */

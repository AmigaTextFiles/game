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


    $RCSfile: PlayersAmi.c,v $
    $Revision: 3.2 $
    $Date: 1994/11/19 19:32:01 $

    This file contains the system dependent functions for the Players menu.

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
    AskExtContinue() brings up a requester asking a question and lets the
    user select between different possibilities.

    Inputs: str     a printf()-like format string
	    buttons a string containing the different choices, separated by
		    a '|', for example "Yes|No|Cancel"
	    Other arguments may follow. These are used in the format string.

    Results: 0 for the rightmost choice and 1, 2, 3, ... for the other
	     choices. (In the "Yes|No|Cancel" example this would be 1 for
	     "Yes", 2 for "No" and 0 for "Cancel".
*/
int AskExtContinue(char *str, char *buttons, ...)

#ifdef AMIGA
{ return(MUI_RequestA(App, MainWnd, 0, (char *) MSG_ATTENTION,
		      buttons, str, (APTR) ((&buttons)+1)));
}
#endif




/*
    The AskContinue() function brings up a requester asking a Yes/No
    question like "Do you really want to delete player p?"

    Inputs: a printf()-like format string, possibly followed by
	    the corresponding arguments.

    Results: TRUE, if the user selected Ok, FALSE otherwise
*/
int AskContinue(char *str, ...)

#ifdef AMIGA
{ return(MUI_RequestA(App, MainWnd, 0,
		      (char *) MSG_ATTENTION,
		      (char *) MSG_YES_NO,
		      str, (APTR) ((&str)+1)));
}
#endif  /*  AMIGA   */




/*
    The TerminatePlrWnd() function deletes the window that allows to edit
    players.
*/
#ifdef AMIGA
static APTR PlrWnd = NULL;  /*  Player window                       */
static APTR PlrOkGad;       /*  Ok gadget (player window)           */
static APTR PlrCancelGad;   /*  Cancel gadget (player window)       */
static APTR NameGad;        /*  Name gadget                         */
static APTR StreetGad;      /*  Street gadget                       */
static APTR VillageGad;     /*  Village gadget                      */
static APTR ChessClubGad;   /*  Chess club gadget                   */
static APTR PhoneGad;       /*  Phone gadget                        */
static APTR BirthdayGad;    /*  Birthday gadget                     */
static APTR DWZGad;         /*  DWZ gadget                          */
static APTR ELOGad;         /*  ELO gadget                          */
static APTR SeniorGad;      /*  Senior gadget                       */
static APTR JuniorGad;      /*  Junior gadget                       */
static APTR WomanGad;       /*  Woman gadget                        */
static APTR JuniorAGad;     /*  Junior (A) gadget                   */
static APTR JuniorBGad;     /*  Junior (B) gadget                   */
static APTR JuniorCGad;     /*  Junior (C) gadget                   */
static APTR JuniorDGad;     /*  Junior (D) gadget                   */
static APTR JuniorEGad;     /*  Junior (E) gadget                   */
void TerminatePlrWnd(void)

{ if (PlrWnd != NULL)
  { set(PlrWnd, MUIA_Window_Open, FALSE);
    DoMethod(App, OM_REMMEMBER, PlrWnd);
    MUI_DisposeObject(PlrWnd);
    PlrWnd = NULL;
  }
}
#endif  /*  AMIGA   */




/*
    The InitPlrWnd() function creates the window that allows to edit
    a player.

    Inputs:     title   the windows title

    Results:    TRUE, if successful, FALSE otherwise
*/
#define ID_PlrWnd_Cancel    303
#define ID_PlrWnd_Ok        304
int InitPlrWnd(char *title)

#ifdef AMIGA
{ int Ok_SC = *MSG_OK_SC;
  int Cancel_SC = *MSG_CANCEL_SC;

  PlrWnd = WindowObject,
	    MUIA_Window_ID, MAKE_ID('P','L','R','I'),
	    MUIA_Window_Width, MUIV_Window_Width_MinMax(50),
	    MUIA_Window_Title, title,
	    WindowContents, VGroup,
		Child, HGroup,
		    Child, VGroup,
			MUIA_Weight, 300,
			Child, ColGroup(2),
			    Child, Label2(MSG_NAME_INPUT),
			    Child, NameGad = StringObject,
				StringFrame,
				MUIA_String_MaxLen, NAMELEN+1,
			    End,
			    Child, Label2(MSG_STREET_INPUT),
			    Child, StreetGad = StringObject,
				StringFrame,
				MUIA_String_MaxLen, NAMELEN+1,
			    End,
			    Child, Label2(MSG_VILLAGE_INPUT),
			    Child, VillageGad = StringObject,
				StringFrame,
				MUIA_String_MaxLen, NAMELEN+1,
			    End,
			    Child, Label2(MSG_CHESS_CLUB_INPUT),
			    Child, ChessClubGad = StringObject,
				StringFrame,
				MUIA_String_MaxLen, NAMELEN+1,
			    End,
			    Child, Label2(MSG_PHONE_INPUT),
			    Child, PhoneGad = StringObject,
				StringFrame,
				MUIA_String_MaxLen, PHONENRLEN+1,
			    End,
			    Child, Label2(MSG_BIRTHDAY_INPUT),
			    Child, BirthdayGad = StringObject,
				StringFrame,
				MUIA_String_MaxLen, BIRTHDAYLEN+1,
			    End,
			End,
			Child, HGroup,
			    Child, Label2(MSG_DWZ_INPUT),
			    Child, DWZGad = StringObject, StringFrame,
				MUIA_String_MaxLen, DWZLEN+1,
				MUIA_String_Accept, "0123456789-",
			    End,
			    Child, HSpace(0),
			    Child, Label2(MSG_ELO_INPUT),
			    Child, ELOGad = StringObject, StringFrame,
				MUIA_String_MaxLen, DWZLEN+1,
				MUIA_String_Accept, "0123456789",
			    End,
			End,
		    End,
		    Child, MUI_NewObject(MUIC_Rectangle,
			MUIA_Weight, 50,
			End,
		    Child, ColGroup(2),
			Child, SeniorGad = CheckMark(FALSE),
			Child, Label2(MSG_SENIORS_INPUT),
			Child, JuniorGad = CheckMark(FALSE),
			Child, Label2(MSG_JUNIORS_INPUT),
			Child, WomanGad = CheckMark(FALSE),
			Child, Label2(MSG_WOMEN_INPUT),
			Child, JuniorAGad = CheckMark(FALSE),
			Child, Label2(MSG_JUNIORSA_INPUT),
			Child, JuniorBGad = CheckMark(FALSE),
			Child, Label2(MSG_JUNIORSB_INPUT),
			Child, JuniorCGad = CheckMark(FALSE),
			Child, Label2(MSG_JUNIORSC_INPUT),
			Child, JuniorDGad = CheckMark(FALSE),
			Child, Label2(MSG_JUNIORSD_INPUT),
			Child, JuniorEGad = CheckMark(FALSE),
			Child, Label2(MSG_JUNIORSE_INPUT),
		    End,
		End,
		Child, HGroup,
		    MUIA_Group_SameSize, TRUE,
		    Child, PlrOkGad = KeyButton(MSG_OK, Ok_SC),
		    Child, HSpace(0),
		    Child, HSpace(0),
		    Child, PlrCancelGad = KeyButton(MSG_CANCEL_INPUT, Cancel_SC),
		End,
	    End,
	End;

  if (!PlrWnd)
  { return(FALSE);
  }
  DoMethod(App, OM_ADDMEMBER, PlrWnd);

  /*
      Setting up the notification events for the player input window
  */
  DoMethod(PlrWnd, MUIM_Notify, MUIA_Window_CloseRequest, TRUE, App, 2,
	   MUIM_Application_ReturnID, ID_PlrWnd_Cancel);
  DoMethod(PlrWnd, MUIM_Notify, MUIA_Window_InputEvent, "ctrl return",
	   App, 2, MUIM_Application_ReturnID, ID_PlrWnd_Ok);
  DoMethod(PlrOkGad, MUIM_Notify, MUIA_Pressed, FALSE, App, 2,
	   MUIM_Application_ReturnID, ID_PlrWnd_Ok);
  DoMethod(PlrCancelGad, MUIM_Notify, MUIA_Pressed, FALSE, App, 2,
	   MUIM_Application_ReturnID, ID_PlrWnd_Cancel);

  /*
      Setting up the cycle chain in the player input window
  */
  DoMethod(PlrWnd, MUIM_Window_SetCycleChain,
	   NameGad, StreetGad, VillageGad, ChessClubGad, PhoneGad,
	   BirthdayGad, DWZGad, ELOGad, PlrOkGad, PlrCancelGad,
	   SeniorGad, JuniorGad, WomanGad, JuniorAGad, JuniorBGad,
	   JuniorCGad, JuniorDGad, JuniorEGad, NULL);
  DoMethod(NameGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   PlrWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, StreetGad);
  DoMethod(StreetGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   PlrWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, VillageGad);
  DoMethod(VillageGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   PlrWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, ChessClubGad);
  DoMethod(ChessClubGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   PlrWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, PhoneGad);
  DoMethod(PhoneGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   PlrWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, BirthdayGad);
  DoMethod(BirthdayGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   PlrWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, DWZGad);
  DoMethod(DWZGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   PlrWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, ELOGad);
  DoMethod(ELOGad, MUIM_Notify, MUIA_String_Acknowledge, MUIV_EveryTime,
	   PlrWnd, 3, MUIM_Set, MUIA_Window_ActiveObject, NameGad);

  /*
      Of course you cannot be both senior and junior. Selecting a junior
      gadget deselects a junior gadget and vice versa. Further you can
      only be one of JuniorA, JuniorB, JuniorC, JuniorD and JuniorE.

      On the other hand a JuniorA is a Junior too.
  */
  DoMethod(JuniorAGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorBGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorAGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorCGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorAGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorDGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorAGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorEGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorAGad, MUIM_Notify, MUIA_Selected, TRUE, SeniorGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorAGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorGad, 4,
	   MUIM_Set, MUIA_Selected, TRUE);

  DoMethod(JuniorBGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorAGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorBGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorCGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorBGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorDGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorBGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorEGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorBGad, MUIM_Notify, MUIA_Selected, TRUE, SeniorGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorBGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorGad, 4,
	   MUIM_Set, MUIA_Selected, TRUE);

  DoMethod(JuniorCGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorAGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorCGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorBGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorCGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorDGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorCGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorEGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorCGad, MUIM_Notify, MUIA_Selected, TRUE, SeniorGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorCGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorGad, 4,
	   MUIM_Set, MUIA_Selected, TRUE);

  DoMethod(JuniorDGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorAGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorDGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorBGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorDGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorCGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorDGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorEGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorDGad, MUIM_Notify, MUIA_Selected, TRUE, SeniorGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorDGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorGad, 4,
	   MUIM_Set, MUIA_Selected, TRUE);

  DoMethod(JuniorEGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorAGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorEGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorBGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorEGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorCGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorEGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorDGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorEGad, MUIM_Notify, MUIA_Selected, TRUE, SeniorGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorEGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorGad, 4,
	   MUIM_Set, MUIA_Selected, TRUE);

  DoMethod(JuniorGad, MUIM_Notify, MUIA_Selected, TRUE, SeniorGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorGad, MUIM_Notify, MUIA_Selected, FALSE, JuniorAGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorGad, MUIM_Notify, MUIA_Selected, FALSE, JuniorBGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorGad, MUIM_Notify, MUIA_Selected, FALSE, JuniorCGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorGad, MUIM_Notify, MUIA_Selected, FALSE, JuniorDGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(JuniorGad, MUIM_Notify, MUIA_Selected, FALSE, JuniorEGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);

  DoMethod(SeniorGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(SeniorGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorAGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(SeniorGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorBGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(SeniorGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorCGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(SeniorGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorDGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);
  DoMethod(SeniorGad, MUIM_Notify, MUIA_Selected, TRUE, JuniorEGad, 4,
	   MUIM_Set, MUIA_Selected, FALSE);

  return(TRUE);
}
#endif  /*  AMIGA   */




/*
    The ProcessPlrWnd() function brings up a window and allows the user, to
    enter or modify a players data. (Note, that this behaves in another
    manner on the Amiga, than the other Process...() functions: The window
    isn't opened by InitPlrWnd(), but by ProcessPlrWnd(). Of course this is
    no must.

    Inputs:     plr - A pointer to a player structure with the defaults.
		new - TRUE, if this is the first call of ProcessPlrWnd or if
		      plr has changed since the last call, FALSE otherwise.

    Results:    TRUE    - User selected the Ok button.
		FALSE   - Error or user selected the Cancel button.
*/
int ProcessPlrWnd(struct Player *plr, int new)

#ifdef AMIGA
{ ULONG open, Signal;
  char *str;
  ULONG flag;

  if(new)
  { char elo[10];

    set(PlrWnd, MUIA_Window_ActiveObject, NameGad);
    set(NameGad, MUIA_String_Contents, plr->Name);
    set(StreetGad, MUIA_String_Contents, plr->Street);
    set(VillageGad, MUIA_String_Contents, plr->Village);
    set(ChessClubGad, MUIA_String_Contents, plr->ChessClub);
    set(PhoneGad, MUIA_String_Contents, plr->PhoneNr);
    set(BirthdayGad, MUIA_String_Contents, plr->BirthDay);
    set(DWZGad, MUIA_String_Contents, plr->DWZ);
    sprintf(elo, "%d", plr->ELO);
    set(ELOGad, MUIA_String_Contents, plr->ELO);
    set(SeniorGad, MUIA_Selected,
	(plr->Flags & TNFLAGSF_SENIOR) ? TRUE : FALSE);
    set(JuniorGad, MUIA_Selected,
	(plr->Flags & TNFLAGSF_JUNIOR) ? TRUE : FALSE);
    set(WomanGad, MUIA_Selected,
	(plr->Flags & TNFLAGSF_WOMAN) ? TRUE : FALSE);
    set(JuniorAGad, MUIA_Selected,
	(plr->Flags & TNFLAGSF_JUNIORA) ? TRUE : FALSE);
    set(JuniorBGad, MUIA_Selected,
	(plr->Flags & TNFLAGSF_JUNIORB) ? TRUE : FALSE);
    set(JuniorCGad, MUIA_Selected,
	(plr->Flags & TNFLAGSF_JUNIORC) ? TRUE : FALSE);
    set(JuniorDGad, MUIA_Selected,
	(plr->Flags & TNFLAGSF_JUNIORD) ? TRUE : FALSE);
    set(JuniorEGad, MUIA_Selected,
	(plr->Flags & TNFLAGSF_JUNIORE) ? TRUE : FALSE);
  }

  set(PlrWnd, MUIA_Window_Open, TRUE);
  get(PlrWnd, MUIA_Window_Open, &open);
  if (!open)
  { MUIError((char *) ERRMSG_CANNOT_OPEN_WINDOW);
    return(FALSE);
  }
  if (new)
  { set(PlrWnd, MUIA_Window_ActiveObject, NameGad);
  }

  /*
      Check for user actions
  */
  for (;;)
  { switch (DoMethod(App, MUIM_Application_Input, &Signal))
    { case MUIV_Application_ReturnID_Quit:
	if (TestSaved())
	{ exit(0);
	}
	break;
      case ID_PlrWnd_Cancel:
	set(PlrWnd, MUIA_Window_Open, FALSE);
	return(FALSE);
      case ID_PlrWnd_Ok:
	/*
	    Get the final state of the gadgets.
	*/
	set(PlrWnd, MUIA_Window_Open, FALSE);
	get(NameGad, MUIA_String_Contents, &str);
	strcpy(plr->Name, str);
	get(StreetGad, MUIA_String_Contents, &str);
	strcpy(plr->Street, str);
	get(VillageGad, MUIA_String_Contents, &str);
	strcpy(plr->Village, str);
	get(ChessClubGad, MUIA_String_Contents, &str);
	strcpy(plr->ChessClub, str);
	get(PhoneGad, MUIA_String_Contents, &str);
	strcpy(plr->PhoneNr, str);
	get(BirthdayGad, MUIA_String_Contents, &str);
	strcpy(plr->BirthDay, str);
	get(DWZGad, MUIA_String_Contents, &str);
	strcpy(plr->DWZ, str);
	get(ELOGad, MUIA_String_Contents, &str);
	plr->ELO = atol(str);
	plr->Flags &= ~(TNFLAGSF_SENIOR|TNFLAGSF_JUNIOR|TNFLAGSF_WOMAN|
			TNFLAGSF_JUNIORA|TNFLAGSF_JUNIORB|TNFLAGSF_JUNIORC|
			TNFLAGSF_JUNIORD|TNFLAGSF_JUNIORE);
	get(SeniorGad, MUIA_Selected, &flag);
	if (flag) plr->Flags |= TNFLAGSF_SENIOR;
	get(JuniorGad, MUIA_Selected, &flag);
	if (flag) plr->Flags |= TNFLAGSF_JUNIOR;
	get(WomanGad, MUIA_Selected, &flag);
	if (flag) plr->Flags |= TNFLAGSF_WOMAN;
	get(JuniorAGad, MUIA_Selected, &flag);
	if (flag) plr->Flags |= TNFLAGSF_JUNIORA;
	get(JuniorBGad, MUIA_Selected, &flag);
	if (flag) plr->Flags |= TNFLAGSF_JUNIORB;
	get(JuniorCGad, MUIA_Selected, &flag);
	if (flag) plr->Flags |= TNFLAGSF_JUNIORC;
	get(JuniorDGad, MUIA_Selected, &flag);
	if (flag) plr->Flags |= TNFLAGSF_JUNIORD;
	get(JuniorEGad, MUIA_Selected, &flag);
	if (flag) plr->Flags |= TNFLAGSF_JUNIORE;
	return(TRUE);
    }

    if (Signal)
    { Wait(Signal);
    }
  }

}
#endif  /*  AMIGA   */




/*
    The TerminatePlrSelWnd() function deletes the player select window.
*/
#ifdef AMIGA
static APTR PlrSelWnd = NULL;   /*  Player select window                    */
static APTR PlrSelCancelGad;    /*  Cancel gadget (player select window)    */
static APTR PlrSelLV;           /*  Player listview gadget                  */
static APTR PlrSelReverseGad;   /*  Reverse button                          */
static APTR PlrSelSelGad;       /*  Select button                           */
void TerminatePlrSelWnd(void)

{ if (PlrSelWnd)
  { set(PlrSelWnd, MUIA_Window_Open, FALSE);
    DoMethod(App, OM_REMMEMBER, PlrSelWnd);
    MUI_DisposeObject(PlrSelWnd);
    PlrSelWnd = NULL;
  }
}
#endif




#ifdef AMIGA
/*
    The following function is automagically called from MUI, if a player
    will be displayed. (It's the displayhook of the player list.)

    Inputs: plr -   the player, that was selected.

    Result: a pointer to the players name
*/
SAVEDS ASM static LONG DispPlayerFunc(REG(a1) struct Player *plr,
				      REG(a2) char **array)

{ *array = plr->Name;
  return(0);
}
#ifdef AZTEC_C
#asm
		    xref    _geta4
_MyDispPlayerFunc:  move.l  a4,-(sp)
		    jsr     _geta4
		    move.l  a2,-(sp)
		    move.l  a1,-(sp)
		    jsr     _DispPlayerFunc
		    add.l   #8,sp
		    move.l  (sp)+,a4
		    rts
#endasm
extern LONG MyDispPlayerFunc(struct Player *, char **);
#define DispPlayerFunc MyDispPlayerFunc
#endif  /*  AZTEC_C */
struct Hook PlrSelWnd_PlrListDispHook =
{ {NULL, NULL}, (void *) DispPlayerFunc, NULL, NULL
};




/*
    The following function is called from MUI, to sort the players. It's
    the comparehook of the player list.

    Inputs: plr1, plr2 - the players whose names will be compared

    Result: < 0   plr1 alphabetically before plr2
	    = 0   plr1 alphabetically equal plr2
	    > 0   plr1 alphabetically after plr2
*/
SAVEDS ASM LONG CompPlayerFunc(REG(a1) struct Player *plr1,
			       REG(a2) struct Player *plr2)

{ return (Stricmp((STRPTR) plr1->Name, (STRPTR) plr2->Name));
}
#ifdef AZTEC_C
LONG MyCompPlayerFunc(struct Player *, struct Player *);
#asm
		    xref    _geta4
_MyCompPlayerFunc:  move.l  a4,-(sp)
		    jsr     _geta4
		    move.l  a2,-(sp)
		    move.l  a1,-(sp)
		    jsr     _CompPlayerFunc
		    add.l   #8,sp
		    move.l  (sp)+,a4
		    rts
#endasm
#define CompPlayerFunc MyCompPlayerFunc
#endif  /*  AZTEC_C */
struct Hook PlrSelWnd_PlrListCompHook =
  {{NULL, NULL}, (void *) CompPlayerFunc, NULL, NULL};
#endif  /*  AMIGA   */




/*
    The ProcessPlrSelWnd() function brings up a list of players and allows
    the user to select some.

    Inputs: wintitle    - Title of the window
	    buttontitle - title of the select button
	    buttonsc    - shortcut of the select button
	    flags       - Include only those players into the list, which
			  don't have one of flags set. (0 = Include all
			  players)
	    plrlist     - list, where the players should be read from

    Results: TRUE, if successfull, FALSE otherwise
	     The selected users will have TNFLAGSF_SELECTED set in their
	     flags field.
*/
#ifdef AMIGA
#define ID_PlrSelWnd_Cancel  300
#define ID_PlrSelWnd_Player  301
#define ID_PlrSelWnd_Select  302
#define ID_PlrSelWnd_PlrLV   303
#define ID_PlrSelWnd_Reverse 304
#define ID_PlrSelWnd_Ok      305

int ProcessPlrSelWnd(char *title, char *buttontitle, char buttonsc,
		     int flags, struct List *plrlist)

{ struct Player *plr;
  ULONG open;

  PlrSelWnd = WindowObject,
		MUIA_Window_Width, MUIV_Window_Width_MinMax(40),
		MUIA_Window_ID, MAKE_ID('P','L','R','S'),
		MUIA_Window_Title, title,
		WindowContents, VGroup,
		    Child, PlrSelLV = ListviewObject,
			MUIA_Listview_MultiSelect, TRUE,
			MUIA_Listview_List, ListObject,
			    MUIA_List_DisplayHook, &PlrSelWnd_PlrListDispHook,
			    MUIA_List_CompareHook, &PlrSelWnd_PlrListCompHook,
			    InputListFrame,
			End,
		    End,
		    Child, HGroup,
			Child, PlrSelSelGad = TextObject,
			    ButtonFrame,
			    MUIA_Text_Contents, buttontitle,
			    MUIA_Text_PreParse, "\33c",
			    MUIA_Text_SetMax, FALSE,
			    MUIA_Text_HiChar, (int) buttonsc,
			    MUIA_ControlChar, (int) buttonsc,
			    MUIA_InputMode, MUIV_InputMode_RelVerify,
			    MUIA_Background, MUII_ButtonBack,
			End,
			Child, HSpace(0),
			Child, PlrSelReverseGad = TextObject,
			    ButtonFrame,
			    MUIA_Text_Contents, Button_Reverse,
			    MUIA_Text_PreParse, "\33c",
			    MUIA_Text_SetMax, FALSE,
			    MUIA_Text_HiChar, *Button_Reverse_SC,
			    MUIA_ControlChar, *Button_Reverse_SC,
			    MUIA_InputMode, MUIV_InputMode_RelVerify,
			    MUIA_Background, MUII_ButtonBack,
			End,
			Child, HSpace(0),
			Child, PlrSelCancelGad = TextObject,
			    ButtonFrame,
			    MUIA_Text_Contents, MSG_CANCEL_INPUT,
			    MUIA_Text_PreParse, "\33c",
			    MUIA_Text_SetMax, FALSE,
			    MUIA_Text_HiChar, *MSG_CANCEL_SC,
			    MUIA_ControlChar, *MSG_CANCEL_SC,
			    MUIA_InputMode, MUIV_InputMode_RelVerify,
			    MUIA_Background, MUII_ButtonBack,
			End,
		    End,
		End,
	    End;

  if (!PlrSelWnd)
  { TerminatePlrSelWnd();
    return(FALSE);
  }
  DoMethod(App, OM_ADDMEMBER, PlrSelWnd);
  DoMethod(PlrSelWnd, MUIM_Window_SetCycleChain, PlrSelLV, PlrSelSelGad,
	   PlrSelCancelGad, NULL);
  set(PlrSelWnd, MUIA_Window_ActiveObject, PlrSelLV);

  /*
      Setting up the notification events for the player select window:
      CloseWindow, Ok- and Cancel Gadget and player list gadget.
  */
  DoMethod(PlrSelWnd, MUIM_Notify, MUIA_Window_CloseRequest, TRUE, App, 2,
	   MUIM_Application_ReturnID, ID_PlrSelWnd_Cancel);
  DoMethod(PlrSelCancelGad, MUIM_Notify, MUIA_Pressed, FALSE, App, 2,
	   MUIM_Application_ReturnID, ID_PlrSelWnd_Cancel);
  DoMethod(PlrSelSelGad, MUIM_Notify, MUIA_Pressed, FALSE,
	   App, 2, MUIM_Application_ReturnID, ID_PlrSelWnd_Ok);
  DoMethod(PlrSelReverseGad, MUIM_Notify, MUIA_Pressed, FALSE,
	   App, 2, MUIM_Application_ReturnID, ID_PlrSelWnd_Reverse);

  for (plr = (struct Player *) plrlist->lh_Head;
       plr->Tn_Node.ln_Succ != NULL;
       plr = (struct Player *) plr->Tn_Node.ln_Succ)
  { /*
	Make sure, that no players are selected yet.
    */
    plr->Flags &= ~TNFLAGSF_SELECTED;

    /*
	Insert those players in the list, that should be inserted.
    */
    if (!flags  ||  (plr->Flags & flags) == 0)
    { DoMethod(PlrSelLV, MUIM_List_Insert, &plr, 1, MUIV_List_Insert_Bottom);
    }
  }


  set(PlrSelWnd, MUIA_Window_Open, TRUE);
  get(PlrSelWnd, MUIA_Window_Open, &open);
  if (!open)
  { TerminatePlrSelWnd();
    return(0);
  }

  /*
      Check for user actions
  */
  for (;;)
  { ULONG Signal;
    LONG entries, i;

    switch (DoMethod(App, MUIM_Application_Input, &Signal))
    { case MUIV_Application_ReturnID_Quit:
	if (TestSaved())
	{ exit(0);
	}
	break;
      case ID_PlrSelWnd_Cancel:
	TerminatePlrSelWnd();
	return(0);
      case ID_PlrSelWnd_Ok:
	for (i = -1;;)
	{ DoMethod(PlrSelLV, MUIM_List_NextSelected, &i);
	  if (i == -1)
	  { TerminatePlrSelWnd();
	    return(TRUE);
	  }
	  DoMethod(PlrSelLV, MUIM_List_GetEntry, i, &plr);
	  plr->Flags |= TNFLAGSF_SELECTED;
	}
      case ID_PlrSelWnd_Reverse:
	set(PlrSelLV, MUIA_List_Quiet, TRUE);
	get(PlrSelLV, MUIA_List_Entries, &entries);
	for (i = 0;  i < entries;  i++)
	{ DoMethod(PlrSelLV, MUIM_List_Select, i, MUIV_List_Select_Toggle,
		   NULL);
	}
	set(PlrSelLV, MUIA_List_Quiet, FALSE);
	break;
    }

    if (Signal)
    { Wait(Signal);
    }
  }
}
#endif  /*  AMIGA   */

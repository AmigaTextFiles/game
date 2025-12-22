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


    $RCSfile: PairingsAmi.c,v $
    $Revision: 3.2 $
    $Date: 1994/11/19 19:32:01 $

    This file contains functions that allow to set games by the
    administrator. This is highly system dependent.

    Computer:   Amiga 1200                  Compiler:   Dice 2.07.54 (3.0)

    Author:     Jochen Wiedmann
		Am Eisteich 9
	  72555 Metzingen
		Tel. 07123 / 14881
		Internet: jochen.wiedmann@zdv.uni-tuebingen.de
*/



/*
    The function GetSettings() should offer the user a list of players
    and a list of games. Withdrawn players (which are indicated by the flag
    TNFLAGSF_WITHDRAWN in their Flags field) should not appear. Players may
    be included into the list of games by selecting them, so a game is set
    by selecting the two opponents. If the number of selected players is odd,
    the last player should get a point for free. (Of course this should be
    rejected, if the number of players is odd!) Note, that selecting the
    players doesn't mean deciding the colors. Chaos will select the colors
    even for the set games, which allows to make the best choice.

    Inputs: user - TRUE, if the user should be allowed to set games

    Result: The number of games, that have been set. (Giving a point for
	    free to a player doesn't mean to set up a game, so if the user
	    has selected 5 players, the result will be 2.) -1 indicates, that
	    the user has cancelled.
	    The function has to indicate the selection by setting up the
	    Opponents field of the selected players or setting
	    GMFLAGSF_NOFIGHT in the GFlags field for the player who has got
	    a point for free.
	    The function is guaranteed, that all players Opponent fields are
	    initialized to NULL and the GFlags fiels is initialized with 0,
	    when the function is called. If you need flags, to mark special
	    players within the function, use TNFLAGSF_NOTDOWN.

    Note: I don't see a possibility to arrange this in a portable way. So
	  this is only ONE function. (But this allows me to use ALL the
	  advantages of MUI for the first time... :-)
*/


#ifndef CHAOS_H
#include "chaos.h"
#endif




#ifdef AMIGA
/*
    The set games are stored dynamically.
*/
struct SetGame
{ struct MinNode node;
  struct Player *plr1, *plr2;
  char *gamestr;
  int colors;
};
struct MinList *SetGames = NULL;
static void *GmMem = NULL;




/*
    InitSetGames() initializes an empty list of games

    Result: TRUE, if successfull, FALSE otherwise
*/
int InitSetGames(void)

{ PutMemList (&GmMem);
  if (!(SetGames = GetMem(&GmMem, sizeof(*SetGames))))
  { return(FALSE);
  }
  NewList((struct List *) SetGames);
  return(TRUE);
}




/*
    SetPlayer adds one player to the list of set players

    Inputs: plr    - the player to be added
	    colors - TRUE, if the user wants to determine the colors, FALSE
		     otherwise
	    force  - FALSE, if the user should be asked for confirmation
		     in case both players had the same color in the last
		     two rounds, TRUE otherwise

    Result: TRUE, if successfull, FALSE otherwise
*/
int SetPlayer(struct Player *plr, int force, int colors)

{ struct SetGame *sg;
  struct Game *gm;
  int i;

  if (!SetGames  &&  !InitSetGames())
  { return(FALSE);
  }

  if (plr->Flags & TNFLAGSF_WITHDRAWN)
  { ShowError((char *) MSG_PLAYER_WITHDRAWN, plr->Name);
    return(FALSE);
  }
  for (sg = (struct SetGame *) SetGames->mlh_Head;
       sg->node.mln_Succ != NULL;
       sg = (struct SetGame *) sg->node.mln_Succ)
  { if (sg->plr1 == plr  ||  sg->plr2 == plr)
    { ShowError((char *) MSG_INVALID_PLAYER, plr->Name,
		plr->Opponent->Name);
      return(FALSE);
    }
  }

  /*
      Check for valid game
  */
  sg = (struct SetGame *) SetGames->mlh_TailPred;
  if (sg->node.mln_Pred != NULL  &&  sg->plr2 == NULL)
  { for (i = 1, gm = plr->First_Game;  gm != NULL;
	 i++, gm = gm->Next)
    { if (gm->Opponent == sg->plr1)
      { ShowError((char *) MSG_INVALID_GAME,
		  sg->plr1->Name, plr->Name, i);
	return(FALSE);
      }
    }

    if ((i = sg->plr1->HowMuchWhiteLast) == plr->HowMuchWhiteLast  &&
	(i >= 2  ||  i <= -2))
    { if (!force  &&
	  !AskContinue((char *) MSG_INVALID_COLORS,
		       sg->plr1->Name, plr->Name,
		       (i == 2) ? MSG_WHITE_OUTPUT :
				  MSG_BLACK_OUTPUT))
      { return(FALSE);
      }
    }
    else if (i >= 2  &&  colors)
    { if (!force  &&
	  !AskContinue((char *) MSG_INVALID_COLOR,
		       sg->plr1->Name, MSG_WHITE_OUTPUT))
      { return(FALSE);
      }
    }
    else if (plr->HowMuchWhiteLast <= -2  &&  colors)
    { if (!force  &&
	  !AskContinue((char *) MSG_INVALID_COLOR,
		       plr->Name, MSG_BLACK_OUTPUT))
      { return(FALSE);
      }
    }
    sg->plr2 = plr;
    sg->colors = colors;
  }
  else
  { if (!(sg = GetMem(&GmMem, sizeof(*sg))))
    { return(FALSE);
    }
    sg->plr1 = plr;
    AddTail((struct List *) SetGames, (struct Node *) sg);
  }
  return(TRUE);
}




/*
    The DoSetGames() function processes the list of set games and initializes
    the players Opponent and GFlags fields.

    Result: Number of set games or -1, if an error occurred
*/
static int DoSetGames(void)

{ struct SetGame *sg;
  int numplayers;
  int result;

  struct Player *plr;

  if (SetGames == NULL)
  { return(0);
  }

  /*
      Count the number of active players to see, if a one point bye is
      needed.
  */
  for (numplayers = 0,  plr = (struct Player *) PlayerList.lh_Head;
       plr->Tn_Node.ln_Succ != NULL;
       plr = (struct Player *) plr->Tn_Node.ln_Succ)
  { if (!(plr->Flags & TNFLAGSF_WITHDRAWN))
    { numplayers++;
    }
  }

  /*
      Check for invalid one point bye
  */
  sg = (struct SetGame *) SetGames->mlh_TailPred;
  if (sg->node.mln_Pred != NULL  &&  sg->plr2 == NULL)
  { if ((numplayers % 2)  ==  0)
    { ShowError((char *) MSG_INVALID_ONEPOINTBYE);
      return(-1);
    }
    if (sg->plr1->Flags & TNFLAGSF_HADFREE)
    { ShowError((char *) MSG_HAD_ONEPOINTBYE,
		sg->plr1->Name);
      return(-1);
    }
  }

  for (result = 0, sg = (struct SetGame *) SetGames->mlh_Head;
       sg->node.mln_Succ != NULL;
       sg = (struct SetGame *) sg->node.mln_Succ)
  { if (sg->plr2 == NULL)
    { sg->plr1->GFlags = GMFLAGSF_NOFIGHT;
    }
    else
    { sg->plr1->Opponent = sg->plr2;
      sg->plr2->Opponent = sg->plr1;
      sg->plr1->BoardNr = sg->plr2->BoardNr = result++;
      if (sg->colors)
      { sg->plr1->GFlags = GMFLAGSF_WHITE;
      }
    }
  }
  return(result);
}




/*
    The following function is automagically called from MUI, if a game will
    be displayed. (It's the game list's displayhook.)
*/
SAVEDS ASM static LONG DispGameFunc(REG(a1) struct SetGame *setgame,
				    REG(a2) char **array)

{ *(array++) = setgame->plr1->Name;
  *(array++) = setgame->plr2  ?  ":"  :  "";
  *(array++) = setgame->plr2  ?   setgame->plr2->Name :
			      (char *) MSG_FREE_POINT_OUTPUT;
  *array = (setgame->plr2 && setgame->colors)  ?
		    (char *) MSG_COLORS_SET  :  "";
  return(0);
}
#ifdef AZTEC_C
extern LONG MyDispGameFunc(struct SetGame *, char **);
#asm
		    xref    _geta4
_MyDispGameFunc:    move.l  a4,-(sp)
		    jsr     _geta4
		    move.l  a2,-(sp)
		    move.l  a1,-(sp)
		    jsr     _DispGameFunc
		    add.l   #8,sp
		    move.l  (sp)+,a4
		    rts
#endasm
#define DispGameFunc MyDispGameFunc
#endif  /*  AZTEC_C */
struct Hook GmStWnd_GmListDispHook =
{ NULL, NULL, (void *) DispGameFunc, NULL, NULL
};




#define ID_GmStWnd_Ok       8
#define ID_GmStWnd_Cancel   9
#define ID_GmStWnd_PlrLV    10
#define ID_GmStWnd_GmDel    11
#define ID_GmStWnd_GmLV     12

int GetSettings(int user)

{ struct Player *plr;
  ULONG open, signal;
  int result = -1;
  struct SetGame *sg;
  APTR GmStWnd = NULL;      /*  Game set window                     */
  APTR GmStWnd_OkGad;       /*  Ok gadget (game set window)         */
  APTR GmStWnd_CancelGad;   /*  Cancel gadget (game set window)     */
  APTR GmStWnd_PlrList;     /*  player list (game set window)       */
  APTR GmStWnd_PlrLV;       /*  player listview gad. (game set wnd.)*/
  APTR GmStWnd_GmLV;        /*  game listview gadget (game set wnd.)*/
  APTR GmStWnd_GmDel;       /*  delete button (game set window)     */
  APTR GmStWnd_Clrs;        /*  Color mode gadget                   */
  char *CycleEntries[3];
  int Ok_SC = *MSG_OK_SC;
  int Cancel_SC = *MSG_CANCEL_SC;
  int Delete_SC = *BUTTON_DELETE_SC;

  extern struct Hook PlrSelWnd_PlrListDispHook;
  extern struct Hook PlrSelWnd_PlrListCompHook;


  if (!user)
  { result = DoSetGames();
    goto Terminate;
  }

  CycleEntries[0] = (char *) CYCLE_CHAOSCOLORS;
  CycleEntries[1] = (char *) CYCLE_USERCOLORS;
  CycleEntries[2] = NULL;

  GmStWnd = WindowObject,
		MUIA_Window_ID, MAKE_ID('G','M','S','T'),
		MUIA_Window_Title, WND_GAMESET_TITLE,
		MUIA_Window_Width, MUIV_Window_Width_MinMax(50),
		WindowContents, VGroup,
		    Child, HGroup,
			Child, VGroup,
			    Child, GmStWnd_PlrLV = ListviewObject,
				MUIA_Listview_List, GmStWnd_PlrList = ListObject,
				    MUIA_List_Format, "",
				    MUIA_List_DisplayHook, &PlrSelWnd_PlrListDispHook,
				    MUIA_List_CompareHook, &PlrSelWnd_PlrListCompHook,
				    InputListFrame,
				End,
			    End,
			    Child, GmStWnd_Clrs = Cycle(CycleEntries),
			 End,
			 Child, VGroup,
			    MUIA_Weight, 400,
			    Child, GmStWnd_GmLV = ListviewObject,
				MUIA_Listview_List, ListObject,
				    MUIA_List_Format, ",P=\33c,,",
				    MUIA_List_DisplayHook, &GmStWnd_GmListDispHook,
				    InputListFrame,
				End,
			    End,
			    Child, HGroup,
				Child, HSpace(0),
				Child, GmStWnd_GmDel = KeyButton(BUTTON_DELETE_TITLE, Delete_SC),
			    End,
			 End,
		    End,
		    Child, HGroup,
			MUIA_Group_SameSize, TRUE,
			Child, GmStWnd_OkGad = KeyButton(MSG_OK, Ok_SC),
			Child, HSpace(0),
			Child, GmStWnd_CancelGad = KeyButton(MSG_CANCEL_INPUT, Cancel_SC),
		    End,
		End,
	    End;

  if (!GmStWnd)
  { return(-1);
  }
  DoMethod(App, OM_ADDMEMBER, GmStWnd);
  DoMethod(GmStWnd, MUIM_Window_SetCycleChain, GmStWnd_PlrLV, GmStWnd_GmLV,
	   GmStWnd_GmDel, GmStWnd_OkGad, GmStWnd_CancelGad,
	   NULL);
  set(GmStWnd, MUIA_Window_ActiveObject, GmStWnd_PlrLV);

  /*
      Setting up the notification events for the game set window:
      CloseWindow, Ok-, Cancel- and Delete-buttons and the listview
      gadgets
  */
  DoMethod(GmStWnd, MUIM_Notify, MUIA_Window_CloseRequest, TRUE, App,
	   2, MUIM_Application_ReturnID, ID_GmStWnd_Cancel);
  DoMethod(GmStWnd_CancelGad, MUIM_Notify, MUIA_Pressed, FALSE, App, 2,
	   MUIM_Application_ReturnID, ID_GmStWnd_Cancel);
  DoMethod(GmStWnd, MUIM_Notify, MUIA_Window_InputEvent, "ctrl return",
	   App, 2, MUIM_Application_ReturnID, ID_GmStWnd_Ok);
  DoMethod(GmStWnd_OkGad, MUIM_Notify, MUIA_Pressed, FALSE, App, 2,
	   MUIM_Application_ReturnID, ID_GmStWnd_Ok);
  DoMethod(GmStWnd_GmDel, MUIM_Notify, MUIA_Pressed, FALSE, App, 2,
	   MUIM_Application_ReturnID, ID_GmStWnd_GmDel);
  DoMethod(GmStWnd_PlrLV, MUIM_Notify, MUIA_Listview_DoubleClick, TRUE, App,
	   2, MUIM_Application_ReturnID, ID_GmStWnd_PlrLV);
  DoMethod(GmStWnd_GmLV, MUIM_Notify, MUIA_List_Active, MUIV_EveryTime,
	   App, 2, MUIM_Application_ReturnID, ID_GmStWnd_GmLV);


  /*
      Initialize the list of games
  */
  if (SetGames == NULL  &&  !InitSetGames())
  { goto Terminate;
  }
  for (sg = (struct SetGame *) SetGames->mlh_Head;
       sg->node.mln_Succ != NULL;
       sg = (struct SetGame *) sg->node.mln_Succ)
  { DoMethod(GmStWnd_GmLV, MUIM_List_Insert, &sg, 1, MUIV_List_Insert_Bottom);
  }


  /*
      Initialize the player list
  */
  for (plr = (struct Player *) PlayerList.lh_Head;
       plr->Tn_Node.ln_Succ != NULL;
       plr = (struct Player *) plr->Tn_Node.ln_Succ)
  { if ((plr->Flags & TNFLAGSF_WITHDRAWN)  ==  0)
    { for (sg = (struct SetGame *) SetGames->mlh_Head;
	   sg->node.mln_Succ != NULL;
	   sg = (struct SetGame *) sg->node.mln_Succ)
      { if (sg->plr1 == plr  ||  sg->plr2 == plr)
	{ break;
	}
      }
      if (sg->node.mln_Succ ==  NULL)
      { DoMethod(GmStWnd_PlrLV, MUIM_List_Insert, &plr, 1,
		 MUIV_List_Insert_Bottom);
      }
    }
  }


  /*
      Open the window
  */
  set(GmStWnd_GmLV, MUIA_List_Active, MUIV_List_Active_Bottom);
  set(GmStWnd, MUIA_Window_Open, TRUE);
  get(GmStWnd, MUIA_Window_Open, &open);
  if (!open)
  { MUIError((char *) ERRMSG_CANNOT_OPEN_WINDOW);
    goto Terminate;
  }

  /*
      Wait for user actions
  */
  for(;;)
  { int colors;

    switch(DoMethod(App, MUIM_Application_Input, &signal))
    { case MUIV_Application_ReturnID_Quit:
	if (TestSaved())
	{ exit(0);
	}
	break;
      case ID_GmStWnd_Ok:
	if ((result = DoSetGames())  ==  -1)
	{ break;
	}
	goto Terminate;
      case ID_GmStWnd_Cancel:
	goto Terminate;
      case ID_GmStWnd_PlrLV:
	/*
	    Get the active player
	*/
	DoMethod(GmStWnd_PlrLV, MUIM_List_GetEntry,
		 MUIV_List_GetEntry_Active, &plr);
	get(GmStWnd_Clrs, MUIA_Cycle_Active, &colors);

	if (!SetPlayer(plr, FALSE, colors))
	{ break;
	}

	/*
	    Remove him from the list of players
	*/
	DoMethod(GmStWnd_PlrLV, MUIM_List_Remove, MUIV_List_Remove_Active);

	sg = (struct SetGame *) SetGames->mlh_TailPred;
	if (sg->plr2 == plr)
	{ DoMethod(GmStWnd_GmLV, MUIM_List_Remove, MUIV_List_Remove_Last);
	}
	DoMethod(GmStWnd_GmLV, MUIM_List_Insert, &sg, 1,
		 MUIV_List_Insert_Bottom);
	set(GmStWnd_GmLV, MUIA_List_Active, MUIV_List_Active_Bottom);
	break;
      case ID_GmStWnd_GmDel:
	/*
	    Get the active game from the list of games
	*/
	DoMethod(GmStWnd_GmLV, MUIM_List_GetEntry,
		 MUIV_List_GetEntry_Active, &sg);
	if (sg == NULL)
	{ break;
	}

	/*
	    Remove it from the list
	*/
	DoMethod(GmStWnd_GmLV, MUIM_List_Remove, MUIV_List_Remove_Active);
	Remove((struct Node *) sg);

	/*
	    Add the players into the list of players
	*/
	set(GmStWnd_PlrLV, MUIA_List_Quiet, TRUE);
	DoMethod(GmStWnd_PlrLV, MUIM_List_Insert, &sg->plr1, 1,
		 MUIV_List_Insert_Sorted);
	if (sg->plr2 != NULL)
	{ DoMethod(GmStWnd_PlrLV, MUIM_List_Insert, &sg->plr2, 1,
		   MUIV_List_Insert_Sorted);
	}
	set(GmStWnd_PlrLV, MUIA_List_Quiet, FALSE);
	break;
      case ID_GmStWnd_GmLV:
	DoMethod(GmStWnd_GmLV, MUIM_List_GetEntry, MUIV_List_GetEntry_Active,
		 &sg);
	set(GmStWnd_GmDel, MUIA_Disabled, sg == NULL);
	break;
    }

    if (signal)
    { Wait(signal);
    }
  }


Terminate:
  if (GmStWnd)
  { set(GmStWnd, MUIA_Window_Open, FALSE);
    DoMethod(App, OM_REMMEMBER, GmStWnd);
    MUI_DisposeObject(GmStWnd);
  }
  PutMemList(&GmMem);
  SetGames = NULL;
  return(result);
}
#endif  /*  AMIGA   */

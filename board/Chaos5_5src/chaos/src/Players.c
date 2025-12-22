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


    $RCSfile: Players.c,v $
    $Revision: 3.2 $
    $Date: 1994/10/14 09:44:02 $

    This file contains the functions of the Players-menu.

    Computer:   Amiga 1200                  Compiler:   Dice 2.07.54 (3.0)

    Author:     Jochen Wiedmann
		Am Eisteich 9
	  72555 Metzingen
		Phone: 07123 / 14881
		Internet: jochen.wiedmann@zdv.uni-tuebingen.de
*/


#ifndef CHAOS_H
#include "chaos.h"
#endif
#include <time.h>




/*
    InsertPlayer inserts a player into the alphabetically sorted list of
    players.

    Inputs: plrlist - pointer to the list, where the player should be
		      inserted
	    tn      - pointer to the Player structure of the new player
*/
static void InsertPlayer (struct List *plrlist, struct Player *tn)

{ struct Player *node;

  for (node = (struct Player *) PlayerList.lh_Head;
       node->Tn_Node.ln_Succ != NULL;
       node = (struct Player *) node->Tn_Node.ln_Succ)
  { if (Stricmp((STRPTR) tn->Name, (STRPTR) node->Name) < 0)
    { break;
    }
  }
  Insert(&PlayerList, (struct Node *) tn, node->Tn_Node.ln_Pred);
}




/*
    This function removes preceding blanks from a string.

    Inputs: str     - a pointer to the string, where the blanks should
		      be removed

    Result: a pointer to the first nonblank character in str (may be \0!)
*/
static char *WithoutBlanks(char *str)

{ if (str != NULL)
  { while (*str == ' ')
    { ++str;
    }
  }
  return(str);
}




/*
    CheckPlayerValid() checks, if a players data is valid.

    Inputs: plr     - a pointer to the player structure
	    user    - TRUE, if an error message may be shown to the user

    Result: TRUE, if the player is valid, FALSE otherwise

    Note: This functions assumes, that plr is not included in PlayerList!
*/
int CheckPlayerValid(struct Player *plr, int user)

{ struct Player *cmpplr;
  char *birthday = WithoutBlanks(plr->BirthDay);
  char *name = WithoutBlanks(plr->Name);
  struct tm tm;


  /*
      Check if the players name and birthday are valid
  */
  if (*WithoutBlanks(name) == '\0')
  { if (user)
    { ShowError((char *) MSG_MISSING_PLAYER_NAME);
    }
    return(FALSE);
  }
  if (*birthday != '\0'  &&  !atotm(birthday, &tm))
  { if (user)
    { ShowError((char *) MSG_BIRTHDAY_ERROR);
    }
    return(FALSE);
  }


  /*
      Check, if the players name is unique.
  */
  for (cmpplr = (struct Player *) PlayerList.lh_Head;
       cmpplr->Tn_Node.ln_Succ != NULL;
       cmpplr = (struct Player *) cmpplr->Tn_Node.ln_Succ)
  { if (Stricmp((STRPTR) cmpplr->Name, (STRPTR) name) == 0)
    { if (user)
      { ShowError((char *) MSG_PlayerExists, plr->Name);
      }
      return(FALSE);
    }
  }
  return(TRUE);
}





/*
    The AddPlayer() function adds a new player to the list of players.
    It is assumed, that CheckPlayer() and CheckPlayerNameUnique() are
    already called.

    Inputs: plr     a pointer to a player structure

    Results:    TRUE, if successfull, FALSE otherwise
*/
int AddPlayer(struct Player *plr)

{ struct Player *newplr, **plrptr;
  struct Game *game;

  /*
      Allocate memory for the new player
  */
  if ((newplr = GetMem(&TrnMem, sizeof(*newplr)))  ==  NULL)
  { return(FALSE);
  }

  /*
      Initialize data
  */
  strcpy(newplr->Name, WithoutBlanks(plr->Name));
  strcpy(newplr->Street, WithoutBlanks(plr->Street));
  strcpy(newplr->Village, WithoutBlanks(plr->Village));
  strcpy(newplr->PhoneNr, WithoutBlanks(plr->PhoneNr));
  strcpy(newplr->ChessClub, WithoutBlanks(plr->ChessClub));
  strcpy(newplr->BirthDay, WithoutBlanks(plr->BirthDay));
  strcpy(newplr->DWZ, WithoutBlanks(plr->DWZ));
  newplr->ELO = plr->ELO;
  newplr->Flags = plr->Flags & (TNFLAGSF_SENIOR|TNFLAGSF_JUNIOR|
				TNFLAGSF_WOMAN|TNFLAGSF_JUNIORA|
				TNFLAGSF_JUNIORB|TNFLAGSF_JUNIORC|
				TNFLAGSF_JUNIORD|TNFLAGSF_JUNIORE);
  newplr->Tn_Node.ln_Name = newplr->Name;
  newplr->Tn_Node.ln_Type = (UBYTE) -1;
  newplr->Tn_Node.ln_Pri = 0;

  /*
      The Swiss Pairing allows adding players, until round 1 is finished.
      Possibly we have to select an opponent.
  */
  if(NumRounds > 0)
  { /*
	Allocate a Game structure
    */
    if  ((game = newplr->First_Game = GetMem(&TrnMem, sizeof(*game)))
	       ==  NULL)
    { PutMem(newplr);
      return(FALSE);
    }
    game->BoardNr = NumPlayers / 2;

    /*
	Add the new player to the bottom of the internal rankings.
    */
    for (plrptr = &RankingFirst; *plrptr != NULL;
	 plrptr = &((*plrptr)->RankNext))
    {
    }
    *plrptr = newplr;

    /*
	If the number of players was odd, the new players opponent will
	be the player, who had a point for free.
    */
    if ((NumPlayers % 2) != 0)
    { struct Player *opponent;

      for (opponent = RankingFirst;
	   (opponent->Flags & TNFLAGSF_HADFREE) == 0;
	   opponent = opponent->RankNext)
      {
      }

      opponent->Flags &= ~TNFLAGSF_HADFREE;
      game->Opponent = opponent;
      game->Result = -1;
      game->Flags = (RangeRand(2) == 0)  ?  GMFLAGSF_WHITE : 0;
      newplr->HowMuchWhite = newplr->HowMuchWhiteLast =
			     game->Flags  ?  1 : -1;

      game = opponent->First_Game;
      game->Opponent = newplr;
      game->Result = -1;
      game->BoardNr = newplr->First_Game->BoardNr;
      game->Flags = GMFLAGSF_WHITE-newplr->First_Game->Flags;
      opponent->HowMuchWhite = opponent->HowMuchWhiteLast =
			       game->Flags  ? 1 : -1;
      opponent->Points = 0;
      NumGamesMissing++;
    }
    /*
	The new player gets a point for free, if the number of players
	was even.
    */
    else
    { newplr->Flags |= TNFLAGSF_HADFREE;
      newplr->Points = WinnerPoints;
      game->Result = 2;
      game->Flags = GMFLAGSF_POINTFORFREE|GMFLAGSF_NOFIGHT;
    }
  }

  InsertPlayer(&PlayerList, newplr);
  NumPlayers++;

  IsSaved = FALSE;
  return(TRUE);
}




/*
    The AddPlayers() function allows the user to enter new players.
*/
void AddPlayers(void)

{ struct Player plr;
  int new = TRUE;

  /*
      Check, if we may enter new players.
  */
  if (NumRounds >= 1 &&  RoundRobinTournament)
  { ShowError((char *) MSG_NO_NEW_PLAYERS_ROUND_ROBIN);
    return;
  }
  if (NumRounds > 1  &&  SwissPairingTournament)
  { ShowError((char *) MSG_NO_NEW_PLAYERS_SWISS_PAIR);
    return;
  }
  if (NumRounds > 0)
  { if (!AskContinue((char *) MSG_NEW_PLAYER_REQUEST))
    { return;
    }
  }

  if (!InitPlrWnd((char *) WND_PLAYER_ADD_TITLE))
  { return;
  }

  memset(&plr, 0, sizeof(plr));
  for (;;)
  { if (!ProcessPlrWnd(&plr, new))
    { break;
    }
    new = FALSE;

    if (CheckPlayerValid(&plr, TRUE))
    { if (!AddPlayer(&plr))
      { break;
      }

      memset(&plr, 0, sizeof(plr));
      new = TRUE;
    }
  }
  TerminatePlrWnd();
}





/*
    The InportPlayers() function allows to add players from a previous
    tournament.
*/
void ImportPlayers(void)

{ void *PlrMem = NULL;
  struct List ImportPlayerList;

  /*
      Check, if we may enter new players.
  */
  if (NumRounds >= 1 &&  RoundRobinTournament)
  { ShowError((char *) MSG_NO_NEW_PLAYERS_ROUND_ROBIN);
    return;
  }
  if (NumRounds > 1  &&  SwissPairingTournament)
  { ShowError((char *) MSG_NO_NEW_PLAYERS_SWISS_PAIR);
    return;
  }
  if (NumRounds > 0)
  { if (!AskContinue((char *) MSG_NEW_PLAYER_REQUEST))
    { return;
    }
  }

  if (LoadTournament(NULL, &PlrMem, &ImportPlayerList)  ==  RETURN_OK)
  { if (ProcessPlrSelWnd((char *) MSG_ImportPlayersWinTitle,
			 (char *) MSG_ImportPlayersOkButton,
			 *(char *) MSG_ImportPlayersOkButtonSC,
			 0, &ImportPlayerList))
    { struct Player *plr;

      for (plr = (struct Player *) ImportPlayerList.lh_Head;
	   plr->Tn_Node.ln_Succ != NULL;
	   plr = (struct Player *) plr->Tn_Node.ln_Succ)
      { if (plr->Flags & TNFLAGSF_SELECTED)
	{ while(!CheckPlayerValid(plr, TRUE))
	  { if (!ModifyOnePlayer(plr, TRUE))
	    { goto Terminate;
	    }
	  }
	}
      }

      for (plr = (struct Player *) ImportPlayerList.lh_Head;
	   plr->Tn_Node.ln_Succ != NULL;
	   plr = (struct Player *) plr->Tn_Node.ln_Succ)
      {
	if ((plr->Flags & TNFLAGSF_SELECTED)  &&  !AddPlayer(plr))
	{ break;
	}
      }
    }
  }

Terminate:
  PutMemList(&PlrMem);
}





/*
    The ModifyPlayer() function modifys one player. This function assumes,
    that CheckPlayer() and CheckPlayerNameUnique() are already called.
*/
void ModifyPlayer(struct Player *old, struct Player *new)

{
  Remove(&old->Tn_Node);
  memcpy(old, new, sizeof(*old));
  strcpy(old->Name, WithoutBlanks(old->Name));
  strcpy(old->Street, WithoutBlanks(old->Street));
  strcpy(old->Village, WithoutBlanks(old->Village));
  strcpy(old->PhoneNr, WithoutBlanks(old->PhoneNr));
  strcpy(old->ChessClub, WithoutBlanks(old->ChessClub));
  strcpy(old->BirthDay, WithoutBlanks(old->BirthDay));
  strcpy(old->DWZ, WithoutBlanks(old->DWZ));
  InsertPlayer(&PlayerList, old);
  IsSaved = FALSE;
}




/*
    ModifyOnePlayer() allows to modify one player.

    Inputs: plr     - a pointer to the player structure
	    initwin - a flag which indicates, if the player window needs
		      to be initialized

    Result: TRUE, if successfull, FALSE otherwise
*/
int ModifyOnePlayer(struct Player *plr, int initwin)

{ int result = 0;

  if (!initwin  ||
      InitPlrWnd((char *) WND_PLAYER_MODIFY_TITLE))
  { int new = TRUE;
    struct Player modifiedplr;

    memcpy(&modifiedplr, plr, sizeof(modifiedplr));
    do
    { if (!ProcessPlrWnd(&modifiedplr, new))
      { goto Terminate;
      }


      Remove((struct Node *) plr);
      result = CheckPlayerValid(&modifiedplr, TRUE);
      Insert((struct List *) &PlayerList, (struct Node *) plr,
	     plr->Tn_Node.ln_Pred);
    }
    while (!result);

    ModifyPlayer(plr, &modifiedplr);
  }

Terminate:
  if (initwin)
  { TerminatePlrWnd();
  }
  return(result);
}





/*
    ModifyPlayers() is called from the menu to modify player data.
*/
void ModifyPlayers(void)

{
  /*
      Check, if we really may modify players
  */
  if (NumRounds > 0)
  { if (!AskContinue((char *) MSG_MODIFY_PLAYER_REQUEST))
    { return;
    }
  }

  if (ProcessPlrSelWnd((char *) WND_PLAYER_MODSEL_TITLE,
		       (char *) BUTTON_MODIFY_TITLE,
		       *(char *) BUTTON_MODIFY_SC, 0,
		       &PlayerList))
  { if (InitPlrWnd((char *) WND_PLAYER_MODIFY_TITLE))
    { struct Player *plr;

      /*
	  Copy the old link pointers, because they may be changed when
	  calling ModifyPlayer()!
      */
      for (plr = (struct Player *) PlayerList.lh_Head;
	   plr->Tn_Node.ln_Succ != NULL;
	   plr = (struct Player *) plr->Tn_Node.ln_Succ)
      { if (((struct Player *) plr->Tn_Node.ln_Succ)->Tn_Node.ln_Succ != NULL)
	{ plr->Helpptr = (struct Player *) plr->Tn_Node.ln_Succ;
	}
	else
	{ plr->Helpptr = NULL;
	}
      }


      for (plr = (struct Player *) PlayerList.lh_Head;
	   plr != NULL;
	   plr = plr->Helpptr)
      { if (plr->Flags & TNFLAGSF_SELECTED)
	{ if(!ModifyOnePlayer(plr, FALSE))
	  { TerminatePlrWnd();
	    return;
	  }
	}
      }

      TerminatePlrWnd();
    }
  }
}




/*
    The DeletePlayer() function deletes one player or marks him as
    withdrawn.
*/
void DeletePlayer(struct Player *plr)

{
  if (NumRounds == 0)
  { Remove(&plr->Tn_Node);
    PutMem(plr);
    NumPlayers--;
  }
  else
  { plr->Flags |= TNFLAGSF_WITHDRAWN;
  }
  IsSaved = FALSE;
}




/*
    DeletePlayers() allows deleting of players or marking them as withdrawn.
    It uses the player selection functions.
*/
void DeletePlayers(void)

{
  /*
      Check, if we really may delete players
  */
  if (NumRounds > 0  &&  RoundRobinTournament)
  { ShowError((char *) MSG_NO_PLAYER_DELETE);
    return;
  }
  if (NumRounds > 0)
  { if (!AskContinue((char *) MSG_DELETE_PLAYER_REQUEST))
    { return;
    }
  }

  if (ProcessPlrSelWnd((char *) WND_PLAYER_DELSEL_TITLE,
		       (char *) BUTTON_DELETE_TITLE,
		       *(char *) BUTTON_DELETE_SC,
		       TNFLAGSF_WITHDRAWN, &PlayerList))
  { struct Player *plr, *next;

    for (plr = (struct Player *) PlayerList.lh_Head;
	 plr->Tn_Node.ln_Succ  !=  NULL;
	 plr = (struct Player *) plr->Tn_Node.ln_Succ)
    { if (plr->Flags & TNFLAGSF_SELECTED)
      { int Result;

	Result = (NumRounds == 0)  ?
		    AskExtContinue((char *)
			MSG_DELETE_THIS_PLAYER_REQUEST,
				  (char *)
			BUTTONS_DELETE_THIS_PLAYER_REQUEST,
			plr->Name)
				   :
		    AskExtContinue((char *)
			MSG_THIS_PLAYER_GONE_REQUEST,
				   (char *)
			BUTTONS_THIS_PLAYER_GONE_REQUEST,
			plr->Name);

	switch(Result)
	{ case 1:   /*  "Delete him" or "Withdraw him" button   */
	    break;
	  case 2:   /*  "Skip him"                     button   */
	    plr->Flags &= ~TNFLAGSF_SELECTED;
	    break;
	  case 0:
	    return; /*  "Cancel"                       button   */
	}
      }
    }

    /*
	Note, that plr may be no longer valid after calling DeletePlayer()!
	(That's why we use the next pointer.)
    */
    for (plr = (struct Player *) PlayerList.lh_Head;
	 (next = (struct Player *) plr->Tn_Node.ln_Succ)  !=  NULL;
	 plr = next)
    { if (plr->Flags & TNFLAGSF_SELECTED)
      { DeletePlayer(plr);
      }
    }
  }
}

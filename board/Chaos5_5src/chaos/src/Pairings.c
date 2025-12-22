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


    $RCSfile: Pairings.c,v $
    $Revision: 3.3 $
    $Date: 1994/12/03 18:02:26 $

    This file contains the pairing-functions. The algorithm of the
    swiss-pairing is described in the function LoseGroup().

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
    GameAddress() returns the address of a game-structure.

    Inputs: t - player, whose game list will be searched
	    r - number of the round, which's game structure will be
		returned. This may be 0, in which case the address of
		t->First_Game will be returned.

    Result: pointer to the game structure corresponding to player t, round r
*/
struct Game *GameAddress(struct Player *t, int r)

{ struct Game *g;

  for (g = (struct Game *) &(t->First_Game);  r != 0;
       g = g->Next, r--)
  {
  }
  return(g);
}



/*
    The NewGames() function gets called after each round that has been
    paired. It assumes, that each players Opponent, GFlags and BoardNr fields
    are initialized.

    Inputs: memlistptr - pointer to the memory list, where the allocated
			 memory will be included.
	    fpoints    - number of points, that free players will receive
			 (2 for swiss pairing, 0 for round robin)

    Result: TRUE, if successful, FALSE otherwise
*/
static int NewGames(void **memlistptr, int fpoints)

{ struct Game *g, *gmem;
  struct Player *t;
  int NumGames = 0;

  /*
      Allocate new game structures.
  */
  if ((gmem = GetMem(memlistptr, sizeof(*g)*NumPlayers))  ==  NULL)
  { return(FALSE);
  }
  NumRounds++;

  /*
      Initialize the game structures.
  */
  for (t = ((struct Player *) PlayerList.lh_Head), g = gmem;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ, g++)
  { if (t->Flags & TNFLAGSF_WITHDRAWN)
    { t->GFlags |= GMFLAGSF_NOFIGHT;
    }
    else if (t->Opponent == NULL)
    { t->GFlags |= GMFLAGSF_NOFIGHT|GMFLAGSF_POINTFORFREE;
    }

    GameAddress(t, NumRounds-1)->Next = g;

    g->Next = NULL;
    g->Opponent = t->Opponent;
    g->Flags = t->GFlags;
    g->BoardNr = t->BoardNr;

    if (g->Flags & GMFLAGSF_NOFIGHT)
    { if (t->Flags & TNFLAGSF_WITHDRAWN)
      { g->Result = 0;
	g->Flags = GMFLAGSF_WITHDRAWN;
      }
      else
      { t->Points += fpoints;
	g->Result = fpoints;
	t->Flags |= TNFLAGSF_HADFREE;
      }
    }
    else
    { NumGames++;
      g->Result = -1;
      if (g->Flags & GMFLAGSF_WHITE)
      { t->HowMuchWhite++;
	if (t->HowMuchWhiteLast > 0)
	{ t->HowMuchWhiteLast++;
	}
	else
	{ t->HowMuchWhiteLast = 1;
	}
      }
      else
      { t->HowMuchWhite--;
	if (t->HowMuchWhiteLast < 0)
	{ t->HowMuchWhiteLast--;
	}
	else
	{ t->HowMuchWhiteLast = -1;
	}
      }
    }
  }

  NumGamesMissing = NumGames/2;
  return(TRUE);;
}




/*
    The function CreateRankings() creates the internal ranking list.
    The list is sorted by ELO numbers (if players have one) and by DWZ
    numbers otherwise.
    Players without rating number will appear at the tail of the list
*/
void CreateRankings(void)

{ struct Player *t, **tptr;
  int t1, t2;

  RankingFirst = NULL;
  for (t = (struct Player *) PlayerList.lh_Head;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ)
  { /*
	Get the curremt players (t) rating number into t1.
    */
    if ((t1 = t->ELO)  ==  0)
    { t1 = tdwz(t);
    }

    /*
	Insert t into the internal ranking list
    */
    for (tptr = &RankingFirst;  *tptr != NULL;
	 tptr = &((*tptr)->RankNext))
    { if (t1 != 0)
      { if ((t2 = (*tptr)->ELO)  ==  0)
	{ t2 = tdwz(*tptr);
	}
	if (t1 > t2)
	{ break;
	}
      }
    }

    t->RankNext = *tptr;
    *tptr = t;
  }
}




/*
    DoSwissPairingFirst() makes the pairings of the first round of a
    Swiss pairing tournament.

    Inputs: user - True, if the user may set games
*/
static int DoSwissPairingFirst(int user)

{ struct Player *t, *thelp;
  int NumGames, NumFreePlayers;
  int i, j;
  int flag;
  int BoardNr;

  /*
      Build the internal ranking list
  */
  CreateRankings();


  /*
      Allow the user to make settings.
  */
  if ((BoardNr = GetSettings(user))  ==  -1)
  { return(FALSE);
  }

#ifdef DEBUG_PAIRINGS
  printf("Setting results:\n");
  for (t = RankingFirst;  t != NULL;  t = t->RankNext)
  { if (t->Opponent)
    { printf("Player %s paired against %s.\n", t->Name, t->Opponent->Name);
    }
    else if (t->GFlags & GMFLAGSF_NOFIGHT)
    { printf("One point bye: %s\n", t->Name);
    }
    else
    { printf("Player %s not set\n", t->Name);
    }
  }
#endif

  /*
      get colour of player 1
  */
  flag = (RangeRand(2) == 0)  ?  GMFLAGSF_WHITE  :  0;



  /*
      Count the number of players without opponent. Get the number of players
      with minimal rating. Additionally setup the colors for set players.
  */
  NumFreePlayers = 0;
  for (t = RankingFirst;  t != NULL;  t = t->RankNext)
  { if (t->Opponent == NULL  &&  (t->GFlags & GMFLAGSF_NOFIGHT) == 0)
    { NumFreePlayers++;
    }
    else if (t->Opponent)
    { if ((t->GFlags & GMFLAGSF_WHITE) == 0  &&
	  (t->Opponent->GFlags & GMFLAGSF_WHITE) == 0)
      { t->GFlags = flag;
	flag = GMFLAGSF_WHITE - flag;
	t->Opponent->GFlags = flag;
      }
#ifdef DEBUG_PAIRINGS
      printf("Game set: %s : %s (%d)\n",
	     flag ? t->Opponent->Name : t->Name,
	     flag ? t->Name : t->Opponent->Name, BoardNr);
    }
    else
    { printf("One point bye set: %s\n", t->Name);
#endif
    }
  }


  /*
      If the number of free players is odd, select a player which receives a
      one point bye.
  */
#ifdef DEBUG_PAIRINGS
  printf("Number of players not set: %d\n", NumFreePlayers);
#endif
  if (NumFreePlayers % 2)
  { int i, ihelp;

    /*
	Find the 5 players with the lowest ranking.
    */
    int MinPlayers = (NumFreePlayers > 5) ? 5 : NumFreePlayers;

    i = ihelp = NumFreePlayers;
    t = thelp = RankingFirst;
    for (t = thelp = RankingFirst;  t != NULL;  t = t->RankNext)
    { if (t->Opponent == NULL)
      { if (thelp->Opponent != NULL)
	{ thelp = t;
	  ihelp = i;
	}
	if (tdwz(t) < tdwz(thelp))
	{ if (i >= MinPlayers)
	  { thelp = t;
	    ihelp = i;
	  }
	}
	--i;
      }
    }
#ifdef DEBUG_PAIRINGS
    printf("Looking for one point bye beginning with %s.\n", thelp->Name);
#endif

    /*
	Now thelp points to the last ihelp players. Select one of them.
    */
    j = RangeRand(ihelp);

    while(j > 0  ||  thelp->Opponent)
    { if (!thelp->Opponent)
      { --j;
      }
      thelp = thelp->RankNext;
    }

#ifdef DEBUG_PAIRINGS
    printf("Player %s gets a one point bye.\n", thelp->Name);
#endif
    thelp->GFlags = GMFLAGSF_POINTFORFREE|GMFLAGSF_NOFIGHT;
    --NumFreePlayers;
  }





  /*
      Do the other pairings. t points into the upper and thelp into the
      lower half of the players.
  */
  if ((NumGames = NumFreePlayers/2))
  { /*
	Initialize thelp
    */
    thelp = RankingFirst;
    for (i = NumGames;  i;  thelp = thelp->RankNext)
    { if (thelp->Opponent == NULL  &&
	  (thelp->GFlags & GMFLAGSF_NOFIGHT)  ==  0)
      { i--;
      }
    }

    for (t = RankingFirst, i = NumGames;  i;  --i)
    {
#ifdef DEBUG_PAIRINGS
      printf("Looking for next game: Upper half player %s, lower half player %s\n",
	     t->Name, thelp->Name);
#endif
      /*
	  t and thelp must not point on free or set players!
      */
      while ((t->GFlags & GMFLAGSF_NOFIGHT)  !=  0   ||
	     t->Opponent != NULL)
      { t = t->RankNext;
      }
      while ((thelp->GFlags & GMFLAGSF_NOFIGHT)  !=  0   ||
	     thelp->Opponent != NULL)
      { thelp = thelp->RankNext;
      }

      t->Opponent = thelp;
      thelp->Opponent = t;
      t->BoardNr = ++BoardNr;
      thelp->BoardNr = BoardNr;
      t->GFlags = flag;
      flag = GMFLAGSF_WHITE - flag;
      thelp->GFlags = flag;
#ifdef DEBUG_PAIRINGS
      printf("Pairing %s : %s (%d)\n",
	     flag ? thelp->Name : t->Name,
	     flag ? t->Name : thelp->Name, t->BoardNr);
#endif
      t = t->RankNext;
      thelp = thelp->RankNext;
    }
  }

  return(TRUE);
}





/*
    The DoSwissPairing() function gets called instead of
    DoSwissPairingFirst() for round 2 and later.

    Inputs: user - TRUE, if the user may set games

    Result: TRUE, if succesfull, FALSE otherwise
*/
static int DoSwissPairing(int user)

{ struct Player *t, *thelp, **tptr;
  void *PKey = NULL;
  int BoardNr;
  int result;

  /*
      First create the new ranking list
  */
  t = RankingFirst;
  RankingFirst = NULL;
  while (t != NULL)
  { for (tptr = &RankingFirst;  *tptr != NULL;
	 tptr = &((*tptr)->RankNext))
    { if (t->Points > (*tptr)->Points)
      { break;
      }
    }
    thelp = t->RankNext;
    t->RankNext = *tptr;
    *tptr = t;
    t = thelp;
  }
#ifdef DEBUG_PAIRINGS
  { int i;

    printf("New rankings:\n");
    for (i = 1, t = RankingFirst;  t != NULL;  t = t->RankNext, ++i)
    { printf("%5d. %s\n", i, t->Name);
    }
  }
#endif


  /*
      Allow the user to make settings.
  */
  if ((BoardNr = GetSettings(user))  ==  -1)
  { return(FALSE);
  }



  /*
      Do the pairings
  */
#ifdef AMIGA
  set(App, MUIA_Application_Sleep, TRUE);
#endif
  { result = DoFirstGroup();
  }
#ifdef AMIGA
  set(App, MUIA_Application_Sleep, FALSE);
#endif

  if (!result)
  { ShowError((char *) MSG_NO_PAIRING);
    PutMemList(&PKey);
    return(FALSE);
  }

  /*
      Select colors
  */
  for (t = RankingFirst;  t != NULL;  t = t->RankNext)
  { if (t->Flags & TNFLAGSF_WITHDRAWN)
    { continue;
    }
    if (t->Opponent == NULL)
    { t->GFlags = GMFLAGSF_POINTFORFREE|GMFLAGSF_NOFIGHT;
    }
    else
    { /*
	  Select colors
      */
      thelp = t->Opponent;
      if ((t->GFlags & GMFLAGSF_WHITE) == 0  &&
	  (thelp->GFlags & GMFLAGSF_WHITE) == 0)
      { if (t->HowMuchWhiteLast < thelp->HowMuchWhiteLast  ||
	    (t->HowMuchWhiteLast == thelp->HowMuchWhiteLast  &&
	     (t->HowMuchWhite < thelp->HowMuchWhite  ||
	      (t->HowMuchWhite == thelp->HowMuchWhite  &&
	       t->Nr > thelp->Nr))))
	{ thelp = t;
	}
	thelp->GFlags = GMFLAGSF_WHITE;
      }
    }
  }
  return(TRUE);
}




/*
    DoRoundRobin() does the Round Robin pairings. Here all rounds are paired
    at once.

    Inputs: mode - 0 for FIDE system, TNMODEF_SHIFT_SYSTEM for shift system

    Result: TRUE, if successfull, FALSE otherwise
*/
static int DoRoundRobin(int mode)

{ struct Player *t, **ttab, *tg;
  int i, j, k, l;
  int NumGames;
  int GamesMissing = 0;
  short flag, BoardNr;
  void *PMem = NULL, *GMem = NULL;

  /*
      Allocate a table of player numbers
  */
  if ((ttab = GetMem(&PMem, sizeof(*ttab)*NumPlayers))  ==  NULL)
  { MemError();
    return(FALSE);
  }

  /*
      Give any player a different, random number
  */
  { struct Player **PTab;
    int i, j;

    if (!(PTab = GetMem(&PMem, sizeof(*PTab)*NumPlayers)))
    { PutMemList(&PMem);
      MemError();
      return(FALSE);
    }

    for (i = 0, t = (struct Player *) PlayerList.lh_Head;
	 t->Tn_Node.ln_Succ;
	 i++, t = (struct Player *) t->Tn_Node.ln_Succ)
    { PTab[i] = t;
    }
    while(i)
    { j = RangeRand(i);
      t = PTab[j];
      PTab[j] = PTab[i-1];
      t->Nr = i;
      ttab[--i] = t;
    }

    PutMem(PTab);
  }
  NumGames = (NumPlayers+1)/2;

  if ((mode & TNMODEF_SHIFT_SYSTEM)  ==  0)
  { /*
	Here comes the FIDE-system.

	Assume n=NumPlayers (n=NumPlayers+1 for an odd number of players)
	The FIDE system wants the following pairings for round 1:
	1:n, 2:n-1, 3:n-2, 4:n-3 and so on. (n as opponent means free round,
	if the number of players is odd.)
    */
    for (i = 0;  i < NumGames; i++)
    { t = ttab[i];
      if(i == 0  &&  ((NumPlayers%2) != 0))    /*  Spielfrei   */
      { t->Opponent = NULL;
	t->BoardNr = i;
	t->GFlags = GMFLAGSF_POINTFORFREE|GMFLAGSF_NOFIGHT;
      }
      else
      { tg = ttab[NumGames*2-i-1];

	t->Opponent = tg;
	tg->Opponent = t;
	t->BoardNr = tg->BoardNr = i+1;
	t->GFlags = GMFLAGSF_WHITE;
	tg->GFlags = 0;
	GamesMissing++;
      }
    }

    if (!NewGames(&GMem, 0))
    { goto Error;
    }

    /*
	The following rounds are determined by a simple algorithm:
	(See Ernst Schubart, Helmut Noettger: "Turnierleiterhandbuch des
	Deutschen Schachbundes" (The official german chess federation's
	guide to managing chess-tournaments), p.64

	- In the odd rounds the players 1, 2, 3 and so on have player n as
	  opponent (or have a free round, if the number of players is even.
	  In the even rounds n plays against k+1, k+2, k+3 and so on, where
	  k=n/2.
	- All other participants play against the player whose number is the
	  number of their last opponent, incremented by 1. Player n is left
	  out, player 1 comes after n-1.
	- If the number of players is even, the players 1, 2, ..., k have
	  white, when playing against opponent n. The other players have
	  black in that case.
	- In all other games the player with the lower number has the white
	  pieces, if the sum of the two player-numbers is odd. Otherwise he
	  gets the black pieces.
    */
    for (j = 1;  j < NumGames*2-1;  j++)
    { /*
	  First get an opponent for player n.
      */
      k = (((j%2) == 0) ? 0 : NumGames) + j/2 + 1;
      t = ttab[k-1];
      if ((NumPlayers%2) == 0) /*  No point for free    */
      { tg = ttab[NumPlayers-1];
	t->BoardNr = tg->BoardNr = BoardNr = 0;
	t->GFlags = (t->Nr <= NumGames) ? GMFLAGSF_WHITE : 0;
	tg->GFlags = GMFLAGSF_WHITE - t->GFlags;
	tg->Opponent = t;
	GamesMissing++;
      }
      else
      { tg = NULL;
	t->BoardNr = BoardNr = -1;
	t->GFlags = GMFLAGSF_POINTFORFREE|GMFLAGSF_NOFIGHT;
      }
      t->Opponent = tg;

      /*
	  Get the other games
      */
      for (i = 1;  i < NumGames;  i++)
      { if (++k == NumGames*2)
	{ k = 1;
	}
	t = ttab[k-1];
	if ((tg = GameAddress(t, j)->Opponent) == NULL  ||
	    tg->Nr == NumGames*2)
	{ l = t->Nr;
	}
	else
	{ l = tg->Nr;
	}
	if (++l == NumGames*2)
	{ l = 1;
	}
	tg = ttab[l-1];
	flag = (((t->Nr+tg->Nr) % 2) != 0) ? GMFLAGSF_WHITE : 0;
	if (t->Nr > tg->Nr)
	{ flag = GMFLAGSF_WHITE-flag;
	}
	t->GFlags = flag;
	tg->GFlags = GMFLAGSF_WHITE-flag;
	t->BoardNr = tg->BoardNr = ++BoardNr;
	t->Opponent = tg;
	tg->Opponent = t;
	GamesMissing++;
      }

      if (!NewGames(&GMem, 0))
      { goto Error;
      }
    }
  }
  else
  { /*
	Here comes the shift system. Its algorithm is rather easy, if you
	have seen it in practice.

	The boards are placed reverted on the table and all players sit down
	for the first round in the following order:
			    1 : k
			    2 : k+1
			    3 : k+2
			      .
			      .
			      .
			  k-1 : n
	(We assume again, that n is the number of players is even and
	k = n/2. If this isn't true, we add a virtual player n. Playing
	against n means having a free game.)

	After each round the players 1, 2, 3, ..., n-1 are shifted clockwise.
	All boards remain unchanged, except for the board of player n, who
	may keep his place, but has to revert his board.

	Below the array ttab is used to simulate the table. (That's probably
	why it's got his name...)
    */
    int lastflag;

    for (i = 0;  i < NumGames*2-1;  i++)
    { for (j = 0, flag = GMFLAGSF_WHITE;  j < NumGames; j++)
      { t = ttab[j];
	if (j+NumGames < NumPlayers)
	{ tg = ttab[j+NumGames];
	  t->GFlags = flag;
	  flag = GMFLAGSF_WHITE-flag;
	  tg->GFlags = flag;
	  tg->Opponent = t;
	  tg->BoardNr = j+1;
	}
	else
	{ tg = NULL;
	}
	t->Opponent = tg;
	t->BoardNr = j+1;
      }
      if (i == 0)
      { lastflag = flag;
      }
      else if (NumPlayers == NumGames*2)
      { t = ttab[NumGames-1];
	tg = ttab[NumGames*2-1];
	t->GFlags = lastflag;
	lastflag = GMFLAGSF_WHITE-lastflag;
	tg->GFlags = lastflag;
      }
    if (!NewGames(&GMem, 0))
    { goto Error;
    }

    /*
	Shift all players except for n.
    */
    t = ttab[0];
    for (j = 0;  j < NumGames-1;  j++)
    { ttab[j] = ttab[j+1];
    }
    ttab[NumGames-1] = ttab[NumGames*2-2];
    for (j = NumGames*2-3;  j >= NumGames;  j--)
    { ttab[j+1] = ttab[j];
    }
    ttab[NumGames] = t;
    }
  }

  PutMem(ttab);
  MoveMemList(&GMem, &TrnMem);
  NumGamesMissing = GamesMissing;
  return(TRUE);

Error:
  for (t = (struct Player *) PlayerList.lh_Head;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ)
  { t->First_Game = NULL;
  }
  PutMemList(&GMem);
  PutMem(ttab);
  NumRounds = 0;
  return(FALSE);
}




/*
    This function selects the boards, where the players should play.
*/
static void SelectBoards(void)

{ struct Player *p;
  int BoardNr;

  for (p = RankingFirst;  p != NULL;  p = p->RankNext)
  { p->BoardNr = -1;
  }

  for (p = RankingFirst, BoardNr = 0;  p != NULL;  p = p->RankNext)
  { if (p->BoardNr < 0  &&  p->Opponent != NULL)
    { p->BoardNr = p->Opponent->BoardNr = BoardNr++;
    }
  }
}





/*
    DoPairings() is the function that gets called from the menu.

    Input:  mode - tournament mode (TNMODEF_SWISS_PAIRING or
		   TNMODEF_ROUND_ROBIN with or without TNMODEF_SHIFT_SYSTEM)
	    save - TRUE, if the user should be asked to save the tournament
	    user - TRUE, if the user may set games (ignored for Round
		   Robin tournaments)

    Result: TRUE, if successfull, FALSE otherwise
*/
int DoPairings(int mode, int save, int user)

{ struct Player *t, *rankingfirst;
  char *name;
  char trnfilename[TRNFILENAME_LEN+1];
  char ending[20];
  int len, endlen, oldNumRounds = NumRounds;

  /*
      Copy the ranking pointers. This allows to undo the pairing calls, if
      something goes wrong. Additionally the Opponent and GFlags fields
      get initialized.
  */
  rankingfirst = RankingFirst;
  for (t = (struct Player *) PlayerList.lh_Head;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ)
  { t->Helpptr = t->RankNext;
    t->Opponent = NULL;
    t->GFlags = 0;
  }

  if (mode & TNMODEF_SWISS_PAIRING)
  { if (!((NumRounds == 0)  ?  DoSwissPairingFirst(user)  :
			       DoSwissPairing(user)))
    { goto Error;
    }
    SelectBoards();
    NewGames(&TrnMem, WinnerPoints);
  }
  else
  { if (!DoRoundRobin(mode))
    { goto Error;
    }
  }
  TrnMode |= mode;
  IsSaved = FALSE;


  /*
      Offer the user to save data. If the convention "name.roundnumber.cdat"
      was kept until now, we keep this.
  */
  if (save)
  { strcpy(trnfilename, TrnFileName);
    sprintf(ending, ".%d.cdat", oldNumRounds);
    endlen = strlen(ending);
    len = strlen(trnfilename);
    if (len >= endlen  &&
	Stricmp((STRPTR) trnfilename+(len-endlen), (STRPTR) ending)  ==  0)
    { sprintf(trnfilename+(len-endlen), ".%d.cdat", NumRounds);
    }
    name = FileRequest(trnfilename, NULL, NULL, TRUE);
    if (name  !=  NULL  &&  *name != '\0')
    { return(SaveTournament(name));
    }
  }
  return(TRUE);;

Error:
  /*
      Get the old ranking list
  */
  RankingFirst = rankingfirst;
  for (t = (struct Player *) PlayerList.lh_Head;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ)
  { t->RankNext = t->Helpptr;
  }
  return(FALSE);
}

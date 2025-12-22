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


    $RCSfile: Rounds.c,v $
    $Revision: 3.2 $
    $Date: 1994/10/14 09:44:02 $

    This file contains the functions to enter results.

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
    The function FormatGame() initializes the Text field of a GameNode
    structure due to the contents of the other fields.

    Inputs: gn           -  the GameNode structure, which's Text fiels
            format       -  0 = full game, short notion
                            1 = full game, long notion
                            2 = result only
*/
static char *ResultLongPoints(int result)

{ static char buffer[20];

  if ((result%2) == 0)
  { sprintf(buffer, " %-2d", result/2);
  }
  else if (result == 1)
  { sprintf(buffer, "1/2");
  }
  else
  { sprintf(buffer, "%d.5", result/2);
  }
  return(buffer);
}
static char *ResultLong(int result)

{ static char buffer[40];

  switch(result)
  { case -1:
      return(" _ : _ ");
    case 0:
      sprintf(buffer, " 0 :%s", ResultLongPoints(WinnerPoints));
      break;
    case 1:
      strcpy(buffer, ResultLongPoints(DrawPoints));
      sprintf(buffer+strlen(buffer), ":%s", ResultLongPoints(DrawPoints));
      break;
    case 2:
      sprintf(buffer, "%s: 0 ", ResultLongPoints(WinnerPoints));
      break;
  }
  return(buffer);
}

void FormatGame(struct GameNode *gn, int format)

{ static char *ResultShort[4] =
  { "_:_", "0:1", "½:½", "1:0"
  };

  if (gn->Flags & GMFLAGSF_POINTFORFREE)
  { sprintf(gn->Text, "     %s: %s",
            (TrnMode & TNMODEF_SWISS_PAIRING) ?
                        MSG_FREE_POINT_OUTPUT :
                        MSG_FREE_GAME_OUTPUT2,
            gn->White->Name);
  }
  else
  { if (format != 2)
    { sprintf(gn->Text, "%4d %-30s:%-30s %s %s", gn->BoardNr+1,
              gn->White->Name, gn->Black->Name,
              format  ?  ResultLong(gn->Result) :
                         ResultShort[gn->Result+1],
              (gn->Flags & GMFLAGSF_NOFIGHT) ?
                      (char *) MSG_NO_FIGHT_OUTPUT : "    ");
    }
    else
    { sprintf(gn->Text, "%d", gn->BoardNr+1);
      sprintf(gn->Text+strlen(gn->Text)+1, "%s %s",
              ResultShort[gn->Result+1],
              (gn->Flags & GMFLAGSF_NOFIGHT) ?
                (char *) MSG_NO_FIGHT_OUTPUT : "");
    }
  }
}




/*
    GetRound builds a list of the games of one round.

    Inputs: memlist   - argument for GetMem
            Round     - number of the round
            freegames - TRUE, if free games should be included
            format    - argument for FormatGame()

    Result: pointer to a list of games if successfull or NULL otherwise.
            Note, that the calling function should execute PutMemList()
            in either case.
*/
struct MinList *GetRound(void **memlist, int Round, int freegames, int format)

{ struct MinList *rlist;
  struct GameNode *gn, *gnhelp;
  struct Player *t;
  struct Game *g;

  *memlist = NULL;
  if ((rlist = GetMem(memlist, sizeof(*rlist)))  ==  NULL)
  { return(NULL);
  }
  NewList((struct List *) rlist);

  for (t = (struct Player *) PlayerList.lh_Head;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ)
  { t->Helpptr = NULL;
  }
  for (t = (struct Player *) PlayerList.lh_Head;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ)
  { if (t->Helpptr == NULL)
    { g = GameAddress(t, Round);
      if ((g->Flags & GMFLAGSF_POINTFORFREE) != 0)
      { if (!freegames  ||
            ((TrnMode & TNMODEF_SWISS_PAIRING)  &&  g->Result == 0))
        { continue;
        }
      }
      else if ((g->Flags & GMFLAGSF_WHITE)  ==  0)
      { continue;
      }

      if ((gn = GetMem(memlist,sizeof(*gn)))  ==  NULL)
      { return(NULL);
      }
      g = GameAddress(t, Round);
      gn->White = t;
      gn->Black = g->Opponent;
      gn->Result = g->Result;
      gn->BoardNr = (g->Flags & GMFLAGSF_POINTFORFREE) ? 0x7fff : g->BoardNr;
      gn->Flags = g->Flags;

      t->Helpptr = t;
      if (g->Opponent != NULL)
      { g->Opponent->Helpptr = t;
      }

      for (gnhelp = (struct GameNode *) rlist->mlh_Head;
           gnhelp->gn_Node.mln_Succ != NULL;
           gnhelp = (struct GameNode *) gnhelp->gn_Node.mln_Succ)
      { if (gn->BoardNr < gnhelp->BoardNr)
        { break;
        }
      }
    Insert((struct List *) rlist, (struct Node *) gn,
           (struct Node *) gnhelp->gn_Node.mln_Pred);
    FormatGame(gn, format);
    }
  }
  return (rlist);
}




/*
    EnterResult modifies one game's result

    Inputs: gn    - pointer to a struct GameNode
            Round - number of the round, in which the game was played
*/
void EnterResult(struct GameNode *gn, int Round)

{ struct Player *t;
  struct Game *g;

  t = gn->White;
  g = GameAddress(t, Round);
  if (g->Result != gn->Result  ||  g->Flags != gn->Flags)
  { IsSaved = FALSE;
  }
  if (gn->Result == -1  &&  g->Result != -1)
  { NumGamesMissing++;
  }
  else if (gn->Result != -1  &&  g->Result == -1)
  { NumGamesMissing--;
  }

  switch(g->Result)
  { case -1:
    case 0:
      break;
    case 1:
      t->Points -= DrawPoints;
      break;
    case 2:
      t->Points -= WinnerPoints;
      break;
  }
  switch(gn->Result)
  { case -1:
    case 0:
      break;
    case 1:
      t->Points += DrawPoints;
      break;
    case 2:
      t->Points += WinnerPoints;
      break;
  }
  g->Result = gn->Result;
  g->Flags = gn->Flags;

  if((t = gn->Black) != NULL)
  { g = GameAddress(t, Round);
    switch(g->Result)
    { case -1:
      case 0:
        break;
      case 1:
        t->Points -= DrawPoints;
        break;
      case 2:
        t->Points -= WinnerPoints;
        break;
    }
    switch(gn->Result)
    { case -1:
        g->Result = -1;
        break;
      case 2:
        g->Result = 0;
        break;
      case 1:
        g->Result = 1;
        t->Points += DrawPoints;
        break;
      case 0:
        g->Result = 2;
        t->Points += WinnerPoints;
        break;
    }
    g->Flags = gn->Flags & ~GMFLAGSF_WHITE;
  }
}




/*
    EnterResults() is called, if the user wants to enter results. (Surprise!)

    Inputs: Round - number of the round
*/
void EnterResults(int Round)

{ struct MinList *rlist;
  struct GameNode *gn;
  void *memlist = NULL;
  char title[80];

  /*
      Get the list of games
  */
#ifdef AMIGA
  if ((rlist = GetRound(&memlist, Round, FALSE, 2))  ==  NULL)
#else   /*  !AMIGA  */
  if ((rlist = GetRound(&memlist, Round, FALSE, 0))  ==  NULL)
#endif  /*  !AMIGA  */
  { return;
  }

  /*
      Initialize the window
  */
  sprintf(title, (char *) MSG_ROUND_INPUT_TITLE, Round);
  InitRsltWnd(title, rlist);

  for (;;)
  { switch(ProcessRsltWnd(rlist))
    { case 0:
        PutMemList(&memlist);
        TerminateRsltWnd();
        return;
      case -1:
        TerminateRsltWnd();
        /*
            Process the changes
        */
        for(gn = (struct GameNode *) rlist->mlh_Head;
            gn->gn_Node.mln_Succ != NULL;
            gn = (struct GameNode *) gn->gn_Node.mln_Succ)
        { EnterResult(gn, Round);
        }
        PutMemList(&memlist);

        return;
    }
  }
}

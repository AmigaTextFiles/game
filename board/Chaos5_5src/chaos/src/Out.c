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


    $RCSfile: Out.c,v $
    $Revision: 3.4 $
    $Date: 1994/12/03 18:02:26 $

    This file contains most of the output-functions.

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
    PointsToA() creates a string holding the number of points from p.

    Inputs: s - the string where the result should be written
	    p - the number of points
*/
void PointsToA(char *s, long p)

{ if (WinnerPoints%2  ||  DrawPoints%2)
  { sprintf(s, "%ld%s", p/2, (p%2)?".5":"  ");
  }
  else
  { sprintf(s, "%ld", p/2);
  }
}




/*
    tdwz() returns the DW (German rating number) of a player as short.
*/
int tdwz(struct Player *t)

{ long dwz;

#ifdef AMIGA
  if (StrToLong((STRPTR) t->DWZ, &dwz) < 0)
  { dwz = 0;
  }
#else
  dwz = atol(t->DWZ);
#endif
  return ((short) dwz);
}




/*
    RatingToA() gets a string from a DWZ or ELO number.

    Inputs: s - the string, that should be written
	    w - the rating number (Note, that this must not be the
		Player->DWZ field itself, because this is a string!)
*/
static void RatingToA(char *s, int w)

{ if(w == 0)
  { *s = '\0';
  }
  else
  { sprintf(s, "%d", w);
  }
}




/*
    lprint() is used to buffer the output which will be done later with
    ProcessOutput(). It can work in two modes: The first is building a list
    of lines, the second is collecting ALL lines in a single string.
    The latter is needed on the Amiga for using a FloatText gadget while the
    list is needed for output on the printer.

    Inputs: line - the string holding the line

    Result: TRUE, if successfull, FALSE otherwise
*/
int lprint(char *line)

{ extern struct MinList OutputList;
  extern void *OutputMemList;
  extern int OutputLineLen, OutputLineMaxLen;
  extern char*OutputLine;
  extern int OutputReturnCode;
  struct MinNode *n;
  char *ptr;
  int i, len;

  /*
      Get length of string, ignore trailing blanks.
  */
  for (i = 1, len = 0, ptr = line;  *ptr != '\0';  ptr++, i++)
  { if (*ptr != ' ')
    { len = i;
    }
  }

  if (OutputLineMaxLen == -1)
  { if ((n = GetMem(&OutputMemList, sizeof(*n)+len+1))  ==  NULL)
    { OutputReturnCode = RETURN_ERROR;
      return(FALSE);
    }

    strncpy((char *) (n+1), line, len);
    ((char *) (n+1))[len] = '\0';
    AddTail((struct List *) &OutputList, (struct Node *) n);
  }
  else
  { while (OutputLineLen + len + 2  >  OutputLineMaxLen)
    { if ((ptr = GetMem(&OutputMemList, OutputLineMaxLen += 16384))  ==  NULL)
      { OutputReturnCode = RETURN_ERROR;
	return(FALSE);
      }
      if (OutputLine != NULL)
      { strcpy(ptr, OutputLine);
	PutMem(OutputLine);
      }
      OutputLine = ptr;
    }

    strncpy(OutputLine+OutputLineLen, line, len);
    OutputLine[OutputLineLen += len] = '\n';
    OutputLine[++OutputLineLen] = '\0';
  }
  return(TRUE);
}




/*
    longlprint() does the same job as lprint(), but can process text with
    more than one line. The lines are split and lprint is called for each
    line.

    Inputs: txt - the string holding the text; note, that a single line must
		  not extend 512 characters!

    Result: TRUE, if successfull, FALSE otherwise
*/
int longlprint(char *txt)

{ char line[512];
  char *lptr;
  char c;

  while (*txt != '\0')
  { lptr = line;
    while ((c = *txt) != '\0'  &&  c != '\n')
    { *(lptr++) = *(txt++);
    }
    *lptr = '\0';
    if (!lprint(line))
    { return(FALSE);
    }
    if (c == '\n')
    { txt++;
    }
  }
  return(TRUE);
}




/*
    This function prints the list of players.

    Inputs: filename    - destination file; see InitOutput()
	    device      - device; see InitOutput()
	    longformat  - TRUE, if long format, FALSE otherwise
*/
void OutPlayerList(char *filename, int device, int longformat)

{ struct Player *t;
  int i, lines;
  char head[301];
  char line1[121], line2[121], line3[121];
  char dwz[6], elo[6];

  if (longformat == FALSE)
  { lines = 1;
    sprintf(head, "%-4s %-30s %6s %6s %s",
	    MSG_NUMBER,
	    MSG_NAME_OUTPUT,
	    MSG_DWZ_OUTPUT,
	    MSG_ELO_OUTPUT,
	    MSG_CHESSCLUB_OUTPUT);
  }
  else
  { lines = 4;
    sprintf(head, "%-4s %-30s %-30s %s\n"
		  "     %-30s %-30s %s\n"
		  "     %-15s %s%s%s %s%s%s%s%s      %s\n",
	    MSG_NUMBER,
	    MSG_NAME_OUTPUT,
	    MSG_STREET_OUTPUT,
	    MSG_DWZ_OUTPUT,

	    MSG_CHESSCLUB_OUTPUT,
	    MSG_VILLAGE_OUTPUT,
	    MSG_ELO_OUTPUT,

	    MSG_BIRTHDAY_OUTPUT,
	    MSG_SENIOR_SHORT,
	    MSG_JUNIOR_SHORT,
	    MSG_WOMAN_SHORT,
	    MSG_JUNIORA_SHORT,
	    MSG_JUNIORB_SHORT,
	    MSG_JUNIORC_SHORT,
	    MSG_JUNIORD_SHORT,
	    MSG_JUNIORE_SHORT,
	    MSG_PHONE_OUTPUT);
  }
  if (!InitOutput((char *) MSG_PLAYER_LIST_TITLE,
		  head, head, filename, "#?.plst", device, lines, lines))
  { TerminateOutput();
    return;
  }

  for (t = (struct Player *) PlayerList.lh_Head, i = 1;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ, i++)
  { RatingToA(dwz, tdwz(t));
    RatingToA(elo, (int) t->ELO);

    if (!longformat)
    { sprintf(line1, "%-4d %-30s %6s %6s %-30s", i, t->Name, dwz, elo,
	      t->ChessClub);
      if (!lprint(line1))
      { TerminateOutput();
	return;
      }
    }
    else
    { sprintf(line1, "%-4d %-30s %-30s %s", i, t->Name, t->Street, dwz);
      sprintf(line2, "     %-30s %-30s %s", t->ChessClub, t->Village, elo);
      sprintf(line3, "     %-15s %s%s%s %s%s%s%s%s      %s",
	      t->BirthDay,
	      (t->Flags & TNFLAGSF_SENIOR)   ?
			(char *) MSG_SENIOR_SHORT  : " ",
	      (t->Flags & TNFLAGSF_JUNIOR)   ?
			(char *) MSG_JUNIOR_SHORT  : " ",
	      (t->Flags & TNFLAGSF_WOMAN)     ?
			(char *) MSG_WOMAN_SHORT   : " ",
	      (t->Flags & TNFLAGSF_JUNIORA)  ?
			(char *) MSG_JUNIORA_SHORT : " ",
	      (t->Flags & TNFLAGSF_JUNIORB)  ?
			(char *) MSG_JUNIORB_SHORT : " ",
	      (t->Flags & TNFLAGSF_JUNIORC)  ?
			(char *) MSG_JUNIORC_SHORT : " ",
	      (t->Flags & TNFLAGSF_JUNIORD)  ?
			(char *) MSG_JUNIORD_SHORT : " ",
	      (t->Flags & TNFLAGSF_JUNIORE)  ?
			(char *) MSG_JUNIORE_SHORT : " ",
	      t->PhoneNr);

      if (!lprint(line1)  ||  !lprint(line2)  ||
	  !lprint(line3)  ||  !lprint(""))
      { TerminateOutput();
	return;
      }
    }
  }

  ProcessOutput();
  TerminateOutput();
}




/*
    This function prints the results of one round.

    Inputs: filename    - destination file; see InitOutput()
	    device      - output device; see InitOutput()
	    Round       - number of the round, that should be printed
*/
void OutRound(char *filename, int device, int Round)

{ void *memlist;
  struct MinList *rlist;
  struct GameNode *gn;
  char head[81];
  char title[81];

  if ((rlist = GetRound(&memlist, Round, TRUE,
			(device == DEVICE_Screen) ? 0 : 1))
	     ==  NULL)
  { return;
  }

  sprintf(head, "%4s %-30s:%-30s %s",
	  MSG_NUMBER,
	  MSG_WHITE_OUTPUT,
	  MSG_BLACK_OUTPUT,
	  MSG_RESULT_OUTPUT);
  sprintf(title, (char *) MSG_ROUND_TITLE, Round);
  if (!InitOutput(title, head, head, filename, "#?.rslt", device, 1, 1))
  { goto Terminate;
  }

  for(gn = (struct GameNode *) rlist->mlh_Head;
      gn->gn_Node.mln_Succ != NULL;
      gn = (struct GameNode *) gn->gn_Node.mln_Succ)
  { if (!lprint(gn->Text))
    { goto Terminate;
    }
  }

  ProcessOutput();

Terminate:
  TerminateOutput();
  PutMemList(&memlist);
}




/*
    This function creates the table. The players are connected via the
    Player->Helpptr field.

    Inputs: sortmode    - sorting mode, either 0 (simple mode) or one of the
			  flags TNMODEF_BUCHHOLZ, TNMODEF_EXT_BUCHHOLZ or
			  TNMODEF_SONNEBORN_BERGER

    Result: pointer to the best player in the table
*/
struct Player *MakeTable(int sortmode)

{ struct Player *t, **tptr, *TabFirst;
  struct Game *g;

  for (t = (struct Player *) PlayerList.lh_Head;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ)
  { t->Buchholz = t->ExtBuchholz = 0;
  }

  /*
      Getting the Buchholz points
  */
  if (sortmode & (TNMODEF_BUCHHOLZ|TNMODEF_EXT_BUCHHOLZ))
  { for (t = (struct Player *) PlayerList.lh_Head;
	 t->Tn_Node.ln_Succ != NULL;
	 t = (struct Player *) t->Tn_Node.ln_Succ)
    { for (g = t->First_Game;  g != NULL;  g = g->Next)
      { if ((g->Flags & GMFLAGSF_POINTFORFREE)  ==  0  &&
	    (g->Flags & GMFLAGSF_WITHDRAWN) == 0)
	{ t->Buchholz += g->Opponent->Points;
	}
      }
    }

  /*
      Getting the extended Buchholz points
  */
    if (sortmode & TNMODEF_EXT_BUCHHOLZ)
    { for (t = (struct Player *) PlayerList.lh_Head;
	   t->Tn_Node.ln_Succ != NULL;
	   t = (struct Player *) t->Tn_Node.ln_Succ)
      { for (g = t->First_Game;  g != NULL;  g = g->Next)
	{ if ((g->Flags & GMFLAGSF_POINTFORFREE)  ==  0  &&
	      (g->Flags & GMFLAGSF_WITHDRAWN) == 0)
	  { t->ExtBuchholz += g->Opponent->Buchholz;
	  }
	}
      }
    }
  }
  /*
      Getting the Sooneborn-Berger points
  */
  else if (sortmode & TNMODEF_SONNEBORN_BERGER)
  { for (t = (struct Player *) PlayerList.lh_Head;
	 t->Tn_Node.ln_Succ != NULL;
	 t = (struct Player *) t->Tn_Node.ln_Succ)
    { for (g = t->First_Game;  g != NULL;  g = g->Next)
      { if ((g->Flags & GMFLAGSF_POINTFORFREE) == 0  &&
	    g->Result != -1)
	{ t->Buchholz += g->Opponent->Points * g->Result;
	}
      }
    }
  }

  /*
      Sorting
  */
  TabFirst = NULL;
  for (t = (struct Player *) PlayerList.lh_Head;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ)
  { for (tptr = &TabFirst;  *tptr != NULL;
	 tptr = (struct Player **) &((*tptr)->Helpptr))
    { if (t->Points > (*tptr)->Points  ||
	  (t->Points == (*tptr)->Points  &&
	   (t->Buchholz > (*tptr)->Buchholz  ||
	    (t->Buchholz == (*tptr)->Buchholz  &&
	     t->ExtBuchholz > (*tptr)->ExtBuchholz))))
      { break;
      }
    }
    t->Helpptr = *tptr;
    *tptr = t;
  }
  return(TabFirst);
}




/*
    The following function prints the table.

    Inputs: filename    - destination file; see InitOutput()
	    device      - output device; see InitOutput()
	    plrmode     - tells which players to include into the table:
			  Either 0 for all players or one of the flags
			  TNFLAGSF_SENIOR, TNFLAGSF_JUNIOR, TNFLAGSF_WOMAN,
			  TNFLAGSF_JUNIORA, TNFLAGSF_JUNIORB,
			  TNFLAGSF_JUNIORC, TNFLAGSF_JUNIORD or
			  TNFLAGSF_JUNIORE
	    sortmode    - tells how to sort the table; see MakeTable()
*/
void OutTable(char *filename, int device, int plrmode, int sortmode)

{ struct Player *t, *TabFirst;
  int i, Place;
  long pextbuchholz;
  short ppoints, pbuchholz;
  char head[81];
  char line[81];
  char title[81];
  char subtitle[81];
  char ppointsstrtr[10], pbuchholzstr[10], pextbuchholzstr[10];

  TabFirst = MakeTable(sortmode);

  switch (sortmode & TNMODE_TABMASK)
  { case TNMODEF_BUCHHOLZ:
      sprintf(head, "%-5s %-6s %-8s %-30s", MSG_PLACE_OUTPUT,
	      MSG_POINTS_OUTPUT,
	      MSG_BUCHHOLZ_OUTPUT,
	      MSG_NAME_OUTPUT);
      break;
    case TNMODEF_EXT_BUCHHOLZ:
      sprintf(head, "%-5s %-6s %-8s %-9s %-30s",
	      MSG_PLACE_OUTPUT,
	      MSG_POINTS_OUTPUT,
	      MSG_BUCHHOLZ_OUTPUT,
	      MSG_EXT_BUCHHOLZ_OUTPUT,
	      MSG_NAME_OUTPUT);
      break;
    case TNMODEF_SONNEBORN_BERGER:
      sprintf(head, "%-5s %-6s %-8s %-30s",
	      MSG_PLACE_OUTPUT,
	      MSG_POINTS_OUTPUT,
	      MSG_SONNEBORN_BERGER_OUTPUT,
	      MSG_NAME_OUTPUT);
      break;
    default:
      sprintf(head, "%5s %6s %-30s",
	      MSG_PLACE_OUTPUT,
	      MSG_POINTS_OUTPUT,
	      MSG_NAME_OUTPUT);
  }

  switch (plrmode)
  { case TNFLAGSF_SENIOR:
      sprintf(subtitle, "  -  %s",
	      MSG_OUTPUT_TABLE_SENIORS_SUB);
      break;
    case TNFLAGSF_JUNIOR:
      sprintf(subtitle, "  -  %s",
	      MSG_OUTPUT_TABLE_JUNIORS_SUB);
      break;
    case TNFLAGSF_WOMAN:
      sprintf(subtitle, "  -  %s",
	      MSG_OUTPUT_TABLE_WOMEN_SUB);
      break;
    case TNFLAGSF_JUNIORA:
      sprintf(subtitle, "  -  %s",
	      MSG_OUTPUT_TABLE_JUNIORSA_SUB);
      break;
    case TNFLAGSF_JUNIORB:
      sprintf(subtitle, "  -  %s",
	      MSG_OUTPUT_TABLE_JUNIORSB_SUB);
      break;
    case TNFLAGSF_JUNIORC:
      sprintf(subtitle, "  -  %s",
	      MSG_OUTPUT_TABLE_JUNIORSC_SUB);
      break;
    case TNFLAGSF_JUNIORD:
      sprintf(subtitle, "  -  %s",
	      MSG_OUTPUT_TABLE_JUNIORSD_SUB);
      break;
    case TNFLAGSF_JUNIORE:
      sprintf(subtitle, "  -  %s",
	      MSG_OUTPUT_TABLE_JUNIORSE_SUB);
      break;
    default:
      sprintf(subtitle, "");
      break;
  }
  if (sortmode & TNMODEF_SWISS_PAIRING)
  { sprintf(title, (char *) MSG_TABLE_TITLE,
	    (NumGamesMissing == 0) ? NumRounds : NumRounds-1,
	    subtitle);
  }
  else
  { sprintf(title, (char *) MSG_TABLE_TITLE2, subtitle);
  }


  if (!InitOutput(title, head, head, filename, "#?.tbl", device, 1, 1))
  { TerminateOutput();
    return;
  }

  /*
      Force initialization of ppoints, pbucholz and pextbuchholz in the
      following loop.
  */
  ppoints = -1;
  pbuchholz = -1;
  pextbuchholz = -1;

  for (i = 0, t = TabFirst;  t != NULL;  t = t->Helpptr)
  { if (plrmode != 0  &&  (plrmode & t->Flags) == 0)
    { continue;
    }
    i++;
    if (ppoints != t->Points  ||  pbuchholz != t->Buchholz  ||
	pextbuchholz != t->ExtBuchholz)
    { Place = i;
      ppoints = t->Points;
      pbuchholz = t->Buchholz;
      pextbuchholz = t->ExtBuchholz;
    }

    PointsToA(ppointsstrtr, (long) ppoints);
    PointsToA(pbuchholzstr, (long) pbuchholz);
    PointsToA(pextbuchholzstr, pextbuchholz);
    switch (sortmode & TNMODE_TABMASK)
      { case TNMODEF_BUCHHOLZ:
	case TNMODEF_SONNEBORN_BERGER:
	  sprintf(line, "%5d %6s %8s %s", Place, ppointsstrtr, pbuchholzstr,
		  t->Name);
	  break;
	case TNMODEF_EXT_BUCHHOLZ:
	  sprintf(line, "%5d %6s %8s %8s  %s", Place, ppointsstrtr,
		  pbuchholzstr, pextbuchholzstr, t->Name);
	  break;
	default:
	  sprintf(line, "%5d %6s %s", Place, ppointsstrtr, t->Name);
      }

    if (!lprint(line))
    { TerminateOutput();
      return;
    }
  }

  ProcessOutput();
  TerminateOutput();
}




/*
    The following function prints the internal ranking list.

    Inputs: filename    - destination file; see InitOutput()
	    device      - output device; see InitOutput()
*/
void OutInternalRankings(char *filename, int device)

{ struct Player *t;
  int i;
  char head[81], line[81], title[81];
  char pointsstr[10];
  char dwz[6], elo[6];

  if (NumRounds == 0  ||  RoundRobinTournament)
  { sprintf(title, (char *) MSG_RANKINGS_TITLE);
    sprintf(head, "%-4s %-6s %-6s %-30s", MSG_NUMBER,
	    MSG_DWZ_OUTPUT, MSG_ELO_OUTPUT,
	    MSG_NAME_OUTPUT);
    CreateRankings();
  }
  else
  { sprintf(title, (char *) MSG_RANKINGS_TITLE2,
	    NumRounds);
    sprintf(head, "%-4s %-6s %-6s %-6s %-30s", MSG_NUMBER,
	    MSG_DWZ_OUTPUT, MSG_ELO_OUTPUT,
	    MSG_POINTS_OUTPUT, MSG_NAME_OUTPUT);
  }

  if (!InitOutput(title, head, head, filename, "#?.rnk", device, 1, 1))
  { TerminateOutput();
    return;
  }

  for (t = RankingFirst, i = 0;  t != NULL;  t = t->RankNext)
  { RatingToA(dwz, tdwz(t));
    RatingToA(elo, (int) t->ELO);
    if (NumRounds != 0)
    { PointsToA(pointsstr, (long) t->Points);
      sprintf(line, "%-4d %-6s %-6s %-5s  %s", ++i, dwz, elo,
	      pointsstr, t->Name);
    }
    else
    { sprintf(line, "%-4d %-6s %-6s %s", ++i, dwz, elo, t->Name);
    }
    if (!lprint(line))
    { TerminateOutput();
      return;
    }
  }

  ProcessOutput();
  TerminateOutput();
}




/*
    The following function prints the table of progress.

    Inputs: filename    - destination file; see InitOutput()
	    device      - output device; see InitOutput()
	    sortmode    - sorting mode of the table; see MakeTable()
*/
void OutTableProgress(char *filename, int device, int sortmode)

{ struct Player *TabFirst, *t;
  struct Game *g;
  int i, gperline, needprint;
  int lines;
  char head[81], title[81], line[81], pointsstr[10], helps[10];

  sprintf(title, (char *) MSG_PROGRESS_TABLE_TITLE,
	  NumRounds);
  sprintf(head, "%-4s %-6s %-33s %s", MSG_NUMBER,
	  MSG_POINTS_OUTPUT, MSG_NAME_OUTPUT,
	  MSG_GAME_OUTPUT);
  TabFirst = MakeTable(sortmode);

  lines = (NumRounds+3)/8+1;
  if (!InitOutput(title, head, head, filename, "#?.tblp", device, lines,
		  lines))
  { TerminateOutput();
    return;
  }

  for (t = TabFirst, i = 0;  t != NULL;  t = t->Helpptr)
  { t->Nr = ++i;
  }

  for (t = TabFirst;  t != NULL;  t = t->Helpptr)
  { PointsToA(pointsstr, (long) t->Points);
    sprintf(line, "%4d %6s %-34s", t->Nr, pointsstr, t->Name);
    gperline = 3;
    for (i = 1;  i <= NumRounds;  i++)
    { needprint = TRUE;
      g = GameAddress(t, i);
      if (g->Flags & GMFLAGSF_POINTFORFREE)
      { sprintf(helps, (char *) MSG_FREE_GAME_OUTPUT);
      }
      else if (g->Flags & GMFLAGSF_WITHDRAWN)
      { sprintf(helps, (char *) MSG_GONE_OUTPUT);
      }
      else
      { static char *ergchars = "?-=+";
	sprintf(helps, "  %4d%c%c%c", g->Opponent->Nr,
		ergchars[g->Result+1],
		(g->Flags&GMFLAGSF_WHITE) ? 'w' : 's',
		(g->Flags&GMFLAGSF_NOFIGHT) ? 'k' : ' ');
      }
      strcat(line, helps);
      if (--gperline == 0)
      { if (!lprint(line))
	{ TerminateOutput();
	  return;
	}
	gperline = 7;
	sprintf(line, "          ");
	needprint = FALSE;
      }
    }
    if (needprint)
    { if (!lprint(line))
      { TerminateOutput();
	return;
      }
    }
  }

  ProcessOutput();
  TerminateOutput();
}




/*
    The cross table can be printed on screen, on printer in ascii format
    or in TeX format. Note, that this must not be called in a Swiss Pairing
    tournament! Strange things might happen!

    Inputs: filename    - destination file; see InitOutput()
	    device      - output device; see InitOutput()
*/
void OutCrossTable(char *filename, int device)

{ struct Player *plr;
  struct Player **plrlist;
  void *PlrMem = NULL;
  struct Game *gm;
  char *title;
  int i,j;
  char line[512];
  char subline[512];
  int allflag;
  int width;

  /*
      Create the player table. (We deal with player numbers here and so its
      easier to use the table instead of going through the list of players
      each time.)
  */
  if ((plrlist = GetMem(&PlrMem, sizeof(struct Player *)*NumPlayers))
	       ==  NULL)
  { return;
  }
  for (plr = (struct Player *) PlayerList.lh_Head;
       plr->Tn_Node.ln_Succ != NULL;
       plr = (struct Player *) plr->Tn_Node.ln_Succ)
  { plrlist[plr->Nr-1] = plr;
  }



  if (device == DEVICE_FileTeX)
  { title = "";
  }
  else
  { title = (char *) MSG_OUTPUT_CROSSTABLE_ITEM;
  }
  if (!InitOutput(title, "", "", filename, "#?.crss", device, 0, 0))
  { goto Terminate;
  }


  /*
      Some guys (me!) like beautiful TeX printings...
  */
  if (device == DEVICE_FileTeX)
  { sprintf(line, "\\documentstyle[german,a4,%s]{article}\n"
		  "\\newcommand{\\r}{$\\frac{1}{2}$}\n"
		  "\\renewcommand{\\arraystretch}{2.0}\n"
		  "\\parindent0em\n\n"
		  "\\begin{document}\n"
		  "  \\begin{tabular}{l|*{%d}{p{0.6cm}|}r}",
		  (NumPlayers < 25) ? "12pt" : "",
		  NumPlayers);
    if (!longlprint(line))
    { goto Terminate;
    }

    strcpy(line, "    ");
    for (i = 0;  i < NumPlayers;  i++)
      { sprintf(line + strlen(line), "& %d ", i+1);
      }
    strcat(line, "& \\\\\\hline");
    if (!lprint(line))
    { goto Terminate;
    }


    for (i = 1;  i <= NumPlayers;  i++)
    { plr = plrlist[i-1];
      sprintf(line, "    %s", plr->Name);
      allflag = TRUE;
      for (j = 1;  j <= NumPlayers;  j++)
      { if (j == i)
	{ strcat(line, "& x ");
	}
	else
	{ gm = plr->First_Game;
	  while(gm->Opponent == NULL  ||  gm->Opponent->Nr != j)
	  { gm = gm->Next;
	  }
	  switch (gm->Result)
	  { case 2:
	      strcat(line, "& 1 ");
	      break;
	    case 1:
	      strcat(line, "& \\r");
	      break;
	    case 0:
	      strcat(line, "& 0 ");
	      break;
	    default:
	      strcat(line, "&   ");
	      allflag = FALSE;
	  }
	}
      }
      strcat(line, "& ");
      if (allflag)
      { PointsToA(line+strlen(line), (long) plr->Points);
      }
      if (i < NumPlayers)
      { strcat(line, "\\\\\\hline");
      }
      if (!lprint(line))
      { goto Terminate;
      }
    }

    if (!longlprint("  \\end{tabular}\n"
		    "\\end{document}"))
    { goto Terminate;
    }
  }

  /*
      other guys don't have or don't like TeX (really? :-( ) For those
      poor creatures the Ascii output:
  */
  else
  { CenterText(device);

    if (NumPlayers < 10)
    { width = 40 + NumPlayers*4;
    }
    else
    { width = 40 + NumPlayers*2;
    }
    for (i = 0;  i < width;  i++)
    { subline[i] = '-';
    }
    subline[width] = '\0';

    if (NumPlayers > 99)
    { sprintf(line, "%36s|", "");
      for (i = 1;  i <= NumPlayers;  i++)
      { plr = plrlist[i-1];
	if (i > 99)
	{ sprintf(line + strlen(line), "%c|", i/100+'0');
	}
	else
	{strcat(line, " |");
	}
      }
      if (!lprint(line))
      { goto Terminate;
      }
    }


    if (NumPlayers > 9)
    { sprintf(line, "%36s|", "");
      for (i = 1;  i <= NumPlayers;  i++)
      { plr = plrlist[i-1];
	if (i > 9)
	{ sprintf(line + strlen(line), "%c|", (i%100)/10+'0');
	}
	else
	{ strcat(line, " |");
	}
      }
      if (!lprint(line))
      { goto Terminate;
      }
    }


    sprintf(line, "%36s|", "");
    for (i = 1;  i <= NumPlayers;  i++)
    { plr = plrlist[i-1];
      sprintf(line + strlen(line), (NumPlayers > 9) ? "%c|" : " %c |",
	      i%10+'0');
    }
    if (!lprint(line))
    { goto Terminate;
    }


    for (i = 1;  i <= NumPlayers;  i++)
    { plr = plrlist[i-1];

      sprintf(line, "|%3d %30s |", i, plr->Name);
      allflag = TRUE;

      for (j = 1;  j <= NumPlayers;  j++)
      { if (j == i)
	{ strcat(line, (NumPlayers > 9) ? "x|" : " x |");
	}
	else
	{ static const char *ergs = {" 0=1" };

	  gm = plr->First_Game;
	  while(gm->Opponent == NULL  ||  gm->Opponent->Nr != j)
	  { gm = gm->Next;
	  }

	  sprintf(line+strlen(line), (NumPlayers > 9) ? "%c|" : " %c |",
		  ergs[gm->Result+1]);
	  if (gm->Result == -1)
	  { allflag = FALSE;
	  }
	}
      }
      if (allflag)
      { PointsToA(line + strlen(line), (long) plr->Points);
      }
      if (!lprint(subline)  ||  !lprint(line))
      { goto Terminate;
      }
    }
  }

  ProcessOutput();

Terminate:
  TerminateOutput();
  PutMemList(&PlrMem);
}




/*
    The following function prints the player cards.

    Inputs: filename - destination file; see InitOutput()
	    device   - output device; see InitOutput()
*/
void OutPlayerCards(char *filename, int device)

{ struct Player *plr, **plrlist;
  void *PlrMem = NULL;
  struct Game *gm;
  int i, j;
  int defrounds, numrounds;
  int lines;
  char line[512];
  char subline[512];
  char *title;

  /*
      Create the player table. (We deal with player numbers here and so its
      easier to use the table instead of going through the list of players
      each time.)
  */
  if ((plrlist = GetMem(&PlrMem, sizeof(struct Player *)*NumPlayers))
	       ==  NULL)
  { return;
  }
  for (i = 0, plr = (struct Player *) PlayerList.lh_Head;
       plr->Tn_Node.ln_Succ != NULL;
       plr = (struct Player *) plr->Tn_Node.ln_Succ)
  { plrlist[i++] = plr;
    plr->Nr = i;
  }


  /*
      Determine, how much rounds to print
  */
  defrounds = (device == DEVICE_FileTeX) ? 11 : 9;
  if (NumRounds < defrounds-1)
  { numrounds = defrounds;
  }
  else
  { numrounds = NumRounds+2;
  }
  if ((numrounds % 2) == 0)
  { numrounds++;
  }

  if (device == DEVICE_FileTeX)
  { title = "";
    lines = 0;
  }
  else
  { title = (char *) MSG_OUTPUT_PLAYERCARDS_ITEM;
    lines = 11;
  }
  if (!InitOutput(title, "", "", filename, "#?.pcrd", device, lines, lines))
  { goto Terminate;
  }

  /*
      Some guys (me!) like beautiful TeX printings...
  */
  if (device == DEVICE_FileTeX)
  { sprintf(line, "\\documentstyle[german,a4,12pt]{article}\n"
		  "\\renewcommand{\\arraystretch}{2.0}\n"
		  "\\parindent0em\n\n"
		  "\\begin{document}");
    if (!longlprint(line))
    { goto Terminate;
    }

    for (plr = (struct Player *) PlayerList.lh_Head;
	 plr->Tn_Node.ln_Succ != NULL;
	 plr = (struct Player *) plr->Tn_Node.ln_Succ)
    { sprintf(line, "\\begin{tabular}{|l*{%d}{|p{0.6cm}}|}\\hline\n"
		    "%s %d&\\multicolumn{%d}{|l|}{%s}\\\\\\hline",
	      numrounds, MSG_NUMBER,
	      plr->Nr, numrounds, plr->Name);
      if (!longlprint(line))
      { goto Terminate;
      }

      strcpy(line, (char *) MSG_WHITE_OUTPUT);
      for (j = 0, gm = plr->First_Game;  j < numrounds;  j++)
      { if (gm != NULL)
	{ if (gm->Flags & GMFLAGSF_WHITE)
	  { sprintf(line + strlen(line), "&%d", gm->Opponent->Nr);
	  }
	  else
	  { sprintf(line + strlen(line),
		    (gm->Flags & GMFLAGSF_POINTFORFREE) ? "&%s" : "&",
		    MSG_ONEPOINTBYE_VERYSHORT);
	  }
	  gm = gm->Next;
	}
	else
	{ strcat(line, "&");
	}
      }
      strcat(line, "\\\\\\hline");
      if (!lprint(line))
      { goto Terminate;
      }

      strcpy(line, (char *) MSG_BLACK_OUTPUT);
      for (j = 0, gm = plr->First_Game;  j < numrounds;  j++)
      { if (gm != NULL)
	{ if ((gm->Flags & (GMFLAGSF_WHITE|GMFLAGSF_POINTFORFREE))  ==  0)
	  { sprintf(line + strlen(line), "&%d", gm->Opponent->Nr);
	  }
	  else
	  { sprintf(line + strlen(line),
		    (gm->Flags & GMFLAGSF_POINTFORFREE) ? "&%s" : "&",
		    MSG_ONEPOINTBYE_VERYSHORT);
	  }
	  gm = gm->Next;
	}
	else
	{ strcat(line, "&");
	}
      }
      strcat(line, "\\\\\\hline");
      if (!lprint(line))
      { goto Terminate;
      }

      strcpy(line, (char *) MSG_POINTS_OUTPUT);
      for (j = 0, i = 0, gm = plr->First_Game;  j < numrounds;  j++)
      { strcat(line, "&");
	if (gm != NULL)
	{ i += gm->Result;
	  gm = gm->Next;
	  PointsToA(line + strlen(line), (long) i);
	}
      }
      strcat(line, "\\\\\\hline\n"
		   "\\end{tabular}\n\n\\vspace{0.5cm}\n");
      if (!longlprint(line))
      { goto Terminate;
      }
    }
    if (!lprint("\\end{document}"))
    { goto Terminate;
    }
  }

  /*
      other guys don't have or don't like TeX (really? :-( ) For those
      poor creatures the Ascii output:
  */
  else
  { char *plrformatstr, *emptyformatstr, *onepbyeformatstr, *pointsformatstr;
    char ppointsstr[10];
    int width, plrwidth;

    CenterText(device);

    if (numrounds > 11)
    { plrformatstr = "%3d |";
      emptyformatstr = "    |";
      onepbyeformatstr = "  %s |";
      pointsformatstr = "%4s";
      plrwidth = 4;
    }
    else
    { plrformatstr = " %3d |";
      emptyformatstr = "     |";
      onepbyeformatstr = "  %s  |";
      pointsformatstr = "%4s |";
      plrwidth = 6;
    }
    width = 14 + (numrounds+1) * plrwidth;
    for (i = 0;  i < width;  i++)
    { subline[i] = '-';
    }
    subline[width] = '\0';


    for (plr = (struct Player *) PlayerList.lh_Head;
	 plr->Tn_Node.ln_Succ != NULL;
	 plr = (struct Player *) plr->Tn_Node.ln_Succ)
    { if (!lprint(subline))
      { goto Terminate;
      }

      sprintf(line, "| %4s  %4d | %30s",
	      MSG_NUMBER, plr->Nr, plr->Name);
      for (i = strlen(line);  i < width-1;  i++)
      { line[i] = ' ';
      }
      line[width-1] = '|';
      line[width] = '\0';
      if (!lprint(line))
      { goto Terminate;
      }

      if (!lprint(subline))
      { goto Terminate;
      }

      sprintf(line, "| %10s |", (char *) MSG_WHITE_OUTPUT);
      for (j = 0, gm = plr->First_Game;  j < numrounds+1;  j++)
      { if (gm != NULL)
	{ if (gm->Flags & GMFLAGSF_WHITE)
	  { sprintf(line + strlen(line), plrformatstr, gm->Opponent->Nr);
	  }
	  else
	  { sprintf(line + strlen(line),
		    (gm->Flags & GMFLAGSF_POINTFORFREE) ?
				onepbyeformatstr : emptyformatstr,
		    MSG_ONEPOINTBYE_VERYSHORT);
	  }
	  gm = gm->Next;
	}
	else
	{ strcat(line, emptyformatstr);
	}
      }
      if (!lprint(line)  ||  !lprint(subline))
      { goto Terminate;
      }

      sprintf(line, "| %10s |", (char *) MSG_BLACK_OUTPUT);
      for (j = 0, gm = plr->First_Game;  j < numrounds+1;  j++)
      { if (gm != NULL)
	{ if ((gm->Flags & (GMFLAGSF_WHITE|GMFLAGSF_POINTFORFREE))  ==  0)
	  { sprintf(line + strlen(line), plrformatstr, gm->Opponent->Nr);
	  }
	  else
	  { sprintf(line + strlen(line),
		    (gm->Flags & GMFLAGSF_POINTFORFREE) ?
				onepbyeformatstr : emptyformatstr,
		    MSG_ONEPOINTBYE_VERYSHORT);
	  }
	  gm = gm->Next;
	}
	else
	{ strcat(line, emptyformatstr);
	}
      }
      if (!lprint(line)  ||  !lprint(subline))
      { goto Terminate;
      }

      sprintf(line, "| %10s |", (char *) MSG_POINTS_OUTPUT);
      for (j = 0, i = 0, gm = plr->First_Game;  j < numrounds+1;  j++)
      { if (gm != NULL)
	{ i += gm->Result;
	  gm = gm->Next;
	  PointsToA(ppointsstr, (long) i);
	  sprintf(line + strlen(line), pointsformatstr, ppointsstr);
	}
	else
	{ strcat(line, emptyformatstr);
	}
      }
      if (!lprint(line) ||  !lprint(subline)  ||  !lprint("\n"))
      { goto Terminate;
      }
    }
  }

  ProcessOutput();

Terminate:
  TerminateOutput();
  PutMemList(&PlrMem);
}

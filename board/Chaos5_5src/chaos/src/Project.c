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


    $RCSfile: Project.c,v $
    $Revision: 3.3 $
    $Date: 1994/11/19 19:32:01 $

    This file contains the functions of the Project-menu.

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



static char FILEVERSION[9] = "CHAOS5.3";




/*
    DeleteTournament creates a new tournament with default settings.

    Inputs: name    pointer to a string containing the new tournaments
		    name.
*/
void *TrnMem = NULL;
void DeleteTournament(char *name)

{
  /*
      Deallocate data used by the old tournament.
  */
  PutMemList (&TrnMem);

  /*
      Initialize the new tournament.
  */
  NewList(&PlayerList);
  PlayerList.lh_Type = (UBYTE) -1;
  *TrnFileName = '\0';
  NumRounds = 0;
  NumPlayers = 0;
  if (name == NULL)
  { *TrnName = '\0';
  }
  else
  { strcpy (TrnName, name);
  }
  TrnMode = 0;
  WinnerPoints = DefaultWinnerPoints;
  DrawPoints = DefaultDrawPoints;
  IsSaved = TRUE;
}




/*
    SaveTournament() saves a tournament.

    Inputs: name    Name of the tournament file; FileRequest() is called,
		    if name is NULL or the empty string.

    Result: TRUE, if successfull, FALSE otherwise
*/
int SaveTournament(char *name)

  { FILE *fh;
    struct Player *tn;
    struct Game *gm;

    if (name == NULL  ||  *name == '\0')
      { if ((name = FileRequest(TrnFileName, NULL, NULL, TRUE))  ==  NULL)
	  { return(FALSE);
	  }
      }

    if ((fh = fopen(name, "w"))  ==  NULL)
      { ShowError((char *) MSG_NO_WRITE_FILE, name, IoErr());
	return(FALSE);
      }

    if (fwrite(FILEVERSION, sizeof(FILEVERSION)-1, 1, fh) != 1)
      { goto WriteError;
      }

    if (fwrite(&NumRounds, sizeof(NumRounds), 1, fh) != 1               ||
	fwrite(&RankingFirst, sizeof(RankingFirst), 1, fh) != 1         ||
	fwrite(&NumPlayers, sizeof(NumPlayers), 1, fh) != 1             ||
	fwrite(&NumGamesMissing, sizeof(NumGamesMissing), 1, fh) != 1   ||
	fwrite(TrnName, sizeof(TrnName), 1, fh) != 1                    ||
	fwrite(&TrnMode, sizeof(TrnMode), 1, fh) != 1                   ||
	fwrite(&WinnerPoints, sizeof(WinnerPoints), 1, fh) != 1         ||
	fwrite(&DrawPoints, sizeof(DrawPoints), 1, fh) != 1)
      { goto WriteError;
      }

    for (tn = (struct Player *) PlayerList.lh_Head;
	 tn->Tn_Node.ln_Succ != NULL;
	 tn = (struct Player *) tn->Tn_Node.ln_Succ)
      { tn->Helpptr = tn;
	if (fwrite(tn, sizeof(*tn), 1, fh)  !=  1)
	  { goto WriteError;
	  }
	for (gm = tn->First_Game;  gm != NULL;  gm = gm->Next)
	  { if (fwrite(gm, sizeof(*gm), 1, fh)  !=  1)
	      { goto WriteError;
	      }
	  }
      }

    fclose(fh);
    IsSaved = TRUE;
    strcpy(TrnFileName, name);
    CreateIcon(name);
    return(TRUE);

WriteError:
    fclose(fh);
    ShowError((char *) MSG_WRITE_ERROR, IoErr(), name);
    return(FALSE);
  }




/*
    The function NewAddress() initializes a pointer after loading.
*/
static void NewAddress(struct Player **tptr)

{ struct Player *tn;

  for (tn = (struct Player *) PlayerList.lh_Head;
       tn->Tn_Node.ln_Succ != NULL;
       tn = (struct Player *) tn->Tn_Node.ln_Succ)
  { if (tn->Helpptr == *tptr)
    { *tptr = tn;
      return;
    }
  }
}




/*
    LoadTournament() loads a tournament from disk.

    Inputs: name    - Name of the tournament file; FileRequest() is called,
		      if name is NULL or the empty string.
	    memlist - a pointer to the memlist, where the player should
		      be inserted; this may be NULL, in which case TrnMem
		      is used
	    plrlist - a pointer to a list, where the new player should be
		      inserted; this may be NULL, in which case PlayerList
		      is used


    Result: RETURN_OK, if successful, RETURN_WARN or RETURN_ERROR otherwise
*/
int LoadTournament(char *name, void **memlist, struct List *plrlist)

{ FILE *fh;
  struct Player *tn, *rankingfirst;
  struct Game *gm;
  int i, j;
  char fileversion[sizeof(FILEVERSION)-1];
  char trnname[TRNNAME_LEN+1];
  int import;
  int numplayers, numrounds, numgamesmissing, trnmode, winnerpoints, drawpoints;
  int version = 53;

  if (plrlist == NULL)
  { plrlist = &PlayerList;
  }
  if (memlist == NULL)
  { memlist = &TrnMem;
  }
  import = (plrlist != &PlayerList);

  if (name == NULL  ||  *name == '\0')
  { if ((name = FileRequest(TrnFileName, NULL, NULL, FALSE))  ==  NULL)
    { return(RETURN_WARN);
    }
  }

  if ((fh = fopen(name, "r"))  ==  NULL)
  { ShowError((char *) MSG_NO_READ_FILE, name, IoErr());
    return(RETURN_ERROR);
  }

  if (fread(fileversion, sizeof(FILEVERSION)-1, 1, fh)  !=  1)
  { goto ReadError;
  }
  if (strncmp(fileversion, FILEVERSION, sizeof(FILEVERSION)-1) != 0)
  { if(strncmp(fileversion, "CHAOS5.0", 8) != 0)
    { ShowError((char *) MSG_NO_CHAOS_FILE, name);
      fclose(fh);
      return(RETURN_ERROR);
    }
    version = 50;
  }

  if (!import)
  { DeleteTournament(NULL);
  }
  NewList(plrlist);
  if (fread(&numrounds, sizeof(numrounds), 1, fh) != 1              ||
      fread(&rankingfirst, sizeof(rankingfirst), 1, fh) != 1        ||
      fread(&numplayers, sizeof(numplayers), 1, fh) != 1            ||
      fread(&numgamesmissing, sizeof(numgamesmissing), 1, fh) != 1  ||
      fread(trnname, sizeof(trnname), 1, fh) != 1                   ||
      fread(&trnmode, sizeof(trnmode), 1, fh) != 1)
    { goto ReadError;
    }
  if (version >= 53)
  { if (fread(&winnerpoints, sizeof(winnerpoints), 1, fh) != 1      ||
	fread(&drawpoints, sizeof(drawpoints), 1, fh) != 1)
    { goto ReadError;
    }
  }
  else
  { winnerpoints = 2;
    drawpoints = 1;
  }
  if (!import)
  { NumRounds = numrounds;
    RankingFirst = rankingfirst;
    NumPlayers = numplayers;
    NumGamesMissing = numgamesmissing;
    strcpy(TrnName, trnname);
    TrnMode = trnmode;
    WinnerPoints = winnerpoints;
    DrawPoints = drawpoints;
  }


  for (i = 0;  i < numplayers;  i++)
  { int readsize = sizeof(*tn) + (import ? 0 : sizeof(*gm)*numrounds);
    int seeksize = import ? sizeof(*gm)*numrounds : 0;

    if ((tn = GetMem(memlist, readsize))  ==  NULL)
    { goto Error;
    }

    if (fread (tn, readsize, 1, fh)  !=  1   ||
	(seeksize != 0  &&  fseek(fh, seeksize, SEEK_CUR)))
    { goto ReadError;
    }

    tn->Tn_Node.ln_Name = tn->Name;
    AddTail(plrlist, (struct Node *) tn);

    if (!import)
    { if (NumRounds != 0)
      tn->First_Game = gm = (struct Game *)(tn+1);
      for (j = 0;  j < NumRounds-1;  j++, gm++)
      { gm->Next = gm+1;
      }
    }
  }

  if (!import)
  { for (tn = (struct Player *) PlayerList.lh_Head;
	 tn->Tn_Node.ln_Succ != NULL;
	 tn = (struct Player *) tn->Tn_Node.ln_Succ)
    { NewAddress(&tn->RankNext);
      for (gm = tn->First_Game;  gm != NULL;  gm = gm->Next)
      { NewAddress(&gm->Opponent);
      }
    }
    NewAddress(&RankingFirst);

    IsSaved = TRUE;
    strcpy(TrnFileName, name);
  }


  fclose(fh);
  return(RETURN_OK);

ReadError:
  ShowError((char *) MSG_READ_ERROR, IoErr(), name);
Error:
  fclose(fh);
  if (!import)
  { DeleteTournament(NULL);
  }
  return(RETURN_ERROR);
}




/*
    TestSaved() checks, if the current tournament has changed since the
    last load or save. The user is asked for saving, if it has.

    Result: FALSE, if the user cancels, TRUE otherwise.
*/
int TestSaved(void)

  { if (IsSaved)
      { return(TRUE);
      }

    return(AskSave());
  }




/*
    NewTournament() brings up a window asking for new tournament data.
    The old tournament gets removed, if successfull.
*/
void NewTournament(void)

{ char NewTrnName[TRNNAME_LEN+1];
  int running = 1;
  int winnerpoints, drawpoints;

  NewTrnName[0] = '\0';
  if (InitTrnWnd(NewTrnName, DefaultWinnerPoints, DefaultDrawPoints))
  { while (running == 1)
    { running = ProcessTrnWnd(NewTrnName, &winnerpoints, &drawpoints);
    }
    TerminateTrnWnd();
    if (running == -1)
    { DeleteTournament(NewTrnName);
      IsSaved = FALSE;
    }
  }
  WinnerPoints = winnerpoints;
  DrawPoints = drawpoints;
}




/*
    My beloved routine: The About() function... :-)
*/
void About(void)

{ static char *txt = "\n"
		     "Chaos V5.4     The Chess HAppening Organisation "
			"System\n"
		     "\n"
		     "Copyright © 1993 by       Jochen Wiedmann\n"
		     "                          Am Eisteich 9\n"
		     "                          72555 Metzingen\n"
		     "                          Germany\n"
		     "\n"
		     "                          Phone: (0049) +7123 14881\n"
		     "                          Internet: jochen.wiedmann@zdv.uni-tuebingen.de\n"
		     "\n\n";

  InitOutput((char *) MSG_ABOUT_TITLE, "", "", "", NULL,
	     DEVICE_Screen, 0, 0);

  if (longlprint(txt)  &&
      longlprint((char *) MSG_ABOUT_PERMISSION)  &&
      longlprint((char *) MSG_ABOUT_THANKS1)  &&
      longlprint((char *) MSG_ABOUT_THANKS2))
  { ProcessOutput();
  }

  TerminateOutput();
}

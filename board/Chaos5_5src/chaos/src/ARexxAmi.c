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


    $RCSfile: ARexxAmi.c,v $
    $Revision: 3.2 $
    $Date: 1994/10/11 20:44:56 $

    This file contains the functions of the ARexx port. I don't expect them
    to be interesting besides the Amiga.

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

#include <ctype.h>



#ifdef AMIGA
#ifndef AZTEC_C
SAVEDS ASM static ULONG ARexxCmdFunc(REG(a0) struct Hook *hook,
				     REG(a1) char *args[])

{ extern void MakeDisplay(void);
  extern int EnableARexx;
  extern int NoWindow;
  ULONG result;
  HOOKFUNC func = hook->h_SubEntry;
  typedef ULONG (*MYHOOKFUNC)(char **);

  if (!EnableARexx)
  { return(RETURN_ERROR);
  }
  result = (*((MYHOOKFUNC) func))(args);
  if (!NoWindow)
  { MakeDisplay();
  }
  return(result);
}
#else   /*  AZTEC_C */
extern ULONG ARexxCmdFunc(struct Hook *, char **);
#asm
		xref    _geta4
		xref    _EnableARexx
		xref    _MakeDisplay
		xref    _NoWindow
_ARexxCmdFunc:  move.l  a4,-(sp)
		jsr     _geta4
		move.l  #10,d0
		tst.l   _EnableARexx
		bne     ARexxCmdFuncE
		move.l  a1,-(sp)
		move.l  12(a0),a0
		jsr     (a0)
		add.l   #4,sp
		tst.l   _NoWindow
		bne     ARexxCmdFuncE
		move.l  d0,-(sp)
		jsr     _MakeDisplay
		move.l  (sp)+,d0
ARexxCmdFuncE:  move.l  (sp)+,a4
		rts
#endasm
#endif  /*  AZTEC_C */




/*
    NewTrnCmd creates a new tournament.

    Inputs: NAME  - the new tournament's name
	    FORCE - suppress asking the user for confirmation, if current
		    tournament isn't saved
*/
ULONG NewTrnCmd(char *args[])

{
  if (!(ULONG)args[1]  &&  !TestSaved)
  { return(RETURN_WARN);
  }

  DeleteTournament(args[0]);
  return(RETURN_OK);
}
struct Hook NewTrnCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			     (HOOKFUNC) NewTrnCmd};




/*
    LoadTrn loads a tournament

    Inputs: FILE  - the name of the file to be loaded
	    FORCE - suppress asking the user for confirmation, if current
		    tournament isn't saved
*/
ULONG LoadTrnCmd(char *args[])

{
  if (!(ULONG)args[1]  &&  !TestSaved)
  { return(RETURN_WARN);
  }

  return((ULONG) LoadTournament(args[0], NULL, NULL));
}
struct Hook LoadTrnCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc, 
			      (HOOKFUNC) LoadTrnCmd};




/*
    SaveTrn saves a tournament

    Inputs: FILE  - the name of the file to be written
	    ICON  - create an icon
*/
ULONG SaveTrnCmd(char *args[])

{ int makeicons = MakeIcons;
  int result;

  MakeIcons = (ULONG)args[1];
  result = SaveTournament(args[0]);
  MakeIcons = makeicons;
  return((ULONG) (result ? RETURN_OK : RETURN_ERROR));
}
struct Hook SaveTrnCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			      (HOOKFUNC) SaveTrnCmd};




/*
    AddPlrCmd adds a new player

    Inputs: NAME    - the players name
	    STREET, VILLAGE, CHESSCLUB, BIRTHDAY, PHONE, RATING, ELO
		    - the corresponding fields in the player structure
	    FLAGS   - a string, that may contain the characters
		      s,j,w,a,b,c,d,e corresponding to the flags
		      TNFLAGSF_SENIOR, TNFLAGSF_JUNIOR, TNFLAGSF_WOMAN
		      and TNFLAGSFJUNIORA, ..., TNFLAGSF_JUNIORE
	    NOUSER  - a flag which indicates, that the user should not be
		      asked
*/
static void getstr(char *dest, char *src, int maxlen, ULONG *result)
{ int len;

  if (src != NULL)
  { len = strlen(src);

    if (len > maxlen)
    { *result = RETURN_WARN;
      strncpy(dest, src, maxlen);
      dest[maxlen] = '\0';
    }
    else
    { strcpy(dest, src);
    }
  }
}
static int getflags(char *flagsstr, ULONG *result)
{ int flags = 0;

  while (flagsstr != NULL  &&  *flagsstr != '\0')
  { switch(ToLower((int) *flagsstr++))
    { case 's':
	flags |= TNFLAGSF_SENIOR;
	break;
      case 'j':
	flags |= TNFLAGSF_JUNIOR;
	break;
      case 'w':
	flags |= TNFLAGSF_WOMAN;
	break;
      case 'a':
	flags |= TNFLAGSF_JUNIOR|TNFLAGSF_JUNIORA;
	break;
      case 'b':
	flags |= TNFLAGSF_JUNIOR|TNFLAGSF_JUNIORB;
	break;
      case 'c':
	flags |= TNFLAGSF_JUNIOR|TNFLAGSF_JUNIORC;
	break;
      case 'd':
	flags |= TNFLAGSF_JUNIOR|TNFLAGSF_JUNIORD;
	break;
      case 'e':
	flags |= TNFLAGSF_JUNIOR|TNFLAGSF_JUNIORE;
	break;
      default:
	*result = RETURN_WARN;
    }
    if ((flags & TNFLAGSF_SENIOR)  &&
	(flags & TNFLAGSF_JUNIOR|TNFLAGSF_JUNIORA|TNFLAGSF_JUNIORB|
		 TNFLAGSF_JUNIORC|TNFLAGSF_JUNIORD|TNFLAGSF_JUNIORE))
    { *result = RETURN_WARN;
    }
  }
  return(flags);
}
ULONG AddPlrCmd(char *args[])

{ struct Player plr;
  ULONG result = 0;

  /*
      Check, if we may enter new players.
  */
  if (NumRounds >= 1 &&  RoundRobinTournament)
  { return(RETURN_ERROR);
  }
  if (NumRounds > 1  &&  SwissPairingTournament)
  { return(RETURN_ERROR);
  }
  if (NumRounds > 0)
  { if (!args[9]  &&
	!AskContinue((char *) MSG_NEW_PLAYER_REQUEST))
    { return(RETURN_ERROR);
    }
  }


  memset(&plr, 0, sizeof(plr));
  getstr(plr.Name, args[0], NAMELEN, &result);
  if (result != 0)
  { return(RETURN_ERROR);
  }
  getstr(plr.Street, args[1], NAMELEN, &result);
  getstr(plr.Village, args[2], NAMELEN, &result);
  getstr(plr.ChessClub, args[3], NAMELEN, &result);
  getstr(plr.BirthDay, args[4], NAMELEN, &result);
  getstr(plr.PhoneNr, args[5], PHONENRLEN, &result);
  getstr(plr.DWZ, args[6], DWZLEN, &result);
  if (args[7] != NULL)
  { plr.ELO = *((ULONG *) args[7]);
  }
  plr.Flags = getflags(args[8], &result);

  if (!CheckPlayerValid(&plr, !args[9]))
  { return(RETURN_ERROR);
  }

  if (!AddPlayer(&plr))
  { return(RETURN_ERROR);
  }
  return(result);
}
struct Hook AddPlrCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			     (HOOKFUNC) AddPlrCmd};




/*
    ModifyPlrCmd modifies a new player

    Inputs: PLAYER  - the players name
	    NAME, STREET, VILLAGE, CHESSCLUB, BIRTHDAY, PHONE, RATING, ELO
		    - the corresponding fields in the player structure
	    FLAGS   - a string, that may contain the characters
		      s,j,w,a,b,c,d,e corresponding to the flags
		      TNFLAGSF_SENIOR, TNFLAGSF_JUNIOR, TNFLAGSF_WOMAN
		      and TNFLAGSFJUNIORA, ..., TNFLAGSF_JUNIORE
	    NOUSER  - a flag which indicates, that the user should not be
		      asked

    Note, that only those fields are modified, for which an argument is
    supplied
*/
static struct Player *getplayer(char *arg)
{ struct Player *plr;

  if (arg)
  { for (plr = (struct Player *) PlayerList.lh_Head;
	 plr->Tn_Node.ln_Succ != NULL;
	 plr = (struct Player *) plr->Tn_Node.ln_Succ)
    { if (Stricmp((STRPTR) plr->Name, (STRPTR) arg)  ==  0)
      { return(plr);
      }
    }
  }
  return(NULL);
}
ULONG ModifyPlrCmd(char *args[])

{ struct Player plr, *plrptr;
  ULONG result = 0;

  /*
      Check, if we really may modify players
  */
  if (!args[10]  &&  NumRounds > 0  &&
      !AskContinue((char *) MSG_MODIFY_PLAYER_REQUEST))
  { return(RETURN_ERROR);
  }

  if (plrptr = getplayer(args[0]))
  { memcpy(&plr, plrptr, sizeof(plr));
    getstr(plr.Name, args[1], NAMELEN, &result);
    getstr(plr.Street, args[2], NAMELEN, &result);
    getstr(plr.Village, args[3], NAMELEN, &result);
    getstr(plr.ChessClub, args[4], NAMELEN, &result);
    getstr(plr.BirthDay, args[5], NAMELEN, &result);
    getstr(plr.PhoneNr, args[6], PHONENRLEN, &result);
    getstr(plr.DWZ, args[7], DWZLEN, &result);
    if (args[7] != NULL)
    { plr.ELO = *((ULONG *) args[8]);
    }
    plr.Flags = getflags(args[9], &result);

    { int result;

      Remove((struct Node *) plrptr);
      result = CheckPlayerValid(&plr, !args[10]);
      Insert(&PlayerList, (struct Node *) plrptr,
	     (struct Node *) plrptr->Tn_Node.ln_Pred);
      if (!result)
      { return(RETURN_ERROR);
      }
    }

    ModifyPlayer(plrptr, &plr);
    return(result);
  }
  return(RETURN_ERROR);
}
struct Hook ModifyPlrCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
				(HOOKFUNC) ModifyPlrCmd};




/*
    DelPlrCmd deletes a player

    Inputs: PLAYER - the players name
	    FORCE  - suppresses asking the user for confirmation
*/
ULONG DelPlrCmd(char *args[])

{ struct Player *plrptr;

  if ((NumRounds > 0  &&  RoundRobinTournament)  ||
      (NumGamesMissing > 0  &&  SwissPairingTournament))
  { return(RETURN_ERROR);
  }

  if (plrptr = getplayer(args[0]))
  { if ((plrptr->Flags & TNFLAGSF_WITHDRAWN)  ||
	(!(ULONG)args[1]  &&
	 !AskContinue((char *) (NumRounds == 0)  ?
					MSG_DELETE_THIS_PLAYER_REQUEST  :
					MSG_THIS_PLAYER_GONE_REQUEST,
		      plrptr->Name)))
    { return(RETURN_WARN);
    }
    DeletePlayer(plrptr);
  }
  return(RETURN_ERROR);
}
struct Hook DelPlrCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			     (HOOKFUNC) DelPlrCmd};




/*
    SetPlrCmd sets a player

    Inputs: PLAYER   - the player, that should be set
	    INIT     - discard set players
	    FORCE    - suppresses asking the user for confirmation, if
		       players should be paired, that had the same color
		       in the last two rounds
	    SETCOLOR - colors are determined by the order of entering the
		       players
*/
static ULONG SetPlrCmd(char **args)

{ struct Player *plr;

  if (args[1]  &&  !InitSetGames())
    { return(RETURN_ERROR);
    }
  if (!args[0])
  { return ((ULONG) (args[1] ? RETURN_OK : RETURN_ERROR));
  }
  if (!(plr = getplayer(args[0])))
  { return(RETURN_ERROR);
  }
  return((ULONG) (SetPlayer(plr, (int) args[2], (int) args[3])  ?
		    RETURN_OK  :  RETURN_ERROR));
}
struct Hook SetPlrCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			     (HOOKFUNC) SetPlrCmd};




/*
    DoPairingsCmd creates a new round

    Inputs: SWISSPAIRING    - create a swiss pairing tournament
	    ROUNDROBIN      - create a round robin tournament (FIDE system)
	    ROUNDROBINSHIFT - create a round robin tournament (shift system)
	    NOUSER          - suppresses setting games by the user
*/
static ULONG DoPairingsCmd(char *args[])

{ int mode = TrnMode;

  if (args[0])
  { if (RoundRobinTournament  ||  args[1]  ||  args[2])
    { return(RETURN_ERROR);
    }
    else
    { mode = TNMODEF_SWISS_PAIRING;
    }
  }

  if (args[1])
  { if ((TrnMode & (TNMODEF_SWISS_PAIRING|TNMODEF_SHIFT_SYSTEM))  ||
	args[2])
    { return(RETURN_ERROR);
    }
    else
    { mode = TNMODEF_ROUND_ROBIN;
    }
  }

  if (args[2])
  { if (SwissPairingTournament  ||
	(TrnMode & (TNMODEF_ROUND_ROBIN|TNMODEF_SHIFT_SYSTEM)
			== TNMODEF_ROUND_ROBIN))
    { return(RETURN_ERROR);
    }
    else
    { mode = TNMODEF_ROUND_ROBIN|TNMODEF_SHIFT_SYSTEM;
    }
  }

  if (mode == 0)
  { return(RETURN_ERROR);
  }

  return((ULONG) (DoPairings(mode, FALSE, !(int) args[3]) ? 0 : RETURN_ERROR));
}
struct Hook DoPairingsCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
				 (HOOKFUNC) DoPairingsCmd};




/*
    RsltCmd allows to enter a result

    Inputs: WHITE     - the white players name
	    BLACK     - the black players name
	    RESULT    - the result (-1 = result missing, 0 = black wins,
			1 = draw, 2 = white wins)
	    NOTPLAYED - indicates, that the game wasn't really played
*/
ULONG RsltCmd(char *args[])

{ struct Game *gm;
  struct GameNode gn;
  int round;

  if (NumRounds == 0  ||  (ULONG)args[2] < -1  ||  (ULONG)args[2] > 2)
  { return(RETURN_ERROR);
  }

  for(gn.White = (struct Player *) PlayerList.lh_Head;
      gn.White->Tn_Node.ln_Succ != NULL;
      gn.White = (struct Player *) gn.White->Tn_Node.ln_Succ)
  { if (Stricmp((STRPTR) gn.White->Name, (STRPTR) args[0])  ==  0)
    { for (gm = gn.White->First_Game, round = 1;  gm != NULL;
	   gm = gm->Next, round++)
      { if (Stricmp((STRPTR) gm->Opponent->Name, (STRPTR) args[1])  ==  0)
	{ gn.Result = *(ULONG *)args[2];
	  gn.Flags = (ULONG)args[3] ? GMFLAGSF_NOFIGHT : 0;
	  gn.Black = gm->Opponent;
	  EnterResult(&gn, round);
	}
      }
      break;
    }
  }
  return(RETURN_ERROR);
}
struct Hook RsltCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			   (HOOKFUNC) RsltCmd};




/*
    PlrLstCmd prints the list of players

    Inputs: FILE  - the file, which should receive the output
	    SHORT - makes the output short
*/
static int getdevice(char *devicestr)
{ int device = DEVICE_FileAscii;

  if (Stricmp((STRPTR) devicestr, (STRPTR) "prt:")  ==  0)
  { device = DEVICE_PrinterDraft;
  }
  else if (Stricmp((STRPTR) devicestr, (STRPTR) "prt:LQ")  ==  0)
  { device = DEVICE_PrinterLQ;
  }
  return(device);
}
ULONG PlrLstCmd(char *args[])

{ extern int OutputReturnCode;

  if (NumPlayers == 0)
  { return(RETURN_ERROR);
  }

  OutPlayerList(args[0], getdevice(args[0]), !(ULONG)args[1]);
  return((ULONG) OutputReturnCode);
}
struct Hook PlrLstCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			     (HOOKFUNC) PlrLstCmd};




/*
    IntRatCmd prints the internal rankings.

    Inputs: FILE  - the file, which should receive the output
*/
ULONG IntRatCmd(char *args[])

{ extern int OutputReturnCode;

  if (NumPlayers == 0)
  { return(RETURN_ERROR);
  }

  OutInternalRankings(args[0], getdevice(args[0]));
  return((ULONG) OutputReturnCode);
}
struct Hook IntRatCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			     (HOOKFUNC) IntRatCmd};




/*
    TblCmd prints the table.

    Inputs: FILE    - the file, which should receive the output
	    TABMODE - the table's sorting mode (0 = simple, 1 = Buchholz,
		      2 = Extended Buchholz, 3 = Sonneborn-Berger)
		      default is simple
	    PLRMODE - the code, which players should be included into the
		      table (0 = all, 1 = seniors, 2 = juniors, 3 = women,
		      4 = juniors (A), 5 = juniors (B), 6 = juniors (C),
		      7 = juniors (D), 8 = juniors (E))
		      default is all players
*/
int gettabmode(ULONG *mode)
{ int tabmode = 0;

  if (mode != NULL)
  { switch(*mode)
    { case 0:
	break;
      case 1:
	if (RoundRobinTournament)
	{ return(-1);
	}
	tabmode = TNMODEF_BUCHHOLZ;
	break;
      case 2:
	if (RoundRobinTournament)
	{ return(-1);
	}
	tabmode = TNMODEF_EXT_BUCHHOLZ;
	break;
      case 3:
	if (!SwissPairingTournament)
	{ tabmode = TNMODEF_SONNEBORN_BERGER;
	  break;
	}
      default:
	return(-1);
    }
  }
  return(tabmode);
}
ULONG TblCmd(char *args[])

{ extern int OutputReturnCode;
  int plrmode = 0;
  int tabmode;

  if (NumRounds == 0)
  { return(RETURN_ERROR);
  }

  if ((tabmode = gettabmode((ULONG *) args[1]))  == -1)
  { return(RETURN_ERROR);
  }

  if (args[2])
  { switch(*(ULONG *)args[2])
    { case 0:
	break;
      case 1:
	plrmode = TNFLAGSF_SENIOR;
	break;
      case 2:
	plrmode = TNFLAGSF_JUNIOR;
	break;
      case 3:
	plrmode = TNFLAGSF_WOMAN;
	break;
      case 4:
	plrmode = TNFLAGSF_JUNIORA;
	break;
      case 5:
	plrmode = TNFLAGSF_JUNIORB;
	break;
      case 6:
	plrmode = TNFLAGSF_JUNIORC;
	break;
      case 7:
	plrmode = TNFLAGSF_JUNIORD;
	break;
      case 8:
	plrmode = TNFLAGSF_JUNIORE;
	break;
      default:
	return(RETURN_ERROR);
    }
  }

  OutTable(args[0], getdevice(args[0]), plrmode, tabmode);
  return((ULONG) OutputReturnCode);
}
struct Hook TblCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			  (HOOKFUNC) TblCmd};




/*
    RndCmd prints the results of one round

    Inputs: FILE  - the file, which should receive the output
	    ROUND - the number of the round (default is the last round)
*/
ULONG RndCmd(char *args[])

{ extern int OutputReturnCode;
  int round;


  if ((round = NumRounds) == 0)
  { return(RETURN_ERROR);
  }

  if (args[1]  &&
      ((round = *(ULONG *)args[1]) <= 0  ||  round > NumRounds))
  { return(RETURN_ERROR);
  }

  OutRound(args[0], getdevice(args[0]), round);
  return((ULONG) OutputReturnCode);
}
struct Hook RndCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			  (HOOKFUNC) RndCmd};




/*
    TblPrgrssCmd prints the table of progress

    Inputs: FILE    - the file, which should receive the output
	    TABMODE - the table's sorting mode (see TblCmd)
*/
ULONG TblPrgrssCmd(char *args[])

{ extern int OutputReturnCode;
  int tabmode = 0;

  if (NumRounds == 0)
  { return(RETURN_ERROR);
  }

  if ((tabmode = gettabmode((ULONG *) args[1]))  == -1)
  { return(RETURN_ERROR);
  }

  OutTableProgress(args[0], getdevice(args[0]), tabmode);
  return((ULONG) OutputReturnCode);
}
struct Hook TblPrgrssCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
				(HOOKFUNC) TblPrgrssCmd};




/*
    CrossTableCmd prints a crosstable

    Inputs: FILE - the file, which should receive the output
	    TEX  - creates tex source
*/
ULONG CrssTblCmd(char *args[])

{ int device = getdevice(args[0]);

  if (!RoundRobinTournament)
  { return (RETURN_ERROR);
  }
  if (args[1])
  { device = DEVICE_FileTeX;
  }

  OutCrossTable(args[0], device);
  return((ULONG) OutputReturnCode);
}
struct Hook CrssTblCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			      (HOOKFUNC) CrssTblCmd};




/*
    PlrCrdsCmd prints player cards

    Inputs: FILE - the file, which should receive the output
	    TEX  - creates tex source
*/
ULONG PlrCrdsCmd(char *args[])

{ int device = getdevice(args[0]);

  if (!SwissPairingTournament)
  { return(RETURN_ERROR);
  }
  if (args[1])
  { device = DEVICE_FileTeX;
  }

  OutPlayerCards(args[0], device);
  return((ULONG) OutputReturnCode);
}
struct Hook PlrCrdsCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			      (HOOKFUNC) PlrCrdsCmd};




/*
    DWZRprtCmd prints the DWZ report

    Inputs: FILE - the file, which should receive the output
*/
ULONG DWZRprtCmd(char *args[])

{
  if (NumRounds == 0)
  { return(RETURN_ERROR);
  }

  OutDWZReport(args[0], getdevice(args[0]));
  return((ULONG) OutputReturnCode);
}
struct Hook DWZRprtCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			      (HOOKFUNC) DWZRprtCmd};




/*
    WindowCmd switches the main window on or off

    Inputs: ON  - switch the window on
	    OFF - switch it off
*/
ULONG WindowCmd(char *args[])

{ extern int NoWindow;
  int open;

  if (args[0] == args[1])
  { return(RETURN_ERROR);
  }
  NoWindow = (int) args[1];
  get(MainWnd, MUIA_Window_Open, &open);
  if (!open != NoWindow)
  { set(MainWnd, MUIA_Window_Open, !open);
  }
  return(RETURN_OK);
}
struct Hook WindowCmdHook = {{NULL, NULL}, (HOOKFUNC) ARexxCmdFunc,
			     (HOOKFUNC) WindowCmd};



struct MUI_Command ARexxCommands[] =
  { {"NewTournament",   "NAME/A,FORCE/S",
     2,  &NewTrnCmdHook,    NULL, NULL, NULL, NULL, NULL },
    {"LoadTournament",  "FILE/A,FORCE/S",
     2,  &LoadTrnCmdHook,   NULL, NULL, NULL, NULL, NULL },
    {"SaveTournament",  "FILE/A,ICON/S",
     1,  &SaveTrnCmdHook,   NULL, NULL, NULL, NULL, NULL },
    {"AddPlayer",       "NAME/A,STREET/K,VILLAGE/K,CHESSCLUB/K,BIRTHDAY/K,PHONE/K,RATING/K,ELO/K/N,FLAGS/K,NOUSER/S",
     9,  &AddPlrCmdHook,    NULL, NULL, NULL, NULL, NULL },
    {"ModifyPlayer",    "PLAYER/A,NAME/K,STREET/K,VILLAGE/K,CHESSCLUB/K,BIRTHDAY/K,PHONE/K,RATING/K,ELO/K,FLAGS/K,NOUSER/S,",
     10, &ModifyPlrCmdHook, NULL, NULL, NULL, NULL, NULL },
    {"DeletePlayer",    "PLAYER/A,FORCE/S",
     2,  &DelPlrCmdHook,    NULL, NULL, NULL, NULL, NULL },
    {"SetPlayer",       "PLAYER,INIT/S,FORCE/S,SETCOLOR/S",
     3,  &SetPlrCmdHook,    NULL, NULL, NULL, NULL, NULL },
    {"DoPairings",      "SWISSPAIRING/S,ROUNDROBIN/S,ROUNDROBINSHIFT/S,NOUSER/S",
     4,  &DoPairingsCmdHook,NULL, NULL, NULL, NULL, NULL },
    {"EnterResult",     "WHITE/A,BLACK/A,RESULT/A/N,NOTPLAYED/S",
     4,  &RsltCmdHook,      NULL, NULL, NULL, NULL, NULL },
    {"PlayerList",      "FILE/A,SHORT/S",
     3,  &PlrLstCmdHook,    NULL, NULL, NULL, NULL, NULL },
    {"InternalRatings", "FILE/A",
     1,  &IntRatCmdHook,    NULL, NULL, NULL, NULL, NULL },
    {"Table",           "FILE/A,TABMODE/K/N,PLRMODE/K/N",
     3,  &TblCmdHook,       NULL, NULL, NULL, NULL, NULL },
    {"Round",           "FILE/A,NUMBER/N",
     2,  &RndCmdHook,       NULL, NULL, NULL, NULL, NULL },
    {"TableOfProgress", "FILE/A,TABMODE/K/N",
     2,  &TblPrgrssCmdHook, NULL, NULL, NULL, NULL, NULL },
    {"CrossTable",      "FILE/A,TEX/S",
     2,  &CrssTblCmdHook,   NULL, NULL, NULL, NULL, NULL },
    {"PlayerCards",     "FILE/A,TEX/S",
     2,  &PlrCrdsCmdHook,   NULL, NULL, NULL, NULL, NULL },
    {"DWZReport",       "FILE/A",
     1,  &DWZRprtCmdHook,   NULL, NULL, NULL, NULL, NULL },
    {"Window",          "ON/S,OFF/S",
     2,  &WindowCmdHook,    NULL, NULL, NULL, NULL, NULL },
    {NULL,              NULL,
     0,  NULL,              NULL, NULL, NULL, NULL, NULL }
  };
#endif  /*  AMIGA   */

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


    $RCSfile: Chaos.h,v $
    $Revision: 3.3 $
    $Date: 1994/11/19 19:32:01 $

    This is the include-file of the program. It defines the constants,
    structures and prototypes.

    Computer:   Amiga 1200                  Compiler:   Dice 2.07.54 (3.0)

    Author:     Jochen Wiedmann
		Am Eisteich 9
	  72555 Metzingen
		Tel. 07123 / 14881
		Internet: jochen.wiedmann@zdv.uni-tuebingen.de
*/


#ifndef CHAOS_H
#define CHAOS_H

#ifndef Chaos_CAT_H
#include "Chaos_Cat.h"
#endif

#ifdef AMIGA
#include <exec/lists.h>
#include <exec/memory.h>
#include <dos/dos.h>
#include <dos/exall.h>
#include <intuition/intuition.h>
#include <libraries/iffparse.h>
#include <libraries/mui.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/intuition.h>
#include <proto/utility.h>
#include <proto/iffparse.h>
#include <proto/muimaster.h>
#include <clib/alib_protos.h>

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>

#else   /*  !AMIGA                      */
#include <stdio.h>
#include <NonAmiga.h>
#endif  /*  AMIGA                       */



#define TRNFILENAME_LEN 512
#define TRNNAME_LEN 60

#define TNMODEB_SWISS_PAIRING       0
#define TNMODEB_ROUND_ROBIN         1
#define TNMODEB_BUCHHOLZ            2
#define TNMODEB_EXT_BUCHHOLZ        3
#define TNMODEB_SONNEBORN_BERGER    4
#define TNMODEB_SHIFT_SYSTEM        5
#define TNMODEF_SWISS_PAIRING (1 << TNMODEB_SWISS_PAIRING)
#define TNMODEF_ROUND_ROBIN (1 << TNMODEB_ROUND_ROBIN)
#define TNMODEF_BUCHHOLZ (1 << TNMODEB_BUCHHOLZ)
#define TNMODEF_EXT_BUCHHOLZ (1 << TNMODEB_EXT_BUCHHOLZ)
#define TNMODEF_SONNEBORN_BERGER (1 << TNMODEB_SONNEBORN_BERGER)
#define TNMODE_TABMASK (TNMODEF_BUCHHOLZ|TNMODEF_EXT_BUCHHOLZ| \
			TNMODEF_SONNEBORN_BERGER)
#define TNMODEF_SHIFT_SYSTEM (1 << TNMODEB_SHIFT_SYSTEM)
#define SwissPairingTournament (TrnMode & TNMODEF_SWISS_PAIRING)
#define RoundRobinTournament (TrnMode & TNMODEF_ROUND_ROBIN)


/*
    The struct Player holds all data of one participant.
*/
#define NAMELEN 30
#define BIRTHDAYLEN 10
#define PHONENRLEN 20
#define DWZLEN 10
struct Player
  { struct Node Tn_Node;            /*  This is used to build the alpha-
					betically sorted list of players.   */

    struct Player *LT_Succ;         /*  An internal list is builded when    */
    struct Player *LT_Pred;         /*  pairing the games. These fields     */
				    /*  are used for it.                    */

    struct Player *RankNext;        /*  Next in list of internal rankings   */
    struct Player *Opponent;        /*  Used for pairings                   */
    struct Player *Helpptr;         /*  Used for different things           */
    struct Game *First_Game;        /*  List of games                       */
    int Flags;                      /*  See below                           */
    short Nr;                       /*  Used for pairings                   */
    short GFlags, BoardNr;          /*  Used for pairings                   */
    short Points, Buchholz;         /*  Points, Buchholzpoints and extended */
    long  ExtBuchholz;              /*  Buchholzpoints                      */
    short HowMuchWhite;             /*  < 0 = Black; > 0 = White            */
    short HowMuchWhiteLast;         /*  < 0 = Black; > 0 = White            */
    short ELO;                      /*  International ELO number            */
    char DWZ[DWZLEN+1];             /*  German rating number                */
    char Name[NAMELEN+1];           /*  Name and prename                    */
    char Street[NAMELEN+1];         /*  address                             */
    char Village[NAMELEN+1];
    char PhoneNr[PHONENRLEN+1];
    char ChessClub[NAMELEN+1];      /*  Schachclub des Teilnehmers          */
    char BirthDay[BIRTHDAYLEN+1];   /*  Geburtsdatum des Teilnehmers        */
  };
/*
    Possible Flags in the player structure
*/
#define TNFLAGSB_SENIOR 31
#define TNFLAGSB_JUNIOR 30
#define TNFLAGSB_WOMAN  29
#define TNFLAGSB_JUNIORA 28
#define TNFLAGSB_JUNIORB 27
#define TNFLAGSB_JUNIORC 26
#define TNFLAGSB_JUNIORD 25
#define TNFLAGSB_JUNIORE 24
#define TNFLAGSB_WITHDRAWN 0    /*  Player has withdrawn                    */
#define TNFLAGSB_HADFREE 1      /*  Player had a free round                 */
#define TNFLAGSB_NOTDOWN 2      /*  Internally used for pairings            */
#define TNFLAGSB_SELECTED 3     /*  Internally used for player selections   */
#define TNFLAGSF_SENIOR (1 << TNFLAGSB_SENIOR)
#define TNFLAGSF_JUNIOR (1 << TNFLAGSB_JUNIOR)
#define TNFLAGSF_WOMAN  (1 << TNFLAGSB_WOMAN)
#define TNFLAGSF_JUNIORA (1 << TNFLAGSB_JUNIORA)
#define TNFLAGSF_JUNIORB (1 << TNFLAGSB_JUNIORB)
#define TNFLAGSF_JUNIORC (1 << TNFLAGSB_JUNIORC)
#define TNFLAGSF_JUNIORD (1 << TNFLAGSB_JUNIORD)
#define TNFLAGSF_JUNIORE (1 << TNFLAGSB_JUNIORE)
#define TNFLAGSF_WITHDRAWN (1 << TNFLAGSB_WITHDRAWN)
#define TNFLAGSF_HADFREE (1 << TNFLAGSB_HADFREE)
#define TNFLAGSF_NOTDOWN (1 << TNFLAGSB_NOTDOWN)
#define TNFLAGSF_SELECTED (1 << TNFLAGSB_SELECTED)



/*
    The Game structure holds all data of one game. The games of one
    participant build a linked list. Each game is therefore represented
    by two game structures: One in the white players list and one in the
    black players list.
*/
struct Game
  { struct Game *Next;          /*  Pointer to next game                    */
    struct Player *Opponent;    /*  Pointer to Opponent                     */
    short BoardNr;              /*  Board number                            */
    short Result;               /*  Result (-1 = Result is missing)         */
    short Flags;                /*  See below                               */
  };
/*
    Possible flags in the game structure
*/
#define GMFLAGSB_NOFIGHT        0
#define GMFLAGSB_POINTFORFREE   1
#define GMFLAGSB_WITHDRAWN      2
#define GMFLAGSB_WHITE          3
#define GMFLAGSF_NOFIGHT (1 << GMFLAGSB_NOFIGHT)
#define GMFLAGSF_POINTFORFREE (1 << GMFLAGSB_POINTFORFREE)
#define GMFLAGSF_WITHDRAWN (1 << GMFLAGSB_WITHDRAWN)
#define GMFLAGSF_WHITE (1 << GMFLAGSB_WHITE)




/*
    Possible output devices
*/
#define DEVICE_Screen       0
#define DEVICE_PrinterDraft 1
#define DEVICE_PrinterLQ    2
#define DEVICE_FileAscii    3
#define DEVICE_FileTeX      4




/*
    The structure GameNode is used to build a list of all games of one round.
*/
struct GameNode
  { struct MinNode gn_Node;
    struct Player *White, *Black;
    short BoardNr;
    short Result, Flags;  /*  of White  */
    char Text[80];
  };



/*
    Prototypes of main.c
*/
extern struct Library *MUIMasterBase;
extern struct ExecBase *SysBase;
extern struct DosLibrary *DOSBase;
extern struct IntuitionBase *IntuitionBase;
extern struct Library *UtilityBase;
extern struct Library *IconBase;
extern char *AVERSION;
extern char *PVERSION;
extern char *MVERSION;
extern char *VERVERSION;
extern struct List PlayerList;
extern int IsSaved;
extern int OutputDevice;
extern char TrnFileName [TRNFILENAME_LEN+1];
extern int AllowErrorMessage;
extern int NumRounds;
extern struct Player *RankingFirst;
extern int NumPlayers;
extern int NumGamesMissing;
extern char TrnName [TRNNAME_LEN+1];
extern int DefaultWinnerPoints;
extern int DefaultDrawPoints;
extern int WinnerPoints;
extern int DrawPoints;
extern int TrnMode;


/*
    Prototypes of MaiAmi.c
*/
#ifdef AMIGA
extern int MakeIcons;
extern char IconName[TRNFILENAME_LEN+1];
extern char ProgName[TRNFILENAME_LEN+1];
extern APTR App;
extern APTR MainWnd;
#endif

extern void OpenLibs(void);
extern void InitRandom(void);
extern void DoStartup(int argc, char *argv[]);
extern void InitMainWnd(void);
extern void ProcessMainWnd(void);
extern void TerminateMainWnd(void);
extern void CloseLibs(void);
extern void ShowError(char *, ...);
extern void MemError(void);
#ifdef AMIGA
extern void MUIError(char *);
#endif  /*  AMIGA   */


/*
    Prototypes of Memory.c
*/
extern void *GetMem(void **, ULONG);
extern void PutMem(void *);
extern void PutMemList(void **);
extern void PutMemAll(void);
extern char *GetStringMem(void **, char *);
extern void MoveMemList(void **, void **);


/*
    Prototypes of Project.c
*/
extern void *TrnMem;
extern void DeleteTournament(char *);
extern int TestSaved(void);
extern int LoadTournament(char *, void **, struct List *);
extern int SaveTournament(char *);
extern void NewTournament(void);
extern void About(void);


/*
    Prototypes of ProjectAmi.c
*/
extern char *FileRequest(char *, char *, char *, int);
extern int AskSave(void);
extern void CreateIcon(char *);
extern void TerminateTrnWnd(void);
extern int InitTrnWnd(char *, int, int);
extern int ProcessTrnWnd(char *, int *, int *);


/*
    Prototypes of Players.c
*/
extern int CheckPlayerValid(struct Player *, int);
extern int AddPlayer(struct Player *);
extern void AddPlayers(void);
extern void ImportPlayers(void);
extern void ModifyPlayer(struct Player *, struct Player *);
extern int ModifyOnePlayer(struct Player *, int);
extern void ModifyPlayers(void);
extern void DeletePlayer(struct Player *);
extern void DeletePlayers(void);


/*
    Prototypes of PlayersAmi.c
*/
extern int AskContinue(char *, ...);
extern int AskExtContinue(char *, char *, ...);
extern int InitPlrWnd(char *);
extern int ProcessPlrWnd(struct Player *, int);
extern void TerminatePlrWnd(void);
extern int ProcessPlrSelWnd(char *, char *, char, int, struct List *);


/*
    Prototypes of Pairings.c
*/
extern struct Game *GameAddress(struct Player *, int);
extern void CreateRankings(void);
extern int GamePossible(struct Player *, struct Player *);
extern int DoPairings(int, int, int);


/*
    Prototypes of SwissPairing.c
*/
extern int DoFirstGroup(void);


/*
    Prototypes of PairingsAmi.c
*/
extern int InitSetGames(void);
extern int SetPlayer(struct Player *, int, int);
extern int GetSettings(int);


/*
    Prototypes of Rounds.c
*/
extern void FormatGame(struct GameNode *, int);
extern struct MinList *GetRound(void **, int, int, int);
extern void EnterResult(struct GameNode *, int);
extern void EnterResults(int);


/*
    Prototypes of RoundsAmi.c
*/
extern int GetRoundNr(void);
extern void TerminateRsltWnd(void);
extern int InitRsltWnd(char *, struct MinList *);
extern int ProcessRsltWnd(struct MinList *);


/*
    Prototypes of Out.c
*/
extern int tdwz(struct Player *);
extern void PointsToA(char *, long);
extern int longlprint(char *);
extern int lprint(char *);
extern void OutPlayerList(char *, int, int);
extern void OutInternalRankings(char *, int);
extern void OutRound(char *, int, int);
extern void OutTable(char *, int, int, int);
extern void OutTableProgress(char *, int, int);
extern struct Player *MakeTable(int);
extern void OutCrossTable(char *, int);
extern void OutPlayerCards(char *, int);


/*
    Prototypes for OutAmi.c
*/
extern int CenterText(int);
extern int AskForBirthday(struct Player *);
extern int InitOutput(char *, char *, char *, char *, char *, int, int, int);
extern void ProcessOutput(void);
extern void TerminateOutput(void);


/*
    Prototypes for OutDWZ.c
*/
extern int atotm(char *, struct tm *);
extern void OutDWZReport(char *, int);


/*
    Debugging stuff
*/
#ifdef DEBUG
#define strlen dbg_strlen
extern size_t dbg_strlen(const char *);
#define strcpy dbg_strcpy
extern char *strcpy(char *, const char *);
#define sprintf dbg_sprintf
extern int sprintf(char *dest, const char *fmt, ...);
#define fprintf dbg_fprintf
extern int fprintf(FILE *fh, const char *fmt, ...);
#define printf dbg_printf
extern int printf(const char *fmt, ...);
extern void kprintf(const char *, ...);
#endif



#ifdef AMIGA
/*
    Some compiler specific stuff (how to use register arguments)
*/
#ifdef _DCC
#define REG(x) __ ## x
#define ASM
#define SAVEDS __geta4
#endif  /*  _DCC    */
#ifdef __SASC
#define REG(x) register __ ## x
#define ASM    __asm
#define SAVEDS __saveds
#endif  /*  __SASC  */
#ifdef AZTEC_C
#define REG(x)
#define ASM
#define SAVEDS
#endif  /*  AZTEC_C */


/*
    Check if we use 2.0-Includes.
*/
#ifdef GFLG_RELSPECIAL
#define V39_INCLUDES
#endif  /*  GFLG_RELSPECIAL */
#endif  /*  AMIGA           */
#endif  /*  !CHAOS_H        */

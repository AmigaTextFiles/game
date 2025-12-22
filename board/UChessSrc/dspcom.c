#define CLEARHISTBETWEENMOVES // old way to handle hist table
/*
 * dspcom.c - C source for GNU CHESS
 *
 * Copyright (c) 1988,1989,1990 John Stanback
 * Copyright (c) 1992 Free Software Foundation
 *
 * This file is part of GNU CHESS.
 *
 * GNU Chess is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * GNU Chess is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GNU Chess; see the file COPYING.  If not, write to
 * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */
#include "gnuchess.h"
void calc_pgm_rating(void);
void DoEasy(void);
void DoIntermediate(void);
void DoAdvanced(void);

#define PTRHEIGHT 55
extern UWORD chip myPointer[];

#define MYREPLY (1<<InputReply->mp_SigBit)
extern struct MsgPort *InputReply;
extern struct MsgPort *InThreadPort;
extern struct myMsgStruct Global_Message;


#if defined NULLMOVE || defined DEEPNULL
extern short int __aligned no_null;
extern short int __aligned null;         /* Null-move already made or not */
extern short int __aligned PVari;        /* Is this the PV */
#endif
extern short __aligned Threat[MAXDEPTH];
extern unsigned short int __aligned PrVar[MAXDEPTH];
extern short __aligned PawnStorm;
extern short __aligned start_stage;
extern short __aligned thrashing_tt; /* must we recycle slots at random. TomV */
extern INTSIZE __aligned amigaboard[64],amigacolor[64];
int __aligned GetEntryDone;


extern int OpEntryRecvd;
extern char __aligned OpEntryStr[64];
extern INTSIZE Mwpawn[64], Mbpawn[64], Mknight[2][64], Mbishop[2][64];
extern char *version, *patchlevel;
char __aligned mvstr[8][8];
char __aligned mvstrhint[8][8];
char __aligned *InPtr;
#define BOOKMENUNUM 0xc2

#ifdef CACHE
extern struct etable __far __aligned etab[2][ETABLE];
#endif


void algbr2 (SHORT f, SHORT t, SHORT flag);
extern unsigned int TTadd;

int __aligned SecsPerMove=10;
extern int IllegalMove;
int __aligned func_num=0;
int __aligned thinkahead=0;
int __aligned ThinkInARow=0;
int __aligned ThinkAheadWorked=0;
int __aligned ThinkAheadDepth=0;

extern int backsrchaborted;
extern short int ISZERO;
extern short __aligned background;
int __aligned verifyquiet=0;
int __aligned MouseDropped=0;

#include <ctype.h>
#include <signal.h>

#ifdef AMIGA
#define __USE_SYSBASE
#include <exec/types.h>
#include <exec/exec.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
struct IntuiMessage __aligned globalmessage;
int __aligned globalmessage_valid=0;
extern struct Window __aligned *wG;
extern int procpri;
extern struct Process *myproc;
extern struct MenuItem MenuItem6;
extern struct Menu Menu1;
extern unsigned char __far cookedchar[128];
extern struct Menu __aligned Menu1;
#define MenuList1 Menu1
extern struct MenuItem __aligned MenuItem8ab;
extern int __aligned MenuStripSet;
#endif

#define SIGQUIT SIGINT

#ifdef MSDOS
#include <dos.h>
#include <conio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#else
#include <dos.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
/*
#include <sys/param.h>
#include <sys/types.h>
#include <sys/file.h>
#include <sys/ioctl.h>
*/
#endif


/*
 * ataks.h - Header source for GNU CHESS
 *
 * Copyright (c) 1988,1989,1990 John Stanback
 * Copyright (c) 1992 Free Software Foundation
 *
 * This file is part of GNU CHESS.
 *
 * GNU Chess is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * GNU Chess is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GNU Chess; see the file COPYING.  If not, write to
 * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */
inline int
SqAtakd2 (ARGSZ int sq, ARGSZ int side)

/*
 * See if any piece with color 'side' ataks sq.  First check pawns then
 * Queen, Bishop, Rook and King and last Knight.
 */

{
  register INTSIZE u;
  register unsigned char *ppos, *pdir;
  INTSIZE xside;

  xside = side ^ 1;
  pdir = nextdir[ptype[xside][pawn]][sq];
  u = pdir[sq];			/* follow captures thread */
  if (u != sq)
    {
      if (board[u] == pawn && color[u] == side)
	return (true);
      u = pdir[u];
      if (u != sq && board[u] == pawn && color[u] == side)
	return (true);
    }
  /* king capture */
  if (distance (sq, PieceList[side][0]) == 1)
    return (true);
  /* try a queen bishop capture */
  ppos = nextpos[bishop][sq];
  pdir = nextdir[bishop][sq];
  u = ppos[sq];
  do
    {
      if (color[u] == neutral)
	u = ppos[u];
      else
	{
	  if (color[u] == side && (board[u] == queen || board[u] == bishop))
	    return (true);
	  u = pdir[u];
	}
  } while (u != sq);
  /* try a queen rook capture */
  ppos = nextpos[rook][sq];
  pdir = nextdir[rook][sq];
  u = ppos[sq];
  do
    {
      if (color[u] == neutral)
	u = ppos[u];
      else
	{
	  if (color[u] == side && (board[u] == queen || board[u] == rook))
	    return (true);
	  u = pdir[u];
	}
  } while (u != sq);
  /* try a knight capture */
  pdir = nextdir[knight][sq];
  u = pdir[sq];
  do
    {
      if (color[u] == side && board[u] == knight)
	return (true);
      u = pdir[u];
  } while (u != sq);
  return (false);
}


#ifndef OLD_ALGBR
void
algbr (SHORT f, SHORT t, SHORT flag)


/*
 * Generate move strings in different formats.
 */

{
  int m3p;

  if (f != t)
    {
      /* algebraic notation */
      mvstr[0][0] = cxx[column (f)];
      mvstr[0][1] = rxx[row (f)];
      mvstr[0][2] = cxx[column (t)];
      mvstr[0][3] = rxx[row (t)];
      mvstr[4][0] = mvstr[0][4] = mvstr[3][0] = '\0';
      if (((mvstr[1][0] = pxx[board[f]]) == 'P') || (flag & promote))
	{
	  if (mvstr[0][0] == mvstr[0][2])	/* pawn did not eat */
	    {
	      mvstr[2][0] = mvstr[1][0] = mvstr[0][2];	/* to column */
	      mvstr[2][1] = mvstr[1][1] = mvstr[0][3];	/* to row */
	      m3p = 2;
	    }
	  else
	    /* pawn ate */
	    {
	      mvstr[2][0] = mvstr[1][0] = mvstr[0][0];	/* column */
	      mvstr[2][1] = mvstr[1][1] = mvstr[0][2];	/* to column */
	      mvstr[2][2] = mvstr[0][3];
	      m3p = 3;		/* to row */
	    }
	  if (flag & promote)
	    {
	      mvstr[0][4] = mvstr[1][2] = mvstr[2][m3p] = qxx[flag & pmask];
	      mvstr[0][5] = mvstr[1][3] = mvstr[2][m3p + 1] = mvstr[3][0] = '\0';
#ifdef CHESSTOOL 
	      mvstr[3][0] = mvstr[0][0];	/* Allow e7e8 for chesstool */
	      mvstr[3][1] = mvstr[0][1];
	      mvstr[3][2] = mvstr[0][2];
	      mvstr[3][3] = mvstr[0][3];
	      mvstr[3][4] = '\0';
#endif
	    } else mvstr[2][m3p] = mvstr[1][2] = '\0';
	}
      else
	/* not a pawn */
	{
	  mvstr[2][0] = mvstr[1][0];
	  mvstr[2][1] = mvstr[0][1];
	  mvstr[2][2] = mvstr[1][1] = mvstr[0][2];	/* to column */
	  mvstr[2][3] = mvstr[1][2] = mvstr[0][3];	/* to row */
	  mvstr[2][4] = mvstr[1][3] = '\0';
	  strcpy (mvstr[3], mvstr[2]);
          mvstr[3][1] = mvstr[0][0];
	  mvstr[4][0] = mvstr[1][0]; strcpy(&mvstr[4][1],mvstr[0]);
	  if (flag & cstlmask)
	    {
	      if (t > f)
		{
		  //strcpy (mvstr[1], mvstr[0]);
		  strcpy (mvstr[1], CP[5]);
		  strcpy (mvstr[2], CP[7]);
		}
	      else
		{
		  //strcpy (mvstr[1], mvstr[0]);
		  strcpy (mvstr[1], CP[6]);
		  strcpy (mvstr[2], CP[8]);
		}
	    }
	}
    }
  else
    mvstr[0][0] = mvstr[1][0] = mvstr[2][0] = mvstr[3][0] = mvstr[4][0] = '\0';
}

void
algbr2 (SHORT f, SHORT t, SHORT flag)


/*
 * Generate move strings in different formats.
 */

{
  int m3p;

  if (f != t)
    {
      /* algebraic notation */
      mvstrhint[0][0] = cxx[column (f)];
      mvstrhint[0][1] = rxx[row (f)];
      mvstrhint[0][2] = cxx[column (t)];
      mvstrhint[0][3] = rxx[row (t)];
      mvstrhint[4][0] = mvstrhint[0][4] = mvstrhint[3][0] = '\0';
      if (((mvstrhint[1][0] = pxx[board[f]]) == 'P') || (flag & promote))
	{
	  if (mvstrhint[0][0] == mvstrhint[0][2])	/* pawn did not eat */
	    {
	      mvstrhint[2][0] = mvstrhint[1][0] = mvstrhint[0][2];	/* to column */
	      mvstrhint[2][1] = mvstrhint[1][1] = mvstrhint[0][3];	/* to row */
	      m3p = 2;
	    }
	  else
	    /* pawn ate */
	    {
	      mvstrhint[2][0] = mvstrhint[1][0] = mvstrhint[0][0];	/* column */
	      mvstrhint[2][1] = mvstrhint[1][1] = mvstrhint[0][2];	/* to column */
	      mvstrhint[2][2] = mvstrhint[0][3];
	      m3p = 3;		/* to row */
	    }
	  if (flag & promote)
	    {
	      mvstrhint[0][4] = mvstrhint[1][2] = mvstrhint[2][m3p] = qxx[flag & pmask];
	      mvstrhint[0][5] = mvstrhint[1][3] = mvstrhint[2][m3p + 1] = mvstrhint[3][0] = '\0';
	    } else mvstrhint[2][m3p] = mvstrhint[1][2] = '\0';
	}
      else
	/* not a pawn */
	{
	  mvstrhint[2][0] = mvstrhint[1][0];
	  mvstrhint[2][1] = mvstrhint[0][1];
	  mvstrhint[2][2] = mvstrhint[1][1] = mvstrhint[0][2];	/* to column */
	  mvstrhint[2][3] = mvstrhint[1][2] = mvstrhint[0][3];	/* to row */
	  mvstrhint[2][4] = mvstrhint[1][3] = '\0';
	  strcpy (mvstrhint[3], mvstrhint[2]);
          mvstrhint[3][1] = mvstrhint[0][0];
	  mvstrhint[4][0] = mvstrhint[1][0]; strcpy(&mvstrhint[4][1],mvstrhint[0]);
	  if (flag & cstlmask)
	    {
	      if (t > f)
		{
		  strcpy (mvstrhint[1], CP[5]);
		  strcpy (mvstrhint[2], CP[7]);
		}
	      else
		{
		  strcpy (mvstrhint[1], CP[6]);
		  strcpy (mvstrhint[2], CP[8]);
		}
	    }
	}
    }
  else
    mvstrhint[0][0] = mvstrhint[1][0] = mvstrhint[2][0] = mvstrhint[3][0] = mvstrhint[4][0] = '\0';
}


#endif // not OLD_ALGBR

#ifndef OLD_VERIFY

int
VerifyMove (char *s, int iop, unsigned short *mv)

/*
 * Compare the string 's' to the list of legal moves available for the
 * opponent. If a match is found, make the move on the board.
 */

{
  static SHORT pnt, tempb, tempc, tempsf, tempst, cnt;
  static struct leaf xnode;
  struct leaf *node;
  char piece;
  int r,c,l;
  char mystr[80];

  *mv = 0;

  if ((s[1] >= 'a') && (s[1] <= 'h'))
   {
    if ((s[0] == 'n') || (s[0] == 'p') || (s[0] == 'b') ||
        (s[0] == 'k') || (s[0] == 'r') || (s[0] == 'q'))
     {
      s[0] = toupper(s[0]);
     }
   }
  if (iop == 2)
    {
      UnmakeMove (opponent, &xnode, &tempb, &tempc, &tempsf, &tempst);
      return (false);
    }
  cnt = 0;
  MoveList (opponent, 2);
  pnt = TrPnt[2];
  while (pnt < TrPnt[3])
    {
      node = &Tree[pnt++];
      algbr (node->f, node->t, (SHORT) node->flags);
      if (strcmp (s, mvstr[0]) == 0 || strcmp (s, mvstr[1]) == 0 ||
	  strcmp (s, mvstr[2]) == 0 || strcmp (s, mvstr[3]) == 0
		|| strcmp (s, mvstr[4]) == 0)
	{
	  cnt++;
	  xnode = *node;
	}
    }
  if (cnt == 1)
    {
      MakeMove (opponent, &xnode, &tempb, &tempc, &tempsf, &tempst, &INCscore);
      if (SqAtakd2 (PieceList[opponent][0], computer))
	{
	  UnmakeMove (opponent, &xnode, &tempb, &tempc, &tempsf, &tempst);
#if defined CHESSTOOL
	  printz (CP[78]);
#else
#ifdef NONDSP
#ifndef AMIGA
/* Illegal move in check */
	  printz (CP[77]);
	  printz ("\n");
#else
          DisplayComputerMove(CP[77]);
#endif
#else // not nondsp
/* Illegal move in check */
          if (!verifyquiet)
	   ShowMessage (CP[77]);
#endif
#endif /* CHESSTOOL */
	  return (false);
	}
      else
	{
	  if (iop == 1)
	    return (true);
	  UpdateDisplay (xnode.f, xnode.t, 0, (SHORT) xnode.flags);
	  if ((board[xnode.t] == pawn)
	      || (xnode.flags & capture)
	      || (xnode.flags & cstlmask))
	    {
	      Game50 = GameCnt;
	      ZeroRPT ();
	    }
	  GameList[GameCnt].depth = GameList[GameCnt].score = 0;
	  GameList[GameCnt].nodes = 0;
	  ElapsedTime (1);
	  GameList[GameCnt].time = (SHORT) (et+50)/100;
	  if (TCflag)
	    {
	      TimeControl.clock[opponent] -= (et-TCadd);
	      timeopp[oppptr] = et;
	      --TimeControl.moves[opponent];
	    }
	  *mv = (xnode.f << 8) | xnode.t;
	  algbr (xnode.f, xnode.t, false);
#ifdef AMIGA
      strcpy(mystr,mvstr[0]);
      r = mystr[3] - '1';
      c = mystr[2] - 'a';
      l = ((flag.reverse) ? locn (7 - r, 7 - c) : locn (r, c));
      if (color[l] == neutral)
       {
        piece = ' ';
       }
      else if (color[l] == white)
        piece = qxx[board[l]]; /* white are lower case pieces */
      else
        piece = pxx[board[l]]; /* black are upper case pieces */
      if (piece != ' ')
       AnimateAmigaMove(mystr,piece);
#endif
	  return (true);
	}
    }
#if defined CHESSTOOL
  printz (CP[78]);
#else
#ifdef NONDSP
/* Illegal move */
#ifdef AMIGA
  if (!verifyquiet)
   {
    //sprintf(mystr,CP[75],s);
    strcpy(mystr,"Illegal move (no match):");
    strcat(mystr,s);
    DisplayComputerMove(mystr);
   }
#else
  printz (CP[75], s);
#endif // AMIGA
#else
/* Illegal move */
  if (!verifyquiet)
   ShowMessage (CP[76]);
#endif
#endif /* CHESSTOOL */
#if !defined CHESSTOOL && !defined XBOARD
  if (cnt > 1)
    ShowMessage (CP[32]);
#endif /* CHESSTOOL */
  return (false);
}
#endif // not old verify




#ifdef OLD_ALGBR
void
algbr (INTSIZE int f, INTSIZE int t, INTSIZE int flag)


/*
 * Generate move strings in different formats.
 */

{
  int m3p;

  if (f != t)
    {
      /* algebraic notation */
      mvstr[0][0] = cxx[column (f)];
      mvstr[0][1] = rxx[row (f)];
      mvstr[0][2] = cxx[column (t)];
      mvstr[0][3] = rxx[row (t)];
      mvstr[0][4] = mvstr[3][0] = '\0';
      if (((mvstr[1][0] = pxx[board[f]]) == 'P') || (flag & promote))
	{
	  if (mvstr[0][0] == mvstr[0][2])	/* pawn did not eat */
	    {
	      mvstr[2][0] = mvstr[1][0] = mvstr[0][2];	/* to column */
	      mvstr[2][1] = mvstr[1][1] = mvstr[0][3];	/* to row */
	      m3p = 2;
	    }
	  else
	    /* pawn ate */
	    {
	      mvstr[2][0] = mvstr[1][0] = mvstr[0][0];	/* column */
	      mvstr[2][1] = mvstr[1][1] = mvstr[0][2];	/* to column */
	      mvstr[2][2] = mvstr[0][3];
	      m3p = 3;		/* to row */
	    }
	  if (flag & promote)
	    {
	      mvstr[0][4] = mvstr[1][2] = mvstr[2][m3p] = qxx[flag & pmask];
	      mvstr[0][5] = mvstr[1][3] = mvstr[2][m3p + 1] = mvstr[3][0] = '\0';
#ifdef CHESSTOOL
	      mvstr[3][0] = mvstr[0][0];	/* Allow e7e8 for chesstool */
	      mvstr[3][1] = mvstr[0][1];
	      mvstr[3][2] = mvstr[0][2];
	      mvstr[3][3] = mvstr[0][3];
	      mvstr[3][4] = '\0';
#endif
	    }
	  mvstr[2][m3p] = mvstr[1][2] = '\0';
	}
      else
	/* not a pawn */
	{
	  mvstr[2][0] = mvstr[1][0];
	  mvstr[2][1] = mvstr[0][1];
	  mvstr[2][2] = mvstr[1][1] = mvstr[0][2];	/* to column */
	  mvstr[2][3] = mvstr[1][2] = mvstr[0][3];	/* to row */
	  mvstr[2][4] = mvstr[1][3] = '\0';
	  strcpy (mvstr[3], mvstr[2]);
	  mvstr[3][1] = mvstr[0][0];
	  if (flag & cstlmask)
	    {
	      if (t > f)
		{
		  strcpy (mvstr[1], CP[5]);
		  strcpy (mvstr[2], CP[7]);
		}
	      else
		{
		  strcpy (mvstr[1], CP[6]);
		  strcpy (mvstr[2], CP[8]);
		}
	    }
	}
    }
  else
    mvstr[0][0] = mvstr[1][0] = mvstr[2][0] = mvstr[3][0] = '\0';
}
#endif // old_algbr

#ifdef OLD_VERIFY
int
VerifyMove (char *s, INTSIZE int iop, INTSIZE unsigned int *mv)

/*
 * Compare the string 's' to the list of legal moves available for the
 * opponent. If a match is found, make the move on the board.
 */

{
  static INTSIZE pnt, tempb, tempc, tempsf, tempst, cnt;
  int r,c,l;
  char mystr[80];
  char piece;
  static struct leaf xnode;
  struct leaf *node;

  if ((s[1] >= 'a') && (s[1] <= 'h'))
   {
    if ((s[0] == 'n') || (s[0] == 'p') || (s[0] == 'b') ||
        (s[0] == 'k') || (s[0] == 'r') || (s[0] == 'q'))
     {
      s[0] = toupper(s[0]);
     }
   }
  *mv = 0;
  if (iop == 2)
    {
      UnmakeMove (opponent, &xnode, &tempb, &tempc, &tempsf, &tempst);
      return (false);
    }
  cnt = 0;
  MoveList (opponent, 2);
  pnt = TrPnt[2];
  while (pnt < TrPnt[3])
    {
      node = &Tree[pnt++];
      algbr (node->f, node->t, (INTSIZE) node->flags);
      if (strcmp (s, mvstr[0]) == 0 || strcmp (s, mvstr[1]) == 0 ||
	  strcmp (s, mvstr[2]) == 0 || strcmp (s, mvstr[3]) == 0)
	{
	  cnt++;
	  xnode = *node;
	}
    }
  if (cnt == 1)
    {
      MakeMove (opponent, &xnode, &tempb, &tempc, &tempsf, &tempst, &INCscore);
      if (SqAtakd2 (PieceList[opponent][0], computer))
	{
	  UnmakeMove (opponent, &xnode, &tempb, &tempc, &tempsf, &tempst);
#if defined CHESSTOOL
	  printz (CP[15]);
#else
#ifdef NONDSP
/* Illegal move in check */
#ifndef AMIGA
	  printz (CP[77]);
	  printz ("\n");
#else
          DisplayComputerMove(CP[77]);
#endif
#else
/* Illegal move in check */
          if (!verifyquiet)
 	   ShowMessage (CP[77]);
#endif
#endif /* CHESSTOOL */
	  return (false);
	}
      else
	{
	  if (iop == 1)
	    return (true);
	  UpdateDisplay (xnode.f, xnode.t, 0, (INTSIZE) xnode.flags);
	  if ((board[xnode.t] == pawn)
	      || (xnode.flags & capture)
	      || (xnode.flags & cstlmask))
	    {
	      Game50 = GameCnt;
	      ZeroRPT ();
	    }
	  GameList[GameCnt].depth = GameList[GameCnt].score = 0;
	  GameList[GameCnt].nodes = 0;
	  ElapsedTime (1);
	  GameList[GameCnt].time = (INTSIZE) et;
	  if (TCflag)
	    {
	      TimeControl.clock[opponent] -= et;
	      timeopp[oppptr] = et;
	      --TimeControl.moves[opponent];
	    }
	  *mv = (xnode.f << 8) | xnode.t;
	  algbr (xnode.f, xnode.t, false);
#ifdef AMIGA
      strcpy(mystr,mvstr[0]);
      r = mystr[3] - '1';
      c = mystr[2] - 'a';
      l = ((flag.reverse) ? locn (7 - r, 7 - c) : locn (r, c));
      if (color[l] == neutral)
       {
	//DisplayBeep(0L);
        //Delay(25L);
	//DisplayBeep(0L);
        //Delay(25L);
	//DisplayBeep(0L);
        //Delay(25L);
        piece = ' ';
       }
      else if (color[l] == white)
        piece = qxx[board[l]]; /* white are lower case pieces */
      else
        piece = pxx[board[l]]; /* black are upper case pieces */
      if (piece != ' ')
       AnimateAmigaMove(mystr,piece);
#endif
	  return (true);
	}
    }
#if defined CHESSTOOL
  printz (CP[78]);
#else
#ifdef NONDSP
/* Illegal move */
#ifdef AMIGA
  //sprintf(mystr,CP[75],s);
  strcpy(mystr,"Illegal move (no match):");
  strcat(mystr,s);
  if (!verifyquiet)
   DisplayComputerMove(mystr);
#else
  printz (CP[75], s);
#endif
#ifdef DEBUG8
  if (1)
    {
      FILE *D;
      int r, c, l;
      extern unsigned INTSIZE int PrVar[];
      D = fopen ("/tmp/DEBUG", "a+");
      pnt = TrPnt[2];
      fprintf (D, "resp = %d\n", ResponseTime);
      fprintf (D, "iop = %d\n", iop);
      fprintf (D, "matches = %d\n", cnt);
      algbr (hint >> 8, hint & 0xff, (INTSIZE) 0);
      fprintf (D, "hint %s\n", mvstr[0]);
      fprintf (D, "inout move is %s\n", s);
      for (r = 1; PrVar[r]; r++)
	{
	  algbr (PrVar[r] >> 8, PrVar[r] & 0xff, (INTSIZE) 0);
	  fprintf (D, " %s", mvstr[0]);
	}
      fprintf (D, "\n");
      fprintf (D, "legal move are \n");
      while (pnt < TrPnt[3])
	{
	  node = &Tree[pnt++];
	  algbr (node->f, node->t, (INTSIZE) node->flags);
	  fprintf (D, "%s %s %s %s\n", mvstr[0], mvstr[1], mvstr[2], mvstr[3]);
	}
      fprintf (D, "\n current board is\n");
      for (r = 7; r >= 0; r--)
	{
	  for (c = 0; c <= 7; c++)
	    {
	      l = locn (r, c);
	      if (color[l] == neutral)
		fprintf (D, " -");
	      else if (color[l] == white)
		fprintf (D, " %c", qxx[board[l]]);
	      else
		fprintf (D, " %c", pxx[board[l]]);
	    }
	  fprintf (D, "\n");
	}
      fprintf (D, "\n");
      fclose (D);
      abort ();
    }
#endif
#else
/* Illegal move */
 if (!verifyquiet)
  ShowMessage (CP[76]);
#endif
#endif /* CHESSTOOL */
#if !defined CHESSTOOL && !defined XBOARD
  if (cnt > 1)
    ShowMessage (CP[32]);
#endif /* CHESSTOOL */
  return (false);
}

#endif // OLD_VERIFY



int
parser (char *f, int side)
{
  int c1, r1, c2, r2;

  if (f[4] == 'o')
    if (side == black)
      return 0x3C3A;
    else
      return 0x0402;
  else if (f[0] == 'o')
    if (side == black)
      return 0x3C3E;
    else
      return 0x0406;
  else
    {
      c1 = f[0] - 'a';
      r1 = f[1] - '1';
      c2 = f[2] - 'a';
      r2 = f[3] - '1';
      return (locn (r1, c1) << 8) | locn (r2, c2);
    }
  /*NOTREACHED*/
}

int myfgets(char *buff,int len,BPTR fd)
{
 char tmpch;
 int done=0;
 int numchars=0;
 int retval;

 retval = 1;
 do{
    if (Read(fd,&tmpch,1L) != 1L)
     {
      done = 1;
      retval = 0;
     }
    else
     {
      buff[numchars++] = tmpch;
      if (tmpch == '\n')
       {
        done = 1;
       }
      if (numchars >= (len-1))
       {
        done = 1;
        retval = 0;
       }
     }
  } while (!done);
 buff[numchars] = '\0';
 return(retval);
}

void
GetGame (void)
{
  int filefmt;
  int side = black; // was side = computer in 2.51
  char checkstr[8];
  BPTR fd;
  int eps;
  char fname[256], *p;
  int c, i, j;
  INTSIZE sq;

/* enter file name */
 if (!GetFileName(fname))
  {
   return;
  }
 (void)SetTaskPri((struct Task *)myproc,0);
 if (fname[0] == 0)
  ShowMessage (CP[63]);
#ifndef AMIGA
  scanz ("%s", fname);
#endif
/* chess.000 */
  if (fname[0] == '\0')
    strcpy (fname, CP[137]);
  if ((fd = Open (fname, MODE_OLDFILE)) != NULL)
    {
      NewGame();
      Delay(10L);
      ShowMessage("Loading Game..");
      Delay(20L);
      myfgets (fname, 256, fd);
      for(i=0;i<5;i++)
       checkstr[i] = fname[i];
      checkstr[5] = 0;
      if (stricmp(checkstr,"Black"))
       {
        DisplayBeep(0L);
        Delay(25L);
        DisplayBeep(0L);
        Close(fd);
        return;
       }
      computer = opponent = white;
      InPtr = fname;
      if (strlen(fname) < 34)
       {
        filefmt = 0;
        DisplayError("   Old Save File format");
       }
      else
       filefmt = 1;
      skip ();
      if (*InPtr == 'c')
	computer = black;
      else
	opponent = black;
      skip ();
      skip ();
      skip ();
      Game50 = atoi (InPtr);
      if (filefmt)
       {
        skip();
        skip();
        eps = atoi(InPtr);
       }
      else
       eps = -1;
      myfgets (fname, 256, fd);
      InPtr = &fname[14];
      castld[white] = ((*InPtr == CP[214][0]) ? true : false);
      skip ();
      skip ();
      castld[black] = ((*InPtr == CP[214][0]) ? true : false);
      myfgets (fname, 256, fd);
      InPtr = &fname[11];
      skipb ();
      TCflag = atoi (InPtr);
      skip ();
      InPtr += 14;
      skipb ();
      OperatorTime = atoi (InPtr);
      myfgets (fname, 256, fd);
      InPtr = &fname[11];
      skipb ();
      TimeControl.clock[white] = atoi (InPtr);
      skip ();
      skip ();
      TimeControl.moves[white] = atoi (InPtr);
      myfgets (fname, 256, fd);
      InPtr = &fname[11];
      skipb ();
      TimeControl.clock[black] = atoi (InPtr);
      skip ();
      skip ();
      TimeControl.moves[black] = atoi (InPtr);
      myfgets (fname, 256, fd);
      for (i = 7; i > -1; i--)
	{
	  myfgets (fname, 256, fd);
	  p = &fname[2];
	  InPtr = &fname[11];
	  skipb ();
	  for (j = 0; j < 8; j++)
	    {
	      sq = i * 8 + j;
	      if (*p == '.')
		{
		  board[sq] = no_piece;
		  color[sq] = neutral;
		}
	      else
		{
		  for (c = 0; c < 8; c++)
		    {
		      if (*p == pxx[c])
			{
			  board[sq] = c;
			  color[sq] = black;
			}
		    }
		  for (c = 0; c < 8; c++)
		    {
		      if (*p == qxx[c])
			{
			  board[sq] = c;
			  color[sq] = white;
			}
		    }
		}
	      p++;
	      Mvboard[sq] = atoi (InPtr);
	      skip ();
	    }
	}
      GameCnt = 0;
      flag.regularstart = false/*true*/;
      myfgets (fname, 256, fd);
      myfgets (fname, 256, fd);
      myfgets (fname, 256, fd);
      while (myfgets (fname, 256, fd))
	{
	  struct GameRec *g;

/*printf("in while loop\n");*/
	  side = side ^ 1;
	  ++GameCnt;
	  InPtr = fname;
	  skipb ();
	  g = &GameList[GameCnt];
	  g->gmove = parser (InPtr, side);
	  skip ();
	  g->score = atoi (InPtr);
	  skip ();
	  g->depth = atoi (InPtr);
	  skip ();
	  g->nodes = atoi (InPtr);
	  skip ();
	  g->time = atoi (InPtr);
	  skip ();
	  g->flags = c = atoi (InPtr);
	  skip ();
	  g->hashkey = strtol (InPtr, (char **) NULL, 16);
	  skip ();
	  g->hashbd = strtol (InPtr, (char **) NULL, 16);
          if (filefmt)
	   {
	    skip();
	    g->epssq = atoi(InPtr);
	   }
          else
           g->epssq = -1;
	  g->piece = no_piece;
	  g->color = neutral;
	  if (c & (capture | cstlmask))
	    {
	      if (c & capture)
		{
		  skip ();
		  for (c = 0; c < 8; c++)
		    if (pxx[c] == *InPtr)
		      break;
		  g->piece = c;
		}
	      skip ();
	      g->color = ((*InPtr == CP[119][0]) ? black : white);
	    }
	}
      /* GameCnt--; */
      //if (TimeControl.clock[white] > 0)
      //TCflag = true;
      Close (fd);
//      TrPnt[1] = 0;
//      root = &Tree[0];
//      MoveList (side, 1);
    }
  ISZERO = 1;
  ZeroRPT ();
  epsquare = eps;
  InitializeStats ();
  UpdateDisplay (0, 0, 1, 0);
  Sdepth = 0;
  hint = 0;
//  DisableMoveNow();
//  if (!TCflag)
//   {
    EnableMoveNow();
//   }
//  else
//   {
//    i = player;
//    player = black;
//    UpdateClocks();
//    player = white;
 //   UpdateClocks();
 //   player = i;
  //  if ((((TimeControl.clock[black])/TimeControl.moves[black]) > 5900) ||
  //      (((TimeControl.clock[white])/TimeControl.moves[white]) > 5900))
 //    {
 //     EnableMoveNow();
 //    }
 //  }
  flag.regularstart = false;
  Book = 0;
  if (MenuStripSet)
   {
    
    MenuItem8ab.Flags &= (0xffff ^ CHECKED);
    SetMenuStrip(wG,&MenuList1);	/* attach any Menu */
   }
  ZeroTTable(0);
  MoveMem128(board,amigaboard);
  MoveMem128(color,amigacolor);
#ifndef AMIGA
   memset ((signed char *) etab, 0, sizeof (etab));
#else
   ClearMem(etab,sizeof(etab));
#endif
  ShowMessage("Game Loaded");
#ifdef AMIGA
  DrawAmigaBoard();
#endif
  (void)SetTaskPri((struct Task *)myproc,procpri);
}

void
GetXGame (void)
{
  BPTR fd;
  char fname[256], *p;
  int c, i, j;
  INTSIZE sq;
/* Enter file name */
  ShowMessage (CP[63]);
#ifndef AMIGA
  scanz ("%s", fname);
#endif
  if (fname[0] == '\0')
/* xboard.position.read*/
    strcpy (fname, CP[205]);
  if ((fd = Open (fname, MODE_OLDFILE)) != NULL)
    {
      NewGame ();
      flag.regularstart = false;
      Book = false;
      myfgets (fname, 256, fd);
      fname[6] = '\0';
      if (strcmp (fname, CP[206]))
	return;
      myfgets (fname, 256, fd);
      myfgets (fname, 256, fd);
      for (i = 7; i > -1; i--)
	{
	  myfgets (fname, 256, fd);
	  p = fname;
	  for (j = 0; j < 8; j++)
	    {
	      sq = i * 8 + j;
	      if (*p == '.')
		{
		  board[sq] = no_piece;
		  color[sq] = neutral;
		}
	      else
		{
		  for (c = 0; c < 8; c++)
		    {
		      if (*p == qxx[c])
			{
			  board[sq] = c;
			  color[sq] = black;
			}
		    }
		  for (c = 0; c < 8; c++)
		    {
		      if (*p == pxx[c])
			{
			  board[sq] = c;
			  color[sq] = white;
			}
		    }
		}
	      p += 2;
	    }
	}
      Close (fd);
    }
  ISZERO = 1;
  ZeroRPT ();
  InitializeStats ();
  UpdateDisplay (0, 0, 1, 0);
  Sdepth = 0;
  hint = 0;
}

void
SaveGame (void)
{
  FILE *fd;
  char fname[256];
  INTSIZE sq, i, c, f, t;
  char p;

  if (!(GetFileName(savefile)))   
   { 
    return;
   }
  (void)SetTaskPri((struct Task *)myproc,0);
  if (savefile[0])
    strcpy (fname, savefile);
  else
    {
/* Enter file name*/
      ShowMessage (CP[63]);
#ifndef AMIGA
      scanz ("%s", fname);
#endif
    }

  if (fname[0] == '\0')
/* chess.000 */
    strcpy (fname, CP[137]);
  Delay(25L);
  if ((fd = fopen (fname, "w")) != NULL)
    {
      char *b, *w;

      Delay(25L);
      b = w = CP[74];
      if (computer == black)
	b = CP[141];
      if (computer == white)
	w = CP[141];
      fprintf (fd, CP[37], b, w, Game50,epsquare);
      fprintf (fd, CP[42], castld[white] ? CP[214] : CP[215], castld[black] ? CP[214] : CP[215]);
      fprintf (fd, CP[111], TCflag, OperatorTime);
      fprintf (fd, CP[117],
	       TimeControl.clock[white], TimeControl.moves[white],
	       TimeControl.clock[black], TimeControl.moves[black]);
      for (i = 7; i > -1; i--)
	{
	  fprintf (fd, "%1d ", i + 1);
	  for (c = 0; c < 8; c++)
	    {
	      sq = i * 8 + c;
	      switch (color[sq])
		{
		case black:
		  p = pxx[board[sq]];
		  break;
		case white:
		  p = qxx[board[sq]];
		  break;
		default:
		  p = '.';
		}
	      fprintf (fd, "%c", p);
	    }
	  for (f = i * 8; f < i * 8 + 8; f++)
	    fprintf (fd, " %d", Mvboard[f]);
	  fprintf (fd, "\n");
	}
      fprintf (fd, "  %s\n", cxx);
      fprintf (fd, CP[126]);
      for (i = 1; i <= GameCnt; i++)
	{
	  struct GameRec *g = &GameList[i];

	  f = g->gmove >> 8;
	  t = (g->gmove & 0xFF);
	  algbr (f, t, g->flags);
	  fprintf (fd, "%s %5d %5d %7ld %5d %5d  %#08lx %#08lx %d %c   %s\n",
		   mvstr[0], g->score, g->depth,
		   g->nodes, g->time, g->flags, g->hashkey, g->hashbd,g->epssq,
	   pxx[g->piece], ((g->color == 2) ? "     " : ColorStr[g->color]));
	}
      fclose (fd);
/* Game saved */
      ShowMessage (CP[70]);
    }
  else
    /*ShowMessage ("Could not open file");*/
    ShowMessage (CP[48]);
  (void)SetTaskPri((struct Task *)myproc,procpri);
}

void
ListGame (getstr)
int getstr;
{
  FILE *fd;
  INTSIZE i, f, t;
  long when;
  char fname[256], dbuf[256];

  if (listfile[0])
    strcpy (fname, listfile);
  else
    {
#ifdef MSDOS
      sprintf (fname, "chess.lst");
#else
      if (!getstr)
       {
        time (&when);
        strncpy (dbuf, ctime (&when), 20);
        dbuf[7] = '\0';
        dbuf[10] = '\0';
        dbuf[13] = '\0';
        dbuf[16] = '\0';
        dbuf[19] = '\0';
/* use format "CLp16.Jan01-020304B" when patchlevel is 16,
   date is Jan 1
   time is 02:03:04
   program played black */
        sprintf (fname, "t:UC%s.%s%s-%s%s%s%c", patchlevel, dbuf + 4, dbuf + 8, dbuf + 11, dbuf + 14, dbuf + 17, ColorStr[computer][0]);
        /* replace space padding with 0 */
        for (i = 0; fname[i] != '\0'; i++)
  	  if (fname[i] == ' ')
	    fname[i] = '0';
       }
      else
       {
        if (!GetFileName(fname))
         {
          return;
         }
       }
#endif /* MSDOS */
    }
  Delay(5L);
  (void)SetTaskPri((struct Task *)myproc,0);
  fd = fopen (fname, "w");
  Delay(5L);
  if (!fd)
    {
     (void)SetTaskPri((struct Task *)myproc,procpri);
     return;
    }
  /*fprintf (fd, "gnuchess game %d\n", u);*/
  fprintf (fd, "%s\n", VERSTRING);
  fprintf (fd, CP[10]);
  fprintf (fd, CP[11]);
  for (i = 1; i <= GameCnt; i++)
    {
      f = GameList[i].gmove >> 8;
      t = (GameList[i].gmove & 0xFF);
      algbr (f, t, GameList[i].flags);
      if(GameList[i].flags & book)
          fprintf (fd, "%5s  %5d    Book%7ld %5d", mvstr[0],
	       GameList[i].score, 
	       GameList[i].nodes, GameList[i].time);
      else
          fprintf (fd, "%5s  %5d     %2d %7ld %5d", mvstr[0],
	       GameList[i].score, GameList[i].depth,
	       GameList[i].nodes, GameList[i].time);
      if ((i % 2) == 0)
	{
	  fprintf (fd, "\n");
#ifdef DEBUG40
	  if (computer == black)
	    fprintf (fd, " %d %d %d %d %d %d %d\n",
		     GameList[i].d1,
		     GameList[i].d2,
		     GameList[i].d3,
		     GameList[i].d4,
		     GameList[i].d5,
		     GameList[i].d6,
		     GameList[i].d7);
	  else
	    fprintf (fd, " %d %d %d %d %d %d %d\n",
		     GameList[i - 1].d1,
		     GameList[i - 1].d2,
		     GameList[i - 1].d3,
		     GameList[i - 1].d4,
		     GameList[i - 1].d5,
		     GameList[i - 1].d6,
		     GameList[i - 1].d7);
#endif
	}
      else
	fprintf (fd, "         ");
    }
  fprintf (fd, "\n\n");
  if (GameList[GameCnt].flags & draw)
    {
      fprintf (fd, CP[54], DRAW);
    }
  else if (GameList[GameCnt].score == -9999)
    {
      fprintf (fd, "%s\n", ColorStr[player ]);
    }
  else if (GameList[GameCnt].score == 9998)
    {
      fprintf (fd, "%s\n", ColorStr[player ^ 1]);
    }
  fclose (fd);
  (void)SetTaskPri((struct Task *)myproc,procpri);
}

void
Undo (void)

/*
 * Undo the most recent half-move.
 */

{
  INTSIZE f, t;
  f = GameList[GameCnt].gmove >> 8;
  t = GameList[GameCnt].gmove & 0xFF;
  if (board[t] == king && distance (t, f) > 1)
    (void) castle (GameList[GameCnt].color, f, t, 2);
  else
    {
      /* Check for promotion: */
      if (GameList[GameCnt].flags & promote)
	{
	  board[t] = pawn;
	}
      board[f] = board[t];
      color[f] = color[t];
      board[t] = GameList[GameCnt].piece;
      color[t] = GameList[GameCnt].color;
      if (color[t] != neutral)
	Mvboard[t]--;
      Mvboard[f]--;
    }
  if (GameList[GameCnt].flags & epmask)
    EnPassant (otherside[color[f]], f, t, 2);
  else
    InitializeStats ();
  epsquare = GameList[GameCnt].epssq;
  if (TCflag && (TCmoves>1))
    ++TimeControl.moves[color[f]];
  hashkey = GameList[GameCnt].hashkey;
  hashbd = GameList[GameCnt].hashbd;
  GameCnt--;
  computer = computer ^ 1;
  opponent = opponent ^ 1;
  Mate = flag.mate = false;
  Sdepth = 0;
  player = player ^ 1;
  ShowSidetoMove ();
  UpdateDisplay (0, 0, 1, 0);

  InitializeStats();

#if defined NULLMOVE || defined DEEPNULL
  no_null=0;
  null = 0;         /* Null-move already made or not */
  PVari = 0;        /* Is this the PV */
#endif
  dither = 0;
  PawnStorm = start_stage = 0;
  thrashing_tt = 0; /* must we recycle slots at random. TomV */
  ClearMem(QueenCheck,MAXDEPTH*sizeof(short));
  ClearMem(PrVar,MAXDEPTH*sizeof(short));
  ClearMem(Threat,MAXDEPTH*sizeof(short));
  ClearMem(ThreatSave,MAXDEPTH*sizeof(short));
  ClearMem(Pscore,MAXDEPTH*sizeof(short));
  ClearMem(Tscore,MAXDEPTH*sizeof(short));
  ClearMem(ChkFlag,MAXDEPTH*sizeof(short));
  ClearMem(CptrFlag,MAXDEPTH*sizeof(short));
  ClearMem(PawnThreat,MAXDEPTH*sizeof(short));


  //ZeroRPT();
  ZeroTTable(0);
#ifndef AMIGA
   memset ((signed char *) etab, 0, sizeof (etab));
#else
   ClearMem(etab,sizeof(etab));
#endif
#ifdef HISTORY
 ClearMem(history,sizeof(history));
#endif
 MoveMem128(board,amigaboard);
 MoveMem128(color,amigacolor);
/*  if (flag.regularstart)
    Book = BOOKFAIL;*/
}

void
 TestSpeed (void (*f) ( INTSIZE int side, INTSIZE int ply), unsigned j)
{
  char astr[256];
  INTSIZE i;
  long cnt, rate, t1, t2;

  t1 = time (0);
  Forbid();
  for (i = 0; i < j; i++)
    {
      f (opponent, 2);
    }
  Permit();
  t2 = time (0);
  cnt = j * (TrPnt[3] - TrPnt[2]);
  if (t2 - t1)
    et = (t2 - t1) * 100;
  else
    et = 1;
  rate = (et) ? (cnt / et) : 0;
  /*printz ("Nodes= %ld Nodes/sec= %ld\n", cnt, rate);*/
#ifdef NONDSP
#ifdef AMIGA
if (!func_num)
 sprintf(astr,"Mlst=%dN/s",rate*100);
else if (func_num == 1)
 sprintf(astr,"Clst=%dN/s",rate*100);
ShowMessage(astr);
#else
  printz (CP[91], cnt, rate*100);
#endif
#ifdef DEBUG9
  for (j = TrPnt[2]; j < TrPnt[3]; j++)
    {
      struct leaf *node = &Tree[j];
      algbr (node->f, node->t, node->flags);
      printf ("%s %s %s %s %d %x\n", mvstr[0], mvstr[1], mvstr[2], mvstr[3],node->score,node->flags);
    }
#endif
#else
  ShowNodeCnt (cnt);
#endif
}

void
 TestPSpeed (INTSIZE int (*f) (INTSIZE int side), unsigned j)
{
  char astr[256];
  INTSIZE i;
  long cnt, rate, t1, t2;

  t1 = time (0);
  Forbid();
  for (i = 0; i < j; i++)
    {
      (void) f (opponent);
    }
  Permit();
  t2 = time (0);
  cnt = j;
  if (t2 - t1)
    et = (t2 - t1) * 100;
  else
    et = 1;
  rate = (et) ? (cnt / et) : 0;
  /*printz ("Nodes= %ld Nodes/sec= %ld\n", cnt, rate);*/
#ifdef NONDSP
#ifdef AMIGA
sprintf(astr,"Eval=%ldN/s",rate*100);
ShowMessage(astr);
#else
  printz (CP[91], cnt, rate*100);
#endif
#else
  ShowNodeCnt (cnt);
#endif
}


void
SetMachineTime (char *s)
{
  char *time;
  int m, t;
  time = &s[strlen (CP[197])];
  m = strtol (time, &time, 10);
  t = strtol (time, &time, 10);
  if (t)
    TimeControl.clock[computer] = t;
  if (m)
    TimeControl.moves[computer] = m;
#ifdef XBOARD
  printz (CP[222], m, t);
#endif
}


void
InputCommand (cstring)

char *cstring;

/*
 * Process the users command. If easy mode is OFF (the computer is thinking
 * on opponents time) and the program is out of book, then make the 'hint'
 * move on the board and call SelectMove() to find a response. The user
 * terminates the search by entering ^C (quit siqnal) before entering a
 * command. If the opponent does not make the hint move, then set Sdepth to
 * zero.
 */

{
  int tmpPawnStorm;
  int need_to_zero;
  char tstr[40];
  int i = 0;
  INTSIZE have_shown_prompt = false;
  INTSIZE ok, tmp;
  unsigned INTSIZE mv;
  char s[80];
  char *sx;

  sx = OpEntryStr;
  tmpPawnStorm = PawnStorm;
#if defined CHESSTOOL
  INTSIZE normal = false;

#endif

  ok = flag.quit = false;
  MoveMem128(board,amigaboard);
  MoveMem128(color,amigacolor);
  player = opponent;
  ft = 0;
  thinkahead = 0;
#ifdef CACHE
//  if(TTadd > ttblsize) // want to zero out ttable each time
   ZeroTTable(1);
#endif
  if (hint > 0 && !flag.easy && !flag.force)
    if ((board[hint >> 8] != pawn) || ((row (hint & 0x3f) != 0) && (row (hint & 0x3f) != 7)))
      {
        s[0] = sx[0] = '\0';
        thinkahead = 1;
        ft = time0;
	algbr ((INTSIZE) hint >> 8, (INTSIZE) hint & 0x3F, false);
	strcpy (s, mvstr[0]);
	tmp = epsquare;
        verifyquiet = 1;
	if (VerifyMove (s, 1, &mv))
	  {
	    Sdepth = 0;
#ifdef QUIETBACKGROUND
#ifdef NONDSP
	    PromptForMove ();
#else
	    ShowSidetoMove ();
	    ShowPrompt ();
#endif
	    have_shown_prompt = true;
#endif /* QUIETBACKGROUND */
            backsrchaborted = 0;
            if (!GetEntryDone)
             {
              Global_Message.myData = 1L;
              Forbid();
              PutMsg(InThreadPort,(struct Message *)&Global_Message);
              Permit();
              GetEntryDone = 1;
             }
	    SelectMove (computer, 2);
#ifdef OLD_LOOKAHEAD
	    VerifyMove (s, 2, &mv);
	    Sdepth = 0;
#else // faster lookahead on predict
	    VerifyMove (s, 2, &mv);
	    if ((Sdepth > 0)&&(backsrchaborted))
              Sdepth--;
#endif
	  }
         verifyquiet = 0;
	/*ft = (time ((long *) 0) - time0) * 100;*/
	epsquare = tmp;
	time0 = ft;
      }
  while (!(ok || flag.quit))
    {
      need_to_zero = 0;
#if defined CHESSTOOL
      normal = false;
#endif
      player = opponent;
#ifdef QUIETBACKGROUND
      if (!have_shown_prompt)
	{
#endif /* QUIETBACKGROUND */
#ifdef NONDSP
	  PromptForMove ();
#else
	  ShowSidetoMove ();
	  ShowPrompt ();
#endif
#ifdef QUIETBACKGROUND
	}
      have_shown_prompt = false;
#endif /* QUIETBACKGROUND */
#ifdef NONDSP
      if (!GetEntryDone)
       s[0] = sx[0] = '\0';
#ifndef AMIGA
      while (!sx[0])
	i = (int) gets (sx);
#else
       thinking2 = 0;
       i = 1;
       thinkahead = 0;
       if (!GetEntryDone)
        {
         Global_Message.myData = 1L;
         Forbid();
         PutMsg(InThreadPort,(struct Message *)&Global_Message);
         Permit();
        }
       GetEntryDone = 0;
       if (Wait(MYREPLY) & MYREPLY)
        { // string is waiting for me!
           //GetOperatorEntry(); // TMP DEBUG STATEMENT
        }
       else // funny wake up, should not happen!
        {
         strcpy(sx,"quit");
        }
#endif
#else
     /* fflush (stdout);
      i = (int) getstr (sx);*/
#endif
      sscanf (sx, "%s", s);
      if (i == EOF)
	ExitChess ();
      if (s[0] == '\0')
	continue;
      if (strcmp (s, CP[131]) == 0)	/*bd*/
	{
#if defined CHESSTOOL || defined XBOARD
	  chesstool = 0;
#endif /* CHESSTOOL */
	  ClrScreen ();
	  UpdateDisplay (0, 0, 1, 0);
#if defined CHESSTOOL || defined XBOARD
	  chesstool = 1;
#endif /* CHESSTOOL */
	}
      else if (strcmp (s, CP[129]) == 0) /* noop */ ;	/*alg*/
      else if ((strcmp (s, CP[180]) == 0) || (strcmp (s, CP[216]) == 0))	/* quit exit*/
	flag.quit = true;
      else if (strcmp (s, CP[178]) == 0)	/*post*/
	{
	 /* flag.post = !flag.post;*/
	}
      else if ((strcmp (s, CP[191]) == 0) || (strcmp (s, CP[154]) == 0))	/*set edit*/
	EditBoard ();
#ifdef NONDSP
      else if (strcmp (s, CP[190]) == 0)	/*setup*/
	SetupBoard ();
#endif
      else if (strcmp (s, CP[156]) == 0)	/*first*/
	{
#if defined CHESSTOOL
	  computer = white;
	  opponent = black;
	  flag.force = false;
	  Sdepth = 0;
#endif /* CHESSTOOL */
	  ok = true;
	}
      else if (strcmp (s, CP[162]) == 0)	/*go*/
	{
	  ok = true;
	  flag.force = false;
	  if (computer == white)
	    {
	      computer = black;
	      opponent = white;
	    }
	  else
	    {
	      computer = white;
	      opponent = black;
	    }
	}
      else if (strcmp (s, CP[166]) == 0)	/*help*/
	help ();
      else if (strcmp (s, CP[221]) == 0)	/*material*/
	flag.material = !flag.material;
      else if (strcmp (s, CP[157]) == 0)	/*force*/
	{flag.force = !flag.force; flag.bothsides = false;}
      else if (strcmp (s, CP[134]) == 0)	/*book*/
	Book = Book ? 0 : BOOKFAIL;
      else if (strcmp (s, CP[172]) == 0)	/*new*/
	{
	  NewGame ();
	  UpdateDisplay (0, 0, 1, 0);
	}
      //else if (strcmp (s, CP[171]) == 0)	/*list*/
	//ListGame (0xff);
      else if (strcmp (s, CP[169]) == 0 || strcmp (s, CP[217]) == 0)	/*level clock*/
       {
        GetTimeString(tstr);
	SelectLevel (tstr);
       }
      else if (strcmp (s, CP[165]) == 0)	/*hash*/
	flag.hash = !flag.hash;
      else if (strcmp (s, CP[132]) == 0)	/*beep*/
	flag.beep = !flag.beep;
      else if (strcmp (s, CP[197]) == 0)	/*time*/
	{
	  SetMachineTime (sx);
	}
      else if (strcmp (s, CP[33]) == 0)	/*Awindow*/
	ChangeAlphaWindow ();
      else if (strcmp (s, CP[39]) == 0)	/*Bwindow*/
	ChangeBetaWindow ();
      else if (strcmp (s, CP[183]) == 0)	/*rcptr*/
	flag.rcptr = !flag.rcptr;
      else if (stricmp(s,"calc") == 0)
       {
        calc_pgm_rating();
        OpEntryStr[0] = 0;
        s[0] = 0;
       }
      else if (stricmp(s,"advan") == 0)
       {
        DoAdvanced();
        OpEntryStr[0] = 0;
        s[0] = 0;
       }
      else if (stricmp(s,"interm") == 0)
       {
        DoIntermediate();
        OpEntryStr[0] = 0;
        s[0] = 0;
       }
      else if (stricmp(s,"easy") == 0)
       {
        DoEasy();
        OpEntryStr[0] = 0;
        s[0] = 0;
       }
      else if (strcmp (s, CP[168]) == 0)	/*hint*/
       {
	GiveHint ();
       }
      else if (strcmp (s, CP[135]) == 0)	/*both*/
	{
	  flag.bothsides = !flag.bothsides;
          if (flag.bothsides)
           {
            (void)SetTaskPri((struct Task *)myproc,0);
            thinkahead = 1;
           }
          flag.force = false;
	  Sdepth = 0;
	  ElapsedTime (1);
	  SelectMove (opponent, 1);
	  ok = true;
	}
      else if (strcmp (s, CP[185]) == 0)	/*reverse*/
	{
#ifndef AMIGA
	  flag.reverse = !flag.reverse;
	  ClrScreen ();
	  UpdateDisplay (0, 0, 1, 0);
#endif
	}
      else if (strcmp (s, CP[195]) == 0)	/*switch*/
	{
	  computer = computer ^ 1;
	  opponent = opponent ^ 1;
	  xwndw = (computer == white) ? WXWNDW : BXWNDW;
	  flag.force = false;
	  Sdepth = 0;
	  if ((!GameCnt) && (Book) && (flag.regularstart))
	   GetOpenings(computer);
          else
           Book = 0;
	  ok = true;
	}
      else if (strcmp (s, CP[203]) == 0)	/*white*/
	{
	  computer = black;
	  opponent = white;
	  xwndw = WXWNDW;
	  flag.force = false;
	  Sdepth = 0;

	  /*
           * ok = true; don't automatically start with white command
           */
	}
      else if (strcmp (s, CP[133]) == 0)	/*black*/
	{
	  computer = white;
	  opponent = black;
	  xwndw = BXWNDW;
	  flag.force = false;
	  Sdepth = 0;

	  /*
           * ok = true; don't automatically start with black command
           */
	}
      else if (strcmp (s, CP[201]) == 0 && GameCnt > 0)	/*undo*/
	{
#ifndef AMIGA
	  Undo ();
#endif
	}
      else if (strcmp (s, CP[184]) == 0 && GameCnt > 1)	/*remove*/
	{
#ifndef AMIGA
	  Undo ();
	  Undo ();
#endif
	}
      //else if (strcmp (s, CP[160]) == 0)	/*get*/
	//GetGame ();
      //else if (strcmp (s, CP[207]) == 0)	/*xget*/
	//GetXGame ();
      //else if (strcmp (s, CP[189]) == 0)	/*save*/
	//SaveGame ();
      else if (strcmp (s, CP[151]) == 0)	/*depth*/
	ChangeSearchDepth ();
#ifdef DEBUG
      else if (strcmp (s, CP[147]) == 0)	/*debuglevel*/
	ChangeDbLev ();
#endif /* DEBUG */
      else if (strcmp (s, CP[164]) == 0)	/*hashdepth*/
	ChangeHashDepth ();
      else if (strcmp (s, CP[182]) == 0)	/*random*/
	dither = DITHER;
      else if (strcmp (s, CP[152]) == 0)	/*easy*/
       {
	/*flag.easy = !flag.easy;*/
	flag.easy = flag.easy; /* mod this for menu toggle on amiga */
       }
      else if (strcmp (s, CP[143]) == 0)	/*contempt*/
	SetContempt ();
      else if (strcmp (s, CP[209]) == 0)	/*xwndw*/
	ChangeXwindow ();
      else if (strcmp (s, CP[186]) == 0)	/*rv*/
	{
	  flag.rv = !flag.rv;
	  UpdateDisplay (0, 0, 1, 0);
	}
      else if (strcmp (s, CP[145]) == 0)	/*coords*/
	{
	  flag.coords = !flag.coords;
	  UpdateDisplay (0, 0, 1, 0);
	}
      else if (strcmp (s, CP[193]) == 0)	/*stras*/
	{
	  flag.stars = !flag.stars;
	  UpdateDisplay (0, 0, 1, 0);
	}
      else if (strcmp (s, CP[196]) == 0)	/*test*/
	{
/*	  ShowMessage (CP[108]);/*test movelist*/
          ShowMessage ("Testing..");
          func_num = 0;
	  TestSpeed (MoveList, 20000);
/*	  ShowMessage (CP[107]);/*test capturelist*/
          func_num++;
	  TestSpeed (CaptureList, 30000);
/*	  ShowMessage (CP[85]);/*test score position*/
          func_num++;
	  TestPSpeed (ScorePosition, 15000);
	}
      //else if (strcmp (s, CP[179]) == 0)	/*p*/
	//ShowPostnValues ();
#ifdef DEBUGG
      else if (strcmp (s, CP[148]) == 0)	/*debug*/
	DoDebug ();
	else if (strcmp (s, "Mwpawn") == 0)        /*debug*/
        DoTable (Mwpawn);
	else if (strcmp (s, "Mbpawn") == 0)        /*debug*/
        DoTable (Mbpawn);
	else if (strcmp (s, "Mwknight") == 0)        /*debug*/
        DoTable (Mknight[white]);
	else if (strcmp (s, "Mbknight") == 0)        /*debug*/
        DoTable (Mknight[black]);
	else if (strcmp (s, "Mwbishop") == 0)        /*debug*/
        DoTable (Mbishop[white]);
	else if (strcmp (s, "Mbbishop") == 0)        /*debug*/
        DoTable (Mbishop[black]);
#endif
      else
	{ /* this is where we move the humans pieces */
#if defined CHESSTOOL
	  normal = (ok = VerifyMove (s, 0, &mv));
#else
	  ok = VerifyMove (s, 0, &mv);
#endif
#ifdef OLDVERSION1_01
	  if ((ok && mv != hint))
	    {
	      Sdepth = 0;
	      ft = 0;
	    }
	  else
	    Sdepth = 0;
#else
#ifndef OLD_LOOKAHEAD
          if ((ok)&&((mv != hint)||(flag.easy)||(Sdepth2<3)||(GameCnt <= 2)))
           {
#ifndef CLEARHISTBETWEENMOVES
            if (!flag.easy) // if  thinkahead was wrong clear hist
             ClearMem(history,sizeof (history));
#endif
            Sdepth = 0;
            need_to_zero = 1;
           }
         else // TMP DEBUG UNTIL I CAN GET SOMETHING BETTER
          {
            Sdepth = 0;
            need_to_zero = 1;
          }
#endif
          if (ok)
           {
	    if ((!flag.easy)&&(mv == hint)&&(Sdepth2>2)&&(GameCnt > 2))
             {
              ThinkAheadDepth = Sdepth2;
              //if (ThinkInARow > 4) /* if it got to 4, we would have skipped one */
               ThinkInARow = 0;
              ThinkAheadWorked = 1;
             }
            else
             {
#ifndef CLEARHISTBETWEENMOVES
              if (!flag.easy) // if thinkahead is wrong clear hist
               ClearMem(history,sizeof (history));
#endif
              ThinkInARow = 0;
              ThinkAheadDepth = 0;
              ThinkAheadWorked = 0;
             }
           } // ok
#endif
          if ((!ok))
           {
            IllegalMove = 1;
           }
          if ((ok)&&(MouseDropped))
           {
                DoLegalMove(s);
                MouseDropped = 0;
           }
          //ClearMem(etab,sizeof(etab)); // I find it buggy to keep around!
          if (need_to_zero)
           {
            if (!flag.easy)
             PawnStorm = tmpPawnStorm;
            need_to_zero = 0;
//            if (!flag.easy)
//#ifndef AGING
//             ZeroTTable(0);
//#else
//             ZeroTTable(0);
//#endif
           }
          if (!ok)
           MouseDropped = 0;
	}
    }

  ElapsedTime (1);
  if (flag.force)
    {
      computer = opponent;
      opponent = computer ^ 1;
    }
}


void
ElapsedTime (INTSIZE int iop)


/*
 * Determine the time that has passed since the search was started. If the
 * elapsed time exceeds the target (ResponseTime+ExtraTime) then set timeout
 * to true which will terminate the search. iop = 0 calculate et bump ETnodes
 * iop = 1 calculate et set timeout if time exceeded, calculate et
 */

{
#ifndef MSDOS
  extern int errno;
#ifdef AMIGA
   //struct IntuiMessage *localmessage;
   //long __aligned class,code;
#endif
#ifndef AMIGA
#ifdef FIONREAD
  if (i = ioctl ((int) 0, FIONREAD, &nchar))
    {
      perror ("FIONREAD");
      fprintf (stderr,
        "You probably have a non-ANSI <ioctl.h>; see README. %d %d %x\n",
	i, errno, FIONREAD);
      exit (1);
    }

  if (nchar)
    {
      if (!flag.timeout)
	flag.back = true;
      flag.bothsides = false;
    }
#endif /*FIONREAD*/
#endif
#ifdef AMIGA /* check if I need to interrupt thinking */
#ifndef OLDWAY
  if (OpEntryRecvd)
   {
    OpEntryRecvd = 0;
    if ((thinkahead)&&(!flag.bothsides))
     {
          (void)SetTaskPri((struct Task *)myproc,procpri);
          if (!TCflag)
           backsrchaborted = 1;
          if (!flag.timeout)
           {
            flag.back = true;
           }
          flag.bothsides = false;
     }
    else if (thinking2)
     {
      if (OpEntryRecvd == 2)
       { // move now!
             if (!flag.timeout)
              {
               flag.back = true;
   	       flag.musttimeout = true;
              }
             flag.bothsides = false;
       }
     }
   }
#else
  if (thinkahead)
  {
  while ( (localmessage = (struct IntuiMessage *)
	GetMsg(wG->UserPort) )) /* got a message at window port */
   {
        if (localmessage->Class == RAWKEY)
         {
          if (localmessage->Code < 56)
           code = cookedchar[localmessage->Code];
          else
           code = 0;
         }
        else
         {
          code = 'A';
         }
        if (isalpha(code))
         {
          (void)SetTaskPri((struct Task *)myproc,procpri);
          if (!TCflag)
           backsrchaborted = 1;
          if (!flag.timeout)
           {
            flag.back = true;
           }
          flag.bothsides = false;
	  globalmessage_valid = 0xffff;
          globalmessage = *localmessage;
         }
	ReplyMsg((struct Message *)localmessage);
   }
  }
  else if (thinking2) /* check for move now menu item */
  {
  while ( (localmessage = (struct IntuiMessage *)
	GetMsg(wG->UserPort) )) /* got a message at window port */
   {
	class = localmessage->Class;
        code = localmessage->Code;
	ReplyMsg((struct Message *)localmessage);
        if ((class == MENUPICK))
          {
 	   if (ItemAddress(&Menu1,code) == &MenuItem6)
            {
             if (!flag.timeout)
              {
               flag.back = true;
   	       flag.musttimeout = true;
              }
             flag.bothsides = false;
            }
          }
   }
  }
#endif // oldway
#endif
#else
  if (kbhit ())
    {
      if (!flag.timeout)
	flag.back = true;
      flag.bothsides = false;
    }
#endif /* MSDOS */
  et = (time ((long *) 0) - time0) * 100;
  ETnodes = NodeCnt + ZNODES;
  if (et < 0)
    et = 0;
  if (iop == 1)
    {
      if (et > ResponseTime + ExtraTime && Sdepth > MINDEPTH)
	flag.timeout = true;
      ETnodes = NodeCnt + ZNODES;
      time0 = time ((long *) 0);
    }
#ifdef AMIGA
    UpdateClocks ();
#endif
}


void
SetTimeControl (void)
{
 int tmp;
  if (TCflag)
    {
      TimeControl.moves[white] = TimeControl.moves[black] = TCmoves;
      TimeControl.clock[white] = 6000L * TCminutes + TCseconds * 100;
      TimeControl.clock[black] = 6000L * TCminutes + TCseconds * 100;
      SecsPerMove = tmp = (TCminutes*60+TCseconds)/TCmoves;
      if (tmp < 10)
       {
        GlobalTgtDepth = 2;
       }
      else if (tmp < 180)
       {
        GlobalTgtDepth = 3;
       }
      else
       GlobalTgtDepth = 4;
    }
  else
    {
      TimeControl.moves[white] = TimeControl.moves[black] = 0;
      TimeControl.clock[white] = TimeControl.clock[black] = 0;
    }
  flag.onemove = (TCmoves == 1);
  et = 0;
  ElapsedTime (1);
}

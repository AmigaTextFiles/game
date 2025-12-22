/*
 * nondsp.c - UNIX & MSDOS NON-DISPLAY, AND CHESSTOOL interface for Chess
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

#include <ctype.h>
#include <signal.h>
#include <string.h>

#ifdef AMIGA
void mysprintf(char *,char *,int);
void mysprintf4(char *,char *,int);
void mysprintf3(char *,char *,int,int);
void algbr2 (short, short, short);
#define __USE_SYSBASE
#include <exec/types.h>
#include <exec/exec.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#endif

char HintString[80];


#ifndef __MORPHOS__
#define SIGQUIT SIGINT
#endif

#include "gnuchess.h"
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

extern int thinkahead;

extern INTSIZE amigaboard[64],amigacolor[64];
extern short int ISZERO;
char IllegalString[40];
extern int AmigaStarted;
extern int global_tmp_score;
extern int previous_score;
int IllegalMove=0;
int Mate=0;
int DrawnGame=0;
char MateString[40]={0};
extern long OrigResponse;

#ifdef DEBUG
INTSIZE int debuglevel = 0;

#endif /* DEBUG */
unsigned INTSIZE int MV[MAXDEPTH];
int MSCORE;

#if defined CHESSTOOL || defined XBOARD
INTSIZE int chesstool = 1;

#else
INTSIZE int chesstool = 0;

#endif /* CHESSTOOL */
extern char mvstrhint[8][8];
extern char mvstr[8][8];
int mycnt1, mycnt2;
char *DRAW;
extern char *InPtr;
extern INTSIZE int pscore[];

void mysprintf4(ostr,fstr,num)
char *ostr,*fstr;
int num;
{ // formats string "Tgt:%d xxx"

 int index;
 int thou,hun,ten,one,rem;
 

 ostr[0] = fstr[0];
 ostr[1] = fstr[1];
 ostr[2] = fstr[2];
 ostr[3] = fstr[3];
 ostr[4] = 0;
 if (num < 0) 
  {
   num = -num;
   index = 5;
   strcat(ostr,"-");
  }
 else
  {
   index = 4;
  }
 thou = num / 1000;
 rem = num-(num / 1000)*1000;
 hun = (rem / 100);
 rem = rem-(hun * 100);
 ten = rem / 10;
 rem = rem-(ten * 10);
 one = rem;
 if (thou)
  {
   ostr[index++] = thou+'0';
  }
 if ((hun)||(thou))
  {
   ostr[index++] = hun+'0';
  }
 if ((ten)||(hun)||(thou))
  {
   ostr[index++] = ten+'0';
  }
 ostr[index++] = one+'0';
 ostr[index] = 0;
 strcat(ostr,&fstr[6]);
}

void mysprintf3(ostr,fstr,num,num2)
char *ostr,*fstr;
int num,num2;
{ // formats string "D%d S%d "

 int index;
 int thou,hun,ten,one,rem;
 

 ostr[0] = fstr[0]; // get the D
 ostr[1] = 0;
 if (num < 0) 
  {
   num = -num;
   index = 2;
   strcat(ostr,"-");
  }
 else
  {
   index = 1;
  }
 thou = num / 1000;
 rem = num-(num / 1000)*1000;
 hun = (rem / 100);
 rem = rem-(hun * 100);
 ten = rem / 10;
 rem = rem-(ten * 10);
 one = rem;
 if (thou)
  {
   ostr[index++] = thou+'0';
  }
 if ((hun)||(thou))
  {
   ostr[index++] = hun+'0';
  }
 if ((ten)||(hun)||(thou))
  {
   ostr[index++] = ten+'0';
  }
 ostr[index++] = one+'0';
 ostr[index++] = fstr[3];
 ostr[index++] = fstr[4];

 if (num2 < 0)
  {
   num2 = -num2;
   ostr[index++] = '-';
  }
 thou = num2 / 1000;
 rem = num2-(num2 / 1000)*1000;
 hun = (rem / 100);
 rem = rem-(hun * 100);
 ten = rem / 10;
 rem = rem-(ten * 10);
 one = rem;
 if (thou)
  {
   ostr[index++] = thou+'0';
  }
 if ((hun)||(thou))
  {
   ostr[index++] = hun+'0';
  }
 if ((ten)||(hun)||(thou))
  {
   ostr[index++] = ten+'0';
  }
 ostr[index++] = one+'0';
 ostr[index] = 0;
 strcat(ostr,&fstr[7]);
}


void
Initialize (void)
{
  mycnt1 = mycnt2 = 0;
#if defined CHESSTOOL || defined XBOARD
#ifndef SYSV
/*  setlinebuf (stdout);*/
#else
/*  setvbuf (stdout, NULL, _IOLBF, BUFSIZ);*/
#endif
/*  printf (CP[43]);*/		/*Chess*/
  if (!TCflag && (MaxResponseTime == 0))
    MaxResponseTime = 15L*100L;
#endif /* CHESSTOOL */
}


void DoAMove(void);

void DoAMove()
{
 char astr[40];
 int r,c,l;
 char piece;

      r = mvstr[0][3] - '1';
      c = mvstr[0][2] - 'a';
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
  if (computer == black)
   {
    mysprintf(astr,"%d: ",GameCnt>>1);
    strcat(astr,mvstr[0]);
   }
  else
   {
    mysprintf(astr,"%d: ",(GameCnt+1)>>1);   
    strcat(astr,mvstr[0]);
   }
  DisplayComputerMove(astr);
  if (piece != ' ')
   AnimateAmigaMove(mvstr[0],piece);
}
void
ExitChess (void)
{
/*  signal (SIGTERM, SIG_IGN);*/
  ListGame (0L);
#ifdef AMIGA
  if (AmigaStarted)
   AmigaShutDown();
#endif
  exit (0);
}

#ifndef MSDOS			/* never called!!! */
#ifndef AMIGA
void
Die (int sig)
{
  char s[80];

  ShowMessage (CP[31]);		/*Abort?*/
  scanz ("%s", s);
  if (strcmp (s, CP[210]) == 0)	/*yes*/
    ExitChess ();
}
#endif
#endif /* MSDOS */

void
TerminateSearch (int sig)
{
#ifdef MSDOS
  sig++;			/* shut up the compiler */
#endif /* MSDOS */
  if (!flag.timeout)
    flag.musttimeout = true;
  flag.bothsides = false;
}


void
help (void)
{
#ifndef AMIGA
  ClrScreen ();
  /*printz ("CHESS command summary\n");*/
  printz (CP[40]);
  printz ("----------------------------------------------------------------\n");
  /*printz ("g1f3      move from g1 to f3      quit      Exit Chess\n");*/
  printz (CP[158]);
  /*printz ("Nf3       move knight to f3       beep      turn %s\n", (flag.beep) ? "off" : "on");*/
  printz (CP[86], (flag.beep) ? CP[92] : CP[93]);
  /*printz ("a7a8q     promote pawn to queen\n");*/
  printz (CP[128], (flag.material) ? CP[92] : CP[93]);
  /*printz ("o-o       castle king side        easy      turn %s\n", (flag.easy) ? "off" : "on");*/
  printz (CP[173], (flag.easy) ? CP[92] : CP[93]);
  /*printz ("o-o-o     castle queen side       hash      turn %s\n", (flag.hash) ? "off" : "on");*/
  printz (CP[174], (flag.hash) ? CP[92] : CP[93]);
  /*printz ("bd        redraw board            reverse   board display\n");*/
  printz (CP[130]);
  /*printz ("list      game to chess.lst       book      turn %s used %d of %d\n", (Book) ? "off" : "on", bookcount, BOOKSIZE);*/
  printz (CP[170], (Book) ? CP[92] : CP[93], bookcount, BOOKSIZE);
  /*printz ("undo      undo last ply           remove    take back a move\n");*/
  printz (CP[200]);
  /*printz ("edit      edit board              force     enter game moves\n");*/
  printz (CP[153]);
  /*printz ("switch    sides with computer     both      computer match\n");*/
  printz (CP[194]);
  /*printz ("white     computer plays white    black     computer plays black\n");*/
  printz (CP[202]);
  /*printz ("depth     set search depth        clock     set time control\n");*/
  printz (CP[149]);
  /*printz ("post      principle variation     hint      suggest a move\n");*/
  printz (CP[177]);
  /*printz ("save      game to file            get       game from file\n");*/
  printz (CP[188]);
  /*printz ("random    randomize play          new       start new game\n");*/
  printz (CP[181]);
  printz ("----------------------------------------------------------------\n");
  /*printz ("Computer: %-12s Opponent:            %s\n",*/
  printz (CP[46],
	  ColorStr[computer], ColorStr[opponent]);
  /*printz ("Depth:    %-12d Response time:       %d sec\n",*/
  printz (CP[51],
	  MaxSearchDepth, MaxResponseTime/100);
  /*printz ("Random:   %-12s Easy mode:           %s\n",*/
  printz (CP[99],
	  (dither) ? CP[93] : CP[92], (flag.easy) ? CP[93] : CP[92]);
  /*printz ("Beep:     %-12s Transposition file: %s\n",*/
  printz (CP[36],
	  (flag.beep) ? CP[93] : CP[92], (flag.hash) ? CP[93] : CP[92]);
  /*printz ("Time Control %s %d moves %d seconds %d opr %d depth\n", (TCflag) ? "ON" : "OFF",*/
  printz (CP[110], (TCflag) ? CP[93] : CP[92],
	  TimeControl.moves[white], TimeControl.clock[white] / 100, OperatorTime, MaxSearchDepth);
  signal (SIGINT, TerminateSearch);
#ifndef MSDOS
  signal (SIGQUIT, TerminateSearch);
#endif /* MSDOS */
#endif
}

void
EditBoard (void)

/*
 * Set up a board position. Pieces are entered by typing the piece followed
 * by the location. For example, Nf3 will place a knight on square f3.
 */

{
  INTSIZE a, r, c, sq, i, found;
  int tmpcolor;
  char s[80];

  flag.regularstart = false;
  if (thinkahead)
   {
    flag.back = true;
    while (thinkahead)
     {
      Delay(20L);
     }
   }
  Book = 0;
#ifndef AMIGA
  /*printz (".   exit to main\n");*/
  printz (CP[29]);
  /*printz ("#   clear board\n");*/
  printz (CP[28]);
  /*printz ("c   change sides\n");*/
  printz (CP[136]);
  /*printz ("enter piece & location: \n");*/
  printz (CP[155]);
#else
  if (!OpenAmigaEditWindow())
   { /* open the window which will give us back text string */
    DisplayBeep(0L);
    Delay(25L);
    DisplayBeep(0L);
    return;
   }
#endif

  a = tmpcolor = white;
  do
    {
      GetEditText(s,&tmpcolor); /* amiga routine to get the command from user */
      found=0;
      if (s[0] == CP[28][0])	/*#*/
	for (sq = 0; sq < 64; sq++)
	  {
	    board[sq] = no_piece;
	    color[sq] = neutral;
	  }
      if (a != tmpcolor)	/*c*/
	a = otherside[a];
      c = s[1] - 'a';
      r = s[2] - '1';
      if ((c >= 0) && (c < 8) && (r >= 0) && (r < 8))
	{
	  sq = locn (r, c);
	  color[sq] = a;
	  board[sq] = no_piece;
	  for (i = no_piece; i <= king; i++)
	    if ((s[0] == pxx[i]) || (s[0] == qxx[i]))
	      {
		board[sq] = i;
		found=1;
		break;
	      }
	  if ((found==0)||(board[sq] == no_piece)) color[sq] = neutral;	
	}
  } while (s[0] != CP[29][0]);
  for (sq = 0; sq < 64; sq++)
    Mvboard[sq] = ((board[sq] != Stboard[sq]) ? 10 : 0);
  CloseAmigaEditWindow(); /* Closes the edit window */
  GameCnt = 0;
  Game50 = 1;
  ISZERO = 1;
  ZeroRPT ();
  Sdepth = 0;
  InitializeStats ();
  MoveMem128(board,amigaboard);
  MoveMem128(color,amigacolor);
  DrawAmigaBoard();
}

void
SetupBoard (void)

/*
 * Compatibility with Unix chess and the nchesstool. Set up a board position.
 * Eight lines of eight characters are used to setup the board. a8-h8 is the
 * first line. Black pieces are  represented  by  uppercase characters.
 */

{
#ifdef AMIGA
return;
#else
  INTSIZE r, c, sq, i;
  char ch;
  char s[80];

  NewGame ();

  gets (s);			/* skip "setup" command */
  for (r = 7; r >= 0; r--)
    {
      gets (s);
      for (c = 0; c <= 7; c++)
	{
	  ch = s[c];
	  sq = locn (r, c);
	  color[sq] = neutral;
	  board[sq] = no_piece;
	  for (i = no_piece; i <= king; i++)
	    if (ch == pxx[i])
	      {
		color[sq] = black;
		board[sq] = i;
		break;
	      }
	    else if (ch == qxx[i])
	      {
		color[sq] = white;
		board[sq] = i;
		break;
	      }
	}
    }
  for (sq = 0; sq < 64; sq++)
    Mvboard[sq] = ((board[sq] != Stboard[sq]) ? 10 : 0);
  InitializeStats ();
  ClrScreen ();
  UpdateDisplay (0, 0, 1, 0);
  /*printz ("Setup successful\n");*/
  printz (CP[106]);
#endif
}


void
ShowDepth (char ch)
{
#ifdef MSDOS
  ch++;				/* shut up the compiler */
#endif /* MSDOS */
}


void
ShowLine (INTSIZE unsigned int *bstline,char *astr)
{

      algbr ((INTSIZE) (bstline[1] >> 8), (INTSIZE) (bstline[1] & 0xFF), false);
      strcpy (astr,mvstr[0]);
}

void
ShowResults (INTSIZE int score, INTSIZE unsigned int *bstline, char ch)
{
 char astr[64];
 char nstr[16];

#if !defined CHESSTOOL
/*printf("GameCnt = %d PrevDepth = %d\n",GameCnt,GameList[GameCnt-1].depth);*/
  if ((!flag.easy)&&(ThinkAheadDepth)&&(TCflag)&&(GameCnt > 1)&&(Sdepth > 2))
   { /* check for lookahead abort */
    if ((Sdepth >= ThinkAheadDepth)&&(Sdepth >= GameList[GameCnt-1].depth)&&
        (Sdepth > GlobalTgtDepth)&&(global_tmp_score >= (previous_score-25)))
     { /* a chance I may want to abort search here */
        if (!flag.musttimeout)
         { /* not already aborted */
          if ((ThinkInARow < 4)||(Sdepth > ThinkAheadDepth))
           { /* max 4 times in a row */
            flag.musttimeout = true;
            if (Sdepth == ThinkAheadDepth)
             ThinkInARow++;
            else /* you thought past thinkaheaddepth */
             ThinkInARow = 0;
           }
         }
     }
   }
  if (flag.post)
    {
      ElapsedTime (2);
      mysprintf3(astr,"D%d S%d ", Sdepth, score);
      ShowLine (bstline,nstr);
      strcat(astr,nstr);
      ShowMessage(astr);
    }
#else
  REG int i;

  MSCORE = score;
  MV[30] = ch;
  for (i = 1; bstline[i] > 0; i++)
    {
      MV[i] = bstline[i];
    } MV[i] = 0;
#endif /* CHESSTOOL */
}

void
SearchStartStuff (INTSIZE int side)
{
 unsigned long numsecs;
 char astr[64];

//  signal (SIGINT, TerminateSearch);
//#ifndef MSDOS
//  signal (SIGQUIT, TerminateSearch);
//#endif /* MSDOS */
#if !defined CHESSTOOL
/*#ifndef AMIGA*/
  if (flag.post)
    {
      numsecs = (ResponseTime*2L+51L)/100L;
      if (TCflag)
       mysprintf4(astr,"Tgt:%d secs  ", numsecs);
      else
       mysprintf4(astr,"Tgt:%d ply   ", MaxSearchDepth);
      ShowMessage(astr);
    }
/*#endif*/
#endif /* CHESSTOOL */
}
void
OutputMove (cstring)
char *cstring;
{
 int r,c,l;
 char astr[40];
 char piece;

#ifdef DEBUG11
  if (1)
    {
      FILE *D;
      extern unsigned INTSIZE int PrVar[];
      char d[80];
      int r, c, l, i;
      D = fopen ("/tmp/DEBUGA", "a+");
      fprintf (D, "inout move is %s\n", mvstr[0]);
      strcpy (d, mvstr[0]);
      for (i = 1; PrVar[i] > 0; i++)
	{
	  algbr ((INTSIZE) (PrVar[i] >> 8), (INTSIZE) (PrVar[i] & 0xFF), false);
	  fprintf (D, "%5s ", mvstr[0]);
	}
      fprintf (D, "\n");

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
      strcpy (mvstr[0], d);
    }
#endif
if(flag.illegal){
 IllegalMove = 1;
 strcpy(IllegalString,CP[225]);
 return;
}
if (mvstr[0][0] == '\0') goto nomove;
#ifndef AMIGA
#if defined CHESSTOOL
  if (computer == black)
    printz ("%d. ... %s\n", GameCnt, mvstr[0]);
  else
    printz ("%d. %s\n", ++mycnt1, mvstr[0]);
#else
#ifdef XBOARD
  printz ("%d. ... %s\n", ++mycnt1, mvstr[0]);
#else
  printz ("%d. ... %s\n", ++mycnt1, mvstr[0]);
#endif
#endif /* CHESSTOOL */
#endif /* amiga */
#ifdef notdef
  if (flag.post)
    {
      REG int i;

      printz (" %6d%c ", MSCORE, MV[30]);
      for (i = 1; MV[i] > 0; i++)
	{
	  algbr ((INTSIZE) (MV[i] >> 8), (INTSIZE) (MV[i] & 0xFF), false);
	  printz ("%5s ", mvstr[0]);
	}
    }
  printz ("\n");
#endif
nomove:
  if ((root->flags & draw)||(root->score == -9999)||
      (root->score == 9998)) goto summary;
#if !defined CHESSTOOL
  if (flag.post)
    {
      INTSIZE h, l, t;

      h = TREE;
      l = 0;
      t = TREE >> 1;
      while (l != t)
	{
	  if (Tree[t].f || Tree[t].t)
	    l = t;
	  else
	    h = t;
	  t = (l + h) >> 1;
	}
#ifndef AMIGA
      /*printf ("Nodes %ld Tree %d Eval %ld Rate %ld RS high %ld low %ld\n",*/
      printf (CP[89],
	       NodeCnt, t, EvalNodes, (et) ? (NodeCnt / (et / 100)) : 0, reminus, replus);
      /*printf ("Hin/Hout/Coll/Fin/Fout = %ld/%ld/%ld/%ld/%ld\n",*/
      printf (CP[71],
	       HashAdd, HashCnt, THashCol, HashCol, FHashAdd, FHashCnt);
#else /* print out thinking on amiga */
#endif
    }
  UpdateDisplay (root->f, root->t, 0, root->flags);
#ifndef AMIGA
  /*printf ("My move is: %s\n", mvstr[0]);*/

  printz (CP[83], mvstr[0]);
#else
      r = mvstr[0][3] - '1';
      c = mvstr[0][2] - 'a';
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
  if (computer == black)
   {
    mysprintf(astr,"%d: ",GameCnt>>1);
    strcat(astr,mvstr[0]);
   }
  else
   {
    mysprintf(astr,"%d: ",(GameCnt+1)>>1);   
    strcat(astr,mvstr[0]);
   }
  DisplayComputerMove(astr);
  if (piece != ' ')
   AnimateAmigaMove(mvstr[0],piece);
#endif
  if ((flag.beep)&&(!flag.bothsides))
   {
    DisplayBeep(0L);
   }
#endif /* CHESSTOOL */
 summary:
  if (root->flags & draw)
    /*	printf ("Drawn game!\n");*/
   {
    /*printz (CP[57]);*/
    DrawnGame = 1;
   }
  else if (root->score == -9999)
   {
    Mate = 1;
    strcpy(MateString,ColorStr[opponent]);
    strcat(MateString," mates!");
/*    printz("%s mates!\n",ColorStr[opponent]);*/
   }
  else if (root->score == 9998)
   {
    Mate = 1;
    DoAMove();
    if (flag.bothsides)
     {
      strcpy(MateString,ColorStr[computer^1]);
      strcat(MateString," mates!");
     }
    else
     {
      strcpy(MateString,ColorStr[computer]);
      strcat(MateString," mates!");
     }
/*    printz("%s mates!\n",ColorStr[computer]);*/
   }
#if !defined CHESSTOOL && !defined XBOARD
#ifdef VERYBUGGY
  else if (root->score < -9000)
    /*printf("%s has a forced mate!\n",ColorStr[opponent]);*/
  else if (root->score > 9000)
    /*printf("%s has a forced mate!\n",ColorStr[computer]);*/
#endif /*VERYBUGGY*/
#endif /* CHESSTOOL */
}

void
ClrScreen (void)
{
#if !defined CHESSTOOL && !defined XBOARD && !defined AMIGA
  printz ("\n");
#endif
#ifdef AMIGA
#endif
}

void
UpdateDisplay (INTSIZE int f, INTSIZE int t, INTSIZE int redraw, INTSIZE int isspec)
{

#ifndef AMIGA
  INTSIZE r, c, l, m;
#endif

  if (redraw && !chesstool)
    {
#ifndef AMIGA /* text clock and etc display */
      printz ("\n");
      r = TimeControl.clock[white] / 6000;
      c = (TimeControl.clock[white] % 6000) / 100;
      l = TimeControl.clock[black] / 6000;
      m = (TimeControl.clock[black] % 6000) / 100;
      /*printz ("White %d:%02d  Black %d:%02d\n", r, c, l, m);*/
      printz (CP[116], r, c, l, m);
      printz ("\n");
      for (r = 7; r >= 0; r--)
	{
	  for (c = 0; c <= 7; c++)
	    {
	      l = ((flag.reverse) ? locn (7 - r, 7 - c) : locn (r, c));
	      if (color[l] == neutral)
		printz (" -");
	      else if (color[l] == white)
		printz (" %c", qxx[board[l]]);
	      else
		printz (" %c", pxx[board[l]]);
	    }
	  printz ("\n");
	}
      printz ("\n");
#else /* Update intution board on the Amiga */
#endif
    }
}

void
skip ()
{
  while (*InPtr != ' ')
    InPtr++;
  while (*InPtr == ' ')
    InPtr++;
}
void
skipb ()
{
  while (*InPtr == ' ')
    InPtr++;
}

#ifndef AMIGA
void
ShowMessage (char *s)
{
#ifndef AMIGA
  printf("%s\n", s);
#else /* write this msg on the intuition msg screen */
  DisplayComputerMove(s);
#endif
}

#endif

void
ShowSidetoMove (void)
{
}

void
PromptForMove (void)
{
#if !defined CHESSTOOL && !defined XBOARD && !defined AMIGA
  /*printz ("\nYour move is? ");*/
  printz (CP[124]);
#endif /* CHESSTOOL */
}


void
ShowCurrentMove (INTSIZE int pnt, INTSIZE int f, INTSIZE int t)
{
#ifdef MSDOS
  f++;
  t++;
  pnt++;			/* shut up the compiler */
#endif /* MSDOS */
}

void
ChangeAlphaWindow (void)
{
#ifndef AMIGA
  printz ("WAwindow: ");
  scanz ("%hd", &WAwindow);
  printz ("BAwindow: ");
  scanz ("%hd", &BAwindow);
#endif
}


void
ChangeBetaWindow (void)
{
#ifndef AMIGA
  printz ("WBwindow: ");
  scanz ("%hd", &WBwindow);
  printz ("BBwindow: ");
  scanz ("%hd", &BBwindow);
#endif
}

void
GiveHint (void)
{
  if (hint)
    {
      algbr2 ((INTSIZE) (hint >> 8), (INTSIZE) (hint & 0xFF), false);
      strcpy(HintString,"Hint : ");
      strcat(HintString,mvstrhint[0]);
    }
  else
    strcpy (HintString,"No idea..");
#ifndef AMIGA
printf(HintString);
#else
DisplayComputerMove(HintString);
#endif
}

void
SelectLevel (timestring)
char *timestring;
{
  int tmp;
  char T[64], *p, *q;

#ifndef AMIGA
  printz (CP[61]);
  scanz ("%hd %s", &TCmoves, T);
#else
#ifndef LONGINTS2
  sscanf(timestring,"%hd %s",&TCmoves,T);
#else
  sscanf(timestring,"%d %s",&TCmoves,T);
#endif
#endif
  for (p = T; *p == ' '; p++) ;
  TCminutes = strtol (p, &q, 10);
  TCadd = 0;
  if (TCminutes < 1)
   TCminutes = 1;
  if (TCmoves < 1)
   TCmoves = 1;
//  if ((TCminutes/TCmoves) > 0)
//   {
    EnableMoveNow();
//   }
//  else
//   {
//    DisableMoveNow();
//   }
  if (*q == ':')
    TCseconds = strtol (q + 1, (char **) NULL, 10);
  else
    TCseconds = 0;
#ifdef OPERATORTIME
  printz (CP[94]);
  scanz ("%hd", &OperatorTime);
#endif
  if (TCmoves == 0) {
    TCflag = false;
    MaxResponseTime = TCminutes*60L*100L + TCseconds*100L;
    TCminutes = TCseconds = 0;
  } else {
    TCflag = true;
    MaxResponseTime = 0;
    MaxSearchDepth = MAXDEPTH - 1;
  }
  SetTimeControl ();
#ifdef AMIGA
  tmp = player;
  player = white;
  UpdateClocks();
  player = black;
  UpdateClocks();
  player = tmp;
#endif
}

#ifdef DEBUG
void
ChangeDbLev (void)
{
  printz (CP[146]);
  scanz ("%hd", &debuglevel);
}

#endif /* DEBUG */

void
ChangeSearchDepth (void)
{
 int Old;

 Old = MaxSearchDepth;
#ifndef AMIGA
  printz ("depth= ");
  scanz ("%hd", &MaxSearchDepth);
#else
  MaxSearchDepth = SetAmigaDepth();
#endif
  if (MaxSearchDepth)
   {
    TCflag = !(MaxSearchDepth > 0);
    if (MaxSearchDepth > 2)
     EnableMoveNow();
   }
  else
   MaxSearchDepth = Old;
}

void ChangeHashDepth (void)
{
#ifndef AMIGA
  printz ("hashdepth= ");
  scanz ("%hd", &HashDepth);
  printz ("MoveLimit= ");
  scanz ("%hd", &HashMoveLimit);
#endif
}

void
SetContempt (void)
{
#ifndef AMIGA
  printz ("contempt= ");
  scanz ("%hd", &contempt);
#endif
}

void
ChangeXwindow (void)
{
#ifndef AMIGA
  printz ("xwndw= ");
  scanz ("%hd", &xwndw);
#endif
}

#ifdef DEBUGG
void
ShowPostnValue (INTSIZE int sq)

/*
 * must have called ExaminePosition() first
 */

{
  char astr[80];
  INTSIZE score;

  score = ScorePosition (color[sq]);
  if (color[sq] != neutral){
    sprintf (astr,"%3d%c ", svalue[sq],(color[sq] == black)?'b':'w');}
  else
    sprintf(astr," *   ");
  ShowMessage(astr);
}

void
DoDebug (void)
{
#ifndef AMIGA
  INTSIZE c, p, sq, tp, tc, tsq, score,j,k;
  char s[40];

  ExaminePosition ();
  ShowMessage (CP[65]);
  scanz ("%s", s);
  c = neutral;
  if (s[0] == CP[9][0] || s[0] == CP[9][1])     /* w W*/ c = white;
  if (s[0] == CP[9][2] || s[0] == CP[9][3])     /*b B*/ c = black;
  for (p = king; p > no_piece; p--)
    if ((s[1] == pxx[p]) || (s[1] == qxx[p])) break;
  if(p > no_piece)
  for(j=7;j>=0;j--){
  for(k=0;k<8;k++){
      sq=j*8+k;
      tp = board[sq];
      tc = color[sq];
      board[sq] = p;
      color[sq] = c;
      tsq = PieceList[c][1];
      PieceList[c][1] = sq;
      ShowPostnValue (sq);
      PieceList[c][1] = tsq;
      board[sq] = tp;
      color[sq] = tc;
    }
      printz("\n");
    }
  score = ScorePosition (opponent);
  printz (CP[103], score, mtl[computer], pscore[computer], mtl[opponent],pscore[opponent]);
#endif
}

void
DoTable (INTSIZE table[64])
{
  char astr[16];
  INTSIZE  sq,j,k;
  ExaminePosition ();
  for(j=7;j>=0;j--){
  for(k=0;k<8;k++){
    sq=j*8+k;
    sprintf (astr,"%3d ", table[sq]);
    ShowMessage(astr);
  }
}
}

void
ShowPostnValues (void)
{
  INTSIZE sq, score,j,k;
  char astr[64];

  ExaminePosition ();
  for(j=7;j>=0;j--){
  for(k=0;k<8;k++){
  sq=j*8+k;
    ShowPostnValue (sq);
  }
  }
  score = ScorePosition (opponent);
 sprintf (astr,CP[103], score, mtl[computer], pscore[computer], mtl[opponent],pscore[opponent]);
 ShowMessage(astr);
 sprintf(astr,"hung white %d hung black %d\n",hung[white],hung[black]);
 ShowMessage(astr);
}

#endif

/*
 * init.c - C source for GNU CHESS
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
#include <string.h>

#include "gnuchess.h"

#ifdef CACHE
extern struct etable etab[2][ETABLE];
#endif

extern int ThinkInARow;
extern int bookflag;
extern int Sdepth2;

#ifdef AMIGA
#define __USE_SYSBASE
#define MOVENOWMENUNUM 0x42
#define THINKMENUNUM 0x82
#define SHOWMENUNUM 0xa2
#define BOOKMENUNUM 0xc2
#define SUPERMENUNUM 0xe2
#define ADVANCEDMENUNUM 0x102
#define INTERMEDIATEMENUNUM 0x122
#define EASYMENUNUM 0x142
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/intuition.h>
extern int cmptr_sec,cmptr_min,hum_sec,hum_min;
extern int procpri;
extern struct Process *myproc;
extern int ResignOffered;
#endif

extern struct Menu Menu1;
#define MenuList1 Menu1
extern int MenuStripSet;
extern struct MenuItem MenuItem8ab;
extern struct Window *wG;
unsigned int urand (void);


/* .... MOVE GENERATION VARIABLES AND INITIALIZATIONS .... */


void InitHashCode(unsigned int);
short PCRASH,PCENTER;
extern int PlayMode;
extern unsigned int TTadd;

#if defined NULLMOVE || defined DEEPNULL
extern short int no_null;
extern short int null;         /* Null-move already made or not */
extern short int PVari;        /* Is this the PV */
#endif
extern short Threat[MAXDEPTH];
extern unsigned short int PrVar[MAXDEPTH];
extern short PawnStorm;
extern short start_stage;
extern short thrashing_tt; /* must we recycle slots at random. TomV */
extern short int ISZERO;
extern int global_tmp_score;
extern int previous_score;
int FirstTime=1;
extern int SupervisorMode;
extern int IllegalMove;
extern int CheckIllegal;
#ifdef LONGINTS2
INTSIZE  distdata[64][64];
INTSIZE  taxidata[64][64];
#else
INTSIZE  distdata[64][64];
INTSIZE  taxidata[64][64];
#endif

#ifdef KILLT
/* put moves to the center first */
void
Initialize_killt (void)
{
  REG unsigned INTSIZE f, t, s;
  REG INTSIZE d;
  for (f = 64; f--;)
    for (t = 64; t--;)
      {
	d = taxidata[f][0x1b];
	if (taxidata[f][0x1c] < d)
	  d = taxidata[f][0x1c];
	if (taxidata[f][0x23] < d)
	  d = taxidata[f][0x23];
	if (taxidata[f][0x24] < d)
	  d = taxidata[f][0x24];
	s = d;
	d = taxidata[t][0x1b];
	if (taxidata[t][0x1c] < d)
	  d = taxidata[t][0x1c];
	if (taxidata[t][0x23] < d)
	  d = taxidata[t][0x23];
	if (taxidata[t][0x24] < d)
	  d = taxidata[t][0x24];
	s -= d;
	killt[(f << 8) | t] = s;
	killt[(f << 8) | t | 0x80] = s;
      }
}
#endif
void
Initialize_dist (void)
{
  REG INTSIZE a, b, d, di;

  for (a = 0; a < 64; a++)
    for (b = 0; b < 64; b++)
      {
	d = abs (column (a) - column (b));
	di = abs (row (a) - row (b));
	taxidata[a][b] = d + di;
	distdata[a][b] = (d > di ? d : di);
      }
#ifdef KILLT
  Initialize_killt ();
#endif
}

const INTSIZE Stboard[64] =
{rook, knight, bishop, queen, king, bishop, knight, rook,
 pawn, pawn, pawn, pawn, pawn, pawn, pawn, pawn,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 pawn, pawn, pawn, pawn, pawn, pawn, pawn, pawn,
 rook, knight, bishop, queen, king, bishop, knight, rook};
const INTSIZE Stcolor[64] =
{white, white, white, white, white, white, white, white,
 white, white, white, white, white, white, white, white,
 neutral, neutral, neutral, neutral, neutral, neutral, neutral, neutral,
 neutral, neutral, neutral, neutral, neutral, neutral, neutral, neutral,
 neutral, neutral, neutral, neutral, neutral, neutral, neutral, neutral,
 neutral, neutral, neutral, neutral, neutral, neutral, neutral, neutral,
 black, black, black, black, black, black, black, black,
 black, black, black, black, black, black, black, black};
INTSIZE board[64], color[64];
INTSIZE amigaboard[64],amigacolor[64];

/* given epsquare, from where can a pawn be taken? */
const INTSIZE epmove1[64] =
{0, 1, 2, 3, 4, 5, 6, 7,
 8, 9, 10, 11, 12, 13, 14, 15,
 16, 24, 25, 26, 27, 28, 29, 30,
 24, 25, 26, 27, 28, 29, 30, 31,
 32, 33, 34, 35, 36, 37, 38, 39,
 40, 32, 33, 34, 35, 36, 37, 38,
 48, 49, 50, 51, 52, 53, 54, 55,
 56, 57, 58, 59, 60, 61, 62, 63};
const INTSIZE epmove2[64] =
{0, 1, 2, 3, 4, 5, 6, 7,
 8, 9, 10, 11, 12, 13, 14, 15,
 25, 26, 27, 28, 29, 30, 31, 23,
 24, 25, 26, 27, 28, 29, 30, 31,
 32, 33, 34, 35, 36, 37, 38, 39,
 33, 34, 35, 36, 37, 38, 39, 47,
 48, 49, 50, 51, 52, 53, 54, 55,
 56, 57, 58, 59, 60, 61, 62, 63};


/*
 * nextpos[piece][from-square] , nextdir[piece][from-square] gives vector of
 * positions reachable from from-square in ppos with piece such that the
 * sequence	ppos = nextpos[piece][from-square]; pdir =
 * nextdir[piece][from-square]; u = ppos[sq]; do { u = ppos[u]; if(color[u]
 * != neutral) u = pdir[u]; } while (sq != u); will generate the sequence of
 * all squares reachable from sq.
 *
 * If the path is blocked u = pdir[sq] will generate the continuation of the
 * sequence in other directions.
 */

unsigned char nextpos[8][64][64];
unsigned char nextdir[8][64][64];

/*
 * ptype is used to separate white and black pawns, like this; ptyp =
 * ptype[side][piece] piece can be used directly in nextpos/nextdir when
 * generating moves for pieces that are not black pawns.
 */
const INTSIZE ptype[2][8] =
{
  no_piece, pawn, knight, bishop, rook, queen, king, no_piece,
  no_piece, bpawn, knight, bishop, rook, queen, king, no_piece};

/* data used to generate nextpos/nextdir */
static const INTSIZE direc[8][8] =
{
  0, 0, 0, 0, 0, 0, 0, 0,
  10, 9, 11, 0, 0, 0, 0, 0,
  8, -8, 12, -12, 19, -19, 21, -21,
  9, 11, -9, -11, 0, 0, 0, 0,
  1, 10, -1, -10, 0, 0, 0, 0,
  1, 10, -1, -10, 9, 11, -9, -11,
  1, 10, -1, -10, 9, 11, -9, -11,
  -10, -9, -11, 0, 0, 0, 0, 0};
static const INTSIZE max_steps[8] =
{0, 2, 1, 7, 7, 7, 1, 2};
static const INTSIZE nunmap[120] =
{
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, 0, 1, 2, 3, 4, 5, 6, 7, -1,
  -1, 8, 9, 10, 11, 12, 13, 14, 15, -1,
  -1, 16, 17, 18, 19, 20, 21, 22, 23, -1,
  -1, 24, 25, 26, 27, 28, 29, 30, 31, -1,
  -1, 32, 33, 34, 35, 36, 37, 38, 39, -1,
  -1, 40, 41, 42, 43, 44, 45, 46, 47, -1,
  -1, 48, 49, 50, 51, 52, 53, 54, 55, -1,
  -1, 56, 57, 58, 59, 60, 61, 62, 63, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1};

int InitFlag = false;
void
Initialize_moves (void)

/*
 * This procedure pre-calculates all moves for every piece from every square.
 * This data is stored in nextpos/nextdir and used later in the move
 * generation routines.
 */

{
  INTSIZE ptyp, po, p0, d, di, s, delta;
  unsigned char *ppos, *pdir;
  INTSIZE dest[8][8];
  INTSIZE steps[8];
  INTSIZE sorted[8];

  for (ptyp = 0; ptyp < 8; ptyp++)
    for (po = 0; po < 64; po++)
      for (p0 = 0; p0 < 64; p0++)
	{
	  nextpos[ptyp][po][p0] = (unsigned char) po;
	  nextdir[ptyp][po][p0] = (unsigned char) po;
	}
  for (ptyp = 1; ptyp < 8; ptyp++)
    for (po = 21; po < 99; po++)
      if (nunmap[po] >= 0)
	{
	  ppos = nextpos[ptyp][nunmap[po]];
	  pdir = nextdir[ptyp][nunmap[po]];
	  /* dest is a function of direction and steps */
	  for (d = 0; d < 8; d++)
	    {
	      dest[d][0] = nunmap[po];
	      delta = direc[ptyp][d];
	      if (delta != 0)
		{
		  p0 = po;
		  for (s = 0; s < max_steps[ptyp]; s++)
		    {
		      p0 = p0 + delta;

		      /*
		       * break if (off board) or (pawns only move two
		       * steps from home square)
		       */
		      if ((nunmap[p0] < 0) || (((ptyp == pawn) || (ptyp == bpawn))
					       && ((s > 0) && ((d > 0) || (Stboard[nunmap[po]] != pawn)))))
			break;
		      else
			dest[d][s] = nunmap[p0];
		    }
		}
	      else
		s = 0;

	      /*
	       * sort dest in number of steps order currently no sort
	       * is done due to compability with the move generation
	       * order in old gnu chess
	       */
	      steps[d] = s;
	      for (di = d; s > 0 && di > 0; di--)
		if (steps[sorted[di - 1]] == 0)	/* should be: < s */
		  sorted[di] = sorted[di - 1];
		else
		  break;
	      sorted[di] = d;
	    }

	  /*
	   * update nextpos/nextdir, pawns have two threads (capture
	   * and no capture)
	   */
	  p0 = nunmap[po];
	  if (ptyp == pawn || ptyp == bpawn)
	    {
	      for (s = 0; s < steps[0]; s++)
		{
		  ppos[p0] = (unsigned char) dest[0][s];
		  p0 = dest[0][s];
		}
	      p0 = nunmap[po];
	      for (d = 1; d < 3; d++)
		{
		  pdir[p0] = (unsigned char) dest[d][0];
		  p0 = dest[d][0];
		}
	    }
	  else
	    {
	      pdir[p0] = (unsigned char) dest[sorted[0]][0];
	      for (d = 0; d < 8; d++)
		for (s = 0; s < steps[sorted[d]]; s++)
		  {
		    ppos[p0] = (unsigned char) dest[sorted[d]][s];
		    p0 = dest[sorted[d]][s];
		    if (d < 7)
		      pdir[p0] = (unsigned char) dest[sorted[d + 1]][0];

		    /*
		     * else is already initialized
		     */
		  }
	    }
	}
}

void
NewGame (void)

/*
 * Reset the board and other variables to start a new game.
 */

{
  INTSIZE l;
  int tmp;
  char tstr[32];
  INTSIZE a, r, c, sq, i, found = found;
  int tmpcolor;
  char s[16];

 TTadd = ISZERO = 1;
 cmptr_min = hum_min = cmptr_sec = hum_sec = -1;
 if (AmigaStarted)
  {
   if (FirstTime)
    {
     FirstTime = 0;
    }
   else
    {
     if (!LoadFullBitMap())
      {
       ExitChess();
      }
     (void)SetTaskPri((struct Task *)myproc,procpri);
    }
  }
/* SupervisorMode = 0;*/
 bookflag = previous_score = 0;
 global_tmp_score = 0;
 CheckIllegal = IllegalMove = 0;
  Mate = 0;
 ResignOffered = 0;
 ThinkInARow = ThinkAheadDepth = ThinkAheadWorked = 0;
 DrawnGame = 0;
 MateString[0] = '\0';
  compptr = oppptr = 0; // was -1 in 2.35
  stage = stage2 = -1;		/* the game is not yet started */
  flag.illegal = flag.mate = flag.quit = flag.reverse = flag.bothsides = flag.onemove = flag.force = false;
  flag.material = flag.coords = flag.hash = flag.beep = flag.rcptr = true;
  flag.threat = true;
  flag.stars = flag.shade = flag.back = flag.musttimeout = false;
#ifdef CLIENT
  flag.gamein = true;
#else 
  flag.gamein = false;
#endif
#if defined(MSDOS) && !defined(SEVENBIT)
  flag.rv = false;
#else
  flag.rv = true;
#endif /* MSDOS && !SEVENBIT */

  ClearPointer(wG);
  mycnt1 = mycnt2 = 0;
  GenCnt = NodeCnt = et0 = epsquare = XCmore = 0;
  dither = 0;
  WAwindow = WAWNDW;
  WBwindow = WBWNDW;
  BAwindow = BAWNDW;
  BBwindow = BBWNDW;
  xwndw = BXWNDW;
  if (!MaxSearchDepth)
    MaxSearchDepth = MAXDEPTH - 1;
  contempt = 0;
  GameCnt = 0;
  Game50 = 1;
  hint = 0x0C14;
  ISZERO = 1;
  ZeroRPT ();
  Developed[white] = Developed[black] = false;
  MouseDropped = 0;
  Castled[white] = Castled[black] = 0;
  myEnPassant[white] = myEnPassant[black] = 0;
  castld[white] = castld[black] = false;
#if defined NULLMOVE || defined DEEPNULL
  no_null=0;
  null = 0;         /* Null-move already made or not */
  PVari = 0;        /* Is this the PV */
#endif
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
  PawnThreat[0] = CptrFlag[0] = false;
  Pscore[0] = 12000;
  Tscore[0] = 12000;
  opponent = white;
  computer = black;
  for (l = 0; l < TREE; l++)
    Tree[l].f = Tree[l].t = 0;
#ifdef OLD_TTABLE
 gsrand ((unsigned int) 1);
  if (!InitFlag)
    {
      for (c = white; c <= black; c++)
	for (p = pawn; p <= king; p++)
	  for (l = 0; l < 64; l++)
	    {
	      hashcode[c][p][l].key = (((unsigned long) urand ()));
	      hashcode[c][p][l].key += (((unsigned long) urand ()) << 16);
	      hashcode[c][p][l].bd = (((unsigned long) urand ()));
	      hashcode[c][p][l].bd += (((unsigned long) urand ()) << 16);
#ifdef LONG64
	      hashcode[c][p][l].key += (((unsigned long) urand ()) << 32);
	      hashcode[c][p][l].key += (((unsigned long) urand ()) << 48);
	      hashcode[c][p][l].bd += (((unsigned long) urand ()) << 32);
	      hashcode[c][p][l].bd += (((unsigned long) urand ()) << 48);
#endif
	    }
    }
#else //new ttable stuff from pl70
  if (!InitFlag)
    InitHashCode((unsigned int)1);
#endif // oldttable
  for (l = 0; l < 64; l++)
    {
      amigaboard[l] = board[l] = Stboard[l];
      amigacolor[l] = color[l] = Stcolor[l];
      Mvboard[l] = 0;
    }
  InitializeStats ();
  time0 = time ((long *) 0);
  ElapsedTime (1);
  flag.regularstart = true;
  if (MenuStripSet)
   {
    MenuItem8ab.Flags |= CHECKED;
    SetMenuStrip(wG,&MenuList1);	/* attach any Menu */
   }
  Book = BOOKFAIL;
  if (!InitFlag)
    {
      if (TCflag)
       {
        strcpy(tstr,"60 10");
	SelectLevel (tstr);
	SetTimeControl ();
       }
      else if (MaxResponseTime == 0)
       {
        strcpy(tstr,"60 10");
	SelectLevel (tstr);
	SetTimeControl ();
       }
      UpdateDisplay (0, 0, 1, 0);
/*    GetOpenings(black);*/
#ifdef CACHE
      Initialize_ttable();
#endif
      InitFlag = true;
    }
   else
    {
      if (TCflag)
       {
        sprintf(tstr,"%d %d",TCmoves,TCminutes);
	SelectLevel (tstr);
	SetTimeControl ();
       }
    }
  GetOpenings(black);
  hashbd = hashkey = 0;
#ifdef AMIGA
  tmp = player;
  player = white;
  UpdateClocks();
  player = black;
  UpdateClocks();
  player = tmp;
#endif
#ifdef CACHE
#if ttblsz
  ZeroTTable (0);
  TTadd = 0;
#endif /* ttblsz */
#ifndef AMIGA
   memset ((signed char *) etab, 0, sizeof (etab));
#else
   ClearMem(etab,sizeof(etab));
#endif
#endif
 if (PlayMode == 1)
  {
    flag.regularstart = false;
    Book = 0;

      strcpy(s," g8");
      a = tmpcolor = black;
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
      strcpy(s," b8");
      a = tmpcolor = black;
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

    if (MenuStripSet)
     {
      OnMenu(wG,ADVANCEDMENUNUM);
      OffMenu(wG,BOOKMENUNUM);
      OffMenu(wG,INTERMEDIATEMENUNUM); 
      OnMenu(wG,EASYMENUNUM); 
     }
    GameCnt = 0;
    Game50 = 1;
    ISZERO = 1;
    ZeroRPT ();
    Sdepth2 = Sdepth = 0;
    InitializeStats ();
    DrawAmigaBoard();
  }
 else if (PlayMode == 0)
  {
    flag.regularstart = false;
    Book = 0;

      strcpy(s," d8");
      a = tmpcolor = black;
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
      strcpy(s," g8");
      a = tmpcolor = black;
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
      strcpy(s," b8");
      a = tmpcolor = black;
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

   if (MenuStripSet)
    {
     OnMenu(wG,ADVANCEDMENUNUM); 
     OnMenu(wG,INTERMEDIATEMENUNUM); 
     OffMenu(wG,EASYMENUNUM);
     OffMenu(wG,BOOKMENUNUM);
    }
    GameCnt = 0;
    Game50 = 1;
    ISZERO = 1;
    ZeroRPT ();
    Sdepth2 = Sdepth = 0;
    InitializeStats ();
    DrawAmigaBoard();
  }
 else if (PlayMode == 2)
  {
    if (MenuStripSet)
     {
      OnMenu(wG,BOOKMENUNUM);
      OffMenu(wG,ADVANCEDMENUNUM); 
      OnMenu(wG,INTERMEDIATEMENUNUM); 
      OnMenu(wG,EASYMENUNUM); 
     }
  }
#ifdef KILLT
 ClearMem(killt,sizeof(killt));
 Initialize_dist ();
#endif
#ifdef HISTORY
#ifdef AMIGA
 ClearMem(history,sizeof(history));
#else
 memset(history,0,sizeof(history));
#endif
#endif
#ifdef NODITHER
  PCRASH = PCRASHS;
  PCENTER = PCENTERS;
#else
  PCRASH = PCRASHS + (dither?(rand() % PCRASHV):0);
  PCENTER = PCENTERS + (dither?(rand() % PCENTERV):0);
#endif
#ifndef __MORPHOS__
  MoveMem128(board,amigaboard);
  MoveMem128(color,amigacolor);
#else
  CopyMem(board, amigaboard, 128);
  CopyMem(color, amigacolor, 128);
#endif
}

void
InitConst (char *lang)
{
  FILE *constfile;
  char s[256];
  char sl[5];
  int len, entry;
  char *p, *q;

  constfile = fopen (LANGFILE, "r");
  if (!constfile)
    {
     /* printf ("NO LANGFILE\n");*/
      exit (1);
    }
  while (fgets (s, sizeof (s), constfile))
    {
      if (s[0] == '!')
	continue;
      len = strlen (s);
      for (q = &s[len]; q > &s[8]; q--)
	if (*q == '}')
	  break;
      if (q == &s[8])
	{
/*	  printf ("{ error in cinstfile\n");*/
	  exit (1);
	}
      *q = '\0';
      if (s[3] != ':' || s[7] != ':' || s[8] != '{')
	{
	/*  printf ("Langfile format error %s\n", s);*/
	  exit (1);
	}
      s[3] = s[7] = '\0';
      if (lang == NULL)
	{
	  lang = sl;
	  strcpy (sl, &s[4]);
	}
      if (strcmp (&s[4], lang))
	continue;
      entry = atoi (s);
      if (entry < 0 || entry >= CPSIZE)
	{
	 /* printf ("Langfile number error\n");*/
	  exit (1);
	}
      for (q = p = &s[9]; *p; p++)
	{
	  if (*p != '\\')
	    {
	      *q++ = *p;
	    }
	  else if (*(p + 1) == 'n')
	    {
	      *q++ = '\n';
	      p++;
	    }
	}
      *q = '\0';
      if (entry < 0 || entry > 255)
	{
	 /* printf ("Langfile error %d\n", entry);*/
	  exit (0);
	}
      CP[entry] = (char *) malloc ((unsigned) strlen (&s[9]) + 1);
      if (CP[entry] == NULL)
	{
	  ShowMessage("malloc");
	  exit (0);
	}
      strcpy (CP[entry], &s[9]);

    }
  fclose (constfile);
}

#ifdef OLDTTABLE

#ifndef CACHE
#ifdef ttblsz
void
Initialize_ttable ()
{
  if (rehash < 0)
    rehash = MAXrehash - 1;
}

#endif /* ttblsz */

#else

#ifdef ttblsz
void

Initialize_ttable ()
{
  char astr[32];
  int doit = true;
  if (rehash < 0)
    rehash = MAXrehash;
while(doit && ttblsize >= (1<<13)){
  ttable[0] = (struct hashentry *)malloc((unsigned)(sizeof(struct hashentry))*(ttblsize+rehash));
  ttable[1] = (struct hashentry *)malloc((unsigned)(sizeof(struct hashentry))*(ttblsize+rehash));
  if(ttable[0] == NULL || ttable[1] == NULL){
  if(ttable[0] != NULL)free(ttable[0]);
  ttblsize = ttblsize>>1;
  } else doit = false;
}
  if(ttable[0] == NULL || ttable[1] == NULL)
   {
    ShowMessage("Critical Mem Failure");
    Delay(100L);
    AmigaShutDown();
    exit(1);
   }
  sprintf(astr,"transposition tbl is %d\n",ttblsize);
  ShowMessage(astr);
}

#endif /* ttblsz */
#endif
#endif // oldttable

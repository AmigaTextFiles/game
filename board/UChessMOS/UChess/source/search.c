// about splitting the search into a new thread, perhaps
// the best place to check the msg queue is in UpdateClocks,
// called from ElapsedTime, you would set a flag in here
// before you call each ElapsedTime, telling the system
// to check the msg queue in there for any new moves

//char strx[40];
#define CLEARHISTBETWEENMOVES // old way to handle hist table
/*
 * search.c - C source for GNU CHESS
 *
 * Copyright (c) 1988,1989,1990 John Stanback Copyright (c) 1992 Free Software
 * Foundation
 *
 * This file is part of GNU CHESS.
 *
 * GNU Chess is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2, or (at your option) any later
 * version.
 *
 * GNU Chess is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * GNU Chess; see the file COPYING.  If not, write to the Free Software
 * Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */
#include <string.h>

#include "gnuchess.h"

#define PTRHEIGHT 55
extern UWORD myPointer[];
#include <proto/intuition.h>
extern struct Window *wG;
extern int SupervisorMode;


#define ZEROALLBETWEENPLY 1

#ifdef QUIETBACKGROUND
short background = 0;

#endif /* QUIETBACKGROUND */
static short int DepthBeyond;
short Threat[MAXDEPTH];
unsigned short int PrVar[MAXDEPTH];
extern short int ISZERO;
extern long EADD,EGET;
extern char mvstr[8][8];
extern short int recycle;
extern int GetEntryDone;
extern int trying_again;
short int myflagdeepnull=0xff;
int got_20000=0;
short ThreatSave[MAXDEPTH]; /* tom@izf.tno.nl */
extern short QueenCheck[MAXDEPTH]; /* tom@izf.tno.nl */
#if defined NULLMOVE || defined DEEPNULL
short int no_null;
short int null;         /* Null-move already made or not */
short int PVari;        /* Is this the PV */
#endif
#ifdef DEBUG40
extern int whichway;
#endif
#ifdef DEBUG
unsigned short DBLINE[MAXDEPTH];
struct leaf *dbptr;

#endif
short start_stage;
short thrashing_tt; /* must we recycle slots at random. TomV */
short int zwndw;

#include "ataks3.h"

#define __USE_SYSBASE
#include <proto/exec.h>

extern long OrigResponse;
extern int global_tmp_score;
extern int previous_score;
short myflagpvs=true;
int backsrchaborted=0;
int Sdepth2=0;
extern int MoveNowOK;
extern int procpri;
extern struct Process *myproc;
extern struct MsgPort *InThreadPort;
extern struct myMsgStruct Global_Message;

int RealThink=0;

#ifdef SPEED_PRECALC
unsigned short PreCalcedHint;
unsigned short PreCalcedMove;
int DoPreCalc (unsigned INTSIZE *, INTSIZE);
#endif
int Castled[2]={0,0};
int myEnPassant[2]={0,0};

#include "ttable.c"


short int __inline repetition (void);


#include "debug41.h"
/* ............    MOVE GENERATION & SEARCH ROUTINES    .............. */

//#define STRAIGHT4PL70 1 // for repetiton code
#ifndef STRAIGHT4PL70
// improved Kong Sian Repetition

short int __inline
repetition ()

/*  Check for draw by threefold repetition.  */

{
  register short i, cnt;

  cnt = 0;
  /* try to avoid work */
  if (GameCnt > Game50 + 3)
    for (i = GameCnt; i >= Game50; i--)
      if (hashbd == GameList[i].hashbd && hashkey == GameList[i].hashkey)
        cnt++;

  return cnt;
}

#else // straight 4pl70 repetition
short int __inline
repetition ()

/*  Check for draw by threefold repetition.  */

{
  register SHORT i, c, cnt;
  register SHORT m;
  SHORT b[64];

  cnt = c = 0;
  /* try to avoid work */
  if (GameCnt > Game50 + 3)
    {
      ClearMem(b,sizeof(b));
      for (i = GameCnt; i >= Game50; i--)
	{
	  m = GameList[i].gmove;
	  /* does piece exist on diff board? */
	  if (b[m & 0x3f])
	    {
	      /* does diffs cancel out, piece back? */
	      if ((b[m >> 8] += b[m & 0x3f]) == 0)
		--c;
	      b[m & 0x3f] = 0;
	    }
	  else
	    {
	      /* create diff */
	      ++c;
	      /* does diff cancel out another diff? */
	      if (!(b[m >> 8] -= (b[m & 0x3f] = board[m & 0x3f] +
				  (color[m & 0x3f] << 8))))
		--c;
	    }
	  /* if diff count is 0 we have a repetition */
	  if (c == 0)
	    if ((i ^ GameCnt) & 1)
	      cnt++;
	}
    }
  return cnt;
}

#endif // striaght 4pl70 repetition

int plyscore, globalscore;
int
pick (short int p1, short int p2)

/*
 * Find the best move in the tree between indexes p1 and p2. Swap the best
 * move into the p1 element.
 *
 */
{
  struct leaf *p, *q, *r, *k;
  int s0;
  struct leaf temp;

  k = p = &Tree[p1];
  q = &Tree[p2];
  s0 = p->score;
  for (r = p + 1; r <= q; r++)
    if (r->score != 9999 && (r->score) > s0) // this is the PL70 way!
//    if ((r->score) > s0) 
      {
	s0 = (r->score);
	p = r;
      }
  if (p != k)
    {
      temp = *p;
      *p = *k;
      *k = temp;
      return true;
    }
  return false;
}

#ifdef DEBUG
unsigned short trace[MAXDEPTH];
char traceline[256];
unsigned short tracelog[MAXDEPTH];
int tracen = 0;
int traceflag = 0;
int traceply = 0;
#endif
int bookflag = false;
int Jscore = 0;

static int TCcount, TCleft;
void
SelectMove (short int side, short int iop)
/*
 * Select a move by calling function search() at progressively deeper ply
 * until time is up or a mate or draw is reached. An alpha-beta window of
 * -Awindow to +Bwindow points is set around the score returned from the
 * previous iteration. If Sdepth != 0 then the program has correctly
 * predicted the opponents move and the search will start at a depth of
 * Sdepth+1 rather than a depth of 1.
 */
{
  static short int i, tempb, tempc, tempsf, tempst, xside, rpt;
  static short int alpha, beta, score;
  static struct GameRec *g;
  int earlyflag;

#ifndef CLEARHISTBETWEENMOVES // old way to handle hist table
  int cnt;
  ULONG *tmphistptr;
#endif

  char mystr[32];
  short InChkDummy;
  short start_score;
#ifdef DEBUG

if(debuglevel & (512|1024)){
	char b[32];
	short c1,c2,r1,r2;
tracen=0;
traceflag = false;
traceply = 0;
tracelog[0]=0;
while(true){
	/*printf("debug?");
	gets(b);*/
	if(b[0] == 'p')traceply = atoi(&b[1]);
	else
	if(b[0] == '\0')break;
	else{
		c1 = b[0] - 'a';
      		r1 = b[1] - '1';
      		c2 = b[2] - 'a';
      		r2 = b[3] - '1';
      		trace[++tracen] = (locn (r1, c1) << 8) | locn (r2, c2);
	}
	if(tracen == 0 && traceply >0)traceflag = true;
	}
	
}
#endif

//  InitializeStats(); // MY FIX FOR UNDO PROBLEMS!!! TMP!!!

if (!SupervisorMode)
 SetPointer(wG,myPointer,PTRHEIGHT,0x10L,0L,0L);
got_20000 = 0;
if (iop != 2)
 {
  RealThink = 1;
  if (!GetEntryDone)
   {
    Global_Message.myData = 1L;
    Forbid();
    PutMsg(InThreadPort,(struct Message *)&Global_Message);
    Permit();
    GetEntryDone = 1;
   }
 }
else
 RealThink = 0;
start_again:
  flag.timeout = false;
  flag.back = flag.musttimeout = false;
  INCscore = 0; // new from 4pl70, do I want this?
  xside = side ^ 1;
  recycle = (GameCnt % rehash) - rehash;
  /* if background mode set to infinite */
  if (iop == 2)
    {
      Sdepth2 = 0;
      (void)SetTaskPri((struct Task *)myproc,0);
      OrigResponse = ResponseTime = 9999999;
#ifdef QUIETBACKGROUND
      background = true;
#endif /* QUIETBACKGROUND */
    }
  else
    {
      player = side;
      if (TCflag)
	{
	  TCcount = 0;
#ifdef QUIETBACKGROUND
	  background = false;
#endif /* QUIETBACKGROUND */
	  if (TimeControl.moves[side] < 1)
	    TimeControl.moves[side] = 1;
	  /* special case time per move specified */
	  if (flag.onemove)
	    {
	      OrigResponse = ResponseTime = TimeControl.clock[side] - 100;
	      TCleft = 0;
	    }
	  else
	    {
	      /* calculate avg time per move remaining */
	      TimeControl.clock[side] += TCadd;

	      ResponseTime = (TimeControl.clock[side]) / (((TimeControl.moves[side]) * 2) + 1);
	      TCleft = (int)ResponseTime / 3;
	      ResponseTime += TCadd/2;
	      if (TimeControl.moves[side] < 5)
		TCcount = MAXTCCOUNTX - 1;
	    }
	  if (ResponseTime < 101)
	    {
	      ResponseTime = 100;
	      TCcount = MAXTCCOUNTX;
	    }
	  else if (ResponseTime < 200)
	    {
	      TCcount = MAXTCCOUNTX - 1;
	    }
          OrigResponse = ResponseTime;
          if ((TimeControl.moves[side] > 9))
           ResponseTime += 51;
//           ResponseTime = ResponseTime + (ResponseTime/4); // ADDED TO 2.50 to make clock better
	}
      else
       {
#ifdef QUIETBACKGROUND
	  background = false;
#endif /* QUIETBACKGROUND */
	OrigResponse = ResponseTime = MaxResponseTime;
       }
      if (TCleft)
	{
	  TCcount = ((int)((TimeControl.clock[side] - ResponseTime)) / 2) / TCleft;
	  if (TCcount > MAXTCCOUNTX)
	    TCcount = 0;
	  else
	    TCcount = MAXTCCOUNTX - TCcount;
	}
      else
	TCcount = MAXTCCOUNTX;
    }
  if (MoveNowOK)
   {
    thinking2 = 1; /* allow move now menu item to work */
   }
  else
   {
    thinking2 = 0; /* do not allow move now menu item to work */
   }
#ifndef OLD_LOOKAHEAD // this is faster for predicted moves
  if (Sdepth > 0) // guessed correct move!
   {
     if (TCflag)
       time0 = time(0L);
#ifdef QUIETBACKGROUND
    if (!background)
#endif /* QUIETBACKGROUND */
     SearchStartStuff (side);
    trying_again = 0;
    if ((GameCnt>2)&&(TCflag)&&(global_tmp_score >= (previous_score-50))&&(Sdepth >= GlobalTgtDepth)
          &&(global_tmp_score >= (GameList[GameCnt-1].score - 50)))
     {
      if (Sdepth >= (GameList[GameCnt-1].depth))
       flag.timeout = true;
      goto ForceTheMove2;
     }
    if ((TCflag)||(backsrchaborted))
     {
      goto ForceTheMove2; // for now use 2, it was ForceTheMove before
     }
    else
     {
      goto ForceTheMove2;
     }
   }
#endif
  ExtraTime = 0;
  ExaminePosition ();
//  score = ScorePosition (side);
  stage= -1; /* Force init in UpdateWeights() */
  start_score= Tscore[0]= Tscore[1]= score=
    evaluate (side, 1, 1, 0, -9999, 9999, 0, &InChkDummy);
  start_stage= stage;
#ifdef QUIETBACKGROUND
  if (!background)
#endif /* QUIETBACKGROUND */
    ShowSidetoMove ();
#ifdef notdef
  if (TCflag && TCcount < MAXTCCOUNT)
    if (score < SCORETIME)
      {
	ExtraTime += TCleft;
	TCcount++;
      }
#endif

#ifdef QUIETBACKGROUND
  if (!background)
#endif /* QUIETBACKGROUND */
    SearchStartStuff (side);

#ifdef HISTORY
#ifndef CLEARHISTBETWEENMOVES
// keep hist info between moves, just shift it all over one bit (depth)
tmphistptr = (ULONG *)history;
for(cnt=0;cnt<(32768/4);cnt++)
 {
  tmphistptr[cnt] = ((tmphistptr[cnt] >> 1) & 0x7f7f7f7f);
 }
#else // clear history between moves
  ClearMem(history,sizeof (history));
#endif // clear history between moves
#endif // HISTORY

  FROMsquare = TOsquare = -1;
  PV = 0;
  if (iop == 1)
    hint = 0;
#ifndef AMIGA
  for (i = 0; i < MAXDEPTH; i++)
   {
    PrVar[i] = killr0[i] = killr1[i] = killr2[i] = killr3[i] = 0;
   }
#else
  ClearMem(PrVar,MAXDEPTH*sizeof(PrVar[0]));
  ClearMem(killr0,MAXDEPTH*sizeof(killr0[0]));
  ClearMem(killr1,MAXDEPTH*sizeof(killr1[0]));
  ClearMem(killr2,MAXDEPTH*sizeof(killr2[0]));
  ClearMem(killr3,MAXDEPTH*sizeof(killr3[0]));
#endif
  /* set initial window for search */
  alpha = score - ((computer == black) ? BAwindow : WAwindow);
  beta = score + ((computer == black) ? BBwindow : WBwindow);
  rpt = 0;
  TrPnt[1] = 0;
  root = &Tree[0];
  MoveList (side, 1);
#ifdef BEFORE4PL70
if(TrPnt[2]-TrPnt[1] == 0){
    /* if no moves and not in check then draw */
  if (!(SqAtakd3 (PieceList[side][0], xside)))
    {
      root->flags |= draw;
      DRAW = CP[87];            /* No moves */
    } else {
#if !defined CLIENT
	flag.quit = 
#endif
	flag.mate = true;
	root->score = -9999;
	}
	if(iop !=2){
	OutputMove(mystr);
	}
    RealThink = 0;
    ClearPointer(wG);
    return;
	}
#endif // before 4pl70
  for (i = TrPnt[1]; i < TrPnt[2]; i++) pick (i, TrPnt[2] - 1);
  /* can I get a book move? */
  if ((flag.regularstart && Book))
    {
      flag.timeout = bookflag = OpeningBook (&hint, side);
      if (TCflag)
       {
	ResponseTime += ResponseTime;
        OrigResponse = ResponseTime;
       }
    }
#ifdef SPEED_PRECALC
  if ((!flag.timeout)&&(ThinkAheadWorked))
   {
    flag.timeout = DoPreCalc(&hint,side);
   }
#endif
  /* zero stats for hash table */
#ifdef ZEROALLBETWEENPLY
#ifdef OLDTTABLE
  if (!bookflag)
   {
    ZeroTTable();
    EADD = EGET = 0;
   }
#endif
#endif
  reminus = replus = 0;
  GenCnt = NodeCnt = ETnodes = EvalNodes = HashCnt = FHashAdd = HashAdd = FHashCnt = THashCol = HashCol = 0;
  globalscore = plyscore = score;
  zwndw = 20;
  Jscore = trying_again = global_tmp_score = previous_score = 0;
#include "debug4.h"
  /********************* main loop ********************************/
    Sdepth = (MaxSearchDepth<(MINDEPTH-1))?MaxSearchDepth:(MINDEPTH-1);
/*printf("\n\n");*/
ForceTheMove:
  while (!flag.timeout)
    {
/*printf("time0 = %d et = %d SDepth = %d GameCnt = %d\n",time0, et,Sdepth,GameCnt);*/
/*printf("ThinkAheadWorked = %d  ThinkAheadDepth = %d\n",ThinkAheadWorked,ThinkAheadDepth);*/
      /* go down a level at a time */
      Sdepth++;
#if defined NULLMOVE || defined DEEPNULL
      null = 0;
      PVari = 1;
#endif
//      DepthBeyond = Sdepth + ((Sdepth == 1) ? 7 : 11);
      DepthBeyond = Sdepth +
        ((Sdepth == 1) ? FBEYOND : flag.threat ? SBEYOND: TBEYOND);
      no_null= (emtl[xside] == 0 || emtl[side] == 0);

#if !defined CHESSTOOL && !defined XBOARD
#ifdef QUIETBACKGROUND
      if (!background)
#endif /* QUIETBACKGROUND */
	ShowDepth (' ');
#endif
      root->score= Tscore[0]= Tscore[1]= start_score;
      /* search at this level returns score of PV */
//      score = search (side, 1, Sdepth, alpha, beta, PrVar, &rpt, QBLOCK);
      score = search (side, 1, Sdepth, 0, alpha, beta, PrVar, &rpt, QBLOCK, false);
      /* save PV as killer */
      for (i = 1; i <= Sdepth; i++)
	killr0[i] = PrVar[i];

      /* low search failure re-search with (-inf,score) limits  */
      if (score < alpha)
	{
#if !defined CHESSTOOL && !defined XBOARD
	  reminus++;
#ifdef QUIETBACKGROUND
	  if (!background)
#endif /* QUIETBACKGROUND */
	    ShowDepth ('-');
#endif
	  if (TCflag && TCcount < MAXTCCOUNTR)
	    {
	      TCcount = MAXTCCOUNTR - 1;
	      ExtraTime += (8 * TCleft);
	    }
// root->score commented out on 4pl71 FIX!!!
          /*root->score= */Tscore[0]= Tscore[1]= start_score;
	  score = search (side, 1, Sdepth, 0, -9999, 9999, PrVar, &rpt,QBLOCK,false);
	}
      /* high search failure re-search with (score, +inf) limits */
      else if (score > beta && !(root->flags & exact))
	{
#if !defined CHESSTOOL && !defined XBOARD
	  replus++;
#ifdef QUIETBACKGROUND
	  if (!background)
#endif /* QUIETBACKGROUND */
	    ShowDepth ('+');
#endif
// root->score commented out on 4pl71 fix
          /*root->score=*/ Tscore[0]= Tscore[1]= start_score;
	  score = search (side, 1, Sdepth, 0, -9999, 9999, PrVar, &rpt,QBLOCK,false);
	}
      /**************** out of search ********************************************/
ForceTheMove2:
      if ((flag.timeout)||(flag.musttimeout)||(flag.back))
       earlyflag = true;
      else
       earlyflag = false;
      if (flag.musttimeout || Sdepth >= MaxSearchDepth)
       {
	flag.timeout = true;
       }
      else if (TCflag && (Sdepth > (MINDEPTH - 1)) && (TCcount < MAXTCCOUNTR))
	{
	  if (killr0[1] != PrVar[1] /* || Killr0[2] != PrVar[2] */ )
	    {
	      TCcount++;
	      ExtraTime += TCleft;
	    }
	  if ((abs (score - globalscore) / Sdepth) > ZDELTA)
	    {
	      TCcount++;
	      ExtraTime += TCleft;
	    }
	}
      if (score > (Jscore - zwndw) && score > (Tree[1].score + 250)) ExtraTime = 0;
/*printf("sdepth = %d mindepth = %d TCflag = %d \n4*et = %d respt = %d extra = %d\n",Sdepth,MINDEPTH,TCflag,4*et,ResponseTime,ExtraTime);*/
// || rpt > 1 added with 4pl71
      if (root->flags & exact || rpt > 1) flag.timeout = true;
      /*else if (Tree[1].score < -9000) flag.timeout = true;*/
      else if (!(Sdepth < MINDEPTH) && TCflag && ((4 * et) > (2*ResponseTime + ExtraTime))) flag.timeout = true;
      /************************ time control ***********************************/

      /* save PV as killer */
      for (i = 1; i <= Sdepth + 1; i++) killr0[i] = PrVar[i];
      if (!flag.timeout) start_score = Tscore[0] = score;
      /* if (!flag.timeout) */
//      for (i = TrPnt[1]+1; i < TrPnt[2]; i++) if (!pick (i, TrPnt[2] - 1)) break;
      /* if done or nothing good to look at quit */
      if ((root->flags & exact) || (score < -9000)) flag.timeout = true;
      /* find the next best move put below root */
#include "debug13.h"
      if (!flag.timeout)
	{
	  /* */
#if !defined NODYNALPHA
	  Jscore = (plyscore + score) >> 1;
#endif
	  zwndw = 20 + abs (Jscore / 12);
	  plyscore = score;
	  /* recompute search window */
	  beta = score + ((computer == black) ? BBwindow : WBwindow);
#if !defined NODYNALPHA
	  alpha = ((Jscore < score) ? Jscore : score) - ((computer == black) ? BAwindow : WAwindow) - zwndw;
#else
	  alpha = score - ((computer == black) ? BAwindow : WAwindow);
#endif
	}
#if !defined CHESSTOOL && !defined XBOARD
#ifdef QUIETBACKGROUND
      if (!background)
#endif /* QUIETBACKGROUND */
	ShowResults (score, PrVar, '.');
#ifdef DEBUG41
      debug41 (score, PrVar, '.');
#endif
#endif
#include "debug16.h"
#ifdef CHECKMOVERESULTS
      if ((score >= 11000)&&(!got_20000))
       {
        got_20000 = 1;
        Sdepth = 0;
        goto start_again;
       }
      if (((flag.timeout)&&((!PrVar[1])||(!PrVar[2]))&&(!(root->flags & exact))&&(iop != 2)&&(abs(score) < 9000)&&(abs(score)>25))) /* do not trust this move! */
       {
        if ((Sdepth > 2))
         {
          if ((earlyflag))
           {
            Sdepth--;
           }
          if (!trying_again)
           { /* this is first bogus move we have seen */
            ResponseTime = ResponseTime << 1;
            ExtraTime += 251;
           }
          else
           { /* this is not 1st bogus move we have seen */
            ExtraTime += 201;
           }
          trying_again = 1;
          flag.timeout = false;
          flag.back = false;
          flag.musttimeout = false;
         }
       }
      else if (trying_again) /* this move is trustworthy, to an extent */
       {
        if ((TCflag && ((4 * et) > (ResponseTime + ExtraTime - 251)))||(root->flags & exact)) 
         flag.timeout = true;
       }
#endif
      previous_score = score;
    } /* while !flag.timeout */
  /******************************* end of main loop ***********************************/
  /* background mode */
  if (iop == 2)
   {
    if (bookflag) Sdepth = 0;
    if (!flag.easy)
     {
      Sdepth2 = Sdepth;
      if (Sdepth2 > (GlobalTgtDepth+1))
       Sdepth2--;
#ifdef SPEED_PRECALC
      PreCalcedMove = (Tree[TrPnt[1]].f << 8) | (Tree[TrPnt[1]].t);
      PreCalcedHint = ((PrVar[1]) ? PrVar[2] : 0);
#endif
     }
    RealThink = 0;
    ClearPointer(wG);
    return;
   }
#include "debug4.h"
#ifdef PRE4PL70
  if (rpt >= 2)
    {
      root->flags |= draw;
      DRAW = CP[101];		/* Repetition */
    }
  else
    /* if no moves and not in check then draw */
#endif // PRE4pl70
   if ((score == -9999) && !(SqAtakd3 (PieceList[side][0], xside))) // was 9998
    {
      root->flags |= draw;
      DRAW = CP[87];		/* No moves */
    }
  else if (GameCnt == MAXMOVES)
    {
      root->flags |= draw;
      DRAW = CP[80];		/* Max Moves */
    }
  /* not in book so set hint to guessed move for other side */
  if (!bookflag)
   {
    hint = ((PrVar[1]) ? PrVar[2] : 0);
   }
  else if ((!Book)||(!flag.regularstart))
   bookflag = 0;

  algbr (root->f, root->t, (short) root->flags);
  /* if not mate or draw make move and output it */
  if (((score != -9999)  && (score != 9998) && (rpt <= 2)) || (root->flags & draw))
    {
      MakeMove (side, &Tree[0], &tempb, &tempc, &tempsf, &tempst, &INCscore);
#if !defined NOMATERIAL
      if (flag.material && !pmtl[black] && !pmtl[white] && (mtl[white] < (valueR + valueK)) && (mtl[black] < (valueR + valueK)))
	{
	  root->flags |= draw;
	  DRAW = CP[224];	/* No pieces */
	}
      else
#endif
      if (!PieceCnt[black] && !PieceCnt[white])
	{
	  root->flags |= draw;
	  DRAW = CP[88];	/* No pieces */
	}
    }
  else
    { root->score = score;	/* When mate, ignore distinctions! * --SMC */
    }

  g = &GameList[GameCnt];
  if (g->flags & capture && g->piece == king)
    {
      flag.mate = flag.illegal = true;
    }
  /* If Time Control get the elapsed time */
  if (TCflag)
    ElapsedTime (1);
  /* if mate set flag */
// this line added from 4pl71 code!
   if (rpt > 1) root->flags |= (draw | exact);

   if (score == -9999 || rpt > 1)
     mvstr[0][0] = mvstr[1][0] = mvstr[2][0] = mvstr[3][0] = mvstr[4][0] = '\0';
    /* if mate set flag */
  if ((score == -9999) || (score == 9998)) {flag.mate = true; 
#ifndef CLIENT
#ifndef AMIGA
	flag.quit = true;
#endif
#endif
	}
  OutputMove (mystr);
  /* if mate clear hint */
  if (flag.mate)
    hint = 0;
  /* if pawn move or capture or castle or promote zero repitition array */
  if ((board[root->t] == pawn) || (root->flags & (capture | cstlmask | promote)))
    {
      Game50 = GameCnt;
      ZeroRPT ();
    }
  /* add move to game list */
  g->score = score;
  g->nodes = NodeCnt;
  g->time = (et +50)/100;
  g->depth = Sdepth;
#include "debug40.h"
  /* update time comtrol info */
  if (TCflag)
    {
#if defined CHESSTOOL || defined XBOARD
      TimeControl.clock[side] -= (et + OperatorTime + 45);
      timecomp[compptr] = (et + OperatorTime + 45);
#else
      TimeControl.clock[side] -= (et + OperatorTime);
      timecomp[compptr] = (et + OperatorTime);
#endif
      /* finished our required moves - setup the next set */
      --TimeControl.moves[side];
    }
  /* check for end conditions */
  if ((root->flags & draw) /* && flag.bothsides */ )
#if !defined CLIENT
     flag.mate = true;
#else 
	;
#endif
  else if (GameCnt == MAXMOVES)
    {
      flag.mate = true;
    }
  /* out of move store, you loose */
  else
    /* switch to other side */
    player = xside;
  Sdepth = 0;
  RealThink = 0;
  ClearPointer(wG);
}

int
search (short int side,
	register short int ply,
	register short int depth,
	short ext,
	short int alpha,
	short int beta,
	short unsigned int *bstline,
	short int *rpt,
        short SAVEHT,
	int didnull)

/*
 * Perform an alpha-beta search to determine the score for the current board
 * position. If depth <= 0 only capturing moves, pawn promotions and
 * responses to check are generated and searched, otherwise all moves are
 * processed. The search depth is modified for check evasions, certain
 * re-captures and threats. Extensions may continue for up to 11 ply beyond
 * the nominal search depth.
 */


{
  register short j, pnt;
  short tempb, tempc, tempsf, tempst;
  short xside, pbst, score, rcnt, InChk;
  unsigned short mv, nxtline[MAXDEPTH];
  struct leaf *node, tmp;
  short best = -12000;
#ifdef DOIT_4PL68WAY // this is the 4pl68 way to extend search
  int max_time;
#endif
  short bestwidth = 0;
#if defined NULLMOVE || defined DEEPNULL
  short int PVsave;
  short int PVarisave;
  unsigned short verydeep=0xffff;
#endif
#ifdef DEBUG
  int xxxtmp;
  int tracetmp;
#endif
  short extdb= 0;
  short threat= 0;      /* tom@izf.tno.nl */
  short threat2= 0;     /* tom@izf.tno.nl */
  short do_pvs;

  NodeCnt++;
  /* look every ZNODE nodes for a timeout */
  if (!null)
   {
  if (NodeCnt > ETnodes )
    {
      ElapsedTime (2);
      if (flag.back)
	{
	  flag.back = false;
	  flag.timeout = true;
	  flag.musttimeout = false;
	}
      else if (TCflag || MaxResponseTime)
	{
	  if ((et >= (ResponseTime + ExtraTime)) && Sdepth > MINDEPTH && abs(best) < 10000)
	    {			/* try to extend to finish ply */
#define TRYEXTEND 1
#ifdef TRYEXTEND
	      if ((TCflag && TCcount < MAXTCCOUNTX)&&(GameCnt > 10))
		{
		  flag.musttimeout = true;
		  TCcount += 1;
		  ExtraTime += TCleft;
		}
	      else
		{
		  flag.timeout = true;
		  flag.musttimeout = false;
		}
#else
	      if ((TCflag && TCcount < MAXTCCOUNTX)&&(flag.easy))
		{
		  flag.musttimeout = true;
		  TCcount += 1;
		  ExtraTime += TCleft;
		}
	      else
		{
		  flag.timeout = true;
		  flag.musttimeout = false;
		}
#endif
	    }
	}
    }
  else if (!TCflag && flag.musttimeout && Sdepth > MINDEPTH)
    {
      flag.timeout = true;
      flag.musttimeout = false;
    }
   } // !null
  xside = side ^ 1;
  if (ply == 1) INCscore = 0; // TMP!! MY Fix for INCscore not init at ply 1
  /* slk is lone king indicator for either side */
  score = evaluate (side, ply, depth, ext, alpha, beta, INCscore, &InChk);

  /*
   * check for possible repitition if so call repitition - rpt is
   * repeat count
   */
  if (ProbeRPThash(side,hashkey))
    {
      *rpt = repetition ();
      if (*rpt == 1) score = -contempt;
// next line changed from *rpt > 2 to *rpt > 1 in 4pl71
      else if (*rpt > 1) {
          bstline[ply] = 0;
          return (-contempt);
        }
    }
  else
    *rpt = 0;

  /* score > 9000 its a draw or mate */
  if (score > 9000 /*|| root->flags & draw*/) // was commented out is back in with 4pl70
    {
      bstline[ply] = 0;
      return (score);
    }
  /* Do we need to add depth because of special conditions */
  /* if in check or pawn threat or in capture sequence search deeper */
  /*************************************** depth extensions ***********************************/
#ifdef OLDEXT
  if (depth > 0)
    {
      /* Allow opponent a chance to check again */
      if (InChk)
	depth = (depth < 2) ? 2 : depth;
      else if (PawnThreat[ply - 1] ||
	       (flag.rcptr && (score > alpha) &&
      (score < beta) && (ply > 2) && CptrFlag[ply - 1] && CptrFlag[ply - 2]))
	++depth;
    }
  else
    {
      if (score >= alpha &&
	  (InChk || PawnThreat[ply - 1] || (hung[side] > 1 /* && ply == Sdepth + 1*/)))
	depth = 1;
      else if (score <= beta &&
	       ((ply < Sdepth + 4) && (ply > 4) &&

		ChkFlag[ply - 2] && ChkFlag[ply - 4]))
	{
              depth = 1;
        }
    }
#else
 
#define DOTHREAT    (start_stage < THRSTAGE)
#define DOCHECK     (start_stage < CHECKSTAGE)
 
  Threat[ply]= 0;
  if (depth > 0)
    {
      /* Allow opponent a chance to check again */
      if (InChk) {
#ifdef DOIT_4PL68WAY // this is the 4pl68 way to extend search
          if (TCflag)
           max_time = ((OrigResponse<<2) + ExtraTime);
          else
           max_time = 99999999;
          if (et >= max_time)
           {
            if (flag.threat)
              depth= DOCHECK && (ply+depth<DepthBeyond-DEPTHMARGIN) ?
                depth+1: depth;
            else
              depth= (depth < 2) ? 2 : depth;
           }
          else
           depth++;
#else // this is the Kong Sian way, always extend check search
      // this way costs more time but may be better
          depth++;
#endif
      }
      else if ((ply>1 && PawnThreat[ply - 1] && ply+depth<DepthBeyond-DEPTHMARGIN) ||
               (flag.rcptr && ply>2 && CptrFlag[ply - 1] && CptrFlag[ply - 2] &&
               ((ply<Sdepth+2 && CptrFlag[ply-1]==CptrFlag[ply-2]) ||
// the next line is a fix from Kong Sian, old way may be better
	        (score > root->score - valueP/4 && score < root->score + valueP/4))) // FIX by Kong SIAN
//               (score > alpha && score < beta))) // OLD 4PL68 way
               )
          ++depth;
    }
  else
    { 
      int tripple_check = 0;
      if (score >= alpha &&
          (InChk || (ply>1 && PawnThreat[ply - 1] && depth<DepthBeyond-4)
          || (hung[side] > 1 /*&& !ext*/))) { // fix from Kong Sian
        threat2= 1;
        ext++;
        depth= 1;
      }
      else if (score <= beta &&
               ((ply<Sdepth+4 && ply>4 &&
                ChkFlag[ply-2] && ChkFlag[ply-4] &&
                (ChkFlag[ply-2] != ChkFlag[ply-4] ||
                (flag.threat && DOTHREAT && QueenCheck[ply-2])))
          ||
                (flag.threat && ply<DepthBeyond-DEPTHMARGIN && ply>6
                && ChkFlag[ply-2] && ChkFlag[ply-4] && ChkFlag[ply-6]
                &&  (tripple_check=1)
                && ((ply < Sdepth+4 ?
                  (ChkFlag[ply-2] != ChkFlag[ply-4] || ChkFlag[ply-2] !=
ChkFlag [ply-6])
                  : (ChkFlag[ply-2] != ChkFlag[ply-4] &&
                     ChkFlag[ply-2] != ChkFlag[ply-6] &&
                     ChkFlag[ply-4] != ChkFlag[ply-6]))
                || (DOTHREAT && QueenCheck[ply-2]
                && QueenCheck[ply-4] && QueenCheck[ply-6]
                && QueenCheck[ply-2] != QueenCheck[ply-6]))
                ))) {
          if (tripple_check && DepthBeyond < Sdepth+13+DEPTHMARGIN)
            {
              extdb += 2;
              DepthBeyond += 2;
            }
          depth= 1;
          ext++;
          Threat[ply]= threat= 1;
        }
    }    
  ThreatSave[ply]= ((ply>1 && ThreatSave[ply-1]) || threat);
#endif
  /*******************************************************************************************/
  /* try the local transition table if it's there */
  if (ply>1) TrPnt[ply+1]= TrPnt[ply]; // TMP!! My Fix for move gen

  /*
   * if more then DepthBeyond ply past goal depth or at goal depth and
   * score > beta quit - means we are out of the window
   */
  if (ply > DepthBeyond || (depth < 1 && score > beta))
    {
      return (score);
    }
#if defined ttblsz
	  if ( flag.hash && ply > 1) // fix from Kong Sian
	    {
		if (ProbeTTable (side, depth, ply, &alpha, &beta, &score) == true)
		  {
		      if (beta == -20000 || alpha > beta)
			{
			    bstline[ply] = PV;
			    bstline[ply + 1] = 0;
                            /*
                             * make sure the move is in the
                             * MoveList
                             */
                            if (ply == 1)
                              {   
                                  struct leaf tmp;
				  register int spnt;
                                  for (spnt = TrPnt[ply]; spnt < TrPnt[ply + 1]; spnt++)
                                    {
                                        if (((Tree[spnt].f << 8) | Tree[spnt].t) == PV)
                                          {
                                              if (ply == 1 && Tree[spnt].score == DONTUSE) {bstline[1] = 0; break;}
                                              Tree[spnt].score = (beta == -20000) ? score : alpha;
                                              if (abs (score) > 9000) Tree[spnt].flags |= exact;
                                              if (spnt != TrPnt[ply])
                                                {
                                                    tmp = Tree[TrPnt[ply]];
                                                    Tree[TrPnt[ply]] = Tree[spnt];
                                                    Tree[spnt] = tmp;
                                                }
#include "debug64.h"
                                              if (beta == -20000) return (score);
                                              else return (alpha);
                                          }
                                    }
                              } else {
				register int i = TrPnt[ply];
				Tree[i].t = PV & 0x3f;
				Tree[i].f = PV>>8;
				Tree[i].flags = 0;
				Tree[i].reply = 0;
				Tree[i].score = (beta == -20000) ? score : alpha; 
				TrPnt[ply+1] = i+1;
                                if (abs (score) > 9000) Tree[i].flags |= exact; 
				if (beta == -20000) return (score); 
                                    else return (alpha); 
			      }

			}
		  }
#ifdef HASHFILE
		/* ok try the transition file if its there */
		else if (hashfile && (depth > HashDepth) && (GameCnt < HashMoveLimit)
			 && (ProbeFTable (side, depth, ply, &alpha, &beta, &score) == true))
		  {
		      if (beta == -20000 || alpha > beta)
			{
			    bstline[ply] = PV;
			    bstline[ply + 1] = 0;
			    /*
			     * make sure the move is in the
			     * MoveList
			     */
			    if (ply == 1)
			      {
				  struct leaf tmp;
				  register int spnt;
				  for (spnt = TrPnt[ply]; spnt < TrPnt[ply + 1]; spnt++)
				    {
					if (((Tree[spnt].f << 8) | Tree[spnt].t) == PV)
					  {
      					      if (ply == 1 && Tree[spnt].score == DONTUSE) {bstline[1] = 0; break;}
					      Tree[spnt].score = (beta == -20000) ? score : alpha;
					      if (abs (score) > 9000) Tree[spnt].flags |= exact;
					      if (spnt != TrPnt[ply])
						{
						    tmp = Tree[TrPnt[ply]];
						    Tree[TrPnt[ply]] = Tree[spnt];
						    Tree[spnt] = tmp;
						}
					      PutInTTable (side, score, depth, ply, /*alpha,*/ beta, PV);
#include "debug10.h"
					      if (beta == -20000) return (score);
					      else return (alpha);
					  }
				    }
			       } else {
                                register int i = TrPnt[ply];
                                Tree[i].t = PV & 0x3f;
                                Tree[i].f = PV>>8;
                                Tree[i].score = (beta == -20000) ? score : alpha;
				TrPnt[ply+1] = i+1;
                                if (abs (score) > 9000) Tree[i].flags |= exact;
                                if (beta == -20000) return (score);
                                    else return (alpha);
                              }
 

			}
		  }
#endif // HASHFILE
     }
#endif /* ttblsz */
      if (depth > 0 || (background && ply < Sdepth + 2)) {if(ply >1)
#ifdef LEGAL
		VMoveList (side, ply);}
#else
		MoveList (side, ply);}
#endif
    else
      {
#ifdef LEGAL
		VCaptureList (side, ply);
#else
		CaptureList (side, ply);
#endif
	if(!SAVEHT)SAVEHT = ply;
      }



  /* no moves return what we have */

  /*
   * normally a search will continue til past goal and no more capture
   * moves exist
   */
  /* unless it hits DepthBeyond */
  if (TrPnt[ply] == TrPnt[ply + 1]) { if(!InChk) return (score); else return (-10001+ply); }



  /* if not at goal set best = -inf else current score */
	 best = (depth >0) ? -12000:score;
#ifdef NULLMOVE
 
  PVarisave = PVari;
  if (!null &&                         /* no previous null-move */
      !PVari &&                        /* no null-move during the PV */
      (ply > 1) && // was 2 changed by Kong Sian
      (ply <= Sdepth) &&                       /* not at ply 1 */
      (depth > 2) && // changed by Kong Sian   /* not during the quienscesearch */
      !InChk &&                        /* no check */
      ((mtl[side] + mtl[xside]) > NULLMOVELIM))
    /* enough material such that zugzwang is unlike but who knows which value
       is suitable? */
    {
      
      /* ok, we make a null move, i.e.  this means we have nothing to do
 	 but we have to keep the some arrays up to date otherwise gnuchess
 	 gets confused.  Maybe somebody knows exactly which informations are
	 important and which not.

	 Another idea is that we try the null-move first and generate the
	 moves later.  This may save time but we have to take care that
	 PV and other variables contain the right value so that the move
	 ordering works right.
	 */
      register struct GameRec *g;
      
      nxtline[ply + 1] = 0;
      CptrFlag[ply] = 0;
      PawnThreat[ply] = 0;
      Tscore[ply] = score;
      PVsave = PV;
      PV = 0;
      null = 1;
      g = &GameList[++GameCnt];
      g->hashkey = hashkey;
      g->hashbd = hashbd;
      epsquare = -1;
      TOsquare = -1;
      g->Game50 = Game50;
#ifdef LONGINTS
      g->gmove = 0xffffffff;
#else
      g->gmove = 0xffff;
#endif
      g->flags = 0;
      g->piece = 0;
      g->color = neutral;
      
//      best = -search (xside, ply + 1, false, depth - 2, -beta - 1, -beta, nxtline, &rcnt,false,false);
//this next line a fix from Kong Sian replaces above line
      best = -search (xside, ply + 1, false, depth - 2, -beta, -beta, nxtline, &rcnt,false,false);
      null = 0;
      PV = PVsave;
      GameCnt--;
      if (best < alpha) best = -12000;
      else if (best > 0 && best > beta) return (best);
      else
 	best = -12000;
    }
#else 
#ifdef DEEPNULL

  /*
   * The deepnull algoritm is taken from the article by
   * Christian Donninger in ICCA journal Vol 16, No. 3.  TomV
   */
  PVarisave = PVari;
  if ((myflagdeepnull ? !didnull : !null) &&	/* no previous null-move */
    //  !flag.nonull &&
      !no_null &&
      !PVari &&			/* no null-move during the PV */
      (ply > (myflagdeepnull ? 1: 2)) &&		/* not at ply 1 */
      (score > alpha - 150 || !myflagdeepnull) &&
      (ply <= Sdepth || myflagdeepnull) &&
      (depth > (myflagdeepnull ? (verydeep ? 1: 2): 3)) &&
      !InChk &&			/* no check */
      /* enough material such that zugzwang is unlikely: */
      ! (emtl[xside] == 0 || emtl[side] <= valueB))
    {

      /* ok, we make a null move, i.e.  this means we have nothing to do
 	 but we have to keep the some arrays up to date otherwise gnuchess
 	 gets confused.

	 Another idea is that we try the null-move first and generate the
	 moves later.  This may save time but we have to take care that
	 PV and other variables contain the right value so that the move
	 ordering works right.
	 */
      CptrFlag[ply] = 0;
      PawnThreat[ply] = 0;
      Tscore[ply] = score;
      PVsave = PV;
      PV = 0;
      epsquare = -1;
      TOsquare = -1;
      if (!null)
        null= ply;
      if (myflagdeepnull) {
        int nmscore = -search (xside, ply + 1, (depth >= 3 ? depth - 3: 0), ext, -beta, -alpha, nxtline, &rcnt,false,1);
        if (ply == null)
          null = 0;
        PV = PVsave;
	if (nmscore > beta) {
	  DepthBeyond-= extdb;
	  return nmscore;
        }
	if (nmscore > alpha)
	  best= nmscore;
        if (depth <= 3 && ply < DepthBeyond-depth-4
            && score >= beta && nmscore < score - 350)
              depth++;
      } else {
// change to -beta,-beta from K SIAN
        best = -search (xside, ply + 1, depth - 2, ext, -beta - 1, -beta, nxtline, &rcnt, false, 1);
//        best = -search (xside, ply + 1, depth - 2, ext, -beta, -beta, nxtline, &rcnt, false, 1);
        null = 0;
        PV = PVsave;
        if (best < alpha) best = -12000;
        else if (best > beta) {
	   DepthBeyond-= extdb;
           return (best);
        }  else best = -12000;
      }
    }
#endif //deepnull
#endif // nullmove
  /* if best so far is better than alpha set alpha to best */
	if(best>alpha)alpha=best;
  /********************** main loop ************************************************************************/
  /* look at each move until no more or beta cutoff */
   do_pvs = 0;
//   for (pnt = pbst = TrPnt[ply]; pnt < TrPnt[ply + 1] &&
//    (best <= beta || (ply == 1 && best > 9000)); pnt++) /* Find best mate, TomV TMP!!*/
  for (pnt = pbst = TrPnt[ply]; pnt < TrPnt[ply + 1] && best <= beta; pnt++)
    {
      /* find the most interesting looking of the remaining moves */
      if (ply > 1)
	pick (pnt, TrPnt[ply + 1] - 1);
#if defined NULLMOVE || defined DEEPNULL
      PVari = PVarisave && (pnt == pbst/*TrPnt[ply]*/);  /* Is this the PV? */
#endif

      node = &Tree[pnt];
      /* is this a forbidden move */
      if (pnt == pbst)
       do_pvs = myflagpvs && PVari; // this line a fix from Kong Sian, replaced line below
//        do_pvs= myflagpvs && !null && (PrVar[ply] == ((node->f << 8) | node->t));
      if (ply == 1 && node->score == DONTUSE)
	continue;
#ifdef DEBUG
	if(debuglevel & (512 | 1024)){
		if(!tracen)traceflag = ((ply >traceply)?false:true);
	 	else
		if(ply <= tracen && (ply ==1 || traceflag))
			{ 
			if(trace[ply] == (Tree[pnt].t |(Tree[pnt].f<<8))) traceflag = true; else traceflag = false; }
		tracelog[ply] = (Tree[pnt].t |(Tree[pnt].f<<8));
		tracelog[ply+1] = 0;
}
#endif
      nxtline[ply + 1] = 0;

#if !defined CHESSTOOL && !defined XBOARD
      /* if at top level */
      if (ply == 1)
	{			/* at the top update search status */
	  if (flag.post)
#ifdef QUIETBACKGROUND
	    if (!background)
#endif /* QUIETBACKGROUND */
	      ShowCurrentMove (pnt, node->f, node->t);
	}
#endif
	  /* make the move and go deeper */
	  MakeMove (side, node, &tempb, &tempc, &tempsf, &tempst, &INCscore);
// FIX from Kong Sian for cpt flag
//	  CptrFlag[ply] = (node->flags & capture); // OLD way
	  CptrFlag[ply] = (node->flags & capture ? TOsquare+1 : 0); // K. Sian way
	  PawnThreat[ply] = (node->flags & pwnthrt);
	  Tscore[ply] = node->score;
	  PV = node->reply;
#ifdef DEBUG
	  xxxtmp = node->score;
	  tracetmp = traceflag;
#endif
	  if (do_pvs) {
            if (pbst == pnt) {
              node->score= -search (xside, ply + 1,
                                 depth > 0 ? depth - 1 : 0, ext,
                                 -beta, -alpha,
                                 nxtline, &rcnt,SAVEHT, 0);
            } else {
              node->score= -search(xside, ply + 1,
                              depth > 0 ? depth - 1 : 0, ext,
                              -alpha-1, -alpha,
// below line is a fix from Kong Sian, replaces above line
//                              -alpha, -alpha,
                              nxtline, &rcnt,SAVEHT, 0);
// next if stmt improved by Kong Sian after 4pl68
              if (/*node->score >= best && */alpha <= node->score
              /*&& node->score <= beta*/)
                  node->score = -search (xside, ply + 1,
                                 depth > 0 ? depth - 1 : 0, ext,
                                 -beta, /*-node->score*/-alpha,
                                 nxtline, &rcnt,SAVEHT, 0);
            }
          } else

	  node->score = -search (xside, ply + 1,
				 (depth > 0) ? depth - 1 : 0, ext,
				 -beta, -alpha,
				 nxtline, &rcnt, SAVEHT, false);
	  node->width = (ply % 2 == 1) ? (TrPnt[ply + 2] - TrPnt[ply + 1]) : 0;
	  if (abs (node->score) > 9000) node->flags |= exact;
          else if (rcnt == 1) node->score = 0;
	  if(node->score == (9999-ply) && !ChkFlag[ply] ) {node->flags |= draw;
	      node->score = (-contempt);}
#include "debug256.h"
	  if ((rcnt >= 2 || GameCnt - Game50 > 99 
/*|| (node->score == 9999 - ply && !ChkFlag[ply])*/
	      ))
	    {
	      node->flags |= (draw | exact);
	      DRAW = CP[58];	/* Draw */
	      node->score = -contempt;
	    }
	  node->reply = nxtline[ply + 1];
	  /* reset to try next move */
	  UnmakeMove (side, node, &tempb, &tempc, &tempsf, &tempst);
      /* if best move so far */
      if (!flag.timeout && ((node->score > best) || ((node->score == best) && (node->width > bestwidth))))
	{
	  /*
	   * all things being equal pick the denser part of the
	   * tree
	   */
	  bestwidth = node->width;

	  /*
	   * if not at goal depth and better than alpha and not
	   * an exact score increment by depth
	   */
	  if (depth > 0 && node->score > alpha && !(node->flags & exact))
	    node->score += depth;
	  best = node->score;
	  pbst = pnt;
	  if (best > alpha) { alpha = best; }
	  /* update best line */
	  for (j = ply + 1; nxtline[j] > 0; j++) bstline[j] = nxtline[j];
	  bstline[j] = 0;
	  bstline[ply] = (node->f << 8) | node->t;
	  /* if at the top */
	  if (ply == 1)
	    {
	      /*
	       * if its better than the root score make it
	       * the root
	       */
// next line has || pnt > 0 added in pl71
	      if ((best > root->score) || ((best == root->score) && (bestwidth > 
              root->width)) || pnt > 0)
		{
		  tmp = Tree[pnt];
		  for (j = pnt - 1; j >= 0; j--) Tree[j + 1] = Tree[j];
		  Tree[0] = tmp;
		  pbst = 0;
		}
              if (Sdepth > 2)
               global_tmp_score = best;
#if !defined CHESSTOOL && !defined XBOARD
#ifdef QUIETBACKGROUND
	      if (!background)
#endif /* QUIETBACKGROUND */
		if (Sdepth > 2)
		  if (best > beta)
		    {
		      ShowResults (best, bstline, '+');
#ifdef DEBUG41
		      debug41 (best, bstline, '+');
#endif
		    }
		  else if (best < alpha)
		    {
		      ShowResults (best, bstline, '-');
#ifdef DEBUG41
		      debug41 (best, bstline, '-');
#endif
		    }
		  else
                   {
		    ShowResults (best, bstline, '&');
                   }
#ifdef DEBUG41
	      debug41 (best, bstline, '&');
#endif
#else
	   if ((!background) && (Sdepth >2) && (best < alpha)){
	        TCcount = 0;
		ExtraTime += 20*TCleft;
	   }
#endif
	    }
	}
      if (flag.timeout)
	{
          DepthBeyond-= extdb;
#if defined NULLMOVE || defined DEEPNULL
  PVari = PVarisave;
#endif
	  return (Tscore[ply - 1]);
	}
    }

  /******************************************************************************************/
// this best == -10000 line added in 4pl71
  if (best == -10000+ply) bstline[ply] = 0;
  node = &Tree[pbst];
  mv = (node->f << 8) | node->t;
#if defined NULLMOVE || defined DEEPNULL
  PVari = PVarisave;
#endif
#ifdef DEBUG
#include "debug512.h"
#endif

  /*
   * we have a move so put it in local table - if it's already there
   * done else if not there or needs to be updated also put it in
   * hashfile
   */
#if ttblsz
  if (flag.hash && !SAVEHT  /*&& ply <= Sdepth*/ && *rpt == 0 && best == alpha)
    {
      PutInTTable (side, best, depth, SAVEHT?SAVEHT:ply, /*alpha,*/ beta, mv);
    }
#endif /* ttblsz */

  if (depth > 0)
    {
#ifdef HISTORY
      j = (node->f << 8) | node->t; // was 6 should be 8
      if (side == black)
	j |= 0x4000;
// BELOW IS NEWEST WAY TO UPDATE HISTORY TABLE, AFTER 4PL69
#ifndef CLEARHISTBETWEENMOVES
      if (history[j] < HISTORYLIM)
        history[j] |= (unsigned short) 1 << depth;
#else
// below is original way
      if (history[j] < HISTORYLIM)
	history[j] |= (unsigned short) 1<<depth;
// here is a Kong Sian fix from after 4pl68
//      if (history[j] < ((unsigned short) 1 << depth))
//        history[j] = ((unsigned short) 1 << depth);
#endif

#endif
      if (node->t != (short)(GameList[GameCnt].gmove & 0xFF))
	if (best <= beta)
	  killr3[ply] = mv;
	else if (mv != killr1[ply])
	  {
	    killr2[ply] = killr1[ply];
	    killr1[ply] = mv;
	  }
      killr0[ply] = ((best > 9000) ? mv : 0);
    }

  DepthBeyond -= extdb; // this LINE added after 4pl68 by Kong Sian

  return (best);
}



int
castle (short side, short kf, short kt, short iop)

/* Make or Unmake a castling move. */

{
  register short rf, rt, t0, xside;

  xside = side ^ 1;
  if (kt > kf)
    {
      rf = kf + 3;
      rt = kt - 1;
    }
  else
    {
      rf = kf - 4;
      rt = kt + 1;
    }
  if (iop == 0)
    {
      if (kf != kingP[side] ||
	  board[kf] != king ||
	  board[rf] != rook ||
	  color[kf] != side ||
	  color[rf] != side ||
	  Mvboard[kf] != 0 ||
	  Mvboard[rf] != 0 ||
	  color[kt] != neutral ||
	  color[rt] != neutral ||
	  color[kt - 1] != neutral ||
	  SqAtakd3 (kf, xside) ||
	  SqAtakd3 (kt, xside) ||
	  SqAtakd3 (rt, xside))
	return (false);
    }
  else
    {
      if (iop == 1)
	{
          Castled[side] = 1;
	  castld[side] = true;
	  Mvboard[kf]++;
	  Mvboard[rf]++;
	}
      else
	{
          Castled[side] = 0;
	  castld[side] = false;
	  Mvboard[kf]--;
	  Mvboard[rf]--;
	  t0 = kt;
	  kt = kf;
	  kf = t0;
	  t0 = rt;
	  rt = rf;
	  rf = t0;
	}
      board[kt] = king;
      color[rt] = color[kt] = side;
      Pindex[kt] = 0;
      board[kf] = no_piece;
      color[rf] = color[kf] = neutral;
      board[rt] = rook;
      Pindex[rt] = Pindex[rf];
      board[rf] = no_piece;
      PieceList[side][Pindex[kt]] = kt;
      PieceList[side][Pindex[rt]] = rt;
      UpdateHashbd (side, king, kf, kt);
      UpdateHashbd (side, rook, rf, rt);
    }
  return (true);
}


void
EnPassant (short xside, short f, short t, short iop)

/*
 * Make or unmake an en passant move.
 */

{
  register short l;

  l = t + ((t > f) ? -8 : 8);
  if (iop == 1)
    {
      myEnPassant[xside] = 1;
      board[l] = no_piece;
      color[l] = neutral;
    }
  else
    {
      myEnPassant[xside] = 0;
      board[l] = pawn;
      color[l] = xside;
    }
  InitializeStats ();
}

void
UpdatePieceList (SHORT side, SHORT sq, SHORT iop,short piece)

/*
 * Update the PieceList and Pindex arrays when a piece is captured or when a
 * capture is unmade.
 */

{
  register SHORT i;

 if( iop == 1 ) {
   i = Pindex[ sq ];
   if( i < PieceCnt[ side ] ) {
     PieceList[ side ][ i ] = PieceList[ side ][ PieceCnt[ side ] ];
     Pindex[ PieceList[ side ][ i ] ] = i;
   }
   PieceCnt[ side ]--;    
 }
  else
    { if(piece != king){
      PieceCnt[side]++;
      PieceList[side][PieceCnt[side]] = sq;
      Pindex[sq] = PieceCnt[side];
      } else {
	PieceCnt[side]++;
      	for (i = PieceCnt[side]; i > 0; i--)
        	{
          	PieceList[side][i] = PieceList[side][i - 1];
          	Pindex[PieceList[side][i]] = i;
        	} 
		PieceList[side][0] = sq;
		Pindex[sq] = 0;

      }
    }
}

void
MakeMove (SHORT side,
	  struct leaf *node,
	  SHORT *tempb,	/* color of to square */
	  SHORT *tempc,	/* piece at to square */
	  SHORT *tempsf,	/* static value of piece on from */
	  SHORT *tempst,	/* static value of piece on to */
	  SHORT *INCscore)	/* score increment for pawn structure change */

/*
 * Update Arrays board[], color[], and Pindex[] to reflect the new board
 * position obtained after making the move pointed to by node. Also update
 * miscellaneous stuff that changes when a move is made.
 */

{
  register SHORT f, t, xside, ct, cf;
  register struct GameRec *g;

  xside = side ^ 1;
  g = &GameList[++GameCnt];
  g->hashkey = hashkey;
  g->hashbd = hashbd;
  g->epssq = epsquare;
  f = node->f;
  t = node->t;
  epsquare = -1;
  /* FROMsquare = f;*/
  TOsquare = t;
  *INCscore = 0;
  g->Game50 = Game50;
  g->gmove = (f << 8) | t;
  g->flags = node->flags;
  if (node->flags & cstlmask)
    {
      g->piece = no_piece;
      g->color = side;
      (void) castle (side, f, t, 1);
      Game50 = GameCnt;
    }
  else
    {
      if (!(node->flags & capture) && (board[f] != pawn))
	{ IncrementRPThash(side,hashkey); }
      else
	Game50 = GameCnt;
      *tempsf = svalue[f];
      *tempst = svalue[t];
      g->piece = *tempb = board[t];
      g->color = *tempc = color[t];
      if (*tempc != neutral)
	{
	  UpdatePieceList (*tempc, t, 1,*tempb);
	  /* if capture decrement pawn count */
	  if (*tempb == pawn)
	    {
	      --PawnCnt[*tempc][column (t)];
	    }
	  if (board[f] == pawn)
	    {
	      cf = column (f);
	      ct = column (t);
	      /* move count from from to to */
	      --PawnCnt[side][cf];
	      ++PawnCnt[side][ct];

	      /*
	       * calculate increment for pawn structure
	       * changes
	       */
	      /* doubled or more - */
	      if (PawnCnt[side][ct] > (1 + PawnCnt[side][cf]))
		*INCscore -= 15;
	      /* went to empty column + */
	      else if (PawnCnt[side][ct] < 1 + PawnCnt[side][cf])
		*INCscore += 15;

	      /*
	       * went to outside col or empty col on one
	       * side ????????
	       */
	      else if (ct == 0 || ct == 7 || PawnCnt[side][ct + ct - cf] == 0)
		*INCscore -= 15;
	    }
	  mtl[xside] -= value[*tempb];
	  if (*tempb == pawn)
	    pmtl[xside] -= valueP;
	  UpdateHashbd (xside, *tempb, -1, t);
	  *INCscore += *tempst;
	  Mvboard[t]++;
	}
      color[t] = color[f];
      board[t] = board[f];
      svalue[t] = svalue[f];
      Pindex[t] = Pindex[f];
      PieceList[side][Pindex[t]] = t;
      color[f] = neutral;
      board[f] = no_piece;
      if (board[t] == pawn)
	if (t - f == 16)
	  epsquare = f + 8;
	else if (f - t == 16)
	  epsquare = f - 8;
      if (node->flags & promote)
	{
	  board[t] = node->flags & pmask;
	  if (board[t] == queen)
	    HasQueen[side]++;
	  else if (board[t] == rook)
	    HasRook[side]++;
	  else if (board[t] == bishop)
	    HasBishop[side]++;
	  else if (board[t] == knight)
	    HasKnight[side]++;
	  --PawnCnt[side][column (t)];
	  mtl[side] += value[board[t]] - valueP;
	  pmtl[side] -= valueP;
	  UpdateHashbd (side, pawn, f, -1);
	  UpdateHashbd (side, board[t], f, -1);
	  *INCscore -= *tempsf;
	}
      if (node->flags & epmask)
	EnPassant (xside, f, t, 1);
      else
	UpdateHashbd (side, board[t], f, t);
      Mvboard[f]++;
    }
}

void
UnmakeMove (SHORT side,
	    struct leaf *node,
	    SHORT *tempb, /* -> piece */
	    SHORT *tempc, /* -> side */
	    SHORT *tempsf,
	    SHORT *tempst)

/*
 * Take back a move.
 */

{
  register SHORT f, t, xside;

  xside = side ^ 1;
  f = node->f;
  t = node->t;
  Game50 = GameList[GameCnt].Game50;
  if (node->flags & cstlmask)
    (void) castle (side, f, t, 2);
  else
    {
      color[f] = color[t];
      board[f] = board[t];
      svalue[f] = *tempsf;
      Pindex[f] = Pindex[t];
      PieceList[side][Pindex[f]] = f;
      color[t] = *tempc;
      board[t] = *tempb;
      svalue[t] = *tempst;
      if (node->flags & promote)
	{
	  board[f] = pawn;
	  ++PawnCnt[side][column (t)];
	  mtl[side] += valueP - value[node->flags & pmask];
	  pmtl[side] += valueP;
	  UpdateHashbd (side, (SHORT) node->flags & pmask, -1, t);
	  UpdateHashbd (side, pawn, -1, t);
	}
      if (*tempc != neutral)
	{
	  UpdatePieceList (*tempc, t, 2,*tempb);
	  if (*tempb == pawn)
	    {
	      ++PawnCnt[*tempc][column (t)];
	    }
	  if (board[f] == pawn)
	    {
	      --PawnCnt[side][column (t)];
	      ++PawnCnt[side][column (f)];
	    }
	  mtl[xside] += value[*tempb];
	  if (*tempb == pawn)
	    pmtl[xside] += valueP;
	  UpdateHashbd (xside, *tempb, -1, t);
	  Mvboard[t]--;
	}
      if (node->flags & epmask)
	{
	  EnPassant (xside, f, t, 2);
	}
      else
	UpdateHashbd (side, board[f], f, t);
      Mvboard[f]--;
      if (!(node->flags & capture) && (board[f] != pawn))
	{ DecrementRPThash(side,hashkey); }
    }
  epsquare = GameList[GameCnt--].epssq;
}


void
InitializeStats (void)

/*
 * Scan thru the board seeing what's on each square. If a piece is found,
 * update the variables PieceCnt, PawnCnt, Pindex and PieceList. Also
 * determine the material for each side and set the hashkey and hashbd
 * variables to represent the current board position. Array
 * PieceList[side][indx] contains the location of all the pieces of either
 * side. Array Pindex[sq] contains the indx into PieceList for a given
 * square.
 */

{
  register SHORT i, sq;

  epsquare = -1;
  for (i = 0; i < 8; i++)
    {
      PawnCnt[white][i] = PawnCnt[black][i] = 0;
    }
  mtl[white] = mtl[black] = pmtl[white] = pmtl[black] = 0;
  PieceCnt[white] = PieceCnt[black] = 0;
  hashbd = hashkey = 0;
  for (sq = 0; sq < 64; sq++)
    if (color[sq] != neutral)
      {
	mtl[color[sq]] += value[board[sq]];
	if (board[sq] == pawn)
	  {
	    pmtl[color[sq]] += valueP;
	    ++PawnCnt[color[sq]][column (sq)];
	  }
	Pindex[sq] = ((board[sq] == king) ? 0 : ++PieceCnt[color[sq]]);

	PieceList[color[sq]][Pindex[sq]] = sq;
	UpdateHashbd(color[sq], board[sq], -1, sq);
      }
}

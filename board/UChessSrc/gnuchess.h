/*#define LONGINTS 1*/
#define AGING 1
#define NODITHER 1
#define INTSIZE short
/*#define LONGINTS2 1*/
#ifdef LONGINTS
#define INTSIZE2 long
#else
#define INTSIZE2 short
#endif


#ifdef _M68040
#define VERSTRING "UChess v2.89L(040)"
#define AVSTR "$VER: UChess 2.89L [040] (29.07.94)"
#else
#ifndef TINYCHESS
#define VERSTRING "UChess v2.89(020)"
#define AVSTR "$VER: UChess 2.89 [020] (29.07.94)"
#else
#define VERSTRING "UChess v2.89T(020)"
#define AVSTR "$VER: UChess 2.89T [020] (29.07.94)"
#endif
#endif


#define ARGSZ long

#define REG register

/* 
   To fix it as a tool for pgm use, modify the routine
   InputCommand() in dspcom.c and OutputMove() in nondsp.c 
   modify main.c to setup screen, etc,
   modify inline statement below,
   Modify SelectLevel in nondsp.c so that it does not use scanf
   in dspcom.c, ElapsedTime function is where you cut short
   any thinking on human players time.  Around the FIONREAD
   area, you need a loop for looking for the intuition events
   and stop the thinking short if that happens

   Modify PromptForMove in nondsp.c, actaully may not be needed at all

   */

/*
 * gnuchess.h - Header file for GNU CHESS
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

/*

 On an Amiga 4000, Gnuchess 4.0 gets from  80,000(short), 100,000 (long)
 nodes/sec on MoveList, and 3000(s)-3700(l) Nodes/sec on Eval Speed 

 On a SunStation (netcom), Gnuchess 4.0 gets from 100,000 to 133,300 nodes/sec on
 MoveList, and 3700 Nodes/sec on Eval Speed 

*/


#if !defined(__STDC__) || !defined(MSDOS)
#define const
#endif

#ifndef __GNUC__
#define inline __inline
#endif

#include <stdio.h>

typedef unsigned char	UCHAR;	    /* unsigned 8-bit quantity */
typedef short tshort;
typedef unsigned short utshort;
#ifdef USEINT
typedef  int SHORT;
typedef  unsigned int UTSHORT;
#else
typedef unsigned short UTSHORT;
//typedef short SHORT;
#endif


#ifdef AMIGA
#undef printf
#define printf NULLY
#undef stdin
#undef stdout
#undef stderr
#define stdin NULLYIN
#define stdout NULLYOUT
#define stderr NULLYERR
#undef scanf
#define scanf NULLYSCANF
#endif

#define SEEK_SET 0
#define SEEK_END 2
#ifdef DEBUG
void
ShowDBLine (char *, INTSIZE int, INTSIZE int,
	    INTSIZE int, INTSIZE int, INTSIZE int,
	    INTSIZE unsigned int *);
     extern FILE *debugfd;
     extern INTSIZE int debuglevel;

#endif /* DEBUG */

#include <ctype.h>

#ifdef AMIGA
#define __USE_SYSBASE
#include <exec/types.h>
#include <dos/dos.h>
#include <proto/exec.h>
#endif


extern long int GenCnt;

extern int GlobalTgtDepth;
extern int TCadd;
extern int mycnt3;
extern int globalmessage_valid;
extern struct IntuiMessage __aligned globalmessage;
extern char __far HintString[80];
extern char __far MateString[40];
extern int AmigaStarted;
extern int Mate;
extern int DrawnGame;

void
 TestSpeed (void (*f) (INTSIZE int side, INTSIZE int ply), unsigned j);
void
 TestPSpeed (INTSIZE int (*f) (INTSIZE int side), unsigned j);

void GetEditText(char *,int *);
void CloseAmigaEditWindow(void);
int OpenAmigaEditWindow(void);

unsigned int urand (void);
void gsrand (unsigned int seed);

#ifdef AMIGA
void __regargs MoveMem(void *,void *,ULONG);
void __regargs MoveMem128(void *,void *);
void __regargs ClearMem(void *,ULONG);
#endif
int myfgets(char *,int ,BPTR);
int DoResign(void);
void EnableMoveNow(void);
void DisableMoveNow(void);
void UpdateClocks (void);
int LoadFullBitMap(void);
void DoLegalMove(char *);
void DisplayComputerMove(char *);
int HandleEvent(APTR);
void DoAbout(void);
void LoadAGame(void);
void SaveAGame(void);
void ListAGame(void);
void DoQuit(void);
void Go2D(void);
void Go3D(void);
void DoReverse(void);
void DoSwap(void);
void DoAutoPlay(void);
void MoveNow(void);
void TakeBack(void);
void DoThinking(void);
void DoShwThnk(void);
void DoSuper(void);
void DoBookToggle(void);
void DoHint(void);
void DoTest(void);
void SetTime(void);
int GetFileName(char *);

void DisplayError(char *);
void __saveds InputThread(void);
void GetOperatorEntry(void);
void AmigaShutDown(void);
void AnimateAmigaMove(char *,char);
void GetTimeString(char *);
void GiveHint(void);
void EditBoard(void);
void help(void);
void ChangeAlphaWindow(void);
void ChangeBetaWindow(void);
void ChangeSearchDepth(void);
void ChangeHashDepth(void);
void SetContempt(void);
void ChangeXwindow(void);
void ShowPostnValues(void);
void DoDebug(void);
void DoTable(INTSIZE *);

void GetGame(void);
void SaveGame(void);
void DrawAmigaBoard(void);
void skip(void);
void skipb(void);
void EnPassant (INTSIZE int xside, INTSIZE int f, INTSIZE int t, INTSIZE int iop);

void ataks(INTSIZE int, INTSIZE int *);
void Initialize_dist(void);
void InitConst(char *);
int SetAmigaDepth(void);


#ifdef MSDOS
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define RWA_ACC "r+b"
#define WA_ACC "w+b"
#else
#define RWA_ACC "r+"
#define WA_ACC "w+"
/*
#include <sys/param.h>
#include <sys/types.h>
#include <sys/times.h>
*/
#include <stdlib.h>
#include <string.h>
#include <time.h>

extern int FirstTime;

#endif /* MSDOS */
#ifdef NONDSP
#ifdef AMIGA
#define printz NULLFUNC
#define scanz NULLFUNC2
#else
#define printz printf
#define scanz scanf
#endif
#else
#include <curses.h>
#define scanz fflush(stdout),scanw
#define printz printw
#endif

#if defined(__STDC__) || defined(MSDOS)
/* <stdio.h> */
     extern int fclose (FILE *);
#ifndef __ultrix /* work around bug in c89 compiler --t.mann */
#endif /*__ultrix*/

/* <stdlib.h> */

/* <time.h> */

/* <string.h> */
#endif


/* Piece values */
#define valueP 100
#define valueN 350
#define valueB 355
#define valueR 550
#define valueQ 1100
#define valueK 1200
/* masks into upper 8 bits of ataks array */
#define ctlP 0x4000
#define ctlN 0x2800
#define ctlB 0x1800
#define ctlR 0x0400
#define ctlQ 0x0200
#define ctlK 0x0100
#define ctlBQ 0x1200
#define ctlBN 0x0800
#define ctlRQ 0x0600
#define ctlNN 0x2000
/* attack functions */
#define Patak(c, u) (atak[c][u] > ctlP)
#define Anyatak(c, u) (atak[c][u] > 0)
/* distance function */
#define taxicab(a,b) taxidata[a][b]
/* hashtable flags */
#define truescore 0x0001
#define lowerbound 0x0002
#define upperbound 0x0004
#define kingcastle 0x0008
#define queencastle 0x0010
#define evalflag 0x0020 /* from PL 61 */
/* king positions */
#define wking PieceList[white][0]
#define bking PieceList[black][0]
#define EnemyKing PieceList[c2][0]
/* constants */
/* castle moves */
#define BLACKCASTLE	0x3C3E
#define WHITECASTLE	0x0406
#define LONGBLACKCASTLE	0x3C3A
#define LONGWHITECASTLE	0x0402
/* truth values */
#define false 0
#define true 1
/* colors */
#define white 0
#define black 1
#define neutral 2
/* piece code defines */
#define no_piece 0
#define pawn 1
#define knight 2
#define bishop 3
#define rook 4
#define queen 5
#define king 6
#define bpawn 7
/* node flags */
#define pmask 0x0007
#define promote 0x0008
#define cstlmask 0x0010
#define epmask 0x0020
#define exact 0x0040
#define pwnthrt 0x0080
#define check 0x0100
#define capture 0x0200
#define draw 0x0400
#define book 0x1000
/* move symbols */
#define pxx (CP[2])
#define qxx (CP[1])
#define rxx (CP[4])
#define cxx (CP[3])
/* for everything that can't use the above */
#define Qxx " pnbrqk"
#define Pxx " PNBRQK"
#define Cxx "abcdefgh"
#define Rxx "12345678"
/***************************************************************************/
/***************** Table limits ********************************************/
/*
 * ttblsz must be a power of 2. Setting ttblsz 0 removes the transposition
 * tables.
 */
#ifdef MSDOS
#define vttblsz (1 << 11)
#else
#ifdef _M68040
#define vttblsz (150001) // was 150001 in pl70
#else
#ifndef TINYCHESS
#define vttblsz (1 << 16)
#else
#define vttblsz (1 << 14)
#endif
#endif
#define huge
#endif /* MSODS */

#define ttblsz vttblsz
#define TREE 1500		/* max number of tree entries */
#define MAXDEPTH 35		/* max depth a search can be carried */
#define MINDEPTH 2		/* min search depth =1 (no hint), >1 hint */
#define MAXMOVES 400		/* max number of half moves in a game */
#ifdef _M68040
#define BOOKSIZE 30000		/* was 30k Number of unique position/move combinations allowed */
#else
#ifndef TINYCHESS
#define BOOKSIZE 11200		/* was 30k Number of unique position/move combinations allowed */
#else
#define BOOKSIZE 5000		/* was 30k Number of unique position/move combinations allowed */
#endif
#endif
#define CPSIZE 226		/* size of lang file max */
#ifdef _M68040
#define ETABLE (18001)		/* static eval cache was 18001 in uchess pl70 */
#else
#ifndef TINYCHESS
#define ETABLE (2<<11)		/* static eval cache */
#else
#define ETABLE (2<<9)		/* static eval cache */
#endif
#endif
/***************** tuning paramaters **********************************************/
#define MINGAMEIN 4
#define MINMOVES 15
#define FBEYOND 5// was 7
#define SBEYOND 9
#define TBEYOND 11
#define CHKDEPTH 1		/* always look forward CHKDEPTH half-moves if in check */
#define DEPTHBEYOND 11		/* Max to go beyond Sdepth */
#define HASHDEPTH 2 // was 3		/* depth above which to use HashFile */
#define HASHMOVELIMIT 40	/* Use HashFile only for this many moves */
#define PTVALUE 0	        /* material value below which pawn threats at 5 & 3 are used */
#define ZDEPTH 3		/* depth beyond which to check ZDELTA for extra time */
#define ZDELTA 40//10		/* is 40 in 4pl68 score delta per ply to cause extra time to be given */
#define QBLOCK false //was true		/* if true cache quiescent positions */
#define BESTDELTA 90
#define ZNODES 1000		/* check the time every ZNODES positions */
/*#define MAXTCCOUNT 4		/* max number of time clicks per search */
#define MAXTCCOUNTX  10		/* max number of time clicks per search to complete ply*/
#define MAXTCCOUNTR 4		/* max number of time clicks per search extensions*/
#define SCORESPLIM 8		/* Score space doesn't apply after this stage */
/*#define MINSEARCHPCT 10		/* must have looked at MINSEARCHPCT moves on a ply on a timeout */
/*#define SCORETIME -50		/* score below which to add search time */
#define SCORESPLIM 8		/* Score space doesn't apply after this stage */
#define SDEPTHLIM Sdepth+2 /* WAS Sdepth+1 in 2.35 of UChess */
#define HISTORYLIM 4096		/* Max value of history killer */
#define EWNDW 10		/* Eval window to force position scoring at depth greater than Sdepth + 2 */
#define WAWNDW 90		/* alpha window when computer white*/
#define WBWNDW 90		/* beta window when computer white*/
#define BAWNDW 90		/* alpha window when computer black*/
#define BBWNDW 90		/* beta window when computer black*/
#define BXWNDW 90		/* window to force position scoring at lower */
#define WXWNDW 90		/* window to force position scoring at lower */
#define PCRASHS	5
#define PCRASHV 5
#define PCENTERS 5
#define PCENTERV 5
#define DITHER 5		/* max amount random can alter a pos value */
#define BBONUS 2		/* points per stage value of B increases */
#define RBONUS 6		/* points per stage value of R increases */
#define KINGPOSLIMIT ( -1)	/* King positional scoring limit */
#define KINGSAFETY  40 /* was 32 in PL60,  in PL61 it is 40 */
#define MAXrehash (7)
#define NULLMOVELIM 4000	/* below this total material on board don't use null move */
#define DEPTHMARGIN 2
#define THRSTAGE    6
#define CHECKSTAGE  5

#if defined AG0
#define WHITEAG0
#define BLACKAG0

#elif defined AG1
#define WHITEAG1
#define BLACKAG1

#elif defined AG2
#define WHITEAG2
#define BLACKAG2

#elif defined AG3
#define WHITEAG3
#define BLACKAG3

#elif defined AGB
#define WHITEAG2
#define BLACKAG2

#elif defined AG4
#define WHITEAG4
#define BLACKAG4
#endif
/************************* parameters for Opening Book *********************************/
#define BOOKBITS 10		/* # bits for hashtable to book moves */
#define BOOKFAIL 20000		/* if no book move found for BOOKFAIL turns stop using book */
#define BOOKRAND 1000		/* used to select an opening move from a list */
#define BOOKENDPCT 950		/* 50 % chance a BOOKEND will stop the book */
#define DONTUSE -32000 //was -32768		/* flag move as don't use */
/*************************** Book access defines ****************************************/
#define BKTBLSIZE (2<<BOOKBITS)
#define BOOKMASK (BKTBLSIZE - 1)
#define SIDEMASK 0x1
#define BOOKEND 0x2		/* means this is the last move of an opening */
#define BADMOVE 0x8000		/* means this is a bad move in this position */
/****************************************************************************************/
     struct hashval
     {
       unsigned long key, bd;
     };

#ifdef CACHE
	struct etable
	{ unsigned long ehashbd;
		short int escore[2];
		short int sscore[64];
		short int score;
		short int xx_pad;
		short int hung[2];
	} ;


     struct hashentry
     {
       unsigned long hashbd;
       unsigned short mv;
       unsigned char flags, depth;	/* char saves some space */
       unsigned short age;
       short score;
#ifdef HASHTEST
       unsigned char bd[32];
#endif /* HASHTEST */

     };
#else
     struct hashentry
     {
       unsigned long hashbd;
       unsigned INTSIZE2 mv;
       unsigned char flags, depth;	/* char saves some space */
       INTSIZE2 score;
#ifdef HASHTEST
       unsigned char bd[32];
#endif /* HASHTEST */

     };
#endif

#ifdef HASHFILE

/*
 * persistent transposition table. The size must be a power of 2. If you
 * change the size, be sure to run gnuchess -c before anything else.
 */
#define frehash 6
#ifdef MSDOS
#define Deffilesz (1 << 11) -1
#else
#define Deffilesz (1 << 17) -1
#endif /* MSDOS */
     struct fileentry
     {
       unsigned char bd[32];
       unsigned char f, t, flags, depth, sh, sl;
     };

#endif /* HASHFILE */


     struct leaf
     {
       INTSIZE f, t, score, reply, width;
       unsigned INTSIZE flags;
     };
     struct GameRec
     {
       unsigned INTSIZE gmove;	/* this move */
       INTSIZE score;		/* score after this move */
       INTSIZE depth;		/* search depth this move */
       INTSIZE time;		/* search time this move */
       INTSIZE piece;		/* piece captured */
       INTSIZE color;		/* color */
       INTSIZE flags;		/* move flags capture, promote, castle */
       INTSIZE Game50;		/* flag for repetition */
       long nodes;		/* nodes searched for this move */
       long hashkey, hashbd;	/* board key before this move */
       short epssq;		/* epssquare before this move */
#ifdef DEBUG40
       int d1;
       int d2;
       int d3;
       int d4;
       int d5;
       int d6;
       int d7;
#endif
     };
     struct TimeControlRec
     {
       INTSIZE moves[2];
       long clock[2];
     };

     struct flags
     {
       INTSIZE mate;		/* the game is over */
       INTSIZE post;		/* show principle variation */
       INTSIZE quit;		/* quit/exit */
       INTSIZE regularstart;	/* did the game start from standard
				 * initial board ? */
       INTSIZE reverse;		/* reverse board display */
       INTSIZE bothsides;		/* computer plays both sides */
       INTSIZE hash;		/* enable/disable transposition table */
       INTSIZE force;		/* enter moves */
       INTSIZE easy;		/* disable thinking on opponents time */
       INTSIZE beep;		/* enable/disable beep */
       INTSIZE timeout;		/* time to make a move */
       INTSIZE musttimeout;	/* time to make a move */
       INTSIZE back;		/* time to make a move */
       INTSIZE rcptr;		/* enable/disable recapture heuristics */
       INTSIZE rv;		/* reverse video */
       INTSIZE stars;		/* add stars to uxdsp screen */
       INTSIZE coords;		/* add coords to visual screen */
       INTSIZE shade;
       INTSIZE material;		/* draw on lack of material */
       INTSIZE illegal;		/* illegal position */
       INTSIZE onemove;		/* timing is onemove */
       INTSIZE gamein;		/* timing is gamein */
       INTSIZE threat;            /* Enable threats, tom@izf.tno.nl */
     };

#ifdef DEBUG
     extern FILE *debugfile;

#endif /* DEBUG */
#ifdef HISTORY
     extern unsigned char __far history[32768];
#endif
     extern int Sdepth2;
     extern int thinking2;
     extern char *ColorStr[2];
     extern unsigned INTSIZE int MV[MAXDEPTH];
     extern int MSCORE;
     extern int mycnt1, mycnt2;
     extern INTSIZE int ahead;
     extern INTSIZE int chesstool;
     extern struct leaf __far Tree[];
     extern struct leaf  *root/*, rootnode*/;
     extern char __far savefile[];
     extern char __far listfile[];
     extern INTSIZE TrPnt[];
     extern INTSIZE board[], color[];
     extern INTSIZE PieceList[2][64], PawnCnt[2][8];
     extern int Castled[2];
     extern int MouseDropped;
     extern int myEnPassant[2];
     extern INTSIZE castld[], Mvboard[];
     extern INTSIZE __aligned svalue[64];
     extern struct flags flag;
     extern INTSIZE opponent, computer, INCscore;
     extern INTSIZE WAwindow, BAwindow, WBwindow, BBwindow;
     extern INTSIZE dither, player;
     extern INTSIZE xwndw, epsquare, contempt;
     extern long ResponseTime, ExtraTime, MaxResponseTime, et, et0, time0, ft;
     extern long reminus, replus;
     extern long NodeCnt, ETnodes, EvalNodes, HashAdd, HashCnt, HashCol, THashCol,
      FHashCnt, FHashAdd;
     extern INTSIZE HashDepth, HashMoveLimit;
     extern struct GameRec GameList[];
     extern INTSIZE GameCnt, Game50;
     extern INTSIZE Sdepth, MaxSearchDepth;
     extern int Book;
     extern struct TimeControlRec TimeControl;
     extern INTSIZE TCflag, TCmoves, TCminutes, TCseconds, OperatorTime;
     extern int timecomp[MINGAMEIN], timeopp[MINGAMEIN];
     extern int compptr,oppptr;
     extern INTSIZE XCmore, XCmoves[], XCminutes[], XCseconds[], XC;
     extern const INTSIZE otherside[];
     extern const INTSIZE Stboard[];
     extern const INTSIZE Stcolor[];
     extern unsigned INTSIZE hint;
     extern INTSIZE int TOflag;
     extern INTSIZE stage, stage2, Developed[];
     extern INTSIZE ChkFlag[], CptrFlag[], PawnThreat[];
     extern short ChkFlag[], CptrFlag[], PawnThreat[];
     extern short QueenCheck[];  /* tom@izf.tno.nl */
//     extern short NMoves[];  /* tom@izf.tno.nl */
     extern short Threat[];  /* tom@izf.tno.nl */
     extern short ThreatSave[];  /* tom@izf.tno.nl */
     extern INTSIZE Pscore[], Tscore[];
     extern INTSIZE rehash;
     extern unsigned int ttblsize;
     extern INTSIZE mtl[], pmtl[], hung[], emtl[];
     extern INTSIZE Pindex[];
     extern INTSIZE PieceCnt[];
     extern INTSIZE FROMsquare, TOsquare;
     extern INTSIZE HasKnight[], HasBishop[], HasRook[], HasQueen[];
     extern const INTSIZE qrook[];
     extern const INTSIZE krook[];
     extern const INTSIZE kingP[];
     extern const INTSIZE rank7[];
     extern const INTSIZE sweep[];
     extern const INTSIZE epmove1[], epmove2[];
     extern unsigned INTSIZE killr0[], killr1[];
     extern unsigned INTSIZE killr2[], killr3[];
     extern unsigned INTSIZE PV, SwagHt, Swag0, Swag1, Swag2, Swag3, Swag4, sidebit;
#ifdef KILLT
     extern INTSIZE __far __aligned killt[0x4000];
#endif
     extern INTSIZE mtl[2], pmtl[2], hung[2];
     extern const INTSIZE value[];
     extern const INTSIZE control[];
     extern unsigned char __far nextpos[8][64][64];
     extern unsigned char __far nextdir[8][64][64];
     extern const INTSIZE ptype[2][8];
     extern long filesz;
     extern FILE *hashfile;
     extern unsigned int starttime;
     extern int ThinkAheadWorked;
     extern int ThinkInARow;
     extern int ThinkAheadDepth;
#ifdef LONGINTS2
     extern INTSIZE __far distdata[64][64];
     extern INTSIZE __far taxidata[64][64];
#else
     extern INTSIZE distdata[64][64];
     extern INTSIZE taxidata[64][64];
#endif
     extern int bookcount;
     extern unsigned long hashkey, hashbd;
#ifdef LONGINTS2
     extern struct hashval __far hashcode[2][7][64];
#else
     extern struct hashval hashcode[2][7][64];
#endif
     extern char __far *CP[];
#ifdef QUIETBACKGROUND
     extern INTSIZE background;
#endif /* QUIETBACKGROUND */

#ifdef CACHE

#ifdef ttblsz
     extern struct hashentry *ttable[2];
#endif

#else

#ifdef ttblsz
     extern struct hashentry __far ttable[2][vttblsz + MAXrehash];
#endif

#endif

/*
 * hashbd contains a 32 bit "signature" of the board position. hashkey
 * contains a 16 bit code used to address the hash table. When a move is
 * made, XOR'ing the hashcode of moved piece on the from and to squares with
 * the hashbd and hashkey values keeps things current.
 */
#define UpdateHashbd(side, piece, f, t) \
{\
  if ((f) >= 0)\
    {\
      hashbd ^= hashcode[side][piece][f].bd;\
      hashkey ^= hashcode[side][piece][f].key;\
    }\
  if ((t) >= 0)\
    {\
      hashbd ^= hashcode[side][piece][t].bd;\
      hashkey ^= hashcode[side][piece][t].key;\
    }\
}


     extern INTSIZE rpthash[2][256];
     extern char *DRAW;

#define distance(a,b) distdata[a][b]
#define row(a) ((a) >> 3)
#define column(a) ((a) & 7)
#define locn(a,b) (((a) << 3) | (b))

/* init external functions */
     extern void NewGame (void);
     extern int parse (FILE * fd, INTSIZE unsigned int *mv, INTSIZE int side, char *opening);
     extern void GetOpenings (int);
     extern int OpeningBook (unsigned INTSIZE int *hint, INTSIZE int side);
     extern void SelectMove (INTSIZE int side, INTSIZE int iop);
     int 
      search (INTSIZE int side,
	       INTSIZE int ply,
	       INTSIZE int depth,
	       short ext,
	       INTSIZE int alpha,
	       INTSIZE int beta,
	       INTSIZE unsigned int *bstline,
	       INTSIZE int *rpt,
               short SAVEHT,
	       int didnull);
#if ttblsz
     extern int
      ProbeTTable (int side,
		    int depth,
		    int ply,
		    SHORT *alpha,
		    SHORT *beta,
		    SHORT *score);
     extern int
      PutInTTable (int side,
		    int score,
		    int depth,
		    int ply,
		    //int alpha,
		    int beta,
		    unsigned int mv);
     extern void ZeroTTable (int);
     extern void ZeroRPT (void);
     extern void Initialize_ttable (void);
#ifdef HASHFILE
     extern unsigned int urand (void);
     extern void srand (unsigned int);
     extern int
      ProbeFTable (INTSIZE int side,
		    INTSIZE int depth,
		    INTSIZE int ply,
		    INTSIZE int *alpha,
		    INTSIZE int *beta,
		    INTSIZE int *score);
     extern void
      PutInFTable (INTSIZE int side,
		    INTSIZE int score,
		    INTSIZE int depth,
		    INTSIZE int ply,
		    INTSIZE int alpha,
		    INTSIZE int beta,
		    INTSIZE unsigned int f,
		    INTSIZE unsigned int t);

#endif /* HASHFILE */
#endif /* ttblsz */
     extern void Initialize_moves (void);
     extern void MoveList (INTSIZE int side, INTSIZE int ply);
     extern void CaptureList (INTSIZE int side, INTSIZE int ply);
     extern int castle (INTSIZE int side, INTSIZE int kf, INTSIZE int kt, INTSIZE int iop);
     extern void
      MakeMove (INTSIZE int side,
		 struct leaf * node,
		 INTSIZE int *tempb,
		 INTSIZE int *tempc,
		 INTSIZE int *tempsf,
		 INTSIZE int *tempst,
		 INTSIZE int *INCscore);
     extern void
      UnmakeMove (INTSIZE int side,
		   struct leaf * node,
		   INTSIZE int *tempb,
		   INTSIZE int *tempc,
		   INTSIZE int *tempsf,
		   INTSIZE int *tempst);
     extern void InitializeStats (void);
#ifdef OLD4PL67
     extern int
      evaluate (INTSIZE int side,
		 INTSIZE int ply,
		 INTSIZE int alpha,
		 INTSIZE int beta,
		 INTSIZE int INCscore,
		 /*INTSIZE int *slk,*/
		 INTSIZE int *InChk);
#else
int
evaluate (register short side,
	  register short ply,
	  register short depth,
          register short ext,
	  register short alpha,
	  register short beta,
	  short INCscore,
	  short *InChk);	/* output Check flag */
#endif
     extern INTSIZE int ScorePosition (INTSIZE int side);
     extern void ExaminePosition (void);
     extern void Initialize (void);
     extern void InputCommand (char *);
     extern void ExitChess (void);
     extern void ClrScreen (void);
     extern void SetTimeControl (void);
     extern void SelectLevel (char *);
     extern void
      UpdateDisplay (INTSIZE int f,
		      INTSIZE int t,
		      INTSIZE int flag,
		      INTSIZE int iscastle);
     extern void ElapsedTime (INTSIZE int iop);
     extern void ShowSidetoMove (void);
     extern void SearchStartStuff (INTSIZE int side);
     extern void ShowDepth (char ch);
     extern void TerminateSearch (int);
     extern void
      ShowResults (INTSIZE int score,
		    INTSIZE unsigned int *bstline,
		    char ch);
     extern void PromptForMove (void);
     extern void SetupBoard (void);
     extern void algbr (INTSIZE int f, INTSIZE int t, INTSIZE int flag);
     extern void OutputMove (char *);
     extern void ShowCurrentMove (INTSIZE int pnt, INTSIZE int f, INTSIZE int t);
     extern void ListGame (int);
     extern void ShowMessage (char *s);
     extern void ClrScreen (void);
     extern void gotoXY (INTSIZE int x, INTSIZE int y);
     extern void ClrEoln (void);
     extern void DrawPiece (INTSIZE int sq);
     extern void UpdateClocks (void);
     extern void ShowLine (INTSIZE unsigned int *bstline,char *);
     extern int pick (INTSIZE int p1, INTSIZE int p2);
     extern int TrComp (struct leaf * a, struct leaf * b);
     void UpdateWeights(void);

#ifdef AMIGA
struct myMsgStruct {
struct Message MainMsg;
ULONG myData;
};
#endif



#include "ttable.h"

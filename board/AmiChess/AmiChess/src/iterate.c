#include <clib/alib_protos.h>
#ifdef __PPC__
#include <clib/powerpc_protos.h>
#include <clib/utility_protos.h>
#include <intuition/classes.h>
#else
#include <clib/timer_protos.h>
#endif
#include <devices/timer.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include "catalog.h"
#include "common.h"

#define WINDOW	75

void MoveSound(char *);
void PlaySound(Object *,BOOL);

extern Object *snd_smate;
extern Object *snd_draw;

int InChkDummy,terminal;

#ifdef __PPC__

ULONG DoMethod(Object *obj,ULONG MethodID,...)
{
return CallHookPkt(&OCLASS(obj)->cl_Dispatcher,obj,(APTR)&MethodID);
}

#endif

void Iterate(void)
{
int side;
int score,RootAlpha,RootBeta;
char text[50];
side=board.side;
computerplays=board.side;
lazyscore[white]=lazyscore[black]=150;
maxposnscore[white]=maxposnscore[black]=150;
GenCnt=0;
NodeCnt=QuiesCnt=0;
RootPawns=nbits(board.b[white][pawn]|board.b[black][pawn]);
RootPieces=nbits(board.friends[white]|board.friends[black])-RootPawns;
RootMaterial=MATERIAL;
ElapsedTime=0.0;
StartTime=StartTiming();
memset(ChkCnt,0,sizeof(ChkCnt));
memset(ThrtCnt,0,sizeof(ThrtCnt));
memset(history,0,sizeof(history));
memset(killer1,0,sizeof(killer1));
memset(killer2,0,sizeof(killer2));
CLEAR(flags,TIMEOUT);
if(flags&TIMECTL)
	{
	SearchTime=(TimeLimit[side]-2)/MoveLimit[side];
	SearchTime=95*SearchTime/100;
	if(suddendeath) SearchTime=92*SearchTime/100;
	if(nmovesfrombook<=3) SearchTime=1.5*SearchTime;
	if(TCinc!=0) if(SearchTime<TCinc)
		{
		if(TimeLimit[side]>30) SearchTime=TCinc;
		}
	}
Idepth=0;
TreePtr[2]=TreePtr[1];
GenMoves(1);
FilterIllegalMoves(1);
SortRoot();
InChk[1]=SqAtakd(board.king[side],1^side);
if(GenCnt==0)
	{
	if(!(flags&ENDED))
		{
		if(InChk[1])
			{
			if(computerplays==black)
				{
				strcpy(resultstr,"1-0");
				DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_COMP_LOSEBLACK));
				}
			else if(computerplays==white)
				{
				strcpy(resultstr,"0-1");
				DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_COMP_LOSEWHITE));
				}
			}
		else
			{
			strcpy(resultstr,"1/2-1/2");
			DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_STALEMATE));
			PlaySound(snd_smate,0);
			}
		}
	SET(flags,TIMEOUT|ENDED);
	return;
	}
if(GenCnt==1)
	{
	RootPV=TreePtr[1]->move;
	SET(flags,TIMEOUT);
	}
lastrootscore=score=Evaluate(-INFINITY,INFINITY);
wasbookmove=0;
if(bookmode!=BOOKOFF&&!(flags&SOLVE)&&nmovesfrombook<=3)
	{
	if(BookQuery()==BOOK_SUCCESS)
		{
		nmovesfrombook=0;
		wasbookmove=1;
		SET(flags,TIMEOUT);
		}
	else nmovesfrombook++;
	}
else nmovesfrombook++;
maxtime=4*SearchTime;
while(!(flags&TIMEOUT))
	{
	threatply=0;
	if(score>MATE-255)
		{
		RootAlpha=score-1;
		RootBeta=MATE;
		}
	else if(score<-MATE+255)
		{
		RootAlpha=-MATE;
		RootBeta=score+1;
		}
	else
		{
		RootAlpha=MAX(score-WINDOW,-MATE);
		RootBeta=MIN(score+WINDOW,MATE);
		}
	Idepth+=DEPTH;
	rootscore=-INFINITY-1;
	score=SearchRoot(Idepth,RootAlpha,RootBeta);
	if(score>=RootBeta&&score<MATE&&!(flags&TIMEOUT))
		{
		ShowLine(score,'+');
		rootscore=-INFINITY-1;
		RootAlpha=RootBeta;
		RootBeta=INFINITY;
		score=SearchRoot(Idepth,RootAlpha,RootBeta);
		}
	else
		{
		if(score<=RootAlpha&&!(flags&TIMEOUT))
			{
			ShowLine(score,'-');
			rootscore=-INFINITY-1;
			RootBeta=RootAlpha;
			RootAlpha=-INFINITY;
			score=SearchRoot(Idepth,RootAlpha,RootBeta);
			}
		}
	ShowLine(score,'.');
	lastrootscore=score;
	if(SearchDepth==0 &&(flags&TIMECTL)&&ElapsedTime>=2*SearchTime/3)
	SET(flags,TIMEOUT);
	if(abs(score)+Idepth>=MATE+1) SET(flags,TIMEOUT);
	if(Idepth==SearchDepth*DEPTH) break;
	}
ElapsedTime=GetElapsed(StartTime);
SANMove(RootPV,1);
strcpy(Game[GameCnt+1].SANmv,SANmv);
Game[GameCnt+1].et=ElapsedTime;
MakeMove(side,&RootPV);
if(flags&TIMECTL)
	{
	if(suddendeath)
		{
		if(TimeLimit[side]>0&&TimeLimit[side]<=60) MoveLimit[side]=60;
		else MoveLimit[side]=35;
		}
	else MoveLimit[side]--;
	TimeLimit[side]-=ElapsedTime;
	if(TCinc!=0) TimeLimit[side]+=TCinc;
	if(MoveLimit[side]==0) MoveLimit[side]=TCMove;
	}
if(!wasbookmove) DoMethod(mui_app,MUIM_Chess_Stats);
else DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_FROMBOOK));
DoMethod(mui_app,MUIM_Chess_MyMove,SANmv);
sprintf(text,"%d: %-5s  %2.2f",GameCnt/2+1,SANmv,ElapsedTime);
DoMethod(mui_app,MUIM_Chess_AddMove,side,text);
if(!(flags&SOLVE)) DoMethod(mui_app,MUIM_Chess_ShowBoard);
MoveSound(SANmv);
TreePtr[2]=TreePtr[1];
GenMoves(1);
FilterIllegalMoves(1);
if(TreePtr[1]==TreePtr[2])
	{
	if(SqAtakd(board.king[board.side],1^board.side))
		{
		if(computerplays==black)
			{
			strcpy(resultstr,"0-1");
			DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_COMP_WINBLACK));
			}
		else
			{
			strcpy(resultstr,"1-0");
			DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_COMP_WINWHITE));
			}
		}
	else
		{
		strcpy(resultstr,"1/2-1/2");
		DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_STALEMATE));
		PlaySound(snd_smate,0);
		}
	SET(flags,ENDED);
	}
if(EvaluateDraw()||Repeat()>=2)
	{
	strcpy(resultstr,"1/2-1/2");
	DoMethod(mui_app,MUIM_Chess_ShowThinking,getstr(MSG_DRAW));
	PlaySound(snd_draw,0);
	SET(flags,ENDED);
	}
DoMethod(mui_app,MUIM_Chess_Side);
}

double GetElapsed(Timer start)
{
Timer t;
#ifdef __PPC__
GetSysTimePPC(&t);
#else
GetSysTime(&t);
#endif
return(t.tv_sec+t.tv_usec/1e6)-(start.tv_sec+start.tv_usec/1e6);
}

Timer StartTiming(void)
{
Timer t;
#ifdef __PPC__
GetSysTimePPC(&t);
#else
GetSysTime(&t);
#endif
return t;
}

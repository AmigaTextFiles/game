
/*################*/
/* RandomPlayer.c */        /* 9.1.2011 */
/*################*/
/*

    Generate bumper and sled moves in a random manner.

NOTE: RandomPlayer pays no attention to the game state, so it can generate all 900 of its moves before
      starting the game. ie, it has no overhead in calculating its next move during the game.

      All timing is handled by the synchronous reading of the game state.

*/

/*
Copyright (C) 2010 Thomas Breeden, All Rights Reserved.
                   Aglet Software
                   PO Box 99
                   Free Union, VA 22940

Permission to use, copy, modify and distribute this software and its
documentation for any purpose and without fee is hereby granted, provided that
the above copyright notice appear in all copies and that both the copyright
notice and this permission notice appear in supporting documentation.
Thomas Breeden makes no representations about the suitability of this software
for any purpose. It is provided "as is" without express or implied warranty.
*/

/*

gcc -o RandomPlayer RandomPlayer.c ICPCPlayerLib.o pipeio.o -lauto

*/

#include <stdio.h>
#include <string.h>
#include <assert.h>

#include <proto/utility.h>
#include <proto/timer.h>

#include "MyTypes.h"

#include "CaptureSpecs.h"
#include "ICPCPlayerLib.h"
#include "PipeIO.h"

#define  PgmName "RandomPlayer"
#define  PgmVersion  "\0$VER: RandomPlayer 0.0 (31.10.2010) C\0"

#define  PgmTemplate "-CmdPipeName=-cp/K,-StatePipeName=-sp/K"
typedef enum {CmdPipeNameCmd, StatePipeNameCmd}     PgmCmds;

#define  BaseTime1  75
#define  BaseTime2  100

struct PipeInfo  StatePipe,
                 CmdPipe;

#define ParamStringSiz  32
char  CmdPipeName[ParamStringSiz+2],
      StatePipeName[ParamStringSiz+2];

float  Factor1,
       Factor2;
int    Factor1Time,
       Factor2Time;
Vector (Bump1Accel);
Vector (Bump2Accel);
float SledTurn;

struct OneMove {Vector    (B1);
                Vector    (B2);
                float      R;
               };

struct OneMove RandomMoves[1001];

PucksArray    Pucks;
BumpersArray  Bumpers;
SledsArray    Sleds;

int           TurnNumber;

struct RandomState randstate;

/*-------------------------------------*/
 static void Assert(boolean b, char msg[])
/*-------------------------------------*/
{

if (!b) {
   fprintf(stderr, "%s\n", msg);
   assert(0);
}

}

/*---------------------*/
 static boolean TstBreak(void)
/*---------------------*/
{

return (IDOS->CheckSignal(SIGBREAKF_CTRL_C) != 0);

}

/*------------------*/
 static boolean ODD(int i)
/*------------------*/
{

if ((i % 2) == 0) {
   return T;
} else {
   return F;
}

}

/*--------------------*/
 static void StrCap(char s[])
/*--------------------*/
{
int i,
    len;

len = strlen(s);

for (i = 0; i < len; i++) {
   s[i] = toupper(s[i]);
}

}

/*-------------------------------------------------------------------------*/
 static void StrSeg(char InStr[], int Start, int Stop, char OutStr[], int OutStrSize)
/*-------------------------------------------------------------------------*/
{
int  i,
     InStrLen,
     EndLoop;

InStrLen = strlen(InStr);
i = 0;

if (Start < 0) {
   Start = 0;
}

if ((Start < InStrLen) && (Stop >= 0)) {

   if (Stop >= InStrLen) {
      Stop = InStrLen-1;
   }

   EndLoop = Stop - Start;
   if (EndLoop >= OutStrSize) {
      EndLoop = OutStrSize-1;
   }

   while (i <= EndLoop) {
      OutStr[i] = InStr[i+Start];
      i++;
   }

}

OutStr[i] = '\0';

}

/*-------------------*/
 static float Random1(void)
/*-------------------*/

{
int  iFrac;

iFrac = (rand(200000000) / 100) % 100 - 50;

return iFrac / 100.0;

}

/*------------------------*/
 static void InitPgm(void)
/*------------------------*/

{
int    r;
struct TimeVal tval;

/*Seed = 7390431;*/
ITimer->GetSysTime(&tval);
randstate.rs_High = tval.Seconds;
randstate.rs_Low = tval.Microseconds;

TurnNumber = 0;
CmdPipeName[0] = '\0';
StatePipeName[0] = '\0';

Factor1 = 1.0;
Factor2 = -1.0;
r = IUtility->Random(&randstate) % 5;
Factor1Time = BaseTime1 + (r - 2);
r = IUtility->Random(&randstate) % 11;
Factor2Time = BaseTime2 + (r - 5);

SledTurn = Factor1*0.25;
Bump1Accel[X] = Factor1*1.0;
Bump1Accel[Y] = Factor1*0.5;
Bump2Accel[X] = Factor2*0.4;
Bump2Accel[Y] = Factor2*1.0;

printf("%s\n", PgmVersion);

}

/*-----------------------------------------------------------------------------------------------------*/
 static void GetArgs(char CmdPipeName[], int CmdPipeNameSiz, char StatePipeName[], int StatePipeNameSiz)
/*-----------------------------------------------------------------------------------------------------*/

{

struct RDArgs* rdargs;
char*          args[2];

args[0] = NULL;
args[1] = NULL;

rdargs = IDOS->ReadArgs(PgmTemplate, (LONG*)args, NULL);
Assert(rdargs != NULL, "ReadArgs() FAIL");

Assert(args[0] != NULL, "CmdPipeName missing");
Assert(strlen(args[0]) <= CmdPipeNameSiz, "CmdPipeName too long");
strcpy(CmdPipeName, args[0]);

Assert(args[1] != NULL, "StatePipeName missing");
Assert(strlen(args[1]) <= StatePipeNameSiz, "StatePipeName too long");
strcpy(StatePipeName, args[1]);

IDOS->FreeArgs(rdargs);

}

/*--------------------------*/
 static void InitPipes(void)
/*--------------------------*/

{
char        PipeNameAndBuffer[132];
OpenResults oRes;

StatePipe.pipeF = InvalidPipe();
strncpy(StatePipe.pipeName, StatePipeName, sizeof StatePipe.pipeName);
StrCap(StatePipe.pipeName);
if (strstr(StatePipe.pipeName, "PIPE:") == StatePipe.pipeName) {
   StrSeg(StatePipe.pipeName, 5, 32767, StatePipe.pipeName, (sizeof StatePipe.pipeName) -1);
};

CmdPipe.pipeF = InvalidPipe();
strncpy(CmdPipe.pipeName, CmdPipeName, sizeof CmdPipe.pipeName);
StrCap(CmdPipe.pipeName);
if (strstr(CmdPipe.pipeName, "PIPE:") == CmdPipe.pipeName) {
   StrSeg(CmdPipe.pipeName, 5, 32767, CmdPipe.pipeName, (sizeof CmdPipe.pipeName) -1);
};

/*if (DEBUGcomm) {  DebugPause(StatePipe.pipeName, 0); };*/
strcpy(PipeNameAndBuffer, StatePipe.pipeName);
strcat(PipeNameAndBuffer, "/8192");
StatePipe.pipeF = OpenPipe(PipeNameAndBuffer, PipeModeRead, &oRes);
Assert(oRes == opened, "OpenPipe for read FAIL");

/*if (DEBUGcomm) { DebugOn(0); DebugPause(CmdPipe.pipeName, 0); };*/
CmdPipe.pipeF = OpenPipe(CmdPipe.pipeName, PipeModeWrite, &oRes);
Assert(oRes == opened, "OpenPipe for write FAIL");

/*if (DEBUGcomm) { DebugPause("RandomPlayer pipes opened", 0); };*/

}

/*--------------------------------------*/
 static void CalcGameMove(int TurnNum)
/*--------------------------------------*/
{

if (TurnNum % Factor1Time == 0) {
   /*DebugOn(0); DebugPause("reverse Factor1", 0);*/

   if (ODD(IUtility->Random(&randstate))) {
      Factor1 = 1.0 + Random1();
   } else {
      Factor1 = -(1.0 + Random1());
   };
   /*DebugReal("Factor1", 0, Factor1);*/
   Bump1Accel[X] = Factor1*1.0;
   Bump1Accel[Y] = Factor1*0.5;
   SledTurn = Factor1 * (3.141592/16.0);

   Factor1Time = BaseTime1 + ((IUtility->Random(&randstate) % 5) - 2);
};

if (TurnNum % Factor2Time == 0) {
   /*DebugOn(0); DebugPause("reverse Factor2", 0);*/
   if (ODD(IUtility->Random(&randstate))) {
      Factor2 = 1.0 + Random1();
   } else {
      Factor2 = -(1.0 + Random1());
   };
   /*DebugReal("Factor2", 0, Factor2);*/
   Bump2Accel[X] = Factor2*0.4;
   Bump2Accel[Y] = Factor2*1.0;
   Factor2Time = BaseTime2 + ((IUtility->Random(&randstate) % 11) - 5);
};

/*SledTurn = (Factor1+Random1())*0.25;*/

/*
Bump1Accel[X] = Factor1*1.0;
Bump1Accel[Y] = Factor1*0.5;
Bump2Accel[X] = Factor2*0.4;
Bump2Accel[Y] = Factor2*1.0;
*/

}

/*----------------------------*/
 static void PreCalcRandomMoves(void)
/*----------------------------*/

{
int  i;

for (i = 0; i <= 900; i++) {
   CalcGameMove(i);
   RandomMoves[i].B1[0] = Bump1Accel[0];
   RandomMoves[i].B1[1] = Bump1Accel[1];
   RandomMoves[i].B2[0] = Bump2Accel[0];
   RandomMoves[i].B2[1] = Bump2Accel[1];
   RandomMoves[i].R = SledTurn;
};

}

 void RandomPlayer(void) {
/*----------------*/
 /*BEGIN*/ /* program */
/*----------------*/

/*DebugOn(0);*/
/*DebugPause("RandomPlayer", 0);*/

InitPgm();

/*
GetArgs(CmdPipeName, ParamStringSiz, StatePipeName, ParamStringSiz);
if (DEBUG) { DebugOn(0); DebugPause(CmdPipeName, 0); DebugPause(StatePipeName, 0); };
*/

PreCalcRandomMoves;

InitPipes();

while ((TurnNumber != -1) && !TstBreak()) {

   /*
   InGameState(StatePipe.pipeF, TurnNumber, Pucks, Bumpers, Sleds);
   */

   if (TurnNumber != -1) {

      CalcGameMove(TurnNumber);

      OutGameMove(CmdPipe.pipeF, RandomMoves[TurnNumber].B1, RandomMoves[TurnNumber].B2, RandomMoves[TurnNumber].R);

   };

};

}


/*----------*/
 int main()
/*----------*/
{

printf("Hello, World\n");

InitPgm();

GetArgs(CmdPipeName, ParamStringSiz, StatePipeName, ParamStringSiz);

PreCalcRandomMoves();

InitPipes();

while ((TurnNumber != -1) && !TstBreak()) {
   /*printf("%i\n", TurnNumber);*/

   /*if (TurnNumber > 10) {*/
   /*   getchar();*/
   /*}*/

   InGameState(StatePipe.pipeF, &TurnNumber, Pucks, Bumpers, Sleds);
 
   if (TurnNumber != -1) {

      CalcGameMove(TurnNumber);

      OutGameMove(CmdPipe.pipeF, RandomMoves[TurnNumber].B1, RandomMoves[TurnNumber].B2, RandomMoves[TurnNumber].R);

   };
};

     printf("Goodbye, World\n");

/*======*/
/* FINALLY */
/*======*/

/*printf("%i\n", TurnNumber);
getchar();*/

if (StatePipe.pipeF != InvalidPipe()) {
   ClosePipe(&StatePipe.pipeF);
};

if (CmdPipe.pipeF != InvalidPipe()) {
   ClosePipe(&CmdPipe.pipeF);
};

     return 0;
}


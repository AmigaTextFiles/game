
/*#################*/
/* ICPCPlayerLib.c */         /* 9.1.2011 */
/*#################*/

/*Copyright (C) 2010 Thomas Breeden, All Rights Reserved.
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

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "ICPCPlayerLib.h"

/*
gcc -c ICPCPlayerLib.c
*/

#define DEBUG         FALSE
#define DEBUGhndshk   FALSE
#define DEBUGinstate  FALSE

#define WhiteSpace " \t"

char      OneLine[1000],
          token[100];

PipeFile  InPipe,
          OutPipe;

static int dbg = 0;

/*-------------------------------------*/
 static void Assert(boolean b, char msg[])
/*-------------------------------------*/
{

if (!b) {
   fprintf(stderr, "%s\n", msg);
   assert(0);
}

}

/*----------------------------------------------------------------------*/
 static void NextToken(char s[], int len, char delims[], char token[], int* inx)
/*----------------------------------------------------------------------*/
             /* same behaviour as M2 procedure */
{
char* p;
boolean stepped;

/*printf("NextToken \"%s\"   %i   \"%s\"   \"%s\"   %i\n", s, len, delims, token, *inx);*/
/*printf("OneLine \"%s\"   %i\n", OneLine, strlen(OneLine));*/

if (*inx >= len) {
   /*printf("inx >= len\n");*/
   token[0] = '\0';
   /*printf("OneLine \"%s\"   %i\n", OneLine, strlen(OneLine));*/
   return;
}

*inx += strspn(&(s[*inx]), WhiteSpace);   /* strtok() won't let you know how many */

p = strtok(&(s[*inx]), WhiteSpace);
if (p != NULL) {

   /*printf("%s\n", p);*/

   strcpy(token, p);

   /*printf("%s\n", token);*/
   /*printf("OneLine \"%s\"   %i\n", OneLine, strlen(OneLine));*/

   *inx += (strlen(token));
   /*printf("inx %i  OneLine \"%s\"   %i\n", *inx, OneLine, strlen(OneLine));*/

   s[*inx] = delims[0];       /* ? */
   /*printf("inx %i  OneLine \"%s\"   %i\n", *inx, OneLine, strlen(OneLine));*/

   (*inx)++;
   /*printf("inx %i  OneLine \"%s\"   %i\n", *inx, OneLine, strlen(OneLine));*/

} else {

   token[0] = '\0';
   *inx = len;

}

} 
 
/*=============================================================*/
 void DebugReal(char msg[], int i, float r)
/*=============================================================*/

{

fprintf(stderr, "%s %6.2f   %i", msg, r, i);

} /*DebugReal*/

/*===============================================================*/
 void DebugReal2(char msg[], int i, float r1, float r2)
/*===============================================================*/

{

fprintf(stderr, "%s %6.2f %6.2f   %i", msg, r1, r2, i);

} /*DebugReal2*/

/*=============================*/
 void WriteLn(PipeFile f)
/*=============================*/

{

/*DEBUG*/Assert(WritePipe(f, LF), "WriteLn FAIL");
/*printf("\n");*/

} /*WriteLn*/

/*=================================================*/
 void WriteString(PipeFile f, char s[])
/*=================================================*/
{

/*DEBUG*/Assert(WriteStringPipe(f, s), "WriteString FAIL");
/*printf("%s", s);*/

} /*WriteString*/

/*========================================*/
 void WriteInt(PipeFile f, int i)
/*========================================*/

{
char  numstr[18];

sprintf(numstr, "%i", i);

WriteString(f, numstr);

} /*WriteInt*/

/*==========================================*/
 void WriteReal(PipeFile f, float r)
/*==========================================*/

{
char  numstr[18];

sprintf(numstr, "%6.2f", r);

WriteString(f, numstr);

} /*WriteReal*/

/*===========================================*/
 void WriteVector(PipeFile f, /*Vector*/float p[])
/*===========================================*/
{

WriteReal(f, p[X]);
WriteString(f, " ");
WriteReal(f, p[Y]);

} /*WriteVector*/

/*===================================================================================*/
 void OutGameMove(PipeFile f, /*Vector*/float Bump1Accel[], float Bump2Accel[], float SledTurn)
/*===================================================================================*/

{

WriteVector(f, Bump1Accel); WriteString(f, " ");            /* Writes here should probably include at least 2 digits right of decimal point */
WriteVector(f, Bump2Accel); WriteString(f, " ");
WriteReal(f, SledTurn);
WriteLn(f);

/*FlushPipe(pipeF); <<< careful, what is the definition of FlushPipe? */

/*if (DEBUGhndshk) { fprintf(stderr, "OutGameMove exit", 0); }*/
/*STextIO.WriteString("OutGameMove exit ");STextIO.WriteString(CmdPipe.pipeName); STextIO.WriteLn;*/

} /*OutGameMove*/

/*---------------------------------------------------------------*/
 static void NxtLine(int* inx)
/*---------------------------------------------------------------*/

{
boolean  bRes;

bRes = ReadPipeLine(InPipe, OneLine); 
Assert(bRes, "NxtLine?");

*inx = 0;

/*printf("NxtLine \"%s\"   %i\n", OneLine, strlen(OneLine));*/

} /*NxtLine*/

  /*
   Read requests may be satisfied not just when the entire amount of
   data requested has been read, but even when just one new byte
   has just been written to the pipe. In other words, reading from the
   pipe will not necessarily block until exactly the requested amount
   of data has become available for reading.

   You will read back a 0 (= EOF) on a pipe for which no more data
   will arrive because the last writer has closed it. If you are
   trying to read from a pipe to which no writer has yet sent any data
   your read request will block until the first data has been written
   to it (unless you opened the read pipe with the NOBLOCK option).
  */


/*-----------------------------------------------------------------*/
 static void ReadInt(int* inx, int* i)
/*-----------------------------------------------------------------*/

{
boolean cRes;

NextToken(OneLine, strlen(OneLine), WhiteSpace, token, inx);

if ((strlen(token) > 0) /*&& ()*/) {
   *i = atoi(token);
   cRes = T;
} else {
   cRes = F;
}

Assert(cRes, "ReadInt?");

} /*ReadInt*/

/*-------------------------------------------------------------------*/
 static void ReadReal(int* inx, float *r)
/*-------------------------------------------------------------------*/

{
double  dr;
boolean cRes;

/*printf("ReadReal1 %i \"%s\"\n", *inx, OneLine, strlen(OneLine));*/
NextToken(OneLine, strlen(OneLine), WhiteSpace, token, inx);
/*printf("Token %i   \"%s\"\n", *inx, token);*/
/*printf("ReadReal2 %i \"%s\"\n", *inx, OneLine, strlen(OneLine));*/

if ((strlen(token) > 0) /*&& ()*/) {
   *r = atof(token);
   cRes = T;
} else {
   cRes = F;
}

/*printf("cRes %i\n", cRes);*/

/*printf("ReadReal exit Oneline %i  \"%s\"  %i\n", *inx, OneLine, strlen(OneLine));*/

/*
if (dbg > 2){
getchar();
};
dbg++;
*/

/*printf("ReadReal return\n");*/
Assert(cRes, "ReadReal?");

} /*ReadReal*/

/*----------------------------------------------------------------------*/
 static void ReadColor(int* inx, GameColors* c)
/*----------------------------------------------------------------------*/

{
boolean cRes;

NextToken(OneLine, strlen(OneLine), WhiteSpace, token, inx);

if (strlen(token) == 1) {

   if (token[0] == '2') {
      *c = GreyColor;
   } else if (token[0] == '0') {
      *c = MyColor;
   } else if (token[0] == '1') {
      *c = HisColor;
   } else {
      Assert(F, "color?");
   }
   cRes = T;
} else {
   cRes = F;
}

} /*ReadColor*/

/*---------------------------------------------------------------------*/
 static void ReadVector(int* inx, float Val[])
/*---------------------------------------------------------------------*/

{
int     len;
boolean cRes;

len = strlen(OneLine);
/*printf("ReadVector  %i \"%s\"   %i\n", *inx, OneLine, strlen(OneLine));
printf("len %i\n", len);*/

/*NextToken(OneLine, len, WhiteSpace, token, inx);*/

ReadReal(inx, &(Val[0]));
/*printf("in ReadVector[0] %i \"%s\"   %i\n", *inx, OneLine, strlen(OneLine));*/

ReadReal(inx, &(Val[1]));
/*printf("in ReadVector[1] %i \"%s\"   %i\n", *inx, OneLine, strlen(OneLine));*/

/*printf("ReadVector exit inx %i  val[0] %f  val[1]  %f\n", *inx, Val[0], Val[1]);*/

} /*ReadVector*/

/*============================================================*/
 void ReadPuck(PuckInfoPtr Puck)
/*============================================================*/

{
int  inx;

NxtLine(&inx);
/*if (DEBUGhndshk) { fprintf(stderr, OneLine.str^, 0); }*/
/*printf("ReadPuck  %i \"%s\"   %i\n", inx, OneLine,  strlen(OneLine));*/

ReadVector(&inx, Puck->pos);

/*printf("%i \"%s\"\n", inx, OneLine);*/
/*printf("%f  %f\n", Puck->pos[0], Puck->pos[1]);*/

ReadVector(&inx, Puck->speed);
/*printf("%i \"%s\"\n", inx, OneLine);*/
/*printf("%f  %f\n", Puck->speed[0], Puck->speed[1]);*/

ReadColor(&inx, (GameColors*)(&(Puck->color)));
/*printf("%i\n", Puck->color);*/

} /*ReadPuck*/

/*============================================================*/
 void ReadBumper(BumperInfoPtr Bumper)
/*============================================================*/

{
int  inx;

NxtLine(&inx);

ReadVector(&inx, Bumper->pos);
ReadVector(&inx, Bumper->speed);

} /*ReadBumper*/

/*=====================================================*/
 void ReadSled(SledInfoPtr Sled)
/*=====================================================*/

{
int  i,
     inx;

NxtLine(&inx);

ReadVector(&inx, Sled->pos);
ReadReal(&inx, &(Sled->direct));

NxtLine(&inx);

ReadInt(&inx, &(Sled->TrailNumSegs));

for (i = 0; i < Sled->TrailNumSegs; i++) {
   ReadVector(&inx, Sled->Trail[i]);
}

} /*ReadSled*/

/*==========================================================================================================================*/
 void InGameState(PipeFile f, int* TurnNum, struct PuckInfo Pucks[], struct BumperInfo Bumpers[], struct SledInfo Sleds[])
/*==========================================================================================================================*/

{
int  i,
     inx;
int  NumPucksSent,
     NumBumpersSent,
     NumSledsSent;

/*if (DEBUGhndshk) { fprintf(stderr, "InGameState -> ", 0); }*/
/*STextIO.WriteString("InGameState -> "); STextIO.WriteString(StatePipe.pipeName); STextIO.WriteLn;*/

InPipe = f;

NxtLine(&inx);

ReadInt(&inx, TurnNum);
/*printf("TurnNum %i\n", *TurnNum);*/

/*fprintf(stderr, OneLine.str^, inx);*/
/*fprintf(stderr, token.str^, token.len);*/
/*fprintf(stderr, "Player LIB: TurnNum", TurnNum);*/

/*if (DEBUGhndshk) { fprintf(stderr, "FirstLine Read", TurnNum); }*/

NxtLine(&inx);
/*printf("%i \"%s\"\n", inx, OneLine);*/

ReadInt(&inx, &NumPucksSent);
Assert(NumPucksSent == NumPucks, "NumPucksSent?");

/*if (DEBUGhndshk) { fprintf(stderr, "SecondLine Read", NumPucks); }*/

for (i = 0; i < NumPucks; i++) {
   ReadPuck(&(Pucks[i]));
}

NxtLine(&inx);
ReadInt(&inx, &NumBumpersSent);
Assert(NumBumpersSent == NumBumpers, "NumBumpersSent?");

for (i = 0; i < NumBumpers; i++) {
   ReadBumper(&(Bumpers[i]));
}

NxtLine(&inx);
ReadInt(&inx, &NumSledsSent);
Assert(NumSledsSent == NumSleds, "NumSledsSent?");

for (i = 0; i < NumSleds; i++) {
   ReadSled(&(Sleds[i]));
      /*if (dbg > 2){*/
   /*getchar();*/
   /*};*/
   /*dbg++;*/
}

/*DEBUG*/
/*INC(TurnNum);*/
/*if (TurnNum >= 900) {
   TurnNum = -1;
}*/

/*if (DEBUGhndshk) {  fprintf(stderr, "InGameState exit -> ", 0); }*/

} /*InGameState*/



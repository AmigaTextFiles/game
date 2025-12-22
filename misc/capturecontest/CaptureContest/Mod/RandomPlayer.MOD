
(*##################*)
 MODULE RandomPlayer;        (* $VER: RandomPlayer.MOD 0.0 (30.1.2011) *)
(*##################*)
(*

    Generate bumper and sled moves in a random manner.

NOTE: RandomPlayer pays no attention to the game state, so it can generate all 900 of its moves before
      starting the game. ie, it has no overhead in calculating its next move during the game.

      All timing is handled by the synchronous reading of the game state.

*)

(*
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
*)

FROM Storage    IMPORT ALLOCATE;
IMPORT SymbolsRTS;
FROM Assertions IMPORT Assert;
FROM Debugging  IMPORT Debug, DebugOn, DebugPause;

FROM ChanConsts IMPORT OpenResults;
IMPORT STextIO, SWholeIO;

FROM CaptureSpecs  IMPORT BumperIndices, GameColors, HisBumperIndices, LineSeg, MaxBumperVelocity, MyBumperIndices,
                          TrailMaxPoints;
FROM PlayerLib IMPORT BumperInfo, BumpersArray, CR,
                      PipeInfo, PuckInfo, PucksArray, SledInfo, SledsArray, Point, XY,
                      InGameState, DebugReal,
                      OutGameMove;
 
FROM ArgsSupport     IMPORT AllocParamsArray, DisposeParamsArray, ParamsArrayPtr, ProcessCLI;
FROM Break           IMPORT TstBreak;
FROM DynStr0         IMPORT DynStr;
FROM PipeIO          IMPORT ClosePipe, InvalidPipe, OpenModes, OpenPipe, PipeFile, SetReadTimeout;
FROM RandomNumbers   IMPORT Random;
IMPORT DynStr0, DynStr1, Str0, Str1, Str2;

CONST  PgmName = "RandomPlayer";
       PgmVersion = "$VER: RandomPlayer (30.1.2011) M2";

CONST  PgmTemplate = "-CmdPipeName=-cp/K,-StatePipeName=-sp/K";
TYPE   PgmCmds     = (CmdPipeNameCmd, StatePipeNameCmd);

CONST DEBUG        = FALSE;
      DEBUGcomm    = FALSE;
      DEBUGhndshk  = FALSE;
      DEBUGTurnSeq = FALSE;

CONST BumperRadius         =   8.0;
      PuckRadius           =   5.0;

CONST BaseTime1 = 75;
      BaseTime2 = 100;

CONST PipeTimeOut = 200(*10000*); (*DEBUG*)

VAR  StatePipe     :PipeInfo;
     CmdPipe       :PipeInfo;
     CmdPipeName,
     StatePipeName :Str0.String32;

VAR  Factor1,
     Factor2       :REAL;
     Factor1Time,
     Factor2Time   :INTEGER;
     Bump1Accel,
     Bump2Accel    :Point;
     SledTurn      :REAL;

TYPE OneMove   = RECORD
                   B1,
                   B2  :Point;
                   S   :REAL
                 END;

VAR  RandomMoves   :ARRAY [0..1000] OF OneMove;

     Pucks         :PucksArray;
     Bumpers       :BumpersArray;
     Sleds         :SledsArray;

     TurnNum       :INTEGER;

VAR  OneLine,
     token         :DynStr;

     bRes          :BOOLEAN;

(*----------------------------*)
 PROCEDURE Random1():REAL;
(*----------------------------*)

VAR  iFrac  :INTEGER;

BEGIN

iFrac := INT((Random(200000000) DIV 100) MOD 100) - 50;

RETURN FLOAT(iFrac) / 100.0;

END Random1;

(*-----------------*)
 PROCEDURE InitPgm;
(*-----------------*)

BEGIN

TurnNum := 0;
CmdPipeName := "";
StatePipeName := "";

Factor1 := 1.0;
Factor2 := -1.0;
Factor1Time := BaseTime1 + (Random(5) - 2);
Factor2Time := BaseTime2 + (Random(11) - 5);

SledTurn := Factor1*0.25;
Bump1Accel[X] := Factor1*1.0;
Bump1Accel[Y] := Factor1*0.5;
Bump2Accel[X] := Factor2*0.4;
Bump2Accel[Y] := Factor2*1.0;

END InitPgm;

(*---------------------------------------------------------------*)
 PROCEDURE GetArgs(VAR CmdPipeName, StatePipeName:Str0.String32);
(*---------------------------------------------------------------*)

VAR  PgmArgs   :ParamsArrayPtr;
     dTemplate :DynStr;
     bRes      :BOOLEAN;

BEGIN

DynStr0.dStrInC(PgmTemplate, dTemplate);
AllocParamsArray(dTemplate, PgmArgs);

bRes := ProcessCLI(PgmTemplate, PgmArgs^);
Assert(bRes, "Bad CLI Params");

IF PgmArgs^[ORD(CmdPipeNameCmd)].Given THEN
   DynStr0.dStrOut(PgmArgs^[ORD(CmdPipeNameCmd)].Val.vs, CmdPipeName);
END;

IF PgmArgs^[ORD(StatePipeNameCmd)].Given THEN
   DynStr0.dStrOut(PgmArgs^[ORD(StatePipeNameCmd)].Val.vs, StatePipeName);
END;

DisposeParamsArray(dTemplate, PgmArgs);
DynStr0.dStrDispose(dTemplate);

END GetArgs;

(*-------------------*)
 PROCEDURE InitPipes;
(*-------------------*)

VAR PipeNameAndBuffer :Str0.String80;
    oRes              :OpenResults;

BEGIN

WITH StatePipe DO
   pipeF := InvalidPipe();
   pipeName := StatePipeName;
   Str1.StrCap(StatePipeName);
   IF Str1.StrPos(StatePipeName, "PIPE:", 0) = 0 THEN
      Str1.StrSeg(pipeName, 5, 32767, pipeName);
   END;
END;

WITH CmdPipe DO
   pipeF := InvalidPipe();
   pipeName := CmdPipeName;
   Str1.StrCap(CmdPipeName);
   IF Str1.StrPos(CmdPipeName, "PIPE:", 0) = 0 THEN
      Str1.StrSeg(pipeName, 5, 32767, pipeName);
   END;
END;

IF DEBUGcomm THEN DebugOn(0); DebugPause(StatePipe.pipeName, 0); END;
WITH StatePipe DO
   Str0.StrAsg(pipeName, PipeNameAndBuffer);
   Str1.StrCat("/8192", PipeNameAndBuffer);
   pipeF := OpenPipe(PipeNameAndBuffer, PipeModeRead, oRes);
   Assert(oRes = opened, "OpenPipe for read FAIL");
   SetReadTimeout(pipeF, PipeTimeOut); (* 200 msec *)
END;

IF DEBUGcomm THEN DebugOn(0); DebugPause(CmdPipe.pipeName, 0); END;
WITH CmdPipe DO
   pipeF := OpenPipe(pipeName, PipeModeWrite, oRes);
   Assert(oRes = opened, "OpenPipe for write FAIL");
END;

IF DEBUGcomm THEN DebugPause("RandomPlayer pipes opened", 0); END;

END InitPipes;

(*--------------------------------------*)
 PROCEDURE CalcGameMove(TurnNum:INTEGER);
(*--------------------------------------*)
BEGIN

IF TurnNum MOD Factor1Time = 0 THEN
   (*DebugOn(0); DebugPause("reverse Factor1", 0);*)
   IF ODD(Random(2)) THEN
      Factor1 := 1.0 + Random1();
   ELSE
      Factor1 := -(1.0 + Random1());
   END;
   (*DebugReal("Factor1", 0, Factor1);*)
   Bump1Accel[X] := Factor1*1.0;
   Bump1Accel[Y] := Factor1*0.5;
   SledTurn := Factor1 * (3.141592/16.0);
   (*DebugReal("SledTurn", 0, SledTurn);*)
   Factor1Time := BaseTime1 + (Random(5) - 2);
END;

IF TurnNum MOD Factor2Time = 0 THEN
   (*DebugOn(0); DebugPause("reverse Factor2", 0);*)
   IF ODD(Random(2)) THEN
      Factor2 := 1.0 + Random1();
   ELSE
      Factor2 := -(1.0 + Random1());
   END;
   (*DebugReal("Factor2", 0, Factor2);*)
   Bump2Accel[X] := Factor2*0.4;
   Bump2Accel[Y] := Factor2*1.0;
   Factor2Time := BaseTime2 + (Random(11) - 5);
END;

(*SledTurn := (Factor1+Random1())*0.25;*)

(*
Bump1Accel[X] := Factor1*1.0;
Bump1Accel[Y] := Factor1*0.5;
Bump2Accel[X] := Factor2*0.4;
Bump2Accel[Y] := Factor2*1.0;
*)

END CalcGameMove;

(*----------------------------*)
 PROCEDURE PreCalcRandomMoves;
(*----------------------------*)

VAR  i :INTEGER;

BEGIN

FOR i := 0 TO 900 DO
   CalcGameMove(i);
   RandomMoves[i].B1 := Bump1Accel;
   RandomMoves[i].B2 := Bump2Accel;
   RandomMoves[i].S := SledTurn;
END;

END PreCalcRandomMoves;

(*----------------*)
 BEGIN (* program *)
(*----------------*)

(*DebugOn(0);*)
(*DebugPause("RandomPlayer", 0);*)

InitPgm;

GetArgs(CmdPipeName, StatePipeName);
IF DEBUG THEN DebugOn(0); DebugPause(CmdPipeName, 0); DebugPause(StatePipeName, 0); END;

PreCalcRandomMoves;

InitPipes;

(*Assert(StartATimer(timer, 0(*secs*), 100000(* 0.1 secs *), sig), "StartATimer FAIL");  (* Make sure to do the first one, even if pause *)*)

WHILE (TurnNum # -1) AND NOT TstBreak() DO

   InGameState(StatePipe.pipeF, TurnNum, Pucks, Bumpers, Sleds);
   IF DEBUGTurnSeq THEN (*STextIO.WriteChar(CR);*) STextIO.WriteString("Randomplayer: "); SWholeIO.WriteInt(TurnNum, 3); STextIO.WriteLn; END;

   IF TurnNum # -1 THEN

      (*CalcGameMove;*)

      OutGameMove(CmdPipe.pipeF, RandomMoves[TurnNum].B1, RandomMoves[TurnNum].B2, RandomMoves[TurnNum].S);

   END;

END;

(*Assert(WaitATimer(timer, SignalSet{}(*AdditionalSignals*), ResultSignals), "WaitATimer FAIL");*)

(*======*)
 FINALLY
(*======*)

(*DebugOn(0);*)
(*DebugPause("RandomPlayer FINALLY", 0);*)

IF StatePipe.pipeF # InvalidPipe() THEN
   ClosePipe(StatePipe.pipeF);
END;

IF CmdPipe.pipeF # InvalidPipe() THEN
   ClosePipe(CmdPipe.pipeF);
END;

END RandomPlayer.


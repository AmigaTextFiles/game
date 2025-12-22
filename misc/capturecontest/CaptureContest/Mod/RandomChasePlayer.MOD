
(*########################*)
 MODULE RandomChasePlayer;        (* $VER: RandomChasePlayer.MOD 0.0 (31.10.2010) *)
(*########################*)

(*
   Sled runs randomly.

   Bumpers simply chase the opponents bumpers around.

         NOTE: 1. All timing is handled by the synchronous reading of the game state.
*)

(*Copyright (C) 2010 Thomas Breeden, All Rights Reserved.
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
FROM RealMath   IMPORT sqrt;
IMPORT STextIO, SWholeIO;

(*FROM Tasks         IMPORT SignalRange, SignalSet;*)

FROM CaptureSpecs IMPORT MaxBumperVelocity (*, TrailMaxPoints*);
FROM PlayerLib    IMPORT (*BumperIndices,*) BumperInfo, BumpersArray, CR, GameColors, (*HisBumperIndices,*) LF, LineSeg,
                         (*MyBumperIndices,*) PipeInfo, PuckInfo, PucksArray, SledInfo, SledsArray,
                         Point, XY,
                         InGameState, DebugReal,
                         OutGameMove;

FROM ArgsSupport     IMPORT AllocParamsArray, DisposeParamsArray, ParamsArrayPtr, ProcessCLI;
(*FROM AmigaTimer      IMPORT CloseATimer, NullTimerHandle, OpenATimer, StartATimer,*)
(*                            TestATimer, TimerHandle, WaitATimer;*)
FROM Break           IMPORT TstBreak;
FROM DynStr0         IMPORT DynStr;
FROM PipeIO          IMPORT ClosePipe, InvalidPipe, OpenModes, OpenPipe, PipeFile, SetReadTimeout;
FROM RandomNumbers   IMPORT Random;
IMPORT DynStr0, DynStr1, Str0, Str1, Str2;

CONST  PgmName = "RandomChasePlayer";
       PgmVersion = "$VER: RandomChasePlayer 0.0 (31.10.2010)";

CONST  PgmTemplate = "-CmdPipeName=-cp/K,-StatePipeName=-sp/K";
TYPE   PgmCmds     = (CmdPipeNameCmd, StatePipeNameCmd);

CONST DEBUG        = FALSE;
      DEBUGcomm    = FALSE;
      DEBUGhndshk  = FALSE;
      DEBUGTurnSeq = FALSE;

CONST BaseTime1 = 75;
      BaseTime2 = 100;

CONST PipeTimeOut = 200(*10000*); (*DEBUG*)

VAR  StatePipe     :PipeInfo;
     CmdPipe       :PipeInfo;
     CmdPipeName,
     StatePipeName :Str0.String32;

VAR  Factor1       :REAL;
     Factor1Time   :INTEGER;
     Bump1Accel,
     Bump2Accel    :Point;
     SledTurn      :REAL;

     Pucks         :PucksArray;
     Bumpers       :BumpersArray;
     Sleds         :SledsArray;

     TurnNum       :INTEGER;

(*VAR  timer         :TimerHandle;*)
(*     sig           :SignalRange;*)
(*     ResultSignals :SignalSet;*)

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

(*timer := NullTimerHandle;*)
(*Assert(OpenATimer(timer, 0(*UnitMicroHz*)), "OpenATimer FAIL");*)

TurnNum := 0;
CmdPipeName := "";
StatePipeName := "";

Factor1 := 1.0;
Factor1Time := BaseTime1 + (Random(5) - 2);

SledTurn := Factor1*0.25;
Bump1Accel[X] := Factor1*1.0;
Bump1Accel[Y] := Factor1*0.5;
Bump2Accel[X] := 0.0;
Bump2Accel[Y] := 0.0;

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

IF DEBUGcomm THEN DebugPause("RandomChasePlayer pipes opened", 0); END;

END InitPipes;

(*----------------------------------*)
 PROCEDURE sqr(a:REAL):REAL;
(*----------------------------------*)
BEGIN

RETURN a*a;

END sqr;

(*---------------------------------*)
 PROCEDURE sgn(a:REAL):REAL;
(*---------------------------------*)
BEGIN

IF a < 0.0 THEN
   RETURN -1.0;
END;

RETURN 1.0;

END sgn;

(*-------------------------------------------------------------------------------*)
 PROCEDURE NewVelocityToComponents(Velocity:REAL; VAR xComp, yComp:REAL);
(*-------------------------------------------------------------------------------*)

VAR  ratio :REAL;

BEGIN

IF Velocity # 0.0 THEN

   IF xComp = 0.0 THEN
      yComp := sgn(yComp) * Velocity;
   ELSIF yComp = 0.0 THEN
      xComp := sgn(xComp) * Velocity;
   ELSE
      ratio := ABS(yComp/xComp);
      xComp := sgn(xComp) * Velocity / sqrt(1.0+sqr(ratio));
      yComp := sgn(yComp) * ABS(xComp) * ratio;
   END;

ELSE

   xComp := 0.0;
   yComp := 0.0;

END;

END NewVelocityToComponents;

(*
(*-----------------------------------------------------------------------------*)
 PROCEDURE LimitVeloc(VAR xSpeed, ySpeed:REAL; MaxVeloc:REAL):REAL;
(*-----------------------------------------------------------------------------*)

VAR  velocReturn :REAL;

BEGIN

velocReturn := sqrt(sqr(xSpeed)+sqr(ySpeed));

IF velocReturn > MaxVeloc THEN

   velocReturn := MaxVeloc;

   NewVelocityToComponents(velocReturn, xSpeed, ySpeed);

END;

RETURN velocReturn;

END LimitVeloc;
*)

(*---------------------*)
 PROCEDURE CalcGameMove;
(*---------------------*)

VAR  i      :INTEGER;
     found  :BOOLEAN;

BEGIN

IF TurnNum MOD Factor1Time = 0 THEN
   (*DebugOn(0); DebugPause("reverse Factor1", 0);*)
   IF ODD(Random(2)) THEN
      Factor1 := 1.0 + Random1();
   ELSE
      Factor1 := -(1.0 + Random1());
   END;
   (*DebugReal("Factor1", 0, Factor1);*)
   SledTurn := Factor1 * (3.141592/16.0);
   (*DebugReal("SledTurn", 0, SledTurn);*)
   Factor1Time := BaseTime1 + (Random(5) - 2);
END;

      (* --------------------------------------- *)

Bump1Accel[X] := (Bumpers[2].pos[X] - Bumpers[0].pos[X]);
Bump1Accel[Y] := (Bumpers[2].pos[Y] - Bumpers[0].pos[Y]);
NewVelocityToComponents(MaxBumperVelocity/3.0, Bump1Accel[X], Bump1Accel[Y]);  (* ? pursue at the max speed *)
Bump1Accel[X] := Bump1Accel[X] - Bumpers[0].speed[X];                      (* change speed on a dime *)
Bump1Accel[Y] := Bump1Accel[Y] - Bumpers[0].speed[Y];

Bump2Accel[X] := (Bumpers[3].pos[X] - Bumpers[1].pos[X]);
Bump2Accel[Y] := (Bumpers[3].pos[Y] - Bumpers[1].pos[Y]);
NewVelocityToComponents(MaxBumperVelocity, Bump2Accel[X], Bump2Accel[Y]);  (* pursue at the max speed *)
Bump2Accel[X] := Bump2Accel[X] - Bumpers[1].speed[X];
Bump2Accel[Y] := Bump2Accel[Y] - Bumpers[1].speed[Y];

END CalcGameMove;

(*----------------*)
 BEGIN (* program *)
(*----------------*)

(*DebugOn(0);*)
(*DebugPause("RandomChasePlayer", 0);*)

InitPgm;

GetArgs(CmdPipeName, StatePipeName);
IF DEBUG THEN DebugOn(0); DebugPause(CmdPipeName, 0); DebugPause(StatePipeName, 0); END;

InitPipes;

(*Assert(StartATimer(timer, 0(*secs*), 50000(*> 0.1 secs*), sig), "StartATimer FAIL");*)

WHILE (TurnNum # -1) AND NOT TstBreak() DO

   InGameState(StatePipe.pipeF, TurnNum, Pucks, Bumpers, Sleds);
   IF DEBUGTurnSeq THEN STextIO.WriteChar(CR); SWholeIO.WriteInt(TurnNum, 3); END;

   IF TurnNum # -1 THEN

      CalcGameMove;

      (*Assert(WaitATimer(timer, SignalSet{}(*AdditionalSignals*), ResultSignals), "WaitATimer FAIL");*)

      OutGameMove(CmdPipe.pipeF, Bump1Accel, Bump2Accel, SledTurn);

      (*Assert(StartATimer(timer, 0(*secs*), 50000(*>0.1 secs*), sig), "StartATimer FAIL");*)

   END;

END;

(*Assert(WaitATimer(timer, SignalSet{}(*AdditionalSignals*), ResultSignals), "WaitATimer FAIL");*)

(*======*)
 FINALLY
(*======*)

(*DebugOn(0);*)
(*DebugPause("RandomChasePlayer FINALLY", 0);*)

(*IF timer # NullTimerHandle THEN*)
(*   bRes := CloseATimer(timer);*)
(*END;*)

IF StatePipe.pipeF # InvalidPipe() THEN
   ClosePipe(StatePipe.pipeF);
END;

IF CmdPipe.pipeF # InvalidPipe() THEN
   ClosePipe(CmdPipe.pipeF);
END;

END RandomChasePlayer.



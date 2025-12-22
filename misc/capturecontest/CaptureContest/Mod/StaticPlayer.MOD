
(*##################*)
 MODULE StaticPlayer;        (* $VER: StaticPlayer.MOD 0.0 (17.1.2011) *)
(*##################*)

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
IMPORT IOChan, SeqFile, StdChans, STextIO, SWholeIO;

FROM Tasks         IMPORT SignalRange, SignalSet;

FROM CaptureSpecs  IMPORT BumperIndices, HisBumperIndices, MyBumperIndices, TrailMaxPoints;
FROM PlayerLib     IMPORT BumperInfo, BumpersArray, CR, GameColors,
                          PipeInfo, PuckInfo, PucksArray, SledInfo, SledsArray, Point, XY,
                          InGameState, DebugReal,
                          OutGameMove;
 
FROM ArgsSupport     IMPORT AllocParamsArray, DisposeParamsArray, ParamsArrayPtr, ProcessCLI;
FROM Break           IMPORT TstBreak;
FROM DynStr0         IMPORT DynStr;
FROM PipeIO          IMPORT ClosePipe, InvalidPipe, OpenModes, OpenPipe, PipeFile, SetReadTimeout;
IMPORT DynStr0, DynStr1, Str0, Str1, Str2;

CONST  PgmName = "StaticPlayer";
       PgmVersion = "$VER: StaticPlayer 0.0 (17.1.2011)";

CONST  PgmTemplate = "-CmdPipeName=-cp/K,-StatePipeName=-sp/K";
TYPE   PgmCmds     = (CmdPipeNameCmd, StatePipeNameCmd);

CONST DEBUG        = FALSE;
      DEBUGcomm    = FALSE;
      DEBUGhndshk  = FALSE;
      DEBUGTurnSeq = FALSE;
      DEBUGinstate = FALSE;

CONST PipeTimeOut = 200(*10000*); (*DEBUG*)

VAR  StatePipe     :PipeInfo;
     CmdPipe       :PipeInfo;
     CmdPipeName,
     StatePipeName :Str0.String32;

     dbgFile       :SeqFile.ChanId;
     oRes          :OpenResults;

VAR  Bump1Accel,
     Bump2Accel    :Point;
     SledTurn      :REAL;

     Pucks         :PucksArray;
     Bumpers       :BumpersArray;
     Sleds         :SledsArray;

     TurnNum       :INTEGER;

VAR  OneLine,
     token         :DynStr;

     bRes          :BOOLEAN;

(*-----------------*)
 PROCEDURE InitPgm;
(*-----------------*)

BEGIN

TurnNum := 0;
CmdPipeName := "";
StatePipeName := "";

SledTurn := 0.0;
Bump1Accel[X] := 0.0;
Bump1Accel[Y] := 0.0;
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
   Str1.StrCat("/8192"(*"/1024/50"*), PipeNameAndBuffer);
   (*DebugOn(0); DebugPause(PipeNameAndBuffer, 0);*)
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

(*---------------------*)
 PROCEDURE CalcGameMove;
(*---------------------*)
BEGIN

END CalcGameMove;

(*----------------*)
 BEGIN (* program *)
(*----------------*)

(*DebugOn(0);*)
(*DebugPause("StaticPlayer", 0);*)

InitPgm;

GetArgs(CmdPipeName, StatePipeName);
IF DEBUG THEN DebugOn(0); DebugPause(CmdPipeName, 0); DebugPause(StatePipeName, 0); END;
IF DEBUGinstate THEN
   SeqFile.OpenWrite(dbgFile, StatePipeName, SeqFile.old, oRes);
   Assert(oRes = opened, "dbgFile openwrite fail");
   StdChans.SetOutChan(dbgFile);
END;

InitPipes;

WHILE (TurnNum # -1) AND NOT TstBreak() DO

   InGameState(StatePipe.pipeF, TurnNum, Pucks, Bumpers, Sleds);
   IF DEBUGTurnSeq THEN STextIO.WriteChar(CR); SWholeIO.WriteInt(TurnNum, 3); STextIO.WriteLn; END;

   IF TurnNum # -1 THEN

      CalcGameMove;

      OutGameMove(CmdPipe.pipeF, Bump1Accel, Bump2Accel, SledTurn);

   END;

END;

(*======*)
 FINALLY
(*======*)

(*DebugOn(0);*)
(*DebugPause("StaticPlayer FINALLY", 0);*)
IF DEBUGinstate THEN
   SeqFile.Close(dbgFile);
END;

IF StatePipe.pipeF # InvalidPipe() THEN
   ClosePipe(StatePipe.pipeF);
END;

IF CmdPipe.pipeF # InvalidPipe() THEN
   ClosePipe(CmdPipe.pipeF);
END;

END StaticPlayer.



(*#####################*)
 MODULE CapturePlayback;        (* $VER: CapturePlayback.MOD 0.0 (30.4.2011) *)
(*#####################*)

FROM SYSTEM         IMPORT ADDRESS, ADR;
IMPORT SymbolsRTS;
FROM Assertions     IMPORT Assert, AssertWarn;
FROM Debugging      IMPORT Debug, DebugOff, DebugOn, DebugPause, IsDebugOn;

IMPORT SWholeIO, STextIO;

FROM Tasks           IMPORT SignalRange, SignalSet;

FROM CaptureSpecs    IMPORT BumperObjsDesc, GameColors,
                            NumPucks, NumSleds, PuckObjsDesc,
                            Point, SledObjsDesc;

FROM CaptureGraphics IMPORT curBuf, DrawBumper, DrawBumpers, DrawPuck, DrawPucks, DrawSleds, GameRgn,
                            GameScr, InitGameScreen, ShowNextFrame, SwapDrawingBuffers;
FROM TraceFileIO     IMPORT CloseInFile, GetNextState, OpenInFile;

FROM AmigaTimer     IMPORT CloseATimer, NullTimerHandle, OpenATimer, SleepATimer, StartATimer, GetSysTime,
                           TestATimer, TimerFlavors, TimerHandle, WaitATimer;
FROM ArgsSupport    IMPORT AllocParamsArray, DisposeParamsArray, ParamsArrayPtr, ProcessCLI;
FROM Break          IMPORT TstBreak;
FROM DynStr0        IMPORT DynStr;
FROM SimpleGraphics IMPORT XY;

IMPORT DynStr0, DynStr1, DynStr3;

CONST  PgmName = "CapturePlayback";
       PgmVersion = "$VER: 0.0 (30.4.2011)";

CONST  PgmTemplate = "-InFile/A,-Pause/S";
TYPE   PgmCmds     = (InFileCmd, PauseCmd);

CONST  DEBUG        = FALSE;
       DEBUGspeed   = FALSE;
       DEBUGTurnSeq = FALSE;
       DEBUGTRACE   = FALSE;

VAR  InFileName      :DynStr;

     timer           :TimerHandle;
     timerSecs,
     timerMicros     :CARDINAL;
     i               :INTEGER;

     sig             :SignalRange;
     ResultSignals   :SignalSet;

     elapsedSecs,
     elapsedMicros   :ARRAY[0..1] OF CARDINAL;

     Time            :REAL;
     Pucks           :PuckObjsDesc;
     Bumpers         :BumperObjsDesc;
     Sleds           :SledObjsDesc;

     PauseMode,
     FrameByFrame    :BOOLEAN;
     doExit          :BOOLEAN;
     bRes            :BOOLEAN;

(*-----------------*)
 PROCEDURE InitPgm;
(*-----------------*)

BEGIN

timer := NullTimerHandle;
Assert(OpenATimer(timer, WaitUntilSys(*MicroHz*)), "OpenATimer FAIL");

PauseMode := FALSE;
doExit := FALSE;
FrameByFrame := FALSE;

elapsedSecs[0] := 0; elapsedSecs[1] := 0;
elapsedMicros[0]:= 0; elapsedMicros[1]:= 0;

DynStr0.dStrCreate(InFileName, 80);

END InitPgm;

(*--------------------------------------------------------------*)
 PROCEDURE GetArgs(VAR InFileName:DynStr; VAR PauseMode:BOOLEAN);
(*--------------------------------------------------------------*)

VAR  PgmArgs   :ParamsArrayPtr;
     dTemplate :DynStr;
     bRes      :BOOLEAN;

BEGIN

DynStr0.dStrInC(PgmTemplate, dTemplate);
AllocParamsArray(dTemplate, PgmArgs);

bRes := ProcessCLI(PgmTemplate, PgmArgs^);
Assert(bRes, "Bad CLI Params");

DynStr3.dStrAsgE(PgmArgs^[ORD(InFileCmd)].Val.vs, InFileName);

IF PgmArgs^[ORD(PauseCmd)].Given THEN
   PauseMode := TRUE;
END;

DisposeParamsArray(dTemplate, PgmArgs);
DynStr0.dStrDispose(dTemplate);

END GetArgs;

(*----------------------*)
 PROCEDURE ReportResult;
(*----------------------*)

VAR  i        :INTEGER;
     BlueCnt,
     RedCnt   :INTEGER;

BEGIN

RedCnt := 0;
BlueCnt := 0;

(* assuming the trace file ended correctly *)
FOR i := 0 TO NumPucks-1 DO
   IF Pucks[i].color = RedPlayer THEN
      INC(RedCnt);
   ELSIF Pucks[i].color = BluePlayer THEN
      INC(BlueCnt);
   END;
END;

STextIO.WriteLn;
STextIO.WriteString("Red  ="); SWholeIO.WriteInt(RedCnt, 4); STextIO.WriteLn;
STextIO.WriteString("Blue ="); SWholeIO.WriteInt(BlueCnt, 4); STextIO.WriteLn;

elapsedSecs[0] := elapsedSecs[1] - elapsedSecs[0];
IF elapsedMicros[1] < elapsedMicros[0] THEN
   DEC(elapsedSecs[0]);
   elapsedMicros[0] := 1000000 - elapsedMicros[0] + elapsedMicros[1];
ELSE
   elapsedMicros[0] := elapsedMicros[1] - elapsedMicros[0];
END;

SWholeIO.WriteCard(elapsedSecs[0], 1); STextIO.WriteString("."); SWholeIO.WriteCard(elapsedMicros[0] DIV 100000, 1);
STextIO.WriteString(" secs elapsed"); STextIO.WriteLn;

END ReportResult;

(*----*)
 BEGIN
(*----*)
(*DebugOn(0);*)

InitPgm;

GetArgs(InFileName, PauseMode);
FrameByFrame := PauseMode;

bRes := OpenInFile(InFileName);

InitGameScreen;

Assert(GetNextState(Time, Pucks, Bumpers, Sleds), "CapturePlayback: GetNextState FAIL");
IF DEBUG THEN DebugPause("after First GetNextState", 0); END;

DrawBumpers(Bumpers);
DrawPucks(Pucks);
DrawSleds(Sleds);

ShowNextFrame;

IF DEBUG THEN DebugOn(0); DebugPause("READY", 0); END;

GetSysTime(elapsedSecs[0], elapsedMicros[0]);

LOOP

   (* read ahead in the Trace file *)
   IF NOT GetNextState(Time, Pucks, Bumpers, Sleds) THEN
      EXIT;
   END;

   timerSecs :=   TRUNC(Time)/1000 + elapsedSecs[0];
   timerMicros := TRUNC(1000.0*Time) MOD 1000000 + elapsedMicros[0];
   IF timerMicros > 1000000 THEN
      DEC(timerMicros, 1000000);
      INC(timerSecs);
   END;

   Assert(StartATimer(timer, timerSecs, timerMicros, sig), "StartATimer FAIL");      (* WaitUntil flavor *)

   SwapDrawingBuffers;

   DrawBumpers(Bumpers);
   DrawPucks(Pucks);
   DrawSleds(Sleds);

   Assert(WaitATimer(timer, SignalSet{}(*AdditionalSignals*), ResultSignals), "WaitATimer FAIL");

   ShowNextFrame;

   (*IF PauseMode THEN
      DebugPause("Pause after upd", 0); DebugOff;
   ELS*)IF FrameByFrame THEN
      DebugOn(0); DebugPause("Frame", 0);
      FrameByFrame := IsDebugOn();
   END;

   IF DEBUG THEN Debug("Before TstBreak", 0); END;
   IF TstBreak() THEN
      EXIT;
   END;

   IF DEBUG THEN DebugPause("bottom of LOOP", 0); END;
END;

GetSysTime(elapsedSecs[1], elapsedMicros[1]);

ReportResult;

DebugOn(0); DebugPause("Fin", 0);

(*------*)
 FINALLY
(*------*)

IF DEBUG THEN DebugPause("FINALLY", 0); END;

IF timer # NullTimerHandle THEN
   bRes := CloseATimer(timer);
END;

bRes := CloseInFile();

END CapturePlayback.


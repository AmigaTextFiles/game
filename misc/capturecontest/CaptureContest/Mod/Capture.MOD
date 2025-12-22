
(*#################*)
 MODULE Capture;        (* $VER: Capture.MOD 0.0 (9.2.2011) *)
(*#################*)

FROM SYSTEM         IMPORT ADDRESS, ADR;
IMPORT SymbolsRTS;
FROM Assertions     IMPORT Assert, AssertWarn;
FROM Debugging      IMPORT Debug, DebugOff, DebugOn, DebugPause, IsDebugOn;

FROM RealMath        IMPORT round;
IMPORT SWholeIO, STextIO;

FROM Tasks           IMPORT SignalRange, SignalSet;

FROM CaptureDefs     IMPORT BluePlayerExe, CollideObj, DisplayMillis, DisplayNum,
                            (*InteractiveMode,*) MovingObjects, PauseMode, QuietMode, RedPlayerExe,
                            Sleds, StepMillis, StepNum,
                            StepsPerDisplay, StepsPerTurn, TraceFileName,
                            TurnMillis, TurnNum, TurnsPerGame;
FROM CaptureSpecs    IMPORT BlueSledIndex, BumperIndices, GameColors, GamePlayers, NumPucks, NumSleds, Point,
                            RedSledIndex;
FROM CaptureEngine   IMPORT AccelBumper, DoSledLoop, FollowObjects, InitEngine, InitStepState, ReflectDirection,
                            RemoveSledLoop, TstSledLoop, TurnSled, StepSled;
FROM CaptureGraphics IMPORT curBuf, DrawBumper, DrawBumpers, DrawPuck, DrawPucks, DrawSleds,
                            GameRgn, GameScr, InitGameScreen, ShowNextFrame;
FROM CapturePlayerIO IMPORT InGameMoves, InitPlayerIO, OutGameState;
FROM CaptureDebug    IMPORT PrintMsg;
FROM TraceFileIO     IMPORT CloseOutFile, OpenOutFile, PutNextState;

FROM AmigaTimer     IMPORT CloseATimer, NullTimerHandle, OpenATimer, SleepATimer, StartATimer, GetSysTime,
                           TestATimer, TimerFlavors, TimerHandle, WaitATimer;
FROM ArgsSupport    IMPORT AllocParamsArray, DisposeParamsArray, ParamsArrayPtr, ProcessCLI;
FROM Break          IMPORT TstBreak;
FROM DynStr0        IMPORT DynStr;
FROM SimpleGraphics IMPORT ExtentType, GREENscr, lohi, XY;

IMPORT DynStr0, DynStr1, DynStr3;

CONST  PgmName = "Capture";
       PgmVersion = "$VER: Capture 0.0 (9.2.2011)";

CONST  PgmTemplate = "-RedPlayer=-Red,-BluePlayer=-Blue,-Quiet/S,-TraceFile,-Pause/S,-TurnMillis/N/K,-StepMillis/N/K,-DisplayMillis/N/K";
TYPE   PgmCmds     = (RedPlayerCmd, BluePlayerCmd, QuietCmd, TraceFileCmd, PauseCmd, TurnMillisCmd, StepMillisCmd, DisplayMillisCmd);

CONST  DEBUG        = FALSE;
       DEBUGspeed   = TRUE;
       DEBUGTurnSeq = FALSE;
       DEBUGTRACE   = FALSE;
       DEBUGLOOP    = FALSE;
VAR    dbgLoop      :BOOLEAN;

VAR  timer           :TimerHandle;
     timerSecs,
     timerMicros     :CARDINAL;
     Time            :REAL;

     i               :INTEGER;
     SelectedBumper  :CARDINAL;

     sig             :SignalRange;
     ResultSignals   :SignalSet;

     elapsedSecs,
     elapsedMicros   :ARRAY[0..1] OF CARDINAL;

     FrameByFrame    :BOOLEAN;
     doExit          :BOOLEAN;
     bRes            :BOOLEAN;

(* NOTE:
     1. Debugging can be confusing, since if a pipe is closed with contents at the end, it will persist and the next
        run may be corrupted by the left over contents (?). Try a unique pipe name?

        Usually, the named pipes can be closed down successfully on an exception such that they will start up
        ok on the next program run, but not always.
        So, to avoid having to reboot, each run uses pipe names with a "unique" id appended.

     2. At the end, a CTRL-C break signal is sent to any child process that is still running.

     3. The ICPC definition of the sled tail wraparound says that wraparound can be detected by two points with one
        idential x/y value and one having the other x/y value at 800.0 and the 2nd point at 0.0.
        eg, a tail end sequence like this ... 45.0 799.0 45.0 800.0 45.0 0.0

        This seems to be implemented by ending the tail right there for that turn. This seems to mean that
        that segment of the tail is shorter than it should be. Probably not important, so I'll go that too.

        The 800.0 -> 0.0 or 0.0 -> 800.0 is not drawn, of course.

     4. ACM Queue web pages on this competition (This is last year's "challenge", but they are still
        accessible as of Jan 23, 2011).

        http://queue.acm.org/icpc/game_description/main.cfm
        http://queue.acm.org/icpc/game_description/overview.cfm
        http://queue.acm.org/challenge/2009/tournament/tournament.html
        http://queue.acm.org/icpc/game_description/competition.cfm
        http://queue.acm.org/icpc/game_description/usage.cfm
        http://queue.acm.org/icpc/game_description/rules.cfm

*)

(*-----------------*)
 PROCEDURE InitPgm;
(*-----------------*)

BEGIN

timer := NullTimerHandle;
Assert(OpenATimer(timer, WaitUntilSys(*UnitMicroHz*)), "OpenATimer FAIL");

SelectedBumper := 0;

TurnNum := 0;
DisplayNum := 0;
StepNum := 0;
TurnMillis := 100.0;
StepMillis := 50.0;
DisplayMillis := 50.0;

QuietMode := FALSE;
FrameByFrame := FALSE;
PauseMode := FALSE;
doExit := FALSE;

elapsedSecs[0] := 0; elapsedSecs[1] := 0;
elapsedMicros[0] := 0; elapsedMicros[1] := 0;
Time := 0.0;

DynStr0.dStrCreate(RedPlayerExe, 80);
DynStr0.dStrCreate(BluePlayerExe, 80);

DynStr0.dStrCreate(TraceFileName, 20);

dbgLoop := FALSE;

END InitPgm;

(*------------------------------------------------------------------------------------------------------*)
 PROCEDURE GetArgs(VAR QuietMode:BOOLEAN; VAR TraceFileName:DynStr; PauseMode:BOOLEAN; VAR ReadPlayerExe,
                   BluePlayerExe:DynStr; VAR TurnMillis, StepMillis, DisplayMillis:REAL);
(*------------------------------------------------------------------------------------------------------*)

VAR  PgmArgs   :ParamsArrayPtr;
     dTemplate :DynStr;
     bRes      :BOOLEAN;

BEGIN

DynStr0.dStrInC(PgmTemplate, dTemplate);
AllocParamsArray(dTemplate, PgmArgs);

bRes := ProcessCLI(PgmTemplate, PgmArgs^);
Assert(bRes, "Bad CLI Params");

IF PgmArgs^[ORD(QuietCmd)].Given THEN
   QuietMode := TRUE;
   DynStr3.dStrInE("TraceFile.txt", TraceFileName);
END;

IF PgmArgs^[ORD(TraceFileCmd)].Given THEN
   Assert(QuietMode, "Trace file written only in Quiet mode");
   DynStr3.dStrAsgE(PgmArgs^[ORD(TraceFileCmd)].Val.vs, TraceFileName);
END;

IF PgmArgs^[ORD(PauseCmd)].Given THEN
   PauseMode := TRUE;
END;

IF PgmArgs^[ORD(RedPlayerCmd)].Given THEN
   DynStr3.dStrAsgE(PgmArgs^[ORD(RedPlayerCmd)].Val.vs, RedPlayerExe);
END;

IF PgmArgs^[ORD(BluePlayerCmd)].Given THEN
   DynStr3.dStrAsgE(PgmArgs^[ORD(BluePlayerCmd)].Val.vs, BluePlayerExe);
END;

IF PgmArgs^[ORD(TurnMillisCmd)].Given THEN
   TurnMillis := FLOAT(PgmArgs^[ORD(TurnMillisCmd)].Val.vi);
END;

IF PgmArgs^[ORD(StepMillisCmd)].Given THEN
   StepMillis := FLOAT(PgmArgs^[ORD(StepMillisCmd)].Val.vi);
END;

IF PgmArgs^[ORD(DisplayMillisCmd)].Given THEN
   DisplayMillis := FLOAT(PgmArgs^[ORD(DisplayMillisCmd)].Val.vi);
END;

DisposeParamsArray(dTemplate, PgmArgs);
DynStr0.dStrDispose(dTemplate);

END GetArgs;

(*-------------------*)
 PROCEDURE MoveSleds;
(*-------------------*)

VAR i :INTEGER;

BEGIN
IF DEBUGTRACE THEN STextIO.WriteString("MoveSleds -> "); END;

FOR i := 0 TO NumSleds-1 DO
   StepSled(i);
END;

IF DEBUGTRACE THEN STextIO.WriteString("<- MoveSleds"); STextIO.WriteLn; END;
END MoveSleds;

(*-----------------*)
 PROCEDURE RunStep;
(*-----------------*)

BEGIN
IF DEBUGTRACE THEN STextIO.WriteString("RunStep -> "); END;

InitStepState;
FollowObjects;

IF DEBUGTRACE THEN STextIO.WriteString("<- RunStep"); STextIO.WriteLn; END;
END RunStep;

(*---------------------*)
 PROCEDURE GetMoves;
(*---------------------*)

VAR  Bump1Accel,
     Bump2Accel    :Point;
     SledTurn      :REAL;
     TardyPlayer   :GameColors;

         (*--------------------------------------------------------------------*)
          PROCEDURE GetRed(VAR Bump1Accel, Bump2Accel:Point; VAR SledTurn:REAL);
         (*--------------------------------------------------------------------*)
         BEGIN

         IF InGameMoves(RedPlayer, Bump1Accel, Bump2Accel, SledTurn) THEN

            IF DEBUG THEN DebugPause("after InGameMoves Red", TurnNum); END;

            AccelBumper(0, Bump1Accel[X], Bump1Accel[Y]);
            AccelBumper(1, Bump2Accel[X], Bump2Accel[Y]);

            TurnSled(RedSledIndex, SledTurn);

         END;

         END GetRed;

         (*--------------------------------------------------------------------*)
          PROCEDURE GetBlue(VAR Bump1Accel, Bump2Accel:Point; VAR SledTurn:REAL);
         (*--------------------------------------------------------------------*)
         BEGIN

         IF InGameMoves(BluePlayer, Bump1Accel, Bump2Accel, SledTurn) THEN
               (* NOTE: here the returned parameters are based on the reflected game board sent to the BluePlayer *)

            IF DEBUG THEN DebugPause("after InGameMoves Blue", TurnNum); END;

            AccelBumper(2, -Bump1Accel[X], Bump1Accel[Y]);         (* Blue thinks he is Red *)
            AccelBumper(3, -Bump2Accel[X], Bump2Accel[Y]);

            TurnSled(BlueSledIndex, -SledTurn);       (* blue player thinks he is red *)

         END;

         END GetBlue;

BEGIN
IF DEBUGTRACE THEN STextIO.WriteString("GetMoves -> "); END;
IF DEBUG THEN DebugPause("Before InGameMoves", TurnNum); END;

TardyPlayer := NoPlayer;

IF ODD(TurnNum) THEN              (* seems fairer *)
   TardyPlayer := BluePlayer;
   GetBlue(Bump1Accel, Bump2Accel, SledTurn);
   TardyPlayer := RedPlayer;
   GetRed(Bump1Accel, Bump2Accel, SledTurn);
ELSE
   TardyPlayer := RedPlayer;
   GetRed(Bump1Accel, Bump2Accel, SledTurn);
   TardyPlayer := BluePlayer;
   GetBlue(Bump1Accel, Bump2Accel, SledTurn);
END;
TardyPlayer := NoPlayer;

IF DEBUGTRACE THEN STextIO.WriteString("<- GetMoves"); STextIO.WriteLn; END;

(*-----*)
 EXCEPT
(*-----*)

IF TardyPlayer = RedPlayer THEN
   STextIO.WriteString("Red Player did not respond in time"); STextIO.WriteLn;
ELSIF TardyPlayer = BluePlayer THEN
   STextIO.WriteString("Blue Player did not respond in time"); STextIO.WriteLn;
ELSE
   STextIO.WriteString("some EXCEPTION in GetMoves()"); STextIO.WriteLn;
END;

END GetMoves;

(*------------------*)
 PROCEDURE TstLoops;
(*------------------*)

VAR  iRes  :INTEGER;

BEGIN
IF DEBUGTRACE THEN STextIO.WriteString("TstLoops -> "); END;
IF DEBUG THEN DebugPause("before TstSledLoop", TurnNum); END;
iRes := TstSledLoop(0);
IF DEBUG THEN DebugPause("after TstSledLoop", TurnNum); END;
IF iRes >= 0 THEN
   DoSledLoop(0, iRes);
   (*dbgLoop := TRUE;*)
END;

iRes := TstSledLoop(1);
IF DEBUGTRACE THEN DebugPause("after TstSledLoop", TurnNum); STextIO.WriteLn; END;
IF iRes >= 0 THEN
   DoSledLoop(1, iRes);
   (*dbgLoop := TRUE;*)
END;

IF DEBUGTRACE THEN STextIO.WriteString("<- TstLoops"); STextIO.WriteLn; END;
END TstLoops;

(*---------------------*)
 PROCEDURE RemoveLoops;
(*---------------------*)
BEGIN
IF DEBUGTRACE THEN STextIO.WriteString("RemoveLoops -> "); END;

IF Sleds.infoS[RedSledIndex].loopP[X] # -1.0 THEN
   RemoveSledLoop(RedSledIndex);
END;

IF Sleds.infoS[BlueSledIndex].loopP[X] # -1.0 THEN
   RemoveSledLoop(BlueSledIndex);
END;

IF DEBUGTRACE THEN STextIO.WriteString("<- RemoveLoops"); STextIO.WriteLn; END;
END RemoveLoops;

(*----------------------*)
 PROCEDURE ReportResult;
(*----------------------*)

VAR  i        :INTEGER;
     BlueCnt,
     RedCnt   :INTEGER;

BEGIN

RedCnt := 0;
BlueCnt := 0;

FOR i := 0 TO NumPucks-1 DO
   IF MovingObjects[PuckObj].specsP^[i].color = RedPlayer THEN
      INC(RedCnt);
   ELSIF MovingObjects[PuckObj].specsP^[i].color = BluePlayer THEN
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

InitPgm;

GetArgs(QuietMode, TraceFileName, PauseMode, RedPlayerExe, BluePlayerExe, TurnMillis, StepMillis, DisplayMillis);

IF TurnMillis < StepMillis THEN
   TurnMillis := StepMillis;
END;
IF DisplayMillis < StepMillis THEN
   DisplayMillis := StepMillis;
END;

StepsPerTurn := round(TurnMillis / StepMillis);
StepMillis := TurnMillis / FLOAT(StepsPerTurn);
StepsPerDisplay := round(DisplayMillis / StepMillis);
DisplayMillis := StepMillis * FLOAT(StepsPerDisplay);

IF DEBUG THEN
   DebugOn(0); DebugPause("StepsPerTurn", StepsPerTurn);
   DebugPause("StepMillis", TRUNC(StepMillis));
   DebugPause("Steps PerDisplay", StepsPerDisplay);
   DebugPause("DisplayMillis", TRUNC(DisplayMillis));
   DebugPause("TurnMillis", TRUNC(TurnMillis));
END;

InitEngine;

IF NOT QuietMode THEN
   InitGameScreen;
END;

InitPlayerIO(RedPlayerExe, BluePlayerExe);

IF NOT QuietMode THEN
   DrawBumpers(MovingObjects[BumperObj].specsB^);
   DrawPucks(MovingObjects[PuckObj].specsP^);
   DrawSleds(Sleds.specsS);
END;
IF DEBUG THEN DebugOn(0); DebugPause("READY", 0); END;

IF QuietMode THEN
   Assert(OpenOutFile(TraceFileName), "Can't create trace file");
   Assert(PutNextState(Time, MovingObjects[PuckObj].specsP^, MovingObjects[BumperObj].specsB^, Sleds.specsS),
          "trace file put state FAIL");
END;

OutGameState(RedPlayer);
OutGameState(BluePlayer);

GetSysTime(elapsedSecs[0], elapsedMicros[0]);
Time := StepMillis;

timerSecs :=   TRUNC(Time/1000.0) + elapsedSecs[0];
timerMicros := TRUNC(1000.0*Time) MOD 1000000 + elapsedMicros[0];
IF timerMicros > 1000000 THEN
   DEC(timerMicros, 1000000);
   INC(timerSecs);
END;

Assert(StartATimer(timer, timerSecs, timerMicros, sig), "StartATimer FAIL");      (* WaitUntil flavor *)

LOOP

   (* moved down >>
   IF DEBUG THEN Debug("Before InitStepState", TurnNum); END;
   InitStepState;
   << *)

   IF (StepNum MOD StepsPerDisplay = 0) AND NOT QuietMode THEN                          (* time for a display ? *)

      IF PauseMode THEN
         DebugOn(0); DebugPause("Pause before upd", TurnNum);
      END;
      IF DEBUGTRACE THEN STextIO.WriteString("before UpdScreen"); STextIO.WriteLn; END;

      (*IF dbgLoop THEN DebugOn(0); DebugPause("before loop", 0); END;*)
      ShowNextFrame;
      (*IF dbgLoop THEN DebugPause("after loop", 0); dbgLoop := FALSE; DebugOff; END;*)

      IF DEBUGTRACE THEN STextIO.WriteString("after UpdScreen"); STextIO.WriteLn; END;
      IF PauseMode THEN
         DebugPause("Pause after upd", TurnNum); DebugOff;
      ELSIF FrameByFrame THEN
         DebugOn(0); DebugPause("Frame", TurnNum);
         FrameByFrame := IsDebugOn();
      END;

      curBuf := (curBuf+1) MOD 2;
      GameScr^.vf^.SetActive(GameScr, curBuf);

      GameRgn^.vf^.SetBackColor(GameRgn, GREENscr);
      GameRgn^.vf^.Clear(GameRgn);

   END;

   IF DEBUG THEN Debug("Before TstBreak", TurnNum); END;
   IF TstBreak() THEN
      EXIT;
   END;

   IF DEBUG THEN DebugPause("before RunStep", TurnNum); END;
   RunStep;                               (* doing the next display *)
   MoveSleds;

   TstLoops;

   IF (StepNum MOD StepsPerDisplay = 0) AND NOT QuietMode THEN
      DrawBumpers(MovingObjects[BumperObj].specsB^);
      DrawPucks(MovingObjects[PuckObj].specsP^);
   END;

   RemoveLoops;        (* if any *)

   IF (StepNum MOD StepsPerDisplay = 0) AND NOT QuietMode THEN
      DrawSleds(Sleds.specsS);
      INC(DisplayNum);
   END;

   INC(StepNum);

   IF StepNum MOD StepsPerTurn = 0 THEN                           (* is the turn over with this step? *)

      (*StepNum := 0;*)
      INC(TurnNum);
      IF DEBUG THEN DebugPause("TurnNum", TurnNum); END;

      IF TurnNum = TurnsPerGame THEN
         TurnNum := -1;
      END;

      GetMoves;    (* must go before, since we did a first OutGameState before LOOP *)

      OutGameState(RedPlayer);
      OutGameState(BluePlayer);

      IF TurnNum = -1 THEN
         EXIT;
      END;

      IF DEBUGTurnSeq THEN SWholeIO.WriteInt(TurnNum, 3); STextIO.WriteLn; END;

   END;

   IF QuietMode THEN
      Assert(PutNextState(Time, MovingObjects[PuckObj].specsP^, MovingObjects[BumperObj].specsB^, Sleds.specsS),
             "trace file put state FAIL");
   END;

   (* wait for the step time to come *)
   IF DEBUGspeed AND TestATimer(timer) THEN                                   (* missed the display time *)
      STextIO.WriteString("-");
   END;

   Assert(WaitATimer(timer, SignalSet{}(*AdditionalSignals*), ResultSignals), "WaitATimer FAIL");

   IF DEBUGTRACE THEN STextIO.WriteString("after WaitATimer"); STextIO.WriteLn; END;

   Time := Time + StepMillis;
   timerSecs :=   TRUNC(Time/1000.0) + elapsedSecs[0];
   timerMicros := TRUNC(1000.0*Time) MOD 1000000 + elapsedMicros[0];
   IF timerMicros > 1000000 THEN
      DEC(timerMicros, 1000000);
      INC(timerSecs);
   END;

   IF DEBUGTRACE THEN STextIO.WriteString("before StartATimer"); STextIO.WriteLn; END;

   Assert(StartATimer(timer, timerSecs, timerMicros, sig), "StartATimer FAIL");      (* WaitUntil flavor *)

   IF DEBUGTRACE THEN STextIO.WriteString("after StartATimer"); STextIO.WriteLn; END;

   IF DEBUG THEN DebugPause("bottom of LOOP", TurnNum); END;
END; (*LOOP*)

IF DEBUG THEN Debug("before last Timer Wait", TurnNum); END;
Assert(WaitATimer(timer, SignalSet{}(*AdditionalSignals*), ResultSignals), "WaitATimer FAIL");

GetSysTime(elapsedSecs[1], elapsedMicros[1]);

bRes := CloseOutFile();

ReportResult;

DebugOn(0); DebugPause("Fin", 0);

(*------*)
 FINALLY
(*------*)

IF DEBUG THEN DebugPause("FINALLY", 0); END;

IF timer # NullTimerHandle THEN
   bRes := CloseATimer(timer);
END;

END Capture.


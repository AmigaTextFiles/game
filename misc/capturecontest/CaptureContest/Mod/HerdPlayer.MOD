
(*##################*)
 MODULE HerdPlayer;        (* $VER: HerdPlayer.MOD 0.0 (27.12.2010) *)
(*##################*)

(*

  One Bumper goes toward the nearest grey puck and attempts to move it into the top part of the screen,

  The other Bumper goes toward the nearest puck of matching color and attempts to move it into the top
  part of the screen.

  If either cannot find thier preferred targer, it will find a puck of the opposite color in the top of the
  screen and and attempt to move it down into the bottom of the screen.

  The Sled circles across the top part of the screen.

      NOTE: 1. All timing is handled by the synchronous reading of the game state.
            2. The first 30 bumper moves are generated randomly, however, in order to get some variety into the
               game.
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
FROM RealMath   IMPORT arctan, pi, sqrt;
IMPORT STextIO, SWholeIO;

FROM CaptureSpecs  IMPORT BumperRadius, MaxBumperVelocity, MaxSledTrailLen, NumBumpers, NumPucks, NumSleds,
                          PuckRadius, ScreenSize, SledVelocity;
FROM PlayerLib     IMPORT BumperInfo, BumpersArray, CR, GameColors, LF, LineSeg,
                          PipeInfo, PuckInfo, PucksArray,
                          SledInfo, SledsArray, Point, XY, InGameState, DebugReal, DebugReal2,
                          OutGameMove;

FROM ArgsSupport     IMPORT AllocParamsArray, DisposeParamsArray, ParamsArrayPtr, ProcessCLI;
FROM Break           IMPORT TstBreak;
FROM DynStr0         IMPORT DynStr;
FROM PipeIO          IMPORT ClosePipe, InvalidPipe, OpenModes, OpenPipe, PipeFile, SetReadTimeout;
FROM RandomNumbers   IMPORT Random;
IMPORT DynStr0, DynStr1, Str0, Str1, Str2;

CONST  PgmName = "HerdPlayer";
       PgmVersion = "$VER: HerdPlayer 0.0 (27.12.2010)";

CONST  PgmTemplate = "-CmdPipeName=-cp/K,-StatePipeName=-sp/K";
TYPE   PgmCmds     = (CmdPipeNameCmd, StatePipeNameCmd);

CONST DEBUG        = FALSE;
      DEBUGcomm    = FALSE;
      DEBUGhndshk  = FALSE;
      DEBUGTurnSeq = FALSE;

CONST PipeTimeOut = 200(*10000*); (*DEBUG*)

CONST BigCircleNumSteps    = MaxSledTrailLen/SledVelocity;    (* approx 40     *)
      BigCircleTurn        = 2.0*pi/BigCircleNumSteps;        (* approx 0.1571 *)
      BigCircleDiameter    = MaxSledTrailLen / pi;            (* approx 191    *)
      BigCircleRadius      = BigCircleDiameter / 2.0;         (* approx 95.5   *)

CONST BaseTime1 = 75;
      BaseTime2 = 100;

TYPE Rnge         = ARRAY (lo,hi) OF REAL;

TYPE HerdBumperInfo = RECORD
                        puckNum    :INTEGER;     (* -1 means no puck selected *)
                        direct     :INTEGER;     (* 1 means herd this puck upward, -1 means herd it downward *)
                        VertRange  :Rnge;
                        pushOffset :REAL;
                        pushReady  :BOOLEAN;     (* aligned and ready to push in the right direction. *)
                      END;

     HerdBumpersArray = ARRAY[0..NumBumpers-1] OF HerdBumperInfo;

     MyBumpersType = RECORD
                          gen  :BumpersArray;
                          spec :HerdBumpersArray;
                        END;

TYPE LoopPart      = (LeftSemi, RightSemi, TopSemi, BottomSemi);
     LoopSpec      = RECORD
                       CenterAt   :Point;
                       AimToward  :LoopPart;
                     END;

     Tangents       = ARRAY [0..1] OF LineSeg;

TYPE SledState      = (circling, translating);
     SledStatus     = RECORD
                        state        :SledState;
                        pathnum,
                        circlesteps  :INTEGER;
                        target       :Tangents;
                        whichTangent :[0..1];
                        loop         :LoopSpec;
                      END;

     HerdSledsArray = ARRAY[0..NumSleds-1] OF SledStatus;
     MySledsType    = RECORD
                          gen  :SledsArray;
                          spec :HerdSledsArray;
                        END;

     PucksInfo    = ARRAY GameColors OF PuckInfo;

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
     Bumpers       :MyBumpersType;
     Sleds         :MySledsType;

     TurnNum       :INTEGER;

TYPE PresetPaths   = [0..5];
VAR  MySledPath    :ARRAY PresetPaths OF LoopSpec;

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

VAR  i       :INTEGER;
     xcntr,
     ycntr   :REAL;

BEGIN

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

FOR i := 0 TO NumBumpers-1 DO
   WITH Bumpers.spec[i] DO
      puckNum := -1;
      direct := 1;
      VertRange[lo] := 0.0;
      VertRange[hi] := 0.75*ScreenSize;
      pushOffset := PuckRadius + BumperRadius;
      pushReady := FALSE;
   END;
END;

xcntr := BigCircleRadius + 10.0;
ycntr := ScreenSize - BigCircleRadius -10.0;

WITH MySledPath[0] DO CenterAt[X] := xcntr;                      CenterAt[Y] := ycntr;  AimToward := LeftSemi; END;
WITH MySledPath[1] DO CenterAt[X] := xcntr+2.0*BigCircleRadius;  CenterAt[Y] := ycntr;  AimToward := TopSemi;  END;
WITH MySledPath[2] DO CenterAt[X] := xcntr+4.0*BigCircleRadius;  CenterAt[Y] := ycntr;  AimToward := TopSemi; END;
WITH MySledPath[3] DO CenterAt[X] := xcntr+6.0*BigCircleRadius;  CenterAt[Y] := ycntr;  AimToward := TopSemi; END;
WITH MySledPath[4] DO CenterAt[X] := xcntr+4.0*BigCircleRadius;  CenterAt[Y] := ycntr;  AimToward := BottomSemi; END;
WITH MySledPath[5] DO CenterAt[X] := xcntr+2.0*BigCircleRadius;  CenterAt[Y] := ycntr;  AimToward := BottomSemi; END;

Sleds.spec[0].pathnum := MAX(PresetPaths);   (* so it turns over on the first calculation *)

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

IF DEBUGcomm THEN DebugPause("HerdPlayer pipes opened", 0); END;

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

(*------------------------------------*)
 PROCEDURE Dist2D(p1, p2:Point):REAL;
(*------------------------------------*)
BEGIN

RETURN sqrt(sqr(p1[X]-p2[X]) + sqr(p1[Y]-p2[Y]));

END Dist2D;

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

(*--------------------------------------------------------------------*)
 PROCEDURE ComponentsToDirection(components:Point; VAR radians:REAL);
(*--------------------------------------------------------------------*)
                (* assume Point starts from 0,0 *)
                (* always returns a positive (counterclockwise) angle *)
BEGIN

IF ABS(components[X]) < 1.0E-6 THEN
   IF components[Y] > 0.0 THEN
      radians := pi;
   ELSIF components[Y] < 0.0 THEN
      radians := -pi;
   ELSE
      Assert(FALSE, "ComponentsToDirection: point input");
   END;
ELSE
   radians := arctan(components[Y] / components[X]);         (* arctan returns range  [-pi/2, pi/2] *)
   (*NG, use the best trig func*)
END;

IF components[X] < 0.0 THEN

   radians := radians + pi;

END;


END ComponentsToDirection;

(*-----------------------------------------------------------------------------*)
 PROCEDURE FindNearestPucks(from:Point; VertRange:Rnge; VAR puckHits:PucksInfo);
(*------------------------------------------------------------------------------*)

VAR  i       :INTEGER;
     dist    :REAL;
     minDist :ARRAY GameColors OF REAL;

BEGIN

minDist[MyColor]   := MAX(REAL);
minDist[HisColor]  := MAX(REAL);
minDist[GreyColor] := MAX(REAL);

puckHits[MyColor].num   := -1; puckHits[MyColor].color    := MyColor;
puckHits[HisColor].num  := -1; puckHits[HisColor].color   := HisColor;
puckHits[GreyColor].num := -1; puckHits[GreyColor].color  := GreyColor;

FOR i := 0 TO NumPucks-1 DO

   IF (Pucks[i].pos[Y] >= VertRange[lo]) AND (Pucks[i].pos[Y] <= VertRange[hi]) THEN

      dist := sqr(Pucks[i].pos[X] - from[X]) + sqr(Pucks[i].pos[Y] - from[Y]);

      CASE Pucks[i].color OF
         MyColor:
            IF dist < minDist[MyColor] THEN
               minDist[MyColor] := dist;
               puckHits[MyColor].num := i;
            END;
            |
         HisColor:
            IF dist < minDist[HisColor] THEN
               minDist[HisColor] := dist;
               puckHits[HisColor].num := i;
            END;
            |
         GreyColor:
            IF dist < minDist[GreyColor] THEN
               minDist[GreyColor] := dist;
               puckHits[GreyColor].num := i;
            END;
      END;

   END;

END;

END FindNearestPucks;

(*--------------------------------------------------------------------*)
 PROCEDURE FindNearestLowerPucks(from:Point; VAR puckHits:PucksInfo);
(*--------------------------------------------------------------------*)

VAR  VertRange :Rnge;

BEGIN

VertRange[lo] := 0.0;
VertRange[hi] := 0.75*ScreenSize;

FindNearestPucks(from, VertRange, puckHits);

END FindNearestLowerPucks;

(*--------------------------------------------------------------------*)
 PROCEDURE FindNearestUpperPucks(from:Point; VAR puckHits:PucksInfo);
(*--------------------------------------------------------------------*)

VAR  VertRange :Rnge;

BEGIN

VertRange[lo] := 0.75*ScreenSize;
VertRange[hi] := ScreenSize;

FindNearestPucks(from, VertRange, puckHits);

END FindNearestUpperPucks;

(*---------------------------------------------------------------------------*)
 PROCEDURE CalcLoopTangents(P, C:Point; r:REAL; VAR t:Tangents):CARDINAL;
(*---------------------------------------------------------------------------*)
(*
This algorithm is taken from:

Geometric Tools for Computer Graphics
    Philip Schneider and David Eberly
    8.4 Line Tangent to a Circle through a Given Point
*)

VAR  numSoln    :CARDINAL;
     distanceCP :REAL;
     u          :Point;
     v0, v1     :Point;
     ux2, ux4,
     uy2,
     r2, r4,
     num,
     denom,
     rad        :REAL;


BEGIN

distanceCP := Dist2D(C, P);

IF distanceCP < r THEN

   numSoln := 0;
   DebugPause("numSoln", 0);

ELSIF distanceCP = r THEN

   numSoln := 1;
   DebugPause("numSoln", 1);

   (*u[X] := P[X] - C[X];
   u[Y] := P[Y] - C[Y];*)

   t[0].p1 := P;
   t[0].p2 := P;

ELSE

   numSoln := 2;

   u[X] := P[X] - C[X];
   u[Y] := P[Y] - C[Y];

   ux2 := u[X] * u[X];
   ux4 := ux2 * ux2;
   uy2 := u[Y] * u[Y];
   r2 := r * r;
   r4 := r2 * r2;
   num := r2 * uy2;
   denom := ux2 + uy2;
   rad := sqrt(-(r4 * ux2) + r2 * ux4 + r2 * ux2 * uy2);

   v0[X] := (r2 - (num + u[Y] * rad)/denom)/u[X];
   v0[Y] := (r2 * u[Y] + rad) / denom;

   v1[X] := (r2 - (num - u[Y] * rad)/denom)/u[X];
   v1[Y] := (r2 * u[Y] - rad) / denom;

   t[0].p1 := P;
   t[0].p2[X] := C[X] + v0[X];
   t[0].p2[Y] := C[Y] + v0[Y];

   t[1].p1 := P;
   t[1].p2[X] := C[X] + v1[X];
   t[1].p2[Y] := C[Y] + v1[Y];

END;

RETURN numSoln;

END CalcLoopTangents;

(*===============================*)
 PROCEDURE FindNextTranslation();
(*===============================*)

VAR  distSledAim0,
     distSledAim1   :REAL;
     ps             :PresetPaths;

BEGIN WITH Sleds DO
DebugPause("FindNextTranslation", TurnNum);

ps := (VAL(CARDINAL, spec[0].pathnum)+1) MOD (VAL(CARDINAL, MAX(PresetPaths))+1);
DebugPause("ps", ps);

spec[0].pathnum := ps;
spec[0].loop := MySledPath[ps];
spec[0].state := translating;
spec[0].circlesteps := 0;

END END FindNextTranslation;

(*--------------------------------------*)
 PROCEDURE CalcRandomBumperMove(TurnNum:INTEGER);
(*--------------------------------------*)
BEGIN

IF TurnNum MOD Factor1Time = 0 THEN
   IF ODD(Random(2)) THEN
      Factor1 := 1.0 + Random1();
   ELSE
      Factor1 := -(1.0 + Random1());
   END;
   (*DebugReal("Factor1", 0, Factor1);*)
   Bump1Accel[X] := Factor1*1.0;
   Bump1Accel[Y] := Factor1*0.5;
   Factor1Time := BaseTime1 + (Random(5) - 2);
END;

IF TurnNum MOD Factor1Time = 0 THEN
   IF ODD(Random(2)) THEN
      Factor1 := 1.0 + Random1();
   ELSE
      Factor1 := -(1.0 + Random1());
   END;
   Bump2Accel[X] := Factor1*0.4;
   Bump2Accel[Y] := Factor1*1.0;
   Factor1Time := BaseTime2 + (Random(11) - 5);
END;

END CalcRandomBumperMove;

(*--------------------------------------------------*)
 PROCEDURE PuckHerdFin(bump:HerdBumperInfo):BOOLEAN;
(*--------------------------------------------------*)
     (* successfully moved to specified part of screen? *)
BEGIN

IF bump.direct = 1 THEN
   RETURN Pucks[bump.puckNum].pos[Y] >= bump.VertRange[hi];
ELSE
   RETURN Pucks[bump.puckNum].pos[Y] <= bump.VertRange[lo];
END;

END PuckHerdFin;

(*---------------------*)
 PROCEDURE CalcGameMove;
(*---------------------*)

VAR  ps               :CARDINAL;
     greyP,
     myP,
     hisP             :INTEGER;
     oldDir,
     newDir           :REAL;
     starget,
     ptarget          :Point;
     NearPucksLower,
     NearPucksHigher  :PucksInfo;
     distSledToTang,
     distBumpToPuck,
     speedFactor      :REAL;
     LowerPucksFound,
     HigherPucksFound :BOOLEAN;

BEGIN

(* -------------Sled-------------------- *)

WITH Sleds DO

   oldDir := gen[0].direct;

   IF spec[0].state = translating THEN

      ps := spec[0].whichTangent;

      Assert(CalcLoopTangents(gen[0].pos, spec[0].loop.CenterAt, BigCircleRadius, spec[0].target) = 2, "CalcLoopTangents problem");

      DebugReal2("target[0] pos", 0, spec[0].target[0].p2[X], spec[0].target[0].p2[Y]);
      DebugReal2("target[1] pos", 0, spec[0].target[1].p2[X], spec[0].target[1].p2[Y]);

      CASE spec[0].loop.AimToward OF
         LeftSemi,
         RightSemi: IF spec[0].target[0].p2[X] < spec[0].target[1].p2[X] THEN
                       ps := 0;
                    ELSE
                       ps := 1;
                    END;
                    IF spec[0].loop.AimToward = RightSemi THEN
                       ps := (ps + 1) MOD 2;
                    END; |
         TopSemi,
         BottomSemi: IF spec[0].target[0].p2[Y] < spec[0].target[1].p2[Y] THEN
                        ps := 1;
                     ELSE
                        ps := 0;
                     END;
                     IF spec[0].loop.AimToward = BottomSemi THEN
                       ps := (ps + 1) MOD 2;
                     END; |
      END;

      distSledToTang := Dist2D(gen[0].pos, spec[0].target[ps].p2);

      DebugReal("distSledToTang", 0, distSledToTang);

      IF distSledToTang < 2.0*SledVelocity THEN

         DebugPause("begin circling", 0);
         spec[0].state := circling;
         spec[0].circlesteps := 0;

      ELSE

         starget[X] := spec[0].target[ps].p2[X] - spec[0].target[ps].p1[X];
         starget[Y] := spec[0].target[ps].p2[Y] - spec[0].target[ps].p1[Y];

         ComponentsToDirection(starget, newDir);

         WHILE oldDir < 0.0 DO
            oldDir := oldDir + 2.0*pi;
         END;
         WHILE oldDir > 2.0*pi DO
            oldDir := oldDir - 2.0*pi;
         END;
         DebugReal2("oldDir - newDir", 0, oldDir, newDir);
         SledTurn := oldDir - newDir;    (* left turn is negative *)
         IF SledTurn > pi THEN
            SledTurn := SledTurn - 2.0*pi;
         ELSIF SledTurn < -pi THEN
            SledTurn := SledTurn + 2.0*pi;
         END;
         DebugReal("SledTurn", 0, SledTurn);
         (*NG Need to adjust for size of oldDir to keep it from getting out of range *)
         (*DebugOn(0); DebugReal("oldDir", 0, oldDir);
         DebugReal("newDir", 0, newDir);*)
         DebugReal("SledTurn adj", 0, SledTurn);
      END;

   END;

   IF spec[0].state = circling THEN

      SledTurn := BigCircleTurn (*0.157*) (*0.15955*);
      (*IF NOT spec[0].loop.LoopRight THEN
         SledTurn := -SledTurn;
      END;*)
      (*newDir := oldDir - SledTurn;*)
      (*SledTurn := oldDir - newDir;*)    (* left turn is negative *)
      INC(spec[0].circlesteps);
      IF spec[0].circlesteps = INT(BigCircleNumSteps) THEN
         FindNextTranslation;
      END;

   END;

END;

(*-----------Bumpers------------------ *)
IF TurnNum < 30 THEN                    (* randomize a little for variety *)

   CalcRandomBumperMove(TurnNum);

ELSE

   (* Bumper 0 moves blue pucks down to bottom, or if none, grey pucks up into the top of the screen *)

   LowerPucksFound := FALSE;
   HigherPucksFound := FALSE;

   speedFactor := 1.0;

   IF Bumpers.spec[0].puckNum = -1 THEN

      FindNearestUpperPucks(Bumpers.gen[0].pos, NearPucksHigher);
      Bumpers.spec[0].VertRange[lo] := 0.75*ScreenSize;
      Bumpers.spec[0].VertRange[hi] := ScreenSize;

      Bumpers.spec[0].puckNum :=  NearPucksHigher[HisColor].num;
      Bumpers.spec[0].direct := -1;                                     (* down *)

      HigherPucksFound := TRUE;

   ELSE

      IF PuckHerdFin(Bumpers.spec[0]) THEN              (* successfully moved to specified part of screen *)

         FindNearestUpperPucks(Bumpers.gen[0].pos, NearPucksHigher);       (* upper part of screen *)

         Bumpers.spec[0].VertRange[lo] := 0.75*ScreenSize;
         Bumpers.spec[0].VertRange[hi] := ScreenSize;

         Bumpers.spec[0].puckNum :=  NearPucksHigher[HisColor].num;
         Bumpers.spec[0].direct := -1;
                                              (* down *)
         HigherPucksFound := TRUE;

      END;

   END;

   hisP := Bumpers.spec[0].puckNum;

   IF hisP >= 0 THEN   (* blue puck was really found *)

      IF Bumpers.spec[0].pushReady THEN                      (* NYI *)

         Bump1Accel[X] := Pucks[hisP].pos[X] - Bumpers.gen[0].pos[X];
         Bump1Accel[Y] := (Pucks[hisP].pos[Y] - Bumpers.gen[0].pos[Y]) -FLOAT(Bumpers.spec[0].direct)*(PuckRadius+BumperRadius);

         NewVelocityToComponents(MaxBumperVelocity(*/3.0*), Bump1Accel[X], Bump1Accel[Y]);

         Bump1Accel[X] := Bump1Accel[X] - Bumpers.gen[0].speed[X];        (* remove previous direction components *)
         Bump1Accel[Y] := Bump1Accel[Y] - Bumpers.gen[0].speed[Y];

      ELSE

         Bump1Accel[X] := Pucks[hisP].pos[X] - Bumpers.gen[0].pos[X];
         Bump1Accel[Y] := (Pucks[hisP].pos[Y] - Bumpers.gen[0].pos[Y]) -FLOAT(Bumpers.spec[0].direct)*(PuckRadius+BumperRadius);

         NewVelocityToComponents(MaxBumperVelocity(*/3.0*), Bump1Accel[X], Bump1Accel[Y]);

         Bump1Accel[X] := Bump1Accel[X] - Bumpers.gen[0].speed[X];        (* remove previous direction components *)
         Bump1Accel[Y] := Bump1Accel[Y] - Bumpers.gen[0].speed[Y];

      END;

   ELSE     (* no blue puck found, try moving a grey puck up *)

      Bumpers.spec[0].direct := 1;                                      (* up *)
      Bumpers.spec[0].VertRange[lo] := 0.0;
      Bumpers.spec[0].VertRange[hi] := 0.75*ScreenSize;
      Bumpers.spec[0].pushOffset := PuckRadius + BumperRadius;

      FindNearestLowerPucks(Bumpers.gen[0].pos, NearPucksLower);       (* lower part of screen *)
      Bumpers.spec[0].puckNum := NearPucksLower[GreyColor].num;
      LowerPucksFound := TRUE;

      greyP := Bumpers.spec[0].puckNum;

      IF greyP >= 0 THEN   (* grey puck was really found *)

         IF Bumpers.spec[0].pushReady THEN                      (* NYI *)

            Bump1Accel[X] := Pucks[greyP].pos[X] - Bumpers.gen[0].pos[X];
            Bump1Accel[Y] := (Pucks[greyP].pos[Y] - Bumpers.gen[0].pos[Y]) -FLOAT(Bumpers.spec[0].direct)*(PuckRadius+BumperRadius);

            NewVelocityToComponents(MaxBumperVelocity(*/3.0*), Bump1Accel[X], Bump1Accel[Y]);

            Bump1Accel[X] := Bump1Accel[X] - Bumpers.gen[0].speed[X];        (* remove previous direction components *)
            Bump1Accel[Y] := Bump1Accel[Y] - Bumpers.gen[0].speed[Y];

         ELSE

            Bump1Accel[X] := Pucks[greyP].pos[X] - Bumpers.gen[0].pos[X];
            Bump1Accel[Y] := (Pucks[greyP].pos[Y] - Bumpers.gen[0].pos[Y]) -FLOAT(Bumpers.spec[0].direct)*(PuckRadius+BumperRadius);

            NewVelocityToComponents(MaxBumperVelocity(*/3.0*), Bump1Accel[X], Bump1Accel[Y]);

            Bump1Accel[X] := Bump1Accel[X] - Bumpers.gen[0].speed[X];        (* remove previous direction components *)
            Bump1Accel[Y] := Bump1Accel[Y] - Bumpers.gen[0].speed[Y];

         END;

      ELSE

         DebugOn(0); DebugPause("neg greyP", greyP); DebugPause("TurnNum", TurnNum);
         Bump1Accel[X] := - Bumpers.gen[1].speed[X];        (* remove previous direction components *)
         Bump1Accel[Y] := - Bumpers.gen[1].speed[Y];

      END;
   END;

   (* other bumper moves red pucks up into the top of the screen, or if none left to move, pushes blue pucks down into the bottom of the screen *)

   (*DebugOn(0); DebugPause("second bumper", Bumpers.spec[1].puckNum);*)

   IF Bumpers.spec[1].puckNum = -1 THEN

      Bumpers.spec[1].direct := 1;                                      (* up *)
      Bumpers.spec[1].VertRange[lo] := 0.0;
      Bumpers.spec[1].VertRange[hi] := 0.75*ScreenSize;
      Bumpers.spec[1].pushOffset := PuckRadius + BumperRadius;

      IF NOT LowerPucksFound THEN              (* no need to find them twice if found above *)
         FindNearestLowerPucks(Bumpers.gen[1].pos, NearPucksLower);       (* lower part of screen *)
         LowerPucksFound := TRUE;
         (*DebugOn(0); DebugPause("after return, NearPucksLower[MyColor].num", NearPucksLower[MyColor].num);*)
      END;
      Bumpers.spec[1].puckNum := NearPucksLower[MyColor].num;
      (*DebugOn(0); DebugPause("fresh nearest my puck", Bumpers.spec[1].puckNum);*)

   ELSE

     (*DebugOn(0); DebugPause("before call to PuckHerdFin", Bumpers.spec[1].puckNum);*)
     IF PuckHerdFin(Bumpers.spec[1]) THEN      (* successfully moved to specified part of screen *)

         (*DebugOn(0); DebugPause("PuckHerdFin was true", Bumpers.spec[1].puckNum);*)

         Bumpers.spec[1].direct := 1;                                      (* up *)
         Bumpers.spec[1].VertRange[lo] := 0.0;
         Bumpers.spec[1].VertRange[hi] := 0.75*ScreenSize;
         Bumpers.spec[1].pushReady := FALSE;

         IF NOT LowerPucksFound THEN
            FindNearestLowerPucks(Bumpers.gen[1].pos, NearPucksLower);       (* lower part of screen *)
            LowerPucksFound := TRUE;
         END;
         Bumpers.spec[1].puckNum := NearPucksLower[MyColor].num;
         (*DebugOn(0); DebugPause("finished nearest my puck", Bumpers.spec[1].puckNum);*)

     END;
      
   END;

   (* if none of my pucks is left to move, go find a blue one in the top 3/4 and move it down *)
   IF Bumpers.spec[1].puckNum < 0 THEN

      (*DebugOn(0); DebugPause("go find a blue one", Bumpers.spec[1].puckNum);*)

      Bumpers.spec[1].VertRange[lo] := 0.75*ScreenSize;
      Bumpers.spec[1].VertRange[hi] := ScreenSize;
      FindNearestUpperPucks(Bumpers.gen[1].pos, NearPucksHigher);       (* upper part of screen *)
      Bumpers.spec[1].puckNum :=  NearPucksHigher[HisColor].num;
      Bumpers.spec[1].direct := -1;                                     (* down *)
      (*DebugOn(0); DebugPause("new nearest his puck", Bumpers.spec[1].puckNum);*)

   END;

   myP := Bumpers.spec[1].puckNum;

   IF myP >= 0 THEN

      IF Bumpers.spec[1].pushReady THEN                                 

         (*DebugOn(0);*) DebugPause("PushReady", 0);
         ptarget[X] := Pucks[myP].pos[X];
         ptarget[Y] := Pucks[myP].pos[Y];

         distBumpToPuck := Dist2D(ptarget, Bumpers.gen[1].pos);       (* ?? *)

         IF ABS(Bumpers.gen[1].pos[X] - Pucks[myP].pos[X]) > 4.0*BumperRadius THEN

            Bumpers.spec[1].pushReady := FALSE;
            Bumpers.spec[1].pushOffset := PuckRadius + BumperRadius;

         ELSE

            speedFactor := 1.0;

            Bump2Accel[X] := ptarget[X] - Bumpers.gen[1].pos[X];
            Bump2Accel[Y] := ptarget[Y] - Bumpers.gen[1].pos[Y];

            NewVelocityToComponents(MaxBumperVelocity*speedFactor, Bump2Accel[X], Bump2Accel[Y]);

            Bump2Accel[X] := Bump2Accel[X] - Bumpers.gen[1].speed[X];        (* remove previous direction components *)
            Bump2Accel[Y] := Bump2Accel[Y] - Bumpers.gen[1].speed[Y];

         END;

      END;
      
      IF NOT Bumpers.spec[1].pushReady THEN

         ptarget[X] := Pucks[myP].pos[X] - Bumpers.spec[1].pushOffset;
         IF Bumpers.gen[1].pos[Y] < (Pucks[myP].pos[Y]-4.0*BumperRadius) THEN
            ptarget[Y] := Pucks[myP].pos[Y];
         ELSE
            ptarget[Y] := Pucks[myP].pos[Y] - FLOAT(Bumpers.spec[1].direct)*(PuckRadius + 2.0*BumperRadius);
         END;

         distBumpToPuck := Dist2D(ptarget, Bumpers.gen[1].pos);       (* ?? *)

         IF distBumpToPuck <= 2.0 THEN
            speedFactor := 0.0417;
            IF Bumpers.spec[1].pushOffset = 0.0 THEN
               Bumpers.spec[1].pushReady := TRUE;
               (*speedFactor := 1.0;*)
               (*ptarget[Y] := Pucks[myP].pos[Y];*)
            END;
            ptarget[X] := Pucks[myP].pos[X];
            Bumpers.spec[1].pushOffset := 0.0;
         ELSIF distBumpToPuck < 10.0 THEN
            speedFactor := 0.1;
         ELSIF distBumpToPuck < 2.0*MaxBumperVelocity THEN
            speedFactor := 0.33333;
         ELSE
            speedFactor := 1.0;
         END;
         (*IF ptarget[Y] = Pucks[myP].pos[Y] THEN
            speedFactor := 1.0;
         END;*)

         Bump2Accel[X] := ptarget[X] - Bumpers.gen[1].pos[X];
         Bump2Accel[Y] := ptarget[Y] - Bumpers.gen[1].pos[Y];

         NewVelocityToComponents(MaxBumperVelocity*speedFactor, Bump2Accel[X], Bump2Accel[Y]);

         Bump2Accel[X] := Bump2Accel[X] - Bumpers.gen[1].speed[X];        (* remove previous direction components *)
         Bump2Accel[Y] := Bump2Accel[Y] - Bumpers.gen[1].speed[Y];

      END;
      (*
      Bump2Accel[X] := (Pucks[myP].pos[X] - Bumpers.gen[1].pos[X]) (* - Bumpers.gen[1].speed[X]*);
      Bump2Accel[Y] := (Pucks[myP].pos[Y] - Bumpers.gen[1].pos[Y]) (* - Bumpers.gen[1].speed[Y]*);
      NewVelocityToComponents(MaxBumperVelocity(*/3.0*), Bump2Accel[X], Bump2Accel[Y]);
      Bump2Accel[X] := Bump2Accel[X] - Bumpers.gen[1].speed[X];
      Bump2Accel[Y] := Bump2Accel[Y] - Bumpers.gen[1].speed[Y];
      *)
   ELSE

      (*DebugOn(0); DebugPause("neg my", greyP); DebugPause("TurnNum", TurnNum);*)
      Bump2Accel[X] := - Bumpers.gen[1].speed[X];   (* just stop *)
      Bump2Accel[Y] := - Bumpers.gen[1].speed[Y];

   END;

END;

END CalcGameMove;

(*----------------*)
 BEGIN (* program *)
(*----------------*)

(*DebugOn(0);*)
(*DebugPause("HerdPlayer", 0);*)

InitPgm;

GetArgs(CmdPipeName, StatePipeName);
IF DEBUG THEN DebugOn(0); DebugPause(CmdPipeName, 0); DebugPause(StatePipeName, 0); END;

InitPipes;

WHILE (TurnNum # -1) AND NOT TstBreak() DO

   InGameState(StatePipe.pipeF, TurnNum, Pucks, Bumpers.gen, Sleds.gen);
   IF DEBUGTurnSeq THEN STextIO.WriteChar(CR); SWholeIO.WriteInt(TurnNum, 3); END;

   IF TurnNum # -1 THEN

      IF TurnNum = 0 THEN
         FindNextTranslation();
      END;

      CalcGameMove;

      OutGameMove(CmdPipe.pipeF, Bump1Accel, Bump2Accel, SledTurn);

   END;

END;

(*======*)
 FINALLY
(*======*)

(*DebugOn(0);*)
(*DebugPause("HerdPlayer FINALLY", 0);*)

IF StatePipe.pipeF # InvalidPipe() THEN
   ClosePipe(StatePipe.pipeF);
END;

IF CmdPipe.pipeF # InvalidPipe() THEN
   ClosePipe(CmdPipe.pipeF);
END;

END HerdPlayer.





(*################################*)
 IMPLEMENTATION MODULE TraceFileIO;        (* $VER: TraceFileIO.MOD 0.0 (7.2.2011) *)
(*################################*)

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

FROM Storage      IMPORT ALLOCATE, DEALLOCATE;
FROM Assertions   IMPORT Assert;
FROM Debugging    IMPORT DebugOn, DebugPause;

FROM ChanConsts   IMPORT OpenResults;
FROM ConvTypes    IMPORT ConvResults;
FROM IOChan       IMPORT ChanId, InvalidChan;
FROM IOConsts     IMPORT ReadResults;
FROM RealIO       IMPORT WriteFixed;
FROM RealStr      IMPORT StrToReal;
FROM SeqFile      IMPORT Close, FlagSet, OpenRead, OpenWrite;
FROM TextIO       IMPORT WriteLn, WriteString;
FROM WholeIO      IMPORT WriteCard;
FROM WholeStr     IMPORT IntToStr, StrToCard, StrToInt;
IMPORT STextIO;

(*DEBUG*) IMPORT SLongIO, SWholeIO;

FROM CaptureDebug    IMPORT DebugReal, DebugReal2;
FROM CaptureSpecs    IMPORT BumperObjsDesc, GameColors, IsHidden, MaxStepsPerTurn,
                            NumBumpers, NumPucks, NumSleds, Point, PuckObjsDesc,
                            SledObjsDesc, SledSpecs, TrailMaxPoints, TurnsPerGame;

FROM DynStr0         IMPORT DynStr;
FROM SimpleGraphics  IMPORT XY;
FROM TextIOHelper    IMPORT dReadNextNonBlankLine;

IMPORT DynStr0, DynStr1, DynStr1NC, DynStr2A, DynStr3;

(* Trace File Format
                  { }     -> zero or more repeated instances
                  [a | b] -> one instance or either a OR b
                 *[ ] -> one or more repeated instance
                n*[ ] -> exactly n repeated instances
                  < > -> described token
                  " " -> this literal

    *[FrameHdr PucksStats BumpersStats SledsStats {CollisionStats | WallStats | SledWrapStats | SledLoopStats}] "end"

    FrameHdr ::= "snapshot" TimeMillisecs <newline>

         TimeMillisecs ::= <real number>

    PuckStats ::= "112" <newline> 112*[Xpos Ypos Color <newline>]

         Xpos ::= <real number>
         Ypos ::= <real number>
         Color := [RedColor | BlueColor | GreyColor]
            RedColor  ::= "0"
            BlueColor ::= "1"
            GreyColor ::= "2"

    BumpersState ::= "4" <newline> 4*[Xpos Ypos Color <newline>]

    SledsStats ::= "2" <newline> 2*[Xpos Ypos Direction Color <newline> TailStats]

         TailStats ::= NumSegments*[Xpos Ypos] <newline>
            NumSegments := <cardinal>

  The following are ignored by this software:

    CollisionStats ::= "collision" TimeMillisecs ObjNum ObjNum <newline>
         ObjNum1 := [<puckNum>| <bumperNum+112>
    WallStats      ::= "hitWall" TimeMillisecs ObjNum WallNum Xpos Ypos <newline>
    SledWrapStats  ::= "sledWrap" TimeMillisecs <num> <num> <realnum> <newline>
    SledLoopStats  ::= "sledLoop" TimeMillisecs <num> <num> <newline> SegmentList
         SegmentList ::= NumSegments*[Xpos Ypos] <newline>

e.g.

snapshot 1266.6666666666665
112
  50.0 100.0 2
  50.0 200.0 2
  50.0 300.0 2
  50.0 400.0 0
  50.0 500.0 2
  50.0 600.0 2
  50.0 700.0 2
  ...

  750.0 500.0 2
  750.0 600.0 2
  750.0 700.0 2
4
  43.5 467.0 0
  352.7 477.4 0
  636.8 302.7 1
  758.5 430.2 1
2
  104.8 250.2 -2.99 0
  13 100.0 400.0 113.2 392.8 121.3 380.2 126.9 366.3 132.6 352.4 138.3 338.5 144.0 324.7 149.5 310.7 150.2 295.7 147.0 281.1 139.2 268.3 128.3 258.0 114.7 251.7
  710.0 276.5 6.28 1
  13 700.0 400.0 685.4 396.4 672.2 389.4 660.9 379.5 652.4 367.1 647.1 353.1 645.3 338.2 647.1 323.3 652.4 309.3 660.9 297.0 672.2 287.0 685.4 280.1 700.0 276.5
hitWall 1272.788 108 2 373.758 -11.982
collision 1273.273 92 114
snapshot 1299.9999999999998
112
  50.0 100.0 2
  50.0 200.0 2
  ...

*)

CONST  DEBUG = FALSE;

VAR  inf,
     outf        :ChanId;
     OneLine,
     OneToken    :DynStr;
     strtTok     :DynStr;

TYPE SnapShot = RECORD
                  Time         :REAL;
                  PucksSnap    :PuckObjsDesc;
                  BumpersSnap  :BumperObjsDesc;
                  SledsSnap    :SledObjsDesc;
                END;

VAR  SnapCache   :POINTER TO ARRAY [0..TurnsPerGame*MaxStepsPerTurn-1] OF SnapShot;

VAR  SnapNumber  :CARDINAL;
     bRes        :BOOLEAN;

(*==============================================*)
 PROCEDURE OpenInFile(InFileName:DynStr):BOOLEAN;
(*==============================================*)

VAR oRes :OpenResults;

BEGIN

OpenRead(inf, InFileName.str^, FlagSet{}, oRes);
Assert(oRes = opened, "TraceFileIO: unable to open input file");

RETURN TRUE;

END OpenInFile;

(*===============================*)
 PROCEDURE CloseInFile():BOOLEAN;
(*===============================*)

BEGIN

IF inf # InvalidChan() THEN
   Close(inf);
END;

RETURN TRUE;

END CloseInFile;

(*==============================================*)
 PROCEDURE OpenOutFile(OutFileName:DynStr):BOOLEAN;
(*==============================================*)

VAR oRes :OpenResults;

BEGIN

Assert(SnapCache = NIL, "TraceFileIO: Cache not NIL in OpenOutFile");
NEW(SnapCache);
Assert(SnapCache # NIL, "TraceFileIO: Cache out of memory in OpenOutFile");

OpenWrite(outf, OutFileName.str^, FlagSet{}, oRes);                 (* add: check for "fileExists" error and ask user *)
Assert(oRes = opened, "TraceFileIO: unable to create output file");

RETURN TRUE;

END OpenOutFile;

(*>>>>>>>>>>>>>
(*---------------------------------------------------------------------*)
 PROCEDURE CalcOutputSegs(SledInfo:SledSpecs; VAR outputSegs:CARDINAL);
(*---------------------------------------------------------------------*)

VAR  writeIt :BOOLEAN;
     i       :INTEGER;

BEGIN

outputSegs := 0;

IF SledInfo.TrailNumPoints > 0 THEN

   outputSegs := 1;                       (* always write the first one *)               

   FOR i := INT(SledInfo.TrailNumPoints)-2 TO 1 BY -1 DO

     IF SledInfo.Trail[i-1].hidden OR SledInfo.Trail[i+1].hidden THEN      (* one before/after hidden is always to/from the edge *)
         writeIt := TRUE;
      ELSIF NOT SledInfo.Trail[i].hidden THEN
         writeIt := TRUE;
      ELSE
         writeIt := FALSE;
      END;

      IF writeIt THEN
         INC(outputSegs);
      END;

   END;

   IF SledInfo.TrailNumPoints > 1 THEN
      INC(outputSegs);               (* always write the last one *)
   END;

END;

END CalcOutputSegs;
<<<<<<<<<<<<<<<<<<< *)

(*---------------------------------------------*)
 PROCEDURE WriteOutputSegs(SledInfo:SledSpecs);
(*---------------------------------------------*)

VAR  i,
     j    :INTEGER;

BEGIN WITH SledInfo DO

IF TrailNumPoints > 0 THEN

   j := TrailHeadPos;

   FOR i := 0 TO VAL(INTEGER, TrailNumPoints)-1 DO

      WriteFixed(outf, Trail[j, X], 1(*place*), 6);
      WriteFixed(outf, Trail[j, Y], 1(*place*), 6);

      j := (j + TrailMaxPoints -1) MOD TrailMaxPoints;

   END;

END;

END END WriteOutputSegs;

(*===============================*)
 PROCEDURE CloseOutFile():BOOLEAN;
(*===============================*)

VAR  snap,
     i, j       :INTEGER;
     outputSegs :CARDINAL;

BEGIN

IF outf # InvalidChan() THEN

   STextIO.WriteLn; STextIO.WriteString("Writing Trace File ...");

   FOR snap := 0 TO VAL(INTEGER, SnapNumber)-1 DO
      WITH SnapCache^[snap] DO

         WriteString(outf, "snapshot ");
         WriteFixed(outf, Time, 2(*place*), 8);
         WriteLn(outf);

         WriteCard(outf, NumPucks, 3);
         WriteLn(outf);
         FOR i := 0 TO NumPucks-1 DO
            WriteFixed(outf, PucksSnap[i].pos[X], 1(*place*), 6);
            WriteFixed(outf, PucksSnap[i].pos[Y], 1(*place*), 6);
            WriteCard(outf, ORD(PucksSnap[i].color), 2);
            WriteLn(outf);
         END;

         WriteCard(outf, NumBumpers, 1);
         WriteLn(outf);
         FOR i := 0 TO NumBumpers-1 DO
            WriteFixed(outf, BumpersSnap[i].pos[X], 1(*place*), 6);
            WriteFixed(outf, BumpersSnap[i].pos[Y], 1(*place*), 6);
            WriteCard(outf, ORD(BumpersSnap[i].color), 2);
            WriteLn(outf);
         END;

         WriteCard(outf, NumSleds, 1);
         WriteLn(outf);

         (* better: get rid of the use of hidden segs *)

         FOR i := 0 TO NumSleds-1 DO

            WriteFixed(outf, SledsSnap[i].pos[X], 1(*place*), 6);
            WriteFixed(outf, SledsSnap[i].pos[Y], 1(*place*), 6);
            WriteFixed(outf, SledsSnap[i].direct, 2(*place*), 8);
            WriteCard(outf, ORD(SledsSnap[i].color), 2);
            WriteLn(outf);

            (*CalcOutputSegs(SledsSnap[i], outputSegs);*)
            WriteCard(outf, SledsSnap[i].TrailNumPoints, 4);

            WriteOutputSegs(SledsSnap[i]);
            WriteLn(outf);
         END;

      END;
   END;
   WriteString(outf, "end");
   WriteLn(outf);

   DISPOSE(SnapCache);

   Close(outf);

   STextIO.WriteLn;
END;

RETURN TRUE;

END CloseOutFile;

(*============================================================================*)
 PROCEDURE PutNextState(pTime:REAL; Pucks:PuckObjsDesc; Bumpers:BumperObjsDesc;
                        Sleds:SledObjsDesc):BOOLEAN;
(*============================================================================*)

BEGIN

Assert(SnapNumber < TurnsPerGame*MaxStepsPerTurn, "Too many snapshots in trace file");

WITH SnapCache^[SnapNumber] DO
   Time := pTime;
   PucksSnap := Pucks;
   BumpersSnap := Bumpers;
   SledsSnap := Sleds;
END;

INC(SnapNumber);

RETURN TRUE;

END PutNextState;

(*-----------------------------------------------------------*)
 PROCEDURE NextInt(VAR int:INTEGER; VAR inx:INTEGER):BOOLEAN;
(*-----------------------------------------------------------*)

VAR  cRes     :ConvResults;

BEGIN

DynStr2A.dNextToken(OneLine, DynStr2A.WhiteSpace, OneToken, inx);
IF OneToken.len = 0 THEN
   RETURN FALSE;
END;

StrToInt(OneToken.str^, int, cRes);
IF cRes # strAllRight THEN
   RETURN FALSE;
END;

RETURN TRUE;

END NextInt;

(*-------------------------------------------------------------*)
 PROCEDURE NextCard(VAR card:CARDINAL; VAR inx:INTEGER):BOOLEAN;
(*-------------------------------------------------------------*)

VAR  cRes     :ConvResults;

BEGIN

DynStr2A.dNextToken(OneLine, DynStr2A.WhiteSpace, OneToken, inx);
IF OneToken.len = 0 THEN
   RETURN FALSE;
END;

StrToCard(OneToken.str^, card, cRes);
IF cRes # strAllRight THEN
   RETURN FALSE;
END;

RETURN TRUE;

END NextCard;

(*-------------------------------------------------------*)
 PROCEDURE NextReal(VAR r:REAL; VAR inx:INTEGER):BOOLEAN; 
(*-------------------------------------------------------*)

VAR  cRes     :ConvResults;

BEGIN

DynStr2A.dNextToken(OneLine, DynStr2A.WhiteSpace, OneToken, inx);
IF OneToken.len = 0 THEN
   RETURN FALSE;
END;

StrToReal(OneToken.str^, r, cRes);
IF cRes # strAllRight THEN
   RETURN FALSE;
END;

RETURN TRUE;

END NextReal;

(*-------------------------------------------------------*)
 PROCEDURE NextPoint(VAR v:Point; VAR inx:INTEGER):BOOLEAN;
(*-------------------------------------------------------*)

BEGIN

IF NOT NextReal(v[X], inx) OR NOT NextReal(v[Y], inx) THEN
   RETURN FALSE;
END;

RETURN TRUE;

END NextPoint;

(*--------------------------------------------------------------*)
 PROCEDURE NextColor(VAR c:GameColors; VAR inx:INTEGER):BOOLEAN;
(*--------------------------------------------------------------*)

VAR cRes     :ConvResults;
    cColor   :CARDINAL;

BEGIN

DynStr2A.dNextToken(OneLine, DynStr2A.WhiteSpace, OneToken, inx);
IF OneToken.len = 0 THEN
   RETURN FALSE;
END;

StrToCard(OneToken.str^, cColor, cRes);
IF (cRes # strAllRight) OR (cColor > ORD(MAX(GameColors))) THEN
   RETURN FALSE;
END;

c := VAL(GameColors, cColor);

RETURN TRUE;

END NextColor;

(*----------------------------------------*)
 PROCEDURE ReadUntil(token:DynStr):BOOLEAN;
(*----------------------------------------*)

VAR NumSkipped  :CARDINAL;
    pos         :INTEGER;
    rRes        :ReadResults;

BEGIN

REPEAT
   rRes := dReadNextNonBlankLine(inf, OneLine, NumSkipped);
   IF rRes # allRight THEN
      RETURN FALSE;
   END;

   pos := DynStr1NC.dStrPosNC(OneLine, token, 0);
   IF pos = 0 THEN
      RETURN TRUE;
   END;

UNTIL FALSE;

END ReadUntil;

(*-----------------------------------------*)
 PROCEDURE ReadTime(VAR Time:REAL):BOOLEAN;
(*-----------------------------------------*)

VAR  inx   :INTEGER;

BEGIN

(* OneLine alfeady filled *)

inx := 0;
DynStr2A.dNextToken(OneLine, DynStr2A.WhiteSpace, OneToken, inx);  (* skip "snapshot " *)

RETURN NextReal(Time, inx);

END ReadTime;

(*------------------------------------------------*)
 PROCEDURE ReadPucks(VAR Pucks:PuckObjsDesc):BOOLEAN;
(*------------------------------------------------*)

VAR NumSkipped  :CARDINAL;
    inx,
    i,
    Num         :INTEGER;
    rRes        :ReadResults;

BEGIN

rRes := dReadNextNonBlankLine(inf, OneLine, NumSkipped);
IF rRes # allRight THEN
   RETURN FALSE;
END;

inx := 0;
IF NOT NextInt(Num, inx) THEN
   RETURN FALSE;
END;

IF DEBUG THEN DebugOn(0); DebugPause("ReadPucks: NumPucks", Num); END;
FOR i := 0 TO Num-1 DO

   rRes := dReadNextNonBlankLine(inf, OneLine, NumSkipped);
   IF rRes # allRight THEN
      RETURN FALSE;
   END;

   inx := 0;
   IF NOT NextPoint(Pucks[i].pos, inx) THEN
      RETURN FALSE;
   END;

   IF NOT NextColor(Pucks[i].color, inx) THEN
      RETURN FALSE;
   END;

   IF DEBUG THEN DebugReal2("ReadPucks: PuckPos", i, Pucks[i].pos[X], Pucks[i].pos[Y]); END;

END;

RETURN TRUE;

END ReadPucks;

(*-------------------------------------------------------*)
 PROCEDURE ReadBumpers(VAR Bumpers:BumperObjsDesc):BOOLEAN;
(*-------------------------------------------------------*)

VAR NumSkipped  :CARDINAL;
    inx,
    i,
    Num         :INTEGER;
    rRes        :ReadResults;

BEGIN

rRes := dReadNextNonBlankLine(inf, OneLine, NumSkipped);
IF rRes # allRight THEN
   RETURN FALSE;
END;

inx := 0;
IF NOT NextInt(Num, inx) THEN
   RETURN FALSE;
END;

IF DEBUG THEN DebugOn(0); DebugPause("ReadBumpers: NumBumpers", Num); END;
FOR i := 0 TO Num-1 DO

   rRes := dReadNextNonBlankLine(inf, OneLine, NumSkipped);
   IF rRes # allRight THEN
      RETURN FALSE;
   END;

   inx := 0;
   IF NOT NextPoint(Bumpers[i].pos, inx) THEN
      RETURN FALSE;
   END;

   IF NOT NextColor(Bumpers[i].color, inx) THEN
      RETURN FALSE;
   END;

   IF DEBUG THEN DebugReal2("ReadBumpers: BumperPos", i, Bumpers[i].pos[X], Bumpers[i].pos[Y]); END;

END;

RETURN TRUE;

END ReadBumpers;

(*--------------------------------------------------*)
 PROCEDURE ReadSleds(VAR Sleds:SledObjsDesc):BOOLEAN;
(*--------------------------------------------------*)

VAR NumSkipped  :CARDINAL;
    inx,
    i, j,
    NumSleds    :INTEGER;
    iNumSegs    :INTEGER;
    rRes        :ReadResults;

BEGIN

rRes := dReadNextNonBlankLine(inf, OneLine, NumSkipped);
IF rRes # allRight THEN
   RETURN FALSE;
END;

inx := 0;
IF NOT NextInt(NumSleds, inx) THEN
   RETURN FALSE;
END;

IF DEBUG THEN DebugOn(0); DebugPause("ReadSleds: Num", NumSleds); END;
FOR i := 0 TO NumSleds-1 DO

   rRes := dReadNextNonBlankLine(inf, OneLine, NumSkipped);
   IF rRes # allRight THEN
      RETURN FALSE;
   END;

   inx := 0;
   IF NOT NextPoint(Sleds[i].pos, inx) THEN
      RETURN FALSE;
   END;

   IF NOT NextReal(Sleds[i].direct, inx) THEN
      RETURN FALSE;
   END;

   IF NOT NextColor(Sleds[i].color, inx) THEN
      RETURN FALSE;
   END;

   IF DEBUG THEN DebugReal2("ReadSleds: SledPos", i, Sleds[i].pos[X], Sleds[i].pos[Y]); END;

   rRes := dReadNextNonBlankLine(inf, OneLine, NumSkipped);
   IF rRes # allRight THEN
      RETURN FALSE;
   END;

   inx := 0;
   IF NOT NextInt(iNumSegs, inx) THEN
      RETURN FALSE;
   END;
   Sleds[i].TrailNumPoints := iNumSegs;

   FOR j := 0 TO INT(Sleds[i].TrailNumPoints)-1 DO
      IF NOT NextPoint(Sleds[i].Trail[j], inx) THEN
         RETURN FALSE;
      END;

      IF DEBUG THEN DebugReal2("ReadSleds: Trail[j] p2", j, Sleds[i].Trail[j,X], Sleds[i].Trail[j,Y]); END;
   END;
   Sleds[i].TrailHeadPos := Sleds[i].TrailNumPoints-1;
   IF DEBUG THEN DebugPause("TrailNumPoints", Sleds[i].TrailNumPoints); END;
END;

RETURN TRUE;

END ReadSleds;

(*=======================================================================================*)
 PROCEDURE GetNextState(VAR Time:REAL; VAR Pucks:PuckObjsDesc; VAR Bumpers:BumperObjsDesc;
                        VAR Sleds:SledObjsDesc):BOOLEAN;
(*=======================================================================================*)

BEGIN

IF NOT ReadUntil(strtTok) THEN
   RETURN FALSE;
END;

Assert(ReadTime(Time), "TraceFileIO: ReadTime() FAILED");
IF DEBUG THEN DebugOn(0); DebugReal("GetNextState: Time", 0, Time); END;

Assert(ReadPucks(Pucks), "TraceFileIO: ReadPucks() FAILED");

Assert(ReadBumpers(Bumpers), "TraceFileIO: ReadBumpers() FAILED");

Assert(ReadSleds(Sleds), "TraceFileIO: ReadSleds() FAILED");

RETURN TRUE;

END GetNextState;

(*-----*)
 BEGIN
(*-----*)

inf := InvalidChan();
outf := InvalidChan();
SnapCache := NIL;
SnapNumber := 0;

DynStr0.dStrCreate(OneLine, 132);
DynStr0.dStrCreate(OneToken, 40);

DynStr0.dStrInC("snapshot", strtTok);

(*-----*)
 FINALLY
(*-----*)

bRes := CloseOutFile();
bRes := CloseInFile();

END TraceFileIO.


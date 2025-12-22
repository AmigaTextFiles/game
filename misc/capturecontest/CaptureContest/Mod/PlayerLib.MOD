
(*##################################*)
 IMPLEMENTATION MODULE PlayerLib;        (* $VER: PlayerLib.mod 0.0 (29.1.2011) *)
(*##################################*)

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

FROM Assertions IMPORT Assert;
FROM Debugging  IMPORT DebugOn, DebugPause;

FROM RealStr    IMPORT RealToFixed, RealToFloat, StrToReal;
FROM WholeStr   IMPORT ConvResults, IntToStr, StrToInt;
IMPORT STextIO, SWholeIO;

FROM CaptureSpecs    IMPORT NumBumpers, NumPucks, NumSleds,
                            TrailMaxPoints;

FROM DynStr0         IMPORT DynStr;
FROM DynStr3Policies IMPORT dsAllocDeallocPolicies, dsAllocDeallocPolicyAttributes, dsAttributeSet,
                            SetEmbeddedDynStrPolicy;
FROM PipeIO          IMPORT ClosePipe, dReadPipeLine, FlushPipe, PipeFile, ReadPipe,
                            WritePipe, WriteStringPipe;

IMPORT DynStr0, DynStr1, DynStr2A, Str0, Str1;

CONST DEBUG        = FALSE;
      DEBUGhndshk  = FALSE;
      (*DEBUGTurnSeq = FALSE;*)
      DEBUGinstate = FALSE;

VAR  OneLine,
     token         :DynStr;

     InPipe,
     OutPipe       :PipeFile;

(*=============================================================*)
 PROCEDURE DebugReal(msg:ARRAY OF CHAR; i:INTEGER; r:REAL);
(*=============================================================*)

VAR lmsg   :Str0.String80;
    numstr :Str0.String16;

BEGIN

Str0.StrAsg(msg, lmsg); Str1.StrCat(" ", lmsg);
RealToFixed(r, 2, numstr);
Str1.StrCat(numstr, lmsg);
DebugPause(lmsg, i);

END DebugReal;

(*===============================================================*)
 PROCEDURE DebugReal2(msg:ARRAY OF CHAR; i:INTEGER; r1, r2:REAL);
(*===============================================================*)

VAR lmsg   :Str0.String80;
    numstr :Str0.String16;

BEGIN

Str0.StrAsg(msg, lmsg); Str1.StrCat(" ", lmsg);
RealToFixed(r1, 3, numstr);
Str1.StrCat(numstr, lmsg); Str1.StrCat(",", lmsg);
RealToFixed(r2, 3, numstr);
Str1.StrCat(numstr, lmsg);
DebugPause(lmsg, i);

END DebugReal2;

(*=============================*)
 PROCEDURE WriteLn(f:PipeFile);
(*=============================*)

BEGIN

Assert(WritePipe(f, LF), "WriteLn FAIL");

END WriteLn;

(*=================================================*)
 PROCEDURE WriteString(f:PipeFile; s:ARRAY OF CHAR);
(*=================================================*)
BEGIN

Assert(WriteStringPipe(f, s), "WriteString FAIL");

END WriteString;

(*========================================*)
 PROCEDURE WriteInt(f:PipeFile; i:INTEGER);
(*========================================*)

VAR  numstr :Str0.String16;

BEGIN

IntToStr(i, numstr);
WriteString(f, numstr);

END WriteInt;

(*==========================================*)
 PROCEDURE WriteReal(f:PipeFile; r:REAL);
(*==========================================*)

VAR numstr :Str0.String16;

BEGIN

RealToFixed(r, 2(*place*), numstr);
(*RealToFloat(r, 7(*sigFigs*), numstr);*)
WriteString(f, numstr);

END WriteReal;

(*===========================================*)
 PROCEDURE WritePoint(f:PipeFile; p:Point);
(*===========================================*)
BEGIN

WriteReal(f, p[X]);
WriteString(f, " ");
WriteReal(f, p[Y]);

END WritePoint;

(*===================================================================================*)
 PROCEDURE OutGameMove(f:PipeFile; Bump1Accel, Bump2Accel:Point; SledTurn:REAL);
(*===================================================================================*)

BEGIN

(*IF DEBUGhndshk THEN DebugOn(0); DebugPause("OutGameMove -> ", 0); END;*)
(*STextIO.WriteString("OutGameMove -> "); STextIO.WriteString(CmdPipe.pipeName); STextIO.WriteLn;*)

WritePoint(f, Bump1Accel); WriteString(f, " ");            (* Writes here should probably include at least 2 digits right of decimal point *)
WritePoint(f, Bump2Accel); WriteString(f, " ");
WriteReal(f, SledTurn);
WriteLn(f);

(*FlushPipe(pipeF); <<< careful, what is the definition of FlushPipe? *)

(*IF DEBUGhndshk THEN DebugOn(0); DebugPause("OutGameMove exit", 0); END;*)
(*STextIO.WriteString("OutGameMove exit ");STextIO.WriteString(CmdPipe.pipeName); STextIO.WriteLn;*)

END OutGameMove;

(*---------------------------------------------------------------*)
 PROCEDURE NxtLine(VAR inx:INTEGER);
(*---------------------------------------------------------------*)

VAR  bRes  :BOOLEAN;

BEGIN

bRes := dReadPipeLine(InPipe, OneLine);
Assert(bRes, "NxtLine?");

inx := 0;

IF DEBUGinstate THEN
   STextIO.WriteString(OneLine.str^); STextIO.WriteLn;
END;

IF DEBUG THEN DebugPause(OneLine.str^, OneLine.len); END;

END NxtLine;

(*-----------------------------------------------------------------*)
 PROCEDURE ReadInt(VAR inx:INTEGER; VAR i:INTEGER);
(*-----------------------------------------------------------------*)

VAR ch   :CHAR;
    cRes :ConvResults;

BEGIN

DynStr2A.dNextToken(OneLine, DynStr2A.WhiteSpace, token, inx);

StrToInt(token.str^, i, cRes);
Assert(cRes = strAllRight, "ReadInt?");

END ReadInt;

(*-------------------------------------------------------------------*)
 PROCEDURE ReadReal(VAR inx:INTEGER; VAR r:REAL);
(*-------------------------------------------------------------------*)

VAR ch   :CHAR;
    cRes :ConvResults;

BEGIN

DynStr2A.dNextToken(OneLine, DynStr2A.WhiteSpace, token, inx);

StrToReal(token.str^, r, cRes);
Assert(cRes = strAllRight, "ReadReal?");

END ReadReal;

(*----------------------------------------------------------------------*)
 PROCEDURE ReadColor(VAR inx:INTEGER; VAR c:GameColors);
(*----------------------------------------------------------------------*)

BEGIN

DynStr2A.dNextToken(OneLine, DynStr2A.WhiteSpace, token, inx);

IF DynStr1.dStr0Cmp("2", token) = 0 THEN
   c := GreyColor;
ELSIF DynStr1.dStr0Cmp("0", token) = 0 THEN
   c := MyColor;
ELSIF DynStr1.dStr0Cmp("1", token) = 0 THEN
   c := HisColor;
ELSE
   Assert(FALSE, "color?");
END;

END ReadColor;

(*---------------------------------------------------------------------*)
 PROCEDURE ReadPoint(VAR inx:INTEGER; VAR Val:Point);
(*---------------------------------------------------------------------*)

VAR  cRes     :ConvResults;

BEGIN

DynStr2A.dNextToken(OneLine, DynStr2A.WhiteSpace, token, inx);

StrToReal(token.str^, Val[X], cRes);
Assert(cRes = strAllRight, "Vec[X]?");

DynStr2A.dNextToken(OneLine, DynStr2A.WhiteSpace, token, inx);

StrToReal(token.str^, Val[Y], cRes);
Assert(cRes = strAllRight, "Vec[Y]?");

END ReadPoint;

(*============================================================*)
 PROCEDURE ReadPuck(VAR Puck:PuckInfo);
(*============================================================*)

VAR inx  :INTEGER;

BEGIN

NxtLine(inx);
(*IF DEBUGhndshk THEN DebugPause(OneLine.str^, 0); END;*)

ReadPoint(inx, Puck.pos);
ReadPoint(inx, Puck.speed);

ReadColor(inx, Puck.color);

END ReadPuck;

(*============================================================*)
 PROCEDURE ReadBumper(VAR Bumper:BumperInfo);
(*============================================================*)

VAR inx  :INTEGER;

BEGIN

NxtLine(inx);

ReadPoint(inx, Bumper.pos);
ReadPoint(inx, Bumper.speed);

END ReadBumper;

(*=====================================*)
 PROCEDURE ReadSled(VAR Sled:SledInfo);
(*=====================================*)

VAR  i,
     inx  :INTEGER;

BEGIN WITH Sled DO

NxtLine(inx);

ReadPoint(inx, pos);
ReadReal(inx, direct);

NxtLine(inx);

ReadInt(inx, TrailNumPoints);

FOR i := 0 TO TrailNumPoints-1 DO
   ReadPoint(inx, Trail[i]);
END;

END END ReadSled;

(*==========================================================================================================================*)
 PROCEDURE InGameState(f:PipeFile; VAR TurnNum:INTEGER; VAR Pucks:PucksArray; VAR Bumpers:BumpersArray; VAR Sleds:SledsArray);
(*==========================================================================================================================*)

VAR  i,
     inx           :INTEGER;
     NumPucksSent,
     NumBumpersSent,
     NumSledsSent  :INTEGER;
     cRes          :ConvResults;
     bRes          :BOOLEAN;

BEGIN
IF DEBUGhndshk THEN (*DebugOn(0);*) DebugPause("InGameState -> ", 0); END;
(*STextIO.WriteString("InGameState -> "); STextIO.WriteString(StatePipe.pipeName); STextIO.WriteLn;*)

InPipe := f;

NxtLine(inx);
ReadInt(inx, TurnNum);
DebugPause(OneLine.str^, inx);
DebugPause(token.str^, token.len);
DebugPause("Player LIB: TurnNum", TurnNum);

IF DEBUGhndshk THEN DebugPause("FirstLine Read", TurnNum); END;

NxtLine(inx);
ReadInt(inx, NumPucksSent);
Assert(NumPucksSent = NumPucks, "NumPucksSent?");

IF DEBUGhndshk THEN DebugPause("SecondLine Read", NumPucks); END;

(*
IF Pucks = NIL THEN
   ALLOCATE(Pucks, SIZE(PuckInfo)*NumPucks);
END;
*)

FOR i := 0 TO NumPucks-1 DO
   ReadPuck(Pucks[i]);
END;

NxtLine(inx);
ReadInt(inx, NumBumpersSent);
Assert(NumBumpersSent = NumBumpers, "NumBumpersSent?");

FOR i := 0 TO NumBumpers-1 DO
   ReadBumper(Bumpers[i]);
END;

NxtLine(inx);
ReadInt(inx, NumSledsSent);
Assert(NumSledsSent = NumSleds, "NumSledsSent?");

FOR i := 0 TO NumSleds-1 DO
   ReadSled(Sleds[i]);
END;

(*DEBUG*)
(*INC(TurnNum);*)
(*IF TurnNum >= 900 THEN
   TurnNum := -1;
END;*)

IF DEBUGhndshk THEN (*DebugOn(0);*) DebugPause("InGameState exit -> ", 0); END;
(*STextIO.WriteString("InGameState exit "); STextIO.WriteString(StatePipe.pipeName); STextIO.WriteLn;*)

END InGameState;

(*----*)
 BEGIN
(*----*)

SetEmbeddedDynStrPolicy(dsExpectedRangePolicy, dsAttributeSet{dsDontShrink}, TrailMaxPoints*12(*ExpectedSize*),
                        TrailMaxPoints*12(*ExpectedLong*), 0(*ShrinkThreshold*));

DynStr0.dStrCreate(OneLine, TrailMaxPoints*12);
DynStr0.dStrCreate(token, 32);

END PlayerLib.

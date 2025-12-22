
(*##################################*)
 IMPLEMENTATION MODULE CaptureDebug;        (* $VER: CaptureDebug.MOD 0.0 (16.12.2010) *)
(*##################################*)
FROM Debugging IMPORT Debug, DebugOn, DebugPause;

FROM RealStr  IMPORT RealToFixed;
FROM SRealIO  IMPORT WriteFixed;
FROM STextIO  IMPORT WriteLn, WriteString;
FROM SWholeIO IMPORT WriteInt;

FROM CaptureSpecs IMPORT LineSeg, Point;
(*FROM CaptureDefs  IMPORT CollideObj, MovingObjects, Sleds;*)

FROM SimpleGraphics IMPORT XY;

IMPORT Str0, Str1;

(*==============================================================*)
 PROCEDURE DebugReal2(msg:ARRAY OF CHAR; i:INTEGER; r1, r2:REAL);
(*==============================================================*)

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

(*==============================================================*)
 PROCEDURE DebugReal(msg:ARRAY OF CHAR; i:INTEGER; r:REAL);
(*==============================================================*)

VAR lmsg   :Str0.String80;
    numstr :Str0.String16;

BEGIN

Str0.StrAsg(msg, lmsg); Str1.StrCat(" ", lmsg);
RealToFixed(r, 3, numstr);
Str1.StrCat(numstr, lmsg);
DebugPause(lmsg, i);

END DebugReal;

(*==================*)
 PROCEDURE LineFeed;
(*==================*)
BEGIN

WriteLn;

END LineFeed;
 
(*=====================================*)
 PROCEDURE PrintMsg(msg:ARRAY OF CHAR);
(*=====================================*)
BEGIN

WriteString(msg); WriteString(" ");

END PrintMsg;

(*=====================================*)
 PROCEDURE PrintMsg2(msg1, msg2:ARRAY OF CHAR);
(*=====================================*)
BEGIN

PrintMsg(msg1); PrintMsg(msg2);

END PrintMsg2;

(*================================================*)
 PROCEDURE PrintInt(msg:ARRAY OF CHAR; i:INTEGER);
(*================================================*)
BEGIN

PrintMsg(msg); 
WriteInt(i, 1);

END PrintInt;

(*==================================================*)
 PROCEDURE PrintReal(msg:ARRAY OF CHAR; r:REAL);
(*==================================================*)
BEGIN

PrintMsg(msg);
WriteFixed(r, 3, 1);

END PrintReal;

(*=================================================*)
 PROCEDURE PrintPoint(msg:ARRAY OF CHAR; p:Point);
(*=================================================*)
BEGIN

PrintMsg(msg); WriteString("(");
WriteFixed(p[X], 3, 1); WriteString(",");
WriteFixed(p[Y], 3, 1); WriteString(")");

END PrintPoint;

(*===================================================*)
 PROCEDURE PrintLine(msg:ARRAY OF CHAR; lin:LineSeg);
(*===================================================*)
BEGIN

PrintMsg(msg); WriteString("(");
WriteFixed(lin.p1[X], 3, 1); WriteString(",");
WriteFixed(lin.p1[Y], 3, 1); WriteString(")");
WriteString(" - (");
WriteFixed(lin.p2[X], 3, 1); WriteString(",");
WriteFixed(lin.p2[Y], 3, 1); WriteString(")");
(*IF lin.hidden THEN
   PrintMsg(" HIDDEN");
END;*)

END PrintLine;

(*
(*======================================*)
 PROCEDURE PrintSledState(sld:CARDINAL);
(*======================================*)

VAR i :INTEGER;

BEGIN

WITH Sleds[sld] DO
   LineFeed;
   PrintPoint("pos:", pos); PrintReal(" direct:", direct); LineFeed;
   PrintInt("TrailNumPoints:", TrailNumPoints); PrintInt(" TrailHeadPos:", TrailHeadPos); LineFeed;
   PrintPoint("loopP", loopP); PrintInt(" loopSeg:", loopSeg); LineFeed;
   FOR i := 0 TO VAL(INTEGER, TrailNumPoints)-1 DO
      PrintInt("#", i); PrintLine("  ", Trail[i]); LineFeed;
   END;
END;

END PrintSledState;
*)

(*=================================================*)
 PROCEDURE DebugPoint(msg:ARRAY OF CHAR; p:Point);
(*=================================================*)

VAR lmsg   :Str0.String80;
    numstr :Str0.String16;

BEGIN

Str0.StrAsg(msg, lmsg); Str1.StrCat(" (", lmsg);
RealToFixed(p[X], 3, numstr);
Str1.StrCat(numstr, lmsg); Str1.StrCat(",", lmsg);
RealToFixed(p[Y], 3, numstr);
Str1.StrCat(numstr, lmsg);  Str1.StrCat(")", lmsg);
DebugPause(lmsg, 0);

END DebugPoint;

(*===================================================*)
 PROCEDURE DebugLine(msg:ARRAY OF CHAR; lin:LineSeg);
(*===================================================*)

VAR lmsg   :Str0.String80;
    numstr :Str0.String16;

BEGIN

Str0.StrAsg(msg, lmsg); Str1.StrCat(" (", lmsg);
RealToFixed(lin.p1[X], 3, numstr);
Str1.StrCat(numstr, lmsg); Str1.StrCat(",", lmsg);
RealToFixed(lin.p1[Y], 3, numstr);
Str1.StrCat(numstr, lmsg); Str1.StrCat(")", lmsg);

RealToFixed(lin.p2[X], 3, numstr); Str1.StrCat(" -> (", lmsg);
Str1.StrCat(numstr, lmsg); Str1.StrCat(",", lmsg);
RealToFixed(lin.p2[Y], 3, numstr);
Str1.StrCat(numstr, lmsg);  Str1.StrCat(")", lmsg);

DebugPause(lmsg, 0);

END DebugLine;

(*
(*===========================================*)
 PROCEDURE DebugBumper(WhichBumper:CARDINAL);
(*===========================================*)

BEGIN WITH MovingObjects[BumperObj]^[WhichBumper] DO

DebugPause("Bumper", WhichBumper);

DebugReal2("pos ", WhichBumper, pos[X], pos[Y]);
DebugReal2("prevpos ", WhichBumper, prevpos[X], prevpos[Y]);
DebugReal2("speed ", WhichBumper, speed[X], speed[Y]);
(*DebugReal("velocity ", WhichBumper, veloc);*)
IF moved AND marked THEN
   DebugPause("moved and marked", 0);
ELSIF moved THEN
   DebugPause("moved", 0);
ELSIF marked THEN
   DebugPause("marked", 0);

END;

END END DebugBumper;

(*=========================================*)
 PROCEDURE DebugPuck(WhichPuck:CARDINAL);
(*=========================================*)

BEGIN WITH MovingObjects[PuckObj]^[WhichPuck] DO
DebugPause("Puck", WhichPuck);

DebugReal2("pos ", WhichPuck, pos[X], pos[Y]);
DebugReal2("speed ", WhichPuck, speed[X], speed[Y]);
DebugReal("velocity ", WhichPuck, veloc);

END END DebugPuck;
*)

BEGIN

END CaptureDebug.


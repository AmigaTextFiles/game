
(*#####################################*)
 IMPLEMENTATION MODULE CaptureGraphics;        (* $VER: CaptureGraphics.MOD 0.0 (29.1.2011) *)
(*#####################################*)

FROM Storage        IMPORT ALLOCATE;
FROM Assertions     IMPORT Assert;
FROM Debugging      IMPORT DebugOn, DebugPause;

FROM RealMath       IMPORT cos, sin, pi;

FROM CaptureSpecs   IMPORT BlueSledIndex, BumperIndices, BumperObjsDesc, BumperRadius, GameColors, IsHidden,
                           LineSeg, MyBumperIndices, NumPucks, PuckObjsDesc, PuckRadius, RedSledIndex,
                           ScreenSize, SledObjsDesc, TrailMaxPoints;
FROM CaptureDebug   IMPORT DebugReal2, LineFeed, PrintInt, PrintLine, PrintMsg;

FROM Obj            IMPORT oo;
FROM SimpleGraphics IMPORT BLACKscr, BLUEscr, BROWNscr, BufferedScreen, BufferedScreenDelete, BufferedScreenNew,
                           CustomInfoType, CustomInfoTypePtr, ExtentType,
                           GraphPlot, GraphPlotLineStyles, GraphPlotMarks, GraphPlotNew,
                           GraphRegion, GraphRegionDelete, GraphRegionNew,
                           GraphScreenType, GREENscr, lohi, REDscr, RegionAttributesSet,
                           ScreenClass, (*Screen, ScreenDelete, ScreenNew,*)
                           XY;

VAR  ci          :CustomInfoTypePtr;
     UpdExtent   :ExtentType;

CONST DEBUG = FALSE;

(*==========================================================*)
 PROCEDURE DrawPuck(WhichPuck:CARDINAL; Pucks:PuckObjsDesc);
(*==========================================================*)

VAR  fillcolor :CARDINAL;

BEGIN WITH Pucks[WhichPuck] DO

(*DebugPause("DrawPuck", WhichPuck);*)

IF moved THEN
   (*ErasePuck(WhichPuck);*)
   moved := FALSE;
END;

CASE color OF
   RedPlayer:  fillcolor := REDscr;      |
   BluePlayer: fillcolor := BLUEscr;     |
   NoPlayer:   fillcolor := BROWNscr;    |
END;

GamePlt^.vf^.SetBackColor(GamePlt, fillcolor);

GamePlt^.vf^.Ellipse(GamePlt, pos[X], pos[Y], PuckRadius, PuckRadius, TRUE(*filled*));

END END DrawPuck;

(*======================================*)
 PROCEDURE DrawPucks(Pucks:PuckObjsDesc);
(*======================================*)

VAR  i :INTEGER;

BEGIN

IF DEBUG THEN DebugOn(0); DebugPause("DrawPucks", 0); END;
FOR i := 0 TO NumPucks-1 DO
   DrawPuck(i, Pucks);
END;

(*(*DEBUG*)GamePlt^.vf^.Ellipse(GamePlt, 105.5, 694.5, 95.5, 95.5, FALSE(*filled*));*)

END DrawPucks;

(*=================================================================*)
 PROCEDURE DrawBumper(WhichBumper:CARDINAL; Bumpers:BumperObjsDesc);
(*=================================================================*)

VAR  drawcolor :CARDINAL;

BEGIN WITH Bumpers[WhichBumper] DO

IF moved THEN
   moved := FALSE;
END;

IF color = RedPlayer THEN
   drawcolor := REDscr;
ELSE
   drawcolor := BLUEscr;
END;

GamePlt^.vf^.SetBackColor(GamePlt, drawcolor);
(*GamePlt^.vf^.SetForeColor(GamePlt, drawcolor);*)

GamePlt^.vf^.Ellipse(GamePlt, pos[X], pos[Y], BumperRadius, BumperRadius, TRUE(*filled*));

(*GamePlt^.vf^.Mark(GamePlt, VAL(REAL, pos[X]), VAL(REAL, pos[Y]), XMARKgp);*)

END END DrawBumper;

(*============================================*)
 PROCEDURE DrawBumpers(Bumpers:BumperObjsDesc);
(*============================================*)

VAR  i :INTEGER;

BEGIN

FOR i := MIN(BumperIndices) TO MAX(BumperIndices) DO
   DrawBumper(i, Bumpers);
END;

END DrawBumpers;

(*=========================================================*)
 PROCEDURE DrawSled(WhichSled:CARDINAL; Sleds:SledObjsDesc);
(*=========================================================*)

CONST ArrowArms = 330.0 / 360.0 * 2.0 * pi;
      h         = 2.0 *  BumperRadius;

VAR  drawcolor :CARDINAL;
     (*tpos      :CARDINAL;*)
     i, j      :INTEGER;
     x1, y1,
     x2, y2,
     x3, y3    :REAL;
     cosDir,
     sinDir,
     ang       :REAL;
     lseg      :LineSeg;

BEGIN WITH Sleds[WhichSled] DO

IF DEBUG THEN DebugOn(0); DebugPause("DrawSled", WhichSled); END;

IF color = RedPlayer THEN
   drawcolor := REDscr;
ELSE
   drawcolor := BLUEscr;
END;

IF DEBUG THEN DebugReal2("DrawSled: sled pos", 0, pos[X], pos[Y]); END;

GamePlt^.vf^.SetForeColor(GamePlt, drawcolor);
GamePlt^.vf^.SetBackColor(GamePlt, drawcolor);

cosDir := cos(direct);
sinDir := sin(direct);
IF cosDir # 0.0 THEN
   x1 := pos[X] + (h / 2.0) * cosDir;
ELSE
   x1 := pos[X];
END;
IF sinDir # 0.0 THEN
   y1 := pos[Y] + (h / 2.0) * sinDir;
ELSE
   y1 := pos[Y];
END;

(*GamePlt^.vf^.Line(GamePlt, pos[X], pos[Y], x1, y1);*)

ang := direct + ArrowArms;
x2 := h * cos(ang);
y2 := h * sin(ang);

GamePlt^.vf^.Line(GamePlt, x1, y1, x1-x2, y1-y2);

ang := direct - ArrowArms;
x3 := h * cos(ang);
y3 := h * sin(ang);

GamePlt^.vf^.Line(GamePlt, x1, y1, x1-x3, y1-y3);

GamePlt^.vf^.Line(GamePlt, x1, y1, pos[X], pos[Y]);

(*x1 := pos[X];*)
(*y1 := pos[Y];*)

(*GamePlt^.vf^.SetLineStyle(GamePlt, DASHEDgp);*)

IF DEBUG THEN DebugPause("DrawSled: TrailHeadPos", TrailHeadPos); END;
IF DEBUG THEN DebugPause("DrawSled: TrailNumPoints", TrailNumPoints); END;

(*DebugOn(0); DebugPause("tpos", tpos);*)
j := TrailHeadPos;
lseg.p2[X] := Trail[j, X];
lseg.p2[Y] := Trail[j, Y];

(*PrintInt("graphics numpoints", TrailNumPoints); LineFeed;*)
(*PrintInt("graphics headposition", TrailHeadPos); LineFeed;*)

(*DebugOn(0); DebugPause("DrawSled TrailNumPoints", TrailNumPoints);*)
FOR i := 0 TO VAL(INTEGER, TrailNumPoints)-2 DO        (* line segs is one fewer line segment than number of points *)

   lseg.p1 := lseg.p2;

   j := (j + TrailMaxPoints -1) MOD TrailMaxPoints;       (* decrement with wrap-around *)

   (*(*DEBUG*)IF PauseMode THEN*)
   (*   PrintInt("i", i); PrintMsg("  "); PrintInt("j", j); LineFeed;*)
   (*(*DEBUG*)END;*)

   lseg.p2[X] := Trail[j, X];
   lseg.p2[Y] := Trail[j, Y];

   IF DEBUG THEN DebugReal2("DrawSled: x1 y1", j, lseg.p1[X], lseg.p1[Y]); END;
   IF DEBUG THEN DebugReal2("DrawSled: x2 y2", j, lseg.p2[X], lseg.p2[Y]); END;

   IF NOT IsHidden(lseg) THEN
      GamePlt^.vf^.Line(GamePlt, lseg.p1[X], lseg.p1[Y], lseg.p2[X], lseg.p2[Y]);
   (*(*DEBUG*)ELSE*)
   (*(*DEBUG*)   (*PauseMode := TRUE;*)*)
   (*            PrintInt("i", i); PrintMsg("  "); PrintInt("j", j); LineFeed;*)
   (*            PrintLine("seg ", lseg); LineFeed;*)
   (*            PrintMsg("^IsHidden"); LineFeed;*)
   END;

   IF DEBUG THEN IF WhichSled = 0 THEN GamePlt^.vf^.Mark(GamePlt, lseg.p1[X], lseg.p1[Y], PIXMARKgp); END; END;

END;
(*GamePlt^.vf^.SetLineStyle(GamePlt, SOLIDgp);*)

END END DrawSled;

(*======================================*)
 PROCEDURE DrawSleds(Sleds:SledObjsDesc);
(*======================================*)

BEGIN

IF DEBUG THEN DebugOn(0); DebugPause("DrawSleds", 0); END;

DrawSled(RedSledIndex, Sleds);
DrawSled(BlueSledIndex, Sleds);

END DrawSleds;

(*=======================*)
 PROCEDURE ShowNextFrame;
(*=======================*)
BEGIN

GameScr^.vf^.UpdScreen(GameScr, curBuf, UpdExtent);     (* WaitTOF() or not in SimpleGraphics does not seem to make a hell of a difference *)

END ShowNextFrame;

(*============================*)
 PROCEDURE SwapDrawingBuffers;
(*============================*)
BEGIN

curBuf := (curBuf+1) MOD 2;
GameScr^.vf^.SetActive(GameScr, curBuf);

GameRgn^.vf^.SetBackColor(GameRgn, GREENscr);
GameRgn^.vf^.Clear(GameRgn);

END SwapDrawingBuffers;

(*========================*)
 PROCEDURE InitGameScreen;
(*========================*)
BEGIN

GameScr := BufferedScreenNew(VideoScreen, 2, ci);
Assert(GameScr # NIL, "ScreenNew FAIL");
GameScr^.vf^.SetActive(GameScr, 0(*-1*));
curBuf := 0(*-1*);

GameRgn := GraphRegionNew(0, 0, TRUNC(ScreenSize)(*-1*), TRUNC(ScreenSize)(*-1*), RegionAttributesSet{}, oo(GameScr, ScreenClass));
Assert(GameRgn # NIL, "GraphRegionNew FAIL");
GameRgn^.vf^.SetBackColor(GameRgn, GREENscr);
GameRgn^.vf^.Clear(GameRgn);

GamePlt := GraphPlotNew(0.0, 0.0, ScreenSize, ScreenSize, oo(GameScr, ScreenClass));
Assert(GameRgn # NIL, "GraphPlotNew FAIL");

END InitGameScreen;

(*-------------------*)
 BEGIN (* mod init *)
(*-------------------*)

GameScr := NIL;
GameRgn := NIL;
GamePlt := NIL;

NEW(ci);
WITH ci^ DO
   Left := 10;
   Top := 10;
   Right := Left + TRUNC(ScreenSize);
   Bottom := Top + TRUNC(ScreenSize);
   ScreenTitle := "Game";
END;

UpdExtent[X, lo] := 5;
UpdExtent[Y, lo] := 5;
UpdExtent[X, hi] := TRUNC(ScreenSize)+5;
UpdExtent[Y, hi] := TRUNC(ScreenSize)+5;

(*------*)
 FINALLY
(*------*)

IF GameScr # NIL THEN
   BufferedScreenDelete(GameScr);
END;

END CaptureGraphics.



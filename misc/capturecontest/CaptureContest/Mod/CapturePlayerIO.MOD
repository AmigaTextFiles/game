
(*####################################*)
 IMPLEMENTATION MODULE CapturePlayerIO;        (* $VER: CapturePlayerIO.mod 0.0 (25.1.2011) *)
(*####################################*)

FROM SYSTEM       IMPORT ADR, CAST, LOC;
FROM Assertions   IMPORT Assert;
FROM Debugging    IMPORT DebugOn, DebugPause;

FROM ChanConsts   IMPORT OpenResults;
FROM RealStr      IMPORT RealToFixed, RealToFloat, StrToReal;
FROM RealIO       IMPORT WriteFixed;
FROM Processes    IMPORT ProcessId, Start;
FROM WholeStr     IMPORT ConvResults, IntToStr, StrToInt;
(*DEBUG*) IMPORT SLongIO, STextIO, SWholeIO;

FROM AmigaDosInterfaces IMPORT IDOS;
FROM UtilityInterfaces  IMPORT IUtility;

IMPORT AmigaDOS;

FROM CaptureDefs     IMPORT CollideObj, MovingObjects,
                            Sleds, StepsPerTurn, TurnNum;
FROM CaptureSpecs    IMPORT BlueSledIndex, BumperIndices, GameColors, GamePlayers, HisBumperIndices, MyBumperIndices,
                            NumBumpers, NumPucks, NumSleds, Point, ScreenSize, TrailMaxPoints;
FROM CaptureEngine   IMPORT ReflectDirection;
FROM CaptureComm     IMPORT StatePipeNameBase, CmdPipeNameBase;
FROM CaptureDebug    IMPORT DebugReal, LineFeed, PrintMsg, PrintMsg2;
FROM SimpleGraphics  IMPORT XY;

FROM DirUtil2        IMPORT FileExists, GetExecutable;
FROM DynStr0         IMPORT DynStr;
FROM OsRun           IMPORT BreakOffspring, GetMyPid, SpawnRedirect;
FROM PipeIO          IMPORT ClosePipe, FlushPipe, InvalidPipe, OpenModes, OpenPipe, PipeFile, ReadPipe,
                            RevealPipeFH, ServePipeFH, SetReadTimeout, (*WritePipe,*) WriteBufferPipe(*,
                            WriteStringPipe*);

IMPORT DirUtil2, DynStr0, DynStr3, MyConversions, Str0, Str1;


CONST  LF      = 12C;
       BufSize = 8192;

CONST  DEBUGcomm     = FALSE;
       DEBUGoutstate = FALSE;

TYPE buffertype = RECORD CASE :BOOLEAN OF TRUE:                      (* <<<- should not be necessary, compiler limitation *)
                     char   :ARRAY[0..BufSize+1] OF CHAR;  |
                                          FALSE:
                     loc    :ARRAY[0..BufSize+1] OF LOC;
                  END END;

TYPE PipeInfo   = RECORD
                    pipeName   :Str0.String16;
                    pipeF      :PipeFile;
                    BufPos     :INTEGER;
                    pipeBuffer :buffertype;         (* <<<- should not be necessary, compiler limitation *)
                  END;
     PipeInfoPtr = POINTER TO PipeInfo;

CONST PipeTimeOut = 200(*10000*); (*DEBUG*)

VAR  StatePipe   :ARRAY GamePlayers OF PipeInfo;
     CmdPipe     :ARRAY GamePlayers OF PipeInfo;

     runId       :CARDINAL;
     runIdStr    :Str0.String16;

     EOL         :Str0.String2;

(*--------------------------------------*)
 PROCEDURE FlushWrtBuffer(inf:PipeInfo);
(*--------------------------------------*)
BEGIN WITH inf DO

(*(*DEBUG*)DebugOn(0); DebugPause("FlushWrtBuffer", BufPos);*)

IF BufPos > 0 THEN

   IF DEBUGoutstate THEN
      STextIO.WriteString("Begin WriteBuffer Flush"); STextIO.WriteLn;
      Str0.StrSet(pipeBuffer.char, BufPos); STextIO.WriteString(pipeBuffer.char); (*STextIO.WriteLn;*)
      STextIO.WriteString("End WriteBuffer Flush"); STextIO.WriteLn;
      (*DebugOn(0); DebugPause("after WriteBufferPipe()", BufSize);*)
   END;

   Assert(WriteBufferPipe(pipeF, pipeBuffer.loc, BufPos), "WriteBufferPipe() FAIL");
   (*Str0.StrSet(pipeBuffer.char, BufPos); STextIO.WriteString(pipeBuffer.char); STextIO.WriteLn;*)
   BufPos := 0;
END;

FlushPipe(pipeF);

END END FlushWrtBuffer;

(*---------------------------------------------------*)
 PROCEDURE WriteString(inf:PipeInfo; s:ARRAY OF CHAR);
(*---------------------------------------------------*)

VAR i,
    len :CARDINAL;
    fin :BOOLEAN;
    (*dbg :BOOLEAN;*)

BEGIN WITH inf DO

fin := FALSE;
i := 0;
(*dbg := FALSE;*)
len := LENGTH(s);

REPEAT

   (*IF dbg THEN DebugPause(s, ORD(s[0]));  DebugPause("i", i); DebugPause("len", len); END;*)
   WHILE (i < len) AND (BufPos < BufSize) DO
      (*IF dbg THEN DebugPause("BufPos", BufPos); DebugPause("char", ORD(pipeBuffer.char[BufPos])); END;*)
      pipeBuffer.char[BufPos] := s[i];
      INC(i);
      INC(BufPos);
   END;

   IF BufPos = BufSize THEN
      (*DebugOn(0); DebugPause("Buf full in CapturePlayerIO.WriteString", BufPos);*)
      IF DEBUGoutstate THEN
         STextIO.WriteString("Begin WriteBuffer"); STextIO.WriteLn;
         Str0.StrSet(pipeBuffer.char, BufSize); STextIO.WriteString(pipeBuffer.char); STextIO.WriteLn;
         STextIO.WriteString("End WriteBuffer"); STextIO.WriteLn;
         (*DebugOn(0); DebugPause("after WriteBufferPipe()", BufSize);*)
      END;

      Assert(WriteBufferPipe(pipeF, pipeBuffer.loc, BufSize), "WriteBufferPipe() FAIL");
      BufPos := 0;
      (*Str1.StrClr(pipeBuffer.char); (*DEBUG*)*)
      (*dbg := TRUE;*)
   ELSE
      fin := TRUE;
   END;

UNTIL fin;

(*IF dbg THEN*)
(*   STextIO.WriteString("New buffer started:"); STextIO.WriteLn;*)
(*   Str0.StrSet(pipeBuffer.char, BufPos); STextIO.WriteString(pipeBuffer.char); STextIO.WriteLn;*)
(*   DebugOn(0); DebugPause("pipeBuffer contents on exit WriteString to Pipe", BufPos);*)
(*   STextIO.WriteString("Buffer contents on exit from WriteString"); STextIO.WriteLn;*)
(*END;*)

Assert(i = LENGTH(s), "CapturePlayerIO.WriteString: buffering bug");

END END WriteString;

(*-----------------------------*)
 PROCEDURE WriteLn(inf:PipeInfo);
(*-----------------------------*)

BEGIN

WriteString(inf, EOL);

END WriteLn;

(*----------------------------------------*)
 PROCEDURE WriteInt(inf:PipeInfo; i:INTEGER);
(*----------------------------------------*)

VAR  numstr :Str0.String16;

BEGIN

IntToStr(i, numstr);
WriteString(inf, numstr);

END WriteInt;

(*------------------------------------------*)
 PROCEDURE WriteReal2p(inf:PipeInfo; r:REAL);
(*------------------------------------------*)

VAR numstr :Str0.String16;

BEGIN

RealToFixed(r, 2(*place*), numstr);

WriteString(inf, numstr);

END WriteReal2p;

(*------------------------------------------*)
 PROCEDURE WriteReal(inf:PipeInfo; r:REAL);
(*------------------------------------------*)

VAR numstr :Str0.String16;

BEGIN

RealToFixed(r, 1(*place*), numstr);

WriteString(inf, numstr);

END WriteReal;

(*-------------------------------------------*)
 PROCEDURE WriteVector(inf:PipeInfo; p:Point);
(*-------------------------------------------*)
BEGIN

WriteReal(inf, p[X]);
WriteString(inf, " ");
WriteReal(inf, p[Y]);

END WriteVector;

(*DEBUG*)(*----------------------------------------*)
(*DEBUG*) PROCEDURE WriteDebugInt(i:INTEGER);
(*DEBUG*)(*----------------------------------------*)
(*DEBUG*)
(*DEBUG*)VAR  numstr :Str0.String16;
(*DEBUG*)
(*DEBUG*)BEGIN
(*DEBUG*)
(*DEBUG*)IntToStr(i, numstr);
(*DEBUG*)STextIO.WriteString(numstr);
(*DEBUG*)
(*DEBUG*)END WriteDebugInt;

(*DEBUG*)(*-----------------------------------*)
(*DEBUG*) PROCEDURE WriteDebugReal(r:REAL);
(*DEBUG*)(*-----------------------------------*)
(*DEBUG*)
(*DEBUG*)VAR numstr :Str0.String16;
(*DEBUG*)
(*DEBUG*)BEGIN
(*DEBUG*)
(*DEBUG*)RealToFixed(r, 1(*place*), numstr);
(*DEBUG*)
(*DEBUG*)STextIO.WriteString(numstr);
(*DEBUG*)
(*DEBUG*)END WriteDebugReal;

(*--------------------------------------*)
(*DEBUG*) PROCEDURE WriteDebugVector(p:Point);
(*--------------------------------------*)
(*DEBUG*)BEGIN
(*DEBUG*)
(*DEBUG*)WriteDebugReal(p[X]);
(*DEBUG*)STextIO.WriteString(" ");
(*DEBUG*)WriteDebugReal(p[Y]);
(*DEBUG*)
(*DEBUG*)END WriteDebugVector;

(*--------------------------------------------------------*)
 PROCEDURE WritePucks(inf:PipeInfo; whichPlayer:GamePlayers);
(*--------------------------------------------------------*)

VAR i             :CARDINAL;
    posReflect,
    speedReflect  :REAL;

BEGIN

IF whichPlayer = BluePlayer THEN
   speedReflect := -1.0;
ELSE
   speedReflect := 1.0;
   posReflect := 0.0;
END;

FOR i := 0 TO NumPucks-1 DO

   WITH MovingObjects[PuckObj] DO

      IF whichPlayer = BluePlayer THEN
         posReflect := ScreenSize - 2.0*specsP^[i].pos[X];
      END;

      WriteReal(inf, specsP^[i].pos[X]+posReflect); WriteString(inf, " "); WriteReal(inf, specsP^[i].pos[Y]);
      WriteString(inf, "  ");

      WriteReal(inf, infoP^[i].speed[X]*speedReflect); WriteString(inf, " "); WriteReal(inf, infoP^[i].speed[Y]);
      WriteString(inf, "  ");

      IF specsP^[i].color = NoPlayer THEN
         WriteInt(inf, ORD(NoPlayer));
      ELSIF specsP^[i].color = whichPlayer THEN                     (* both players think they are Red *)
         WriteInt(inf, ORD(RedPlayer));
      ELSE
         WriteInt(inf, ORD(BluePlayer));
      END;

   END;
   WriteLn(inf);
END;

END WritePucks;

(*------------------------------------------------------------*)
 PROCEDURE WriteBumpers(inf:PipeInfo; whichPlayer:GamePlayers);
(*------------------------------------------------------------*)

VAR i, j          :CARDINAL;
    colorReflect  :CARDINAL;
    posReflect,
    speedReflect  :REAL;

BEGIN

IF whichPlayer = BluePlayer THEN
   colorReflect := MIN(HisBumperIndices);
   speedReflect := -1.0;
ELSE
   colorReflect := MIN(MyBumperIndices);
   speedReflect := 1.0;
   posReflect := 0.0;
END;

FOR i := MIN(BumperIndices) TO MAX(BumperIndices) DO

   WITH MovingObjects[BumperObj] DO

      IF whichPlayer = BluePlayer THEN
         j := (i + colorReflect) MOD NumBumpers;            (* both players think they are Red *)
         posReflect := ScreenSize - 2.0*specsB^[j].pos[X];
      ELSE
         j := i;
      END;

      DebugReal("pos X", ORD(whichPlayer), specsB^[j].pos[X]+posReflect);
      DebugReal("pos Y", ORD(whichPlayer), specsB^[j].pos[Y]);
      WriteReal(inf, specsB^[j].pos[X]+posReflect); WriteString(inf, " "); WriteReal(inf, specsB^[j].pos[Y]);
      WriteString(inf, "  ");
      DebugReal("speed X", ORD(whichPlayer), infoB^[j].speed[X]*speedReflect);
      DebugReal("speed Y", ORD(whichPlayer), infoB^[j].speed[Y]);
      WriteReal(inf, infoB^[j].speed[X]*speedReflect); WriteString(inf, " "); WriteReal(inf, infoB^[j].speed[Y]);
   END;
   WriteLn(inf);

   (*IF DEBUGoutstate THEN
      WITH MovingObjects[BumperObj]^[j] DO
         WriteDebugVector(pos); STextIO.WriteString("  ");
         WriteDebugVector(speed);
      END;
      STextIO.WriteLn;
   END;*)

END;

DebugPause("WriteBumpers entry", ORD(whichPlayer));

END WriteBumpers;

(*----------------------------------------------------------*)
 PROCEDURE WriteSleds(inf:PipeInfo; whichPlayer:GamePlayers);
(*----------------------------------------------------------*)
                      (* only write out one segment from all the steps per turn, if possible *)
VAR i,
    k             :CARDINAL;
    m,
    j             :INTEGER;
    posReflect    :REAL;
    outputSegs    :CARDINAL;
    writeIt       :BOOLEAN;

BEGIN
IF DEBUGoutstate THEN
   STextIO.WriteString("WriteSleds"); STextIO.WriteLn;
END;

posReflect := 0.0;

FOR i := 0 TO NumSleds-1 DO

   WITH Sleds DO

      IF whichPlayer = BluePlayer THEN
         k := (i + 1) MOD NumSleds;
         posReflect := ScreenSize - 2.0*specsS[k].pos[X];
      ELSE
         k := i;
      END;

      WriteReal(inf, specsS[k].pos[X]+posReflect); WriteString(inf, " "); WriteReal(inf, specsS[k].pos[Y]);
      WriteString(inf, " ");

      IF whichPlayer = BluePlayer THEN
         WriteReal2p(inf, ReflectDirection(specsS[k].direct)); WriteLn(inf);           (* need two places to right of decimal for the direction *)
      ELSE
         WriteReal2p(inf, specsS[k].direct); WriteLn(inf);           (* need two places to right of decimal for the direction *)
      END;

      IF DEBUGoutstate THEN
         STextIO.WriteString("OneSledPos"); STextIO.WriteLn;
      END;

      WriteInt(inf, specsS[k].TrailNumPoints); WriteString(inf, " ");

      IF specsS[k].TrailNumPoints > 0 THEN
                                              
         j := specsS[k].TrailHeadPos;
         FOR m := 0 TO VAL(INTEGER, specsS[k].TrailNumPoints)-1 DO

            IF whichPlayer = BluePlayer THEN        (* $VER: CapturePlayerIO.MOD 0.0 (25.1.2011) *)
               posReflect := ScreenSize - 2.0*specsS[k].Trail[j, X];
            END;

            WriteReal(inf, specsS[k].Trail[j, X]+posReflect);       
            WriteString(inf, " ");
            WriteReal(inf, specsS[k].Trail[j, Y]);
            WriteString(inf, " ");

            j := (j + TrailMaxPoints -1) MOD TrailMaxPoints;       (* decrement with wrap-around *)
         END;

      END;
      WriteLn(inf);

      IF DEBUGoutstate THEN
         STextIO.WriteString("OneSledTrail"); STextIO.WriteLn;
      END;

   END;

END;

END WriteSleds;

(*---------------------------------------------*)
 PROCEDURE ReadReal(f:PipeFile; VAR r:REAL);
(*---------------------------------------------*)

VAR ch   :CHAR;
    tok  :Str0.String32;
    bRes :BOOLEAN;
    cRes :ConvResults;

BEGIN
(*(*DebugOn(0);*) DebugPause("ReadReal", 0);*)

tok := "";
bRes := ReadPipe(f, ch);                       (*DebugPause(tok, ORD(ch));*)
WHILE (ch = " ") OR (ch = LF) DO
   bRes := ReadPipe(f, ch);                    (*DebugPause(tok, ORD(ch));*)
END;

IF ch = "-" THEN
   Str1.ChrCat(ch, tok);                       
   bRes := ReadPipe(f, ch);                    (*DebugPause(tok, ORD(ch));*)
END;

WHILE (ch >= "0") AND (ch <= "9") DO
   Str1.ChrCat(ch, tok);                       
   bRes := ReadPipe(f, ch);                    (*DebugPause(tok, ORD(ch));*)
END;

Assert(ch = ".", "ReadReal, missing dot");
Str1.ChrCat(ch, tok);
bRes := ReadPipe(f, ch);                       (*DebugPause(tok, ORD(ch));*)

WHILE (ch >= "0") AND (ch <= "9") DO
   Str1.ChrCat(ch, tok);
   bRes := ReadPipe(f, ch);                    (*DebugPause(tok, ORD(ch));*)
END;

IF CAP(ch) = "E" THEN
   IF ch = "-" THEN
      Str1.ChrCat(ch, tok);
      bRes := ReadPipe(f, ch);
   END;
   WHILE (ch >= "0") AND (ch <= "9") DO
      Str1.ChrCat(ch, tok);
      bRes := ReadPipe(f, ch);
   END;
END;

StrToReal(tok, r, cRes);
Assert(cRes = strAllRight, "ReadReal(PipeFile, ) FAIL");

END ReadReal;

(*-------------------------------------------*)
 PROCEDURE ReadInt(f:PipeFile; VAR i:INTEGER);
(*-------------------------------------------*)

VAR ch   :CHAR;
    tok  :Str0.String32;
    bRes :BOOLEAN;
    cRes :ConvResults;

BEGIN

tok := "";
bRes := ReadPipe(f, ch);
WHILE (ch = " ") OR (ch = LF) DO
   bRes := ReadPipe(f, ch);
END;

IF ch = "-" THEN
   Str1.ChrCat(ch, tok);
   bRes := ReadPipe(f, ch);
END;

WHILE (ch >= "0") AND (ch <= "9") DO
   Str1.ChrCat(ch, tok);
   bRes := ReadPipe(f, ch);
END;

StrToInt(tok, i, cRes);
Assert(cRes = strAllRight, "ReadInt(PipeFile, ) FAIL");

END ReadInt;

(*----------------------------------------------*)
 PROCEDURE ReadVector(f:PipeFile; VAR v:Point);
(*----------------------------------------------*)

BEGIN

ReadReal(f, v[X]);
ReadReal(f, v[Y]);

END ReadVector;

(*===============================================*)
 PROCEDURE OutGameState(whichPlayer:GamePlayers);
(*===============================================*)

VAR  inf  :PipeInfoPtr;

BEGIN
IF DEBUGcomm THEN DebugOn(0); DebugPause("OutGameState -> ", 0); DebugPause(CmdPipe[whichPlayer].pipeName, 0); END;
(*PrintMsg2("C OutGameState -> ",  CmdPipe[whichPlayer].pipeName); LineFeed;*)

inf := ADR(StatePipe[whichPlayer]);

IF DEBUGoutstate THEN DebugOn(0); DebugPause("CapturePlayerIO", TurnNum); END;
WriteInt(inf^, TurnNum); WriteLn(inf^);
(*DebugOn(0); DebugPause("After WriteInt", TurnNum);*)

(*IF DEBUGoutstate THEN WriteDebugInt(NumPucks); STextIO.WriteLn; END;*)
WriteInt(inf^, NumPucks); WriteLn(inf^);
WritePucks(inf^, whichPlayer);

(*IF DEBUGoutstate THEN WriteDebugInt(NumBumpers); STextIO.WriteLn; END;*)
WriteInt(inf^, NumBumpers); WriteLn(inf^);
WriteBumpers(inf^, whichPlayer);

(*IF DEBUGoutstate THEN WriteDebugInt(NumSleds); STextIO.WriteLn; END;*)
WriteInt(inf^, NumSleds); WriteLn(inf^);
WriteSleds(inf^, whichPlayer);

FlushWrtBuffer(inf^);

IF DEBUGcomm THEN DebugOn(0); DebugPause("OutGameState Exit", TurnNum); END;
(*PrintMsg("C OutGameState Exit"); LineFeed;*)

END OutGameState;

(*========================================================================================================*)
 PROCEDURE InGameMoves(whichPlayer:GamePlayers; VAR Bump1Accel, Bump2Accel:Point; VAR SledTurn:REAL):BOOLEAN;
(*========================================================================================================*)

VAR  f :PipeFile;

BEGIN

IF DEBUGcomm THEN DebugOn(0); DebugPause("InGameMoves -> ", 0); DebugPause(CmdPipe[whichPlayer].pipeName, 0); END;
(*intMsg2("InGameMoves -> ", CmdPipe[whichPlayer].pipeName);*)

f := CmdPipe[whichPlayer].pipeF;

ReadVector(f, Bump1Accel);
ReadVector(f, Bump2Accel);
ReadReal(f, SledTurn);

IF DEBUGcomm THEN DebugOn(0); DebugPause("InGameMoves Exit", 0); END;
(*intMsg("InGameMoves Exit");*)
RETURN TRUE;

END InGameMoves;

(*-------------------*)
 PROCEDURE InitPipes;
(*-------------------*)

VAR  PipeNameAndBuffer :Str0.String80;
     numstr            :Str0.String16;
     oRes              :OpenResults;

BEGIN
IF DEBUGcomm THEN DebugOn(0); DebugPause("InitPipes", 0); END;

WITH CmdPipe[RedPlayer] DO
   pipeF := OpenPipe(pipeName, PipeModeRead, oRes);
   Assert(oRes = opened, "OpenPipe for read FAIL");
   SetReadTimeout(pipeF, PipeTimeOut); (* 200 msec *)
END;

WITH StatePipe[RedPlayer] DO
   Str0.StrAsg(pipeName, PipeNameAndBuffer);
   IntToStr(BufSize, numstr);
   Str1.StrCat("/", PipeNameAndBuffer);
   Str1.StrCat(numstr, PipeNameAndBuffer);
   (*Str1.StrCat("/50", PipeNameAndBuffer);*)

   pipeF := OpenPipe(PipeNameAndBuffer, PipeModeWrite, oRes);
   Assert(oRes = opened, "OpenPipe for write FAIL");
END;

WITH CmdPipe[BluePlayer] DO
   pipeF := OpenPipe(pipeName, PipeModeRead, oRes);
   Assert(oRes = opened, "OpenPipe for read FAIL");
   SetReadTimeout(pipeF, PipeTimeOut); (* 200 msec *)
END;

WITH StatePipe[BluePlayer] DO
   Str0.StrAsg(pipeName, PipeNameAndBuffer);
   IntToStr(BufSize, numstr);
   Str1.StrCat("/", PipeNameAndBuffer);
   Str1.StrCat(numstr, PipeNameAndBuffer);
   (*Str1.StrCat("/50", PipeNameAndBuffer);*)

   pipeF := OpenPipe(PipeNameAndBuffer, PipeModeWrite, oRes);
   Assert(oRes = opened, "OpenPipe for write FAIL");
END;

IF DEBUGcomm THEN DebugOn(0); DebugPause("pipes opened", 0); END;

END InitPipes;

(*=========================================================*)
 PROCEDURE InitPlayerIO(RedPlayerExe, BluePlayerExe:DynStr);
(*=========================================================*)

VAR  RunResult :INTEGER;
     RunArgs   :DynStr;
     inFil(*,
     outFil,
     errFil*)    :AmigaDOS.FileHandle;
     ch        :CHAR;
     isExec    :BOOLEAN;
     iRes      :INTEGER;
     bRes      :BOOLEAN;

         (*-------------------------------------------------------------------*)
          PROCEDURE TstPlayerPgm(PlayerExe:DynStr; specificMsg:ARRAY OF CHAR);
         (*-------------------------------------------------------------------*)

         VAR  msg    :Str0.String80;

         BEGIN

         IF NOT FileExists(PlayerExe.str^) THEN
            DynStr0.dStrOut(PlayerExe, msg);
            Str1.StrCat(": Player program not found - ", msg);
            Str1.StrCat(specificMsg, msg);
            Assert(FALSE, msg);
         ELSIF GetExecutable(PlayerExe.str^, isExec) AND NOT isExec THEN
            DynStr0.dStrOut(PlayerExe, msg);
            Str1.StrCat(": Player program not executable - ", msg);
            Str1.StrCat(specificMsg, msg);
            Assert(FALSE, msg);
         END;

         END TstPlayerPgm;

BEGIN

TstPlayerPgm(RedPlayerExe, "Red");
TstPlayerPgm(BluePlayerExe, "Blue");

InitPipes;

(*inFil := RevealPipeFH(StatePipe[RedPlayer].pipeF);
outFil := RevealPipeFH(CmdPipe[RedPlayer].pipeF);*)
inFil := IDOS^.Open(IDOS, "CON:100/820/250/50/RED", AmigaDOS.ModeNewFile);
Assert(CAST(INTEGER, inFil) # AmigaDOS.DOSFALSE, "Open inFile FAIL");
(*DebugPause("Before Spawn", 0);*)

DynStr0.dStrInC("-cp ", RunArgs);
DynStr3.dStr0Cat(CmdPipe[RedPlayer].pipeName, RunArgs);
DynStr3.dStr0Cat(" -sp ", RunArgs);
DynStr3.dStr0Cat(StatePipe[RedPlayer].pipeName, RunArgs);

bRes := SpawnRedirect(RedPlayerExe, RunArgs, "RED", inFil, NIL(*outFil*), NIL, TRUE(*Async*), RunResult);
IF NOT bRes THEN
   iRes := IDOS^.Close(IDOS, inFil);
   Assert(FALSE, "SpawnRedirect -red FAIL");
END;

(*DebugOn(0); DebugPause("After Spawn red", 0);*)

inFil := IDOS^.Open(IDOS, "CON:600/820/250/50/BLUE", AmigaDOS.ModeNewFile);
Assert(CAST(INTEGER, inFil) # AmigaDOS.DOSFALSE, "Open inFile FAIL");

DynStr0.dStrInE("-cp ", RunArgs);
DynStr3.dStr0Cat(CmdPipe[BluePlayer].pipeName, RunArgs);
DynStr3.dStr0Cat(" -sp ", RunArgs);
DynStr3.dStr0Cat(StatePipe[BluePlayer].pipeName, RunArgs);

bRes := SpawnRedirect(BluePlayerExe, RunArgs, "BLUE", inFil, NIL(*outFil*), NIL, TRUE(*Async*), RunResult);
IF NOT bRes THEN
   iRes := IDOS^.Close(IDOS, inFil);
   Assert(FALSE, "SpawnRedirect -blue FAIL");
END;

(*DebugOn(0); DebugPause("after SpawnRedirect", 0);*)
DynStr0.dStrDispose(RunArgs);

END InitPlayerIO;

(*--------------------*)
 BEGIN (* module init *)
(*--------------------*)

Str1.ChrAsg(LF, EOL);

runId := IUtility^.GetUniqueID(IUtility);
MyConversions.ConvertCardinal(runId, 1, runIdStr);

WITH CmdPipe[RedPlayer] DO
   pipeName := CmdPipeNameBase;
   Str1.StrCat("R", pipeName);
   Str1.StrCat(runIdStr, pipeName);
   pipeF := InvalidPipe();
   BufPos := 0;
END;

WITH StatePipe[RedPlayer] DO
   pipeName := StatePipeNameBase;
   Str1.StrCat("R", pipeName);
   Str1.StrCat(runIdStr, pipeName);
   pipeF := InvalidPipe();
   BufPos := 0;
END;

WITH CmdPipe[BluePlayer] DO
   pipeName := CmdPipeNameBase;
   Str1.StrCat("B", pipeName);
   Str1.StrCat(runIdStr, pipeName);
   pipeF := InvalidPipe();
   BufPos := 0;
END;

WITH StatePipe[BluePlayer] DO
   pipeName := StatePipeNameBase;
   Str1.StrCat("B", pipeName);
   Str1.StrCat(runIdStr, pipeName);
   pipeF := InvalidPipe();
   BufPos := 0;
END;

(*------*)
 FINALLY
(*------*)                             (* we might not want to close the state pipes before the players do, since
                                          currently close a reader pipe does a flush which does a DOS.READ unblocked
                                          with invokes the re-open kludge. *)
(*
<<<<<< Player MUST BE Reading after end but before this close <<<<< don't see how the close() could give the error

IDOS^.Delay(IDOS, AmigaDOS.TicksPerSecond*10); (* better, use DeathSignal? *)  (* NOT GOOD ENUF, Maybe should not FLUSH on closing the read pipe, at least *)
*)

WITH StatePipe[RedPlayer] DO
  IF pipeF # InvalidPipe() THEN
     ClosePipe(pipeF);
  END;
END;

WITH CmdPipe[RedPlayer] DO
  IF pipeF # InvalidPipe() THEN
     ClosePipe(pipeF);
  END;
END;

WITH StatePipe[BluePlayer] DO
  IF pipeF # InvalidPipe() THEN
     ClosePipe(pipeF);
  END;
END;

WITH CmdPipe[BluePlayer] DO
  IF pipeF # InvalidPipe() THEN
     ClosePipe(pipeF);
  END;
END;

BreakOffspring;

END CapturePlayerIO.



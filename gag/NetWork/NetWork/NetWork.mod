(*---------------------------------------------------------------------------
    :Program.    NetWork.mod
    :Author.     Fridtjof Siebert
    :Address.    Nobileweg 67, D-7-Stgt-40
    :Phone.      (0)711/822509
    :Shortcut.   [fbs]
    :Version.    1.0
    :Date.       04-Jan-89 03:57:52
    :Copyright.  PD
    :Language.   Modula-II
    :Translator. M2Amiga v3.1d
    :Contents.   Program to create a NetWork on Workbench.
    :Remark.     Idea by Achim Siebert
---------------------------------------------------------------------------*)

MODULE NetWork;

FROM SYSTEM      IMPORT ADR, ADDRESS, LONGSET, INLINE;
FROM Arts        IMPORT Assert, TermProcedure, Terminate;

FROM Dos         IMPORT ctrlC, Delay;
FROM Exec        IMPORT Forbid, Permit, FindPort, MsgPortPtr, NodeType,
                        Message, MessagePtr, GetMsg, ReplyMsg, PutMsg, Wait,
                        MemReqs, MemReqSet, WaitPort, FreeMem;
FROM ExecSupport IMPORT CreatePort, DeletePort;
FROM Graphics    IMPORT WaitBOVP, BitMap, SetDrMd, WaitTOF, RastPortPtr,
                        BitMapPtr, BltBitMap, SetAPen, jam1, WritePixel,
                        RastPort, InitBitMap, InitRastPort;
FROM Intuition   IMPORT ScreenPtr, MakeScreen, RethinkDisplay, NewWindow,
                        WindowFlags, WindowFlagSet, ScreenFlags, CloseWindow,
                        ScreenFlagSet, IDCMPFlags, IDCMPFlagSet, OpenWindow,
                        WindowPtr;
FROM IFFSupport  IMPORT ReadILBM, ReadILBMFlags, ReadILBMFlagSet, NuScreen,
                        IFFInfo;
FROM Heap        IMPORT AllocMem;

(*------  CONSTS:  ------*)

CONST
  WindowTitle = "NetWork © Fridtjof Siebert";
  PortName    = "NewWBPlanes[fbs].Port";
  ReplyName   = "NewWBPlanes[fbs].ReplyPort";
  minx = 32;
  miny = 16;

(*------  TYPES:  ------*)

TYPE
  ColorMap =  ARRAY[0..31] OF INTEGER;

(*------  VARS:  ------*)

VAR
  WBScreen,SDummy: ScreenPtr;
  CMap: ColorMap;
  OldColTable: POINTER TO ColorMap;
  Window,WDummy: WindowPtr;
  NuWindow: NewWindow;
  MyMsg: Message;
  QuitMessage: MessagePtr;
  MyPort, OldPort: MsgPortPtr;
  i: INTEGER;
  rp: RastPort;
  bm: BitMap;
  SpiderBM: BitMapPtr;
  SpiderSaveBM: BitMap;
  SpiderX,SpiderY: INTEGER;
  W,H,D,R,Hx,Hy,X6,Y6: INTEGER;
  FirstDraw: BOOLEAN;
  SpidOffSetX,SpidOffSetY: INTEGER;
  Factor: LONGINT;
  LinNum: CARDINAL;
  x,y: INTEGER;
  Line: ARRAY[0..23] OF RECORD
                         x,y: INTEGER;
                         dx,dy: LONGINT;
                       END;

(*------  CleanUp:  ------*)

PROCEDURE CleanUp();

BEGIN

(*------  Remove IFF:  ------*)

  IF SpiderBM#NIL THEN
    WITH SpiderBM^ DO
      i:=0;
      WHILE i#ORD(depth) DO
        FreeMem(planes[i],rows*bytesPerRow);
        INC(i);
      END;
    END;
    FreeMem(SpiderBM,SIZE(BitMap));
  END;


(*------  Remove Picture from WB:  ------*)

  IF WBScreen#NIL THEN
    Forbid();
      IF OldColTable#NIL THEN
        WBScreen^.viewPort.colorMap^.colorTable := OldColTable;
      END;
      WITH WBScreen^.bitMap DO
        depth := 2;
        planes[2] := NIL;
      END;
      MakeScreen(WBScreen);
    Permit();
    RethinkDisplay();
  END;

(*------  Close everything:  ------*)

  IF Window#NIL THEN CloseWindow(Window); END;

(*------  Remove Port:  ------*)

  IF MyPort#NIL THEN
    Forbid();
      IF QuitMessage=NIL THEN QuitMessage := GetMsg(MyPort) END;
      WHILE QuitMessage#NIL DO
        ReplyMsg(QuitMessage);
        QuitMessage := GetMsg(MyPort);
      END;
      DeletePort(MyPort);
    Permit();
  END;

END CleanUp;

(*------  Put Spiderplanes on WBScreen:  ------*)

PROCEDURE Rethink();

BEGIN
  WITH WBScreen^.bitMap DO
    WaitTOF();
    Forbid();
      depth := 4;
      MakeScreen(WBScreen);
      depth := 2;
    Permit();
    RethinkDisplay();
  END;
END Rethink;

(*------  Let Spider draw a line:  ------*)

PROCEDURE SpiderLine(ex,ey: INTEGER; draw: BOOLEAN);

VAR
  sdDir: CARDINAL;
  dx,dy,xinc,yinc: INTEGER;
  dirx,diry: BOOLEAN;
  count: INTEGER;
  sdpos: INTEGER;
  sdposdir,p,sy: INTEGER;
  Duese: POINTER TO ARRAY [0..7] OF RECORD x,y: INTEGER END;

  PROCEDURE DueseTable(); (* $E- *)
  BEGIN
    INLINE(17,11,20, 9,26, 8,27, 9,32,12,27,15,22,15,16,14);
  END DueseTable;

BEGIN
  Duese := ADR(DueseTable);
  dx:= ex-SpiderX;
  dy:= ey-SpiderY;
  IF (dx=0) AND (dy=0) THEN RETURN END;
  IF    (dx>0) AND (ABS(dx)>ABS(dy)*4) THEN sdDir := 0;
  ELSIF (dy>0) AND (ABS(dy)>ABS(dx))   THEN sdDir := 2;
  ELSIF (dx<0) AND (ABS(dx)>ABS(dy)*4) THEN sdDir := 4;
  ELSIF (dy<0) AND (ABS(dy)>ABS(dx))   THEN sdDir := 6;
  ELSIF (dx>0) AND (dy>0)              THEN sdDir := 1;
  ELSIF (dx>0) AND (dy<0)              THEN sdDir := 7;
  ELSIF (dx<0) AND (dy>0)              THEN sdDir := 3;
  ELSIF (dx<0) AND (dy<0)              THEN sdDir := 5;
  END;
  IF dx>0 THEN xinc:=1 ELSE xinc := -1 END;
  IF dy>0 THEN yinc:=1 ELSE yinc := -1 END;
  dx := ABS(dx); dy := ABS(dy);
  dirx := dx>dy;
  IF dirx THEN count := dx/2 ELSE count := dy/2 END;
  sdpos := 0; sdposdir := 1;
  SetAPen(ADR(rp),2); SetDrMd(ADR(rp),jam1);
  REPEAT
    IF FirstDraw THEN FirstDraw:= FALSE ELSE
      p := BltBitMap(ADR(SpiderSaveBM),0,0,ADR(bm),SpiderX-SpidOffSetX,
             SpiderY-SpidOffSetY,49,25,192,255,NIL);
    END;
    SpidOffSetX := Duese^[sdDir].x;
    SpidOffSetY := Duese^[sdDir].y;
    IF dirx THEN
      INC(SpiderX,xinc);
      INC(count,dy);
      IF count>=dx THEN
        DEC(count,dx);
        INC(SpiderY,yinc)
      ELSIF SpiderX#ex THEN
        IF draw THEN p:= WritePixel(ADR(rp),SpiderX,SpiderY) END;
        INC(SpiderX,xinc);
        INC(count,dy);
        IF count>=dx THEN DEC(count,dx); INC(SpiderY,yinc) END;
      END;
    ELSE
      INC(SpiderY,yinc);
      INC(count,dx);
      IF count>=dy THEN DEC(count,dy); INC(SpiderX,xinc) END;
    END;
    IF draw THEN p:= WritePixel(ADR(rp),SpiderX,SpiderY) END;
    p := BltBitMap(ADR(bm),SpiderX-SpidOffSetX,SpiderY-SpidOffSetY,
           ADR(SpiderSaveBM),0,0,49,25,192,255,NIL);
    CASE sdpos DIV 3 OF 0: sy := 24| 1: sy := 0| 2: sy := 48 END;
    p := BltBitMap(SpiderBM,48*sdDir,sy,ADR(bm),
       SpiderX-SpidOffSetX,SpiderY-SpidOffSetY,49,25,224,255,NIL);
    INC(sdpos,sdposdir);
    IF (sdpos=0) OR (sdpos=8) THEN sdposdir := -sdposdir END;
    IF draw THEN WaitTOF(); WaitBOVP(ADR(WBScreen^.viewPort)) END;
  UNTIL ((SpiderX=ex) AND dirx) OR ((SpiderY=ey) AND NOT(dirx));
  SpiderX := ex; SpiderY := ey;
  QuitMessage := GetMsg(MyPort);
  IF QuitMessage#NIL THEN Terminate(0) END;
  Rethink();
END SpiderLine;

(*------  MAIN:  ------*)

BEGIN

(*------  Initialization:  ------*)

  WBScreen := NIL; OldColTable := NIL; Window := NIL; MyPort := NIL;
  SpiderBM := NIL;
  TermProcedure(CleanUp);

(*------  Have we already been started?  ------*)

  OldPort := FindPort(ADR(PortName));
  IF OldPort#NIL THEN
    MyPort := CreatePort(ADR(ReplyName),0);
    Assert(MyPort#NIL,ADR("CreatePort failed"));
    MyMsg.node.type := message;
    MyMsg.replyPort := MyPort;
    PutMsg(OldPort,ADR(MyMsg)); (* Signal task to quit *)
    WaitPort(MyPort);
    DeletePort(MyPort);
    MyPort := NIL;
    Terminate(0);
  END;
  MyPort := CreatePort(ADR(PortName),0);
  Assert(MyPort#NIL,ADR("CreatePort failed"));

(*------  Open Window:  ------*)

  WITH NuWindow DO
    leftEdge   := 0; topEdge     := 0;
    width      := 1; height      := 1;
    detailPen  := 0; blockPen    := 1;
    idcmpFlags := IDCMPFlagSet{};
    flags      := WindowFlagSet{backDrop};
    firstGadget:= NIL; checkMark := NIL;
    title      := ADR(WindowTitle);
    screen     := NIL; bitMap    := NIL;
    type       := ScreenFlagSet{wbenchScreen};
  END;
  Window := OpenWindow(NuWindow);
  Assert(Window#NIL,ADR("Can't open Window!!!"));
  WBScreen := Window^.wScreen;
  IF WBScreen^.bitMap.depth>2 THEN Terminate(0) END;

(*------  Load Spiders:  ------*)

  Assert(ReadILBM("NetWork.Handler",ReadILBMFlagSet{visible,dontopen},SDummy,
         WDummy),ADR("Can't load SpinnenSort.iff"));
  SpiderBM := NuScreen.customBitMap;

(*------  Set Colors:  ------*)

  OldColTable := WBScreen^.viewPort.colorMap^.colorTable;
  CMap := OldColTable^;
  FOR i:=0 TO 3 DO
    CMap[ 4+i] := 0000H;
    CMap[ 8+i] := 0DDDH;
    CMap[12+i] := 0000H;
  END;
  WBScreen^.viewPort.colorMap^.colorTable := ADR(CMap);

(*------  Add Planes to WBScreen:  ------*)

  bm := WBScreen^.bitMap;
  WITH bm DO
    AllocMem(planes[0],rows*bytesPerRow,TRUE);
    Assert(planes[0]#NIL,ADR("Out of memory"));
    AllocMem(planes[1],rows*bytesPerRow,TRUE);
    Assert(planes[1]#NIL,ADR("Out of memory"));
    WBScreen^.bitMap.planes[2] := planes[0];
    WBScreen^.bitMap.planes[3] := planes[1];
  END;

(*------  Init SpiderSaveBM:  ------*)

  InitBitMap(SpiderSaveBM,2,64,32);
  WITH SpiderSaveBM DO
    AllocMem(planes[0],rows*bytesPerRow,TRUE);
    AllocMem(planes[1],rows*bytesPerRow,TRUE);
    Assert((planes[0]#NIL) AND (planes[1]#NIL),ADR("Out of memory!"));
  END;

(*------  Init RastPort:  ------*)

  bm.depth := 2;
  InitRastPort(rp);
  rp.bitMap := ADR(bm);

(*------  Create NetWork:  ------*)

  WITH WBScreen^ DO
    W := width-2*minx;  R := width-minx;  Hx := minx + W DIV 2;
    H := height-2*miny; D := height-miny; Hy := miny + H DIV 2;
  END;
  Rethink();

(*------  Gerüst:  ------*)

  SpiderX := minx; SpiderY := miny; FirstDraw := TRUE;
  SpiderLine(minx,D   ,TRUE);
  SpiderLine(R   ,miny,TRUE);
  SpiderLine(minx,miny,TRUE);
  SpiderLine(R   ,D   ,TRUE);
  SpiderLine(R   ,Hy  ,TRUE);
  SpiderLine(minx,Hy  ,TRUE);
  SpiderLine(minx,D   ,TRUE);
  SpiderLine(Hx  ,D   ,TRUE);
  SpiderLine(Hx  ,miny,TRUE);
  SpiderLine(R   ,miny,TRUE);
  SpiderLine(R   ,D   ,TRUE);
  SpiderLine(Hx  ,D   ,TRUE);
  SpiderLine(Hx  ,Hy  ,TRUE);

  X6 := W DIV 6; Y6 := H DIV 6;
  W  := W DIV 2; H  := H DIV 2;
  WITH Line[ 0] DO x := Hx;        y := D;         dx :=  0;    dy := -H    END;
  WITH Line[ 1] DO x := Hx + X6;   y := D;         dx := -X6;   dy := -H    END;
  WITH Line[ 2] DO x := Hx + 2*X6; y := D;         dx := -2*X6; dy := -H    END;
  WITH Line[ 3] DO x := R;         y := D;         dx := -W;    dy := -H    END;
  WITH Line[ 4] DO x := R;         y := D - Y6;    dx := -W;    dy := -2*Y6 END;
  WITH Line[ 5] DO x := R;         y := D - 2*Y6;  dx := -W;    dy := -Y6   END;
  WITH Line[ 6] DO x := R;         y := Hy;        dx := -W;    dy :=  0    END;
  WITH Line[ 7] DO x := R;         y := Hy - Y6;   dx := -W;    dy :=  Y6   END;
  WITH Line[ 8] DO x := R;         y := Hy - 2*Y6; dx := -W;    dy :=  2*Y6 END;
  WITH Line[ 9] DO x := R;         y := miny;      dx := -W;    dy :=  H    END;
  WITH Line[10] DO x := R - X6;    y := miny;      dx := -2*X6; dy :=  H    END;
  WITH Line[11] DO x := R - 2*X6;  y := miny;      dx := -X6;   dy :=  H    END;
  WITH Line[12] DO x := Hx;        y := miny;      dx :=  0;    dy :=  H    END;
  WITH Line[13] DO x := Hx - X6;   y := miny;      dx :=  X6;   dy :=  H    END;
  WITH Line[14] DO x := Hx - 2*X6; y := miny;      dx :=  2*X6; dy :=  H    END;
  WITH Line[15] DO x := minx;      y := miny;      dx :=  W;    dy :=  H    END;
  WITH Line[16] DO x := minx;      y := Hy - 2*Y6; dx :=  W;    dy :=  2*Y6 END;
  WITH Line[17] DO x := minx;      y := Hy - Y6;   dx :=  W;    dy :=  Y6   END;
  WITH Line[18] DO x := minx;      y := Hy;        dx :=  W;    dy :=  0    END;
  WITH Line[19] DO x := minx;      y := Hy + Y6;   dx :=  W;    dy := -Y6   END;
  WITH Line[20] DO x := minx;      y := Hy + 2*Y6; dx :=  W;    dy := -2*Y6 END;
  WITH Line[21] DO x := minx;      y := D;         dx :=  W;    dy := -H    END;
  WITH Line[22] DO x := Hx - 2*X6; y := D;         dx :=  2*X6; dy := -H    END;
  WITH Line[23] DO x := Hx - X6;   y := D;         dx :=  X6;   dy := -H    END;

  LinNum := 0; Factor := 0F800H;

  REPEAT
    DEC(Factor,256);
    IF LinNum=23 THEN LinNum := 0 ELSE INC(LinNum) END;
    WITH Line[LinNum] DO
      IF (LinNum DIV 3) * 3 = LinNum THEN
        SpiderLine(x + (dx*Factor) DIV 10000H,y + (dy*Factor) DIV 10000H,TRUE);
      ELSE
        SpiderLine(x + (dx*(Factor + 400H)) DIV (0E000H + Factor DIV 8),
                   y + (dy*(Factor + 400H)) DIV (0E000H + Factor DIV 8),TRUE);
      END;
    END;
  UNTIL Factor=0200H;

  LOOP
    Delay(50);
    WITH WBScreen^ DO x := mouseX; y := mouseY END;
    IF (x>minx) AND (y>miny) AND (x<R) AND (y<D) THEN
      SpiderLine(x,y,FALSE);
    ELSE
      SpiderLine(Hx,Hy,FALSE);
    END;
  END;

END NetWork.

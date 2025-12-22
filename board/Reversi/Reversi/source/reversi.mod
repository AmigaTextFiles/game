(*****************************************************************************
**									    **
**   #####  ###### ##   ## ##### #####   ##### ####       written by:       **
**   ##  ## ##     ##   ## ##    ##  ## ##      ##      Robert Brandner     **
**   #####  ####    ## ##  ####  #####   ####   ##   	Schillerstr. 3      **
**   ##  ## ##      ## ##  ##    ##  ##     ##  ##   	A-8280 Fürstenfeld  **
**   ##  ## ######   ###   ##### ##  ## #####  ####  	AUSTRIA/EUROPE      **
**									    **
**   This program is written in Modula-II using the compiler M2Amiga V3.3d  **
**									    **
*****************************************************************************)

MODULE Reversi;

FROM Intuition IMPORT
  NewScreen, ScreenPtr, OpenScreen, CloseScreen, NewWindow, WindowPtr,
  OpenWindow, CloseWindow, WindowFlags,WindowFlagSet,customScreen,IDCMPFlagSet;
FROM SYSTEM IMPORT ADR, ADDRESS, INLINE, CAST;
FROM Graphics IMPORT
  RastPortPtr, SetRast, RectFill, SetAPen, LoadRGB4, Text, Move, Draw,
  SetDrMd, jam1, jam2, BitMap, normalFont, InitBitMap, BltBitMapRastPort,
  AllocRaster, FreeRaster, SetFont, CloseFont, TextFontPtr, TextAttr, SetRGB4,
  TextLength, OpenFont, ReadPixel, FontFlags, FontFlagSet, ViewModeSet;
FROM GfxMacros IMPORT RasSize;
FROM Arts IMPORT Assert, TermProcedure;
FROM Dos IMPORT Delay;
FROM Hardware IMPORT gamePort0, ciaa;
FROM Exec IMPORT CopyMem;
FROM RandomNumber IMPORT RND;

CONST GROSS = 8;
      SCHWARZ = 0; WEISS = 1; LEER = 2;
      MENSCH = 0; AMIGA = 1; PAUSE = 2; KEIN = 3;
      BREAK = -30000;

TYPE Brett = ARRAY [0..GROSS-1],[0..GROSS-1] OF INTEGER;

VAR SCHWSP, WEISSP, STIEF, WTIEF : INTEGER;
    memptr : ARRAY[1..4] OF ADDRESS;
    ns : NewScreen;
    nw : NewWindow;
    scr : ScreenPtr;
    win : WindowPtr;
    rp : RastPortPtr;
    maxzug, amzug, zugnum, mx, my, x, y, zx, zy : INTEGER;
    i : CARDINAL;
    anz : ARRAY[0..2] OF INTEGER;
    brett, wert : Brett;
    memory : ARRAY[0..GROSS*GROSS-1] OF
             RECORD
               b : Brett;
               sp : INTEGER;
             END;
    forward, back, paused, force, restart, quit, sZieh, wZieh : BOOLEAN;
    bm : BitMap;
    pl : ADDRESS;
    ch : ARRAY[0..0] OF CHAR;
    topaz : TextFontPtr;
    ta : TextAttr;

PROCEDURE Graphics; (* $E- *)
BEGIN
  INLINE(0FFFFH,0FFFFH,0FFFEH,003F0H,00000H,00000H,00FFFH,0FFE0H,0C000H,
         0FC07H,0FFC0H,07FFBH,0FCF7H,0FFFFH,0FFFFH,0EC1FH,0F7FEH,04000H,0F001H,
         0FF00H,01FFFH,0FF72H,0ABAEH,0BEAAH,0E80FH,083FFH,00000H,0E000H,0FE00H,
         00FFFH,0FFB3H,0AAAAH,0E6EFH,0E405H,001BFH,08000H,0E000H,07E00H,007DFH,
         0FFD3H,0BBAAH,0F6EAH,0A404H,000BFH,08000H,08000H,03800H,003FFH,0FFD0H,
         089AAH,03E2EH,0A404H,000BFH,08000H,0C000H,03C00H,003BFH,0FFE7H,048C4H,
         02516H,0A604H,0009FH,08000H,04000H,01400H,001BFH,0FFE4H,00000H,00000H,
         00304H,001CFH,0C000H,04000H,01400H,001BFH,0FFE0H,00048H,02763H,009EEH,
         003E1H,0C000H,04000H,01400H,001BFH,0FFE0H,06B1EH,0CD96H,02C1FH,007FFH,
         0C000H,04000H,01400H,001BFH,0FFE2H,01144H,08D06H,02FFFH,0FF00H,00000H,
         04000H,01400H,001BFH,0FFE0H,03948H,09924H,00C1DH,0FF00H,00000H,06000H,
         01600H,001BFH,0FFE0H,09482H,0F657H,0080DH,0FF00H,00000H,02000H,01200H,
         001DFH,0FFF1H,00000H,00000H,00405H,0FF00H,00000H,0B000H,03B00H,003DFH,
         0FFD0H,00440H,0A11BH,0A405H,0FF00H,00000H,09800H,03980H,003EFH,0FFF0H,
         00000H,00000H,00405H,0FF00H,00000H,0CC00H,07CC0H,007F7H,0FFF0H,00000H,
         00000H,00605H,0FF00H,00000H,0E701H,0FE70H,01FF9H,0FEF0H,00000H,00000H,
         00305H,0FF00H,00000H,0F1FDH,0FF1FH,0DFFEH,003F0H,00000H,00000H,009EDH,
         0FF00H,00000H,0FC07H,0FFC0H,07FFFH,0FFF0H,00000H,00000H,00C1CH,00100H,
         00000H,0FE03H,0FFFFH,0FFFEH,003F7H,0FFFFH,0FFFFH,0FE0FH,0FFE0H,0C000H,
         0FBF8H,0FFC0H,07FFBH,0FCF7H,0FFFFH,0FFFFH,0FFE7H,0FFFEH,04000H,0FFFEH,
         07F00H,01FFFH,0FF72H,0ABAEH,0BEAAH,0FFF3H,0FFFFH,00000H,0FFFFH,03E00H,
         00FFFH,0FFB3H,0AAAAH,0E6EFH,0F7F9H,0FFFFH,08000H,0FFFFH,09C00H,007FFH,
         0FFD3H,0BBAAH,0F6EAH,0B7F9H,0FFFFH,08000H,0BFFFH,0D800H,003FFH,0FFD0H,
         089AAH,03E2EH,0B7F9H,0FFFFH,08000H,0FFFFH,0C800H,003FFH,0FFE7H,048C4H,
         02516H,0B7F9H,0BBFFH,08000H,07FFFH,0E000H,001FFH,0FFE4H,00000H,00000H,
         013FCH,0C7FFH,0C000H,07FFFH,0E000H,001FFH,0FFE0H,00048H,02763H,019FEH,
         07FFFH,0C000H,07FFFH,0E000H,001FFH,0FFE0H,06B1EH,0CD96H,03C1FH,007FFH,
         0C000H,07FFFH,0E000H,001FFH,0FFE2H,01144H,08D06H,03FFEH,00000H,00000H,
         07FFFH,0E000H,001FFH,0FFE0H,03948H,09924H,01C1CH,00000H,00000H,07FFFH,
         0E000H,001FFH,0FFE0H,09482H,0F657H,0180CH,00000H,00000H,03FFFH,0F000H,
         001FFH,0FFF1H,00000H,00000H,01004H,00000H,00000H,0BFFFH,0D800H,003FFH,
         0FFD0H,00440H,0A11BH,0B004H,00000H,00000H,09FFFH,0F800H,003FFH,0FFF0H,
         00000H,00000H,01004H,00000H,00000H,0CFFFH,0FC00H,007FFH,0FFF0H,00000H,
         00000H,00004H,00000H,00000H,0E7FFH,0FE00H,00FFFH,0FFF0H,00000H,00000H,
         00004H,00000H,00000H,0F1FDH,0FF00H,01FFFH,0FFF0H,00000H,00000H,0080CH,
         00000H,00000H,0FC07H,0FFC0H,07FFFH,0FFF0H,00000H,00000H,00C1CH,00100H,
         00000H,001FCH,0001FH,0C001H,0FC08H,00000H,00000H,001F0H,06C1FH,00000H,
         007FFH,00040H,07004H,0030BH,0BB2CH,0E4EEH,0A3F8H,0FE01H,08000H,00FFFH,
         08000H,01800H,0008FH,07EFBH,0CFDDH,047FDH,0FF00H,0C000H,01FFFH,0C000H,
         00C00H,0004EH,07FFFH,0BDBEH,0AFFFH,0FF00H,04000H,03FFFH,0E000H,00600H,
         0002FH,0FF7FH,0E9FDH,0EFFFH,0FF00H,04000H,07FFFH,0E400H,00200H,0002FH,
         07655H,0C1D1H,04FFFH,0FF00H,04000H,07FFFH,0F000H,00300H,00019H,048C4H,
         02516H,08FFFH,0FF00H,04000H,0FFFFH,0F800H,00100H,00018H,0FFFFH,0FFFFH,
         08FFBH,0FE00H,00000H,0FFFFH,0F800H,00100H,0001DH,0C8DAH,03FFBH,0C7F1H,
         0FC00H,00000H,0FFFFH,0F800H,00100H,0001DH,0EFBFH,0FFDFH,0E3E0H,0F800H,
         00000H,0FFFFH,0F800H,00100H,0001FH,0B5EDH,0BF57H,0E1F1H,0FF00H,00000H,
         0FFFFH,0F800H,00100H,0001DH,0BD69H,0BB7DH,0C01BH,0FF00H,00000H,0FFFFH,
         0F800H,00100H,0001DH,0B4CAH,0FEDFH,0C00FH,0BB00H,00000H,0FFFFH,0EC00H,
         00000H,0000DH,0FFFFH,0FFFFH,08807H,0EF00H,00000H,07FFFH,0E400H,00200H,
         0002EH,00440H,0A11BH,08807H,0EF00H,00000H,07FFFH,0C600H,00000H,0000FH,
         0FFFFH,0FFFFH,0E807H,0BB00H,00000H,03FFFH,08300H,00000H,00000H,00000H,
         00000H,00807H,0C700H,00000H,01FFFH,00180H,00000H,00000H,00000H,00000H,
         00C03H,0FF00H,00000H,00FFEH,000E0H,02000H,00000H,00000H,00000H,00603H,
         0FF00H,00000H,003F8H,0003FH,08000H,00000H,00000H,00000H,003E3H,0FE00H,
         00000H,0FFFFH,0FFE0H,03FFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,093FFH,0C000H,
         0FFFFH,0FFBFH,08FFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,001FFH,0C000H,0FFFFH,
         0FFFFH,0E7FFH,0FFFFH,0FFFFH,0FFFFH,0FFFEH,000FFH,0C000H,0FFFFH,0FFFFH,
         0F3FFH,0FFFFH,0FFFFH,0FFFFH,0FFFEH,044FFH,0C000H,0FFFFH,0FFFFH,0F9FFH,
         0FFFFH,0FFFFH,0FFFFH,0FFFEH,000FFH,0C000H,0FFFFH,0FFFFH,0FDFFH,0FFFFH,
         0FFFFH,0FFFFH,0FFFEH,000FFH,0C000H,0FFFFH,0FFFFH,0FCFFH,0FFFEH,0B73BH,
         0DAE9H,07FFEH,000FFH,0C000H,0FFFFH,0FFFFH,0FEFFH,0FFFFH,00000H,00000H,
         07FFFH,001FFH,0C000H,0FFFFH,0FFFFH,0FEFFH,0FFFEH,03725H,0C004H,03FFFH,
         083FFH,0C000H,0FFFFH,0FFFFH,0FEFFH,0FFFEH,01040H,00020H,01FFFH,0FFFFH,
         0C000H,0FFFFH,0FFFFH,0FEFFH,0FFFCH,04A12H,040A8H,01E0EH,00000H,00000H,
         0FFFFH,0FFFFH,0FEFFH,0FFFEH,04296H,04482H,03FE6H,0FE00H,00000H,0FFFFH,
         0FFFFH,0FEFFH,0FFFEH,04B35H,00120H,03FF2H,0BA00H,00000H,0FFFFH,0FFFFH,
         0FFFFH,0FFFEH,00000H,00000H,07FFAH,0EE00H,00000H,0FFFFH,0FFFFH,0FDFFH,
         0FFFFH,0FBBFH,05EE4H,07FFAH,0EE00H,00000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,
         0FFFFH,0FFFFH,0FFFAH,0BA00H,00000H,0FFFFH,0FFFFH,0FFFFH,0FFF0H,00000H,
         00000H,00FFAH,0C600H,00000H,0FFFFH,0FFFFH,0FFFFH,0FFF0H,00000H,00000H,
         00FFEH,0FE00H,00000H,0FFFFH,0FFFFH,0FFFFH,0FFF0H,00000H,00000H,00FFEH,
         00000H,00000H,0FFFFH,0FFFFH,0FFFFH,0FFF0H,00000H,00000H,00FFFH,0FF00H,
         00000H)
END Graphics;

PROCEDURE Colors; (* $E- *)
BEGIN
  INLINE(0000H,0EEEH,0F00H,000FH,0C03H,0ECAH,0E84H,0FE0H,
         0FC0H,0CA0H,0CCCH,0AAAH,0888H,045DH,040CH,0208H)
END Colors;

PROCEDURE Werte; (* $E- *)
BEGIN
  INLINE(700,-10,100,100,100,100,-10,700);
  INLINE(-10,-10, -7, -7, -7, -7,-10,-10);
  INLINE(100, -7,  2,  2,  2,  2, -7,100);
  INLINE(100, -7,  2,  1,  1,  2, -7,100);
  INLINE(100, -7,  2,  1,  1,  2, -7,100);
  INLINE(100, -7,  2,  2,  2,  2, -7,100);
  INLINE(-10,-10, -7, -7, -7, -7,-10,-10);
  INLINE(700,-10,100,100,100,100,-10,700);
END Werte;

PROCEDURE Quad(x0, y0, x1, y1:INTEGER);
BEGIN
  SetAPen(rp, 11); RectFill(rp, x0, y0, x1, y1);
  SetAPen(rp, 10); Move(rp, x0, y0); Draw(rp, x1, y0); Draw(rp, x1, y1);
  SetAPen(rp, 12); Move(rp, x0, y0+1); Draw(rp, x0, y1); Draw(rp, x1, y1);
END Quad;

PROCEDURE SchreibSchatt(txt : ARRAY OF CHAR; l, x, y, w, c : INTEGER);
VAR xx : INTEGER;
BEGIN
  SetDrMd(rp, jam1);
  xx := x+(w-TextLength(rp, ADR(txt), l))/2;
  SetAPen(rp, 12); Move(rp, xx-1, y+1+INTEGER(rp^.txBaseline));
  Text(rp, ADR(txt), l);
  SetAPen(rp, c); Move(rp, xx, y+INTEGER(rp^.txBaseline));
  Text(rp, ADR(txt), l);
END SchreibSchatt;

PROCEDURE Schreib(txt : ARRAY OF CHAR; la, farb : INTEGER);
BEGIN
  Quad(32, 32+(1-farb)*32, 87, 55+(1-farb)*32);
  SchreibSchatt(txt, la, 32, 40+(1-farb)*32, 56, 1);
END Schreib;

PROCEDURE Blit(xoffset, yoffset, dx, dy, w, h : INTEGER);
BEGIN
  BltBitMapRastPort(ADR(bm), xoffset, yoffset, rp, dx, dy, w, h, 0C0H);
END Blit;

PROCEDURE Titel;
VAR i, j : INTEGER;
BEGIN
  FOR i := 0 TO 15 DO SetRGB4(ADR(scr^.viewPort), i, 0, 0, 0) END;
  SetAPen(rp, 1);
  Move(rp, 0, 200+rp^.txBaseline); Text(rp, ADR("REVERSI 1.0"), 11);
  FOR i := 87 TO 0 BY -1 DO
    FOR j := 0 TO 7 DO
      IF ReadPixel(rp, i, 200+j)=1 THEN
        SetAPen(rp, 12); RectFill(rp, 28+i*3, 18+j*4, 31+i*3, 21+j*4);
        SetAPen(rp, 4);
        RectFill(rp, 29+i*3, 17+j*4, 32+i*3, 20+j*4);
      END
    END
  END;
  SetAPen(rp, 0); RectFill(rp, 0, 200, 100, 209);
  SchreibSchatt("written by Robert Brandner", 26, 0, 55, 320, 1);
  SchreibSchatt("This program is public domain!", 30, 0, 70, 320, 4);
  FOR i := 0 TO 4 DO
    FOR j := 0 TO 4 DO
      IF RND(4)<2 THEN
        IF RND(2)=0 THEN
          Blit(0, 0, 110+i*20, 90+j*20, 20, 20)
        ELSE
          Blit(20, 0, 110+i*20, 90+j*20, 20, 20)
        END
      END
    END
  END;
  LoadRGB4(ADR(scr^.viewPort), ADR(Colors), 16);
  SetRGB4(ADR(scr^.viewPort),11,0,0,0);
  SetRGB4(ADR(scr^.viewPort),12,0,0,0);
  REPEAT UNTIL NOT (gamePort0 IN ciaa.pra);
  REPEAT UNTIL gamePort0 IN ciaa.pra;
  FOR i := 0 TO 15 DO SetRGB4(ADR(scr^.viewPort), i, 0, 0, 0) END;
  SetRast(rp, 0);
END Titel;

PROCEDURE Start;
BEGIN
  WITH ns DO
    leftEdge:=0; topEdge:=0; width:=320; height:=210; depth:=4;
    detailPen:=0; blockPen:=1; viewModes:=ViewModeSet{};
    type:=customScreen; font:=ADR(ta); defaultTitle:=NIL;
    gadgets:=NIL; customBitMap:=NIL;
  END;
  scr := OpenScreen(ns);
  Assert(scr#NIL, ADR("Kein Screen!"));
  WITH nw DO
    leftEdge:=0; topEdge:=0; width:=320; height:=210; detailPen:=0;
    blockPen:=1; idcmpFlags:=IDCMPFlagSet{};
    flags:=WindowFlagSet{reportMouse,borderless,activate,rmbTrap,simpleRefresh};
    firstGadget:=NIL; checkMark:=NIL; title:=NIL;
    screen:=scr; bitMap:=NIL;type:=customScreen;
  END;
  win := OpenWindow(nw);
  Assert(win#NIL, ADR("Kein Window!"));
  rp := win^.rPort;
  SetRast(rp, 0);
  quit := FALSE;
  CopyMem(ADR(Werte), ADR(wert), SIZE(wert));
  InitBitMap(bm, 4, 130, 20);
  FOR i := 0 TO 3 DO
    pl := AllocRaster(130, 20);
    Assert(pl#NIL, ADR("Kein Speicher für Graphik"));
    bm.planes[i] := pl;
    CopyMem(ADR(Graphics)+LONGINT(i*RasSize(130, 20)), pl, RasSize(130, 20));
  END;
  Titel;
  SetAPen(rp, 11);
  RectFill(rp, 0, 0, 319, 207);
  FOR i := 0 TO 25 DO
    SetAPen(rp, 10); Move(rp, 0, i*8); Draw(rp, 319, i*8);
    SetAPen(rp, 12); Move(rp, 0, i*8+7); Draw(rp, 319, i*8+7);
  END;
  FOR i := 0 TO 39 DO
    SetAPen(rp, 12); Move(rp, i*8, 0); Draw(rp, i*8, 207);
    SetAPen(rp, 10); Move(rp, i*8+7, 0); Draw(rp, i*8+7, 207);
  END;
  Quad(120, 8, 311, 199);
  FOR i := 0 TO GROSS-1 DO
    ch[0] := CHAR(INTEGER("8")-i);
    SchreibSchatt(ch, 1, 125, 30+i*20, 8, 1);
    ch[0] := CHAR(INTEGER("A")+i);
    SchreibSchatt(ch, 1, 143+i*20, 188, 8, 1);
  END;
  Quad(8, 8, 71, 23);
  SchreibSchatt("REVERSI", 7, 8, 12, 63, 4);
  Blit(60, 0, 72, 8, 40, 16);
  FOR i := 0 TO 1 DO
    Quad(8, 32+i*32, 31, 55+i*32); Quad(32, 32+i*32, 87, 55+i*32);
    Quad(88, 32+i*32, 111, 55+i*32);
  END;
  Blit(20, 0, 10, 34, 20, 20); Blit(0, 0, 10, 66, 20, 20);
  Quad(8, 96, 111, 135);
  Blit(110, 0, 10, 111, 10, 10);
  FOR i := 1 TO 9 DO Blit(110, 10, 10+i*10, 111, 10, 10) END;
  LoadRGB4(ADR(scr^.viewPort), ADR(Colors), 16);
END Start;

PROCEDURE ZeigWahl;
BEGIN
  FOR i := 0 TO 9 DO Blit(120, 0, 10+i*10, 98, 10, 10) END;
  FOR i := 0 TO 9 DO Blit(120, 0, 10+i*10, 124, 10, 10) END;
  IF WEISSP = MENSCH THEN
    Blit(100, 10, 10, 98, 10, 10)
  ELSE
    FOR i := 1 TO WTIEF DO Blit(100, 10, 10+i*10, 98, 10, 10) END;
  END;
  IF SCHWSP = MENSCH THEN
    Blit(100, 0, 10, 124, 10, 10)
  ELSE
    FOR i := 1 TO STIEF DO Blit(100, 0, 10+i*10, 124, 10, 10) END;
  END;
END ZeigWahl;

PROCEDURE ZeigBrett(brett : Brett);
VAR y, x : INTEGER;
    num : ARRAY[0..1] OF CHAR;
BEGIN
  anz[0] := 0; anz[1] := 0; anz[2] := 0;
  FOR y := 0 TO GROSS-1 DO
    FOR x := 0 TO GROSS-1 DO
      Blit(brett[y,x]*20, 0, 136+x*20, 24+y*20, 20, 20);
      INC(anz[brett[y,x]]);
    END
  END;
  num[0] := CHAR(INTEGER("0")+anz[WEISS] DIV 10);
  num[1] := CHAR(INTEGER("0")+anz[WEISS] MOD 10);
  Quad(88, 32, 111, 55);
  SchreibSchatt(num, 2, 88, 40, 24, 1);
  num[0] := CHAR(INTEGER("0")+anz[SCHWARZ] DIV 10);
  num[1] := CHAR(INTEGER("0")+anz[SCHWARZ] MOD 10);
  Quad(88, 64, 111, 87);
  SchreibSchatt(num, 2, 88, 72, 24, 1);
END ZeigBrett;

PROCEDURE MachAnfang;
BEGIN
  SCHWSP := AMIGA; WEISSP := MENSCH; STIEF := 1; WTIEF := 1;
  restart := FALSE; back := FALSE; zugnum := 0; maxzug := 0;
  amzug := WEISS; paused := FALSE;
  FOR y := 0 TO GROSS-1 DO
    FOR x := 0 TO GROSS-1 DO
      brett[y, x] := LEER;
    END
  END;
  brett[3,4] := SCHWARZ; brett[3,3] := WEISS;
  brett[4,4] := SCHWARZ; brett[4,3] := WEISS;
  ZeigBrett(brett); memory[zugnum].b := brett; memory[zugnum].sp := WEISS;
  Quad(32, 32, 87, 55);
  Quad(32, 64, 87, 87);
  Quad(8, 152, 111, 167); SchreibSchatt("Force Move", 10, 8, 156, 103, 1);
  Quad(8, 168, 47, 183);
  FOR i := 0 TO 1 DO
    SetAPen(rp, 10); Move(rp, 12+i*16, 175); Draw(rp, 24+i*16, 170);
    Draw(rp, 24+i*16, 181); SetAPen(rp, 12); Draw(rp, 12+i*16, 175);
  END;
  Quad(48, 168, 71, 183); Quad(52, 170, 58, 181); Quad(62, 170, 68, 181);
  Quad(72, 168, 111, 183);
  FOR i := 0 TO 1 DO
    SetAPen(rp, 10); Move(rp, 80+i*16, 170); Draw(rp, 92+i*16, 175);
    SetAPen(rp, 12); Draw(rp, 80+i*16, 181); Draw(rp, 80+i*16, 170);
  END;
  Quad(8, 184, 63, 199); SchreibSchatt("New", 3, 8, 188, 55, 1);
  Quad(64, 184, 111, 199); SchreibSchatt("Quit", 4, 64, 188, 47, 1);
  ZeigWahl;
END MachAnfang;

PROCEDURE MachZug(y, x, farb : INTEGER; VAR brett : Brett);
VAR dx, dy, px, py, xx, yy : INTEGER;
    moegl : BOOLEAN;
BEGIN
  brett[y, x] := farb;
  FOR dx := -1 TO 1 DO
    FOR dy := -1 TO 1 DO
      moegl := FALSE;
      IF (dx # 0) OR (dy # 0) THEN
        px := x + dx; py := y + dy;
        WHILE (px>=0) & (px<GROSS) & (py>=0) & (py<GROSS) &
              (brett[py, px] = (1-farb)) DO
          px := px + dx; py := py + dy;
          moegl := TRUE;
        END;
        IF moegl & (px>=0) & (px<GROSS) & (py>=0) & (py<GROSS) &
           (brett[py,px] = farb) THEN
          xx := x + dx; yy := y + dy;
          WHILE NOT ((xx = px) AND (yy = py)) DO
            brett[yy,xx] := farb;
            xx := xx + dx; yy := yy + dy;
          END
        END
      END
    END
  END;
END MachZug;

PROCEDURE ZeigZug(y, x, farb:INTEGER; VAR brett : Brett);
VAR dx, dy, px, py, xx, yy : INTEGER;
    moegl : BOOLEAN;
BEGIN
  FOR i := 0 TO 2 DO
    BltBitMapRastPort(ADR(bm), farb*20, 0, rp,
                        136+x*20, 24+y*20, 20, 20, 0C0H);
    Delay(4);
    BltBitMapRastPort(ADR(bm), 40, 0, rp,
                      136+x*20, 24+y*20, 20, 20, 0C0H);
    Delay(2);
  END;
  MachZug(y, x, farb, brett);
  ZeigBrett(brett);
  INC(zugnum); memory[zugnum].b:=brett; memory[zugnum].sp := 1-farb;
  maxzug := zugnum;
END ZeigZug;

PROCEDURE TestZug(y, x, farb : INTEGER; b : Brett) : BOOLEAN;
VAR dx, dy, px, py, xx, yy : INTEGER;
    moegl : BOOLEAN;
BEGIN
  IF b[y, x] # LEER THEN RETURN FALSE END;
  FOR dx := -1 TO 1 DO
    FOR dy := -1 TO 1 DO
      IF (dx # 0) OR (dy # 0) THEN
        px := x + dx; py := y + dy; moegl := FALSE;
        WHILE (px>=0) & (px<GROSS) & (py>=0) & (py<GROSS) &
              (b[py,px] = (1-farb)) DO
          moegl := TRUE;
          px := px + dx; py := py + dy;
        END;
        IF moegl & (px>=0) & (px<GROSS) & (py>=0) &
           (py<GROSS) & (b[py, px] = farb) THEN
          RETURN TRUE
        END
      END
    END
  END;
  RETURN FALSE
END TestZug;

PROCEDURE TestBrett(farb : INTEGER) : BOOLEAN;
VAR y, x : INTEGER;
BEGIN
  FOR y := 0 TO GROSS-1 DO
    FOR x := 0 TO GROSS-1 DO
      IF TestZug(y, x, farb, brett) THEN
        RETURN TRUE;
      END
    END
  END;
  RETURN FALSE;
END TestBrett;

PROCEDURE Bewertung(b : Brett; farb : INTEGER) : INTEGER;
VAR y, x, erg : INTEGER;
BEGIN
  erg := 0;
  FOR y := 0 TO GROSS-1 DO
    FOR x := 0 TO GROSS-1 DO
      IF b[y, x] = farb THEN INC(erg, wert[y, x])
      ELSIF b[y, x] = 1-farb THEN DEC(erg, wert[y, x])
      END;
    END
  END;
  RETURN erg;
END Bewertung;

PROCEDURE TestMaus(typ : INTEGER);
BEGIN
  IF NOT (gamePort0 IN ciaa.pra) THEN
    mx := scr^.mouseX; my := scr^.mouseY;
    IF (typ = AMIGA) & (mx>8) & (mx<111) & (my>152) & (my<167) THEN
      SetAPen(rp, 11); Move(rp, 8, 152); Draw(rp, 111, 152);
      Draw(rp, 111, 167); Draw(rp, 8, 167); Draw(rp, 8, 152);
      force := TRUE;
    ELSIF (mx>48) & (mx<71) & (my>168) & (my<183) & NOT paused THEN
      SetAPen(rp, 11); Move(rp, 48, 168); Draw(rp, 71, 168);
      Draw(rp, 71, 183); Draw(rp, 48, 183); Draw(rp, 48, 168);
      paused := TRUE;
    ELSIF paused THEN
      IF (mx>48) & (mx<71) & (my>168) & (my<183) THEN
        SetAPen(rp, 10); Move(rp, 48, 168); Draw(rp, 71, 168);
        Draw(rp, 71, 183); SetAPen(rp, 12); Move(rp, 48, 169);
        Draw(rp, 48, 183); Draw(rp, 71, 183);
        paused := FALSE;
      ELSIF (mx>8) & (mx<47) & (my>168) & (my<183) & (zugnum>0)
      THEN back := TRUE;
        SetAPen(rp, 11); Move(rp, 8, 168); Draw(rp, 47, 168);
        Draw(rp, 47, 183); Draw(rp, 8, 183); Draw(rp, 8, 168);
        DEC(zugnum); brett := memory[zugnum].b;
      ELSIF (mx>72) & (mx<111) & (my>168) & (my<183) & (zugnum<maxzug)
      THEN forward := TRUE;
        SetAPen(rp, 11); Move(rp, 72, 168); Draw(rp, 111, 168);
        Draw(rp, 111, 183); Draw(rp, 72, 183); Draw(rp, 72, 168);
        INC(zugnum); brett := memory[zugnum].b;
      ELSIF (mx>8) & (mx<63) & (my>184) & (my<199) THEN
        SetAPen(rp, 11); Move(rp, 8, 184); Draw(rp, 63, 184);
        Draw(rp, 63, 199); Draw(rp, 8, 199); Draw(rp, 8, 184);
        restart := TRUE;
      ELSIF (mx>64) & (mx<111) & (my>184) & (my<199) THEN
        SetAPen(rp, 11); Move(rp, 64, 184); Draw(rp, 111, 184);
        Draw(rp, 111, 199); Draw(rp, 64, 199); Draw(rp, 64, 184);
        quit := TRUE;
      ELSIF (mx>9) & (mx<19) & (my>98) & (my<108) THEN
        WEISSP := MENSCH; ZeigWahl;
      ELSIF (mx>9) & (mx<19) & (my>124) & (my<134) THEN
        SCHWSP := MENSCH; ZeigWahl;
      ELSIF (mx>19) & (mx<111) & (my>98) & (my<108) THEN
        WEISSP := AMIGA; WTIEF := (mx-9) DIV 10; ZeigWahl;
      ELSIF (mx>19) & (mx<111) & (my>124) & (my<134) THEN
        SCHWSP := AMIGA; STIEF := (mx-9) DIV 10; ZeigWahl;
      END;
    END;
    REPEAT UNTIL gamePort0 IN ciaa.pra;
  END
END TestMaus;

PROCEDURE MiniMax(farb, aktfarb, tief, alpha, beta : INTEGER;
                  br : Brett) : INTEGER;
VAR max, min, w, px, py : INTEGER;
    b :Brett;
BEGIN
  IF tief = 0 THEN RETURN Bewertung(br, farb) END;
  max := -10000; min := 10000;
  FOR py := 0 TO GROSS-1 DO
    FOR px := 0 TO GROSS-1 DO
      IF TestZug(py, px, aktfarb, br) THEN
        IF farb = aktfarb THEN
          IF max <= beta THEN
            b := br;
            MachZug(py, px, aktfarb, b);
            w := MiniMax(farb, 1-aktfarb, tief-1, max, 0, b);
            IF w>max THEN max := w END;
          END;
        ELSE
          IF min > alpha THEN
            b := br;
            MachZug(py, px, aktfarb, b);
            w := MiniMax(farb, 1-aktfarb, tief-1, 0, min, b);
            IF w<min THEN min := w END;
          END
        END;
        TestMaus(AMIGA);
        IF quit OR restart OR paused OR
           ((farb = WEISS) & (WEISSP # AMIGA)) OR
           ((farb = SCHWARZ ) & (SCHWSP # AMIGA)) THEN
          RETURN BREAK
        END;
        IF force THEN
          IF farb = aktfarb THEN RETURN max ELSE RETURN min END;
        END;
      END
    END
  END;
  IF farb = aktfarb THEN RETURN max ELSE RETURN min END;
END MiniMax;

PROCEDURE ComputerZug(farb, tiefe : INTEGER; VAR y, x : INTEGER);
VAR max, w, px, py : INTEGER;
    b : Brett;
BEGIN
  max := -10000; x := -1;
  FOR py := 0 TO GROSS-1 DO
    FOR px := 0 TO GROSS-1 DO
      IF TestZug(py, px, farb, brett) THEN
        b := brett;
        MachZug(py, px, farb, b);
        w := MiniMax(farb, 1-farb, tiefe-1, max, 0, b);
        IF w = BREAK THEN x := -1; RETURN END;
        IF (w>max) OR (x = -1) THEN max := w; x := px; y := py; END;
        TestMaus(AMIGA);
        IF restart OR quit OR paused OR ((farb = WEISS) & (WEISSP # AMIGA)) OR
           ((farb = SCHWARZ ) & (SCHWSP # AMIGA)) THEN RETURN END;
        IF force THEN
          SetAPen(rp, 10); Move(rp, 8, 152); Draw(rp, 111, 152);
          Draw(rp, 111, 167);
          SetAPen(rp, 12); Move(rp, 8, 153); Draw(rp, 8, 167);
          Draw(rp, 111, 167);
          force := FALSE; RETURN
        END;
      END
    END
  END;
END ComputerZug;

PROCEDURE MenschZug(farb : INTEGER; VAR y, x : INTEGER) : BOOLEAN;
BEGIN
  x := (mx-136) DIV 20;
  y := (my-24) DIV 20;
  IF (x >= 0) & (x < GROSS) & (y >= 0) & (y < GROSS) THEN
    IF TestZug(y, x, farb, brett) THEN
      RETURN TRUE
    ELSE
      SetRGB4(ADR(scr^.viewPort), 0, 15, 15, 15);
      Delay(1);
      SetRGB4(ADR(scr^.viewPort), 0, 0, 0, 0);
      RETURN FALSE;
    END
  END;
  RETURN FALSE;
END MenschZug;

PROCEDURE SpielEnde;
BEGIN
  IF anz[WEISS] > anz[SCHWARZ] THEN
    Schreib("Wins!", 5, WEISS); Schreib("Looses", 6, SCHWARZ);
  ELSIF anz[WEISS] < anz[SCHWARZ] THEN
    Schreib("Wins!", 5, SCHWARZ); Schreib("Looses", 6, WEISS);
  ELSE
    Schreib("Drawn", 5, SCHWARZ); Schreib("Drawn", 5, WEISS);
  END
END SpielEnde;

PROCEDURE TheEnd;
BEGIN
  IF win#NIL THEN CloseWindow(win) END;
  IF scr#NIL THEN CloseScreen(scr) END;
  FOR i := 0 TO 3 DO
    IF bm.planes[i] # NIL THEN
      FreeRaster(bm.planes[i], 130, 20)
    END
  END;
  IF topaz#NIL THEN CloseFont(topaz) END;
END TheEnd;

PROCEDURE Spiel;
BEGIN
  MachAnfang;
  LOOP
    WHILE paused DO
      TestMaus(PAUSE);
      IF back OR forward THEN
        amzug := memory[zugnum].sp;
        back := FALSE; forward := FALSE;
        IF amzug # KEIN
          THEN Schreib("Move", 4, amzug); Schreib("", 0, 1-amzug);
        ELSE
          SpielEnde;
        END;
        SetAPen(rp, 10); Move(rp, 8, 168); Draw(rp, 47, 168); Draw(rp, 47, 183);
        SetAPen(rp, 12); Move(rp, 8, 169); Draw(rp, 8, 183); Draw(rp, 47, 183);
        SetAPen(rp, 10); Move(rp, 72, 168); Draw(rp, 111, 168);
        Draw(rp, 111, 183); SetAPen(rp, 12); Move(rp, 72, 169);
        Draw(rp, 72, 183); Draw(rp, 111, 183);
        ZeigBrett(brett);
      END;
      IF restart OR quit THEN RETURN END;
    END;
    LOOP
      IF amzug = WEISS THEN
        wZieh := TestBrett(WEISS);
        IF NOT (wZieh OR sZieh) THEN
          SpielEnde; paused := TRUE; memory[zugnum].sp := KEIN;
          SetAPen(rp, 11); Move(rp, 48, 168); Draw(rp, 71, 168);
          Draw(rp, 71, 183); Draw(rp, 48, 183); Draw(rp, 48, 168);
          EXIT
        END;
        IF NOT wZieh THEN
          Schreib("Can't", 5, WEISS);
        ELSE
          Schreib("Move", 4, WEISS);
          LOOP
            IF WEISSP = MENSCH THEN
              LOOP
                WHILE gamePort0 IN ciaa.pra DO END;
                mx := scr^.mouseX; my := scr^.mouseY;
                TestMaus(MENSCH);
                IF paused THEN EXIT END;
                IF WEISSP # MENSCH THEN EXIT END;
                IF MenschZug(WEISS, zy, zx) THEN EXIT END;
              END;
            END;
            IF (WEISSP = AMIGA) THEN
              ComputerZug(WEISS, WTIEF, zy, zx);
            END;
            IF (zx # -1) OR paused THEN EXIT END;
          END;
          IF paused THEN EXIT END;
          ZeigZug(zy, zx, WEISS, brett);
          Schreib("", 0, WEISS);
        END;
        amzug := SCHWARZ;
      END;
      IF amzug=SCHWARZ THEN
        sZieh := TestBrett(SCHWARZ);
        IF NOT (sZieh OR wZieh) THEN
          SpielEnde; paused := TRUE; memory[zugnum].sp := KEIN;
          SetAPen(rp, 11); Move(rp, 48, 168); Draw(rp, 71, 168);
          Draw(rp, 71, 183); Draw(rp, 48, 183); Draw(rp, 48, 168);
          EXIT
        END;
        IF NOT sZieh THEN
          Schreib("Can't", 5, SCHWARZ);
        ELSE
          Schreib("Move", 4, SCHWARZ);
          LOOP
            IF SCHWSP = MENSCH THEN
              LOOP
                WHILE gamePort0 IN ciaa.pra DO END;
                mx := scr^.mouseX; my := scr^.mouseY;
                TestMaus(MENSCH);
                IF paused THEN EXIT END;
                IF SCHWSP # MENSCH THEN EXIT END;
                IF MenschZug(SCHWARZ, zy, zx) THEN EXIT END;
              END;
            END;
            IF SCHWSP = AMIGA THEN
              ComputerZug(SCHWARZ, STIEF, zy, zx);
            END;
            IF (zx # -1) OR paused THEN EXIT END;
          END;
          IF paused THEN EXIT END;
          ZeigZug(zy, zx, SCHWARZ, brett);
          Schreib("", 0, SCHWARZ);
        END;
        amzug := WEISS;
      END;
    END;
  END;
END Spiel;

BEGIN
  TermProcedure(TheEnd);
  WITH ta DO
    name :=ADR("topaz.font"); ySize:=8; style:=normalFont;
    flags:=FontFlagSet{romFont,designed};
  END;
  topaz:=OpenFont(ADR(ta));
  Assert(topaz#NIL, ADR("Kein topaz.font"));
  Start;
  LOOP
    Spiel;
    IF quit THEN EXIT END;
  END;
END Reversi.

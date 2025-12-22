(*$T- Range checking off *)
(*$S- Stack checking off *)
IMPLEMENTATION MODULE TilesPlay;

(* Game stolen from the Mac by Todd Lewis.
   Lots of code ideas from Trails, by Richard Bielak.
   Created: 3/15/88 by Todd Lewis
   Modified:
Copyright (c) 1988 by Todd Lewis
This program can be freely copied, but please
leave my name in. Thanks, Todd.
*)

FROM SYSTEM IMPORT TSIZE,ADR, BYTE, WORD, ADDRESS, SETREG, NULL,CODE;
FROM Intuition IMPORT Image, Border, DrawImage, DrawBorder,RememberPtr,
        AllocRemember,FreeRemember,Remember,IntuitionBase,CurrentTime;
FROM Memory IMPORT MemReqSet,MemChip;
FROM GraphicsLibrary IMPORT GraphicsName, GraphicsBase, Jam2, Jam1,
     Complement, DrawingModeSet, BitMapPtr, BitMap, InitBitMap;
FROM Blitter IMPORT BltBitMapRastPort,BltMaskBitMapRastPort;
FROM BlitterHardware IMPORT BplCon0;
FROM Pens IMPORT Flood, Draw, Move, SetAPen, SetDrMd, RectFill;
FROM PenUtils IMPORT SetWrMsk,SetOPen,BoundaryOff;
FROM Rasters IMPORT TmpRas,InitTmpRas,SetRast,
     RastPortPtr,RastPort,AllocRaster,FreeRaster,InitRastPort;
FROM Screens IMPORT DisplayBeep;
FROM RandomNumbers IMPORT Random, Seed;
FROM Windows IMPORT SetWindowTitles;
FROM InputEvents IMPORT LButton, UpPrefix;
FROM Areas IMPORT AreaDraw,AreaMove,AreaEnd,InitArea,AreaInfo;
FROM InOut IMPORT WriteString, WriteLn,WriteCard;
(* The modules below are home grown *)
FROM TilesIcons IMPORT IconsAddr;
FROM TilesScreen IMPORT wp,sp;

CONST IconTypes = 36;
      LastIcon  = IconTypes - 1;
      maxx = 31; maxy = 17;  ysize = 20-1; xsize = 40-1;
      (* pen numbers/border colors *)
      bcSelected = 12; bcHigh = 13; bcLevel = 14; bcLow = 15;
      rassize = 20 * ((20+15) DIV 8);
TYPE
  TType = (Empty,TopLeft,TopRight,LowLeft,LowRight);
  TileType = RECORD
           Icon,
           ord   : CARDINAL;
           top   : INTEGER;
           tType : TType;
           Played: BOOLEAN;
           Nominated : BOOLEAN;
           END;
  MemRec = RECORD
            x0,y0,z0,
            x1,y1,z1 : CARDINAL;
            END;
  MyBitMapType = RECORD
                bm :ARRAY[0..LastIcon],[0..1],[0..ysize],[0..2] OF WORD;
                END;
  MyBitMapPtr = POINTER TO MyBitMapType;
VAR
  WorkingTitle,PlayTitle,noTitle : ARRAY[0..50] OF CHAR;
  Noms   : CARDINAL;
  rp     : RastPortPtr;
  Tile   : ARRAY[0..maxx],[0..maxy],[0..4] OF TileType;
  MyBitMap : MyBitMapPtr;
  MyBitMap1: MyBitMapPtr;
  TmpBM  : BitMap;
  TmpRP  : RastPort;
  Icons  : ARRAY[0..LastIcon] OF RECORD
              count : CARDINAL;
              image : Image;
              END;
  border1 : Border;
  borderarray : ARRAY[0..15],[0..1] OF INTEGER;
  border2 : Border;
  border2rray : ARRAY[0..15],[0..1] OF INTEGER;
  RememberKey : RememberPtr;
  CurTile : RECORD
               Selected : BOOLEAN;
               x,y,z    : CARDINAL;
               Icon     : CARDINAL;
               END;
  areabuf   : ARRAY[0..250] OF WORD;
  areainfo  : AreaInfo;
  tmpras,tmpras2    : TmpRas;
  tmprasbufptr,tmprbuf2 : ADDRESS; (* points to temporary raster work bitmap *)
  UndoRec : RECORD
               i : CARDINAL;
               LastM : ARRAY[0..122] OF MemRec;
               END;

PROCEDURE FreeBitMap;
  VAR bool : BOOLEAN;
  BEGIN
    FreeRemember(RememberKey,TRUE);
    FreeRaster(TmpBM.Planes[0],300,200);
    FreeRaster(TmpBM.Planes[1],300,200);
    FreeRaster(TmpBM.Planes[2],300,200);
    FreeRaster(TmpBM.Planes[3],300,200);
    END FreeBitMap;

PROCEDURE SeedRandomNumGen;
  VAR Seconds,Micros : LONGCARD;
  BEGIN
    CurrentTime(ADR(Seconds),ADR(Micros));
    Seed(Micros);
    END SeedRandomNumGen;

PROCEDURE InitTiles;
  VAR i,x,y,z : CARDINAL;

  PROCEDURE q(x1,x2, y1,y2, z:CARDINAL);
    VAR x,y : CARDINAL;
    BEGIN
      FOR x := x1 TO x2 BY 2 DO
        FOR y := y1 TO y2 BY 2 DO
          Tile[x  ][y  ][z].tType := TopLeft;
          Tile[x+1][y  ][z].tType := TopRight;
          Tile[x  ][y+1][z].tType := LowLeft;
          Tile[x+1][y+1][z].tType := LowRight;
          END;
        END;
      END q;

  BEGIN
    SetWindowTitles(wp, noTitle, WorkingTitle);
    rp := wp^.RPort;
    SeedRandomNumGen;
    CurTile.Selected := FALSE;
    UndoRec.i := 0;

    borderarray[0,0] := -1;borderarray[0,1] :=21;
    borderarray[1,0] := -1;borderarray[1,1] := 0;
    borderarray[2,0] := -6;borderarray[2,1] :=-3;
    borderarray[3,0] := -6;borderarray[3,1] :=19;
    borderarray[4,0] := -6;borderarray[4,1] :=-3;
    borderarray[5,0] := 35;borderarray[5,1] :=-3;
    borderarray[6,0] := 41;borderarray[6,1] := 0;
    borderarray[7,0] := 41;borderarray[7,1] :=21;
    borderarray[8,0] := -1;borderarray[8,1] :=21;
    borderarray[9,0] := -5;borderarray[9,1] :=19;
    borderarray[10,0]:=  0;borderarray[10,1] :=21;
    borderarray[11,0]:=  0;borderarray[11,1] := 0;
    borderarray[12,0]:= 40;borderarray[12,1]:= 0;
    borderarray[13,0]:= 40;borderarray[13,1]:=21;
    border1.NextBorder := NULL;        border1.LeftEdge := 0;
    border1.XY := ADR(borderarray);    border1.TopEdge  := 0;
    border1.FrontPen := BYTE(13);      border1.Count    := BYTE(14);
    border1.BackPen  := BYTE(3);
    border1.DrawMode := BYTE(Jam1);

    border2rray[0, 0] := 39; border2rray[0, 1] :=-1;
    border2rray[1, 0] := -1; border2rray[1, 1] :=-1;
    border2rray[2, 0] := -1; border2rray[2, 1] :=20;
    border2rray[3, 0] := -2; border2rray[3, 1] :=20;
    border2rray[4, 0] := -2; border2rray[4, 1] :=-1;
    border2rray[5, 0] := -3; border2rray[5, 1] :=-1;
    border2rray[6, 0] := -3; border2rray[6, 1] :=19;
    border2rray[7, 0] := -4; border2rray[7, 1] :=19;
    border2rray[8, 0] := -4; border2rray[8, 1] :=-3;
    border2rray[9, 0] := -5; border2rray[9, 1] :=-3;
    border2rray[10,0] := -5; border2rray[10,1] :=18;
    border2rray[11,0] := -5; border2rray[11,1] :=-3;
    border2rray[12,0] := 35; border2rray[12,1] :=-3;
    border2rray[13,0] := -4; border2rray[13,1] :=-2;
    border2rray[14,0] := 37; border2rray[14,1] :=-2;
    border2.NextBorder := ADR(border1);     border2.LeftEdge := 0;
    border2.XY := ADR(border2rray); border2.TopEdge  := 0;
    border2.FrontPen := BYTE(14);   border2.Count    := BYTE(15);
    border2.BackPen  := BYTE(3);
    border2.DrawMode := BYTE(Jam1);

    IF RememberKey = NULL
       THEN MyBitMap1 := IconsAddr();
            MyBitMap := AllocRemember(RememberKey,TSIZE(MyBitMapType),MemReqSet{MemChip});
            IF MyBitMap # NULL
               THEN MyBitMap^.bm := MyBitMap1^.bm;
               END;

            InitBitMap(TmpBM,4,300,200);
            TmpBM.Planes[0] := AllocRaster(300,200);
            TmpBM.Planes[1] := AllocRaster(300,200);
            TmpBM.Planes[2] := AllocRaster(300,200);
            TmpBM.Planes[3] := AllocRaster(300,200);

            InitRastPort(ADR(TmpRP));
            TmpRP.bitMap := ADR(TmpBM);
            TmpRP.tmpRas := ADR(tmpras);
            rp^.tmpRas   := ADR(tmpras2);
            tmprasbufptr := AllocRemember(RememberKey,
                              rassize,
                              MemReqSet{MemChip});
            tmprbuf2     := AllocRemember(RememberKey,
                              rassize,
                              MemReqSet{MemChip});


            InitArea(areainfo,areabuf,100);
            InitTmpRas(ADR(tmpras),tmprasbufptr,rassize);
            InitTmpRas(ADR(tmpras2),tmprbuf2,rassize);
       END;

    SetRast(rp,0);
    FOR x := 0 TO maxx DO
      FOR y := 0 TO maxy DO
        FOR z := 0 TO 4 DO
          WITH Tile[x,y,z] DO
            tType := Empty; Played := TRUE;
            Icon := 0; ord := 0; Nominated := FALSE;
            top := -1;
            END;
          END;
        END;
      END;

    FOR x := 0 TO LastIcon DO
      WITH Icons[x] DO
        count := 0;
        WITH image DO
          ImageData := ADR(MyBitMap^.bm[x]);  LeftEdge := 1;
          PlanePick := BYTE(3);         TopEdge  := 1;
          PlaneOnOff:= BYTE(0);  Width := 40; Height := 20; Depth := 2;
          NextImage := NULL;
          END;
        END;
      END;

    (*x1,x2,y1,y2, z *)
    (* Bottom Layer *)   (* Second Layer *)
    q( 3,25, 1, 1, 0);   q( 9,19, 3,13, 1);
    q( 7,21, 3,13, 0);
    q( 3,25,15,15, 0);   (* Third Layer  *)
    q( 5,23, 5,11, 0);   q(11,17, 5,11, 2);
    q( 3,25, 7, 9, 0);   (* Fourth Layer *)
    q( 1, 1, 8, 8, 0);   q(13,15, 7, 9, 3);
    q(27,29, 8, 8, 0);   q(14,14, 8, 8, 4);

    PlaceTiles;

    border1.FrontPen := BYTE(15);
    border2.FrontPen := BYTE(14);
    FOR z := 0 TO 4 DO
      FOR x := maxx TO 1 BY -1 DO
        FOR y := maxy TO 1 BY -1 DO
          IF Tile[x,y,z].tType = TopLeft
             THEN (* Show(x,y,z,FALSE);*) (* x,y,z are Normalized *)
                  IF Visible(x,y,z)
                     THEN DrawImage(rp,Icons[Tile[x,y,z].Icon].image,
                            px(x) + 5 + 6*z,
                            py(y) + 2 + 3*z);
                          DoShadows(rp,x,y,z,px(x)+5+6*z,py(y)+2+3*z);
                     END;
                  DrawBorder(rp,border2,px(x)+5+6*z,py(y)+2+3*z);
             END;
          END;
        END;
      END;
    SetWindowTitles(wp, noTitle, PlayTitle);
    END InitTiles;

PROCEDURE PlaceTiles;
  VAR x,y,z,i, cnt : CARDINAL;
      TilesPlaced : CARDINAL;
      UnPlaceGroupSize : CARDINAL;
  PROCEDURE PlaceTilesSetUp;
    VAR y : CARDINAL;
    BEGIN
      SetRast(rp,6);
      TilesPlaced := 0;
      UnPlaceGroupSize := 8; (* Seems like a good number? *)
      ClearNoms();
      UndoRec.i := 0;
      z := 0; (* work on bottom level *)
      FOR y := 1 TO 15 BY 2 DO  (* get each row *)
        x := 9 + Random(5) * 2; (* should be a TopLeft tile *)
        Normalize(x,y,z);  (* but don't take chances *)
        SetNominated(x,y,z, TRUE);
        END;
      Noms := NomCount();
      (* Now we should have 8 Tiles nominated for board use. *)
      SetRast(rp,0);
      END PlaceTilesSetUp;
  BEGIN
    PlaceTilesSetUp;
    WHILE (TilesPlaced < (IconTypes * 4)) DO
      IF (Noms > 1)
         THEN Place2Tiles();
              TilesPlaced := TilesPlaced + 2;
         ELSE UnPlaceGroupSize := UnPlaceGroupSize + 2;
              IF (UnPlaceGroupSize >= TilesPlaced)
                 THEN PlaceTilesSetUp;
                 ELSE FOR i := 0 TO UnPlaceGroupSize BY 2 DO
                          UnPlace2Tiles;
                          TilesPlaced := TilesPlaced - 2;
                          END; (* FOR *)
                 END; (* IF *)
         END;
      END; (* WHILE *)
    UndoRec.i := 0;
    END PlaceTiles;

PROCEDURE SetPlayed(x,y,z:CARDINAL; played:BOOLEAN);
  BEGIN
    Tile[x,y  ,z].Played := played;  Tile[x+1,y  ,z].Played := played;
    Tile[x,y+1,z].Played := played;  Tile[x+1,y+1,z].Played := played;
    IF NOT played
       THEN SetNominated(x,y,z,FALSE);
       END;
    Tile[x,y  ,0].top:=ColTop(x,y);  Tile[x+1,y  ,0].top:=ColTop(x+1,y);
    Tile[x,y+1,0].top:=ColTop(x,y+1);Tile[x+1,y+1,0].top:=ColTop(x+1,y+1);
    END SetPlayed;

PROCEDURE SetNominated(x,y,z:CARDINAL; n:BOOLEAN);
  BEGIN
    IF (Tile[x,y,z].Nominated = n) THEN RETURN; END;
    Tile[x,y  ,z].Nominated := n;  Tile[x+1,y  ,z].Nominated := n;
    Tile[x,y+1,z].Nominated := n;  Tile[x+1,y+1,z].Nominated := n;
    IF n
       THEN INC(Noms);
       ELSE IF (Noms > 0)
               THEN DEC(Noms);
               END;
       END;
    END SetNominated;

PROCEDURE UnPlace2Tiles;
  VAR a,b,c : CARDINAL;
  BEGIN
    WITH UndoRec.LastM[UndoRec.i] DO
      DEC(Icons[Tile[x0,y0,z0].Icon].count);
      DEC(Icons[Tile[x0,y0,z0].Icon].count);
      WITH Tile[x0,y0,z0] DO
        Icon := 0;
        ord := 0;
        END; (* WITH *)
      SetPlayed(x0,y0,z0,TRUE);
      SetNominated(x0,y0,z0,FALSE);
      WITH Tile[x1,y1,z1] DO
        Icon := 0;
        ord := 0;
        END; (* WITH *)
      SetPlayed(x1,y1,z1,TRUE);
      SetNominated(x1,y1,z1,FALSE);
      END; (* WITH *)
    DEC(UndoRec.i);
    FOR a := 1 TO 31 DO
      FOR b := 1 TO 15 DO
        FOR c := 0 TO 4 DO
          IF (Tile[a,b,c].tType = TopLeft)
             THEN SetNominated(a,b,c,FALSE);
             END;
          END;
        END;
      END;
    FOR a := 1 TO 31 DO
      FOR b := 1 TO 15 DO
        FOR c := 0 TO 4 DO
          IF (Tile[a,b,c].tType = TopLeft)
             THEN NomTest(a,b,c); (* a,b,and c are Normalized *)
             END;
          END;
        END;
      END;
    END UnPlace2Tiles;

PROCEDURE NomTest( a,b,c: CARDINAL);  (* a,b,c should be Normalized *)
  VAR d,e,f, i,j,k : CARDINAL;
     ci : INTEGER;
     Ok1,Ok2 : BOOLEAN;
  BEGIN
    IF (Tile[a,b,c].tType # TopLeft) THEN RETURN; END;
    IF (Tile[a,b,c].Played = FALSE) THEN RETURN; END;

    ci := INTEGER( c - 1 );
    IF (ColTop(a,b  ) # ci) OR (ColTop(a+1,b  ) # ci) OR
       (ColTop(a,b+1) # ci) OR (ColTop(a+1,b+1) # ci)
       THEN RETURN; END;

    IF (Tile[a-1,b  ,c].Played = FALSE) AND
       (Tile[a-1,b+1,c].Played = FALSE)
       THEN SetNominated(a,b,c,TRUE);
            RETURN;
       END;

    IF (Tile[a+2,b  ,c].Played = FALSE) AND
       (Tile[a+2,b+1,c].Played = FALSE)
       THEN SetNominated(a,b,c,TRUE);
            RETURN;
       END;

    (* if there are no other pieces placed or nominated
       on my row, then I can accept the nomination *)
    d := 1; e := b + 1;
    LOOP
      IF (Tile[d, b, c].Played = FALSE) THEN RETURN; END;
      IF (Tile[d, e, c].Played = FALSE) THEN RETURN; END;
      IF (Tile[d, b, c].Nominated) THEN RETURN; END;
      IF (Tile[d, e, c].Nominated) THEN RETURN; END;
      INC(d);
      IF (d > 30) THEN EXIT; END;
      END; (* LOOP *)
    SetNominated(a,b,c,TRUE);
    END NomTest;

PROCEDURE Place2Tiles();
  VAR x,y,z,X1,Y1,Z1,X2,Y2,Z2,a,b,c,d : CARDINAL;
  BEGIN
    REPEAT
      a := Random(Noms) + 1;   (* [1..Noms] *)
      b := Random(Noms) + 1;
      UNTIL (a # b) AND (a > 0) AND (a <=Noms) AND
                        (b > 0) AND (b <=Noms);
    REPEAT
      c := Random(IconTypes);  (* [0..IconTypes-1] *)
      UNTIL (Icons[c].count < 4);
    d := 0;
    x := 1;
    WHILE (x <= 31) AND ((d < a) OR (d < b)) DO
      y := 1;
      WHILE (y <=15 ) AND ((d < a) OR (d < b)) DO
        z := 0;
        WHILE ((NOT Tile[x,y,z].Played) OR (Tile[x,y,z].Nominated)) AND
              ( z < 5                                             ) DO
          WITH Tile[x,y,z] DO
            IF (tType = TopLeft) AND ( Nominated )
               THEN d := d + 1;
                    IF (d = a) OR (d = b)
                       THEN SetNominated(x,y,z,FALSE);
                            INC(Icons[c].count);
                            Icon := c;
                            SetPlayed(x,y,z,FALSE);
                            ord := Icons[c].count;
                            IF (d = a)
                               THEN X1 := x; Y1 := y; Z1 := z;
                               ELSE X2 := x; Y2 := y; Z2 := z;
                               END;
                            (* Show(x,y,z,TRUE); *)
                       END; (* IF *)
               END; (* IF *)
            END; (* WITH *)
          INC(z);
          END; (* WHILE ... *)
        INC(y);
        END;  (* WHILE y ... *)
      INC(x)
      END;  (* WHILE x *)
    INC(UndoRec.i);
    WITH UndoRec.LastM[UndoRec.i] DO
      x0 := X1; y0 := Y1; z0 := Z1;
      x1 := X2; y1 := Y2; z1 := Z2;
      END;
    DoNomsAround(X1,Y1,Z1);
    DoNomsAround(X2,Y2,Z2);
    END Place2Tiles;

PROCEDURE DoNomsAround(x,y,z: CARDINAL);
  BEGIN
    IF (x > 1)
       THEN Nominate(x-1,y  ,z);
            Nominate(x-1,y+1,z);
       END;
    IF (z < 4)
       THEN Nominate(x  ,y  ,z+1);
            Nominate(x  ,y+1,z+1);
            Nominate(x+1,y  ,z+1);
            Nominate(x+1,y+1,z+1);
       END;
    IF (x < 29)
       THEN Nominate(x+2,y  ,z);
            Nominate(x+2,y+1,z);
       END;
    END DoNomsAround;

PROCEDURE Nominate(x,y,z:CARDINAL);
  BEGIN
    Normalize(x,y,z);
    IF (Tile[x,y,z].tType # TopLeft) THEN RETURN; END;
    NomTest(x,y,z); (* x,y, and z are Normalized *)
    END Nominate;

PROCEDURE ClearNoms();
  VAR x,y,z : CARDINAL;
  BEGIN
    FOR x := 0 TO LastIcon DO
      WITH Icons[x] DO
        count := 0;
        WITH image DO
          ImageData := ADR(MyBitMap^.bm[x]);  LeftEdge := 1;
          PlanePick := BYTE(3);         TopEdge  := 1;
          PlaneOnOff:= BYTE(0);  Width := 40; Height := 20; Depth := 2;
          NextImage := NULL;
          END;
        END;
      END;
    FOR x := 1 TO maxx DO
      FOR y := 1 TO maxy DO
        FOR z := 0 TO 4 DO
          WITH Tile[x,y,z] DO
            top := -1;
            IF tType = TopLeft
               THEN SetNominated(x,y,z,FALSE);
                    Icon := 0; ord := 0;
                    SetPlayed(x,y,z,TRUE);
               END;
            END; (* WITH *)
          END; (* FOR z *)
        END; (* FOR y *)
      END; (* FOR x *)
    Noms := 0;
    END ClearNoms;

PROCEDURE NomCount():CARDINAL;
  VAR x,y,z,a : CARDINAL;
  BEGIN
    a := 0;
    FOR x := 1 TO 31 DO
      FOR y := 1 TO 15 DO
        FOR z := 0 TO 4 DO
          WITH Tile[x,y,z] DO
            IF tType = TopLeft
               THEN IF Nominated THEN INC(a); END;
               END;
            END; (* WITH *)
          END; (* FOR z *)
        END; (* FOR y *)
      END; (* FOR x *)
    Noms := a;
    RETURN a;
    END NomCount;

PROCEDURE Visible(x,y:CARDINAL; Z:WORD):BOOLEAN;
  VAR z : INTEGER;
  BEGIN
    z := INTEGER(Z);
    IF (ColTop(x,y  ) = z) OR (ColTop(x+1,y  ) = z) OR
       (ColTop(x,y+1) = z) OR (ColTop(x+1,y+1) = z)
       THEN RETURN TRUE;
       ELSE RETURN FALSE;
       END;
    END Visible;

PROCEDURE UnDo;
  BEGIN
    IF UndoRec.i = 0 THEN RETURN; END;
    DEC(UndoRec.i);
    WITH UndoRec.LastM[UndoRec.i] DO
      SetPlayed(x0,y0,z0,FALSE);
      SetPlayed(x1,y1,z1,FALSE);
      Show(x0, y0, z0, TRUE);  (* these coordinates are Normalized *)
      Show(x1, y1, z1, TRUE);  (* and so are these                 *)
      END;
    END UnDo;

PROCEDURE RemoveTiles(x,y,z:CARDINAL);
  VAR x1,y1 : CARDINAL;
  PROCEDURE sh(x,y,z:CARDINAL; bool:BOOLEAN);
    BEGIN
      Show(x,y,z,bool);
      IF (INTEGER(z) >= 0)
         THEN IF Tile[x,y,z].tType # TopLeft
                 THEN Show(x+1,y,z,bool);
                      Show(x+1,y+1,z,bool);
                      Show(x,y+1,z,bool);
                 END;
         END;
      END sh;
  BEGIN
    WITH UndoRec.LastM[UndoRec.i] DO
         x0 := x;
         y0 := y;
         z0 := z;
         x1 := CurTile.x;
         y1 := CurTile.y;
         z1 := CurTile.z;
         END;
    INC(UndoRec.i);

    SetPlayed(CurTile.x,CurTile.y,CurTile.z, TRUE);
    SetPlayed(        x,        y,        z, TRUE);
    sh(        x,         y,         z - 1, TRUE);
    sh(CurTile.x, CurTile.y, CurTile.z - 1, TRUE);
    CurTile.Selected := FALSE;
    END RemoveTiles;

PROCEDURE Select(x,y,z:CARDINAL);
  BEGIN
    IF CurTile.Selected
       THEN IF (x = CurTile.x) AND (y = CurTile.y) AND (z = CurTile.z)
               THEN DeSelect(CurTile.x,CurTile.y,CurTile.z);
                    RETURN;
               END;
            (* If we get here, x,y,z is a different Tile. *)
            IF CurTile.Icon = Tile[x,y,z].Icon
               THEN RemoveTiles(x,y,z);
                    RETURN;
               END;
            (* If we get here, we have selected a different Icon type,
               so Deselect the current one and highlight the new one. *)
            DeSelect(CurTile.x,CurTile.y,CurTile.z);
       END;

    Icons[Tile[x,y,z].Icon].image.PlaneOnOff := BYTE(0);
    CurTile.Selected := TRUE;
    CurTile.x := x;  CurTile.y := y;  CurTile.z := z;
    CurTile.Icon := Tile[x,y,z].Icon;
    Show(x,y,z,TRUE);
    END Select;

PROCEDURE DeSelect(x,y,z:CARDINAL);
  BEGIN
    IF CurTile.Selected
       THEN CurTile.Selected := FALSE;
            Show(x,y,z,TRUE);
       END;
    END DeSelect;

PROCEDURE Show(x,y:CARDINAL; Z:WORD; doShadow :BOOLEAN);
  VAR cx,cy,z,x1,y1,z1,level,sx,sy,shx,shy,xxx,yyy : CARDINAL;
      tx,ty,dl,
      j,col,row : INTEGER;
  BEGIN
    IF (x < 1) OR (x > 30) OR (y < 1) OR (y > 16) THEN RETURN; END;
    j := INTEGER(Z);
    z := CARDINAL(Z);
    TmpRP.Mask := BYTE(15);
    SetRast(ADR(TmpRP),0);  (* Clear Temp Rast Port *)
    border1.FrontPen := BYTE(15);
    border2.FrontPen := BYTE(14);
    DrawBorder( ADR(TmpRP), border2, 6, 3);
    border1.FrontPen := BYTE(12);
    border2.FrontPen := BYTE(13);
    DrawBorder( ADR(TmpRP), border2,54, 3);
    FOR level := 0 TO 4 DO
      FOR col := Min(2,30-x) TO Max(-3,-INTEGER(x)) BY -1 DO
        FOR row := Min(2,16-y) TO Max(-3,-INTEGER(y)) BY -1 DO
          tx := INTEGER(x) + col;  cx := CARDINAL(tx);
          ty := INTEGER(y) + row;  cy := CARDINAL(ty);
          IF (Tile[tx,ty,level].tType = TopLeft) AND
             (Tile[tx,ty,level].Played = FALSE)
             THEN sy := 0;
                  sx := 0;
                  Icons[Tile[tx,ty,level].Icon].image.PlaneOnOff := BYTE(0);
                  IF (CurTile.Selected ) AND (CurTile.x = CARDINAL(tx)) AND
                     (CurTile.y = CARDINAL(ty)) AND (CurTile.z = level)
                     THEN Icons[Tile[tx,ty,level].Icon].image.PlaneOnOff := BYTE(4);
                          sx := 48;
                     END;
                  TmpRP.Mask := BYTE(15);
                  IF (Visible(tx,ty,level))
                     THEN DrawImage(ADR(TmpRP),
                            Icons[Tile[tx,ty,level].Icon].image,
                            150+21*col+INTEGER(level)*6,
                            100+11*row+INTEGER(level)*3);
                          DoShadows(ADR(TmpRP),cx,cy,level,
                            150+21*CARDINAL(col)+level*6,
                            100+11*CARDINAL(row)+level*3);
                     END;
                  BltMaskBitMapRastPort(TmpRP.bitMap^,sx,sy,ADR(TmpRP),
                            150+21*CARDINAL(col)+level*6-6,
                            100+11*CARDINAL(row)+level*3-3,
                            48,25,0E0H,(* ABC+ABNC+ANBC *)TmpRP.bitMap^.Planes[3]);
             END;
          END;
        END;
      END;
    rp^.Mask := BYTE(15);
    BltBitMapRastPort(TmpBM,144,97,
                      rp,px(x)-1,py(y)-1,
                      Min(73,639-px(x)),Min(41,199-py(y)),12*16);
    END Show;

PROCEDURE DoShadows(dRP:RastPortPtr; x,y,z, x0, y0 : CARDINAL);
    VAR xxx, yyy, shx, shy : CARDINAL;
        dl : INTEGER;
    BEGIN
      dRP^.Mask := BYTE(8);
      SetAPen( dRP, 8);
      FOR shx := 0 TO  1 DO
          FOR shy := 0 TO 1 DO
              xxx := x0 + 21*shx;
              yyy := y0 + 11*shy;

              dl  := ColTop(x+shx-1,y+shy) - ColTop(x+shx,y+shy);
              IF (dl > 0)
                 THEN Shadow( dRP,xxx,yyy,
                      xxx+CARDINAL(Min(8*dl+2,20)),yyy+CARDINAL(Min(4*dl,10)),
                      xxx+CARDINAL(Min(8*dl+2,20)),yyy+10,
                      xxx,yyy+10);
                 END;

              dl := ColTop(x+shx-1,y+shy-1) - ColTop(x+shx,y+shy);
              IF (dl > 0)
                 THEN Shadow(dRP,xxx,yyy,
                      xxx+CARDINAL(Min(8*dl+2,20)),yyy,
                      xxx+CARDINAL(Min(8*dl+2,20)),yyy+CARDINAL(Min(4*dl,10)),
                      xxx,yyy+CARDINAL(Min(4*dl,10)));
                 END;

              dl := ColTop(x+shx,y+shy-1) - ColTop(x+shx,y+shy);
              IF (dl > 0)
                 THEN Shadow(dRP,xxx,yyy,
                      xxx+20,yyy,
                      xxx+20,yyy+CARDINAL(Min(4*dl,10)),
                      xxx+CARDINAL(Min(8*dl-2,20)),yyy+CARDINAL(Min(4*dl,10)));
                 END;
              END;
          END;
      dRP^.Mask := BYTE(15);
      SetAPen( dRP, 15);
      END DoShadows;

PROCEDURE Shadow(RPs: RastPortPtr; x0,y0, x1,y1, x2,y2, x3,y3:CARDINAL);
  VAR
      i   : INTEGER;
  BEGIN
    SetDrMd( RPs, Jam1);
    SetAPen( RPs, 8 );
    RPs^.Mask := BYTE(8);
    BoundaryOff( RPs );
    RPs^.areaInfo := ADR(areainfo);
    i := AreaMove(RPs,x0,y0);
    i := AreaDraw(RPs,x1,y1);
    i := AreaDraw(RPs,x2,y2);
    i := AreaDraw(RPs,x3,y3);
    AreaEnd( RPs );
    END Shadow;

(***************
PROCEDURE DrawLine(color,x1,y1,x2,y2:CARDINAL);
  BEGIN
    SetAPen(rp, color);
    SetDrMd(rp, Jam1);
    Move   (rp, x1, y1);
    Draw   (rp, x2, y2);
    END DrawLine;
**************)

PROCEDURE ColTop(x,y:CARDINAL):INTEGER;
  VAR t,i : INTEGER;
  BEGIN
    t := -1;
    IF (INTEGER(x) >= 0) AND (INTEGER(x) <=31) AND
       (INTEGER(y) >= 0) AND (INTEGER(y) <=17)
       THEN FOR i := 0 TO 4 DO
              IF (Tile[x,y,i].Played = FALSE) THEN t := i; END;
              END;
            Tile[x,y,0].top := t;
       END;
    RETURN t;
    END ColTop;

PROCEDURE Playable(x,y,z:CARDINAL):BOOLEAN;
  VAR zi : INTEGER;
  BEGIN
    zi := INTEGER(z);
    IF ( x < 1) OR (x > 30) OR
       ( y < 1) OR (y > 16) OR
       (zi < 0) OR (z > 4)  THEN RETURN FALSE; END;
    IF (*Tile[x,  y  ,0].top*)
       ColTop(x  ,y  ) > zi THEN RETURN FALSE; END;
    IF (*Tile[x+1,y  ,0].top*)
       ColTop(x+1,y  ) > zi THEN RETURN FALSE; END;
    IF (*Tile[x+1,y+1,0].top*)
       ColTop(x+1,y+1) > zi THEN RETURN FALSE; END;
    IF (*Tile[x  ,y+1,0].top*)
       ColTop(x  ,y+1) > zi THEN RETURN FALSE; END;

    IF ( ColTop(x-1,y  ) < zi) AND
       ( ColTop(x-1,y+1) < zi)
       THEN RETURN TRUE;
       END;
    IF ( ColTop(x+2,y  )  < zi) AND
       ( ColTop(x+2,y+1)  < zi)
       THEN RETURN TRUE;
       END;
    RETURN FALSE;
    END Playable;

PROCEDURE Normalize(VAR x,y,z : CARDINAL);
  BEGIN
    IF (z < 5)
       THEN CASE Tile[x,y,z].tType OF
                Empty    :
             |  TopLeft  :
             |  TopRight : x := x - 1;
             |  LowLeft  : y := y - 1;
             |  LowRight : y := y - 1; x := x - 1;
             ELSE
             END;
       END;
    END Normalize;

PROCEDURE UserInput(x,y:CARDINAL);
  VAR z : CARDINAL; zi : INTEGER;
      tx, ty: INTEGER;
  PROCEDURE DESELECT;
     BEGIN
       DeSelect(CurTile.x,CurTile.y,CurTile.z);
       END DESELECT;
  PROCEDURE LevelShift(dx,dy,level:INTEGER):BOOLEAN;
     BEGIN
       tx := INTEGER(x) - dx;  ty := INTEGER(y) - dy;
       IF (tx < 0) OR (ty < 0) THEN RETURN FALSE; END;
       tx := (tx+15) DIV 21;
       IF ty > 4
          THEN ty := (ty-4) DIV 11;
          ELSE ty := 0;
          END;
       IF (ColTop(tx,ty) = level) OR (level = 0)
          THEN x := CARDINAL(tx);
               y := CARDINAL(ty);
               RETURN TRUE;
          ELSE RETURN FALSE;
          END;
       END LevelShift;
  BEGIN
    IF NOT LevelShift(24,12,4)
       THEN IF NOT LevelShift(18,9,3)
               THEN IF NOT LevelShift(12,6,2)
                       THEN IF NOT LevelShift(6,3,1)
                               THEN IF LevelShift(0,0,0) THEN END;
                               END;
                       END;
               END;
       END;
    zi := ColTop(x,y);
    IF zi >= 0
       THEN z := CARDINAL(zi);
            Normalize(x,y,z);
            (* Send x, y, and z off to be processed *)
            (* then return to the caller *)
            IF Playable(x,y,z)
               THEN Select(x,y,z);
               ELSE DESELECT;
               END;
       ELSE IF CurTile.Selected
               THEN DESELECT;
               ELSE UnDo;
               END;
       END;
    END UserInput;

PROCEDURE px(x:CARDINAL):CARDINAL;
  BEGIN
    IF INTEGER(x) > 0
       THEN RETURN 21*x-20;
       ELSE RETURN 0;
       END;
    END px;

PROCEDURE py(y:CARDINAL):CARDINAL;
  BEGIN
    IF INTEGER(y) > 0
       THEN RETURN 2+11*y;
       ELSE RETURN 0;
       END;
    END py;

PROCEDURE dx(x:CARDINAL):CARDINAL;
  BEGIN
    IF INTEGER(x) > 0
       THEN RETURN x * 4;
       ELSE RETURN 0;
       END;
    END dx;

PROCEDURE dy(y:CARDINAL):CARDINAL;
  BEGIN
    IF INTEGER(y) > 0
       THEN RETURN y * 2;
       ELSE RETURN 0;
       END;
    END dy;

PROCEDURE Max(a,b:INTEGER):INTEGER;
BEGIN
  IF a<b
     THEN RETURN b;
     ELSE RETURN a;
     END;
  END Max;

PROCEDURE Min(a,b:INTEGER):INTEGER;
BEGIN
  IF b<a
     THEN RETURN b;
     ELSE RETURN a;
     END;
  END Min;


BEGIN
  RememberKey  := NULL;
  WorkingTitle := " Building new board.  Please wait...";
  PlayTitle    := " Tiles!      Version 2.1";
  noTitle      := "";
  END TilesPlay.



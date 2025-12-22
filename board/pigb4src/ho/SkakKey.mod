IMPLEMENTATION MODULE SkakKey; (* EBM 95 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=TRUE StackParms:=FALSE CStrings:=TRUE LargeVars:=FALSE *)

(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=FALSE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=FALSE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT
  ADDRESS,ADR;
FROM GraphicsD IMPORT
  DrawModeSet, DrawModes;
FROM IntuitionD IMPORT
  boolGadget, stdScreenHeight, GadgetPtr, IDCMPFlagSet, IDCMPFlags,
  IntuiMessagePtr, WindowPtr, WindowFlags, WindowFlagSet, strGadget, propGadget,
  PropInfoPtr, StringInfoPtr, IntuiText, gadgHNone, IntuiTextPtr, GadgetFlags;
FROM IntuitionL IMPORT
  CloseWindow, RefreshGList, PrintIText, NewModifyProp, ActivateGadget,
  ActivateWindow, SizeWindow, WindowToBack;
FROM String IMPORT
  Copy;
FROM QuickIntuition IMPORT
  AF, AFS, GFS, AddGadget, AddIntuiText, AddBorder, OutLine, AddStringInfo;
FROM QISupport IMPORT
  SimpleWIN, TwoGadWIN, ThreeGadWIN,
  VINDUE, STRINGPTR, CREATEWIN, OPENWIN, WAITWIN, CLOSEWIN, MSGWIN, PRINTWIN,
  EscWIN, OkWIN, DropWIN, ActiveWIN, InactiveWIN, OpenInfoWIN, PrintInfoWIN,
  CloseInfoWIN, swptr, CenterWIN, txtOK, txtDROP, txtUPS, MsgCloseInfoWIN,
  SetGadget, SetToggl, GetToggl;
FROM SkakBase IMPORT
  MaxTraek, LongFormOn, MouthOff, Quick, InterOn, LotMemOn, NoAutoPGN,
  SetUpMode, STILLINGTYPE, VlmO, VlmU, VlpO, VlpU, Lates3, L1b;
FROM SkakBrain IMPORT
  Spil, stilling, GetNext, Mirror, stVsum, MOVETYPE;
FROM SkakBrainX IMPORT
  GetV, GetD;
FROM SkakSprog IMPORT
  Q;
FROM SkakFil IMPORT
  teoWIN;
FROM SkakScreen IMPORT
  ttMOUTHOFF, ttLOTMEMON, ttNOAUTOPGN, ttQUICK,
  ttINTERNATIONAL, ttLONGFORMWRITE, ttPGN;
FROM SkakTeori IMPORT
  VluToStr;
FROM VersionLog IMPORT
  LogVersion;

(*$IF Test *)
  FROM W IMPORT
    WRITELN, WRITE, CONCAT, s, l, lf, c, READs, b;
(*$ENDIF *)

CONST
  SkakKeyModCompilation="34";
  f2f4=2646;
  e2e4=2545;
  d2d4=2444;
  c2c4=2343;
  b2b4=2242;
  f7f5=7656;
  e7e5=7555;
  d7d5=7454;
  c7c5=7353;
  g2g3=2737;
  b2b3=2232;
  g7g6=7767;
  e7e6=7565;
  d7d6=7464;
  c7c6=7363;
  g1f3=1736;
  g8f6=8766;
  b1c3=1233;
  b8c6=8263;
  f1c4=1643;
  f1b5=1652;
  f8b4=8642;
  c1g5=1357;
  f8e7=8675;
  b8d7=8274;
  c5d4=5344;
  d5c4=5443;
  e2e3=2535;
  e8g8=8587;
  f8g7=8677;
  f2f3=2636;
  d4d5=4454;
  e6d5=6554;
  a7a6=7161;
  e1g1=1517;
  d1c2=1423;
  c4d5=4354;
  b5a4=5241;
  b7b5=7252;
  a4b3=4132;
  f3d4=3644;
  f1e1=1615;

  PosX =10;
  PosYS=14;
  SzY  =10;
  SzX  = 8;
  GdCnt= 7;

  TeoW          =313;   (*'W';                              313-324 Sprog *)
  TeoB          =314;   (*'B';*)
  TeoDrawStat   =315;   (*'Draw values:  Statistic:';*)
  TeoTeoF3      =316;   (*'Theory: F3=Import';*)
  TeoLOAD       =317;   (*' LOAD ';*)
  TeoSAVE       =318;   (*' SAVE ';*)
  TeoNEW        =319;   (*' NEW  ';*)
  TeoPos        =320;   (*'Position';*)
  TeoDELETE     =321;   (*'DELETE';*)
  TeoGame       =322;   (*'Game:';*)
  TeoANALYZE    =323;   (*'ANALYZE ';*)
  TeoADD        =324;   (*' ADD ';*)

PROCEDURE GetOpeningKeys(VAR ECO,NIC:ARRAY OF CHAR);
CONST
  need=14;
VAR
  n,max:INTEGER;
  m:ARRAY[0..need-1] OF INTEGER;
  eco,nic:ARRAY[0..3] OF CHAR;
BEGIN
  max:=MaxTraek;
  IF max>need THEN
    max:=need;
  END;
  FOR n:=1 TO max DO
    m[n-1]:=Spil^[n].Fra*100+Spil^[n].Til;
  END;
  FOR n:=max TO need-1 DO
    m[n]:=0;
  END;

  IF m[0]=d2d4 THEN                                       (* Ab Ac Ad Da Db Ea Eb *)
    IF m[1]=d7d5 THEN                                     (*          Da D0-D6    *)
      IF m[2]=c2c4 THEN                                   (*             D0-D6    *)
        nic:='QG';
        IF m[3]=e7e6 THEN                                 (*             D3-D6    *)
          IF (m[4]=b1c3) & (m[5]=g8f6) THEN               (* D3-D6                *)
            IF (m[6]=c1g5) THEN
              IF (m[7]=f8e7) & (m[8]=e2e3)
              & (m[9]=e8g8) & (m[10]=g1f3)
              & (m[11]=b8d7) THEN                         
                eco:='D6';
              ELSE
                eco:='D5';
              END;
            ELSE
              IF (m[6]=g1f3) & ((m[7]=c7c5) OR (m[7]=c7c6)) THEN
                eco:='D4';
              ELSE
                eco:='D3';
              END;
            END;
          ELSE
            eco:='D3'
          END;
        ELSE                                              (* D0-D2                *)
          IF m[3]=c7c6 THEN
            eco:='D1';
          ELSIF m[3]=d5c4 THEN
            eco:='D2';
          ELSE
            eco:='D0';
          END;
        END;
      ELSE
        eco:='D0';
        nic:='QP';
      END;
    ELSIF m[1]=g8f6 THEN                                  (*    Ac Ad    Db Ea Eb *)
      IF m[2]=c2c4 THEN                                   (*       Ad    Db Ea Eb *)
        IF m[3]=e7e6 THEN                                 (*                Ea    *)
          IF m[4]=b1c3 THEN                               (* E2-E5                *)
            IF m[5]=f8b4 THEN                             (* E2-E5                *)
              nic:='NI';
              IF m[6]=e2e3 THEN
                IF (m[7]=e8g8) & (m[8]=g1f3) THEN
                  eco:='E5';
                ELSE
                  eco:='E4';
                END;
              ELSE
                IF (m[6]=c1g5) OR (m[6]=d1c2) THEN
                  eco:='E3';
                ELSE
                  eco:='E2';
                END;
              END;
            ELSE
              nic:='QI';
              eco:='E2';
            END;
          ELSE                                            (* E0-E1                *)
            nic:='QI';
            IF m[4]=g1f3 THEN
              eco:='E1';
            ELSE
              eco:='E0';
            END;
          END;
        ELSIF m[3]=g7g6 THEN                              (*             Db    Eb *)
          nic:='KI';
          IF m[5]=d7d5 THEN                               (*  D7-D9      Db       *)
            IF m[4]=b1c3 THEN
              IF m[6]=g1f3 THEN
                eco:='D9';
              ELSE
                eco:='D8';
              END;
            ELSE
              eco:='D7';
            END;
          ELSE                                            (*  E6-E9            Eb *)
            IF (m[4]=b1c3) & (m[5]=f8g7)
            & (m[6]=e2e4) THEN                            (*  E7-E9               *)
              IF m[7]=d7d6 THEN
                IF m[8]=f2f3 THEN
                  eco:='E8';
                ELSIF m[8]=g1f3 THEN
                  eco:='E9';
                ELSE
                  eco:='E7';
                END;
              ELSE
                eco:='E7';
              END;
            ELSE
              eco:='E6';
            END;
          END;
        ELSE                                              (*       Ad (A5-A7)     *)    
          nic:='QO';
          IF (m[3]=c7c5) & (m[4]=d4d5) & (m[5]=e7e6) THEN (* A6, A7               *)
            IF (m[6]=b1c3) & (m[7]=e6d5) & (m[8]=c4d5)
            &  (m[9]=d7d6) & (m[10]=e2e4) & (m[11]=g7g6)
            &  (m[12]=g1f3) THEN                          (*     A7               *)
              eco:='A7';
            ELSE                                          (* A6                   *)
              eco:='A6';
            END;
          ELSE                                            (* A5                   *)
            eco:='A5';
          END;
        END;
      ELSE                                                (*    Ac-A4             *)
        eco:='A4';
        nic:='QP';
      END;
    ELSIF m[1]=f7f5 THEN                                  (* A8, A9               *)
      nic:='HD';
      IF (m[2]=c2c4) & (m[3]=g8f6)
      & (m[4]=g2g3) & (m[5]=e7e6) THEN                    (*     A9               *)
        eco:='A9';
      ELSE                                                (* A8                   *)
        eco:='A8';
      END;
    ELSE                                                  (* Ab-A4                *)
      eco:='A4';
      IF m[1]=c7c5 THEN
        nic:='BI';
      ELSIF m[1]=g7g6 THEN
        nic:='KF';
      ELSE
        IF (m[1]=e7e6) & (m[3]=f7f5) THEN
          nic:='HD';
        ELSE
          nic:='QP';
        END;
      END;
    END;
  ELSIF m[0]=e2e4 THEN                                    (* Ba Bb Ca Cb          *)
    IF m[1]=e7e6 THEN                                     (*       Ca             *)
      nic:='FR';
      IF (m[2]=d2d4) & (m[3]=d7d5) & (m[4]=b1c3) THEN
        eco:='C0';
      ELSE
        eco:='C1';
      END;
    ELSIF m[1]=e7e5 THEN                                  (*          Cb C3-C9    *)
      IF m[2]=f2f4 THEN
        nic:='KG';
        eco:='C3';
      ELSIF m[2]=g1f3 THEN
        IF m[3]=b8c6 THEN
          IF m[4]=f1b5 THEN (* C6-9 *)
            nic:='RL';
            IF (m[5]=a7a6) & (m[6]=b5a4) THEN (* C7-9 *)
              IF (m[7]=g8f6) & (m[8]=e1g1) THEN (* c8-9 *)
                IF (m[9]=f8e7) & (m[10]=f1e1) & (m[11]=b7b5)
                &  (m[12]=a4b3) & (m[13]=d7d6) THEN
                  eco:='C9'
                ELSE
                  eco:='C8';
                END;
              ELSE
                eco:='C7';
              END;
            ELSE
              eco:='C6';
            END;
          ELSIF m[4]=f1c4 THEN
            nic:='IG';
            eco:='C5';
          ELSE
            IF m[4]=d2d4 THEN
              nic:='SO';
            ELSE
              nic:='KP'
            END;
            eco:='C4';
          END;
        ELSE
          IF m[3]=g8f6 THEN
            nic:='RG';
          ELSE
            nic:='KP';
          END;
          eco:='C4'; 
        END;
      ELSE
        IF m[2]=d2d4 THEN
          nic:='SO';
        ELSIF m[2]=b1c3 THEN
          nic:='VG';
        ELSE
          nic:='KP';
        END;
        eco:='C2';
      END;
    ELSIF m[1]=c7c5 THEN                                  (*    Bb                *)
      nic:='SI';
      IF (m[2]=g1f3) & (m[3]=d7d6) THEN
        IF (m[4]=d2d4) & (m[5]=c5d4) & (m[6]=f3d4)
        &  (m[7]=g8f6) & (m[8]=b1c3) THEN                 (* B6-B9, B5            *)
          IF m[9]=b8c6 THEN                               (* B6, B5               *)
            IF m[10]=c1g5 THEN                            (* B6                   *)
              eco:='B6';
            ELSE                                          (* B5                   *)
              eco:='B5';
            END;
          ELSIF m[9]=g7g6 THEN                            (* B7                   *)
            eco:='B7';
          ELSIF m[9]=e7e6 THEN                            (* B8                   *)
            eco:='B8';
          ELSIF m[9]=a7a6 THEN                            (* B9                   *)      
            eco:='B9';
          ELSE                                            (* B5                   *)
            eco:='B5';
          END;
        ELSE                                              (* B5                   *)
          eco:='B5';
        END;
      ELSE                                                (* B2-B4                *)
        IF (m[2]=g1f3) & (m[3]=b8c6) THEN                 (* B3                   *)
          eco:='B3';
        ELSIF (m[2]=g1f3) & (m[3]=e7e6) THEN              (* B4                   *)
          eco:='B4';
        ELSE
          eco:='B2';
        END;
      END;
    ELSE                                                  (* Ba                   *)
      IF m[1]=c7c6 THEN                                   (* B1                   *)
        nic:='CK';
        eco:='B1';
      ELSE                                                (* B0                   *)
        IF m[1]=d7d5 THEN
          nic:='SD';
        ELSIF m[1]=d7d6 THEN
          nic:='PU';
        ELSIF m[1]=g7g6 THEN
          nic:='PU';
        ELSE
          IF m[1]=g8f6 THEN
            nic:='AL';
          ELSE
            nic:='KP';
          END;
        END;
        eco:='B0';
      END;
    END;
  ELSE                                                    (* Aa                   *)
    IF m[0]=c2c4 THEN                                     (* A1-A3                *)
      nic:='EO';
      IF m[1]=e7e5 THEN                                   (* A2                   *)
        eco:='A2';
      ELSIF m[1]=c7c5 THEN                                (* A3                   *)
        eco:='A3';
      ELSE                                                (* A1                   *)
        eco:='A1';
      END;
    ELSE                                                  (* A0                   *)
      eco:='A0';
      IF m[0]=g1f3 THEN
        nic:='RE';
      ELSE
        nic:='VO';
      END;
    END;
  END;
  Copy(ECO,eco);
  Copy(NIC,nic);
(*$ IF Test *)
  WRITELN(s('ECO="')+s(eco)+s('",  NIC="')+s(nic)+s('"'));
(*$ ENDIF *)
END GetOpeningKeys;

PROCEDURE OpenSetWin;
VAR
  G:GadgetPtr;
  PosY,X,Y,n:INTEGER;
  Txt:ADDRESS;
  GadFS:GFS;
BEGIN
  PosY:=PosYS;
  IF SetFirst THEN
    SetFirst:=FALSE;
    CREATEWIN(setWIN,FALSE,FALSE,FALSE,FALSE);
    X:= 254;
    Y:= 2;
    setWIN.Tekst:=ADR('');
    FOR n:=0 TO GdCnt-1 DO
      GadFS:=GFS{};
      CASE n OF
      | 0: Txt :=ADR(ttINTERNATIONAL);
           IF InterOn THEN GadFS:=GFS{selected} END;
      | 1: Txt :=ADR(ttLONGFORMWRITE);
           IF LongFormOn='L' THEN GadFS:=GFS{selected} END;
      | 2: Txt :=ADR(ttMOUTHOFF);
           IF MouthOff THEN GadFS:=GFS{selected} END;
      | 3: Txt :=ADR(ttLOTMEMON);
           IF LotMemOn THEN GadFS:=GFS{selected} END;
      | 4: Txt :=ADR(ttNOAUTOPGN);
           IF NoAutoPGN THEN GadFS:=GFS{selected} END;
      | 5: Txt :=ADR(ttQUICK);
           IF Quick THEN GadFS:=GFS{selected} END;
      | 6: Txt :=ADR(ttPGN);
           IF Lates3=1 THEN GadFS:=GFS{selected} END;
      END;
      AddGadget(setWIN.Gadgets, PosX, PosY+n*(SzY+3),  SzX+13*SzX, SzY, GadFS,AFS{relVerify,toggleSelect},
                NIL,NIL,NIL,NIL,100+n,NIL);
      AddIntuiText(setWIN.Gadgets, 2,1, DrawModeSet{dm0}, 2,1, Txt);
      AddBorder(setWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(setWIN.Gadgets));
    END;                             (*-2,-2 *)
  ELSE
    IF setWIN.Window<>NIL THEN
      CLOSEWIN(setWIN);
    END;
    X:=-1;
    Y:=-1;
  END;
  OPENWIN(setWIN,ADR(''), 132,PosYS+GdCnt*(SzX+3)+26, -1,-1, X,Y, -1,-1,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);
(*                txt       Min                        Max   Pos   Scr  Act   Mou   Cen   Key   Raw   SzGd *)
END OpenSetWin;

PROCEDURE OpenTeoWin;
VAR
  G:GadgetPtr;
  PosY,X,Y,n,m:INTEGER;
  Txt:ADDRESS;
  GadFS:GFS;
PROCEDURE A(X,Y,Value:INTEGER);
CONST
  XS=8;
  YS=8;
VAR
  x,y:INTEGER;
BEGIN
  x:=PosX+7*SzX+3*X*XS-18+2*X;
  y:=PosY+(n-1)*(SzY+3)+Y*YS-YS+Y-1;
  AddGadget(teoWIN.Gadgets, x, y, 3*XS, YS, GadFS,AFS{relVerify},
            NIL,NIL,NIL,NIL,130+Value,NIL);
  AddIntuiText(teoWIN.Gadgets, 2,1, DrawModeSet{dm0}, 0,0, VluToStr(Value));
(*
  AddBorder(teoWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(teoWIN.Gadgets));
*)
END A;
BEGIN
  PosY:=PosYS;
  IF TeoFirst THEN
    TeoFirst:=FALSE;
    CREATEWIN(teoWIN,FALSE,FALSE,FALSE,FALSE);
    X:= 254;
    Y:= 4;
    teoWIN.Tekst:=ADR('');
    GadFS:=GFS{};

    n:=1;
    AddGadget(teoWIN.Gadgets, PosX+2*SzX, PosY+n*(SzY+3),  SzX+2*SzX, SzY, GadFS,AFS{relVerify},
                NIL,NIL,NIL,NIL,108,NIL);
    AddStringInfo(teoWIN.Gadgets,3,"50");
    AddIntuiText(teoWIN.Gadgets, 1,0, DrawModeSet{dm0}, -12,0, ADR(Q[TeoW]^));
    AddIntuiText(teoWIN.Gadgets, 1,0, DrawModeSet{dm0}, -18,-10, ADR(Q[TeoDrawStat]^));
    AddBorder(teoWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(teoWIN.Gadgets));

    AddGadget(teoWIN.Gadgets, PosX+8*SzX, PosY+n*(SzY+3),  SzX+2*SzX, SzY, GadFS,AFS{relVerify},
                NIL,NIL,NIL,NIL,109,NIL);
    AddStringInfo(teoWIN.Gadgets,3,"50");
    AddIntuiText(teoWIN.Gadgets, 1,0, DrawModeSet{dm0}, -12,0, ADR(Q[TeoB]^));
    AddBorder(teoWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(teoWIN.Gadgets));

    AddGadget(teoWIN.Gadgets, PosX+17*SzX, PosY+n*(SzY+3),  SzX+3*SzX, SzY, GadFS,AFS{relVerify,toggleSelect},
                NIL,NIL,NIL,NIL,114,NIL);
    AddBorder(teoWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(teoWIN.Gadgets));

    n:=3;
    AddGadget(teoWIN.Gadgets, PosX, PosY+n*(SzY+3),  SzX+6*SzX, SzY, GadFS,AFS{relVerify},
                NIL,NIL,NIL,NIL,110,NIL);
    AddIntuiText(teoWIN.Gadgets, 1,0, DrawModeSet{dm0}, 40,-10, ADR(Q[TeoTeoF3]^));
    AddIntuiText(teoWIN.Gadgets, 2,1, DrawModeSet{dm0}, 2,1, ADR(Q[TeoLOAD]^));
    AddBorder(teoWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(teoWIN.Gadgets));

    AddGadget(teoWIN.Gadgets, PosX+8*SzX, PosY+n*(SzY+3),  SzX+6*SzX, SzY, GadFS,AFS{relVerify},
                NIL,NIL,NIL,NIL,111,NIL);
    AddIntuiText(teoWIN.Gadgets, 2,1, DrawModeSet{dm0}, 2,1, ADR(Q[TeoSAVE]^));
    AddBorder(teoWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(teoWIN.Gadgets));

    AddGadget(teoWIN.Gadgets, PosX+16*SzX, PosY+n*(SzY+3),  SzX+6*SzX, SzY, GadFS,AFS{relVerify},
                NIL,NIL,NIL,NIL,112,NIL);
    AddIntuiText(teoWIN.Gadgets, 2,1, DrawModeSet{dm0}, 2,1, ADR(Q[TeoNEW]^));
    AddBorder(teoWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(teoWIN.Gadgets));

    n:=5;
    AddGadget(teoWIN.Gadgets, PosX, PosY+n*(SzY+3),  SzX+6*SzX, SzY, GFS{gadgDisabled}, AFS{relVerify},
                NIL,NIL,NIL,NIL,113,NIL);
    AddIntuiText(teoWIN.Gadgets, 1,0, DrawModeSet{dm0}, -3,-10, ADR(Q[TeoPos]^));
    AddIntuiText(teoWIN.Gadgets, 2,1, DrawModeSet{dm0}, 2,1, ADR(Q[TeoDELETE]^));
    AddBorder(teoWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(teoWIN.Gadgets));


    A(1,1, 6);          A(3,1, 5);          A(5,1, 4);
    A(1,2,20);A(2,2,18);A(3,2,11);A(4,2,19);A(5,2,21);
    A(1,3,16);A(2,3,14);A(3,3,12);A(4,3,15);A(5,3,17);
              A(2,4, 9);A(3,4,10);A(4,4, 8);
                        A(3,5,13);

                                            A(5,7, 3);

    n:=8;
    AddGadget(teoWIN.Gadgets, PosX, PosY+n*(SzY+3),  SzX+8*SzX, SzY, GFS{gadgDisabled},AFS{relVerify},
                NIL,NIL,NIL,NIL,117,NIL);
    AddIntuiText(teoWIN.Gadgets, 1,0, DrawModeSet{dm0}, 50,-10, ADR(Q[TeoGame]^));
    AddIntuiText(teoWIN.Gadgets, 2,1, DrawModeSet{dm0}, 2,1, ADR(Q[TeoANALYZE]^));
    AddBorder(teoWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(teoWIN.Gadgets));
    AddGadget(teoWIN.Gadgets, PosX+10*SzX, PosY+n*(SzY+3),  SzX+5*SzX, SzY, GadFS,AFS{relVerify},
                NIL,NIL,NIL,NIL,118,NIL);
    AddIntuiText(teoWIN.Gadgets, 2,1, DrawModeSet{dm0}, 2,1, ADR(Q[TeoADD]^));
    AddBorder(teoWIN.Gadgets,FALSE,-2,-1,3,2,DrawModeSet{dm0},5,OutLine(teoWIN.Gadgets));
    FOR m:=1 TO 9 DO
      AddGadget(teoWIN.Gadgets, PosX, PosY+n*(SzY+3)+30+8*m,  188, 8, GadFS,AFS{relVerify},
                  NIL,NIL,NIL,NIL,119+m,NIL);
    END;

  ELSE
    IF teoWIN.Window<>NIL THEN
      CLOSEWIN(teoWIN);
    END;
    X:=-1;
    Y:=-1;
  END;
  OPENWIN(teoWIN,ADR(''), 208,PosYS+17*(SzX+3)+29, -1,-1, X,Y, -1,-1,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);
(*                txt       Min                        Max   Pos   Scr  Act   Mou   Cen   Key   Raw   SzGd *)
  IF ~L1b THEN WindowToBack(teoWIN.Window) END;
END OpenTeoWin;

PROCEDURE CalcMunde; (* and/or Dominans (only if ~MouthOff/DominansOn) *)
VAR
  X,Y,XY,n,m,nm,no,vs,vh,vt:INTEGER;
  st,mt                    :STILLINGTYPE;
  ch                       :CHAR;
BEGIN
(*$IF Test0 *)
  d(s('CalcMunde and/or Dominans (only if ~MouthOff/DominansOn)'));
(*$ENDIF *)
  IF ~MouthOff THEN
    FOR X:=11 TO 88 DO 
      Mund[X]:=' '; (* (sur) A,F,L,R,Z (Glad) *)
      mt[X]:=' ';
    END;
(*IF FALSE AND Debug THEN Vis('Mund før',Mund); END;*)
    IF SetUpMode<>1 THEN
      st:=stilling;
      GetV(stilling,Mund); (* for hvid *)
  
      vs:=stVsum;                 (* sum af sorte dækninger/træk *) 
  
      Mirror(st);
      GetV(st,mt); (* for sort *)
  
      vh:=stVsum;                 (* sum af hvide dækninger/træk *) 
  
      vt:=(vs-vh)/8;              (* totalværdi beregning for munde (0-8) *) 
      IF vt>4 THEN vt:=4; END;
      IF vt<-4 THEN vt:=-4; END;
      VlpU:=4+vt;
      VlmU:=4+vt;
      VlmO:=4-vt;
      VlpO:=4-vt;
  
      FOR n:=1 TO 4 DO (* Spejl *)
        nm:=10*n;
        no:=90-nm;
        FOR m:=1 TO 8 DO (* Byt 2 *)
          INC(nm);
          INC(no);
          ch:=mt[nm];
          mt[nm]:=mt[no];
          mt[no]:=ch;
        END;
      END;
      FOR Y:=1 TO 8 DO
        XY:=10*Y;
        FOR X:=1 TO 8 DO
          INC(XY);
          IF (stilling[XY]>' ') AND (stilling[XY]<'Z') THEN (* sorte *)
            Mund[XY]:=mt[XY];
          END;
        END;
      END;
    ELSE
      FOR X:=11 TO 88 DO
        Mund[X]:='R'; (* (sur) A,F,L,R,Z (Glad) *)
      END;
    END;
  END;

  FOR Y:=1 TO 8 DO
    XY:=10*Y;
    FOR X:=1 TO 8 DO
      INC(XY);
      Dominans[XY]:=' ';
(*    mt[XY]:=0C;*)
    END;
  END;   
  IF DominansOn THEN
    IF (SetUpMode<>1) THEN
      GetD(stilling,Dominans);

(* 1-97: Sort side Flyttet til GetD 
      IF MouthOff THEN
        st:=stilling;
        Mirror(st);
      END;
      GetD(st,mt);
      FOR n:=1 TO 4 DO 
        nm:=10*n;
        no:=90-nm;
        FOR m:=1 TO 8 DO
          INC(nm);
          INC(no);
          IF mt[no]<>0C THEN
            DEC(Dominans[nm],CARDINAL(mt[no]));
          END;
          IF mt[nm]<>0C THEN
            DEC(Dominans[no],CARDINAL(mt[nm]));
          END;
          IF Dominans[nm] > ' ' THEN 
            Dominans[nm]:='H';
          ELSIF Dominans[nm] < ' ' THEN 
            Dominans[nm]:='S';
          END;
          IF Dominans[no] > ' ' THEN
            Dominans[no]:='H';
          ELSIF Dominans[no] < ' ' THEN 
            Dominans[no]:='S';
          END;
        END;
      END;
*)
    END;
(*
  IF Debug THEN Vis('Domi total',Dominans); END;
*)
  END;
(* VlmO,U VlpO,U *)
END CalcMunde;(* and/or Dominans (only if ~MouthOff/DominansOn) *)

PROCEDURE MarkMoves(frafelt:INTEGER):INTEGER;
VAR
  st:STILLINGTYPE;
  fra,til,ret,cnt:INTEGER;
  mvt:MOVETYPE;
  Sort:BOOLEAN;
BEGIN
  (*$IF Test0 *)
    d(s('MarkMoves ')+l(frafelt));
  (*$ENDIF *)
  st:=stilling;
  cnt:=0;
  fra:=frafelt-1;
  til:=89;
  ret:=0;
  REPEAT
    GetNext(st,fra,til,ret,mvt);
    IF fra=frafelt THEN
      (* check om træk er underforvandling *)
      IF ((fra<71) OR (til>fra) OR (st[fra]<>'b')) 
      &  ((fra>28) OR (til<fra) OR (st[fra]<>'B')) THEN 
        INC(cnt);
        Select[til]:='S';
      END;
    END;
  UNTIL fra>frafelt;(* her findes et træk for næste brik (overflødigt?) *)
  RETURN(cnt);
END MarkMoves;

BEGIN
  (*LogVersion("SkakKey.def",SkakKeyDefCompilation);*)
  LogVersion("SkakKey.mod",SkakKeyModCompilation);
(*$IF Test *)
  WRITELN(s('SkakKey.1'));
(*$ENDIF *)
  SetFirst:=TRUE;
  TeoFirst:=TRUE;
(*$IF Test *)
  WRITELN(s('SkakKey.2'));
(*$ENDIF *)
CLOSE
(*$IF Test *)
  WRITELN(s('SkakKey.3'));
(*$ENDIF *)
  CLOSEWIN(setWIN);
  CLOSEWIN(teoWIN);
(*$IF Test *)
  WRITELN(s('SkakKey.4'));
(*$ENDIF *)
END SkakKey.

IMPLEMENTATION MODULE SkakBrainX; (* (c) E.B.Madsen, DK 1991      Rev 26/1-97.01 *)

(* 2-97 V and D versions moved from SkakBrain to new SkakBrainX  *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Chks:=FALSE  *)
(*$ DEFINE True:=TRUE   *) (* For at kunne enable/disable kommenterede procs *)
(*$ DEFINE False:=FALSE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=TRUE StackParms:=FALSE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=FALSE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=FALSE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT
  BYTE;

FROM RandomBetter IMPORT
  Randomize;

FROM SkakBase IMPORT
  HvisTur, MaxTeori, TraekNr, MaxTraek, STILLINGTYPE;

FROM SkakBrainEval IMPORT
 ValueT,ValueR,ValueM,ValueK,ValueD,ValueL,ValueS,ValueB,ValueE;

FROM SkakBrain IMPORT
  MOVETYPE,MOVETYPES,MOVEnormal,MOVEslag,stVsum,retn,Teo,TeoT,TRKDATA,still,
  TeoMax, DefStill, DoMove;

(*$ IF Test *)
FROM W IMPORT
   WRITE,WRITELN,CONCAT,c,s,l,lf,READs;
(*$ ENDIF *)

(*
GetNextTilV :
   næste trækmulighed med nuværende HVIDE brik, til=fra -> til=89 når ikke flere
GetNextTilD :
   finder næste dækning med nuværende HVIDE brik, til=fra -> til=89 når ikke flere
GetNextTilDB :
   finder næste dækning med nuværende SORTE brik, til=fra -> til=89 når ikke flere
GetNextD
   finder næste (hvide) dækning i stillingen, fra=89 når ikke flere
GetNextDB
   finder næste (sorte) dækning i stillingen, fra=89 når ikke flere
GetD
   finder Dominans (felter) for hvide brikker
GetV
   finder værdi (munde) for hvide brikker
InitTeo
  Intitierer mikro-teori, der laver 1'ste træk med random
Init
   calls InitTeo and initiates the retn array.

     PROCEDURE OVERSIGT : (i parantes hvis i SkakKey)

     (CalcMunde)__________GetV ______________________________ GetNextTilV
                \_________GetD _______________ GetNextD _____ GetNextTilD
                 \________(Mirror)

     Init_________________InitTeo

*)

CONST
  SkakBrainXModCompilation="27";
  MaxDistance  =  18; (* Hvilken plads i retn array som maxdistancen gemmes i *)
(*ValueT= 470;
  ValueR= 480;
  ValueM=9999;
  ValueK=9980;
  ValueD= 880;
  ValueL= 300;
  ValueS= 300;
  ValueB= 100;
  ValueE= 100;*)

PROCEDURE GetNextTilV(VAR stilling:STILLINGTYPE; VAR fra,til,retning:INTEGER;
                      VAR MoveTyp:MOVETYPE);
(*  GETV : næste træk med nuværende brik, til=fra -> til=89 når ikke flere *)
(*  GetNextTilV er for munde (hvide brikker) *)
VAR
  Done :BOOLEAN;
  Brik :CHAR;
  Max  :INTEGER;
BEGIN
  Brik:=stilling[fra];
  Max :=retn[Brik,MaxDistance];
  IF retning=0 THEN retning:=retn[Brik,retning] END;
  Done:=FALSE;
  REPEAT
    (* næste retning hvis :
       nået til kant, egen bonde, garderet bonde eller max *)
    IF (stilling[til+retning]='.') OR (stilling[til+retning]='b')
    OR (stilling[til+retning]='B') AND ((stilling[til+retning+9]='B')
    OR (stilling[til+retning+11]='B')) OR (fra<>til) AND (Max=1) THEN
      (* spring underforvandlinger over *)
      IF (Brik='b') & (retning=20) OR (Brik='B') & (retning=-20) THEN
        retning:=0;
      ELSE
        retning:=retn[Brik,retning];
      END; 
      til:=fra;
      IF retning=0 THEN
        Done:=TRUE;
        til:=89;
      END;
    ELSE
      til:=til+retning;
      IF stilling[til]<>' ' THEN
        MoveTyp:=MOVEslag
      ELSE
        MoveTyp:=MOVEnormal;
      END;
      IF stilling[fra]='b' THEN (* Bonde *)
        CASE retning OF
          | 10   : Done := (stilling[til]=' ');
          | 9,11 :
            IF stilling[til]<>' ' THEN
              Done:=TRUE;
              INCL(MoveTyp,slag);
            ELSE
              Done:=stilling[til-10]='E';
              INCL(MoveTyp,enpassant);
            END;
          | 20   : Done := (fra>=21) AND (fra<=28) AND (stilling[til-10]=' ')
                 AND (stilling[til]=' ');
        ELSE END;
      ELSE (* ikke-bonde *)
        IF ABS(retning)=2 THEN  (* er kun 2 ved rokade *)
          INCL(MoveTyp,rokade);
          IF retning=2 THEN  (* O-O *)
            Done:=(stilling[16]=' ') AND (stilling[17]=' ')
            AND (stilling[18]='r');
          ELSE        (* O-O-O *)
            Done:=(stilling[14]=' ') AND (stilling[13]=' ')
            AND (stilling[12]=' ') AND (stilling[11]='r');
          END;
        ELSE 
          Done:=TRUE;
        END;
      END;
    END;
  UNTIL Done;
END GetNextTilV;

PROCEDURE GetNextTilD(VAR stilling:STILLINGTYPE; VAR fra,til,retning:INTEGER);
(* finder næste træk med nuværende brik, til=fra -> til=89 når ikke flere *)
(* GetNextTilD er for Dominans (hvide) *)
VAR
  Done :BOOLEAN;
  Brik :CHAR;
  Max  :INTEGER;
BEGIN
  Brik:=stilling[fra];
  Max :=retn[Brik,MaxDistance];
  IF retning=0 THEN retning:=retn[Brik,retning] END;
  Done:=FALSE;
  REPEAT
    (* næste retning hvis :
       nået til kant, max nået eller sidste var ufri *)
    IF (stilling[til+retning]='.') OR (fra<>til)
    AND ( (Max=1) OR (stilling[til]<>' ') ) THEN
      (* spring underforvandlinger over (2 frem er sidste normale i tabel) *)
      IF (Brik='b') & (retning=20) THEN 
        retning:=0;
      ELSE
        retning:=retn[Brik,retning];
      END; 
      til:=fra;
      IF retning=0 THEN
        Done:=TRUE;
        til:=89;
      END;
    ELSE
      til:=til+retning;
      IF Brik='b' THEN
        IF (retning=9) OR (retning=11) THEN Done:=TRUE END;
      ELSE
        Done:=ABS(retning)<>2;  (* alt andet end rokade *)
      END;
    END;
  UNTIL Done;
(*  WRITE(s('GetNextTilD, fra=')+l(fra)+s(' til=')+l(til));*)
END GetNextTilD;

PROCEDURE GetNextTilDB(VAR stilling:STILLINGTYPE; VAR fra,til,retning:INTEGER);
(* finder næste træk med nuværende brik, til=fra -> til=89 når ikke flere *)
(* GetNextTilDB er for Dominans (sorte) *)
VAR
  Done :BOOLEAN;
  Brik :CHAR;
  Max  :INTEGER;
BEGIN
  Brik:=stilling[fra];
  Max :=retn[Brik,MaxDistance];
  IF retning=0 THEN retning:=retn[Brik,retning] END;
  Done:=FALSE;
  REPEAT
    (* næste retning hvis :
       nået til kant, max nået eller sidste var ufri *)
    IF (stilling[til+retning]='.') OR (fra<>til)
    AND ( (Max=1) OR (stilling[til]<>' ') ) THEN
      (* spring underforvandlinger over (2 frem er sidste normale i tabel) *)
      IF (Brik='B') & (retning=-20) THEN 
        retning:=0;
      ELSE
        retning:=retn[Brik,retning];
      END; 
      til:=fra;
      IF retning=0 THEN
        Done:=TRUE;
        til:=89;
      END;
    ELSE
      til:=til+retning;
      IF Brik='B' THEN
        IF (retning=-9) OR (retning=-11) THEN Done:=TRUE END;
      ELSE
        Done:=ABS(retning)<>2; (* alt andet end rokade *)
      END;
    END;
  UNTIL Done;
  (* WRITE(s('GetNextTilDB, fra=')+l(fra)+s(' til=')+l(til)+s(' Brik=')+c(Brik));*)
END GetNextTilDB;

PROCEDURE GetNextD(VAR stilling:STILLINGTYPE; VAR fra,til,retning:INTEGER);
(* finder næste (hvide) dækning i stillingen, fra=89 når ikke flere *)
(*  GetNextD er for Dominans *)
BEGIN
  REPEAT
    IF til>88 THEN
      REPEAT
        INC(fra);
      UNTIL (fra>88) OR (stilling[fra]>'a');
      til:=fra;
      retning:=0;
    END;
    IF fra<>89 THEN GetNextTilD(stilling,fra,til,retning) END;
  UNTIL (til<>89) OR (fra=89);
END GetNextD;

PROCEDURE GetNextDB(VAR stilling:STILLINGTYPE; VAR fra,til,retning:INTEGER);
(* finder næste (sorte) dækning i stillingen, fra=89 når ikke flere *)
(*  GetNextDB er for Dominans *)
BEGIN
  REPEAT
    IF til>88 THEN
      REPEAT
        INC(fra);
      UNTIL (fra>88) OR (stilling[fra]>'A') & (stilling[fra]<'a');
      til:=fra;
      retning:=0;
    END;
    IF fra<>89 THEN GetNextTilDB(stilling,fra,til,retning) END;
  UNTIL (til<>89) OR (fra=89);
END GetNextDB;

PROCEDURE GetD(VAR stilling,stV:STILLINGTYPE);
(* GetD finder Dominans for (hvide+sorte) *)
CONST
  stDcount  =0;
  stDpawns  =1;
  stDknights=2;
  stDbishops=2;
  stDrooks  =3;
  stDqueens =4;
  stDkings  =5;
TYPE
  FIGHTERS=ARRAY[stDcount..stDkings] OF INTEGER;
PROCEDURE Fight(Fown,Fopp:FIGHTERS; Pool:INTEGER):INTEGER;
VAR
  p,sum,risk:INTEGER;
BEGIN
  p:=stDpawns;
  WHILE Fown[p]=0 DO INC(p) END;
  DEC(Fown[p]);
  DEC(Fown[stDcount]);
  CASE p OF
  | stDpawns   : risk:= ValueB;     (* !!!!! CONST:ARRAY optimere *)
  | stDknights : risk:= ValueS;
  | stDrooks   : risk:= ValueT;
  | stDqueens  : risk:= ValueD;
  | stDkings   : risk:= ValueK;
  END;
  IF Fopp[stDcount]=0 THEN
    sum:=Pool;
  ELSE
    sum:=Pool-Fight(Fopp,Fown,risk);
  END;
  IF sum<0 THEN RETURN(0) ELSE RETURN(sum) END;
END Fight;
VAR
  n,m,fra,til,retning           : INTEGER;
  nm,no,risk,total              : INTEGER;
  MoveTyp                       : MOVETYPE;
  Brik                          : CHAR;
  stDwhite,stDblack             : ARRAY[11..88] OF FIGHTERS;
BEGIN
  (*$IF False *)
    d(s('GetD'));
  (*$ENDIF *)

  FOR fra:=11 TO 88 DO
    FOR n:=stDcount TO stDkings DO
      stDwhite[fra,n]:=0;
      stDblack[fra,n]:=0;
    END;
  END;

  retning:=0;
  fra:=10;
  til:=89;
  REPEAT
    GetNextD(stilling,fra,til,retning); (**** !! GetNextD !! *****)
    IF fra<89 THEN
      INC(stV[til]);
      INC(stDwhite[til,stDcount]);
      CASE stilling[fra] OF
      | 'b','e' : INC(stDwhite[til,stDpawns]);
      | 's','l' : INC(stDwhite[til,stDbishops]);
      | 't','r' : INC(stDwhite[til,stDrooks]);
      | 'd'     : INC(stDwhite[til,stDqueens]);
      | 'k','m' : INC(stDwhite[til,stDkings]);
      ELSE END;
    END;
  UNTIL fra>88;

  retning:=0;
  fra:=10;
  til:=89;
  REPEAT
    GetNextDB(stilling,fra,til,retning); (**** !! GetNextDB !! *****)
    IF fra<89 THEN
      DEC(stV[til]);
      INC(stDblack[til,stDcount]);
      CASE stilling[fra] OF
      | 'B','E' : DEC(stDblack[til,stDpawns]);
      | 'S','L' : DEC(stDblack[til,stDbishops]);
      | 'T','R' : DEC(stDblack[til,stDrooks]);
      | 'D'     : DEC(stDblack[til,stDqueens]);
      | 'K','M' : DEC(stDblack[til,stDkings]);
      ELSE END;
    END;
  UNTIL fra>88;

(* Gl. OK metode:
  FOR fra:=11 TO 88 DO
    n:=stDwhite[fra,stDcount]-stDblack[fra,stDcount];
    IF n<0 THEN
      stV[fra]:='S'
    ELSIF n>0 THEN
      stV[fra]:='H'
    ELSE
      stV[fra]:=' ';
    END;
  END;
*)

(* ny metode: *)
  total:=0;
  IF stilling[HvisTur]='H' THEN
    FOR fra:=11 TO 88 DO
      n:=0;
      Brik:=stilling[fra];
      IF Brik=' ' THEN    (* empty field, give symbolic bonus *)
        IF stDwhite[fra,stDcount]>0 THEN
          n:=Fight(stDwhite[fra],stDblack[fra],1);
          IF (n=0) & (stDblack[fra,stDcount]>0) THEN
            n:=-Fight(stDblack[fra],stDwhite[fra],1);
          END;
        ELSE
          IF stDblack[fra,stDcount]>0 THEN
            n:=-1
          ELSE
            n:= 0;
          END;
        END;
      ELSIF Brik>'a' THEN (* white *)
        CASE Brik OF
        | 'b','e' : risk:=ValueB;
        | 'l','s' : risk:=ValueS;
        | 't','r' : risk:=ValueT;
        | 'd'     : risk:=ValueD;
        | 'k','m' : risk:=ValueK;
  (*$IF False *)
        ELSE
          WRITELN(s('CASE1: ')+c(Brik));
  (*$ENDIF *)
        END;
        IF (stDblack[fra,stDcount]>0) THEN
          n:=-Fight(stDblack[fra],stDwhite[fra],risk);
          IF (n=0) & (stDwhite[fra,stDcount]>0) THEN
            n:=Fight(stDwhite[fra],stDblack[fra],1);
          END;
        ELSE
          IF (stDwhite[fra,stDcount]>0) THEN
            n:=1;
          ELSE
            n:=0;
          END;
        END;
      ELSIF Brik<>'.' THEN
        CASE Brik OF
        | 'B','E' : risk:=ValueB;
        | 'L','S' : risk:=ValueS;
        | 'T','R' : risk:=ValueT;
        | 'D'     : risk:=ValueD;
        | 'K','M' : risk:=ValueK;
  (*$IF False *)
        ELSE
          WRITELN(s('CASE2: ')+c(Brik));
  (*$ENDIF *)
        END;
        IF (stDwhite[fra,stDcount]>0) THEN
          n:=Fight(stDwhite[fra],stDblack[fra],risk);
          IF (n=0) & (stDblack[fra,stDcount]>0) THEN
            n:=-Fight(stDblack[fra],stDwhite[fra],1);
          END;
        ELSE
          IF (stDblack[fra,stDcount]>0) THEN
            n:=-1;
          ELSE
            n:=0;
          END;
        END;
      END;
      total:=total+n;
      IF n<0 THEN
        stV[fra]:='S'
      ELSIF n>0 THEN
        stV[fra]:='H'
      ELSE
        stV[fra]:=' ';
      END;
  (*$IF False *)
      IF fra MOD 10>8 THEN
        WRITELN(0)
      ELSIF fra MOD 10>0 THEN
        WRITE(lf(n,5))
      END;
  (*$ENDIF *)
    END;
  ELSE
    FOR fra:=11 TO 88 DO
      n:=0;
      Brik:=stilling[fra];
      IF Brik=' ' THEN    (* empty field, give symbolic bonus *)
        IF stDblack[fra,stDcount]>0 THEN
          n:=Fight(stDblack[fra],stDwhite[fra],1);
          IF (n=0) & (stDwhite[fra,stDcount]>0) THEN
            n:=-Fight(stDwhite[fra],stDblack[fra],1);
          END;
        ELSE
          IF stDwhite[fra,stDcount]>0 THEN
            n:=-1
          ELSE
            n:= 0;
          END;
        END;
      ELSIF Brik<'a' THEN (* black *)
        IF Brik<>'.' THEN
          CASE Brik OF
          | 'B','E' : risk:=ValueB;
          | 'L','S' : risk:=ValueS;
          | 'T','R' : risk:=ValueT;
          | 'D'     : risk:=ValueD;
          | 'K','M' : risk:=ValueK;
  (*$IF False *)
          ELSE
            WRITELN(s('CASE3: ')+c(Brik));
  (*$ENDIF *)
          END;
          IF (stDwhite[fra,stDcount]>0) THEN
            n:=-Fight(stDwhite[fra],stDblack[fra],risk);
            IF (n=0) & (stDblack[fra,stDcount]>0) THEN
              n:=Fight(stDblack[fra],stDwhite[fra],1);
            END;
          ELSE
            IF (stDblack[fra,stDcount]>0) THEN
              n:=1;
            ELSE
              n:=0;
            END;
          END;
        END;
      ELSE
        CASE Brik OF
        | 'b','e' : risk:=ValueB;
        | 'l','s' : risk:=ValueS;
        | 't','r' : risk:=ValueT;
        | 'd'     : risk:=ValueD;
        | 'k','m' : risk:=ValueK;
  (*$IF False *)
        ELSE
          WRITELN(s('CASE4: ')+c(Brik));
  (*$ENDIF *)
        END;
        IF (stDblack[fra,stDcount]>0) THEN
          n:=Fight(stDblack[fra],stDwhite[fra],risk);
          IF (n=0) & (stDwhite[fra,stDcount]>0) THEN
            n:=-Fight(stDwhite[fra],stDblack[fra],1);
          END;
        ELSE
          IF (stDwhite[fra,stDcount]>0) THEN
            n:=-1;
          ELSE
            n:=0;
          END;
        END;
      END;
      total:=total+n;
      IF n<0 THEN
        stV[fra]:='H'
      ELSIF n>0 THEN
        stV[fra]:='S'
      ELSE
        stV[fra]:=' ';
      END;
  (*$IF False *)
      IF fra MOD 10>8 THEN
        WRITELN(0)
      ELSIF fra MOD 10>0 THEN
        WRITE(lf(n,5))
      END;
  (*$ENDIF *)
    END;
  END;
  (*$IF False *)
  WRITELN(0);
  WRITELN(s('total=')+l(total));
  (*$ENDIF *)
END GetD;

PROCEDURE GetV(VAR stilling,stV:STILLINGTYPE);
(* finder værdi for (hvide) brikker *)
(*  GetV er for munde *)
VAR
  n,r,fra,til,retning : INTEGER;
  MoveTyp             : MOVETYPE;
  first               : BOOLEAN;
BEGIN
  (*$IF False *)
   d(s('GetV'));
  (*$ENDIF *)
  retning:=0;
  stVsum:=0;
  fra:=10;
  til:=89;
  FOR n:=11 TO 88 DO
    IF stilling[n]>'a' THEN stV[n]:='0' END;
  END;
  REPEAT
    REPEAT
      REPEAT
        IF til>88 THEN
          REPEAT
            INC(fra);
          UNTIL (fra>88) OR (stilling[fra]>'a');
          til:=fra;
          retning:=0;
          first:=TRUE;
        END;
        IF fra<>89 THEN GetNextTilV(stilling,fra,til,retning,MoveTyp) END;
      UNTIL (til<>89) OR (fra=89);
    UNTIL TRUE OR (fra=89); (* TRUE??????????????????????????? *)
    IF fra<89 THEN
      INC(stV[fra]);
      INC(stVsum);
      IF first THEN
        first:=FALSE;
        IF (stilling[fra]='k') OR (stilling[fra]='m') THEN
          (* så beregn konges beskyttelse *)
          r:=0;
          REPEAT
            r:=retn['k',r];
            IF (stilling[fra+r]<>' ') THEN INC(stV[fra],2); END;
          UNTIL r=0;
        END;
        IF (stilling[fra]='b') OR (stilling[fra]='e') THEN
          (* så beregn bondes placering *)
          FOR n:=3 TO fra DIV 10 DO INC(stV[fra]); END;
        END;
      END;
    END;
  UNTIL fra=89;
(*IF Debug THEN Vis('(stilling) før juster',stilling); END;*)
  FOR n:=11 TO 88 DO
    CASE stilling[n] OF
      | 'l','r','t' : stV[n]:=CHAR(65+ (9*(CARDINAL(stV[n])-48)) DIV 5);
      | 'd'         : stV[n]:=CHAR(65+    (CARDINAL(stV[n])-48));
      | 's'         : stV[n]:=CHAR(65+  3*(CARDINAL(stV[n])-48));
      | 'b','e'     : stV[n]:=CHAR(65+  3*(CARDINAL(stV[n])-48));
      | 'k','m'     : stV[n]:=CHAR(65+  3*((CARDINAL(stV[n])-48)-10));
      | ' '         : stV[n]:=' ';
    ELSE END;
  END;
END GetV;

(* copy of SkakBrain.def : 
  TeoMax       =   5;                           max antal kendte stillinger
  TeoMaxTrk    =   5;                           max variantlængde
  Teo:ARRAY[0..TeoMax] OF STILLINGTYPE;
  TeoT:ARRAY[0..TeoMax],[1..4] OF TRKDATA;
*)
PROCEDURE InitTeo;
CONST
  b1=12; c1=13; d1=14; e1=15; f1=16; g1=17;
  b2=22; c2=23; d2=24; e2=25; f2=26; g2=27;
  b3=32; c3=33; d3=34; e3=35; f3=36; g3=37;     
  b4=42; c4=43; d4=44; e4=45; f4=46; g4=47;     
  b5=52; c5=53; d5=54; e5=55; f5=56; g5=57;     
  b6=62; c6=63; d6=64; e6=65; f6=66; g6=67;
  b7=72; c7=73; d7=74; e7=75; f7=76; g7=77;     
  b8=82; c8=83; d8=84; e8=85; f8=86; g8=87;
VAR
  mvtN,mvtS,mvtE,mvtR:MOVETYPE; (* normal, slag, enpassant, rokade *)
  X,Y:INTEGER;
PROCEDURE TeoS(StilNr,TrkNr,fra,til:INTEGER;mvt:MOVETYPE;vlu:INTEGER);
VAR
  Trk:TRKDATA;
BEGIN
  TeoT[StilNr,TrkNr].Fra:=fra; (* TeoT=0..TeoMax (5), 1..4 *)
  TeoT[StilNr,TrkNr].Til:=til;
  TeoT[StilNr,TrkNr].Typ:=mvt;
  TeoT[StilNr,TrkNr].Vlu:=vlu;
END TeoS;
BEGIN
  (* Opret mikro teoribog (p.t. kun for laveste niveau og første træk) *)
  still(DefStill,'');
  Randomize;
  mvtN:=MOVEnormal;
  mvtS:=MOVEslag;
  mvtE:=MOVETYPE{enpassant}; (* vigtig *)
  mvtR:=MOVETYPE{rokade};    (* vigtig *)
  FOR X:=0 TO TeoMax DO
    Teo[X]:=DefStill;
    FOR Y:=1 TO 4 DO
      TeoT[X,Y].Fra:=11;
      TeoT[X,Y].Til:=11;
      TeoT[X,Y].Typ:=mvtN;
      TeoT[X,Y].Vlu:=0;
    END;
  END;
  TeoS(0,1,d2,d4,mvtN,0); (* udgangsstilling: d4,e4,c4,b3 *)
  TeoS(0,2,e2,e4,mvtN,0);
  TeoS(0,3,c2,c4,mvtN,0);
  TeoS(0,4,b2,b3,mvtN,0);
  DoMove(Teo[1], 24, 44, mvtN); (* d4: d5,g6,b6,sf6 *)
  TeoS(1,1,d7,d5,mvtN,0);
  TeoS(1,2,g7,g6,mvtN,0);
  TeoS(1,3,b7,b6,mvtN,0);
  TeoS(1,4,g8,f6,mvtN,0);
  DoMove(Teo[2], 25, 45, mvtN); (* e4: e5,e6,c5,c6 *)
  TeoS(2,1,e7,e5,mvtN,0);
  TeoS(2,2,e7,e6,mvtN,0);
  TeoS(2,3,c7,c5,mvtN,0);
  TeoS(2,4,c7,c6,mvtN,0);
  DoMove(Teo[3], 23, 43, mvtN); (* c4: g6,f5,c5,e5 *)
  TeoS(3,1,g7,g6,mvtN,0);
  TeoS(3,2,f7,f5,mvtN,0);
  TeoS(3,3,c7,c5,mvtN,0);
  TeoS(3,4,e7,e5,mvtN,0);
  DoMove(Teo[4], 26, 46, mvtN); (* f4: d5,f5,b6,c5 *)
  TeoS(4,1,d7,d5,mvtN,0);
  TeoS(4,2,f7,f5,mvtN,0);
  TeoS(4,3,b7,b6,mvtN,0);
  TeoS(4,4,c7,c5,mvtN,0);
  MaxTeori:=0;
END InitTeo;

PROCEDURE Init;
VAR
  n,m:INTEGER;
  ch:CHAR;
BEGIN
  InitTeo;
  (* sort=upcase *)
  (* Tårn,Rokadetårn,Springer,Løber,Dronning,Majestæt,Konge,Bonde,Enpassantbonde *)

  (* lav træktabel *)
  retn['t',MaxDistance]:=8;
  retn['t',  0]:=-10;
  retn['t',-10]:= -1;
  retn['t', -1]:=  1;
  retn['t',  1]:= 10;
  retn['t', 10]:=  0;

  retn['T']:=retn['t'];

  retn['r',MaxDistance]:=8;
  retn['r',  0]:= 10;
  retn['r', 10]:= -1;
  retn['r', -1]:=  1;
  retn['r',  1]:=  0;

  retn['R',MaxDistance]:=8;
  retn['R',  0]:=-10;
  retn['R',-10]:= -1;
  retn['R', -1]:=  1;
  retn['R',  1]:=  0;

  retn['s',MaxDistance]:=1;
  retn['s',  0]:=-21;
  retn['s',-21]:=-19;
  retn['s',-19]:=-12;
  retn['s',-12]:= -8;
  retn['s', -8]:=  8;
  retn['s',  8]:= 12;
  retn['s', 12]:= 19;
  retn['s', 19]:= 21;
  retn['s', 21]:=  0;
  retn['S']:=retn['s'];

  retn['l',MaxDistance]:=8;
  retn['l',  0]:=-11;
  retn['l',-11]:= -9;
  retn['l', -9]:=  9;
  retn['l',  9]:= 11;
  retn['l', 11]:=  0;
  retn['L']:=retn['l'];

  retn['d',MaxDistance]:=8;
  retn['d',  0]:=-11;
  retn['d',-11]:=-10;
  retn['d',-10]:= -9;
  retn['d', -9]:= -1;
  retn['d', -1]:=  1;
  retn['d',  1]:=  9;
  retn['d',  9]:= 10;
  retn['d', 10]:= 11;
  retn['d', 11]:=  0;
  retn['D']:=retn['d'];

  retn['m',MaxDistance]:=1;
  retn['m',  0]:= -2;
  retn['m', -2]:= -1;
  retn['m', -1]:=  1;
  retn['m',  1]:=  2;
  retn['m',  2]:=  9;
  retn['m',  9]:= 10;
  retn['m', 10]:= 11;
  retn['m', 11]:=  0;
  retn['M',MaxDistance]:=1;
  retn['M',  0]:= -2;
  retn['M', -2]:= -1;
  retn['M', -1]:=  1;
  retn['M',  1]:=  2;
  retn['M',  2]:=-11;
  retn['M',-11]:=-10;
  retn['M',-10]:= -9;
  retn['M', -9]:=  0;

  retn['k',MaxDistance]:=1;
  retn['k',  0]:=-11;
  retn['k',-11]:=-10;
  retn['k',-10]:= -9;
  retn['k', -9]:= -1;
  retn['k', -1]:=  1;
  retn['k',  1]:=  9;
  retn['k',  9]:= 10;
  retn['k', 10]:= 11;
  retn['k', 11]:=  0;
  retn['K']:=retn['k'];

  retn['b',MaxDistance]:=1;
  retn['b',  0]:=  9;
  retn['b',  9]:= 10;
  retn['b', 10]:= 11;
  retn['b', 11]:= 20;
  retn['b', 20]:=-11;
  retn['b',-11]:=-10;(* -11..-9 Underforvandling til Tårn (til-20) *)
  retn['b',-10]:= -9;
  retn['b', -9]:=-21;
  retn['b',-21]:=-20;(* -21..-6 Underforvandling til Springer (til-30) *)
  retn['b',-20]:=-19;
  retn['b',-19]:=-31;
  retn['b',-31]:=-30;(* -7..-9 Underforvandling til Løber (til-40) *)
  retn['b',-30]:=-29;
  retn['b',-29]:=  0;
  retn['e']:=retn['b'];
  retn['e',11] :=  0;
  retn['B',MaxDistance]:=1;
  retn['B',  0]:= -9;
  retn['B', -9]:=-10;
  retn['B',-10]:=-11;
  retn['B',-11]:=-20;
  retn['B',-20]:= 11;
  retn['B', 11]:= 10;(*  11..9 Underforvandling til Tårn (til+20) *)
  retn['B', 10]:=  9;
  retn['B',  9]:= 21;
  retn['B', 21]:= 20;(* 21..19 Underforvandling til Springer (til+30) *)
  retn['B', 20]:= 19;
  retn['B', 19]:= 31;
  retn['B', 31]:= 30;(* 31..29 Underforvandling til Løber (til+40) *)
  retn['B', 30]:= 29;
  retn['B', 29]:=  0;
  retn['E']:=retn['B'];
  retn['E',-11]:=  0;
END Init;

BEGIN
  Init;
END SkakBrainX.

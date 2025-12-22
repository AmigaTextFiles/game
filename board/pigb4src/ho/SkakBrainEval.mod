IMPLEMENTATION MODULE SkakBrainEval; (* (c) E.B.Madsen, DK 1991      Rev 26/1-97.01 *)

(*$ DEFINE Test:=FALSE  *)
(*$ DEFINE Test0:=FALSE *)
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
  ADR;
FROM Arts IMPORT
  Assert;
FROM Heap IMPORT
  Allocate, Deallocate, Largest, Available;
FROM VersionLog IMPORT
  LogVersion;
FROM SkakBase IMPORT
  STILLINGTYPE,HvisTur;
FROM FileSystem IMPORT
  WriteChar;

(*$ IF Test *)
FROM W IMPORT
   WRITE,WRITELN,CONCAT,c,s,l,lf,b,READs,Buf;
(*$ ENDIF *)

CONST
  SkakBrainEvalModCompilation="286";

VAR
  ClosedD4,ClosedE4,ClosedD5,ClosedD3,ClosedE5,ClosedE3,
  LatePart:BOOLEAN; (* LatePart of OpenGame or EndGame *)
  FirstW  : BOOLEAN;

PROCEDURE WRITEF(n:CARDINAL);
VAR
  m:INTEGER;
BEGIN
(*$ IF Test *)
  IF ToFile THEN
    n:=0;
    IF FirstW THEN
      FOR m:=1 TO Depth DO
        WriteChar(TestFil,'.');
        WriteChar(TestFil,' ');
      END;
      FirstW:=FALSE;
    END;
    WHILE Buf[n]<>0C DO
      WriteChar(TestFil,Buf[n]);
      INC(n);
    END;
    Buf[0]:=0C;
  ELSE
    WRITE(n);
  END;
(*$ ENDIF *)
END WRITEF;

PROCEDURE WRITELNF(n:CARDINAL);
BEGIN
(*$ IF Test *)
  IF ToFile THEN 
    WRITEF(n);
    WriteChar(TestFil,12C);
    Buf[0]:=0C;
    FirstW:=TRUE;
  ELSE
    WRITELN(n);
  END;
(*$ ENDIF *)
END WRITELNF;

PROCEDURE Vis(txt:ARRAY OF CHAR; VAR st:STILLINGTYPE);
VAR
  X,Y:INTEGER;
BEGIN
(*$ IF Test *)
  WRITELNF(s('Vis ')+s(txt));
  FOR Y:=8 TO 1 BY -1 DO
    FOR X:=1 TO 8 DO
      CONCAT(c(st[X+10*Y]));
    END;
    WRITELNF(0);
  END;
(*$ ENDIF *)
END Vis;

(*$ IF Test *)
PROCEDURE tst(str:ARRAY OF CHAR; VAR stilling:STILLINGTYPE);
VAR
  n,m,f:INTEGER;
  Show:BOOLEAN;
  brik:CHAR;
BEGIN
  Show:=TRUE;
  FOR n:=1 TO 8 DO
    FOR m:=1 TO 8 DO 
      f:=(9-n)*10+m;
      IF (stilling[f]>'A') & (pdw^[stilling[f],f]>100) THEN
        Show:=TRUE; m:=8; n:=8;
      END;
    END;
  END;
  IF Show THEN
    WRITELNF(s(str));
    FOR n:=1 TO 8 DO
      FOR m:=1 TO 8 DO 
        f:=(9-n)*10+m;
        brik:=stilling[f];
        IF (brik>'A')
        OR (stilling[f+1]='K')
        OR (stilling[f-1]='K')
        OR (stilling[f+10]='K')
        OR (stilling[f-10]='K')
        OR (stilling[f+11]='K')
        OR (stilling[f-11]='K')
        OR (stilling[f+9]='K')
        OR (stilling[f-9]='K') THEN
          IF brik=' ' THEN brik:='K' END;
          WRITEF(lf(pdw^[brik,f],5)+c(stilling[f+m]));
        ELSE
          WRITEF(s('      '));
        END;
      END;
      WRITELNF(0);
    END;
  END;
END tst;

PROCEDURE tst2(str:ARRAY OF CHAR; VAR stilling:STILLINGTYPE; brik:CHAR);
VAR
  n,m,f:INTEGER;
  Show:BOOLEAN;
BEGIN
  IF Evals=0 THEN
    WRITELNF(s(str)+s(' pdw^[')+c(brik)+c(']'));
    FOR n:=1 TO 8 DO
      FOR m:=1 TO 8 DO 
        f:=(9-n)*10+m;
        WRITEF(lf(pdw^[brik,f],5)+c(stilling[f]));
      END;
      WRITELNF(0);
    END;
    IF brik>'a' THEN brik:=CAP(brik) ELSE brik:=CHR(ORD(brik)+32) END;
    WRITELNF(s('pdb^[')+c(brik)+c(']'));
    FOR n:=1 TO 8 DO
      FOR m:=1 TO 8 DO 
        f:=(9-n)*10+m;
        WRITEF(lf(pdb^[brik,f],5)+c(stilling[n*10+m]));
      END;
      WRITELNF(0);
    END;
  END;
END tst2;

VAR
  stTst:STILLINGTYPE;
(*$ ENDIF *)

CONST
  (* PreProcess (defaults): *)
  RokeretBonus          = 20; (* bonus for safe king *)
  pd1080                = -9; (* *)
  pd2070                = -2; (* *)
  pd3060                =  3; (* *)
  pd4050                =  8; (* *)
  pd1080qb              =  3; (* for queen and bishops *)
  pd3060qb              = -2;
  pd3060qe              =  8; (* for queen in endgame *)
  pd1080k               =  8; (* for king *)
  pd2070k               = -5;
  pd3060k               =-20;
  pd7R                  = 20; (* rook on 7'th rank *) 
  pd8R                  =  5;
  pd6Q                  =  5;
  pd7Q                  = 12;
  pd8Q                  =  5;
  pdkc12                =  9; (* penalty for king in centre *)
  (*pdkc9                 =  7; *) (* penalty for king in centre *)
  pdPcf                 =  9; (* Pawn center (c+f) bonus  *)
  pdPde                 = 17; (* Pawn center (d+e) bonus  *)
  pdP                   =  8; (* pawn rank bonus :  6  7  8  9 start for below:   *)
  pdPend                = 11; (* pawn -"- endgame : 1, 3, 5, 7, 9, 11, 13, 15, 17 *)
  PenalUndev            = 12; (* Penalty for undelevoped pieces *)

  (* PreProcessor (adjustments according to position): *)
  BishopPenalty         =  3; (* behind own pawns penalty *)
  OpenGameValue         =  6; (* if FirstLineCount > 7*)
  EndGameValue          = 10; (* if q*4+Q*4+r*2+R*2+n+N+b+B < *)
  pdB5                  =  6; (* Bishop b5,g5 bonus/penalty *)
  KingArea30            = 30;
  KingArea20            = 20;
  KingArea16            = 16;
  KingArea12            = 12;
  KingArea8             =  8;
  AroundKingBonus       =  5; (* by KingAdj: *1 *2 or *3 *)
  PawnStrateg20         = 15; (* strategical pawn moves when closed center *)
  PawnStrateg10         =  8;
  BishopClosed          = 15; (* penalty *)
  BishopOpen            =  7;
  KnightClosed          =  7;
  RookFullOpenLine      = 12;
  RookHalfOpenLine      =  8;
  EarlyKnight           = 12; (* penalty *)
  LateBishop            =  3; (* penalty *)
  pawnh3a3attack        =  5;
  AvoidCastling         =  6; (* penalty *)
  CastleBonus           = 28;

  (* Eval: *)
  InMoveBonus           = 10;

VAR
  kOut,KOut :BOOLEAN;

PROCEDURE PreProcess;
VAR
  n,m,t,v,f:INTEGER;
  ch:CHAR;
BEGIN
(*$ IF Test *)
  WRITELNF(s('PREPROCESS'));
(*$ ENDIF *)
  FOR ch:='B' TO 'T' DO        (* positionel data, centrum bedst *)
    CASE ch OF
    | 'B','E','T','R','S' :
      FOR n:=10 TO 80 BY 10 DO FOR m:=1 TO 8 DO pdw^[ch,n+m]:=pd1080 END END;
      FOR n:=20 TO 70 BY 10 DO FOR m:=2 TO 7 DO pdw^[ch,n+m]:=pd2070 END END;
      FOR n:=30 TO 60 BY 10 DO FOR m:=3 TO 6 DO pdw^[ch,n+m]:=pd3060 END END;
      FOR n:=40 TO 50 BY 10 DO FOR m:=4 TO 5 DO pdw^[ch,n+m]:=pd4050 END END;
    | 'K','M' :
      FOR n:=10 TO 80 BY 10 DO FOR m:=1 TO 8 DO pdw^[ch,n+m]:=pd1080k END END;
      FOR n:=20 TO 70 BY 10 DO FOR m:=2 TO 7 DO pdw^[ch,n+m]:=pd2070k END END;
      FOR n:=30 TO 60 BY 10 DO FOR m:=3 TO 6 DO pdw^[ch,n+m]:=pd3060k END END;
    | 'L','D' :  (* løber,D ikke specielt i centrum, men fianciettering *)
      IF EndGame & (ch='D') THEN t:=pd3060qe ELSE t:=pd3060qb END;
      FOR n:=10 TO 80 BY 10 DO FOR m:=1 TO 8 DO pdw^[ch,n+m]:=pd1080qb END;END;
      FOR n:=30 TO 60 BY 10 DO FOR m:=4 TO 5 DO pdw^[ch,n+m]:=t END;END;
    ELSE END;
  END;

(*$ IF Test0 *)
  tst2('After INIT:',stTst,'K');
  tst2('After INIT:',stTst,'B');
  tst2('After INIT:',stTst,'k');
  tst2('After INIT:',stTst,'b');
(*$ ENDIF *)

  IF OpenGame THEN
    (* bonus to move pawns into the center *)
    INC(pdw^['B',56],pdPcf);
    INC(pdw^['B',55],pdPde);
    INC(pdw^['B',54],pdPde);
    INC(pdw^['B',53],pdPcf);
    INC(pdw^['E',54],pdPde);
    INC(pdw^['E',55],pdPde);
    INC(pdw^['E',53],pdPcf);
    INC(pdw^['E',56],pdPcf);
    (* penalty to undeveloped pieces *)
    DEC(pdw^['S',82],PenalUndev);
    DEC(pdw^['L',83],PenalUndev);
    DEC(pdw^['D',84],PenalUndev);
    DEC(pdw^['L',86],PenalUndev);
    DEC(pdw^['S',87],PenalUndev);
    DEC(pdw^['B',74],PenalUndev);
    DEC(pdw^['B',75],PenalUndev);
  ELSE

    (* tårne + Dronning på 7+8 række bonus *)
    FOR n:=1 TO 8 DO
      pdw^['T',20+n]:= pd7R;
      pdw^['T',10+n]:= pd8R;
      pdw^['D',30+n]:= pd6Q;
      pdw^['D',20+n]:= pd7Q;
      pdw^['D',10+n]:= pd8Q;
    END;

    (* bønder mere værd jo tættere de er på forvandling 7, 9 *)
    IF EndGame THEN t:=pdPend ELSE t:=pdP END;
    FOR n:=2 TO 7 DO
      v:=(t-n)*(t-n);
      FOR m:=1 TO 8 DO
        f:=10*n+m;
        INC(pdw^['B',f],v);
        INC(pdw^['E',f],v);
      END;
    END;

  END;

  (* Knights worth a bit less *)
  FOR n:= 1 TO 8 DO
    FOR m:= 1 TO 8 DO
      DEC(pdw^['S',10*n+m],12);
    END;
  END;

  (* spejl af sort til hvid*)
  FOR ch:='b' TO 't' DO 
    CASE ch OF
    | 'b','e','t','r','k','m','d','s','l' : FOR n:=11 TO 88 DO
                                              pdw^[ch,n]:=pdw^[CAP(ch),99-n];
                                            END;
    ELSE END;
  END;

  (* konge mere værd hvis i sikkerhed *)

  IF ~EndGame THEN
    FOR m:= 1 TO 2 DO
      FOR n:=2 TO 3 DO
        pdw^['k',m*10+5-n]:=RokeretBonus;
        pdw^['k',m*10+5+n]:=RokeretBonus;
        pdw^['K',90-m*10+5-n]:=RokeretBonus;
        pdw^['K',90-m*10+5+n]:=RokeretBonus;
      END;
      FOR n:=4 TO 6 DO
        DEC(pdw^['k',m*10+n],pdkc12);
        DEC(pdw^['K',90-m*10+n],pdkc12);
      END;
    END;
    (* 5-98: develop king-side bishops *)
    DEC(pdw^['l',16],3);
    DEC(pdw^['L',86],3);
  END;

  (*pd:=pdw;*)
END PreProcess;

PROCEDURE PreProcessor(st:STILLINGTYPE);
VAR
  d,t,l,ss,b,D,T,L,S,B, n,m,f,FirstLineCount, wk,bk,x,y,v,nm,om,sw:INTEGER;
  ch:CHAR;
  nb,nB:INTEGER;
  r,R:ARRAY[1..8] OF BOOLEAN; (* stores TRUE if line open for rooks *)
  NoWoffs,NoBoffs:BOOLEAN;
PROCEDURE KingAdj(k:INTEGER);
VAR
  WpieceCnt,BpieceCnt:INTEGER;
  fc:CHAR;
BEGIN
  x:=k MOD 10;
  y:=k DIV 10;
  WpieceCnt:=0;
  BpieceCnt:=0;
  FOR n:=x-2 TO x+2 DO
    FOR m:=y-2 TO y+2 DO
      IF (n>0) & (n<9) & (m>0) & (m<9) THEN 
        f:=n+10*m;
        IF st[f]>' ' THEN
          IF st[f]=CAP(st[f]) THEN INC(BpieceCnt) ELSE INC(WpieceCnt) END;
        END;
      END;
    END;
  END;
  IF st[k]=CAP(st[k]) THEN (* black king, then swap *)
    n:=BpieceCnt;
    BpieceCnt:=WpieceCnt;
    WpieceCnt:=n;
  END;
  IF WpieceCnt+BpieceCnt<10 THEN
    INC(WpieceCnt,3);
  ELSIF WpieceCnt+BpieceCnt<13 THEN
    INC(WpieceCnt,2);
  ELSIF WpieceCnt+BpieceCnt<17 THEN
    INC(WpieceCnt);
  END;
  IF WpieceCnt-BpieceCnt>7 THEN
    l:=0;
  ELSIF WpieceCnt-BpieceCnt>5 THEN
    l:=AroundKingBonus;
  ELSIF WpieceCnt-BpieceCnt>4 THEN
    l:=AroundKingBonus*2;
  ELSE
    l:=AroundKingBonus*3
  END;
  FOR n:=x-2 TO x+2 DO
    FOR m:=y-2 TO y+2 DO
      IF (n>0) & (n<9) & (m>0) & (m<9) THEN 
        f:=n+10*m;
        INC(pdw^['D',f],l);
        INC(pdw^['T',f],l);
        INC(pdw^['L',f],l);
        INC(pdw^['S',f],l);
        INC(pdw^['B',f],l);
        INC(pdw^['d',f],l);
        INC(pdw^['t',f],l);
        INC(pdw^['l',f],l);
        INC(pdw^['s',f],l);
        INC(pdw^['b',f],l);
      END;
    END;
  END;
END KingAdj;
PROCEDURE PieceAdjust;
BEGIN
  FOR x:=1 TO 8 DO
    FOR y:=1 TO 8 DO
      v:=x+10*y;
      pdw^['k',v]:=0; (*pdw^['k',v] DIV 2;*)
      pdw^['K',v]:=0; (*pdw^['K',v] DIV 2;*)
    END;
  END;
  FOR x:=1 TO 8 DO
    FOR y:=1 TO 8 DO
      v:=x+10*y;
      IF st[v]>' ' THEN
        FOR n:=x-4 TO x+4 DO
          FOR m:=y-4 TO y+4 DO
            IF (n>0) & (n<9) & (m>0) & (m<9) & ((n<>x) OR (m<>y)) THEN 
              f:=n+10*m;
              l:=(26-ABS(y-m)*ABS(x-n)) DIV 2; (* 12,11,8,5 *)
              IF st[v]<>'k' THEN INC(pdw^['k',f],l); END;
              IF st[v]<>'K' THEN INC(pdw^['K',f],l); END;
            END;
          END;
        END;
      END;
    END;
  END;
  FOR x:=1 TO 8 DO FOR y:=1 TO 8 DO DEC(pdw^['k',x+10*y],50); END; END;
END PieceAdjust;
PROCEDURE SetP(brik:CHAR; distance:INTEGER; value:INTEGER);
VAR
  kx,ky,x,y:INTEGER;
BEGIN                  (* brik=white piece (adjusts for black too) *)
  kx:=bk MOD 10;
  ky:=bk DIV 10;
  FOR x:=kx-distance TO kx+distance DO
    FOR y:=ky-distance TO ky+distance DO
      IF (x>0) & (x<9) & (y>0) & (y<9)
      & ((ABS(x-kx)=distance) OR (ABS(y-ky)=distance)) THEN
        INC(pdw^[brik,x+10*y],value);
      END;
    END;
  END;
  kx:=wk MOD 10;
  ky:=wk DIV 10;
  FOR x:=kx-distance TO kx+distance DO
    FOR y:=ky-distance TO ky+distance DO
      IF (x>0) & (x<9) & (y>0) & (y<9)
      & ((ABS(x-kx)=distance) OR (ABS(y-ky)=distance)) THEN
        INC(pdw^[CAP(brik),x+10*y],value);
      END;
    END;
  END;
END SetP;
BEGIN
(*$ IF Test0 *) WRITELNF(s('PreProcessor...')); (*$ ENDIF *)

  (* init variables *)
  d:=0;t:=0;l:=0;ss:=0;b:=0;  D:=0;T:=0;L:=0;S:=0;B:=0;
  ClosedE4:=FALSE;ClosedD4:=FALSE;ClosedE3:=FALSE;
  ClosedE5:=FALSE;ClosedD3:=FALSE;ClosedD5:=FALSE;

  FirstLineCount:=16;

  (* count pieces *)
  FOR n:=11 TO 88 DO
    CASE st[n] OF
    | 'd'     : INC(d);
    | 'D'     : INC(D);
    | 't','r' : INC(t);
    | 'T','R' : INC(T);
    | 'l'     : INC(l);
    | 'L'     : INC(L);
    | 's'     : INC(ss);
    | 'S'     : INC(S);
    | 'b','e' : INC(b);
    | 'B','E' : INC(B);
    | 'k','m' : kOut := n=15;
    | 'K','M' : KOut := n=85;
    ELSE
      IF (n<19) OR (n>80) THEN DEC(FirstLineCount) END;
    END;
  END;
  NoBoffs:=  (S=0) & (L=0) & (D=0) & (T=0);
  NoWoffs:= (ss=0) & (l=0) & (d=0) & (t=0);

  (* set global flags *)
  OpenGame :=FirstLineCount>OpenGameValue;
  IF OpenGame THEN
    LatePart:=FirstLineCount<OpenGameValue+3;
    EndGame :=FALSE;
  ELSE
    EndGame  :=d*4+D*4+t*2+T*2+ss+S+l+L<EndGameValue;
    IF EndGame THEN
      LatePart:=d*4+D*4+t*2+T*2+ss+S+l+L<EndGameValue-4;
    END;
  END;

  (* Mating, 4-Double value of pawns to try to promote or Added value to
             get lonely king to the edge *)
  IF NoBoffs & (B=0) THEN
    FOR x:=1 TO 8 DO
      FOR y:=1 TO 8 DO
        n:=x+10*y;
        IF b=0 THEN
          IF (n<19) OR (n>70) OR (x=1) OR (x=8) THEN
            pdw^['K',n] := pdw^['K',n]-60;
          ELSIF (n<29) OR (n>60) OR (x=2) OR (x=7) THEN
            pdw^['K',n] := pdw^['K',n]-30;
          END;
        ELSE
          pdw^['b',n]:=pdw^['b',n]*4;
        END;
      END;
    END;
  END;
(*
  IF NoBoffs & (B>0) & (b>0) THEN
    FOR x:=1 TO 8 DO
      FOR y:=1 TO 8 DO
        n:=x+10*y;
        pdw^['b',n]:=pdw^['b',n]*4;
      END;
    END;
  END;
*)
  IF NoWoffs & (b=0) THEN
    FOR x:=1 TO 8 DO
      FOR y:=1 TO 8 DO
        n:=x+10*y;
        IF B=0 THEN
          IF (n<19) OR (n>70) OR (x=1) OR (x=8) THEN
            pdw^['k',n] := pdw^['k',n]-60;
          ELSIF (n<29) OR (n>60) OR (x=2) OR (x=7) THEN
            pdw^['k',n] := pdw^['k',n]-30;
          END;
        ELSE
          pdw^['B',n]:=pdw^['B',n]*4;
        END;
      END;
    END;
  END;
(*
  IF NoWoffs & (b>0) & (B>0) THEN
    FOR x:=1 TO 8 DO
      FOR y:=1 TO 8 DO
        n:=x+10*y;
        pdb^['B',n]:=pdb^['B',n]*4;
      END;
    END;
  END;
*)
  (* calc pawn center type *)
  IF (st[44]='b') & (st[54]='b') THEN
    ClosedD4:=TRUE;
    IF (st[35]='b') & (st[45]='B') THEN ClosedE3 :=TRUE END;
    IF (st[55]='b') & (st[65]='B') THEN ClosedE5 :=TRUE END;
  ELSIF (st[45]='b') & (st[55]='b') THEN
    ClosedE4:=TRUE;
    IF (st[34]='b') & (st[44]='B') THEN ClosedD3 :=TRUE END;
    IF (st[54]='b') & (st[64]='B') THEN ClosedD5 :=TRUE END;
  END;

  (* set default positional values (in pd) *)
(*$ IF Test *) stTst:=st; (*$ ENDIF *)
(*$ IF Test0 *) WRITELNF(s('T1: ')+lf(pdw^['k',24],3)); (*$ ENDIF *)

  PreProcess;

  IF (st[HvisTur]='S') THEN (* 5-98 *)
    IF ~NoBoffs & NoWoffs THEN
      FOR x:=1 TO 8 DO
        FOR y:=1 TO 8 DO
          n:=x+10*y;
          pdb^['B',n]:=pdb^['B',n]*2;
        END;
      END;
    END;
  ELSE
    IF ~NoWoffs & NoBoffs THEN
      FOR x:=1 TO 8 DO
        FOR y:=1 TO 8 DO
          n:=x+10*y;
          pdw^['b',n]:=pdw^['b',n]*2;
(*$ IF Test *) IF x=8 THEN WRITELN(s('*2 ')+lf(LONGINT(pdw^['b',n]),99)); END; (*$ ENDIF *)
        END;
      END;
    END;
  END;

(*$ IF Test0 *) WRITELNF(s('T2: ')+lf(pdw^['k',24],3)); (*$ ENDIF *)
(*$ IF Test0 *)  tst2('After PreProcess:',st,'K'); (*$ ENDIF *)

  (* rook open lines calc *)
  FOR x:=1 TO 8 DO
    r[x]:=TRUE;
    R[x]:=TRUE;
    FOR y:=20 TO 70 BY 10 DO
      IF (st[y+x]='b') OR (st[y+x]='e') THEN r[x]:=FALSE END;
      IF (st[y+x]='B') OR (st[y+x]='E') THEN R[x]:=FALSE END;
    END;
  END;

  (* king positions calc *)
  IF st[15]='m' THEN 
    wk:=15;
    IF ~EndGame THEN
      INC(pdw^['k',17],CastleBonus+9);
      INC(pdw^['k',13],CastleBonus-9);
    END;
  ELSE
    wk:=11;
    WHILE (st[wk]<>'k') & (wk<88) DO INC(wk) END;
  END;
  IF ~EndGame & (wk=15) OR OpenGame & ((wk MOD 10>3) OR (wk MOD 10<7)) THEN
    (* king castling eval (avoid a side?) *)
    f:=0; (* O-O-O *)
    IF (st[21]<>'b') & (st[31]<>'b') THEN INC(f); END;
    IF (st[22]<>'b') & (st[22]<>'l') & (st[33]<>'l') THEN INC(f); END;
    IF st[23]<>'b' THEN INC(f); END;
    FOR x:=1 TO 3 DO IF R[x] THEN INC(f) END; END;
    IF f>0 THEN DEC(pdw^['k',13],f*f*AvoidCastling) END;
    f:=0; (* O-O *)
    IF (st[28]<>'b') & (st[38]<>'b') THEN INC(f); END;
    IF (st[27]<>'b') & (st[27]<>'l')  & (st[36]<>'l') THEN INC(f); END;
    IF st[26]<>'b' THEN INC(f); END;
    FOR x:=6 TO 8 DO IF r[x] THEN INC(f) END; END;
    IF f>0 THEN
      DEC(pdw^['k',17],f*f*AvoidCastling);
    ELSE
      IF (st[15]='m') & (st[16]='l') & (st[17]='s') THEN
        (* undeveloped king-side penalty *)
        DEC(pdw^['l',16],8);
        DEC(pdw^['s',17],8);
      END; 
    END;
  END;

  IF st[85]='M' THEN
    bk:=85;
    IF ~EndGame THEN
      INC(pdw^['K',87],CastleBonus+9);
      INC(pdw^['K',83],CastleBonus-9);
    END;
  ELSE
    bk:=88;
    WHILE (st[bk]<>'K') & (bk>11) DO DEC(bk) END;
  END;
  IF ~EndGame & (bk=85) OR OpenGame & ((bk MOD 10>3) OR (bk MOD 10<7)) THEN
    f:=0; (* O-O-O *)
    IF (st[71]<>'B') & (st[61]<>'B') THEN INC(f); END;
    IF (st[72]<>'B') & (st[72]<>'L') & (st[63]<>'L') THEN INC(f); END;
    IF st[73]<>'B' THEN INC(f); END;
    FOR x:=1 TO 3 DO IF r[x] THEN INC(f) END; END;
    IF f>0 THEN DEC(pdw^['K',83],f*f*AvoidCastling) END;
    f:=0; (* O-O *)
    IF (st[78]<>'B') & (st[68]<>'B') THEN INC(f); END;
    IF (st[77]<>'B') & (st[77]<>'L') & (st[66]<>'L') THEN INC(f); END;
    IF st[76]<>'B' THEN INC(f); END;
    FOR x:=6 TO 8 DO IF r[x] THEN INC(f) END; END;
    IF f>0 THEN
      DEC(pdw^['K',87],f*f*AvoidCastling);
    ELSE
      IF (st[85]='M') & (st[86]='L') & (st[87]='S') THEN (* undeveloped king-side penalty *)
        DEC(pdw^['L',86],8);
        DEC(pdw^['S',87],8);
      END; 
    END;
  END;

  (* adjust around opponent king (wk,bk) as better fields (mating) *)
  IF EndGame THEN
    (* attract the kings to areas with pieces, own AND opponents *)
    PieceAdjust;
(*$ IF Test0 *)  tst2('After PieceAdjust:',st,'K'); (*$ ENDIF *)
(*$ IF Test0 *)  tst2('After PieceAdjust:',st,'B'); (*$ ENDIF *)
(*$ IF Test0 *)  tst2('After PieceAdjust:',st,'k'); (*$ ENDIF *)
(*$ IF Test0 *)  tst2('After PieceAdjust:',st,'b'); (*$ ENDIF *)
    SetP('d',0,KingArea30);
    SetP('d',1,KingArea30);
    SetP('d',2,KingArea20);
    SetP('d',3,KingArea12);
    SetP('d',4,KingArea8);
    SetP('t',0,KingArea30);
    SetP('t',1,KingArea30);
    SetP('t',2,KingArea20);
    SetP('t',3,KingArea12);
    SetP('t',4,KingArea8);
    SetP('k',0,KingArea20);
    SetP('k',1,KingArea20);
    SetP('k',2,KingArea16);
    SetP('k',3,KingArea12);
    SetP('k',4,KingArea8);
(*$ IF Test0 *)  tst2('After SetP:',st,'K'); (*$ ENDIF *)
(*$ IF Test0 *)  tst2('After SetP:',st,'B'); (*$ ENDIF *)
(*$ IF Test0 *)  tst2('After SetP:',st,'k'); (*$ ENDIF *)
(*$ IF Test0 *)  tst2('After SetP:',st,'b'); (*$ ENDIF *)
  ELSE

    IF (st[11]='t') & (wk=12) OR (wk=13) THEN (* rook in corner *)
      DEC(pdw^['t',11],10); DEC(pdw^['t',21],10); DEC(pdw^['t',12],10);
      DEC(pdw^['k',14],RokeretBonus DIV 2);
      INC(pdw^['k',21],RokeretBonus+10);
      INC(pdw^['k',22],RokeretBonus+10);
      INC(pdw^['k',23],RokeretBonus);
      IF (st[wk+9]='b') & (st[wk+10]='b') THEN
        INC(pdw^['b',31],RokeretBonus+10);
        INC(pdw^['b',32],RokeretBonus+10);
        INC(pdw^['b',33],RokeretBonus);
        INC(pdw^['b',41],RokeretBonus+10);
      END;
    END;
    IF (st[18]='t') & (wk=17) OR (wk=16) THEN (* rook in corner *)
      DEC(pdw^['t',18],10); DEC(pdw^['t',28],10); DEC(pdw^['t',17],10);
      DEC(pdw^['k',15],RokeretBonus DIV 2);
      INC(pdw^['k',28],RokeretBonus+10);
      INC(pdw^['k',27],RokeretBonus+10);
      INC(pdw^['k',26],RokeretBonus);
      IF (st[wk+11]='b') & (st[wk+10]='b') THEN
        INC(pdw^['b',38],RokeretBonus+10);
        INC(pdw^['b',37],RokeretBonus+10);
        INC(pdw^['b',36],RokeretBonus);
        INC(pdw^['b',48],RokeretBonus+10);
      END;
    END;

    IF (st[81]='T') & (bk=82) OR (bk=83) THEN (* rook in corner *)
      DEC(pdw^['T',81],10); DEC(pdw^['T',71],10); DEC(pdw^['T',82],10);
      DEC(pdw^['K',84],RokeretBonus DIV 2);
      INC(pdw^['K',71],RokeretBonus+10);
      INC(pdw^['K',72],RokeretBonus+10);
      INC(pdw^['K',73],RokeretBonus);
      IF (st[bk-11]='B') & (st[bk-10]='B') THEN
        INC(pdw^['B',61],RokeretBonus+10);
        INC(pdw^['B',62],RokeretBonus+10);
        INC(pdw^['B',63],RokeretBonus);
        INC(pdw^['B',51],RokeretBonus+10);
      END;
    END;
    IF (st[88]='T') & (bk=87) OR (bk=86) THEN (* rook in corner *)
      DEC(pdw^['T',88],10); DEC(pdw^['T',78],10); DEC(pdw^['T',87],10);
      DEC(pdw^['K',85],RokeretBonus DIV 2);
      INC(pdw^['K',78],RokeretBonus+16);
      INC(pdw^['K',77],RokeretBonus+16);
      INC(pdw^['K',76],RokeretBonus);
      IF (st[bk-9]='B') & (st[bk-10]='B') THEN
        INC(pdw^['B',68],RokeretBonus+10);
        INC(pdw^['B',67],RokeretBonus+10);
        INC(pdw^['B',66],RokeretBonus);
        INC(pdw^['B',58],RokeretBonus+10);
      END;
    END;

    (* king positions adjust up around *)
    KingAdj(wk);
(*$ IF Test0 *)  tst2('After KingAdj(wk):',st,'K'); (*$ ENDIF *)
    KingAdj(bk);
(*$ IF Test0 *)  tst2('After KingAdj(bk):',st,'K'); (*$ ENDIF *)
  END;
(*$ IF Test0 *) WRITELNF(s('T4: ')+lf(pdw^['k',24],3)); (*$ ENDIF *)

  (* if closed center, add value to strategical pawn moves, decrement bad bishop *)
  IF ClosedD4 THEN
    IF ClosedE5 THEN
      INC(pdw^['b',46],PawnStrateg10);
      INC(pdw^['b',56],PawnStrateg20);
      INC(pdw^['B',53],PawnStrateg20);
    END;
    IF ClosedE3 THEN
      INC(pdw^['b',43],PawnStrateg20);
      INC(pdw^['B',56],PawnStrateg10);
      INC(pdw^['B',46],PawnStrateg20);
    END;   
    IF ClosedE5 OR ClosedE3 THEN (* decrement white/black bad bishops on own half *)
      FOR m:=1 TO 4 DO
        FOR n:=1 TO 4 DO
          f:=10*m+n*2;
          IF ODD(m) THEN
            DEC(pdw^['l',f-1],BishopClosed);
            DEC(pdw^['L',f+40],BishopClosed);
          ELSE
            DEC(pdw^['l',f],BishopClosed);
            DEC(pdw^['L',f+39],BishopClosed);
          END;
        END;
      END;
    END;
  END;
  IF ClosedE4 THEN
    IF ClosedD5 THEN
      INC(pdw^['b',43],PawnStrateg10);
      INC(pdw^['b',53],PawnStrateg20);
      INC(pdw^['B',56],PawnStrateg20);
    END;
    IF ClosedD3 THEN
      INC(pdw^['b',46],PawnStrateg20);
      INC(pdw^['B',53],PawnStrateg10);
      INC(pdw^['B',43],PawnStrateg20);
    END;   
    IF ClosedD5 OR ClosedD3 THEN (* decrement white/black bad bishops on own half *)
      FOR m:=1 TO 4 DO
        FOR n:=1 TO 4 DO
          f:=10*m+n*2;
          IF ODD(m) THEN
            DEC(pdw^['l',f],BishopClosed);
            DEC(pdw^['L',f+39],BishopClosed);
          ELSE
            DEC(pdw^['l',f-1],BishopClosed);
            DEC(pdw^['L',f+40],BishopClosed);
          END;
        END;
      END;
    END;
  END;

  (* add value to bishops if open center *)
  IF ~ClosedD4 & ~ClosedE4 THEN
    FOR n:=11 TO 88 DO
      INC(pdw^['l',n],BishopOpen);
      INC(pdw^['L',n],BishopOpen);
    END;
  END;

  (* add value to knights if closed center *)
  IF ClosedD4 & (ClosedE3 OR ClosedE5) OR  ClosedE4 & (ClosedD3 OR ClosedD5) THEN
    FOR n:=11 TO 88 DO
      INC(pdw^['s',n],KnightClosed);
      INC(pdw^['S',n],KnightClosed);
    END;
  END;

  (* rooks bonus on open lines *)
  FOR n:=1 TO 8 DO
    nb:=0; nB:=0;
    FOR m:=2 TO 7 DO
      ch:=st[10*m+n];
      IF ch='b' THEN INC(nb) END;
      IF ch='B' THEN INC(nB) END;
    END;
    IF nb=0 THEN
      IF nB=1 THEN f:=RookHalfOpenLine ELSE f:=RookFullOpenLine END;
      FOR m:=1 TO 2 DO
        INC(pdw^['t',10*m+n],f);
      END;
      IF ((n=1) OR (n=8)) THEN INC(pdw^['r',10+n],f) END;
    END;
    IF nB=0 THEN
      IF nb=1 THEN f:=RookHalfOpenLine ELSE f:=RookFullOpenLine END;
      FOR m:=7 TO 8 DO
        INC(pdw^['T',10*m+n],f);
      END;
      IF ((n=1) OR (n=8)) THEN INC(pdw^['R',10+n],f) END;
    END;
  END;

  IF OpenGame THEN
    (* Bishop b/g5 bonus if not too early *)
    IF (st[33]='s') THEN INC(pdw^['L',42],pdB5); ELSE DEC(pdw^['L',42],pdB5 DIV 2) END;
    IF (st[63]='S') THEN INC(pdw^['l',52],pdB5); ELSE DEC(pdw^['l',52],pdB5 DIV 2) END;
    IF (st[36]='s') THEN INC(pdw^['L',47],pdB5); ELSE DEC(pdw^['L',47],pdB5 DIV 2) END;
    IF (st[66]='S') THEN INC(pdw^['l',57],pdB5); ELSE DEC(pdw^['l',57],pdB5 DIV 2) END;
    (* too early knights *)
    (*WRITELN(s('TOOEARLYKNIGHTS:s(33)=')+lf(pdw^['s',33],4));*)
    IF (st[44]='b') & (st[54]=' ') THEN
      IF st[63]='S' THEN
        INC(pdw^['B',54],EarlyKnight);
        INC(pdw^['B',65],EarlyKnight);
      ELSE
        DEC(pdw^['S',63],EarlyKnight);
        IF st[75]='B' THEN DEC(pdw^['S',63],EarlyKnight); END;
      END;
    END;
    IF (st[54]='B') & (st[44]=' ') THEN 
      IF st[33]='s' THEN
        INC(pdw^['b',44],EarlyKnight);
        INC(pdw^['b',35],EarlyKnight);
      ELSE
        DEC(pdw^['s',33],EarlyKnight);
        IF st[25]='b' THEN DEC(pdw^['s',33],EarlyKnight); END;
      END;
    END;
    IF (st[45]='b') & (st[55]=' ') THEN 
      IF st[66]='S' THEN
        INC(pdw^['B',55],EarlyKnight);
        INC(pdw^['B',64],EarlyKnight);
      ELSE
        DEC(pdw^['S',66],EarlyKnight);
        IF st[74]='B' THEN DEC(pdw^['S',66],EarlyKnight); END;
      END;
    END;
    IF (st[55]='B') & (st[45]=' ') THEN 
      IF st[36]='s' THEN
        INC(pdw^['b',45],EarlyKnight);
        INC(pdw^['b',34],EarlyKnight);
      ELSE
        DEC(pdw^['s',36],EarlyKnight);
        IF st[24]='b' THEN DEC(pdw^['s',36],EarlyKnight); END;
      END;
    END;
    (*WRITELN(s('TOOEARLYKNIGHTS:s(33)=')+lf(pdw^['s',33],4));*)
  END;
  (* too early bishops *)
  IF (st[33]=' ') & (st[23]='b') THEN
    DEC(pdw^['L',42],EarlyKnight);
  END;
  IF (st[36]=' ') & (st[26]='b') THEN
    DEC(pdw^['L',47],EarlyKnight);
  END;
  IF (st[63]=' ') & (st[73]='B') THEN
    DEC(pdw^['l',52],EarlyKnight);
  END;
  IF (st[66]=' ') & (st[76]='B') THEN
    DEC(pdw^['l',57],EarlyKnight);
  END;
  IF ~EndGame THEN
    (* too late bishops *)
    DEC(pdw^['L',86],LateBishop);
    DEC(pdw^['L',83],LateBishop);
    DEC(pdw^['l',13],LateBishop);
    DEC(pdw^['l',16],LateBishop);
  END;

  (* h3 *)
  IF (st[47]='L') OR (st[47]='S') THEN INC(pdw^['b',38],pawnh3a3attack); END;
  IF (st[57]='l') OR (st[57]='s') THEN INC(pdw^['B',68],pawnh3a3attack); END;
  IF (st[42]='L') OR (st[42]='S') THEN INC(pdw^['b',38],pawnh3a3attack); END;
  IF (st[52]='l') OR (st[52]='s') THEN INC(pdw^['B',68],pawnh3a3attack); END;

  (*  penalty for bishops behind own pawns *)
  FOR n:=10 TO 50 BY 10 DO (* do it for whites first 5 rows *)
    FOR m:=1 TO 8 DO
      IF st[n+m]='b' THEN
        IF st[n+10+m]='B' THEN v:=BishopPenalty*2 ELSE v:=BishopPenalty END; 
        FOR f:=1 TO m-1 DO (* to left edge *)
          IF 10*f<n THEN (* if on-board *) 
            DEC(pdw^['l',n-10*f+f],v);
          END;
        END;
        FOR f:=1 TO 8-m DO (* to right edge *)
          IF 10*f<n THEN
            DEC(pdw^['l',n-10*f+m+f],v);
          END;
        END;
      END;
    END;
  END;
  FOR n:=40 TO 80 BY 10 DO (* do it for blacks first 5 rows *)
    FOR m:=1 TO 8 DO
      IF st[n+m]='B' THEN 
        IF st[n-10+m]='b' THEN v:=BishopPenalty*2 ELSE v:=BishopPenalty END;
        FOR f:=1 TO m-1 DO (* to left edge *)
          IF 10*f+n<90 THEN (* if on-board *)
            DEC(pdw^['L',n+10*f+f],v);
          END;
        END;
        FOR f:=1 TO 8-m DO (* to right edge *)
          IF 10*f+n<90 THEN
            DEC(pdw^['L',n+10*f+m+f],v);
          END;
        END;
      END;
    END;
  END;
      
  (* mirror pdw to pdb *)
  FOR ch:='b' TO 't' DO 
    CASE ch OF
    | 'b','e','t','r','k','m','d','s','l' :
      FOR n:=1 TO 4 DO 
        nm:=10*n;
        om:=90-nm;
        FOR m:=1 TO 8 DO
          INC(nm);
          INC(om);

          pdb^[ch,nm]      := pdw^[CAP(ch),om];
          pdb^[ch,om]      := pdw^[CAP(ch),nm];
          pdb^[CAP(ch),nm] := pdw^[ch,om];
          pdb^[CAP(ch),om] := pdw^[ch,nm];

        END;
      END;
    ELSE END;
  END;

(*$ IF Test *)
  tst2('Preprocessor slut:',st,'K');
  tst2('Preprocessor slut:',st,'B');
  tst2('Preprocessor slut:',st,'k');
  tst2('Preprocessor slut:',st,'b');
  IF OpenGame OR EndGame THEN
    IF LatePart THEN WRITEF(s(' LatePart')) END;
    IF OpenGame THEN 
      WRITELNF(s(' OpenGame.'));
    ELSE
      WRITELNF(s(' EndGame.'));
    END;
  ELSE
    WRITELNF(s(' MidGame.'));
  END;
(*$ ENDIF *)
END PreProcessor;

PROCEDURE Eval(VAR stilling:STILLINGTYPE; Activity:INTEGER;
               Sort:BOOLEAN; alpha, beta:INTEGER):INTEGER;
CONST
  ActivityWeight=0; (*!!!!!!!!!!!!!!!!!!!!!! 1-5 !!!!!!*)
  TwoOnRow7=350;
  TwoOnRow6=150;

VAR
  n,m,res,kpos,Kpos,x,y,inmv: INTEGER;   (* Positionel, matriel værdi *)
  brik                      : CHAR;
  KingEndGameW,KingEndGameB : BOOLEAN; (* if k or k+n endgame W/B *)
  knEndGameW,knEndGameB     : BOOLEAN; (* if k+n endgame W/B      *)
  priW,priB                 : INTEGER; (* for k or kn endgame     *)
  Wpawns,Bpawns             : ARRAY[10..89] OF BOOLEAN;
  WpL,BpL                   : ARRAY[1..8] OF SHORTINT; (* Pawns on line (iopb) *)
  WpLc,BpLc                 : SHORTINT; (* Pawns Total (if only pawns back) *)
  HvidsTur,Slut             : BOOLEAN;
BEGIN
  HvidsTur:=stilling[HvisTur]<>'S';
  IF HvidsTur THEN 
    inmv:=InMoveBonus;
  ELSE
    inmv:=-InMoveBonus;
  END;
  INC(Evals);
  posi:=0;
  wbonus:=0;
  bbonus:=0;
  matr:=0;
  KingEndGameW:=TRUE; knEndGameW:=FALSE;
  KingEndGameB:=TRUE; knEndGameB:=FALSE;
  FOR n:=11 TO 88 DO
    brik:=stilling[n];
    IF (brik>'A') THEN 
      CASE brik OF
        | 't','r' : matr:=matr+ValueT; KingEndGameW:=FALSE;
                    IF (n<50) THEN
                      IF (stilling[n+10]='b') OR (stilling[n+20]='b') THEN
                        wbonus:=wbonus-8;
                      END;
                    END;
                    IF n=11 THEN
                      IF brik='r' THEN matr:=matr+(ValueR-ValueT); END;
                      IF stilling[12]<>' ' THEN
                        IF stilling[12]='k' THEN
                          wbonus:=wbonus-30;
                        ELSE
                          wbonus:=wbonus-4;
                        END;
                      END;
                    ELSIF n=18 THEN
                      IF brik='r' THEN matr:=matr+(ValueR-ValueT); END;
                      IF stilling[17]<>' ' THEN
                        IF stilling[17]='k' THEN
                          wbonus:=wbonus-30;
                        ELSE
                          wbonus:=wbonus-4;
                        END;
                      END;
                    END;
        | 'm'     : matr:=matr+ValueM; kpos:=n;
        | 'k'     : matr:=matr+ValueK; kpos:=n;
                    IF ~EndGame THEN
                      IF (n=16) & ((stilling[18]='t') OR (stilling[17]='t'))
                      OR (n=13) & ((stilling[11]='t') OR (stilling[12]='t')) THEN
                        IF (n=16) & (stilling[26]='b') & (stilling[27]='b') 
                        OR (n=13) & (stilling[23]='b') & (stilling[22]='b') THEN
                          wbonus:=wbonus-22;
                        END;
                      ELSE
                        FOR m:=n+9 TO n+11 DO
                          IF stilling[m]='b' THEN wbonus:=wbonus+12 END;
                        END;
                        wbonus:=wbonus-12;
                      END;
                    END;
        | 'd'     : matr:=matr+ValueD; KingEndGameW:=FALSE;
                    IF OpenGame THEN
                      IF n>28 THEN
                        wbonus:=wbonus-12;
                        IF n>41 THEN
                          wbonus:=wbonus-12;
                        ELSE
                          IF (n=34) & (stilling[24]='b') THEN
                            wbonus:=wbonus-20;
                            IF (stilling[13]='l') & (stilling[22]='b') THEN
                              wbonus:=wbonus-30;
                            END;
                          ELSIF (n=35) & (stilling[25]='b') THEN
                            wbonus:=wbonus-20;
                            IF (stilling[16]='l') & (stilling[27]='b') THEN
                              wbonus:=wbonus-30;
                            END;
                          END;
                        END;
                      ELSIF (n=24) & (stilling[13]='l') & (stilling[22]='b')
                      OR    (n=25) & (stilling[16]='l') & (stilling[27]='b') THEN
                        wbonus :=wbonus-15;
                      END;
                    END;
        | 'l'     : matr:=matr+ValueL; KingEndGameW:=FALSE;
                    IF (n<39) & (n>30) THEN IF stilling[n-10]='b' THEN wbonus:=wbonus-13 END END;
                    IF (n=13) & (stilling[22]='b') & (stilling[24]<>' ') THEN wbonus:=wbonus-8 END;  
                    IF (n=16) & (stilling[27]='b') & (stilling[25]<>' ') THEN wbonus:=wbonus-8 END;  
                    IF (stilling[n-11]='b') OR (stilling[n-9]='b') THEN wbonus:=wbonus+8 END;
        | 's'     : matr:=matr+ValueS; knEndGameW:=TRUE;
                    IF (n<39) & (n>30) THEN IF stilling[n-10]='b' THEN wbonus:=wbonus-10 END END;
                    IF (stilling[n-11]='b') OR (stilling[n-9]='b') THEN wbonus:=wbonus+8 END;
                    IF (stilling[n+10]='B') & (stilling[n+11]<>'B') & (stilling[n+9]<>'B') THEN
                      wbonus:=wbonus+12;
                      IF (n>50) OR (stilling[n+19]<>'B') & (stilling[n+21]<>'B') THEN 
                        wbonus:=wbonus+12;
                        IF (n>60) OR (stilling[n+29]<>'B') & (stilling[n+31]<>'B') THEN 
                          wbonus:=wbonus+12;
                        END;
                      END;
                    END;
        | 'b','e' : matr:=matr+ValueB;
                    IF stilling[n- 1]='b' THEN
                      IF EndGame THEN
                        IF n>70 THEN
                          wbonus:=wbonus+TwoOnRow7;
                        ELSIF n>60 THEN
                          wbonus:=wbonus+TwoOnRow6;
                        END;
                      END;
                      wbonus:=wbonus+8;
                    END;
                    IF stilling[n+ 1]='b' THEN wbonus:=wbonus+8 END;
                    IF stilling[n- 9]='b' THEN wbonus:=wbonus+5 END;
                    IF stilling[n-11]='b' THEN wbonus:=wbonus+5 END;
                    IF stilling[n-10]='b' THEN wbonus:=wbonus-40 END;
                    IF stilling[n-20]='b' THEN wbonus:=wbonus-40 END;
        | 'T','R' : matr:=matr-ValueT; KingEndGameB:=FALSE;
                    IF (n>40) THEN
                      IF (stilling[n-10]='B') OR (stilling[n-20]='B') THEN
                        bbonus:=bbonus-8;
                      END;
                    END;
                    IF n=81 THEN
                      IF brik='R' THEN matr:=matr+(ValueT-ValueR); END;
                      IF stilling[82]<>' ' THEN
                        IF stilling[82]='K' THEN
                          bbonus:=bbonus-30;
                        ELSE
                          bbonus:=bbonus-4;
                        END;
                      END;
                    ELSIF n=88 THEN
                      IF brik='R' THEN matr:=matr+(ValueT-ValueR); END;
                      IF stilling[87]<>' ' THEN
                        IF stilling[87]='K' THEN
                          bbonus:=bbonus-30;
                        ELSE
                          bbonus:=bbonus-4;
                        END;
                      END;
                    END;
        | 'M'     : matr:=matr-ValueM; Kpos:=n;
        | 'K'     : matr:=matr-ValueK; Kpos:=n;
                    IF ~EndGame THEN
                      IF (n=86) & ((stilling[88]='T') OR (stilling[87]='T'))
                      OR (n=83) & ((stilling[81]='T') OR (stilling[82]='T')) THEN
                        IF (n=86) & (stilling[76]='B') & (stilling[77]='B') 
                        OR (n=83) & (stilling[73]='B') & (stilling[72]='B') THEN
                          bbonus:=bbonus-22;
                        END;
                      ELSE
                        FOR m:=n-11 TO n-9 DO
                          IF stilling[m]='B' THEN bbonus:=bbonus+12 END;
                        END;
                        bbonus:=bbonus-12;
                      END;
                    END;
        | 'D'     : matr:=matr-ValueD; KingEndGameB:=FALSE;
                    IF OpenGame THEN
                      IF n<71 THEN
                        bbonus:=bbonus-12;
                        IF n<61 THEN
                           IF n<>51 THEN bbonus:=bbonus-12 END;
                        ELSE
                          IF (n=64) & (stilling[74]='B') THEN
                            bbonus:=bbonus-20;
                            IF (stilling[83]='L') & (stilling[72]='B') THEN
                              bbonus:=bbonus-30;
                            END;
                          ELSIF (n=65) & (stilling[75]='B') THEN
                            bbonus:=bbonus-20;
                            IF (stilling[86]='L') & (stilling[77]='B') THEN
                              bbonus:=bbonus-30;
                            END;
                          END;
                        END;
                      ELSIF (n=74) & (stilling[83]='L') & (stilling[72]='B')
                      OR    (n=75) & (stilling[86]='L') & (stilling[77]='B') THEN
                        bbonus :=bbonus-15;
                      END;
                    END;
        | 'L'     : matr:=matr-ValueL; KingEndGameB:=FALSE;
                    IF (n>60) & (n<69) THEN IF stilling[n+10]='B' THEN bbonus:=bbonus-13 END END;
                    IF (n=83) & (stilling[72]='B') & (stilling[74]<>' ') THEN bbonus:=bbonus-8 END;  
                    IF (n=86) & (stilling[77]='B') & (stilling[75]<>' ') THEN bbonus:=bbonus-8 END;  
                    IF (stilling[n+11]='B') OR (stilling[n+9]='B') THEN bbonus:=bbonus+8 END;
        | 'S'     : matr:=matr-ValueS; knEndGameB:=TRUE;
                    IF (n>60) & (n<69) THEN IF stilling[n+10]='B' THEN bbonus:=bbonus-10 END END;
                    IF (stilling[n+11]='B') OR (stilling[n+9]='B') THEN bbonus:=bbonus+8 END;
                    IF (stilling[n-10]='b') & (stilling[n-11]<>'b') & (stilling[n-9]<>'b') THEN
                      bbonus:=bbonus+12;
                      IF (n<31) OR (stilling[n-19]<>'b') & (stilling[n-21]<>'b') THEN 
                        bbonus:=bbonus+12;
                        IF (n<41) OR (stilling[n-29]<>'b') & (stilling[n-31]<>'b') THEN 
                          bbonus:=bbonus+12;
                        END;
                      END;
                    END;
        | 'B','E' : matr:=matr-ValueB;
                    IF stilling[n- 1]='B' THEN
                      IF EndGame THEN
                        IF n<29 THEN
                          bbonus:=bbonus+TwoOnRow7;
                        ELSIF n<39 THEN
                          bbonus:=bbonus+TwoOnRow6;
                        END;
                      END;
                      bbonus:=bbonus+8;
                    END;
                    IF stilling[n+ 1]='B' THEN bbonus:=bbonus+8 END;
                    IF stilling[n+ 9]='B' THEN bbonus:=bbonus+5 END;
                    IF stilling[n+11]='B' THEN bbonus:=bbonus+5 END;
                    IF stilling[n+10]='B' THEN bbonus:=bbonus-40 END;
                    IF stilling[n+20]='B' THEN bbonus:=bbonus-40 END;
      ELSE END;
(*$ IF Test0 *)
WRITEF(s('POSI (')+l(posi)+c(')'));
(*$ENDIF *)
      IF brik=CAP(brik) THEN 
        posi:=posi-pd^[brik,n]; (* 99-n *)
      ELSE 
        posi:=posi+pd^[brik,n]; (* CAP(brik) *)
      END;
(*$ IF Test0 *)
WRITELNF(s(' brik=')+c(brik)+s(' n=')+l(n)+s(' posi=')+l(posi));
(*$ENDIF *)
    END;
  END;
  IF KingEndGameW OR KingEndGameB THEN

    IF knEndGameW THEN priW:=6 ELSE priW:=12 END;
    IF knEndGameB THEN priB:=6 ELSE priB:=12 END;


    FOR n:=11 TO 88 DO
      Wpawns[n]:=FALSE;
      Bpawns[n]:=FALSE;
    END;

    FOR x:=1 TO 8 DO WpL[x]:=0; BpL[x]:=0; END;
    WpLc:=0; BpLc:=0;
    (* mark squares with pawn defend *)
    FOR y:=2 TO 7 DO
      FOR x:=1 TO 8 DO
        n:=10*y+x;
        CASE stilling[n] OF
        | 'B','E' : IF KingEndGameB THEN
                      INC(BpL[x]);
                      INC(BpLc);
                      Bpawns[n-10]:=TRUE;
                      IF ~HvidsTur THEN 
                        Bpawns[n-11]:=TRUE; (* 10 too! *)
                        Bpawns[n- 9]:=TRUE;
                      END;
                      FOR m:=20+x TO n-20 BY 10 DO
                        Bpawns[m]  :=TRUE;
                        Bpawns[m-1]:=TRUE;
                        Bpawns[m+1]:=TRUE;
                      END;
                    END;
        | 'b','e' : IF KingEndGameW THEN
                      INC(WpL[x]);
                      INC(WpLc);
                      Wpawns[n+10]:=TRUE;
                      IF HvidsTur THEN 
                        Wpawns[n+11]:=TRUE; (* 89 too! *)
                        Wpawns[n+ 9]:=TRUE;
                      END;
                      FOR m:=n+20 TO 70+x BY 10 DO
                        Wpawns[m]  :=TRUE;
                        Wpawns[m-1]:=TRUE;
                        Wpawns[m+1]:=TRUE;
                      END;
                    END;
        ELSE END;
      END;
    END;

    (* find first (nearest promotion) free white pawn *)
    IF KingEndGameB THEN
      Slut:=FALSE;
      IF ~knEndGameB & (posi<0) THEN (* Check if only pawns on A or H file *)
        (* IF king in the corner then equal !!!!!!! VIRKER VIST IKKE!!!!!*)
        IF (BpLc=BpL[8]) & ((kpos=17) OR (kpos=18) OR (kpos=27) OR (kpos=28)) 
        OR (BpLc=BpL[1]) & ((kpos=12) OR (kpos=11) OR (kpos=22) OR (kpos=21)) THEN
          RETURN(0);
        END;
      END;
      FOR y:=7 TO 3 BY -1 DO
        FOR x:=1 TO 8 DO
          n:=10*y+x;
          IF (stilling[n]='b') OR (y=3) & (stilling[n-10]='b') THEN
            IF ~Bpawns[n] THEN
              IF (Kpos DIV 10<y) OR (ABS(Kpos MOD 10-x)>8-y) THEN
                Slut:=TRUE; (* inside quadrant *)
              ELSIF ~knEndGameB THEN
                IF (n>60) THEN
                  IF (kpos=n+9) OR (kpos=n+11) THEN
                    Slut:=TRUE; (* Supported pawn *)
                  ELSIF n>70 THEN
                    IF (kpos=n-1) OR (kpos=n+1)
                    OR (kpos>=n-12) & (kpos<=n-8) & (Kpos<>n+10) THEN
                      Slut:=TRUE; (* Supported pawn *)
                    END;
                  ELSE
                    IF (kpos=n-1) & (Kpos MOD 10>x)
                    OR (kpos=n+1) & (Kpos MOD 10<x) THEN
                      Slut:=TRUE; (* Supported pawn in one move *)
                      posi:=posi-50;
                    END;
                  END;
                ELSIF (n>50) THEN
                  (* IF Possibly supported pawn then add value:*)
                  IF (kpos=n+9)  OR (kpos=n+11) THEN posi:=posi+ 50 END;
                  IF (kpos=n+10) OR (kpos=n+20) THEN posi:=posi+ 20 END;
                  IF (kpos=n+19) OR (kpos=n+21) THEN posi:=posi+ 80 END;
                END;
              END;
              IF Slut THEN
                posi:=posi+y*y*priW; x:=8; y:=3; (* pawn can promote, exit loop *)
(*$ IF Test0 *) WRITELNF(s(' fpW felt=')+l(n)+s(' posi=')+l(posi)); (*$ ENDIF *)
              END;
            END;
          END;
        END;
      END;
    END;

    (* find first (nearest promotion) free black pawn *)
    IF KingEndGameW THEN
      Slut:=FALSE;
      IF ~knEndGameW & (posi>0) THEN (* Check if only pawns on A or H file *)
        (* IF king in the corner then equal !!!!!!! VIRKER VIST IKKE!!!!!*)
        IF (WpLc=WpL[8]) & ((Kpos=87) OR (Kpos=88) OR (Kpos=77) OR (Kpos=78)) 
        OR (WpLc=WpL[1]) & ((Kpos=72) OR (Kpos=71) OR (Kpos=72) OR (Kpos=71)) THEN
          RETURN(0);
        END;
      END;
      FOR y:=2 TO 6 DO
        FOR x:=1 TO 8 DO
          n:=10*y+x;
          IF (stilling[n]='B') OR (y=6) & (stilling[n+10]='B') THEN
            IF ~Wpawns[n] THEN
              IF (kpos DIV 10-1>y) OR (ABS(kpos MOD 10-x)>y) THEN
                Slut:=TRUE; (* inside quadrant *)
              ELSIF ~knEndGameW THEN
                IF (n<40) THEN
                  IF (Kpos=n-9) OR (Kpos=n-11) THEN
                    Slut:=TRUE; (* Supported pawn *)
                  ELSIF n<30 THEN
                    IF (Kpos=n-1) OR (Kpos=n+1)
                    OR (Kpos>=n+12) & (Kpos<=n+8) & (kpos<>n-10) THEN
                      Slut:=TRUE; (* Supported pawn *)
                    END;
                  ELSE
                    IF (Kpos=n-1) & (kpos MOD 10>x)
                    OR (Kpos=n+1) & (kpos MOD 10<x) THEN
                      Slut:=TRUE; (* Supported pawn in one move *)
                      posi:=posi+50;
                    END;
                  END;
                ELSIF (n<50) THEN
                  (* IF Possibly supported pawn then add value:*)
                  IF (Kpos=n-9)  OR (Kpos=n-11) THEN posi:=posi- 50 END;
                  IF (Kpos=n-10) OR (Kpos=n-20) THEN posi:=posi- 20 END;
                  IF (Kpos=n-19) OR (Kpos=n-21) THEN posi:=posi- 80 END;
                END;
              END;
              IF Slut THEN
                posi:=posi-(9-y)*(9-y)*priB; x:=8; y:=6; (* pawn can promote, exit loop *)
(*$ IF Test0 *)  WRITELNF(s(' fpB felt=')+l(n)+s(' posi=')+l(posi)); (*$ ENDIF *)
              END;
            END;
          END;
        END;
      END;
    END;
          
  END;

  IF TRUE (* EndGame OR (matr>alpha-200) AND (matr<beta+200)*) THEN
    (* penalty for bad development *)
    m:=-1;
    IF stilling[12]='s' THEN INC(m) END;
    IF stilling[13]='l' THEN INC(m) END;
    IF stilling[15]='m' THEN
      INC(m);
      IF stilling[16]='l' THEN wbonus:=wbonus-6; END;
    END;
    IF stilling[16]='l' THEN INC(m) END;
    IF stilling[17]='s' THEN INC(m) END;
    IF stilling[24]='b' THEN INC(m) END;
    IF stilling[25]='b' THEN INC(m) END;
    IF m>0 THEN wbonus:=wbonus-m*17 END;
    m:=-1;
    IF stilling[82]='S' THEN INC(m) END;
    IF stilling[83]='L' THEN INC(m) END;
    IF stilling[85]='M' THEN
      INC(m);
      IF stilling[86]='L' THEN bbonus:=bbonus-6 ; END;
    END;
    IF stilling[86]='L' THEN INC(m) END;
    IF stilling[87]='S' THEN INC(m) END;
    IF stilling[74]='B' THEN INC(m) END;
    IF stilling[75]='B' THEN INC(m) END;
    IF m>0 THEN bbonus:=bbonus-m*17 END;

(*$ IF Test0 *)
  tst2('Eval:',stilling,'K');
(*$ ENDIF *)

    IF Sort THEN
(*$ IF Test *) WRITELNF(s(' !!SORT!! ')); (*$ ENDIF *)
  
      res:=(-matr-posi-wbonus+bbonus (* +Activity*ActivityWeight *) -inmv);
    ELSE
      res:=( matr+posi+wbonus-bbonus (* +Activity*ActivityWeight *) +inmv);
    END; (*** posi DIV 2 !!!!!!!!!****)
  ELSE
    IF Sort THEN RETURN(-matr) ELSE RETURN(matr) END;
  END;
  RETURN(res);
END Eval;

BEGIN
(*$IF Test *)
  WRITELN(s('SkakBrainEval.1'));
(*$ENDIF *)
  ToFile:=TRUE;
  FirstW:=TRUE;
  LogVersion("SkakBrainEval.def",SkakBrainEvalDefCompilation);
  LogVersion("SkakBrainEval.mod",SkakBrainEvalModCompilation);
  Allocate(pdw,SIZE(pdType));
  Assert(pdw#NIL,ADR(' pdw: Low memory! '));
  pd:=pdw;
(*$IF Test0 *)
  WRITELN(s('SkakBrainEval.pdw ')+l(SIZE(pdType)));
(*$ENDIF *)
  Allocate(pdb,SIZE(pdType));
  Assert(pdb#NIL,ADR(' pdb: Low memory! '));
(*$IF Test0 *)
  WRITELN(s('SkakBrainEval.2'));
(*$ENDIF *)
CLOSE
  Deallocate(pdw);
  Deallocate(pdb);
END SkakBrainEval.

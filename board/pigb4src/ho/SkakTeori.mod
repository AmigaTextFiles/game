IMPLEMENTATION MODULE SkakTeori;

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)
(*$ DEFINE False:=FALSE *)

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

FROM Heap IMPORT
  Allocate,Largest,Available,Deallocate;

FROM String IMPORT
  Concat,ConcatChar,Copy,Length;

FROM Conversions IMPORT
  ValToStr,StrToVal;

FROM FileSystem IMPORT
  File, FileMode, FileModeSet, Lookup, Close, ReadBytes, WriteBytes, 
  Delete, Response, ReadChar, WriteChar, GetPos, SetPos;

FROM RandomBetter IMPORT
  RND;

FROM VersionLog IMPORT
  LogVersion;

FROM SkakBase IMPORT
  HvisTur,      (* Stilling[HvisTur] indikerer om H eller S er i trækket *)
  STILLINGTYPE, (* ARRAY[-10..HvisTur] OF CHAR; A1-H8=11-88, HvidSort='H' | 'S' *)
  TraekNr,      (* 0..MaxTraek *)
  MaxTraek,     (* 0..MaxPartiLaengde *)
  LotMemOn,
  TFra,TTil,    (* The top (recommended) move by theory tree *)
  valuetype,valuetypePtr,felttype,briktype,traektype,nodeptr,node,
  L1b;

FROM SkakSprog IMPORT
  Q;

FROM SkakBrain IMPORT
  MaxHalvTraek, (*p.t.600*)
  DoMoveC,      (* move Checked moves *)
  STILLREC,     (* Fra,Til,Tekst *)
  SPIL,         (* ARRAY[0..MaxHalvTraek] OF STILLREC (TYPE) *)
  Spil,         (* POINTER TO ARRAY[0..MaxHalvTraek] OF STILLREC; [0]=udgangsstilling *)
  start,        (* Equal(DefStill,start.Still) *)
  stilling,      
  still;
FROM SkakFil IMPORT
  LP;

(*$IF Test *)
  FROM W IMPORT
    WRITELN, WRITE, CONCAT, s, l, lf, c, READs, b;
(*$ENDIF *)

CONST
  SkakTeoriModCompilation="320";

  ht='t';st='T'; (* Hvid/sort Tårn *)
  hr='r';sr='R'; (* Hvid/sort Rokadeberettiget tårn*)
  hl='l';sl='L'; (* Hvid/sort Løber*)
  hs='s';ss='S'; (* Hvid/sort Springer*)
  hk='k';sk='K'; (* Hvid/sort Konge*)
  hm='m';sm='M'; (* Hvid/sort Majestæt (rokadeberettiget konge) *)
  hd='d';sd='D'; (* Hvid/sort Dronning *)
  hb='b';sb='B'; (* Hvid/sort Bonde *)
  he='e';se='E'; (* Hvid/sort Enpassantslagbar bonde *)
  tom=' ';kant='.';(* Tomt felt/Kant felt (udenfor brædt) *)

  TeoMvNr       =301;   (* '  MvNr:'          301-311 Sprog*)
  TeoNodes      =302;   (* 'Nodes:' *)
  TeoT          =303;   (* 'T' *)
  TeoF          =304;   (* 'F' *)
  TeoTeo        =305;   (* ' Teo=' *)
  TeoVari       =306;   (* 'Vari=' *)
  TeoStat       =307;   (* ' Stat=' *)
  TeoNoTeo      =308;   (* '- No theory -           ' *)
  TeoTotal      =309;   (* 'TOTAL:  ' *)
  TeoBest       =310;   (* 'BEST:   ' *)
  TeoEnd        =311;   (* '- End of theory -       ' *)

(* 5-98: now dynamic alloc extension works, the values are lowered to spare ram *)
  minnodecnt=  1000; (* 25000*)
  maxnodecnt= 64000; (*400000*)
  minfree   = 70000;     (* minimum ram free after alloc *)
TYPE
  STRING=ARRAY[0..80] OF CHAR;
  STR25=ARRAY[0..25] OF CHAR;
  STRINGptr=POINTER TO STRING;

(*$IF False *) (* commented out (now in SkakBase.def): *)
  valuetype=RECORD
              white:SHORTCARD; (* 255=100%,  draw=255-white-black *)
              black:SHORTCARD;
              count :CARDINAL;   (* count of Games *)
            END;
  valuetypePtr=POINTER TO valuetype;
  felttype =SHORTINT;
  briktype =CHAR;
  traektype=RECORD
              fra,til : felttype;
            END;
  nodeptr  =POINTER TO node;
  node     =RECORD
              link :nodeptr;    (*Linked liste af mulige (iflg. teori) træk*)
              naest:nodeptr;    (*Næste stilling (efter træk)*)
              traek:traektype;  (* .fra .til SHORTINT*)
              value:valuetype;  (* Stillings bedømmelse efter træk*)
            END;
(*$ENDIF *)

  varianttype=ARRAY[0..MaxHalvTraek] OF traektype;
  varptrtype=ARRAY[0..MaxHalvTraek] OF nodeptr;
 
  dat      =ARRAY[0..1000000] OF node; (* max: 16Mb ram*)
  datptr   =POINTER TO dat;


CONST
(*         
           ---------------------
          |1-0######1/2######0-1|
          |                     |
          |   +-           -+   |
          |                     |
          |      +=  =  -=      |
          |                     |
          |          ~          |
           ---------------------
*)
  afgsort    = valuetype{white:  5,black:237,count:1};   (*  3% NAG21  --  *)
  storsort   = valuetype{white: 12,black:162,count:1};   (* 20% NAG19  -+  *)
  midsort    = valuetype{white: 32,black:132,count:1};   (* 35% NAG17  --= *)
  lillesort  = valuetype{white: 62,black:100,count:1};   (* 42% NAG15  -=  *)
  lillesortu = valuetype{white: 66,black: 95,count:1};   (*     (8)    -~  *)
  uklart     = valuetype{white: 95,black: 95,count:1};   (* 49% NAG13  ~   *)
  uafsluttet = valuetype{white: 85,black: 85,count:1};   (*     (7)    *   *)
  ligeu      = valuetype{white: 80,black: 80,count:1};   (*     (10)   =~  *)
  lige       = valuetype{white: 60,black: 60,count:1};   (* 50% NAG12  =   *)
  ligestille = valuetype{white: 40,black: 40,count:1};   (* 50% NAG11  ==  *)
  lillehvidu = valuetype{white: 95,black: 66,count:1};   (*     (9 )   +~  *)
  lillehvid  = valuetype{white:100,black: 62,count:1};   (* 57% NAG14  +=  *)
  midhvid    = valuetype{white:132,black: 32,count:1};   (* 65% NAG16  ++= *)
  storhvid   = valuetype{white:162,black: 12,count:1};   (* 80% NAG18  +-  *)
  afghvid    = valuetype{white:237,black:  5,count:1};   (* 96% NAG20  ++  *)

  sortvind   = valuetype{white:  0,black:255,count:1};   (*  0% (4)   0-1 *)
  remis      = valuetype{white:  0,black:  0,count:1};   (* 50% (5)   1/2 *)
  hvidvind   = valuetype{white:255,black:  0,count:1};   (*100% (6)   1-0 *)

  empty      = valuetype{white: 85,black: 85,count:1};

  niltraek   = traektype{fra:10, til:10};

  a8=81;b8=82;c8=83;d8=84;e8=85;f8=86;g8=87;h8=88;
  a7=71;b7=72;c7=73;d7=74;e7=75;f7=76;g7=77;h7=78;
  a6=61;b6=62;c6=63;d6=64;e6=65;f6=66;g6=67;h6=68;
  a5=51;b5=52;c5=53;d5=54;e5=55;f5=56;g5=57;h5=58;
  a4=41;b4=42;c4=43;d4=44;e4=45;f4=46;g4=47;h4=48;
  a3=31;b3=32;c3=33;d3=34;e3=35;f3=36;g3=37;h3=38;
  a2=21;b2=22;c2=23;d2=24;e2=25;f2=26;g2=27;h2=28;
  a1=11;b1=12;c1=13;d1=14;e1=15;f1=16;g1=17;h1=18;

VAR
  oldptr:nodeptr;       (*peger på sidste teori-træk*)
  teoriptr:nodeptr;     (*peger på head-node*)
  stillptr:nodeptr;     (*peger på node hvis træk giver nuværende stilling*)
  testptr,tstptr:nodeptr;
  nodenr:LONGINT;       (*antal noder i alt (ud over startstilling i 0) *)
  varptr:varptrtype;    (*pointerliste til de træk i partiet der giver stilling*)
  variant,varifound:varianttype;
  traekfound,TrNr:INTEGER;
  WhiteDrawValue,BlackDrawValue:CARDINAL;
  Dptr:datptr;

  Str:ARRAY[0..1000] OF CHAR;

PROCEDURE VluToStr(Value:INTEGER):ADDRESS;
BEGIN
  CASE Value OF
  | 21: RETURN(ADR('-- '));
  | 19: RETURN(ADR('-+ '));
  | 17: RETURN(ADR('--='));
  | 15: RETURN(ADR('-= '));
  | 8 : RETURN(ADR('-~ '));
  | 13: RETURN(ADR('~  '));
  | 7 : RETURN(ADR('*  '));
  | 10: RETURN(ADR('=~ '));
  | 12: RETURN(ADR('=  '));
  | 11: RETURN(ADR('== '));
  | 9 : RETURN(ADR('+~ '));
  | 14: RETURN(ADR('+= '));
  | 16: RETURN(ADR('++='));
  | 18: RETURN(ADR('+- '));
  | 20: RETURN(ADR('++ '));
  | 4 : RETURN(ADR('0-1'));
  | 5 : RETURN(ADR('1/2'));
  | 6 : RETURN(ADR('1-0'));
  | 3 : RETURN(ADR('pgn'));
  ELSE
    RETURN(ADR('   '));
  END;
END VluToStr;

PROCEDURE StrToVlu(S:ARRAY OF CHAR):INTEGER;
BEGIN
  IF    S[0]='-' THEN
    IF S[1]='-' THEN
      IF S[2]='=' THEN
        RETURN(17);
      ELSE
        RETURN(21);
      END;
    ELSIF S[1]='+' THEN
      RETURN(19);
    ELSIF S[1]='=' THEN
      RETURN(15);
    ELSIF S[1]='~' THEN
      RETURN(8);
    ELSE
      RETURN(1);
    END;
  ELSIF S[0]='+' THEN
    IF S[1]='+' THEN
      IF S[2]='=' THEN
        RETURN(16);
      ELSE
        RETURN(20);
      END;
    ELSIF S[1]='-' THEN
      RETURN(18);
    ELSIF S[1]='=' THEN
      RETURN(14);
    ELSIF S[1]='~' THEN
      RETURN(9);
    ELSE
      RETURN(1);
    END;
  ELSIF S[0]='=' THEN
    IF S[1]='=' THEN
      RETURN(11);
    ELSIF S[1]='~' THEN
      RETURN(9);
    ELSE
      RETURN(12);
    END;
  ELSIF S[0]='*' THEN
    RETURN(7);
  ELSIF S[0]='~' THEN
    RETURN(13);
  ELSIF (S[0]='0') & (S[1]='-') & (S[2]='1')  THEN
     RETURN(4);
  ELSIF S[0]='1' THEN
    IF (S[1]='-') & (S[2]='0') THEN
      RETURN(6);
    ELSIF (S[1]='/') & (S[2]='2') THEN
      RETURN(5);
    ELSE
      RETURN(1);
    END;
  ELSE
    RETURN(0);
  END;
END StrToVlu;

PROCEDURE BetterWhite(VAR a,b:valuetype;delta:CARDINAL):BOOLEAN;
VAR
  av,bv:LONGINT;
BEGIN;
  av:=a.white*CARDINAL(101)+(255-a.white-a.black)*WhiteDrawValue;
  bv:=b.white*CARDINAL(101)+(255-b.white-b.black)*WhiteDrawValue;
  IF av>25000 THEN delta :=delta*3 DIV 2; END;
(*$IF Test0 *)
   WRITELN(s('BW: W:')+l(a.white)+s(' D:')+l(255-a.white-a.black)+s(' B:')+l(a.black)+s(' > W:')+l(b.white)+s(' D:')+l(255-b.white-b.black)+s(' B:')+l(b.black)+s(' = ')+bb(av>bv));
(*$ENDIF *)
  RETURN(av>bv+LONGINT(delta));
END BetterWhite;

PROCEDURE BetterBlack(VAR a,b:valuetype;delta:CARDINAL):BOOLEAN;
VAR
  av,bv:LONGINT;
BEGIN
  av:=a.black*101+(255-a.white-a.black)*BlackDrawValue;
  bv:=b.black*101+(255-b.white-b.black)*BlackDrawValue;
  IF av>25000 THEN delta :=delta*3 DIV 2; END;
(*$IF Test0 *)
   WRITELN(s('BB: W:')+l(a.white)+s(' D:')+l(255-a.white-a.black)+s(' B:')+l(a.black)+s(' > W:')+l(b.white)+s(' D:')+l(255-b.white-b.black)+s(' B:')+l(b.black)+s(' = ')+bb(av>bv));
(*$ENDIF *)
  RETURN(av>bv+LONGINT(delta));
END BetterBlack;

PROCEDURE ConcatValue(VAR Str:ARRAY OF CHAR; value:valuetype);
VAR
  m:INTEGER;
  err:BOOLEAN;
  st:STR25;
BEGIN
  ValToStr(value.white*100 DIV 255,FALSE,st,10,2,' ',err);
  m:=Length(st);
  Concat(Str,st);ConcatChar(Str,'/');
  IF CARDINAL(value.white)+value.black<256 THEN
    ValToStr((255-value.white-value.black)*100 DIV 255,FALSE,st,10,2,' ',err);
  ELSE
    st:='ERR';
  END;
  m:=m+Length(st);
  Concat(Str,st);ConcatChar(Str,'/');
  ValToStr(value.black*100 DIV 255,FALSE,st,10,2,' ',err);
  m:=m+Length(st);
  Concat(Str,st);
  IF m<7 THEN
    ConcatChar(Str,' ');
  END;
  ValToStr(value.count,FALSE,st,10,5,' ',err);
  Concat(Str,st);
END ConcatValue;

PROCEDURE ConcatMove(VAR Str:ARRAY OF CHAR;sptr:nodeptr);
VAR
  c1,brik:CHAR;
  err:BOOLEAN;
  st:STR25;
BEGIN
  ValToStr(sptr^.traek.fra,FALSE,st,10,3,' ',err);
  c1:=CHR(ORD(st[2])+48);
  st[2]:=st[1];
  st[1]:=c1;
  brik:=CAP(stilling[sptr^.traek.fra]);
  IF brik='B' THEN
    st[0]:=' ';
  ELSIF brik='M' THEN
    st[0]:=LP('K');
  ELSIF brik='R' THEN
    st[0]:=LP('T');
  ELSE
    st[0]:=LP(brik);
  END;
  Concat(Str,st);
  IF stilling[sptr^.traek.til]=' ' THEN
    ConcatChar(Str,'-');
  ELSE
    ConcatChar(Str,'x');
  END;
  ValToStr(sptr^.traek.til,FALSE,st,10,2,' ',err);
  c1:=CHR(ORD(st[1])+48);
  st[1]:=st[0];
  st[0]:=c1;
  Concat(Str,st);ConcatChar(Str,' ');
  ConcatValue(Str,sptr^.value);
  Concat(Str,' \n');
END ConcatMove;

PROCEDURE NodeInfo(nptr:nodeptr);
CONST
  maxn=16;
  maxvisible=11; (* two moves less than maxvisible shown *)
VAR
  sptr:nodeptr;
  err,Black,chg:BOOLEAN;
  st:STR25;
  d:ARRAY[3..maxn] OF RECORD (* d[maxn] used for swap buffer *)
    str:STR25;
    val:valuetype;
    trk:traektype
  END;
  n,m,p:INTEGER;
  games,gamenr:LONGINT;
BEGIN
  TFra:=0;
  TTil:=0;
  ValToStr(nodenr,FALSE,st,10,4,' ',err);
  Copy(Str,Q[TeoNodes]^); Concat(Str,st);Concat(Str,Q[TeoMvNr]^);
  ValToStr(TrNr,FALSE,st,10,3,' ',err);
  Concat(Str,st);Concat(Str,'  \n');
  Concat(Str,Q[TeoVari]^);
  IF Variant THEN
    Concat(Str,Q[TeoT]^);
  ELSE
    Concat(Str,Q[TeoF]^);
  END;
  Concat(Str,Q[TeoTeo]^);
  IF Teori THEN
    Concat(Str,Q[TeoT]^);
  ELSE
    Concat(Str,Q[TeoF]^);
  END;
  Concat(Str,Q[TeoStat]^);
  IF Statistic THEN
    Concat(Str,Q[TeoT]^);
  ELSE
    Concat(Str,Q[TeoF]^);
  END;
  Concat(Str,' \n');
  n:=3;
  IF nptr=NIL THEN
    Concat(Str,Q[TeoNoTeo]^);
  ELSE
    IF Statistic THEN
      Concat(Str,Q[TeoTotal]^);
    ELSE
      Concat(Str,Q[TeoBest]^);
    END;
    ConcatValue(Str,nptr^.value);
    Concat(Str,'         \n');
    sptr:=nptr^.naest;
    IF (sptr<>NIL) & (sptr^.traek.fra=niltraek.fra)
    & (sptr^.traek.til=niltraek.til) THEN (* skip if niltraek *)
      sptr:=sptr^.naest;
    END;
    IF sptr=NIL THEN
      Concat(Str,Q[TeoEnd]^);
      INC(n);
    ELSE

      (* make list in array d *)
      games:=0;
      REPEAT
        d[n].str[0]:=' ';d[n].str[1]:=0C;
        ConcatMove(d[n].str,sptr);
        d[n].trk:=sptr^.traek;
        d[n].val:=sptr^.value;
        games:=games+LONGINT(d[n].val.count);
        sptr:=sptr^.link;
        INC(n);
      UNTIL (sptr=NIL) OR (n=maxn);
      gamenr:=RND(games);

      (* sort Array d *)
      m:=4;
      Black:=stilling[HvisTur]='S';
      chg:=TRUE;
      WHILE chg & (m<n) DO

(*$IF Test0 *)
   WRITELN(s('boble: ')+l(n-1)+s(' to ')+l(m)+s(' Black=')+b(Black));
(*$ENDIF *)
        chg:=FALSE;
        FOR p:=n-1 TO m BY -1 DO
          IF Black & BetterBlack(d[p].val,d[p-1].val,0)
          OR ~Black & BetterWhite(d[p].val,d[p-1].val,0) THEN (* swap *)
            d[16]:=d[p];
            d[p]:=d[p-1];
            d[p-1]:=d[16];
            chg:=TRUE;
          END;
        END;
        INC(m);
      END;

      (* Give the best move as proposal to engine *)
      (*
      TFra:=d[3].trk.fra;
      TTil:=d[3].trk.til;
      *)

      (* copy to array d to Str *)
      games:=0;
      chg:=FALSE;
      FOR m:=3 TO n-1 DO
        games:=games+LONGINT(d[m].val.count);
        IF ~chg & (games>gamenr) THEN
          (* give the frequency-weighted random move as propolsal to engine *)
          (* but use best move if too lousy value! 10% diff. = 2550*)
          IF (m>3) & (Black & ((d[m].val.black*101+(255-d[m].val.white-d[m].val.black)*BlackDrawValue<6000)
                               OR BetterBlack(d[3].val,d[m].val,12000))
                  OR ~Black & ((d[m].val.white*101+(255-d[m].val.white-d[m].val.black)*WhiteDrawValue<6000)
                               OR BetterWhite(d[3].val,d[m].val,12000))) THEN
            TFra:=d[3].trk.fra;
            TTil:=d[3].trk.til;
          ELSE
            TFra:=d[m].trk.fra;
            TTil:=d[m].trk.til;
          END;
         
          chg:=TRUE;
        END;
        IF m<=maxvisible THEN Concat(Str,d[m].str); END;
      END; 
      
    END;
  END;
  FOR n:=n TO 11 DO
    Concat(Str,'                        \n');
  END;
END NodeInfo;

PROCEDURE setudgangsstilling;
BEGIN
(*$IF Test *)
   WRITELN(s('setudgangsstilling: '));
(*$ENDIF *)
  stillptr:=teoriptr;
  Variant:=TRUE;
  Teori:=TRUE;
END setudgangsstilling;

VAR
  nodecnt:LONGINT; (* how many nodes allocated in Dptr *)

PROCEDURE AllocateN(VAR ptr:nodeptr);
VAR
  p:datptr;
  n,offset,newcnt,blockcnt:LONGINT;
BEGIN
  IF nodenr+1<nodecnt THEN
    nodenr:=nodenr+1;
    ptr:=ADR(Dptr^[nodenr]);
  ELSE
    ptr:=NIL;

    newcnt:=nodecnt*2;
    IF newcnt>1000000 THEN newcnt:=1000000 END;
    blockcnt:=Largest(FALSE) DIV SIZE(node);
    IF (blockcnt<newcnt) & (blockcnt>nodecnt+100) THEN newcnt:=blockcnt; END;
    IF  blockcnt>=newcnt THEN
(*$IF Test *) WRITELN(s('1.Dptr=')+l(ADDRESS(Dptr)));(*$ENDIF *)
      p:=Dptr;
      Allocate(Dptr,newcnt*SIZE(node));
(*$IF Test *) WRITELN(s('2.Dptr=')+l(ADDRESS(Dptr)));(*$ENDIF *)
      IF (Dptr=NIL) THEN
        Dptr:=p;
      ELSE
        nodecnt:=newcnt;
        offset:=LONGINT(Dptr)-LONGINT(p);
(*$IF Test *)
   WRITELN(s('AllocateN: *(2), offset=')+l(offset));
(*$ENDIF *)
        FOR n:=0 TO nodenr DO
          Dptr^[n]:=p^[n];
(*$IF Test0 *) WRITELN(s('3.naest=')+l(ADDRESS(Dptr^[n].naest)));(*$ENDIF *)
          IF Dptr^[n].naest<>NIL THEN
            Dptr^[n].naest:=ADDRESS(LONGINT(Dptr^[n].naest)+offset);
          END;
(*$IF Test0 *) WRITELN(s('4.naest=')+l(ADDRESS(Dptr^[n].naest)));(*$ENDIF *)
          IF Dptr^[n].link<>NIL THEN
            Dptr^[n].link:=ADDRESS(LONGINT(Dptr^[n].link)+offset);
          END;
        END;
        Deallocate(p);
        nodenr:=nodenr+1;
        ptr:=ADR(Dptr^[nodenr]);
        teoriptr:=ADDRESS(Dptr);
(*$IF Test *) WRITELN(s('5.Dptr=')+l(ADDRESS(Dptr)));(*$ENDIF *)
        (*stillptr:=NIL;*)
        IF stillptr<>NIL THEN
          stillptr:=ADDRESS(LONGINT(stillptr)+offset);
        END;
      END;
    END;

  END;
END AllocateN;

PROCEDURE AllocDptr;
BEGIN
  IF LotMemOn THEN
    nodecnt:=maxnodecnt; (* 400.000, max 6 Mb, ca 5440 games  *)
  ELSE
    nodecnt:=minnodecnt; (*  25.000, max 400kb, ca 340 games *) (* 256 games = 18200 nodes *)
  END;
  IF Available(FALSE)-minfree<nodecnt*SIZE(node) THEN
     nodecnt:=(Available(FALSE)-minfree) DIV SIZE(node);
  END;
  IF Largest(FALSE)<nodecnt*SIZE(node) THEN
     nodecnt:=Largest(FALSE) DIV SIZE(node);
  END;
  Allocate(Dptr,nodecnt*SIZE(node));
  IF Dptr=NIL THEN
    nodecnt:=0;
  ELSE
    nodenr:=-1;
    AllocateN(teoriptr);
    teoriptr^.link:=NIL;      (*head-node laves*)
    teoriptr^.traek.fra:=a4;
    teoriptr^.traek.til:=a4;
    teoriptr^.naest:=NIL;
    teoriptr^.value:=lige;
    setudgangsstilling;
  END;
END AllocDptr;

(* inserts as LAST in move-chain, returns a ptr to the newnode in stiptr *)
PROCEDURE nynode(traek:traektype; Value:valuetype; VAR stiptr:nodeptr):BOOLEAN;
VAR
  linkptr:nodeptr;
BEGIN
  IF Dptr=NIL THEN
    AllocDptr;
  END;
  IF (teoriptr<>NIL) & (Dptr<>NIL) & (stillptr<>NIL) THEN
    AllocateN(stiptr);
    IF stiptr<>NIL THEN
(*$IF Test *)
WRITELN(s('nynode: ')+l(traek.fra)+s('-')+l(traek.til)+s(' nodenr: ')+l(nodenr));
(*$ENDIF *)
      stiptr^.traek:=traek;
      stiptr^.naest:=NIL;
      stiptr^.value:=Value;
      stiptr^.link:=NIL;
      IF stillptr^.naest=NIL THEN (* insert as next *)
        stillptr^.naest:=stiptr;
      ELSE                        (* insert as last in next-chain *)
        linkptr:=stillptr^.naest;
        WHILE linkptr^.link<>NIL DO
          linkptr:=linkptr^.link;
        END;
        linkptr^.link:=stiptr;
      END;
(*$IF Test *)
WRITELN(s('nynode:T '));
(*$ENDIF *)
      RETURN(TRUE);
    END;
  END;
  RETURN(FALSE);
END nynode;

PROCEDURE init;
VAR
  felt:felttype;
BEGIN
  teoriptr:=NIL;
  Statistic:=FALSE;
  Teori:=FALSE;
  nodenr:=0;
  Dptr:=NIL;
END init;

PROCEDURE ClrTeori;
BEGIN
  Deallocate(Dptr);
  init;
END ClrTeori;

PROCEDURE GetDrawWhite(VAR Value:CARDINAL); (* 1..99 *)
BEGIN
  Value:=WhiteDrawValue;
END GetDrawWhite;

PROCEDURE GetDrawBlack(VAR Value:CARDINAL); (* 1..99 *)
BEGIN
  Value:=BlackDrawValue;
END GetDrawBlack;

PROCEDURE lavtraek(traek:traektype):BOOLEAN;
VAR
  tptr:nodeptr;
BEGIN
(*$IF Test *)
   WRITELN(s('lavtraek: '));
(*$ENDIF *)
  tptr:=NIL;
  IF ~(stillptr=NIL) THEN (*søg; og flyt pointere, hvis træk kendes*)
    tptr:=stillptr^.naest;
    WHILE ~(tptr=NIL) AND ((tptr^.traek.fra<>traek.fra)
    OR (tptr^.traek.til<>traek.til)) DO
      tptr:=tptr^.link;
    END;
  END;
  IF tptr<>NIL THEN
    stillptr:=tptr;
    RETURN(TRUE);
  END;
  RETURN(FALSE);
END lavtraek;

PROCEDURE soegstilling(stilling:STILLINGTYPE;VAR nptr:nodeptr; notptr:nodeptr);
BEGIN (*soegstilling*)
(*$IF Test *)
   WRITELN(s('søgstilling'));
(*$ENDIF *)
  nptr:=NIL;
END soegstilling;

(* Hvis stilling er fundet vil nptr pege på den
   , så er traekfound=count og varifound=variant *)
PROCEDURE soegstillingNew(stilling:STILLINGTYPE;VAR nptr,notptr:nodeptr);
VAR
  tst:STILLINGTYPE;
  tnr:INTEGER;
  tptr:nodeptr;
  vart:varianttype;
  drop:BOOLEAN;
PROCEDURE trkall(tptr:nodeptr;tnr:INTEGER;otst:STILLINGTYPE);
VAR
  ttst:STILLINGTYPE;
  ft:felttype;
  n,sort:INTEGER;
BEGIN
(*$IF Test *)
  IF tptr<>NIL THEN
    WRITELN(s('tnr=')+l(tnr)+s(' fra-til=')+l(tptr^.traek.fra)+s(',')+l(tptr^.traek.til));
  END;
(*$ENDIF *)
  WHILE ~(tptr=NIL) AND (nptr=NIL) DO
    drop:=FALSE;
    tst:=otst; (*Afskær søgningen ved hjælp af bonde-check*)
               (*kan vel udvides med check af RrMm *)
    IF tst[tptr^.traek.fra]=hb THEN
      IF (tptr^.traek.fra>=a2) & (tptr^.traek.fra<=h2) THEN
        IF stilling[tptr^.traek.fra]=hb THEN
          drop:=TRUE;
(*$IF Test *)
   WRITELN(s('drop hb'));
(*$ENDIF *)
        END;
      END;
    END;
    IF tst[tptr^.traek.fra]=sb THEN
      IF (tptr^.traek.fra>=a7) & (tptr^.traek.fra<=h7) THEN
        IF stilling[tptr^.traek.fra]=sb THEN
          drop:=TRUE;
(*$IF Test *)
   WRITELN(s('drop sb'));
(*$ENDIF *)
        END;
      END;
    END;
    varptr[tnr]:=tptr;
    IF ODD(tnr) THEN
      sort:=1
    ELSE
      sort:=0; (*check FOR trækgentagelse: *)
    END;
    FOR n:=0 TO tnr DIV 2 -1 DO
      IF tptr=varptr[n*2+sort] THEN
        drop:=TRUE;
(*$IF Test *)
   WRITELN(s('drop rep.'));
(*$ENDIF *)
      END;
    END;
    IF ~drop THEN
      DoMoveC(tst,tptr^.traek.fra,tptr^.traek.til);
      vart[tnr]:=tptr^.traek;
      ft:=a1;
      (*sammenlign om den samme er i trækket i begge stillinger (tst,stilling)*)
      IF ODD(tnr)=ODD(TrNr) THEN
        (*sammenlign tst med stilling og sæt nptr hvis ens*)
        WHILE (ft<=h8) & (tst[ft]=stilling[ft]) DO
          ft:=ft+1;
        END;
        IF ft>h8 THEN
(*$IF Test *)
   WRITELN(s('Equals!'));
(*$ENDIF *)
          IF tptr<>notptr THEN
            nptr:=tptr;
            traekfound:=tnr;
            varifound:=vart;
            drop:=TRUE;
          END;
        END;
      END;
      IF ~drop THEN
        trkall(tptr^.naest,tnr+1,tst);
      END;
    END;
    tptr:=tptr^.link;
  END;
END trkall;
BEGIN (*soegstilling*)
(*$IF Test *)
   WRITELN(s('søgstilling'));
(*$ENDIF *)
  tnr:=0;
  nptr:=NIL;
  IF (teoriptr=NIL) OR (teoriptr^.naest=NIL) THEN
    traekfound:=tnr;
  ELSE
    tst:=start.Still;
    tptr:=teoriptr;
    varptr[0]:=tptr;
    trkall(tptr^.naest,tnr+1,tst);
  END;
END soegstillingNew;

PROCEDURE Update;
VAR
  n:INTEGER;
  trk:traektype;
  nptr,notptr:nodeptr;
BEGIN
(*$IF Test *)
   WRITELN(s('Update'));
(*$ENDIF *)
  n:=1;
  setudgangsstilling;
(*$IF Test *)
   WRITELN(s('Update,satudg'));
(*$ENDIF *)
  trk.fra:=Spil^[n].Fra;
  trk.til:=Spil^[n].Til;
  WHILE (n<=TraekNr) & lavtraek(trk) DO
    INC(n);
    trk.fra:=Spil^[n].Fra;
    trk.til:=Spil^[n].Til;
  END;
  IF n<=TraekNr THEN
    Variant:=FALSE;
(*$IF Test *)
   WRITELN(s('Update, Soegstilling...'));
(*$ENDIF *)
    notptr:=NIL;
    soegstilling(stilling,nptr,notptr);
    IF nptr=NIL THEN
      Teori:=FALSE;
    END;
    stillptr:=nptr;
  END;
(*$IF Test *)
   WRITELN(s('Update,slut'));
(*$ENDIF *)
END Update;

(*$IF Test *)
PROCEDURE bb(f:BOOLEAN):CARDINAL;
BEGIN
  RETURN(b(f));
END bb;
(*$ENDIF *)

(* min-max'er alt teori fra tptr *)
PROCEDURE regn(tptr:nodeptr;tnr:INTEGER):valuetypePtr;
VAR
  fbedst:valuetype;
  temp:valuetype;
  tstptr:nodeptr;
  sortf,drop:BOOLEAN;
  n,sort:INTEGER;
  Cnt,Cwh,Cbl:LONGCARD;
(*$IF Test *)
  ja :BOOLEAN;
(*$ENDIF *)
BEGIN
(*$IF Test *)
   ja:=(tnr>349) & (tnr<353);
   IF ja THEN WRITELN(s('regn: ')+l(tnr)); END;
(*$ENDIF *)
  IF tptr=NIL THEN RETURN(NIL) END;
  varptr[tnr]:=tptr;
  IF ~(tptr^.naest=NIL) & (tnr<MaxHalvTraek) THEN
    (* linked list med mindst een node *)
    tstptr:=tptr^.naest;
    IF (tstptr^.traek.fra=niltraek.fra) & (tstptr^.traek.til=niltraek.til) THEN
      tstptr:=tstptr^.link; (* skip found nil-node *)
    END;
    IF tstptr<>NIL THEN
      sortf:=ODD(tnr);
      Cnt:=0;
      Cwh:=0;
      Cbl:=0;
      IF sortf THEN
        IF ~Statistic THEN fbedst:=hvidvind END;
        sort:=1;
      ELSE
        IF ~Statistic THEN fbedst:=sortvind END;
        sort:=0;
      END;
      WHILE ~(tstptr=NIL) DO (*hvis flere END een node så find bedste*)
        varptr[tnr]:=tstptr;
        drop:=FALSE;                   (*check FOR trækgentagelse, så lige*)
        FOR n:=0 TO tnr DIV 2 -1 DO
          IF tstptr=varptr[n*2+sort] THEN
            drop:=TRUE;
  (*$IF Test0 *)
     WRITELN(s('regn:REPt-STILL '));
  (*$ENDIF *)
          END;
        END;
        IF drop THEN
          temp:=remis
        ELSE
          temp:=regn(tstptr,tnr+1)^;
        END;
        IF Statistic THEN
          Cwh:=Cwh+LONGCARD(tstptr^.value.white)*tstptr^.value.count;
          Cbl:=Cbl+LONGCARD(tstptr^.value.black)*tstptr^.value.count;
        ELSE
          IF sortf THEN
            IF BetterBlack(temp,fbedst,0) THEN
    (*$IF Test0 *)
       WRITELN(s('regn: BetterBlack'));
    (*$ENDIF *)
              fbedst:=temp;
            END;
          ELSE
            IF BetterWhite(temp,fbedst,0) THEN
    (*$IF Test0 *)
       WRITELN(s('regn: BetterWhite'));
    (*$ENDIF *)
              fbedst:=temp;
            END;
          END;
        END;
        Cnt:=Cnt+tstptr^.value.count;
        tstptr:=tstptr^.link;
      END;
      IF Cnt>65535 THEN fbedst.count:=65535 ELSE fbedst.count:=Cnt; END;
(*$IF Test *)
   IF ja THEN WRITELN(s('regn, Cnt: ')+l(Cnt)); END;
(*$ENDIF *)
      IF Statistic THEN
        IF Cnt>0 THEN 
          fbedst.white:=Cwh DIV Cnt;
          fbedst.black:=Cbl DIV Cnt;
        ELSE
          fbedst:=uklart;
        END;
      END;
      tptr^.value:=fbedst;
    END;
  END;
  RETURN(ADR(tptr^.value));
END regn;

PROCEDURE ReCalc(StatisticOn:BOOLEAN);
BEGIN
  Statistic:=StatisticOn;
  IF (regn(teoriptr,0)=NIL) THEN END;
END ReCalc;

(* 0=NonAlloc, 1=NotOpened, 2=NotSK30, 3=NotRead, 4=NotComplete, 5=OK *)
PROCEDURE LoadTeori(navn:ARRAY OF CHAR):CARDINAL;
VAR
  f:File;
  no:node;
  np:nodeptr;
  actual,nonr,gamenr:LONGINT;
  n,OK:CARDINAL;
  lastnodeadr,h1,h2:LONGINT;
  id:ARRAY[0..3] OF CHAR;
(*$IF Test *)
  h3,h4:LONGINT;
(*$ENDIF *)

BEGIN
  OK:=0;
  IF Dptr=NIL THEN
    AllocDptr;
  END;
  IF Dptr<>NIL THEN
    OK:=1;
    Lookup(f,navn,16384,FALSE);
    IF f.res=done THEN
      OK:=2;
      ReadBytes(f,ADR(id),4,actual);
      IF (actual=4) & (id[0]='S') & (id[1]='K') & (id[2]='3') & (id[3]='0') THEN
        OK:=3;
        nodenr:=-1;
        gamenr:=0;
  (*$IF Test0 *)
     h3:=0;
  (*$ENDIF *)
        REPEAT
          ReadBytes(f,ADR(no),SIZE(node),actual);
          IF (f.res=done) & ~f.eof THEN
            OK:=4;
            INC(nodenr);
            IF no.naest<>NIL THEN
              no.naest:=ADDRESS(LONGINT(no.naest)+LONGINT(Dptr));
            ELSE;
              INC(gamenr);
            END;
            IF no.link<>NIL THEN
              no.link:=ADDRESS(LONGINT(no.link)+LONGINT(Dptr));
            END;
            IF no.value.count=0 THEN
              no.value.count:=1;
(*$IF Test *) WRITELN(s('LoadTeo, count:=1 nodenr=')+l(nodenr)); (*$ENDIF *)
            END;
  (*$IF Test0 *)
     WRITELN(s('LoadTeo, Node=')+l(nodenr)+s(' Next=')+l(LONGINT(no.naest))+s(' link=')+l(LONGINT(no.link)));
  (*$ENDIF *)
            Dptr^[nodenr]:=no;
            IF (nodenr+1>=nodecnt) THEN (* try get more allocated *)
              AllocateN(np);
              IF np<>NIL THEN (*success, un'alloc' returned node *)
                DEC(nodenr);
              END;
(*$IF Test *) WRITELN(s('LdTeo: MoreAllocated.')); (*$ENDIF *)
(*$IF Test *)
   IF Dptr^[nodenr].value.count<>no.value.count THEN
     WRITELN(s('LoadTeo, Node=')+l(nodenr)+s(' Next=')+l(LONGINT(no.naest))+s(' link=')+l(LONGINT(no.link))+s(' cnt=')+l(LONGINT(no.value.count)));
     no:=Dptr^[nodenr];
     WRITELN(s('LoadTeo, Node=')+l(nodenr)+s(' Next=')+l(LONGINT(no.naest))+s(' link=')+l(LONGINT(no.link))+s(' cnt=')+l(LONGINT(no.value.count)));
   END;
(*$ENDIF *)
            END;
          END;
        UNTIL f.eof OR (f.res<>done) OR (nodenr+1>=nodecnt);
        IF (f.res<>done) & (nodenr<0) THEN END;
        IF f.eof THEN
          OK:=5;
        ELSE 
          ReadBytes(f,ADR(no),SIZE(node),actual);
          IF f.eof THEN
            OK:=5;
    (*$IF Test *)
       WRITELN(s('extra eof chk, FOUND'))
    (*$ENDIF *)
          ELSE (* find pointers to not-loaded nodes and set to NIL*)
            lastnodeadr:=LONGINT(ADR(Dptr^[nodenr]));
    (*$IF Test *)
       WRITELN(s('not-loaded to NIL, ADDRESS(Dptr)=')+l(ADDRESS(Dptr))
              +s(' lastnodeadr=')+l(lastnodeadr)+s(' nodenr=')+l(nodenr));
       h3:=0;
       h4:=0;
    (*$ENDIF *)
            FOR nonr:=0 TO nodenr DO
              WITH Dptr^[nonr] DO
                h1:=LONGINT(naest);
                h2:=LONGINT(link);
                IF h1>lastnodeadr THEN
                  naest:=NIL;
  (*$IF Test *)
     INC(h3);
  (*$ENDIF *)
                END;
                IF h2>lastnodeadr THEN
                  link:=NIL;
  (*$IF Test *)
     INC(h4);
  (*$ENDIF *)
                END;
              END;
            END;
          END;
  (*$IF Test *)
     WRITELN(s('next-cuts(h3)=')+l(h3)+s(' link-cuts(h4)=')+l(h4)+s(' leafnodes=')+l(gamenr));
  (*$ENDIF *)
        END;
        Update;
        IF (regn(teoriptr,0)=NIL) THEN END;
  (*$IF Test *)
     WRITELN(s('LT: regnet.'));
  (*$ENDIF *)
      END;
      Close(f);       
    END;  
  END;
  RETURN(OK);
END LoadTeori;

PROCEDURE AddTeori(navn:ARRAY OF CHAR);
BEGIN
END AddTeori;

(* 0=NonAlloc, 1=NotOpened, 2=NotSK30, 3=NotOpened, 4=NotComplete, 5=OK *)
PROCEDURE SaveTeori(navn:ARRAY OF CHAR):CARDINAL;
VAR
  n,actual:LONGINT;
  no:node;
  f:File;
  id:ARRAY[0..3] OF CHAR;
  OK:BOOLEAN;
  Res:CARDINAL;
BEGIN
  Res:=0;
  IF (Dptr<>NIL) & (nodenr>0) & ((navn[0]<>'_') OR (nodenr<=10000)) THEN
    Res:=1; (* Demo version når _ (kun 10000 muligt) *)
    Lookup(f,navn,16,FALSE);
    IF f.res=done THEN
      (* if file exists, then allow overwrite, only if in SK30 format! *)
      ReadBytes(f,ADR(id),4,actual);
      Close(f);
      IF (actual=4) & (id[0]='S') & (id[1]='K') & (id[2]='3') & (id[3]='0') THEN
        OK:=TRUE;
      ELSE
        OK:=FALSE;
        Res:=2;
      END;
    ELSE
      OK:=TRUE;
    END;      
    IF OK THEN
      Lookup(f,navn,16384,TRUE);
      Res:=3;
      IF f.res=done THEN
        WriteChar(f,'S');WriteChar(f,'K');WriteChar(f,'3');WriteChar(f,'0');
        Res:=4;
        FOR n:=0 TO nodenr DO
          no:=Dptr^[n];
          IF no.naest<>NIL THEN
            no.naest:=ADDRESS(LONGINT(no.naest)-LONGINT(Dptr));
          END;
          IF no.link<>NIL THEN
            no.link:=ADDRESS(LONGINT(no.link)-LONGINT(Dptr));
          END;
          WriteBytes(f,ADR(no),SIZE(node),actual);
        END;
        IF f.res=done THEN Res:=5 END;
      END;
      Close(f);
    END;
  END;
  RETURN(Res);
END SaveTeori;

PROCEDURE SetDrawWhite(Value:CARDINAL); (* 1..99 *)
BEGIN
  IF (Value>=0) & (Value<=100) THEN
    WhiteDrawValue:=Value;
    (*$IF Test *) WRITELN(s('DrawWhite:=')+l(INTEGER(Value)));(*$ENDIF *)
    IF (regn(teoriptr,0)=NIL) THEN END;
  END;
END SetDrawWhite;

PROCEDURE SetDrawBlack(Value:CARDINAL); (* 1..99 *)
BEGIN
  IF (Value>=0) & (Value<=100) THEN
    BlackDrawValue:=Value;
    (*$IF Test *) WRITELN(s('DrawBlack:=')+l(INTEGER(Value)));(*$ENDIF *)
    IF (regn(teoriptr,0)=NIL) THEN END;
  END;
END SetDrawBlack;

(* 0=NonAlloc, 5=OK *)
PROCEDURE AddGame(Value:SHORTINT; Simple:BOOLEAN):CARDINAL;
VAR
  nr,nk:INTEGER;
  traek:traektype;
  vlu:valuetype;
  testptr,oldstillptr,notptr:nodeptr;
  OK:CARDINAL;
  MaxNewMoves:INTEGER; (* Limits how many (half) moves to add *)
  MaxMoves:INTEGER;    (* Limits how many (half) moves total *)
BEGIN
(*$IF Test *)
   WRITELN(s('AddGame: '));
(*$ENDIF *)
  OK:=5;
  MaxNewMoves := BlackDrawValue*2;
  MaxMoves    := WhiteDrawValue*2+CARDINAL(MaxNewMoves); (* to use full-moves *)

(*
MaxMoves := 999;
MaxNewMoves := 999;
*)
  IF MaxTraek>0 THEN
(*$IF Test *)   WRITELN(s('AddGame: >0 mm=')+l(MaxMoves)+s(' mnm=')+l(MaxNewMoves));(*$ENDIF *)
    CASE Value OF
    | 21: vlu:=afgsort;
    | 19: vlu:=storsort;
    | 17: vlu:=midsort;
    | 15: vlu:=lillesort;
    |  8: vlu:=lillesortu;
    | 13: vlu:=uklart;
    |  7: vlu:=uafsluttet;
    | 10: vlu:=ligeu;
    | 12: vlu:=lige;
    | 11: vlu:=ligestille;
    |  9: vlu:=lillehvidu;
    | 14: vlu:=lillehvid;
    | 16: vlu:=midhvid;
    | 18: vlu:=storhvid;
    | 20: vlu:=afghvid;
    |  4: vlu:=sortvind;
    |  5: vlu:=remis;
    |  6: vlu:=hvidvind;
    ELSE vlu:=empty;
    END;
    IF (stillptr<>NIL) & (stillptr^.naest=NIL) & (TraekNr>0) THEN
      (* If Leaf-node *)
      (*$IF Test *)   WRITELN(s('AddGame: Leaf. Just set value.'));(*$ENDIF *)
      stillptr^.value:=vlu;
    ELSE   
      setudgangsstilling;
      nr:=1;
      nk:=1; (* stores how many known moves *)
      WHILE (OK=5) & (nr<=MaxTraek) & (nr<=MaxMoves) & (nr-nk<MaxNewMoves) DO

        traek.fra:=Spil^[nr].Fra;
        traek.til:=Spil^[nr].Til;
        WHILE (nr<=MaxTraek) & (nr<MaxMoves) & lavtraek(traek) DO
          INC(nr);
          INC(nk);
          traek.fra:=Spil^[nr].Fra;
          traek.til:=Spil^[nr].Til;
        END;
(*$IF Test *)   WRITELN(s('AddGame: nr=')+l(nr)+s(' mt=')+l(MaxTraek)+s(' mm=')+l(MaxMoves));(*$ENDIF *)

        IF (nr<=MaxTraek) & (nr<=MaxMoves) THEN
(*$IF Test *)   WRITELN(s('AddGame: 12'));(*$ENDIF *)
          IF nynode(traek,vlu,notptr) THEN
            IF lavtraek(traek) THEN
              IF ~Simple THEN
                soegstilling(stilling,testptr,notptr);
                IF testptr<>NIL THEN

                  (* insert a niltraek node in found positions move-chain*)
(*$IF Test *)   WRITELN(s('AddGame: ins nil'));(*$ENDIF *)
                  IF (testptr^.naest=NIL)
                  OR (testptr^.naest^.traek.fra<>niltraek.fra)
                  OR (testptr^.naest^.traek.til<>niltraek.til) THEN
                    oldstillptr:=stillptr;
                    stillptr:=testptr;
                    IF nynode(niltraek,empty,notptr) THEN
                    END;
                    stillptr:=oldstillptr;
                  END;
                  
                  stillptr^.naest:=testptr^.naest;
                END;
              END;
              INC(nr);
            ELSE (* not possible to make move *) 
              OK:=1;
            END;
          ELSE (* no new node allocated *)
            OK:=0;
          END;
        END;
      END;
  
    (*$IF Test *)
       WRITELN(s('AddGame, lav: ')+l(nr)+s(', ')+l(nk)+s('. ')+l(traek.fra)+s('-')+l(traek.til));
    (*$ENDIF *)
    END;
  END;
  RETURN(OK);
END AddGame;

PROCEDURE FindPosition():ADDRESS;                     
BEGIN
(*$IF Test *)
   WRITELN(s('FindPosition: '));
(*$ENDIF *)
  Update;
  NodeInfo(stillptr);
  RETURN(ADR(Str));
END FindPosition;

PROCEDURE DeletePosMove(Fra,Til:SHORTINT);
BEGIN
END DeletePosMove;

PROCEDURE FindTeori();
BEGIN
END FindTeori;

BEGIN
(*$IF Test *)
  WRITELN(s('SkakTeori.1'));
(*$ENDIF *)
  WhiteDrawValue:=50;
  BlackDrawValue:=50;
  LogVersion("SkakTeori.def",SkakTeoriDefCompilation);
  LogVersion("SkakTeori.mod",SkakTeoriModCompilation);
  init;
(*$IF Test *)
  WRITELN(s('SkakTeori.2'));
(*$ENDIF *)
END SkakTeori.

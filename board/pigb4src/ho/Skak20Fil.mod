IMPLEMENTATION MODULE Skak20Fil;(* Lær-Skak, (c) E.B.Madsen DK 91-95 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Demo:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)
(*$ DEFINE False:=FALSE *)

(*$ DEFINE NoProfiler:=TRUE *) (* TRUE for fuld version !!!! (kun FALSE for test med Profiler) *)
(*$ DEFINE XchangeChk:=TRUE *) (* TRUE for chk af færre brikker ved still søg *)
(*$ LongAlign:=TRUE StackParms:=FALSE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=FALSE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=FALSE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT
  ADR, ADDRESS, ASSEMBLE, CAST, BPTR, BYTE, SHORTSET, TSIZE;
FROM Arts IMPORT 
  BreakPoint;
FROM ExecD IMPORT
  MsgPort, MsgPortPtr, MemReqSet;
FROM ExecL IMPORT
  ReplyMsg, GetMsg, AllocMem, FreeMem;
FROM IntuitionD IMPORT
  WindowPtr,IntuiText,IntuiMessagePtr,GadgetPtr, IDCMPFlagSet, IDCMPFlags;
FROM IntuitionL IMPORT
  PrintIText,CurrentTime;
FROM GraphicsD IMPORT
  RastPortPtr, DrawModeSet, DrawModes;
FROM FileSystem IMPORT
  File, FileMode, FileModeSet, Lookup, Close, ReadBytes, WriteBytes, 
  Delete, Response, ReadChar, WriteChar, GetPos, SetPos;
IMPORT FileSystem;
FROM String IMPORT
  Copy, LastPos, Length, Compare, Concat, ConcatChar, CapString, Occurs,
  Insert, FirstPos;
FROM StrSupport IMPORT
  Valid,Eq,Gt,IntVal,CardVal,UpCase,UpString,TrimString,TrimVal,in;
FROM Conversions IMPORT
  ValToStr,StrToVal;
FROM Heap IMPORT
  Allocate, Deallocate, Largest, Available;
FROM QISupport IMPORT
  SimpleWIN, TwoGadWIN, ThreeGadWIN,
  VINDUE, STRINGPTR, CREATEWIN, OPENWIN, WAITWIN, CLOSEWIN, MSGWIN, PRINTWIN,
  EscWIN, OkWIN, DropWIN, ActiveWIN, InactiveWIN, OpenInfoWIN, PrintInfoWIN,
  CloseInfoWIN, swptr, CenterWIN, MsgCloseInfoWIN;
FROM PointerSprites IMPORT
  SetPtr;
(*$IF Test *)
  FROM W IMPORT
    WRITELN, WRITE, CONCAT, s, l, lf, c, READs,b;
(*$ENDIF *)
FROM SkakBase IMPORT
  HvisTur, STILLINGTYPE, SetUpMode, Valg, StyO, StyU, VlmO, VlmU, 
  VlpO, VlpU, TraekNr, MaxTraek, sptr,
  OpAd, Simple, Debug, ReqReq, SpeakOff, MaxTeori, InterOn, (* LongFormOn, *)
  MaxExtras,
  gNIC,gAnnotator,gSource,gInfo,gEventDate,gEventSponsor,gSection,gStage,gBoard,
  gOpening,gVariation,gSubVariation,gECO,gTime,gWhiteCountry,gBlackCountry,
  STR30,
  gEvent,gSite,gDate,gRound,gWhite,gBlack,gResult,
  gWhiteTitle,gBlackTitle,gWhiteElo,gBlackElo,gWhiteUSCF,gBlackUSCF,
  gExtras,gFilters,gFlags,gLabels,gInverse,MAXLLSIZE,LLSIZE,LL,LLP,
  TextListPtr,TextList,TextListRec, STR77,
  PIGtotal,PIGdeleted,PIGlength,PIGstat0,PIGstat1,PIGstat2,PIGstat3, 
  path20,EMPROC, DATARR, LotMemOn, gExt17, gPosition, gComments,
  gMoves, gIC, gSkip, Later, path20ud, Lates3;

FROM SkakBrain IMPORT
  DoMove, GetNext, Mirror, DoMoveC, DoMoveOk, Equal, still, FindTrk, 
  MOVETYPE, MOVETYPES, MOVEnormal, MOVEslag, TRAEKDATA, TRKDATA, stVsum, Push, stilling,
  Spil, SPIL, start, STRING, STIL, MaxHalvTraek, GetMove, GetMoveNr, EatChar;
FROM VersionLog IMPORT
  LogVersion;
FROM SkakSprog IMPORT
  Txr,Txt,Txs,Txl,Txd,Txm,Txk,Txe,Txb,TxR,TxT,TxS,TxL,TxD,TxM,TxK,TxE,TxB,
  TxrI,TxtI,TxsI,TxlI,TxdI,TxmI,TxkI,TxeI,TxbI,TxRI, TxTI,TxSI,TxLI,TxDI,TxMI,
  TxKI,TxEI,TxBI,Fxs01,Fxs02,Fxs03,Fxs04,Fxs05,Fxs06,Fxs07,Fxs08,Fxs09,Fxs10,
  Fxs11,Fxs12,Fxs13,Fxs14,Fxs15,Fxs16,Fxs17,Fxs18,Q,TxForkertTegnIStilling,
  TxSPILIKKETEKST,TxLINIE,TxPOSITION,TxHALVTRAEK,TxIKKEHENTET,TxIKKESKAKFIL,
  TxIKKESKAKTXT,TxUKORREKTKUNDELVIS,HelpSt,AddHelp,Qisapigfile,TAGo,DemoMessage,
  Qwantmemory,Qgamesread,Qgamesappended,Qgamedeleted,Qf7toundelete,Qgameundeleted,
  Q214,Q215,Q216,Q217,Q218,Q219;
FROM SkakFil IMPORT
  rettetREM, rettetPGN, rettetSPIL, remWIN, pgnWIN, SetPGNinfos,
  RydSpil, FilBufferSzRead, FilBufferSzWrite, FilBufferSzBig, StartStilling,
  FENtoSTILLING, STILLINGtoFEN, LP;

CONST
  Skak20FilModCompilation="383";

TYPE
  spSTR=POINTER TO ARRAY[0..99] OF CHAR;
  DATptr=POINTER TO ARRAY[0..65535] OF SHORTCARD;
VAR
  dbf,dbfud:File;
  dbg,dbgt:DATptr; (* Ned til 1024 hvis LowMem *)
  dbgs:LONGINT; (* dbgSize *)
  dbgp,dbgpMarked:CARDINAL;
  Press7:BOOLEAN; (* 7-bits move compression ? (12% smaller) *)
  Quick:BOOLEAN; (* New move values? (faster) *) 

CONST
  MAXLLCACHESIZE=2000;
  MINLLCACHESIZE=200;
VAR
  LLCACHESIZE:CARDINAL;
  LLCACHE:ARRAY[1..MAXLLCACHESIZE] OF DATptr;
  LLCACHEsz:ARRAY[1..MAXLLCACHESIZE] OF CARDINAL;
(*

Modul Skak20Fil
~~~~~~~~~~~~~~~
Anteil|    Prozedur selbst:  |    Prozedur gesamt:  |  Anzahl  | Prozedur
  %   |   Zeit   |Zeit/Aufruf|   Zeit   |Zeit/Aufruf|  Aufrufe |
------+----------+-----------+----------+-----------+----------+---------
 39.5 |    711.2 |      0.23 |   2119.5 |      0.67 |     3145 | GetInfo
 17.8 |    319.5 |    319.54 |   4373.6 |   4373.60 |        1 | LL20
 15.2 |    272.8 |      0.09 |    272.8 |      0.09 |     3145 | GetStr
 10.3 |    186.1 |      0.06 |    597.8 |      0.19 |     3146 | GetSpil
  8.5 |    153.6 |      0.05 |    390.0 |      0.12 |     3145 | Filter20
  7.1 |    127.4 |      0.02 |    127.4 |      0.02 |     6290 | GetCard
  0.9 |     15.7 |      0.13 |    140.1 |      1.16 |      121 | WrStat
  0.7 |     12.3 |      0.13 |     24.5 |      0.26 |       96 | ConcatF
  0.1 |      1.3 |      0.66 |      7.5 |      3.73 |        2 | FreeLL
  0.0 |      0.1 |      0.07 |      2.5 |      2.51 |        1 | Alloc
  0.0 |      0.1 |      0.03 |      7.9 |      3.96 |        2 | <Skak20Fil>

Modul Skak20Fil
~~~~~~~~~~~~~~~
Anteil|    Prozedur selbst:  |    Prozedur gesamt:  |  Anzahl  | Prozedur
  %   |   Zeit   |Zeit/Aufruf|   Zeit   |Zeit/Aufruf|  Aufrufe |
------+----------+-----------+----------+-----------+----------+---------
 34.1 |    780.9 |    780.95 |  25474.8 |  25474.77 |        1 | LL20
 30.5 |    697.9 |      0.22 |   1524.2 |      0.48 |     3145 | GetInfo
 11.9 |    272.8 |      0.09 |    272.8 |      0.09 |     3145 | Filter20
 11.9 |    271.1 |      0.03 |  18819.8 |      2.03 |     9250 | GetMovet
  8.3 |    190.0 |      0.06 |    603.5 |      0.19 |     3146 | GetSpil
  2.4 |     54.4 |      0.02 |     54.4 |      0.02 |     3145 | GetCard
  0.7 |     15.3 |      0.13 |    141.4 |      1.17 |      121 | WrStat
  0.2 |      3.8 |      0.13 |      7.3 |      0.24 |       30 | ConcatF
  0.0 |      1.1 |      0.54 |      4.1 |      2.05 |        2 | FreeLL
  0.0 |      0.1 |      0.07 |      2.3 |      2.35 |        1 | Alloc
------+----------+-----------+----------+-----------+----------+---------

Test af XchangeChk på Fischer.pig (524 games, 44680 halfmoves):

                   (Træk) fil      trk     vundet
    Tidlig åbning:   (5) .aaa  1730 / 1708   1%    e4e5 sf3sc6 lb5a6 lxdx oof6
    Sen åbning:     (10) .bbb  4319 / 4166   3%
    Midspil:        (35) .ccc  9125 / 8475   4% 
    Teoretisk max:  (11) .ddd 13599 / 7001  47%
    konge-konge:   (200) .eee 44649 /44260   0%
    Slutspil TTtt:  (80) .fff 44429 /39519  11%

    XchangeChk cut-off Er altså normalt 1-11% hurtigere, men KAN afskære
    for meget på grund af under-forvandling!!! (men usansynligt)
-------------------------------------------------------------------
    Gamelength+4 max cutoff: (KAN overse hvis mere end 1 trækgentagelse)
       8x  ved Tidlig åbning
       4x  ved Sen åbning
      10%  ved Midtspil
      0.5% ved slutspil;
       
    Udgangsposition Bonde (+T+K) cut-off:
      3.2x ved Tidlig åbning
      2.6x ved Sen åbning
       4x  ved Midtspil
      <1%  ved slutspil;

    XchangeChk cut-off: (KAN overse hvis underforvandling)
       1%  ved Tidlig åbning
       3%  ved Sen åbning
       4%  ved Midtspil
      11%  ved slutspil;

    Total cut-off:
      25x  ved Tidlig åbning
      10x  ved Sen åbning
       5x  ved Midtspil
      11%  ved slutspil;

1095: NICptr korrekt NIL

1949/2024 ECO -75, why?
--------------------------------------------------------------------
*)

PROCEDURE Alloc(VAR ptr:ADDRESS; VAR CurrentSize:LONGINT; MaxSize,GoalSize,MinSize:LONGINT; TotalParts:INTEGER);
VAR
  tptr:ADDRESS;
  tsize,lblk,avail:LONGINT;
BEGIN
  REPEAT
    lblk:=Largest(FALSE);
    avail:=Available(FALSE);
    IF lblk<MinSize THEN
      tsize:=MinSize;
    ELSIF lblk>GoalSize THEN
      IF LotMemOn & (lblk>MaxSize) THEN
        tsize:=MaxSize;
      ELSE
        tsize:=GoalSize;
      END;
    ELSE
      tsize:=MinSize;
    END;
    WHILE (avail<tsize*TotalParts) & (tsize>=MinSize*2) DO
      tsize:=tsize DIV 2;
    END;
    Allocate(tptr,tsize);
    IF tptr=NIL THEN
      tsize:=0;
    END;
    ptr:=tptr;
    CurrentSize:=tsize;
  UNTIL (tptr<>NIL) OR (TwoGadWIN(ADDRESS(Q[Qwantmemory]))=0);
END Alloc;

PROCEDURE AddShortcard(Shortcard:SHORTCARD);
BEGIN
  dbg^[dbgp]:=Shortcard;
  INC(dbgp);
END AddShortcard;

(*
PROCEDURE GetShortCard(VAR Shortcard:SHORTCARD);
BEGIN
  Shortcard:=dbg^[dbgp];
  INC(dbgp);
END GetShortCard;
*)

PROCEDURE AddStr(s:ARRAY OF CHAR);
VAR
  n:CARDINAL;
BEGIN
  n:=0;
  REPEAT
    dbg^[dbgp]:=SHORTCARD(s[n]);
    INC(dbgp);
    INC(n);
  UNTIL s[n-1]=0C;;
END AddStr;

PROCEDURE GetStr(VAR s:ARRAY OF CHAR); 
VAR
  n:CARDINAL;
  ch:CHAR;
BEGIN
(*
  Copy(s,spSTR( ADDRESS(dbg)+LONGINT(dbgp) )^);
  dbgp:=dbgp+CARDINAL(Length(s));
  INC(dbgp);
*)
  n:=0;
  REPEAT
    ch:=CHAR(dbg^[dbgp]);
    INC(dbgp);
    IF ch>CHAR(127) THEN 
      CASE ch OF
      | CHAR(145) : ch:='æ'; (* IBM-PC (D/N) charset-conversion *)
      | CHAR(155) : ch:='ø';
      | CHAR(134) : ch:='å';
      | CHAR(146) : ch:='Æ';
      | CHAR(157) : ch:='Ø';
      | CHAR(143) : ch:='Å';
      | CHAR(148) : ch:='ö';
      | CHAR(153) : ch:='Ö';
      | CHAR(132) : ch:='ä';
      | CHAR(142) : ch:='Ä';
      | CHAR(129) : ch:='ü';
      | CHAR(154) : ch:='Ü';
      | CHAR(138) : ch:='è';
      | CHAR(130) : ch:='é';
      | CHAR(171) : ch:=CHAR(189); (* 1/2 *)
      ELSE
      END;
    END;
    s[n]:=ch;
    INC(n);
  UNTIL (n=CARDINAL(HIGH(s))) OR (s[n-1]=0C);
END GetStr;

PROCEDURE GetStrName(VAR s:ARRAY OF CHAR); 
VAR
  n,m,spp       :CARDINAL;
  ch            :CHAR;
  comma,PGNon   :BOOLEAN;
  s2            :ARRAY[0..25] OF CHAR;
BEGIN
  PGNon:=Lates3=1;
  n:=0;
  spp:=0;
  comma:=FALSE;
  REPEAT
    ch:=CHAR(dbg^[dbgp]);
    INC(dbgp);
    IF ch>CHAR(127) THEN 
      CASE ch OF
      | CHAR(145) : ch:='æ'; (* IBM-PC (D/N) charset-conversion *)
      | CHAR(155) : ch:='ø';
      | CHAR(134) : ch:='å';
      | CHAR(146) : ch:='Æ';
      | CHAR(157) : ch:='Ø';
      | CHAR(143) : ch:='Å';
      | CHAR(148) : ch:='ö';
      | CHAR(153) : ch:='Ö';
      | CHAR(132) : ch:='ä';
      | CHAR(142) : ch:='Ä';
      | CHAR(129) : ch:='ü';
      | CHAR(154) : ch:='Ü';
      | CHAR(138) : ch:='è';
      | CHAR(130) : ch:='é';
      | CHAR(171) : ch:=CHAR(189); (* 1/2 *)
      ELSE
      END;
    ELSIF ch < ' ' THEN
      IF ch=CHAR(30) THEN ch:='æ'; END;(* Sinkbæk *)
    END;
    IF (ch<>' ') OR (n=0) OR (s[n-1]<>' ') THEN (* remove a space if two in row *)
      s[n]:=ch;
      INC(n);
    END;
    IF ch=',' THEN (* insert space after comma *)
      comma:=TRUE;
      s[n]:=' ';
      INC(n);
    END;
    IF ch=' ' THEN spp:=n; END;
  UNTIL (n=CARDINAL(HIGH(s))) OR (s[n-1]=0C);
  IF ~comma THEN
    IF (s[0]='T') & (s[1]='B') & (s[2]='N') THEN
      Copy(s,'TBN (Thomas Bach Nielsen)');
    END;
    IF (s[0]='H') & (s[1]='H') & (s[2]='H') THEN
      Copy(s,'HHH (Hans Henrik Hansen)');
    END;
    IF (s[0]='E') & (s[1]='M') & (s[2]='A') THEN
      Copy(s,'EMA (Egon Bech Madsen)');
    END;
    IF PGNon & (spp>0) & (s[spp]<>0C) THEN (* reverse name: SIR LAST to LAST, SIR *)
      Copy(s2,s);
      n:=0;
      m:=spp;
      REPEAT
        s[n]:=s2[m];
        INC(n);
        INC(m);
      UNTIL (n=CARDINAL(HIGH(s))) OR (s[n-1]=0C);
      s[n-1]:=','; s[n]:=' '; INC(n);
      FOR m:=0 TO spp-2 DO
        s[n]:=s2[m];
        INC(n);
      END;
      s[n]:=0C;
    END;
  END;  
END GetStrName;

PROCEDURE SkipStr;
BEGIN
  WHILE dbg^[dbgp]<>0 DO INC(dbgp) END; INC(dbgp); (* SkipStr *)
END SkipStr;

PROCEDURE AddCard(Card:CARDINAL);
BEGIN
  dbg^[dbgp]:=Card DIV 256;
  INC(dbgp);
  dbg^[dbgp]:=Card MOD 256;
  INC(dbgp);
END AddCard;

TYPE
  pCard=POINTER TO CARDINAL;

PROCEDURE GetCard(VAR Card:CARDINAL);
BEGIN
(*
  Card:=dbg^[dbgp]*256+dbg^[dbgp+1];
*)
  Card:=pCard(ADDRESS(dbg)+LONGINT(dbgp))^;
  INC(dbgp,2);
END GetCard;

PROCEDURE AddInt(Int:INTEGER);
BEGIN
  dbg^[dbgp]:=Int DIV 256;
  INC(dbgp);
  dbg^[dbgp]:=Int MOD 256;
  INC(dbgp);
END AddInt;

PROCEDURE GetInt(VAR Int:INTEGER);
BEGIN
  Int:=dbg^[dbgp]*256+dbg^[dbgp+1];
  INC(dbgp,2);
END GetInt;

PROCEDURE MarkSize;
BEGIN
  dbgpMarked:=dbgp;
  dbgp:=dbgp+2;
END MarkSize;

PROCEDURE AddSize;
VAR
  dbgpOld:CARDINAL;
BEGIN
  dbgpOld:=dbgp;  
  dbgp:=dbgpMarked;
  AddCard(dbgpOld-dbgp-2);
  dbgp:=dbgpOld;
END AddSize;

PROCEDURE AppendInfo;
VAR
  dbgpo,dbgps,Date,Month:CARDINAL;
  d,d2,d3,n:INTEGER;
  FENstr:ARRAY[0..100] OF CHAR;
BEGIN
  MarkSize;

(*$ IF NoProfiler *)
  AddShortcard(1); (* GameType *)
  IF (gExtras[gEvent,1]=0C) & (gExtras[gEvent,0]<>0C) THEN
    AddStr('');
  ELSE
    AddStr(gExtras[gEvent]);
  END;
  IF (gExtras[gSite,1]=0C) & (gExtras[gSite,0]<>0C) THEN
    AddStr('');
  ELSE
    AddStr(gExtras[gSite]);
  END;
  IF (Length(gExtras[gDate])<10)
  OR (gExtras[gDate,8]<'0') OR (gExtras[gDate,8]>'3')
  OR (gExtras[gDate,9]<'0') OR (gExtras[gDate,9]>'9') THEN
    Date:=0;
  ELSE
    Date:=10*ORD(gExtras[gDate,8])+ORD(gExtras[gDate,9])-528; (*480+48=528*)
  END;

  IF (Length(gExtras[gDate])<7)
  OR (gExtras[gDate,5]<'0') OR (gExtras[gDate,5]>'1')
  OR (gExtras[gDate,6]<'0') OR (gExtras[gDate,6]>'9') THEN
    Month:=0;
  ELSE
    Month:=10*ORD(gExtras[gDate,5])+ORD(gExtras[gDate,6])-528;
  END;

(* DateResult dannes udfra gResult og gDate (månedsdel) *)
  d:=0;
  IF Length(gExtras[gResult])>1 THEN 
    IF gExtras[gResult,2]='0' THEN
      d:=32;
    ELSIF gExtras[gResult,2]='1' THEN
      d:=96;
    ELSIF gExtras[gResult,2]='2' THEN
      d:=64;
    END;
  ELSIF (Length(gExtras[gResult])=1) & (gExtras[gResult,0]='*') THEN
    d:=128;
  END;

  d:=d+INTEGER(Date);

  AddShortcard(SHORTCARD(d));

(* YearMonth dannes udfra gDate (år+måneds del) *)
  d:=0;
  IF Length(gExtras[gDate])>9 THEN
    IF (gExtras[gDate,3]>='0') & (gExtras[gDate,3]<='9') THEN
      d:=ORD(gExtras[gDate,3])-48;
    END;
    IF (gExtras[gDate,2]>='0') & (gExtras[gDate,2]<='9') THEN
      d:=d+10*ORD(gExtras[gDate,2])-480;
    END;
    IF (gExtras[gDate,1]>='0') & (gExtras[gDate,1]<='9') THEN
      d:=d+100*ORD(gExtras[gDate,1])-4800;
    END;
    IF (gExtras[gDate,0]>='0') & (gExtras[gDate,0]<='9') THEN
      d:=d+1000*ORD(gExtras[gDate,0])-48000;
    END;


    d:=d*16+INTEGER(Month);

  END;
  AddCard(d);

(* Beregn WhiteElo til d2, så Runde kan markere om den skal med (d2<>0) *)
  d2:=0;
  IF gExtras[gWhiteElo,0]=0C THEN
    IF gExtras[gWhiteUSCF,0]<>0C THEN
      d2:=-CardVal(gExtras[gWhiteUSCF]);
    END;
  ELSE
    d2:=CardVal(gExtras[gWhiteElo]);
  END;

(* Beregn BlackElo til d3, så Runde kan markere om den skal med (d3<>0) *)
  d3:=0;
  IF gExtras[gBlackElo,0]=0C THEN
    IF gExtras[gBlackUSCF,0]<>0C THEN
      d3:=-CardVal(gExtras[gBlackUSCF]);
    END;
  ELSE
    d3:=CardVal(gExtras[gBlackElo]);
  END;

(* Runde *)
  d:=0;
  FOR n:=0 TO Length(gExtras[gRound])-1 DO
    IF (gExtras[gRound,n]>='0') & (gExtras[gRound,n]<='9') THEN
      d:=10*d+ORD(gExtras[gRound,n])-48;
    END;
  END;
  IF d>63 THEN
    d:=63;
  END;

  (* Sæt evt markeringer i Runde af om White/BlackElo er med *)
  IF d2<>0 THEN
    d:=d+128;
  END;
  IF d3<>0 THEN
    d:=d+64;
  END;

  AddShortcard(SHORTCARD(d));

  AddStr(gExtras[gWhite]);
  AddStr(gExtras[gBlack]);

  IF d2<>0 THEN
    AddInt(d2);
  END;

  IF d3<>0 THEN
    AddInt(d3);
  END;

(* gWhite/BlackTitle ud til Titles *)
  d:=0;
  IF    Eq(gExtras[gWhiteTitle], 'GM') THEN d:=1;
  ELSIF Eq(gExtras[gWhiteTitle],'WGM') THEN d:=2;
  ELSIF Eq(gExtras[gWhiteTitle], 'IM') THEN d:=3;
  ELSIF Eq(gExtras[gWhiteTitle],'WIM') THEN d:=4;
  ELSIF Eq(gExtras[gWhiteTitle], 'FM') THEN d:=5;
  END;
  IF    Eq(gExtras[gBlackTitle], 'GM') THEN d:=d+16;
  ELSIF Eq(gExtras[gBlackTitle],'WGM') THEN d:=d+32;
  ELSIF Eq(gExtras[gBlackTitle], 'IM') THEN d:=d+48
  ELSIF Eq(gExtras[gBlackTitle],'WIM') THEN d:=d+64;
  ELSIF Eq(gExtras[gBlackTitle], 'FM') THEN d:=d+80;
  END;
  AddShortcard(d);
    
(* Named PGN extras (1-MaxExtras): *)
  FOR n:= 1 TO MaxExtras DO
    IF gExtras[n,0]<>0C THEN
      AddShortcard(n);
      AddStr(gExtras[n]);
    END;
  END;

(* FEN (17) *)
  IF ~Equal(start.Still,StartStilling) THEN
    AddShortcard(17);
    STILLINGtoFEN(FENstr,start.Still);
    AddStr(FENstr);
  END;

(* 0-terminering: *)
  AddShortcard(0);

  AddSize;
(*$ ENDIF *)
END AppendInfo;

PROCEDURE AppendMoves;
VAR
  n:INTEGER;
  m:CARDINAL;
  st:STILLINGTYPE;
  t:TRKDATA;
  mvnr,movenr,dbgpOld:CARDINAL;
BEGIN
  MarkSize;
(*$ IF NoProfiler *)
  st:=start.Still;
  FOR n:=1 TO MaxTraek DO
    GetMoveNr(st,Spil^[n].Fra,Spil^[n].Til,movenr,TRUE);
    IF movenr>127 THEN
      movenr:=0;
    END;
    IF Press7 & (n MOD 8=0) THEN
      mvnr:=movenr;
      FOR m:=1 TO 7 DO
        IF ODD(mvnr) THEN
          dbg^[dbgp-m]:=dbg^[dbgp-m]+128;
        END;
        mvnr:=mvnr DIV 2;
      END;
    ELSE
      AddShortcard(movenr);
    END;
    DoMoveC(st,Spil^[n].Fra,Spil^[n].Til);
  END;
  dbgpOld:=dbgp;
  dbgp:=dbgpMarked;
  AddCard(MaxTraek);
  dbgp:=dbgpOld;
(*$ ENDIF *)
END AppendMoves;

PROCEDURE AppendComments;
VAR 
  n:INTEGER;
  dbgpo,dbgpi,csz:CARDINAL;
BEGIN
  MarkSize;
  FOR n:=0 TO MaxTraek DO
    IF ~(Spil^[n].Tekst=NIL) & ~(Spil^[n].Tekst^[0]=0C) THEN
      IF dbgs>LONGINT(dbgp)+Length(Spil^[n].Tekst^)+3 THEN
        AddCard(n);
        AddStr(Spil^[n].Tekst^);
      END;
    END;
  END;
  AddSize;
END AppendComments;

PROCEDURE AppendGame;
VAR
  ls:CARDINAL;
  actual:LONGINT;
  dbgpOld:CARDINAL;
BEGIN
  dbgp:=2;
  AppendInfo;
  AppendMoves;
  AppendComments;
  dbgpOld:=dbgp;
  dbgp:=0;
  AddCard(dbgpOld-2);
  dbgp:=dbgpOld;
END AppendGame;

VAR
  ldbfud:LONGINT;

PROCEDURE Save20init(pth:ARRAY OF CHAR);
VAR
  Buf:LONGINT;
BEGIN
  IF LotMemOn THEN
    Buf:=FilBufferSzWrite*FilBufferSzBig;
  ELSE
    Buf:=FilBufferSzWrite;
  END;
  Lookup(dbfud,pth,Buf,FALSE);
  IF dbfud.res=notFound THEN (* Create a new GameBase *)
    Lookup(dbfud,pth,Buf,TRUE);
    IF dbfud.res=done THEN
      WriteChar(dbfud,'S');
      WriteChar(dbfud,'K');
      WriteChar(dbfud,'2');
      WriteChar(dbfud,'0');
    END;
  ELSE
    FileSystem.Length(dbfud,ldbfud);
    SetPos(dbfud,ldbfud);
  END;
END Save20init;

(* gemme spillet til skakbasefil *)
PROCEDURE Save20body(Auto:BOOLEAN):BOOLEAN;
VAR
  Title:ARRAY[0..40] OF CHAR;
  n,m,Pos:INTEGER;
  Ok:BOOLEAN;
  actual:LONGINT;
BEGIN
  Ok:=FALSE;
(*
  Allocate(dbg,SIZE(dbg^));
*)
  Alloc(dbg,dbgs,SIZE(dbg^),16384,4096,2);

  IF dbg<>NIL THEN
    AppendGame;
    WriteBytes(dbfud,dbg,dbgp,actual);
    Ok:= actual=LONGINT(dbgp);
    Deallocate(dbg);
    IF (actual>0) & ~Ok THEN (* fjern det delvist gemte *)
      SetPos(dbfud,ldbfud);
    END;
    IF Ok THEN
(*$IF Test0 *)
  WRITELN(s('rettetREM,PGN,SPIL=F'));
(*$ENDIF *)
      rettetREM:=FALSE;
      rettetPGN:=FALSE;
      rettetSPIL:=FALSE;
    END;
  END;
  RETURN(Ok);
END Save20body;

PROCEDURE Save20close();
BEGIN
  Close(dbfud);
END Save20close;

PROCEDURE Save20(pth:ARRAY OF CHAR; Auto:BOOLEAN):BOOLEAN;
VAR
  OK:BOOLEAN;
BEGIN
 Save20init(pth);
 OK:=Save20body(Auto);
 Save20close();
 RETURN(OK);
END Save20;

VAR
  INVALID:BOOLEAN;

(*   gFlags[-12..16]

   -12 Event,       -11 Site,      -10|-6 DateResult,   -10 YearMonth,
    -9 Round,        -8 White,         -7 Black,      -3|-1 WhiteElo,
  -2|0 BlackElo,  -5|-4 Titles,         1 NIC,            2 Annotator,
     3 Source,        4 Info,           5 EventDate,      6 EventSponsor,
     7 Section,       8 Stage,          9 Board,         10 Opening,
    11 Variation,    12 SubVariation,   13 ECO,          14 Time,
    15 WhiteCountry, 16 BlackCountry *)

VAR
  spNIC,spEvent,spSite,spWhite,spBlack,spECO:ADDRESS; (* spSTR type *)
  FENstr:ARRAY[0..100] OF CHAR;

PROCEDURE GetInfo(Complete:BOOLEAN);
VAR
  InfoSize,YearMonth,Year,Month,Date,Result,nr:CARDINAL;
  GameType,DateResult,Round,Titles,TitleW,TitleB,Nr:SHORTCARD;
  WhiteElo,BlackElo:INTEGER;
  sDate,sYear,sMonth:STR30;
  err,WhiteEloPresent,BlackEloPresent:BOOLEAN;
BEGIN
(*$IF Test *)
  WRITELN(s('GetInfo.'));
(*$ENDIF *)
  SetPGNinfos;

(* IF Demo *)
  FOR nr:=0 TO MaxHalvTraek DO (* IKKE MaxHalvTraek, men MaxTraek!!!! *)
    IF Spil^[nr].Tekst<>NIL THEN
      Deallocate(Spil^[nr].Tekst);
    END;
  END;
(* ENDIF *)

  InfoSize:=pCard(ADDRESS(dbg)+LONGINT(dbgp))^; (* GetCard macro *)
  INC(dbgp,2);

  INVALID:=(InfoSize<15) OR (InfoSize>435);
(*$IF Test *)
  WRITELN(s('GetInfo.sz=')+l(InfoSize));
(*$ENDIF *)

  GameType:=dbg^[dbgp];
  INC(dbgp); (* GetShortCard *)

  Quick:=ODD(GameType);
(*$IF Test *)
  WRITELN(s('GetInfo.gametype=')+l(GameType));
(*$ENDIF *)

  spEvent:=LONGINT(dbg)+LONGINT(dbgp);
  IF Complete OR gFlags[gEvent] THEN
    GetStr(gExtras[gEvent]);
    IF gExtras[gEvent,0]=0C THEN
      gExtras[gEvent]:='?';
    END;
  ELSE
    WHILE dbg^[dbgp]<>0 DO INC(dbgp) END; INC(dbgp); (* SkipStr *)
  END;

  IF Complete OR gFlags[gSite] THEN
    GetStr(gExtras[gSite]);
    IF gExtras[gSite,0]=0C THEN
      gExtras[gSite]:='?';
    END;
  ELSE
    spSite:=LONGINT(dbg)+LONGINT(dbgp);
    WHILE dbg^[dbgp]<>0 DO INC(dbgp) END; INC(dbgp); (* SkipStr *)
  END;

  DateResult:=dbg^[dbgp];
  INC(dbgp); (* GetShortCard *)

  IF Complete OR gFlags[gDate] THEN
    Date:=DateResult MOD 32;
    IF Date=0 THEN
      sDate:='??';
    ELSE
      ValToStr(Date,FALSE,sDate,10,2,'0',err);
      IF err THEN sDate:='??'; END;
    END;
  ELSE
    sDate[0]:=0C;
  END;

  Result:=DateResult DIV 32;
(*$IF Test *)
  WRITELN(s('DateRes=')+l(DateResult)+s(' Date=')+l(Date)+s(' Res=')+l(Result));
(*$ENDIF *)
  CASE Result OF
  | 0: gExtras[gResult]:='';
  | 1: gExtras[gResult]:='1-0';
  | 2: gExtras[gResult]:='1/2-1/2';
  | 3: gExtras[gResult]:='0-1';
  | 4: gExtras[gResult]:='*';
  ELSE
    gExtras[gResult]:='?';
  END;

  YearMonth:=pCard(ADDRESS(dbg)+LONGINT(dbgp))^; (* GetCard macro *)
  INC(dbgp,2);

  Year:=YearMonth DIV 16;
  IF Year<1000 THEN
    sYear:='????'
  ELSE
    ValToStr(Year,FALSE,sYear,10,4,'0',err);
    IF err THEN sYear:='????'; END;
  END;

  Copy      (gExtras[gDate],sYear);

  IF Complete OR gFlags[gDate] THEN
    Month:=YearMonth MOD 16;
    IF (Month=0) OR (Month>12) THEN
      sMonth:='??'
    ELSE
      ValToStr(Month,FALSE,sMonth,10,2,'0',err);
      IF err THEN sMonth:='??'; END;
    END;
    ConcatChar(gExtras[gDate],'.');
    Concat    (gExtras[gDate],sMonth);
    ConcatChar(gExtras[gDate],'.');
    Concat    (gExtras[gDate],sDate);  
  END;

(*$IF Test *)
  WRITELN(s('GetInfo.gDate=')+s(gExtras[gDate]));
(*$ENDIF *)

  Round:=dbg^[dbgp];
  INC(dbgp); (* GetShortCard *)

  WhiteEloPresent:=Round>127;
  IF WhiteEloPresent THEN
    Round:=Round-128;
  END;
  BlackEloPresent:=Round>63;

  IF Complete OR gFlags[gRound] THEN
    IF BlackEloPresent THEN
      Round:=Round-64;
    END;
    IF Round=0 THEN
      gExtras[gRound]:=''
    ELSE
      ValToStr(Round,FALSE,gExtras[gRound],10,1,' ',err);
      IF err THEN gExtras[gRound]:=''; END;
    END;
  END;


  INVALID:=INVALID OR (Date>31) OR (Month>12) OR (Year<1000);

(*$IF Test *)
  WRITELN(s('GetInfo.gRound=')+s(gExtras[gRound]));
(*$ENDIF *)
  
  IF Complete THEN
    GetStrName(gExtras[gWhite]);
    GetStrName(gExtras[gBlack]);
  ELSE
    spWhite:=LONGINT(dbg)+LONGINT(dbgp);
    IF gFlags[gWhite] OR gFlags[gBlack] & gInverse[gIC] THEN
      GetStrName(gExtras[gWhite]);
    ELSE
      WHILE dbg^[dbgp]<>0 DO INC(dbgp) END; INC(dbgp); (* SkipStr *)
    END;
    spBlack:=LONGINT(dbg)+LONGINT(dbgp);
    IF gFlags[gBlack] OR gFlags[gWhite] & gInverse[gIC] THEN
(*$IF Test *)
  WRITELN(s('GetInfo.get[gBlack]'));
(*$ENDIF *)
      GetStrName(gExtras[gBlack]);
    ELSE
      WHILE dbg^[dbgp]<>0 DO INC(dbgp) END; INC(dbgp); (* SkipStr *)
    END;
  END;    


(*$IF Test *)
  WRITELN(s('GetInfo.gWhite=')+s(gExtras[gWhite]));
  WRITELN(s('GetInfo.gBlack=')+s(gExtras[gBlack]));
(*$ENDIF *)

  IF Complete OR gFlags[gWhiteElo] OR gFlags[gWhiteUSCF] THEN
    IF WhiteEloPresent THEN
      GetInt(WhiteElo);
    ELSE
      WhiteElo:=0;
    END;
    IF WhiteElo<>0 THEN
      INVALID:=INVALID OR (ABS(WhiteElo)>3000) OR (ABS(WhiteElo)<700);
    END;
    IF WhiteElo<0 THEN
      gExtras[gWhiteElo]:='';
      ValToStr(-WhiteElo,FALSE,gExtras[gWhiteUSCF],10,4,'0',err);
      IF err THEN gExtras[gWhiteUSCF]:=''; END;
    ELSE
      gExtras[gWhiteUSCF]:='';
      IF WhiteElo>0 THEN
        ValToStr(WhiteElo,FALSE,gExtras[gWhiteElo],10,4,'0',err);
      ELSE
        err:=TRUE;
      END;
      IF err THEN gExtras[gWhiteElo]:=''; END;
    END;
  ELSE
    IF WhiteEloPresent THEN
      INC(dbgp,2);
    END;
  END;

  IF Complete OR gFlags[gBlackElo] OR gFlags[gBlackUSCF] THEN
    IF BlackEloPresent THEN
      GetInt(BlackElo);
    ELSE
      BlackElo:=0;
    END;
    IF BlackElo<>0 THEN
      INVALID:=INVALID OR (ABS(BlackElo)>3000) OR (ABS(BlackElo)<700);
    END;
    IF BlackElo<0 THEN
      gExtras[gBlackElo]:='';
      ValToStr(-BlackElo,FALSE,gExtras[gBlackUSCF],10,4,'0',err);
      IF err THEN gExtras[gBlackUSCF]:=''; END;
    ELSE
      gExtras[gBlackUSCF]:='';
      IF BlackElo>0 THEN
        ValToStr(BlackElo,FALSE,gExtras[gBlackElo],10,4,'0',err);
      ELSE
        err:=TRUE;
      END;
      IF err THEN gExtras[gBlackElo]:=''; END;
    END;
  ELSE
    IF BlackEloPresent THEN
      INC(dbgp,2);
    END;
  END;

(*$IF Test *)
  WRITELN(s('GetInfo.gRatings WE=')+s(gExtras[gWhiteElo])+s(' BE=')+s(gExtras[gBlackElo])
          +s(' WU=')+s(gExtras[gWhiteUSCF])+s(' BU=')+s(gExtras[gBlackUSCF]));
(*$ENDIF *)

  Titles:=dbg^[dbgp];
  INC(dbgp); (* GetShortCard *)

  IF Complete OR gFlags[gWhiteTitle] OR gFlags[gBlackTitle] THEN
    TitleW:=Titles MOD 16;
    CASE TitleW OF
    |  0 : gExtras[gWhiteTitle]:='';
    |  1 : gExtras[gWhiteTitle]:='GM';
    |  2 : gExtras[gWhiteTitle]:='WGM';
    |  3 : gExtras[gWhiteTitle]:='IM';
    |  4 : gExtras[gWhiteTitle]:='WIM';
    |  5 : gExtras[gWhiteTitle]:='FM';
    |  6 : gExtras[gWhiteTitle]:='t6';
    |  7 : gExtras[gWhiteTitle]:='t7';
    |  8 : gExtras[gWhiteTitle]:='t8';
    |  9 : gExtras[gWhiteTitle]:='t9';
    ELSE   gExtras[gWhiteTitle]:='?';
    END;

    TitleB:=Titles DIV 16;
    CASE TitleB OF
    |  0 : gExtras[gBlackTitle]:='';
    |  1 : gExtras[gBlackTitle]:='GM';
    |  2 : gExtras[gBlackTitle]:='WGM';
    |  3 : gExtras[gBlackTitle]:='IM';
    |  4 : gExtras[gBlackTitle]:='WIM';
    |  5 : gExtras[gBlackTitle]:='FM';
    |  6 : gExtras[gBlackTitle]:='t6';
    |  7 : gExtras[gBlackTitle]:='t7';
    |  8 : gExtras[gBlackTitle]:='t8';
    |  9 : gExtras[gBlackTitle]:='t9';
    ELSE   gExtras[gBlackTitle]:='?';
    END;
  END;

(*$IF Test *)
  WRITELN(s('GetInfo.title W=')+s(gExtras[gWhiteTitle])+s(' B=')+s(gExtras[gBlackTitle]));
(*$ENDIF *)

  spNIC:=NIL;
  spECO:=NIL;
  REPEAT
    Nr:=dbg^[dbgp];
    INC(dbgp); (* GetShortCard *)

    IF Nr>32 THEN
      INVALID:=TRUE;
    END;
    IF (Nr>0) THEN
      IF Nr=gNIC THEN
        spNIC:=LONGINT(dbg)+LONGINT(dbgp);
      END;
      IF Nr=gECO THEN
        spECO:=LONGINT(dbg)+LONGINT(dbgp);
      END;
      IF (Nr<=MaxExtras) & (Complete OR gFlags[Nr] OR (Nr=17)) THEN
        IF Nr=17 THEN
          GetStr(FENstr);
(*$IF Test *)
  WRITELN(s('GetInfo.FENstr=')+s(FENstr));
(*$ENDIF *)
        ELSE
          GetStr(gExtras[Nr]);
        END;
(*$IF Test *)
  WRITELN(s('GetInfo.Ext= ')+l(Nr)+s(' ')+s(gExtras[Nr]));
(*$ENDIF *)
      ELSE
        WHILE dbg^[dbgp]<>0 DO INC(dbgp) END; INC(dbgp); (* SkipStr *)
      END;
    END;
  UNTIL Nr=0;
END GetInfo;

PROCEDURE GetMoves():CARDINAL;
VAR
  n:INTEGER;
  t:TRKDATA;
  MoveTyp:MOVETYPE;
  movenr,move8:SHORTCARD;
  OK:BOOLEAN;
  MovesSize,MovesBytes:CARDINAL;
BEGIN
(*$IF Test0 *)
  WRITELN(s('GetMoves'));
(*$ENDIF *)
  IF FENstr[0]=0C THEN
    start.Still:=StartStilling;
  ELSE
    FENtoSTILLING(start.Still,FENstr);
    FENstr[0]:=0C;
  END;
  stilling:=start.Still;
  GetCard(MovesSize);
(*
  MovesBytes:=MovesSize-MovesSize DIV 8;
*)
(*$IF Test *)
  WRITELN(s('GetMoves.sz')+l(MovesSize)+s(' dbgp=')+l(dbgp));
(*$ENDIF *)
  OK:=TRUE;
  MaxTraek:=0;
  TraekNr:=0;
  move8:=0;
  FOR n:=1 TO MovesSize DO
    IF Press7 & (n MOD 8=0) THEN
      movenr:=move8;
      move8:=0;
    ELSE
      movenr:=dbg^[dbgp];
      INC(dbgp); (* GetShortCard *)


      IF Press7 THEN
        move8:=move8+move8;
        IF movenr>127 THEN
          movenr:=movenr-128;
          INC(move8);
        END;
      END;
    END;
    IF OK THEN
      GetMove(stilling,t,movenr,Quick);
      OK:=t.Fra<89;
      IF OK THEN
(*$IF Test *)
  WRITELN(s('GetMoves.Nr=')+l(n)+s(' ')+l(t.Fra)+s('-')+l(t.Til));
(*$ENDIF *)
        Spil^[n].Fra:=t.Fra;
        Spil^[n].Til:=t.Til;
        INC(MaxTraek);
      ELSE
        INVALID:=TRUE;
      END;
    END;
  END;
  IF ~OK THEN
    TraekNr:=MaxTraek;
  ELSE
    stilling:=start.Still;
  END;
  RETURN(MovesSize);
END GetMoves;

PROCEDURE GetComments;
VAR 
  tekst:ARRAY[0..4096] OF CHAR;
  CommentsSize,CommentMove,n,odbgp:CARDINAL;
BEGIN
(*$IF Test *)
  WRITELN(s('GetComments'));
(*$ENDIF *)
  FOR n:=0 TO MaxTraek DO
    IF Spil^[n].Tekst<>NIL THEN
(*$IF Test *)
  WRITELN(s('GetComments.Deallocate ')+l(n));
(*$ENDIF *)
      Deallocate(Spil^[n].Tekst);
    END;
  END;
  odbgp:=dbgp;
  GetCard(CommentsSize);
(*$IF Test *)
  WRITELN(s('GetComments.sz')+l(CommentsSize)+s(' dbgp=')+l(dbgp));
(*$ENDIF *)
  IF CommentsSize>0 THEN
    REPEAT
      GetCard(CommentMove);
      IF CommentMove<= CARDINAL(MaxTraek) THEN
        GetStr(tekst);
(*$IF Test *)
  WRITELN(s('CM=')+l(CommentMove)+s(' lgth=')+l(Length(tekst)));
(*$ENDIF *)
        Allocate(Spil^[CommentMove].Tekst,Length(tekst)+2);
        IF Spil^[CommentMove].Tekst<>NIL THEN
(*$IF Test *)
  WRITELN(s('CM1'));
(*$ENDIF *)
          Copy(Spil^[CommentMove].Tekst^,tekst);
(*$IF Test *)
  WRITELN(s('CM2'));
(*$ENDIF *)
        END;
      ELSE
(*$IF Test *)
  WRITELN(s('Invalid'));
(*$ENDIF *)
        INVALID:=TRUE;
      END;
    UNTIL (CommentMove>1023) OR (dbgp>=odbgp+CommentsSize);
  END;
(*$IF Test *)
  WRITELN(s('GC.slut'));
(*$ENDIF *)
END GetComments;

(* læse et spil fra dbg (skakbase format) til program *)
PROCEDURE GetGame;
VAR
  msz:CARDINAL;
BEGIN
  dbgp:=0;
  GetInfo(TRUE);
  msz:=GetMoves();
  GetComments;
END GetGame;

VAR
  GameSize:CARDINAL;

PROCEDURE SAVECACHE(n:INTEGER);
VAR
  cnt:CARDINAL;
BEGIN
(*$IF Test *)
  WRITELN(s('SaveCache'));
(*$ENDIF *)
  Allocate(LLCACHE[n],GameSize);
  IF LLCACHE[n]<>NIL THEN
    FOR cnt:=0 TO GameSize-1 DO
      LLCACHE[n]^[cnt]:=dbg^[cnt];
    END;
    LLCACHEsz[n]:=GameSize;
  END;
(*
  LLCACHEadr[n]:=LL^[n].Adrs;
*)
END SAVECACHE;

PROCEDURE LOADCACHE(n:INTEGER); (* Load game from cache *)
VAR
  cnt:CARDINAL;
BEGIN
(*$IF Test *)
  WRITELN(s('LoadCache'));
(*$ENDIF *)
  IF (dbg<>NIL) & (LLCACHE[n]<>NIL) THEN
    FOR cnt:=0 TO LLCACHEsz[n]-1 DO
      dbg^[cnt]:=LLCACHE[n]^[cnt];
    END;
    GameSize:=LLCACHEsz[n];
  END;
END LOADCACHE;

PROCEDURE EraseCache; (* Erase all in cache *)
VAR
  nnn:INTEGER;
BEGIN
(*$IF Test *)
  WRITELN(s('EraseCache'));
(*$ENDIF *)
  FOR nnn:=1 TO MAXLLCACHESIZE DO
    IF LLCACHE[nnn]<>NIL THEN
      Deallocate(LLCACHE[nnn]);
    END;
  END;
END EraseCache;

PROCEDURE Load20init(pth:ARRAY OF CHAR; Auto:BOOLEAN):BOOLEAN;
VAR
  OK:BOOLEAN;
  c1,c2,c3,c4:CHAR;
BEGIN
  IF ~RydSpil(TRUE,Auto) THEN RETURN(FALSE) END;
  Lookup(dbf,pth,FilBufferSzRead,FALSE);
  ReadChar(dbf,c1);ReadChar(dbf,c2);ReadChar(dbf,c3);ReadChar(dbf,c4);
  RETURN((c1='S') & (c2='K') & (c3='2') & (c4>='0') & (c4<='9'));
END Load20init;

(* læse et spil fra skakbasefil adresse Adr til dbg, Næste adresse retur (0=slut) *)
PROCEDURE Load20body(VAR Adr:LONGINT; VAR NxtAdr:LONGINT;
                 Auto:BOOLEAN):BOOLEAN;
VAR
  ldbf,actual,Adrt:LONGINT;
  GameSize:CARDINAL;
  OK:BOOLEAN;
BEGIN
(*$IF Test *)
  WRITELN(s('Load20.Adr=')+l(Adr));
(*$ENDIF *)
  OK:=FALSE;
  NxtAdr:=0;
  IF (dbf.res=done) THEN
    IF TRUE THEN
      Alloc(dbg,dbgs,SIZE(dbg^),16384,4096,2);
(*$IF Test *)
  WRITELN(s('dbgs=')+l(dbgs));
(*$ENDIF *)
      IF dbg<>NIL THEN
        FileSystem.Length(dbf,ldbf);
        IF Adr<ldbf THEN
          SetPos(dbf,Adr);
          ReadBytes(dbf,ADR(GameSize),2,actual);

          IF dbgs<LONGINT(GameSize) THEN
(*$IF Test *)
  WRITELN(s('dbgs<GameSize'));
(*$ENDIF *)
            Deallocate(dbg);
            Alloc(dbg,dbgs,SIZE(dbg^),GameSize,GameSize,2);
(*$IF Test *)
  WRITELN(s('dbgs=')+l(dbgs));
(*$ENDIF *)
          END;
          
          IF dbg<>NIL THEN

            NxtAdr:=Adr+LONGINT(GameSize)+2;
            ReadBytes(dbf,dbg,3,actual);

          (* skip slettede spil *)
            WHILE ~dbf.eof & (dbf.res=done) & (dbg^[2]>127) & (NxtAdr<ldbf) DO (* så er spil markeret slettet *)
(*$IF Test *)
  WRITELN(s('skip'));
(*$ENDIF *)
              Adr:=NxtAdr;
              NxtAdr:=Adr+LONGINT(GameSize)+2;
              GetPos(dbf,Adrt);
              SetPos(dbf,Adrt+LONGINT(GameSize)-3);
              ReadBytes(dbf,ADR(GameSize),2,actual);
              ReadBytes(dbf,dbg,3,actual);
            END;

            ReadBytes(dbf,LONGINT(dbg)+3,GameSize-3,actual);

            IF (dbf.res=done) & (LONGINT(GameSize)-3=actual) THEN
(*$IF Test0 *)
  WRITELN(s('call getGame')+l(dbgs));
(*$ENDIF *)
              GetGame;
              OK:=TRUE;
(*
              rettetREM:=FALSE;
              rettetPGN:=FALSE;
              rettetSPIL:=FALSE;
*)
            END;
            IF NxtAdr>=ldbf THEN
              NxtAdr:=0;
            END;
          END;
        END;
        Deallocate(dbg);
      END;
    END;
  END;
(*$IF Test *)
  WRITELN(s('Load20.NxtAdr=')+l(NxtAdr));
(*$ENDIF *)
  RETURN(OK);
END Load20body;

PROCEDURE Load20close;
BEGIN
  Close(dbf);
END Load20close;

(* NxtAdr ser ikke ud til at blive brugt !!!! *)
PROCEDURE Load20(pth:ARRAY OF CHAR; VAR Adr:LONGINT; VAR NxtAdr:LONGINT;
                 Auto:BOOLEAN):BOOLEAN;
VAR
  OK:BOOLEAN;
  n:CARDINAL;
BEGIN
  OK:=FALSE;
  n:=0;
  WHILE (n<LLCACHESIZE) & ~OK DO
    INC(n);
    IF Adr=LL^[n].Adrs THEN
      OK:=TRUE;
      Alloc(dbg,dbgs,SIZE(dbg^),LLCACHEsz[n],LLCACHEsz[n],2);
      IF dbg<>NIL THEN
        LOADCACHE(INTEGER(n));
        GetGame;
        Deallocate(dbg);
(* unødvendig???
        IF LONGINT(n)<LLSIZE THEN
          NxtAdr:=LL^[n+1].Adrs;
        ELSE
          NxtAdr:=0;
        END;
*)
      END;
    END;
  END;

  IF ~OK THEN
    IF Load20init(pth,Auto) THEN
      OK:=Load20body(Adr,NxtAdr,Auto);
      Load20close;
    ELSE
      OK:=FALSE;
    END;
  END;
  RETURN(OK);
END Load20;

VAR
  Wh1,Wh2,Bl1,Bl2:STR30; (* The adjusted gExtras[gWhite/Black] !!!! *)
  Whn,Bln:CARDINAL;

PROCEDURE Filter20():BOOLEAN;
VAR
  Drop,InterChange:BOOLEAN;
  n,alt:INTEGER;
BEGIN
(*$IF Test0 *)
  WRITELN(s('Filter20 Wh1="')+s(Wh1)+s('" Bl1="')+s(Bl1)+s('"'));
  IF Whn>1 THEN WRITE(s(' Wh2="')+s(Wh2)+s('"')); END;
  IF Bln>1 THEN WRITE(s(' Bl2="')+s(Bl2)+s('"')); END;
  IF (Whn>1) OR (Bln>1) THEN WRITELN(0); END;
(*$ENDIF *)
  Drop:=FALSE;
  InterChange:=gInverse[gIC];

  n:=gEvent;
  REPEAT (* FOR n:=gEvent TO gBlackCountry *)
    IF gFlags[n] THEN
(*$IF Test0 *)
  WRITELN(s('Filter20, gFlags=')+l(n)+s(' "')+s(gFilters[n])+s('" i "')+s(gExtras[n])+s('"'));
  WRITELN(s('Occurs=')+l(Occurs(gExtras[n],0,gFilters[n],FALSE))+s(' Lgth=')+l(Length(gExtras[n])));
(*$ENDIF *)
      IF (n=gWhiteElo) OR (n=gBlackElo) OR (n=gWhiteUSCF) OR (n=gBlackUSCF) THEN
        Drop:=Compare(gExtras[n],gFilters[n])<0;
      ELSIF (n=gWhite) THEN
(*$IF Test *)  WRITELN(s('gW: "')+s(gExtras[n])+s('"'));(*$ENDIF *)
        Drop:=Occurs(gExtras[n],0,Wh1,FALSE)<0;
        IF ~Drop & (Whn>1) THEN
          Drop:=Occurs(gExtras[n],0,Wh2,FALSE)<0;
        END;
      ELSIF (n=gBlack) THEN
(*$IF Test *)  WRITELN(s('gB: "')+s(gExtras[n])+s('"'));(*$ENDIF *)
        Drop:=Occurs(gExtras[n],0,Bl1,FALSE)<0;
        IF ~Drop & (Bln>1) THEN
          Drop:=Occurs(gExtras[n],0,Bl2,FALSE)<0;
        END;
      ELSE
        Drop:=Occurs(gExtras[n],0,gFilters[n],FALSE)<0;
      END;
      IF Drop THEN
        IF  InterChange THEN 
          IF n=gWhite THEN
            Drop:=Occurs(gExtras[gBlack],0,Wh1,FALSE)<0;
            IF ~Drop & (Whn>1) THEN
              Drop:=Occurs(gExtras[gBlack],0,Wh2,FALSE)<0;
            END;
          ELSIF n=gBlack THEN
            Drop:=Occurs(gExtras[gWhite],0,Bl1,FALSE)<0;
            IF ~Drop & (Bln>1) THEN
              Drop:=Occurs(gExtras[gWhite],0,Bl2,FALSE)<0;
            END;
          END;
        END;
(*$IF FALSE *)
  WRITELN(s('Filter20, DROP da ')+s(gFilters[n])+s(' ikke er i ')+s(gExtras[n]));
(*$ENDIF *)
      END;
      IF gInverse[n] THEN
(*$IF FALSE *)
  WRITELN(s('Reverse Drop'));
(*$ENDIF *)
        Drop:=~Drop;
      END;
    END;
    INC(n);
  UNTIL Drop OR (n>=gBlackCountry);
  RETURN(Drop);
END Filter20;
     
PROCEDURE FreeLL(Fra:LONGINT);
VAR
  n:LONGINT;
BEGIN
  IF (LL<>NIL) & (Fra>0) THEN
    FOR n:=Fra TO LLSIZE DO
      IF LL^[n].Text<>NIL THEN
        FreeMem(LL^[n].Text,SIZE(STR77));
        LL^[n].Text:=NIL;
(* Deallocate(LL^[n].Text); *)
      END;
    END;
  END;
END FreeLL;

(***********************************************************************
  Specials:                425 new lines + 50 lines editions to ll20
  
     W=white to move
     B=black to move
     R=reversed positions (up/down) too
     M=mirrored postions (left/right) too
     N=no count of undefined pieces (else count=0);
*)

CONST
  sdCntb       =1;  sdCntB       =2; (* eE *)
  sdCntt       =3;  sdCntT       =4; (* rR *)
  sdCnts       =5;  sdCntS       =6;
  sdCntl       =7;  sdCntL       =8;
  sdCntd       =9;  sdCntD       =10;
  sdCntk       =11; sdCntK       =12;(* mM *)
  MaxQualifiers= 9; (* max 9 queen,rook,bishop,knight and pawn qualifiers*)
  MaxFields    = 9; (* max 9 fields/qualifier *)
  Pieces       =12;

TYPE
  SDREC= RECORD (* bBtTsSlLdDkK *)
           CountIt    : BOOLEAN;   
           CountMin   : SHORTCARD;
           CountMax   : SHORTCARD;
           Qualifiers : SHORTCARD;
           Qarr       : ARRAY[1..MaxQualifiers] OF RECORD
                          Fields:SHORTCARD;
                          Field:ARRAY[1..MaxFields] OF SHORTCARD;
                        END;
        END;

  SDTYPE=ARRAY[1..Pieces] OF SDREC;
  GtNrArr=ARRAY['@'..'z'] OF SHORTCARD;

CONST        (* GtNr converts internal (DK) piece-chars to piece-nr *)
             (*    B    D E            K L M          R S T           Z *) 
  GtNr=GtNrArr{0,0,2,0,10,2,0,0,0,0,0,12,8,12,0,0,0,0,4,6,4,0,0,0,0,0,0,0,0,0,0,0,
               0,0,1,0, 9,1,0,0,0,0,0,11,7,11,0,0,0,0,3,5,3,0,0,0,0,0,0};

VAR
  GetNr:ARRAY[0C..377C] OF SHORTCARD;
  sdArr:ARRAY[1..4] OF SDTYPE;
  sdSize:SHORTCARD;(*1-4*)
  (* count of pieces maintained for current scanned game *)
  sdCnt:ARRAY[0..Pieces] OF SHORTCARD; (* [0] for non-pieces *)

PROCEDURE Clr(CountOn:BOOLEAN);
VAR
  n:CARDINAL;
BEGIN
(*$IF Test0 *)
  WRITELN(s('Clr'));
(*$ENDIF *)
  FOR n:=1 TO Pieces-2 DO
    WITH sdArr[1,n] DO
      CountIt:=CountOn;
      CountMin:=0;
      CountMax:=0;
      Qualifiers:=0;
    END;
  END;
  FOR n:=Pieces-1 TO Pieces DO
    WITH sdArr[1,n] DO
      CountIt:=FALSE;
      CountMin:=1;
      CountMax:=1;
      Qualifiers:=0;
    END;
  END;     
END Clr;

PROCEDURE GetNrInit;
VAR
  ch:CHAR;
BEGIN
 FOR ch:=0C TO 377C DO
   GetNr[ch]:=0;
 END;
 GetNr[LP('b')]:=sdCntb;
 GetNr[LP('e')]:=sdCntb;
 GetNr[LP('B')]:=sdCntB;
 GetNr[LP('E')]:=sdCntB;
 GetNr[LP('t')]:=sdCntt;
 GetNr[LP('r')]:=sdCntt;
 GetNr[LP('T')]:=sdCntT;
 GetNr[LP('R')]:=sdCntT;
 GetNr[LP('s')]:=sdCnts;
 GetNr[LP('S')]:=sdCntS;
 GetNr[LP('l')]:=sdCntl;
 GetNr[LP('L')]:=sdCntL;
 GetNr[LP('d')]:=sdCntd;
 GetNr[LP('D')]:=sdCntD;
 GetNr[LP('k')]:=sdCntk;
 GetNr[LP('m')]:=sdCntk;
 GetNr[LP('K')]:=sdCntK;
 GetNr[LP('M')]:=sdCntK;
END GetNrInit;

(* returns error number or 0:
    0: OK
    1: Too many fields for one piece (max 9 allowed, like Pa-c5-7)
*)

VAR
  PatWhite,PatBlack,PatReverse,PatMirror,PatNo:BOOLEAN;

PROCEDURE Scan(VAR Str:ARRAY OF CHAR):INTEGER;
VAR
(*bEqu,bOdd:BOOLEAN;*)
  Min,Max,xFra,xTil,yFra,yTil,x,y,q,f:SHORTCARD;
  Err:INTEGER;
  n,BrikNr:CARDINAL;
  Ch:CHAR;
  swp:SDREC;
BEGIN
(*$IF Test0 *)
  WRITELN(s('Scan "')+s(Str)+s('"'));
(*$ENDIF *)
  Err:=0;
  n:=0;
  sdSize:=1;

  GetNrInit; (* each time to catch LOCALE set on/off *)

  (* set Specials *)
  PatWhite  :=FALSE;
  PatBlack  :=FALSE;    
  PatReverse:=FALSE;    
  PatMirror :=FALSE;    
  PatNo     :=FALSE;

  IF Str[n]='.' THEN
    INC(n);
    WHILE (Str[n]<>0C) & (Str[n]<>' ') DO
      CASE CAP(Str[n]) OF
      | 'W' : PatWhite  :=TRUE;
      | 'B' : PatBlack  :=TRUE;
      | 'R' : PatReverse:=TRUE;
      | 'M' : PatMirror :=TRUE;
      | 'N' : PatNo     :=TRUE;
      ELSE END;
      INC(n);
    END;
    IF Str[n]=' ' THEN INC(n) END; 
  END;

  Clr(~PatNo);

  (* Set counts *)
  Ch:=Str[n];
  WHILE (Ch<>0C) & ((Ch>='0') & (Ch<='9') OR (Ch='#')) DO
    IF Ch='#' THEN
      Min:=0;
      Max:=9;
    ELSE
      Min:=ORD(Ch)-48;
      Max:=Min;
    END;
    INC(n);
    IF Str[n]='-' THEN
      INC(n);
      IF (Str[n]>='0') & (Str[n]<='9') THEN
        Max:=ORD(Str[n])-48;
        INC(n);
      END;
    END;
    WHILE (Str[n]<>0C) & (Str[n]<>' ') DO
      BrikNr:=GetNr[Str[n]];
      IF (BrikNr>0) & (BrikNr<=Pieces) THEN (* parsed OK, store result *)
(*$IF Test0 *)
  WRITELN(s('Scan.SetCount, BrikNr=')+l(BrikNr)+s(' Min=')+l(Min)+s(' Max=')+l(Max));
(*$ENDIF *)
        WITH sdArr[1,BrikNr] DO
          CountIt:=TRUE;
          CountMin:=Min;
          CountMax:=Max;
        END;
      END;
      INC(n);
    END;
    IF Str[n]=' ' THEN INC(n) END;
    Ch:=Str[n];
  END;

  (* Scan qualifiers *)
  WHILE Ch<>0C DO
    BrikNr:=GetNr[Ch];
    IF (BrikNr>0) & (BrikNr<=Pieces) THEN (* found piece *)
      xFra:=1; xTil:=8; (* means a-h *)
      yFra:=1; yTil:=8; (* means 1-8 *)
      INC(n);
(*
      bEqu := Str[n]='=';
      bOdd := Str[n]='#';
      IF bEqu OR bOdd THEN INC(n) END;
*)
      IF (CAP(Str[n])>='A') & (CAP(Str[n])<='H') THEN (* get x (from) *)
        xFra:=ORD(CAP(Str[n]))-64;
        xTil:=xFra;
        INC(n);
      END;
      IF Str[n]='-' THEN
        INC(n);
        IF (CAP(Str[n])>='A') & (CAP(Str[n])<='H') THEN (* get x to *)
          xTil:=ORD(CAP(Str[n]))-64;
          INC(n);
        END;
      END;
      IF (Str[n]>='1') & (Str[n]<='8') THEN (* get y (from) *)
        yFra:=ORD(Str[n])-48;
        yTil:=yFra;
        INC(n);
      END;
      IF Str[n]='-' THEN
        INC(n);
        IF (Str[n]>='1') & (Str[n]<='8') THEN (* get y to *)
          yTil:=ORD(Str[n])-48;
          INC(n);
        END;
      END;
      IF (xTil>=xFra) & (yTil>=yFra) & ((xTil-xFra+1)*(yTil-yFra+1)<=MaxFields) THEN
        (*store the qualifier: field,rows or rectangles (upto 9 fields) *)
(*$IF Test0 *)
  WRITELN(s('Scan.StoreQualiferOrt, n=')+l(n)+s(' BrikNr=')+l(BrikNr));
(*$ENDIF *)
        WITH sdArr[1,BrikNr] DO
          IF Qualifiers<MaxQualifiers THEN INC(Qualifiers) END;
          Qarr[Qualifiers].Fields:=0;
          FOR x:=xFra TO xTil DO
            FOR y:=yFra TO yTil DO
              IF Qarr[Qualifiers].Fields<MaxFields THEN
                INC(Qarr[Qualifiers].Fields);
              END;
              Qarr[Qualifiers].Field[Qarr[Qualifiers].Fields]:=10*y+x;
(*$IF Test0 *)
  WRITELN(s('Scan.StoreQualiferOrt, f=')+l(10*y+x));
(*$ENDIF *)
            END;
          END;
        END;
      ELSIF (xTil<xFra) & (yTil<yFra) THEN
        (* store the qualifier: diagonal *)
(*$IF Test0 *)
  WRITELN(s('Scan.StoreQualiferDiag'));
(*$ENDIF *)
        WITH sdArr[1,BrikNr] DO
          IF Qualifiers<MaxQualifiers THEN INC(Qualifiers) END;
          Qarr[Qualifiers].Fields:=0;
          y:=yTil;
          FOR x:=xTil TO xFra DO
            IF Qarr[Qualifiers].Fields<MaxFields THEN
              INC(Qarr[Qualifiers].Fields);
            END;
            Qarr[Qualifiers].Field[Qarr[Qualifiers].Fields]:=10*y+x;
            INC(y);
          END;
        END;
      ELSE
        Err:=1;
      END;
    ELSE
      INC(n);
    END;
    Ch:=Str[n];
  END;

  IF PatMirror THEN
(*$IF Test0 *)
  WRITELN(s('Scan.Mirror'));
(*$ENDIF *)
    sdSize:=2;
    sdArr[2]:=sdArr[1];
    FOR BrikNr:=1 TO Pieces DO
      WITH sdArr[2,BrikNr] DO
        FOR q:=1 TO Qualifiers DO
          WITH Qarr[q] DO
            FOR f:=1 TO Fields DO
              Field[f]:=Field[f] DIV 10 * 10 +9-Field[f] MOD 10;
            END;
          END;
        END;
      END;
    END;
  END;

  IF PatReverse THEN
(*$IF Test0 *)
  WRITELN(s('Scan.Reverse'));
(*$ENDIF *)
    FOR n:=1 TO sdSize DO
      sdArr[sdSize+n]:=sdArr[n];
      FOR BrikNr:=1 TO Pieces DO
        IF ODD(BrikNr) THEN (* swap H/S *)
          swp:=sdArr[sdSize+n,BrikNr];
          sdArr[sdSize+n,BrikNr]:=sdArr[sdSize+n,BrikNr+1];
          sdArr[sdSize+n,BrikNr+1]:=swp;
        END;
        WITH sdArr[sdSize+n,BrikNr] DO
          FOR q:=1 TO Qualifiers DO
            WITH Qarr[q] DO
              FOR f:=1 TO Fields DO
                Field[f]:=Field[f] MOD 10 +90-Field[f] DIV 10 *10;
              END;
            END;
          END;
        END;
      END;
    END;
    sdSize:=sdSize*2;
  END;
  RETURN(Err);
END Scan;

PROCEDURE ExprOK(VAR stit:STILLINGTYPE; TrNr:INTEGER (*; gfMoves:BOOLEAN; nMoves:CARDINAL*) ):BOOLEAN;
VAR
  piece,sdNr,F,fra:CARDINAL;
  Q:INTEGER;
  mask:ARRAY[11..88] OF BOOLEAN;
  OK:BOOLEAN;
PROCEDURE OKCnt(sdNr:CARDINAL):BOOLEAN;
BEGIN
  FOR piece:=1 TO Pieces DO
    WITH sdArr[sdNr,piece] DO
      IF CountIt THEN
        IF (sdCnt[piece]<CountMin) OR (sdCnt[piece]>CountMax) THEN
          (*$IF Test0 *)
          IF TrNr>159 THEN
            WRITELN(s('ExprOk.CutCount, piece=')+l(piece)+s(' Qualifiers=')+l(Qualifiers));
            FOR F:=1 TO Pieces DO
              WRITE(lf(F,4)+lf(sdCnt[piece],2)+lf(CountMin,2)+lf(CountMax,2));
              IF F MOD 6=0 THEN WRITELN(0) END;
            END;
          END;
          (*$ENDIF *)
          RETURN(FALSE);
        END;
      END;
    END;
  END;
  RETURN(TRUE);
END OKCnt;
PROCEDURE OkPos(sdNr:CARDINAL):BOOLEAN;
BEGIN
  FOR piece:=1 TO Pieces DO
    WITH sdArr[sdNr,piece] DO
      FOR Q:=1 TO Qualifiers DO
        WITH Qarr[Q] DO
          (*$IF Test0 *)
          OK:=FALSE;
          IF TrNr>159 THEN
            WRITELN(s('ExprOk.CutPos, Fields=')+l(Fields)+s(' Q=')+l(Q)+s(' Field[1]=')+l(Field[1])+s(' stit[Field[1]]=')+c(stit[Field[1]])+s(' Nr=')+l(GetNr[stit[Field[1]]]));
          END;
          (*$ENDIF *)
          F:=1;
          OK:=FALSE;
          WHILE ~OK & (F<=Fields) DO
            IF (*mask[Field[F]] &*) (GtNr[stit[Field[F]]]=piece) THEN
              OK:=TRUE;
              (*$IF Test0 *)
              IF TrNr>159 THEN
                WRITELN(s('ExprOk.CutPos, ')+s(' F=')+l(F));
              END;
              (*$ENDIF *)
              (*mask[Field[F]]:=FALSE;*)
            END;
            INC(F);
          END;
          IF ~OK THEN
            (*$IF Test0 *)
            IF TrNr>159 THEN
              WRITELN(s('ExprOk.CutPos, ')+s(' piece=')+l(piece));
            END;
            (*$ENDIF *)
            RETURN(FALSE);
          END;
        END;
      END;
    END;
  END;
  RETURN(TRUE);
END OkPos;
BEGIN
(*
  IF gfMoves & (TrNr<INTEGER(nMoves)) THEN
    RETURN(FALSE);
  END;
*)
  IF PatWhite & (stit[HvisTur]='S') THEN
    (*$IF Test0 *)
    IF TrNr>160 THEN
      WRITELN(s('ExprOk.CutWhite'));
    END;
    (*$ENDIF *)
    RETURN(FALSE);
  END;

  IF PatBlack & (stit[HvisTur]<>'S') THEN
    (*$IF Test0 *)
    IF TrNr>159 THEN
      WRITELN(s('ExprOk.CutBlack'));
    END;
    (*$ENDIF *)
    RETURN(FALSE);
  END;

  fra:=1;
  IF ~OKCnt(1) THEN
    IF PatReverse THEN
      IF OKCnt(sdSize) THEN
        IF PatMirror THEN
          fra:=3;
        ELSE
          fra:=2;
        END;
      ELSE
        RETURN(FALSE);
      END;
    ELSE
      RETURN(FALSE);
    END;
  END;
(*FOR piece:=11 TO 88 DO mask[piece]:=TRUE END;*)

  FOR sdNr:=fra TO sdSize DO (*should only check reversed if Count matched reversed*)
    IF OkPos(sdNr) THEN
      (*$IF Test0 *)
      WRITELN(s('ExprOk.TRUE, TrNr=')+l(TrNr));
      (*$ENDIF *)
      RETURN(TRUE);
    END;
  END;
  RETURN(FALSE);
END ExprOK;

(* formatter st2 til fast længde l og concat til st med ' ' på *)

(*$ copydyn:=FALSE *)
PROCEDURE ConcatF(VAR st:ARRAY OF CHAR; st2:ARRAY OF CHAR; ll:CARDINAL);
VAR
  n:INTEGER;
  s1,s2:CARDINAL;
BEGIN
  s2:=Length(st2);
  IF s2>ll THEN
    s1:=Length(st);
    Concat(st,st2);
    st[s1+ll]:=' ';
    st[s1+ll+1]:=0C;
  ELSE
    Concat(st,st2);
    FOR n:=s2 TO ll DO
      ConcatChar(st,' ');
    END;
  END;
END ConcatF;

(* lave liste over spil i pig fil path20, op til 1000 *)
(* (global) Later=9 to skip cache use *)
(* (global) Later=2 to append while listing *)
PROCEDURE LL20(wp:WindowPtr):INTEGER;
CONST
  traeknrdelta=4;
  MinfmaxMin=2;
VAR
  actual,nn,nOld,m,Adr,Skip,Stop,MaxSkip,nTal,
  dbgsz,LLPh,szh,firstfmax,NoRemV:LONGINT;
  fmax,nsz,posi,nnn,       dbgpType,dbgpGame,dbgpOld,Minfmax:CARDINAL;
  c1,c2,c3,c4  :CHAR;
  st,st2       :STR77;
  Sign,err,NIKS,NoRemF,INVERSE,ECOkeys:BOOLEAN;
  gnr,Takt     :INTEGER;
  LLh          :TextListPtr;
  msg          :IntuiMessagePtr;
  p            :ARRAY[0..78] OF CHAR;
  pc           :ARRAY[0..16] OF CHAR;
  itx          :IntuiText;
  rp           :RastPortPtr;
  PIGstat      :LONGINT;
  class        :IDCMPFlagSet;
  gad          :GadgetPtr;
  mcode,dbgpNxt:CARDINAL;

  t            :TRKDATA;
  MoveTyp      :MOVETYPE;
  movenr,move8 :SHORTCARD;
  stit         :STILLINGTYPE;
  cfra         :CHAR;
  OldgExtras   :DATARR;
  UDV          :LONGINT;
  micros1,micros2,seconds1,seconds2:LONGINT;
  MovesSize,CommentsSize,gSz,bSz,mSz  :CARDINAL;
  nMoves,nComments,nVariant,mvnr,maxmvnr,tnrp4,tnrm4:CARDINAL;
  fSpecial,FILT20,D1,D2,D3,NoCut,S4,OK,D1S,Diff,FirstSave,
  gFlagMoves,stitEQstart,stibEQstart,stitEQstib,stibWhite,winOn,cacheOn :BOOLEAN;
  ExpressionSearch:BOOLEAN; (* gFlags[gExt17] *)
  sc:SHORTCARD;
  MaxTraekB,MovesSizeB,nVariantB:CARDINAL;

  CountTotMoves, CountTot:LONGINT;
(*
  Cb,Cl,Cs,Ct,Cr:CARDINAL;
*)
(*$IF XchangeChk *)
  (* optalt slåede brikker i parti, der gennemsøges *)
  CountOfb,CountOfl,CountOfs,CountOft,
  CountOfB,CountOfL,CountOfS,CountOfT:INTEGER;

  (* optalt slåede brikker i stilling ved søg stilling *)
  CountStb,CountStl,CountSts,CountStt,
  CountStB,CountStL,CountStS,CountStT:INTEGER;
(*$ENDIF *)
PROCEDURE WrStat;
BEGIN
  PIGstat:=PIGstat0+PIGstat1+PIGstat2+PIGstat3;
  ValToStr(PIGstat,FALSE,p,10,6,' ',err);
  IF err THEN
    p:='';
  END;
  ConcatChar(p,'/');
  ValToStr(PIGtotal,FALSE,pc,10,1,' ',err);
  IF err THEN
    pc:='error';
  END;
  Concat(p,pc);
  ConcatChar(p,'+');
  ValToStr(PIGdeleted,FALSE,pc,10,1,' ',err);
  IF err THEN
    pc:='error';
  END;
  Concat(p,pc);
(*$IF Test0 *)
  WRITELN(s('WrStat ')+s(p));
(*$ENDIF *)
  PrintIText(rp,ADR(itx),202,230-11);
END WrStat;
PROCEDURE WrTime;
BEGIN
  IF winOn THEN
    CurrentTime(ADR(seconds2),ADR(micros2));
    ValToStr(seconds2-seconds1,FALSE,p,10,1,' ',err);
    ConcatChar(p,'s');
  (*
    ValToStr((micros2-micros1) DIV 10000 ,FALSE,st,10,1,' ',err);
    Concat(p,st);
  *)
    PrintIText(rp,ADR(itx),300,1);
  END;
END WrTime;
PROCEDURE GetSpil():BOOLEAN;
BEGIN
  (* læs spil *)
  NIKS:=FALSE;
(*$IF Test0 *)
  WRITELN(s('GetSpil, Adr=')+l(Adr));
(*$ENDIF *)
  GetPos(dbf,Adr);
  ReadBytes(dbf,ADR(GameSize),2,actual);
  IF actual=2 THEN
(*$IF Test0 *)
  WRITELN(s('LL20 læs spil ADR=')+l(Adr)+s(' GameSize=')+l(GameSize)+s(' actual=')+l(actual));
(*$ENDIF *)
    IF dbgs<LONGINT(GameSize) THEN
      Deallocate(dbg);
      Alloc(dbg,dbgs,SIZE(dbg^),GameSize,GameSize,2);
(*$IF Test0 *)
  WRITELN(s('LL20 ny dbgs=')+l(dbgs));
(*$ENDIF *)
    END;
    IF (LONGINT(GameSize)>dbgs) OR (GameSize<6) THEN
(*$IF Test0 *)
  WRITELN(s('NIKS1898=TRUE ')+l(GameSize));
(*$ENDIF *)
      SetPos(dbf,Adr+2+LONGINT(GameSize));
      NIKS:=TRUE;               
    ELSE
      ReadBytes(dbf,dbg,3,actual);
(*$IF Test0 *)
IF actual=3 THEN
  WRITELN(s('læst 3'));
END;
(*$ENDIF *)
    END;
  END;
  RETURN(~NIKS);
END GetSpil;
PROCEDURE SaveGame();
VAR
  Ok:BOOLEAN;
  actual:LONGINT;
BEGIN
  IF FirstSave THEN
(*$IF Test0 *)
  WRITELN(s('LL20.SaveGamefirst'));
(*$ENDIF *)
    Save20init(path20ud);
    FirstSave:=FALSE;
  END;
  IF dbg<>NIL THEN
(*$IF Test0 *)
  WRITELN(s('LL20.SAVEGAMEwr, GameSize=')+l(GameSize));
(*$ENDIF *)
    WriteBytes(dbfud,ADR(GameSize),2,actual);
(*$IF Test0 *)
  WRITELN(s('LL20. Actual=')+l(actual));
(*$ENDIF *)
    WriteBytes(dbfud,dbg,GameSize,actual);
(*$IF Test0 *)
  WRITELN(s('LL20. Actual=')+l(actual));
(*$ENDIF *)
    IF (actual>0) & (actual<LONGINT(GameSize)) THEN (* fjern det delvist gemte *)
(*$IF Test0 *)
  WRITELN(s('LL20. Actual>0 & ~Ok'));
(*$ENDIF *)
      SetPos(dbfud,ldbfud);
    END;
  END;
END SaveGame;
BEGIN
(*$IF Test0 *)
  WRITELN(s('LL20'));
(*$ENDIF *)
  Lookup(dbf,path20,FilBufferSzRead*FilBufferSzBig*4,FALSE);
  nTal:=0;
  ECOkeys:=FALSE;
  nOld:=0;
  gnr:=-8;
  PIGtotal:=0;
  PIGdeleted:=0;
  PIGlength:=0;
  PIGstat0:=0;
  PIGstat1:=0;
  PIGstat2:=0;
  PIGstat3:=0;
  UDV:=1;
  Minfmax:=MinfmaxMin;
  FirstSave:=TRUE;
  cacheOn:=Later<>9;
  winOn:=wp<>NIL;
  IF winOn THEN
    rp:=wp^.rPort;
    WITH itx DO
      frontPen:=1;
      backPen:=0;
      drawMode:=DrawModeSet{dm0};
      leftEdge:=0;
      topEdge:=0;
      iTextFont:=NIL;
      iText:=NIL;
      nextText:=NIL;
    END;
    itx.iText :=ADR(p);
(*
    WrStat;
*)
  ELSE
    msg:=NIL;
  END;
  IF dbf.res=done THEN
    gnr:=-7;
    ReadChar(dbf,c1);ReadChar(dbf,c2);ReadChar(dbf,c3);ReadChar(dbf,c4);
    IF (c1='S') & (c2='K') & (c3='2') & (c4>='0') & (c4<='9') THEN
      gnr:=-6; 
      Alloc(dbg,dbgs,SIZE(dbg^),16384,4096,8);

      IF dbg<>NIL THEN
        WHILE (LL=NIL) & (LLSIZE>16) DO
(*$IF Test0 *)
  WRITELN(s('LL20.Allocate LLSIZE=')+l(LLSIZE)+s(' bytes=')+l(LLSIZE*TSIZE(TextListRec)));
(*$ENDIF *)
          Allocate(LL,LLSIZE*TSIZE(TextListRec));
          IF LL=NIL THEN
            LLSIZE:=LLSIZE DIV 2;
          ELSE
            FOR m:=1 TO LLSIZE DO
              LL^[m].Text:=NIL;
            END;
          END;
        END;

        IF LL<>NIL THEN
          gnr:=-5;
          IF cacheOn THEN
            IF LotMemOn THEN
              IF (LLCACHESIZE=MINLLCACHESIZE) THEN
                LLCACHESIZE:=MAXLLCACHESIZE;
              END;
            ELSE
              IF (LLCACHESIZE=MAXLLCACHESIZE) THEN
                LLCACHESIZE:=MINLLCACHESIZE;
              END;
            END;
            EraseCache;
          END;

          Skip:=0;
          Stop:=0;
          IF gFlags[gSkip] THEN (* Skip value + flag *)
            StrToVal(gFilters[gSkip],Skip,Sign,10,err);
            IF err THEN
              Skip:=0;
            END;
            IF gInverse[gSkip] THEN 
              Stop:=Skip;
              Skip:=0;
            END;
          END;
          MaxSkip:=Skip;

          NoRemF:=gFlags[gPosition];(*MaxExtras-4, max lines to keep Info for*)  
          IF NoRemF THEN
            StrToVal(gFilters[gPosition],NoRemV,Sign,10,err);
            IF err THEN
              NoRemV:=0;
            END;
            UDV:=16;
          END;

          ExpressionSearch:=gFlags[gExt17];
          IF ExpressionSearch THEN (* search expression *)
            IF Scan(gFilters[gExt17])=0 THEN END;
            fSpecial:=TRUE;
          ELSE
            fSpecial:=gInverse[gPosition]; (*position search flag *)
(*$IF Test0 *)
IF fSpecial THEN
  WRITELN(s('gInverseMax-4'));
END;
(*$ENDIF *)

            IF fSpecial THEN (* count the captured pieces in stilling *)
              CountTotMoves:=0;
              CountTot:=0;
  (*
              Cb:=0;Cl:=0;Cs:=0;Ct:=0;Cd:=0;
  *)
  (*$IF XchangeChk *)
              CountStb:=8;
              CountStl:=2;
              CountSts:=2;
              CountStt:=2;
              CountStB:=8;
              CountStL:=2;
              CountStS:=2;
              CountStT:=2;
              FOR nnn:=11 TO 88 DO
                IF (stilling[nnn]='t') OR (stilling[nnn]='r') THEN
                  DEC(CountStt);
                ELSIF stilling[nnn]='s' THEN
                  DEC(CountSts);
                ELSIF stilling[nnn]='l' THEN
                  DEC(CountStl);
                ELSIF (stilling[nnn]='b') OR (stilling[nnn]='e') THEN
                  DEC(CountStb);
                ELSIF (stilling[nnn]='T') OR (stilling[nnn]='R') THEN
                  DEC(CountStT);
                ELSIF stilling[nnn]='S' THEN
                  DEC(CountStS);
                ELSIF stilling[nnn]='L' THEN
                  DEC(CountStL);
                ELSIF (stilling[nnn]='B') OR (stilling[nnn]='E') THEN
                  DEC(CountStB);
                END;
              END;
(*$ENDIF *)
              stibEQstart:= Equal(StartStilling,start.Still);
              stibWhite:= start.Still[HvisTur]<>'S';
(*$IF Test0 *)
  IF stibEQstart THEN WRITELN(s('stibEQstart')) END;
(*$ENDIF *)
            END;
          END;
          gFlagMoves:=gFlags[gMoves];(*MaxExtras-2*)
          IF gFlagMoves THEN (* gMoves, Moves ind i antal HEL-træk (nMoves i HALV)*)
            fSpecial:=TRUE;
            StrToVal(gFilters[gMoves],szh,Sign,10,err);
            IF err OR (szh<0) THEN
              nMoves:=0;
            ELSE
              szh:=szh+szh; (* konverter indtastede heltræk til halvtræk *)
              IF szh>65535 THEN
                nMoves:=65535;
              ELSE
                nMoves:=CARDINAL(szh);
              END;
            END;
          END;

          D1S:=FALSE;
          nsz:=15; (* NameSize in list *)
          IF gFlags[gIC] THEN (* gIC, Variant value (HALV-TRÆK)*)
(*$IF Test0 *)
  WRITELN(s('-1'));
(*$ENDIF *)
            StrToVal(gFilters[gIC],szh,Sign,10,err);
            IF err OR (szh<0) THEN
              nVariant:=0;
            ELSE
              IF szh>999 THEN
                nVariant:=999;
              ELSE
                nVariant:=CARDINAL(szh);
                IF nVariant=0 THEN
                  D1S:=TRUE;
                  nVariant:=1000;
                  fmax:=0; (* 0 eller 2 ? *)
                  firstfmax:=0;
                  nsz:=14;
                ELSE
(*
                  IF ~gFlagMoves THEN
                    gFlagMoves:=TRUE;  
                    nMoves:=nVariant DIV 2;
                  END;
*)
                END;
              END;
            END;
(*$IF Test0 *)
  WRITELN(s('nVariant=')+l(nVariant));
(*$ENDIF *)
            IF nVariant>0 THEN 
              dbgp:=0;
              AppendMoves;
              dbgp:=0;
              GetCard(gSz);
(*$IF Test0 *)
  WRITELN(s('gSz=')+l(gSz));
(*$ENDIF *)
              IF (gSz>0) & (gSz<1000) THEN (* kopier presset spil til dbgt *)
                bSz:=gSz-gSz DIV 8;
                MaxTraekB:=MaxTraek-MaxTraek DIV 8;
                mSz:=gSz-1-(gSz-1) DIV 8; (* gir gamesize-1 samme bytesize? *)
                IF mSz<>bSz THEN
                  mSz:=bSz-gSz MOD 8;
                END;
                Allocate(dbgt,bSz);
                IF dbgt=NIL THEN 
                  nVariant:=0;
                ELSE
(*$IF FALSE *)
  WRITELN(s('Variant overføres til dbgt, gSz=')+l(gSz)+s(' mSz=')+l(mSz)+s(' bSz=')+l(bSz)+s(' nVariant=')+l(nVariant));
  READs(st);
(*$ENDIF *)
                  FOR nnn:=0 TO bSz-1 DO
                    dbgt^[nnn]:=dbg^[nnn+dbgp];
(*$IF FALSE *)
  WRITELN(lf(nn,3)+lf(dbgt^[nnn],3));
(*$ENDIF *)
                  END;
                END;
              ELSE
                nVariant:=0;
              END;
            END;
            IF nVariant<>0 THEN
              nVariantB:=nVariant-nVariant DIV 8;
              fSpecial:=TRUE;
            ELSE
               (* error *)
            END;
          END;

          IF gFlags[gComments] THEN (* MaxExtras-3*)
            fSpecial:=TRUE;
            StrToVal(gFilters[gComments],szh,Sign,10,err);
            IF err OR (szh<0) THEN
              nComments:=0;
            ELSE
              IF szh>65535 THEN
                nComments:=65535;
              ELSE
                nComments:=CARDINAL(szh);
              END;
            END;
          END;

          INVERSE:=gInverse[gExt17];
(*$IF Test0 *)
IF INVERSE THEN  
  WRITELN(s('INVERSE'));
ELSE
  WRITELN(s('NOT INV'));
END;
(*$ENDIF *)

          OldgExtras:=gExtras;     
          CurrentTime(ADR(seconds1),ADR(micros1));
          
          (* !!!! here is Wh1,2 og Bl1,2 made out of Filter entries *)
          IF gFlags[gWhite] OR gFlags[gBlack] THEN
            Copy(Wh1,gFilters[gWhite]);Whn:=1;
            m:=FirstPos(Wh1,1,'&');
(*$IF Test *) WRITELN(s('WB ')+l(m));(*$ENDIF *)
            IF m>0 THEN (* split string *)
(*$IF Test *) WRITELN(s('ssW: '));(*$ENDIF *)
              Wh1[m]:=0C;Whn:=2; Wh2:=''; 
              REPEAT
                INC(m);
                ConcatChar(Wh2,Wh1[m]);
              UNTIL Wh1[m]=0C;
            END;
            (* Insert Space after , if missing *)
            m:=FirstPos(Wh1,1,',')+1;
(*$IF Test *) WRITELN(s('isW, m=')+l(m));(*$ENDIF *)
            IF (m>0) & (Wh1[m]<>' ') THEN
              Insert(Wh1,m,' ');
(*$IF Test *) WRITELN(s('isW! ')+s(Wh1));(*$ENDIF *)
            END;
            Copy(Bl1,gFilters[gBlack]);Bln:=1;
            m:=FirstPos(Bl1,1,'&');
            IF m>0 THEN (* split string *)
              Bl1[m]:=0C;Bln:=2; Bl2:=''; 
              REPEAT
                INC(m);
                ConcatChar(Bl2,Bl1[m]);
              UNTIL Bl1[m]=0C;
            END;
            (* Insert Space after , if missing *)
            m:=FirstPos(Bl1,1,',')+1;
            IF (m>0) & (Bl1[m]<>' ') THEN
              Insert(Bl1,m,' ');
            END;
          END;
   
          REPEAT

            IF GetSpil() THEN
              (* skip slettede spil *)
              WHILE ~dbf.eof & (dbf.res=done) & ((dbg^[2]>127)<>INVERSE) DO
(*$IF Test0 *)
  WRITELN(s('skipped, Adr=')+l(Adr)+s(' Gsz=')+l(GameSize));
(*$ENDIF *)
                Adr:=Adr+LONGINT(GameSize)+2;
(*$IF Test0 *)
  WRITELN(s('skipped, NyAdr=')+l(Adr));
(*$ENDIF *)
                SetPos(dbf,Adr);
                IF GetSpil() THEN
                  INC(PIGdeleted);
                END;
                
              END;

              IF ~NIKS THEN
(*$IF Test0 *)
  WRITELN(s('Læser: ')+l(GameSize-3));
(*$ENDIF *)
                ReadBytes(dbf,LONGINT(dbg)+3,GameSize-3,actual);
              END;
              dbgp:=0;
              IF ~NIKS & (dbf.res=done) & (LONGINT(GameSize)-3=actual) THEN
(*$IF Test0 *)
  WRITELN(s('LL20 spil læst'));
(*$ENDIF *)
(*$IF Test0 *)IF nTal<1 THEN WRITELN(s('CC')+l(nTal)) END; (*$ENDIF *)
 (*$IF Test0 *) IF nTal < 0 THEN WRITELN(s('2246 ')+l(PIGtotal)) END;  (*$ENDIF *)
                INC(nTal);  
                (* hvis nødvendigt prøv at udvide liste størrelse *)
                IF (nTal>LLSIZE) & (LLSIZE*2<=MAXLLSIZE*UDV) THEN
(*$IF Test0 *)
  WRITELN(s('LL20.AllocateH LLSIZE*2=')+l(LLSIZE*2)+s(' bytes=')+l(2*LLSIZE*TSIZE(TextListRec)));
(*$ENDIF *)
                  Allocate(LLh,2*LLSIZE*TSIZE(TextListRec));
                  IF LLh<>NIL THEN
(*$IF Test0 *)
  WRITELN(s('Double Array from LLSIZE=')+l(LLSIZE));
(*$ENDIF *)
                    FOR m:=1 TO LLSIZE DO
                      LLh^[m]:=LL^[m];
                    END;
                    FOR m:=LLSIZE+1 TO LLSIZE*2 DO
                      LLh^[m].Text:=NIL;
                    END;
                    LLSIZE:=LLSIZE*2;
                    Deallocate(LL);
                    LL:=LLh;
                    LLh:=NIL;
                  END;
                END;

                IF (nTal<=LLSIZE) & (LONGINT(GameSize)-3=actual) THEN

                  INC(PIGtotal);
                  GetInfo(FALSE);

                  dbgpGame:=dbgp;

                  IF (PIGtotal=1) & (spSTR(spWhite)^[0]='W') & (spSTR(spWhite)^[1]=0C)
                  &  (spSTR(spBlack)^[0]='B') & (spSTR(spBlack)^[1]=0C) THEN
                    ECOkeys:=TRUE;
                  END;

                  IF ECOkeys THEN
                    IF (PIGtotal=1600) THEN
                      Minfmax:=1;
                    ELSIF (PIGtotal=1900) THEN
                      Minfmax:=0;
                    END;
                  END;

                  D1:=FALSE;
                  D2:=FALSE;
                  D3:=FALSE;
                  NoCut:=FALSE;
                  FILT20:=Filter20();
                  IF ~FILT20 THEN
                    IF fSpecial THEN
                      (* -4=gPosition -3=gComments -2=gMoves -1=gVariant *)
                      GetCard(MovesSize);
                      CountTot:=CountTot+INTEGER(MovesSize);
                      MovesSizeB:=MovesSize-MovesSize DIV 8;
  
                      (* beregn comments position *)
                      IF MovesSize=0 THEN
                        dbgpNxt:=dbgp;
                      ELSE
                        dbgpNxt:=dbgp+MovesSizeB;
                      END;
  (*$IF Test0 *)
    WRITELN(s('LL20.Moves.sz')+l(MovesSize)+s(' dbgp=')+l(dbgp)+s(' dbgpNxt=')+l(dbgpNxt));
  (*$ENDIF *)
                      IF gFlagMoves THEN
  (*$IF Test0 *)
    WRITELN(s('D2'));
  (*$ENDIF *)
                        D2:=MovesSize<nMoves;
                        IF gInverse[gMoves] THEN (*MaxExtras-2*)
                          D2:=~D2;
                        END;
                      END;

                      IF gFlags[gIC] & (nVariant>0) & ~D2 THEN
                        D1:= ~D1S & (MovesSize<nVariant);
  (*$IF FALSE *)
    WRITELN(s('D1, MSZB=')+l(MovesSizeB)+s(' MTB=')+l(MaxTraekB));
  (*$ENDIF *)
                        nnn:=0;
                        WHILE ~D1 & (nnn<MaxTraekB) & (nnn<MovesSizeB) & (nnn<nVariant) DO
                          sc:=dbg^[dbgp+nnn];
                          IF (nnn>=mSz) & (sc>127) THEN (* slet msb hvis *)
                            sc:=sc-128;
                          END;
  (*$IF FALSE *)
    WRITELN(lf(nnn,3)+lf(sc,4)+c('=')+l(dbgt^[nnn]));
  (*$ENDIF *)
  
                          D1:=dbgt^[nnn]<>sc;
                          INC(nnn);
                        END;
                        IF D1S THEN (* variant=0 (nVariant=1000) gir Special, juster kriterie *)
                          IF nnn>0 THEN
                            IF D1 THEN
                              DEC(nnn);
                            END;
                            D1:= (nnn<fmax) OR (nnn<=Minfmax);
                          END;
                        END;
  (*$IF FALSE *)
    WRITELN(s('D1, nnn=')+l(nnn));
    IF D1 THEN WRITELN(s('Drop!')) ELSE WRITELN(s('Not Drop!')) END;
  (*$ENDIF *)
                      END;

(* gExt17 *)
                      IF ((gInverse[gPosition]) OR ExpressionSearch) & ~D2 THEN (* pos search *)
                        (* NoCut:= (MovesSize<nVariant); *)
                        (* scan game for the position *)
                        NoCut:=TRUE; (* different positions *)
                        OK:=TRUE;
(*$IF XchangeChk *)
                        CountOfb:=0;
                        CountOfl:=0;
                        CountOfs:=0;
                        CountOft:=0;
                        CountOfB:=0;
                        CountOfL:=0;
                        CountOfS:=0;
                        CountOfT:=0;
(*$ENDIF *)
                        Takt:=0;
                        IF FENstr[0]=0C THEN
                          stit:=StartStilling;
                          stitEQstart:=TRUE;
                          IF ~stibWhite THEN
                            Takt:=1;
                          END;
                          stitEQstib:=stibEQstart;
                        ELSE
                          FENtoSTILLING(stit,FENstr);
                          FENstr[0]:=0C;
                          IF stibWhite=(stit[HvisTur]='S') THEN
                            Takt:=1;
                          END;
                          stitEQstart:=FALSE;
                          IF stibEQstart THEN
                            stitEQstib:=FALSE;
                          ELSE
                            stitEQstib:= Equal(stit,start.Still);
(*$IF Test0 *)
  WRITELN(s('stitEQstib: ')+b(stitEQstib));
(*$ENDIF *)
                          END;
                        END;
                        (* stit       : startstillLoadedGame *)
                        (* stibEQstart: startstillBoardGame =udgangsstilling  *)
                        (* stitEQstart: startstillLoadedGame=udgangsstilling *)
                  
                        IF ExpressionSearch THEN (* make piece-counts to stit *)
                          IF stitEQstart THEN
(*$IF Test0 *)
  WRITELN(s('ExprSearch,stitEqstart'));
(*$ENDIF *)
                            sdCnt[sdCntb]:=8;
                            sdCnt[sdCntB]:=8;
                            sdCnt[sdCnts]:=2;
                            sdCnt[sdCntS]:=2;
                            sdCnt[sdCntl]:=2;
                            sdCnt[sdCntL]:=2;
                            sdCnt[sdCntt]:=2;
                            sdCnt[sdCntT]:=2;
                            sdCnt[sdCntd]:=1;
                            sdCnt[sdCntD]:=1;
                            sdCnt[sdCntk]:=1;
                            sdCnt[sdCntK]:=1;
                          ELSE
                            FOR mvnr:=1 TO Pieces DO
                              sdCnt[mvnr]:=0;
                            END;
                            FOR mvnr:=11 TO 88 DO
                              IF stit[mvnr]<>' ' THEN
                                INC(sdCnt[GetNr[stit[mvnr]]]);
                              END;
                            END;
                          END;
                        END;

(*$IF Test0 *)
  WRITELN(s('POSITION: stib=')+b(stibEQstart)+s(' stit=')+b(stitEQstart)+s(' Takt=')+l(Takt));
(*$ENDIF *)
                        IF ~ExpressionSearch & (stibEQstart & stitEQstart OR stitEQstib) THEN (* on-board is with same startpositions *)
(*$IF Test0 *)
  WRITELN(s('POSITION: a&b OR c')); (*!!!!!! stib= still FEJLER!!!!! *)
(*$ENDIF *)
                          IF TraekNr<=traeknrdelta THEN
                            tnrm4:=0; 
                          ELSE
                            tnrm4:=CARDINAL(TraekNr-traeknrdelta);
                          END;
                          tnrp4:=CARDINAL(TraekNr+traeknrdelta);
                          IF tnrp4>MovesSize THEN
                            tnrp4:=MovesSize;
                          END;
                        ELSE
                          tnrm4:=0;
                          tnrp4:=MovesSize;
                        END;
  (*$IF Test0 *)
    WRITELN(s('NoCut, tnrm4=')+l(tnrm4)+s(' tnrp4=')+l(tnrp4)+s(' MovesSize=')+l(MovesSize)+s(' TraekNr=')+l(TraekNr));
  (*$ENDIF *)

                        mvnr:=0;
                        move8:=0;
                        IF ExpressionSearch & ExprOK(stit,mvnr (*,gFlagMoves,nMoves*) )
                        OR ~ExpressionSearch & (tnrm4=0) & Equal(stit,stilling) THEN
                          NoCut:=FALSE; (* stilling fundet! *)
                        ELSE
                          REPEAT
                            INC(mvnr);
  
      IF Press7 & (mvnr MOD 8=0) THEN
        movenr:=move8;
        move8:=0;
      ELSE
        movenr:=dbg^[dbgp];
        INC(dbgp); (* GetShortCard *)

        IF Press7 THEN
          move8:=move8+move8;
          IF movenr>127 THEN
            movenr:=movenr-128;
            INC(move8);
          END;
        END;
      END;
      IF OK THEN
        INC(CountTotMoves);
        GetMove(stit,t,movenr,Quick);
        OK:=t.Fra<89;
        IF OK THEN
          IF stit[HvisTur]='S' THEN (* så var sidste træk hvidt *)
(*$IF Test0 *)
  WRITELN(s('0.OK=')+b(OK));
(*$ENDIF *)
(*$IF XchangeChk *)
            IF EatChar<>' ' THEN (* hvis slag *)
              IF ExpressionSearch THEN (* cut possible here !!!!!!!!!!!! *)
                IF (EatChar='B') OR (EatChar=' ') THEN
                  DEC(sdCnt[sdCntB]);
                ELSIF EatChar='L' THEN
                  DEC(sdCnt[sdCntL]);
                ELSIF EatChar='S' THEN
                  DEC(sdCnt[sdCntS]);
                ELSIF (EatChar='T') OR (EatChar='R') THEN
                  DEC(sdCnt[sdCntT]);
                ELSIF EatChar='D' THEN (* for ExpressionSearch only *)
                  DEC(sdCnt[sdCntD]);
                END;
              ELSE
                IF (EatChar='B') OR (EatChar=' ') THEN
                  INC(CountOfB);
                  IF CountOfB>CountStB THEN OK:=FALSE;(* INC(Cb) *) (*$IF Test0 *) ; WRITELN(s('Cut B')); (*$ENDIF *)END;
                ELSIF EatChar='L' THEN
                  INC(CountOfL);
                  IF CountOfL>CountStL THEN OK:=FALSE;(* INC(Cl) *) (*$IF Test0 *) ; WRITELN(s('Cut L')); (*$ENDIF *)END;
                ELSIF EatChar='S' THEN
                  INC(CountOfS);
                  IF CountOfS>CountStS THEN OK:=FALSE;(* INC(Cs) *) (*$IF Test0 *) ; WRITELN(s('Cut S')); (*$ENDIF *)END;
                ELSIF (EatChar='T') OR (EatChar='R') THEN
                  INC(CountOfT);
                  IF CountOfT>CountStT THEN OK:=FALSE;(* INC(Ct) *) (*$IF Test0 *) ; WRITELN(s('Cut T')); (*$ENDIF *)END;
                END;
              END;
            END;
(*$ENDIF *)
(*$IF Test0 *)
  WRITELN(s('1.OK=')+b(OK));
(*$ENDIF *)
            IF ExpressionSearch THEN
              (* possible to look for cuts!!!!!!!!!!!!!!!!! *)
            ELSE
              IF OK THEN
                IF (stit[t.Til]='b') &  (t.Fra<29) THEN  (* unmoved pawn! (t.Fra>20) & *)
                  OK:=stilling[t.Fra]<>'b';
                END;
                IF (stit[t.Til]='k') THEN
                  OK:=stilling[t.Fra]<>'m';
                END;
                IF (stit[t.Til]='t') THEN
                  OK:=stilling[t.Fra]<>'r';
                END;
              END;
            END;
(*$IF Test0 *)
  WRITELN(s('2.OK=')+b(OK));
(*$ENDIF *)
          ELSE
(*$IF Test0 *)
  WRITELN(s('3.OK=')+b(OK));
(*$ENDIF *)
(*$IF XchangeChk *)
            IF EatChar<>' ' THEN (* hvis slag, adj & check material for cutoff *)
              IF ExpressionSearch THEN (* cut possible here !!!!!!!!!!!! *)
                IF (EatChar='b') OR (EatChar=' ') THEN
                  DEC(sdCnt[sdCntb]);
                ELSIF EatChar='l' THEN
                  DEC(sdCnt[sdCntl]);
                ELSIF EatChar='s' THEN
                  DEC(sdCnt[sdCnts]);
                ELSIF (EatChar='t') OR (EatChar='r') THEN
                  DEC(sdCnt[sdCntt]);
                ELSIF EatChar='d' THEN (* for ExpressionSearch only *)
                  DEC(sdCnt[sdCntd]);
                END;
              ELSE
                IF (EatChar='b') OR (EatChar=' ') THEN
                  INC(CountOfb);
                  IF CountOfb>CountStb THEN OK:=FALSE;(* INC(Cb) *) (*$IF Test0 *) ; WRITELN(s('Cut b')); (*$ENDIF *)END;
                ELSIF EatChar='l' THEN
                  INC(CountOfl);
                  IF CountOfl>CountStl THEN OK:=FALSE;(* INC(Cl) *) (*$IF Test0 *) ; WRITELN(s('Cut l')); (*$ENDIF *)END;
                ELSIF EatChar='s' THEN
                  INC(CountOfs);
                  IF CountOfs>CountSts THEN OK:=FALSE;(* INC(Cs) *) (*$IF Test0 *) ; WRITELN(s('Cut s')); (*$ENDIF *)END;
                ELSIF (EatChar='t') OR (EatChar='r') THEN
                  INC(CountOft);
                  IF CountOft>CountStt THEN OK:=FALSE;(* INC(Ct) *) (*$IF Test0 *) ; WRITELN(s('Cut t')); (*$ENDIF *)END;
                END;
              END;
            END;
(*$ENDIF *)
(*$IF Test0 *)
  WRITELN(s('4.OK=')+b(OK));
(*$ENDIF *)

            (* check for unmoved pawn/majesty/rook cutoff *)
            IF ExpressionSearch THEN
              (* possible to look for cut!!!!!!!!!!!!!!!!! *)
            ELSE
              IF OK THEN
                IF (stit[t.Til]='B') & (t.Fra>70) THEN  (* & (t.Fra<79) *)
                  OK:=stilling[t.Fra]<>'B';
                END;
                IF (stit[t.Til]='K') THEN
                  OK:=stilling[t.Fra]<>'M';
                END;
                IF (stit[t.Til]='T') THEN
                  OK:=stilling[t.Fra]<>'R';
                END;
              END;
            END;
(*$IF Test0 *)
  WRITELN(s('5.OK=')+b(OK));
(*$ENDIF *)
          END;
(*$IF Test0 *) ; IF ~OK THEN WRITELN(s('Cut in move ')+l(mvnr)) END; (*$ENDIF *)
  (*$IF Test0 *)
    WRITELN(s(' mvnr=')+lf(mvnr,2)+s(' ')+l(t.Fra)+l(t.Til)+c(stit[t.Til])+c(stilling[t.Fra]));
  (*$ENDIF *)
          IF OK THEN
            IF ExpressionSearch THEN
              (*NoCut:=gFlagMoves & (mvnr<nMoves) OR ~ExprOK(stit,mvnr (*,gFlagMoves,nMoves*) );*)
              NoCut:=~ExprOK(stit,mvnr (*,gFlagMoves,nMoves*) );
            ELSE
              IF mvnr>=tnrm4 THEN
                IF ~ODD(TraekNr-INTEGER(mvnr)+Takt) THEN
                  NoCut:=~Equal(stit,stilling);
                END;
              END;
            END;
          END;
        END;
      END;
  
  
                          UNTIL ~OK OR (mvnr>=tnrp4) OR ~NoCut;
    (*$IF Test0 *) IF OK & NoCut THEN WRITELN(s('Not cut, moves ')+l(mvnr)) END; (*$ENDIF *)
    (*$IF Test0 *)
      WRITELN(0);
    (*$ENDIF *)
                        END;   
                      END;
  
                      IF gFlags[gComments] THEN (* Comments antal tegn *)
  (*$IF Test0 *)
    WRITELN(s('D3 dbgp=')+l(dbgp)+s(' dbgpNxt=')+l(dbgpNxt));
  (*$ENDIF *)
                        dbgp:=dbgpNxt;
                        GetCard(CommentsSize);
  (*$IF Test0 *)
    WRITELN(s('D3 -2 CommentsSize=')+l(CommentsSize)+s(' dbgp=')+l(dbgp));
  (*$ENDIF *)
                        D3:=CommentsSize<nComments;
                        IF gInverse[gComments] THEN
                          D3:=~D3;
                        END;
                      END;
  
                    END;
                  END;

                  IF D1 OR D2 OR D3 OR NoCut OR FILT20 THEN
(*$IF Test0 *)
  WRITELN(s('LL20 Filter NIKS'));
(*$ENDIF *)
                    NIKS:=TRUE;
                  ELSE
                    IF Skip>0 THEN
                      DEC(Skip);
                      NIKS:=TRUE;
                    ELSE
                      gnr:=-4;
                      (* GetTextPGN: Append it all *)
                      IF Later=2 THEN
                        IF ~Quick THEN
                          dbgpOld:=dbgp;
                          dbgp:=dbgpGame;
                          IF GetMoves()>0 THEN
                            INC(dbg^[2]);
                            dbgp:=dbgpGame;
                            AppendMoves;
  (*$IF Test0 *)
    WRITELN(s('Converted...'));
  (*$ENDIF *)
                          END;
                          dbgp:=dbgpOld;                    
                        END;
                        SaveGame;
                      END;

                      IF LL^[nTal].Text=NIL THEN
                        IF ~NoRemF OR (nTal<=NoRemV) THEN
                          LL^[nTal].Text:=AllocMem(SIZE(st),MemReqSet{});
(* Allocate(LL^[nTal].Text,SIZE(st));*)
(*   
                          IF LL^[nTal].Text=NIL THEN
                            DEC(nTal);
  (*$IF Test0 *) IF nTal < 0 THEN WRITELN(s('2677 ')+l(PIGtotal)) END;  (*$ENDIF *)
                            DEC(actual); 
                          END;
*)
                        END;
                      ELSE
                        IF NoRemF & (nTal>NoRemV) THEN
(* Deallocate(LL^[nTal].Text);*)
                          FreeMem(LL^[nTal].Text,SIZE(st));
                          LL^[nTal].Text:=NIL;
                        END;
                      END;
    
                      IF Length(gExtras[gResult])>2 THEN
                        CASE gExtras[gResult,2] OF
                        | '0' : INC(PIGstat0);                   
                        | '1' : INC(PIGstat1);                   
                        | '2' : INC(PIGstat2);                   
                        ELSE    INC(PIGstat3);
                        END;
                      ELSE
                        INC(PIGstat3);
                      END;
(*$IF Test0 *)IF n<1 THEN WRITELN(s('AA')+l(nTal)) END; (*$ENDIF *)
                      IF LL^[nTal].Text<>NIL THEN
                        IF D1S THEN
                          IF (nnn>=Minfmax) & (nnn>fmax) THEN
  (*$IF Test0 *)
    WRITELN(s('Nymax=')+l(nnn));
  (*$ENDIF *)
                            fmax:=nnn;
                            firstfmax:=nTal;
                          END;
                          IF fmax>999 THEN
                            st:='   ';
                          ELSE
                            ValToStr(fmax,FALSE,st,10,3,' ',err);
                          END;
                          ValToStr(nTal+MaxSkip ,FALSE,pc,10,6,' ',err);
                          ConcatF(st,pc,6);
                        ELSE
                          ValToStr(nTal+MaxSkip ,FALSE,st,10,7,' ',err);
                          IF INVERSE THEN
                            st[0]:='X';
                          END;
                          ConcatChar(st,' ');
                        END;
                        ConcatChar(st,' ');
(*
                        IF (n=1) & (spSTR(spWhite)^[0]='W') & (spSTR(spWhite)^[1]=0C)
                        &  (spSTR(spBlack)^[0]='B') & (spSTR(spBlack)^[1]=0C) THEN
                          ECOkeys:=TRUE;
                        END;
*)
                        IF ECOkeys THEN (* 32+2*nsz, nsz=14|15 *)
                          Concat(st,'ECO: ');
                          IF spECO=NIL THEN
                            ConcatF(st,'??? ',4);
                          ELSE
                            ConcatF(st,spSTR(spECO)^,4);
                          END;
                          Copy(st2,spSTR (spSite)^);
                          IF spSTR(spEvent)^[0]<>0C THEN 
                            Concat(st2,spSTR(spEvent)^);
                          END;
                          ConcatF(st,st2,2*nsz+19);
                          Concat(st,'NIC: ');
                          IF spNIC=NIL THEN
                            ConcatF(st,'? ',2);
                          ELSE
                            ConcatF(st,spSTR(spNIC)^,2);
                          END;
                        ELSE
                          IF spNIC=NIL THEN
                            IF spECO=NIL THEN
                              ConcatF(st,'?          ',11);
                            ELSE
                              ConcatF(st,spSTR(spECO)^,11);
                            END;
                          ELSE
                            ConcatF(st,spSTR(spNIC)^,11);
                          END;
                          IF (spSTR(spSite)^[0]=0C) THEN
                            IF (spSTR(spEvent)^[0]=0C) THEN 
                              ConcatF(st,'*             ',14);
                            ELSE
                              Concat(st,' Ev:'); (* ,3 *)
                              ConcatF(st,spSTR(spEvent)^,10);
                            END;
                          ELSE
                            ConcatF(st,spSTR(spSite)^,14);
                          END;
                          ConcatF(st,spSTR(spWhite)^,nsz);
                          ConcatF(st,spSTR(spBlack)^,nsz);
  
                          ConcatF(st,gExtras[gResult],3);
  
                          ConcatF(st,gExtras[gDate],4);
                        END;
(*$ IF Demo *)
 IF (nTal MOD 80 =2) & (nTal>2) THEN
   st:='!!!! SHAREWARE VERSION, THE INFO FOR THIS GAME IS THEREFORE HIDDEN       !!!!';
 END;
(*$ ENDIF *)
                        Copy(LL^[nTal].Text^,st);   
(*$IF Test0 *)
  WRITELN(s(st));
(*$ENDIF *)
                      END;
                      LL^[nTal].Attr:=0;
                      LL^[nTal].Adrs:=Adr;
                      IF cacheOn & (nTal<=INTEGER(LLCACHESIZE)) THEN
                        SAVECACHE(nTal);
                      END;
                    END;
                  END;
                END;
              END; 
              IF NIKS THEN
                IF TRUE OR (nTal>0) THEN (* 'rollback' *)
                  DEC(nTal);
  (*$IF Test0 *) IF nTal < 0 THEN WRITELN(s('2799 ')+l(PIGtotal)) END;  (*$ENDIF *)
                ELSE
                (*$IF Test0 *)WRITELN(s('BBBB')+l(nTal)) (*$ENDIF *)
                END;
              END;
            END;
            IF winOn THEN
              LLPh:=LLP;
              LLP :=nTal;
              gnr:=EMPROC(wp,nTal>nOld);
              LLP:=LLPh;
              nOld:=nTal;

              IF gnr=-2 THEN
                IF (PIGtotal<1000) THEN
                  IF (PIGtotal MOD 10=0) THEN
                    WrStat;
                  END;
                ELSE
                  IF (PIGtotal MOD 100=0) THEN
                    WrStat;
                    IF PIGtotal MOD 1000=0 THEN
                      WrTime;
                    END;
                  END;
                END;
              END;
            END;
(*$IF Test0 *)
  WRITELN(l(nTal)+s(',')+l(LLP));
  IF LL=NIL THEN WRITELN(s('LL=NIL')) END;
(*$ENDIF *)
          UNTIL dbf.eof OR ~(dbf.res=done) OR (actual<LONGINT(GameSize)-3) OR (nTal>LLSIZE) OR (Stop>0) & (nTal=Stop) OR (gnr=0) OR (gnr=1);
          gExtras:=OldgExtras;
(*
          IF winOn THEN WrStat END;
*)
          IF nTal>LLSIZE THEN
            ValToStr(MaxSkip+nTal-1,FALSE,st,10,1,' ',err);
            gFlags[gSkip]:=TRUE;
            Copy(gFilters[gSkip],st);
            nTal:=LLSIZE;
  (*$IF Test0 *) IF nTal < 0 THEN WRITELN(s('2839 ')+l(PIGtotal)) END;  (*$ENDIF *)
          END;
          IF D1S & (firstfmax>0) THEN
            IF ECOkeys THEN
              firstfmax:=nTal;
              pc:='?? ';
              FOR posi:=0 TO 2 DO
                pc[posi]:=LL^[nTal].Text^[posi+16];
              END;
  (*$IF Test0 *)
    WRITELN(s('gECO=')+s(gExtras[gECO]));
  (*$ENDIF *)
              Copy(gExtras[gECO],pc);
  (*$IF Test0 *)
    WRITELN(s('gECO=')+s(pc));
  (*$ENDIF *)
              IF winOn THEN
                p:='ECOkey='; 
                Concat(p,pc);
                PrintIText(rp,ADR(itx),500,219);
              END;
            ELSE
              posi:=0;
              WHILE (LL^[firstfmax].Text^[11]=' ') & (firstfmax<nTal) DO
                INC(firstfmax);
              END;
              Diff:=FALSE;
              REPEAT
                pc[posi]:=LL^[firstfmax].Text^[posi+11];
  (*$IF FALSE *)
    FOR nn:=0 TO posi DO
      WRITE(c(pc[nn]));
    END;
    WRITELN(s('=pc[posi] '));
  (*$ENDIF *)
                FOR nn:=firstfmax+1 TO nTal DO
                  IF LL^[nn].Text^[11]<>' ' THEN
                    Diff:=LL^[nn].Text^[posi+11]<>pc[posi];
                  END;
                END;
                INC(posi);
              UNTIL Diff OR (posi>11);
              IF Diff THEN
                DEC(posi);
              END;
              WHILE (posi>0) & (pc[posi-1]<'0') DO
                DEC(posi);
              END;
              IF Diff & (posi>0) & (pc[posi-1]<='9')
              & (pc[posi]>='0') & (pc[posi]<'9') THEN
                DEC(posi);
              END;
              pc[posi]:=0C;
              IF posi>0 THEN
  (*$IF Test0 *)
    WRITELN(s('gNIC=')+s(gExtras[gNIC]));
  (*$ENDIF *)
                Copy(gExtras[gNIC],pc);
  (*$IF Test0 *)
    WRITELN(s('gNIC=')+s(pc));
  (*$ENDIF *)
                IF winOn THEN
                  p:='NICkey='; 
                  Concat(p,pc);
                  PrintIText(rp,ADR(itx),500,219); (* 237,241 *)
                END;
              END;
  (*$IF Test0 *)
    WRITELN(c('"')+s(pc)+c('"'));
  (*$ENDIF *)
            END;
          END;
          WrTime;
          IF gInverse[gPosition] & winOn THEN (*MaxExtras-4*)
            ValToStr(CountTot,FALSE,st,10,1,' ',err);
            ValToStr(CountTotMoves,FALSE,p,10,1,' ',err);
            ConcatChar(p,'/');
            Concat(p,st);
            PrintIText(rp,ADR(itx),360,1);
          END;
        END;

        (* INC(nTal); *) (*!!!!!!!!! store antal*)

(*$IF Test *)
  WRITELN(l(nTal)+s(' games listet af LL20.'));

(*
  WRITELN(s('I LL er nu:'));
  FOR m:=1 TO nTal DO 
    WRITELN(s(LL^[m].Text^));
    WRITELN(s('Adresse=')+l(LL^[m].Adrs));
  END;
*)

(*$ENDIF *)

        (* dealloker evt tidligere større liste *)

        IF (nTal+50<LLP) & winOn THEN
          p:='   Freeing RAM... ';
          PrintIText(rp,ADR(itx),30,219);
        END;
        FreeLL(nTal+1);
(*
        FOR m:=nTal+1 TO LLP DO
           IF LL^[m].Text<>NIL THEN
             FreeMem(LL^[nTal].Text,SIZE(st));
             LL^[nTal].Text:=NIL;
( Deallocate(LL^[m].Text); )
          END;
        END;
*)
        IF (nTal+50<LLP) & winOn THEN
          p:='                 ';
          PrintIText(rp,ADR(itx),50,219);
        END;
        LLP:=nTal;

        Deallocate(dbg);
      END;
    END;
  END;
  IF (Later=2) & ~FirstSave THEN
    Close(dbfud);
  END;
  Close(dbf);
(*$ IF Test *)
   WRITELN(s('CountTot     =')+l(CountTot));
   WRITELN(s('CountTotMoves=')+l(CountTotMoves)+s('   Cuts because of:'));
(*
   WRITELN(s('Ct=')+l(Ct));
   WRITELN(s('Cs=')+l(Cs));
   WRITELN(s('Cl=')+l(Cl));
   WRITELN(s('Cb=')+l(Cb));
*)
(*$ENDIF *)
  RETURN(gnr);  
END LL20;

(* kopiere alle uslettede spil fra pth (PIG) over til pthud (PIG) (append) *)
PROCEDURE Append20(pth,pthud:ARRAY OF CHAR);
(*$ IF NoProfiler *)
VAR
  GameSize,n:CARDINAL;
  ldbf,actual,actualud,Ind,Ud,Adrt:LONGINT;
  c1,c2,c3,c4:CHAR;
  OK,err,Slut:BOOLEAN;
  pst:ARRAY[0..180] OF CHAR;
  st2:ARRAY[0..20] OF CHAR;
PROCEDURE Info;
BEGIN
  ValToStr(Ind,FALSE,pst,10,7,' ',err);
  ValToStr(Ud ,FALSE,st2,10,7,' ',err);
  IF Slut THEN
    Concat(pst,Q[Qgamesread]^);
    Concat(pst,pth);
  END;
  ConcatChar(pst,12C);
  Concat(pst,st2);
  IF Slut THEN
    Concat(pst,Q[Qgamesappended]^);
    Concat(pst,pthud);
  END;
END Info;
(*$ ENDIF *)
BEGIN
(*$ IF NoProfiler *)
  OK:=FALSE;
  Slut:=FALSE;
  Ind:=0;
  Ud:=0;
  Lookup(dbf,pth,FilBufferSzRead*FilBufferSzBig*4,FALSE);
  IF dbf.res=done THEN
    Lookup(dbfud,pthud,FilBufferSzWrite*FilBufferSzBig,FALSE);
    IF dbfud.res=notFound THEN (* Create a new GameBase *)
      Lookup(dbfud,pthud,FilBufferSzWrite*FilBufferSzBig,TRUE);
      IF dbfud.res=done THEN
        WriteChar(dbfud,'S');
        WriteChar(dbfud,'K');
        WriteChar(dbfud,'2');
        WriteChar(dbfud,'0');
        OK:=TRUE;
      END;
    ELSE
      ReadChar(dbfud,c1);ReadChar(dbfud,c2);ReadChar(dbfud,c3);ReadChar(dbfud,c4);
      IF (c1='S') & (c2='K') & (c3='2') & (c4>='0') & (c4<='9') THEN
        OK:=TRUE;
        FileSystem.Length(dbfud,ldbf);
        SetPos(dbfud,ldbf);
      END;
    END;

    IF OK & (dbfud.res=done) THEN
      ReadChar(dbf,c1);ReadChar(dbf,c2);ReadChar(dbf,c3);ReadChar(dbf,c4);
      IF (c1='S') & (c2='K') & (c3='2') & (c4>='0') & (c4<='9') THEN
        Alloc(dbg,dbgs,SIZE(dbg^),16384,4096,2);
        IF dbg<>NIL THEN
          REPEAT
            ReadBytes(dbf,ADR(GameSize),2,actual);
            IF dbgs<LONGINT(GameSize) THEN
              Deallocate(dbg);
              Alloc(dbg,dbgs,SIZE(dbg^),GameSize,GameSize,2);
            END;
            IF actual=2 THEN INC(Ind) END;
            IF dbgs<LONGINT(GameSize) THEN
              GetPos(dbf,Adrt);
              SetPos(dbf,Adrt+LONGINT(GameSize));
            ELSE
              ReadBytes(dbf,dbg,3,actual);

            (* kopier kun ikke-slettede spil *)
              IF (actual=3) & (dbg^[2]<128) THEN (* så er spil ikke markeret slettet *)
                ReadBytes(dbf,LONGINT(dbg)+3,GameSize-3,actual);
                IF actual=LONGINT(GameSize)-3 THEN
                  WriteBytes(dbfud,ADR(GameSize),2,actualud);
                  WriteBytes(dbfud,dbg,GameSize,actualud);
                  INC(Ud);
                  IF TRUE OR (Ud MOD 10=0) THEN
                    Info;
                    PrintInfoWIN(0,45,ADR(pst));
                  END;
                END;
              ELSE
                GetPos(dbf,Adrt);
                SetPos(dbf,Adrt+LONGINT(GameSize)-3);
              END;

            END;
          UNTIL ((actual<LONGINT(GameSize)-3) OR (actualud<LONGINT(GameSize))) & (dbg^[2]<128)
          OR (dbf.eof) OR (dbf.res<>done) OR (dbfud.res<>done) OR MsgCloseInfoWIN();
          Deallocate(dbg);
        END;
      END;
    END;
    Close(dbfud);
  END;
  Close(dbf);
  Slut:=TRUE;
  Info;
  n:=SimpleWIN(ADR(pst));
(*$ ENDIF *)
END Append20;

VAR
  ldbf:LONGINT;

PROCEDURE Mark20init(pth:ARRAY OF CHAR):BOOLEAN;
VAR
  actual:LONGINT;
  c1,c2,c3,c4:CHAR;
  OK:BOOLEAN;
BEGIN
  OK:=FALSE;
  Lookup(dbf,pth,FilBufferSzWrite,FALSE);
  IF dbf.res=done THEN
    ReadChar(dbf,c1);ReadChar(dbf,c2);ReadChar(dbf,c3);ReadChar(dbf,c4);
    IF (c1='S') & (c2='K') & (c3='2') & (c4>='0') & (c4<='9') THEN
      FileSystem.Length(dbf,ldbf);
      OK:=TRUE;
    END;
  END;
  RETURN(OK);
END Mark20init;

PROCEDURE Mark20body(Adr:LONGINT; VAR Slettet:SHORTINT);
VAR
  actual:LONGINT;
  GameSize:CARDINAL;
  c1,c2,c3,c4:CHAR;
BEGIN
  IF Adr<ldbf-5 THEN
    SetPos(dbf,Adr+4);
    ReadChar(dbf,c2);
    IF dbf.res=done THEN
(*$IF Test0 *)
  WRITELN(s('M20b:læst ')+l(Adr)+s(' c2=')+l(SHORTCARD(c2)));
(*$ENDIF *)
      IF Slettet=-1 THEN
        IF SHORTCARD(c2)>127 THEN
          Slettet:=0;
        ELSE
          Slettet:=1;
        END;
      END;
      IF Slettet=1 THEN
(*$IF Test0 *)
  WRITELN(s('M20b:SLET ')+l(Adr)+s(' c2=')+l(SHORTCARD(c2)));
(*$ENDIF *)
        INCL(CAST(SHORTSET,c2),7);
(*$IF Test0 *)
  WRITELN(s('M20b:SLET ')+l(Adr)+s(' c2=')+l(SHORTCARD(c2)));
(*$ENDIF *)
      ELSIF Slettet=0 THEN
(*$IF Test0 *)
  WRITELN(s('M20b:U-SLET ')+l(Adr)+s(' c2=')+l(SHORTCARD(c2)));
(*$ENDIF *)
        EXCL(CAST(SHORTSET,c2),7);
(*$IF Test0 *)
  WRITELN(s('M20b:U-SLET ')+l(Adr)+s(' c2=')+l(SHORTCARD(c2)));
(*$ENDIF *)
      END;
      SetPos(dbf,Adr+4);
      WriteChar(dbf,c2);
    END;
  END;
END Mark20body;

PROCEDURE Mark20close;
BEGIN
  SetPos(dbf,ldbf);    
  Close(dbf);
END Mark20close;

(* Åben file, marker Current spil som slettet eller uslettet, luk file *)
(* Slettet: =1 for Slet, =0 for uslet, =-1 for Toggle *)
PROCEDURE Mark20(pth:ARRAY OF CHAR; Adr:LONGINT; Slettet:SHORTINT);
VAR
  pst:ARRAY[0..180] OF CHAR;
BEGIN
  IF Mark20init(pth) THEN
    Mark20body(Adr,Slettet);
    Mark20close;
    IF Slettet=1 THEN
      Copy(pst,Q[Qgamedeleted]^);
    ELSIF Slettet=0 THEN
      Copy(pst,Q[Qgameundeleted]^);
    ELSE
      Concat(pst,Q[Qf7toundelete]^); (* ToggleText *)
    END;
    Concat(pst,pth);
    Concat(pst,' \n');
    IF SimpleWIN(ADR(pst))=0 THEN END;
  END;
END Mark20;


(*  PGN standard infos:
[Event "?"]
[Site "dk"]
[Date "1994.??.??"]
[Round "78"]
[White "hvid, fornavn"]
[Black "sort, efternavn"]
[Result "1/2-1/2"]
  PGN ekstra infos: 
[WhiteTitle "GM"]*
[BlackTitle "FM"]*
[WhiteElo "2123"]*
[BlackElo "1934"]*
[WhiteUSCF "2223"]*
[BlackUSCF "2034"]*
[NIC "KP.1.12.44"]*
[Annotator "name"]*
[EventDate "1994.12.21"]*
[EventSponsor "Gevalia"]*
[Section "Open"]*
[Stage "Semifinal"]*
[Board "5"]*
[Opening "Spanish"]*
[Variation "Exchange"]*
[SubVariation "5.f6"]*
[ECO "XXDD/DD"]*
[Time "HHMMSS"]*
  PGN ustandard infos: 
[Source "own"]
[Info "jada"]
[WhiteCountry "DEN"]
[BlackCountry "USA"]

  SK20 filformat:
  ----- Game (0..n): ------ (2+13+2+2 -> 2+435+1025+30000 = 19 -> 31462)
    GameSize:CARDINAL;  (InfoBlock+MovesBlock+CommentsBlock, size=19-32765)
    --Info: -- (2+15 .. 2+15+90+228 bytes = 17..435)
      InfoSize     :CARDINAL; (rest of Info in BYTES)
      GameType     :SHORTCARD; (bit7=Slettet, bit6-1=FALSE, bit0=QuickPressed)
      ( Skak20 + PGN standard infos:)
-12   Event        :STR20;
-11   Site         :STR20; (NIC.Place)
-10 -6DateResult   :SHORTCARD; (bit  7..5=[0='',]1=1-0,2=1/2-1/2,3=0-1,4='*'], 4..0=Date (0..31))
-10   YearMonth    :CARDINAL; (PGN.Date, NIC.Year, bit 15..4=Year (0 or >999), 3..0=Month (0..12))
-9    Round        :SHORTCARD; (0..63, bit 7=WhiteElo, 6=BlackElo Present)
-8    White        :STR25;
-7    Black        :STR25;
      ( Skak20 standard, PGN ekstra infos:)
  
      (* er der kun hvis henholdsvis Round bit7 , bit6 er ON *)
-3 -1 WhiteElo     :INTEGER; (negativ=USCF ellers Elo, 0 eller 700-3000)
-2  0 BlackElo     :INTEGER; (negativ=USCF ellers Elo, 0 eller 700-3000)

-5 -4 Titles       :SHORTCARD; (White=0..3, Black=4..7 [0='',1=GM,2=WGM,IM,WIM,FM])
      (SKAK20 + PGN Ekstra infos :)
      (Named by a ShortCard 1-17 (max 32) preceeding the string, 0=terminal)
 1    NIC          :STR11; (NIC.Keycode)
 2    Annotator    :STR15;
 3    Source       :STR19; (NIC.Source)
 4    Info         :STR12; (NIC.Info)
 5    EventDate    :STR10;
 6    EventSponsor :STR20;
 7    Section      :STR15;
 8    Stage        :STR15;
 9    Board        :STR3;
10    Opening      :STR15;
11    Variation    :STR15;
12    SubVariation :STR15;
13    ECO          :STR7; ("XXDD/DD")
14    Time         :STR6; ("HHMMSS")
15    WhiteCountry :STR3;
16    BlackCountry :STR3;
17    FEN          :STR100;
    --Moves: -- (2-1025 bytes, brug max 1023 halvtræk)
      MovesSize:CARDINAL;(rest of Moves in Moves, BYTES=MovesSize-MovesSize DIV 8;
      --Move: --
        MoveNr: SHORTCARD; (* vilkårligt antal halvtræk (brug max 1023) *)
      --
    --Comments: -- (2-30000)
      CommentsSize:CARDINAL;(rest of Comments in BYTES)
      --Comment: -- (2-4098)
        CommentMove: CARDINAL; (CommentMove>=1023 terminerer, kun nødvendig hvis CommentsSize>0);
        Comment:ARRAY[0..4095] OF CHAR; (max 4096)
      --       
    --         
  --
*)

VAR
  n:INTEGER;

BEGIN
(*$IF Test *)
  WRITELN(s('Skak20Fil.1'));
(*$ENDIF *)
  dbg:=NIL;
  Press7:=TRUE;
  LLP:=0;
  LL:=NIL;
  FENstr[0]:=0C;
  IF LotMemOn THEN
    LLCACHESIZE:=MAXLLCACHESIZE;
  ELSE
    LLCACHESIZE:=MINLLCACHESIZE;
  END;

  FOR n:=1 TO MAXLLCACHESIZE DO LLCACHE[n]:=NIL; END;
  LogVersion("Skak20Fil.def",Skak20FilDefCompilation);
  LogVersion("Skak20Fil.mod",Skak20FilModCompilation);

(*$IF Test *)
  WRITELN(s('Skak20Fil.2'));
(*$ENDIF *)

CLOSE
(*$IF Test *)
  WRITELN(s('Skak20Fil.3'));
(*$ENDIF *)
  FreeLL(1);
(*$IF Test *)
  WRITELN(s('Skak20Fil.4'));
(*$ENDIF *)
END Skak20Fil.

(*
PROCEDURE GetNrOld(LocaleCh:CHAR):CARDINAL;
BEGIN
 IF    (LocaleCh=LP('b')) OR (LocaleCh=LP('e')) THEN RETURN(sdCntb)
 ELSIF (LocaleCh=LP('B')) OR (LocaleCh=LP('E')) THEN RETURN(sdCntB)
 ELSIF (LocaleCh=LP('t')) OR (LocaleCh=LP('r')) THEN RETURN(sdCntt)
 ELSIF (LocaleCh=LP('T')) OR (LocaleCh=LP('R')) THEN RETURN(sdCntT)
 ELSIF LocaleCh=LP('s') THEN RETURN(sdCnts)
 ELSIF LocaleCh=LP('S') THEN RETURN(sdCntS)
 ELSIF LocaleCh=LP('l') THEN RETURN(sdCntl)
 ELSIF LocaleCh=LP('L') THEN RETURN(sdCntL)
 ELSIF LocaleCh=LP('d') THEN RETURN(sdCntd)
 ELSIF LocaleCh=LP('D') THEN RETURN(sdCntD)
 ELSIF (LocaleCh=LP('k')) OR (LocaleCh=LP('m')) THEN RETURN(sdCntk)
 ELSIF (LocaleCh=LP('K')) OR (LocaleCh=LP('M')) THEN RETURN(sdCntK)
 ELSE   RETURN(0)
 END;
END GetNrOld;
*)


IMPLEMENTATION MODULE SkakFil;(* Lær-Skak, (c) E.B.Madsen DK 91-95 *)

(* MANGLER AT LAVE NAG KONVERTERING PÅ HENT + Chk af GEM !!!!! *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Demo:=FALSE *)
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

(*
  6-94 {} as comments, (OK)
  6-94 . as space, WORKING 
  6-94 ! as rest of line is comment if in first position, (OK)
  2-95 Save SK20 flyttet til SkakFil fra Skak
  2-95 PGN TAGS Compare nu med mellemrum, OK
  2-95 Load PGN, Underforvandling skippes nu som fra-gæt, (OK)
  2-95 Filter (OK)
  4-95 DelToggle (OK)
 12-95 Slet rem[0] også (OK)
*)

FROM SYSTEM IMPORT
  ADR, ADDRESS, ASSEMBLE, CAST, BPTR, BYTE, SHORTSET, TSIZE;
(*
FROM ExecD IMPORT
  MsgPort, MsgPortPtr, MemReqSet;
FROM ExecL IMPORT
  ReplyMsg, GetMsg, AllocMem, FreeMem;
*)
FROM IntuitionD IMPORT
  WindowPtr,IntuiText,IntuiMessagePtr,GadgetPtr, IDCMPFlagSet, IDCMPFlags;
FROM IntuitionL IMPORT
  PrintIText;
FROM GraphicsD IMPORT
  RastPortPtr, DrawModeSet, DrawModes;
FROM FileSystem IMPORT
  File, FileMode, FileModeSet, Lookup, Close, ReadBytes, WriteBytes, 
  Response, ReadChar, WriteChar, GetPos, SetPos;
IMPORT FileSystem;
FROM String IMPORT
  Copy, LastPos, Length, Compare, Concat, ConcatChar, CapString, Occurs, Insert, Delete;
FROM StrSupport IMPORT
  Valid,Eq,Gt,IntVal,CardVal,UpCase,UpString,TrimString,TrimVal,in;
FROM Conversions IMPORT
  ValToStr,StrToVal;
FROM Heap IMPORT
  Allocate, Deallocate, Largest, Available;
FROM RequestFile IMPORT
  FileRequest;
FROM ReqSupport IMPORT
  SimpleFileRequester, wsptr, POSTEXT, MIDTEXT, NEGTEXT, reqOn;
FROM PointerSprites IMPORT
  SetPtr;
FROM QISupport IMPORT
  SimpleWIN, TwoGadWIN, ThreeGadWIN,
  VINDUE, STRINGPTR, CREATEWIN, OPENWIN, WAITWIN, CLOSEWIN, MSGWIN, PRINTWIN,
  EscWIN, OkWIN, DropWIN, ActiveWIN, InactiveWIN, OpenInfoWIN, PrintInfoWIN,
  CloseInfoWIN, swptr, CenterWIN, MsgCloseInfoWIN;
(*$IF Test *)
  FROM W IMPORT
    WRITELN, WRITE, CONCAT, s, l, lf, c, b, READs;
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
  TextListPtr,TextList,TextListRec, STR97,
  PIGtotal,PIGdeleted,PIGlength,PIGstat0,PIGstat1,PIGstat2,PIGstat3, 
  path20,EMPROC, DATARR, LotMemOn, gExt17, Later2, VariantTil,Lates1,Lates2,
  Lates3;

FROM SkakBrain IMPORT
  DoMove, GetNext, Mirror, DoMoveC, DoMoveOk, Equal, still, FindTrk, 
  MOVETYPE, MOVETYPES, MOVEnormal, MOVEslag, TRAEKDATA, TRKDATA, stVsum, Push, stilling,
  Spil, SPIL, start, STRING, STIL, MaxHalvTraek, GetMove, GetMoveNr, STRINGptr,
  AddHistory,ClearHistory, ATTRTYPES, ATTRTYPE;
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
  Q214,Q215,Q216,Q217,Q218,Q219,TxOK,TxMID,TxUPS,TxSti,TxNavn,TxUdvalgt,
  TxGEMSPIL,TxSKRIVSPIL,TxIKKEGEMT,TxIKKEUDSKREVET
;

TYPE
  (* pt $0..$139 in PGN standard (here just $0..$21) *)
  NAGarr=ARRAY[0..21] OF ARRAY[0..21] OF CHAR;
  STR97PTR=POINTER TO STR97;

CONST
  SkakFilModCompilation="813";
(*
  NAGs = NAGarr{'','!','?','!!','??','!?','?!',
                'forced','singular move','worst move','drawish',
                'equal, quiet','equal, active','unclear position',
                'W. slight advantage'  ,'B. slight advantage',
                'W. moderate advantage','B. moderate advantage',
                'W. decisive advantage','B. decisive advantage',
                'W. crushing advantage','B. crushing advantage'};
*)                

VAR
  (* kar:ADDRESS; *) (* kommentar (for gl.) *)
  CFilPos,x:LONGINT;

  KD:CARDINAL;
  FilType:INTEGER;

VAR
(*
NAG    Interpretation
---    --------------
  0    null annotation
  1    good move (traditional "!")
  2    poor move (traditional "?")
  3    very good move (traditional "!!")
  4    very poor move (traditional "??")
  5    speculative move (traditional "!?")
  6    questionable move (traditional "?!")
  7    forced move (all others lose quickly)
  8    singular move (no reasonable alternatives)
  9    worst move
 10    drawish position
 11    equal chances, quiet position                            (==)
 12    equal chances, active position                           (=)
 13    unclear position                                         (~)
 14    White has a slight advantage                             (+=)
 15    Black has a slight advantage                             (-=)
 16    White has a moderate advantage                           (++=)
 17    Black has a moderate advantage                           (--=)
 18    White has a decisive advantage                           (+-)
 19    Black has a decisive advantage                           (-+)
 20    White has a crushing advantage (Black should resign)     (++)
 21    Black has a crushing advantage (White should resign)     (--)

 22    White is in zugzwang
 23    Black is in zugzwang
 24    White has a slight space advantage
 25    Black has a slight space advantage
 26    White has a moderate space advantage
 27    Black has a moderate space advantage
 28    White has a decisive space advantage
 29    Black has a decisive space advantage
 30    White has a slight time (development) advantage
 31    Black has a slight time (development) advantage
 32    White has a moderate time (development) advantage
 33    Black has a moderate time (development) advantage
 34    White has a decisive time (development) advantage
 35    Black has a decisive time (development) advantage
 36    White has the initiative
 37    Black has the initiative
 38    White has a lasting initiative
 39    Black has a lasting initiative
 40    White has the attack
 41    Black has the attack
 42    White has insufficient compensation for material deficit
 43    Black has insufficient compensation for material deficit
 44    White has sufficient compensation for material deficit
 45    Black has sufficient compensation for material deficit
 46    White has more than adequate compensation for material deficit
 47    Black has more than adequate compensation for material deficit
 48    White has a slight center control advantage
 49    Black has a slight center control advantage
 50    White has a moderate center control advantage
 51    Black has a moderate center control advantage
 52    White has a decisive center control advantage
 53    Black has a decisive center control advantage
 54    White has a slight kingside control advantage
 55    Black has a slight kingside control advantage
 56    White has a moderate kingside control advantage
 57    Black has a moderate kingside control advantage
 58    White has a decisive kingside control advantage
 59    Black has a decisive kingside control advantage
 60    White has a slight queenside control advantage
 61    Black has a slight queenside control advantage
 62    White has a moderate queenside control advantage
 63    Black has a moderate queenside control advantage
 64    White has a decisive queenside control advantage
 65    Black has a decisive queenside control advantage
 66    White has a vulnerable first rank
 67    Black has a vulnerable first rank
 68    White has a well protected first rank
 69    Black has a well protected first rank
 70    White has a poorly protected king
 71    Black has a poorly protected king
 72    White has a well protected king
 73    Black has a well protected king
 74    White has a poorly placed king
 75    Black has a poorly placed king
 76    White has a well placed king
 77    Black has a well placed king
 78    White has a very weak pawn structure
 79    Black has a very weak pawn structure
 80    White has a moderately weak pawn structure
 81    Black has a moderately weak pawn structure
 82    White has a moderately strong pawn structure
 83    Black has a moderately strong pawn structure
 84    White has a very strong pawn structure
 85    Black has a very strong pawn structure
 86    White has poor knight placement
 87    Black has poor knight placement
 88    White has good knight placement
 89    Black has good knight placement
 90    White has poor bishop placement
 91    Black has poor bishop placement
 92    White has good bishop placement
 93    Black has good bishop placement
 84    White has poor rook placement
 85    Black has poor rook placement
 86    White has good rook placement
 87    Black has good rook placement
 98    White has poor queen placement
 99    Black has poor queen placement
100    White has good queen placement
101    Black has good queen placement
102    White has poor piece coordination
103    Black has poor piece coordination
104    White has good piece coordination
105    Black has good piece coordination
106    White has played the opening very poorly
107    Black has played the opening very poorly
108    White has played the opening poorly
109    Black has played the opening poorly
110    White has played the opening well
111    Black has played the opening well
112    White has played the opening very well
113    Black has played the opening very well
114    White has played the middlegame very poorly
115    Black has played the middlegame very poorly
116    White has played the middlegame poorly
117    Black has played the middlegame poorly
118    White has played the middlegame well
119    Black has played the middlegame well
120    White has played the middlegame very well
121    Black has played the middlegame very well
122    White has played the ending very poorly
123    Black has played the ending very poorly
124    White has played the ending poorly
125    Black has played the ending poorly
126    White has played the ending well
127    Black has played the ending well
128    White has played the ending very well
129    Black has played the ending very well
130    White has slight counterplay
131    Black has slight counterplay
132    White has moderate counterplay
133    Black has moderate counterplay
134    White has decisive counterplay
135    Black has decisive counterplay
136    White has moderate time control pressure
137    Black has moderate time control pressure
138    White has severe time control pressure
139    Black has severe time control pressure
*)

(*$ IF Test *)
PROCEDURE QQ(txt:ARRAY OF CHAR; VAR stilling:STILLINGTYPE);
VAR
  n:INTEGER;
BEGIN
  FOR n:=11 TO 88 DO
    IF stilling[n]<' ' THEN
      WRITELN(s('QQ: n=')+l(n)+s(' ch=')+l(ORD(stilling[n]))+s(txt));
    END;
  END;
END QQ;
(*$ ENDIF *)

(* fejltekst på max 32 tegn til brug med FileSystem *)
PROCEDURE FilErr(res:Response; VAR st:ERRSTR);
BEGIN
  CASE res OF
    | done              : Copy(st,Q[Fxs01]^);
    | notdone           : Copy(st,Q[Fxs02]^);
    | lockErr           : Copy(st,Q[Fxs03]^);
    | openErr           : Copy(st,Q[Fxs04]^);
    | readErr           : Copy(st,Q[Fxs05]^);
    | writeErr          : Copy(st,Q[Fxs06]^);
    | seekErr           : Copy(st,Q[Fxs07]^);
    | memErr            : Copy(st,Q[Fxs08]^);
    | inUse             : Copy(st,Q[Fxs09]^);
    | notFound          : Copy(st,Q[Fxs10]^);
    | diskWriteProtected: Copy(st,Q[Fxs11]^);
    | deviceNotMounted  : Copy(st,Q[Fxs12]^);
    | diskFull          : Copy(st,Q[Fxs13]^);
    | deleteProtected   : Copy(st,Q[Fxs14]^);
    | writeProtected    : Copy(st,Q[Fxs15]^);
    | notDosDisk        : Copy(st,Q[Fxs16]^);
    | noDisk            : Copy(st,Q[Fxs17]^);
  ELSE                    Copy(st,Q[Fxs18]^);
  END;
END FilErr;

PROCEDURE LP(ch:CHAR):CHAR; (* Localize Piece name (DK to Locale) *)
VAR
  c:CHAR;
BEGIN
  IF InterOn THEN (* TRUE=Engelsk R/W i Ikke-engelske udgaver *)
    CASE ch OF
      | 'r' : c:=TxrI;
      | 't' : c:=TxtI;
      | 's' : c:=TxsI;
      | 'l' : c:=TxlI;
      | 'd' : c:=TxdI;
      | 'm' : c:=TxmI;
      | 'k' : c:=TxkI;
      | 'e' : c:=TxeI;
      | 'b' : c:=TxbI;
      | 'R' : c:=TxRI;
      | 'T' : c:=TxTI;
      | 'S' : c:=TxSI;
      | 'L' : c:=TxLI;
      | 'D' : c:=TxDI;
      | 'M' : c:=TxMI;
      | 'K' : c:=TxKI;
      | 'E' : c:=TxEI;
      | 'B' : c:=TxBI;
      | '.' : c:='.';
    ELSE
      c:=' ';
    END;
  ELSE
    CASE ch OF
      | 'r' : c:=Txr;
      | 't' : c:=Txt;
      | 's' : c:=Txs;
      | 'l' : c:=Txl;
      | 'd' : c:=Txd;
      | 'm' : c:=Txm;
      | 'k' : c:=Txk;
      | 'e' : c:=Txe;
      | 'b' : c:=Txb;
      | 'R' : c:=TxR;
      | 'T' : c:=TxT;
      | 'S' : c:=TxS;
      | 'L' : c:=TxL;
      | 'D' : c:=TxD;
      | 'M' : c:=TxM;
      | 'K' : c:=TxK;
      | 'E' : c:=TxE;
      | 'B' : c:=TxB;
      | '.' : c:='.';
    ELSE
      c:=' ';
    END;
  END;
  RETURN(c);
END LP;

PROCEDURE FENtoSTILLING(VAR stilling:STILLINGTYPE; fen:ARRAY OF CHAR);
VAR
  n,x,y,p,i:INTEGER;
BEGIN
  IF HIGH(fen)>29 THEN 
    i:=0;
    FOR y:=8 TO 1 BY -1 DO
      x:=1;
      REPEAT
        p:=y*10+x;
        IF (fen[i]<'9') & (fen[i]>'0') THEN
          FOR n:=1 TO ORD(fen[i])-48 DO
            stilling[p]:=' ';
            INC(x);
            INC(p);
          END;
        ELSE
          CASE fen[i] OF
          | 'P' : stilling[p]:='b';
          | 'R' : stilling[p]:='t';
          | 'N' : stilling[p]:='s';
          | 'B' : stilling[p]:='l';
          | 'Q' : stilling[p]:='d';
          | 'K' : stilling[p]:='k';
          | 'p' : stilling[p]:='B';
          | 'r' : stilling[p]:='T';
          | 'n' : stilling[p]:='S';
          | 'b' : stilling[p]:='L';
          | 'q' : stilling[p]:='D';
          | 'k' : stilling[p]:='K';
          ELSE    stilling[p]:=' ';
          END;
          INC(x);
        END;
        INC(i);
      UNTIL (x>8) OR (fen[i]=0C);
      IF fen[i]<>0C THEN INC(i) END;
    END;
    IF fen[i]='w' THEN
      stilling[HvisTur]:='H';
    ELSE
      stilling[HvisTur]:='S';
    END;
    IF (fen[i]<>0C) & (fen[i+1]<>0C) THEN i:=i+2; END;
    IF fen[i]<>0C THEN (* rokaderet *)
      REPEAT
        CASE fen[i] OF
        | 'K' : IF stilling[18]='t' THEN stilling[18]:='r' END;
        | 'Q' : IF stilling[11]='t' THEN stilling[11]:='r' END; 
        | 'k' : IF stilling[88]='T' THEN stilling[88]:='R' END;
        | 'q' : IF stilling[81]='T' THEN stilling[81]:='R' END;
        ELSE
        END;
        INC(i);
      UNTIL (fen[i]=' ') OR (fen[i]=0C);
    END;
    IF ((stilling[11]='r') OR (stilling[18]='r')) & (stilling[15]='k') THEN stilling[15]:='m' END;
    IF ((stilling[81]='R') OR (stilling[88]='R')) & (stilling[85]='K') THEN stilling[85]:='M' END;
    IF fen[i]=' ' THEN
      INC(i);
      IF (fen[i]>='a') & (fen[i]<='h') THEN (* en-passant *)
        n:=ORD(fen[i])-96;
        IF fen[i+1]='6' THEN
          IF stilling[50+n]='B' THEN stilling[50+n]:='E' END;
        ELSE
          IF stilling[40+n]='b' THEN stilling[40+n]:='e' END;
        END;
      END;
      IF fen[i]<>0C THEN INC(i) END;
    END;
  END;
END FENtoSTILLING;

PROCEDURE STILLINGtoFEN(VAR fen:ARRAY OF CHAR; stilling:STILLINGTYPE);
VAR
  n,x,y,p,i:INTEGER;
  RH:BOOLEAN;
BEGIN
  IF HIGH(fen)>99 THEN
    i:=0;
    FOR y:=8 TO 1 BY -1 DO (* the 8 lines *)
      x:=1;
      REPEAT
        p:=y*10+x;
        IF stilling[p]=' ' THEN (* count empty fields *)
          fen[i]:='1';
          WHILE (stilling[p+1]=' ') & (x<9) DO
            INC(p);
            INC(x);
            INC(fen[i]);
          END;
        ELSE
          CASE stilling[p] OF
          | 'b' : fen[i]:='P';
          | 'e' : fen[i]:='P';
          | 't' : fen[i]:='R';
          | 'r' : fen[i]:='R';
          | 's' : fen[i]:='N';
          | 'l' : fen[i]:='B';
          | 'd' : fen[i]:='Q';
          | 'k' : fen[i]:='K';
          | 'm' : fen[i]:='K';
          | 'B' : fen[i]:='p';
          | 'E' : fen[i]:='p';
          | 'T' : fen[i]:='r';
          | 'R' : fen[i]:='r';
          | 'S' : fen[i]:='n';
          | 'L' : fen[i]:='b';
          | 'D' : fen[i]:='q';
          | 'K' : fen[i]:='k';
          | 'M' : fen[i]:='k';
          ELSE    fen[i]:=' ';
          END;
        END;
        INC(i);
        INC(x);
      UNTIL x>8;
      IF y>1 THEN
        fen[i]:='/';
      ELSE
        fen[i]:=' ';
      END;
      INC(i);
    END;
  
    (* colour *)
    IF stilling[HvisTur]='S' THEN
      fen[i]:='b';
    ELSE
      fen[i]:='w';
    END;
    INC(i);
  
    fen[i]:=' ';
    INC(i);
  
    (* Castling-rights *)
    RH:=FALSE;
    IF stilling[15]='m' THEN
      IF stilling[18]='r' THEN
        fen[i]:='K';
        INC(i);
        RH:=TRUE;
      END;
      IF stilling[11]='r' THEN
        fen[i]:='Q';
        INC(i);
        RH:=TRUE;
      END;
    END;
    IF stilling[85]='M' THEN
      IF stilling[88]='R' THEN
        fen[i]:='k';
        INC(i);
        RH:=TRUE;
      END;
      IF stilling[81]='R' THEN
        fen[i]:='q';
        INC(i);
        RH:=TRUE;
      END;
    END;
    IF ~RH THEN
      fen[i]:='-';
      INC(i);
    END;
  
    fen[i]:=' ';
    INC(i);
  
    (* set en-passant field *)
    n:=41;
    WHILE (n<59) & (stilling[n]<>'e') & (stilling[n]<>'E') DO
      INC(n);
    END;
    IF n<59 THEN (* found *)
      fen[i]:=CHR(96+n MOD 10);
      INC(i);
      IF n<49 THEN
        fen[i]:='3';
      ELSE
        fen[i]:='6';
      END;
      INC(i);
    ELSE
      fen[i]:='-';
      INC(i);
    END;
    fen[i]:=' ';
    INC(i);
  
    (* set count for 50-rule *)
    fen[i]:='0';
    INC(i);
    fen[i]:=' ';
    INC(i);
   
    (* set count for full-moves *)
    fen[i]:='1';
    INC(i);
    fen[i]:=0C;
  END;
END STILLINGtoFEN;

(* makes the position out of TraekNr *)
PROCEDURE GetStilling(fra:INTEGER);
CONST
  HisMax=20; (* HisMax have to equal SkakBrain.HisMax *)
VAR
  n,r:INTEGER;
BEGIN
  IF fra>TraekNr THEN 
    stilling:=start.Still;
    fra:=0;
    ClearHistory(999,FALSE);
    ClearHistory(999,TRUE);
  END;
  FOR n:=fra+1 TO TraekNr DO
    IF n+2*HisMax>TraekNr THEN
      AddHistory(stilling,Spil^[n].Fra,Spil^[n].Til,0);
    END;
    DoMoveC(stilling,Spil^[n].Fra,Spil^[n].Til);
  END;
END GetStilling;

(* Set PGN 7 tags to: ? ? ????.??.?? ? ? ? *         to be reset *)      
PROCEDURE SetPGNinfos;
VAR
  n:INTEGER;
BEGIN
  gExtras[gEvent]        :="?";
  gExtras[gSite]         :="?";
  gExtras[gDate]         :="????.??.??";
  gExtras[gRound]        :="?";
  gExtras[gWhite]        :="?";
  gExtras[gBlack]        :="?";
  gExtras[gResult]       :="*";

  (* Skak20 standard+extras, PGN ekstras: *)
  FOR n:=gWhiteTitle TO MaxExtras DO
    gExtras[n,0]:=0C;
  END;
END SetPGNinfos;

PROCEDURE NoPGNinfos():BOOLEAN;
VAR
  Res:BOOLEAN;
BEGIN
  Res:= ((gExtras[gWhite,1]=0C) OR (gExtras[gWhite,0]=0C))
     &  ((gExtras[gBlack,1]=0C) OR (gExtras[gBlack,0]=0C))
     &  ((gExtras[gSite ,1]=0C) OR (gExtras[gSite ,0]=0C))
     &  ((gExtras[gEvent,1]=0C) OR (gExtras[gEvent,0]=0C));
  RETURN(Res);
END NoPGNinfos;

(* Give ups or clear pgn,rem,spil *) 
PROCEDURE RydSpil(Complete:BOOLEAN; Auto:BOOLEAN):BOOLEAN;
VAR
  Res,nr,TrkNr:INTEGER;
  st:ARRAY[0..256] OF CHAR;
  Rettet:BOOLEAN;
BEGIN
(*$IF Test0 *)
  WRITELN(s('RydSpil'));
(*$ENDIF *)
  Rettet:=rettetREM OR rettetPGN OR rettetSPIL &
 ((TraekNr<>MaxTraek-1) OR (Spil^[MaxTraek].Tekst<>NIL) OR VariantTil);
  IF Rettet OR (MaxTraek>0) OR Complete THEN
    IF Rettet & ~Auto THEN
      Copy(st,Q[Q214]^);      (* Q214='Changes made to the game in: \n\n' *)
      IF rettetREM THEN
        Concat(st,Q[Q215]^);  (* Q215='  Comments\n' *)
      END;
      IF Complete & rettetPGN THEN
        Concat(st,Q[Q216]^);  (* Q216='  PGN infos\n' *)
      END;
      IF rettetSPIL THEN
        Concat(st,Q[Q217]^);  (* Q217='  Moves\n' *)
      END;
      Concat(st,Q[Q218]^);    (* Q218='\n OK to skip game?\n' *)
      Res:=TwoGadWIN(ADR(st));
    ELSE
      Res:=1;
    END;
    IF Res<>0 THEN
(*$IF Test0 *)
  WRITELN(s('Rydder Spil'));
(*$ENDIF *)
      CLOSEWIN(remWIN);

      IF Complete THEN
        CLOSEWIN(pgnWIN);
        SetPGNinfos;
        rettetPGN :=FALSE;
        TrkNr:=0;
      ELSE
        IF TraekNr=0 THEN
          gExtras[gNIC]:="";
          gExtras[gECO]:="";
          TrkNr:=0;
        ELSE
          TrkNr:=TraekNr+1;
        END;
      END;
(*$IF Test *)
  WRITELN(s('Slet fra: TrkNr=')+l(TrkNr));
(*$ENDIF *)

      FOR nr:=TrkNr TO MaxHalvTraek DO
        IF Spil^[nr].Tekst<>NIL THEN
          Deallocate(Spil^[nr].Tekst);
        END;
        Spil^[nr].Secs:=0;
        Spil^[nr].Attribs:=ATTRTYPE{};
        Spil^[nr].Fra:=11;
        Spil^[nr].Til:=88;
      END;
      rettetREM :=FALSE;

      IF Complete THEN
        TraekNr:=0;
        MaxTraek:=0;
        Spil^[0].Fra:=0;
        Spil^[0].Til:=0;
        stilling:=start.Still;
      END;
      rettetSPIL:=FALSE;

    END;
    RETURN(Res<>0);
  ELSE
    RETURN(TRUE);
  END;
END RydSpil;

(*
   -1 : file doesn't exist
    0 : file type unknown
    1 : file type SK1 (Single game SK10 or SK11)
    2 : file type SK2 (pig gamefile SK20)
*)
PROCEDURE FileType(VAR path:ARRAY OF CHAR);
VAR
  f:File;
  c1,c2,c3,c4:CHAR;
  r:INTEGER;
BEGIN
  (*$IF Test *)
    WRITELN(s('FilType "')+s(path)+s('"'));
  (*$ENDIF *)
  IF (Compare(path,'prt:')=0) OR (Compare(path,'PRT:')=0) THEN
    r:=-1;
  ELSE
    Lookup(f,path,8,FALSE);
    IF ~(f.res=done) THEN
      r:=-1;
    ELSE
      r:=0;
      ReadChar(f,c1);
      ReadChar(f,c2);
      ReadChar(f,c3);
      IF (c1='S') & (c2='K') & (c3='1') THEN r:=1 END;
      IF (c1='S') & (c2='K') & (c3='2') THEN r:=2 END;
    END;
    Close(f);
  END;
  FilType:=r;
END FileType;

VAR
  FirstTime:BOOLEAN;

PROCEDURE simpleFileRequester2(title:ARRAY OF CHAR; VAR name,path,
                              dir:ARRAY OF CHAR):BOOLEAN;
VAR
  patt:ARRAY[0..40] OF CHAR;
  OK:BOOLEAN;
BEGIN
  (*$IF Test0 *)
    WRITELN(s('simpleFileRequester2'));
  (*$ENDIF *)
  SetPtr(wptr,PTRsove);
  IF FirstTime THEN
    Copy(POSTEXT,Q[TxOK]^);
    Copy(MIDTEXT,Q[TxMID]^);
    Copy(NEGTEXT,Q[TxUPS]^);
    FirstTime:=FALSE;
  END;
  IF reqOn & ReqReq THEN
    OK:=SimpleFileRequester(title,name,path,dir);
    FileType(path);
  ELSE
    patt:='~*.info';
    OK:=FileRequest(dir, name, patt ,            (* giver og modtager resultat *)
                    title,Q[TxOK]^,Q[TxUPS]^,    (* tekst *)
                    Q[TxSti]^,Q[TxNavn]^,Q[TxUdvalgt]^, sptr);   (* tekst for path,navn,pattern *)
    IF OK THEN
      Copy(path,dir);
      Concat(path,name);
      FileType(path);
    END;
  END;  
  SetPtr(wptr,PTRrestore);
  (*$IF Test0 *)
    WRITELN(s('simpleFileRequester2, path=')+s(path));
  (*$ENDIF *)
  RETURN(OK);
END simpleFileRequester2;

PROCEDURE unNAG(VAR NAGst:ARRAY OF CHAR);
VAR
  m,v,x:INTEGER;
PROCEDURE Ins(nag:ARRAY OF CHAR; pos,sz:INTEGER);
VAR
  lnag:INTEGER;
BEGIN
  Delete(NAGst,pos,sz);
  Insert(NAGst,pos,nag);
END Ins;  
BEGIN
  m:=0;
(*$IF Test *)
  WRITE(s('$, unNAG: "')+s(NAGst)+s('"  '));
(*$ENDIF *)
  WHILE NAGst[m]<>0C DO
    IF (NAGst[m]='$') & (NAGst[m+1]>='0') & (NAGst[m+1]<='9') THEN
      x:=2;
      v:=ORD(NAGst[m+1])-48;
      IF (NAGst[m+2]>='0') & (NAGst[m+2]<='9') THEN
        v:=10*v+ORD(NAGst[m+2])-48;
        x:=3;
      END;
      CASE v OF
      | 1: Ins("!",m,x);
      | 2: Ins("?",m,x);
      | 3: Ins("!!",m,x);
      | 4: Ins("??",m,x);
      | 5: Ins("!?",m,x);
      | 6: Ins("?!",m,x);
      |11: Ins("==",m,x);
      |12: Ins("=",m,x);
      |13: Ins("~",m,x);
      |14: Ins("+=",m,x);
      |15: Ins("-=",m,x);
      |16: Ins("++=",m,x);
      |17: Ins("--=",m,x);
      |18: Ins("+-",m,x);
      |19: Ins("-+",m,x);
      |20: Ins("++",m,x);
      |21: Ins("--",m,x);
      ELSE
      END;
    END;
    INC(m);
  END;
(*$IF Test *)
  WRITELN(s('unNAGGED: "')+s(NAGst)+c('"'));
(*$ENDIF *)
END unNAG;

VAR
  LastFilLnr:LONGINT;
  Lastpnr   :INTEGER;
  LastCnt   :CARDINAL;

(*$ EntryClear:=TRUE *)  (* SK10 + txt + PGNtxt loader *)
(* Entry: COMPARE=dontcare, IFSFR2=TRUE (IFSimpleFileReqOk), ERROR=dontcare *)
PROCEDURE HentF(VAR f:File; VAR FraLine:LONGINT; VAR COMPARE:BOOLEAN;

                VAR ERROR:BOOLEAN; VAR IFSFR2:BOOLEAN; VAR sta:STIL; Auto:BOOLEAN);
VAR
  buf,n,m,p,nr,tp,otil:CARDINAL;
  n1,nn:INTEGER;
  actual,nl:LONGINT;
  txt,st:STRING;
  BadDat,do,StS,GlF,DR,Err,UF,FoundMove,Dublo,
  BadMove,SamePos,PGNtype,Oflag,Mflag:BOOLEAN; (* STartString, GammeLFrigjort *)
  fnr,pnr,pnrOld:INTEGER; (* OldMaxTræk,OldTrækNr,FraNr,PositionNr *)
  CFilPosOld,FilLnr,FilLnrOld:LONGINT;
  sti,stit:STILLINGTYPE;
  mvt:MOVETYPE;
  c1,c2,c3,c4,c5,c6,c3t,c2o,c3o,c4o,c5o,c6o,fra,til,ht,cx,cy,c9,cq:CHAR;
  errstr:ERRSTR;
  est,pst2,cst
(*$IF Test *)
  ,cs1,cs2
(*$ENDIF *)
     :ARRAY[0..255] OF CHAR;
  FENstr:ARRAY[0..127] OF CHAR;
  pst:ARRAY[0..512] OF CHAR;
  fresnd,SPEC:BOOLEAN;

PROCEDURE GetC1; (****** HentF.GetC1 ******)
BEGIN
  ReadChar(f,c1);
(*$IF Test0 *)
  WRITELN(s('HentF.GetC1="')+c(c1)+s('"'));
(*$ENDIF *)
  IF ~BadMove & ((c1=12C) OR (c1=15C)) THEN
    INC(FilLnr);
    GetPos(f,CFilPos);
    pnr:=1;
  ELSE
    INC(pnr);
  END;
END GetC1;  (* i HentF *)

PROCEDURE SkipStr(ch:CHAR); (* ch='%' *) (****** HentF.SkipStr ******)
BEGIN
  REPEAT
    GetC1;
  UNTIL (f.eof) OR (c1=12C) OR (c1=15C);
  IF ~f.eof THEN
    GetPos(f,CFilPos);
  END;
END SkipStr; (* i HentF *)

PROCEDURE GetStr(ch:CHAR); (* ch=';','(','[' or '$' **** HentF.GetStr **)
VAR 
  Cheat,CsNF,Stop,Brace:BOOLEAN;
  n,n2:CARDINAL;
  par:INTEGER;

PROCEDURE Cs(stc:ARRAY OF CHAR; VAR std:ARRAY OF CHAR; nr:INTEGER); (** HentF.GetStr.Cs **)
(* Checker om stc er i txt fra [1], hvis så overfør det i "" til std *)
VAR
  n,m:INTEGER;
  res:LONGINT;
BEGIN
(*$IF Test0 *)
  WRITELN(s('Cs ')+s(stc)+s(' i ')+s(txt));
(*$ENDIF *)
  n:=0;
  ConcatChar(stc,' ');
  WHILE  (n<=HIGH(stc)) & (stc[n]<>0C) & (stc[n]=txt[n]) & (txt[n]<>0C) DO
    INC(n);
  END;
  IF (n>HIGH(stc)) OR (stc[n]=0C) THEN
(*$IF Test0 *)
  WRITELN(s('Cs-a'));
(*$ENDIF *)
    CsNF:=FALSE;
    WHILE (txt[n]<>'"') & (txt[n]<>0C) DO
      INC(n);
    END;
    m:=0;
    IF (txt[n]='"') THEN
      IF (Compare(stc,'Event ')=0) & (TraekNr>0) THEN
        BadMove:=TRUE;
        DEC(CFilPos);
        cq:='*';
      ELSE
        INC(n);
        WHILE (m<HIGH(std)-1) & (txt[n]<>'"') & (txt[n]<>0C) DO
          std[m]:=txt[n]; (*!!!!!!!!!!!*)
          INC(n);
          INC(m);
        END;
        std[m]:=0C;

        (* fix cb import space-problems *)
        IF (nr=gBlack) & (std[0]=' ') THEN (* remove initial space *) 
          Delete(std,0,1);
        END;
        IF nr=gWhite THEN (* remove trailing space *)
          res:=Length(std);
          IF (res>0) & (std[res-1]=' ') THEN
            std[res-1]:=0C;
          END;
        END;

      END;
    END;
  END;
END Cs; (**** i HentF.GetStr ****)

PROCEDURE PGNtxt():BOOLEAN; (**** HentF.GetStr.PGNtxt() ****)
(* Checker om læst streng er en PGN info-tekst og kopier den hvis ja *)
VAR
  n:INTEGER;
BEGIN
(*$IF Test0 *)
  WRITELN(s('PGNtxt()'));
(*$ENDIF *)
  IF ch<>'[' THEN RETURN(FALSE); END;
  CsNF:=TRUE;
  FOR n:=-12 TO gBlackCountry DO
    IF CsNF THEN
      Cs(gLabels[n],gExtras[n],n);
    END;
  END;
  IF CsNF THEN
    Cs('FEN',FENstr,-13);
    IF CsNF THEN
      Cs('SetUp',FENstr,-14); (* to skip the SetUp Tags *)
    ELSE
(*$IF Test *)
  WRITELN(s('FEN læst!'));
(*$ENDIF *)
      FENtoSTILLING(sta.Still,FENstr);
      sti:=sta.Still;
      start.Still:=sta.Still;
      COMPARE:=TRUE;
    END;
  END;
  IF ~CsNF THEN 
    PGNtype:=TRUE;
  END;
  RETURN(~CsNF);
END PGNtxt;(**** i HentF.GetStr ****)

BEGIN  (* HentF.GetStr *****************************)
  (*$IF Test0 *)
    WRITELN(s('LæsStreng'));
  (*$ENDIF *)
  n:=0;
  par:=0;
  Brace:=(ch='[') OR (ch=';');
  Cheat:=~DiskOn & (TraekNr>0);
  IF Cheat THEN 
    DEC(TraekNr);
  END;

  (* Indlæs streng til txt (max 2000) *)
  
  REPEAT
    ReadChar(f,txt[n]);
(*
    IF txt[n]=15C THEN (* skip CR *)
      INC(FilLnr);
      ReadChar(f,txt[n]);
    END;
*)
    IF (txt[n]=12C) OR (txt[n]=15C) THEN 
      INC(FilLnr);
(*$IF Test0 *)
  WRITELN(s('Repeat GetPos=')+l(CFilPos));
(*$ENDIF *)
      GetPos(f,CFilPos);
      pnr:=1;
    ELSIF (txt[n]='(') & ~Brace OR (txt[n]='[') OR (txt[n]='{') THEN
      INC(par);
    ELSIF (txt[n]=')') & ~Brace OR (txt[n]=']') OR (txt[n]='}') THEN
      DEC(par);
    END;
(*$IF Test0 *)
  WRITELN(s('Stop: pnr=')+l(pnr)+s(' ch=')+c(ch)+s(' txt[n]=')+c(txt[n]));
(*$ENDIF *)
    Stop:= (pnr<2) & (ch='(') & (txt[n]='[');
    IF ~DiskOn & ((ch='$') & ((txt[n]<'0') OR (txt[n]>'9')) OR (ch=';') & ((txt[n]=12C) OR (txt[n]=15C)) OR ((ch='(') OR  (ch='[') OR (c1='{')) & (par<0)) THEN
      txt[n]:=0C;
    END;
    INC(n);
  UNTIL (n>=SIZE(STRING)) OR (txt[n-1]=0C) OR f.eof OR ~(f.res=done) OR Stop;

  IF (n<SIZE(STRING)) THEN
    IF ch='$' THEN
      Insert(txt,0,'$');
    END;
    IF ch<>'[' THEN
      unNAG(txt);
    END;
  END;

  (*  convert cr to space if cr+lf else cr to lf *)
  FOR n2:=0 TO Length(txt)-1 DO
    IF (txt[n]=15C) THEN
      IF (txt[n+1]=12C) THEN
        txt[n]:=' ';
      ELSE
        txt[n]:=12C;
      END;
    END;
  END;

  IF Stop THEN
(*$IF Test0 *)
  WRITELN(s('Stopped: pnr=')+l(pnr)+s(' ch=')+c(ch)+s(' txt[n]=')+c(txt[n])+s(' CFilPos=')+l(CFilPos));
(*$ENDIF *)
    BadMove:=TRUE;
    DEC(CFilPos,1);
    cq:='*';
  END;
(*$IF Test0 *)
    WRITELN(l(Length(txt))+s('"')+s(txt)+s('"'));
(*$ENDIF *)
  IF f.res=done THEN (* så streng læst ok *)
    IF ~PGNtxt() THEN
      IF n>=SIZE(STRING) THEN DEC(n); END;
      IF txt[n]<>0C THEN txt[n]:=0C; END;

(*$IF Test *)
  WRITELN(s("txt='")+s(txt)+s("'"));
(*$ENDIF *)
  
      IF Spil^[TraekNr].Tekst<>NIL THEN
(*$IF Test *)
  WRITELN(s("<>NIL"));
(*$ENDIF *)
        Copy(st,Spil^[TraekNr].Tekst^);
        ConcatChar(st,12C);
        Concat(st,txt);
        Copy(txt,st);
        n:=Length(txt);
        Deallocate(Spil^[TraekNr].Tekst);
      END;
      Allocate(Spil^[TraekNr].Tekst,n+1);
      IF Spil^[TraekNr].Tekst<>NIL THEN (* OK *)
        p:=0;
        REPEAT
          Spil^[TraekNr].Tekst^[p]:=txt[p];
          INC(p);
        UNTIL (p=n) OR (txt[p]=0C);
        Spil^[TraekNr].Tekst^[p]:=0C;
(*$IF Test *)
  WRITELN(s('GetStr=')+s(Spil^[TraekNr].Tekst^));
(*$ENDIF *)
      END;
    END;
  END;
  IF Cheat THEN 
    INC(TraekNr);
  END;
(*$IF Test *)
  IF ch='$' THEN WRITELN(s('GetStrExit="')+s(txt)+s('"')); END;
(*$ENDIF *)
END GetStr; (******************** i HentF **********************************)

PROCEDURE PL(ch:CHAR); (*** HentF.PL ***)
BEGIN
  IF c1=LP(ch) THEN
    c9:=ch;
  END;
END PL; (*** i HentF ***)

BEGIN (* *********************** HentF ********************************)
(*$ IF Test *) QQ(' hentF',start.Still);(*$ ENDIF *)
  (*$IF Test0 *)
    WRITELN(s("Hent,kar=NIL"));
  (*$ENDIF *)
  PGNtype:=FALSE;
  FoundMove:=FALSE;
  BadMove:=FALSE;
  SamePos:=FALSE;
  SPEC:=FALSE;
  FENstr[0]:=0C;
  cst:='';
  AdjDiskOn:=FALSE;
  COMPARE:=FALSE; (* TRUE to disable position-selection *)
  IF DiskOn OR (TraekNr<1) THEN
 (*$IF Test0 *)
    WRITELN(s('COMPARE=TRUE'));
(*$ENDIF *) (* DiskOn *)
   COMPARE:=TRUE;
  END;
  ERROR:=FALSE;
  FilLnr:=1;
  pnr:=1;
  est:='';
  pst:='';
  pst2:='';
  IF VariantTil OR RydSpil(TRUE,Auto) & IFSFR2 THEN
(*$IF Test0 *)
    WRITELN(s('Path="')+s(path)+s('"'));
(*$ENDIF *) (* DiskOn *)
    IF Compare(ptho,path)<>0 THEN
      ptho:=path;
      FraLine:=0;
    END;
    StS:=FALSE;
    IF DiskOn THEN
(*$IF Test0 *)
   WRITELN(s('LæsStillrec'));
(*$ENDIF *)
      ReadChar(f,c1); ReadChar(f,c2); ReadChar(f,c3); ReadChar(f,c4);
      BadDat := (c1<>'S') OR (c2<>'K');
      IF ~BadDat THEN
        IF (c3='2') & (c4>='0') & (c4<='9') THEN
          Copy(est,Q[Qisapigfile]^);
          BadDat:=TRUE;
        ELSE
          IF (c3='1') & (c4='1') THEN 
            FOR n1:=gEvent TO MaxExtras DO
              (* hent streng *)
              nn:=-1;
              REPEAT
                INC(nn);
                ReadChar(f,gExtras[n1,nn]);
              UNTIL f.eof OR (f.res<>done) OR (nn=30) OR (gExtras[n1,nn]=0C);
            END;
          END;
          ReadChar(f,c5);
          ReadBytes(f,ADR(sta),ORD(c5),actual);
(*$ IF Test *) QQ(' hentF~',sta.Still);(*$ ENDIF *)
          (* sta.Still:=Udgangsstilling hvis c5<100 !!!!!!!!!!!!!!!!!!!!! *)
          IF ORD(c5)<100 THEN
            sta.Still:=StartStilling;
          ELSE (* fix v2.7b2 and older file error if alternative start pos *)
            SPEC:=(sta.Still[ 0]='.') & (sta.Still[ 9]='.') & (sta.Still[40]='.')
                & (sta.Still[90]='.') & (sta.Still[99]='.') & (sta.Still[59]='.');
            FOR n1:=11 TO 88 DO 
              IF sta.Still[n1]=12C THEN sta.Still[n1]:=' ' END;
            END;
          END;
        END;
      END;
    ELSE
      BadDat:=FALSE;

  (*$IF Test0 *)
    WRITELN(s('SkipLines=')+l(FraLine));
  (*$ENDIF *)
   
      IF FraLine>0 THEN
        SetPos(f,CFilPos);
        FilLnr:=FraLine;
(*$IF Test0 *)
  WRITELN(s('Sat cfilpos=')+l(CFilPos)+s(' FilLnr=')+l(FilLnr));
(*$ENDIF *)
      ELSE
        KD:=0;
      END;
      GetC1;

      WHILE ~f.eof & (f.res=done) & (FraLine>=FilLnr) DO
(*$IF Test0 *)
  WRITELN(s('GetC1...'));
(*$ENDIF *)
        GetC1;
      END;

      IF (c1=';') OR (c1='(') OR (c1='[') OR (c1='{') OR (c1='$') THEN
(*$IF Test0 *)
  WRITELN(s('GetStr1...'));
(*$ENDIF *)
        GetStr(c1);
        GetC1;
        StS:=TRUE;
      END; 
      IF (c1='%') & (pnr<4) OR (c1='!') & (pnr=1) THEN
        SkipStr(c1);
      END;
      IF c1='.' THEN           (* Så indlæs start-stilling 10x10 tegn *)
  (*$IF Test *)
    WRITELN(s('LæsStilling'));
  (*$ENDIF *)
        sta.Still[HvisTur]:='H';
        FOR n:=9 TO 0 BY -1 DO
          FOR m:=0 TO 9 DO
            IF (c1<>'.') & (c1<>' ') & (c1<>LP('T')) & (c1<>LP('R')) &
              (c1<>LP('S')) & (c1<>LP('L')) & (c1<>LP('K')) & (c1<>LP('M')) &
              (c1<>LP('D')) & (c1<>LP('B')) & (c1<>LP('E')) & (c1<>LP('t')) &
              (c1<>LP('r')) & (c1<>LP('s')) & (c1<>LP('l')) & (c1<>LP('k')) &
              (c1<>LP('m')) & (c1<>LP('d')) & (c1<>LP('b')) & (c1<>LP('e')) THEN
              BadDat:=TRUE;
              Copy(est,Q[TxForkertTegnIStilling]^);
            END;
            IF ~BadDat THEN
              c9:=c1;
              (* IF c1=LP('k') THEN c9:='k' *)
              PL('k'); PL('K'); PL('m'); PL('M'); PL('t'); PL('T');
              PL('r'); PL('R'); PL('l'); PL('L'); PL('s'); PL('S');
              PL('d'); PL('D'); PL('b'); PL('B'); PL('e'); PL('E');
              sta.Still[10*n+m]:=c9;
              GetC1;
            END;
          END;
          IF (c1='*') & (n>5) THEN
  (*$IF Test0 *)
    WRITELN(s('SortTrækker'));
  (*$ENDIF *)
            sta.Still[HvisTur]:='S';
          END;
          WHILE (c1<>12C) & (c1<>15C) & (f.res=done) & ~f.eof DO
            GetC1;
            IF (c1='%') & (pnr<4) OR (c1='!') & (pnr=1) THEN
              SkipStr(c1);
            END;
            IF (c1=';') OR (c1='(') OR (c1='[') OR (c1='{') OR (c1='$') THEN
(*$IF Test0 *)
  WRITELN(s('GetStr2...'));
(*$ENDIF *)
              GetStr(c1);
(*$IF Test0 *)
    WRITELN(s('@:c1=; or ('));
(*$ENDIF *)
            END;
          END; (* WHILE *)
          GetC1;
        END; (* FOR *)

        IF (sta.Still[15]='m') & (sta.Still[11]<>'r') & (sta.Still[18]<>'r') THEN
          IF (sta.Still[11]='t') THEN
            sta.Still[11]:='r';
          END; 
          IF (sta.Still[18]='t') THEN
            sta.Still[18]:='r';
          END; 
        END; 
        IF (sta.Still[85]='M') & (sta.Still[81]<>'R') & (sta.Still[88]<>'R') THEN
          IF (sta.Still[81]='T') THEN
            sta.Still[81]:='R';
          END; 
          IF (sta.Still[88]='T') THEN
            sta.Still[88]:='R';
          END; 
        END; 

        IF (sta.Still[11]<>'r') 
        &  (sta.Still[15]<>'m') 
        &  (sta.Still[18]<>'r') 
        &  (sta.Still[81]<>'R') 
        &  (sta.Still[85]<>'M')
        &  (sta.Still[88]<>'R') THEN (* sansynligvis ukendskab *) 
          IF (sta.Still[15]='k') & ((sta.Still[11]='t') OR (sta.Still[18]='t')) THEN
            sta.Still[15]:='m';
            IF sta.Still[11]='t' THEN
              sta.Still[11]:='r';
            END;
            IF sta.Still[18]='t' THEN
              sta.Still[18]:='r';
            END;
          END;
          IF (sta.Still[85]='K') & ((sta.Still[81]='T') OR (sta.Still[88]='T')) THEN
            sta.Still[85]:='M';
            IF sta.Still[81]='T' THEN
              sta.Still[81]:='R';
            END;
            IF sta.Still[88]='T' THEN
              sta.Still[88]:='R';
            END;
          END;
        END;
      ELSE (* IKKE custom-stilling (men måske alligevel: FEN) *)
        IF VariantTil THEN
(*$IF Test0 *)
    WRITELN(s('sta=start'));
(*$ENDIF *)
          sta:=start;
        ELSE
          sta.Still:=StartStilling;
        END;
      END;
      sti:=sta.Still;
      IF ~COMPARE & ~Equal(sti,start.Still) THEN  (* Load-always when diff. start-positions *)
        COMPARE:=TRUE;
      END;
    END;            
    IF ~BadDat & (f.res=done) THEN
      start:=sta;
      UF:=FALSE;
      cq:=' ';
      REPEAT
        IF DiskOn THEN 
          fra:=13C; til:=13C;
          ReadChar(f,fra);
          IF (f.res=done) & (fra=0C) & ~BadDat  & ~f.eof THEN
            GetStr(';');
            ReadChar(f,fra);
          END;
          ReadChar(f,til);
        ELSE
 (* Alt efter % eller ! i linie start er kommentarer, der IKKE skal læses *)
          IF (c1='%') & (pnr<4) OR (c1='!') & (pnr=1) THEN
            SkipStr(c1);
          END;
 (* Alle tal, hvor ok tegn før (a-h,A-H) er træk. Alt efter ; er kommentar *)
          IF (c1=';') OR (c1='(') OR (c1='[') OR (c1='{') OR (c1='$') THEN
(*$IF Test0 *)
    WRITELN(s('a:c1=; or ('));
(*$ENDIF *)
(*$IF Test0 *)
  WRITELN(s('GetStr3...'));
(*$ENDIF *)
            GetStr(c1);
            GetC1;
          END;
          DR:=FALSE;
          FOR n:=1 TO 2 DO (* fra, til *)
            IF ~f.eof OR DR THEN
              IF (c1='%') & (pnr<4) OR (c1='!') & (pnr=1) THEN
                SkipStr(c1);
              END;
              IF (c1=';') OR (c1='(') OR (c1='[') OR (c1='{') OR (c1='$') THEN
(*$IF Test0 *)
    WRITELN(s('b:c1=; or ('));
(*$ENDIF *)
(*$IF Test0 *)
  WRITELN(s('GetStr4...'));
(*$ENDIF *)
                GetStr(c1);
                GetC1;   
              END;
              IF DR THEN
                c1:=cx; 
                c2:=cy;
              END;
              WHILE  ~ BadMove & ~f.eof & (f.res=done) & ((c1<'1') OR (c1>'8') OR (c2<'A') OR (c2>'H')) DO
                c6:=c5;
                c5:=c4;
                c4:=c3;
                c3:=c2;
                c2:=CAP(c1);
                c6o:=c5o;
                c5o:=c4o;
                c4o:=c3o;
                c3o:=c2o;
                c2o:=c1;
                c1:=' ';
                GetC1;

IF PGNtype & (c1<>'[') & (c1<>'(') & (c1<>12C) & (c1<>15C) & (c1<>'$') THEN
  ConcatChar(cst,c1);
END;

                IF (TraekNr>0)
                & ((c1='0') & (c2='-') & (c3='1')
                OR (c1='1') & (c2='-') & (c3='0')
                OR (c1='2') & (c2='/') & (c3='1')) THEN
                  BadMove:=TRUE;
                  cq:=c1;
                  INC(FilLnr);
                END;

                IF ~f.eof & (f.res=done) THEN
                  IF (c1='%') & (pnr<4) OR (c1='!') & (pnr=1) THEN
                    SkipStr(c1);
                  END;
                  IF (c1=';') OR (c1='(') OR (c1='[') OR (c1='{') OR (c1='$') THEN
(*$IF Test0 *)
    WRITELN(s('c:c1=; or ('));
(*$ENDIF *)
(*$IF Test0 *)
  WRITELN(s('GetStr5...'));
(*$ENDIF *)
                    GetStr(c1);
                    GetC1;   
                  END;
                END;
                IF ~f.eof & (f.res=done) THEN
                  IF UF THEN (* check om UnderForvandling og udfør hvis *)
(*$IF Test0 *)
    WRITELN(s('IF UF = TRUE'));
(*$ENDIF *)
                    otil:=ORD(til);
                    UF:=FALSE;
                    IF (stit[ORD(fra)]='b') & (ORD(fra)>70) THEN
                      IF c1='=' THEN
                        GetC1;
(*$IF Test0 *)
    WRITELN(s('C1="=" c2="')+c(c2)+s('" NYc1="')+c(c1)+c('"'));
(*$ENDIF *)
                      END;
                      IF CAP(c1)=LP('T') THEN
                        til:=CHR(ORD(til)-20);
                        c1:=LP(' ');
                      ELSIF CAP(c1)=LP('S') THEN
                        til:=CHR(ORD(til)-30);
                        c1:=LP(' ');
                      ELSIF CAP(c1)=LP('L') THEN
                        til:=CHR(ORD(til)-40);
                        c1:=LP(' ');
                      ELSIF CAP(c1)=LP('D') THEN
                        c1:=LP(' ');
                      END;
                    END;
                    IF (stit[ORD(fra)]='B') & (ORD(fra)<29) THEN
                      IF c1='=' THEN
                        GetC1;
(*$IF Test0 *)
    WRITELN(s('C1="=" c2="')+c(c2)+s('" NYc1="')+c(c1)+c('"'));
(*$ENDIF *)
                      END;
                      IF CAP(c1)=LP('T') THEN
                        til:=CHR(ORD(til)+20);
                        c1:=LP(' ');
                      ELSIF CAP(c1)=LP('S') THEN
                        til:=CHR(ORD(til)+30);
                        c1:=LP(' ');
                      ELSIF CAP(c1)=LP('L') THEN
                        til:=CHR(ORD(til)+40);
                        c1:=LP(' ');
                      ELSIF CAP(c1)=LP('D') THEN
                        c1:=LP(' ');
                      END;
                    END;
                    IF otil<>CARDINAL(til) THEN
(*$IF Test0 *)
    WRITELN(s('otil<>til'));
(*$ENDIF *)
                      IF DoMoveOk(stit,ORD(fra),ORD(til),mvt) THEN
                        sti:=stit;
                        Spil^[TraekNr-1].Til:=ORD(til);
                      END;
                    END;
                  END; (* IF underforvandling *)
                  IF (c1='%') & (pnr<4) OR (c1='!') & (pnr=1) THEN
                    SkipStr(c1);
                  END;
                  IF (c1=';') OR (c1='(') OR (c1='[') OR (c1='{') OR (c1='$') THEN
(*$IF Test0 *)
  WRITELN(s('GetStr6...'));
(*$ENDIF *)
                    GetStr(c1);
                  END;
                END;
                IF ~f.eof & (f.res=done) THEN
                  IF (FilLnr=1) & (pnr=5) & (c4='S') & (c3='K') THEN
                    IF (c2='1') & (c1='0') THEN
                      Copy(pst,Q[TxSPILIKKETEKST]^);
                    ELSE
                      IF (c2='2') & (c1>='0') & (c1<='9') THEN
                        Copy(pst,Q[Qisapigfile]^);
                      END;
                    END;
                  END;
                  IF DR THEN (* O-O *)
                    IF c1='-' THEN
                      cy:='C';
                    ELSE
                      cy:='G';
                    END;
                    c2:='E';
                    IF ODD(TraekNr) THEN
                      cx:='1';
                    ELSE 
                      cx:='8';
                    END;
                    c1:=cx;
                  ELSE
                    IF n=1 THEN
                      DR:= (CAP(c1)='O') & (c2='-') & (CAP(c3)='O')
                           OR (c1='0') & (c2='-') & (c3='0');
                    END;
                  END;
                END;
              END; (* while til tal med legal koordinat før er fundet *)

(*  cs1:=cst; *)

  IF PGNtype THEN
(*$IF Test *)
  WRITELN(s('cst01="')+s(cst)+c('"'));
(*$ENDIF *)
    (* afskær ved det sidste space (fjerner trækket) *)
    nn:=Length(cst)-1;
    WHILE (nn>=0) & (cst[nn]<>' ') & (cst[nn]>=40C) DO DEC(nn) END;
    IF (nn>=0) & ((cst[nn]=' ') OR (cst[nn]<40C)) THEN cst[nn]:=0C ELSE cst[0]:=0C END;

    (* fjern trailing '.' *)
    nn:=Length(cst)-1;
    IF (nn>=0) & (cst[nn]='.') THEN
      cst[nn]:=0C;
    END;

(*  cs2:=cst; *)

(*$IF Test0 *)
  WRITELN(s('cst02="')+s(cst)+c('"'));
(*$ENDIF *)
    (* fjern linienr *)
    nn:=0;
    WHILE (cst[nn]<>0C) & ((cst[nn]<'1') OR (cst[nn]>'9')) DO INC(nn) END;
    cst[nn]:=0C;

(*$IF Test0 *)
  WRITELN(s('cst03="')+s(cst)+c('"'));
(*$ENDIF *)
    (* fjern trailing spaces *)
    nn:=Length(cst)-1;
    WHILE (nn>=0) & (cst[nn]=' ') DO DEC(nn) END;
    cst[nn+1]:=0C;

(*$IF Test0 *)
  WRITELN(s('cst04="')+s(cst)+c('"'));
(*$ENDIF *)
    (* fjern O-O *)
    nn:=Length(cst)-1;
    Oflag:=FALSE;
    Mflag:=FALSE;
    WHILE (nn>=0) & ((cst[nn]='O') OR (cst[nn]='-')) DO
      IF cst[nn]='-' THEN Mflag:=TRUE END;
      IF cst[nn]='O' THEN Oflag:=TRUE END;
      DEC(nn);
    END;
    IF Oflag & Mflag THEN
      cst[nn+1]:=0C;
    END;

(*$IF Test0 *)
  WRITELN(s('cst05="')+s(cst)+c('"'));
(*$ENDIF *)
    (* fjern 1 lange med O, Q, + og Space *)
    IF (cst[1]=0C) & ((cst[0]='O') OR (cst[0]=' ') OR (cst[0]='Q') OR (cst[0]='+')) THEN cst[0]:=0C END;

    IF cst[0]<>0C THEN

(*$IF Test0 *)
  WRITELN(c('"')+s(cs1)+c('"'));
  WRITELN(c('"')+s(cs2)+c('"'));
(*$ENDIF *)

(*$IF Test0 *)
  WRITELN(l(TraekNr)+s(': "')+s(cst)+c('"'));
(*$ENDIF *)

      (* placer comment *)
      IF TraekNr>0 THEN
        st[0]:=0C;
(*$IF Test0 *)
  WRITELN(s('PLAC'));
(*$ENDIF *)
        IF Spil^[TraekNr-1].Tekst<>NIL THEN
          Copy(st,Spil^[TraekNr-1].Tekst^);
          ConcatChar(st,12C);
          Deallocate(Spil^[TraekNr-1].Tekst);
        END;
        Concat(st,cst);
        nn:=Length(st);
        Allocate(Spil^[TraekNr-1].Tekst,nn+1);
        IF Spil^[TraekNr-1].Tekst<>NIL THEN (* OK *)
          Copy(Spil^[TraekNr-1].Tekst^,st);
        END;
      END;
    END;
  END;

              IF ~BadMove & ~f.eof & (f.res=done) THEN
                fnr:=10*ORD(c1)-480+ORD(c2)-64;
                IF (fnr>=11) & (fnr<=88) THEN
    (*Range*)     til:=CHR(fnr);
                END;
                IF n=1 THEN
                  fra:=til;
  (*$IF Test0 *)
    WRITELN(s('n=1'));
  (*$ENDIF *)   
                  (* Hvis Felttomt eller FeltsBrikFarve modsat Hvistur, SÅ *)
                  IF (sti[ORD(til)]=' ') OR ((CAP(sti[ORD(til)])=sti[ORD(til)]) = (sti[HvisTur]='H')) THEN
                    (* Ulovligt som fra-felt, prøv som til-felt og find fra *) 
  (*$IF Test0 *)
    WRITELN(s('ill som fra'));
  (*$ENDIF *)
                    fra:=CHR(10);
                    tp:=11; (* TestPosition *)
                    stit:=sti;
                    (* Dublo hvis koordinat-del før til, og Briktegn før k-del *)
                    Dublo:=((c3o>='a') & (c3o<='h') OR (c3>='1') & (c3<='8')) &
                    (
                    (c4=LP('B')) OR (c4=LP('E')) OR (c4=LP('K')) OR 
                    (c4=LP('M')) OR (c4=LP('D')) OR (c4=LP('T')) OR 
                    (c4=LP('R')) OR (c4=LP('S')) OR (c4=LP('L'))
                    );
  (*$IF Test0 *)
    WRITELN(s('c5c4c3c2c1 c4o')+c(c5)+c(c4)+c(c3)+c(c2)+c(c1)+c(' ')+c(c4o));
    IF Dublo THEN WRITELN(s('1.Dublo')) END;
  (*$ENDIF *)
                    (* Hvis Dublo,slag,streg eller space/lf og ikke 'O' eller '='
                       før det, så skip c3 *)
                    IF Dublo
                    OR ((c3=' ') OR (c3=12C) OR (c3=15C) OR (c3='#'))  & (CAP(c4o)<>'O') & (c5o<>'=')
                    OR (c3='-')
                    OR (c3='X') THEN
                      IF ((c3=12C) OR (c3=15C)) & (c4o>='a') & (c5o>='a') THEN
(*$IF Test0 *)
  WRITELN(s('HHHHHHHH'));
(*$ENDIF *)
                        c4:=' ';
                        c4o:=c4;
                      END;
                      cx:=c4;
                      (* Recalc Dublo hvis tegn skip *)
                      IF (c3='X')
                      OR ((c3=' ') OR (c3=12C) OR (c3=15C) OR (c3='#')) & (CAP(c4o)<>'O') & (c5o<>'=')
                      OR (c3='-') THEN
                        Dublo:=((c4o>='a') & (c4o<='h') OR (c4>='1') & (c4<='8')) &
                        (
                        (c5=LP('B')) OR (c5=LP('E')) OR (c5=LP('K')) OR 
                        (c5=LP('M')) OR (c5=LP('D')) OR (c5=LP('T')) OR 
                        (c5=LP('R')) OR (c5=LP('S')) OR (c5=LP('L')) OR
                        (c5=' ') OR (c5=12C) OR (c5=15C) OR (c5='.')
                        );

  (*$IF Test0 *)
    IF Dublo THEN WRITELN(s('2.Dublo'));END;
  (*$ENDIF *)
                        IF Dublo
                          THEN cx:=c5;
                        END;
                      END;
                    ELSE 
                      cx:=c3;
                    END;
                    REPEAT
                      CASE CAP(sti[tp]) OF
                      | 'B','E' : cy:=LP('B'); (* P,K,Q,R,N,B ved engelsk *)
                      | 'K','M' : cy:=LP('K');
                      | 'D'     : cy:=LP('D');
                      | 'T','R' : cy:=LP('T');
                      | 'S'     : cy:=LP('S');
                      | 'L'     : cy:=LP('L');
                      ELSE        cy:='W';
                      END;
                      (* cx=fil-frabrik , cy=stilling-FraBrik *)
                      (* korrekt navn på fra-brik ?*)
  (*$IF Test0 *)
    WRITELN(s('1:c1=[brik, ,,] cy,cx="')+c(cy)+s('","')+c(cx)+s('" tp=')+l(tp)+s(' c6c5c4c3c2c1=')+c(c6)+c(c5)+c(c4)+c(c3)+c(c2)+c(c1));
  (*$ENDIF *)
                      IF (cy=cx) OR (cy=LP('B')) & ((cx<'A') OR (cx>'Z')) THEN
  (*$IF Test0 *)
    WRITELN(s('2:c1=[brik, ,,] cy,cx="')+c(cy)+s('","')+c(cx)+s('" tp=')+l(tp));
  (*$ENDIF *)
                        IF DoMoveOk(stit,tp,ORD(til),mvt) THEN
  (*$IF Test0 *)
    WRITELN(s('fra:=tp')+l(tp));
  (*$ENDIF *)
                          IF Dublo THEN (* check om den RIGTIGE fundet. See4, s4c3 *)
  (*$IF Test0 *)
    IF Dublo THEN WRITELN(s('3.Dublo'));END;
  (*$ENDIF *)
                            IF c3='X' THEN
                              c3t:=c4o;
  (*$IF Test0 *)
    WRITELN(s('c3t=4'));
  (*$ENDIF *)
                            ELSE
                              c3t:=c3o;
                            END;
                            IF (c3t>='a') & (c3t<='h') & (ORD(c3t)-96=INTEGER(tp) MOD 10)
                            OR (c3t>='1') & (c3t<='8') & (ORD(c3t)-48=INTEGER(tp) DIV 10) THEN
                              fra:=CHR(tp);
                            ELSE (* restore så find næste lovlige træk går *)
                              stit:=sti;
                            END;
                          ELSE

                            IF (sti[tp]='b') & (tp>70) & (CARDINAL(ORD(til))<tp)
                            OR (sti[tp]='B') & (tp<29) & (CARDINAL(ORD(til))>tp) THEN
                              (* Undervandlings-fra fundet,så find næste *)
                              stit:=sti;

                            ELSE
                              fra:=CHR(tp);
                            END;
                          END;
                        END;
                      END;
                      INC(tp);
                    UNTIL (tp>88) OR (fra<>CHR(10));
                    IF fra<>CHR(10) THEN
                      INC(n);
                    ELSE
(*!!!!!!!!!!*)        BadMove:=TRUE;
                    END;
                  END;
                END;
                c1:=' ';
              END; (* IF ~EOF *)
            END; (* IF ~EOF OR .. *)
          END; (* FOR n:=1 TO 2 *)
          cst:='';  
        END; (* iF ~DiskOn *)
  (*$IF Test0 *)
    WRITELN(s('LæstTræk ')+l(ORD(fra))+s('->')+l(ORD(til)));
    WRITELN(s('10:Set CFilPos=')+l(CFilPos));
  (*$ENDIF *)
        IF ~DiskOn THEN
          IF TraekNr=0 THEN
            INC(TraekNr);
          END;
          (* Legalitetscheck af træk *) 
  (*$IF Test0 *)
    WRITELN(s('Chk legality'));
  (*$ENDIF *)
          IF ~f.eof & (done=f.res) & ~BadDat & ((fra<>CHR(10)) OR BadMove) THEN
  (*$IF Test0 *)
    WRITELN(s('NOT DoMoveOk ?'));
  (*$ENDIF *)
            IF ~BadMove THEN
              UF:=(sti[ORD(fra)]='b') & (ORD(fra)>70)
              OR  (sti[ORD(fra)]='B') & (ORD(fra)<29);
              IF UF THEN
(*$IF Test0 *)
    WRITELN(s('Underforvandling, så stit=sti'));
(*$ENDIF *)
                stit:=sti;
              END;
            END;
            IF BadMove OR NOT DoMoveOk(sti,ORD(fra),ORD(til),mvt) THEN
  (*$IF Test0 *)
    WRITELN(s('BadMove OR NOT DoMoveOk l=')+l(FilLnr)+s(' p=')+l(pnr)+b(BadMove)++c(' ')+c(cq));
  (*$ENDIF *)
              IF TRUE OR (cq<>' ') THEN (* så ikke afsluttet med 1-0 0-1 eller 1/2 *)
                Concat(pst,Q[TxLINIE]^);
                ValToStr(FilLnr,FALSE,st,10,1,' ',Err);
                Concat(pst,st);
                Concat(pst,Q[TxPOSITION]^);
                ValToStr(pnr,FALSE,st,10,1,' ',Err);
                Concat(pst,st);
                Concat(pst,Q[TxHALVTRAEK]^);
                ValToStr(TraekNr,FALSE,st,10,1,' ',Err);
                Concat(pst,st);
                Concat(pst,'  \n');
              END;
              BadDat:=TRUE;
            END;
          END;
        END;
        IF ~BadDat & (fra>CHR(10)) THEN
          FoundMove:=TRUE;
          Spil^[TraekNr].Fra:=ORD(fra);
          Spil^[TraekNr].Til:=ORD(til);
(*$IF Test0 *)
  FOR n:=11 TO 88 DO
    WRITE(c(sti[n]));
  END;
  WRITELN(0);
  FOR n:=11 TO 88 DO
    WRITE(c(stilling[n]));
  END;
  WRITELN(0);
(*$ENDIF *)
          IF ~COMPARE & Equal(sti,stilling) THEN
            COMPARE:=TRUE;
(*$IF Test0 *)
  WRITELN(s('COMPARE=TRUE'));
(*$ENDIF *)
          END;
(*$IF Test0 *)
  WRITELN(s('MAKE, TraekNr=')+l(TraekNr)+s(' fra=')+l(ORD(fra))+s(' til=')+l(ORD(til)));
(*$ENDIF *)
        END;
        INC(TraekNr);
      UNTIL f.eof OR ~(done=f.res) OR BadDat OR BadMove; (* til fil slut/defekt *)
      IF ~FoundMove THEN 
        TraekNr:=0;
      END;
    END; (* if file opened *)

    fresnd:=f.res<>done;
(*   Close(f); *)

    (* IF Demo *)
      IF ~Auto & (TraekNr>160) THEN (* DemoMax i Skak=160 *)
        n:=SimpleWIN(ADDRESS(Q[DemoMessage]));
      END;
    (* ENDIF *)
    IF TraekNr>0 THEN
      DEC(TraekNr);
    END;
    IF ~DiskOn & (TraekNr=1) THEN 
      DEC(TraekNr);
    END;
    IF (BadDat OR fresnd) & (TraekNr=0) OR ~FoundMove & ~SPEC THEN
      FraLine:=0;
      Concat(pst,Q[TxIKKEHENTET]^);
      IF f.res<>done THEN
        FilErr(f.res,errstr);
        Copy(est,errstr);
      ELSE
        IF DiskOn THEN
          Concat(pst2,Q[TxIKKESKAKFIL]^);
        ELSE
          Concat(pst2,Q[TxIKKESKAKTXT]^);
        END;
      END;
      ConcatChar(est,'\n');
      Concat(pst,est);
      Concat(pst,pst2);
      ERROR:=TRUE;
      IF ~Auto THEN
        n:=SimpleWIN(ADR(pst));
      END;
      MaxTraek:=0;
      TraekNr:=0;
      (* SetPtr(wptr,-1); *)
    ELSE (* helt eller delvist indlæst *)
      IF BadDat OR fresnd THEN (* Delvist indlæst *)
        BadDat:=FALSE;
        IF TraekNr>0 THEN
          sta.TrkNr:=TraekNr-1;
          FraLine:=FilLnr-1;
        ELSE        
          sta.TrkNr:=0;
        END;
        IF cq=' ' THEN
          Concat(pst,Q[TxUKORREKTKUNDELVIS]^);
          (* ERROR:=TRUE; *)
          IF COMPARE THEN
(*$IF Test *)
  WRITELN(s("kundel, COMPARE"));
(*$ENDIF *)
            IF ~Auto THEN
              n:=SimpleWIN(ADR(pst));
            END;

            IF ~fresnd THEN (* IF BadDat & Traeknr>0 !!!!! *)
              (* wind to next game *)
              BadMove:=FALSE;
              n:=0;
              LastFilLnr:=FilLnr;
              Lastpnr:=pnr;
              INC(KD);
              REPEAT
(*$IF Test0 *)
  WRITELN(s('Wind:')+c(c1)+s(' cfilpos=')+l(CFilPos));
(*$ENDIF *)
                GetC1;
                INC(n);
              UNTIL f.eof OR (f.res<>done) OR (c1='[') OR (n>65534);
              LastCnt:=n;
              IF ~f.eof & (f.res=done) & (FraLine>0) & (TraekNr>1) THEN
                FraLine:=FilLnr-1;
                ERROR:=FALSE;
              END;
              BadMove:=TRUE; (* BadMove:=~Auto; *)
            END;
          
          END;
        END;
      ELSE
        FraLine:=0;
      END;

      IF TraekNr>0 THEN
        MaxTraek:=TraekNr-1;
      ELSE
        MaxTraek:=0;
      END;
      IF sta.TrkNr>-1 THEN
        TraekNr:=sta.TrkNr;
      ELSE
        TraekNr:=0;
      END;

      MaxTeori:=0;

      IF ~DiskOn THEN
        TraekNr:=0;
      END;

      IF COMPARE THEN
        GetStilling(TraekNr+1);
      END;

      AdjDiskOn:=TRUE;

(*
      IF COMPARE THEN
      END;
*)

    END;
    IF f.eof & Auto & (KD>0) THEN
      pst2[0]:=0C;
      ValToStr(LastFilLnr,FALSE,st,10,1,' ',Err);
      Concat(pst2,st);
      Concat(pst2,' p');
      ValToStr(Lastpnr,FALSE,st,10,1,' ',Err);
      Concat(pst2,st);
(*    Concat(pst2,' skipped chars: ');
      ValToStr(LONGINT(LastCnt),FALSE,st,10,1,' ',Err);
      Concat(pst2,st);                   *)
      IF Lates2 THEN
        Concat(pst2,': ');
      ELSE
        ConcatChar(pst2,12C);
        ConcatChar(pst2,12C);
      END;

      ValToStr(KD,FALSE,st,10,1,' ',Err);
      Concat(pst2,st);
      Concat(pst2,Q[Q219]^);

      IF Lates2 THEN (* super-auto *)
        Copy(STR97PTR(Lates1)^,pst2)
      ELSE
        ConcatChar(pst2,12C);
        ConcatChar(pst2,12C);
        n:=SimpleWIN(ADR(pst2));
      END;
    END;
    (* Close(f); *)
  END;
END HentF; (***************   END  af  HentF   ************)
(*$ POP EntryClear *)

VAR
  savepath:STR97;

PROCEDURE GemF(LongFormOn:CHAR; DominansOn:BOOLEAN; Auto:BOOLEAN):BOOLEAN;
CONST
  RightMargen=67;
VAR
  f:File;
  lf:LONGINT;
  Title,sn,sd:STR97;
  lnr,n,m,um,ss,csn,FraT,Pos,p,lnrhlp:INTEGER;
  OK,Ok,NotPrt,UdgStill,Err,RokadeM,UnderM,Result:BOOLEAN;
  actual:LONGINT;
  res:Response;
  est:ERRSTR;
  pst,st:ARRAY[0..264] OF CHAR;
  FENstr:ARRAY[0..127] OF CHAR;
  stt,sti:STILLINGTYPE;
  ch,uc,cht,cht2:CHAR;
  c,cs:ARRAY[0..8] OF CHAR;
  mvt:MOVETYPE;
PROCEDURE WriteCh(VAR f:File; ch:CHAR);
BEGIN
  WriteChar(f,ch);
  IF ch=12C THEN
    Pos:=1; 
  ELSE
    INC(Pos);
  END;
END WriteCh; (* i GemF *)
PROCEDURE WriteByt(VAR f:File; adr:ADDRESS; len:LONGINT; VAR Actual:LONGINT; WrapLines:BOOLEAN);
VAR
  strptr:STRINGptr;
  n:INTEGER;
  ch,chold:CHAR;
BEGIN
  strptr:=adr;
  IF WrapLines & (Pos+len>RightMargen) THEN
    chold:=' ';
    FOR n:=0 TO len-1 DO
      chold:=ch;
      ch:=strptr^[n];
      IF (Pos>RightMargen) & (ch=' ') & (chold<>'.') THEN
        WriteCh(f,12C);
      ELSE
        WriteCh(f,ch);
      END;
    END;
  ELSE
    WriteBytes(f,adr,len,Actual);
  END;
  FOR n:=0 TO len-1 DO
    IF strptr^[n]=12C THEN
      Pos:=1;
    ELSE
      INC(Pos);
    END;
  END;
END WriteByt;
PROCEDURE MakeTextComment(color:CHAR); (* i GemF *)
VAR
  m,Nc:INTEGER;
  ch,NAGch0,NAGch1,NAGch2:CHAR;
  NAG:BOOLEAN;
  NAGnr:INTEGER;
  NAGstr:ARRAY[0..4] OF CHAR;
BEGIN
  (*$IF Test *)
    WRITELN(s("MakeTextComment"));
  (*$ENDIF *)
  IF (LongFormOn='L') THEN
    Nc:=0;
    ch:=Spil^[lnr].Tekst^[Nc];
    WHILE (ch='!') OR (ch='?') OR (ch='=') OR (ch='+') OR (ch='-') OR (ch='~') DO
      WriteCh(f,ch);
      INC(Nc);          
      ch:=Spil^[lnr].Tekst^[Nc];
    END;
    IF ch<>0C THEN
      IF (color='S') THEN
        WriteCh(f,12C);
      END;
      IF ch=' ' THEN
        INC(Nc);
      END;   
      IF NotPrt THEN
        WriteCh(f,';');
      END;
      FOR n:=Nc TO Length(Spil^[lnr].Tekst^)-1 DO
        WriteCh(f,Spil^[lnr].Tekst^[n]);
        IF Spil^[lnr].Tekst^[n]=12C THEN
          IF NotPrt THEN
            WriteCh(f,';');
          END;
        END;
      END;
    END;

    WriteCh(f,12C);
  ELSE 
    NAG:=FALSE;
    IF NoPGNinfos() THEN
      IF (Spil^[lnr].Tekst^[0]='$') THEN (* unNAG *) END;
    ELSE
      (* ChkNAG *)
      IF (Spil^[lnr].Tekst^[0]='$') THEN (* gem evt. NAGs uden paranteser *)
        NAGch1:=Spil^[lnr].Tekst^[1];
        IF (NAGch1>='0') & (NAGch1<='9') & (Length(Spil^[lnr].Tekst^)<5) THEN
          NAG:=TRUE;
          NAGnr:=-1;
        END;
      ELSE
        NAGch0:=Spil^[lnr].Tekst^[0];
        NAGch1:=Spil^[lnr].Tekst^[1];
        NAGch2:=Spil^[lnr].Tekst^[2];
        Nc:=2;
        IF    NAGch0='!' THEN
          IF (NAGch1=0C) OR (NAGch1=12C) OR (NAGch1=' ') THEN NAGnr:=1;  NAG:=TRUE; Nc:=1; END;
          IF NAGch1='!' THEN NAGnr:=3;  NAG:=TRUE; END;
          IF NAGch1='?' THEN NAGnr:=5;  NAG:=TRUE; END;
        ELSIF NAGch0='?' THEN 
          IF NAGch1='?' THEN NAGnr:=4;  NAG:=TRUE; END;
          IF (NAGch1=0C) OR (NAGch1=12C) OR (NAGch1=' ') THEN NAGnr:=2;  NAG:=TRUE; Nc:=1; END;
          IF NAGch1='!' THEN NAGnr:=6;  NAG:=TRUE; END;
        ELSIF NAGch0='=' THEN
          IF (NAGch1=0C) OR (NAGch1=12C) OR (NAGch1=' ') THEN NAGnr:=12; NAG:=TRUE; Nc:=1; END;
          IF NAGch1='=' THEN NAGnr:=11; NAG:=TRUE; END;
        ELSIF NAGch0='-' THEN
          IF NAGch1='-' THEN
            IF NAGch2='=' THEN NAGnr:=17; Nc:=3; ELSE NAGnr:=21 END;
            NAG:=TRUE;
          END;
          IF NAGch1='=' THEN NAGnr:=15; NAG:=TRUE; END;
          IF NAGch1='+' THEN NAGnr:=19; NAG:=TRUE; END;
        ELSIF NAGch0='+' THEN
          IF NAGch1='+' THEN
            IF NAGch2='=' THEN NAGnr:=16; Nc:=3; ELSE NAGnr:=20 END;
            NAG:=TRUE;
          END;
          IF NAGch1='=' THEN NAGnr:=14; NAG:=TRUE; END;
          IF NAGch1='-' THEN NAGnr:=18; NAG:=TRUE; END;
        ELSIF NAGch0='~' THEN
          NAGnr:=13;
          Nc:=1;
          NAG:=TRUE;
        END;
      END;
    END;
    IF NAG & (Lates3=1) THEN (* 0..99 kan virke her *)
      IF (NAGnr>0) & (NAGnr<100) THEN
        WriteCh(f,' ');
        WriteCh(f,'$');
        IF NAGnr>9 THEN
          WriteCh(f,CHR(NAGnr DIV 10+48));
        END;
        WriteCh(f,CHR(NAGnr MOD 10+48));
      END;
    ELSE
      IF ~NAG THEN
        WriteCh(f,' ');
        WriteCh(f,'(');
      END;
      WriteByt(f,Spil^[lnr].Tekst,Length(Spil^[lnr].Tekst^),actual,TRUE);
    END;
    IF NAG THEN
      WHILE Spil^[lnr].Tekst^[Nc]<>0C DO
        WriteCh(f,Spil^[lnr].Tekst^[Nc]);
        INC(Nc);
      END;
    ELSE
      WriteCh(f,')');
    END;
  END;
(*
  IF ~NAG THEN
    WriteCh(f,12C);
  END;
*)
  IF Occurs(Spil^[lnr].Tekst^,0,'<dia>',FALSE)>=0 THEN
    WriteByt(f,ADR('9________)\n'),11,actual,TRUE);
    FOR n:=8 TO 1 BY -1 DO
      WriteCh(f,CHR(n+48));
      FOR m:=1 TO 8 DO
        ch:=sti[n*10+m];
        IF    ch=' ' THEN ch:='f'
        ELSIF ch='m' THEN ch:='k'
        ELSIF ch='M' THEN ch:='K'
        ELSIF ch='e' THEN ch:='b'
        ELSIF ch='E' THEN ch:='B'
        ELSIF ch='r' THEN ch:='t'
        ELSIF ch='R' THEN ch:='T'
        END;
        IF ~ODD(n+m) THEN
          IF    ch='t' THEN ch:='y'
          ELSIF ch='T' THEN ch:='Y'
          ELSIF ch='s' THEN ch:='w'
          ELSIF ch='S' THEN ch:='W'
          ELSIF ch='l' THEN ch:='o'
          ELSIF ch='L' THEN ch:='O'
          ELSIF ch='k' THEN ch:='i'
          ELSIF ch='K' THEN ch:='I'
          ELSIF ch='d' THEN ch:='e'
          ELSIF ch='D' THEN ch:='E'
          ELSIF ch='b' THEN ch:='g'
          ELSIF ch='B' THEN ch:='G'
          ELSIF ch='f' THEN ch:='r'
          ELSE
            ch:='?';
          END; 
        END;
        WriteCh(f,ch);  
      END;
      IF (n=7) & (sti[HvisTur]='S') OR (n=2) & (sti[HvisTur]<>'S') THEN
        WriteCh(f,'*');
      ELSE
        WriteCh(f,'\\');
      END;
      WriteCh(f,'\n');
    END;
    WriteByt(f,ADR('0!"#¤%&/(=\n'),11,actual,TRUE);
  END;
END MakeTextComment; (* i GemF *)
PROCEDURE Wp(stc:ARRAY OF CHAR; std:ARRAY OF CHAR; Always:BOOLEAN);
BEGIN
  (*$IF Test0 *)
    WRITELN(s("Wp NYYY"));
  (*$ENDIF *)
  IF Always OR (std[0]<>0C) THEN
    WriteCh(f,'[');

    (* print stc *)
    n:=0;
    WHILE (n<=HIGH(stc)) & (stc[n]<>0C) DO
      WriteCh(f,stc[n]);
      INC(n);
    END;

    WriteCh(f,' ');
    WriteCh(f,'"');

    (* print std *)
    n:=0;
    WHILE std[n]<>0C DO
      WriteCh(f,std[n]);
      INC(n);
    END;

    WriteCh(f,'"');
    WriteCh(f,']');
    WriteCh(f,12C);
  END;
END Wp; (* i gemF *)
BEGIN (* GemF *)
(*$ IF Test *) QQ(' gemF',start.Still);(*$ ENDIF *)
  (*$IF Test *)
    WRITELN(s("GemF"));
  (*$ENDIF *)
  IF DiskOn THEN
    HelpNr:=10;
    Copy(Title,Q[TxGEMSPIL]^);
    OK:=simpleFileRequester2(Title,name,path,dir);
    IF OK & ((FilType=0) OR (FilType=2)) THEN (* ukendt eller sk20 *)
      OK:=TwoGadWIN(ADDRESS(Q[265]))=1;
    END;
    (*$IF Test0 *)
      WRITELN(s(path));
    (*$ENDIF *)
  ELSE
    HelpNr:=60;
    IF Auto THEN 
      OK:=TRUE;
      FilType:=0;
      IF VariantTil THEN
        savepath:=TmpFil;
        FilType:=-1;
      END;
    ELSE
      Copy(Title,Q[TxSKRIVSPIL]^);
      sn:="prt:";
      sd[0]:=0C;
      OK:=simpleFileRequester2(Title,sn,savepath,sd);
      IF OK & (FilType>=0) THEN
        OK:=TwoGadWIN(ADDRESS(Q[265]))=1;
      END;

    END;
  END;
  (*$IF Demo *)
    IF MaxTraek>160 THEN
      lnr:=SimpleWIN(ADDRESS(Q[DemoMessage]));
      (* OK:=FALSE; *)
    END;
  (*$ ENDIF *)
    IF OK THEN
      SetPtr(wptr,PTRsove);
      UdgStill := Equal(StartStilling,start.Still);
      Pos:=1;
      IF DiskOn THEN
        Lookup(f,path,FilBufferSzWrite,TRUE);
      ELSE
(*$IF Test *)
  WRITELN(s('Lookup save fil=')+s(savepath));
(*$ENDIF *)
        IF (FilType=0) THEN
          Lookup(f,savepath,FilBufferSzWrite,FALSE);
        END;
        IF (FilType<>0) OR (f.res=notFound) THEN
(*$IF Test *)
  WRITELN(s('Lookup save, newfile'));
(*$ENDIF *)
          Lookup(f,savepath,FilBufferSzWrite,TRUE);
        ELSE
          FileSystem.Length(f,lf);
          SetPos(f,lf);
        END;
      END;
      IF f.res=done THEN
(*
  WRITELN(s('res=done'));
*)
        lnr:=0;
        Spil^[0].Fra:=1;
        Spil^[0].Til:=1;
        WITH start DO
          IF DominansOn THEN (* -128 for uændret *)
            DomOn:=1;
          ELSE
            DomOn:=0;
          END;
          StyOv:=ABS(StyO);  (* 0=mand, 1-9=Maskine(Styrke), -128 for uændret *)
          StyUn:=ABS(StyU); 
          IF OpAd THEN       (* -128 for uændret *)
            Opad:=1;
          ELSE
            Opad:=0;
          END;
          TrkNr:=TraekNr;    (* -128 for uændret *)
          Late1:=0;
          Late2:=0;
          Late3:=0;
        END;
        IF DiskOn THEN
          WriteCh(f,'S');WriteCh(f,'K');WriteCh(f,'1');
          IF NoPGNinfos() THEN
            WriteCh(f,'0');
          ELSE
            (* SK11 så gem PGNs *)
            WriteCh(f,'1');
            FOR n:=gEvent TO MaxExtras DO
              (* gem streng *)
              m:=-1;
              REPEAT
                INC(m);
                WriteCh(f,gExtras[n,m]);
              UNTIL gExtras[n,m]=0C;
            END;
          END;
          (* 'SK' for valid skak-fil, '10' for V1.0 genereret *)
          IF UdgStill THEN
    (*
      WRITELN(s('UdgangsStilling'));
    *)
(*$ IF Test *) WRITELN(s('UdgangsStilling'));QQ(' gemF.Udg',start.Still);(*$ ENDIF *)
            WriteCh(f,CHAR(SIZE(start)-SIZE(STILLINGTYPE)));
            WriteByt(f,ADR(start),SIZE(start)-SIZE(STILLINGTYPE),actual,FALSE);
          ELSE
(*$ IF Test *) WRITELN(s('~UdgangsStilling')); QQ(' gemF.e1',start.Still);(*$ ENDIF *)
            WriteCh(f,CHAR(SIZE(start)));
            WriteByt(f,ADR(start),SIZE(start),actual,FALSE);
(*$ IF Test *) QQ(' gemF.e2',start.Still);(*$ ENDIF *)
          END;
        ELSE
          NotPrt:=(Compare(savepath,"prt:")<>0) & (Compare(savepath,"PRT:")<>0) & (Compare(savepath,"prt")<>0); (*!!!!!!!!!!!!!!!!!!!*)
          sti:=start.Still;
          ch:=start.Still[HvisTur];
          IF ~UdgStill & ~VariantTil & NoPGNinfos() THEN
            FOR n:=9 TO 0 BY -1 DO
              FOR m:=0 TO 9 DO
                IF ~NotPrt THEN 
                  WriteCh(f,' ');
                END;
                WriteCh(f,LP(start.Still[10*n+m]));
              END;
              IF (n=7) & (ch='S') OR (n=2) & (ch<>'S') THEN
                IF ~NotPrt THEN
                  WriteCh(f,' ');
                END;
                WriteCh(f,'*');
              END;
              WriteCh(f,12C);
            END;
          ELSE
            IF ~VariantTil & ~NoPGNinfos() THEN (* Et PGN spil, gem PGNs *)
              FOR p:=-12 TO gResult DO
                Wp(gLabels[p],gExtras[p],TRUE);
              END;
              FOR p:=gWhiteTitle TO MaxExtras DO
                Wp(gLabels[p],gExtras[p],FALSE);
              END;
              IF ~UdgStill THEN
                STILLINGtoFEN(FENstr,start.Still);
                Wp('SetUp','1',TRUE);
                Wp('FEN',FENstr,TRUE);
              END;
              WriteCh(f,12C);
            END;
          END;
          IF (f.res=done) & (Spil^[lnr].Tekst<>NIL) THEN
            (*MakeTextComment;*)
          END;
        END;

        ss:=0; (* ss=1 for sort starter *)
        REPEAT
          Result:=FALSE;

          IF (f.res=done) & (Spil^[lnr].Tekst<>NIL) & DiskOn THEN      
            WriteCh(f,0C);
            WriteByt(f,Spil^[lnr].Tekst,Length(Spil^[lnr].Tekst^)+1,actual,TRUE);
          END;

          IF DiskOn THEN
            WriteCh(f,CHAR(Spil^[lnr].Fra));
            WriteCh(f,CHAR(Spil^[lnr].Til));
          ELSE
            IF lnr>0 THEN
              IF (ch<>'S') OR (lnr=1) THEN (* hvid eller start-sort*)
                IF LongFormOn='L' THEN (* Lang notationsform *)
                  ValToStr((lnr+1+ss)/2,FALSE,st,10,4,' ',Err);
                ELSE
                  IF VariantTil THEN
                    lnrhlp:=lnr+Later2; (* Later2=VarMaxTraekNr *)
                  ELSE
                    lnrhlp:=lnr;
                  END;
                  ValToStr((lnrhlp+1+ss)/2,FALSE,st,10,1,' ',Err);
                END;
                IF Pos>RightMargen THEN
                  WriteCh(f,12C);
                END;
                IF Pos>1 THEN
                  WriteCh(f,' ');
                END;
                WriteByt(f,ADR(st),Length(st),actual,TRUE);
                WriteCh(f,'.');
                IF ch='S' THEN
(*
  WRITELN(s('  -  '));
ENDIF *)
                  IF LongFormOn='L' THEN
                    WriteByt(f,ADR('    -     '),10,actual,TRUE);
                  ELSE 
                    WriteByt(f,ADR(' -'),2,actual,TRUE);
                  END;
                  ss:=1; (* sort starter, så inc lnr i udskrift *)
                END;
              END;
              WriteCh(f,' ');

              RokadeM:=FALSE;
              UnderM:=FALSE;
              csn:=0;
              cht:=sti[Spil^[lnr].Fra];
              CASE CAP(cht) OF
                | 'M'     : c[0]:=LP('K'); RokadeM:=TRUE;
                | 'K'     : c[0]:=LP('K');
                | 'T','R' : c[0]:=LP('T');
                | 'B'     : c[0]:=LP('B'); UnderM:=TRUE;
                | 'E'     : c[0]:=LP('B');
                | 'S'     : c[0]:=LP('S');
                | 'L'     : c[0]:=LP('L');
                | 'D'     : c[0]:=LP('D');
              ELSE
                c[0]:='?';
              END;
              c[1]:=CHAR(Spil^[lnr].Fra MOD 10+96);
              c[2]:=CHAR(Spil^[lnr].Fra DIV 10+48);
              (* c0-2 er nu Lokal-brik+frafelt, f.eks. Be2  cht=brik intern*)

              IF (LongFormOn='S') & (CAP(cht)<>'B') THEN (* shortform, ikke-bonde *)
                (* er der andre mulige fra-brikker ? *)
                IF cht='R' THEN
                  cht:='T';
                END;
                IF cht='r' THEN
                  cht:='t';
                END;
                FraT:=10;
                stt:=sti;
                REPEAT (* find evt alternativ fra-brik *)
                  INC(FraT);
                  cht2:=sti[FraT];
                  IF cht2='R' THEN
                    cht2:='T';
                  END;
                  IF cht2='r' THEN
                    cht2:='t';
                  END;
                  IF (cht=cht2) & (FraT<>Spil^[lnr].Fra) THEN
                    IF DoMoveOk(stt,FraT,Spil^[lnr].Til,mvt) THEN
                      FraT:=FraT+100;
                    END;
                  END;
                UNTIL FraT>=88;
                IF FraT>88 THEN (* Fundet lovligt alternativ *)
                  (* forskellig række så husk række (a-h), ellers linie (1-8) *)
                  IF Spil^[lnr].Fra MOD 10 <> (FraT-100) MOD 10 THEN
                    cht:=c[1];
                  ELSE
                    cht:=c[2];
                  END;
                ELSE
                  cht:=' ';
                END;
              ELSE
                cht:=' '; (* !!!!!!!!!! *)
              END; (* andre brikker scan *)
              (* cht<>' ' er nu indikator af hvilken brik hvis flere mulige *)

              IF ~DoMoveOk(sti,Spil^[lnr].Fra,Spil^[lnr].Til,mvt) THEN END;
              c[4]:=CHAR(Spil^[lnr].Til MOD 10+96);
              c[5]:=CHAR(Spil^[lnr].Til DIV 10+48);
              (* c4-5 er nu til-felt f.eks. e4 *)

              (* Hvis Brik <> bonde, så ud med brik-tegn (til cs) *)
              IF c[0]<>LP('B') THEN
                cs[csn]:=c[0];
                INC(csn);

                (* Hvis alternativ fra, så ud med alternativ indikation *)
                IF cht<>' ' THEN
                  cs[csn]:=cht;
                  INC(csn);
                END;
              ELSE
                (* Hvis bonde-slag så ud med linie (a-h) *)
                IF slag IN mvt THEN
                  cs[csn]:=c[1];
                  INC(csn);
                END;
              END;
              uc:=' ';
              IF UnderM THEN   (* Hvis Bonde, så ret hvis underforvandling *)
                IF ch<>'S' THEN (* Hvid *)
                  IF Spil^[lnr].Fra>70 THEN
                    uc:='D';
                    IF Spil^[lnr].Til<Spil^[lnr].Fra+9 THEN
                      um:=20;
                      uc:='T';
                      IF Spil^[lnr].Til+um<Spil^[lnr].Fra+9 THEN
                        um:=30;
                        uc:='S';
                        IF Spil^[lnr].Til+um<Spil^[lnr].Fra+9 THEN
                          um:=40;
                          uc:='L';
                        END;
                      END;
                      c[4]:=CHAR((Spil^[lnr].Til+um) MOD 10+96);
                      c[5]:=CHAR((Spil^[lnr].Til+um) DIV 10+48);
                    END;
                  END;
                ELSE
                  IF Spil^[lnr].Fra<29 THEN
                    uc:='D';
                    IF Spil^[lnr].Til>Spil^[lnr].Fra-9 THEN
                      um:=20;
                      uc:='T';
                      IF Spil^[lnr].Til-um>Spil^[lnr].Fra-9 THEN
                        um:=30;
                        uc:='S';
                        IF Spil^[lnr].Til-um>Spil^[lnr].Fra-9 THEN
                          um:=40;
                          uc:='L';
                        END;
                      END;
                      c[4]:=CHAR((Spil^[lnr].Til-um) MOD 10+96);
                      c[5]:=CHAR((Spil^[lnr].Til-um) DIV 10+48);
                    END;
                  END;
                END;
              END; (* underforvandling check på bønder *)

              IF slag IN mvt THEN
                c[3]:='x';
                cs[csn]:='x';
                INC(csn);
              ELSE
                c[3]:='-';
              END;

              (* send til-felt ud *)
              cs[csn]:=c[4];
              INC(csn);
              cs[csn]:=c[5];
              INC(csn);

              IF uc<>' ' THEN (* så underforvandling, send ud *)
                c[6]:=LP(uc);
                c[7]:=0C;
                cs[csn]:='=';
                INC(csn);
                cs[csn]:=LP(uc);
                INC(csn);
              ELSE
                c[6]:=0C;
              END;
              IF RokadeM THEN        (* Rokade, så ret til O-O *)
                IF c[4]='c' THEN
                  c:='O-O-O ';
                  cs:='O-O-O';
                  csn:=5;
                END;
                IF c[4]='g' THEN
                  c:='O-O   ';
                  cs:='O-O';
                  csn:=3;
                END;
              END;
              IF LongFormOn='L' THEN (* lang-form *)
                um:=Length(c);
                WriteByt(f,ADR(c),um,actual,TRUE);
                IF (mvt=MOVEnormal) OR (slag IN mvt) THEN
                  WriteCh(f,' '); IF um<7 THEN WriteCh(f,' ');END;
                ELSIF rokade IN mvt THEN
                  WriteCh(f,' '); IF um<7 THEN WriteCh(f,' ');END;
                ELSIF enpassant IN mvt THEN
                  WriteCh(f,'e'); WriteCh(f,'p');
                ELSIF pat IN mvt THEN
                  WriteCh(f,'='); IF um<7 THEN WriteCh(f,' ');END;
                ELSIF mat IN mvt THEN
                  WriteCh(f,'+'); WriteCh(f,'+');
                ELSIF skak IN mvt THEN
                  WriteCh(f,'+'); IF um<7 THEN WriteCh(f,' ');END;
                END;
                IF ch<>'S' THEN 
                  WriteCh(f,' ');
                ELSE
                  WriteCh(f,12C);
                END;
              ELSE
                cs[csn]:=0C;
(*
                IF Pos>RightMargen THEN
                  WriteCh(f,12C);
                END;
*)
                WriteByt(f,ADR(cs),Length(cs),actual,TRUE);
                IF pat IN mvt THEN
                  WriteByt(f,ADR('= 1/2-1/2'),9,actual,TRUE);
                  Result:=TRUE;
                ELSIF mat IN mvt THEN
                  IF ch='S' THEN
                    WriteByt(f,ADR('# 0-1'),5,actual,TRUE);
                  ELSE
                    WriteByt(f,ADR('# 1-0'),5,actual,TRUE);
                  END;
                  Result:=TRUE;
                ELSIF skak IN mvt THEN
                  WriteCh(f,'+');
                END;
              END;

            END;
          END;

          ch:=sti[HvisTur];

          IF (f.res=done) & (Spil^[lnr].Tekst<>NIL) & ~DiskOn THEN
            MakeTextComment(ch);
            IF (lnr>0) & (ch='S') THEN
(*
  WRITELN(s('           -'));
ENDIF *)
              IF LongFormOn='L' THEN
                WriteByt(f,ADR("        -        "),15,actual,TRUE);
              ELSE
                (*
                WriteByt(f,ADR(" - "),3,actual,TRUE);
                *)
              END;
            END;
          END;

          INC(lnr);
        UNTIL (lnr>MaxTraek) OR ~(done=f.res);
        IF DiskOn THEN
          IF f.res<>done THEN
            FileSystem.Delete(f);
          END;
        ELSE
          IF ~VariantTil THEN
            IF (gExtras[gWhite,0]<>0C) & ~Result THEN
              WriteCh(f,' ');
              WriteByt(f,ADR(gExtras[gResult]),Length(gExtras[gResult]),actual,TRUE);
            END;
            WriteCh(f,12C);
          END;
          WriteCh(f,12C);
        END;
        Close(f);
      ELSE
        OK:=FALSE;
      END;
      IF f.res<>done THEN
        IF DiskOn THEN
          Copy(pst,Q[TxIKKEGEMT]^);
        ELSE
          Copy(pst,Q[TxIKKEUDSKREVET]^);
        END;
        FilErr(f.res,est);
        Concat(est,'\n');
        Concat(pst,est);
        lnr:=SimpleWIN(ADR(pst));
      END;
      SetPtr(wptr,PTRrestore);
    END;
  (* ENDIF *)
  IF OK & DiskOn THEN
(*$IF Test *)
  WRITELN(s('rettetREM,SPIL,PGN=F'));
(*$ENDIF *)
    rettetREM :=FALSE;
    rettetSPIL:=FALSE;
    rettetPGN :=FALSE;
  END;
  (*$IF Test *)
    WRITELN(s("GemF.end"));
  (*$ENDIF *)
  RETURN(OK);
END GemF;

BEGIN
(*$IF Test *)
  WRITELN(s('SkakFil.1'));
(*$ENDIF *)
  LogVersion("SkakFil.def",SkakFilDefCompilation);
  LogVersion("SkakFil.mod",SkakFilModCompilation);

  FirstTime:=TRUE;
  (* firsttime simplefilerequester called: Copy(NEGTEXT,Q[TxUPS]^);
     Because it's initiated later by SkakScreen (cause tooltypes binding)
  *)

  Allocate(STR97PTR(Lates1),100);
  Lates2:=FALSE;
  LastFilLnr:=0;
  Lastpnr:=0;
  LastCnt:=0;

  SetPGNinfos;
(*$IF Test *)
  WRITELN(s('rettetREM,PGN,SPIL=F'));
(*$ ENDIF *)

  rettetREM:=FALSE;
  rettetSPIL:=FALSE;
  rettetPGN:=FALSE;
  SetPGNinfos;
  still(StartStilling,'');
(*$IF Test *)
  WRITELN(s('SkakFil.2'));
(*$ENDIF *)
END SkakFil.

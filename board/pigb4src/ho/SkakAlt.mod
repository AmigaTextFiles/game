IMPLEMENTATION MODULE SkakAlt; (* Lær-Skak, (c) E.B.Madsen DK 91-95, Rev 20/4-97 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Demo:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)
(*$ DEFINE False:=FALSE *)

(*$ DEFINE Quick:=FALSE *)

(*$ LongAlign:=TRUE StackParms:=FALSE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=FALSE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=FALSE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

(* Work-> Compiler bug i EXCL procedure, 4 timer spildt (Grrr).  Outline
Select kan ikke bruges ved overlappende gadgets, 2-3 timer spildt (Grr),
(det står i manualen, så no excuses.) RefreshGlist bug, stopper ikke ved
max.  2 timer spildt (Grr), lavet patch-rutine RefreshGadget, der løser
problemet.  COMPILER (BUG) ok:=DoMoveOk(stilling,Traek.Fra:INTEGER,tt);
BUGS :
  RangError i 'Kommentar', SkakScreen.GetText underløb i løkke, nu OK
  OverFlow i GetD og i GetV, OK
  For langsom på hi level, OK
  Break af tænke, OK
  Buffer problemer, EmptyMsg lavet og kaldes passende steder, OK
  For lang tid på høj niveau, interruptable, OK
  H/S update error, OK
  Nytspil,OK gir ikke reset af pile, hvis i forvejen udgangsstilling, ACCEPTED
  Setup,ret,OK heller ikke, OK
  Vend bræt, skal også spejle x, OK
  -  "  -                     Gd 30,31-37, 38,41-47 , OK
  Setup-select resettes ikke -> main, OK
  I Debug 'låses' når der udskrives samtidig med aktivitet (højre knap), WORKING
  10-91 Parametre på fil bruges ikke, Hvistur opdateres ikke, OK
  10-91 Mangler intelligent fremad (evt cashes), OK
  12-91 M2 4.0, ChipMem for grafik, OK
  12-91 Print+ikon, OK
  12-91 Kommentar til tomt parti, nu OK
  12-91 Betinget kompilering, Demo,Named,De-Crack,Test, OK
  01-92 tekst-read,write (med evt speciel start-stilling), (OK)
  01-92 Hånd sprite Hot-point skal ned? NEJ!!!
  01-92 Default stilling ved Save/Load, OK
  01-92 OpNed,DomiOn,StyO/U,TraekNr sættes nu ved indlæsning, (OK)
  01-92 AutoOK kommentarer ville være bedre (evt. direkte Edit)
  01-92 BrikNavn og skak (o-o også ind, OK) på udskrift mangler
  01-92 OK, UPS tekst bør være grafik
  01-92 Check af Tekst parti ind mangler, OK
  01-92 Alt i paranteser indlæses som kommentarer, OK
  02-92 CustomScreen, OK
  02-92 Arguments/ToolTypes, OK
  02-92 Modificeret Speak task kontrol, (OK)
  05-92 Load med intelligent FRA, OK
  11-92 Localization, DK-OK, GB-(OK) , S, D, WORKING
  12-92 Localization, DK+GB, OK
  05-93 Documentation, (OK)
  03-94 Re-check, v4.2 compilation, busy<>ready ptr var byttet (AnimPointer), OK
  03-94 Requester module re named to RequestFile
  04-94 MarkMoves kalder GetNextTil (via GetNext) der nu genererer
        underforvandlingstræk, der IKKE skal Mark'es, OK
  04-94 Bladr i parti/load når markerede træk så afmarkeres de ikke, OK
  04-94 Nu V1.1, Bedre Bladre, Mikro Teori.
  04-94 Teorifil, nu V1.2, OK  
  04-94 EntryClear=TRUE for at undgå trap 15, WORKING
  04-94 CountFar justering i SkakBrain.Eval disablet, skal fjernes?, OK
  04-94 Sorting of Entry moves in Find, OK
  04-94 - " - save game temporary disablet to allow to compile, RESTORED, OK
  04-94 Find, FindTrk, still, Equal flyttet til SkakScreen, OK
  04-94 DoMoveC indført i SkakBrain, FindStilling MEGET kortere, OK
  04-94 - " - fjernede underforvandlingsfejl ved bladre!!!, NU v1.3, OK
  04-94 VersionLog, VersionList vises ved ved FØRSTE Help, OK
  04-94 Setup message now about ALL the problems with a position, OK
  05-94 Underforvandling, Load/save, (load/save/read/write OK), OK
  05-94 Sort-starter var ikke integreret i printud, OK
  05-94 ORD(CHARtype) bruger 4 bytes mere end INTEGER(CHARtype), problem?
        Skal i stedet bruges SHORTINT(CHARtype)
  05-94 HENT tekst errorhandling forfinet, OK
  05-94 HENT errortekst blev til tider afskåret, OK
  05-94 International Tekst-load skal også kunne fra DK-version, OK
  05-94 TEXT-load: Udover Fra-til og brik-til også brik-linie-til, OK
  05-94 IDE: gem træk som legal-træk-nr (så kun 7-8 bit/træk), OK
  05-94 IDE: gem stilling som 16*6 bit + 16*6 bit = 24 bytes + 4 bit til
             tårnes rokaderet (ep bonde hvis på 1'ste række) + 1 bit til
             hvistur KBTBLBSBDBTBLBSB (bønder KAN gemmes som 5 bit! (22b5 byte)
             eller alle slåede kan afskæres bagfra.
             RECORD Bedst pakkede stilling:
               BrikkerMed       :0..7    (SET[16,15,14,12,10,8,6,4])
               Hvidstur         :BIT;
               Tårn1HvidRykket  :BIT; Tårn2HvidRykket  :BIT;
               Tårn1SortRykket  :BIT; Tårn1SortRykket  :BIT;
             END;
             RECORD gange to, afskåret til BrikkerMed 
               K:0..63;Ba:0..31;T:0..63;Bb:0..31;L:0..63;Bc:0..31;S:0..63;Bd:0..31;
               D:0..63;Be:0..31;T:0..63;Bf:0..31;L:0..63;Bg:0..31;S:0..63;Bh:0..31;
             END; (bønder kan stå på max 1+3+5+7+8(7+1ep)+8=32 felter)
             i alt 6.5 -> 23 bytes (snit på ca 20?) 
  05-94 txt infoboxe virker ikke mere?, OK
  05-94 Tekstfiler ser nu også tekst i [ ] som kommentarer, OK
  05-94 Load af spil UNDEN comments vil ikke slette gl. comments, OK
  05-94 Udskriv mister evt. kommentar før 1'ste træk, OK
  05-94 Txt ud med ustandardiseret startstilling fejl (LP()), OK
  05-94 HENT tekst med ustandardiseret startstilling fejl i IKKE-DK, (OK)
  05-94 Multiread fra pgm filer, men kommentar-forskydning, OK
  05-94 ToolType INTERNATIONAL gi'r Engelsk TEKST læs/skriv i stedet for lokal, OK
  05-94 !!!!!!!!!!!!! Sorts tårne kunne KUN rykke forlæns !!!!!!!!!!!, OK
  06-94 kort-notation Bondetræk efter rokade kunne ikke indlæses, OK
  06-94 Stilling er filter ved indlæsning af tekst-partier, (OK)
  06-94 kort-notation Bondetræk efter bondeforvandling ku ik' indlæses, OK
  06-94 SkakSprog (før SkakDiv) indeholder nu alle tekster, OK
  06-94 DataBase append, OK
  06-94 Læs pgn filer svigt når resultat er i egen linie, WORKING
  06-94 FilErr,LP,GetStilling,HentF flyttet til nyt modul: SkakFil, OK 
  12-94 GetMove, GetMoveNr, OK
  02-95 Save to Base, NAVN PIG-BASE (Pgn International-chess Games BASE) 
  02-95 Save SK20 flyttet til skakfil og andet, OK
  02-95 PGN datastrukturer indarbejdede, OK
  02-95 DataBase Append, Save, (OK?)
  02-95 Print PGN i ikke-dansk fejlede bønder, OK

  03-95 Save tager IKKE pgn info med som kommentar til 1'ste linie, OK
  03-95 Ingen ok to delete game når funktion, der sletter det
  03-95 match træk viser = som help navn, WORKING
  03-95 kan ikke promotes? powerpackes? PATH length?
  03-95 help/(pgn) boxe ikke permanente, (OK)
  03-95 matchvariant kun >1, OK
  04-95 RydSpil problem, OK
  04-95 LoadListe seriøst problem ved slet, OK
  04-95 Siger Skak-mat ved PAT, WORKING
  04-95 PGN win åben/luk igen ved 1'ste, WORKING
  04-95 Delete toggle fra liste, OK
  04-95 Slettede flag i filter, OK
  04-95 Årstal fejl, OK
  04-95 PGNs ikke med i SK10 gem/hent (nu med som SK11), (OK)
  04-95 Filerequester return problem, OK, nu vises Size i K
  04-95 Flere Tooltyper, men ikke underforvandling brikker vist mere, OK 
  04-95 Udskriv nu med () om tekster i shortform, (OK)
  04-95 LOCALE af RydSpil, Kopi20, Delete, (OK)
  04-95 LOCALE af (auto)PGNtilPIG, PIGtilPGN, PIGtilPIG, WORKING
  04-95 NICkey= flyttes, OK
  04-95 skriver Me8-g8 i toplinie, WORKING
  04-95 Gl. SK20 format kan ikke variantsøge helt korrekt, WORKING
  04-95 Hvis Clr af FileRequester rescannes ikke, (OK)
  05-95 LOCALE af linie 938 , WORKING
  05-95 Hent holder nu fil åben ved PGNtilPIG hel-fil konvertering, (OK)
  09-95 Shareware begrænsninger for de nye PIGbase funktioner er nu indlagt.
  10-95 SKAKdata vil nu indlæse brikker fra evt. ilbm dir og SkakScreen vil nu
        justere vinduet efter brikstørrelse (fra hvidt felt 001) og åbne skærm
        interlaced hvis nødvendigt.
  10-95 Animer af underforvandling nu korrekt!
  10-95 Nu vil skærm ku startes i andre farvedybder (bestemt af hvidt felt 001).
        Palette gemmes nu når ændret. En palette for hver farvedybde.
        Ryk sletter nu heller ikke pgn infos i 1ste træk
  12-95 PIG save appender til ALLE typer FILER!!!
        10 nye ikoner til PIG, Variant ikon, (to) tekst ikon, OK
  04-96 Forslag til PIGtools:
        - Sorter (4 niveauer, alle? felter, variant?).
        - list (Site,gamecount,winner?)
        - split i Sites
        - Replace text (alle? felter, kommentarer).
        - turnerings-skema(er)
        - dubletter?
  06-96 - sorter turnerings-skema
  07-97 Better PGN to PIG (faster, less disk trashing, better info)

FEN is "Forsyth-Edwards Notation"; it is a standard for describing chess
positions using the ASCII character set (CAP=Black).
ex:  rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2
     8-1række w/b Rokademuligheder EPfelt(eller-) 50Træk Træknr

*)

(*
   SK10 FIL-FORMAT :
     SK10         4 BYTES   filtype skak1.0 (SK validerer fil)
     n            1 BYTE    startbloks længde (n<100 så udgangsstilling)
     0C           1 BYTE    så er der tekststreng (nul-termineret) til Halvtræk
     Fra,Til      2 BYTES   Halvtræk

   SK11 FIL-FORMAT :
     SK11         4 BYTES   filtype skak1.1 (SK validerer fil)
                 35 STRENGE (-12..22) PGN infos
     n            1 BYTE    startbloks længde (n<100 så udgangsstilling)
     0C           1 BYTE    så er der tekststreng (nul-termineret) til Halvtræk
     Fra,Til      2 BYTES   Halvtræk

   TEKST-FIL FORMAT:
     Evt: stilling (første tegn '.') som 10 første tegn på de 10 første linier.
          Kant laves med '.'  Tomt felt med ' '
          'T','R'     for (SORT med STORT) Tårn, Rokadeberettiget Tårn
          'K','M'     for Konge, Majestæt (RokadeBerettiget Konge)
          'B','E'     for Bonde, EnpassantBonde
          'S','L','D' for Springer, Løber, Dronning
          trkmbesld   for hvids brikker
*)
(*
          En * umiddelbart efter en af de første 4 linier indikerer Sorts tur.
     Hvert lovligt tal (1-8) med et lovligt tegn før (a-h,A-H) er en koordinat.
     Hver to koordinater er et træk.
     Alt efter ; (resten af linien) er kommentarer (kun een pr træk huskes)       

*)

FROM SYSTEM IMPORT
  ADR, ADDRESS, ASSEMBLE, CAST, BPTR, BYTE, LONGSET;
FROM Arts IMPORT
  BreakPoint, wbStarted, thisTask;
FROM Heap IMPORT
  Allocate, Deallocate;
FROM String IMPORT
  Copy, LastPos, Length, Compare, Concat, ConcatChar, CapString, Occurs, Delete;
FROM StrSupport IMPORT
  Eq,CardVal;
FROM Conversions IMPORT
  ValToStr,StrToVal;
FROM DosD IMPORT
  ProcessId, FileHandlePtr, ProcessPtr,
  FileInfoBlock,FileInfoBlockPtr, FileLockPtr, FileLock, accessRead;
FROM DosL IMPORT
  Delay, CreateProc, Execute, Input, Output,
  Examine, ExNext, Lock, UnLock;
FROM ExecD IMPORT
  MemReqSet, MemReqs, TaskPtr, Message, MessagePtr, MsgPort, MsgPortPtr,
  IORequest;
FROM ExecL IMPORT
  ReplyMsg, WaitPort, GetMsg, AvailMem, Forbid, Permit, PutMsg,
  FindPort, FindTask, OpenDevice;
FROM GraphicsD IMPORT
  DrawModeSet, DrawModes;
FROM FileSystem IMPORT
  File, FileMode, FileModeSet, Lookup, Close, ReadBytes, WriteBytes, 
  Response, ReadChar, WriteChar, GetPos, SetPos;
IMPORT FileSystem;
FROM FileSystemSupport IMPORT
  ReadString, WriteString, WriteStr;
FROM Console IMPORT RawKeyConvert;
FROM InputEvent	IMPORT InputEvent,InputEventPtr,Class;
FROM IntuitionD IMPORT
  boolGadget, stdScreenHeight, GadgetPtr, IDCMPFlagSet, IDCMPFlags,
  IntuiMessagePtr, WindowPtr, WindowFlags, WindowFlagSet, strGadget, propGadget,
  PropInfoPtr, StringInfoPtr, IntuiText, gadgHNone, IntuiTextPtr, GadgetFlags;
FROM IntuitionL IMPORT
  CloseWindow, RefreshGList, PrintIText, NewModifyProp, ActivateGadget,
  ActivateWindow, SizeWindow, CurrentTime;
FROM OptReq IMPORT
  ColorRequester,reqBase;
FROM QuickIntuition IMPORT
  AF, AFS, GFS, AddGadget, AddIntuiText, AddBorder, OutLine,GetString;
FROM QISupport IMPORT
  SimpleWIN, TwoGadWIN, ThreeGadWIN,
  VINDUE, STRINGPTR, CREATEWIN, OPENWIN, WAITWIN, CLOSEWIN, MSGWIN, PRINTWIN,
  EscWIN, OkWIN, DropWIN, ActiveWIN, InactiveWIN, OpenInfoWIN, PrintInfoWIN,
  CloseInfoWIN, swptr, CenterWIN, txtOK, txtDROP, txtUPS, MsgCloseInfoWIN,
  SetGadget, SetToggl, GetToggl;
FROM PointerSprites IMPORT
  SetPtr;
FROM NarratorSupport IMPORT
  PrepareNarrator, CloseNarrator, SetVoiceParams, Say;
FROM ExecSupport IMPORT
  CreateTask, DeleteTask, CreatePort, DeletePort;
(*$IF Test *)
  FROM W IMPORT
    WRITELN, WRITE, CONCAT, s, l, lf, c, READs, b;
(*$ENDIF *)

FROM VersionLog IMPORT
  LogVersion, VersionList, MaxLogs;
FROM SKAKdata IMPORT
  sth;
FROM SkakBase IMPORT
  HvisTur, STILLINGTYPE, SetUpMode, Valg, StyO, StyU, VlmO, VlmU, 
  VlpO, VlpU, TraekNr, MaxTraek, sptr,
  OpAd, Simple, Debug, ReqReq, SpeakOff, MaxTeori, InterOn, LongFormOn,
  MaxExtras,
  gNIC,gAnnotator,gSource,gInfo,gEventDate,gEventSponsor,gSection,gStage,gBoard,
  gOpening,gVariation,gSubVariation,gECO,gTime,gWhiteCountry,gBlackCountry,
  STR30,
  gEvent,gSite,gDate,gRound,gWhite,gBlack,gResult,gPosition,
  gWhiteTitle,gBlackTitle,gWhiteElo,gBlackElo,gWhiteUSCF,gBlackUSCF,
  gExtras,gLabels,gFilters,
  LL,LLP, STR97,Name20,path20,
  NoSpeakTask, NoAutoPGN, LotMemOn, MouthOff, Quick, Later2, Later,
  path20ud,Name20ud,VariantTil, Name30, path30,
  FLAGARR,gIC,LLSIZE,gFlags,gInverse,Lates1,Lates2,Lates3,NoLocale
;

FROM SkakScreen IMPORT
  InitGW, ReDraw, Refresh, SetOpNed, GetToggle, SetToggle, GetText, RG,
  GetTextPGN, ListPick, Config,
  kHome,kEnd ,kPgUp,kPgDn,kHelp,kUp  ,kDn  ,kRt  ,kLt  ,kUpN ,kDnN ,kRtN ,
  kLtN ,kF1  ,kF2  ,kF3  ,kF4  ,kF5  ,kF6  ,kF7  ,kF8  ,kF9  ,kF0  ,kCr  ,
  kCrN ,kNumL,kScrL,kSyRq,kPrSc,kEsc, MOVEINFOSTRING, SavePalette,
  SetGad,SetGadImage, TIMEINFOSTRING, VARIINFOSTRING,
  ttINTERNATIONAL,ttLONGFORMWRITE,ttMOUTHOFF,ttLOTMEMON,ttNOAUTOPGN,ttQUICK
;
FROM SkakBrain IMPORT
  DoMove, GetNext, Mirror, DoMoveC, DoMoveOk, Equal, still, FindTrk, 
  TRAEKDATA, TRKDATA, stVsum, Push, stilling,
  Spil, SPIL, start, STRING, STIL, MaxHalvTraek, GetMoveNr, MOVETYPES,
  ATTRTYPES, ATTRTYPE,
  GameStartSeconds, GameStartMicros, MoveStartSeconds, MoveStartMicros;

FROM SkakSprog IMPORT
  Txr,Txt,Txs,Txl,Txd,Txm,Txk,Txe,Txb,TxR,TxT,TxS,TxL,TxD,TxM,TxK,TxE,TxB,
  TxrI,TxtI,TxsI,TxlI,TxdI,TxmI,TxkI,TxeI,TxbI,TxRI, TxTI,TxSI,TxLI,TxDI,TxMI,
  TxKI,TxEI,TxBI,
  TxFILTERDROPHENT,TxOK,TxMID,TxUPS,TxSti,TxNavn,TxUdvalgt,TxOKAY,TxSKAKMAT,
  TxHVIDVANDT,TxSORTVANDT,TxREMIS,TxHUMM,TxAHA,TxHVIDSTUR,TxSORTSTUR,TxNAAH,
  TxENPASSANT,TxROKADE,TxPATREMIS,TxHAPS,TxSKAK,TxDENKANIKKERYKKES,TxGODDAG,
  TxForkertTegnIStilling,Fxs01,Fxs02,Fxs03,Fxs04,Fxs05,Fxs06,Fxs07,Fxs08,Fxs09,
  Fxs10,Fxs11,Fxs12,Fxs13,Fxs14,Fxs15,Fxs16,Fxs17,Fxs18,TxGEMSPIL,TxSKRIVSPIL,
  TxIKKEGEMT,TxIKKEUDSKREVET,TxHENTSPIL,TxLAESSPIL,TxSPILIKKETEKST,TxLINIE,
  TxPOSITION,TxHALVTRAEK,TxIKKEHENTET,TxIKKESKAKFIL,TxIKKESKAKTXT,
  TxUKORREKTKUNDELVIS,TxSKAKSPISEBMREV,TxDUVALGTEAT,TxFORLIDTRAMDROPTEKST,Ax01,
  Ax02,Ax03,Ax04,Ax05,Ax06,Ax07,Ax08,Ax09,Ax10,Ax11,Ax12,Ax13,Ax14,  
  Ax15,Ax16,Ax17,TxKONTROLADVARSEL,TxSTOP,DemoMessage,Q,HelpSt, AddHelp,
  Qnomoregamesinpig,Qgetfirstgameinpig,Qappendgametopig,TAGo,Qkeyshelp,
  Q211,Q212,Q213,Qwantmemory, DoubleSelect,Rev,InitSprog,MaxTxts,
  LAERSKAK,PIECES
;

FROM SkakFil IMPORT
  ERRSTR,AdjDiskOn,DiskOn,path,ptho,FilErr,LP,GetStilling,HentF,
  SetPGNinfos,
  FilBufferSzRead, FilBufferSzWrite,FilBufferSzBig, pgnWIN, remWIN, hlpWIN,
  rettetREM,rettetPGN,rettetSPIL,RydSpil,NoPGNinfos,
  PTRrestore, PTRnormal, PTRgribe, PTRgrebet, PTRsove, PTRtale,
  simpleFileRequester2, name, dir, wptr, HelpNr, GemF, TmpFil,
  STILLINGtoFEN, FENtoSTILLING, teoWIN
;

FROM Skak20Fil IMPORT
  Save20, Load20, Append20, Mark20, LL20, Mark20init, Mark20close,
  Mark20body, Save20init, Save20body, Save20close,
  Load20init, Load20body, Load20close
;

FROM SkakKey IMPORT 
  GetOpeningKeys, OpenSetWin, setWIN, OpenTeoWin, SetFirst, TeoFirst,
  Dominans, Select, CalcMunde, MarkMoves, Mund, DominansOn;

FROM SkakTeori IMPORT
  SetDrawWhite,SetDrawBlack,GetDrawWhite,GetDrawBlack,ClrTeori,LoadTeori,
  SaveTeori,AddGame,FindPosition,DeletePosMove, ReCalc, VluToStr, StrToVlu,
  Teori,Variant,setudgangsstilling;

TYPE
  STR97PTR=POINTER TO STR97;

CONST
  SkakAltModCompilation="117";

(*$ IF Demo *)
  dqo='S';
  dqp='h'; dqu='a'; dqz='e';
  dqq='a'; dqv='r'; dq1='r';
  dqr='r'; dqw='e'; dq2='.';
  dqs='e'; dqx=' '; dq3=' ';
  dqt='w'; dqy='V'; dq4=' ';
(*$ ELSE *)

  eqf=' '; eqk='e'; eqp=' '; equ='E'; eqz='.';
  eqg='S'; eql='w'; eqq='('; eqv='.'; eq1=' ';
  eqh='h'; eqm='a'; eqr='c'; eqw='B'; eq2='D';
  eqi='a'; eqn='r'; eqs=')'; eqx='.'; eq3='e';
  eqj='r'; eqo='e'; eqt=' '; eqy='M'; eq4='n';
(*
  eqf=' '; eqk='a'; eqp='c'; equ='e'; eqz=' ';
  eqg='T'; eql='s'; eqq='h'; eqv='l'; eq1=' ';
  eqh='h'; eqm=' '; eqr=' '; eqw='s'; eq2=' ';
  eqi='o'; eqn='B'; eqs='N'; eqx='e'; eq3=' ';
  eqj='m'; eqo='a'; eqt='i'; eqy='n'; eq4=' ';

  eqf=' '; eqk=' '; eqp='i'; equ='n'; eqz='D';
  eqg='H'; eql='H'; eqq='k'; eqv='s'; eq1='r';
  eqh='a'; eqm='e'; eqr=' '; eqw='e'; eq2='.';
  eqi='n'; eqn='n'; eqs='H'; eqx='n'; eq3=' ';
  eqj='s'; eqo='r'; eqt='a'; eqy=' '; eq4=' ';
*)
(*
  eqf=' '; eqk='r'; eqp='s'; equ='H'; eqz='n';
  eqg='P'; eql=' '; eqq='s'; eqv='e'; eq1='g';
  eqh='e'; eqm='N'; eqr='o'; eqw='l'; eq2='b';
  eqi='t'; eqn='i'; eqs='n'; eqx='s'; eq3='.';
  eqj='e'; eqo='l'; eqt=' '; eqy='i'; eq4=' ';
*)
(*$ ENDIF *)

(* KOMPILEKÆDEN: (en rekompile af en .def kræver rekompile af alle før i kæden) 

SkakGo--->Skak------>SkakScreen---------------->SkakData------>SkakData2
 2k        81k  \      35k                  \     132k            83k
                 \                           \                 
                  -->Skak20Fil--SkakFil-------->SkakSprog----->SkakBase
                       54k        38k    \         23k     /     2k
                                          \               /        
                                           ---->SkakBrain-
                                                   47k
Amiga Libs:
               ExecD,ExecL
               DosD,DosL
               GraphicsD,GraphicsL
               IconL
               IntuitionD,IntuitionL
               WorkbenchD

Modula2 Libs:
               SYSTEM
               ARTS
               Heap
               String
               Conversions
               FileSystem
               Arguments

Egne libs:
               Req
               ReqSupport
               PointerSprites
               NarratorSupport
               ExecSupport
               Requester
               W,WRITE
               QuickIntuition
               VersionLog
*)

CONST       
                     (* RevDate + Version i SkakSprog.mod *)   

(*$ IF Demo *) (* 7+24 Lang *)
  qa='S'; qf='w'; qk=' '; qp=dqp; qu=dqu; qz=dqz; q5='-';
  qb='h'; qg='a'; ql=' '; qq=dqq; qv=dqv; q1=dq1;
  qc='a'; qh='r'; qm=':'; qr=dqr; qw=dqw; q2=dq2;
  qd='r'; qi='e'; qn=' '; qs=dqs; qx=dqx; q3=dq3;
  qe='e'; qj=' '; qo=dqo; qt=dqt; qy=dqy; q4=dq4;
  DemoMax=160; (* også defineret i Skak.mod *)
(*$ ELSE *)
  qa='U'; qf=eqf; qk=eqk; qp=eqp; qu=equ; qz=eqz; q5='-';
  qb='s'; qg=eqg; ql=eql; qq=eqq; qv=eqv; q1=eq1;
  qc='e'; qh=eqh; qm=eqm; qr=eqr; qw=eqw; q2=eq2;
  qd='r'; qi=eqi; qn=eqn; qs=eqs; qx=eqx; q3=eq3;
  qe=':'; qj=eqj; qo=eqo; qt=eqt; qy=eqy; q4=eq4;
(*$ ENDIF *)
  BrugerC=qa+qb+qc+qd+qe+qf+qg+qh+qi+qj+qk+ql+qm+qn+qo+qp+qq+qr+qs+qt+qu+qv+qw+qx+qy+qz+q1+q2+q3+q4+q5;

(*$IF Test *)
VAR
  more:CARDINAL;
  moreS:ARRAY[0..9] OF CHAR;

PROCEDURE d(n:INTEGER);
BEGIN
  IF FALSE & (more>20) THEN
    more:=0;
    IF moreS[0]<>' ' THEN
      WRITE(s('<more> space to unmore '));
      READs(moreS);
    END;
  END;
  INC(more);
  WRITELN(n);
END d;
(*$ENDIF *)

(*       $ RangeChk:=FALSE OverflowChk:=FALSE StackChk:=FALSE ReturnChk:=FALSE *)

(* sæt en stilling op st[0..63] = stilling, st[64]= 'H' | 'S' *)
(* st='' for udgangsstilling *)

(* PROCEDURE EmptyMsg; FORWARD;*)



(*         $ POP RangeChk POP OverflowChk POP StackChk POP ReturnChk *)

VAR
  remFirst:BOOLEAN;

PROCEDURE Draw;
VAR
  xp,yp:INTEGER;
BEGIN
  (*$IF Test0 *)
    d(s('Draw'));
  (*$ENDIF *)
  ReDraw(stilling,Dominans,Mund,Select);
  IF Tx & (SetUpMode<>1) THEN
    IF (Spil^[TraekNr].Tekst<>NIL) THEN
      Tx:=FALSE;
      remWIN.Tekst:=ADDRESS(Spil^[TraekNr].Tekst);
      IF remFirst THEN
        remFirst:=FALSE;
        xp:=800;
        yp:=4;
      ELSE
        xp:=-1;
        yp:=-1;
      END;
      IF remWIN.Window<>NIL THEN
        CLOSEWIN(remWIN);
      END;
      OPENWIN(remWIN,ADR(''),80,30, -1,-1, xp,yp, -1,-1, FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);
(*
      IF SimpleWIN(ADDRESS(Spil^[TraekNr].Tekst))=1 THEN END;
*)
    ELSE
      CLOSEWIN(remWIN); 
    END;
  END;
END Draw;

(*  PHONEMES :     expanded version of the ARPAbet
    VOWELS       : IY, EH, AA, AO, ER, AX, IH, AE, UH, OH, IX
    DIPTHONGS    : EY, OY, OW, AY, AW, UW
    CONSONANTS   :  R,  W,  M, NX,  S,  F,  Z, CH, /H,  B,  D,  K,  L,
                    Y,  N, SH, TH, ZH, DH, WH,  J, /C,  P,  T,  G
    SPECIAL      : DX=TONGUE FLAP, Q=GLOTTAL STOP, QX=SILENT VOWEL
    CONTRACTIONS : UL=AXL, IL=IXL, UM=AXM, IM=IXM, UN=AXN, IN=IXN
    PUNCTATION   : . ? - , ( )
    DIGITS       : SYLLABIC STRESS 1-9 = SECONDARY to EMPHATIC

    ord :               PHONETIC :

    HVID, HVIDS         VIY4DH | VIYD, VIY9DHS
    SORT, SORTS         SOH2AXT, SOH2AXTS
    SKAK OG MAT         SKAX6K, OW, MAX6T.
    PAT                 PAET
    REMIS               REHMIX1
    REMIS?              REHMIX9
    ER                  AE3 | AER
    TUR                 TUW2AX
    GODDAG MED DIG      GUHDAE1, MEHD DAY.
    VANDT               VAENDT.
    DEN KAN IKKE RYKKES DEH9N, KAXN, EH9KEH, RERKEHS.
*)

VAR
  Running:BOOLEAN; (* Globale Data for Multitasking Say *)
  pTps:ProcessId;
  bpSB:BPTR;
  str:ARRAY[0..99] OF CHAR;
  pMess:MessagePtr;
  Mess:Message;
  pMp,pSp:MsgPortPtr;
  FilInd,FilUd:FileHandlePtr;
  dr:LONGINT;

PROCEDURE Run(stp:ADDRESS):LONGINT;
BEGIN
  IF wbStarted THEN
    FilInd:=NIL;
    FilUd:=Output();
  ELSE
    FilInd:=NIL;
    FilUd:=NIL;
  END;   
  RETURN(Execute(stp,FilInd,FilUd));
END Run;

PROCEDURE InitSay;
VAR
  n:INTEGER;
PROCEDURE FindP(Retrys:INTEGER);
BEGIN
  IF ~SpeakOff THEN
    n:=1;
    REPEAT
      (*$IF Test0 *)
        d(s('FindPort(Speaker)'));
      (*$ENDIF *)
      pMp:=FindPort(ADR('Speaker'));
      IF pMp=NIL THEN
      END;
      INC(n);
    UNTIL (pMp<>NIL) OR (n>Retrys);
  END;
END FindP;
BEGIN
  (*$IF Test0 *)
    d(s('InitSay'));
  (*$ENDIF *)
  pMp:=NIL;
  IF ~NoSpeakTask THEN
    FindP(2);
  
    IF pMp=NIL THEN
      (* !!!!!!!!!!!!!! stopper til tider ved forsøg på run af speaker !!!! *) 
      (*$IF Test0 *)
        d(s('run Speaker:'));
      (*$ENDIF *)
      dr:=Run(ADR('run Speaker'));
      (*$IF Test0 *)
        d(s('Result=')+l(dr));
      (*$ENDIF *)
      FindP(10);
    END;
  END;

  IF pMp<>NIL THEN
    (*$IF Test0 *)
      d(s('pSpCreate:'));
    (*$ENDIF *)
    pSp:=CreatePort(ADR("svar"),0);     (* svarport *)
    IF pSp=NIL THEN
      pMp:=NIL;
    END;
  ELSE
    pSp:=NIL;
  END;
  Mess.length:=0;
  Mess.replyPort:=pSp;
  Mess.node.name:=ADR(str);
  Running:=FALSE;
END InitSay;

PROCEDURE StartSay():INTEGER;
BEGIN
  IF pMp=NIL THEN
    SetPtr(wptr,PTRtale);
    IF Say(ADR(str),Length(str))=0 THEN END;
    SetPtr(wptr,PTRrestore);
  ELSE
    PutMsg(pMp,ADR(Mess));
    Running:=TRUE;
  END;
  RETURN(0);
END StartSay;
    
PROCEDURE Sig(st:ARRAY OF CHAR);
VAR
  n:INTEGER;
  error:LONGINT;
BEGIN
  (*$IF Test0 *)
    d(s('Sig'));
  (*$ENDIF *)
  IF LydTil THEN
    IF Running THEN
      IF GetMsg(pSp)=NIL THEN
        SetPtr(wptr,PTRtale);
        WaitPort(pSp);
        SetPtr(wptr,PTRrestore);
      END;
      pMess:=GetMsg(pSp);
      Running:=FALSE;
    END;
    IF ~Running THEN
      n:=0;
      WHILE (n<=HIGH(st)) AND (n<99) DO
        str[n]:=st[n];
        INC(n);
      END;
      str[n]:=0C;
      error:=StartSay();
      IF error<>0 THEN
        LydTil:=FALSE;
      END;
  (*$IF Test0 *)
        d(s('Say: ')+s(str));
  (*$ENDIF *)
    END;
  END;
END Sig;

PROCEDURE StoreStilling(fra,til:INTEGER);
BEGIN
  (*$IF Test0 *)
    d(s('StoreStilling'));
  (*$ENDIF *)
  WITH Spil^[TraekNr] DO
    Fra:=fra;
    Til:=til;
  END;
  IF TraekNr=0 THEN
    IF DominansOn THEN start.DomOn:=1 ELSE start.DomOn:=0; END;
    start.StyOv:=StyO;
    start.StyUn:=StyU;
    start.Still:=stilling;
  END;
END StoreStilling;

PROCEDURE FullRefresh;
VAR
  ch:CHAR;
BEGIN
  (* Sæt flag, der giver fuld refresh *)
  ch:=stilling[10]; 
  stilling[10]:='*';
  Refresh(stilling,Dominans,Mund,Select); 
  stilling[10]:=ch;
END FullRefresh;

PROCEDURE Udgang;
BEGIN
  (*$IF Test0 *)
    d(s("Udgang"));
  (*$ENDIF *)
  HelpNr:=24;
  still(stilling,'');
  CalcMunde; (* and/or Dominans (only if ~MouthOff/DominansOn) *)
  Draw;
END Udgang;

(* 0=BOTH 1=NIC 2=ECO *)
PROCEDURE CatGame(type:INTEGER; Auto:BOOLEAN);
CONST
  ECOname='ECO-KEYS.PIG';
  NICname='NIC-KEYS.PIG';
VAR
  flgs,finv:FLAGARR;
  ic  :STR30;
  llstore:ADDRESS;
  llszstore,llpstore:LONGINT;
  pathstore:STR97;
  st:ARRAY[0..200] OF CHAR;
  n,res:INTEGER;
PROCEDURE Get(eco:BOOLEAN);
BEGIN
  IF eco THEN
    Concat(st,ECOname);
    path20:=ECOname;
  ELSE
    Concat(st,NICname);
    path20:=NICname;
  END;
  ConcatChar(st,' ');
  res:=LL20(NIL);
  CASE res OF
  | -8..-4: Concat(st,Q[300+res]^);
            IF res=-4 THEN
              IF eco THEN
                Concat(st,gExtras[gECO]);
              ELSE
                Concat(st,gExtras[gNIC]);
              END;
            END;
  ELSE
    Copy(st,Q[312]^);
  END;
  ConcatChar(st,'\n');
END Get;
BEGIN
  SetPtr(wptr,PTRsove);
  PigPigMode:=type;

(*$ IF Demo *)
  IF SimpleWIN(ADDRESS(Q[DemoMessage]))=0 THEN END;
(*$ ENDIF *)

  (* Push filter,liste *)
  flgs:=gFlags;
  finv:=gInverse;
  ic:=gExtras[gIC];
  llszstore:=LLSIZE;
  llstore:=LL;
  llpstore:=LLP;
  Copy(pathstore,path20);

  (* set filter, liste *)
  FOR n:=gEvent TO MaxExtras DO
    gFlags[n]:=FALSE;
    gInverse[n]:=FALSE;
  END;
  gExtras[gIC]:='0';
  gFlags[gIC]:=TRUE;
  LLSIZE:=256;
  LL:=NIL;
  Later:=9; (* sets LL20 to skip cache use *)

  Copy(st,Q[297]^);
  IF type<>2 THEN Get(FALSE) END;
  IF type<>1 THEN Get(TRUE) END;

  IF ~Auto & (SimpleWIN(ADR(st))=1) THEN END;

  (* Pop liste, filter *)
  Later:=0;
  Copy(path20,pathstore);
  LLP:=llpstore;
  LL:=llstore;
  LLSIZE:=llszstore;
  gExtras[gIC]:=ic;
  gInverse:=finv;
  gFlags:=flgs;

  SetPtr(wptr,PTRrestore);
END CatGame;

(*PROCEDURE MVINFO(LastFra,LastTil:CHAR); FORWARD;
  PROCEDURE Flyt(gnr:CARDINAL); FORWARD;*)

VAR
  VarTraekNr,VarMaxTraek  :INTEGER;
  VarSpilPtr              :POINTER TO SPIL;
  Varstilling,VarStart    :STILLINGTYPE;

PROCEDURE ToNormal;
VAR
  n:INTEGER;
BEGIN
(*$IF Test0 *)
  WRITELN(s('ToNormal'));
(*$ENDIF *)
  IF VariantTil THEN
    VariantTil:=FALSE;
    SetToggle(233,TRUE);
    SetGadImage(231,FALSE,132);
    (*SetGad(235,FALSE);*)
    CLOSEWIN(remWIN); 
    FOR n:=0 TO MaxTraek DO
      IF Spil^[n].Tekst<>NIL THEN
(*$IF Test0 *)
  WRITELN(s('ToNormal:Dealloc ')+l(n));
(*$ENDIF *)
        Deallocate(Spil^[n].Tekst);
      END;
    END;
    TraekNr    := VarTraekNr;
    MaxTraek   := VarMaxTraek;
    Spil^       := VarSpilPtr^;
    stilling   := Varstilling;
    start.Still:= VarStart;
    IF (Spil^[TraekNr].Tekst<>NIL) THEN
      Tx:=TRUE;
    END;
    CalcMunde;  (* and/or Dominans (only if ~MouthOff/DominansOn) *)
    MVINFO(' ','-');
    Draw;
    IF ~LotMemOn THEN
      Deallocate(VarSpilPtr);
    END;
  END;
END ToNormal;

(* 235 max analyze to the game
PROCEDURE ToStil;
VAR
  n:INTEGER;
  st:ARRAY[0..256] OF CHAR;
  OK:BOOLEAN;
BEGIN
  HelpNr:=263;
  IF VariantTil THEN
    IF rettetSPIL THEN
      Copy(st,Q[Q214]^);
      Concat(st,Q[Q217]^);
      Concat(st,Q[Q218]^);
      OK:=TwoGadWIN(ADR(st))=1;
    ELSE
      OK:=TRUE;
    END;
    IF OK THEN
      FOR n:=VarTraekNr+1 TO VarMaxTraek DO
        IF VarSpilPtr^[n].Tekst<>NIL THEN
          Deallocate(VarSpilPtr^[n].Tekst);
        END;
      END;
      VarSpilPtr^:=Spil^;
      VarTraekNr:=TraekNr;
      VarMaxTraek:=MaxTraek;
      Varstilling:=stilling;
      ToNormal;
    END;
  END;
END ToStil;
*)

PROCEDURE VariantTgl; (* 233 start/stop analyze *)
VAR
  n,ofs:INTEGER;
  Fil:File;
  sp:STRINGPTR;
  VarDiskOn,COMPARE,ERROR,IFSFR2,WROK,Tx0,Tx1:BOOLEAN;
  sta:STIL;
BEGIN 
(*$IF Test0 *)
  WRITELN(s('VariantTgl'));
(*$ENDIF *)
  HelpNr:=262;
  IF VarSpilPtr=NIL THEN
    Allocate(VarSpilPtr,SIZE(SPIL));
  END;
  IF VarSpilPtr<>NIL THEN
    VariantTil:=GetToggle(233);
    IF VariantTil THEN
(*$IF Test0 *)
  WRITELN(s('ToVariantTgl'));
(*$ENDIF *)
      (*SetGad(235,TRUE);*)
      SetGadImage(231,FALSE,131);

      (* Flyt Til Var#? *)
      VarTraekNr:=TraekNr;
      VarMaxTraek:=MaxTraek;
      VarSpilPtr^:=Spil^;
      FOR n:=0 TO MaxTraek DO
        Spil^[n].Tekst:=NIL;
      END;
      Varstilling:=stilling;
      VarStart:=start.Still;

      (* Sæt variant *)
      IF TraekNr>0 THEN
        Flyt(69);
      END;
      start.Still:=stilling;
      TraekNr:=0;
      MaxTraek:=0;

      Tx0:=~(VarSpilPtr^[VarTraekNr].Tekst=NIL);
      IF Tx0 THEN
        ofs:=0;
      ELSE
        ofs:=1;
      END;
      Tx1:=(VarTraekNr>0) & ~(VarSpilPtr^[VarTraekNr-1].Tekst=NIL);

(*$IF Test0 *)
  WRITELN(s('ofs=')+l(ofs)+s(' Tx1=')+b(Tx1));
(*$ENDIF *)
      IF Tx0 OR Tx1 THEN
        VarDiskOn:=DiskOn;
        DiskOn:=FALSE;

        (* Gem Rem til fil *)
        ptho:=path;
        path:=TmpFil;
(*
        ConcatChar(path,'s');
*)
        REPEAT
(*$IF Test0 *)
  WRITELN(s('ToVariant:Gem ')+s(VarSpilPtr^[VarTraekNr-ofs].Tekst^)+s(' til ')+s(path));
(*$ENDIF *)
          Lookup(Fil,path,256,TRUE);
          WROK:=(Fil.res=done);
          IF WROK THEN
            FOR n:=0 TO Length(VarSpilPtr^[VarTraekNr-ofs].Tekst^) DO
              WriteChar(Fil,VarSpilPtr^[VarTraekNr-ofs].Tekst^[n]);
            END;
            Close(Fil);
  
            (* Læs Variant fra fil *)
            Lookup(Fil,path,256,FALSE);
            IFSFR2:=(Fil.res=done);
            IF IFSFR2 THEN
(*$IF Test0 *)
  WRITELN(s('ToVariant, HentF'));
(*$ENDIF *)
              HentF(Fil,CFraLine,COMPARE,ERROR,IFSFR2,sta,TRUE);
            END;
            FileSystem.Delete(Fil);
            Close(Fil);
          END;
          INC(ofs);
(*$IF Test0 *)
  WRITELN(s('ofs=')+l(ofs)+s(' Tx1=')+b(Tx1));
(*$ENDIF *)
        UNTIL ~Tx1 OR (ofs>1) OR ~WROK OR IFSFR2 & ~ERROR;
  
        DiskOn:=VarDiskOn;
        path:=ptho;
      END;

      Tx:=TRUE;
      IF MaxTraek>0 THEN
        Flyt(71);
      ELSE
        CalcMunde;  (* and/or Dominans (only if ~MouthOff/DominansOn) *)
        MVINFO(' ','-');
        Draw;
      END;

    ELSE
      VariantTil:=TRUE; (* for at ku blive FALSE i ToNormal *)
      ToNormal;
    END;
  ELSE
    SetGad(233,FALSE);
    IF SimpleWIN(ADDRESS(Q[Qwantmemory]))=1 THEN END;
 END;
END VariantTgl;

(*PROCEDURE Comments; FORWARD;*)

PROCEDURE ToA; (* 231 save variant as comment and stop analyze else call comment *)
VAR
  VarDiskOn:BOOLEAN;
  Fil:File;
  st:STRING;
  ch:CHAR;
BEGIN 
(*$IF Test0 *)
  WRITELN(s('ToA'));
(*$ENDIF *)
  IF VariantTil THEN
    HelpNr:=264;
    VarDiskOn:=DiskOn;
    DiskOn:=FALSE;
    (* Variant to Comment *)
    ptho:=path;
    path:=TmpFil;
(*$IF Test0 *)
  WRITELN(s('ToA. path=')+s(path));
(*$ENDIF *)
    IF (MaxTraek>0) THEN
      Later2:=VarTraekNr;
      IF Later2>0 THEN
        DEC(Later2);
      END;
      IF GemF('S',DominansOn,TRUE) THEN
(*$IF Test0 *)
  WRITELN(s('ToA..'));
(*$ENDIF *)
        Lookup(Fil,path,256,FALSE);
        IF Fil.res=done THEN
(*$IF Test0 *)
  WRITELN(s('ToA...'));
(*$ENDIF *)
          IF VarSpilPtr^[VarTraekNr].Tekst<>NIL THEN
            Copy(st,VarSpilPtr^[VarTraekNr].Tekst^);
            Deallocate(VarSpilPtr^[VarTraekNr].Tekst);
          ELSE
            st[0]:=0C;
          END;
          REPEAT
            ReadChar(Fil,ch);
            ConcatChar(st,ch);
          UNTIL Fil.eof OR (Fil.res<>done);
          FileSystem.Delete(Fil); (* !!!!!!!!!!!!!!!!!! *)
          Close(Fil);
          IF st[0]<>0C THEN
            Allocate(VarSpilPtr^[VarTraekNr].Tekst,Length(st)+2);
            IF VarSpilPtr^[VarTraekNr].Tekst<>NIL THEN
              Copy(VarSpilPtr^[VarTraekNr].Tekst^,st);
            END;
          END;
        END;
      END;
    END;
    path:=ptho;
    DiskOn:=VarDiskOn;
    ToNormal;
  ELSE
    Comments;
  END;
END ToA;

PROCEDURE Gem(Auto:BOOLEAN):BOOLEAN;
VAR
  OK:BOOLEAN;
BEGIN
  ToNormal;
  OK:=GemF(LongFormOn,DominansOn,Auto);
(*$IF Test0 *)
  WRITELN(s('Gem=')+b(OK));
(*$ENDIF *)
  IF ~Auto THEN
    IF Simple THEN
      FullRefresh;
    END;
    EmptyMsg;
  END;
  RETURN(OK);
END Gem;

PROCEDURE Gem20(Auto,KeepOpen,Open:BOOLEAN):BOOLEAN;
VAR
  Title:ARRAY[0..40] OF CHAR;
  OK:BOOLEAN;
BEGIN
  HelpNr:=277;
  ToNormal;
  IF ~Auto THEN
    Copy(Title,Q[Qappendgametopig]^);
    OK:=simpleFileRequester2(Title,Name20,path20,dir20);
  ELSE
    OK:=TRUE;
  END;
  IF OK THEN
    SetPtr(wptr,PTRsove);
    IF KeepOpen THEN
      IF Open THEN
        Save20init(path20);
      END;
      OK:=Save20body(Auto);
    ELSE
      OK:=Save20(path20,Auto);
    END;
    SetPtr(wptr,PTRrestore);
  END;
  RETURN(OK);
END Gem20;

VAR
  pgnFirst:BOOLEAN;

PROCEDURE PGNcomments;
VAR
  Res,lngth:CARDINAL;
  n,m:INTEGER;
  st0:ARRAY[0..16] OF CHAR;
  st1:ARRAY[0..3000] OF CHAR;
  st2:HelpSt;
  Last:BOOLEAN;
  xp,yp:INTEGER;
PROCEDURE ConcatF(VAR st:ARRAY OF CHAR; st2:ARRAY OF CHAR);
CONST
  FormSize=14;
VAR
  x:CARDINAL;
BEGIN
  FOR x:=Length(st2) TO FormSize-1 DO
    st2[x]:=' '
  END;
  st2[FormSize]:=0C;
  Concat(st,st2);
END ConcatF;
BEGIN
  HelpNr:=281;
  IF ~NoPGNinfos() THEN

(*  
  SetPtr(wptr,PTRsove);
*)
  (*
    st1:='PGN TAGS:';
  *)
    st1:='';
    lngth:=7;
    FOR n:=-12 TO MaxExtras DO
      IF gExtras[n,0]<>0C THEN
        IF (n=-12) OR Last & ((n=gBlackTitle) OR (n=gBlackElo) OR (n=gBlackUSCF)
        OR (n=gBoard) OR (n=gTime) OR (n=gBlackCountry)) THEN
          Concat(st1,' ');
          FOR m:=lngth TO 6 DO
            ConcatChar(st1,' ');
          END;
        ELSE
          Concat(st1,'\n ');
        END;
        ConcatF(st1,Q[n+TAGo]^);
        Concat(st1,gExtras[n]);
        lngth:=Length(gExtras[n]);
        Last:=TRUE;
      ELSE
        Last:=FALSE;
      END;
    END;

    pgnWIN.Tekst:=ADR(st1);
    IF pgnFirst THEN
      pgnFirst:=FALSE;
      xp:=280;
      yp:=100;
    ELSE
      xp:=-1;
      yp:=-1;
    END;
    CLOSEWIN(pgnWIN);
    OPENWIN(pgnWIN,ADR(''), 80,30, -1,-1, xp,yp, -1,-1,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);
(*                           Min    Max    Pos    Scr   Act   Mou   Cen  Key  Raw   SzGd
    Res:=SimpleWIN(ADR(st1));
    SetPtr(wptr,PTRrestore);
*)
    IF Simple THEN
      FullRefresh;
    END;
    EmptyMsg;

  END;
END PGNcomments;

PROCEDURE SetKeys;
VAR
  ec,ni:BOOLEAN;
  eco,nic:ARRAY[0..3] OF CHAR;
BEGIN
(*$IF Test0 *)
  WRITELN(s('SetKeys'));
(*$ENDIF *)
  IF ~VariantTil THEN
(*$IF Test0 *)
  WRITELN(s('SetKeys.do'));
(*$ENDIF *)
    ec:=Length(gExtras[gECO])<3;
    ni:=Length(gExtras[gNIC])<3;
    IF ec OR ni THEN
      GetOpeningKeys(eco,nic);
      IF ec THEN
        Copy(gExtras[gECO],eco);
      END;
      IF ni THEN
        Copy(gExtras[gNIC],nic);
      END;
      IF pgnWIN.Window<>NIL THEN
        CLOSEWIN(pgnWIN);
        PGNcomments;
      END;
    END;
  END;
END SetKeys;

VAR
  NxtAdr:LONGINT;
  CurAdr:LONGINT;

PROCEDURE Marker20(Slettet:SHORTINT);
BEGIN
  IF Slettet=1 THEN
    HelpNr:=288;
  ELSE
    HelpNr:=289;
  END;
  SetPtr(wptr,PTRsove);
  Mark20(path20,CurAdr,Slettet);
  SetPtr(wptr,PTRrestore);
END Marker20;

PROCEDURE ToggleMarked;
VAR
  nadr:LONGINT;
  slt:SHORTINT;
BEGIN
  (* Delete marked *)
  IF Mark20init(path20) THEN
    FOR nadr:=1 TO LLP DO
      IF LL^[nadr].Attr<>0 THEN
        slt:=-1;
(*$IF Test0 *)
  WRITELN(s('Slet, nr=')+l(nadr)+s('LL^[nr].Adrs=')+l(LL^[nadr].Adrs));
(*$ENDIF *)
        Mark20body(LL^[nadr].Adrs,slt);
        IF (LL^[nadr].Text<>NIL) THEN
          IF LL^[nadr].Text^[0]='X' THEN
            LL^[nadr].Text^[0]:=' '         
          ELSE
            LL^[nadr].Text^[0]:='X';
          END;
        END;
      ELSE
(*$IF Test0 *)
  WRITELN(s('SKIP, nr=')+l(nadr)+s('LL^[nr].Adrs=')+l(LL^[nadr].Adrs));
(*$ENDIF *)
      END;
    END;
    Mark20close;
  END;
END ToggleMarked;

PROCEDURE CopyMarked;
VAR
  n,Adr,NxtAdr,ind,ud:LONGINT;
  Got,FIRST,FIRIN:BOOLEAN;
  Title:ARRAY[0..40] OF CHAR;
  OK,err,None:BOOLEAN;
  Str:ARRAY[0..200] OF CHAR;
  Str2:ARRAY[0..8] OF CHAR;
BEGIN 
  FIRST:=TRUE;
  FIRIN:=TRUE;
  None:=TRUE;
  FOR n:=1 TO LLP DO
    IF LL^[n].Attr<>0 THEN
      None:=FALSE;
      n:=LLP;
    END;
  END;
  IF None THEN
    IF SimpleWIN(ADDRESS(Q[266]))=1 THEN END;
  ELSE
    Name20ud:='';
    ind:=0;
    ud:=0;
    Copy(Title,Q[Qappendgametopig]^);
    OK:=simpleFileRequester2(Title,Name20ud,path20ud,dir20);
    IF OK THEN
      Str:='     0 ';
      Concat(Str,Q[Q213]^); (* to *)
      Concat(Str,'PIG');
      Concat(Str,Q[Q212]^); (* file: *)
      Concat(Str,'\n');
      Concat(Str,Name20ud);
      Concat(Str,'\n');
      OpenInfoWIN (ADR(Str));
      FOR n:=1 TO LLP DO
        IF LL^[n].Attr<>0 THEN
          Adr:=LL^[n].Adrs;
          IF FIRIN THEN
            OK:=Load20init(path20,FALSE);
            FIRIN:=FALSE;
          END;
          IF OK & Load20body(Adr,NxtAdr,FALSE) THEN
            INC(ind);
            IF FIRST THEN
              Save20init(path20ud);
              FIRST:=FALSE;
            END;
            IF Save20body(FALSE) THEN
              INC(ud);
              ValToStr(ud,FALSE,Str2,10,6,' ',err);
              PrintInfoWIN(0,0,ADR(Str2));
            END;
            IF MsgCloseInfoWIN() THEN n:=LLP END;
          END;
        END;
      END;
      Save20close;
      Load20close;
      CloseInfoWIN;
    END;
  END;
END CopyMarked;

PROCEDURE Hent20Nxt(Auto:BOOLEAN):BOOLEAN;
VAR
  n:LONGINT;
  Got:BOOLEAN;
BEGIN
  ToNormal;
  Got:=FALSE;
  IF DoubleSelect>-1 THEN
    n:=DoubleSelect;
    DoubleSelect:=-1;
  ELSE
    n:=1;
    WHILE (n<=LLP) & (LL^[n].Attr=0) DO
      INC(n);
    END;
  END;
  IF n<=LLP THEN
    CurAdr:=LL^[n].Adrs;
    LL^[n].Attr:=0;
    SetPtr(wptr,PTRsove);
    Got:=Load20(path20,CurAdr,NxtAdr,Auto);
    IF ~Auto THEN
      Tx:=TRUE;
      CalcMunde;  (* and/or Dominans (only if ~MouthOff/DominansOn) *)
      Valg:=0;
      Draw;
      SetPtr(wptr,PTRrestore);
      CLOSEWIN(pgnWIN);
      IF ~NoAutoPGN THEN
        PGNcomments;
      END;
    END;
  END;
  SetKeys;
  RETURN(Got);
END Hent20Nxt;

(* F2 *)
PROCEDURE Hent20Next(Auto:BOOLEAN):BOOLEAN; (* AUTO er altid FALSE!!!!? *)
VAR
  Got:BOOLEAN;
BEGIN
  HelpNr:=278;
  Got:=FALSE;
  SetPtr(wptr,PTRsove);
  IF ListPick(NIL) THEN
    IF ~Auto & (Later2=1) THEN (* Delete toggle all marked*)
      ToggleMarked;
    ELSIF ~Auto & (Later2=2) THEN (* copy all marked to a file *)
      CopyMarked;
    ELSE
      SetPtr(wptr,PTRrestore);
      Got:=Hent20Nxt(Auto);
    END;
    SetPtr(wptr,PTRgribe);
  ELSE
    SetPtr(wptr,PTRrestore);
  END;
  IF Simple THEN
    FullRefresh;
  END;
  EmptyMsg;
  RETURN(Got);
END Hent20Next;

(* F1 *)
PROCEDURE Hent20First(Auto:BOOLEAN):BOOLEAN;
VAR
  Title:ARRAY[0..40] OF CHAR;
  OK,Got:BOOLEAN;
  path20Old,dirud:STR97;
BEGIN
  HelpNr:=279;
  Got:=FALSE;
  Copy(Title,Q[Qgetfirstgameinpig]^);
  Copy(path20Old,path20);
  OK:=simpleFileRequester2(Title,Name20,path20,dir20);
  IF OK THEN
    IF Compare(path20,path20Old)<>0 THEN
      gFilters[MaxExtras,0]:=0C;
    END;
    SetPtr(wptr,PTRsove);
    IF GetTextPGN(1) THEN
      IF Later=2 THEN
        Copy(Title,Q[Qappendgametopig]^);
        Copy(dirud,dir20);
         IF ~simpleFileRequester2(Title,Name20ud,path20ud,dirud) THEN
           Later:=0;
         END;
      END;
      IF ListPick(LL20) THEN
        IF Later2=1 THEN  (* & ~Auto *)
          ToggleMarked;
        ELSIF Later2=2 THEN  (* & ~Auto *)
          CopyMarked;
        ELSE
          (* Load first marked *)
          Got:=Hent20Nxt(Auto);
          IF Got THEN CLOSEWIN(pgnWIN) END;
        END;
(*        SetPtr(wptr,PTRgribe);*)
      ELSE
(*        SetPtr(wptr,PTRrestore);*)
      END;
      Draw;
    ELSE
(*     SetPtr(wptr,PTRrestore);*)
    END;
    SetPtr(wptr,PTRrestore);
  END;
  IF Simple THEN
    FullRefresh;
  END;
  EmptyMsg;
  RETURN(Got);
END Hent20First;

PROCEDURE Kopi20;
VAR
  Title:ARRAY[0..40] OF CHAR;
  OK:BOOLEAN;
  Str:ARRAY[0..255] OF CHAR;
BEGIN
  HelpNr:=282;
  Copy(Title,Q[Qgetfirstgameinpig]^);
  OK:=simpleFileRequester2(Title,Name20,path20,dir20);
  IF OK THEN
    Name20ud:='';
    Copy(Title,Q[Qappendgametopig]^);
    OK:=simpleFileRequester2(Title,Name20ud,path20ud,dir20);
    IF OK THEN
      SetPtr(wptr,PTRsove);
(*
Str:='Appending PGN file:      \n';
*)
      Copy(Str,Q[Q211]^);
      Concat(Str,'PGN');
      Concat(Str,Q[Q212]^);     
      Concat(Str,path20);
      Concat(Str,'\n');
      Concat(Str,Q[Q213]^);
      Concat(Str,'PGN');
      Concat(Str,Q[Q212]^);
(*
Concat(Str,'\nto PGN file:\n');
*)
      Concat(Str,path20ud);
      Concat(Str,'\n\n\n\n'); 
      OpenInfoWIN(ADR(Str));
      Append20(path20,path20ud);
      CLOSEWIN(pgnWIN);
      Draw;
      Tx:=TRUE;
      CloseInfoWIN;
      SetPtr(wptr,PTRgribe);
    END;
  END;
  IF Simple THEN
    FullRefresh;
  END;
  EmptyMsg;
END Kopi20;

(**************************************************************************)


(*PROCEDURE OpNed();FORWARD;
PROCEDURE DomiFraTil(gnr:CARDINAL);FORWARD;
PROCEDURE Styrke(gnr:CARDINAL);FORWARD;
PROCEDURE Person(gnr:CARDINAL);FORWARD;
*)

(*$ EntryClear:=TRUE *)
(* axb5 see2 s3d4  *)

PROCEDURE Hent(Auto:BOOLEAN):BOOLEAN;
VAR
  SpilOld:SPIL;
  TraekNrOld,MaxTraekOld,n:INTEGER;
  CFraLineOld:LONGINT;
  stillingOld,startOld:STILLINGTYPE;
  ERROR,COMPARE,IFSFR2,OK:BOOLEAN;
  Title:ARRAY[0..40] OF CHAR;
  kar:ADDRESS; (* kommentar (for gl.) *)
  sta:STIL;
  gExtrasO:ARRAY[-12..MaxExtras] OF STR30;
PROCEDURE RestoreGame;
BEGIN
  Spil^:=SpilOld;
  TraekNr:=TraekNrOld;
  MaxTraek:=MaxTraekOld;
  stilling:=stillingOld;
  start.Still:=startOld;
  FOR n:=-12 TO MaxExtras DO 
    gExtras[n]:=gExtrasO[n];
  END;
END RestoreGame;
BEGIN (* Hent *)
  ERROR:=FALSE;
  ToNormal;
  IF RydSpil(TRUE,Auto) THEN
    SpilOld:=Spil^;
    TraekNrOld:=TraekNr;
    MaxTraekOld:=MaxTraek;
    stillingOld:=stilling;
    startOld:=start.Still;
    FOR n:=-12 TO MaxExtras DO 
      gExtrasO[n]:=gExtras[n];
    END;
(*  
  SetPGNinfos;
  CLOSEWIN(pgnWIN);
*)
    IF ~Auto THEN
      IF DiskOn THEN
        Copy(Title,Q[TxHENTSPIL]^);
      ELSE
        Copy(Title,Q[TxLAESSPIL]^);
      END;
      IFSFR2:=simpleFileRequester2(Title,name,path,dir);
    ELSE
      IFSFR2:=TRUE;
    END;
    OK:=TRUE;
    IF  ~Auto & (TraekNr>0) & ~DiskOn & (CFraLine=0) THEN 
      SetPtr(wptr,PTRsove);
      CASE ThreeGadWIN(ADDRESS(Q[TxFILTERDROPHENT])) OF
      | 0: OK:=FALSE;
      | 2: TraekNr:=0;
      ELSE
      END;
      SetPtr(wptr,PTRrestore);
    END;
    IF Auto THEN TraekNr:=0 END;
    IF IFSFR2 & OK THEN
(*$IF Test0 *)
  d(s('Au1'));
(*$ENDIF *)
      IF ~Auto THEN
        SetPtr(wptr,PTRsove);
        Lookup(hentfil,path,FilBufferSzRead,FALSE);
      END;
      (* CFilPos:=0;*)
      REPEAT
        CFraLineOld:=CFraLine;
(*$IF Test0 *)
  d(s('a:Set CFilPos=')+l(CFilPos));
  IF hentfil.res=done THEN d(s('Au1.7')) END;
(*$ENDIF *)
        HentF(hentfil,CFraLine,COMPARE,ERROR,IFSFR2,sta,Auto);
        SetKeys;
(*$IF Test0 *)
  IF COMPARE THEN d(s('Au2')) END;
  IF ERROR   THEN d(s('Au3')) END;
  IF IFSFR2  THEN d(s('Au4')) END;
(*$ENDIF *)
        IF AdjDiskOn THEN
          IF DiskOn THEN
            WITH sta DO
              IF (DomOn<>-128) & ((DomOn=0) & DominansOn OR (DomOn=1) & ~DominansOn) THEN
                DominansOn:=~DominansOn;
                SetToggle(79,DominansOn);
                (* DomiFraTil(79); *)
              END;
      
              IF (Opad<>-128) & ((Opad=0) & OpAd OR (Opad=1) & ~OpAd) THEN
                SetToggle(29,Opad=1);
                OpNed;
              END;
    
              (* StyOv/Un er altid gemt som -128,0..9 *)
              (* -128 = don't change    *)
              (*    0 = man             *)
              (*  1-9 = machine (1,4,7) *)     
              IF (StyOv<>-128) THEN 
                IF (StyOv<>StyO) THEN
                  IF StyOv=0 THEN
                    SetToggle(30,TRUE);
                    Person(30);
                  ELSE
                    IF StyO=0 THEN
                      SetToggle(30,FALSE);
                      Person(30);
                    END;
                    IF stilling[HvisTur]='H' THEN
                      StyO:=StyOv;
                    ELSE
                      StyO:=-StyOv;
                    END;
                  END;
                END;
              END;
      
              IF (StyUn<>-128) THEN
                IF (StyUn<>StyU) THEN
                  IF StyUn=0 THEN
                    SetToggle(40,TRUE);
                    Person(40);
                  ELSE
                    IF StyU=0 THEN
                      SetToggle(40,FALSE);
                      Person(40);
                    END;          
                    IF stilling[HvisTur]='S' THEN
                      StyU:=StyUn;
                    ELSE
                      StyU:=-StyUn;
                    END;
                  END;
                END;
              END;
              
            END;
          ELSE
          END; (* IF DiskOn*)
          Tx:=TRUE;
        END; (* IF AdjDiskOn*)
  
        IF ~COMPARE & (CFraLine>CFraLineOld) & ~ERROR THEN
(*$IF Test *)
  d(s('Hent: UNDO! '));
(*$ENDIF *)
          RestoreGame;
        END;
        AEM;
      UNTIL (CFraLine=0) OR COMPARE OR ERROR OR Push;
      Tx:=TRUE;
      IF ~Auto THEN
        Close(hentfil);
        SetPtr(wptr,PTRrestore);
        Valg:=0;
      END;
    ELSE (* restore *)
      RestoreGame;
    END;

    CalcMunde;  (* and/or Dominans (only if ~MouthOff/DominansOn) *)
    IF Simple THEN
      FullRefresh;
    ELSE
      Draw;
    END;
    IF DiskOn THEN
      HelpNr:=9;
    ELSE
      HelpNr:=59;
    END;
    EmptyMsg;
  END;
  RETURN(~ERROR);
END Hent;
(*$ POP EntryClear *)

VAR
  logfile : File;
  CloseNr :SHORTINT;

CONST
  INCOMPLETE = 'Incomplete! (Stopped) ';
  STOPPED    = 'Stopped by user!      ';

PROCEDURE PGNtilPIG(Auto:BOOLEAN);
VAR
  OK,ODiskOn,err,WIN,CloseWin:BOOLEAN;
  CFLO,nr:LONGINT;
  Str,cbs,pgnPath:ARRAY[0..511] OF CHAR;
  Str2:ARRAY[0..25] OF CHAR;
  Title:ARRAY[0..40] OF CHAR;
  actual:LONGINT;
  n:INTEGER;
  FilInd,FilUd:FileHandlePtr;
  dr:LONGINT;
  cb:BOOLEAN;
PROCEDURE CleanUpPGN;
BEGIN
  (* cleanup some 1-char PGN tags *)
  IF Length(gExtras[gNIC])=1 THEN gExtras[gNIC]:=''; END;
  IF Length(gExtras[gInfo])=1 THEN gExtras[gInfo]:=''; END;
  IF Length(gExtras[gSource])=1 THEN gExtras[gSource]:=''; END;
  IF Length(gExtras[gAnnotator])=1 THEN gExtras[gAnnotator]:=''; END;
  
  IF cb & (Length(gExtras[gSite])=1) THEN (* Swap Site <-> Event *)
    Copy(cbs,gExtras[gSite]);
    gExtras[gSite]:=gExtras[gEvent];
    Copy(gExtras[gEvent],cbs);
  END;
END CleanUpPGN;
BEGIN
  HelpNr:=284;
  STR97PTR(Lates1)^[0]:=0C;
  nr:=0;
  Str[0]:=0C;
  WIN:=FALSE;
  cb:=FALSE;
  ODiskOn:=DiskOn;
  DiskOn:=FALSE;
(*$IF Test0 *)
  d(s('PGNtilPIG: Hent ')+s(path));
(*$ENDIF *)
  Copy(Title,Q[TxLAESSPIL]^);
  IF Auto OR simpleFileRequester2(Title,name,path,dir) THEN
    Copy(pgnPath,path);
    n:=Length(path);
    IF (n>3) & (CAP(path[n-4])='.') & (CAP(path[n-3])='C')
             & (CAP(path[n-2])='B') & (CAP(path[n-1])='F') THEN (* ChessBase *)
      path[n-4]:=0C;
      cb:=TRUE;
      cbs:='cbascii -e ';
      Copy(pgnPath,'t:'); Concat(pgnPath,name);
      pgnPath[Length(pgnPath)-4]:=0C;
      Concat(pgnPath,'.pgn');
      Concat(cbs,pgnPath);
      ConcatChar(cbs,' ');
      Concat(cbs,path);
      Concat(cbs,'.CBF');
      (* 275='Conversion of .CBF (ChessBase gamefile) to PGN format: \n\n' *)
      Copy(Str,Q[275]^);
      Concat(Str,cbs);
      OpenInfoWIN(ADR(Str));
      dr:=Run(ADR(cbs));
      CloseInfoWIN;
(*$IF Test0 *)
  d(s('PGNtilPIG: Chessbase->pgn ')+s(cbs)+s(' dr=')+l(dr));
(*$ENDIF *)
      Concat(path,'.pgn');
    END;
    Lookup(hentfil,pgnPath,FilBufferSzRead*FilBufferSzBig,FALSE);
    IF cb & (hentfil.res<>done) THEN
      (*276='failed!
             Do you have enough free space in t: (5 times the .CBF size)?
             Do you have the cbascii conversion utility in your path?' *)
          (* !!!!! Needs: Try to assign t: to a harddisk with free space *)
      Concat(Str,Q[276]^);
      IF SimpleWIN(ADR(Str))=1 THEN END;
      Str[0]:=0C;
    ELSE
      Str[0]:=0C;
      IF Hent(TRUE) THEN
    (*$IF Test0 *)
      d(s('PGNtilPIG: Hent(TRUE)=')+s(path));
    (*$ENDIF *)
        IF ~Auto THEN CLOSEWIN(pgnWIN) END;
        CleanUpPGN;    
        IF Gem20(Auto,TRUE,TRUE) THEN
          INC(nr);
          Concat(Str,Q[267]^); (*'     1 games from PGN file:  \n\n  '*)
          Concat(Str,pgnPath);
          Concat(Str,Q[268]^); (*'  \n\nappended to PIG-BASE file:  \n\n  '*)
          Concat(Str,path20);
          Concat(Str,'  \n');
          WIN:=TRUE;
          OpenInfoWIN(ADR(Str));
          REPEAT
            CFLO:=CFraLine;
    (*$IF Test0 *)
      d(s('PGNtilPIG: Hent.path=')+s(path));
    (*$ENDIF *)
            OK:=Hent(TRUE);
            IF OK THEN
    (*$IF Test0 *)
      d(s('PGNtilPIG: Gem20.path20=')+s(path20));
    (*$ENDIF *)
              CleanUpPGN;    
              OK:=Gem20(TRUE,TRUE,FALSE);
            END;
            IF OK THEN
              INC(nr);
              ValToStr(nr,FALSE,Str2,10,6,' ',err);
              PrintInfoWIN(0,0,ADR(Str2));
    (*$IF Test0 *)
      d(s('PGNtilPIG: PGNlinie=')+l(CFraLine)+s(' spilnr=')+l(nr));
    (*$ENDIF *)
            END;
    (*$IF Test0 *)
      d(s('PGNtilPIG: OK=')+b(OK)+s(' PGNlinie=')+l(CFraLine)+s(' PGNoldLn=')+l(CFLO));
    (*$ENDIF *)
            AEM;
            CloseWin:=MsgCloseInfoWIN();
            IF Auto & CloseWin THEN
              INC(CloseNr);
              IF CloseNr=1 THEN
                CloseWin:=FALSE;
              END;
            END;
          UNTIL ~OK OR (CFraLine<=CFLO) OR Push OR CloseWin;
        END;
        Save20close;
      END;
      IF cb THEN
        FileSystem.Delete(hentfil);
      END;
      Close(hentfil);
    END;
  END;
  DiskOn:=ODiskOn;
  ValToStr(nr,FALSE,Str2,10,6,' ',err);
  FOR n:=0 TO Length(Str2)-1 DO
    Str[n]:=Str2[n];
  END;
  IF WIN THEN
    IF Auto THEN
      WriteBytes(logfile,ADR(Str),Length(Str),actual);
      WriteBytes(logfile,ADDRESS(Lates1),Length(STR97PTR(Lates1)^),actual);
      IF CloseNr>1 THEN
        WriteBytes(logfile,ADR(INCOMPLETE),Length(INCOMPLETE),actual);
      END;
      WriteChar(logfile,12C);
      WriteChar(logfile,12C);
      IF CloseNr>0 THEN
        WriteBytes(logfile,ADR(STOPPED),Length(STOPPED),actual);
      END;
    ELSE
      IF CloseWin THEN
        Concat(Str,INCOMPLETE);
        Concat(Str,'  \n');
      END;
      IF SimpleWIN(ADR(Str))=1 THEN END;
    END;
    CloseInfoWIN;
  END;
END PGNtilPIG;

PROCEDURE AutoPGNtilPIG;
CONST
  MaxFiles=512;
VAR
  minlaas : FileLockPtr;
  fibp    : FileInfoBlockPtr; (* !! Må ikke være lokalvariabel, 32-bit-align!! *)
  sa      : ARRAY[1..MaxFiles] OF ARRAY[0..32] OF CHAR;
  st      : ARRAY[0..32] OF CHAR;     (* to check for .pgn version of .cbf files *)
  ca      : ARRAY[1..MaxFiles] OF BOOLEAN; (* .cbf flag *)
  m,n,lp,m2 : CARDINAL;
  actual  : LONGINT;
  Title   : STR97;
  Pos,stl : INTEGER;
  Str     : ARRAY[0..255] OF CHAR;
  err,cac,Skip  : BOOLEAN;
BEGIN
  HelpNr:=285;
  Copy(Title,Q[271]^);
  CloseNr:=0;
  n:=0;
  Lates2:=TRUE;
  IF simpleFileRequester2(Title,name,path,dir) THEN
    minlaas:=Lock(ADR(dir),accessRead);
    IF minlaas<>NIL THEN
      Allocate(fibp,SIZE(FileInfoBlock));
      IF fibp<>NIL THEN
        IF Examine(minlaas,fibp) THEN
          REPEAT   
            IF fibp^.entryType>0 THEN
              (* Directory *)
            ELSE
              Pos:=Occurs(fibp^.fileName,1,'.PGN',FALSE);
              cac:=FALSE;
              IF Pos<Length(fibp^.fileName)-4 THEN
                Pos:=Occurs(fibp^.fileName,1,'.CBF',FALSE);
                cac:=TRUE;
              END;
              IF Pos=Length(fibp^.fileName)-4 THEN (* .PGN or .CBF *)
                IF n<MaxFiles THEN
                  INC(n);
                END;
                Copy(sa[n],fibp^.fileName);
                ca[n]:=cac;
  (*$IF Test0 *)
    d(s('AutoPGNtilPIG2 ')+s(sa[n])+s(' Pos=')+l(Pos));
  (*$ENDIF *)
              END;
            END;
          UNTIL NOT ExNext(minlaas,fibp);
          UnLock(minlaas);
        END;
        Deallocate(fibp);
      END;
    END;
    Lookup(logfile,'t:AutoPGNtoPIG.LOGFILE',512,TRUE);
    IF n>0 THEN CLOSEWIN(pgnWIN) END;
    FOR m:=1 TO n DO
      path:=dir;
      lp:=Length(path);
(*$IF Test0 *)
  d(s('AutoPGNtilPIG3 ')+s(path)+s(' lp=')+l(lp));
(*$ENDIF *)
      IF (lp>0) & (path[lp-1]<>':') & (path[lp-1]<>'/') THEN
        ConcatChar(path,'/');
      END;
      Concat(path,sa[m]);
      path20:=path;
      Concat(path20,'.PIG');
(*$IF Test0 *)
  d(s('AutoPGNtilPIG ')+s(path)+s(' -> ')+s(path20));
(*$ENDIF *)

      Skip:=FALSE;
      IF ca[m] THEN (* er .cbf fil, så check om .pgn version findes, så skip *)
        Copy(st,sa[m]);
        stl:=Length(st);
        st[stl-4]:=0C;
        m2:=1;
        WHILE ~Skip & (m2<=n) DO
          IF ~ca[m2] THEN
            IF (stl=Length(sa[m2])) THEN
              Skip:=Occurs(sa[m2],0,st,FALSE)=0;
            END;
          END;
          INC(m2);
        END;
      END;

      IF ~Skip THEN
        Copy(name,sa[m]);
        PGNtilPIG(TRUE);
        WriteChar(logfile,12C);
      END;
      IF Push OR (CloseNr>0) THEN 
        m:=n;
      END;
    END;
    Close(logfile);
  END;
  ValToStr(n,FALSE,Str,10,4,' ',err);
  Concat(Str,Q[269]^) ;
  IF n>0 THEN
    Concat(Str,Q[270]^) ;
  END;
  IF SimpleWIN(ADR(Str))=1 THEN END;
  IF Simple THEN
    FullRefresh;
  END;
  EmptyMsg;
  Lates2:=FALSE;
END AutoPGNtilPIG;

PROCEDURE PIGtilPGN;
VAR
  Ok,ODiskOn,err:BOOLEAN;
  CFLO,nr:LONGINT;
  Str:ARRAY[0..255] OF CHAR;
  Str2:ARRAY[0..16] OF CHAR;
  LFS:CHAR;
  PGN:INTEGER;
BEGIN
  LFS:=LongFormOn;
  LongFormOn:='S';
  PGN:=Lates3;
  Lates3:=1;
  HelpNr:=283;
  nr:=0;
  ODiskOn:=DiskOn;
  DiskOn:=FALSE;
  SetPtr(wptr,PTRsove);
  OK:=Hent20First(TRUE);
(*$IF Test0 *)
  WRITELN(s('Hentet20First.'));
(*$ENDIF *)
  IF OK THEN
    Ok:=Gem(FALSE);
    Copy(Str,Q[272]^) ;
    Concat(Str,path20);
    Concat(Str,Q[273]^);
    Concat(Str,path);
    Concat(Str,'  \n');
    OpenInfoWIN(ADR(Str));
  (*$IF Test0 *)
    WRITELN(s('Ok=Gem(FALSE).'));
  (*$ENDIF *)
    IF Ok THEN
      CLOSEWIN(pgnWIN);
      INC(nr);
      REPEAT
        OK:=Hent20Nxt(TRUE);
(*$IF Test0 *)
  WRITELN(s('PIGtilPGN, Hent20Nxt OK=')+b(OK)+s(' White=')+s(gExtras[gWhite]));
(*$ENDIF *)
        IF OK THEN
          Ok:=Gem(TRUE);
(*$IF Test0 *)
  WRITELN(s('PIGtilPGN, Gem(TRUE) Ok=')+b(Ok));
(*$ENDIF *)
          IF Ok THEN
            ValToStr(nr,FALSE,Str2,10,6,' ',err);
            PrintInfoWIN(0,0,ADR(Str2));
            INC(nr);
          END;
          AEM;
        END;
      UNTIL ~OK OR ~Ok OR Push OR MsgCloseInfoWIN();
    END;
    CloseInfoWIN;
    Draw;
  END;
  SetPtr(wptr,PTRgribe);
  DiskOn:=ODiskOn;
  IF Simple THEN
    FullRefresh;
  END;
  EmptyMsg;
  Lates3:=PGN;
  LongFormOn:=LFS;
END PIGtilPGN;

PROCEDURE PIGtilSKEMA(Type:INTEGER);
CONST
  MaxPersons=64;
TYPE
  STR=ARRAY[0..25] OF CHAR;
  LIN=ARRAY[1..MaxPersons] OF SHORTINT;
VAR
  n,v,m,nr,n1,n2,p,games,cnt,tot,swpi:INTEGER;  (* nr:count of players *)
  (* ds[0] is for swapping *)
  ds:ARRAY[0..MaxPersons] OF LIN; (* 0:'0', 1:'0.5' 2:'1' 3:'1.5' 4:'2' 127:'*' -1:' ' *)
  dn:ARRAY[1..MaxPersons] OF STR;
  dt:ARRAY[1..MaxPersons] OF INTEGER; (* tot *)
  dc:ARRAY[1..MaxPersons] OF INTEGER; (* cnt *)
  Str2:STR;
  Str3:ARRAY[0..8] OF CHAR;
  Top:ARRAY[0..80] OF CHAR;
  Str1:ARRAY[0..2000] OF CHAR;
  u:File;
  res:LONGINT;
  swps:SHORTINT;
  err,ciw,cLast:BOOLEAN;
PROCEDURE MakeLine;
BEGIN
  FOR n:=0 TO nr+16 DO
    WriteStr(u,'--');
  END;
  WriteChar(u,12C);
END MakeLine;
BEGIN
  HelpNr:=291;
  FOR n:=1 TO MaxPersons DO
    FOR m:=1 TO MaxPersons DO
      ds[m,n]:=-1;
    END;
  END;
  nr:=0;
  games:=0;
  cLast:=FALSE;
  SetPtr(wptr,PTRsove);
  IF Hent20First(TRUE) THEN
    Copy(Top,gExtras[gSite]);

    (* Copy(Str1,Q[300]^); '     1 games\n'+
                           '     2 persons\n\n'+
                           '  Making tournament table (to file "t:Table")  \n';*)
 
    OpenInfoWIN(ADDRESS(Q[300]));

    IF (Top[0]<>0C) THEN
      Concat(Top,', ');
    END;
    Concat(Top,gExtras[gEvent]);
    Concat(Top,', ');
    Concat(Top,gExtras[gDate]);
    Concat(Top,'  (% = 1/2)');
    REPEAT
      INC(games);

      (* fix cb import space-problems *)
      IF gExtras[gBlack,0]=' ' THEN 
        Delete(gExtras[gBlack],0,1);
      END;
      res:=Length(gExtras[gWhite]);
      IF (res>0) & (gExtras[gWhite,res-1]=' ') THEN
        gExtras[gWhite,res-1]:=0C;
      END;

      n1:=1;
      WHILE (n1<=MaxPersons) & (n1<=nr) & (Compare(dn[n1],gExtras[gWhite])<>0) DO
        INC(n1);
      END;
      IF n1>MaxPersons THEN
        n1:=MaxPersons;
        cLast:=TRUE;
      END;
      IF n1>nr THEN
        INC(nr);
        Copy(dn[n1],gExtras[gWhite]);
      END;

      n2:=1;
      WHILE (n2<=MaxPersons) & (n2<=nr) & (Compare(dn[n2],gExtras[gBlack])<>0) DO
        INC(n2);
      END;
      IF n2>MaxPersons THEN
        n2:=MaxPersons;
        cLast:=TRUE;
      END;
      IF n2>nr THEN
        INC(nr);
        Copy(dn[n2],gExtras[gBlack]);
      END;
(*$IF Test *)
  WRITELN(s('Læser game:')+l(games)+s(' n1:')+l(n1)+s(' n2:')+l(n2));
(*$ENDIF *)

      ValToStr(games,FALSE,Str2,10,6,' ',err);
      ValToStr(nr   ,FALSE,Str3,10,6,' ',err);
      ConcatChar(Str2,'\n');
      Concat(Str2,Str3);
      PrintInfoWIN(0,0,ADR(Str2));

      IF gExtras[gResult,0]='*' THEN
        IF ds[n1,n2]=-1 THEN ds[n1,n2]:=-2; END;
        IF ds[n2,n1]=-1 THEN ds[n1,n2]:=-2; END;
      ELSE
        IF ds[n1,n2]=-1 THEN ds[n1,n2]:=0; END;
        IF ds[n2,n1]=-1 THEN ds[n2,n1]:=0; END;
        IF Length(gExtras[gResult])>2 THEN
          IF gExtras[gResult,2]='1' THEN           (* uberlauf >63 points *)
            IF ds[n2,n1]<126 THEN ds[n2,n1]:=ds[n2,n1]+2; ELSE ds[n2,n1]:=127; END;
          ELSIF gExtras[gResult,2]='0' THEN
            IF ds[n1,n2]<126 THEN ds[n1,n2]:=ds[n1,n2]+2; ELSE ds[n1,n2]:=127; END;
          ELSIF gExtras[gResult,2]='2' THEN
            IF ds[n2,n1]<127 THEN ds[n2,n1]:=ds[n2,n1]+1; ELSE ds[n2,n1]:=127; END;
            IF ds[n1,n2]<127 THEN ds[n1,n2]:=ds[n1,n2]+1; ELSE ds[n1,n2]:=127; END;
          END;
        END;
      END;

      OK:=Hent20Nxt(TRUE);
      AEM;
      ciw:=MsgCloseInfoWIN();
    UNTIL ~OK OR Push OR (games>=MaxPersons*MaxPersons) OR ciw;
(*$IF Test *)
  WRITELN(s('Læst games:')+l(games)+s(' spillere:')+l(nr));
(*$ENDIF *)
    IF (nr>0) & (games>0) & ~ciw THEN
      Lookup(u,'t:Table',512,TRUE);
      IF u.res=done THEN

        (* write toplines *)
        WriteString(u,Top);

        ValToStr(games,FALSE,Top,10,8,' ',err);
        WriteStr(u,Top);
        FOR n:=8+1 TO 25+3 DO 
          WriteChar(u,' ');
        END;
        FOR n:=1 TO nr DO
          WriteChar(u,' ');
          WriteChar(u,CHR(n MOD 10+48));
        END;
        WriteString(u,Q[299]^); (*'  #  p  '*)
        MakeLine;

        (* write rest of the lines *)
(*$IF Test *)
  WRITELN(s('Skriver linier:')+l(nr));
(*$ENDIF *)

        FOR n:=1 TO nr DO
          (* make individual scores *)
          cnt:=0;
          tot:=0;
          FOR m:=1 TO nr DO
            CASE ds[n,m] OF
            |  0:  INC(tot);
            |  1:  INC(tot);INC(cnt);
            |  2:  INC(tot);INC(cnt,2);
            |  3:  INC(tot);INC(cnt,3);
            |  4:  INC(tot);INC(cnt,4);
            ELSE
              IF ds[n,m]>4 THEN
                INC(tot);cnt:=cnt+ds[n,m];
              END;
            END;
            IF (ds[n,m]>=0) & (ds[n,m]<=4) & (ds[m,n]>=0) & (ds[m,n]<=4) THEN
              IF (ds[n,m]+ds[m,n])>2 THEN
                INC(tot,(ds[n,m]+ds[m,n]) DIV 2-1);
              END;
            END;
          END;
          dt[n]:=tot;
          dc[n]:=cnt;
        END;

        (* Sorter *)
        FOR m:=1 TO nr-1 DO
          FOR n:=1 TO nr-1 DO
            IF dc[n]<dc[n+1] THEN
              (* swap *)
              swpi:=dt[n]; dt[n]:=dt[n+1]; dt[n+1]:=swpi;
              swpi:=dc[n]; dc[n]:=dc[n+1]; dc[n+1]:=swpi;
              Str2:=dn[n]; dn[n]:=dn[n+1]; dn[n+1]:=Str2;
              ds[0]:=ds[n]; ds[n]:=ds[n+1]; ds[n+1]:=ds[0];
              FOR cnt:=1 TO nr DO
                swps:=ds[cnt,n]; ds[cnt,n]:=ds[cnt,n+1]; ds[cnt,n+1]:=swps;
              END;
            END;
          END;
        END;

        FOR n:=1 TO nr DO

          (* make player name *)
          p:=0;
          IF ~cLast OR (n<MaxPersons) THEN
            WHILE dn[n,p]<>0C DO
              WriteChar(u,dn[n,p]);
              INC(p);
            END;
          END;
          FOR p:=p+1 TO 25 DO
            WriteChar(u,' ');
          END;

          (* make player nr *)
          ValToStr(n,FALSE,Top,10,2,' ',err);
          WriteChar(u,Top[0]);
          WriteChar(u,Top[1]);

          WriteChar(u,'|');

          (* write individual scores *)
          FOR m:=1 TO nr DO
            CASE ds[n,m] OF
            |  0:  WriteStr(u,' 0');
            |  1:  WriteStr(u,' %');
            |  2:  WriteStr(u,' 1');
            |  3:  WriteStr(u,'1%');
            |  4:  WriteStr(u,' 2');
            | -2:  WriteStr(u,' *');
            ELSE
              IF ds[n,m]>4 THEN
                WriteStr(u,'>2');
              ELSE
                WriteStr(u,'  ');
              END;
            END;
          END;

          WriteChar(u,'|');

          (* make game-count *)
          ValToStr(dt[n],FALSE,Top,10,2,' ',err);
          WriteChar(u,Top[0]);
          WriteChar(u,Top[1]);
          WriteChar(u,'|');

          (* make total score *)
          IF dc[n]=1 THEN
            WriteString(u,' % ');
          ELSE
            ValToStr(dc[n] DIV 2,FALSE,Top,10,2,' ',err);
            WriteChar(u,Top[0]);
            WriteChar(u,Top[1]);
            IF ODD(dc[n]) THEN
              WriteString(u,'%');
            ELSE
              WriteString(u,' ');
            END;
          END;

        END;
        MakeLine;
       
      END;
      Close(u);

      IF nr<=24 THEN
        n:=0;
        Lookup(u,'t:Table',512,FALSE);
        WHILE (n<SIZE(Str1)) & (u.res=done) DO
          ReadChar(u,Str1[n]);
          INC(n);
        END;
        Close(u);
        IF n=0 THEN      
          Str1[0]:=0C;
        ELSE
          Str1[n-1]:=0C;
        END;
      ELSE
        Copy(Str1,Q[298]^); 
(* '\n  Table too big to show (max 24 persons)!  \n\n    See the file "t:Table"' *)
      END;
      IF SimpleWIN(ADR(Str1))=1 THEN END;
    END;
    CloseInfoWIN;
    Draw;
  END;
  SetPtr(wptr,PTRgribe);
  IF Simple THEN
    FullRefresh;
  END;
  EmptyMsg;
END PIGtilSKEMA;

PROCEDURE teoPRT;
(*
VAR
  hst:ARRAY[0..100] OF CHAR;
*)
BEGIN
  IF teoWIN.Window<>NIL THEN
(*
    Copy(hst,TeoSpaces); Concat(hst,Q[TeoSearch]^); Concat(hst,TeoSpaces);
    PRINTWIN(teoWIN,4,120,ADR(hst),2,0);
*)
    FPtxt:=FindPosition();
    PRINTWIN(teoWIN,140,108,VluToStr(EVA),1,0);
    PRINTWIN(teoWIN,4,120,FPtxt,1,0);
  END;
END teoPRT;

PROCEDURE ReCalcTeo(StatisticOn:BOOLEAN);
VAR
  hst:ARRAY[0..100] OF CHAR;
BEGIN
  SetPtr(wptr,PTRsove);
  Copy(hst,TeoSpaces); Concat(hst,Q[TeoRecalc]^); Concat(hst,TeoSpaces);
  PRINTWIN(teoWIN,4,120,ADR(hst),3,0);
  ReCalc(StatisticOn);
  SetPtr(wptr,PTRrestore);
END ReCalcTeo;

PROCEDURE PIGtilPIG; (* F3 *)
VAR
  Ok,ODiskOn,err,TeoLd:BOOLEAN;
  CFLO,nr:LONGINT;
  Str,pi,pu:ARRAY[0..255] OF CHAR;
  Str2:ARRAY[0..16] OF CHAR;
PROCEDURE Juster;
BEGIN
  (* cleanup some 1-char PGN tags *)
  IF Length(gExtras[gNIC])=1 THEN gExtras[gNIC]:=''; END;
  IF Length(gExtras[gInfo])=1 THEN gExtras[gInfo]:=''; END;
  IF Length(gExtras[gSource])=1 THEN gExtras[gSource]:=''; END;
  IF Length(gExtras[gAnnotator])=1 THEN gExtras[gAnnotator]:=''; END;
  IF PigPigMode>-1 THEN CatGame(PigPigMode,TRUE) END;
END Juster;
BEGIN
  TeoLd:=teoWIN.Window<>NIL;
  HelpNr:=287;
  nr:=0;
  ODiskOn:=DiskOn;
  DiskOn:=FALSE;
  OK:=Hent20First(TRUE);
(*$IF Test0 *)
  WRITELN(s('Hentet20First.'));
(*$ENDIF *)
  SetPtr(wptr,PTRsove);
  IF OK THEN
    Copy(pi,path20);
    Copy(Str,Q[272]^) ;   (* '     0 spil fra PIG fil:  \n\n  ' *)
    Concat(Str,pi);
    IF TeoLd THEN
      Concat(Str,'  \n\n');
      Concat(Str,Q[TeoAdded]^);
      Concat(Str,'  \n\n  ');
    (*$IF Test0 *)
      WRITELN(s('PIP-PIG.1 ...'));
    (*$ENDIF *)
      setudgangsstilling;
      OK:= AddGame(StrToVlu(gExtras[gResult]),TRUE)>4;
    (*$IF Test0 *)
      WRITELN(s('PIP-PIG.1'));
    (*$ENDIF *)
    ELSE
      Juster;
      Ok:=Gem20(FALSE,TRUE,TRUE);
      Copy(pu,path20);
      Concat(Str,Q[268]^);  (* '  \n\ntilføjet til PIG-BASE fil:  \n\n  ' *)
      Concat(Str,pu);
    (*$IF Test0 *)
      WRITELN(s('Ok=Gem(FALSE).'));
    (*$ENDIF *)
    END;
    Concat(Str,'  \n');
    OpenInfoWIN(ADR(Str));
    IF Ok THEN
      INC(nr);
      REPEAT
        Copy(path20,pi);
        OK:=Hent20Nxt(TRUE);
        IF OK THEN
          IF TeoLd THEN
    (*$IF Test0 *)
      WRITELN(s('PIP-PIG.2 ... TraekNr=')+l(TraekNr));
    (*$ENDIF *)
            setudgangsstilling;
            OK:= AddGame(StrToVlu(gExtras[gResult]),TRUE)>4;
            IF ~OK THEN
              IF SimpleWIN(ADR(Q[TeoNotGamAdd]^))=1 THEN END;
            END;
    (*$IF Test0 *)
      WRITELN(s('PIP-PIG.2'));
    (*$ENDIF *)
          ELSE
            Copy(path20,pu);
            Juster;
            Ok:=Gem20(TRUE,TRUE,FALSE);
          END;
          IF Ok THEN
            INC(nr);
            ValToStr(nr,FALSE,Str2,10,6,' ',err);
            PrintInfoWIN(0,0,ADR(Str2));
          END;
    (*$IF Test0 *)
      WRITELN(s('PIP-PIG.3 ...'));
    (*$ENDIF *)
          AEM;
    (*$IF Test0 *)
      WRITELN(s('PIP-PIG.3'));
    (*$ENDIF *)
        END;
      UNTIL ~OK OR ~Ok OR Push OR MsgCloseInfoWIN();
    (*$IF Test0 *)
      WRITELN(s('PIP-PIG.4'));
    (*$ENDIF *)
    END;
    IF TeoLd THEN
      ReCalcTeo(Statistic);
      teoPRT;
    ELSE
      Save20close;
    END;
    CloseInfoWIN;
    (*$IF Test0 *)
      WRITELN(s('PIP-PIG.5'));
    (*$ENDIF *)
    Draw;
  END;
  SetPtr(wptr,PTRgribe);
  DiskOn:=ODiskOn;
  IF Simple THEN
    FullRefresh;
  END;
    (*$IF Test0 *)
      WRITELN(s('PIP-PIG.6'));
    (*$ENDIF *)
  EmptyMsg;
END PIGtilPIG;

(*
PROCEDURE LavListe20;
BEGIN
  SetPtr(wptr,PTRsove);
  ToNormal;
  IF GetTextPGN(1) THEN
    IF LL20(NIL)=1 THEN END;
  END;
  SetPtr(wptr,PTRgribe);
END LavListe20;
*)

VAR
  FirstHelp:BOOLEAN;

PROCEDURE Help;
VAR
  Res:CARDINAL;
  st1:ARRAY[0..3000] OF CHAR;
  st2:HelpSt;

n:INTEGER;
st:STILLINGTYPE;
t:TRKDATA;

BEGIN
  (*$IF Test0 *)
    d(s("Help"));
  (*$ENDIF *)

  SetPtr(wptr,PTRsove);
  Copy(st1,Q[TxSKAKSPISEBMREV]^);
(*
STILLINGtoFEN(st1,stilling);
FENtoSTILLING(stilling,st1);
STILLINGtoFEN(st1,stilling);
FullRefresh;
ConcatChar(st1,'\n');
*)
  Concat(st1,Rev);
  Concat(st1,Q[TxDUVALGTEAT]^);
  AddHelp(st2,HelpNr,Valg);
  Concat(st1,st2);
  ConcatChar(st1,'\n');
  Concat(st1,Bruger);
  ConcatChar(st1,'\n');
  IF FirstHelp & (HelpNr=17) THEN (* farver,så help vil vise Versions *)
    FOR Res:=0 TO MaxLogs DO
      IF ~(VersionList[Res]=NIL) THEN
        IF ODD(Res) THEN
          Concat(st1,', ');
        ELSE
          Concat(st1,'\n');
        END;
        Concat(st1,VersionList[Res]^);
      END;
    END;
    FirstHelp:=FALSE;
  ELSE
    Concat(st1,Q[Qkeyshelp]^); (* Key Help *)
  END;
  Res:=SimpleWIN(ADR(st1));
  SetPtr(wptr,PTRrestore);
  IF Simple THEN
    FullRefresh;
  END;
  EmptyMsg;
END Help;

PROCEDURE Opsaet(gnr:CARDINAL); (* og Nyt spil *)
BEGIN
  (*$IF Test0 *)
    d(s("Opsaet(gnr:CARDINAL)"));
  (*$ENDIF *)
  ToNormal;
  IF gnr=75 THEN HelpNr:=21 ELSE HelpNr:=18 END;
  OldStilling:=stilling;
  IF gnr=77 THEN                (* Nyt spil *)
    Udgang;
  END;
  SetUpMode:=1;
  Valg:=0;
  SetPtr(wptr,PTRgribe);
  CalcMunde;  (* and/or Dominans (only if ~MouthOff/DominansOn) *)
  EmptyMsg;
  Draw;
END Opsaet;

PROCEDURE AddSecsToStr(secs:LONGINT; VAR str:ARRAY OF CHAR);
VAR
  st:ARRAY[0..20] OF CHAR;
  er:BOOLEAN;
BEGIN
  IF secs>=0 THEN
    ValToStr(secs DIV 60,FALSE,st,10,3,' ',er);
    Concat(str,st);
    ConcatChar(str,':');
    ValToStr(secs MOD 60,FALSE,st,10,2,'0',er);
    Concat(str,st);
    ConcatChar(str,' ');
  END;
END AddSecsToStr;
 
(* Hvis forvandling: ret Til og returner type 1=D 2=T 3=S 4=L, ellers 0 *)
PROCEDURE AdjustTilForUnder(VAR Fra,Til:INTEGER; Brik:CHAR):INTEGER;
VAR
  cnt:INTEGER;
BEGIN
  cnt:=0;
  IF (Brik='b') & (Fra>70) THEN
    WHILE Til<Fra+9 DO Til:=Til+10; INC(cnt);END;
    IF cnt=0 THEN INC(cnt); END; 
  END;
  IF (Brik='B') & (Fra<29) THEN
    WHILE Til>Fra-9 DO Til:=Til-10; INC(cnt); END;
    IF cnt=0 THEN INC(cnt); END; 
  END;
  (*$IF Test0 *)
    d(s("ADJ Til=")+l(Til));
  (*$ENDIF *)
  IF cnt>0 THEN
    MOVEINFOSTRING[6]:='=';
    CASE cnt OF
      | 1 : MOVEINFOSTRING[7]:=LP('D');
      | 2 : MOVEINFOSTRING[7]:=LP('T');
      | 3 : MOVEINFOSTRING[7]:=LP('S');
      | 4 : MOVEINFOSTRING[7]:=LP('L');
    ELSE
    END;
  END;
  RETURN(cnt);
END AdjustTilForUnder;

VAR
  SecsLast:LONGINT;
  FirstMoveInfo:BOOLEAN;

(* LastFra=piece moved, or ? to detect or 0C to skip moveinfo *)
(* LastTil= ' ' or '-' then then not an exchange *)
PROCEDURE MVINFO(LastFra,LastTil:CHAR); (* ' ' or '-' for empty (ikke slag) *)
VAR
  ifra,itil,n:INTEGER;
  Secs,SecsNow,Micros:LONGINT;
  Move:BOOLEAN;
BEGIN
  Move:=LastFra<>0C;
  IF Move THEN
    IF TraekNr>0 THEN
      ifra:=Spil^[TraekNr].Fra;
      IF LastFra='?' THEN LastFra:=stilling[ifra] END;
      itil:=Spil^[TraekNr].Til;
    (*$IF Test0 *)
      d(s("MVINFO itil=")+l(itil)+c(LastFra)+l(ifra));
    (*$ENDIF *)
      MOVEINFOSTRING[6]:=' ';
      MOVEINFOSTRING[7]:=' ';
      n:=AdjustTilForUnder(ifra,itil,LastFra);
    (*$IF Test0 *)
      d(s("MVINFO itil=")+l(itil));
    (*$ENDIF *)
      MOVEINFOSTRING[0]:=' '; (* LP(CHAR(stilling[itil])); *)
      MOVEINFOSTRING[1]:=CHAR(ifra MOD 10+96);
      MOVEINFOSTRING[2]:=CHAR(ifra DIV 10+48);
      IF (LastTil=' ') OR (LastTil='-') THEN
        MOVEINFOSTRING[3]:='-';
      ELSE
        MOVEINFOSTRING[3]:='x';
      END;     
      MOVEINFOSTRING[4]:=CHAR(itil MOD 10+96);
      MOVEINFOSTRING[5]:=CHAR(itil DIV 10+48);
      MOVEINFOSTRING[8]:=0C; 
    ELSE
      MOVEINFOSTRING:='        ';
    END;

    (* set clock *)
    TIMEINFOSTRING:='';
    Secs:=0;
    FOR n:=1 TO TraekNr BY 2 DO Secs:=Secs+LONGINT(Spil^[n].Secs); END;
    AddSecsToStr(Secs,TIMEINFOSTRING);
    Secs:=0;
    FOR n:=2 TO TraekNr BY 2 DO Secs:=Secs+LONGINT(Spil^[n].Secs); END;
    AddSecsToStr(Secs,TIMEINFOSTRING);
    AddSecsToStr(Spil^[TraekNr].Secs,TIMEINFOSTRING);
  END;

  CurrentTime(ADR(SecsNow),ADR(Micros));
  IF FirstMoveInfo THEN
    FirstMoveInfo:=FALSE;
    SecsLast:=SecsNow;
    GameStartSeconds:=SecsNow;
    MoveStartSeconds:=SecsNow;
  END;
  IF Move OR (SecsNow<>SecsLast) THEN
    SecsLast:=SecsNow;
    IF ~Move THEN TIMEINFOSTRING[21]:=0C; END;
    (*AddSecsToStr(SecsNow-GameStartSeconds,TIMEINFOSTRING);*)
    AddSecsToStr(SecsNow-MoveStartSeconds,TIMEINFOSTRING);
    (*$IF Test0 *)
      d(s("MVINFO Time=")+s(TIMEINFOSTRING));
    (*$ENDIF *)
    IF ~Move THEN ReDraw(stilling,Dominans,Mund,Select); END;
  END;
END MVINFO;

VAR
  Method:SHORTINT;

PROCEDURE Flyt4(gnr:CARDINAL; Offset:INTEGER);(* 67,69,71,73+0 or 66+Offset or 61*)
VAR
  df:BOOLEAN;
  of,ot,fra,dx,dy,rx,ry,px,py,n,Times:INTEGER;
  cf,ct,co:CHAR;
PROCEDURE BlinkFra;
BEGIN
  Select[of]:='S';
  Draw;
  Delay(4*Times);
  Select[of]:=' ';
  Draw;
  Delay(4*Times);
END BlinkFra;
PROCEDURE MarkerFraTil;
BEGIN
  Select[of]:='S';
  Select[ot]:='S';
  Draw;
  Delay(4*Times);
END MarkerFraTil;
PROCEDURE FlytBrik;
BEGIN
  stilling[of]:=' ';
  stilling[ot]:=cf;
  Draw;
  Delay(4*Times);
END FlytBrik;
PROCEDURE FraBrik;
BEGIN
  stilling[of]:=cf;
  Draw;
  Delay(4*Times);
END FraBrik;
PROCEDURE Animer;
VAR
  m:INTEGER;
BEGIN
  px:=of MOD 10;
  py:=of DIV 10;
  dx:=(ot MOD 10)-px;
  dy:=(ot DIV 10)-py;
  IF dx=0 THEN rx:=0 ELSIF dx<0 THEN rx:=-1 ELSE rx:=1 END;
  IF dy=0 THEN ry:=0 ELSIF dy<0 THEN ry:=-1 ELSE ry:=1 END;
  IF (CAP(cf)='S') THEN
    IF ABS(dx)>ABS(dy) THEN rx:=rx+rx ELSE ry:=ry+ry END;
  END;
  stilling[of]:=' ';
  px:=px+rx;
  py:=py+ry;
  m:=0;

  WHILE ((of>=ot) OR (px+10*py<ot))
  & ((of<=ot) OR (px+10*py>ot))
  & (px>=1) & (px<=8) & (py>=1)& (py<=8) & (m<=7) DO
    n:=px+10*py;            
    co:=stilling[n];
    stilling[n]:=cf;
    Draw;
    INC(m);
    IF m<3 THEN
      Delay(3*Times);
    ELSIF m<6 THEN
      Delay(2*Times);
    ELSE
      Delay(1*Times);
    END;
    stilling[n]:=co;
    px:=px+rx;
    py:=py+ry;
  END;
  IF m>0 THEN
    stilling[ot]:=cf;
    Draw;
  END;
END Animer;
BEGIN
  (*$IF Test0 *)
    d(s("Flyt(gnr:CARDINAL)"));
  (*$ENDIF *)
  IF gnr=67 THEN HelpNr:=11 ELSE HelpNr:=14 END;
  IF ~NoAutoPGN & ((TraekNr=0) & ((gnr>=71) & (gnr<=73) OR (gnr=66) & (Offset>0))
  OR (TraekNr=MaxTraek) & ((gnr<=69) & (gnr>=67) OR (gnr=66) & (Offset<0))) THEN
    CLOSEWIN(pgnWIN);
  END;
  fra:=TraekNr;
  df:=FALSE;
  cf:=' '; (* CharFraFørMove *)
  ct:='-'; (* CharTilFørMove *)
  CASE gnr OF
    | 66 :  (* *)
      n:=TraekNr;
      TraekNr:=TraekNr+Offset;
      IF TraekNr>MaxTraek THEN 
        TraekNr:=MaxTraek;
      ELSIF TraekNr<0 THEN 
        TraekNr:=0;
      END;
      df:=n<>TraekNr;
    | 67 : (* to start (of movelist) *)
      IF TraekNr>0 THEN 
        TraekNr:=0;
        df:=TRUE;
      END;
    | 69 : (* left (1 back) *)
      IF TraekNr>0 THEN 
        DEC(TraekNr);
        df:=TRUE;
      END;      
    | 61,71 : (* 61=move, 71=right (one forward)  *)
      IF (gnr=61) OR (TraekNr<MaxTraek) THEN 
        IF (gnr=61) & (TraekNr=15) THEN
          SetKeys;
        END;
        IF Quick THEN Times:=1 ELSE Times:=2 END;
        (* flash *)
        of:=Spil^[TraekNr+1].Fra;
        cf:=stilling[of];
        ot:=Spil^[TraekNr+1].Til;
        n:=AdjustTilForUnder(of,ot,cf);
        ct:=stilling[ot];
        Method:=3;
        CASE Method OF  
        | 1: (* flyt fra->til, tænd fra, sluk fra *)
          FlytBrik;
          FraBrik;
        | 2:
          BlinkFra;
          MarkerFraTil;
          FlytBrik;
        | 3:
          BlinkFra;
          Animer;
        ELSE
        END;
        stilling[of]:=cf;
        stilling[ot]:=ct;
        Select[of]:=' ';
        Select[ot]:=' ';
        INC(TraekNr);
        df:=TRUE;
      END;
    | 73 : (* to end (of movelist) *)
      IF TraekNr<MaxTraek THEN 
        TraekNr:=MaxTraek;
        df:=TRUE;
      END;
  ELSE 
  (*$IF Test0 *)
      d(s('Flyt: CASE error'));
  (*$ENDIF *)
  END;
  IF df THEN
    GetStilling(fra); 
    IF gnr<>61 THEN
      IF (stilling[HvisTur]='H') THEN
        IF StyU>0 THEN StyU:=-StyU; END;
        IF StyO<0 THEN StyO:=-StyO; END;
      ELSE
        IF StyO>0 THEN StyO:=-StyO; END;
        IF StyU<0 THEN StyU:=-StyU; END;
      END;
      SetPtr(wptr,PTRgribe);
    END;
    CalcMunde;  (* and/or Dominans (only if ~MouthOff/DominansOn) *)
    Tx:=TRUE;
    Valg:=0;
    MVINFO(cf,ct);
    teoPRT;
    Draw;
    IF (TraekNr>0) & (TraekNr=MaxTraek) & (gnr<>61) & ~VariantTil THEN
      IF pgnWIN.Window=NIL THEN
        PGNcomments;
      END;
    END;
  END;
END Flyt4;

PROCEDURE Flyt(gnr:CARDINAL); (* 67,69,71,73 *)
BEGIN
  Flyt4(gnr,0);
END Flyt;

PROCEDURE OpNed;
BEGIN
  (*$IF Test0 *)
    d(s("OpNed"));
  (*$ENDIF *)
  HelpNr:=1;
  SetOpNed(stilling,Dominans,Mund,Select,~OpAd);
END OpNed;

(* set the man/machine vars StyO/U to relevant values depending on  who to move*)
PROCEDURE Person(gnr:CARDINAL);
BEGIN
  (*$IF Test0 *)
    d(s("Person(gnr:CARDINAL)"));
  (*$ENDIF *)
  IF gnr=30 THEN 
    IF StyO=0 THEN 
      HelpNr:=5;
      IF stilling[HvisTur]<>'S' THEN
        StyO:=1;
      ELSE
        StyO:=-1;
      END;
    ELSE
      HelpNr:=3;
      StyO:=0;
    END;
  ELSE (* 40? *)
    IF StyU=0 THEN 
      HelpNr:=4;
      IF stilling[HvisTur]='S' THEN
        StyU:=1;
      ELSE
        StyU:=-1;
      END;
    ELSE
      HelpNr:=2;
      StyU:=0;
    END;
  END;
  Draw;
END Person;

PROCEDURE DomiFraTil(gnr:CARDINAL);
BEGIN
  (*$IF Test0 *)
    d(s("DomiFraTil"));
  (*$ENDIF *)
  DominansOn:=~GetToggle(gnr);
  IF DominansOn THEN HelpNr:=19 ELSE HelpNr:=20 END;
  CalcMunde;  (* and/or Dominans (only if ~MouthOff/DominansOn) *)
  Draw;   
END DomiFraTil;

PROCEDURE DiskFraTil(gnr:CARDINAL);
BEGIN
  IF Bruger[10]<>qk THEN INC(SneakCount); END;
  (*$IF Test0 *)
    d(s("DiskFraTil"));
  (*$ENDIF *)
  DiskOn:=~GetToggle(gnr);
  IF DiskOn THEN HelpNr:=42 ELSE HelpNr:=43 END;
END DiskFraTil;

PROCEDURE LydFraTil(gnr:CARDINAL);
BEGIN
  IF Bruger[6]<>qg THEN INC(SneakCount); END;
  (*$IF Test0 *)
    d(s("LydFraTil"));
  (*$ENDIF *)
  LydTil:=~GetToggle(gnr);
  IF LydTil THEN 
    HelpNr:=15;
    Sig(Q[TxOKAY]^);
  ELSE
    HelpNr:=16;
  END;
END LydFraTil;


PROCEDURE Farver;
VAR
  n:INTEGER;
  ch:CHAR;
  actual:LONGINT;
BEGIN
  (*$IF Test0 *)
    d(s("Farver"));
  (*$ENDIF *)
  HelpNr:=17;
  SetPtr(wptr,PTRsove);
  IF reqBase=NIL THEN
    IF SimpleWIN(ADDRESS(Q[274]))=1 THEN END;
    SetGad(83,FALSE);
  ELSE
    actual:=ColorRequester(1);
    Debug:=(actual=999); (* =0 Kun for Debug !!!!!!!!!!! *)
    IF actual>=0 THEN
      SavePalette;
    END;
  END;
  SetPtr(wptr,PTRrestore);
  IF Simple THEN
    FullRefresh;
  END;
  EmptyMsg;
END Farver;

(****************************************************************************)
(* PROCEDURER Equal, Find, NEq, FindTrk og still rykket til SkakBrain       *)
(****************************************************************************)

PROCEDURE Comments;
VAR
  st,sto:STRING;
  OK:BOOLEAN;
  n:INTEGER;
BEGIN
  (*$IF Test0 *)
    d(s("Comments"));
  (*$ENDIF *)
  IF ~VariantTil THEN
    HelpNr:=27;
    WITH Spil^[TraekNr] DO
      IF Tekst=NIL THEN
        st:='';
      ELSE
        Copy(st,Tekst^);
      END;    
      sto:=st;
      SetPtr(wptr,PTRsove);
      GetText (ADR(st));
      SetPtr(wptr,PTRrestore);
      IF (Compare(st,sto)<>0) THEN
  (*$IF Test0 *)
    WRITELN(s('rettetREM=T'));
  (*$ENDIF *)
        rettetREM:=TRUE;
        IF Tekst<>NIL THEN
          Deallocate(Tekst);
        END;
        REPEAT
          Allocate(Tekst,Length(st)+2);
          IF Tekst<>NIL THEN
            FOR n:=0 TO Length(st) DO Tekst^[n]:=st[n]; END;
            OK:=TRUE;
            TxRet:=TRUE;
          ELSE
            SetPtr(wptr,PTRsove);
            OK:=TwoGadWIN(ADDRESS(Q[TxFORLIDTRAMDROPTEKST]))=1;
            SetPtr(wptr,PTRrestore);
          END;
        UNTIL OK;
      END;     
    END;
    Tx:=TRUE;
    IF Simple THEN
      FullRefresh;
    ELSE
      Draw;
    END;
    EmptyMsg;
  END;
END Comments;

(* PROCEDURE Ryk(gptr:GadgetPtr; gnr:INTEGER); FORWARD;*)

PROCEDURE TeoriWindow;
BEGIN
  HelpNr:=286; 
  OpenTeoWin;
  teoPRT;
END TeoriWindow;

PROCEDURE SetupVindue;
BEGIN
  HelpNr:=290;
  OpenSetWin;
END SetupVindue;

PROCEDURE Slut(Traek:TRKDATA):BOOLEAN;
BEGIN
  IF (pat IN Traek.Typ)
  OR (mat IN Traek.Typ) THEN (* spil slut *)
    IF mat IN Traek.Typ THEN
      (*$IF Test0 *) d(s('SkakMat.'));(*$ENDIF *)
      Sig(Q[TxSKAKMAT]^);
      IF stilling[HvisTur]='S' THEN
        (*$IF Test0 *) d(s('Hvid vandt.'));(*$ENDIF *)
        Sig(Q[TxHVIDVANDT]^);
      ELSE
        (*$IF Test0 *) d(s('Sort vandt.')); (*$ENDIF *)
        Sig(Q[TxSORTVANDT]^);
      END;
    ELSIF pat IN Traek.Typ THEN
      (*$IF Test0 *) d(s('Remis (uafgjort) on pat')); (*$ENDIF *)
      Sig(Q[TxREMIS]^);
    END;
    (*$IF Test0 *) d(s('Spillet er slut.'));(*$ENDIF *)
    IF StyO>0 THEN StyO:=-StyO; END;
    IF StyU>0 THEN StyU:=-StyU; END;
    RETURN(TRUE);
  ELSE
    RETURN(FALSE);
  END;
END Slut;

PROCEDURE Brain;
VAR
  ok,ryd,tnEQmt,White,RepDraw:BOOLEAN;
  Traek:TRKDATA;
  stilo:STILLINGTYPE;
  n:INTEGER;
  txt:ARRAY[0..80] OF CHAR;
  dybet:INTEGER;
  Secs,Micros:LONGINT;
BEGIN
  IF Bruger[0]<>qa THEN INC(SneakCount); END;
(*$IF Test *) WRITELN(s('Brain:rydspil'));(*$ENDIF *)
  IF VariantTil OR (TraekNr=MaxTraek) THEN
    ryd:=TRUE;
  ELSE
    ryd:=RydSpil(TraekNr=0,FALSE);
  END;
  IF ryd THEN
    REPEAT
      dyb:=0;
      IF (stilling[HvisTur]='H') AND (StyU>0) THEN
        dyb:=StyU;
      ELSIF (stilling[HvisTur]='S') AND (StyO>0) THEN
        dyb:=StyO;
      END;
      IF dyb>0 THEN
        teoPRT;
        Draw;
        AEM;
        IF Push THEN
          (*$IF Test0 *) d(s('Pushed'));(*$ENDIF *)
        ELSE
          dybet:=dyb;
          dybx:=1;
         (*$IF Test0 *) d(s('Jeg tænker .....')); (*$ENDIF *)
          Sig(Q[TxHUMM]^);
          SetPtr(wptr,PTRnormal);

          CurrentTime(ADR(Secs),ADR(Micros));

          (* dyb = 1, 4 eller 7   dybx = 1 (bruges p.t. ikke) *)
          FindTrk (stilling,dyb,dybx,Traek,AEM);

          IF ~Push THEN
            IF ~Slut(Traek) THEN
              RepDraw:= x7 IN Traek.Typ;
              stilo:=stilling;
              ok:=(TraekNr<MaxHalvTraek) & DoMoveOk(stilling,Traek.Fra,Traek.Til,Traek.Typ);
              IF ok THEN
                IF ~VariantTil THEN rettetSPIL:=TRUE END;
                INC(TraekNr);
                MaxTraek:=TraekNr;
                IF (Spil^[MaxTraek].Tekst<>NIL) & (Spil^[MaxTraek].Tekst^[0]<>'#') THEN
                  rettetREM:=TRUE;                     (* # is mark for debugging *)
                  Deallocate(Spil^[MaxTraek].Tekst);
                END;

                (* set the clock *)
                CurrentTime(ADR(MoveStartSeconds),ADR(MoveStartMicros));
                IF TraekNr=1 THEN
                  (*$IF Test *)
                    d(s("GameStart by engine s=")+l(Secs));
                  (*$ENDIF *)
                  GameStartSeconds:=Secs;
                  GameStartMicros :=Micros;
                END;
                IF dybet=1 THEN
                  Spil^[TraekNr].Attribs:=ATTRTYPE{e1};
                ELSIF dybet=4 THEN
                  Spil^[TraekNr].Attribs:=ATTRTYPE{e4};
                ELSIF dybet=7 THEN
                  Spil^[TraekNr].Attribs:=ATTRTYPE{e1,e2,e4};
                ELSE
                  Spil^[TraekNr].Attribs:=ATTRTYPE{};  (* unknown *)
                END;
                IF MoveStartSeconds-Secs<65535 THEN
                  Spil^[TraekNr].Secs:=CARDINAL(MoveStartSeconds-Secs);
                ELSE
                  Spil^[TraekNr].Secs:=65535;
                END;

                Sig(Q[TxAHA]^);
                StoreStilling(Traek.Fra,Traek.Til);
                DEC(TraekNr);
                stilling:=stilo;
                Flyt4(61,0);
              END;
              White:=stilling[HvisTur]<>'S';
              IF RepDraw THEN
                (*$IF Test0 *) d(s('Remis (uafgjort) on repetition')); (*$ENDIF *)
                Sig(Q[TxREMIS]^);
                IF OpAd=White THEN
                  StyU:=-StyU;
                ELSE 
                  StyO:=-StyO;
                END;
                IF Spil^[TraekNr].Tekst<>NIL THEN
                  Deallocate(Spil^[TraekNr].Tekst);
                END;
                txt:='\n  3* :   1/2 - 1/2  \n';
                Allocate(Spil^[TraekNr].Tekst,Length(txt)+2);
                IF Spil^[TraekNr].Tekst<>NIL THEN
                  Copy(Spil^[TraekNr].Tekst^,txt);
                END;
                Draw;
              ELSIF  White THEN 
                Sig(Q[TxHVIDSTUR]^);
              ELSE
                Sig(Q[TxSORTSTUR]^);
              END;
            END;
          ELSE
            Sig(Q[TxNAAH]^);
          END;
          SetPtr(wptr,PTRgribe);
        END;
      END;

(*$IF Test0 *)
  Secs:=0;
  WRITE(s('White: '));
  FOR dybet :=1 TO TraekNr BY 2 DO
    Secs:=Secs+LONGINT(Spil^[dybet].Secs);
(*
    WRITE(lf(dybet,2)+s(' ')+lf(Spil^[dybet].Secs,2));
    IF man IN Spil^[dybet].Attribs THEN WRITE(s('m'));
    ELSIF e2 IN Spil^[dybet].Attribs THEN WRITE(s('c'));
    ELSIF e1 IN Spil^[dybet].Attribs THEN WRITE(s('a'));
    ELSIF e4 IN Spil^[dybet].Attribs THEN WRITE(s('b'));
    ELSE WRITE(s('? ')); END;
*)
  END;
  WRITE(lf(Secs DIV 60,3)+s(':'));
  IF Secs MOD 60 < 10 THEN WRITE(s('0')); END;
  WRITE(l(Secs MOD 60));
  Secs:=0;
  WRITE(s('    Black: '));
  FOR dybet :=2 TO TraekNr BY 2 DO
    Secs:=Secs+LONGINT(Spil^[dybet].Secs);
(*
    WRITE(lf(dybet,2)+s(' ')+lf(Spil^[dybet].Secs,2));
    IF man IN Spil^[dybet].Attribs THEN WRITE(s('m'));
    ELSIF e1 IN Spil^[dybet].Attribs THEN WRITE(s('a'));
    ELSIF e2 IN Spil^[dybet].Attribs THEN WRITE(s('c'));
    ELSIF e1 IN Spil^[dybet].Attribs THEN WRITE(s('b'));
    ELSE WRITE(s('? ')); END;
*)
  END;
  WRITE(lf(Secs DIV 60,3)+s(':'));
  IF Secs MOD 60 < 10 THEN WRITE(s('0')); END;
  WRITE(l(Secs MOD 60));
  WRITE(s('    Game time=')+lf((MoveStartSeconds-GameStartSeconds) DIV 60,3)+s(':'));
  IF (MoveStartSeconds-GameStartSeconds) MOD 60 < 10 THEN WRITE(s('0')); END;
  WRITELN(l((MoveStartSeconds-GameStartSeconds) MOD 60));
(*$ENDIF *)

    UNTIL (dyb=0) OR Push;
  END;
  IF ~ryd OR Push THEN
    IF (StyU>0) THEN 
      StyU:=-StyU;
    END;
    IF (StyO>0) THEN 
      StyO:=-StyO;
    END;
  END;
END Brain;

PROCEDURE Styrke(gnr:CARDINAL);
VAR
  lnr:INTEGER;
  bon:BOOLEAN;
BEGIN
  (*$IF Test0 *)
    d(s("Styrke gnr=")+l(gnr));
  (*$ENDIF *)
  (*$ IF False *)
    IF (gnr>34) & (gnr<40) OR (gnr>44) THEN
      lnr:=SimpleWIN(ADDRESS(Q[DemoMessage]));
      gnr:=0;
    END;
  (*$ ENDIF *)
  IF gnr>0 THEN
    bon:=(stilling[HvisTur]='H') & (gnr>39) OR (stilling[HvisTur]='S') & (gnr<40);

    IF gnr<40 THEN
      StyO:=gnr-30;
      HelpNr:=6+StyO/3;
    ELSE
      StyU:=gnr-40;
      HelpNr:=6+StyU/3;
    END;
    IF GetToggle(gnr) THEN
      IF gnr<40 THEN
        StyO:=-StyO;
      ELSE
        StyU:=-StyU;
      END;
    END;
    Draw;
    IF bon THEN 
      Brain;
    END;
  END;
END Styrke;

PROCEDURE Tom;
BEGIN
  (*$IF Test0 *)
    d(s("Tom"));
  (*$ENDIF *)
  HelpNr:=25;
  still(stilling,'                                                                H');
  Draw;
END Tom;

PROCEDURE Restore;
BEGIN
  (*$IF Test0 *)
    d(s("Restore"));
  (*$ENDIF *)
  HelpNr:=26;
  stilling:=OldStilling;
  Draw;
END Restore;

PROCEDURE HvidSortTur(gnr:INTEGER);
BEGIN
  (*$IF Test0 *)
    d(s("HvidSortTur"));
  (*$ENDIF *)
  IF GetToggle(gnr) THEN 
    stilling[HvisTur]:='S';
    HelpNr:=23;
  ELSE
    stilling[HvisTur]:='H';
    HelpNr:=22;
  END;
END HvidSortTur;

PROCEDURE Main(gnr:CARDINAL); (* Fra SetUp til Main *)
VAR
  n      : INTEGER;
  msg    : IntuiMessagePtr;
  swp    : ADDRESS;
  brk    : ARRAY[' '..'t'] OF INTEGER;
  ch     : CHAR;
  st     : ARRAY[0..1023] OF CHAR;
  st2    : ARRAY[0..255] OF CHAR;
  Warn   : BOOLEAN;
  startSt: STILLINGTYPE;
PROCEDURE Add(str:ARRAY OF CHAR);
BEGIN
  Concat(st,'\n');
  Concat(st,str);
END Add;
BEGIN
  Warn:=FALSE;
  (*$IF Test0 *)
    d(s("Main(gnr:INTEGER)"));
  (*$ENDIF *)
  SetUpMode:=0;
  Valg:=0;
  SetPtr(wptr,PTRgribe);
  Tx:=TRUE;
  IF gnr=103 THEN (* Ups! *)
    HelpNr:=40;
    stilling:=OldStilling;
  ELSE (* OK! *)
    (* sammenlign stilling med OldStilling *)
    n:=88;
    WHILE (n>10) & ((n MOD 10=0) OR (n MOD 10=9) OR (stilling[n]=OldStilling[n])) DO DEC(n) END;
    IF (n>10) OR (stilling[HvisTur]<>OldStilling[HvisTur]) OR (TraekNr=0) THEN (* så stilling ændret *)
(*$IF Test0 *)
  WRITELN(s('Main:rydspil'));
(*$ENDIF *)
      startSt:=start.Still;
      start.Still:=stilling;
      IF RydSpil(TRUE,FALSE) THEN
        
        FOR ch:=' ' TO 't' DO
          brk[ch]:=0;
        END;
        FOR n:=11 TO 88 DO
          ch:=stilling[n];
          IF (ch>=' ') & (ch<='t') THEN
            INC(brk[ch]);
          END;
        END;
        Special := (brk['T']=0) & (brk['R']=0) & (brk['B']=0) & (brk['E']=0) &
        (brk['K']=0) & (brk['M']=0) & (brk['S']=0) & (brk['L']=0) & (brk['D']=0);

(* ADVARSELS-CHECK BØR F.EKS. INDEHOLDE : 
   B+E>8, ODD(L1)=ODD(L2), E+Sort, E+/-1<>e, Skak+Hvid, K+1=k, R+K, M+T+T *)

        Copy(st,Q[TxKONTROLADVARSEL]^);
        IF Special THEN 
          Warn:=TRUE;
          Concat(st,Q[Ax01]^);
        ELSE
          IF brk['b']+brk['e']>8 THEN Warn:=TRUE; Add(Q[Ax02]^); END;
          IF brk['B']+brk['E']>8 THEN Warn:=TRUE; Add(Q[Ax03]^); END;
          IF (brk['m']>0) & (brk['r']<1) THEN Warn:=TRUE; Add(Q[Ax05]^); END;
          IF (brk['M']>0) & (brk['R']<1) THEN Warn:=TRUE; Add(Q[Ax04]^); END;
          IF (brk['k']>0) & (brk['r']>0) THEN Warn:=TRUE; Add(Q[Ax07]^); END;
          IF (brk['K']>0) & (brk['R']>0) THEN Warn:=TRUE; Add(Q[Ax06]^); END;
          IF brk['k']+brk['m']<1 THEN Warn:=TRUE; Add(Q[Ax08]^); END;
          IF brk['K']+brk['M']<1 THEN Warn:=TRUE; Add(Q[Ax09]^); END;
          IF brk['t']+brk['r']>2 THEN Warn:=TRUE; Add(Q[Ax10]^); END;
          IF brk['T']+brk['R']>2 THEN Warn:=TRUE; Add(Q[Ax11]^); END;
          IF brk['s']>2 THEN Warn:=TRUE; Add(Q[Ax12]^); END;
          IF brk['S']>2 THEN Warn:=TRUE; Add(Q[Ax13]^); END;
          IF brk['l']>2 THEN Warn:=TRUE; Add(Q[Ax14]^); END;
          IF brk['L']>2 THEN Warn:=TRUE; Add(Q[Ax15]^); END;
          IF brk['d']>1 THEN Warn:=TRUE; Add(Q[Ax16]^); END;
          IF brk['D']>1 THEN Warn:=TRUE; Add(Q[Ax17]^); END;
        END;
        IF Warn THEN
          IF SimpleWIN(ADR(st))=1 THEN END;
        END;
        HelpNr:=41;
        IF TxRet THEN
          IF TraekNr>0 THEN
            swp:=Spil^[0].Tekst;
            Spil^[0].Tekst:=Spil^[TraekNr].Tekst;
            Spil^[TraekNr].Tekst:=swp;
          END;
        ELSE
          IF Spil^[0].Tekst<>NIL THEN
            Deallocate(Spil^[0].Tekst);
          END;
        END;

        TraekNr:=0;
        MaxTraek:=0;
        MaxTeori:=0;
        StoreStilling(0,0);
      ELSE
        HelpNr:=40;
        stilling:=OldStilling;
        start.Still:=startSt;
      END; 
    ELSE
      HelpNr:=40;
    END;
  END;
  TxRet:=FALSE;
  CalcMunde;  (* and/or Dominans (only if ~MouthOff/DominansOn) *)
  EmptyMsg;
  Draw;
END Main;

(* Ryk.SetUp :
Hvis Valg=111..188,200..219 så sæt felt til det, ellers sæt Valg=gnr
*)

PROCEDURE Vaelg(gnr:CARDINAL); (* Gd 200-219 *)
VAR
  n:CARDINAL;
BEGIN
  (*$IF Test0 *)
    d(s("Vaelg(gnr:CARDINAL)"));  
  (*$ENDIF *)
  IF gnr=218 THEN
    HelpNr:=38;
    Valg:=0;
    SetPtr(wptr,PTRgribe);
  ELSE
    Valg:=gnr;
    HelpNr:=gnr/2-72; (* 28+(gnr-200) DIV 2) *)
    SetPtr(wptr,PTRgrebet);
  END;
  Draw;
END Vaelg;

PROCEDURE PscrL;
BEGIN
  HelpNr:=280;
  SetPtr(wptr,PTRsove);
  IF GetTextPGN(0) THEN
    rettetPGN:=TRUE;
(*$IF Test0 *)
  WRITELN(s('rettetPGN=T'));
(*$ENDIF *)
  END;
  SetPtr(wptr,PTRrestore);
  IF pgnWIN.Window<>NIL THEN
    PGNcomments; 
  END;
END PscrL;

VAR
  preparenarrator:BOOLEAN;

PROCEDURE InitS;
VAR
  X,Y,XY:INTEGER;
  error:LONGINT;
BEGIN
  (*$IF Test0 *)
    d(s('InitS'));
  (*$ENDIF *)
  still(stilling,'');

  (* Opret mikro teoribog flyttet til brain *)

  (* stilling hvor sort sætter mat med d4c2 *)
  (* 
  still(stilling,'R  DM  RBdB  BBB    B      B     b SSbL     b   b b   bbrsl mlsrS');
  *)
  FOR X:=1 TO 8 DO
    FOR Y:=1 TO 8 DO
      XY:=X+10*Y;
      Dominans[XY]:=' ';
      Mund[XY]:=' ';
      Select[XY]:=' ';
    END;
  END;
  (*$IF Test0 *)
    d(s('InitGW'));
  (*$ENDIF *)
  InitGW(wptr);

  (* System-Requesters (og req.library requesters) til programs vindue *) 
  oldwindowptr:=ProcessPtr(thisTask)^.windowPtr;
  ProcessPtr(thisTask)^.windowPtr:=wptr;


  preparenarrator:=FALSE;
  InitSay;
  LydTil:=~SpeakOff;
  IF SpeakOff THEN
    SetToggle(81,LydTil);
  END;
 
  IF TRUE OR ~SpeakOff THEN
    IF (pSp=NIL) THEN
      (*$IF Test0 *)
        d(s('pSp=NIL'));
      (*$ENDIF *)
      error:= PrepareNarrator();
      preparenarrator:=TRUE;
      IF error=0 THEN
        (* parameters: rate,pitch,mode,sex,vol,freq *)
        (* SetVoiceParams(-1,-1,-1,-1,-1,-1); *) (* change no parameters *)
      ELSE
        SetGad(81,FALSE);
        LydTil:=FALSE;
      END;
    END;
  END;
  DominansOn:=~GetToggle(79);
  DiskOn:=TRUE;
  TxRet:=FALSE;
  Tx:=TRUE;
  dir:='Problems/';
  FOR X:=0 TO MaxHalvTraek DO 
    Spil^[X].Tekst:=NIL; 
  END;
  StoreStilling(0,0);
  CalcMunde;  (* and/or Dominans (only if ~MouthOff/DominansOn) *)
  Draw;
END InitS;

PROCEDURE Xit;
BEGIN
  (*$IF Test0 *)
    d(s('Xit'));
  (*$ENDIF *)
  IF pSp<>NIL THEN 
    Mess.node.name:=NIL;
    PutMsg(pMp,ADR(Mess));
    WaitPort(pSp);
    pMess:=GetMsg(pSp);
    DeletePort(pSp);
  ELSE
    (*$IF Test0 *)
      d(s('CloseNarrator:'));
    (*$ENDIF *)
    IF preparenarrator THEN
      CloseNarrator; (* leave a tidy Amiga *)
    END;
  END;
END Xit;

(*$IF Test0 *)
PROCEDURE ReadLocaleFileT;
VAR
  n,m:INTEGER;
  filnavn:ARRAY[0..32] OF CHAR;
  st:ARRAY[0..4096] OF CHAR;
  lfil:File;
  ch:CHAR;
  n2:INTEGER;
  oldm:ADDRESS;
  lstr:LONGINT;
BEGIN
  Copy(filnavn,'LOCALE');
(*$IF Test *)
  WRITELN(s('ReadLocaleFileT "')+s(filnavn)+s('"'));
(*$ENDIF *)
  IF filnavn[0]<>0C THEN 
    Lookup(lfil,filnavn,4096,FALSE);
    m:=0;
(*$IF Test *)
  WRITELN(s('LU'));
(*$ENDIF *)
    IF lfil.res=done THEN

      WHILE ~lfil.eof & (lfil.res=done) & (m<=MaxTxts) DO
        (* læs til ikke tom ikke-kommentar linie er indlæst *)
        REPEAT
(*
          n2:=0;
          ch:=0C;
          WHILE ~lfil.eof & (lfil.res=done) & (ch<>12C) & (n2<SIZE(st)) DO
            ReadChar(lfil,ch);
            st[n2]:=ch;
            INC(n2);
          END;
          WHILE (n2>0) & (st[n2-1]<' ') DO
            DEC(n2);
          END;
          st[n2]:=0C;
*)
          ReadString(lfil,st);
(*$IF Test *)
WRITELN(s(st));
(*  FOR n:=0 TO n2-1 DO
      WRITE(c(st[n]));
    END;
    WRITELN(0);*)
(*$ENDIF *)
        UNTIL lfil.eof OR (lfil.res#done) OR (st[0]#';') & (st[0]#0C);
        (* konverter \ til linefeed: *)

        n:=0;
        WHILE (n<SIZE(st)) & (st[n]<>0C) DO
          IF st[n]='\\' THEN
            st[n]:=12C;
          END;
          INC(n);
        END;
        
        IF (lfil.res=done) & ~lfil.eof & (m#DemoMessage) & (m#LAERSKAK) & (st[0]<>':') THEN
          lstr:=Length(st);
          IF (lstr>0) & ((m<>PIECES) OR (lstr>17)) THEN
            oldm:=Q[m];
            Q[m]:=NIL;
            Allocate(Q[m],lstr+1);
            IF Q[m]<>NIL THEN
(*$IF Test *)
  WRITELN(s('A: "')+s(st)+s('"'));
(*$ENDIF *)

              (*Copy(Q[m]^,st);*)

              FOR n:=0 TO lstr-1 DO
                Q[m]^[n]:=st[n];
              END;
              Q[m]^[lstr]:=0C;

              IF m=PIECES THEN
                Txr:=Q[PIECES]^[0];
                Txt:=Q[PIECES]^[1];
                Txs:=Q[PIECES]^[2];
                Txl:=Q[PIECES]^[3];
                Txd:=Q[PIECES]^[4];
                Txm:=Q[PIECES]^[5];
                Txk:=Q[PIECES]^[6];
                Txe:=Q[PIECES]^[7];
                Txb:=Q[PIECES]^[8];
                TxR:=Q[PIECES]^[9];
                TxT:=Q[PIECES]^[10];
                TxS:=Q[PIECES]^[11];
                TxL:=Q[PIECES]^[12];
                TxD:=Q[PIECES]^[13];
                TxM:=Q[PIECES]^[14];
                TxK:=Q[PIECES]^[15];
                TxE:=Q[PIECES]^[16];
                TxB:=Q[PIECES]^[17];
              END;
            ELSE
              Q[m]:=oldm;
            END;
          END;
  (*$IF Test *)
    WRITELN(s('m=')+l(m)+s(' st=')+s(st));
    IF (m=210) & (Q[m]<>NIL) THEN
      WRITELN(s('ReadQ210="')+s(Q[m]^)+s('"'));
    END;
  (*$ENDIF *)
        END;
        INC(m);
      END;
      Close(lfil);
(*$IF Test *)
  WRITELN(s('CLOSED. ')+s(st));
(*$ENDIF *)
    END;
  END;
END ReadLocaleFileT;
(*$ENDIF *)

PROCEDURE Init;
BEGIN
  IF InitSprog(0) THEN END;
  (*ReadLocaleFileT;*)
  InitS;
  txtOK  :=ADDRESS(Q[TxOK]);
  txtUPS :=ADDRESS(Q[TxUPS]);
  txtDROP:=ADDRESS(Q[TxMID]);

  (*SetGad(246,FALSE);*)
  swptr:=sptr;
(*
  IF (swptr=NIL) THEN
    OK:=TwoGadWIN(ADDRESS(ADR('1.NIL!!')))=1;
  END;
*)

  CREATEWIN(remWIN,FALSE,FALSE,FALSE,FALSE);
  CREATEWIN(pgnWIN,FALSE,FALSE,FALSE,FALSE);
  CREATEWIN(hlpWIN,FALSE,FALSE,FALSE,FALSE);

  Push:=FALSE;
  SetPtr(wptr,PTRgribe);
END Init;
(*
VAR
  iorq:IORequest;
*)

BEGIN
(*$IF Test *)
  WRITELN(s('SkakAlt.1'));
(*$ENDIF *)
    (*$IF Test0 *)
      IF InterOn THEN d(s('InterOn=TRUE'));ELSE d(s('InterOn=FALSE'));END;
    (*$ENDIF *)
(*LogVersion("SkakAlt.def",SkakAltDefCompilation);*)
  LogVersion("SkakAlt.mod",SkakAltModCompilation);
  FirstMoveInfo:=TRUE;
  FirstHelp:=TRUE;
  remFirst:=TRUE;
  pgnFirst:=TRUE;
  Statistic:=FALSE;
  Running:=FALSE;
  Debug:=TRUE;
  Icon:=FALSE;
  MaxTraek:=0;
  VarSpilPtr:=NIL;
  Special:=FALSE;
  TraekNr:=0;
  HelpNr:=0;
  SneakCount:=0;
  dyb:=1;
  dybx:=1;
  PigPigMode:=-1; (* Defaults to no ECO or NIC key generation when F3 (PIGtilPIG) *) 
  Name20[0]:=0C; 
  dir20[0]:=0C;
  Name30:='PIGbase4.theory';
  dir30:='';
  EVA:=3;
(*
OpenDevice(ADR("console.device"),-1,ADR(iorq),LONGSET{});
*)


  Vql:=ql; Vqb:=qb;
  Vqc:=qc; Vqd:=qd;
  Vqf:=qf; Vqa:=qa;
  Vqx:=qx; Vqt:=qt;
  Vqv:=qv;
  Vqn:=qn; Vqp:=qp;
  Vqr:=qr;
  Vqh:=qh; Vqz:=qz;
  Vqj:=qj;
  Bruger:=BrugerC;
(*$IF Test *)
  WRITELN(s('SkakAlt.2'));
(*$ENDIF *)
CLOSE
(*$IF Test *)
  WRITELN(s('SkakAlt.3'));
(*$ENDIF *)
  ProcessPtr(thisTask)^.windowPtr:=oldwindowptr; (* ALTID *)
  Xit;
(*$IF Test *)
  WRITELN(s('SkakAlt.4'));
(*$ENDIF *)
END SkakAlt.

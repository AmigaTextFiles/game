IMPLEMENTATION MODULE Skak; (* Lær-Skak, (c) E.B.Madsen DK 91-95, Rev 7/1-96 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Demo:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)
(*$ DEFINE False:=FALSE *)

(*$ DEFINE TestS:=FALSE *)
(*$ DEFINE Quick:=FALSE *)

(*$ LongAlign:=TRUE StackParms:=FALSE CStrings:=TRUE LargeVars:=FALSE *)

(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=FALSE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=FALSE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT
  ADR, ADDRESS, ASSEMBLE, CAST, BPTR, BYTE, LONGSET;
FROM Arts IMPORT
  thisTask;
FROM Heap IMPORT
  Allocate, Deallocate;
FROM String IMPORT
  Copy, Concat;
FROM Conversions IMPORT
  StrToVal;
FROM DosD IMPORT
  ProcessPtr;
FROM DosL IMPORT
  Delay;
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
  Delete, Response, ReadChar, WriteChar, GetPos, SetPos;
IMPORT FileSystem;
FROM Console IMPORT RawKeyConvert;
FROM InputEvent	IMPORT InputEvent,InputEventPtr,Class;
FROM IntuitionD IMPORT
  boolGadget, stdScreenHeight, GadgetPtr, IDCMPFlagSet, IDCMPFlags,
  IntuiMessagePtr, WindowPtr, WindowFlags, WindowFlagSet, strGadget, propGadget,
  PropInfoPtr, StringInfoPtr, IntuiText, gadgHNone, IntuiTextPtr, GadgetFlags,
  selectUp;
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
(*$IF Test OR TestS *)
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
  FLAGARR,gIC,LLSIZE,gFlags,gInverse, Lates3, TFra, TTil, L1b;

FROM SkakScreen IMPORT
  InitGW, ReDraw, Refresh, SetOpNed, GetToggle, SetToggle, GetText, RG,
  GetTextPGN, ListPick, Config,
  kHome,kEnd ,kPgUp,kPgDn,kHelp,kUp  ,kDn  ,kRt  ,kLt  ,kUpN ,kDnN ,kRtN ,
  kLtN ,kF1  ,kF2  ,kF3  ,kF4  ,kF5  ,kF6  ,kF7  ,kF8  ,kF9  ,kF0  ,kCr  ,
  kCrN ,kNumL,kScrL,kSyRq,kPrSc,kEsc, MOVEINFOSTRING, SavePalette,
  SetGad,SetGadImage,
  ttINTERNATIONAL,ttLONGFORMWRITE,ttMOUTHOFF,ttLOTMEMON,ttNOAUTOPGN,ttQUICK
;
FROM SkakBrain IMPORT
  DoMoveOk, TRKDATA, Push, stilling, MOVETYPES,MOVEnormal,MOVEslag,
  Spil, SPIL, STRING, MaxHalvTraek, AddHistory, ClearHistory,
  ATTRTYPES, ATTRTYPE,
  GameStartSeconds, GameStartMicros, MoveStartSeconds, MoveStartMicros
;
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
  Q211,Q212,Q213,Q214,Q217,Q218,Qwantmemory, DoubleSelect,Rev
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

FROM SkakAlt IMPORT
  AdjustTilForUnder, StoreStilling, Brain, SetKeys, teoPRT, Draw,
  Flyt, Flyt4, Help, Comments, PscrL, SetupVindue, TeoriWindow, Hent20First,
  Hent20Next, Hent20Nxt, HvidSortTur, Kopi20, LydFraTil, OpNed,
  PGNcomments, PGNtilPIG, PIGtilPGN, PIGtilPIG, Styrke, ToA, ToggleMarked,
  Tom, ToNormal, Udgang, Vaelg, VariantTgl, Sig, MVINFO, FullRefresh,
  ReCalcTeo, Person, DiskFraTil, DomiFraTil, Farver, Gem20, Marker20,
  CatGame, AutoPGNtilPIG, Hent, Gem, Opsaet, Restore, Main,

  dyb, dybx, OldStilling, sv, ret, TxRet, Tx, HvidsTur, LydTil, PilNede,
  Stop, Abort, OK, Icon, Pgad, gad,  Pclass, class,  mcode,  msg,  gnr,
  SneakCount, Bruger, Special, oldwindowptr, dir20, dir30, CFraLine,
  CFilPos, hentfil, Statistic, FPtxt, EVA, PigPigMode, AEM, EmptyMsg,
  TeoLoad,  TeoLoading,  TeoNotCompLoad,  TeoSave,  TeoSaving,  TeoNotCompSave,
  TeoNotCompAdd,  TeoSearch,  TeoRecalc,  TeoAdded,  TeoNotGamAdd, TeoSpaces,
  Vql,Vqb,Vqc,Vqd,Vqf,Vqa,Vqx,Vqt,Vqv,Vqn,Vqp,Vqr,Vqh,Vqz,Vqj, Sneaks,
  PIGtilSKEMA, Init;

CONST
  SkakModCompilation="825";
  kQ=10H; (**)
  kW=11H; (* WRITE *)
  kE=12H; (* ECO key*)
  kR=13H; (* READ *)
  kT=14H; (* ToA *)
  kY=15H; (* VARIANT *)
  kU=16H; (* UP/DOWN BOARD*)
  kI=17H; (**)
  kO=18H; (**)
  kP=19H; (**)
  kAA=1AH;(**)
  kA=20H; (**)
  kS=21H; (* SAVE *)
  kD=22H; (**)
  kF=23H; (**)
  kG=24H; (**)
  kH=25H; (**)
  kJ=26H; (**)
  kK=27H; (* KEYS (ECO+NIC) *)
  kL=28H; (* LOAD *)
  kAE=29H;(**)
  kOE=2AH;(**)
  kZ=31H; (**)
  kX=32H; (**)
  kC=33H; (**)
  kV=34H; (**)
  kB=35H; (**)
  kN=36H; (* NIC key*)
  kM=37H; (* Make Table*)

  DemoMax=600; (* også defineret i SkakAlt.mod og SkakFil, about line 1815 *)
               (* MaxHalvTraek er p.t. 600 *)
PROCEDURE PopMsg():BOOLEAN;
VAR
  msg  :IntuiMessagePtr;
BEGIN
  IF ~Push THEN 
    msg:=GetMsg(wptr^.userPort);
    IF msg=NIL THEN RETURN(FALSE) END; 
    Pclass:=msg^.class;
    Pgad  :=msg^.iAddress;
    mcode :=msg^.code;
    ReplyMsg(msg);
    Push:=TRUE;
  END;
  RETURN(TRUE);
END PopMsg;

PROCEDURE Ryk(gptr:GadgetPtr; gnr:INTEGER); (* Gd 111-188 *)
VAR
  blk:BOOLEAN;
  tgn,tgn2,cfra,ctyp,c6,c7:CHAR;
  VNr,tf,tt,n,fra,til,wx,wy,xf,xt,xh,yf,yt,yh,Colr:INTEGER;
  ok:BOOLEAN;
  Trk,Traek:TRKDATA;
  Secs,Micros:LONGINT;

(*$IF Test *)
  MN,MN2:CARDINAL;
(*$ENDIF *)

BEGIN
  IF gptr<>NIL THEN
    wx:=wptr^.mouseX;
    wy:=wptr^.mouseY;
    gnr:= gptr^.gadgetID;
  END;
  VNr:=Valg;
  (*$IF Test0 *)
    d(s("Ryk()"));
  (*$ENDIF *)
  IF SetUpMode=1 THEN
    fra:=0;
    ok:=TRUE;
    IF (VNr>110) AND (VNr<189) THEN
      blk:=FALSE;
      tgn:=stilling[VNr-100];
      IF gnr<>VNr THEN
        fra:=VNr-100;
      END;
      Valg:=0;
      SetPtr(wptr,PTRgribe);
    ELSE
      blk:=ODD(VNr);
      IF blk THEN DEC(VNr) END;
      CASE VNr OF 
        | 200: tgn:='m';
        (*$ IF Demo *)
        n:=SimpleWIN(ADDRESS(Q[DemoMessage]));
        (*$ ENDIF *)
        | 202: tgn:='k';
        (*$ IF False *)
        n:=SimpleWIN(ADDRESS(Q[DemoMessage]));
        (*$ ENDIF *)
        | 204: tgn:='d';
        | 206: tgn:='r';
        | 208: tgn:='t';
        | 210: tgn:='l';
        | 212: tgn:='s';
        | 214: tgn:='e';
        | 216: tgn:='b';
        | 218: tgn:=' ';
      ELSE
        VNr:=gnr;
        Valg:=gnr;
        IF Valg=0 THEN SetPtr(wptr,PTRgribe) ELSE SetPtr(wptr,PTRgrebet) END;
      END;
    END;
    IF VNr<>gnr THEN
      IF blk THEN tgn:=CAP(tgn) END;
      til:=gnr-100;
      IF (tgn='e') THEN
        IF (til>48) OR (til<41) THEN 
          tgn:='b';
        ELSE
          FOR n:=41 TO 48 DO
            IF stilling[n]='e' THEN stilling[n]:='b' END;
          END;
        END;
      END;
      IF (tgn='E') THEN
        IF (til>58) OR (til<51) THEN 
          tgn:='B';
        ELSE
          FOR n:=51 TO 58 DO
            IF stilling[n]='E' THEN stilling[n]:='B' END;
          END;
        END;
      END;
      IF (tgn='b') & (til>78) THEN tgn:='d' END;
      IF (tgn='B') & (til<21) THEN tgn:='D' END;
      IF (tgn='m') & (til<>15) THEN
        tgn:='k';
        (*$ IF False *)
        n:=SimpleWIN(ADDRESS(Q[DemoMessage]));
        (*$ ENDIF *)
      END;
      IF (tgn='M') & (til<>85) THEN
        tgn:='K';
        (*$ IF False *)
        n:=SimpleWIN(ADDRESS(Q[DemoMessage]));
        (*$ ENDIF *)
      END;
      IF (tgn='m') OR (tgn='k') THEN
        (*$ IF Demo *)
        IF tgn='m' THEN n:=SimpleWIN(ADDRESS(Q[DemoMessage])); END;
        (*$ ENDIF *)
        FOR n:=11 TO 88 DO
          IF (stilling[n]='k') OR (stilling[n]='m') THEN stilling[n]:=' ' END;
        END;
      END;
      IF (tgn='M') OR (tgn='K') THEN
        (*$ IF Demo *)
        IF tgn='M' THEN n:=SimpleWIN(ADDRESS(Q[DemoMessage])); END;
        (*$ ENDIF *)
        FOR n:=11 TO 88 DO
          IF (stilling[n]='K') OR (stilling[n]='M') THEN stilling[n]:=' ' END;
        END;
      END;
      IF (tgn='r') & (til<>11) & (til<>18) THEN tgn:='t' END;
      IF (tgn='R') & (til<>81) & (til<>88) THEN tgn:='T' END;
      IF ((tgn='b') OR (tgn='B')) & ((til>78) OR (til<21)) THEN ok:=FALSE END;
      IF ok THEN
        IF fra>0 THEN stilling[fra]:=' ' END;
        stilling[til]:=tgn;
      END;
    END;
  ELSE  (* not SetUp *)
    (*$ IF Demo *)
    IF TraekNr>DemoMax THEN 
      n:=SimpleWIN(ADDRESS(Q[DemoMessage]));
      VNr:=999;
    END;     
    (*$ ENDIF *)
    IF (VNr>110) AND (VNr<189) THEN
      IF VNr=gnr THEN
        Valg:=0;
        SetPtr(wptr,PTRgribe);
      ELSE (* udfør træk *)
(*$IF Test0 *)
  WRITELN(s('Ryk:rydspil'));
(*$ENDIF *)
        IF (TraekNr=MaxTraek) OR VariantTil OR RydSpil(FALSE,FALSE) THEN
          Traek.Fra:=VNr-100;
          Traek.Til:=gnr-100;
(*$IF Test0 *)
  WRITELN(s('2. Fra=')+l(Traek.Fra)+s(' Til=')+l(Traek.Til));
(*$ENDIF *)

          IF stilling[Traek.Til]=' ' THEN
            Traek.Typ:=MOVEnormal;
            ctyp:='-';
          ELSE
            Traek.Typ:=MOVEslag;
            ctyp:='x';
          END;
          c6:=' ';
          c7:=' ';

(*$IF Test0 *) (* IMPORT GetMoveNr fra SkakBrain *)
  GetMoveNr(stilling,Traek.Fra,Traek.Til,MN,FALSE);
  GetMoveNr(stilling,Traek.Fra,Traek.Til,MN2,TRUE);
(*$ENDIF *)

          IF (gptr<>NIL) & (CAP(stilling[Traek.Fra])='B') & ((gnr<119) OR (gnr>180))
          THEN (* bonde forvandling, Underforvandling *)
            IF stilling[Traek.Fra]='b' THEN
              Colr:= 1;
            ELSE
              Colr:=-1;
            END;
            WITH gptr^ DO
              xf:=leftEdge;
              xt:=leftEdge+width-1;
              xh:=width DIV 2;
              yf:=topEdge;
              yt:=topEdge+height-1;
              yh:=height DIV 2;      
            END;
            IF wx>xf+xh THEN (* Tårn eller Løber underforvandling *)
              IF wy>yf+yh THEN (* Løber *)
(*$IF Test0 *)
  WRITELN(s('Ryk:Løber'));
(*$ENDIF *)
                Traek.Til:=Traek.Til-40*Colr;
              ELSE (* Tårn *)
(*$IF Test0 *)
  WRITELN(s('Ryk:Tårn'));
(*$ENDIF *)
                Traek.Til:=Traek.Til-20*Colr;
              END;
            ELSE (* Dronning eller Springer underforvandling *)
              IF wy>yf+yh THEN (* Springer *)
(*$IF Test0 *)
  WRITELN(s('Ryk:Springer'));
(*$ENDIF *)
                Traek.Til:=Traek.Til-30*Colr;
              ELSE (* Dronning *)
(*$IF Test0 *)
  WRITELN(s('Ryk:Dronning'));
(*$ENDIF *)
              END;
            END; 
          END;

          tf:=Traek.Fra;
          tt:=Traek.Til;
          Trk:=Traek;
          cfra:=stilling[tf];

          AddHistory(stilling,tf,tt,0);

          ok:=DoMoveOk(stilling,tf,tt,Trk.Typ);
          IF ok THEN


(*            n:=AdjustTilForUnder(tf,tt,cfra);*)

(*$IF Test0 *)
  d(lf(Traek.Fra,2)+s('-')+lf(Traek.Til,2)+lf(Traek.Vlu,5)+s(', MN,MN2=')+l(MN)+s(',')+l(MN2)+s('  '));
(*$ENDIF *)
            IF Trk.Typ=MOVEnormal    THEN
              (*$IF Test0 *) d(s('Normal'));    (*$ENDIF *)
            END;
            IF slag IN Trk.Typ THEN
              (*$IF Test0 *) d(s('slag'));      (*$ENDIF *)   Sig(Q[TxHAPS]^);     ctyp:='x';
            END;
            IF enpassant IN Trk.Typ THEN
              (*$IF Test0 *) d(s('EnPassant')); (*$ENDIF *)   Sig(Q[TxENPASSANT]^);c6:='e';c7:='p';ctyp:='x';
            END;
            IF rokade IN Trk.Typ THEN
              (*$IF Test0 *) d(s('Rokade'));    (*$ENDIF *)   Sig(Q[TxROKADE]^);
            END;
            IF pat IN Trk.Typ THEN
              (*$IF Test0 *) d(s('pat'));       (*$ENDIF *)   Sig(Q[TxPATREMIS]^); c6:='-';c7:='-';
            END;
            IF skak IN Trk.Typ THEN
              (*$IF Test0 *) d(s('skak'));      (*$ENDIF *)   Sig(Q[TxSKAK]^);     c6:='+';
            END;
            IF mat IN Trk.Typ THEN
              (*$IF Test0 *) d(s('mat'));       (*$ENDIF *)   Sig(Q[TxSKAKMAT]^);  c6:='+';c7:='+';
            END;
            Tx:=TRUE;
            Valg:=0;
            IF TraekNr<MaxHalvTraek THEN
(*$IF Test0 *)
  WRITELN(s('Ryk.rettetSPIL=T'));              
(*$ENDIF *)
              IF ~VariantTil THEN rettetSPIL:=TRUE END;
              INC(TraekNr);
              MaxTraek:=TraekNr;

              (* set the clock *)
              Secs   := MoveStartSeconds;
              Micros := MoveStartMicros;
              CurrentTime(ADR(MoveStartSeconds),ADR(MoveStartMicros));
              IF TraekNr=1 THEN
                GameStartSeconds:=MoveStartSeconds;
                GameStartMicros :=MoveStartMicros;
                Secs  := MoveStartSeconds;
                Micros:= MoveStartMicros;
                (*$IF Test *)
                  WRITE(s("GameStart by player s=")+l(Secs));
                (*$ENDIF *)
              END;
              IF MoveStartSeconds<Secs THEN
                Spil^[TraekNr].Secs:=0;
              ELSIF MoveStartSeconds-Secs<65535 THEN
                Spil^[TraekNr].Secs:=CARDINAL(MoveStartSeconds-Secs);
              ELSE
                Spil^[TraekNr].Secs:=65535;
              END;
              Spil^[TraekNr].Attribs:=ATTRTYPE{man};

              IF TraekNr<MaxTeori THEN
                MaxTeori:=TraekNr;
              END;
              SetPtr(wptr,PTRgribe);
              IF Spil^[MaxTraek].Tekst<>NIL THEN
                rettetREM:=TRUE;
                Deallocate(Spil^[MaxTraek].Tekst);
              END;
              StoreStilling(Traek.Fra,Traek.Til);
              MVINFO(cfra,ctyp); (* 0 , 3 *)
              CASE cfra OF
                | 'b','B','e','E' : cfra:=' ';
                | 'm','M'         : cfra:='K';
                | 'r','R'         : cfra:='T';
              ELSE
              END;
              MOVEINFOSTRING[0]:=LP(CAP(cfra));
(*            MOVEINFOSTRING[3]:=ctyp;*)
              IF MOVEINFOSTRING[6]=' ' THEN (* ikke forvandling *)
                MOVEINFOSTRING[6]:=c6;            
                MOVEINFOSTRING[7]:=c7;
              END;
(*$IF Test0 *)
  WRITELN(s('MVIS=')+s(MOVEINFOSTRING));
(*$ENDIF *)
            END;
            CalcMunde; (* and/or Dominans (only if ~MouthOff/DominansOn) *)
(*$IF Test *) WRITELN(s('Ryk: kalder Brain...')); (*$ENDIF *)
            Brain;
(*$IF Test *) WRITELN(s('Ryk: kaldt Brain.')); (*$ENDIF *)
          ELSE
            ClearHistory(1,stilling[HvisTur]='S'); (* undo AddHistory *)
          END;
        ELSE (* ~RydSpil *)
        END;
        IF (TraekNr=15) THEN
          SetKeys;
        END;
      END;
    ELSE
      IF VNr<>999 THEN (* 999= Demo,>30 *)
        tgn:=stilling[gnr-100];
        IF Special THEN
          stilling[HvisTur]:='H';
        END;  (* !!!!!!!!!!!!!! *)
        IF stilling[HvisTur]='H' THEN
          IF tgn<>CAP(tgn) THEN
            IF MarkMoves(gnr-100)>0 THEN
              Valg:=gnr;
              SetPtr(wptr,PTRgrebet);
            ELSE
              Sig(Q[TxDENKANIKKERYKKES]^);
            END;
          ELSE
            Sig(Q[TxHVIDSTUR]^);
          END;
        ELSE
          IF (tgn<>' ') AND (tgn=CAP(tgn)) THEN
            IF MarkMoves(gnr-100)>0 THEN
              Valg:=gnr;
              SetPtr(wptr,PTRgrebet);
            ELSE
              Sig(Q[TxDENKANIKKERYKKES]^);
            END;
          ELSE
            Sig(Q[TxSORTSTUR]^);
          END;
        END;
      END;
    END;
  END;
  teoPRT;
  Draw;
  CASE CAP(stilling[gnr-100]) OF
    | 'M' : HelpNr:=28;
    | 'K' : HelpNr:=29;
    | 'D' : HelpNr:=30;
    | 'R' : HelpNr:=31;
    | 'T' : HelpNr:=32;
    | 'L' : HelpNr:=33;
    | 'S' : HelpNr:=34;
    | 'E' : HelpNr:=35;
    | 'B' : HelpNr:=36;
    | ' ' : HelpNr:=37;
  END;
END Ryk;

PROCEDURE DoWIN(VAR WIN:VINDUE);
VAR
  wn,X,n,m,fra,til:INTEGER;
  dv:LONGINT;
  G:GadgetPtr;
  strptr:STRINGPTR;
  dvs:ARRAY[0..8] OF CHAR;
  Sign,err,rettetSPILold:BOOLEAN;
  res:CARDINAL;
  hst:ARRAY[0..100] OF CHAR;
BEGIN
  IF WIN.Window<>NIL THEN
    REPEAT
      wn:=MSGWIN(WIN,FALSE);
      IF (wn=0) OR (wn=1) THEN
        CLOSEWIN(WIN);
      ELSE
        IF wn=ActiveWIN THEN
          ActivateWindow(wptr);
        END;
        IF (wn>=100) & (wn<=106) THEN (* setWIN *)
          G:=WIN.Gadgets;
          WHILE (G<>NIL) & (G^.gadgetID<>wn) DO
            G:=G^.nextGadget;
          END;
          IF wn=100 THEN
            InterOn:=GetToggl(G);
          ELSIF wn=101 THEN
            IF GetToggl(G) THEN LongFormOn:='L' ELSE LongFormOn:='S' END;
          ELSIF wn=102 THEN
            MouthOff:=GetToggl(G);
            CalcMunde; (* and/or Dominans (only if ~MouthOff/DominansOn) *)
            IF MouthOff THEN
              FOR X:=11 TO 88 DO
                Mund[X]:=' '; (* (sur) A,F,L,R,Z (Glad) *)
              END;
              FullRefresh;
            ELSE            
              Draw;
            END;
          ELSIF wn=103 THEN
            LotMemOn:=GetToggl(G);
          ELSIF wn=104 THEN
            NoAutoPGN:=GetToggl(G);
          ELSIF wn=105 THEN
            Quick:=GetToggl(G);
          ELSIF wn=106 THEN
            IF GetToggl(G) THEN
              Lates3:=1;
            ELSE
              Lates3:=0;
            END;
          END;
          ActivateWindow(wptr);
        END;
        IF (wn>=108) & (wn<=151) THEN (* teoWIN *)
          G:=WIN.Gadgets;
          WHILE (G<>NIL) & (G^.gadgetID<>wn) DO
            G:=G^.nextGadget;
          END;
          IF    wn=108 THEN (* DrawValues-White *)
(*$IF Test0 *)
 d(s('SDW'));
(*$ENDIF *)
            GetString(G,dvs);
            StrToVal(dvs,dv,Sign,10,err);
            IF (dv>99) THEN dv:=100 END;
            IF (dv<1) THEN dv:=0 END;
            IF err THEN dv:=50 END;
            SetDrawWhite(dv);
          ELSIF wn=109 THEN (* DrawValues-Black *)
(*$IF Test0 *)
 d(s('SDB'));
(*$ENDIF *)
            GetString(G,dvs);
            StrToVal(dvs,dv,Sign,10,err);
            IF (dv>99) THEN dv:=100 END;
            IF (dv<1) THEN dv:=0 END;
            IF err THEN dv:=50 END;
            SetDrawBlack(dv);
          ELSIF wn=110 THEN (* Theory-Load *)
            SetPtr(wptr,PTRsove);
            IF simpleFileRequester2(Q[TeoLoad]^,Name30,path30,dir30) THEN
              Copy(hst,TeoSpaces); Concat(hst,Q[TeoLoading]^); Concat(hst,TeoSpaces);
              PRINTWIN(teoWIN,4,120,ADR(hst),2,0);
              res:=LoadTeori(path30);
              IF (res>3) THEN
                SetPGNinfos;
                IF res<5 THEN
                  IF SimpleWIN(ADR(Q[TeoNotCompLoad]^))=1 THEN END;
                END;
              END;
            END;
            SetPtr(wptr,PTRrestore);
          ELSIF wn=111 THEN (* Theory-Save *)
            SetPtr(wptr,PTRsove);
            IF simpleFileRequester2(Q[TeoSave]^,Name30,path30,dir30) THEN
              Copy(hst,TeoSpaces); Concat(hst,Q[TeoSaving]^); Concat(hst,TeoSpaces);
              PRINTWIN(teoWIN,4,120,ADR(hst),2,0);
  (*$IF Demo *)
      IF SimpleWIN(ADDRESS(Q[DemoMessage]))=0 THEN END;
      path30[0]:='_'; (* prevents saves when more than 10000 nodes *)
  (*$ENDIF *)
              res:=SaveTeori(path30);
              IF (res<5) & (SimpleWIN(ADR(Q[TeoNotCompSave]^))=1) THEN END;
            END;

            SetPtr(wptr,PTRrestore);
          ELSIF wn=112 THEN (* Theory-New *)
            ClrTeori;
          ELSIF wn=113 THEN (* Position-Delete *)
            DeletePosMove(23,43);
          ELSIF wn=114 THEN (* Eval method *)
            Statistic:=GetToggl(G);
            ReCalcTeo(Statistic);
          ELSIF wn=115 THEN (* Spare *)
          ELSIF wn=116 THEN (* Spare *)
          ELSIF wn=117 THEN (* Game-Analyze *)
            FPtxt:=FindPosition();
            IF SimpleWIN(FPtxt)=1 THEN END;
          ELSIF wn=118 THEN (* Game-Add *)
            IF EVA=3 THEN
              res:=AddGame(StrToVlu(gExtras[gResult]),FALSE);
            ELSE
              res:=AddGame(EVA,FALSE);
            END;
            IF res<5 THEN
              IF SimpleWIN(ADDRESS(Q[TeoNotCompAdd]))=1 THEN END;
            END;
            ReCalcTeo(Statistic);
          ELSIF (wn>119) & (wn<131) THEN
(*$IF Test0 *)
 d(s('120-130: ')+l(wn));
(*$ENDIF *)
  (*$IF False *)
      IF (wn>125) & (SimpleWIN(ADDRESS(Q[DemoMessage]))=0) THEN END;
  (*$ENDIF *)
            n:=117;
            m:=0;
            strptr:=NIL;
            WHILE (n<wn) & (FPtxt^[m]<>0C) DO
              IF FPtxt^[m]=12C THEN
                INC(n);
                strptr:=ADR(FPtxt^[m+1]);
              END;
              INC(m);
            END;
            IF (strptr<>NIL) & (strptr^[2]>='a') & (strptr^[2]<='h') THEN (* make the move *)
              fra:=ORD(strptr^[2])-96+10*(ORD(strptr^[3])-48);
              til:=ORD(strptr^[5])-96+10*(ORD(strptr^[6])-48);
(*$IF Test0 *)
 d(c(strptr^[1])+c(strptr^[2])+c(strptr^[3])+c(strptr^[4])+c(strptr^[5])+c(strptr^[6]));
 d(l(fra)+c('-')+l(til));
(*$ENDIF *)
              IF (fra>10) & (til>10) & (fra<89) & (til<89) THEN
                Valg:=0;
                rettetSPILold:=rettetSPIL;
                SetPGNinfos;
                Ryk(NIL,fra+100);
                Ryk(NIL,til+100);
                rettetSPIL:=rettetSPILold;                
              END;
            END;
          ELSIF (wn>=133) & (wn<=151) THEN
            EVA:=wn-130;
(*$IF Test0 *)
 d(s('EVA: ')+l(EVA));
(*$ENDIF *)
          END;
          teoPRT;
          ActivateWindow(wptr);
        END; 
      END;
    UNTIL wn<0;
  ELSIF ADR(WIN)=ADR(teoWIN) THEN
    TFra:=0; TTil:=0;
  END;
END DoWIN;

VAR
  MovIt:BOOLEAN;
  MovGad:GadgetPtr;

PROCEDURE AEMproc; (* Active Event Monitor *)
VAR
  msg  :IntuiMessagePtr;
  gnr  :INTEGER;
BEGIN
  (*$IF Test0 *)
 WRITELN(s('AEM'));
  (*$ENDIF *)
  (*$IF Test0 *)
(* d(s('AEM:teo'));*)
  (*$ENDIF *)
    MVINFO(0C,'-'); (* to update the clock *)
    msg:=GetMsg(wptr^.userPort);    (* overfør msg-class og evt. gadget ptr*)
    IF msg<>NIL THEN
      Pclass :=msg^.class; (*IDCMPFlags*) (* til egne variable class, gad*)
      Pgad   :=msg^.iAddress;
      ReplyMsg(msg);                      (* returner/frigør message *)
      IF inactiveWindow IN Pclass THEN      (* eksekver den/de? modtagede messages *)
        (* wptr^.userPort^.msgList.head<>NIL *)
        DoWIN(remWIN);
        DoWIN(pgnWIN);
        DoWIN(hlpWIN);
        IF ~SetFirst THEN DoWIN(setWIN) END;
        IF ~TeoFirst THEN DoWIN(teoWIN) END;
      END;
      IF activeWindow IN Pclass THEN      (* eksekver den/de? modtagede messages *)
  (*$IF Test0 *)
 WRITELN(s('AEM:AW'));
  (*$ENDIF *)
      END;
      IF refreshWindow IN Pclass THEN     (* kun ved simplerefresh vindue *)
        Refresh(stilling,Dominans,Mund,Select);
      END;
      IF closeWindow IN Pclass THEN
        Push:=TRUE;
      END;

      IF rawKey IN class THEN
        mcode:=msg^.code;
        IF mcode=kHelp THEN
          Help;
        ELSIF mcode=kNumL THEN
          PGNcomments;
        ELSIF mcode=kSyRq THEN
          SetupVindue;
        ELSIF mcode=kPrSc THEN
          TeoriWindow;
        ELSIF (* (mcode=kCr) OR *) (mcode=kCrN) THEN
          Comments;
        ELSIF mcode=kEsc THEN
          Push:=TRUE;
        ELSE 
        END;
      END;

      IF gadgetUp IN Pclass THEN
        gnr:= Pgad^.gadgetID;
        CASE gnr OF
            (*styp,Hent,Gem,Opsaet,Udgang,Flyt*)
          |  30            : IF stilling[HvisTur]='S' THEN Push:=TRUE ELSE
                               Person(gnr);
                             END;
          |  31..39        : IF stilling[HvisTur]='S' THEN Push:=TRUE ELSE
                               Styrke(gnr);
                             END;
          |  40            : IF stilling[HvisTur]='H' THEN Push:=TRUE ELSE
                               Person(gnr);
                             END;
          |  41..49        : IF stilling[HvisTur]='H' THEN Push:=TRUE ELSE
                               Styrke(gnr);
                             END;
          |  63, 65, 75,77,  87,  67..73: Push:=TRUE;
          |  29            : OpNed;
          |  85,97         : Help;
          |  61            : DiskFraTil(gnr);
          |  79            : DomiFraTil(gnr);
          |  81            : LydFraTil(gnr);
          |  83            : Farver;
          |  241           : TeoriWindow; (* xtra *)
          |  246           : PGNcomments; (* NumL *)
          |  235           : SetupVindue;
        ELSE END;
      END;
(*
      IF gadgetDown IN Pclass THEN
        gnr:= Pgad^.gadgetID;
        CASE gnr OF
          | 999 :;
        ELSE END;
      END;
*)
    END;
END AEMproc;

PROCEDURE EmptyMsgproc; (* Tøm Msg buffer, men udfør dem, der ikke må overses *)
VAR
  gad   :GadgetPtr;
  class :IDCMPFlagSet;
  msg   :IntuiMessagePtr;
  gnr,wn:INTEGER;
BEGIN
  Push:=FALSE;
  DoWIN(remWIN);
  DoWIN(pgnWIN);
  DoWIN(hlpWIN);
  IF ~SetFirst THEN DoWIN(setWIN) END;
  IF ~TeoFirst THEN DoWIN(teoWIN) END;
  REPEAT
    msg:=GetMsg(wptr^.userPort);    (* overfør msg-class og evt. gadget ptr*)
    IF msg<>NIL THEN
      class :=msg^.class; (*IDCMPFlags*) (* til egne variable class, gad*)
      gad   :=msg^.iAddress;
      mcode :=msg^.code;
      ReplyMsg(msg);                     (* returner/frigør message *)
      IF refreshWindow IN class THEN      (* kun ved simplerefresh vindue *)
        Refresh(stilling,Dominans,Mund,Select);
      END;
      IF rawKey IN class THEN
        IF (mcode=kRt) OR (mcode=kRtN) THEN (* msg^.qualifier set{lShift,rShift,lCommand,rCommand,numericPad} *)
          Flyt(71);
        ELSIF (mcode=kLt) OR (mcode=kLtN) THEN
          Flyt(69);
        ELSIF (mcode=kUp) OR (mcode=kUpN) THEN
          Flyt4(66, 10);
        ELSIF (mcode=kDn) OR (mcode=kDnN) THEN
          Flyt4(66,-10);
        ELSIF mcode=kHome THEN
          Flyt(67);
        ELSIF mcode=kEnd  THEN
          Flyt(73);
        ELSIF mcode=kPgUp THEN
          Flyt(71);Flyt(71);Flyt(71);Flyt(71);
        ELSIF mcode=kPgDn THEN
          Flyt(69);Flyt(69);Flyt(69);Flyt(69);
        ELSIF mcode=kF5 THEN
          IF Gem20(FALSE,FALSE,FALSE) THEN END;
        ELSIF mcode=kF1 THEN
          IF Hent20First(FALSE) THEN END;
        ELSIF mcode=kF2 THEN
          IF Hent20Next(FALSE) THEN END;
(*      ELSIF mcode=kY THEN
          VariantTgl; *)
        ELSIF VariantTil & (mcode=kT) THEN
          ToA;
        END;
      END;
      IF gadgetUp IN class THEN
        gnr:= gad^.gadgetID;
        CASE gnr OF
          |  69,71         : PilNede:=FALSE;
          |  29            : OpNed;
          |  30,40         : Person(gnr);
          |  31..39,41..49 : Styrke(gnr);
          |  61            : DiskFraTil(gnr);
          |  79            : DomiFraTil(gnr);
          |  81            : LydFraTil(gnr);
          |  95            : HvidSortTur(gnr);
          |  231           : ToA;
          |  233           : VariantTgl;
          |  237           : IF Gem20(FALSE,FALSE,FALSE) THEN END; (* F5 v*)
          |  238           : IF Hent20Next(FALSE) THEN END; (* F2 v*)
          |  239           : IF Hent20First(FALSE) THEN END; (* F1 v*)
        ELSE END;
      END;
    END;
  UNTIL msg=NIL;
END EmptyMsgproc;

PROCEDURE MainEventMonitor;
CONST
  ss01='U'; ss07='g'; ss13='i'; ss19='m'; ss25='r'; ss31=' '; ss37='o'; ss43='t';
  ss02='l'; ss08=' '; ss14='o'; ss20='e'; ss26='a'; ss32='t'; ss38='l'; ss44='!';
  ss03='o'; ss09='v'; ss15='n'; ss21='l'; ss27='c'; ss33='i'; ss39='i';
  ss04='v'; ss10='e'; ss16=','; ss22='d'; ss28='k'; ss34='l'; ss40='t';
  ss05='l'; ss11='r'; ss17=' '; ss23=' '; ss29='e'; ss35=' '; ss41='i';
  ss06='i'; ss12='s'; ss18='\\';ss24='c'; ss30='r'; ss36='p'; ss42='e';
  ss=CHAR(ORD(ss01)-31)+CHAR(ORD(ss02)-31)+CHAR(ORD(ss03)-31)+CHAR(ORD(ss04)-31)+
     CHAR(ORD(ss05)-31)+CHAR(ORD(ss06)-31)+CHAR(ORD(ss07)-31)+CHAR(ORD(ss08)-31)+
     CHAR(ORD(ss09)-31)+CHAR(ORD(ss10)-31)+CHAR(ORD(ss11)-31)+CHAR(ORD(ss12)-31)+
     CHAR(ORD(ss13)-31)+CHAR(ORD(ss14)-31)+CHAR(ORD(ss15)-31)+CHAR(ORD(ss16)-31)+
     CHAR(ORD(ss17)-31)+CHAR(ORD(ss18)-31)+CHAR(ORD(ss19)-31)+CHAR(ORD(ss20)-31)+
     CHAR(ORD(ss21)-31)+CHAR(ORD(ss22)-31)+CHAR(ORD(ss23)-31)+CHAR(ORD(ss24)-31)+
     CHAR(ORD(ss25)-31)+CHAR(ORD(ss26)-31)+CHAR(ORD(ss27)-31)+CHAR(ORD(ss28)-31)+
     CHAR(ORD(ss29)-31)+CHAR(ORD(ss30)-31)+CHAR(ORD(ss31)-31)+CHAR(ORD(ss32)-31)+
     CHAR(ORD(ss33)-31)+CHAR(ORD(ss34)-31)+CHAR(ORD(ss35)-31)+CHAR(ORD(ss36)-31)+
     CHAR(ORD(ss37)-31)+CHAR(ORD(ss38)-31)+CHAR(ORD(ss39)-31)+CHAR(ORD(ss40)-31)+
     CHAR(ORD(ss41)-31)+CHAR(ORD(ss42)-31)+CHAR(ORD(ss43)-31)+CHAR(ORD(ss44)-31);
VAR
  n,m,dl,my,x,y:INTEGER;
  sss:ARRAY[0..44] OF CHAR;
  buffer15:ARRAY[0..15] OF CHAR;
  NrCh:LONGINT;
  ievent:InputEvent;
  INAKTIV:BOOLEAN;
BEGIN
  (*$IF Test0 *)
    d(s("MainEventMonitor"));
  (*$ENDIF *)
  PilNede:=FALSE;
  INAKTIV:=FALSE;
  REPEAT                               (* EVENT-MONITOR *)
  (*$IF Test0 *)
      d(s("M"));
  (*$ENDIF *)
    IF Push THEN 
      IF Bruger[1]<>Vqb THEN INC(SneakCount); END;
      class:=Pclass;
      gad  :=Pgad;
      Push :=FALSE;
    ELSE
      IF INAKTIV THEN
        REPEAT 
          DoWIN(remWIN);
          DoWIN(pgnWIN);
          DoWIN(hlpWIN);
          IF ~SetFirst THEN DoWIN(setWIN) END;
          IF ~TeoFirst THEN DoWIN(teoWIN) END;
          msg:=GetMsg(wptr^.userPort);
          IF msg=NIL THEN
            Delay(4);
          END;
        UNTIL msg<>NIL;
      ELSE
        WaitPort(wptr^.userPort);          (* vent på input (message) *)
        msg   :=GetMsg(wptr^.userPort);    (* overfør msg-class og evt. gadget ptr*)
      END;
      class :=msg^.class; (*IDCMPFlags*) (* til egne variable class, gad*)
      gad   :=msg^.iAddress;
      mcode :=msg^.code;
      ReplyMsg(msg);                     (* returner/frigør message *)
    END;
    IF activeWindow IN class THEN
      INAKTIV:=FALSE;
(*      RG(108); *) (*iconizer*)
    END;
    IF mouseButtons IN class THEN
      IF mcode=selectUp THEN
        IF MovIt THEN
          MovIt:=FALSE;
          x     := wptr^.mouseX;
          y     := wptr^.mouseY;
          MovGad:= wptr^.firstGadget;
          gad   := NIL;
          WHILE (MovGad<>NIL) & (gad=NIL) DO
            WITH MovGad^ DO
              IF (x>=leftEdge) & (x<leftEdge+width)
              &  (y>=topEdge)  & (y<topEdge+height) THEN
                gad:=MovGad;
                gnr:=gad^.gadgetID;
              END;
            END;
            MovGad:=MovGad^.nextGadget;
          END;
          IF (gad<>NIL) & (gnr>110) & (gnr<189) THEN
            Ryk(gad,0);
          END;
        END;
      END;
    END;
    IF inactiveWindow IN class THEN
      INAKTIV:=TRUE;
(*      RG(108); *) (*iconizer*)
    END;
    IF Bruger[0]<>Vqa THEN INC(SneakCount); END;
    IF refreshWindow IN class THEN      (* kun ved simplerefresh vindue *)
  (*$IF Test0 *)
        d(s('refreshWindow'));
  (*$ENDIF *)
      Refresh(stilling,Dominans,Mund,Select);
    END;
    IF closeWindow IN class THEN
      Stop:=TRUE;
    END;

    IF rawKey IN class THEN
(*$IF Test0 *) 
  d(s('rawkey-Code=')+l(msg^.code));
(*$ENDIF *)

      IF (mcode=kRt) OR (mcode=kRtN) THEN (* msg^.qualifier set{lShift,rShift,lCommand,rCommand,numericPad} *)
        Flyt(71);
      ELSIF (mcode=kLt) OR (mcode=kLtN) THEN
        Flyt(69);
      ELSIF (mcode=kUp) OR (mcode=kUpN) THEN
        Flyt4(66, 10);
      ELSIF (mcode=kDn) OR (mcode=kDnN) THEN
        Flyt4(66,-10);
      ELSIF mcode=kHelp THEN
        Help;
      ELSIF mcode=kHome THEN
        Flyt(67);
      ELSIF mcode=kEnd  THEN
        Flyt(73);
      ELSIF mcode=kPgUp THEN
        FOR n:=1 TO 4 DO
          Flyt(71);
        END;
      ELSIF mcode=kPgDn THEN
        FOR n:=1 TO 4 DO
          Flyt(69);
        END;
      ELSIF (* (mcode=kCr) OR *) (mcode=kCrN) THEN
        Comments;
      ELSIF mcode=kNumL THEN
        PGNcomments;
      ELSIF mcode=kScrL THEN
        PscrL;
      ELSIF mcode=kSyRq THEN
        SetupVindue;
      ELSIF mcode=kPrSc THEN
        TeoriWindow;
      ELSIF mcode=kF1 THEN
        IF Hent20First(FALSE) THEN END;
      ELSIF mcode=kF2 THEN
        IF Hent20Next(FALSE) THEN END;
      ELSIF mcode=kF3 THEN
        PIGtilPIG;
      ELSIF mcode=kF4 THEN
        AutoPGNtilPIG;
      ELSIF mcode=kF5   THEN
        IF Gem20(FALSE,FALSE,FALSE) THEN END;
      ELSIF mcode=kF6 THEN
        Marker20(1);
      ELSIF mcode=kF7 THEN
        Marker20(0);
      ELSIF mcode=kF8 THEN
        Kopi20; 
      ELSIF mcode=kF9 THEN
        PGNtilPIG(FALSE);
      ELSIF mcode=kF0 THEN
        PIGtilPGN;
      ELSIF mcode=kK THEN
        CatGame(0,FALSE);
      ELSIF mcode=kN THEN
        CatGame(1,FALSE);
      ELSIF mcode=kE THEN
        CatGame(2,FALSE);
(*    ELSIF mcode=kY THEN
        VariantTgl;*)
      ELSIF mcode=kM THEN
        PIGtilSKEMA(1);
      ELSIF VariantTil & (mcode=kT) THEN
        ToA;
      ELSE
(*      ievent.nextEvent:=NIL;
        ievent.class:=rawkey;
        ievent.subClass:=null;
        ievent.code:=msg^.code;
        ievent.qualifier:=msg^.qualifier;
        ievent.eventAddress:=msg^.iAddress;
        NrCh:=RawKeyConvert(NIL,ADR(ievent),ADR(buffer15),15,NIL);
        IF NrCh>0 THEN
*)
(*$IF Test0 *) 
  d(l(NrCh)+s(' vanillakeys=')+s(buffer15));
(*$ENDIF *)
(*
        END;
*)
      END;
    END;
    IF gadgetDown IN class THEN
      IF Bruger[2]<>Vqc THEN INC(SneakCount); END;
      gnr:= gad^.gadgetID;
      CASE gnr OF
        | 69..71 : 
(*$IF Test *)
  WRITELN(s('gnr69-71 down'));
(*$ENDIF *)
          IF gnr=69 THEN HelpNr:=12 ELSE HelpNr:=13 END;
          n:=0;
          PilNede:=TRUE;
          my:=wptr^.mouseY;
          REPEAT
            m:=0;
            IF n>1 THEN (* repeat delay *) 
              dl:=my-wptr^.mouseY;
              dl:=ABS(dl);
              IF dl>64 THEN dl:=64; END;
              m:=64-dl;
              WHILE (m>0) & ~PopMsg() DO
                IF m<5 THEN
                  m:=0;
                ELSE
                  m:=m-5;
                END;
                Delay(5);
              END;
            END;  
            IF m=0 THEN
              Flyt(gnr);
            END;
            IF n=0 THEN (* Click-delay *)
              m:=0;
              REPEAT
                Delay(5);
                INC(m);
              UNTIL PopMsg() OR (5*m>64);
            END;
            INC(n);
          UNTIL PopMsg() OR (TraekNr=MaxTraek) OR (TraekNr=0);
          IF Bruger[3]<>Vqd THEN INC(SneakCount); END;
        |  111..188      :
           IF Valg=0 THEN
             MovIt:=TRUE;
           END;
          Ryk(gad,0);
      ELSE END;
    END;
    IF gadgetUp IN class THEN
      IF Bruger[5]<>Vqf THEN INC(SneakCount); END;
      gnr:= gad^.gadgetID;
      CASE gnr OF
        |  61            : DiskFraTil(gnr);
        |  63            : IF Hent(FALSE) THEN END; IF Bruger[23]<>Vqx THEN INC(SneakCount); END;
        |  65            : IF Gem(FALSE) THEN END;
        |  85,97         : Help; IF Bruger[19]<>Vqt THEN INC(SneakCount); END;
        |  75,77         : Opsaet(gnr); IF Bruger[21]<>Vqv THEN INC(SneakCount); END;
        |  67,73         : Flyt(gnr);
        |  69,71         : PilNede:=FALSE;
                           IF gnr=69 THEN HelpNr:=12 ELSE HelpNr:=13 END;
        |  29            : OpNed; IF Bruger[13]<>Vqn THEN INC(SneakCount); END;
        |  30,40         : Person(gnr);
        |  31..39,41..49 : Styrke(gnr); IF Bruger[15]<>Vqp THEN INC(SneakCount); END;
        |  79            : DomiFraTil(gnr); IF Bruger[25]<>Vqz THEN INC(SneakCount); END;
        |  81            : LydFraTil(gnr); IF Bruger[17]<>Vqr THEN INC(SneakCount); END;
        |  83,99         : Farver; IF Bruger[7]<>Vqh THEN INC(SneakCount); END;
        |  87            : Udgang; IF Bruger[9]<>Vqj THEN INC(SneakCount); END;
        |  89            : Tom; IF Bruger[11]<>Vql THEN INC(SneakCount); END;
        |  91            : Restore;
        |  93            : Comments;
        |  95            : HvidSortTur(gnr);
        |  101,103       : Main(gnr);
        |  108           : (* ToggleWindow *) ;
        |  111..188      : (*Ryk(gad,0)*) MovIt:=FALSE;
        |  200..219      : Vaelg(gnr);
        |  235           : SetupVindue;
        |  233           : VariantTgl; (* Y *)
        |  231           : ToA; (* T *)
        |  237           : IF Gem20(FALSE,FALSE,FALSE) THEN END; (* F5 v*)
        |  238           : IF Hent20Next(FALSE) THEN END; (* F2 v*)
        |  239           : IF Hent20First(FALSE) THEN END; (* F1 v*)
        |  240           : PscrL; (* ScrL *)
        |  241           : TeoriWindow;(* xtra *)
        |  242           : Kopi20; (* F8 *)
        |  243           : PIGtilPGN; (* F0 *)
        |  244           : PGNtilPIG(FALSE); (* F9 *)
        |  245           : AutoPGNtilPIG; (* F4 *)
        |  246           : PGNcomments; (* NumL *)
      ELSE END;
    END;
    IF SneakCount>Sneaks THEN
      sss:=ss;
      FOR n:=0 TO 43 DO sss[n]:=CHAR(ORD(sss[n])+31); END;
      IF SimpleWIN(ADR(sss))=1 THEN END;
      Stop:=TRUE; 
    END;
  UNTIL Stop;      
END MainEventMonitor;

PROCEDURE GoSkak;
VAR
  G:GadgetPtr;
BEGIN
  Init; (* IF InitSprog(0) THEN END;*)
  Sig(Q[TxGODDAG]^);
  MovIt:=FALSE;

  L1b:=FALSE;
  TeoriWindow;
  IF teoWIN.Window<>NIL THEN
   (* statistic button=114 *)

    SetPtr(wptr,PTRsove);
    IF LoadTeori('PigBase4.theory')>3 THEN
      SetPGNinfos;
      G:=teoWIN.Gadgets;
      WHILE (G<>NIL) & (G^.gadgetID<>114) DO 
        G:=G^.nextGadget;
      END;
      IF G<>NIL THEN
        IF ~GetToggl(G) THEN
          Statistic:=TRUE;
          SetToggl(G,teoWIN.Window,FALSE);
          ReCalcTeo(Statistic);
        END;
      END;
      teoPRT;
    ELSE
      CLOSEWIN(teoWIN);
    END;
    SetPtr(wptr,PTRrestore);
  END;
  L1b:=TRUE;(* Teoriwindow in foreground if TRUE *)

  REPEAT
    Stop:=FALSE;
    MainEventMonitor;

(*
    SetPtr(wptr,PTRsove);
    IF swptr=NIL THEN
      OK:=TwoGadWIN(ADDRESS(ADR('q.NIL!!')))=1;
    END;
    OK:=TwoGadWIN(ADDRESS(Q[TxSTOP]))=1;
    SetPtr(wptr,PTRrestore);
*)
    HelpNr:=39;
    IF ~OK & Simple THEN
      FullRefresh;
    END;
  UNTIL RydSpil(TRUE,FALSE) (* & OK *);
  CLOSEWIN(remWIN);
  CLOSEWIN(pgnWIN);
  CLOSEWIN(hlpWIN);
END GoSkak;

BEGIN
  LogVersion("Skak.def",SkakDefCompilation);
  LogVersion("Skak.mod",SkakModCompilation);
(*$IF Test *)
  WRITELN(s('Skak.1'));
(*$ENDIF *)
  AEM:=AEMproc; (* make AEM visible in SkakAlt *)
  EmptyMsg:=EmptyMsgproc;
(*$IF Test *)
  WRITELN(s('Skak.2'));
(*$ENDIF *)
CLOSE
(*$IF Test *)
  WRITELN(s('Skak.3'));
(*$ENDIF *)
  EmptyMsgproc;
  ProcessPtr(thisTask)^.windowPtr:=oldwindowptr; (* FØR ScreenClose *)
(*$IF Test *)
  WRITELN(s('Skak.4'));
(*$ENDIF *)
END Skak.

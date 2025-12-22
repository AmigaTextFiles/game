IMPLEMENTATION MODULE SkakScreen;         (* (c) E.B.Madsen 91 DK     Rev 17/11-95 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ DEFINE TestG:=FALSE *)

(*$ LongAlign:=TRUE StackParms:=FALSE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=FALSE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=FALSE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)


(* 3-94 TOPAZ 9 font as Screenfont *)
(* 3-94 Write Move count of total in the window, OK *)
(* 4-94 UnderPromotion, show, OK *)
(* 5-94 INTERNATIONAL, OK *)
(* 5-94 LONGFORMWRITE, OK (LongFormOn) *)
(* 5-94 ttTOOLTYPES *)
(* 6-94 Locale moved to SkakSprog *)
(* 2-95 Nye requestere GetTextPGN og ListPic, LOCALE, OK, lave key support,OK
        Lave flag undo og show selected i ListPic, WORKING, OK
   2-95 Multitasking ListPic med ll20, OK
   2-95 PGNreader forbedret, stopper nu ikke hvis ingen resultat,OK
                             stopper nu paranteslæs ved [ i 1'ste pos, OK
   2-95 Lave Filter Skip GameSize felt: Så kan man udvælge f.eks. lange spil
        og dermed de kommenterede eller de korte plus not 1/2 og dermed alle
        miniaturerne), WORKING
   2-95 Lave Filter (ikon) for at bruge stillingen som kriterie, OK
   2-95 Lave egen tekstviewer med keysupport og multitasking, (OK)
   2-95 Lave Auto SK10/SK20 Load/LoadFirst Save altid Append20, OK
   2-95 Lave LoadNext ikon, (OK)
   1-96 Calc of icon-positions better,
*)
FROM SYSTEM IMPORT
  ADR, ADDRESS, ASSEMBLE, CAST;
FROM Arts IMPORT
  wbStarted,programName, Assert;
FROM String IMPORT
  Copy, Concat, ConcatChar, Length, Compare, CapString;
FROM Conversions IMPORT
  ValToStr,StrToVal;
FROM Heap IMPORT
  Allocate, Deallocate;
FROM GraphicsD IMPORT
  RastPortPtr, DrawModeSet, DrawModes, ViewModes, ViewModeSet, TextAttrPtr,
  FontStyleSet, FontFlags, FontFlagSet;
FROM GraphicsL IMPORT
  SetDrMd, Move, Draw, RectFill, SetAPen, LoadRGB4, GetRGB4;
FROM ExecD IMPORT
  MemReqSet, MemReqs;
FROM ExecL IMPORT
  ReplyMsg, WaitPort, GetMsg, AvailMem, Forbid, Permit;
FROM IntuitionD IMPORT
  boolGadget, stdScreenHeight, GadgetPtr, IDCMPFlagSet, IDCMPFlags,
  IntuiMessagePtr, WindowPtr, WindowFlags, WindowFlagSet,
  strGadget, propGadget, PropInfoPtr, StringInfoPtr, gadgHNone,
  IntuiText, IntuiTextPtr, ScreenFlags, ScreenFlagSet,ImagePtr;
FROM IntuitionL IMPORT
  CloseWindow, CloseScreen,  RefreshGList, PrintIText, NewModifyProp,
  ActivateGadget, ActivateWindow, BeginRefresh, EndRefresh, RemoveGList,
  AddGList, DrawImage, DoubleClick, CurrentTime;
FROM Arguments IMPORT
  NumArgs, GetArg;
FROM WorkbenchD IMPORT
  DiskObjectPtr;
FROM IconL IMPORT
  GetDiskObject, FreeDiskObject, FindToolType, MatchToolValue;
FROM FileSystem IMPORT
  File, FileMode, FileModeSet, Lookup, Close, ReadBytes, WriteBytes, 
  Delete, Response, ReadChar, WriteChar, GetPos, SetPos;
FROM QuickIntuition IMPORT
  AF, AFS, GF, GFS, AddGadget, AddIntuiText, AddBorder, AddGadgetImage,
  AddStringInfo, AddPropInfo, ChipPicture, OutLine, MakeImage, SetTextAttr,
  AddWindow, AddScreen, SetString, GetString, SetGadgetImage, WriteText;
FROM QISupport IMPORT
  MarkGadget,RefreshGadget,SetGadget,SetToggl,GetToggl,SimpleWIN, TwoGadWIN,
  Edit;
FROM VersionLog IMPORT
  LogVersion;
FROM SkakBase IMPORT
  HvisTur,STILLINGTYPE,OpAd,SetUpMode,Valg,StyO,StyU,VlmO,VlmU,VlpO,VlpU,
  TraekNr,MaxTraek,Simple,Debug,sptr,ReqReq,SpeakOff,MaxTeori,
  InterOn,NoLocale,LongFormOn,
  gExtras,gFlags,gFilters,gInverse,MaxExtras,
  gSite,gEventDate,gEvent,gEventSponsor,gSection,gRound,gBoard,gStage,
  gInfo,gResult,gOpening,gNIC,gVariation,gECO,gSubVariation,gDate,
  gTime,gWhite,gWhiteElo,gWhiteUSCF,gWhiteTitle,gWhiteCountry,gBlack,
  gBlackElo,gBlackUSCF,gBlackTitle,gBlackCountry,gExt17,gSource,gAnnotator,
  LBLARR,LL,LLP,LLSIZE,
  PIGtotal,PIGdeleted,PIGlength,PIGstat0,PIGstat1,PIGstat2,PIGstat3,EMPROC,
  LotMemOn,MouthOff,NoSpeakTask, NoAutoPGN, Quick, MAXLLSIZE, Later2, Later,
  VariantTil, Lates3;


FROM SKAKdata IMPORT
  Grafik;
FROM SkakSprog IMPORT
  TASTBESKRIVELSE,LAERSKAK,TxD,TxT,TxS,TxL,Q,TAGo,
  Qoriginal,Qclear,Qpgn,Qspg,Qor,Qtitlefilter,Qtitlepgninfo,
  Qall0,Qall1,Qwin0,Qwin1,Qtitlepick,Qnotext,Qreadinglist,QFilterHelp,
  InitSprog,Q220,DoubleSelect;

(*$ IF Test *)
FROM W IMPORT
  WRITE, WRITELN, s, l, lf, bf,b,c;
(*$ ENDIF *)

CONST
  SkakScreenModCompilation="578";
(*
  pd=TxD;
  pt=TxT;
  ps=TxS;
  pl=TxL;
*)

(*Redraw: Under Markering, OK *)
(* - " -: DK tegn only ved Underforvandling, rettet, OK *)

  MinChip      = 65000; (* 42K+21K+?K *)
  MinTotal     = 125000; (*   -  "  - + ?K *)
  MaxGadget    =  356;
  XOff         =   7;
  YOff         =  12;
  MaxDistance  =  18;

  Color0blue=0;
  Color1white=1;
  Color2black=2;
  Color3orange=3;

VAR
  Gadgets      : ARRAY[1..MaxGadget] OF GadgetPtr;
  BG           : GadgetPtr; (* BoardGadgets (Første user gadget *)
  MG,SG,BGE    : GadgetPtr; (* MainGadgets,SetupGadgets,BoardGadgetsEnd *)
  ScrOn        : BOOLEAN;
  rp           : RastPortPtr;
  StilC        : STILLINGTYPE; (* ' MKDRTSLBEmkdrtslbe','.' *)
  DomiC        : STILLINGTYPE; (* ' HS' *)
  MundC        : STILLINGTYPE; (* 'A..Z','.' *)
  SeleC        : STILLINGTYPE; (* ' S' *)
  ValgC        : INTEGER;      (* 0,111..188,200..219 *)
  SetUC,nq     : INTEGER;      (* 0=Main, 1=SetUp , 2=InTeori,
                                  3=OutOfTeori, 4=SetUpTeori *)
  OpAdC        : BOOLEAN;      (* TRUE = Hvid spiller opad *)
  StyOC,StyUC  : INTEGER;      (* Styrke -1,0,1..9 *)
  VlmOC,VlmUC  : INTEGER;      (* VærdiMateriel 0,1-99 *)
  VlpOC,VlpUC  : INTEGER;      (* Værdi positionel 0,1-99 *)
  TraeC,MaxTC  : INTEGER;      (* -1,0..MaxTraek , -1,0..MaxPartiLaengde *)
  wptr         : WindowPtr;  
  pd,pt,ps,pl  : ARRAY[0..1] OF CHAR; 
  XSize:CARDINAL; (* =60; *)
  YSize:CARDINAL; (* =30; *)
  ZSize:CARDINAL; (* =30; *)
  YmK,YmT,YmL,YmD,YmB,YmS:CARDINAL; (* 10,11,15,9,10,12 (mundes Y placering) *)
  XmS,XmR:CARDINAL;                 (* 8,19 (Springers,Restens X placering) *)
  stx:INTEGER;  (* =494; *)

  itx        :IntuiText;
  NFP        :BOOLEAN;
 
(*$ IF Test OR TestG *)
  PROCEDURE d(n:CARDINAL);
  BEGIN
    WRITELN(n);
  END d; 

  PROCEDURE D(n:CARDINAL);
  BEGIN
    WRITE(n);
  END D;
(*$ ENDIF *)

(*$ IF Test *)
  PROCEDURE w(g:GadgetPtr):CARDINAL;
  VAR
    n:CARDINAL;
  BEGIN
    n:=MaxGadget;
    WHILE (n>0) AND (Gadgets[n]<>g) DO
      DEC(n); 
    END;
    WRITE(lf(n,3));
    RETURN(0);
  END w;
(*$ ENDIF *)

PROCEDURE ico; (*$ EntryExitCode:=FALSE *) (* 16x10x2 *)
BEGIN
  ASSEMBLE(DC.W
$0000,
$3FFE,
$2002,
$2002,
$2002,
$2002,
$2002,
$2002,
$3FFE,
$0000,

$0000,
$0000,
$0000,
$0000,
$0000,
$0000,
$0000,
$0000,
$0000,
$0000
 END);
END ico;

(*
PROCEDURE WrTxt(rp:RastPortPtr; StringPtr:ADDRESS; leftoffset,topoffset:INTEGER);
VAR
  itxt : IntuiText;
BEGIN
  WITH itxt DO
    frontPen:=2;
    backPen:=1;
    drawMode:=DrawModeSet{dm0};
    leftEdge:=0;
    topEdge:=0;
    iTextFont:=NIL;
    iText:=StringPtr;
    nextText:=NIL;
  END;
  PrintIText(rp,ADR(itxt),leftoffset,topoffset);
END WrTxt;
*)

VAR
  MaxWinY:INTEGER;

PROCEDURE InitBoardGadgets(VAR G:GadgetPtr);
VAR
  X,Y:CARDINAL;
  PosY:INTEGER;
  Ip:ImagePtr;
BEGIN
(*$ IF Test*)
  d(s('InitBoardGadgets'));
(*$ ENDIF *)
  G:=NIL;
  Ip:=Grafik[1];
  XSize:=Ip^.width;
  YSize:=Ip^.height;
  ZSize:=Ip^.depth;
  IF ZSize>8 THEN ZSize:=8 END;
  IF ZSize<1 THEN ZSize:=1 END;

  (* sæt Mundes placering: *)
  YmK:=10*YSize DIV 30;
  YmT:=11*YSize DIV 30;
  YmL:=15*YSize DIV 30;
  YmD:= 9*YSize DIV 30;
  YmB:=10*YSize DIV 30;
  YmS:=12*YSize DIV 30;
  XmS:=XSize DIV 7;
  XmR:=XSize DIV 3-1;

  stx:=8*XSize+12; (* 494 , nu 492 *)
  FOR X:=1 TO 8 DO
    FOR Y:=1 TO 8 DO
      AddGadget(G,XOff+X*XSize-XSize,YOff+(8-Y)*YSize,XSize,YSize,
 (*!!!!!!!!!!*) gadgHNone,AFS{gadgImmediate,relVerify},NIL,NIL,NIL,NIL,100+X+10*Y,NIL);
      IF ODD(X+Y) THEN
        SetGadgetImage(G,FALSE,Grafik[1]);
      ELSE
        SetGadgetImage(G,FALSE,Grafik[2]);
      END;
      Gadgets[100+X+10*Y]:=G;
    END;
  END;
  PosY:=YOff+8*YSize;
  (* iconizer *)
  (*
  Grafik[108]:=MakeImage(16,10,2,ADR(ico));
  AddGadget(G,-68,1,16,10,
            GFS{gRelRight},AFS{relVerify},NIL,NIL,NIL,NIL,108,NIL);
  SetGadgetImage(G,FALSE,Grafik[108]);
  Gadgets[108]:=G;
  *)
  IF PosY>MaxWinY THEN 
    MaxWinY:=PosY;
  END;
END InitBoardGadgets;

VAR
  MundY1,MundY2:INTEGER;

CONST
  (*ply=92;*) (* pos y Lower Player *)
  st7=11;
  (*st4=25;*)
  (*st1=37;*)
  Yo = 1;

PROCEDURE InitMainGadgets(VAR G:GadgetPtr);
CONST
(*nix=112;*)
(*k1y=203;*)
(*k2y=229;*)
  kxs=5; (* gdX+5=49 *)
  kys=3;
VAR
  gfs:GFS;
  kx,ky,PosY,nix,PosYtmp,nx,ny:INTEGER;
  Ip:ImagePtr;
BEGIN
(*$ IF Test*)
  d(s("InitMainGadgets(VAR G:GadgetPtr)"));
(*$ ENDIF *)
  G:=NIL;
  PosY:=st7+Yo;        (* mund var: 77+/- yp (46) *)

  (* før: y=12+19 for mund *)
  MundY1:=PosY;
  (* øverste spiller/stærk/middel/svag 95,38  30,14  30,12  30,12 *)
  AddGadget(G,stx+15 , PosY,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,30,NIL);
  SetGadgetImage(G,FALSE,Grafik[33]);
  nix:=G^.width+2+15;
  PosYtmp:=PosY+G^.height;
  MundY1:=MundY1+G^.height DIV 2;
  SetGadgetImage(G,TRUE,Grafik[36]);
  Gadgets[30]:=G;

  AddGadget(G, stx+nix, PosY,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,37,NIL);
  SetGadgetImage(G,FALSE,Grafik[43]);
  Gadgets[37]:=G;
  PosY:=PosY+G^.height;

  AddGadget(G, stx+nix, PosY,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,34,NIL);
  SetGadgetImage(G,FALSE,Grafik[40]);
  Gadgets[34]:=G;
  PosY:=PosY+G^.height;

  AddGadget(G, stx+nix, PosY,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,31,NIL);
  Gadgets[31]:=G;
  SetGadgetImage(G,FALSE,Grafik[37]);
  PosY:=PosY+G^.height;

  IF PosYtmp>PosY THEN
    PosY:=PosYtmp;
  END;
  PosY:=PosY+2;
  (* Bræt 51+Yo *)
  Ip:=Grafik[29];  (* Centrer board under player *)
  AddGadget(G, stx+15+Gadgets[30]^.width DIV 2-Ip^.width DIV 2,PosY,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,29,NIL);
  SetGadgetImage(G,FALSE,Grafik[29]);
  SetGadgetImage(G,TRUE,Grafik[30]);
  Gadgets[29]:=G;

  PosY:=PosY+G^.height+2;
  MundY2:=PosY;
  (* nederste spiller/stærk/middel/svag *)
  AddGadget(G, stx+15, PosY,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,40,NIL);
  SetGadgetImage(G,FALSE,Grafik[32]);
  nix:=G^.width+2+15;
  MundY2:=MundY2+G^.height DIV 2;
  PosYtmp:=PosY+G^.height;
  SetGadgetImage(G,TRUE,Grafik[35]);
  Gadgets[40]:=G;

  AddGadget(G, stx+nix, PosY,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,47,NIL);
  SetGadgetImage(G,FALSE,Grafik[43]);
  Gadgets[47]:=G;
  PosY:=PosY+G^.height;

  AddGadget(G, stx+nix, PosY,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,44,NIL);
  SetGadgetImage(G,FALSE,Grafik[40]);
  Gadgets[44]:=G;

  PosY:=PosY+G^.height;
  AddGadget(G, stx+nix, PosY,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,41,NIL);
  SetGadgetImage(G,FALSE,Grafik[37]);
  Gadgets[41]:=G;
  PosY:=PosY+G^.height;

  IF PosYtmp>PosY THEN
    PosY:=PosYtmp;
  END;
  PosY:=PosY+2;
  (* Disk ind/tegning/ud 75,11  68,33  75,11 *)
  AddGadget(G, stx, PosY,   0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,63,NIL);
  SetGadgetImage(G,FALSE,Grafik[63]);
  Gadgets[63]:=G;

  AddGadget(G, stx+75, PosY,   0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,61,NIL);
  SetGadgetImage(G,FALSE,Grafik[62]);
  SetGadgetImage(G,TRUE,Grafik[64]);
  Gadgets[61]:=G;
  PosYtmp:=PosY+G^.height+kys;
  PosY:=PosY+Gadgets[63]^.height;

  AddGadget(G, stx, PosY,   0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,65,NIL);
  SetGadgetImage(G,FALSE,Grafik[65]);
  Gadgets[65]:=G;
  PosY:=PosY+G^.height+kys;

  (* ToStil,Variant,ToA  19,11  26,11  26,11 *)
  AddGadget(G, stx, PosY,   0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,235,NIL);
  SetGadgetImage(G,FALSE,Grafik[135]);
  Gadgets[235]:=G;
  IF PosY+G^.height<PosYtmp-kys THEN
    PosY:=PosYtmp-kys-G^.height;
    G^.topEdge:=PosY;
  END;
  AddGadget(G, stx+19, PosY,   0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,233,NIL);
  SetGadgetImage(G,FALSE,Grafik[133]);
  Gadgets[233]:=G;
  AddGadget(G, stx+45, PosY,   0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,231,NIL); (* Comment gdID *)
  SetGadgetImage(G,FALSE,Grafik[132]);
  Gadgets[231]:=G;
  PosY:=PosY+G^.height;
  IF PosYtmp>PosY THEN
    PosY:=PosYtmp;
  END;

  (* start/tilbage/frem/enden, def: 36, 20 *)
  AddGadget(G, stx, PosY,  0, 0, GFS{gadgDisabled},AFS{relVerify},
            NIL,NIL,NIL,NIL,67,NIL);
  SetGadgetImage(G,FALSE,Grafik[67]);
  ky:=G^.height;
  Gadgets[67]:=G;
  AddGadget(G, stx+36, PosY,  0, 0, GFS{gadgDisabled},AFS{gadgImmediate,relVerify},
            NIL,NIL,NIL,NIL,69,NIL);
  SetGadgetImage(G,FALSE,Grafik[69]);
  Gadgets[69]:=G;
  AddGadget(G, stx+72, PosY,  0, 0, GFS{gadgDisabled},AFS{gadgImmediate,relVerify},
            NIL,NIL,NIL,NIL,71,NIL);
  SetGadgetImage(G,FALSE,Grafik[71]);
  Gadgets[71]:=G;
  AddGadget(G, stx+108, PosY,  0, 0, GFS{gadgDisabled},AFS{relVerify},
            NIL,NIL,NIL,NIL,73,NIL);
  SetGadgetImage(G,FALSE,Grafik[73]);
  Gadgets[73]:=G;
  PosY:=PosY+ky+kys;

  (* tale/farve/nytspil/ dominans/about/setup, def: 44, 22*)
  AddGadget(G, stx, PosY,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,81,NIL);
  SetGadgetImage(G,FALSE,Grafik[81]);
  Gadgets[81]:=G;
  kx:=G^.width;
  ky:=G^.height;
  AddGadget(G, stx+kx+kxs, PosY,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,83,NIL);
  SetGadgetImage(G,FALSE,Grafik[83]);
  Gadgets[83]:=G;
  AddGadget(G, stx+kx+kxs+kx+kxs, PosY,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,77,NIL);
  SetGadgetImage(G,FALSE,Grafik[77]);
  Gadgets[77]:=G;
  PosY:=PosY+ky+kys;

  IF NFP THEN gfs:=GFS{selected} ELSE gfs:=GFS{} END;
  AddGadget(G, stx, PosY,  0, 0, gfs,AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,79,NIL);
  SetGadgetImage(G,FALSE,Grafik[79]);
  Gadgets[79]:=G;
  ky:=G^.height;

  AddGadget(G, stx+kx+kxs, PosY,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,85,NIL);
  SetGadgetImage(G,FALSE,Grafik[85]);
  Gadgets[85]:=G;
  AddGadget(G, stx+kx+kxs+kx+kxs, PosY,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,75,NIL);
  SetGadgetImage(G,FALSE,Grafik[75]);
  Gadgets[75]:=G;
  PosY:=PosY+ky;

  IF (PosY+2<MaxWinY) OR (PosY+2>=273) THEN
    PosY:=PosY+2;
    FOR ny:=0 TO 1 DO
      FOR nx:=0 TO 4 DO
        AddGadget(G, stx+nx*kx, PosY,  0, 0, GFS{},AFS{relVerify},
                  NIL,NIL,NIL,NIL,237+nx+5*ny,NIL);
        SetGadgetImage(G,FALSE,Grafik[137+nx+5*ny]);
        Gadgets[237+nx+5*ny]:=G;
        kx:=G^.width;
        ky:=G^.height;
        IF nx=0 THEN
          IF PosY+ky+kys<MaxWinY THEN
            PosY:=PosY+kys;
            G^.topEdge:=PosY;
          END;
        END;
      END;
      PosY:=PosY+ky;
      IF (PosY+2>=MaxWinY) & (PosY+2<273) THEN (* Stop FOR ny loop *)
        INC(ny);
      END;
    END;
  END;

  IF PosY>MaxWinY THEN 
    MaxWinY:=PosY;
  END;
END InitMainGadgets;

PROCEDURE InitSetUpGadgets(VAR G:GadgetPtr);
CONST
  sty= 11;
VAR
  X,Y,xs,ys,xo,szy,spy,stx2,my:INTEGER;
  Ip:ImagePtr;
BEGIN
(*$ IF Test*)
  d(s("InitSetUpGadgets(VAR G:GadgetPtr)"));
(*$ ENDIF *)
  G:=NIL;

  AddGadget(G, stx, sty-1,  1, 1, gadgHNone,AFS{}, (* Menu *)
            NIL,NIL,NIL,NIL,199,NIL);
  SetGadgetImage(G,FALSE,Grafik[28]);
  Gadgets[199]:=G;
  Ip:=Grafik[28];
  xs:=Ip^.width DIV 2;  (*  93 *)
  my:=Ip^.height+1;
  ys:=my DIV 10; (* 229 *)
  IF xs<47 THEN  xo:=0 ELSE xo:=1 END;
  FOR X:=0 TO 1 DO
    FOR Y:=0 TO 9 DO
      AddGadget(G,stx+1+X*xs+xo+xo,sty+Y*ys-1+xo,xs-2,ys-1, GFS{},
      AFS{relVerify},NIL,NIL,NIL,NIL,200+X+Y+Y,NIL);
      Gadgets[200+X+Y+Y]:=G;
    END;
  END;

  stx2:=Ip^.width+3;

  spy:=3; (* space between in y *)
  AddGadget(G, stx+stx2, sty,  0, 0, GFS{},AFS{relVerify,toggleSelect},
            NIL,NIL,NIL,NIL,95,NIL);
  SetGadgetImage(G,FALSE,Grafik[95]); (* HvidSort *)
  szy:=G^.height+spy;
  SetGadgetImage(G,TRUE ,Grafik[96]);
  Gadgets[95]:=G;

  AddGadget(G, stx+stx2, sty+1*szy,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,87,NIL);
  SetGadgetImage(G,FALSE,Grafik[77]); (* udgangst. *)
  Gadgets[87]:=G;

  AddGadget(G, stx+stx2, sty+2*szy,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,89,NIL);
  SetGadgetImage(G,FALSE,Grafik[89]); (* tom *)
  Gadgets[89]:=G;

  AddGadget(G, stx+stx2, sty+3*szy,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,91,NIL);
  SetGadgetImage(G,FALSE,Grafik[75]); (* restore *)
  Gadgets[91]:=G;

  AddGadget(G, stx+stx2, sty+4*szy,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,93,NIL);
  SetGadgetImage(G,FALSE,Grafik[93]); (* Comment *)
  Gadgets[93]:=G;

  AddGadget(G, stx+stx2, sty+5*szy,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,97,NIL);
  SetGadgetImage(G,FALSE,Grafik[85]);  (* help *)
  Gadgets[97]:=G;

  AddGadget(G, stx+stx2, sty+6*szy,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,99,NIL);
  SetGadgetImage(G,FALSE,Grafik[83]); (* farver *)
  Gadgets[99]:=G;

  Y:=sty+7*szy;            (* OK, UPS *)
  IF Y<sty+my THEN               
    Y:=sty+my;
  END;
  AddGadget(G, stx, Y,  0, 0, GFS{},AFS{relVerify}, (* 50,11 *)
            NIL,NIL,NIL,NIL,101,NIL);
  SetGadgetImage(G,FALSE,Grafik[102]);
  Gadgets[101]:=G;
  AddGadget(G, stx+stx2-10, Y,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,103,NIL);
  SetGadgetImage(G,FALSE,Grafik[104]);
  Gadgets[103]:=G;
  Y:=Y+G^.height;
  IF Y>MaxWinY THEN 
    MaxWinY:=Y;
  END;
END InitSetUpGadgets;

PROCEDURE UnderShow(gptr:GadgetPtr);
VAR
  xf,xt,yf,yt,xh,yh,xk,yk:INTEGER;
BEGIN
  IF gptr<>NIL THEN
    WITH gptr^ DO
      xf:=leftEdge+2;
      xt:=leftEdge+width-3;
      xh:=width DIV 2;
      xk:=xh DIV 2;
      yf:=topEdge+2;
      yt:=topEdge+height-3;
      yh:=height DIV 2;
      yk:=yh DIV 2;
      SetAPen(rp,Color0blue);
      Move(rp,xf+xh-1,yf);
      Draw(rp,xf+xh-1,yt);
      Move(rp,xf,yf+yh-1);
      Draw(rp,xt,yf+yh-1);

      WriteText(rp,ADR(pd),xf+xk-3,yf+yk-3);
      WriteText(rp,ADR(pt),xt-xk-3,yf+yk-3);
      WriteText(rp,ADR(ps),xf+xk-3,yt-yk-3);
      WriteText(rp,ADR(pl),xt-xk-3,yt-yk-3);
    END;
  END;
END UnderShow;

PROCEDURE RG(gnr:INTEGER);
BEGIN
  RefreshGadget(Gadgets[gnr],wptr);
END RG;

PROCEDURE SetToggle(gnr:INTEGER; OnOff:BOOLEAN);
BEGIN
(*$ IF Test*)
  d(s('SetToggle'));
(*$ ENDIF *)
  SetToggl(Gadgets[gnr],wptr,OnOff);
END SetToggle;

PROCEDURE SetGad(gnr:INTEGER; OnOff:BOOLEAN);
BEGIN
  SetGadget(Gadgets[gnr],wptr,OnOff);
END SetGad;

PROCEDURE GetToggle(gnr:INTEGER):BOOLEAN;
BEGIN
(*$ IF Test*)
  d(s('GetToggle'));
(*$ ENDIF *)
  RETURN(GetToggl(Gadgets[gnr]));
END GetToggle;

VAR
  TG,TGPGN,TGFG,LSG: GadgetPtr;
  wptrT : WindowPtr;

PROCEDURE ExitT;
BEGIN
  IF wptrT<>NIL THEN
    CloseWindow(wptrT);
    wptrT:=NIL;
  END;
END ExitT;

PROCEDURE SetGadImage(gnr:INTEGER; select:BOOLEAN; GrafikNr:INTEGER);
                  (* Set the gadget Image, select if secondary *)
VAR
  p1,p2:ADDRESS;
BEGIN
(*$ IF Test*)
  d(s('SetGadImage'));
(*$ ENDIF *)
  p1:=Gadgets[gnr];
  p2:=Grafik[GrafikNr];
  Forbid;
  SetGadgetImage(p1,select,p2);
  Permit;
  RG(gnr);
END SetGadImage;

(*$ IF Test0 *)
PROCEDURE InitTextGadgets(VAR G:GadgetPtr);
VAR
  n:INTEGER;
BEGIN
  FOR n:=230 TO 245 DO
    AddGadget(G, 8,(n-229)*12+4,  330, 10, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,n,NIL);
    Gadgets[n]:=G;
    AddStringInfo(G,40,"");
    AddBorder(G,FALSE,-2,-2,3,2,DrawModeSet{dm0},5,OutLine(G));
  END;
  AddGadget(G, 8, 218,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,228,NIL);
  SetGadgetImage(G,FALSE,Grafik[101]);
  Gadgets[228]:=G;
  AddGadget(G, 268, 218,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,229,NIL);
  SetGadgetImage(G,FALSE,Grafik[103]);
  Gadgets[229]:=G;
END InitTextGadgets;
(*$ ENDIF *)

VAR
  FirstEdit:BOOLEAN;

PROCEDURE GetText(txt:ADDRESS);
TYPE
  STR=ARRAY[0..1000] OF CHAR;
VAR
  st:STR;
  stp:POINTER TO STR;
  MinX,MinY,PosX,PosY:INTEGER;
BEGIN
  IF FirstEdit THEN
    MinX:=140;MinY:=36;
    PosX:=6;  PosY:=6;
    FirstEdit:=FALSE;
  ELSE
    MinX:=-1; MinY:=-1;
    PosX:=-1; PosY:=-1;
  END;
  stp:=txt;
  Copy(st,stp^);
  IF Edit(stp^,ADR('Edit'),MinX,MinY,-1,-1,PosX,PosY,TRUE)=0 THEN (* IF Esc then restore contents *)
    Copy(stp^,st);
  END;
END GetText;


(*
Reserveret Gadgets[288..355], brug:
   Bool: -12..16,17,18-22  GdId:  0..28,29,30-34  GdNr: 258..286,287,288-292
   Strs: -12..16,   18-22  GdId: 50..78,   80-84  GdNr: 308..336,    338-342
   OK                      GdId: 228              GdNr: 354 (unødvendig)
   UPS                     GdId: 229              GdNr: 355 (unødvendig)     
   SYS:                    GdId: 193..200         GdNr: 293..300          

*)
CONST
  MaxShortTexts=15;
VAR
  ShortTexts:ARRAY[1..MaxShortTexts] OF POINTER TO ARRAY[0..16] OF CHAR;
  ShortTextsPtr:=INTEGER{0};
  TxtHlp:INTEGER;

PROCEDURE InitTextGadgetsPGN(VAR G:GadgetPtr);
CONST
  Ys=8;
VAR
  n,Ofs:INTEGER;
PROCEDURE Add(TAGindex, TX,TY,TS,TOFS, SX,SY,SS,SOFS : INTEGER); (* OFS=Offset *)
VAR
  Pos,PosUd,Skip:INTEGER;
  Ch:CHAR;
BEGIN
(*$ IF Test*)
  d(s('Add TAG=')+l(TAGindex)+s(' SX=')+l(SX));
(*$ ENDIF *)
  IF TAGindex=MaxExtras-1 THEN
    Ofs:=1;
  ELSE
    Ofs:=0;
  END;
  AddGadget(G, TX*8-17,TY*Ys-2+Ofs+TOFS, TS*8+3,10-Ofs-Ofs, GFS{}, AFS{relVerify,toggleSelect},
              NIL,NIL,NIL,NIL,TAGindex+12,NIL);
  IF Length(Q[TAGindex+TAGo]^)<=TS THEN
    AddIntuiText(G, 2,1, DrawModeSet{dm0}, 2,1-Ofs, Q[TAGindex+TAGo]);
  ELSE
    IF ShortTextsPtr<MaxShortTexts THEN
      INC(ShortTextsPtr);
      Allocate(ShortTexts[ShortTextsPtr],TS+1);
      IF ShortTexts[ShortTextsPtr]<>NIL THEN
        Skip:=Length(Q[TAGindex+TAGo]^)-TS;
(*$ IF Test*)
  d(s('Skip=')+l(Skip)+s(' TS=')+l(TS));
(*$ ENDIF *)
        Pos:=0;
        PosUd:=0;
        REPEAT
          Ch:=Q[TAGindex+TAGo]^[Pos];
          IF (Skip<=0) OR (Ch=CAP(Ch)) THEN
            ShortTexts[ShortTextsPtr]^[PosUd]:=Ch;
            INC(PosUd);
          ELSE
            DEC(Skip);
          END;
          INC(Pos);
        UNTIL (Ch=0C) OR (PosUd>=TS);
        IF Ch<>0C THEN
          ShortTexts[ShortTextsPtr]^[PosUd]:=0C;
        END;
        AddIntuiText(G, 2,1, DrawModeSet{dm0}, 2,1, ShortTexts[ShortTextsPtr]);
      END;
    END;
  END;

  Gadgets[TAGindex+270]:=G;

  AddGadget(G, SX*8-10,SY*Ys-2+SOFS, SS*8+8,10, GFS{}, AFS{gadgImmediate,relVerify},
              NIL,NIL,NIL,NIL,TAGindex+62,NIL);
  IF TAGindex=gExt17 THEN
    SS:=30;
  END;
  AddStringInfo(G,SS,"");
  AddBorder(G,FALSE,-2,-2,3,2,DrawModeSet{dm0},5,OutLine(G));
  Gadgets[TAGindex+320]:=G;
END Add;
BEGIN
(*$ IF Test*)
  d(s('InitTextGadgetsPGN'));
(*$ ENDIF *)

  Add(gSite,            4, 2,10, 0,   14, 2,20, 0);
  Add(gEventDate,      38, 2,17, 0,   55, 2,10, 0);
  Add(gEvent,           4, 4,10, 0,   14, 4,20, 0);
  Add(gEventSponsor,   38, 4,17, 0,   55, 4,20, 0);

  Add(gSection,         4, 7,10, 0,   14, 7,15, 0);
  Add(gRound,          34, 7, 8, 0,   42, 7, 2, 0);
  Add(gBoard,          47, 7, 8, 0,   55, 7, 3, 0);
  Add(gStage,           4, 9,10, 0,   14, 9,15, 0);
  Add(gInfo,           34, 9, 8, 0,   42, 9,12, 0);

  Add(gResult,          4,12,10, 0,   14,12, 7, 0);
  Add(gOpening,        28,12,14, 0,   42,12,15, 0);
  Add(gNIC,             4,14,10, 0,   14,14,11, 0);
  Add(gVariation,      28,14,14, 0,   42,14,15, 0);
  Add(gECO,             4,16,10, 0,   14,16, 7, 0);
  Add(gSubVariation,   28,16,14, 0,   42,16,15, 0);

  Add(gDate,            4,19,10, 0,   14,19,10, 0);
  Add(gTime,           27,19, 7, 0,   34,19, 6, 0);
  Add(gWhite,           4,21,10,-2,   14,21,25, 0);
  Add(gWhiteElo,       44,18, 7,-1,   44,21, 4, 0);
  Add(gWhiteUSCF,      53,18, 8,-1,   53,21, 4, 0);
  Add(gWhiteTitle,     62,18, 7,-1,   62,21, 3, 0);
  Add(gWhiteCountry,   71,18, 8,-1,   71,21, 3, 0);
  Add(gBlack,           4,23,10, 0,   14,23,25, 0);
  Add(gBlackElo,       44,19, 7, 1,   44,23, 4, 0);
  Add(gBlackUSCF,      53,19, 8, 1,   53,23, 4, 0);
  Add(gBlackTitle,     62,19, 7, 1,   62,23, 3, 0);
  Add(gBlackCountry,   71,19, 8, 1,   71,23, 3, 0);

(*Add(gExt17,          58, 9, 8, 0,   66, 9, 2, 0);*)  (* Del Only Bool *)
  Add(gExt17,          62, 7, 8, 0,   58, 9,12, 0);
                     (*TX,TY,TS,TOFS, SX,SY,SS,SOFS*)
                     (*  Text   xPts   Gadget      *)
  Add(MaxExtras-3,      4,26,12, 0,   16,26, 5, 0);  (* gComments *)     
  Add(MaxExtras-2,     26,26, 8, 0,   34,26, 3, 0);  (* gMoves *)     
  Add(MaxExtras-1,      5,22, 8,-1,   57,26, 3, 0);  (* = og Variant *)
  AddIntuiText(Gadgets[341],Color1white,Color2black, DrawModeSet{dm0}, -122,0, Q[Qor]);

  Add(gSource,         21,29, 8, 0,   29,29,20, 0);
  Add(gAnnotator,      52,29,11, 0,   63,29,15, 0);

  Add(MaxExtras,        4,29, 6, 0,   10,29, 8, 0);   (* gSkip *)   

(*  AddGadget(G, 42,194,44,8, GFS{}, AFS{relVerify,toggleSelect},
              NIL,NIL,NIL,NIL,33,NIL);
  AddIntuiText(G, 2,1, DrawModeSet{dm0}, 2,0, Q[Qor]);
  Gadgets[291]:=G;*)

  AddGadget(G, 556,  94,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,228,NIL);
  SetGadgetImage(G,FALSE,Grafik[101]);
  Gadgets[354]:=G;

  AddGadget(G, 556, 118,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,229,NIL);
  SetGadgetImage(G,FALSE,Grafik[103]);
  Gadgets[355]:=G;

  AddGadget(G, 561,40, 60,13, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,193,NIL);
  AddIntuiText(G, 2,3, DrawModeSet{dm0}, 2,2, Q[Qoriginal]);
  Gadgets[293]:=G;

  AddGadget(G, 561,53, 60,13, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,194,NIL);
  AddIntuiText(G, 2,3, DrawModeSet{dm0}, 2,2, Q[Qclear]);
  Gadgets[294]:=G;

  AddGadget(G, 561,66, 60,13, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,195,NIL);
  AddIntuiText(G, 2,3, DrawModeSet{dm0}, 2,2, Q[Qpgn]);
  Gadgets[295]:=G;


  AddGadget(G, 561,79, 60,13, GFS{}, AFS{relVerify,toggleSelect},
              NIL,NIL,NIL,NIL,196,NIL);
  AddIntuiText(G, 2,3, DrawModeSet{dm0}, 2,2, Q[Qspg]);
  Gadgets[296]:=G;


(* gPosition, Search Bool: (MaxExtras-4) *)
  AddGadget(G, 488,82 , 0,0, GFS{}, AFS{relVerify,toggleSelect},
              NIL,NIL,NIL,NIL,30,NIL);
  SetGadgetImage(G,FALSE,Grafik[75]);
  Gadgets[288]:=G;

(* Help *)
  AddGadget(G, 488,112,0,0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,85,NIL);
  SetGadgetImage(G,FALSE,Grafik[85]);

(* Max games show Infolines:  (MaxExtras-4) *)
  AddGadget(G, 73*8-10,26*Ys-2, 5*8+8,10, GFS{}, AFS{gadgImmediate,relVerify},
              NIL,NIL,NIL,NIL,62+MaxExtras-4,NIL);
  AddStringInfo(G,5,"");
  AddIntuiText(G, 1,2, DrawModeSet{dm0}, -10*8,1, Q[TAGo+MaxExtras-4]);
  AddBorder(G,FALSE,-2,-2,3,2,DrawModeSet{dm0},5,OutLine(G));
  Gadgets[320+MaxExtras-4]:=G;

END InitTextGadgetsPGN;

(* Mode0=Ret PGN TAGS,  Mode1=Ret Filter, *)
PROCEDURE GetTextPGN(Mode:SHORTINT):BOOLEAN;
VAR
  gad       :GadgetPtr;
  msg       :IntuiMessagePtr;
  class     :IDCMPFlagSet;
  gnr,n,TH  :INTEGER;
  WFS       :WindowFlagSet;
  Stop,OK   :BOOLEAN;
  ModeEq1   :BOOLEAN;
  TitlePtr  :ADDRESS;
  Clr       :ARRAY[0..4] OF CHAR;
  StrV      :ARRAY[0..1000] OF CHAR;
  mcode,lgt,p :CARDINAL;
  err,Bool  :BOOLEAN;
  ch1       :CHAR;
PROCEDURE Help;
BEGIN
  TH:=TxtHlp;
  Bool:=TH<50;
  IF Bool THEN
    TH:=TH+50;
    Copy(StrV,Q[338]^); (* 338='      Bool ' *)
  ELSE
    StrV:='           ';
  END;
  IF (TH>=49) & ((TH<85) OR (TH>=193) & (TH<=196)) THEN
    IF (TH>49) & (TH<85) & (~Bool OR (TH<>80) & (TH<>83)) & (Bool OR (TH<>79)) THEN
      Concat(StrV,Q[TAGo+TH-62]^);
      Concat(StrV,'\n\n');
    END;
    IF TH=58 THEN TH:=57 END;          (* BlackTitle=WhiteTitle *)
    IF TH=60 THEN TH:=59 END;          (* BlackElo=W     *)
    IF TH=62 THEN TH:=61 END;          (* BlackUSCF=W    *)
    IF TH=78 THEN TH:=77 END;          (* BlackCountry=W *)
    IF Bool & (TH=80) THEN TH:=62 END; (* Position       *)
    IF Bool & (TH=83) THEN TH:=78 END; (*     =          *)
    IF ~Bool & (TH=79) THEN TH:=85 END;(* Pattern Search *)
    IF TH>=193 THEN TH:=TH-193+86; END;(* org,clr,pgn,app*)
    Concat(StrV,Q[QFilterHelp+TH-49]^);
    IF SimpleWIN(ADR(StrV))=0 THEN END;
  END;
END Help;
BEGIN
(*$ IF Test*)
  d(s('GetTextPGN'));
(*$ ENDIF *)
  TxtHlp:=-1;
  OK:=FALSE;
  Later:=0;
  IF TGPGN=NIL THEN 
    InitTextGadgetsPGN(TGPGN);
  END;

  IF TGPGN<>NIL THEN

    Clr:=0C;
    ModeEq1:=Mode=1;
    IF ModeEq1 THEN
      TitlePtr:=Q[Qtitlefilter];
    ELSE
      TitlePtr:=Q[Qtitlepgninfo];
    END;
    FOR n:=gEvent TO MaxExtras DO
      IF ModeEq1 THEN
        SetToggl(Gadgets[n+270],wptrT,gInverse[n]);
        SetString(Gadgets[n+320],gFilters[n]);
      ELSE
        SetToggl(Gadgets[n+270],wptrT,FALSE);
        SetString(Gadgets[n+320],gExtras[n]);
      END;
    END;
    SetGadget(Gadgets[MaxExtras  +270],wptrT,ModeEq1);
    SetGadget(Gadgets[MaxExtras  +320],wptrT,ModeEq1);
    SetGadget(Gadgets[MaxExtras-1+270],wptrT,ModeEq1);
    SetGadget(Gadgets[MaxExtras-1+320],wptrT,ModeEq1);
    SetGadget(Gadgets[MaxExtras-2+270],wptrT,ModeEq1);
    SetGadget(Gadgets[MaxExtras-2+320],wptrT,ModeEq1);
    SetGadget(Gadgets[MaxExtras-3+270],wptrT,ModeEq1);
    SetGadget(Gadgets[MaxExtras-3+320],wptrT,ModeEq1);
    SetGadget(Gadgets[MaxExtras-4+270],wptrT,ModeEq1);
    SetGadget(Gadgets[MaxExtras-4+320],wptrT,ModeEq1);
    SetGadget(Gadgets[296],wptrT,ModeEq1);
    SetGadget(Gadgets[gExt17+270],wptrT,ModeEq1);
    SetGadget(Gadgets[gExt17+320],wptrT,ModeEq1);
    SetToggl(Gadgets[296],wptrT,TRUE);


    WFS:=WindowFlagSet{windowDrag,windowClose};
    gnr:=0;
    REPEAT
      INC(gnr);

      AddWindow(wptrT,TitlePtr, 2,2, 636,254, 0,1, 
              IDCMPFlagSet{inactiveWindow,activeWindow,closeWindow,
                           gadgetDown,gadgetUp,refreshWindow,rawKey}, (* intuiTicks *)
                           WFS, TGPGN, sptr, NIL, 1,0, -1,-1);
      IF wptrT=NIL THEN 
        INCL(WFS,simpleRefresh);
      END;
    UNTIL (wptrT<>NIL) OR (gnr>1);

    IF wptrT<>NIL THEN
      ActivateWindow(wptrT);
      Stop:=FALSE;
(*
      IF ActivateGadget(Gadgets[gEvent+320],wptrT,NIL) THEN END;
*)
      REPEAT
        WaitPort(wptrT^.userPort);         (* vent på input (message) *)
        msg   :=GetMsg(wptrT^.userPort);   (* overfør msg-class og evt. gadget ptr*)
        class :=msg^.class; (*IDCMPFlags*) (* til egne variable class, gad*)
        gad   :=msg^.iAddress;
        mcode :=msg^.code;
        ReplyMsg(msg);                     (* returner/frigør message *)

(*$ IF Test0 *)
        IF activeWindow IN class THEN      (* eksekver den/de? modtagede messages *)
          IF ActivateGadget(Gadgets[gEvent+320],wptrT,NIL) THEN END;
        END;
        IF refreshWindow IN class THEN      (* kun ved simplerefresh vindue *)
        END;
(*$ ENDIF *)

        IF closeWindow IN class THEN
          Stop:=TRUE;
          gnr:=229;
        END;
        IF rawKey IN class THEN
          IF mcode=kEsc THEN
            Stop:=TRUE;
            gnr:=229;
          ELSIF (mcode=kCr) OR (mcode=kCrN) THEN
            Stop:=TRUE;
            gnr:=228;
          ELSIF mcode=kHelp THEN
            Help;
          END;
        END;
        IF gadgetDown IN class THEN
          TxtHlp:=gad^.gadgetID;
        END;
        IF gadgetUp IN class THEN
          gnr:= gad^.gadgetID;
          CASE gnr OF
            |  228..229  : Stop:=TRUE;
            |  50..77    : IF ActivateGadget(Gadgets[gnr-62+320+1],wptrT,NIL) THEN END;
            |  78        : IF ActivateGadget(Gadgets[gEvent+320],wptrT,NIL) THEN END;
            |  85        : Help;
            |  193 : (* Qoriginal *)
              FOR n:=gEvent TO MaxExtras DO
                IF Mode=1 THEN
                  SetToggl(Gadgets[n+270],wptrT,gInverse[n]);
                  SetString(Gadgets[n+320],gFilters[n]);
                ELSE
                  SetToggl(Gadgets[n+270],wptrT,FALSE);
                  SetString(Gadgets[n+320],gExtras[n]);
                END;
                RefreshGadget(Gadgets[n+320],wptrT);
              END;
            |  194 : (* Qclear *)
              FOR n:=gEvent TO MaxExtras DO
                SetToggl(Gadgets[n+270],wptrT,FALSE);
                SetString(Gadgets[n+320],Clr);
                RefreshGadget(Gadgets[n+320],wptrT);
              END;
            |  195 : (* Qpgn *)
              FOR n:=gEvent TO MaxExtras DO
                IF Mode=1 THEN
                  SetString(Gadgets[n+320],gExtras[n]);
                ELSE
                  SetString(Gadgets[n+320],gFilters[n]);
                END;
                RefreshGadget(Gadgets[n+320],wptrT);
              END;
            | 196 : (* Qspg (append) *)
          ELSE
          END;
          IF (gnr<85) OR (gnr>=193) & (gnr<=196) THEN
            TxtHlp:=gnr;
          END;
        END;
      UNTIL Stop;

      ExitT;

      IF (gnr=228) THEN
        IF (Mode=1) & GetToggle(296) THEN
          Later:=2;
        END;
        FOR n:=gEvent TO MaxExtras DO
          IF Mode=1 THEN
            GetString(Gadgets[320+n],gFilters[n]);
            gFlags[n]:= ~(gFilters[n,0]=0C);
            gInverse[n]:=~GetToggle(270+n);
          ELSE
            GetString(Gadgets[320+n],gExtras[n]);

            (* på åååå så tilføj .??.?? hvis nødvendigt, ddmmåå accept *)
            IF (n=gDate) OR (n=gEventDate) THEN 
              lgt:= Length(gExtras[n]);
              IF lgt=6 THEN
                gExtras[n,10]:=0C;
                gExtras[n,9]:=gExtras[n,1];
                gExtras[n,8]:=gExtras[n,0];
                gExtras[n,7]:='.';
                gExtras[n,6]:=gExtras[n,3];
                gExtras[n,3]:=gExtras[n,5];
                gExtras[n,5]:=gExtras[n,2];
                gExtras[n,2]:=gExtras[n,4];
                gExtras[n,4]:='.';
                IF gExtras[n,2]<'2' THEN (* virke fra 1920 til 2019 *)
                  gExtras[n,1]:='0';
                  gExtras[n,0]:='2';
                ELSE
                  gExtras[n,1]:='9';
                  gExtras[n,0]:='1';
                END;
              ELSIF (lgt<>10) & (lgt>0) THEN
                IF (gExtras[n,5]>'1') OR (gExtras[n,5]='1') & (gExtras[n,6]>'2') THEN
                  ch1:=gExtras[n,8];
                  gExtras[n,8]:=gExtras[n,5];
                  gExtras[n,5]:=ch1;
                  ch1:=gExtras[n,9];
                  gExtras[n,9]:=gExtras[n,6];
                  gExtras[n,6]:=ch1;
                END;
                FOR p:=0 TO 9 DO
                  IF (p=4) OR (p=7) THEN
                    gExtras[n,p]:='.'; 
                  ELSE
                    IF (gExtras[n,p]<'0') OR (gExtras[n,p]>'9') THEN
                      gExtras[n,p]:='?';
                    END;
                  END;
                END;
                gExtras[10]:=0C;
              END;
            END;

          END;
        END;
        OK:=TRUE;
      END;

    END;
  END;
  RETURN(OK);
END GetTextPGN;

CONST
  GFGlines=20;
  GFGlsize=10;
  GFGstx  =40;
  GFGicons=228;

VAR
  FG67,FG69,FG71,FG73:GadgetPtr;

PROCEDURE InitGetFilterGameGadgets(VAR G:GadgetPtr);
VAR
  n:INTEGER;
BEGIN
  FOR n:=1 TO GFGlines DO
    AddGadget(G, 8,4+n*GFGlsize, 624,GFGlsize, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,n,NIL);
  END;

  (* start/tilbage/frem/enden *)
  AddGadget(G, GFGstx, GFGicons,  0, 0, GFS{gadgDisabled},AFS{relVerify},
            NIL,NIL,NIL,NIL,67,NIL);
  FG67:=G;
  SetGadgetImage(G,FALSE,Grafik[67]);
  AddGadget(G, GFGstx+36, GFGicons,  0, 0, GFS{gadgDisabled},AFS{relVerify},
            NIL,NIL,NIL,NIL,69,NIL);
  FG69:=G;
  SetGadgetImage(G,FALSE,Grafik[69]);
  AddGadget(G, GFGstx+72, GFGicons,  0, 0, GFS{gadgDisabled},AFS{relVerify},
            NIL,NIL,NIL,NIL,71,NIL);
  FG71:=G;
  SetGadgetImage(G,FALSE,Grafik[71]);
  AddGadget(G, GFGstx+108, GFGicons,  0, 0, GFS{gadgDisabled},AFS{relVerify},
            NIL,NIL,NIL,NIL,73,NIL);
  FG73:=G;
  SetGadgetImage(G,FALSE,Grafik[73]);

  AddGadget(G, 200,GFGicons, 52,10, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,100,NIL);
  AddIntuiText(G, 2,3, DrawModeSet{dm0}, 2,1, Q[Qall0]);
  AddGadget(G, 260,GFGicons, 52,10, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,101,NIL);
  AddIntuiText(G, 2,3, DrawModeSet{dm0}, 2,1, Q[Qall1]);
  AddGadget(G, 320,GFGicons, 52,10, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,102,NIL);
  AddIntuiText(G, 2,3, DrawModeSet{dm0}, 2,1, Q[Qwin0]);
  AddGadget(G, 380,GFGicons, 52,10, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,103,NIL);
  AddIntuiText(G, 2,3, DrawModeSet{dm0}, 2,1, Q[Qwin1]);
  AddGadget(G, 380,GFGicons+13, 52,10, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,104,NIL);
  AddIntuiText(G, 2,3, DrawModeSet{dm0}, 2,1, Q[321]);  (*ADR('Delete')*)
  AddGadget(G, 320,GFGicons+13, 52,10, GFS{}, AFS{relVerify},
              NIL,NIL,NIL,NIL,105,NIL);
  AddIntuiText(G, 2,3, DrawModeSet{dm0}, 2,1, Q[Qspg]);  (*ADR('Append')*)

  (* OK, UPS *)
  AddGadget(G, 558, GFGicons,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,228,NIL);
  SetGadgetImage(G,FALSE,Grafik[101]);
  AddGadget(G, 458, GFGicons,  0, 0, GFS{},AFS{relVerify},
            NIL,NIL,NIL,NIL,229,NIL);
  SetGadgetImage(G,FALSE,Grafik[103]);
END InitGetFilterGameGadgets;

VAR
  GFGoffset:=LONGINT{0};
  GFGselected:LONGINT;
  GFGlast:BOOLEAN;


PROCEDURE WrGFGselected(rp:RastPortPtr);
VAR
  st:ARRAY[0..16] OF CHAR;
  err:BOOLEAN;
BEGIN
(*$ IF Test*)
  d(s('WrGFGselected'));
(*$ ENDIF *)

  WITH itx DO
    frontPen:=Color1white;
    backPen:=Color0blue;
    itx.iText:=ADR(st);
  END;
(*
    drawMode:=DrawModeSet{dm0};
    leftEdge:=0;
    topEdge:=0;
    iTextFont:=NIL;
    nextText:=NIL;
  END;
*)
  IF GFGselected<0 THEN
    itx.iText:=ADR('negative');
    PrintIText(rp,ADR(itx),200,GFGicons+13);
  ELSE
    ValToStr(GFGselected,FALSE,st,10,9,' ',err);
    PrintIText(rp,ADR(itx),220,GFGicons+13);
  END;
END WrGFGselected;

PROCEDURE ReArrow(wptrT:WindowPtr);
BEGIN
  IF GFGoffset=0 THEN
    SetGadget(FG67,wptrT,FALSE);
    SetGadget(FG69,wptrT,FALSE);
  ELSE
    SetGadget(FG67,wptrT,TRUE);
    SetGadget(FG69,wptrT,TRUE);
  END;
  IF GFGlines+GFGoffset>=LLP THEN
    SetGadget(FG71,wptrT,FALSE);
    SetGadget(FG73,wptrT,FALSE);
  ELSE
    SetGadget(FG71,wptrT,TRUE);
    SetGadget(FG73,wptrT,TRUE);
  END;
END ReArrow;

PROCEDURE Relist(wptrT:WindowPtr; Posi:INTEGER);
VAR
  n,fra,til,m:INTEGER;
  st:ARRAY[0..80] OF CHAR;
  stv:ARRAY[0..16] OF CHAR;
  err:BOOLEAN;
  rp:RastPortPtr;
(*
  itx      :IntuiText;
*)
BEGIN
  IF (LL<>NIL) & (wptrT<>NIL) THEN
    rp:=wptrT^.rPort;
    st[0]:=0C;
    IF GFGoffset<0 THEN
      GFGoffset:=0;
    END;
    IF Posi=0 THEN
      fra:=1;
      til:=GFGlines;
    ELSE
      fra:=Posi;
      til:=Posi;
    END;
(*$ IF Test*)
  d(s('Relist, fra=')+l(fra)+s(' til=')+l(til)+s(' GFGo=')+l(GFGoffset));
(*$ ENDIF *)
    FOR n:=fra TO til DO
      itx.frontPen:=Color2black;
      itx.backPen :=Color1white;
      IF (n+GFGoffset>LLP) THEN
        IF st[0]=0C THEN
          FOR m:=7 TO 79 DO
            st[m]:=' ';
          END;
          st[77]:=0C;
        END;
        FOR m:=0 TO 6 DO
          st[m]:=' ';
        END;
        itx.iText :=ADR(st);
      ELSE
        IF (LL^[n+GFGoffset].Text=NIL) THEN
          IF st[0]=0C THEN
            FOR m:=0 TO 79 DO 
              st[m]:=' ';
            END;
            st[77]:=0C;
          END;
          ValToStr(n+GFGoffset,FALSE,stv,10,7,' ',err);
          m:=0;
          WHILE stv[m]<>0C DO
            st[m]:=stv[m];
            INC(m);
          END;
          itx.iText :=ADR(st);
        ELSE
          itx.iText :=LL^[n+GFGoffset].Text;
        END;
        IF LL^[n+GFGoffset].Attr<>0 THEN
          itx.frontPen:=Color2black;
          itx.backPen :=Color3orange;
        END;
      END;
      PrintIText(rp,ADR(itx),12,5+n*GFGlsize);
    END;
    ReArrow(wptrT);
  END;
END Relist;

VAR
  seconds1,micros1,seconds2,micros2:LONGINT;
  ctNr:INTEGER;

(* retur:   -3 : WptrT=NIL  -2 : NoMsg  -1 : NoSpecialActions  0 : Esc  1: OK *)
PROCEDURE EM(wptrT:WindowPtr; Active:BOOLEAN):INTEGER;
VAR
  gnr        :INTEGER;
  n          :LONGINT;
  gad        :GadgetPtr;
  msg        :IntuiMessagePtr;
  class      :IDCMPFlagSet;
  mcode      :CARDINAL;
  rp         :RastPortPtr;
  Stop       :BOOLEAN;
PROCEDURE g69;
BEGIN
  GFGlast:=FALSE;
  IF GFGoffset>=GFGlines THEN
    GFGoffset:=GFGoffset-GFGlines
  ELSE
    GFGoffset:=0
  END;
  Relist(wptrT,0);
END g69;
PROCEDURE g71;
BEGIN
(*$ IF Test*)
  d(s('g71'));
(*$ ENDIF *)
  GFGlast:=FALSE;
  IF GFGoffset+GFGlines<LLP THEN
    GFGoffset:=GFGoffset+GFGlines;
    Relist(wptrT,0);
  END;
END g71;
PROCEDURE g73;
BEGIN
(*$ IF Test*)
  d(s('g73'));
(*$ ENDIF *)
  GFGlast:=TRUE; 
  WHILE GFGoffset+GFGlines<LLP DO
    GFGoffset:=GFGoffset+GFGlines;
  END;
  Relist(wptrT,0);
END g73;
BEGIN
(*$ IF Test*)
  d(s('EM'));
(*$ ENDIF *)
  gnr:=-3;
  DoubleSelect:=-1;
  IF wptrT<>NIL THEN
    rp:=wptrT^.rPort;
    gnr:=-2;
    msg   :=GetMsg(wptrT^.userPort);   (* overfør msg-class og evt. gadget ptr*)
    IF msg<>NIL THEN
      gnr:=-1;
      class :=msg^.class; (*IDCMPFlags*) (* til egne variable class, gad*)
      gad   :=msg^.iAddress;
      mcode :=msg^.code;
      ReplyMsg(msg);                     (* returner/frigør message *)
    (*$ IF Test0*)
      IF activeWindow IN class THEN      (* eksekver den/de? modtagede messages *)
      END;
      IF refreshWindow IN class THEN      (* kun ved simplerefresh vindue *)
      END;
    (*$ ENDIF *)
       IF closeWindow IN class THEN
        gnr:=0;
      END;
      IF rawKey IN class THEN
        IF mcode=kEsc THEN
          gnr:=0;
        ELSIF (mcode=kCr) OR (mcode=kCrN) (* space=40H *) THEN
          gnr:=1;
        ELSIF mcode=kHome THEN
          GFGlast:=FALSE; 
          GFGoffset:=0;
          Relist(wptrT,0);
        ELSIF mcode=kEnd  THEN
          g73;
        ELSIF mcode=kPgUp THEN
          g69;
        ELSIF mcode=kPgDn THEN
          g71;
        ELSIF (mcode=kRt) OR (mcode=kRtN) THEN
        ELSIF (mcode=kLt) OR (mcode=kLtN) THEN
        ELSIF (mcode=kUp) OR (mcode=kUpN) THEN
          GFGlast:=FALSE;
          IF GFGoffset>0 THEN
            DEC(GFGoffset);
            Relist(wptrT,0);
          END;
        ELSIF (mcode=kDn) OR (mcode=kDnN) THEN
          GFGlast:=FALSE;
          IF GFGoffset+1<LLP THEN
            INC(GFGoffset);
            Relist(wptrT,0);
          END;
        ELSIF mcode=kHelp THEN
          IF SimpleWIN(ADDRESS(Q[337]))=0 THEN END;
        END;
      END;
      IF gadgetUp IN class THEN
        gnr:= gad^.gadgetID;
        CASE gnr OF
          |1..GFGlines : Stop:=FALSE;
                         IF gnr+GFGoffset<=LLP THEN
                           seconds1:=seconds2;
                           micros1:=micros2;
                           CurrentTime(ADR(seconds2),ADR(micros2));
                           IF (gnr=ctNr) & DoubleClick(seconds1,micros1,seconds2,micros2) THEN
                             Stop:=TRUE;
                             DoubleSelect:=gnr+GFGoffset;
                           ELSE
(*$ IF Test*)
  d(s('EM.ctNr=gnr'));
(*$ ENDIF *)
                             ctNr:=gnr;
                             IF LL^[gnr+GFGoffset].Attr=0 THEN
                               LL^[gnr+GFGoffset].Attr:=1;
                               INC(GFGselected);
                             ELSE
                               LL^[gnr+GFGoffset].Attr:=0;
                               DEC(GFGselected);
                             END;
                           END;
                         END;
                         WrGFGselected(rp);
                         Relist(wptrT,gnr);
                         IF Stop THEN
                           gnr:=1;
                         ELSE
                           INC(gnr); (* for at undgå 1 der ses som stop *)
                         END;
          |   67       : GFGlast:=FALSE; 
                         GFGoffset:=0;
                         Relist(wptrT,0);
          |   69       : g69;
          |   71       : g71;
          |   73       : g73;
          |  100       : FOR n:=1 TO LLP DO
                           LL^[n].Attr:=0;
                           GFGselected:=0;
                         END;
                         WrGFGselected(rp);
                         Relist(wptrT,0);
          |  101       : FOR n:=1 TO LLP DO  
                           LL^[n].Attr:=1;
                           GFGselected:=LLP;
                         END;
                         WrGFGselected(rp);
                         Relist(wptrT,0);
          |  102       : FOR n:=GFGoffset+1 TO GFGoffset+GFGlines DO  
                           IF n<=LLP THEN 
                             IF LL^[n].Attr=1 THEN
                               LL^[n].Attr:=0;
                               DEC(GFGselected);
                             END;
                           END;
                         END;
                         WrGFGselected(rp);
                         Relist(wptrT,0);
          |  103       : FOR n:=GFGoffset+1 TO GFGoffset+GFGlines DO  
                           IF n<=LLP THEN 
                             IF LL^[n].Attr=0 THEN
                               LL^[n].Attr:=1;
                               INC(GFGselected);
                             END;
                           END;
                         END;
                         WrGFGselected(rp);
                         Relist(wptrT,0);
          |  104       : IF TwoGadWIN(ADDRESS(Q[Q220]))=1 THEN
                           Later2:=1;
                           gnr:=1;
                         END;
          |  105       : Later2:=2;
                         gnr:=1; 
          |  228       : gnr:=1;
          |  229       : gnr:=0;
        ELSE
        END;
      END;
    END;
(*$ IF Test*)
  d(s('LLP=')+l(LLP)+s(' , GFGoffset=')+l(GFGoffset));
(*$ ENDIF *)
    IF Active THEN
      IF GFGlast & (GFGoffset+GFGlines<LLP) THEN
        GFGoffset:=GFGoffset+GFGlines;
(*$IF Test *)
  WRITELN(s('GFGLast, Relist0:, GFGo=')+l(GFGoffset)+s(' LLSIZE=')+l(LLSIZE)); 
(*$ENDIF *)
        Relist(wptrT,0);
      ELSE
        IF (GFGoffset<LLP) & (LLP<=GFGoffset+GFGlines) THEN
(*$ IF Test*)
  d(s('Relist LLP=')+l(LLP)+s(' - GFGoffset=')+l(GFGoffset));
(*$ ENDIF *)
          Relist(wptrT,LLP-GFGoffset);
        ELSE
          IF LLP=GFGlines+1 THEN
            ReArrow(wptrT);
          END;
        END;
      END;
    END;
  END;
  RETURN(gnr);
END EM;

PROCEDURE ListPick(LoadList:LL20PROC):BOOLEAN;
VAR
  gnr,n      :INTEGER;
  WFS        :WindowFlagSet;
  Stop,OK,err:BOOLEAN;
  Title,str,p:ARRAY[0..78] OF CHAR;
  pc         :ARRAY[0..16] OF CHAR;
  TitlePtr   :ADDRESS;
  rp         :RastPortPtr;
  PIGstat,PIh:LONGINT;
BEGIN
(*$ IF Test*)
  d(s('ListPick, GetFilterGame20'));
(*$ ENDIF *)
  Later2:=0;
  OK:=FALSE;
  GFGlast:=FALSE;
  IF TGFG=NIL THEN 
    InitGetFilterGameGadgets(TGFG); 
  END;

  IF TGFG<>NIL THEN
    TitlePtr:=Q[Qtitlepick];
    WFS:=WindowFlagSet{windowDrag,windowClose};
    gnr:=0;
    REPEAT
      INC(gnr);
      AddWindow(wptrT,TitlePtr, 0,2, 640,254, 0,1, 
              IDCMPFlagSet{activeWindow,closeWindow,gadgetDown,gadgetUp,
              refreshWindow,rawKey},WFS,TGFG,sptr,NIL, 1,0, -1,-1);
      IF wptrT=NIL THEN 
        INCL(WFS,simpleRefresh);
      END;
    UNTIL (wptrT<>NIL) OR (gnr>1);

    IF wptrT<>NIL THEN
      rp:=wptrT^.rPort;

      SetAPen(rp,Color3orange);
      Move(rp,  6, 12);
      Draw(rp,633, 12);
      Draw(rp,633,215);
      Draw(rp,  6,215);
      Draw(rp,  6, 12);

      ActivateWindow(wptrT);
      IF LoadList<>NIL THEN
        WITH itx DO
          frontPen:=Color1white;
          backPen:=Color0blue;
          iText :=Q[Qreadinglist]; (* 'READING LIST, read:' *)
        END;
        PrintIText(rp,ADR(itx),30,GFGicons-11);
        GFGoffset:=0;
        GFGselected:=0;
        gnr:=LoadList(wptrT); (* Skak20Fil.LL20 *)
        WITH itx DO
          frontPen:=Color1white;
          backPen:=Color0blue;
          iText:=ADR('                     ');
        END;
        PrintIText(rp,ADR(itx),30,GFGicons-11);
      ELSE
        gnr:=-4;
      END;
      WHILE GFGoffset>=LLP DO
        GFGoffset:=GFGoffset-GFGlines; 
      END;
      IF LL=NIL THEN (* INGEN TEKST !!! *)
        WITH itx DO
          frontPen:=Color1white;
          backPen:=Color0blue;
          itx.iText :=Q[Qnotext];
        END;
        PrintIText(rp,ADR(itx),70,5+8*GFGlsize);
      ELSE
        PIGstat:=PIGstat0+PIGstat1+PIGstat2+PIGstat3;
        PIh:=PIGstat DIV 2;
        ValToStr(PIGstat,FALSE,p,10,6,' ',err);
        ConcatChar(p,'/');
        ValToStr(PIGtotal,FALSE,pc,10,1,' ',err);
        Concat(p,pc);
        ConcatChar(p,'+');
        ValToStr(PIGdeleted,FALSE,pc,10,1,' ',err);
        Concat(p,pc);
  
        IF PIGstat>0 THEN
          Concat(p,'   ');
          ValToStr((PIGstat0*100+PIh) DIV PIGstat,FALSE,pc,10,1,' ',err);
          Concat(p,pc);
          ConcatChar(p,'-');
          ValToStr((PIGstat2*100+PIh) DIV PIGstat,FALSE,pc,10,1,' ',err);
          Concat(p,pc);
          ConcatChar(p,'-');
          ValToStr((PIGstat1*100+PIh) DIV PIGstat,FALSE,pc,10,1,' ',err);
          Concat(p,pc);
          Concat(p,' %');
        END;
        WITH itx DO
          frontPen:=Color1white;
          backPen:=Color0blue;
          iText :=ADR(p);
        END;
        PrintIText(rp,ADR(itx),202,GFGicons-9);
      END;
      IF (gnr<>0) & (gnr<>1) THEN
        WrGFGselected(rp);
        Relist(wptrT,0);
        REPEAT
          WaitPort(wptrT^.userPort);         (* vent på input (message) *)
          gnr:=EM(wptrT,FALSE);
        UNTIL (gnr=0) OR (gnr=1);
      END;
 
      ExitT;

      IF (gnr=1) THEN
        IF (GFGselected>0) & (Later2=0) THEN DEC(GFGselected) END;
        OK:=TRUE;
      END;

    END;
  END;
  RETURN(OK);
END ListPick;

PROCEDURE Config():BOOLEAN;
BEGIN
END Config;

PROCEDURE ClearGadgetArea;
BEGIN
(*$ IF Test*)
  d(s('ClearGadgetArea'));
(*$ ENDIF *)
  SetAPen(rp,Color0blue);
  RectFill(rp,stx,10,stx+143,MaxWinY);
END ClearGadgetArea;

PROCEDURE MakeSty(Styrke,Gnr:INTEGER);              (* Gnr = 30 | 40 *)
VAR
  n:INTEGER;
BEGIN
(*$ IF Test*)
  d(s('MakeSty'));
(*$ ENDIF *)
  FOR n:=1 TO 9 DO
    IF (n=1) OR (n=4) OR (n=7) THEN
      SetToggl(Gadgets[Gnr+n],wptr,Styrke=n);
      SetGadget(Gadgets[Gnr+n],wptr,Styrke<>0);
    END;
  END;
END MakeSty;

(*$ IF Test*)
  PROCEDURE C(ch:CHAR):CARDINAL;
  BEGIN
    RETURN(c(ch));
  END C;
(*$ ENDIF *)

PROCEDURE ReDraw(VAR Stil,Domi,Mund,Sele:STILLINGTYPE);
VAR
  X,Y,bn,gn,XY,Xv,Yv,Xo,Yo,Go,grnr,mx,my:CARDINAL;
  Yp,nt,np,Ym:INTEGER;
  c:CHAR;
  InfoS,Info2,st:ARRAY[0..10] OF CHAR;
  Sud:ARRAY[0..40] OF CHAR;
  HvidsTur,Under:BOOLEAN;
BEGIN
(*$ IF Test*)
  d(s("ReDraw"));
(*$ ENDIF *)
  HvidsTur:=Stil[HvisTur]='H';
  IF SetUpMode<>SetUC THEN
(*$ IF Test*)
  d(s("ReDrawSt"));
(*$ ENDIF *)
    SetUC:=SetUpMode;
    Forbid;
      IF SetUpMode=1 THEN
        BGE^.nextGadget:=SG;    (* Sæt Board og Main gadget lister sammen *)
      ELSIF SetUpMode=0 THEN
        BGE^.nextGadget:=MG;    (* Sæt Board og SetUp gadget lister sammen *)
      ELSE
(* Teori management *)
      END;
    Permit;
    ClearGadgetArea;
    IF ValgC>188 THEN
      ValgC:=0;
    END;
    RefreshGList(BGE^.nextGadget,wptr,NIL,-1);
    Valg:=0;
    IF SetUpMode<>1 THEN
      StyOC:=-1;
      StyUC:=-1;
      StilC[HvisTur]:='.';
    END;
  END;
  IF SetUpMode=1 THEN
    SetToggl(Gadgets[95],wptr,HvidsTur);
  END;
  IF (SetUpMode<>1) AND (Stil[HvisTur]<>StilC[HvisTur]) THEN
(*$ IF Test*)
  d(s("ReDrawA"));
(*$ ENDIF *)
    StilC[HvisTur]:=Stil[HvisTur];
    IF HvidsTur THEN
      SetGadgetImage(Gadgets[30],FALSE,Grafik[33]);
      SetGadgetImage(Gadgets[30],TRUE,Grafik[36]);
      SetGadgetImage(Gadgets[40],FALSE,Grafik[32]);
      SetGadgetImage(Gadgets[40],TRUE,Grafik[35]);
    ELSE
      SetGadgetImage(Gadgets[30],FALSE,Grafik[32]);
      SetGadgetImage(Gadgets[30],TRUE,Grafik[35]);
      SetGadgetImage(Gadgets[40],FALSE,Grafik[33]);
      SetGadgetImage(Gadgets[40],TRUE,Grafik[36]);
    END;
    RefreshGadget(Gadgets[30],wptr);
    RefreshGadget(Gadgets[40],wptr);
    VlmOC:=-1; VlmUC:=-1; VlpOC:=-1; VlpUC:=-1;
  END;   
  IF SetUpMode<>1 THEN
    IF StyOC<>StyO THEN
      IF (StyOC=0) & (StyO<>0) OR (StyOC<>0) & (StyO=0) THEN
        VlmOC:=-1;
        VlpOC:=-1;
      END;
      StyOC:=StyO;
      MakeSty(StyO,30);
    END;
    IF StyUC<>StyU THEN
      IF (StyUC=0) & (StyU<>0) OR (StyUC<>0) & (StyU=0) THEN
        VlmUC:=-1;
        VlpUC:=-1;
      END;  
      StyUC:=StyU;
      MakeSty(StyU,40);
    END;
    IF MouthOff THEN
(*
      SetAPen(rp,Color1white);
      RectFill(rp,532,77-46,532+50-1,77-46+9-1);
      RectFill(rp,532,77+46,532+50-1,77+46+9-1);
*)
(*
      DrawImage(rp,Grafik[128],532,77-46);
      DrawImage(rp,Grafik[128],532,77+46);
*)
    ELSE                                           (* stx=494 *)
      Yp:=(MundY2-MundY1) DIV 2;
      Ym:=MundY1+Yp;
      IF ~OpAd THEN Yp:=-Yp END;
      IF VlmO<>VlmOC THEN (* 44-52 Value materiel, venstre mund 1-9 (vm1-vm9) *)
        DrawImage(rp,Grafik[44+VlmO],stx+38,Ym-Yp);
        VlmOC:=VlmO;
      END;
      IF VlpO<>VlpOC THEN (* 53-61 Value positionel, højre mund 1-9 (hm1-hm9) *)
        DrawImage(rp,Grafik[53+VlpO],stx+62,Ym-Yp);
        VlpOC:=VlpO;
      END;
      IF VlmU<>VlmUC THEN
        DrawImage(rp,Grafik[44+VlmU],stx+38,Ym+Yp);
        VlmUC:=VlmU;
      END;
      IF VlpU<>VlpUC THEN
        DrawImage(rp,Grafik[53+VlpU],stx+62,Ym+Yp);
        VlpUC:=VlpU;
      END;
    END;
  END;
  IF (TraeC<>TraekNr) OR (MaxTC<>MaxTraek) THEN
    (* skriv Trknr/max *)

    IF ~ODD(TraekNr) THEN
      Info2:='  0. ... ';
    ELSE
      Info2:='  0. ';
    END;
    nt:=(TraekNr+1) DIV 2;
    np:=2;
    REPEAT
      Info2[np]:=CHR(nt MOD 10+48);
      nt:=nt DIV 10;
      DEC(np);
    UNTIL (nt=0) OR (np<0);

    nt:=MaxTraek;
    np:=7;
    InfoS[8]:=0C;
    REPEAT
      InfoS[np]:=CHR(nt MOD 10+48);
      nt:=nt DIV 10;
      DEC(np);
    UNTIL (nt=0) OR (np<2);

    nt:=TraekNr;
    InfoS[np]:='/';
    DEC(np);
    REPEAT
      InfoS[np]:=CHR(nt MOD 10+48);
      nt:=nt DIV 10;
      DEC(np);
    UNTIL (nt=0) OR (np<0);
    WHILE np>=0 DO
      InfoS[np]:=' ';
      DEC(np);
    END;
    IF VariantTil THEN
      Sud:=' Y';
      Info2[0]:=':';
    ELSIF MaxTeori<TraekNr THEN
      Sud:='  ';
    ELSE
      Sud:=' T';
    END;
    Concat(Sud,Info2);
    Concat(Sud,MOVEINFOSTRING);
    IF ODD(TraekNr) THEN
      Concat(Sud,'    ');
    END;
    ConcatChar(Sud,' ');
    Concat(Sud,InfoS);

    WriteText(rp,ADR(Sud),stx-133,1); (* før 359, stx=492 *)

    TraeC:=TraekNr;
    MaxTC:=MaxTraek;
    SetGadget(Gadgets[67],wptr,TraekNr>0);
    SetGadget(Gadgets[69],wptr,TraekNr>0);
    SetGadget(Gadgets[71],wptr,TraekNr<MaxTraek);
    SetGadget(Gadgets[73],wptr,TraekNr<MaxTraek);
  END;

  WriteText (rp,ADR(TIMEINFOSTRING),16,1);

  IF Valg<>ValgC THEN
    IF ValgC>188 THEN
      RefreshGadget(Gadgets[199],wptr);
    ELSE
      IF ValgC>0 THEN
        FOR X:=1 TO 8 DO
          FOR Y:=1 TO 8 DO
            Sele[X+10*Y]:=' ';
          END;
        END; 
        StilC[ValgC-100]:='.';
      END;
    END;
    IF Valg>0 THEN
      IF Valg<189 THEN
        Sele[Valg-100]:='.';
      ELSE
        MarkGadget(Gadgets[Valg],rp);
      END;
    END;
    ValgC:=Valg;
  END; 
  Under:=FALSE;
(*$ IF Test*)
  d(s("ReDrawBa")+C(StilC[88])+C(Stil[88]));
(*$ ENDIF *)
  FOR X:=1 TO 8 DO 
    FOR Y:=1 TO 8 DO
      XY:=X+10*Y;
      c:=Stil[XY];
      IF (Domi[XY]<>DomiC[XY]) AND (Domi[XY]=' ') THEN
(*$ IF Test*)
  d(s("ReDrawBx"));
(*$ ENDIF *)
        StilC[XY]:='.';
      END;
      IF c <> StilC[XY] THEN
(*$ IF Test*)
  d(s("ReDrawB2"));
(*$ ENDIF *)
        StilC[XY]:=c;
        IF ODD(X+Y) THEN gn:=10 ELSE gn:=110 END;
        CASE CAP(c) OF
          | 'M': bn:=0;
          | 'K': bn:=2;
          | 'D': bn:=4;
          | 'R': bn:=6;
          | 'T': bn:=8;
          | 'L': bn:=10;
          | 'S': bn:=12;
          | 'E': bn:=14;
          | 'B': bn:=16;
        ELSE
          bn:=0;
          IF gn=10 THEN gn:=0 ELSE gn:=1 END;
        END;
        IF CAP(c)=c THEN INC(gn) END;
(*$ IF Test*)
  d(s("ReDrawG"));
(*$ ENDIF *)
        SetGadgetImage(Gadgets[100+X+10*Y],FALSE,Grafik[gn+bn]);
        RefreshGadget(Gadgets[100+X+10*Y],wptr);
        SeleC[XY]:=' ';
        DomiC[XY]:=' ';
        MundC[XY]:=' '; (* før Z, . *)
      END;
      IF Sele[XY]<>SeleC[XY] THEN
        IF Sele[XY]<>' ' THEN
          IF HvidsTur & (XY>70) & (Stil[XY]='b') 
          OR ~HvidsTur & (XY<29) & (Stil[XY]='B') THEN
            Under:=TRUE;
          END;
          MarkGadget (Gadgets[XY+100],rp);
        ELSE
          RefreshGadget(Gadgets[XY+100],wptr);
          DomiC[XY]:=' ';
          MundC[XY]:='.'; (* før Z *)
        END;
        SeleC[XY]:=Sele[XY];
      END;
      IF Domi[XY]<>DomiC[XY] THEN
(*$ IF Test*)
  d(s("ReDrawD"));
(*$ ENDIF *)
        IF Domi[XY]='H' THEN
          gn:=4;
          SetAPen(rp,Color1white);
        ELSIF Domi[XY]='S' THEN
          gn:=3;
          SetAPen(rp,Color2black);
        ELSE
          gn:=0;
        END;
        IF gn>0 THEN
(*$ IF Test0 *)
          d(s('Domi ')+l(XY));
          SetDrMd(rp,DrawModeSet{dm0}); (*   ,dm0,complement *)
(*$ ENDIF *)
          IF OpAd THEN
            Xo:=(X-1)*XSize+XOff+3;
            Yo:=(8-Y)*YSize+YOff+2;
          ELSE
            Xo:=(8-X)*XSize+XOff+3;
            Yo:=(Y-1)*YSize+YOff+2;
          END;
          RectFill(rp,Xo,Yo,Xo+4,Yo+2);
(*
          DrawImage(rp,Grafik[gn],(X-1)*XSize+XOff+3,Yv*YSize+YOff+2);
*)
        END;
        DomiC[XY]:=Domi[XY];
      END;
(*$ IF Test*)
  IF MouthOff THEN d(s("MO")) END;
(*$ ENDIF *)
      IF ~MouthOff & (Mund[XY]<>MundC[XY]) & (Stil[XY]<>' ') THEN
(*$ IF Test*)
  d(s("ReDrawC"));
(*$ ENDIF *)
        CASE Mund[XY] OF
          | 'A'      : gn:=5; (* mund1hvid (+100=mund1sort) *)
          | 'B'..'C' : gn:=5;
          | 'D'..'F' : gn:=6; (* m2h *)
          | 'G'..'I' : gn:=6;
          | 'J'..'L' : gn:=7; (* m3h *)
          | 'M'..'O' : gn:=7;
          | 'P'..'R' : gn:=8; (* m4h *)
          | 'S'..'U' : gn:=8;
          | 'V'..'X' : gn:=9; (* m5h *)
          | 'Y'..']' : gn:=9;
          | ' '      : gn:=0;
          ELSE         gn:=9; (* ingen, før 0 !!! *)
        END;
        IF gn>0 THEN
          Xo:=XmR;
          CASE Stil[XY] OF                      (* Mundes placering *)
            | 'k','K','m','M' : Yo:=YmK; 
            | 't','T','r','R' : Yo:=YmT;
            | 'l','L'         : Yo:=YmL;
            | 'd','D'         : Yo:=YmD;
            | 'b','B','e','E' : Yo:=YmB;
            | 's','S'         : Yo:=YmS; Xo:=XmS;
          END;
          IF Stil[XY]>'a' THEN
            Go:=0;
(*
            IF MouthOff THEN
              SetAPen(rp,Color1white);
            END;
*)
          ELSE
            Go:=100;
(*
            IF MouthOff THEN
              SetAPen(rp,Color2black);
            END;
*)
          END;
          IF OpAd THEN (* 5-9 (m1h-m5h) eller 105-109 (m1s-m5s) *)
            IF MouthOff THEN
(*
              mx:=(X-1)*XSize+XOff+Xo;
              my:=(9-Y)*YSize+YOff-Yo;
              RectFill(rp,mx,my,mx+22-1,my+3-1);
*)
            ELSE
              DrawImage(rp,Grafik[gn+Go],(X-1)*XSize+XOff+Xo,(9-Y)*YSize+YOff-Yo);
            END;
          ELSE
            IF MouthOff THEN
(*
               mx:=(8-X)*XSize+XOff+Xo;
               my:=( Y )*YSize+YOff-Yo;
               RectFill(rp,mx,my,mx+22-1,my+3-1);
*)
            ELSE
              DrawImage(rp,Grafik[gn+Go],(8-X)*XSize+XOff+Xo,  Y  *YSize+YOff-Yo);
            END;
          END;
        END;
        MundC[XY]:=Mund[XY];
      END;
    END;
  END;
  IF Under THEN
    IF HvidsTur THEN
      FOR X:=81 TO 88 DO
        IF Sele[X]<>' ' THEN
          UnderShow(Gadgets[X+100]);
        END;
      END;
    ELSE  
      FOR X:=11 TO 18 DO
        IF Sele[X]<>' ' THEN
          UnderShow(Gadgets[X+100]);
        END;
      END;
    END;
  END;
END ReDraw;

PROCEDURE ReDrawAll(VAR Stil,Domi,Mund,Sele:STILLINGTYPE);
VAR
  n:INTEGER;
BEGIN
(*$ IF Test*)
  d(s('ReDrawAll'));
  IF MouthOff THEN d(s("MO")) END;
(*$ ENDIF *)
  FOR n:=11 TO 88 DO
    DomiC[n] := '.';
    MundC[n] := '.';
    SeleC[n] := '.';
    StilC[n] := '.';
  END;
  ValgC:=0;
  StyOC:=StyO+1;
  StyUC:=StyU+1;
  VlmOC:=-1;
  VlmUC:=-1;
  VlpOC:=-1;
  VlpUC:=-1;
(*$ IF Test*)
  d(s("ReDrawAll")+C(StilC[88])+C(Stil[88]));
(*$ ENDIF *)
  ReDraw(Stil,Domi,Mund,Sele);
END ReDrawAll;

PROCEDURE Refresh(VAR Stil,Domi,Mund,Sele:STILLINGTYPE);
BEGIN
  IF Stil[10]='*' THEN
(*$ IF Test*)
  d(s("Refresh")+C(StilC[88])+C(Stil[88]));
  IF MouthOff THEN d(s("MO")) END;
(*$ ENDIF *)
    ReDrawAll(Stil,Domi,Mund,Sele);
  ELSE
    BeginRefresh(wptr);               (* kun ødelagte regioner vil blive *)
      ReDrawAll(Stil,Domi,Mund,Sele); (* gentegnet, resten klippes væk.  *)
    EndRefresh(wptr,TRUE);            (* Herved opnås hurtigere refresh. *)
  END;
END Refresh;

(* Bruges kun på inaktive gadgets. *)
(* Eksisterende x,y ganges med RelX,RelY (normalt -1,0,1) *)
(* Hvis x eller y = -1, så bibeholdes værdi. *)

PROCEDURE MoveGadget(gptr:GadgetPtr; x,y, RelX,RelY:INTEGER);
BEGIN
  IF x <> -1 THEN
    gptr^.leftEdge  := x+RelX*gptr^.leftEdge;
  END;
  IF y <> -1 THEN
    gptr^.topEdge := y+RelY*gptr^.topEdge;
  END;
END MoveGadget;

PROCEDURE SwapGadgetsY(a,b:INTEGER);
VAR
  sw:INTEGER;
BEGIN
  sw:=Gadgets[a]^.topEdge;
  Gadgets[a]^.topEdge:=Gadgets[b]^.topEdge;
  Gadgets[b]^.topEdge:=sw;
END SwapGadgetsY;

PROCEDURE SetOpNed(VAR Stil,Domi,Mund,Sele:STILLINGTYPE; opad:BOOLEAN);
VAR
  gp:GadgetPtr;
  n:CARDINAL;
  res,offo,offu:INTEGER;
  BytStat:BOOLEAN;
BEGIN
(*$ IF Test*)
  d(s("SetOpNed"));
(*$ ENDIF *)
  OpAd:=opad;
  IF OpAd<>OpAdC THEN
    OpAdC:=OpAd;
    gp:=BG;
    n:=1;
    res:=RemoveGList(wptr,BG,-1);
    WHILE (n<65) AND (gp<>NIL) DO
      MoveGadget(gp, 7*XSize+XOff+XOff,7*YSize+YOff+YOff, -1,-1);
      gp:=gp^.nextGadget;
      INC(n);
    END;

    (* flyt over/under ikoner *)
    SwapGadgetsY(30,40);
    SwapGadgetsY(31,41);
    SwapGadgetsY(34,44);
    SwapGadgetsY(37,47);
(*
    IF OpAd THEN
      offo:=0;
      offu:=ply;
    ELSE
      offo:=ply;
      offu:=0;
    END;
    MoveGadget(Gadgets[30],-1,Yo+st7+offo,0,0);
    MoveGadget(Gadgets[31],-1,Yo+st1+offo,0,0);
    MoveGadget(Gadgets[34],-1,Yo+st4+offo,0,0);
    MoveGadget(Gadgets[37],-1,Yo+st7+offo,0,0);
    MoveGadget(Gadgets[40],-1,Yo+st7+offu,0,0);
    MoveGadget(Gadgets[41],-1,Yo+st1+offu,0,0);
    MoveGadget(Gadgets[44],-1,Yo+st4+offu,0,0);
    MoveGadget(Gadgets[47],-1,Yo+st7+offu,0,0);
*)
    res:=AddGList(wptr,BG,-1,-1,NIL);
    (* byt over/under status *)
    BytStat := (StyO=0) & (StyU<>0) OR (StyO<>0) & (StyU=0);
    IF BytStat THEN
      res:=StyO; 
      StyO:=-StyU;
      StyU:=-res;
      SetToggl(Gadgets[30],wptr,StyO=0);
      SetToggl(Gadgets[40],wptr,StyU=0);
    END;
    (* sæt kun for refresh af de felter, der SKAL. *)
    ValgC:=0;
    FOR n:=11 TO 88 DO 
      IF (Stil[99-n]<>Stil[n]) OR (Sele[99-n]=' ') AND (Sele[n]<>' ') 
      OR (Domi[99-n]=' ') AND (Domi[n]<>' ') THEN
        StilC[n]:='.'; 
      ELSE
        DomiC[n]:='.';
        MundC[n]:='.';
        SeleC[n]:='.';
      END;   
    END;
  END;

  IF ~BytStat THEN
    FOR n:=30 TO 49 DO
      RefreshGadget(Gadgets[n],wptr);
    END;
(*
    VlmOC:=8;
    VlmUC:=8;
    VlpOC:=8;
    VlpUC:=8;
    ReDraw(Stil,Domi,Mund,Sele);
*)
  END;
  ReDrawAll(Stil,Domi,Mund,Sele);
END SetOpNed;

PROCEDURE Exit;
BEGIN
(*$ IF Test*)
  d(s("Exit"));
(*$ ENDIF *)
  IF wptr<>NIL THEN
    CloseWindow(wptr);
  END;
  IF sptr<>NIL THEN
    CloseScreen(sptr);
  END;
END Exit;

PROCEDURE colorData; (*$ EntryExitCode:=FALSE *)(*  ARRAY [0..7] OF RGB *)
BEGIN
  ASSEMBLE(DC.W $000C, $0DDD, $0000, $0F80, $0222, $0FFF, $0555, $0CCC END) (* WB 1.3 Colors bhso *)
  (* 0RGB        blå   hvid6   sort  orange  grå1   hvid7  grå2   grå6*)
END colorData;

PROCEDURE BPtoCNT(n:INTEGER):INTEGER;
VAR
  zn:INTEGER;
BEGIN
  CASE n OF
  | 1 : zn:=  2;
  | 2 : zn:=  4;
  | 3 : zn:=  8;
  | 4 : zn:= 16;
  | 5 : zn:= 32;
  | 6 : zn:= 64;
  | 7 : zn:=128;
  | 8 : zn:=256;
  ELSE zn:=4;
  END;
  RETURN(zn);
END BPtoCNT;

PROCEDURE InitGW(VAR winptr:WindowPtr);
TYPE
  CDAT=ARRAY[0..255] OF CARDINAL;
VAR
  WFS:WindowFlagSet;
  n,sc,ys,yw,zn:CARDINAL;
  ni:INTEGER;
  actual:LONGINT;
  id:ARRAY[0..255] OF CARDINAL;
  cf:File;
  cdatptr:POINTER TO CDAT;
  palname:ARRAY[0..16] OF CHAR;
BEGIN
(*$ IF Test*)
  d(s("InitGW"));
(*$ ENDIF *)
(*IF InitSprog(0) THEN END;*)
  FOR n:= 1 TO MaxGadget DO
    Gadgets[n]:=NIL;
  END;
  InitBoardGadgets(BG);
  BGE:=BG;                     (* Find sidste Gadget i Board hægtet liste *)
  WHILE BGE^.nextGadget<>NIL DO
    BGE:=BGE^.nextGadget;
  END;
  InitMainGadgets(MG);
  InitSetUpGadgets(SG);
  BGE^.nextGadget:=MG;         (* Sæt Board og Main gadget lister sammen *)
  WFS:=WindowFlagSet{windowDrag,windowDepth,windowClose};
  IF (AvailMem(MemReqSet{chip})<MinChip) OR (AvailMem(MemReqSet{public})<MinTotal) THEN (* Hurtig refresh hvis nok Chip RAM *)
    Simple:=TRUE;
  END;
  IF Simple THEN
(*$ IF Test*)
  d(s("Simple"));
(*$ ENDIF *)
    INCL(WFS,simpleRefresh);
  END;
  sc:=0;
(*$ IF Test*)
  d(s("ScrOn=")+b(ScrOn));
(*$ ENDIF *)
(*
  yw:=YOff+8*YSize+3; (* 260 *)
  IF yw<255 THEN yw:=255 END;
*)
  yw:=MaxWinY+3;
  IF ScrOn THEN
    ys:=yw+1+4;
    IF ys<273 THEN
      IF ys<256 THEN
        IF ys<200 THEN
          ys:=200;
        ELSE
          ys:=256;
        END;
      END;
      AddScreen(sptr,0,0, 640,ys, ZSize, 1,0,
                ViewModeSet{hires},ScreenFlagSet{},
                TextAttrPtr(LONGINT(1)),ADR(''),NIL,NIL);
    ELSE
      IF ys<400 THEN ys:=400 END;
      AddScreen(sptr,0,0, 640,ys, ZSize, 1,0,
                ViewModeSet{hires,lace},ScreenFlagSet{},
                TextAttrPtr(LONGINT(1)),ADR(''),NIL,NIL);
    END;
    IF sptr<>NIL THEN
(*$ IF Test*)
  d(s("ScrOn, 640, ys=")+l(ys)+s(" ZSize=")+l(ZSize)+s(", ReadPalette..."));
(*$ ENDIF *)
      zn:=BPtoCNT(ZSize);
      palname:='PIGpaletteBP?';
      palname[12]:=CHR(ZSize+48);
      Lookup(cf,palname,512,FALSE);
      IF cf.res=done THEN
        ni:=0;
        REPEAT
          ReadBytes(cf,ADR(id[ni]),2,actual);
          INC(ni);
        UNTIL (ni>255) OR (cf.eof);
        Close(cf);
      ELSE
        cdatptr:=ADR(colorData);
        FOR ni:=0 TO 7 DO
          id[ni]:=cdatptr^[ni];
        END;
        ni:=8;
      END;
      FOR ni:=ni TO 255 DO
        id[ni]:=ni*101;
      END;
      LoadRGB4(ADR(sptr^.viewPort), ADR(id), zn);
      
(*
      FOR ni:=0 TO sptr^.viewPort.colorMap^.count-1 DO
        id[ni]:=GetRGB4(sptr^.viewPort.colorMap,ni);
      END;
*)

      sc:=4;
    ELSE
      ScrOn:=FALSE;
    END;
  ELSE
    sptr:=NIL;
  END;
  (* Åbnes 1 punkt under toppen til Y=255, så screen kan 'trækkes' ned *)
(*$ IF Test*)
  d(s("AddWin, stx+146=")+l(stx+146)+s(" yw=")+l(yw)+s(" 1+sc=")+l(1+sc));
(*$ ENDIF *)
  AddWindow(wptr,Q[LAERSKAK], 0,1+sc, stx+146,yw, 0,1, 
            IDCMPFlagSet{activeWindow,inactiveWindow,closeWindow,gadgetDown,
            gadgetUp,refreshWindow,rawKey,mouseButtons},
            WFS,BG,sptr,NIL, 80,12, -1,-1);
  winptr:=wptr;
  IF wptr<>NIL THEN
    rp:=wptr^.rPort;
    ActivateWindow(wptr);
  END;
  SetUC:=1;
  SetUpMode:=0;
  OpAdC:=TRUE;
  OpAd :=TRUE;
  Valg :=0;
  ValgC:=0;
  VlmO:=8;
  VlmU:=8;
  VlpO:=8;
  VlpU:=8;
  VlmOC:=8;
  VlmUC:=8;
  VlpOC:=8;
  VlpUC:=8;
  SetDrMd(rp,DrawModeSet{dm0}); (*   ,dm0,complement *)
END InitGW;

PROCEDURE SavePalette;
VAR
  ni,cnt:INTEGER;
  actual:LONGINT;
  id:ARRAY[0..255] OF CARDINAL;
  cf:File;
  palname:ARRAY[0..16] OF CHAR;
BEGIN
  palname:='PIGpaletteBP?';
  palname[12]:=CHR(ZSize+48);
  Lookup(cf,palname,512,TRUE);
  IF cf.res=done THEN
(*$IF Test *)
  WRITELN(s('Palette: ZSize=')+l(ZSize));
(*$ENDIF *)
    FOR ni:=0 TO BPtoCNT(ZSize)-1 DO
(*$IF Test *)
  WRITELN(l(ni));
(*$ENDIF *)
      id[ni]:=GetRGB4(sptr^.viewPort.colorMap,ni);
      WriteBytes(cf, ADR(id[ni]),2,actual);
    END;
    Close(cf);
  END;
END SavePalette;

PROCEDURE ArgChk;
VAR
  stp  : POINTER TO ARRAY[0..128] OF CHAR;
  dobj : DiskObjectPtr;
  st   : ARRAY[0..128] OF CHAR;
  n,sz : INTEGER;
  stkSz: LONGINT;
BEGIN
  ScrOn         :=TRUE; (* !!!!!!!! TRUE !!!!!!!!!!!! *)
  ReqReq        :=FALSE;
  SpeakOff      :=FALSE;
  Simple        :=FALSE;
  InterOn       :=FALSE;
  NoLocale      :='LOCALE';
  MouthOff      :=FALSE;
  LotMemOn      :=FALSE;
  NoSpeakTask   :=FALSE;
  NoAutoPGN     :=FALSE;
  Quick         :=FALSE;
  NFP           :=FALSE;
  Lates3        :=0;
  LongFormOn    :='S'; (* Shortform write / Longform *)
  IF wbStarted THEN
(*$IF Test *)
  WRITELN(s('wbStarted'));
(*$ENDIF *)
    dobj:=GetDiskObject(programName);
    IF dobj<>NIL THEN

      stp:=FindToolType(dobj^.toolTypes,ADR(ttWORKBENCH));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          ScrOn:=FALSE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttREQFILEREQUESTER));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          ReqReq:=TRUE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttNOSPEAK));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          SpeakOff:=TRUE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttSIMPLEREFRESH));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          Simple:=TRUE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttINTERNATIONAL));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          InterOn:=TRUE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttLONGFORMWRITE));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          LongFormOn:='L';
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttNOLOCALE));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          NoLocale:='';
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttMOUTHOFF));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          MouthOff:=TRUE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttLOTMEMON));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          LotMemOn:=TRUE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttNOSPEAKTASK));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          NoSpeakTask:=TRUE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttNOAUTOPGN));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          NoAutoPGN:=TRUE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttQUICK));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          Quick:=TRUE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttNOFIELDPOWER));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          NFP:=TRUE;
        END;
      END;

      stp:=FindToolType(dobj^.toolTypes,ADR(ttPGN));
      IF stp<>NIL THEN
        IF MatchToolValue(stp,ADR('ON')) THEN
          Lates3:=1;
        END;
      END;
      stkSz:=dobj^.stackSize;
      FreeDiskObject(dobj);

(*$IF Test *)
  WRITELN(s('ReqReq=')+b(ReqReq));
(*$ENDIF *)
      (* warn if stack too small *)
      IF ReqReq & (stkSz<16384) OR ~ReqReq & (stkSz<34500) THEN
        Assert(FALSE,ADR('needs more stack'));
      END;
    END;
  END;  
  FOR n:=1 TO NumArgs() DO  (* check argumenter *)
    GetArg(n,st,sz);
    CapString(st);
    IF ~wbStarted THEN
      IF    (Compare(st,ttWORKBENCH)=0) THEN
        ScrOn:=FALSE;
(*$IF Test *)
  WRITELN(s('ScrOn'));
(*$ENDIF *)
      ELSIF (Compare(st,ttREQFILEREQUESTER)=0) THEN
        ReqReq:=TRUE;
(*$IF Test *)
  WRITELN(s('ReqReq'));
(*$ENDIF *)
      ELSIF (Compare(st,ttNOSPEAK)=0) THEN
(*$IF Test *)
  WRITELN(s('SpeakOff'));
(*$ENDIF *)
        SpeakOff:=TRUE;
      ELSIF (Compare(st,ttSIMPLEREFRESH)=0) THEN
(*$IF Test *)
  WRITELN(s('Simple'));
(*$ENDIF *)
        Simple:=TRUE;
      ELSIF (Compare(st,ttINTERNATIONAL)=0) THEN
        InterOn:=TRUE;
(*$IF Test *)
  WRITELN(s('InterOn'));
(*$ENDIF *)
      ELSIF (Compare(st,ttLONGFORMWRITE)=0) THEN
        LongFormOn:='L'; (* Longform write *)
(*$IF Test *)
  WRITELN(s('LongFormOn'));
(*$ENDIF *)
      ELSIF (Compare(st,ttNOLOCALE)=0) THEN
        NoLocale:='';
(*$IF Test *)
  WRITELN(s('NoLocale'));
(*$ENDIF *)
      ELSIF (Compare(st,ttMOUTHOFF)=0) THEN
        MouthOff:=TRUE;
(*$IF Test *)
  WRITELN(s('MouthOff'));
(*$ENDIF *)
      ELSIF (Compare(st,ttLOTMEMON)=0) THEN
        LotMemOn:=TRUE;
(*$IF Test *)
  WRITELN(s('LotMemOn'));
(*$ENDIF *)
      ELSIF (Compare(st,ttNOSPEAKTASK)=0) THEN
        NoSpeakTask:=TRUE;
(*$IF Test *)
  WRITELN(s('NoSpeakTask'));
(*$ENDIF *)
      ELSIF (Compare(st,ttNOAUTOPGN)=0) THEN
        NoAutoPGN:=TRUE;
(*$IF Test *)
  WRITELN(s('NoAutoPGN'));
(*$ENDIF *)
      ELSIF (Compare(st,ttQUICK)=0) THEN
(*$IF Test *)
  WRITELN(s('Quick'));
(*$ENDIF *)
        Quick:=TRUE;
      ELSIF (Compare(st,ttNOFIELDPOWER)=0) THEN
(*$IF Test *)
  WRITELN(s('NoFieldPower'));
(*$ENDIF *)
        NFP:=TRUE;
      ELSIF (Compare(st,ttPGN)=0) THEN
        Lates3:=1;
(*$IF Test *)
  WRITELN(s('Pgn'));
(*$ENDIF *)
      ELSE
        (* filnavn *)
      END;
    ELSE
      (* filnavn *)
    END;
  END;
END ArgChk;

(*
VAR
   mnuPtr: MenuPtr;

PROCEDURE AddMenu;
  nyPtr:MenuPtr;
BEGIN
  Allocate(nyPtr, SIZE(Menu)+1);
  nyPtr^.nextMenu       := mnuPtr;
  nyPtr^.leftEdge       := 10;
  nyPtr^.topEdge        :=  0;
  nyPtr^.width          := 80;
  nyPtr^.height         := 10;
  nyPtr^.flags          := BITSET{menuEnabled};
  nyPtr^.menuName       := ADR('wwwww');
  nyPtr^.firstItem      := NIL;
  nyPtr^.jazzX          := 0;
  nyPtr^.jazzY          := 0;
  nyPtr^.beatX          := 0;
  nyPtr^.beatY          := 0;


  mnuPtr:=nyPtr;

  nyPtr.type  := nmTitle;
  ny.label := ADR('TESTMENU');
  mnu.commKey :=ADR('F1')
  IF mnu.type=nmTitle THEN
    menuFlags:=BITSET{};
  ELSE
    mnu.itemFlags:=MenuItemFlagSet{};
  END;
  mutualExclude:=LONGSET{};
  userData:=NIL;

  mnuPtr:=ADR(mnu);

  CreateMenus(mnuPtr);
END InitMenu;
*)

BEGIN
(*$IF Test *)
  WRITELN(s('SkakScreen.1'));
(*$ENDIF *)
  LogVersion("SkakScreen.def",SkakScreenDefCompilation);
  LogVersion("SkakScreen.mod",SkakScreenModCompilation);

  wptrT:=NIL;
  TG   :=NIL;
  TGPGN:=NIL;
  TGFG :=NIL;
  sptr :=NIL;
  MaxWinY:=80;
  FirstEdit:=TRUE;
  EMPROC:=EM;
  SetTextAttr(
    ADR('topaz.font'),
    8,
    FontStyleSet{},
    FontFlagSet{romFont}
  );
  ArgChk;

  (* InitSprog is initiated from start of InitGW called from Skak?
     (because tooltypes binding) so don't use SkakSprog in inits in
      child modules to Skak?! 
  *)

  (* lave 2 tegn strenge af CHARs så de kan skrives på skærm: *)
  pd[0]:=TxD;pd[1]:=0C;
  pt[0]:=TxT;pt[1]:=0C;
  ps[0]:=TxS;ps[1]:=0C;
  pl[0]:=TxL;pl[1]:=0C;

  IF LotMemOn THEN
    MAXLLSIZE:=65536*16; (* max 32768 *)
  ELSE
    MAXLLSIZE:=16384;
  END;
  IF Simple THEN
    MAXLLSIZE:=1024;
  END;
  MOVEINFOSTRING[0]:=0C;
  WITH itx DO
    drawMode:=DrawModeSet{dm0};
    leftEdge:=0;
    topEdge:=0;
    iTextFont:=NIL;
    nextText:=NIL;
  END;
(*$IF Test *)
  WRITELN(s('SkakScreen.2'));
(*$ENDIF *)

CLOSE

(*$IF Test *)
  WRITELN(s('SkakScreen.3'));
(*$ENDIF *)
  ExitT;
  Exit;
(*$IF Test *)
  WRITELN(s('SkakScreen.4'));
(*$ENDIF *)
END SkakScreen.

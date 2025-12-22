IMPLEMENTATION MODULE RequestFile;    (* FileRequester v1.02  (c) EBM 14/11-90 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=TRUE StackParms:=TRUE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=FALSE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=TRUE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT
  ADDRESS, ADR, ASSEMBLE, CAST;
FROM Arts IMPORT
  Terminate, Assert, BreakPoint;
FROM Heap IMPORT
  Allocate, Deallocate, AllocMem;
FROM Conversions IMPORT
  ValToStr;
FROM String IMPORT
  Copy, LastPos, Length, Compare, Concat, ConcatChar, CapString, FirstPos;
FROM StrSupport IMPORT
  Valid, UpString;
FROM DosD IMPORT
  FileInfoBlockPtr, FileInfoBlock, FileLockPtr, accessRead, FileLock,
  DosLibraryPtr, DeviceListPtr, DeviceListType; 
IMPORT DosL; FROM DosL IMPORT
  Examine, ExNext, Lock, UnLock, Delay; 
FROM IntuitionD IMPORT
  boolGadget, stdScreenHeight, GadgetPtr, IDCMPFlagSet, IDCMPFlags, Image, ImagePtr,
  IntuiMessagePtr, WindowPtr, WindowFlags, WindowFlagSet, strGadget, ScreenPtr,
  propGadget, PropInfoPtr, StringInfoPtr, IntuiText, gadgHNone, IntuiTextPtr;
FROM IntuitionL IMPORT
  CloseWindow, RefreshGList, PrintIText, NewModifyProp, ActivateGadget,
  ActivateWindow, DoubleClick, CurrentTime;
FROM GraphicsD IMPORT
  RastPortPtr, DrawModeSet, DrawModes,
  TextAttrPtr, FontStyleSet, FontFlags, FontFlagSet;
FROM GraphicsL IMPORT
  SetDrMd, Move, Draw,
  RectFill,SetAPen;
FROM ExecL IMPORT
  ReplyMsg, WaitPort, GetMsg;
FROM QuickIntuition IMPORT
  AF, AFS, GF,GFS, PIF, PIFS,
  AddBorder,
  AddGadget,
  AddStringInfo, AddGadgetImage, ChipPicture, AddPropInfo,
  AddWindow, AddIntuiText, GetString, SetString, OutLine, SetTextAttr
  (* , WriteText *);

(*$IF Test *)
  FROM W IMPORT
    WRITELN,s,l;
(*$ENDIF *)

(* Lager-brug : 
   kode, intern            = ca 11Kb
   kode, m2-biblioteker    = ca 6kb, QuickIntuition ca 3Kb, andre ca 3Kb
   kode, runtime-bib.      = Åbner Dos,Graphics,Intuition,Exec
   Statiske variable       = ca 175 bytes, 
   Heap-Statisk            = ca 600 bytes til gadgets
   Heap-dynamisk           = ca 6500 bytes til dir
   Lokale variable (Stak)  = ca 800 + det som Libraryfunktionerne bruger
   INAKTIV                 = ca 12Kb + 6Kb (de 6 kan genbruges)
   AKTIV                   = ca 7Kb ekstra + et intuition-window
*) 
(* Begrænsninger :
   Max filer ad gangen     = 192, resten overses
   Max dirs                =  64, resten overses
   DevicelistRefresh       = Ved starten af hvert kald
*)
(* forslag til forbedringer : 
   Sortering, OK
   pattern, OK
   Størrelse OK, dato, tid, fileinfo
   Advanced toggle
   Slet ved påbegyndt dir, OK
   Altid topaz80 eller korrekt default
   aktive gadget scrolls, OK
   parallel read/display/eksekver, (OK)
   Udnytte aktuelle skærmhøjde (OK NTSC)
   Slet ulovligt path/fil, OK
   Inaktiver gadgets når ingen reaktion mulig
   indlæse logiske og fysiske devices, OK
   Load ved dobbelt-klik, OK
   1-95 ELSE for device CASE, (OK)
   3-95 Nu læses tekstfelter når OK gadget, OK
        FileSize vises nu i k, OK
        Return/Esc for OK/UPS, OK
   1-96 FileSize <10000 bytes, >=10000 k, OK
        PreCalc Filesize, OK
        Double-click file-select, OK
*)
(* Bugs :
  ld[] dynamisk (stack), Gadgets ptr's IKKE refreshed, ld nu statisk, OK
  Ingen fil+dir refresh fra start når ulovlig path, OK
  / Op/Ud? , nu parent hvis bare første tegn = '/', OK
  assign skrevet i filnavn flyttes nu til path, OK
*)
CONST
  MAXFILES=192;
  MAXDIRS = 64;
  DevStHi=4;
  ldY=3;
  TxY=9;
  DirY=26+TxY*ldY;
  kHome=3DH;  kEnd =1DH;  kPgUp=3FH;  kPgDn=1FH;  kHelp=5FH;  kUp  =4CH;
  kDn  =4DH;  kRt  =4EH;  kLt  =4FH;  kUpN =3EH;  kDnN =1EH;  kRtN =2FH;
  kLtN =2DH;  kF1  =50H;  kF2  =51H;  kF3  =52H;  kF4  =53H;  kF5  =54H;
  kF6  =55H;  kF7  =56H;  kF8  =57H;  kF9  =58H;  kF0  =59H;  kCr  =44H;
  kCrN =43H;  kNumL=5AH;  kScrL=5BH;  kSyRq=5CH;  kPrSc=5DH;  kEsc =45H;

TYPE
  LINE=ARRAY[0..25] OF CHAR;
  DEVST=ARRAY [0..DevStHi] OF CHAR;
  STSZ=ARRAY[0..6] OF CHAR;

VAR
  DirSort,FileSort:BOOLEAN; (* Her sættes sortering fra/TIL, dynamisk*)
  DirOn           :BOOLEAN; (* Fuld dir fra/TIL, FØR første kald *)
  dirs    : POINTER TO ARRAY[1..MAXDIRS] OF LINE;
  files   : POINTER TO ARRAY[1..MAXFILES] OF LINE;
  filest  : POINTER TO ARRAY[1..MAXFILES] OF STSZ;
  gptr    : GadgetPtr;
  Pot1p,Pot2p    : GadgetPtr;
  St1p,St2p,St3p : GadgetPtr;
  rqOKptr,rqAbortptr,rqPathptr,rqNameptr,rqPatternptr : IntuiTextPtr;
  wptr    : WindowPtr;
  Pgad    : GadgetPtr;
  Pclass  : IDCMPFlagSet;
  Pmcode  : CARDINAL;
  Push    : BOOLEAN;
  ld      : ARRAY[1..7],[1..ldY] OF DEVST;

PROCEDURE PilOp; (*$ EntryExitCode:=FALSE *)
BEGIN
  ASSEMBLE(DC.W $FFFF,
         $8181,
         $87E1,
         $9FF9,
         $FFFF,
         $83C1,
         $83C1,
         $FFFF
         END);
END PilOp;

PROCEDURE PilNed; (*$ EntryExitCode:=FALSE *)
BEGIN
  ASSEMBLE(DC.W $FFFF,
         $83C1,
         $83C1,
         $FFFF,
         $9FF9,
         $87E1,
         $8181,
         $FFFF
         END);
END PilNed;

PROCEDURE NoMem(p:ADDRESS);
BEGIN
  Assert(p<>NIL,ADR('Not enough memory'));
END NoMem;

PROCEDURE SetStr(gptr:GadgetPtr; st:ARRAY OF CHAR);
BEGIN  
  SetString(gptr,st);
  RefreshGList(gptr,wptr,NIL,1);
END SetStr;

(* Pattern med super wildcards, normalt * men kan være f.eks. ~*.(info,bak) *)
(* (alle, der IKKE (~) ender på .info eller .bak), se Diverse.Valid         *)

PROCEDURE FileRequest(VAR Path,FilNvn,Pattern:ARRAY OF CHAR; 
                      RqHead,RqOK,RqAbort:ARRAY OF CHAR;
                      RqPath,RqName,RqPattern:ARRAY OF CHAR;
                      ScrPtr:ScreenPtr) : BOOLEAN;
CONST
  lines=8;
TYPE
  BLINE=ARRAY [0..40] OF CHAR;
VAR
  s1,s2,s3: BLINE;
  rw,First: BOOLEAN;
  path    : BLINE;
  filnvn  : LINE;
  pattern : BLINE;
  OldPath : BLINE;
  rqOK,rqAbort,rqPattern,rqName,rqPath  : ARRAY[0..8] OF CHAR;
  Pot1,Pot2      : CARDINAL;
  Pot1s,Pot2s    : CARDINAL;
  rp      : RastPortPtr;
  dirn,filen,diro,fileo,dirg,fileg,mcode:CARDINAL;

PROCEDURE QSort(data:ADDRESS; datasz:ADDRESS; max:CARDINAL);
VAR
  dt :POINTER TO ARRAY[1..MAXFILES] OF LINE;
  ds :POINTER TO ARRAY[1..MAXFILES] OF STSZ;
PROCEDURE QS(fra,til:CARDINAL);
VAR
  i,j:CARDINAL;
  dh,dc :LINE;
PROCEDURE Byt(i,j:CARDINAL);
VAR
  hlp:LINE;
  hls:STSZ;
BEGIN
  hlp:=dt^[i];
  dt^[i]:=dt^[j];
  dt^[j]:=hlp;
  IF ds<>NIL THEN
    hls:=ds^[i];
    ds^[i]:=ds^[j];
    ds^[j]:=hls;
  END;
END Byt;
BEGIN (* QS *)
  i:=fra; j:=til;
  dh:=dt^[(fra+til) DIV 2];
  CapString(dh);
  REPEAT
    REPEAT
      dc:=dt^[i];
      CapString(dc);
      INC(i);
    UNTIL Compare(dh,dc) <= 0;
    DEC(i);
    REPEAT
      dc:=dt^[j];
      CapString(dc);
      DEC(j);
    UNTIL Compare(dh,dc) >= 0;
    INC(j);
    IF i<=j THEN
      IF i<j THEN Byt(i,j) END;
      INC(i);
      DEC(j);
    END;
  UNTIL i>j;
  IF fra<j THEN QS(fra,j) END;
  IF i<til THEN QS(i,til) END;
END QS;
BEGIN (* QSort *)
  dt:=data;
  ds:=datasz;
  IF max>1 THEN QS(1,max) END;
END QSort;


VAR
  itx : IntuiText;
PROCEDURE PrintI(tp:ADDRESS; leftoffset,topoffset:INTEGER);
BEGIN
  itx.iText := tp;
  PrintIText(rp,ADR(itx),leftoffset,topoffset);
END PrintI;

(*
PROCEDURE PrintI(tp:ADDRESS; leftoffset,topoffset:INTEGER);
BEGIN
  WriteText(rp,tp,leftoffset,topoffset);
END PrintI;
*)

CONST
  overlap=1;
  MaxPot=65535;

TYPE
  UpDateModes=(clr,txt);
  UDMS=SET OF UpDateModes;

PROCEDURE CLn(x,y:INTEGER);
BEGIN
  PrintI(ADR('                                 '),x,y);
END CLn;

PROCEDURE UpDateDirs(mode:UDMS; UpDatePot:BOOLEAN);
VAR
  n,hidden:CARDINAL;
BEGIN
  IF DirOn AND ((diro<>dirg) OR (mode=UDMS{clr})) THEN
    IF mode<>UDMS{clr} THEN dirg:=diro END;
    FOR n:=1 TO lines DO
      IF clr IN mode THEN 
        CLn(6,DirY+TxY*n);
      END;
      IF (txt IN mode) AND (n+diro <= dirn) THEN
        PrintI(ADR(dirs^[n+diro]),8,DirY+TxY*n);
      END;
    END;
    IF dirn<lines THEN hidden:=0 ELSE hidden:=dirn-lines END;
    IF diro>hidden THEN diro:=hidden END; 
    IF UpDatePot THEN
      IF hidden>0 THEN
        Pot1s:=LONGCARD(MaxPot)*(lines-overlap) DIV (dirn-overlap);
        Pot1:=LONGCARD(diro)*MaxPot DIV hidden;
      ELSE
        Pot1s:=MaxPot;
        Pot1:=0;
      END;
      NewModifyProp(Pot1p,wptr,NIL,PIFS{autoKnob,freeVert}, 0,Pot1, 0,Pot1s, 1);
    END;
  ELSE
    Delay(2); (* frigør CPU tid ved scrollgadgets busy-wait loop *)
  END;
END UpDateDirs;

PROCEDURE UpDateFiles(mode:UDMS; UpDatePot:BOOLEAN);
VAR
  n,hidden:CARDINAL;
BEGIN
  IF (files<>NIL) AND ((fileo<>fileg) OR (mode=UDMS{clr})) THEN
    IF mode<>UDMS{clr} THEN fileg:=fileo END;
    FOR n:=1 TO lines DO
      IF clr IN mode THEN
        CLn(6,80+TxY*lines+TxY*n);
      END; 
      IF (txt IN mode) AND (n+fileo <= filen) THEN
        PrintI(ADR(files^[n+fileo]),8,80+TxY*lines+TxY*n);
(*
        IF filesz<>NIL THEN
          IF filesz^[n+fileo]<0 THEN
            ValToStr(-filesz^[n+fileo],FALSE,sz,10,6,' ',err);
          ELSE
            ValToStr(filesz^[n+fileo],FALSE,sz,10,5,' ',err);
            ConcatChar(sz,'k');
          END;
          PrintI(ADR(sz),220,80+TxY*lines+TxY*n);
        END;
*)
        IF filest<>NIL THEN
          PrintI(ADR(filest^[n+fileo]),220,80+TxY*lines+TxY*n);
        END;
      END;
    END;
    IF filen<lines THEN hidden:=0 ELSE hidden:=filen-lines END;
    IF fileo>hidden THEN fileo:=hidden END;
    IF UpDatePot THEN
      IF hidden>0 THEN
        Pot2s:=LONGCARD(MaxPot)*(lines-overlap) DIV (filen-overlap);
        Pot2:=LONGCARD(fileo)*MaxPot DIV hidden;
      ELSE
        Pot2s:=MaxPot;
        Pot2:=0;
      END;
      NewModifyProp(Pot2p,wptr,NIL,PIFS{autoKnob,freeVert}, 0,Pot2, 0,Pot2s, 1);
    END;
  ELSE 
    Delay(2);
  END;
END UpDateFiles;

PROCEDURE ReDraw;
BEGIN  
  IF rw THEN
    rw:=FALSE;
  ELSE
    RefreshGList(gptr,wptr,NIL,9999);
  END;
  UpDateDirs(UDMS{clr,txt},FALSE);
  UpDateFiles(UDMS{clr,txt},FALSE);
END ReDraw;

PROCEDURE AEM; (* Active Event Monitor *)
VAR
  msg  :IntuiMessagePtr;
  gnr  :CARDINAL; 
BEGIN
  msg   :=GetMsg(wptr^.userPort);    (* overfør msg-class og evt. gadget ptr*)
  IF msg<>NIL THEN
    Pclass :=msg^.class; (*IDCMPFlags*) (* til egne variable class, gad*)
    Pgad   :=msg^.iAddress;
    Pmcode :=msg^.code;
    ReplyMsg(msg);                      (* returner/frigør message *)
    IF activeWindow IN Pclass THEN      (* eksekver den/de? modtagede messages *)
      IF ActivateGadget(St2p,wptr,NIL) THEN END;
    END;
    IF refreshWindow IN Pclass THEN     (* kun ved simplerefresh vindue *)
      rw:=TRUE;
      dirg:=65535;
      fileg:=dirg; 
      ReDraw;
    END;
    IF closeWindow IN Pclass THEN
      Push:=TRUE;
    END;
    IF rawKey IN Pclass THEN
      IF (Pmcode=kEsc) OR (Pmcode=kCr) OR (Pmcode=kCrN) THEN
        Push:=TRUE;
      END;
    END;
    IF gadgetUp IN Pclass THEN
      gnr:= Pgad^.gadgetID;
      CASE gnr OF
        |  1..3 : Push:=TRUE;
      ELSE END;
    END;
    IF gadgetDown IN Pclass THEN
      gnr:= Pgad^.gadgetID;
      CASE gnr OF
        | 20..51,58..59 : Push:=TRUE;
      ELSE END;
    END;
  END;
END AEM;
 
PROCEDURE GetDir;
VAR
  minlaas : FileLockPtr;
  fibp    : FileInfoBlockPtr;
  wild    : BOOLEAN;
  len     : INTEGER;
  nvn,Unvn: LINE;
  err     : BOOLEAN;
  sz      : STSZ;
BEGIN 
  IF DirOn AND (dirs=NIL) THEN Allocate(dirs,SIZE(dirs^)) END;
  IF files=NIL THEN Allocate(files,SIZE(files^)) END;
  IF filest=NIL THEN Allocate(filest,SIZE(filest^)) END;
  Allocate(fibp,SIZE(fibp^));
  IF (NOT DirOn OR (dirs<>NIL)) AND (files<>NIL) AND (fibp<>NIL) THEN
    minlaas:=Lock(ADR(path),accessRead);
    IF minlaas<>NIL THEN
      dirn :=0;
      diro :=0;
      filen:=0;
      fileo:=0;
      UpDateDirs(UDMS{clr},TRUE);
      UpDateFiles(UDMS{clr},TRUE);
    ELSE
      IF First THEN
        path:='';
        SetStr(St1p,path);
        minlaas:=Lock(ADR(path),accessRead);
        dirn :=0;
        diro :=0;
        filen:=0;
        fileo:=0;
        UpDateDirs(UDMS{clr},TRUE);
        UpDateFiles(UDMS{clr},TRUE);
      END;
    END;
    IF minlaas=NIL THEN
      path:=OldPath;
      SetStr(St1p,path);
    ELSE
      OldPath:=path;
      wild := Compare(pattern,"*")<>0;
      IF wild THEN UpString(pattern) END;
      IF Examine(minlaas,fibp) THEN 
        REPEAT   
          Copy(nvn,fibp^.fileName);
          IF fibp^.entryType=2 THEN
            IF DirOn THEN
              IF dirn>0 THEN 
                dirs^[dirn]:=nvn;
              END;
              dirn:=dirn+1;
            END; 
          ELSE
            IF wild THEN 
              Unvn:=nvn;
              UpString(Unvn); 
            END;
            IF NOT wild OR Valid(pattern,Unvn) THEN
              filen:=filen+1; 
              files^[filen]:=nvn;
              IF filest<>NIL THEN
                IF fibp^.size>=10000 THEN
                  ValToStr(fibp^.size DIV 1024,FALSE,sz,10,5,' ',err);
                  ConcatChar(sz,'k');
                ELSE
                  ValToStr(fibp^.size,FALSE,sz,10,6,' ',err);
                END;
                Copy(filest^[filen],sz);
              END;
            END;
          END;
          AEM;
        UNTIL (dirn>=MAXDIRS) OR (filen>=MAXFILES) OR Push OR NOT ExNext(minlaas,fibp);
        dirn:=dirn-1;
      END;
      UnLock(minlaas);
      IF NOT Push THEN
        dirg:=65535; (* så der opdateres *)
        fileg:=dirg;
        IF DirSort THEN QSort(dirs,NIL,dirn) END;
        IF FileSort THEN QSort(files,filest,filen) END;
        UpDateDirs(UDMS{txt},TRUE);
        UpDateFiles(UDMS{txt},TRUE);
      END;
    END;
  END;
  IF fibp<>NIL THEN Deallocate(fibp) END;
END GetDir;

PROCEDURE InitWindow1(VAR wptr:WindowPtr);
CONST 
  bredde=290;
  lh=12;
TYPE
  TTT=ARRAY[0..7] OF INTEGER;
VAR
  tttp,tttd:POINTER TO TTT;
  ttti:Image;
  y:INTEGER;
  nx,ny:INTEGER;
  dosLib:DosLibraryPtr;
  DevLstPtr:DeviceListPtr;
  sp:POINTER TO DEVST;
  st:DEVST;

PROCEDURE Liste(nvn:INTEGER);
BEGIN 
  FOR ny:=1 TO lines DO
    AddGadget(gptr,  6,y, bredde-24,TxY-1, GFS{}
    ,AFS{gadgImmediate},NIL,NIL,NIL,NIL,nvn+ny,NIL);
    y:=y+TxY;
  END;

  AddGadget(gptr, -19,y-18, 16,8, GFS{gRelRight}
  ,AFS{relVerify,gadgImmediate},NIL,NIL,NIL,NIL,nvn+13,NIL);
  AddGadgetImage(gptr,FALSE, 0,0, 16,8, 1, ChipPicture(ADR(PilOp),8), 1,0);

(*
AllocMem(tttp,8*2,TRUE);
tttd:=ADR(PilOp);
BreakPoint(ADR("gp3"));
tttp^:=tttd^;
WITH ttti DO
  width:=16;
  height:=8;
  depth:=1;
  imageData:=tttp;
  planePick:=1;
  nextImage:=NIL;
END;
gptr^.gadgetRender:=ADR(ttti);
BreakPoint(ADR("gp5"));
*)

  AddGadget(gptr, -19,y-9 , 16,8, GFS{gRelRight}
  ,AFS{relVerify,gadgImmediate},NIL,NIL,NIL,NIL,nvn+14,NIL);
  AddGadgetImage(gptr,FALSE, 0,0, 16,8, 1, ChipPicture(ADR(PilNed),8), 1,0);
 
  (* PROPORTIONAL, LODRET, PROPORTIONAL AUTOKNOB *)
  AddGadget(gptr, -19,y-lines*TxY, 16,(lines-2)*TxY-1, GFS{gRelRight}
  ,AFS{relVerify,gadgImmediate},NIL,NIL,NIL,NIL,nvn+15,NIL);
  AddPropInfo(gptr,PIFS{autoKnob,freeVert}, 0,32767, 0,65535);      (*autoKnob*)
  (* ingen billede ved autoknob, men kræver alligevel 'tom' *)
  AddGadgetImage(gptr,FALSE, 0,0, 0,0, 0,NIL, 0,0);

  y:=y+lh-TxY;
END Liste;

BEGIN (* initwindow1 *)
  dosLib := ADR(DosL);                       (* derfor IMPORT Dos *)
  DevLstPtr:=dosLib^.root^.info^.devInfo;
  FOR nx:=1 TO 6 DO 
    FOR ny:=1 TO ldY DO ld[nx,ny]:='' END;
  END; 
(*
  ld[1,1]:='DF0:';
  ld[1,2]:='DF1:';
  ld[1,3]:='DF2:';
  ld[2,1]:='DH0:';
  ld[2,2]:='DH1:';
  ld[2,3]:='RAM:';
*)
  nx:=1;
  ny:=1;
  WHILE (DevLstPtr<>NIL) AND (nx<7) DO
    sp:=ADDRESS(DevLstPtr^.name);
    (* increment af pointeren, er nødvendig men hvorfor ? (BCPL?) *)
    INC(sp);
    CASE DevLstPtr^.type OF
      | device,directory : 
        Copy(st,sp^);
        IF Length(st)<DevStHi THEN   (* så plads til : og 0C *)
          IF  (Compare(st,'AUX')<>0) AND (Compare(st,'PIP')<>0) 
          AND (Compare(st,'PRT')<>0) AND (Compare(st,'PAR')<>0) 
          AND (Compare(st,'SER')<>0) AND (Compare(st,'RAW')<>0) 
          AND (Compare(st,'CON')<>0) THEN
            Concat(st,":");
            WHILE Length(st)<DevStHi DO 
              Concat(st," ");
            END;
            Copy(ld[nx,ny],st);
            IF ny=ldY THEN 
              ny:=1;
              INC(nx); 
            ELSE 
              INC(ny);
            END;
          END;
        END;
      | volume    : ;
    ELSE
    END;
    DevLstPtr:=DevLstPtr^.next;
  END;

  ld[7,1]:='/ Op';
  ld[7,2]:=':   ';
  FOR y:=3 TO ldY DO
    ld[7,y]:='    ';
  END;
  IF gptr=NIL THEN
    y:=lh+2;
    
    AddGadget(gptr, 46,y, bredde-50,TxY, GFS{},AFS{relVerify}
    ,NIL,NIL,NIL,NIL,1,NIL);   
    St1p:=gptr; 
    AddBorder(gptr,FALSE,-2,-2,1,1,DrawModeSet{dm0},5,OutLine(gptr));
    AddStringInfo(gptr,SIZE(BLINE),"");
    AddIntuiText(gptr, 3,0, DrawModeSet{dm0}, -40,0, ADR(''));
    rqPathptr:=gptr^.gadgetText; 
    y:=y+lh;

    IF DirOn THEN
      FOR ny:=1 TO ldY DO  (* max=4 *)
        FOR nx:=1 TO 7 DO  (* max=8 *)                       (* navn=20-51*)
          AddGadget(gptr,  40*nx-36,y, 38,TxY+1, GFS{}, AFS{gadgImmediate}
          ,NIL,NIL,NIL,NIL,11+nx+8*ny,NIL);
          AddIntuiText(gptr, 2,3, DrawModeSet{dm0}, 3,1, ADR(ld[nx,ny]));
        END;
        y:=y+lh;
      END;
      Liste(60); (* navn= 60-79 *)
      Pot1p:=gptr;
    END;

    AddGadget(gptr, 70,y, bredde-74,TxY, GFS{},AFS{relVerify}
    ,NIL,NIL,NIL,NIL,2,NIL);   
    St2p:=gptr; 
    AddBorder(gptr,FALSE,-2,-2,1,1,DrawModeSet{dm0},5,OutLine(gptr));
    AddStringInfo(gptr,SIZE(LINE),"");
    AddIntuiText(gptr, 3,0, DrawModeSet{dm0}, -40,0, ADR(''));
    rqNameptr:=gptr^.gadgetText;
    y:=y+lh;

    AddGadget(gptr, 70,y, bredde-74,TxY, GFS{},AFS{relVerify}
    ,NIL,NIL,NIL,NIL,3,NIL);   
    St3p:=gptr; 
    AddBorder(gptr,FALSE,-2,-2,1,1,DrawModeSet{dm0},5,OutLine(gptr));
    AddStringInfo(gptr,SIZE(BLINE),"");
    AddIntuiText(gptr, 3,0, DrawModeSet{dm0}, -64,0, ADR(''));
    rqPatternptr:=gptr^.gadgetText;
    y:=y+lh;

    Liste(80); (* navn=80-99 *)
    Pot2p:=gptr; 

    AddGadget(gptr, 8,        y, 80,lh, GFS{}, AFS{gadgImmediate}
    ,NIL,NIL,NIL,NIL,58,NIL);
    AddBorder(gptr,FALSE,-2,-1,1,1,DrawModeSet{dm0},5,OutLine(gptr));
    AddIntuiText(gptr, 0,1, DrawModeSet{dm0}, 16,2, ADR(''));
    rqOKptr:=gptr^.gadgetText;

    AddGadget(gptr, bredde-88,y, 80,lh, GFS{}, AFS{gadgImmediate}
    ,NIL,NIL,NIL,NIL,59,NIL);
    AddBorder(gptr,FALSE,-2,-1,1,1,DrawModeSet{dm0},5,OutLine(gptr));
    AddIntuiText(gptr, 0,1, DrawModeSet{dm0}, 13,2, ADR(''));
    rqAbortptr:=gptr^.gadgetText;
  END;
  
  Copy(rqOK,RqOK);
  Copy(rqAbort,RqAbort);
  Copy(rqPath,RqPath);
  Copy(rqName,RqName);
  Copy(rqPattern,RqPattern);
  rqOKptr^.iText      := ADR(rqOK);
  rqAbortptr^.iText   := ADR(rqAbort);
  rqPathptr^.iText    := ADR(rqPath);
  rqNameptr^.iText    := ADR(rqName);
  rqPatternptr^.iText := ADR(rqPattern);
  SetString(St1p,path);
  SetString(St2p,filnvn);
  SetString(St3p,pattern);

(*
  SetTextAttr(
    ADR('topaz.font'),
    8,
    FontStyleSet{},
    FontFlagSet{romFont}
  );
*)

  (* WORKBENCH drag,depth,close VINDUE, MSG close,gadget *)
  (* IKKE gzz da det var for langsomt, så hellere passe på ikke at overtegne *)
  (* borders (borderleft,bordertop til width-borderright,height-borderbottom)*)
  (* detail,blockpen IKKE 1,2 for man kunne ikke se aktiv proportional-gadget*)
  AddWindow(wptr,ADR(RqHead), 20,1, 292,8*lh+2*TxY*lines+12+(ldY-3)*TxY,
            0,1, IDCMPFlagSet{activeWindow,closeWindow,gadgetDown,
            gadgetUp,refreshWindow,rawKey},
            WindowFlagSet{windowDrag,windowDepth,windowClose,sizeBRight,
            simpleRefresh},gptr,ScrPtr,NIL, 0,0, -1,-1);
END InitWindow1;

PROCEDURE Init;
BEGIN
  Copy(path,Path);
  OldPath:='';
  Copy(filnvn,FilNvn);
  Copy(pattern,Pattern);
  InitWindow1(wptr);
  ActivateWindow(wptr);
  rp   := wptr^.rPort;
  rw   := FALSE;

  WITH itx DO
    frontPen:=2;
    backPen:=1;
    drawMode:=DrawModeSet{dm0};
    leftEdge:=0;
    topEdge:=0;
    iTextFont:=NIL;
    iText:=NIL;
    nextText:=NIL;
  END;

  First:=TRUE;
  GetDir;
  First:=FALSE;
END Init;

VAR
  gad   :GadgetPtr;
  msg   :IntuiMessagePtr;
  class :IDCMPFlagSet;
  piptr :PropInfoPtr;
  gnr,nx,ny:CARDINAL;
  Stop  :BOOLEAN;
  Abort :BOOLEAN;
  lp    :LONGINT;
  hidden:CARDINAL;
  str   :ARRAY[0..40] OF CHAR;

PROCEDURE PopMsg():BOOLEAN;
BEGIN
  msg:=GetMsg(wptr^.userPort);
  IF msg=NIL THEN RETURN(FALSE) END; 
  Pclass:=msg^.class;
  Pgad  :=msg^.iAddress;
  Pmcode:=msg^.code;
  ReplyMsg(msg);
  Push:= NOT(gadgetUp IN Pclass);
  RETURN(TRUE);
END PopMsg;

PROCEDURE GetPath;
BEGIN
  GetString (St1p,path);
  IF (Length(path) > 0) AND (path[Length(path)-1] <> ':') 
    AND (path[Length(path)-1] <> '/') THEN
    Concat(path,'/');
    SetStr(St1p,path);
  END; 
END GetPath;

PROCEDURE GetFile;
VAR
  p,n:LONGINT;
BEGIN
  GetString(St2p,filnvn);
  p:=FirstPos(filnvn,0,':')+1;
  IF (p>0) & ((p<>4) OR (filnvn[0]<>'p') OR (filnvn[1]<>'r') OR (filnvn[2]<>'t')) THEN
    Copy(path,filnvn);
    path[p]:=0C;
    SetStr(St1p,path);
    n:=-1;
    REPEAT
      INC(n);
      filnvn[n]:=filnvn[p];
      INC(p);
    UNTIL filnvn[n]=0C;
    SetStr(St2p,filnvn);
    IF n=0 THEN
      Stop:=FALSE;
      GetDir;
    END;
  END;
END GetFile;

PROCEDURE GetPattern;
BEGIN
  GetString (St3p,pattern);
  IF Length(pattern)=0 THEN 
    pattern:="*";
    SetStr(St3p,pattern);
  END;
END GetPattern;

PROCEDURE Slut;
BEGIN
  GetPath;
  GetFile;
  GetPattern;
  Stop  := TRUE;
END Slut;

VAR
  seconds1,micros1,seconds2,micros2:LONGINT;
  ctNr:CARDINAL;

BEGIN (* FileRequest *)
  ctNr:=0;
  dirn:=0;
  filen:=0;
  Stop  := FALSE;
  Abort := FALSE;
  Push  := FALSE;
  Init;
  REPEAT                               (* EVENT-MONITOR *)
    IF Push THEN 
      class:=Pclass;
      gad  :=Pgad;
      mcode:=Pmcode;
      Push :=FALSE;
    ELSE
      WaitPort(wptr^.userPort);          (* vent på input (message) *)
      msg   :=GetMsg(wptr^.userPort);    (* overfør msg-class og evt. gadget ptr*)
      class :=msg^.class; (*IDCMPFlags*) (* til egne variable class, gad*)
      gad   :=msg^.iAddress;
      mcode :=msg^.code;
      ReplyMsg(msg);                     (* returner/frigør message *)
    END;
    IF activeWindow IN class THEN      (* eksekver den/de? modtagede messages *)
      IF ActivateGadget(St2p,wptr,NIL) THEN END;
    END;
    IF refreshWindow IN class THEN     (* kun ved simplerefresh vindue *)
      rw:=TRUE;
      dirg:=65535;
      fileg:=dirg; 
      ReDraw;
    END;
    IF closeWindow IN class THEN
      Abort:=TRUE;
      Stop:=TRUE;
    END;

    IF rawKey IN class THEN
      IF mcode=kEsc THEN
        Abort:=TRUE;
        Stop:=TRUE;
      ELSIF (mcode=kCr) OR (mcode=kCrN) THEN
        Slut;
      END;
    END;

    IF gadgetDown IN class THEN
      gnr:= gad^.gadgetID;
      CASE gnr OF
        | 20..51 : 
          ny:=(gnr-20) DIV 8 + 1;
          nx:=(gnr-20) MOD 8 + 1;
          IF ld[nx,ny,0]='/' THEN
            IF Length(path)>1 THEN
              lp:=LastPos(path,Length(path)-2,'/');
            ELSE
              lp:=0;
            END;
            IF lp>0 THEN
              path[lp+1]:=0C;
            ELSE
              lp:=LastPos(path,Length(path),':');
              IF (lp>=0) AND (lp<Length(path)) THEN
                path[lp+1]:=0C;
              END;
 	    END;
          ELSE
            Copy(path,ld[nx,ny]);
            WHILE (Length(path)>0) AND (path[Length(path)-1]=' ') DO
              path[Length(path)-1]:=0C;
            END;
          END; 
          SetStr(St1p,path);
          GetDir;
        | 58 : (* OK *)
          Slut;
        | 59 : (* UPS! *)
          Abort := TRUE;
          Stop  := TRUE;
        | 61..72 : (* dir *)
          IF gnr+diro-60<=dirn THEN
            Copy(str,dirs^[gnr+diro-60]);
            Concat(path,str);
            Concat(path,'/');
            SetStr(St1p,path);
            GetDir;
          END; 
        | 81..92 : (* fil *)
          seconds1:=seconds2;
          micros1:=micros2;
          CurrentTime(ADR(seconds2),ADR(micros2));
          IF (gnr=ctNr) & DoubleClick(seconds1,micros1,seconds2,micros2) THEN
            Slut;
          ELSE
            ctNr:=gnr;
            IF gnr+fileo-80<=filen THEN
              Copy(filnvn,files^[gnr+fileo-80]);
              SetStr(St2p,filnvn);
            END;
          END;
        | 73 : (* p1up *)
          IF diro>0 THEN
            REPEAT
              DEC(diro); INC(ny);
              UpDateDirs(UDMS{clr,txt},TRUE);
              IF ny=1 THEN Delay(25) ELSE Delay(5) END;
            UNTIL PopMsg() OR (diro=0);
          END;
        | 74 : (* p1dn *)
          IF diro+lines<dirn THEN
            REPEAT
              INC(diro); INC(ny);
              UpDateDirs(UDMS{clr,txt},TRUE);
              IF ny=1 THEN Delay(25) ELSE Delay(5) END;
            UNTIL PopMsg() OR (diro+lines>=dirn);
          END; 
        | 75 : (* p1 *)
          REPEAT
            piptr:=gad^.specialInfo;
            Pot1:=piptr^.vertPot;
            IF dirn>lines THEN hidden:=dirn-lines ELSE hidden:=0 END;
            diro:=(LONGCARD(hidden)*Pot1+MaxPot DIV 2) DIV MaxPot;
            UpDateDirs(UDMS{clr,txt},FALSE);
          UNTIL PopMsg();
        | 93 : (* p2up *)
          IF fileo>0 THEN 
            REPEAT
              DEC(fileo); INC(ny);
              UpDateFiles(UDMS{clr,txt},TRUE);
              IF ny=1 THEN Delay(25) ELSE Delay(5) END;
            UNTIL PopMsg() OR (fileo=0);
          END;
        | 94 : (* p2dn *)
          IF fileo+lines<filen THEN 
            REPEAT
              INC(fileo); INC(ny);
              UpDateFiles(UDMS{clr,txt},TRUE);
              IF ny=1 THEN Delay(25) ELSE Delay(5) END;
            UNTIL PopMsg() OR (fileo+lines>=filen);
          END;
        | 95 : (* p2 *)
          REPEAT
            piptr:=gad^.specialInfo;
            Pot2:=piptr^.vertPot;
            IF filen>lines THEN hidden:=filen-lines ELSE hidden:=0 END;
            fileo:=(LONGCARD(hidden)*Pot2+MaxPot DIV 2) DIV MaxPot;
            UpDateFiles(UDMS{clr,txt},FALSE);
          UNTIL PopMsg();
      ELSE END;
    END;
    IF gadgetUp IN class THEN
      gnr:= gad^.gadgetID;
      CASE gnr OF
        |  1 : (* path *)
          GetPath;
          GetDir;
        |  2 : (* file *)
          Stop:=TRUE;
          GetFile;
        |  3 : (* pattern *) 
          GetPattern;         
          GetDir;
      ELSE END;
    END;
  UNTIL Stop;
  IF wptr<>NIL THEN 
    CloseWindow(wptr);
    wptr:=NIL;
  END;
  IF dirs<>NIL THEN 
    Deallocate (dirs);
    dirs:=NIL;
  END;
  IF files<>NIL THEN
    Deallocate(files);
    files:=NIL;
  END;
  IF filest<>NIL THEN
    Deallocate(filest);
    filest:=NIL;
  END;
  IF NOT Abort THEN
    Copy(Path,path);
    Copy(FilNvn,filnvn);
    Copy(Pattern,pattern);
  END;
  RETURN(NOT Abort);
END FileRequest;

(*
VAR
  pth,fnv,ptt:ARRAY[0..40] OF CHAR;  
  OK:BOOLEAN;
*)
BEGIN
(*$IF Test *)
  WRITELN(s('RequestFile.1'));
(*$ENDIF *)
  DirSort:=TRUE;
  DirOn:=TRUE;      (* virker endnu ikke at sætte FALSE *)
  FileSort:=TRUE;
  dirs:=NIL;
  files:=NIL;
  filest:=NIL;
  gptr:=NIL;
(*$IF Test *)
  WRITELN(s('RequestFile.2'));
(*$ENDIF *)
END RequestFile.

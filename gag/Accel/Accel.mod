MODULE Accel;

(*
 *  Source generated with GadToolsBox V2.0
 *  which is (c) Copyright 1991-1993 Jaba Development
 *  Oberon-Sourcecode-Generator by Kai Bolay (AMOK)
 *
 *  GUI Designed by : HDS
 *)

IMPORT e:Exec,
       es:ExecSupport,
       cx:Commodities,
       io,
       y:SYSTEM,
       d:Dos,
       wb:Workbench,
       ol:OberonLib,
       conv:Conversions,
       I: Intuition,
       gt: GadTools,
       g: Graphics,
       u: Utility,
       rq: Requests,
       fr: FileReq,
       ic:Icon;


CONST
  GDMathAccel                       * = 0;
  GDGraphEmu                        * = 1;
  GDMathEn                          * = 2;
  GDGraphAccel                      * = 3;
  GDFPUType                         * = 4;
  GDGraphEn                         * = 5;
  GDSave                            * = 6;
  GDCancel                          * = 7;
  GDUse                             * = 8;

CONST
  WinCNT = 9;
  WinLeft = 16;
  WinTop = 31;
  WinWidth = 486;
  WinHeight = 127;
VAR
  Scr*: I.ScreenPtr;
  VisualInfo*: e.APTR;
  WinWnd*: I.WindowPtr;
  WinGList*: I.GadgetPtr;
  WinMenus*: I.MenuPtr;
  WinGadgets*: ARRAY WinCNT OF I.GadgetPtr;

TYPE
  GraphEmu0LArray = ARRAY     11 OF e.STRPTR;
CONST
  GraphEmu0Labels = GraphEmu0LArray (
    y.ADR ("Original (OCS)"),
    y.ADR ("Enhanced (ECS)"),
    y.ADR ("Advanced (AGA)"),
    y.ADR ("Retina Z2"),
    y.ADR ("Retina Z3"),
    y.ADR ("Picasso"),
    y.ADR ("Merlin"),
    y.ADR ("OpalVison"),
    y.ADR ("Video7 Mirage VL"),
    y.ADR ("EGS 24Bit"),
    NIL );

TYPE
  FPUType0LArray = ARRAY     6 OF e.STRPTR;
CONST
  FPUType0Labels = FPUType0LArray (
    y.ADR ("No FPU"),
    y.ADR ("68881 FPU"),
    y.ADR ("68882 FPU"),
    y.ADR ("68040 FPU"),
    y.ADR ("68060 FPU"),
    NIL );

VAR
CONST
  topaz8 = g.TextAttr (y.ADR ("topaz.font"), 8, y.VAL (SHORTSET, 000H), y.VAL (SHORTSET, 001H) );

VAR
  WinIText: ARRAY 1 OF I.IntuiText;
TYPE
  WinMArray = ARRAY    11 OF gt.NewMenu;
CONST
  WinNewMenu = WinMArray (
    gt.title, y.ADR ("Project"), NIL, {}, y.VAL (LONGSET, 0), NIL,
    gt.item, y.ADR ("Load Config..."), y.ADR ("L"), {}, y.VAL (LONGSET, 0), NIL,
    gt.item, y.ADR ("Save Config..."), y.ADR ("S"), {}, y.VAL (LONGSET, 0), NIL,
    gt.item, gt.barLabel, NIL, {}, LONGSET {}, NIL,
    gt.item, y.ADR ("About"), NIL, {}, y.VAL (LONGSET, 0), NIL,
    gt.item, gt.barLabel, NIL, {}, LONGSET {}, NIL,
    gt.item, y.ADR ("Hide"), y.ADR ("H"), {}, y.VAL (LONGSET, 0), NIL,
    gt.item, y.ADR ("Quit"), y.ADR ("Q"), {}, y.VAL (LONGSET, 0), NIL,
    gt.title, y.ADR ("Edit"), NIL, {}, y.VAL (LONGSET, 0), NIL,
    gt.item, y.ADR ("Reset To Defaults"), y.ADR ("D"), {}, y.VAL (LONGSET, 0), NIL,
    gt.end, NIL, NIL, {}, LONGSET {}, NIL);
TYPE
  WinGTypesArray = ARRAY WinCNT OF INTEGER;
CONST
  WinGTypes = WinGTypesArray (
    gt.sliderKind,
    gt.cycleKind,
    gt.checkBoxKind,
    gt.sliderKind,
    gt.cycleKind,
    gt.checkBoxKind,
    gt.buttonKind,
    gt.buttonKind,
    gt.buttonKind
  );

TYPE
  WinNGadArray = ARRAY WinCNT OF gt.NewGadget;
CONST
  WinNGad = WinNGadArray (
    22, 55, 161, 13, NIL, NIL, GDMathAccel, LONGSET {} ,NIL, NIL,
    256, 72, 161, 13, NIL, NIL, GDGraphEmu, LONGSET {} ,NIL, NIL,
    22, 40, 26, 11, y.ADR ("_Math Acceleration"), NIL, GDMathEn, LONGSET {gt.placeTextRight} ,NIL, NIL,
    256, 55, 161, 13, NIL, NIL, GDGraphAccel, LONGSET {} ,NIL, NIL,
    22, 72, 161, 13, NIL, NIL, GDFPUType, LONGSET {} ,NIL, NIL,
    256, 40, 26, 11, y.ADR ("_Graph Acceleration"), NIL, GDGraphEn, LONGSET {gt.placeTextRight} ,NIL, NIL,
    16, 103, 105, 16, y.ADR ("_Save"), NIL, GDSave, LONGSET {gt.placeTextIn} ,NIL, NIL,
    366, 103, 105, 16, y.ADR ("_Cancel"), NIL, GDCancel, LONGSET {gt.placeTextIn} ,NIL, NIL,
    189, 103, 105, 16, y.ADR ("_Use"), NIL, GDUse, LONGSET {gt.placeTextIn} ,NIL, NIL
  );

TYPE
  WinGTagsArray = ARRAY    51 OF u.Tag;
CONST
  WinGTags = WinGTagsArray (
    gt.slMax, 800, gt.slMaxLevelLen, 5, gt.slLevelFormat, y.ADR ("%ld%%"), gt.slLevelPlace, LONGSET {gt.placeTextRight}, I.pgaFreedom, I.lorientHoriz, I.gaRelVerify, I.LTRUE, u.done,
    gt.cyLabels, y.ADR (GraphEmu0Labels[0]), u.done,
    gt.cbChecked, I.LTRUE, gt.underscore, ORD ('_'), u.done,
    gt.slMax, 500, gt.slMaxLevelLen, 5, gt.slLevelFormat, y.ADR ("%ld%%"), gt.slLevelPlace, LONGSET {gt.placeTextRight}, I.pgaFreedom, I.lorientHoriz, I.gaRelVerify, I.LTRUE, u.done,
    gt.cyLabels, y.ADR (FPUType0Labels[0]), u.done,
    gt.cbChecked, I.LTRUE, gt.underscore, ORD ('_'), u.done,
    gt.underscore, ORD ('_'), u.done,
    gt.underscore, ORD ('_'), u.done,
    gt.underscore, ORD ('_'), u.done
  );

PROCEDURE SetupScreen* (): INTEGER;
BEGIN
  Scr := I.LockPubScreen (NIL);  IF Scr = NIL THEN RETURN 1 END;

  VisualInfo := gt.GetVisualInfo (Scr, u.done);
  IF VisualInfo = NIL THEN RETURN 2 END;

  RETURN 0;
END SetupScreen;

PROCEDURE CloseDownScreen*;
BEGIN
  IF VisualInfo # NIL THEN
    gt.FreeVisualInfo (VisualInfo);
    VisualInfo := NIL;
  END;
  IF Scr # NIL THEN
    I.UnlockPubScreen (NIL, Scr);
    Scr := NIL;
  END;
END CloseDownScreen;

PROCEDURE WinRender*;
VAR
  offx, offy: INTEGER;
BEGIN
  offx := WinWnd^.borderLeft;
  offy := WinWnd^.borderTop;

  WinIText[0] := I.IntuiText (1, 0, g.jam1+SHORTSET {}, 143, 13, y.ADR (topaz8), y.ADR ("Amiga Software Accelerator"), NIL);
  WinIText[0].nextText := NIL;

  I.PrintIText (WinWnd^.rPort, WinIText[0], offx, offy);

  gt.DrawBevelBox (WinWnd^.rPort, offx + 16, offy + 8, 454, 17, gt.visualInfo, VisualInfo, u.done);
  gt.DrawBevelBox (WinWnd^.rPort, offx + 249, offy + 32, 222, 62, gt.visualInfo, VisualInfo, gt.bbRecessed, I.LTRUE, u.done);
  gt.DrawBevelBox (WinWnd^.rPort, offx + 15, offy + 32, 222, 62, gt.visualInfo, VisualInfo, gt.bbRecessed, I.LTRUE, u.done);
END WinRender;

PROCEDURE OpenWinWindow* (): INTEGER;
TYPE
  TagArrayPtr = UNTRACED POINTER TO ARRAY MAX (INTEGER) OF u.TagItem;
VAR
  ng: gt.NewGadget;
  gad: I.GadgetPtr;
  help: TagArrayPtr;
  lc, tc, lvc, offx, offy: INTEGER;
BEGIN
  offx := Scr^.wBorLeft; offy := Scr^.wBorTop + Scr^.rastPort.txHeight + 1;

  gad := gt.CreateContext (WinGList);
  IF gad = NIL THEN RETURN 1 END;

  lc := 0; tc := 0; lvc := 0;
  WHILE lc < WinCNT DO
    ng := WinNGad[lc];
    ng.visualInfo := VisualInfo;
    ng.textAttr   := y.ADR (topaz8);
    INC (ng.leftEdge, offx);
    INC (ng.topEdge, offy);
    help := u.CloneTagItems (y.VAL (TagArrayPtr, y.ADR (WinGTags[tc]))^);
    IF help = NIL THEN RETURN 8 END;
    gad := gt.CreateGadgetA (WinGTypes[lc], gad, ng, help^ );
    u.FreeTagItems (help^);
    IF gad = NIL THEN RETURN 2 END;
    WinGadgets[lc] := gad;

    WHILE WinGTags[tc] # u.done DO INC (tc, 2) END;
    INC (tc);

    INC (lc);
  END; (* WHILE *)
  WinMenus := gt.CreateMenus (WinNewMenu, gt.mnFrontPen, 0, u.done);
  IF WinMenus = NIL THEN RETURN 3 END;

  IF NOT gt.LayoutMenus (WinMenus, VisualInfo, gt.mnTextAttr, y.ADR (topaz8), u.done) THEN RETURN 4 END;

  WinWnd := I.OpenWindowTagsA ( NIL,
                    I.waLeft,          WinLeft,
                    I.waTop,           WinTop,
                    I.waInnerWidth,    WinWidth,
                    I.waInnerHeight,   WinHeight,
                    I.waIDCMP,         gt.sliderIDCMP+gt.cycleIDCMP+gt.checkBoxIDCMP+gt.buttonIDCMP+LONGSET {I.menuPick,I.closeWindow,I.refreshWindow},
                    I.waFlags,         LONGSET {I.activate,I.windowDrag,I.windowDepth,I.windowClose},
                    I.waGadgets,       WinGList,
                    I.waTitle,         y.ADR ("Accelerator 1.27"),
                    I.waScreenTitle,   y.ADR ("Workbench Screen"),
                    I.waPubScreen,     Scr,
                    u.done);
  IF WinWnd = NIL THEN RETURN 20 END;

  IF NOT I.SetMenuStrip (WinWnd, WinMenus^) THEN RETURN 5 END;
  gt.RefreshWindow (WinWnd, NIL);

  WinRender;

  RETURN 0;
END OpenWinWindow;

PROCEDURE CloseWinWindow*;
BEGIN
  IF WinMenus # NIL THEN
    IF WinWnd # NIL THEN
      I.ClearMenuStrip (WinWnd);
    END;
    gt.FreeMenus (WinMenus);
    WinMenus := NIL;
  END;
  IF WinWnd # NIL THEN
    I.CloseWindow (WinWnd);
    WinWnd := NIL;
  END;
  IF WinGList # NIL THEN
    gt.FreeGadgets (WinGList);
    WinGList := NIL;
  END;
END CloseWinWindow;

VAR n:INTEGER;
    ms:I.IntuiMessagePtr;
    Quit,bol,WinOp:BOOLEAN;
    Math,Graph:BOOLEAN;
    MFac,GFac:LONGINT;
    MEmu,GEmu:LONGINT;
    oMath,oGraph:BOOLEAN;
    oMFac,oGFac:LONGINT;
    oMEmu,oGEmu:LONGINT;
    FilNam:ARRAY 120 OF CHAR;
    Gadg:I.GadgetPtr;
    PrSp:I.PropInfoPtr;

VAR
     PopKey:ARRAY 100 OF CHAR;
     MyBrk :cx.CxObjPtr;
     MyFil :cx.CxObjPtr;
     MySnd :cx.CxObjPtr;
     MyTrs :cx.CxObjPtr;
     NwBrk :cx.NewBroker;
     MsPrt :e.MsgPortPtr;
     Err   :LONGINT;
     eMsg  :e.APTR;
     Msg   :cx.CxMsgPtr;
     MsTp  :LONGSET;
     MsId  :LONGINT;
     CxPri :LONGINT;
     CxKey :ARRAY 100 OF CHAR;
     CxPop :BOOLEAN;
     Signal:LONGSET;

PROCEDURE GetToolTypes;
VAR This:d.ProcessPtr;
    wbm:wb.WBStartupPtr;
    sptr:e.STRPTR;
    MyIcon:wb.DiskObjectPtr;
    OCurrentDir:d.FileLockPtr;
BEGIN;
This:=y.VAL(d.ProcessPtr,ol.Me);
CxPri:=0;CxKey:="alt control a";
CxPop:=TRUE;
IF ol.wbStarted THEN
 wbm:=ol.wbenchMsg;
 OCurrentDir:=This.currentDir;
 y.SETREG(0,d.CurrentDir(wbm.argList[0].lock));
 MyIcon := ic.GetDiskObject(wbm.argList[0].name^);
 y.SETREG(0,d.CurrentDir(OCurrentDir));
 IF MyIcon#NIL THEN
  sptr := ic.FindToolType(MyIcon.toolTypes,"CX_PRIORITY");
  IF sptr#NIL THEN IF conv.StringToInt(sptr^,CxPri) THEN END;END;
  sptr := ic.FindToolType(MyIcon.toolTypes,"CX_POPKEY");
  IF sptr#NIL THEN COPY(sptr^,CxKey);END;
  sptr := ic.FindToolType(MyIcon.toolTypes,"CX_POPUP");
  IF sptr#NIL THEN
   IF (sptr^="NO")OR(sptr^="no")OR(sptr^="No")OR(sptr^="nO")
   THEN CxPop:=FALSE;END;END;
  ic.FreeDiskObject(MyIcon);
 END;
END;
END GetToolTypes;

PROCEDURE Refresh(cyc:BOOLEAN);
BEGIN;
IF WinOp THEN
  gt.SetGadgetAttrs(WinGadgets[GDMathEn]^,WinWnd,NIL,gt.cbChecked,I.LTRUE);
 IF Math THEN
  gt.SetGadgetAttrs(WinGadgets[GDMathEn]^,WinWnd,NIL,gt.cbChecked,I.LTRUE);
  gt.SetGadgetAttrs(WinGadgets[GDMathAccel]^,WinWnd,NIL,I.gaDisabled,I.LFALSE);
  gt.SetGadgetAttrs(WinGadgets[GDFPUType]^,WinWnd,NIL,I.gaDisabled,I.LFALSE);
 ELSE
  gt.SetGadgetAttrs(WinGadgets[GDMathEn]^,WinWnd,NIL,gt.cbChecked,I.LFALSE);
  gt.SetGadgetAttrs(WinGadgets[GDMathAccel]^,WinWnd,NIL,I.gaDisabled,I.LTRUE);
  gt.SetGadgetAttrs(WinGadgets[GDFPUType]^,WinWnd,NIL,I.gaDisabled,I.LTRUE);
 END;
 IF Graph THEN
  gt.SetGadgetAttrs(WinGadgets[GDGraphEn]^,WinWnd,NIL,gt.cbChecked,I.LTRUE);
  gt.SetGadgetAttrs(WinGadgets[GDGraphAccel]^,WinWnd,NIL,I.gaDisabled,I.LFALSE);
  gt.SetGadgetAttrs(WinGadgets[GDGraphEmu]^,WinWnd,NIL,I.gaDisabled,I.LFALSE);
 ELSE
  gt.SetGadgetAttrs(WinGadgets[GDGraphEn]^,WinWnd,NIL,gt.cbChecked,I.LFALSE);
  gt.SetGadgetAttrs(WinGadgets[GDGraphAccel]^,WinWnd,NIL,I.gaDisabled,I.LTRUE);
  gt.SetGadgetAttrs(WinGadgets[GDGraphEmu]^,WinWnd,NIL,I.gaDisabled,I.LTRUE);
 END;
 gt.SetGadgetAttrs(WinGadgets[GDGraphAccel]^,WinWnd,NIL,gt.slLevel,GFac);
 gt.SetGadgetAttrs(WinGadgets[GDMathAccel]^,WinWnd,NIL,gt.slLevel,MFac);
 IF cyc THEN
  gt.SetGadgetAttrs(WinGadgets[GDFPUType]^,WinWnd,NIL,gt.cyActive,MEmu);
  gt.SetGadgetAttrs(WinGadgets[GDGraphEmu]^,WinWnd,NIL,gt.cyActive,GEmu);
 END;
 gt.RefreshWindow (WinWnd, NIL);
END;
END Refresh;

PROCEDURE Show;
BEGIN;
IF ~WinOp THEN
oMath:=Math;oGraph:=Graph;
oMFac:=MFac;oGFac:=GFac;
oMEmu:=MEmu;oGEmu:=GEmu;
n:=SetupScreen();
n:=OpenWinWindow();
Quit:=FALSE;WinOp:=TRUE;
Refresh(TRUE);
END;
END Show;

PROCEDURE ReadInt(VAR n:LONGINT);
VAR st:ARRAY 100 OF CHAR;
BEGIN;
io.ReadString(st);
IF conv.StringToInt(st,n) THEN END;
END ReadInt;

PROCEDURE LoadCon;
VAR cf,oli,olo:d.FileHandlePtr;
    n:LONGINT;
BEGIN;
Math:=TRUE;Graph:=TRUE;
MEmu:=0;GEmu:=0;
MFac:=100;GFac:=100;
cf:=d.Open(FilNam,d.oldFile);
IF cf#NIL THEN
 oli:=io.in;
 olo:=io.out;
 io.in:=cf;
 io.out:=cf;
 ReadInt(n);IF n=0 THEN Math:=FALSE;ELSE Math:=TRUE;END;
 ReadInt(MEmu);
 ReadInt(MFac);
 ReadInt(n);IF n=0 THEN Graph:=FALSE;ELSE Graph:=TRUE;END;
 ReadInt(GEmu);
 ReadInt(GFac);
 io.in:=oli;
 io.out:=olo;
 IF d.Close(cf) THEN END;
END;
Refresh(TRUE);
END LoadCon;

PROCEDURE SaveCon;
VAR cf,oli,olo:d.FileHandlePtr;
BEGIN;
cf:=d.Open(FilNam,d.newFile);
IF cf#NIL THEN
 oli:=io.in;
 olo:=io.out;
 io.in:=cf;
 io.out:=cf;
 io.in:=cf;
 io.out:=cf;
 IF Math THEN io.WriteInt(1,4);ELSE io.WriteInt(0,10);END;
 io.WriteLn;
 io.WriteInt(MEmu,4);
 io.WriteLn;
 io.WriteInt(MFac,4);
 io.WriteLn;
 IF Graph THEN io.WriteInt(1,4);ELSE io.WriteInt(0,10);END;
 io.WriteLn;
 io.WriteInt(GEmu,4);
 io.WriteLn;
 io.WriteInt(GFac,4);
 io.WriteLn;
 io.WriteString("Ok. It´s only a joke...\n");
 io.in:=oli;
 io.out:=olo;
 IF d.Close(cf) THEN END;
END;
END SaveCon;

PROCEDURE LoadConR;
BEGIN;
IF fr.FileReq("Select Filename:",FilNam) THEN LoadCon;END;
END LoadConR;

PROCEDURE SaveConR;
BEGIN;
IF fr.FileReqSave("Select Filename:",FilNam) THEN SaveCon;END;
END SaveConR;

PROCEDURE Hide;
BEGIN;
IF WinOp THEN
WinOp:=FALSE;
CloseWinWindow;
CloseDownScreen;END;
END Hide;

PROCEDURE About;
BEGIN;
bol:=rq.RequestWin("Amiga Accelerator V1.27",
      "1994 ADI Inc.\n\n"
      "This is SUCKSware. See the\ndocs for further information.",
      "","Ok",WinWnd);
END About;

PROCEDURE Disable;
BEGIN;
IF cx.ActivateCxObj(MyBrk,0)#0 THEN END;
END Disable;

PROCEDURE Enable;
BEGIN;
IF cx.ActivateCxObj(MyBrk,1)#0 THEN END;
END Enable;

PROCEDURE Reset;
BEGIN;
Math:=TRUE;Graph:=TRUE;
MEmu:=0;GEmu:=0;
MFac:=100;GFac:=100;
Refresh(TRUE);
END Reset;

PROCEDURE Init():BOOLEAN;
VAR ret:BOOLEAN;
BEGIN;
IF e.OpenLibrary("bullet.library",0)#NIL THEN END;
IF e.OpenLibrary("locale.library",0)#NIL THEN END;
IF e.OpenLibrary("powerpacker.library",0)#NIL THEN END;
IF e.OpenLibrary("lowlevel.library",0)#NIL THEN END;
IF e.OpenLibrary("arp.library",0)#NIL THEN END;
IF e.OpenLibrary("mathtrans.library",0)#NIL THEN END;
IF e.OpenLibrary("rexxarplib.library",0)#NIL THEN END;
IF e.OpenLibrary("gadtools.library",0)#NIL THEN END;
IF e.OpenLibrary("rexxapp.library",0)#NIL THEN END;
IF e.OpenLibrary("gadtools13.library",0)#NIL THEN END;
IF e.OpenLibrary("rexxsupport.library",0)#NIL THEN END;
IF e.OpenLibrary("asl.library",0)#NIL THEN END;
IF e.OpenLibrary("reqchange.library",0)#NIL THEN END;
IF e.OpenLibrary("iffparse.library",0)#NIL THEN END;
IF e.OpenLibrary("conhandler.library",0)#NIL THEN END;
IF e.OpenLibrary("iff.library",0)#NIL THEN END;
IF e.OpenLibrary("rct.library",0)#NIL THEN END;
IF e.OpenLibrary("oberonsupport.librarynw",0)#NIL THEN END;
IF e.OpenLibrary("nonvolatile.library",0)#NIL THEN END;
IF e.OpenLibrary("amigaguide.library",0)#NIL THEN END;
IF e.OpenLibrary("voice.library",0)#NIL THEN END;
IF e.OpenLibrary("decrunch.library",0)#NIL THEN END;
IF e.OpenLibrary("reqtools.library",0)#NIL THEN END;
IF e.OpenLibrary("parm.library",0)#NIL THEN END;
IF e.OpenLibrary("muimaster.library",0)#NIL THEN END;
IF e.OpenLibrary("diskfont.library36.x",0)#NIL THEN END;
IF e.OpenLibrary("ixemul.library",0)#NIL THEN END;
IF e.OpenLibrary("rexxmathlib.library",0)#NIL THEN END;
IF e.OpenLibrary("translator.library",0)#NIL THEN END;
IF e.OpenLibrary("rexxreqtools.library",0)#NIL THEN END;
IF e.OpenLibrary("requester.library",0)#NIL THEN END;
IF e.OpenLibrary("rexxhost.library",0)#NIL THEN END;
IF e.OpenLibrary("rexxsyslib.library",0)#NIL THEN END;
IF e.OpenLibrary("asl13.library",0)#NIL THEN END;
IF e.OpenLibrary("mathieeedoubbas.library",0)#NIL THEN END;
IF e.OpenLibrary("gadget.library",0)#NIL THEN END;
IF e.OpenLibrary("explode.library",0)#NIL THEN END;
IF e.OpenLibrary("version.library",0)#NIL THEN END;
IF e.OpenLibrary("virusz.library",0)#NIL THEN END;
IF e.OpenLibrary("downloader.library",0)#NIL THEN END;
IF e.OpenLibrary("intuisup.library",0)#NIL THEN END;
IF e.OpenLibrary("req.library",0)#NIL THEN END;
IF e.OpenLibrary("datatypes.library",0)#NIL THEN END;
IF e.OpenLibrary("multiuser.library.",0)#NIL THEN END;
IF e.OpenLibrary("matrix.library",0)#NIL THEN END;
ret:=TRUE;
IF ret THEN
FilNam:="ENVARC:Accel.prefs";
MsPrt:=e.CreateMsgPort();
IF MsPrt=NIL THEN ret:=FALSE;END;
IF ret THEN
NwBrk.version:=cx.nbVersion;
NwBrk.name:=y.ADR("Accelerator");
NwBrk.title:=y.ADR("The Amiga Accelerator V1.27 © ADI Inc ");
NwBrk.descr:=y.ADR("The strongest software speedup ever.");
NwBrk.unique:=SET{0,1};
NwBrk.flags:=SET{cx.showHide};
NwBrk.pri:=0;
NwBrk.port:=MsPrt;
NwBrk.reservedChannel:=0;
MyBrk:=cx.CxBroker(NwBrk,Err);
IF Err#0 THEN ret:=FALSE;END;
IF ret THEN
MyFil:=cx.CxFilter(y.ADR(CxKey));
MySnd:=cx.CxSender(MsPrt,cx.cxmIEvent);
MyTrs:=cx.CxTranslate(NIL);
cx.AttachCxObj(MyBrk,MyFil);
cx.AttachCxObj(MyFil,MySnd);
cx.AttachCxObj(MyFil,MyTrs);
IF cx.ActivateCxObj(MyBrk,1)#0 THEN ret:=FALSE;END;
IF MyFil=NIL THEN ret:=FALSE;END;
IF MySnd=NIL THEN ret:=FALSE;END;
IF MyTrs=NIL THEN ret:=FALSE;END;
IF cx.CxObjError(MyBrk)#LONGSET{} THEN ret:=FALSE;END;
END;END;END;
WinOp:=FALSE;
IF ~ret THEN I.DisplayBeep(NIL);END;
RETURN (ret);
END Init;

PROCEDURE ShutDown;
BEGIN;
IF MyBrk#NIL THEN cx.DeleteCxObjAll(MyBrk);
REPEAT;UNTIL e.GetMsg(MsPrt)=NIL;END;
IF MsPrt#NIL THEN
e.DeleteMsgPort(MsPrt);END;
Hide;
END ShutDown;

PROCEDURE CheckCx;
BEGIN;
IF MsPrt#NIL THEN
REPEAT;
eMsg:=e.GetMsg(MsPrt);
IF eMsg#NIL THEN
Msg:=y.VAL(cx.CxMsgPtr,eMsg);
MsTp:=cx.CxMsgType(Msg);
MsId:=cx.CxMsgID(Msg);
e.ReplyMsg(eMsg);
 IF MsTp=LONGSET{cx.cxmIEvent} THEN Show;END;
 IF MsTp=LONGSET{cx.cxmCommand} THEN
  IF MsId=cx.cmdDisable THEN Disable;END;
  IF MsId=cx.cmdEnable THEN Enable;END;
  IF MsId=cx.cmdAppear THEN Show;END;
  IF MsId=cx.cmdDisappear THEN Hide;END;
  IF MsId=cx.cmdKill THEN Quit:=TRUE;END;
  IF MsId=cx.cmdUnique THEN Show;END;
 END;
END;
UNTIL eMsg=NIL;
END;
END CheckCx;

VAR iAddress:e.APTR;
    code:LONGINT;
    class:LONGSET;
    cyc:BOOLEAN;

BEGIN;
IF Init() THEN
GetToolTypes;
LoadCon;
IF CxPop THEN Show;END;
REPEAT;
 Signal:=LONGSET{MsPrt.sigBit};
IF WinOp THEN
 Signal:=LONGSET{MsPrt.sigBit,WinWnd.userPort.sigBit};END;
IF e.Wait(Signal)#LONGSET{} THEN END;
CheckCx;
REPEAT;
IF WinOp THEN
ms:=gt.GetIMsg(WinWnd.userPort);
IF ms#NIL THEN
 cyc:=FALSE;
 iAddress:=ms.iAddress;
 code:=ms.code;
 class:=ms.class;
 IF I.closeWindow IN class THEN Hide;END;
 IF (gt.checkBoxIDCMP = class)AND WinOp THEN
  IF iAddress=WinGadgets[GDMathEn] THEN Math:=~Math;END;
  IF iAddress=WinGadgets[GDGraphEn] THEN Graph:=~Graph;END;
 END;
 IF (I.menuPick IN class)AND WinOp THEN
  IF code=-1856 THEN Quit:=TRUE;END;
  IF code=-2048 THEN LoadConR;END;
  IF code=-2016 THEN SaveConR;END;
  IF code=-1952 THEN About;END;
  IF code=-1888 THEN Hide;END;
  IF code=-2047 THEN Reset;END;
 END;
 IF (gt.buttonIDCMP = class)AND WinOp THEN
  IF iAddress=WinGadgets[GDSave] THEN SaveCon;END;
  IF iAddress=WinGadgets[GDUse] THEN Hide;END;
  IF iAddress=WinGadgets[GDCancel] THEN
     Math:=oMath;Graph:=oGraph;
     MFac:=oMFac;GFac:=oGFac;
     MEmu:=oMEmu;GEmu:=oGEmu;
     Hide;END;
 END;
 IF (iAddress=WinGadgets[GDMathAccel])AND WinOp THEN
  MFac:=code;END;
 IF (iAddress=WinGadgets[GDGraphAccel])AND WinOp THEN
  GFac:=code;END;
 IF (iAddress=WinGadgets[GDGraphEmu])AND WinOp THEN
  GEmu:=code;cyc:=TRUE;
   IF GEmu=8 THEN
    IF e.OpenLibrary("fuckWindows.library",47)=NIL THEN
     bol:=rq.RequestWin("Error opening library!",
       "You need at least version 47.11\nof fuckWindows.library for\n"
       "this graphics mode .",
       "","Ok",WinWnd);
    END;
   END;
  END;
 IF (iAddress=WinGadgets[GDFPUType])AND WinOp THEN
  MEmu:=code;cyc:=TRUE;END;
 gt.ReplyIMsg(ms);
 Refresh(cyc);
END;
END;
UNTIL (ms=NIL) OR ~WinOp;
UNTIL Quit;
END;
ShutDown;
END Accel.

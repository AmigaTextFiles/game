MODULE SafeRet;

IMPORT e:Exec,
       es:ExecSupport,
       cx:Commodities,
       conv:Conversions,
       ie:InputEvent,
       y:SYSTEM,
       d:Dos,
       wb:Workbench,
       rq:ReqTools,
       ol:OberonLib,
       I: Intuition,
       u: Utility,
       ic:Icon;

VAR
     PopKey:ARRAY 100 OF CHAR;
     MyBrk :cx.CxObjPtr;
     MyFil :cx.CxObjPtr;
     MySnd :cx.CxObjPtr;
     MyTrs :cx.CxObjPtr;
     NwBrk :cx.NewBroker;
     MsPrt :e.MsgPortPtr;
     Quit  :BOOLEAN;
     Shut  :BOOLEAN;
     Err   :LONGINT;
     eMsg  :e.APTR;
     Msg   :cx.CxMsgPtr;
     MsTp  :LONGSET;
     MsId  :LONGINT;
     CxPri :LONGINT;
     CxKey :ARRAY 254 OF CHAR;
     Signal:LONGSET;

PROCEDURE GetToolTypes;
VAR This:d.ProcessPtr;
    wbm:wb.WBStartupPtr;
    sptr:e.STRPTR;
    MyIcon:wb.DiskObjectPtr;
    OCurrentDir:d.FileLockPtr;
BEGIN;
This:=y.VAL(d.ProcessPtr,ol.Me);
CxPri:=0;CxKey:="return";
IF ol.wbStarted THEN
 wbm:=ol.wbenchMsg;
 OCurrentDir:=This.currentDir;
 y.SETREG(0,d.CurrentDir(wbm.argList[0].lock));
 MyIcon := ic.GetDiskObject(wbm.argList[0].name^);
 y.SETREG(0,d.CurrentDir(OCurrentDir));
 IF MyIcon#NIL THEN
  sptr := ic.FindToolType(MyIcon.toolTypes,"CX_PRIORITY");
  IF sptr#NIL THEN IF conv.StringToInt(sptr^,CxPri) THEN END;END;
  ic.FreeDiskObject(MyIcon);
 END;
END;
END GetToolTypes;

PROCEDURE Disable;
BEGIN;
IF cx.ActivateCxObj(MyBrk,0)#0 THEN END;
END Disable;

PROCEDURE Enable;
BEGIN;
IF cx.ActivateCxObj(MyBrk,1)#0 THEN END;
END Enable;

PROCEDURE Init():BOOLEAN;
VAR ret:BOOLEAN;
BEGIN;
ret:=TRUE;
Shut:=FALSE;
IF ret THEN
MsPrt:=e.CreateMsgPort();
IF MsPrt=NIL THEN ret:=FALSE;END;
IF ret THEN
NwBrk.version:=cx.nbVersion;
NwBrk.name:=y.ADR("SafeRet");
NwBrk.title:=y.ADR("SafeRet 1.0 by HDS");
NwBrk.descr:=y.ADR("Safer System");
NwBrk.unique:=SET{0,1};
NwBrk.flags:=SET{};
NwBrk.pri:=SHORT(SHORT(CxPri));
NwBrk.port:=MsPrt;
NwBrk.reservedChannel:=0;
MyBrk:=cx.CxBroker(NwBrk,Err);
IF Err#0 THEN ret:=FALSE;END;
IF ret THEN
MyFil:=cx.CxFilter(y.ADR(CxKey));
MySnd:=cx.CxSender(MsPrt,cx.cxmIEvent);
MyTrs:=cx.CxTranslate(NIL);
IF cx.CxObjError(MyBrk)#LONGSET{} THEN ret:=FALSE;END;
IF cx.CxObjError(MyFil)#LONGSET{} THEN ret:=FALSE;END;
IF cx.CxObjError(MyTrs)#LONGSET{} THEN ret:=FALSE;END;
cx.AttachCxObj(MyBrk,MyFil);
cx.AttachCxObj(MyFil,MySnd);
cx.AttachCxObj(MyFil,MyTrs);
IF cx.CxObjError(MyBrk)#LONGSET{} THEN ret:=FALSE;END;
IF cx.CxObjError(MyFil)#LONGSET{} THEN ret:=FALSE;END;
IF cx.CxObjError(MyTrs)#LONGSET{} THEN ret:=FALSE;END;
IF cx.ActivateCxObj(MyBrk,1)#0 THEN ret:=FALSE;END;
IF MyFil=NIL THEN ret:=FALSE;END;
IF MySnd=NIL THEN ret:=FALSE;END;
IF MyTrs=NIL THEN ret:=FALSE;END;
IF cx.CxObjError(MyBrk)#LONGSET{} THEN ret:=FALSE;END;
IF cx.CxObjError(MyFil)#LONGSET{} THEN ret:=FALSE;END;
IF cx.CxObjError(MyTrs)#LONGSET{} THEN ret:=FALSE;END;
END;END;END;
RETURN (ret);
END Init;

PROCEDURE ShutDown;
BEGIN;
IF MyBrk#NIL THEN cx.DeleteCxObjAll(MyBrk);
REPEAT;UNTIL e.GetMsg(MsPrt)=NIL;END;
IF MsPrt#NIL THEN
e.DeleteMsgPort(MsPrt);END;
END ShutDown;

PROCEDURE CheckCx;
VAR iv:ie.InputEventPtr;
    dort:BOOLEAN;
BEGIN;
dort:=FALSE;
IF MsPrt#NIL THEN
REPEAT;
eMsg:=e.GetMsg(MsPrt);
IF eMsg#NIL THEN
Msg:=y.VAL(cx.CxMsgPtr,eMsg);
MsTp:=cx.CxMsgType(Msg);
MsId:=cx.CxMsgID(Msg);
e.ReplyMsg(eMsg);
 IF MsTp=LONGSET{cx.cxmIEvent} THEN
  IF rq.EZRequestTags("Really ?",
  "Yes|No",NIL,NIL,rq.ezFlags,LONGSET{rq.ezReqNoReturnKey},u.done)=1
  THEN
   dort:=TRUE;
  END;
 END;
 IF MsTp=LONGSET{cx.cxmCommand} THEN
  IF MsId=cx.cmdDisable THEN Disable;END;
  IF MsId=cx.cmdEnable THEN Enable;END;
  IF MsId=cx.cmdKill THEN Quit:=TRUE;END;
  IF MsId=cx.cmdUnique THEN Quit:=TRUE;END;
 END;
END;
UNTIL eMsg=NIL;
END;
IF dort THEN
 NEW(iv);
 IF cx.InvertKeyMap(13,iv,NIL)#0 THEN
  cx.AddIEvents(iv);
  DISPOSE(iv);
 END;
END;
END CheckCx;

BEGIN;
GetToolTypes;
IF Init() THEN
Enable;
CheckCx;
REPEAT;
e.WaitPort(MsPrt);
CheckCx;
UNTIL Quit;
END;
ShutDown;

END SafeRet.


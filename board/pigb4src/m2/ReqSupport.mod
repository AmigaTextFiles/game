IMPLEMENTATION MODULE ReqSupport;

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=TRUE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=FALSE StackParms:=TRUE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT 
  ADDRESS,ADR;
FROM OptReq IMPORT
  reqFileRequester, reqFileRequesterPtr, FRQINFOGADGETM, FRQNODRAGM, FRQCACHINGM,
  GetString, ReqFileRequester, ColorRequester, TRStructure, TRStructurePtr,
  TextRequest, StrPtr, FRQABSOLUTEXYM, FRQCACHEPURGEM, PurgeFiles,
  GetLongStructPtr, GetLong, GLNODEFAULTM, REQVERSION, reqBase;
FROM Heap IMPORT
  Allocate, Deallocate;
FROM String IMPORT
  Copy;

(* Finds all \ in a string and replaces them with LineFeed CHR(10) *)
PROCEDURE BackSlashToLF(VAR st:ARRAY OF CHAR);
VAR
  hst,n:CARDINAL;
BEGIN
  hst:=HIGH(st); (* It's not guaranteed that allocated as much as max-length *)
                 (* (if POINTER TO string used). Therefore it's *)
                 (* NEEDED to stop when string-termination 0C found. *) 
  n:=0;
  WHILE (n<=hst) AND (st[n]<>0C) DO
    IF st[n]='\\' THEN 
      st[n]:=12C; (* CHR(10) = 12 oktalt *)
    END;
    INC(n);
  END;
END BackSlashToLF;

PROCEDURE TwoGadRequest(string:StrPtr; TimeOut:CARDINAL; parameterlist:ADDRESS):CARDINAL;
VAR
  trsp:TRStructurePtr;
  rv:CARDINAL;
BEGIN
  Allocate(trsp,SIZE(TRStructure));
  BackSlashToLF(string^);  
  WITH trsp^ DO
    Text:=string;
    Controls:=parameterlist;
    Window:=wsptr;
    PositiveText:=ADR(POSTEXT);
    NegativeText:=ADR(NEGTEXT);
    KeyMask:=0FFFFH;
    versionnumber:=REQVERSION;
    Timeout:=TimeOut;
  END;
  rv:=TextRequest(trsp);
  Deallocate(trsp);
  RETURN(rv);
END TwoGadRequest;

PROCEDURE ThreeGadRequest(string:StrPtr; TimeOut:CARDINAL; parameterlist:ADDRESS):CARDINAL;
VAR
  trsp:TRStructurePtr;
  rv:CARDINAL;
BEGIN
  Allocate(trsp,SIZE(TRStructure));
  BackSlashToLF(string^);  
  WITH trsp^ DO
    Text:=string;
    Controls:=parameterlist;
    Window:=wsptr;
    MiddleText  :=ADR(MIDTEXT); 
    PositiveText:=ADR(POSTEXT);
    NegativeText:=ADR(NEGTEXT);
    KeyMask:=0FFFFH;
    versionnumber:=REQVERSION;
    Timeout:=TimeOut;
  END;
  rv:=TextRequest(trsp);
  Deallocate(trsp);
  RETURN(rv);
END ThreeGadRequest;

PROCEDURE SimpleRequest(string:StrPtr; TimeOut:CARDINAL; parameterlist:ADDRESS):CARDINAL;
VAR
  trsp:TRStructurePtr;
  rv:CARDINAL;
BEGIN
  Allocate(trsp,SIZE(TRStructure));
  BackSlashToLF(string^);  
  WITH trsp^ DO
    Text:=string;
    Controls:=parameterlist;
    Window:=wsptr;
    PositiveText:=ADR(POSTEXT);
    KeyMask:=0FFFFH;
    versionnumber:=REQVERSION;
    Timeout:=TimeOut;
  END;
  rv:=TextRequest(trsp);
  Deallocate(trsp);
  RETURN(rv);
END SimpleRequest;

PROCEDURE LongRequest(VAR result:LONGINT; title:StrPtr; min,max,
                      default:LONGINT):BOOLEAN;
VAR
  glsp:GetLongStructPtr;
  ok  :BOOLEAN;
BEGIN
  Allocate(glsp,SIZE(glsp^));
  WITH glsp^ DO
    titlebar:=title;
    defaultval:=default;
    minlimit:=min;
    maxlimit:=max;
    window:=wsptr;
    IF (default<min) OR (default>max) THEN 
      flags:=GLNODEFAULTM;
    END;
  END;
  ok:=GetLong(glsp)<>0;
  result:=glsp^.result;
  Deallocate(glsp);
  RETURN(ok);
END LongRequest;

PROCEDURE SimpleFileRequester(title:ARRAY OF CHAR; VAR name,path,
                              dir:ARRAY OF CHAR):BOOLEAN;
VAR
  frp:reqFileRequesterPtr;
  ok:BOOLEAN;
BEGIN
  Allocate(frp,SIZE(reqFileRequester));
  WITH frp^ DO
    Title:=ADR(title);
    numlines  :=16;
    numcolumns:=32;
    devcolumns:= 8;
    (* WindowLeftEdge:=100;  these two would have a meaning if *)
    (* WindowTopEdge :=  1;  FRQABSOLUTEXYM was set *)
    Copy(Hide,'*.bak');
    Copy(Show,'*');
    File:=    ADR(name);
    PathName:=ADR(path);
    Window:=wsptr;
    Dir:=     ADR(dir);
    Flags:=FRQINFOGADGETM;
  END;
  ok:=ReqFileRequester(frp)<>0;
  Deallocate(frp);
  RETURN(ok);
END SimpleFileRequester;

BEGIN
  reqOn:=reqBase<>NIL;
  POSTEXT:='  OK  ';
  MIDTEXT:=' DROP ';
  NEGTEXT:=' UPS! ';
  wsptr:=NIL;
END ReqSupport.

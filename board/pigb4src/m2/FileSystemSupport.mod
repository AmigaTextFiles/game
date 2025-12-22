IMPLEMENTATION MODULE FileSystemSupport; (* EBM 1-95 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=TRUE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=TRUE StackParms:=TRUE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

(*$IF Test *)
  FROM W IMPORT
    WRITELN, WRITE, CONCAT, s, l, lf, c, READs;
(*$ENDIF *)

FROM SYSTEM IMPORT
  ADR;
FROM String IMPORT
  Length;
FROM FileSystem IMPORT
  File, ReadChar, WriteChar, WriteBytes, done;

(* ReadString strips evt. trailing CR's (used in IBM PCs TEXT files) *)
PROCEDURE ReadString(VAR f:File; VAR st:ARRAY OF CHAR);
VAR
  p:INTEGER;
BEGIN
  p:=0;
  REPEAT
    ReadChar(f,st[p]);
    INC(p);
  UNTIL f.eof OR (st[p-1]=12C) OR (p>HIGH(st)) OR (f.res<>done);
  IF (st[p-1]=12C) OR (p>HIGH(st)) THEN DEC(p) END;
  IF (p>0) & (st[p-1]=15C) THEN DEC(p); END;
  st[p]:=0C;
END ReadString;

PROCEDURE WriteStr(VAR f:File; st:ARRAY OF CHAR);
VAR
  Actual:LONGINT;
BEGIN
  WriteBytes(f,ADR(st),Length(st),Actual);
END WriteStr;

PROCEDURE WriteString(VAR f:File; st:ARRAY OF CHAR);
VAR
  Actual:LONGINT;
BEGIN
  WriteBytes(f,ADR(st),Length(st),Actual);
  WriteChar(f,12C);
END WriteString;

END FileSystemSupport.

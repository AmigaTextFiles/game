IMPLEMENTATION MODULE VersionLog;

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=TRUE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(* 5-96 nasty bug: no explanation, but no alloc but static bettered it *)

(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT 
  ADR;
FROM String IMPORT
  Concat,Length,Copy;

(*$ IF Test *)
FROM W IMPORT
   WRITE,WRITELN,CONCAT,c,s,l,lf,READs;
(*$ ENDIF *)

CONST
  VersionLogModCompilation="19";

VAR
  n:CARDINAL;
  vl:ARRAY[0..MaxLogs] OF STR40;

PROCEDURE LogVersion(Name:ARRAY OF CHAR; Version:ARRAY OF CHAR);
VAR
  st:STR40;
BEGIN
  IF n<=MaxLogs THEN
  (*$IF Test *)
    IF Length(Name)>32 THEN
      WRITELN(s('VersionLog: Name>32'));
    END;
  (*$ENDIF *)
    Copy(st,Name);
    Concat(st,' v');
    Concat(st,Version);
    VersionList[n]:=ADR(vl[n]);
    vl[n]:=st;
    INC(n);
(*$IF Test *)
  ELSE
    WRITELN(s('VersionLog: n>30'));
(*$ENDIF *)
  END;
END LogVersion;
  
BEGIN
(*$IF Test *)
  WRITELN(s('VersionLog.1'));
(*$ENDIF *)
  FOR n:=0 TO MaxLogs DO
    VersionList[n]:=NIL;
  END;
  n:=0;
  LogVersion("VersionLog.def",VersionLogDefCompilation);
  LogVersion("VersionLog.mod",VersionLogModCompilation);
(*$IF Test *)
  WRITELN(s('VersionLog.2'));
(*$ENDIF *)
END VersionLog.

IMPLEMENTATION MODULE SkakBase;         (* (c) E.B.Madsen 91 DK     Rev 5/6-94.01 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
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
FROM VersionLog IMPORT
  LogVersion;

CONST
  SkakBaseModCompilation="28";

VAR
  n:INTEGER;

BEGIN
(*$IF Test *)
  WRITELN(s('SkakBase.1'));
(*$ENDIF *)
  LogVersion("SkakBase.def",SkakBaseDefCompilation);
  LogVersion("SkakBase.mod",SkakBaseModCompilation);
  FOR n:=-12 TO MaxExtras DO
    gFilters[n,0]:=0C;
    gFlags[n]:=FALSE;
    gInverse[n]:=FALSE;
  END;
  NoAutoPGN:=FALSE;
  Quick:=FALSE;
  LLSIZE   := 32;
(*$IF Test *)
  WRITELN(s('SkakBase.2'));
(*$ENDIF *)
END SkakBase.

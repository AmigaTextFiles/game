IMPLEMENTATION MODULE DosKald;

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Chks:=TRUE *)

(*$ LongAlign:=TRUE StackParms:=TRUE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM Arts IMPORT
  wbStarted, Assert;

FROM SYSTEM IMPORT
  ADR;

FROM DosD IMPORT
  FileHandlePtr;

FROM DosL IMPORT
  Execute, Input, Output;

PROCEDURE DoDosCommand(CommandStr : ARRAY OF CHAR;
		       FilInd,FilUd : FileHandlePtr);
VAR
  Result : LONGINT;
  ResultBoolean : BOOLEAN;

BEGIN
  IF wbStarted AND (FilUd=NIL) THEN
    FilUd:=Output();
  END;
  Result:=Execute(ADR(CommandStr),FilInd,FilUd);
  (*Assert(Result#NIL,ADR("DosCall failed"));*)
END DoDosCommand;

END DosKald.

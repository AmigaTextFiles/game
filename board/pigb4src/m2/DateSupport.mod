IMPLEMENTATION MODULE DateSupport;

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

FROM SYSTEM IMPORT
  ADR;
FROM IntuitionL IMPORT
  CurrentTime;
FROM DateConversions IMPORT
  DateInfo, FromDos, DateToStr, month3;

(* !!!!!!!!!!!! skal bruge IntuitionL.CurrentTime i stedet !!!!!!!!!!!!!!! *)
PROCEDURE GetDate(VAR di:DateInfo);
BEGIN
   CurrentTime(ADR(di.minutes),ADR(di.micros));
   di.minutes:=di.minutes DIV 60;
END GetDate;

PROCEDURE GetDateStr(VAR st:ARRAY OF CHAR);
VAR
  di:DateInfo;
BEGIN
  GetDate(di);
  DateToStr(di,"D. %d %t %y  %H:%M:%S",month3,st);
END GetDateStr;

PROCEDURE DayOfDate(dd,mm,yyyy:CARDINAL):LONGCARD;
VAR
  Fr:LONGCARD;
BEGIN               (* beregner dagnr siden år 0, ugedag=FR MOD 7 (0=lørdag) *)
  Fr:=LONGCARD(yyyy)*365+dd+31*(mm-1);
  CASE mm OF
    | 1..2  : Fr:=Fr+(yyyy-1) DIV 4-3*((yyyy-1) DIV 100+1) DIV 4; 
    | 3..12 : Fr:=Fr+yyyy DIV 4-3*(yyyy DIV 100+1) DIV 4-CARDINAL(TRUNC(2.3+FLOAT(mm)*0.4));
    ELSE Fr:=0;
  END;
  RETURN Fr;
END DayOfDate;

END DateSupport.

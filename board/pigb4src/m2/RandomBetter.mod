IMPLEMENTATION MODULE RandomBetter;

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

FROM SYSTEM IMPORT
  CAST, ADR;

IMPORT DosL; FROM DosD IMPORT
  DosLibraryPtr, RootNodePtr;

VAR
  XSeed,YSeed,ZSeed : INTEGER;

PROCEDURE PutSeed(X,Y,Z:INTEGER);
BEGIN
  WHILE X<0 DO X:=X+30269 END;
  WHILE Y<0 DO Y:=Y+30307 END;
  WHILE Z<0 DO Z:=Z+30323 END;
  WHILE X>30268 DO X:=X-30269 END;
  WHILE Y>30306 DO Y:=Y-30307 END;
  WHILE Z>30322 DO Z:=Z-30323 END;
  XSeed:=X;
  YSeed:=Y;
  ZSeed:=Z;
END PutSeed;

PROCEDURE GetSeed(VAR X,Y,Z:INTEGER);
BEGIN
  X:=XSeed;
  Y:=YSeed;
  Z:=ZSeed;
END GetSeed;

PROCEDURE Randomize;
TYPE
  DA=ARRAY[1..2] OF INTEGER;
VAR
  d:DA;
  dosLib:DosLibraryPtr;
  rp:RootNodePtr;
BEGIN
  dosLib := ADR(DosL);                  (* derfor var IMPORT Dos nødvendig *)
  rp:=dosLib^.root;
  d:=CAST(DA,dosLib^.root^.time.tick);
  XSeed:=d[1];
  YSeed:=d[2];
  d:=CAST(DA,dosLib);
  YSeed:=YSeed+d[1];
  ZSeed:=d[2];
  PutSeed(XSeed,YSeed,ZSeed);
END Randomize;

PROCEDURE Random():REAL;
VAR
  TMP:REAL;
BEGIN
  (*LAVET AF BRIAN WICHMANN OG DAVID HILL (3 MDR FULDTIDSARBEJDE), BYTE MAR 87*)
  (*KLARER SERIEL-TEST, POKERHÅNDS-TEST, RUNUP/DOWN-TEST (SOM ANDRE FEJLER!) *)
  (*FØRSTE GENERATOR*)
  XSeed:=171*(XSeed MOD 177)-2*(XSeed DIV 177);
  IF XSeed<0 THEN XSeed:=XSeed+30269 END;
  (*ANDEN GENERATOR*)
  YSeed:=172*(YSeed MOD 176)-35*(YSeed DIV 176);
  IF YSeed<0 THEN YSeed:=YSeed+30307 END;
  (*TREDIE GENERATOR*)
  ZSeed:=170*(ZSeed MOD 178)-63*(ZSeed DIV 178);
  IF ZSeed<0 THEN ZSeed:=ZSeed+30323 END;
  (*KOMBINER TIL FUNKTIONS VÆRDI*)
  TMP:=FLOAT(XSeed)/30269.0+FLOAT(YSeed)/30307.0+FLOAT(ZSeed)/30323.0;
  RETURN(TMP-FLOAT(TRUNC(TMP)));
END Random;

PROCEDURE RND(N:INTEGER):INTEGER;
BEGIN
  RETURN(TRUNC(Random()*FLOAT(N)));
END RND;

BEGIN
  XSeed:=7;       (* vilkårlige, men start altid med samme seed *)
  YSeed:=4099;
  ZSeed:=9991;
END RandomBetter.

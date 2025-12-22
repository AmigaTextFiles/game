IMPLEMENTATION MODULE StrSupport;   (* COPYRIGHT (C) E.B.MADSEN 1988 *)

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

FROM String IMPORT 
  Length, Compare, Concat, ConcatChar, CopyPart, Copy;

FROM Conversions IMPORT
  ValToStr,StrToVal;

PROCEDURE IntVal(S:ARRAY OF CHAR):INTEGER;
VAR
  err:BOOLEAN;
  l:LONGINT;
  signed:BOOLEAN;
BEGIN
  StrToVal(S,l,signed,10,err);
  IF err OR (l>32767) OR (l<-32768) THEN
    RETURN(0);
  ELSE
    RETURN(INTEGER(l));
  END;
END IntVal;

PROCEDURE LongintVal(S:ARRAY OF CHAR):LONGINT;
VAR
  err:BOOLEAN;
  l:LONGINT;
  signed:BOOLEAN;
BEGIN
  StrToVal(S,l,signed,10,err);
  IF err THEN
    RETURN(0);
  ELSE
    RETURN(l);
  END;
END LongintVal;

PROCEDURE CardVal(S:ARRAY OF CHAR):CARDINAL;
VAR
  err:BOOLEAN;
  l:LONGINT;
  signed:BOOLEAN;
BEGIN
  StrToVal(S,l,signed,10,err);
  IF err OR (l>65535) OR (l<0) THEN
    RETURN(0);
  ELSE
    RETURN(CARDINAL(l));
  END;
END CardVal;

PROCEDURE Eq(S1,S2:ARRAY OF CHAR):BOOLEAN;
VAR
  n:CARDINAL;
BEGIN
  n:=0;
  WHILE (S1[n]=S2[n]) & ~(S1[n]=0C) DO
    INC(n);
  END;
  RETURN((S1[n]=0C) & (S2[n]=0C));
END Eq;

PROCEDURE Gt(S1,S2:ARRAY OF CHAR):BOOLEAN;
VAR
  n:CARDINAL;
BEGIN
  n:=0;
  WHILE (S1[n]=S2[n]) & ~(S1[n]=0C) DO
    INC(n);
  END;
  RETURN((S1[n]>S2[n]));
END Gt;

VAR
  ValidStartTST :CARDINAL;
  ValidStopTST  :CARDINAL;

PROCEDURE ValidV(VAR S1,S2:ARRAY OF CHAR;P1,P2:CARDINAL):BOOLEAN;
VAR
  MATCH,FEJL,TMP:BOOLEAN;
  STOP:CARDINAL;
  N,M:CARDINAL;
  ST1,ST2,SH:STRING;
BEGIN
  IF P1=2 THEN ValidStart:=P2 END;
  IF (P1>CARDINAL(Length(S1))) OR (P2>CARDINAL(Length(S2))) THEN 
    TMP := (S1[P1-1]='*') OR (S1[P1-1]='¿');
    IF TMP THEN ValidStopTST:=P2 END;
    MATCH := (P2=CARDINAL(Length(S2))+1) AND ((P1=CARDINAL(Length(S1))+1)
    OR TMP AND (P1=CARDINAL(Length(S1))));
    ValidStop  := ValidStopTST;
  ELSE 
    FEJL:=FALSE;
    CASE S1[P1-1] OF
      | '[' : 
              N:=1;
              MATCH:=FALSE;
              WHILE (S1[P1+N-1] <> ']') AND NOT FEJL DO 
                IF NOT MATCH THEN MATCH := S1[P1+N-1]=S2[P2-1] END;
                INC(N);
                IF CARDINAL(Length(S1)) < P1+N THEN 
                  FEJL:=TRUE;
                END;
              END;
              IF MATCH THEN MATCH:=ValidV(S1,S2,P1+N+1,P2+1) END;
      | '(' : 
              M:=1;
              WHILE (S1[P1+M-1]<>')') AND NOT FEJL DO 
                INC(M);
                IF CARDINAL(Length(S1)) < P1+M THEN 
                  FEJL:=TRUE;
                END;
              END;
              IF NOT FEJL THEN 
                N:=0;
                CopyPart(ST2,S2,P2-1,CARDINAL(Length(S2))-P2+1);
                REPEAT
                  INC(N);
                  ST1:='';
                  WHILE (S1[P1+N-1]<>'|') AND (S1[P1+N-1]<>')') 
                    AND (S1[P1+N-1]<>',') DO 
                    ST1[Length(ST1)+1]:=0C;
                    ST1[Length(ST1)]:=(S1[P1+N-1]);
                    INC(N);
                  END;
                  CopyPart(SH,S1,P1+M,CARDINAL(Length(S1))-M-P1);
                  Concat(ST1,SH);
                  MATCH:=Valid(ST1,ST2);
                UNTIL (S1[P1+N-1]=')') OR MATCH;
              END;
      | '¿' : (* shift+alt+M *) 
              MATCH:=ValidV(S1,S2,P1+1,P2);
              IF NOT MATCH THEN MATCH:=ValidV(S1,S2,P1+1,P2+1) END;
      | '?' : 
              MATCH:=ValidV(S1,S2,P1+1,P2+1);
      | '*' : 
              N:=0;
              STOP:=CARDINAL(Length(S2))-P2+2;
              MATCH:=FALSE;
              ValidStopTST:=P2;
              WHILE (N<STOP) AND NOT MATCH DO 
                MATCH := ValidV(S1,S2,P1+1,P2+N);
                INC(N);
              END;
      | '~' : 
              MATCH := NOT ValidV(S1,S2,P1+1,P2);
    ELSE  
              IF S1[P1-1]=S2[P2-1] THEN MATCH:=ValidV(S1,S2,P1+1,P2+1)
              ELSE MATCH:=FALSE END;
    END;
    IF FEJL THEN MATCH:=FALSE END;
  END;
  RETURN(MATCH);
END ValidV;

PROCEDURE Valid(S1,S2:ARRAY OF CHAR):BOOLEAN;
BEGIN
  IF (CARDINAL(Length(S1))>0) AND (CARDINAL(Length(S2))>FromPos) AND ValidV(S1,S2,1,FromPos+1) THEN 
    IF S1[0]<>'*' THEN ValidStart:=1 END;
    IF S1[Length(S1)-1]<>'*' THEN ValidStop:=Length(S2)+1 END;
    FromPos:=0;
    RETURN(TRUE);
  ELSE 
    FromPos:=0;
    RETURN(FALSE);
  END;
END Valid;

PROCEDURE UpCase(CH:CHAR):CHAR;
BEGIN
  IF (CH>='a') AND (CH<='z') THEN 
    RETURN(CAP(CH));
  ELSE 
    IF (CH>=200C) AND (CH<=377C) THEN 
      CASE CH OF
        | 'æ' : RETURN('Æ');
        | 'ø' : RETURN('Ø');
        | 'å' : RETURN('Å');
      ELSE 
        RETURN(CH);
      END;
    ELSE
      RETURN(CH);
    END;
  END;
END UpCase;

PROCEDURE TrimString(VAR Str:ARRAY OF CHAR; Width:CARDINAL);
VAR
  St:ARRAY[0..255] OF CHAR;
BEGIN
  IF Width < CARDINAL(Length(Str)) THEN 
    CopyPart(Str,Str,0,Width)
  ELSE 
    St:="";
    WHILE Width > CARDINAL(Length(Str)) DO 
      ConcatChar(St,' ');
      DEC(Width);
    END;
    Concat(St,Str);
    Copy(Str,St);
  END;
END TrimString;

PROCEDURE TrimVal(VAR Str:ARRAY OF CHAR; Value:LONGINT; Width:CARDINAL);
VAR
  err:BOOLEAN;
BEGIN
  ValToStr(Value,TRUE,Str,10,Width,' ',err);
END TrimVal;

PROCEDURE UpString(VAR Str:ARRAY OF CHAR);
VAR
  N:INTEGER;
BEGIN
  FOR N:=0 TO Length(Str)-1 DO 
    Str[N]:=UpCase(Str[N]);
  END;
END UpString;

PROCEDURE in(ch:CHAR; st:ARRAY OF CHAR):BOOLEAN;
(*  IF in(ch,'a..zæøåA..ZÆØÅ') THEN ... *)
VAR
  n:INTEGER;
  Found:BOOLEAN;
BEGIN
  Found:=FALSE;
  n:=0;
  WHILE (n<=HIGH(st)) AND NOT Found DO
    Found := ch=st[n];
    IF (st[n]='.') AND (n<HIGH(st)) AND (st[n+1]='.') THEN
      Found := (ch>st[n-1]) AND (ch<=st[n+2]);
      INC(n,2);
    END;
    INC(n);
  END;
  RETURN(Found);
END in;

BEGIN
  FromPos:=0;
END StrSupport.

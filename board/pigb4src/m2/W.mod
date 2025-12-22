IMPLEMENTATION MODULE W; (* *)

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

FROM String IMPORT
  Length, Concat;
FROM Terminal IMPORT
  ReadLn, WriteLn, WriteString;
FROM Conversions IMPORT
  StrToVal, ValToStr;

PROCEDURE s(st:ARRAY OF CHAR):CARDINAL;
BEGIN
  Concat(Buf,st);
  RETURN(0);
END s;

PROCEDURE sf(st:ARRAY OF CHAR; f:INTEGER):CARDINAL;
VAR
  n,leng:CARDINAL;
  m:BOOLEAN;
BEGIN
  IF f<0 THEN
    Concat(Buf,st);
    FOR n:=HIGH(st)+2 TO -f DO 
      Concat(Buf,' ');
    END;
  ELSE
    FOR n:=HIGH(st)+2 TO f DO 
      Concat(Buf,' ');
    END;
    Concat(Buf,st);
  END;
  RETURN(0);
END sf;

PROCEDURE c(ch:CHAR):CARDINAL;
VAR
  len:CARDINAL;
BEGIN
  len:=Length(Buf);
  IF len<SIZE(Buf)-1 THEN
    Buf[len]:=ch;
    Buf[len+1]:=0C;
  END;
  RETURN(0);
END c;

PROCEDURE cf(ch:CHAR; f:INTEGER):CARDINAL;
VAR
  len:CARDINAL;
BEGIN
  IF f>1 THEN
    FOR len:=2 TO f DO
      Concat(Buf,' ');
    END;
  END;
  len:=Length(Buf);
  IF len<SIZE(Buf)-1 THEN
    Buf[len]:=ch;
    Buf[len+1]:=0C;
  END;
  IF f<-1 THEN
    FOR len:=2 TO -f DO
      Concat(Buf,' ');
    END;
  END;
  RETURN(0);
END cf;

PROCEDURE l(l:LONGINT):CARDINAL;
VAR
  st:ARRAY[0..40] OF CHAR;
  err:BOOLEAN;
BEGIN
  ValToStr(l,TRUE,st,10,1,' ',err);
  Concat(Buf,st);
  RETURN(0);
END l;

PROCEDURE lf(l:LONGINT; f:INTEGER):CARDINAL;
VAR
  st:ARRAY[0..40] OF CHAR;
  err:BOOLEAN;
BEGIN
  ValToStr(l,TRUE,st,10,f,' ',err);
  Concat(Buf,st);
  RETURN(0);
END lf;

PROCEDURE l0(l:LONGINT; f:INTEGER):CARDINAL;
VAR
  st:ARRAY[0..40] OF CHAR;
  err:BOOLEAN;
BEGIN
  ValToStr(l,TRUE,st,10,f,'0',err);
  Concat(Buf,st);
  RETURN(0);
END l0;

PROCEDURE lh(l:LONGINT; f:INTEGER):CARDINAL;
VAR
  st:ARRAY[0..40] OF CHAR;
  err:BOOLEAN;
BEGIN
  ValToStr(l,FALSE,st,16,f,'0',err);
  Concat(Buf,st);
  RETURN(0);
END lh;

PROCEDURE lo(l:LONGINT; f:INTEGER):CARDINAL;
VAR
  st:ARRAY[0..40] OF CHAR;
  err:BOOLEAN;
BEGIN
  ValToStr(l,FALSE,st,8,f,'0',err);
  Concat(Buf,st);
  RETURN(0);
END lo;

PROCEDURE lb(l:LONGINT; f:INTEGER):CARDINAL;
VAR
  st:ARRAY[0..40] OF CHAR;
  err:BOOLEAN;
BEGIN
  ValToStr(l,FALSE,st,8,f,'0',err);
  Concat(Buf,st);
  RETURN(0);
END lb;

PROCEDURE b(bool:BOOLEAN):CARDINAL;
BEGIN
  IF bool THEN
    Concat(Buf,'TRUE')
  ELSE
    Concat(Buf,'FALSE')
  END;
  RETURN(0);
END b;

PROCEDURE bf(bool:BOOLEAN; f:INTEGER):CARDINAL;
BEGIN
  IF bool THEN
    RETURN(sf('TRUE',f));
  ELSE
    RETURN(sf('FALSE',f))
  END;
END bf;

PROCEDURE WRITE(n:CARDINAL);
BEGIN
  WriteString(Buf);
  Buf[0]:=0C;
END WRITE;

PROCEDURE WRITELN(n:CARDINAL);
BEGIN
  WriteString(Buf);
  WriteLn;
  Buf[0]:=0C;
END WRITELN;

PROCEDURE FREEBUF;
BEGIN
  Buf[0]:=0C;
END FREEBUF;

PROCEDURE CONCAT(n:CARDINAL);
BEGIN
END CONCAT;

PROCEDURE READs(VAR st:ARRAY OF CHAR);
VAR
  len:INTEGER;
BEGIN
  ReadLn(st,len);
END READs;

PROCEDURE READcn(VAR n:CARDINAL; base:CARDINAL);
VAR
  len:INTEGER;
  l:LONGINT;
  s:ARRAY[0..255] OF CHAR;
  err,signed:BOOLEAN;
BEGIN
  REPEAT
    ReadLn(s,len);
    StrToVal(s,l,signed,base, err);
    IF NOT err THEN 
      IF (l<0) OR (l>65535) THEN err:=TRUE END;
    END;
  UNTIL NOT err;
  n:=l;
END READcn;

PROCEDURE READc(VAR n:CARDINAL);
BEGIN
  READcn(n,10);
END READc;

PROCEDURE READch(VAR n:CARDINAL);
BEGIN
  READcn(n,16);
END READch;

PROCEDURE READco(VAR n:CARDINAL);
BEGIN
  READcn(n,8);
END READco;

PROCEDURE READcb(VAR n:CARDINAL);
BEGIN
  READcn(n,2);
END READcb;

PROCEDURE READln(VAR n:LONGINT; base:CARDINAL);
VAR
  len:INTEGER;
  l:LONGINT;
  s:ARRAY[0..255] OF CHAR;
  err,signed:BOOLEAN;
BEGIN
  REPEAT
    ReadLn(s,len);
    StrToVal(s,l,signed,base, err);
  UNTIL NOT err;
  n:=l;
END READln;

PROCEDURE READl(VAR n:LONGINT);
BEGIN
  READln(n,10);
END READl;

PROCEDURE READlh(VAR n:LONGINT);
BEGIN
  READln(n,16);
END READlh;

PROCEDURE READlo(VAR n:LONGINT);
BEGIN
  READln(n,8);
END READlo;

PROCEDURE READlb(VAR n:LONGINT);
BEGIN
  READln(n,2);
END READlb;

PROCEDURE READi(VAR n:INTEGER);
VAR
  len:INTEGER;
  l:LONGINT;
  s:ARRAY[0..255] OF CHAR;
  err,signed:BOOLEAN;
BEGIN
  REPEAT
    ReadLn(s,n);
    StrToVal(s,l,signed,10,err);
    IF NOT err THEN 
      IF (l<-32768) OR (l>32767) THEN err:=TRUE END;
    END;
  UNTIL NOT err;
  n:=l;
END READi;

PROCEDURE READb(VAR bool:BOOLEAN);
VAR
  len:INTEGER;
  l:LONGINT;
  s:ARRAY[0..255] OF CHAR;
  err,signed:BOOLEAN;
BEGIN
  err:=TRUE;
  REPEAT
    ReadLn(s,len);
    IF (s[0]='1') OR (s[0]='T') OR (s[0]='t') THEN
      bool:=TRUE;
      err:=FALSE;
    ELSIF (s[0]='0') OR (s[0]='F') OR (s[0]='f') THEN
      bool:=FALSE;
      err:=FALSE;
    END;
  UNTIL NOT err;
END READb;

BEGIN
  Buf[0]:=0C; (* Initier (tøm) buffer *)
END W.

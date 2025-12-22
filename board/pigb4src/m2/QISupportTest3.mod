MODULE QITestSupportTest2;

(* Demo of the more advanced, but still easy to use windows *)

(*$ DEFINE Test:=TRUE *)
(*$ DEFINE False:=FALSE *)
(*$ DEFINE True:=TRUE *)

FROM SYSTEM IMPORT
  ADR;

FROM String IMPORT
  Length;

FROM QISupport IMPORT
  VINDUE, STRINGPTR, CREATEWIN, OPENWIN, WAITWIN, CLOSEWIN, MSGWIN, PRINTWIN,
  EscWIN, OkWIN, DropWIN, ActiveWIN, InactiveWIN, CLEARWIN, CURSOR, Edit;

(*$ IF Test *)
FROM W IMPORT
  WRITE, WRITELN, s, l, lf, bf;
(*$ ENDIF *)


PROCEDURE Edit(VAR txt:ARRAY OF CHAR);
VAR
  Vindue1:VINDUE;
  res,X,Y,code,lt,n,cx,cy,MAXSIZE:INTEGER;
  Ins,clr:BOOLEAN;
  ch:CHAR;
PROCEDURE CUR;
VAR
  cx,cy,cp:INTEGER;
BEGIN
  cx:=0;
  cy:=0;
  cp:=0;
  WHILE cp<X DO
    INC(cp);
    IF txt[cp-1]=12C THEN
      cx:=0;
      INC(cy);
    ELSE
      INC(cx);
    END;
  END;
  CURSOR(Vindue1,cx,cy);
END CUR;
BEGIN (* Edit *)
  MAXSIZE:=HIGH(txt);
  CREATEWIN(Vindue1,TRUE,TRUE,FALSE);
  Vindue1.Tekst:=ADR(txt);
  OPENWIN(Vindue1,ADR('Test titel'),200,100, 600,250, 10,4, 640,256,TRUE,FALSE,FALSE,TRUE,TRUE);
  Ins:=TRUE;
  X:=0;
  CUR;
  REPEAT
    res:=MSGWIN(Vindue1,TRUE);
    IF (res>=512) & (res<768-128) THEN (* rawKey, keycode for down*)
      IF res=512+76 THEN (* Up *)
        cx:=0;
        WHILE (X>0) & (txt[X-1]<>12C) DO
          DEC(X);
          INC(cx);
        END;
        IF X>0 THEN DEC(X) END;
        WHILE (X>0) & (txt[X-1]<>12C) DO
          DEC(X);
        END;
        WHILE (txt[X]<>12C) & (cx>0) DO
          INC(X);
          DEC(cx);
        END;
      END;
      IF (res=512+77) & (txt[X]<>0C) THEN (* Dn *)
        cx:=0;
        WHILE (X>0) & (txt[X-1]<>12C) DO
          DEC(X);
          INC(cx);
        END;
        WHILE (X<MAXSIZE) & (txt[X]<>12C) & (txt[X]<>0C) DO
          INC(X);
        END;
        IF (X<MAXSIZE) & (txt[X]=12C) THEN INC(X) END;
        WHILE (X<MAXSIZE) & (txt[X]<>12C) & (cx>0) DO
          INC(X);
          DEC(cx);
        END;
      END;
      IF res=512+78 THEN (* Rt *)
        IF (X<MAXSIZE) & (txt[X]<>0C) THEN
          INC(X);
        END;
      END;
      IF res=512+79 THEN (* Lt *)
        IF X>0 THEN
          DEC(X);
        END;
      END;
      IF res=512+95 THEN (* Help *)
      END;
      IF res=512+80 THEN (* F1 *)
      END;
      PRINTWIN(Vindue1,0,0,ADR(txt),1,0);
      CUR;
    END;
    IF (res>=1024) THEN (* vanillaKey, ASCII *)
      ch:=CHR(res-1024);
      clr:=ch=15C;
      IF (ch>=' ') & (ch<177C) OR (ch>=240C) OR (ch=15C) THEN (* normal char *)
        IF Ins OR (ch=15C) THEN
          lt:=Length(txt);
          IF lt<MAXSIZE THEN
            FOR n:=lt TO X BY -1 DO
              txt[n+1]:=txt[n];
            END;
          END;
        END;
        IF ch=15C THEN ch:=12C END; (* CR to LF *)
        txt[X]:=ch;
        IF X<MAXSIZE THEN
          INC(X);
        END;
      ELSIF (ch=10C) & (X>0) OR (ch=177C) THEN (* BackSpace or Del *) 
        clr:=TRUE;
        IF ch=10C THEN DEC(X) END;
        FOR n:=X TO Length(txt)-1 DO
          IF n<MAXSIZE THEN
            txt[n]:=txt[n+1];
          END;
        END;
      ELSIF ch=11C THEN (* Tab *)
      END;
      IF clr THEN
        CLEARWIN(Vindue1);
      END;
      PRINTWIN(Vindue1,0,0,ADR(txt),1,0);
      CUR;
    END;
  UNTIL (res=EscWIN) OR (res=OkWIN);
  CLOSEWIN(Vindue1);
END Edit;

VAR
  st:ARRAY[0..8] OF CHAR;

BEGIN
  st:='01234567';
  Edit(st);
END QITestSupportTest2.

MODULE QITestSupportTest2;

(* Demo of the more advanced, but still easy to use windows *)

FROM SYSTEM IMPORT
  ADR;
FROM QISupport IMPORT
  VINDUE, STRINGPTR, CREATEWIN, OPENWIN, WAITWIN, CLOSEWIN, MSGWIN, PRINTWIN,
  EscWIN, OkWIN, DropWIN, ActiveWIN, InactiveWIN;

VAR
  Vindue1,Vindue2:VINDUE;
  res:INTEGER;

BEGIN
  CREATEWIN(Vindue1,TRUE,TRUE,FALSE,FALSE);

  Vindue1.Tekst:=ADR('\n\n\n\nTEKST');
  OPENWIN(Vindue1,ADR('Test titel'),80,40, 500,200, 10,4, 640,256,TRUE,FALSE,FALSE,TRUE,TRUE,FALSE);
  REPEAT
    res:=MSGWIN(Vindue1,TRUE);
    IF res=InactiveWIN THEN
      PRINTWIN(Vindue1,20,20, ADR(' InactiveWIN '),0,1);
    ELSIF res=ActiveWIN THEN
      PRINTWIN(Vindue1,20,20, ADR(' ActiveWIN   '),1,0);
    END;
  UNTIL (res=EscWIN) OR (res=OkWIN);
  CLOSEWIN(Vindue1);

END QITestSupportTest2.

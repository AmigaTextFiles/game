MODULE QITestSupportTest4;

(* Demo of the simple full-screen-editor *)

FROM SYSTEM IMPORT
  ADR;
FROM QISupport IMPORT
  Edit,FontY;

VAR
  st:ARRAY[0..89] OF CHAR;

BEGIN
  st:='01234567';
(*  FontY:=16;*)
  IF Edit(st,ADR('Titel'),60,60, 1640,1256, 320,128, TRUE)=1 THEN
     REPEAT
     UNTIL Edit(st,ADR('Titel'), -1,-1, -1,-1, -1,-1, TRUE)=1;
  END;
END QITestSupportTest4.

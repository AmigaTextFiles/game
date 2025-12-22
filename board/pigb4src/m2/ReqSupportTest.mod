MODULE ReqSupportTest; (* V1.1 *)

(*$ DEFINE Test:=TRUE *)
(*$ LongAlign:=TRUE StackParms:=TRUE CStrings:=TRUE LargeVars:=TRUE *)
(*$ IF Test *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

(* Rev: numlines=60 changed to 12. Otherwise the new req.library v2.5
   (9/11-90 WB2.0-fonts compatible) slowed down opening the filerequester.
   Rev 1.1: Now use W instead of WRITE
*)

FROM SYSTEM IMPORT 
  ADDRESS,ADR;
FROM OptReq IMPORT
  reqFileRequester, reqFileRequesterPtr, FRQINFOGADGETM, FRQNODRAGM, FRQCACHINGM,
  GetString, ReqFileRequester, ColorRequester, TRStructure, TRStructurePtr,
  TextRequest, StrPtr, FRQABSOLUTEXYM, FRQCACHEPURGEM, PurgeFiles,
  GetLongStructPtr, GetLong, GLNODEFAULTM, reqBase;
FROM ReqSupport IMPORT
  LongRequest, SimpleFileRequester, SimpleRequest, TwoGadRequest,
  ThreeGadRequest, TEXTSTR, POSTEXT, MIDTEXT, NEGTEXT;
FROM W IMPORT
  WRITELN,s,l,b;
FROM Heap IMPORT
  Allocate, Deallocate;
FROM String IMPORT
  Copy;

VAR
  ll:LONGINT;
  i:INTEGER;
  n:CARDINAL;
  frp:reqFileRequesterPtr;
  glsp:GetLongStructPtr;
  f:BOOLEAN;
  sb,st,navn,path,dir,headline:ARRAY[0..80] OF CHAR;
  trsp:TRStructurePtr;
  OK:BOOLEAN;

BEGIN
  IF reqBase=NIL THEN
    WRITELN(s("req.library kunne ikke indlæses!")); 
  ELSE
    WRITELN(s("En test af ReqSupport.def og Req.def for CED's req.library")); 
  END;
  (* ColorRequester *)
  i:=2;
  REPEAT
    WRITELN(s('CR-kald ')+l(i));
    i:=ColorRequester(i);
    WRITELN(s('CR-retur ')+l(i));
  UNTIL i<0;

  (* FileRequester *)
  Allocate(frp,SIZE(reqFileRequester));
  n:=1;
  navn:='prt:';
  WITH frp^ DO
    Title:=ADR("Hejsa");
    numlines  :=16;
    numcolumns:=32;
    devcolumns:=12;
    WindowLeftEdge:=100; (* de to har kun betydning når FRQABSOLUTEXYM er sat *)
    WindowTopEdge :=  1;
    Copy(Hide,'*.bak');
    Copy(Show,'*');
    File:=    ADR(navn);
    PathName:=ADR(path);
    Dir:=     ADR(dir);
    Flags:=FRQINFOGADGETM+FRQCACHINGM+FRQABSOLUTEXYM+FRQCACHEPURGEM;
  END;
  REPEAT
    WRITELN(s('FR-kald'));
    ll:=ReqFileRequester(frp);
    WRITELN(s('FR-retur ')+l(ll));
    WRITELN(s(navn));
    WRITELN(s(dir));
    WRITELN(s(path));
    INC(n);
  UNTIL (ll=0) OR (n>5);
  PurgeFiles(frp);  (* frigør ram, som FRQ har allokeret. Kun nødvendig hvis *)
                  (* FRQEXTSELECTM eller FRQCACHINGM har været brugt *)
  Deallocate(frp);

  (* GetString *)
  n:=0;
  REPEAT
    WRITELN(s('GS-kald'));
    ll:=GetString(ADR(sb),ADR(st),NIL,20,24);
    WRITELN(s('GS-retur ')+l(ll));
    INC(n);
  UNTIL (ll=0) OR (n>5);

  (* textRequester *)
  Allocate(trsp,SIZE(TRStructure));
  WITH trsp^ DO
    Text:=ADR('Teksten er her'); (* max 5000 tegn i alt (flere linier 12C) *) 
    MiddleText  :=ADR('Midt:Her returneres 2');
    PositiveText:=ADR('Positiv:Her 1');
    NegativeText:=ADR('Negativ:Her 0');
    Title       :=ADR('titel på TextRequesteren');
  END;
  n:=0;
  REPEAT
    INC(n);
    WRITELN(s('FR-kald'));
    ll:=TextRequest(trsp);
    WRITELN(s('FR-retur ')+l(ll));
  UNTIL (ll=0) OR (n>5);

  REPEAT
    ll:=SimpleRequest(ADR('-------- SimpleRequest ---------'),0,NIL);
    WRITELN(s('SR-retur ')+l(ll));
  UNTIL ll=1;

  REPEAT
    ll:=SimpleRequest(ADR('-------- SimpleRequest, TimeOut = 4 sec ---------'),4,NIL);
    WRITELN(s('SR-retur ')+l(ll));
  UNTIL ll=1;

  REPEAT
    ll:=TwoGadRequest(ADR('------TwoGadgRequest ------'),0,NIL);
    WRITELN(s('2GR-retur ')+l(ll));
  UNTIL ll=0;

  REPEAT
    ll:=ThreeGadRequest(ADR('-----\n-------------ThreeGadg\nRequest ----\n-'),0,NIL);
    WRITELN(s('3GR-retur ')+l(ll));
  UNTIL ll=0;

  (* Get a LONGINT *)
  Allocate(glsp,SIZE(glsp^));
  WITH glsp^ DO
    titlebar:=ADR(' Indtast et tal : ');
    defaultval:=-1456;
    minlimit:=-999999;
    maxlimit:=31;
  END;
  REPEAT
    ll:=GetLong(glsp);
    WRITELN(s('GL-retur ')+l(ll)+s('   LONGINT=')+l(glsp^.result));
  UNTIL ll=0;
  Deallocate(glsp);

  REPEAT
    OK:=LongRequest(ll,ADR(' Indtast måned '),1,31,-6);
    WRITELN(s('LR-retur ')+b(OK)+s('   LONGINT=')+l(ll));
  UNTIL ~ OK;

  REPEAT
    WRITELN(s('FR-kald'));
    headline:=' Vælg Fil : ';
    OK:=SimpleFileRequester(headline,navn,path,dir);
    WRITELN(s('FR-retur ')+b(OK));
    WRITELN(s(navn));
    WRITELN(s(dir));
    WRITELN(s(path));
  UNTIL ~ OK; 

END ReqSupportTest.

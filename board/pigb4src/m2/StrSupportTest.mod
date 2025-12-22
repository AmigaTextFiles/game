MODULE StrSupportTest; (* V1.0*)
(*$ LongAlign:=TRUE StackParms:=TRUE CStrings:=TRUE LargeVars:=FALSE *)
(*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
    NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)

FROM W IMPORT
  Buf,					(* Buffer (intern) *)
  WRITE,WRITELN,			(* Buffer -> *)	(* Buffer -> + NewLine*)
  FREEBUF,				(* Buffer = '' *)
  CONCAT,				(* Til Buf : *)
  s,sf,					(* String *)	(* String,Felt *)
  c,cf,					(* Char *)	(* Char,Felt *)
  l,lf,l0,lh,lo,lb,			(* Longint, felt, 0-felt,Hex-,Oct-,Binær- *)
  b,bf,					(* Boolean *)	(* Boolean,Felt *)
  READs,				(* String *)
  READc,READch,READco,READcb,		(* Cardinal, Cardinal-Hex,-Oct,-Binær *)
  READl,READlh,READlo,READlb,		(* Longint, Longint-Hex,-Oct,-Binær *)
  READi,				(* Integer *)
  READb;				(* Boolean (f|t | 0|1) *)

FROM StrSupport IMPORT
  Eq,Gt,IntVal,LongintVal,CardVal,UpCase,UpString,TrimString,TrimVal,in;

VAR
  ch:CHAR;
  ss,s2:ARRAY[0..80] OF CHAR;
  ii:INTEGER;
  cc:CARDINAL;
  ll:LONGINT;
  bb:BOOLEAN;

BEGIN

  s2:='';
  REPEAT
    WRITE(s('Test of StrSupport Calls (Q=Quit) : '));
    READs(ss);
    WRITELN(s(ss)+s('  Eq  ')+s(s2)+s(' ? ')+b(Eq(ss,s2)));
    WRITELN(s(ss)+s('  >   ')+s(s2)+s(' ? ')+b(Gt(ss,s2)));
    WRITELN(s(ss)+s('  <=  ')+s(s2)+s(' ? ')+b(~Gt(ss,s2)));
    WRITELN(s(ss)+s('  <   ')+s(s2)+s(' ? ')+b(Gt(s2,ss)));
    WRITELN(s(ss)+s('  >=  ')+s(s2)+s(' ? ')+b(~Gt(s2,ss)));
    WRITELN(s('IntVal    : ')+l(IntVal(ss)));
    WRITELN(s('LongintVal: ')+l(LongintVal(ss)));
    WRITELN(s('CardVal   : ')+l(CardVal(ss)));
    WRITELN(s('s[0] in si: ')+b(in(s2[0],ss)));
    UpString(s2);
    WRITELN(s('UpString  : ')+s(s2));
    TrimString(s2,20);
    WRITELN(s('TrimString: ')+s(s2)+s(' (20)'));
    s2:=ss;
  UNTIL ss[0]='Q';
    
END StrSupportTest.

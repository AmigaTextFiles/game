MODULE Wtest; (* V1.1*)

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

VAR
  ch:CHAR;
  ss,s2:ARRAY[0..80] OF CHAR;
  ii:INTEGER;
  cc:CARDINAL;
  ll:LONGINT;
  bb:BOOLEAN;

BEGIN

  WRITELN(s('Test of StrSupport Calls (Q=Quit)...'));
  s2:='';
  REPEAT
    READs(ss);
    WRITELN(s(ss)+s('  Eq ')+s(s2)+s(' ? ')+b(Eq(ss,s2));
    WRITELN(s(ss)+s('  >  ')+s(s2)+s(' ? ')+b(Gt(ss,s2));
    WRITELN(s(ss)+s('  <= ')+s(s2)+s(' ? ')+b(~Gt(ss,s2));
    WRITELN(s(ss)+s('  <  ')+s(s2)+s(' ? ')+b(Gt(s2,ss));
    WRITELN(s(ss)+s('  >= ')+s(s2)+s(' ? ')+b(~Gt(s2,ss));
    WRITELN(s('IntVal    :')+l(IntVal(ss));
    WRITELN(s('LongintVal:')+l(LongintVal(ss));
    WRITELN(s('CardVal   :')+l(CardVal(ss));
    s2:=ss;
  UNTIL ss[1]='Q';
    
  WRITELN(l(32));       (* test *)
  WRITELN(l(1234567));
  WRITELN(l(-234));
  WRITELN(lf(30,6));
  WRITELN(lf(30,-6));
  WRITELN(lf(-30,6));
  WRITELN(lf(-30,-6));
  WRITELN(c('A')+c('B'));
  WRITELN(b(TRUE));
  WRITELN(b(FALSE));
  WRITELN(lh(271,4));
  WRITELN(s('Hejsa'));
  WRITELN(c('"')+sf('Hejsa',8)+c('"'));
  WRITELN(c('"')+sf('Hejsa',-8)+c('"'));
  WRITE(s('Tallet er ')+l(234)+c('c'));
  WRITELN(0);

  READs(ss); WRITELN(s(ss));
  READi(ii); WRITELN(l(ii));
  READc(cc); WRITELN(l(cc));
  READl(ll); WRITELN(l(ll));
  READb(bb); WRITELN(b(bb));
  READlh(ll);WRITELN(l(ll));
  READco(cc);WRITELN(l(cc));
  READcb(cc);WRITELN(l(cc));
  READs(ss);
END Wtest.

MODULE QITestSupportTest1;

(* Demo of The simple easy to use windows *)

FROM SYSTEM IMPORT
  ADR;
FROM QISupport IMPORT
  OpenInfoWIN, CloseInfoWIN, SimpleWIN, TwoGadWIN, ThreeGadWIN;

VAR
  res:INTEGER;
BEGIN
  OpenInfoWIN(ADR('Test of: InfoWIN, SimpleWIN. TwoGadWIN, ThreeGadWIN'));
  res:=SimpleWIN(ADR('linie 1-4: SimpleWIN\nLinie 2: rio\nLinie3\nLinie4'));
  res:=TwoGadWIN(ADR('linie 1: TwoGadWIN\nLinie 2: rio'));
  res:=ThreeGadWIN(ADR('linie 1: ThreeGadWIN\nLinie 2: rio LONG LONG LONG LONG LONG LONG LONG LONG LONG LINE'));
  CloseInfoWIN;
END QITestSupportTest1.

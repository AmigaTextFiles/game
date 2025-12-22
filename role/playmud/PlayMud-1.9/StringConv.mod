(**********************************************************************

    :Program.    StringConv.mod
    :Contents.   string formatting procedures
    :Author.     Nicolas Benezan [bne]
    :Address.    Postwiesenstr. 2, D7000 Stuttgart 60
    :Phone.      711/333679
    :Copyright.  Public Domain
    :Language.   Oberon
    :Translator. OBERON v3.20
    :History.    V1.0 [bne] 11.May.1989
    :History.    V1.1 [bne] 1.Oct.1989 (bugs fixed)
    :History.    V2.0 [kai] 09-May-90 ported to Oberon
    :History.    V2.1 [lars] recompiled for Oberon-3.00

**********************************************************************)

MODULE StringConv;

CONST
  nul=CHR(0);

VAR
  Ok : BOOLEAN;

PROCEDURE NumToStr(    Int, Base: LONGINT;
                    VAR String: ARRAY OF CHAR);
  CONST
    DigitArray = "0123456789ABCDEF";

  VAR
    Pos: INTEGER;

  PROCEDURE NextDigit;
    VAR
      Digit: CHAR;
    BEGIN
      IF (Pos<=LEN(String)) THEN
        Digit:= DigitArray[Int MOD Base];
        Int:= Int DIV Base;
        IF (Int # 0) THEN
          NextDigit;
        END;
        String[Pos]:= Digit;
        INC (Pos);
      ELSE
        Ok:= FALSE;
      END;
    END NextDigit;

  BEGIN
    IF Int#0 THEN
      Pos:=0;
      NextDigit;
    ELSE
      String[0]:="0";
      Pos:=1;
    END;
    IF Pos<=LEN(String) THEN
      String[Pos]:=nul;
    END;
  END NumToStr;

PROCEDURE IntToStr * (Int: LONGINT;
                    VAR String: ARRAY OF CHAR);
(*:Semantic.    Converts an INTEGER, CARDINAL or LONGINT variable into
  :Semantic.    a String (decimal).
*)
  BEGIN
    NumToStr (Int, 10, String);
  END IntToStr;

PROCEDURE StrToInt * (String: ARRAY OF CHAR): LONGINT;
(*:Semantic.    Converts a String into a LONGINT value
*)
  CONST
    Base = 10;
    MaxDivBase = MAX (LONGINT) DIV Base;
  VAR
    Int: LONGINT;
    Pos: INTEGER;
    Digit: CHAR;
    Neg: BOOLEAN;
  BEGIN
    Int:= 0;
    IF String[0] # "-" THEN
      Pos:= 0;
      Neg:= FALSE;
    ELSE
      Pos:= 1;
      Neg:= TRUE;
    END;
    LOOP
      IF Pos > LEN(String) THEN
        EXIT
      END;
      Digit:= String[Pos];
      IF (Digit < "0") OR (Digit > "9") THEN
        IF Digit # nul THEN
          Ok:= FALSE;
        END;
        EXIT
      END;
      DEC (Digit, ORD ("0"));
      IF Int <= MaxDivBase THEN
        Int:= Int * Base;
        IF Int <= MAX (LONGINT) - ORD (Digit) THEN
          INC (Int, ORD (Digit));
        ELSE (* overflow *)
          Ok:= FALSE;
          EXIT
        END;
      ELSE (* overflow *)
        Ok:= FALSE;
        EXIT
      END;
      INC (Pos);
    END;
    IF Neg THEN
      RETURN -Int
    ELSE
      RETURN Int
    END;
  END StrToInt;

PROCEDURE IntToHex * (    Int:LONGINT;
                    VAR String:ARRAY OF CHAR);
(*:Semantic.    Converts an INTEGER or LONGINT variable into
  :Semantic.    a String (hexadecimal).
*)
  BEGIN
    NumToStr (Int, 16, String);
  END IntToHex;

PROCEDURE ConversionOk * (): BOOLEAN;

(*:Result.      FALSE if there's been an error since the last call
  :Result.      to ConversionOk().
*)

  VAR
    ConvOk: BOOLEAN;
  BEGIN
    ConvOk:= Ok;
    Ok:= TRUE;
    RETURN ConvOk
  END ConversionOk;

BEGIN
  Ok:=TRUE;
END StringConv.


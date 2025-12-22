IMPLEMENTATION MODULE bgKonvert;
(****h* Backgammon/bgKonvert *************************************************
*
*       NAME
*           bgKonvert
*
*       COPYRIGHT
*           © 1995, Marc Ewert
*
*       FUNCTION
*           Stellt Fkt. zum Konvertieren von und zu Benutzereingaben.
*
*       AUTHOR
*           Marc Ewert
*
*       CREATION DATE
*           12.06.95
*
*       HISTORY
*           V1.00 - (11.03.96)
*                   * Erste Version
*
*       NOTES
*
************************************************************************************
*)

IMPORT

  c   : Conversions,
  mui : bgMui;

(*--------------------------------------------------------------------------------*)

PROCEDURE Str2Zug ( eingabe : ARRAY OF CHAR; VAR zug : mui.Zug );
(****** bgKonvert/Str2Zug ************************************************
*
*       NAME
*           Str2Zug
*
*       SYNOPSIS
*           Str2Zug ( eingabe, zug )
*
*           Str2Zug ( ARRAY OF CHAR, Zug )
*
*       FUNCTION
*           Konvertiert einen String in eine vom Programm verarbeitbare
*           Zugdarstellung.
*
*       INPUTS
*           eingabe - Zu konvertierender String.
*
*       RESULT
*           zug - Erhaltende Zugdarstellung. x1 = 0 => Eingabe fehlerhaft.
*
*       NOTES
*
*       SEE ALSO
*           Zug2Str
*
************************************************************************************
*)

VAR cnt, x, y, i : CARDINAL;
    nr           : ARRAY [0..255] OF CHAR;
    long         : LONGINT;
    signed, err  : BOOLEAN;

BEGIN (* Str2Zug *)

  FOR x := 1 TO 4 DO           (* zug erstmal löschen *)
    zug[x,1] := 0;
    zug[x,2] := 0
  END; (* FOR *)
  x := 0; y := 1; cnt:=1;
  WHILE ( eingabe[x] <> CHAR ( 0 ) ) AND ( cnt <= 4 ) DO
    i := 0;
    WHILE ( eingabe[x] <> "," ) AND ( eingabe[x] <> CHAR ( 0 ) ) DO
      nr[i] := eingabe[x];
      INC ( i ); INC ( x )
    END; (* WHILE *)
    IF eingabe[x] = "," THEN INC ( x ) END; (* IF *)
    nr[i] := CHAR ( 0 );                (* Zahl herausgelesen *)
    c.StrToVal ( nr, long, signed, 10, err );
    IF err THEN zug[1,1] := 0
    ELSE zug[cnt,y] := long;
    END; (* IF *)
    IF y = 2 THEN y := 1; INC ( cnt )
    ELSE y := 2
    END (* IF *)
  END (* WHILE *)

END Str2Zug;

(*--------------------------------------------------------------------------------*)

PROCEDURE Zug2Str ( zug : mui.Zug; VAR ausgabe : ARRAY OF CHAR );
(****** bgKonvert/Zug2Str ************************************************
*
*       NAME
*           Zug2Str
*
*       SYNOPSIS
*           Zug2Str ( zug, ausgabe )
*
*           Zug2Str ( Zug, ARRAY OF CHAR )
*
*       FUNCTION
*           Konvertiert interne Zugdarstellung in String.
*
*       INPUTS
*           zug - Zu konvertiernde interne Darstellung.
*
*       RESULT
*           ausgabe - erhaltender String.
*
*       NOTES
*
*       SEE ALSO
*           Str2Zug
*
************************************************************************************
*)

VAR x, y, i : CARDINAL;
    nr      : ARRAY [0..255] OF CHAR;
    long    : LONGINT;
    err     : BOOLEAN;

BEGIN (* Zug2Str *)

  x := 0;
  FOR i := 1 TO 4 DO
    IF (zug[i,1] <> 0) OR (zug[i,2] <> 0) THEN
      FOR y := 1 TO 2 DO
        long := zug[i,y];
        c.ValToStr ( long, FALSE, nr, 10, 2, " ", err );
        ausgabe[x] := nr[0];
        ausgabe[x+1] := nr[1];
        IF y = 1 THEN ausgabe[x+2] := "-"
        ELSE ausgabe[x+2] := ","
        END; (* IF *)
        INC ( x, 3 )
      END (* FOR *)
    END (* IF *)
  END; (* FOR *)
  ausgabe[x] := 0C

END Zug2Str;


END bgKonvert.


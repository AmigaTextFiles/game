MODULE test;

IMPORT

  io : InOut,
  ro : RealInOut,
  str : bgStrukturen;

(*---------------------------------------------------------------------------*)

TYPE ProbeArr = ARRAY [0..12] OF REAL;
     DeltaArr = ARRAY [0..24] OF REAL;

    (* probe[x] = Wahrscheinlichkeit für x Würfelkombinationen von 21 *)
VAR probe := ProbeArr {0.0,0.0476,0.0952,0.1429,0.1905,0.2381,0.2857,0.3333,0.3809,
                       0.4286,0.4762,0.5238,0.5714};
    (* delta[x] = Wahrscheinlichkeit geschlagen zu werden für x Abstand *)
    delta := DeltaArr {0.0,0.2857,0.3333,0.3809,0.4286,0.3809,0.4762,0.1429,0.1905,
                       0.1429,0.0952,0.0476,0.1429,0.0,0.0,0.0476,0.0476,0.0,0.0476,
                       0.0,0.0476,0.0,0.0,0.0,0.0476};

(*--------------------------------------------------------------------------------*)

PROCEDURE MaxInt (a, b : INTEGER) : INTEGER;

BEGIN (* MaxInt *)

  IF a > b THEN RETURN a
  ELSE RETURN b
  END (* IF *)

END MaxInt;

(*---------------------------------------------------------------------------*)

PROCEDURE SchlagWkt (brett : str.Brett; x, angreifer : INTEGER) : REAL;
(* Berechnet die Wahrscheinlichkeit, dass angreifer opfer nach naechstem Wurf *)
(* schlagen kann *)

VAR cnt : INTEGER;

BEGIN (* SchlagMoeglichkeiten *)

  cnt := 0;
  IF brett[x] = -1 THEN    (* schwarzer Stein *)
    CASE angreifer-x OF
       1 : cnt := 6;
    |  2 : cnt := 6; IF brett[x+1] >= -1 THEN INC (cnt) END (* IF *)
    |  3 : cnt := 6;
           IF (brett[x+1] >= -1) AND (brett[x+2] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+1] >= -1) OR (brett[x+2] >= -1) THEN INC (cnt) END (* IF *)
    |  4 : cnt := 6;
           IF (brett[x+1] >= -1) AND (brett[x+2] >= -1) AND (brett[x+3] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+1] >= -1) OR (brett[x+3] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+2] >= -1) THEN INC (cnt) END (* IF *)
    |  5 : cnt := 6;
           IF (brett[x+1] >= -1) OR (brett[x+4] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+2] >= -1) OR (brett[x+3] >= -1) THEN INC (cnt) END (* IF *)
    |  6 : cnt := 6;
           IF (brett[x+1] >= -1) OR (brett[x+5] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+2] >= -1) OR (brett[x+4] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+3] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+2] >= -1) AND (brett[x+4] >= -1) THEN INC (cnt) END (* IF *)
    |  7 : IF (brett[x+1] >= -1) OR (brett[x+6] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+2] >= -1) OR (brett[x+5] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+3] >= -1) OR (brett[x+4] >= -1) THEN INC (cnt) END (* IF *)
    |  8 : IF (brett[x+2] >= -1) AND (brett[x+4] >= -1) AND (brett[x+6] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+2] >= -1) OR (brett[x+6] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+3] >= -1) OR (brett[x+5] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+4] >= -1) THEN INC (cnt) END (* IF *)
    |  9 : IF (brett[x+3] >= -1) AND (brett[x+6] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+3] >= -1) OR (brett[x+6] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+4] >= -1) OR (brett[x+5] >= -1) THEN INC (cnt) END; (* IF *)
    | 10 : IF (brett[x+4] >= -1) OR (brett[x+6] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+5] >= -1) THEN INC (cnt) END (* IF *)
    | 11 : IF (brett[x+5] >= -1) OR (brett[x+6] >= -1) THEN INC (cnt) END (* IF *)
    | 12 : IF (brett[x+3] >= -1) AND (brett[x+6] >= -1) AND (brett[x+9] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+4] >= -1) AND (brett[x+8] >= -1) THEN INC (cnt) END; (* IF *)
           IF (brett[x+6] >= -1) THEN INC (cnt) END (* IF *)
    | 15 : IF (brett[x+5] >= -1) AND (brett[x+10] >= -1) THEN INC (cnt) END (* IF *)
    | 16 : IF (brett[x+4] >= -1) AND (brett[x+8] >= -1) AND (brett[x+12] >= -1) THEN INC (cnt) END (* IF *)
    | 18 : IF (brett[x+6] >= -1) AND (brett[x+12] >= -1) THEN INC (cnt) END (* IF *)
    | 20 : IF (brett[x+5] >= -1) AND (brett[x+10] >= -1) AND (brett[x+15] >= -1) THEN INC (cnt) END (* IF *)
    | 24 : IF (brett[x+6] >= -1) AND (brett[x+12] >= -1) AND (brett[x+18] >= -1) THEN INC (cnt) END (* IF *)
    ELSE
    END (* CASE *)
  ELSIF brett[x] = 1 THEN    (* weisser Stein wird geschlagen von schwarzen Stein *)
    CASE x-angreifer OF
       1 : cnt := 6;
    |  2 : cnt := 6; IF brett[x-1] <= 1 THEN INC (cnt) END (* IF *)
    |  3 : cnt := 6;
           IF (brett[x-1] <= 1) AND (brett[x-2] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-1] <= 1) OR (brett[x-2] <= 1) THEN INC (cnt) END (* IF *)
    |  4 : cnt := 6;
           IF (brett[x-1] <= 1) AND (brett[x-2] <= 1) AND (brett[x-3] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-1] <= 1) OR (brett[x-3] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-2] <= 1) THEN INC (cnt) END (* IF *)
    |  5 : cnt := 6;
           IF (brett[x-1] <= 1) OR (brett[x-4] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-2] <= 1) OR (brett[x-3] <= 1) THEN INC (cnt) END (* IF *)
    |  6 : cnt := 6;
           IF (brett[x-1] <= 1) OR (brett[x-5] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-2] <= 1) OR (brett[x-4] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-3] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-2] <= 1) AND (brett[x-4] <= 1) THEN INC (cnt) END (* IF *)
    |  7 : IF (brett[x-1] <= 1) OR (brett[x-6] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-2] <= 1) OR (brett[x-5] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-3] <= 1) OR (brett[x-4] <= 1) THEN INC (cnt) END (* IF *)
    |  8 : IF (brett[x-2] <= 1) AND (brett[x-4] <= 1) AND (brett[x-6] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-2] <= 1) OR (brett[x-6] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-3] <= 1) OR (brett[x-5] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-4] <= 1) THEN INC (cnt) END (* IF *)
    |  9 : IF (brett[x-3] <= 1) AND (brett[x-6] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-3] <= 1) OR (brett[x-6] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-4] <= 1) OR (brett[x-5] <= 1) THEN INC (cnt) END; (* IF *)
    | 10 : IF (brett[x-4] <= 1) OR (brett[x-6] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-5] <= 1) THEN INC (cnt) END (* IF *)
    | 11 : IF (brett[x-5] <= 1) OR (brett[x-6] <= 1) THEN INC (cnt) END (* IF *)
    | 12 : IF (brett[x-3] <= 1) AND (brett[x-6] <= 1) AND (brett[x-9] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-4] <= 1) AND (brett[x-8] <= 1) THEN INC (cnt) END; (* IF *)
           IF (brett[x-6] <= 1) THEN INC (cnt) END (* IF *)
    | 15 : IF (brett[x-5] <= 1) AND (brett[x-10] <= 1) THEN INC (cnt) END (* IF *)
    | 16 : IF (brett[x-4] <= 1) AND (brett[x-8] <= 1) AND (brett[x-12] <= 1) THEN INC (cnt) END (* IF *)
    | 18 : IF (brett[x-6] <= 1) AND (brett[x-12] <= 1) THEN INC (cnt) END (* IF *)
    | 20 : IF (brett[x-5] <= 1) AND (brett[x-10] <= 1) AND (brett[x-15] <= 1) THEN INC (cnt) END (* IF *)
    | 24 : IF (brett[x-6] <= 1) AND (brett[x-12] <= 1) AND (brett[x-18] <= 1) THEN INC (cnt) END (* IF *)
    ELSE
    END (* CASE *)
  END; (* IF *)
  RETURN probe[cnt]

END SchlagWkt;

VAR brett : str.Brett;
    feld, feld2, x, wert, eingabe : INTEGER;

BEGIN

  FOR x := 0 TO 27 DO brett[x] := 0 END; (* IF *)
  REPEAT
    io.WriteString ("1) Feldsetzen\n");
    io.WriteString ("2) Wkt ausrechnen\n");
    io.WriteString ("3) Feld ausgeben\n");
    io.WriteString ("4) Quit\n");
    io.ReadInt (eingabe);
    CASE eingabe OF
      1 : io.WriteString ("Welches Feld: "); io.ReadInt (feld); io.WriteString ("Welchen Feldwert: "); io.ReadInt (wert); brett[feld] := wert;
    | 2 : io.WriteString ("Zu schlagendes Feld: "); io.ReadInt (feld); io.WriteString ("Schlagendes Feld: "); io.ReadInt (feld2);
          ro.WriteReal (SchlagWkt (brett, feld, feld2), 10, 8); io.WriteLn
    | 3 : FOR x := 0 TO 27 DO io.WriteInt (brett[x],4) END; (* IF *)
          io.WriteLn
    ELSE
    END (* CASE *)
  UNTIL eingabe = 4

END test.


IMPLEMENTATION MODULE bgBewerten;
(****h* Backgammon/bgBewerten *************************************************
*
*       NAME
*           bgBewerten
*
*       COPYRIGHT
*           © 1995, Marc Ewert
*
*       FUNCTION
*           Bewertung von Backgammonstellungen.
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

  set : bgSettings,
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

PROCEDURE WeissHeimfeld ( brett : str.Brett ) : LONGINT;
(****** bgBewerten/WeissHeimfeld ************************************************
*
*       NAME
*           WeissHeimfeld
*
*       SYNOPSIS
*           cnt := WeissHeimFeld ( brett )
*
*           LONGINT := WeissHeimFeld ( Brett )
*
*       FUNCTION
*           Berechnet Anzahl der weissen Steine im weissen Heimfeld, inkl. Ziel.
*
*       INPUTS
*           brett - Aktuelle Stellung.
*
*       RESULT
*           cnt - Anzahl der weissen Steine im weissen Heimfeld, inkl. Ziel.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR x, cnt : CARDINAL;

BEGIN (* WeissHeimfeld *)

  cnt := 0;
  FOR x := 0 TO 6 DO
    IF brett[x] > 0 THEN INC (cnt, brett[x]) END (* IF *)
  END; (* FOR *)
  RETURN cnt

END WeissHeimfeld;

(*--------------------------------------------------------------------------------*)

PROCEDURE SchwarzHeimfeld ( brett : str.Brett ) : LONGINT;
(****** bgBewerten/SchwarzHeimfeld ************************************************
*
*       NAME
*           SchwarzHeimfeld
*
*       SYNOPSIS
*           cnt := SchwarzHeimFeld ( brett )
*
*           LONGINT := SchwarzHeimFeld ( Brett )
*
*       FUNCTION
*           Berechnet Anzahl der schwarzen Steine im schwarzen Heimfeld, inkl. Ziel.
*
*       INPUTS
*           brett - Aktuelle Stellung.
*
*       RESULT
*           cnt - Anzahl der schwarzen Steine im schwarzen Heimfeld, inkl. Ziel.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR x, cnt : CARDINAL;

BEGIN (* SchwarzHeimfeld *)

  cnt := 0;
  FOR x := 19 TO 24 DO
    IF brett[x] < 0 THEN INC (cnt, ABS (brett[x])) END (* IF *)
  END; (* FOR *)
  INC (cnt, brett[str.schwarzZiel]);
  RETURN cnt

END SchwarzHeimfeld;


(*--------------------------------------------------------------------------------*)

PROCEDURE Endspiel (bh : str.BgHandle) : BOOLEAN;
(* Sind keine Schlagzuege mehr moeglich? *)

VAR x, i         : INTEGER;
    black, white : BOOLEAN;

BEGIN (* Endspiel *)

  x := 1; black := FALSE;
  WHILE (x <= 24) AND NOT black  DO
    black := bh.brett[x] < 0; INC (x)
  END; (* WHILE *)
  i := x; white := FALSE;
  WHILE (i <= 24) AND NOT white DO
    white := bh.brett[i] > 0; INC (i)
  END; (* WHILE *)
  RETURN NOT (white OR (bh.brett[str.schwarzBar] <> 0) OR (bh.brett[str.weissBar] <> 0))

END Endspiel;

(*---------------------------------------------------------------------------*)

PROCEDURE FreeBlack (bh : str.BgHandle) : REAL;
(* Anzahl Freie Plaetze (weniger als 2 Schwarze) im schwarzen Heimfeld *)

VAR n : REAL;
    x : INTEGER;

BEGIN (* FreeBlack *)

  n := 0.0;
  FOR x := 19 TO 24 DO
    IF bh.brett[x] >= -1 THEN n := n + 1.0 END (* IF *)
  END; (* FOR *)
  RETURN n

END FreeBlack;

(*---------------------------------------------------------------------------*)

PROCEDURE FreeWhite (bh : str.BgHandle) : REAL;
(* Anzahl Freie Plaetze (weniger als 2 Weisse) im weissen Heimfeld *)

VAR n : REAL;
    x : INTEGER;

BEGIN (* FreeWhite *)

  n := 0.0;
  FOR x := 1 TO 6 DO
    IF bh.brett[x] <= 1 THEN n := n + 1.0 END (* IF *)
  END; (* FOR *)
  RETURN n

END FreeWhite;

(*---------------------------------------------------------------------------*)

PROCEDURE SchlagWkt (brett : str.Brett; x, angreifer : INTEGER) : REAL;
(* Berechnet die Wahrscheinlichkeit, dass angreifer opfer nach naechstem Wurf *)
(* schlagen kann *)

VAR cnt : INTEGER;

BEGIN (* SchlagWkt *)

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

(*---------------------------------------------------------------------------*)

PROCEDURE Suche (brett : str.Brett; pos, farbe : INTEGER) : INTEGER;
(* Sucht ab gegebener Position die gegebende Farbe *)

VAR x, cnt : INTEGER;

BEGIN (* Suche *)

  cnt := 0;
  IF farbe = str.schwarz THEN
    FOR x := pos TO 1 BY -1 DO IF brett[x] < 0 THEN INC (cnt, ABS (brett[x])) END (* IF *)
    END (* FOR *)
  ELSE
    FOR x := pos TO 24 DO IF brett[x] > 0 THEN INC (cnt, brett[x]) END (* IF *)
    END (* FOR *)
  END; (* IF *)
  RETURN cnt

END Suche;

(*---------------------------------------------------------------------------*)

PROCEDURE Bewerten ( bh : str.BgHandle ) : LONGINT;
(****** bgBewerten/Bewerten ************************************************
*
*       NAME
*           Bewerten
*
*       SYNOPSIS
*           wert = Bewerten ( bh )
*
*           LONGINT = Bewerten ( BgHandle )
*
*       FUNCTION
*           Bewertet die Backgammonstellung.
*
*       INPUTS
*           bh - Spielzustand.
*
*       RESULT
*           wert  - Wert der Stellung.
*                   Min (=>schwarz gewonnen) >= wert <= Max (=>weiss gewonnen)
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR wert, whiteSum, blackSum                     : LONGINT;
    x, i, whiteLen, blackLen, whiteCnt, blackCnt : INTEGER;
    whiteBlock, blackBlock, black, white         : BOOLEAN;
    p, n                                         : REAL;

BEGIN (* Bewerten *)

  IF bh.brett[str.weissZiel] = 15 THEN RETURN Max            (* weiss gewonnen *)
  ELSIF bh.brett[str.schwarzZiel] = 15 THEN RETURN Min      (* schwarz gewonnen *)
  END; (* IF *)

  wert := 0;

  (* Steine auf der Bar *)
  DEC (wert, bh.brett[str.weissBar] * set.kiSetting[bh.farbe,1,set.bar]);
  INC (wert, ABS (bh.brett[str.schwarzBar]) * set.kiSetting[bh.farbe,2,set.bar]);

  (* Steine im Ziel *)
  INC (wert, bh.brett[str.weissZiel] * set.kiSetting[bh.farbe,1,set.target]);
  DEC (wert, ABS (bh.brett[str.schwarzZiel]) * set.kiSetting[bh.farbe,2,set.target]);

  (* Steine im Heimfeld und Ziel *)
  INC (wert, WeissHeimfeld (bh.brett) * set.kiSetting[bh.farbe,1,set.home]);
  DEC (wert, SchwarzHeimfeld (bh.brett) * set.kiSetting[bh.farbe,2,set.home]);

  (* Gleichmaessige Verteilung im Heimfeld *)
  whiteSum := 0; blackSum := 0; whiteCnt := 0; blackCnt := 0;
  FOR x := 1 TO 6 DO
    IF bh.brett[x] > 0 THEN INC (whiteCnt); INC (whiteSum, bh.brett[x]) END (* IF *)
  END; (* FOR *)
  FOR x := 19 TO 24 DO
    IF bh.brett[x] < 0 THEN INC (blackCnt); INC (blackSum, ABS (bh.brett[x])) END (* IF *)
  END; (* FOR *)
  IF whiteSum > 0 THEN INC (wert, TRUNC ((FLOAT (whiteCnt) / FLOAT (whiteSum)) * FLOAT (set.kiSetting[bh.farbe,1,set.distribution])))
  END; (* IF *)
  IF blackSum > 0 THEN DEC (wert, TRUNC ((FLOAT (blackCnt) / FLOAT (blackSum)) * FLOAT (set.kiSetting[bh.farbe,2,set.distribution])))
  END; (* IF *)

  (* Einzeln stehende Steine *)
  IF NOT Endspiel (bh) THEN
    FOR x := 1 TO 24 DO
      IF bh.brett[x] = 1 THEN
        CASE set.set.level OF
         1 : DEC (wert, set.kiSetting[bh.farbe,1,set.single])
        ELSE p := FLOAT (25 - x) / 24.0; n := FreeBlack (bh);
             IF p <= 0.4 THEN p := (7.0 - n) / 6.0
             END; (* IF *)
             DEC (wert, TRUNC (p * FLOAT (set.kiSetting[bh.farbe,1,set.single])))
        END (* CASE *)
      ELSIF bh.brett[x] = -1 THEN
        CASE set.set.level OF
         1 : INC (wert, set.kiSetting[bh.farbe,2,set.single])
        ELSE p := FLOAT (x) / 24.0; n := FreeWhite (bh);
             IF p <= 0.4 THEN p := (7.0 - n) / 6.0
             END; (* IF *)
             INC (wert, TRUNC (p * FLOAT (set.kiSetting[bh.farbe,2,set.single])))
        END (* CASE *)
      END (* IF *)
    END (* FOR *)
  END; (* IF *)

  (* Einzeln stehende Steine mit Wahrscheinlichkeit geschlagen zu werden *)
  FOR x := 1 TO 24 DO
    IF bh.brett[x] = 1 THEN           (* einzelner weisser Stein *)
      FOR i := x-1 TO 1 BY -1 DO      (* rechts davon suchen *)
        IF bh.brett[i] < 0 THEN
          IF set.set.level >= 3 THEN
            DEC (wert, TRUNC (FLOAT (set.kiSetting[bh.farbe,1,set.singleProb]) *
                 SchlagWkt (bh.brett, x, i) + 0.5))
          ELSE
            DEC (wert, TRUNC (FLOAT (set.kiSetting[bh.farbe,1,set.singleProb]) *
               delta[x-i] + 0.5))
          END (* IF *)
        END (* IF *)
      END; (* FOR *)
      IF bh.brett[str.schwarzBar] <> 0 THEN
        IF set.set.level >= 3 THEN
          DEC (wert, TRUNC (FLOAT (set.kiSetting[bh.farbe,1,set.singleProb]) *
               SchlagWkt (bh.brett, x, i) + 0.5))
        ELSE
          DEC (wert, TRUNC (FLOAT (set.kiSetting[bh.farbe,1,set.singleProb]) *
               delta[x-i] + 0.5))
        END (* IF *)
      END (* IF *)
    ELSIF bh.brett[x] = -1 THEN       (* einzelner schwarzer Stein *)
      FOR i := x+1 TO 24 DO           (* links davon suchen *)
        IF bh.brett[i] > 0 THEN
          IF set.set.level >= 3 THEN
            INC (wert, TRUNC (FLOAT (set.kiSetting[bh.farbe,2,set.singleProb]) *
               SchlagWkt (bh.brett, x, i) + 0.5))
          ELSE
            INC (wert, TRUNC (FLOAT (set.kiSetting[bh.farbe,2,set.singleProb]) *
               delta[i-x] + 0.5))
          END (* IF *)
        END (* IF *)
      END; (* FOR *)
      IF bh.brett[str.weissBar] <> 0 THEN
        IF set.set.level >= 3 THEN
          INC (wert, TRUNC (FLOAT (set.kiSetting[bh.farbe,2,set.singleProb]) *
               SchlagWkt (bh.brett, x, i) + 0.5))
        ELSE
          INC (wert, TRUNC (FLOAT (set.kiSetting[bh.farbe,2,set.singleProb]) *
               delta[i-x] + 0.5))
        END (* IF *)
      END (* IF *)
    END (* IF *)
  END; (* FOR *)

  (* Gesamtentfernung vom Ziel berechnen (für Steine, die nicht im Heimfeld sind *)
  whiteSum := 0; blackSum := 0;
  FOR x := 1 TO 24 DO
    IF (bh.brett[x] > 0) AND (x > 6) THEN INC (whiteSum, INTEGER (bh.brett[x]) * (x-6))
    ELSIF (bh.brett[x] < 0) AND (x < 19) THEN INC (blackSum, ABS (bh.brett[x]) * (19-x))
    END (* IF *)
  END; (* FOR *)
  INC (whiteSum, 24 * bh.brett[str.weissBar]);
  INC (blackSum, 24 * ABS (bh.brett[str.schwarzBar]));
  IF whiteSum > 0 THEN whiteSum := MaxInt (whiteSum DIV 4, 1) END; (* IF *)
  IF blackSum > 0 THEN blackSum := MaxInt (blackSum DIV 4, 1) END; (* IF *)
  DEC (wert, set.kiSetting[bh.farbe,1,set.distance] * whiteSum);
  INC (wert, set.kiSetting[bh.farbe,2,set.distance] * blackSum);

  (* Felder mit 6 oder mehr Steinen *)
  FOR x := 1 TO 24 DO
    IF bh.brett[x] >= 6 THEN DEC (wert, set.kiSetting[bh.farbe,1,set.six])
    ELSIF bh.brett[x] <= -6 THEN INC (wert, set.kiSetting[bh.farbe,2,set.six])
    END (* IF *)
  END; (* FOR *)

  (* Blöcke (mehr als 1 sicheres Feld) *)
  whiteBlock := FALSE; blackBlock := FALSE;
  whiteLen := 0; blackLen := 0;
  FOR x := 1 TO 24 DO
    IF bh.brett[x] > 1 THEN  (* weisses sicheres Feld *)
      IF whiteBlock THEN INC (whiteLen)
      ELSE
        IF blackBlock THEN
          blackBlock := FALSE;
          IF blackLen > 1 THEN
            IF set.set.level >= 3 THEN
              (* Wieviele weisse sind eingesperrt ? *)
              blackLen := blackLen * Suche (bh.brett, x, str.weiss)
            END; (* IF *)
            DEC (wert, blackLen * set.kiSetting[bh.farbe,2,set.block])
          END; (* IF *)
          blackLen := 0
        END; (* IF *)
        whiteBlock := TRUE; whiteLen := 1
      END (* IF *)
    ELSIF bh.brett[x] < -1 THEN  (* schwarzes sicheres Feld *)
      IF blackBlock THEN INC (blackLen)
      ELSE
        IF whiteBlock THEN
          whiteBlock := FALSE;
          IF whiteLen > 1 THEN
            IF set.set.level >= 3 THEN
              (* Es müssen schwarze eingesperrt sein *)
              whiteLen := whiteLen * Suche (bh.brett, x-whiteLen-1, str.schwarz)
            END; (* IF *)
            INC (wert, whiteLen * set.kiSetting[bh.farbe,1,set.block])
          END; (* IF *)
          whiteLen := 0
        END; (* IF *)
        blackBlock := TRUE; blackLen := 1
      END (* IF *)
    ELSIF whiteBlock THEN
      whiteBlock := FALSE;
      IF whiteLen > 1 THEN
        IF set.set.level >= 3 THEN
          whiteLen := whiteLen * Suche (bh.brett, x-whiteLen-1, str.schwarz)
        END; (* IF *)
        INC (wert, whiteLen * set.kiSetting[bh.farbe,1,set.block])
      END; (* IF *)
      whiteLen := 0
    ELSIF blackBlock THEN
      blackBlock := FALSE;
      IF blackLen > 1 THEN
        IF set.set.level >= 3 THEN
          blackLen := blackLen * Suche (bh.brett, x, str.weiss)
        END; (* IF *)
        DEC (wert, blackLen * set.kiSetting[bh.farbe,2,set.block])
      END; (* IF *)
      blackLen := 0
    END (* IF *)
  END; (* FOR *)
  RETURN wert


END Bewerten;

(*$ GenDebug := FALSE *)

END bgBewerten.


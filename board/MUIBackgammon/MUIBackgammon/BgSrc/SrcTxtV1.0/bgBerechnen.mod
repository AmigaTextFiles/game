IMPLEMENTATION MODULE bgBerechnen;
(****h* Backgammon/bgBerechnen *************************************************
*
*       NAME
*           bgBerechnen
*
*       COPYRIGHT
*           © 1995, Marc Ewert
*
*       FUNCTION
*           Fkt. zum Berechnen von Backgammonzügen.
*
*       AUTHOR
*           Marc Ewert
*
*       CREATION DATE
*           14.06.95
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

  b   : bgBewerten,
  str : bgStrukturen,
  z   : bgZiehen;

(*--------------------------------------------------------------------------------*)

PROCEDURE FreiWeiss ( brett : str.Brett; stop : INTEGER ) : BOOLEAN;
(* Keine weissen Steine zwischen 6 und stop inkl. ? *)
(*$ GenDebug := FALSE *)

VAR x : INTEGER;

BEGIN (* FreiWeiss *)

  FOR x := stop TO 6 DO
    IF brett[x] > 0 THEN RETURN FALSE END (* IF *)
  END; (* FOR *)
  RETURN TRUE

END FreiWeiss;

(*--------------------------------------------------------------------------------*)

PROCEDURE FreiSchwarz ( brett : str.Brett; stop : INTEGER ) : BOOLEAN;
(* Keine schwarzen Steine zwischen 19 und stop inkl. ? *)
(*$ GenDebug := FALSE *)

VAR x : INTEGER;

BEGIN (* FreiSchwarz *)

  FOR x := 19 TO stop DO
    IF brett[x] < 0 THEN RETURN FALSE END (* IF *)
  END; (* FOR *)
  RETURN TRUE

END FreiSchwarz;

(*--------------------------------------------------------------------------------*)

PROCEDURE Gueltig ( brett:str.Brett; zug:str.Zug; farbe, wurf:INTEGER) : BOOLEAN;
(* Ist zug bei aktueller Situation möglich *)
(*$ GenDebug := FALSE *)

BEGIN (* Gueltig *)

  IF (zug[1,1] <> str.weissZiel) AND (zug[1,1] <> str.schwarzZiel) THEN
    IF (zug[1,2] <> str.weissBar) AND (zug[1,2] <> str.schwarzBar) THEN
      IF farbe = str.weiss THEN
        IF NOT ((brett[str.weissBar] > 0) AND (zug[1,1] <> str.weissBar)) THEN
          IF (brett[zug[1,1]] > 0) AND (brett[zug[1,2]] >= -1) THEN
            IF (zug[1,1] <> str.schwarzBar) AND (zug[1,2] <> str.schwarzZiel) THEN
              IF zug[1,1] = str.weissBar THEN
                IF (25 - wurf = zug[1,2]) THEN RETURN TRUE
                END (* IF *)
              ELSIF zug[1,2] <> str.weissZiel THEN
                IF (zug[1,1] - wurf = zug[1,2]) THEN RETURN TRUE
                END (* IF *)
              ELSIF wurf >= zug[1,1] THEN
                IF (zug[1,1] - wurf = str.weissZiel) THEN RETURN b.WeissHeimfeld (brett) = 15
                ELSIF FreiWeiss (brett, zug[1,1]+1) THEN RETURN b.WeissHeimfeld (brett) = 15
                END (* IF *)
              END (* IF *)
            END (* IF *)
          END (* IF *)
        END (* IF *)
      ELSE                             (* schwarzer Spieler *)
        IF NOT ((brett[str.schwarzBar] > 0) AND (zug[1,1] <> str.schwarzBar)) THEN
          IF (zug[1,1] <> str.weissBar) AND (zug[1,2] <> str.weissZiel) THEN
            IF zug[1,1] = str.schwarzBar THEN
              IF (brett[zug[1,1]] > 0) AND (brett[zug[1,2]] < 1) THEN
                IF wurf = zug[1,2] THEN RETURN TRUE
                END (* IF *)
              END (* IF *)
            ELSIF zug[1,2] <> str.schwarzZiel THEN
              IF (brett[zug[1,1]] < 0) AND (brett[zug[1,2]] < 1) THEN
                IF (zug[1,1] + wurf = zug[1,2]) THEN RETURN TRUE
                END (* IF *)
              END (* IF *)
            ELSIF brett[zug[1,1]] < 0 THEN
              ELSIF (wurf >= 25 - zug[1,1]) THEN
                IF (zug[1,1] + wurf = str.weissZiel) THEN RETURN b.SchwarzHeimfeld (brett) = 15
                ELSIF FreiSchwarz (brett, zug[1,1]-1) THEN RETURN b.SchwarzHeimfeld (brett) = 15
                END (* IF *)
              END (* IF *)
            END (* IF *)
          END (* IF *)
        END (* IF *)
    END (* IF *)
  END; (* IF *)
  RETURN FALSE

END Gueltig;

(*--------------------------------------------------------------------------------*)

PROCEDURE GueltigHis (bh : str.BgHandle; zug:str.Zug; wurf : CARDINAL):BOOLEAN;
(* Ist zug bei vorheriger Situation möglich *)

VAR result : BOOLEAN;

BEGIN (* GueltigHis *)

  z.Zurueck (bh);
  result := Gueltig (bh.brett, zug, bh.farbe, wurf);
  z.Setzen (bh, zug);
  RETURN result

END GueltigHis;

(*--------------------------------------------------------------------------------*)

PROCEDURE ZugMoeglich (bh : str.BgHandle; history, zug : str.Zug) : BOOLEAN;
(****** bgBerechnen/ZugMoeglich ************************************************
*
*       NAME
*           ZugMoeglich
*
*       SYNOPSIS
*           ok = ZugMoeglich ( bh, history, zug )
*
*           BOOLEAN = ZugMoeglich ( BgHandle, Zug, Zug )
*
*       FUNCTION
*           Überprüft, ob Zug möglich ist.
*
*       INPUTS
*           bh      - Aktueller Spielstand.
*           history - Bisher ausgeführte Züge.
*           zug     - Gewünschter Zug.
*
*       RESULT
*           ok - Besagt, ob Zug gültig ist.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

BEGIN (* ZugMoeglich *)

  IF bh.wurf[1] = bh.wurf[2] THEN             (* Pasch *)
    RETURN Gueltig (bh.brett, zug, bh.farbe, bh.wurf[1] )  (* es ist klar, welcher wurf gesetzt wird *)
  ELSE                                  (* kein Pasch *)
    IF (history[1,1] = 0) AND (history[1,2] = 0) THEN (* erster Zug *)
      IF NOT Gueltig (bh.brett, zug, bh.farbe, bh.wurf[1]) THEN
        RETURN Gueltig (bh.brett, zug, bh.farbe, bh.wurf[2])
      ELSE RETURN TRUE
      END (* IF *)
    ELSE                     (* vorher war schon ein Zug *)
      IF NOT GueltigHis (bh, history, bh.wurf[1]) THEN (* war es der erste Wurf *)
        RETURN Gueltig (bh.brett, zug, bh.farbe, bh.wurf[1]) (* es war der 2., also bleibt nur der 1. übrig *)
      ELSIF Gueltig (bh.brett, zug, bh.farbe, bh.wurf[2]) THEN RETURN TRUE (* 1. Wurf war es nich, also 2. übrig *)
      ELSIF GueltigHis (bh, history, bh.wurf[2]) THEN         (* vieleicht war es der 2. Wurf *)
        RETURN Gueltig (bh.brett, zug, bh.farbe, bh.wurf[1])
      END (* IF *)
    END (* IF *)
  END; (* IF *)
  RETURN FALSE

END ZugMoeglich;

(*--------------------------------------------------------------------------------*)

PROCEDURE KannWurfSetzen ( brett:str.Brett; farbe:CARDINAL; wurf:INTEGER ):BOOLEAN;
(* Schaut, ob wurf gesetzt werden kann. *)

VAR x : INTEGER;

BEGIN (* KannWurfSetzen *)

  IF farbe = str.weiss THEN
    IF brett[str.weissBar] > 0 THEN  (* Ist Stein auf Bar? *)
      IF brett[25 - wurf] >= -1 THEN RETURN TRUE
      END (* IF *)
    ELSIF b.WeissHeimfeld (brett) = 15 THEN   (* alle Weissen im Heimfeld? *)
      FOR x := 1 TO 6 DO              (* alle Heimfelder durchgehen *)
        IF brett[x] > 0 THEN
          IF x >= wurf THEN       (* kann ins Ziel oder davor gesetzt werden? *)
            IF brett[x - wurf] >= -1 THEN RETURN TRUE
            END (* IF *)
          ELSIF FreiWeiss (brett, x+1) THEN RETURN TRUE
          END (* IF *)
        END (* IF *)
      END (* FOR *)
    ELSE         (* keine Sonderregeln *)
      FOR x := 2 TO 24 DO      (* alle Felder durchgehen *)
        IF brett[x] > 0 THEN
          IF x - wurf >= 1 THEN    (* Zug auf Brett? *)
            IF brett[x - wurf] >= -1 THEN RETURN TRUE
            END (* IF *)
          END (* IF *)
        END (* IF *)
      END (* FOR *)
    END (* IF *)
  ELSE                      (* schwarz *)
    IF brett[str.schwarzBar] > 0 THEN  (* Ist Stein auf Bar? *)
      IF brett[wurf] <= 1 THEN RETURN TRUE
      END (* IF *)
    ELSIF b.SchwarzHeimfeld (brett) = 15 THEN   (* alle Schwarzen im Heimfeld? *)
      FOR x := 19 TO 24 DO              (* alle Heimfelder durchgehen *)
        IF brett[x] < 0 THEN
          IF x <= 25 - wurf THEN  (* kann ins Ziel oder davor gesetzt werden? *)
            IF (brett[x + wurf] <= 1) OR (x + wurf = str.schwarzZiel) THEN
              RETURN TRUE
            END (* IF *)
          ELSIF FreiSchwarz (brett, x-1) THEN RETURN TRUE
          END (* IF *)
        END (* IF *)
      END (* FOR *)
    ELSE         (* keine Sonderregeln *)
      FOR x := 1 TO 23 DO      (* alle Felder durchgehen *)
        IF brett[x] < 0 THEN
          IF x + wurf <= 24 THEN    (* Zug auf Brett? *)
            IF brett[x + wurf] <= 1 THEN RETURN TRUE
            END (* IF *)
          END (* IF *)
        END (* IF *)
      END (* FOR *)
    END (* IF *)
  END; (* IF *)
  RETURN FALSE

END KannWurfSetzen;

(*--------------------------------------------------------------------------------*)

PROCEDURE ZugUebrig ( bh : str.BgHandle; history : str.Zug) : BOOLEAN;

(****** bgBerechnen/ZugUebrig ************************************************
*
*       NAME
*           ZugUebrig
*
*       SYNOPSIS
*           erfolg = ZugUebrig ( bh, history )
*
*           BOOLEAN = ZugUebrig ( BgHandle, Zug )
*
*       FUNCTION
*           Prüft, ob noch ein Zug gemacht werden kann.
*
*       INPUTS
*           bh      - Aktueller Zustand.
*           history - Bereits ausgeführte Züge.
*
*       RESULT
*           erfolg - Es kann noch ein Zug gesetzt werden <=> TRUE
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

BEGIN (* ZugUebrig *)

  IF bh.wurf[1] = bh.wurf[2] THEN               (* pasch *)
    IF (history[4,1] = 0) AND (history[4,2] = 0) THEN     (* noch keine 4 Züge *)
      RETURN KannWurfSetzen (bh.brett, bh.farbe, bh.wurf[1])
    END (* IF *)
  ELSE                                     (* kein pasch *)
    IF (history[2,1] = 0) AND (history[2,2] = 0) THEN     (* noch keine 2 Züge *)
      IF (history[1,1] = 0) AND (history[1,2] = 0) THEN   (* noch kein Zug *)
        IF KannWurfSetzen (bh.brett, bh.farbe, bh.wurf[1]) THEN RETURN TRUE
        ELSE RETURN KannWurfSetzen (bh.brett, bh.farbe, bh.wurf[2])
        END (* IF *)
      ELSIF GueltigHis (bh, history, bh.wurf[1]) THEN  (* wurde 1 gesetzt *)
        IF KannWurfSetzen (bh.brett, bh.farbe, bh.wurf[2]) THEN RETURN TRUE
        ELSIF GueltigHis (bh, history, bh.wurf[2]) THEN  (* doch vieleicht 2 *)
          RETURN KannWurfSetzen (bh.brett, bh.farbe, bh.wurf[1])
        END (* IF *)
      ELSE RETURN KannWurfSetzen (bh.brett, bh.farbe, bh.wurf[1])
      END (* IF *)
    END (* IF *)
  END; (* IF *)
  RETURN FALSE

END ZugUebrig;

(*--------------------------------------------------------------------------------*)

PROCEDURE Berechnen ( bh : str.BgHandle; VAR zug : str.Zug );
(****** bgBerechen/Berechnen ************************************************
*
*       NAME
*           Berechnen
*
*       SYNOPSIS
*           Berechnen ( bh, zug )
*
*           Berechnen ( BgHandle, Zug )
*
*       FUNCTION
*           Berechnet besten Zug.
*
*       INPUTS
*           bh - Aktuelles Spielbild.
*
*       RESULT
*           zug - Resultierender "bester" Zug.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR x                     : CARDINAL;
    opt                   : LONGINT;
    optCmpl, dummy, pasch : BOOLEAN;
    trial                 : str.Zug;

(*--------------------------------------------------------------------------------*)

PROCEDURE ZugCp ( VAR dest : str.Zug; source : str.Zug );

VAR x : CARDINAL;

BEGIN (* ZugCp *)

  FOR x := 1 TO 4 DO dest[x,1] := source[x,1]; dest[x,2] := source[x,2] END (* FOR *)

END ZugCp;

(*--------------------------------------------------------------------------------*)

PROCEDURE ZugWeiss ( wurf : str.Wurf; tiefe : CARDINAL ) : BOOLEAN;
(* Probiert jeden möglichen Zug aus und merkt sich den besten. *)

VAR x, y    : INTEGER;
    gesetzt : BOOLEAN;
    setzen  : str.Zug;

(*--------------------------------------------------------------------------------*)

PROCEDURE SetzenWeiss ( von, nach : CARDINAL );
(* Setzt Zug berechnet Folgezüge und nimmt ihn wieder zurück. *)

VAR merk : CARDINAL;
    wert : LONGINT;
    ausgabe : ARRAY [1..255] OF CHAR;

BEGIN (* SetzenWeiss *)

  setzen[1,1] := von; setzen[1,2] := nach;
  trial[tiefe,1] := von; trial[tiefe,2] := nach;
  z.Setzen (bh, setzen);
  merk := wurf[x]; wurf[x] := 0;        (* Zug kann nicht zweimal gesetzt werden *)
  gesetzt := TRUE;
  IF (tiefe = 4) OR ((tiefe = 2) AND NOT pasch) THEN (* Endstellung? *)
    wert := b.Bewerten (bh);
    IF (wert > opt) OR NOT optCmpl THEN  (* Bessere, oder vollständige Endstellung? *)
      ZugCp (zug, trial); opt := wert; optCmpl := TRUE
    END (* IF *)
  ELSIF NOT ZugWeiss (wurf, tiefe+1) THEN     (* Keine Folgezüge vorhanden? *)
    IF (wert > opt) AND NOT optCmpl THEN (* Es gibt keine vollständige Lösung *)
      ZugCp (zug, trial); opt := wert
    END (* IF *)
  END; (* IF *)
  wurf[x] := merk;
  z.Zurueck (bh)

END SetzenWeiss;

(*--------------------------------------------------------------------------------*)

BEGIN (* ZugWeiss *)

  z.ZugLoeschen (setzen);
  gesetzt := FALSE;
  x := 1;
  WHILE x <= 4 DO       (* alle Würfe durchgehen *)
    IF wurf[x] <> 0 THEN   (* normalerweise sind wurf[3] und wurf[4] 0 *)
      IF bh.brett[str.weissBar] > 0 THEN  (* Ist Stein auf Bar? *)
        IF bh.brett[25 - wurf[x]] >= -1 THEN   (* Kann Stein reingesetzt werden *)
          SetzenWeiss (str.weissBar, 25 - wurf[x])
        END (* IF *)
      ELSIF b.WeissHeimfeld (bh.brett) = 15 THEN   (* alle Weissen im Heimfeld? *)
        FOR y := 1 TO 6 DO              (* alle Heimfelder durchgehen *)
          IF bh.brett[y] > 0 THEN
            IF y >= wurf[x] THEN       (* kann ins Ziel oder davor gesetzt werden? *)
              IF bh.brett[y - wurf[x]] >= -1 THEN
                SetzenWeiss (y, y - wurf[x])
              END (* IF *)
            ELSIF FreiWeiss (bh.brett, y+1) THEN (* kann grösserer Wurf rausgesetzt werden? *)
              SetzenWeiss (y, str.weissZiel)
            END (* IF *)
          END (* IF *)
        END (* FOR *)
      ELSE         (* keine Sonderregeln *)
        FOR y := 2 TO 24 DO      (* alle Felder durchgehen *)
          IF bh.brett[y] > 0 THEN
            IF y - wurf[x] >= 1 THEN    (* Zug auf Brett? *)
              IF bh.brett[y - bh.wurf[x]] >= -1 THEN (* Zug möglich? *)
                SetzenWeiss (y, y - wurf[x])
              END (* IF *)
            END (* IF *)
          END (* IF *)
        END (* FOR *)
      END (* IF *)
    END; (* IF *)
    IF gesetzt AND pasch THEN x := 5; (* keine neuen Konstellationen möglich *)
    ELSE INC (x)
    END (* IF *)
  END; (* WHILE *)
  RETURN gesetzt

END ZugWeiss;

(*--------------------------------------------------------------------------------*)

PROCEDURE ZugSchwarz ( wurf : str.Wurf; tiefe : CARDINAL ) : BOOLEAN;
(* Probiert jeden möglichen Zug aus und merkt sich den besten. *)

VAR x, y    : INTEGER;
    gesetzt : BOOLEAN;
    setzen  : str.Zug;

(*--------------------------------------------------------------------------------*)

PROCEDURE SetzenSchwarz ( von, nach : CARDINAL );
(* Setzt Zug berechnet Folgezüge und nimmt ihn wieder zurück. *)

VAR merk : CARDINAL;
    wert : LONGINT;

BEGIN (* SetzenSchwarz *)

  setzen[1,1] := von; setzen[1,2] := nach;
  trial[tiefe,1] := von; trial[tiefe,2] := nach;
  z.Setzen (bh, setzen);
  merk := wurf[x]; wurf[x] := 0;        (* Zug kann nicht zweimal gesetzt werden *)
  gesetzt := TRUE;
  IF (tiefe = 4) OR ((tiefe = 2) AND NOT pasch) THEN (* Endstellung? *)
    wert := b.Bewerten (bh);
    IF (wert < opt) OR NOT optCmpl THEN  (* Bessere, oder vollständige Endstellung? *)
      ZugCp (zug, trial); opt := wert; optCmpl := TRUE
    END (* IF *)
  ELSIF NOT ZugSchwarz (wurf, tiefe+1) THEN     (* Keine Folgezüge vorhanden? *)
    IF (wert < opt) AND NOT optCmpl THEN (* Es gibt keine vollständige Lösung *)
      ZugCp (zug, trial); opt := wert
    END (* IF *)
  END; (* IF *)
  wurf[x] := merk;
  z.Zurueck (bh)

END SetzenSchwarz;

(*--------------------------------------------------------------------------------*)

BEGIN (* ZugSchwarz *)

  z.ZugLoeschen (setzen);
  gesetzt := FALSE;
  x := 1;
  WHILE x <= 4 DO       (* alle Würfe durchgehen *)
    IF wurf[x] <> 0 THEN   (* normalerweise sind wurf[3] und wurf[4] 0 *)
      IF bh.brett[str.schwarzBar] > 0 THEN  (* Ist Stein auf Bar? *)
        IF bh.brett[wurf[x]] <= 1 THEN   (* Kann Stein reingesetzt werden *)
          SetzenSchwarz (str.schwarzBar, wurf[x])
        END (* IF *)
      ELSIF b.SchwarzHeimfeld (bh.brett) = 15 THEN   (* alle Schwarzen im Heimfeld? *)
        FOR y := 19 TO 24 DO              (* alle Heimfelder durchgehen *)
          IF bh.brett[y] < 0 THEN
            IF y <= 25 - wurf[x] THEN  (* kann ins Ziel oder davor gesetzt werden? *)
              IF (bh.brett[y + wurf[x]] <= 1) OR (y + wurf[x] = str.schwarzZiel) THEN
                SetzenSchwarz (y, y + wurf[x])
              END (* IF *)
            ELSIF FreiSchwarz (bh.brett, y-1) THEN (* kann grösserer Wurf rausgesetzt werden? *)
              SetzenSchwarz (y, str.schwarzZiel)
            END (* IF *)
          END (* IF *)
        END (* FOR *)
      ELSE         (* keine Sonderregeln *)
        FOR y := 1 TO 23 DO      (* alle Felder durchgehen *)
          IF bh.brett[y] < 0 THEN
            IF y + wurf[x] <= 24 THEN    (* Zug auf Brett? *)
              IF bh.brett[y + wurf[x]] <= 1 THEN (* Zug möglich? *)
                SetzenSchwarz (y, y + wurf[x])
              END (* IF *)
            END (* IF *)
          END (* IF *)
        END (* FOR *)
      END (* IF *)
    END; (* IF *)
    IF gesetzt AND pasch THEN x := 5; (* keine neuen Konstellationen möglich *)
    ELSE INC (x)
    END (* IF *)
  END; (* WHILE *)
  RETURN gesetzt

END ZugSchwarz;

(*--------------------------------------------------------------------------------*)

BEGIN (* Berechnen *)

  z.ZugLoeschen (zug); z.ZugLoeschen (trial);
  optCmpl := FALSE; pasch := (bh.wurf[1] = bh.wurf[2]);
  IF bh.farbe = str.weiss THEN
    opt := b.Min; dummy := ZugWeiss (bh.wurf, 1)
  ELSE
    opt := b.Max; dummy := ZugSchwarz (bh.wurf, 1)
  END (* IF *)

END Berechnen;


END bgBerechnen.


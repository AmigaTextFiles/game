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
*           V2.00 - (0.0.0)
*                   * Berechnen völlig überarbeitet, man kann nun mehrere
*                     Züge voraus blicken
*                   * Böser Fehler in ZugMoeglich behoben, schwarzer menschlicher
*                     Spieler konnte nicht weisse Steine schlagen
*
*       NOTES
*
************************************************************************************
*)

IMPORT

  a   : Arts,
  io  : InOut,
  b   : bgBewerten,
  c   : bgKonvert,
  e   : ExecD,
  E   : ExecL,
  es  : ExecSupport,
  h   : Heap,
  set : bgSettings,
  y   : SYSTEM,
  z   : bgZiehen;

TYPE WurfArr = ARRAY [1..21] OF mui.Wurf;
     ZugNodePtr = POINTER TO ZugNode;
     ZugNode = RECORD
                 node     : e.MinNode;
                 len, pos : CARDINAL;
                 list     : ARRAY [0..99] OF mui.Zug
               END; (* RECORD *)

VAR trial : mui.Zug;
    wurfArr := WurfArr
    {mui.Wurf{1,1,1,1},mui.Wurf{2,2,2,2},mui.Wurf{3,3,3,3},mui.Wurf{4,4,4,4},
     mui.Wurf{5,5,5,5},mui.Wurf{6,6,6,6},mui.Wurf{1,2,0,0},mui.Wurf{1,3,0,0},
     mui.Wurf{1,4,0,0},mui.Wurf{1,5,0,0},mui.Wurf{1,6,0,0},mui.Wurf{2,3,0,0},
     mui.Wurf{2,4,0,0},mui.Wurf{2,5,0,0},mui.Wurf{2,6,0,0},mui.Wurf{3,4,0,0},
     mui.Wurf{3,5,0,0},mui.Wurf{3,6,0,0},mui.Wurf{4,5,0,0},mui.Wurf{4,6,0,0},
     mui.Wurf{5,6,0,0}};

(*--------------------------------------------------------------------------------*)

PROCEDURE FreiWeiss ( brett : mui.Brett; stop : INTEGER ) : BOOLEAN;
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

PROCEDURE FreiSchwarz ( brett : mui.Brett; stop : INTEGER ) : BOOLEAN;
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

PROCEDURE Gueltig ( brett:mui.Brett; zug:mui.Zug; farbe, wurf:INTEGER) : BOOLEAN;
(* Ist zug bei aktueller Situation möglich *)
(*$ GenDebug := FALSE *)

BEGIN (* Gueltig *)

  IF (zug[1,1] <> mui.weissZiel) AND (zug[1,1] <> mui.schwarzZiel) THEN
    IF (zug[1,2] <> mui.weissBar) AND (zug[1,2] <> mui.schwarzBar) THEN
      IF farbe = mui.weiss THEN
        IF NOT ((brett[mui.weissBar] > 0) AND (zug[1,1] <> mui.weissBar)) THEN
          IF (brett[zug[1,1]] > 0) AND (brett[zug[1,2]] >= -1) THEN
            IF (zug[1,1] <> mui.schwarzBar) AND (zug[1,2] <> mui.schwarzZiel) THEN
              IF zug[1,1] = mui.weissBar THEN
                IF (25 - wurf = zug[1,2]) THEN RETURN TRUE
                END (* IF *)
              ELSIF zug[1,2] <> mui.weissZiel THEN
                IF (zug[1,1] - wurf = zug[1,2]) THEN RETURN TRUE
                END (* IF *)
              ELSIF wurf >= zug[1,1] THEN
                IF (zug[1,1] - wurf = mui.weissZiel) THEN RETURN b.WeissHeimfeld (brett) = 15
                ELSIF FreiWeiss (brett, zug[1,1]+1) THEN RETURN b.WeissHeimfeld (brett) = 15
                END (* IF *)
              END (* IF *)
            END (* IF *)
          END (* IF *)
        END (* IF *)
      ELSE                             (* schwarzer Spieler *)
        IF NOT ((brett[mui.schwarzBar] > 0) AND (zug[1,1] <> mui.schwarzBar)) THEN
          IF (zug[1,1] <> mui.weissBar) AND (zug[1,2] <> mui.weissZiel) THEN
            IF zug[1,1] = mui.schwarzBar THEN
              IF (brett[zug[1,1]] > 0) AND (brett[zug[1,2]] <= 1) THEN
                IF wurf = zug[1,2] THEN RETURN TRUE
                END (* IF *)
              END (* IF *)
            ELSIF zug[1,2] <> mui.schwarzZiel THEN
              IF (brett[zug[1,1]] < 0) AND (brett[zug[1,2]] <= 1) THEN
                IF (zug[1,1] + wurf = zug[1,2]) THEN RETURN TRUE
                END (* IF *)
              END (* IF *)
            ELSIF brett[zug[1,1]] < 0 THEN
              ELSIF (wurf >= 25 - zug[1,1]) THEN
                IF (zug[1,1] + wurf = mui.weissZiel) THEN RETURN b.SchwarzHeimfeld (brett) = 15
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

PROCEDURE GueltigHis (bh : mui.BgHandle; zug:mui.Zug; wurf : CARDINAL):BOOLEAN;
(* Ist zug bei vorheriger Situation möglich *)

VAR result : BOOLEAN;

BEGIN (* GueltigHis *)

  z.Zurueck (bh);
  result := Gueltig (bh.brett, zug, bh.farbe, wurf);
  z.Setzen (bh, zug);
  RETURN result

END GueltigHis;

(*--------------------------------------------------------------------------------*)

PROCEDURE ZugMoeglich (bh : mui.BgHandle; history, zug : mui.Zug) : BOOLEAN;
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
    RETURN Gueltig (bh.brett, zug, bh.farbe, bh.wurf[1] )  (* es ist klar, welcher bh.wurf gesetzt wird *)
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

PROCEDURE KannWurfSetzen ( brett:mui.Brett; farbe:CARDINAL; wurf:INTEGER ):BOOLEAN;
(* Schaut, ob bh.wurf gesetzt werden kann. *)

VAR x : INTEGER;

BEGIN (* KannWurfSetzen *)

  IF farbe = mui.weiss THEN
    IF brett[mui.weissBar] > 0 THEN  (* Ist Stein auf Bar? *)
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
    IF brett[mui.schwarzBar] > 0 THEN  (* Ist Stein auf Bar? *)
      IF brett[wurf] <= 1 THEN RETURN TRUE
      END (* IF *)
    ELSIF b.SchwarzHeimfeld (brett) = 15 THEN   (* alle Schwarzen im Heimfeld? *)
      FOR x := 19 TO 24 DO              (* alle Heimfelder durchgehen *)
        IF brett[x] < 0 THEN
          IF x <= 25 - wurf THEN  (* kann ins Ziel oder davor gesetzt werden? *)
            IF (brett[x + wurf] <= 1) OR (x + wurf = mui.schwarzZiel) THEN
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

PROCEDURE ZugUebrig ( bh : mui.BgHandle; history : mui.Zug) : BOOLEAN;

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

PROCEDURE ZugCp ( VAR dest : mui.Zug; source : mui.Zug );

VAR x : CARDINAL;

BEGIN (* ZugCp *)

  FOR x := 1 TO 4 DO dest[x,1] := source[x,1]; dest[x,2] := source[x,2] END (* FOR *)

END ZugCp;

(*---------------------------------------------------------------------------*)

PROCEDURE ZugAdd (list : e.ListPtr; zug : mui.Zug);
(* Fügt Zug an Liste an                               *)

VAR node, neu : ZugNodePtr;

BEGIN (* ZugAdd *)

  IF es.IsListEmpty (list) THEN
    h.Allocate (node, SIZE (ZugNode));
    IF node <> NIL THEN
      node^.pos := 0; node^.len := 0;
      E.AddHead (list, node)
    END (* IF *)
  END; (* IF *)
  node := y.CAST (ZugNodePtr, list^.head);
  IF node^.node.succ <> NIL THEN
    WHILE node^.node.succ^.succ <> NIL DO node := y.CAST (ZugNodePtr, node^.node.succ) END;
    IF node^.len = 100 THEN
      h.Allocate (neu, SIZE (ZugNode));
      IF neu <> NIL THEN
        neu^.pos := 0; neu^.len := 1;
        neu^.list[0] := zug;
        E.AddHead (list, neu)
      END (* IF *)
    ELSE node^.list[node^.len] := zug; INC (node^.len)
    END (* IF *)
  END (* IF *)

END ZugAdd;

(*---------------------------------------------------------------------------*)

PROCEDURE ZugListeLoeschen (list : e.ListPtr);
(* Löscht Zugliste *)

VAR node, free : e.NodePtr;

BEGIN (* ZugListeLoeschen *)

  node := list^.head;
  WHILE node^.succ <> NIL DO
    free := node;
    node := node^.succ;
    h.Deallocate (free)
  END; (* WHILE *)
  es.NewList (list)

END ZugListeLoeschen;

(*---------------------------------------------------------------------------*)

PROCEDURE ZugWeiss (bh : mui.BgHandle; list : e.ListPtr; tiefe : CARDINAL; start : CARDINAL; pasch : BOOLEAN) : BOOLEAN;
(* Probiert jeden möglichen Zug aus und merkt sich den besten. *)

VAR x, x2  : INTEGER;
    gesetzt : BOOLEAN;
    setzen  : mui.Zug;

(*--------------------------------------------------------------------------------*)

PROCEDURE SetzenWeiss ( von, nach : CARDINAL );
(* Setzt Zug berechnet Folgezüge und nimmt ihn wieder zurück. *)

VAR merk : CARDINAL;

BEGIN (* SetzenWeiss *)

  setzen[1,1] := von; setzen[1,2] := nach;
  z.Setzen (bh, setzen);
  trial[tiefe,1] := von; trial[tiefe,2] := nach;
  merk := bh.wurf[x]; bh.wurf[x] := 0;        (* Zug kann nicht zweimal gesetzt werden *)
  gesetzt := TRUE;
  IF (tiefe = 4) OR ((tiefe = 2) AND NOT pasch) THEN (* Endstellung? *)
    ZugAdd (list, trial)
  ELSIF NOT ZugWeiss (bh, list, tiefe+1, start, pasch) AND es.IsListEmpty (list) THEN     (* Keine Folgezüge vorhanden? *)
    ZugAdd (list, trial)
  END; (* IF *)
  trial[tiefe,1] := 0; trial[tiefe,2] := 0;
  bh.wurf[x] := merk;
  z.Zurueck (bh)

END SetzenWeiss;

(*--------------------------------------------------------------------------------*)

BEGIN (* ZugWeiss *)

  z.ZugLoeschen (setzen);
  gesetzt := FALSE;
  x := 1;
  IF bh.brett[mui.weissBar] > 0 THEN  (* Ist Stein auf Bar? *)
    WHILE x <= 4 DO
      IF bh.wurf[x] <> 0 THEN
        IF bh.brett[25 - bh.wurf[x]] >= -1 THEN   (* Kann Stein reingesetzt werden *)
          SetzenWeiss (mui.weissBar, 25 - bh.wurf[x])
        END (* IF *)
      END; (* IF *)
      INC (x)
    END (* WHILE *)
  ELSIF b.WeissHeimfeld (bh.brett) = 15 THEN   (* alle Weissen im Heimfeld? *)
    FOR x2 := 1 TO 6 DO              (* alle Heimfelder durchgehen *)
      IF bh.brett[x2] > 0 THEN
        x := 1; gesetzt := FALSE;
        WHILE x <= 4 DO
          IF bh.wurf[x] <> 0 THEN
            IF x2 >= bh.wurf[x] THEN       (* kann ins Ziel oder davor gesetzt werden? *)
              IF bh.brett[x2 - bh.wurf[x]] >= -1 THEN
                SetzenWeiss (x2, x2 - bh.wurf[x])
              END (* IF *)
            ELSIF FreiWeiss (bh.brett, x2+1) THEN (* kann grösserer Wurf rausgesetzt werden? *)
              SetzenWeiss (x2, mui.weissZiel)
            END (* IF *)
          END; (* IF *)
          INC (x)
        END (* WHILE *)
      END (* IF *)
    END (* FOR *)
  ELSE         (* keine Sonderregeln *)
    FOR x2 := start TO 24 DO      (* alle Felder durchgehen *)
      IF bh.brett[x2] > 0 THEN
        x := 1; gesetzt := FALSE;
        WHILE x <= 4 DO
          IF bh.wurf[x] <> 0 THEN
            IF x2 - bh.wurf[x] >= 1 THEN    (* Zug auf Brett? *)
              IF bh.brett[x2 - bh.wurf[x]] >= -1 THEN (* Zug möglich? *)
                SetzenWeiss (x2, x2 - bh.wurf[x])
              END (* IF *)
            END (* IF *)
          END; (* IF *)
          IF gesetzt AND (tiefe = 1) THEN start := x2 + 1
          END; (* IF *)
          IF pasch AND (bh.wurf[x] <> 0) THEN x := 5; start := x2 + 1
          ELSE INC (x)
          END (* IF *)
        END (* WHILE *)
      END (* IF *)
    END (* FOR *)
  END; (* IF *)
  RETURN gesetzt

END ZugWeiss;

(*--------------------------------------------------------------------------------*)

PROCEDURE ZugSchwarz (bh : mui.BgHandle; list : e.ListPtr; tiefe : CARDINAL; VAR start : CARDINAL; pasch : BOOLEAN) : BOOLEAN;
(* Probiert jeden möglichen Zug aus und merkt sich den besten. *)

VAR x, x2    : INTEGER;
    gesetzt : BOOLEAN;
    setzen  : mui.Zug;

(*---------------------------------------------------------------------------*)

PROCEDURE SetzenSchwarz ( von, nach : CARDINAL );
(* Setzt Zug berechnet Folgezüge und nimmt ihn wieder zurück. *)

VAR merk : CARDINAL;

BEGIN (* SetzenSchwarz *)

  setzen[1,1] := von; setzen[1,2] := nach;
  z.Setzen (bh, setzen);
  trial[tiefe,1] := von; trial[tiefe,2] := nach;
  merk := bh.wurf[x]; bh.wurf[x] := 0;        (* Zug kann nicht zweimal gesetzt werden *)
  gesetzt := TRUE;
  IF (tiefe = 4) OR ((tiefe = 2) AND NOT pasch) THEN (* Endstellung? *)
    ZugAdd (list, trial)
  ELSIF NOT ZugSchwarz (bh, list, tiefe+1, start, pasch) AND es.IsListEmpty (list) THEN     (* Keine Folgezüge vorhanden? *)
    ZugAdd (list, trial)
  END; (* IF *)
  trial[tiefe,1] := 0; trial[tiefe,2] := 0;
  bh.wurf[x] := merk;
  z.Zurueck (bh)

END SetzenSchwarz;

(*--------------------------------------------------------------------------------*)

BEGIN (* ZugSchwarz *)

  z.ZugLoeschen (setzen);
  gesetzt := FALSE;
  x := 1;
  IF bh.brett[mui.schwarzBar] > 0 THEN  (* Ist Stein auf Bar? *)
    WHILE x <= 4 DO
      IF bh.wurf[x] <> 0 THEN
        IF bh.brett[bh.wurf[x]] <= 1 THEN   (* Kann Stein reingesetzt werden *)
          SetzenSchwarz (mui.schwarzBar, bh.wurf[x])
        END (* IF *)
      END; (* IF *)
      INC (x)
    END (* WHILE *)
  ELSIF b.SchwarzHeimfeld (bh.brett) = 15 THEN   (* alle Schwarzen im Heimfeld? *)
    FOR x2 := 19 TO 24 DO              (* alle Heimfelder durchgehen *)
      IF bh.brett[x2] < 0 THEN
        x := 1; gesetzt := FALSE;
        WHILE x <= 4 DO
          IF bh.wurf[x] <> 0 THEN
            IF x2 <= 25 - bh.wurf[x] THEN  (* kann ins Ziel oder davor gesetzt werden? *)
              IF (bh.brett[x2 + bh.wurf[x]] <= 1) OR (x2 + bh.wurf[x] = mui.schwarzZiel) THEN
                SetzenSchwarz (x2, x2 + bh.wurf[x])
              END (* IF *)
            ELSIF FreiSchwarz (bh.brett, x2-1) THEN (* kann grösserer Wurf rausgesetzt werden? *)
              SetzenSchwarz (x2, mui.schwarzZiel)
            END (* IF *)
          END; (* IF *)
          INC (x)
        END (* WHILE *)
      END (* IF *)
    END (* FOR *)
  ELSE         (* keine Sonderregeln *)
    FOR x2 := start TO 23 DO      (* alle Felder durchgehen *)
      IF bh.brett[x2] < 0 THEN
        x := 1; gesetzt := FALSE;
        WHILE x <= 4 DO
          IF bh.wurf[x] <> 0 THEN
            IF x2 + bh.wurf[x] <= 24 THEN    (* Zug auf Brett? *)
              IF bh.brett[x2 + bh.wurf[x]] <= 1 THEN (* Zug möglich? *)
                SetzenSchwarz (x2, x2 + bh.wurf[x])
              END (* IF *)
            END (* IF *)
          END; (* IF *)
          IF gesetzt AND (tiefe = 1) THEN start := x2 + 1
          END; (* IF *)
          IF pasch AND (bh.wurf[x] <> 0) THEN x := 5; start := x2 + 1
          ELSE INC (x)
          END (* IF *)
        END (* WHILE *)
      END (* IF *)
    END (* FOR *)
  END; (* IF *)
  RETURN gesetzt

END ZugSchwarz;

(*---------------------------------------------------------------------------*)

PROCEDURE ZugGenerator (bh : mui.BgHandle; list : e.ListPtr);
(* Berechnet Zugliste, für aktuellen bh.wurf *)
(* list muss initialisierte Liste sein *)

VAR x, start     : CARDINAL;
    dummy, pasch : BOOLEAN;

BEGIN (* ZugGenerator *)

  FOR x := 1 TO 4 DO
    trial[x,1] := 0;
    trial[x,2] := 0
  END; (* FOR *)
  pasch := bh.wurf[3] <> 0;
  IF bh.farbe = mui.weiss THEN
    start := 2;
    dummy := ZugWeiss (bh, list, 1, start, pasch)
  ELSE
    start := 1;
    dummy := ZugSchwarz (bh, list, 1, start, pasch)
  END (* IF *)

END ZugGenerator;

(*---------------------------------------------------------------------------*)

PROCEDURE NextZug (list : e.MinList; VAR zug : mui.Zug) : BOOLEAN;
(* Liefert zug bis ganze Liste durchlaufen wurde *)
(* Die Liste DARF NICHT leer sein *)

VAR node : ZugNodePtr;

BEGIN (* NextZug *)

  node := y.CAST (ZugNodePtr, list.head);
  WHILE node^.pos = 100 DO node := y.CAST (ZugNodePtr, node^.node.succ) END;
  IF (node^.node.succ = NIL) OR (node^.pos >= node^.len) THEN RETURN FALSE END;
  zug := node^.list[node^.pos];
  INC (node^.pos);
  RETURN TRUE

END NextZug;

(*---------------------------------------------------------------------------*)

PROCEDURE PrintZugList (list : e.MinList; mes : ARRAY OF CHAR);

VAR node   : ZugNodePtr;
    string : mui.Str;
    zug    : mui.Zug;

BEGIN

  io.WriteString ("\nZugListe: "); io.WriteString (mes);
  IF es.IsListEmpty (y.ADR (list)) THEN io.WriteString (" Ist leer") END;
  WHILE NextZug (list, zug) DO
    io.WriteLn;
    c.Zug2Str (zug, string);
    io.WriteString (string);
  END; (* WHILE *)
  node := y.CAST (ZugNodePtr, list.head);
  WHILE node^.node.succ <> NIL DO
    node^.pos := 0;
    node := y.CAST (ZugNodePtr, node^.node.succ)
  END (* WHILE *)

END PrintZugList;

(*---------------------------------------------------------------------------*)

PROCEDURE PrintZug (zug : mui.Zug; min, max : LONGINT);

VAR string : mui.Str;

BEGIN

  c.Zug2Str (zug, string);
  io.WriteString ("\nHabe gesetzt: "); io.WriteString (string);
  io.WriteString ("Min "); io.WriteInt (min, 10);
  io.WriteString (" Max "); io.WriteInt (max, 10);
  io.WriteLn

END PrintZug;

(*---------------------------------------------------------------------------*)

PROCEDURE PrintInfo (mes : ARRAY OF CHAR; tiefe, wert, alpha, beta : LONGINT);

VAR x : CARDINAL;

BEGIN

  FOR x := 0 TO tiefe DO io.WriteString ("  ") END;
  io.WriteString (mes);
  io.WriteString (" wert: "); io.WriteInt (wert,5);
  io.WriteString (" alpha: "); io.WriteInt (alpha,5);
  io.WriteString (" beta: "); io.WriteInt (beta,5);
  io.WriteLn

END PrintInfo;

(*---------------------------------------------------------------------------*)

PROCEDURE BerechnenRek (bh : mui.BgHandle; VAR zug : mui.Zug; maxTiefe, tiefe : CARDINAL;
                        alpha, beta : LONGINT) : LONGINT;
(* Rekursive Berechnung, min ist das sichere Ergebnis für weiss,
   max ist das sichere Ergebnis für schwarz *)

VAR x, maxWurf   : CARDINAL;
    wert, opt    : LONGINT;
    string       : mui.Str;
    list         : e.MinList;
    dummy, trial : mui.Zug;

BEGIN (* BerechnenRek *)

  z.ZugLoeschen (zug);
  IF tiefe = maxTiefe THEN RETURN b.Bewerten (bh)
  END; (* IF *)
  es.NewList (y.ADR (list));
  ZugGenerator (bh, y.ADR (list));
  IF NOT es.IsListEmpty (y.ADR (list)) THEN
    IF tiefe = 0 THEN maxWurf := 1
    ELSE maxWurf := 21
    END; (* IF *)
    IF (bh.farbe = mui.weiss) THEN
      (* PrintZugList (list, "Weiss"); *)
      opt := b.Min;
      WHILE NextZug (list, trial) DO
        z.Setzen (bh, trial);
        bh.farbe := mui.schwarz;
        FOR x := 1 TO maxWurf DO
          IF tiefe > 0 THEN bh.wurf := wurfArr[x] END;
          (*PrintZug (trial, alpha, beta);*)
          wert := BerechnenRek (bh, dummy, maxTiefe, tiefe+1, alpha, beta);
          (*PrintInfo ("Schwarz", tiefe+1, wert, alpha, beta);*)
          IF wert > opt THEN opt := wert; ZugCp (zug, trial)
          END; (* IF *)
          IF wert >= beta THEN
            (*io.WriteString ("\nbeta überschritten: "); io.WriteInt (wert, 10);*)
            ZugListeLoeschen (y.ADR (list)); RETURN wert
          ELSIF wert > alpha THEN alpha := wert
          END (* IF *)
        END; (* FOR *)
        bh.farbe := mui.weiss;
        z.Zurueck (bh)
      END (* WHILE *)
    ELSE
      (* PrintZugList (list, "Schwarz"); *)
      opt := b.Max;
      WHILE NextZug (list, trial) DO
        z.Setzen (bh, trial);
        bh.farbe := mui.weiss;
        FOR x := 1 TO maxWurf DO
          IF tiefe > 0 THEN bh.wurf := wurfArr[x] END; (* IF *)
          (*PrintZug (trial, alpha, beta);*)
          wert := BerechnenRek (bh, dummy, maxTiefe, tiefe+1, alpha, beta);
          (*PrintInfo ("Weiss", tiefe+1, wert, alpha, beta);*)
          IF wert < opt THEN opt := wert; ZugCp (zug, trial)
          END; (* IF *)
          IF wert <= alpha THEN
            (*io.WriteString ("\nalpha unterschritten: "); io.WriteInt (wert, 10);*)
            ZugListeLoeschen (y.ADR (list)); RETURN wert
          ELSIF wert < beta THEN beta := wert
          END (* IF *)
        END; (* FOR *)
        bh.farbe := mui.schwarz;
        z.Zurueck (bh);
      END (* WHILE *)
    END; (* IF *)
    ZugListeLoeschen (y.ADR (list))
  END; (* IF *)
  RETURN opt

END BerechnenRek;

(*---------------------------------------------------------------------------*)

PROCEDURE Berechnen (bh : mui.BgHandle; VAR zug : mui.Zug);
(****** bgBerechen/Berechnen ************************************************
*
*       NAME
*           Berechnen
*
*       SYNOPSIS
*           Berechnen ( bh, zug, tiefe )
*
*           Berechnen ( BgHandle, Zug, CARDINAL )
*
*       FUNCTION
*           Berechnet besten Zug.
*
*       INPUTS
*           bh    - Aktuelles Spielbild.
*           tiefe - Aktuelle Tiefe der Berechnung.
*
*       RESULT
*           zug       - Resultierender "bester" Zug.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR maxTiefe, alpha, beta : LONGINT;

BEGIN (* Berechnen *)

  alpha := b.Min; beta := b.Max;
  IF set.set.level <= 3 THEN maxTiefe := 1
  ELSE maxTiefe := 2
  END; (* IF *)
  alpha := BerechnenRek (bh, zug, maxTiefe, 0, alpha, beta)

END Berechnen;


END bgBerechnen.


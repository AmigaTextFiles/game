IMPLEMENTATION MODULE bgZiehen;
(****h* Backgammon/bgZiehen *************************************************
*
*       NAME
*           bgZiehen
*
*       COPYRIGHT
*           © 1995, Marc Ewert
*
*       FUNCTION
*           Fkt. zum Bewegen von Steinen auf Backgammonbrett
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

  a   : Arts,
  e   : ExecD,
  E   : ExecL,
  el  : ExecListSup,
  es  : ExecSupport,
  h   : Heap,
  mui : bgMui,
  y   : SYSTEM;

(*--------------------------------------------------------------------------------*)

CONST historyMax = 2000;

TYPE HistoryArrPtr = POINTER TO HistoryArr;
     HistoryArr = ARRAY [1..historyMax] OF mui.BgHandle;

VAR history : HistoryArrPtr;

(*--------------------------------------------------------------------------------*)

PROCEDURE ZugLoeschen ( VAR zug : mui.Zug );
(****** bgZiehen/ZugLoeschen ************************************************
*
*       NAME
*           ZugLoeschen
*
*       SYNOPSIS
*           ZugLoeschen ( zug )
*
*           ZugLoeschen ( Zug )
*
*       FUNCTION
*           Setzt Zug auf Null.
*
*       INPUTS
*           zug - Zug.
*
*       RESULT
*           zug - Auf Null gesetzt.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR x : CARDINAL;

BEGIN (* ZugLoeschen *)

  FOR x := 1 TO 4 DO
    zug[x,1] := 0; zug[x,2] := 0
  END (* FOR *)

END ZugLoeschen;

(*--------------------------------------------------------------------------------*)

PROCEDURE Setzen ( VAR bh : mui.BgHandle; zug : mui.Zug);
(****** bgZiehen/Setzen ************************************************
*
*       NAME
*           Setzen
*
*       SYNOPSIS
*           Setzen ( bh, zug )
*
*           Setzen ( BgHandle, Zug )
*
*       FUNCTION
*           Bewegt Stein auf BGBrett.
*
*       INPUTS
*           bh  - Aktuelle Stellung.
*           zug - Zu machender Zug.
*
*       RESULT
*           bh - Erhaltende Stellung.
*
*       NOTES
*           Die vorherige Stellung wird gemerkt und kann mit Zurueck
*           wieder hergestellt werden.
*
*       SEE ALSO
*           Zurueck
*
************************************************************************************
*)

VAR x         : CARDINAL;
    von, nach : INTEGER;

BEGIN (* Setzen *)

  IF historyPos = historyMax THEN a.Error (y.ADR ("History Überlauf"), NIL) END;
  history^[historyPos] :=  bh;
  INC (historyPos);
  x := 1;
  WHILE x <= 4 DO
    von := zug[x,1]; nach := zug[x,2];
    IF (von = 0) AND (nach = 0) THEN x := 5   (* es kommt kein Zug mehr *)
    ELSIF bh.farbe = mui.schwarz THEN
      IF (von = mui.schwarzBar) OR (von = mui.schwarzZiel) THEN
        DEC (bh.brett[von])
      ELSE INC (bh.brett[von])
      END; (* IF *)
      IF (nach = mui.schwarzBar) OR (nach = mui.schwarzZiel) THEN
        INC (bh.brett[nach])
      ELSIF bh.brett[nach] = 1 THEN  (* Schlagzug? *)
        INC (bh.brett[mui.weissBar]);
        bh.brett[nach] := -1
      ELSE DEC (bh.brett[nach])
      END (* IF *)
    ELSE
      DEC (bh.brett[von]);
      IF bh.brett[nach] = -1 THEN   (* Schlagzug? *)
        INC (bh.brett[mui.schwarzBar]);
        bh.brett[nach] := 1
      ELSE INC (bh.brett[nach])
      END (* IF *)
    END; (* IF *)
    INC ( x)
  END (* WHILE *)

END Setzen;

(*--------------------------------------------------------------------------------*)

PROCEDURE Zurueck ( VAR bh : mui.BgHandle  );
(****** bgZiehen/Zurueck ************************************************
*
*       NAME
*           Zurueck
*
*       SYNOPSIS
*           Zurueck ( bh )
*
*           Zurueck ( Bh )
*
*       FUNCTION
*           Nimmt letzten Zug zurück.
*
*       INPUTS
*           bh - Momentane Stellung.
*
*       RESULT
*           bh - Vorherige Stellung.
*
*       NOTES
*
*       SEE ALSO
*           Setzen
*
************************************************************************************
*)

BEGIN (* Zurueck *)

  IF historyPos > 1 THEN
    DEC (historyPos);
    bh := history^[historyPos]
  END (* IF *)

END Zurueck;

(*--------------------------------------------------------------------------------*)

BEGIN (* bgZiehen *)

  h.Allocate (history, SIZE (HistoryArr));
  IF history = NIL THEN a.Error (y.ADR ("Nicht genügend Speicher"), NIL) END;
  historyPos := 1;

CLOSE

  h.Deallocate (history)

END bgZiehen.


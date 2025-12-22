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
  str : bgStrukturen,
  y   : SYSTEM;

(*--------------------------------------------------------------------------------*)

CONST historyMax = 2000;

TYPE HistoryArrPtr = POINTER TO HistoryArr;
     HistoryArr = ARRAY [1..historyMax] OF str.BgHandle;

VAR history : HistoryArrPtr;

(*--------------------------------------------------------------------------------*)

PROCEDURE CopyBrett ( VAR dest : str.Brett; source : str.Brett );
(* Kopiert Brett source nach Brett dest.                       *)

VAR i : CARDINAL;

BEGIN (* CopyBrett *)

  FOR i := 0 TO str.maxFeld DO
    dest[i] := source[i]
  END (* FOR *)

END CopyBrett;

(*--------------------------------------------------------------------------------*)

PROCEDURE CopyBgHandle (VAR dest : str.BgHandle; source : str.BgHandle);

VAR i : CARDINAL;

BEGIN (* CopyBgHandle *)

  WITH dest DO
    CopyBrett (brett, source.brett);
    tiefe := source.tiefe;
    farbe := source.farbe;
    typ := source.typ;
    FOR i := 1 TO 4 DO wurf[i] := source.wurf[i]
    END (* FOR *)
  END (* WITH *)

END CopyBgHandle;

(*--------------------------------------------------------------------------------*)

PROCEDURE ZugLoeschen ( VAR zug : str.Zug );
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

PROCEDURE Setzen ( VAR bh : str.BgHandle; zug : str.Zug);
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
  CopyBgHandle (history^[historyPos], bh);
  INC (historyPos);
  x := 1;
  WHILE x <= 4 DO
    von := zug[x,1]; nach := zug[x,2];
    IF (von = 0) AND (nach = 0) THEN x := 5   (* es kommt kein Zug mehr *)
    ELSIF bh.farbe = str.schwarz THEN
      IF (von = str.schwarzBar) OR (von = str.schwarzZiel) THEN
        DEC (bh.brett[von])
      ELSE INC (bh.brett[von])
      END; (* IF *)
      IF (nach = str.schwarzBar) OR (nach = str.schwarzZiel) THEN
        INC (bh.brett[nach])
      ELSIF bh.brett[nach] = 1 THEN  (* Schlagzug? *)
        INC (bh.brett[str.weissBar]);
        bh.brett[nach] := -1
      ELSE DEC (bh.brett[nach])
      END (* IF *)
    ELSE
      DEC (bh.brett[von]);
      IF bh.brett[nach] = -1 THEN   (* Schlagzug? *)
        INC (bh.brett[str.schwarzBar]);
        bh.brett[nach] := 1
      ELSE INC (bh.brett[nach])
      END (* IF *)
    END; (* IF *)
    INC ( x)
  END (* WHILE *)

END Setzen;

(*--------------------------------------------------------------------------------*)

PROCEDURE Zurueck ( VAR bh : str.BgHandle  );
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
    CopyBgHandle (bh, history^[historyPos] )
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


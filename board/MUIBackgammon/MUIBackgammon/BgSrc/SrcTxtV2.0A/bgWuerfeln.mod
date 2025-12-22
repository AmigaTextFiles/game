IMPLEMENTATION MODULE bgWuerfeln;
(****h* Backgammon/bgWuerfeln *************************************************
*
*       NAME
*           bgWuerfeln
*
*       COPYRIGHT
*           © 1995, Marc Ewert
*
*       FUNCTION
*           Fkt. zum Würfeln mit zwei Würfeln
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

(*  io  : InOut,*)
  I   : IntuitionL,
  mui : bgMui,
  r   : RandomNumber,
  y   : SYSTEM;

(*--------------------------------------------------------------------------------*)

PROCEDURE CopyWurf (VAR dest : mui.Wurf; source : mui.Wurf);
(****** bgWuerfeln/CopyWurf ************************************************
*
*       NAME
*           CopyWurf
*
*       SYNOPSIS
*           CopyWurf ( dest, source )
*
*           CopyWurf ( Wurf, Wurf )
*
*       FUNCTION
*           Kopiert Wurf source nach dest.
*
*       INPUTS
*           source - Zu kopierender Wurf.
*
*       RESULT
*           dest - Kopie von source.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR x : CARDINAL;

BEGIN (* CopyWurf *)

  FOR x := 1 TO 4 DO dest[x] := source[x] END (* FOR *)

END CopyWurf;

(*--------------------------------------------------------------------------------*)

PROCEDURE Wuerfeln ( VAR wurf : mui.Wurf );
(****** bgWuerfeln/Wuerfeln ************************************************
*
*       NAME
*           Wuerfeln
*
*       SYNOPSIS
*           Wuefeln ( wurf )
*
*           Wuerfeln ( Wurf )
*
*       FUNCTION
*           Würfelt zwei Würfel und gibt das Ergebnis zurück.
*
*       INPUTS
*
*       RESULT
*           wurf - Ergebnis. (kein Pasch => wurf[3/4] = 0)
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

BEGIN (* Wuerfeln *)

  wurf[1] := r.RND (6) + 1;
  wurf[2] := r.RND (6) + 1;
(*  io.WriteString ("Erster Würfel: "); io.ReadInt (wurf[1]);*)
(*  io.WriteString ("Zweiter Würfel: "); io.ReadInt (wurf[2]);*)
  IF wurf[1] = wurf[2] THEN wurf[3] := wurf[1]; wurf[4] := wurf[1]
  ELSE wurf[3] := 0; wurf[4] := 0
  END (* IF *)

END Wuerfeln;

(*--------------------------------------------------------------------------------*)

VAR secs, micros : LONGINT;

(*--------------------------------------------------------------------------------*)

BEGIN (* bgWuerfeln *)

  I.CurrentTime (y.ADR (secs), y.ADR (micros));
  r.PutSeed (micros)

END bgWuerfeln.


IMPLEMENTATION MODULE bgInit;
(****h* Backgammon/bgInit *************************************************
*
*       NAME
*           bgInit
*
*       COPYRIGHT
*           © 1995, Marc Ewert
*
*       FUNCTION
*           Stellt Funktion zur Initialisierung des Backgammonbrettes zur Verfügung.
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

  MC  : MuiClasses,
  MD  : MuiD,
  MM  : MuiMacros,
  MS  : MuiSupport,
  mui : bgMui,
  set : bgSettings,
  str : bgStrukturen,
  y   : SYSTEM,
  z   : bgZiehen;

(*--------------------------------------------------------------------------------*)

PROCEDURE Init ();
(****** bgInit/Init ************************************************
*
*       NAME
*           Init
*
*       SYNOPSIS
*           Init ()
*
*       FUNCTION
*           Initialisiert die Einstellungen von MUIBackgammon
*           ( das Spielbrett ausgenommen )
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR farbe1, farbe2 : CARDINAL;
    buffer         : ARRAY [0..1] OF LONGINT;

BEGIN (* Init *)

  (* AI Configuration *)
  FOR farbe1 := 1 TO 2 DO
    FOR  farbe2 := 1 TO 2 DO
      MM.set (mui.kiSlider[farbe1,farbe2,set.bar], MD.maNumericValue, 35);
      MM.set (mui.kiSlider[farbe1,farbe2,set.single], MD.maNumericValue, 40);
      MM.set (mui.kiSlider[farbe1,farbe2,set.singleProb], MD.maNumericValue, 80);
      MM.set (mui.kiSlider[farbe1,farbe2,set.distribution], MD.maNumericValue, 3);
      MM.set (mui.kiSlider[farbe1,farbe2,set.distance], MD.maNumericValue, 20);
      MM.set (mui.kiSlider[farbe1,farbe2,set.six], MD.maNumericValue, 28);
      MM.set (mui.kiSlider[farbe1,farbe2,set.block], MD.maNumericValue, 35);
      MM.set (mui.kiSlider[farbe1,farbe2,set.target], MD.maNumericValue, 22);
      MM.set (mui.kiSlider[farbe1,farbe2,set.home], MD.maNumericValue, 32);
    END (* FOR *)
  END; (* FOR *)

  (* Board *)
  MM.set (mui.bgObj[0], MD.maCycleActive, 0);
  MM.set (mui.bgObj[1], MD.maCycleActive, 1);
  MM.set (mui.bgObj[2], MD.maCycleActive, 0);
  MM.set (mui.bgObj[3], MD.maNumericValue, 3);
  MM.set (mui.bgObj[4], MD.maNumericValue, 2);
  MM.set (mui.bgObj[5], MD.maNumericValue, 20);
  MM.set (mui.bgObj[6], MD.maNumericValue, 0);
  MS.DoMethod (mui.bgObj[14], y.TAG (buffer, MD.mmPendisplaySetMUIPen, MC.mpenShine));
  MS.DoMethod (mui.bgObj[15], y.TAG (buffer, MD.mmPendisplaySetMUIPen, MC.mpenShadow));
  MS.DoMethod (mui.bgObj[16], y.TAG (buffer, MD.mmPendisplaySetMUIPen, MC.mpenShine));
  MS.DoMethod (mui.bgObj[17], y.TAG (buffer, MD.mmPendisplaySetMUIPen, MC.mpenShadow));

  (* Menü *)
  MM.set (mui.itemIcons, MD.maMenuitemChecked, LONGCARD (FALSE))

END Init;

(*---------------------------------------------------------------------------*)

PROCEDURE InitBrett (VAR brett : str.Brett);
(****** bgInit/InitBrett ************************************************
*
*       NAME
*           InitBrett
*
*       SYNOPSIS
*           InitBrett ( brett )
*
*           InitBrett ( Brett )
*
*       FUNCTION
*           Versetzt Backgammonbrett in Ausgangszustand.
*
*       INPUTS
*           brett - Zu veränderndes Brett
*
*       RESULT
*           brett - Brett ist im Ausgangszustand.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR i : CARDINAL;

BEGIN (* InitBrett *)

  z.historyPos := 1;             (* vorherige Züge vergessen *)
  FOR i := 0 TO 27 DO            (* gesamtes Brett löschen *)
    brett[i] := 0
  END; (* FOR *)
  brett[1] := -2;
  brett[6] := 5;
  brett[8] := 3;
  brett[12] := -5;
  brett[13] := 5;
  brett[17] := -3;
  brett[19] := -5;
  brett[24] := 2;
  mui.Show (brett)

END InitBrett;

BEGIN (* Init *)

  Init ()

END bgInit.


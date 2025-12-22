IMPLEMENTATION MODULE bgMui;
(****h* Backgammon/bgMui *************************************************
*
*       NAME
*           bgMui
*
*       COPYRIGHT
*           © 1995, Marc Ewert
*
*       FUNCTION
*           Muioberfläche für Backgammon.
*
*       AUTHOR
*           Marc Ewert
*
*       CREATION DATE
*           21.07.95
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
  b   : bgBar,
  D   : DosL,
  e   : ExecD,
  E   : ExecL,
  g   : GraphicsD,
  G   : GraphicsL,
  gt  : GadToolsD,
  GM  : GfxMacros,
  h   : Heap,
  ho  : bgHome,
  i   : IntuitionD,
  I   : IntuitionL,
  l   : bgLocale,
  MC  : MuiClasses,
  MD  : MuiD,
  ML  : MuiL,
  MM  : MuiMacros,
  MS  : MuiSupport,
  ms  : MuiSup,
  pl  : prefsLocale,
  u   : UtilityD,
  U   : UtilityL,
  s   : String,
  set : bgSettings,
  str : bgStrukturen,
  t   : bgTriangle,
  y   : SYSTEM,
  zi  : bgZiehen;

(*--------------------------------------------------------------------------------*)

TYPE AAPTR = POINTER TO MD.APTR;
TYPE LongBrett = ARRAY [0..27] OF LONGINT;

VAR buffer, buffer2, buffer3, buffer4 : ARRAY[0..50] OF LONGINT;
    weissZiel, schwarzZiel            : MD.APTR;
    whiteBrett                        :=LongBrett{0,..};
    blackBrett                        :=LongBrett{0,..};

(*--------------------------------------------------------------------------------*)

PROCEDURE Show ( board : str.Brett );
(*/// "Show" *)
(****** bgMui/Show ************************************************
*
*       NAME
*           Show
*
*       SYNOPSIS
*           Show ( board )
*
*           Show ( Brett )
*
*       FUNCTION
*           Stellt Darstellung auf Brett ein.
*
*       INPUTS
*           board - Interne Brettdarstellung.
*
*       RESULT
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR x            : CARDINAL;
    white, black : y.ADDRESS;

BEGIN (* Show *)

  (* alles nullen *)
  MS.DoMethod (app, y.TAG (buffer, MD.mmMultiSet, t.trWhite, 0,
               brett[13], brett[14], brett[15], brett[16], brett[17], brett[18],
               brett[19], brett[20], brett[21], brett[22], brett[23], brett[24],
               brett[12], brett[11], brett[10], brett[9], brett[8], brett[7],
               brett[6], brett[5], brett[4], brett[3], brett[2], brett[1], u.tagEnd));
  MS.DoMethod (app, y.TAG (buffer, MD.mmMultiSet, t.trBlack, 0,
               brett[13], brett[14], brett[15], brett[16], brett[17], brett[18],
               brett[19], brett[20], brett[21], brett[22], brett[23], brett[24],
               brett[12], brett[11], brett[10], brett[9], brett[8], brett[7],
               brett[6], brett[5], brett[4], brett[3], brett[2], brett[1], u.tagEnd));
  MS.DoMethod (app, y.TAG (buffer, MD.mmMultiSet, b.brStones, 0,
               brett[26], brett[27], u.tagEnd));
  MS.DoMethod (app, y.TAG (buffer, MD.mmMultiSet, ho.hoStones, 0,
               brett[0], brett[25], u.tagEnd));
  MM.get (bgObj[14], MD.maPendisplaySpec, y.ADR (white));
  MM.get (bgObj[15], MD.maPendisplaySpec, y.ADR (black));
  FOR x := 1 TO 24 DO   (* Triangles besetzen *)
    IF board[x] > 0 THEN
      MM.set (brett[x], t.trStonePen, white);
      MM.set (brett[x], t.trWhite, board[x])
    ELSIF board[x] < 0 THEN
      MM.set (brett[x], t.trStonePen, black);
      MM.set (brett[x], t.trBlack, ABS (board[x]))
    END (* IF *)
  END; (* FOR *)
  IF board[0] > 0 THEN MM.set (brett[0], ho.hoStones, board[0]) END;
  IF board[25] > 0 THEN MM.set (brett[25], ho.hoStones, board[25]) END;
  FOR x := 26 TO 27 DO
    IF board[x] > 0 THEN MM.set (brett[x], b.brStones, board[x])
    END (* IF *)
  END (* FOR *)

END Show;
(*///*)
(*--------------------------------------------------------------------------------*)

PROCEDURE Setzen (VAR bh : str.BgHandle; zug : str.Zug; loop : CARDINAL);
(*/// "Setzen" *)
(****** bgMui/Setzen ************************************************
*
*       NAME
*           Setzen
*
*       SYNOPSIS
*           Setzen ( bh, zug, loop )
*
*           Setzen ( BgHandle, Zug, CARDINAL )
*
*       FUNCTION
*           Stellt Zug grafisch da, und setzt ihn dann auch intern.
*
*       INPUTS
*           bh    - Spielzustand.
*           zug   - Darzustellender Zug.
*           loop  - Stein blinkt loop mal.
*
*       RESULT
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

(*--------------------------------------------------------------------------------*)

PROCEDURE Blinke (obj : MD.APTR; tag : LONGCARD; wert, loop : CARDINAL;
                  really, weg : BOOLEAN                                );
(* blinkender Stein *)

VAR x, start : CARDINAL;

BEGIN (* Blinke *)

  MM.set (obj, tag, wert);
  IF NOT really THEN loop := 0 END; (* IF *)
  IF weg THEN start := 1 ELSE start := 2 END; (* IF *)
  FOR x := start TO loop DO
    MS.DoMethod (app, y.TAG (buffer, MD.mmApplicationInputBuffered));
    D.Delay (set.set.blinkTime);
    IF weg THEN MM.set (obj, tag, wert + 1)
    ELSE MM.set (obj, tag, wert - 1)
    END; (* IF *)
    D.Delay (set.set.blinkTime);
    MM.set (obj, tag, wert);
  END; (* FOR *)
  IF loop > 0 THEN D.Delay (set.set.blinkTime) END; (* IF *)

END Blinke;

(*--------------------------------------------------------------------------------*)

VAR x, j, z, tiefe                : CARDINAL;
    hilfZug                       : str.Zug;
    schlagZug, loopFlag, computer : BOOLEAN;
    whiteStones, blackStones, whiteField, blackField : y.ADDRESS;

BEGIN (* Setzen *)

  MM.get (bgObj[14], MD.maPendisplaySpec, y.ADR(whiteStones));
  MM.get (bgObj[15], MD.maPendisplaySpec, y.ADR(blackStones));
  MM.get (bgObj[16], MD.maPendisplaySpec, y.ADR(whiteField));
  MM.get (bgObj[17], MD.maPendisplaySpec, y.ADR(blackField));
  x := 1; z := 100;         (* für vergleich: start = altes ziel *)
  zi.ZugLoeschen (hilfZug);
  computer := (zug[2,1] <> 0) OR (zug[2,2] <> 0);
  IF (zug[4,1] <> 0) OR (zug[4,2] <> 0) THEN tiefe := 4
  ELSIF (zug[3,1] <> 0) OR (zug[3,2] <> 0) THEN tiefe := 3
  ELSIF (zug[2,1] <> 0) OR (zug[2,2] <> 0) THEN tiefe := 2
  ELSE tiefe := 1
  END; (* IF *)
  WHILE (x <=4 ) DO
    IF (zug[x,1] = 0) AND (zug[x,2] = 0) THEN x := 5   (* Endmarkierung *)
    ELSE
      hilfZug[1,1] := zug[x,1]; hilfZug[1,2] := zug[x,2];
      loopFlag := CARDINAL (hilfZug[1,1]) <> z; (* damit nicht zweimal geblinkt wird *)
      z := zug[x,2];
      IF bh.farbe = str.weiss THEN schlagZug := bh.brett[z] < 0
      ELSE schlagZug := (bh.brett[z] > 0) AND (z <> str.schwarzBar) AND (z <> str.schwarzZiel)
      END; (* IF *)
      IF bh.typ = str.computer THEN     (* tiefe manuell setzen *)
        bh.tiefe := x
      END; (* IF *)
      zi.Setzen (bh, hilfZug);
      ms.WriteTextInt (weissZiel, bh.brett[str.weissZiel]);
      ms.WriteTextInt (schwarzZiel, bh.brett[str.schwarzZiel]);
      FOR j := 1 TO 2 DO
        z := zug [x,j];
        IF (z < 25) AND (z > 0) THEN  (* normales Feld *)
          IF bh.farbe = str.weiss THEN
            MM.set (brett[z], t.trBlack, 0);
            MM.set (brett[z], t.trStonePen, whiteStones);
            Blinke (brett[z], t.trWhite, bh.brett[z], loop, loopFlag, j = 1);
            IF schlagZug AND (j = 2) THEN
              Blinke (brett[str.schwarzBar], b.brStones, bh.brett[str.schwarzBar], loop, TRUE, FALSE)
            END (* IF *)
          ELSE                          (* schwarze Steine *)
            MM.set (brett[z], t.trStonePen, blackStones);
            MM.set (brett[z], t.trWhite, 0);
            Blinke (brett[z], t.trBlack, ABS (bh.brett[z]), loop, loopFlag, j = 1);
            IF schlagZug AND (j = 2) THEN
              Blinke (brett[str.weissBar], b.brStones, bh.brett[str.weissBar], loop, TRUE, FALSE)
            END (* IF *)
          END (* IF *)
        ELSIF (z = 0) OR (z = 25) THEN
          Blinke (brett[z], b.brStones, bh.brett[z], loop, TRUE, j = 1)
        ELSE
          Blinke (brett[z], ho.hoStones, bh.brett[z], loop, TRUE, j = 1)
        END; (* IF *)
        loopFlag := TRUE
      END; (* FOR *)
      IF computer THEN ms.WriteTextInt (moves, tiefe - x)
      END (* IF *)
    END; (* IF *)
    INC (x)
  END (* WHILE *)

END Setzen;
(*///*)
(*--------------------------------------------------------------------------------*)

PROCEDURE AddText ( str : y.ADDRESS );
(* ///  "AddText" *)
(****** bgMui/AddText ************************************************
*
*       NAME
*           AddText
*
*       SYNOPSIS
*           AddText ( str )
*
*           AddText ( ADDRESS )
*
*       FUNCTION
*           Stellt Text auf Backgammonbrett dar.
*
*       INPUTS
*           str - Auszugebender Text.
*
*       RESULT
*
*       NOTES
*           Momentan wird ein Listview benutzt, um auch vorherige Texte sehen
*           zu können.
*
*       SEE ALSO
*
************************************************************************************
*)

VAR len : LONGINT;

BEGIN (* AddText *)

  MM.get (text, MD.maListEntries, y.ADR (len));
  IF len > 100 THEN
    MS.DoMethod (text, y.TAG (buffer, MD.mmListRemove, MD.mvListRemoveFirst))
  END; (* IF *)
  MS.DoMethod (text, y.TAG (buffer, MD.mmListInsertSingle, str, MD.mvListInsertBottom));
  MM.set (text, MD.maListActive, MD.mvListActiveBottom)

END AddText;
(*///*)
(*--------------------------------------------------------------------------------*)

VAR modusArr                                     := MM.STRARR{NIL,..};
    playerArr                                    := MM.STRARR{NIL,..};
    traceArr                                     := MM.STRARR{NIL,..};
    boardGrp, board, prevOn, prevWin, strip      : MD.APTR;
    wKiSave, wKiLoad, kiWhiteGrp, kiBlackGrp     : MD.APTR;
    wLCopy, wRCopy, bLCopy, bRCopy, bKiSave, bKiLoad : MD.APTR;
    x, z, farbe1, farbe2                         : CARDINAL;
    elem                                         : set.KiElem;
    kiRegTitles, textSource                      : MM.STRARR;
    copySliderHook, loadKiHook, saveKiHook       : u.HookPtr;
    boardHook                                    : u.HookPtr;

(*--------------------------------------------------------------------------------*)

PROCEDURE CopySliderGroup (hook : u.HookPtr; obj, param : y.ADDRESS) : MD.APTR;
(*/// "CopySliderGroup" *)
TYPE INTPTR = POINTER TO LONGINT;

VAR level, farbe, seite  : LONGINT;

BEGIN (* CopySliderGroup *)

  IF param <> NIL THEN
    farbe := y.CAST (INTPTR, param)^;
    seite := y.CAST (INTPTR, param + 4)^;
    FOR elem := MIN (set.KiElem) TO MAX (set.KiElem) DO
      MM.get (kiSlider[farbe,seite,elem], MD.maNumericValue, y.ADR (level));
      MM.set (kiSlider[farbe,3-seite,elem], MD.maNumericValue, level);
    END (* FOR *)
  END; (* IF *)
  RETURN 0

END CopySliderGroup;
(*///*)

(*--------------------------------------------------------------------------------*)

PROCEDURE CreateBoard (boardType : LONGINT) : MD.APTR;
(* Generiert Backgammonbrett entsprechend boardType *)
(*/// "CreateBoard"*)
VAR buffer, buffer2 : ARRAY [0..30] OF LONGINT;
    kopf            : BOOLEAN;
    x               : CARDINAL;
    tag             : y.ADDRESS;
    whiteStones, blackStones, whiteField, blackField : y.ADDRESS;

BEGIN (* CreateBoard *)

  brett[0] := I.NewObjectA (ho.HomeClass, NIL, y.TAG(buffer, MD.maInputMode, MD.mvInputModeRelVerify,
                            ho.hoStones, whiteBrett[0], ho.hoBottom, kopf, u.tagDone));
  FOR x := 1 TO 24 DO
    IF x <= 12 THEN kopf := (boardType=0) OR (boardType=1)
    ELSE kopf := (boardType<>0) AND (boardType<>1)
    END; (* IF *)
    tag := y.TAG (buffer, MD.maInputMode, MD.mvInputModeRelVerify, t.trBottom, kopf, t.trBlack, blackBrett[x], t.trWhite, whiteBrett[x], u.tagDone);
    brett[x] := I.NewObjectA (t.TriangleClass, NIL, tag)
  END; (* FOR *)
  brett[25] := I.NewObjectA (ho.HomeClass, NIL, y.TAG(buffer, MD.maInputMode, MD.mvInputModeRelVerify,
                             ho.hoStones, whiteBrett[25], ho.hoBottom, NOT kopf, u.tagDone));
  brett[26] := I.NewObjectA (b.BarClass, NIL, y.TAG(buffer, MD.maInputMode, MD.mvInputModeRelVerify,
                             b.brBottom, kopf, b.brStones, whiteBrett[26], u.tagDone));
  brett[27] := I.NewObjectA (b.BarClass, NIL, y.TAG (buffer, MD.maInputMode, MD.mvInputModeRelVerify,
                             b.brBottom, NOT kopf, b.brStones, whiteBrett[27], u.tagDone));

  IF (bgObj[14]#NIL) AND (bgObj[15]#NIL) AND (bgObj[16]#NIL) AND (bgObj[17]#NIL) THEN
    MM.get (bgObj[14], MD.maPendisplaySpec, y.ADR(whiteStones));
    MM.get (bgObj[15], MD.maPendisplaySpec, y.ADR(blackStones));
    MM.get (bgObj[16], MD.maPendisplaySpec, y.ADR(whiteField));
    MM.get (bgObj[17], MD.maPendisplaySpec, y.ADR(blackField));
  END; (* IF *)
  IF (brett[26]#NIL) AND (brett[27]#NIL) AND (brett[0]#NIL) AND (brett[25]#NIL) THEN
    MM.set (brett[26], b.brStonePen, whiteStones);
    MM.set (brett[26], b.brPen, blackField);
    MM.set (brett[27], b.brStonePen, blackStones);
    MM.set (brett[27], b.brPen, whiteField);
    MM.set (brett[0], ho.hoStonePen, whiteStones);
    MM.set (brett[0], ho.hoPen, blackField);
    MM.set (brett[25], ho.hoStonePen, blackStones);
    MM.set (brett[25], ho.hoPen, whiteField)
  END; (* IF *)
  FOR x := 1 TO 24 DO
    IF ODD (x) AND (brett[x]#NIL) THEN MM.set (brett[x], t.trPen, whiteField)
    ELSIF brett[x]#NIL THEN  MM.set (brett[x], t.trPen, blackField)
    END (* IF *)
  END; (* FOR *)

  CASE boardType OF
    0: RETURN MM.HGroup (y.TAG (buffer,
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[13], MM.Child, brett[14],
                            MM.Child, brett[15], MM.Child, brett[16],
                            MM.Child, brett[17], MM.Child, brett[18],
                            MM.Child, brett[12], MM.Child, brett[11],
                            MM.Child, brett[10], MM.Child, brett[9],
                            MM.Child, brett[8], MM.Child, brett[7],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[26], MM.Child, brett[27],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[19], MM.Child, brett[20],
                            MM.Child, brett[21], MM.Child, brett[22],
                            MM.Child, brett[23], MM.Child, brett[24],
                            MM.Child, brett[6], MM.Child, brett[5],
                            MM.Child, brett[4], MM.Child, brett[3],
                            MM.Child, brett[2], MM.Child, brett[1],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[25], MM.Child, brett[0],
                          u.tagEnd)),
              u.tagEnd))
    | 1: RETURN MM.HGroup (y.TAG (buffer,
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[25], MM.Child, brett[0],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[24], MM.Child, brett[23],
                            MM.Child, brett[22], MM.Child, brett[21],
                            MM.Child, brett[20], MM.Child, brett[19],
                            MM.Child, brett[1], MM.Child, brett[2],
                            MM.Child, brett[3], MM.Child, brett[4],
                            MM.Child, brett[5], MM.Child, brett[6],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[26], MM.Child, brett[27],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[18], MM.Child, brett[17],
                            MM.Child, brett[16], MM.Child, brett[15],
                            MM.Child, brett[14], MM.Child, brett[13],
                            MM.Child, brett[7], MM.Child, brett[8],
                            MM.Child, brett[9], MM.Child, brett[10],
                            MM.Child, brett[11], MM.Child, brett[12],
                          u.tagEnd)),
              u.tagEnd))
    | 2: RETURN MM.HGroup (y.TAG (buffer,
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[12], MM.Child, brett[11],
                            MM.Child, brett[10], MM.Child, brett[9],
                            MM.Child, brett[8], MM.Child, brett[7],
                            MM.Child, brett[13], MM.Child, brett[14],
                            MM.Child, brett[15], MM.Child, brett[16],
                            MM.Child, brett[17], MM.Child, brett[18],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[27], MM.Child, brett[26],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[6], MM.Child, brett[5],
                            MM.Child, brett[4], MM.Child, brett[3],
                            MM.Child, brett[2], MM.Child, brett[1],
                            MM.Child, brett[19], MM.Child, brett[20],
                            MM.Child, brett[21], MM.Child, brett[22],
                            MM.Child, brett[23], MM.Child, brett[24],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[0], MM.Child, brett[25],
                          u.tagEnd)),
              u.tagEnd))
    | 3: RETURN MM.HGroup (y.TAG (buffer,
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[0], MM.Child, brett[25],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[1], MM.Child, brett[2],
                            MM.Child, brett[3], MM.Child, brett[4],
                            MM.Child, brett[5], MM.Child, brett[6],
                            MM.Child, brett[24], MM.Child, brett[23],
                            MM.Child, brett[22], MM.Child, brett[21],
                            MM.Child, brett[20], MM.Child, brett[19],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[27], MM.Child, brett[26],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, brett[7], MM.Child, brett[8],
                            MM.Child, brett[9], MM.Child, brett[10],
                            MM.Child, brett[11], MM.Child, brett[12],
                            MM.Child, brett[18], MM.Child, brett[17],
                            MM.Child, brett[16], MM.Child, brett[15],
                            MM.Child, brett[14], MM.Child, brett[13],
                          u.tagEnd)),
              u.tagEnd))
  END (* CASE *)

END CreateBoard;
(*///*)

(*---------------------------------------------------------------------------*)

PROCEDURE ChangeBoardHook (hook : u.HookPtr; obj, param : y.ADDRESS) : MD.APTR;
(*/// "ChangeBoardHook"*)
TYPE INTPTR = POINTER TO LONGINT;

VAR boardType, x    : LONGINT;
    newBoard, dummy : MD.APTR;
    whiteStones, blackStones : y.ADDRESS;

BEGIN (* ChangeBoardHook *)

  IF param <> NIL THEN
    FOR x := 1 TO 24 DO
      MM.get (brett[x], t.trBlack, y.ADR (blackBrett[x]));
      MM.get (brett[x], t.trWhite, y.ADR (whiteBrett[x]));
    END; (* FOR *)
    MM.get (brett[0], ho.hoStones, y.ADR (whiteBrett[0]));
    MM.get (brett[25], ho.hoStones, y.ADR (whiteBrett[25]));
    MM.get (brett[26], b.brStones, y.ADR (whiteBrett[26]));
    MM.get (brett[27], b.brStones, y.ADR (whiteBrett[27]));
    boardType := y.CAST (INTPTR, param)^;
    newBoard := CreateBoard (boardType);
    IF newBoard <> NIL THEN
      IF MS.DOMethod (boardGrp, y.TAG (buffer, MD.mmGroupInitChange)) <> 0 THEN
        MM.RemMember (boardGrp, board);
        ML.mDisposeObject (board);
        board := newBoard;
        MM.get (bgObj[14], MD.maPendisplaySpec, y.ADR (whiteStones));
        MM.get (bgObj[15], MD.maPendisplaySpec, y.ADR (blackStones));
        FOR x := 1 TO 24 DO
          IF blackBrett[x] > 0 THEN MM.set (brett[x], t.trStonePen, blackStones)
          ELSIF whiteBrett[x] > 0 THEN MM.set (brett[x], t.trStonePen, whiteStones)
          END (* IF *)
        END; (* FOR *)
        MM.AddMember (boardGrp, board);
        MS.DoMethod (boardGrp, y.TAG (buffer, MD.mmGroupExitChange));
        FOR x := 0 TO 27 DO
          MM.NoteButton (app, brett[x], x+1)
        END (* FOR *)
      ELSE ML.mDisposeObject (newBoard)
      END (* IF *)
    END (* IF *)
  END; (* IF *)
  RETURN 0

END ChangeBoardHook;
(*///*)

(*---------------------------------------------------------------------------*)

TYPE MenuArr = ARRAY [0..11] OF gt.NewMenu;

VAR menu := MenuArr {
  gt.NewMenu{type:gt.nmTitle},
  gt.NewMenu{type:gt.nmItem, userData:aboutID},
  gt.NewMenu{type:gt.nmItem, userData:openID},
  gt.NewMenu{type:gt.nmItem, userData:saveAsID},
  gt.NewMenu{type:gt.nmItem, userData:MD.mvApplicationReturnIDQuit},
  gt.NewMenu{type:gt.nmTitle},
  gt.NewMenu{type:gt.nmItem, userData:defaultID},
  gt.NewMenu{type:gt.nmItem, userData:lastSavedID},
  gt.NewMenu{type:gt.nmItem, userData:resetID},
  gt.NewMenu{type:gt.nmTitle},
  gt.NewMenu{type:gt.nmItem, userData:iconsID, itemFlags:i.MenuItemFlagSet{i.checkIt,i.menuToggle}},
  gt.NewMenu{type:gt.nmEnd}
  };

BEGIN (* bgMui *)

  (* Menü Label eintragen *)
  menu[0].label := pl.GetString (pl.MSG_PROJEKT);
  menu[1].label := l.GetString (l.MSG_ABOUT);
  menu[2].label := pl.GetString (pl.MSG_O_OFFNEN);
  menu[2].commKey := pl.GetKeyPtr (pl.MSG_O_OFFNEN);
  menu[3].label := pl.GetString (pl.MSG_A_SPEICHERN_ALS);
  menu[3].commKey := pl.GetKeyPtr (pl.MSG_A_SPEICHERN_ALS);
  menu[4].label := pl.GetString (pl.MSG_Q_BEENDEN);
  menu[4].commKey := pl.GetKeyPtr (pl.MSG_Q_BEENDEN);
  menu[5].label := pl.GetString (pl.MSG_Vorgaben);
  menu[6].label := pl.GetString (pl.MSG_DEFAULT);
  menu[6].commKey := pl.GetKeyPtr (pl.MSG_DEFAULT);
  menu[7].label := pl.GetString (pl.MSG_LAST);
  menu[7].commKey := pl.GetKeyPtr (pl.MSG_LAST);
  menu[8].label := pl.GetString (pl.MSG_RESTORE);
  menu[8].commKey := pl.GetKeyPtr (pl.MSG_RESTORE);
  menu[9].label := pl.GetString (pl.MSG_OPTIONEN);
  menu[10].label := pl.GetString (pl.MSG_ICONS);
  menu[10].commKey := pl.GetKeyPtr (pl.MSG_ICONS);

  MM.MakeHook (CopySliderGroup, copySliderHook);
  MM.MakeHook (set.LoadKiSettingsHook, loadKiHook);
  MM.MakeHook (set.SaveKiSettingsHook, saveKiHook);
  MM.MakeHook (ChangeBoardHook, boardHook);

  modusArr[0] := l.GetString (l.MSG_PLAY2);
  modusArr[1] := l.GetString (l.MSG_SET);
  playerArr[0] := l.GetString (l.MSG_HUMAN);
  playerArr[1] := l.GetString (l.MSG_COMPUTER);
  traceArr[0] := l.GetString (l.MSG_OFF);
  traceArr[1] := l.GetString (l.MSG_ON);

  textSource[0] := l.GetString (l.MSG_WELCOME);
  textSource[1] := NIL;

  text := MM.ListviewObject (y.TAG(buffer,
            MD.maListviewInput, FALSE,
            MD.maListviewList, MM.ListObject (y.TAG (buffer2,
                                 MD.maListConstructHook, MD.mvListConstructHookString,
                                 MD.maListDestructHook, MD.mvListDestructHookString,
                                 MD.maFrame, MD.mvFrameReadList,
                                 MD.maBackground, MD.miReadListBack,
                                 MD.maListSourceArray, y.ADR (textSource),
                                 MD.maListAdjustWidth, TRUE,
                               u.tagEnd)),
          u.tagEnd));

  play := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_PLAY)));
  new := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_NEW)));
  back := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_BACK)));
  modus := ML.MakeObject (MD.moCycle, y.TAG (buffer, l.GetKey (l.MSG_MODE), y.ADR (modusArr)));
  moves := MM.TextObject (y.TAG (buffer, MD.maFrame, MD.mvFrameText, MD.maBackground, MD.miTextBack, u.tagEnd));
  rating := MM.TextObject (y.TAG (buffer, MD.maFrame, MD.mvFrameText, MD.maBackground, MD.miTextBack, u.tagEnd));
  weissZiel := MM.TextObject (y.TAG (buffer, MD.maFrame, MD.mvFrameText, MD.maBackground, MD.miTextBack, u.tagEnd));
  schwarzZiel := MM.TextObject (y.TAG (buffer, MD.maFrame, MD.mvFrameText, MD.maBackground, MD.miTextBack, u.tagEnd));
  prevOn := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_Prev_On)));

  board := CreateBoard (0);
  boardGrp := MM.HGroup (y.TAG (buffer,
                MD.maBackground, MD.miGroupBack,
                MM.Child, board,
              u.tagEnd));

  window := MM.WindowObject(y.TAG(buffer,
              MD.maWindowTitle,           y.ADR("MUIBackgammon © 1996, Marc Ewert"),
              MD.maWindowID, MM.MakeID ("MBW1"),
              MD.maBackground, MD.miWindowBack,
              MM.WindowContents,
              MM.HGroup (y.TAG (buffer2,
                MM.Child, boardGrp,
                MM.Child, MM.VGroup (y.TAG(buffer3,
                            MD.maBackground, MD.miGroupBack,
                            MM.Child, MM.HGroup (y.TAG (buffer4,
                                        MM.Child, play,
                                        MM.Child, new,
                                        MM.Child, back,
                                      u.tagEnd)),
                            MM.Child, prevOn,
                            MM.Child, MM.ColGroup (2, y.TAG (buffer4,
                                        MM.Child, MM.KeyLabel1 (l.GetString (l.MSG_MODE), l.GetKey (l.MSG_MODE)),
                                        MM.Child, modus,
                                      u.tagEnd)),
                            MM.Child, MM.ColGroup (2, y.TAG (buffer4,
                                        MM.Child, MM.Label2 (l.GetString (l.MSG_MOVES)),
                                        MM.Child, moves,
                                        MM.Child, MM.Label2 (l.GetString (l.MSG_RATING)),
                                        MM.Child, rating,
                                        MM.Child, MM.Label2 (l.GetString (l.MSG_WHITE_TARGET)),
                                        MM.Child, weissZiel,
                                        MM.Child, MM.Label2 (l.GetString (l.MSG_BLACK_TARGET)),
                                        MM.Child, schwarzZiel,
                                      u.tagEnd)),
                            MM.Child, text,
                          u.tagEnd)),
              u.tagEnd)),
            u.tagEnd));

  (* ///"Preferences Window" *)
  bgObj[2] :=  ML.MakeObject (MD.moCycle, y.TAG (buffer, l.GetKey (l.MSG_TRACE), y.ADR (traceArr)));
  bgObj[0] := ML.MakeObject (MD.moCycle, y.TAG (buffer, l.GetKey (l.MSG_PLAYER1), y.ADR (playerArr)));
  bgObj[1] := ML.MakeObject (MD.moCycle, y.TAG (buffer, l.GetKey (l.MSG_PLAYER2), y.ADR (playerArr)));
  bgObj[3] := ML.MakeObject (MD.moSlider, y.TAG (buffer, l.GetString (l.MSG_LEVEL), 1, 3));
  bgObj[4] := ML.MakeObject (MD.moNumericButton, y.TAG (buffer, l.GetString (4), 0, 100, y.ADR ("%ld")));
  bgObj[5] := ML.MakeObject (MD.moNumericButton, y.TAG (buffer, l.GetString (5), 0, 100, y.ADR ("%ld")));
  bgObj[6] := ML.MakeObject (MD.moNumericButton, y.TAG (buffer, l.GetString (6), 0, 3, y.ADR ("%ld")));
  bgObj[7] := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_KION)));
  bgObj[8] := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_SAVE)));
  bgObj[9] := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_LOAD)));
  bgObj[13] := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_USE)));
  bgObj[14] := ML.mNewObject (y.ADR (MD.mcPoppen), y.TAG (buffer,
               MD.maCycleChain, 1, MD.maWindowTitle, l.GetString (14), u.tagDone));
  bgObj[15] := ML.mNewObject (y.ADR (MD.mcPoppen), y.TAG (buffer,
               MD.maCycleChain, 1, MD.maWindowTitle, l.GetString (15), u.tagDone));
  bgObj[16] := ML.mNewObject (y.ADR (MD.mcPoppen), y.TAG (buffer,
               MD.maCycleChain, 1, MD.maWindowTitle, l.GetString (16), u.tagDone));
  bgObj[17] := ML.mNewObject (y.ADR (MD.mcPoppen), y.TAG (buffer,
               MD.maCycleChain, 1, MD.maWindowTitle, l.GetString (17), u.tagDone));

  bgObj[10] := MM.ColGroup(2, y.TAG(buffer,
                 MD.maFrame, MD.mvFrameGroup,
                 MD.maFrameTitle, l.GetString (10),
                 MM.Child, MM.VSpace (0), MM.Child, MM.VSpace (0),
                 MM.Child, MM.Label1 (l.GetString (0)), MM.Child, bgObj[0],
                 MM.Child, MM.VSpace (0), MM.Child, MM.VSpace (0),
                 MM.Child, MM.Label1 (l.GetString (1)), MM.Child, bgObj[1],
                 MM.Child, MM.VSpace (0), MM.Child, MM.VSpace (0),
                 MM.Child, MM.Label1 (l.GetString (2)), MM.Child, bgObj[2],
                 MM.Child, MM.VSpace (0), MM.Child, MM.VSpace (0),
                 MM.Child, MM.Label1 (l.GetString (3)), MM.Child, bgObj[3],
                 MM.Child, MM.VSpace (0), MM.Child, MM.VSpace (0),
              u.tagEnd));

  bgObj[11] := MM.ColGroup(2, y.TAG(buffer,
                 MD.maFrame, MD.mvFrameGroup,
                 MD.maFrameTitle, l.GetString (11),
                 MM.Child, MM.Label1 (l.GetString (4)), MM.Child, bgObj[4],
                 MM.Child, MM.Label1 (l.GetString (5)), MM.Child, bgObj[5],
                 MM.Child, MM.Label1 (l.GetString (6)), MM.Child, bgObj[6],
                 MM.Child, MM.Label1 (l.GetString (14)), MM.Child, bgObj[14],
                 MM.Child, MM.Label1 (l.GetString (15)), MM.Child, bgObj[15],
                 MM.Child, MM.Label1 (l.GetString (16)), MM.Child, bgObj[16],
                 MM.Child, MM.Label1 (l.GetString (17)), MM.Child, bgObj[17],
              u.tagEnd));

  bgObj[12] := MM.VGroup(y.TAG(buffer,
                 MD.maFrame, MD.mvFrameGroup,
                 MD.maFrameTitle, l.GetString (12),
                 MM.Child, bgObj[7],
              u.tagEnd));

  prevWin := MM.WindowObject(y.TAG(buffer,
               MD.maWindowTitle, l.GetString (l.MSG_Prev_Win),
               MD.maWindowID, MM.MakeID ("MBW2"),
               MD.maBackground, MD.miWindowBack,
               MM.WindowContents,
               MM.VGroup(y.TAG(buffer2,
                 MM.Child, MM.HGroup (y.TAG (buffer3,
                             MD.maBackground, MD.miGroupBack,
                             MM.Child, MM.VGroup (y.TAG (buffer4,
                                         MM.Child, bgObj[10],
                                         MM.Child, bgObj[12],
                                       u.tagEnd)),
                             MM.Child, bgObj[11],
                           u.tagEnd)),
                 MM.Child, MM.HGroup (y.TAG (buffer3,
                             MD.maBackground, MD.miGroupBack,
                             MM.Child, bgObj[8],
                             MM.Child, bgObj[13],
                             MM.Child, bgObj[9],
                           u.tagEnd)),
              u.tagEnd)),
            u.tagEnd));
  (*///*)

  (* /// "KI Window" *)
  FOR farbe1 := 1 TO 2 DO
    FOR farbe2 := 1 TO 2 DO
      FOR elem := MIN (set.KiElem) TO MAX (set.KiElem) DO
        kiSlider[farbe1,farbe2,elem] :=
        ML.MakeObject (MD.moNumericButton, y.TAG (buffer, NIL, 0, 100, y.ADR ("%ld")))
      END (* FOR *)
    END (* FOR *)
  END; (* FOR *)
  wLCopy := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_LEFTCOPY)));
  wRCopy := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_RIGHTCOPY)));
  bLCopy := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_LEFTCOPY)));
  bRCopy := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_RIGHTCOPY)));
  wKiSave := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_SAVE2)));
  wKiLoad := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_LOAD)));
  bKiSave := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_SAVE2)));
  bKiLoad := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (l.MSG_LOAD)));
  wKiCom := ML.MakeObject (MD.moString, y.TAG (buffer, NIL, 200));
  bKiCom := ML.MakeObject (MD.moString, y.TAG (buffer, NIL, 200));

  kiWhiteGrp := MM.VGroup (y.TAG (buffer,
                  MM.Child, wKiCom,
                  MM.Child, MM.HGroup (y.TAG (buffer2,
                              MM.Child, MM.ColGroup(4, y.TAG(buffer3,
                                          MD.maFrame, MD.mvFrameGroup,
                                          MD.maFrameTitle, l.GetString (l.MSG_WHITE),
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_BAR_LEV)),
                                          MM.Child, kiSlider[1,1,set.bar],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SINGLE_LEV)),
                                          MM.Child, kiSlider[1,1,set.single],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SINGLEPROB_LEV)),
                                          MM.Child, kiSlider[1,1,set.singleProb],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_DISTANCE_LEV)),
                                          MM.Child, kiSlider[1,1,set.distance],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SIX_LEV)),
                                          MM.Child, kiSlider[1,1,set.six],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_BLOCK_LEV)),
                                          MM.Child, kiSlider[1,1,set.block],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_TARGET_LEV)),
                                          MM.Child, kiSlider[1,1,set.target],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_HOME_LEV)),
                                          MM.Child, kiSlider[1,1,set.home],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_DISTRIBUTION_LEV)),
                                          MM.Child, kiSlider[1,1,set.distribution],
                                        u.tagEnd)),
                              MM.Child, MM.ColGroup(4, y.TAG(buffer3,
                                          MD.maFrame, MD.mvFrameGroup,
                                          MD.maFrameTitle, l.GetString (l.MSG_BLACK),
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_BAR_LEV)),
                                          MM.Child, kiSlider[1,2,set.bar],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SINGLE_LEV)),
                                          MM.Child, kiSlider[1,2,set.single],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SINGLEPROB_LEV)),
                                          MM.Child, kiSlider[1,2,set.singleProb],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_DISTANCE_LEV)),
                                          MM.Child, kiSlider[1,2,set.distance],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SIX_LEV)),
                                          MM.Child, kiSlider[1,2,set.six],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_BLOCK_LEV)),
                                          MM.Child, kiSlider[1,2,set.block],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_TARGET_LEV)),
                                          MM.Child, kiSlider[1,2,set.target],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_HOME_LEV)),
                                          MM.Child, kiSlider[1,2,set.home],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_DISTRIBUTION_LEV)),
                                          MM.Child, kiSlider[1,2,set.distribution],
                                        u.tagEnd)),
                            u.tagEnd)),
                  MM.Child, MM.HGroup (y.TAG (buffer2,
                              MM.Child, wKiSave,
                              MM.Child, wLCopy,
                              MM.Child, wRCopy,
                              MM.Child, wKiLoad,
                            u.tagEnd)),
                u.tagEnd));

  kiBlackGrp := MM.VGroup (y.TAG (buffer,
                  MM.Child, bKiCom,
                  MM.Child, MM.HGroup (y.TAG (buffer2,
                              MM.Child, MM.ColGroup(4, y.TAG(buffer3,
                                          MD.maFrame, MD.mvFrameGroup,
                                          MD.maFrameTitle, l.GetString (l.MSG_BLACK),
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_BAR_LEV)),
                                          MM.Child, kiSlider[2,1,set.bar],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SINGLE_LEV)),
                                          MM.Child, kiSlider[2,1,set.single],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SINGLEPROB_LEV)),
                                          MM.Child, kiSlider[2,1,set.singleProb],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_DISTANCE_LEV)),
                                          MM.Child, kiSlider[2,1,set.distance],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SIX_LEV)),
                                          MM.Child, kiSlider[2,1,set.six],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_BLOCK_LEV)),
                                          MM.Child, kiSlider[2,1,set.block],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_TARGET_LEV)),
                                          MM.Child, kiSlider[2,1,set.target],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_HOME_LEV)),
                                          MM.Child, kiSlider[2,1,set.home],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_DISTRIBUTION_LEV)),
                                          MM.Child, kiSlider[2,1,set.distribution],
                                        u.tagEnd)),
                              MM.Child, MM.ColGroup(4, y.TAG(buffer3,
                                          MD.maFrame, MD.mvFrameGroup,
                                          MD.maFrameTitle, l.GetString (l.MSG_WHITE),
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_BAR_LEV)),
                                          MM.Child, kiSlider[2,2,set.bar],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SINGLE_LEV)),
                                          MM.Child, kiSlider[2,2,set.single],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SINGLEPROB_LEV)),
                                          MM.Child, kiSlider[2,2,set.singleProb],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_DISTANCE_LEV)),
                                          MM.Child, kiSlider[2,2,set.distance],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_SIX_LEV)),
                                          MM.Child, kiSlider[2,2,set.six],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_BLOCK_LEV)),
                                          MM.Child, kiSlider[2,2,set.block],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_TARGET_LEV)),
                                          MM.Child, kiSlider[2,2,set.target],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_HOME_LEV)),
                                          MM.Child, kiSlider[2,2,set.home],
                                          MM.Child, MM.Label1 (l.GetString (l.MSG_DISTRIBUTION_LEV)),
                                          MM.Child, kiSlider[2,2,set.distribution],
                                        u.tagEnd)),
                            u.tagEnd)),
                  MM.Child, MM.HGroup (y.TAG (buffer2,
                              MM.Child, bKiSave,
                              MM.Child, bLCopy,
                              MM.Child, bRCopy,
                              MM.Child, bKiLoad,
                            u.tagEnd)),
                u.tagEnd));


  kiRegTitles[0] := l.GetString (l.MSG_WHITE);
  kiRegTitles[1] := l.GetString (l.MSG_BLACK);
  kiRegTitles[2] := NIL;

  kiWin := MM.WindowObject(y.TAG(buffer,
             MD.maWindowTitle, l.GetString (l.MSG_KIWIN),
             MD.maWindowID, MM.MakeID ("MBW3"),
             MD.maBackground, MD.miWindowBack,
             MM.WindowContents,
             MM.VGroup(y.TAG(buffer2,
               MM.Child, MM.Register (y.TAG (buffer3,
                           MD.maBackground, MD.miGroupBack,
                           MD.maRegisterFrame, TRUE,
                           MD.maRegisterTitles, y.ADR (kiRegTitles),
                           MM.Child, kiWhiteGrp,
                           MM.Child, kiBlackGrp,
                         u.tagEnd)),
             u.tagEnd)),
           u.tagEnd));
    (*///*)

    strip := ML.MakeObject (MD.moMenustripNM, y.TAG (buffer, y.ADR (menu), u.tagEnd));
    itemIcons := y.CAST (MD.APTR, MS.DOMethod (strip, y.TAG (buffer,
                                MD.mmFindUData, iconsID)));

    app   := MM.ApplicationObject(y.TAG(buffer,
        MD.maApplicationTitle,        y.ADR("MUIBackgammon"),
        MD.maApplicationAuthor,       y.ADR("Marc Ewert"),
        MD.maApplicationVersion,      y.ADR("$VER: MUIBackgammon 1.0 (11.03.96)"),
        MD.maApplicationCopyright,    y.ADR("© 1996, Marc Ewert"),
        MD.maApplicationDescription,  y.ADR("Backgammon Game"),
        MD.maApplicationBase,         y.ADR("MUIBACKGAMMON"),
        MD.maApplicationMenustrip,    strip,
        MM.SubWindow,                 window,
        MM.SubWindow,                 prevWin,
        MM.SubWindow,                 kiWin,
        u.tagEnd));


    IF app=NIL THEN MS.fail(app, "failed to create application!!"); END;

    MM.NoteClose (app, window, MD.mvApplicationReturnIDQuit);   (* set up a notify on closing the window *)

    FOR x := 0 TO 27 DO
      MM.NoteButton (app, brett[x], x+1)
    END; (* FOR *)

    MM.NoteButton (app, play, playID);
    MM.NoteButton (app, new, newID);
    MM.NoteButton (app, back, backID);

    MS.DoMethod(modus, y.TAG (buffer, MD.mmNotify, MD.maCycleActive, MD.mvEveryTime,
                             app, 2, MD.mmApplicationReturnID, modusID));

    (* Notifications für öffnen/schliessen des Preferences Windows *)
    MS.DoMethod (prevOn, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, prevWin, 3, MD.mmSet, MD.maWindowOpen, TRUE));
    MS.DoMethod (prevWin, y.TAG (buffer, MD.mmNotify, MD.maWindowCloseRequest, TRUE, prevWin, 3, MD.mmSet, MD.maWindowOpen, FALSE));

    (* Notification für Preferences Gadgets *)
    MS.DoMethod(bgObj[0], y.TAG (buffer, MD.mmNotify, MD.maCycleActive, MD.mvEveryTime,
                             app, 2, MD.mmApplicationReturnID, player1ID));
    MS.DoMethod(bgObj[1], y.TAG (buffer, MD.mmNotify, MD.maCycleActive, MD.mvEveryTime,
                             app, 2, MD.mmApplicationReturnID, player2ID));
    MS.DoMethod(bgObj[2], y.TAG (buffer, MD.mmNotify, MD.maCycleActive, MD.mvEveryTime,
                             app, 2, MD.mmApplicationReturnID, traceID));

    MS.DoMethod (bgObj[0], y.TAG (buffer, MD.mmNotify, MD.maCycleActive, MD.mvEveryTime, bgObj[0], 3, MD.mmWriteLong, MD.mvTriggerValue, y.ADR (set.set.player1)));
    MS.DoMethod (bgObj[1], y.TAG (buffer, MD.mmNotify, MD.maCycleActive, MD.mvEveryTime, bgObj[1], 3, MD.mmWriteLong, MD.mvTriggerValue, y.ADR (set.set.player2)));
    MS.DoMethod (bgObj[2], y.TAG (buffer, MD.mmNotify, MD.maCycleActive, MD.mvEveryTime, bgObj[2], 3, MD.mmWriteLong, MD.mvTriggerValue, y.ADR (set.set.trace)));

    MS.DoMethod (bgObj[3], y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, bgObj[3], 3, MD.mmWriteLong, MD.mvTriggerValue, y.ADR (set.set.level)));
    MS.DoMethod (bgObj[4], y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, bgObj[4], 3, MD.mmWriteLong, MD.mvTriggerValue, y.ADR (set.set.blink)));
    MS.DoMethod (bgObj[5], y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, bgObj[5], 3, MD.mmWriteLong, MD.mvTriggerValue, y.ADR (set.set.blinkTime)));
    MS.DoMethod (bgObj[6], y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, bgObj[6], 3, MD.mmWriteLong, MD.mvTriggerValue, y.ADR (set.set.boardType)));
    MM.NoteButton (app, bgObj[8], saveID);
    MM.NoteButton (app, bgObj[9], openID);
    MM.NoteButton (app, bgObj[13], useID);
    MS.DoMethod (bgObj[8], y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, prevWin, 3, MD.mmSet, MD.maWindowOpen, FALSE));
    MS.DoMethod (bgObj[13], y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, prevWin, 3, MD.mmSet, MD.maWindowOpen, FALSE));

    MS.DoMethod (bgObj[14], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec,
                 MD.mvEveryTime, brett[26], 3, MD.mmSet, b.brStonePen, MD.mvTriggerValue));
    MS.DoMethod (bgObj[15], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec,
                 MD.mvEveryTime, brett[27], 3, MD.mmSet, b.brStonePen, MD.mvTriggerValue));
    MS.DoMethod (bgObj[16], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec,
                 MD.mvEveryTime, brett[27], 3, MD.mmSet, b.brPen, MD.mvTriggerValue));
    MS.DoMethod (bgObj[17], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec,
                 MD.mvEveryTime, brett[26], 3, MD.mmSet, b.brPen, MD.mvTriggerValue));
    MS.DoMethod (bgObj[14], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec,
                 MD.mvEveryTime, brett[0], 3, MD.mmSet, ho.hoStonePen, MD.mvTriggerValue));
    MS.DoMethod (bgObj[15], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec,
                 MD.mvEveryTime, brett[25], 3, MD.mmSet, ho.hoStonePen, MD.mvTriggerValue));
    MS.DoMethod (bgObj[16], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec,
                 MD.mvEveryTime, brett[25], 3, MD.mmSet, ho.hoPen, MD.mvTriggerValue));
    MS.DoMethod (bgObj[17], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec,
                 MD.mvEveryTime, brett[0], 3, MD.mmSet, ho.hoPen, MD.mvTriggerValue));
    FOR x := 1 TO 24 DO
      IF ODD (x) THEN
        MS.DoMethod (bgObj[16], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec,
                     MD.mvEveryTime, brett[x], 3, MD.mmSet, t.trPen, MD.mvTriggerValue))
      ELSE
        MS.DoMethod (bgObj[17], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec,
                     MD.mvEveryTime, brett[x], 3, MD.mmSet, t.trPen, MD.mvTriggerValue))
      END (* IF *)
    END; (* FOR *)
    MS.DoMethod(bgObj[14], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec, MD.mvEveryTime,
                             app, 2, MD.mmApplicationReturnID, whiteStonesID));
    MS.DoMethod(bgObj[15], y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec, MD.mvEveryTime,
                             app, 2, MD.mmApplicationReturnID, blackStonesID));

    (* Hookfkt. für boardType *)
    MS.DoMethod (bgObj[6], y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, bgObj[6], 3, MD.mmCallHook, boardHook, MD.mvTriggerValue));

    (* Notifications für öffnen/schliessen des KI Windows *)
    MS.DoMethod (bgObj[7], y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, kiWin, 3, MD.mmSet, MD.maWindowOpen, TRUE));
    MS.DoMethod (kiWin, y.TAG (buffer, MD.mmNotify, MD.maWindowCloseRequest, TRUE, kiWin, 3, MD.mmSet, MD.maWindowOpen, FALSE));

    (* Notifications für Slider des Ki Windows *)

    FOR z := 1 TO 2 DO
      FOR x := 1 TO 2 DO
        FOR elem := MIN (set.KiElem) TO MAX (set.KiElem) DO
          MS.DoMethod (kiSlider[z,x,elem], y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, kiSlider[z,x,elem], 3, MD.mmWriteLong, MD.mvTriggerValue, y.ADR (set.kiSetting[z,x,elem])))
        END (* FOR *)
      END (* FOR *)
    END; (* FOR *)

    (* HookFkt. für Kopier Slidergruppe Buttons *)
    MS.DoMethod (wLCopy, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, wLCopy, 4, MD.mmCallHook, copySliderHook, 1, 1));
    MS.DoMethod (wRCopy, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, wRCopy, 4, MD.mmCallHook, copySliderHook, 1, 2));
    MS.DoMethod (bLCopy, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, bLCopy, 4, MD.mmCallHook, copySliderHook, 2, 1));
    MS.DoMethod (bRCopy, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, bRCopy, 4, MD.mmCallHook, copySliderHook, 2, 2));

    (* Hookfkt. für Ki Laden und Speichern *)
    MS.DoMethod (wKiSave, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, wKiSave, 3, MD.mmCallHook, saveKiHook, 1));
    MS.DoMethod (wKiLoad, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, wKiLoad, 3, MD.mmCallHook, loadKiHook, 1));
    MS.DoMethod (bKiSave, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, bKiSave, 3, MD.mmCallHook, saveKiHook, 2));
    MS.DoMethod (bKiLoad, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, bKiLoad, 3, MD.mmCallHook, loadKiHook, 2));

    ms.WriteTextInt (weissZiel, 0);
    ms.WriteTextInt (schwarzZiel, 0);

CLOSE

    MM.set (kiWin, MD.maWindowOpen, 0);
    MM.set (prevWin, MD.maWindowOpen, 0);
    MM.set (window, MD.maWindowOpen, 0);
    ML.mDisposeObject (app);             (* free our application resources *)

END bgMui.


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
*           V2.00 - (..)
*                   * Komplett neu geschrieben, Einteilung in SubClasses
*
*       NOTES
*
************************************************************************************
*)

(*$ RangeChk := FALSE *)

IMPORT

  asl : AslD,
  d   : DosD,
  D   : DosL,
  i   : IntuitionD,
  I   : IntuitionL,
  l   : bgLocale,
  MD  : MuiD,
  ML  : MuiL,
  MM  : MuiMacros,
  s   : String,
  u   : UtilityD,
  y   : SYSTEM;

(*--------------------------------------------------------------------------------*)

PROCEDURE MakeButton (num : LONGINT) : MD.APTR;

VAR obj : MD.APTR;
    buffer : ARRAY [0..0] OF LONGINT;

BEGIN (* MakeButton *)

  obj := ML.MakeObject (MD.moButton, y.TAG (buffer, l.GetString (num)));
  IF obj <> NIL THEN MM.set (obj, MD.maCycleChain, 1)
  END; (* IF *)
  RETURN obj

END MakeButton;

(*---------------------------------------------------------------------------*)

PROCEDURE MakeCycle (num : LONGINT; entries : y.ADDRESS) : MD.APTR;

VAR obj    : MD.APTR;
    buffer : ARRAY [0..1] OF LONGINT;

BEGIN (* MakeCycle *)

  obj := ML.MakeObject (MD.moCycle, y.TAG (buffer, l.GetString (num), entries));
  IF obj <> NIL THEN MM.set (obj, MD.maCycleChain, 1)
  END; (* IF *)
  RETURN obj

END MakeCycle;

(*---------------------------------------------------------------------------*)

PROCEDURE MakeString (num, max : LONGINT) : MD.APTR;

VAR obj    : MD.APTR;
    buffer : ARRAY [0..1] OF LONGINT;

BEGIN (* MakeString *)

  obj := ML.MakeObject (MD.moString, y.TAG (buffer, l.GetString (num), max));
  IF obj <> NIL THEN MM.set (obj, MD.maCycleChain, 1)
  END; (* IF *)
  RETURN obj

END MakeString;

(*---------------------------------------------------------------------------*)

PROCEDURE MakeNumericButton (num, min, max : LONGINT) : MD.APTR;

VAR obj    : MD.APTR;
    buffer : ARRAY [0..3] OF LONGINT;

BEGIN (* MakeNumericButton *)

  obj := ML.MakeObject (MD.moNumericButton, y.TAG (buffer, l.GetString (num), min, max, y.ADR ("%ld")));
  IF obj <> NIL THEN MM.set (obj, MD.maCycleChain, 1)
  END; (* IF *)
  RETURN obj

END MakeNumericButton;

(*---------------------------------------------------------------------------*)

PROCEDURE MakeSlider (num, min, max : LONGINT) : MD.APTR;

VAR obj    : MD.APTR;
    buffer : ARRAY [0..2] OF LONGINT;

BEGIN (* MakeSlider *)

  obj := ML.MakeObject (MD.moSlider, y.TAG (buffer, l.GetString (num), min, max));
  IF obj <> NIL THEN MM.set (obj, MD.maCycleChain, 1)
  END; (* IF *)
  RETURN obj

END MakeSlider;

(*---------------------------------------------------------------------------*)

PROCEDURE MakeLabel1 (num : LONGINT) : y.ADDRESS;

VAR buffer : ARRAY [0..1] OF LONGINT;

BEGIN (* MakeLabel1 *)

  RETURN ML.MakeObject (MD.moLabel, y.TAG (buffer, l.GetString (num), MD.moLabelSingleFrame))

END MakeLabel1;

(*---------------------------------------------------------------------------*)

PROCEDURE MakeLabel2 (num : LONGINT) : y.ADDRESS;

VAR buffer : ARRAY [0..1] OF LONGINT;

BEGIN (* MakeLabel2 *)

  RETURN ML.MakeObject (MD.moLabel, y.TAG (buffer, l.GetString (num), MD.moLabelDoubleFrame))

END MakeLabel2;

(*---------------------------------------------------------------------------*)

PROCEDURE SetQuiet (obj : MD.APTR; n, value : LONGINT);

VAR buffer : ARRAY [0..4] OF LONGINT;
    dummy  : y.ADDRESS;

BEGIN (* SetQuiet *)

  dummy := I.SetAttrsA (obj, y.TAG (buffer, MD.maNoNotify, TRUE, n, value, u.tagDone))

END SetQuiet;

(*---------------------------------------------------------------------------*)

PROCEDURE xget (obj : MD.APTR; value : LONGINT) : y.ADDRESS;

VAR result : y.ADDRESS;

BEGIN (* xget *)

  MM.get (obj, value, y.ADR (result));
  RETURN result

END xget;

(*---------------------------------------------------------------------------*)

VAR buf, file, path  : Str;
    left             :=LONGINT{-1};
    top              :=LONGINT{-1};
    width            :=LONGINT{-1};
    height           :=LONGINT{-1};

PROCEDURE GetFileName (obj : MD.APTR; num : LONGINT; pat : y.ADDRESS; save : BOOLEAN) : y.ADDRESS;
(* Fragt User nach Filename *)

VAR req    : asl.FileRequesterPtr;
    win    : i.WindowPtr;
    app    : MD.APTR;
    res    : y.ADDRESS;
    buffer : ARRAY [0..24] OF LONGINT;

BEGIN (* GetFileName *)

    res := NIL;
    app := xget (obj, MD.maApplicationObject);
    win := y.CAST (i.WindowPtr, xget (obj, MD.maWindowWindow));
    IF left = -1 THEN
      left   := win^.leftEdge + win^.borderLeft + 2;
      top    := win^.topEdge + win^.borderTop + 2;
      width  := win^.width - win^.borderLeft - win^.borderRight - 4;
      height := win^.height - win^.borderTop - win^.borderBottom - 4;
    END; (* IF *)
    req := ML.mAllocAslRequest (asl.aslFileRequest, y.TAG (buffer,
             asl.tfrWindow, win,
             asl.tfrTitleText, l.GetString (num),
             asl.tfrInitialLeftEdge, left,
             asl.tfrInitialTopEdge , top,
             asl.tfrInitialWidth   , width,
             asl.tfrInitialHeight  , height,
             asl.tfrInitialDrawer  , y.ADR (path),
             asl.tfrInitialPattern , pat,
             asl.tfrDoSaveMode     , save,
             asl.tfrDoPatterns     , TRUE,
             asl.tfrRejectIcons    , TRUE,
             asl.tfrUserData       , app,
             u.tagDone));
    IF req <> NIL THEN
      MM.set (app, MD.maApplicationSleep, 1);
      IF ML.mAslRequest (req, y.TAG (buffer, u.tagDone)) THEN
        IF req^.file <> NIL THEN
          IF s.CanCopy (buf, y.CAST (StrPtr, req^.dir)^) THEN
            s.Copy (buf, y.CAST (StrPtr, req^.dir)^);
            IF D.AddPart (y.ADR (buf), req^.file , SIZE (buf)) THEN res := y.ADR (buf)
            END (* IF *)
          END (* IF *)
        END; (* IF *)
        left   := req^.leftEdge;
        top    := req^.topEdge;
        width  := req^.width;
        height := req^.height
      END; (* IF *)
      ML.mFreeAslRequest (req);
      MM.set (app, MD.maApplicationSleep, 0)
    END; (* IF *)
    RETURN res

END GetFileName;

(*---------------------------------------------------------------------------*)

PROCEDURE OpenPref (obj : MD.APTR; VAR datei : d.FileHandlePtr; name : y.ADDRESS; id : LONGINT; ver : INTEGER;  read : BOOLEAN) : BOOLEAN;
(* Öffnet Preferences File *)

VAR res  : INTEGER;
    long : LONGINT;

BEGIN (* OpenPref *)

  IF read THEN
    datei := D.Open (name, d.readOnly);
    IF datei <> NIL THEN
      IF D.Read (datei, y.ADR (long), SIZE (long)) = SIZE (long) THEN
        IF long = id THEN
          IF D.Read (datei, y.ADR (res), SIZE (res)) = SIZE (res) THEN
          END (* IF *)
        END (* IF *)
      END; (* IF *)
      D.Close (datei); RETURN res = ver
    END (* IF *)
  ELSE
    datei := D.Open (name, d.readWrite);
    IF datei <> NIL THEN
      IF D.Write (datei, y.ADR (id), SIZE (id)) = SIZE (id) THEN
        IF D.Write (datei, y.ADR (ver), SIZE (ver)) = SIZE (ver) THEN
        END (* IF *)
      END; (* IF *)
      D.Close (datei); RETURN TRUE
    END (* IF *)
  END; (* IF *)
  RETURN FALSE

END OpenPref;

(*---------------------------------------------------------------------------*)

PROCEDURE Read (obj : MD.APTR; datei : d.FileHandlePtr; buf : y.ADDRESS; len : LONGINT) : LONGINT;

BEGIN (* Read *)

  RETURN D.Read (datei, buf, len)

END Read;

(*---------------------------------------------------------------------------*)

PROCEDURE Write (obj : MD.APTR; datei : d.FileHandlePtr; buf : y.ADDRESS; len : LONGINT) : LONGINT;

BEGIN (* Write *)

  RETURN D.Write (datei, buf, len)

END Write;


END bgMui.


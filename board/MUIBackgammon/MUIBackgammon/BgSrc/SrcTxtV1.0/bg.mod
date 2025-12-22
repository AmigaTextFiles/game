MODULE bg;
(****h* bg/bg *************************************************
*
*       NAME
*           bg  ---  Backgammon
*
*       COPYRIGHT
*           © 1995, Marc Ewert
*
*       FUNCTION
*           Backgammon Spiel
*
*       AUTHOR
*           Marc Ewert
*
*       CREATION DATE
*           11.06.95
*
*       HISTORY
*           V1.00 - (11.03.95)
*                   * Erste Version
*
*       NOTES
*
************************************************************************************
*)

(*$ DEFINE EVOLUTION := FALSE *)

IMPORT

  t   : bgTriangle,
  a   : Arts,
  b   : bgBewerten,
  br  : bgBerechnen,
  c   : Conversions,
  d   : DosD,
  D   : DosL,
  E   : ExecL,
  h   : Heap,
  i   : IntuitionD,
  I   : IntuitionL,
  IC  : IconL,
  in  : bgInit,
  k   : bgKonvert,
  l   : bgLocale,
  MC  : MuiClasses,
  MD  : MuiD,
  ML  : MuiL,
  MM  : MuiMacros,
  MS  : MuiSupport,
  ms  : MuiSup,
  mui : bgMui,
  rs  : ReqSup,
  s   : String,
  set : bgSettings,
  str : bgStrukturen,
  u   : UtilityD,
  w   : bgWuerfeln,
  wb  : WorkbenchD,
  y   : SYSTEM,
  z   : bgZiehen;

  (*$ IF EVOLUTION *)
    IMPORT io : InOut, rnd : RandomNumber;
  (*$ ENDIF *)

(*--------------------------------------------------------------------------------*)

VAR umsetzZug, menschZug, history : str.Zug;
    umsetzFarbe, weiss, schwarz   : CARDINAL;
    warten, mutieren              : BOOLEAN;
    win                           : i.WindowPtr;
    buffer                        : ARRAY [0..10] OF LONGINT;

    (*$ IF EVOLUTION *)
      VAR  whiteCnt, blackCnt : LONGINT;
    (*$ ENDIF *)

(*--------------------------------------------------------------------------------*)

(*$ IF EVOLUTION *)

PROCEDURE Mutiere (farbe : CARDINAL);

VAR elem   : set.KiElem;
    mut, n : LONGINT;

PROCEDURE Min (a, b : LONGINT) : LONGINT;
BEGIN IF a < b THEN RETURN a ELSE RETURN b END END Min;

PROCEDURE Max (a, b : LONGINT) : LONGINT;
BEGIN IF a > b THEN RETURN a ELSE RETURN b END END Max;

BEGIN (* Mutiere *)

    n := ORD (MAX (set.KiElem));
    elem := VAL (set.KiElem, rnd.RND (n + 1));
    CASE elem OF
      set.bar          : mut := rnd.RND(100) + 1
    | set.single       : mut := rnd.RND(100) + 1
    | set.singleProb   : mut := rnd.RND(100) + 1
    | set.distribution : mut := rnd.RND(20) + 1
    | set.distance     : mut := rnd.RND(50) + 1
    | set.six          : mut := rnd.RND(100) + 1
    | set.block        : mut := rnd.RND(100) + 1
    | set.target       : mut := rnd.RND(100) + 1
    | set.home         : mut := rnd.RND(70) + 1
    END; (* CASE *)
    MM.set (mui.kiSlider[farbe, 1, elem], MD.maNumericValue, mut);
    MM.set (mui.kiSlider[farbe, 2, elem], MD.maNumericValue, mut)

END Mutiere;

(*$ ENDIF *)

(*---------------------------------------------------------------------------*)

PROCEDURE Setzen (VAR bh : str.BgHandle; zug : str.Zug; loop : CARDINAL);

VAR x : CARDINAL;

BEGIN (* Setzen *)

  mui.Setzen (bh, zug, loop)

END Setzen;

(*--------------------------------------------------------------------------------*)

PROCEDURE PrintRestZuege (tiefe : CARDINAL; pasch : BOOLEAN);
(* Gibt Anzahl der übrigen Züge auf Bildschirm aus. *)

VAR uebrig : INTEGER;

BEGIN (* PrintRestZuege *)

  IF pasch THEN uebrig :=  4 - tiefe
  ELSE uebrig := 2 - tiefe
  END; (* IF *)
  ms.WriteTextInt (mui.moves, uebrig)

END PrintRestZuege;

(*--------------------------------------------------------------------------------*)

PROCEDURE Bewerten (VAR bh : str.BgHandle) : BOOLEAN;
(* Liefert Flag, ob jemand gewonnen hat *)

VAR bewertung : LONGINT;

BEGIN (* Bewerten *)

  bewertung := b.Bewerten (bh);
  ms.WriteTextInt (mui.rating, bewertung);
  IF bewertung >= b.Max THEN
    mui.AddText (l.GetString (l.MSG_WHITE_WINS));
    in.InitBrett ( bh.brett );

    (*$ IF EVOLUTION *)
      INC (whiteCnt);
      io.WriteString ("White: "); io.WriteInt (whiteCnt, 4); io.WriteLn;
      io.WriteString ("Black: "); io.WriteInt (blackCnt, 4); io.WriteLn;
      IF (whiteCnt > blackCnt+8) OR (whiteCnt+blackCnt > 26) THEN
        IF whiteCnt > blackCnt THEN
          io.WriteString  ("Weiss überlebt!\n");
          Mutiere (str.schwarz);
        ELSE
          io.WriteString  ("Schwarz überlebt!\n");
          Mutiere (str.weiss)
        END; (* IF *)
        whiteCnt := 0; blackCnt := 0;
      END; (* IF *)
    (*$ ENDIF *)

    RETURN TRUE
  ELSIF bewertung <= b.Min THEN
    mui.AddText (l.GetString (l.MSG_BLACK_WINS));
    in.InitBrett ( bh.brett );
    PrintRestZuege (2, FALSE);      (* 0 ausgeben lassen *)

    (*$ IF EVOLUTION *)
      INC (blackCnt);
      io.WriteString ("White: "); io.WriteInt (whiteCnt, 4); io.WriteLn;
      io.WriteString ("Black: "); io.WriteInt (blackCnt, 4); io.WriteLn;
      IF (blackCnt > whiteCnt+8) OR (whiteCnt+blackCnt > 26) THEN
        IF whiteCnt > blackCnt THEN
          io.WriteString  ("Weiss überlebt!\n");
          Mutiere (str.schwarz)
        ELSE
          io.WriteString  ("Schwarz überlebt!\n");
          Mutiere (str.weiss)
        END; (* IF *)
        whiteCnt := 0; blackCnt := 0;
      END; (* IF *)
    (*$ ENDIF *)

    RETURN TRUE
  END; (* IF *)
  RETURN FALSE

END Bewerten;

(*--------------------------------------------------------------------------------*)

PROCEDURE WuerfelAusgeben (wurf : str.Wurf);

VAR ausgabe, long : str.Str;
    err           : BOOLEAN;

BEGIN (* WuerfelAusgeben *)

  s.Copy (ausgabe, y.CAST (a.StrPtr,l.GetString (l.MSG_THE_DICES_ARE))^);
  c.ValToStr (wurf[1], FALSE, long, 10, 2, " ", err);
  s.Concat (ausgabe, long);
  c.ValToStr (wurf[2], FALSE, long, 10, 2, " ", err);
  s.Concat (ausgabe, long);
  c.ValToStr (wurf[3], FALSE, long, 10, 2, " ", err);
  s.Concat (ausgabe, long);
  c.ValToStr (wurf[4], FALSE, long, 10, 2, " ", err);
  s.Concat (ausgabe, long);
  mui.AddText (y.ADR (ausgabe));

END WuerfelAusgeben;

(*--------------------------------------------------------------------------------*)

PROCEDURE Wuerfeln (VAR wurf : str.Wurf);

BEGIN (* Wuerfeln *)

  w.Wuerfeln (wurf);
  WuerfelAusgeben (wurf)

END Wuerfeln;

(*--------------------------------------------------------------------------------*)

PROCEDURE SteinUmsetzen (VAR bh : str.BgHandle; res : LONGINT; VAR first : BOOLEAN);
(* Stein bewegen im Modus setzen *)

VAR farbe, typ : CARDINAL;
    bewertung  : LONGINT;

BEGIN (* SteinUmsetzen *)

  farbe := bh.farbe; typ := bh.typ;
  bh.farbe := umsetzFarbe; (* bh.typ := str.setzen;*)
  IF first THEN         (* Ausgangspunkt gewählt *)
    z.ZugLoeschen (umsetzZug);
    IF bh.brett[res] <> 0 THEN
      umsetzZug[1,1] := res;
      first := FALSE;
      IF (bh.brett[res] > 0) AND (res <> str.schwarzBar) AND (res <> str.schwarzZiel) THEN
        umsetzFarbe := str.weiss
      ELSE umsetzFarbe := str.schwarz
      END (* IF *)
    END; (* IF *)
  ELSE                  (* Zielpunkt wählen *)
    first := TRUE;
    IF (umsetzFarbe = str.weiss) AND (bh.brett[res] >= -1) AND (res <> str.schwarzBar)
    AND (res <> str.schwarzZiel) THEN
      umsetzZug[1,2] := res;
      mui.Setzen (bh, umsetzZug, 0)
    ELSIF (umsetzFarbe = str.schwarz) AND (res <> str.weissBar) AND (res <> str.weissZiel)
    AND ((bh.brett[res] <= 1) OR (res = str.schwarzZiel) OR (res = str.schwarzBar)) THEN
      umsetzZug[1,2] := res;
      mui.Setzen (bh, umsetzZug, 0)
    ELSE I.DisplayBeep (NIL)
    END; (* IF *)
    bewertung := b.Bewerten (bh);
    ms.WriteTextInt (mui.rating, bewertung);
  END; (* IF *)
  bh.typ := typ; bh.farbe := farbe

END SteinUmsetzen;

(*--------------------------------------------------------------------------------*)

PROCEDURE MenschZug (VAR bh : str.BgHandle; res : LONGINT; VAR first : BOOLEAN);
(* Userzug entgegennehmen *)

BEGIN (* MenschZug *)

  IF first THEN         (* Ausgangspunkt gewählt *)
    menschZug[1,1] := res;
    first := FALSE
  ELSE                  (* Zielpunkt wählen *)
    first := TRUE;
    menschZug[1,2] := res;
    IF br.ZugMoeglich (bh, history, menschZug) THEN
      history[bh.tiefe + 1,1] := menschZug[1,1]; history[bh.tiefe + 1,2] := menschZug[1,2];
      mui.Setzen (bh, menschZug, 0);
      INC (bh.tiefe);
      PrintRestZuege (bh.tiefe, bh.wurf[1] = bh.wurf[2])
    ELSE I.DisplayBeep (NIL)
    END (* IF *)
  END (* IF *)

END MenschZug;

(*--------------------------------------------------------------------------------*)

PROCEDURE Wechseln (VAR bh : str.BgHandle);

BEGIN (* Wechseln *)

  Wuerfeln (bh.wurf);
  PrintRestZuege (0, bh.wurf[1] = bh.wurf[2]);
  bh.farbe := 3 - bh.farbe;
  IF bh.farbe = str.weiss THEN
    mui.AddText (l.GetString (l.MSG_WHITE_GOES_ON));
    bh.typ := weiss
  ELSE
    mui.AddText (l.GetString (l.MSG_BLACK_GOES_ON));
    bh.typ := schwarz
  END (* IF *)

END Wechseln;

(*--------------------------------------------------------------------------------*)

PROCEDURE Beginnen (VAR bh : str.BgHandle);

BEGIN (* Beginnen *)

  (* Beginner auswürfeln *)
  LOOP
    Wuerfeln (bh.wurf);
    IF bh.wurf[1] < bh.wurf[2] THEN
      mui.AddText (l.GetString (l.MSG_Black_Begins));
      bh.farbe := str.schwarz; bh.typ := schwarz;
      EXIT
    ELSIF bh.wurf[1] > bh.wurf[2] THEN
      mui.AddText (l.GetString (l.MSG_White_Begins));
      bh.farbe := str.weiss; bh.typ := weiss;
      EXIT
    END (* IF *)
  END; (* LOOP *)
  PrintRestZuege (0, bh.wurf[1] = bh.wurf[2]);
  mutieren := TRUE

END Beginnen;

(*---------------------------------------------------------------------------*)

PROCEDURE Zurueck (VAR bh : str.BgHandle);

VAR wurf  : str.Wurf;
    farbe : CARDINAL;

BEGIN (* Zurueck *)

   z.Zurueck (bh);
   IF bh.typ = str.computer THEN
     (* bei comuter muss ich solange zurueck nehmen, bis ich am Ausgangspunkt
        des Zuges angelangt bin, da Berechnen nur dann angesetzt werden kann *)
     WHILE bh.tiefe > 1 DO z.Zurueck (bh)
     END; (* WHILE *)
     warten := TRUE; mutieren := TRUE;
     MM.set (mui.window, MD.maWindowActiveObject, mui.play)
   ELSIF bh.typ = str.mensch THEN
     history[bh.tiefe+1, 1] := 0; history[bh.tiefe+1, 2] := 0
   END; (* IF *)
   mui.Show (bh.brett);
   PrintRestZuege (bh.tiefe, bh.wurf[1] = bh.wurf[2]);
   WuerfelAusgeben (bh.wurf);
   IF bh.farbe = str.weiss THEN mui.AddText (l.GetString (l.MSG_WHITE_GOES_ON))
   ELSE mui.AddText (l.GetString (l.MSG_BLACK_GOES_ON))
   END (* IF *)

END Zurueck;

(*--------------------------------------------------------------------------------*)

PROCEDURE Berechnen (VAR bh : str.BgHandle) : BOOLEAN;
(* Computer berechnet Zug. Liefert TRUE wenn Computer gewonnen hat*)

VAR zug     : str.Zug;

BEGIN (* Berechnen *)

  mui.AddText (l.GetString (l.MSG_CALCULATE));
  br.Berechnen (bh, zug);
  mui.Setzen (bh, zug, set.set.blink);
  RETURN Bewerten (bh)

END Berechnen;

(*--------------------------------------------------------------------------------*)

PROCEDURE About ();

VAR dummy : LONGINT;

BEGIN (* About *)

  dummy := ML.mRequestA (mui.app, mui.window, 0, y.ADR ("About MUIBackgammon"),
                         y.ADR ("OK"),
                         l.GetString (l.MSG_ABOUT_MES),
                         y.TAG (buffer, u.tagEnd));

END About;

(*---------------------------------------------------------------------------*)

PROCEDURE HandleArgs ();

CONST template = y.ADR ("FROM");
CONST help = y.ADR ("\nUsage: MUIBackgammon <from>\n<from>: name of configuration file");

TYPE Parameter = RECORD
                   name : str.StrPtr;
                 END; (* RECORD *)

VAR rda, rdas  : d.RDArgsPtr;
    parms      : Parameter;
    name       : str.Str;
    diskObject : wb.DiskObjectPtr;
    lock       : d.FileLockPtr;
    fileInfo   : d.FileInfoBlock;
    ch         : CHAR;

BEGIN (* HandleArgs *)

  parms.name := NIL;
  IF a.wbStarted THEN
    IF a.startupMsg <> NIL THEN
      diskObject := IC.GetDiskObject (y.CAST (wb.WBStartupPtr, a.startupMsg)^.argList^[0].name);
      IF diskObject <> NIL THEN
        parms.name := IC.FindToolType (diskObject^.toolTypes, y.ADR ("FROM"));
      END; (* IF *)
      IF y.CAST (wb.WBStartupPtr, a.startupMsg)^.numArgs > 1 THEN
        parms.name := y.CAST (wb.WBStartupPtr, a.startupMsg)^.argList^[1].name;
        lock := y.CAST (wb.WBStartupPtr, a.startupMsg)^.argList^[1].lock;
      END; (* IF *)
    END (* IF *)
  ELSE
    rdas := D.AllocDosObject (d.dosRdArgs, NIL);
    IF rdas <> NIL THEN
      rdas^.extHelp := help;
      rda := D.ReadArgs (template, y.ADR (parms), rdas)
    END (* IF *)
  END; (* IF *)

  name[0] := 0C;
  IF parms.name <> NIL THEN
    IF lock <> NIL THEN
      IF D.Examine (lock, y.ADR (fileInfo)) THEN
        IF s.CanCopy (name, fileInfo.fileName) THEN
          s.Copy (name, fileInfo.fileName);
          IF D.ParentDir (lock) <> NIL THEN ch := "/"
          ELSE ch := ":"
          END; (* IF *)
          IF s.CanConcatChar (name, ch) THEN s.ConcatChar (name, ch)
          END (* IF *)
        END (* IF *)
      END (* IF *)
    END; (* IF *)
    IF s.CanConcat (name, parms.name^) THEN
      s.Concat (name, parms.name^);
      set.LoadSettings (y.ADR (name))
    END (* IF *)
  ELSE
    set.LoadSettings (y.ADR (set.envName))
  END; (* IF *)

  IF rda <> NIL THEN D.FreeArgs (rda) END; (* IF *)
  IF rdas <> NIL THEN D.FreeDosObject (d.dosRdArgs, rdas) END; (* IF *)
  IF diskObject <> NIL THEN IC.FreeDiskObject (diskObject) END (* IF *)

END HandleArgs;

(*--------------------------------------------------------------------------------*)

VAR ausgabe                 : str.Str;
    x                       : CARDINAL;
    running, spielen, first : BOOLEAN;
    trace, wechsel, setted  : BOOLEAN;
    signals                 : y.LONGSET;
    zug                     : str.Zug;
    res, result, result2    : LONGINT;
    bh                      : str.BgHandle;

BEGIN (* Backgammon *)

  IF mui.app <> NIL THEN
    in.InitBrett (bh.brett);
    MM.get (mui.window, MD.maWindow, y.ADR (win));
    HandleArgs ();

    MM.set (mui.window, MD.maWindowOpen, 1);

    weiss := str.mensch; schwarz := str.computer;

    (*$ IF EVOLUTION *)
      weiss := str.computer; schwarz := str.computer;
      whiteCnt := 0; blackCnt := 0;
    (*$ ENDIF *)

    trace := FALSE; z.ZugLoeschen (zug);
    setted := FALSE; spielen := TRUE; mutieren := FALSE;
    running := TRUE; wechsel := TRUE; warten := FALSE;
    Beginnen (bh);
    WHILE running DO
      IF wechsel OR mutieren THEN (* spielerwechsel oder mutation (comp <-> hum) *)
        IF NOT ((bh.typ = str.computer) AND warten) THEN (* trace modus *)
          MM.set (mui.window, MD.maWindowActiveObject, MD.mvWindowActiveObjectNone);
          wechsel := FALSE; mutieren := FALSE;
          IF bh.typ = str.computer THEN
            setted := FALSE;
            warten := trace; wechsel := TRUE;
            IF Berechnen (bh) THEN Beginnen (bh)
            ELSE Wechseln (bh)
            END (* IF *)
          ELSE
            mui.AddText (l.GetString (l.MSG_ITS_YOUR_TURN));
            z.ZugLoeschen (history); z.ZugLoeschen (menschZug);
            bh.tiefe := 0; first := TRUE;
            IF NOT br.ZugUebrig (bh, history) THEN
              Wechseln (bh);
              wechsel := TRUE; warten := trace
            END (* IF *)
          END (* IF *)
        ELSIF warten AND NOT setted THEN
          MM.set (mui.window, MD.maWindowActiveObject, mui.play);
          setted := TRUE
        END (* IF *)
      END; (* IF *)
      res := MS.DOMethod(mui.app, y.TAG(buffer,
                       MD.mmApplicationNewInput, y.ADR(signals)));
      IF (signals <> y.LONGSET{} ) AND (bh.typ = str.mensch) THEN signals := E.Wait(signals) END;
      CASE res OF
        MD.mvApplicationReturnIDQuit :
          running := FALSE
      | mui.newID :
          in.InitBrett (bh.brett);
          Beginnen (bh)
      | mui.player1ID:
          MM.get (mui.bgObj[0], MD.maCycleActive, y.ADR (result));
          IF result = 0 THEN
            IF weiss <> str.mensch THEN weiss := str.mensch; mutieren := TRUE END
          ELSIF weiss <> str.computer THEN weiss := str.computer; mutieren := TRUE
          END; (* IF *)
          IF bh.farbe = str.weiss THEN bh.typ := weiss END (* IF *)
      | mui.player2ID:
          MM.get (mui.bgObj[1], MD.maCycleActive, y.ADR (result));
          IF result = 0 THEN
            IF schwarz <> str.mensch THEN schwarz := str.mensch; mutieren := TRUE END
          ELSIF schwarz <> str.computer THEN schwarz := str.computer; mutieren := TRUE
          END; (* IF *)
          IF bh.farbe = str.schwarz THEN bh.typ := schwarz END (* IF *)
      | mui.modusID:
          MM.get (mui.modus, MD.maCycleActive, y.ADR (result));
          spielen := (result = 0)
      | 1..28:
          DEC (res);       (* 0 für MUI reserviert *)
          IF NOT spielen THEN (* modus setzen *)
            SteinUmsetzen (bh, res, first)
          ELSIF (bh.typ = str.mensch) AND NOT wechsel THEN      (* Userzugeingabe *)
            MenschZug (bh, res, first);
            IF first THEN
              IF NOT br.ZugUebrig (bh, history) THEN
                wechsel := TRUE; warten := trace;
                IF Bewerten (bh) THEN Beginnen (bh)
                ELSE Wechseln (bh)
                END (* IF *)
              END (* IF *)
            END (* IF *)
          END (* IF *)
      | mui.playID:
          warten := FALSE;
          IF bh.typ = str.mensch THEN  (* Computer soll Zug für Mensch berechnen *)
            WHILE bh.tiefe > 0 DO      (* Alle bisherigen Züge zurück *)
              z.Zurueck (bh)
            END; (* WHILE *)
            wechsel := TRUE; warten := TRUE;
            IF Berechnen (bh) THEN Beginnen (bh)
            ELSE Wechseln (bh)
            END (* IF *)
          END (* IF *)
      | mui.traceID:
          MM.get (mui.bgObj[2], MD.maCycleActive, y.ADR (result));
          IF result = 0 THEN trace := FALSE; warten := FALSE
          ELSE trace := TRUE; warten := TRUE
          END (* IF *)
      | mui.backID:
          Zurueck (bh)
      | mui.aboutID:
          About ()
      | mui.saveID:
          set.SaveSettings (y.ADR (set.envarcName));
          set.SaveSettings (y.ADR (set.envName))
      | mui.useID:
          set.SaveSettings (y.ADR (set.envName))
      | mui.loadID:
          set.LoadSettings (y.ADR (set.envName))
      | mui.saveAsID:
          set.SaveSettings (NIL)
      | mui.openID:
          set.LoadSettings (NIL)
      | mui.defaultID:
          in.Init ()
      | mui.lastSavedID:
          set.LoadSettings (y.ADR (set.envarcName))
      | mui.resetID:
          set.LoadSettings (y.ADR (set.envName))
      | mui.iconsID:
          MM.get (mui.itemIcons, MD.maMenuitemChecked, y.ADR (set.set.icons))
      | mui.whiteStonesID:
          MM.get (mui.bgObj[14], MD.maPendisplaySpec, y.ADR (result2));
          FOR x := 1 TO 24 DO
            MM.get (mui.brett[x], t.trWhite, y.ADR (result));
            IF result > 0 THEN
              MM.set (mui.brett[x], t.trStonePen, result2)
            END (* IF *)
          END (* FOR *)
      | mui.blackStonesID:
          MM.get (mui.bgObj[15], MD.maPendisplaySpec, y.ADR (result2));
          FOR x := 1 TO 24 DO
            MM.get (mui.brett[x], t.trBlack, y.ADR (result));
            IF result > 0 THEN
              MM.set (mui.brett[x], t.trStonePen, result2)
            END (* IF *)
          END (* FOR *)
      ELSE
      END (* CASE *)
    END (* WHILE *)
  END (* IF *)

END bg.


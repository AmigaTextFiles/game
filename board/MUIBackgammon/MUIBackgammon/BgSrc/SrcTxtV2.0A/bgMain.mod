IMPLEMENTATION MODULE bgMain;
(****h* Backgammon/bgMain *************************************************
*
*       NAME
*           bgMain
*
*       COPYRIGHT
*           © 1996, Marc Ewert
*
*       FUNCTION
*           Stellt Main Subclass zur Verfügung
*
*       AUTHOR
*           Marc Ewert
*
*       CREATION DATE
*           28.03.96
*
*       HISTORY
*           V1.00 - (..)
*                   * Erste Version
*
*       NOTES
*
************************************************************************************
*)

(*$ RangeChk := FALSE *)

IMPORT

  io  : InOut,
  a   : Arts,
  al  : AmigaLib,
  b   : bgBoard,
  e   : ExecD,
  E   : ExecL,
  g   : GraphicsD,
  G   : GraphicsL,
  gt  : GadToolsD,
  GM  : GfxMacros,
  h   : Heap,
  i   : IntuitionD,
  I   : IntuitionL,
  l   : bgLocale,
  MC  : MuiClasses,
  MCS : MuiClassSupport,
  MD  : MuiD,
  ML  : MuiL,
  MM  : MuiMacros,
  MS  : MuiSupport,
  mui : bgMui,
  (*p   : bgPreferences,*)
  u   : UtilityD,
  U   : UtilityL,
  s   : String,
  w   : bgWuerfeln,
  y   : SYSTEM,
  zi  : bgZiehen;

(*--------------------------------------------------------------------------------*)

CONST whiteStr = MD.mPenSpec{};
      blackStr = MD.mPenSpec{};
      startBoard = mui.Brett{0,-2,0,0,0,0,5,0,3,0,0,0,-5,5,0,0,0,-3,0,-5,0,0,0,0,2,0,0,0};

VAR character : mui.mCharacterPref;

(*---------------------------------------------------------------------------*)

PROCEDURE Bewerten (VAR bh : mui.BgHandle) : BOOLEAN;
(* Liefert Flag, ob jemand gewonnen hat *)

VAR bewertung : LONGINT;

BEGIN (* Bewerten *)

  (*bewertung := b.Bewerten (bh);
  (* ms.WriteTextInt (mui.rating, bewertung);*)
  IF bewertung >= b.Max THEN
    (* mui.AddText (l.GetString (l.MSG_WHITE_WINS)); *)
    RETURN TRUE
  ELSIF bewertung <= b.Min THEN
    (* mui.AddText (l.GetString (l.MSG_BLACK_WINS));*)
    (* PrintRestZuege (2, FALSE);*)      (* 0 ausgeben lassen *)
    RETURN TRUE
  END; (* IF *)
  *)
  RETURN FALSE

END Bewerten;

(*---------------------------------------------------------------------------*)
(* Main Class *)
(* Haupt Fenster von MUIBackgammon *)
(*---------------------------------------------------------------------------*)

TYPE MainDataPtr = POINTER TO MainData;
     MainData = RECORD
                  moves       : MD.APTR;
                  rating      : MD.APTR;
                  whiteTarget : MD.APTR;
                  blackTarget : MD.APTR;
                  text        : MD.APTR;
                  board       : MD.APTR;
                  pref        : MD.APTR;
                  bh          : mui.BgHandle
                END; (* RECORD *)

(*---------------------------------------------------------------------------*)
(*
PROCEDURE MainPref (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;
(* Legt PrefWindow an, wenn es noch nicht existiert, und öffnet es *)

VAR data : MainDataPtr;
    app  : MD.APTR;
    buffer : ARRAY [0..5] OF LONGINT;

BEGIN (* MainPref *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  IF data^.pref = NIL THEN
    app := mui.xget (obj, MD.maApplicationObject);
    data^.pref := I.NewObjectA (p.PrefWindowClass^.class, NIL, y.TAG (buffer,
                                mui.maPrefWindowPref, y.ADR (data^.bh.pref), u.tagEnd));
    MM.AddMember (app, data^.pref);
    MS.DoMethod (data^.pref, y.TAG (buffer, MD.mmNotify, MD.maWindowCloseRequest, TRUE, obj, 1, mui.mmMainClosePref))
  END; (* IF *)
  MM.set (data^.pref, MD.maWindowOpen, 1);
  RETURN 0

END MainPref;
*)
(*---------------------------------------------------------------------------*)

PROCEDURE MainClosePref (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;
(* Schliesst PrefWindow und gibt Speicher frei *)

VAR data : MainDataPtr;
    app  : MD.APTR;

BEGIN (* MainClosePref *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  IF data^.pref <> NIL THEN
    MM.set (data^.pref, MD.maWindowOpen, 0);
    app := mui.xget (obj, MD.maApplicationObject);
    MM.RemMember (app, data^.pref);
    ML.mDisposeObject (data^.pref);
    data^.pref := NIL;
  END; (* IF *)
  RETURN 0

END MainClosePref;

(*---------------------------------------------------------------------------*)

PROCEDURE MainNewPref (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;
(* Es wurden neue Preferences eingegeben *)

VAR data : MainDataPtr;
    pref : mui.mPrefWindowPrefPtr;

BEGIN (* MainNewPref *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  IF data^.pref <> NIL THEN
    pref := mui.xget (data^.pref, mui.maPrefWindowPref);

  END; (* IF *)
  RETURN 0

END MainNewPref;

(*---------------------------------------------------------------------------*)

PROCEDURE MainInit (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;
(* Initialisiert Einstellungen von MUIBackgammon *)

VAR data : MainDataPtr;
    buffer : ARRAY [0..1] OF LONGINT;

BEGIN (* MainInit *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  WITH data^.bh.pref DO
    player1        := 0;
    player2        := 1;
    trace          := 0;
    level          := 3;
    blink          := 2;
    blinkTime      := 15;
    boardType      := 0;
    whiteStones    := whiteStr;
    blackStones    := blackStr;
    whiteField     := whiteStr;
    blackField     := blackStr;
    whiteCharacter := character;
    blackCharacter := character
  END; (* WITH *)
  IF data^.pref <> NIL THEN
    mui.SetQuiet (data^.pref, mui.maPrefWindowPref, y.ADR (data^.bh.pref))
  END; (* IF *)
  RETURN 0

END MainInit;

(*---------------------------------------------------------------------------*)

PROCEDURE MainChange (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;
(* Spielerwechsel, hat jemand gewonnen? maMainPlayer setzen *)

VAR data : MainDataPtr;
    buffer : ARRAY [0..1] OF LONGINT;

BEGIN (* MainChange *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  IF Bewerten (data^.bh) THEN         (* Einer hat gewonnen *)
    MM.set (obj, mui.maMainStart, 1)
  ELSE
    MS.DoMethod (obj, y.TAG (buffer, mui.mmMainWuerfeln));
    (* PrintRestZuege (0, bh.wurf[1] = bh.wurf[2]); *)
    data^.bh.farbe := 3 - data^.bh.farbe;
    IF data^.bh.farbe = mui.weiss THEN
      (* mui.AddText (l.GetString (l.MSG_WHITE_GOES_ON));*)
      data^.bh.typ := mui.weiss
    ELSE
      (* mui.AddText (l.GetString (l.MSG_BLACK_GOES_ON));*)
      data^.bh.typ := mui.schwarz
    END; (* IF *)
    MM.set (obj, mui.maMainPlayer, data^.bh.typ)
  END; (* IF *)
  RETURN 0

END MainChange;

(*---------------------------------------------------------------------------*)

PROCEDURE MainStart (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;
(* Spieler auswürfeln und los gehts, setzt maMainPlayer *)

VAR data : MainDataPtr;
    buffer : ARRAY [0..1] OF LONGINT;

BEGIN (* MainStart *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  LOOP
    MS.DoMethod (obj, y.TAG (buffer, mui.mmMainWuerfeln));
    IF data^.bh.wurf[1] < data^.bh.wurf[2] THEN
      (* mui.AddText (l.GetString (l.MSG_Black_Begins));*)
      data^.bh.farbe := mui.schwarz; data^.bh.typ := mui.schwarz;
      EXIT
    ELSIF data^.bh.wurf[1] > data^.bh.wurf[2] THEN
      (* mui.AddText (l.GetString (l.MSG_White_Begins));*)
      data^.bh.farbe := mui.weiss; data^.bh.typ := mui.weiss;
      EXIT
    END (* IF *)
  END; (* LOOP *)
  (* PrintRestZuege (0, bh.wurf[1] = bh.wurf[2]); *)
  data^.bh.brett := startBoard;
  MS.DoMethod (data^.board, y.TAG (buffer, mui.mmBoardShow, y.ADR (startBoard)));
  MM.set (obj, mui.maMainPlayer, data^.bh.typ);

  RETURN 0

END MainStart;

(*---------------------------------------------------------------------------*)

PROCEDURE MainWuerfeln (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;
(* Wuerfeln *)

VAR data : MainDataPtr;
    buffer : ARRAY [0..1] OF LONGINT;

BEGIN (* MainWuerfeln *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  w.Wuerfeln (data^.bh.wurf);
  RETURN 0

END MainWuerfeln;

(*---------------------------------------------------------------------------*)

PROCEDURE MainPlayer (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;
(* Es wurde ein neuer Spieler gesetzt *)

VAR data : MainDataPtr;
    buffer : ARRAY [0..1] OF LONGINT;

BEGIN (* MainPlayer *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)

  RETURN 0

END MainPlayer;

(*---------------------------------------------------------------------------*)

PROCEDURE MainSet ( cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr ) : y.ADDRESS;

VAR data      : MainDataPtr;
    tags, tag : u.TagItemPtr;
    dummy     : MD.APTR;

BEGIN (* MainSet *)

  data := MC.InstData (cl, obj);
  IF data <> NIL THEN
    tags := msg^.attrList;
    IF tags <> NIL THEN
      REPEAT
        tag := U.NextTagItem (tags);
        IF tag <> NIL THEN
          CASE tag^.tag OF
            (* ma : data^. := tag^.data *)
          ELSE
          END (* CASE *)
        END (* IF *)
      UNTIL tag = NIL
    END (* IF *)
  END; (* IF *)
  RETURN al.DoSuperMethodA (cl, obj, msg)

END MainSet;

(*--------------------------------------------------------------------------------*)

PROCEDURE MainGet (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpGetPtr) : y.ADDRESS;

VAR data  : MainDataPtr;
    store : mui.LongCardPtr;

BEGIN (* MainGet *)

  data := MC.InstData (cl, obj);
  IF data <> NIL THEN
    store := y.CAST (mui.LongCardPtr, msg^.storage);
    CASE msg^.attrID OF
      (* ma : store^ := data^.; RETURN 1 *)
    ELSE
    END (* CASE *)
  END; (* IF *)
  RETURN al.DoSuperMethodA(cl, obj, msg)

END MainGet ;

(*---------------------------------------------------------------------------*)

VAR modeStrs : ARRAY [0..2] OF MM.STRPTR;
    textStrs : ARRAY [0..1] OF MM.STRPTR;
    tmp      := MainData{};

PROCEDURE MainNew (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR buffer, buffer2 : ARRAY [0..20] OF LONGINT;
    data            : MainDataPtr;
    play, new, back : MD.APTR;
    pref, mode, grp : MD.APTR;
    prefs           : mui.mPrefWindowPrefPtr;

BEGIN (* MainNew *)

  (*prefs := y.CAST (mui.mPrefWindowPrefPtr, U.GetTagData (mui.maMainPref, NIL, msg^.attrList));
  IF prefs <> NIL THEN tmp.bh.pref := prefs^
  ELSE (* MS.DoMethod (obj, y.TAG (buffer, mui.mmMainInit)) *)
  END; (* IF *)
  *)

  tmp.text := MM.ListviewObject (y.TAG (buffer,
                 MD.maListviewInput, FALSE,
                 MD.maListviewList, MM.ListObject (y.TAG (buffer2,
                                      MD.maListConstructHook, MD.mvListConstructHookString,
                                      MD.maListDestructHook, MD.mvListDestructHookString,
                                      MD.maFrame, MD.mvFrameReadList,
                                      MD.maBackground, MD.miReadListBack,
                                      MD.maListSourceArray, y.ADR (textStrs),
                                      MD.maListAdjustWidth, TRUE,
                                    u.tagEnd)),
               u.tagEnd));

  play := mui.MakeButton (l.MSG_PLAY);
  new := mui.MakeButton (l.MSG_NEW);
  back := mui.MakeButton (l.MSG_BACK);
  mode := mui.MakeCycle (l.MSG_MODE, y.ADR (modeStrs));
  tmp.moves := MM.TextObject (y.TAG (buffer, MD.maFrame, MD.mvFrameText, MD.maBackground, MD.miTextBack, u.tagEnd));
  tmp.rating := MM.TextObject (y.TAG (buffer, MD.maFrame, MD.mvFrameText, MD.maBackground, MD.miTextBack, u.tagEnd));
  tmp.whiteTarget := MM.TextObject (y.TAG (buffer, MD.maFrame, MD.mvFrameText, MD.maBackground, MD.miTextBack, u.tagEnd));
  tmp.blackTarget := MM.TextObject (y.TAG (buffer, MD.maFrame, MD.mvFrameText, MD.maBackground, MD.miTextBack, u.tagEnd));
  pref := mui.MakeButton (l.MSG_PREFERENCES);

  tmp.board := I.NewObjectA (b.BoardClass^.class, NIL, y.TAG (buffer,
                               mui.maBoardType, 0, u.tagEnd));

  grp := MM.VGroup (y.TAG(buffer,
           MD.maBackground, MD.miGroupBack,
           MM.Child, MM.HGroup (y.TAG (buffer2,
                       MM.Child, play,
                       MM.Child, new,
                       MM.Child, back,
                     u.tagEnd)),
           MM.Child, pref,
           MM.Child, MM.ColGroup (2, y.TAG (buffer2,
                       MM.Child, mui.MakeLabel1 (l.MSG_MODE),
                       MM.Child, mode,
                     u.tagEnd)),
           MM.Child, MM.ColGroup (2, y.TAG (buffer2,
                       MM.Child, mui.MakeLabel2 (l.MSG_MOVES),
                       MM.Child, tmp.moves,
                       MM.Child, mui.MakeLabel2 (l.MSG_RATING),
                       MM.Child, tmp.rating,
                       MM.Child, mui.MakeLabel2 (l.MSG_WHITE_TARGET),
                       MM.Child, tmp.whiteTarget,
                       MM.Child, mui.MakeLabel2 (l.MSG_BLACK_TARGET),
                       MM.Child, tmp.blackTarget,
                     u.tagEnd)),
           MM.Child, tmp.text,
         u.tagEnd));

  obj := MCS.DoSuperNew (cl, obj, y.TAG (buffer,
            MD.maWindowTitle, y.ADR ("MUIBackgammon © 1996, Marc Ewert"),
            MD.maWindowID, MM.MakeID ("MAIN"),
            MD.maBackground, MD.miWindowBack,
            MM.WindowContents,
            MM.HGroup (y.TAG (buffer2,
              MM.Child, tmp.board,
              MM.Child, grp,
            u.tagEnd)),
         u.tagEnd));

  IF obj <> NIL THEN
    data := MC.InstData (cl, obj);
    data^ := tmp;
    (*MS.DoMethod (pref, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 1, mui.mmMainPref));
    MS.DoMethod (new, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 1, mui.mmMainInit));*)
  END; (* IF *)
  RETURN obj

END MainNew;

(*---------------------------------------------------------------------------*)

PROCEDURE MainDispatcher (cl : i.IClassPtr; obj : y.ADDRESS; msg : y.ADDRESS) : y.ADDRESS;

VAR methodID : LONGCARD;

BEGIN (* MainDispatcher *)

  methodID := y.CAST (i.Msg, msg)^.methodID;
  IF    methodID = i.omNEW THEN RETURN MainNew (cl, obj, msg)
  (*ELSIF methodID = i.omSET THEN RETURN MainSet (cl, obj, msg)
  ELSIF methodID = i.omGET THEN RETURN MainGet (cl, obj, msg)*)
  ELSE RETURN al.DoSuperMethodA (cl, obj, msg)
  END (* IF *)

END MainDispatcher;


VAR NULL : MD.APTR;
    elem : mui.mCharacterElem;

BEGIN (* bgMain *)

  NULL := NIL;
  IF NOT MCS.InitClass (MainClass, NIL, y.ADR (MD.mcWindow), NIL, SIZE(MainData), MainDispatcher) THEN
    MS.fail (NULL, "Could not create custom class.")
  END; (* IF *)
  FOR elem := MIN (mui.mCharacterElem) TO MAX (mui.mCharacterElem) DO
    character.character[1,elem] := 5;
    character.character[2,elem] := 5
  END; (* FOR *)
  character.com[0] := 0C;

  modeStrs[0] := l.GetString (l.MSG_PLAY_2);
  modeStrs[1] := l.GetString (l.MSG_SET);
  modeStrs[2] := NIL;

  textStrs[0] := l.GetString (l.MSG_WELCOME);
  textStrs[1] := NIL;

CLOSE

  IF MainClass <> NIL THEN MCS.RemoveClass (MainClass)
  END (* IF *)

END bgMain.


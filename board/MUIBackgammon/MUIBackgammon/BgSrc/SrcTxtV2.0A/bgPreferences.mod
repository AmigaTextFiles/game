IMPLEMENTATION MODULE bgPreferences;
(****h* Backgammon/bgPreferences *************************************************
*
*       NAME
*           bgPreferences
*
*       COPYRIGHT
*           © 1996, Marc Ewert
*
*       FUNCTION
*           Stellt das Preferences Window Objekt zur Verfügung
*
*       AUTHOR
*           Marc Ewert
*
*       CREATION DATE
*           18.03.96
*
*       HISTORY
*           V1.00 - (11.03.96)
*                   * Erste Version
*
*       NOTES
*
************************************************************************************
*)

(*$ RangeChk := FALSE *)

IMPORT

  al  : AmigaLib,
  d   : DosD,
  D   : DosL,
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
  u   : UtilityD,
  U   : UtilityL,
  s   : String,
  y   : SYSTEM;

(*---------------------------------------------------------------------------*)
(* Character Class *)
(* VGroup zum Einstellen des Characters eines Spielers *)
(*---------------------------------------------------------------------------*)

TYPE CharacterDataPtr = POINTER TO CharacterData;
     CharacterData = RECORD
                       white : LONGINT;     (* Character für Weiss? *)
                       num   : ARRAY [1..2], mui.mCharacterElem OF MD.APTR;
                       com   : MD.APTR;
                       pref  : mui.mCharacterPref
                     END; (* RECORD *)

(*--------------------------------------------------------------------------------*)

PROCEDURE CharacterLoad (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR datei  : d.FileHandlePtr;
    data   : CharacterDataPtr;
    name   : mui.StrPtr;
    buffer : ARRAY [0..1] OF LONGINT;
    pref   : mui.mCharacterPref;

BEGIN (* CharacterLoad *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  name := mui.GetFileName (obj, l.MSG_LOAD_FILE, y.ADR ("#?.car"), FALSE);
  IF name <> NIL THEN
    IF mui.OpenPref (obj, datei, name, MM.MakeID ("MBCA"), 1, TRUE) THEN
      IF mui.Read (obj, datei, y.ADR (pref), SIZE (mui.mCharacterPref)) = SIZE (mui.mCharacterPref) THEN
        MM.set (obj, mui.maCharacterPref, y.ADR (pref))
      END; (* IF *)
      D.Close (datei)
    END (* IF *)
  END; (* IF *)
  RETURN 0

END CharacterLoad;

(*--------------------------------------------------------------------------------*)

PROCEDURE CharacterSave (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR datei : d.FileHandlePtr;
    data  : CharacterDataPtr;
    name  : mui.StrPtr;
    pref  : mui.mCharacterPrefPtr;

BEGIN (* CharacterSave *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  name := mui.GetFileName (obj, l.GetString (l.MSG_SAVE_FILE), y.ADR ("#?.car"), TRUE);
  IF name <> NIL THEN
    pref := mui.xget (obj, mui.maCharacterPref);
    IF pref <> NIL THEN
      IF mui.OpenPref (obj, datei, name, MM.MakeID ("MBCA"), 1, TRUE) THEN
        IF mui.Write (obj, datei, pref, SIZE (mui.mCharacterPref)) = SIZE (mui.mCharacterPref) THEN
        END; (* IF *)
        D.Close (datei); RETURN 1
      END (* IF *)
    END (* IF *)
  END; (* IF *)
  RETURN 0

END CharacterSave;

(*---------------------------------------------------------------------------*)

PROCEDURE CharacterCopy (cl : i.IClassPtr; obj : i.ObjectPtr; msg : mui.mpCharacterCopyPtr) : y.ADDRESS;

VAR data : CharacterDataPtr;
    elem : mui.mCharacterElem;

BEGIN (* CharacterCopy *)

  data := MC.InstData (cl, obj);
  IF data <> NIL THEN
    IF msg^.source = mui.mvCharacterCopyLeft THEN
      FOR elem := MIN (mui.mCharacterElem) TO MAX (mui.mCharacterElem) DO
        data^.pref.character[2,elem] := data^.pref.character[1,elem]
      END (* FOR *)
    ELSIF msg^.source = mui.mvCharacterCopyRight THEN
      FOR elem := MIN (mui.mCharacterElem) TO MAX (mui.mCharacterElem) DO
        data^.pref.character[1,elem] := data^.pref.character[2,elem]
      END (* FOR *)
    END; (* IF *)
    MM.set (obj, mui.maCharacterPref, y.ADR (data^.pref))
  END; (* IF *)
  RETURN NIL

END CharacterCopy;

(*---------------------------------------------------------------------------*)

PROCEDURE CharacterSet (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR data      : CharacterDataPtr;
    tags, tag : u.TagItemPtr;
    dummy     : MD.APTR;
    pref      : mui.mCharacterPrefPtr;
    elem      : mui.mCharacterElem;

BEGIN (* CharcterSet *)

  data := MC.InstData (cl, obj);
  IF data <> NIL THEN
    tags := msg^.attrList;
    IF tags <> NIL THEN
      REPEAT
        tag := U.NextTagItem (tags);
        IF tag <> NIL THEN
          CASE tag^.tag OF
            mui.maCharacterPref :
              pref := y.CAST (mui.mCharacterPrefPtr, tag^.data);
              IF pref <> NIL THEN
                FOR elem := MIN (mui.mCharacterElem) TO MAX (mui.mCharacterElem) DO
                  mui.SetQuiet (data^.num[1,elem], MD.maNumericValue, pref^.character[1,elem]);
                  mui.SetQuiet (data^.num[2,elem], MD.maNumericValue, pref^.character[2,elem])
                END; (* FOR *)
                mui.SetQuiet (data^.com, MD.maStringContents, y.ADR (pref^.com));
              END (* IF *)
          ELSE
          END (* CASE *)
        END (* IF *)
      UNTIL tag = NIL
    END (* IF *)
  END; (* IF *)
  RETURN al.DoSuperMethodA (cl, obj, msg)

END CharacterSet;

(*--------------------------------------------------------------------------------*)

PROCEDURE CharacterGet (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpGetPtr) : y.ADDRESS;

VAR data   : CharacterDataPtr;
    store  : mui.LongCardPtr;
    string : mui.StrPtr;
    elem   : mui.mCharacterElem;

BEGIN (* CharacterGet *)

  data := MC.InstData (cl, obj);
  IF data <> NIL THEN
    store := y.CAST (mui.LongCardPtr, msg^.storage);
    CASE msg^.attrID OF
      mui.maCharacterPref:
        FOR elem := MIN (mui.mCharacterElem) TO MAX (mui.mCharacterElem) DO
          data^.pref.character[1,elem] := mui.xget (data^.num[1,elem], MD.maNumericValue);
          data^.pref.character[1,elem] := mui.xget (data^.num[2,elem], MD.maNumericValue)
        END; (* FOR *)
        string := mui.xget (data^.com, MD.maStringContents);
        IF s.CanCopy (data^.pref.com, string^) THEN
          s.Copy (data^.pref.com, string^)
        END; (* IF *)
        store^ := y.ADR (data^.pref); RETURN 1
    ELSE
    END (* CASE *)
  END; (* IF *)
  RETURN al.DoSuperMethodA(cl, obj, msg)

END CharacterGet ;

(*---------------------------------------------------------------------------*)

PROCEDURE CharacterNew (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR data                : CharacterDataPtr;
    save, use, load     : MD.APTR;
    leftCopy, rightCopy : MD.APTR;
    farbe               : CARDINAL;
    elem                : mui.mCharacterElem;
    head1, head2        : y.ADDRESS;
    pref                : mui.mCharacterPrefPtr;
    buffer, buffer2     : ARRAY [0..20] OF LONGINT;
    buffer3             : ARRAY [0..42] OF LONGINT;

BEGIN (* CharacterNew *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)

  data^.white := U.GetTagData (mui.maCharacterColour, mui.mvCharacterColourWhite, msg^.attrList);

  IF data^.white = mui.mvCharacterColourWhite THEN
    head1 := l.GetString (l.MSG_WHITE); head2 := l.GetString (l.MSG_BLACK)
  ELSE
    head1 := l.GetString (l.MSG_BLACK); head2 := l.GetString (l.MSG_WHITE)
  END; (* IF *)

  save := mui.MakeButton (l.MSG_SAVE_2);
  use := mui.MakeButton (l.MSG_USE);
  load := mui.MakeButton (l.MSG_LOAD);
  leftCopy := mui.MakeButton (l.MSG_LEFT_COPY);
  rightCopy := mui.MakeButton (l.MSG_RIGHT_COPY);
  FOR farbe := 1 TO 2 DO
    data^.num[farbe,mui.bar] := mui.MakeNumericButton (l.MSG_BAR, 0, 100);
    data^.num[farbe,mui.single] := mui.MakeNumericButton (l.MSG_SINGLE, 0, 100);
    data^.num[farbe,mui.singleProb] := mui.MakeNumericButton (l.MSG_SINGLE_PROB, 0, 100);
    data^.num[farbe,mui.distance] := mui.MakeNumericButton (l.MSG_DISTANCE, 0, 100);
    data^.num[farbe,mui.six] := mui.MakeNumericButton (l.MSG_SIX, 0, 100);
    data^.num[farbe,mui.block] := mui.MakeNumericButton (l.MSG_BLOCK, 0, 100);
    data^.num[farbe,mui.target] := mui.MakeNumericButton (l.MSG_TARGET, 0, 100);
    data^.num[farbe,mui.home] := mui.MakeNumericButton (l.MSG_HOME, 0, 100);
    data^.num[farbe,mui.distribution] := mui.MakeNumericButton (l.MSG_DISTRIBUTION, 0, 100)
  END; (* FOR *)
  data^.com := mui.MakeString (-1, 30);

  obj := MCS.DoSuperNew (cl, obj, y.TAG (buffer,
            MD.maBackground, MD.miGroupBack,
            MD.maFrame, MD.mvFrameGroup,
            MM.Child, data^.com,
            MM.Child, MM.HGroup (y.TAG (buffer2,
                        MM.Child, MM.ColGroup (4, y.TAG (buffer3,
                                    MD.maFrame, MD.mvFrameGroup,
                                    MD.maFrameTitle, head1,
                                    MM.Child, mui.MakeLabel1 (l.MSG_BAR), MM.Child, data^.num[1,mui.bar],
                                    MM.Child, mui.MakeLabel1 (l.MSG_SINGLE), MM.Child, data^.num[1,mui.single],
                                    MM.Child, mui.MakeLabel1 (l.MSG_SINGLE_PROB), MM.Child, data^.num[1,mui.singleProb],
                                    MM.Child, mui.MakeLabel1 (l.MSG_DISTANCE), MM.Child, data^.num[1,mui.distance],
                                    MM.Child, mui.MakeLabel1 (l.MSG_SIX), MM.Child, data^.num[1,mui.six],
                                    MM.Child, mui.MakeLabel1 (l.MSG_BLOCK), MM.Child, data^.num[1,mui.block],
                                    MM.Child, mui.MakeLabel1 (l.MSG_TARGET), MM.Child, data^.num[1,mui.target],
                                    MM.Child, mui.MakeLabel1 (l.MSG_HOME), MM.Child, data^.num[1,mui.home],
                                    MM.Child, mui.MakeLabel1 (l.MSG_DISTRIBUTION), MM.Child, data^.num[1,mui.distribution],
                                  u.tagEnd)),
                        MM.Child, MM.ColGroup (4, y.TAG (buffer3,
                                    MD.maFrame, MD.mvFrameGroup,
                                    MD.maFrameTitle, head1,
                                    MM.Child, mui.MakeLabel1 (l.MSG_BAR), MM.Child, data^.num[2,mui.bar],
                                    MM.Child, mui.MakeLabel1 (l.MSG_SINGLE), MM.Child, data^.num[2,mui.single],
                                    MM.Child, mui.MakeLabel1 (l.MSG_SINGLE_PROB), MM.Child, data^.num[2,mui.singleProb],
                                    MM.Child, mui.MakeLabel1 (l.MSG_DISTANCE), MM.Child, data^.num[2,mui.distance],
                                    MM.Child, mui.MakeLabel1 (l.MSG_SIX), MM.Child, data^.num[2,mui.six],
                                    MM.Child, mui.MakeLabel1 (l.MSG_BLOCK), MM.Child, data^.num[2,mui.block],
                                    MM.Child, mui.MakeLabel1 (l.MSG_TARGET), MM.Child, data^.num[2,mui.target],
                                    MM.Child, mui.MakeLabel1 (l.MSG_HOME), MM.Child, data^.num[2,mui.home],
                                    MM.Child, mui.MakeLabel1 (l.MSG_DISTRIBUTION), MM.Child, data^.num[2,mui.distribution],
                                  u.tagEnd)),
                      u.tagEnd)),
            MM.Child, MM.HGroup (y.TAG (buffer2,
                        MM.Child, save,
                        MM.Child, leftCopy,
                        MM.Child, rightCopy,
                        MM.Child, load,
                      u.tagEnd)),
         u.tagEnd));

  IF obj <> NIL THEN
    MS.DoMethod (save, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 1, mui.mmCharacterSave));
    MS.DoMethod (load, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 1, mui.mmCharacterLoad));
    MS.DoMethod (leftCopy, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 2, mui.mmCharacterCopy, mui.mvCharacterCopyLeft));
    MS.DoMethod (rightCopy, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 2, mui.mmCharacterCopy, mui.mvCharacterCopyRight));
    MS.DoMethod (data^.com, y.TAG (buffer, MD.mmNotify, MD.maStringAcknowledge, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maCharacterChange, 1));
    FOR farbe := 1 TO 2 DO
      FOR elem := MIN (mui.mCharacterElem) TO MAX (mui.mCharacterElem) DO
        MS.DoMethod (data^.num[farbe,elem], y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maCharacterChange, 1))
      END (* FOR *)
    END; (* FOR *)
    pref := y.CAST (mui.mCharacterPrefPtr, U.GetTagData (mui.maCharacterPref, NIL, msg^.attrList));
    IF pref <> NIL THEN mui.SetQuiet (obj, mui.maCharacterPref, LONGINT (pref))
    END (* IF *)
  END; (* IF *)
  RETURN obj

END CharacterNew;

(*---------------------------------------------------------------------------*)

PROCEDURE CharacterDispatcher (cl : i.IClassPtr; obj : y.ADDRESS; msg : y.ADDRESS) : y.ADDRESS;

VAR methodID : LONGCARD;

BEGIN (* CharacterDispatcher *)

  methodID := y.CAST (i.Msg, msg)^.methodID;
  IF    methodID = i.omNEW             THEN RETURN CharacterNew (cl, obj, msg)
  ELSIF methodID = i.omSET             THEN RETURN CharacterSet (cl, obj, msg)
  ELSIF methodID = i.omGET             THEN RETURN CharacterGet (cl, obj, msg)
  ELSIF methodID = mui.mmCharacterLoad THEN RETURN CharacterLoad (cl, obj, msg)
  ELSIF methodID = mui.mmCharacterSave THEN RETURN CharacterSave (cl, obj, msg)
  ELSIF methodID = mui.mmCharacterCopy THEN RETURN CharacterCopy (cl, obj, msg)
  ELSE RETURN al.DoSuperMethodA (cl, obj, msg)
  END (* IF *)

END CharacterDispatcher;

(*---------------------------------------------------------------------------*)
(* PrefWindow Class *)
(* Window zum Konfigurieren von MUIBackgammon *)
(*---------------------------------------------------------------------------*)

TYPE PrefWindowDataPtr = POINTER TO PrefWindowData;
     PrefWindowData = RECORD
                        player1, player2 : MD.APTR;
                        trace            : MD.APTR;
                        level            : MD.APTR;
                        blink, blinkTime : MD.APTR;
                        boardType        : MD.APTR;
                        whiteStones      : MD.APTR;
                        blackStones      : MD.APTR;
                        whiteField       : MD.APTR;
                        blackField       : MD.APTR;
                        whiteCharacter   : MD.APTR;
                        blackCharacter   : MD.APTR;
                        pref             : mui.mPrefWindowPref
                      END; (* RECORD *)

(*---------------------------------------------------------------------------*)

PROCEDURE PrefWindowLoad (cl : i.IClassPtr; obj : i.ObjectPtr; msg : mui.mpPrefWindowLoadPtr) : y.ADDRESS;

VAR data  : PrefWindowDataPtr;
    pref  : mui.mPrefWindowPref;
    name  : mui.StrPtr;
    datei : d.FileHandlePtr;

BEGIN (* PrefWindowLoad *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  name := msg^.name;
  IF name = NIL THEN
    name := mui.GetFileName (obj, l.GetString (l.MSG_LOAD_FILE), y.ADR ("#?.pref"), FALSE)
  END; (* IF *)
  IF name <> NIL THEN
    IF mui.OpenPref (obj, datei, name, MM.MakeID ("MBPR"), 1, TRUE) THEN
      IF mui.Read (obj, datei, y.ADR (pref), SIZE (mui.mPrefWindowPref)) = SIZE (mui.mPrefWindowPref) THEN
        MM.set (obj, mui.maPrefWindowPref, y.ADR (pref))
      END; (* IF *)
      D.Close (datei)
    END (* IF *)
  END; (* IF *)
  RETURN 0

END PrefWindowLoad;

(*--------------------------------------------------------------------------------*)

PROCEDURE PrefWindowSave (cl : i.IClassPtr; obj : i.ObjectPtr; msg : mui.mpPrefWindowSavePtr) : y.ADDRESS;

VAR data  : PrefWindowDataPtr;
    pref  : mui.mPrefWindowPrefPtr;
    name  : mui.StrPtr;
    datei : d.FileHandlePtr;

BEGIN (* PrefWindowSave *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  name := msg^.name;
  IF name = NIL THEN
    name := mui.GetFileName (obj, l.GetString (l.MSG_SAVE_FILE), y.ADR ("#?.pref"), TRUE)
  END; (* IF *)
  IF name <> NIL THEN
    pref := mui.xget (obj, mui.maPrefWindowPref);
    IF pref <> NIL THEN
      IF mui.OpenPref (obj, datei, name, MM.MakeID ("MBPR"), 1, TRUE) THEN
        IF mui.Write (obj, datei, pref, SIZE (mui.mPrefWindowPref)) = SIZE (mui.mPrefWindowPref) THEN
        END; (* IF *)
        D.Close (datei)
      END (* IF *)
    END (* IF *)
  END; (* IF *)
  RETURN 0

END PrefWindowSave;

(*--------------------------------------------------------------------------------*)

PROCEDURE PrefWindowSet ( cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr ) : y.ADDRESS;

VAR data      : PrefWindowDataPtr;
    tags, tag : u.TagItemPtr;
    dummy     : MD.APTR;
    pref      : mui.mPrefWindowPrefPtr;

BEGIN (* PrefWindowSet *)

  data := MC.InstData (cl, obj);
  IF data <> NIL THEN
    tags := msg^.attrList;
    IF tags <> NIL THEN
      REPEAT
        tag := U.NextTagItem (tags);
        IF tag <> NIL THEN
          CASE tag^.tag OF
            mui.maPrefWindowPref:
              pref := y.CAST (mui.mPrefWindowPrefPtr, tag^.data);
              IF pref <> NIL THEN
                mui.SetQuiet (data^.player1, MD.maCycleActive, pref^.player1);
                mui.SetQuiet (data^.player2, MD.maCycleActive, pref^.player2);
                mui.SetQuiet (data^.trace, MD.maCycleActive, pref^.trace);
                mui.SetQuiet (data^.level, MD.maNumericValue, pref^.level);
                mui.SetQuiet (data^.blink, MD.maNumericValue, pref^.blink);
                mui.SetQuiet (data^.blinkTime, MD.maNumericValue, pref^.blinkTime);
                mui.SetQuiet (data^.boardType, MD.maNumericValue, pref^.boardType);
                mui.SetQuiet (data^.whiteStones, MD.maPendisplaySpec, y.ADR (pref^.whiteStones));
                mui.SetQuiet (data^.blackStones, MD.maPendisplaySpec, y.ADR (pref^.blackStones));
                mui.SetQuiet (data^.whiteField, MD.maPendisplaySpec, y.ADR (pref^.whiteField));
                mui.SetQuiet (data^.blackField, MD.maPendisplaySpec, y.ADR (pref^.blackField));
                mui.SetQuiet (data^.whiteCharacter, mui.maCharacterPref, y.ADR (pref^.whiteCharacter));
                mui.SetQuiet (data^.blackCharacter, mui.maCharacterPref, y.ADR (pref^.blackCharacter))
              END (* IF *)
          ELSE
          END (* CASE *)
        END (* IF *)
      UNTIL tag = NIL
    END (* IF *)
  END; (* IF *)
  RETURN al.DoSuperMethodA (cl, obj, msg)

END PrefWindowSet;

(*--------------------------------------------------------------------------------*)

PROCEDURE PrefWindowGet (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpGetPtr) : y.ADDRESS;

VAR data  : PrefWindowDataPtr;
    store : mui.LongCardPtr;
    pen   : MD.mPenSpecPtr;
    character : mui.mCharacterPrefPtr;

BEGIN (* PrefWindowGet *)

  data := MC.InstData (cl, obj);
  IF data <> NIL THEN
    store := y.CAST (mui.LongCardPtr, msg^.storage);
    CASE msg^.attrID OF
      mui.maPrefWindowPref :
        data^.pref.player1 := mui.xget (data^.player1, MD.maCycleActive);
        data^.pref.player2 := mui.xget (data^.player2, MD.maCycleActive);
        data^.pref.trace := mui.xget (data^.trace, MD.maCycleActive);
        data^.pref.level := mui.xget (data^.level, MD.maNumericValue);
        data^.pref.blink := mui.xget (data^.blink, MD.maNumericValue);
        data^.pref.blinkTime := mui.xget (data^.blinkTime, MD.maNumericValue);
        data^.pref.boardType := mui.xget (data^.boardType, MD.maNumericValue);

        pen := mui.xget (data^.whiteStones, MD.maPendisplaySpec);
        data^.pref.whiteStones := pen^;
        pen := mui.xget (data^.blackStones, MD.maPendisplaySpec);
        data^.pref.blackStones := pen^;
        pen := mui.xget (data^.whiteField, MD.maPendisplaySpec);
        data^.pref.whiteField := pen^;
        pen := mui.xget (data^.blackField, MD.maPendisplaySpec);
        data^.pref.blackField := pen^;

        character := mui.xget (data^.whiteCharacter, mui.maCharacterPref);
        data^.pref.whiteCharacter := character^;
        character := mui.xget (data^.blackCharacter, mui.maCharacterPref);
        data^.pref.blackCharacter := character^;
        store^ := y.ADR (data^.pref); RETURN 1
    ELSE
    END (* CASE *)
  END; (* IF *)
  RETURN al.DoSuperMethodA(cl, obj, msg)

END PrefWindowGet ;

(*---------------------------------------------------------------------------*)

PROCEDURE PrefWindowNew (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR data                             : PrefWindowDataPtr;
    save, use, load                  : MD.APTR;
    general, board, ai               : MD.APTR;
    regTitles                        : ARRAY [0..3] OF mui.StrPtr;
    aiRegTitles, playerArr, traceArr : ARRAY [0..2] OF mui.StrPtr;
    buffer, buffer2                  : ARRAY [0..32] OF LONGINT;

BEGIN (* PrefWindowNew *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  regTitles[0] := l.GetString (l.MSG_GENERAL);
  regTitles[1] := l.GetString (l.MSG_BOARD);
  regTitles[2] := l.GetString (l.MSG_AI);
  regTitles[3] := NIL;

  aiRegTitles[0] := l.GetString (l.MSG_WHITE);
  aiRegTitles[1] := l.GetString (l.MSG_BLACK);
  aiRegTitles[2] := NIL;

  playerArr[0] := l.GetString (l.MSG_HUMAN);
  playerArr[1] := l.GetString (l.MSG_COMPUTER);
  playerArr[2] := NIL;

  traceArr[0] := l.GetString (l.MSG_OFF);
  traceArr[1] := l.GetString (l.MSG_ON);
  traceArr[2] := NIL;

  data^.player1 := mui.MakeCycle (l.MSG_PLAYER_1, y.ADR (playerArr));
  data^.player2 := mui.MakeCycle (l.MSG_PLAYER_2, y.ADR (playerArr));
  data^.trace := mui.MakeCycle (l.MSG_TRACE, y.ADR (traceArr));
  data^.level := mui.MakeSlider (l.MSG_LEVEL, 1, 4);
  data^.blink := mui.MakeNumericButton (l.MSG_BLINK, 0, 100);
  data^.blinkTime := mui.MakeNumericButton (l.MSG_BLINK_TIME, 0, 100);
  data^.boardType := mui.MakeNumericButton (l.MSG_BOARD_TYPE, 0, 3);
  save := mui.MakeButton (l.MSG_SAVE);
  load := mui.MakeButton (l.MSG_LOAD);
  use := mui.MakeButton (l.MSG_USE);
  data^.whiteField := ML.mNewObject (y.ADR (MD.mcPoppen), y.TAG (buffer,
               MD.maCycleChain, 1, MD.maWindowTitle, l.GetString (14), u.tagDone));
  data^.blackField := ML.mNewObject (y.ADR (MD.mcPoppen), y.TAG (buffer,
               MD.maCycleChain, 1, MD.maWindowTitle, l.GetString (15), u.tagDone));
  data^.whiteStones := ML.mNewObject (y.ADR (MD.mcPoppen), y.TAG (buffer,
               MD.maCycleChain, 1, MD.maWindowTitle, l.GetString (16), u.tagDone));
  data^.blackStones := ML.mNewObject (y.ADR (MD.mcPoppen), y.TAG (buffer,
               MD.maCycleChain, 1, MD.maWindowTitle, l.GetString (17), u.tagDone));

  general := MM.ColGroup(2, y.TAG(buffer,
                MD.maFrame, MD.mvFrameGroup,
                MD.maFrameTitle, l.GetString (l.MSG_GENERAL),
                MM.Child, mui.MakeLabel1 (l.MSG_PLAYER_1), MM.Child, data^.player1,
                MM.Child, mui.MakeLabel1 (l.MSG_PLAYER_2), MM.Child, data^.player2,
                MM.Child, mui.MakeLabel1 (l.MSG_TRACE), MM.Child, data^.trace,
                MM.Child, mui.MakeLabel1 (l.MSG_LEVEL), MM.Child, data^.level,
              u.tagEnd));
  board := MM.ColGroup(2, y.TAG(buffer,
             MD.maFrame, MD.mvFrameGroup,
             MD.maFrameTitle, l.GetString (l.MSG_BOARD),
             MM.Child, mui.MakeLabel1 (l.MSG_BLINK), MM.Child, data^.blink,
             MM.Child, mui.MakeLabel1 (l.MSG_BLINK_TIME), MM.Child, data^.blinkTime,
             MM.Child, mui.MakeLabel1 (l.MSG_BOARD_TYPE), MM.Child, data^.boardType,
             MM.Child, mui.MakeLabel1 (l.MSG_WHITE_STONE), MM.Child, data^.whiteStones,
             MM.Child, mui.MakeLabel1 (l.MSG_BLACK_STONE), MM.Child, data^.blackStones,
             MM.Child, mui.MakeLabel1 (l.MSG_WHITE_FIELD), MM.Child, data^.whiteField,
             MM.Child, mui.MakeLabel1 (l.MSG_BLACK_FIELD), MM.Child, data^.blackField,
           u.tagEnd));
  data^.whiteCharacter := I.NewObjectA (CharacterClass^.class, NIL, y.TAG (buffer,
                                  mui.maCharacterColour, mui.mvCharacterColourWhite, u.tagEnd));
  data^.blackCharacter := I.NewObjectA (CharacterClass^.class, NIL, y.TAG (buffer,
                                  mui.maCharacterColour, mui.mvCharacterColourBlack, u.tagEnd));
  ai := MM.Register (y.TAG (buffer,
          MD.maBackground, MD.miGroupBack,
          MD.maRegisterFrame, TRUE,
          MD.maRegisterTitles, y.ADR (aiRegTitles),
          MM.Child, data^.whiteCharacter,
          MM.Child, data^.blackCharacter,
        u.tagEnd));

  obj := MCS.DoSuperNew (cl, obj, y.TAG (buffer,
            MD.maWindowTitle, l.GetString (l.MSG_PREF_WIN),
            MD.maWindowID, MM.MakeID ("PREF"),
            MD.maBackground, MD.miWindowBack,
            MM.WindowContents,
              MM.Register (y.TAG (buffer2,
                MD.maBackground, MD.miGroupBack,
                MD.maRegisterFrame, TRUE,
                MD.maRegisterTitles, y.ADR (regTitles),
                MM.Child, general,
                MM.Child, board,
                MM.Child, ai,
              u.tagEnd)),
            u.tagEnd));

  IF obj <> NIL THEN
    MS.DoMethod (data^.player1, y.TAG (buffer, MD.mmNotify, MD.maCycleActive, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.player2, y.TAG (buffer, MD.mmNotify, MD.maCycleActive, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.trace, y.TAG (buffer, MD.mmNotify, MD.maCycleActive, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.level, y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.blink, y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.blinkTime, y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.boardType, y.TAG (buffer, MD.mmNotify, MD.maNumericValue, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.whiteStones, y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.blackStones, y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.whiteField, y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.blackField, y.TAG (buffer, MD.mmNotify, MD.maPendisplaySpec, MD.mvEveryTime, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.whiteCharacter, y.TAG (buffer, MD.mmNotify, mui.maCharacterChange, TRUE, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));
    MS.DoMethod (data^.blackCharacter, y.TAG (buffer, MD.mmNotify, mui.maCharacterChange, TRUE, obj, 3, MD.mmSet, mui.maPrefWindowChange, 1));

    MS.DoMethod (save, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 2, mui.mmPrefWindowSave, y.ADR (mui.envarc)));
    MS.DoMethod (save, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 2, mui.mmPrefWindowSave, y.ADR (mui.env)));
    MS.DoMethod (use, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 2, mui.mmPrefWindowSave, y.ADR (mui.env)));
    MS.DoMethod (load, y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 2, mui.mmPrefWindowLoad, NIL));
  END; (* IF *)
  RETURN obj

END PrefWindowNew;

(*---------------------------------------------------------------------------*)

PROCEDURE PrefWindowDispatcher (cl : i.IClassPtr; obj : y.ADDRESS; msg : y.ADDRESS) : y.ADDRESS;

VAR methodID : LONGCARD;

BEGIN (* PrefWindowDispatcher *)

  methodID := y.CAST (i.Msg, msg)^.methodID;
  IF    methodID = i.omNEW          THEN RETURN PrefWindowNew (cl, obj, msg)
  ELSIF methodID = i.omSET          THEN RETURN PrefWindowSet (cl, obj, msg)
  ELSIF methodID = i.omGET          THEN RETURN PrefWindowGet (cl, obj, msg)
  ELSIF methodID = mui.mmPrefWindowLoad THEN RETURN PrefWindowLoad (cl, obj, msg)
  ELSIF methodID = mui.mmPrefWindowSave THEN RETURN PrefWindowSave (cl, obj, msg)
  ELSE RETURN al.DoSuperMethodA (cl, obj, msg)
  END (* IF *)

END PrefWindowDispatcher;


VAR NULL : MD.APTR;

BEGIN (* bgPreferences *)

  NULL := NIL;
  IF NOT MCS.InitClass (CharacterClass, NIL, y.ADR (MD.mcGroup), NIL, SIZE(CharacterData), CharacterDispatcher) THEN
    MS.fail (NULL, "Could not create custom class.")
  END; (* IF *)
  IF NOT MCS.InitClass (PrefWindowClass, NIL, y.ADR (MD.mcWindow), NIL, SIZE(PrefWindowData), CharacterDispatcher) THEN
    MS.fail (NULL, "Could not create custom class.")
  END (* IF *)

CLOSE

  MCS.RemoveClass (CharacterClass);
  MCS.RemoveClass (PrefWindowClass)

END bgPreferences.


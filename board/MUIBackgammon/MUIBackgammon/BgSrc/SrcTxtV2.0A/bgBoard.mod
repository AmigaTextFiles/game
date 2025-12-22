IMPLEMENTATION MODULE bgBoard;
(****h* Backgammon/bgBoard *************************************************
*
*       NAME
*           bgBoard
*
*       COPYRIGHT
*           © 1996, Marc Ewert
*
*       FUNCTION
*           Stellt Board Subclass zur Verfügung
*
*       AUTHOR
*           Marc Ewert
*
*       CREATION DATE
*           29.03.96
*
*       HISTORY
*           V1.00 - (..)
*                   * Erste Version
*
*       NOTES
*
************************************************************************************
*)

IMPORT

  io  : InOut,
  al  : AmigaLib,
  b   : bgBar,
  g   : GraphicsD,
  G   : GraphicsL,
  GM  : GfxMacros,
  ho  : bgHome,
  i   : IntuitionD,
  I   : IntuitionL,
  MC  : MuiClasses,
  MCS : MuiClassSupport,
  MD  : MuiD,
  ML  : MuiL,
  MM  : MuiMacros,
  MS  : MuiSupport,
  mui : bgMui,
  u   : UtilityD,
  U   : UtilityL,
  t   : bgTriangle,
  y   : SYSTEM,
  zi  : bgZiehen;

(*---------------------------------------------------------------------------*)
(* Board Class *)
(* Group, Backgammonbrett von MUIBackgammon *)
(*---------------------------------------------------------------------------*)

TYPE BoardDataPtr = POINTER TO BoardData;
     BoardData = RECORD
                   boardType   : LONGINT;
                   board       : MD.APTR;
                   brett       : ARRAY [0..27] OF MD.APTR;
                   set         : ARRAY [0..27] OF LONGINT;
                   whiteStones : MD.mPenSpec;
                   blackStones : MD.mPenSpec;
                   whiteField  : MD.mPenSpec;
                   blackField  : MD.mPenSpec;
                   move        : mui.mBoardMove;
                   first       : LONGINT
                 END; (* RECORD *)

TYPE mpBoardHumanMovePtr = POINTER TO mpBoardHumanMove;
     mpBoardHumanMove = RECORD
                          field : LONGINT
                        END; (* RECORD *)

(*---------------------------------------------------------------------------*)

PROCEDURE MakeBoard (obj : MD.APTR; boardType : LONGINT; data : BoardDataPtr) : MD.APTR;
(* Generiert Backgammonbrett entsprechend boardType *)

VAR buffer, buffer2    : ARRAY [0..30] OF LONGINT;
    kopf               : BOOLEAN;
    x, black, white    : LONGINT;
    tag, pen, stonePen : y.ADDRESS;

BEGIN (* MakeBoard *)

  data^.brett[0] := I.NewObjectA (ho.HomeClass, NIL, y.TAG(buffer, MD.maInputMode, MD.mvInputModeRelVerify,
                            ho.hoStonePen, y.ADR (data^.whiteStones), ho.hoPen, y.ADR (data^.blackField),
                            ho.hoStones, data^.set[0], ho.hoBottom, kopf, u.tagDone));
  FOR x := 1 TO 24 DO
    IF x <= 12 THEN kopf := (boardType=0) OR (boardType=1)
    ELSE kopf := (boardType<>0) AND (boardType<>1)
    END; (* IF *)
    IF ODD (x) THEN pen := y.ADR (data^.whiteField)
    ELSE pen := y.ADR (data^.blackField)
    END; (* IF *)
    IF data^.set[x] > 0 THEN white := data^.set[x]; black := 0; stonePen := y.ADR (data^.whiteStones)
    ELSIF data^.set[x] < 0 THEN black := data^.set[x]; white := 0; stonePen := y.ADR (data^.blackStones)
    ELSE black := 0; white := 0; stonePen := y.ADR (data^.blackStones)
    END; (* IF *)
    tag := y.TAG (buffer, MD.maInputMode, MD.mvInputModeRelVerify, t.trBottom, kopf,
    t.trPen, pen, t.trStonePen, stonePen, t.trBlack, black, t.trWhite, white, u.tagDone);
    data^.brett[x] := I.NewObjectA (t.TriangleClass, NIL, tag)
  END; (* FOR *)
  data^.brett[25] := I.NewObjectA (ho.HomeClass, NIL, y.TAG(buffer, MD.maInputMode, MD.mvInputModeRelVerify,
                             ho.hoStonePen, y.ADR (data^.blackStones), ho.hoPen, y.ADR (data^.whiteField),
                             ho.hoStones, data^.set[25], ho.hoBottom, NOT kopf, u.tagDone));
  data^.brett[26] := I.NewObjectA (b.BarClass, NIL, y.TAG(buffer, MD.maInputMode, MD.mvInputModeRelVerify,
                             b.brStonePen, y.ADR (data^.whiteStones), b.brPen, y.ADR (data^.blackField),
                             b.brBottom, kopf, b.brStones, data^.set[26], u.tagDone));
  data^.brett[27] := I.NewObjectA (b.BarClass, NIL, y.TAG (buffer, MD.maInputMode, MD.mvInputModeRelVerify,
                             b.brStonePen, y.ADR (data^.blackStones), b.brPen, y.ADR (data^.whiteField),
                             b.brBottom, NOT kopf, b.brStones, data^.set[27], u.tagDone));
  FOR x := 0 TO 27 DO
    MS.DoMethod (data^.brett[x], y.TAG (buffer, MD.mmNotify, MD.maPressed, FALSE, obj, 2, mui.mmBoardHumanMove, x))
  END; (* FOR *)

  CASE boardType OF
    0: RETURN MM.HGroup (y.TAG (buffer,
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[13], MM.Child, data^.brett[14],
                            MM.Child, data^.brett[15], MM.Child, data^.brett[16],
                            MM.Child, data^.brett[17], MM.Child, data^.brett[18],
                            MM.Child, data^.brett[12], MM.Child, data^.brett[11],
                            MM.Child, data^.brett[10], MM.Child, data^.brett[9],
                            MM.Child, data^.brett[8], MM.Child, data^.brett[7],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[26], MM.Child, data^.brett[27],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[19], MM.Child, data^.brett[20],
                            MM.Child, data^.brett[21], MM.Child, data^.brett[22],
                            MM.Child, data^.brett[23], MM.Child, data^.brett[24],
                            MM.Child, data^.brett[6], MM.Child, data^.brett[5],
                            MM.Child, data^.brett[4], MM.Child, data^.brett[3],
                            MM.Child, data^.brett[2], MM.Child, data^.brett[1],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[25], MM.Child, data^.brett[0],
                          u.tagEnd)),
              u.tagEnd))
    | 1: RETURN MM.HGroup (y.TAG (buffer,
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[25], MM.Child, data^.brett[0],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[24], MM.Child, data^.brett[23],
                            MM.Child, data^.brett[22], MM.Child, data^.brett[21],
                            MM.Child, data^.brett[20], MM.Child, data^.brett[19],
                            MM.Child, data^.brett[1], MM.Child, data^.brett[2],
                            MM.Child, data^.brett[3], MM.Child, data^.brett[4],
                            MM.Child, data^.brett[5], MM.Child, data^.brett[6],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[26], MM.Child, data^.brett[27],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[18], MM.Child, data^.brett[17],
                            MM.Child, data^.brett[16], MM.Child, data^.brett[15],
                            MM.Child, data^.brett[14], MM.Child, data^.brett[13],
                            MM.Child, data^.brett[7], MM.Child, data^.brett[8],
                            MM.Child, data^.brett[9], MM.Child, data^.brett[10],
                            MM.Child, data^.brett[11], MM.Child, data^.brett[12],
                          u.tagEnd)),
              u.tagEnd))
    | 2: RETURN MM.HGroup (y.TAG (buffer,
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[12], MM.Child, data^.brett[11],
                            MM.Child, data^.brett[10], MM.Child, data^.brett[9],
                            MM.Child, data^.brett[8], MM.Child, data^.brett[7],
                            MM.Child, data^.brett[13], MM.Child, data^.brett[14],
                            MM.Child, data^.brett[15], MM.Child, data^.brett[16],
                            MM.Child, data^.brett[17], MM.Child, data^.brett[18],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[27], MM.Child, data^.brett[26],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[6], MM.Child, data^.brett[5],
                            MM.Child, data^.brett[4], MM.Child, data^.brett[3],
                            MM.Child, data^.brett[2], MM.Child, data^.brett[1],
                            MM.Child, data^.brett[19], MM.Child, data^.brett[20],
                            MM.Child, data^.brett[21], MM.Child, data^.brett[22],
                            MM.Child, data^.brett[23], MM.Child, data^.brett[24],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[0], MM.Child, data^.brett[25],
                          u.tagEnd)),
              u.tagEnd))
    | 3: RETURN MM.HGroup (y.TAG (buffer,
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[0], MM.Child, data^.brett[25],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[1], MM.Child, data^.brett[2],
                            MM.Child, data^.brett[3], MM.Child, data^.brett[4],
                            MM.Child, data^.brett[5], MM.Child, data^.brett[6],
                            MM.Child, data^.brett[24], MM.Child, data^.brett[23],
                            MM.Child, data^.brett[22], MM.Child, data^.brett[21],
                            MM.Child, data^.brett[20], MM.Child, data^.brett[19],
                          u.tagEnd)),
                MM.Child, MM.VGroup (y.TAG (buffer2,
                            MD.maHorizWeight, 9,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[27], MM.Child, data^.brett[26],
                          u.tagEnd)),
                MM.Child, MM.RowGroup (2, y.TAG (buffer2,
                            MD.maHorizWeight, 42,
                            MD.maFrame, MD.mvFrameGroup,
                            MM.Child, data^.brett[7], MM.Child, data^.brett[8],
                            MM.Child, data^.brett[9], MM.Child, data^.brett[10],
                            MM.Child, data^.brett[11], MM.Child, data^.brett[12],
                            MM.Child, data^.brett[18], MM.Child, data^.brett[17],
                            MM.Child, data^.brett[16], MM.Child, data^.brett[15],
                            MM.Child, data^.brett[14], MM.Child, data^.brett[13],
                          u.tagEnd)),
              u.tagEnd))
  ELSE
  END; (* CASE *)
  RETURN NIL

END MakeBoard;

(*---------------------------------------------------------------------------*)

PROCEDURE BoardHumanMove (cl : i.IClassPtr; obj : i.ObjectPtr; msg : mpBoardHumanMovePtr) : y.ADDRESS;

VAR data : BoardDataPtr;

BEGIN (* BoardHumanMove *)

  data := MC.InstData (cl, obj);
  IF data = NIL THEN RETURN NIL
  END; (* IF *)
  IF data^.first = 0 THEN     (* Ausgangsfeld *)
    data^.move[1] := msg^.field; data^.first := 1
  ELSE                        (* Zielfeld *)
    data^.move[2] := msg^.field; data^.first := 0;
    MM.set (obj, mui.maBoardHumanMove, y.ADR (data^.move))
  END; (* IF *)
  RETURN 0

END BoardHumanMove;

(*---------------------------------------------------------------------------*)

PROCEDURE BoardSet ( cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr ) : y.ADDRESS;

VAR data      : BoardDataPtr;
    tags, tag : u.TagItemPtr;
    newBoard  : MD.APTR;
    buffer    : ARRAY [0..1] OF LONGINT;

BEGIN (* BoardSet *)

  data := MC.InstData (cl, obj);
  IF data <> NIL THEN
    tags := msg^.attrList;
    IF tags <> NIL THEN
      REPEAT
        tag := U.NextTagItem (tags);
        IF tag <> NIL THEN
          CASE tag^.tag OF
            mui.maBoardType:
              IF LONGINT (tag^.data) <> data^.boardType THEN
                newBoard := MakeBoard (obj, tag^.data, data);
                IF newBoard <> NIL THEN
                  IF MS.DOMethod (obj, y.TAG (buffer, MD.mmGroupInitChange)) <> 0 THEN
                    MM.RemMember (obj, data^.board);
                    ML.mDisposeObject (data^.board);
                    data^.board := newBoard;
                    MM.AddMember (obj, data^.board);
                    MS.DoMethod (obj, y.TAG (buffer, MD.mmGroupExitChange));
                    data^.boardType := tag^.data
                  ELSE ML.mDisposeObject (newBoard)
                  END (* IF *)
                END (* IF *)
              END (* IF *)
          ELSE
          END (* CASE *)
        END (* IF *)
      UNTIL tag = NIL
    END (* IF *)
  END; (* IF *)
  RETURN al.DoSuperMethodA (cl, obj, msg)

END BoardSet;

(*--------------------------------------------------------------------------------*)

PROCEDURE BoardGet (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpGetPtr) : y.ADDRESS;

VAR data  : BoardDataPtr;
    store : mui.LongCardPtr;

BEGIN (* BoardGet *)

  data := MC.InstData (cl, obj);
  IF data <> NIL THEN
    store := y.CAST (mui.LongCardPtr, msg^.storage);
    CASE msg^.attrID OF
      mui.maBoardHumanMove : store^ := y.ADR (data^.move); RETURN 1
    ELSE
    END (* CASE *)
  END; (* IF *)
  RETURN al.DoSuperMethodA(cl, obj, msg)

END BoardGet ;

(*---------------------------------------------------------------------------*)

VAR tmp := BoardData{};

PROCEDURE BoardNew (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR buffer    : ARRAY [0..4] OF LONGINT;
    boardType : LONGINT;
    data      : BoardDataPtr;
    bh        : mui.BgHandlePtr;

BEGIN (* BoardNew *)

  bh := y.CAST (mui.BgHandlePtr, U.GetTagData (mui.maBoardBgHandle, NIL, msg^.attrList));
  boardType := U.GetTagData (mui.maBoardType, 0, msg^.attrList);
  IF bh <> NIL THEN
    tmp.whiteStones := bh^.pref.whiteStones;
    tmp.blackStones := bh^.pref.blackStones;
    tmp.whiteField := bh^.pref.whiteField;
    tmp.blackField := bh^.pref.blackField
  END; (* IF *)
  tmp.first := 0;
  tmp.move[1] := 0; tmp.move[2] := 0;
  tmp.board := MakeBoard (obj, boardType, y.ADR (tmp));
  obj := MCS.DoSuperNew (cl, obj, y.TAG (buffer,
            MD.maGroupHoriz, TRUE,
            MM.Child, tmp.board,
            u.tagEnd));
  IF obj <> NIL THEN
    data := MC.InstData (cl, obj);
    data^ := tmp
  END; (* IF *)
  RETURN obj

END BoardNew;

(*---------------------------------------------------------------------------*)

PROCEDURE BoardDispatcher (cl : i.IClassPtr; obj : y.ADDRESS; msg : y.ADDRESS) : y.ADDRESS;

VAR methodID : LONGCARD;

BEGIN (* BoardDispatcher *)

  methodID := y.CAST (i.Msg, msg)^.methodID;
  IF    methodID = i.omNEW              THEN RETURN BoardNew (cl, obj, msg)
  ELSIF methodID = i.omSET              THEN RETURN BoardSet (cl, obj, msg)
  ELSIF methodID = i.omGET              THEN RETURN BoardGet (cl, obj, msg)
  ELSIF methodID = mui.mmBoardHumanMove THEN RETURN BoardHumanMove (cl, obj, msg)
  ELSE RETURN al.DoSuperMethodA (cl, obj, msg)
  END (* IF *)

END BoardDispatcher;


VAR NULL : MD.APTR;

BEGIN (* bgBoard *)

  NULL := NIL;
  IF NOT MCS.InitClass (BoardClass, NIL, y.ADR (MD.mcGroup), NIL, SIZE(BoardData), BoardDispatcher) THEN
    MS.fail (NULL, "Could not create custom class.")
  END (* IF *)

CLOSE

  IF BoardClass <> NIL THEN MCS.RemoveClass (BoardClass)
  END (* IF *)


END bgBoard.


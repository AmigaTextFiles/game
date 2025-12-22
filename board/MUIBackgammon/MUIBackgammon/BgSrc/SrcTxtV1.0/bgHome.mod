IMPLEMENTATION MODULE bgHome;
(****h* bgHome/bgHome *************************************************
*
*       NAME
*           bgHome
*
*       COPYRIGHT
*           Marc Ewert © 1996
*
*       FUNCTION
*           Stellt Objekt für Backgammon Zielfeld
*
*       AUTHOR
*           Marc Ewert
*
*       CREATION DATE
*           11.03.96
*
*       HISTORY
*           V1.00 - (11.03.96)
*                   * Erste Version.
*
*       NOTES
*
************************************************************************************
*)

(*$ RangeChk := FALSE *)

IMPORT

  al : AmigaLib,
  g  : GraphicsD,
  G  : GraphicsL,
  GM : GfxMacros,
  gs : GraphicsSupport,
  i  : IntuitionD,
  I  : IntuitionL,
  MC : MuiClasses,
  MD : MuiD,
  ML : MuiL,
  MS : MuiSupport,
  u  : UtilityD,
  U  : UtilityL,
  y  : SYSTEM;

(*--------------------------------------------------------------------------------*)

TYPE HomeDataPtr = POINTER TO HomeData;
     HomeData = RECORD
                 penSpec      : MD.mPenSpec;
                 stonePenSpec : MD.mPenSpec;
                 pen          : y.ADDRESS;
                 stonePen     : y.ADDRESS;
                 stones       : LONGINT;
                 bottom       : BOOLEAN;
                 penChange    : BOOLEAN
               END; (* RECORD *)

(*--------------------------------------------------------------------------------*)

PROCEDURE Min (a,b:INTEGER):INTEGER; BEGIN IF a<b THEN RETURN a END; RETURN b END Min;

(*--------------------------------------------------------------------------------*)

PROCEDURE mNew ( cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr ) : y.ADDRESS;

VAR data : HomeDataPtr;
    tags, tag : u.TagItemPtr;

BEGIN (* mNew *)

  obj := al.DoSuperMethodA (cl, obj, msg);
  IF obj <> NIL THEN
    data := MC.InstData (cl, obj);
    tags := msg^.attrList;
    tag  := U.NextTagItem (tags);
    WHILE tag <> NIL DO
      CASE tag^.tag OF
        hoPen : IF tag^.data <> 0 THEN
                  data^.penSpec := y.CAST (MD.mPenSpecPtr, tag^.data)^
                END (* IF *)
      | hoStonePen : IF tag^.data <> 0 THEN
                       data^.stonePenSpec := y.CAST (MD.mPenSpecPtr, tag^.data)^
                     END (* IF *)
      | hoBottom : data^.bottom := tag^.data <> 0
      | hoStones : data^.stones := tag^.data
      ELSE
      END; (* CASE *)
      tag := U.NextTagItem (tags);
    END (* WHILE *) ;
    data^.penChange := FALSE
  END; (* IF *)
  RETURN obj

END mNew;

(*--------------------------------------------------------------------------------*)

PROCEDURE mSet ( cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr ) : y.ADDRESS;

VAR data      : HomeDataPtr;
    tags, tag : u.TagItemPtr;
    dummy     : MD.APTR;

BEGIN (* mSet *)

  data := MC.InstData (cl, obj);
  tags := msg^.attrList;
  IF tags <> NIL THEN
    REPEAT
      tag := U.NextTagItem (tags);
      IF tag <> NIL THEN
        CASE tag^.tag OF
          hoStones   : data^.stones := tag^.data
        | hoPen      : data^.penSpec := y.CAST (MD.mPenSpecPtr, tag^.data)^;
                       data^.penChange := TRUE
        | hoStonePen : data^.stonePenSpec := y.CAST (MD.mPenSpecPtr, tag^.data)^;
                       data^.penChange := TRUE
        ELSE
        END (* CASE *)
      END (* IF *)
    UNTIL tag = NIL
  END; (* IF *)
  dummy := ML.moRedraw (obj, LONGCARD (MC.drawUpdate));
  RETURN al.DoSuperMethodA (cl, obj, msg);

END mSet;

(*---------------------------------------------------------------------------*)

PROCEDURE mGet (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpGetPtr) : y.ADDRESS;

TYPE LongCardPtr = POINTER TO LONGCARD;

VAR data  : POINTER TO HomeData;
    store : LongCardPtr;

BEGIN (* mGet *)

  data := MC.InstData (cl, obj);
  store := y.CAST (LongCardPtr, msg^.storage);
  CASE msg^.attrID OF
  hoStones : store^ := data^.stones; RETURN LONGCARD(TRUE);
  ELSE RETURN al.DoSuperMethodA(cl, obj, msg)
  END (* CASE *)

END mGet ;

(*--------------------------------------------------------------------------------*)

PROCEDURE mAskMinMax ( cl : i.IClassPtr; obj : i.ObjectPtr;
                       msg : MC.mpAskMinMaxPtr ) : y.ADDRESS;

VAR dummy : y.ADDRESS;

BEGIN (* mAskMinMax *)

  dummy := al.DoSuperMethodA (cl, obj, msg);
  INC (msg^.MinMaxInfo^.MinWidth, 14);
  INC (msg^.MinMaxInfo^.DefWidth, 16);
  INC (msg^.MinMaxInfo^.MaxWidth, 50);
  INC (msg^.MinMaxInfo^.MinHeight, 30);
  INC (msg^.MinMaxInfo^.DefHeight, 40);
  INC (msg^.MinMaxInfo^.MaxHeight, 200);
  RETURN NIL

END mAskMinMax;

(*--------------------------------------------------------------------------------*)

PROCEDURE mSetup (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR data : HomeDataPtr;

BEGIN (* mSetup *)

  data := MC.InstData (cl, obj);
  IF al.DoSuperMethodA (cl, obj, msg) = NIL THEN RETURN LONGCARD(FALSE)
  END; (* IF *)
  data^.pen := ML.moObtainPen (MC.muiRenderInfo (obj), y.ADR (data^.penSpec), 0);
  data^.stonePen := ML.moObtainPen (MC.muiRenderInfo (obj), y.ADR (data^.stonePenSpec), 0);
  RETURN LONGCARD(TRUE)

END mSetup ;     

(*---------------------------------------------------------------------------*)

PROCEDURE mCleanup (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR data : HomeDataPtr;

BEGIN (* mCleanUp *)

  data := MC.InstData (cl, obj);
  ML.moReleasePen (MC.muiRenderInfo (obj), data^.pen);
  ML.moReleasePen (MC.muiRenderInfo (obj), data^.stonePen);
  RETURN al.DoSuperMethodA(cl, obj, msg)

END mCleanup;

(*---------------------------------------------------------------------------*)

PROCEDURE mDraw ( cl : i.IClassPtr; obj : i.ObjectPtr; msg : MC.mpDrawPtr )
                  : y.ADDRESS;

CONST areaPattern = LONGINT{5555AAAAH};

VAR dummy                     : y.ADDRESS;
    width, height, left, bot  : INTEGER;
    thick, x, step, j         : INTEGER;
    rp                        : g.RastPortPtr;
    data                      : HomeDataPtr;
    sarea                     : gs.SAreaHandlePtr;

(*--------------------------------------------------------------------------------*)

BEGIN (* mDraw *)

  dummy := al.DoSuperMethodA(cl,obj,msg);
  data := MC.InstData (cl, obj);
  IF (MC.drawObject IN msg^.flags) OR (MC.drawUpdate IN msg^.flags) THEN
    IF data^.penChange THEN
      data^.penChange := FALSE ;
      ML.moReleasePen (MC.muiRenderInfo (obj), data^.pen);
      data^.pen := ML.moObtainPen (MC.muiRenderInfo (obj), y.ADR (data^.penSpec), 0);
      ML.moReleasePen (MC.muiRenderInfo (obj), data^.stonePen);
      data^.stonePen := ML.moObtainPen (MC.muiRenderInfo (obj), y.ADR (data^.stonePenSpec), 0)
    END; (* IF *)
    rp := MC.OBJ_rp (obj);
    sarea := gs.InitSArea (rp, 40);
    bot := MC.OBJ_mbottom(obj);
    left := MC.OBJ_mleft (obj);
    width := MC.OBJ_mwidth (obj);
    height := MC.OBJ_mheight (obj);
    G.SetAPen (rp, MC.muiPen (data^.pen));
    GM.SetAfPen (rp, y.ADR (areaPattern), 1);
    gs.SAreaMove (sarea, left, bot);
    gs.SAreaDraw (sarea, left + width, bot);
    gs.SAreaDraw (sarea, left + width, bot - height);
    gs.SAreaDraw (sarea, left, bot - height);
    gs.SAreaEnd (sarea, gs.aSolid);
    GM.SetAfPen (rp, NIL, 0);
    IF data^.stones > 0 THEN
      G.SetAPen (rp, MC.muiPen (data^.stonePen));
      thick := height DIV 31;
      (*IF data^.bottom THEN j := 0; step := thick
      ELSE j := height; step := thick * (-1)
      END; (* IF *) *)
      j := 0;
      sarea := gs.InitSArea (rp, 100);
      FOR x := 1 TO data^.stones DO
        INC (j, thick);
        gs.SAreaMove (sarea, left, bot - j);
        gs.SAreaDraw (sarea, left + width - 1, bot - j);
        gs.SAreaDraw (sarea, left + width - 1, bot - j - thick);
        gs.SAreaDraw (sarea, left, bot - j - thick);
        INC (j, thick)
      END; (* FOR *)
      gs.SAreaEnd (sarea, gs.aSolid);
    END (* IF *)
  END; (* IF *)
  RETURN NIL

END mDraw;

(*--------------------------------------------------------------------------------*)

PROCEDURE HomeDispatcher( cl : i.IClassPtr; obj : y.ADDRESS; msg : y.ADDRESS )
                         : y.ADDRESS;

VAR methodID : LONGCARD;

BEGIN (* HomeDispatcher *)

  methodID := y.CAST (i.Msg, msg)^.methodID;
  IF methodID = MD.mmAskMinMax  THEN RETURN mAskMinMax (cl, obj, msg)
  ELSIF methodID = MD.mmDraw    THEN RETURN mDraw (cl, obj, msg)
  ELSIF methodID = i.omNEW      THEN RETURN mNew (cl, obj, msg)
  ELSIF methodID = i.omSET      THEN RETURN mSet (cl, obj, msg)
  ELSIF methodID = i.omGET      THEN RETURN mGet (cl, obj, msg)
  ELSIF methodID = MD.mmSetup   THEN RETURN mSetup (cl, obj, msg)
  ELSIF methodID = MD.mmCleanup THEN RETURN mCleanup (cl, obj, msg)
  ELSE RETURN al.DoSuperMethodA (cl, obj, msg)
  END (* IF *)

END HomeDispatcher;

(*--------------------------------------------------------------------------------*)

VAR SuperClass : i.IClassPtr;
    NULL       : MD.APTR;
    du         : BOOLEAN;

BEGIN (* Home *)

  NULL := NIL;
  SuperClass := ML.moGetClass (y.ADR (MD.mcArea));
  IF SuperClass = NIL THEN MS.fail (NULL, "Superclass for the new class not found,")
  END; (* IF *)
  HomeClass := I.MakeClass (NIL,NIL,SuperClass,SIZE (HomeData),y.LONGSET {});
  IF HomeClass = NIL THEN
    ML.moFreeClass (SuperClass);
    MS.fail (NULL, "Failed to create class!");
  END;
  MC.MakeDispatcher (HomeDispatcher, HomeClass);

CLOSE

  du := I.FreeClass (HomeClass);             (* free our own class *)
  ML.moFreeClass (SuperClass)

END bgHome.


IMPLEMENTATION MODULE bgTriangle;
(****h* bg/bgTriangle *************************************************
*
*       NAME
*           bgTriangle
*
*       COPYRIGHT
*           Marc Ewert © 1996
*
*       FUNCTION
*           Stellt Objekt für Backgammon Feld
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
  MM : MuiMacros,
  MS : MuiSupport,
  u  : UtilityD,
  U  : UtilityL,
  y  : SYSTEM;

(*--------------------------------------------------------------------------------*)

TYPE TriangleDataPtr = POINTER TO TriangleData;
     TriangleData = RECORD
                      white        : LONGCARD;
                      black        : LONGCARD;
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

VAR data      : TriangleDataPtr;
    tags, tag : u.TagItemPtr;

BEGIN (* mNew *)

  obj := al.DoSuperMethodA (cl, obj, msg);
  IF obj <> NIL THEN
    data := MC.InstData (cl, obj);
    tags := msg^.attrList;
    tag  := U.NextTagItem (tags);
    WHILE tag <> NIL DO
      CASE tag^.tag OF
        trPen : IF tag^.data <> 0 THEN
                  data^.penSpec := y.CAST (MD.mPenSpecPtr, tag^.data)^
                END (* IF *)
      | trStonePen : IF tag^.data <> 0 THEN
                       data^.stonePenSpec := y.CAST (MD.mPenSpecPtr, tag^.data)^
                     END (* IF *)
      | trBottom : data^.bottom := tag^.data <> 0
      | trWhite : data^.white := tag^.data
      | trBlack : data^.black := tag^.data
      ELSE
      END; (* CASE *)
      tag := U.NextTagItem (tags);
    END (* WHILE *) ;
    data^.penChange := FALSE
  END; (* IF *)
  RETURN obj

END mNew;

(*---------------------------------------------------------------------------*)

PROCEDURE Equal (spec1, spec2 : MD.mPenSpec) : BOOLEAN;
(* Sind spec1 und spec2 identisch? *)

VAR x : CARDINAL;

BEGIN (* Equal *)

  FOR x := 0 TO 31 DO IF spec1.buf[x] <> spec2.buf[x] THEN RETURN FALSE END
  END;
  RETURN TRUE

END Equal;

(*--------------------------------------------------------------------------------*)

PROCEDURE mSet ( cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr ) : y.ADDRESS;

VAR data      : TriangleDataPtr;
    tags, tag : u.TagItemPtr;
    dummy     : MD.APTR;
    redraw    : BOOLEAN;

BEGIN (* mSet *)

  redraw := FALSE;
  data := MC.InstData (cl, obj);
  tags := msg^.attrList;
  IF tags <> NIL THEN
    REPEAT
      tag := U.NextTagItem (tags);
      IF tag <> NIL THEN
        CASE tag^.tag OF
          trWhite    : IF data^.white <> tag^.data THEN
                         data^.white := tag^.data; redraw := TRUE
                       END (* IF *)
        | trBlack    : IF data^.black <> tag^.data THEN
                         data^.black := tag^.data; redraw := TRUE
                       END (* IF *)
        | trPen      : IF NOT Equal (data^.penSpec, y.CAST (MD.mPenSpecPtr, tag^.data)^) THEN
                         data^.penSpec := y.CAST (MD.mPenSpecPtr, tag^.data)^;
                         data^.penChange := TRUE; redraw := TRUE
                       END (* IF *)
        | trStonePen : IF NOT Equal (data^.stonePenSpec, y.CAST (MD.mPenSpecPtr, tag^.data)^) THEN
                         data^.stonePenSpec := y.CAST (MD.mPenSpecPtr, tag^.data)^;
                         data^.penChange := TRUE; redraw := TRUE
                       END (* IF *)
        ELSE
        END (* CASE *)
      END (* IF *)
    UNTIL tag = NIL
  END; (* IF *)
  IF redraw THEN dummy := ML.moRedraw (obj, LONGCARD (MC.drawUpdate)) END; (* IF *)
  RETURN al.DoSuperMethodA (cl, obj, msg);

END mSet;

(*---------------------------------------------------------------------------*)

PROCEDURE mGet (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpGetPtr) : y.ADDRESS;

TYPE LongCardPtr = POINTER TO LONGCARD;

VAR data  : POINTER TO TriangleData;
    store : LongCardPtr;

BEGIN (* mGet *)

  data := MC.InstData (cl, obj);
  store := y.CAST (LongCardPtr, msg^.storage);
  CASE msg^.attrID OF
    trBlack : store^ := data^.black; RETURN LONGINT(TRUE)
  | trWhite : store^ := data^.white; RETURN LONGINT(TRUE)
  ELSE RETURN al.DoSuperMethodA(cl, obj, msg)
  END (* CASE *)

END mGet;

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

(*---------------------------------------------------------------------------*)

PROCEDURE mSetup (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR data : TriangleDataPtr;

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

VAR data : TriangleDataPtr;

BEGIN (* mCleanUp *)

  data := MC.InstData (cl, obj);
  ML.moReleasePen (MC.muiRenderInfo (obj), data^.pen);
  ML.moReleasePen (MC.muiRenderInfo (obj), data^.stonePen);
  RETURN al.DoSuperMethodA(cl, obj, msg)

END mCleanup;

(*--------------------------------------------------------------------------------*)

PROCEDURE mDraw ( cl : i.IClassPtr; obj : i.ObjectPtr; msg : MC.mpDrawPtr )
                  : y.ADDRESS;

CONST areaPattern = LONGINT{5555AAAAH};

VAR dummy                    : y.ADDRESS;
    width, height, left, bot : INTEGER;
    radius, middle, x, cnt, j : INTEGER;
    rp                       : g.RastPortPtr;
    data                     : TriangleDataPtr;
    sarea                    : gs.SAreaHandlePtr;

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
    IF data^.bottom THEN        (* aufrechtes Dreieck *)
      gs.SAreaMove (sarea, left, bot);
      gs.SAreaDraw (sarea, left+width DIV 2, bot - TRUNC((FLOAT(height)*2.0)/3.0));
      gs.SAreaDraw (sarea, left + width, bot);
      gs.SAreaEnd (sarea, gs.aSolid)
    ELSE                        (* auf dem Kopf stehendes Dreieck *)
      gs.SAreaMove (sarea, left, bot - height);
      gs.SAreaDraw (sarea, left + width DIV 2, bot - height  DIV 3);
      gs.SAreaDraw (sarea, left + width, bot - height);
      gs.SAreaEnd (sarea, gs.aSolid)
    END; (* IF *)
    GM.SetAfPen (rp, NIL, 0);
    IF (data^.white > 0) OR (data^.black > 0) THEN
      IF data^.white > 0 THEN cnt := Min (6, data^.white)
      ELSE cnt := Min (6, data^.black) END; (* IF *)
      G.SetAPen (rp, MC.muiPen (data^.stonePen));
      middle := width DIV 2;
      radius := Min (middle - 1, height DIV 12);
      INC (middle, left);
      sarea := gs.InitSArea (rp, 40);
      FOR x := 1 TO cnt DO
        IF data^.bottom THEN
          j := bot - (((2*x)-1) * radius);
          gs.SAreaCircle (sarea, middle, j, radius);
        ELSE
          j := bot - height + 1 + (((2*x)-1) * radius);
          gs.SAreaCircle (sarea, middle, j, radius);
        END (* IF *)
      END; (* FOR *)
      gs.SAreaEnd (sarea, gs.aSolid)
    END
  END; (* IF *)
  RETURN NIL

END mDraw;

(*--------------------------------------------------------------------------------*)

PROCEDURE TriangleDispatcher( cl : i.IClassPtr; obj : y.ADDRESS; msg : y.ADDRESS )
                              : y.ADDRESS;

VAR methodID : LONGCARD;

BEGIN (* MyDispatcher *)

  methodID := y.CAST (i.Msg, msg)^.methodID;
  IF methodID = MD.mmAskMinMax      THEN RETURN mAskMinMax (cl, obj, msg)
  ELSIF methodID = MD.mmDraw        THEN RETURN mDraw (cl, obj, msg)
  ELSIF methodID = i.omNEW          THEN RETURN mNew (cl, obj, msg)
  ELSIF methodID = i.omSET          THEN RETURN mSet (cl, obj, msg)
  ELSIF methodID = i.omGET          THEN RETURN mGet (cl, obj, msg)
  ELSIF methodID = MD.mmSetup       THEN RETURN mSetup (cl, obj, msg)
  ELSIF methodID = MD.mmCleanup     THEN RETURN mCleanup (cl, obj, msg)
  ELSE RETURN al.DoSuperMethodA (cl, obj, msg)
  END (* IF *)

END TriangleDispatcher;

(*--------------------------------------------------------------------------------*)

VAR SuperClass : i.IClassPtr;
    NULL       : MD.APTR;
    du         : BOOLEAN;

BEGIN (* Triangel *)

  NULL := NIL;
  SuperClass := ML.moGetClass (y.ADR (MD.mcArea));
  IF SuperClass = NIL THEN MS.fail (NULL, "Superclass for the new class not found,")
  END; (* IF *)
  TriangleClass := I.MakeClass (NIL,NIL,SuperClass,SIZE (TriangleData),y.LONGSET {});
  IF TriangleClass = NIL THEN
    ML.moFreeClass (SuperClass);
    MS.fail (NULL, "Failed to create class!");
  END;
  MC.MakeDispatcher (TriangleDispatcher, TriangleClass);

CLOSE

  du := I.FreeClass (TriangleClass);             (* free our own class *)
  ML.moFreeClass (SuperClass)

END bgTriangle.


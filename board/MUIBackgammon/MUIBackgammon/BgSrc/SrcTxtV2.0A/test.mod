MODULE test;

IMPORT

  io  : InOut,
  a   : Arts,
  al  : AmigaLib,
  d   : DosD,
  D   : DosL,
  dd  : DataTypesD,
  E   : ExecL,
  g   : GraphicsD,
  G   : GraphicsL,
  h   : Heap,
  i   : IntuitionD,
  I   : IntuitionL,
  IC  : IconL,
  ip  : IFFParseD,
  l   : bgLocale,
  MC  : MuiClasses,
  MCS : MuiClassSupport,
  MD  : MuiD,
  ML  : MuiL,
  MM  : MuiMacros,
  MS  : MuiSupport,
  ms  : MuiSup,
  mui : bgMui,
  s   : String,
  u   : UtilityD,
  U   : UtilityL,
  wb  : WorkbenchD,
  y   : SYSTEM;

(*$ RangeChk := FALSE *)

TYPE LongCardPtr = POINTER TO LONGCARD;
TYPE ShortCardPtr = POINTER TO SHORTCARD;

TYPE mFieldImagePtr = POINTER TO mFieldImage;
TYPE mFieldImage = RECORD
                     body : y.ADDRESS;
                     cmap : y.ADDRESS;
                     bmhd : dd.BitMapHeader
                   END; (* RECORD *)

CONST maFieldBackground = 85EC1000H;
CONST maFieldImage = 85EC1001H;
CONST maFieldType = 85EC1002H;
CONST maFieldStones = 85EC1003H;

CONST mvFieldTypeTriangle = 85EC2000H;
CONST mvFieldTypeBar = 85EC2001H;
CONST mvFieldTypeHome = 85EC2002H;
CONST mvFieldColorWhite = 85EC2003H;
CONST mvFieldColorBlack = 85EC2004H;

(*---------------------------------------------------------------------------*)

PROCEDURE NextChunk (datei : d.FileHandlePtr; VAR id, size : LONGINT) : BOOLEAN;

BEGIN (* NextChunk *)

  IF D.Read (datei, y.ADR (id), 4) = 4 THEN
    IF D.Read (datei, y.ADR (size), 4) = 4 THEN RETURN TRUE
    ELSE RETURN FALSE
    END (* IF *)
  ELSE RETURN FALSE
  END (* IF *)

END NextChunk;

(*---------------------------------------------------------------------------*)

PROCEDURE ReadChunk (datei : d.FileHandlePtr; buf : y.ADDRESS; size : LONGINT) : BOOLEAN;

VAR dummy : LONGINT;

BEGIN (* ReadChunk *)

  IF D.Read (datei, buf, size) = size THEN
    IF ODD (size) THEN dummy := D.Seek (datei, 1, d.current)
    END; (* IF *)
    RETURN TRUE
  ELSE RETURN FALSE
  END (* IF *)

END ReadChunk;

(*---------------------------------------------------------------------------*)

PROCEDURE JumpChunk (datei : d.FileHandlePtr; size : LONGINT);

VAR dummy : LONGINT;

BEGIN (* JumpChunk *)

  IF ODD (size) THEN dummy := D.Seek (datei, size+1, d.current)
  ELSE dummy := D.Seek (datei, size, d.current)
  END (* IF *)

END JumpChunk;

(*---------------------------------------------------------------------------*)

PROCEDURE ReadILBM (name : y.ADDRESS; VAR bmhd : dd.BitMapHeader;
                    VAR body, cmap : y.ADDRESS) : BOOLEAN;
(* Liest ILBM ein und liefert body, colortable und BitMapHeader zurück *)

VAR colorBuffer        : LongCardPtr;
    color              : y.ADDRESS;
    datei              : d.FileHandlePtr;
    i, id, size, dummy : LONGINT;
    ok                 : BOOLEAN;

BEGIN (* ReadILBM *)

  ok := TRUE;
  datei := D.Open (name, d.oldFile);
  IF datei <> NIL THEN
    IF D.Read (datei, y.ADR (id), 4) = 4 THEN
      IF id = ip.idFORM THEN
        IF D.Read (datei, y.ADR (size), 4) = 4 THEN
          IF D.Read (datei, y.ADR (id), 4) = 4 THEN
            IF id = dd.idILBM THEN
              LOOP
                IF NOT ok THEN EXIT
                ELSIF NextChunk (datei, id, size) THEN
                  IF id = dd.idBMHD THEN
                    IF size = SIZE (dd.BitMapHeader) THEN
                      IF ReadChunk (datei, y.ADR (bmhd), size) THEN
                      ELSE h.Deallocate (body); ok := FALSE
                      END (* IF *)
                    ELSE h.Deallocate (body); ok := FALSE
                    END (* IF *)
                  ELSIF id =  dd.idCMAP THEN
                    h.Allocate (color, size);
                    h.Allocate (cmap, size * SIZE (LONGCARD));
                    IF color <> NIL THEN
                      IF cmap <> NIL THEN
                        IF ReadChunk (datei, color, size) THEN
                          FOR i := 0 TO size-1 DO
                            y.CAST (LongCardPtr, cmap+(i*SIZE (LONGCARD)))^ := LONGCARD (y.CAST (ShortCardPtr, color+i)^)
                          END (* FOR *)
                        ELSE h.Deallocate (cmap); h.Deallocate (color); ok := FALSE
                        END (* IF *)
                      ELSE h.Deallocate (color); ok := FALSE
                      END (* IF *)
                    ELSE ok := FALSE
                    END (* IF *)
                  ELSIF id = dd.idBODY THEN
                    h.Allocate (body, size);
                    IF body <> NIL THEN
                      IF ReadChunk (datei, body, size) THEN
                      ELSE h.Deallocate (body); ok := FALSE
                      END (* IF *)
                    ELSE ok := FALSE
                    END (* IF *)
                  ELSE (* Unbekannte Chunks überspringen *)
                    JumpChunk (datei, size)
                  END (* CASE *)
                ELSE EXIT (* LOOP *)
                END (* IF *)
              END (* LOOP *)
            ELSE ok := FALSE
            END (* IF *)
          ELSE ok := FALSE
          END (* IF *)
        ELSE ok := FALSE
        END (* IF *)
      ELSE ok := FALSE
      END (* IF *)
    ELSE ok := FALSE
    END; (* IF *)
    D.Close (datei)
  ELSE ok := FALSE
  END; (* IF *)
  RETURN ok

END ReadILBM;

(*---------------------------------------------------------------------------*)
(* Field Class *)
(* Bodychunk, einzelnes vom Backgammonbrett *)
(*---------------------------------------------------------------------------*)

TYPE FieldDataPtr = POINTER TO FieldData;
     FieldData = RECORD
                   gads : ARRAY [0..5] OF MD.APTR;
                   body : y.ADDRESS;
                   cmap : y.ADDRESS;
                   bmhd : dd.BitMapHeader
                 END; (* RECORD *)

(*---------------------------------------------------------------------------*)

VAR tmp : FieldData;

PROCEDURE FieldNew (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR buffer         : ARRAY [0..28] OF LONGINT;
    data           : FieldDataPtr;
    background     : y.ADDRESS;
    typ, stones, x : LONGINT;
    image          : mFieldImagePtr;
    body, cmap     : y.ADDRESS;
    bmhd           : dd.BitMapHeader;

BEGIN (* FieldNew *)

  background := U.GetTagData (maFieldBackground, NIL, msg^.attrList);
  IF background <> NIL THEN
    image := y.CAST (mFieldImagePtr, U.GetTagData (maFieldImage, NIL, msg^.attrList));
    stones := U.GetTagData (maFieldStones, 0, msg^.attrList);
    IF image <> NIL THEN
      IF ReadILBM (y.ADR ("DATA:gfx/Brush/ClassicStoneEmpty.ilbm"), bmhd, body, cmap) THEN
      FOR x := 0 TO 5 DO
        IF stones > 0 THEN
          tmp.gads[x] := ML.mNewObject (y.ADR (MD.mcBodychunk), y.TAG (buffer,
                           MD.maBodychunkBody, image^.body,
                           MD.maBitmapWidth, image^.bmhd.width,
                           MD.maBitmapHeight, image^.bmhd.height,
                           MD.maBodychunkDepth, image^.bmhd.depth,
                           MD.maBitmapSourceColors, image^.cmap,
                           MD.maBodychunkCompression, image^.bmhd.compression,
                           MD.maFixHeight, image^.bmhd.height,
                           MD.maFixWidth, image^.bmhd.width,
                           MD.maBodychunkMasking, image^.bmhd.masking,
                           MD.maBitmapTransparent, image^.bmhd.transparent,
                         u.tagEnd));
          DEC (stones)
        ELSE
          tmp.gads[x] := ML.mNewObject (y.ADR (MD.mcBodychunk), y.TAG (buffer,
                           MD.maBodychunkBody, body,
                           MD.maBitmapWidth, bmhd.width,
                           MD.maBitmapHeight, bmhd.height,
                           MD.maFixHeight, image^.bmhd.height,
                           MD.maFixWidth, image^.bmhd.width,
                           MD.maBodychunkDepth, bmhd.depth,
                           MD.maBitmapSourceColors, cmap,
                           MD.maBodychunkCompression, bmhd.compression,
                           MD.maBodychunkMasking, bmhd.masking,
                           MD.maBitmapTransparent, bmhd.transparent,
                         u.tagEnd));
        END (* IF *)
      END; (* FOR *)
      typ := U.GetTagData (maFieldType, mvFieldTypeTriangle, msg^.attrList);
      CASE typ OF
      mvFieldTypeTriangle:
        obj := MCS.DoSuperNew (cl, obj, y.TAG (buffer,
                  MD.maBackground, background,
                  MD.maGroupHoriz, FALSE,
                  MD.maGroupSpacing, 0,
                  MD.maGroupSameSize, TRUE,
                  MD.maInnerBottom, 0,
                  MD.maInnerLeft, 0,
                  MD.maInnerRight, 0,
                  MD.maInnerTop, 0,
                  MM.Child, tmp.gads[5],
                  MM.Child, tmp.gads[4],
                  MM.Child, tmp.gads[3],
                  MM.Child, tmp.gads[2],
                  MM.Child, tmp.gads[1],
                  MM.Child, tmp.gads[0],
               u.tagEnd))
      ELSE
      END; (* CASE *)
      IF obj <> NIL THEN
      END (* IF *)
      END (* IF *)
    END (* IF *)
  END; (* IF *)
  RETURN obj

END FieldNew;

(*---------------------------------------------------------------------------*)

PROCEDURE FieldDispatcher (cl : i.IClassPtr; obj : y.ADDRESS; msg : y.ADDRESS) : y.ADDRESS;

VAR methodID : LONGCARD;

BEGIN (* FieldDispatcher *)

  methodID := y.CAST (i.Msg, msg)^.methodID;
  IF    methodID = i.omNEW        THEN RETURN FieldNew (cl, obj, msg)
  ELSE RETURN al.DoSuperMethodA (cl, obj, msg)
  END (* IF *)

END FieldDispatcher;

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

VAR FieldClass : MC.mCustomClassPtr;

(*---------------------------------------------------------------------------*)

VAR image           : mFieldImage;

PROCEDURE MainNew (cl : i.IClassPtr; obj : i.ObjectPtr; msg : i.OpSetPtr) : y.ADDRESS;

VAR buffer, buffer2 : ARRAY [0..20] OF LONGINT;
    data            : MainDataPtr;
    board           : MD.APTR;
    body, cmap      : y.ADDRESS;
    bmhd            : dd.BitMapHeader;
    dummy           : LONGCARD;
    image           : mFieldImage;

BEGIN (* MainNew *)

  IF ReadILBM (y.ADR ("DATA:gfx/Brush/ClassicStoneWhite.ilbm"), image.bmhd, image.body, image.cmap) THEN
    board := I.NewObjectA (FieldClass^.class, NIL, y.TAG (buffer,
               maFieldBackground, y.ADR ("5:DATA:gfx/Brush/ClassicTriangleWhite.ilbm"),
               maFieldType, mvFieldTypeTriangle,
               maFieldImage, y.ADR (image),
               maFieldStones, 2,
             u.tagDone));

    obj := MCS.DoSuperNew (cl, obj, y.TAG (buffer,
              MD.maWindowTitle, y.ADR ("MUIBackgammon © 1996, Marc Ewert"),
              MD.maWindowID, MM.MakeID ("MAIN"),
              MD.maBackground, MD.miWindowBack,
              MM.WindowContents,
              MM.HGroup (y.TAG (buffer2,
                MM.Child, board,
                MM.Child, MM.HSpace(0),
              u.tagEnd)),
           u.tagEnd));
  END; (* IF *)
  RETURN obj

END MainNew;

(*---------------------------------------------------------------------------*)

PROCEDURE MainDispatcher (cl : i.IClassPtr; obj : y.ADDRESS; msg : y.ADDRESS) : y.ADDRESS;

VAR methodID : LONGCARD;

BEGIN (* MainDispatcher *)

  methodID := y.CAST (i.Msg, msg)^.methodID;
  IF    methodID = i.omNEW THEN RETURN MainNew (cl, obj, msg)
  ELSE RETURN al.DoSuperMethodA (cl, obj, msg)
  END (* IF *)

END MainDispatcher;

(*---------------------------------------------------------------------------*)

VAR NULL      : MD.APTR;
    signals   : y.LONGSET;
    app, win  : MD.APTR;
    buffer    : ARRAY [0..16] OF LONGINT;
    MainClass : MC.mCustomClassPtr;

BEGIN (* test *)

  NULL := NIL;
  IF NOT MCS.InitClass (MainClass, NIL, y.ADR (MD.mcWindow), NIL, SIZE(MainData), MainDispatcher) THEN
    MS.fail (NULL, "Could not create custom class.")
  END; (* IF *)
  IF NOT MCS.InitClass (FieldClass, NIL, y.ADR (MD.mcGroup), NIL, SIZE(FieldData), FieldDispatcher) THEN
    MS.fail (NULL, "Could not create custom class.")
  END; (* IF *)

  win := I.NewObjectA (MainClass^.class, NIL, y.TAG (buffer, u.tagDone));

  app := MM.ApplicationObject(y.TAG(buffer,
           MD.maApplicationTitle,        y.ADR("MUIBackgammon"),
           MD.maApplicationAuthor,       y.ADR("Marc Ewert"),
           MD.maApplicationVersion,      y.ADR("$VER: MUIBackgammon 1.0 (11.03.96)"),
           MD.maApplicationCopyright,    y.ADR("© 1996, Marc Ewert"),
           MD.maApplicationDescription,  y.ADR("Backgammon Game"),
           MD.maApplicationBase,         y.ADR("MUIBACKGAMMON"),
           (* MD.maApplicationMenustrip,    strip, *)
           MM.SubWindow,                 win,
           u.tagEnd));

  IF app <> NIL THEN
    MM.NoteClose (app, win, MD.mvApplicationReturnIDQuit);
    MM.set (win, MD.maWindowOpen, 1);
    signals := y.LONGSET{} ;
    LOOP
      IF MS.DOMethod (app, y.TAG (buffer, MD.mmApplicationNewInput, y.ADR(signals))) = MD.mvApplicationReturnIDQuit THEN EXIT END; (* IF *)
      IF signals <> y.LONGSET{} THEN
        INCL (signals, d.ctrlC);
        signals := E.Wait (signals);
        IF d.ctrlC IN signals THEN EXIT
        END (* IF *)
      END (* IF *)
    END; (* LOOP *)
    MM.set (win, MD.maWindowOpen, 0)
  END (* IF *)

CLOSE

  IF app <> NIL THEN ML.mDisposeObject (app)
  END; (* IF *)
  MCS.RemoveClass (MainClass);
  MCS.RemoveClass (FieldClass)


END test.


IMPLEMENTATION MODULE QuickIntuition; (* EBM 11-90 *)

(*  3-94 new WriteText and modified default Font as topaz9 when NIL+1 *)
(* 10-95 MakeImage, Planes+100 would always set planePick=256 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=TRUE StackParms:=TRUE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT
  ADDRESS,ADR,BITSET,CAST,LONGSET;
FROM Arts IMPORT
  Assert,Terminate;
FROM IntuitionD IMPORT
  boolGadget, stdScreenHeight, ActivationFlags, ActivationFlagSet, Gadget,
  GadgetPtr, GadgetFlags, GadgetFlagSet, IDCMPFlags, IDCMPFlagSet,
  IntuiMessagePtr, NewWindow, WindowPtr,ScreenPtr,
  WindowFlagSet, WindowFlags, ScreenFlagSet, IntuiText,
  ScreenFlags, StringInfo, StringInfoPtr,strGadget,
  propGadget, PropInfo, PropInfoFlags, PropInfoFlagSet, PropInfoPtr, ImagePtr,
  customScreen, IntuiTextPtr, BorderPtr, NewScreen;
FROM IntuitionL IMPORT
  CloseWindow, OpenWindow, OpenScreen, CloseScreen, RefreshGadgets, PrintIText;
FROM GraphicsD IMPORT
  RastPortPtr,DrawModeSet,DrawModes,BitMapPtr,TextAttr,TextAttrPtr,
  FontStyleSet,FontFlagSet,FontFlags,ViewModes,ViewModeSet;
FROM GraphicsL IMPORT
  SetDrMd,DrawEllipse,WritePixel,ClearScreen,Move,Draw,SetRast,
  RectFill,OpenFont,CloseFont;
FROM ExecD IMPORT
  MemReqs,MemReqSet;
FROM ExecL IMPORT
  ReplyMsg,WaitPort,GetMsg,FreeMem;
FROM Heap IMPORT
  Allocate, AllocMem;
FROM String IMPORT
  Length;
(*$ IF Test *)
FROM W IMPORT
  WRITE, WRITELN, s, l, lf, bf;
(*$ ENDIF *)


PROCEDURE AddBorder(gd:GadgetPtr; select:BOOLEAN; leftedge,topedge :INTEGER;
                    frontpen,backpen :SHORTCARD; drawmode:DrawModeSet; Count:SHORTCARD;
                    Xy:ADDRESS);
VAR
  bptr:BorderPtr;
BEGIN
  Allocate(bptr,SIZE(bptr^));
  WITH bptr^ DO
    leftEdge:=leftedge;
    topEdge:=topedge;
    frontPen:=frontpen;
    backPen:=backpen;
    drawMode:=drawmode;
    count:=Count;
    xy:=Xy;
    IF select THEN
      nextBorder := gd^.selectRender;
    ELSE
      nextBorder := gd^.gadgetRender;
    END;
  END;
  IF select THEN
    gd^.selectRender := bptr;
  ELSE
    gd^.gadgetRender := bptr;
  END;
END AddBorder;

(* Fjernet, bruges ikke mere *)
PROCEDURE AllocateChip(VAR ptr:ADDRESS; Bytes:CARDINAL);
BEGIN
  AllocMem(ptr,Bytes,TRUE);
END AllocateChip;

(*
TYPE
  AllocInfoPtr=POINTER TO AllocInfo;
  AllocInfo=RECORD
              cptr:ADDRESS;
              bytes:CARDINAL;
              next:AllocInfoPtr;
            END;
VAR
  ChipHeap:AllocInfoPtr;                      

PROCEDURE AllocateChip(VAR ptr:ADDRESS; Bytes:CARDINAL);
VAR
  chptr:AllocInfoPtr;
BEGIN
  ptr:=AllocMem(Bytes,MemReqSet{chip}); 
  IF ptr=NIL THEN Terminate(0) END;
  Allocate(chptr,SIZE(chptr^));
  chptr^.cptr:=ptr;
  chptr^.bytes:=Bytes;
  chptr^.next:=ChipHeap;
  ChipHeap:=chptr;
END AllocateChip;

PROCEDURE FreeChip;
VAR
  chptr:AllocInfoPtr;
BEGIN
  WHILE ChipHeap<>NIL DO
    chptr:=ChipHeap^.next;
    FreeMem(ChipHeap^.cptr,ChipHeap^.bytes);
    ChipHeap:=chptr;
  END;
END FreeChip;
*)

PROCEDURE AddGadget(VAR gp:GadgetPtr; leftedge,topedge,Width,Height:INTEGER;
                    gfs:GadgetFlagSet; afs:ActivationFlagSet;
                    (* gadgettype:CARDINAL; *) gadgetrender:ADDRESS;
                    selectrender:ADDRESS; gadgettext:ADDRESS;
                    specialinfo:ADDRESS; gadgetid:INTEGER; userdata:ADDRESS);
VAR
  gptr:GadgetPtr;
BEGIN
  Allocate(gptr,SIZE(Gadget));
  WITH gptr^ DO
    nextGadget    := gp;
    leftEdge      := leftedge;
    topEdge       := topedge;
    width         := Width;
    height        := Height;
    flags         := gfs;
    activation    := afs;
    gadgetType    := boolGadget;
    gadgetRender  := gadgetrender;
    selectRender  := selectrender;
    gadgetText    := gadgettext;
    mutualExclude := LONGSET{};
    specialInfo   := specialinfo;
    gadgetID      := gadgetid;
    userData      := userdata;
  END;
  gp:=gptr;
END AddGadget;

PROCEDURE AddStringInfo(gp:GadgetPtr; maxchars:INTEGER; string:ARRAY OF CHAR);
VAR
  siptr:StringInfoPtr;
  ptr:ADDRESS;
  stptr:POINTER TO ARRAY[0..80] OF CHAR;
  n:CARDINAL;
BEGIN
  gp^.gadgetType := strGadget;
  INC(maxchars);
  Allocate(siptr,SIZE(StringInfo));
  Allocate(ptr,maxchars);
  stptr:=ptr;
  FOR n:=0 TO HIGH(string) DO
    stptr^[n]:=string[n];
  END;
  siptr^.buffer    := ptr;
  Allocate(ptr,maxchars);
  siptr^.undoBuffer:= ptr;
  siptr^.maxChars  := maxchars;
  siptr^.dispPos   := 1;
  siptr^.altKeyMap := NIL;
  gp^.specialInfo  := siptr;
END AddStringInfo;

PROCEDURE AddGadgetImage(gp:GadgetPtr; select:BOOLEAN; leftedge,topedge,Width,
                         Height,Depth:CARDINAL; imagedata:ImagePtr;
                         planepick,planeonoff:SHORTCARD);
VAR
  iptr:ImagePtr;
BEGIN
  IF select THEN
    gp^.flags:=gp^.flags+GadgetFlagSet{gadgHImage};
  ELSE
    gp^.flags:=gp^.flags+GadgetFlagSet{gadgImage};
  END;
  IF gp^.width=0 THEN gp^.width := Width END;
  IF gp^.height=0 THEN gp^.height := Height END;
  Allocate(iptr,SIZE(iptr^));
  WITH iptr^ DO
    leftEdge  := leftedge;
    topEdge   := topedge;
    width     := Width;
    height    := Height;
    depth     := Depth;
    imageData := imagedata;
    planePick := planepick; (* byte, 1=bitplan 0 sættes til forgrund *)
    planeOnOff:= planeonoff; (* byte, 2=bitplan 1 sættes til baggrund *)
    IF select THEN
      nextImage := gp^.selectRender;
    ELSE
      nextImage := gp^.gadgetRender;
    END;
  END;
  IF select THEN
    gp^.selectRender:=iptr;
  ELSE
    gp^.gadgetRender:=iptr;
  END;
END AddGadgetImage;

PROCEDURE SetGadgetImage(gp:GadgetPtr; select:BOOLEAN; imagePtr:ImagePtr);
VAR
  iptr:ImagePtr;
BEGIN
  IF gp^.width =0 THEN gp^.width  := imagePtr^.width  END;
  IF gp^.height=0 THEN gp^.height := imagePtr^.height END;
  IF select THEN
    INCL(gp^.flags,gadgHImage);
    gp^.selectRender:=imagePtr;
  ELSE
    INCL(gp^.flags,gadgImage);
    gp^.gadgetRender:=imagePtr;
  END;
END SetGadgetImage;

PROCEDURE ChipPicture(ProcedureAdr:ADDRESS;Words:CARDINAL):ADDRESS;
TYPE
  PICARR=ARRAY[0..32767] OF CARDINAL;
VAR
  picptr,pihptr:POINTER TO PICARR;
  n:CARDINAL;
BEGIN
  pihptr:=ProcedureAdr;                      (* giver TYPE Binding til ARRAY *)
  AllocateChip(picptr,Words*2);              (* alloker chipmemory *)
  IF picptr<>NIL THEN
    FOR n:=0 TO Words-1 DO                   (* kopier data        *)
      picptr^[n]:=pihptr^[n];
    END;
  END;
  RETURN(picptr);                            (* returner ptr til picture *)
END ChipPicture;

PROCEDURE MakeImage(Width,Height,Depth:CARDINAL; ImageDataAdr:ADDRESS):ImagePtr;
VAR
  iptr:ImagePtr;
BEGIN
  Allocate(iptr,SIZE(iptr^));
  IF iptr<>NIL THEN
    WITH iptr^ DO
      leftEdge  := 0;
      topEdge   := 0;
      width     := Width;
      height    := Height;
      IF Depth>100 THEN
        depth     := Depth-100;
        imageData := ImageDataAdr;
      ELSE
        depth     := Depth;
        imageData := ChipPicture(ImageDataAdr,((Width-1) DIV 16+1)*Height*Depth);
      END; 
      CASE depth OF
        | 1 : planePick:=1;
        | 2 : planePick:=3;
        | 3 : planePick:=7;
        | 4 : planePick:=15;
        | 5 : planePick:=31;
        | 6 : planePick:=63;
        | 7 : planePick:=127;
      ELSE 
        planePick:=255;
      END; 
      planeOnOff:= 0;  
    END;
  END;
  RETURN(iptr);
END MakeImage;

PROCEDURE OutLine(gp:GadgetPtr):ADDRESS;
VAR
  old:POINTER TO ARRAY[0..11] OF CARDINAL; (* OutLineData *)
  xs,ys:INTEGER;
BEGIN
  xs:=gp^.width+3;
  ys:=gp^.height+1;
  Allocate(old,SIZE(old^));
  old^[3]:=ys;
  old^[4]:=xs;
  old^[5]:=ys;
  old^[6]:=xs;
  RETURN(old);
END OutLine;

PROCEDURE AddPropInfo(gp:GadgetPtr; Flags:PropInfoFlagSet; horizpot,vertpot,
                      horizbody,vertbody:CARDINAL);
VAR
  piptr : PropInfoPtr;
BEGIN
  gp^.gadgetType := propGadget;
  Allocate(piptr,SIZE(PropInfo));
  WITH piptr^ DO
    flags      := Flags;
    horizPot   := horizpot;
    vertPot    := vertpot;
    horizBody  := horizbody;
    vertBody   := vertbody;
  END;
  gp^.specialInfo := piptr;
END AddPropInfo;

VAR
  nw: NewWindow;

PROCEDURE AddWindow(VAR wptr:WindowPtr; title:ADDRESS;
                       leftedge,topedge,Width,Height:INTEGER;
                       detailpen,blockpen:SHORTINT; idcmpflags:IDCMPFlagSet;
                       Flags:WindowFlagSet; firstgadget:GadgetPtr;
                       Screen:ScreenPtr; superbitmap:BitMapPtr;
                       minwidth,minheight,maxwidth,maxheight:INTEGER);
BEGIN
  nw.leftEdge:=leftedge; nw.topEdge:=topedge;
  nw.width:=Width; nw.height:=Height;
  nw.detailPen:=detailpen; nw.blockPen:=blockpen;
  nw.idcmpFlags:=idcmpflags;
  nw.flags:=Flags;
  nw.firstGadget:=firstgadget;
  nw.checkMark:=NIL;
  nw.title:=title;
  nw.screen:=Screen;
  nw.bitMap:=superbitmap;
  nw.minWidth:=minwidth;
  nw.minHeight:=minheight;
  nw.maxWidth:=maxwidth;
  nw.maxHeight:=maxheight;
  IF Screen=NIL THEN
    nw.type:=ScreenFlagSet{wbenchScreen};
(*$ IF Test*)
  WRITELN(s("aw:~ScrOn"));
(*$ ENDIF *)
  ELSE
    nw.type:=customScreen;
  END;
  wptr:=OpenWindow(nw);
  Assert(wptr # NIL, ADR('could not open window'));
END AddWindow;

VAR
  TxtFontPtr:ADDRESS;
  textattr:TextAttr;

PROCEDURE AddScreen(VAR sptr:ScreenPtr; leftedge,topedge,
                    Width,Height, Depth:INTEGER; 
                    detailpen,blockpen:SHORTINT; viewmodes:ViewModeSet;
                    Type:ScreenFlagSet; Font:TextAttrPtr;
                    DefaultTitle:ADDRESS; Gadgets:GadgetPtr;
                    custombitmap:BitMapPtr);
VAR
  ns:NewScreen;
BEGIN
  WITH ns DO
    leftEdge:=leftedge;
    topEdge:=topedge;
    width:=Width;
    height:=Height;
    depth:=Depth;
    detailPen:=detailpen;
    blockPen:=blockpen;
    viewModes:=viewmodes;
    type:=Type;
    IF Font=TextAttrPtr(LONGINT(1)) THEN
      font:=ADR(textattr);
      TxtFontPtr:=OpenFont(ADR(textattr));
    ELSE 
      font:=Font;
    END;
    defaultTitle:=DefaultTitle;
    gadgets:=Gadgets;
    customBitMap:=custombitmap;
  END;
  sptr:=OpenScreen(ns);
END AddScreen;

PROCEDURE SetTextAttr(Name:ADDRESS; ysize:CARDINAL; Style:FontStyleSet;
                      Flags:FontFlagSet);
BEGIN
  IF ~(TxtFontPtr=NIL) THEN
    CloseFont(TxtFontPtr);
    TxtFontPtr:=NIL;
  END;
  textattr.name :=Name;
  textattr.ySize:=ysize;
  textattr.style:=Style;       (* underlined,bold,italic,extended *)
  textattr.flags:=Flags;       (* romFont,diskFont,,,,proportional,, *)
END SetTextAttr;

PROCEDURE AddIntuiText(gp:GadgetPtr; frontpen,backpen:SHORTCARD;
                       drawmode:DrawModeSet;
                       leftedge,topedge:INTEGER; itext:ADDRESS);
VAR
  itptr:IntuiTextPtr;
BEGIN
  Allocate(itptr,SIZE(itptr^));
  WITH itptr^ DO
    frontPen := frontpen;
    backPen  := backpen;
    drawMode := drawmode; (* dm0,complement,inversvid *)
    leftEdge := leftedge;
    topEdge  := topedge;
    iTextFont:= ADR(textattr);
    iText    := itext;
    nextText := gp^.gadgetText;
  END;
  IF TxtFontPtr=NIL THEN
    TxtFontPtr:=OpenFont(ADR(textattr));
  END;
  gp^.gadgetText:=itptr;
END AddIntuiText;

PROCEDURE WriteText(rp:RastPortPtr; StringPtr:ADDRESS; leftoffset,topoffset:INTEGER);
VAR
  itx : IntuiText;
BEGIN
  WITH itx DO
    frontPen:=2;
    backPen:=1;
    drawMode:=DrawModeSet{dm0};
    leftEdge:=0;
    topEdge:=0;
    iTextFont:=ADR(textattr);
    iText:=StringPtr;
    nextText:=NIL;
  END;
  IF TxtFontPtr=NIL THEN
    TxtFontPtr:=OpenFont(ADR(textattr));
  END;
  PrintIText(rp,ADR(itx),leftoffset,topoffset);
END WriteText;

PROCEDURE SetString(gptr:GadgetPtr; st:ARRAY OF CHAR);
VAR
  stptr:POINTER TO ARRAY[0..80] OF CHAR;
  siptr:StringInfoPtr;
  n:INTEGER;
BEGIN
  IF gptr<>NIL THEN
    siptr:=gptr^.specialInfo;
    stptr:=siptr^.buffer;
    n:=0;
    WHILE (n<HIGH(st)) & (st[n]<>0C) & (n<80) DO 
      stptr^[n] := st[n];
      INC(n);
    END;
    IF n=HIGH(st) THEN DEC(n) END;
    stptr^[n]:=0C;
  END;
END SetString;

PROCEDURE GetString(gptr:GadgetPtr; VAR st:ARRAY OF CHAR);
VAR
  stptr:POINTER TO ARRAY[0..80] OF CHAR;
  siptr:StringInfoPtr;
  n,max:INTEGER;
BEGIN  
  IF gptr<>NIL THEN
    siptr:=gptr^.specialInfo;
    stptr:=siptr^.buffer;
    max:=Length(stptr^);
    IF max>=HIGH(st) THEN
      max:=HIGH(st)-1;
    END;
    FOR n:=0 TO max-1 DO
      st[n]:=stptr^[n];
    END;
    st[max]:=0C;
  END;
END GetString;

BEGIN
(*$IF Test *)
  WRITELN(s('QuickIntuition.1'));
(*$ENDIF *)
  TxtFontPtr:=NIL;
  SetTextAttr(ADR('topaz.font'),9,FontStyleSet{},FontFlagSet{romFont});
(*$IF Test *)
  WRITELN(s('QuickIntuition.2'));
(*$ENDIF *)
CLOSE
(*$IF Test *)
  WRITELN(s('QuickIntuition.3'));
(*$ENDIF *)
  IF ~(TxtFontPtr=NIL) THEN
    CloseFont(TxtFontPtr);
  END;
(*$IF Test *)
  WRITELN(s('QuickIntuition.4'));
(*$ENDIF *)
END QuickIntuition.

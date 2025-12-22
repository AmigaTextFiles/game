IMPLEMENTATION MODULE QISupport; (* rev. 17/11-95 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=TRUE StackParms:=TRUE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=FALSE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

(* 1-96 Place cursor in editor with mouse-click, OK *)

FROM SYSTEM IMPORT
  ADR, ADDRESS, ASSEMBLE, CAST;
FROM String IMPORT
  Copy, Concat, ConcatChar, Length, Compare, CapString;
FROM Heap IMPORT
  Allocate, Deallocate;
FROM GraphicsD IMPORT
  RastPortPtr, DrawModeSet, DrawModes, ViewModes, ViewModeSet, TextAttrPtr,
  FontStyleSet, FontFlags, FontFlagSet;
FROM GraphicsL IMPORT
  SetDrMd, Move, Draw, SetAPen, RectFill;
FROM ExecL IMPORT
  ReplyMsg, WaitPort, GetMsg, AvailMem, Forbid, Permit;
FROM IntuitionD IMPORT
  boolGadget, stdScreenHeight, GadgetPtr, IDCMPFlagSet, IDCMPFlags,
  IntuiMessagePtr, WindowPtr, WindowFlags, WindowFlagSet,
  strGadget, propGadget, PropInfoPtr, StringInfoPtr, gadgHNone,
  IntuiText, IntuiTextPtr, ScreenFlags, ScreenFlagSet, ScreenPtr;
FROM IntuitionL IMPORT
  CloseWindow, CloseScreen,  RefreshGList, RefreshGadgets, PrintIText,
  NewModifyProp, ActivateGadget, ActivateWindow, BeginRefresh, EndRefresh,
  RemoveGList, AddGList, DrawImage;
FROM InputEvent	IMPORT	
  Qualifiers,QualifierSet;
FROM QuickIntuition IMPORT
  AF, AFS, GF, GFS, AddGadget, AddIntuiText, AddWindow;
(*$ IF Test *)
FROM W IMPORT
  WRITE, WRITELN, s, l, lf, bf;
(*$ ENDIF *)

CONST
  FontXc = 8;
  FontYc = 9;
  txtUPSc =' UPS! ';
  txtOKc  ='  OK  ';
  txtDROPc=' DROP ';

VAR
  First:BOOLEAN;
  ScrXdef,ScrYdef:INTEGER;
  winMusX,winMusY:INTEGER;

PROCEDURE InitFontAndScrSz;
VAR
  vin:WindowPtr;
BEGIN
  First:=FALSE;
  AddWindow(vin,ADR(''), 0,20, 40,20, 0,1, IDCMPFlagSet{},
            WindowFlagSet{borderless,backDrop},NIL,swptr,NIL, 40,20, 40,20);
  WITH  vin^.rPort^.font^ DO
    FontX:=xSize;
    FontY:=ySize;
  END;
  IF swptr=NIL THEN
    ScrYdef:=vin^.wScreen^.height;
    ScrXdef:=vin^.wScreen^.width;
  END;
(*$ IF Test*)
  WRITELN(s('FontX=')+l(FontX)+s(' FontY=')+l(FontY));
(*$ ENDIF *)
  CloseWindow(vin);
END InitFontAndScrSz;

PROCEDURE MarkGadget(gptr:GadgetPtr; rp:RastPortPtr);
VAR
  xf,xt,yf,yt:INTEGER;
BEGIN
(*$ IF Test*)
  WRITELN(s('MarkGadget'));
(*$ ENDIF *)
  IF gptr<>NIL THEN
    WITH gptr^ DO
      xf:=leftEdge;
      xt:=leftEdge+width-1;
      yf:=topEdge;
      yt:=topEdge+height-1;
      SetAPen(rp,0);
      Move(rp,xf,yf);
      Draw(rp,xt,yf);
      Draw(rp,xt,yt);
      Draw(rp,xf,yt);
      Draw(rp,xf,yf);

      INC(xf);DEC(xt);INC(yf);DEC(yt);
      SetAPen(rp,1);
      Move(rp,xf,yf);
      Draw(rp,xt,yf);
      Draw(rp,xt,yt);
      Draw(rp,xf,yt);
      Draw(rp,xf,yf);
    END;
  END;
END MarkGadget;

PROCEDURE RefreshGadget(gptr:GadgetPtr; wptr:WindowPtr);
VAR
  gpo:GadgetPtr;
BEGIN
(*$ IF Test0 *)
  WRITELN(s('RefreshGadget'));
(*$ ENDIF *)
  IF (gptr<>NIL) & (wptr<>NIL) THEN
    gpo:=gptr^.nextGadget;
    Forbid;
      gptr^.nextGadget:=NIL;
    Permit;
    RefreshGList(gptr,wptr,NIL,1);
    Forbid;
      gptr^.nextGadget:=gpo;
    Permit;
  END;
END RefreshGadget;

PROCEDURE SetGadget(gptr:GadgetPtr; wptr:WindowPtr; OnOff:BOOLEAN);
BEGIN
(*$ IF Test0 *)
  WRITELN(s('SetGadget')+bf(OnOff,6));
(*$ ENDIF *)
  IF gptr<>NIL THEN
    IF OnOff=(gadgDisabled IN gptr^.flags) THEN
      Forbid;
        IF OnOff THEN
          EXCL(gptr^.flags,gadgDisabled);
        ELSE
          INCL(gptr^.flags,gadgDisabled);
        END;
      Permit;
      (*$ IF Test*)
        WRITELN(s(' OK'));
      (*$ ENDIF *)
      RefreshGadget(gptr,wptr);
    ELSE
      (*$ IF Test*)
        WRITELN(s(' Skipped'));
      (*$ ENDIF *)
    END;
  END;
END SetGadget;

PROCEDURE SetToggl(gptr:GadgetPtr; wptr:WindowPtr; OnOff:BOOLEAN);
VAR
  nr:INTEGER;
BEGIN
(*$ IF Test0 *)
  WRITELN(s('SetToggl'));
(*$ ENDIF *)
  IF gptr<>NIL THEN
    IF OnOff=(selected IN gptr^.flags) THEN
(*    nr:=RemoveGList(wptr,BG,-1); *)
      Forbid;
        IF OnOff THEN
          EXCL(gptr^.flags,selected);
        ELSE
          INCL(gptr^.flags,selected);
        END;
      Permit;

(*    nr:=AddGList(wptr,BG,-1,-1,NIL); *)
(*$ IF Test*)
      WRITELN(s(' OK'));
(*$ ENDIF *)
      RefreshGadget(gptr,wptr);
    ELSE
(*$ IF Test*)
      WRITELN(s(' Skip'));
(*$ ENDIF *)
    END;
  END;
END SetToggl;

PROCEDURE GetToggl(gptr:GadgetPtr):BOOLEAN;
BEGIN
(*$ IF Test*)
  WRITELN(s('GetToggl'));
(*$ ENDIF *)
  IF gptr=NIL THEN RETURN(FALSE) END;
  RETURN(selected IN gptr^.flags);
END GetToggl;

VAR
  AppendGadgets:BOOLEAN;

PROCEDURE CREATEWIN(VAR Vindue:VINDUE; UPS,OK,DROP,Size:BOOLEAN);
VAR
  n:INTEGER;
BEGIN
(*$IF Test *)
  WRITELN(s('CREATEWIN'));
(*$ENDIF *)
  Vindue.Window   :=NIL;
  IF AppendGadgets THEN
    AppendGadgets:=FALSE;
  ELSE
    Vindue.Gadgets  :=NIL;
  END;
  Vindue.Tekst    :=NIL;
  IF Size THEN
    n:=16
  ELSE
    n:=0;
  END;
  IF UPS THEN
    n:=n+70;
    AddGadget(Vindue.Gadgets, -n, -14,  64, 12, GFS{gRelBottom,gRelRight},AFS{relVerify},
              NIL,NIL,NIL,NIL,0,NIL);
    AddIntuiText(Vindue.Gadgets, 2,3, DrawModeSet{dm0}, 4,2, txtUPS);
  END;
  IF DROP THEN
    n:=n+70;
    AddGadget(Vindue.Gadgets, -n, -14,  64, 12, GFS{gRelBottom,gRelRight},AFS{relVerify},
              NIL,NIL,NIL,NIL,2,NIL);
    AddIntuiText(Vindue.Gadgets, 2,3, DrawModeSet{dm0}, 4,2, txtDROP);
  END;
  IF OK THEN
    n:=n+70;
    AddGadget(Vindue.Gadgets, -n, -14,  64, 12, GFS{gRelBottom,gRelRight},AFS{relVerify},
              NIL,NIL,NIL,NIL,1,NIL);
    AddIntuiText(Vindue.Gadgets, 2,3, DrawModeSet{dm0}, 4,2, txtOK);
  END;
  Vindue.MinMinX:=n+10;
  Vindue.SzX:=n+10;
  Vindue.SzY:=28;
  Vindue.PoX:=0;
  Vindue.PoY:=1;
END CREATEWIN;

VAR
  OldX,OldY:INTEGER;
  BigX,BigY,TinyX,TinyY:BOOLEAN;

PROCEDURE CURSOR(VAR Vindue:VINDUE; x,y:INTEGER);
VAR
  rp   :RastPortPtr;
  px,py:INTEGER;
BEGIN
  x:=x-Xofs;
  y:=y-Yofs;
  IF (Vindue.Window<>NIL) THEN
    rp:=Vindue.Window^.rPort;
    SetDrMd(rp,DrawModeSet{complement});
    IF OldX>=0 THEN (* Slet old *)
(*$IF Test *)
  WRITELN(s('Cur.Slet: OldX=')+l(OldX)+s(', OldY=')+l(OldY));
(*$ENDIF *)
      SetAPen(rp,0);
(*    Move(rp,OldX-1,OldY);
      Draw(rp,OldX-1,OldY+FontY-2); *)
      Move(rp,OldX,OldY);
      Draw(rp,OldX,OldY+FontY-2);
      Move(rp,OldX+1,OldY);
      Draw(rp,OldX+1,OldY+FontY-2);
    END;
    OldX:=-1;
    IF x>=0 THEN
      IF y>=0 THEN
        IF (y<(Vindue.Window^.height-FontY-FontY-7) DIV FontY) THEN
          IF  (x<(Vindue.Window^.width-FontX-10) DIV FontX) THEN
            px:=x*FontX+7;
            py:=y*FontY+FontY+4;
(*$IF Test *)
  WRITELN(s('Cur.vise:    X=')+l(px)+s(',    Y=')+l(py));
(*$ENDIF *)
            SetAPen(rp,3);
(*          Move(rp,px-1,py);
            Draw(rp,px-1,py+FontY-2);*)
            Move(rp,px,py);
            Draw(rp,px,py+FontY-2);
            Move(rp,px+1,py);
            Draw(rp,px+1,py+FontY-2);
            OldX:=px;
            OldY:=py;
          ELSE
            BigX:=TRUE;
          END;
        ELSE
          BigY:=TRUE;
        END;
      ELSE
        TinyY:=TRUE;
      END;
    ELSE
      TinyX:=TRUE;
    END;
    SetDrMd(rp,DrawModeSet{dm0});
  END;
END CURSOR;

PROCEDURE PRINTWIN(Vindue:VINDUE; X,Y:INTEGER; Tekst:STRINGPTR; FrontPen,BackPen:SHORTCARD);
VAR
  x,y,ww,wh,cx,whl,whc,wwc,ls :INTEGER;
  NNL :BOOLEAN;
  rp  :RastPortPtr;
  itx :IntuiText;
  strI,lstr:LONGINT;
  ch:CHAR;
(*$IF Test *)
  st  :ARRAY[0..199] OF CHAR;
(*$ENDIF *)
BEGIN
  IF (Vindue.Window<>NIL) & (Tekst<>NIL) THEN (*!!!!!!!!!!*)
    OldX:=-1;
    OldY:=-1;
    rp:=Vindue.Window^.rPort;
    ww:=Vindue.Window^.width-FontX;
    wh:=Vindue.Window^.height-FontY-FontY;           (* h-f-f: 98-16-16=66 *)
    whl:=(wh-7) DIV FontY; (* Writeable lines *)     (* (142-7) DIV 16 *)
    wwc:=(ww-10) DIV FontX+1; (* Writable Chars *)
    IF windowSizing IN Vindue.Window^.flags THEN
      wwc:=wwc-2;
    END;
    WITH itx DO
      frontPen:=FrontPen;
      backPen :=BackPen;
      iText   :=Tekst;
      drawMode:=DrawModeSet{dm0};
      leftEdge:=0;
      topEdge:=0;
      iTextFont:=NIL;
      nextText:=NIL;
    END;
    strI:=0;
    x:=X+7;
    y:=Y+FontY+4;
    lstr:=Length(Tekst^);
    whc:=0;
    REPEAT
(*$IF Test0 *)
  WRITELN(s('strI=')+l(strI)+s(' lstr=')+l(lstr));
(*$ENDIF *)
      NNL:=Tekst^[strI]<>0C;
      WHILE (strI<lstr) & (Tekst^[strI]<>12C) & NNL DO
        INC(strI);
        NNL:=Tekst^[strI]<>0C;
      END;
      IF NNL & (strI<lstr) THEN
        Tekst^[strI]:=0C;
      END;
(*$IF Test *)
  Copy(st,STRINGPTR(itx.iText)^);
  WRITELN(s('X,Y=')+l(X)+s(',')+l(Y)+s(' itx="')+s(st)+s('"'));
  WRITELN(s('x,y=')+l(x)+s(',')+l(y));
(*$ENDIF *)
      INC(whc);
      IF whc>Yofs THEN
(*$IF Test *)
  WRITELN(s('PRINTWIN: whl=')+l(whl)+s(' whc=')+l(whc));
(*$ENDIF *)
        ls:=Length(STRINGPTR(itx.iText)^);
        IF ls>Xofs THEN
          IF Xofs>0 THEN 
            itx.iText:=itx.iText+Xofs;
          END;
          IF ls-Xofs>wwc THEN
            ch:=STRINGPTR(itx.iText)^[wwc];
            STRINGPTR(itx.iText)^[wwc]:=0C;
          END;
          PrintIText(rp,ADR(itx),x,y);
          IF ls-Xofs>wwc THEN
            STRINGPTR(itx.iText)^[wwc]:=ch;
          END;
        END;
        y:=y+FontY;
      END;
      IF NNL & (strI<lstr) THEN
        Tekst^[strI]:=12C;
        INC(strI);
        itx.iText:=ADDRESS(Tekst)+strI;
      END;
    UNTIL ~NNL OR (strI>=lstr) OR (whc>=whl+Yofs);
  END;
END PRINTWIN;

PROCEDURE GETTEXTSIZE(Vindue:VINDUE; VAR wx,wy:INTEGER);
VAR
  xs,ys,xm:INTEGER;
  strI,lts:LONGINT;
BEGIN
  strI:=0;
  xs:=0;
  ys:=1;
  xm:=0;
  IF (Vindue.Tekst=NIL) THEN (*!!!!!!!!!!!!!!!*)
    xm:=0;
    ys:=0;
  ELSE
    lts:=Length(Vindue.Tekst^);
    WHILE (strI<lts) & (Vindue.Tekst^[strI]<>0C) DO
      IF Vindue.Tekst^[strI]=12C THEN
        INC(ys);
        IF xs>xm THEN
          xm:=xs;
        END;
        xs:=0;
      ELSE
        INC(xs);
      END;
      INC(strI);
    END;
    IF xs>xm THEN xm:=xs END;
  END;
  IF windowSizing IN WFS THEN
(*$ IF Test0 *)
  WRITELN(s('xm+2'));
(*$ ENDIF *)
    xm:=xm+2;
  END;
  wx:=xm*FontX;
  wy:=ys*FontY;
(*$IF Test *)
  WRITELN(s('GETTEXTSIZE wx=')+l(wx)+s(' wy=')+l(wy));
(*$ENDIF *)
END GETTEXTSIZE;

(*   -3=NoWindow,       -2=NoMsg,             -1=NoKnown,
      0=ESC/CLOSE/UPS,   1=RETURN/OK,      2-254=GadgetUp,
258-510=GadgetDown,    511=MousePos,      rawkey=512+Code
  768+2=newSize,    768+19=activeWindow,  768+20=inactiveWindow *)

PROCEDURE MSGWIN(Vindue:VINDUE; Wait:BOOLEAN):INTEGER;
VAR
  gnr   :INTEGER;
  gad   :GadgetPtr;
  msg   :IntuiMessagePtr;
  class :IDCMPFlagSet;
  mcode :CARDINAL;
BEGIN
(*$IF Test0 *)
  WRITELN(s('MSGWIN'));
(*$ENDIF *)
  gnr:=-3;
  IF Vindue.Window<>NIL THEN
    gnr:=-2;
(*$IF Test0 *)
  WRITELN(s('MSGWIN Window<>NIL'));
(*$ENDIF *)

    IF Wait THEN (*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*)
(*$IF Test0 *)
  WRITELN(s('MSGWIN Wait:'));
(*$ENDIF *)
      WaitPort(Vindue.Window^.userPort);          (* vent på input (message) *)
    END;
    msg:=GetMsg(Vindue.Window^.userPort);   (* overfør msg-class og evt. gadget ptr*)
    IF msg<>NIL THEN
      gnr:=-1;
      class :=msg^.class; (*IDCMPFlags*) (* til egne variable class, gad*)
      gad   :=msg^.iAddress;
      mcode :=msg^.code;
      qualifier:=msg^.qualifier;
      winMusX:=msg^.mouseX;
      winMusY:=msg^.mouseY;
      ReplyMsg(msg);                    (* returner/frigør message *)
(*$IF Test0 *)
  WRITELN(s('MSGWIN Replied'));
(*$ENDIF *)
      IF closeWindow IN class THEN
(*$IF Test0 *)
  WRITELN(s('MSGWIN close'));
(*$ENDIF *)
        gnr:=0;
      END;
      IF newSize IN class THEN
        gnr:=768+2;
      END;
      IF refreshWindow IN class THEN      (* kun ved simplerefresh vindue *)
(*$IF Test0 *)
  WRITELN(s('MSGWIN refresh'));
(*$ENDIF *)
        PRINTWIN(Vindue,0,0,Vindue.Tekst,1,0);
        gnr:=768+3;
      END;
      IF activeWindow IN class THEN 
(*$IF Test0 *)
  WRITELN(s('MSGWIN active'));
(*$ENDIF *)
        gnr:=768+19;
      END;
      IF inactiveWindow IN class THEN
(*$IF Test0 *)
  WRITELN(s('MSGWIN inactive'));
(*$ENDIF *)
        gnr:=768+20;
      END;
      IF rawKey IN class THEN
(*$IF Test0 *)
  WRITELN(s('MSGWIN rawKey=')+l(mcode)+s(' qualifier=?'));
(*$ENDIF *)
        IF mcode=kEsc THEN
          gnr:=0;
        ELSIF (mcode=kCr) OR (mcode=kCrN) (* space=40H *) THEN
          gnr:=1;
        ELSIF (mcode=40H) THEN
          gnr:=2;
        ELSE
          gnr:=512+mcode;
        END;
      END;
      IF vanillaKey IN class THEN
(*$IF Test0 *)
  WRITELN(s('MSGWIN vanillaKey=')+l(mcode));
(*$ENDIF *)
        IF mcode=27 THEN (* Esc *)
          gnr:=0;
        ELSE
          gnr:=1024+mcode;
        END;
      END;
      IF gadgetUp IN class THEN
        gnr:= gad^.gadgetID;
(*$IF Test0 *)
  WRITELN(s('MSGWIN GdUp'));
(*$ENDIF *)
      END;
      IF gadgetDown IN class THEN
(*$IF Test0 *)
  WRITELN(s('MSGWIN GdDown'));
(*$ENDIF *)
        gnr:= gad^.gadgetID+256;
      END;
    ELSE
(*$IF Test0 *)
  WRITELN(s('MSGWIN NoMsg'));
(*$ENDIF *)
    END;
  END;
(*$IF Test0 *)
  WRITELN(s('MSGWIN return gnr=')+l(gnr));
(*$ENDIF *)
  RETURN(gnr);
END MSGWIN;

PROCEDURE CLOSEWIN(VAR Vindue:VINDUE);
BEGIN
(*$IF Test *)
  WRITELN(s('CLOSEWIN'));
(*$ENDIF *)
  IF Vindue.Window<>NIL THEN
    REPEAT
(*$IF Test0 *)
  WRITELN(s('CLOSEWIN LOOP'));
(*$ENDIF *)
    UNTIL (MSGWIN(Vindue,FALSE)<-1);
    Vindue.PoX:=Vindue.Window^.leftEdge;
    Vindue.PoY:=Vindue.Window^.topEdge;
    Vindue.SzX:=Vindue.Window^.width;
    Vindue.SzY:=Vindue.Window^.height;
(*$IF Test *)
  WRITELN(s('PoX,PoY,SzX,SzY ')+lf(Vindue.PoX,4)+lf(Vindue.PoY,4)+lf(Vindue.SzX,4)+lf(Vindue.SzY,4));
(*$ENDIF *)
    WITH Vindue.Window^.rPort^.font^ DO (* opdater fontinfos, så næste OK *)
      FontX:=xSize;
      FontY:=ySize;
    END;
    CloseWindow(Vindue.Window);
    Vindue.Window:=NIL;
  END;
END CLOSEWIN;

PROCEDURE CLEARWIN(VAR Vindue:VINDUE; Size:BOOLEAN);
VAR
  x:INTEGER;
BEGIN
(*$IF Test *)
  WRITELN(s('CLEARWIN'));
(*$ENDIF *)
  OldX:=-1;
  OldY:=-1;
  x:=Vindue.Window^.width-3;
  IF Size THEN x:=x-16 END;
  SetAPen(Vindue.Window^.rPort,0);
  RectFill(Vindue.Window^.rPort,7,FontY+4,x,Vindue.Window^.height-3);
  RefreshGadgets(Vindue.Window^.firstGadget,Vindue.Window,NIL);
END CLEARWIN;

PROCEDURE OPENWIN(VAR Vindue:VINDUE; Title:STRINGPTR; MinX,MinY, MaxX,MaxY,
          PosX,PosY, ScrX,ScrY:INTEGER; Activate,OnMouse,OnCenter,
          Key,Raw,Size:BOOLEAN);
VAR
  n,wx,wy,mx,my:INTEGER;
BEGIN
(*$IF Test *)
  WRITELN(s('OPENWIN'));
  WRITELN(s('PoX,PoY,SzX,SzY ')+lf(Vindue.PoX,4)+lf(Vindue.PoY,4)+lf(Vindue.SzX,4)+lf(Vindue.SzY,4));
(*$ENDIF *)
  IF Key THEN
    INCL(IFS,vanillaKey);
  ELSE
    EXCL(IFS,vanillaKey);
  END;
  IF Raw THEN
    INCL(IFS,rawKey);
  ELSE
    EXCL(IFS,rawKey);
  END;
  IF First THEN InitFontAndScrSz END;
  IF ScrX<0 THEN
    IF swptr=NIL THEN
      ScrX:=ScrXdef;
    ELSE
      ScrX:=swptr^.width;
    END;
  END;
  IF ScrY<0 THEN
    IF swptr=NIL THEN
      ScrY:=ScrYdef;
    ELSE
      ScrY:=swptr^.height;
    END;
  END;
  IF Vindue.PoX<0 THEN Vindue.PoX:=0 END;
  IF Vindue.PoY<0 THEN Vindue.PoY:=1 END;
  IF Vindue.SzX<0 THEN Vindue.SzX:=48 END;
  IF Vindue.SzY<0 THEN Vindue.SzY:=28 END;
  IF PosX<0 THEN PosX:=Vindue.PoX END;
  IF PosY<0 THEN PosY:=Vindue.PoY END;
  IF MinX<0 THEN MinX:=Vindue.SzX END;
  IF MinY<0 THEN MinY:=Vindue.SzY END;
  IF MaxX<0 THEN MaxX:=ScrX END;
  IF MaxY<0 THEN MaxY:=ScrY END;
  IF MinX<Vindue.MinMinX THEN MinX:=Vindue.MinMinX END;
  IF MinY< 28 THEN MinY:= 28 END;
  IF MaxX<MinX THEN MaxX:=MinX END;
  IF MaxY<MinY THEN MaxY:=MinY END;

  IF Vindue.Window<>NIL THEN CLOSEWIN(Vindue) END;

  IF Size THEN 
    INCL(WFS,windowSizing);
  END;

  GETTEXTSIZE(Vindue,wx,wy);

  IF wx<Length(Title^)*FontX THEN
    wx:=Length(Title^)*FontX;
  END;
  wx:=wx+14;
  wy:=wy+FontY+FontY+7; 
  IF wx<MinX THEN wx:=MinX ELSIF wx>MaxX THEN wx:=MaxX END;
  IF wy<MinY THEN wy:=MinY ELSIF wy>MaxY THEN wy:=MaxY END;
  IF OnMouse THEN
    IF swptr=NIL THEN
      mx:=wbMusX;
      my:=wbMusY;
    ELSE
      mx:=swptr^.mouseX;
      my:=swptr^.mouseY;
    END;
    PosX:=mx-wx+40;
    PosY:=my-wy+15;
  END;
  IF OnCenter THEN
    PosX:=(ScrX-wx) DIV 2;
    PosY:=((ScrY-wy)*2) DIV 5;
  END;
  IF PosX>ScrX-wx THEN PosX:=ScrX-wx END; 
  IF PosX<0 THEN PosX:=0 END; 
  IF PosY>ScrY-wy THEN PosY:=ScrY-wy END; 
  IF PosY<0 THEN PosY:=0 END; 
(*$IF Test *)
  WRITELN(s('wx,wy=')+l(wx)+s(',')+l(wy)+s(' PosX,Y=')+l(PosX)+s(',')+l(PosY));
(*$ENDIF *)

  n:=0;
  REPEAT
    INC(n);
    AddWindow(Vindue.Window,Title, PosX,PosY, wx, wy, 0,1, 
            IFS,WFS,Vindue.Gadgets,swptr,NIL, Vindue.MinMinX,28, MaxX,MaxY);
    IF Vindue.Window=NIL THEN 
      INCL(WFS,simpleRefresh);
    END;
  UNTIL (Vindue.Window<>NIL) OR (n>1);
  IF Vindue.Window<>NIL THEN
    IF Activate THEN
      ActivateWindow(Vindue.Window);
    END;
    PRINTWIN(Vindue,0,0,Vindue.Tekst,1,0);
  END;
  IF Size THEN
    EXCL(WFS,windowSizing);
  END;
END OPENWIN;

PROCEDURE WAITWIN(VAR Vindue:VINDUE):INTEGER;
VAR
  m:INTEGER;
BEGIN
(*$IF Test *)
  WRITELN(s('WAITWIN'));
(*$ENDIF *)
  REPEAT 
    m:=MSGWIN(Vindue,TRUE);
  UNTIL (m=0) OR (m=1) OR (m=2);
  CLOSEWIN(Vindue);
  RETURN(m);
END WAITWIN;

VAR
  Vin1,Vin2,Vin3,Vin4:VINDUE;

(* OPENWIN(VAR Vindue:VINDUE; Title:STRINGPTR; MinX,MinY, MaxX,MaxY,
          PosX,PosY, ScrX,ScrY:INTEGER; Activate,OnMouse,OnCenter,
          Key,Raw,Size:BOOLEAN);*)

PROCEDURE SimpleWIN(string:STRINGPTR):INTEGER;
(* ok=1 (close=0) *)
BEGIN
(*$IF Test *)
  WRITELN(s('SimpleWIN'));
(*$ENDIF *)
  IF LONGINT(Vin1.Window)=4 THEN
    CREATEWIN(Vin1,FALSE,TRUE,FALSE,FALSE);
  END;
  Vin1.Tekst:=string;
  OPENWIN(Vin1,ADR(''), 1,1, -1,-1, 500,2, -1,-1,TRUE,~CenterWIN,CenterWIN,
          FALSE,TRUE,FALSE);
  RETURN(WAITWIN(Vin1));
END SimpleWIN;

PROCEDURE TwoGadWIN(string:STRINGPTR):INTEGER;
(* ok=1, ups/close=0 *)
BEGIN
(*$IF Test *)
  WRITELN(s('TwoGadWIN'));
(*$ENDIF *)
  IF LONGINT(Vin2.Window)=4 THEN
    CREATEWIN(Vin2,TRUE,TRUE,FALSE,FALSE);
  END;
  Vin2.Tekst:=string;
  OPENWIN(Vin2,ADR(''), 1,1, -1,-1, 500,2, -1,-1,TRUE,~CenterWIN,CenterWIN,
          FALSE,TRUE,FALSE);
  RETURN(WAITWIN(Vin2));
END TwoGadWIN;

PROCEDURE ThreeGadWIN(string:STRINGPTR):INTEGER;
(* ok=1, drop=2, ups/close=0 *)
BEGIN
(*$IF Test *)
  WRITELN(s('ThreeGadWIN'));
(*$ENDIF *)
  IF LONGINT(Vin3.Window)=4 THEN
    CREATEWIN(Vin3,TRUE,TRUE,TRUE,FALSE);
  END;
  Vin3.Tekst:=string;
  OPENWIN(Vin3,ADR(''), 1,1, -1,-1, 500,2, -1,-1,TRUE,~CenterWIN,CenterWIN,
          FALSE,TRUE,FALSE);
  RETURN(WAITWIN(Vin3));
END ThreeGadWIN;

PROCEDURE OpenInfoWIN(string:STRINGPTR);
BEGIN
(*$IF Test *)
  WRITELN(s('InfoWIN'));
(*$ENDIF *)
  IF LONGINT(Vin4.Window)=4 THEN
    CREATEWIN(Vin4,FALSE,FALSE,FALSE,FALSE);
  END;
  IF Vin4.Window<>NIL THEN
    CLOSEWIN(Vin4);
  END;
  Vin4.Tekst:=string;
  OPENWIN(Vin4,ADR(''), 1,1, -1,-1, 500,2, -1,-1,FALSE,FALSE,TRUE,
          FALSE,TRUE,FALSE);
END OpenInfoWIN;

PROCEDURE CloseInfoWIN;
BEGIN
  CLOSEWIN(Vin4);
END CloseInfoWIN;

PROCEDURE PrintInfoWIN(X,Y:INTEGER; Tekst:STRINGPTR);
BEGIN
  PRINTWIN(Vin4,X,Y,Tekst,1,0);
END PrintInfoWIN;

PROCEDURE MsgCloseInfoWIN():BOOLEAN;
BEGIN
  RETURN(MSGWIN(Vin4,FALSE)=0);
END MsgCloseInfoWIN;

VAR
  Vindue1:VINDUE;

PROCEDURE Edit(VAR txt:ARRAY OF CHAR; Title:ADDRESS; MinX,MinY, MaxX,MaxY,
               PosX,PosY:INTEGER; Size:BOOLEAN):INTEGER;
VAR
  res,X,Y,code,lt,n,cx,cy,MAXSIZE:INTEGER;
  cpx,cpy,cpp:INTEGER;
  Ins,clr,prt,cur:BOOLEAN;
  ch:CHAR;
PROCEDURE CP;
BEGIN
  cpx:=0;
  cpy:=0;
  cpp:=0;
  WHILE cpp<X DO
    INC(cpp);
    IF txt[cpp-1]=12C THEN
      cpx:=0;
      INC(cpy);
    ELSE
      INC(cpx);
    END;
  END;
END CP;
PROCEDURE CUR;
BEGIN
  CP; (* calcs CursorPos *)
(*$ IF Test *)
  WRITELN(s('CUR         Yofs=')+l(Yofs)+s(' cpy=')+l(cpy));
(*$ ENDIF *)
  CURSOR(Vindue1,cpx,cpy);
  WHILE TinyX OR TinyY OR BigX OR BigY DO
    IF TinyX THEN
      IF Xofs>3 THEN
        Xofs:=Xofs-4;
      ELSE
        Xofs:=0;
      END;
      TinyX:=FALSE;
    END;
    IF TinyY THEN
      Yofs:=Yofs-1;
      TinyY:=FALSE;
    END;
    IF BigX THEN
      Xofs:=Xofs+4;
      BigX:=FALSE;
    END;
    IF BigY THEN
      Yofs:=Yofs+1;
      BigY:=FALSE;
    END;
(*$ IF Test *)
  WRITELN(s('CUR BigTiny Yofs=')+l(Yofs)+s(' cpy=')+l(cpy));
(*$ ENDIF *)
    CLEARWIN(Vindue1,TRUE);
    PRINTWIN(Vindue1,0,0,ADR(txt),1,0);
    CURSOR(Vindue1,cpx,cpy);
  END;
END CUR;
BEGIN (* Edit *)
  BigX:=FALSE;
  BigY:=FALSE;
  TinyX:=FALSE;
  TinyY:=FALSE;
  MAXSIZE:=HIGH(txt);
  IF LONGINT(Vindue1.Window)=4 THEN
    Vindue1.Gadgets:=NIL;   (* 7, 4+FontY *)
    AddGadget(Vindue1.Gadgets, 1, FontY,  9999, 9999, gadgHNone,AFS{gadgImmediate},
              NIL,NIL,NIL,NIL,255,NIL);
    AppendGadgets:=TRUE; (* Monostable to keep gadgets made before CREATEWIN *)
    CREATEWIN(Vindue1,TRUE,TRUE,FALSE,TRUE);
  END;
  Vindue1.Tekst:=ADR(txt);
  OPENWIN(Vindue1,Title,MinX,MinY, MaxX,MaxY, PosX,PosY, -1,-1,TRUE,FALSE,FALSE,
          TRUE,TRUE,Size);
  Ins:=TRUE;
  X:=0;
  CUR;
  REPEAT
    clr:=FALSE;
    prt:=FALSE;
    cur:=FALSE;
    res:=MSGWIN(Vindue1,TRUE);
    IF res=NewSizeWIN THEN
      clr:=TRUE;
    END;
    IF res=511 THEN (* MouseClick-position the cursor *)
      cx:=(winMusX+2-7) DIV FontX+Xofs;
      IF (winMusX<7) THEN
        IF (cx>0) THEN DEC(cx) ELSE clr:=TRUE; cx:=0; END;
      END;
      cy:=(winMusY-4) DIV FontY-1+Yofs;
      IF (winMusY<4+FontY) THEN
        IF (cy>0) THEN DEC(cy) ELSE clr:=TRUE; cy:=0; END;
      END;
      X:=-1;
      REPEAT
        INC(X);
        CP; (* calcs CursorPos cpx,cpy *)
      UNTIL (txt[X]=0C) OR (X=MAXSIZE) OR (cpx=cx) & (cpy=cy) OR (cpy>cy);
      IF cpy>cy THEN
        DEC(X);
      END;
      cur:=TRUE;
(*$IF Test *)
  WRITELN(s('res=511  ')+l(winMusX)+l(winMusY));
(*$ENDIF *)
    END;
    IF (res>=512) & (res<768-128) THEN (* rawKey, keycode for down*)
      IF res=512+76 THEN (* Up *)
        cx:=0;
        WHILE (X>0) & (txt[X-1]<>12C) DO
          DEC(X);
          INC(cx);
        END;
        IF X>0 THEN DEC(X) END;
        WHILE (X>0) & (txt[X-1]<>12C) DO
          DEC(X);
        END;
        WHILE (txt[X]<>12C) & (cx>0) DO
          INC(X);
          DEC(cx);
        END;
        cur:=TRUE;
      END;
      IF (res=512+77) & (txt[X]<>0C) THEN (* Dn *)

       (* til liniestart, tæl *)
        cx:=0;
        WHILE (X>0) & (txt[X-1]<>12C) DO 
          DEC(X);
          INC(cx);
        END;

        (* til linieslut *)
        WHILE (X<MAXSIZE) & (txt[X]<>12C) & (txt[X]<>0C) DO
          INC(X);
        END;

        (* næste linie, hvis *)
        IF (X<MAXSIZE) & (txt[X]=12C) THEN INC(X) END; 

        (* til position, hvis *)
        WHILE (X<MAXSIZE) & (txt[X]<>12C) & (txt[X]<>0C) & (cx>0) DO
          INC(X);
          DEC(cx);
        END;
        cur:=TRUE;
      END;
      IF res=512+78 THEN (* Rt *)
        IF (X<MAXSIZE) & (txt[X]<>0C) THEN
          INC(X);
        END;
        cur:=TRUE;
      END;
      IF res=512+79 THEN (* Lt *)
        IF X>0 THEN
          DEC(X);
        END;
        cur:=TRUE;
      END;
(*
      IF res=512+95 THEN (* Help *)
      END;
      IF res=512+80 THEN (* F1 *)
        IF Xofs>3 THEN Xofs:=Xofs-4 END;
        clr:=TRUE;
      END;
      IF res=512+81 THEN (* F2 *)
        Xofs:=Xofs+4;
        clr:=TRUE;
      END;
      IF res=512+82 THEN (* F3 *)
        IF Yofs>1 THEN Yofs:=Yofs-2 END;
        clr:=TRUE;
      END;
      IF res=512+83 THEN (* F4 *)
        Yofs:=Yofs+2;
        clr:=TRUE;
      END;
*)
    END;
    IF (res>=1024) THEN (* vanillaKey, ASCII *)
      prt:=TRUE;
      ch:=CHR(res-1024);
      clr:=ch=15C;
      IF (ch>=' ') & (ch<177C) OR (ch>=240C) OR (ch=15C) THEN (* normal char *)
        IF Ins OR (ch=15C) THEN
          lt:=Length(txt);
          IF lt<MAXSIZE THEN
            FOR n:=lt TO X BY -1 DO
              txt[n+1]:=txt[n];
            END;
          END;
        END;
        IF ch=15C THEN ch:=12C END; (* CR to LF *)
        txt[X]:=ch;
        IF X<MAXSIZE THEN
          INC(X);
        END;
      ELSIF (ch=10C) & (X>0) OR (ch=177C) THEN (* BackSpace or Del *) 
        clr:=TRUE;
        IF ch=10C THEN DEC(X) END;
        FOR n:=X TO Length(txt)-1 DO
          IF n<MAXSIZE THEN
            txt[n]:=txt[n+1];
          ELSE
            txt[n]:=0C;
          END;
        END;
      ELSIF ch=11C THEN (* Tab *)
      END;
    END;
    IF clr THEN
      CLEARWIN(Vindue1,TRUE);
    END;
    IF clr OR prt THEN
      PRINTWIN(Vindue1,0,0,ADR(txt),1,0);
    END;
    IF clr OR prt OR cur THEN
      CUR;
    END;
  UNTIL (res=EscWIN) OR (res=OkWIN);
  CLOSEWIN(Vindue1);
  OldX:=-1;
  OldY:=-1;
  Xofs:=0;
  Yofs:=0;
  RETURN(res);
END Edit;

BEGIN
(*$IF Test *)
  WRITELN(s('QISupport.1'));
(*$ENDIF *)
  First:=TRUE;
  Xofs:=0;
  Yofs:=0;
  ScrXdef:=640;
  ScrYdef:=256;
  AppendGadgets:=FALSE;
  WFS:=WindowFlagSet{windowDrag,windowClose,windowDepth};
  IFS:= IDCMPFlagSet{inactiveWindow, activeWindow,
                     closeWindow,gadgetDown,gadgetUp,
                     refreshWindow,rawKey};
  txtUPS :=ADR(txtUPSc);
  txtOK  :=ADR(txtOKc);
  txtDROP:=ADR(txtDROPc);
  FontX  :=FontXc;
  FontY  :=FontYc;
  OldX   :=-1;
  OldY   :=-1;
  CenterWIN:=TRUE;
  wbMusX :=160;
  wbMusY :=100;
  LONGINT(Vin1.Window):=4;
  LONGINT(Vin2.Window):=4;
  LONGINT(Vin3.Window):=4;
  LONGINT(Vin4.Window):=4;
  LONGINT(Vindue1.Window):=4;
(*$IF Test *)
  WRITELN(s('QISupport.2'));
(*$ENDIF *)
CLOSE
(*$IF Test *)
  WRITELN(s('QISupport.3'));
(*$ENDIF *)
  IF LONGINT(Vin4.Window)<>4 THEN
    CLOSEWIN(Vin4);
  END;
(*$IF Test *)
  WRITELN(s('QISupport.4'));
(*$ENDIF *)
END QISupport.

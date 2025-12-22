/*
                               Shells gambling game
                          Created by Almos Rajnai, 1996
			  Graphic User Interface Module

  LICENSE: This file is part of Shells.
  Shells is published under the terms of the GNU GPL License v2
  Please see readme.txt file for details.
*/

OPT MODULE

ENUM NONE,ER_OPENLIB,ER_WB,ER_VISUAL,ER_CONTEXT,ER_GADGET,ER_WINDOW,ER_MENUS,
     ER_FILE

EXPORT ENUM MYGT_START=1,MYGT_QUIT,MYGT_LEVEL,MYGT_NAMESTR,MYGT_OK

MODULE 'intuition/intuition', 'gadtools', 'libraries/gadtools',
       'intuition/gadgetclass', 'intuition/screens',
       'exec/nodes',
       'graphics/text'

DEF scr:PTR TO screen,
    visual,
    wnd:PTR TO window,
    glist,g:PTR TO gadget,menu,
    shellsimage:PTR TO image,type,
    gtextattr:PTR TO textattr

EXPORT DEF infos:PTR TO LONG,succ,level
EXPORT DEF bigshellers:PTR TO LONG, intuigraphptr:PTR TO LONG

EXPORT PROC shellsgui(showshellers2me) HANDLE

  glist:=wnd:=visual:=scr:=NIL

  succ:=FALSE

  shellsimage:=New(SIZEOF image)

  shellsimage.imagedata:=intuigraphptr
  shellsimage.leftedge:=0;
  shellsimage.topedge:=8;
  shellsimage.width:=309;
  shellsimage.height:=54;
  shellsimage.depth:=2;
  shellsimage.planepick:=3;
  shellsimage.planeonoff:=0;
  shellsimage.nextimage:=NIL;

  openinterface()

  IF showshellers2me THEN showshellers()

  REPEAT
    wait4message(wnd)

    IF type=IDCMP_CLOSEWINDOW THEN infos:=MYGT_QUIT

    IF type=64
      SELECT infos
        CASE MYGT_START; type:=IDCMP_CLOSEWINDOW
        CASE MYGT_QUIT; type:=IDCMP_CLOSEWINDOW
        CASE MYGT_LEVEL
          level++
          IF level>2 THEN level:=0
      ENDSELECT
    ENDIF

    IF type=256
      SELECT infos
        CASE -1952
          type:=IDCMP_CLOSEWINDOW
          infos:=MYGT_QUIT
        CASE -2048;showshellers()
        CASE -2016;showabout()
      ENDSELECT
    ENDIF

  UNTIL type=IDCMP_CLOSEWINDOW
  succ:=TRUE
  Raise(NONE)
EXCEPT
  closeinterface()
  IF exception>0 THEN WriteF('Could not \s !\n',
    ListItem(['','open "gadtools.library" v37','lock workbench',
              'get visual infos','create context','create gadget',
              'open window','allocate menus','load file'],exception))
ENDPROC

PROC openinterface()

  opennecessary()

  IF (menu:=CreateMenusA([NM_TITLE,0,'Shells',0,0,0,0,
    NM_ITEM,0,'Show Big Shellers','s',0,0,0,
    NM_ITEM,0,'About...','a',0,0,0,
    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
    NM_ITEM,0,'Quit','q',0,0,0,
    NM_END,0,0,0,0,0,0]:newmenu,NIL))=NIL THEN Raise(ER_MENUS)
  IF LayoutMenusA(menu,visual,NIL)=FALSE THEN Raise(ER_MENUS)

  IF (g:=CreateGadgetA(BUTTON_KIND,g,
    [14,104,93,13,'Start',gtextattr,MYGT_START,0,visual,0]:newgadget,
    [GTSC_TOP,2,
     GTSC_VISIBLE,3,0]))=NIL THEN Raise(ER_GADGET)

  IF (g:=CreateGadgetA(BUTTON_KIND,g,
    [220,104,93,13,'Quit',gtextattr,MYGT_QUIT,0,visual,0]:newgadget,
    [GTSC_TOP,2,
     GTSC_VISIBLE,3,0]))=NIL THEN Raise(ER_GADGET)

  IF (g:=CreateGadgetA(CYCLE_KIND,g,
    [132,84,108,14,'Level:',gtextattr,MYGT_LEVEL,0,visual,0]:newgadget,
     [GTCY_LABELS,['Novice','Advanced','Expert',0],
      GTCY_ACTIVE,level,0]))=NIL THEN Raise(ER_GADGET)

  IF (wnd:=OpenW(161,55,331,141,$304 OR SCROLLERIDCMP,
->        WFLG_DRAGBAR+
->        WFLG_DEPTHGADGET+
->        WFLG_CLOSEGADGET+
        WFLG_ACTIVATE,
        NIL,NIL,1,glist))=NIL THEN Raise(ER_WINDOW)

  DrawImage(wnd.rport,shellsimage,11,3)

  SetStdRast(wnd.rport)

  SetTopaz()

  Colour(2,0)
  TextF(110,73,'gambling game')
  TextF(78,131,'©1996 Rachy of Bi0Hazard')

  IF SetMenuStrip(wnd,menu)=FALSE THEN Raise(ER_MENUS)

  Gt_RefreshWindow(wnd,NIL)
ENDPROC

PROC closeinterface()
  IF shellsimage THEN Dispose(shellsimage)
  IF wnd THEN ClearMenuStrip(wnd)
  IF menu THEN FreeMenus(menu)
  IF visual THEN FreeVisualInfo(visual)
  IF wnd THEN CloseWindow(wnd)
  IF glist THEN FreeGadgets(glist)
  IF scr THEN UnlockPubScreen(NIL,scr)
  IF gadtoolsbase THEN CloseLibrary(gadtoolsbase)

  shellsimage:=wnd:=menu:=visual:=wnd:=glist:=scr:=gadtoolsbase:=NIL

ENDPROC

PROC opennecessary()

  IF (gadtoolsbase:=OpenLibrary('gadtools.library',37))=NIL THEN
    Raise(ER_OPENLIB)

  IF (scr:=LockPubScreen('Workbench'))=NIL THEN Raise(ER_WB)

  IF (visual:=GetVisualInfoA(scr,NIL))=NIL THEN Raise(ER_VISUAL)

  IF (g:=CreateContext({glist}))=NIL THEN Raise(ER_CONTEXT)

  gtextattr:=['topaz.font',8,0,0]:textattr

ENDPROC

PROC wait4message(wnd:PTR TO window)
  DEF mes:PTR TO intuimessage,g:PTR TO gadget
  REPEAT
    type:=0
    IF mes:=Gt_GetIMsg(wnd.userport)
      type:=mes.class
      IF type=IDCMP_MENUPICK
        infos:=mes.code
      ELSEIF (type=IDCMP_GADGETDOWN) OR (type=IDCMP_GADGETUP)
        g:=mes.iaddress
        infos:=g.gadgetid
      ELSEIF type=IDCMP_REFRESHWINDOW
        Gt_BeginRefresh(wnd)
        Gt_EndRefresh(wnd,TRUE)
        type:=0
      ELSEIF type<>IDCMP_CLOSEWINDOW
        type:=0
      ENDIF
      Gt_ReplyIMsg(mes)
    ELSE
      Wait(-1)
    ENDIF
  UNTIL type
ENDPROC

EXPORT PROC getname(p:PTR TO CHAR)

 DEF p2:PTR TO CHAR

  opennecessary()

  IF (g:=CreateGadgetA(STRING_KIND,g,
    [32,30,132,15,'Enter your name:',gtextattr,MYGT_NAMESTR,PLACETEXT_ABOVE,
     visual,0]:newgadget,
    [GTST_MAXCHARS,14,0]))=NIL THEN Raise(ER_GADGET)

  IF (wnd:=OpenW(220,90,200,60,$304 OR SCROLLERIDCMP,
->        WFLG_DRAGBAR+
->        WFLG_DEPTHGADGET+
        WFLG_ACTIVATE,
        NIL,NIL,1,glist))=NIL THEN Raise(ER_WINDOW)

  SetStdRast(wnd.rport)

  SetTopaz()

  Gt_RefreshWindow(wnd,NIL)

  ActivateGadget(g,wnd,NIL)

  REPEAT
    wait4message(wnd)
  UNTIL type=64

  p2:=g.specialinfo::stringinfo.buffer

  MOVEA.L  p2,A0
  MOVEA.L  p,A1
  MOVEQ    #14,D0
cyc:
  MOVE.B   (A0)+,(A1)+
  DBF      D0,cyc

  closeinterface()

ENDPROC

PROC showshellers()

DEF wnd=NIL:PTR TO window,
    glist,g:PTR TO gadget,p:PTR TO LONG,i, p2:PTR TO LONG

glist:=NIL

IF (g:=CreateContext({glist}))=NIL THEN Raise(ER_CONTEXT)

IF (g:=CreateGadgetA(BUTTON_KIND,g,
  [190,235,60,15,'Nice!',gtextattr,MYGT_OK,0,visual,0]:newgadget,
  NIL))=NIL THEN Raise(ER_GADGET)
IF (wnd:=OpenW(194,0,260,255,$304 OR SCROLLERIDCMP,
->      WFLG_DRAGBAR+
->      WFLG_DEPTHGADGET+
      WFLG_ACTIVATE,
      NIL,NIL,1,glist))=NIL THEN Raise(ER_WINDOW)

SetStdRast(wnd.rport)

SetTopaz()

Colour(2,0)
p:=bigshellers
p2:=p+225
TextF(95,20,'Novice:')
TextF(85,90,'Advanced:')
TextF(95,160,'Expert:')
TextF(20,10,'Big Shellers'' Hall of Fame!')
Colour(1,0)

FOR i:=1 TO 5
  TextF(10,i*10+30,'\s',p)
  TextF(170,i*10+30,'\d',^p2)
  p:=p+15
  p2:=p2+4
ENDFOR

FOR i:=1 TO 5
  TextF(10,i*10+100,'\s',p)
  TextF(170,i*10+100,'\d',^p2)
  p:=p+15
  p2:=p2+4
ENDFOR

FOR i:=1 TO 5
  TextF(10,i*10+170,'\s',p)
  TextF(170,i*10+170,'\d',^p2)
  p:=p+15
  p2:=p2+4
ENDFOR

Gt_RefreshWindow(wnd,NIL)

REPEAT
  wait4message(wnd)
UNTIL type=64

IF wnd THEN CloseWindow(wnd)
IF glist THEN FreeGadgets(glist)

ENDPROC

PROC showabout()

DEF wnd=NIL:PTR TO window,
    glist,g:PTR TO gadget

glist:=NIL

IF (g:=CreateContext({glist}))=NIL THEN Raise(ER_CONTEXT)

IF (g:=CreateGadgetA(BUTTON_KIND,g,
  [120,158,60,15,'Go on!',gtextattr,MYGT_OK,0,visual,0]:newgadget,
  NIL))=NIL THEN Raise(ER_GADGET)
IF (wnd:=OpenW(176,30,300,180,$304 OR SCROLLERIDCMP,
      WFLG_DRAGBAR+
      WFLG_ACTIVATE+
      WFLG_DEPTHGADGET,
      'Shellsabout...',NIL,1,glist))=NIL THEN Raise(ER_WINDOW)

SetStdRast(wnd.rport)

SetTopaz()

Colour(2,0)
TextF(70,20,'Shells! gambling game')
TextF(75,110,'HUNGARY')
TextF(105,50,'FREEWARE !')
TextF(75,70,'Contact:')
TextF(75,130,'email:')
Colour(1,0)
TextF(55,30,'©1996 Rachy of Bi0Hazard')
TextF(75,80,'Rajnai Álmos')
TextF(75,90,'8360 Keszthely')
TextF(75,100,'Bercsényi M.u. 46')
TextF(75,140,'rachy@fsd.bdtf.hu')
TextF(75,150,'sztecht1@fs2.bdtf.hu')

Gt_RefreshWindow(wnd,NIL)

REPEAT
  wait4message(wnd)
UNTIL type=64

IF wnd THEN CloseWindow(wnd)
IF glist THEN FreeGadgets(glist)

ENDPROC

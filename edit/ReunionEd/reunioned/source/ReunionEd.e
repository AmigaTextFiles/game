/*
** $VER: ReunionEd 1.0 (21.8.96) Peter Karlsson
**
** History:
** Version 1.0 (21.8.96) - First release ever! :)
*/

OPT OSVERSION=37

MODULE 'gadtools','libraries/gadtools','intuition/intuition',
       'intuition/screens', 'intuition/gadgetclass', 'graphics/text',
       'tools/file','reqtools','libraries/reqtools', 'utility/tagitem'

ENUM NONE,NOCONTEXT,NOGADGET,NOWB,NOVISUAL,OPENLIB,NOWINDOW

RAISE OPENLIB   IF OpenLibrary()       = NIL,
      NOWB      IF LockPubScreen()     = NIL,
      NOVISUAL  IF GetVisualInfoA()    = NIL,
      NOCONTEXT IF CreateContext()     = NIL,
      NOGADGET  IF CreateGadgetA()     = NIL,
      NOWINDOW  IF OpenWindowTagList() = NIL

CONST FILELEN = 44114,
      OFFSET_0 = 24824,
      OFFSET_1 = 24878,
      OFFSET_2 = 24932,
      OFFSET_3 = 24986,
      OFFSET_4 = 25040,
      OFFSET_5 = 25202,
      OFFSET_6 = 25256,
      OFFSET_7 = 25310,
      OFFSET_8 = 25418,
      OFFSET_9 = 25526,
      OFFSET_10 = 25580,
      OFFSET_11 = 25634,
      OFFSET_12 = 25742,
      OFFSET_13 = 25796,
      OFFSET_14 = 25850,
      OFFSET_15 = 25904,
      OFFSET_16 = 26012,
      OFFSET_17 = 26066,
      OFFSET_18 = 26120,
      OFFSET_19 = 26174,
      OFFSET_20 = 26390,
      OFFSET_21 = 26444,
      OFFSET_22 = 22,
      OFFSET_23 = 2008,
      OFFSET_24 = 2012,
      OFFSET_25 = 2016,
      OFFSET_26 = 2020,
      OFFSET_27 = 2024,
      OFFSET_28 = 2028,
      OFFSET_29 = 25958,
      OFFSET_33 = 26498,
      OFFSET_DEVELOPED = 19,
      OFFSET_NUM = 28,
      DEVELOPED = 5

DEF resaveedwnd:PTR TO window,
    resaveedglist,
    infos:PTR TO gadget,
    scr:PTR TO screen,
    visual = NIL,
    offx,offy,tattr,
    mem = NIL,
    len = NIL,
    fname[255]:STRING,
    fullfname[255]:STRING,
    g:PTR TO gadget,
    g0:PTR TO gadget,
    g1:PTR TO gadget,
    g2:PTR TO gadget,
    g3:PTR TO gadget,
    g4:PTR TO gadget,
    g5:PTR TO gadget,
    g6:PTR TO gadget,
    g7:PTR TO gadget,
    g8:PTR TO gadget,
    g9:PTR TO gadget,
    g10:PTR TO gadget,
    g11:PTR TO gadget,
    g12:PTR TO gadget,
    g13:PTR TO gadget,
    g14:PTR TO gadget,
    g15:PTR TO gadget,
    g16:PTR TO gadget,
    g17:PTR TO gadget,
    g18:PTR TO gadget,
    g19:PTR TO gadget,
    g20:PTR TO gadget,
    g21:PTR TO gadget,
    g22:PTR TO gadget,
    g23:PTR TO gadget,
    g24:PTR TO gadget,
    g25:PTR TO gadget,
    g26:PTR TO gadget,
    g27:PTR TO gadget,
    g28:PTR TO gadget,
    g29:PTR TO gadget,
    g30:PTR TO gadget,
    g31:PTR TO gadget,
    g32:PTR TO gadget,
    g33:PTR TO gadget,
    bevel:PTR TO LONG,
    enabled:PTR TO LONG,
    disabled:PTR TO LONG,
    load = FALSE

PROC main() HANDLE

   gadtoolsbase := OpenLibrary('gadtools.library',37)
   reqtoolsbase := OpenLibrary('reqtools.library',38)
   scr := LockPubScreen('Workbench')
   visual := GetVisualInfoA(scr,NIL)
   offy := scr.wbortop+Int(scr.rastport+58)-10
   tattr := ['topaz.font',8,0,0]:textattr
   bevel := [GT_VISUALINFO,visual,GTBB_FRAMETYPE,BBFT_ICONDROPBOX,TAG_DONE]
   enabled := [GA_DISABLED,FALSE,TAG_DONE]
   disabled := [GA_DISABLED,TRUE,TAG_DONE]

   g := CreateContext({resaveedglist})
   g0 := CreateGadgetA(BUTTON_KIND,g,
        [offx+10,offy+14,151,12,'Miner Droid',tattr,0,16,visual,0]:newgadget,disabled)
   g1 := CreateGadgetA(BUTTON_KIND,g0,
        [offx+10,offy+26,151,12,'Satellite',tattr,1,16,visual,0]:newgadget,disabled)
   g2 := CreateGadgetA(BUTTON_KIND,g1,
        [offx+10,offy+38,151,12,'Satellite Carrier',tattr,2,16,visual,0]:newgadget,disabled)
   g3 := CreateGadgetA(BUTTON_KIND,g2,
        [offx+10,offy+50,151,12,'Miner Station',tattr,3,16,visual,0]:newgadget,disabled)
   g4:= CreateGadgetA(BUTTON_KIND,g3,
        [offx+10,offy+62,151,12,'Transfer Ship',tattr,4,16,visual,0]:newgadget,disabled)
   g5 := CreateGadgetA(BUTTON_KIND,g4,
        [offx+10,offy+74,151,12,'Trade Ship',tattr,5,16,visual,0]:newgadget,disabled)
   g6 := CreateGadgetA(BUTTON_KIND,g5,
        [offx+10,offy+86,151,12,'Hunter',tattr,6,16,visual,0]:newgadget,disabled)
   g7 := CreateGadgetA(BUTTON_KIND,g6,
        [offx+10,offy+98,151,12,'Laser Cannon',tattr,7,16,visual,0]:newgadget,disabled)
   g8 := CreateGadgetA(BUTTON_KIND,g7,
        [offx+10,offy+110,151,12,'Twin Laser Gun',tattr,8,16,visual,0]:newgadget,disabled)
   g9 := CreateGadgetA(BUTTON_KIND,g8,
        [offx+10,offy+122,151,12,'Galleon',tattr,9,16,visual,0]:newgadget,disabled)
   g10 := CreateGadgetA(BUTTON_KIND,g9,
        [offx+10,offy+134,151,12,'StarFighter',tattr,10,16,visual,0]:newgadget,disabled)
   g11 := CreateGadgetA(BUTTON_KIND,g10,
        [offx+10,offy+146,151,12,'Trooper',tattr,11,16,visual,0]:newgadget,disabled)
   g12 := CreateGadgetA(BUTTON_KIND,g11,
        [offx+10,offy+158,151,12,'Pirate Ship',tattr,12,16,visual,0]:newgadget,disabled)
   g13 := CreateGadgetA(BUTTON_KIND,g12,
        [offx+10,offy+170,151,12,'Spy Satellite',tattr,13,16,visual,0]:newgadget,disabled)
   g14 := CreateGadgetA(BUTTON_KIND,g13,
        [offx+10,offy+182,151,12,'Battle Tank',tattr,14,16,visual,0]:newgadget,disabled)
   g15 := CreateGadgetA(BUTTON_KIND,g14,
        [offx+162,offy+14,151,12,'Missile',tattr,15,16,visual,0]:newgadget,disabled)
   g16 := CreateGadgetA(BUTTON_KIND,g15,
        [offx+162,offy+26,151,12,'Space Station',tattr,16,16,visual,0]:newgadget,disabled)
   g17 := CreateGadgetA(BUTTON_KIND,g16,
        [offx+162,offy+38,151,12,'Spy Ship',tattr,17,16,visual,0]:newgadget,disabled)
   g18 := CreateGadgetA(BUTTON_KIND,g17,
        [offx+162,offy+50,151,12,'AirCraft',tattr,18,16,visual,0]:newgadget,disabled)
   g19 := CreateGadgetA(BUTTON_KIND,g18,
        [offx+162,offy+62,151,12,'Solar Plant',tattr,19,16,visual,0]:newgadget,disabled)
   g20 := CreateGadgetA(BUTTON_KIND,g19,
        [offx+162,offy+74,151,12,'Plasma Gun',tattr,20,16,visual,0]:newgadget,disabled)
   g21 := CreateGadgetA(BUTTON_KIND,g20,
        [offx+162,offy+86,151,12,'Missile Launcher',tattr,21,16,visual,0]:newgadget,disabled)
   g22 := CreateGadgetA(BUTTON_KIND,g21,
        [offx+162,offy+110,151,12,'Money',tattr,22,16,visual,0]:newgadget,disabled)
   g23 := CreateGadgetA(BUTTON_KIND,g22,
        [offx+162,offy+122,151,12,'Detoxin',tattr,23,16,visual,0]:newgadget,disabled)
   g24 := CreateGadgetA(BUTTON_KIND,g23,
        [offx+162,offy+134,151,12,'Energon',tattr,24,16,visual,0]:newgadget,disabled)
   g25 := CreateGadgetA(BUTTON_KIND,g24,
        [offx+162,offy+146,151,12,'Kremia',tattr,25,16,visual,0]:newgadget,disabled)
   g26 := CreateGadgetA(BUTTON_KIND,g25,
        [offx+162,offy+158,151,12,'Lepitium',tattr,26,16,visual,0]:newgadget,disabled)
   g27 := CreateGadgetA(BUTTON_KIND,g26,
        [offx+162,offy+170,151,12,'Raenium',tattr,27,16,visual,0]:newgadget,disabled)
   g28 := CreateGadgetA(BUTTON_KIND,g27,
        [offx+162,offy+182,151,12,'Texon',tattr,28,16,visual,0]:newgadget,disabled)
   g29 := CreateGadgetA(BUTTON_KIND,g28,
        [offx+162,offy+98,151,12,'Destroyer',tattr,29,16,visual,0]:newgadget,disabled)
   g30 := CreateGadgetA(BUTTON_KIND,g29,
        [offx+16,offy+209,138,13,'Load',tattr,30,16,visual,0]:newgadget,[TAG_DONE])
   g31 := CreateGadgetA(BUTTON_KIND,g30,
        [offx+168,offy+209,138,13,'Save',tattr,31,16,visual,0]:newgadget,disabled)
   g32 := CreateGadgetA(BUTTON_KIND,g31,
        [offx+162,offy+194,151,12,'About...',tattr,32,16,visual,0]:newgadget,[TAG_DONE])
   g33 := CreateGadgetA(BUTTON_KIND,g32,
        [offx+10,offy+194,151,12,'Cruiser',tattr,33,16,visual,0]:newgadget,disabled)

  resaveedwnd := OpenWindowTagList(NIL,
                  [WA_LEFT,1,
                  WA_TOP,11,
                  WA_WIDTH,offx+324,
                  WA_HEIGHT,offy+230,
                  WA_IDCMP,$24C077E,
                  WA_FLAGS,$100E,
                  WA_TITLE,'ReSaveEd',
                  WA_SCREENTITLE,'ReunionEd © Copyright 1996 Peter Karlsson / Illogical System INC.',
                  WA_CUSTOMSCREEN,scr,
                  WA_MINWIDTH,67,
                  WA_MINHEIGHT,21,
                  WA_MAXWIDTH,$2A2,
                  WA_MAXHEIGHT,261,
                  WA_AUTOADJUST,1,
                  WA_AUTOADJUST,1,
                  WA_GADGETS,resaveedglist,
                  TAG_DONE])

   DrawBevelBoxA(resaveedwnd.rport,10,206,151,19,bevel)
   DrawBevelBoxA(resaveedwnd.rport,162,206,151,19,bevel)
   DrawBevelBoxA(resaveedwnd.rport,4,11,316,217,bevel)
   Gt_RefreshWindow(resaveedwnd,NIL)

   _Load()
   wait4message(resaveedwnd)

   Raise(NONE)

EXCEPT

   IF visual THEN FreeVisualInfo(visual)
   IF scr THEN UnlockPubScreen(NIL,scr)
   IF resaveedwnd THEN CloseWindow(resaveedwnd)
   IF resaveedglist THEN FreeGadgets(resaveedglist)
   IF gadtoolsbase THEN CloseLibrary(gadtoolsbase)
   IF reqtoolsbase THEN CloseLibrary(reqtoolsbase)

   SELECT exception
      CASE NOCONTEXT
         PutStr('Could not create a context.\n')
      CASE NOGADGET
         PutStr('Could not create \qgadgets\q.\n')
      CASE NOWB
         PutStr('Could not lock Workbenchscreen.\n')
      CASE NOVISUAL
         PutStr('Could not get visaulinfo.\n')
      CASE OPENLIB
         PutStr('Could not open \qgadtools.library\q v37+\n'+
                'or \qreqtools.library\q v38+.\n')
      CASE NOWINDOW
         PutStr('Could not open window.\n')
      CASE "OPEN"
         _ShowError( IoErr() )
      CASE "IN"
         _ShowError( IoErr() )
      CASE "OUT"
         _ShowError( IoErr() )
      DEFAULT
         NOP
   ENDSELECT

ENDPROC

PROC _ShowError(s) IS PrintFault( s, 'Error' )

PROC wait4message(win:PTR TO window)
  DEF mes:PTR TO intuimessage,type, num = NIL
  REPEAT
    type := 0
    IF mes := Gt_GetIMsg(win.userport)
      type := mes.class
      IF (type = IDCMP_GADGETDOWN) OR (type = IDCMP_GADGETUP)
        infos := mes.iaddress
        num := infos.gadgetid
        type := 0
         SELECT num

            CASE 0 /* Miner Droid */
               _LowCh(mem,OFFSET_0)

            CASE 1 /* Satellite */
               _LowCh(mem,OFFSET_1)

            CASE 2 /* Satellite Carrier */
               _LowCh(mem,OFFSET_2)

            CASE 3 /* Miner Station */
               _LowCh(mem,OFFSET_3)

            CASE 4 /* Transfer Ship */
               _LowCh(mem,OFFSET_4)

            CASE 5 /* Trade Ship */
               _LowCh(mem,OFFSET_5)

            CASE 6 /* Hunter */
               _LowCh(mem,OFFSET_6)

            CASE 7 /* Laser Cannon */
               _LowCh(mem,OFFSET_7)

            CASE 8 /* Twin Laser Gun */
               _LowCh(mem,OFFSET_8)

            CASE 9 /* Galleon */
               _LowCh(mem,OFFSET_9)

            CASE 10 /* StarFighter */
               _LowCh(mem,OFFSET_10)

            CASE 11 /* Trooper */
               _LowCh(mem,OFFSET_11)

            CASE 12 /* Pirate Ship */
               _LowCh(mem,OFFSET_12)

            CASE 13 /* Spy Satellite */
               _LowCh(mem,OFFSET_13)

            CASE 14 /* Battle Tank */
               _LowCh(mem,OFFSET_14)

            CASE 15 /* Missile */
               _LowCh(mem,OFFSET_15)

            CASE 16 /* Space Station */
               _LowCh(mem,OFFSET_16)

            CASE 17 /* Spy Ship */
               _LowCh(mem,OFFSET_17)

            CASE 18 /* AirCraft */
               _LowCh(mem,OFFSET_18)

            CASE 19 /* Solar Plant */
               _LowCh(mem,OFFSET_19)

            CASE 20 /* Plasma Gun */
               _LowCh(mem,OFFSET_20)

            CASE 21 /* Missile Launcher */
               _LowCh(mem,OFFSET_21)

            CASE 22 /* Money */
               _HighCh(mem,OFFSET_22,0)

            CASE 23 /* Detoxin */
               _HighCh(mem,OFFSET_23,1)

            CASE 24 /* Energon */
               _HighCh(mem,OFFSET_24,2)

            CASE 25 /* Kremia */
               _HighCh(mem,OFFSET_25,3)

            CASE 26 /* Lepitium */
               _HighCh(mem,OFFSET_26,4)

            CASE 27 /* Raenium */
               _HighCh(mem,OFFSET_27,5)

            CASE 28 /* Texon */
               _HighCh(mem,OFFSET_28,6)

            CASE 29 /* Destroyer */
               _LowCh(mem,OFFSET_29)

            CASE 30 /* LOAD */
               _Load()

            CASE 31 /* SAVE */
               _Save()

            CASE 32 /* ? */
               RtEZRequestA('»-> ReunionEd <-«\n\n'+
                  'A savefile editor to the game Reunion\n\n'+
                  'Copyright 1996 Peter Karlsson\n'+
                  'Illogical System INC.\n'+
                  '(1996-08-21)\n\n'+
                  'Programmed in E v3.1a',
                  'Ok',
                  NIL,
                  NIL,
                  [RT_WINDOW,resaveedwnd,
                  RT_REQPOS,REQPOS_POINTER,
                  RT_LOCKWINDOW,TRUE,
                  RTEZ_REQTITLE, 'ReunionEd - Info',
                  RTEZ_FLAGS,EZREQF_CENTERTEXT,
                  TAG_DONE])

            CASE 33 /* Cruiser */
               _LowCh(mem,OFFSET_33)
               
            DEFAULT
               NOP
         ENDSELECT
      ELSEIF type = IDCMP_REFRESHWINDOW
        Gt_BeginRefresh(win)
        Gt_EndRefresh(win,TRUE)
        type := 0
      ELSEIF type<>IDCMP_CLOSEWINDOW
         type := 0
      ENDIF
      Gt_ReplyIMsg(mes)
    ELSE
      WaitPort(win.userport)
    ENDIF
  UNTIL type
ENDPROC

PROC _Load()
   DEF req:PTR TO rtfilerequester
   IF (req:=RtAllocRequestA(RT_FILEREQ,NIL))
      StrCopy(fname,'SaveGame.000', ALL )
      IF RtFileRequestA( req, fname, 'Choose Reunion savefile:',[RT_WINDOW,resaveedwnd,RT_LOCKWINDOW,TRUE,TAG_DONE])
         StringF(fullfname, '\s', req.dir )
         AddPart(fullfname,fname,255)
         IF load = TRUE THEN freefile(mem)
         mem,len := readfile(fullfname,NIL,NIL)
         IF len<>FILELEN
            RtEZRequestA('\q\s\q is not a Reunion-savefile!','Ok',NIL,[fullfname],
                        [RT_WINDOW,resaveedwnd,
                         RT_REQPOS,REQPOS_POINTER,
                         RT_LOCKWINDOW,TRUE,
                         TAG_DONE])
            freefile(fullfname)
         ELSE
            _ToggleGadgets(TRUE)
            load := TRUE
         ENDIF
      ENDIF
      RtFreeRequest(req)
   ENDIF
ENDPROC

PROC _Save()
   writefile(fullfname,mem,len)
   freefile(mem)
   load := FALSE
   _ToggleGadgets(FALSE)
ENDPROC

PROC _LowCh( start, offset )
   DEF string[255]:STRING, nummer = NIL
   start := start + offset
   nummer := Int(start+OFFSET_NUM)
   StringF(string, '\s : \d', start, Int(start+OFFSET_NUM))
   IF start[OFFSET_DEVELOPED] <> DEVELOPED THEN StrAdd(string, '\nNot developed yet.', ALL )
   StrAdd(string,'\n\nEnter new value:', ALL )
   IF RtGetLongA({nummer},'Enter new value:',NIL,
       [RT_WINDOW,resaveedwnd,
        RT_LOCKWINDOW,TRUE,
        RT_REQPOS,REQPOS_POINTER,
        RTGL_SHOWDEFAULT,FALSE,
        RTGL_MIN,0,
        RTGL_MAX,9999,
        RTGL_TEXTFMT,string,
        TAG_DONE])
      PutInt(start+OFFSET_NUM,nummer)
   ENDIF
ENDPROC

PROC _HighCh( start, offset, off2 )
   DEF ant = NIL, string[255]:STRING
   start := start + offset
   ant := Long( start )
   StringF(string,'\l\s[16] : \d\n\nEnter new value:', ListItem(['Money','Detoxin','Energon','Kremia','Lepitium','Raenium','Texon'],off2), ant )
   IF RtGetLongA({ant},'Enter new value:',NIL,
       [RT_WINDOW,resaveedwnd,
        RT_LOCKWINDOW,TRUE,
        RT_REQPOS,REQPOS_POINTER,
        RTGL_SHOWDEFAULT,FALSE,
        RTGL_MIN,0,
        RTGL_MAX,IF (off2=0) THEN 16000000 ELSE 90000,
        RTGL_TEXTFMT,string,
        RTGL_FLAGS, GLREQF_CENTERTEXT,
        TAG_DONE])
      PutLong( start, ant )
   ENDIF
ENDPROC

PROC _ToggleGadgets(s)
   Gt_SetGadgetAttrsA(g0,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g1,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g2,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g3,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g4,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g5,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g6,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g7,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g8,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g9,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g10,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g11,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g12,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g13,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g14,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g15,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g16,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g17,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g18,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g19,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g20,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g21,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g22,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g23,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g24,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g25,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g26,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g27,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g28,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g29,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g31,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
   Gt_SetGadgetAttrsA(g33,resaveedwnd,NIL,IF s THEN enabled ELSE disabled)
ENDPROC

CHAR 0,'$VER: ReunionEd 1.0 (21.8.96) Peter Karlsson / Illogical System INC.',0

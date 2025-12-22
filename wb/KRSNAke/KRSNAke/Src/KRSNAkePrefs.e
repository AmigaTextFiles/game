->
-> NOVUS ORDO SECLORUM!
->
->         -><- KRSNAkePrefs -><-
->
-> Prefs tool for KRSNAke
->
-> Copyright © 1995 Psilocybe Software
->
-> This program is free software; you can redistribute it and/or modify
-> it under the terms of the GNU General Public License as published by
-> the Free Software Foundation; either version 2 of the License, or
-> (at your option) any later version.
->
-> This program is distributed in the hope that it will be useful,
-> but WITHOUT ANY WARRANTY; without even the implied warranty of
-> MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-> GNU General Public License for more details.
->
-> You should have received a copy of the GNU General Public License
-> along with this program; if not, write to the Free Software
-> Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
->
-> $HISTORY:
->
-> 24 Oct 1995 : 002.006 :  Sends update signals to KRSNAke
-> 22 Oct 1995 : 002.005 :  Some minor bugfixes
-> 11 Oct 1995 : 002.004 :  Added locale support, updated for new gtlayout
-> 02 Oct 1995 : 002.003 :  Rearranged GUI layout
-> 22 Sep 1995 : 002.002 :  Added some new items
-> 05 Sep 1995 : 002.001 :  Initial revision
->
-> Machaben!
->

OPT PREPROCESS

#define VERSION '$VER: KRSNAkePrefs 2.006 (24 Oct 1995) Stab'

MODULE 'gtlayout','gadtools','libraries/gtlayout','libraries/gadtools',
       'utility/tagitem','intuition/intuition','tools/exceptions','tools/trapguru',
       'libraries/gtlayoutmacros','exec/ports','dos/dos','dos/dosasl',
       'asl','libraries/asl','intuition/screens','graphics/view','tools/installhook',
       'utility/hooks','graphics/rastport','graphics/rpattr','datatypes',
       'datatypes/datatypes','datatypes/datatypesclass','datatypes/pictureclass',
       'amigalib/boopsi','graphics/gfx','graphics/clip','libraries/krsnake',
       'krsnake','tools/constructors','exec/lists','exec/nodes','locale'

MODULE '*tiledbitmap','*krsnakecat'

RAISE "GTLO" IF Lt_BuildA()=0,
      "GTLO" IF Lt_CreateHandleTagList()=0,
      "FILE" IF Open()=0,
      "SCR"  IF LockPubScreen()=0,
      "MEM"  IF KsReadKRSNAkePrefs()=0

CONST COL_BACKGROUND=0,
      COL_SNAKEBODY=3,
      COL_SNAKEHEAD=6,
      COL_FRUIT1=9,
      COL_FRUIT2=12,
      COL_FRUIT3=15,
      COL_FRUIT4=18,
      COL_SIZE=21

DEF mhandle:PTR TO layouthandle,phandle:PTR TO layouthandle
DEF mwin:PTR TO window,pwin:PTR TO window
DEF mmask,mmenu,cpen=-1,ccm=0,image:PTR TO LONG
DEF cframehook:hook,localehook:hook
DEF kp=0:PTR TO kprefs,sample=0,save=0

ENUM GAD_RED=1,GAD_GREEN,GAD_BLUE,GAD_PUBSCREEN,GAD_PRI,GAD_LETHAL,
     GAD_STARTGAME,GAD_EATFRUIT,GAD_CRASH,GAD_COLSEL,GAD_RGB,GAD_IMAGE,
     GAD_COLTYPE,GAD_COLTYPEGROUP,GAD_TEST1,GAD_TEST2,GAD_TEST3,GAD_POPKEY,
     GAD_APPICON,GAD_APPMENU,GAD_PAGER,GAD_PAGEGROUP,GAD_GRAPHIC,GAD_DRIPENS,
     GAD_SAVE,GAD_CANCEL,GAD_FREESOUNDS,GAD_CONTSOUND,MAX_GADS

PROC createMainWindow()
    DEF gthandle:PTR TO layouthandle
    CreateHandle(NIL),LAHN_AUTOACTIVATE,FALSE,LAHN_MENUGLYPHS,TRUE,LAHN_EXITFLUSH,TRUE,
                      LAHN_LOCALEHOOK,localehook,LAHN_CLONINGPERMITTED,FALSE,End
        VGROUP,End
            VGROUP,End
                TabGadget,LATB_FIRSTLABEL,ID_OPTIONS1,LATB_LASTLABEL,ID_COLOURS,
                          LATB_FULLWIDTH,TRUE,
                          LATB_TABKEY,TRUE,LATB_AUTOPAGEID,GAD_PAGEGROUP,LA_ID,GAD_PAGER,End
            ENDGROUP
            VGROUP,LAGR_ACTIVEPAGE,0,LA_ID,GAD_PAGEGROUP,End
                VGROUP,End
                    StringGadget,GTST_MAXCHARS,64,LA_LABELID,ID_PUBSCREEN,
                                 GTST_STRING,kp.pubscreen,
                                 LA_CHARS,40,LAST_PICKER,TRUE,LA_ID,GAD_PUBSCREEN,End
                    StringGadget,GTST_MAXCHARS,64,LA_LABELID,ID_POPKEY,
                                 GTST_STRING,kp.popkey,LA_CHARS,40,LA_ID,GAD_POPKEY,End
                    LevelGadget,GTSL_MIN,-3,GTSL_MAX,3,LA_LABELID,ID_PRIORITY,
                                GTSL_LEVEL,kp.priority,
                                LA_CHARS,40,LA_ID,GAD_PRI,End
                ENDGROUP
                VGROUP,End
                    CheckboxGadget,LA_LABELID,ID_LETHAL180,LA_ID,GAD_LETHAL,
                                   GTCB_CHECKED,And(kp.flags,KPF_LETHAL180),End
                    CheckboxGadget,LA_LABELID,ID_APPICON,LA_ID,GAD_APPICON,
                                   GTCB_CHECKED,And(kp.flags,KPF_APPICON),End
                    CheckboxGadget,LA_LABELID,ID_APPMENU,LA_ID,GAD_APPMENU,
                                   GTCB_CHECKED,And(kp.flags,KPF_APPMENU),End
                    CheckboxGadget,LA_LABELID,ID_FREESOUNDS,LA_ID,GAD_FREESOUNDS,
                                   GTCB_CHECKED,And(kp.flags,KPF_FREESOUNDS),End
                    CheckboxGadget,LA_LABELID,ID_CONTSOUND,LA_ID,GAD_CONTSOUND,
                                   GTCB_CHECKED,And(kp.flags,KPF_CONTSOUND),End
                ENDGROUP
                HGROUP,End
                    VGROUP,End
                        StringGadget,GTST_MAXCHARS,256,LA_LABELID,ID_STARTGAME,
                                     GTST_STRING,kp.startgamesound,
                                     LA_CHARS,35,LAST_PICKER,TRUE,LA_ID,GAD_STARTGAME,End
                        StringGadget,GTST_MAXCHARS,256,LA_LABELID,ID_EATFRUIT,
                                     GTST_STRING,kp.eatfruitsound,
                                     LA_CHARS,35,LAST_PICKER,TRUE,LA_ID,GAD_EATFRUIT,End
                        StringGadget,GTST_MAXCHARS,256,LA_LABELID,ID_CRASH,
                                     GTST_STRING,kp.crashsound,
                                     LA_CHARS,35,LAST_PICKER,TRUE,LA_ID,GAD_CRASH,End
                    ENDGROUP
                    VGROUP,End
                        ButtonGadget,LA_LABELID,ID_TEST,LA_ID,GAD_TEST1,End
                        ButtonGadget,LA_LABELID,ID_TEST,LA_ID,GAD_TEST2,End
                        ButtonGadget,LA_LABELID,ID_TEST,LA_ID,GAD_TEST3,End
                    ENDGROUP
                ENDGROUP
                HGROUP,End
                    VGROUP,End
                        ListviewGadget,LALV_FIRSTLABEL,ID_BACKGROUND,LALV_LASTLABEL,ID_FRUIT4,
                                       LALV_CURSORKEY,TRUE,LA_CHARS,10,LALV_LINES,7,
                                       LALV_LINK,NIL_LINK,LA_ID,GAD_COLSEL,
                                       GTLV_SELECTED,0,End
                    ENDGROUP
                    HGROUP,TRUE,End
                        VGROUP,End
                            FrameGadget,LAFR_DRAWBOX,FALSE,LAFR_REFRESHHOOK,cframehook,End
                            FrameGadget,LAFR_INNERWIDTH,64,LAFR_INNERHEIGHT,64,LA_ID,GAD_RGB,
                                        LAFR_DRAWBOX,TRUE,LAFR_REFRESHHOOK,cframehook,End
                            FrameGadget,LAFR_DRAWBOX,FALSE,LAFR_REFRESHHOOK,cframehook,End
                        ENDGROUP
                        VGROUP,End
                            VGROUP,End
                                PopupGadget,LAPU_FIRSTLABEL,ID_RGBTYPE,LAPU_LASTLABEL,ID_DRIPEN,
                                            LA_LABELID,ID_FILLTYPE,LA_ID,GAD_COLTYPE,End
                            ENDGROUP
                            VGROUP,LAGR_ACTIVEPAGE,0,LAGR_FRAME,TRUE,LA_ID,GAD_COLTYPEGROUP,End
                                VGROUP,End
                                    LevelGadget,LA_LABELID,ID_RED,GTSL_MIN,0,GTSL_MAX,255,
                                                LA_CHARS,30,LA_ID,GAD_RED,GTSL_LEVEL,kp.fill[0].red,End
                                    LevelGadget,LA_LABELID,ID_GREEN,GTSL_MIN,0,GTSL_MAX,255,
                                                LA_CHARS,30,LA_ID,GAD_GREEN,GTSL_LEVEL,kp.fill[0].green,End
                                    LevelGadget,LA_LABELID,ID_BLUE,GTSL_MIN,0,GTSL_MAX,255,
                                                LA_CHARS,30,LA_ID,GAD_BLUE,GTSL_LEVEL,kp.fill[0].blue,End
                                ENDGROUP
                                VGROUP,End
                                    StringGadget,GTST_MAXCHARS,256,LA_LABELID,ID_IMAGE,
                                                 GTST_STRING,kp.fill[0].file,
                                                 LA_CHARS,30,LAST_PICKER,TRUE,LA_ID,GAD_IMAGE,End
                                ENDGROUP
                                VGROUP,End
                                    StringGadget,GTST_MAXCHARS,256,LA_LABELID,ID_FILE,
                                                 GTST_STRING,kp.fill[0].file,
                                                 LA_CHARS,30,LAST_PICKER,TRUE,LA_ID,GAD_GRAPHIC,End
                                ENDGROUP
                                VGROUP,End
                                    PopupGadget,LAPU_LABELS,['DETAILPEN','BLOCKPEN','TEXTPEN',
                                                             'SHINEPEN','SHADOWPEN','FILLPEN',
                                                             'FILLTEXTPEN','BACKGROUNDPEN',
                                                             'HIGHLIGHTTEXTPEN','BARDETAILPEN',
                                                             'BARBLOCKPEN','BARTRIMPEN',NIL],
                                                LA_LABELID,ID_PEN,LA_ID,GAD_DRIPENS,End
                                ENDGROUP
                            ENDGROUP
                        ENDGROUP
                    ENDGROUP
                ENDGROUP
            ENDGROUP
            VGROUP,End
                XBarGadget,LAXB_FULLWIDTH,TRUE,End
            ENDGROUP
            HGROUP,LAGR_SPREAD,TRUE,LAGR_SAMESIZE,TRUE,End
                ButtonGadget,LA_LABELID,ID_SAVE,LABT_RETURNKEY,TRUE,LA_ID,GAD_SAVE,End
                ButtonGadget,LA_LABELID,ID_CANCEL,LABT_ESCKEY,TRUE,
                             LABT_DEFAULTCORRECTION,TRUE,LA_ID,GAD_CANCEL,End
            ENDGROUP
        ENDGROUP
    mmenu:=createMenu(gthandle)
    mwin:=Build,LAWN_TITLE,getstr(ID_PREFS),LAWN_SMARTZOOM,TRUE,LAWN_MENU,mmenu,
                LAWN_IDCMP,IDCMP_GADGETDOWN OR IDCMP_CLOSEWINDOW OR IDCMP_MOUSEMOVE,
                LAWN_MAXPEN,256,WA_CLOSEGADGET,TRUE,WA_DRAGBAR,TRUE,WA_DEPTHGADGET,TRUE,
                End
    mhandle:=gthandle
ENDPROC Shl(1,mwin.userport.sigbit)

PROC createPSWindow(list)
    DEF gthandle:PTR TO layouthandle
    CreateHandle(NIL),LAHN_AUTOACTIVATE,FALSE,
                      LAHN_LOCALEHOOK,localehook,LAHN_CLONINGPERMITTED,FALSE,End
        VGROUP,LA_LABELID,ID_PUBSCREENLIST,End
            ListviewGadget,LALV_CURSORKEY,TRUE,LA_CHARS,30,LALV_LINES,10,
                           LALV_RESIZEY,TRUE,LALV_LINK,NIL_LINK,LA_ID,1,
                           GTLV_LABELS,list,
                           LALV_RESIZEX,TRUE,GTLV_SELECTED,0,End
        ENDGROUP
    pwin:=Build,LAWN_TITLE,getstr(ID_PUBSCREENWINDOW),
                LAWN_IDCMP,IDCMP_CLOSEWINDOW OR IDCMP_IDCMPUPDATE,
                LAWN_SMARTZOOM,TRUE,WA_RMBTRAP,TRUE,
                LAWN_PARENT,mwin,LAWN_BLOCKPARENT,TRUE,
                WA_CLOSEGADGET,TRUE,WA_DRAGBAR,TRUE,
                WA_DEPTHGADGET,TRUE,End
    phandle:=gthandle
ENDPROC Shl(1,pwin.userport.sigbit)

PROC createMenu(handle:PTR TO layouthandle)
    DEF menu:PTR TO menu
    menu:=Lt_NewMenuTagList([LAMN_LAYOUTHANDLE,handle,
                             LAMN_TITLEID,MENUID_PROJECT,
                                 LAMN_ITEMID,MENUID_ABOUT,
                                     LAMN_KEYTEXT,'?',
                                 LAMN_ITEMTEXT,NM_BARLABEL,
                                 LAMN_ITEMID,MENUID_QUIT,
                                     LAMN_COMMANDTEXT,'ESC',
                             TAG_DONE])
    IF menu=0 THEN Raise("MENU")
ENDPROC menu

PROC deleteMainWindow()
    IF mhandle
        Lt_DeleteHandle(mhandle)
        mhandle:=0
    ENDIF
ENDPROC

PROC deletePSWindow()
    IF phandle
        Lt_DeleteHandle(phandle)
        phandle:=0
    ENDIF
ENDPROC

PROC copyList(list:PTR TO lh)
    DEF nl:PTR TO lh,in:PTR TO ln
    nl:=newlist()
    in:=list.head
    WHILE in.succ
        AddTail(nl,copyNode(in))
        in:=in.succ
    ENDWHILE
ENDPROC nl

PROC copyNode(n:PTR TO ln)
    DEF nn:PTR TO ln
    nn:=NewR(SIZEOF ln+StrLen(n.name)+1)
    nn.name:=nn+SIZEOF ln
    copystring(nn.name,n.name)
ENDPROC nn

PROC deleteList(l:PTR TO lh)
    DEF n:PTR TO ln
    WHILE n:=RemHead(l) DO Dispose(n)
    END l
ENDPROC

PROC getNode(l:PTR TO lh,c)
    DEF n:PTR TO ln
    n:=l.head
    WHILE n.succ
        IF c=0 THEN RETURN n
        DEC c
        n:=n.succ
    ENDWHILE
ENDPROC 0

PROC selectPubScreen()
    DEF mask,l,pl,done=0,msg:PTR TO intuimessage,n:PTR TO ln,
        msgclass,msgcode,msgqualifier,msggadget:PTR TO gadget

    pl:=LockPubScreenList()
    l:=copyList(pl)
    UnlockPubScreenList()
    mask:=createPSWindow(l)
    ActivateWindow(pwin)

    WHILE done=0
        Wait(mask)
        WHILE (msg:=Lt_GetIMsg(phandle))
            msgclass:=msg.class
            msgcode:=msg.code
            msgqualifier:=msg.qualifier
            msggadget:=msg.iaddress
            Lt_ReplyIMsg(msg)
            SELECT msgclass
                CASE IDCMP_CLOSEWINDOW
                    done:=1
                CASE IDCMP_IDCMPUPDATE
                    IF msggadget.gadgetid=1
                        done:=2
                    ENDIF
            ENDSELECT
        ENDWHILE
    ENDWHILE

    deletePSWindow()
    IF done=2
        n:=getNode(l,msgcode)
        Lt_SetAttributesA(mhandle,GAD_PUBSCREEN,[GTST_STRING,n.name,TAG_DONE])
    ENDIF
    deleteList(l)
ENDPROC

PROC copystring(s2,s1)
    MOVE.L  s1,A0
    MOVE.L  s2,A1
copyloop:
    MOVE.B  (A0)+,D0
    CMP.B   #32,D0
    BLT     terminate
    MOVE.B  D0,(A1)+
    BRA     copyloop
terminate:
    CLR.B   (A1)+
ENDPROC

OBJECT refreshmessage -> refreshmsg in gtlayout.m is wrong
    id:LONG
    left:INT
    top:INT
    width:INT
    height:INT
ENDOBJECT

PROC renderCFrame(obj:PTR TO layouthandle,msg:PTR TO refreshmessage)
    DEF rp:PTR TO rastport,id,cc,dr=0,i:PTR TO imagedata,bounds:rectangle

    rp:=obj.window.rport
    id:=msg.id
    bounds.minx:=msg.left
    bounds.miny:=msg.top
    bounds.maxx:=msg.left+msg.width-1
    bounds.maxy:=msg.top+msg.height-1

    SELECT id
        CASE GAD_RGB
            cc:=Lt_GetAttributesA(mhandle,GAD_COLSEL,NIL)
            IF kp.fill[cc].type=FILLTYPE_RGB
                IF cpen=-1
                    ccm:=obj.screen.viewport.colormap
                    cpen:=ObtainPen(ccm,-1,v32(kp.fill[cc].red),v32(kp.fill[cc].green),v32(kp.fill[cc].blue),PEN_EXCLUSIVE)
                ENDIF
                IF cpen>=0
                    SetAPen(rp,cpen)
                    RectFill(rp,msg.left,msg.top,msg.left+msg.width-1,msg.top+msg.height-1)
                    dr:=1
                ENDIF
            ELSEIF kp.fill[cc].type=FILLTYPE_DRIPEN
                SetAPen(rp,obj.drawinfo.pens[kp.fill[cc].dripen])
                RectFill(rp,msg.left,msg.top,msg.left+msg.width-1,msg.top+msg.height-1)
                dr:=1
            ELSEIF (kp.fill[cc].type=FILLTYPE_DATATYPE) OR (kp.fill[cc].type=FILLTYPE_GRAPHIC)
                IF image[cc]=0
                    image[cc]:=createImageData(kp.fill[cc].file,obj.screen)
                ENDIF
                IF image[cc]
                    i:=image[cc]
                    copyTiledBitMap(i,rp,bounds,1)
                    dr:=1
                ENDIF
            ENDIF
            IF dr=0
                SetAPen(rp,obj.drawinfo.pens[BACKGROUNDPEN])
                RectFill(rp,msg.left,msg.top,msg.left+msg.width-1,msg.top+msg.height-1)
                SetAPen(rp,obj.drawinfo.pens[BLOCKPEN])
                Move(rp,msg.left,msg.top)
                Draw(rp,msg.left+msg.width-1,msg.top+msg.height-1)
                Move(rp,msg.left,msg.top+msg.height-1)
                Draw(rp,msg.left+msg.width-1,msg.top)
            ENDIF
    ENDSELECT
ENDPROC 1

PROC pickFile(id)
    DEF req:PTR TO filerequester,p[256]:STRING,f[256]:STRING,a,pt
    a:=Lt_GetAttributesA(mhandle,GAD_COLSEL,NIL)
    StrCopy(p,Lt_GetAttributesA(mhandle,id,NIL))
    StrCopy(f,FilePart(Lt_GetAttributesA(mhandle,id,NIL)))
    PutChar(PathPart(p),0)
    SetStr(p,StrLen(p))
    IF id=GAD_GRAPHIC
        IF a>=FILL_FRUIT1 THEN pt:='#?.f#?' ELSE pt:='#?.s#?'
    ELSE
        pt:='#?'
    ENDIF

    req:=AllocAslRequest(ASL_FILEREQUEST,[ASLFR_WINDOW,mhandle.window,
                                          ASLFR_SLEEPWINDOW,TRUE,
                                          ASLFR_TITLETEXT,'Select a file',
                                          ASLFR_INITIALFILE,f,
                                          ASLFR_INITIALDRAWER,p,
                                          ASLFR_USERDATA,id,
                                          ASLFR_INITIALPATTERN,pt,
                                          ASLFR_DOPATTERNS,TRUE,
                                          ASLFR_REJECTICONS,TRUE,TAG_DONE])
    IF AslRequest(req,NIL)
        StrCopy(p,req.drawer)
        AddPart(p,req.file,255)
        SetStr(p,StrLen(p))
        Lt_SetAttributesA(mhandle,id,[GTST_STRING,p,TAG_DONE])
        FreeAslRequest(req)
        IF (id=GAD_IMAGE) OR (id=GAD_GRAPHIC)
            copystring(kp.fill[a].file,p)
            IF image[a]
                disposeImageData(image[a])
                image[a]:=0
            ENDIF
            Lt_RebuildTagList(mhandle,FALSE,NIL)
        ENDIF
    ENDIF
ENDPROC

PROC v32(x) IS Or(Shl(x,24),Or(Shl(x,16),Or(Shl(x,8),x)))

PROC setrgbvalue()
    DEF l
    l:=Lt_GetAttributesA(mhandle,GAD_COLSEL,NIL)
    kp.fill[l].red:=Lt_GetAttributesA(mhandle,GAD_RED,NIL)
    kp.fill[l].green:=Lt_GetAttributesA(mhandle,GAD_GREEN,NIL)
    kp.fill[l].blue:=Lt_GetAttributesA(mhandle,GAD_BLUE,NIL)
ENDPROC

PROC openLibrary(name,ver)
    DEF base
    base:=OpenLibrary(name,ver)
    IF base=0 THEN Throw("LIB",name)
ENDPROC base

PROC main() HANDLE
    DEF msg:PTR TO intuimessage,msgqualifier,msgclass,msgcode,
        msggadget:PTR TO gadget,done=FALSE,sig,cdown=FALSE,a,b

->    trapguru()

    image:=List(COL_SIZE/3)

    aslbase:=openLibrary('asl.library',37)
    gadtoolsbase:=openLibrary('gadtools.library',37)
    gtlayoutbase:=openLibrary('gtlayout.library',17)
    datatypesbase:=openLibrary('datatypes.library',39)
    krsnakebase:=openLibrary('krsnake.library',1)
    localebase:=OpenLibrary('locale.library',0)
    openCatalog()

    kp:=KsReadKRSNAkePrefs()

    installhook(cframehook,{renderCFrame})
    installhook(localehook,{getstr})

    mmask:=createMainWindow()

    ActivateWindow(mwin)

    Lt_SetAttributesA(mhandle,GAD_RED,[GTSL_LEVEL,kp.fill[0].red,TAG_DONE])
    Lt_SetAttributesA(mhandle,GAD_GREEN,[GTSL_LEVEL,kp.fill[0].green,TAG_DONE])
    Lt_SetAttributesA(mhandle,GAD_BLUE,[GTSL_LEVEL,kp.fill[0].blue,TAG_DONE])
    Lt_SetAttributesA(mhandle,GAD_IMAGE,[GTST_STRING,kp.fill[0].file,TAG_DONE])
    Lt_SetAttributesA(mhandle,GAD_COLTYPE,[GTCY_ACTIVE,kp.fill[0].type,TAG_DONE])
    Lt_SetAttributesA(mhandle,GAD_COLTYPEGROUP,[LAGR_ACTIVEPAGE,kp.fill[0].type,TAG_DONE])
    IF cpen>=0 THEN SetRGB32(mhandle.screen.viewport,cpen,v32(Lt_GetAttributesA(mhandle,GAD_RED,NIL)),v32(Lt_GetAttributesA(mhandle,GAD_GREEN,NIL)),v32(Lt_GetAttributesA(mhandle,GAD_BLUE,NIL)))

    WHILE done=FALSE
        sig:=Wait(mmask)
        WHILE (msg:=Lt_GetIMsg(mhandle))
            msgclass:=msg.class
            msgcode:=msg.code
            msgqualifier:=msg.qualifier
            msggadget:=msg.iaddress
            Lt_ReplyIMsg(msg)
            SELECT msgclass
                CASE IDCMP_CLOSEWINDOW
                    done:=TRUE
                CASE IDCMP_GADGETDOWN
                    IF (msggadget.gadgetid=GAD_RED) OR (msggadget.gadgetid=GAD_GREEN) OR (msggadget.gadgetid=GAD_BLUE)
                        cdown:=TRUE
                    ENDIF
                CASE IDCMP_MOUSEMOVE
                    IF cdown
                        IF cpen>=0 THEN SetRGB32(mhandle.screen.viewport,cpen,v32(Lt_GetAttributesA(mhandle,GAD_RED,NIL)),v32(Lt_GetAttributesA(mhandle,GAD_GREEN,NIL)),v32(Lt_GetAttributesA(mhandle,GAD_BLUE,NIL)))
                    ENDIF
                CASE IDCMP_IDCMPUPDATE
                    a:=msggadget.gadgetid
                    SELECT MAX_GADS OF a
                        CASE GAD_PUBSCREEN
                            selectPubScreen()
                            copystring(kp.pubscreen,Lt_GetAttributesA(mhandle,GAD_PUBSCREEN,NIL))
                        CASE GAD_IMAGE,GAD_STARTGAME,GAD_EATFRUIT,GAD_CRASH,GAD_GRAPHIC
                            pickFile(a)
                            SELECT a
                                CASE GAD_STARTGAME
                                    copystring(kp.startgamesound,Lt_GetAttributesA(mhandle,GAD_STARTGAME,NIL))
                                CASE GAD_EATFRUIT
                                    copystring(kp.eatfruitsound,Lt_GetAttributesA(mhandle,GAD_EATFRUIT,NIL))
                                CASE GAD_CRASH
                                    copystring(kp.crashsound,Lt_GetAttributesA(mhandle,GAD_CRASH,NIL))
                            ENDSELECT
                    ENDSELECT
                CASE IDCMP_GADGETUP
                    SELECT MAX_GADS OF msggadget.gadgetid
                        CASE GAD_PUBSCREEN
                            copystring(kp.pubscreen,Lt_GetAttributesA(mhandle,GAD_PUBSCREEN,NIL))
                        CASE GAD_POPKEY
                            copystring(kp.popkey,Lt_GetAttributesA(mhandle,GAD_POPKEY,NIL))
                        CASE GAD_STARTGAME
                            copystring(kp.startgamesound,Lt_GetAttributesA(mhandle,GAD_STARTGAME,NIL))
                        CASE GAD_EATFRUIT
                            copystring(kp.eatfruitsound,Lt_GetAttributesA(mhandle,GAD_EATFRUIT,NIL))
                        CASE GAD_CRASH
                            copystring(kp.crashsound,Lt_GetAttributesA(mhandle,GAD_CRASH,NIL))
                        CASE GAD_PRI
                            kp.priority:=Lt_GetAttributesA(mhandle,GAD_PRI,NIL)
                        CASE GAD_LETHAL
                            IF Lt_GetAttributesA(mhandle,GAD_LETHAL,NIL) THEN kp.flags:=Or(kp.flags,KPF_LETHAL180) ELSE kp.flags:=And(kp.flags,Not(KPF_LETHAL180))
                        CASE GAD_APPICON
                            IF Lt_GetAttributesA(mhandle,GAD_APPICON,NIL) THEN kp.flags:=Or(kp.flags,KPF_APPICON) ELSE kp.flags:=And(kp.flags,Not(KPF_APPICON))
                        CASE GAD_APPMENU
                            IF Lt_GetAttributesA(mhandle,GAD_APPMENU,NIL) THEN kp.flags:=Or(kp.flags,KPF_APPMENU) ELSE kp.flags:=And(kp.flags,Not(KPF_APPMENU))
                        CASE GAD_FREESOUNDS
                            IF Lt_GetAttributesA(mhandle,GAD_FREESOUNDS,NIL) THEN kp.flags:=Or(kp.flags,KPF_FREESOUNDS) ELSE kp.flags:=And(kp.flags,Not(KPF_FREESOUNDS))
                        CASE GAD_CONTSOUND
                            IF Lt_GetAttributesA(mhandle,GAD_CONTSOUND,NIL) THEN kp.flags:=Or(kp.flags,KPF_CONTSOUND) ELSE kp.flags:=And(kp.flags,Not(KPF_CONTSOUND))
                        CASE GAD_TEST1
                            playSound(mhandle,GAD_STARTGAME)
                        CASE GAD_TEST2
                            playSound(mhandle,GAD_EATFRUIT)
                        CASE GAD_TEST3
                            playSound(mhandle,GAD_CRASH)
                        CASE GAD_COLTYPE
                            a:=Lt_GetAttributesA(mhandle,GAD_COLSEL,NIL)
                            handleColType(a,msgcode)
                        CASE GAD_COLSEL
                            Lt_SetAttributesA(mhandle,GAD_RED,[GTSL_LEVEL,kp.fill[msgcode].red,TAG_DONE])
                            Lt_SetAttributesA(mhandle,GAD_GREEN,[GTSL_LEVEL,kp.fill[msgcode].green,TAG_DONE])
                            Lt_SetAttributesA(mhandle,GAD_BLUE,[GTSL_LEVEL,kp.fill[msgcode].blue,TAG_DONE])
                            Lt_SetAttributesA(mhandle,GAD_IMAGE,[GTST_STRING,kp.fill[msgcode].file,TAG_DONE])
                            Lt_SetAttributesA(mhandle,GAD_GRAPHIC,[GTST_STRING,kp.fill[msgcode].file,TAG_DONE])
                            Lt_SetAttributesA(mhandle,GAD_DRIPENS,[LAPU_ACTIVE,kp.fill[msgcode].dripen,TAG_DONE])
                            Lt_SetAttributesA(mhandle,GAD_COLTYPE,[GTCY_ACTIVE,kp.fill[msgcode].type,TAG_DONE])
                            Lt_SetAttributesA(mhandle,GAD_COLTYPEGROUP,[LAGR_ACTIVEPAGE,kp.fill[msgcode].type,TAG_DONE])
                            IF cpen>=0 THEN SetRGB32(mhandle.screen.viewport,cpen,v32(Lt_GetAttributesA(mhandle,GAD_RED,NIL)),v32(Lt_GetAttributesA(mhandle,GAD_GREEN,NIL)),v32(Lt_GetAttributesA(mhandle,GAD_BLUE,NIL)))
                            Lt_RebuildTagList(mhandle,FALSE,NIL)
                        CASE GAD_RED TO GAD_BLUE
                            cdown:=FALSE
                            IF cpen>=0 THEN SetRGB32(mhandle.screen.viewport,cpen,v32(Lt_GetAttributesA(mhandle,GAD_RED,NIL)),v32(Lt_GetAttributesA(mhandle,GAD_GREEN,NIL)),v32(Lt_GetAttributesA(mhandle,GAD_BLUE,NIL)))
                            setrgbvalue()
                        CASE GAD_DRIPENS
                            a:=Lt_GetAttributesA(mhandle,GAD_COLSEL,NIL)
                            kp.fill[a].dripen:=msgcode
                            Lt_RebuildTagList(mhandle,FALSE,NIL)
                        CASE GAD_IMAGE
                            a:=Lt_GetAttributesA(mhandle,GAD_COLSEL,NIL)
                            b:=Lt_GetAttributesA(mhandle,GAD_IMAGE,NIL)
                            copystring(kp.fill[a].file,b)
                            IF image[a]
                                disposeImageData(image[a])
                                image[a]:=0
                            ENDIF
                            Lt_RebuildTagList(mhandle,FALSE,NIL)
                        CASE GAD_GRAPHIC
                            a:=Lt_GetAttributesA(mhandle,GAD_COLSEL,NIL)
                            b:=Lt_GetAttributesA(mhandle,GAD_GRAPHIC,NIL)
                            copystring(kp.fill[a].file,b)
                            IF image[a]
                                disposeImageData(image[a])
                                image[a]:=0
                            ENDIF
                            Lt_RebuildTagList(mhandle,FALSE,NIL)
                        CASE GAD_SAVE
                            save:=TRUE
                            done:=TRUE
                        CASE GAD_CANCEL
                            save:=FALSE
                            done:=TRUE
                    ENDSELECT
                CASE IDCMP_MENUPICK
                    done:=handleMenuPick(msgcode)
            ENDSELECT
        ENDWHILE
    ENDWHILE

EXCEPT DO
    FOR a:=0 TO 6 DO IF image[a] THEN disposeImageData(image[a])
    IF cpen<>-1 THEN ReleasePen(ccm,cpen)
    IF mhandle THEN deleteMainWindow()
    IF mmenu THEN Lt_DisposeMenu(mmenu)
    IF kp THEN IF save
        KsWriteKRSNAkePrefs(kp)
        KsNotifyServer(SNAKE_NEWPREFS,NIL)
    ELSE
        FreeVec(kp)
    ENDIF
    IF sample THEN KsDeleteSoundObject(sample)
    closeCatalog()
    IF krsnakebase THEN CloseLibrary(krsnakebase)
    IF gtlayoutbase THEN CloseLibrary(gtlayoutbase)
    IF localebase THEN CloseLibrary(localebase)
    IF gadtoolsbase THEN CloseLibrary(gadtoolsbase)
    IF datatypesbase THEN CloseLibrary(datatypesbase)
    IF aslbase THEN CloseLibrary(aslbase)
    report_exception()
ENDPROC

PROC handleColType(i,t)
    DEF p=TRUE
    IF i=FILL_BACK THEN IF t=FILLTYPE_GRAPHIC THEN p:=FALSE
    IF p
        kp.fill[i].type:=t
        Lt_SetAttributesA(mhandle,GAD_COLTYPEGROUP,[LAGR_ACTIVEPAGE,t,TAG_DONE])
    ELSE
        Lt_SetAttributesA(mhandle,GAD_COLTYPE,[GTCY_ACTIVE,kp.fill[i].type,TAG_DONE])
    ENDIF
ENDPROC

PROC handleMenuPick(code)
    DEF menu,item,sub,t,s[8192]:STRING
    StrCopy(s,VERSION +
              '\nCopyright © 1995 Psilocybe Software\n\n')
    StrAdd(s,getstr(ABOUTID_MAIN))
    menu:=MENUNUM(code)
    item:=ITEMNUM(code)
    sub:=SUBNUM(code)
    SELECT menu
        CASE 0
            SELECT item
                CASE 0
                    REPEAT
                        t:=easyRequest(getstr(ABOUTID_TITLE),s,
                                       getstr(ABOUTID_BUTTONS),NIL)
                        SELECT t
                            CASE 2
                                easyRequest(getstr(ABOUTID_TITLE),
                                            getstr(ABOUTID_WARRANTY),
                                            getstr(ABOUTID_OK),NIL)
                            CASE 1
                                easyRequest(getstr(ABOUTID_TITLE),
                                            getstr(ABOUTID_CONDITIONS),
                                            getstr(ABOUTID_OK),NIL)
                        ENDSELECT
                    UNTIL t=0
                CASE 2
                    RETURN TRUE
            ENDSELECT
    ENDSELECT
ENDPROC FALSE

PROC easyRequest(title,body,gads,arglist) IS EasyRequestArgs(mwin,
            [SIZEOF easystruct,0,title,body,gads],NIL,arglist)

PROC playSound(h,id)
    IF sample THEN KsDeleteSoundObject(sample)
    IF sample:=KsReadSoundObject(Lt_GetAttributesA(h,id,NIL)) THEN KsPlaySoundObject(sample)
ENDPROC


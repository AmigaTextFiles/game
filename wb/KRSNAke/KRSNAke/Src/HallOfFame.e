->
-> ANNVIT CÆPTIS MDCCLXXVI!
->
->    Hall of Fame client 1.7 stab
->
-> $NSAREG: 23F27N06OR2748D5894.3 [Crassus]
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
-> 13 Oct 1995 : 001.007 :  Added locale support
-> 01 Oct 1995 : 001.006 :  Now functions like a listview
-> 22 Sep 1995 : 001.005 :  Understands SNAKE_HIDE/SHOWINTERFACE
-> 13 Sep 1995 : 001.004 :  Performs simple encryption on data file
-> 12 Sep 1995 : 001.003 :  Highlights current player's position
-> 20 Aug 1995 : 001.002 :  Updated to use krsnake.library
-> 27 Jun 1995 : 001.001 :  Initial release
->
-> NOVUS ORDO SECLORUM!
->

OPT OSVERSION=37

MODULE 'intuition/intuition','intuition/screens','dos/dos','graphics/text'
MODULE 'graphics/view','exec/ports','exec/lists','exec/nodes','utility'
MODULE 'reqtools','libraries/reqtools','krsnake','libraries/krsnake'
MODULE 'tools/trapguru','tools/exceptions','exec/tasks','*createpath'
MODULE 'intuition/classes','intuition/gadgetclass','intuition/icclass'
MODULE 'intuition/imageclass','utility/tagitem','locale','*krsnakecat'

RAISE   "SCR"   IF  LockPubScreen()=0,
        "WIN"   IF  OpenWindowTagList()=0,
        "DRI"   IF  GetScreenDrawInfo()=0,
        "FONT"  IF  OpenFont()=0,
        "OBJ"   IF  NewObjectA()=0

OBJECT playernode
    succ:PTR TO playernode
    pred:PTR TO playernode
    name:PTR TO CHAR
    score:LONG
ENDOBJECT

DEF krc=0,w=0:PTR TO window,s=0:PTR TO screen
DEF dri=0:PTR TO drawinfo,font:PTR TO textfont,dripens[NUMDRIPENS]:ARRAY OF INT
DEF ww=160,wh=-1,iw,ih,fy,fh,wx=0,wy=-1,th
DEF killtask=FALSE
DEF hall=0:PTR TO playernode
DEF dn[256]:ARRAY OF CHAR,current=0:PTR TO playernode
DEF visible=0,kp=0:PTR TO kprefs
DEF upimage=0:PTR TO image,downimage=0:PTR TO image,sizeimage=0:PTR TO image
DEF vertgadget=0:PTR TO gadget,upgadget=0:PTR TO gadget,downgadget=0:PTR TO gadget
DEF vtotal=0,vvisible=0,vtop=0,oldscore=0

ENUM VERT_GID=1,UP_GID,DOWN_GID

PROC max(x,y) IS IF x>y THEN x ELSE y

PROC sysisize() IS
 IF s.flags AND SCREENHIRES THEN SYSISIZE_MEDRES ELSE SYSISIZE_LOWRES

PROC newimageobject(which) IS
  NewObjectA(NIL,'sysiclass',
    [SYSIA_DRAWINFO,dri,SYSIA_WHICH,which,SYSIA_SIZE,sysisize(),NIL])

PROC newpropobject(freedom,taglist) IS
  NewObjectA(NIL,'propgclass',
    [ICA_TARGET,ICTARGET_IDCMP,PGA_FREEDOM,freedom,PGA_NEWLOOK,TRUE,
     PGA_BORDERLESS,(dri.flags AND DRIF_NEWLOOK) AND (dri.depth<>1),
     TAG_MORE,taglist])

PROC newbuttonobject(image:PTR TO object,taglist) IS
  NewObjectA(NIL,'buttongclass',
    [ICA_TARGET,ICTARGET_IDCMP,GA_IMAGE,image,TAG_MORE,taglist])

PROC updateprop(gadget:PTR TO object,attr,value)
  SetGadgetAttrsA(gadget,w,NIL,[attr,value,NIL])
ENDPROC

PROC newplayer(name:PTR TO CHAR,score)
    DEF node:PTR TO playernode,nodename:PTR TO CHAR
    NEW node
    NEW nodename[StrLen(name)+1]
    node.name:=nodename
    copystring(nodename,name)
    node.score:=score
    insertplayer(node)
ENDPROC node

PROC deleteplayer(node:PTR TO playernode)
    DEF nodename:PTR TO CHAR
    removeplayer(node)
    nodename:=node.name
    END nodename
    END node
ENDPROC

PROC removeplayer(node:PTR TO playernode)
    IF node.succ THEN node.succ::playernode.pred:=node.pred
    IF node.pred THEN node.pred::playernode.succ:=node.succ
    IF hall=node THEN hall:=node.succ
    IF Stricmp(node.name,'Player') THEN DEC vtotal
ENDPROC

PROC findplayer(name:PTR TO CHAR)
    DEF node:PTR TO playernode
    node:=hall
    WHILE node
        IF Stricmp(node.name,name)=0 THEN RETURN node
        node:=node.succ
    ENDWHILE
    node:=0
ENDPROC node

PROC insertplayer(node:PTR TO playernode)
    DEF c:PTR TO playernode,ok=0
    c:=hall
    IF Stricmp(node.name,'Player') THEN INC vtotal
    IF c=0
        node.succ:=0
        node.pred:=0
        hall:=node
    ELSE
        WHILE ok=0
            IF node.score>=c.score
                node.pred:=c.pred
                node.succ:=c
                IF node.pred
                    node.pred::playernode.succ:=node
                ELSE
                    hall:=node
                    node.pred:=0
                ENDIF
                c.pred:=node
                ok:=1
            ELSE
                IF c.succ
                    c:=c.succ
                ELSE
                    c.succ:=node
                    node.pred:=c
                    node.succ:=0
                    ok:=1
                ENDIF
            ENDIF
        ENDWHILE
    ENDIF
ENDPROC

PROC getname(score)
    DEF node:PTR TO playernode
    RtGetStringA(dn,255,getstr(HALLID_ENTERNAMETITLE),0,[RTGS_TEXTFMT,getstr(HALLID_ENTERNAME),RTGS_FLAGS,GSREQF_CENTERTEXT,NIL])
    IF (node:=findplayer(TrimStr(dn)))
        IF node.score<score
            newplayer(TrimStr(dn),score)
            deleteplayer(node)
        ENDIF
    ELSE
        newplayer(TrimStr(dn),score)
    ENDIF
    renderhall()
ENDPROC

PROC readhall() HANDLE
    DEF f=0,b[256]:ARRAY OF CHAR
    f:=Open('ENVARC:KRSNAke/HallOfFame.data',MODE_OLDFILE)
    IF f=0
        newplayer('Captain Merrill Stubing',250)
        newplayer('Dr. Adam Bricker',200)
        newplayer('Isaac Washington',150)
        newplayer('Julie McCoy',100)
        newplayer('Gopher Smith',50)
        Raise("URK")
    ENDIF
    WHILE TRUE
        readstring(f,b)
        rotstring(b)
        newplayer(b,readrotnumeral(f))
    ENDWHILE
EXCEPT DO
    IF f THEN Close(f)
ENDPROC

PROC dumphall() HANDLE
    DEF f=0,p:PTR TO playernode,b1[256]:STRING,b2[64]:STRING
    createPath('ENVARC:KRSNAke/urk')
    f:=Open('ENVARC:KRSNAke/HallOfFame.data',MODE_NEWFILE)
    IF f=0 THEN Raise("URK")
    p:=hall
    WHILE p
        IF Stricmp(p.name,'Player')
            StrCopy(b1,p.name)
            StringF(b2,'\d',p.score)
            rotstring(b1)
            rotstring(b2)
            VfPrintf(f,'%s\n%s\n',[b1,b2])
        ENDIF
        p:=p.succ
    ENDWHILE
EXCEPT DO
    IF f THEN Close(f)
ENDPROC

PROC dumpsettings() HANDLE
    DEF f=0
    createPath('ENVARC:KRSNAke/urk')
    f:=Open('ENVARC:KRSNAke/HallOfFame.snapshot',MODE_NEWFILE)
    IF f=0 THEN Raise("URK")
    VfPrintf(f,'%ld\n%ld\n%ld\n%ld\n%s\n',[wx,wy,ww,wh,dn])
EXCEPT DO
    IF f THEN Close(f)
ENDPROC

PROC readstring(f,s)
    DEF i,b[256]:ARRAY OF CHAR
    IF (Fgets(f,b,255)=0) THEN Raise("URK")
    copystring(s,b)
ENDPROC i

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

PROC rotstring(s)
    MOVE.L  s,A0
rotloop:
    MOVE.B  (A0),D0
    BEQ     endofrot
    EORI.B  #15,D0
    MOVE.B  D0,(A0)+
    BRA     rotloop
endofrot:
ENDPROC

PROC readnumeral(f)
    DEF i,b[256]:ARRAY OF CHAR
    IF (Fgets(f,b,255)=0) THEN Raise("URK")
    i:=Val(b)
ENDPROC i

PROC readrotnumeral(f)
    DEF i,b[256]:ARRAY OF CHAR
    IF (Fgets(f,b,255)=0) THEN Raise("URK")
    rotstring(b)
    i:=Val(b)
ENDPROC i

PROC readsettings()
    DEF f=0
    kp:=KsReadKRSNAkePrefs()
    IF kp=0 THEN Raise("URK")
    IF (f:=Open('ENVARC:KRSNAke/HallOfFame.snapshot',MODE_OLDFILE))
        wx:=readnumeral(f)
        wy:=readnumeral(f)
        ww:=readnumeral(f)
        wh:=readnumeral(f)
        readstring(f,dn)
        Close(f)
    ENDIF
ENDPROC

PROC bevelbox(x1,y1,x2,y2,dir=TRUE,bf=0)
    DEF shine,shadow
    IF dir
        shine:=dripens[SHINEPEN]
        shadow:=dripens[SHADOWPEN]
    ELSE
        shine:=dripens[SHADOWPEN]
        shadow:=dripens[SHINEPEN]
    ENDIF
    SetAPen(stdrast,shine)
    RectFill(stdrast,x1,y1,x1,y2)
    RectFill(stdrast,x1+1,y1,x2-1,y1)
    SetAPen(stdrast,shadow)
    RectFill(stdrast,x1+1,y2,x2,y2)
    RectFill(stdrast,x2,y1,x2,y2-1)
    IF bf
        SetAPen(stdrast,bf)
        RectFill(stdrast,x1+1,y1+1,x2-1,y2-1)
    ENDIF
ENDPROC

PROC renderhall(noclear=FALSE)
    DEF pc,ty,i=0,p:PTR TO playernode,tp,urk[32]:STRING,name[256]:STRING,u,pw,d=1024,pn=0
    recalcscale()
    GetAttr(PGA_TOP,vertgadget,{vtop})
    IF noclear=FALSE
        SetAPen(stdrast,dripens[BACKGROUNDPEN])
        RectFill(stdrast,w.borderleft+4,fy+4,w.borderleft+iw-5,w.bordertop+ih-5)
    ENDIF
    pc:=(fh-12)/th
    ty:=fy+6+(((fh-12)-(pc*th))/2)
    p:=hall
    tp:=ty+font.baseline
    IF vtop
        FOR i:=0 TO vtop-1 DO p:=p.succ
        i:=0
    ENDIF
    WHILE p AND (i<pc)
        INC i
        IF p=current
            SetAPen(stdrast,dripens[HIGHLIGHTTEXTPEN])
            p:=p.succ
            d:=oldscore
            oldscore:=p.score
            pn:=1
        ELSE
            SetAPen(stdrast,dripens[TEXTPEN])
        ENDIF
        IF (p.score>=d) OR (noclear=FALSE)
            StringF(urk,'\d',p.score)
            StrCopy(name,p.name)
            u:=TextLength(stdrast,urk,StrLen(urk))
            pw:=iw-u-24
            WHILE TextLength(stdrast,name,EstrLen(name))>pw
                StrCopy(name,p.name,EstrLen(name)-1)
            ENDWHILE
            Move(stdrast,w.borderleft+8,tp)
            Text(stdrast,name,EstrLen(name))
            Move(stdrast,w.borderleft+iw-u-8,tp)
            Text(stdrast,urk,StrLen(urk))
        ELSE
            IF pn THEN i:=pc
        ENDIF
        tp:=tp+th
        p:=p.succ
        IF current THEN IF p=current THEN IF p.succ=0 THEN RETURN
    ENDWHILE
ENDPROC

PROC render()
    iw:=w.width-w.borderleft-w.borderright
    ih:=w.height-w.bordertop-w.borderbottom
    fy:=w.bordertop+th+6
    fh:=ih-(th+6)

    SetAPen(stdrast,dripens[BACKGROUNDPEN])
    RectFill(stdrast,w.borderleft,w.bordertop,w.borderleft+iw-1,w.bordertop+ih-1)
    bevelbox(w.borderleft,w.bordertop,w.borderleft+iw-1,w.bordertop+th+5)
    bevelbox(w.borderleft,fy,w.borderleft+iw-1,w.bordertop+ih-1)
    bevelbox(w.borderleft+3,fy+3,w.borderleft+iw-4,w.bordertop+ih-4,FALSE)
    SetAPen(stdrast,dripens[HIGHLIGHTTEXTPEN])
    Move(stdrast,w.borderleft+8,w.bordertop+font.baseline+3)
    Text(stdrast,getstr(HALLID_PLAYER),StrLen(getstr(HALLID_PLAYER)))
    Move(stdrast,w.borderleft+iw-8-TextLength(stdrast,getstr(HALLID_SCORE),StrLen(getstr(HALLID_SCORE))),w.bordertop+font.baseline+3)
    Text(stdrast,getstr(HALLID_SCORE),StrLen(getstr(HALLID_SCORE)))
    renderhall()
ENDPROC

PROC openKRSNAkeLib()
    DEF base=0
    base:=OldOpenLibrary('krsnake.library')
    IF base=0 THEN OldOpenLibrary('Libs/krsnake.library')
    IF base=0 THEN OldOpenLibrary('PROGDIR:Libs/krsnake.library')
    IF base=0 THEN OldOpenLibrary('/Libs/krsnake.library')
    IF base=0 THEN OldOpenLibrary('PROGDIR:/Libs/krsnake.library')
    IF base=0 THEN Raise("klib")
ENDPROC base

PROC recalcscale()
    vvisible:=(fh-12)/th
    updateprop(vertgadget,PGA_VISIBLE,vvisible)
    updateprop(vertgadget,PGA_TOTAL,vtotal)
ENDPROC

PROC appear()
    DEF resolution,topborder,uw,uh,bw,bh,rw,rh,gw,gap
    IF visible=0
        IF StrLen(kp.pubscreen)
            s:=LockPubScreen(kp.pubscreen)
        ELSE
            s:=LockPubScreen(NIL)
        ENDIF
        font:=OpenFont(s.font)
        dri:=GetScreenDrawInfo(s)
        dripens:=dri.pens
        th:=font.ysize
        IF wh=-1 THEN wh:=(th*13)+32
        IF wy=-1 THEN wy:=s.barheight+1
        sizeimage:=newimageobject(SIZEIMAGE)
        upimage:=newimageobject(UPIMAGE)
        downimage:=newimageobject(DOWNIMAGE)
        resolution:=sysisize()
        topborder:=s.wbortop+font.ysize+1
        uw:=sizeimage.width
        uh:=sizeimage.height
        bw:=IF resolution=SYSISIZE_LOWRES THEN 1 ELSE 2
        bh:=IF resolution=SYSISIZE_HIRES THEN 2 ELSE 1
        rw:=IF resolution=SYSISIZE_HIRES THEN 3 ELSE 2
        rh:=IF resolution=SYSISIZE_HIRES THEN 2 ELSE 1
        gw:=max(upimage.width,uw)
        gw:=max(downimage.width,gw)
        gap:=1
        vertgadget:=newpropobject(FREEVERT,
          [GA_RELRIGHT,bw-gw+3,
           GA_TOP,topborder+rh,
           GA_WIDTH,gw-bw-bw-4,
           GA_RELHEIGHT,(-topborder)-uh-upimage.height-downimage.height-rh-rh,
           GA_RIGHTBORDER,TRUE,
           GA_ID,VERT_GID,
           PGA_TOTAL,vtotal,
           PGA_VISIBLE,1,
           NIL])
        upgadget:=newbuttonobject(upimage,
          [GA_RELRIGHT,(1)-upimage.width,
           GA_RELBOTTOM,(1)-upimage.height-downimage.height-uh,
           GA_RIGHTBORDER,TRUE,
           GA_PREVIOUS,vertgadget,
           GA_ID,UP_GID,
           NIL])
        downgadget:=newbuttonobject(downimage,
          [GA_RELRIGHT,(1)-downimage.width,
           GA_RELBOTTOM,(1)-downimage.height-uh,
           GA_RIGHTBORDER,TRUE,
           GA_PREVIOUS,upgadget,
           GA_ID,DOWN_GID,
           NIL])
        w:=OpenWindowTagList(NIL,[WA_WIDTH,ww,WA_HEIGHT,wh,
                                  WA_LEFT,wx,WA_TOP,wy,
                                  WA_TITLE,'Hall of Fame v1.7',
                                  WA_SIZEGADGET,TRUE,
                                  WA_DRAGBAR,TRUE,
                                  WA_DEPTHGADGET,TRUE,
                                  WA_CLOSEGADGET,TRUE,
                                  WA_ACTIVATE,FALSE,
                                  WA_SMARTREFRESH,TRUE,
                                  WA_SIZEBRIGHT,TRUE,
                                  WA_NEWLOOKMENUS,TRUE,
                                  WA_SCREENTITLE,'KRSNAke Hall of Fame v1.7',
                                  WA_AUTOADJUST,TRUE,
                                  WA_PUBSCREEN,s,
                                  WA_RMBTRAP,TRUE,
                                  WA_IDCMP,IDCMP_CLOSEWINDOW OR IDCMP_REFRESHWINDOW OR IDCMP_NEWSIZE OR IDCMP_RAWKEY OR IDCMP_IDCMPUPDATE,
                                  WA_GADGETS,vertgadget,
                                  NIL])
        WindowLimits(w,w.borderleft+w.borderright+128,w.bordertop+w.borderbottom+(th*12),-1,-1)
        SetStdRast(w.rport)
        SetFont(stdrast,font)
        render()
        visible:=1
    ENDIF
ENDPROC

PROC vanish()
    IF visible
        wx:=w.leftedge;wy:=w.topedge;ww:=w.width;wh:=w.height
        IF w THEN CloseWindow(w)
        IF vertgadget THEN DisposeObject(vertgadget)
        IF upgadget THEN DisposeObject(upgadget)
        IF downgadget THEN DisposeObject(downgadget)
        IF sizeimage THEN DisposeObject(sizeimage)
        IF upimage THEN DisposeObject(upimage)
        IF downimage THEN DisposeObject(downimage)
        IF dri THEN FreeScreenDrawInfo(s,dri)
        IF font THEN CloseFont(font)
        IF s THEN UnlockPubScreen(NIL,s)
        w:=0;dri:=0;font:=0;s:=0;visible:=0
        sizeimage:=0;upimage:=0;downimage:=0
        vertgadget:=0;upgadget:=0;downgadget:=0
    ENDIF
ENDPROC

PROC main() HANDLE
    DEF sig,mask,icl,ico,iad,msg:PTR TO intuimessage,postpone=0,fnord=0,v,oldtop
    trapguru()
    krsnakebase:=openKRSNAkeLib()
    IF (reqtoolsbase:=OpenLibrary('reqtools.library',38))=0 THEN Throw("LIB",'reqtools.library')
    IF (utilitybase:=OpenLibrary('utility.library',37))=0 THEN Throw("LIB",'utility.library')
    localebase:=OpenLibrary('locale.library',37)
    openCatalog()
    copystring(dn,'Crassus')
    GetVar('USER',dn,255,NIL)
    readsettings()
    readhall()
    SetTaskPri(FindTask(NIL),kp.priority)
    IF (krc:=KsRegisterClient())=0 THEN Throw("krsX",getstr(ERRORID_NOKRSNAKE))

    REPEAT
        IF visible
            mask:=Shl(1,KsGetClientSig(krc)) OR Shl(1,w.userport::mp.sigbit)
        ELSE
            mask:=Shl(1,KsGetClientSig(krc))
        ENDIF
        sig:=Wait(mask)
        IF And(sig,Shl(1,KsGetClientSig(krc)))
            fnord:=0
            WHILE KsReadEvent(krc,{icl},{ico})
                SELECT icl
                    CASE SNAKE_NEWGAME
                        oldscore:=0
                        current:=newplayer('Player',0)
                        renderhall()
                    CASE SNAKE_NEWSCORE
                        postpone:=ico
                        fnord:=1
                    CASE SNAKE_QUIT
                        killtask:=TRUE
                    CASE SNAKE_GAMEOVER
                        deleteplayer(current)
                        current:=0
                        getname(ico)
                    CASE SNAKE_SHOWINTERFACE
                        appear()
                    CASE SNAKE_HIDEINTERFACE
                        vanish()
                ENDSELECT
            ENDWHILE
            IF fnord=0 AND postpone>0 AND current
                removeplayer(current)
                current.score:=postpone
                insertplayer(current)
                IF visible THEN renderhall(TRUE)
                postpone:=0
            ENDIF
        ELSEIF visible=1
            IF And(sig,Shl(1,w.userport::mp.sigbit))
                WHILE (msg:=GetMsg(w.userport))
                    icl:=msg.class
                    ico:=msg.code
                    iad:=msg.iaddress
                    ReplyMsg(msg)
                    SELECT icl
                        CASE IDCMP_CLOSEWINDOW
                            killtask:=TRUE
                        CASE IDCMP_REFRESHWINDOW
                            render()
                        CASE IDCMP_NEWSIZE
                            recalcscale()
                            render()
                        CASE IDCMP_RAWKEY
                            IF ico=$45 THEN killtask:=TRUE
                            IF ico=$4C
                                GetAttr(PGA_TOP,vertgadget,{oldtop})
                                IF oldtop>0
                                    updateprop(vertgadget,PGA_TOP,oldtop-1)
                                    renderhall()
                                ENDIF
                            ENDIF
                            IF ico=$4D
                                GetAttr(PGA_TOP,vertgadget,{oldtop})
                                IF oldtop<(vtotal-vvisible)
                                    updateprop(vertgadget,PGA_TOP,oldtop+1)
                                    renderhall()
                                ENDIF
                            ENDIF
                        CASE IDCMP_IDCMPUPDATE
                            v:=GetTagData(GA_ID,0,iad)
                            SELECT v
                                CASE VERT_GID
                                    GetAttr(PGA_TOP,vertgadget,{oldtop})
                                    IF oldtop<>vtop THEN renderhall()
                                CASE UP_GID
                                    GetAttr(PGA_TOP,vertgadget,{oldtop})
                                    IF oldtop>0
                                        updateprop(vertgadget,PGA_TOP,oldtop-1)
                                        renderhall()
                                    ENDIF
                                CASE DOWN_GID
                                    GetAttr(PGA_TOP,vertgadget,{oldtop})
                                    IF oldtop<(vtotal-vvisible)
                                        updateprop(vertgadget,PGA_TOP,oldtop+1)
                                        renderhall()
                                    ENDIF
                            ENDSELECT
                    ENDSELECT
                ENDWHILE
            ENDIF
        ENDIF
    UNTIL killtask

    vanish()
    dumphall()
    dumpsettings()

EXCEPT DO
    IF krc THEN KsRemoveClient(krc)
    vanish()
    closeCatalog()
    IF kp THEN FreeVec(kp)
    IF utilitybase THEN CloseLibrary(utilitybase)
    IF reqtoolsbase THEN CloseLibrary(reqtoolsbase)
    IF localebase THEN CloseLibrary(localebase)
    IF krsnakebase THEN CloseLibrary(krsnakebase)
    IF exception THEN report_exception()
ENDPROC

CHAR '$VER: HallOfFame 1.007 (13 Oct 1995) stable beta test version'


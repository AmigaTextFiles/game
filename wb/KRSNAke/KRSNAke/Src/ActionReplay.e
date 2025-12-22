->
-> ANNVIT CÆPTIS MDCCLXXVI!
->
->    ActionReplay 1.7 stab
->
-> $NSAREG: 23F11N07OR2748D5963.6 [Crassus]
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
-> 23 Oct 1995 : 001.007 :  Uses krsnake graphics
-> 13 Oct 1995 : 001.006 :  Added locale support
-> 01 Oct 1995 : 001.005 :  Some small bugfixes
-> 22 Sep 1995 : 001.004 :  Understands SNAKE_HIDE/SHOWINTERFACE
-> 12 Sep 1995 : 001.003 :  Updated to use datatypes and new prefs
-> 21 Aug 1995 : 001.002 :  Finished version, supports krsnake.library
-> 11 Jul 1995 : 001.001 :  Initial release
->
-> NOVUS ORDO SECLORUM!
->

OPT OSVERSION=37

MODULE 'intuition/intuition','intuition/screens','dos/dos','graphics/text'
MODULE 'graphics/view','exec/lists','exec/nodes','exec/ports','graphics/gfx'
MODULE 'libraries/krsnake','krsnake','*graphic'
MODULE 'tools/trapguru','tools/exceptions','*tiledbitmap','*createpath'
MODULE 'tools/cookrawkey','tools/ctype','locale','*krsnakecat'

RAISE   "SCR"   IF  LockPubScreen()=0,
        "WIN"   IF  OpenWindowTagList()=0,
        "DRI"   IF  GetScreenDrawInfo()=0,
        "FONT"  IF  OpenFont()=0

OBJECT event
    next:PTR TO event
    event:LONG
    data:LONG
ENDOBJECT

DEF krc=0
DEF w=0:PTR TO window,s=0:PTR TO screen,dri=0:PTR TO drawinfo
DEF font:PTR TO textfont,dripens[NUMDRIPENS]:ARRAY OF INT
DEF bw=3,bh=3,fw=128,fh=128,fy,gy,ww,wh,wx=0,wy=-1,th
DEF chunk=0,hx=15,hy=15,sx=0,sy=-1,eaten=0,playing=0,cx=-1,cy=-1,speed=3
DEF fifox[1024]:ARRAY OF INT,fifoy[1024]:ARRAY OF INT,fifos=0,fifoe=1,fifol=2
DEF matrix[1024]:ARRAY OF INT,killtask=FALSE,gameover=0
DEF fillp[7]:ARRAY OF LONG,datatype[7]:ARRAY OF LONG,cp=0,paused=0
DEF wantobtainpens=0,pensobtained=0,graphic[7]:ARRAY OF LONG
DEF cstr=0,kp=0:PTR TO kprefs,firstevent=0:PTR TO event,lastevent=0:PTR TO event
DEF visible=0,head=3

PROC obtainpen(a)
    SELECT 4 OF kp.fill[a].type
        CASE FILLTYPE_RGB
            fillp[a]:=ObtainBestPenA(s.viewport.colormap,v32(kp.fill[a].red),v32(kp.fill[a].green),v32(kp.fill[a].blue),[OBP_PRECISION,PRECISION_EXACT,NIL])
        CASE FILLTYPE_DATATYPE
            datatype[a]:=createImageData(kp.fill[a].file,s)
        CASE FILLTYPE_GRAPHIC
            graphic[a]:=loadGraphic(kp.fill[a].file,s)
    ENDSELECT
ENDPROC

PROC scaleGraphics()
    DEF i
    FOR i:=0 TO 6
        IF kp.fill[i].type=FILLTYPE_GRAPHIC THEN scaleGraphic(graphic[i],bw,bh,s)
    ENDFOR
ENDPROC

PROC v32(x) IS Or(Shl(x,24),Or(Shl(x,16),Or(Shl(x,8),x)))

PROC obtainpens()
    DEF gfxver,a
    MOVE.L  gfxbase,A0
    MOVE.W  20(A0),gfxver
    IF gfxver>=39
        pensobtained:=1
        FOR a:=0 TO 6 DO obtainpen(a)
    ENDIF
ENDPROC

PROC freepens()
    DEF a
    FOR a:=0 TO 6
        SELECT 4 OF kp.fill[a].type
            CASE FILLTYPE_RGB
                IF fillp[a]<>-1 THEN ReleasePen(s.viewport::viewport.colormap,fillp[a])
            CASE FILLTYPE_DATATYPE
                IF datatype[a] THEN disposeImageData(datatype[a])
            CASE FILLTYPE_GRAPHIC
                IF graphic[a] THEN freeGraphic(graphic[a])
        ENDSELECT
    ENDFOR
ENDPROC

PROC dumpsettings() HANDLE
    DEF f=0
    createPath('ENVARC:KRSNAke/urk')
    f:=Open('ENVARC:KRSNAke/ActionReplay.snapshot',MODE_NEWFILE)
    IF f=0 THEN Raise("URK")
    VfPrintf(f,'%ld\n%ld\n%ld\n%ld\n%ld\n',[wx,wy,bw,bh,speed])
EXCEPT DO
    IF f THEN Close(f)
ENDPROC

PROC readnumeral(f)
    DEF i,b[256]:ARRAY OF CHAR
    IF (Fgets(f,b,255)=0) THEN Raise("URK")
    i:=Val(b)
ENDPROC i

PROC readsettings()
    DEF f=0
    kp:=KsReadKRSNAkePrefs()
    IF kp=0 THEN Raise("Pref")
    wantobtainpens:=TRUE
    IF (f:=Open('ENVARC:KRSNAke/ActionReplay.snapshot',MODE_OLDFILE))
        wx:=readnumeral(f)
        wy:=readnumeral(f)
        bw:=readnumeral(f)
        fw:=bw*32
        bh:=readnumeral(f)
        fh:=bh*32
        speed:=readnumeral(f)
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

PROC renderlink(x,y,p)
    DEF sx,sy,a
    sx:=(x*bw)+4
    sy:=(y*bh)+fy
    IF kp.fill[p].type<>FILLTYPE_GRAPHIC
        IF p>FILL_BACK
            bevelbox(sx,sy,sx+bw-1,sy+bh-1,TRUE)
            renderfill(sx+1,sy+1,sx+bw-2,sy+bh-2,p)
        ELSE
            renderfill(sx,sy,sx+bw-1,sy+bh-1,FILL_BACK)
        ENDIF
    ELSE
        IF p<FILL_FRUIT1 THEN a:=matrix[(y*32)+x]-1 ELSE a:=0
        drawGraphic(stdrast,graphic[p],a,sx,sy)
    ENDIF
ENDPROC

PROC renderfill(x1,y1,x2,y2,p)
    DEF r:rectangle,d:PTR TO imagedata
    SELECT 4 OF kp.fill[p].type
        CASE FILLTYPE_RGB,FILLTYPE_GRAPHIC
            SetAPen(stdrast,fillp[p])
            RectFill(stdrast,x1,y1,x2,y2)
        CASE FILLTYPE_DRIPEN
            SetAPen(stdrast,dripens[kp.fill[p].dripen])
            RectFill(stdrast,x1,y1,x2,y2)
        CASE FILLTYPE_DATATYPE
            d:=datatype[p]
            r.minx:=x1
            r.maxx:=x2
            r.miny:=y1
            r.maxy:=y2
            copyTiledBitMap(d,stdrast,r)
    ENDSELECT
ENDPROC

PROC rendersnake()
    DEF i,p
    renderfill(4,fy,fw+3,fh+fy-1,FILL_BACK)
    i:=fifol
    p:=fifos
    REPEAT
        IF i>1
            renderlink(fifox[p],fifoy[p],FILL_LINK)
        ELSE
            renderlink(fifox[p],fifoy[p],FILL_HEAD)
        ENDIF
        p:=p+1
        IF p>=1024 THEN p:=0
        i:=i-1
    UNTIL i=0
    IF (cx>=0) AND (cy>=0) THEN renderlink(cx,cy,FILL_FRUIT+cp)
ENDPROC

PROC pushlink(data)
    DEF x,y
    x:=And(data,$FF)
    y:=And(Shr(data,8),$FF)
    fifoe:=fifoe+1
    fifol:=fifol+1
    IF fifoe>=1024 THEN fifoe:=0
    fifox[fifoe]:=x
    fifoy[fifoe]:=y
    matrix[(y*32)+x]:=head
ENDPROC

PROC poplink()
    DEF x,y
    x:=fifox[fifos]
    y:=fifoy[fifos]
    fifos:=fifos+1
    fifol:=fifol-1
    IF fifos>=1024 THEN fifos:=0
    matrix[(y*32)+x]:=0
ENDPROC x,y

PROC renderstatus(str=0:PTR TO CHAR,redraw=TRUE)
    DEF sw
    IF str THEN cstr:=str
    IF visible
        IF redraw
            SetAPen(stdrast,dripens[BACKGROUNDPEN])
            RectFill(stdrast,1,gy+2,ww-2,gy+th+1)
        ENDIF
        IF cstr
            sw:=TextLength(stdrast,cstr,StrLen(cstr))
            SetAPen(stdrast,dripens[TEXTPEN])
            Move(stdrast,(ww-sw)/2,gy+3+font.baseline)
            Text(stdrast,cstr,StrLen(cstr))
        ENDIF
    ENDIF
ENDPROC

PROC render()
    DEF rw,rh
    ww:=w.width-w.borderleft-w.borderright
    wh:=w.height-w.bordertop-w.borderbottom
    fw:=ww-8
    fh:=wh-th-14
    fy:=4
    gy:=fh+8
    bw:=fw/32
    bh:=fh/32
    rw:=bw*32
    rh:=bh*32
    IF (fw-rw) OR (fh-rh) THEN JUMP done

    scaleGraphics()
    SetRast(stdrast,dripens[BACKGROUNDPEN])
    bevelbox(0,gy,ww-1,gy+th+5)
    bevelbox(0,0,ww-1,gy-1)
    bevelbox(3,3,ww-4,gy-4,FALSE)
    renderstatus()
    rendersnake()
done:
ENDPROC

PROC verifysize()
    DEF rw,rh,aw,ah
    aw:=w.width
    ah:=w.height
    fw:=aw-w.borderleft-w.borderright-8
    fh:=ah-w.bordertop-w.borderbottom-th-14
    bw:=fw/32
    bh:=fh/32
    rw:=bw*32
    rh:=bh*32
    IF (fw-rw) OR (fh-rh)
        aw:=aw-(fw-rw)
        ah:=ah-(fh-rh)
        ChangeWindowBox(w,w.leftedge,w.topedge,aw,ah)
    ENDIF
ENDPROC

PROC transformhead(x,y,h)
    DEF p,nh
    p:=(y*32)+x
    nh:=matrix[p]
    SELECT nh
        CASE 5
            SELECT h
                CASE 5
                    matrix[p]:=1
                CASE 6
                    matrix[p]:=15
                CASE 8
                    matrix[p]:=16
            ENDSELECT
        CASE 6
            SELECT h
                CASE 5
                    matrix[p]:=14
                CASE 6
                    matrix[p]:=2
                CASE 7
                    matrix[p]:=20
            ENDSELECT
        CASE 7
            SELECT h
                CASE 6
                    matrix[p]:=17
                CASE 7
                    matrix[p]:=3
                CASE 8
                    matrix[p]:=18
            ENDSELECT
        CASE 8
            SELECT h
                CASE 5
                    matrix[p]:=13
                CASE 7
                    matrix[p]:=19
                CASE 8
                    matrix[p]:=4
            ENDSELECT
    ENDSELECT
ENDPROC

PROC transformtail(x,y)
    DEF p,h
    p:=(y*32)+x
    h:=matrix[p]
    SELECT 21 OF h
        CASE 1,5,13,14
            matrix[p]:=9
        CASE 2,6,15,17
            matrix[p]:=10
        CASE 3,7,19,20
            matrix[p]:=11
        CASE 4,8,16,18
            matrix[p]:=12
    ENDSELECT
ENDPROC

PROC newchunk(data)
    cx:=And(data,$FF)
    cy:=And(Shr(data,8),$FF)
    chunk:=And(Shr(data,24),$FF)
    cp:=And(Shr(data,16),$FF)
    renderlink(cx,cy,FILL_FRUIT+cp)
ENDPROC

PROC resetgame()
    DEF i
    FOR i:=0 TO 1023 DO matrix[i]:=0
    playing:=1
    fifos:=0
    fifoe:=1
    fifol:=2
    fifox[0]:=15
    fifoy[0]:=16
    fifox[1]:=15
    fifoy[1]:=15
    matrix[(15*32)+15]:=8
    matrix[(16*32)+15]:=12
    head:=8
    sx:=0
    sy:=-1
    chunk:=0
    eaten:=0
    hx:=15
    hy:=15
    cx:=-1
    cy:=-1
    gameover:=0
    paused:=0
    IF visible THEN render()
ENDPROC

PROC newevent(event,data)
    DEF e:PTR TO event
    NEW e
    e.event:=event
    e.data:=data
    IF lastevent THEN lastevent.next:=e
    lastevent:=e
    IF firstevent=0 THEN firstevent:=e
ENDPROC

PROC flushevents()
    DEF e:PTR TO event,u:PTR TO event
    e:=firstevent
    WHILE e
        u:=e
        e:=e.next
        END u
    ENDWHILE
    firstevent:=0
    lastevent:=0
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

PROC speedcheck(char)
    IF (char>="1") AND (char<="9") THEN speed:=char-"0"
ENDPROC

PROC replaySequence()
    DEF msg:PTR TO intuimessage,e:PTR TO event,x,y,icl,ico,iqu,iad,ct
    resetgame()
    renderstatus(getstr(REPLAYID_STOP),TRUE)
    e:=firstevent
    WHILE e
        WHILE e.event=SNAKE_NEWCHUNK
            newchunk(e.data)
            e:=e.next
            IF e=0 THEN RETURN FALSE
        ENDWHILE
        IF e.event=SNAKE_MOVES
            head:=And(Shr(e.data,16),$FF)
            transformhead(fifox[fifoe],fifoy[fifoe],head)
            IF kp.fill[FILL_LINK].type=FILLTYPE_GRAPHIC THEN renderlink(fifox[fifoe],fifoy[fifoe],FILL_BACK)
            renderlink(fifox[fifoe],fifoy[fifoe],FILL_LINK)
            pushlink(e.data)
            renderlink(fifox[fifoe],fifoy[fifoe],FILL_HEAD)
            IF (fifox[fifoe]=cx) AND (fifoy[fifoe]=cy) THEN eaten:=eaten+chunk
            IF eaten
                eaten:=eaten-1
            ELSE
                x,y:=poplink()
                renderlink(x,y,FILL_BACK)
                transformtail(fifox[fifos],fifoy[fifos])
                IF kp.fill[FILL_LINK].type=FILLTYPE_GRAPHIC THEN renderlink(fifox[fifos],fifoy[fifos],FILL_BACK)
                renderlink(fifox[fifos],fifoy[fifos],FILL_LINK)
            ENDIF
            ct:=speed
            WHILE ct
                DEC ct
                WaitTOF()
            ENDWHILE
        ENDIF
        WHILE (msg:=GetMsg(w.userport))
            icl:=msg.class
            ico:=msg.code
            iqu:=msg.qualifier
            iad:=msg.iaddress
            ReplyMsg(msg)
            SELECT icl
                CASE IDCMP_CLOSEWINDOW
                    RETURN TRUE
                CASE IDCMP_REFRESHWINDOW
                    render()
                CASE IDCMP_NEWSIZE
                    verifysize()
                    render()
                CASE IDCMP_RAWKEY
                    IF ico=$45 THEN RETURN TRUE
                    ico:=tolower(cookRawkey(ico,iqu,iad))
                    speedcheck(ico)
                    SELECT ico
                        CASE " "
                            RETURN FALSE
                    ENDSELECT
            ENDSELECT
        ENDWHILE
        e:=e.next
    ENDWHILE
ENDPROC FALSE

PROC appear()
    IF visible=0
        visible:=1
        IF StrLen(kp.pubscreen)
            s:=LockPubScreen(kp.pubscreen)
        ELSE
            s:=LockPubScreen(NIL)
        ENDIF
        font:=OpenFont(s.font)
        dri:=GetScreenDrawInfo(s)
        dripens:=dri.pens
        th:=font.ysize
        IF wy=-1 THEN wy:=s.barheight+1
        ww:=fw+8
        wh:=fh+th+14
        obtainpens()
        w:=OpenWindowTagList(NIL,[WA_INNERWIDTH,ww,WA_INNERHEIGHT,wh,
                                  WA_LEFT,wx,WA_TOP,wy,
                                  WA_TITLE,'ActionReplay v1.7',
                                  WA_SIZEGADGET,TRUE,
                                  WA_DRAGBAR,TRUE,
                                  WA_DEPTHGADGET,TRUE,
                                  WA_CLOSEGADGET,TRUE,
                                  WA_ACTIVATE,FALSE,
                                  WA_SMARTREFRESH,TRUE,
                                  WA_SIZEBBOTTOM,TRUE,
                                  WA_GIMMEZEROZERO,TRUE,
                                  WA_NEWLOOKMENUS,TRUE,
                                  WA_SCREENTITLE,'KRSNAke ActionReplay v1.7',
                                  WA_AUTOADJUST,TRUE,
                                  WA_PUBSCREEN,s,
                                  WA_RMBTRAP,TRUE,
                                  WA_IDCMP,IDCMP_CLOSEWINDOW OR IDCMP_REFRESHWINDOW OR IDCMP_NEWSIZE OR IDCMP_RAWKEY OR IDCMP_GADGETUP,
                                  NIL])
        WindowLimits(w,w.borderleft+w.borderright+104,w.bordertop+w.borderbottom+th+110,-1,-1)
        SetStdRast(w.rport)
        SetFont(stdrast,font)
        render()
    ENDIF
ENDPROC

PROC vanish()
    IF visible
        wx:=w.leftedge;wy:=w.topedge
        IF w THEN CloseWindow(w)
        IF pensobtained THEN freepens()
        IF dri THEN FreeScreenDrawInfo(s,dri)
        IF font THEN CloseFont(font)
        IF s THEN UnlockPubScreen(NIL,s)
        w:=0;pensobtained:=0;dri:=0;font:=0;s:=0;visible:=0
    ENDIF
ENDPROC

PROC main() HANDLE
    DEF icl,ico,iqu,iad,mask,sig,msg:PTR TO intuimessage,x,y
    trapguru()
    warmupRawkeyCooker()
    krsnakebase:=openKRSNAkeLib()
    datatypesbase:=OpenLibrary('datatypes.library',39)
    localebase:=OpenLibrary('locale.library',37)
    openCatalog()
    fifox[0]:=15
    fifoy[0]:=15
    readsettings()
    SetTaskPri(FindTask(NIL),kp.priority)
    resetgame()
    playing:=0
    krc:=KsRegisterClient()
    renderstatus(getstr(REPLAYID_NOGAME),TRUE)

    REPEAT
        IF visible
            mask:=Shl(1,KsGetClientSig(krc)) OR Shl(1,w.userport::mp.sigbit)
        ELSE
            mask:=Shl(1,KsGetClientSig(krc))
        ENDIF
        sig:=Wait(mask)
        IF And(sig,Shl(1,KsGetClientSig(krc)))
            WHILE KsReadEvent(krc,{icl},{ico})
                SELECT icl
                    CASE SNAKE_QUIT
                        killtask:=TRUE
                    CASE SNAKE_NEWGAME
                        flushevents()
                        resetgame()
                        renderstatus(getstr(REPLAYID_RECORDING),TRUE)
                    CASE SNAKE_PAUSED
                        renderstatus(getstr(REPLAYID_PAUSED),TRUE)
                    CASE SNAKE_RESTARTED
                        renderstatus(getstr(REPLAYID_RECORDING),TRUE)
                    CASE SNAKE_GAMEOVER
                        renderstatus(getstr(REPLAYID_FINISHED),TRUE)
                    CASE SNAKE_MOVES
                        newevent(icl,ico)
                        head:=And(Shr(ico,16),$FF)
                        transformhead(fifox[fifoe],fifoy[fifoe],head)
                        IF kp.fill[FILL_LINK].type=FILLTYPE_GRAPHIC THEN renderlink(fifox[fifoe],fifoy[fifoe],FILL_BACK)
                        renderlink(fifox[fifoe],fifoy[fifoe],FILL_LINK)
                        pushlink(ico)
                        renderlink(fifox[fifoe],fifoy[fifoe],FILL_HEAD)
                        IF (fifox[fifoe]=cx) AND (fifoy[fifoe]=cy) THEN eaten:=eaten+chunk
                        IF eaten
                            eaten:=eaten-1
                        ELSE
                            x,y:=poplink()
                            renderlink(x,y,FILL_BACK)
                            transformtail(fifox[fifos],fifoy[fifos])
                            IF kp.fill[FILL_LINK].type=FILLTYPE_GRAPHIC THEN renderlink(fifox[fifos],fifoy[fifos],FILL_BACK)
                            renderlink(fifox[fifos],fifoy[fifos],FILL_LINK)
                        ENDIF
                    CASE SNAKE_NEWCHUNK
                        newevent(icl,ico)
                        newchunk(ico)
                    CASE SNAKE_SHOWINTERFACE
                        appear()
                    CASE SNAKE_HIDEINTERFACE
                        vanish()
                ENDSELECT
            ENDWHILE
        ENDIF
        IF visible
            IF And(sig,Shl(1,w.userport::mp.sigbit))
                WHILE (msg:=GetMsg(w.userport))
                    icl:=msg.class
                    ico:=msg.code
                    iqu:=msg.qualifier
                    iad:=msg.iaddress
                    ReplyMsg(msg)
                    SELECT icl
                        CASE IDCMP_CLOSEWINDOW
                            killtask:=TRUE
                        CASE IDCMP_REFRESHWINDOW
                            render()
                        CASE IDCMP_NEWSIZE
                            verifysize()
                            render()
                        CASE IDCMP_RAWKEY
                            IF ico=$45 THEN killtask:=TRUE
                            ico:=tolower(cookRawkey(ico,iqu,iad))
                            speedcheck(ico)
                            SELECT ico
                                CASE "r"
                                    killtask:=replaySequence()
                                    renderstatus(getstr(REPLAYID_FINISHED),TRUE)
                            ENDSELECT
                    ENDSELECT
                ENDWHILE
            ENDIF
        ENDIF
    UNTIL killtask

    vanish()
    dumpsettings()

EXCEPT DO
    IF krc THEN KsRemoveClient(krc)
    IF kp THEN FreeVec(kp)
    vanish()
    closeCatalog()
    IF datatypesbase THEN CloseLibrary(datatypesbase)
    IF localebase THEN CloseLibrary(localebase)
    IF krsnakebase THEN CloseLibrary(krsnakebase)
    shutdownRawkeyCooker()
    IF exception THEN IF exception="krsX" THEN PrintF(getstr(ERRORID_NOKRSNAKE)) ELSE report_exception()
ENDPROC

CHAR '$VER: ActionReplay 1.007 (23 Oct 1995) stable beta test version'


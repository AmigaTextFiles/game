->
-> ANNVIT CÆPTIS MDCCLXXVI!
->
->      KRSNAke v1.17 Stab
->
-> $NSAREG: 23F07N07OR2748D5944.7 [Fnord!]
->
-> Copyright © 1995, 1996 Psilocybe Software
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
-> 22 Feb 1996 : 001.017 :  Notifies user about important dates :)
-> 26 Jan 1996 : 001.016 :  Optimised and debugged ARexx interface
-> 24 Oct 1995 : 001.015 :  Uses new server notification system
-> 24 Oct 1995 : 001.014 :  Resets itself when prefs are changed
-> 19 Oct 1995 : 001.013 :  Graphic snake is scaled and masked
-> 14 Oct 1995 : 001.012 :  Snake can be graphic now
-> 13 Oct 1995 : 001.011 :  Added locale support
-> 08 Oct 1995 : 001.010 :  Optimised the score updating a little.
-> 08 Oct 1995 : 001.009 :  Oops.. Rnd() wasn't properly seeded. Fixed now.
-> 22 Sep 1995 : 001.008 :  Now is a commodity, can appear/disappear.
-> 19 Sep 1995 : 001.007 :  Added ARexx port and cleaned up imsg handling.
-> 10 Sep 1995 : 001.006 :  Uses new prefs system and datatype backgrounds.
-> 12 Jul 1995 : 001.005 :  Uses krsnake.library instead of internal c/s code.
-> 11 Jul 1995 : 001.004 :  Autostarts clients.
-> 07 Jul 1995 : 001.003 :  Now sends SNAKE_MOVES event to clients.
-> 27 Jun 1995 : 001.002 :  Added client/server interface.
-> 23 Jun 1995 : 001.001 :  Initial revision
->
-> NOVUS ORDO SECLORUM!
->

OPT OSVERSION=39
OPT PREPROCESS

MODULE 'intuition/intuition','intuition/screens','dos/dos','graphics/text'
MODULE 'graphics/view','datatypes/datatypes','datatypes/datatypesclass'
MODULE 'datatypes/soundclass','datatypes','exec/execbase','exec/lists','utility'
MODULE 'exec/semaphores','exec/nodes','dos/dostags','exec/libraries','dos/dosextens'
MODULE 'krsnake','libraries/krsnake','tools/trapguru','exec/ports'
MODULE 'libraries/lowlevel','lowlevel','datatypes/pictureclass','graphics/gfx'
MODULE 'commodities','libraries/commodities','tools/ports','amigalib/cx'
MODULE 'wb','icon','workbench/workbench','locale','utility/tagitem'
MODULE 'tools/arexx','rexx/errors','utility/date','class/hash','other/split'

MODULE '*tiledbitmap','*krsnakecat','*graphic'

RAISE   "SCR"   IF  LockPubScreen()=0,
        "WIN"   IF  OpenWindowTagList()=0,
        "DRI"   IF  GetScreenDrawInfo()=0,
        "FONT"  IF  OpenFont()=0,
        "DOBJ"  IF  AllocDosObject()=0,
        "LSEG"  IF  LoadSeg()=0,
        "CXBR"  IF  CxBroker()=0,
        "PORT"  IF  CreateMsgPort()=0

#define KRSNAKEVER {krsnakever}+6

OBJECT rexxcommand OF hashlink
    id:INT
ENDOBJECT

DEF krs=0
DEF w=0:PTR TO window,s=0:PTR TO screen,dri=0:PTR TO drawinfo
DEF font:PTR TO textfont,dripens[NUMDRIPENS]:ARRAY OF INT
DEF bw=4,bh=4,fw=128,fh=128,fy,ww,wh,wx=0,wy=-1,th
DEF chunk=0,hx=15,hy=15,sx=0,sy=-1,eaten=0,playing=0,cx=-1,cy=-1,counter=3,speed=3
DEF fifox[1024]:ARRAY OF INT,fifoy[1024]:ARRAY OF INT,fifos=0,fifoe=0,fifol=1
DEF matrix[1024]:ARRAY OF INT,killtask=FALSE,gameover=0
DEF keybuf[256]:ARRAY OF CHAR,keybufs=1,keybufe=0,keybufl=0
DEF fillp[7]:ARRAY OF LONG,datatype[7]:ARRAY OF LONG,cp=0,paused=0
DEF wantobtainpens=0,pensobtained=0,visible=0
DEF bgs=0,efs=0,crs=0,nsx,nsw,nsh
DEF kp=0:PTR TO kprefs,rexxPort=0:PTR TO mp
DEF broker=0,brokerPort=0:PTR TO mp
DEF appicon=0,appmenu=0,myicon=0:PTR TO diskobject,appPort=0:PTR TO mp
DEF head,graphic[7]:ARRAY OF LONG,newprefs=0
DEF rexxwait=0,rexxwaitmode=0,rexxhash=0:PTR TO hashtable

ENUM CXID_POPKEY=1
ENUM APPID_ICON=1,APPID_MENU

ENUM AREXX_ERROR=0,
     AREXX_CHECK=1,
     AREXX_DOWN,
     AREXX_GET,
     AREXX_HIDE,
     AREXX_LEFT,
     AREXX_NEWGAME,
     AREXX_PAUSE,
     AREXX_QUIT,
     AREXX_RIGHT,
     AREXX_SET,
     AREXX_SHOW,
     AREXX_UP,
     AREXX_WAIT,
     AREXX_MAX


PROC randomise()
    DEF ds:datestamp
    DateStamp(ds)
    Rnd(0-And(ds.tick+ds.days+ds.minute,$7fffffff))
ENDPROC

PROC launchclients() HANDLE
    DEF fib=0:PTR TO fileinfoblock,lock=0,olddir,cc=0
    fib:=AllocDosObject(DOS_FIB,NIL)
    lock:=Lock('PROGDIR:Clients',ACCESS_READ)
    IF lock=0 THEN Raise(1)
    IF Examine(lock,fib)
        olddir:=CurrentDir(lock)
        WHILE ExNext(lock,fib)
            IF fib.direntrytype<0
                IF launchClient(fib.filename)=0 THEN INC cc
            ENDIF
        ENDWHILE
        CurrentDir(olddir)
    ENDIF
EXCEPT DO
    IF lock THEN UnLock(lock)
    IF fib THEN FreeDosObject(DOS_FIB,fib)
    IF exception>1 THEN ReThrow()
ENDPROC

PROC launchClient(name) IS SystemTagList(name,[SYS_ASYNCH,TRUE,SYS_INPUT,NIL,SYS_OUTPUT,NIL,TAG_DONE])

PROC readsounds()
    IF StrLen(kp.startgamesound) THEN bgs:=KsReadSoundObject(kp.startgamesound)
    IF StrLen(kp.eatfruitsound) THEN efs:=KsReadSoundObject(kp.eatfruitsound)
    IF StrLen(kp.crashsound) THEN crs:=KsReadSoundObject(kp.crashsound)
ENDPROC

PROC freesounds()
    KsDeleteSoundObject(bgs)
    KsDeleteSoundObject(efs)
    KsDeleteSoundObject(crs)
    bgs:=0
    efs:=0
    crs:=0
ENDPROC

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
        fillp[a]:=-1
        datatype[a]:=0
        graphic[a]:=0
    ENDFOR
ENDPROC
 
PROC dumpsettings() HANDLE
    DEF f=0
    f:=Open('ENVARC:KRSNAke/KRSNAke.snapshot',MODE_NEWFILE)
    IF f=0 THEN Raise("URK")
    VfPrintf(f,'%ld\n%ld\n%ld\n%ld\n%ld\n',[w.leftedge,w.topedge,bw,bh,speed])
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
    IF (f:=Open('ENVARC:KRSNAke/KRSNAke.snapshot',MODE_OLDFILE))
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
        CASE FILLTYPE_RGB
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

PROC pushlink(x,y,l)
    fifoe:=fifoe+1
    fifol:=fifol+1
    IF fifoe>=1024 THEN fifoe:=0
    fifox[fifoe]:=x
    fifoy[fifoe]:=y
    matrix[(y*32)+x]:=l
ENDPROC

PROC poplink()
    DEF x,y,l
    x:=fifox[fifos]
    y:=fifoy[fifos]
    l:=matrix[(y*32)+x]
    fifos:=fifos+1
    fifol:=fifol-1
    IF fifos>=1024 THEN fifos:=0
    matrix[(y*32)+x]:=0
ENDPROC x,y,l

PROC pushkey(key)
    IF (key<$80) AND (key<>keybuf[keybufe])
        keybufe:=keybufe+1
        keybufl:=keybufl+1
        IF keybufe>=256 THEN keybufe:=0
        keybuf[keybufe]:=key
    ENDIF
ENDPROC

PROC popkey()
    DEF key
    IF keybufl<=0 THEN RETURN 0
    key:=keybuf[keybufs]
    keybufs:=keybufs+1
    keybufl:=keybufl-1
    IF keybufs>=256 THEN keybufs:=0
ENDPROC key

PROC renderscore(redraw=TRUE,newscore=FALSE)
    DEF ss[64]:STRING
    IF redraw
        SetAPen(stdrast,dripens[BACKGROUNDPEN])
        IF newscore
            RectFill(stdrast,nsx,3,nsx+nsw-1,2+nsh)
        ELSE
            RectFill(stdrast,1,3,ww-2,th+2)
        ENDIF
    ENDIF
    IF playing THEN lStringF(ss,getstr(ID_INGAMESTATUS),[fifol,chunk])
    IF (playing=0) AND (gameover=0) THEN lStringF(ss,getstr(ID_INITIALSTATUS),[bw,bh])
    IF (playing=0) AND (gameover=1) THEN lStringF(ss,getstr(ID_GAMEOVERSTATUS),[fifol])
    nsw:=TextLength(stdrast,ss,EstrLen(ss))
    SetAPen(stdrast,dripens[TEXTPEN])
    nsx:=(ww-nsw)/2
    nsh:=font.ysize
    Move(stdrast,nsx,3+font.baseline)
    Text(stdrast,ss,EstrLen(ss))
ENDPROC

PROC render()
    DEF rw,rh
    ww:=w.width-w.borderleft-w.borderright
    wh:=w.height-w.bordertop-w.borderbottom
    fw:=ww-8
    fh:=wh-th-14
    fy:=th+10
    bw:=fw/32
    bh:=fh/32
    rw:=bw*32
    rh:=bh*32
    IF (fw-rw) OR (fh-rh) THEN JUMP done

    scaleGraphics()
    SetRast(stdrast,dripens[BACKGROUNDPEN])
    bevelbox(0,0,ww-1,th+5)
    bevelbox(0,fy-4,ww-1,wh-1)
    bevelbox(3,fy-1,ww-4,wh-4,FALSE)
    renderscore(FALSE)
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

PROC newchunk()
    REPEAT
        cx:=Rnd(32)
        cy:=Rnd(32)
    UNTIL matrix[(cy*32)+cx]=0
    chunk:=Rnd(9)+1
    cp:=Rnd(4)
    KsNotifyClients(krs,SNAKE_NEWCHUNK,Shl(chunk,24) OR Shl(cp,16) OR Shl(cy,8) OR cx)
    renderlink(cx,cy,FILL_FRUIT+cp)
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

PROC movesnake()
    DEF alive=1,x,y,key
    key:=popkey()
    IF paused=1
        IF key
            KsNotifyClients(krs,SNAKE_RESTARTED,fifol)
            WaitTOF()
            paused:=0
        ELSE
            RETURN 1
        ENDIF
    ENDIF
    IF playing=0
        IF key=$40
            resetgame()
        ELSE
            RETURN 0
        ENDIF
    ENDIF
    IF (key>0) AND (key<11)
        speed:=key
    ELSE
        SELECT key
            CASE $4C
                IF (sy<>1) OR And(kp.flags,KPF_LETHAL180)
                    sx:=0
                    sy:=-1
                    head:=8
                ENDIF
            CASE $4D
                IF (sy<>-1) OR And(kp.flags,KPF_LETHAL180)
                    sx:=0
                    sy:=1
                    head:=6
                ENDIF
            CASE $4E
                IF (sx<>-1) OR And(kp.flags,KPF_LETHAL180)
                    sx:=1
                    sy:=0
                    head:=5
                ENDIF
            CASE $4F
                IF (sx<>1) OR And(kp.flags,KPF_LETHAL180)
                    sx:=-1
                    sy:=0
                    head:=7
                ENDIF
            CASE $45
                killtask:=TRUE
            CASE $19
                KsNotifyClients(krs,SNAKE_PAUSED,fifol)
                WaitTOF()
                paused:=1
        ENDSELECT
    ENDIF
    hx:=hx+sx
    hy:=hy+sy
    SELECT 4 OF rexxwaitmode
        CASE 1
            IF hx=rexxwait THEN rexxwaitmode:=0
            IF rexxwaitmode=0 THEN rexxwait:=0
            checkRexxCommands()
        CASE 2
            IF hy=rexxwait THEN rexxwaitmode:=0
            IF rexxwaitmode=0 THEN rexxwait:=0
            checkRexxCommands()
        CASE 3
            IF rexxwait>0 THEN DEC rexxwait
            IF rexxwait=0 THEN rexxwaitmode:=0
            checkRexxCommands()
        DEFAULT
            rexxwait:=0
            rexxwaitmode:=0
    ENDSELECT

    IF (hx<0) OR (hx>31) OR (hy<0) OR (hy>31) OR (matrix[(hy*32)+hx]>0) OR (fifol>=1023)
        KsNotifyClients(krs,SNAKE_GAMEOVER,fifol)
        KsPlaySoundObject(crs)
        alive:=0
        playing:=0
        gameover:=1
        keybufs:=1
        keybufe:=0
        keybufl:=0
        rexxwait:=0
        rexxwaitmode:=0
        renderscore()
    ELSE
        KsNotifyClients(krs,SNAKE_MOVES,Shl(head,16) OR Shl(hy,8) OR hx)
        transformhead(fifox[fifoe],fifoy[fifoe],head)
        IF kp.fill[FILL_LINK].type=FILLTYPE_GRAPHIC THEN renderlink(fifox[fifoe],fifoy[fifoe],FILL_BACK)
        renderlink(fifox[fifoe],fifoy[fifoe],FILL_LINK)
        pushlink(hx,hy,head)
        renderlink(hx,hy,FILL_HEAD)
        IF (hx=cx) AND (hy=cy)
            KsNotifyClients(krs,SNAKE_EATEN,chunk)
            KsPlaySoundObject(efs)
            eaten:=eaten+chunk
            newchunk()
        ENDIF
        IF eaten
            eaten:=eaten-1
            KsNotifyClients(krs,SNAKE_NEWSCORE,fifol)
            renderscore(TRUE,TRUE)
        ELSE
            x,y:=poplink()
            renderlink(x,y,FILL_BACK)
            transformtail(fifox[fifos],fifoy[fifos])
            IF kp.fill[FILL_LINK].type=FILLTYPE_GRAPHIC THEN renderlink(fifox[fifos],fifoy[fifos],FILL_BACK)
            renderlink(fifox[fifos],fifoy[fifos],FILL_LINK)
        ENDIF
    ENDIF
ENDPROC alive

PROC resetgame(real=1)
    DEF i
    IF real
        KsNotifyClients(krs,SNAKE_NEWGAME,NIL)
        IF And(kp.flags,KPF_CONTSOUND)=0 THEN KsPlaySoundObject(bgs)
    ENDIF
    FOR i:=0 TO 1023 DO matrix[i]:=0
    playing:=real
    fifos:=0
    fifoe:=1
    fifol:=2
    fifox[0]:=15
    fifoy[0]:=16
    fifox[1]:=15
    fifoy[1]:=15
    matrix[(15*32)+15]:=8
    matrix[(16*32)+15]:=12
    sx:=0
    sy:=-1
    head:=8
    chunk:=0
    eaten:=0
    hx:=15
    hy:=15
    cx:=-1
    cy:=-1
    gameover:=0
    paused:=0
    IF real
        newchunk()
        renderscore()
        rendersnake()
    ENDIF
ENDPROC

PROC waitimessage(win:PTR TO window)
    DEF msg:PTR TO intuimessage,icl=0,ico=0,sigs=0
    DEF jpv

    IF visible
        WaitTOF()

        IF lowlevelbase
            jpv:=ReadJoyPort(1) AND JP_DIRECTION_MASK
            SELECT jpv
                CASE JPF_JOY_UP
                    pushkey($4C)
                CASE JPF_JOY_DOWN
                    pushkey($4D)
                CASE JPF_JOY_RIGHT
                    pushkey($4E)
                CASE JPF_JOY_LEFT
                    pushkey($4F)
            ENDSELECT
        ENDIF

        IF playing=0 THEN paused:=0
        IF counter
            counter:=counter-1
        ELSE
            counter:=speed
            playing:=movesnake()
        ENDIF

        WHILE KsGetNotifyEvent(krs,{icl},{ico})
            SELECT icl
                CASE SNAKE_NEWPREFS
                    killtask:=1
                    newprefs:=1
                    KsNotifyClients(krs,SNAKE_QUIT,NIL)
            ENDSELECT
        ENDWHILE

        WHILE (msg:=GetMsg(win.userport))
            icl:=msg.class
            ico:=msg.code
            ReplyMsg(msg)
            SELECT icl
                CASE IDCMP_CLOSEWINDOW
                    killtask:=TRUE
                CASE IDCMP_REFRESHWINDOW
                    render()
                CASE IDCMP_NEWSIZE
                    verifysize()
                    render()
                CASE IDCMP_INACTIVEWINDOW
                    IF playing
                        KsNotifyClients(krs,SNAKE_PAUSED,fifol)
                        paused:=1
                    ENDIF
                CASE IDCMP_RAWKEY
                    IF ico=$45 THEN killtask:=TRUE
                    pushkey(ico)
            ENDSELECT
        ENDWHILE
        sigs:=SetSignal(0,0)
        IF (sigs AND Shl(1,rexxPort.sigbit)) THEN checkRexxCommands()
        IF (sigs AND Shl(1,brokerPort.sigbit)) THEN checkCxPort()
    ELSE
        sigs:=Wait(Shl(1,appPort.sigbit) OR Shl(1,brokerPort.sigbit) OR Shl(1,rexxPort.sigbit))
        IF (sigs AND Shl(1,rexxPort.sigbit)) THEN checkRexxCommands()
        IF (sigs AND Shl(1,brokerPort.sigbit)) THEN checkCxPort()
        IF (sigs AND Shl(1,appPort.sigbit)) THEN checkAppPort()
    ENDIF
ENDPROC

PROC checkCxPort()
    DEF msg:PTR TO mn,id,type
    WHILE (msg:=GetMsg(brokerPort))
        id:=CxMsgID(msg)
        type:=CxMsgType(msg)
        SELECT type
            CASE CXM_IEVENT
                SELECT id
                    CASE CXID_POPKEY
                        IF visible THEN vanish() ELSE appear()
                ENDSELECT
            CASE CXM_COMMAND
                SELECT id
                    CASE CXCMD_KILL
                        killtask:=1
                    CASE CXCMD_DISAPPEAR
                        IF visible THEN vanish()
                    CASE CXCMD_APPEAR
                        IF visible=0 THEN appear()
                    CASE CXCMD_UNIQUE
                        IF visible=0 THEN appear()
                ENDSELECT
        ENDSELECT
        ReplyMsg(msg)
    ENDWHILE
ENDPROC

PROC checkAppPort()
    DEF msg:PTR TO appmessage
    WHILE (msg:=GetMsg(appPort))
        IF msg.numargs>0
            DisplayBeep(NIL)
        ELSE
            appear()
        ENDIF
        ReplyMsg(msg)
    ENDWHILE
ENDPROC

PROC uffGetMsg(port,uff:PTR TO LONG)
    DEF m,s
    m,s:=rx_GetMsg(port)
    ^uff:=s
ENDPROC m

PROC checkRexxCommands()
    DEF msg,rc,a,b,st[32]:STRING,sr:PTR TO CHAR,
        ps:PTR TO LONG,cs[256]:STRING
    IF rexxwaitmode<>0 THEN RETURN
    WHILE (rexxwaitmode=0) AND (msg:=uffGetMsg(rexxPort,{ps}))
        rc:=0
        sr:=0
        StrCopy(cs,ps)
        UpperStr(cs)
        ps:=argSplit(cs)
        SELECT AREXX_MAX OF getRexxId(ps[0])
            CASE AREXX_UP
                IF playing
                    pushkey($4C)
                    rc:=RC_OK
                ELSE
                    rc:=RC_WARN
                ENDIF
            CASE AREXX_DOWN
                IF playing
                    pushkey($4D)
                    rc:=RC_OK
                ELSE
                    rc:=RC_WARN
                ENDIF
            CASE AREXX_RIGHT
                IF playing
                    pushkey($4E)
                    rc:=RC_OK
                ELSE
                    rc:=RC_WARN
                ENDIF
            CASE AREXX_LEFT
                IF playing
                    pushkey($4F)
                    rc:=RC_OK
                ELSE
                    rc:=RC_WARN
                ENDIF
            CASE AREXX_QUIT
                killtask:=1
                rc:=RC_OK
            CASE AREXX_NEWGAME
                IF playing=0
                    pushkey($40)
                    rc:=RC_OK
                ELSE
                    rc:=RC_WARN
                ENDIF
            CASE AREXX_HIDE
                IF visible
                    vanish()
                    rc:=RC_OK
                ELSE
                    rc:=RC_WARN
                ENDIF
            CASE AREXX_SHOW
                IF visible=0
                    appear()
                    rc:=RC_OK
                ELSE
                    rc:=RC_WARN
                ENDIF
            CASE AREXX_WAIT
                IF playing
                    IF StrCmp(ps[1],'UNTIL')
                        IF StrCmp(ps[2],'X')
                            rexxwaitmode:=1
                            rexxwait:=Val(ps[3])
                            rc:=RC_OK
                        ELSEIF StrCmp(ps[2],'Y')
                            rexxwaitmode:=2
                            rexxwait:=Val(ps[3])
                            rc:=RC_OK
                        ENDIF
                    ELSEIF StrCmp(ps[1],'FOR')
                        rexxwaitmode:=3
                        rexxwait:=Val(ps[2])
                        rc:=RC_OK
                    ELSE
                        rc:=RC_ERROR
                    ENDIF
                ELSE
                    rc:=RC_WARN
                ENDIF
            CASE AREXX_SET
                IF StrCmp(ps[1],'SPEED')
                    speed:=Val(ps[2])
                    rc:=RC_OK
                ELSE
                    rc:=RC_ERROR
                ENDIF
            CASE AREXX_GET
                IF StrCmp(ps[1],'FRUIT')
                    IF StrCmp(ps[2],'X')
                        StringF(st,'\d',cx)
                        sr:=st
                        rc:=RC_OK
                    ELSEIF StrCmp(ps[2],'Y')
                        StringF(st,'\d',cy)
                        sr:=st
                        rc:=RC_OK
                    ELSE
                        rc:=RC_ERROR
                    ENDIF
                ELSEIF StrCmp(ps[1],'HEAD')
                    IF StrCmp(ps[2],'X')
                        StringF(st,'\d',hx)
                        sr:=st
                        rc:=RC_OK
                    ELSEIF StrCmp(ps[2],'Y')
                        StringF(st,'\d',hy)
                        sr:=st
                        rc:=RC_OK
                    ELSE
                        rc:=RC_ERROR
                    ENDIF
                ELSEIF StrCmp(ps[1],'LENGTH')
                    IF playing
                        StringF(st,'\d',fifol)
                        sr:=st
                        rc:=RC_OK
                    ELSE
                        rc:=RC_WARN
                    ENDIF
                ELSEIF StrCmp(ps[1],'PLAYING')
                    StringF(st,'\d',playing)
                    sr:=st
                    rc:=RC_OK
                ELSE
                    rc:=RC_ERROR
                ENDIF
            CASE AREXX_PAUSE
                IF playing
                    KsNotifyClients(krs,SNAKE_PAUSED,fifol)
                    paused:=1
                    rc:=RC_OK
                ELSE
                    rc:=RC_WARN
                ENDIF
            CASE AREXX_CHECK
                IF playing
                    b:=Val(ps[1])
                    a:=Val(ps[2])
                    StringF(st,'\d',matrix[Shl(a,5)+b])
                    sr:=st
                    rc:=RC_OK
                ELSE
                    rc:=RC_WARN
                ENDIF
            DEFAULT
                rc:=RC_ERROR
        ENDSELECT
        rx_ReplyMsg(msg,rc,sr)
        DisposeLink(ps)
    ENDWHILE
ENDPROC

PROC openKRSNAkeLib()
    DEF base=0:PTR TO lib
    base:=OpenLibrary('krsnake.library',1)
    IF base=0 THEN OpenLibrary('Libs/krsnake.library',1)
    IF base=0 THEN OpenLibrary('PROGDIR:Libs/krsnake.library',1)
    IF base
        IF base.revision<6
            CloseLibrary(base)
            Throw("LIB",getstr(ERRORID_OLDKRSNAKELIB))
        ENDIF
    ENDIF
ENDPROC base

PROC createBroker()
    brokerPort:=CreateMsgPort()
    broker:=CxBroker([NB_VERSION,0,
                      'KRSNAke',KRSNAKEVER,
                      getstr(ID_BROKERINFO),
                      NBU_UNIQUE,COF_SHOW_HIDE,0,0,
                      brokerPort,0]:newbroker,NIL)
    AttachCxObj(broker,hotKey(kp.popkey,brokerPort,CXID_POPKEY))
    ActivateCxObj(broker,TRUE)
ENDPROC broker

PROC initrexx()
    rexxPort:=rx_OpenPort('KRSNAKE')
    NEW rexxhash.hashtable(HASH_NORMAL)
    addRexxCommand('CHECK',AREXX_CHECK)
    addRexxCommand('DOWN',AREXX_DOWN)
    addRexxCommand('GET',AREXX_GET)
    addRexxCommand('HIDE',AREXX_HIDE)
    addRexxCommand('LEFT',AREXX_LEFT)
    addRexxCommand('NEWGAME',AREXX_NEWGAME)
    addRexxCommand('PAUSE',AREXX_PAUSE)
    addRexxCommand('QUIT',AREXX_QUIT)
    addRexxCommand('RIGHT',AREXX_RIGHT)
    addRexxCommand('SET',AREXX_SET)
    addRexxCommand('SHOW',AREXX_SHOW)
    addRexxCommand('UP',AREXX_UP)
    addRexxCommand('WAIT',AREXX_WAIT)
ENDPROC

PROC endrexx()
    IF rexxPort THEN rx_ClosePort(rexxPort)
    END rexxhash
ENDPROC

PROC addRexxCommand(cmd:PTR TO CHAR,id)
    DEF hl:PTR TO rexxcommand,hv
    hl,hv:=rexxhash.find(cmd,StrLen(cmd))
    IF hl THEN RETURN FALSE
    NEW hl
    hl.id:=id
    rexxhash.add(hl,hv,cmd,StrLen(cmd))
ENDPROC

PROC getRexxId(cmd:PTR TO CHAR)
    DEF hl:PTR TO rexxcommand
    hl:=rexxhash.find(cmd,StrLen(cmd))
    IF hl=0 THEN RETURN 0
    RETURN hl.id
ENDPROC

PROC appear()
    IF visible=0
        IF appicon THEN RemoveAppIcon(appicon)
        IF appmenu THEN RemoveAppMenuItem(appmenu)
        appicon:=0;appmenu:=0
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
        IF wantobtainpens THEN obtainpens()
        IF And(kp.flags,KPF_FREESOUNDS) THEN readsounds()
        w:=OpenWindowTagList(NIL,[WA_INNERWIDTH,ww,WA_INNERHEIGHT,wh,
                                  WA_LEFT,wx,WA_TOP,wy,
                                  WA_TITLE,'KRSNAke v1.17',
                                  WA_SIZEGADGET,TRUE,
                                  WA_DRAGBAR,TRUE,
                                  WA_DEPTHGADGET,TRUE,
                                  WA_CLOSEGADGET,TRUE,
                                  WA_ACTIVATE,TRUE,
                                  WA_SMARTREFRESH,TRUE,
                                  WA_SIZEBBOTTOM,TRUE,
                                  WA_GIMMEZEROZERO,TRUE,
                                  WA_NEWLOOKMENUS,TRUE,
                                  WA_SCREENTITLE,'KRSNAke v1.17 - IGNE NATURA RENOVATUR INTEGRA!',
                                  WA_AUTOADJUST,TRUE,
                                  WA_PUBSCREEN,s,
                                  WA_RMBTRAP,TRUE,
                                  WA_IDCMP,IDCMP_CLOSEWINDOW OR IDCMP_REFRESHWINDOW OR IDCMP_INACTIVEWINDOW OR IDCMP_NEWSIZE OR IDCMP_RAWKEY,
                                  NIL])
        WindowLimits(w,w.borderleft+w.borderright+136,w.bordertop+w.borderbottom+th+142,-1,-1)
        SetStdRast(w.rport)
        SetFont(stdrast,font)
        render()
        visible:=1
        IF krs THEN KsShowInterface(krs)
        IF And(kp.flags,KPF_CONTSOUND) THEN IF And(kp.flags,KPF_FREESOUNDS) THEN KsPlaySoundObject(bgs)
    ENDIF
ENDPROC

PROC vanish(forever=FALSE)
    IF visible
        IF w THEN CloseWindow(w)
        IF And(kp.flags,KPF_FREESOUNDS) THEN freesounds()
        IF pensobtained THEN freepens()
        IF dri THEN FreeScreenDrawInfo(s,dri)
        IF font THEN CloseFont(font)
        IF s THEN UnlockPubScreen(NIL,s)
        IF playing=1 THEN paused:=1
        IF krs THEN KsHideInterface(krs)
        w:=0;pensobtained:=0;dri:=0;font:=0;s:=0;visible:=0
        IF forever=0
            IF And(kp.flags,KPF_APPICON) THEN appicon:=AddAppIconA(APPID_ICON,0,'KRSNAke',appPort,NIL,myicon,NIL)
            IF And(kp.flags,KPF_APPMENU) THEN appmenu:=AddAppMenuItemA(APPID_MENU,0,'KRSNAke',appPort,NIL)
        ENDIF
    ENDIF
ENDPROC

PROC main() HANDLE
->    trapguru()
    randomise()
    IF (krsnakebase:=openKRSNAkeLib())=0 THEN Throw("LIB",'krsnake.library')
    IF (utilitybase:=OpenLibrary('utility.library',37))=0 THEN Throw("LIB",'utility.library')
    IF (cxbase:=OpenLibrary('commodities.library',37))=0 THEN Throw("LIB",'commodities.library')
    IF (iconbase:=OpenLibrary('icon.library',37))=0 THEN Throw("LIB",'icon.library')
    IF (workbenchbase:=OpenLibrary('workbench.library',37))=0 THEN Throw("LIB",'workbench.library')
    datatypesbase:=OpenLibrary('datatypes.library',39)
    localebase:=OpenLibrary('locale.library',37)
    openCatalog()
    IF (lowlevelbase:=OpenLibrary('lowlevel.library',40)) THEN SetJoyPortAttrsA(1,[SJA_TYPE,SJA_TYPE_JOYSTK,NIL])
    myicon:=GetDiskObjectNew('PROGDIR:KRSNAke')
    krs:=KsRegisterServer()
    launchclients()
    readsettings()
    resetgame(0)
    SetTaskPri(FindTask(NIL),kp.priority)
    IF And(kp.flags,KPF_FREESOUNDS)=0 THEN readsounds()
    appPort:=CreateMsgPort()
    createBroker()
    initrexx()
    appear()
    IF And(kp.flags,KPF_CONTSOUND) THEN IF And(kp.flags,KPF_FREESOUNDS)=0 THEN KsPlaySoundObject(bgs)

    checkStubing()

    REPEAT
        waitimessage(w)
    UNTIL killtask

    dumpsettings()

EXCEPT DO
    vanish(TRUE)
    closeCatalog()
    IF krs THEN KsRemoveServer(krs)
    IF rexxPort THEN endrexx()
    IF broker THEN DeleteCxObj(broker)
    IF brokerPort THEN deletePortSafely(brokerPort)
    IF appicon THEN RemoveAppIcon(appicon)
    IF appmenu THEN RemoveAppMenuItem(appmenu)
    IF appPort THEN deletePortSafely(appPort)
    IF myicon THEN FreeDiskObject(myicon)
    IF kp THEN FreeVec(kp)
    freesounds()
    IF krsnakebase THEN CloseLibrary(krsnakebase)
    IF localebase THEN CloseLibrary(localebase)
    IF utilitybase THEN CloseLibrary(utilitybase)
    IF iconbase THEN CloseLibrary(iconbase)
    IF workbenchbase THEN CloseLibrary(workbenchbase)
    IF cxbase THEN CloseLibrary(cxbase)
    IF lowlevelbase THEN CloseLibrary(lowlevelbase)
    IF datatypesbase THEN CloseLibrary(datatypesbase)
    IF exception>0 THEN report_exception() ELSE IF newprefs THEN RETURN reLaunch()
ENDPROC

PROC report_exception()
  DEF e[5]:ARRAY,s[256]:STRING,t[256]:STRING
  IF exception
    StrCopy(s,getstr(ERRORID_EXCEPTION))
    IF exception<10000
      StringF(t,' \d\n',exception)
      StrAdd(s,t)
    ELSE
      SELECT exception
        CASE  "MEM"; StrCopy(t,getstr(ERRORID_MEM))
        CASE "OPEN"; lStringF(t,getstr(ERRORID_OPEN),[IF exceptioninfo THEN exceptioninfo ELSE ''])
        CASE "LOCK"; lStringF(t,getstr(ERRORID_LOCK),[IF exceptioninfo THEN exceptioninfo ELSE ''])
        CASE  "WIN"; lStringF(t,getstr(ERRORID_WIN),[IF exceptioninfo THEN exceptioninfo ELSE ''])
        CASE  "LIB"; lStringF(t,getstr(ERRORID_LIB),[IF exceptioninfo THEN exceptioninfo ELSE ''])
        CASE  "SCR"; lStringF(t,getstr(ERRORID_SCR),[IF exceptioninfo THEN exceptioninfo ELSE ''])
        CASE   "^C"; StrCopy(t,getstr(ERRORID_BREAK))
        CASE "DOUB"; StrCopy(t,getstr(ERRORID_DOUB))
        CASE  "SIG"; StrCopy(t,getstr(ERRORID_SIG))
        CASE "CXBR"; StrCopy(t,getstr(ERRORID_CXBR))
        DEFAULT
          e[4]:=0
          ^e:=exception
          WHILE e[]=0 DO e++
          StringF(t,IF exceptioninfo<1000 THEN '"\s" [\d]' ELSE '"\s" [\s]',e,exceptioninfo)
      ENDSELECT
      StrAdd(s,t)
    ENDIF
    EasyRequestArgs(NIL,[SIZEOF easystruct,0,getstr(ID_EXCEPTION),s,getstr(ABOUTID_OK)],NIL,NIL)
  ENDIF
ENDPROC

PROC reLaunch()
    DEF p[1024]:ARRAY OF CHAR,n[256]:ARRAY OF CHAR
    NameFromLock(GetProgramDir(),p,1024)
    IF GetProgramName(n,256)=0 THEN StrCopy(n,'KRSNAke')
    AddPart(p,n,1024)
    RETURN launchClient(p)
ENDPROC

PROC checkStubing()
    DEF cd:PTR TO clockdata,secs:LONG,micros:LONG
    NEW cd
    CurrentTime({secs},{micros})
    Amiga2Date(secs,cd)
    IF (cd.mday=28) AND (cd.month=2) THEN EasyRequestArgs(NIL,[SIZEOF easystruct,0,'Halelujah!','Today, Gavin MacLeod is %ld years old!\n\nHappy Birthday, Captain Stubing!','Rejoice!'],NIL,[cd.year-1930])
    IF (cd.mday=8) AND (cd.month=1) THEN EasyRequestArgs(NIL,[SIZEOF easystruct,0,'Elvis be praised!','Today the King is %ld years old!\nEnter your congratulation in alt.elvis.king now!','You ain''t nuthin'' but a hound dog!'],NIL,[cd.year-1935])
    IF (cd.mday=13) AND (cd.month=10) THEN EasyRequestArgs(NIL,[SIZEOF easystruct,0,'Fnord!','On this very day, %ld years ago,\nJacques de Molay was arrested!','Good riddance!'],NIL,[cd.year-1307])
    END cd
ENDPROC

krsnakever: CHAR '$VER: KRSNAke 1.017 (22 Feb 1996)',0



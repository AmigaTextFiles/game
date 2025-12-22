->
-> KRSNAke.library by Crassus
->
-> This library contains the client/server code for KRSNAke
->
-> $HISTORY:
->
-> 24 Oct 1995 : 001.011 :  Notification events for main program handled
-> 10 Oct 1995 : 001.010 :  Now supports playsid.library
-> 02 Oct 1995 : 001.009 :  Uses ptreplay.library instead of tools/pt.m
-> 02 Oct 1995 : 001.008 :  Default colour values from dripens
-> 22 Sep 1995 : 001.007 :  Supports client show/hide
-> 16 Sep 1995 : 001.006 :  Sound player added to library
-> 15 Sep 1995 : 001.005 :  Provides default setup if no setup file is found
-> 10 Sep 1995 : 001.004 :  Added krsnakeprefs read/write functions
-> 06 Sep 1995 : 001.003 :  More secure server removal
-> 21 Aug 1995 : 001.002 :  Stable release
-> 31 Jul 1995 : 001.001 :  Initial release
->

OPT PREPROCESS

LIBRARY 'krsnake.library',1,10,'$VER: krsnake.library 1.011 (24 Oct 1995)' IS
        ksRegisterServer,ksRemoveServer,ksRegisterClient,ksRemoveClient,
        ksNotifyClients,ksWaitForEvent,ksReadEvent,ksGetClientSig,
        ksReadKRSNAkePrefs,ksWriteKRSNAkePrefs,ksReadSoundObject,
        ksPlaySoundObject,ksDeleteSoundObject,ksShowInterface,ksHideInterface,
        ksNotifyServer,ksGetNotifySig,ksGetNotifyEvent

MODULE 'exec/tasks','exec/lists','exec/nodes','exec/semaphores','exec/memory',
       'exec/ports','tools/constructors','dos/dosextens','libraries/krsnake',
       '*createpath','dos/dos','datatypes','datatypes/datatypes','tools/ports',
       'datatypes/datatypesclass','datatypes/soundclass','ptreplay',
       'libraries/player61','player61','medplayer','intuition/screens',
       'graphics/view','playsid','libraries/playsidbase','exec/execbase'

#define KRSNAME 'KRSNAke Server'

#define findSem FindSemaphore(KRSNAME)

RAISE "MEM"  IF AllocPooled()=0,
      "MEM"  IF CreatePool()=0,
      "MEM"  IF AllocMem()=0,
      "MEM"  IF CreateMsgPort()=0

OBJECT krso
    type:LONG
    dtlib:LONG
    p61lib:LONG
    medlib:LONG
    ptlib:LONG
    psidlib:LONG
    obj:LONG
    size:LONG
    state:LONG
ENDOBJECT

ENUM STYPE_DATATYPE=1,STYPE_MED,STYPE_TRACKER,STYPE_PLAYER61,STYPE_PLAYSID,STYPE_MAX

OBJECT krss OF ss
    pool:LONG
    server:PTR TO tc
    clist:PTR TO mlh
    ccount:LONG
    visible:LONG
    np:PTR TO mp
ENDOBJECT

OBJECT krc OF ln
    port:PTR TO mp
ENDOBJECT

OBJECT krm OF mn
    pool:LONG
    event:LONG
    score:LONG
ENDOBJECT

PROC ksRegisterServer() HANDLE
    DEF s=0:PTR TO krss
    Forbid()
    IF findSem=0
        s:=AllocMem(SIZEOF krss,MEMF_PUBLIC OR MEMF_CLEAR)
        s.ln.name:=KRSNAME
        s.ln.pri:=0
        s.server:=FindTask(NIL)
        s.pool:=CreatePool(MEMF_PUBLIC OR MEMF_CLEAR,4096,2048)
        s.np:=CreateMsgPort()
        s.clist:=AllocPooled(s.pool,SIZEOF lh)
        newlist(s.clist)
        AddSemaphore(s)
    ENDIF
    Permit()
    RETURN s
EXCEPT
    Permit()
ENDPROC 0

PROC ksRemoveServer(s:PTR TO krss)
    DEF ct=0
    IF s
fnord:
        REPEAT
            ksNotifyClients(s,SNAKE_QUIT,0)
            WaitTOF()
            ObtainSemaphoreShared(s)
            ct:=s.ccount
            ReleaseSemaphore(s)
        UNTIL ct=0
        ObtainSemaphore(s)
        IF s.ccount>0
            ReleaseSemaphore(s)
            JUMP fnord
        ENDIF
        RemSemaphore(s)
        DeletePool(s.pool)
        deletePortSafely(s.np)
        FreeMem(s,SIZEOF krss)
    ELSE
        RETURN 0
    ENDIF
ENDPROC

PROC ksNotifyServer(event,data)
    DEF s:PTR TO krss,m=0:PTR TO krm
    IF s:=findSem
        m:=AllocPooled(s.pool,SIZEOF krm)
        m.length:=SIZEOF krm
        m.pool:=s.pool
        m.event:=event
        m.score:=data
        PutMsg(s.np,m)
        RETURN 1
    ENDIF
ENDPROC 0

PROC ksGetNotifyEvent(s:PTR TO krss,event:PTR TO LONG,data:PTR TO LONG)
    DEF m:PTR TO krm
    IF m:=GetMsg(s.np)
        ^event:=m.event
        ^data:=m.score
        FreePooled(m.pool,m,m.length)
        RETURN 1
    ELSE
        RETURN 0
    ENDIF
ENDPROC

PROC ksRegisterClient() HANDLE
    DEF c:PTR TO krc,s:PTR TO krss
    IF s:=findSem
        c:=AllocPooled(s.pool,SIZEOF krc)
        c.port:=CreateMsgPort()
        IF c=0 THEN Raise("MEM")
        ObtainSemaphore(s)
        AddTail(s.clist,c)
        s.ccount:=s.ccount+1
        ReleaseSemaphore(s)
        IF s.visible THEN ksSendClientMessage(s,c,SNAKE_SHOWINTERFACE,0) ELSE ksSendClientMessage(s,c,SNAKE_HIDEINTERFACE,0)
        RETURN c
    ENDIF
EXCEPT DO
    RETURN 0
ENDPROC

PROC ksRemoveClient(c:PTR TO krc)
    DEF s:PTR TO krss
    IF c=0 THEN RETURN 0
    IF s:=findSem
        ObtainSemaphore(s)
        Remove(c)
        s.ccount:=s.ccount-1
        clearMsgPort(c.port)
        DeleteMsgPort(c.port)
        FreePooled(s.pool,c,SIZEOF krc)
        ReleaseSemaphore(s)
    ELSE
        RETURN 0
    ENDIF
ENDPROC 1

PROC clearMsgPort(port:PTR TO mp)
    DEF m:PTR TO krm
    WHILE m:=GetMsg(port) DO FreePooled(m.pool,m,m.length)
ENDPROC

PROC ksGetNotifySig(s:PTR TO krss) IS s.np.sigbit

PROC ksGetClientSig(c:PTR TO krc) IS c.port.sigbit

PROC ksNotifyClients(s:PTR TO krss,event,score) HANDLE
    DEF i=0:PTR TO krc
    IF s=0 THEN RETURN 0
    i:=s.clist.head
    WHILE i.succ
        ksSendClientMessage(s,i,event,score)
        i:=i.succ
    ENDWHILE
EXCEPT
    RETURN 0
ENDPROC 1

PROC ksSendClientMessage(s:PTR TO krss,c:PTR TO krc,event,score)
    DEF m=0:PTR TO krm
    m:=AllocPooled(s.pool,SIZEOF krm)
    m.length:=SIZEOF krm
    m.pool:=s.pool
    m.event:=event
    m.score:=score
    PutMsg(c.port,m)
ENDPROC

PROC ksWaitForEvent(c:PTR TO krc)
    IF c=0 THEN RETURN 0
    WaitPort(c.port)
ENDPROC 1

PROC ksReadEvent(c:PTR TO krc,event:PTR TO LONG,score:PTR TO LONG)
    DEF m=0:PTR TO krm
    IF c=0 THEN RETURN 0
    IF m:=GetMsg(c.port)
        ^event:=m.event
        ^score:=m.score
        FreePooled(m.pool,m,m.length)
        RETURN 1
    ELSE
        RETURN 0
    ENDIF
ENDPROC

PROC ksReadKRSNAkePrefs()
    DEF f=0,p:PTR TO kprefs,s:PTR TO screen,dri:PTR TO drawinfo

    IF (p:=AllocVec(SIZEOF kprefs,MEMF_CLEAR))=0 THEN RETURN 0

    IF (f:=Open('ENVARC:KRSNAke/KRSNAke.prefs',MODE_OLDFILE))
        Read(f,p,SIZEOF kprefs)
        Close(f)
    ELSE
        IF s:=LockPubScreen(NIL)
            IF dri:=GetScreenDrawInfo(s)
                setDriPen(s,p,0,dri.pens[BACKGROUNDPEN])
                setDriPen(s,p,1,dri.pens[BACKGROUNDPEN])
                setDriPen(s,p,2,dri.pens[FILLPEN])
                setDriPen(s,p,3,dri.pens[FILLPEN])
                setDriPen(s,p,4,dri.pens[FILLPEN])
                setDriPen(s,p,5,dri.pens[FILLPEN])
                setDriPen(s,p,6,dri.pens[FILLPEN])
                FreeScreenDrawInfo(s,dri)
            ENDIF
            UnlockPubScreen(NIL,s)
        ELSE
            p.fill[0].type:=FILLTYPE_RGB;p.fill[0].red:=53;p.fill[0].green:=136;p.fill[0].blue:=85
            p.fill[1].type:=FILLTYPE_RGB;p.fill[1].red:=136;p.fill[1].green:=92;p.fill[1].blue:=145
            p.fill[2].type:=FILLTYPE_RGB;p.fill[2].red:=255;p.fill[2].green:=167;p.fill[2].blue:=255
            p.fill[3].type:=FILLTYPE_RGB;p.fill[3].red:=232;p.fill[3].green:=213;p.fill[3].blue:=132
            p.fill[4].type:=FILLTYPE_RGB;p.fill[4].red:=127;p.fill[4].green:=174;p.fill[4].blue:=127
            p.fill[5].type:=FILLTYPE_RGB;p.fill[5].red:=231;p.fill[5].green:=137;p.fill[5].blue:=163
            p.fill[6].type:=FILLTYPE_RGB;p.fill[6].red:=145;p.fill[6].green:=151;p.fill[6].blue:=217
        ENDIF
        p.flags:=KPF_LETHAL180
    ENDIF
ENDPROC p

PROC setDriPen(s:PTR TO screen,p:PTR TO kprefs,n,pen)
    DEF d[12]:ARRAY OF CHAR
    GetRGB32(s.viewport.colormap,pen,1,d)
    p.fill[n].type:=FILLTYPE_RGB
    p.fill[n].red:=d[0]
    p.fill[n].green:=d[4]
    p.fill[n].blue:=d[8]
ENDPROC

PROC ksWriteKRSNAkePrefs(p:PTR TO kprefs) HANDLE
    DEF f

    createPath('ENVARC:KRSNAke/KRSNAke.prefs')
    IF (f:=Open('ENVARC:KRSNAke/KRSNAke.prefs',MODE_NEWFILE))=0 THEN RETURN 0
    IF (SIZEOF kprefs)<>Write(f,p,SIZEOF kprefs)
        Close(f)
        DeleteFile('ENVARC:KRSNAke/KRSNAke.prefs')
        RETURN 0
    ENDIF
    Close(f)
    FreeVec(p)
EXCEPT
    RETURN 0
ENDPROC 1

PROC ksReadSoundObject(name) HANDLE
    DEF f=0,tb=0,o=0:PTR TO krso,r,a,b

    f:=Open(name,MODE_OLDFILE)
    IF f=0 THEN Raise(1)
    tb:=AllocMem(1084,MEMF_PUBLIC OR MEMF_CLEAR)
    r:=Read(f,tb,1084)
    Close(f);f:=0
    o:=AllocMem(SIZEOF krso,MEMF_CLEAR OR MEMF_PUBLIC)
    IF (r=1084) AND (Long(tb+1080)="M.K.") THEN o.type:=STYPE_TRACKER
    IF (r>64) AND ((Int(tb)="MM") AND (Char(tb+2)="D")) THEN o.type:=STYPE_MED
    IF (r>64) AND ((Long(tb)="P61A") OR (Long(tb)="P60A")) THEN o.type:=STYPE_PLAYER61
    IF (r>64) AND (Long(tb)="PSID") THEN o.type:=STYPE_PLAYSID
    SELECT STYPE_MAX OF o.type
        CASE STYPE_TRACKER
            o.ptlib:=OpenLibrary('ptreplay.library',5)
            IF o.ptlib=0 THEN Raise(1)
            ptreplaybase:=o.ptlib
            o.obj:=PtLoadModule(name)
            IF o.obj=0 THEN Raise(1)
        CASE STYPE_MED
            o.medlib:=OpenLibrary('medplayer.library',2)
            IF o.medlib=0 THEN Raise(1)
            medplayerbase:=o.medlib
            o.obj:=LoadModule(name)
            IF o.obj=0 THEN Raise(1)
        CASE STYPE_PLAYER61
            o.obj:=readFile(name)
            o.p61lib:=OpenLibrary('player61.library',1)
            IF o.p61lib=0 THEN Raise(1)
        CASE STYPE_PLAYSID
            a,b:=readFile(name)
            o.obj:=a
            o.size:=b
            o.psidlib:=OpenLibrary('playsid.library',1)
            IF o.psidlib=0 THEN Raise(1)
            playsidbase:=o.psidlib
            IF AllocEmulResource()
                CloseLibrary(o.psidlib)
                Raise(1)
            ENDIF
            MOVE.L  4,A0
            MOVEQ   #0,D0
            MOVE.B  $213(A0),D0
            MOVE.L  D0,a
            SetVertFreq(a)
            SetModule(o.obj,o.obj,o.size)
        DEFAULT
            o.type:=STYPE_DATATYPE
            o.dtlib:=OpenLibrary('datatypes.library',39)
            IF o.dtlib=0 THEN Raise(1)
            datatypesbase:=o.dtlib
            o.obj:=NewDTObjectA(name,[DTA_GROUPID,GID_SOUND,NIL])
            IF o.obj=0 THEN Raise(1)
    ENDSELECT
EXCEPT
    IF tb THEN FreeMem(tb,1084)
    IF f THEN Close(f)
    IF o THEN ksDeleteSoundObject(o)
    RETURN 0
ENDPROC o

PROC ksPlaySoundObject(o:PTR TO krso)
    IF o
        SELECT STYPE_MAX OF o.type
            CASE STYPE_TRACKER
                ptreplaybase:=o.ptlib
                IF o.state THEN PtStop(o.obj)
                PtPlay(o.obj)
                BSET #1,$BFE001
                o.state:=TRUE
            CASE STYPE_PLAYER61
                player61base:=o.p61lib
                IF o.state THEN Pl61_Stop()
                IF Pl61_Play(o.obj,NIL,NIL) THEN o.state:=FALSE ELSE o.state:=TRUE
            CASE STYPE_MED
                medplayerbase:=o.medlib
                IF o.state THEN StopPlayer()
                IF o.state=FALSE THEN GetPlayer(0)
                PlayModule(o.obj)
                o.state:=TRUE
            CASE STYPE_PLAYSID
                playsidbase:=o.psidlib
                IF o.state
                    StopSong()
                ENDIF
                o.state:=Not(StartSong(o.obj::sidheader.defsong))
                BSET #1,$BFE001
            CASE STYPE_DATATYPE
                datatypesbase:=o.dtlib
                DoDTMethodA(o.obj,NIL,NIL,[DTM_TRIGGER,NIL,STM_PLAY,NIL])
                o.state:=TRUE
        ENDSELECT
    ENDIF
ENDPROC

PROC ksDeleteSoundObject(o:PTR TO krso)
    IF o
        IF o.state AND o.obj
            SELECT STYPE_MAX OF o.type
                CASE STYPE_TRACKER
                    ptreplaybase:=o.ptlib
                    PtStop(o.obj)
                CASE STYPE_MED
                    medplayerbase:=o.medlib
                    StopPlayer()
                    FreePlayer()
                CASE STYPE_PLAYER61
                    player61base:=o.p61lib
                    Pl61_Stop()
                CASE STYPE_PLAYSID
                    playsidbase:=o.psidlib
                    StopSong()
            ENDSELECT
        ENDIF
        IF o.obj
            SELECT STYPE_MAX OF o.type
                CASE STYPE_TRACKER
                    ptreplaybase:=o.ptlib
                    PtUnloadModule(o.obj)
                CASE STYPE_MED
                    medplayerbase:=o.medlib
                    UnLoadModule(o.obj)
                CASE STYPE_DATATYPE
                    datatypesbase:=o.dtlib
                    DisposeDTObject(o.obj)
                CASE STYPE_PLAYSID
                    playsidbase:=o.psidlib
                    FreeEmulResource()
                    FreeVec(o.obj)
                DEFAULT
                    FreeVec(o.obj)
            ENDSELECT
        ENDIF
        IF o.dtlib THEN CloseLibrary(o.dtlib)
        IF o.p61lib THEN CloseLibrary(o.p61lib)
        IF o.medlib THEN CloseLibrary(o.medlib)
        IF o.ptlib THEN CloseLibrary(o.ptlib)
        IF o.psidlib THEN CloseLibrary(o.psidlib)
        FreeMem(o,SIZEOF krso)
    ENDIF
ENDPROC

PROC readFile(name)
    DEF f=0,p=0,fib=0:PTR TO fileinfoblock,s=0,l=0
    IF (fib:=AllocDosObject(DOS_FIB,NIL))
        IF (f:=Open(name,MODE_OLDFILE))
            IF ExamineFH(f,fib)
                IF (p:=AllocVec(fib.size+4,MEMF_CLEAR OR MEMF_CHIP))
                    IF Read(f,p,fib.size)=fib.size THEN s:=1
                    l:=fib.size
                ENDIF
                IF s=0 THEN FreeVec(p)
            ENDIF
            Close(f)
        ENDIF
        FreeDosObject(DOS_FIB,fib)
    ENDIF
    IF s=0 THEN Raise(1)
ENDPROC p,l

PROC ksShowInterface(s:PTR TO krss)
    s.visible:=1
    ksNotifyClients(s,SNAKE_SHOWINTERFACE,0)
ENDPROC

PROC ksHideInterface(s:PTR TO krss)
    s.visible:=0
    ksNotifyClients(s,SNAKE_HIDEINTERFACE,0)
ENDPROC

PROC main()
ENDPROC


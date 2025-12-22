
/* Edit CEL v 1.50 */

/*
    No copyright is claimed for *any* material within.
  This source is *currently* Public Domain, and therefore open to free exploitation. */

/* Use at your own risk, and watch for hairy palms. */


/*  November 9, 1994
                                             Chad Randall 
                                                        - mbissaymssiK Software, broken spork division
                        Internet:  crandall@garnet.msen.com
                            USNail:  229 S.Washington St.
                                             Manchester, Michigan, 48158-9680 USA */

/* This sucker's not been tested but on my machine.  So let me know about any probs, 'kay? */

OPT LARGE
OPT PREPROCESS

MODULE  'graphics/rastport','graphics/gfx','graphics/text','graphics/scale','graphics/view',
                'graphics/gfxbase','graphics/clip','graphics/layers','graphics/displayinfo'
MODULE  'layers'
MODULE  'utility','mathffp','datatypes','iffparse'
MODULE  'intuition/intuition','intuition/screens','intuition/gadgetclass','intuition/screens',
                'intuition/pointerclass'
MODULE  'libraries/gadtools','gadtools'
MODULE  'doloaddt','libraries/doloaddt'
MODULE  'dos/dos'
MODULE  'libraries/asl','asl'
MODULE  'tools/async'
MODULE  'wb','workbench/workbench','workbench/startup'
MODULE  'icon'
MODULE  'exec/memory'

MODULE  '*i3_subs'
MODULE  '*i3_procs'
MODULE  'mod/filenames'
MODULE  'mod/compare'
MODULE  'mod/menus'

#define ibmconv(var) (Shl((var AND $00FF),8) OR Shr((var AND $FF00),8))

ENUM OLD_,NEW_
ENUM    DRAG_TOP,DRAG_PAUSE,DRAG_DIRTY,DRAG_BUFFER,DRAG_SMART

OBJECT color
    red:LONG
    grn:LONG
    blu:LONG
ENDOBJECT

OBJECT palet
    color[260]:ARRAY OF color
ENDOBJECT


DEF filename[500]:STRING
DEF paletname[500]:STRING
DEF dtname[500]:STRING
DEF ppmname[500]:STRING

DEF vp:PTR TO viewport,cm,depth,scrw,scrh,menu,vis
DEF rp:PTR TO rastport,winw,winh

DEF textfont,textattr,textstyle=0

DEF quit=FALSE,newproj=FALSE
DEF mode=0
DEF config_size_x,config_size_y

DEF disp:PTR TO rastport
DEF scr:PTR TO screen
DEF win:PTR TO window,outwin:PTR TO window
DEF fixxed=FALSE,rtdrag=4,waittof=TRUE,hand=FALSE,bound=TRUE
DEF string[500]:STRING
DEF iconbmap=0:PTR TO bitmap,iconwidth,iconheight,oldx,oldy
DEF copybmap=0:PTR TO bitmap,copyrast:PTR TO rastport
DEF backbmap=0:PTR TO bitmap,backrast:PTR TO rastport
DEF maskbmap=0:PTR TO bitmap
DEF blankbmap=0:PTR TO bitmap,maximumw=1,maximumh=1
DEF palet=0:PTR TO palet
DEF hand1=0,hand2=0,hand3=0
DEF curobj=0,offx,offy,dragmode=0
DEF filereq=0:PTR TO filerequester
DEF paletreq=0:PTR TO filerequester
DEF dtreq=0:PTR TO filerequester
DEF ppmreq=0:PTR TO filerequester
ENUM OFF=FALSE,ON=TRUE
DEF outputmode=0
DEF pauseflag=FALSE
DEF iinfo:PTR TO imageinfo
DEF goodload,xsize,ysize,nxsize,nysize,xoff,yoff
DEF tbmp:PTR TO bitmap

CONST FILE_MARK_CELL=$20,FILE_MARK_PALET=$10


RAISE "CHIP" IF AllocBitMap()=FALSE
RAISE "MEM" IF AllocMem()=FALSE
RAISE "MEM" IF New()=FALSE
RAISE "^C" IF CtrlC()=TRUE

PROC version()
    WriteF('\s',{versionstring})
ENDPROC

versionstring:
CHAR    '\0$VER: edit cel 1.50 (26.1.96) \tPUBLIC DOMAIN --- NOT FOR RESALE\0\0'

PROC reportmousemoves(win:PTR TO window)
    Forbid()
    win.flags:=win.flags OR WFLG_REPORTMOUSE
    Permit()
ENDPROC
PROC noreportmousemoves(win:PTR TO window);DEF flag
    Forbid()
    flag:=win.flags
    IF (flag AND WFLG_REPORTMOUSE) THEN flag:=flag-WFLG_REPORTMOUSE
    win.flags:=flag
    Permit()
ENDPROC

PROC busy()
    SetWindowPointerA(win,[$80000098,TRUE,WA_POINTERDELAY,TRUE,NIL,NIL])
    ModifyIDCMP(win,IDCMP_MENUPICK)
    StrCopy(string,'Edit CEL 1.50  *BUSY*',ALL)
    SetWindowTitles(win,-1,string)
ENDPROC

PROC ready()
    ClearPointer(win)
    ModifyIDCMP(win,IDCMP_MENUPICK OR IDCMP_MENUVERIFY)
    StringF(string,'Edit CEL 1.50  (\dx\d)',xsize,ysize)
    SetWindowTitles(win,-1,string)
ENDPROC


PROC main() HANDLE
    DEF i,ii,t,zz,tt,zzz
    DEF mes:PTR TO intuimessage
    DEF hit,hitflag=0,palload=0,iadd:PTR TO menuitem,drawx,drawy
    DEF dir[500]:STRING,file[250]:STRING,buffer
    DEF args:PTR TO wbarg,wstr[250]:STRING,toolobject=NIL:PTR TO diskobject
    DEF region1,rectangle:PTR TO rectangle
    DEF olddir,dirrr,wb:PTR TO wbstartup
    DEF argarray[32]:LIST,rdarg=0,gotme=0,check,code=0,du=0
    DEF zx,zy,zw,zh,zox,zoy
    DEF oldfh=0,newfh=0,filebuf=0,bufptr,filelen=1
    DEF menuverify=FALSE
    DEF fh1,fbuf=0,byte_h,byte_l,r,g,b,bpp,numc

    IF (KickVersion(39)=0)
        Raise("Kick")
    ENDIF

    buffer:=New(260*16)
    NEW palet,iinfo
    IF (doloaddtbase:=OpenLibrary('doloaddt.library',2))=NIL THEN Raise("DLDT")
    IF (iconbase:=OpenLibrary('icon.library', 37))=NIL THEN Raise("ICOL")
    IF (aslbase:=OpenLibrary('asl.library', 37))=NIL THEN Raise("ASL")
    IF (gadtoolsbase:=OpenLibrary('gadtools.library',37))=NIL THEN Raise("GT")
    IF (layersbase:=OpenLibrary('layers.library',37))=NIL THEN Raise("LAY")

    IF (iffparsebase:=OpenLibrary('iffparse.library',39))=NIL THEN Raise("IFFP")
    IF (utilitybase:=OpenLibrary('utility.library',39))=NIL THEN Raise("UTIL")
    IF (datatypesbase:=OpenLibrary('datatypes.library',39))=NIL THEN Raise("DT")
    IF (mathbase:=OpenLibrary('mathffp.library',37))=NIL THEN Raise("MFFP")

    IF wbmessage<>NIL
        outputmode:=TRUE
        wb:=wbmessage;args:=wb.arglist
        olddir:=CurrentDir(args.lock)
        IF args.name>0
            GetCurrentDirName(wstr,250)
            StrCopy(filename,wstr,ALL);AddPart(filename,'',490)
            StrAdd(wstr,args.name,ALL)
            toolobject:=GetDiskObjectNew(wstr)
            CurrentDir(olddir)
        ENDIF
        IF wb.numargs>1
            olddir:=args[].lock++ ->skip our lock! olddir is meaningless at this point
            IF args.lock
                olddir:=CurrentDir(args.lock)
                GetCurrentDirName(filename,490)
                NameFromLock(args.lock,wstr,240)
                CurrentDir(olddir)
                AddPart(filename,args.name,490)
                StrCopy(dtname,filename,ALL)
                StrCopy(ppmname,filename,ALL)
                StrCopy(paletname,filename,ALL)
            ENDIF
        ENDIF
        IF (toolobject<>0)
            IF (du:=FindToolType(toolobject.tooltypes,'DEPTH'))
                StrToLong(du,{rtdrag})
                IF rtdrag<4 THEN rtdrag:=4
                IF rtdrag>4 THEN rtdrag:=8
            ENDIF
            IF (du:=FindToolType(toolobject.tooltypes,'PICTURE_DIRECTORY'))
                StrCopy(dtname,du,ALL)
                AddPart(dtname,'',490)
                StrCopy(ppmname,du,ALL)
                AddPart(ppmname,'',490)
            ENDIF
            IF (du:=FindToolType(toolobject.tooltypes,'PICDIR'))
                StrCopy(dtname,du,ALL)
                AddPart(dtname,'',490)
            ENDIF
            IF (du:=FindToolType(toolobject.tooltypes,'KISS_DIRECTORY'))
                StrCopy(filename,du,ALL)
                AddPart(filename,'',490)
                StrCopy(paletname,du,ALL)
                AddPart(paletname,'',490)
            ENDIF
            IF (du:=FindToolType(toolobject.tooltypes,'CELDIR'))
                StrCopy(filename,du,ALL)
                AddPart(filename,'',490)
            ENDIF
            IF (du:=FindToolType(toolobject.tooltypes,'KCFDIR'))
                StrCopy(paletname,du,ALL)
                AddPart(paletname,'',490)
            ENDIF
            IF (du:=FindToolType(toolobject.tooltypes,'INITIAL_KCF'))
                StrCopy(paletname,du,ALL)
                palload:=555
            ENDIF
            FreeDiskObject(toolobject)
        ENDIF
    ELSE
        FOR i:=0 TO 30
            argarray[i]:=NIL
        ENDFOR
        rdarg:=ReadArgs('WORKDIR=K,PICDIR=P,KCF/K,DEPTH=D/N',argarray,0)
        IF rdarg
            IF argarray[0]
                StrCopy(filename,argarray[0],ALL)
                AddPart(filename,'',490)
                StrCopy(paletname,argarray[0],ALL)
                AddPart(paletname,'',490)
                StrCopy(dtname,argarray[0],ALL)
                AddPart(dtname,'',490)
                StrCopy(ppmname,argarray[0],ALL)
                AddPart(ppmname,'',490)
            ENDIF
            IF argarray[1]
                StrCopy(dtname,argarray[1],ALL)
                AddPart(dtname,'',490)
                StrCopy(ppmname,argarray[1],ALL)
                AddPart(ppmname,'',490)
            ENDIF
            IF argarray[2]
                StrCopy(paletname,argarray[2],ALL)
                palload:=555
            ENDIF
            IF argarray[3]
                rtdrag:=argarray[3]
                rtdrag:=^rtdrag
                IF rtdrag<4 THEN rtdrag:=4
                IF rtdrag>4 THEN rtdrag:=8
            ENDIF
            FreeArgs(rdarg)
        ENDIF
    ENDIF

    filereq:=AllocAslRequest(ASL_FILEREQUEST,[ASLFR_INITIALPATTERN,'#?.CEL',NIL,NIL])
    paletreq:=AllocAslRequest(ASL_FILEREQUEST,[ASLFR_INITIALPATTERN,'#?.KCF',NIL,NIL])
    dtreq:=AllocAslRequest(ASL_FILEREQUEST,[ASLFR_INITIALPATTERN,'#?',NIL,NIL])
    ppmreq:=AllocAslRequest(ASL_FILEREQUEST,[ASLFR_INITIALPATTERN,'#?.ppm',NIL,NIL])

    scr:=LockPubScreen('Workbench')
    config_size_x:=scr.width
    config_size_y:=(scr.height+scr.barheight+1)
    UnlockPubScreen(0,scr);scr:=0
    openscreen(rtdrag)
    GetRGB32(cm,0,256,buffer)
    FOR i:=0 TO 255
        palet.color[i].red:=Long(buffer+(i*12))
        palet.color[i].grn:=Long(buffer+(i*12)+4)
        palet.color[i].blu:=Long(buffer+(i*12)+8)
    ENDFOR
    WHILE quit=FALSE
        updatecolors()
        WHILE ((quit=FALSE) AND (newproj=FALSE))
            Wait(-1)
            CtrlC()
            hitflag:=0
            WHILE (mes:=Gt_GetIMsg(win.userport))
                IF (mes.class=IDCMP_MENUVERIFY)
                    menucolors(buffer)
                ENDIF
                IF (mes.class=IDCMP_MENUPICK)
                    code:=mes.code
                    WHILE (code<>MENUNULL)
                        iadd:=ItemAddress(menu,code)
                        IF iadd
                            hit:=Long(iadd+34)
                            check:=(Int(iadd+12) AND CHECKED)
                            IF ((hit>0) AND (hit<10)) THEN hitflag:=hit
                            IF hit=66 THEN quit:=TRUE
                            code:=iadd.nextselect
                        ELSE
                            code:=MENUNULL
                        ENDIF
                    ENDWHILE
                    updatemenucolors()
                ENDIF
          Gt_ReplyIMsg(mes)
            ENDWHILE
            IF (palload) THEN hitflag:=1
            SELECT hitflag
            CASE 1
                busy()
                IF palload=0
                    WbenchToFront()
                    splitname(paletname,dir,file)
                    ii:=AslRequest(paletreq,[ASL_HAIL,'Open which .KCF file?',
                            ASL_OKTEXT,'Open',ASL_FILE,file,ASL_DIR,dir,
                            ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,FALSE,FILF_NEWIDCMP,TRUE,NIL,NIL])
                    WbenchToBack()
                ELSE
                    ii:=TRUE
                ENDIF
                IF ii
                    IF palload=0
                        StrCopy(paletname,paletreq.drawer,ALL)
                        AddPart(paletname,paletreq.file,490)
                    ENDIF
                    fh1:=Open(paletname,MODE_OLDFILE)
                    IF fh1
                        fbuf:=New(500)
                        Read(fh1,fbuf,32)
                        IF Long(fbuf)="KiSS"
                            IF Char(fbuf+4)=FILE_MARK_PALET
                                bpp:=Char(fbuf+5)
                                numc:=ibmconv(Int(fbuf+8))
                                FOR i:=0 TO numc-1
                                    IF bpp=12
                                        Read(fh1,fbuf,2)
                                        byte_l:=Char(fbuf)
                                        byte_h:=Char(fbuf+1)
                                        r:=(Shr(byte_l,4) AND $F)*$1111
                                        g:=(byte_h AND $F)*$1111
                                        b:=(byte_l AND $F)*$1111
                                    ELSE
                                        Read(fh1,fbuf,1);r:=Shl(Char(fbuf),8) OR Char(fbuf)
                                        Read(fh1,fbuf,1);g:=Shl(Char(fbuf),8) OR Char(fbuf)
                                        Read(fh1,fbuf,1);b:=Shl(Char(fbuf),8) OR Char(fbuf)
                                    ENDIF
                                    r:=(Shl(Shl(r,8),8) OR r)
                                    g:=(Shl(Shl(g,8),8) OR g)
                                    b:=(Shl(Shl(b,8),8) OR b)
                                    palet.color[i].red:=r
                                    palet.color[i].grn:=g
                                    palet.color[i].blu:=b
                                ENDFOR
                            ENDIF
                        ELSE
                            Seek(fh1,0,OFFSET_BEGINNING)
                            FOR i:=0 TO 15
                                Read(fh1,fbuf,2)
                                byte_l:=Char(fbuf)
                                byte_h:=Char(fbuf+1)
                                r:=(Shr(byte_l,4) AND $F)*$1111
                                g:=(byte_h AND $F)*$1111
                                b:=(byte_l AND $F)*$1111
                                r:=(Shl(Shl(r,8),8) OR r)
                                g:=(Shl(Shl(g,8),8) OR g)
                                b:=(Shl(Shl(b,8),8) OR b)
                                palet.color[i].red:=r
                                palet.color[i].grn:=g
                                palet.color[i].blu:=b
                            ENDFOR
                        ENDIF
                        Dispose(fbuf)
                        Close(fh1)
                        updatecolors()
                    ENDIF
                ENDIF
            CASE 2
                busy()
                WbenchToFront()
                splitname(filename,dir,file)
                ii:=AslRequest(filereq,[ASL_HAIL,'Open which .CEL file?',
                        ASL_OKTEXT,'Open',ASL_FILE,file,ASL_DIR,dir,
                        ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,FALSE,FILF_NEWIDCMP,TRUE,NIL,NIL])
                WbenchToBack()
                IF ii
                    StrCopy(filename,filereq.drawer,ALL)
                    AddPart(filename,filereq.file,490)
                    fh1:=Open(filename,MODE_OLDFILE)
                    IF fh1
                        fbuf:=New(8000)
                        SetRast(rp,0)
                        Read(fh1,fbuf,4)
                        IF Long(fbuf)="KiSS"
                            Read(fh1,fbuf,28)
                            IF Char(fbuf)=FILE_MARK_CELL
                                nxsize:=ibmconv(Int(fbuf+4))
                                IF (nxsize/2)<>((nxsize+1)/2) THEN nxsize:=nxsize+1
                                nysize:=ibmconv(Int(fbuf+6))
                                xoff:=ibmconv(Int(fbuf+8))
                                yoff:=ibmconv(Int(fbuf+10))
                                xsize:=nxsize+xoff
                                ysize:=nysize+yoff
                                bpp:=Char(fbuf+1)
                                IF bpp=4
                                    FOR t:=0 TO nysize-1
                                        Read(fh1,fbuf,((nxsize+1)/2))
                                        FOR i:=0 TO (nxsize) STEP 2
                                            byte_h:=Char(fbuf+(i/2))
                                            SetAPen(rp,Shr(byte_h AND $F0,4))
                                            WritePixel(rp,xoff+i,yoff+t)
                                            SetAPen(rp,byte_h AND $F)
                                            WritePixel(rp,xoff+i+1,yoff+t)
                                        ENDFOR
                                    ENDFOR
                                ELSE
                                    FOR t:=0 TO nysize-1
                                        Read(fh1,fbuf,nxsize)
                                        FOR i:=0 TO nxsize-1
                                            byte_h:=Char(fbuf+i)
                                            SetAPen(rp,byte_h)
                                            WritePixel(rp,xoff+i,xoff+t)
                                        ENDFOR
                                    ENDFOR
                                ENDIF
                            ELSE
                                DisplayBeep(0)
                            ENDIF
                        ELSE
                            nxsize:=ibmconv(Int(fbuf))
                            IF (nxsize/2)<>((nxsize+1)/2) THEN nxsize:=nxsize+1
                            nysize:=ibmconv(Int(fbuf+2))
                            IF ((nxsize<2) OR (nxsize>640) OR (nysize<2) OR (nysize>400))
                                DisplayBeep(0)
                            ELSE
                                xsize:=nxsize
                                ysize:=nysize
                                FOR t:=0 TO ysize-1
                                    Read(fh1,fbuf,((xsize+1)/2))
                                    FOR i:=0 TO (xsize) STEP 2
                                        byte_h:=Char(fbuf+(i/2))
                                        SetAPen(rp,Shr(byte_h AND $F0,4))
                                        WritePixel(rp,i,t)
                                        SetAPen(rp,byte_h AND $F)
                                        WritePixel(rp,i+1,t)
                                    ENDFOR
                                ENDFOR
                            ENDIF
                        ENDIF
                        Dispose(fbuf)
                        Close(fh1)
                    ENDIF
                ENDIF
            CASE 3
                busy()
                WbenchToFront()
                splitname(dtname,dir,file)
                ii:=AslRequest(dtreq,[ASL_HAIL,'Open which Picture file?',
                        ASL_OKTEXT,'Open',ASL_FILE,file,ASL_DIR,dir,
                        ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,FALSE,FILF_NEWIDCMP,TRUE,NIL,NIL])
                WbenchToBack()
                IF ii
                    StrCopy(dtname,dtreq.drawer,ALL)
                    AddPart(dtname,dtreq.file,490)
                ENDIF
                textattr:=['topaz.font',8,0,0]:textattr
                textfont:=OpenFont(textattr)
                goodload:=(Doloaddt(dtname,rp,cm,0,0,config_size_x,config_size_y,[DLDT_CENTER,FALSE,
                    DLDT_DITHERTYPE,DITH_FLOYD,
                    DLDT_REMAP,TRUE,
                    DLDT_ASPECTX,1,
                    DLDT_ASPECTY,1,
                    DLDT_SCALE,FALSE,
                    DLDT_USEASPECT,FALSE,
                    DLDT_CLEAR,TRUE,
                    DLDT_INFO,iinfo,
                    DLDT_STATWINDOW,[scr,0,16,textfont,textattr,textstyle,'Loading...','Scaling...','histo','quant','Rendering','Cancel','Loading Datatype',dtname]:statwindow,
                    DLDT_ACTIVATESTATWINDOW,TRUE,
                    DLDT_HIGHPEN,-1,NIL,NIL]))
                CloseFont(textattr)
                IF goodload=0
                    xsize:=(iinfo.destination_w+1)/2*2
                    ysize:=iinfo.destination_h
                ENDIF
            CASE 4
                menucolors(buffer)
                EasyRequestArgs(win,[20,0,'Load .ppm file...',
                    'Loading a .ppm file is not implemented yet.',
                    'Ok'],0,0)
                updatemenucolors()
->              busy()
->              WbenchToFront()
->              splitname(ppmname,dir,file)
->              ii:=AslRequest(ppmreq,[ASL_HAIL,'Select ppm file',
->                      ASL_OKTEXT,'Open',ASL_FILE,file,ASL_DIR,dir,
->                      ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,FALSE,FILF_NEWIDCMP,TRUE,NIL,NIL])
->              WbenchToBack()
->              IF ii
->                  StrCopy(ppmname,ppmreq.drawer,ALL)
->                  AddPart(ppmname,ppmreq.file,490)
->              ENDIF
            CASE 5
                busy()
                WbenchToFront()
                splitname(paletname,dir,file)
                ii:=AslRequest(paletreq,[ASL_HAIL,'Save .KCF file as',
                        ASL_OKTEXT,'Save',ASL_FILE,file,ASL_DIR,dir,
                        ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,TRUE,FILF_NEWIDCMP,TRUE,NIL,NIL])
                WbenchToBack()
                IF ii
                    StrCopy(paletname,paletreq.drawer,ALL)
                    AddPart(paletname,paletreq.file,490)
                    fh1:=Open(paletname,MODE_NEWFILE)
                    IF fh1
                        fbuf:=New(500)
                        FOR i:=0 TO 31
                            PutChar(fbuf,0)
                        ENDFOR
                        PutLong(fbuf,"KiSS")
                        PutChar(fbuf+4,FILE_MARK_PALET)
                        PutChar(fbuf+5,24)
                        PutInt(fbuf+8,ibmconv(IF depth=4 THEN 16 ELSE 256))
                        PutInt(fbuf+10,ibmconv(10))
                        Write(fh1,fbuf,32)
                        FOR t:=0 TO 9
                            FOR i:=0 TO IF (depth=4) THEN 15 ELSE 255
                                PutChar(fbuf+(i*3),palet.color[i].red)
                                PutChar(fbuf+(i*3)+1,palet.color[i].grn)
                                PutChar(fbuf+(i*3)+2,palet.color[i].blu)
                            ENDFOR
                            Write(fh1,fbuf,IF (depth=4) THEN 16*3 ELSE 256*3)
                        ENDFOR
                        Dispose(fbuf)
                        Close(fh1)
                    ENDIF
                ENDIF
            CASE 6
                busy()
                WbenchToFront()
                splitname(filename,dir,file)
                ii:=AslRequest(filereq,[ASL_HAIL,'Save .CEL file as',
                        ASL_OKTEXT,'Save',ASL_FILE,file,ASL_DIR,dir,
                        ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,TRUE,FILF_NEWIDCMP,TRUE,NIL,NIL])
                WbenchToBack()
                IF ii
                    StrCopy(filename,filereq.drawer,ALL)
                    AddPart(filename,filereq.file,490)
                    xoff:=xsize
                    FOR i:=0 TO ysize
                        FOR t:=0 TO xoff
                            IF ReadPixel(rp,t,i)<>0
                                xoff:=smaller(xoff,t)
                                t:=xoff
                            ENDIF
                        ENDFOR
                    ENDFOR
                    yoff:=ysize
                    FOR i:=0 TO xsize
                        FOR t:=0 TO yoff
                            IF ReadPixel(rp,i,t)<>0
                                yoff:=smaller(yoff,t)
                                t:=yoff
                            ENDIF
                        ENDFOR
                    ENDFOR
                    xsize:=((xsize-xoff+1)/2)*2+1
                    ysize:=ysize-yoff+1
                    ClipBlit(rp,xoff,yoff,rp,0,0,xsize,ysize,192)
                    SetAPen(rp,0)
                    RectFill(rp,xsize,0,3000,2000)
                    RectFill(rp,0,ysize,3000,2000)

                    nxsize:=0
                    FOR i:=ysize TO 0 STEP -1
                        FOR t:=xsize TO nxsize STEP -1
                            IF ReadPixel(rp,t,i)<>0
                                nxsize:=t
                                t:=nxsize
                            ENDIF
                        ENDFOR
                    ENDFOR
                    nysize:=0
                    FOR i:=xsize TO 0 STEP -1
                        FOR t:=ysize TO nysize STEP -1
                            IF ReadPixel(rp,i,t)<>0
                                nysize:=t
                                t:=nysize
                            ENDIF
                        ENDFOR
                    ENDFOR
                    xsize:=((nxsize+1)/2)*2+1
                    ysize:=nysize+1

                    fh1:=Open(filename,MODE_NEWFILE)
                    IF fh1
                        fbuf:=New(6000)
                        FOR i:=0 TO 31
                            PutChar(fbuf,0)
                        ENDFOR
                        PutLong(fbuf,"KiSS")
                        PutChar(fbuf+4,FILE_MARK_CELL)
                        PutChar(fbuf+5,IF (depth=4) THEN 4 ELSE 8)
                        PutInt(fbuf+8, ibmconv(xsize))
                        PutInt(fbuf+10,ibmconv(ysize))
                        PutInt(fbuf+12,ibmconv(xoff))
                        PutInt(fbuf+14,ibmconv(yoff))
                        Write(fh1,fbuf,32)
                        IF (depth=4)
                            FOR t:=0 TO ysize-1
                                FOR i:=0 TO (xsize-1) STEP 2
                                    PutChar(fbuf+(i/2),(Shl(ReadPixel(rp,i,t) AND $F,4) OR (ReadPixel(rp,i+1,t) AND $F)))
                                ENDFOR
                                Write(fh1,fbuf,((xsize+1)/2))
                            ENDFOR
                        ELSE
                            FOR t:=0 TO ysize-1
                                FOR i:=0 TO xsize-1
                                    PutChar(fbuf+i,ReadPixel(rp,i,t))
                                ENDFOR
                                Write(fh1,fbuf,xsize)
                            ENDFOR
                        ENDIF
                        Close(fh1)
                        Dispose(fbuf)
                    ENDIF
                ENDIF
                ClipBlit(rp,0,0,rp,xoff,yoff,xsize,ysize,192)
                SetAPen(rp,0)
                IF ((xoff>0)) THEN  RectFill(rp,0,0,xoff-1,1000)
                IF ((yoff>0)) THEN  RectFill(rp,0,0,1000,yoff-1)
                xsize:=xsize+xoff
                ysize:=ysize+yoff
            CASE 7
                busy()
                WbenchToFront()
                splitname(dtname,dir,file)
                ii:=AslRequest(dtreq,[ASL_HAIL,'Save IFF file as',
                        ASL_OKTEXT,'Save',ASL_FILE,file,ASL_DIR,dir,
                        ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,TRUE,FILF_NEWIDCMP,TRUE,NIL,NIL])
                WbenchToBack()
                IF ii
                    StrCopy(dtname,dtreq.drawer,ALL)
                    AddPart(dtname,dtreq.file,490)
                    tbmp:=AllocBitMap(xsize,ysize,depth,BMF_STANDARD,scr.rastport.bitmap)
                    IF tbmp
                        BltBitMap(scr.rastport.bitmap,0,scr.barheight+1,tbmp,0,0,xsize,ysize,192,$FFFFFFFF,0)
                        saveclip(dtname,tbmp,vp,xsize,ysize)
                        FreeBitMap(tbmp)
                    ENDIF
                ENDIF
            CASE 8
                busy()
                WbenchToFront()
                splitname(ppmname,dir,file)
                ii:=AslRequest(ppmreq,[ASL_HAIL,'Save ppm file as',
                        ASL_OKTEXT,'Save',ASL_FILE,file,ASL_DIR,dir,
                        ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,TRUE,FILF_NEWIDCMP,TRUE,NIL,NIL])
                WbenchToBack()
                IF ii
                    StrCopy(ppmname,ppmreq.drawer,ALL)
                    AddPart(ppmname,ppmreq.file,490)
                ENDIF
            CASE 9
                menucolors(buffer)
                EasyRequestArgs(win,[20,0,'About Edit CEL 1.50',
                    'Written in a few hours\n(plus one more)\nby\nChad Randall\ncrandall@msen.com',
                    'Ok'],0,0)
                updatemenucolors()
            ENDSELECT
            ready();palload:=FALSE
        ENDWHILE
    ENDWHILE    
    closescreen()
EXCEPT DO

    SELECT exception
    CASE 0;NOP
    CASE "DLDT";err('Missing doloaddt.library')
    CASE "ICOL";err('Missing icon.library')
    CASE "IFFP";err('Missing iffparse.library')
    CASE "MFFP";err('Missing mathffp.library')
    CASE "KEYM";err('Missing keymap.library')
    CASE "UTIL";err('Missing utility.library')
    CASE "GT";err('Missing gadtools.library')
    CASE "ASL";err('Missing asl.library')
    CASE "LAY";err('Missing layers.library')
    CASE "DT";err('Missing datatype.library')
    CASE "MEM";err('Not enough memory.')
    CASE "CHIP";err('Not enough CHIP memory.')
    CASE "^C";err('***Break')
    CASE "Egui";err('EasyGUI error.')
    CASE "bigg";err('EasyGUI too big!')
    CASE "SCR";err('Can\at open screen.')
    CASE "WIN";err('Can\at open window.')
    CASE "MENU";err('Can\at create menu.')
    CASE "VIS";err('Can\t obtain visual structure.')
    CASE "file";err('File error.')
    CASE "err";err('Misc. error?')
    ENDSELECT

    closescreen()
    Dispose(buffer)
    IF ((exception="^C") AND (outputmode=0)) THEN WriteF('***BREAK\n')
    IF ((exception="Kick"))
        WriteF('You need at least OS 3.0 (Kickstart 39) to run.\n')
        DisplayBeep(0)
    ENDIF
    IF filereq THEN FreeAslRequest(filereq)
    IF dtreq THEN FreeAslRequest(dtreq)
    IF paletreq THEN FreeAslRequest(paletreq)
    IF ppmreq THEN FreeAslRequest(ppmreq)
    IF doloaddtbase THEN CloseLibrary(doloaddtbase)
    IF gadtoolsbase THEN CloseLibrary(gadtoolsbase)
    IF layersbase THEN CloseLibrary(layersbase)
    IF aslbase THEN CloseLibrary(aslbase)
    IF iconbase THEN CloseLibrary(iconbase)
    END palet
ENDPROC

PROC menucolors(buffer)
    DEF i
    FOR i:=0 TO 3
        SetRGB32(vp,i,Long(buffer+(i*12)),Long(buffer+(i*12)+4),Long(buffer+(i*12)+8))
    ENDFOR
    FOR i:=17 TO 19
        SetRGB32(vp,i,Long(buffer+(i*12)),Long(buffer+(i*12)+4),Long(buffer+(i*12)+8))
    ENDFOR
    FOR i:=(Shl(1,rtdrag)-4) TO (Shl(1,rtdrag)-1)
        SetRGB32(vp,i,Long(buffer+(i*12)),Long(buffer+(i*12)+4),Long(buffer+(i*12)+8))
    ENDFOR
ENDPROC

PROC updatemenucolors()
    DEF i
    FOR i:=0 TO 3
        SetRGB32(vp,i,palet.color[i].red,palet.color[i].grn,palet.color[i].blu)
->      SetRGB32(vp,i,Long(buffer+(i*12)),Long(buffer+(i*12)+4),Long(buffer+(i*12)+8))
    ENDFOR
    FOR i:=17 TO 19
        SetRGB32(vp,i,palet.color[i].red,palet.color[i].grn,palet.color[i].blu)
->      SetRGB32(vp,i,Long(buffer+(i*12)),Long(buffer+(i*12)+4),Long(buffer+(i*12)+8))
    ENDFOR
    FOR i:=(Shl(1,rtdrag)-4) TO (Shl(1,rtdrag)-1)
        SetRGB32(vp,i,palet.color[i].red,palet.color[i].grn,palet.color[i].blu)
->      SetRGB32(vp,i,Long(buffer+(i*12)),Long(buffer+(i*12)+4),Long(buffer+(i*12)+8))
    ENDFOR
ENDPROC

PROC updatecolors()
    DEF i,pn=0,t
    FOR i:=0 TO 255
        SetRGB32(vp,i,palet.color[i].red,palet.color[i].grn,palet.color[i].blu)
    ENDFOR
ENDPROC

PROC isdigit(s);IF (((s>="0") AND (s<="9")) OR (s=".") OR (s="-")) THEN RETURN TRUE;ENDPROC FALSE
PROC isalpha(s);IF (((s>="a") AND (s<="z")) OR ((s>="A") AND (s<="Z"))) THEN RETURN TRUE;ENDPROC FALSE
PROC ispunc(s);IF ((s=".") OR (s="-") OR (s="_")) THEN RETURN TRUE;ENDPROC FALSE

PROC scanforvalue(str)
    DEF l=0,i,s[100]:STRING,ins,iii=0
    WHILE (isdigit(Char(str+l)));l:=l+1;ENDWHILE
    StrCopy(s,str,l)
    ins:=InStr(str,'.')
    IF ((ins>0) AND (ins<=l))
        StrToLong(s,{i})
        StrToLong(s+ins+1,{iii})
    ELSE
        StrToLong(s,{i})
    ENDIF
ENDPROC i,l,iii

PROC scanforstring(str)
    DEF l=0
    WHILE (isdigit(Char(str+l)) OR isalpha(Char(str+l)) OR ispunc(Char(str+l)));l:=l+1;ENDWHILE
ENDPROC l

PROC openscreen(d)
    DEF cflag,lflag1=CHECKIT,lflag2=CHECKIT,lflag3=CHECKIT,lflag4=CHECKIT,lflag5=CHECKIT,lflag=CHECKIT
    DEF hflag1=CHECKIT,hflag2=CHECKIT,hflag3=CHECKIT,bflag=CHECKIT
    depth:=d
    scr:=OpenScreenTagList(NIL,[SA_LIKEWORKBENCH,TRUE,
        SA_DEPTH,depth,
        SA_TITLE,'Edit CEL',
        SA_COLORMAPENTRIES,256,
        SA_FULLPALETTE,TRUE,
        SA_WIDTH,config_size_x,
        SA_HEIGHT,config_size_y,
        SA_INTERLEAVED,TRUE,
        SA_AUTOSCROLL,TRUE,
        SA_PENS,[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]:INT,
        NIL,NIL])
    IF scr=0 THEN Raise("SCR")
    IF (vis:=GetVisualInfoA(scr,NIL))=0 THEN RETURN "VIS"
    win:=OpenWindowTagList(0,[WA_WIDTH,scr.width,WA_HEIGHT,scr.height-scr.barheight-1,
        WA_TOP,scr.barheight+1,WA_LEFT,0,
        WA_FLAGS,WFLG_ACTIVATE OR WFLG_SMART_REFRESH,
        WA_BORDERLESS,TRUE,
        WA_BACKDROP,TRUE,
        WA_CUSTOMSCREEN,scr,
        WA_NEWLOOKMENUS,TRUE,
        WA_IDCMP,IDCMP_MENUPICK OR IDCMP_MENUVERIFY,
        NIL,NIL])
    IF win=0 THEN Raise("WIN")
    vp:=scr.viewport
    cm:=vp.colormap
    rp:=win.rport

  IF (menu:=CreateMenusA([NM_TITLE,0,'Project',0,0,0,0,
                                                    NM_ITEM,0,'Open KCF...','K',0,0,1,
                                                    NM_ITEM,0,'Open CEL...','C',0,0,2,
                                                    NM_ITEM,0,'Open Datatype...','O',0,0,3,
                                                    NM_ITEM,0,'Open PPM (P6)','P',0,0,4,
                                                    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
                                                    NM_ITEM,0,'Save KCF','F',0,0,5,
                                                    NM_ITEM,0,'Save CEL','E',0,0,6,
                                                    NM_ITEM,0,'Save IFF','I',0,0,7,
                                                    NM_ITEM,0,'Save PPM (P6)','B',0,0,8,
                                                    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
                                                    NM_ITEM,0,'About','?',0,0,9,
                                                    NM_ITEM,0,'Quit','Q',0,0,66,

                                                    NM_END,0,'End','x',0,0,0]:newmenu,NIL))=NIL THEN Raise("MENU")
    LayoutMenusA(menu,vis,[GTMN_NEWLOOKMENUS,TRUE,NIL,NIL])
    SetMenuStrip(win,menu)
    offmenu(4)
    offmenu(8)
ENDPROC

PROC offmenu(id);DEF a,b,c;a,b,c:=findmenuid(menu,id);IF win THEN OffMenu(win,packmenunumber(a,b,c));ENDPROC
PROC onmenu(id);DEF a,b,c;a,b,c:=findmenuid(menu,id);IF win THEN OnMenu(win,packmenunumber(a,b,c));ENDPROC

PROC closescreen()
    IF win
        CloseWindow(win)
        win:=0
    ENDIF
    IF menu
        FreeMenus(menu)
        menu:=0
    ENDIF
    IF vis
        FreeVisualInfo(vis)
        vis:=0
    ENDIF
    IF scr
        CloseScreen(scr)
        scr:=0
    ENDIF

ENDPROC

PROC err(msgptr)
    IF ((aslbase<>0))
        EasyRequestArgs(0,[20,0,'Error!',msgptr,'Okay'],0,0)
    ELSE
        WriteF('\s\n',msgptr)
    ENDIF
ENDPROC


OPT MODULE

MODULE 'graphics/gfx','datatypes','datatypes/datatypes','datatypes/pictureclass',
       'datatypes/datatypesclass','intuition/screens','amigalib/boopsi',
       'graphics/view','utility/tagitem','graphics/rastport','graphics/scale',
       'exec/memory','hardware/blit','tools/file'

EXPORT OBJECT graphic
    w,h,dt,type
PRIVATE
    bm[20]:ARRAY OF LONG
    mask[20]:ARRAY OF LONG
ENDOBJECT

ENUM TYPE_ERROR,TYPE_SNAKE,TYPE_FRUIT

PROC patchGraphic(name:PTR TO CHAR,screen:PTR TO screen) -> Aaaaargh! a KLUDGE!!
    DEF dri:PTR TO drawinfo,f=0,l,c[3]:ARRAY OF LONG,p,s=FALSE,r,g,b
    f,l:=readfile(name,NIL)
    p:=f
    IF Long(p)<>"FORM" THEN Raise("grld")
    p:=p+8
    IF Long(p)<>"ILBM" THEN Raise("grld")
    p:=p+4
    WHILE p<(f+l)
        IF Long(p)="CMAP"
            dri:=GetScreenDrawInfo(screen)
            GetRGB32(screen.viewport.colormap,dri.pens[BACKGROUNDPEN],1,c)
            FreeScreenDrawInfo(screen,dri)
            r:=Char(c)
            g:=Char(c+4)
            b:=Char(c+8)
            IF (r<>Char(p+8)) OR (g<>Char(p+9)) OR (b<>Char(p+10))
                PutChar(p+8,r)
                PutChar(p+9,g)
                PutChar(p+10,b)
                s:=TRUE
            ENDIF
        ENDIF
        p:=p+Long(p+4)+8
    ENDWHILE
    IF s THEN writefile(name,f,l)
    freefile(f)
ENDPROC

EXPORT PROC loadGraphic(name:PTR TO CHAR,screen:PTR TO screen) HANDLE
    DEF g:PTR TO graphic,pat[1024]:ARRAY OF CHAR

    IF name=0 THEN RETURN 0
    IF Char(name)=0 THEN RETURN 0
    patchGraphic(name,screen)
    NEW g
    g.dt:=NewDTObjectA(name,[DTA_GROUPID,GID_PICTURE,PDTA_REMAP,TRUE,
                             PDTA_SCREEN,screen,
                             PDTA_FREESOURCEBITMAP,FALSE,
                             OBP_PRECISION,PRECISION_EXACT,TAG_DONE])
    IF g.dt<>0
        IF doMethodA(g.dt,[DTM_PROCLAYOUT,NIL,1])=0 THEN Raise("grld")
    ELSE
        Raise("grld")
    ENDIF

    g.type:=TYPE_ERROR
    ParsePatternNoCase('#?.s#?',pat,1024)
    IF MatchPatternNoCase(pat,name) THEN g.type:=TYPE_SNAKE
    ParsePatternNoCase('#?.f#?',pat,1024)
    IF MatchPatternNoCase(pat,name) THEN g.type:=TYPE_FRUIT
    IF g.type=TYPE_ERROR THEN Raise("grld")

EXCEPT
    IF g
        IF g.dt THEN DisposeDTObject(g.dt)
        END g
    ENDIF
    ReThrow()
ENDPROC g

EXPORT PROC freeGraphic(g:PTR TO graphic)
    DEF i
    IF g=0 THEN RETURN
    FOR i:=0 TO 13
        IF g.bm[i] THEN FreeBitMap(g.bm[i])
        IF g.mask[i] THEN Dispose(g.mask[i])
    ENDFOR
    DisposeDTObject(g.dt)
    END g
ENDPROC

EXPORT PROC drawGraphic(rp,g:PTR TO graphic,i,x,y)
    IF g.mask[i]
        BltMaskBitMapRastPort(g.bm[i],0,0,rp,x,y,g.w,g.h,ABC OR ABNC OR ANBC,g.mask[i])
    ELSE
        BltBitMapRastPort(g.bm[i],0,0,rp,x,y,g.w,g.h,$C0)
    ENDIF
ENDPROC

EXPORT PROC scaleGraphic(g:PTR TO graphic,w,h,screen:PTR TO screen) HANDLE
    DEF bmhd:PTR TO bitmapheader,bm:PTR TO bitmap,rw,rh,sa:PTR TO bitscaleargs,i,m

    IF (w=g.w) AND (h=g.h) THEN RETURN

    m:=IF g.type=TYPE_FRUIT THEN 0 ELSE 19

    FOR i:=0 TO 19
        IF g.bm[i] THEN FreeBitMap(g.bm[i])
        IF g.mask[i] THEN Dispose(g.mask[i])
    ENDFOR
    GetDTAttrsA(g.dt,[PDTA_BITMAPHEADER,{bmhd},PDTA_DESTBITMAP,{bm},TAG_DONE])
    IF bm
        g.w:=w
        g.h:=h
        rw:=bmhd.width
        rh:=bmhd.height/(m+1)
        IF (rh*(m+1))<>bmhd.height THEN Raise("size")
        i:=0
        NEW sa
        FOR i:=0 TO m
            g.bm[i]:=AllocBitMap(w,h,GetBitMapAttr(bm,BMA_DEPTH),0,screen.rastport.bitmap)
            IF g.bm[i]
                IF (w<>rw) OR (h<>rh)
                    sa.srcx:=0
                    sa.srcwidth:=rw
                    sa.srcheight:=rh
                    sa.destx:=0
                    sa.desty:=0
                    sa.srcbitmap:=bm
                    sa.xsrcfactor:=rw
                    sa.xdestfactor:=w
                    sa.ysrcfactor:=rh
                    sa.ydestfactor:=h
                    sa.destbitmap:=g.bm[i]
                    sa.srcy:=i*rh
                    BitMapScale(sa)
                ELSE
                    BltBitMap(bm,0,i*rh,g.bm[i],0,0,rw,rh,$C0,$FF,NIL)
                ENDIF
                g.mask[i]:=createMask(g.bm[i],w,h)
            ELSE
                Raise("MEM")
            ENDIF
        ENDFOR
    ELSE
        Raise("grbm")
    ENDIF
EXCEPT DO
    END sa
    IF exception THEN ReThrow()
ENDPROC

PROC createMask(bm:PTR TO bitmap,w,h) HANDLE -> KLUDGE! Gfxlib ought to support bitmaps as masks! :(
    DEF mbm:bitmap,i,j,mask=0:PTR TO CHAR,bs,p:PTR TO CHAR,m

    mbm.flags:=BMF_STANDARD
    mbm.bytesperrow:=bm.bytesperrow
    mbm.rows:=bm.rows
    mbm.depth:=bm.depth
    bs:=mbm.bytesperrow*mbm.rows
    FOR i:=0 TO (mbm.depth-1) DO mbm.planes[i]:=0
    FOR i:=0 TO (mbm.depth-1) DO mbm.planes[i]:=NewM(bs,MEMF_CHIP OR MEMF_CLEAR)
    BltBitMap(bm,0,0,mbm,0,0,w,h,$C0,$FF,NIL)
    mask:=NewM(bs,MEMF_CHIP OR MEMF_CLEAR)
    FOR i:=0 TO (bs-1)
        m:=0
        FOR j:=0 TO (mbm.depth-1)
            p:=mbm.planes[j]
            m:=Or(m,p[i])
        ENDFOR
        mask[i]:=m
    ENDFOR
EXCEPT DO
    FOR i:=0 TO (mbm.depth-1) DO IF mbm.planes[i] THEN Dispose(mbm.planes[i])
    IF exception
        IF mask THEN Dispose(mask)
        ReThrow()
    ENDIF
ENDPROC mask


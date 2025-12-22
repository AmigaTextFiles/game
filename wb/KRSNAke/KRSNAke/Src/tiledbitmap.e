OPT MODULE

MODULE 'graphics/rastport','graphics/clip','graphics/gfx','datatypes',
       'datatypes/datatypes','datatypes/datatypesclass','datatypes/pictureclass',
       'graphics/view','utility/tagitem','amigalib/boopsi','intuition/screens'

EXPORT OBJECT imagedata
    dt:LONG
    bmhd:PTR TO bitmapheader
    bm:PTR TO bitmap
ENDOBJECT

EXPORT PROC createImageData(name:PTR TO CHAR,screen:PTR TO screen)
    DEF i:PTR TO imagedata,s=0,bm:PTR TO bitmap,a
    IF name=0 THEN RETURN 0
    IF Char(name)=0 THEN RETURN 0
    NEW i
    i.dt:=NewDTObjectA(name,[DTA_GROUPID,GID_PICTURE,PDTA_REMAP,TRUE,
                             PDTA_SCREEN,screen,
                             PDTA_FREESOURCEBITMAP,TRUE,
                             OBP_PRECISION,PRECISION_EXACT,TAG_DONE])
    IF i.dt<>0
        IF doMethodA(i.dt,[DTM_PROCLAYOUT,NIL,1])
            GetDTAttrsA(i.dt,[PDTA_BITMAPHEADER,{a},TAG_DONE])
            i.bmhd:=a
            GetDTAttrsA(i.dt,[PDTA_DESTBITMAP,{bm},TAG_DONE])
            IF bm=0 THEN GetDTAttrsA(i.dt,[PDTA_BITMAP,{bm},TAG_DONE])
            IF bm
                a:=GetBitMapAttr(bm,BMA_DEPTH)
                i.bm:=AllocBitMap(i.bmhd.width,i.bmhd.height,a,IF a=8 THEN BMF_MINPLANES ELSE 0,screen.rastport.bitmap)
                IF i.bm
                    BltBitMap(bm,0,0,i.bm,0,0,i.bmhd.width,i.bmhd.height,$C0,$FF,NIL)
                    s:=1
                ENDIF
            ENDIF
        ENDIF
        IF s=0 THEN DisposeDTObject(i.dt)
    ENDIF
    IF s=0
        END i
        i:=0
    ENDIF
ENDPROC i

EXPORT PROC disposeImageData(i:PTR TO imagedata)
    IF i.dt THEN DisposeDTObject(i.dt)
    IF i.bm THEN FreeBitMap(i.bm)
    END i
ENDPROC

EXPORT PROC copyTiledBitMap(srci:PTR TO imagedata,dst:PTR TO rastport,dstbounds:PTR TO rectangle,flag=0)
    DEF firstsizex,firstsizey,secondminx,secondminy,secondsizex,secondsizey,pos,size,
        src:PTR TO bitmap,srcsizex,srcsizey,srcoffsetx=0,srcoffsety=0

    src:=srci.bm
    srcsizex:=srci.bmhd.width
    srcsizey:=srci.bmhd.height
    IF flag=0
        srcoffsetx:=offsmod(dstbounds.minx,srcsizex)
        srcoffsety:=offsmod(dstbounds.miny,srcsizey)
    ENDIF

    firstsizex:=Min(srcsizex-srcoffsetx,rectsizex(dstbounds))
    secondminx:=dstbounds.minx+firstsizex
    secondsizex:=Min(srcoffsetx,dstbounds.maxx-secondminx+1)

    firstsizey:=Min(srcsizey-srcoffsety,rectsizey(dstbounds))
    secondminy:=dstbounds.miny+firstsizey
    secondsizey:=Min(srcoffsety,dstbounds.maxy-secondminy+1)

    BltBitMapRastPort(src,srcoffsetx,srcoffsety,dst,dstbounds.minx,dstbounds.miny,firstsizex,firstsizey,$C0)
    IF secondsizex>0 THEN BltBitMapRastPort(src,0,srcoffsety,dst,secondminx,dstbounds.miny,secondsizex,firstsizey,$C0)
    IF secondsizey>0
        BltBitMapRastPort(src,srcoffsetx,0,dst,dstbounds.minx,secondminy,firstsizex,secondsizey,$C0)
        IF secondsizex>0 THEN BltBitMapRastPort(src,0,0,dst,secondminx,secondminy,secondsizex,secondsizey,$C0)
    ENDIF
    pos:=dstbounds.minx+srcsizex
    size:=Min(srcsizex,dstbounds.maxx-pos+1)
    WHILE pos<=dstbounds.maxx
        BltBitMapRastPort(dst.bitmap,dstbounds.minx+dst.layer.minx,dstbounds.miny+dst.layer.miny,dst,pos,dstbounds.miny,size,Min(srcsizey,rectsizey(dstbounds)),$C0)
        pos:=pos+size
        size:=Min(Shl(size,1),dstbounds.maxx-pos+1)
    ENDWHILE
    pos:=dstbounds.miny+srcsizey
    size:=Min(srcsizey,dstbounds.maxy-pos+1)
    WHILE pos<=dstbounds.maxy
        BltBitMapRastPort(dst.bitmap,dstbounds.minx+dst.layer.minx,dstbounds.miny+dst.layer.miny,dst,dstbounds.minx,pos,rectsizex(dstbounds),size,$C0)
        pos:=pos+size
        size:=Min(Shl(size,1),dstbounds.maxy-pos+1)
    ENDWHILE
ENDPROC

PROC rectsizex(r:PTR TO rectangle) IS r.maxx-r.minx+1
PROC rectsizey(r:PTR TO rectangle) IS r.maxy-r.miny+1
PROC offsmod(x,y) IS IF x<0 THEN y-Mod(0-x,y) ELSE Mod(x,y)


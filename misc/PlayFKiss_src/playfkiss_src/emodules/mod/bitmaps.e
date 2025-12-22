OPT MODULE
MODULE 'intuition/intuition','intuition/gadgetclass'
MODULE 'exec/lists','exec/nodes','exec/ports','exec/memory'
MODULE 'gadtools','libraries/gadtools'
MODULE 'iffparse','libraries/iffparse'
MODULE 'icon'
MODULE	'graphics/gfx','graphics/layers','graphics/rastport','graphics/regions','graphics/clip'
MODULE	'layers'

EXPORT CONST BMF_MAKEMASK=$10000000
EXPORT CONST AREALEN=500
EXPORT OBJECT imbuf
	li:PTR TO layer_info
	l:PTR TO layer
	rast:PTR TO rastport
	bmap:PTR TO bitmap
	tempbitmap:PTR TO bitmap
	tmpras:tmpras
	areainfo:areainfo
	areabuf:LONG
	ismask:CHAR
ENDOBJECT

PROC new(w,h,d,flags=0) OF imbuf
	createlayerinfo(self,w,h,d,FALSE,0,flags)
ENDPROC self.bmap

PROC end() OF imbuf
	disposelayerinfo(self)
ENDPROC

EXPORT PROC createlayerinfo(imbuf:PTR TO imbuf,x,y,d,flag,fb,flags)
	DEF i
  IF (imbuf=0) THEN RETURN

	disposelayerinfo(imbuf)

	imbuf.bmap:=AllocBitMap(x,y,d,(BMF_CLEAR OR (flags AND Not(BMF_MAKEMASK))),fb);IF (imbuf.bmap=NIL) THEN Raise("MEM")
	imbuf.li:=NewLayerInfo();IF (imbuf.li=NIL) THEN Raise("MEM")
	LockLayerInfo(imbuf.li)
	imbuf.l:=CreateBehindLayer(imbuf.li,imbuf.bmap,0,0,x-1,y-1,LAYERSMART,NIL);IF (imbuf.l=NIL) THEN Raise("MEM")

	UnlockLayerInfo(imbuf.li)
	imbuf.rast:=imbuf.l.rp
	IF (flag=FALSE)
		imbuf.tempbitmap:=AllocBitMap(x,y,1,(BMF_CLEAR),fb);IF (imbuf.tempbitmap=NIL) THEN Raise("MEM")
		InitTmpRas(imbuf.tmpras,Long(imbuf.tempbitmap+8),((x+31)/32)*y*4)
		imbuf.rast.tmpras:=imbuf.tmpras
		imbuf.areabuf:=AllocMem(AREALEN*6,MEMF_PUBLIC)
		InitArea(imbuf.areainfo,imbuf.areabuf,AREALEN)
		imbuf.rast.areainfo:=imbuf.areainfo
	ELSE
		imbuf.tempbitmap:=0
		imbuf.areabuf:=0
	ENDIF
	IF flags AND BMF_MAKEMASK
		FOR i:=1 TO 7
			imbuf.bmap.planes[i]:=imbuf.bmap.planes[0]
		ENDFOR
		imbuf.bmap.depth:=8
		imbuf.ismask:=TRUE
	ENDIF
ENDPROC

EXPORT PROC disposelayerinfo(imbuf:PTR TO imbuf)
	DEF i
	IF imbuf
	IF (imbuf.li<>0)
		IF (imbuf.l<>0)
			IF (imbuf.l.rp<>0)
				imbuf.l.rp::rastport.areainfo:=0
				imbuf.l.rp::rastport.tmpras:=0
			ENDIF
			LockLayerInfo(imbuf.li)
			DeleteLayer(imbuf.li,imbuf.l);imbuf.l:=0
			UnlockLayerInfo(imbuf.li)
		ENDIF
		DisposeLayerInfo(imbuf.li);imbuf.li:=0
	ENDIF
	IF (imbuf.areabuf<>0)
		FreeMem(imbuf.areabuf,6*AREALEN)
		imbuf.areabuf:=0
	ENDIF
	IF (imbuf.tempbitmap<>0)
		WaitBlit()
		FreeBitMap(imbuf.tempbitmap)
		imbuf.tempbitmap:=0
	ENDIF
	IF imbuf.bmap
		IF (imbuf.ismask)
			imbuf.bmap.depth:=1
			FOR i:=1 TO 7
				imbuf.bmap.planes[i]:=0
			ENDFOR
		ENDIF
		WaitBlit()
		FreeBitMap(imbuf.bmap)
	ENDIF
	imbuf.bmap:=0
	imbuf.rast:=0
	ENDIF
ENDPROC

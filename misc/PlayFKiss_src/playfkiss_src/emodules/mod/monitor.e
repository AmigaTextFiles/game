OPT MODULE

MODULE	'graphics/gfx','graphics/displayinfo'

EXPORT PROC findbestmode(musthavemask,mustnothavemask,width,height,depth,aspectx,aspecty,wantkey=0)
	DEF lastid=-1,nextid:PTR TO displayinfo
	DEF dim:PTR TO dimensioninfo
	DEF dis:PTR TO displayinfo
	DEF bestscore=0,bestid=-1
	DEF score
	DEF ax,ay,visw,vish

	dim:=New(1000)
	dis:=New(1000)
	REPEAT
		nextid:=NextDisplayInfo(lastid)
		IF (nextid>0)
			score:=0
			GetDisplayInfoData(0,dis,900,DTAG_DISP,nextid)
			IF dis.notavailable=0
->WriteF('\n\z\h[8] \z\h[8]',nextid,dis.propertyflags)
				GetDisplayInfoData(0,dim,900,DTAG_DIMS,nextid)
->WriteF('  <\d[4],\d[4] \d[4],\d[4] \d[4],\d[4]> ',dim.maxoscan.minx,dim.maxoscan.miny,dim.maxoscan.maxx,dim.maxoscan.maxy,dim.maxoscan.maxx-dim.maxoscan.minx,dim.maxoscan.maxy-dim.maxoscan.miny)
				visw:=(dim.stdoscan.maxx-dim.stdoscan.minx)
				vish:=(dim.stdoscan.maxy-dim.stdoscan.miny)
->				score:=score+((visw-width)/100)
->				score:=score+((vish-height)/100)
->WriteF('\n!score=\d  ',score)				
->				score:=score+ (dim.stdoscan.maxx-dim.stdoscan.minx)/100
->				score:=score+ (dim.stdoscan.maxy-dim.stdoscan.miny)/100

				IF (dim.stdoscan.maxx-dim.stdoscan.minx)=width THEN score:=score+500
				IF (dim.stdoscan.maxy-dim.stdoscan.miny)=height THEN score:=score+500
->WriteF('{\d,\d}',dis.resolution.x,dis.resolution.y)

->WriteF('@score=\d  ',score)				
				IF (aspectx*100/aspecty)=(dis.resolution.x*100/dis.resolution.y) THEN score:=score+2000
->WriteF('#score=\d  ',score)				
				IF ((nextid AND wantkey)=wantkey) THEN score:=score+1001	-> Even if wantkey=0 then *all modes* get +100
->WriteF('$score=\d  ',score)				
				IF ((nextid AND musthavemask)<>musthavemask)
					score:=0
				ENDIF
				IF ((nextid AND mustnothavemask)<>0) THEN score:=0
				IF (dim.maxdepth<depth) THEN score:=0
				IF (dim.minrasterwidth>width) OR (dim.minrasterheight>height) THEN score:=0
				IF (dim.maxrasterwidth<width) OR (dim.maxrasterheight<height) THEN score:=0
				IF score>bestscore
					bestscore:=score
					bestid:=nextid
					ax:=dim.stdoscan.maxx-dim.stdoscan.minx
					ay:=dim.stdoscan.maxy-dim.stdoscan.miny
->WriteF('!!!!!!!!!!')
				ENDIF
			ENDIF
		ENDIF
		lastid:=nextid
	UNTIL (nextid=-1)
	Dispose(dim)
	Dispose(dis)
ENDPROC bestid,ax,ay

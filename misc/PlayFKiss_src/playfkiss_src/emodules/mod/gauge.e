OPT MODULE

MODULE	'mod/gadgets'
MODULE	'mod/fonts'
MODULE	'mod/compare'

MODULE	'gadtools','libraries/gadtools'
MODULE	'intuition/intuition','intuition/gadgetclass'
MODULE	'graphics/gfx','graphics/rastport','graphics/text'
MODULE  'intuition/screens','intuition/gadgetclass'

OBJECT newgauge
	rast:PTR TO rastport
	x:INT
	y:INT
	w:INT
	h:INT
	textfont:PTR TO textfont
	textstyle:LONG
	visual:LONG
	drawinfo:PTR TO drawinfo
	lastx:INT
	type:INT
ENDOBJECT

EXPORT CONST GAUGETYPE_PLAIN=0,GAUGETYPE_FANCY=1

EXPORT PROC newgauge(rast,x,y,w,h,textfont,textstyle,visual,drawinfo,type=GAUGETYPE_PLAIN)
	DEF gauge:PTR TO newgauge
	gauge:=New(SIZEOF newgauge)
	gauge.rast:=rast
	gauge.x:=x
	gauge.y:=y
	gauge.w:=w
	gauge.h:=h
	gauge.textfont:=textfont
	gauge.textstyle:=textstyle
	gauge.visual:=visual
	gauge.drawinfo:=drawinfo
	gauge.type:=type
	gauge.lastx:=-1
ENDPROC gauge

EXPORT PROC endgauge(gauge)
	IF gauge THEN Dispose(gauge)
ENDPROC

EXPORT PROC cleargauge(gauge:PTR TO newgauge)
	drawbevelbox(gauge.visual,gauge.rast,gauge.x,gauge.y,gauge.w,gauge.h,1,TRUE,0)
	gauge.lastx:=-1
ENDPROC

EXPORT PROC statusgauge(gauge:PTR TO newgauge,string)
	IF (string)
		IF StrLen(string)
			cleargauge(gauge)
			textgauge(gauge,string)
		ENDIF
	ENDIF
ENDPROC

PROC textgauge(gauge:PTR TO newgauge,string)
	DEF w,h,i
	w,h:=fontsize2(gauge.rast,string,gauge.textfont,gauge.textstyle)
	SetFont(gauge.rast,gauge.textfont)
	SetDrMd(gauge.rast,RP_JAM1)

	Move(gauge.rast,gauge.x+((gauge.w)/2)-(w/2),gauge.y+gauge.textfont.baseline+1)
	SetAPen(gauge.rast,Int(gauge.drawinfo.pens+(TEXTPEN*2)))
	Text(gauge.rast,string,StrLen(string))

ENDPROC

EXPORT PROC fuelgauge(gauge:PTR TO newgauge,quant,max,string=0,ignorelast=FALSE)
	DEF newx
	IF ((gauge>0) AND (max>0))
		IF ignorelast=TRUE THEN gauge.lastx:=0
		SetAPen(gauge.rast,Int(gauge.drawinfo.pens+(FILLPEN*2)))
		newx:=((((gauge.w-7)*100)/(10000/(bigger((quant*100/(max)),1)))))
		IF newx>gauge.lastx
			IF gauge.lastx=-1 THEN gauge.lastx:=0
			SetDrMd(gauge.rast,RP_JAM2)
			RectFill(gauge.rast,gauge.x+gauge.lastx+3,gauge.y+2,gauge.x+newx+3,gauge.y+gauge.h-3)
			IF gauge.type=GAUGETYPE_FANCY
				qwikbox(gauge,2,1,4)
				qwikbox(gauge,4,1,3)
				qwikbox(gauge,4,3,3)
				qwikbox(gauge,8,1,2)
				qwikbox(gauge,8,3,2)
				qwikbox(gauge,8,5,2)
				qwikbox(gauge,8,7,2)
			ENDIF
			IF (string) THEN textgauge(gauge,string)
		ELSE
			IF newx<gauge.lastx
				cleargauge(gauge)
				fuelgauge(gauge,quant,max,string,ignorelast)
			ENDIF
		ENDIF
		gauge.lastx:=newx
	ENDIF
ENDPROC

PROC qwikbox(gauge:PTR TO newgauge,div,mul,height)
	drawbevelbox(gauge.visual,gauge.rast,gauge.x+((((gauge.w*100)/(div))*mul)/100),gauge.y+gauge.h-height-1,2,height,0)
ENDPROC

OPT MODULE
OPT EXPORT

MODULE	'graphics','graphics/text','graphics/gfx'
MODULE	'mod/compare'

PROC fontsize2(rast,str,textfont2:PTR TO textfont,style)
	DEF w=0,h=0,xor=0
	DEF textextent:PTR TO textextent
	NEW textextent
	IF ((textfont2<>0) AND (rast<>0))
		xor:=xor OR (IF ((textfont2.style AND 1)<>(style AND 1)) THEN 1 ELSE 0)
		xor:=xor OR (IF ((textfont2.style AND 2)<>(style AND 2)) THEN 2 ELSE 0)
		xor:=xor OR (IF ((textfont2.style AND 4)<>(style AND 4)) THEN 4 ELSE 0)
		SetFont(rast,textfont2)
		SetSoftStyle(rast,xor,7)
		TextExtent(rast,str,StrLen(str),textextent)

		w:=Abs(textextent.extent.minx)+Abs(textextent.extent.maxx)+1
		h:=Abs(textextent.extent.miny)+Abs(textextent.extent.maxy)+1


/*		IF xor AND FSF_BOLD THEN w:=w+1
		IF xor AND FSF_UNDERLINED THEN w:=w+2
		IF xor AND FSF_ITALIC THEN w:=w+4*/
	ENDIF
	END textextent
ENDPROC w,h

PROC biggest(rast,tags:PTR TO LONG,textfont,style)
	DEF w=0,h=0,nw,nh
	WHILE tags[0]<>0
		nw,nh:=fontsize2(rast,tags[0],textfont,style)
		w:=bigger(w,nw)
		h:=bigger(h,nh)
		tags:=tags+4
	ENDWHILE
ENDPROC w,h


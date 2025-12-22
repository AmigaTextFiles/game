OPT MODULE
OPT EXPORT

MODULE	'graphics/rastport'
MODULE	'intuition/intuition'

PROC setafpt(rast:PTR TO rastport,pattern,size)
	IF rast
		rast.areaptrn:=pattern
		rast.areaptsz:=size
	ENDIF
ENDPROC

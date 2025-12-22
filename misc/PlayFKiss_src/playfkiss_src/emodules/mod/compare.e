OPT MODULE
OPT EXPORT

PROC bigger(a,max) IS IF (a<max) THEN max ELSE a
PROC smaller(a,min) IS IF (a>min) THEN min ELSE a
PROC limit(a,min,max)
	IF a<min THEN a:=min
	IF a>max THEN a:=max
ENDPROC a
EXPORT PROC inside(dx,dy,x1,y1,w,h) IS ((dx>=x1) AND (dx<=(x1+w)) AND (dy>=y1) AND (dy<=(y1+h)))

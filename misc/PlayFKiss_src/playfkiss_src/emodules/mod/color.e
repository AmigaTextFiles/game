OPT MODULE

MODULE	'graphics'
MODULE	'mod/bits'

EXPORT PROC exchangecolorcmap(cmap,c1,c2)
	DEF buf
	buf:=New(32)
	GetRGB32(cmap,c1,1,buf)
	GetRGB32(cmap,c2,1,buf+12)
	SetRGB32CM(cmap,c2,Long(buf),Long(buf+4),Long(buf+8))
	SetRGB32CM(cmap,c1,Long(buf+12),Long(buf+16),Long(buf+20))
	Dispose(buf)
ENDPROC

EXPORT PROC findcolorbytes(cmap,byte_red,byte_grn,byte_blu,highpen) IS FindColor(cmap,byte2long(byte_red),byte2long(byte_grn),byte2long(byte_blu),highpen)

OPT MODULE
OPT EXPORT

PROC long2byte(long)
	long:=(Shr(Shr(Shr(long AND $FF000000,8),8),8)) AND $FF
ENDPROC long
PROC byte2long(byte)
	MOVE.L	byte,D0
	AND.L		#$FF,D0
	MOVE.L	D0,D1
	LSL.L		#8,D1
	OR.L		D1,D0
	MOVE.L	D0,D1
	SWAP		D1
	OR.L		D1,D0
	MOVE.L	D0,byte
/*
	byte:=(byte AND $FF)
	byte:=Shl(byte,8) OR byte
	byte:=Shl(byte,8) OR byte
	byte:=Shl(byte,8) OR byte
*/
ENDPROC byte

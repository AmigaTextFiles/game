OPT MODULE

EXPORT PROC pack_rlen(inbuf,outbuf,inlen,outlen)
	DEF start:PTR TO CHAR
	DEF end:PTR TO CHAR
	DEF cur:PTR TO CHAR
	DEF dest:PTR TO CHAR
	start:=inbuf
	dest:=outbuf
	cur:=inbuf
	REPEAT
		IF ((start[0]=start[1]) AND (start[1]=start[2]))
			start,dest:=writerepeat(start,dest,inlen-(start-inbuf))
		ELSE
			start,dest:=writeverbatim(start,dest,inlen-(start-inbuf))
		ENDIF
	UNTIL (start-inbuf)>=inlen
ENDPROC dest-outbuf+1

PROC writerepeat(start:PTR TO CHAR,dest:PTR TO CHAR,inlen)
	DEF last:PTR TO CHAR
	last:=start
	REPEAT
		last:=last+1
	UNTIL ((last[0]<>start[0]) OR ((last-start)=inlen))
	dest[0]:=0-(last-start-1)
	dest[1]:=start[0]
ENDPROC last,dest+2

PROC writeverbatim(start:PTR TO CHAR,dest:PTR TO CHAR,inlen)
	DEF last:PTR TO CHAR
	last:=start
	REPEAT
		last:=last+1
	UNTIL (((last[0]=last[1]) AND (last[1]=last[2])) OR ((last-start)=inlen))
	dest[0]:=last-start-1
	dest:=dest+1
	REPEAT
		dest[0]:=start[0]
		dest:=dest+1
		start:=start+1
	UNTIL start=last
ENDPROC last,dest

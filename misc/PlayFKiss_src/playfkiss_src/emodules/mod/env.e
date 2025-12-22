OPT MODULE
OPT EXPORT

PROC getenvstring(str,defstr)
	DEF buffer[3000]:STRING
	IF ((GetVar(str,buffer,2990,0))>0)
		IF defstr
			StrCopy(defstr,buffer,ALL)
			RETURN TRUE
		ENDIF
	ENDIF	
ENDPROC FALSE

PROC getenvvar(str,def=0)
	DEF buffer
	buffer:=New(2000)
	IF ((GetVar(str,buffer,1900,0))>0) THEN StrToLong(buffer,{def})
	Dispose(buffer)
ENDPROC def

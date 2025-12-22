OPT MODULE
OPT EXPORT

MODULE	'mod/filenames'
MODULE	'mod/env'
MODULE	'dos/dos'

PROC findfile(filename,paths)
	DEF str[1000]:STRING,envstr[1000]:STRING
	DEF lock
	IF paths
		WHILE Long(paths)
			IF Char(Long(paths))="$"
				StrCopy(str,Long(paths)+1,ALL)
				IF (getenvstring(str,envstr))
					StrCopy(str,envstr,ALL)
					eaddpart(str,filename,990)
				ELSE
					StrCopy(str,'',ALL)
				ENDIF
			ELSE
				StrCopy(str,Long(paths),ALL)
				eaddpart(str,filename,990)
			ENDIF
			IF StrLen(str)
				lock:=Lock(str,ACCESS_READ)
				IF lock
					UnLock(lock)
					StrCopy(filename,str,ALL)
					RETURN TRUE
				ENDIF
			ENDIF
			paths:=paths+4
		ENDWHILE
	ENDIF
ENDPROC FALSE

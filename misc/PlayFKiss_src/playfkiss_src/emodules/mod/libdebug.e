
OPT MODULE
OPT EXPORT

MODULE	'dos/dos'

PROC debug()
	stdout:=Open('CON:80/300/520/180/DEBUGGING OUTPUT/CLOSE',MODE_NEWFILE)
ENDPROC

PROC enddebug()
	IF stdout
		Close(stdout)
		stdout:=0
	ENDIF
ENDPROC

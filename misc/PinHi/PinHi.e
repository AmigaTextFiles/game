/* PinHi - show highscores of DI's Pinball Illusions
doesn't use nonvolatile.library although it *should* (anyone send me the
NV-Autodocs and -Includes?) */

OPT OSVERSION=36

MODULE 'dos/dos'

DEF buff[50]:ARRAY

PROC main()
DEF ver,nv_loc[120]:ARRAY,lock,oldlock

	ver:='$VER: PinHi 1.0 (1.11.95)'

	IF (GetVar('ENV:Sys/nv_location',nv_loc,120,0))>0

		IF lock:=Lock(nv_loc,ACCESS_READ)
			oldlock:=CurrentDir(lock)
			IF gethi(1) THEN outputhi(' Law ''n Justice\n\n')
			IF gethi(2) THEN outputhi(' BabeWatch\n\n')
			IF gethi(3) THEN outputhi(' Extreme Sports\n\n')
			WriteF('\n')
			CurrentDir(oldlock)
			UnLock(lock)
		ENDIF
	ENDIF
ENDPROC

PROC gethi(table)
DEF filename[30]:ARRAY,fh
	StringF(filename,'PinballIllusions/table00\d',table)
	IF fh:=Open(filename,MODE_OLDFILE)
		Read(fh,buff,50)
		Close(fh)
		RETURN 1
	ENDIF
ENDPROC 0

PROC outputhi(tablename)
DEF name[3]:STRING,pos,score[14]:ARRAY,d

	WriteF('\n')
	WriteF(tablename)

	pos:=0
	WHILE pos<50
		MidStr(name,buff,pos,3)
		WriteF(' \d. ',pos/10+1)
		WriteF('\s',name)

		CopyMem(buff+4+pos,score,14)
		MOVE.L score,A0
		d:=0
		MOVE.L (A0),d
		WriteF('\h[8]',d)

		MOVE.L score,A0
		d:=0
		MOVEQ #0,D0
		MOVE.W 4(A0),D0
		MOVE.L D0,d
		WriteF('\z\h[4]\n',d)

		pos:=pos+10
	ENDWHILE
ENDPROC

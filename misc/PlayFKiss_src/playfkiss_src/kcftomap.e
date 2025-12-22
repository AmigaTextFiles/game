
MODULE 'dos/dos'

DEF rdarg
DEF argarray[11]:LIST
DEF source[150]:STRING
DEF dest[150]:STRING
DEF dummy[250]:STRING
DEF fh1,fh2,res,i
DEF red,grn,blu
DEF buffer

PROC main() HANDLE
	buffer:=New(1000)
	argarray[0]:=0
	argarray[1]:=0
	rdarg:=ReadArgs('FROM/A,TO',argarray,0)

	IF argarray[0]<>NIL
		StrCopy(source,argarray[0],ALL)
	ENDIF
	IF argarray[1]<>NIL
		StrCopy(dest,argarray[1],ALL)
		IF StrLen(dest)<1
			StrCopy(dest,source,ALL)
			i:=InStr(UpperStr(dest),'.KCF')
			StrCopy(dest,source,i)
			StrAdd(dest,'.map',ALL)
		ENDIF
	ENDIF

WriteF('Translating "\s" to "\s"...\n',source,dest)

	IF rdarg>0
		IF (fh1:=Open(source,MODE_OLDFILE))
			IF (fh2:=Open(dest,MODE_NEWFILE))
				PutLong(buffer,$50360A31)       -> P6 nl 1
				PutLong(buffer+4,$3620310A)     -> 6 space 1 nl
				PutLong(buffer+8,$3235350A)     -> 255 nl
				res:=Write(fh2,buffer,12)
				IF res<0 THEN Raise("DOS")
				FOR i:=0 TO 15
					res:=Read(fh1,buffer,2)
					IF res<0 THEN Raise("DOS")

					red:=Shl((Shr(Char(buffer),4) AND %00001111),4)
					blu:=Shl((Char(buffer) AND %00001111),4)
					grn:=Shl((Char(buffer+1) AND %00001111),4)

					PutChar(buffer,red)
					PutChar(buffer+1,grn)
					PutChar(buffer+2,blu)

					res:=Write(fh2,buffer,3)
					IF res<0 THEN Raise("DOS")
				ENDFOR
			ELSE
				Raise("DOS")
			ENDIF
		ELSE
			Raise("DOS")
		ENDIF
	ELSE
		Raise("DOS")
	ENDIF
EXCEPT DO
	WriteF('\n\h \h \n\n',fh1,fh2)
	IF fh1 THEN Close(fh1)
	IF fh2 THEN Close(fh2)
	IF buffer THEN Dispose(buffer)
	IF exception THEN WriteF('An error occured.\n\n')
ENDPROC

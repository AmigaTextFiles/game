
MODULE 'dos/dos'

DEF rdarg
DEF argarray[11]:LIST
DEF source[250]:STRING
DEF dest[250]:STRING
DEF palette[250]:STRING
DEF dummy[250]:STRING
DEF fh1,fh2,fh3,res,i,t,offset
DEF re[18]:LIST,gr[18]:LIST,bl[18]:LIST
DEF red,grn,blu
DEF buffer,buffer2
DEF x,y,w,h,nw
DEF long
DEF r1,g1,b1,r2,g2,b2
DEF res1,res2

RAISE "^C" IF CtrlC ()=TRUE

PROC ibmconv(a)
	DEF hi,lo,ret
	hi:=a AND $FF00
	lo:=a AND $00FF
	ret:=Shl(lo,8) OR Shr(hi,8)
ENDPROC ret

PROC readstring(fh,buf)
	DEF ret=0,bp=0

	PutLong(buf,0)
	PutLong(buf+4,0)
	Read(fh,buf+bp,1);bp:=bp+1
	WHILE (iswhitespace(Char(buf+bp-1))=0)
		Read(fh,buf+bp,1);bp:=bp+1
		CtrlC()
	ENDWHILE
	PutChar(buf+bp-1,0)
	StrToLong(buf,{ret})
ENDPROC ret

PROC iswhitespace(a)
	IF a=10 THEN RETURN TRUE
	IF a=9 THEN RETURN TRUE
	IF a=13 THEN RETURN TRUE
	IF a=32 THEN RETURN TRUE
	IF a="," THEN RETURN TRUE
ENDPROC FALSE

PROC main() HANDLE
	buffer:=New(10000)
	buffer2:=New(700*6)
	argarray[0]:=0
	argarray[1]:=0
	argarray[2]:=0
	rdarg:=ReadArgs('FROM/A,TO,KCF/A',argarray,0)

	IF argarray[0]>NIL
		StrCopy(source,argarray[0],ALL)
	WriteF('\h  ',argarray[0])
	ELSE
		Raise("HELP")
	ENDIF
	IF argarray[1]>NIL
		StrCopy(dest,argarray[1],ALL)
		IF StrLen(dest)<1
			StrCopy(dest,source,ALL)
			i:=InStr(UpperStr(dest),'.CEL')
			StrCopy(dest,source,i)
			StrAdd(dest,'.ppm',ALL)
		ENDIF
	ELSE
		StrCopy(dest,source,ALL)
		i:=InStr(UpperStr(dest),'.CEL')
		StrCopy(dest,source,i)
		StrAdd(dest,'.ppm',ALL)
	ENDIF
	IF argarray[2]>NIL
		StrCopy(palette,argarray[2],ALL)
	ELSE
		Raise("HELP")
	ENDIF

WriteF('Translating "\s" to "\s"...\n',source,dest)
	CtrlC()
	IF rdarg>0
		IF (fh3:=Open(palette,MODE_OLDFILE))
			Read(fh3,buffer,32)
			IF StrCmp(buffer,'KiSS',4) THEN Read(fh3,buffer,32)
			t:=0
			FOR i:=0 TO 31 STEP 2
        red:=(Char(buffer+i) AND $F0)
        blu:=Shl((Char(buffer+i) AND $0F),4)
        grn:=Shl((Char(buffer+i+1) AND $0F),4)
        re[i/2]:=red;gr[i/2]:=grn;bl[i/2]:=blu
      ENDFOR
			CtrlC()
			IF (fh1:=Open(source,MODE_OLDFILE))
				IF (fh2:=Open(dest,MODE_NEWFILE))
					Read(fh1,buffer,4)
					IF StrCmp(buffer,'KiSS',4)
						Read(fh1,buffer,28)
						w:=ibmconv(Int(buffer+4))
						h:=ibmconv(Int(buffer+6))
					ELSE
						w:=ibmconv(Int(buffer))
						h:=ibmconv(Int(buffer+2))
					ENDIF

WriteF('Source image size= \d x \d \n',w,h)

					StringF(dummy,'P6\n\d \d \d\n',w,h,255)
					Write(fh2,dummy,StrLen(dummy))

					FOR y:=0 TO h-1
						res:=Read(fh1,buffer,w/2)
						IF (res<0) THEN Raise("DOS")
						CtrlC()
						FOR x:=0 TO ((w-1)/2)

							r1:=Shr((Char(buffer+x) AND $F0),4)
							r2:=Char(buffer+x) AND $0F

							PutChar(buffer2+(x*6),re[r1])
							PutChar(buffer2+(x*6)+1,gr[r1])
							PutChar(buffer2+(x*6)+2,bl[r1])
							PutChar(buffer2+(x*6)+3,re[r2])
							PutChar(buffer2+(x*6)+4,gr[r2])
							PutChar(buffer2+(x*6)+5,bl[r2])

						ENDFOR
						Write(fh2,buffer2,w*3)
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
	ELSE
		Raise("NONE")
	ENDIF
EXCEPT DO
	IF rdarg THEN FreeArgs(rdarg)
	IF fh1 THEN Close(fh1)
	IF fh2 THEN Close(fh2)
	IF fh3 THEN Close(fh3)
	IF buffer THEN Dispose(buffer)
	IF buffer2 THEN Dispose(buffer2)
	IF exception="DOS" THEN WriteF('An error occured.\n\n')
	IF exception="HELP" THEN WriteF('Usage: celtoppm FROM\\A,TO,KCF\\A\n\n')
	IF exception="PAL" THEN WriteF('Colors do not match.  Use "ppmquant -map".\n\n')
	IF exception="P6P6" THEN WriteF('Map file contains more than 16 colors.\n\n')
	IF exception="NOP6" THEN WriteF('Map file is invalid.\n\n')
	IF exception="NOP5" THEN WriteF('Source file is invalid.\n\n')
ENDPROC

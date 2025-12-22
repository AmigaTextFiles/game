
MODULE 'dos/dos'

CONST FILE_MARK_CELL=$20,FILE_MARK_PALET=$10
DEF rdarg
DEF argarray[21]:LIST
DEF source[250]:STRING
DEF dest[250]:STRING
DEF palette[250]:STRING
DEF dummy[250]:STRING
DEF fh1,fh2,fh3,res,i,t,offset
DEF re[18]:LIST,gr[18]:LIST,bl[18]:LIST
DEF red,grn,blu
DEF buffer
DEF x,y,w,h,nw
DEF long
DEF r1,g1,b1,r2,g2,b2
DEF res1,res2
DEF xoff=0,yoff=0,oldmode=FALSE
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
	argarray[0]:=0
	argarray[1]:=0
	argarray[2]:=0
	argarray[3]:=0
	argarray[4]:=0
	argarray[5]:=0
	rdarg:=ReadArgs('FROM/A,TO,MAP/A,X/N,Y/N,OLD/S',argarray,0)

	IF argarray[0]<>NIL
		StrCopy(source,argarray[0],ALL)
	ELSE
		Raise("HELP")
	ENDIF
	IF argarray[1]<>NIL
		StrCopy(dest,argarray[1],ALL)
		IF StrLen(dest)<1
			StrCopy(dest,source,ALL)
			i:=InStr(UpperStr(dest),'.PPM')
			StrCopy(dest,source,i)
			StrAdd(dest,'.CEL',ALL)
		ENDIF
	ELSE
		StrCopy(dest,source,ALL)
		i:=InStr(UpperStr(dest),'.PPM')
		StrCopy(dest,source,i)
		StrAdd(dest,'.CEL',ALL)
	ENDIF
	IF argarray[2]<>NIL
		StrCopy(palette,argarray[2],ALL)
	ELSE
		Raise("HELP")
	ENDIF
	IF argarray[3]<>NIL THEN xoff:=argarray[3];xoff:=^xoff
	IF argarray[4]<>NIL	THEN yoff:=argarray[4];yoff:=^yoff
	IF argarray[5]<>NIL THEN oldmode:=TRUE
	IF (rdarg<>0)
WriteF('Translating "\s" to "\s"...\n',source,dest)
		IF (fh3:=Open(palette,MODE_OLDFILE))
			Read(fh3,buffer,60)
			IF Int(buffer)<>"P6" THEN Raise("NOP6")
			t:=0
			FOR i:=2 TO 59
				IF ((Char(buffer+i)=10) OR (Char(buffer+i)=32) OR (Char(buffer+i)=13) OR (Char(buffer+i)=9)) THEN t:=t+1
        IF (t=4)
					offset:=i+1;t:=5
				ENDIF
      ENDFOR
			FOR i:=0 TO 15
        red:=(Char(buffer+offset+(i*3)) AND $F0)
        grn:=(Char(buffer+offset+(i*3)+1) AND $F0)
        blu:=(Char(buffer+offset+(i*3)+2) AND $F0)
        re[i]:=red;gr[i]:=grn;bl[i]:=blu
      ENDFOR
			IF (fh1:=Open(source,MODE_OLDFILE))
				IF (fh2:=Open(dest,MODE_NEWFILE))
					Read(fh1,buffer,3)
					IF Int(buffer)<>"P6" THEN Raise("NOP5")
					w:=readstring(fh1,buffer)
					h:=readstring(fh1,buffer)
					i:=readstring(fh1,buffer)

					nw:=Shl(Shr(w+1,1),1)

WriteF('Source image size= \d x \d x \d \n',w,h,i)

					IF oldmode=TRUE
						PutInt(buffer,ibmconv(nw))
						PutInt(buffer+2,ibmconv(h))
						Write(fh2,buffer,4)
					ELSE
						PutLong(buffer,"KiSS")
						PutChar(buffer+4,FILE_MARK_CELL)
						PutChar(buffer+5,4)
						PutInt(buffer+8,ibmconv(nw))
						PutInt(buffer+10,ibmconv(h))
						PutInt(buffer+12,ibmconv(xoff))
						PutInt(buffer+14,ibmconv(yoff))
						Write(fh2,buffer,32)
					ENDIF

					FOR y:=0 TO h-1
						res:=Read(fh1,buffer,w*3)
						IF (res<0) THEN Raise("DOS")
						CtrlC()
						FOR x:=0 TO w-1 STEP 2
							r1:=(Char(buffer+(x*3)) AND $F0)
							g1:=(Char(buffer+(x*3)+1) AND $F0)
							b1:=(Char(buffer+(x*3)+2) AND $F0)
							r2:=(Char(buffer+(x*3)+3) AND $F0)
							g2:=(Char(buffer+(x*3)+4) AND $F0)
							b2:=(Char(buffer+(x*3)+5) AND $F0)

							res1:=-1;res2:=-1
							FOR i:=0 TO 15
								IF ((r1=re[i]) AND (g1=gr[i]) AND (b1=bl[i])) THEN res1:=i
								IF ((r2=re[i]) AND (g2=gr[i]) AND (b2=bl[i])) THEN res2:=i
							ENDFOR
							IF ((res1<0) OR (res2<0)) THEN Raise("PAL")
							PutChar(buffer+(x/2),(Shl((res1 AND $F),4) OR (res2 AND $F)))
						ENDFOR
						Write(fh2,buffer,(w/2))
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
	IF fh1 THEN Close(fh1)
	IF fh2 THEN Close(fh2)
	IF fh3 THEN Close(fh3)
	IF buffer THEN Dispose(buffer)
	IF exception="HELP" THEN WriteF('Usage: ppmtocel FROM\\A,TO,MAP\\A\n\n')
	IF exception="DOS" THEN WriteF('An error occured.\n\n')
	IF exception="PAL" THEN WriteF('Colors do not match.  Use "ppmquant -map".\n\n')
	IF exception="P6P6" THEN WriteF('Map file contains more than 16 colors.\n\n')
	IF exception="NOP6" THEN WriteF('Map file is invalid.\n\n')
	IF exception="NOP5" THEN WriteF('Source file is invalid.\n\n')
ENDPROC

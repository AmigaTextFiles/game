

MODULE 'dos/dos','dos/dosextens','dos/dosasl','exec/tasks'

DEF rdarg
DEF argarray[11]:LIST
DEF source[250]:STRING
DEF dest[250]:STRING
DEF palette[250]:STRING
DEF dummy[250]:STRING
DEF array[250]:LIST
DEF fh1,fh2,fh3,res,i,t,offset,names:PTR TO LONG
DEF re[18]:LIST,gr[18]:LIST,bl[18]:LIST,lc=0,toomany=0
DEF red,grn,blu
DEF buffer
DEF x,y,w,h,nw
DEF long
DEF r1,g1,b1,r2,g2,b2
DEF res1,res2
DEF apath=NIL:PTR TO anchorpath

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

PROC dofindcolors(str)
	DEF fileinfo=NIL:PTR TO fileinfoblock
	DEF achain=NIL:PTR TO achain
	DEF err=0,pathlen,filestart,first=0,chance=1
	DEF newdate=NIL:PTR TO datestamp

	apath:=New(SIZEOF anchorpath)

	WHILE err=NIL
		IF first=FALSE
			err:=MatchFirst(str,apath)
			first:=TRUE
		ELSE
			err:=MatchNext(apath)
		ENDIF
		IF err=NIL
			achain:=apath.last
			IF (achain)
				fileinfo:=achain.info
				IF (fileinfo)
					IF (fileinfo.direntrytype)<0
						doscan(fileinfo.filename)
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDWHILE
	IF apath THEN MatchEnd(apath)
	IF apath THEN Dispose(apath);apath:=NIL
ENDPROC

PROC doscan(file)
	WriteF('\nScanning file "\s"...',file)
	IF (fh1:=Open(file,MODE_OLDFILE))
		Read(fh1,buffer,3)
		IF Int(buffer)="P6"
			PrintF('File type OK.\n')
			w:=readstring(fh1,buffer)
			h:=readstring(fh1,buffer)
			i:=readstring(fh1,buffer)
			WriteF('size: (\d x \d x \d)',w,h,i)
			FOR y:=0 TO h-1
				res:=Read(fh1,buffer,w*3)
				IF res>=0
					FOR x:=0 TO w-1
						r1:=((Char(buffer+(x*3))) AND $F0)
						g1:=((Char(buffer+(x*3)+1)) AND $F0)
						b1:=((Char(buffer+(x*3)+2)) AND $F0)
						IF exi(r1,g1,b1)=0
							re[lc]:=(r1 AND $F0)
							gr[lc]:=(g1 AND $F0)
							bl[lc]:=(b1 AND $F0)
							IF lc<16
								INC lc
WriteF('\n($\h\h\h) ',r1,g1,b1)
							ELSE
								toomany:=TRUE
							ENDIF
						ENDIF
					ENDFOR
				ENDIF
			ENDFOR
		ELSE
			Raise("NOP6")
		ENDIF
		Close(fh1);fh1:=0
	ENDIF
ENDPROC

PROC exi(r,g,b)
	DEF tt
	FOR tt:=0 TO lc
		IF ((re[tt]=r) AND (gr[tt]=g) AND (bl[tt]=b)) THEN RETURN TRUE
	ENDFOR
ENDPROC FALSE

PROC main() HANDLE
	buffer:=New(10000)
	argarray[0]:=0
	argarray[1]:=0
	rdarg:=ReadArgs('FROM/A/M,TO/A',argarray,0)

	IF argarray[0]=NIL
		Raise("HELP")
	ENDIF
	IF argarray[1]<>NIL
		StrCopy(dest,argarray[1],ALL)
	ELSE
		Raise("HELP")
	ENDIF
	IF (rdarg<>0)
		names:=argarray[0]
		WHILE (names[0])
WriteF('\n\nSearching for "\s"',names[0])
			dofindcolors(names[]++)
		ENDWHILE
	ENDIF

	IF (fh2:=Open(dest,MODE_NEWFILE))

		PutLong(buffer,$50360A31)       -> P6 nl 1
		PutLong(buffer+4,$3620310A)     -> 6 space 1 nl
		PutLong(buffer+8,$3235350A)     -> 255 nl
		res:=Write(fh2,buffer,12)
		FOR i:=0 TO 15
			PutChar(buffer,re[i])
			PutChar(buffer+1,gr[i])
			PutChar(buffer+2,bl[i])
			res:=Write(fh2,buffer,3)
		ENDFOR
		WriteF('\n\nSaved \d colors.',lc)
	ENDIF
EXCEPT DO
	WriteF('\n\n')
	IF toomany THEN WriteF('More than 16 colors were found.\n')
	IF apath THEN MatchEnd(apath)
	IF apath THEN Dispose(apath);apath:=NIL
	IF fh1 THEN Close(fh1)
	IF fh2 THEN Close(fh2)
	IF buffer THEN Dispose(buffer)
	IF exception="HELP" THEN WriteF('Usage: ppmtocel FROM\\A,TO\n\n')
	IF exception="DOS" THEN WriteF('An error occured.\n\n')
	IF exception="PAL" THEN WriteF('Colors do not match.  Use "ppmquant -map".\n\n')
	IF exception="P6P6" THEN WriteF('Map file contains more than 16 colors.\n\n')
	IF exception="NOP6" THEN WriteF('Map file is invalid.\n\n')
	IF exception="NOP5" THEN WriteF('Source file is invalid.\n\n')
ENDPROC

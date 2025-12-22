
MODULE 'dos/dos','dos/dosextens','dos/dosasl','exec/tasks'

CONST FILE_MARK_CELL=$20,FILE_MARK_PALET=$10
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
DEF noclip=FALSE,nopad=FALSE
DEF newmode=0	-> To NEW format, only.  IF TRUE then to OLD format only.
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
	DEF	achain=NIL:PTR TO achain
	DEF err=0,pathlen,filestart,first=0,chance=1
	DEF	newdate=NIL:PTR TO datestamp

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
	DEF offx=0,offy=0,w=0,h=0,ib1=0,ib2=0
	DEF i,t,ii,tt,fx=5000,fy=5000
	DEF nw,nh
	WriteF('\nScanning file "\s"...',file)
	IF (fh1:=Open(file,MODE_OLDFILE))
		Read(fh1,buffer,4)
		IF Long(buffer)="KiSS"		-> Convert from G6 to 224c
			IF (newmode=TRUE)
				Read(fh1,buffer,28)
				IF Char(buffer)=FILE_MARK_CELL
					w:=((Char(buffer+ 5)*256)+Char(buffer+ 4))
					h:=(Char(buffer+7)*256)+Char(buffer+6)
					offx:=Char(buffer+9)*256+Char(buffer+8)
					offy:=Char(buffer+11)*256+Char(buffer+10)
					IF (smaller(bigger(Char(buffer+1),4),8))=4
						ib1:=New((offx+w)*(offy+h))
						IF ib1
							FOR t:=offy TO offy+h-1
								Read(fh1,buffer,(w-1)/2)
								FOR i:=offx TO offx+w-1 STEP 2
									PutChar(ib1+(t*(offx+w))+i,Shr(Char((buffer+(i/2)) AND $F0),4))
									PutChar(ib1+(t*(offx+w))+i+1,(Char((buffer+(i/2)) AND $F)))
								ENDFOR
							ENDFOR
							Close(fh1);fh1:=0
							fh2:=Open(file,MODE_NEWFILE)
							IF fh2
								WriteF(' writing.\n')
								PutInt(buffer,ibmconv(w+offx))
								PutInt(buffer+2,ibmconv(h+offy))
								Write(fh2,buffer,4)
								Write(fh2,ib1,((offx+w)*(offy+h)))
							ELSE
								WriteF(' could not open destination file.\n')
							ENDIF
						ELSE
							WriteF(' not enough memory.\n')
						ENDIF
					ELSE
						WriteF(' cannot be converted. (256 colors)\n')
					ENDIF
				ELSE
					WriteF(' not a CELL file.\n')
				ENDIF
			ELSE
				WriteF(' already G6 format.\n')
			ENDIF
		ELSE
			w:=ibmconv(Int(buffer))
			h:=ibmconv(Int(buffer+2))
			IF ((w>0) AND (w<800) AND (h>0) AND (h<600))
				IF newmode=FALSE
					ib1:=New(w*h)
					IF ib1
						FOR t:=0 TO h-1
							Read(fh1,buffer,w/2)
							FOR i:=0 TO w-1 STEP 2
								PutChar(ib1+(w*t)+i,Shr(Char(buffer+(i/2)) AND $F0,4))
								PutChar(ib1+(w*t)+i+1,(Char(buffer+(i/2)) AND $F))
							ENDFOR
						ENDFOR
						Close(fh1);fh1:=0
						FOR t:=0 TO h
							FOR i:=0 TO w
								IF Char(ib1+(t*(w))+i)>0
									fx:=smaller(fx,i)
									fy:=smaller(fy,t)
								ENDIF
							ENDFOR
						ENDFOR
						fx:=limit(fx,0,w)
						fy:=limit(fy,0,h)
						IF ((nw/2)<>((nw+1)/2))
							nw:=nw/2*2
						ENDIF
						IF ((nh/2)<>((nh+1)/2))
							nh:=nh/2*2
						ENDIF
						nw:=limit(w-fx,0,w)
						nh:=limit(h-fy,0,h)
							fh2:=Open(file,MODE_NEWFILE)
							IF fh2
								WriteF(' stripped(\d,\d)--writing.\n',w-nw,h-nh)
								FOR i:=0 TO 31;PutChar(buffer+i,0);ENDFOR
								PutLong(buffer,"KiSS")
								PutChar(buffer+4,FILE_MARK_CELL)
								PutChar(buffer+5,4)
								PutInt(buffer+8,ibmconv(nw))
								PutInt(buffer+10,ibmconv(nh))
								PutInt(buffer+12,ibmconv(fx))
								PutInt(buffer+14,ibmconv(fy))
								Write(fh2,buffer,32)
								FOR t:=fy TO fy+nh-1
									FOR i:=fx TO fx+nw-1 STEP 2
										PutChar(buffer+((i-fx)/2),((Shl(Char(ib1+i+(t*w)) AND $F,4)) OR (Char(ib1+i+(t*w)+1) AND $F)))
									ENDFOR
									Write(fh2,buffer,nw/2)
								ENDFOR
							ELSE
								WriteF(' could not open destination file.\n')
							ENDIF
					ELSE
						WriteF(' not enough memory.\n')
					ENDIF
				ELSE
					WriteF(' already a 244c cel.\n')
				ENDIF
			ELSE
				WriteF(' appears not to be a kiss 224c cel.\n')
			ENDIF
		ENDIF

		IF fh1 THEN Close(fh1);fh1:=0
		IF fh2 THEN Close(fh2);fh2:=0
		IF ib1 THEN Dispose(ib1)
		IF ib2 THEN Dispose(ib2)
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
	argarray[2]:=0
	argarray[3]:=0
	argarray[4]:=0
	rdarg:=ReadArgs('PATTERN/A/M,NOCLIP/S,NOPAD/S,OLD/S,NEW/S',argarray,0)
	IF argarray[0]=NIL
		Raise("HELP")
	ENDIF
	IF argarray[1] THEN noclip:=TRUE
	IF argarray[2] THEN nopad:=TRUE
	IF argarray[3] THEN newmode:=TRUE
	IF argarray[4] THEN newmode:=FALSE
WriteF('newmode=\d\n',newmode)
	IF (rdarg<>0)
		names:=argarray[0]
		WHILE (names[0])
WriteF('\n\nSearching for "\s"',names[0])
			dofindcolors(names[]++)
		ENDWHILE
	ENDIF
EXCEPT DO
	WriteF('\n\n')
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

PROC smaller(val1,val2);IF val1<val2;RETURN val1;ELSE;RETURN val2;ENDIF;ENDPROC
PROC bigger(val1,val2);IF val1>val2;RETURN val1;ELSE;RETURN val2;ENDIF;ENDPROC
PROC limit(val1,val2,val3);IF val1<val2 THEN RETURN val2
	        IF val1>val3 THEN RETURN val3;ENDPROC val1

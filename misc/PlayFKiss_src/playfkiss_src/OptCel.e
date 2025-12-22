
MODULE	'exec/nodes','exec/lists','exec/ports','exec/types','exec/memory','exec/tasks'
MODULE	'dos/dos','dos/dosextens','dos/notify','dos/dosextens','dos/dosasl'
MODULE	'graphics/gfx','graphics/rastport','graphics/view','graphics/layers',
				'graphics/modeid'
MODULE	'utility/tagitem'
MODULE	'intuition/intuition','intuition/screens'
MODULE	'mathtrans','mathffp'

MODULE	'amigalib/lists'

MODULE	'mod/bits','mod/filenames'

CONST DEBUG=FALSE

CONST FILE_MARK_CELL=$20,FILE_MARK_PALET=$10

RAISE "^C" IF CtrlC()=TRUE

DEF errorstring[1000]:STRING	-> A dos error string buffer
DEF str[1000]:STRING					-> A general string storage
DEF namestr[300]:STRING
DEF task:PTR TO process

DEF totalorig=0,totalnew=0

PROC main() HANDLE
	DEF source:PTR TO LONG				-> Source file(s)/pattern(s)
	DEF pp,totalsave
	DEF args[20]:LIST
	DEF rdarg=0

	task:=FindTask(0)
	GetProgramName(namestr,490)	-> Get our process name, from the CLI handle.
	IF StrLen(namestr)=0 THEN StrCopy(namestr,task.task.ln.name)	-> Task name, in case above failed

	rdarg:=ReadArgs('FILES/A/M',args,0)
	IF rdarg=0 THEN Raise("DOS")
	source:=args[0]
	IF source=0 THEN Raise("DOS")

	WHILE (source[0])
		scan(source[]++)
	ENDWHILE

	IF (totalorig>0)
		WriteF('\n\nTotal:')
		IF (totalorig>totalnew)
			pp:=Mul(totalnew,100)
			totalsave:=Div(pp,totalorig)
			WriteF(' \d%\n',totalsave)
		ELSE
			IF (totalorig=totalnew)
				WriteF(' 100%\n')
			ELSE
				WriteF(' GREW IN SIZE!??\n')
			ENDIF
		ENDIF
	ENDIF
EXCEPT DO
	IF rdarg THEN FreeArgs(rdarg)
	SELECT exception
	CASE 0;NOP
	CASE "MEM";err('out of memory')
	CASE "^C";err('***Break')
	CASE "DOS"
		StrAdd(str,namestr)
		Fault(IoErr(),str,errorstring,998)
		err(errorstring)
	DEFAULT
		StrAdd(str,namestr)
		Fault(exception,str,errorstring,998)
		err(errorstring)
	ENDSELECT
ENDPROC

PROC err(msgptr)
	WriteF('\s\n',msgptr)
ENDPROC

PROC scan(pat) HANDLE
	DEF apath=NIL:PTR TO anchorpath
	DEF fileinfo=NIL:PTR TO fileinfoblock
	DEF	achain=NIL:PTR TO achain
	DEF error=NIL
	DEF first=FALSE

	DEF filestart,pathlen
	DEF dir[500]:STRING
	DEF cpat[1000]:STRING

	DEF node:PTR TO ln,next

	DEF namelist:PTR TO lh

	NEW apath,namelist

	newList(namelist)

	StrCopy(cpat,pat,ALL)
	splitname(cpat,dir,str)

	WHILE error=NIL
		CtrlC()
		IF (first=FALSE)
			error:=MatchFirst(pat,apath)
			first:=TRUE
		ELSE
			error:=MatchNext(apath)		
		ENDIF
		IF (error=NIL)
			achain:=apath.last
			IF (achain)
				fileinfo:=achain.info
				IF (fileinfo)
					IF (fileinfo.direntrytype)<0
						node:=New(SIZEOF ln)
						node.name:=String(StrLen(fileinfo.filename))
						StrCopy(node.name,fileinfo.filename)
						AddTail(namelist,node)
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDWHILE

	node:=namelist.head
	REPEAT
		next:=node.succ
		IF (next)
			convert(dir,node.name)
			Remove(node)
			DisposeLink(node.name)
			Dispose(node)
		ENDIF
		node:=next
	UNTIL next=0
EXCEPT DO
	END apath,namelist
	SELECT exception
	CASE 0;NOP
	CASE "MEM";err('out of memory')
	CASE "DOS"
		StrAdd(str,namestr)
		Fault(IoErr(),str,errorstring,998)
		err(errorstring)
	CASE "^C"
		ReThrow()
	DEFAULT
		StrAdd(str,namestr)
		Fault(exception,str,errorstring,998)
		err(errorstring)
	ENDSELECT
ENDPROC

PROC convert(dir,file) HANDLE
	DEF filename[1500]:STRING
	DEF buffer=0:PTR TO CHAR
	DEF fh=0
	DEF ow=0,oh=0,ox=0,oy=0,bits
	DEF gfx=0:PTR TO CHAR
	DEF x=0,y=0,w=0,h=0
	DEF x1=500000,y1=500000,x2=0,y2=0
	DEF i,t,z,pp
	DEF origsize=0,newsize=0,savesize=0
	DEF xsize,ysize,xoff,yoff

	StrCopy(filename,dir)
	eaddpart(filename,file,1494)

	fh:=Open(filename,MODE_OLDFILE)
	IF (fh)
		WriteF('\s: ',file)
		buffer:=New(32)
		Read(fh,buffer,4)
		IF Long(buffer)="KiSS"
			Read(fh,buffer,28)
			IF (buffer[0]=FILE_MARK_CELL)
				ow:=(buffer[5]*256)+buffer[4]
				oh:=(buffer[7]*256)+buffer[6]
				ox:=(buffer[9]*256)+buffer[8]
				oy:=(buffer[11]*256)+buffer[10]
				bits:=buffer[1]
				Dispose(buffer)
				buffer:=New(ow*2)
				gfx:=New(((ox+ow)*(oy+oh))+64)
				origsize:=ow*oh
				totalorig:=totalorig+origsize
				IF bits=4
					FOR t:=oy TO (oy+oh-1)
						Read(fh,buffer,(ow+1)/2)
						z:=0
						FOR i:=ox TO (ox+ow-1) STEP 2
							gfx[i+(t*(ox+ow))]:=(buffer[z] AND $F0)/$10
							gfx[i+(t*(ox+ow))+1]:=(buffer[z] AND $F)
							z:=z+1
->						WriteF('\h\h',(buffer[(i-ox)/2] AND $F) ,(buffer[(i-ox)/2+1] AND $F0)/$10)
						ENDFOR
->					WriteF('\n')
					ENDFOR
				ELSE
					FOR t:=oy TO (oy+oh-1)
						Read(fh,gfx+ox+((ow+ox)*t),ow)
					ENDFOR
				ENDIF
			ENDIF
		ELSE
			ow:=(buffer[1]*256)+buffer[0]
			oh:=(buffer[3]*256)+buffer[2]
			ox:=0
			oy:=0
			origsize:=ow*oh
			totalorig:=totalorig+origsize
			IF ((ow>0) AND (ow<800) AND (oh>0) AND (oh<600))
				bits:=4
				Dispose(buffer)
				buffer:=New(ow*2)				
				gfx:=New(((ox+ow)*(oy+oh))+64)
				FOR t:=oy TO (oy+oh-1)
					Read(fh,buffer,(ow+1)/2)
					z:=0
					FOR i:=ox TO (ox+ow-1) STEP 2
						gfx[i+(t*(ox+ow))]:=(buffer[z] AND $F0)/$10
						gfx[i+(t*(ox+ow))+1]:=(buffer[z] AND $F)
						z:=z+1
->						WriteF('\h\h',(buffer[(i-ox)/2] AND $F) ,(buffer[(i-ox)/2+1] AND $F0)/$10)
					ENDFOR
->					WriteF('\n')
				ENDFOR
			ENDIF
		ENDIF
		IF ((ow>0) AND (oh>0))
			FOR t:=0 TO (oy+oh-1)
				FOR i:=0 TO (ox+ow-1)
					IF (gfx[i+(t*(ox+ow))])
						IF (i<x1) THEN x1:=i
						IF (t<y1) THEN y1:=t
						IF (i>x2) THEN x2:=i
						IF (t>y2) THEN y2:=t
					ENDIF
				ENDFOR
			ENDFOR

			IF ((x1<40000) AND (y1<40000))
				Close(fh)
				StrCopy(str,filename,ALL)
				StrAdd(str,'.bak')
				DeleteFile(str)
				Rename(filename,str)
				fh:=Open(filename,MODE_NEWFILE)
				IF (fh)
					Dispose(buffer)
					xsize:=x2-x1+1
					IF ((xsize/2)<>((xsize+1)/2))
						xsize:=xsize+1
					ENDIF
					buffer:=New(((xsize)*2)+xsize)
					ysize:=y2-y1+1
					xoff:=x1
					yoff:=y1
					PutLong(buffer,"KiSS")
					buffer[4]:=FILE_MARK_CELL
					buffer[5]:=bits

					PutInt(buffer+8, ibmconv(xsize))
					PutInt(buffer+10,ibmconv(ysize))
					PutInt(buffer+12,ibmconv(xoff))
					PutInt(buffer+14,ibmconv(yoff))

					newsize:=xsize*ysize
					totalnew:=totalnew+newsize

					Write(fh,buffer,32)

					IF (bits=8)
						FOR t:=yoff TO (yoff+ysize-1)
							z:=0
							pp:=t*(ox+ow)
							FOR i:=xoff TO (xoff+xsize-1)
								buffer[z]:=gfx[pp+i]
								z:=z+1
							ENDFOR
							Write(fh,buffer,xsize)
						ENDFOR
					ELSE
						FOR t:=yoff TO (yoff+ysize-1)
							z:=0
							pp:=(t*(ox+ow))+xoff
							FOR i:=0 TO (xsize-1) STEP 2
								buffer[z]:=(((gfx[pp] AND $F)*$10) OR ((gfx[pp+1] AND $F)))
								pp:=pp+2
								z:=z+1
							ENDFOR
							Write(fh,buffer,z)
						ENDFOR
					ENDIF

					IF (origsize>0)
						IF (origsize>newsize)
							pp:=Mul(newsize,100)
							savesize:=Div(pp,origsize)
							WriteF(' \d%',savesize)
						ELSE
							IF (origsize=newsize)
								WriteF(' 100%')
							ELSE
								WriteF(' 100%++')
							ENDIF
						ENDIF
					ENDIF
				ELSE
					Raise("DOS")
				ENDIF
			ENDIF
		ENDIF
	ELSE
		Raise("DOS")
	ENDIF
EXCEPT DO
	WriteF('\n')
	IF (fh) THEN Close(fh)
	IF (buffer) THEN Dispose(buffer)
	IF (gfx) THEN Dispose(gfx)
	IF exception THEN ReThrow()
ENDPROC

PROC ibmconv(a)
	DEF hi,lo,ret
	hi:=a AND $FF00
	lo:=a AND $00FF
	ret:=Shl(lo,8) OR Shr(hi,8)
ENDPROC ret

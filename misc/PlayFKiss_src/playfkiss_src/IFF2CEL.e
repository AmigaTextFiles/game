OPT PREPROCESS

MODULE  'exec/nodes','exec/lists','exec/ports','exec/types','exec/memory','exec/tasks'
MODULE  'dos/dos','dos/dosextens','dos/notify','dos/dosextens','dos/dosasl'
MODULE  'intuition/intuition','intuition/screens','intuition/gadgetclass','intuition/imageclass'
MODULE  'graphics/rastport','graphics/gfx','graphics/text','graphics/scale','graphics/view',
				'graphics/gfxbase','graphics/clip','graphics/layers','graphics/modeid'
MODULE  'utility','utility/hooks','utility/tagitem'
MODULE  'datatypes','datatypes/datatypes','datatypes/datatypesclass',
										'datatypes/pictureclass','datatypes/animationclass'
MODULE  'mathffp'

MODULE  'tools/boopsi'

MODULE  'mod/bits'
MODULE  'mod/compare'
MODULE  'mod/gadgets'
MODULE  'mod/macros'
MODULE  'mod/pool'
MODULE  'mod/color'
MODULE  'mod/tags'

CONST FILE_MARK_CELL=$20,FILE_MARK_PALET=$10
RAISE "^C" IF CtrlC()=TRUE

DEF errorstring[1000]:STRING    -> A dos error string buffer
DEF str[1000]:STRING                    -> A general string storage
DEF namestr[300]:STRING
DEF task:PTR TO process

PROC main() HANDLE
	DEF dtf=NIL:PTR TO dtframebox
	DEF fri=NIL:PTR TO frameinfo
	DEF obj=NIL:PTR TO datatypeheader
	DEF gpl=NIL:PTR TO gplayout
	DEF adtframe:PTR TO adtframe
	DEF dtrast=NIL:PTR TO rastport
	DEF cregs
	DEF bm=NIL:PTR TO bitmap
	DEF bmhd=NIL:PTR TO bitmapheader
	DEF dynatags:PTR TO LONG

	DEF dtn=0:PTR TO datatype
	DEF dth=0:PTR TO datatypeheader

	DEF w,h,d,nof
	DEF i
	DEF lock=0

	DEF source:PTR TO LONG              -> Source file(s)/pattern(s)
	DEF rdarg=0
	DEF args[20]:LIST
	DEF name[500]:STRING
	DEF tstr[500]:STRING

	NEW dtrast;InitRastPort(dtrast)

	IF (utilitybase:=OpenLibrary('utility.library',37))=0 THEN Raise("UTIL")
	IF (datatypesbase:=OpenLibrary('datatypes.library',0))=0 THEN Raise("DTL")

	task:=FindTask(0)
	GetProgramName(namestr,490) -> Get our process name, from the CLI handle.
	IF StrLen(namestr)=0 THEN StrCopy(namestr,task.task.ln.name)    -> Task name, in case above failed

	FOR i:=0 TO 19;args[i]:=0;ENDFOR
	rdarg:=ReadArgs('FILES/A/M',args,0)
	IF rdarg=0 THEN Raise("DOS")
	source:=args[0]
	IF source=0 THEN Raise("DOS")

	WHILE (source[0])
		CtrlC()
		StrCopy(name,source[]++)

		lock:=Lock(name,ACCESS_READ)
		IF lock
			dtn:=ObtainDataTypeA(DTST_FILE,lock,0)
			IF dtn
				dth:=dtn.header
				IF dth.groupid=GID_PICTURE
					obj:=NewDTObjectA(name,[DTA_SOURCETYPE,DTST_FILE,DTA_GROUPID,GID_PICTURE,PDTA_REMAP,FALSE,NIL,NIL])
					IF obj
						NEW fri
						dtf:=NEW [DTM_FRAMEBOX,0,fri,fri,SIZEOF frameinfo,0]:dtframebox
						IF (domethod(obj,dtf))
							gpl:=NEW [DTM_PROCLAYOUT,0,1]:gplayout
							IF (domethod(obj,gpl))
								GetDTAttrsA(obj,dynatags:=NEW [
									PDTA_BITMAPHEADER,{bmhd},
									PDTA_BITMAP,{bm}]);END dynatags
								WriteF('  ILBM: (\dx\dx\d)\n',bmhd.width,bmhd.height,bmhd.depth)
								StringF(tstr,'\s.CEL',name)
								UpperStr(tstr)
								WriteF('Saving: "\s"\n',tstr)
								convertbitmap(tstr,bm,bmhd.width,bmhd.height)
							ENDIF
						ENDIF
						END dtf
						END fri
						DisposeDTObject(obj)
					ENDIF
				ENDIF
				IF dth.groupid=GID_ANIMATION
					obj:=NewDTObjectA(name,[DTA_SOURCETYPE,DTST_FILE,DTA_GROUPID,GID_ANIMATION,ADTA_REMAP,FALSE,NIL,NIL])
					IF obj
						NEW fri
						dtf:=NEW [DTM_FRAMEBOX,0,fri,fri,SIZEOF frameinfo,0]:dtframebox
						IF (domethod(obj,dtf))
							gpl:=NEW [DTM_PROCLAYOUT,0,1]:gplayout
							IF (domethod(obj,gpl))
								GetDTAttrsA(obj,dynatags:=NEW [
									ADTA_KEYFRAME,{bm},
									ADTA_WIDTH,{w},
									ADTA_HEIGHT,{h},
									ADTA_DEPTH,{d},
									ADTA_FRAMES,{nof}]);END dynatags
								WriteF('  ANIM: (\dx\dx\d) \d frames.\n',w,h,d,nof)
								FOR i:=0 TO nof-1
									adtframe:=NEW [ADTM_LOADFRAME,0,i,0,0,0,0,0,0,0]:adtframe
									domethod(obj,adtframe)
									StringF(tstr,'\s\z\d[2].CEL',name,i)
									UpperStr(tstr)
									WriteF('Saving: "\s"\n',tstr)
									convertbitmap(tstr,adtframe.bitmap,w,h)
									adtframe.methodid:=ADTM_UNLOADFRAME
									domethod(obj,adtframe)
									END adtframe
								ENDFOR
							ENDIF
						ENDIF
						END dtf
						END fri
						DisposeDTObject(obj)
					ENDIF
				ENDIF
				ReleaseDataType(dtn)
			ENDIF
		ELSE
			Raise("DOS")
		ENDIF
	ENDWHILE
EXCEPT DO
	IF lock THEN UnLock(lock)
	IF rdarg THEN FreeArgs(rdarg)
	SELECT exception
	CASE 0;NOP
	CASE "MEM";err('out of memory')
	CASE "^C";err('***Break')
	CASE "DTL";err('cannot open datatypes.library v40')
	CASE "UTIL";err('cannot open datatypes.library v40')
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

PROC convertbitmap(str,bitmap:PTR TO bitmap,srcw,srch) HANDLE
	DEF filename[1500]:STRING
	DEF buffer=0:PTR TO CHAR
	DEF fh=0
	DEF ow=0,oh=0,ox=0,oy=0,bits
	DEF gfx=0:PTR TO CHAR
	DEF x=0,y=0
	DEF x1=500000,y1=500000,x2=0,y2=0
	DEF i,t,z,pp
	DEF origsize=0,newsize=0,savesize=0
	DEF xsize,ysize,xoff,yoff
	DEF rp:PTR TO rastport
	DEF leftedge=0

	NEW rp;InitRastPort(rp)
	rp.bitmap:=bitmap

	IF ((srcw/2)<>((srcw+1)/2))
		srcw:=srcw+1
		leftedge:=TRUE
	ENDIF
	gfx:=New((srcw*srch)+(srcw*2))
	FOR t:=0 TO srch-1
		FOR i:=0 TO srcw-1
			gfx[i+(t*srcw)]:=ReadPixel(rp,i,t)
			IF leftedge
				IF (i=(srcw-1))
					gfx[i+(t*srcw)]:=0
				ENDIF
			ENDIF                   
		ENDFOR
	ENDFOR
	IF bitmap.depth<=4 THEN bits:=4
	IF bitmap.depth>4 THEN bits:=8
	ow:=srcw;oh:=srch
	ox:=0;oy:=0
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
			StrCopy(filename,str,ALL)
			StrAdd(filename,'.bak')
			DeleteFile(filename)
			Rename(str,filename)
			fh:=Open(str,MODE_NEWFILE)
			IF (fh)
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
			ELSE
				Raise("DOS")
			ENDIF
		ENDIF
	ENDIF

EXCEPT DO
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

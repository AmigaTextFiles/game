
/* Play KiSS v 0.88 */

/*
	No copyright is claimed for *any* material within.
  This source is *currently* Public Domain, and therefore open to free exploitation. */

/* Use at your own risk, and watch for hairy palms. */


/*  November 9, 1994
											 Chad Randall 
														- mbissaymssiK Software, broken spork division
						Internet:  crandall@garnet.msen.com
							USNail:  229 S.Washington St.
											 Manchester, Michigan, 48158-9680 USA */

/* This sucker's not been tested but on my machine.  So let me know about any probs, 'kay? */

OPT LARGE

MODULE	'graphics/rastport','graphics/gfx','graphics/text','graphics/scale','graphics/view',
				'graphics/gfxbase','graphics/clip','graphics/layers','graphics/displayinfo'
MODULE	'layers'
MODULE	'intuition/intuition','intuition/screens','intuition/gadgetclass','intuition/screens',
				'intuition/pointerclass'
MODULE	'libraries/gadtools','gadtools'
MODULE	'dos/dos'
MODULE	'libraries/asl','asl'
MODULE	'tools/async'
MODULE	'wb','workbench/workbench','workbench/startup'
MODULE	'icon'
MODULE	'exec/memory','exec/lists','exec/nodes'
MODULE	'utility/tagitem'

MODULE	'amigalib/lists'

MODULE	'mod/pool'

CONST	GS1_SIZE_X=640,GS2_SIZE_X=640,GS3_SIZE_X=640,GS4_SIZE_X=768
CONST	GS1_SIZE_Y=400,GS2_SIZE_Y=400,GS3_SIZE_Y=480,GS4_SIZE_Y=512
CONST	GS1_MAX_COLOR=16,GS2_MAX_COLOR=256,GS3_MAX_COLOR=256,GS4_MAX_COLOR=256
CONST	GS1_MAX_CELL=128,GS2_MAX_CELL=192,GS3_MAX_CELL=256,GS4_MAX_CELL=256
CONST SIZE_X_218=448,SIZE_Y_218=320,SIZE_X_224C=640,SIZE_Y_224C=400
CONST FILE_MARK_CELL=$20,FILE_MARK_PALET=$10
CONST DEFAULT_SIKII_DITHER=36
CONST DEFAULT_SIKII_GOSA=1300
CONST DEFAULT_COEF_GOSA=25
CONST MAX_CELL=600
CONST MAX_SET=10,MAX_PAL=10,MAX_COLOR=GS4_MAX_COLOR
CONST MAX_SIZE_X=GS4_SIZE_X,MAX_SIZE_Y=GS4_SIZE_Y
CONST DEFAULT_SIZE_X=SIZE_X_218,DEFAULT_SIZE_Y=SIZE_Y_218
CONST FILENAME_LENGTH=64

ENUM OLD_,NEW_
ENUM	DRAG_TOP,DRAG_PAUSE,DRAG_DIRTY,DRAG_BUFFER,DRAG_SMART
CONST	CACHE_CHIP=0,CACHE_FAST=1,CACHE_NONEED=5,CACHE_NEED=6,CACHE_CHECK=7

OBJECT gcmap
	red[256]:ARRAY OF CHAR
	grn[256]:ARRAY OF CHAR
	blu[256]:ARRAY OF CHAR
ENDOBJECT

OBJECT cello
	xsize,ysize:INT
	xoffset,yoffset:INT
	mark:INT
	fix:INT
	cache:INT
	palet_num:CHAR
	bit_per_pixel:CHAR
	catch:LONG
	setxy:PTR TO setxy
		pix:PTR TO bitmap
	pix_rp:PTR TO rastport
	clip_pix:PTR TO bitmap
	clip_pix_rp:PTR TO rastport
	name:LONG
	catchsize:LONG
ENDOBJECT

OBJECT setxy
	set[MAX_SET]:ARRAY OF CHAR
	x[MAX_SET]:ARRAY OF INT
	y[MAX_SET]:ARRAY OF INT
ENDOBJECT	

OBJECT paleto
	name[FILENAME_LENGTH]:ARRAY OF CHAR
	format:CHAR
	palet_num:CHAR
	bit_per_pixel:CHAR
	color_num:INT
	pb[MAX_PAL]:ARRAY OF INT
	color[18]:ARRAY OF LONG
ENDOBJECT

OBJECT color
	red:LONG
	green:LONG
	blue:LONG
ENDOBJECT

OBJECT objnode
	ln:ln
	cels:PTR TO LONG
	x:INT
	y:INT
ENDOBJECT

OBJECT celnode
	ln:ln
	ox:INT
	oy:INT
	w:INT
	h:INT
	bm:PTR TO bitmap
	cd:PTR TO CHAR
ENDOBJECT

ENUM SCAN_NORMAL, SCAN_EOL, SCAN_SETDATA, SCAN_IBM, SCAN_CEL, SCAN_CELNUM, SCAN_CELNAME, SCAN_CELNEXT

DEF filename[500]:STRING

DEF vp:PTR TO viewport,cm,depth,scrw,scrh,menu,vis
DEF rp:PTR TO rastport,winw,winh

DEF quit=FALSE,newproj=FALSE
DEF mode=0
DEF config_size_x,config_size_y
DEF cell[MAX_CELL]:ARRAY OF cello
DEF palet[20]:ARRAY OF paleto

DEF objlist:PTR TO lh
DEF cellist:PTR TO lh
DEF mempool=0

DEF highcell=0
DEF barh=8
DEF pb[MAX_SET]:LIST
DEF current_palet=0
DEF current_set=0
DEF disp:PTR TO rastport
DEF scr:PTR TO screen
DEF win:PTR TO window,outwin:PTR TO window
DEF fixxed=FALSE,fixpow=0,fixpower=0,rtdrag=DRAG_TOP,waittof=TRUE,hand=FALSE,bound=TRUE
DEF string[500]:STRING
DEF iconbmap=0:PTR TO bitmap,iconwidth,iconheight,oldx,oldy
DEF copybmap=0:PTR TO bitmap,copyrast:PTR TO rastport
DEF backbmap=0:PTR TO bitmap,backrast:PTR TO rastport
DEF maskbmap=0:PTR TO bitmap
DEF blankbmap=0:PTR TO bitmap,maximumw=1,maximumh=1
DEF hand1=0,hand2=0,hand3=0
DEF curobj=0,offx,offy,dragmode=0,origx,origy
DEF filereq=0:PTR TO filerequester
DEF modeid=0,sh=400,sw=640
ENUM OFF=FALSE,ON=TRUE
DEF outputmode=0
DEF pauseflag=FALSE
RAISE "CHIP" IF AllocBitMap()=FALSE
RAISE "MEM" IF AllocMem()=FALSE
RAISE "MEM" IF New()=FALSE
RAISE "^C" IF CtrlC()=TRUE

PROC check_str(str)
	DEF p
	p:=str;WHILE (Char(p)<>0)
		IF ((Char(p)=10) OR (Char(p)=13) OR (Char(p)=9)) THEN PutChar(p," ")
		IF (Char(p)=";")
			PutChar(p,0)
		ENDIF
		EXIT (Char(p)=";")
	p:=p+1;ENDWHILE
ENDPROC

versionstring:
CHAR	'\0$VER: playkiss 0.88 (21.11.94) \tPUBLIC DOMAIN --- NOT FOR RESALE\0\0'

/*PROC skip_str(str) ->char *skip_str(char *str)
	DEF p																						->   	char *p;
	p:=str;WHILE (Char(p)=" ");p:=p+1;ENDWHILE 			->		for (p=str;*p==' ';p++);
  WHILE (Char(p)<>" ")														->		for (;*p!=' ';p++)
		IF (Char(p)=0) THEN RETURN p									->	if (*p=='\0') return(p);
	p:=p+1;ENDWHILE
	WHILE (Char(p)=" ");p:=p+1;ENDWHILE							->    for (;*p==' ';p++);
  RETURN p
ENDPROC*/

PROC check_kiss_header(fp)
	DEF buf
	buf:=[0,0,0,0]:LONG
	Read(fp,buf,4)
	Seek(fp,0,OFFSET_BEGINNING)
	IF Long(buf)="KiSS" THEN RETURN 1
ENDPROC FALSE


PROC load_data_cell(fn,num) HANDLE
	DEF fh=0
	DEF buf[64]:ARRAY OF CHAR,tmp_buf
	DEF i,t,j,x,y,flag
	DEF b[MAX_SIZE_X]:ARRAY OF CHAR
	DEF dir[500]:STRING,oldfile[100]:STRING
	DEF nx=0,ny=0,p,nrp=0

	DEF ob=0:PTR TO CHAR,nb=0:PTR TO CHAR	

	DEF temprp=0:PTR TO rastport
	DEF array=0
	DEF tempbitmap=0:PTR TO bitmap

	DEF charptr=0:PTR TO CHAR
	DEF cp2=0
	DEF cs1=0:PTR TO CHAR
	DEF cs2=0:PTR TO CHAR
	DEF cs=0:PTR TO CHAR

	highcell:=bigger(num,highcell)
	splitname(filename,dir,oldfile)
	AddPart(dir,fn,490)
	fh:=as_Open(dir,MODE_OLDFILE,6,4000)
	IF fh
		as_Read(fh,buf,4)
		IF Long(buf)="KiSS"
			as_Read(fh,buf,28)
			IF Char(buf)<>FILE_MARK_CELL THEN Raise("|cel")
			cell[num].xsize:=((Char(buf+ 5)*256)+Char(buf+ 4))
			cell[num].ysize:=(Char(buf+7)*256)+Char(buf+6)
			cell[num].xoffset:=Char(buf+9)*256+Char(buf+8)
			cell[num].yoffset:=Char(buf+11)*256+Char(buf+10)
			cell[num].bit_per_pixel:=smaller(bigger(Char(buf+1),4),8)
		ELSE
			cell[num].xsize:=(Char(buf+1)*256+Char(buf))
			cell[num].ysize:=Char(buf+3)*256+Char(buf+2)
			cell[num].xoffset:=0
			cell[num].yoffset:=0
			cell[num].bit_per_pixel:=4
		ENDIF

		IF cell[num].bit_per_pixel=8
			cell[num].pix:=AllocBitMap(cell[num].xsize,cell[num].ysize,8, BMF_INTERLEAVED OR BMF_CLEAR, NIL)
			cell[num].pix_rp:=New(SIZEOF rastport)
			InitRastPort(cell[num].pix_rp)
			cell[num].pix_rp.bitmap:=cell[num].pix

			cell[num].clip_pix:=AllocBitMap(cell[num].xsize,cell[num].ysize,1, BMF_INTERLEAVED OR BMF_CLEAR, NIL)
			cell[num].clip_pix_rp:=New(SIZEOF rastport)
			InitRastPort(cell[num].clip_pix_rp)
			cell[num].clip_pix_rp.bitmap:=cell[num].clip_pix
			cell[num].palet_num:=0
		ELSE
			cell[num].pix:=AllocBitMap(cell[num].xsize,cell[num].ysize,4, BMF_INTERLEAVED OR BMF_CLEAR, NIL)
			cell[num].pix_rp:=New(SIZEOF rastport)
			InitRastPort(cell[num].pix_rp)
			cell[num].pix_rp.bitmap:=cell[num].pix

			cell[num].clip_pix:=AllocBitMap(cell[num].xsize,cell[num].ysize,1, BMF_INTERLEAVED OR BMF_CLEAR, NIL)
			cell[num].clip_pix_rp:=New(SIZEOF rastport)
			InitRastPort(cell[num].clip_pix_rp)
			cell[num].clip_pix_rp.bitmap:=cell[num].clip_pix
		ENDIF

		temprp:=New(SIZEOF rastport)
		InitRastPort(temprp)
		CopyMem(cell[num].pix_rp,temprp,SIZEOF rastport)
		tempbitmap:=AllocBitMap(cell[num].xsize,1,8, BMF_CLEAR,NIL)
		temprp.bitmap:=tempbitmap
		array:=New(cell[num].xsize+100)


-> NEED TO OPTIMIZE THE FOLLOWING:::

		IF cell[num].bit_per_pixel=8
			nx:=cell[num].xsize
			nrp:=cell[num].pix_rp
			FOR i:=0 TO cell[num].ysize-1

				as_Read(fh,b,nx)

				FOR t:=0 TO nx-1
					PutChar(array+t,Char(b+t))
				ENDFOR
				IF (nrp<>0) THEN WritePixelLine8(nrp,0,i,nx,array,temprp)
			ENDFOR
		ENDIF

		IF cell[num].bit_per_pixel=4
			nx:=cell[num].xsize
			ny:=cell[num].ysize
			nrp:=cell[num].pix_rp
			nb:=New(nx*2)
			IF (nb)
				ob:=New(nx*ny*2)
				IF (ob)
					as_Read(fh,nb,((nx+1)/2)*ny)
					IF (nrp<>0)
						FOR i:=0 TO ny-1
							cs1:=nb
							cs2:=ob+(i*nx)
							charptr:=cs2
							FOR t:=0 TO (nx-1) STEP 2
								cs:=cs1[0]
								cs2[0]:=((cs*$10) AND $0F)
								cs2[1]:=(cs AND $0F)
								cs1:=cs1+1
								cs2:=cs2+2
							ENDFOR
							WritePixelLine8(nrp,0,i,nx,charptr,temprp)
						ENDFOR
					ENDIF
					Dispose(ob)
				ENDIF
				Dispose(nb)
			ENDIF
		ENDIF

		maximumw:=bigger(maximumw,nx)
		maximumh:=bigger(maximumh,cell[num].ysize)

		IF ((cell[num].pix<>0) AND (cell[num].clip_pix<>0))
			planesclip(cell[num].pix,cell[num].clip_pix,cell[num].xsize,cell[num].ysize)
			FOR i:=1 TO 7;PutLong(cell[num].clip_pix+8+(i*4),Long(cell[num].clip_pix+8));ENDFOR
			PutChar(cell[num].clip_pix+5,8)
		ENDIF
	ENDIF
EXCEPT DO
	IF fh;as_Close(fh);ELSE
		IF outwin
			StringF(string,'Object not found:"\s" ',fn)
			SetWindowTitles(outwin,string,-1)
			DisplayBeep(0)
			Delay(30)
		ENDIF
	ENDIF
	
	IF temprp THEN Dispose(temprp)
	IF array THEN Dispose(array)
	IF tempbitmap THEN FreeBitMap(tempbitmap)
	IF exception="CHIP"
		WriteF('Not enough CHIP memory.\n')
		DisplayBeep(0)
	ENDIF
	IF exception="^C" THEN ReThrow()
ENDPROC

PROC cache_cell(num,mode)  -> bitmap must be INTERLEAVED!!!  ie, *ONE* raster!!!!
	DEF newmode=CACHE_NONEED,plane:PTR TO bitmap
	IF (mode=CACHE_CHECK)
		IF (cell[num].setxy.set[current_set]<10)
			newmode:=CACHE_NEED
		ENDIF
	ENDIF
	IF mode=CACHE_NEED THEN newmode:=CACHE_NEED
	IF (newmode=CACHE_NONEED)
		IF (cell[num].cache=CACHE_CHIP)
			IF cell[num].pix=0 THEN RETURN
			cell[num].catchsize:=(cell[num].pix.bytesperrow*cell[num].pix.rows)
			cell[num].catch:=AllocMem(cell[num].catchsize,MEMF_ANY)
			CopyMem(Long(cell[num].pix+8),cell[num].catch,cell[num].catchsize)
			FreeBitMap(cell[num].pix);cell[num].pix:=0
			cell[num].cache:=CACHE_FAST
		ENDIF
	ENDIF
	IF (newmode=CACHE_NEED)
		IF (cell[num].cache=CACHE_FAST)
			IF cell[num].bit_per_pixel=8
				cell[num].pix:=AllocBitMap(cell[num].xsize,cell[num].ysize,8, BMF_INTERLEAVED OR BMF_CLEAR, NIL)
			ELSE
				cell[num].pix:=AllocBitMap(cell[num].xsize,cell[num].ysize,4, BMF_INTERLEAVED OR BMF_CLEAR, NIL)
			ENDIF
			cell[num].pix_rp.bitmap:=cell[num].pix
			IF (cell[num].catch<>0)
				IF (cell[num].pix<>0)
					CopyMem(cell[num].catch,Long(cell[num].pix+8),cell[num].catchsize)
					FreeMem(cell[num].catch,cell[num].catchsize);cell[num].catch:=0
				ELSE
					WriteF('nopix?!!!? \n');DisplayBeep(0)
				ENDIF
			ELSE
				WriteF('nomem???!? \n');DisplayBeep(0)
			ENDIF
			cell[num].cache:=CACHE_CHIP
		ENDIF
	ENDIF			
ENDPROC

PROC disposesaveback()
	DEF i
	IF iconbmap THEN FreeBitMap(iconbmap)
	IF copybmap THEN FreeBitMap(copybmap)
	IF backbmap THEN FreeBitMap(backbmap)
	IF backrast THEN Dispose(backrast)
	IF copyrast THEN Dispose(copyrast)
	IF maskbmap
		PutChar(maskbmap+5,1)
		FOR i:=1 TO 7;PutLong(maskbmap+8+(i*4),0);ENDFOR
		FreeBitMap(maskbmap)
	ENDIF
	iconbmap:=0;backbmap:=0;maskbmap:=0;copybmap:=0;backrast:=0;copyrast:=0
ENDPROC

PROC createsaveback(obj)
	DEF i,minw=16,minh=8,dummy,mask
	disposesaveback()
	FOR i:=0 TO MAX_CELL-1
		IF cell[i].mark=obj
			minw:=bigger(minw,cell[i].xoffset+cell[i].xsize+1)
			minh:=bigger(minh,cell[i].yoffset+cell[i].ysize+1)
		ENDIF
	ENDFOR
	iconwidth:=minw
	iconheight:=minh
	iconbmap:=AllocBitMap(minw,minh,retdepth(mode), BMF_CLEAR OR IF (rtdrag<DRAG_DIRTY) THEN BMF_INTERLEAVED ELSE 0,NIL)
	IF ((rtdrag=DRAG_BUFFER) OR (rtdrag=DRAG_SMART))
		IF (((rtdrag=DRAG_SMART) AND (minw<160) AND (minh<280)) OR (rtdrag=DRAG_BUFFER))
			copybmap:=AllocBitMap(minw,minh,retdepth(mode), BMF_INTERLEAVED,NIL)
			copyrast:=New(SIZEOF rastport)
			InitRastPort(copyrast)
			copyrast.bitmap:=copybmap
		ENDIF
	ENDIF
	backbmap:=AllocBitMap(minw,minh,retdepth(mode), BMF_INTERLEAVED,NIL)
	backrast:=New(SIZEOF rastport)
	InitRastPort(backrast)
	backrast.bitmap:=backbmap
	maskbmap:=AllocBitMap(minw,minh,1,IF (rtdrag=FALSE) THEN  BMF_INTERLEAVED ELSE 0,NIL)

	FOR i:=MAX_CELL-1 TO 0 STEP -1
		IF (cell[i].mark=obj)
			IF (cell[i].setxy.set[current_set]<10)
				IF ((cell[i].clip_pix<>0) AND (iconbmap<>0)) THEN BltBitMap(cell[i].clip_pix,0,0,iconbmap,cell[i].xoffset,cell[i].yoffset,cell[i].xsize,cell[i].ysize,$20,$FFFFFFFF,0)
				IF ((cell[i].pix<>0) AND (iconbmap<>0)) THEN BltBitMap(cell[i].pix,0,0,iconbmap,cell[i].xoffset,cell[i].yoffset,cell[i].xsize,cell[i].ysize,$E0,$FFFFFFFF,0)
				dummy:=cell[i].palet_num
				SELECT dummy
					CASE 0 ;mask:=%00000000
					CASE 1 ;mask:=%00010000
					CASE 2 ;mask:=%00100000
					CASE 3 ;mask:=%00110000
					CASE 4 ;mask:=%01000000
					CASE 5 ;mask:=%01010000
					CASE 6 ;mask:=%01100000
					CASE 7 ;mask:=%01110000
					CASE 8 ;mask:=%10000000
					CASE 9 ;mask:=%10010000
					CASE 10;mask:=%10100000
					CASE 11;mask:=%10110000
					CASE 12;mask:=%11000000
					CASE 13;mask:=%11010000
					CASE 14;mask:=%11100000
					CASE 15;mask:=%11110000
				ENDSELECT
				dummy:=retdepth(mode)
				SELECT dummy
					CASE 4;mask:=(mask AND %00000000)
					CASE 5;mask:=(mask AND %00010000)
					CASE 6;mask:=(mask AND %00110000)
					CASE 7;mask:=(mask AND %01110000)
					CASE 8;mask:=(mask AND %11110000)
				ENDSELECT
				IF ((cell[i].clip_pix<>0) AND (iconbmap<>0)) THEN BltBitMap(cell[i].clip_pix,0,0,iconbmap,cell[i].xoffset,cell[i].yoffset,cell[i].xsize,cell[i].ysize,$E0,mask,0)
			ENDIF
		ENDIF			
	ENDFOR

	planesclip(iconbmap,maskbmap,iconwidth,iconheight)
	PutChar(maskbmap+5,8)
	FOR i:=1 TO 7;PutLong(maskbmap+8+(i*4),Long(maskbmap+8));ENDFOR

ENDPROC

PROC reportmousemoves(win:PTR TO window)
	Forbid()
	win.flags:=win.flags OR WFLG_REPORTMOUSE
	Permit()
ENDPROC
PROC noreportmousemoves(win:PTR TO window);DEF flag
	Forbid()
	flag:=win.flags
	IF (flag AND WFLG_REPORTMOUSE) THEN flag:=flag-WFLG_REPORTMOUSE
	win.flags:=flag
	Permit()
ENDPROC


PROC main() HANDLE
	DEF i,ii,t,zz,tt,zzz
	DEF mes:PTR TO intuimessage
	DEF hit,hitflag=0,iadd:PTR TO menuitem,drawx,drawy
	DEF dir[500]:STRING,file[250]:STRING,buffer
	DEF args:PTR TO wbarg,wstr[250]:STRING,toolobject=NIL:PTR TO diskobject
	DEF region1,rectangle:PTR TO rectangle
	DEF olddir,dirrr,wb:PTR TO wbstartup
	DEF argarray[32]:LIST,rdarg=0,gotme=0,check,code=0,du=0
	DEF zx,zy,zw,zh,zox,zoy
	DEF oldfh=0,newfh=0,filebuf=0,bufptr,filelen=1
	DEF menuverify=FALSE

	IF (KickVersion(39)=0)
		Raise("Kick")
	ENDIF

	buffer:=New(260*12)
	IF (iconbase:=OpenLibrary('icon.library', 37))=NIL THEN Raise("LIB")
	IF (aslbase:=OpenLibrary('asl.library', 37))=NIL THEN Raise("LIB")
	IF (gadtoolsbase:=OpenLibrary('gadtools.library',37))=NIL THEN Raise("LIB")
	IF (layersbase:=OpenLibrary('layers.library',37))=NIL THEN Raise("LIB")

	NEW cell[MAX_CELL]
	FOR i:=0 TO MAX_CELL-1
		cell[i].setxy:=New(SIZEOF setxy)
	ENDFOR
	NEW palet[16]
	NEW rectangle

	NEW objlist
	NEW cellist

	newList(objlist)
	newList(cellist)

	IF wbmessage<>NIL
		outputmode:=TRUE
		wb:=wbmessage;args:=wb.arglist
		olddir:=CurrentDir(args.lock)
		IF args.name>0
			GetCurrentDirName(wstr,250)
			StrCopy(filename,wstr,ALL);AddPart(filename,'',490)
			StrAdd(wstr,args.name,ALL)
			IF (toolobject:=GetDiskObjectNew(wstr))
				IF (du:=FindToolType(toolobject.tooltypes,'DRAG_STRENGTH'))
					StrToLong(du,{fixpow})
					fixpow:=limit(fixpow,0,9)
				ENDIF
				IF (du:=FindToolType(toolobject.tooltypes,'FIXED'))
					IF MatchToolValue(du,'yes');fixxed:=FALSE;fixpow:=0;ELSE;fixxed:=TRUE;fixpow:=9;ENDIF
				ENDIF
				IF (du:=FindToolType(toolobject.tooltypes,'KISS_DIRECTORY'))
					StrCopy(filename,du,ALL)
					AddPart(filename,'',490)
				ENDIF
				IF (du:=FindToolType(toolobject.tooltypes,'HANDPOINTER'))
					IF MatchToolValue(du,'yes');hand:=TRUE;ELSE;hand:=FALSE;ENDIF
				ENDIF
				IF (du:=FindToolType(toolobject.tooltypes,'BLANKPOINTER'))
					IF MatchToolValue(du,'yes');hand:=3;ENDIF
				ENDIF
				IF (du:=FindToolType(toolobject.tooltypes,'BOUNDS'))
					IF MatchToolValue(du,'no');bound:=FALSE;ELSE;bound:=TRUE;ENDIF
				ENDIF
				IF (du:=FindToolType(toolobject.tooltypes,'DRAGTYPE'))
					StrToLong(du,{rtdrag})
					du:=limit(du,DRAG_TOP,DRAG_SMART)
				ENDIF
				IF (du:=FindToolType(toolobject.tooltypes,'MODEID'))
					IF Char(du)<>"$"
						StrToLong(du,{modeid})
					ELSE
						modeid:=hex2int(du)
					ENDIF
				ENDIF
				IF (du:=FindToolType(toolobject.tooltypes,'SCREEN_WIDTH'))
					StrToLong(du,{sw})
				ENDIF
				IF (du:=FindToolType(toolobject.tooltypes,'SCREEN_HEIGHT'))
					StrToLong(du,{sh})
				ENDIF
				IF (du:=FindToolType(toolobject.tooltypes,'WAITBLITTER'))
					IF MatchToolValue(du,'no');waittof:=FALSE;ELSE;waittof:=TRUE;ENDIF
				ENDIF
				FreeDiskObject(toolobject)
			ENDIF
		ENDIF
		CurrentDir(olddir)

->		StrCopy(filename,wstr,ALL)
		IF wb.numargs>1
			olddir:=args[].lock++ ->skip our lock! olddir is meaningless at this point
			IF args.lock
				olddir:=CurrentDir(args.lock)
				GetCurrentDirName(filename,490)
				NameFromLock(args.lock,wstr,240)
				CurrentDir(olddir)
				AddPart(filename,args.name,490)
				gotme:=TRUE
			ENDIF
		ENDIF
	ELSE
		FOR i:=0 TO 30
			argarray[i]:=NIL
		ENDFOR
		rdarg:=ReadArgs('FILE,M=MODEID/K,SW=SCREENWIDTH/N/K,SH=SCREENHEIGHT/N/K,D=DRAGMODE/N/K,DS=DRAGSTRENGTH/B/K,X=NOFIX/S,H=HAND/S,BP=BLANKPTRP/S,NWB=NOWAITBLIT/S,NOB=NOBOUNDS/S',argarray,0)
		IF rdarg
			IF argarray[0]
				StrCopy(filename,argarray[0],ALL)
				gotme:=TRUE
			ENDIF
			IF argarray[1]
				IF (Char(argarray[1])<>"$")
					StrToLong(argarray[1],{modeid})
				ELSE
					modeid:=hex2int(argarray[1])
				ENDIF
			ENDIF
			IF argarray[2]
				sw:=argarray[2]
				sw:=^sw
			ENDIF
			IF argarray[3]
				sh:=argarray[3]
				sh:=^sh
			ENDIF
			IF argarray[4]
				rtdrag:=argarray[4]
				rtdrag:=^rtdrag
				rtdrag:=limit(rtdrag,DRAG_TOP,DRAG_SMART)
			ENDIF
			IF argarray[5]
				fixpow:=argarray[5]
				fixpow:=^fixpow
				fixpow:=limit(fixpow,0,9)
			ENDIF
			IF argarray[6];fixxed:=TRUE;fixpow:=9;ENDIF
			IF argarray[7] THEN hand:=TRUE
			IF argarray[8] THEN hand:=3
			IF argarray[9] THEN waittof:=FALSE
			IF argarray[10] THEN bound:=FALSE
			FreeArgs(rdarg)
		ENDIF
	ENDIF

	FOR i:=0 TO MAX_CELL-1
		cell[i].name:=String(FILENAME_LENGTH)
		cell[i].mark:=-66
		cell[i].cache:=0
		cell[i].pix:=0
		cell[i].clip_pix:=0
	ENDFOR
	FOR i:=0 TO 15
		FOR ii:=0 TO 15
			palet[i].color[ii]:=0
		ENDFOR
	ENDFOR

	PutLong({hand1bm}+8,{hand1dataa})
	PutLong({hand1bm}+12,{hand1datab})
	PutLong({hand2bm}+8,{hand2dataa})
	PutLong({hand2bm}+12,{hand2datab})
	PutLong({hand3bm}+8,{hand3dataa})
	PutLong({hand3bm}+12,{hand3datab})
	hand1:=NewObjectA(NIL,'pointerclass',[POINTERA_BITMAP,{hand1bm},
							POINTERA_XOFFSET,-7,
							POINTERA_YOFFSET,0,
							POINTERA_XRESOLUTION,POINTERXRESN_SCREENRES,
							POINTERA_YRESOLUTION,POINTERYRESN_SCREENRESASPECT,
							NIL,NIL])
	hand2:=NewObjectA(NIL,'pointerclass',[POINTERA_BITMAP,{hand2bm},
							POINTERA_XOFFSET,-7,
							POINTERA_YOFFSET,1,
							POINTERA_XRESOLUTION,POINTERXRESN_SCREENRES,
							POINTERA_YRESOLUTION,POINTERYRESN_SCREENRESASPECT,
							NIL,NIL])
	hand3:=NewObjectA(NIL,'pointerclass',[POINTERA_BITMAP,{hand3bm},
							POINTERA_XRESOLUTION,POINTERXRESN_HIRES,
							POINTERA_YRESOLUTION,POINTERYRESN_HIGH,
							POINTERA_XOFFSET,0,
							POINTERA_YOFFSET,0,
							NIL,NIL])


	filereq:=AllocAslRequest(ASL_FILEREQUEST,[ASLFR_INITIALPATTERN,'#?.CNF',NIL,NIL])

	region1:=NewRegion()

	WHILE quit=FALSE
		IF (gotme<>TRUE)
			splitname(filename,dir,file)
			WbenchToFront()
			ii:=AslRequest(filereq,[ASL_HAIL,'Select .CNF file',
								ASL_OKTEXT,'Open',ASL_FILE,file,ASL_DIR,dir,
								ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,FALSE,FILF_NEWIDCMP,TRUE,NIL,NIL])
			IF ii
				StrCopy(filename,filereq.drawer,ALL)
				AddPart(filename,filereq.file,490)
			ELSE
				quit:=TRUE;StrCopy(filename,'',ALL)
			ENDIF
		ENDIF	;gotme:=FALSE
		mode:=0
		maximumw:=1;maximumh:=1
		scr:=LockPubScreen('Workbench')
		config_size_x:=scr.width
		config_size_y:=(scr.height)
		IF sw THEN config_size_x:=sw
		IF sh THEN config_size_y:=sh
		barh:=scr.barheight
		UnlockPubScreen(0,scr);scr:=0
		IF openproj(filename)
			openscreen(retdepth(mode))
			docheck(fixpow+100,TRUE)
			SELECT fixpow
			CASE 0;fixpower:=0
			CASE 1;fixpower:=32
			CASE 2;fixpower:=128
			CASE 3;fixpower:=256
			CASE 4;fixpower:=1024
			CASE 5;fixpower:=2048
			CASE 6;fixpower:=4096
			CASE 7;fixpower:=8192
			CASE 8;fixpower:=16384
			CASE 9;fixpower:=32768
			ENDSELECT
			->blankbmap:=AllocBitMap(maximumw,maximumh,1, BMF_CLEAR,NIL)
			GetRGB32(cm,0,256,buffer)
			current_set:=0
			docheck(20+current_palet,FALSE)
			current_palet:=pb[current_set]
			docheck(20+current_palet,TRUE)
			updatecolors()
			updatelist()
			newproj:=FALSE
			WHILE ((quit=FALSE) AND (newproj=FALSE))
				IF ((hand<>0) AND (hand1<>0) AND (hand2<>0) AND (menuverify=FALSE))
					IF (retdepth(mode)<5)
						SetRGB32(vp,17,$FFFFFFFF,$DDDDDDDD,$88888888)
						SetRGB32(vp,18,$99999999,$66666666,$33333333)
						SetRGB32(vp,19,0,0,0)
					ENDIF
					IF (hand<>3)
						IF (dragmode=FALSE)
							SetWindowPointerA(win,[WA_POINTER,hand1,WA_POINTERDELAY,FALSE,NIL,NIL])
						ELSE
							SetWindowPointerA(win,[WA_POINTER,hand2,WA_POINTERDELAY,FALSE,NIL,NIL])
						ENDIF
					ELSE
						IF (dragmode<>FALSE)
							SetWindowPointerA(win,[WA_POINTER,hand3,WA_POINTERDELAY,FALSE,NIL,NIL])
						ELSE
							ClearPointer(win)
						ENDIF
					ENDIF						
				ELSE
					ClearPointer(win)
				ENDIF
				Wait(-1)
				CtrlC()
				hitflag:=0
				WHILE (mes:=Gt_GetIMsg(win.userport))
					IF (mes.class=IDCMP_MENUVERIFY)
						IF dragmode
							mes.code:=MENUCANCEL
							IF (dragmode=TRUE)
								IF backrast THEN ClipBlit(backrast,0,0,rp,oldx-offx,oldy-offy,iconwidth,iconheight,$C0)
								placeobj(curobj,origx,origy);pauseflag:=TRUE
								disposesaveback()
								dragmode:=FALSE;curobj:=-1;noreportmousemoves(win)
								SetWindowTitles(win,-1,' Play KiSS 0.88')
							ENDIF
						ELSE
							menucolors(buffer)
							ClearPointer(win);menuverify:=TRUE
						ENDIF
					ENDIF
					IF (mes.class=IDCMP_MENUPICK)
						ClearPointer(win);menuverify:=FALSE
						code:=mes.code
						WHILE (code<>MENUNULL)
							iadd:=ItemAddress(menu,code)
							IF iadd
								hit:=Long(iadd+34)
								check:=(Int(iadd+12) AND CHECKED)
->								IF hit=75 THEN fixxed:=IF check THEN FALSE ELSE TRUE
								IF ((hit>=100) AND (hit<=109))
									SELECT hit
									CASE 100;fixpower:=0;fixpow:=0
									CASE 101;fixpower:=32;fixpow:=1
									CASE 102;fixpower:=128;fixpow:=2
									CASE 103;fixpower:=256;fixpow:=3
									CASE 104;fixpower:=1024;fixpow:=4
									CASE 105;fixpower:=2048;fixpow:=5
									CASE 106;fixpower:=4096;fixpow:=6
									CASE 107;fixpower:=8192;fixpow:=7
									CASE 108;fixpower:=16384;fixpow:=8
									CASE 109;fixpower:=32769;fixpow:=9
									ENDSELECT
								ENDIF
								IF hit=76 THEN IF check THEN hand:=0
								IF hit=78 THEN IF check THEN hand:=TRUE
								IF hit=79 THEN IF check THEN hand:=3
								IF hit=77
									bound:=IF check THEN TRUE ELSE FALSE
								ENDIF
								IF hit=89 THEN waittof:=IF check THEN TRUE ELSE FALSE
								IF ((hit>=80) AND (hit<=84))
									rtdrag:=hit-80
								ENDIF
								IF hit=66 THEN quit:=TRUE
								IF hit=4
									updatecolors()
									updatelist()
								ENDIF
								IF hit=3 THEN hitflag:=3
								IF hit=2 THEN hitflag:=2
								IF hit=1 THEN newproj:=TRUE
								IF ((hit>=30) AND (hit<=39))
									IF current_set<>(hit-30)
										current_set:=hit-30
										SetWindowPointerA(win,[$80000098,TRUE,WA_POINTERDELAY,TRUE,NIL,NIL])
										FOR i:=0 TO MAX_CELL-1
											cache_cell(i,CACHE_CHECK)
										ENDFOR
										docheck(20+current_palet,FALSE)
										current_palet:=pb[current_set]
										docheck(20+current_palet,TRUE)
										updatecolors()
										updatelist()
									ENDIF
								ENDIF
								IF ((hit>=20) AND (hit<=29))
									current_palet:=hit-20
									updatecolors()
								ENDIF
								code:=iadd.nextselect
							ELSE
								code:=MENUNULL
							ENDIF
						ENDWHILE
						updatecolors()
					ENDIF
					IF (mes.class=IDCMP_INTUITICKS) THEN drawx,drawy:=boundize(mes.mousex,mes.mousey)
					IF (mes.class=IDCMP_MOUSEMOVE) THEN drawx,drawy:=boundize(mes.mousex,mes.mousey)
					IF (mes.class=IDCMP_MOUSEBUTTONS)
						pauseflag:=FALSE
						IF mes.code=SELECTDOWN
							menuverify:=FALSE
							curobj,offx,offy:=findobj(mes.mousex,mes.mousey)
							origx:=mes.mousex-offx;origy:=mes.mousey-offy
							IF (curobj>-1)
								dragmode:=TRUE;reportmousemoves(win)
								removeobj(curobj)
								createsaveback(curobj)
								oldx:=-5000;oldy:=-5000
								ii:=0
								FOR i:=0 TO MAX_CELL-1
									IF cell[i].mark=curobj THEN ii:=ii+1
								ENDFOR
StringF(string,'Object #\d has \d cells. @(\d[3],\d[3]) CHIP:\d',curobj,ii,mes.mousex-offx,mes.mousey-offy,AvailMem(MEMF_CHIP))
SetWindowTitles(win,-1,string)
							ENDIF
						ENDIF
						IF mes.code=SELECTUP
							IF ((curobj>-1) AND (dragmode=TRUE))
								IF backrast THEN ClipBlit(backrast,0,0,rp,oldx-offx,oldy-offy,iconwidth,iconheight,$C0)
								placeobj(curobj,mes.mousex-offx,mes.mousey-offy);pauseflag:=TRUE
								disposesaveback()
								dragmode:=FALSE;curobj:=-1;noreportmousemoves(win)
								SetWindowTitles(win,-1,' Play KiSS 0.88')
							ENDIF
						ENDIF
						IF mes.code=MENUDOWN
							IF (dragmode=TRUE)
								IF backrast THEN ClipBlit(backrast,0,0,rp,oldx-offx,oldy-offy,iconwidth,iconheight,$C0)
								placeobj(curobj,origx,origy);pauseflag:=TRUE
								disposesaveback()
								dragmode:=FALSE;curobj:=-1;noreportmousemoves(win)
								SetWindowTitles(win,-1,' Play KiSS 0.88')
							ENDIF
						ENDIF
					ENDIF
		      Gt_ReplyIMsg(mes)
				ENDWHILE
				SELECT hitflag
				CASE 2
					WbenchToFront()
					splitname(filename,dir,file)
					ii:=AslRequest(filereq,[ASL_HAIL,'Select .CNF file',
							ASL_OKTEXT,'Save',ASL_FILE,file,ASL_DIR,dir,
							ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,TRUE,FILF_NEWIDCMP,TRUE,NIL,NIL])
					WbenchToBack()
					IF ii
						StrCopy(string,filename,ALL)
						StrCopy(filename,filereq.drawer,ALL)
						AddPart(filename,filereq.file,490)
						oldfh:=Open(filename,MODE_OLDFILE)
						newfh:=1
						IF oldfh
							Close(oldfh)
							menucolors(buffer)
							newfh:=EasyRequestArgs(win,[20,0,'Confirm overwrite!',
								'File exists.\nDo you wish to overwrite?',
								'Overwrite|Cancel'],0,0)
							updatecolors()
						ENDIF
						IF newfh
							SetWindowPointerA(win,[$80000098,TRUE,WA_POINTERDELAY,TRUE,NIL,NIL])
							filelen:=FileLength(string)
							IF (filelen>0)
								filebuf:=New(filelen)
								oldfh:=Open(string,MODE_OLDFILE)
								IF oldfh
									Read(oldfh,filebuf,filelen)
									Close(oldfh)
									bufptr:=filebuf
									WHILE ((((Char(bufptr)<>10) OR (Char(bufptr)<>13)) AND (Char(bufptr+1)<>"$")) AND (bufptr<=(filebuf+filelen)))
										bufptr:=bufptr+1
									ENDWHILE
									newfh:=Open(filename,MODE_NEWFILE)
									IF newfh
										Write(newfh,filebuf,(bufptr-filebuf+1))
										FOR i:=0 TO 9
											StringF(string,'\n$\d[1]',pb[i]);Write(newfh,string,StrLen(string))
											ii:=0
											FOR t:=0 TO MAX_CELL-1
												IF (cell[t].setxy.set[i]<10)
													ii:=bigger(ii,cell[t].mark)
												ENDIF
											ENDFOR
											FOR t:=0 TO ii STEP 16
												FOR tt:=t TO smaller(t+15,ii)
													zz:=-11
													FOR zzz:=0 TO MAX_CELL-1
														IF (cell[zzz].setxy.set[i]<10)
															IF (cell[zzz].mark=tt)
																zz:=zzz
															ENDIF
														ENDIF
													ENDFOR
													IF zz>=0
														StringF(string,' \d,\d',cell[zz].setxy.x[i],cell[zz].setxy.y[i])
														Write(newfh,string,StrLen(string))
													ELSE
														Write(newfh,' *',2)
													ENDIF
												ENDFOR
												Write(newfh,'\n',1)
											ENDFOR
											Write(newfh,'\n',1)
										ENDFOR
										Write(newfh,'\n;save file written by - Play KiSS v0.88 for Amiga computers\n\n\n',61)
										Close(newfh)
									ENDIF
								ENDIF
								Dispose(filebuf)
							ENDIF
							ClearPointer(win)
						ENDIF
					ENDIF
				CASE 3
					menucolors(buffer)
					EasyRequestArgs(win,[20,0,'About "Play KiSS"',
							'Play KiSS v0.92 - July 19, 1995\nwritten by Chad Randall\n(crandall@conch.aa.msen.com)\n---\nKISS/GS4 compatibility\n(All limits affected by CHIP or FAST memory)\n---\nReleased as PUBLIC DOMAIN\nNo warranty of any kind',
							'Ok'],0,0)
					updatecolors()
				ENDSELECT

				IF ((dragmode=TRUE) AND (curobj>=0))
					IF ((oldx<>drawx) OR (oldy<>drawy))
						IF (oldx<>-5000) THEN IF (backrast<>0) THEN ClipBlit(backrast,0,0,rp,oldx-offx,oldy-offy,iconwidth,iconheight,$C0)
						IF (backrast<>0) THEN ClipBlit(rp,drawx-offx,drawy-offy,backrast,0,0,iconwidth,iconheight,$C0)
						IF (rtdrag>=DRAG_DIRTY)
							IF ((maskbmap<>0) AND (iconbmap<>0))
								BltBitMap(iconbmap,0,0,maskbmap,0,0,iconwidth,iconheight,1,1,0)
								FOR i:=MAX_CELL-1 TO 0 STEP -1
									IF (cell[i].setxy.set[current_set]<10)
										IF (cell[i].clip_pix<>0)
											IF (cell[i].mark=curobj)
												BltBitMap(cell[i].clip_pix,0,0,maskbmap,cell[i].xoffset,cell[i].yoffset,cell[i].xsize,cell[i].ysize,$E0,%00000001,0)
											ELSE
												IF (((cell[i].setxy.x[current_set]+cell[i].xoffset)<(drawx-offx+iconwidth)) AND ((cell[i].setxy.x[current_set]+cell[i].xsize+cell[i].xoffset)>(drawx-offx)))
													IF (((cell[i].setxy.y[current_set]+cell[i].yoffset)<(drawy-offy+iconheight)) AND ((cell[i].setxy.y[current_set]+cell[i].ysize+cell[i].yoffset)>(drawy-offy)))
														zox:=0;zoy:=0
														zx:=(drawx-offx)-(cell[i].setxy.x[current_set]+cell[i].xoffset)
														zy:=(drawy-offy)-(cell[i].setxy.y[current_set]+cell[i].yoffset)
														IF (zx<=0)
															zox:=0
															zx:=Abs(zx)
														ELSE
															zox:=zx
															zx:=0
														ENDIF
														IF (zy<=0)
															zoy:=0
															zy:=Abs(zy)
														ELSE
															zoy:=zy
															zy:=0
														ENDIF
														zw:=limit(cell[i].xsize-zox,0,iconwidth-zx)
														zh:=limit(cell[i].ysize-zoy,0,iconheight-zy)
->	WriteF('\nBltBitMap($\h,\d,\d,$\h,\d,\d->\d,\d)',cell[i].clip_pix,zox,zoy,maskbmap,zx,zy,zw,zh)
														BltBitMap(cell[i].clip_pix,zox,zoy,maskbmap,zx,zy,zw,zh,$20,%00000001,0)
													ENDIF
												ENDIF
											ENDIF
										ENDIF
									ENDIF
								ENDFOR
								IF ((rtdrag=DRAG_DIRTY) OR ((rtdrag=DRAG_SMART) AND (copybmap=0)))
									BltMaskBitMapRastPort(iconbmap,0,0,rp,drawx-offx,drawy-offy,iconwidth,iconheight,%11100000,Long(maskbmap+8))
								ELSE
									IF ((copyrast<>0) AND (copybmap<>0))
										BltBitMap(iconbmap,0,0,copybmap,0,0,iconwidth,iconheight,$C0,$FF,0)
										BltBitMap(maskbmap,0,0,copybmap,0,0,iconwidth,iconheight,$80,$FF,0)
										BltBitMapRastPort(maskbmap,0,0,rp,drawx-offx,drawy-offy,iconwidth,iconheight,$20)
										BltBitMapRastPort(copybmap,0,0,rp,drawx-offx,drawy-offy,iconwidth,iconheight,$E0)
									ENDIF
								ENDIF
							ENDIF
						ENDIF
						IF ((rtdrag=DRAG_TOP) OR (rtdrag=DRAG_PAUSE))
							IF (maskbmap<>0) THEN BltBitMapRastPort(maskbmap,0,0,rp,drawx-offx,drawy-offy,iconwidth,iconheight,$20)
							IF (iconbmap<>0) THEN BltBitMapRastPort(iconbmap,0,0,rp,drawx-offx,drawy-offy,iconwidth,iconheight,$E0)
						ENDIF

						IF waittof
							WaitBlit()
							WaitTOF()
							WaitTOF()
->							FOR i:=0 TO 2
								WaitBOVP(vp)
->							ENDFOR
						ENDIF
						oldx:=drawx;oldy:=drawy;pauseflag:=FALSE
					ELSE
						IF pauseflag=FALSE
							IF (rtdrag=DRAG_PAUSE)
								drawobj(curobj,drawx-offx,drawy-offy)
								pauseflag:=TRUE
							ENDIF
						ENDIF
					ENDIF
				ENDIF
			ENDWHILE
			disposesaveback()
			flushproj()
->			IF blankbmap THEN FreeBitMap(blankbmap);blankbmap:=0
			closescreen()
		ENDIF
	ENDWHILE	

EXCEPT DO
	FOR i:=0 TO MAX_CELL-1
		DisposeLink(cell[i].name)
	ENDFOR
	IF hand1 THEN DisposeObject(hand1)
	IF hand2 THEN DisposeObject(hand2)
	flushproj()
	END cell[MAX_CELL]
	END palet[16]
	END rectangle
->	IF blankbmap THEN FreeBitMap(blankbmap);blankbmap:=0
	closescreen()
	Dispose(buffer)
	Dispose(region1)
	IF ((exception="^C") AND (outputmode=0)) THEN WriteF('***BREAK\n')
	IF ((exception="Kick"))
		WriteF('You need at least OS 3.0 (Kickstart 39) to "Play KiSS"!!!\n')
		DisplayBeep(0)
	ENDIF
	IF filereq THEN FreeAslRequest(filereq)
	IF gadtoolsbase THEN CloseLibrary(gadtoolsbase)
	IF layersbase THEN CloseLibrary(layersbase)
	IF aslbase THEN CloseLibrary(aslbase)
	IF iconbase THEN CloseLibrary(iconbase)
ENDPROC

PROC unpackmenunumber(code)
	DEF menu,item,sub,c
	c:=code
	menu:=c AND %11111
	c:=Shr(c,5)
	item:=c AND %111111
	c:=Shr(c,6)
	sub:=c AND %11111
ENDPROC menu,item,sub

PROC packmenunumber(menu=MENUNULL,item=NOITEM,sub=NOSUB)
	DEF work
	IF menu=-1 THEN menu:=MENUNULL
	IF item=-1 THEN item:=NOITEM
	IF sub=-1 THEN sub:=NOSUB
	menu:=menu AND %11111
  item:=item AND %111111
  sub:=sub AND %11111
	work:=Shl(sub,8)
	work:=Shl(work,3)
	work:=(work OR (Shl(item,5)))
	work:=(work OR menu)
ENDPROC work

PROC findmenuitem(menu:PTR TO menu,title,item=NOITEM,subitem=NOSUB)
	DEF menuitem:PTR TO menuitem
	DEF localscratch
	IF title>0
		FOR localscratch:=1 TO title
			menu:=menu.nextmenu
		ENDFOR
	ENDIF
	menuitem:=menu
	IF item<>NOITEM
		menuitem:=menu.firstitem
		FOR localscratch:=1 TO item
			menuitem:=menuitem.nextitem
		ENDFOR
		IF (subitem<>NOSUB)
			menuitem:=menuitem.subitem
			IF subitem>0
				FOR localscratch:=1 TO subitem
					menuitem:=menuitem.nextitem
				ENDFOR
			ENDIF
		ENDIF
	ENDIF
ENDPROC menuitem

PROC docheck(item,f=0)
	DEF mi:PTR TO menuitem,t,i,si
	t,i,si:=findmenuid(menu,item)  ->  Finds t,s,si using our USERID!
	mi:=findmenuitem(menu,t,i,si)  ->  Finds a menuitem struct using t,s,si!  Redundant...
	IF mi>50
		IF f=0
			IF (mi.flags AND CHECKED) THEN mi.flags:=(mi.flags-CHECKED)
		ELSE
			mi.flags:=(mi.flags OR CHECKED)
		ENDIF	
	ENDIF
ENDPROC

PROC findmenuid(menu:PTR TO menu,id)
	DEF menuitem:PTR TO menuitem,subitem:PTR TO menuitem
	DEF t=-1,i=-1,si=-1
	WHILE menu>0
		t:=t+1
		menuitem:=menu.firstitem
		WHILE menuitem>0
			i:=i+1
			subitem:=menuitem.subitem
			IF (Long(menuitem+34)=id) THEN RETURN t,i,-1
			WHILE subitem>0
				si:=si+1
				IF (Long(subitem+34)=id) THEN RETURN t,i,si
				subitem:=subitem.nextitem			
			ENDWHILE
			menuitem:=menuitem.nextitem
			si:=-1
		ENDWHILE
		i:=-1
		menu:=menu.nextmenu
	ENDWHILE
ENDPROC -1,-1,-1

PROC boundize(dx,dy)
	IF bound
		dx:=limit(dx,offx,config_size_x-iconwidth+offx)
		dy:=limit(dy,offy,config_size_y-iconheight+offy-scr.barheight-1)
	ENDIF
ENDPROC dx,dy

PROC hex2int(str)
	DEF r=0
	WHILE (Char(str)<>0)
		IF ((Char(str)>="0") AND (Char(str)<="9"))
			r:=Shl(r,4)
			r:=r+(Char(str)-"0")
		ENDIF
		IF ((Char(str)>="A") AND (Char(str)<="F"))
			r:=Shl(r,4)
			r:=r+((Char(str)-"A")+10)
		ENDIF
		str:=str+1
	ENDWHILE
ENDPROC r

PROC menucolors(buffer)
	DEF i
	FOR i:=0 TO 3
		SetRGB32(vp,i,Long(buffer+(i*12)),Long(buffer+(i*12)+4),Long(buffer+(i*12)+8))
	ENDFOR
	FOR i:=17 TO 19
		SetRGB32(vp,i,Long(buffer+(i*12)),Long(buffer+(i*12)+4),Long(buffer+(i*12)+8))
	ENDFOR
	FOR i:=(Shl(1,retdepth(mode))-4) TO (Shl(1,retdepth(mode))-1)
		SetRGB32(vp,i,Long(buffer+(i*12)),Long(buffer+(i*12)+4),Long(buffer+(i*12)+8))
	ENDFOR
ENDPROC

PROC placeobj(obj,x,y,flag=FALSE)
	DEF i,w=0,h=0
	IF flag THEN removeobj(obj)
	IF bound
		FOR i:=0 TO MAX_CELL-1
			IF (cell[i].mark=obj)
				w:=bigger(w,cell[i].xoffset+cell[i].xsize)
				h:=bigger(h,cell[i].yoffset+cell[i].ysize)
			ENDIF
		ENDFOR
		x:=limit(x,0,config_size_x-w)
		y:=limit(y,0,config_size_y-h-scr.barheight-1)
	ENDIF
	FOR i:=0 TO MAX_CELL-1
		IF (cell[i].mark=obj)
			cell[i].setxy.x[current_set]:=x
			cell[i].setxy.y[current_set]:=y
		ENDIF
	ENDFOR
	drawobj(obj)
ENDPROC

PROC findobj(x,y)
	DEF i
	FOR i:=0 TO MAX_CELL-1
		IF ((cell[i].fix<=fixpower) OR (fixxed=TRUE))
		IF (cell[i].setxy.set[current_set]<10)
		IF (x>=(cell[i].xoffset+cell[i].setxy.x[current_set]))
			IF (y>=(cell[i].yoffset+cell[i].setxy.y[current_set]))
				IF (x<(cell[i].xoffset+cell[i].setxy.x[current_set]+cell[i].xsize))
					IF (y<(cell[i].yoffset+cell[i].setxy.y[current_set]+cell[i].ysize))
						IF ReadPixel(cell[i].pix_rp,(x-(cell[i].xoffset+cell[i].setxy.x[current_set])),y-(cell[i].yoffset+cell[i].setxy.y[current_set]))>0
							RETURN cell[i].mark,(x-cell[i].setxy.x[current_set]),(y-cell[i].setxy.y[current_set])
						ENDIF
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		ENDIF
		ENDIF
	ENDFOR
ENDPROC -1,-1,-1


PROC updatecolors()
	DEF i,pn=0,t
	FOR i:=0 TO 15
		IF (palet[i].color[current_palet]<>0)
			FOR t:=0 TO (palet[i].color_num-1)
				SetRGB32(vp,pn,(Long(palet[i].color[current_palet]+(t*SIZEOF color))),(Long(palet[i].color[current_palet]+(t*SIZEOF color)+4)),(Long(palet[i].color[current_palet]+(t*SIZEOF color)+8)))
->				SetRGB32(vp,pn,Shl(Shl(pn*$1111,8),8),pn*$1111,Shl(pn*$1111,8))
->WriteF('\n\d \d \d \h,\h,\h',i,t,pn,Long(palet[i].color[current_palet]+(t*SIZEOF color)),Long(palet[i].color[current_palet]+(t*SIZEOF color)+4),Long(palet[i].color[current_palet]+(t*SIZEOF color)+8))
				pn:=pn+1;IF pn>255 THEN pn:=255
			ENDFOR
->			pn:=(pn+15)/16*16
		ENDIF
	ENDFOR
ENDPROC

/*PROC oldmaskobj(obj,x,y)
	DEF sp[8]:LIST,i,t,sd

	FOR i:=0 TO 7
		sp[i]:=Long(cell[obj].pix+8+(i*8))
	ENDFOR
	sd:=cell[obj].pix.depth

	cell[obj].pix.depth:=depth
	IF cell[obj].bit_per_pixel=4
		FOR i:=0 TO 3
			IF (cell[obj].palet_num AND Shl(1,i))
				PutLong(cell[obj].pix+8+((i+4)*4),Long(cell[obj].clip_pix+8))
			ELSE
				PutLong(cell[obj].pix+8+((i+4)*4),Long(blankbmap+8))
			ENDIF
		ENDFOR
	ENDIF

	BltMaskBitMapRastPort(cell[obj].pix,0,0,rp,x+cell[obj].xoffset,y+cell[obj].yoffset,(cell[obj].pix.bytesperrow)*8,cell[obj].ysize,
		%11100000,Long(cell[obj].clip_pix+8))

	cell[obj].pix.depth:=sd
	FOR i:=0 TO 7
		PutLong(cell[obj].pix+8+(i*8),sp[i])
	ENDFOR
ENDPROC
*/
PROC maskobj(obj,x,y)
	DEF dummy

	IF cell[obj].pix=0 THEN RETURN

	IF (cell[obj].clip_pix_rp<>0) THEN ClipBlit(cell[obj].clip_pix_rp,0,0,rp,x+cell[obj].xoffset,y+cell[obj].yoffset,cell[obj].xsize,cell[obj].ysize,$20)
	IF (cell[obj].pix_rp<>0) THEN ClipBlit(cell[obj].pix_rp,0,0,rp,x+cell[obj].xoffset,y+cell[obj].yoffset,cell[obj].xsize,cell[obj].ysize,$E0)
	dummy:=cell[obj].palet_num
	SELECT dummy
		CASE 0 ;rp.mask:=%00000000
		CASE 1 ;rp.mask:=%00010000
		CASE 2 ;rp.mask:=%00100000
		CASE 3 ;rp.mask:=%00110000
		CASE 4 ;rp.mask:=%01000000
		CASE 5 ;rp.mask:=%01010000
		CASE 6 ;rp.mask:=%01100000
		CASE 7 ;rp.mask:=%01110000
		CASE 8 ;rp.mask:=%10000000
		CASE 9 ;rp.mask:=%10010000
		CASE 10;rp.mask:=%10100000
		CASE 11;rp.mask:=%10110000
		CASE 12;rp.mask:=%11000000
		CASE 13;rp.mask:=%11010000
		CASE 14;rp.mask:=%11100000
		CASE 15;rp.mask:=%11110000
	ENDSELECT
	IF (cell[obj].bit_per_pixel<8)
		dummy:=retdepth(mode)
		SELECT dummy
			CASE 4;rp.mask:=(rp.mask AND %00000000)
			CASE 5;rp.mask:=(rp.mask AND %00010000)
			CASE 6;rp.mask:=(rp.mask AND %00110000)
			CASE 7;rp.mask:=(rp.mask AND %01110000)
			CASE 8;rp.mask:=(rp.mask AND %11110000)
		ENDSELECT
		IF (cell[obj].clip_pix_rp<>0) THEN ClipBlit(cell[obj].clip_pix_rp,0,0,rp,x+cell[obj].xoffset,y+cell[obj].yoffset,cell[obj].xsize,cell[obj].ysize,$E0)
	ENDIF
	rp.mask:=%11111111
ENDPROC

PROC updatelist()
	DEF i,t
	SetRast(rp,0)

	SetWindowPointerA(win,[$80000098,TRUE,WA_POINTERDELAY,TRUE,NIL,NIL])
	FOR i:=MAX_CELL-1 TO 0 STEP -1
		IF (cell[i].mark>=0)
			IF (cell[i].setxy.set[current_set]<10)
				maskobj(i,cell[i].setxy.x[current_set],cell[i].setxy.y[current_set])
			ENDIF
		ENDIF			
	ENDFOR
	ClearPointer(win)
ENDPROC

PROC removeobj(obj)
	DEF i,t
	DEF minx=10000,miny=10000
	DEF region,oldregion=0,rectangle:PTR TO rectangle

	region:=NewRegion()
	NEW rectangle
	rectangle.minx:=10000
	rectangle.miny:=10000

	FOR i:=0 TO MAX_CELL-1
		IF cell[i].mark=obj
			rectangle.minx:=smaller(rectangle.minx,cell[i].setxy.x[current_set]+cell[i].xoffset)
			rectangle.miny:=smaller(rectangle.miny,cell[i].setxy.y[current_set]+cell[i].yoffset)
			rectangle.maxx:=bigger(rectangle.maxx,cell[i].setxy.x[current_set]+cell[i].xoffset+cell[i].xsize)
			rectangle.maxy:=bigger(rectangle.maxy,cell[i].setxy.y[current_set]+cell[i].yoffset+cell[i].ysize)
		ENDIF
	ENDFOR
	OrRectRegion(region,rectangle)


	oldregion:=InstallClipRegion(win.wlayer,region)

	SetRast(rp,0)
	FOR i:=MAX_CELL-1 TO 0 STEP -1
		IF ((cell[i].mark>=0) AND (cell[i].mark<>obj))
			IF (cell[i].setxy.set[current_set]<10)

				maskobj(i,cell[i].setxy.x[current_set],cell[i].setxy.y[current_set])

/*				IF (cell[i].clip_pix_rp<>0) THEN ClipBlit(cell[i].clip_pix_rp,0,0,rp,cell[i].setxy.x[current_set]+cell[i].xoffset,cell[i].setxy.y[current_set]+cell[i].yoffset,cell[i].xsize,cell[i].ysize,$20)
				IF (cell[i].pix_rp<>0) THEN ClipBlit(cell[i].pix_rp,0,0,rp,cell[i].setxy.x[current_set]+cell[i].xoffset,cell[i].setxy.y[current_set]+cell[i].yoffset,cell[i].xsize,cell[i].ysize,$E0)
				dummy:=cell[i].palet_num
				SELECT dummy
					CASE 0 ;rp.mask:=%00000000
					CASE 1 ;rp.mask:=%00010000
					CASE 2 ;rp.mask:=%00100000
					CASE 3 ;rp.mask:=%00110000
					CASE 4 ;rp.mask:=%01000000
					CASE 5 ;rp.mask:=%01010000
					CASE 6 ;rp.mask:=%01100000
					CASE 7 ;rp.mask:=%01110000
					CASE 8 ;rp.mask:=%10000000
					CASE 9 ;rp.mask:=%10010000
					CASE 10;rp.mask:=%10100000
					CASE 11;rp.mask:=%10110000
					CASE 12;rp.mask:=%11000000
					CASE 13;rp.mask:=%11010000
					CASE 14;rp.mask:=%11100000
					CASE 15;rp.mask:=%11110000
				ENDSELECT
				dummy:=retdepth(mode)
				SELECT dummy
					CASE 4;rp.mask:=(rp.mask AND %00000000)
					CASE 5;rp.mask:=(rp.mask AND %00010000)
					CASE 6;rp.mask:=(rp.mask AND %00110000)
					CASE 7;rp.mask:=(rp.mask AND %01110000)
					CASE 8;rp.mask:=(rp.mask AND %11110000)
				ENDSELECT
				IF (cell[i].clip_pix_rp<>0) THEN ClipBlit(cell[i].clip_pix_rp,0,0,rp,cell[i].setxy.x[current_set]+cell[i].xoffset,cell[i].setxy.y[current_set]+cell[i].yoffset,cell[i].xsize,cell[i].ysize,$E0)
				rp.mask:=%11111111*/
			ENDIF
		ENDIF			
	ENDFOR
	InstallClipRegion(win.wlayer,oldregion)
	END rectangle
	IF region
		DisposeRegion(region)
	ENDIF
ENDPROC

PROC drawobj(obj,xxxx=-500,yyyy=-500)
	DEF i,t
	DEF minx=10000,miny=10000
	DEF region,oldregion=0,rectangle:PTR TO rectangle
	DEF xx,yy

	region:=NewRegion()
	NEW rectangle

	rectangle.minx:=10000
	rectangle.miny:=10000

	FOR i:=0 TO MAX_CELL-1
		IF cell[i].mark=obj
			xx:=IF (xxxx=-500) THEN cell[i].setxy.x[current_set] ELSE xxxx
			yy:=IF (yyyy=-500) THEN cell[i].setxy.y[current_set] ELSE yyyy
			rectangle.minx:=smaller(rectangle.minx,xx+cell[i].xoffset)
			rectangle.miny:=smaller(rectangle.miny,yy+cell[i].yoffset)
			rectangle.maxx:=bigger(rectangle.maxx,xx+cell[i].xoffset+cell[i].xsize)
			rectangle.maxy:=bigger(rectangle.maxy,yy+cell[i].yoffset+cell[i].ysize)
		ENDIF
	ENDFOR
	OrRectRegion(region,rectangle)

	oldregion:=InstallClipRegion(win.wlayer,region)

	FOR i:=MAX_CELL-1 TO 0 STEP -1
		IF ((cell[i].mark>=0))
			IF (cell[i].setxy.set[current_set]<10)
				
xx:=cell[i].setxy.x[current_set]
yy:=cell[i].setxy.y[current_set]

				IF (cell[i].mark=obj)
					IF (xxxx>-500)
						IF (yyyy>-500)
							xx:=xxxx
							yy:=yyyy
						ENDIF
					ENDIF
				ENDIF

				maskobj(i,xx,yy)

/*
->				xx:=IF ((x<>-50000) AND (cell[i].mark=obj)) THEN y ELSE cell[i].setxy.x[current_set]
->				yy:=IF ((y<>-50000) AND (cell[i].mark=obj)) THEN x ELSE cell[i].setxy.y[current_set]
				IF (cell[i].clip_pix_rp<>0) THEN ClipBlit(cell[i].clip_pix_rp,0,0,rp,xx+cell[i].xoffset,yy+cell[i].yoffset,cell[i].xsize,cell[i].ysize,$20)
				IF (cell[i].pix_rp<>0) THEN ClipBlit(cell[i].pix_rp,0,0,rp,xx+cell[i].xoffset,yy+cell[i].yoffset,cell[i].xsize,cell[i].ysize,$E0)
				dummy:=cell[i].palet_num
				SELECT dummy
					CASE 0 ;rp.mask:=%00000000
					CASE 1 ;rp.mask:=%00010000
					CASE 2 ;rp.mask:=%00100000
					CASE 3 ;rp.mask:=%00110000
					CASE 4 ;rp.mask:=%01000000
					CASE 5 ;rp.mask:=%01010000
					CASE 6 ;rp.mask:=%01100000
					CASE 7 ;rp.mask:=%01110000
					CASE 8 ;rp.mask:=%10000000
					CASE 9 ;rp.mask:=%10010000
					CASE 10;rp.mask:=%10100000
					CASE 11;rp.mask:=%10110000
					CASE 12;rp.mask:=%11000000
					CASE 13;rp.mask:=%11010000
					CASE 14;rp.mask:=%11100000
					CASE 15;rp.mask:=%11110000
				ENDSELECT
				dummy:=retdepth(mode)
				SELECT dummy
					CASE 4;rp.mask:=(rp.mask AND %00000000)
					CASE 5;rp.mask:=(rp.mask AND %00010000)
					CASE 6;rp.mask:=(rp.mask AND %00110000)
					CASE 7;rp.mask:=(rp.mask AND %01110000)
					CASE 8;rp.mask:=(rp.mask AND %11110000)
				ENDSELECT
				IF (cell[i].clip_pix_rp<>0) THEN ClipBlit(cell[i].clip_pix_rp,0,0,rp,xx+cell[i].xoffset,yy+cell[i].yoffset,cell[i].xsize,cell[i].ysize,$E0)
				rp.mask:=%11111111
*/
			ENDIF
		ENDIF			
	ENDFOR
	InstallClipRegion(win.wlayer,oldregion)
	END rectangle
	IF region
		DisposeRegion(region)
	ENDIF
ENDPROC

/*PROC scanstring(fh,flag=FALSE)
	DEF l=-1,res=1
	DEF buf,str
	buf:=[0,0]:LONG
	str:=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]:LONG
	PutLong(buf,0)
	WHILE ((res>0) AND ((Char(buf)<>32) AND (Char(buf)<>10) AND (Char(buf)<>13) AND (Char(buf)<>9) AND (Char(buf)<>":") AND (Char(buf)<>"*") AND (Char(buf)<>",")))
		res:=Read(fh,buf,1)
		l:=l+1
		IF l<120
			PutChar(str+l,Char(buf))
		ENDIF
	ENDWHILE
	PutChar(str+l+1,0)
	IF flag THEN PutChar(str+l,0)
ENDPROC str,l*/

PROC openproj(str) HANDLE
	DEF fh=0
	DEF fib:PTR TO fileinfoblock
	DEF i,buf,f
	DEF newbuf=0
	DEF num=0,set=-1
	DEF set_str[MAX_SET]:LIST
	DEF palset
	DEF wbscr

	NEW fib;newbuf:=New(2000);buf:=[0,0,0]
	FOR i:=0 TO MAX_SET-1
		set_str[i]:=String(4096)
	ENDFOR

	StrCopy(filename,str,ALL)
	
	IF (fh:=Open(filename,MODE_OLDFILE))

		current_set:=0
		WbenchToFront()
		wbscr:=LockPubScreen('Workbench')
		outwin:=OpenWindowTagList(0,[WA_INNERWIDTH,480,WA_INNERHEIGHT,1,
			WA_TOP,32,WA_LEFT,80,
			WA_AUTOADJUST,TRUE,
			WA_TITLE,' Play KiSS 0.88 - Broken Spork Technologies',
			WA_FLAGS,WFLG_DEPTHGADGET OR WFLG_DRAGBAR OR WFLG_NOCAREREFRESH,
			WA_CUSTOMSCREEN,wbscr,
			NIL,NIL])
		IF wbscr THEN UnlockPubScreen(0,wbscr)

		palset:=0
		->Delay(30)
		WHILE (Fgets(fh,newbuf,1024))
			i:=Char(newbuf)
			SELECT i
			CASE "%";load_palet(newbuf+1,palset);
				palset:=palset+1;mode:=limit(mode+1,1,16)
->			CASE "["
			CASE "("
				load_config_size(newbuf+1)
			CASE "#"
				load_config_cell(num,newbuf+1);num:=num+1
			CASE "$"
				set:=set+1
				StrCopy(set_str[set],newbuf+1,ALL)
			CASE " "
				IF set>=0 THEN StrAdd(set_str[set],newbuf+1,ALL)
			ENDSELECT
		ENDWHILE
		FOR i:=0 TO set STEP 1
			load_config_set(i,set_str[i])
		ENDFOR
	ELSE
		Raise("DOS")
	ENDIF
EXCEPT DO
	IF outwin THEN CloseWindow(outwin);outwin:=0
	IF fh THEN Close(fh);fh:=0
	IF newbuf THEN Dispose(newbuf)
	END fib
	FOR i:=0 TO MAX_SET-1
		DisposeLink(set_str[i])
	ENDFOR
	IF exception="^C" THEN ReThrow()
	IF exception THEN RETURN FALSE
ENDPROC TRUE

PROC isdigit(s);IF (((s>="0") AND (s<="9")) OR (s=".") OR (s="-")) THEN RETURN TRUE;ENDPROC FALSE
PROC isalpha(s);IF (((s>="a") AND (s<="z")) OR ((s>="A") AND (s<="Z"))) THEN RETURN TRUE;ENDPROC FALSE
PROC ispunc(s);IF ((s=".") OR (s="-") OR (s="_")) THEN RETURN TRUE;ENDPROC FALSE

PROC scanforvalue(str)
	DEF l=0,i,s[100]:STRING,ins,iii=0
	WHILE (isdigit(Char(str+l)));l:=l+1;ENDWHILE
	StrCopy(s,str,l)
	ins:=InStr(str,'.')
	IF ((ins>0) AND (ins<=l))
		StrToLong(s,{i})
		StrToLong(s+ins+1,{iii})
	ELSE
		StrToLong(s,{i})
	ENDIF
ENDPROC i,l,iii

PROC scanforstring(str)
	DEF l=0
	WHILE (isdigit(Char(str+l)) OR isalpha(Char(str+l)) OR ispunc(Char(str+l)));l:=l+1;ENDWHILE
ENDPROC l

PROC load_config_cell(num,str)
	DEF p,c,i,j,n,secval
	DEF buf,mark,len
	buf:=[0,0,0,0,0,0,0,0,0,0,0,0,0]
	p:=str
	check_str(p)
	mark,len,secval:=scanforvalue(p)
	cell[num].mark:=mark
	cell[num].fix:=secval
	p:=p+len+1

	WHILE ((Char(p)=" ") OR (Char(p)=9));p:=p+1;ENDWHILE
	len:=scanforstring(p)
	StrCopy(cell[num].name,p,len)
	p:=p+len

	load_data_cell(cell[num].name,num)
	IF outwin
		StringF(string,'MEM:\d[9] OBJ #:\d[3] CEL #\d[3] (\d[3]x\d[3]) "\s" ',AvailMem(MEMF_CHIP),cell[num].mark,num,cell[num].xsize,cell[num].ysize,cell[num].name)
		SetWindowTitles(outwin,string,-1)
	ENDIF
	WHILE (Char(p)<>0)
		IF Char(p)="*"
			mark,len:=scanforvalue(p+1)
			cell[num].palet_num:=mark
			p:=p+1+len
		ENDIF
		IF Char(p)=":"
			p:=p+1
			FOR i:=0 TO MAX_SET-1;cell[num].setxy.set[i]:=50;ENDFOR
			WHILE (TRUE=TRUE)
				mark:=(Char(p)-"0")
				IF ((0<=mark) AND (mark<MAX_SET))
					cell[num].setxy.set[mark]:=1
				ENDIF
				p:=p+1
				EXIT (Char(p)=0)
			ENDWHILE
			cache_cell(num,CACHE_CHECK)
			RETURN
		ENDIF
	p:=p+1;ENDWHILE
	FOR i:=0 TO MAX_SET-1
		cell[num].setxy.set[i]:=1
	ENDFOR
ENDPROC

PROC load_palet(fn,num)
	DEF fh
	DEF buf:PTR TO CHAR
	DEF p,c,r,g,b,len,loop
	DEF dir[500]:STRING,oldfile[100]:STRING
	DEF byte_l,byte_h

	buf:=[0,0,0,0,0,0,0,0,0,0]
	check_str(fn)
	len:=scanforstring(fn)
	PutChar(fn+len,0)
	IF outwin
		StringF(string,'PALETTE #\d:\s ',num,fn)
		SetWindowTitles(outwin,string,-1)
	ENDIF
	splitname(filename,dir,oldfile)
	AddPart(dir,fn,490)
	fh:=Open(dir,MODE_OLDFILE)
	IF fh
		StrCopy(palet[num],dir,ALL)
		IF (check_kiss_header(fh)=1)
			Read(fh,buf,32)
			IF buf[4]=FILE_MARK_PALET
				palet[num].color_num:=buf[9]*256+buf[8]
				IF (palet[num].color_num>16);mode:=16;ENDIF
				palet[num].palet_num:=buf[11]*256+buf[10]
				palet[num].bit_per_pixel:=buf[5]
			ENDIF
		ELSE
			palet[num].color_num:=GS1_MAX_COLOR
			palet[num].palet_num:=MAX_PAL
			palet[num].bit_per_pixel:=12
		ENDIF
		p:=0;WHILE (p<palet[num].palet_num)
			palet[num].color[p]:=New(SIZEOF color*palet[num].color_num+50)
			c:=0;WHILE (c<palet[num].color_num)
				IF palet[num].bit_per_pixel=12
					Read(fh,buf,2)
					byte_l:=buf[0]
					byte_h:=buf[1]
					r:=(Shr(byte_l,4) AND $F)*$1111
					g:=(byte_h AND $F)*$1111
					b:=(byte_l AND $F)*$1111
					r:=(Shl(Shl(r,8),8) OR r)
					g:=(Shl(Shl(g,8),8) OR g)
					b:=(Shl(Shl(b,8),8) OR b)
				ENDIF
				IF palet[num].bit_per_pixel=24
					Read(fh,buf,3)
					r:=buf[0]
					g:=buf[1]
					b:=buf[2]
					FOR loop:=0 TO 2
						r:=Shl(r,8) OR r
						g:=Shl(g,8) OR g
						b:=Shl(b,8) OR b
					ENDFOR
				ENDIF
				PutLong(palet[num].color[p]+(12*c),r)
				PutLong(palet[num].color[p]+(12*c)+4,g)
				PutLong(palet[num].color[p]+(12*c)+8,b)
			c:=c+1;ENDWHILE
		p:=p+1;ENDWHILE
		Close(fh)
	ENDIF
ENDPROC

PROC load_config_size(str)
	DEF p,mark,len
	check_str(str)
	p:=str
	mark,len:=scanforvalue(p)
	config_size_x:=bigger(mark,config_size_x)
	p:=p+len+1
	mark,len:=scanforvalue(p)
	config_size_y:=bigger(mark+barh+1,config_size_y)
	IF outwin
		StringF(string,'Environment (\d,\d)',config_size_x,config_size_y)
		SetWindowTitles(outwin,string,-1)
	ENDIF
ENDPROC

PROC load_config_set(num,str)
	DEF n,p:PTR TO CHAR,mark,len,x,y,i
	check_str(str)
	p:=str
	mark,len:=scanforvalue(p)
	p:=p+len+1

	pb[num]:=mark

	IF outwin
		StringF(string,'SET #\d uses Palette #\d ',num,mark)
		SetWindowTitles(outwin,string,-1)
	ENDIF

	n:=0;WHILE(n<MAX_CELL)
		IF p[0]<>"*"
			mark,len:=scanforvalue(p)
			p:=p+len+1
			x:=mark
			mark,len:=scanforvalue(p)
			p:=p+len+1
			y:=mark
			FOR i:=0 TO highcell
				IF cell[i].mark=n
					cell[i].setxy.x[num]:=x
					cell[i].setxy.y[num]:=y
				ENDIF
			ENDFOR
			WHILE ((p[0]=32) OR (p[0]=9) OR (p[0]=13));p:=p+1;ENDWHILE
		ELSE
			p:=p+1
			WHILE ((p[0]=32) OR (p[0]=9) OR (p[0]=13));p:=p+1;ENDWHILE
		ENDIF
	n:=n+1;ENDWHILE
ENDPROC

PROC planesclip(bm1,bm2,maxiw,maxih)
	DEF hap,hap2,sp1[8]:LIST
	IF ((bm1=0) OR (bm2=0)) THEN RETURN
	FOR hap:=0 TO 7
		sp1[hap]:=Long(bm1+8+(hap*4))
	ENDFOR

	FOR hap:=0 TO 7
		PutLong((bm1+8),sp1[hap])
		IF (((sp1[hap]>0)) AND ((hap+1)<=Char(bm1+5)))
			BltBitMap(bm1,0,0,bm2,0,0,maxiw,maxih,IF hap=0 THEN 192 ELSE 224,$1,0)
		ENDIF
	ENDFOR	
	FOR hap:=0 TO 7
		PutLong(bm1+8+(hap*4),sp1[hap])
	ENDFOR
->	BltBitMap(bm2,0,0,bm2,0,0,maxiw,maxih,$50,$1,0)
ENDPROC

PROC flushproj()
	DEF i,t
	FOR i:=0 TO MAX_CELL-1
		IF ((cell[i].clip_pix<>0))
			PutChar(cell[i].clip_pix+5,1)
			FOR t:=1 TO 7;PutLong(cell[i].clip_pix+8+(t*4),0);ENDFOR
		ENDIF
		cache_cell(i,CACHE_NEED)
		IF cell[i].pix
			FreeBitMap(cell[i].pix)
			cell[i].pix:=0
		ENDIF
		IF cell[i].clip_pix
			FreeBitMap(cell[i].clip_pix)
			cell[i].clip_pix:=0
		ENDIF
		IF (cell[i].pix_rp)
			Dispose(cell[i].pix_rp)
			cell[i].pix_rp:=0
		ENDIF
		IF (cell[i].clip_pix_rp)
			Dispose(cell[i].clip_pix_rp)
			cell[i].clip_pix_rp:=0
		ENDIF
		cell[i].mark:=-2
		FOR t:=0 TO MAX_SET-1
			cell[i].setxy.x[t]:=0
			cell[i].setxy.y[t]:=0
			cell[i].setxy.set[t]:=50
		ENDFOR
		IF (cell[i].catch<>0)
			IF (cell[i].catchsize<>0)
				FreeMem(cell[i].catch,cell[i].catchsize);cell[i].catch:=0
			ENDIF
		ENDIF
		cell[i].mark:=-66
		cell[i].fix:=0
		cell[i].xoffset:=0
		cell[i].yoffset:=0
		cell[i].xsize:=0
		cell[i].ysize:=0
		cell[i].cache:=0
	ENDFOR
	FOR i:=0 TO MAX_PAL-1
		FOR t:=0 TO MAX_SET-1
			IF palet[i].color[t]
				Dispose(palet[i].color[t])
				palet[i].color[t]:=0
			ENDIF
		ENDFOR
	ENDFOR
	FOR i:=0 TO MAX_SET-1
		pb[i]:=0
	ENDFOR
	highcell:=0
ENDPROC

PROC splitname(str1,str2,str3)
  DEF filestart,pathlen,stt[5]:STRING
	filestart:=FilePart(str1)
	pathlen:=filestart-str1
	IF pathlen
		StrCopy(str2,str1,pathlen)
		MidStr(stt,str2,StrLen(str2)-1,1)
		IF StrCmp(stt,'/',ALL)
			MidStr(str2,str2,0,StrLen(str2)-1)
		ENDIF		
		StrCopy(str3,filestart,ALL)
	ELSE
		StrCopy(str2,'',ALL)
		StrCopy(str3,str1,ALL)
	ENDIF
ENDPROC

PROC openscreen(d)
	DEF cflag,lflag1=CHECKIT,lflag2=CHECKIT,lflag3=CHECKIT,lflag4=CHECKIT,lflag5=CHECKIT,lflag=CHECKIT
	DEF hflag1=CHECKIT,hflag2=CHECKIT,hflag3=CHECKIT,bflag=CHECKIT

	lflag:=lflag OR MENUTOGGLE
	bflag:=bflag OR MENUTOGGLE

	depth:=d
	scr:=OpenScreenTagList(NIL,[SA_LIKEWORKBENCH,TRUE,
		SA_DEPTH,depth,
		SA_TITLE,'Play KiSS 0.88',
		SA_COLORMAPENTRIES,256,
		SA_FULLPALETTE,TRUE,
		SA_WIDTH,config_size_x,
		SA_HEIGHT,config_size_y,
		SA_INTERLEAVED,TRUE,
		SA_AUTOSCROLL,TRUE,
		SA_PENS,[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]:INT,
		IF (modeid>0) THEN SA_DISPLAYID ELSE $80000000,
			modeid,
		NIL,NIL])
	IF scr=0 THEN Raise("SCR")
	IF (vis:=GetVisualInfoA(scr,NIL))=0 THEN RETURN "VIS"
	win:=OpenWindowTagList(0,[WA_WIDTH,scr.width,WA_HEIGHT,scr.height-scr.barheight-1,
		WA_TOP,scr.barheight+1,WA_LEFT,0,
		WA_FLAGS,WFLG_ACTIVATE OR WFLG_SMART_REFRESH,
		WA_BORDERLESS,TRUE,
		WA_BACKDROP,TRUE,
		WA_CUSTOMSCREEN,scr,
		WA_NEWLOOKMENUS,TRUE,
		WA_IDCMP,IDCMP_MENUPICK OR IDCMP_MOUSEBUTTONS OR IDCMP_INTUITICKS OR IDCMP_MENUVERIFY OR IDCMP_MOUSEMOVE,
		NIL,NIL])
	IF win=0 THEN Raise("WIN")
	vp:=scr.viewport
	cm:=vp.colormap
	rp:=win.rport

	cflag:=CHECKIT
	IF (fixxed=0) THEN cflag:=cflag OR CHECKED
	IF (hand=TRUE) 	THEN hflag2:=hflag2 OR CHECKED
	IF (hand=0) 		THEN hflag1:=hflag1 OR CHECKED
	IF (hand=3) 		THEN hflag3:=hflag3 OR CHECKED
	IF (waittof) THEN lflag:=lflag OR CHECKED
	IF (bound) THEN bflag:=bflag OR CHECKED
	SELECT rtdrag
	CASE DRAG_TOP; 		lflag1:=lflag1 OR CHECKED
	CASE DRAG_PAUSE;	lflag2:=lflag2 OR CHECKED
	CASE DRAG_DIRTY;	lflag3:=lflag3 OR CHECKED
	CASE DRAG_BUFFER;	lflag4:=lflag4 OR CHECKED
	CASE DRAG_SMART;	lflag5:=lflag5 OR CHECKED
	ENDSELECT
  IF (menu:=CreateMenusA([NM_TITLE,0,'Project','P',0,0,0,
													NM_ITEM,0,'Redraw Screen','R',0,0,4,
													NM_ITEM,0,'Open','O',0,0,1,
													NM_ITEM,0,NM_BARLABEL,0,0,0,0,
													NM_ITEM,0,'Save As...','S',0,0,2,
													NM_ITEM,0,NM_BARLABEL,0,0,0,0,
													NM_ITEM,0,'About','?',0,0,3,
													NM_ITEM,0,'Quit','Q',0,0,66,

													NM_TITLE,0,'Item',0,0,0,0,
													NM_ITEM,0,'Sets',0,0,0,0,
													NM_SUB,0,'Set 0','A',CHECKIT OR CHECKED,%1111111110,30,
													NM_SUB,0,'Set 1','B',CHECKIT,%1111111101,31,
													NM_SUB,0,'Set 2','C',CHECKIT,%1111111011,32,
													NM_SUB,0,'Set 3','D',CHECKIT,%1111110111,33,
													NM_SUB,0,'Set 4','E',CHECKIT,%1111101111,34,
													NM_SUB,0,'Set 5','F',CHECKIT,%1111011111,35,
													NM_SUB,0,'Set 6','G',CHECKIT,%1110111111,36,
													NM_SUB,0,'Set 7','H',CHECKIT,%1101111111,37,
													NM_SUB,0,'Set 8','I',CHECKIT,%1011111111,38,
													NM_SUB,0,'Set 9','J',CHECKIT,%0111111111,39,

													NM_ITEM,0,'Palettes',0,0,0,0,
													NM_SUB,0,'Palette 0','0',CHECKIT OR CHECKED,%1111111110,20,
													NM_SUB,0,'Palette 1','1',CHECKIT,%1111111101,21,
													NM_SUB,0,'Palette 2','2',CHECKIT,%1111111011,22,
													NM_SUB,0,'Palette 3','3',CHECKIT,%1111110111,23,
													NM_SUB,0,'Palette 4','4',CHECKIT,%1111101111,24,
													NM_SUB,0,'Palette 5','5',CHECKIT,%1111011111,25,
													NM_SUB,0,'Palette 6','6',CHECKIT,%1110111111,26,
													NM_SUB,0,'Palette 7','7',CHECKIT,%1101111111,27,
													NM_SUB,0,'Palette 8','8',CHECKIT,%1011111111,28,
													NM_SUB,0,'Palette 9','9',CHECKIT,%0111111111,29,

													NM_TITLE,0,'Settings',0,0,0,0,
													NM_ITEM,0,'Screen Boundaries?',0,bflag,0,77,

													NM_ITEM,0,'Drag Strength',0,0,0,0,
													NM_SUB,0,'0',0,CHECKIT,%1111111110,100,
													NM_SUB,0,'1',0,				CHECKIT,%1111111101,101,
													NM_SUB,0,'2',0,				CHECKIT,%1111111011,102,
													NM_SUB,0,'3',0,				CHECKIT,%1111110111,103,
													NM_SUB,0,'4',0,				CHECKIT,%1111101111,104,
													NM_SUB,0,'5',0,				CHECKIT,%1111011111,105,
													NM_SUB,0,'6',0,				CHECKIT,%1110111111,106,
													NM_SUB,0,'7',0,				CHECKIT,%1101111111,107,
													NM_SUB,0,'8',0,				CHECKIT,%1011111111,108,
													NM_SUB,0,'9',0,				CHECKIT,%0111111111,109,

													NM_ITEM,0,'Pointer',0,0,0,0,
													NM_SUB,0,'Normal',0,hflag1,	%110,76,
													NM_SUB,0,'Hand',0,hflag2,		%101,78,
													NM_SUB,0,'Blank',0,hflag3,	%011,79,

													NM_ITEM,0,'Drag Type',0,0,0,0,
													NM_SUB,0,'Always on top',						0,lflag1,%11110,80,
													NM_SUB,0,'Layered, on pause',				0,lflag2,%11101,81,
													NM_SUB,0,'Layered, quick&dirty',		0,lflag3,%11011,82,
													NM_SUB,0,'Layered, buffered',				0,lflag4,%10111,83,
													NM_SUB,0,'Layered, smart buffered',	0,lflag5,%01111,84,
													NM_SUB,0,NM_BARLABEL,0,0,0,0,
													NM_SUB,0,'Wait for blitter?',0,lflag,0,89,

													NM_END,0,'End','x',0,0,0]:newmenu,NIL))=NIL THEN Raise("MENU")
	LayoutMenusA(menu,vis,[GTMN_NEWLOOKMENUS,TRUE,NIL,NIL])
	SetMenuStrip(win,menu)
ENDPROC

PROC closescreen()
	IF win
		CloseWindow(win)
		win:=0
	ENDIF
	IF menu
		FreeMenus(menu)
		menu:=0
	ENDIF
	IF vis
		FreeVisualInfo(vis)
		vis:=0
	ENDIF
	IF scr
		CloseScreen(scr)
		scr:=0
	ENDIF

ENDPROC

PROC retdepth(m)
	SELECT m
	CASE 0;RETURN 4
	CASE 1;RETURN 4
	CASE 2;RETURN 5
	CASE 3;RETURN 6
	CASE 4;RETURN 6
	CASE 5;RETURN 7
	CASE 6;RETURN 7
	CASE 7;RETURN 7
	CASE 8;RETURN 7
	ENDSELECT
ENDPROC 8

PROC smaller(val1,val2);IF val1<val2;RETURN val1;ELSE;RETURN val2;ENDIF;ENDPROC
PROC bigger(val1,val2);IF val1>val2;RETURN val1;ELSE;RETURN val2;ENDIF;ENDPROC
PROC limit(val1,val2,val3);IF val1<val2 THEN RETURN val2
	        IF val1>val3 THEN RETURN val3;ENDPROC val1


hand1bm:
	INT	2,22
	CHAR	0,2
	INT	0
	LONG	0,0,0,0,0,0,0,0

hand2bm:
	INT	2,22
	CHAR	0,2
	INT	0
	LONG	0,0,0,0,0,0,0,0

hand3bm:
	INT	2,1
	CHAR	0,2
	INT	0
	LONG	0,0,0,0,0,0,0,0


hand1dataa:
	LONG	$03000380,$03800380,$038003e0,$03f00368,$c37ae3ef,$73fb3fff
	LONG	$1fff0fff,$0fff07ff,$07fe03fe,$03f803f8,$01f80000
hand1datab:
	LONG	$00000080,$00800080,$00800080,$00900090,$00840011,$00050001
	LONG	$00010001,$00010003,$0002000e,$00080008,$01f80000

hand2dataa:
	LONG	$00000000,$00000300,$038003e0,$03f00b68,$1f7a1bef,$1ffb1fff
	LONG	$1fff0fff,$0fff07ff,$07fe03fe,$03f803f8,$01f80000
hand2datab:
	LONG	$00000000,$00000000,$00800080,$04900490,$00840411,$00050001
	LONG	$00010001,$00010003,$0002000e,$00080008,$01f80000

hand3dataa:
	LONG %10000000000000000000000000000000
	LONG %00000000000000000000000000000000
hand3datab:
	LONG %10000000000000000000000000000000
	LONG %00000000000000000000000000000000

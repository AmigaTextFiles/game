;
; China Challenge III - 9/93 by G.Nikl
;

; include stuff

		include	exec/types.i
		include	lvo13/dos_lib.i
		include	lvo13/exec_lib.i
		include	lvo13/icon_lib.i
		include	lvo13/graphics_lib.i
		include	lvo13/intuition_lib.i

; special define for audio.device

_LVOBeginIO	equ	-30

; macro stuff

CALL		macro
		move.l	\2,a6
		jsr	_LVO\1(a6)
		endm

RECALL		macro
		jsr	_LVO\1(a6)
		endm

ADDOPT		macro
		dc.b	Opt\1-OptTable
		endm

; global stuff

	STRUCTURE Globals,0
	 ULONG	SysBase
	 ULONG	WbMsg
	 ULONG	DosBase
	 ULONG	IntBase
	 ULONG	GfxBase
	 ULONG	OurTask  
	 ULONG	OldLock
	 UWORD	ArgC
	 UBYTE	IntroE
	 UBYTE	MusicE
	 ULONG	ScrPtr
	 ULONG	WinPtr
	 ULONG	SampleBuf
	 ULONG	RandVal
	 ULONG	imClass
	 UWORD	imCode
	 UBYTE	EndAll
	 UBYTE	AudioOpen
	 UBYTE	Music
	 UBYTE	MovesToGo
	 UBYTE	FirstPiece
	 UBYTE	TwoSelected
	 UWORD	PiecePos1
	 UWORD	PiecePos2
	 STRUCT	MoveBuf,2*4
	 STRUCT	ImageTable,31*4
	 STRUCT	ImageBuf,31*20
	 STRUCT AudioPort,36
	 STRUCT	AudioIO,68
	 STRUCT	RastPort,100
	 STRUCT	BitMap,40
	 STRUCT	EntryTable,120
	 STRUCT	UndoTable,240
	 STRUCT	NewDragon,288
	 STRUCT	ImgTable,16956
	LABEL gb_SIZEOF

bp		equr	a4

; some definitions

MaxArg		equ	20			; max value for cli args
INTRO		equ	1			; define for intro pic

*******************************************************************************

		SECTION	GAME,CODE

start		lea	vars,bp			; global vars
		move.l	d0,d2
		move.l	a0,a2
		move.l	4,a6
		move.l	a6,SysBase(bp)		; cache SysBase
		suba.l	a1,a1
		RECALL	FindTask
		move.l	d0,a3
		move.l	d0,OurTask(bp)		; cache task ptr
		tst.l	172(a3)
		bne.s	fromCLI
fromWB		lea	92(a3),a0		; wb start
		RECALL	WaitPort
		lea	92(a3),a0
		RECALL	GetMsg
		move.l	d0,WbMsg(bp)
fromCLI		lea	DosName(pc),a1		; open dos v33+
		moveq	#33,d0
		RECALL	OpenLibrary
		move.l	d0,DosBase(bp)
		beq.s	exit
		tst.l	WbMsg(bp)		; get args
		seq	d0
		ext.w	d0
		and.w	#ParseCLI-ParseWB,d0
		jsr	ParseWB(pc,d0.W)
		bsr	main
		move.l	DosBase(bp),a6
		tst.l	WbMsg(bp)
		beq.s	1$
		move.l	OldLock(bp),d1
		RECALL	CurrentDir
1$		move.l	a6,a1			; close dos
		CALL	CloseLibrary,SysBase(bp)
exit		move.l	WbMsg(bp),d2
		beq.s	1$
		RECALL	Forbid
		move.l	d2,a1
		RECALL	ReplyMsg
1$		moveq	#0,d0			; leave
		rts

;------------------------------------------------------------------------------

ParseWB		move.l	WbMsg(bp),a2		; get WbArg
		move.l	28(a2),d2
		move.l	36(a2),a2
		subq.l	#1,d2
		beq.s	4$			; no project !
		addq.w	#8,a2
4$		move.l	(a2)+,d1
		CALL	CurrentDir,DosBase(bp)	; cd to icon dir
		move.l	d0,OldLock(bp)
		lea	IconName(pc),a1		; open icon v33+
		moveq	#33,d0
		CALL	OpenLibrary,SysBase(bp)
		move.l	d0,d6
		beq.s	1$			; no lib !
		move.l	0(a2),a0
		CALL	GetDiskObject,d6	; get icon
		move.l	d0,a2
		move.l	a2,d0
		beq.s	2$			; no icon ?!
		lea	NoIntro(pc),a1
		bsr.s	GetToolType		; NoIntro ?
		move.b	d0,IntroE(bp)
		lea	NoMusic(pc),a1
		bsr.s	GetToolType		; NoMusic ?
		move.b	d0,MusicE(bp)
3$		move.l	a2,a0
		RECALL	FreeDiskObject		; free icon
2$		move.l	d6,a1			; close lib
		CALL	CloseLibrary,SysBase(bp)
1$		rts

GetToolType	move.l	54(a2),a0
		RECALL	FindToolType		; find it or not
		tst.l	d0
		seq	d0			; result d0.b
		rts

;------------------------------------------------------------------------------

ParseCLI	lea	ImgTable+500(bp),a1
		subq.w	#1,d2
		move.l	a1,a0
1$		move.b	(a2)+,(a0)+		; copy line to a `safe' place
		dbra	d2,1$
		clr.b	-(a0)
		lea	ImgTable(bp),a2
		moveq	#0,d2

; a1 - pointer into command line
; d2 - argc
; a2 - argv

ParseArg	bsr.s	GetNext			; search argument
		bmi.s	doquote			; quotation sign
		beq.s	dosemi			; commentary stops all
		bcs.s	ParseArg		; separation sign
		lea	-1(a1),a0		; argument start
		bsr.s	BumpArgV		; argc+1 & ptr to argv
build_2		bsr.s	GetNext			; search separation sign
		beq.s	dosemi			; commentary stops all
		bcc.s	build_2			; no separation sign
		clr.b	-1(a1)			; mark end
		bra.s	ParseArg		; continue search

doquote		move.l	a1,a0			; argument start
		bsr.s	BumpArgV		; argc+1 & ptr to argv
quote_2		bsr.s	GetNext			; search quotation sign
		bpl.s	quote_2			; no quotation sign
		clr.b	-1(a1)			; mark end
quote_3		bsr.s	GetNext			; search separation sign
		beq.s	dosemi			; commentary stops all
		bcc.s	quote_3			; no separation sign
		bra.s	ParseArg		; continue search

dosemi		clr.b	-(a1)			; delete semicolon
		bra.s	ParseArg		; go on

BumpArgV	cmp.w	#MaxArg,d2		; max argc reached ?
		bcc.s	1$
		move.l	a0,(a2)+		; store argptr
		addq.w	#1,d2			; increment argc
1$		rts

GetNext		move.b	(a1)+,d0		; test character
		beq.s	BuildRdy
		moveq	#-3,d1			; N=1,Z=0,C=0 -> quotation
		cmp.b	#'"',d0
		beq.s	1$
		moveq	#-2,d1			; N=0,Z=1,C=1 -> semicolon
		cmp.b	#';',d0
		beq.s	1$
		moveq	#-1,d1			; N=0,Z=0,C=1 -> separation
		cmp.b	#'=',d0
		beq.s	1$
		cmp.b	#' ',d0
		beq.s	1$
		cmp.b	#9,d0
		beq.s	1$
		moveq	#0,d1			; N=0,Z=0,C=0 -> others
1$		addq.l	#2,d1			; set flags ( see above )
		rts

BuildRdy	addq.w	#4,sp			; set right return address
		move.w	d2,ArgC(bp)
		lea	Help(pc),a3
		bsr.s	FindArg
		bne.s	1$
		CALL	Output,DosBase(bp)
		move.l	d0,d1
		lea	Template(pc),a2
		move.l	a2,d2
		moveq	#TemplateLen,d3
		RECALL	Write			; print template
		RECALL	Input
		move.l	d0,d1
		lea	ImgTable+1000(bp),a2
		move.l	a2,d2
		moveq	#80,d3
		RECALL	Read			; get cmd line
		move.l	d0,d2
		bne	ParseCLI		; parse input (if any...)

1$		lea	NoIntro(pc),a3		; NoIntro ?
		bsr.s	FindArg
		move.b	d0,IntroE(bp)
		lea	NoMusic(pc),a3		; NoMusic ?
		bsr.s	FindArg
		move.b	d0,MusicE(bp)
		rts

FindArg		lea	ImgTable(bp),a2		; ArgV[]
		move.w	ArgC(bp),d2
3$		subq.w	#1,d2
		bcs.s	1$			; all done
		move.l	(a2)+,a0
		move.l	a3,a1
2$		moveq	#$5f,d0			; upper case
		and.b	(a0)+,d0
		cmp.b	(a1)+,d0		; same chars ?
		bne.s	3$
		tst.b	d0			; string end ?
		bne.s	2$
1$		sne	d0			; result d0.b
		rts

*******************************************************************************

	IFD INTRO
ShowIntro	suba.l	a5,a5
		tst.b	IntroE(bp)
		beq.s	1$
		move.l	#24068,d0		; opening picture
		moveq	#3,d1
		CALL	AllocMem,SysBase(bp)
		move.l	d0,a5
		move.l	a5,d0
		beq.s	1$			; no buffer for pic !
		lea	PicData(pc),a0
		move.l	a5,a1
		bsr	Explode
		move.l	a5,a0
		CALL	OpenScreen,IntBase(bp)
		move.l	d0,0(a5)
		beq.s	1$			; no screen
		moveq	#8,d0
		move.l	0(a5),a0
		lea	44(a0),a0
		lea	52(a5),a1
		CALL	LoadRGB4,GfxBase(bp)	; set colours
		lea	32(a5),a1
		move.l	a5,d1
		add.l	d1,10(a1)
		move.l	0(a5),a0
		lea	84(a0),a0
		moveq	#0,d0
		moveq	#0,d1
		CALL	DrawImage,IntBase(bp)	; show pic
		move.l	72(a6),4(a5)		; for waiting (ib_Seconds)
1$		rts
	ENDC

;------------------------------------------------------------------------------

MakeImgs	lea	ImgData(pc),a0		; decrunch data
		lea	ImgTable(bp),a1
		bsr.s	Explode
		lea	ImageTable(bp),a2	; setup image structures
		lea	ImageBuf(bp),a1
		moveq	#0,d0
		moveq	#31-1,d2
2$		move.l	a1,(a2)+
		move.w	#27,4(a1)		; size
		move.w	#32,6(a1)
		move.w	#$703,d1
		cmp.w	#26*2,d0		; image 27-31 differ
		bcs.s	1$
		move.w	#$302,d1
1$		move.b	d1,9(a1)		; planes
		lea	ImgTable(bp),a0
		add.w	0(a0,d0.w),a0
		move.l	a0,10(a1)		; chip data
		lsr.w	#8,d1
		move.b	d1,14(a1)		; planepick
		addq.w	#2,d0
		lea	20(a1),a1		; next image
		dbra	d2,2$
		move.w	#160,ImageBuf+4(bp)	; background image is bigger !
		move.w	#99,ImageBuf+6(bp)
		rts

;
; Imploder explode-routine (modified!!!)
;
; call as:
;    Explode ( imploded, buffer )
;                 a0       a1
; with:
;    imploded : (UBYTE *) start of imploded data
;    buffer   : (UBYTE *) buffer for exploded data
;

Explode		movem.l	d2-d5/a2-a4,-(sp)
		move.l	a1,a4
		add.w	(a0)+,a4		; end of exploding buffer
		add.w	(a0)+,a0		; end of imploded data
		move.l	a0,a3
		move.w	(a0)+,d2
		move.w	(a0)+,d3
		bmi.s	Expl_03
		subq.w	#1,a3
Expl_03		tst.w	d2
		beq.s	Expl_05
Expl_04		move.b	-(a3),-(a4)
		subq.w	#1,d2
		bne.s	Expl_04
Expl_05		cmpa.l	a4,a1
		bcs.s	Expl_06
		movem.l	(sp)+,d2-d5/a2-a4
		rts

Expl_06		add.b	d3,d3
		bne.s	Expl_07
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_07		bcc.s	Expl_19
		add.b	d3,d3
		bne.s	Expl_08
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_08		bcc.s	Expl_18
		add.b	d3,d3
		bne.s	Expl_09
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_09		bcc.s	Expl_17
		add.b	d3,d3
		bne.s	Expl_10
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_10		bcc.s	Expl_16
		moveq	#0,d4
		add.b	d3,d3
		bne.s	Expl_11
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_11		bcc.s	Expl_12
		move.b	-(a3),d4
		moveq	#3,d0
		subq.b	#1,d4
		bra.s	Expl_20

Expl_12		add.b	d3,d3
		bne.s	Expl_13
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_13		addx.b	d4,d4
		add.b	d3,d3
		bne.s	Expl_14
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_14		addx.b	d4,d4
		add.b	d3,d3
		bne.s	Expl_15
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_15		addx.b	d4,d4
		addq.b	#5,d4
		moveq	#3,d0
		bra.s	Expl_20

Expl_16		moveq	#4,d4
		moveq	#3,d0
		bra.s	Expl_20

Expl_17		moveq	#3,d4
		moveq	#2,d0
		bra.s	Expl_20

Expl_18		moveq	#2,d4
		moveq	#1,d0
		bra.s	Expl_20

Expl_19		moveq	#1,d4
		moveq	#0,d0
Expl_20		moveq	#0,d5
		move.w	d0,d1
		add.b	d3,d3
		bne.s	Expl_21
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_21		bcc.s	Expl_24
		add.b	d3,d3
		bne.s	Expl_22
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_22		bcc.s	Expl_23
		move.b	ExplBits_1(pc,d0.w),d5
		addq.b	#8,d0
		bra.s	Expl_24

Expl_23		moveq	#2,d5
		addq.b	#4,d0
Expl_24		move.b	ExplBits_2(pc,d0.w),d0
Expl_25		add.b	d3,d3
		bne.s	Expl_26
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_26		addx.w	d2,d2
		subq.b	#1,d0
		bne.s	Expl_25
		add.w	d5,d2
		moveq	#0,d5
		movea.l	d5,a2
		move.w	d1,d0
		add.b	d3,d3
		bne.s	Expl_27
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_27		bcc.s	Expl_30
		add.w	d1,d1
		add.b	d3,d3
		bne.s	Expl_28
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_28		bcc.s	Expl_29
		movea.w	8(a0,d1.w),a2
		addq.b	#8,d0
		bra.s	Expl_30

Expl_29		movea.w	0(a0,d1.w),a2
		addq.b	#4,d0
Expl_30		move.b	16(a0,d0.w),d0
Expl_31		add.b	d3,d3
		bne.s	Expl_32
		move.b	-(a3),d3
		addx.b	d3,d3
Expl_32		addx.l	d5,d5
		subq.b	#1,d0
		bne.s	Expl_31
		addq.w	#1,a2
		adda.l	d5,a2
		adda.l	a4,a2
Expl_33		move.b	-(a2),-(a4)
		dbra	d4,Expl_33
		bra	Expl_03

ExplBits_1	dc.b	6,10,10,18
ExplBits_2	dc.b	1,1,1,1,2,3,3,4,4,5,7,14

;------------------------------------------------------------------------------

InitMusic	move.b	#4,AudioPort+8(bp)	; init port
		moveq	#-1,d0
		CALL	AllocSignal,SysBase(bp)
		lea	AudioPort+15(bp),a0
		move.b	d0,(a0)+
		bmi	3$			; no signal ?!
		move.l	OurTask(bp),(a0)+
		move.l	a0,8(a0)
		addq.w	#4,a0
		move.l	a0,-(a0)
		lea	AudioIO(bp),a1
		move.b	#5,8(a1)
		move.b	#127,9(a1)		; pri for channel allocation
		lea	AudioPort(bp),a0
		move.l	a0,14(a1)
		move.b	#$40,30(a1)		; ADIOF_NOWAIT
		lea	ChannelMap(pc),a0
		move.l	a0,34(a1)		; ioa_Data
		moveq	#4,d0
		move.l	d0,38(a1)		; ioa_Length
		lea	AudioName(pc),a0
		moveq	#0,d0
		moveq	#0,d1
		RECALL	OpenDevice
		tst.b	d0
		bne.s	3$			; error
		addq.b	#1,AudioOpen(bp)	; device opened
		move.l	#104076,d0
		moveq	#3,d1
		RECALL	AllocMem
		move.l	d0,SampleBuf(bp)
		beq.s	4$			; no buffer
		lea	Sample(pc),a1
		move.l	a1,d1
		move.l	#1005,d2
		CALL	Open,DosBase(bp)
		move.l	d0,d4
		beq.s	4$			; no file
		move.l	d4,d1
		move.l	SampleBuf(bp),d2
		move.l	#104072,d3
		RECALL	Read
		move.l	d0,d2
		move.l	d4,d1
		RECALL	Close
		cmp.l	d2,d3			; wrong size
		bne.s	4$
		moveq	#2,d0
		and.b	$bfe001,d0
		bne.s	5$
		ori.b	#2,$bfe001		; filter off
		addq.b	#1,AudioOpen(bp)	; switched filter off
5$		move.w	#$feff,d0
		tst.b	MusicE(bp)
		beq.s	2$			; stay quiet
		bsr	OptMusic
		tst.b	AudioIO+31(bp)
		beq.s	1$
4$		bsr	FreeMusic		; free whole music stuff
3$		move.w	#$feee,d0
2$		lea	ItemMusic(pc),a0
		and.w	d0,12(a0)		; disable item
1$		moveq	#1,d0			; don't quit
		rts

ChannelMap	dc.b	3,5,10,12

;------------------------------------------------------------------------------

InitAll		bsr.s	OpenLibs		; open all stuff
		beq.s	1$
	IFD INTRO
		bsr	ShowIntro
	ENDC
		bsr	MakeImgs
		bsr.s	MakeGfx
		beq.s	2$
		bsr	InitMusic
2$
	IFD INTRO
		move.l	d0,-(sp)
		bsr	RemIntro
		move.l	(sp)+,d0
	ENDC
1$		rts

;------------------------------------------------------------------------------

OpenLibs	move.l	SysBase(bp),a6		; open all libs
		lea	IntName(pc),a1
		moveq	#IntBase,d2
		bsr.s	2$
		beq.s	1$
		lea	GfxName(pc),a1
		moveq	#GfxBase,d2
2$		moveq	#33,d0
		RECALL	OpenLibrary
		move.l	d0,0(bp,d2.w)
1$		rts

;------------------------------------------------------------------------------

MakeGfx		move.l	IntBase(bp),a6		; setup gfx stuff
		lea	NewScreen(pc),a0
		RECALL	OpenScreen
		move.l	d0,d2
		move.l	d2,ScrPtr(bp)
		beq.s	MakeGfx-2		; no scr ?!
		lea	NewWindow(pc),a0
		move.l	d2,30(a0)
		RECALL	OpenWindow
		move.l	d0,WinPtr(bp)
		beq.s	MakeGfx-2		; no win ?!
		move.l	d0,a0
		lea	MenuStrip(pc),a1
		RECALL	SetMenuStrip
		moveq	#0,d0			; hide screen title
		move.l	d2,a0
		RECALL	ShowTitle
		move.l	GfxBase(bp),a6		; load new colours
		moveq	#8,d0
		move.l	d2,a0
		lea	44(a0),a0
		lea	ColTab(pc),a1
		RECALL	LoadRGB4
		lea	RastPort(bp),a1		; create hidden screen
		RECALL	InitRastPort		; init rp
		move.l	WinPtr(bp),a0
		move.l	128(a0),a0		; set window font to hidden
		lea	RastPort(bp),a1
		RECALL	SetFont			; rp for text output !!!
		moveq	#3,d0
		moveq	#(320>>4),d1
		lsl.w	#4,d1
		moveq	#256-200,d2
		neg.b	d2
		lea	BitMap(bp),a0
		RECALL	InitBitMap		; init bm
		lea	BitMap+8(bp),a2
		moveq	#3-1,d2
2$		moveq	#(320>>4),d0
		lsl.w	#4,d0
		moveq	#256-200,d1
		neg.b	d1
		RECALL	AllocRaster		; get bitplanes
		move.l	d0,(a2)+
		beq.s	1$			; no mem ...
		dbra	d2,2$
		lea	BitMap(bp),a0
		move.l	a0,RastPort+4(bp)	; RastPort->Bitmap
		move.l	IntBase(bp),a6
		move.l	76(a6),RandVal(bp)	; start value for random
		bsr	MakeDragon		; create a dragon
	IFND INTRO
		move.l	ScrPtr(bp),a0
		CALL	ScreenToFront,IntBase(bp)
	ENDC
		moveq	#1,d0			; all ok
1$		rts

ColTab		dc.w	$000,$feb,$fe9,$cb7,$a43,$c52,$4a0,$86b

;------------------------------------------------------------------------------

	IFD INTRO
RemIntro	move.l	ScrPtr(bp),d2		; game screen
		move.l	IntBase(bp),a2
		move.l	a5,d0
		beq.s	2$			; no intro pic !
		move.l	0(a5),d0
		beq.s	3$			; no intro screen !
		tst.l	d2
		beq.s	4$			; no game screen !
5$		move.l	72(a2),d0		; ib_Seconds
		sub.l	4(a5),d0
		moveq	#2,d1
		cmp.l	d1,d0
		bcc.s	4$			; time > 2 seconds
		moveq	#25,d1
		CALL	Delay,DosBase(bp)	; wait 0.5 secs
		bra.s	5$
4$		bsr.s	2$			; not nice but works ...
		moveq	#0,d2
		move.l	0(a5),a0
		RECALL	CloseScreen		; close intro scr
3$		move.l	#24068,d0
		move.l	a5,a1
		CALL	FreeMem,SysBase(bp)	; free buffer
2$		move.l	a2,a6
		tst.l	d2
		beq.s	1$			; no screen ...
		move.l	d2,a0
		RECALL	ScreenToFront
1$		rts
	ENDC

*******************************************************************************

main		movem.l	d2-d7/a2-a6,-(sp)
		bsr	InitAll			; init whole stuff
		beq.s	mainexit
mainloop	move.l	WinPtr(bp),a0		; message loop
		move.l	86(a0),a0		; check port
		CALL	GetMsg,SysBase(bp)
		move.l	d0,a1
		move.l	a1,d0
		bne.s	gotmsg			; got message
		move.l	WinPtr(bp),a0
		move.l	86(a0),a0
		RECALL	WaitPort		; be nice and wait
		bra.s	mainloop
gotmsg		move.l	20(a1),imClass(bp)
		move.w	24(a1),imCode(bp)
		RECALL	ReplyMsg		; msg back
		bsr	DoIDCMP
		tst.b	EndAll(bp)		; end flaged ?
		beq.s	mainloop
mainexit	bsr.s	CloseAll		; free whole stuff
		movem.l	(sp)+,d2-d7/a2-a6
		rts

*******************************************************************************

CloseAll	bsr.s	FreeMusic		; free all stuff
		bsr.s	CloseGfx

;------------------------------------------------------------------------------

CloseLibs	move.l	SysBase(bp),a6		; close all libs
		move.l	GfxBase(bp),a1
		bsr.s	2$
		move.l	IntBase(bp),a1
2$		move.l	a1,d0
		beq.s	1$
		RECALL	CloseLibrary
1$		rts

;------------------------------------------------------------------------------

FreeMusic	move.l	SysBase(bp),a6
		move.b	AudioOpen(bp),d2	; device open ?
		beq.s	3$
		lea	AudioIO(bp),a1
		RECALL	CloseDevice		; close audio device
3$		moveq	#0,d0
		move.b	AudioPort+15(bp),d0
		ble.s	2$
		RECALL	FreeSignal		; release signal
		clr.b	AudioPort+15(bp)
2$		move.l	SampleBuf(bp),d0
		beq.s	1$
		move.l	d0,a1
		move.l	#104076,d0
		RECALL	FreeMem			; free sample buffer
		clr.l	SampleBuf(bp)
		subq.b	#1,d2			; filter off ?
		beq.s	1$
		and.b	#$fd,$bfe001		; filter on
1$		clr.b	AudioOpen(bp)
		rts

;------------------------------------------------------------------------------

CloseGfx	move.l	GfxBase(bp),a6		; free gfx stuff
		lea	BitMap+8(bp),a2
		moveq	#3-1,d2
4$		move.l	(a2)+,d0
		beq.s	3$			; no bitplane ...
		move.l	d0,a0
		moveq	#(320>>4),d0
		lsl.w	#4,d0
		moveq	#256-200,d1
		neg.b	d1
		RECALL	FreeRaster		; free bitplane
3$		dbra	d2,4$
		move.l	IntBase(bp),a6
		move.l	WinPtr(bp),d2
		beq.s	2$
		move.l	d2,a0
		RECALL	ClearMenuStrip
		move.l	d2,a0
		RECALL	CloseWindow
2$		move.l	ScrPtr(bp),d0
		beq.s	1$
		move.l	d0,a0
		RECALL	CloseScreen
1$		rts

*******************************************************************************

DoIDCMP		cmp.l	#$100,imClass(bp)	; menu event ?
		bne	DoMouse
		moveq	#0,d0			; hide screen title
		move.l	ScrPtr(bp),a0
		CALL	ShowTitle,IntBase(bp)
2$		move.l	ScrPtr(bp),a2		; redraw first scr line
		lea	84(a2),a2
		moveq	#4,d0
		move.l	a2,a1
		CALL	SetAPen,GfxBase(bp)	; colour for drawing
		moveq	#0,d0
		moveq	#0,d1
		move.l	a2,a1
		RECALL	Move			; startpos
		move.l	#319,d0
		moveq	#0,d1
		move.l	a2,a1
		RECALL	Draw			; draw line
		moveq	#-1,d0			; MENUNULL
		cmp.w	imCode(bp),d0
		beq.s	1$			; menu done
		moveq	#$1f,d0
		and.w	imCode(bp),d0		; get menu number
		moveq	#$3f,d1			; mask for item number
		move.b	MenuTable(pc,d0.w),d0
		jsr	MenuTable(pc,d0.w)	; do menu function
		move.w	imCode(bp),d0
		lea	MenuStrip(pc),a0
		CALL	ItemAddress,IntBase(bp)	; get menu item address
		move.l	d0,a0
		move.w	32(a0),imCode(bp)	; NextSelect
		bra.s	2$
1$		rts

MenuTable	dc.b	MenuProject-MenuTable
		dc.b	MenuOptions-MenuTable

;------------------------------------------------------------------------------

MenuProject	move.w	imCode(bp),d0		; first menu
		lsr.w	#5,d0
		and.w	d1,d0			; d1:=$3f
		beq.s	ProjectAbout

ProjectQuit	st	EndAll(bp)		; this is the end ...
		addq.w	#4,sp
		rts

ProjectAbout	lea	AboutWin(pc),a0		; display about
		move.l	ScrPtr(bp),30(a0)
		CALL	OpenWindow,IntBase(bp)	; open about window
		move.l	d0,a3
		move.l	a3,d0
		beq.s	ProjectAbout-2		; sorry, no window ...
		move.l	GfxBase(bp),a6
		move.l	50(a3),a2		; window rastport
		moveq	#5,d0
		move.l	a2,a1
		RECALL	SetRast			; clear window
		moveq	#5,d0
		move.l	a2,a1
		RECALL	SetBPen			; background colour
		moveq	#2-1,d2
5$		lea	Author1.str(pc),a5	; display all messages
		moveq	#9-1,d3
4$		moveq	#0,d0
		move.b	0(a5,d2.w),d0
		move.l	a2,a1
		RECALL	SetAPen			; text colour
		move.l	d2,d0
		add.b	2(a5),d0
		move.l	d2,d1
		add.b	3(a5),d1
		move.l	a2,a1
		RECALL	Move			; text position
		moveq	#23,d0
		lea	4(a5),a0
		move.l	a2,a1
		RECALL	Text			; message
		lea	28(a5),a5
		dbra	d3,4$
		moveq	#0,d0
		move.l	a2,a1
		RECALL	SetDrMd			; new drawmode
		dbra	d2,5$
		moveq	#2-1,d2
3$		moveq	#30,d0			; random between 0 and 30
		bsr	Random
		lsl.w	#2,d0
		move.l	ImageTable+4(bp,d0.w),a1
		move.l	a2,a0
		moveq	#2,d0
		tst.w	d2
		bne.s	2$
		move.w	#168,d0
2$		moveq	#23,d1
		CALL	DrawImage,IntBase(bp)
		dbra	d2,3$
		move.l	86(a3),a0
		CALL	WaitPort,SysBase(bp)	; wait for action
		move.l	a3,a0
		CALL	CloseWindow,IntBase(bp)	; close window
1$		rts

;------------------------------------------------------------------------------

MenuOptions	move.w	imCode(bp),d0		; second menu
		lsr.w	#5,d0
		and.w	d1,d0			; d1:=$3f
		move.b	OptTable(pc,d0.w),d0
		jmp	OptTable(pc,d0.w)

OptTable	ADDOPT	NewGame
		ADDOPT	UndoMove
		ADDOPT	UndoAll
		ADDOPT	Load
		ADDOPT	Save
		ADDOPT	Music

OptNewGame	bsr	MakeDragon		; create new dragon
		rts

OptUndoMove	moveq	#120,d1			; undo last move
		sub.b	MovesToGo(bp),d1
		beq.s	1$			; nothing to undo
		lea	UndoTable(bp),a1
		add.w	d1,d1
		lea	NewDragon(bp),a0
		move.w	-4(a1,d1.w),d0		; get old pos one
		and.b	#$7f,0(a0,d0.w)
		move.w	-2(a1,d1.w),d0		; get old pos two
		and.b	#$7f,0(a0,d0.w)
		addq.b	#2,MovesToGo(bp)
		bsr	ShowDragon		; show the dragon
1$		rts

OptUndoAll	moveq	#120,d0			; undo all
		cmp.b	MovesToGo(bp),d0
		beq.s	1$			; nothing to undo
		move.b	d0,MovesToGo(bp)
		lea	NewDragon(bp),a0
		move.w	#288-1,d0
2$		and.b	#$7f,(a0)+		; clear bit 7
		dbra	d0,2$
		bsr	ShowDragon		; show the dragon
1$		rts

OptLoad		moveq	#0,d0			; request file for loading
		bsr	ReqFile
		move.l	d0,d4
		beq.s	1$			; no file
		move.l	d4,d1
		lea	UndoTable-4(bp),a2
		move.l	a2,d2
		moveq	#4,d3
		CALL	Read,DosBase(bp)
		cmp.w	#'C3',(a2)+
		bne.s	2$
		addq.w	#1,a2
		move.b	(a2)+,MovesToGo(bp)
		move.l	d4,d1
		move.l	a2,d2
		move.w	#240+288,d3
		RECALL	Read
		bsr	ShowDragon		; show loaded dragon
2$		move.l	d4,d1
		CALL	Close,DosBase(bp)
1$		rts

OptSave		moveq	#1,d0			; request file for saving
		bsr	ReqFile
		move.l	d0,d4
		beq.s	1$			; no file
		move.l	d4,d1
		lea	UndoTable-4(bp),a0
		move.l	a0,d2
		move.w	#'C3',(a0)+
		clr.b	(a0)+
		move.b	MovesToGo(bp),(a0)
		move.l	#240+288+4,d3
		CALL	Write,DosBase(bp)	; save dragon + undo table !
		move.l	d4,d1
		CALL	Close,DosBase(bp)	; close file
1$		rts

OptMusic	tst.b	AudioOpen(bp)		; audio enabled ?
		beq.s	1$
		lea	ItemMusic(pc),a0
		btst	#0,12(a0)		; checkmark set ?
		sne	d0
		cmp.b	Music(bp),d0
		beq.s	1$			; same state !
		lea	AudioIO(bp),a1
		moveq	#11,d1			; ADCMD_FINISH
		tst.b	d0
		beq.s	2$			; music off
		move.b	#$11,30(a1)		; ADIOF_PERVOL+IOF_QUICK
		move.l	SampleBuf(bp),a0
		lea	104(a0),a0
		move.l	a0,34(a1)		; ioa_Data
		move.l	#2*51984,38(a1)		; ioa_Length
		move.w	#428,42(a1)		; ioa_Period
		move.w	#55,44(a1)		; ioa_Volume
		clr.w	46(a1)			; ioa_Cycles
		moveq	#3,d1			; CMD_WRITE
2$		move.w	d1,28(a1)
		CALL	BeginIO,20(a1)
		not.b	Music(bp)
1$		rts

;------------------------------------------------------------------------------

DoMouse		moveq	#8,d0			; mouse pressed
		cmp.l	imClass(bp),d0
		bne.s	ConfirmQ
		moveq	#$68,d0
		cmp.w	imCode(bp),d0
		bne.s	ConfirmQ		; wasn't lmb
		bsr	CheckPos
		beq.s	ConfirmQ		; wrong position

Confirm		tst.b	TwoSelected(bp)
		beq.s	ChoiceTwo		; not two selected
		cmp.w	PiecePos2(bp),d0
		beq.s	1$
		cmp.w	PiecePos1(bp),d0
		bne.s	ConfirmQ
1$		lea	UndoTable(bp),a1
		moveq	#120,d1
		sub.b	MovesToGo(bp),d1
		subq.b	#2,MovesToGo(bp)
		add.w	d1,d1
		lea	NewDragon(bp),a0
		move.w	PiecePos1(bp),d0
		or.b	#$80,0(a0,d0.w)		; mark removed
		move.w	d0,0(a1,d1.w)		; store pos
		move.w	PiecePos2(bp),d0
		or.b	#$80,0(a0,d0.w)		; mark removed
		move.w	d0,2(a1,d1.w)		; store pos
		bsr	ShowDragon		; show the dragon
ConfirmQ	bra.s	MouseQuit

ChoiceTwo	tst.b	FirstPiece(bp)		; second choice ?
		beq.s	ChoiceOne
		move.w	PiecePos1(bp),d1
		cmp.w	d1,d0
		beq.s	MouseQuit		; same pos ...
		lea	NewDragon(bp),a1
		move.b	0(a1,d1.w),d1
		cmp.b	0(a1,d0.w),d1
		bne.s	ChoiceOne		; diffrent piece
		st	TwoSelected(bp)
		move.w	d0,PiecePos2(bp)
		bra.s	ChoiceShow

ChoiceOne	st	FirstPiece(bp)		; first selection
		move.w	d0,PiecePos1(bp)

ChoiceShow	lea	NewDragon(bp),a1	; show selected piece
		move.b	0(a1,d0.w),d1
		ext.w	d1
		lsl.w	#2,d1
		move.l	ImageTable(bp,d1.w),a1
		move.l	WinPtr(bp),a0
		move.l	50(a0),a0		; rastport
		moveq	#85,d1
		moveq	#3,d0
		tst.b	TwoSelected(bp)
		beq.s	1$			; is the first
		move.w	#291,d0
1$		CALL	DrawImage,IntBase(bp)

MouseQuit	rts

;------------------------------------------------------------------------------
; Teil an Klickposition ?

CheckPos	movem.l	d2-d6,-(sp)
		moveq	#0,d6			; FALSE
		move.l	WinPtr(bp),a1
		lea	NewDragon(bp),a0
		moveq	#1,d4			; start displacement
		moveq	#4-1,d5
6$		moveq	#0,d2
		move.w	12(a1),d2		; y -> Zeile
		sub.w	d4,d2
		divu	#30,d2
		cmp.w	#6,d2			; Zeile < 6 ?
		bcc.s	5$
		moveq	#0,d3
		move.w	14(a1),d3		; x -> Spalte
		sub.w	d4,d3
		divu	#25,d3
		moveq	#12,d1
		cmp.w	d1,d3			; Spalte > 11 ?
		bcc.s	5$
		move.l	d1,d0			; calculate matrix index
		mulu	d2,d0			; 12*Zeile
		add.w	d3,d0
		moveq	#72,d1
		mulu	d5,d1
		add.w	d1,d0
		tst.b	0(a0,d0.w)
		bgt.s	4$			; piece not removed
5$		addq.w	#3,d4
		dbra	d5,6$
		bra.s	1$
4$		tst.w	d3			; Spalte == 0 ?
		beq.s	2$
		cmp.w	#11,d3			; Spalte == 11 ?
		beq.s	2$
		tst.b	-1(a0,d0.w)		; links ein Teil ?
		ble.s	3$
		tst.b	1(a0,d0.w)		; rechts ein Teil ?
		bgt.s	1$
3$		subq.b	#3,d5			; Ebene 3 (ganz oben) ?
		beq.s	2$
		tst.b	72(a0,d0.w)		; Teil darueber ?
		bgt.s	1$
2$		moveq	#1,d6			; TRUE
1$		move.l	d6,d1			; set flags
		movem.l	(sp)+,d2-d6
		rts

;------------------------------------------------------------------------------
; Drachen erstellen

MakeDragon	movem.l	d2/d3/a2/a3,-(sp)	; save regs
		moveq	#120,d2
		move.b	d2,MovesToGo(bp)	; initial moves
		lea	EntryTable(bp),a3
		move.l	a3,a2
		moveq	#(120>>2),d2		; piece count
3$		move.b	d2,(a2)+
		move.b	d2,(a2)+		; init table
		move.b	d2,(a2)+
		move.b	d2,(a2)+		; entries ...
		subq.b	#1,d2
		bne.s	3$
		lea	NewDragon(bp),a2
		subq.w	#1,d2
		moveq	#120,d3			; place count
2$		addq.w	#1,d2
		move.w	d2,d1
		moveq	#-8,d0
		and.w	d1,d0
		sub.w	d0,d1			; d1=x mod 8;
		lsr.w	#3,d0			; d0=x div 8;
	IFND .a68k
		btst	d1,PosTable(pc,d0.w)
	ENDC
	IFD .a68k
		btst	d1,PosTable+2(pc,d0.w)
	ENDC
		beq.s	2$			; unused position
		move.l	d3,d0
		bsr.s	Random
		move.b	0(a3,d0.w),0(a2,d2.w)	; set piece number
		move.b	-1(a3,d3.w),0(a3,d0.w)	; replace old piece
1$		subq.w	#1,d3
		bne.s	2$
		bsr.s	ShowDragon		; draw dragon
		movem.l	(sp)+,d2/d3/a2/a3	; restore regs
		rts

PosTable	dc.b	$FF,$8F,$1F,$FE,$E7,$7F,$F8,$F1,$FF
		dc.b	$FC,$03,$0F,$F8,$81,$1F,$F0,$C0,$3F
		dc.b	$60,$00,$0F,$F0,$00,$0F,$F0,$00,$06
		dc.b	$00,$00,$00,$F0,$00,$0F,$00,$00,$00

;------------------------------------------------------------------------------
; Erzeugen einer Zufallszahl (Tausworth)
;

Random		move.l	d0,-(sp)
		move.w	RandVal+2(bp),d0	; random value k
		move.w	d0,d1
		lsr.w	#6,d1
		eor.w	d1,d0
		move.w	d0,d1
		lsl.w	#8,d1
		lsl.w	#2,d1
		eor.w	d1,d0
		move.w	d0,RandVal+2(bp)	; random value (k+1)
		move.l	(sp)+,d1
		divu	d1,d0
		swap	d0			; rest of division
		rts

;------------------------------------------------------------------------------
; Drachen darstellen

ShowDragon	movem.l	d2-d7/a2,-(sp)		; save regs
		clr.b	TwoSelected(bp)
		clr.b	FirstPiece(bp)
		move.l	IntBase(bp),a6
		lea	BackGrdTab(pc),a2	; possition table
		moveq	#4-1,d2
5$		moveq	#0,d0
		move.b	(a2)+,d0		; x pos
		moveq	#0,d1
		move.b	(a2)+,d1		; y pos
		lea	RastPort(bp),a0
		move.l	ImageTable(bp),a1
		RECALL	DrawImage		; draw background
		dbra	d2,5$
		moveq	#0,d0
		moveq	#0,d1
		lea	RastPort(bp),a0
		lea	Border11(pc),a1
		RECALL	DrawBorder
		lea	NewDragon(bp),a2	; piece to draw
		moveq	#10,d4
		moveq	#4-1,d7			; 3 layers
4$		moveq	#0,d3
		moveq	#6-1,d6			; 6 rows
3$		moveq	#0,d2
		moveq	#12-1,d5		; 12 columns
2$		moveq	#0,d1
		move.b	(a2)+,d1
		ble.s	1$			; no piece or already removed
		lsl.w	#2,d1
		move.l	ImageTable(bp,d1.w),a1
		lea	RastPort(bp),a0
		move.l	d3,d1			; y=(30*row-3*layer)+10
		add.l	d4,d1
		move.l	d2,d0			; x=(25*column-3*layer)+10
		add.l	d4,d0
		RECALL	DrawImage
1$		add.w	#25,d2			; next x
		dbra	d5,2$
		add.w	#30,d3			; next y
		dbra	d6,3$
		subq.w	#3,d4			; next layer diff
		dbra	d7,4$
		bsr.s	PrintMoves
		move.l	WinPtr(bp),a1		; blit from hidden to real scr
		move.l	50(a1),a1
		lea	BitMap(bp),a0
		moveq	#0,d0
		moveq	#0,d1
		moveq	#0,d2
		moveq	#0,d3
		moveq	#(320>>4),d4
		lsl.w	#4,d4
		moveq	#256-198,d5
		neg.b	d5
		moveq	#256-$c0,d6
		neg.b	d6
		CALL	BltBitMapRastPort,GfxBase(bp)	; great job !
		movem.l	(sp)+,d2-d7/a2		; restore regs
		rts

BackGrdTab	dc.b	0,0,160,0,0,99,160,99	; positions

;------------------------------------------------------------------------------
; Verbleibende Zuege anzeigen

PrintMoves	movem.l	d2-d4/a2/a3,-(sp)	; show remaining pieces
		move.l	GfxBase(bp),a6		, load GfxBase to a6
		lea	RastPort(bp),a2
		moveq	#3-1,d4
1$		moveq	#0,d0
		move.b	APenTab(pc,d4.w),d0
		move.l	a2,a1
		RECALL	SetAPen			; set apen for rectangle
		move.l	#277,d0
		sub.w	d4,d0
		moveq	#50,d1
		sub.w	d4,d1
		move.l	#313,d2
		add.w	d4,d2
		moveq	#61,d3
		add.w	d4,d3
		move.l	a2,a1
		RECALL	RectFill		; draw rectangle
		dbra	d4,1$
		move.l	a2,-(sp)		; save rp !
		lea	MoveFmt(pc),a0
		moveq	#0,d0
		move.b	MovesToGo(bp),d0
		move.w	d0,-(sp)
		move.l	sp,a1
		lea	scput(pc),a2
		lea	MoveBuf(bp),a3
		CALL	RawDoFmt,SysBase(bp)	; make string
		addq.w	#2,sp
		lea	MoveIText(pc),a1
		move.l	(sp)+,a0		; rastport !!!
		moveq	#0,d0
		moveq	#0,d1
		CALL	PrintIText,IntBase(bp)	; show piece count
		movem.l	(sp)+,d2-d4/a2/a3
		rts
scput		move.b	d0,(a3)+		; for sprintf()
		rts

APenTab		dc.b	5,0,2,0			; rectangle apens-> 3 2 1 (pad)

;------------------------------------------------------------------------------
; File auswaehlen && oeffnen

_LVOFileRequest	equ	-294			; ARP FileRequest()
_LVOTackOn	equ	-624			; add filename to path

ReqFile		movem.l	d2/d3/d4/a2/a3/a5,-(sp)	; save regs
		moveq	#0,d3
		move.l	d0,d2			; save flag
		move.l	OurTask(bp),a5
		adda.w	#184,a5
		move.l	WinPtr(bp),a1
		move.l	0(a5),d4		; save pr_WindowPtr
		move.l	a1,0(a5)
		or.w	#1,24(a1)		; Window->Flags | RMBTRAP>>16
		moveq	#(416>>4),d0
		lsl.w	#4,d0
		moveq	#1,d1
		swap	d1
		CALL	AllocMem,SysBase(bp)	; alloc filerequest + buffer
		move.l	d0,a2
		move.l	a2,d0
		beq.s	1$			; no mem for filerequest
		lea	ArpName(pc),a1
		moveq	#39,d0
		RECALL	OpenLibrary		; open arp
		tst.l	d0
		beq.s	2$			; no lib, sorry !
		move.l	d0,a6			; setup base reg
		lea	LoadDragon.str(pc),a0
		tst.l	d2
		beq.s	4$
		lea	SaveDragon.str(pc),a0
4$		move.l	a0,0(a2)		; requester title
		lea	28+256(a2),a0
		move.l	a0,4(a2)		; filename buffer
		lea	28(a2),a0
		move.l	a0,8(a2)		; pathname buffer
		move.l	WinPtr(bp),12(a2)	; window
		move.w	#$2801,16(a2)		; DoColor+NewWindFunc&LongPath
		lea	ChangeFunc(pc),a0
		move.l	a0,18(a2)		; change window structure
		move.l	a2,a0
		RECALL	FileRequest		; ArpBase already in a6 !
		tst.l	d0
		beq.s	3$			; cancled
		lea	28(a2),a0
		lea	28+256(a2),a1
		RECALL	TackOn			; add filename to path
		lea	28(a2),a1
		move.l	a1,d1
		add.w	#1005,d2		; (1005 read) or (1006 write)
		RECALL	Open			; use ArpOpen()
		move.l	d0,d3
3$		move.l	a6,a1			; close arp
		CALL	CloseLibrary,SysBase(bp)
2$		moveq	#(416>>4),d0		; free filerequest + buffer
		lsl.w	#4,d0
		move.l	a2,a1
		RECALL	FreeMem
1$		move.l	WinPtr(bp),a0
		and.w	#$fffe,24(a0)		; Window->Flags & ~RMBTRAP>>16
		move.l	d4,0(a5)		; restore pr_WindowPtr
		move.l	d3,d0			; return file handle
		movem.l	(sp)+,d2/d3/d4/a2/a3/a5
		rts

ChangeFunc	moveq	#10,d0			; new pos on screen (10,10)
		move.w	d0,(a0)+
		move.w	d0,(a0)+
		rts

;------------------------------------------------------------------------------

DosName		dc.b	'dos.library',0
IconName	dc.b	'icon.library',0
IntName		dc.b	'intuition.library',0
GfxName		dc.b	'graphics.library',0
ArpName		dc.b	'arp.library',0
AudioName	dc.b	'audio.device',0
TopazName	dc.b	'topaz.font',0

Template	dc.b	'NOINTRO/S,NOMUSIC/S: ',0
TemplateLen	equ	*-Template-1
NoIntro		dc.b	'NOINTRO',0
NoMusic		dc.b	'NOMUSIC',0
Help		dc.b	$5f&'?',0

Sample		dc.b	'Sample',0
MoveFmt		dc.b	'%3d',0

About.str	dc.b	'About',0
Quit.str	dc.b	'Quit',0,0
NewGame.str	dc.b	'New game',0,0
UndoMove.str	dc.b	'Undo last move',0,0
UndoAll.str	dc.b	'Undo all moves',0,0
LoadDragon.str	dc.b	'Load Dragon',0
SaveDragon.str	dc.b	'Save Dragon',0
Music.str	dc.b	'Play Music',0
Options.str	dc.b	'Options',0
Project.str	dc.b	'Project',0

Author1.str	dc.b	4,0,09,09,'  China Challenge III  ',0
Author2.str	dc.b	4,0,09,16,'  -------------------  ',0
Author3.str	dc.b	4,0,09,29,'    written 1991 by    ',0
Author4.str	dc.b	2,0,09,44,'     Dirk Hoffmann     ',0
Author5.str	dc.b	4,0,06,60,'   rewritten 1993 by   ',0
Author6.str	dc.b	2,0,09,75,'     Gunther Nikl      ',0
Author7.str	dc.b	3,0,09,89,'This game is Freeware !',0
Author8.str	dc.b	3,0,09,99,'       Enjoy ...       ',0
Author9.str	dc.b	2,0,09,112,' (dedicated to Astrid) ',0

		dc.b	'$VER: '
Title.str	dc.b	'China Challenge III 1.1 (2.11.95)',0

		even 

TopazFont	dc.l	TopazName		; screen font
		dc.w	8
		dc.b	0,0

NewScreen	dc.w	0,0			; main screen definition
		dc.w	320,200
		dc.w	3
		dc.b	4,2
		dc.w	0
		dc.w	$18f
		dc.l	TopazFont,Title.str,0,0

NewWindow	dc.w	0,1			; main window definition
		dc.w	320,198
		dc.b	2,4
		dc.l	$108,$1900
		dc.l	0,0,0,0,0
		dc.w	320,198
		dc.w	320,198
		dc.w	15

AboutWin	dc.w	57,55			; about window definition
		dc.w	200,120
		dc.b	2,2
		dc.l	$200008,$31800
		dc.l	0,0,0,0,0
		dc.w	200,120
		dc.w	200,120
		dc.w	15

MenuStrip	dc.l	MenuStrip2		; menu one
		dc.w	2,2,60,10,1
		dc.l	Project.str
		dc.l	ItemAbout
		dc.w	0,0,0,0

ItemAbout	dc.l	ItemQuit
		dc.w	2,2,80,11,$56
		dc.l	0
		dc.l	TextAbout,0
		dc.b	'a',0
		dc.l	0
		dc.w	0
TextAbout	dc.b	2,4,1,0
		dc.w	3,1
		dc.l	0
		dc.l	About.str,0

ItemQuit	dc.l	0
		dc.w	2,14,80,11,$56
		dc.l	0
		dc.l	TextQuit,0
		dc.b	'q',0
		dc.l	0
		dc.w	0
TextQuit	dc.b	2,4,1,0
		dc.w	3,1
		dc.l	0
		dc.l	Quit.str,0

MenuStrip2	dc.l	0			; menu 2
		dc.w	70,2,60,10,1
		dc.l	Options.str
		dc.l	ItemNewGame
		dc.w	0,0,0,0

ItemNewGame	dc.l	ItemUndoMove
		dc.w	2,2,150,11,$56
		dc.l	0
		dc.l	TextNewGame,0
		dc.b	'n',0
		dc.l	0
		dc.w	0
TextNewGame	dc.b	2,4,1,0
		dc.w	3,1
		dc.l	0
		dc.l	NewGame.str,0

ItemUndoMove	dc.l	ItemUndoAll
		dc.w	2,14,150,11,$56
		dc.l	0
		dc.l	TextUndoMove,0
		dc.b	'b',0
		dc.l	0
		dc.w	0
TextUndoMove	dc.b	2,4,1,0
		dc.w	3,1
		dc.l	0
		dc.l	UndoMove.str,0

ItemUndoAll	dc.l	ItemLoadGame
		dc.w	2,26,150,11,$56
		dc.l	0
		dc.l	TextUndoAll,0
		dc.b	'g',0
		dc.l	0
		dc.w	0
TextUndoAll	dc.b	2,4,1,0
		dc.w	3,1
		dc.l	0
		dc.l	UndoAll.str,0

ItemLoadGame	dc.l	ItemSaveGame
		dc.w	2,38,150,11,$56
		dc.l	0
		dc.l	TextLoadGame,0
		dc.b	'l',0
		dc.l	0
		dc.w	0
TextLoadGame	dc.b	2,4,1,0
		dc.w	3,1
		dc.l	0
		dc.l	LoadDragon.str,0

ItemSaveGame	dc.l	ItemMusic
		dc.w	2,50,150,11,$56
		dc.l	0
		dc.l	TextSaveGame,0
		dc.b	's',0
		dc.l	0
		dc.w	0
TextSaveGame	dc.b	2,4,1,0
		dc.w	3,1
		dc.l	0
		dc.l	SaveDragon.str,0

ItemMusic	dc.l	0
		dc.w	2,62,150,11,$15f
		dc.l	0
		dc.l	TextMusic,0
		dc.b	'm',0
		dc.l	0
		dc.w	0
TextMusic	dc.b	2,4,1,0
		dc.w	3+10,1
		dc.l	0
		dc.l	Music.str,0

Border11	dc.w	2,84			; selection places
		dc.b	1,2,1,5
		dc.l	KoordArray
		dc.l	Border12
Border12	dc.w	290,84
		dc.b	1,2,1,5
		dc.l	KoordArray
		dc.b	0,0,0,0
KoordArray	dc.w	0,0,28,0,28,33,0,33,0,0

MoveIText	dc.b	2,5,1,0			; remaining moves text
		dc.w	283,53
		dc.l	0
		dc.l	vars+MoveBuf
		dc.l	0

ImgData		dc.l	$423C168A,$003E1774,$18F61A78,$1BFA1D7C,$1EFE2080
		dc.l	$22022384,$25062688,$280A298C,$2B142C96,$2E182FA0
		dc.l	$312232A4,$342635A8,$372A38AC,$3A2E3BB0,$3D323E34
		dc.l	$3F364038,$413ABA88,$19040E06,$08A00400,$40A0111A
		dc.l	$43576112,$05308ECC,$64021021,$4100E000,$08002838
		dc.l	$3B3D953D,$DE506534,$6A021012,$86180180,$08010428
		dc.l	$56C07C8A,$92B10CDE,$692DC060,$02A62280,$A4342900
		dc.l	$C0E188E2,$3542381C,$960747A9,$41712C41,$228809F2
		dc.l	$8F69D743,$04D42E5F,$01102104,$6481B44A,$59891E0C
		dc.l	$DC9580A0,$C240D115,$40110694,$7884A611,$8372BCC1
		dc.l	$5605687A,$154225E9,$20A24D35,$4D4146B7,$C2128AF0
		dc.l	$D1EE0295,$0C49CD22,$25824835,$D1D04B65,$E038E1F8
		dc.l	$43988802,$500182E5,$0F8B4713,$48A200CE,$7B08214C
		dc.l	$A35811D0,$81422A04,$1001BC48,$3D0EC00D,$001D1F5A
		dc.l	$61804010,$22000884,$88C4E529,$C2102C20,$265D025D
		dc.l	$DF082914,$20280C76,$18A483ED,$9CC21047,$A39946DA
		dc.l	$7920E081,$A240A6B1,$0DC27634,$02030A8A,$E348A622
		dc.l	$A28A0054,$07400E3F,$AA3423B0,$A0001020,$41070325
		dc.l	$00604804,$24740AD7,$04D89A00,$04A99F21,$A39F4054
		dc.l	$41CA5000,$18800008,$95B82802,$09280705,$0FF64588
		dc.l	$C0F1C162,$C2E418C5,$5C664910,$200E1680,$08CF94F4
		dc.l	$21901006,$C6091014,$C11A3200,$115294C8,$0463D078
		dc.l	$31842010,$3ACE2543,$89180840,$00404010,$089F3087
		dc.l	$AF0C1448,$642A0358,$78686440,$3120980A,$412C8CB6
		dc.l	$B5A0D466,$34380132,$17A40040,$21038E04,$01265802
		dc.l	$A50C2169,$15EE4012,$04782400,$40206021,$60A6EA21
		dc.l	$24592051,$2C00042C,$A11381A9,$00F9A122,$00B47395
		dc.l	$CE103065,$C0BA88B1,$21238076,$207F2C09,$0453E0EC
		dc.l	$18428481,$1A020580,$03C02B31,$1277C80F,$C72D9248
		dc.l	$83822C00,$020013D8,$6B002213,$501FF660,$115B4D10
		dc.l	$941600AE,$021072C0,$0AD1E364,$C828A084,$9E378737
		dc.l	$9B123808,$31A812D1,$0A4C1342,$60F0BDAD,$7A4346C0
		dc.l	$14C00200,$0500CE28,$0A46A702,$2486D900,$01EA0A09
		dc.l	$A22CB820,$932290C3,$4145D656,$A245EB04,$24137D20
		dc.l	$32024104,$D848BB48,$2120336C,$084BAE20,$A8628693
		dc.l	$1629C400,$1906AA31,$2E680828,$1F9E660C,$8637A081
		dc.l	$45B80460,$43104266,$0BC826E1,$F51E6EC1,$1266D9A8
		dc.l	$022A0044,$D080213B,$8C2AF239,$489E5A89,$4A638864
		dc.l	$265D0088,$D24078FA,$417F1CC1,$A29FD9A4,$0B26A34A
		dc.l	$865D8411,$ED208F4C,$084B3901,$9C93F415,$0A510F00
		dc.l	$9050923F,$5B0707CC,$4B8905E2,$082E3AEA,$90F0185A
		dc.l	$33B47023,$54B869E2,$D8BFC481,$2049D772,$45DA6414
		dc.l	$0B5EA5AB,$DD580F21,$0AF74259,$E3B89D93,$81B66BA5
		dc.l	$87D8C180,$0BA51EC8,$4CF6C613,$3BEF8628,$59520CC7
		dc.l	$30617551,$9B0821AA,$E1E4E1E0,$84F66491,$1E72409E
		dc.l	$B2E94607,$A510B1E7,$43FF8A60,$F91B791C,$551302A0
		dc.l	$CFA58A14,$AC01110D,$B9ED1412,$348A4BB6,$2500A100
		dc.l	$86180815,$D58A4E11,$4FF968AF,$4A1BB125,$724EA1C0
		dc.l	$81639F78,$AF2ACA01,$5B5CF415,$204DAA53,$0A260102
		dc.l	$424A8359,$4A382285,$05660120,$4DD15F26,$02000115
		dc.l	$949A8826,$6C442F50,$52144444,$0012D052,$11302182
		dc.l	$C8419640,$543868C0,$05EE6041,$C08F0392,$88491498
		dc.l	$7960D080,$193819C2,$8E262028,$0BE2672A,$1040204B
		dc.l	$70C80092,$0C0A0F19,$0159A012,$47840228,$12270A16
		dc.l	$504A9E00,$08D7C120,$08E0B0D1,$8A621340,$00208D00
		dc.l	$9A820410,$881A1100,$3212814E,$20E00141,$590B22A0
		dc.l	$02453404,$8A06C242,$0A2A3D18,$85A83280,$A000028D
		dc.l	$000A0400,$30E15911,$00B8558C,$2D100600,$42085A44
		dc.l	$00D9C408,$84600802,$42898C14,$58510098,$21E02690
		dc.l	$03908710,$6882181C,$C58583B1,$902B0024,$00244014
		dc.l	$E1C2589E,$22003B04,$2298059A,$20840C4A,$51010002
		dc.l	$11C64B00,$78093622,$00C00D82,$44102200,$38002500
		dc.l	$025D8E48,$D226B012,$808183CC,$222920CC,$4009402C
		dc.l	$1C06A120,$838092A0,$AA10EE05,$249A0446,$40041011
		dc.l	$08F9AD82,$DCB04A22,$8E83659D,$B8030008,$0402C125
		dc.l	$80DCED40,$05488A00,$091311D2,$1001C041,$C8448089
		dc.l	$8F2B0250,$6A061004,$B24008F2,$B1601911,$F886F6CA
		dc.l	$8411E6A4,$32820900,$38C03D15,$00B20122,$32A10C40
		dc.l	$98727243,$38880402,$49800002,$80C06753,$08004803
		dc.l	$41425E36,$42310630,$58603401,$4AC78772,$8009CA19
		dc.l	$4120358B,$AA448C81,$42114841,$08540560,$05200000
		dc.l	$2162819B,$42260284,$3F2EA00E,$0A01C360,$2148E0BA
		dc.l	$8048D34E,$A4004E08,$6512050D,$E0024491,$1100800C
		dc.l	$59575879,$94100515,$0E14806C,$40CA0A3C,$A0A28000
		dc.l	$0A3A267D,$9A62080C,$6084F408,$82022C08,$20202013
		dc.l	$30084512,$1405CE8B,$0B45C420,$00089481,$540220A6
		dc.l	$584077A8,$F0993960,$4F905200,$A4841846,$40044226
		dc.l	$0088C944,$C4500205,$B920A422,$300AB344,$1826E691
		dc.l	$04D274B8,$02182A13,$AA324A68,$B81152E9,$0C545104
		dc.l	$DAF149F9,$21612805,$93BBE639,$10285110,$72280004
		dc.l	$80FDA832,$9180166B,$8308F6FC,$0E00C88C,$0002D407
		dc.l	$CA7896E9,$D00209A0,$EAEAB8BC,$8C18ABF3,$020102C4
		dc.l	$C6F3E090,$E02005E0,$4120CF31,$EC50A7E9,$C8150603
		dc.l	$F3628C70,$22301210,$064E67DF,$705AC835,$0140144B
		dc.l	$606E1641,$885E1E01,$049B79BC,$78D8FA1F,$1810A020
		dc.l	$B4C0153D,$00C891A2,$447DB9FB,$FB5C0337,$5DC0177A
		dc.l	$A0A8EB24,$38044424,$4A9FDED7,$B97524FE,$8A50440C
		dc.l	$40E0E834,$031A8200,$02958BAD,$29602F6B,$AAD40668
		dc.l	$A6929059,$09147132,$11D44C7F,$042A965B,$CEB3840E
		dc.l	$44329200,$28A42800,$9503A55E,$04392870,$8268A971
		dc.l	$09021000,$1E20480D,$819CD2FB,$282522D0,$17011411
		dc.l	$88410049,$8A440207,$A8815F4B,$64A002DE,$46101C88
		dc.l	$1E490C01,$4160F31A,$0587EEB9,$66502B27,$62042A07
		dc.l	$1CC8881A,$0DA4D3C6,$2E5B23D0,$06180048,$0B18092B
		dc.l	$5D048010,$3096E845,$008365BB,$51C031A1,$E3200046
		dc.l	$59104C02,$22690295,$12043140,$215360C0,$CB008029
		dc.l	$54199466,$1C426E3E,$EB16D248,$022A0040,$40082474
		dc.l	$90121240,$0C9087E9,$49CF1A8C,$289A700A,$060041CC
		dc.l	$420D0104,$39195DE9,$2211103A,$81E00264,$C00080CF
		dc.l	$81188600,$684ADC81,$80881005,$160A0B00,$00418098
		dc.l	$4C3CC20C,$12000500,$98900F98,$84603948,$A411184A
		dc.l	$6008005A,$42017D75,$6220010E,$09000012,$0220812E
		dc.l	$E044748E,$736800D0,$8FFF3F00,$FF3E00FF,$3E00FF3E
		dc.l	$00FF3E00,$FF3E00FF,$3E00C200,$3E80FF3E,$00FF3E00
		dc.l	$FF3E00FF,$3E00FF3E,$00FF3E00,$FF3E00C2,$7E0A3110
		dc.l	$B9B00F68,$12385E06,$50EEBC06,$00093E02,$4DD23D06
		dc.l	$029A838C,$E00E60BE,$F80460BC,$0359E978,$02609038
		dc.l	$7C18C130,$7EF21B7A,$F818E108,$38F81639,$F8B70379
		dc.l	$F903D041,$A8610621,$F0FA28F8,$0072E080,$0194FB00
		dc.l	$1FEE1AD0,$26F00C07,$32061FE4,$023F884F,$94A9DF4F
		dc.l	$3C1221E7,$37D6C84F,$C0658B7D,$2066F217,$14E08104
		dc.l	$34CF13FB,$8125C8C3,$0F3EB9E7,$289BC434,$C8D9C9F1
		dc.l	$C38D1C97,$903E9EE0,$1FF460B9,$1FEAE0B8,$1F36609C
		dc.l	$003CD100,$D6BE0007,$9C206880,$0C3C3EE0,$143F3EB4
		dc.l	$B00E903F,$CF050F9D,$28131FDE,$E0980F86,$E010DFDE
		dc.l	$D64021E4,$07073424,$1FEEE417,$68E41B6B,$14FE021E
		dc.l	$CD1F50EC,$13392ECC,$B88C3810,$66F91F1B,$07129C37
		dc.l	$CAD5EF27,$F20F372D,$81BFC081,$AA738383,$86603F81
		dc.l	$0C60BF86,$0E60B380,$0460AEE6,$0A920016,$CF20437C
		dc.l	$07E4BF03,$9F39900F,$87870F2D,$70B0433C,$7C61E820
		dc.l	$A8F10327,$F934400B,$34F0F201,$CDDC1188,$2D00FC83
		dc.l	$B8F8091C,$50E81365,$22FE8062,$1F8876FC,$8318F903
		dc.l	$3C788135,$EE37D6C0,$BC302FD0,$20BC60A6,$603C7144
		dc.l	$FC20F006,$360004CD,$63E0D63C,$C198E323,$78B8E334
		dc.l	$40B90381,$E7390084,$1F21A0D8,$4E91870C,$1EA9E736
		dc.l	$E021E706,$E0A0E7C6,$0D72E6D8,$C633BA6E,$5FB8C51F
		dc.l	$C4C80722,$2A287F40,$7DFB03E8,$F040C80E,$283E8EB8
		dc.l	$6F911F50,$21B0FEC8,$BF936854,$9F3688E0,$BF352627
		dc.l	$3F8AEB95,$2F866020,$06593A02,$40A99F77,$0A8ECE20
		dc.l	$36609E73,$B51A80BC,$1F72902E,$7200FE7D,$FEE0228E
		dc.l	$E3233FB1,$A83FA778,$003F86E0,$A4510390,$2FF6E010
		dc.l	$3FCEE002,$0CE820F9,$0FFE0B1C,$863A0946,$C9010ACE
		dc.l	$05143A81,$1008830C,$0D44E4F3,$880B333E,$8812F903
		dc.l	$F0063CA0,$D8B8176E,$0FBD7F40,$69FB8588,$FC7DF141
		dc.l	$8C7C8518,$CE1F50EC,$67083802,$F860BE03,$A8A4C5A9
		dc.l	$838C0782,$B904A3EA,$38E33209,$1EC581F4,$EC3C07EA
		dc.l	$E0B187B6,$60980784,$E0BC0362,$BE000683,$4F7B8C0F
		dc.l	$839F17C3,$050EE32D,$F0E3BEE0,$AFF33EE0,$27F30EE0
		dc.l	$A6FB360C,$28B6D9C2,$2AED050F,$7204561E,$40E60F44
		dc.l	$7223CE4B,$7DE80311,$40F9839F,$B8BF00C0,$07D5C5E7
		dc.l	$2DF2F7C5,$811EC800,$1FF148E0,$B850B460,$B03420E5
		dc.l	$40371BE4,$1F8A7C0F,$8660300D,$A1419E07,$3E60BC02
		dc.l	$34F63735,$BEC031F8,$9FF0048C,$E8A1BFC0,$1F3E7400
		dc.l	$0C010710,$688EB007,$C633F80F,$B274401F,$F6C13FE6
		dc.l	$A3E05142,$99EFDEF1,$200E23FF,$82C7B687,$2F4A4C0B
		dc.l	$DED0410C,$FA44540C,$68F00282,$030A0FFE,$401AE4C7
		dc.l	$21F28188,$7C1F0E28,$6F3F1091,$8C1F18C8,$8138FC9D
		dc.l	$AB0F4426,$787E3E28,$F3F09402,$CF86E0B3,$C0266020
		dc.l	$815C18C8,$077E061F,$F460A00F,$A8FDBC07,$D53A9C86
		dc.l	$1CE0BDC0,$3EE0BFE0,$7EE09FE1,$1A64B2C1,$839C059F
		dc.l	$B60F2C90,$1FD003A8,$3F1D207F,$D002A07F,$02E090EF
		dc.l	$B6E01005,$E231F943,$77E40730,$A21ED00F,$08FE801D
		dc.l	$F64377E4,$90F3B020,$F8806619,$712066F2,$1F60787F
		dc.l	$A0F8402D,$E4D0384F,$7050EEB0,$30091E30,$300A559F
		dc.l	$20AA3020,$1C4FF260,$3E69003A,$C8C0F8C6,$80B6609F
		dc.l	$8139C803,$D341BE07,$069EA8C1,$0873F211,$73A4CF2F
		dc.l	$91FFB608,$68B234A0,$C219D0F2,$0C68F606,$34CE032E
		dc.l	$B1001F88,$C5101807,$2218DF3C,$0211F836,$E252169F
		dc.l	$FFA1231F,$8882FC01,$7801AE23,$0C1ECCC8,$816CF318
		dc.l	$F98112C8,$C80F68E6,$BCF48EE0,$3C38D120,$43002673
		dc.l	$478001CD,$F660BCF1,$1260B81D,$45E05306,$60800C04
		dc.l	$33583F06,$E0A07F0E,$E090C783,$0FD94017,$837EB783
		dc.l	$D00591C7,$3D50F018,$20780C10,$3C92029A,$BA0182CD
		dc.l	$D02FBD3F,$C8D889E3,$C1632122,$06807220,$07194377
		dc.l	$232E7E27,$40DE0FEA,$3DF917F0,$033C006C,$F981441C
		dc.l	$7CC84E31,$BC7FE1EA,$F1240066,$B97F5CA3,$011A6177
		dc.l	$7480CE14,$6AD101F6,$34F8D52C,$780EBFD5,$6048A114
		dc.l	$830F770C,$1741D000,$B77F0D91,$007ED087,$1E3F56FE
		dc.l	$80EEE621,$FFD41300,$58FF8100,$62344040,$1D4AFF01
		dc.l	$0054C805,$7DF4018C,$00073901,$C12F2168,$20B107A9
		dc.l	$72200907,$2F526E7F,$11FFC036,$6E3AF1F3,$10E08FC0
		dc.l	$7E00147F,$BEB8D166,$3E743CE7,$57CADF78,$25CF081B
		dc.l	$E879C804,$E94E9C3B,$F51C1AFC,$5EA001F9,$4CEA1CFA
		dc.l	$2A758EFB,$EE8247F8,$0CE0B823,$BBD28D9A,$9C09C885
		dc.l	$151F1CBC,$5FA00199,$4F1AAAA0,$5BE02BEF,$06A80FA9
		dc.l	$0F07E12B,$65292F7E,$3E73800D,$0E3C6402,$B621770C
		dc.l	$120C9009,$030AF830,$080C9D23,$05FF560A,$190FF87F
		dc.l	$086440FA,$00B82FAC,$E4400410,$0E28D081,$E2980718
		dc.l	$0872802F,$DCCFC631,$CD3728C1,$BF80FC00,$EC33391E
		dc.l	$800327E5,$432AE427,$32BFF28E,$40D237F6,$8AF280F6
		dc.l	$16F94488,$49EF7E0F,$0B528324,$32BF2672,$BFA22628
		dc.l	$14F8072F,$BE98805A,$E0A5C402,$947420B1,$7F072568
		dc.l	$2128BF07,$AFAF6880,$4EA28BFD,$F1101BFB,$17AB000E
		dc.l	$1C401319,$07F00A80,$4580017E,$470011B7,$23080630
		dc.l	$FF108087,$4090A0D8,$2FE000E2,$A0000720,$3F80E8F6
		dc.l	$34801040,$0340F803,$20307880,$A020BA18,$7A8825FC
		dc.l	$01380BE3,$01D8702B,$E4009CA0,$1CFC09C0,$0FC0073E
		dc.l	$37F3DAE2,$C52FE5BF,$C5084BB1,$D5F4E0B4,$55C16432
		dc.l	$BD086038,$BE2C60FE,$6560B45D,$5A7B7A81,$1770B266
		dc.l	$B07E2497,$37147222,$1217BA3E,$8EE098BE,$2EE0B29C
		dc.l	$A6E0345D,$16724029,$DBBF98F1,$0FE38032,$BF5FFC03
		dc.l	$BFFF8822,$0AE001E9,$01E53E9A,$7FF8C6F9,$81F90178
		dc.l	$0008E381,$283CE43C,$80073494,$FF34827F,$01F901D8
		dc.l	$1F27F203,$22CA0F44,$E6EB57A0,$B9382BB2,$6CA8B672
		dc.l	$03365D34,$7F44E496,$6F14606E,$A260A823,$60AFB441
		dc.l	$6013BFF2,$22609FD1,$FC27C535,$3F94C80A,$5D10E02F
		dc.l	$BE372880,$6982A516,$947F46E0,$B17F16E0,$253E52E0
		dc.l	$28BE8AE0,$AFAEFAE0,$F24CE0ED,$23811AC8,$3F0F680E
		dc.l	$E0012E13,$39C00A2A,$8B9041C4,$13511A7B,$A0561980
		dc.l	$7C458C3F,$2FFF2041,$B2481B44,$3280AE12,$B0F100FC
		dc.l	$D6383EC1,$22300310,$4159381A,$800F2032,$E001A022
		dc.l	$02EA3CE3,$FE052221,$F89F207F,$1583BF81,$13F000EE
		dc.l	$33190023,$390FBE2F,$80F003B0,$6FEE7800,$0F800663
		dc.l	$E82121F2,$3FFCF8E4,$291ED5F4,$60B21424,$E0B8B688
		dc.l	$60F891C6,$60301F40,$23681C04,$60FC41F4,$016098BE
		dc.l	$8CE0B27E,$200FFF0F,$3EC0920F,$A8BE8EE0,$321C26E0
		dc.l	$B7DDF6E0,$90F2745B,$1D871FC8,$FFFEE040,$3E80171C
		dc.l	$067F082A,$0E1C5027,$007FC301,$CFFC6320,$57C702E2
		dc.l	$FF28220A,$0788FE01,$B0FB07D5,$1822087F,$900F4C10
		dc.l	$07301404,$F2F4F7FC,$748825E0,$FF40C07F,$80072003
		dc.l	$801FF5C1,$F0D08318,$3AFC0380,$CA0F44FF,$7E408031
		dc.l	$F8BE001C,$3E0034F8,$B81C30E4,$E3E70906,$03D93616
		dc.l	$1060BF94,$03A0F081,$0C2B9EE0,$0058D13B,$B0008247
		dc.l	$9000C1AE,$00A38042,$800337B1,$78FF706C,$F7039591
		dc.l	$F8DF587F,$F70083CF,$012E855B,$087C04F3,$005EB8D4
		dc.l	$0F28167F,$64E3018C,$2C073CB4,$CF04CB8F,$1FFE6E72
		dc.l	$0307739A,$0FE30F0F,$C13400E3,$1DC874E2,$000E5134
		dc.l	$06F87020,$5F881F0F,$0F9C3940,$0F3E0307,$A47A1288
		dc.l	$4730D39F,$00287B02,$3991DFF0,$D0F1211C,$6AF98466
		dc.l	$E655DC9E,$0196BE0A,$1DD53C60,$BEF60572,$9E609D3F
		dc.l	$ECBAF2DD,$B5BBAAC8,$009B49EE,$059FB602,$B1DBF886
		dc.l	$13BA3F80,$0D35307F,$2FEEFF83,$1C747F03,$7F78FF85
		dc.l	$7FD2FF66,$E2A0FF0D,$8A4EFF0B,$437F51D6,$F4FF3749
		dc.l	$397F1FFF,$DC7F0AFF,$E87F2AFF,$A87FB6FF,$B07FAAFF
		dc.l	$A07F097F,$407F2F3E,$407F10F7,$8005A203,$30FD0006
		dc.l	$22293F09,$F101F737,$B45F03AA,$7C4007AA,$B502FD23
		dc.l	$830E7FD8,$D1233F3D,$18FFEC00,$1AFE1C00,$1DBEFC32
		dc.l	$A87F3829,$8CF77822,$47DDD103,$14606790,$A40601FF
		dc.l	$091C00F7,$A9804E94,$39F9F7E8,$2985701E,$BAE4442E
		dc.l	$70118B1D,$2F30F640,$3EFAF340,$0E44E807,$B0760C0F
		dc.l	$30901703,$B9D895F1,$E241DC0F,$28088E1E,$C1C47F01
		dc.l	$C1C8503E,$A9818808,$FC530446,$DA0EFD40,$0FE42F76
		dc.l	$2ABC382D,$F7BF0FF0,$C11701B6,$66830700,$700EDD69
		dc.l	$05D5D096,$532A3A0A,$FF656C36,$F7B6147B,$DD823B27
		dc.l	$E3F2001D,$635C002A,$E3AA0031,$DDC6000B,$FFE80002
		dc.l	$77200004,$77100004,$D5900004,$C9900007,$94F00000
		dc.l	$B6800000,$4103CA01,$5AFC1766,$E2F7079F,$E386093E
		dc.l	$C10D7216,$38B1F01E,$91FC50EB,$ADFCA875,$21F8143B
		dc.l	$A031CEE0,$9127E6E0,$11E1F6E0,$0A150A44,$66F6240F
		dc.l	$68F19081,$CC0320B8,$F7A00E19,$50EA6820,$CDF6FB03
		dc.l	$9AF99E99,$EC3EA3E0,$EED1250F,$E41717E0,$7441B0F0
		dc.l	$03807134,$41AC707E,$C1E0A7DA,$A0E0D33A,$8021AA1D
		dc.l	$00610522,$6EF8B388,$038911C3,$98790844,$D4FFDCFE
		dc.l	$00F1A5BF,$F8C29FE0,$F85340FC,$B3FA17FC,$048FA078
		dc.l	$020A60ED,$3DAE41A5,$207FC6A3,$DC79F253,$EC70E820
		dc.l	$790724B4,$1F8846FC,$07B86091,$5F619071,$00A00719
		dc.l	$B41F888C,$A77CAEE0,$B1F3D37D,$BC00CA27,$7734F83C
		dc.l	$36048FBE,$C1A6603E,$F51C0E54,$606F04CD,$7E33A2FF
		dc.l	$B1A0E184,$73008E1A,$79E38A82,$47E782C1,$E4A34717
		dc.l	$C026A280,$A87880E7,$92947CE7,$2A3D6FA3,$75A040A4
		dc.l	$3B93CEF4,$80F9E682,$477F8120,$D8F23F0C,$24A00016
		dc.l	$79002D68,$00BCE04C,$89C124BE,$A0718127,$B8500EF9
		dc.l	$03203890,$B0033958,$7C00221F,$287E020E,$C324389F
		dc.l	$B819C82C,$402013F2,$61401800,$0C000E22,$387F88A9
		dc.l	$8C0DAA54,$03EB4662,$013E3440,$01494000,$07FFF000
		dc.l	$0FFFF800,$1FFFFC00,$4EDA1F80,$16FCFC40,$FE66000A
		dc.l	$731E8633,$E7E38424,$12C63AE3,$C04819A1,$C28B82CD
		dc.l	$C1E60DBF,$F803BFE0,$34409F88,$02419CA7,$411F3E06
		dc.l	$824E1C0E,$E093881E,$E0AFC03E,$E027E001,$B8377CFE
		dc.l	$A001FE2E,$FF83FF14,$7F07F788,$73D86182,$FFC3C0A2
		dc.l	$41E3C2FF,$1FF7C00E,$B0933184,$411FF863,$801FDE7F
		dc.l	$3FE601BF,$9C3A40AF,$3E03B43B,$062F8818,$11C0A040
		dc.l	$42600339,$B03F50F7,$3CD8FF1C,$6CEFA6E6,$8CFD0299
		dc.l	$FF81C0CC,$00EAE6B7,$E6603E7C,$7100E869,$C4A05148
		dc.l	$0FAC6417,$E631B707,$917220AF,$07277220,$07399208
		dc.l	$3FD8000C,$64100632,$02A2AFA0,$80698ACC,$812C3E90
		dc.l	$7F18C80C,$800F1080,$C06FA88C,$81081C2E,$C8816420
		dc.l	$90389039,$FC152836,$90F21C2A,$90093E0A,$C0EA1C03
		dc.l	$99C101CC,$B603D97C,$C638A066,$6C0FF090,$1703B739
		dc.l	$909115E0,$AF1C6790,$27C17E82,$4EC10133,$D801D64F
		dc.l	$246E3400,$837F0FC0,$EA1C0398,$940F4872,$20A301DF
		dc.l	$206420B0,$1FA87220,$08072E72,$6F7F101C,$0E981CE9
		dc.l	$60148036,$BFF7A8FC,$43C0103A,$C1AAA009,$1C26603F
		dc.l	$3E5C1AA0,$7E0E3E74,$D2311C6A,$EA18C136,$058DC182
		dc.l	$4ED10208,$C1FC011E,$80031083,$F9246636,$389CC6A6
		dc.l	$3C99EFC8,$00042F08,$56FF0101,$EE1D1C54,$D00458FF
		dc.l	$807F2274,$60DA3462,$0A781C14,$98031CC8,$0A401030
		dc.l	$0C3E0341,$7F8007E0,$00443E1E,$CE862719,$E0832610
		dc.l	$0C401BF0,$00BFA008,$03500040,$BEEA2060,$BFF008BA
		dc.l	$9AD3F86D,$06D0C6B8,$360C6023,$AC4C0F27,$C9F060E0
		dc.l	$1360E92A,$E060B82E,$0A2BA660,$9FFFFCE0,$BF57A8B8
		dc.l	$0E0398B4,$914FE007,$3800A71D,$87C9F2E0,$A3C8DFE0
		dc.l	$382E1AB8,$3E0EA447,$6F1A13FF,$64800A1D,$FEE086A4
		dc.l	$E0826E13,$2635A0C0,$5FE0C05F,$F79FAE4D,$DF0115DE
		dc.l	$0F0FF66A,$842C0656,$380EA21F,$889A83E4,$240F8FE3
		dc.l	$FAFFE013,$E90080E2,$FF0390E4,$07A8FF20,$00024788
		dc.l	$0030FE41,$2303A3F9,$90AF030F,$39902FE3,$F87F0380
		dc.l	$038390E0,$7F18400D,$3D903040,$AC07B5E2,$3940808E
		dc.l	$7FFD91EC,$7F7F0C50,$3F01FF00,$00000003,$00300040
		dc.l	$00800100,$010000C0,$02800300,$05000607,$08080709
		dc.w	$090A,$080A,$0B0C

	IFD INTRO
PicData		dc.l	$5E042716,$1FB8AF0F,$806215FB,$2DC847DB,$9C004407
		dc.l	$9337943C,$09200A60,$0D000B90,$0ED00AAF,$07B0FF7E
		dc.l	$E33BCD9F,$C508B41F,$F3E5308F,$2387419F,$C35C0517
		dc.l	$E68B2BF7,$02042200,$605020C6,$6F6A400C,$02A49524
		dc.l	$BDC24052,$6F33B91B,$DE751F90,$BEDC02B3,$E504D51F
		dc.l	$F9300340,$08049048,$C4E9591E,$9D10101F,$1414A5C2
		dc.l	$4402CCCF,$19FE03E0,$833A85E9,$A0181FC6,$0FFB8D10
		dc.l	$C85766A0,$00131204,$60C00455,$1B7E0742,$01C380D4
		dc.l	$2204A129,$423C811C,$04FE66C7,$265EA842,$08C40409
		dc.l	$4FBA1BF8,$FB203640,$0EAF0203,$8C29903E,$1BF1BD80
		dc.l	$1642C010,$012104E8,$C42AC148,$4D17BE55,$E2527A10
		dc.l	$0361222A,$84008C8C,$CC131AE7,$23011024,$0A0012A6
		dc.l	$07024A58,$0C93479C,$B31A0501,$209FE301,$A96BC520
		dc.l	$B3A84AE1,$E2FC2713,$28203110,$683E1220,$4020496B
		dc.l	$0011FE1D,$19F60306,$C1410328,$40481692,$008000C4
		dc.l	$03C710D9,$7F8CD980,$04025804,$26080015,$1C2D8088
		dc.l	$FA283516,$FB250C12,$010BD230,$DA6B210D,$104882C2
		dc.l	$902EE519,$E477428B,$59839210,$3C888402,$440404E2
		dc.l	$1416FD5D,$89BC9000,$55832862,$EE5F9539,$B2F369F8
		dc.l	$43EF5015,$04393E42,$A163000E,$1140C0A9,$94C59F9C
		dc.l	$18028841,$FF8D026B,$000A121C,$691154A3,$D13B18E8
		dc.l	$9603A16F,$6B039EF4,$80625214,$D0D49E8C,$1800C51C
		dc.l	$849F9AF4,$442A261A,$3A8AA39A,$D1F5E315,$442A7C06
		dc.l	$D01545D5,$068F3CA9,$0B1714FF,$290E7C02,$1EBC6002
		dc.l	$2057906D,$9A31464C,$13FE6F35,$F19C7C31,$7C4E4517
		dc.l	$70E2864E,$15F1FF16,$2B24E189,$E80BC42F,$206B209F
		dc.l	$D6A23C08,$0F111443,$04FE1D06,$690488D4,$20B9373C
		dc.l	$17FC10C3,$04839E69,$7106643B,$9012FEC4,$16F80518
		dc.l	$A2130948,$1A23C822,$443DDC2C,$2716C652,$8A62CF2C
		dc.l	$74CC3768,$B6B0810E,$9315E237,$6771E1AB,$E08423F4
		dc.l	$823A08B0,$6977F387,$F2200FF8,$90BA412B,$7CA49FFC
		dc.l	$32A19CCB,$384C8A15,$FF007637,$846D74E8,$486921AC
		dc.l	$D6B78BFC,$EA3C16FB,$A218FEF6,$74E8C279,$47C3FE9A
		dc.l	$4BBCF83D,$1503E24C,$F584FE06,$D364274A,$515F8227
		dc.l	$F2C17915,$FC030EBB,$F9899FA6,$6F89001A,$DD14F19C
		dc.l	$01DE15E4,$053471F3,$0327CD8F,$2E021E69,$1E6E89E3
		dc.l	$EC13F8DF,$88D8520F,$7004A434,$4F0D527B,$9AB7640D
		dc.l	$F6181F0E,$820939EE,$BBE9EF60,$2AFA4498,$07010D18
		dc.l	$F66F8F0F,$3F03F125,$DCFD7E94,$94733E91,$9D9D1BF0
		dc.l	$FE504F90,$1413EFCA,$5C36FFC9,$3BB488C5,$B95EA9FB
		dc.l	$4C7C8715,$FCBDA05C,$D604A421,$43984EFD,$3F8EF5DC
		dc.l	$4F901418,$8C26D5CF,$9FC057B4,$8869F5FA,$FE9DE8FC
		dc.l	$4F261535,$BD845F3F,$0BE9DF3B,$16F46808,$770E851F
		dc.l	$7D04101E,$AC70A6BB,$FFC41FF4,$892F9FE4,$271D487C
		dc.l	$342615E4,$A35A3D3F,$1BA57945,$B53A7A4D,$8E94E413
		dc.l	$14E47E3B,$FFEB903F,$31387D2C,$FB834FEE,$11659F20
		dc.l	$147BDB2F,$D8D43F81,$45E968BF,$EBEFA3CB,$9DF90914
		dc.l	$F9BDB9FF,$6C5FED38,$77FD249E,$A00D80FF,$7A1F8814
		dc.l	$C96EFF57,$955FCF94,$4F798730,$EDE0046F,$9FF29F20
		dc.l	$14F2C5A3,$F27F2D8A,$479E9571,$C0039ED6,$BBC69578
		dc.l	$14FCD836,$4F7DE34E,$63E813DD,$8001E996,$B9E73EFA
		dc.l	$0910BF9C,$F20F6BBE,$59A77F03,$98012405,$F5F6DFF4
		dc.l	$2414FC5E,$EFF65B78,$9343999E,$01642101,$BFBDE717
		dc.l	$6114F1FB,$FEB40023,$7B732CFA,$49F17FBB,$464FE014
		dc.l	$F07FF7CA,$2B4CEDBF,$30A6E2FF,$7DFBDFC1,$13E101FA
		dc.l	$DEC70B87,$F14B278A,$605D2F67,$618713FF,$21CDE2E9
		dc.l	$F900E731,$8A3CBFCF,$C7E187F7,$AF4BFB7F,$7C1E1DF4
		dc.l	$073CF027,$FEBFF027,$14E0BFF7,$7BC7160E,$1FFBFD7E
		dc.l	$DF7D0FF8,$4F00FCBF,$7FBA070E,$1FFDA7FF,$9B8615FD
		dc.l	$F71F160E,$F81F1FE2,$4814FBFD,$A73C850E,$F9375FF1
		dc.l	$A11307BF,$7D2BEEA3,$1E10D0FD,$E717EC5F,$2EF73DF8
		dc.l	$AB13FC13,$70DFE236,$BB05FFBF,$BF13177F,$7E9370F7
		dc.l	$15FB3C15,$E9DF97FA,$52A17F7F,$B0FB1315,$E1EFFFEF
		dc.l	$77D1D007,$FBFE0918,$F85F6D74,$DF837027,$13FA8072
		dc.l	$BC77B13F,$1DC1EF53,$EA4F28F0,$016C7C24,$82BF463C
		dc.l	$25C12F97,$F109237E,$43183F1B,$C1F786FD,$091DBE30
		dc.l	$E226803F,$1EC10F2F,$4622FE04,$219F630F,$CC3F14C1
		dc.l	$F74085F1,$041A5F4C,$4CFC090E,$BEC313F2,$4F0EF0E9
		dc.l	$C5C49F6A,$E017C525,$E3092A7E,$9D98F813,$137CA530
		dc.l	$F1270EF8,$6E13CA3F,$31C15701,$E3276AF8,$0C883FE1
		dc.l	$96E82466,$DE3E14F9,$270EF8FF,$313E20C1,$97889D18
		dc.l	$9FC1271C,$F8F8F009,$5F313E16,$C1570523,$7F027F58
		dc.l	$7C3B4CFD,$091707FE,$AFE6271D,$F8580FF0,$37CD4F16
		dc.l	$F0F5C0C0,$E09FC80F,$4F04EF97,$15FC13C4,$C3144FF0
		dc.l	$39F11316,$FC0430F0,$27B8B74A,$15FE09EC,$1F5F323F
		dc.l	$1DC14723,$9E1EE007,$2DF02788,$7F44E05D,$15927F82
		dc.l	$78243C3F,$E1441B3F,$59811F2B,$2A129F00,$DE25993F
		dc.l	$34C14F51,$E04F004F,$C7C74F30,$E215F34F,$101F537C
		dc.l	$354E1CF0,$6313F813,$DC2FFE14,$F9279017,$2D268813
		dc.l	$1BFC9C04,$7E97F058,$CA3901BC,$249DFA13,$11FC383C
		dc.l	$415EE2BB,$3816C15F,$47E04F60,$5F3416E6,$E7277E02
		dc.l	$F0AB381C,$C4179C1C,$E00F134F,$1FF0118B,$4FE0E055
		dc.l	$430A7F0F,$FB17FB27,$7009E213,$1F7C0EE2,$13C8B3C0
		dc.l	$127F183E,$29FEAC29,$C06BCD30,$112A4A93,$F9BA39F0
		dc.l	$F47EEC4F,$203F47C4,$A03499B7,$849FE0FE,$5E4480D6
		dc.l	$6066119F,$40BE00F0,$27984785,$FC978065,$0BE60A2D
		dc.l	$F1A30EE7,$BF27F358,$F00980DC,$28B58C80,$F8D10EF3
		dc.l	$F9C1C867,$25FCBE2C,$4315FC8B,$E48F0F9E,$1F24667E
		dc.l	$84FC7822,$0324F23F,$7A0FFE6C,$9CF9159C,$37E3A149
		dc.l	$FC8F109E,$FF80CCFF,$E109EC7F,$F4D05720,$F015CAFC
		dc.l	$0992EC98,$D08CFC8F,$109E100F,$2AF903F0,$E460FEE8
		dc.l	$89B740E6,$7FF4C87F,$E999C724,$9EC0FE47,$10CF9F50
		dc.l	$E67FF41F,$7C31855E,$F1000219,$09F13F7A,$10BEF681
		dc.l	$8114FC1F,$3D1381FF,$4727DF0F,$4EE67FF4,$1FFCA765
		dc.l	$FE47FFCF,$57BA11F3,$7FF41CFC,$77D8FFE8,$1BF9EF0E
		dc.l	$F8409F92,$FFD111F3,$10330EB4,$8090FFA3,$071740BF
		dc.l	$3C0EF680,$1DDDC5FF,$E811F942,$34ED0EFE,$24329F8D
		dc.l	$0FE70110,$EB210EF8,$D58B3F7A,$14BE5734,$220F1F05
		dc.l	$F33F7A0F,$04BE9D0F,$08FE39E6,$3F7A11BE,$1D12A0BE
		dc.l	$F83AF91F,$3DF7A47B,$127EC101,$8FC8FFE8,$A90102D7
		dc.l	$0111FECF,$437C8DFC,$8F9EFA13,$13FC5743,$0F13F94F
		dc.l	$14F8ED13,$C847814C,$8DBC04EC,$1712F13D,$88E37715
		dc.l	$FE8F119E,$04BF8314,$FD44E347,$11CF7FBE,$430FCEC6
		dc.l	$FE4712CF,$FFBB330F,$ABE65E8E,$6803FB9B,$00C00915
		dc.l	$419F6302,$016880F1,$01D8458C,$831508FC,$1B670F3B
		dc.l	$882389E2,$44843510,$FF47CFFD,$0946F024,$8044184D
		dc.l	$177CB538,$E12610E0,$13F8471F,$CF4F85E3,$2720B089
		dc.l	$1BFE0077,$08423C04,$01431EDF,$80043F81,$10AAD261
		dc.l	$673E0A18,$10FF1414,$4E0860CF,$1FF70708,$01388021
		dc.l	$0E74F31A,$781B04FE,$8F27BE01,$FFA3FFEF,$0FE57EF9
		dc.l	$00FFF800,$CCF88937,$D6451BFE,$02EAC916,$911FBF8F
		dc.l	$024D46E6,$BE13E42A,$30FE8238,$43C42CF1,$DBB703F1
		dc.l	$94C0FC87,$7F7CDBDD,$649281C4,$F9FFCDB3,$4CFC0D9B
		dc.l	$A7DF7221,$62FF9FA7,$6B61FC4A,$0CFDE006,$26FBE69D
		dc.l	$9BEE2D7F,$82BB7453,$F06E26A6,$4329213D,$BFAD6F33
		dc.l	$B91B2E08,$7EBCF7EE,$EF73029C,$B7279A1A,$A82D6FFE
		dc.l	$FD932DE7,$864231F0,$F77ECDBB,$EFEC0D48,$FA5D6C1B
		dc.l	$BF763446,$54093C8D,$BFF7FB6F,$41446942,$8D816002
		dc.l	$EF6FDED2,$E2823F1F,$1E3044FF,$07689634,$EFEF3D28
		dc.l	$EB4A8589,$FDC820E0,$7181838C,$4FDCF967,$4FD39901
		dc.l	$BF01277C,$C59EA586,$F7E7BFDE,$0387F4F8,$870EDB6F
		dc.l	$449C21FF,$5FFFECED,$FB9F3F40,$991BDF01,$BDFE3C7F
		dc.l	$2BDDFB5E,$D6BD4FA0,$1CFBBFD9,$B189176A,$BDF73BFB
		dc.l	$029E19F8,$7D8931C9,$BF7845FD,$FC7381F4,$1B89EF15
		dc.l	$7FE90246,$EFFEDEFB,$27560946,$6A0EF2AD,$0E92ADAF
		dc.l	$C7EFFC9E,$DDD52CF7,$73733A01,$1ADCFEEF,$DBF5FFED
		dc.l	$59F8FDB5,$A7F36C7E,$0019EC2F,$3F980C8E,$FEA36B3A
		dc.l	$DF4C577F,$A08C19FF,$2BD7DFCE,$EF97C1ED,$DFBFDFB6
		dc.l	$94FFEE92,$9415FD6E,$F93EBEFC,$D7BFB7E9,$6D70E5BF
		dc.l	$3B468573,$1215FD26,$7FFBFDA7,$FB7CB6FF,$EAE3D231
		dc.l	$8FAB1015,$E54FC0F3,$EDFEF42D,$1A5E6FFF,$F2EFB77D
		dc.l	$3D6FD169,$10FCFC7F,$7E0D21BC,$5BBDC80F,$7C6DEFC3
		dc.l	$777BFDBB,$FBFBC4E9,$EACF5FED,$E8FFDFFB,$6767C262
		dc.l	$436000AA,$7CD79D11,$7BBFC64D,$0CCF7C02,$C2DDF716
		dc.l	$6E583E31,$CA7A773C,$8588FBC6,$E023369C,$FFF1EEBF
		dc.l	$3F566B3A,$9AE0D9F7,$F4FA4E28,$FE7FE58A,$87FD77BE
		dc.l	$FC89A305,$94E005ED,$E396EEAB,$5C0900D3,$F707EFF8
		dc.l	$FBCE08FC,$DF7B7F27,$8469FC5E,$27DBD0C0,$019DADEB
		dc.l	$2F2B9F94,$0E6B7E6F,$CC137A00,$9F7BF6F7,$103AE37B
		dc.l	$FA931F68,$8555D9E5,$C575F319,$43F7F7EF,$BAAF30F8
		dc.l	$3C63C4DE,$83E87FBB,$D52F8D6A,$1E0F2AF9,$70C3A506
		dc.l	$3C8FC704,$083AF48A,$EE88D4F1,$DF9F21E8,$3CA09CDF
		dc.l	$A86F9265,$8F0016C8,$9FE4F378,$270E8BC8,$BAE88F1D
		dc.l	$D02915FE,$09E5E9D4,$DBAED2A2,$8BC050DF,$94DF4695
		dc.l	$07627F42,$F312EEEB,$BCFBAF5E,$179D7A8D,$772BDF63
		dc.l	$60181F0F,$81C177FE,$DDBF664B,$EDE83CFB,$7C27A23E
		dc.l	$4F799BC4,$6FE4E497,$0EDB3770,$89A06E9D,$354EC58B
		dc.l	$BC2FA9E7,$5DEC9FA2,$25455DBB,$C223D3E4,$03D39A77
		dc.l	$DF011EED,$37EFFFF5,$7EDDBBC0,$49AD759D,$9B6C692C
		dc.l	$BA081749,$4F7E0C93,$A2BB3F0C,$1EE0F7EE,$7CFF6649
		dc.l	$6B988E1E,$5482F3B0,$E82257F7,$4F96E7F0,$89D1374F
		dc.l	$04FFB7CE,$FDFB7EED,$9FDA6F45,$BED45502,$D227EAE7
		dc.l	$5E63341C,$2643FBF7,$DFC714FE,$2718F1F2,$4089137A
		dc.l	$4B5B89C8,$FE4F442B,$C15E5329,$48749F4C,$82071FA3
		dc.l	$ACC3FFFE,$045DE7F7,$FB27D42B,$A2993C01,$65B4DFC1
		dc.l	$D22712F8,$1DB30A7B,$2F7ED14F,$35AEA07D,$D860E81C
		dc.l	$EFAFD5CC,$F1440676,$7F92473E,$916522EB,$0E63F9FE
		dc.l	$A38F10E0,$FACB8E0C,$FC3F99BE,$50E196E1,$91762FFC
		dc.l	$1D15F927,$ADF08FF9,$484B9FC8,$F2AD8465,$486F2714
		dc.l	$C8F6C611,$44167FCB,$E9613067,$F8FEF2E7,$DECAD312
		dc.l	$13DA2302,$81FC334A,$0C8BC862,$62E40F01,$AF2714C8
		dc.l	$EC1035A3,$C9FF6444,$5A443A46,$A15604B3,$BE431542
		dc.l	$5FA3297E,$02D25EC7,$B102C071,$0A23F209,$14F2E773
		dc.l	$D92A6BCD,$458741E3,$960A0501,$62172714,$C8F8CA42
		dc.l	$7BA07F67,$415A8D01,$E90B97F7,$882B79A2,$14FCE153
		dc.l	$8F59882B,$3A1001D0,$601BD8E2,$B7F18914,$F2801B5C
		dc.l	$A5C283E5,$E84F4AC5,$85B2716B,$F00914F2,$81C40014
		dc.l	$6F9F9847,$8EDE7CB0,$11EE9AFC,$C414F884,$24D0272B
		dc.l	$3F4D3AF3,$6214105C,$3462FE64,$14FC4246,$0093A0C7
		dc.l	$A695E061,$5C027F00,$853E740E,$F2670091,$00A86AA0
		dc.l	$1E279E06,$D6600112,$10039060,$0D9E2814,$0D3A5C0D
		dc.l	$7F2D8A38,$3E672E61,$29441E40,$13F8FF27,$858F3082
		dc.l	$48411C8B,$C8229E16,$69840008,$12BF5340,$630C1094
		dc.l	$CC1B5DB9,$D838C60A,$0920313F,$87F77168,$44FEA110
		dc.l	$AC69D496,$58928E2F,$404218E1,$89E85534,$F2022885
		dc.l	$7F04014A,$001C6302,$D4D35FE7,$E444B92D,$CFA0FC59
		dc.l	$C4184BEF,$B7FE8008,$3470EE32,$097F7666,$82047B1E
		dc.l	$41E8FE1E,$4C34E207,$E0FA0521,$0F84F1B4,$71E7E4A2
		dc.l	$D0BFBB1D,$2A8A8802,$AFC0AF41,$BAFEFC40,$32F35316
		dc.l	$E325E3C8,$0B40309F,$0FFBDB94,$0049840F,$F188F181
		dc.l	$C4BE9480,$A4813A16,$0F01401B,$FFF5E77F,$50DF5881
		dc.l	$EFDFDEFD,$77035AEF,$51F44008,$23F55134,$E404125F
		dc.l	$FDFDBFBD,$EBBF5E34,$BFD77B31,$F7EF95FF,$D6EDEC02
		dc.l	$03C0F21A,$A30F065C,$171F914E,$EDCBF7BF,$FB18ACAC
		dc.l	$E880C0BF,$FC18B82D,$87100C04,$E01FBF40,$FEFFB62A
		dc.l	$650EF1F9,$DD845477,$BC023942,$102D1028,$A01AFF9E
		dc.l	$FFEFBD7E,$813F8CE7,$BF954F23,$BEFC9FF8,$40050830
		dc.l	$26930F01,$10257FFF,$C2F68A94,$3CC32BDD,$FDE31267
		dc.l	$E2FFB4A6,$89400AD0,$39217320,$023BFF6F,$50DFF700
		dc.l	$846258EE,$9F3BC527,$D5F7B820,$50402A55,$A6CB0208
		dc.l	$500FC534,$FB87FEF7,$B0D932E8,$9F81DDFF,$B7FD7880
		dc.l	$5C049025,$640FF007,$29BDFEEE,$BFFEDD6C,$BFBFAEDB
		dc.l	$9FBBE37B,$7DEBEEF8,$08202010,$578F0F80,$0E888049
		dc.l	$9DDFFFCF,$F7F9DAED,$FFABFABC,$7E77B782,$FBFDE840
		dc.l	$A010D6A0,$560FBF0F,$0DFFFDDE,$7BFAEFEB,$77EDDF6E
		dc.l	$FDF6CFFF,$EAFFFFF8,$43AF3646,$C6976AEE,$8EF3DDAF
		dc.l	$FB05E97F,$7F739E8D,$6FDADEB9,$BF797805,$EB238A88
		dc.l	$EE7C86F6,$BB533F7F,$FB79BEE3,$5FFFC9EF,$DDF2EF7E
		dc.l	$DAF4D6FF,$FE242021,$8407403F,$C9C7461E,$33A2198D
		dc.l	$7F9F65A6,$FDFF3DEF,$3C7FCD4F,$933FF72B,$EF4DAC30
		dc.l	$A0812010,$8F784F00,$768031F3,$8B0F7EDB,$94B75BF5
		dc.l	$C4EF2BFE,$F1AE5FD9,$5FECE7FB,$FC410B21,$E141FF56
		dc.l	$E38CA82F,$6DF3AFF7,$A7DF153E,$EFAE1F3B,$FDDCBF17
		dc.l	$4D3FA1A2,$408F2142,$3DC31801,$D81C2104,$89F82FFD
		dc.l	$E5F8CDF6,$BDF4BB5C,$72BD5BFF,$861B34F8,$02410058
		dc.l	$A4559E20,$BC005C05,$10205B36,$D5707686,$6EE8DEC5
		dc.l	$264BD5AF,$07FBDBFD,$7CF97044,$01802408,$CF755E00
		dc.l	$AE8110A5,$056CFF7F,$EAE47FEB,$BBFD73DA,$F49EEE3D
		dc.l	$7D7BB7F8,$92B0054F,$8F210004,$1B160C01,$5532C02A
		dc.l	$808DFAFC,$7DA9225B,$B72F87FF,$E675EFA6,$CE8DDF7F
		dc.l	$C1CD5499,$142216BA,$1CDA0178,$7EB42010,$14BE8F6B
		dc.l	$5DEC736E,$FFE4BECD,$B2BDC03E,$7FD4563C,$81283528
		dc.l	$05F4F185,$E59382EA,$1250B834,$7A300120,$612F8327
		dc.l	$F6FDB5BB,$776F7FA3,$F2CF383F,$CFE3B980,$80009C24
		dc.l	$34C00002,$91C9B614,$E81CA80A,$08421482,$3FD6560A
		dc.l	$DE4C8DD5,$C58D98BF,$7C2AF5C7,$95034E28,$4115742E
		dc.l	$3DCB0666,$0FE75550,$6001ECEC,$6F9DB49A,$E687ADB7
		dc.l	$6C326EE2,$DDD03B7F,$F2220083,$3A452028,$01C87387
		dc.l	$612E04A2,$DFF1A140,$975E3462,$E7D64174,$69A3BFB3
		dc.l	$BD800F9E,$63BE01B4,$8FFD26F4,$05260000,$0AD12CCA
		dc.l	$7B31ED0A,$EF801AB2,$832ABEE9,$15E1CA6A,$B42ABADD
		dc.l	$BAF38ED0,$B3201AF6,$2E9E0188,$228A8000,$06C24A00
		dc.l	$0014D8A4,$10400C88,$1A96DE6E,$DB4E7C93,$0A6409D9
		dc.l	$EAD48044,$77AA5466,$C610A24D,$9D084000,$005B7700
		dc.l	$00693050,$02863093,$A5999375,$5418C541,$CACEF105
		dc.l	$BF1F6132,$DCCFB769,$28814001,$8085E000,$0049D7AD
		dc.l	$288E5001,$C580B07C,$B0E6F78C,$16190481,$D3B8A191
		dc.l	$128BDB39,$81213C80,$716B055D,$06C86A23,$2385089C
		dc.l	$85BD364C,$0B1DFBC5,$6745AFBA,$7B674F78,$54F076FD
		dc.l	$74733223,$1300A377,$0C9450A0,$000B9937,$00002C19
		dc.l	$70430E2B,$45266474,$61C32C26,$44EB8C37,$713313F0
		dc.l	$55A4069C,$6908241C,$B9BA58A0,$00060591,$000046A5
		dc.l	$413991B5,$13A8AA8D,$A3D1C31E,$79514829,$3340B874
		dc.l	$498D0404,$00418A1B,$08920400,$00206C2E,$000035C4
		dc.l	$DF30D251,$8612DE29,$040083F0,$884A5A46,$4C139D80
		dc.l	$BA2C0862,$050080E2,$01758040,$0019149D,$0001A25F
		dc.l	$7C8D6089,$81E4A3B5,$87C19101,$603ED65B,$CB0C7D8B
		dc.l	$0B3004CD,$D7F224D6,$2F9CF300,$00004D2F,$00010591
		dc.l	$C69DBB5F,$B8524788,$01586801,$CA223324,$0105D555
		dc.l	$804D0290,$7A56F890,$5C10BC00,$0016CA86,$0001D180
		dc.l	$00E0A238,$5C2822A9,$10004C80,$8C2F6500,$B25FC748
		dc.l	$A2724180,$3B5C45C8,$459DFFA0,$00405ACA,$00013000
		dc.l	$00196D69,$CC6592C8,$8B7618CA,$69480106,$A8CB8EA5
		dc.l	$8A562444,$A79A2003,$D3034CE0,$0002F646,$00015180
		dc.l	$00018478,$7D810A68,$99281D03,$60279684,$92810059
		dc.l	$C1801CBA,$10E0215D,$F15918E0,$002E3610,$00018400
		dc.l	$00057FD1,$981A662A,$50923188,$6280B2F0,$02080A0A
		dc.l	$45C0711D,$23F753F0,$FCD1C3C0,$0031CCDA,$0002D800
		dc.l	$0001CF06,$21128024,$3A100401,$C20059E1,$80425729
		dc.l	$80008212,$85934F28,$F64E3480,$006A8174,$000B3400
		dc.l	$0000F43B,$0C510000,$281C1001,$61001054,$208A1042
		dc.l	$9C4606DB,$203655AC,$E8A38580,$00F3919C,$0004D800
		dc.l	$0000C7AB,$D5D88802,$0A068006,$148A0224,$4992C080
		dc.l	$4A011840,$4C0057D8,$D2A63840,$015FB6FE,$000F4000
		dc.l	$0000F57B,$3CBA2808,$80011811,$0414C985,$04111140
		dc.l	$1042020E,$22C97008,$B8E72140,$00A7E49E,$0008B000
		dc.l	$00000750,$A500080C,$0842A00A,$2C081092,$0004901E
		dc.l	$0400960A,$2053371A,$E37626C0,$0152F06E,$0017A000
		dc.l	$00006B52,$F4200C29,$04140288,$0002008A,$48820025
		dc.l	$984020F8,$011DD3EE,$67F4BE40,$039DB598,$BAD59F09
		dc.l	$C332E815,$4030BB90,$D6D68040,$2ACC4C30,$145D46C1
		dc.l	$02011067,$A49E77C8,$FBC001E3,$5D74001B,$B73C366D
		dc.l	$9D00A828,$60EC3E56,$758C2F02,$0C264392,$1300048C
		dc.l	$8997D3ED,$1746C007,$FB114200,$1E9E0C02,$F3D84004
		dc.l	$88000E08,$9BA3D00A,$90140176,$D29B9584,$0F51F56F
		dc.l	$ADEC800F,$BD9F6E00,$6A6B0D12,$F5F64F64,$1441DA9E
		dc.l	$0832B335,$80603074,$81402002,$716BF589,$F3800DC4
		dc.l	$5F93C863,$762C66B0,$5F210174,$6D404241,$242E926A
		dc.l	$60330658,$4003A522,$B02D9800,$05DBCA69,$231DEC4E
		dc.l	$07D27208,$41568C8F,$2402FE08,$88114002,$BAA70443
		dc.l	$E3F18FE6,$DC8007EF,$FFD8004F,$4E1019FD,$8009B64A
		dc.l	$A9C380B8,$95A10442,$80A30C8E,$3EDF5DCD,$F5330011
		dc.l	$F6FBB800,$2F893B82,$0C6C504D,$FC6405DB,$C4CD8E80
		dc.l	$713622F8,$673EFF3D,$69801BDB,$75E80097,$E7249FBA
		dc.l	$93D18202,$40A0043D,$223AC210,$2001EFC0,$D1EEF9FF
		dc.l	$6D588013,$36FF0F67,$8E55728A,$C0810244,$C84D1C84
		dc.l	$074DEA66,$F79F8E8D,$65BE3B8D,$50027851,$0F743B76
		dc.l	$EE3312E6,$4DED5C5F,$AD007EAF,$67700184,$60178C37
		dc.l	$9F950383,$1677E3A8,$7E6F5FDE,$FBCB1003,$3BA08B80
		dc.l	$2D5B9A98,$06173EBB,$EFE60071,$7FFDC003,$FCFF89C0
		dc.l	$54DE3E01,$163BD7FB,$EE3E00ED,$DFE9C005,$F77E5282
		dc.l	$57D67D02,$16FC1C6E,$7757DA93,$5FFEA70B,$C7EC12F9
		dc.l	$5A44A634,$14F3AFAE,$CFFE01D7,$39C00919,$782590BF
		dc.l	$86A9836F,$0112F37C,$E7FDF200,$FEFD3BC0,$0FABD719
		dc.l	$017E58F6,$4416F806,$BFEBDFFC,$01E3F67F,$800EE7A5
		dc.l	$6CAEBA17,$03FCF7BF,$BC02EBEF,$FD93CCD4,$E788C9B3
		dc.l	$366E1213,$E677BFF7,$E807BF84,$D88037FE,$5EB55207
		dc.l	$DF6608CA,$1F810FF9,$017DFBEC,$FC07FDDD,$4F806FFE
		dc.l	$DFF00075,$55E9CEDF,$10E1FA7E,$EF9FFF52,$2800F729
		dc.l	$46BC635E,$8F0F26FF,$1010E66F,$1F38FC0F,$1E8400E4
		dc.l	$EE36DC43,$47803CDE,$1B78E833,$F52BF81F,$3F6F9F03
		dc.l	$FD3C8C15,$DB49C341,$FA13101D,$7C792FE6,$83FE0313
		dc.l	$4005865F,$F820F327,$10F807FD,$F83EFBBE,$BE8093EF
		dc.l	$FBBFBF7A,$42948FC2,$030F92D4,$0E3F5FE5,$534220F0
		dc.l	$F716983C,$061C7862,$3DF558FB,$F0F3F7FB,$DEC609D2
		dc.l	$E72DB010,$F91310FD,$B0F0A227,$BEFA6E44,$401E4BF2
		dc.l	$81C9FC00,$F1283FBF,$FFEFFFDF,$B20592F3,$80089202
		dc.l	$C7C0ECD3,$EDC85B20,$F30140D1,$40796B65,$FED116CC
		dc.l	$3F12C1FF,$3116F39F,$12F0DFCB,$1642FC5C,$6CFE04F2
		dc.l	$9F6516FE,$09EA9FCA,$1DFC13D4,$E322F2FF,$6415FEC1
		dc.l	$4204DFAA,$C9BF9215,$F995A014,$EFCDE4BF,$C8147C04
		dc.l	$A508FE5D,$F20F6410,$BE4710F2,$A913F9DF,$3110BF3A
		dc.l	$12F93664,$11BE2715,$40FE89E4,$3FC60FFC,$1319FC67
		dc.l	$310FFF09,$19FF4F0F,$CC1710C1,$BF49E833,$C71FFC2F
		dc.l	$CC7F871A,$F92C0EC8,$7F0C28F3,$7FC228FC,$773029FF
		dc.l	$1328CC7F,$0229F357,$32937F18,$877F1F81,$6F08FA33
		dc.l	$0F7C263B,$F40E0EF8,$880F0EFA,$427718FA,$110F0EFA
		dc.l	$A02719FA,$0F0EF827,$18F8C7C4,$27C89F00,$04FE5E19
		dc.l	$FF04F14B,$69E0204B,$E7391414,$80FE89EE,$79E9D07B
		dc.l	$0FE00800,$8FA4C178,$02C02B1A,$E140EFA3,$83203F11
		dc.l	$FCB821F2,$C1E20426,$109F41CF,$2523F880,$2728FA80
		dc.l	$4E25FA01,$00812726,$C2402FA7,$AE1E00FF,$1F00FF1F
		dc.l	$00735FAF,$98301BF9,$030EC907,$22C06F07,$FC601BF2
		dc.l	$B90E912F,$8E1B7C82,$E45E211B,$F92CC9BD,$4C13F259
		dc.l	$87A868CE,$20F2690E,$C83C1F18,$04348B7F,$72871F7C
		dc.l	$01C33C31,$C27B625E,$30813C3F,$701807C7,$D884DBB1
		dc.l	$C7CFB17E,$FE15C69C,$0FFC4804,$383ECCFE,$6BEC3A91
		dc.l	$8B9F873F,$72429B4F,$F25A843E,$17813926,$0D98E62C
		dc.l	$3F41ABFA,$49B06201,$DBA2A008,$8F0F8C33,$32FDB8E6
		dc.l	$277F87F4,$13C3C7B3,$4E9830A9,$1B0FC11F,$8E373ECD
		dc.l	$98E760F8,$09D2FB81,$C1C39F76,$01F3D9D7,$A61BA3FE
		dc.l	$023F1CFC,$F8E76CC6,$0C183E89,$273D2CDC,$1DF5F0A0
		dc.l	$0F6F12D3,$B740EC01,$1BF02D90,$7B0C19E4,$73BDA9D7
		dc.l	$5919BE05,$13F23119,$906F810F,$7CED15E5,$B7B90EF9
		dc.l	$02601A3E,$D70F9B2F,$0519E673,$BD0FF97A,$60193ED7
		dc.l	$0F9B2FF4,$11E6B729,$121F3A4E,$FD09187E,$9B9BF928
		dc.l	$3713BFCD,$15CD8F72,$13F3DFE1,$001A821F,$850FF3D1
		dc.l	$10F86710,$FC27C03F,$70DC0C43,$F8F93B78,$F56888CC
		dc.l	$1F8BFE3B,$66848605,$E593E4B8,$211CFA03,$DC73166E
		dc.l	$584E8CF3,$7C359B3C,$0111160E,$7D02D873,$F0671FFC
		dc.l	$64840E3F,$64C5105C,$3D56E0D8,$AB8B8781,$C07307E3
		dc.l	$98A18CF0,$0CC72740,$780730F1,$20C0A46B,$F11AE073
		dc.l	$3669D9F0,$89110F87,$3876FE84,$68AF848E,$69E04FE0
		dc.l	$71F7EFCF,$60981D0E,$BF0C7C8B,$C433AA81,$074715BE
		dc.l	$41027F82,$784635F0,$0815C977,$49E04F20,$2F83384C
		dc.l	$72037007,$8F6F9522,$FD0912FE,$8F718771,$CEF8137E
		dc.l	$F92229D4,$A5F804F7,$3089DBF0,$9B8B41F8,$87EEDD9F
		dc.l	$66FD60EA,$F40416DB,$31C7FF49,$08F26E1C,$15067F62
		dc.l	$DAAAF804,$F7588988,$3F4C86E2,$03332F1E,$117EC52A
		dc.l	$5E65804F,$0EF00FAB,$F1E01360,$B3EEFC09,$669D1BE8
		dc.l	$31C39F00,$03B1CE1C,$1B7EEDD8,$9D9A09DF,$003F9F68
		dc.l	$3E03FBF1,$C106110E,$FE133815,$FC041E9F,$13F11378
		dc.l	$3432FFAF,$0EFC132F,$7C5C347E,$82F94064,$FE04391F
		dc.l	$2E8D9F0E,$E0BF2A0E,$FF042F3F,$FC8C9FC0,$EBD9CC9F
		dc.l	$A9B93F58,$C1C73BE3,$04F0091C,$0E787F34,$0FFF042E
		dc.l	$1FE08C9F,$0EE09F27,$0EFF0457,$5FB18C9F,$80FE2E11
		dc.l	$CD3F17C1,$FC4FC3F3,$09193E33,$7C02F078,$C03C9F16
		dc.l	$E0DF27F1,$2780C037,$C0E8450E,$F04FB0C2,$3881C7A0
		dc.l	$00B9C63F,$0F9A8F80,$863EDFC7,$A7F0094C,$6C9C407E
		dc.l	$00998F43,$23E213BC,$15279001,$1F0500C7,$27706F22
		dc.l	$2F80AD81,$F0893F7C,$0FA26F0B,$F9B38831,$96E01048
		dc.l	$019E7703,$747D9E4F,$20CF6963,$0401B864,$F3FE18F8
		dc.l	$AB22089A,$F913C87F,$9B44A523,$51440878,$050E5068
		dc.l	$0149BAF3,$09E0A1CE,$C8371B9D,$04247301,$92080738
		dc.l	$810F2443,$6F8E5323,$85049EC7,$8C1F7C25,$E4000A18
		dc.l	$41205581,$10202102,$03DA10D2,$A8C93ABE,$CD0F001B
		dc.l	$FFEFE002,$02404214,$FCB98240,$287D3108,$106A0029
		dc.l	$1213FDFF,$7FFA36A3,$F7478787,$E881C809,$12340840
		dc.l	$04839515,$1D101840,$03E7DFE6,$0FF0DF1B,$96E04641
		dc.l	$010049A6,$98430E06,$37219588,$43FFC770,$2F8B0F07
		dc.l	$D7FFE500,$61001042,$5F30FB18,$40C24F23,$BE036048
		dc.l	$8AFBF740,$81F705FE,$FFFAC039,$07099150,$9EE11522
		dc.l	$021C8998,$1D004F74,$53BFEF79,$96C106DF,$FDF4007B
		dc.l	$C3200802,$2014C32A,$1160C43E,$2A0847DF,$BFBFF5C9
		dc.l	$BD5CDEF7,$703A81E1,$30010803,$310E603D,$22004802
		dc.l	$87FF10AF,$EF300B73,$0FFCD642,$01114001,$22934040
		dc.l	$51246044,$1C848214,$113F422D,$82E163E6,$07F7FFF6
		dc.l	$62200030,$08062512,$1EAE6243,$8188487D,$040217BF
		dc.l	$5FD11E6C,$5D19077B,$4BF23E21,$84051014,$88122091
		dc.l	$02093000,$159D08B2,$C332EE2C,$7307EFFF,$F10C2250
		dc.l	$042F9016,$80808C61,$72902521,$46408687,$71F27577
		dc.l	$9E58CF72,$689F4880,$0486411C,$A0003610,$220D1081
		dc.l	$250B2900,$01DBDFDE,$7BF8BFF9,$6C2F1F00,$D7075DE6
		dc.l	$7280609A,$590200C2,$10C38032,$B06CC008,$D410B253
		dc.l	$CF5F7EDF,$EF7F3BC6,$934D820B,$FF74F081,$246B48A4
		dc.l	$0A3B10D4,$010E51A0,$26A01318,$0403BEF4,$DE1EFFBB
		dc.l	$F8130BC0,$F51FDF57,$D0920C50,$085820EA,$C11051E0
		dc.l	$C4022340,$E8B2C05E,$5DBF70DE,$BDEF2716,$80EB23DE
		dc.l	$FB7607D0,$021A0732,$09420B44,$A38D42A4,$0079E4CB
		dc.l	$07FDBEFF,$A75BAAB9,$C80BC0F5,$1DDFA4C9,$2A8F8979
		dc.l	$9117213A,$D9B42A50,$F8042402,$83068FBB,$FE7FDBF7
		dc.l	$C7173901,$B87EEF5A,$FA930080,$151B8014,$44028C25
		dc.l	$0B6111C2,$82844807,$6D4FFA3E,$CDE19E03,$A04FCE02
		dc.l	$AACD3FD5,$7F720503,$8256DDA4,$48D07800,$198A1059
		dc.l	$31722080,$3E32AB66,$EBDDE9C0,$000671EB,$CC03DF1E
		dc.l	$6DDFEFEB,$417094A2,$138C9100,$1B41324D,$423FC180
		dc.l	$2BA9C37E,$D7CAD7FA,$0BC00002,$6C7CE850,$DFAF47CB
		dc.l	$3D98FEDF,$9ED07CD8,$09024A44,$8890805C,$0D30C7C0
		dc.l	$301C467F,$7FFF63DB,$CB000005,$6ECE46DE,$17E357F5
		dc.l	$F7BDEB7D,$C029A9F5,$21B3722A,$3A726740,$83D50A38
		dc.l	$6AFCB1D7,$BEEA8BDC,$C0000FF9,$EE892FFF,$F7BFAF9F
		dc.l	$FE131390,$624B6519,$78524893,$CD911D22,$2FC4800D
		dc.l	$DDFF7CC5,$BADFD7C0,$0008DE77,$5AB311FB,$5D200E5E
		dc.l	$BF68A1CB,$9D1829BE,$8B965C40,$4C427FF0,$619C41FE
		dc.l	$4B7002D9,$0BFAD9C0,$00052E3F,$00004E12,$F5107FE5
		dc.l	$4D7CD541,$16EA1E35,$954BD545,$22450C71,$2F4CDFE5
		dc.l	$09D161FE,$77DD7540,$00093DB5,$00006B27,$5BEFBFF3
		dc.l	$77E56921,$9124B183,$6CF59BF6,$26152B7F,$BB8855AB
		dc.l	$9939EF5D,$B262F780,$000FA488,$000016CF,$AFFD79CF
		dc.l	$6C5A666C,$8AABE73A,$BE35310E,$FA40E09E,$CD233048
		dc.l	$96D77EBF,$FE7F7A00,$001FB6FF,$000032D7,$71AFFE3A
		dc.l	$7F4F834F,$198CCDE9,$E6FB7E2C,$475E6EED,$7424C67E
		dc.l	$DEC37F8E,$94FAA2E0,$000DDCDC,$0000FF63,$7AEFFBB3
		dc.l	$F4E2043A,$98BA5045,$8498B087,$AB0F8902,$8B8CCDDC
		dc.l	$ECFF5C88,$F36BAF40,$001466C8,$0000D3E6,$8FBCF1D4
		dc.l	$BAD99B8B,$9E3CD3D9,$BB1473C8,$8ECCEC0F,$AA5BF963
		dc.l	$96F7DBE3,$4645A740,$0019FA6E,$0000B95A,$BEC66E4A
		dc.l	$EC575572,$5C2E3CE1,$86AEB7D6,$CCBF478B,$B672FBFB
		dc.l	$FFBE75E4,$F76DFBE0,$001F93D1,$0001CA3B,$20CF2DAE
		dc.l	$79ED21D6,$FBFF7C0F,$77B5A5B9,$B3EC627F,$45D3F79D
		dc.l	$FAFF7F1D,$FE8A7FA0,$0026EB62,$00005DA0,$83729F76
		dc.l	$7E1B5C4A,$783E6EFE,$9FC129A4,$34F38274,$F4CFFB32
		dc.l	$280DDB29,$D0630CE0,$003FB2D0,$0000FA6E,$396244A0
		dc.l	$47ADB877,$FEA797FE,$35DDCCDB,$FEFA2AAA,$7FB2FD6F
		dc.l	$85A9076F,$A3EF43E0,$00693579,$00022E7C,$011F5DC7
		dc.l	$A3D7DD56,$EFFFB37F,$73D09AFF,$4DA038B7,$5D8DBE7F
		dc.l	$C4A3BA37,$BA620040,$003FA535,$0002CFF0,$00669296
		dc.l	$339A6D37,$7489E735,$96B7FEF9,$5734715A,$75A9DBBB
		dc.l	$5865DFFC,$2CFCB300,$007D09B8,$0006AE40,$001E7B87
		dc.l	$827EF597,$66D7E2FC,$9FD8697B,$6D7EFFA6,$3E7FE345
		dc.l	$EF1FDEA2,$0EA6E700,$00D1C9EE,$00067B00,$0002802E
		dc.l	$67E599D5,$AF6DCE77,$9D7F4D0F,$FDF7F5F5,$BA3F8EE2
		dc.l	$DC08AC0F,$032E3C20,$00CE3324,$00052600,$000230F9
		dc.l	$DEED7FDB,$C5EFFBFE,$3DFFA61E,$7FBDA8D6,$7FFF7DED
		dc.l	$7A6CB0D7,$09B1CB60,$00957E8A,$0004C800,$00010BC4
		dc.l	$F3AEFFFF,$D7E3EFFE,$9EFFEFAB,$DF75EFBD,$63B9F924
		dc.l	$DFC9AA53,$175C7A60,$010C6E62,$000B2000,$00003854
		dc.l	$2A2777FD,$F5F97FF9,$EB75FDDB,$B66D3F7F,$B5FEE7BF
		dc.l	$B3FFA827,$2D59C780,$00A04900,$0010B800,$00000A84
		dc.l	$C345D7F7,$7FFEE7EE,$FBEB367A,$FBEEEEBF,$EFBDFDF1
		dc.l	$DD368FF7,$4718DE80,$03581B60,$00174000,$000078AF
		dc.l	$5AFFF7F3,$F7BD5FF5,$D3F7EF6D,$FFFB6FE1,$FBFF69F5
		dc.l	$DFACC8E5,$1C89D900,$02AD0F90,$00085000,$000014AD
		dc.l	$0BDFF3D6,$FBEBFD77,$FFFDFF75,$B77DFFDA,$67BFDF07
		dc.l	$FEE22C11,$980B4180,$00624A66,$002A2000,$00000D17
		dc.l	$EABFCFBF,$F76FFFEF,$7FBFD5FF,$F7CFEBFF,$F93EFDFE
		dc.l	$EF985B61,$88370400,$061CA28A,$00244000,$00000992
		dc.l	$62FF57D7,$9FFFDDFF,$FFDDBFF7,$FDF3D97F,$FFECFFBD
		dc.l	$7F76682C,$12E8B900,$0004EEBC,$00214000,$00001D0C
		dc.l	$27BFFB77,$FFF1F764,$5C2FF56F,$EBFEF7FD,$FFDFFFFF
		dc.l	$FFF0AE0A,$90521340,$00426090,$0015C000,$00000D0A
		dc.l	$7FFBF7FF,$BEFBEFFF,$F7CDDFFB,$FFFF7F9F,$CFEFDFBF
		dc.l	$DFFD8E94,$0A760C00,$023BA064,$001C8F59,$0F994FFB
		dc.l	$0AA1FE6B,$BFBDBEDB,$03526D03,$CCF9C312,$BFFC5A81
		dc.l	$4DD26780,$0A2435EC,$006277AE,$182D8DF7,$BE973855
		dc.l	$DBFDA11C,$77EEBFFD,$744FFBBC,$1C0E7019,$23000845
		dc.l	$9C891A94,$C719027F,$F6B12ADF,$B1C82DFE,$10BD7FEF
		dc.l	$4C54F424,$20A2320A,$CC800E09,$A0D8D06A,$271393AF
		dc.l	$FFD75B99,$B689FE7F,$FDE23305,$DDFDD9C1,$00C296D9
		dc.l	$B2248A8A,$3668BA93,$16406B8D,$5AFDBF5F,$FB6888A5
		dc.l	$FD0DEFDF,$FEBF1191,$11060092,$A7002CC9,$004A9C71
		dc.l	$DDC91438,$3F88FDBB,$9400FBFF,$6567FD28,$9016FF99
		dc.l	$6F437172,$002FC472,$A001A269,$10C0BAD7,$8211FF02
		dc.l	$B212A3A0,$520E7650,$9835447B,$159A6053,$8E16FB88
		dc.l	$1C5781D2,$567534E0,$00C4C74A,$A512A4E7,$C617E0C1
		dc.l	$4410BF71,$0E800220,$04033A41,$2B5D104E,$1E040FC4
		dc.l	$280411C0,$00122016,$3FEB2C2F,$2829F113,$16E0E391
		dc.l	$88A8240F,$E6B40438,$844DD006,$640EDBCF,$55E85051
		dc.l	$30671A4D,$6306E634,$1540831A,$460C16F0,$8318020C
		dc.l	$010102C4,$FEC154CC,$C42981A7,$E104289F,$ACFE3890
		dc.l	$E4F94014,$2002021C,$09800011,$47040393,$766982F3
		dc.l	$1EFE7020,$CD030742,$0114CD9C,$E874228C,$80519ACD
		dc.l	$9F00FE1B,$F2064008,$14D1E024,$162201A1,$F812207A
		dc.l	$28FCF913,$C13F42FE,$8204139E,$A50222B0,$140126A8
		dc.l	$0A84DEE8,$3DE07AC7,$0FE40581,$118D0408,$6127520C
		dc.l	$0DA1E283,$E459C2F8,$000E1898,$90FC1110,$A0B39D1B
		dc.l	$11D04BA0,$9F40E8FE,$44F0B4CA,$C0BC9EC0,$90608C14
		dc.l	$10EA2410,$F54171FE,$0EF1D389,$FFE2BC0B,$68275CA1
		dc.l	$88E8173E,$C83C2698,$F85764FE,$21027204,$419CB0E8
		dc.l	$10044040,$8313A2FE,$F83C0882,$F0E38F9B,$F1FC40AA
		dc.l	$00BE0408,$B6C0E4F9,$F85F80F0,$E1019B3C,$9604000C
		dc.l	$08045171,$7DC01816,$D8F37CB8,$16F97F22,$F970A4BE
		dc.l	$1BB1C3FB,$8F07C6FE,$57481E05,$F2400010,$00201638
		dc.l	$CE83F783,$02E37E77,$3110AC08,$B7C01143,$EF7ED382
		dc.l	$F27BE099,$FC09ECDD,$90F913CC,$CF7F6EF2,$F0A87747
		dc.l	$3D3B221F,$613C413E,$12996F44,$ECFFC273,$119CE74F
		dc.l	$E491516F,$0CFFFAAB,$8DFEC020,$4CE64B40,$0F9CCCC7
		dc.l	$9F882F1E,$5911DF18,$F352C43B,$D0172F64,$F524904F
		dc.l	$C0FCC142,$F4391F84,$0EE0EF41,$EA07B00C,$A1F83EBF
		dc.l	$4350FE04,$F43D88F1,$3C75663F,$5F8CC583,$62DE13F4
		dc.l	$3EC83F7D,$BE260F80,$794FC8FC,$F72A1E01,$F0CF8F90
		dc.l	$C0C0F813,$C9DF43E1,$87FE040E,$F823E355,$DF0E8F13
		dc.l	$FB270EE0,$8957C9E2,$4F208F05,$8C47F9FF,$04EF07F1
		dc.l	$0EF4ED30,$FE01CFBF,$900EE13F,$81E0FC89,$E0033D25
		dc.l	$0F9F820E,$E77DB54C,$F8FE44F0,$5890F81C,$8F050EF1
		dc.l	$C1C37E0B,$613C005C,$3591F818,$013F110F,$01F0FE4B
		dc.l	$A03C007A,$1AEA09BD,$090F81F0,$FE4F82F2,$80804027
		dc.l	$F2FE1C1C,$2610C2FF,$79210C64,$F2000045,$40F87879
		dc.l	$0A12E070,$7CB74812,$F0F8BF13,$EB371A13,$11F8FDF8
		dc.l	$429F12C2,$C07FED4C,$10E0E078,$189F0812,$F8FFB5E7
		dc.l	$230FA118,$388F8D14,$E01E0F88,$A7C30EF0,$C2DF038C
		dc.l	$A713F80F,$F73EA20E,$F0A1FC38,$1E3F9B18,$12FC0F00
		dc.l	$FFD740E4,$201FFA53,$08F84E80,$1487DFCB,$FE021879
		dc.l	$C0307FC0,$01E1FC3E,$43FE4414,$F9F36F9C,$AFC0C038
		dc.l	$01031D8F,$81E1F3F8,$4A048E16,$C787FF04,$F429FC41
		dc.l	$1F03E07F,$FC2C3116,$F807FE13,$BA8979F8,$046FC1E2
		dc.l	$4419C3FE,$1F2DF03C,$7FE03A21,$1FC3BF8D,$271CFCFF
		dc.l	$A71F8F9C,$407863E6,$041C03F8,$FF04F007,$7A427C00
		dc.l	$7F511DC2,$E17F9287,$A7F07F9F,$48091E0F,$F07E0F0F
		dc.l	$87C3C01F,$7F8920F3,$C0180F07,$83009B20,$23FE03C0
		dc.l	$5F3F00FF,$F10379E0,$FFFF0002,$FFE00040,$00800100
		dc.l	$010000C0,$02800300,$05000607,$08080709,$090A090A
		dc.w	$0C0D
	ENDC

		SECTION VARS,BSS,CHIP

vars		ds.b	gb_SIZEOF

		end

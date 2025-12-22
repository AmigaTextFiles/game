*******************************************************************************

; Ladder 1.0 - 28/05/91 by Tom van der Meijden
; Ladder 1.1 - 09/06/96 by Gunther Nikl

*******************************************************************************

; include stuff

		include	exec/types.i
		include	lvo13/dos_lib.i
		include	lvo13/exec_lib.i
		include	lvo13/icon_lib.i
		include	lvo13/graphics_lib.i
		include	lvo13/intuition_lib.i

;LOADLEVELS	equ	1

; specific defines

_LVOBeginIO	equ	-30				; for audio

SINIT		equ	$F0209

FRATE		equ	60

; macro stuff

CALL		MACRO
		IFNE	NARG-2
		FAIL
		ENDC
		move.l	\2,a6
		jsr	_LVO\1(a6)
		ENDM

RECALL		MACRO
		IFNE	NARG-1
		FAIL
		ENDC
		jsr	_LVO\1(a6)
		ENDM

; global stuff

	STRUCTURE Globals,0

	 ULONG	SysBase
	 ULONG	DosBase
	 ULONG	IntBase
	 ULONG	GfxBase
	 ULONG	OurTask
	 ULONG	WbMsg
	 ULONG	OldLock
	 ULONG	Seed
	 ULONG	TimerIO
	 ULONG	ScrPtr
	 ULONG	WinPtr
	 ULONG	UserPort
	 ULONG	RastPort
	 ULONG	imClass

	 ULONG	AudData
	 ULONG	AudioIO

	 ULONG	Mem_1840_1
	 ULONG	Mem_1840_2
	 ULONG	RGenList
	 ULONG	RockList

	 ULONG	LevelPtr
	 ULONG	LevelSize
	 ULONG	LevelBuf

	 ULONG	Lives
	 ULONG	Round
	 ULONG	Score
	 ULONG	PlayTime
	 ULONG	LevelTime

	 ULONG	MaxLevel
	 ULONG	TimeTab
	 ULONG	PlayTab

	 UWORD	imCode
	 UWORD	AudPeriod
	 UWORD	AudCycles
	 UWORD	NextLive
	 UWORD	RGenCount

	 UWORD	xPosInit
	 UWORD	yPosInit
	 UWORD	xPosLad
	 UWORD	yPosLad

	 UWORD	ShapeDef
	 UWORD	ShapeNum

	 UWORD	lbW0035FC
	 UWORD	lbW0035FE
	 UWORD	lbW003600
	 UWORD	lbW003602
	 UWORD	lbW003604
	 UWORD	lbW003606
	 UWORD	lbW003608
	 UWORD	lbW00360A
	 UWORD	lbW00360C
	 UWORD	lbW00360E

	 UBYTE	Speed
	 UBYTE	Level
	 UBYTE	Levl2
	 UBYTE	imCtrl
	 UBYTE	NewScore
	 UBYTE	MaxRocks
	 UBYTE	RockCount
	 UBYTE	LevelEnde
	 UBYTE	TimerCount
	 UBYTE	LeftRight
	 UBYTE	UpAndDown
	 UBYTE	Jumping

	 UBYTE	lbB003610
	 UBYTE	lbB003612

	 STRUCT	TextAttr,8
	 STRUCT	StringGad,44
	 STRUCT	StringInfo,36
	 STRUCT	NumberBuf,32
	 STRUCT	ScoreBuf,5*34

	 UBYTE	SmallBuf
	 UBYTE	bPad

	 STRUCT BitMap,16				; only 2 Planes!

	LABEL gb_SIZEOF

; base register

bp		equr	a4

*******************************************************************************

		SECTION	Game,CODE

start		move.l	d0,d2
		move.l	a0,a2
		moveq	#(gb_SIZEOF>>2)-1,d0
5$		clr.l	-(sp)
		dbra	d0,5$
		move.l	sp,bp
		move.l	4,a6
		move.l	a6,SysBase(bp)
		suba.l	a1,a1
		RECALL	FindTask
		move.l	d0,a3
		move.l	d0,OurTask(bp)
		tst.l	172(a3)
		bne.s	4$
		lea	92(a3),a0
		RECALL	WaitPort
		lea	92(a3),a0
		RECALL	GetMsg
		move.l	d0,WbMsg(bp)
4$		lea	DosName(pc),a1
		moveq	#33,d0
		RECALL	OpenLibrary
		move.l	d0,DosBase(bp)
		beq.s	2$
		tst.l	WbMsg(bp)
		sne	d0
		and.w	#ParseWB-ParseCLI,d0
		jsr	ParseCLI(pc,d0.w)
		bsr	main
		move.l	DosBase(bp),a6
		tst.l	WbMsg(bp)
		beq.s	3$
		move.l	OldLock(bp),d1
		RECALL	CurrentDir
3$		move.l	a6,a1
		CALL	CloseLibrary,SysBase(bp)
2$		move.l	WbMsg(bp),d2
		beq.s	1$
		RECALL	Forbid
		move.l	d2,a1
		RECALL	ReplyMsg
1$		moveq	#0,d0
		lea	gb_SIZEOF(bp),sp
		rts

;------------------------------------------------------------------------------

ParseCLI	subq.w	#1,d2
		beq.s	1$
		cmp.w	#30,d2
		bhi.s	1$
		lea	NumberBuf(bp),a1
		dc.w	$0c40
2$		move.b	(a2)+,(a1)+
		dbra	d0,2$
		clr.b	0(a1)
1$		rts

;------------------------------------------------------------------------------

ParseWB		move.l	WbMsg(bp),a2
		move.l	28(a2),d2
		move.l	36(a2),a2
		subq.l	#1,d2
		beq.s	5$
		addq.w	#8,a2
5$		move.l	(a2)+,d1
		CALL	CurrentDir,DosBase(bp)
		move.l	d0,OldLock(bp)
		lea	IconName(pc),a1
		moveq	#33,d0
		CALL	OpenLibrary,SysBase(bp)
		move.l	d0,d6
		beq.s	1$
		move.l	0(a2),a0
		CALL	GetDiskObject,d6
		move.l	d0,a2
		tst.l	d0
		beq.s	2$
		move.l	54(a2),a0
		lea	ToolType(pc),a1
		RECALL	FindToolType
		move.l	d0,a0
		tst.l	d0
		beq.s	3$
		lea	NumberBuf(bp),a1
		moveq	#30,d0
4$		move.b	(a0)+,(a1)+
		dbeq	d0,4$
		clr.b	0(a1)
3$		move.l	a2,a0
		RECALL	FreeDiskObject
2$		move.l	d6,a1
		CALL	CloseLibrary,SysBase(bp)
1$		rts

*******************************************************************************

OpenAudio	moveq	#0,d2
		move.l	SysBase(bp),a6
		moveq	#32+32,d0
		moveq	#3,d1
		RECALL	AllocMem
		move.l	d0,AudData(bp)
		beq.s	1$
		move.l	d0,a1
		lea	TuneData(pc),a0
		moveq	#(16*2/4-1),d0
2$		move.l	(a0)+,(a1)+
		dbra	d0,2$
		move.l	a1,BitMap+08(bp)
		adda.w	#16,a1
		move.l	a1,BitMap+12(bp)
		moveq	#68+36,d0
		move.l	#$10001,d1
		RECALL	AllocMem
		move.l	d0,AudioIO(bp)
		beq.s	1$
		move.l	d0,a2
		move.b	#7,8(a2)
		lea	68(a2),a0
		move.l	a0,14(a2)
		move.b	#4,68+08(a2)
		moveq	#-1,d0
		RECALL	AllocSignal
		move.b	d0,68+15(a2)
		blt.s	1$
		move.l	OurTask(bp),68+16(a2)
		lea	68+20(a2),a0
		move.l	a0,8(a0)
		addq.w	#4,a0
		move.l	a0,-(a0)
		lea	AudioName(pc),a0
		moveq	#0,d0
		move.l	a2,a1
		moveq	#0,d1
		RECALL	OpenDevice
		move.b	d0,68+34(a2)
		bne.s	1$
		moveq	#1,d2
1$		move.l	d2,d0
		rts

;------------------------------------------------------------------------------

InitGfx		moveq	#(48>>2)-1,d0
4$		clr.l	-(sp)
		dbra	d0,4$
		move.w	#640,4(sp)
		move.w	#200,6(sp)
		addq.w	#1,8(sp)
		addq.b	#1,11(sp)
		move.w	#$8000,12(sp)
		move.w	#$010f,14(sp)
		lea	TextAttr(bp),a0
		move.l	a0,16(sp)
		lea	TopazName(pc),a1
		move.l	a1,(a0)+
		move.w	#8,0(a0)
		move.l	sp,a0
		CALL	OpenScreen,IntBase(bp)
		move.l	d0,ScrPtr(bp)
		beq	1$
		move.l	d0,a0
		lea	44(a0),a0
		lea	ColTab(pc),a1
		moveq	#2,d0
		CALL	LoadRGB4,GfxBase(bp)
		lea	BitMap(bp),a0
		moveq	#1,d0
		moveq	#8,d1
		moveq	#8,d2
		RECALL	InitBitMap
		move.l	sp,a0
		moveq	#(48>>2)-1,d0
3$		clr.l	(a0)+
		dbra	d0,3$
		addq.w	#2,2(sp)
		move.w	#640,4(sp)
		move.w	#198,6(sp)
		addq.b	#1,9(sp)
		move.w	#$440,12(sp)
		move.l	#$31800,14(sp)
		move.l	ScrPtr(bp),30(sp)
		move.w	#15,46(sp)
		move.l	sp,a0
		CALL	OpenWindow,IntBase(bp)
		move.l	d0,WinPtr(bp)
		beq.s	1$
		move.l	d0,a0
		move.l	50(a0),RastPort(bp)
		move.l	86(a0),UserPort(bp)
1$		lea	48(sp),sp
		rts

;------------------------------------------------------------------------------

OpenTimer	moveq	#0,d2
		move.l	SysBase(a4),a6
		moveq	#40+36,d0
		move.l	#$10001,d1
		RECALL	AllocMem
		move.l	d0,TimerIO(bp)
		beq.s	1$
		move.l	d0,a2
		move.b	#7,8(a2)
		lea	40(a2),a0
		move.l	a0,14(a2)
		move.b	#4,40+8(a2)
		moveq	#-1,d0
		RECALL	AllocSignal
		move.b	d0,40+15(a2)
		blt.s	1$
		move.l	OurTask(bp),40+16(a2)
		lea	40+20(a2),a0
		move.l	a0,8(a0)
		addq.w	#4,a0
		move.l	a0,-(a0)
		lea	TimerName(pc),a0
		moveq	#0,d0
		move.l	a2,a1
		moveq	#0,d1
		RECALL	OpenDevice
		move.b	d0,40+34(a2)
		bne.s	1$
		moveq	#1,d2
1$		move.l	d2,d0
		rts

;------------------------------------------------------------------------------

OpenLibs	move.l	SysBase(bp),a6
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

main		bsr.s	OpenLibs
		beq	1$
		bsr	OpenTimer
		beq	2$
		bsr	InitGfx
		beq	3$
		bsr	OpenAudio
		beq	4$

		move.l	#2*1840+400+180,d0
		moveq	#1,d1
		swap	d1
		CALL	AllocMem,SysBase(bp)
		move.l	d0,Mem_1840_1(bp)
		move.l	d0,a0
		beq	4$
		adda.w	#1840,a0
		move.l	a0,Mem_1840_2(bp)
		adda.w	#1840,a0
		move.l	a0,RGenList(bp)
		adda.w	#400,a0
		move.l	a0,RockList(bp)
		moveq	#7,d1
8$		moveq	#20,d0
		add.l	a0,d0
		move.l	d0,0(a0)
		move.l	d0,a0
		dbra	d1,8$

		move.w	#90,StringGad+6(bp)
		move.w	#152,StringGad+4(bp)
		move.w	#240,StringGad+08(bp)
		move.w	#8,StringGad+10(bp)
		clr.w	StringGad+12(bp)
		move.w	#1,StringGad+14(bp)
		move.w	#4,StringGad+16(bp)
		lea	StringInfo(bp),a0
		move.l	a0,StringGad+34(bp)
		move.w	#30,10(a0)

		lea	NumberBuf(bp),a0
		tst.b	0(a0)
		beq.s	7$
		bsr	LoadLevels
		move.l	LevelBuf(bp),a0
		bne.s	6$
7$		lea	OrigLevel(pc),a0
6$		move.l	a0,LevelPtr(bp)
		bsr	GetLevelInfo
		bsr	LoadScore
		bsr	MainLoop
		tst.b	NewScore(bp)
		beq.s	5$
		bsr	SaveScore

5$		bsr.s	FreeBuffer
4$		bsr	CloseAudio
3$		bsr.s	FreeGfx
2$		bsr.s	CloseTimer
1$

;------------------------------------------------------------------------------

CloseLibs	move.l	SysBase(bp),a6
		move.l	GfxBase(bp),a1
		bsr.s	2$
		move.l	IntBase(bp),a1
2$		move.l	a1,d0
		beq.s	1$
		RECALL	CloseLibrary
1$		rts

;------------------------------------------------------------------------------

CloseTimer	move.l	TimerIO(bp),d0
		move.l	SysBase(bp),a6
		beq.s	1$
		move.l	d0,a2
		tst.b	40+34(a2)
		bne.s	3$
		move.l	a2,a1
		RECALL	CloseDevice
3$		moveq	#0,d0
		move.b	40+15(a2),d0
		ble.s	2$
		RECALL	FreeSignal
2$		move.l	a2,a1
		moveq	#40+36,d0
		RECALL	FreeMem
1$		rts

;------------------------------------------------------------------------------

FreeGfx		move.l	IntBase(bp),a6
		move.l	WinPtr(bp),d0
		beq.s	2$
		move.l	d0,a0
		RECALL	CloseWindow
2$		move.l	ScrPtr(bp),d0
		beq.s	1$
		move.l	d0,a0
		RECALL	CloseScreen
1$		rts

;------------------------------------------------------------------------------

FreeBuffer	move.l	SysBase(bp),a6
		move.l	TimeTab(bp),d0
		beq.s	3$
		move.l	d0,a1
		move.l	MaxLevel(bp),d0
		lsl.l	#2,d0
		RECALL	FreeMem
3$		move.l	LevelBuf(bp),d0
		beq.s	2$
		move.l	d0,a1
		move.l	LevelSize(bp),d0
		RECALL	FreeMem
2$		move.l	Mem_1840_1(bp),a1
		move.l	#2*1840+400+180,d0
		RECALL	FreeMem
1$		rts

;------------------------------------------------------------------------------

CloseAudio	move.l	AudioIO(bp),d0
		move.l	SysBase(bp),a6
		beq.s	2$
		move.l	d0,a2
		tst.b	68+34(a2)
		bne.s	4$
		tst.l	24(a2)
		beq.s	5$
		move.w	#11,28(a2)
		move.b	#32,30(a2)
		move.l	a2,a1
		RECALL	DoIO
5$		move.l	a2,a1
		RECALL	CloseDevice
4$		moveq	#0,d0
		move.b	68+15(a2),d0
		ble.s	3$
		RECALL	FreeSignal
3$		moveq	#68+36,d0
		move.l	a2,a1
		RECALL	FreeMem
2$		move.l	AudData(bp),d0
		beq.s	1$
		move.l	d0,a1
		moveq	#32+32,d0
		RECALL	FreeMem
1$		rts

*******************************************************************************

MainLoop	move.b	#5,Speed(bp)
6$		bsr	TitleScreen
		moveq	#14,d7
		moveq	#24,d6
		moveq	#0,d5
		moveq	#0,d4
5$		subq.w	#1,d7
		bne.s	2$
		moveq	#14,d7
		lea	SmallBuf(bp),a0			; blink
		moveq	#' ',d0
		not.b	d5
		beq.s	4$
		tst.b	d4
		bne.s	4$
		moveq	#'_',d0
4$		move.b	d0,0(a0)
		move.w	#188,d0
		move.w	#182,d1
		bsr	PutStr
		subq.b	#1,d6
		bne.s	2$
		moveq	#24,d6
		lea	InfoMesg2(pc),a0
		not.b	d4
		beq.s	3$
		moveq	#4,d6
		moveq	#10,d1				; message
		bsr	Random
		subq.b	#5,d0
		lea	Message1(pc),a0
		bcc.s	3$
		lea	Message2(pc),a0
3$		moveq	#0,d0
		move.w	#194,d1
		bsr	PutStr
2$		moveq	#1,d0
		bsr	TimeDelay
		bsr	CheckUserPort
		beq	5$
		cmp.l	#$400,imClass(bp)
		bne	5$
		move.w	imCode(bp),d0
		tst.b	d0
		bmi	5$
		pea	5$(pc)
		cmp.b	#$22,d0				; D
		beq	GetLevels
		cmp.b	#$28,d0				; L
		beq	SetSpeed
		moveq	#6$-5$,d1
		add.l	d1,0(sp)
		cmp.b	#$19,d0				; P
		beq	GamePlay
		cmp.b	#$17,d0				; I
		beq	HelpScreen
		addq.w	#4,sp
		cmp.b	#$32,d0				; X
		bne	5$

;------------------------------------------------------------------------------

		lea	Exiting(pc),a0
		move.w	#188,d0
		move.w	#182,d1
		bsr	PutStr
		moveq	#30,d0
		bra	TimeDelay

;------------------------------------------------------------------------------

SetSpeed	moveq	#'0'+6,d2
		move.b	Speed(bp),d1
		subq.b	#1,d1
		cmp.b	#2,d1
		bne.s	1$
		moveq	#5,d1
1$		move.b	d1,Speed(bp)
		sub.b	d1,d2
		lea	SmallBuf(bp),a0
		move.w	#446,d0
		moveq	#88,d1
		move.b	d2,0(a0)
		bsr	PutStr
		move.w	#3,AudCycles(bp)
		move.w	#3320,AudPeriod(bp)
		bra	PlayNote

;------------------------------------------------------------------------------

GetLevels	lea	LevelName(pc),a0
		bsr	LoadLevels
		beq	1$
		move.l	LevelBuf(bp),LevelPtr(bp)
		bsr	GetLevelInfo
1$		rts

;------------------------------------------------------------------------------

HelpScreen	move.l	RastPort(bp),a1
		moveq	#0,d0
		CALL	SetRast,GfxBase(bp)
		lea	Instructions(pc),a2
4$		moveq	#0,d0
		move.b	(a2)+,d0
		moveq	#0,d1
		move.b	(a2)+,d1
		move.l	a2,a0
		bsr	PutStr
3$		tst.b	(a2)+
		bne.s	3$
		cmp.b	#$FF,0(a2)
		bne.s	4$
2$		bsr	WaitUserPort
		cmp.l	#$400,imClass(bp)
		bne.s	2$
		moveq	#-$44,d0
		add.w	imCode(bp),d0
		beq.s	1$				; $44 ?
		addq.w	#1,d0
		bne.s	2$				; $43 ?
1$		rts

;------------------------------------------------------------------------------

GamePlay	move.l	TimeTab(bp),a0
		move.l	PlayTab(bp),a1
		move.l	MaxLevel(bp),d0
		add.l	d0,d0
		CALL	CopyMem,SysBase(bp)
		clr.l	Score(bp)
		moveq	#5,d0
		move.l	d0,Lives(bp)
		moveq	#1,d0
		move.l	d0,Round(bp)
		clr.w	lbW0035FC(bp)
		clr.w	NextLive(bp)
		st	Level(bp)
		move.b	#2,Levl2(bp)
		bsr	lbC00164A
15$		bsr	DrawLevel
14$		bsr	WriteTime
		bsr	DrawPlayer
		bsr	BeginMesg
13$		moveq	#0,d2
		move.b	Speed(bp),d2
12$		bsr	CheckInput
		tst.b	imCtrl(bp)			; ctrl-c ?
		beq.s	11$
		cmp.w	#$33,imCode(bp)
		beq	6$
11$		cmp.w	#$45,imCode(bp)			; esc ?
		bne.s	10$
		bsr	PauseGame
		bne	5$
10$		moveq	#1,d0
		bsr	TimeDelay
		subq.b	#1,TimerCount(bp)
		bne.s	9$
		move.b	#3*FRATE,TimerCount(bp)
		moveq	#100,d0
		sub.l	d0,PlayTime(bp)
		bcs.s	7$
		bsr	WriteTime
9$		dbra	d2,12$
		bsr	lbC0018FC
		bsr	lbC001768
		tst.b	LevelEnde(bp)
		bmi.s	7$
		bne.s	8$
		bsr	lbC0013E8
		tst.b	LevelEnde(bp)
		bne.s	7$
		moveq	#10,d1
		bsr	Random
		tst.b	d0
		beq.s	13$
		bsr	NewRock
		bra	13$
8$		bsr	ShowSuccess
		addq.l	#1,Round(bp)
		bra	15$
7$		subq.l	#1,Lives(bp)
		bsr	WriteLads
		bsr	ShowDeath
		tst.l	Lives(bp)
		beq	5$
		bsr	InitLevel
		bra	14$
6$		clr.l	Score(bp)
5$		bsr	CheckScore
		beq.s	1$
		move.l	RastPort(bp),a1
		moveq	#0,d0
		CALL	SetRast,GfxBase(bp)
		lea	HighMesg(pc),a0
		moveq	#80,d0
		moveq	#48,d1
		bsr	PutStr
		lea	ScoreTab(pc),a0
4$		move.l	(a0)+,d0
		cmp.l	Score(bp),d0
		bmi.s	2$
3$		tst.b	(a0)+
		bne.s	3$
		bra.s	4$
2$		moveq	#8,d0
		moveq	#72,d1
		bsr	PutStr
		lea	HighName(pc),a0
		moveq	#8,d0
		moveq	#96,d1
		bsr	PutStr
		bsr	GetName
1$		rts

;------------------------------------------------------------------------------

CheckScore	lea	ScoreBuf(bp),a0
		moveq	#5-1,d0
4$		move.l	0(a0),d1
		cmp.l	Score(bp),d1
		bcs.s	3$
		adda.w	#34,a0
		dbra	d0,4$
		moveq	#0,d0
		rts
3$		move.w	d0,d2
		lea	ScoreBuf+4*34(bp),a0
		lsl.w	#4,d0
		lea	ScoreBuf+5*34(bp),a1
		add.w	d2,d0
		dc.w	$0c40
2$		move.w	-(a0),-(a1)
		dbra	d0,2$
		move.l	Score(bp),(a0)+
		move.l	a0,StringInfo+0(bp)
		st	NewScore(bp)
		rts

*******************************************************************************

NextLevel	addq.b	#1,Level(bp)
		move.b	Level(bp),d0
		cmp.b	Levl2(bp),d0			; restart ?
		bne.s	2$
		clr.b	Level(bp)
		addq.b	#1,Levl2(bp)
		move.l	MaxLevel(bp),d0
		addq.b	#1,d0
		cmp.b	Levl2(bp),d0
		bne.s	2$
		cmp.b	#3,Speed(bp)
		beq.s	3$
		subq.b	#1,Speed(bp)
3$		move.b	#2,Levl2(bp)
2$		moveq	#0,d1
		move.b	Level(bp),d1
		move.w	d1,d0
		add.w	d1,d1
		move.l	PlayTab(bp),a1
		adda.w	d1,a1
		move.w	0(a1),a0
		move.l	a0,LevelTime(bp)
		sub.w	#200,0(a1)
		move.l	LevelPtr(bp),a0
		dc.w	$0c40				; eat next
1$		adda.w	0(a0),a0
		dbra	d0,1$
		rts

;------------------------------------------------------------------------------

InitLevel	move.l	a2,-(sp)
		move.w	xPosInit(bp),xPosLad(bp)
		move.w	yPosInit(bp),yPosLad(bp)
		clr.w	lbW0035FC(bp)
		move.w	ShapeDef(bp),ShapeNum(bp)
		move.l	LevelTime(bp),PlayTime(bp)
		clr.b	LevelEnde(bp)
		move.b	#3*FRATE,TimerCount(bp)
		clr.b	LeftRight(bp)
		clr.b	UpAndDown(bp)
		clr.b	Jumping(bp)
		clr.b	lbB003610(bp)
		move.l	RockList(bp),d0
2$		move.l	d0,a2
		tst.w	4(a2)
		beq.s	1$
		clr.w	4(a2)
		move.w	6(a2),d0
		move.w	8(a2),d1
		move.w	18(a2),a0
		bsr	FastDraw
		subq.b	#1,RockCount(bp)
1$		move.l	0(a2),d0
		bne.s	2$
		bsr	CheckUserPort
		move.l	(sp)+,a2
		rts

;------------------------------------------------------------------------------

DrawLevel	movem.l	d2/d3/d4/a2/a3,-(sp)
		bsr	NextLevel
		move.l	a0,a2				; new level
		bsr	InitLevel
		move.l	RastPort(bp),a1
		moveq	#0,d0
		CALL	SetRast,GfxBase(bp)
		addq.w	#2,a2
		move.w	(a2)+,d2
		move.w	(a2)+,d0
		move.w	d0,xPosInit(bp)
		move.w	d0,xPosLad(bp)
		move.w	(a2)+,d0
		move.w	d0,yPosInit(bp)
		move.w	d0,yPosLad(bp)
		move.b	(a2)+,MaxRocks(bp)
		moveq	#0,d0
		move.b	(a2)+,d0
		move.w	d0,ShapeNum(bp)
		move.w	d0,ShapeDef(bp)
		addq.w	#2,a2
		move.l	Mem_1840_2(bp),a1
9$		move.b	(a2)+,d1
		cmp.b	#127,d1
		beq.s	8$
		move.b	d1,(a1)+
		subq.w	#1,d2
		bne.s	9$
		bra.s	6$
8$		moveq	#0,d0
		move.b	(a2)+,d0
		move.b	(a2)+,d1
		dc.w	$0c40
7$		move.b	d1,(a1)+
		dbra	d0,7$
		subq.w	#3,d2
		bne.s	9$
6$		clr.w	RGenCount(bp)
		move.l	Mem_1840_1(bp),a3
		move.l	Mem_1840_2(bp),a2
		moveq	#0,d4
5$		moveq	#0,d3
4$		move.w	d3,d0
		move.w	d4,d1
		move.b	(a2)+,d2
		cmp.b	#32,d2
		bls.s	3$
		clr.b	(a3)+
		lea	SmallBuf(bp),a0
		lsl.w	#3,d0
		lsl.w	#3,d1
		addq.w	#6,d1
		move.b	d2,0(a0)
		bsr	PutStr
		bra.s	1$
3$		move.b	d2,(a3)+
		cmp.b	#7,d2
		bne.s	2$
		move.w	RGenCount(bp),a0
		cmpa.w	#99,a0
		beq.s	2$
		adda.w	a0,a0
		adda.w	a0,a0
		adda.l	RGenList(bp),a0
		move.w	d0,(a0)+
		move.w	d1,0(a0)
		addq.w	#1,RGenCount(bp)
2$		move.w	d2,a0
		bsr	FastDraw
1$		addq.w	#1,d3
		cmp.w	#80,d3
		bcs.s	4$
		moveq	#3,d0
		bsr	TimeDelay
		addq.w	#1,d4
		cmp.w	#22,d4
		bcs.s	5$
		lea	StatusLine(pc),a0
		moveq	#1,d0
		move.w	#181,d1
		bsr.s	PutStr
		bsr.s	WriteLads
		bsr.s	WriteRound
		bsr.s	WriteScore
		movem.l	(sp)+,d2/d3/d4/a2/a3
		rts

;------------------------------------------------------------------------------

WriteTime	move.l	PlayTime(bp),-(sp)
		move.l	0(sp),d0
		bsr	MakeNum
		lea	NumberBuf+4(bp),a0
		move.w	#584,d0
		move.w	#181,d1
		bsr.s	PutStr
		move.l	(sp)+,a0
		cmp.w	#900,a0
		bhi.s	WriteTime-2
		move.w	#4,AudCycles(bp)
		move.w	#9320,AudPeriod(bp)
		bra	PlayNote

WriteScore	move.l	Score(bp),d0
		bsr.s	MakeNum
		lea	NumberBuf(bp),a0
		move.w	#328,d0
		move.w	#181,d1
		bra.s	PutStr

WriteRound	move.l	Round(bp),d0
		bsr.s	MakeNum
		lea	NumberBuf+5(bp),a0
		move.w	#176,d0
		move.w	#181,d1
		bra.s	PutStr

WriteLads	move.l	Lives(bp),d0
		bsr.s	MakeNum
s		lea	NumberBuf+5(bp),a0
		moveq	#40,d0
		move.w	#181,d1
;		bra.s	PutStr

;------------------------------------------------------------------------------

PutStr		move.l	a6,-(sp)
		move.l	a2,-(sp)
		move.l	a0,a2
		move.l	RastPort(bp),a1
		CALL	Move,GfxBase(bp)
		move.l	a2,a0
1$		tst.b	(a2)+
		bne.s	1$
		suba.l	a0,a2
		subq.w	#1,a2
		move.l	a2,d0
		move.l	RastPort(bp),a1
		RECALL	Text
		move.l	(sp)+,a2
		move.l	(sp)+,a6
		rts

;------------------------------------------------------------------------------

MakeNum		movem.l	d0-d7/a0-a6,-(sp)
		lea	fmtstr(pc),a0
		move.l	sp,a1
		lea	1$(pc),a2
		lea	NumberBuf(bp),a3
		CALL	RawDoFmt,SysBase(bp)
		movem.l	(sp)+,d0-d7/a0-a6
		rts
1$		move.b	d0,(a3)+
		rts

;------------------------------------------------------------------------------

TimeDelay	move.l	a6,-(sp)
		move.l	TimerIO(bp),a1
		mulu	#1000000/FRATE,d0
		move.w	#9,28(a1)
		clr.l	32(a1)
		move.l	d0,36(a1)
		CALL	DoIO,SysBase(bp)
		move.l	(sp)+,a6
		rts

;------------------------------------------------------------------------------

BeginMesg	lea	Ready1(pc),a0
		moveq	#0,d0
		move.w	#194,d1
		bsr.s	PutStr
		move.w	#6,AudCycles(bp)
		move.w	#4920,AudPeriod(bp)
		bsr	PlayNote
		moveq	#7,d0
		bsr.s	TimeDelay
		move.w	#6,AudCycles(bp)
		move.w	#9920,AudPeriod(bp)
		bsr	PlayNote
		moveq	#7,d0
		bsr.s	TimeDelay
		move.w	#6,AudCycles(bp)
		move.w	#4920,AudPeriod(bp)
		bsr	PlayNote
		moveq	#27,d0
		bsr.s	TimeDelay
		lea	InfoMesg2(pc),a0
		moveq	#0,d0
		move.w	#194,d1
		bra	PutStr

ShowSuccess	move.l	d2,-(sp)
		move.l	PlayTime(bp),d2
		beq.s	1$
		add.w	#2600,d2
3$		moveq	#100,d0
		add.l	d0,Score(bp)
		sub.l	d0,PlayTime(bp)
		sub.w	d0,d2
		add.w	d0,NextLive(bp)
		cmp.w	#10000,NextLive(bp)
		bcs.s	2$
		sub.w	#10000,NextLive(bp)
		addq.l	#1,Lives(bp)
		bsr	WriteLads
2$		bsr	WriteTime
		bsr	WriteScore
		move.w	d2,AudPeriod(bp)
		move.w	#8,AudCycles(bp)
		bsr	PlayNote
		moveq	#6,d0
		bsr	TimeDelay
		tst.l	PlayTime(bp)
		bne.s	3$
1$		move.l	(sp)+,d2
		rts

ShowDeath	movem.l	d2/d3/a2,-(sp)
		moveq	#2,d2
		lea	DeathTab(pc),a2
		moveq	#14-1,d3
		move.w	#9600,AudPeriod(bp)
2$		subq.b	#1,d2
		bne.s	1$
		moveq	#2,d2
		move.w	#3,AudCycles(bp)
		add.w	#400,AudPeriod(bp)
		bsr	PlayNote
1$		moveq	#0,d0
		move.b	(a2)+,d0
		move.w	yPosLad(bp),d1
		move.w	d0,a0
		move.w	xPosLad(bp),d0
		bsr	FastDraw
		moveq	#5,d0
		bsr	TimeDelay
		dbra	d3,2$
		move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr	FastDraw
		moveq	#30,d0
		bsr	TimeDelay
		movem.l	(sp)+,d2/d3/a2
		rts

;------------------------------------------------------------------------------

lbC001768	move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		bsr	lbC0013CA
		subq.b	#5,d0				; 5
		seq	d1
		neg.b	d1
		move.b	d1,LevelEnde(bp)
		bne.s	1$
		subq.b	#7,d0				; 12
		seq	LevelEnde(bp)
		beq.s	1$
		addq.b	#6,d0				; 6
		bne.s	1$
		move.l	Mem_1840_1(bp),a0
		move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		clr.w	lbW0035FC(bp)
		lsl.w	#4,d1
		add.w	d1,d0
		lsl.w	#2,d1
		add.w	d1,d0
		clr.b	0(a0,d0.w)
		move.l	PlayTime(bp),d0
		beq.s	2$
		add.l	d0,Score(bp)
		add.w	d0,NextLive(bp)
		cmp.w	#10000,NextLive(bp)
		bcs.s	2$
		sub.w	#10000,NextLive(bp)
		addq.l	#1,Lives(bp)
		bsr	WriteLads
2$		bsr	WriteScore
		move.w	#8,AudCycles(bp)
		move.w	#3320,AudPeriod(bp)
		bsr	PlayNote
1$		rts

;------------------------------------------------------------------------------

NewRock		move.b	MaxRocks(bp),d0
		cmp.b	RockCount(bp),d0
		beq.s	1$
		moveq	#0,d1
		move.w	RGenCount(bp),d1
		beq.s	1$
		bsr	Random
		lsl.w	#2,d0
		move.l	RGenList(bp),a0
		adda.w	d0,a0
		move.w	(a0)+,d0
		move.w	0(a0),d1
		lea	RockList(bp),a0
2$		tst.l	0(a0)
		beq.s	1$
		move.l	0(a0),a0
		tst.w	4(a0)
		bne.s	2$
		move.w	#1,4(a0)
		move.w	d0,6(a0)
		move.w	d1,8(a0)
		clr.w	10(a0)
		move.w	#1,12(a0)
		move.w	d0,14(a0)
		move.w	d1,16(a0)
		move.w	#7,18(a0)
		move.w	#2,a0
		bsr	FastDraw
		addq.b	#1,RockCount(bp)
1$		rts

;------------------------------------------------------------------------------

lbC0013CA	lsl.w	#4,d1
		add.w	d1,d0
		lsl.w	#2,d1
		add.w	d0,d1
		move.l	Mem_1840_1(bp),a0
		moveq	#0,d0
		move.b	0(a0,d1.w),d0
		rts

;------------------------------------------------------------------------------

lbC0013E8	movem.l	d2-d7/a2,-(sp)
		move.l	RockList(bp),d0
5$		move.l	d0,a2
		tst.w	4(a2)
		beq	2$
		move.w	6(a2),d0
		move.w	8(a2),d1
		cmp.w	xPosLad(bp),d0
		bne.s	4$
		cmp.w	yPosLad(bp),d1
		seq	LevelEnde(bp)
		beq	1$
4$		bsr.s	lbC0013CA
		cmp.w	#9,d0
		bne.s	3$
		clr.w	4(a2)
		move.w	6(a2),d0
		move.w	8(a2),d1
		move.w	18(a2),a0
		bsr	FastDraw
		subq.b	#1,RockCount(bp)
		bra.s	2$
3$		bsr.s	lbC00148A
		tst.w	4(a2)
		beq.s	2$
		move.w	14(a2),d0
		move.w	16(a2),d1
		move.w	18(a2),a0
		bsr	FastDraw
		move.w	6(a2),d0
		move.w	8(a2),d1
		bsr	lbC0013CA
		move.w	d0,18(a2)
		move.w	6(a2),d0
		move.w	8(a2),d1
		move.w	#2,a0
		bsr	FastDraw
		move.w	6(a2),d0
		move.w	8(a2),d1
		cmp.w	xPosLad(bp),d0
		bne.s	2$
		cmp.w	yPosLad(bp),d1
		seq	LevelEnde(bp)
		beq.s	1$
2$		move.l	0(a2),d0
		bne	5$
1$		movem.l	(sp)+,d2-d7/a2
		rts

;------------------------------------------------------------------------------

lbC00148A	move.w	6(a2),d6
		move.w	8(a2),d7
;		move.w	10(a2),d4
		move.w	12(a2),d5
		move.w	d6,d0
		move.w	d7,d1
		addq.w	#1,d1
		bsr	lbC0013CA
		beq.s	5$
		subq.w	#3,d0
		beq.s	4$
		subq.w	#5,d0				; 8
		beq.s	4$
		subq.w	#2,d0				; 10
		beq.s	4$
		tst.w	d5
		bne.s	5$
		moveq	#10,d1
		bsr	Random
		subq.b	#5,d0
		bcs.s	4$
5$		move.w	6(a2),14(a2)
		move.w	8(a2),16(a2)
		addq.w	#1,8(a2)
		clr.w	10(a2)
		move.w	#1,12(a2)
		bra.s	1$
4$		move.w	d6,d0
		move.w	d7,d1
		bsr	lbC0013CA
		subq.w	#4,d0
		bne.s	2$
		moveq	#11,d1
		bsr	Random
		subq.b	#3,d0
		bcs.s	3$
		subq.b	#4,d0
		bcs.s	2$
		neg.w	10(a2)
2$		bsr.s	lbC001536
		bra.s	1$
3$		move.w	6(a2),14(a2)
		move.w	8(a2),16(a2)
1$		rts

;------------------------------------------------------------------------------

lbC001536	tst.w	d5
		beq.s	6$
		move.w	#1,10(a2)
		clr.w	12(a2)
		moveq	#10,d1
		bsr	Random
		subq.b	#5,d0
		bcs.s	6$
		subq.w	#2,10(a2)			; -1
6$		moveq	#79,d1
		move.w	10(a2),d0
		beq.s	4$
		bpl.s	5$
		moveq	#0,d1
5$		cmp.w	d1,d6
		beq.s	3$
4$		add.w	d6,d0
		move.w	d7,d1
		bsr	lbC0013CA
		subq.w	#3,d0
		beq.s	3$
		subq.w	#5,d0
		bne.s	2$
3$		neg.w	10(a2)
2$		move.w	6(a2),14(a2)
		move.w	8(a2),16(a2)
		move.w	10(a2),d0
		add.w	d0,6(a2)
1$		rts

;------------------------------------------------------------------------------

lbC001672	move.l	a2,-(sp)
		tst.w	lbW003606(bp)
		bne.s	1$
		cmp.w	#4,lbW0035FE(bp)
		beq.s	1$
		move.l	RockList(bp),d0
5$		move.l	d0,a2
		tst.w	4(a2)
		beq.s	2$
		move.w	6(a2),d0
		cmp.w	xPosLad(bp),d0
		bne.s	2$
		move.w	8(a2),d1
		subq.w	#1,d1
		cmp.w	yPosLad(bp),d1
		beq.s	4$
		subq.w	#1,d1
		cmp.w	yPosLad(bp),d1
		bne.s	2$
4$		moveq	#100,d0
		add.w	d0,d0
		add.l	d0,Score(bp)
		add.w	d0,NextLive(bp)
		cmp.w	#10000,NextLive(bp)
		bcs.s	3$
		sub.w	#10000,NextLive(bp)
		addq.l	#1,Lives(bp)
		bsr	WriteLads
3$		bsr	WriteScore
		move.w	#3,AudCycles(bp)
		move.w	#3320,AudPeriod(bp)
		bsr	PlayNote
2$		move.l	0(a2),d0
		bne.s	5$
1$		move.l	(sp)+,a2
		rts

;------------------------------------------------------------------------------

lbC00184A	move.w	lbW0035FE(bp),d0
		move.w	#1,a0
		cmp.w	#15,d0
		beq.s	1$
		move.w	lbW003606(bp),d1
		beq.s	1$
		cmp.w	#4,d0
		beq.s	4$
		subq.w	#3,d1
		beq.s	4$
		subq.w	#5,d1
		beq.s	4$
		subq.w	#2,d1
		beq.s	4$
		clr.b	Jumping(bp)
		bra.s	1$
4$		tst.b	LeftRight(bp)
		beq.s	2$
		move.w	#lbW003608,a1
		bmi.s	3$
		move.w	#lbW00360C,a1
3$		cmp.w	#3,0(bp,a1.w)
		beq.s	1$
2$		suba.w	a0,a0
1$		move.l	a0,d0
		rts

;------------------------------------------------------------------------------

lbC0016C2	move.l	Mem_1840_1(bp),a0
		move.w	yPosLad(bp),d1
		move.w	xPosLad(bp),d0
		lsl.w	#4,d1
		add.w	d1,d0
		lsl.w	#2,d1
		add.w	d1,d0
		moveq	#0,d1
		move.b	-81(a0,d0.w),d1
		move.w	d1,lbW003608(bp)
		move.b	-80(a0,d0.w),d1
		move.w	d1,lbW003604(bp)
		move.b	-79(a0,d0.w),d1
		move.w	d1,lbW00360C(bp)
		move.b	-1(a0,d0.w),d1
		move.w	d1,lbW003602(bp)
		move.b	0(a0,d0.w),d1
		move.w	d1,lbW0035FE(bp)
		move.b	1(a0,d0.w),d1
		move.w	d1,lbW003600(bp)
		move.b	79(a0,d0.w),d1
		move.w	d1,lbW00360A(bp)
		move.b	80(a0,d0.w),d1
		move.w	d1,lbW003606(bp)
		move.b	81(a0,d0.w),d1
		move.w	d1,lbW00360E(bp)
		rts

;------------------------------------------------------------------------------

lbC0018B2	clr.l	-(sp)
		moveq	#9,d1
		bsr	Random
		subq.b	#2,d0
		bcs.s	2$
		addq.l	#2,0(sp)
		subq.b	#3,d0
		bcs.s	1$
		subq.l	#1,0(sp)
		neg.b	LeftRight(bp)
		beq.s	1$
		lea	CursorRight(pc),a0
		bpl.s	3$
		lea	CursorLeft(pc),a0
3$		jsr	0(a0)
		bra.s	1$
2$		clr.b	lbB003610(bp)
1$		move.l	(sp)+,d0
		rts

;------------------------------------------------------------------------------

lbC0018FC	bsr	lbC0016C2
		bsr	lbC001672
		cmp.w	#15,lbW0035FE(bp)
		bne.s	10$
		bsr.s	lbC0018B2
		cmp.b	#2,d0
		beq.s	7$
		bra.s	8$
10$		tst.b	lbB003610(bp)
		beq.s	9$
		bsr	lbC001B4E
		beq.s	1$
9$		bsr	lbC0019B6
		beq.s	1$
8$		tst.b	Jumping(bp)
		beq.s	6$
		clr.b	Jumping(bp)
		bsr	lbC00184A
		bne.s	6$
7$		st	lbB003610(bp)
		clr.b	lbB003612(bp)
		bsr	lbC001B4E
		beq.s	1$
6$		tst.b	LeftRight(bp)
		bne.s	5$
		tst.b	UpAndDown(bp)
		beq.s	1$
5$		tst.b	UpAndDown(bp)
		beq.s	3$
		lea	lbC001A06(pc),a0
		bmi.s	4$
		lea	lbC001A58(pc),a0
4$		jsr	0(a0)
3$		tst.b	LeftRight(bp)
		beq.s	1$
		lea	lbC001AFA(pc),a0
		bmi.s	2$
		lea	lbC001AA4(pc),a0
2$		jsr	0(a0)
1$		bsr	DrawPlayer
		bsr	lbC001732
		bsr	lbC001672
		rts

;------------------------------------------------------------------------------

lbC001B4E	moveq	#0,d0
		move.b	lbB003612(bp),d0
		pea	(1).w
		cmp.w	#6,d0
		bcc	2$
		move.b	12$(pc,d0.w),d0
		tst.b	LeftRight(bp)
		jmp	12$(pc,d0.w)
12$		dc.b	11$-12$
		dc.b	11$-12$
		dc.b	8$-12$
		dc.b	8$-12$
		dc.b	6$-12$
		dc.b	6$-12$
11$		lea	lbC001C7C(pc),a0
		beq.s	9$
		bmi.s	10$
		bsr	lbC001D52
		beq.s	4$
		subq.w	#2,d0
		beq.s	2$
		bsr	CursorLeft
10$		bsr	lbC001D02
		beq.s	4$
		subq.w	#2,d0
		beq.s	2$
		bsr	CursorRight
		lea	lbC001D52(pc),a0
9$		jsr	0(a0)
		bne.s	2$
8$		beq.s	4$
		bmi.s	7$
		bsr	lbC001AA4
		beq.s	4$
		subq.w	#2,d0
		beq.s	2$
		bsr	CursorLeft
7$		bsr	lbC001AFA
		beq.s	4$
		subq.w	#2,d0
		beq.s	2$
		bsr	CursorRight
		bsr	lbC001AA4
		beq.s	4$
		bra.s	2$
6$		lea	lbC001CC2(pc),a0
		beq.s	5$
		lea	lbC001DF6(pc),a0
		bmi.s	5$
		lea	lbC001DA4(pc),a0
5$		jsr	0(a0)
		bne.s	2$
4$		clr.l	0(sp)
		bsr	DrawPlayer
		bsr	lbC001732
		cmp.w	#4,lbW0035FE(bp)
		bne.s	3$
		bsr	lbC00164A
		bra.s	2$
3$		addq.b	#1,lbB003612(bp)
		cmp.b	#6,lbB003612(bp)
		bne.s	1$
2$		clr.b	lbB003612(bp)
		clr.b	lbB003610(bp)
1$		move.l	(sp)+,d0
		rts

;------------------------------------------------------------------------------

lbC001732	move.l	Mem_1840_1(bp),a0
		move.w	yPosLad(bp),d1
		move.w	xPosLad(bp),d0
		lsl.w	#4,d1
		add.w	d1,d0
		lsl.w	#2,d1
		add.w	d1,d0
		moveq	#0,d1
		move.b	0(a0,d0.w),d1
		move.w	d1,lbW0035FE(bp)
		move.b	80(a0,d0.w),d1
		move.w	d1,lbW003606(bp)
		rts

;------------------------------------------------------------------------------

lbC0019B6	move.w	lbW003606(bp),d0
		pea	(1).w
		subq.w	#3,d0
		beq.s	1$
		subq.w	#5,d0
		beq.s	1$
		subq.w	#2,d0
		beq.s	1$
		cmp.w	#4,lbW0035FE(bp)
		beq.s	1$
		move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr	FastDraw
;		move.w	d0,xPosLad(bp)
		addq.w	#1,yPosLad(bp)
		move.w	lbW003606(bp),lbW0035FC(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

lbC001A06	pea	(1).w
		move.w	yPosLad(bp),d1
		beq.s	1$
		move.w	lbW003604(bp),d0
		beq.s	1$
		subq.w	#3,d0
		beq.s	1$
		subq.w	#5,d0
		beq.s	1$
		move.w	xPosLad(bp),d0
;		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr	FastDraw
;		move.w	d0,xPosLad(bp)
		subq.w	#1,yPosLad(bp)
		move.w	lbW003604(bp),lbW0035FC(bp)
		clr.b	LeftRight(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

lbC001A58	move.w	lbW003606(bp),d0
		pea	(1).w
		subq.w	#3,d0
		beq.s	1$
		subq.w	#5,d0
		beq.s	1$
		subq.w	#2,d0
		beq.s	1$
		move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr	FastDraw
;		move.w	d0,xPosLad(bp)
		addq.w	#1,yPosLad(bp)
		move.w	lbW003606(bp),lbW0035FC(bp)
		clr.b	LeftRight(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

lbC001AA4	move.w	lbW003600(bp),d0
		pea	(2).w
		subq.w	#3,d0
		beq.s	1$
		subq.l	#1,0(sp)
		subq.w	#5,d0
		beq.s	1$
		cmp.w	#79,xPosLad(bp)
		beq.s	1$
		cmp.w	#10,lbW003606(bp)
		bne.s	2$
		bsr.s	lbC0017FA
2$		move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr	FastDraw
		addq.w	#1,xPosLad(bp)
;		move.w	d1,yPosLad(bp)
		move.w	lbW003600(bp),lbW0035FC(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

lbC001AFA	move.w	lbW003602(bp),d0
		pea	(2).w
		subq.w	#3,d0
		beq.s	1$
		subq.l	#1,0(sp)
		subq.w	#5,d0
		beq.s	1$
		tst.w	xPosLad(bp)
		beq.s	1$
		cmp.w	#10,lbW003606(bp)
		bne.s	2$
		bsr.s	lbC0017FA
2$		move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr	FastDraw
		subq.w	#1,xPosLad(bp)
;		move.w	d1,yPosLad(bp)
		move.w	lbW003602(bp),lbW0035FC(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

lbC0017FA	move.w	yPosLad(bp),d0
		move.w	xPosLad(bp),a0
		addq.w	#1,d0
		move.w	d0,d1
		lsl.w	#4,d0
		add.w	d0,a0
		lsl.w	#2,d0
		add.l	Mem_1840_1(bp),a0
		clr.b	0(a0,d0.w)
		move.w	xPosLad(bp),d0
		suba.l	a0,a0
		bra	FastDraw

lbC001C7C	move.w	lbW003604(bp),d0
		pea	(1).w
		subq.w	#3,d0
		beq.s	1$
		subq.w	#5,d0
		beq.s	1$
		move.w	yPosLad(bp),d1
		beq.s	1$
		move.w	xPosLad(bp),d0
;		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr	FastDraw
;		move.w	d0,xPosLad(bp)
		subq.w	#1,yPosLad(bp)
		move.w	lbW003604(bp),lbW0035FC(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

lbC001CC2	move.w	lbW003606(bp),d0
		pea	(1).w
		subq.w	#3,d0
		beq.s	1$
		subq.w	#5,d0
		beq.s	1$
		move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr	FastDraw
;		move.w	d0,xPosLad(bp)
		addq.w	#1,yPosLad(bp)
		move.w	lbW003606(bp),lbW0035FC(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

lbC001D02	move.w	lbW003608(bp),d0
		pea	(2).w
		subq.w	#3,d0
		beq.s	1$
		subq.l	#1,0(sp)
		subq.w	#5,d0
		beq.s	1$
		move.w	xPosLad(bp),d0
		beq.s	1$
		move.w	yPosLad(bp),d1
		beq.s	1$
;		move.w	xPosLad(bp),d0
;		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr	FastDraw
		subq.w	#1,xPosLad(bp)
		subq.w	#1,yPosLad(bp)
		move.w	lbW003608(bp),lbW0035FC(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

lbC001D52	move.w	lbW00360C(bp),d0
		pea	(2).w
		subq.w	#3,d0
		beq.s	1$
		subq.l	#1,0(sp)
		cmp.w	#79,xPosLad(bp)
		beq.s	1$
		move.w	yPosLad(bp),d1
		beq.s	1$
		subq.w	#5,d0
		beq.s	1$
		move.w	xPosLad(bp),d0
;		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr	FastDraw
		addq.w	#1,xPosLad(bp)
		subq.w	#1,yPosLad(bp)
		move.w	lbW00360C(bp),lbW0035FC(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

lbC001DA4	move.w	xPosLad(bp),d0
		pea	(1).w
		cmp.w	#79,d0
		beq.s	1$
		move.w	lbW00360E(bp),d1
		subq.w	#3,d1
		beq.s	1$
		subq.w	#5,d1
		beq.s	1$
		subq.w	#2,d1
		beq.s	1$
;		move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr.s	FastDraw
		addq.w	#1,xPosLad(bp)
		addq.w	#1,yPosLad(bp)
		move.w	lbW00360E(bp),lbW0035FC(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

lbC001DF6	pea	(1).w
		move.w	xPosLad(bp),d0
		beq.s	1$
		move.w	lbW00360A(bp),d1
		subq.w	#3,d1
		beq.s	1$
		subq.w	#5,d1
		beq.s	1$
		subq.w	#2,d1
		beq.s	1$
;		move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		move.w	lbW0035FC(bp),a0
		bsr.s	FastDraw
		subq.w	#1,xPosLad(bp)
		addq.w	#1,yPosLad(bp)
		move.w	lbW00360A(bp),lbW0035FC(bp)
		clr.l	0(sp)
1$		move.l	(sp)+,d0
		rts

;------------------------------------------------------------------------------

DrawPlayer	move.w	xPosLad(bp),d0
		move.w	yPosLad(bp),d1
		move.w	ShapeNum(bp),a0

;------------------------------------------------------------------------------

FastDraw	movem.l	d2-d6/a6,-(sp)
		move.w	a0,d2
		lsl.w	#3,d2
		lea	CharData(pc),a0
		adda.w	d2,a0
		move.l	BitMap+8(bp),a1
		moveq	#8-1,d2
1$		move.b	(a0)+,0(a1)
		addq.w	#2,a1
		dbra	d2,1$
		move.w	d0,a0
		moveq	#0,d0
		move.w	d1,a1
		moveq	#0,d1
		move.l	a0,d2
		move.l	a1,d3
		lsl.l	#3,d2
		lsl.l	#3,d3
		moveq	#8,d4
		moveq	#8,d5
		moveq	#256-$c0,d6
		neg.b	d6
		lea	BitMap(bp),a0
		move.l	RastPort(bp),a1
		CALL	BltBitMapRastPort,GfxBase(bp)
		movem.l	(sp)+,d2-d6/a6
		rts

;------------------------------------------------------------------------------

PlayNote	move.l	a6,-(sp)
		move.l	a2,-(sp)
		move.l	AudioIO(bp),a2
		tst.l	24(a2)
		bne.s	3$
		move.b	#-70,9(a2)
		move.w	#32,28(a2)
		move.b	#64,30(a2)
		lea	ChannelMap(pc),a0
		move.l	a0,34(a2)
		moveq	#4,d0
		move.l	d0,38(a2)
		move.l	a2,a1
		CALL	BeginIO,20(a2)
		tst.b	31(a2)
		bne.s	1$
3$		move.l	a2,a1
		CALL	CheckIO,SysBase(bp)
		tst.l	d0
		bne.s	2$
		move.l	a2,a1
		RECALL	AbortIO
		move.l	a2,a1
		RECALL	WaitIO
2$		move.w	#3,28(a2)
		move.b	#16,30(a2)
		move.l	AudData(bp),34(a2)
		moveq	#32,d0
		move.l	d0,38(a2)
		move.w	AudPeriod(bp),42(a2)
		move.w	#50,44(a2)
		move.w	AudCycles(bp),46(a2)
		move.l	a2,a1
		CALL	BeginIO,20(a2)
1$		move.l	(sp)+,a2
		move.l	(sp)+,a6
		rts

;------------------------------------------------------------------------------

TitleScreen	move.l	RastPort(bp),a1
		moveq	#0,d0
		CALL	SetRast,GfxBase(bp)
		lea	ProgName(pc),a0
		moveq	#95,d0
		moveq	#7,d1
		bsr	Banner
		lea	TitleMesg(pc),a2
4$		moveq	#0,d0
		move.b	(a2)+,d0
		moveq	#0,d1
		move.b	(a2)+,d1
		move.l	a2,a0
		bsr	PutStr
3$		tst.b	(a2)+
		bne.s	3$
		cmp.b	#$FF,0(a2)
		bne.s	4$
		moveq	#'0'+6,d2			; level
		lea	SmallBuf(bp),a0
		sub.b	Speed(bp),d2
		move.w	#446,d0
		moveq	#88,d1
		move.b	d2,0(a0)
		bsr	PutStr
		moveq	#131-9,d2
		lea	ScoreBuf(bp),a3
		moveq	#5-1,d3
2$		move.l	(a3)+,d0
		bsr	MakeNum
		add.w	#9,d2
		lea	NumberBuf(bp),a0
		move.w	#320,d0
		move.l	d2,d1
		bsr	PutStr
		move.l	a3,a0
		move.w	#400,d0
		move.l	d2,d1
		bsr	PutStr
		adda.w	#30,a3
		dbra	d3,2$
		move.l	Score(bp),d0
		beq.s	1$
		bsr	MakeNum				; d0 - score
		lea	LastScore(pc),a0
		move.w	#304,d0
		move.w	#182,d1
		bsr	PutStr
		lea	NumberBuf(bp),a0
		move.w	#392,d0
		move.w	#182,d1
		bsr	PutStr
1$		rts

;------------------------------------------------------------------------------

Banner		movem.l	d0-d7/a0-a6,-(sp)
		move.l	RastPort(bp),a6
		move.l	52(a6),a6
		move.l	a0,a5
5$		tst.b	(a0)+
		bne.s	5$
		suba.l	a5,a0
		subq.w	#2,a0
		move.l	a0,d5
4$		moveq	#0,d0
		move.b	(a5)+,d0
		move.l	$22(a6),a3
		move.b	d0,d4
		move.l	0(sp),d2
		sub.b	$20(a6),d0
		move.l	4(sp),a2
		adda.l	d0,a3
		moveq	#7,d6
3$		move.b	0(a3),d3
		moveq	#7,d7
2$		lea	SmallBuf(bp),a0
		move.b	d4,0(a0)
		btst	d7,d3
		bne.s	1$
		move.b	#32,0(a0)
1$		move.l	d2,d0
		move.l	a2,d1
		bsr	PutStr
		addq.l	#8,d2
		dbra	d7,2$
		adda.w	$26(a6),a3
		moveq	#64,d0
		addq.w	#8,a2
		sub.l	d0,d2
		dbra	d6,3$
		moveq	#80,d0
		add.l	d0,0(sp)
		dbra	d5,4$
		movem.l	(sp)+,d0-d7/a0-a6
		rts

;------------------------------------------------------------------------------

PauseGame	move.l	a6,-(sp)
		lea	InfoMesg1(pc),a0
		moveq	#0,d0
		move.w	#194,d1
		bsr	PutStr
2$		bsr.s	WaitUserPort
		cmp.l	#$400,imClass(bp)
		bne.s	2$
		move.w	imCode(bp),d0
		cmp.w	#$33,d0
		suba.l	a6,a6
		beq.s	1$
		cmp.w	#$20,d0
		bne.s	2$
		addq.w	#1,a6
1$		lea	InfoMesg2(pc),a0
		moveq	#0,d0
		move.w	#194,d1
		bsr	PutStr
		move.l	a6,d0
		move.l	(sp)+,a6
		rts

;------------------------------------------------------------------------------

GetName		movem.l	d2/a2/a3/a6,-(sp)
		move.l	WinPtr(bp),d2
		lea	StringGad(bp),a3
		move.l	d2,a0
		move.l	a3,a1
		moveq	#-1,d0
		CALL	AddGadget,IntBase(bp)
		move.l	a3,a0
		move.l	d2,a1
		suba.l	a2,a2
		RECALL	RefreshGadgets
		move.l	a3,a0
		move.l	d2,a1
		suba.l	a2,a2
		RECALL	ActivateGadget
1$		bsr.s	WaitUserPort
		moveq	#$40,d0
		cmp.l	imClass(bp),d0
		bne.s	1$
		move.l	d2,a0
		move.l	a3,a1
		CALL	RemoveGadget,IntBase(bp)
		movem.l	(sp)+,d2/a2/a3/a6
		rts

;------------------------------------------------------------------------------

WaitUserPort	bsr.s	CheckUserPort
		bne.s	WaitUserPort-2
		move.l	UserPort(bp),a0
		CALL	WaitPort,SysBase(bp)

;------------------------------------------------------------------------------

CheckUserPort	move.l	a6,-(sp)
		move.l	SysBase(bp),a6
		clr.l	imClass(bp)
		clr.w	imCode(bp)
2$		move.l	UserPort(bp),a0
		RECALL	GetMsg
		move.l	d0,a1
		tst.l	d0
		beq.s	1$
		move.l	20(a1),imClass(bp)
		move.w	24(a1),imCode(bp)
		btst	#3,26+1(a1)
		sne	imCtrl(bp)			; ctrl ?
		RECALL	ReplyMsg
		bra.s	2$
1$		tst.l	imClass(bp)
		move.l	(sp)+,a6
r_t_s		rts

;------------------------------------------------------------------------------

CheckInput	bsr	CheckUserPort
		beq.s	r_t_s
		cmp.l	#$400,imClass(bp)
		bne.s	r_t_s
		move.w	imCode(bp),d0
		tst.b	d0
		bmi.s	r_t_s
		cmp.w	#$45,d0
		beq.s	r_t_s

;------------------------------------------------------------------------------

TestKeys	cmp.w	#$4E,d0				; right
		beq.s	CursorRight
		cmp.w	#$2F,d0
		beq.s	CursorRight

		cmp.w	#$4F,d0				; left
		beq.s	CursorLeft
		cmp.w	#$2D,d0
		beq.s	CursorLeft

		cmp.w	#$4C,d0				; up
		beq.s	CursorUp
		cmp.w	#$3E,d0
		beq.s	CursorUp

		cmp.w	#$4D,d0				; down
		beq.s	CursorDown
		cmp.w	#$1E,d0
		beq.s	CursorDown

		cmp.w	#$40,d0				; space
		beq.s	SpaceKey

lbC00164A	lea	ShapeNum(bp),a0
		clr.b	LeftRight(bp)
		clr.b	UpAndDown(bp)
		moveq	#13,d0
		cmp.w	#1,0(a0)
		beq.s	2$
		cmp.w	#11,0(a0)
		bne.s	1$
		moveq	#14,d0
2$		move.w	d0,0(a0)
1$		rts

CursorUp	st	UpAndDown(bp)
		rts

CursorDown	move.b	#1,UpAndDown(bp)
		rts

CursorLeft	st	LeftRight(bp)
		clr.b	UpAndDown(bp)
		move.w	#11,ShapeNum(bp)
		rts

CursorRight	moveq	#1,d0
		move.b	d0,LeftRight(bp)
		clr.b	UpAndDown(bp)
		move.w	d0,ShapeNum(bp)
		rts

SpaceKey	st	Jumping(bp)
		rts

;------------------------------------------------------------------------------

GetLevelInfo	move.l	a6,-(sp)
		move.l	d2,-(sp)
		move.l	LevelPtr(bp),a0
		moveq	#-1,d0
5$		move.l	a0,LevelPtr(bp)
		moveq	#0,d2
		cmp.w	0(a0),d0
		beq.s	3$
4$		addq.w	#1,d2
		adda.w	0(a0),a0
		cmp.w	0(a0),d0
		bne.s	4$
3$		tst.w	d2
		lea	OrigLevel(pc),a0
		beq.s	5$
		move.l	SysBase(bp),a6
		move.l	TimeTab(bp),d0
		beq.s	2$
		move.l	d0,a1
		move.l	MaxLevel(bp),d0
		lsl.l	#2,d0
		RECALL	FreeMem
2$		move.l	d2,MaxLevel(bp)
		move.l	d2,d0
		lsl.l	#2,d0
		moveq	#0,d1
		RECALL	AllocMem
		move.l	d0,TimeTab(bp)
		add.l	d2,d0
		add.l	d2,d0
		move.l	d0,PlayTab(bp)
		move.l	LevelPtr(bp),a0
		move.l	TimeTab(bp),a1
		subq.w	#1,d2
1$		move.w	10(a0),(a1)+
		adda.w	0(a0),a0
		dbra	d2,1$
		move.l	(sp)+,d2
		move.l	(sp)+,a6
		rts

;------------------------------------------------------------------------------

LoadLevels
	IFND LOADLEVELS
		moveq	#0,d0
	ELSE
		adda.w	#-260,sp
		movem.l	d2/d3/d4/a2/a6,-(sp)
		move.l	a0,a2
		move.l	a0,d1
		moveq	#-2,d2
		CALL	Lock,DosBase(bp)
		move.l	d0,d3
		beq	1$
		move.l	d3,d1
		moveq	#14*4,d2
		add.l	sp,d2
		RECALL	Examine
		move.l	d0,d2
		move.l	d3,d1
		RECALL	UnLock
		tst.l	d2
		beq.s	1$
		move.l	LevelBuf(bp),d0
		beq.s	2$
		move.l	d0,a1
		move.l	LevelSize(bp),d0
		CALL	FreeMem,SysBase(bp)
		clr.l	LevelBuf(bp)
2$		move.l	14*4+124(sp),d0
		move.l	d0,LevelSize(bp)
		beq.s	1$
		moveq	#1,d1
		CALL	AllocMem,SysBase(bp)
		move.l	d0,LevelBuf(bp)
		beq.s	1$
		move.l	a2,d1
		move.l	#1005,d2
		CALL	Open,DosBase(bp)
		move.l	d0,d4
		beq.s	1$
		move.l	d4,d1
		move.l	LevelBuf(bp),d2
		move.l	LevelSize(bp),d3
		RECALL	Read
		move.l	d0,d2
		move.l	d4,d1
		RECALL	Close
		cmp.l	d2,d3
		seq	d0
		tst.b	d0
1$		movem.l	(sp)+,d2/d3/d4/a2/a6
		adda.w	#260,sp
	ENDC
		rts

;------------------------------------------------------------------------------

SaveScore	adda.w	#-172,sp
		lea	ScoreName(pc),a1
		move.l	a1,d1
		move.l	#1006,d2
		CALL	Open,DosBase(bp)
		move.l	d0,d4
		beq.s	1$
		move.l	#SINIT,Seed(bp)
		lea	ScoreBuf(bp),a2
		move.l	sp,a3
		move.w	#170-1,d2
2$		bsr.s	CodeNum
		add.b	(a2)+,d0
		move.b	d0,(a3)+
		dbra	d2,2$
		move.l	d4,d1
		move.l	sp,d2
		moveq	#170/2,d3
		add.w	d3,d3
		RECALL	Write
		move.l	d4,d1
		RECALL	Close
1$		adda.w	#172,sp
		rts

;------------------------------------------------------------------------------

LoadScore	adda.w	#-172,sp
		lea	ScoreName(pc),a1
		move.l	a1,d1
		move.l	#1005,d2
		CALL	Open,DosBase(bp)
		move.l	d0,d4
		beq.s	1$
		move.l	d4,d1
		move.l	sp,d2
		moveq	#170/2,d3
		add.w	d3,d3
		RECALL	Read
		move.l	d0,d2
		move.l	d4,d1
		RECALL	Close
		cmp.l	d2,d3
		bne.s	1$
		move.l	#SINIT,Seed(bp)
		move.l	sp,a2
		lea	ScoreBuf(bp),a3
		move.w	#170-1,d2
2$		bsr.s	CodeNum
		neg.b	d0
		add.b	(a2)+,d0
		move.b	d0,(a3)+
		dbra	d2,2$
1$		adda.w	#172,sp
		rts

;------------------------------------------------------------------------------

CodeNum		moveq	#256>>2,d1
		lsl.w	#2,d1

;------------------------------------------------------------------------------

Random		move.l	d1,-(sp)
		subq.w	#1,d1
		move.l	Seed(bp),d0
3$		add.l	d0,d0
		bhi.s	2$
		eori.l	#$1D872B41,d0
2$		lsr.w	#1,d1
		bne.s	3$
		move.l	d0,Seed(bp)
		move.l	(sp)+,d1
		beq.s	1$
		mulu.w	d1,d0
		clr.w	d0
1$		swap	d0
		rts

*******************************************************************************

		dc.b	'$VER: Ladder 1.1 (17.7.96)',0
DosName		dc.b	'dos.library',0
GfxName		dc.b	'graphics.library',0
IntName		dc.b	'intuition.library',0
IconName	dc.b	'icon.library',0
TimerName	dc.b	'timer.device',0
TopazName	dc.b	'topaz.font',0
AudioName	dc.b	'audio.device',0
ScoreName	dc.b	'highscore.lad',0
LevelName	dc.b	'leveldata.lad',0
ProgName	dc.b	'Ladder',0
ToolType	dc.b	'LEVEL',0
fmtstr		dc.b	'%8ld',0

Ready1		dc.b	'Get ready!',0

LastScore	dc.b	'Last Score:',0
Exiting		dc.b	' Exiting...',0

Message1	dc.b	'Come on, we don''t have all day!',0
Message2	dc.b	'You eat quiche!',0

StatusLine	dc.b	'Lads           Level               Score                     Bonus time',0

InfoMesg1	dc.b	'Game paused (a=abort, c=continue)',0
InfoMesg2	dc.b	'                                 ',0

HighMesg	dc.b	'YAHOO! YAHOO! YAHOO! YAHOO! YAHOO! YAHOO! YAHOO!',0
HighName	dc.b	'Enter your name :',0

TitleMesg	dc.b	0,070,'Tom van der Meijden                   Version : 1.1',0
		dc.b	0,079,'28 May 1991                           Terminal: Amiga',0
		dc.b	0,088,'Gunther Nikl                          Difficulty level:',0
		dc.b	0,097,'17 July 1996                          Up = 8  Down = 2  Left = 4  Right = 6',0
		dc.b	0,106,'                                      Jump = Space  Stop = Other',0
		dc.b	0,122,'P = Play game                         High Scores',0
		dc.b	0,131,'L = change level of difficulty        1)',0
		dc.b	0,140,'D = Load leveldata from disk          2)',0
		dc.b	0,149,'I = Instructions                      3)',0
		dc.b	0,158,'X = Exit ladder                       4)',0
		dc.b	0,167,'                                      5)',0
		dc.b	0,182,'Enter one of the above:',0
		dc.b	$FF

Instructions	dc.b	5,011,'You are a Lad trapped in a maze. Your mission is to explore the',0
		dc.b	5,020,'dark corridors never before seen by human eyes and find hidden',0
		dc.b	5,029,'treasures and riches.',0
		dc.b	5,047,'You control Lad by typing the direction buttons and jumping by',0
		dc.b	5,056,'typing SPACE. But beware of the falling rocks called Der rocks.',0
		dc.b	5,065,'You must find and grasp the treasure (shown as $) BEFORE the',0
		dc.b	5,074,'bonus time runs out.',0
		dc.b	5,092,'A new Lad will be awarded for every 10,000 points. Extra points',0
		dc.b	5,101,'are awarded for touching the gold statues (shown as &). You will',0
		dc.b	5,110,'receive the bonus time points that are left when you have finished ',0
		dc.b	5,119,'the level.',0
		dc.b	5,137,'Remember, there is more then one way to skin a cat. (Chum)',0
		dc.b	5,155,'Type ESCape to pause the game.',0
		dc.b	5,173,'Good luck Lad.',0
		dc.b	5,191,'Type RETURN to return to main menu',0
		dc.b	$FF

		cnop	0,4

ScoreTab	dc.l	500000
		dc.b	'You are a true Lad-Master!!! ',0
		dc.l	250000
		dc.b	'Wow! You are now a Lad-Guru! ',0
		dc.l	100000
		dc.b	'Yeah! Now you are a Lad-Wiz! ',0
		dc.l	50000
		dc.b	'Looks like we have a Lad-Der here',0
		dc.l	30000
		dc.b	'Amazing! You rate!!',0
		dc.l	10000
		dc.b	'Not bad for a young Lad',0
		dc.l	0
		dc.b	'You really don''t deserve this but... ',0

ChannelMap	dc.b	1,2,4,8

ColTab		dc.w	$0000,$0FFF

DeathTab	dc.b	16,1,16,17,11,18,16,17,16,18,1,2,19,20

CharData	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$7C,$C6,$C6,$FC,$C0,$C0,$C0
		dc.b	$00,$00,$00,$78,$CC,$CC,$CC,$78
		dc.b	$00,$FE,$00,$00,$FE,$00,$00,$00
		dc.b	$00,$CC,$CC,$CC,$FC,$CC,$CC,$CC
		dc.b	$00,$18,$3E,$60,$3C,$06,$7C,$18
		dc.b	$00,$38,$6C,$68,$76,$DC,$CC,$76
		dc.b	$00,$00,$00,$66,$66,$66,$3C,$18
		dc.b	$00,$18,$18,$18,$18,$18,$18,$18
		dc.b	$00,$00,$00,$66,$3C,$FF,$3C,$66
		dc.b	$00,$FE,$00,$00,$00,$00,$00,$00
		dc.b	$00,$7C,$C6,$C6,$7E,$06,$06,$06
		dc.b	$00,$10,$38,$7C,$10,$10,$10,$10
		dc.b	$00,$7C,$C6,$C6,$FC,$C0,$C0,$7C
		dc.b	$00,$7C,$C6,$C6,$7E,$06,$06,$7C
		dc.b	$00,$00,$00,$00,$00,$18,$00,$00
		dc.b	$00,$C0,$C0,$C0,$FC,$C6,$C6,$7C
		dc.b	$00,$06,$06,$06,$7E,$C6,$C6,$7C
		dc.b	$FC,$C6,$C6,$FC,$C0,$C0,$C0,$C0
		dc.b	$00,$00,$00,$00,$7E,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$7E

TuneData	dc.w	$46BA,$46BA,$46BA,$46BA,$46BA,$46BA,$46BA,$46BA
		dc.w	$46BA,$46BA,$46BA,$46BA,$46BA,$46BA,$46BA,$46BA

OrigLevel	dc.l	$00D000C4,$00050014,$050D0DAC,$7FC70007,$7F110005
		dc.l	$7F4F0004,$7F260004,$7F280004,$7F1D007F,$0903047F
		dc.l	$32037F1D,$00047F4F,$00047F4F,$00047F0A,$00047F1D
		dc.l	$00047F16,$007F1003,$047F0A03,$047F1203,$0000007F
		dc.l	$0803047F,$16037F10,$00067F0A,$00047F1D,$00047F0A
		dc.l	$00087F07,$00087F3C,$00047F09,$00456173,$79005374
		dc.l	$72656574,$7F120004,$7F280004,$7F1D007F,$0903047F
		dc.l	$0A03047F,$09030000,$7F17037F,$2200047F,$4F00047F
		dc.l	$4F00047F,$2800047F,$16007F18,$03007F16,$03007F09
		dc.l	$03047F0E,$037F4100,$047F4F00,$047F1600,$097F3800
		dc.l	$047F1500,$097F5003,$011A010D,$00110014,$080D1194
		dc.l	$7FEA0005,$7F480006,$7F060004,$7F090004,$7F070008
		dc.l	$077F3500,$07087F05,$00047F05,$007F0403,$047F1703
		dc.l	$007F1903,$007F1603,$7F070004,$7F4F0004,$7F4F0004
		dc.l	$7F140006,$00087F19,$000F000F,$7F120004,$7F05007F
		dc.l	$1A03007F,$06030000,$7F130300,$7F130304,$03037F4D
		dc.l	$00047F27,$00087F27,$00047F09,$00047F1D,$00087F11
		dc.l	$000F0000,$0F7F1200,$047F0500,$7F040304,$7F150300
		dc.l	$00007F06,$0300007F,$10030000,$7F16037F,$0700047F
		dc.l	$4F00047F,$1600087F,$3800047F,$1600087F,$18000F00
		dc.l	$00000F7F,$1100047F,$05007F19,$0300007F,$08037F04
		dc.l	$007F0E03,$0000007F,$12030403,$037F4D00,$047F0500
		dc.l	$7F0E037F,$1600087F,$2500047F,$06004C6F,$6E670049
		dc.l	$736C616E,$6400087F,$0D00097F,$0800087F,$1100097F
		dc.l	$1300047F,$05007F50,$03000150,$01430006,$0004050D
		dc.l	$0CE47FBD,$00077F0F,$00077F0B,$00077F0F,$00057F4E
		dc.l	$00050505,$7F100004,$7F340004,$7F06007F,$05050000
		dc.l	$00047F0B,$03040303,$037F3000,$03047F0E,$03047F0B
		dc.l	$00047F34,$00047F0E,$00047F0B,$00047F1E,$00067F15
		dc.l	$00047F0E,$00047F06,$007F0E03,$0000007F,$04037F05
		dc.l	$00037F04,$007F0603,$7F040003,$0000007F,$04037F04
		dc.l	$007F0503,$047F0503,$7F090004,$7F050047,$7F0E000C
		dc.l	$0C0C7F04,$007F050C,$007F040C,$7F06007F,$040C000C
		dc.l	$0C0C7F04,$000C0C0C,$7F150005,$7F050068,$7F410008
		dc.l	$7F0D006F,$7F050008,$7F150004,$7F1D0006,$7F070008
		dc.l	$7F0D0073,$7F05007F,$1603047F,$1E03007F,$0B037F09
		dc.l	$00747F08,$00067F12,$00047F4F,$00047F3D,$00087F11
		dc.l	$00047F11,$00047F13,$00047F0D,$00547F09,$007F1203
		dc.l	$047F1103,$047F1303,$047F0703,$7F06006F,$7F2D0004
		dc.l	$7F130004,$7F0D0077,$7F410004,$7F0D006E,$7F1B000C
		dc.l	$7F250004,$7F080009,$7F1F000C,$0C0C7F24,$00047F07
		dc.l	$00097F50,$030001BA,$01AE004C,$0012050E,$0C807FCC
		dc.l	$00077F17,$00077F60,$00047F0D,$00047F19,$00087F10
		dc.l	$00047F11,$007F0503,$047F0503,$0A0A7F06,$03047F1A
		dc.l	$037F0500,$0303037F,$040A7F04,$03047F0B,$037F0B00
		dc.l	$047F0D00,$047F1000,$0806067F,$1700047F,$1600047F
		dc.l	$0D00047F,$10007F12,$037F0800,$047F1600,$047F0D00
		dc.l	$047F1700,$74756E6E,$656C0000,$047F0A00,$047F1600
		dc.l	$047F0B00,$7F07030A,$0A0A0303,$037F040A,$7F110304
		dc.l	$037F0900,$047F0B00,$047F0A00,$047F0900,$087F1B00
		dc.l	$76697369,$6F6E0000,$047F0A00,$047F0B00,$047F0A00
		dc.l	$047F0900,$7F09030A,$0A0A067F,$06007F05,$0A7F0C03
		dc.l	$047F0A00,$047F0B00,$047F0A00,$047F0B00,$047F2100
		dc.l	$0400087F,$0800047F,$0B00047F,$0A00047F,$0B00047F
		dc.l	$09037F04,$0A030303,$7F040A7F,$10037F08,$00040000
		dc.l	$7F0F037F,$1100047F,$28000600,$0000047F,$2200047F
		dc.l	$28000800,$0000047F,$11007F04,$030A0A0A,$7F04037F
		dc.l	$0600047F,$28000800,$0000047F,$1100087F,$0900087F
		dc.l	$04007F10,$030A0A0A,$0303030A,$0A0A7F13,$03000000
		dc.l	$047F1100,$08000000,$03030300,$0000087F,$3300047F
		dc.l	$0800047F,$0800087F,$0400057F,$0400087F,$3300047F
		dc.l	$05000303,$03047F08,$03080900,$00050505,$00000908
		dc.l	$00000009,$7F100009,$7F070009,$7F150009,$047F0700
		dc.l	$09047F08,$007F5003,$015E0151,$00490005,$070E0B54
		dc.l	$7FA90005,$7F4F0004,$7F330007,$7F1B0004,$7F4F007F
		dc.l	$0D047F05,$000F7F0E,$047F1A00,$047F1400,$067F1300
		dc.l	$077F0B00,$047F1800,$0303047F,$0B037F29,$00047F1A
		dc.l	$00047F0E,$00047F25,$00047F08,$000F7F11,$00047F0B
		dc.l	$00030303,$047F0E03,$7F0B0A7F,$0C03047F,$04037F16
		dc.l	$00047F0E,$00047F36,$00047F09,$00047F0E,$00047F31
		dc.l	$007F0503,$047F0E03,$7F0A0004,$7F250004,$7F100004
		dc.l	$7F180004,$7F0E0006,$0F0F0C0C,$0C7F050F,$0C0F0F0C
		dc.l	$000F000C,$0C000000,$0403037F,$090A7F05,$00047F18
		dc.l	$00047F09,$007F1C03,$047F0400,$067F0B00,$047F0D00
		dc.l	$047F0A00,$047F0900,$0303037F,$06000303,$037F0600
		dc.l	$0303037F,$0700047F,$04007F09,$0A7F1103,$047F0703
		dc.l	$00000004,$7F250004,$7F1E0004,$7F0A0004,$7F1A0006
		dc.l	$7F0A0004,$7F0A0006,$7F130004,$7F0A007F,$0A037F19
		dc.l	$0A7F0703,$7F0A0A7F,$13037F56,$000C0C0C,$097F0900
		dc.l	$7F190C09,$7F050009,$7F0A0C09,$506F696E,$74006F66
		dc.l	$004E6F00,$52657475,$726E097F,$050C7F50,$0300018E
		dc.l	$01820021,$000A060E,$0B547FA8,$00427567,$00436974
		dc.l	$797F0D00,$7F08047F,$1A00077F,$2B000404,$047F0600
		dc.l	$0404047F,$2C00047F,$2A003E7F,$086D7F1C,$00047F0F
		dc.l	$037F1300,$7F14037F,$0A00047F,$0E00047F,$0E00087F
		dc.l	$05037F07,$005C0000,$2F7F0900,$077F1200,$7F050304
		dc.l	$7F0B0300,$0000047F,$1C005C2F,$7F220004,$7F0E0004
		dc.l	$7F280008,$00057F15,$00047F0E,$00047F0B,$00047F1C
		dc.l	$00080004,$7F150004,$7F0E0004,$7F07007F,$0403047F
		dc.l	$07037F15,$00080604,$7F040004,$7F100004,$7F0E0004
		dc.l	$7F0B0004,$7F0D007F,$1603047F,$0B007F06,$037F0E00
		dc.l	$047F0B00,$047F0600,$06087F1B,$00047F14,$00047F0A
		dc.l	$00047F0B,$00047F06,$0006087F,$1400047F,$0600047F
		dc.l	$05007D7B,$7F08007F,$0503047F,$05030000,$03030304
		dc.l	$03030306,$7F070004,$7F07007F,$1503047F,$0600047F
		dc.l	$1400047F,$1600047F,$1C00047F,$0600047F,$1400047F
		dc.l	$1600047F,$1C00047F,$0600067F,$1400047F,$10007F06
		dc.l	$03040303,$03000000,$7F07037F,$0400047F,$04003C3E
		dc.l	$7F040006,$7F1B0004,$7F280004,$7F0A037F,$07007F05
		dc.l	$037F0500,$037F0500,$7F0D037F,$05007D69,$7B7F1900
		dc.l	$047F2E00,$097F2000,$047F2D00,$097F5003,$01FA01EE
		dc.l	$00060004,$060D0898,$7FB40003,$47616E67,$004C616E
		dc.l	$64037F1D,$00077F09,$000F7F1C,$0003037F,$06005F00
		dc.l	$0003037F,$26000F7F,$1400047F,$08000800,$005B5D00
		dc.l	$085F0800,$087F1200,$067F1400,$0F000004,$7F06007F
		dc.l	$0B03047F,$0800087F,$0500085F,$0800087F,$0700047F
		dc.l	$09000303,$03000000,$7F130304,$7F0C0007,$7F040004
		dc.l	$7F08007F,$0D037F05,$00047F06,$037F1C00,$047F1100
		dc.l	$047F1A00,$047F1500,$067F0C00,$047F1100,$047F1A00
		dc.l	$047F1000,$087F0400,$087F0C00,$047F0A00,$047F0600
		dc.l	$047F0800,$0C0C0C06,$060C0C0C,$0006000C,$00000C0C
		dc.l	$0C00047F,$0B00047F,$0400087F,$04007F0D,$03047F0A
		dc.l	$00047F06,$03040000,$007F1703,$047F0B03,$047F0503
		dc.l	$7F0A0006,$7F060004,$7F0A0004,$7F210004,$7F0B0004
		dc.l	$7F040008,$7F090006,$06067F05,$00047F0A,$00047F21
		dc.l	$00047F0B,$00047F04,$00087F08,$007F0506,$7F040004
		dc.l	$7F0A0004,$7F210004,$7F0B0004,$7F040008,$7F04007F
		dc.l	$0D03047F,$14007F05,$037F060A,$7F11037F,$0800047F
		dc.l	$0400087F,$0700057F,$0500057F,$3300087F,$0800047F
		dc.l	$0400087F,$06000505,$05000000,$0505057F,$09007F04
		dc.l	$037F060A,$0303037F,$1C00087F,$0800047F,$0400087F
		dc.l	$05007F05,$05007F05,$057F1400,$087F0700,$037F1400
		dc.l	$08007F0D,$037F0400,$7F0C037F,$1400087F,$0700057F
		dc.l	$15000C7F,$0A00067F,$2600087F,$0E0C7F06,$0005000C
		dc.l	$7F0E007F,$06037F18,$00097F13,$000F7F06,$00060000
		dc.l	$000C0004,$090C7F14,$000C0000,$0C7F0700,$7F0D0C7F
		dc.l	$5003FFFF

		end

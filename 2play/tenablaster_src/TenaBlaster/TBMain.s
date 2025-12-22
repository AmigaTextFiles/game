**
** TENABLASTER, Programmed by Peter Bakota
** (C)1995 Tenax Software, Ltd.
** All rights reserved.
**

**
** REGISTERED EXTENSION (c)1997 Copyright Peter Bakota (29.01.97)
**

REGISTERED	equ	1

STKSIZE		EQU	8000		;STACK size a program szamara!

MIN_CHIP_MEMORY	EQU	400*1024	;Min. CHIP memory to run this game!
;MIN_CHIP_MEMORY	EQU	100*1024	;Min. CHIP memory to run this game!
MIN_PUBL_MEMORY	EQU	54*1024		;Min. PUBLIC memory to run this game!
MAX_PUBL_MEMORY	EQU	100*1024	;Max. PUBLIC memory to RUN this game (WITH MUSIC!)

BRK	MACRO
.brk: 	move.w	#$f00,$dff180
	btst	#2,$dff016
	bne	.brk
	ENDM

BREAK_EXECUTE MACRO
	jmp	BreakExecute(pc)
	ENDM

DEBUG_RESULT MACRO
	move.l	\1,DRes
	BREAK_EXECUTE
	ENDM

	include	"TBEqu.s"	;Equates & data structures!
	RsSet	DataLong
	include	"TBLog" 	;File list!

	opt	o+,ow-
	section	Start,code

Start	sub.l 	a1,a1
	CallSys	FindTask
	move.l	d0,REG_Process
	tst.l 	pr_CLI(REG_Process)
	bne	CLIStart
	lea	pr_MsgPort(REG_Process),a0
	jsr	WaitPort(a6)
	lea	pr_MsgPort(REG_Process),a0
	jsr	GetMsg(a6)
	lea	WBMessage(pc),a0
	move.l	d0,(a0)
	move.w	#200,d0
	bsr	WaitX
CLIStart
	bsr	Main
	move.l	WBMessage(pc),d0
	beq	.Exit
	CallSys	Forbid
	move.l	WBMessage(pc),a1
	jsr	ReplyMsg(a6)
.Exit 	moveq 	#0,d0
; 	move.l	DRes(pc),d0
	rts

;DRes	ds.l	1
WBMessage
	ds.l	1

TbVersion
	IFD	REGISTERED
	dc.b	"$VER: Tenablaster V1.1R - (C)1995,96 TENAX Software",0
	ELSEIF
	dc.b	"$VER Tenablaster V1.1 - (C)1995,96 TENAX Software",0
	ENDC
	even

	include "TBSystem.s"	;Include System functions!
	
;***********************************************************

PrepareMemory
	bsr	GetAllMem	;GetAll of memory!
	tst.l	d0
	beq	.NoMem
	move.l	#ScreenSIZEOF*5,d0
	move.l	#0,d1
	bsr	AllocMemBlock
	move.l	d0,SysPlaneA(a5)
	beq	.MError
	move.l	#ScreenSIZEOF*5,d0
	move.l	#0,d1
	bsr	AllocMemBlock
	move.l	d0,SysPlaneB(a5)
	beq	.MError
	move.l	#ScreenSIZEOF*5,d0
	move.l	#0,d1
	bsr	AllocMemBlock
	move.l	d0,SysPlaneC(a5)
	beq	.MError
	move.l	#COPPERLISTSIZE,d0
	move.l	#0,d1
	bsr	AllocMemBlock
	move.l	d0,CopperListA(a5)
	beq	.MError
	move.l	#COPPERLISTSIZE,d0
	move.l	#0,d1
	bsr	AllocMemBlock
	move.l	d0,CopperListB(a5)
	beq	.MError
	move.l	#ENEMYDATASIZE,d0
	move.l	#0,d1
	bsr	AllocMemBlock
	move.l	d0,Enemy1Data(a5)
	beq	.MError
	move.l	#ENEMYDATASIZE,d0
	move.l	#0,d1
	bsr	AllocMemBlock
	move.l	d0,Enemy2Data(a5)
	beq	.MError
	move.l	#ENEMYDATASIZE,d0
	move.l	#0,d1
	bsr	AllocMemBlock
	move.l	d0,Enemy3Data(a5)
	beq	.MError
	move.l	#ENEMYDATASIZE,d0
	move.l	#0,d1
	bsr	AllocMemBlock
	move.l	d0,Enemy4Data(a5)
	beq	.MError
	move.l	LocTop(a5),LowLocMem(a5) ;Set lower limit of local memory!
.NoMem	rts

.MError	move.w	#$ff0,$dff180
	btst	#6,$bfe001
	bne	.MError
	BREAK_EXECUTE

Initialize
	sub.l 	a1,a1
	CallSys	FindTask
	move.l	d0,ThisTask(a5)
	move.l	d0,a1
	move.l	pr_WindowPtr(a1),oldprWindow(a5)
	move.l	#-1,pr_WindowPtr(a1)
	lea	GfxName(pc),a1
	moveq 	#LIBVER,d0
	jsr	OpenLib(a6)
	move.l	d0,GfxBase(a5)
	beq	.ErrorNoLib
	lea	IntName(pc),a1
	moveq 	#LIBVER,d0
	jsr	OpenLib(a6)
	move.l	d0,IntuiBase(a5)
	beq	.ErrorNoLib
	lea	DosName(pc),a1
	moveq 	#LIBVER,d0
	jsr	OpenLib(a6)
	move.l	d0,DosBase(a5)
	beq	.ErrorNoLib
	lea	NewScreen(pc),a0
	CallInt	OpenScreen
	move.l	d0,FScreen(a5)
	beq	.ErrorNoScreen
	move.w	#$100,$dff096
	move.l	#STKSIZE,d0
	move.l	#$10001,d1
	bsr	MyAllocMem
	tst.l	d0
	beq	.ErrorStk
	add.l	#STKSIZE,d0
	move.l	d0,PSP(a5)
.ErrorStk
.ErrorNoLib
.ErrorNoScreen
	rts

DeInitialize
	move.l	PSP(a5),d0
	beq	.NoPSP
	sub.l	#STKSIZE,d0
	move.l	d0,a1
	bsr	MyFreeMem
.NoPSP	tst.l 	FScreen(a5)
	beq	.NoScreen
	move.l	FScreen(a5),a0
	CallInt	CloseScreen
.NoScreen
	tst.l 	DosBase(a5)
	beq	.NoDos
	move.l	DosBase(a5),a1
	CallSys	CloseLib
.NoDos	tst.l 	IntuiBase(a5)
	beq	.NoIntui
	move.l	IntuiBase(a5),a1
	CallSys	CloseLib
.NoIntui
	tst.l 	GfxBase(a5)
	beq	.NoGfx
	move.l	GfxBase(a5),a1
	CallSys	CloseLib
.NoGfx	move.l	ThisTask(a5),a1
	move.l	oldprWindow(a5),pr_WindowPtr(a1)
	rts


** Sets sound fx to play
* FxNb=d0, PlayerDef=a1
PlayBankFx
	movem.l	d1/a1,-(sp)
	move.w	plSbk(a1),d1
	lea	Bank0Fx(a5),a1
	mulu	#fxSIZEOF*MAXBANKFX,d1
	mulu	#fxSIZEOF,d0
	add.l	d1,a1
	add.l	d0,a1
	bsr	PlayFx
	movem.l	(sp)+,d1/a1
	rts
	
* Chanel=d0, SoundDef=a1
PlaySpecialFx
	move.l	d0,FxChanel(a5)
	sub.b	#$a0,d0
	lsr.b	#4,d0
	ext.w	d0
	add.w	d0,d0
	lea	FxCounters(a5),a2
	clr.w	(a2,d0.w)

* SoundDef=a1
PlayFx	movem.l	d0-d2/a0/a2/a3,-(sp)
	tst.b 	(a1)
	beq	.Exit
	moveq 	#0,d0
	move.b	fxSample(a1),d0
	mulu	#eiSIZEOF,d0
	lea	SampleInfo-eiSIZEOF(a5),a0
	lea	(a0,d0.l),a0
	lea	FxCounters(a5),a2
	moveq	#1,d1
	move.l	FxChanel(a5),d0
	cmp.b	#$a0,d0
	beq	.Set
	add.w	d1,d1
	addq.w	#2,a2
	cmp.b	#$b0,d0
	beq	.Set
	add.w	d1,d1
	addq.w	#2,a2
	cmp.b	#$c0,d0
	beq	.Set
	add.w	d1,d1
	addq.w	#2,a2
	cmp.b	#$d0,d0
	beq	.Set
	add.w	d1,d1
	addq.w	#2,a2
.Set	moveq	#3,d2
.Loop	tst.w	(a2)
	bne	.Loop2
	move.w	d1,$dff096
	or.w	d1,DMAReg(a5)
	or.w	#$8000,d1
	move.l	d0,a3
 	move.l	d0,FxChanel(a5)
	move.l	eiStart(a0),(a3)+
	move.w	eiLength(a0),(a3)+
	move.w	fxPeriod(a1),(a3)+
	moveq 	#0,d0
	move.b	fxVolume(a1),d0
	move.w	d0,(a3)
	move.w	d1,$dff096
	move.w	fxRate(a1),(a2)
	bra	.Exit

.Loop2	addq.w	#2,a2
	add.w	d1,d1
	add.b 	#$10,d0
	cmp.b 	#$e0,d0
	bne	.A
	lea	FxCounters(a5),a2
	move.b	#$a0,d0
	moveq	#1,d1
.A	dbf	d2,.Loop

.Exit 	movem.l	(sp)+,d0-d2/a0/a2/a3
	rts
	
SoundFxCounters
	lea	FxCounters(a5),a0
	moveq 	#3,d0
	moveq 	#1,d1
.Loop 	tst.w 	(a0)+
	ble	.Loop1
	subq.w	#1,-2(a0)
	bne	.Loop1
	move.w	d1,$dff096
	not.w	d1
	and.w	d1,DMAReg(a5)
	not.w	d1
.Loop1	add.w 	d1,d1
	dbf	d0,.Loop
	rts

ResetAudio
	lea	FxCounters(a5),a0
	clr.w 	(a0)+
	clr.w 	(a0)+
	clr.w 	(a0)+
	clr.w 	(a0)
	move.l	#$dff0a0,FxChanel(a5)
	clr.w 	$dff0a8
	clr.w 	$dff0b8
	clr.w 	$dff0c8
	clr.w 	$dff0d8
	move.w	#$f,$dff096
	clr.w	DMAReg(a5)
	rts

;******************************** Copper lists
; bitplanes=d0, buffer=a0
MakeCListReq
	move.l	#$01060c00,(a0)+
	move.l	#$01fc0000,(a0)+
	move.l	#$008ea871,(a0)+
	move.l	#$0090b0c1,(a0)+
	move.l	#$00920030,(a0)+
	move.l	#$009400d0,(a0)+
	move.l	#$01080000,(a0)+
	move.l	#$010a0000,(a0)+
	move.l	#$01020000,(a0)+
	move.l	#$01040000,(a0)+
	move.l	#$0180080a,(a0)+
	move.l	#$01820fff,(a0)+
	swap	d0
	move.w	#$00e0,(a0)+
	move.w	d0,(a0)+
	swap	d0
	move.w	#$00e2,(a0)+
	move.w	d0,(a0)+
	move.l	#$01001200,(a0)+
	move.l	#$fffffffe,(a0)
	rts
		
; bitplanes=d0, buffer=a0
MakeCListJump
	move.l	#$01060c00,(a0)+
	move.l	#$01fc0000,(a0)+
	move.l	#$008e2c81,(a0)+
	move.l	#$00902cc1,(a0)+
	move.l	#$00920038,(a0)+
	move.l	#$009400d0,(a0)+
	move.l	#$01080078,(a0)+
	move.l	#$010a0078,(a0)+
	move.l	#$01020000,(a0)+
	move.l	#$01040024,(a0)+
	move.l	a0,copSprites(a5)
	bsr	InsertCopSprites
	move.l	a0,copPaletta(a5)
	bsr	InsertCopPaletta
	move.l	#$01000200,(a0)+
	move.l	a0,CopJmpPtr(a5)
	move.l	#$ffdffffe,(a0)+
	move.l	#$2c01fffe,(a0)+
	move.l	a0,copPlanes(a5)
	bsr	InsertCopPlanes40
	move.l	#$01004200,(a0)+
	move.l	#$fffffffe,(a0)
	rts

; bitplanes=d0, buffer=a0
MakeCList42
	move.l	#$01060c00,(a0)+
	move.l	#$01fc0000,(a0)+
	move.l	#$008e2c71,(a0)+
	move.l	#$00902cc1,(a0)+
	move.l	#$00920030,(a0)+
	move.l	#$009400d0,(a0)+
	move.l	#$01020000,(a0)+
	move.l	#$01040024,(a0)+
	move.l	#$010800a8,(a0)+
	move.l	#$010a00a8,(a0)+
	move.l	a0,copSprites(a5)
	bsr	InsertCopSprites
	move.l	a0,copPaletta(a5)
	bsr	InsertCopPaletta
	move.l	a0,copPlanes(a5)
	bsr	InsertCopPlanes42
	move.l	#$01005200,(a0)+
	move.l	#$fffffffe,(a0)
	rts

;bitplanes=d0, buffer=a0
MakeCListGame
	move.l	#$01060c00,(a0)+
	move.l	#$01fc0000,(a0)+
	move.l	#$008e3471,(a0)+
	move.l	#$009024c1,(a0)+
	move.l	#$00920030,(a0)+
	move.l	#$009400d0,(a0)+
	move.l	a0,copReg102(a5)
	move.l	#$01020000,(a0)+
	move.l	#$01040024,(a0)+
	move.l	#$010800a8,(a0)+
	move.l	#$010a00a8,(a0)+
	move.l	a0,copSprites(a5)
	bsr	InsertCopSprites
	move.l	a0,copPaletta(a5)
	bsr	InsertCopPaletta
	move.l	a0,copPlanes(a5)
	bsr	InsertCopPlanes42
	move.l	#$01005200,(a0)+
	move.l	#$fffffffe,(a0)
	rts

InsertCopSprites
	move.w	#$120,d1
.Loop 	move.w	d1,(a0)+
	clr.w 	(a0)+
	addq.w	#2,d1
	cmp.w 	#$140,d1
	bne	.Loop
	rts

;CopPalPtr=a0
InsertCopPaletta
	move.w	#$180,d1
.Loop 	move.w	d1,(a0)+
	clr.w 	(a0)+
	addq.w	#2,d1
	cmp.w 	#$1c0,d1
	bne	.Loop
	rts

;CopPlanePtr=a0
InsertCopPlanes40
	move.l	d2,-(sp)
	moveq 	#40,d2
	bra	InserCopX
InsertCopPlanes42
	move.l	d2,-(sp)
	moveq 	#42,d2
InserCopX
	move.w	#$e0,d1
.Loop move.w	d1,(a0)+
	swap	d0
	move.w	d0,(a0)+
	addq.w	#2,d1
	move.w	d1,(a0)+
	swap	d0
	move.w	d0,(a0)+
	addq.w	#2,d1
	add.l 	d2,d0
	cmp.w 	#$f8,d1
	bne	.Loop
	move.l	(sp)+,d2
	rts

;CopPlanePtr=a0
SetCopPlanes42
	move.l	d2,-(sp)
	move.l	#42,d2
	bra	SetCopPlanesX
SetCopPlanes40
	move.l	d2,-(sp)
	move.l	#40,d2

SetCopPlanesX
	move.l	copPlanes(a5),a0
	moveq 	#4,d1
.Loop move.w	d0,6(a0)
	swap	d0
	move.w	d0,2(a0)
	swap	d0
	add.l 	d2,d0
	addq.w	#8,a0
	dbf	d1,.Loop
	move.l	(sp)+,d2
	rts

;ColorTab=a1
SetCopPaletta
	movem.l	d0/a0,-(sp)
	move.l	copPaletta(a5),a0
	addq.l	#2,a0
	moveq 	#31,d0
.Loop 	move.w	(a1)+,(a0)+
	addq.w	#2,a0
	dbf	d0,.Loop
	movem.l	(sp)+,d0/a0
	rts

ClearCopPaletta
	move.l	copPaletta(a5),a0
	addq.l	#2,a0
	moveq 	#31,d0
.Loop 	clr.w 	(a0)+
	addq.w	#2,a0
	dbf	d0,.Loop
	rts

SetCopperList
	bsr	WaitBOF
	move.l	#$7fff,$dff096
	move.l	a0,LastCopperList(a5)
	move.l	a0,$dff080
;	clr.w 	$dff088
	move.w	#$83d0,$dff096
	rts

;BitPlanesPtr=a0
InitPointer
	add.l 	#149*42*5+26,a0
	move.l	CopperListB(a5),a1
	move.l	#$80,d0
	move.l	d0,3*26*4(a1)
	move.l	d0,2*26*4(a1)
	move.l	d0,1*26*4(a1)
	move.l	d0,(a1)+
	moveq 	#23,d0
.Loop 	move.w	0*42+0(a0),0*26*4+0*2(a1)
	move.w	1*42+0(a0),0*26*4+1*2(a1)
	move.w	2*42+0(a0),1*26*4+0*2(a1)
	move.w	3*42+0(a0),1*26*4+1*2(a1)
	move.w	0*42+2(a0),2*26*4+0*2(a1)
	move.w	1*42+2(a0),2*26*4+1*2(a1)
	move.w	2*42+2(a0),3*26*4+0*2(a1)
	move.w	3*42+2(a0),3*26*4+1*2(a1)
	add.l 	#4,a1
	add.l 	#42*5,a0
	dbf	d0,.Loop
	clr.l 	3*26*4(a1)
	clr.l 	2*26*4(a1)
	clr.l 	1*26*4(a1)
	clr.l 	(a1)
	move.l	copSprites(a5),a0
	move.l	CopperListB(a5),d0
	moveq 	#3,d1
.Loop2	move.w	d0,6(a0)
	swap	d0
	move.w	d0,2(a0)
	swap	d0
	addq.l	#8,a0
	add.l 	#26*4,d0
	dbf	d1,.Loop2
	move.w	#$8020,$dff096
	rts

;pointerx=d0, pointery=d1
SetPointerPos
	move.l	CopperListB(a5),a0
	add.w	#$71,d0
	add.w 	#$2c,d1
	lsr.w 	d0
	move.b	d1,d2
	lsl.l 	#8,d2
	move.b	d0,d2
	swap	d2
	clr.w 	d2
	cmp.w 	#256,d0
	blt	.A
	bset	#0,d2
.A 	cmp.w 	#256,d1
	blt	.B
	bset	#2,d2
.B 	add.w 	#24,d1		;24=Pointer HEIGHT!
	cmp.w 	#256,d1
	blt	.C
	bset	#1,d2
.C 	lsl.w 	#8,d1
	or.w	d1,d2
	bset	#7,d2
	move.l	d2,0*26*4(a0)
	move.l	d2,1*26*4(a0)
	addq.w	#8,d0
	swap	d2
	move.b	d0,d2
	swap	d2
	cmp.w 	#256,d0
	blt	.D
	bset	#0,d2
.D 	move.l	d2,2*26*4(a0)
	move.l	d2,3*26*4(a0)
	rts

* Bitplane=d0
ShowJumpPic
	move.l	d0,-(sp)
	move.l	CopperListA(a5),a0
	bsr	MakeCListJump
	move.l	(sp)+,a1
	add.l	#40*4*256,a1
	bsr	SetCopPaletta
	move.l	CopperListA(a5),a0
	bsr	SetCopperList
	lea	CopJmpTab(pc),a1
	lea	CopJmpEnd(pc),a2
	move.l	CopJmpPtr(a5),a0
.Loop	move.w	(a1)+,d0
	add.w	#$2c,d0
	cmp.w	#$100,d0
	bhs	.Loop2
	move.l	#$01fe0000,(a0)
.Loop2	move.b	d0,4(a0)
.A	btst	#0,$dff005
	beq	.A
	cmp.b	#$2c,$dff006
	bne	.A
	cmp.l	a2,a1
	blo	.Loop
.End	rts

HideJumpPic
	lea	CopJmpEnd(pc),a1
	lea	CopJmpTab(pc),a2
	move.l	CopJmpPtr(a5),a0
.Loop	move.w	-(a1),d0
	add.w	#$2c,d0
	cmp.w	#$100,d0
	blo	.Loop2
	move.l	#$ffdffffe,(a0)
.Loop2	move.b	d0,4(a0)
.A	btst	#0,$dff005
	beq	.A
	cmp.b	#$2c,$dff006
	bne	.A
	cmp.l	a2,a1
	bhi	.Loop
	bsr	ClearCopPaletta
	rts
			
CopJmpTab:
 dc.w 256,252,248,244,240,236,232,228,224,220
 dc.w 216,212,208,204,200,196,192,188,184,180
 dc.w 176,172,168,164,160,157,153,149,145,142
 dc.w 138,134,131,127,124,120,117,113,110,107
 dc.w 103,100, 97, 94, 91, 87, 84, 81, 78, 75
 dc.w  73, 70, 67, 64, 62, 59, 56, 54, 51, 49
 dc.w  47, 44, 42, 40, 38, 35, 33, 31, 30, 28
 dc.w  26, 24, 22, 21, 19, 18, 16, 15, 14, 12
 dc.w  11, 10,  9,  8,  7,  6,  5,  4,  4,  3
 dc.w   3,  2,  2,  1,  1,  1,  1,  1,  0
CopJmpEnd:
		
InitABPlanes
	move.l	SysPlaneA(a5),PlaneA(a5)
	move.l	SysPlaneB(a5),PlaneB(a5)
	move.l	SysPlaneC(a5),PlaneC(a5)
	rts

*-----------------------------------------
* Player control

ReadKbJoystick
	movem.l	d1/a1,-(sp)
	lea	KBMatrix(a5),a1
	moveq 	#0,d0
	moveq 	#0,d1
	move.b	(a0)+,d1
	tst.b 	(a1,d1.w)
	beq	.NoDown
	bset	#bitDown,d0
.NoDown	move.b	(a0)+,d1
	tst.b 	(a1,d1.w)
	beq	.NoRight
	bset	#bitRight,d0
.NoRight
	move.b	(a0)+,d1
	tst.b 	(a1,d1.w)
	beq	.NoUp
	bset	#bitUp,d0
.NoUp 	move.b	(a0)+,d1
	tst.b 	(a1,d1.w)
	beq	.NoLeft
	bset	#bitLeft,d0
.NoLeft	move.b	(a0)+,d1
	tst.b 	(a1,d1.w)
	beq	.NoFire
	bset	#bitFire,d0
.NoFire	movem.l	(sp)+,d1/a1
	rts

JoyRegs1 dc.w	$00a,$00c
JoyRegs2 dc.w	6,7

ReadNrmJoystick
	move.l	d1,-(sp)
	lea	$dff000,a0
	add.w 	d0,d0
	add.w 	JoyRegs1(pc,d0.w),a0
	move.w	JoyRegs2(pc,d0.w),-(sp)
	move.w	(a0),d0
	and.w 	#$303,d0
	move.w	d0,d1
	lsr.w 	d1
	eor.w 	d0,d1
	move.w	d1,d0
	and.w 	#$3,d0
	lsr.w 	#6,d1
	and.w 	#$c,d1
	or.w	d1,d0
	move.w	(sp)+,d1
	btst	d1,$bfe001
	bne	.NoFire
	bset	#bitFire,d0
.NoFire	move.l	(sp)+,d1
	rts

ReadParJoystickHi
	move.w	d1,-(sp)
	move.b	$bfe101,d1
	lsr.b 	#4,d1
	bsr	ReadParJoy
	btst	#0,$bfd000
	bne	.NoFire
	bset	#bitFire,d0
.NoFire	move.w	(sp)+,d1
	rts

ReadParJoystickLo
	move.w	d1,-(sp)
	move.b	$bfe101,d1
	bsr	ReadParJoy
	btst	#2,$bfd000
	bne	.NoFire
	bset	#bitFire,d0
.NoFire	move.w	(sp)+,d1
	rts

ReadParJoy
	moveq 	#0,d0
	btst	#3,d1
	bne.s 	.A
	bset	#bitRight,d0
.A 	btst	#2,d1
	bne.s 	.B
	bset	#bitLeft,d0
.B	btst	#1,d1
	bne.s 	.C
	bset	#bitDown,d0
.C 	btst	#0,d1
	bne.s 	.D
	bset	#bitUp,d0
.D 	rts

* PlayerDef=a1
* Read player control
ReadControl
	moveq 	#0,d0
	move.b	plControl(a1),d0
	lsl.w 	#2,d0
	jsr	.Control(pc,d0.w)
	move.b	d0,plJoystick(a1)
	rts

;	and.b 	#%11100000,plJoystick(a1)
;	or.b	d0,plJoystick(a1)
;	rts

.Control
	bra.w 	ReadJoy0
	bra.w 	ReadJoy1
	bra.w 	ReadParJoystickLo
	bra.w 	ReadParJoystickHi
	bra.w 	ReadKeyb

ReadJoy0
	moveq 	#0,d0
ReadJoy1x
	bsr	ReadNrmJoystick
	rts

ReadJoy1
	moveq 	#1,d0
	bra	ReadJoy1x

ReadKeyb
	lea	plKeyboard(a1),a0
	bsr	ReadKbJoystick
	rts

************************************** Copy Blocks with blitter

InitCopyBlock
	lea	$dff000,a6
.WBlt 	btst	#6,$2(a6)
	bne	.WBlt
	move.l	#$09f00000,$40(a6)
	move.l	#$ffffffff,$44(a6)
	move.w	#40*5-2,$64(a6)
	move.w	#42*5-2,$66(a6)
	rts

; blocknb=d0, dest.address=a1
CopyBlock
	lsl.w 	#2,d0
	lea	ObjectsAddress(a5),a0
	move.l	(a0,d0.w),a0
	move.w	#16<<6+1,d0
	move.w	#$8400,$96(a6)
.WBlt1	btst	#6,$2(a6)
	bne	.WBlt1
	movem.l	a0/a1,$50(a6)
	move.w	d0,$58(a6)
	lea	40(a0),a0
	lea	42(a1),a1
.WBlt2	btst	#6,$2(a6)
	bne	.WBlt2
	movem.l	a0/a1,$50(a6)
	move.w	d0,$58(a6)
	lea	40(a0),a0
	lea	42(a1),a1
.WBlt3	btst	#6,$2(a6)
	bne	.WBlt3
	movem.l	a0/a1,$50(a6)
	move.w	d0,$58(a6)
	lea	40(a0),a0
	lea	42(a1),a1
.WBlt4	btst	#6,$2(a6)
	bne	.WBlt4
	movem.l	a0/a1,$50(a6)
	move.w	d0,$58(a6)
	lea	40(a0),a0
	lea	42(a1),a1
.WBlt5	btst	#6,$2(a6)
	bne	.WBlt5
	movem.l	a0/a1,$50(a6)
	move.w	d0,$58(a6)
	move.w	#$400,$96(a6)
	rts

DrawArea
	bsr	InitCopyBlock
	sub.l 	a1,a1
	lea	AreaA(a5),a0
	moveq 	#AREAY-1,d1
.Loop1	moveq 	#0,d2
.Loop2	moveq 	#0,d0
	move.b	(a0)+,d0
	movem.l	d1/d2/a0/a1,-(sp)
	add.l 	PlaneA(a5),a1
	add.l 	d2,a1
	bsr	CopyBlock
	movem.l	(sp)+,d1/d2/a0/a1
	addq.w	#2,d2
	cmp.w 	#AREAX*2,d2
	blt	.Loop2
	add.l 	#42*5*16,a1
	dbf	d1,.Loop1
	move.l	PlaneA(a5),a0
	move.l	PlaneB(a5),a1
	move.l	PlaneC(a5),a2
	move.w	#(42*5*240)/4-1,d0
.Loop3	move.l	(a0),(a1)+
	move.l	(a0)+,(a2)+
	dbf	d0,.Loop3
	rts

InitAreas
	lea	AreaA(a5),a1
	move.l	AreaB1(a5),a2
	move.l	AreaB2(a5),a3
	move.w	#(AREAX*AREAY)-1,d0
.Loop 	moveq 	#blURES,d1
	move.b	(a1),d2
	beq	.A
	moveq 	#blFAL,d1
	subq.b	#1,d2
	beq	.A
	moveq 	#blTEGLA,d1
	subq.b	#1,d2
	beq	.A
	moveq 	#blKEMENY,d1
.A 	move.b	d1,(a1)+
	move.b	d1,(a2)+
	move.b	d1,(a3)+
	dbf	d0,.Loop
	rts

GenerateArea
	move.w	Brick(a5),d0
	bne	.B
	moveq	#5,d0
	bsr	Random
	addq.w	#1,d0
.B	add.w	#blCBRICKS,d0
	lsl.w	#2,d0
	lea	ObjectsAddress-4(a5),a0
	move.l	(a0,d0.w),a1
	move.l	blFAL*4+4(a0),a0
	moveq	#15,d0
.CLoop	move.w	0*40(a1),0*40(a0)	;Copy constant brick to the valid pos!
	move.w	1*40(a1),1*40(a0)
	move.w	2*40(a1),2*40(a0)
	move.w	3*40(a1),3*40(a0)
	move.w	4*40(a1),4*40(a0)
	add.w	#40*5,a0
	add.w	#40*5,a1
	dbf	d0,.CLoop
	move.w	LevelCode(a5),d0
	cmp.w	#lcRANDOM,d0
	bne	.A
	moveq	#lcRANDOM,d0
	bsr	Random
.A	move.w	d0,CrLevel(a5)
	lsl.w	#2,d0
	lea	AreasTab(pc),a0
	move.l	(a0,d0.w),a0
	lea	AreaA(a5),a1		;A mezok torlese!
	lea	Extras(a5),a2
	move.w	#AREAX*AREAY-1,d0
.Loop 	move.b	(a0)+,(a1)+
	move.b	#blURES,(a2)+
	dbf	d0,.Loop
	lea	AreaA(a5),a1
	moveq 	#16,d3			;A kemeny teglak szamlaloja!
	move.w	#AREAX*AREAY*8-1,d2
.Loop2	move.w	#AREAX*AREAY,d0		;A teglak elhelyezese!
	bsr	Random
	move.w	d0,d1
	tst.b 	(a1,d1.w)
	bne	.Loop3
	move.w	#3,d0
	bsr	Random
	addq.w	#2,d0
	cmp.b 	#3,d0
	blt	.Loop5
	tst.w 	d3
	beq	.Loop3
	subq.w	#1,d3
.Loop5	move.b	d0,(a1,d1.w)
.Loop3	dbf	d2,.Loop2

	lea	EmptyTB(pc),a0		;Azon helyek torlese hogy az 1. lepest
.Loop4	move.w	(a0)+,d0		;meglephessuk!!!!
	clr.b 	(a1,d0.w)
	tst.w 	(a0)
	bpl	.Loop4

* A keret megjelolese (-1) az ATOM BOMBA vegett!!
	lea	Extras(a5),a0
	moveq	#AREAX-1,d0
.Loop1	move.b	#exKERET,(AREAY-1)*AREAX(a0)
	move.b	#exKERET,(a0)+
	dbf	d0,.Loop1
	moveq	#AREAY-2,d0
.Loop11	move.b	#exKERET,AREAX-1(a0)
	move.b	#exKERET,(a0)
	add.w	#AREAX,a0
	dbf	d0,.Loop11

* Az ajandekok elhelyezese a jatek terben!
	lea	Extras(a5),a0
	lea	AjandekTB(pc),a1
	moveq	#ajnb-1,d3
.Loop6	moveq	#0,d2
	move.b	1(a1),d2
	beq	.ItemOff
.Loop7	move.w	#AREAX*AREAY,d0
	bsr	Random
	cmp.b	#exKERET,(a0,d0.w)
	beq	.Loop7
	cmp.b	#blURES,(a0,d0.w)
	bne	.Loop8
	move.b	(a1),(a0,d0.w)
.Loop8	subq.w	#1,d2
	bne	.Loop7
.ItemOff
	addq.w	#2,a1
	dbf	d3,.Loop6
	rts
	

MAXAJ	EQU	((AREAX-2)*(AREAY-2))
;		Ajandek code,	elofordulasi szam
AjandekTB
	dc.b	blRANDOM,	25
AjandekTBNoRandom
	dc.b	blCTRLSWAP,	10
	dc.b	blATOMBOMB,	3
	dc.b	blNIGHT,	3
	dc.b	blEXTRABOMB,	30
	dc.b	blPOWER,	25
	dc.b	blSUPERMAN,	5
	dc.b	blCONTROLER,	5
	dc.b	blPROTECTION,	10
	dc.b	blGHOST,	10
	dc.b	blPERSWAP,	10
	dc.b	blSPEED,	20
	dc.b	blSKULL,	15
	dc.b	blTIMEBOMB,	5
	dc.b	blSTOP,		10
	dc.b	blMONEY,	16
	dc.b	blICEMAN,	5
	dc.b	blTELEPORT,	10
	dc.b	blFIRSTAID,	5
	dc.b	blDETONATOR,	10
	dc.b	blPACMAN,	5
	dc.b	blMONEYBAG,	5
	dc.b	blLOPO,		5

ajnb 	equ	(*-AjandekTB)/2
	even

*	dc.b	blVORTEX,	(MAXAJ*4)/100
*	dc.b	blVIZARD,	(MAXAJ*4)/100
*	dc.b	blFOOTBALL,	(MAXAJ*4)/100
*	dc.b	blSQUEEZE,	(MAXAJ*4)/100
*	dc.b	blTENIS,	(MAXAJ*4)/100

EmptyTB
; Azon helyeknek a torlese hogy az elso lepest megtehessuk!
	dc.w	AREAX+1				;Player 1
	dc.w	AREAX+2
	dc.w	2*AREAX+1
	dc.w	AREAY*AREAX-1*AREAX-2		;PLayer 2
	dc.w	AREAY*AREAX-1*AREAX-3
	dc.w	AREAY*AREAX-2*AREAX-2
	dc.w	((AREAY/2)-1)*AREAX+AREAX/2-1 	;Player 3
	dc.w	AREAY/2*AREAX+AREAX/2-1
	dc.w	AREAY/2*AREAX+AREAX/2
	dc.w	AREAY/2*AREAX+AREAX/2+1
	dc.w	((AREAY/2)+1)*AREAX+AREAX/2+1
	dc.w	2*AREAX-2			;Player 4
	dc.w	2*AREAX-3
	dc.w	3*AREAX-2
	dc.w	(AREAY-2)*AREAX+1 		;Player 5
	dc.w	(AREAY-2)*AREAX+2
	dc.w	(AREAY-3)*AREAX+1
	dc.w	-1

InitTabels
	lea	ObjectsAddress(a5),a0
	move.l	ObjectsData(a5),d3
	moveq 	#0,d0
.Loop 	moveq 	#0,d1
.Loop2	move.w	d0,d2
	mulu	#40*5*16,d2
	add.l 	d1,d2
	add.l 	d1,d2
	add.l 	d3,d2
	move.l	d2,(a0)+
	addq.w	#1,d1
	cmp.w 	#20,d1
	blt	.Loop2
	addq.w	#1,d0
	cmp.w 	#6,d0
	blt	.Loop

InitBobOffsets
	lea	BobOffsets(a5),a0
	move.w	#0,d0
.Loop1	move.w	#0,d1
.Loop2	move.w	d0,d2
	mulu	#40*23,d2
	add.l 	d1,d2
	add.l 	d1,d2
	add.l 	d1,d2
	add.l 	d1,d2
	move.w	d2,(a0)+
	move.w	d0,d2
	mulu	#40*5*23,d2
	add.l 	d1,d2
	add.l 	d1,d2
	add.l 	d1,d2
	add.l 	d1,d2
	move.w	d2,(a0)+
	addq.w	#1,d1
	cmp.w 	#10,d1
	blt	.Loop2
	addq.w	#1,d0
	cmp.w 	#5*3,d0
	blt	.Loop1
	rts

InitGhostImage
	move.l	GhostImage(a5),a0
	move.l	BobData(a5),a1
	add.l	#46*40*5+4*4,a1
	lea	$dff000,a6
.WBlt	btst	#6,$2(a6)
	bne	.WBlt
	move.w	#24*5-24,$64(a6)
	move.w	#40*5-24,$66(a6)
	move.l	#$09f00000,$40(a6)
	move.l	#$ffffffff,$44(a6)
	move.w	#23<<6+12,d1
	moveq	#4,d2
.Loop	moveq	#4,d0
	movem.l	a0/a1,-(sp)
.Loop2	movem.l	a0/a1,$50(a6)
	move.w	d1,$58(a6)
	add.l	#24,a0
	add.l	#40,a1
.WBlt2	btst	#6,$2(a6)
	bne	.WBlt2
	dbf	d0,.Loop2
	movem.l	(sp)+,a0/a1
	add.l	#13800,a1
	dbf	d2,.Loop
	rts
		
MakeFigMasks
	lea	$dff000,a6
	move.w	#40*5-40,$64(a6)
	clr.w 	$62(a6)
	clr.w 	$66(a6)
	move.w	#0,$74(a6)
	move.l	#$1f000000,$40(a6)	
	move.l	#$ffffffff,$44(a6)
	move.w	#414<<6+20,d0
	move.l	BobMask(a5),a1
	move.l	a1,$54(a6)
	move.w	d0,$58(a6)		;Clear Mask memory!
.WBlt0	btst	#6,$2(a6)
	bne	.WBlt0
	move.l	BobData(a5),a0
	move.w	#$0dfc,$40(a6)
	bsr	.MakeMask
	bsr	.MakeMask
	bsr	.MakeMask
	bsr	.MakeMask
	bsr	.MakeMask
	rts

.MakeMask
	move.l	a1,$4c(a6)
	movem.l	a0/a1,$50(a6)
	move.w	d0,$58(a6)
	add.l 	#40,a0
.WBlt1	btst	#6,$2(a6)
	bne	.WBlt1
	rts

;bobptr=a0, imagenum=d0
SetBobImage
	move.l	a1,-(sp)
	lsl.w 	#2,d0
	lea	BobOffsets(a5),a1
	move.l	(a1,d0.w),bobImage(a0)
	move.l	(sp)+,a1
	rts

DrawAllBobs
	lea	$dff000,a6
.WBlt 	btst	#6,$2(a6)
	bne	.WBlt
	move.l	BobSaveA(a5),a4
	tst.b 	(a4)
	bmi	.NoBobBefore
	move.l	#$09f00000,$40(a6)
	move.l	#$ffffffff,$44(a6)
	move.w	#42-4-2,$64(a6)
	move.w	#42-4-2,$66(a6)
	move.l	PlaneC(a5),a0
	move.l	PlaneA(a5),a1
	move.l	a4,a2
.NextBob2
	move.l	(a2)+,d0
	move.l	d0,d1
	add.l 	a0,d0
	add.l 	a1,d1
.WBlt2	btst	#6,$2(a6)
	bne	.WBlt2
	movem.l	d0/d1,$50(a6)
	move.w	#(23*5)<<6+3,$58(a6)
	tst.b 	(a2)
	bpl	.NextBob2
.WBlt3	btst	#6,$2(a6)
	bne	.WBlt3
.NoBobBefore
	move.w	#42*5-4-2,$60(a6)
	move.w	#40*5-4-2,$62(a6)
	move.w	#40*1-4-2,$64(a6)
	move.w	#42*5-4-2,$66(a6)
	move.l	#$ffff0000,$44(a6)
	lea	NewBobs(a5),a3
	tst.b 	(a3)
	bmi	.NoNewBob
.NextBob
	move.l	(a3)+,a0
	bsr	BltDrawBob
	move.l	d0,(a4)+
.NotDrawn
	tst.b 	(a3)
	bpl	.NextBob
.NoNewBob
	st 	(a4)
	rts

;bobptr=a0
BltDrawBob
	movem.w	bobX(a0),d0-d1
	mulu	#42*5,d1
	moveq 	#$f,d2
	and.w 	d0,d2
	ror.w 	#4,d2
	lsr.w 	#4,d0
	add.w 	d0,d0
	ext.l 	d0
	add.l 	d1,d0
	move.l	PlaneA(a5),a2
	add.l 	d0,a2
	move.w	#$fca,d1
	btst	#bitPROTECTION,bobFlags+1(a0)
	beq	.NoProt
	move.w	#$bfa,d1
	bra	.WBlt
.NoProt	btst	#bitGHOST,bobFlags+1(a0)
	beq	.WBlt
	move.w	#$f8a,d1
.WBlt btst	#6,$2(a6)
	bne	.WBlt
	move.w	d2,$42(a6)
	or.w	d1,d2
	move.w	d2,$40(a6)
	moveq 	#0,d1
	moveq 	#0,d2
	move.w	bobImage+0(a0),d1
	move.w	bobImage+2(a0),d2
	btst	#bitPACMAN,bobFlags+1(a0)
	beq	.NoPm
	move.l	d1,a1
	move.l	d2,a0
	add.l	PacManData(a5),a0
	add.l	PacManMask(a5),a1
	bra	.DPm
.NoPm	move.l	d1,a1
	move.l	d2,a0
	add.l 	BobData(a5),a0
	add.l 	BobMask(a5),a1
.DPm	move.w	#23<<6+3,d1
.WBlt1	btst	#6,$2(a6)
	bne	.WBlt1
	move.l	a2,$48(a6)
	movem.l	a0-a2,$4c(a6)
	move.w	d1,$58(a6)
	lea	42(a2),a2
	lea	40(a0),a0
.WBlt2	btst	#6,$2(a6)
	bne	.WBlt2
	move.l	a2,$48(a6)
	movem.l	a0-a2,$4c(a6)
	move.w	d1,$58(a6)
	lea	42(a2),a2
	lea	40(a0),a0
.WBlt3	btst	#6,$2(a6)
	bne	.WBlt3
	move.l	a2,$48(a6)
	movem.l	a0-a2,$4c(a6)
	move.w	d1,$58(a6)
	lea	42(a2),a2
	lea	40(a0),a0
.WBlt4	btst	#6,$2(a6)
	bne	.WBlt4
	move.l	a2,$48(a6)
	movem.l	a0-a2,$4c(a6)
	move.w	d1,$58(a6)
	lea	42(a2),a2
	lea	40(a0),a0
.WBlt5	btst	#6,$2(a6)
	bne	.WBlt5
	move.l	a2,$48(a6)
	movem.l	a0-a2,$4c(a6)
	move.w	d1,$58(a6)
	rts

InitDrawBob
	lea	SaveBuf1(a5),a0
	lea	SaveBuf2(a5),a1
	move.l	a0,BobSaveA(a5)
	move.l	a1,BobSaveB(a5)
	st 	(a0)
	st 	(a1)
	st 	NewBobs(a5)
	pea	NewBobs(a5)
	move.l	(sp)+,NewBobPtr(a5)
	move.l	SysPlaneA(a5),PlaneA(a5)
	move.l	SysPlaneB(a5),PlaneB(a5)
	move.l	SysPlaneC(a5),PlaneC(a5)
	move.l	#42*5*16,d0
	add.l 	d0,PlaneA(a5)
	add.l 	d0,PlaneB(a5)
	add.l 	d0,PlaneC(a5)
;Init block spares
	st 	BlockSpare(a5)
	rts

AddBob	move.l	a1,-(sp)
	move.l	NewBobPtr(a5),a1
	addq.l	#4,NewBobPtr(a5)
	move.l	a0,(a1)+
	st 	(a1)
	move.l	(sp)+,a1
	rts

;-------------------------------------------
SetGameDefaults
	lea	DefPlNames(pc),a1
	lea	PlayersTB(a5),a2

	lea	Player1DEF(a5),a0
	move.l	a0,(a2)+
	bsr	SetPlName
	pea	BobPlayer1(a5)
	move.l	(sp)+,plBob(a0)
	move.b	#ctJoy0,plControl(a0)
	move.b	#1,plPlayerID(a0)
	bset	#bitSELECTED,plFlags+2(a0)
	move.b	#GyASTRO,plGuyImage(a0)
	add.w 	#plKeyboard,a0	;Keyboard control keys
	move.b	#$4d,(a0)+	;CURSOL DOWN
	move.b	#$4e,(a0)+	;CURSOL RIGHT
	move.b	#$4c,(a0)+	;CURSOL UP
	move.b	#$4f,(a0)+	;CUSROL LEFT
	move.b	#$61,(a0)	;RSHIFT

	lea	Player2DEF(a5),a0
	move.l	a0,(a2)+
	bsr	SetPlName
	pea	BobPlayer2(a5)
	move.l	(sp)+,plBob(a0)
	move.b	#ctJoy1,plControl(a0)
	move.b	#2,plPlayerID(a0)
	bset	#bitSELECTED,plFlags+2(a0)
	move.b	#GyBABY,plGuyImage(a0)
	add.w 	#plKeyboard,a0
	move.b	#$4d,(a0)+
	move.b	#$4e,(a0)+
	move.b	#$4c,(a0)+
	move.b	#$4f,(a0)+
	move.b	#$61,(a0)

	lea	Player3DEF(a5),a0
	move.l	a0,(a2)+
	bsr	SetPlName
	pea	BobPlayer3(a5)
	move.l	(sp)+,plBob(a0)
	move.b	#ctJoy2,plControl(a0)
	move.b	#3,plPlayerID(a0)
;	bset	#bitSELECTED,plFlags+2(a0)
	move.b	#GyBARTSIMPSON,plGuyImage(a0)
	add.w 	#plKeyboard,a0
	move.b	#$4d,(a0)+
	move.b	#$4e,(a0)+
	move.b	#$4c,(a0)+
	move.b	#$4f,(a0)+
	move.b	#$61,(a0)

	lea	Player4DEF(a5),a0
	move.l	a0,(a2)+
	bsr	SetPlName
	pea	BobPlayer4(a5)
	move.l	(sp)+,plBob(a0)
	move.b	#ctJoy3,plControl(a0)
	move.b	#4,plPlayerID(a0)
;	bset	#bitSELECTED,plFlags+2(a0)
	move.b	#GyCHINESE,plGuyImage(a0)
	add.w 	#plKeyboard,a0
	move.b	#$4d,(a0)+
	move.b	#$4e,(a0)+
	move.b	#$4c,(a0)+
	move.b	#$4f,(a0)+
	move.b	#$61,(a0)

	lea	Player5DEF(a5),a0
	move.l	a0,(a2)+
	bsr	SetPlName
	pea	BobPlayer5(a5)
	move.l	(sp)+,plBob(a0)
	move.b	#ctKeyb,plControl(a0)
	move.b	#5,plPlayerID(a0)
;	bset	#bitSELECTED,plFlags+2(a0)
	move.b	#GyCOOLGUY,plGuyImage(a0)
	add.w 	#plKeyboard,a0
	move.b	#$4d,(a0)+
	move.b	#$4e,(a0)+
	move.b	#$4c,(a0)+
	move.b	#$4f,(a0)+
	move.b	#$61,(a0)

	moveq 	#0,d0
	bset	#bitSHOP,d0
	bset	#bitSHRINKING,d0
	bset	#bitGAMBLING,d0
	bset	#bitTIMELIMIT,d0
	bset	#bitFASTIG,d0
	bset	#bitMUSICON,d0
	move.b	d0,GlobalFlags(a5)	;Sets global flags(shop,shrink,etc.)

	move.w	#3,WinsNeeded(a5)
	move.w	#0,StartMoney(a5)
	move.w	#0,TeamMode(a5)
	move.w	#0,GhostsNb(a5)
	move.w	#0,Brick(a5)
	move.w	#lcNORMAL,LevelCode(a5)

	rts

SetPlName
	move.l	a0,-(sp)
	add.l 	#plName,a0
.Loop 	move.b	(a1)+,(a0)+
	bne	.Loop
	move.l	(sp)+,a0
	rts

DefPlNames
	dc.b	"PLAYER1",0
	dc.b	"PLAYER2",0
	dc.b	"PLAYER3",0
	dc.b	"PLAYER4",0
	dc.b	"PLAYER5",0

SetPlayersStart
	lea	BobPlayer1(a5),a0
	move.w	#8,bobX(a0)
	move.w	#9,bobY(a0)
	clr.w 	bobFlags(a0)
	clr.w 	bobFazisHi(a0)
	clr.w 	bobASpeed(a0)
	moveq 	#0,d0
	bsr	SetBobImage

	lea	BobPlayer2(a5),a0
	move.w	#296,bobX(a0)
	move.w	#201,bobY(a0)
	clr.w 	bobFlags(a0)
	clr.w 	bobFazisHi(a0)
	clr.w 	bobASpeed(a0)
	moveq 	#30,d0
	bsr	SetBobImage

	lea	BobPlayer3(a5),a0
	move.w	#152,bobX(a0)
	move.w	#105,bobY(a0)
	clr.w 	bobFlags(a0)
	clr.w 	bobFazisHi(a0)
	clr.w 	bobASpeed(a0)
	moveq 	#60,d0
	bsr	SetBobImage

	lea	BobPlayer4(a5),a0
	move.w	#296,bobX(a0)
	move.w	#9,bobY(a0)
	clr.w 	bobFlags(a0)
	clr.w 	bobFazisHi(a0)
	clr.w 	bobASpeed(a0)
	moveq 	#90,d0
	bsr	SetBobImage

	lea	BobPlayer5(a5),a0
	move.w	#8,bobX(a0)
	move.w	#201,bobY(a0)
	clr.w 	bobFlags(a0)
	clr.w 	bobFazisHi(a0)
	clr.w 	bobASpeed(a0)
	moveq 	#120,d0
	bsr	SetBobImage
	rts

InitPlayersDEF
	lea	Player1DEF(a5),a0
	clr.w	plWinTime(a0)
	move.w	StartMoney(a5),plMoney(a0)
	lea	Player2DEF(a5),a0
	clr.w	plWinTime(a0)
	move.w	StartMoney(a5),plMoney(a0)
	lea	Player3DEF(a5),a0
	clr.w	plWinTime(a0)
	move.w	StartMoney(a5),plMoney(a0)
	lea	Player4DEF(a5),a0
	clr.w	plWinTime(a0)
	move.w	StartMoney(a5),plMoney(a0)
	lea	Player5DEF(a5),a0
	clr.w	plWinTime(a0)
	move.w	StartMoney(a5),plMoney(a0)
	rts

ReInitPlayersDEF
	bsr	SetPlayersStart
	lea	Player1DEF(a5),a0
	bsr	ClearPlVars
	move.w	#1,plBomb(a0)
	move.w	#1,plPower(a0)
	move.b	#DEFAULTBOMBTIME,plBombTime(a0)
	lea	Player2DEF(a5),a0
	bsr	ClearPlVars
	move.w	#1,plBomb(a0)
	move.w	#1,plPower(a0)
	move.b	#DEFAULTBOMBTIME,plBombTime(a0)
	lea	Player3DEF(a5),a0
	bsr	ClearPlVars
	move.w	#1,plBomb(a0)
	move.w	#1,plPower(a0)
	move.b	#DEFAULTBOMBTIME,plBombTime(a0)
	lea	Player4DEF(a5),a0
	bsr	ClearPlVars
	move.w	#1,plBomb(a0)
	move.w	#1,plPower(a0)
	move.b	#DEFAULTBOMBTIME,plBombTime(a0)
	lea	Player5DEF(a5),a0
	bsr	ClearPlVars
	move.w	#1,plBomb(a0)
	move.w	#1,plPower(a0)
	move.b	#DEFAULTBOMBTIME,plBombTime(a0)
	rts

ClearPlVars
	clr.w	plFlags(a0)
	lea	plVars(a0),a1
	moveq 	#plSIZEOF-plVars-1,d0
.Loop 	clr.b 	(a1)+
	dbf	d0,.Loop
	rts

WaitX
.Loop 	bsr	WaitBOF
	dbf	d0,.Loop
	rts

WaitBOF
.A	btst	#0,$dff005
	beq	.A
	cmp.b	#$2c,$dff006
	bne	.A
.B	cmp.b	#$2c,$dff006
	beq	.B
	rts

*********** A "zavaro tenyezok" rutinjai ********
InitEnemySprites
	move.l	Enemy1Data(a5),a0
	move.l	Enemy2Data(a5),a1
	bsr	CopyEData
	move.l	Enemy1Data(a5),a0
	move.l	Enemy3Data(a5),a1
	bsr	CopyEData
	move.l	Enemy1Data(a5),a0
	move.l	Enemy4Data(a5),a1
	bsr	CopyEData
	lea	Enemy1DEF(a5),a0
	move.l	Enemy1Data(a5),enSprite(a0)
	lea	Enemy2DEF(a5),a0
	move.l	Enemy2Data(a5),enSprite(a0)
	lea	Enemy3DEF(a5),a0
	move.l	Enemy3Data(a5),enSprite(a0)
	lea	Enemy4DEF(a5),a0
	move.l	Enemy4Data(a5),enSprite(a0)
	rts	

CopyEData
	move.w	#ENEMYDATASIZE/2-1,d0
.Loop	move.w	(a0)+,(a1)+
	dbf	d0,.Loop
	rts

ScNoWalls
ScNormal
	dc.w	7*16,5*16-6
	dc.w	(AREAX-7-1)*16,(AREAY-5-1)*16-6
	dc.w	(AREAX-7-1)*16,5*16-6
	dc.w	7*16,(AREAY-5-1)*16-6
	
ScMad	dc.w	6*16,5*16-6
	dc.w	(AREAX-6-1)*16,(AREAY-5-1)*16-6
	dc.w	(AREAX-6-1)*16,5*16-6
	dc.w	7*16,(AREAY-5-1)*16-6

ScCoords
	dc.l	ScNormal, ScMad, ScNoWalls

ReInitEnemyDEF
	move.w	CrLevel(a5),d0
	lsl.w	#2,d0
	move.l	ScCoords(pc,d0.w),a1
	lea	Enemy1DEF(a5),a0
	move.w	(a1)+,enX(a0)
	move.w	(a1)+,enY(a0)
	clr.b	enFlags(a0)
	clr.w	enFazis(a0)
	clr.w	enIData(a0)
	move.b	#edDown,enDirection(a0)
	clr.w	enDCount(a0)
	lea	Enemy2DEF(a5),a0
	move.w	(a1)+,enX(a0)
	move.w	(a1)+,enY(a0)
	clr.b	enFlags(a0)
	clr.w	enFazis(a0)
	clr.w	enIData(a0)
	move.b	#edRight,enDirection(a0)
	clr.w	enDCount(a0)
	lea	Enemy3DEF(a5),a0
	move.w	(a1)+,enX(a0)
	move.w	(a1)+,enY(a0)
	clr.b	enFlags(a0)
	clr.w	enFazis(a0)
	clr.w	enIData(a0)
	move.b	#edUp,enDirection(a0)
	clr.w	enDCount(a0)
	lea	Enemy4DEF(a5),a0
	move.w	(a1)+,enX(a0)
	move.w	(a1)+,enY(a0)
	clr.b	enFlags(a0)
	clr.w	enFazis(a0)
	clr.w	enIData(a0)
	move.b	#edLeft,enDirection(a0)
	clr.w	enDCount(a0)
	rts

* Enemy coords: d0=X, d1=Y
TestENCollosion
	move.l	a1,-(sp)
	moveq	#4,d4
	lea	PlayersTB(a5),a2
.Loop	move.l	(a2)+,a1
	btst	#bitSELECTED,plFlags+2(a1)
	beq	.Loop2
	btst	#bitKILLSEQ,plFlags+1(a1)
	bne	.Loop2
	btst	#bitGHOST,plFlags+1(a1)
	bne	.Loop2
	movem.w	d0/d1,-(sp)
	move.l	plBob(a1),a0
	moveq	#8,d2
	moveq	#7,d3
	add.w	bobX(a0),d2
	add.w	bobY(a0),d3
	cmp.w	d0,d2
	ble	.Loop3
	exg	d0,d2
.Loop3	cmp.w	d1,d3
	ble	.Loop4
	exg	d1,d3
.Loop4	add.w	#15,d2
	add.w	#15,d3
	cmp.w	d0,d2
	blt	.Loop5
	cmp.w	d1,d3
	blt	.Loop5
	clr.w	plIceCount(a1)
	bset	#bitDEAD,plFlags+1(a1)
	bne	.Loop5
	clr.b 	bobFazisLo(a0)
	clr.w 	bobASpeed(a0)
.Loop5	movem.w	(sp)+,d0/d1
.Loop2	dbf	d4,.Loop
	move.l	(sp)+,a1
	rts

MoveEnemys
	tst.w	GhostsNb(a5)
	beq	.Exit
	btst	#bitENEMYSTOP,GlobalFlags+1(a5)
	beq	.NoStop
	subq.w	#1,EStopCount(a5)
	bpl	.NoStop
	bclr	#bitENEMYSTOP,GlobalFlags+1(a5)
.NoStop	lea	Enemy1DEF(a5),a1
	btst	#bitENEMYKILLED,enFlags(a1)
	bne	.A
	bsr	MoveEnemy
.A	cmp.w	#1,GhostsNb(a5)
	beq	.Exit
	lea	Enemy2DEF(a5),a1
	btst	#bitENEMYKILLED,enFlags(a1)
	bne	.B
	bsr	MoveEnemy
.B	cmp.w	#2,GhostsNb(a5)
	beq	.Exit
	lea	Enemy3DEF(a5),a1
	btst	#bitENEMYKILLED,enFlags(a1)
	bne	.C
	bsr	MoveEnemy
.C	cmp.w	#3,GhostsNb(a5)
	beq	.Exit
	lea	Enemy4DEF(a5),a1
	btst	#bitENEMYKILLED,enFlags(a1)
	bne	.Exit
	bsr	MoveEnemy
.Exit	rts

MoveEnemy
	btst	#bitENEMYKSEQ,enFlags(a1)
	beq	EnNoKill
	subq.w	#1,enASpeed(a1)
	bpl	.ExitRTS
	move.w	#3,enASpeed(a1)
	move.w	enFazis(a1),d0
	addq.w	#1,enFazis(a1)
	move.b	.EnKillTB(pc,d0.w),d0
	bpl	SetIData
	bset	#bitENEMYKILLED,enFlags(a1)
	moveq	#6,d1
	move.w	enX(a1),d0
	add.w	enY(a1),d1
	bsr	GetACodeXY
	cmp.b	#blURES,(a2)
	bne	.ExitRTS
	move.b	#blMONEY,(a2)
.ExitRTS
	rts

.EnKillTB
	dc.b	12,13,14,15,16,17,18,19,20,-1
	even
SetIData
	ext.w	d0
	move.w	d0,enIData(a1)
	rts

EnemyDead
	bset	#bitENEMYKSEQ,enFlags(a1)
	clr.w	enFazis(a1)
	rts

EnNoKill
	moveq	#6,d1
	move.w	enX(a1),d0
	add.w	enY(a1),d1
	bsr	GetACodeXY
	cmp.b	#blEXPLODE+5,(a2)
	bls	EnemyDead
	bsr	TestENCollosion
	moveq	#0,d0
	move.b	enDirection(a1),d0
	lsl.w	#2,d0
	jmp	.MovTB(pc,d0.w)

.MovTB	bra.w	EnemyDown
	bra.w	EnemyRight
	bra.w	EnemyUp
	bra.w	EnemyLeft

EnemyDown
	moveq	#$f,d0
	moveq	#6,d1
	add.w	enY(a1),d1
	and.w	d1,d0
	bne	.Loop1
	move.w	enX(a1),d0
	bsr	GetACodeXY
	cmp.b	#blFAL,(a2)
	beq	EnemyDead
	cmp.b	#blFAL,AREAX(a2)
	beq	GetNewDirection
	subq.w	#1,enDCount(a1)
	bmi	GetNewDirection
.Loop1	btst	#bitENEMYSTOP,GlobalFlags+1(a5)
	bne	.Loop3
	addq.w	#1,enY(a1)
.Loop3	subq.w	#1,enASpeed(a1)
	bpl	.Loop4
	move.w	#7,enASpeed(a1)
	addq.w	#1,enFazis(a1)
.Loop4	move.w	enFazis(a1),d0
	move.b	.FrameTB(pc,d0.w),d0
	bpl	SetIData
	clr.w	enFazis(a1)
	move.b	.FrameTB(pc),d0
	bra	SetIData

.FrameTB
	dc.b	0,1,0,2,-1
	even

EnemyRight
	moveq	#$f,d1
	move.w	enX(a1),d0
	and.w	d0,d1
	bne	.Loop1
	moveq	#6,d1
	add.w	enY(a1),d1
	bsr	GetACodeXY
	cmp.b	#blFAL,(a2)
	beq	EnemyDead
	cmp.b	#blFAL,1(a2)
	beq	GetNewDirection
	subq.w	#1,enDCount(a1)
	bmi	GetNewDirection
.Loop1	btst	#bitENEMYSTOP,GlobalFlags+1(a5)
	bne	.Loop3
	addq.w	#1,enX(a1)
.Loop3	subq.w	#1,enASpeed(a1)
	bpl	.Loop4
	move.w	#7,enASpeed(a1)
	addq.w	#1,enFazis(a1)
.Loop4	move.w	enFazis(a1),d0
	move.b	.FrameTB(pc,d0.w),d0
	bpl	SetIData
	clr.w	enFazis(a1)
	move.b	.FrameTB(pc),d0
	bra	SetIData
.FrameTB
	dc.b	3,4,3,5,-1
	even

EnemyUp	moveq	#$f,d0
	moveq	#6,d1
	add.w	enY(a1),d1
	and.w	d1,d0
	bne	.Loop1
	move.w	enX(a1),d0
	bsr	GetACodeXY
	cmp.b	#blFAL,(a2)
	beq	EnemyDead
	cmp.b	#blFAL,-AREAX(a2)
	beq	GetNewDirection
	subq.w	#1,enDCount(a1)
	bmi	GetNewDirection
.Loop1	btst	#bitENEMYSTOP,GlobalFlags+1(a5)
	bne	.Loop3
	subq.w	#1,enY(a1)
.Loop3	subq.w	#1,enASpeed(a1)
	bpl	.Loop4
	move.w	#7,enASpeed(a1)
	addq.w	#1,enFazis(a1)
.Loop4	move.w	enFazis(a1),d0
	move.b	.FrameTB(pc,d0.w),d0
	bpl	SetIData
	clr.w	enFazis(a1)
	move.b	.FrameTB(pc),d0
	bra	SetIData
.FrameTB
	dc.b	6,7,6,8,-1
	even

EnemyLeft
	moveq	#$f,d1
	move.w	enX(a1),d0
	and.w	d0,d1
	bne	.Loop1
	moveq	#6,d1
	add.w	enY(a1),d1
	bsr	GetACodeXY
	cmp.b	#blFAL,(a2)
	beq	EnemyDead
	cmp.b	#blFAL,-1(a2)
	beq	GetNewDirection
	subq.w	#1,enDCount(a1)
	bmi	GetNewDirection
.Loop1	btst	#bitENEMYSTOP,GlobalFlags+1(a5)
	bne	.Loop3
	subq.w	#1,enX(a1)
.Loop3	subq.w	#1,enASpeed(a1)
	bpl	.Loop4
	move.w	#7,enASpeed(a1)
	addq.w	#1,enFazis(a1)
.Loop4	move.w	enFazis(a1),d0
	move.b	.FrameTB(pc,d0.w),d0
	bpl	SetIData
	clr.w	enFazis(a1)
	move.b	.FrameTB(pc),d0
	bra	SetIData
.FrameTB
	dc.b	9,10,9,11,-1
	even

GetNewDirection
	moveq	#MAXENEMYDCOUNT,d0
	bsr	Random
	addq.w	#1,d0
	move.w	d0,enDCount(a1)
.Loop	moveq	#4,d0
	bsr	Random
	move.b	d0,enDirection(a1)
	lsl.w	#2,d0
	jmp	.NdTB(pc,d0.w)

.NdTB	bra.w	.NdDown
	bra.w	.NdRight
	bra.w	.NdUp
	bra.w	.NdLeft

.NdDown	cmp.b	#blFAL,AREAX(a2)
	beq	.Loop
	rts

.NdRight
	cmp.b	#blFAL,1(a2)
	beq	.Loop
	rts

.NdUp	cmp.b	#blFAL,-AREAX(a2)
	beq	.Loop
	rts

.NdLeft	cmp.b	#blFAL,-1(a2)
	beq	.Loop
	rts
			
SetEnemySprites
	tst.w	GhostsNb(a5)
	beq	.Exit
	move.l	copSprites(a5),a0
	lea	Enemy1DEF(a5),a1
	bsr	SetSpriteREG
	cmp.w	#1,GhostsNb(a5)
	beq	.Exit
	lea	Enemy2DEF(a5),a1
	bsr	SetSpriteREG
	cmp.w	#2,GhostsNb(a5)
	beq	.Exit
	lea	Enemy3DEF(a5),a1
	bsr	SetSpriteREG
	cmp.w	#3,GhostsNb(a5)
	beq	.Exit
	lea	Enemy4DEF(a5),a1
	bsr	SetSpriteREG
.Exit	rts

SetSpriteREG
	move.w	enIData(a1),d0
	move.l	enSprite(a1),a2
	ext.w	d0
	mulu	#ENEMYSPRITESIZE,d0
	add.l	d0,a2
	move.w	enX(a1),d0
	move.w	enY(a1),d1
	add.w	#$70,d0
	add.w 	#$34,d1
	btst	#bitENEMYKILLED,enFlags(a1)
	beq	.D
	moveq	#0,d0
	moveq	#0,d1
.D	moveq	#0,d2
	move.b	d1,d2
	lsl.w	#8,d2
	ror.w	d0
	move.b	d0,d2
	swap	d2
	rol.w	d0
	move.b	d0,d2
	and.b	#$1,d2
 	btst 	#8,d1
	beq	.B
	bset	#2,d2
.B 	add.w 	#ENEMYHEIGHT,d1	;ENEMYHEIGHT=sprite HEIGHT!
	btst 	#8,d1
	beq	.C
	bset	#1,d2
.C 	lsl.w 	#8,d1
	or.w	d1,d2
	bset	#7,d2		;Detach sprites!
	move.l	d2,(a2)
	move.l	d2,SPRITE2OFFSET(a2)
	move.l	a2,d0
	move.w	d0,6(a0)
	swap	d0
	move.w	d0,2(a0)
	swap	d0
	addq.w	#8,a0
	add.l	#SPRITE2OFFSET,d0
.E	move.w	d0,6(a0)
	swap	d0
	move.w	d0,2(a0)
	addq.w	#8,a0
	rts

*******************************************************
* PLAYER<->PLAYER utkozes detektalasa (koordinata osszehasonlitas!)
PLPLCollosion
	lea	PlayersTB(a5),a1
	moveq	#4,d0
.Loop	move.l	(a1)+,a0
	btst	#bitSELECTED,plFlags+2(a0)
	beq	.Loop2
	clr.b	plColBits(a0)
	btst	#bitKILLSEQ,plFlags+1(a0)
	bne	.Loop2
	btst	#bitGHOST,plFlags+1(a0)
	bne	.Loop2
	bsr	TestCollosion
.Loop2	dbf	d0,.Loop
	rts

REG_Collosion	EQUR	d5

TestCollosion
	movem.l	d0/a1,-(sp)
	move.l	plBob(a0),a1
	moveq	#8,d0
	moveq	#1,d1
	add.w	bobX(a1),d0
	add.w	bobY(a1),d1
	moveq	#0,REG_Collosion
	moveq	#0,d4
	lea	PlayersTB(a5),a2
.Loop	move.l	(a2)+,a1
	cmp.l	a1,a0
	beq	.Loop2
	btst	#bitSELECTED,plFlags+2(a1)
	beq	.Loop2
	btst	#bitKILLSEQ,plFlags+1(a1)
	bne	.Loop2
	btst	#bitGHOST,plFlags+1(a1)
	bne	.Loop2
	movem.w	d0/d1,-(sp)
	move.l	plBob(a1),a1
	moveq	#8,d2
	moveq	#1,d3
	add.w	bobX(a1),d2
	add.w	bobY(a1),d3
	cmp.w	d0,d2
	ble	.Loop3
	exg	d0,d2
.Loop3	cmp.w	d1,d3
	ble	.Loop4
	exg	d1,d3
.Loop4	add.w	#15,d2
	add.w	#22,d3
	cmp.w	d0,d2
	blt	.Loop5
	cmp.w	d1,d3
	blt	.Loop5
	bset	d4,REG_Collosion
.Loop5	movem.w	(sp)+,d0/d1
.Loop2	addq.w	#1,d4
	cmp.w	#5,d4
	blo	.Loop
	move.b	REG_Collosion,plColBits(a0)
	movem.l	(sp)+,d0/a1
	rts

**************************************************************************		
MovePlayers
	lea	Player1DEF(a5),a1
	btst	#bitSELECTED,plFlags+2(a1)
	beq	.A
	bsr	PlayerControl
.A	lea	Player2DEF(a5),a1
	btst	#bitSELECTED,plFlags+2(a1)
	beq	.B
	bsr	PlayerControl
.B	lea	Player3DEF(a5),a1
	btst	#bitSELECTED,plFlags+2(a1)
	beq	.C
	bsr	PlayerControl
.C	lea	Player4DEF(a5),a1
	btst	#bitSELECTED,plFlags+2(a1)
	beq	.D
	bsr	PlayerControl
.D	lea	Player5DEF(a5),a1
	btst	#bitSELECTED,plFlags+2(a1)
	beq	.E
	bsr	PlayerControl
.E	rts

;Test for collosion with bricks (CF=1 if you can't go to that direction!)
Collosion
	ext.w 	d2
	add.w 	d2,d2
	move.w	.ColTab(pc,d2.w),d2
	jmp	.ColTab(pc,d2.w)

*		Jump offset		Code

.ColTab	rept	6-0
	dc.w	.CNop-.ColTab	;0-5 NOP
	endr
	rept	13-6
	dc.w	.CFal-.ColTab	;6-12
	endr
	rept	20-13
	dc.w	.CNop-.ColTab	;13-19
	endr
	rept	25-20
	dc.w	.CKofal-.ColTab	;20-24
	endr
	rept	29-25
	dc.w	.CNop-.ColTab	;25-28
	endr
	rept	34-29
	dc.w	.CFal-.ColTab	;29-33
	endr
	dc.w	.CBombA-.ColTab	;34
	dc.w	.CBombA-.ColTab	;35
	dc.w	.CBombA-.ColTab	;36
	dc.w	.CKofal-.ColTab	;37
	dc.w	.CFal-.ColTab	;38
	rept	85-39
	dc.w	.CNop-.ColTab	;39-84
	endr
	dc.w	.CBombB-.ColTab	;85
	dc.w	.CBombB-.ColTab	;86
	dc.w	.CBombB-.ColTab	;87
	rept	100-88
	dc.w	.CNop-.ColTab 		;88-100
	endr

.CNop 	clc
	rts

.CKofal	sec
	rts

.CFal	btst	#bitGHOST,plFlags+1(a1)
	bne	.CNop
	sec
	rts

.CBombA
	btst	#bitGHOST,plFlags+1(a1)
	bne	.CNop
	cmp.w	#1,TeamMode(a5)
	bne	.CKofal
	tst.b	plTeam(a1)
	bne	.CKofal
	bra	.CNop

.CBombB
	btst	#bitGHOST,plFlags+1(a1)
	bne	.CNop
	cmp.w	#1,TeamMode(a5)
	bne	.CKofal
	tst.b	plTeam(a1)
	beq	.CKofal
	bra	.CNop

GetACodeXY
	movem.w	d0/d1,-(sp)
	lea	AreaA(a5),a2
	lsr.w 	#4,d0
	lsr.w 	#4,d1
	mulu	#AREAX,d1
	add.w 	d1,d0
	add.w 	d0,a2
	movem.w	(sp)+,d0/d1
	rts

* AreaOffset=a2, PlayerBob=a0
SetPlayerAreaPos
	move.l	a2,d0
	divu	#AREAX,d0
	move.w	d0,d1
	swap	d0
	lsl.w	#4,d0
	lsl.w	#4,d1
	subq.w	#8,d0
	subq.w	#7,d1
	movem.w	d0/d1,bobX(a0)
	clr.b 	bobFazisLo(a0)
	rts

PlayerControl
	btst	#bitOUT,plFlags+1(a1)
	bne	.MExit
	clr.b	plJoystick(a1)
	btst	#bitKILLSEQ,plFlags+1(a1)
	bne	.A
	bsr	ReadControl
	cmp.w	#btFIREON,plBetegseg(a1)
	bne	.A
	bset	#bitFire,plJoystick(a1)
.A	move.l	plBob(a1),a0
	btst	#bitFREEZED,plFlags(a1)
	beq	.B
	bset	#bitPROTECTION,bobFlags+1(a0)
	subq.w	#1,plIceCount(a1)
	bpl	.B
	bclr	#bitFREEZED,plFlags(a1)
	btst	#bitPROTECTION,plFlags+1(a1)
	bne	.B
	bclr	#bitPROTECTION,bobFlags+1(a0)
.B	btst	#bitPACMAN,plFlags+1(a1)
	beq	.NoPm
	bsr	PacManNyam
	subq.w	#1,plPMCount(a1)
	bne	.PMLoop
	bclr	#bitPACMAN,plFlags+1(a1)
	bclr	#bitPACMAN,bobFlags+1(a0)
	bra	.NoPm
.PMLoop	cmp.w	#100,plPMCount(a1)
	bge	.NoPm
	moveq	#$7,d0
	and.w	plPMCount(a1),d0
	bne	.NoPm
	bchg	#bitPACMAN,bobFlags+1(a0)
.NoPm	bsr	PlayerMov
	bsr	PlayerFire
	bsr	PlayerAjandek
	bsr	PlayerBetegseg
	tst.w	plBetegseg(a1)
	beq	.DBob
	subq.w	#1,plBetCount(a1)
	bne	.Flash
	clr.w	plBetegseg(a1)
	bra	.DBob
.Flash	btst	#0,plBetCount+1(a1)
	beq	.MExit
.DBob	move.l	plBob(a1),a0
	bsr	AddBob
.MExit	rts

* A PacMan<->Jatekos detektalasa! (A pacman megette a jatekost!)
PacManNyam
	moveq	#8+8,d0
	moveq	#7+8,d1
	add.w	bobX(a0),d0
	add.w	bobY(a0),d1
	lea	PlayersTB(a5),a2
	moveq	#4,d4
.Loop	move.l	(a2)+,a3
	cmp.l	a1,a3
	beq	.Loop2
	btst	#bitSELECTED,plFlags+2(a3)
	beq	.Loop2
	btst	#bitKILLSEQ,plFlags+1(a3)
	bne	.Loop2
;	btst	#bitGHOST,plFlags+1(a3)
;	bne	.Loop2
	move.l	plBob(a3),a4
	moveq	#8,d2
	moveq	#7,d3
	add.w	bobX(a4),d2
	add.w	bobY(a4),d3
	cmp.w	d2,d0
	blt	.Loop2
	cmp.w	d3,d1
	blt	.Loop2
	add.w	#16,d2
	add.w	#16,d3
	cmp.w	d2,d0
	bgt	.Loop2
	cmp.w	d3,d1
	bgt	.Loop2
	clr.w	plIceCount(a3)
	bset	#bitDEAD,plFlags+1(a3)
	move.l	a3,-(sp)
	move.l	plBob(a3),a3
	clr.b 	bobFazisLo(a3)
	clr.w 	bobASpeed(a3)
	move.l	(sp)+,a3
.Loop2	dbf	d4,.Loop
	rts

PlayerBetegseg
	move.b	plColBits(a1),d0
	beq	.NoSwap
	and.b	plColMask(a1),d0
	cmp.b	plColBits(a1),d0
	beq	.Exit
	move.b	plColBits(a1),d1
	and.b	d1,plColMask(a1)
	move.b	plColMask(a1),d0
	or.b	d1,plColMask(a1)
	eor.b	d1,d0
	beq	.Exit
	moveq	#1,d3
	move.b	plPlayerID(a1),d1
	subq.b	#1,d1
	lsl.b	d1,d3
	bclr	#bitICEMAN,plFlags+1(a1)
	beq	.NoFreez
	move.b	d0,d1
	lea	PlayersTB(a5),a2
	moveq	#4,d2
.Loop1	move.l	(a2)+,a0
	lsr.b	d1
	bcc	.Loop12
	btst	#bitSELECTED,plFlags+2(a0)
	beq	.Loop12
	btst	#bitKILLSEQ,plFlags+1(a0)
	bne	.Loop12
	or.b	d3,plColMask(a0)
	bset	#bitFREEZED,plFlags(a0)
	move.w	#DEFAULTICETIME,plIceCount(a0)
.Loop12	dbf	d2,.Loop1
.NoFreez
	bclr	#bitTHIEF,plFlags+1(a1)
	beq	.NoThief
	move.b	d0,d1
	lea	PlayersTB(a5),a2
	moveq	#4,d2
.Loop21	move.l	(a2)+,a0
	lsr.b	d1
	bcc	.Loop22
	btst	#bitSELECTED,plFlags+2(a0)
	beq	.Loop22
	btst	#bitKILLSEQ,plFlags+1(a0)
	bne	.Loop22
	or.b	d3,plColMask(a0)
	move.w	plMoney(a0),d4
	clr.w	plMoney(a0)
	add.w	d4,plMoney(a1)
	MakeBankFx bfxTHIEF
.Loop22	dbf	d2,.Loop21
.NoThief
	tst.w	plBetegseg(a1)
	beq	.Exit
	cmp.w	#btPERSONSWAP,plBetegseg(a1)
	bne	.Fertozes
	movem.w	d0/d3,-(sp)
	bsr	PersonSwap
	movem.w	(sp)+,d0/d3
.Fertozes
	move.b	d0,d2
	lea	PlayersTB(a5),a2
	moveq	#4,d1
.Loop	move.l	(a2)+,a0
	lsr.b	d2
	bcc	.Loop2
	or.b	d3,plColMask(a0)
	move.w	plBetegseg(a1),plBetegseg(a0)
	move.w	#DEFAULTBETEGTIME,plBetCount(a0)
	MakeBankFx bfxDISEASES
.Loop2	dbf	d1,.Loop
.Exit	rts

.NoSwap	clr.b	plColMask(a1)
	rts
	
PersonSwap
	lea	PlayersTB(a5),a2
	moveq	#4,d1
.Loop	move.l	(a2)+,a0
	lsr.b	d0
	bcc	.Loop2
;	moveq	#plMoney,d2
;	bsr	SwapIt
	moveq	#plBombCount,d2
	bsr	SwapIt
	moveq	#plBombTime,d2
	bsr	SwapIt
	moveq	#plBomb,d2
	bsr	SwapIt
	moveq	#plPower,d2
	bsr	SwapIt
	moveq	#plSpeed,d2
	bsr	SwapIt
	moveq	#plCBOffset,d2
	bsr	SwapIt
	moveq	#plStopCount,d2
	bsr	SwapIt
	moveq	#plIceCount,d2
	bsr	SwapIt
	move.b	plFlags(a0),d2
	move.b	plFlags(a1),plFlags(a0)
	move.b	d2,plFlags(a1)
	move.b	plPlayerID(a0),d3
	move.b	plPlayerID(a1),d4
	lea	BombArea(a5),a3
	add.l 	#bcSIZEOF*AREAX,a3
	moveq 	#AREAX,d2
.DLoop 	moveq 	#$f,d5
	and.b 	bcPlayerID(a3),d5
	beq	.NextBomb
	cmp.b 	#6,d5
	bge	.NextBomb
	cmp.b	d3,d5
	beq	.SetToD4
	cmp.b	d4,d5
	bne	.NextBomb
	and.b	#$f0,bcPlayerID(a3)
	or.b	d3,bcPlayerID(a3)
	bra	.NextBomb
.SetToD4
	and.b	#$f0,bcPlayerID(a3)
	or.b	d4,bcPlayerID(a3)
.NextBomb
	addq.w	#bcSIZEOF,a3
	addq.w	#1,d2
	cmp.w 	#AREAX*AREAY-AREAX,d2
	blt	.DLoop
.Loop2	dbf	d1,.Loop
	rts

SwapIt	move.w	(a0,d2.w),d3
	move.w	(a1,d2.w),(a0,d2.w)
	move.w	d3,(a1,d2.w)
	rts
			
;playerdef=a1
PlayerFire
	btst	#bitFire,plJoystick(a1)
	beq	.Exit2
	btst	#bitKILLSEQ,plFlags+1(a1)
	bne	.Exit
	btst	#bitSTOP,plFlags(a1)
	bne	.Exit
	btst	#bitFREEZED,plFlags(a1)
	bne	.Exit
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.Exit
	cmp.w	#btNOBOMB,plBetegseg(a1)
	beq	.Exit
	move.l	plBob(a1),a0
	moveq 	#8+8,d0
	moveq 	#7+8,d1
	add.w 	bobX(a0),d0
	add.w 	bobY(a0),d1
	bsr	GetACodeXY
	btst	#bitCONTROLER,plFlags(a1)
	beq	.NoContrBomb
	tst.w 	plCBOffset(a1)
	bne	.Exit
	move.w	plBombCount(a1),d0
	cmp.w 	plBomb(a1),d0
	bge	.Exit
	cmp.b 	#blURES,(a2)
	bne	.Exit
	moveq	#blBOMBA,d0
	tst.w	TeamMode(a5)
	beq	.NoTm
	tst.b	plTeam(a1)
	beq	.NoTm
	moveq	#blBOMBB,d0
.NoTm	move.b	d0,(a2)
	pea	AreaA(a5)
	sub.l 	(sp)+,a2
	bclr	#bitGHOST,bobFlags+1(a0)
	bclr	#bitGHOST,plFlags+1(a1)
	beq	.NoGH
	bsr	SetPlayerAreaPos
.NoGH	move.w	a2,plCBOffset(a1)
	bra	.Exit

.NoContrBomb
	cmp.b 	#blURES,(a2)
	bne	.Exit
	move.w	plBombCount(a1),d0
	cmp.w 	plBomb(a1),d0
	bge	.Exit
.SetNewBomb
	addq.w	#1,plBombCount(a1)
	pea	AreaA(a5)
	sub.l 	(sp)+,a2
	bclr	#bitGHOST,bobFlags+1(a0)
	bclr	#bitGHOST,plFlags+1(a1)
	beq	.NoGH2
	bsr	SetPlayerAreaPos
.NoGH2	moveq 	#anBOMBA,d0
	tst.w	TeamMode(a5)
	beq	.NoTm2
	tst.b	plTeam(a1)
	beq	.NoTm2
	moveq	#anBOMBB,d0
.NoTm2	move.w	a2,d1
	bsr	InsertAnimation
	lea	BombArea(a5),a0
	add.w 	d1,d1
	add.w 	d1,a0
	move.b	plPlayerID(a1),bcPlayerID(a0)
	move.b	plBombTime(a1),bcCount(a0)
	bclr	#bitATOMBOMB,plFlags(a1)
	beq	.NoATM
	bset	#bitATOMBOMB,bcPlayerID(a0)
	bra	.Exit

.NoATM	btst	#bitCONTROLER,plFlags(a1)
	beq	.SetNrm
	btst	#bitFASTIG,GlobalFlags(a5)
	bne	.SetTimeB
.SetNrm	btst	#bitTIMEBOMB,plFlags(a1)
	beq	.Exit
.SetTimeB
	bset	#bitTIMEBOMB,bcPlayerID(a0)
	move.b	#$ff,bcCount(a0)	;LONG TIME BOMB!
.Exit 	rts

.Exit2	btst	#bitCONTROLER,plFlags(a1)
	beq	.Exit
	lea	AreaA(a5),a2
	add.w 	plCBOffset(a1),a2
	moveq	#blBOMBA,d0
	tst.w	TeamMode(a5)
	beq	.NoTm3
	tst.b	plTeam(a1)
	beq	.NoTm3
	moveq	#blBOMBB,d0
.NoTm3	cmp.b 	(a2),d0
	bne	.NoBomb
	clr.w 	plCBOffset(a1)
	bra	.SetNewBomb

.NoBomb	moveq	#blBOMBAUD,d0
	moveq	#blBOMBALR+6,d1
	tst.w	TeamMode(a5)
	beq	.NoTm4
	tst.b	plTeam(a1)
	beq	.NoTm4
	moveq	#blBOMBBUD,d0
	moveq	#blBOMBBLR+6,d1
.NoTm4	cmp.b 	(a2),d1
	bls	.ClrCB
	cmp.b 	(a2),d0
	bls	.Exit
.ClrCB	clr.w 	plCBOffset(a1)
	bra	.Exit

PlayerAjandek
	btst	#bitKILLSEQ,plFlags+1(a1)
	bne	.Exit
	btst	#bitGHOST,plFlags+1(a1)
	beq	.GetAJ
.Exit	rts

.GetAJ	move.l	plBob(a1),a0
	moveq 	#8+8,d0
	moveq 	#7+8,d1
	add.w 	bobX(a0),d0
	add.w 	bobY(a0),d1
	bsr	GetACodeXY
	move.b	(a2),d0
NewAJ 	ext.w 	d0
	add.w 	d0,d0
	move.w	AJTab(pc,d0.w),d0
	jmp	AJTab(pc,d0.w)

AJTab	rept	6-0
 	dc.w	.CExpl-AJTab	;0-5
 	endr
	rept	14-6
 	dc.w	.CDead-AJTab	;6-13
 	endr
	dc.w	.CNop-AJTab	;14 	
	dc.w	.CNop-AJTab	;15 	
	dc.w	.CNop-AJTab	;16 	
	dc.w	.CNop-AJTab	;17
	dc.w	.CNop-AJTab	;18
	dc.w	.CNop-AJTab	;19
	rept	25-20
	dc.w	.CDead-AJTab	;20-24
	endr
	dc.w	.CVortex-AJTab	;25
	dc.w	.CCtrlSwap-AJTab ;26
	dc.w	.CAtom-AJTab	;27
	dc.w	.CNight-AJTab	;28
	rept	34-29
	dc.w	.CDead-AJTab	;29-33
	endr
	dc.w	.CBombA-AJTab	;34	
	dc.w	.CBombA-AJTab	;35	
	dc.w	.CBombA-AJTab	;36
	dc.w	.CDead-AJTab	;37
	dc.w	.CDead-AJTab	;38
	dc.w	.CBomb-AJTab	;39
	dc.w	.CPower-AJTab	;40
	dc.w	.CSuperMan-AJTab ;41
	dc.w	.CControler-AJTab ;42
	dc.w	.CProtection-AJTab ;43
	dc.w	.CGhost-AJTab	;44
	dc.w	.CPersonSwapper-AJTab ;45
	dc.w	.CSpeed-AJTab	;46
	dc.w	.CSkull-AJTab	;47
	dc.w	.CRandom-AJTab	;48
	dc.w	.CTimeBomb-AJTab ;49
	dc.w	.CStop-AJTab	;50
	dc.w	.CMoney-AJTab	;51
	rept	66-52
	dc.w	.CNop-AJTab	;52-65
	endr
	dc.w	.CIcer-AJTab	;66
	dc.w	.CTeleport-AJTab ;67
	dc.w	.CVizard-AJTab	;68
	dc.w	.CFirstAid-AJTab ;69
	dc.w	.CDetonator-AJTab ;70
	dc.w	.CNop-AJTab	;71
	dc.w	.CFootball-AJTab ;72
	dc.w	.CPacMan-AJTab	;73
	dc.w	.CSqueeze-AJTab	;74
	dc.w	.CTenis-AJTab	;75
	dc.w	.CMoneyBag-AJTab ;76
	dc.w	.CLopo-AJTab	;77
	rept	85-78
	dc.w	.CNop-AJTab	;78-84
	endr
	dc.w	.CBombB-AJTab	;85
	dc.w	.CBombB-AJTab	;86
	dc.w	.CBombB-AJTab	;87
	rept	100-88
	dc.w	.CNop-AJTab	;88-99
	endr

.CBombB
.CBombA	btst	#bitPACMAN,plFlags+1(a1)
	beq	.CNop
	move.b	#blURES,(a2)
	pea	AreaA(a5)
	sub.l	(sp)+,a2
	move.w	a2,d1
	add.w	d1,d1		;bcSIZEOF=2
	lea	BombArea(a5),a0
	add.w	d1,a0
	moveq	#$f,d0
	and.b	bcPlayerID(a0),d0
	beq	.CNop
	clr.b	bcPlayerID(a0)
	lsl.w	#2,d0
	lea	PlayersTB-4(a5),a0
	move.l	(a0,d0.w),a0
	subq.w	#1,plBombCount(a0)
	lea	AnimationsTab(a5),a0
	lsl.w 	#2,d1 		;anSIZEOF=4!!!!
;	mulu	#anSIZEOF,d1
	move.w	#-1,anType(a0)
	rts

.CExpl	btst	#bitFREEZED,plFlags(a1)
	bne	.CNop

.CSkull
.CDead	clr.w	plIceCount(a1)
	bset	#bitDEAD,plFlags+1(a1)
	bne	.CNop
	clr.b 	bobFazisLo(a0)
	clr.w 	bobASpeed(a0)
.CNop 	rts

.CBomb	addq.w	#1,plBomb(a1)
	bclr	#bitTIMEBOMB,plFlags(a1)
	bclr	#bitCONTROLER,plFlags(a1)
	bra	.CDelete

.CPower	addq.w	#1,plPower(a1)
	bra	.CDelete

.CSuperman
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.CDelete
	bset	#bitSUPERMAN,plFlags(a1)
	bra	.CDelete

.CProtection
	bset	#bitPROTECTION,plFlags+1(a1)
	bset	#bitPROTECTION,bobFlags+1(a0)
	bclr	#bitDEAD,plFlags+1(a1)
	move.w	#DEFAULTPROTTIME,plProtCount(a1)
	move.b	#blURES,(a2)
	MakeBankFx bfxPROTECTION
	rts

.CGhost	btst	#bitPACMAN,plFlags+1(a1)
	bne	.CDelete
	bclr	#bitPROTECTION,plFlags+1(a1)
	bclr	#bitPROTECTION,bobFlags+1(a0)
	bclr	#bitDEAD,plFlags+1(a1)
	bset	#bitGHOST,plFlags+1(a1)
	move.b	#blURES,(a2)
	MakeA1Fx GhostFx
	rts

.CSpeed	cmp.w	#8,plSpeed(a1)
	bge	.R
	addq.w	#1,plSpeed(a1)
.R	move.b	#blURES,(a2)
	MakeBankFx bfxGO
	rts

.CTimeBomb
	btst	#bitFASTIG,GlobalFlags(a5)
	beq	.NoTB
	bclr	#bitCONTROLER,plFlags(a1)
.NoTB	bset	#bitTIMEBOMB,plFlags(a1)
	sub.b 	#10,plBombTime(a1)
	cmp.b	#30,plBombTime(a1)
	bhs	.A
	move.b	#30,plBombTime(a1)
.A 	move.b	#blURES,(a2)
	MakeA1Fx TimeBFx
	rts

.CStop	move.b	#blURES,(a2)
	lea	PlayersTB(a5),a2
	move.b	plTeam(a1),d1
	moveq 	#4,d0
.Loop 	move.l	(a2)+,a0
	cmp.l 	a1,a0
	beq	.CStp2
	tst.w	TeamMode(a5)
	beq	.CStp3
	cmp.b	plTeam(a0),d1
	beq	.CStp2
.CStp3	bset	#bitSTOP,plFlags(a0)
	move.w	#DEFAULTSTOPTIME,plStopCount(a0)
.CStp2	dbf	d0,.Loop
	move.w	#DEFAULTSTOPTIME,EStopCount(a5)
	bset	#bitENEMYSTOP,GlobalFlags+1(a5)
	MakeA1Fx LezerFx
	rts

.CMoney	addq.w	#1,plMoney(a1)
	move.b	#blURES,(a2)
	MakeA1Fx MoneyFx
	rts

.CControler
	btst	#bitFASTIG,GlobalFlags(a5)
	beq	.NoTB2
	bclr	#bitTIMEBOMB,plFlags(a1)
.NoTB2	bset	#bitCONTROLER,plFlags(a1)
.CDelete
	move.b	#blURES,(a2)
	MakeA1Fx ExtroFx
	rts

.CRandom
	moveq 	#ajnb-1+MAXBETEGSEG,d0
	bsr	Random
	cmp.w	#ajnb-1,d0
	bhs	.Betegseg
	lea	AjandekTBNoRandom(pc),a3
	add.w	d0,d0
	add.w	d0,a3
	move.b	(a3)+,d0
	tst.b	(a3)
	beq	.CRandom
	bra	NewAJ

.Betegseg
	move.w	#DEFAULTBETEGTIME,plBetCount(a1)
	sub.w	#ajnb-1,d0
	move.w	d0,plBetegseg(a1)
	move.b	#blURES,(a2)
	MakeBankFx bfxDISEASES
	rts
	
.CNight	move.w	#DEFAULTNIGHTTIME,NightCount(a5)
	bset	#bitNIGHT,GlobalFlags+1(a5)
	bne	.NoFade
	move.w	#DEFAULTNIGHTDEPTH,FadeCount(a5)
.NoFade	bra	.CDelete

.CCtrlSwap
	move.b	#blURES,(a2)
	lea	PlayersTB(a5),a2
	move.b	plTeam(a1),d1
	moveq 	#4,d0
.CLoop 	move.l	(a2)+,a0
	cmp.l 	a1,a0
	beq	.CTtp2
	tst.w	TeamMode(a5)
	beq	.CTtp3
	cmp.b	plTeam(a0),d1
	beq	.CTtp2
.CTtp3	bset	#bitCTRLSWAP,plFlags(a0)
	move.w	#DEFAULTCTRLSWAPTIME,plCSwapCount(a0)
.CTtp2	dbf	d0,.CLoop
	MakeA1Fx LezerFx
	rts

.CTeleport
	move.b	#blURES,(a2)
	lea	AreaA(a5),a2
.TLoop	move.w	#AREAX*AREAY,d0
	bsr	Random
	cmp.b	#blURES,(a2,d0.w)
	bne	.TLoop
	move.w	d0,a2
	bsr	SetPlayerAreaPos
	MakeA1Fx TeleportFx
	rts

.CMoneyBag
	bclr	#bitCONTROLER,plFlags(a1)
	bclr	#bitTIMEBOMB,plFlags(a1)
	bclr	#bitSUPERMAN,plFlags(a1)
	move.w	#1,plBomb(a1)
	move.w	#1,plPower(a1)
	move.w	#0,plSpeed(a1)
	move.w	#8,plMoney(a1)
	move.b	#DEFAULTBOMBTIME,plBombTime(a1)
	bra	.CDelete
	
.CVortex
.CVizard
.CFootball
.CSqueeze
.CTenis
	bra	.CDelete

.CLopo	bset	#bitTHIEF,plFlags+1(a1)
	MakeBankFx bfxTHIEF
	move.b	#blURES,(a2)
	rts

.CIcer	bset	#bitICEMAN,plFlags+1(a1)
	bra	.CDelete

.CFirstAid
	clr.w	plBetegseg(a1)
	bra	.CDelete

.CPersonSwapper
	move.w	#btPERSONSWAP,plBetegseg(a1)
	move.w	#DEFAULTBETEGTIME,plBetCount(a1)
	bra	.CDelete

.CAtom	bset	#bitATOMBOMB,plFlags(a1)
	move.b	#blURES,(a2)
	MakeBankFx bfxATOMBOMB
	rts

.CPacMan
	bclr	#bitSUPERMAN,plFlags(a1)
	bclr	#bitTIMEBOMB,plFlags(a1)
	bclr	#bitCONTROLER,plFlags(a1)
	bset	#bitPACMAN,plFlags+1(a1)
	bset	#bitPACMAN,bobFlags+1(a0)
	move.w	#DEFAULTPACMANTIME,plPMCount(a1)
	bra	.CDelete

.CDetonator
	lea	BombArea(a5),a0
	add.l 	#bcSIZEOF*AREAX,a0
	moveq 	#AREAX,d2
.DLoop 	moveq 	#$f,d0
	and.b 	bcPlayerID(a0),d0
	beq	.NextBomb
	cmp.b 	#6,d0
	bge	.NextBomb
	bclr	#bitTIMEBOMB,bcPlayerID(a0)
	move.b	#1,bcCount(a0)
.NextBomb
	addq.w	#bcSIZEOF,a0
	addq.w	#1,d2
	cmp.w 	#AREAX*AREAY-AREAX,d2
	blt	.DLoop
	bra	.CDelete
		
; -----------------------------

SuperMan
	move.l	a2,-(sp)
	btst	#bitSUPERMAN,plFlags(a1)
	beq	NoSuper
	add.w 	d1,a2
	cmp.b 	#blTEGLA,(a2)
	bne	NoSuper
	add.w 	d1,a2
	cmp.b 	#blURES,(a2)
	bne	NoSuper
	sub.w 	d1,a2
	move.l	a2,d1
	pea	AreaA(a5)
	sub.l 	(sp)+,d1
YeSuper	move.l	(sp)+,a2
	clc
	rts

NoSuper	move.l	(sp)+,a2
	sec
	rts

TPacMan	move.l	a2,-(sp)
	add.w	d1,a2
	move.l	a2,d1
	pea	AreaA(a5)
	sub.l	(sp)+,d1
	move.b	(a2),d0
	cmp.b	#blFAL,d0
	beq	NoSuper
	cmp.b	#blTEGLA,d0
	beq	.pmTegla
	cmp.b	#blKEMENY,d0
	blo	NoSuper
	cmp.b	#blKEMENY+2,d0
	bhs	NoSuper
	addq.b	#1,(a2)
	cmp.b	#blKEMENY+2,(a2)
	beq	.pmKemeny
	bra	YeSuper

.pmKemeny
	moveq 	#anKEMENY,d0
	bsr	InsertAnimation
	bra	YeSuper

.pmTegla
	moveq 	#anTEGLA,d0
	bsr	InsertAnimation
	bra	YeSuper

; playerdef=a1
PlayerMov
	move.l	plBob(a1),a0
	btst	#bitDEAD,plFlags+1(a1)
	beq	.NoDead
	btst	#bitPROTECTION,plFlags+1(a1)
	beq	.Dead
	bchg	#bitPROTECTION,bobFlags+1(a0)
	subq.w	#1,plProtCount(a1)
	bne	.NoDead
	bclr	#bitPROTECTION,plFlags+1(a1)
	bclr	#bitPROTECTION,bobFlags+1(a0)
	bclr	#bitDEAD,plFlags+1(a1)
	bra	.NoDead

.Dead	bset	#bitKILLSEQ,plFlags+1(a1)
	bne	.NotFirst
;	clr.b	plJoystick(a1)
;	clr.w	plBetegseg(a1)
	MakeBankFx bfxDEAD
.NotFirst
	subq.w	#1,bobASpeed(a0)
	bpl	.Exit
	move.w	#2,bobASpeed(a0)
	moveq	#0,d0
 	moveq 	#0,d1
	addq.b	#1,bobFazisLo(a0)
	move.b	bobFazisLo(a0),d1
	lea	.DeadAT(pc),a2
	move.b	(a2,d1.w),d0
	bpl	.AnimOk
	clr.b 	bobFazisLo(a0)
	bset	#bitOUT,plFlags+1(a1)
	moveq 	#8+8,d0
	moveq 	#7+8,d1
	add.w 	bobX(a0),d0
	add.w 	bobY(a0),d1
	bsr	GetACodeXY
	cmp.b	#blURES,(a2)
	bne	.Exit
	move.b	#blMONEY,(a2)
	bra	.Exit
.AnimOk	move.b	plPlayerID(a1),d1
	lea	BAFNull-1(pc),a2
	move.b	(a2,d1.w),d1
	btst	#bitPACMAN,bobFlags+1(a0)
	beq	.NoPM
	moveq	#0,d1
.NoPM	add.w 	d1,d0
	bsr	SetBobImage
	rts

.DeadAT	dc.b	15,16,17,18,19,20,21,22,23,-1
	even

.NoDead	btst	#bitSTOP,plFlags(a1)
	bne	.ItsSTOP
	btst	#bitFREEZED,plFlags(a1)
	bne	.Exit
	move.b	plJoystick(a1),d0
	lea	.NormalMove(pc),a2
	btst	#bitCTRLSWAP,plFlags(a1)
	beq	.NoSwap
	lea	.SwapMove(pc),a2
	subq.w	#1,plCSwapCount(a1)
	bne	.NoSwap
	bclr	#bitCTRLSWAP,plFlags(a1)
.NoSwap	lsr.b 	d0
	bcs	.MoveJ
	addq.w	#4,a2
	lsr.b 	d0
	bcs	.MoveJ
	addq.w	#4,a2
	lsr.b 	d0
	bcs	.MoveJ
	addq.w	#4,a2
	lsr.b 	d0
	bcs	.MoveJ
	bra	SetZeroPosition

.MoveJ	jmp	(a2)

.NormalMove
	bra.w	MoveDown
	bra.w	MoveRight
	bra.w	MoveUp
	bra.w	MoveLeft

.SwapMove
	bra.w	MoveUp
	bra.w	MoveLeft
	bra.w	MoveDown
	bra.w	MoveRight

.ItsSTOP
	lea	.ATStop(pc),a2
	moveq 	#2,d1
	bsr	SetBobAnim2
	subq.w	#1,plStopCount(a1)
	bne	.Exit
	bclr	#bitSTOP,plFlags(a1)
.Exit 	rts

.ATStop	dc.b	0,3,9,6,-1
.PMStop	dc.b	0,3,9,6,-1
	even

SetZeroPosition
	btst	#bitCONTROLER,plFlags(a1)
	beq	.NoCont
	btst	#bitFire,plJoystick(a1)
	beq	.NoCont
	lea	.ATControler(pc),a2
	bra	.SetCBob

.NoCont	btst	#bitPACMAN,bobFlags+1(a0)
	bne	.NoGhost
	btst	#bitGHOST,plFlags+1(a1)
	beq	.NoGhost
	btst	#bitGHOST,bobFlags+1(a0)
	bne	.NoGhost
.SetCBob
	bsr	SetBobAnim
	rts

.NoGhost
	clr.w 	bobASpeed(a0)
	clr.b 	bobFazisLo(a0)
	move.b	bobFazisHi(a0),d0
	ext.w 	d0
	move.b	.ANull(pc,d0.w),d0
	moveq 	#0,d1
	move.b	plPlayerID(a1),d1
	move.b	.AFNull-1(pc,d1.w),d1
	btst	#bitPACMAN,bobFlags+1(a0)
	beq	.NoPm
	moveq	#0,d1
.NoPm	add.w 	d1,d0
	bsr	SetBobImage
	rts

.AFNull	dc.b	0,30,60,90,120
.ANull	dc.b	0,3,9,6,21

.AtControler
	dc.b	12,13,12,14,-1
	even

;************************************** Egy jatekos mozgatasa!

REG_Speed	equr	d7

;**
;** Move down!
;**
MoveDown
	btst	#bitCONTROLER,plFlags(a1)
	beq	.ManDown
	btst	#bitFire,plJoystick(a1)
	beq	.ManDown
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.ManDown
	lea	AreaA(a5),a2
	move.w	plCBOffset(a1),d1
	add.w	d1,a2
	moveq	#blBOMBA,d0
	moveq	#anBOMBAM1,d2
	moveq	#anBOMBAM2,d3
	tst.w	TeamMode(a5)
	beq	.NoTm
	tst.b	plTeam(a1)
	beq	.NoTm
	moveq	#blBOMBB,d0
	moveq	#anBOMBBM1,d2
	moveq	#anBOMBBM2,d3
.NoTm	cmp.b 	(a2),d0
	bne	SetZeroPosition
	cmp.b 	#blURES,AREAX(a2)
	bne	SetZeroPosition
	add.w 	#AREAX,plCBOffset(a1)
	move.w 	d2,d0
	bsr	InsertAnimation
	add.w 	#AREAX,d1
	move.w 	d3,d0
	bsr	InsertAnimation
	MakeA1Fx ControlerFx
	bra	SetZeroPosition

.ManDown
	move.b	#0,bobFazisHi(a0)
	bsr	GetSpeedParam
	move.w	d0,REG_Speed
	moveq 	#8,d0
	moveq 	#7,d1
	add.w 	bobX(a0),d0
	add.w 	bobY(a0),d1
	bsr	GetACodeXY
	moveq	#$f,d4
	and.w	d0,d4
	bne	.DA
;Ha DX=0 (Benne vagyunk a folyosoban!)
	moveq	#$f,d4
	and.w	d1,d4
	beq	.DSuperMan
	add.w	REG_Speed,d4
	cmp.w	#$10,d4		;Uj kocka ?
	blt	.MDown3		;Meg nem!
	move.b	2*AREAX(a2),d2
	bsr	Collosion
	bcc	.MDown3
.DMaxMelle
	sub.w	#$10,d4
	move.w	REG_Speed,d2
	sub.w	d4,d2
	add.w	d2,bobY(a0)	;Egesszen az akadaly melle lepunk!
	bra	SetZeroPosition

;Ha DX<>0 (A folyoso szelen vagyunk!)
.DA	moveq	#$f,d4
	and.w	d1,d4
	beq	.DD
	add.w	REG_Speed,d4
	cmp.w	#$10,d4		;Uj kocka ?
	blt	.MDown3		;Meg nem!
	and.w	#$f,d1
	beq	.DD
	add.w	#AREAX,a2
.DD	move.b	AREAX+1(a2),d2
	bsr	Collosion
	scs	d3
	move.b	AREAX+0(a2),d2
	bsr	Collosion
	scs	d2
	and.w	#$f,d1
	beq	.DLeftRight
	or.b	d2,d3
	bne	.DMaxMelle
	bra	.MDown3

.DLeftRight	
	tst.b	d2
	bne	.DRight
	tst.b	d3
	beq	.MDown3		;Mind a ket alattunk levo kocka ures -) lefele!
	move.w	d0,d4
	move.w	REG_Speed,d5
	and.w	#$f,d4
	sub.w	d5,d4		;Bele allunk a folyosoba ballrol!
	bpl	.DB
	add.w	d4,d5
.DB	sub.w	d5,bobX(a0)	;ballra lepunk!
	bra	.MDown4

.DRight	tst.b	d3		;Mind a ket alattunk levo kocka van -) stop!
	bne	SetZeroPosition
	move.w	d0,d4
	move.w	REG_Speed,d5
	and.w	#$f,d4
	add.w	d5,d4
	cmp.w	#$10,d4		;Bele allunk a folyosoba jobbrol!
	blt	.DC
	sub.w	#$10,d4
	sub.w	d4,d5
.DC	add.w	d5,bobX(a0)
	bra	.MDown4

.DSuperMan
	move.b	AREAX(a2),d2
	bsr	Collosion
	bcc	.MDown3
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.DPacMan
	moveq 	#AREAX,d1
	bsr	SuperMan
	bcs	SetZeroPosition
	moveq 	#anTEGLAM1,d0
	bsr	InsertAnimation
	moveq 	#anTEGLAM2,d0
	add.w 	#AREAX,d1
	bsr	InsertAnimation
	MakeA1Fx SuperManFx
	bra	SetZeroPosition

.DPacMan
	moveq	#AREAX,d1
	bsr	TPacMan
	bcs	SetZeroPosition
	bra	.MDown4

.MDown3	add.w 	REG_Speed,bobY(a0)
.MDown4	lea	.ATDown(pc),a2
;	btst	#bitPACMAN,bobFlags+1(a0)
;	beq	.MDown5
;	lea	.PMDown(pc),a2
.MDown5	bsr	SetBobAnim
	rts

.ATDown	dc.b	0,1,0,2,-1
.PMDown	dc.b	0,1,2,1,-1
	even

;**
;** Move right!
;**

MoveRight
	btst	#bitCONTROLER,plFlags(a1)
	beq	.ManRight
	btst	#bitFire,plJoystick(a1)
	beq	.ManRight
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.ManRight
	lea	AreaA(a5),a2
	move.w	plCBOffset(a1),d1
	add.w 	d1,a2
	moveq	#blBOMBA,d0
	moveq	#anBOMBAM3,d2
	moveq	#anBOMBAM4,d3
	tst.w	TeamMode(a5)
	beq	.NoTm
	tst.b	plTeam(a1)
	beq	.NoTm
	moveq	#blBOMBB,d0
	moveq	#anBOMBBM3,d2
	moveq	#anBOMBBM4,d3
.NoTm	cmp.b 	(a2),d0
	bne	SetZeroPosition
	cmp.b 	#blURES,1(a2)
	bne	SetZeroPosition
	addq.w	#1,plCBOffset(a1)
	move.w	d2,d0
	bsr	InsertAnimation
	addq.w	#1,d1
	move.w  d3,d0
	bsr	InsertAnimation
	MakeA1Fx ControlerFx
	bra	SetZeroPosition

.ManRight
	move.b	#1,bobFazisHi(a0)
	bsr	GetSpeedParam
	move.w	d0,REG_Speed
	moveq 	#8,d0
	moveq 	#7,d1
	add.w 	bobX(a0),d0
	add.w 	bobY(a0),d1
	bsr	GetACodeXY
	moveq	#$f,d4
	and.w	d1,d4
	bne	.DA
;Ha DY=0 (Benne vagyunk a folyosoban!)
	moveq	#$f,d4
	and.w	d0,d4
	beq	.RSuperMan
	add.w	REG_Speed,d4
	cmp.w	#$10,d4		;Uj kocka ?
	blt	.MRight3		;Meg nem!
	move.b	2(a2),d2
	bsr	Collosion
	bcc	.MRight3
.DMaxMelle
	sub.w	#$10,d4
	move.w	REG_Speed,d2
	sub.w	d4,d2
	add.w	d2,bobX(a0)	;Egesszen az akadaly melle lepunk!
	bra	SetZeroPosition

;Ha DY<>0 (A folyoso szelen vagyunk!)
.DA	moveq	#$f,d4
	and.w	d0,d4
	beq	.DD
	add.w	REG_Speed,d4
	cmp.w	#$10,d4		;Uj kocka ?
	blt	.MRight3		;Meg nem!
	and.w	#$f,d0
	beq	.DD
	add.w	#1,a2
.DD	move.b	AREAX+1(a2),d2
	bsr	Collosion
	scs	d3
	move.b	1(a2),d2
	bsr	Collosion
	scs	d2
	and.w	#$f,d0
	beq	.RUpDown
	or.b	d2,d3
	bne	.DMaxMelle
	bra	.MRight3

.RUpDown
	tst.b	d2
	bne	.DDown
	tst.b	d3
	beq	.MRight3		;Mind a ket alattunk levo kocka ures -) lefele!
	move.w	d1,d4
	move.w	REG_Speed,d5
	and.w	#$f,d4
	sub.w	d5,d4		;Bele allunk a folyosoba ballrol!
	bpl	.DB
	add.w	d4,d5
.DB	sub.w	d5,bobY(a0)	;ballra lepunk!
	bra	.MRight4

.DDown	tst.b	d3		;Mind a ket alattunk levo kocka van -) stop!
	bne	SetZeroPosition
	move.w	d1,d4
	move.w	REG_Speed,d5
	and.w	#$f,d4
	add.w	d5,d4
	cmp.w	#$10,d4		;Bele allunk a folyosoba jobbrol!
	blt	.DC
	sub.w	#$10,d4
	sub.w	d4,d5
.DC	add.w	d5,bobY(a0)
	bra	.MRight4

.RSuperMan
	move.b	1(a2),d2
	bsr	Collosion
	bcc	.MRight3
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.RPacMan
	moveq 	#1,d1
	bsr	SuperMan
	bcs	SetZeroPosition
	moveq 	#anTEGLAM3,d0
	bsr	InsertAnimation
	moveq 	#anTEGLAM4,d0
	addq.w	#1,d1
	bsr	InsertAnimation
	MakeA1Fx SuperManFx
	bra	SetZeroPosition

.RPacMan
	moveq	#1,d1
	bsr	TPacMan
	bcs	SetZeroPosition
	bra	.MRight4

.MRight3
	add.w 	REG_Speed,bobX(a0)
.MRight4
	lea	.ATRight(pc),a2
;	btst	#bitPACMAN,bobFlags+1(a0)
;	beq	.MRight5
;	lea	.PMRight(pc),a2
.MRight5
	bsr	SetBobAnim
	rts

.ATRight
	dc.b	3,4,3,5,-1
.PMRight
	dc.b	3,4,5,4,-1
	even

;**
;** Move up!
;**

MoveUp	btst	#bitCONTROLER,plFlags(a1)
	beq	.ManUp
	btst	#bitFire,plJoystick(a1)
	beq	.ManUp
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.ManUp
	lea	AreaA(a5),a2
	move.w	plCBOffset(a1),d1
	add.w 	d1,a2
	moveq	#blBOMBA,d0
	moveq	#anBOMBAM5,d2
	moveq	#anBOMBAM6,d3
	tst.w	TeamMode(a5)
	beq	.NoTm
	tst.b	plTeam(a1)
	beq	.NoTm
	moveq	#blBOMBB,d0
	moveq	#anBOMBBM5,d2
	moveq	#anBOMBBM6,d3
.NoTm	cmp.b 	(a2),d0
	bne	SetZeroPosition
	cmp.b 	#blURES,-AREAX(a2)
	bne	SetZeroPosition
	sub.w 	#AREAX,plCBOffset(a1)
	move.w  d2,d0
	bsr	InsertAnimation
	sub.w 	#AREAX,d1
	move.w	d3,d0
	bsr	InsertAnimation
	MakeA1Fx ControlerFx
	bra	SetZeroPosition

.ManUp	move.b	#2,bobFazisHi(a0)
	bsr	GetSpeedParam
	move.w	d0,REG_Speed
	moveq 	#8,d0
	moveq 	#7,d1
	add.w 	bobX(a0),d0
	add.w 	bobY(a0),d1
	bsr	GetACodeXY
	moveq	#$f,d4
	and.w	d0,d4
	bne	.DA
;Ha DX=0 (Benne vagyunk a folyosoban!)
	moveq	#$f,d4
	and.w	d1,d4
	beq	.USuperMan
	sub.w	REG_Speed,d4
	bpl	.MUp3		;Meg nem!
	move.b	-AREAX(a2),d2
	bsr	Collosion
	bcc	.MUp3
.DMaxMelle
	move.w	REG_Speed,d2
	add.w	d4,d2
	sub.w	d2,bobY(a0)	;Egesszen az akadaly melle lepunk!
	bra	SetZeroPosition

;Ha DX<>0 (A folyoso szelen vagyunk!)
.DA	moveq	#$f,d4
	and.w	d1,d4
	beq	.DD
	sub.w	REG_Speed,d4
	bpl	.MUp3		;Meg nem!
.DD	move.b	-AREAX+1(a2),d2
	bsr	Collosion
	scs	d3
	move.b	-AREAX+0(a2),d2
	bsr	Collosion
	scs	d2
	and.w	#$f,d1
	beq	.DLeftRight
	or.b	d2,d3
	bne	.DMaxMelle
	bra	.MUp3

.DLeftRight	
	tst.b	d2
	bne	.DRight
	tst.b	d3
	beq	.MUp3		;Mind a ket alattunk levo kocka ures -) lefele!
	move.w	d0,d4
	move.w	REG_Speed,d5
	and.w	#$f,d4
	sub.w	d5,d4		;Bele allunk a folyosoba ballrol!
	bpl	.DB
	add.w	d4,d5
.DB	sub.w	d5,bobX(a0)	;ballra lepunk!
	bra	.MUp4

.DRight	tst.b	d3		;Mind a ket alattunk levo kocka van -) stop!
	bne	SetZeroPosition
	move.w	d0,d4
	move.w	REG_Speed,d5
	and.w	#$f,d4
	add.w	d5,d4
	cmp.w	#$10,d4		;Bele allunk a folyosoba jobbrol!
	blt	.DC
	sub.w	#$10,d4
	sub.w	d4,d5
.DC	add.w	d5,bobX(a0)
	bra	.MUp4

.USuperMan
	move.b	-AREAX(a2),d2
	bsr	Collosion
	bcc	.MUp3
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.UPacMan
	move.w	#-AREAX,d1
	bsr	SuperMan
	bcs	SetZeroPosition
	moveq 	#anTEGLAM5,d0
	bsr	InsertAnimation
	moveq 	#anTEGLAM6,d0
	sub.w 	#AREAX,d1
	bsr	InsertAnimation
	MakeA1Fx SuperManFx
	bra	SetZeroPosition

.UPacMan
	moveq	#-AREAX,d1
	bsr	TPacMan
	bcs	SetZeroPosition
	bra	.MUp4

.MUp3	sub.w 	REG_Speed,bobY(a0)
.MUp4	lea	.ATUp(pc),a2
;	btst	#bitPACMAN,bobFlags+1(a0)
;	beq	.MUp5
;	lea	.PMUp(pc),a2
.MUp5	bsr	SetBobAnim
	rts

.ATUp 	dc.b	9,10,9,11,-1
.PMUp	dc.b	9,10,11,10,-1
	even

;**
;** Move left!
;**

MoveLeft
	btst	#bitCONTROLER,plFlags(a1)
	beq	.ManLeft
	btst	#bitFire,plJoystick(a1)
	beq	.ManLeft
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.ManLeft
	lea	AreaA(a5),a2
	move.w	plCBOffset(a1),d1
	add.w 	d1,a2
	moveq	#blBOMBA,d0
	moveq 	#anBOMBAM7,d2
	moveq 	#anBOMBAM8,d3
	tst.w	TeamMode(a5)
	beq	.NoTm
	tst.b	plTeam(a1)
	beq	.NoTm
	moveq	#blBOMBB,d0
	moveq 	#anBOMBBM7,d2
	moveq 	#anBOMBBM8,d3
.NoTm	cmp.b 	(a2),d0
	bne	SetZeroPosition
	cmp.b 	#blURES,-1(a2)
	bne	SetZeroPosition
	subq.w	#1,plCBOffset(a1)
	move.w 	d2,d0
	bsr	InsertAnimation
	subq.w	#1,d1
	move.w 	d3,d0
	bsr	InsertAnimation
	MakeA1Fx ControlerFx
	bra	SetZeroPosition

.ManLeft
	move.b	#3,bobFazisHi(a0)
	bsr	GetSpeedParam
	move.w	d0,REG_Speed
	moveq 	#8,d0
	moveq 	#7,d1
	add.w 	bobX(a0),d0
	add.w 	bobY(a0),d1
	bsr	GetACodeXY
	moveq	#$f,d4
	and.w	d1,d4
	bne	.DA
;Ha DY=0 (Benne vagyunk a folyosoban!)
	moveq	#$f,d4
	and.w	d0,d4
	beq	.LSuperMan
	sub.w	REG_Speed,d4
	bpl	.MLeft3		;Meg nem!
	move.b	-1(a2),d2
	bsr	Collosion
	bcc	.MLeft3
.DMaxMelle
	move.w	REG_Speed,d2
	add.w	d4,d2
	sub.w	d2,bobX(a0)	;Egesszen az akadaly melle lepunk!
	bra	SetZeroPosition

;Ha DY<>0 (A folyoso szelen vagyunk!)
.DA	moveq	#$f,d4
	and.w	d0,d4
	beq	.DD
	sub.w	REG_Speed,d4
	bpl	.MLeft3		;Meg nem!
.DD	move.b	-1(a2),d2
	bsr	Collosion
	scs	d3
	move.b	AREAX-1(a2),d2
	bsr	Collosion
	scs	d2
	and.w	#$f,d0
	beq	.RUpDown
	or.b	d2,d3
	bne	.DMaxMelle
	bra	.MLeft3

.RUpDown
	tst.b	d2
	bne	.DDown
	tst.b	d3
	beq	.MLeft3		;Mind a ket alattunk levo kocka ures -) lefele!
	move.w	d1,d4
	move.w	REG_Speed,d5
	and.w	#$f,d4
	add.w	d5,d4
	cmp.w	#$10,d4		;Bele allunk a folyosoba jobbrol!
	blt	.DC
	sub.w	#$10,d4
	sub.w	d4,d5
.DC	add.w	d5,bobY(a0)
	bra	.MLeft4

.DDown	tst.b	d3		;Mind a ket alattunk levo kocka van -) stop!
	bne	SetZeroPosition
	move.w	d1,d4
	move.w	REG_Speed,d5
	and.w	#$f,d4
	sub.w	d5,d4		;Bele allunk a folyosoba ballrol!
	bpl	.DB
	add.w	d4,d5
.DB	sub.w	d5,bobY(a0)	;ballra lepunk!
	bra	.MLeft4

.LSuperMan
	move.b	-1(a2),d2
	bsr	Collosion
	bcc	.MLeft3
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.LPacMan
	moveq 	#-1,d1
	bsr	SuperMan
	bcs	SetZeroPosition
	moveq 	#anTEGLAM7,d0
	bsr	InsertAnimation
	moveq 	#anTEGLAM8,d0
	subq.w	#1,d1
	bsr	InsertAnimation
	MakeA1Fx SuperManFx
	bra	SetZeroPosition

.LPacMan
	moveq	#-1,d1
	bsr	TPacMan
	bcs	SetZeroPosition
	bra	.MLeft4

.MLeft3	sub.w 	REG_Speed,bobX(a0)
.MLeft4	lea	.ATLeft(pc),a2
;	btst	#bitPACMAN,bobFlags+1(a0)
;	beq	.MLeft5
;	lea	.PMLeft(pc),a2
.MLeft5	bsr	SetBobAnim
	rts

.ATLeft	dc.b	6,7,6,8,-1
.PMLeft	dc.b	6,7,8,7,-1
	even

;playerdef=a1
;dx=d0, speedcount=d1
GetSpeedParam
	moveq	#1,d0
	btst	#bitPACMAN,plFlags+1(a1)
	bne	.C
	tst.w	plBetegseg(a1)
	beq	.B
	cmp.w	#btBACHUS,plBetegseg(a1)
	bne	.D
	btst	#0,BeamCount+3(a5)
	bne	.C
	moveq	#0,d0
.C	rts
.D	cmp.w	#btSPRINTER,plBetegseg(a1)
	bne	.B
	moveq	#12,d0
	rts
.B	move.w	plSpeed(a1),d0
	cmp.w 	#7,d0
	bls	.A
	moveq 	#7,d0
.A	move.b	.SpeedTab(pc,d0.w),d0
	rts

.SpeedTab
;	Speed
	dc.b	1,2,3,4,5,6,7,8

;bobptr=a0, playerdef=a1, animtab=a2
SetBobAnim
	moveq	#7,d1
;... animsped=d1
SetBobAnim2
	btst	#bitGHOST,plFlags+1(a1)
	beq	.NoGhost
	btst	#bitGHOST,bobFlags+1(a0)
	bne	.NoGhost
	lea	ATGhost(pc),a2
	bra	.A
.NoGhost
	btst	#bitPACMAN,bobFlags+1(a0)
	beq	.A
	addq.w	#5,a2			;Set pacman anim offset...
.A	subq.w	#1,bobASpeed(a0)
	bpl	.B
	move.w	d1,bobASpeed(a0)
	addq.b	#1,bobFazisLo(a0)
.B	moveq	#0,d0
	moveq 	#0,d1
	move.b	bobFazisLo(a0),d1
	move.b	(a2,d1.w),d0
	bpl	.AnimOk
	clr.b 	bobFazisLo(a0)
	move.b	(a2),d0
.AnimOk	btst	#bitPACMAN,bobFlags+1(a0)
	bne	.Pm
	move.b	plPlayerID(a1),d1
	move.b	BAFNull-1(pc,d1.w),d1
	add.w 	d1,d0
.Pm	bsr	SetBobImage
BAnimEnd
	rts

BAFNull	dc.b	0,30,60,90,120
ATGhost	dc.b	24,25,26,27,28,29,-1
	even

;----------------------------------

DeleteBombArea
	lea	BombArea(a5),a0
	move.w	#AREAX*AREAY-1,d0
.Loop 	clr.b 	bcPlayerID(a0)
	addq.w	#bcSIZEOF,a0
	dbf	d0,.Loop
	rts

BombExplode
	lea	BombArea(a5),a0
	add.l 	#bcSIZEOF*AREAX,a0
	moveq 	#AREAX,d2
.Loop 	moveq 	#$f,d0
	and.b 	bcPlayerID(a0),d0
	beq	.NextBomb
	cmp.b 	#6,d0
	blt	.PlayerBomb
	subq.b	#1,bcCount(a0)
	bmi	.KillExplode
	subq.w	#6,d0
	move.w	d0,d3
	move.w	d2,d1
	moveq 	#anEXPLODE,d0
	bsr	InsertAnimation
	lsl.w 	#2,d3
	move.w	d2,d1
	jsr	.ExplJumps(pc,d3.w)
.KillExplode
	clr.b 	bcPlayerID(a0)
	bra	.NextBomb
.ExplJumps
	bra.w 	ExplDown
	bra.w 	ExplRight
	bra.w 	ExplUp
	bra.w 	ExplLeft

.PlayerBomb
	move.w	d0,d1
	lsl.w 	#2,d1
	lea	PlayersTB-4(a5),a1
	move.l	(a1,d1.w),a1
	subq.b	#1,bcCount(a0)
	beq	.NoTMBomb
	btst	#bitTIMEBOMB,bcPlayerID(a0)
	beq	.NextBomb
	btst	#bitOUT,plFlags+1(a1)
	bne	.NoTMBomb
	btst	#bitFire,plJoystick(a1)
	bne	.NextBomb
.NoTMBomb
	move.l	a1,-(sp)
	move.w	d2,d1
	lsl.w 	#2,d1 			;anSIZEOF=4!!!!!
;	mulu	#anSIZEOF,d1
	lea	AnimationsTab(a5),a1
	move.w	#-1,anType(a1,d1.w)	;Bomba animacio torles!
	move.l	(sp)+,a1
	subq.w	#1,plBombCount(a1)	;A lerakott bomba szamlalo csokkentes!
	move.w	plPower(a1),d0
	cmp.w	#btMICROBOMB,plBetegseg(a1)
	bne	.NoBt
	moveq	#1,d0			;Micro bomba!
.NoBt	move.b	d0,bcCount(a0)		;Power!
	move.w	d2,d1
	moveq 	#anEXPLODE,d0
	bsr	InsertAnimation		;Robbanas animacio ...
	btst	#bitATOMBOMB,bcPlayerID(a0)
	beq	.NoATM
	bsr	AtomBombExplode
	bra	.SetATM

.NoATM	clr.b 	bcPlayerID(a0) 		;Bomba torles
	bsr	ExplDown
	bsr	ExplRight
	bsr	ExplUp
	bsr	ExplLeft
.SetATM	bsr	ExplodeNight
	MakeFx	ExplodeFx
.NextBomb
	addq.w	#bcSIZEOF,a0
	addq.w	#1,d2
	cmp.w 	#AREAX*AREAY-AREAX,d2
	blt	.Loop
	rts

ExplodeNight
	btst	#bitNIGHT,GlobalFlags+1(a5)
	beq	.NoNight
	lea	DefaultPaletta(pc),a1
	bsr	SetCopPaletta
	move.w	#DEFAULTNIGHTDEPTH,FadeCount(a5)
.NoNight
	rts

ExplDown
	move.w	d1,-(sp)
	moveq 	#6,d0
	add.w 	#AREAX,d1
	bra	TryNewExplode

ExplRight
	move.w	d1,-(sp)
	moveq 	#7,d0
	addq.w	#1,d1
	bra	TryNewExplode

ExplUp	move.w	d1,-(sp)
	moveq 	#8,d0
	sub.w 	#AREAX,d1
	bra	TryNewExplode

ExplLeft
	move.w	d1,-(sp)
	moveq 	#9,d0
	subq.w	#1,d1

TryNewExplode
	bsr	IExplode
	bcs	.Exit
	lea	BombArea(a5),a1
	add.w 	d1,d1
	add.w 	d1,a1
	move.b	d0,bcPlayerID(a1)
	move.b	bcCount(a0),bcCount(a1)
.Exit 	move.w	(sp)+,d1
	rts

IExplode
	movem.l	d0/d1,-(sp)
	lea	AreaA(a5),a1
	move.b	(a1,d1.w),d0
	cmp.b 	#blURES,d0
	bne	INemUres
IExpNone
	clc
IExpEnd	movem.l	(sp)+,d0/d1
	rts

INemUres
	cmp.b 	#blFAL,d0
	beq	.ExplodeFal
	cmp.b 	#blTEGLA,d0
	beq	.ExplodeTegla
	cmp.b 	#blKEMENY,d0
	blt	.nemkemeny
	cmp.b 	#blKEMENY+3,d0
	blt	.ExplodeKemeny
.nemkemeny
	cmp.b 	#blBOMBA,d0
	blt	.nembomba
	cmp.b 	#blBOMBA+3,d0
	blt	.ExplodeBomb
.nembomba
	cmp.b	#blBOMBB,d0
	blt	.nembomba2
	cmp.b	#blBOMBB+3,d0
	blt	.ExplodeBomb
.nembomba2
	cmp.b	#blWEXPLODE,d0
	blt	IExpNone
	cmp.b	#blWEXPLODE+5,d0
	blt	.ExplodeFal
	bra	IExpNone

.ExplodeFal
	sec
	bra	IExpEnd

.ExplodeTegla
	moveq 	#anTEGLA,d0
	bsr	InsertAnimation
	bra	.ExplodeFal

.ExplodeKemeny
	addq.b	#1,d0
	cmp.b 	#blKEMENY+2,d0
	bhs	.Explk2
	move.b	d0,(a1,d1.w)
	bra	.ExplodeFal

.Explk2	moveq 	#anKEMENY,d0
	bsr	InsertAnimation
	bra	.ExplodeFal

.ExplodeBomb
	lea	BombArea(a5),a1
	add.w 	d1,d1
	add.w 	d1,a1
	moveq	#$f,d0
	and.b 	bcPlayerID(a1),d0
	beq	IExpNone
	cmp.b	#6,d0
	bge	IExpNone
	move.b	#1,bcCount(a1)
	bclr	#bitTIMEBOMB,bcPlayerID(a1)
;	bclr	#bitATOMBOMB,bcPlayerID(a1)
	bra	.ExplodeFal

* offset=d1
AtomBombExplode
	movem.l	d2/a0,-(sp)
	clr.b	bcPlayerID(a0)
	move.w	d1,d0
	ext.l	d0
	divu	#AREAX,d0
	move.w	d0,d1
	swap	d0
	subq.w	#ATOMW/2,d0
	subq.w	#ATOMH/2,d1
	moveq	#ATOMH-1,d2
	lea	BombArea(a5),a0
	lea	Extras(a5),a1
	lea	PlayersTB-4(a5),a2
.Loop1	cmp.w	#AREAY,d1
	bhs	.Next2
	move.w	d0,-(sp)
	moveq	#ATOMW-1,d3
.Loop	cmp.w	#AREAX,d0
	bhs	.Next
	move.w	d1,d4
	mulu	#AREAX,d4
	add.w	d0,d4
	cmp.b	#exKERET,(a1,d4.w)
	beq	.Next
	movem.w	d0/d1,-(sp)
	moveq	#anEXPLODE,d0
	move.w	d4,d1
	bsr	InsertAnimation
	add.w	d1,d1			;bcSIZEOF=2!!!
	moveq	#$f,d0
	and.b	(a0,d1.w),d0
	beq	.Next3
	cmp.b	#6,d0
	bge	.Next3
	clr.b	bcPlayerID(a0,d1.w)
	lsl.w	#2,d0
	move.l	(a2,d0.w),a3
	subq.w	#1,plBombCount(a3)
.Next3	movem.w	(sp)+,d0/d1		
.Next	addq.w	#1,d0
	dbf	d3,.Loop
	move.w	(sp)+,d0
.Next2	addq.w	#1,d1
	dbf	d2,.Loop1
	movem.l	(sp)+,a0/d2
	bset	#bitATOMEXPLODE,GlobalFlags+1(a5)
	clr.w	AtomCount(a5)
	rts

; ----------

DrawAllBlocks
	tst.b 	BlockSpare(a5)
	bmi	.NoSpare
	lea	$dff000,a6
.WBlt 	btst	#6,$2(a6)
	bne	.WBlt
	move.w	#42-2,$64(a6)
	move.w	#42-2,$66(a6)
	move.w	#$09f0,$40(a6)
	move.l	#$ffffffff,$44(a6)
	move.l	PlaneC(a5),d0
	move.l	PlaneA(a5),d1
	lea	BlockSpare(a5),a2
	move.w	#$8400,$96(a6)
.NextSpare
	addq.w	#2,a2
	move.l	(a2)+,a0
	move.l	a0,a1
	add.l 	d0,a0
	add.l 	d1,a1
.WBlt2	btst	#6,$2(a6)
	bne	.WBlt2
	movem.l	a0/a1,$50(a6)
	move.w	#(16*5)<<6+1,$58(a6)
	tst.b 	(a2)
	bpl	.NextSpare
	move.w	#$400,$96(a6)
.NoSpare
	rts

InsertAllBlocks
	lea	AreaA(a5),a0
	move.l	AreaB1(a5),a1
	add.l 	#AREAX+1,a0
	add.l 	#AREAX+1,a1
	move.l	#42*5*16,d1
	lea	BlockSpare(a5),a2
	moveq 	#AREAY-2-1,d2
.Loop1	moveq 	#1,d3
.Loop2	move.b	(a0)+,d0
	cmp.b 	(a1)+,d0
	beq	.Loop3
	move.b	d0,-1(a1)
	ext.w 	d0
	move.w	d0,(a2)+
	move.l	d1,d0
	add.l 	d3,d0
	add.l 	d3,d0
	move.l	d0,(a2)+
.Loop3	addq.w	#1,d3
	cmp.w 	#AREAX-1,d3
	blt	.Loop2
	add.l 	#42*5*16,d1
	addq.w	#2,a0
	addq.w	#2,a1
	dbf	d2,.Loop1
	st 	(a2)
	tst.b 	BlockSpare(a5)
	bmi	.NoSpare
	bsr	InitCopyBlock
	lea	BlockSpare(a5),a2
.Loop 	move.w	(a2)+,d0
	move.l	(a2)+,a1
	add.l 	PlaneC(a5),a1
	bsr	CopyBlock
	tst.b 	(a2)
	bpl	.Loop
.NoSpare
	rts

;type=d0, offset=d1
InsertAnimation
	movem.l	d1/a0,-(sp)
	lea	AnimationsTab(a5),a0
	lsl.w 	#2,d1 	;anSIZEOF=4!!!!
;	mulu	#anSIZEOF,d1
	add.l 	d1,a0
	move.w	d0,anType(a0)
	clr.w 	anFazis(a0)
	movem.l	(sp)+,d1/a0
	rts

DeleteAnimations
	lea	AnimationsTab(a5),a0
	move.w	#AREAX*AREAY-1,d0
.Loop 	move.w	#-1,anType(a0)
	addq.w	#anSIZEOF,a0
	dbf	d0,.Loop
	rts

Animations
	lea	AnimationsTab(a5),a0
	add.l 	#anSIZEOF*AREAX,a0
	lea	AreaA(a5),a2
	moveq 	#AREAX,d2
.Loop 	move.w	anType(a0),d0
	bmi	.NextAnim
	move.w	d0,d3
	lsl.w 	#2,d0
	lea	AnimsTB(pc),a1
	add.w 	AnimsPar+0(pc,d0.w),a1
	move.w	AnimsPar+2(pc,d0.w),d1
	bsr	DoAnimation
.NextAnim
	add.w 	#anSIZEOF,a0
	addq.w	#1,d2
	cmp.w 	#AREAX*AREAY-AREAX,d2
	blt	.Loop
	rts

DoAnimation
	subq.b	#1,anACount(a0)
	bpl	.Exit
	move.b	d1,anACount(a0)
	moveq 	#0,d0
	move.b	anFazis(a0),d0
	addq.b	#1,anFazis(a0)
	move.b	0(a1,d0.w),(a2,d2.w)
	tst.b 	1(a1,d0.w)
	bpl	.Exit
	clr.b 	anFazis(a0)
	cmp.b 	#-2,1(a1,d0.w)
	bne	.Exit
	move.w	#-1,anType(a0)
	cmp.w 	#anTEGLA,d3 	;AJANDEK OSZTAS!!
	bne	.Exit
	lea	Extras(a5),a1
	move.b	(a1,d2.w),(a2,d2.w)
.Exit 	rts

;		Anim taboffset,	anim speed!
AnimsPar
	dc.w	ExplodeAT-AnimsTB, 0
	dc.w	KemenyAT-AnimsTB,  3
	dc.w	BombAT-AnimsTB,	   3
	dc.w	ShrinkAT-AnimsTB,  4
	dc.w	TeglaAT-AnimsTB,   3
	dc.w	TeglaM1AT-AnimsTB, 1
	dc.w	TeglaM2AT-AnimsTB, 1
	dc.w	TeglaM3AT-AnimsTB, 1
	dc.w	TeglaM4AT-AnimsTB, 1
	dc.w	TeglaM5AT-AnimsTB, 1
	dc.w	TeglaM6AT-AnimsTB, 1
	dc.w	TeglaM7AT-AnimsTB, 1
	dc.w	TeglaM8AT-AnimsTB, 1
	dc.w	BombAM1AT-AnimsTB, 2
	dc.w	BombAM2AT-AnimsTB, 2
	dc.w	BombAM3AT-AnimsTB, 2
	dc.w	BombAM4AT-AnimsTB, 2
	dc.w	BombAM5AT-AnimsTB, 2
	dc.w	BombAM6AT-AnimsTB, 2
	dc.w	BombAM7AT-AnimsTB, 2
	dc.w	BombAM8AT-AnimsTB, 2
	dc.w	BombBT-AnimsTB,	   3
	dc.w	BombBM1AT-AnimsTB, 2
	dc.w	BombBM2AT-AnimsTB, 2
	dc.w	BombBM3AT-AnimsTB, 2
	dc.w	BombBM4AT-AnimsTB, 2
	dc.w	BombBM5AT-AnimsTB, 2
	dc.w	BombBM6AT-AnimsTB, 2
	dc.w	BombBM7AT-AnimsTB, 2
	dc.w	BombBM8AT-AnimsTB, 2
	
; Animacios tablazatok....
AnimsTB
ExplodeAT
;	dc.b	5,4,3,2,1,0,1,2,3,4,5,blURES,-2
	dc.b	0,1,2,3,4,5,blURES,-2
BombAT	dc.b	34,35,34,36,-1
KemenyAT
	dc.b	8,9,10,11,12,blURES,-2
ShrinkAT
	dc.b	20,21,22,23,24,blFAL,-2
TeglaAT	dc.b	29,30,31,32,33,blURES,-2
TeglaM1AT
	dc.b	16,blURES,-2	;Tegla le (felso resz)
TeglaM2AT
	dc.b	17,blTEGLA,-2	;Tegla le (also resz)
TeglaM3AT
	dc.b	14,blURES,-2	;Tegla jobbra (ball resz)
TeglaM4AT
	dc.b	15,blTEGLA,-2	;Tegla jobbra (jobb resz)
TeglaM5AT
	dc.b	17,blURES,-2	;Tegla fel (also resz)
TeglaM6AT
	dc.b	16,blTEGLA,-2	;Tegla fel (felso resz)
TeglaM7AT
	dc.b	15,blURES,-2	;Tegla ballra (jobb resz)
TeglaM8AT
	dc.b	14,blTEGLA,-2	;Tegla ballra (ball resz)

BombAM1AT
	dc.b	54,56,58,blURES,-2	;Bomba le (felso resz)
BombAM2AT
	dc.b	55,57,59,blBOMBA,-2	;Bomba le (also resz)
BombAM3AT
	dc.b	64,62,60,blURES,-2	;Bomba jobbra (ball resz)
BombAM4AT
	dc.b	65,63,61,blBOMBA,-2	;Bomba jobbra (jobb resz)
BombAM5AT
	dc.b	59,57,55,blURES,-2	;Bomba fel (also resz)
BombAM6AT
	dc.b	58,56,54,blBOMBA,-2	;Bomba fel (felso resz)
BombAM7AT
	dc.b	61,63,65,blURES,-2	;Bomba ballra (jobb resz)
BombAM8AT
	dc.b	60,62,64,blBOMBA,-2	;Bomba ballra (ball resz)

* TEAM B BOMB ANIMATIONS...
BombBT	dc.b	85,86,85,87,-1
BombBM1AT
	dc.b	88,90,92,blURES,-2	;Bomba le (felso resz)
BombBM2AT
	dc.b	89,91,93,blBOMBB,-2	;Bomba le (also resz)
BombBM3AT
	dc.b	98,96,94,blURES,-2	;Bomba jobbra (ball resz)
BombBM4AT
	dc.b	99,97,95,blBOMBB,-2	;Bomba jobbra (jobb resz)
BombBM5AT
	dc.b	93,91,89,blURES,-2	;Bomba fel (also resz)
BombBM6AT
	dc.b	92,90,88,blBOMBB,-2	;Bomba fel (felso resz)
BombBM7AT
	dc.b	95,97,99,blURES,-2	;Bomba ballra (jobb resz)
BombBM8AT
	dc.b	94,96,98,blBOMBB,-2	;Bomba ballra (ball resz)
	even

VisualEffects
	btst	#bitNIGHT,GlobalFlags+1(a5)
	beq	.NoNight
	tst.w	NightCount(a5)
	bne	.SetNight
	bclr	#bitNIGHT,GlobalFlags+1(a5)
	lea	DefaultPaletta(pc),a1
	bsr	SetCopPaletta
	bra	.NoNight
.SetNight	
	subq.w	#1,NightCount(a5)
	tst.w	FadeCount(a5)
	beq	.NoNight
	subq.w	#1,FadeSpeed(a5)
	bpl	.NoNight
	move.w	#DEFAULTFADESPEED,FadeSpeed(a5)
	bsr	FadeDown
	subq.w	#1,FadeCount(a5)
.NoNight
	btst	#bitATOMEXPLODE,GlobalFlags+1(a5)
	beq	.NoAtom
	move.w	AtomCount(a5),d0
	move.b	AtomBoom(pc,d0.w),d0
	bne	.SetAtom
	bclr	#bitATOMEXPLODE,GlobalFlags+1(a5)
	bra	.NoAtom
.SetAtom
	move.l	copReg102(a5),a0
	add.b	d0,3(a0)
	addq.w	#1,AtomCount(a5)
.NoAtom	rts

AtomBoom
	dc.b	-$88,+$88,-$88,+$88,-$88,+$88,-$88,+$88
	dc.b	-$44,+$44,-$44,+$44,-$44,+$44
	dc.b	-$22,+$22,-$22,+$22
	dc.b	-$11,+$11
	dc.b	0
	even

FadeDown
	move.l	copPaletta(a5),a0
	addq.w	#2,a0
	moveq	#31,d1
.mloop	move.w	(a0),d0
	and.w	#$00f,d0
	beq	.bloop
	subq.w	#1,(a0)
.bloop	move.w	(a0),d0
	and.w	#$0f0,d0
	beq	.gloop
	sub.w	#$10,(a0)
.gloop	move.w	(a0),d0
	and.w	#$f00,d0
	beq	.rloop
	sub.w	#$100,(a0)
.rloop	addq.w	#4,a0
	dbf	d1,.mloop
	rts

MakeAlarm
	btst	#bitTIMELIMIT,GlobalFlags(a5)
	beq	.Exit
	tst.w	AlarmCount(a5)
	bmi	.A
	addq.w	#1,AlarmCount(a5)
	cmp.w 	#DEFAULTALARMTIME,AlarmCount(a5)
	blt	.Exit
	bne	.A
	move.w	#1,AlarmDX(a5)
	clr.w	AlarmCReg(a5)
	MakeSpecialFx	AlarmFx,$dff0b0
.A 	move.w	AlarmCReg(a5),d0
	move.w	d0,d1
	lsl.w	#8,d0
	move.l	copPaletta(a5),a0
	move.w	d0,2(a0)
	add.w	AlarmDX(a5),d1
	beq	.B
	cmp.w	#15,d1
	bne	.C
.B	neg.w	AlarmDx(a5)
.C	move.w	d1,AlarmCReg(a5)
	move.w	AlarmCount(a5),d0
	bmi	.Exit
	cmp.w	#DEFAULTALARMTIME+DEFAULTSHRINKTIME,d0
	blt	.Exit
	st	AlarmCount(a5)
	clr.w	ShrinkCount(a5)
	clr.w	ShrinkSpeed(a5)
.Exit 	rts

MakeShrinking
	tst.w	AlarmCount(a5)
	bpl	.Exit
	bsr	DeleteProtGhost
	btst	#bitSHRINKING,GlobalFlags(a5)
	beq	.KillEmAll
	subq.w	#1,ShrinkSpeed(a5)
	bpl	.Exit
	move.w	#7,ShrinkSpeed(a5)
	move.w	ShrinkCount(a5),d0
	move.w	d0,d1
	add.w	d1,d1
	lea	ShrinkTabel(pc),a0
	move.w	(a0,d1.w),d1
	bmi	.ShrinkEnd
	addq.w	#1,ShrinkCount(a5)
	move.w	d1,d2
	lsl.w	#2,d2			;anSIZEOF=4!!!!!!
	lea	AnimationsTab(a5),a0
	move.w	#-1,anType(a0,d2.w)	;Delete animation!
	lea	BombArea(a5),a0
	move.w	d1,d2
	add.w	d2,d2			;bcSIZEOF=2!!!!!
	add.w	d2,a0
	clr.b 	bcPlayerID(a0) 		;Delete bomb/explode!
	moveq	#$f,d2
	and.b	bcPlayerID(a0),d2
	beq	.NoBomb
	cmp.b	#6,d2
	bge	.NoBomb
	lsl.w 	#2,d2
	lea	PlayersTB-4(a5),a0
	move.l	(a0,d2.w),a0
	subq.w	#1,plBombCount(a0)	;Bomba szamlalo csokkentes!
.NoBomb	lea	Extras(a5),a0
	move.b	#exKERET,(a0,d1.w)	;Az atom bomba nem tudja lerombolni!
	lsr.w	d0
	bcs	.SetSHAnim
	moveq	#anSHRINK,d0
	bsr	InsertAnimation
	MakeFx	ShrinkFx
	bra	.Exit
.SetSHAnim
	lea	AreaA(a5),a0
	move.b	#blFAL,(a0,d1.w)
.Exit	rts

.ShrinkEnd
	bset	#bitGAMEEND,GlobalFlags+1(a5)
	rts

.KillEmAll
	lea	PlayersTB(a5),a0
	moveq	#4,d0
.Loop	move.l	(a0)+,a1
	bset	#bitDEAD,plFlags+1(a1)
	bne	.Loop2
	clr.w	plIceCount(a1)
	move.l	plBob(a1),a1
	clr.b 	bobFazisLo(a1)
	clr.w 	bobASpeed(a1)
.Loop2	dbf	d0,.Loop
	rts

DeleteProtGhost
	lea	PlayersTB(a5),a0
	moveq	#4,d0
.Loop	move.l	(a0)+,a1
	clr.w	plIceCount(a1)
	btst	#bitPROTECTION,plFlags+1(a1)
	beq	.NoProt
	bset	#bitDEAD,plFlags+1(a1)
	move.l	plBob(a1),a1
	clr.b 	bobFazisLo(a1)
	clr.w 	bobASpeed(a1)
	bra	.Loop2
.NoProt	bclr	#bitGHOST,plFlags+1(a1)
	beq	.Loop2
	move.l	plBob(a1),a1
	bclr	#bitGHOST,bobFlags+1(a1)
	clr.b 	bobFazisLo(a1)
	clr.w 	bobASpeed(a1)
.Loop2	dbf	d0,.Loop
	rts

* Find the winner player or team...
FindWinner
	tst.w	TeamMode(a5)
	bne	.FindWinTeam
	lea	PlayersTB(a5),a0
	moveq	#4,d0
	moveq	#0,d1
.Loop	move.l	(a0)+,a1
	btst	#bitSELECTED,plFlags+2(a1)
	beq	.NoSel
	btst	#bitOUT,plFlags+1(a1)
	bne	.NoSel
	addq.w	#1,d1
	move.l	a1,a2
.NoSel	dbf	d0,.Loop
	cmp.w	#1,d1
	bgt	.NotEnd
	subq.w	#1,d1
	bmi	.Undecided
.SetWinPlayer
	move.b	plPlayerID(a2),WinnerIs+1(a5)
	bset	#bitGAMEEND,GlobalFlags+1(a5)
.NotEnd	rts

.Undecided
	clr.w	WinnerIs(a5)
	cmp.w	#DEFAULTWINTIME-100,WinnerCount(a5)
	bhs	.A
	bset	#bitGAMEEND,GlobalFlags+1(a5)
	move.w	#DEFAULTWINTIME-100,WinnerCount(a5)
.A	rts

.FindWinTeam
	lea	PlayersTB(a5),a0
	moveq	#4,d0
.Loop2	movea.l	(a0)+,a2
	btst	#bitSELECTED,plFlags+2(a2)
	beq	.Loop1
	btst	#bitOUT,plFlags+1(a2)
	beq	.Loop3
.Loop1	dbf	d0,.Loop2
	bra	.Undecided

.Loop3	subq.w	#1,d0
	bmi	.SetWinPlayer
	move.b	plTeam(a2),d1
.Loop5	movea.l	(a0)+,a1
	btst	#bitSELECTED,plFlags+2(a1)
	beq	.Loop4
	btst	#bitOUT,plFlags+1(a1)
	bne	.Loop4
	cmp.b	plTeam(a1),d1
	bne	.NotEnd
.Loop4	dbf	d0,.Loop5
	bra	.SetWinPlayer

;TabelSizeX=21, TabelSizeY=15!!!!!!!!!!

ShrinkTabel
 dc.w  22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39
 dc.w  40, 61, 82,103,124,145,166,187,208,229,250,271
 dc.w 292,291,290,289,288,287,286,285,284,283,282,281,280,279,278,277,276,275
 dc.w 274,253,232,211,190,169,148,127,106, 85, 64, 43
 dc.w  44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59
 dc.w  60, 81,102,123,144,165,186,207,228,249
 dc.w 270,269,268,267,266,265,264,263,262,261,260,259,258,257,256,255
 dc.w 254,233,212,191,170,149,128,107, 86, 65
 dc.w  66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79
 dc.w  80,101,122,143,164,185,206,227
 dc.w 248,247,246,245,244,243,242,241,240,239,238,237,236,235
 dc.w 234,213,192,171,150,129,108, 87
 dc.w  88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99
 dc.w 100,121,142,163,184,205
 dc.w 226,225,224,223,222,221,220,219,218,217,216,215
 dc.w 214,193,172,151,130,109
 dc.w 110,111,112,113,114,115,116,117,118,119
 dc.w 120,141,162,183
 dc.w 204,203,202,201,200,199,198,197,196,195
 dc.w 194,173,152,131
 dc.w 132,133,134,135,136,137,138,139
 dc.w 140,161
 dc.w 182,181,180,179,178,177,176,175
 dc.w 174,153
 dc.w -1	;End of tabel!
	 
SwapScreens
	movem.l	PlaneA(a5),d0-d1
	move.l	d1,PlaneA(a5)
	move.l	d0,PlaneB(a5)
	movem.l	BobSaveA(a5),d0-d1
	move.l	d1,BobSaveA(a5)
	move.l	d0,BobSaveB(a5)
	movem.l	AreaB1(a5),d0-d1
	move.l	d1,AreaB1(a5)
	move.l	d0,AreaB2(a5)
	lea	NewBobs(a5),a0
	move.l	a0,NewBobPtr(a5)
	st 	(a0)
	bsr	WaitBOF
	move.l	PlaneB(a5),d0
	bsr	SetCopPlanes42
	st 	BlockSpare(a5)
	rts

Random	movem.l	d1/d2,-(sp)
	move.w	d0,d2
	move.l	RndSeed(a5),d0
	move.l	BeamCount(a5),d1
	add.l 	d0,d0
	bcc	.A
	eor.l 	#$1d872b41,d0
.A	eor.l	d1,d0
 	move.l	d0,RndSeed(a5)
	and.l 	#$ffff,d0
	divu	d2,d0
	swap	d0
	movem.l	(sp)+,d1/d2
	rts

GetSeed	move.b	ciab+$a00,d0
	lsl.l	#8,d0
	move.b	ciab+$900,d0
	lsl.l	#8,d0
	move.b	ciab+$800,d0
	lsl.l	#8,d0
	move.b	ciab+$700,d0
	move.l	d0,RndSeed(a5)
	rts
			
;*******************************************************

Main	lea	Vars,a5
	lea	VarsPtr(pc),a0
	move.l	a5,(a0)
	move.l	sp,SystemSP(a5)
	bsr	Initialize
	tst.l 	d0
	beq	ExitToDOS
	IFND	REGISTERED
	bset	#bitPASSOK,SysFlags+1(a5)
	ENDC
	move.l	PSP(a5),sp		;Set game SP
	bsr	SetDir
	bsr	OpenTFSData
	beq	ExitToDOS
	bsr	AddInterrupts
	bsr	SetIEHandler
	bsr	SetChips
	bsr	PrepareMemory
	tst.l	d0
	beq	BreakExecute
	bsr	InitABPlanes
	move.l	PlaneA(a5),d0
	move.l	CopperListA(a5),a0
	bsr	MakeCList42
	move.l	CopperListA(a5),a0
	bsr	SetCopperList
	bsr	ResetAudio
	bsr	SetGameDefaults
	bsr	GetSeed
	IFD	REGISTERED
	bsr	DoProt
	ENDC
	bsr	LoadConfig
	bsr	LoadDatas
	bsr	InitTabels
	bsr	InitGhostImage
	bsr	MakeFigMasks
	bsr	InitEnemySprites
; GAME START
GameStart
	sf	$45+KBMatrix(a5)	;Clear ESC Flag!!
	bsr	InitABPlanes
	bsr	ResetAudio
	bsr	TitleMain
	tst.b 	$45+KBMatrix(a5)
	bne	BreakExecute
	clr.w	EndOfGame(a5)
	bsr	InitPlayersDEF
	bsr	InitABPlanes
	move.l	PlaneA(a5),d0
	move.l	CopperListA(a5),a0
	bsr	MakeCList42
	move.l	CopperListA(a5),a0
	bsr	SetCopperList	
BattleStart
	clr.w	WinnerIs(a5)
	clr.w	WinnerCount(a5)
	clr.w 	AlarmCount(a5)
	clr.w 	AlarmCReg(a5)
	clr.b	GlobalFlags+1(a5)	;Clear Global Effect flags!!!
	bsr	ReInitPlayersDEF
	btst	#bitSHOP,GlobalFlags(a5)
	beq	.NoShop
	bsr	ShopMain
	tst.b 	$45+KBMatrix(a5)
	bne	GameStart
.NoShop	bsr	Count321
	bsr	ClearAllPlanes
	move.l	PlaneA(a5),d0
	move.l	CopperListB(a5),a0
	bsr	MakeCListGame
	move.l	CopperListB(a5),a0
	bsr	SetCopperList
	bsr	InitDrawBob
	pea	AreaA1(a5)
	move.l	(sp)+,AreaB1(a5)
	pea	AreaA2(a5)
	move.l	(sp)+,AreaB2(a5)
	bsr	GenerateArea
	bsr	InitAreas
	bsr	DrawArea
	bsr	DeleteAnimations
	bsr	DeleteBombArea
	tst.w	GhostsNb(a5)
	beq	.NoEnemys
	bsr	ReInitEnemyDEF
	move.w	#$8020,$dff096		;Set sprites on!
.NoEnemys
	lea	DefaultPaletta(pc),a1
	clr.w 	(a1)
	bsr	SetCopPaletta
	btst	#bitMUSICON,GlobalFlags(a5)
	beq	GMainLoop
	bsr	StartMainMusic
GMainLoop
	bsr	SwapScreens
	bsr	SetEnemySprites
	bsr	MoveEnemys
	bsr	PLPLCollosion
	bsr	MovePlayers
	bsr	BombExplode
	bsr	MakeShrinking
	bsr	Animations
	bsr	InsertAllBlocks
	bsr	DrawAllBlocks
	bsr	DrawAllBobs
	bsr	MakeAlarm
	bsr	VisualEffects
	bsr	FindWinner
	btst	#bitGAMEEND,GlobalFlags+1(a5)
	beq	.A
	addq.w	#1,WinnerCount(a5)
	cmp.w	#DEFAULTWINTIME,WinnerCount(a5)
	bhs	GotAWinner
.A	bsr	CheckForPause
	tst.b 	$45+KBMatrix(a5)
	beq	GMainLoop
	bra	GameStart
GotAWinner
	bsr	ClearCopPaletta
	bsr	InitABPlanes
	bsr	ResetAudio
	move.l	PlaneA(a5),d0
	move.l	CopperListA(a5),a0
	bsr	MakeCList42
	move.l	CopperListA(a5),a0
	bsr	SetCopperList
	bsr	Standings
	tst.w	EndOfGame(a5)
	bne	.A
	bsr	Gambling
	bra	BattleStart
.A	bsr	ShowWinner
	bra	GameStart
	
BreakExecute
	bsr	ResetAudio
	bsr	RestoreChips
	bsr	FreeAllMem
	move.w	#$100,$dff096
	bsr	RemInterrupts
	bsr	RemIEHandler
ExitToDOS
	bsr	CloseTFSData
	bsr	RestoreDir
	move.l	SystemSP(a5),sp
	bsr	DeInitialize
	move.w	#$8100,$dff096
	moveq 	#0,d0
	rts

************** PAUSE & GAME KEYS ******************************
* Pause (F10)
CheckForPause
	tst.b	$59+KBMatrix(a5)
	beq	.K0
	move.w	#$000f,$dff096
	sf	$59+KBMatrix(a5)
	btst	#bitNIGHT,GlobalFlags+1(a5)
	bne	.Loop
	moveq	#3,d2
.Loop2	bsr	WaitBOF
	bsr	WaitBOF
	bsr	FadeDown
	dbf	d2,.Loop2
.Loop	tst.b	$59+KBMatrix(a5)
	beq	.Loop
	move.w	DMAReg(a5),d0
	or.w	#$8000,d0
	move.w	d0,$dff096
	sf	$59+KBMatrix(a5)
	btst	#bitNIGHT,GlobalFlags+1(a5)
	bne	.Exit
	lea	DefaultPaletta(pc),a1
	bsr	SetCopPaletta
.Exit	rts	

* MusicOn/OFF (F9)
.K0	tst.b	$58+KBMatrix(a5)
	beq	.Exit
	sf	$58+KBMatrix(a5)
	bchg	#bitMUSICON,GlobalFlags(a5)
	beq	StartMainMusic
	move.w	#$0001,$dff096
	bclr	#0,DMAReg+1(a5)	
	clr.w	FxCounters(a5)
	rts
StartMainMusic
	MakeSpecialFx	MainFx,$dff0a0
	rts

***************************** COUNT 3-2-1 **********************
* Count 3-2-1 for start...
REG_Count321	equr	d2
Count321
	move.l	PlaneA(a5),a0
	bsr	ClearPlane
	move.l	PlaneC(a5),a0
	bsr	ClearPlane
	lea	DefaultPaletta(pc),a1
	clr.w	(a1)
	bsr	SetCopPaletta
	moveq	#3,REG_Count321
.Loop	lea	42*5*124+20,a1
	move.w	REG_Count321,d0
	moveq	#17,d1
	bsr	PrintDECNum
	move.w	#20,d0
	bsr	WaitX
	subq.w	#1,REG_Count321
	bne	.Loop
	bsr	ClearCopPaletta
	rts

*********************************** GAMBLING *****************************

GZOOM		EQU	5	;Gambling Player image zooming
GAMBLINGCOUNT	EQU	12	;Gambling count

REG_GBGuy	EQUR	d5
REG_GBMaxGuy	EQUR	d6
REG_GBMaxHeight	EQUR	d7

Gambling
	btst	#bitSHOP,GlobalFlags(a5)
	beq	.Exit
	btst	#bitGAMBLING,GlobalFlags(a5)
	beq	.Exit
	bsr	ClearAllPlanes
	lea	GamblingText(pc),a0
	lea	42*5*16+18,a1
	moveq	#17,d1
	bsr	PrintTextLinesA
	moveq 	#16,d0
	moveq 	#1,d1
	moveq 	#11,d2
	moveq 	#2,d3
	moveq 	#4,d4
	bsr	DrawBoxA
	moveq 	#11,d0
	moveq 	#7,d1
	moveq 	#GZOOM*4+1,d2
	moveq 	#GZOOM*3+1,d3
	moveq 	#14,d4
	bsr	DrawBoxA
	bsr	MakeGBImages
	move.w	d2,REG_GBMaxGuy
	mulu	#GZOOM*24,d2
	move.w	d2,REG_GBMaxHeight
	lea	DefaultPaletta(pc),a1
	move.w	#$303,(a1)
	bsr	SetCopPaletta
	bsr	InitGamblingBLT
	move.w	REG_GBMaxGuy,d0
	bsr	Random
	move.w	d0,REG_GBGuy
	mulu	#GZOOM*24,d0
	move.w	d0,d1
	moveq	#16,d0
	moveq	#0,d3
	moveq	#GAMBLINGCOUNT-1,d2
.loop2	bsr	WaitBOF
	bsr	ScrollGBArea
	add.w	d0,d1
	add.w	d0,d3
	cmp.w	#GZOOM*24,d3
	blo	.loop22
	MakeFx	GamblingFx
	sub.w	#GZOOM*24,d3
	addq.w	#1,REG_GBGuy
	cmp.w	REG_GBMaxGuy,REG_GBGuy
	bls	.loop22
	moveq	#1,REG_GBGuy
.loop22	subq.w	#1,d2
	bpl	.loop1
	moveq	#GAMBLINGCOUNT-1,d2
	subq.w	#1,d0
	bne	.loop1
	moveq	#1,d0
	tst.w	d3
	beq	.loop3
.loop1	cmp.w	REG_GBMaxHeight,d1
	blo	.loop2
	sub.w	REG_GBMaxHeight,d1
	bra	.loop2
.loop3	MakeFx	MoneyFx
	subq.w	#1,REG_GBGuy
	lsl.w	#2,REG_GBGuy
	lea	GBPlayers(a5),a0
	move.l	(a0,REG_GBGuy),a0
	addq.w	#1,plMoney(a0)
	moveq	#50,d0
	bsr	WaitX
	bsr	ClearCopPaletta
.Exit	rts

GamblingText
	dc.b	"GAMBLING",0
	even

InitGamblingBLT
	lea	$dff000,a6
.WBlt0	btst	#6,$2(a6)
	bne	.WBlt0
	move.l	#$09f00000,$40(a6)
	move.l	#$ffffffff,$44(a6)
	rts

* Speed=d0, offset=d1
ScrollGBArea
	movem.l	d0-d2,-(sp)
	lea	42*5*64+12,a0
	add.l	PlaneA(a5),a0
	move.l	PlaneB(a5),a1
	mulu	#GZOOM*4*5,d1
	add.l	d1,a1
	move.w	d0,d1
	mulu	#42*5,d0
	add.l	a0,d0
	move.w	#$8400,$96(a6)
.WBlt0	btst	#6,$2(a6)
	bne	.WBlt0
	move.w	#42-(GZOOM*4),$64(a6)
	move.w	#42-(GZOOM*4),$66(a6)
	movem.l	d0/a0,$50(a6)
	move.w	#GZOOM*24,d0
	sub.w	d1,d0
	move.w	d0,d2
	addq.w	#1,d0
	mulu	#5<<6,d0
	or.w	#(GZOOM*4)/2,d0
	move.w	d0,$58(a6)
	mulu	#42*5,d2
	add.l	d2,a0
	exg	a0,a1
	lsl.w	#6,d1
	or.w	#(GZOOM*4)/2,d1
.WBlt1	btst	#6,$2(a6)
	bne	.WBlt1
	move.w	#(GZOOM*4)*5-(GZOOM*4),$64(a6)
	move.w	#42*5-(GZOOM*4),$66(a6)
	bsr	.InsertNewPart
	bsr	.InsertNewPart
	bsr	.InsertNewPart
	bsr	.InsertNewPart
	bsr	.InsertNewPart
	move.w	#$400,$96(a6)
	movem.l	(sp)+,d0-d2
	rts

.InsertNewPart
	movem.l	a0/a1,$50(a6)
	move.w	d1,$58(a6)
	add.l	#GZOOM*4,a0
	add.l	#42,a1
.WBlt2	btst	#6,$2(a6)
	bne	.WBlt2
	rts

MakeGBImages
	move.l	BobData(a5),a0
	move.l	PlaneB(a5),a1
	lea	PlayersTB(a5),a3
	lea	GBPlayers(a5),a4
	moveq	#0,d1
	moveq	#0,d2
	moveq	#4,d0
.Loop	move.l	(a3)+,a2
	btst	#bitSELECTED,plFlags+2(a2)
	beq	.NextGuy
	move.l	a2,(a4)+
	bsr	ZoomGBFig
	addq.w	#1,d2
	lea	24*GZOOM*5*GZOOM*4(a1),a1
	tst.l	d1
	bne	.NextGuy
	move.l	a0,d1
.NextGuy
	add.l	#13800,a0
	dbf	d0,.Loop
	move.l	d1,a0
	bsr	ZoomGBFig
	rts

* FigImage=a0, DestAddr=a1
ZoomGBFig
	movem.l	d0-d2/a0-a4,-(sp)
	lea	42*5*128,a2
	add.l	PlaneC(a5),a2		;Temp Buffer
	moveq 	#22,d0
.Loop2 	move.l	0*40(a0),(a2)+
	move.l	1*40(a0),(a2)+
	move.l	2*40(a0),(a2)+
	move.l	3*40(a0),(a2)+
	move.l	4*40(a0),(a2)+
	add.l 	#40*5,a0
	dbf	d0,.Loop2
	moveq 	#GZOOM,d0
	moveq 	#GZOOM,d1
	moveq 	#2*5,d2
	moveq 	#23,d3
	lea	42*5*128,a0
	add.l	PlaneC(a5),a0
	bsr	Zoom
	movem.l	(sp)+,d0-d2/a0-a4
	rts
			
********************************* STANDINGS ******************************
Standings
	bsr	ClearAllPlanes
	lea	StandingText(pc),a0
	lea	42*5*0+16,a1
	moveq	#17,d1
	bsr	PrintTextLinesA
	lea	DefaultPaletta(pc),a1
	move.w	#$022,(a1)
	bsr	SetCopPaletta
	MakeFx	OlalaFx
	sub.l	a4,a4
	lea	PlayersTB(a5),a3
	move.w	WinnerIs(a5),d0
	beq	.NoWinner
	subq.w	#1,d0
	lsl.w	#2,d0
	move.l	(a3,d0.w),a4
	addq.w	#1,plWinTime(a4)
.NoWinner
	lea	42*5*16+0,a1	;First Guy PosY
	move.l	BobData(a5),a0
	moveq	#4,d0
.Loop	move.l	(a3)+,a2
	btst	#bitSELECTED,plFlags+2(a2)
	beq	.NoSel
	tst.w	TeamMode(a5)
	beq	.NoTeam
	move.l	a4,d1
	beq	.NoTeam
	cmp.l	a2,a4
	beq	.NoTeam
	move.b	plTeam(a4),d1
	cmp.b	plTeam(a2),d1
	bne	.NoTeam
	addq.w	#1,plWinTime(a2)
.NoTeam	bsr	BltCopyGuyA
	move.w	plWinTime(a2),d1
	beq	.NoWin
	cmp.w	WinsNeeded(a5),d1
	blt	.Loop1
	st	EndOfGame(a5)
.Loop1	movem.l	d0/a0-a2,-(sp)
	move.l	a1,a2
	bsr	InitCopyBlock
	add.w	#42*5*4+6,a1
	add.l	PlaneA(a5),a1
	moveq	#0,d2
.Loop2	move.l	a1,-(sp)
	moveq	#blSERLEG,d0
	bsr	CopyBlock
	move.w	d2,d0
	addq.w	#1,d0
	bsr	PrintWinNum
	MakeFx	CountFx
	bsr	WaitBOF
	bsr	WaitBOF
	move.l	(sp)+,a1
	addq.w	#2,a1
	addq.w	#1,d2
	cmp.w	d1,d2
	blo	.Loop2
	movem.l	(sp)+,d0/a0-a2
.NoWin	lea	42*5*32(a1),a1
.NoSel	lea	13800(a0),a0
	dbf	d0,.Loop
	move.w	#250,d0
	bsr	WaitX
	bsr	ClearCopPaletta
	rts

StandingText
	dc.b	"STANDINGS",0
	even

PrintWinNum
	movem.l	d0-d1/a2-a4,-(sp)
	lea	42*5*8+3(a2),a1
	moveq	#31,d1
	bsr	PrintDECNum
	movem.l	(sp)+,d0-d1/a2-a4
	rts
		
* GuyImage=a0, DestOffset=a1
BltCopyGuyA
	movem.l	d0-d1/a0-a1,-(sp)
	add.l	PlaneA(a5),a1
	bra	BltCopyGuy
BltCopyGuyB
	movem.l	d0-d1/a0-a1,-(sp)
	add.l	PlaneB(a5),a1
	bra	BltCopyGuy
BltCopyGuy
	lea	$dff000,a6
.WBlt	btst	#6,$2(a6)
	bne	.WBlt
	move.w	#40*5-4,$64(a6)
	move.w	#42*5-4,$66(a6)
	move.l	#$09f00000,$40(a6)
	move.l	#$ffffffff,$44(a6)
	move.w	#23<<6+2,d0
	moveq	#4,d1
.Loop	movem.l	a0/a1,$50(a6)
	move.w	d0,$58(a6)
	add.l	#40,a0
	add.l	#42,a1
.WBlt1	btst	#6,$2(a6)
	bne	.WBlt1
	dbf	d1,.Loop
	movem.l	(sp)+,d0-d1/a0-a1
	rts

************************ SHOW WINNER(S) *************************

REG_WinCount	EQUR	d7

ShowWinner
	bsr	ClearAllPlanes
	lea	PlayersTB(a5),a0
	sub.l	a1,a1
	moveq	#0,d1
	moveq	#4,d0
.Loop	move.l	(a0)+,a2
	btst	#bitSELECTED,plFlags+2(a2)
	beq	.Loop2
	cmp.w	plWinTime(a2),d1
	bge	.Loop2
	move.w	plWinTime(a2),d1
	move.l	a2,a1
.Loop2	dbf	d0,.Loop
	lea	WinPlayers(a5),a3
	move.l	a1,(a3)+
	moveq	#1,REG_WinCount
	tst.w	TeamMode(a5)
	beq	.NoTm
	lea	PlayersTB(a5),a0
	move.b	plTeam(a1),d1
	moveq	#4,d0
.Loop3	move.l	(a0)+,a2
	btst	#bitSELECTED,plFlags+2(a2)
	beq	.Loop4
	cmp.l	a1,a2
	beq	.Loop4
	cmp.b	plTeam(a2),d1
	bne	.Loop4
	move.l	a2,(a3)+
	addq.w	#1,REG_WinCount
.Loop4	dbf	d0,.Loop3
.NoTm	move.w	REG_WinCount,d0
	mulu	#2*4,d0
	move.w	#40,d1
	sub.w	d0,d1
	lsr.w	d1
	lea	42*5*80-2,a1
	add.w	d1,a1
	add.l	PlaneA(a5),a1
	lea	WinPlayers(a5),a0
	moveq	#0,d1
.Loop5	move.l	(a0)+,a2
	moveq	#0,d0
	move.b	plPlayerID(a2),d0
	subq.w	#1,d0
	mulu	#30,d0
	movem.l	d1/REG_WinCount/a0/a1,-(sp)
	move.l	PlaneB(a5),a0
	bsr	ClearPlane
	bsr	ZoomFigura
	movem.l	(sp)+,d1/REG_WinCount/a0/a1
	addq.w	#2*4,a1
	addq.w	#1,d1
	cmp.w	REG_WinCount,d1
	blo	.Loop5
	move.l	WinPlayers(a5),a1
	cmp.w	#1,REG_WinCount
	beq	.Loop6
	move.b	plTeam(a1),d0
	add.b	#'A',d0
	lea	WinTeam(pc),a0
	move.b	d0,(a0)
	lea	WinTeamText(pc),a0
	bra	.Loop7

.Loop6	lea	WinPlayer(pc),a0
	lea	plName(a1),a1
	moveq	#6,d0
.Loop8	move.b	(a1)+,(a0)+
	dbf	d0,.Loop8
	lea	WinPlayerText(pc),a0
.Loop7	moveq	#31,d1
	sub.l	a1,a1
	bsr	PrintTextLinesA
	lea	DefaultPaletta(pc),a1
	move.w	#$047,(a1)
	bsr	SetCopPaletta
	move.w	#350,d0
	bsr	WaitX
	bsr	ClearCopPaletta
	rts

WinPlayerText
	dc.b	"u11;16;"
WinPlayer
	dc.b	"xxxxxxx p8;IS THE WINNER!",0

WinTeamText
	dc.b	"u11;16;p8;TEAM p31;"
WinTeam	dc.b	"A p8;IS WINNER!",0
	even

**************************** LOAD DATAS *************************
* Load all of data from TFS file
LoadDatas
	move.w	#TBTITLE.RAW,a0
	move.l	PlaneB(a5),a1
	bsr	LoadFile
	move.l	PlaneB(a5),d0
	bsr	ShowJumpPic
	bsr	LoadSamples
	bsr	LoadSbk0
	move.w	#ENEMY.RAW,a0
	move.l	Enemy1Data(a5),a1
	bsr	LoadFile
	move.w	#TBOBJECTS.RAW,a0
	moveq 	#0,d0
	bsr	LoadData
	move.l	d0,ObjectsData(a5)
	move.l	#13800*6,d0
	moveq	#0,d1
	bsr	AllocMemBlock
	move.l	d0,BobData(a5)
	beq	.MError
	move.l	#2760*6,d0
	moveq	#0,d1
	bsr	AllocMemBlock
	move.l	d0,BobMask(a5)
	beq	.MError
	move.w	#GHOST.RAW,a0
	moveq	#0,d0
	bsr	LoadData
	move.l	d0,GhostImage(a5)
	move.w	#SETUP.RAW,a0
	moveq 	#1,d0
	bsr	LoadData
	move.l	d0,SetUpItems(a5)
	btst	#bitMUSICOK,SysFlags(a5)
	beq	.NoMemForMusic
	move.w	#TBMUSIC,a0
	moveq 	#1,d0
	bsr	LoadData
	move.l	d0,MusicData(a5)
	move.l	d1,MusicLength(a5)
.NoMemForMusic
	move.l	ExtTop(a5),LowExtMem(a5)
	move.l	LocTop(a5),LowLocMem(a5)
	lea	PlayersTB(a5),a0
	moveq	#4,d2
.Loop	move.l	(a0)+,a1
	moveq	#0,d0
	moveq	#0,d1
	move.b	plPlayerID(a1),d1
	move.b	plGuyImage(a1),d0
	subq.w	#1,d1
	movem.l	d2/a0,-(sp)
	bsr	LoadGuy
	movem.l	(sp)+,d2/a0
	dbf	d2,.Loop
	move.l	BobMask(a5),a1
	add.l	#5*2760,a1
	move.l	a1,PacManMask(a5)
	move.l	BobData(a5),a1
	add.l	#5*13800,a1
	move.l	a1,PacManData(a5)
	move.w	#PACMAN.RAW,a0
	bsr	LoadFile
	bsr	LoadAllSbk
	bsr	CheckPlayersSbk
	bsr	HideJumpPic
	rts

.MError	move.w	#$f0f,$dff180
	btst	#6,$bfe001
	bne	.MError
	BREAK_EXECUTE
	
* GuyID=d0, PlayerNr=d1
* LoadGuy, Loads the guy image into the area!

LoadGuy	mulu	#13800,d1
	move.l	BobData(a5),a1
	add.l	d1,a1
	add.w	d0,d0
	move.w	GuysData(pc,d0.w),a0
	bsr	LoadFile
	rts

GuysData
	dc.w	ASTRO.RAW,BABY.RAW,BARTSIMPSON.RAW,CHINESE.RAW,COOLGUY.RAW
	dc.w	CRAZYGUY.RAW,DEVIL.RAW,DIVER.RAW,DOCTOR.RAW,DRACULA.RAW
	dc.w	FRANKY.RAW,KING.RAW,MARTIAN.RAW,MUMMY.RAW,NINJA.RAW,PEASANT.RAW
	dc.w	POLICEMAN.RAW,ROBINHOOD.RAW,SOLDIER.RAW,TARZAN.RAW,WORKER.RAW

* Load all of samples & setup the VBI counter
LoadSamples
	lea	SampleNames(pc),a1
	lea	SampleInfo(a5),a2
	moveq	#MAXSAMPLES-1,d2
.loop	move.w	(a1)+,a0
	moveq	#0,d0
	movem.l	d2/a1-a2,-(sp)
	bsr	LoadData
	movem.l	(sp)+,d2/a1-a2
	move.l	d0,(a2)+
	lsr.l	d1
	move.w	d1,(a2)+
	dbf	d2,.loop
	lea	SampleInfo(a5),a2
	lea	SamplesDefStr(pc),a0
	lea	SamplesDefEnd(pc),a1
	bsr	SetSampleRate
	rts

;Info=a2, start=a0, end=a1
SetSampleRate
	sub.w	#eiSIZEOF,a2
.loop2	move.w	fxRate(a0),d1
	bmi	.loop3
	moveq	#0,d0
	move.b	fxSample(a0),d0
	mulu	#eiSIZEOF,d0
	mulu	eiLength(a2,d0.w),d1
	divu	#10000,d1
	move.w	d1,fxRate(a0)
.loop3	addq.w	#fxSIZEOF,a0
	cmp.l	a1,a0
	blo	.loop2
	rts
	
SampleNames
	dc.w	BOMB.SPL
	dc.w	BINGO.SPL
	dc.w	BINGO22.SPL
	dc.w	INGAME.SPL
;	dc.w	HI.SPL
	dc.w	ALARM.SPL
	dc.w	EFFECT.SPL
	dc.w	BUBBLE.SPL
	dc.w	WARP.SPL
;	dc.w	GO.SPL
	dc.w	BURP.SPL
	dc.w	MONEY.SPL
	dc.w	TELEPORT.SPL
;	dc.w	THIEF.SPL
	dc.w	COUNT.SPL
;	dc.w	DAME.SPL
;	dc.w	HEY.SPL

************************************
CheckPlayersSbk
	lea	PlayersTB(a5),a1
	moveq	#4,d1
.Loop	move.l	(a1)+,a2
	btst	#bitPASSOK,SysFlags+1(a5)
	beq	.Error
	move.w	plSbk(a2),d0
	beq	.Loop3
	mulu	#MAXBANKFX*eiSIZEOF,d0
	lea	Bank0Info(a5),a0
	add.w	d0,a0
	moveq	#MAXBANKFX-1,d0
.Loop2	tst.l	(a0)
	beq	.Error
	addq.w	#eiSIZEOF,a0
	dbf	d0,.Loop2
	bra	.Loop3
.Error	clr.w	plSbk(a2)
.Loop3	dbf	d1,.Loop
	rts

LoadSbk0
	lea	Bank0Name(pc),a0
	lea	Bank0Info(a5),a1
	lea	Bank0Fx(a5),a2
	bsr	LoadSampleBank
	tst.l	d0
	beq	.Error
	move.l	a2,a0
	moveq	#MAXBANKFX-1,d0
.Loop	add.b	#BANKFXSTART,fxSample(a2)
	add.w	#fxSIZEOF,a2
	dbf	d0,.Loop
	lea	MAXBANKFX*fxSIZEOF(a0),a1
	lea	SampleInfo(a5),a2
	bsr	SetSampleRate
	rts

.Error	move.w	#$00f,$dff180
	btst	#6,$bfe001
	bne	.Error
	BREAK_EXECUTE

Bank0Name
	DEFSBKNAME
	even

LoadAllSbk
	lea	Bank1Info(a5),a0
	move.w	#(eiSIZEOF*MAXBANKFX*5)/2-1,d0
.Loop1	clr.w	(a0)+
	dbf	d0,.Loop1
	lea	Bank1Fx(a5),a0
	move.w	#(fxSIZEOF*MAXBANKFX*5)/2-1,d0
.Loop11	clr.w	(a0)+
	dbf	d0,.Loop11
	move.l	LowLocMem(a5),LocTop(a5)
	lea	Bank1Name(a5),a0
	lea	Bank1Info(a5),a1
	lea	Bank1Fx(a5),a2
	moveq	#BANKFXSTART+MAXBANKFX,d2
	moveq	#4,d3
.Loop	tst.b	(a0)
	beq	.Loop3
	bsr	CheckDisk
	bsr	LoadSampleBank
	tst.l	d0
	beq	.Loop3
	move.l	a2,a3
	moveq	#MAXBANKFX-1,d0
.Loop2	add.b	d2,fxSample(a3)
	add.w	#fxSIZEOF,a3
	dbf	d0,.Loop2
	movem.l	a0/a1/a2,-(sp)
	move.l	a2,a0
	lea	MAXBANKFX*fxSIZEOF(a0),a1
	lea	SampleInfo(a5),a2
	bsr	SetSampleRate
	movem.l	(sp)+,a0/a1/a2
.Loop3	addq.w	#MAXBANKFX,d2
	add.w	#16,a0
	add.w	#eiSIZEOF*MAXBANKFX,a1
	add.w	#fxSIZEOF*MAXBANKFX,a2
	dbf	d3,.Loop
	rts
									
******************************* LOAD SampleBank
;Name=a0, Info=a1, FxDef=a2
REG_InfoSave	equr	d6
REG_DefSave	equr	d7

LoadSampleBank
	movem.l	d2-d7/a0-a4,-(sp)
	move.l	a1,REG_InfoSave
	move.l	a2,REG_DefSave
	bsr	OpenSbkFile
	move.l	d0,TFSHandler(a5)
	beq	.Exit
	cmp.l	#MAXBANKFX+1,SBHeader+4(a5)
	bhi	.Error
	sub.l	a0,a0
	move.l	REG_DefSave,a1
	pea	SBHeader+8(a5)
	move.l	(sp)+,d0
	bsr	ReadTFSData
	tst.l	d0
	beq	.Error
	move.l	REG_InfoSave,a3
	moveq	#1,d5
.Loop	move.w	d5,a0
	pea	SBHeader+8(a5)
	move.l	(sp)+,d0
	bsr	GetTFSDataSize
	tst.l	d0
	beq	.Error
	moveq	#0,d1
	bsr	AllocMemBlock
	move.l	d0,(a3)+
	beq	.Error
	move.w	d5,a0
	move.l	d0,a1
	pea	SBHeader+8(a5)
	move.l	(sp)+,d0
	bsr	ReadTFSData
	tst.l	d0
	beq	.Error
	lsr.l	d0
	move.w	d0,(a3)+
	addq.w	#1,d5
	cmp.w	#MAXBANKFX+1,d5
	bne	.Loop
	bsr	CloseSbkFile
.Exit	movem.l	(sp)+,d2-d7/a0-a4
	rts

.Error	bsr	CloseSbkFile
	moveq	#0,d0
	bra	.Exit

OpenSbkFile
	move.l	a0,-(sp)
	bsr	SwitchSysON
	st	MotorFlag(a5)	
	move.l	(sp)+,a0
	lea	SBHeader(a5),a1
	bsr	OpenTFSFile
	move.l	d0,-(sp)
	bsr	SwitchSysOFF
	move.l	(sp)+,d0
	rts

CloseSbkFile
	bsr	SwitchSysON
	st	MotorFlag(a5)
	move.l	TFSHandler(a5),d1
	bsr	CloseTFSFile
	bsr	SwitchSysOFF
	rts

***************************** Misc Blitter procedures
ClearAllPlanes
	move.l	PlaneA(a5),a0
	bsr	ClearPlane
	move.l	PlaneB(a5),a0
	bsr	ClearPlane
	move.l	PlaneC(a5),a0

ClearPlane
	lea	$dff000,a6
.WBlt 	btst	#6,$2(a6)
	bne	.WBlt
	clr.w 	$66(a6)
	move.l	#$01000000,$40(a6)
	move.l	a0,$54(a6)
	bra	BltAllPlanes

CopyToBkg
	move.l	PlaneC(a5),a1
	lea	$dff000,a6
.WBlt 	btst	#6,$2(a6)
	bne	.WBlt
	move.l	#$09f00000,$40(a6)
	move.l	#$ffffffff,$44(a6)
	clr.l 	$64(a6)
	movem.l	a0/a1,$50(a6)
BltAllPlanes
	move.w	#(256*3)<<6+21,$58(a6)
.WBlt2	btst	#6,$2(a6)
	bne	.WBlt2
	move.w	#(256*2)<<6+21,$58(a6)
.WBlt3	btst	#6,$2(a6)
	bne	.WBlt3
	rts

;figuranb=d0,temp1=a0,(temp2=a2),dest=a1
FZOOMX	EQU	3
FZOOMY	EQU	3
ZoomFigura
	move.l	PlaneC(a5),a2
	movem.l	a0/a1,-(sp)
	move.l	a2,a1
	lsl.w 	#2,d0
	lea	BobOffsets(a5),a0
	moveq 	#0,d1
	move.w	2(a0,d0.w),d1
	move.l	BobData(a5),a0
	add.l 	d1,a0
	moveq 	#22,d0
.Loop 	move.l	0*40(a0),(a1)+
	move.l	1*40(a0),(a1)+
	move.l	2*40(a0),(a1)+
	move.l	3*40(a0),(a1)+
	move.l	4*40(a0),(a1)+
	add.l 	#40*5,a0
	dbf	d0,.Loop
	move.l	(sp),a1
	move.l	a2,a0
	moveq 	#FZOOMX,d0
	moveq 	#FZOOMY,d1
	moveq 	#2*5,d2
	moveq 	#23,d3
	bsr	Zoom
	movem.l	(sp)+,a0/a1
	move.w	#$8dfc,$40(a6)
	move.w	#$ffff,$46(a6)
	move.w	#FZOOMX*4*5-FZOOMX*4,$64(a6)
	move.w	#42*5-FZOOMX*4,$62(a6)
	move.w	#42*5-FZOOMX*4,$66(a6)
	moveq 	#4,d0
.Loop2	move.l	a1,$4c(a6)
	movem.l	a0/a1,$50(a6)
	move.w	#(23*FZOOMY)<<6+FZOOMX*2,$58(a6)
	add.l 	#FZOOMX*4,a0
	add.l 	#42,a1
.WBlt 	btst	#6,$2(a6)
	bne	.WBlt
	dbf	d0,.Loop2
	rts
**
** ZOOM routin V1.0 - Ez egy Univerzalis ZOOM rutin 1:16 aranyban nagyithat!
** Belepes :	D0 = X ZOOM (min=1, max=16)
** 	D1 = Y ZOOM ( ----''----- )
** 	D2 = Wordok szam egy sorban!
** 	D3 = Sorok szama!
** 	A0 = SRC
** 	A1 = DEST
**
**

REG_Words	equr	d7
REG_PlotMask	equr	d6
REG_Lines	equr	d5
REG_BitCount	equr	d4
REG_PWord	equr	d3
REG_Shift	equr	d2
REG_DestMOD 	equr	d1
REG_PenWidth	equr	a2
REG_BltSize 	equr	a3
REG_Dest 	equr	a4

pMasks	dc.w	%1000000000000000
	dc.w	%1100000000000000
	dc.w	%1110000000000000
	dc.w	%1111000000000000
	dc.w	%1111100000000000
	dc.w	%1111110000000000
	dc.w	%1111111000000000
	dc.w	%1111111100000000
	dc.w	%1111111110000000
	dc.w	%1111111111000000
	dc.w	%1111111111100000
	dc.w	%1111111111110000
	dc.w	%1111111111111000
	dc.w	%1111111111111100
	dc.w	%1111111111111110
	dc.w	%1111111111111111

;zoomx=d0,zoomy=d1,words=d2,lines=d3,src=a0,dest=a1
Zoom	move.w	d0,REG_PenWidth
	move.w	d2,REG_Words
	move.w	d3,REG_Lines
	move.l	a1,REG_Dest
	add.w 	d0,d0
	move.w	pMasks-2(pc,d0.w),REG_PlotMask
	move.w	REG_PenWidth,d0
	mulu	d2,d0
	add.l 	d0,d0
	move.w	d0,d2
	mulu	d1,d2
	lsl.w 	#6,d1
	add.w 	#2,d1
	move.w	d1,REG_BltSize
	lea	$dff000,a6
.WBlt 	btst	#6,$2(a6)
	bne	.WBlt
	clr.w 	$42(a6)
	move.l	#$ffff0000,$44(a6)
	subq.w	#4,d0
	move.w	d0,$62(a6)
	move.w	d0,$66(a6)
	move.l	d2,REG_DestMOD
	subq.w	#1,REG_Words
	subq.w	#1,REG_Lines
.Loop1	moveq 	#0,REG_Shift
	move.l	REG_Dest,a1
	move.w	REG_Words,-(sp)
.Loop2	move.w	(a0)+,REG_PWord
	moveq 	#15,REG_BitCount
.Loop 	moveq 	#0,d0
	add.w 	REG_PWord,REG_PWord
	bcc	.Null
	move.w	REG_PlotMask,d0
.Null 	move.w	d0,$74(a6)
	move.w	REG_Shift,d0
	ror.w 	#4,d0
	or.w	#$05fc,d0
	move.w	d0,$40(a6)
	move.l	a1,$4c(a6)
	move.l	a1,$54(a6)
	move.w	REG_BltSize,$58(a6)
.WBlt2	btst	#6,$2(a6)
	bne	.WBlt2
	add.w 	REG_PenWidth,REG_Shift
	cmp.w 	#15,REG_Shift
	ble	.A
	and.w 	#15,REG_Shift
	addq.w	#2,a1
.A 	dbf	REG_BitCount,.Loop
	dbf	REG_Words,.Loop2
	move.w	(sp)+,REG_Words
	add.l 	REG_DestMOD,REG_Dest
	dbf	REG_Lines,.Loop1
	rts

;****************** ITEM Manager
ITEM_JOY1	EQU	0
ITEM_JOY2	EQU	1
ITEM_JOY3	EQU	2
ITEM_JOY4	EQU	3
ITEM_KEYB	EQU	4
ITEM_PSELECT	EQU	5
ITEM_POFFMASK	EQU	6
ITEM_MOPTION	EQU	7
ITEM_PNAME	EQU	8
ITEM_PLAYEROFF	EQU	9
ITEM_GO		EQU	10
ITEM_MENU	EQU	11
ITEM_ITEMS	EQU	12
ITEM_SETUP	EQU	13
ITEM_CANCEL 	EQU	14
ITEM_OKAY 	EQU	15
ITEM_ITEMSET	EQU	16
ITEM_MONEYL 	EQU	17
ITEM_MONEYM 	EQU	18
ITEM_MONEYR 	EQU	19
ITEM_LEDA	EQU	20
ITEM_LEDB	EQU	21
ITEM_LEDMASK	EQU	22
ITEM_RDBLANK	EQU	23
ITEM_RDDOWN	EQU	24
ITEM_RDRIGHT	EQU	25
ITEM_RDUP	EQU	26
ITEM_RDLEFT	EQU	27
ITEM_RDFIRE	EQU	28
ITEM_RDICON	EQU	29
ITEM_RDMASK	EQU	30
ITEM_ITEMOFF 	EQU	31
ITEM_SAVE	EQU	32
ITEM_REQUESTER	EQU	33
ITEM_BANKEDIT	EQU	34
ITEM_BANKID	EQU	35
ITEM_BANKNAME	EQU	36
ITEM_LOAD	EQU	37

ITEM_END 	EQU	-1

ItemsParamList
	dc.w	  0/8,  0, 48/16,52	;ITEM JOY1
	dc.w	 48/8,  0, 48/16,52	;ITEM JOY2
	dc.w	 96/8,  0, 48/16,52	;ITEM JOY3
	dc.w	144/8,  0, 48/16,52	;ITEM JOY4
	dc.w	192/8,  0, 48/16,52	;ITEM KEYB
	dc.w	240/8,  0, 48/16,52	;ITEM PLAYER SELECT
	dc.w	288/8,  0, 48/16,52	;ITEM PLAYER OFF MASK
	dc.w	  0/8, 52,208/16,15	;ITEM MENU OPTION
	dc.w	208/8, 52,112/16,15	;ITEM PLAYER NAME
	dc.w	320/8, 53, 16/16,13	;ITEM PLAYER OFF BUTTON
	dc.w	  0/8, 67, 48/16,41	;ITEM GO
	dc.w	 48/8, 67, 48/16,41	;ITEM MENU
	dc.w	 96/8, 67, 48/16,41	;ITEM ITEMS
	dc.w	144/8, 67, 48/16,41	;ITEM PLAYERSETUP BUTTON
	dc.w	192/8, 67, 48/16,41	;ITEM CANCEL BUTTON
	dc.w	240/8, 67, 48/16,41	;ITEM OK BUTTON
	dc.w	288/8, 67, 48/16,39	;ITEM ITEMSET
	dc.w	288/8, 67, 16/16,39	;ITEM MONEY L
	dc.w	304/8, 67, 16/16,39	;ITEM MONEY M
	dc.w	320/8, 67, 16/16,39	;ITEM MONEY R
	dc.w	304/8,107, 16/16,13	;ITEM LED TEAM A
	dc.w	320/8,107, 16/16,13	;ITEM LED TEAM B
	dc.w	304/8,120, 16/16,13	;ITEM LED MASK
	dc.w	  0/8,217, 32/16,23	;ITEM REDEFINE KEY BLANK
	dc.w	 32/8,217, 32/16,23	;ITEM REDEFINE KEY DOWN
	dc.w	 64/8,217, 32/16,23	;ITEM REDEFINE KEY RIGHT
	dc.w	 96/8,217, 32/16,23	;ITEM REDEFINE KEY UP
	dc.w	128/8,217, 32/16,23	;ITEM REDEFINE KEY LEFT
	dc.w	160/8,217, 32/16,23	;ITEM REDEFINE KEY FIRE
	dc.w	192/8,217, 32/16,23	;ITEM REDEFINE KEY ICON
	dc.w	224/8,217, 32/16,23	;ITEM REDEFINE KEY MASK
	dc.w	208/8,176, 16/16,16	;ITEM ITEM OFF MASK
	dc.w	  0/8,108, 48/16,41	;ITEM SAVE CONFIGURATION
	dc.w	 48/8,108,144/16,86	;ITEM REQUESTER "WINDOW"
	dc.w	  0/8,149, 48/16,41	;ITEM SAMPLE BANK EDIT
	dc.w	272/8,217, 32/16,23	;ITEM SAMPLE BANK ID
	dc.w	  0/8,240,224/16,15	;ITEM SAMPLE BANK NAME
	dc.w	240/8,108, 48/16,41	;ITEM LOAD SAMPLE BANK
		
; In:  DestX=d1, DestY=d2, PlanePtr=a0
; Out: Shift=d3, DestAddr=a0

DestAddr
	moveq 	#$f,d3
	and.w 	d1,d3
	mulu	#42*5,d2
	lsr.w 	#3,d1
	bclr	#0,d1
	ext.l 	d1
	add.l 	d1,d2
	add.l 	d2,a0
	ror.w 	#4,d3
	rts

; In:  ItemDef=a2, DestWidth=d2, BltShift=d3
; Out: Modulo=d2, ItemAddr=d0, ItemBltWidth=d1, BltAMask=d4

ItemMOD	move.w	(a2)+,d0
	move.w	(a2)+,d1
	mulu	#42*5,d1
	ext.l 	d0
	add.l 	d1,d0
	add.l 	PlaneB(a5),d0
	move.w	(a2)+,d1
	add.w 	d1,d1
	moveq	#-1,d4
	tst.w	d3
	beq	.A
	addq.w	#2,d1
	clr.w	d4
.A	sub.w 	d1,d2
	lsr.w	d1
	rts

;itemnum=d0, destx=d1, desty=d2, planeptr=a0
DrawItem
	movem.l	d0-d4/a0/a2,-(sp)
	lsl.w 	#3,d0
	lea	ItemsParamList(pc),a2
	add.w 	d0,a2
	lea	$dff000,a6
.WBlt 	btst	#6,$2(a6)
	bne	.WBlt
	bsr	DestAddr
	move.w	#42,d2
	bsr	ItemMOD
	move.w	d2,$64(a6)
	move.w	d2,$66(a6)
	move.w	(a2),d2
	mulu	#5,d2
	lsl.w 	#6,d2
	or.w	d2,d1
	or.w	#$09f0,d3
	swap	d3
	move.l	d3,$40(a6)
	move.l	d4,$44(a6)
	movem.l	d0/a0,$50(a6)
	move.w	d1,$58(a6)
	movem.l	(sp)+,d0-d4/a0/a2
	rts

;itemnum(mask)=d0, destx=d1, desty=d2, planeptr=a0
MaskItem
	movem.l	d0-d4/a0/a2,-(sp)
	lsl.w 	#3,d0
	lea	ItemsParamList(pc),a2
	add.w 	d0,a2
	lea	$dff000,a6
.WBlt 	btst	#6,$2(a6)
	bne	.WBlt
	bsr	DestAddr
	move.w	#42*5,d2
	bsr	ItemMOD
	move.w	d2,$60(a6)
	move.w	d2,$62(a6)
	move.w	d2,$64(a6)
	move.w	d2,$66(a6)
	move.w	(a2),d2
	move.w	#42*4,a2
	add.l	d0,a2		;Mask address!
	bra	MaskAny

* GuyNum=d0, destx=d1, desty=d2, planeptr=a0

GuyDEF	dc.w	0, 194, 16/16,23

DrawGuy	movem.l	d0-d4/a0/a2,-(sp)
	lea	GuyDef(pc),a2
	add.w	d0,d0
	move.w	d0,(a2)
	lea	$dff000,a6
.WBlt 	btst	#6,$2(a6)
	bne	.WBlt
	bsr	DestAddr
	move.w	#42*5,d2
	bsr	ItemMOD
	move.w	d2,$60(a6)
	move.w	d2,$62(a6)
	move.w	d2,$64(a6)
	move.w	d2,$66(a6)
	move.w	(a2),d2
	lea	217*42*5+32,a2
	add.l	PlaneB(a5),a2
MaskAny	lsl.w 	#6,d2
	or.w	d2,d1
	move.w	d3,$42(a6)
	or.w	#$0fca,d3
	move.w	d3,$40(a6)
	move.l	d4,$44(a6)
	move.l	a2,d2
	bsr	.BltMask
	bsr	.BltMask
	bsr	.BltMask
	bsr	.BltMask
	bsr	.BltMask
	movem.l	(sp)+,d0-d4/a0/a2
	rts

.BltMask
	lea	$48(a6),a2
	move.l	a0,(a2)+
	move.l	d0,(a2)+
	move.l	d2,(a2)+
	move.l	a0,(a2)+
	move.w	d1,(a2)
	add.l	#42,a0
	add.l	#42,d0
.WBlt	btst	#6,$2(a6)
	bne	.WBlt
	rts
		
;itemslist=a0
DrawAllItems
	move.l	a0,a2
	move.l	PlaneA(a5),a0
.Loop 	movem.w	(a2),d0/d1/d2
	cmp.w 	#ITEM_END,d0
	beq	.Exit
	add.w 	#3*2,a2
	bsr	DrawItem
	bra	.Loop
.Exit 	rts

; ************** TEXTPRINT manager

FMOD	EQU	74	;Font modulo!

;textdata=a0, printoffset=a1
PrintTextLinesA
	move.l	PlaneA(a5),a2
;textdata=a0, printoffset=a1, bitplane=a2
PrintTextLines
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	d1,d2
	move.l	a1,d3
	divu	#42*5,d3
	swap	d3
	ext.l 	d3
.Loop1	move.b	(a0)+,d0
	beq	.EndOfLine
	cmp.b 	#'p',d0
	beq	.ChgPen
	cmp.b 	#'t',d0
	beq	.DoTab
	cmp.b 	#'u',d0
	beq	.DoPosi
	cmp.b 	#'w',d0
	beq	.InsBlock
	cmp.b 	#$a,d0
	beq	.Newline
	cmp.b 	#$20,d0
	blt	.Loop1
	move.b	d2,d1
	bsr	PrintTChar
	addq.l	#1,a1
	addq.l	#1,d3
.Loop3	cmp.l 	#42,d3
	blt	.Loop1
.NewLine
	sub.l 	d3,a1
	add.l 	#42*5*8,a1
	moveq 	#0,d3
	bra	.Loop1
.ChgPen	bsr	GetDECNumber
	move.l	d0,d2
	bra	.Loop1
.DoTab	moveq 	#12,d0
.Loop2	cmp.b 	.TxTabs(pc,d0.w),d3
	blt	.GetTabpos
	dbf	d0,.Loop2
	bra	.NewLine
.GetTabPos
	sub.l 	d3,a1
	move.b	.TxTabs(pc,d0.w),d3
	add.l 	d3,a1
	bra	.Loop1
.DoPosi	bsr	GetDECNumber
	move.l	d0,d3
	bsr	GetDECNumber
	mulu	#42*5,d0
	add.l 	d3,d0
	move.l	d0,a1
	bra	.Loop1
.InsBlock
	move.b	(a0)+,d0
	movem.l	a0-a1,-(sp)
	bsr	InitCopyBlock
	move.l	a1,d1
	sub.l 	#42*5*4,d1
	bclr	#0,d1
	move.l	d1,a1
	add.l 	a2,a1
	ext.w 	d0
	bsr	CopyBlock
	movem.l	(sp)+,a0-a1
	addq.l	#2,d3
	addq.l	#2,a1
	bra	.Loop3

.EndOfLine
	movem.l	(sp)+,d0-d7/a0-a6
	rts

.TxTabs	dc.b	13*3,12*3,11*3,10*3,9*3,8*3,7*3,6*3,5*3,4*3,3*3,2*3,1*3
	even

GetDECNumber
	moveq 	#0,d0
.Loop 	moveq 	#0,d1
	move.b	(a0),d1
	beq	.Exit
	addq.w	#1,a0
	sub.b 	#$30,d1
	cmp.b 	#';'-$30,d1
	beq	.Exit
	cmp.b 	#$9,d1
	bhi	.Exit
	mulu	#10,d0
	add.l 	d1,d0
	bra	.Loop
.Exit 	rts

;char=d0, pen=d1, printoffset=a1, bitplane=a2
PrintTChar
	movem.l	d2/a2/a3/a4,-(sp)
	lea	Font-$20(pc),a3
	ext.w 	d0
	add.w 	d0,a3
	move.l	a2,a4
	move.l	PlaneC(a5),a2
	add.l 	a1,a4
	add.l 	a1,a2
	moveq 	#4,d0
.Loop1	move.w	d0,-(sp)
	moveq 	#7,d0
.Loop 	move.b	(a3),d2
	not.b 	d2
	and.b 	(a2),d2
	move.b	d2,(a4)
	btst	#0,d1
	beq	.Loop2
	move.b	(a3),d2
	or.b	d2,(a4)
.Loop2	add.l 	#FMOD,a3
	add.l 	#42*5,a2
	add.l 	#42*5,a4
	dbf	d0,.Loop
	move.w	(sp)+,d0
	lsr.b 	d1
	sub.l 	#8*FMOD,a3
	sub.l 	#42*5*8-42,a2
	sub.l 	#42*5*8-42,a4
	dbf	d0,.Loop1
	movem.l	(sp)+,d2/a2/a3/a4
	rts

;char =d0, OptionsTab=a1
PrintPointer
	move.w	OPNumber(a5),d1
	lsl.w 	#2,d1
	move.l	(a1,d1.w),a1
	move.l	PlaneA(a5),a2
	moveq 	#31,d1
	bsr	PrintTChar
	rts

;char=d0, pen=d1, printoffset=a1
PrintAChar
	move.l	PlaneA(a5),a2
	bra	PrintTChar

* DecNum=d0.w, pen=d1, printoffset=a1
PrintDECNum
	movem.l	d2/d3,-(sp)
	move.w	d1,d2
	ext.l 	d0
	divu	#10,d0
	add.l 	#$00300030,d0
	cmp.b 	#$30,d0
	bne	.A
	move.w	#$20,d0
.A 	move.l	d0,d3
	bsr	PrintAChar
	addq.l	#1,a1
	swap	d3
	move.w	d2,d1
	move.w	d3,d0
	bsr	PrintAChar
	moveq 	#$20,d0
	addq.l	#1,a1
	bsr	PrintAChar
	movem.l	(sp)+,d2/d3
	rts

bxUL	equ	'`'
bxUR	equ	'a'
bxDL	equ	'b'
bxDR	equ	'c'
bxUPPER	equ	'd'
bxLOWER	equ	'e'
bxLEFT	equ	'f'
bxRIGHT	equ	'g'
bxPOINTER equ	'h'
bxCURSOR equ	'@'

;leftedge=d0, topedge=d1, width=d2, height=d3, pen=d4
DrawBoxA
	movem.l	d5-d7/a2,-(sp)
	move.l	PlaneA(a5),a2
	mulu	#42*5*8,d1
	move.w	d0,a1
	add.l 	d1,a1
	move.w	d4,d1
	moveq 	#bxUL,d0
	bsr	PrintTChar
	addq.l	#1,a1
	move.w	d2,d5
	subq.w	#2,d5
.Loop1	moveq 	#bxUPPER,d0
	move.w	d4,d1
	bsr	PrintTChar
	addq.l	#1,a1
	dbf	d5,.Loop1
	move.w	d4,d1
	moveq 	#bxUR,d0
	bsr	PrintTChar
	add.w 	#42*5*8,a1
	move.w	d3,d5
	subq.w	#2,d5
.Loop2	moveq 	#bxRIGHT,d0
	move.w	d4,d1
	bsr	PrintTChar
	add.l 	#42*5*8,a1
	dbf	d5,.Loop2
	moveq 	#bxDR,d0
	move.w	d4,d1
	bsr	PrintTChar
	subq.l	#1,a1
	move.w	d2,d5
	subq.w	#2,d5
.Loop3	moveq 	#bxLOWER,d0
	move.w	d4,d1
	bsr	PrintTChar
	subq.w	#1,a1
	dbf	d5,.Loop3
	moveq 	#bxDL,d0
	move.w	d4,d1
	bsr	PrintTChar
	sub.l 	#42*5*8,a1
	move.w	d3,d5
	subq.w	#2,d5
.Loop4	moveq 	#bxLEFT,d0
	move.w	d4,d1
	bsr	PrintTChar
	sub.l 	#42*5*8,a1
	dbf	d5,.Loop4
	movem.l	(sp)+,d5-d7/a2
	rts

; ------------------------------------

;optionsdef=a0, dirbits=d0 (Ha d0=0 akkor -) set current option!)
MarkOption
	move.l	(a0)+,a1
	btst	#bitDown,d0
	bne	.A
	addq.w	#4,a0
	btst	#bitRight,d0
	bne	.A
	addq.w	#4,a0
	btst	#bitUp,d0
	bne	.A
	addq.w	#4,a0
	btst	#bitLeft,d0
	bne	.A
	move.w	OPNumber(a5),d1
	bra	.B

.A 	move.l	(a0),a0
	move.w	OPNumber(a5),d0
	move.b	(a0,d0.w),d1
	bmi	.Exit
	ext.w 	d1
	move.w	d1,OPNumber(a5)
.B 	lsl.w 	#2,d1
	movem.w	(a1,d1.w),d0/d1
	bsr	SetPointerPos
.Exit 	rts

;*************************** MAIN MENU
MainMenuItems
	dc.w	ITEM_MOPTION,68,27
	dc.w	ITEM_MOPTION,68,43
	dc.w	ITEM_MOPTION,68,59
	dc.w	ITEM_MOPTION,68,75
	dc.w	ITEM_MOPTION,68,91
	dc.w	ITEM_MOPTION,68,107
	dc.w	ITEM_MOPTION,68,123
	dc.w	ITEM_MOPTION,68,139
	dc.w	ITEM_MOPTION,68,155
	dc.w	ITEM_MOPTION,68,171
	dc.w	ITEM_MOPTION,68,187
	
	dc.w	ITEM_SETUP,32,215
	dc.w	ITEM_GO,148,215
	dc.w	ITEM_ITEMS,266,215
	dc.w	ITEM_SAVE,96,215
	dc.w	ITEM_BANKEDIT,200,215
	dc.w	ITEM_END

OptionsText2
	dc.b	"p31;u15;12;MAIN SETUP :p8;"
	dc.b	"u11;031;HARD BRICK"
	dc.b	"u11;047;WINS NEEDED"
	dc.b	"u11;063;GHOSTS"
	dc.b	"u11;079;SHOP"
	dc.b	"u11;095;SHRINKING"
	dc.b	"u11;111;START MONEY"
	dc.b	"u11;127;LEVEL"
	dc.b	"u11;143;GAMBLING"
	dc.b	"u11;159;TIME LIMIT"
	dc.b	"u11;175;TEAM MODE"
	dc.b	"u11;191;FAST IGNIT"
	dc.b	0
	even

MainOptions
	dc.l	.OpPointerPos
	dc.l	.OpDown
	dc.l	.OpRight
	dc.l	.OpUp
	dc.l	.OpLeft

.OpPointerPos
	dc.w	158, 35 ;constant brick
	dc.w	158, 51	;options
	dc.w	158, 67
	dc.w	158, 83
	dc.w	158, 99
	dc.w	158,115
	dc.w	158,131
	dc.w	158,147
	dc.w	158,163
	dc.w	158,179
	dc.w	158,195
	dc.w	 51,235	;setup
	dc.w	116,235	;save
	dc.w	167,235	;go
	dc.w	220,235	;bankedit
	dc.w	286,235	;items

.OpDown	dc.b	 1, 2, 3, 4, 5, 6, 7, 8, 9,10,13,-1,-1,-1,-1,-1
.OpRight
	dc.b	-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,12,13,14,15,-1
.OpUp 	dc.b	-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,10,10,10,10
.OpLeft	dc.b	-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,11,12,13,14
	even

LoadSetUpItemsToPlaneB
	move.l	SetUpItems(a5),a0
	move.l	PlaneB(a5),a1
	move.w	#(42*256*5/4)-1,d0
.Loop	move.l	(a0)+,(a1)+
	dbf	d0,.Loop
	rts
	
MainSetUp
	bsr	ClearCopPaletta
	bsr	LoadSetUpItemsToPlaneB
	move.l	SetUpItems(a5),a0
	bsr	InitPointer
MainSetUpAgain
	move.l	PlaneA(a5),a0
	bsr	ClearPlane
	lea	MainMenuItems(pc),a0
	bsr	DrawAllItems
	move.l	PlaneA(a5),a0
	bsr	CopyToBkg
	lea	OptionsText2(pc),a0
	sub.l 	a1,a1
	bsr	PrintTextLinesA
	bsr	PrintCurrentOptions
	move.w	#13,OPNumber(a5)
	lea	MainOptions(pc),a0
	moveq 	#0,d0
	bsr	MarkOption
	lea	DefaultPaletta(pc),a1
	move.w	#$aaa,(a1)
	bsr	SetCopPaletta
	clr.b 	OPLastStick(a5)
SetUpLoop
	bsr	WaitBOF
	tst.b 	$45+KBMatrix(a5)
	bne	.Exit
	moveq 	#1,d0
	bsr	ReadNrmJoystick
	btst	#bitFire,d0
	bne	.Selected
	cmp.b 	OPLastStick(a5),d0
	beq	SetUpLoop
	move.b	d0,OPLastStick(a5)
	btst	#bitLeft,d0
	bne	.OPLeft
	btst	#bitRight,d0
	bne	.OPRight
	btst	#bitUp,d0
	bne	.OPUp
	btst	#bitDown,d0
	bne	.OPDown
	bra	SetUpLoop

.OPLeft	cmp.w 	#11,OPNumber(a5)
	blt	.Options
.OPDown
.OPUp
.NewOption
	lea	MainOptions(pc),a0
	bsr	MarkOption
	bra	SetUpLoop

.OPRight
	cmp.w 	#10,OPNumber(a5)
	bgt	.NewOption

.Options
	move.w	OPNumber(a5),d1
	lsl.w 	#2,d1
	jsr	.OPJump(pc,d1.w)
	bra	SetUpLoop

.OPJump	bra.w	SetBrick
	bra.w 	SetWins
	bra.w 	SetGhosts
	bra.w 	SetShop
	bra.w 	SetShrink
	bra.w 	SetMoney
	bra.w 	SetLevel
	bra.w 	SetGambling
	bra.w	SetTimeLimit
	bra.w	SetTeamMode
	bra.w	SetFastIg

.Selected
	cmp.w	#12,OPNumber(a5)
	bne	.Wait5
.Wait6	btst	#7,$bfe001
	beq	.Wait6
	bsr	SaveConfig
	lea	MainOptions(pc),a0
	moveq 	#0,d0
	bsr	MarkOption
	bra	SetUpLoop
.Wait5	cmp.w 	#13,OPNumber(a5)
	beq	.Wait
	cmp.w	#15,OPNumber(a5)
	bne	.Wait3
.Wait4	btst	#7,$bfe001
	beq	.Wait4
	bsr	ItemSetUpMain
	cmp.w	#26,OPNumber(a5)
	beq	.Wait
	cmp.w	#24,OpNumber(a5)
	beq	.Wait2
	bra	.MSetUp
.Wait3	cmp.w 	#11,OPNumber(a5)
	bne	.Wait7
.Wait2	btst	#7,$bfe001
	beq	.Wait2
	bsr	PlayersSetUp
	cmp.w 	#35,OPNumber(a5)
	bne	.Wait
.MSetUp	bsr	ClearCopPaletta
	bra	MainSetUpAgain
.Wait7	cmp.w	#14,OPNumber(a5)
	bne	SetUpLoop
.Wait8	btst	#7,$bfe001
	beq	.Wait8
	bsr	SBankSetUpMain
	cmp.w	#10,OPNumber(a5)
	beq	.Wait2
	cmp.w	#13,OPNumber(a5)
	beq	.MSetUp
	cmp.w	#12,OPNumber(a5)
	bne	SetUpLoop
	
.Wait 	btst	#7,$bfe001
	beq	.Wait
.Exit 	rts

SetBrick
	btst	#bitLeft,d0
	bne	.DecBrick
	cmp.w	#5,Brick(a5)
	beq	OPReturn
	tst.w	Brick(a5)
	bne	.A
	lea	RanClr(pc),a0
	lea	42*5*31+23,a1
	bsr	PrintOptz
.A	addq.w	#1,Brick(a5)
	bra	PrintBrickNum
.DecBrick
	tst.w	Brick(a5)
	beq	OPReturn
	subq.w	#1,Brick(a5)
PrintBrickNum
	lea	RanText(pc),a0
	lea	42*5*31+23,a1
	move.w	Brick(a5),d0
	beq	PrintOptz
PrintOptionNum
	moveq	#1,d1
	bsr	PrintDECNum
OPReturn
	rts

SetWins	btst	#bitLeft,d0
	bne	.DecWins
	cmp.w 	#18,WinsNeeded(a5)
	beq	OPReturn
	addq.w	#1,WinsNeeded(a5)
	bra	PrintWinsNeeded
.DecWins
	cmp.w 	#1,WinsNeeded(a5)
	beq	OPReturn
	subq.w	#1,WinsNeeded(a5)
PrintWinsNeeded
	move.w	WinsNeeded(a5),d0
	lea	42*5*47+23,a1
	bra	PrintOptionNum

SetGhosts
	btst	#bitLeft,d0
	bne	.DecGhosts
	cmp.w 	#4,GhostsNb(a5)
	beq	OPReturn
	addq.w	#1,GhostsNb(a5)
	bra	PrintGhostsNb
.DecGhosts
	tst.w 	GhostsNb(a5)
	beq	OPReturn
	subq.w	#1,GhostsNb(a5)
PrintGhostsNb
	move.w	GhostsNb(a5),d0
	lea	42*5*63+23,a1
	beq	PrintOptionNo
	bra	PrintOptionNum

SetMoney
	btst	#bitLeft,d0
	bne	.DecMoney
	cmp.w 	#12,StartMoney(a5)
	beq	OPReturn
	addq.w	#1,StartMoney(a5)
	bra	PrintStartMoney
.DecMoney
	tst.w 	StartMoney(a5)
	beq	OPReturn
	subq.w	#1,StartMoney(a5)
PrintStartMoney
	lea	42*5*111+23,a1
	move.w	StartMoney(a5),d0
	beq	PrintOptionNo
	bra	PrintOptionNum

SetLevel
	btst	#bitLeft,d0
	bne	.DecLevel
	cmp.w 	#lcRANDOM,LevelCode(a5)
	beq	OPReturn
	addq.w	#1,LevelCode(a5)
	bra	PrintLevelCode
.DecLevel
	tst.w 	LevelCode(a5)
	beq	OPReturn
	subq.w	#1,LevelCode(a5)
PrintLevelCode
	move.w	LevelCode(a5),d0
	add.w 	d0,d0
	lea	LTypes(pc),a0
	add.w 	(a0,d0.w),a0
	lea	42*5*127+23,a1
	bra	PrintOptz

LTypes	dc.w	NorText-LTypes
	dc.w	MadText-LTypes
	dc.w	NowText-LTypes
	dc.w	RanText-LTypes

NorText	dc.b	"NORMAL  ",0
MadText	dc.b	"MAD     ",0
NowText	dc.b	"NO WALLS",0
RanText	dc.b	"RANDOM  ",0

RanClr	dc.b	"        ",0
	even

SetShop	moveq	#bitSHOP,d1
 	lea	42*5*79+23,a1
	bra	SetOptionFlag

SetShrink
	moveq	#bitSHRINKING,d1
 	lea	42*5*95+23,a1
	bra	SetOptionFlag

SetGambling
	moveq	#bitGAMBLING,d1
 	lea	42*5*143+23,a1
	bra	SetOptionFlag

SetTimeLimit
	moveq	#bitTIMELIMIT,d1
	lea	42*5*159+23,a1
	bra	SetOptionFlag

SetFastIg
	moveq	#bitFASTIG,d1
	lea	42*5*191+23,a1
	bra	SetOptionFlag
	
SetTeamMode
	btst	#bitLeft,d0
	bne	.DecTeam
	cmp.w 	#2,TeamMode(a5)
	beq	OPReturn
	addq.w	#1,TeamMode(a5)
	bra	PrintTeamMode
.DecTeam
	tst.w 	TeamMode(a5)
	beq	OPReturn
	subq.w	#1,TeamMode(a5)
PrintTeamMode
	lea	42*5*175+23,a1
	move.w	TeamMode(a5),d0
	beq	PrintOptionNo
	bra	PrintOptionNum
	
PrintCurrentOptions
	bsr	PrintBrickNum
	bsr	PrintWinsNeeded
	bsr	PrintGhostsNb
	bsr	PrintStartMoney
	bsr	PrintLevelCode
	bsr	PrintTeamMode
	lea	42*5*79+23,a1
	moveq	#bitSHOP,d1
	bsr	PrintOptionFlag
	lea	42*5*95+23,a1
	moveq	#bitSHRINKING,d1
	bsr	PrintOptionFlag
	lea	42*5*143+23,a1
	moveq	#bitGAMBLING,d1
	bsr	PrintOptionFlag
	lea	42*5*159+23,a1
	moveq	#bitTIMELIMIT,d1
	bsr	PrintOptionFlag
	moveq	#bitFASTIG,d1
	lea	42*5*191+23,a1
	bsr	PrintOptionFlag
	rts

SetOptionFlag
	bclr	d1,GlobalFlags(a5)
	btst	#bitLeft,d0
	bne	PrintOptionFlag
	bset	d1,GlobalFlags(a5)
PrintOptionFlag
	lea	YesText(pc),a0
	btst	d1,GlobalFlags(a5)
	bne	PrintOptz
PrintOptionNo
	lea	NoText(pc),a0
PrintOptz
 	moveq 	#1,d1
	bsr	PrintTextLinesA
	rts

YesText	dc.b	"YES",0
NoText	dc.b	"NO ",0
	even

;********************************* Edit sound banks
SBankSetUpItems
	dc.w	ITEM_BANKNAME,60,76+0
	dc.w	ITEM_BANKNAME,60,76+24
	dc.w	ITEM_BANKNAME,60,76+48
	dc.w	ITEM_BANKNAME,60,76+72
	dc.w	ITEM_BANKNAME,60,76+96
	dc.w	ITEM_SETUP,32,215
	dc.w	ITEM_GO,148,215
	dc.w	ITEM_MENU,266,215
	dc.w	ITEM_LOAD,96,215
	dc.w	ITEM_END

SBankSetUpText
	dc.b	"p31;u12;32;SAMPLE BANK SETUP :"
	dc.b	"p8;u10;64;Nu18;64;NAME"
	dc.b	"p3;u10;080;1"
	dc.b	"p3;u10;104;2"
	dc.b	"p3;u10;128;3"
	dc.b	"p3;u10;152;4"
	dc.b	"p3;u10;176;5"
	dc.b	"u11;192;BUFFER SIZE:"
	dc.b	"u18;200;FREE:"
	dc.b	0
	even

SBankOptions
	dc.l	.OpPointerPos
	dc.l	.OpDown
	dc.l	.OpRight
	dc.l	.OpUp
	dc.l	.OpLeft

.OpPointerPos
	dc.w	220, 85+0  ;bank #1
	dc.w	246, 85+0
	dc.w	220, 85+24 ;bank #2
	dc.w	246, 85+24
	dc.w	220, 85+48 ;bank #3
	dc.w	246, 85+48
	dc.w	220, 85+72 ;bank #4
	dc.w	246, 85+72
	dc.w	220, 85+96 ;bank #5
	dc.w	246, 85+96

	dc.w	 51,235	;setup
	dc.w	116,235	;load
	dc.w	167,235	;go
	dc.w	286,235	;menu

.OpDown	dc.b	 2, 3, 4, 5, 6, 7, 8, 9,12,12,-1,-1,-1,-1
.OpRight
	dc.b	 1,-1, 3,-1, 5,-1, 7,-1, 9,-1,11,12,13,-1
.OpUp 	dc.b	-1,-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8
.OpLeft	dc.b	-1, 0,-1, 2,-1, 4,-1, 6,-1, 8,-1,10,11,12
	even

SBankSetUpMain
	bsr	ClearCopPaletta
	move.l	PlaneA(a5),a0
	bsr	ClearPlane
	lea	SBankSetUpItems(pc),a0
	bsr	DrawAllItems
	move.l	PlaneA(a5),a0
	bsr	CopyToBkg
	bsr	PrintBankNames
	bsr	PrintBufSize
	lea	SBankSetUpText(pc),a0
	sub.l 	a1,a1
	bsr	PrintTextLinesA
	move.w	#12,OPNumber(a5)
	lea	SBankOptions(pc),a0
	moveq 	#0,d0
	bsr	MarkOption
	lea	DefaultPaletta(pc),a1
	move.w	#$aaa,(a1)
	bsr	SetCopPaletta
	clr.b 	OPLastStick(a5)
SBankSetUpLoop
	bsr	WaitBOF
	tst.b 	$45+KBMatrix(a5)
	bne	.Exit
	moveq 	#1,d0
	bsr	ReadNrmJoystick
	btst	#bitFire,d0
	bne	.Selected
	cmp.b 	OPLastStick(a5),d0
	beq	SBankSetUpLoop
	move.b	d0,OPLastStick(a5)
	lea	SBankOptions(pc),a0
	bsr	MarkOption
	bra	SBankSetUpLoop

.Selected
	cmp.w	#11,OPNumber(a5)
	bne	.Wait2
.Wait1	btst	#7,$bfe001
	beq	.Wait1
	bsr	LoadAllBanks
	moveq	#0,d0
	lea	SBankOptions(pc),a0
	bsr	MarkOption
	bra	SBankSetUpLoop

.Wait2	cmp.w	#10,OPNumber(a5)
	bge	.Wait
	bsr	EditBankName
	bra	SBankSetUpLoop

.Wait	btst	#7,$bfe001
	beq	.Wait
.Exit	rts

LoadAllBanks
	lea	LoadText(pc),a0
	moveq	#1,d0
	bsr	DoRequester
	tst.w	d0
	beq	.Exit
	btst	#bitPASSOK,SysFlags+1(a5)
;	tst.w	PRFlag(a5)
	beq	.Exit
	clr.w	PRFlag(a5)
	move.w	#$0020,$dff096
	bsr	DrawReqBack
	lea	LoadingText(pc),a0
	sub.l	a1,a1
	bsr	PrintReqText
	bsr	LoadAllSbk
	bsr	CheckPlayersSbk
	bsr	RestoreReqBack
	bsr	PrintBufSize
	move.w	#$8020,$dff096
.Exit	rts

LoadText
	dc.b	"u16;106;p12;LOAD SAMPLE"
	dc.b	"u19;114;BANKS ?",0
LoadingText
	dc.b	"u15;114;p12;LOADING ...",0
	even

EditBankName
	move.w	OPNumber(a5),d2
	lsr.w	d2
	bcs	.Delete
	lea	Bank1Name(a5),a0
	moveq	#12,d0
	moveq	#80,d1
	move.w	d2,d3
	mulu	#24,d2
	lsl.w	#4,d3
	add.w	d3,a0
	add.w	d2,d1
	mulu	#42*5,d1
	ext.l	d0
	add.l	d0,d1
	move.l	d1,a1
	move.l	a0,d3
.Loop	tst.b	(a0)+
	bne	.Loop
	exg	d3,a0
	sub.l	a0,d3
	subq.l	#1,d3
	moveq	#15,d5
	bsr	EnterString
	tst.w	d3
	beq	.NoSpc
.Trim	cmp.b	#$20,-1(a0,d3.w)
	bne	.NoSpc
	subq.w	#1,d3
	bne	.Trim
.NoSpc	clr.b	(a0,d3.w)
	rts

.Delete	lea	Bank1Name(a5),a0
	moveq	#12,d0
	moveq	#80,d1
	move.w	d2,d3
	mulu	#24,d2
	lsl.w	#4,d3
	add.w	d3,a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	add.w	d2,d1
	mulu	#42*5,d1
	ext.l	d0
	add.l	d0,d1
	move.l	d1,a1
	lea	EmptyString(pc),a0
	moveq	#0,d1
	bsr	PrintTextLinesA
	rts		

EmptyString
	dc.b	"               ",0
	even

PrintBankNames
	lea	Bank1Name(a5),a0
	moveq	#12,d0
	moveq	#80,d1
	moveq	#4,d2
.Loop	movem.l	d0-d2/a0,-(sp)
	mulu	#42*5,d1
	add.l	d0,d1
	move.l	d1,a1
	moveq	#2,d1
	bsr	PrintTextLinesA
	movem.l	(sp)+,d0-d2/a0
	add.w	#24,d1
	add.w	#16,a0
	dbf	d2,.Loop
	rts

PrintBufSize
	move.l	#$20202020,-(sp)
	move.l	#$20202000,-(sp)
	lea	7(sp),a0
	move.l	MaxLocMem(a5),d0
	sub.l	LowLocMem(a5),d0
	bsr	BinToAsciiLong
	lea	23+42*5*192,a1
	move.l	sp,a0
	moveq	#31,d1
	bsr	PrintTextLinesA
	addq.w	#8,sp
	move.l	#$20202020,-(sp)
	move.l	#$20202000,-(sp)
	lea	7(sp),a0
	move.l	MaxLocMem(a5),d0
	sub.l	LocTop(a5),d0
	bsr	BinToAsciiLong
	lea	23+42*5*200,a1
	move.l	sp,a0
	moveq	#31,d1
	bsr	PrintTextLinesA
	addq.w	#8,sp
	rts
	
; Buffer+places=a0, long=d0
BinToAsciiLong
	move.l	d0,d1
	clr.w	d1
	swap	d1
	divu	#10,d1
	move.w	d0,d2
	move.w	d1,d0
	move.w	d2,d1
	swap	d0
	divu	#10,d1
	move.w	d1,d0
	swap	d1
	add.b	#$30,d1
	move.b	d1,-(a0)
	tst.l	d0
	bne	BinToAsciiLong
	rts
			
;********************************* Save configuration

CFGSIZE	EQU	11+16*5+23+5*16+5
WAITDOS	EQU	400

SaveConfig
	lea	SaveText(pc),a0
	moveq	#1,d0
	bsr	DoRequester
	tst.w	d0
	beq	.Exit
	btst	#bitPASSOK,SysFlags+1(a5)
;	tst.w	PRFlag(a5)
	beq	.Exit
	clr.w	PRFlag(a5)
	bsr	DrawReqBack
	lea	SavingText(pc),a0
	sub.l	a1,a1
	bsr	PrintReqText
	bsr	SetCfgBuffer
	bsr	SwitchSysOn
	move.w	#$0020,$dff096
	CallSys	Permit
	move.w	#WAITDOS,d0
	bsr	WaitX
	move.l	#CfgName,d1
	move.l	#MODE_NEWFILE,d2
	CallDos	Open
	tst.l	d0
	beq	.OpnError
	move.l	d0,d4
	move.l	d0,d1
	pea	CfgBuffer(a5)
	move.l	(sp)+,d2
	move.l	#CFGSIZE,d3
	jsr	Write(a6)
	move.l	d0,d5
	move.l	d4,d1
	jsr	Close(a6)
	move.w	#WAITDOS,d0
	bsr	WaitX
	CallSys	Forbid
	bsr	SwitchSysOff
	bsr	RestoreReqBack
	move.w	#$8020,$dff096
	cmp.l	#CFGSIZE,d5
	bne	.WrError
.Exit	rts

.OpnError
	jsr	IoErr(a6)
	move.l	d0,-(sp)
	move.w	#WAITDOS,d0
	bsr	WaitX
	CallSys	Forbid
	bsr	SwitchSysOff
	bsr	RestoreReqBack
	move.w	#$8020,$dff096
	move.l	(sp)+,d0
	lea	DiskWProtText(pc),a0
	cmp.l	#214,d0
	beq	.ShowIOErrText
	lea	DiskFullText(pc),a0
	cmp.l	#221,d0
	beq	.ShowIOErrText
	lea	NoDiskText(pc),a0
	cmp.l	#226,d0
	beq	.ShowIOErrText
	lea	DosErrCode(pc),a2
	bsr	BinToASCII
	lea	DosIOErrText(pc),a0
.ShowIOErrText
	moveq	#0,d0
	bsr	DoRequester
	rts
			
.WrError
	lea	WriteErrorText(pc),a0
	moveq	#0,d0
	bsr	DoRequester
	rts
	
CfgName	CFGFILENAME

DiskWProtText
	dc.b	"u13;106;p12; DISK IS WRITE"
	dc.b	"u13;114;p12;tPROTECTED!",0

DiskFullText
	dc.b	"u13;106;p12;tDISK FULL!",0
NoDiskText
	dc.b	"u13;106;p12;t NO DISK"
	dc.b	"u13;114;p12;t IN DRIVE",0

DosIOErrText
	dc.b	"u13;106;p12; DOS I/O ERROR"
	dc.b	"u13;114;p12;tt#"
DosErrCode
	dc.b	"xxx",0

WriteErrorText
	dc.b	"u13;106;p12;  WRITE ERROR!",0
SaveText
	dc.b	"u13;106;p12;tSAVE CONFIG?",0
SavingText
	dc.b	"u13;114;p12;tSAVING ...",0
	even

********************************************
SetCfgBuffer
	lea	CfgBuffer(a5),a4
	move.l	#'TB10',(a4)+
	move.b	Brick+1(a5),(a4)+
	move.b	WinsNeeded+1(a5),(a4)+
	move.b	GhostsNb+1(a5),(a4)+
	move.b	StartMoney+1(a5),(a4)+
	move.b	LevelCode+1(a5),(a4)+
	move.b	TeamMode+1(a5),(a4)+
	move.b	GlobalFlags(a5),(a4)+
	lea	PlayersTB(a5),a0
	moveq	#4,d0
.Loop	move.l	(a0)+,a1
	btst	#bitSELECTED,plFlags+2(a1)
	sne	(a4)+
	move.b	plGuyImage(a1),(a4)+
	move.b	plControl(a1),(a4)+
	move.b	plSbk+1(a1),(a4)+
	lea	plKeyboard(a1),a2
	moveq	#4,d1
.Loop2	move.b	(a2)+,(a4)+
	dbf	d1,.Loop2
	moveq	#7,d1
.Loop3	move.b	(a1)+,(a4)+
	dbf	d1,.Loop3
	dbf	d0,.Loop
	lea	Bank1Name(a5),a0
	moveq	#(5*16)-1,d0
.Loop5	move.b	(a0)+,(a4)+
	dbf	d0,.Loop5
	lea	AjandekTB(pc),a0
	moveq	#ajnb-1,d0
.Loop4	move.b	1(a0),(a4)+
	addq.w	#2,a0
	dbf	d0,.Loop4
	rts

*****************************************************
SetConfig
	lea	CfgBuffer(a5),a4
	cmp.l	#'TB10',(a4)+
	bne	.Exit
	move.b	(a4)+,Brick+1(a5)
	move.b	(a4)+,WinsNeeded+1(a5)
	move.b	(a4)+,GhostsNb+1(a5)
	move.b	(a4)+,StartMoney+1(a5)
	move.b	(a4)+,LevelCode+1(a5)
	move.b	(a4)+,TeamMode+1(a5)
	move.b	(a4)+,GlobalFlags(a5)
	lea	PlayersTB(a5),a0
	moveq	#4,d0
.Loop	move.l	(a0)+,a1
	bclr	#bitSELECTED,plFlags+2(a1)
	tst.b	(a4)+
	beq	.Loop5
	bset	#bitSELECTED,plFlags+2(a1)
.Loop5	move.b	(a4)+,plGuyImage(a1)
	move.b	(a4)+,plControl(a1)
	move.b	(a4)+,plSbk+1(a1)
	lea	plKeyboard(a1),a2
	moveq	#4,d1
.Loop2	move.b	(a4)+,(a2)+
	dbf	d1,.Loop2
	moveq	#7,d1
.Loop3	move.b	(a4)+,(a1)+
	dbf	d1,.Loop3
	dbf	d0,.Loop
	lea	Bank1Name(a5),a0
	moveq	#(5*16)-1,d0
.Loop6	move.b	(a4)+,(a0)+
	dbf	d0,.Loop6
	lea	AjandekTB(pc),a0
	moveq	#ajnb-1,d0
.Loop4	move.b	(a4)+,1(a0)
	addq.w	#2,a0
	dbf	d0,.Loop4
.Exit	rts
	
********************************* Load configuration
LoadConfig
	btst	#bitPASSOK,SysFlags+1(a5)
	beq	.Exit
	bsr	SwitchSysOn
	move.l	#CfgName,d1
	move.l	#MODE_OLDFILE,d2
	CallDos	Open
	tst.l	d0
	beq	.OpnError
	move.l	d0,d4
	move.l	d0,d1
	pea	CfgBuffer(a5)
	move.l	(sp)+,d2
	move.l	#CFGSIZE,d3
	jsr	Read(a6)
	move.l	d0,d5
	move.l	d4,d1
	jsr	Close(a6)
	bsr	SwitchSysOff
	cmp.l	#CFGSIZE,d5
	bne	.Exit
	bsr	SetConfig
.Exit	rts

.OpnError
	bsr	SwitchSysOff
	rts
	
;******************************** Requester manager
; Button=DoRequester(text=a0, buttonflag=d0)
REQX	EQU	96
REQY	EQU	85

REG_ButtonFlag	equr	d7

DoRequester
	movem.l	d0/a0,-(sp)
	bsr	DrawReqBack
	move.l	(sp)+,d0
	tst.w	d0
	bne	.BothButton
	moveq	#ITEM_OKAY,d0
	move.w	#REQX+48,d1
	move.w	#REQY+41,d2
	move.l	PlaneA(a5),a0
	bsr	DrawItem
	moveq	#0,REG_ButtonFlag
	bra	.DZText
.BothButton
	moveq	#ITEM_OKAY,d0
	move.w	#REQX+16,d1
	move.w	#REQY+41,d2
	move.l	PlaneA(a5),a0
	bsr	DrawItem
	moveq	#ITEM_CANCEL,d0
	move.w	#REQX+80,d1
	move.w	#REQY+41,d2
	bsr	DrawItem
	moveq	#1,REG_ButtonFlag
.DZText	move.l	(sp)+,a0
	sub.l	a1,a1
	bsr	PrintReqText
	move.w	OPNumber(a5),-(sp)
	move.w	REG_ButtonFlag,d0
	lsl.w	#2,d0
	lea	ReqButtonTab(pc),a0
	move.l	(a0,d0.w),-(sp)
	move.w	REG_ButtonFlag,OPNumber(a5)
	move.l	(sp),a0
	moveq	#0,d0
	bsr	MarkOption		
	clr.b 	OPLastStick(a5)
	clr.w	PRFlag(a5)
ReqMainLoop2
	pea	PRText(pc)
	move.l	(sp)+,PRPtr(a5)
ReqMainLoop
	bsr	WaitBOF
	tst.b	$45+KBMatrix(a5)
	bne	.ReqCancel
;	tst.b	$44+KBMatrix(a5)
;	bne	.ReqOk
	moveq 	#1,d0
	bsr	ReadNrmJoystick
	btst	#bitFire,d0
	bne	.Selected
	cmp.b 	OPLastStick(a5),d0
	beq	.ReqPRPass
	move.b	d0,OPLastStick(a5)
	move.l	(sp),a0
	bsr	MarkOption
;	bra	ReqMainLoop
.ReqPRPass
	move.b	KBLastk(a5),d0
	beq	ReqMainLoop
	clr.b	KBLastk(a5)
	move.l	PRPtr(a5),a0
	cmp.b	(a0),d0
	bne	ReqMainLoop2
	addq.l	#1,PRPtr(a5)
	cmp.b	#$d,d0
	bne	ReqMainLoop
	st	PRFlag(a5)
	move.l	#10000,d0
.PLoop	move.w	d0,$dff180
	subq.l	#1,d0
	bne	.PLoop
	bra	ReqMainLoop
.ReqCancel
	clr.b	$45+KBMatrix(a5)
	moveq	#0,REG_ButtonFlag
	bra	.ReqEnd
.ReqOk	clr.b	$4+KBMatrix(a5)
	moveq	#1,REG_ButtonFlag
	bra	.ReqEnd
.Selected
	move.w	OPNumber(a5),REG_ButtonFlag
.Wait	btst	#7,$bfe001
	beq	.Wait
.ReqEnd	addq.w	#4,sp
	move.w	(sp)+,OPNumber(a5)
	bsr	RestoreReqBack
	move.w	REG_ButtonFlag,d0
	bchg	#0,d0
	rts
		
ReqButtonTab
	dc.l	OneButton, TwoButtons

OneButton
	dc.l	.OpPointerPos
	dc.l	.OpDown
	dc.l	.OpRight
	dc.l	.OpUp
	dc.l	.OpLeft

.OpPointerPos
	dc.w	REQX+68, REQY+61 ;ok button

.OpDown	dc.b	-1
.OpRight
	dc.b	-1
.OpUp 	dc.b	-1
.OpLeft	dc.b	-1
	even

TwoButtons
	dc.l	.OpPointerPos
	dc.l	.OpDown
	dc.l	.OpRight
	dc.l	.OpUp
	dc.l	.OpLeft

.OpPointerPos
	dc.w	REQX+40,  REQY+61 ;cancel button
	dc.w	REQX+104, REQY+61 ;ok button

.OpDown	dc.b	-1,-1
.OpRight
	dc.b	 1,-1
.OpUp 	dc.b	-1,-1
.OpLeft	dc.b	-1, 0
	even

PRText	PRPASSCODE	;a protection kodja...
	even

PrintReqText
	move.l	PlaneC(a5),-(sp)
	move.l	PlaneA(a5),PlaneC(a5)
	bsr	PrintTextLinesA
	move.l	(sp)+,PlaneC(a5)
	rts
		
DrawReqBack
	move.l	PlaneC(a5),a1
	lea	REQX/8+REQY*42*5,a0
	add.l	PlaneA(a5),a0
	bsr	WaitBOF
	bsr	CopyReqBlock
	moveq	#ITEM_REQUESTER,d0
	move.w	#REQX,d1
	move.w	#REQY,d2
	move.l	PlaneA(a5),a0
	bsr	DrawItem
	rts

RestoreReqBack
	move.l	PlaneC(a5),a0
	lea	REQX/8+REQY*42*5,a1
	add.l	PlaneA(a5),a1
	bsr	WaitBOF
	bsr	CopyReqBlock
	rts

CopyReqBlock
	lea	$dff000,a6
.WBlt	btst	#6,$2(a6)
	bne	.WBlt
	move.l	#$09f00000,$40(a6)
	move.l	#$ffffffff,$44(a6)
	move.w	#42-18,$64(a6)
	move.w	#42-18,$66(a6)
	movem.l	a0/a1,$50(a6)
	move.w	#(86*5)<<6+9,$58(a6)
.WBlt2	btst	#6,$2(a6)
	bne	.WBlt2
	rts
				
;******************************** ITEM SET UP
ItemSetUpItems
	dc.w	ITEM_SETUP,32,215
	dc.w	ITEM_GO,148,215
	dc.w	ITEM_MENU,266,215
	dc.w	ITEM_END

ItemOptions
	dc.l	.OpPointerPos
	dc.l	.OpDown
	dc.l	.OpRight
	dc.l	.OpUp
	dc.l	.OpLeft

.OpPointerPos
	dc.w	 56,72
	dc.w	 88,72
	dc.w	120,72
	dc.w	152,72
	dc.w	184,72
	dc.w	216,72
	dc.w	248,72
	dc.w	280,72

	dc.w	 56,104
	dc.w	 88,104
	dc.w	120,104
	dc.w	152,104
	dc.w	184,104
	dc.w	216,104
	dc.w	248,104
	dc.w	280,104

	dc.w	 56,136
	dc.w	 88,136
	dc.w	120,136
	dc.w	152,136
	dc.w	184,136
	dc.w	216,136
	dc.w	248,136
	dc.w	280,136
	
	dc.w	 51,235	;setup
	dc.w	286,235	;menu
	dc.w	167,235	;go

.OpDown	dc.b	 8, 9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,26,26,26,26,26,26,26,26,-1,-1,-1
.OpRight
	dc.b	 1, 2, 3, 4, 5, 6, 7,-1, 9,10,11,12,13,14,15,-1,17,18,19,20,21,22,23,-1,26,-1,25
.OpUp	dc.b	-1,-1,-1,-1,-1,-1,-1,-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,23,19
.OpLeft	dc.b	-1, 0, 1, 2, 3, 4, 5, 6,-1, 8, 9,10,11,12,13,14,-1,16,17,18,19,20,21,22,-1,26,24
	even

ItemSetUpText
	dc.b	"p31;u15;12;ITEM SETUP :",0
	even

ItemSetUpMain
	bsr	ClearCopPaletta
	move.l	PlaneA(a5),a0
	bsr	ClearPlane
	lea	ItemSetUpItems(pc),a0
	bsr	DrawAllItems
	bsr	DrawGameItems
	move.l	PlaneA(a5),a0
	bsr	CopyToBkg
	lea	ItemSetUpText(pc),a0
	sub.l 	a1,a1
	bsr	PrintTextLinesA
	moveq 	#5,d0
	moveq 	#6,d1
	moveq 	#31,d2
	moveq 	#12,d3
	moveq 	#27,d4
	bsr	DrawBoxA
	moveq 	#5,d0
	moveq 	#20,d1
	moveq 	#31,d2
	moveq 	#2,d3
	moveq 	#26,d4
	bsr	DrawBoxA
	move.w	#26,OPNumber(a5)
	lea	ItemOptions(pc),a0
	moveq 	#0,d0
	bsr	MarkOption
	lea	DefaultPaletta(pc),a1
	move.w	#$aaa,(a1)
	bsr	SetCopPaletta
	clr.b 	OPLastStick(a5)
ItemSetUpLoop
	bsr	WaitBOF
	tst.b 	$45+KBMatrix(a5)
	bne	.Exit
	moveq 	#1,d0
	bsr	ReadNrmJoystick
	btst	#bitFire,d0
	bne	.Selected
	cmp.b 	OPLastStick(a5),d0
	beq	ItemSetUpLoop
	move.b	d0,OPLastStick(a5)
	beq	ItemSetUpLoop
	lea	ItemOptions(pc),a0
	bsr	MarkOption
	bsr	PrintItemName
	bra	ItemSetUpLoop

.Selected
	cmp.w	#24,OPNumber(a5)
	bge	.Wait
	bsr	UpdateGameItemNum
	bra	ItemSetUpLoop

.Wait	btst	#7,$bfe001
	beq	.Wait
.Exit	rts

UpdateGameItemNum
	cmp.w	#23,OPNumber(a5)
	beq	.Exit
	btst	#bitLeft,d0
	bne	.GoUp
	btst	#bitRight,d0
	bne	.GoDown
	rts

.GoUp	bsr	AddItemNums
	cmp.w	#MAXAJ,d0
	bhs	.Exit
	lea	AjandekTB(pc),a0
	move.w	OPNumber(a5),d0
	add.w	d0,d0
	add.w	d0,a0
	addq.b	#1,1(a0)
	cmp.b	#1,1(a0)
	bne	.Update
	move.b	(a0),-(sp)
	bsr	InitCopyBlock
	bsr	GetItemCoord
	moveq	#0,d0
	move.b	(sp)+,d0
	mulu	#5*42,d2
	move.l	d2,a1
	lsr.w	#3,d1
	add.w	d1,a1
	add.l	PlaneA(a5),a1
	move.l	a0,-(sp)
	bsr	CopyBlock
	move.l	(sp)+,a0
.Update	moveq	#0,d0
	move.b	1(a0),d0
	clr.l	-(sp)
	move.l	sp,a2
	bsr	BinToASCII
	bsr	GetItemCoord
.Loop	add.w	#4,d1
	sub.w	#8,d2
	moveq	#25,d0
	move.l	sp,a0
	bsr	PrintDString
	addq.w	#4,sp
	moveq	#3,d0
	bsr	WaitX
.Exit	rts

.GoDown	bsr	AddItemNums
	cmp.b	#1,d0
	beq	.Exit
	lea	AjandekTB(pc),a0
	move.w	OPNumber(a5),d0
	add.w	d0,d0
	add.w	d0,a0
	tst.b	1(a0)
	beq	.Exit
	subq.b	#1,1(a0)
	bne	.Update
	bsr	GetItemCoord
	move.l	a0,-(sp)
	move.l	PlaneA(a5),a0
	moveq	#ITEM_ITEMOFF,d0
	bsr	MaskItem
	move.l	(sp)+,a0
	bra	.Update
	
GetItemCoord
	move.w	OPNumber(a5),d2
	moveq	#$7,d1
	and.w	d2,d1
	lsr.w	#3,d2
	lsl.w	#5,d1
	lsl.w	#5,d2
	add.w	#48,d1
	add.w	#64,d2
	rts

AddItemNums
	lea	AjandekTB(pc),a0
	moveq	#0,d0
	moveq	#ajnb-1,d1
.Loop	moveq	#0,d2
	move.b	1(a0),d2
	add.w	d2,d0
	addq.w	#2,a0
	dbf	d1,.Loop
	rts

PrintItemName
	lea	168*5*42+12,a1
	lea	EmptyNameLine(pc),a0
	moveq	#0,d1
	bsr	PrintTextLinesA
	cmp.w	#24,OPNumber(a5)
	bhs	.Exit
	move.w	OPNumber(a5),d0
	lea	ItemNamesTB(pc),a0
.Loop	subq.w	#1,d0
	bmi	.Loop2
.Loop3	tst.b	(a0)+
	bne	.Loop3
	bra	.Loop
.Loop2	move.l	a0,d0
.Loop4	tst.b	(a0)+
	bne	.Loop4
	subq.w	#1,a0
	exg	d0,a0
	sub.l	a0,d0
	moveq	#42,d1
	sub.w	d0,d1
	lsr.w	d1
	lea	168*5*42,a1
	add.w	d1,a1
	moveq	#2,d1
	bsr	PrintTextLinesA
.Exit	rts
	
ItemNamesTB
	dc.b	"RANDOM",0
	dc.b	"CONTROL SWAPPER",0
	dc.b	"ATOM BOMB",0
	dc.b	"NIGHT PLAY",0
	dc.b	"EXTRA BOMB",0
	dc.b	"POWER UP",0
	dc.b	"SUPERMAN",0
	dc.b	"CONTROLER",0
	dc.b	"PROTECTION",0
	dc.b	"GHOST",0
	dc.b	"PERSON SWAPPER",0
	dc.b	"SPEED UP",0
	dc.b	"SKULL",0
	dc.b	"TIMEBOMB",0
	dc.b	"STOP",0
	dc.b	"MONEY",0
	dc.b	"ICER MAN",0
	dc.b	"RANDOM TELEPORT",0
	dc.b	"FIRST AID",0
	dc.b	"DETONATOR",0
	dc.b	"PAC-MAN",0
	dc.b	"MONEY BAG",0
	dc.b	"THIEF",0
EmptyNameLine
	dc.b	"                ",0
	even

DrawGameItems
	bsr	InitCopyBlock
	lea	AjandekTB(pc),a0
	moveq	#48,d3
	moveq	#64,d4
	moveq	#ajnb-1,d2
.Loop	move.b	(a0)+,d0
	move.b	(a0)+,d1
	movem.l	d2-d4/a0,-(sp)
	move.w	d4,d2
	mulu	#42*5,d2
	move.l	d2,a1
	move.w	d3,d2
	lsr.w	#3,d2
	add.w	d2,a1
	ext.w	d0
	add.l	PlaneA(a5),a1
	bsr	CopyBlock
	tst.b	d1
	bne	.NotOff
	move.w	d1,-(sp)
	move.w	d3,d1
	move.w	d4,d2
	move.l	PlaneA(a5),a0
	moveq	#ITEM_ITEMOFF,d0
	bsr	MaskItem
	bsr	InitCopyBlock
	move.w	(sp)+,d1
.NotOff	clr.l	-(sp)
	move.l	sp,a2
	moveq	#0,d0
	move.b	d1,d0
	bsr	BinToASCII
	clr.b	(a2)
	move.l	sp,a0
	move.w	d3,d1
	move.w	d4,d2
	addq.w	#4,d1
	subq.w	#8,d2
	moveq	#25,d0
	bsr	PrintDString
	addq.w	#4,sp
	movem.l	(sp)+,d2-d4/a0
	add.w	#32,d3
	cmp.w	#9*32,d3
	blo	.Loop2
	moveq	#48,d3
	add.w	#32,d4
.Loop2	dbf	d2,.Loop
	rts

BinToASCII
	moveq	#0,d1
	move.w	#100,d1
	bsr	Div10
	move.w	#10,d1
	bsr	Div10
	add.b	#$30,d0
	move.b	d0,(a2)+
	rts

Div10	divu	d1,d0
	tst.w	d0
	bne	.Loop
	btst	#31,d1
	bne	.Loop
	move.b	#' ',d0
	bra	.Loop2

.Loop	bset	#31,d1
	add.b	#$30,d0
.Loop2	move.b	d0,(a2)+
	clr.w	d0
	swap	d0
	rts

* DString=a0, posx=d1, posy=d2, colorpen=d0

PrintDString
	move.b	d0,d5
	mulu	#5*42,d2
	move.l	d2,a1	
	lsr.w	#2,d1
	moveq	#0,d4
	lsr.w	d1
	bcc	.Loop3
	bset	#0,d4
.Loop3	add.w	d1,a1
	add.l	PlaneA(a5),a1
.Loop1	move.b	(a0)+,d0
	beq	.Loop2
	bsr	PrintDChar
	bchg	#0,d4
	beq	.Loop1
	addq.w	#1,a1
	bra	.Loop1
.Loop2	rts

PrintDChar
	movem.l	d5/a0/a1,-(sp)
	sub.b	#$30,d0
	bpl	.Loop
	moveq	#0,d0
	moveq	#0,d5
.Loop	ext.w	d0
	moveq	#-$10,d1
	lsr.w	d0
	bcc	.Loop1
	not.b	d1
.Loop1	lea	DGFont(pc),a0
	add.w	d0,a0
	moveq	#4,d6
.Loop5	move.l	a0,-(sp)
	move.l	a1,a2
	lsr.b	d5
	bcs	.Loop6
	moveq	#-$10,d2
	btst	#0,d4
	bne	.Loop7
	not.b	d2
.Loop7	moveq	#7,d3
.Loop8	and.b	d2,(a2)
	add.w	#42*5,a2
	dbf	d3,.Loop8
	bra	.Loop9

.Loop6	moveq	#7,d3
.Loop2	move.b	(a0),d0
	and.b	d1,d0
	tst.b	d1
	bpl	.Loop3
	lsr.b	#4,d0
.Loop3	moveq	#-$10,d2
	btst	#0,d4
	bne	.Loop4
	lsl.b	#4,d0
	not.b	d2
.Loop4	and.b	d2,(a2)
	or.b	d0,(a2)
	add.w	#6,a0
	add.w	#42*5,a2
	dbf	d3,.Loop2
.Loop9	move.l	(sp)+,a0
	add.w	#42,a1
	dbf	d6,.Loop5
	movem.l	(sp)+,d5/a0/a1
	rts

DGFont:	dc.b	$E4,$EE,$8E,$EE,$EE,$00,$AC,$22,$88,$82,$AA,$A6,$A4,$22,$A8,$82
	dc.b	$AA,$26,$A4,$EE,$AE,$E2,$EE,$46,$A4,$82,$E2,$A2,$A2,$46,$A4,$82
	dc.b	$22,$A2,$A2,$86,$EE,$EE,$2E,$E2,$EE,$A6,$00,$00,$00,$00,$00,$00
	even
	
;******************************** PLAYERS SETUP
PlayersMenuItems
	dc.w	ITEM_PNAME,    0+4,   0+0
	dc.w	ITEM_PLAYEROFF,0+0,   0+16
;	dc.w	ITEM_PSELECT,  0+16,  0+16
;	dc.w	ITEM_JOY1,     0+64,  0+16
;	dc.w	ITEM_LEDA,     0+112, 0+16
	dc.w	ITEM_BANKID,   0+28,  0+69
	dc.w	ITEM_RDICON,   0+64,  0+69

	dc.w	ITEM_PNAME,    208+4,  164+0
	dc.w	ITEM_PLAYEROFF,208+0,  164+16
;	dc.w	ITEM_PSELECT,  208+16, 164+16
;	dc.w	ITEM_JOY1,     208+64, 164+16
;	dc.w	ITEM_LEDA,     208+112,164+16
	dc.w	ITEM_BANKID,   208+28, 164+69
	dc.w	ITEM_RDICON,   208+64, 164+69

	dc.w	ITEM_PNAME,    208+4,  0+0
	dc.w	ITEM_PLAYEROFF,208+0,  0+16
;	dc.w	ITEM_PSELECT,  208+16, 0+16
;	dc.w	ITEM_JOY1,     208+64, 0+16
;	dc.w	ITEM_LEDA,     208+112,0+16
	dc.w	ITEM_BANKID,   208+28, 0+69
	dc.w	ITEM_RDICON,   208+64, 0+69

	dc.w	ITEM_PNAME,    112+4,  72+0
	dc.w	ITEM_PLAYEROFF,112+0,  72+16
;	dc.w	ITEM_PSELECT,  112+16, 72+16
;	dc.w	ITEM_JOY1,     112+64, 72+16
;	dc.w	ITEM_LEDA,     112+112,72+16
	dc.w	ITEM_BANKID,   112+28, 72+69
	dc.w	ITEM_RDICON,   112+64, 72+69

	dc.w	ITEM_PNAME,    0+4,  164+0
	dc.w	ITEM_PLAYEROFF,0+0,  164+16
;	dc.w	ITEM_PSELECT,  0+16, 164+16
;	dc.w	ITEM_JOY1,     0+64, 164+16
;	dc.w	ITEM_LEDA,     0+112,164+16
	dc.w	ITEM_BANKID,   0+28, 164+69
	dc.w	ITEM_RDICON,   0+64, 164+69

	dc.w	ITEM_GO,7,98
	dc.w	ITEM_MENU,288,98
	dc.w	ITEM_END

PlayersOptions
	dc.l	.OpPointerPos
	dc.l	.OpDown
	dc.l	.OpRight
	dc.l	.OpUp
	dc.l	.OpLeft

.OpPointerPos
	dc.w	 94+0,11+0
	dc.w	  6+0,22+0
	dc.w	 48+0,55+0
	dc.w	 94+0,55+0
	dc.w	118+0,22+0
	dc.w	 55+0,87+0
	dc.w	 91+0,87+0

	dc.w	 94+208,11+164
	dc.w	  6+208,22+164
	dc.w	 48+208,55+164
	dc.w	 94+208,55+164
	dc.w	118+208,22+164
	dc.w	 55+208,87+164
	dc.w	 91+208,87+164

	dc.w	 94+112,11+72
	dc.w	  6+112,22+72
	dc.w	 48+112,55+72
	dc.w	 94+112,55+72
	dc.w	118+112,22+72
	dc.w	 55+112,87+72
	dc.w	 91+112,87+72

	dc.w	 94+208,11+0
	dc.w	  6+208,22+0
	dc.w	 48+208,55+0
	dc.w	 94+208,55+0
	dc.w	118+208,22+0
	dc.w	 55+208,87+0
	dc.w	 91+208,87+0

	dc.w	 94+0,11+164
	dc.w	  6+0,22+164
	dc.w	 48+0,55+164
	dc.w	 94+0,55+164
	dc.w	118+0,22+164
	dc.w	 55+0,87+164
	dc.w	 91+0,87+164

	dc.w	312,119
	dc.w	24,119

.OpDown	dc.b	 3, 2, 5, 6, 3,36,36,10, 9,12,13,10,-1,-1,17,16,19,20,17,28, 7,24,23,26,27,24,35,35,31,30,33,34,31,-1,-1, 7,28
.OpRight
	dc.b	21, 2, 3, 4,22, 6,14,-1, 9,10,11,-1,13,-1,26,16,17,18,35,20, 7,-1,23,24,25,-1,27,-1,19,30,31,32, 8,34,12,-1,15
.OpUp 	dc.b	-1, 0, 0, 0, 0, 2, 3,35, 7, 7, 7, 7, 9,10,-1,14,14,14,14,16,17,-1,21,21,21,21,23,24,36,28,28,28,28,30,31,27, 5
.OpLeft	dc.b	-1,-1, 1, 2, 3, 1, 5,20,32, 8, 9,10,34,12, 6,36,15,16,17,28,19, 0, 4,22,23,24,14,26,-1,-1,29,30,31,-1,33,18,-1
	even

PlayersSetUp
	lea	LastGImage(a5),a1
	lea	PlayersTB(a5),a0
	moveq	#4,d1
.Loop	move.l	(a0)+,a2
	move.b	plGuyImage(a2),(a1)+
	dbf	d1,.Loop
	bsr	ClearCopPaletta
	move.l	PlaneA(a5),a0
	bsr	ClearPlane
	lea	PlayersMenuItems(pc),a0
	bsr	DrawAllItems
	move.l	PlaneA(a5),a0
	bsr	CopyToBkg
	move.w	#36,OPNumber(a5)
	lea	PlayersOptions(pc),a0
	moveq 	#0,d0
	bsr	MarkOption
	bsr	PrintPlayers
	lea	DefaultPaletta(pc),a1
	move.w	#$aaa,(a1)
	bsr	SetCopPaletta
	clr.b 	OPLastStick(a5)
PlayersSetUpLoop
	bsr	WaitBOF
	moveq 	#1,d0
	bsr	ReadNrmJoystick
	btst	#bitFire,d0
	bne	.Selected
	cmp.b 	OPLastStick(a5),d0
	beq	PlayersSetUpLoop
	move.b	d0,OPLastStick(a5)
	lea	PlayersOptions(pc),a0
	bsr	MarkOption
	bra	PlayersSetUpLoop

.Selected
	cmp.w 	#35,OPNumber(a5)
	bge	.Wait
	lea	PlayersTB(a5),a0
	move.w	OPNumber(a5),d0
	ext.l 	d0
	divu	#7,d0
	btst	#bitPASSOK,SysFlags+1(a5)
	bne	.loopa
	cmp.w	#2,d0
	bge	PlayersSetUpLoop
.loopa	add.w 	d0,d0
	move.w	PlayersNum(pc,d0.w),d0
	move.l	PlayersPos(pc,d0.w),d1
	move.l	(a0,d0.w),a0
	swap	d0
	cmp.w	#1,d0
	beq	.A
	btst	#bitSELECTED,plFlags+2(a0)
	beq	PlayersSetUpLoop
.A	lsl.w 	#2,d0
	move.l	d1,d2
	swap	d1
	jsr	.PLOptJump(pc,d0.w)
	bra	PlayersSetUpLoop

.Wait	btst	#7,$bfe001
	beq	.Wait
	bsr	UpdateGImages
	bsr	CheckPlayersSbk
 	rts

.PLOptJump
	bra.w 	EnterName
	bra.w 	OnOffPlayer
	bra.w 	SelectPlayer
	bra.w 	SelectControl
	bra.w	SelectTeam
	bra.w	SelectBank
	bra.w	RedefKey

PlayersNum
	dc.w	0*4,1*4,2*4,3*4,4*4

PlayersPos
	dc.w	  0,  0	;pl1
	dc.w	208,164	;pl2
	dc.w	112, 72 ;pl3
	dc.w	208,  0	;pl4
	dc.w	  0,164	;pl5

UpdateGImages
	lea	LastGImage(a5),a1	;Update guys image if needed!
	lea	PlayersTB(a5),a0
	clr.w	-(sp)
	moveq	#4,d1
.Loop	move.l	(a0)+,a2
	move.b	plGuyImage(a2),d2
	cmp.b	(a1)+,d2
	beq	.Loop2
	st	(sp)
	movem.l	d1/a0/a1,-(sp)
	moveq	#0,d1
	move.b	plPlayerID(a2),d1
	subq.b	#1,d1
	ext.w	d2
	move.w	d2,d0
	bsr	LoadGuy
	movem.l	(sp)+,d1/a0/a1
.Loop2	dbf	d1,.Loop
	tst.w	(sp)+
	beq	.Loop1
	bsr	InitGhostImage
	bsr	MakeFigMasks
.Loop1	rts

SelectBank
	addq.w	#1,plSbk(a0)
	cmp.w	#6,plSbk(a0)
	blo	PrintPlayerSbk
	clr.w	plSbk(a0)
PrintPlayerSbk
	add.w	#40,d1
	add.w	#77,d2
	mulu	#42*5,d2
	lsr.w	#3,d1
	move.w	d1,a1
	add.l	d2,a1
	move.w	plSbk(a0),d0
	moveq	#31,d1
	bsr	PrintDECNum
.Wait 	btst	#7,$bfe001
	beq	.Wait
	rts

EnterName
	add.w 	#32,d1
	add.w 	#4,d2
	lsr.w 	#3,d1
	mulu	#42*5,d2
	move.w	d1,a1
	add.l 	d2,a1
;	lea	plName(a0),a0	;plName offset = NUL!!!!
	moveq 	#7,d3
	moveq	#7,d5
	bsr	EnterString
.Loop2	cmp.w 	#7,d3
	beq	.NoFill
	move.b	#$20,(a0,d3.w)
	addq.w	#1,d3
	bra	.Loop2
.NoFill	rts

OnOffPlayer
	bchg	#bitSELECTED,plFlags+2(a0)
	beq	SelectPlayerA
OffPlayer
	add.w	#16,d1
	add.w	#16,d2
	moveq	#ITEM_POFFMASK,d0
	move.l	PlaneA(a5),a0
	bsr	MaskItem
.Wait 	btst	#7,$bfe001
	beq	.Wait
	rts

SelectPlayer
	addq.b	#1,plGuyImage(a0)
SelectPlayerA
	add.w	#16,d1
	add.w	#16,d2
	move.b	plGuyImage(a0),d0
	cmp.b	#MAXGUYS-1,d0
	ble	.A
	clr.b	plGuyImage(a0)
	moveq	#0,d0
.A	ext.w	d0
	move.l	PlaneA(a5),a0
	movem.w	d0-d2,-(sp)
	moveq	#ITEM_PSELECT,d0
	bsr	MaskItem
	movem.w	(sp)+,d0-d2
	add.w	#14,d1
	add.w	#14,d2
	bsr	DrawGuy
.Wait 	btst	#7,$bfe001
	beq	.Wait
	rts

SelectControl
	cmp.b	#ctKeyb,plControl(a0)
	bne	.A
	moveq	#ITEM_RDMASK,d0
	bsr	SetKeybItem
.A	addq.b	#1,plControl(a0)
SelectControlA
	cmp.b	#ctKeyb,plControl(a0)
	bne	.A
	moveq	#ITEM_RDICON,d0
	bsr	SetKeybItem
.A	add.w 	#64,d1
	add.w 	#16,d2
	move.b	plControl(a0),d0
	cmp.b 	#ctKeyb,d0
	ble	.B
	clr.b 	plControl(a0)
	moveq 	#ctJoy0,d0
.B	move.l	PlaneA(a5),a0
	ext.w 	d0
	bsr	DrawItem
.Wait 	btst	#7,$bfe001
	beq	.Wait
	rts

SetKeybItem
	movem.l	d1-d2/a0,-(sp)
	add.w	#64,d1
	add.w	#69,d2
	move.l	PlaneA(a5),a0
	cmp.w	#ITEM_RDMASK,d0
	bne	.A
	bsr	MaskItem
	bra	.End
.A	bsr	DrawItem
.End	movem.l	(sp)+,d1-d2/a0
	rts
	
SelectTeam
	tst.w	TeamMode(a5)
	beq	NoTeamM
	bchg	#0,plTeam(a0)
SelectTeamA
	moveq	#ITEM_LEDA,d0
	btst	#0,plTeam(a0)
	beq	.A
	moveq	#ITEM_LEDB,d0
.A	bsr	SetTeamItem
.Wait 	btst	#7,$bfe001
	beq	.Wait
NoTeamM	rts

SetTeamItem
	movem.l	d1-d2/a0,-(sp)
	add.w	#112,d1
	add.w	#16,d2
	move.l	PlaneA(a5),a0
	cmp.w	#ITEM_LEDMASK,d0
	bne	.A
	bsr	MaskItem
	bra	.End
.A	bsr	DrawItem
.End	movem.l	(sp)+,d1-d2/a0
	rts
	
REG_Count equr	d4
REG_Flag  equr	d5
REG_Blink equr	d6

RedefKey
	cmp.b	#ctKeyb,plControl(a0)
	bne	.NoKeyb
	moveq	#0,REG_Count
	moveq	#0,REG_Flag
	moveq	#0,REG_Blink
	lea	plKeyboard(a0),a1	;Save last keyboard
	move.b	(a1)+,-(sp)
	move.b	(a1)+,-(sp)
	move.b	(a1)+,-(sp)
	move.b	(a1)+,-(sp)
	move.b	(a1)+,-(sp)
	st	KBRaw(a5)
.RDLoop	moveq	#ITEM_RDBLANK,d0
	tst.w	REG_Flag
	beq	.Loop1
	moveq	#ITEM_RDDOWN,d0
	add.w	REG_Count,d0
.Loop1	bsr	SetKeybItem
	bsr	WaitBOF
	bsr	WaitBOF
	addq.w	#1,REG_Blink
	cmp.w	#8,REG_Blink
	blo	.Loop2
	moveq	#0,REG_Blink
	not.w	REG_Flag
.Loop2	tst.b	$45+KBMatrix(a5)
	bne	.Abort
	move.b	KBRaw(a5),d0
	bmi	.RDLoop
	st	KBRaw(a5)
	cmp.b	#$45,d0		;ESC=AbortGame
	beq	.RDLoop
	cmp.b	#$59,d0		;F10=PauseGame
	beq	.RDLoop
	cmp.b	#$58,d0		;F9=MainMusic On/Off
	beq	.RDLoop
	cmp.b	#$62,d0
	beq	.RDLoop		;CapsLock=NOP
	move.b	d0,plKeyboard(a0,REG_Count)
	addq.w	#1,REG_Count
	cmp.w	#5,REG_Count
	blo	.RDLoop
	lea	5*2(sp),sp
	bra	.End

.Abort	sf	$45+KBMatrix(a5)
	lea	plKeyboard+5(a0),a1	;Restore last keyboard!
	move.b	(sp)+,-(a1)
	move.b	(sp)+,-(a1)
	move.b	(sp)+,-(a1)
	move.b	(sp)+,-(a1)
	move.b	(sp)+,-(a1)
.End	moveq	#ITEM_RDICON,d0
	bsr	SetKeybItem
.NoKeyb	rts
	
PrintPlayers
	lea	PlayersTB(a5),a3
	moveq 	#0,d2
.Loop 	move.l	(a3)+,a0
	move.w	d2,d0
	lsl.w 	#2,d0
	lea	PlayersPos(pc),a1
	move.l	(a1,d0.w),d1
	move.w	d2,-(sp)
	move.l	d1,d2
	swap	d1
	movem.l	d1/d2/a0,-(sp)
	bsr	SelectPlayerA
	movem.l	(sp),d1/d2/a0
	bsr	SelectControlA
	movem.l	(sp),d1/d2/a0
	bsr	PrintPlayerSbk
	movem.l	(sp),d1/d2/a0
	bsr	SelectTeamA
	cmp.b	#ctKeyb,plControl(a0)
	beq	.B
	moveq	#ITEM_RDMASK,d0
	bsr	SetKeybItem
.B	tst.w	TeamMode(a5)
	bne	.C
	moveq	#ITEM_LEDMASK,d0
	bsr	SetTeamItem
.C	btst	#bitSELECTED,plFlags+2(a0)
	bne	.A
	bsr	OffPlayer
.A	movem.l	(sp)+,d1/d2/a0
	move.w	d1,d0
	move.w	d2,d1
	move.w	(sp)+,d2
	add.w 	#32,d0
	add.w 	#4,d1
	mulu	#42*5,d1
	lsr.w 	#3,d0
	move.w	d0,a1
	add.l	d1,a1
	moveq 	#2,d1
	bsr	PrintTextLinesA
	addq.w	#1,d2
	cmp.w 	#5,d2
	bne	.Loop
	rts

;buffer=a0, position=a1,cpos=d3, maxchars=d5
EnterString
	add.w 	d3,a1
	moveq 	#bxCURSOR,d4
.EnterLoop
	eor.b 	#$60,d4
	bsr	WaitBOF
	bsr	WaitBOF
	move.b	d4,d0
	moveq 	#31,d1
	bsr	PrintAChar
	move.b	KBLastK(a5),d0
	beq	.EnterLoop
	clr.b 	KBLastK(a5)
	cmp.b 	#$d,d0
	beq	.EndOfInput
	cmp.b 	#$8,d0
	beq	.BS
	cmp.b 	#$20,d0
	blt	.EnterLoop
	cmp.b 	#$60,d0
	bge	.EnterLoop
	cmp.w 	d5,d3
	beq	.EnterLoop
	move.b	d0,(a0,d3.w)
	moveq 	#2,d1
	bsr	PrintAChar
	addq.w	#1,d3
	addq.w	#1,a1
	bra	.EnterLoop
.BS	tst.w 	d3
	beq	.EnterLoop
	moveq 	#$20,d0
	move.b	d0,-1(a0,d3.w)
	bsr	PrintAChar
	subq.w	#1,d3
	subq.w	#1,a1
	bra	.EnterLoop
.EndOfInput
	moveq 	#$20,d0
	bsr	PrintAChar
	rts

	
; ********************************* TITLE

SwapMusicAndSplData
	btst	#bitMUSICOK,SysFlags(a5)
	beq	.NoMusic
	move.l	SampleInfo(a5),a0
	move.l	MusicBase(a5),d0
	clr.l	MusicBase(a5)
	cmp.l	d0,a0
	beq	.Loop1
	move.l	a0,MusicBase(a5)
.Loop1	move.l	MusicData(a5),a1
	move.l	MusicLength(a5),d0
	divu	#4,d0
.Loop	move.l	(a0),d1
	move.l	(a1),(a0)+
	move.l	d1,(a1)+
	subq.w	#1,d0
	bne	.Loop
	swap	d0
	tst.w	d0
	beq	.NoMusic
.Loop2	move.b	(a0),d1
	move.b	(a1),(a0)+
	move.b	d1,(a1)+
	subq.w	#1,d0
	bne	.Loop2
.NoMusic
	rts

TitleMain
	move.l	PlaneA(a5),d0
	move.l	CopperListA(a5),a0
	bsr	MakeCList42
	move.l	CopperListA(a5),a0
	bsr	SetCopperList
	bsr	ClearAllPlanes
	bsr	SwapMusicAndSplData
	move.l	PlaneA(a5),a1
	add.l 	#72*42*5-2,a1
	moveq 	#0,d0
.NextFig
	movem.l	d0/a1,-(sp)
	move.l	PlaneB(a5),a0
	bsr	ClearPlane
	bsr	ZoomFigura
	movem.l	(sp)+,d0/a1
	add.l 	#2*4,a1
	add.w 	#30,d0
	cmp.w 	#5*30,d0
	blt	.NextFig
	move.l	PlaneA(a5),a0
	bsr	CopyToBkg
	moveq 	#6,d0
	moveq 	#0,d1
	moveq 	#30,d2
	moveq 	#4,d3
	moveq 	#1,d4
	bsr	DrawBoxA
	lea	TitleText(pc),a0
	sub.l 	a1,a1
	moveq 	#1,d1
	bsr	PrintTextLinesA
	tst.l	MusicBase(a5)		;Music present?
	beq	.NoMusic
	CallMusic mt_init
	st 	MusicEnabled(a5)
.NoMusic
	lea	DefaultPaletta(pc),a1
	move.w	#$112,(a1)
	bsr	SetCopPaletta
	bsr	InitBText
MainLoop
	bsr	WaitBOF
	bsr	BlasterText
	tst.b 	$45+KBMatrix(a5)
	bne	.Exit
	btst	#7,$bfe001
	bne	MainLoop
.Wait 	btst	#7,$bfe001
	beq	.Wait
	bsr	MainSetUp
.Exit 	tst.l	MusicBase(a5)		;Music present?
 	beq	.NoMusic
	sf 	MusicEnabled(a5)
	CallMusic mt_end
.NoMusic
	bsr	SwapMusicAndSplData
	rts

InitBText
	move.w	#0,BlasterCnt(a5)
	move.w	#7,BSpeed(a5)
	lea	BText(pc),a0
	move.l	a0,BTextPtr(a5)
	move.l	PlaneB(a5),d0
	move.l	d0,BlasterPlaneA(a5)
	add.l 	#16*42*5,d0
	move.l	d0,BlasterPlaneB(a5)
	add.l 	#16*42*5,d0
	move.l	d0,a0
	moveq 	#0,d1
.Loop2	moveq 	#0,d0
.Loop1	move.l	d1,d2
	add.l 	d0,d2
	move.l	d2,(a0)+
	addq.l	#1,d0
	cmp.l 	#42,d0
	blt	.Loop1
	add.l 	#42*5,d1
	cmp.l 	#8*42*5,d1
	blt	.Loop2
	move.l	BlasterPlaneA(a5),a0
	move.l	BlasterPlaneB(a5),a1
	move.w	#42*5*8/2-1,d0
.Loop3	clr.w 	(a0)+
	clr.w 	(a0)+
	dbf	d0,.Loop3
	rts

BlasterBits
	dc.b	%11111110,%11111101,%11111011,%11110111
	dc.b	%11101111,%11011111,%10111111,%01111111

BlasterText
	tst.w 	BSpeed(a5)
	bmi	.Loop0
	subq.w	#1,BSpeed(a5)
	bpl	.Exit
.Loop0	move.l	BlasterPlaneA(a5),a0
	move.l	PlaneA(a5),a1
	add.l 	#160*42*5,a1
	moveq 	#0,d0
	move.w	BlasterCnt(a5),d1
.Loop1	move.b	BlasterBits(pc,d1.w),d2
	move.l	PlaneB(a5),a2
	add.l 	#32*42*5,a2
	move.w	d0,d3
	add.w 	d3,d3
	add.w 	d3,d3
	move.l	(a2,d3.w),d3
	move.l	a0,a2
	move.l	a1,a3
	add.l 	d3,a2
	add.l 	d3,a3
	move.b	d2,d3
	not.b 	d3
	moveq 	#4,d6
.Loop5	move.b	(a2),d4
	move.b	(a3),d5
	and.b 	d3,d4
	and.b 	d2,d5
	or.b	d5,d4
	move.b	d4,(a3)
	add.l 	#42,a2
	add.l 	#42,a3
	dbf	d6,.Loop5
	addq.w	#$3,d1
	and.w 	#$7,d1
	addq.w	#$1,d0
	cmp.w 	#42*8,d0
	blt	.Loop1
	addq.w	#1,BlasterCnt(a5)
	cmp.w 	#8,BlasterCnt(a5)
	blt	.Exit
	move.w	#0,BlasterCnt(a5)
	move.w	#199,BSpeed(a5)
	move.l	BlasterPlaneB(a5),d0
	move.l	BlasterPlaneA(a5),BlasterPlaneB(a5)
	move.l	d0,BlasterPlaneA(a5)
	move.l	d0,a2
	move.l	a2,a0
	move.w	#42*5*8/2-1,d0
.Loop4	clr.w 	(a0)+
	dbf	d0,.Loop4
	move.l	BTextPtr(a5),a0
	move.l	a0,a1
.Loop3	tst.b 	(a1)+
	bne	.Loop3
	move.l	a1,d0
	sub.l 	a0,d0
	subq.l	#1,d0
	neg.w 	d0
	add.w 	#42+4,d0
	lsr.w 	d0
	tst.b 	(a1)
	bne	.Loop2
	lea	BText(pc),a1
.Loop2	move.l	a1,BTextPtr(a5)
	move.w	d0,a1
	bsr	PrintTextLines
.Exit 	rts

BText 	dc.b	"p10;TENABLASTER",0
	dc.b	"p11;THE ULTIMATE MULTI PLAYER GAME",0
	dc.b	"p12;(C)1995 TENAX SOFTWARE",0
	dc.b	"p13;THIS GAME IS >SHAREWARE<",0
	dc.b	"p14;COPYRIGHTED BY",0
	dc.b	"p15;TENAX SOFTWARE",0
	dc.b	"p00; ",0
	dc.b	"p01;THE CREDITS:",0
	dc.b	"p02;PROGRAMMED BY",0
	dc.b	"p02;PETER BAKOTA",0
	dc.b	"p03;GRAPHICS AND FEATURES BY",0
	dc.b	"p03;BORIS IVIC",0
	dc.b	"p04;MUSIC AND ADDITIONAL GRAPHICS BY",0
	dc.b	"p04;TIBOR CSONKAS",0
	dc.b	"p00; ",0
	dc.b	"p09;FOR MORE INFORMATION ABOUT THE FEATURES",0
	dc.b	"p09;READ THE DOC FILE",0
	dc.b	"p00; ",0
	dc.b	"p11;THE FOLLOWING SOFTWARE ARE USED",0
	dc.b	"p18;HISOFT DEVPAC 2.15",0
	dc.b	"p19;DELUXE PAINT IV",0
	dc.b	"p20;IFF MASTER V1.0",0
	dc.b	"p21;PROTRACKER 3.15",0
	dc.b	"p23;AEGIS AUDIO MASTER",0
	dc.b	"p24;T.F.S. ARCHIVER WAS WRITTEN IN",0
	dc.b	"p22;MANX AZTEC C V3.6A",0
	dc.b	"p00; ",0
	dc.b	"p18;TO CONTACT WITH TENAX SOFTWARE WRITE TO :",0
	dc.b	"p19;PETER BAKOTA",0
	dc.b	"p20;>TENAX SOFTWARE<",0
	dc.b	"p21;SABO MIKLOSA 21",0
	dc.b	"p23;24000 SUBOTICA",0
	dc.b	"p24;YUGOSLAVIA",0
	dc.b	"p22;OR CALL : 024-32-289",0
	dc.b	"p00; ",0
	dc.b	0

TitleText
	dc.b	$a
	dc.b	"tttttp8; TENABLASTERttt",$a,$a
	dc.b	"tttp3; (C)1995 TENAX SOFTWARE "
	dc.b	"u11;216;p31;PRESS FIRE TO START!"
	dc.b	0
	even
; *******************************
ShopMain
	moveq 	#4,d1
	lea	PlayersTB(a5),a2
.Loop 	bsr	ClearAllPlanes
	move.l	(a2)+,a3
	btst	#bitSELECTED,plFlags+2(a3)
	beq	.NoMoney
	tst.w 	plMoney(a3)
	beq	.NoMoney
	movem.l	d1/a2,-(sp)
	bsr	EnterToShop
	movem.l	(sp)+,d1/a2
.NoMoney
	tst.b 	$45+KBMatrix(a5)
	dbne	d1,.Loop
 	rts

ShopPointTB
	dc.l	10+10*8*42*5 ;Extra bomb
	dc.l	10+12*8*42*5 ;Power up
	dc.l	10+14*8*42*5 ;Superman
	dc.l	10+16*8*42*5 ;Ghost
	dc.l	10+18*8*42*5 ;Time bomb
	dc.l	10+20*8*42*5 ;Protection
	dc.l	10+22*8*42*5 ;Controler
	dc.l	10+24*8*42*5 ;Speed up
	dc.l	10+26*8*42*5 ;PacMan
	dc.l	10+30*8*42*5 ;Exit

;playerDef=a3
EnterToShop
	move.b	plPlayerID(a3),d0
	ext.w	d0
	subq.w	#1,d0
	mulu	#30,d0
	move.l	PlaneB(a5),a0
	move.l	PlaneA(a5),a1
	add.l 	#72*42*5-2,a1
	move.l	a3,-(sp)
	bsr	ZoomFigura
	move.l	(sp)+,a3
	move.l	PlaneA(a5),a0
	bsr	CopyToBkg
	lea	plName(a3),a0
	lea	shPlayerName(pc),a1
	moveq	#6,d0
.Loop 	move.b	(a0)+,(a1)+
	dbf	d0,.Loop
	lea	ShopText(pc),a0
	sub.l 	a1,a1
	moveq 	#1,d1
	bsr	PrintTextLinesA
	moveq 	#0,d0
	moveq 	#1,d1
	moveq 	#41,d2
	moveq 	#4,d3
	moveq 	#16,d4
	bsr	DrawBoxA
	moveq 	#0,d0
	moveq 	#6,d1
	moveq 	#41,d2
	moveq 	#25,d3
	moveq 	#16,d4
	bsr	DrawBoxA
	bsr	PrintPlayerMoney
	lea	DefaultPaletta(pc),a1
	move.w 	#$102,(a1)
	bsr	SetCopPaletta
	move.w	#MAXSHOP,OPNumber(a5)
	clr.b 	OPLastStick(a5)
ShopLoop
	bsr	WaitBOF
	moveq 	#bxPOINTER,d0
	lea	ShopPointTB(pc),a1
	bsr	PrintPointer
	tst.b 	$45+KBMatrix(a5)
	bne	.Exit
	move.l	a3,a1
	bsr	ReadControl
	move.b	plJoystick(a1),d0
	cmp.b 	OPLastStick(a5),d0
	beq	ShopLoop
	move.b	d0,OPLastStick(a5)
	btst	#bitFire,d0
	bne	.SHSelected
	btst	#bitUp,d0
	bne	.SHOptUp
	btst	#bitDown,d0
	bne	.SHOptDown
	bra	ShopLoop
.SHOptUp
	moveq 	#$20,d0
	lea	ShopPointTB(pc),a1
	bsr	PrintPointer
	subq.w	#1,OPNumber(a5)
	MakeFx	OptionsFx
	tst.w 	OPNumber(a5)
	bpl	ShopLoop
	move.w	#MAXSHOP,OPNumber(a5)
	bra	ShopLoop

.SHOptDown
	moveq 	#$20,d0
	lea	ShopPointTB(pc),a1
	bsr	PrintPointer
	addq.w	#1,OPNumber(a5)
	MakeFx	OptionsFx
	cmp.w 	#MAXSHOP+1,OPNumber(a5)
	bne	ShopLoop
	clr.w 	OPNumber(a5)
	bra	ShopLoop

.SHSelected
	cmp.w 	#MAXSHOP,OPNumber(a5)
	beq	.Wait
	move.w	OPNumber(a5),d0
	add.w 	d0,d0
	lea	PrizeList(pc),a0
	move.w	(a0,d0.w),d2
	cmp.w 	plMoney(a3),d2
	bhi	.SHError
	MakeFx	MoneyFx
	move.w	plMoney(a3),d1
	sub.w 	d2,plMoney(a3)
	subq.w	#1,d2
	subq.w	#1,d1
	movem.w	d1/d2,-(sp)
	add.w 	d0,d0
	jsr	.BuyJump(pc,d0.w)
	movem.w	(sp)+,d1/d2
	lea	8+20*42*5,a1
	add.w 	d1,a1
	add.w 	d1,a1
	bsr	InitCopyBlock
.Loop 	moveq 	#7,d0
	bsr	WaitX
	move.l	a1,-(sp)
	cmp.w	#16,d1
	bhs	.Loop2
	add.l 	PlaneA(a5),a1
	moveq 	#blCOLOR0,d0
	bsr	CopyBlock
.Loop2	MakeFx	LezerFx
	move.l	(sp)+,a1
	subq.w	#2,a1
	subq.w	#1,d1
	dbf	d2,.Loop
	tst.w 	plMoney(a3)
	bne	ShopLoop
	moveq 	#30,d0
	bsr	WaitX
	bra	.Wait

.BuyJump
	bra.w 	BuyExtraBomb
	bra.w 	BuyPowerUp
	bra.w 	BuySuperMan
	bra.w 	BuyGhost
	bra.w 	BuyTimeB
	bra.w 	BuyProtection
	bra.w 	BuyControler
	bra.w 	BuySpeedUp
	bra.w	BuyPacMan

.SHError
	MakeFx	TimeBFx
	bra	ShopLoop

.Wait 	bsr	WaitBOF
	move.l	a3,a1
	bsr	ReadControl
	btst	#bitFire,plJoystick(a1)
	bne	.Wait
.Exit 	bsr	ClearCopPaletta
	rts

PrintPlayerMoney
	bsr	InitCopyBlock
	lea	8+20*42*5,a1
	moveq 	#0,d1
.Loop 	move.l	a1,-(sp)
	add.l 	PlaneA(a5),a1
	moveq 	#blMONEY,d0
	bsr	CopyBlock
	move.l	(sp)+,a1
	addq.w	#2,a1
	addq.w	#1,d1
	cmp.w 	#16,d1
	beq	.Exit
	cmp.w 	plMoney(a3),d1
	bne	.Loop
.Exit 	rts

PrizeList
	dc.w	1,1,2,2,3,3,4,4,5

BuyExtraBomb
	addq.w	#1,plBomb(a3)
	rts

BuyPowerUp
	addq.w	#1,plPower(a3)
	rts

BuySuperMan
	move.l	plBob(a3),a0
	bset	#bitSUPERMAN,plFlags(a3)
	bclr	#bitPACMAN,plFlags+1(a3)
	bclr	#bitPACMAN,bobFlags+1(a0)
	rts

BuyGhost
	move.l	plBob(a3),a0
	bset	#bitGHOST,plFlags+1(a3)
	bset	#bitGHOST,bobFlags+1(a0)
	bclr	#bitPROTECTION,plFlags+1(a3)
	bclr	#bitPROTECTION,bobFlags+1(a0)
	bclr	#bitPACMAN,plFlags+1(a3)
	bclr	#bitPACMAN,bobFlags+1(a0)
	rts

BuyTimeB
	bset	#bitTIMEBOMB,plFlags(a3)
	sub.b 	#10,plBombTime(a3)
	cmp.b	#30,plBombTime(a3)
	bgt	.A
	move.b	#30,plBombTime(a3)
.A 	rts

BuyProtection
	move.l	plBob(a3),a0
	bset	#bitPROTECTION,plFlags+1(a3)
	bset	#bitPROTECTION,bobFlags+1(a0)
	bclr	#bitGHOST,plFlags+1(a3)
	bclr	#bitGHOST,bobFlags+1(a0)
	move.w	#DEFAULTPROTTIME,plProtCount(a3)
	rts

BuyControler
	bset	#bitCONTROLER,plFlags(a3)
	rts

BuySpeedUp
	addq.w	#1,plSpeed(a3)
	rts

BuyPacMan
	move.l	plBob(a3),a0
	bclr	#bitGHOST,plFlags+1(a3)
	bclr	#bitGHOST,bobFlags+1(a0)
	bclr	#bitSUPERMAN,plFlags(a3)
	bclr	#bitTIMEBOMB,plFlags(a3)
	bclr	#bitCONTROLER,plFlags(a3)
	bset	#bitPACMAN,plFlags+1(a3)
	bset	#bitPACMAN,bobFlags+1(a0)
	move.w	#DEFAULTPACMANTIME,plPMCount(a3)
	rts

	IFD	REGISTERED
	include	TBProt.s
	ENDC

MAXSHOP	equ	9

ShopText
	dc.b	"ttttp31;"
shPlayerName
	dc.b	"xxxxxxx p4;ENTERS SHOP",$a
	dc.b	$a,$a
	dc.b	"p2; MONEY",$a
	dc.b	$a,$a,$a
	dc.b	"tttttEXTRAttttPRIZE",$a
	dc.b	$a,$a
	dc.b	"ttttEXTRA BOMB : w",blEXTRABOMB, "t  1",$a,$a
	dc.b	"ttttPOWER-UP   : w",blPOWER,	  "t  1",$a,$a
	dc.b	"ttttSUPERMAN   : w",blSUPERMAN,  "t  2",$a,$a
	dc.b	"ttttGHOST      : w",blGHOST,	  "t  2",$a,$a
	dc.b	"ttttTIMEBOMB   : w",blTIMEBOMB,  "t  3",$a,$a
	dc.b	"ttttPROTECTION : w",blPROTECTION,"t  3",$a,$a
	dc.b	"ttttCONTROLER  : w",blCONTROLER, "t  4",$a,$a
	dc.b	"ttttSPEED UP   : w",blSPEED,	  "t  4",$a,$a
	dc.b	"ttttPACMAN     : w",blPACMAN,	  "t  5",$a,$a
	dc.b	$a,$a
	dc.b	"ttttEXIT",$a
	dc.b	0
	even

; **********************************************

VarsPtr	ds.l	1	;Global POINTER TO data filed! (A5)

GfxName	dc.b	"graphics.library",0
IntName	dc.b	"intuition.library",0
DosName	dc.b	"dos.library",0
InputName
	dc.b	"input.device",0

TFSName	TFSFILENAME			;DATAFILE NAME!
	even

NewScreen
	dc.w	0,0,320,16,1
	dc.b	0,1
	dc.w	2,15
	dc.l	0,0,0,0

AreasTab
	dc.l	NormalArea,MadArea,NoWallsArea

NormalArea
	dc.b	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

NoWallsArea
	dc.b	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

MadArea	dc.b	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,1,1,0,1,0,1,1,1,0,1,1,1,0,1,0,1,1,0,1
	dc.b	1,0,0,1,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0,1
	dc.b	1,0,1,1,0,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1
	dc.b	1,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,0,1,0,0,1
	dc.b	1,0,1,1,0,1,0,1,0,1,1,0,1,1,0,1,0,1,1,0,1
	dc.b	1,0,0,1,0,1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1
	dc.b	1,0,1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,1,0,1
	dc.b	1,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,0,1,1,0,1,0,1,1,0,1,1,0,1,0,1,1,1,1,0,1
	dc.b	1,0,1,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1
	dc.b	1,0,1,0,1,1,0,1,1,0,1,0,1,1,0,1,0,1,1,0,1
	dc.b	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	even

DefaultPaletta
	dc.w	$0666,$0037,$050B,$0370,$003F,$000D,$0009,$0555
	dc.w	$0FF0,$0FB0,$0900,$0D00,$0B00,$00A0,$00C0,$02F2
	dc.w	$0500,$0F70,$0F50,$0F30,$0F90,$00FF,$00BF,$007F
	dc.w	$0F0B,$0000,$0333,$0777,$0999,$0BBB,$0DDD,$0FFF

SamplesDefStr:

ExplodeFx
	dc.b	fxEXPLODE
	dc.b	$32
	SETRATE	$226

OlalaFx	dc.b	fxOLALA
	dc.b	$40
	SETRATE	$190

ExtroFx	dc.b	fxEXTRO
	dc.b	$40
	SETRATE	$226

MainFx	dc.b	fxMAIN
	dc.b	64
	dc.w	224
	dc.w	-1

;YeahFx	dc.b	fxYEAH
;	dc.b	$40
;	SETRATE	$168

AlarmFx	dc.b	fxALARM
	dc.b	$40
	dc.w	$154
	dc.w	-1

ShrinkFx
	dc.b	fxLASER
	dc.b	$40
	SETRATE	$190

SuperManFx
	dc.b	fxSUPER
	dc.b	$40
	SETRATE	$258

ControlerFx
	dc.b	fxSUPER
	dc.b	$28
	SETRATE	$258

LezerFx	dc.b	fxLASER
	dc.b	$40
	SETRATE	$190

TeleportFx
	dc.b	fxTELEPORT
	dc.b	64
	SETRATE	226

GhostFx	dc.b	fxGHOST
	dc.b	$40
	SETRATE	$1f4

;GoFx	dc.b	fxGO
;	dc.b	$40
;	SETRATE	$8c

TimeBFx	dc.b	fxTIMEB
	dc.b	$40
	SETRATE	$190

MoneyFx	dc.b	fxMONEY
	dc.b	$28
	SETRATE	$1f4

GamblingFx
	dc.b	fxTIMEB
	dc.b	$40
	SETRATE	$64

OptionsFx
	dc.b	fxTIMEB
	dc.b	$28
	SETRATE	$60

StandingFx
	dc.b	fxTELEPORT
	dc.b	64
	SETRATE	160

CountFx	dc.b	fxCOUNT
	dc.b	64
	SETRATE	275

;DameFx	dc.b	fxDAME
;	dc.b	64
;	SETRATE	275

;ThiefFx	dc.b	fxTHIEF
;	dc.b	64
;	SETRATE	295

;HeyFx	dc.b	fxHEY
;	dc.b	64
;	SETRATE	380
		
SamplesDefEnd:

Font	incbin	"TBFONT.RAW"

	section	vars,bss
Vars	ds.b	DataLong
	end



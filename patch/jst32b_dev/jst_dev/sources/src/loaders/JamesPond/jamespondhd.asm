; *** James Pond Hard Disk Loader V0.9
; *** Written by Jean-François Fabre


	include	"jst.i"

	HD_PARAMS	"jpond.d",STD_DISK_SIZE,1

BUILD_BLITWAIT:MACRO
BlitWait\1
	JSRGEN	WaitBlit
	move.w	#$\1,$DFF058
	rts
	ENDM

PATCH_BLITWAIT:MACRO
	move.l	#$4E714EB9,\2
	GETUSRADDR	BlitWait\1
	move.l	D0,\2+4
	ENDM
	

_loader:
	RELOC_MOVEL	D0,trainer

	Mac_printf	"James Pond HD Loader V0.9a"
	Mac_printf	"Coded by Jean-François Fabre © 1997"

	tst.l	D0
	beq	skip$

	NEWLINE
	Mac_printf	"Trainer activated"
skip$
	JSRABS	LoadDisks
	JSRABS	TransfRoutines

	moveq.l	#0,D0
;	move.l	#CACRF_CopyBack,D1
	move.l	#-1,D1
	JSRABS	Degrade

;	WAIT_LMB

	GO_SUPERVISOR
	SAVE_OSDATA	$80000

	JSRGEN	InitTrackDisk

	move.w	#$2,$1C(A1)
	MOVE.L	#$00020000,40(A1)	;00: 237C000200000028
	MOVE.L	#$000B6E00,44(A1)	;08: 237C000B6E00002C
	MOVE.L	#$00001400,36(A1)	;10: 237C000014000024
	MOVE	#$000E,D1		;18: 323C000E
LAB_0000:
	MOVE	D1,-(A7)		;1C: 3F01
	JSRGEN	TrackLoad
	MOVE	(A7)+,D1		;22: 321F
	ADDI.L	#$00001400,40(A1)	;24: 06A9000014000028
	ADDI.L	#$00002C00,44(A1)	;2C: 06A900002C00002C
	DBF	D1,LAB_0000		;34: 51C9FFE6

	PATCHABSJMP	$2F94C,PatchLoader1

	JSRGEN	FlushCachesHard

	JMP	$2F912


PatchLoader1:
	STORE_REGS
	bsr	SetupPatches
	JSRGEN	FlushCachesHard
	RESTORE_REGS
	nop
	nop
	JMP	$12626
	nop
	nop

SetupPatches:
	; *** disk loader

	PATCHUSRJMP	$104CC,ReadSectors

	; *** remove disk accesses

	move.w	#$4E75,$10806
	move.w	#$4E75,$10858
	move.w	#$4E75,$108FC
	move.w	#$4E75,$107CC
	move.w	#$6006,$126C4

	; *** end decrunch

	PATCHUSRJMP	$C95C,EndDecrunch

	; *** keyboard interrupt

	PATCHUSRJSR	$C346,KbInt

	; *** trainer
	
	move.l	trainer(pc),D0
	beq	sktr$

	move.w	#$4A78,$9AE8

sktr$

	; *** blitter waits (registers, indexed)

	move.w	#$4EF9,$B0.W
	GETUSRADDR	BlitWaitD1_A5
	move.l	D0,$B2.W
	move.w	#$4EF9,$B6.W
	GETUSRADDR	BlitWaitD7_A6
	move.l	D0,$B8.W

	move.l	#$4EB800B0,D0

	move.l	D0,$EECA
	move.l	D0,$EED8
	move.l	D0,$EEE4
	move.l	D0,$EEF0

	move.l	#$4EB800B6,D0
	
	move.l	D0,$ED08
	move.l	D0,$ED14
	move.l	D0,$ED20
	move.l	D0,$ED2C
	move.l	D0,$ED9C
	move.l	D0,$EDB0
	move.l	D0,$EDC4
	move.l	D0,$EDD8

	; *** blitter waits (hardcoded)

	PATCH_BLITWAIT	1420,$4932
	PATCH_BLITWAIT	03C1,$AA90
	PATCH_BLITWAIT	03CA,$B026
	PATCH_BLITWAIT	2816,$BDE6
	PATCH_BLITWAIT	2816,$BDF6
	PATCH_BLITWAIT	280F,$BE3E
	PATCH_BLITWAIT	280F,$BE52
	PATCH_BLITWAIT	2814,$11826
	PATCH_BLITWAIT	2814,$11838

	; *** blitter waits (registers)
	
	PATCHUSRJSR	$A694,BlitWaitD0
	PATCHUSRJSR	$A6AE,BlitWaitD0
	PATCHUSRJSR	$A6C8,BlitWaitD0
	PATCHUSRJSR	$C712,BlitWaitD0

	GETUSRADDR	BlitWaitD1

	move.l	#$33C100DF,D1
	move.w	#$F058,D2

	lea	$A000,A0
	lea	$B000,A1

loop$
	cmp.l	(A0),D1
	beq.b	found$
next$
	addq.l	#2,A0
	cmp.l	A0,A1
	bne.b	loop$

	rts

found$
	cmp.w	4(A0),D2
	bne.b	next$
	
	; *** sequence found, let's patch

	move.w	#$4EB9,(A0)+
	move.l	D0,(A0)

	bra.b	next$

	

	BUILD_BLITWAIT	1420
	BUILD_BLITWAIT	03C1
	BUILD_BLITWAIT	03CA
	BUILD_BLITWAIT	2816
	BUILD_BLITWAIT	280F
	BUILD_BLITWAIT	2814

BlitWaitD0:
	JSRGEN	WaitBlit
	move.w	D0,$DFF058
	rts

BlitWaitD1:
	JSRGEN	WaitBlit
	move.w	D1,$DFF058
	rts

BlitWaitD1_A5:
	JSRGEN	WaitBlit
	move.w	D1,($58,A5)
	rts

BlitWaitD7_A6:
	JSRGEN	WaitBlit
	move.w	D7,($58,A6)
	rts

KbInt:
	ror.b	#1,D0
	move.b	D0,($159).W
	cmp.b	#$59,D0
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	RTS

EndDecrunch
	tst.l	D5
	bne	error$
	rts

error$:
	lea	DecErr(pc),A0
	JSRGEN	SetExitRoutine
	JSRGEN	InGameExit
	move.w	#$F00,$DFF180
	bra	error$

ReadSectors:
	STORE_REGS
	moveq	#0,D0
	JSRGEN	GetDiskPointer
	move.l	D0,A0

	moveq	#0,D0
	moveq	#0,D1
	moveq	#0,D2
	moveq	#0,D3
	
	move.w	$27A6.W,D0	; disk side
	mulu.w	#$B,D0
	lsl.l	#8,D0
	add.l	D0,D0
	

	move.w	$27A8.W,D1	; start track (track = both sides ($2C00))
	mulu.w	#$B,D1
	lsl.l	#8,D1
	add.l	D1,D1
	add.l	D1,D1

	add.l	D0,D1
	add.l	D1,A0		; source buffer

	move.l	$27AE,A1	; destination buffer

	move.w	$27AA,D2	; sector offset
	subq	#1,D2
	lsl.l	#7,D2
	add.l	D2,D2
	add.l	D2,D2
	add.l	D2,A0


	move.l	#$1400,D4	; real track length
	sub.l	D2,D4
	bmi	error$

	move.w	$27AC,D3
	lsl.l	#7,D3

copy$
	move.l	(A0)+,(A1)+
	subq.l	#4,D4
	bne	skip$
	add.l	#$1800,A0
	move.l	#$1400,D4	; real track length
skip$
	subq.l	#1,D3
	bne.b	copy$

	move.l	A1,$27AE
	clr.w	$27AC

	JSRGEN	ResetSprites

	RESTORE_REGS
	RTS

error$
	JSRGEN	WaitMouse
	JSRGEN	InGameExit

MemErr:
	Mac_printf	"** Not enough memory to run James Pond!"
	JMPABS	CloseAll

DecErr:
	Mac_printf	"** Decrunch failed. Disk corrupt!"
	Mac_printf	"   Press RETURN"
	JSRABS	WaitReturn
	RTS

trainer:
	dc.l	0
ExtBase:
	dc.l	0



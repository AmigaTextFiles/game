; *** Written by Jean-François Fabre


	include	"jst.i"

	HD_PARAMS	"immortal.d",STD_DISK_SIZE,2	; JST loader parameters
	SET_VARZONE	startvar,endvar			; snapshot saved variables

loader:
	RELOC_MOVEL	D0,trainer

	move.l	#$80000,D0
	JSRABS	AllocExtMem
	RELOC_MOVEL	D0,ExtBase
	beq	MemErr

	Mac_printf	"Immortal HD Loader V1.1a"
	Mac_printf	"Coded by Jean-François Fabre © 1998"

	RELOC_TSTL	trainer
	beq	skip$

	NEWLINE
	Mac_printf	"Trainer activated"
skip$
	JSRABS	LoadDisks

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

;	WAIT_LMB

	GO_SUPERVISOR
	SAVE_OSDATA	$80000

	JSRGEN	FreezeAll
	move	#$2700,SR

	lea	$DFF000,A6
	MOVE	#$7FFF,154(A6)		;0EC: 3D7C7FFF009A
	MOVE	#$7FFF,156(A6)		;0F2: 3D7C7FFF009C
	MOVE	#$8640,150(A6)		;0F8: 3D7C86400096

	bsr	InstallBoot

	sub.l	A0,A0
	sub.l	A1,A1

	; **** boot stuff and patch

	JSRGEN	FlushCachesHard

	move.l	ExtBase(pc),D0
	jmp	$10000
	

PatchLoader1:
	PATCHUSRJMP	$5A5C.W,ReadSectors
	move.w	#$4E75,$620A.W

	PATCHUSRJSR	$26970,KbInt

	PATCHUSRJSR	$26990,Delay
	move.w	#$4E71,$2698E

	PATCHUSRJSR	$2462A,WaitD6
	PATCHUSRJSR	$24642,WaitD6
	PATCHUSRJSR	$2465A,WaitD6

	PATCHUSRJMP	$D6.W,StoreCop
	move.l	#$4EB800D6,$24754

	JSRGEN	FlushCachesHard
	add.l	#$145F6,A0
	nop
	nop
	jmp	(A0)
	nop
	nop

StoreCop:
	move.l	A1,$DFF080
	move.l	A1,$E0
	move.l	D0,-(A7)
	move.l	A1,D0
	JSRGEN	StoreCopperPointer
	move.l	(A7)+,D0
	rts

WaitD6:
	move.l	D0,-(sp)
	moveq	#0,D0
	move.w	D6,D0
	divu.w	#$30,D0
	swap	D0
	clr.w	D0
	swap	D0
	BEAM_DELAY	D0
	move.l	(sp)+,D0
	rts

InstallBoot:
	moveq	#0,D0
	move.l	#$20000,D1
	move.l	#$A2C00,D2
	lea	$10000,A0
	JSRGEN	ReadDiskPart

	PATCHUSRJMP	$11348,PatchLoader1

	move.w	#$6006,$11322	; remove a poke in ROM ????
	rts

ReadSectors:
	movem.l	A0/D0-D2,-(a7)
	and.w	#$FFFF,D1
	and.w	#$FFFF,D2

	moveq	#0,D0
	cmp.w	#2,D1
	bne.b	load$
	cmp.w	#2,D2
	bne.b	load$
	move.l	diskcount(pc),D0
	cmp.l	#2,D0
	beq	load$
	RELOC_ADDL	#1,diskcount

	; remove the protection

	move.b	#$22,$101C5
	move.b	#$04,$1043C
	move.w	#$0B38,$1F770

load$
	move.l	diskcount(pc),D0
	cmp.l	#2,D0
	beq	disk2$
	moveq	#0,D0
	bra.b	call$
disk2$
	moveq.l	#1,D0

call$
	cmp.w	#$370,D1
	bcs	read$		; normal if D1 below $370
	add.l	#22,D1		; skips 2 tracks if D1 above $370
read$
	JSRGEN	ReadRobSectors
	movem.l	(a7)+,A0/D0-D2
	moveq	#0,D0
	rts

KbInt:
	move.b	$BFEC01,D0
	move.l	D0,-(A7)
	ror.b	#1,D0
	not.b	D0
	cmp.b	#$59,D0		; F10
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	cmp.b	#$42,D0		; TAB key
	bne	noicon$
	JSRGEN	InGameIconify
	move.w	#$4200,$DFF100	; set proper bpl control ( HRTMon does not restore
				; the display right unless you type e $100 $4200 )
	move.w	($DFF088),D0	; reactivate
noicon$
	move.l	(a7)+,D0
	rts

Delay:
	move.l	D0,-(sp)
	move.w	#$12C,D0
	divu.w	#$28,D0
	swap	D0
	clr.w	D0
	swap	D0
	JSRGEN	BeamDelay
	move.l	(sp)+,D0
	rts
	
MemErr:
	Mac_printf	"** Not enough memory to run Immortal!"
	JMPABS	CloseAll

startvar:
diskcount:
	dc.l	0	; this variable is saved by JST snapshot
endvar:

trainer:
	dc.l	0
ExtBase:
	dc.l	0

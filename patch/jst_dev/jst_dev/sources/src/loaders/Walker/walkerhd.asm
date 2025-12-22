; *** Walker Hard Disk Loader V1.0
; *** Written by Jean-François Fabre


	include	"jst.i"

	HD_PARAMS	"",0,0

_loader:
	RELOC_MOVEL	D0,trainer

	move.l	#$80000,D0
	JSRABS	AllocExtMem
	RELOC_MOVEL	D0,ExtBase
	beq	MemErr

	Mac_printf	"Walker HD Loader V1.2"
	Mac_printf	"Coded by Jean-François Fabre © 1997"


	RELOC_TSTL	trainer
	beq	skip$

;	NEWLINE
;	Mac_printf	"Trainer activated"
skip$

	TESTFILE	bootname
	tst.l	D0
	bne	FileErr

	move.l	#6000,D0
	JSRABS	LoadSmallFiles

	NEWLINE
	Mac_printf	"Memory used for game:"
	NEWLINE

	move.l	ExtBase(pc),D0
	cmp.l	#$80000,D0
	beq	skf$

	Mac_printf	"512K of extension mem"

	cmp.l	#$200000,D0
	bcs	memok$

skf$
	JSRABS	Test1MBChip
	tst.l	D0
	bne	only512$

	Mac_printf	"1MB of chipmem"

	move.l	ExtBase(pc),D0
	cmp.l	#$80000,D0
	beq	memok$

	RELOC_MOVEL	#$80000,SpeechBase

	bra	memok$

only512$
	Mac_printf	"512K of chipmem"
	
memok$

	RELOC_TSTL	SpeechBase
	beq	sksp$

	NEWLINE
	Mac_printf	"Speech available"
sksp$

	JSRABS	TransfRoutines		; (relocates ExtBase and SpeechBase)

	move.l	#50,D1
	move.l	_DosBase(pc),A6
	JSRLIB	Delay

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

	GO_SUPERVISOR
	RELOC_TSTL	SpeechBase
	bne	save1mb$
	SAVE_OSDATA	$80000
	bra	cont$
save1mb$
	SAVE_OSDATA	$100000
cont$
	move.l	ExtBase(pc),D0
	add.l	#$80000,D0
	move.l	D0,A7		; relocate stack to top of extmem

	bsr	PatchBoot
	JSRGEN	FlushCachesHard

	move.l	#$11000,D0
	nop
	nop
	jmp	$1A(A1)
	nop
	nop

PatchProg:
	; *** extension mem

	move.l	(4,A0),A2

	; *** read file
	
	PATCHUSRJMP	($51DA,A2),ReadFile

	; *** quit option

	PATCHUSRJSR	($4126,A2),KbInt

	; *** removes a poke in $7C

	move.w	#$6004,($18,A2)

	; *** decrunch in fastmem

	PATCHUSRJMP	($61FA,A2),Decrunch

;	move.w	#$4EF9,($631E,A2)
;	move.l	#EndDec,($6320,A2)
	
	JSRGEN	FlushCachesHard

	move.l	(4,A0),A5	; extbase
	move.l	(8,A0),A2	; speechbase
	jmp	(A5)

CheckF1:
	btst.b	#7,$BFE001
	bne	exit$

	movem.l	D1-D2,-(sp)
	move.w	$DFF000+joy1dat,D1
	move.w	D1,D2
	lsr.w	#1,D1
	eor.w	D2,D1

	btst	#8,D1
	movem.l	(sp)+,D1-D2
	rts

exit$
	move.l	ExtBase(pc),A0
	lea	($684C,A0),A0
	tst.l	($50,A0)
	rts


CheckF3:
	btst.b	#7,$BFE001
	bne	exit$

	movem.l	D1-D2,-(sp)
	move.w	$DFF000+joy1dat,D1
	move.w	D1,D2
	lsr.w	#1,D1
	eor.w	D2,D1

	btst	#0,D1
	movem.l	(sp)+,D1-D2
	rts

exit$
	move.l	ExtBase(pc),A0
	lea	($684C,A0),A0
	tst.l	($52,A0)
	rts

PatchWalker:
	move.l	ExtBase(pc),A1

	GETUSRADDR	Patch60000
	move.l	D0,$76(A1)	; trap the $60000 call	
	move.b	#$60,$3E(A1)		; remove cacr related routine

	JSRGEN	FlushCachesHard

	lea	$80000,A7
	nop
	nop
	jmp	(A1)
	nop
	nop


PatchBoot:
	move.l	#$10000,A1
	lea	bootname(pc),A0
	moveq	#0,D0
	moveq	#-1,D1
	JSRGEN	ReadFile

	; *** remove disable cache routine

	move.w	#$4E75,$E4C(A1)	

	; *** remove memory check routine

	move.l	#$70004E75,$C80(A1)	

	; *** change a gotosupervisor routine

	PATCHUSRJMP	($E84,A1),GoSup

	; *** patch read file routine

	PATCHUSRJMP	($F4,A1),ReadFile

	; *** patch fatal error -> exit

	PATCHUSRJMP	($EA,A1),FatalError
	
	; *** patch loader (walker)

	PATCHUSRJMP	($E4,A1),PatchWalker

	rts

FatalError:
	JSRGEN	WaitMouse
	JSRGEN	InGameExit
	bra	FatalError

GoSup:
	MOVEA.L	#$00DFF000,A6		;E98: 2C7C00DFF000
	MOVE	#$7FFF,intena(A6)	;E9E: 3D7C7FFF009A
	MOVE.B	#$7F,$BFED01
	MOVE.B	#$7F,$BFDD00
	MOVE	#$2000,SR
	MOVE	#$03FF,dmacon(A6)

;	MOVE.L	138(A5),D0
;	ADD.L	162(A5),D0

	move.l	ExtBase(pc),$8A(A5)	; fast or chipmem
	move.l	#$100,$86(A5)
;	clr.l	$8E(A5)
	move.l	SpeechBase(pc),$8E(A5)	; chip compulsory, maybe zero
	move.l	#$80000,$A2(A5)		; ext size

	clr.l	$92(A5)
	clr.l	$96(A5)
	clr.l	$AA(A5)

	MOVE.L	#$0,4.W
	MOVE	#$0000,168(A6)
	MOVE	#$0000,184(A6)
	MOVE	#$0000,200(A6)
	MOVE	#$0000,216(A6)
	rts

ReadFile:
	STORE_REGS

	tst.w	D0
	bne	notread$

	move.l	A0,A2
	bsr	shortname

	moveq	#-1,D1
	JSRGEN	ReadFile
	tst.l	D0
	bne	notfound$

	move.l	D0,(A7)		; error flag
	move.l	D1,4(A7)	; length

	bra	exit$
notread$
	JSRGEN	WaitMouse

exit$
	RESTORE_REGS
	rts

notfound$
	lea	FileError(pc),A0
	JSRGEN	SetExitRoutine
	JSRGEN	InGameExit
	bra	notfound$

shortname:
	
next$
	move.b	(A2)+,D4
	beq	exit$
	cmp.b	#':',D4
	bne	t2$
	move.l	A2,A0		; advance A0
	bra	next$
t2$
	cmp.b	#'/',D4
	bne	next$
	move.l	A2,A0		; advance A0
	bra	next$

exit$
	rts


Patch60000:
	PATCHUSRJMP	$615A6,ReadFile
	PATCHUSRJMP	$60F02,PatchProg

	move.b	#$60,$6003C
	move.w	#$600A,$60004

	move.l	ExtBase(pc),$64FB2

	JSRGEN	FlushCachesHard
	JSRGEN	GoECS

	; *** removes (emulates) protection

	move.l	#$75CE90E2,D7
	JMP	$60CF6

Decrunch:
	JSRGEN	RNCDecrunchEncrypted	
EndDec:
	move.l	A3,-(sp)

	; *** joystick control in menu

	move.l	ExtBase(pc),A3
	add.l	#$8000,A3
	cmp.l	#$41FAE29E,($5AC,A3)
	bne	endpatch$

	PATCHUSRJSR	($58A,A3),CheckF1
	move.w	#$4E71,($588,A3)
	PATCHUSRJSR	($5AE,A3),CheckF3
	move.w	#$4E71,($5AC,A3)
endpatch$
	move.l	(sp)+,A3

	JSRGEN	FlushCachesHard	
	rts

KbInt:
	move.b	$BFEC01,D0
	move.l	D0,-(sp)
	not.b	D0
	ror.b	#1,D0
	cmp.b	#$59,D0
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	move.l	(sp)+,D0
	rts

MemErr:
	Mac_printf	"** Not enough memory to run Walker!"
	JMPABS	CloseAll

FileErr:
	Mac_printf	"** File ''boot'' missing."
	JMPABS	CloseAll

FileError:
	Mac_printf	"** At least one file is missing. Reinstall game"
	Mac_printf	"   Press RETURN to exit"
	JSRABS	WaitReturn
	JMPABS	CloseAll


trainer:
	dc.l	0
ExtBase:
	dc.l	0
SpeechBase:
	dc.l	0
bootname:
	dc.b	"boot",0
	even

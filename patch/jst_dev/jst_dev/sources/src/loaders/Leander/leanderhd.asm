; *** Leander Hard Disk Loader V1.3
; *** Written by Jean-François Fabre 1997-1998

	include	"jst.i"

	HD_PARAMS	"",0,0

HDLOAD = 1

TEST_FILE:MACRO
	lea	disk\1file(pc),A0
	move.l	A0,D0
	JSRABS	TestFile
	tst.l	D0
	bne	FileErr
	ENDM

loader:
	RELOC_MOVEL	D0,trainer
	RELOC_MOVEL	D4,buttonwait

	Mac_printf	"Leander HD Loader V1.3a"
	Mac_printf	"Coded by Jean-François Fabre © 1997-1998"

	move.l	trainer(pc),D0
	beq	trskip$

	NEWLINE
	Mac_printf	"Trainer mode activated"
trskip$
	TEST_FILE	1
	TEST_FILE	2
	TEST_FILE	3

	bsr	ReadScores
	tst.l	D0
	beq	sk$

	Mac_printf	"** Could not read score file"
sk$
	move.l	#1000,D0
	JSRABS	LoadSmallFiles

	; *** try to find external memory (fails for 32bit memory)

	move.l	#$80000,D0
	JSRABS	AllocExtMem
	RELOC_MOVEL	D0,ExtBase
	bne	suite$			; OK

	; *** 512K extension (may fail)

;	RELOC_MOVEL	#$80000,ExtBase
;	RELOC_MOVEL	#$F,ExtFlag
;	bra	suite$

	; *** only the 512K chipmem used
noext$
	RELOC_CLRL	ExtSize
	RELOC_CLRL	ExtFlag
	RELOC_CLRL	ExtBase

suite$

	moveq.l	#0,D0
	move.l	#-1,D1
	JSRABS	Degrade

	GO_SUPERVISOR
	SAVE_OSDATA	$80000

LeanderBoot:
	move.l	ExtBase(pc),D0
	MOVE.L	ExtSize(pc),D1
	MOVE.l	ExtFlag(pc),D2

;;	MOVEA.L	#$00080000,A7
	MOVEA.L	#$00DFF000,A6
	JSRGEN	FreezeAll
	MOVE.L	D0,$4.W		; extension base pointer
	MOVE.L	D1,$8.W		; memory extension size

	; *** Clear a zone from $400 to $70000

	MOVEA.L	#$00000400,A0
	MOVE.L	#$0001BF00,D0
clear$:
	MOVE.L	#0,(A0)+
	SUBQ.L	#1,D0
	BNE	clear$

	lea	boot(pc),A0
	lea	$400.W,A1
	move.l	#endboot-boot-1,D0
	lsr.l	#2,D0

copy$
	move.l	(A0)+,(A1)+
	dbf	D0,copy$

	PATCHUSRJMP	$66E.W,DiskRoutine
	PATCHUSRJMP	$500.W,PatchLoader1
	JSRGEN	FlushCachesHard

	JMP	$400.W

DiskRoutine:
	cmp.b	#5,D1
	beq	DR_DirRead
	cmp.b	#0,D1
	beq	DR_FileRead

	cmp.b	#1,D1
	beq	DR_FileWrite

	moveq.l	#0,D0
	JSRGEN	WaitMouse
	bra	DR_End

	; *** load the file

DR_FileRead:
	moveq.l	#0,D0
	moveq.l	#-1,D1
	
	JSRGEN	ReadFile
	tst.l	D0
	bmi	DR_End	; not found : return -1 in D0

	bsr	WaitOnLevel

	move.l	D0,D1
	moveq.l	#0,D0
	bra	DR_End

; *** read directory

DR_DirRead:
	moveq.l	#0,D1
	moveq.l	#0,D0	

DR_End:
	MOVEM.L	(A7)+,D2-D7/A0-A6
	RTS

; *** other commands, still not supported

DR_Other:
	cmp.w	#1,D1
	beq	DR_FileWrite

	JSRGEN	WaitMouse
	JSRGEN	InGameExit
	bra	DR_Other

; *** write file (only score)
; D0 holds the length to write but we ignore it
; because we write only the scores

DR_FileWrite:
	; *** if something else than the scorefile is written, ignore it

	move.l	A0,D1
	GETUSRADDR	scorename
	JSRGEN	StrcmpAsm
	tst.l	D0
	bne	notscore$

	; *** copy the scores in fast memory

	lea	scorebuffer(pc),A2
	move.w	#$C7,D1
scopy$
	move.b	(A1)+,(A2)+
	dbf	D1,scopy$

	; *** set the exit routine; so the scores will
	; *** be saved on exit

	lea	WSOnExit(pc),A0
	JSRGEN	SetExitRoutine

	moveq.l	#0,D0
	move.l	#$C8,D1
	bra	DR_End

notscore$
	JSRGEN	WaitMouse
	moveq.l	#-1,D0
	moveq.l	#0,D1
	bra	DR_End


WaitOnLevel
	move.l	buttonwait(pc),D2
	beq	sk$

	cmp.b	#'L',(A0)
	bne	sk$
	cmp.b	#'E',1(A0)
	bne	sk$
	cmp.b	#'V',2(A0)
	bne	sk$

wb$
	btst	#6,$bfe001
	beq	sk$
	btst	#7,$bfe001
	bne	wb$
sk$
	rts



ReadScores:
	lea	scorename(pc),A0
	lea	scorebuffer(pc),A1
	move.l	#$C8,D1
	moveq.l	#0,D0
	JSRGEN	ReadUserFileHD
	rts

WSOnExit:
	bsr	WriteScores
	tst.l	D0
	beq	wok$
	Mac_printf	"** Could not save scores"
	Mac_printf	"   Hit Return to exit"
	JSRABS	WaitReturn
wok$
	rts

WriteScores:
	lea	scorename(pc),A0
	lea	scorebuffer(pc),A1
	move.l	#$C8,D1
	moveq.l	#0,D0
	JSRGEN	WriteUserFileHD
	rts


FileErr:
	Mac_printf	"** Please install the game properly"
	JMPABS	CloseAll


_UserPatchRoutines:

PatchLoader1:
	bsr	LocalPatchExcept

	move.l	A0,-(sp)

	; *** patch the disk routine

	PATCHUSRJMP	$5CC0.W,DiskRoutine	

	; *** set up the new patch
	; *** at 2 locations

	PATCHUSRJMP	$5C1E.W,PatchLoader2
	PATCHUSRJMP	$5BE8.W,PatchLoader2

	; *** remove another disk routine

	move.l	#$60000204,$7778.W

	move.l	(sp)+,A0
	jmp	$5AA0.W

PatchLoader2:
	STORE_REGS
	bsr	LocalPatchExcept

	; *** remove another disk routine

	move.l	#$60000216,$7121A

	; *** patch the disk routine

	PATCHUSRJMP	$704EC,DiskRoutine	

	; *** install the quit key

	PATCHUSRJSR	$7FEA0,kbint

	; *** remove life-decrease in case of trainer mode

	RELOC_TSTL	trainer
	beq	trskip$

	move.l	#$4E714E71,D0
	lea	$6BE58,A0
	move.l	D0,(A0)+
	move.l	D0,(A0)+
trskip$

	RESTORE_REGS
	jmp	$609F8

kbint:
	move.b	#0,$C00(A0)
	cmp.b	#$5F,D0
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	rts


LocalPatchExcept:
	move.l	$8.W,-(sp)	; used by the game to store data
	JSRGEN	PatchExceptions
	move.l	(sp)+,$8.W
	rts



ExtBase:
	dc.l	0
ExtSize:
	dc.l	0
ExtFlag:
	dc.l	0
buttonwait:
	dc.l	0
trainer:
	dc.l	0

scorebuffer:
	blk.b	$C8,0
	cnop	0,4

boot:
	incbin	"chip.bin"
endboot:
	cnop	0,4

scorename:
	dc.b	"SCORES",0


disk1file:
	dc.b	"PSYLOGO",0

disk2file:
	dc.b	"WORLD1",0

disk3file:
	dc.b	"QUEST3",0

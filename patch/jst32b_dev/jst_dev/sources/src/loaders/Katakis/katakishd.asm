; *** Written by Jean-François Fabre


	include	"jst.i"

	HD_PARAMS	"katakis.d",STD_DISK_SIZE,1

loader:
	RELOC_MOVEL	D0,trainer

	Mac_printf	"Katakis HD Loader V1.0"
	Mac_printf	"Coded by Jean-François Fabre © 1998"

	RELOC_TSTL	trainer
	beq	skip$

	NEWLINE
	Mac_printf	"Trainer activated"
skip$
	bsr	LoadScores

	JSRABS	LoadDisks

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

;;	WAIT_LMB

	GO_SUPERVISOR
	SAVE_OSDATA	$80000

	JSRGEN	FreezeAll

	bsr	InstallBoot

	move.w	#$8040,$DFF096
	move	#$2000,SR

	; **** boot stuff and patch

	PATCHGENJMP	$BA.W,InGameExit
	JSRGEN	FlushCachesHard
	moveq	#0,D7

	nop
	nop
	jmp	$C0.W
	nop
	nop

LoadScores:
	moveq.l	#0,D0
	move.l	#200,D1
	lea	hiscname(pc),A0
	lea	hiscbuff(pc),A1
	JSRGEN	ReadUserFileHD
	tst.l	D0
	beq	exit$

	Mac_printf	"** Hi-score file not found"
exit$
	rts

SaveScores:
	moveq.l	#0,D0
	move.l	#200,D1
	lea	hiscname(pc),A0
	lea	hiscbuff(pc),A1
	JSRGEN	WriteUserFileHD
	tst.l	D0
	beq	exit$

	Mac_printf	"** Cannot save hi-score file"
	Mac_printf	"   Hit RETURN to exit"
	JSRABS	WaitReturn
exit$
	rts

InstallBoot:
	JSRGEN	InitTrackDisk
	MOVE	#$0002,28(A1)		;0C: 337C0002001C
	MOVE.L	#$0004EF6C,40(A1)	;12: 237C0004EF6C0028
	MOVE.L	#$00022600,36(A1)	;1A: 237C000226000024
	MOVE.L	#$0008DA00,44(A1)	;22: 237C0008DA00002C
	JSRGEN	TrackLoad

	lea	$4F000,A0
	lea	$C0.W,A1
	lea	$300C0,A2
copy$
	move.l	(A0)+,(A1)+
	cmp.l	A1,A2
	bne.b	copy$

	; hiscore read

	PATCH_RTS	$A60

	; hiscore save

	PATCHUSRJMP	$AFC,StoreHiscores

	; trackload

	PATCHUSRJMP	$1D2FE,ReadAndUnpack
	
	; keyboard

	PATCHUSRJSR	$30C0,KbInt
	move.w	#$C038,$152.W

	; hiscores

	lea	hiscbuff(pc),A0
	lea	$1CA12,A1
	move.w	#79,D0
copy2$
	move.l	(A0)+,(A1)+
	dbf	D0,copy2$

	rts

StoreHiscores:
	STORE_REGS
	lea	hiscbuff(pc),A0
	lea	$1CA12,A1
	move.w	#79,D0
copy2$
	move.l	(A1)+,(A0)+
	dbf	D0,copy2$
	
	lea	SaveScores(pc),A0
	JSRGEN	SetExitRoutine
	
	RESTORE_REGS
	rts

KbInt:
	cmp.b	#$59,D0
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	BEAM_DELAY	#2
	rts

ReadAndUnpack:
	STORE_REGS

	subq.l	#8,D2
	move.l	D2,A0
	mulu	#$1600,D0
	mulu	#$1600,D1
	
	move.l	D0,D2		; offset
	moveq	#0,D0		; disk 1

	JSRGEN	ReadDiskPart

	move.l	A0,A1
	addq.l	#8,A1
	bsr	Decrunch

	RESTORE_REGS
	rts


trainer:
	dc.l	0
ExtBase:
	dc.l	0

hiscname:
	dc.b	"katakis.hisc",0
	cnop	0,4

hiscbuff:
	incbin	"def_hisc.bin"
	blk.l	10,0
Decrunch:
	incbin	"dec_1d770.bin"
	rts

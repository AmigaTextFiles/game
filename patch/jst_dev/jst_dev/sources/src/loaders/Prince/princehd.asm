; *** Prince Hard Disk Loader V1.2
; *** Written by Jean-François Fabre


	include	"jst.i"
				not a standard disk!
				     |
	HD_PARAMS	"Prince.d",509952,1

loader:
	RELOC_MOVEL	D0,trainer	; store trainer flag for later

	Mac_printf	"Prince Of Persia HD Loader V1.2"
	Mac_printf	"Coded by Jean-François Fabre © 1997-1998"

	RELOC_TSTL	trainer
	beq	skip$

	NEWLINE
	Mac_printf	"Trainer activated: Infinite energy and time"
skip$
	bsr	LoadGameHD	; try to read savegame buffer

	JSRABS	LoadDisks	; read diskfile (unless LOWMEM is on)

	; *** allocate external mem (optionnal in the game but compulsory in this loader)

	move.l	#$80000,D0
	JSRABS	AllocExtMem
	RELOC_MOVEL	D0,ExtBase
	beq	MemErr

	bsr	checkversion	; there are (at least) 3 different versions around

	moveq.l	#0,D0
	move.l	#-1,D1
	JSRABS	Degrade		; no caches at all, goto PAL
	
;	WAIT_LMB

	GO_SUPERVISOR		; supervisor mode
	SAVE_OSDATA	$80000	; saves $0-$80000 chipmem
	move	#$2700,SR	; no interrupts
	lea	$10000,A7	; relocates stack

	; **** boot stuff and patch

	bsr	installboot	; installs bootprog
	bsr	patchboot	; patches bootprog

	JSRGEN	FlushCachesHard	; cache flush
	move.l	version(pc),D0	; different versions -> different jumps
	cmp.l	#2,D0
	beq	v2$
	jmp	$7E986		; same for V1 and V3
v2$
	jmp	$7E988
	nop
	nop

PatchProg:
	STORE_REGS

	; *** removes protection level (common to both versions)

	move.l	#-1,$6378.W


	move.l	version(pc),D0
	cmp.l	#1,d0
	bne	version2

version1:
	; *** removes unexpected exception

	move.w	#$6004,$195E8

	; *** quit key

	PATCHUSRJSR	$1A322,kbint

	; *** load/save

	PATCHUSRJMP	$C770,SaveGame_V1
	PATCHUSRJMP	$C808,LoadGame_V1

	move.l	trainer(pc),D0	; trainer ON?
	beq	skipt$

	; *** time--

	move.l	#$4E714E71,$1926A
	move.w	#$4E71,$1926E

	; *** time=15 (levelskip)

	move.b	#$60,$190D6

	; *** infinite energy

	PATCHUSRJSR	$C622,Trainer_V1

skipt$

	JSRGEN	FlushCachesHard		; cache flush!

	RESTORE_REGS
	jmp	$1F662


version2:
	cmp.l	#2,d0
	bne	version3

	; *** removes unexpected exception

	move.w	#$6004,$195B6

	; *** quit key

	PATCHUSRJSR	$1A2F0,kbint

	; *** if exception exit

;	PATCHUSRJMP	$7F38E,error

	; *** load/save

	PATCHUSRJMP	$C774,SaveGame_V2
	PATCHUSRJMP	$C806,LoadGame_V2

	; *** trainer

	move.l	trainer(pc),D0
	beq	skipt$

	; *** time--

	move.l	#$4E714E71,$19238
	move.w	#$4E71,$1923C

	; *** time=15 (levelskip)

	move.w	#$703C,$190A6
	move.w	#$703C,$1909C

	; *** infinite energy

	PATCHUSRJSR	$C626,Trainer_V2

skipt$
	JSRGEN	FlushCachesHard		; cache flush!

	RESTORE_REGS
	jmp	$1F636

version3:
	; *** removes unexpected exception

	move.w	#$6004,$195C0

	; *** quit key

	PATCHUSRJSR	$1A2FA,kbint

	; *** load/save

	PATCHUSRJMP	$C748,SaveGame_V3
	PATCHUSRJMP	$C7E0,LoadGame_V3

	move.l	trainer(pc),D0
	beq	skipt$

	; *** time--

	move.l	#$4E714E71,$19242
	move.w	#$4E71,$19246

	; *** time=15 (levelskip)

	move.b	#$60,$190AE

	; *** infinite energy

	PATCHUSRJSR	$C5FA,Trainer_V3

skipt$
	
	JSRGEN	FlushCachesHard		; cache flush!

	RESTORE_REGS
	jmp	$1F63A

error:
	JSRGEN	WaitMouse
	JSRGEN	InGameExit
	bra	error

installboot:
	lea	$7E800,A0
	moveq.l	#0,D0
	move.l	#$1800,D1
	moveq.l	#0,D2
	JSRGEN	ReadDiskPart	; read first $1800 bytes of the disk
	rts

patchboot:
	move.l	version(pc),D0
	cmp.l	#2,D0
	beq	patchboot2

	; same patches for boot in V1 and V3

patchboot1:
	; 512K expansion memory

	PATCHUSRJMP	$7EAA0,GetExtMem

	; disk load

	PATCHUSRJMP	$7EE24,ReadTracks
	move.l	#$4E714E71,$7EA2A
	move.w	#$6006,$7E9E6

	;	** $7EE4C load

	move.w	#$6044,$7E8A6

	PATCHUSRJMP	$7EA2E,PatchProg
	rts


patchboot2:
	PATCHUSRJMP	$7EAA4,GetExtMem
	PATCHUSRJMP	$7EE28,ReadTracks
	move.l	#$4E714E71,$7EA2C
	move.w	#$6006,$7E9E8

;	** $7EE4C load

	move.w	#$6044,$7E8A8

	PATCHUSRJMP	$7EA30,PatchProg
	rts


kbint:
	move.b	$BFEC01,D2
	move.l	D2,-(sp)
	not.b	D2
	ror.b	#1,D2
	cmp.b	#$59,D2		; F10 pressed?
	bne	noquit$
	JSRGEN	InGameExit	; clean quit to WB
noquit$
	move.l	(sp)+,D2
	rts

Trainer_V1:
	tst.l	D0
	bne	nodie$
	CLR.L	$47AD4
nodie$
	RTS


Trainer_V2:
	tst.l	D0
	bne	nodie$
	CLR.L	$479FC
nodie$
	RTS

Trainer_V3:
	tst.l	D0
	bne	nodie$
	CLR.L	$47AAC
nodie$
	RTS

SaveGame_V3:
	movem.l	D1-A6,-(sp)
	lea	savebuff(pc),A1
	move.l	$63A6,(A1)+
	move.l	$47AE8,(A1)+
	move.l	$47ADC,(A1)+
	move.l	$47AE0,(A1)+
	lea	SaveGameHD(pc),A0
	JSRGEN	SetExitRoutine		; SaveGameHD called on exit to write on HD
	moveq	#$10,D0
	movem.l	(sp)+,D1-A6
	rts

LoadGame_V3:
	movem.l	D1-A6,-(sp)
	lea	savebuff(pc),A1
	cmp.l	#'FUCK',(A1)		; valid save data?
	beq	err$

	move.l	(A1)+,$47AE4
	move.l	(A1)+,$47AE8
	move.l	(A1)+,$47ADC
	move.l	(A1)+,$47AE0
	moveq	#$10,D0

	move.l	#1,$470AE

	movem.l	(sp)+,D1-A6
	rts

err$
	moveq	#$0,D0
	movem.l	(sp)+,D1-A6
	rts





SaveGame_V1:
	movem.l	D1-A6,-(sp)
	lea	savebuff(pc),A1
	move.l	$47AB8,(A1)+
	move.l	$47B10,(A1)+
	move.l	$47B04,(A1)+
	move.l	$47B08,(A1)+
	lea	SaveGameHD(pc),A0
	JSRGEN	SetExitRoutine
	moveq	#$10,D0
	movem.l	(sp)+,D1-A6
	rts

LoadGame_V1:
	movem.l	D1-A6,-(sp)
	lea	savebuff(pc),A1
	cmp.l	#'FUCK',(A1)
	beq	err$

	move.l	(A1)+,$47B0C
	move.l	(A1)+,$47B10
	move.l	(A1)+,$47B04
	move.l	(A1)+,$47B08
	moveq	#$10,D0

	move.l	#1,$470D6

	movem.l	(sp)+,D1-A6
	rts

err$
	moveq	#$0,D0
	movem.l	(sp)+,D1-A6
	rts

SaveGame_V2:
	movem.l	D1-A6,-(sp)
	lea	savebuff(pc),A1
	move.l	$63A6.W,(A1)+		; level
	move.l	$47A38,(A1)+		; max energy
	move.l	$47A2C,(A1)+		; minutes left
	move.l	$47A30,(A1)+		; milli-minutes???
	lea	SaveGameHD(pc),A0
	JSRGEN	SetExitRoutine
	moveq	#$10,D0
	movem.l	(sp)+,D1-A6
	rts

LoadGame_V2:
	movem.l	D1-A6,-(sp)
	lea	savebuff(pc),A1
	cmp.l	#'FUCK',(A1)
	beq	err$

	move.l	(A1)+,$47A34
	move.l	(A1)+,$47A38
	move.l	(A1)+,$47A2C
	move.l	(A1)+,$47A30
	moveq	#$10,D0

	move.l	#1,$46FFE	; tell the game not to reset life/time
	movem.l	(sp)+,D1-A6
	rts

err$
	moveq	#$0,D0
	movem.l	(sp)+,D1-A6
	rts

GetExtMem:
	move.l	ExtBase(pc),A0
	rts

; A1=buffer, D0=begtrack, D1=length in tracks

ReadTracks:
	STORE_REGS
	move.l	A1,A0	; destination buffer

	subq.l	#1,D0	; always >=1
	bcs exit$	; impossible ??
	
	and.w	#$FFFF,D1
	mulu.w	#$C,D1
	lsl.l	#8,D1
	add.l	D1,D1	; * $1800 = length

	and.w	#$FFFF,D0
	mulu.w	#$C,D0
	lsl.l	#8,D0
	add.l	D0,D0	; * $1800 = offset

	move.l	D0,D2
	moveq.l	#0,D0
	JSRGEN	ReadDiskPart

exit$
	moveq.l	#-1,D0
	tst.l	D0
	RESTORE_REGS
	rts


checkversion:
	moveq.l	#0,D0
	moveq.l	#4,D2
	moveq.l	#4,D1
	lea	verbuff(pc),A0
	JSRGEN	ReadDiskPart	; read only 4 bytes to check the version
	move.l	(A0),D0

	cmp.l	#$FFFF,D0
	bne	notv2$
	RELOC_MOVEL	#2,version
	rts
notv2$
	cmp.l	#0,D0
	bne	notv1$
	RELOC_MOVEL	#1,version
	rts

notv1$
	cmp.l	#3,D0
	bne	VerErr
	RELOC_MOVEL	#3,version
	rts
	



LoadGameHD:
	RELOC_MOVEL	#'FUCK',savebuff	; invalidate file

	
	lea	savename(pc),A0
	lea	savebuff(pc),A1
	move.l	#$10,D1
	moveq.l	#0,D0
	JSRGEN	ReadUserFileHD
	tst.l	D0
	beq	exit$
	Mac_printf	"** Savegame file not found"
exit$
	rts

; called when the OS is active to save the scores if SAVE was
; pressed (CTRL-G)

SaveGameHD:
	lea	savename(pc),A0
	lea	savebuff(pc),A1
	move.l	#$10,D1
	moveq.l	#0,D0
	JSRGEN	WriteUserFileHD
	tst.l	D0
	beq	exit$
	Mac_printf	"   Can't create save game file"
	Mac_printf	"** Press RETURN to exit"
	JMPABS	WaitReturn
exit$
	rts


VerErr:
	Mac_printf	"** Unsupported version. Please contact the author"
	JMPABS	CloseAll

MemErr:
	Mac_printf	"** Not enough memory!"
	JMPABS	CloseAll


trainer:
	dc.l	0
ExtBase:
	dc.l	0
version:
	dc.l	0
savebuff:
	blk.l	4,0

	; name for the save game file

savename:
	dc.b	"PRINCE.SAV",0
	cnop	0,4

	; space for version buffer (4 bytes+4 safety bytes)

verbuff:
	dc.l	0,0

; *** ATR HD Loader
; *** Written by Jean-François Fabre (jffabre@ensica.fr)

	include	"jst.i"

	HD_PARAMS	"ATR.d",STD_DISK_SIZE,2


loader:
	move.l	#$80000,D0
	JSRABS	AllocExtMem
	RELOC_MOVEL	D0,ExtBase
	beq	MemErr

	Mac_printf	"ATR HD Loader V1.1"
	Mac_printf	"Coded by Jean-Francois Fabre © 1996/1997"

	JSRABS	LoadDisks

	move.l	#CACRF_CopyBack,D1
	moveq.l	#0,D0
	JSRABS	Degrade

;	WAIT_LMB

	GO_SUPERVISOR
	SAVE_OSDATA	$80000

	PATCHGENJMP	$C0,InGameExit

	bsr	InstallBoot


	JSRGEN	FlushCachesHard
	move.l	ExtBase(pc),$F00.W
	jmp	$78034

PatchLoader1:
	PATCHUSRJSR	$17E4.W,kbint
	PATCHUSRJSR	$11A2A,SetDisk2
	PATCHUSRJMP	$8D96,Patch2
	PATCHUSRJMP	$58F0.W,ReadSectors

	JSRGEN	GoECS
	JSRGEN	FlushCachesHard
	nop
	nop
	jmp	$1000.W
	nop
	nop

Patch2:
	move.l	#$6A616D69,$6BC00
	move.l	#$65313233,$6BC04
	jmp	$8DBA

InstallBoot:
	lea	$78000,A0
	move.l	#$1200,D1
	move.l	#$400,D2
	moveq	#0,D0
	JSRGEN	ReadDiskPart

	PATCHUSRJMP	$787A2,ReadSectors
	PATCHUSRJMP	$78096,PatchLoader1
	rts


MemErr:
	Mac_printf	"** Not enough memory to run ATR"
	JMPABS	CloseAll

ReadSectors:
	moveq.l	#0,D0
	move.w	currdisk(pc),D0
	JSRGEN	ReadRobSectors
	rts

	cnop	0,4
SetDisk2:
	lea	currdisk(pc),A1
	move.w	#1,(A1)
	rts


kbint:
	move.b	$C00(A0),D0
	not.b	D0

	move.l	D0,-(sp)

	ror.b	#1,D0
	cmp.b	#$59,D0
	bne	kbend

	; *** try to quit

	JSRGEN	InGameExit

kbend:
	move.l	(sp)+,D0
	rts

ExtBase:
	dc.l	0
currdisk:
	dc.l	0

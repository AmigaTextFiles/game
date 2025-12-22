; *** Qwak HD Loader V1.3c
; *** Written by Jean-François Fabre (jffabre@ensica.fr)

; *** A simple example of a hd loader (my first one actually)


	MACHINE	68000

	include	"jst.i"

	HD_PARAMS	"Qwak.d",STD_DISK_SIZE,1

loader:
	move.l	#$80000,D0
	JSRABS	AllocExtMem
	RELOC_MOVEL	D0,ExtBase
	beq	MemErr		; extension mem is necessary
	
	Mac_printf	"QWAK HD Loader V1.3c (JST final)"
	Mac_printf	"Coded by Jean-Francois Fabre © 1995-1997"

	JSRABS	LoadDisks

	move.l	#CACRF_CopyBack,D1
	moveq.l	#0,D0
	JSRABS	Degrade

	GO_SUPERVISOR
	SAVE_OSDATA	$80000

	LEA	$0007F000,A7
	MOVE	#$2700,SR
	JSRGEN	FreezeAll
	BSET	#$01,$00BFE001

	move.l	#0,D3
	move.l	#2,D1
	move.l	#$60000,A0
	move.l	#$16,D2
	JSRGEN	ReadRobSectors

	PATCHUSRJMP	$60086,PatchLoader1
	PATCHGENJMP	$6078E,ReadRobSectors

	JSRGEN	FlushCachesHard

	move.l	ExtBase(pc),$FFC.W
	JMP	$60034

PatchLoader1:
	STORE_REGS

	PATCHUSRJSR	$11FC.W,kbint		; keyboard
	PATCHGENJMP	$29AC.W,ReadRobSectors	; disk

	JSRGEN	GoECS
	JSRGEN	FlushCachesHard
	RESTORE_REGS
	jmp	$1000.W

kbint:
	cmp.b	#$59,D0
	bne	kbend

	; *** try to quit

	JSRGEN	InGameExit

kbend:
	bset	#6,$E00(A0)
	rts

ExtBase:
	dc.l	0	; extension memory location

MemErr:
	Mac_printf	"** Not enough memory to run QWAK. Set the NOFAST tooltype"
	JMPABS	CloseAll



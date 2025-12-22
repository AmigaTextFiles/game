; *** Arcade Pool Hard Disk Loader BETA
; *** Written by Jean-François Fabre

	include	"syslibs.i"
	include	"jst.i"

	HD_PARAMS	"disk.",$EC800,1

BOOT_SIZE = 22528

loader:
	move.l	#$100000,D0
	JSRABS	AllocExtMem

	Mac_printf	"Arcade Pool HD Loader v2.0"
	Mac_printf	"Coded by Jean-François Fabre © 1997-1999"
	NEWLINE
	Mac_printf	"Thanks to Chris Vella"

	JSRABS	CheckFastMem
	tst.l	D0
	bne.b	.fastok
	RELOC_STL	nofast
.fastok:

	JSRABS	UseHarryOSEmu
	JSRABS	LoadDisks

	moveq.l	#0,D0
	moveq.l	#0,D1
	JSRABS	Degrade

	GO_SUPERVISOR
	RELOC_TSTL	nofast
	bne.b	.save1meg

	SAVE_OSDATA	$0
	bra	.boot
.save1meg
	SAVE_OSDATA	$100000
.boot
	bsr	InstallBoot

	JSRGEN	FlushCachesHard

	; *** jump whereever you want


	move.l	bootbase(pc),A0
	nop
	nop
	jmp	$40C(A0)
	nop
	nop

InstallBoot:
	; allocates mem for boot file

	JSRGEN	EnterDebugger

	move.l	#BOOT_SIZE,D0
	move.l	#MEMF_CHIP,D1
	move.l	4,A6
	JSRLIB	AllocMem
	RELOC_MOVEL	D0,bootbase

	; read the boot file

	move.l	bootbase(pc),A0
	moveq.l	#0,D0
	move.l	#BOOT_SIZE,D1
	moveq.l	#0,D2
	JSRGEN	ReadDiskPart

	; patch the boot file

	move.l	bootbase(pc),A0

	move.l	($DC6,A0),d0
	cmp.l	#$48E77FFC,D0
	bne	.v2

	PATCHUSRJMP	($DC6,A0),ReadSectors
	PATCHUSRJSR	($48A,A0),PatchLoader1_V1
	bra	.cont

.v2
	PATCHUSRJMP	($DEC,A0),ReadSectors
	PATCHUSRJSR	($48A,A0),PatchLoader1_V2


.cont
	rts

MemErr:
	Mac_printf	"** Not enough memory to run Arcade Pool!"
	JMPABS	CloseAll

PatchLoader1_V2:
	move.l	16(A0),A0	; extbase

	PATCHUSRJMP	($330E,A0),ReadSectors
	bra.b	ReRun

PatchLoader1_V1:
	move.l	16(A0),A0	; extbase

	PATCHUSRJMP	($32E8,A0),ReadSectors

ReRun:
	JSRGEN	FlushCachesHard
	jmp	(A0)


ReadSectors:
	move.l	D1,-(sp)
	sub.w	#$4,D1			; -4 12 sectored tracks + 4 11 sectored tracks
	JSRGEN	ReadRobSectors
	move.l	(sp)+,D1
	moveq	#0,D0
	rts

bootbase:
	dc.l	0
nofast:
	dc.l	0

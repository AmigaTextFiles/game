; *** Blastar Hard Disk Loader V$VER
; *** Written by Jean-François Fabre


	include	"jst.i"

;			   disk		disk	number
;			   image	size	  of
;			   name		(DOS)	disks
;			    |		  |	  |
	HD_PARAMS	"Blastar.d",STD_DISK_SIZE,3

_loader:
	move.l	#$80000,D0	; 512K
	JSRABS	AllocExtMem	; allocates the extra 512K which the game needs
	RELOC_MOVEL	D0,ExtBase	; stores it (relocated macro)
	beq	MemErr			; 0 > no mem!

	Mac_printf	"Blastar JST HD Loader V1.2"
	Mac_printf	"Programmed by Jean-François Fabre © 1997"

	JSRABS	LoadDisks	; loads disk data (except if LOWMEM is on)
				; if HDLOAD is on, load only first disk

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1	; disable copyback cache
	JSRABS	Degrade			; set display to PAL (unless NTSC is on)

;	WAIT_LMB			; enable it and you can break here using HRTMon

	GO_SUPERVISOR			; supervisor mode (macro)
	SAVE_OSDATA	$80000		; saves 0->$80000 (it will be overwritten by game)

	; **** boot stuff and patch

	bsr	loadboot		; loads the boot program

	JSRGEN	InitTrackDisk		; trackdisk emulation
	
	PATCHUSRJMP	$6004A,PatchLoader1	; sets a patch

	JSRGEN	FlushCachesHard		; caches flush
	JMP	$60000			; jump!


PatchLoader1:
	JSRGEN	TrackLoad

	PATCHGENJMP	$7EBB0,RNCDecrunch	; faster decrunch (the game uses RNC)
	PATCHUSRJMP	$7EADE,GetExtMem	; emulates search for extra mem
	PATCHUSRJMP	$7E362,ReadSectors	; read sectors (RobNorthen routine)
	PATCHUSRJMP	$7EB8A,PatchProg	; another patch

	JSRGEN	FlushCachesHard			; caches flush (we just patched)

	jmp	$7A000				; game again

PatchProg:
	move.l	ExtBase(pc),A0			; get extension pointer in A0
	STORE_REGS				; save registers

	; *** disk load routine

	move.l	A0,A1
	add.l	#$2D5D2,A1
	move.w	#$4EF9,(A1)+
	GETUSRADDR	ReadSectors
	move.l	D0,(A1)

;	move.l	A0,A1
;	add.l	#$2686A,A1
;	move.w	#$4EF9,(A1)+
;	GETGENADDR	RNCDecrunch
;	move.l	D0,(A1)

	; *** keyboard interrupt

	move.l	A0,A1
	add.l	#$9514,A1
	move.w	#$4EB9,(A1)+
	GETUSRADDR	kbint
	move.l	D0,(A1)

	; *** activates trainer keys

	move.l	A0,A1
	add.l	#$95F8,A1
	move.l	#$4E714E71,(A1)

	; *** removes a patch for traps $64->$7C

	move.w	#$6010,$1AC(A0)

	; *** patch to avoid the game to crash (protection??)

	move.l	A0,A1
	add.l	#$191D0,A1
	move.w	#$6004,(A1)
	move.l	A0,A1
	add.l	#$3DC42,A1
	move.w	#$6004,(A1)

	; *** copylock emulation

	move.l	A0,A1
	add.l	#$2B6B6,A1
	GETUSRADDR	copylockemu
	move.l	D0,(A1)

	JSRGEN	FlushCachesHard		; cache flush

	RESTORE_REGS
	jmp	(A0)			; jump to extension mem

copylockemu:
	move.l	#$5EE0F501,$F4.W	; copylock sets this value in $F4
	rts

kbint:
	move.b	$BFEC01,D0		; SERDAT
	move.l	D0,-(sp)

	ror.b	#1,D0
	not.b	D0
	cmp.b	#$5F,D0			; HELP key?
	bne	noquit$
	JSRGEN	InGameExit		; clean exit to WB
noquit$

	move.l	(sp)+,D0
	rts				; return to game
	
ReadSectors:
	JSRGEN	ReadRobSectors		; standard RobNorthen load routine
	moveq.l	#0,D0
	rts


GetExtMem:
	move.l	ExtBase(pc),A0
	move.l	A0,$7EBAA
	rts

loadboot:
	moveq.l	#0,D0
	LEA	$60000,A0
	move.l	#$F4,D1	; length
	move.l	#$32,D2	; offset
	JSRGEN	ReadDiskPart
	tst.l	D0
	bne	nodisk$
	rts

nodisk$
	lea	DiskErr(pc),A0
	JSRGEN	SetExitRoutine	; DiskErr called on quit, now.
	JSRGEN	InGameExit
	bra	nodisk$

trainer:
	dc.l	0
ExtBase:
	dc.l	0

MemErr:
	Mac_printf	"** Not enough memory to run Blastar"
	JMPABS	CloseAll

DiskErr:
	Mac_printf	"** Disk 1 missing!!!"
	Mac_printf	"   Hit RETURN"
	JSRABS	WaitReturn			; waits for return in the output console
	rts

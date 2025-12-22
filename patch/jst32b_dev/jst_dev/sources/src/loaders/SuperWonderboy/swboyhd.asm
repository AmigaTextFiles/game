; *** Super WonderBoy Hard Disk Loader V1.0
; *** Written by Jean-François Fabre

; *** Needs 1.5MB of memory to run


	include	"jst.i"

	HD_PARAMS	"swboy.d",STD_DISK_SIZE,1

loader:
	Mac_printf	"Super Wonderboy HD Loader V1.2"
	Mac_printf	"Coded by Jean-François Fabre © 1997"
	NEWLINE
	Mac_printf	"Trainer by Harry"

	JSRABS	LoadDisks

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

	GO_SUPERVISOR
	SAVE_OSDATA	$80000
	move	#$2700,SR

	JSRGEN	InitTrackDisk
	
	move.w	#2,$1C(A1)
	move.l	#$80C00,$2C(A1)
	move.l	#$33400,$24(A1)
	move.l	#$400,$28(A1)
	JSRGEN	TrackLoad

	PATCHUSRJMP	$D03C,PatchLoad
	PATCHUSRJSR	$CC22,KbInt

	; **** boot stuff and patch

	JSRGEN	FlushCachesHard

	JMP	$400.W

KbInt:
	lea	$CCE5,A0

	cmp.b	#$59,D1
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	cmp.b	#$5F,D1
	bne	noswaptr$
	EOR.W	#(~$9179&$4A79)!($9179&~$4a79),$64fc.w
	JSRGEN	FlushCachesHard
noswaptr$
	rts

PatchLoad:
	STORE_REGS

	mulu	#$200,D0
	move.l	D0,D2
	moveq.l	#0,D0
	move.l	A1,A0
	JSRGEN	ReadDiskPart

	RESTORE_REGS
	move.l	(A7)+,A0	; original game
	rts




; *** Written by Jean-François Fabre


	include	"jst.i"

	HD_PARAMS	"stag2.d",STD_DISK_SIZE,1

loader:
	Mac_printf	"Son Of Stag 2 Anims HD Loader v1.0"
	Mac_printf	"Coded by JOTD © 1998"

	JSRABS	UseHarryOSEmu
	JSRABS	LoadDisks

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

;;;	WAIT_LMB

	GO_SUPERVISOR
	SAVE_OSDATA	$100000

	bsr	InstallBoot

	JSRGEN	FlushCachesHard

	move.l	#$70000,D0
	move.l	D0,-(A7)
	rts

PatchProg:
;;;	PATCHUSRJSR	$AC68,Mask24Bit		; disabled

	JSRGEN	FlushCachesHard

	add.l	#$60,D0
	move.l	D0,-(A7)
	rts

Mask24Bit:
	and.l	#$FFFFFF,D0
	move.l	D0,$BAE0
	rts

InstallBoot:
	lea	$70000,A0
	moveq.l	#0,D0
	move.l	#$C,D2
	move.l	#$3F4,D1
	JSRGEN	ReadDiskPart

	PATCHUSRJMP	($28,A0),PatchProg
	rts


; *** Imperium Hard Disk Loader V2.0
; *** Written by Jean-François Fabre 1999


	include	"syslibs.i"
	include	"jst.i"

	HD_PARAMS	"",0,0

loader:

	Mac_printf	"Sensible Soccer CD32 HD Loader V2.0"
	Mac_printf	"Coded by Jean-François Fabre © 1999"

	JSRABS	DisableChipmemGap	; 2megs of chipmem will be allocated (os swap)
	JSRABS	UseHarryOSEmu		; loads OSEmu.400 and installs it

	lea	LOADERFILE(pc),A1
	move.l	A1,D0
	JSRABS	TestFile
	tst.l	d0
	bne	FileErr			; file 'loader' not found

	lea	SOCV1FILE(pc),A1
	move.l	A1,D0
	JSRABS	TestFile
	tst.l	d0
	bne	TryV2			; file 'soccer' not found. V2?

	lea	SOCV1FILE(pc),A1
	move.l	A1,D0
	JSRABS	GetFileLength
	cmp.l	#1000,D0		; check if size if below 1000 bytes
	bcc	ExeFound		; not a script: it's V1

TryV2

	JSRGEN	GetUserFlags
	btst	#AFB_NTSC,D0
	bne	.boot_ntsc		; user specified NTSC

	lea	SOCPALFILE(pc),A1
	move.l	A1,D0
	JSRABS	TestFile
	tst.l	d0
	beq	ExeFound
	bra	FileErr			; SOC.PAL not found: error

.boot_ntsc
	lea	SOCNTSCFILE(pc),A1
	move.l	A1,D0
	JSRABS	TestFile
	tst.l	d0
	bne	FileErr			; SOC.NTS not found: error


ExeFound:
	RELOC_MOVEL	A1,SOCCERNAME	; this will be the name of the exe

	JSRABS	LoadFiles		; load program files

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade			; disables copyback cache

	GO_SUPERVISOR
	SAVE_OSDATA	$200000,#$5D	; 2MB saved, quitkey = numerical '*'

	; boot stuff and patch
	; thanks to Harry for this piece of code 

	MOVE.L	$4.W,A6			;OPEN DOSLIB FOR USE (THE EMU
	MOVEQ.L	#0,D0			;PROVIDES THE FUNCTIONS)
	LEA	DOSNAM(PC),A1
	JSRLIB	OpenLibrary(A6)
	LEA.L	DOSP(PC),a4
	MOVE.L	d0,(a4)
	MOVE.L	D0,A6

	LEA.L	LOADERFILE(PC),A0
	MOVE.L	A0,D1
	JSRLIB	LoadSeg
	RELOC_MOVEL	D0,loader_seg

	LSL.L	#2,D0
	MOVE.L	D0,A1
	ADDQ.L	#4,A1

	SUB.L	A0,A0
	MOVEQ.L	#0,D0		; no pointer on argumentline

	JSRGEN	FlushCachesHard

	jsr	(A1)

	move.l	DOSP(pc),A6
	move.l	loader_seg(pc),D1
	JSRLIB	UnLoadSeg

	move.l	DOSP(pc),A6
	move.L	SOCCERNAME(PC),A0
	MOVE.L	A0,D1
	JSRLIB	LoadSeg

	LSL.L	#2,D0
	MOVE.L	D0,A1
	ADDQ.L	#4,A1

	SUB.L	A0,A0
	MOVEQ.L	#0,D0		; no pointer on argumentline

	JSRGEN	FlushCachesHard

	jsr	(A1)		; go!

	JSRGEN	InGameExit

	; error message

FileErr:
	Mac_printf	"** File '",v
	JSRABS	Display
	Mac_printf	"' missing!"
	JSRABS	CloseAll

	; data

loader_seg:
	dc.l	0
DOSP:
	dc.l	0
SOCCERNAME:
	dc.l	0	; will reference the name of the executable actually used
DOSNAM:
	dc.b	"dos.library",0

	; executable filenames

LOADERFILE:
	dc.b	"loader",0
SOCV1FILE:
	dc.b	"soccer",0
SOCPALFILE:
	dc.b	"SOC.PAL",0
SOCNTSCFILE:
	dc.b	"SOC.NTSC",0

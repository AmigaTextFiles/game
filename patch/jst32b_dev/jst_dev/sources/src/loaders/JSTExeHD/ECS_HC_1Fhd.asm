; *** OSEmu 1meg chip, no fast
; *** Written by Jean-François Fabre 1999


	include	"syslibs.i"
	include	"jst.i"

	HD_PARAMS	"",0,0

MEM_SIZE = $80000

loader:
	move.l	#$100000,D0
	JSRABS	AllocExtMem

	Mac_printf	"Generic 512K chip/1Meg fast/ECS OSEmu HD Loader"
	Mac_printf	"Coded by Jean-François Fabre © 1999"

	JSRABS	UseHarryOSEmu

	JSRGEN	GetUserData
	tst.l	(A0)
	beq	UDErr
	move.l	A0,D0
	lea	MAINFILE(pc),A0
	move.l	A0,D1
	JSRGEN	StrcpyAsm

	TESTFILE	MAINFILE
	tst.l	d0
	bne	FileErr

	JSRABS	LoadFiles

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

	GO_SUPERVISOR
	SAVE_OSDATA	MEM_SIZE,#$5D

	MOVE.L	$4.W,A6			;OPEN DOSLIB FOR USE (THE EMU

	; **** boot stuff and patch

	MOVE.L	$4.W,A6			;OPEN DOSLIB FOR USE (THE EMU
	MOVEQ.L	#0,D0			;PROVIDES THE FUNCTIONS)
	LEA	DOSNAM(PC),A1
	JSRLIB	OpenLibrary(A6)
	LEA.L	DOSP(PC),a4
	MOVE.L	d0,(a4)
	MOVE.L	D0,A6

	LEA.L	MAINFILE(PC),A0		;LOAD MAIN GAME
	MOVE.L	A0,D1
	JSRLIB	LoadSeg
					;NO NEED TO STORE POINTER FOR LATER USE
	LSL.L	#2,D0
	MOVE.L	D0,A1
	ADDQ.L	#4,A1

	cmp.l	#0,A1
	beq	LoadsegErr

	SUB.L	A0,A0
	MOVEQ.L	#0,D0		; no pointer on argumentline

	
	jsr	(A1)

LoadsegErr
	JSRGEN	InGameExit
FileErr:
	Mac_printf	"File ",f
	lea	MAINFILE(pc),A1
	JSRABS	Display
	Mac_printf 	" missing!"
	JSRABS	CloseAll

UDErr:
	Mac_printf	"Executable program name must be passed in USERDATA"
	JSRABS	CloseAll

DOSP:
	dc.l	0
DOSNAM:
	dc.b	"dos.library",0
MAINFILE:
	blk.b	256,0



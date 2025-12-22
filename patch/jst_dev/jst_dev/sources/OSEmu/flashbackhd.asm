; *** Flashback Hard Disk Loader V1.0
; *** Written by Jean-François Fabre 1999


	include	"syslibs.i"
	include	"jst.i"

	HD_PARAMS	"",0,0

loader:
	Mac_printf	"Flashback HD Loader V1.0"
	Mac_printf	"Coded by Jean-François Fabre © 1999"

	JSRABS	UseHarryOSEmu

	TESTFILE	MAINFILE
	tst.l	d0
	bne	FileErr

	JSRABS	LoadFiles

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade


	GO_SUPERVISOR
	SAVE_OSDATA	$100000,#$5D

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

	SUB.L	A0,A0
	MOVEQ.L	#0,D0		; no pointer on argumentline

	nop
	nop
	nop
	jsr	(A1)
	nop
	nop
	nop

FileErr:
	Mac_printf	"File ",f
	lea	MAINFILE(pc),A1
	JSRABS	Display
	Mac_printf 	" missing!"
	JSRABS	CloseAll

DOSP:
	dc.l	0
DOSNAM:
	dc.b	"dos.library",0
MAINFILE:
	dc.b	"flashback",0



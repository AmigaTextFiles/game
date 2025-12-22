;*---------------------------------------------------------------------------
;  :Program.	crazycars3slave.asm
;  :Contents.	Slave for "Crazy Cars 3"
;  :Author.	Harry
;  :History.	26.09.1998/08.10.1998/ example-rework 11.10.1998
;  :Requires.	whdload-package :)
;  :Copyright.	Freeware
;  :Language.	68000 Assembler
;  :Translator.	ASM-One 1.25
;  :To Do.
;---------------------------------------------------------------------------*

	IFND BARFLY

	INCDIR	asm-one:Include2.0/
	INCLUDE LIBRARIES/DOS_LIB.I
	INCLUDE	LIBRARIES/DOS.I
	INCLUDE EXEC/EXEC_LIB.I
	INCLUDE	EXEC/MEMORY.I
	INCLUDE	GRAPHICS/GRAPHICS_LIB.I
	INCLUDE INTUITION/INTUITION_LIB.I
	INCLUDE INTUITION/INTUITION.I
	INCLUDE	OWN/CCRMAKRO
	INCLUDE	own/whdload.i
	
	ELSE

		INCDIR	Includes:
		INCLUDE	lvo/dos.i
		INCLUDE	lvo/exec.i
		INCLUDE	whdload.i

		BOPT	O+ OG+			;enable optimizing
		BOPT	ODd- ODe-		;disable mul optimizing
		BOPT	w4-			;disable 64k warnings
		SUPER				;disable supervisor warnings

		OUTPUT	wart:a-c/anotherworld/anotherworld.slave
	ENDC

;======================================================================

SLBASE		SLAVE_HEADER		;ws_Security + ws_ID
		dc.w	7		;ws_Version
		dc.w	WHDLF_Disk!WHDLF_NoError!WHDLF_EmulTrap	;ws_flags
		dc.l	$D0000		;ws_BaseMemSize	
		dc.l	$00		;ws_ExecInstall
		dc.w	SLStart-SLBASE	;ws_GameLoader
		dc.w	CCDIR-SLBASE	;ws_CurrentDir
		dc.w	0		;ws_DontCache
 		dc.b	$00		;debugkey
qkey		dc.b	$5D		;quitkey

CCDIR	DC.B	'ccdat',0
	EVEN

;======================================================================

;	DOSCMD	"WDate >T:date"
		dc.b	"$VER: Crazy_Cars_3_Slave_2.02"
;	INCBIN	"T:date"
		dc.b	0
		even

;======================================================================
SLStart	;	A0 = resident loader
;======================================================================

		lea	_RESLOAD(PC),a1
		move.l	a0,(a1)			;save for later using

		move.l	#CACRF_EnableI,d0	;enable instruction cache
		move.l	d0,d1			;mask
		jsr	(resload_SetCACR,a0)

					;LOAD EMUMODULE
	LEA.L	$400.W,A1		;ADDY
	LEA.L	OSMNAME(PC),A0		;FILENAME
	move.l	_RESLOAD(PC),a2
	jsr	(resload_LoadFileDecrunch,a2)


	MOVE.L	_RESLOAD(PC),A0		;INIT EMU
	LEA.L	SLBASE(PC),A1
	JSR	$400.W

	MOVE.L	4.W,A6
	BCLR	#4,$129(A6)		;ELSE CC3'S RUNTIMESYSTEM FAILS
					;ON 68060

	MOVE.W	#0,SR

	MOVE.L	#$400,D0		;ELSE THE OSEMU ALLOCATES MEM
	MOVEQ.L	#MEMF_CHIP,D1		;AT THE END AND COMES INTO
	MOVE.L	$4.W,A6			;CC3'S UNALLOCATED AREA *GRRRR*
	JSR	_LVOAllocMem(A6)	;SO WE ALLOCATE A BIT MEM, LOAD
	MOVE.L	D0,-(A7)		;THE EXE AND FREE THAT BIT MEM

	MOVE.L	$4.W,A6			;OPEN DOSLIB FOR USE (THE EMU
	MOVEQ.L	#0,D0			;PROVIDES THE FUNCTIONS)
	LEA	DOSNAM(PC),A1
	JSR	_LVOOpenLibrary(A6)
	LEA.L	DOSP(PC),a4
	MOVE.L	d0,(a4)
	MOVE.L	D0,A6

	LEA.L	INTROFILE(PC),A0	;LOAD INTROEXECUTABLE
	MOVE.L	A0,D1
	JSR	_LVOLoadSeg(A6)
	LEA.L	PRGP(PC),A4		;STORE POINTER FOR FREEING
	MOVE.L	D0,(A4)
	LSL.L	#2,D0
	MOVE.L	D0,A1
	ADDQ.L	#4,A1

	MOVE.L	A1,-(A7)
	MOVE.L	4(A7),A1		;FREE STARTMEM TO FRAGMENT MEMORY
	MOVE.L	#$400,D0		;THAT MEMORYTHING IS ONLY NEEDED
	MOVE.L	$4.W,A6			;FOR CRAZY CARS 3 ITSELF AND MAY
	JSR	_LVOFreeMem(A6)		;BE OMITTED IN OTHER SLAVES

	MOVE.L	(A7)+,A1
	ADDQ.L	#4,A7

	SUB.L	A0,A0			;NO POINTER ON ARGUMENTLINE
	MOVEQ.L	#0,D0			;ARGUMENTLINE HAS LEN 0

	JSR	(A1)			;CALL EXE

	MOVE.L	DOSP(PC),A6		;INTRO FINISHED, THROW EXE OUT
	MOVE.L	PRGP(PC),D1
	JSR	_LVOUnloadSeg(A6)

	LEA.L	MAINFILE(PC),A0		;LOAD MAIN GAME
	MOVE.L	A0,D1
	JSR	_LVOLoadSeg(A6)
					;NO NEED TO STORE POINTER FOR LATER USE
	LSL.L	#2,D0
	MOVE.L	D0,A1
	ADDQ.L	#4,A1

	SUB.L	A0,A0
	MOVEQ.L	#0,D0

	MOVEQ.L	#0,D5			;else gfx is destroyed
	and.b	#$fd,$bfe001		;set filter in right state (ON)

	JSR	(A1)			;CALL EXE

	ILLEGAL				;SHOULD NEVER BE REACHED

;version	dc.w	0	;version of disks
_RESLOAD	dc.l	0	;address of resident loader
OSMNAME	DC.B	'OSEMUMODULE400.BIN',0
	EVEN
INTROFILE	DC.B	'anim',0
	EVEN
MAINFILE	DC.B	'cciii',0
	EVEN
DOSNAM	DC.B	'dos.library',0
	EVEN
PRGP	DC.L	0
DOSP	DC.L	0

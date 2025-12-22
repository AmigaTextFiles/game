	cnop	0,4

; loads an executable by calling OSEmu LoadSeg()
;
; < A0: name of the executable
; > A1: start address (do a JSR (a1) to start the program)
; ** no checks are done there so be careful **

LoadExecutable:
	movem.l	A2-A6/D0-D7,-(A7)
	move.l	A0,-(A7)
	MOVE.L	$4.W,A6			;OPEN DOSLIB FOR USE (THE EMU
	MOVEQ.L	#0,D0			;PROVIDES THE FUNCTIONS)
	LEA	dosname(PC),A1
	JSRLIB	OpenLibrary
	RELOC_MOVEL	D0,dosbase
	MOVE.L	D0,A6
	move.l	(A7)+,A0

	MOVE.L	A0,D1
	JSRLIB	LoadSeg
	RELOC_MOVEL	D0,loaderseg

	LSL.L	#2,D0
	MOVE.L	D0,A1
	ADDQ.L	#4,A1

	SUB.L	A0,A0
	MOVEQ.L	#0,D0		; no pointer on argumentline

	JSRGEN	FlushCachesHard
	movem.l	(A7)+,A2-A6/D0-D7
	rts

; unloads previously loaded executable

UnloadExecutable:
	STORE_REGS
	move.l	dosbase(pc),A6
	move.l	loaderseg(pc),D1
	JSRLIB	UnLoadSeg
	RESTORE_REGS
	rts

loaderseg:
	dc.l	0
dosbase:
	dc.l	0
dosname:
	dc.b	"dos.library",0


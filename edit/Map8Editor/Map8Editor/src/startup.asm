*
* Startup/cleanup code
*
* d0=returnCode = cleanup()
*

	include	"custom.i"


; from linker
	xref	_LinkerDB

; from os.asm
	xref	openlibs
	xref	killOS
	xref	restoreOS

; from init.asm
	xref	inithw
	xref	restorehw

; from input.asm
	xref	kbdhandler

; from display.asm
	xref	initdisplay

; from interrupt.asm
	xref	install_interrupt

; from main.asm
	xref	main
	xref	initgfx
	xref	loadTileGfx
	xref	loadFgGfx
	xref	loadMap
	xref	saveMap
	xref	Quit

; from end.asm
	xref	BSSEnd



	near	a4

	code


;---------------------------------------------------------------------------
startup:
; This is the program's entry point from the AmigaDOS shell or Workbench.
; When the OS is disabled all sub routines can expect to find the custom
; chip base address in A6 and the small data base in A4.
; a0 = dosCmdBuf
; d0 = dosCmdLen, -1 when started from trackloader
; -> d0 = dos return code

	move.l	d0,d2
	move.l	a0,a2
	lea	_LinkerDB,a4
	bsr	clearBSS
	move.l	sp,InitialSP(a4)

	bsr	openlibs
	bne	exit

	bsr	parseArgs
	beq	.1
	bsr	restoreOS
	bra	exit

.1:	bsr	killOS
	bne	exit

	lea	CUSTOM,a6
	bsr	inithw

	; make sure at least Blitter DMA is available before init
	move.w	#$8240,DMACON(a6)

	bsr	initdisplay
	bsr	initgfx

	; install CIA-A interrupt handler for keyboard
	lea	kbdhandler(pc),a0
	moveq	#3,d0
	bsr	install_interrupt

	; make program run in VERTB interrupt
	lea	main(pc),a0
	moveq	#5,d0
	bsr	install_interrupt

	; check whether user wants to quit program
.2:	tst.b	Quit(a4)
	beq	.2

	moveq	#0,d0


;---------------------------------------------------------------------------
	xdef	cleanup
cleanup:
; Exit the program from any point back into the OS.
; d0 = DOS return code

	lea	CUSTOM,a6
	lea	_LinkerDB,a4
	move.l	InitialSP(a4),sp

	move.l	d0,-(sp)
	bsr	restorehw
	bsr	restoreOS

	tst.b	Quit(a4)
	bpl	.1
	move.l	MapName(a4),d0
	beq	.1
	move.l	d0,a0
	bsr	saveMap

.1:	move.l	(sp)+,d0
exit:
	rts


;---------------------------------------------------------------------------
clearBSS:
; Kickstart versions before OS2.0 didn't clear the BSS part of a
; DATA-BSS segment, so we have to do it ourselves.

	lea	BSSStart(a4),a0
	move.l	#BSSEnd,d0
	sub.l	a0,d0
	moveq	#0,d1
.1:	move.l	d1,(a0)+
	subq.l	#4,d0
	bne	.1
	rts


;---------------------------------------------------------------------------
parseArgs:
; Parse command line arguments.
; We expect to find a file name for the map and a file name for the block
; graphics.
; a2 = CmdlinePtr
; d2 = CmdlineLen
; -> d0/Z = ok

	subq.w	#1,d2
	bmi	.1		; empty command line

	; skip leading blanks
	bsr	skipBlanks
	bmi	.1

	; get first file name and read map file
	bsr	getName
	move.l	a0,MapName(a4)
	bsr	loadMap
	beq	.1

	; skip blanks to next file name
	tst.w	d2
	bmi	.1
	bsr	skipBlanks
	bmi	.1

	; get second file name and read the block graphics file
	bsr	getName
	bsr	loadTileGfx
	beq	.1

	; skip blanks to next file name
	tst.w	d2
	bmi	.1
	bsr	skipBlanks
	bmi	.1

	; get third file name and read the foreground block graphics file
	bsr	getName
	bsr	loadFgGfx
	beq	.1

	moveq	#0,d0		; all files read ok!
	rts

.1:	moveq	#1,d0		; error
	rts


skipBlanks:
; a2 = cmdLine ptr
; d2 = remaining length - 1

	cmp.b	#' ',(a2)+
	dbhi	d2,skipBlanks
	subq.l	#1,a2
	tst.w	d2
	rts


getName:
; Skip and terminate a file name, return its start address.
; a2 = cmdLine ptr
; d2 = remaining length - 1
; -> a0 = file name start

	cmp.b	#'"',(a2)
	bne	.2

	; skip a name in quotes
	addq.l	#1,a2
	move.l	a2,a0
	subq.w	#1,d2
	bmi	.4

.1:	cmp.b	#'"',(a2)+
	dbeq	d2,.1
	clr.b	-1(a2)
	subq.w	#1,d2
	rts

	; skip everything until the first blank
.2:	move.l	a2,a0

.3:	cmp.b	#' ',(a2)+
	dbls	d2,.3
	subq.l	#1,a2

.4:	clr.b	(a2)
	rts



	section	__MERGED,bss


	cnop	0,4
BSSStart:

InitialSP:
	ds.l	1

	; remember map name for saving on program exit
MapName:
	ds.l	1

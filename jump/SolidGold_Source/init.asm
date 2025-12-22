*
* Game and hardware initialization. Run main() in supervisor mode.
* Do not restore the system when KILLOS is defined.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* init()
* restorehw()
* stackcheck()
*

	include	"custom.i"
	include	"cia.i"
	include	"files.i"


AUTOVEC1	equ	$64
TRAP0VEC	equ	$80

SUPERSTACKSIZE	equ	$1000		; 4K
RZCHECK		equ	$aabbccdd	; check code for red-zone


; from trackdisk.asm
	xref	td_init
	xref	td_selectdisk

; from os.asm
	xref	AutoVecBase
	xref	CPUtype

; from display.asm
	xref	initdisplay
	xref	display_off
	xref	waitvertb

; from input.asm
	xref	initControllers
	xref	initKeyboard

; from main.asm
	xref	main
	xref	panic

; from blit.asm
	xref	make_yoffsets

; from music.asm
	xref	initMusic

; from debug.asm
	xref	initdebug
	xref	exitdebug



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	init
init:
; Switch to supervisor mode. Initialize hardware. Call main function.

	bsr	inithw			; disable DMA and interrupts
	clr.l	0.w			; make sure first four bytes are zero

	move.l	AutoVecBase(a4),a1
	add.w	#TRAP0VEC,a1
	move.l	(a1),a0
	move.l	#super,(a1)
	trap	#0
	rts				; return into cleanup


super:
	; Running in supervisor mode now. Restore TRAP0 vector.
	move.l	a0,(a1)

	ifd	KILLOS
	; When the OS was killed we have no guarantee that the supervisor
	; stack area is not reused by Chip RAM allocations.
	; So switch to a safe stack. There will be no return from it.

	lea	SuperStack+SUPERSTACKSIZE,sp

	ifd	DEBUG
	; Establish a red-zone for stack checking.
	lea	-SUPERSTACKSIZE-32(sp),a0
	move.l	#RZCHECK,d0
	moveq	#7,d1
.1:	move.l	d0,(a0)+
	dbf	d1,.1
	endif	; DEBUG

	endif	; KILLOS

	bsr	initdisplay	; allocate memory for bitmaps

	ifnd	BOOTLOGO
	bsr	display_off	; turn the display off, colors are black
	endif

	bsr	td_init
	move.l	#DISK_ID,d0
	bsr	td_selectdisk	; select our disk and read its directory
	bne	exit

	bsr	initControllers
	bsr	initKeyboard
	bsr	initMusic

	bsr	make_yoffsets	; make offset-table for y-positions

	; run the game, make sure the blitter is available
	move.w	#$8240,DMACON(a6)
	bsr	main

exit:
	ifd	KILLOS
	; There is nothing we could return to. Panic.
	move.w	#$fff,d0
	bra	panic

	else
	; Return to user mode.
	rte
	endif


;---------------------------------------------------------------------------
inithw:
; Remember interrupt vectors, DMA and interrupt enables, disable everything.

	ifnd	KILLOS
	move.w	#$8000,d1

	move.w	ADKCONR(a6),d0
	or.w	d1,d0
	move.w	d0,Oldadkcon(a4)

	move.w	INTENAR(a6),d0
	or.w	d1,d0
	move.w	d0,Oldintena(a4)

	move.w	DMACONR(a6),d0
	or.w	d1,d0
	move.w	d0,Olddmacon(a4)
	endif	; !KILLOS

	; disable all DMA channels and interrupts
	bsr	waitvertb
	move.w	#$7fff,d0
	move.w	d0,INTENA(a6)
	move.w	d0,INTREQ(a6)

	ifd	BOOTLOGO
	move.w	#$047f,DMACON(a6)	; disable all except BPL and COP
	else
	move.w	d0,DMACON(a6)		; all DMA off
	endif	; BOOTLOGO

	ifd	DEBUG
	move.b	CPUtype(a4),d0
	jsr	initdebug

	else
	; save interrupt vectors
	move.l	AutoVecBase(a4),a1
	add.w	#AUTOVEC1,a1
	lea	Oldvecs(a4),a0


copy6longs:
	moveq	#6-1,d1
.1:	move.l	(a1)+,(a0)+
	dbf	d1,.1
	endif

	rts


;---------------------------------------------------------------------------
	xdef	restorehw
restorehw:
; Restore initial hardware state.

	bsr	waitvertb
	move.w	#$7fff,d0
	move.w	d0,INTENA(a6)
	move.w	d0,INTREQ(a6)
	move.w	d0,DMACON(a6)

	ifd	DEBUG
	jsr	exitdebug

	else
	lea	Oldvecs(a4),a1
	move.l	AutoVecBase(a4),a0
	add.w	#AUTOVEC1,a0
	bsr	copy6longs
	endif	; DEBUG

	ifnd	KILLOS
	; reenable original DMA and interrupts
	move.w	Oldintena(a4),INTENA(a6)
	move.w	Olddmacon(a4),DMACON(a6)
	move.w	Oldadkcon(a4),ADKCON(a6)
	endif
	rts


	ifd	KILLOS
	ifd	DEBUG
;---------------------------------------------------------------------------
	xdef	stackcheck
stackcheck:
; Make sure that the stack didn't grow too big, by checking the red-zone.

	lea	SuperStack-32,a0
	move.l	#RZCHECK,d0
	moveq	#7,d1
.1:	cmp.l	(a0)+,d0
	dbne	d1,.1
	bne	.2
	rts

	; red-zone has been overwriten, stop the program
.2:	trap	#1

	endif	; DEBUG
	endif	; KILLOS



	section	__MERGED,bss


Oldvecs:
	ds.l	6

	ifnd	KILLOS
Oldadkcon:
	ds.w	1
Olddmacon:
	ds.w	1
Oldintena:
	ds.w	1
	endif	; !KILLOS



	bss


	ifd	KILLOS
	cnop	0,4

	ifd	DEBUG
	ds.b	32
	endif	; DEBUG

SuperStack:
	ds.b	SUPERSTACKSIZE
	endif	; KILLOS

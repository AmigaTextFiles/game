*
* Game and hardware initialization
*
* inithw()
* restorehw()
*

	include	"custom.i"
	include	"cia.i"
	include	"interrupt.i"


; from linker
	xref	_LinkerDB

; from os.asm
	xref	AutoVecBase

; from display.asm
	xref	waitvertb



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	inithw
inithw:
; Remember interrupt vectors, DMA and interrupt enables, disable everything.

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

	; disable all DMA channels and interrupts
	bsr	disable_dmaint

	; disarm sprites
	moveq	#0,d0
	moveq	#15,d1
	lea	SPR0POS(a6),a0
.1:	move.l	d0,(a0)+
	dbf	d1,.1

	; save interrupt vectors
	move.l	AutoVecBase(a4),a1
	add.w	#AUTOVEC1,a1
	lea	Oldvecs(a4),a0


copy6longs:
	moveq	#6-1,d1
copylongs:
	move.l	(a1)+,(a0)+
	dbf	d1,copylongs
	rts


;---------------------------------------------------------------------------
	xdef	restorehw
restorehw:
; Restore initial hardware state.

	bsr	disable_dmaint

	lea	Oldvecs(a4),a1
	move.l	AutoVecBase(a4),a0
	add.w	#$0064,a0
	bsr	copy6longs

	; reenable original DMA and interrupts
	move.w	Oldintena(a4),INTENA(a6)
	move.w	Olddmacon(a4),DMACON(a6)
	move.w	Oldadkcon(a4),ADKCON(a6)
	rts


;---------------------------------------------------------------------------
disable_dmaint:
; turn off DMA channels and interrupts

	bsr	waitvertb
	move.w	#$7fff,d0
	move.w	d0,INTENA(a6)
	move.w	d0,INTREQ(a6)
	move.w	d0,DMACON(a6)
	rts



	section	__MERGED,bss

Oldvecs:
	ds.l	6
Oldadkcon:
	ds.w	1
Olddmacon:
	ds.w	1
Oldintena:
	ds.w	1

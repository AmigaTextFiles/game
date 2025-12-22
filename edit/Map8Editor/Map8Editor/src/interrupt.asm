*
* Interrupt handlers
*
* d0=ok = install_interrupt(d0.w=CustomIntBit, a0=InterruptFunc)
* delete_interrupt(d0.w=CustomIntBit)
*

	include	"custom.i"
	include	"interrupt.i"
	include	"macros.i"


; from linker
	xref	_LinkerDB

; from os.asm
	xref	AutoVecBase



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	install_interrupt
install_interrupt:
; Enable a hardware interrupt and install an interrupt function.
; d0 = Custom chip interrupt number
; a0 = interrupt function pointer
; -> d0 = ok when true

	cmp.w	#13,d0			; 0-13 is valid
	bhi	.exit

	moveq	#1,d1
	lsl.w	d0,d1
	or.w	#$c000,d1		; d1 INTENA interrupt enable

	; install appropriate 68k interrupt vector
	move.l	AutoVecBase(a4),a1
	add.w	d0,d0
	add.w	IntVecs(pc,d0.w),a1
	add.w	d0,d0
	move.l	IntHandlers(pc,d0.w),(a1)

	; install new hardware interrupt function
	lea	IntFuncs(a4),a1
	tst.l	(a1,d0.w)
	bne	.exit			; already set
	move.l	a0,(a1,d0.w)

	; enable the interrupt
	move.w	d1,INTENA(a6)

	moveq	#1,d0			; ok
	SKIPW
.exit:	moveq	#0,d0
	rts

IntVecs:
	dc.w	AUTOVEC1
	dc.w	AUTOVEC1
	dc.w	AUTOVEC1
	dc.w	AUTOVEC2
	dc.w	AUTOVEC3
	dc.w	AUTOVEC3
	dc.w	AUTOVEC3
	dc.w	AUTOVEC4
	dc.w	AUTOVEC4
	dc.w	AUTOVEC4
	dc.w	AUTOVEC4
	dc.w	AUTOVEC5
	dc.w	AUTOVEC5
	dc.w	AUTOVEC6

IntHandlers:
	dc.l	lev1_handler
	dc.l	lev1_handler
	dc.l	lev1_handler
	dc.l	lev2_handler
	dc.l	lev3_handler
	dc.l	lev3_handler
	dc.l	lev3_handler
	dc.l	lev4_handler
	dc.l	lev4_handler
	dc.l	lev4_handler
	dc.l	lev4_handler
	dc.l	lev5_handler
	dc.l	lev5_handler
	dc.l	lev6_handler


;---------------------------------------------------------------------------
	xdef	delete_interrupt
delete_interrupt:
; Disable a hardware interrupt and delete the interrupt function.
; d0 = Custom chip interrupt number

	cmp.w	#13,d0			; 0-13 is valid
	bhi	.exit

	; disable hardware interrupt
	moveq	#1,d1
	lsl.w	d0,d1
	move.w	d1,INTENA(a6)

	; delete interrupt function pointer
	lea	IntFuncs(a4),a0
	lsl.w	#2,d0
	clr.l	(a0,d0.w)

.exit:	rts


;---------------------------------------------------------------------------
lev1_handler:
; Level 1 interrupt handler: TBE, DSKBLK, SOFT

	movem.l	d0/d7/a4-a6,-(sp)
	lea	_LinkerDB,a4
	lea	CUSTOM,a6
	moveq	#7,d7
	and.w	INTREQR(a6),d7

	btst	#2,d7
	beq	.1
	move.l	Lev1Ints+8(a4),d0
	beq	.1
	move.l	d0,a5
	jsr	(a5)

.1:	btst	#1,d7
	beq	.2
	move.l	Lev1Ints+4(a4),d0
	beq	.2
	move.l	d0,a5
	jsr	(a5)

.2:	btst	#0,d7
	beq	.3
	move.l	Lev1Ints+0(a4),d0
	beq	.3
	move.l	d0,a5
	jsr	(a5)

.3:	move.w	d7,INTREQ(a6)
	movem.l	(sp)+,d0/d7/a4-a6
	nop
	rte


;---------------------------------------------------------------------------
lev2_handler:
; Level 2 interrupt handler: PORTS

	movem.l	d0/d7/a4-a6,-(sp)
	lea	_LinkerDB,a4
	lea	CUSTOM,a6

	moveq	#8,d7
	and.w	INTREQR(a6),d7
	beq	.1
	move.l	Lev2Ints(a4),d0
	beq	.1
	move.l	d0,a5
	jsr	(a5)

.1:	move.w	d7,INTREQ(a6)
	movem.l	(sp)+,d0/d7/a4-a6
	nop
	rte


;---------------------------------------------------------------------------
lev3_handler:
; Level 3 interrupt handler: COPER, VERTB, BLIT

	movem.l	d0/d7/a4-a6,-(sp)
	lea	_LinkerDB,a4
	lea	CUSTOM,a6
	moveq	#$70,d7
	and.w	INTREQR(a6),d7

	btst	#6,d7
	beq	.1
	move.l	Lev3Ints+8(a4),d0
	beq	.1
	move.l	d0,a5
	jsr	(a5)

.1:	btst	#5,d7
	beq	.2
	move.l	Lev3Ints+4(a4),d0
	beq	.2
	move.l	d0,a5
	jsr	(a5)

.2:	btst	#4,d7
	beq	.3
	move.l	Lev3Ints+0(a4),d0
	beq	.3
	move.l	d0,a5
	jsr	(a5)

.3:	move.w	d7,INTREQ(a6)
	movem.l	(sp)+,d0/d7/a4-a6
	nop
	rte


;---------------------------------------------------------------------------
lev4_handler:
; Level 4 interrupt handler: AUD0 - AUD3

	movem.l	d0/d7/a4-a6,-(sp)
	lea	_LinkerDB,a4
	lea	CUSTOM,a6
	move.w	INTREQR(a6),d7
	and.w	#$0780,d7

	btst	#10,d7
	beq	.1
	move.l	Lev4Ints+12(a4),d0
	beq	.1
	move.l	d0,a5
	jsr	(a5)

.1:	btst	#9,d7
	beq	.2
	move.l	Lev4Ints+8(a4),d0
	beq	.2
	move.l	d0,a5
	jsr	(a5)

.2:	btst	#8,d7
	beq	.3
	move.l	Lev4Ints+4(a4),d0
	beq	.3
	move.l	d0,a5
	jsr	(a5)

.3:	btst	#7,d7
	beq	.4
	move.l	Lev4Ints+0(a4),d0
	beq	.4
	move.l	d0,a5
	jsr	(a5)

.4:	move.w	d7,INTREQ(a6)
	movem.l	(sp)+,d0/d7/a4-a6
	nop
	rte


;---------------------------------------------------------------------------
lev5_handler:
; Level 5 interrupt handler: RBF, DSKSYN

	movem.l	d0/d7/a4-a6,-(sp)
	lea	_LinkerDB,a4
	lea	CUSTOM,a6
	move.w	INTREQR(a6),d7
	and.w	#$1800,d7

	btst	#12,d7
	beq	.1
	move.l	Lev5Ints+4(a4),d0
	beq	.1
	move.l	d0,a5
	jsr	(a5)

.1:	btst	#11,d7
	beq	.2
	move.l	Lev5Ints+0(a4),d0
	beq	.2
	move.l	d0,a5
	jsr	(a5)

.2:	move.w	d7,INTREQ(a6)
	movem.l	(sp)+,d0/d7/a4-a6
	nop
	rte


;---------------------------------------------------------------------------
lev6_handler:
; Level 6 interrupt handler: EXTER

	movem.l	d0/d7/a4-a6,-(sp)
	lea	_LinkerDB,a4
	lea	CUSTOM,a6

	move.w	INTREQR(a6),d7
	and.w	#$2000,d7
	beq	.1
	move.l	Lev6Ints(a4),d0
	beq	.1
	move.l	d0,a5
	jsr	(a5)

.1:	move.w	d7,INTREQ(a6)
	movem.l	(sp)+,d0/d7/a4-a6
	nop
	rte



	section	__MERGED,bss

IntFuncs:
Lev1Ints:
	ds.l	3
Lev2Ints:
	ds.l	1
Lev3Ints:
	ds.l	3
Lev4Ints:
	ds.l	4
Lev5Ints:
	ds.l	2
Lev6Ints:
	ds.l	1

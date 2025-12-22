*
* Program Main Loop
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* main()
* set_vertb_irq(a0=routine)
* clr_vertb_irq()
* newlist(a0=list)
* d0=rnd = rand()
* makeseed()
* ovflowerr()
* loaderr()
* panic(d0.w=color)
* d0.w=color = color_scale(d0.w=color, d1=loColor.w|hiColor.w)
* d0.w=color = color_intensity(d0.w=color, d1.w=intensity)
* d0=div/d1=mod = divu32(d0=dividend, d1=divisor)
*
* Button
* UpDown
* LeftRight
* LastKey
*

	include	"custom.i"
	include	"cia.i"


; from linker
	xref	_LinkerDB

	ifd	BOOTLOGO
; from startup.asm
	xref	BootLogoColors
	endif	; BOOTLOGO

; from os.asm
	xref	AutoVecBase

; from menu.asm
	xref	menu
	xref	loadHiscores

; from intro.asm
	xref	intro

; from game.asm
	xref	initgame
	xref	exitgame
	xref	game

; from finish.asm
	xref	end_sequence



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	main
main:
; The program's main loop.

	ifd	BOOTLOGO
	lea	fade_bootlogo(pc),a0
	bsr	set_vertb_irq
	endif	; BOOTLOGO

	; load the high scores from disk
	bsr	loadHiscores

	;----------------
	; menu and intro
	;----------------
.loop:
	bsr	menu		; returns level number in d0
	tst.b	d0
	beq	.loop		; shouldn't happen
	bpl	.game

	bsr	intro		; show the introduction
	bra	.loop

	;--------------
	; run the game
	;--------------
.game:
	bsr	initgame
	bsr	game
	bsr	exitgame
	tst.b	d0		; game finished flag
	beq	.loop

	;---------------
	; finished game
	;---------------

	bsr	end_sequence
	bra	.loop


	ifd	BOOTLOGO
;---------------------------------------------------------------------------
fade_bootlogo:
; Fade the 16 boot logo colors from highest to lowest intensity. This
; interrupt routine will be stopped when the loading-screen is displayed.
; Running in VERTB interrupt.
; a4 = SmallData base
; a6 = CUSTOM

	; calculate color codes for next lower intensity level
	move.w	BootLogoIntensity(a4),d4
	beq	.2
	sub.w	#$10,d4
	move.w	d4,BootLogoIntensity(a4)

	; write 16 colors with new intensity into the hardware registers
	move.l	BootLogoColors(a4),a2
	lea	COLOR00(a6),a3
	moveq	#16-1,d5

.1:	move.w	(a2)+,d0
	move.w	d4,d1
	bsr	color_intensity
	move.w	d0,(a3)+
	dbf	d5,.1

.2:	rts
	endif	; BOOTLOGO


;---------------------------------------------------------------------------
	xdef	set_vertb_irq
set_vertb_irq:
; Establish and enable a VERTB interrupt routine.
; a0 = interrupt routine

	; disable BLIT, VERTB, COPER interrupts
	moveq	#$70,d0
	move.w	d0,INTENA(a6)
	move.w	d0,INTREQ(a6)

	lea	VertBroutine(pc),a1
	move.l	a0,(a1)

	move.l	AutoVecBase(a4),a0
	lea	lev3_handler(pc),a1
	move.l	a1,$6c(a0)

	; enable VERTB interrupts
	move.w	#$c020,INTENA(a6)
	rts


;---------------------------------------------------------------------------
	xdef	clr_vertb_irq
clr_vertb_irq:
; Disable VERTB interrupts. Establish a dummy handler.

	; disable BLIT, VERTB, COPER interrupts
	moveq	#$70,d0
	move.w	d0,INTENA(a6)
	move.w	d0,INTREQ(a6)

	; set dummy handler, in case somebody enables interrupts again
	move.l	AutoVecBase(a4),a0
	lea	lev3_default(pc),a1
	move.l	a1,$6c(a0)

	rts


;---------------------------------------------------------------------------
lev3_handler:
; Level 3 interrupt handler, which runs the installed VERTB-routine.
; It cares for saving, restoring and initializing registers and
; clearing the interrupt flags.

	movem.l	d0-d7/a0-a6,-(sp)
	lea	_LinkerDB,a4
	lea	CUSTOM,a6

	; clear all level 3 interrupt flags, so we can be interrupted again
	move.w	#$0070,INTREQ(a6)

	; call the interrupt routine
	move.l	VertBroutine(pc),a0
	jsr	(a0)

	movem.l	(sp)+,d0-d7/a0-a6
	nop
	rte


VertBroutine:
	dc.l	-1


;---------------------------------------------------------------------------
lev3_default:
; Default level 3 handler, which clears the interrupt flags.

	ifd	DEBUG
	trap	#7			; should not happen, call debugger

	else

	move.w	#$0070,CUSTOM+INTREQ
	move.w	#$0070,CUSTOM+INTREQ
	nop
	rte
	endif	; DEBUG


;---------------------------------------------------------------------------
	xdef	newlist
newlist:
; a0 = list
; All registers are preserved.

	move.l	a0,8(a0)
	addq.l	#4,a0
	clr.l	(a0)
	move.l	a0,-(a0)
	rts


;---------------------------------------------------------------------------
	xdef	rand
rand:
; Calculate next 16-bit random number from RandSeed.
; RandSeed has to be initialized during startup with some random value.
; -> d0.w = random (-32768 to 32767)
; a1 is preserved!

	move.l	d2,a0

	move.w	#16807,d0
	move.w	d0,d2
	mulu	RandSeed+2(a4),d0

	move.l	d0,d1
	clr.w	d1
	swap	d1
	mulu	RandSeed(a4),d2
	add.l	d1,d2

	move.l	d2,d1
	add.l	d1,d1
	clr.w	d1
	swap	d1

	and.l	#$ffff,d0
	sub.l	#$7fffffff,d0
	and.l	#$7fff,d2
	swap	d2
	add.l	d1,d2
	add.l	d0,d2
	bpl	.1
	add.l	#$7fffffff,d2
.1:	move.l	d2,RandSeed(a4)

	moveq	#0,d0
	move.w	d2,d0
	move.l	a0,d2
	rts


;---------------------------------------------------------------------------
	xdef	makeseed
makeseed:
; Make a 32-bit random seed value. Should be called early in startup.

	lea	CIAA,a0
	move.b	CIATBLO(a0),d0
	lsl.w	#8,d0
	move.b	CIATODLO(a0),d0
	swap	d0
	move.w	CUSTOM+VHPOSR,d0
	move.l	d0,RandSeed(a4)
	rts


;---------------------------------------------------------------------------
	xdef	ovflowerr
ovflowerr:
	move.w	#$f80,d0	; overflow, file too big, is orange
	bra	panic


;---------------------------------------------------------------------------
	xdef	loaderr
loaderr:
	move.w	#$f00,d0	; load error is red


;---------------------------------------------------------------------------
	xdef	panic
panic:
; Fatal error. Display a color code in 16 intensity levels.
; d0.w = color

	ifd	DEBUG
	movem.l	d0-d7/a0-a6,-(sp)
	endif

	lea	CUSTOM,a6
	move.w	d0,d4
	move.w	#$ff00,d5

.1:	move.w	#$f00,d1
	and.w	VHPOSR(a6),d1
	lsr.w	#4,d1
	move.w	d4,d0
	bsr	color_intensity

	move.w	d5,d2
	and.w	VHPOSR(a6),d2

.2:	move.w	d5,d3
	and.w	VHPOSR(a6),d3
	cmp.w	d2,d3
	beq	.2

	move.w	d0,COLOR00(a6)

	ifd	DEBUG
	btst	#6,CIAA+CIAPRA		; mouse button enters debugger
	bne	.1
	movem.l	(sp)+,d0-d7/a0-a6
	illegal				; enter debugger, inspect registers

	else
	bra	.1
	endif	; DEBUG


;---------------------------------------------------------------------------
	xdef	color_scale
color_scale:
; Scale a normal RGB4 color code into a lowest/highest color range.
; All components of the lowest RGB4 color must be lower or same than
; those of the highest RGB4 color!
; d0.w = RGB4 color
; d1.l = lowest RGB4 color | highest RGB4 color
; -> d0.w = scaled color
; Destroys registers d2 - d5!

	move.w	d0,d2
	lea	Mult16Tab(pc),a0

	move.w	d1,d3
	swap	d1
	sub.w	d1,d3			; number of R, G and B levels

	; Blue component
	moveq	#15,d4
	and.w	d3,d4
	lsr.w	#4,d3
	lsl.w	#4,d4

	moveq	#15,d5
	and.w	d2,d5
	lsr.w	#4,d2
	add.w	d5,d4

	moveq	#15,d5
	and.w	d1,d5
	lsr.w	#4,d1
	add.b	(a0,d4.w),d5

	ror.w	#4,d5
	move.w	d5,d0

	; Green component
	moveq	#15,d4
	and.w	d3,d4
	lsr.w	#4,d3
	lsl.w	#4,d4

	moveq	#15,d5
	and.w	d2,d5
	lsr.w	#4,d2
	add.w	d5,d4

	moveq	#15,d5
	and.w	d1,d5
	lsr.w	#4,d1
	add.b	(a0,d4.w),d5

	or.w	d5,d0
	ror.w	#4,d0

	; Red component
	moveq	#15,d4
	and.w	d3,d4
	lsl.w	#4,d4

	moveq	#15,d5
	and.w	d2,d5
	add.w	d5,d4

	moveq	#15,d5
	and.w	d1,d5
	add.b	(a0,d4.w),d5

	or.w	d5,d0
	ror.w	#8,d0
	rts


;---------------------------------------------------------------------------
	xdef	color_intensity
color_intensity:
; Apply one of 16 intensity levels on an RGB4 color code.
; d0.w = RGB4 color
; d1.w = intensity level ($00-$f0 in $10 steps)
; -> d0.w = RGB4 color with above intensity
; Destroys registers d2 and d3!

	lea	Mult16Tab(pc,d1.w),a0

	moveq	#15,d3
	and.w	d0,d3
	lsr.w	#4,d0
	moveq	#15,d2
	and.w	d0,d2
	lsr.w	#4,d0
	moveq	#15,d1
	and.w	d0,d1

	move.b	(a0,d1.w),d0
	lsl.w	#4,d0
	or.b	(a0,d2.w),d0
	lsl.w	#4,d0
	or.b	(a0,d3.w),d0
	rts


Mult16Tab:
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	dc.b	0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2
	dc.b	0,0,0,0,0,1,1,1,1,1,2,2,2,2,2,3
	dc.b	0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,4
	dc.b	0,0,0,1,1,1,2,2,2,3,3,3,4,4,4,5
	dc.b	0,0,0,1,1,2,2,2,3,3,4,4,4,5,5,6
	dc.b	0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7
	dc.b	0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,8
	dc.b	0,0,1,1,2,3,3,4,4,5,6,6,7,7,8,9
	dc.b	0,0,1,2,2,3,4,4,5,6,6,7,8,8,9,10
	dc.b	0,0,1,2,2,3,4,5,5,6,7,8,8,9,10,11
	dc.b	0,0,1,2,3,4,4,5,6,7,8,8,9,10,11,12
	dc.b	0,0,1,2,3,4,5,6,6,7,8,9,10,11,12,13
	dc.b	0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14
	dc.b	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15


;---------------------------------------------------------------------------
	xdef	divu32
divu32:
; Unsigned 32-bit division and modulo.
; d0 = dividend
; d1 = divisor
; -> d0 = divison result
; -> d1 = modulo
; a0 and a1 are preserved!

	move.l	d3,-(sp)
	swap	d1
	tst.w	d1
	bne	.big_denom
	swap	d1
	move.l	d1,d3
	swap	d0
	move.w	d0,d3
	beq	.1
	divu.w	d1,d3
	move.w	d3,d0
.1:	swap	d0
	move.w	d0,d3
	divu.w	d1,d3
	move.w	d3,d0
	swap.w	d3
	move.w	d3,d1
	move.l	(sp)+,d3
	rts

.big_denom:
	swap	d1
	move.l	d2,-(sp)
	moveq	#15,d3
	move.w	d3,d2
	move.l	d1,d3
	move.l	d0,d1
	clr.w	d1
	swap	d1
	swap	d0
	clr.w	d0
.2:	add.l	d0,d0
	addx.l	d1,d1
	cmp.l	d1,d3
	bhi	.3
	sub.l	d3,d1
	addq.w	#1,d0
.3:	dbf	d2,.2

	movem.l	(sp)+,d2-d3
	rts



	section	__MERGED,data


	ifd	BOOTLOGO
BootLogoIntensity:
	dc.w	$f0
	endif	; BOOTLOGO



	section	__MERGED,bss


	; RNG seed
RandSeed:
	ds.l	1

	; Joystick status of current frame
	xdef	Button
Button:
	ds.b	1
	xdef	UpDown
UpDown:
	ds.b	1
	ds.b	1
	xdef	LeftRight
LeftRight:
	ds.b	1

	; last key pressed (valid for one frame)
	xdef	LastKey
LastKey:
	ds.b	1
	even

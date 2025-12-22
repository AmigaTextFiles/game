*
* AmigaOS support routines.
* Functions for taking over the system and for restoring the OS and the
* initial hardware state.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* d0=error = takeover()
* restore()
*
* PALflag
* CPUtype
*

	include	"exec/execbase.i"
	include	"exec/libraries.i"
	include "dos/dosextens.i"
	include "graphics/gfxbase.i"

	include	"custom.i"


; AmigaOS constants
EXECBASE	equ	4

; exec LVOs
Supervisor	equ	-30
CloseLibrary	equ	-414
OpenLibrary	equ	-552

; graphics LVOs
LoadView	equ	-222
WaitBlit	equ	-228
WaitTOF		equ	-270
OwnBlitter	equ	-456
DisownBlitter	equ	-462



	mc68010
	near	a4

	code


;---------------------------------------------------------------------------
	xdef	takeover
takeover:
; Determine CPU. Save the auto vector location.
; Turn off AGA and graphics cards and load a NULL view. Lock the blitter.
; -> a6 = CUSTOM (when error=0)
; -> d0 = error

	move.l	(EXECBASE).w,a6

	; determine CPU type
	moveq	#0,d0
	moveq	#6,d2
	move.b	AttnFlags+1(a6),d1
	bmi	.1			; N-flag is AFB_68060
	moveq	#0,d2
	lsr.b	#1,d1
	addx.b	d0,d2
	lsr.b	#1,d1
	addx.b	d0,d2
	lsr.b	#1,d1
	addx.b	d0,d2
	lsr.b	#1,d1
	addx.b	d0,d2

.1:	move.b	d2,CPUtype(a4)
	beq	.2			; 68000?

	; get VBR for 68010+
	lea	getVBR(pc),a5
	jsr	Supervisor(a6)
.2:	move.l	d0,AutoVecBase(a4)

	; open graphics.library
	lea	GfxName(pc),a1
	moveq	#33,d0
	jsr	OpenLibrary(a6)
	move.l	d0,_GfxBase(a4)
	beq	err_return
	move.l	d0,a6

	ifnd	BOOTLOGO
	; save current active view and load a NULL view
	move.l	gb_ActiView(a6),ActiView(a4)
	sub.l	a1,a1
	jsr	LoadView(a6)
	jsr	WaitTOF(a6)
	jsr	WaitTOF(a6)
	endif	; !BOOTLOGO

	; get exclusive blitter access
	jsr	OwnBlitter(a6)
	jsr	WaitBlit(a6)

	; determine PAL/NTSC
	moveq	#0,d0			; BEAMCON0 NTSC
	btst	#PALn,gb_DisplayFlags+1(a6)
	sne	PALflag(a4)

	; disable AGA/ECS features
	lea	CUSTOM,a6
	move.w	#$0020,BEAMCON0(a6)	; force PAL
	ifnd	BOOTLOGO
	lea	BplconInit(pc),a0
	lea	BPLCON0(a6),a1
	moveq	#7-1,d0
.3:	move.w	(a0)+,(a1)+
	dbf	d0,.3
	endif	; !BOOTLOGO

	; set OCS fetch-mode
	moveq	#0,d0
	move.w	d0,FMODE(a6)
	rts

getVBR:
	movec	vbr,d0
	rte

BplconInit:	; Init. for BPLCON0..4, BPL1/2MOD
	dc.w	$0000,$0000,$0024,$0c00,$0000,$0000,$0011

GfxName:
	dc.b	"graphics.library",0
	even


;---------------------------------------------------------------------------
	xdef	restore
restore:
; Restore the OS display, free the blitter.

	ifnd	KILLOS
	lea	CUSTOM,a3
	move.l	(EXECBASE).w,a5
	move.l	_GfxBase(a4),d0
	beq	.1

	; restore system view and release blitter
	move.l	d0,a6
	jsr	WaitBlit(a6)
	jsr	DisownBlitter(a6)
	move.l	ActiView(a4),a1
	jsr	LoadView(a6)
	move.l	gb_copinit(a6),COP1LC(a3)

	; close graphics.library
	move.l	a6,a1
	move.l	a5,a6
	jsr	CloseLibrary(a6)

.1:	move.l	a5,a6
	endif	; !KILLOS

err_return:
	moveq	#1,d0
	rts



	section	__MERGED,bss


_GfxBase:
	ds.l	1

ActiView:
	ds.l	1

	xdef	AutoVecBase
AutoVecBase:
	ds.l	1

	xdef	PALflag
PALflag:
	ds.b	1

	xdef	CPUtype
CPUtype:
	ds.b	1
	even

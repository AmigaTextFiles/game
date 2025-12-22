*
* Scroll constants and macros
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


; Scroll margins. Scroll the bitmap slow or fast, depending on the
; hero's distance to the display borders.
SLOW_HOR_MARGIN	equ	140
FAST_HOR_MARGIN	equ	100
SLOW_TOP_MARGIN	equ	56
FAST_TOP_MARGIN	equ	40
SLOW_BOT_MARGIN	equ	120
FAST_BOT_MARGIN	equ	112
VFST_BOT_MARGIN	equ	96


; Number of phases for drawing new tiles. The maximum scroll speed per
; frame calculates as: 16 pixels per block / BLTPHASES / 2 (double buffering)
BLTPHASES	equ	2


; Macros depend on YBLOCKS=18 and 2 phases.
	ifne	YBLOCKS-18
	fail
	endif

; Row to start blitting in each phase. Used to index 16-bit tables (*2).
	macro	TILEYPOS
	dc.w	9*2,0*2
	endm

; Number of tiles to draw in each phase (-1 for dbf-loop).
	macro	TILEYCNT
	dc.w	9-1,9-1
	endm


; Macros depend on XBLOCKS=24 and 2 phases.
	ifne	XBLOCKS-24
	fail
	endif

; Column-offset to start blitting in each phase.
	macro	TILEXOFF
	dc.w	11,0
	endm

; Number of tiles to draw in each phase (-1 for dbf-loop).
	macro	TILEXCNT
	dc.w	12-1,11-1
	endm

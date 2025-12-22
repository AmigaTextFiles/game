*
* Editor constants
*

; Info display, coordinates, cursor position on map
INFOCOORDS_X1	equ	$d8
INFOCOORDS_X2	equ	$f8

; Monster count display
MONSTERCNT_X	equ	$120

; tile-selection view, start position
TILESEL_X	equ	$30

; Scroll speed, when moving the joystick in pixels/frame
SCROLLSPEED	equ	2

; Number of phases for drawing new tiles: 4 is needed for above SCROLLSPEED
BLTPHASES	equ	4

; Start scrolling when cursor crosses the display's margin
SCROLLMARGIN	equ	4*BLKW


; Macros depend on YBLOCKS=18 and 4 phases.
	ifne	YBLOCKS-18
	fail
	endc

; Row to start blitting in each phase. Used to index 16-bit tables (*2).
	macro	TILEYPOS
	dc.w	0*2,4*2,9*2,14*2
	endm

; Number of tiles to draw in each phase (-1 for dbf-loop).
	macro	TILEYCNT
	dc.w	4-1,5-1,5-1,4-1
	endm


; Macros depend on XBLOCKS=24 and 4 phases.
	ifne	XBLOCKS-24
	fail
	endc

; Column-offset to start blitting in each phase.
	macro	TILEXOFF
	dc.w	17,11,5,0
	endm

; Number of tiles to draw in each phase (-1 for dbf-loop).
	macro	TILEXCNT
	dc.w	6-1,6-1,6-1,5-1
	endm


; Monster description
		rsreset
Mtype		rs.w	1	; 1-9
Mdir		rs.w	1	; -1 for left, 1 for right
Mcol		rs.w	1
Mrow		rs.w	1
sizeof_Monster	rs

NUM_MONSTERS	equ	127

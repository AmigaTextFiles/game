*
* Display constants, structures and macros
*


; display dimensions
DISPW		equ	320
DISPH		equ	240
PLANES		equ	5
NCOLORS		equ	1<<PLANES

; info bitmap on top of display
INFOH		equ	16
INFOGAP		equ	2

; display window in raster coordinates (HSTART must be odd)
HSTART		equ	129
VSTART		equ	36
VSCROLLEND	equ	VSTART+DISPH
VEND		equ	VSCROLLEND+INFOGAP+INFOH

; normal display data fetch start/stop (without scrolling)
DFETCHSTART	equ	HSTART/2-8
DFETCHSTOP	equ	DFETCHSTART+8*((DISPW/16)-1)

; scroll bitmap dimensions (16x16 blocks)
XBLOCKS		equ	(DISPW/16)+4
YBLOCKS		equ	(DISPH/16)+3
BMAPW		equ	XBLOCKS*16
BMAPH		equ	YBLOCKS*16
BPR		equ	BMAPW/8


; copper list
		rsreset
Cl_sprites	rs.l	2*8		; SPRxPT
Cl_scroll	rs.l	1		; BPLCON1, scroll delay
Cl_bpltop	rs.l	2*PLANES	; BPLxPT
Cl_waitsplit	rs.l	2		; WAIT until split
Cl_bplsplit	rs.l	2*PLANES	; BPLxPT
Cl_waitend	rs.l	2		; WAIT for end of scroll display
		rs.l	1		; BPLCON0, diplay off
		rs.l	1		; BPLCON1, no scrolling
		rs.l	2*PLANES	; BPLxPT for info display
		rs.l	1		; WAIT for start of info display
		rs.l	1		; BPLCON0, display on
		rs.l	1		; $ffff,$fffe end of copper list
sizeof_Clist	rs.b	0

*
* Display constants, structures and macros
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


; display dimensions
DISPW		equ	320
DISPH		equ	240
PLANES		equ	5
NCOLORS		equ	1<<PLANES

; display window in raster coordinates (HSTART must be odd)
HSTART		equ	129
VSTART		equ	44
VEND		equ	VSTART+DISPH

; normal display data fetch start/stop (without scrolling)
DFETCHSTART	equ	HSTART/2-8
DFETCHSTOP	equ	DFETCHSTART+8*((DISPW/16)-1)

; scroll bitmap dimensions (16x16 blocks)
EXTRACOLS	equ	4
EXTRAROWS	equ	3
XBLOCKS		equ	(DISPW/16)+EXTRACOLS
YBLOCKS		equ	(DISPH/16)+EXTRAROWS
BMAPW		equ	XBLOCKS*16
BMAPH		equ	YBLOCKS*16
BPR		equ	BMAPW/8

; maximum object dimensions in the game
MAXOBJWIDTH	equ	16
MAXOBJHEIGHT	equ	22		; hero height


; game copper list
		rsreset
Cl_sprites	rs.l	2*8		; SPRxPT
Cl_illcolors	rs.l	2		; two colors which may be illuminated
Cl_scroll	rs.l	1		; BPLCON1, scroll delay
Cl_bpltop	rs.l	2*PLANES	; BPLxPT
		IFD	COPPERBACK
Cl_colors	rs.l	2*DISPH		; WAIT and COLOR01 each line
		rs.l	1		; including one WAIT for $ff,$de
		rs.l	2*PLANES	; and the BPLxPT of the split
		ELSE
Cl_waitsplit	rs.l	2		; WAIT until split
Cl_bplsplit	rs.l	2*PLANES	; BPLxPT
		ENDIF	; COPPERBACK
		rs.l	1		; $ffff,$fffe end of copper list
sizeof_GameCL	rs.b	0

; menu and intro copper list
		rsreset
		rs.l	2*8		; SPRxPT
		rs.l	2*PLANES	; BPLxPT
MCl_dynamic	rs.l	2		; BPLxMOD
		rs.l	NCOLORS
		rs.l	2		; 1 or 2 WAITs
		rs.l	NCOLORS
		rs.l	1		; WAIT
		rs.l	NCOLORS
		rs.l	1		; WAIT for mirrored region
		rs.l	2		; BPLxMOD to draw bitmap backwards
		rs.l	NCOLORS
		rs.l	1		; WAIT
		rs.l	NCOLORS
		rs.l	1		; WAIT
		rs.l	NCOLORS
		rs.l	1		; WAIT bottom of bitmap
		rs.l	1		; end mirror by resetting COLOR00
		rs.l	2		; space for 1 or 2 end of clist instr.
sizeof_MenuCL	rs.b	0

; intro copper list
		rsreset
		rs.l	2*8		; SPRxPT
		rs.l	2*PLANES	; BPLxPT
ICl_colortop	rs.l	NCOLORS
ICl_waitmid	rs.l	2		; 1 or 2 WAITs
		rs.l	NCOLORS
		rs.l	1		; WAIT
		rs.l	NCOLORS
		rs.l	2		; space for 1 or 2 end of clist instr.
sizeof_IntroCL	rs.b	0

; load world screen copper list
		rsreset
		rs.l	2*8		; SPRxPT
		rs.l	2*PLANES	; BPLxPT
		rs.l	NCOLORS		; text colors
		rs.l	2		; 1 or 2 WAITs
		rs.l	NCOLORS		; loading picture colors
		rs.l	1		; WAIT
		rs.l	NCOLORS		; text colors
		rs.l	1		; WAIT
		rs.l	NCOLORS		; hero animation colors
		rs.l	1		; WAIT
		rs.l	NCOLORS		; text colors
		rs.l	2		; space for 1 or 2 end of clist instr.
sizeof_LdWrldCL	rs.b	0

; end sequence copper list
		rsreset
		rs.l	2*8		; SPRxPT
		rs.l	2*PLANES	; BPLxPT
		rs.l	1		; set BPLCON0
		rs.l	NCOLORS		; picture colors
		rs.l	1		; WAIT
		rs.l	NCOLORS		; text colors
ECl_text	rs.l	2		; 1 or 2 WAITs
		rs.l	NCOLORS-1	; dimmed text colors (without COLOR00)
		rs.l	1		; WAIT
		rs.l	1		; display off, clear BPLCON0
		rs.l	2		; space for 1 or 2 end of clist instr.
sizeof_EndCL	rs.b	0


; memory is allocated for the biggest copper list size: sizeof_Clist
maxclsize	set	sizeof_GameCL
		ifgt	sizeof_MenuCL-maxclsize
maxclsize	set	sizeof_MenuCL
		endif
		ifgt	sizeof_IntroCL-maxclsize
maxclsize	set	sizeof_IntroCL
		endif
		ifgt	sizeof_LdWrldCL-maxclsize
maxclsize	set	sizeof_LdWrldCL
		endif
		ifgt	sizeof_EndCL-maxclsize
maxclsize	set	sizeof_EndCL
		endif
sizeof_Clist	equ	maxclsize

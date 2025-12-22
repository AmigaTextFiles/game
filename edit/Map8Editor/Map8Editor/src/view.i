*
* View definition
* There are two Views for double buffering.
*

; DrawNode - redraws visible tiles and animated foreground blocks
		rsreset
DNnext		rs.l	1
DNprev		rs.l	1
DNcol		rs.w	1
DNrow		rs.w	1
DNpos		rs.l	1	; target bitmap address
DNbmap		rs.l	1	; background map pointer
DNfmap		rs.l	1	; foreground map pointer
DNmonster	rs.l	1	; monster image to draw over the foreground
sizeof_DrawNode	rs

NUM_DRAWNODES	equ	32

; View structure
		rsreset
Vclist		rs.l	1
Vbitmap		rs.l	1
Vxpos		rs.w	1
Vypos		rs.w	1
Vcolcnt		rs.w	1
Vmapcol		rs.w	1
Vrowcnt		rs.w	1
Vmaprow		rs.w	1
Vbufrow		rs.w	1
Vrowcol		rs.w	1
Vvisrows	rs.w	YBLOCKS
Vdrawlist	rs.l	3
Vlastdn		rs.l	1
Vputcol		rs.w	1
Vputrow		rs.w	1
Vdrawnodes	rs.b	NUM_DRAWNODES*sizeof_DrawNode
sizeof_View	rs

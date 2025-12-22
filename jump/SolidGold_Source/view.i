*
* View definition
* There are two Views for double buffering.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*

; DrawNode - redraws visible tiles and animated foreground blocks
		rsreset
DNnext		rs.l	1
DNprev		rs.l	1
DNcol		rs.w	1
DNrow		rs.w	1
DNbmap		rs.l	1	; background map pointer
DNfmap		rs.l	1	; foreground map pointer
DNpos		rs.l	1	; target bitmap address
sizeof_DrawNode	rs.b	0

NUM_DRAWNODES	equ	32

; BOBs - restore and save background, draw Blitter Objects
		rsreset
BOnext		rs.l	1
BOprev		rs.l	1
BOmob		rs.l	1	; link to MOB, NULL when BOB becomes unused
BOshift		rs.w	1	; shift from xpos & 15
BObpr		rs.w	1	; width in bytes
BOsize1		rs.w	1	; bltsize before the split
BOpos1		rs.l	1	; bitmap pos before the split
BOsize2		rs.w	1	; bltsize after the split (0 when unused)
BOpos2		rs.l	1	; bitmap pos after the split (optional)
BOimg		rs.l	1	; image buffer
BOmsk		rs.l	1	; mask buffer
BObuf		rs.l	1	; saved background buffer
sizeof_BOB	rs.b	0

NUM_BOBS	equ	256	; maximum visible/insvibible BOBs
MAX_VIS_BOBS	equ	32	; maximum number of visible BOBs

; size of largest BOB background to save
MAXBOBSIZE	equ	((MAXOBJWIDTH+31)>>3)*MAXOBJHEIGHT*PLANES

; View structure
		rsreset
Vbitmap		rs.l	1
Vclist		rs.l	1
Vtop		rs.l	1	; bitmap pointer for top-left display edge
Vsplit		rs.l	1	; bitmap pointer for copper split
Vxpos		rs.w	1
Vypos		rs.w	1
Vsplyoff	rs.w	1	; y-offset from Vtop to split
Vid		rs.w	1	; View's ID (0 or 1)
Vdelcol		rs.w	1	; last deleted col by left-scrolling
Vdelrow		rs.w	1	; last deleted row by up-scrolling
Vcolcnt		rs.w	1
Vmapcol		rs.w	1
Vrowcnt		rs.w	1
Vmaprow		rs.w	1
Vbufrow		rs.w	1
Vrowcol		rs.w	1
Vvisrows	rs.w	YBLOCKS
Vdrawlist	rs.l	3
Vlastdn		rs.l	1
Vvboblist	rs.l	3	; visible BOBs
Viboblist	rs.l	3	; invisible BOBs
Vuboblist	rs.l	3	; unsused BOBs
Vbackgdhead	rs.l	1	; first BOB background buffer in list
Vbackgdtail	rs.l	1	; last BOB background buffer in list
Vdrawnodes	rs.b	NUM_DRAWNODES*sizeof_DrawNode
Vbobs		rs.b	NUM_BOBS*sizeof_BOB
sizeof_View	rs.b	0

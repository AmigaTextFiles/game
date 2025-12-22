*
* Copper/Blitter 8-way soft scrolling and tile routines
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* set_scroll_pos(d0.w=xpos, d1.w=ypos)
* $scroll(a5=View)
* d2.w=xpos, d3.w=ypos, d4.w=ypos%BMAPH = $copper_scroll(a5=View)
* $moveView(d0.w=xpos, d1.w=ypos)
* load_copperback(d0.w=fileID)
*

	include	"custom.i"
	include	"display.i"
	include	"scroll.i"
	include	"view.i"
	include	"map.i"
	include	"macros.i"


; from trackdisk.asm
	xref	td_loadcr

; from main.asm
	xref	ovflowerr
	xref	loaderr

; from blit.asm
	xref	YOffTab

; from tiles.asm
	xref	RowOffTab
	xref	Tiles

; from map.asm
	xref	Map
	xref	FgMap
	xref	MapWidth
	xref	MapHeight
	xref	ScrWidth
	xref	ScrHeight
	xref	MapRowOffTab



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	set_scroll_pos
set_scroll_pos:
; Set the map position of the top-left display edge.
; Warning: Needs to be followed by copper_scroll() and draw_tiles(),
; which redraws the whole bitmap. scroll() is for small movements only!
; d0 = xpos.w
; d1 = ypos.w

	move.l	d2,a0
	moveq	#0,d2
	move.w	d1,d2
	divu	#BMAPH,d2
	swap	d2
	movem.w	d0-d2,Xpos(a4)		; initialize Xpos, Ypos, Ymod
	move.l	a0,d2

	; determine our position on the copper background
	move.l	CopperbarTab(a4),a1
	subq.l	#4,a1
	asr.w	#1,d1
	move.w	d1,CbackPos(a4)
.1:	addq.l	#4,a1
	move.w	(a1),d0
	sub.w	d0,d1
	bpl	.1
	move.l	a1,CbackPtr(a4)
	add.w	d0,d1
	move.w	d1,CbackOffs(a4)
	rts


;---------------------------------------------------------------------------
	xdef	scroll
scroll:
; Scroll the View to match the current MapX/MapY coordinates.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	bsr	copper_scroll

	; Load/update View position
	movem.w	Vxpos(a5),d0-d1
	movem.w	d2-d3,Vxpos(a5)

	bra	blitter_scroll


;---------------------------------------------------------------------------
; Horizontal scroll codes for BPLCON1, xpos 0..15
ScrollTab:
	dc.w	$0000,$00ff,$00ee,$00dd,$00cc,$00bb,$00aa,$0099
	dc.w	$0088,$0077,$0066,$0055,$0044,$0033,$0022,$0011


	xdef	copper_scroll
copper_scroll:
; Change BPLPTx and BPLCON1 to view the requested position.
; a5 = View
; -> d2 = xpos
; -> d3 = ypos
; -> d4 = ypos % BMAPH
; Registers, except a4 - a6, are not preserved!

	movem.w	Xpos(a4),d2-d4
	move.l	Vclist(a5),a2

	; write fine scrolling code for (xpos & 15)
	moveq	#15,d0
	and.w	d2,d0
	add.w	d0,d0
	move.w	ScrollTab(pc,d0.w),Cl_scroll+2(a2)

	; calculate xoffset on bitplanes
	move.l	Vbitmap(a5),a0
	move.w	d2,d0
	subq.w	#1,d0			; prefetch, when xpos&15 is 0
	and.w	#$fff0,d0
	asr.w	#3,d0
	add.w	d0,a0

	; calculate a second bitplane pointer with xoffset and ymodulo
	lea	YOffTab(a4),a1
	move.w	d4,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a1,d0.w),d6
	add.l	a0,d6			; d6 (top): bitmap + xoffset + ymodulo
	move.l	a0,d7			; d7 (split): bitmap + xoffset

	; determine real Vtop and Vsplit bitmap pointer for rendering
	move.l	d6,a0
	move.l	d7,a1
	moveq	#15,d0
	and.w	d2,d0
	bne	.1
	addq.l	#2,a0
	addq.l	#2,a1
.1:	movem.l	a0-a1,Vtop(a5)

	; calculate current y-offset of split
	move.w	#BMAPH,d1
	sub.w	d4,d1
	move.w	d1,Vsplyoff(a5)

	; calculate raster line of display split
	IFND	COPPERBACK
	move.w	#VEND,d0
	ELSE
	move.l	#DISPH,d0
	ENDIF
	moveq	#-EXTRAROWS*16,d1
	add.w	d4,d1
	bmi	.2			; no split
	sub.w	d1,d0

	IFND	COPPERBACK
	; write WAIT command for split line
.2:	move.b	d0,Cl_waitsplit+4(a2)
	and.w	#$ff00,d0
	sne	Cl_waitsplit(a2)

	; write updated bitplane pointers for top and split section
	lea	Cl_bpltop+2(a2),a0
	moveq	#PLANES-1,d0
	move.w	#BPR,a1
.3:	swap	d6
	move.w	d6,(a0)
	swap	d6
	move.w	d6,4(a0)
	swap	d7
	move.w	d7,Cl_bplsplit-Cl_bpltop(a0)
	swap	d7
	move.w	d7,4+Cl_bplsplit-Cl_bpltop(a0)
	addq.l	#8,a0
	add.l	a1,d6
	add.l	a1,d7
	dbf	d0,.3
	rts

	ELSE	; COPPERBACK

.2:	move.w	#BPR,a1			; a1 = BPR

	; write updated bitplane pointers for the top of the display
	lea	Cl_bpltop+2(a2),a0
	moveq	#PLANES-1,d1
.3:	swap	d6
	move.w	d6,(a0)
	swap	d6
	move.w	d6,4(a0)
	addq.l	#8,a0
	add.l	a1,d6
	dbf	d1,.3

	; determine current top background copper bar and its height
	move.l	CbackPtr(a4),a3
	move.w	CbackOffs(a4),d2
	asr.w	#1,d3			; new position on copper background
	move.w	CbackPos(a4),d1		; old position
	move.w	d3,CbackPos(a4)
	sub.w	d1,d3			; y-delta on background
	beq	.copperback_init	; no change
	bpl	.6
	bra	.5

	; scrolling upwards (smaller y), find new copper bar position
.4:	subq.l	#4,a3
	move.w	(a3),d3
.5:	add.w	d3,d2
	bmi	.4
	bra	.8

	; scrolling downwards (greater y), find new copper bar position
.6:	neg.w	d3
	subq.l	#4,a3
.7:	addq.l	#4,a3
	sub.w	d3,d2
	move.w	(a3),d3
	cmp.w	d3,d2
	bhs	.7

	; update position in the copper bar table
.8:	move.l	a3,CbackPtr(a4)
	move.w	d2,CbackOffs(a4)

.copperback_init:
	moveq	#0,d1
	move.w	(a3)+,d1
	sub.w	d2,d1			; remaining height of first copper bar

	lea	Cl_colors(a2),a2
	movem.l	.copperback_reginit(pc),d2-d4
	move.w	#$ffdf,d5
	bra	.writeinstr

.copperback_reginit:
	dc.l	(VSTART-1)<<24|$df<<16|$fffe
	dc.l	COLOR01<<16
	dc.l	BPL1PTH<<16|DISPH-1

.copperback_loop:
	moveq	#0,d1
	move.w	(a3)+,d1		; height of this copper bar

.writeinstr:
	move.l	d2,(a2)+		; WAIT
	move.w	(a3)+,d3		; get new color
	move.l	d3,(a2)+		; COLOR01

	; check whether this bar includes the split line
	sub.w	d1,d0
	blo	.split_bplpt

	; check whether this bar passes or extends until VPOS=$100
.addheight:
	sub.w	d1,d4
	ror.l	#8,d1
	add.l	d1,d2
	bcs	.vposoverflow

	; loop until all lines of the display got a color
	tst.w	d4
	bpl	.copperback_loop

	moveq	#-2,d0
	move.l	d0,(a2)			; end of copper list
	movem.w	Xpos(a4),d2-d4
	rts


.vposoverflow:
	; Next WAIT is on or after raster line $100. This means that
	; we have to insert a WAIT for end of line $ff, when not
	; already done.
	; a2 = copper list pointer
	; d2 = last WAIT
	; d5.w = $ffdf

	cmp.w	-8(a2),d5
	beq	.copperback_loop	; last WAIT was already for VPOS=$ff
	move.w	d5,(a2)+
	move.w	d2,(a2)+
	bra	.copperback_loop


.split_bplpt:
	; Write bitplane pointers for the split section. At this line
	; the pointers are reset to point to the top of the bitmap.
	; This might happen within a copper bar and the bar might also
	; pass over raster line $100. Handle all these cases!
	; a2 = copper list pointer
	; d0 = height of copper bar after the split line (negated value)
	; d1 = height of copper bar
	; d2 = last WAIT
	; d4 = remaining display lines
	; d5.w = $ffdf
	; d7 = top bitmap pointers

	add.w	d1,d0			; split line offset into copper bar
	beq	.write_split		; same line as last WAIT

	; set remaining height of copper bar after the split
	sub.w	d0,d1
	sub.w	d0,d4

	; split is not at the top of a copper bar, so insert another WAIT
	ror.l	#8,d0
	add.l	d0,d2
	bcc	.splitwait

	; wait for line $ff first, when passing line $100
	cmp.w	-8(a2),d5
	beq	.splitwait		; last WAIT was already for VPOS=$ff
	move.w	d5,(a2)+
	move.w	d2,(a2)+

.splitwait:
	move.l	d2,(a2)+		; wait for split line

	; write updated bitplane pointers for the split section
.write_split:
	swap	d4			; BPL1PTH to LSW
	moveq	#PLANES-1,d0
.split_loop:
	move.w	d4,(a2)+
	swap	d7
	move.w	d7,(a2)+
	addq.w	#2,d4
	move.w	d4,(a2)+
	swap	d7
	move.w	d7,(a2)+
	addq.w	#2,d4
	add.l	a1,d7
	dbf	d0,.split_loop
	swap	d4			; get remaining height back into LSW
	bra	.addheight

	ENDIF	; COPPERBACK


;---------------------------------------------------------------------------
blitter_scroll:
; Draw new blocks in the border when required.
; a5 = View
; d0 = oldxpos
; d1 = oldypos
; d2 = newxpos
; d3 = newypos
; d4 = newypos % BMAPH
; Registers, except a4 - a6, are not preserved!

	; convert xpos/ypos into tile-columns/rows
	asr.w	#4,d0
	asr.w	#4,d1
	asr.w	#4,d2
	asr.w	#4,d3

	; check if a new column was entered
	cmp.w	d0,d2
	beq	.check_dy
	bgt	.pos_dx

	; Negative delta-x.
	; Remember the last column being deleted by left-scrolling in Vdelcol.
	; We must not draw it as the rightmost tile in a new row.
	; Remove all DrawNodes from the deleted column.
	; Set Vmapcol to the new column to blit at the left side.
	moveq	#XBLOCKS-2,d0
	add.w	d2,d0
	move.w	d0,Vdelcol(a5)
	bsr	del_drawnode_x

	moveq	#-1,d0
	add.w	d2,d0			; column from map to blit
	bmi	.check_dy

	move.w	d0,Vmapcol(a5)
	move.w	#BLTPHASES*2,Vcolcnt(a5)
	bra	.check_dy

	; Positive delta-x.
	; Disable Vdelcol.
	; Remove all DrawNodes from the deleted column.
	; Set Vmapcol to the new column to blit at the right side.
.pos_dx:
	moveq	#-2,d0
	move.w	d0,Vdelcol(a5)		; disabled Vdelcol check
	add.w	d2,d0
	bsr	del_drawnode_x

	moveq	#XBLOCKS-3,d0
	add.w	d2,d0			; column from map to blit
	cmp.w	MapWidth(a4),d0
	bge	.check_dy

	move.w	d0,Vmapcol(a5)
	move.w	#BLTPHASES*2,Vcolcnt(a5)

.check_dy:
; d1 = old row
; d2 = new column
; d3 = new row
; d4 = newypos % BMAPH

	; check if a new row was entered
	cmp.w	d1,d3
	beq	.work
	bgt	.pos_dy

	; Negative delta-y.
	; Remember the last row being deleted by up-scrolling in Vdelrow.
	; We must not draw it as the bottommost tile in a new column.
	; Remove all DrawNodes from the deleted row.
	moveq	#YBLOCKS-1,d0
	add.w	d3,d0
	move.w	d0,Vdelrow(a5)
	bsr	del_drawnode_y

	subq.w	#1,d3			; row from map to blit
	bmi	.work

	asr.w	#4,d4
	subq.w	#1,d4			; row on bitmap to update
	bpl	.setyblt
	add.w	#YBLOCKS,d4
	bra	.setyblt

	; Positive delta-y.
	; Disable Vdelrow.
	; Remove all DrawNodes from the deleted row.
.pos_dy:
	moveq	#-2,d0
	move.w	d0,Vdelrow(a5)
	add.w	d3,d0
	bsr	del_drawnode_y

	moveq	#YBLOCKS-2,d0
	add.w	d0,d3			; row from map to blit
	cmp.w	MapHeight(a4),d3
	bge	.work

	asr.w	#4,d4
	add.w	d0,d4			; row on bitmap to update
	cmp.w	#YBLOCKS,d4
	blt	.setyblt
	sub.w	#YBLOCKS,d4

	; Vrowcol = first column of the new row
	; Vmaprow = new row from the map
	; Vbufrow = row on the bitmap to update
.setyblt:
	subq.w	#1,d2			; column-offset for this row
	move.w	d2,Vrowcol(a5)
	move.w	d3,Vmaprow(a5)
	move.w	d4,Vbufrow(a5)
	move.w	#BLTPHASES*2,Vrowcnt(a5)
	add.w	d4,d4
	move.w	d3,Vvisrows(a5,d4.w)	; new visible map row on the bitmap

	;-------------------------------------------------------------
	; Blit tiles of a new row or column, when there is work to do
	;-------------------------------------------------------------
.work:
	; load needed pointers
	lea	Tiles(a4),a1
	lea	MapRowOffTab(a4),a2
	lea	RowOffTab(a4),a3
	move.l	Vlastdn(a5),d3
	move.l	FgMap(a4),d4
	move.l	Map(a4),d5

	; save small-data base - no static data is available in this section!
	move.l	a4,-(sp)

	; are there any new column tiles left to blit?
	move.w	Vcolcnt(a5),d7
	bne	.workcol
	bra	.chkrowcnt

.tileYPos:	; ypos to start drawing for each phase
	TILEYPOS
.tileYCnt:	; number of tiles to draw (-1) in each phase
	TILEYCNT

	;---------------------------------
	; draw some tiles of a new column
	;---------------------------------
.workcol:
	subq.w	#2,d7
	move.w	d7,Vcolcnt(a5)

	moveq	#0,d2
	move.w	Vmapcol(a5),d2		; column to blit
	move.w	.tileYPos(pc,d7.w),d6
	move.w	.tileYCnt(pc,d7.w),d7

	; calculate destination bitmap pointer for first tile to blit
	move.w	d6,d0
	move.l	Vbitmap(a5),a4
	add.w	d0,d0
	add.l	(a3,d0.w),a4		; add bitmap row-offset
	add.w	d2,a4
	add.w	d2,a4			; and add col-offset (col is 2 bytes)

	; preconfigure Blitter: copy D=A, AMOD=0, DMOD=BPR-2
	moveq	#-1,d1
	WAITBLIT
	move.l	d1,BLTAFWM(a6)
	move.l	#0<<16|BPR-2,BLTAMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)

.col_loop:
	; get the corresponding map row for a specific row on the display
	move.w	Vvisrows(a5,d6.w),d0
	cmp.w	Vdelrow(a5),d0
	beq	.col_nextrow		; tile is already obsolete, skip it
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a2,d0.w),d1
	add.l	d2,d1			; map-offset for current column/row

	; check for a new foreground block to draw
	move.l	d4,a0
	moveq	#0,d0
	move.b	(a0,d1.l),d0		; block number from foreground map
	beq	.col_draw		; no fg block, just draw the new tile

	; enter new foreground block into the DrawList
	exg	d3,a4
	move.l	DNnext(a4),a4
	tst.l	DNnext(a4)
	beq	.col_overfl		; DrawList overflowed! No more nodes.

	; initialize new DrawNode
	lea	DNcol(a4),a0
	move.w	d2,(a0)+		; DNcol
	move.w	Vvisrows(a5,d6.w),(a0)+ ; DNrow
	move.l	d1,d0
	add.l	d5,d0			; Map-pointer
	move.l	d0,(a0)+		; DNbmap
	add.l	d4,d1			; FgMap-pointer
	move.l	d1,(a0)+		; DNfmap
	move.l	d3,(a0)			; DNpos - bitmap pointer
	exg	d3,a4
	bra	.col_nextrow		; no need to draw the tile now

.col_overfl:
	ifd	DEBUG
	trap	#5			; DrawList is too small
	endif
	move.l	DNprev(a4),a4
	exg	d3,a4

.col_draw:
	; calculate address of tile image
	move.l	d5,a0
	moveq	#0,d0
	move.b	(a0,d1.l),d0		; tile number from map
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a1,d0.w),d1

	; blit next tile
	WAITBLIT
	move.l	d1,BLTAPT(a6)
	move.l	a4,BLTDPT(a6)
	move.w	#(16*PLANES)<<6|1,BLTSIZE(a6)

.col_nextrow:
	addq.w	#2,d6
	lea	16*PLANES*BPR(a4),a4
	dbf	d7,.col_loop

.chkrowcnt:
	; are there any new row tiles left to blit?
	move.w	Vrowcnt(a5),d7
	beq	.done
	bra	.workrow

.tileXOff:	; x-offset in columns to start drawing for each phase
	TILEXOFF
.tileXCnt:	; number of tiles to draw (-1) in each phase
	TILEXCNT

	;------------------------------
	; draw some tiles of a new row
	;------------------------------
.workrow:
	subq.w	#2,d7
	move.w	d7,Vrowcnt(a5)

	; calculate destination bitmap pointer for first tile to blit
	move.l	Vbitmap(a5),a4
	move.w	Vrowcol(a5),d1		; start column of this row
	add.w	d1,a4
	add.w	d1,a4			; add byte-offset of start-column
	move.w	.tileXOff(pc,d7.w),d2
	add.w	d2,a4
	add.w	d2,a4			; add byte-offset of phase
	move.w	Vbufrow(a5),d0
	add.w	d0,d0
	add.w	d0,d0
	add.l	(a3,d0.w),a4		; add bitmap row-offset

	; calculate map pointer to first tile
	move.l	d4,a3
	move.w	Vmaprow(a5),d0
	move.w	d0,d4			; d4 row
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a2,d0.w),a0		; row-offset
	add.w	d1,d2			; d2 row start-col + phase col-offset
	add.w	d2,a0			; map-offset
	add.l	a0,a3			; a3 foreground map pointer
	add.l	d5,a0			; a0 background map pointer

	; get number of tiles to blit - 1
	move.w	.tileXCnt(pc,d7.w),d7

	; The rightmost tile of the new row might become obsolete when
	; scrolling diagonally to the left. The last tile col calculates as:
	; row start-col + phase col-offset + tiles to blit - 1 (d2 + d7)
	; Do not draw it and especially do not create DrawNodes for
	; foreground blocks, when it was just deleted (column matches Vdelcol).
	move.w	d2,d0
	add.w	d7,d0
	cmp.w	Vdelcol(a5),d0
	bne	.rowpreconf
	subq.w	#1,d7			; ignore the rightmost tile

.rowpreconf:
	; preconfigure Blitter: copy D=A, AMOD=0, DMOD=BPR-2
	moveq	#-1,d1
	WAITBLIT
	move.l	d1,BLTAFWM(a6)
	move.l	#0<<16|BPR-2,BLTAMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)

	move.l	d3,a2			; last DrawNode

.row_loop:
	; check for a new foreground block to draw
	moveq	#0,d0
	move.b	(a3),d0			; block number from foreground map
	beq	.row_draw		; no fg block, just draw the new tile

	; enter new foreground block into the DrawList
	move.l	DNnext(a2),a2
	tst.l	DNnext(a2)
	beq	.row_overfl		; DrawList overflowed! No more nodes.

	; initialize new DrawNode
	move.l	a0,d1
	lea	DNcol(a2),a0
	move.w	d2,(a0)+		; DNcol
	move.w	d4,(a0)+		; DNrow
	move.l	d1,(a0)+		; DNbmap
	move.l	a3,(a0)+		; DNfmap
	move.l	a4,(a0)			; DNpos - bitmap pointer
	move.l	d1,a0
	addq.l	#1,a0
	bra	.row_nextcol		; no need to draw the tile now

.row_overfl:
	ifd	DEBUG
	trap	#5			; DrawList is too small
	endif
	move.l	DNprev(a2),a2

.row_draw:
	; calculate address of tile image
	move.b	(a0)+,d0		; next tile in row
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a1,d0.w),d1		; address of tile image

	; blit next tile
	WAITBLIT
	move.l	d1,BLTAPT(a6)
	move.l	a4,BLTDPT(a6)
	move.w	#(16*PLANES)<<6|1,BLTSIZE(a6)

.row_nextcol:
	addq.l	#1,a3
	addq.l	#2,a4
	addq.w	#1,d2
	dbf	d7,.row_loop

	move.l	a2,d3

.done:
	; restore small data base
	move.l	(sp)+,a4

	; update last DrawNode
	move.l	d3,Vlastdn(a5)
	rts


;---------------------------------------------------------------------------
del_drawnode_x:
; a5 = View
; d0.w = disable DrawNodes with this column
; uses d6/d7/a0/a1/a2

	move.l	Vdrawlist(a5),a2
	bra	.4

.1:	cmp.w	d0,d6
	bne	.3

	; disable DrawNode
	moveq	#-1,d6
	move.l	d6,DNcol(a2)		; disabled

	; remove this node
	move.l	a2,a0
	REMOVE	a0,a1			; a0 becomes previous DrawNode

	cmp.l	Vlastdn(a5),a2
	bne	.2
	move.l	a0,Vlastdn(a5)		; previous is new last DrawNode

	; add it to list's tail
.2:	lea	Vdrawlist(a5),a0
	ADDTAIL	a0,a2,d6

.3:	move.l	d7,a2
.4:	move.l	DNnext(a2),d7
	beq	.5
	move.w	DNcol(a2),d6
	bpl	.1

.5:	rts


;---------------------------------------------------------------------------
del_drawnode_y:
; a5 = View
; d0.w = disable DrawNodes with this row
; uses d6/d7/a0/a1/a2

	move.l	Vdrawlist(a5),a2
	bra	.4

.1:	cmp.w	d0,d6
	bne	.3

	; disable DrawNode
	moveq	#-1,d6
	move.l	d6,DNcol(a2)		; disabled

	; remove this node
	move.l	a2,a0
	REMOVE	a0,a1			; a0 becomes previous DrawNode

	cmp.l	Vlastdn(a5),a2
	bne	.2
	move.l	a0,Vlastdn(a5)		; previous is new last DrawNode

	; add it to list's tail
.2:	lea	Vdrawlist(a5),a0
	ADDTAIL	a0,a2,d6

.3:	move.l	d7,a2
.4:	move.l	DNnext(a2),d7
	beq	.5
	move.w	DNrow(a2),d6
	bpl	.1

.5:	rts


;---------------------------------------------------------------------------
	xdef	moveView
moveView:
; Keep the display centered around the given coordinates.
; d0 = xpos.w
; d1 = ypos.w
; Registers, except a4 - a6, are not preserved!

	; load display position on map
	movem.w	Xpos(a4),d2-d4
	move.w	#DISPW-1,d6
	add.w	d2,d6
	move.w	#DISPH-1,d7
	add.w	d3,d7

	; load map limits
	move.l	ScrHeight(a4),d5

	; d2.w = Display left border (X0)
	; d3.w = Display top border (Y0)
	; d4.w = Ymod
	; d5   = map-height | map-width
	; d6.w = Display right border (X1)
	; d7.w = Display bottom border (Y1)

	; horizontal movement - right
	sub.w	d0,d6			; distance to right border
	cmp.w	#SLOW_HOR_MARGIN,d6
	bgt	.2
	addq.w	#1,d2
	cmp.w	#FAST_HOR_MARGIN,d6
	bgt	.1
	addq.w	#1,d2

.1:	move.w	#DISPW,d0
	add.w	d2,d0
	cmp.w	d5,d0
	blo	.4
	move.w	d5,d2
	sub.w	#DISPW,d2		; maximum Xpos is ScrWidth-DISPW
	bra	.4

	; horizontal movement - left
.2:	sub.w	d2,d0			; distance to left border
	cmp.w	#SLOW_HOR_MARGIN,d0
	bgt	.4
	subq.w	#1,d2
	cmp.w	#FAST_HOR_MARGIN,d0
	bgt	.3
	subq.w	#1,d2

.3:	tst.w	d2
	bpl	.4
	moveq	#0,d2			; minimum Xpos is 0

	; vertical movement - bottom
.4:	swap	d5
	sub.w	d1,d7			; distance to bottom border
	cmp.w	#SLOW_BOT_MARGIN,d7
	bgt	.6
	addq.w	#1,d3
	addq.w	#1,d4
	cmp.w	#FAST_BOT_MARGIN,d7
	bgt	.5
	addq.w	#1,d3
	addq.w	#1,d4
	cmp.w	#VFST_BOT_MARGIN,d7
	bgt	.5
	addq.w	#2,d3			; falling fast, scroll 4 pixels/frame
	addq.w	#2,d4

.5:	move.w	#DISPH,d1
	add.w	d3,d1
	cmp.w	d5,d1
	blo	.8
	move.w	d3,d0
	move.w	d5,d3
	sub.w	#DISPH,d3		; maximum Ypos is ScrHeight-DISPH
	sub.w	d3,d0
	sub.w	d0,d4
	bra	.8

	; vertical movement - top
.6:	sub.w	d3,d1			; distance to top border
	cmp.w	#SLOW_TOP_MARGIN,d1
	bgt	.8
	subq.w	#1,d3
	subq.w	#1,d4
	cmp.w	#FAST_TOP_MARGIN,d1
	bgt	.7
	subq.w	#1,d3
	subq.w	#1,d4

.7:	tst.w	d3
	bpl	.8
	moveq	#0,d3			; minimum Ypos is 0
	moveq	#0,d4

	; fix Ymod
.8:	move.w	#BMAPH,d0
	tst.w	d4
	bmi	.9
	cmp.w	d0,d4
	blt	.10
	sub.w	d0,d4
	SKIPW
.9:	add.w	d0,d4

	; new bitmap position to display
.10:	movem.w	d2-d4,Xpos(a4)
	rts


;---------------------------------------------------------------------------
	xdef	load_copperback
load_copperback:
; Load a table with height and color of background copper bars. Format:
;   dc.w height,rgb4 ...
; d0.w = file ID

	move.l	CopperbarTab(a4),a0
	bsr	td_loadcr
	beq	loaderr
	cmp.l	#4*MAXMAPH*16/2,d0
	bhi	ovflowerr
	rts



	section	__MERGED,data


CopperbarTab:
	dc.l	Copperbars



	section	__MERGED,bss


	; Coordinates of upper/left display pixel on the map.
	; Ymod is Ypos modulo BMAPH.
Xpos:
	ds.w	1
Ypos:
	ds.w	1
Ymod:
	ds.w	1

	; Position on the copper background. Pointer to the color entry
	; from Copperbars and the line-offset within the current bar.
CbackPos:
	ds.w	1
CbackPtr:
	ds.l	1
CbackOffs:
	ds.w	1



	bss


	; Space for the copper background definitions. The worst case is
	; a changed color in each line (which shouldn't happen). As we
	; scroll the background at half of the vertical scroll speed, the
	; size would be half of the maximum map height * 16 pixels per block.
	; WARNING: the minimum height of a copper background should be
	; the maximum map height in pixels / 2 + DISPH / 2.
Copperbars:
	ds.l	MAXMAPH*16/2

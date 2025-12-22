*
* Draw and animate background tiles
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* init_tiles()
* load_tiles(d0.w=fileID, a0=tiletypes)
* makeBlkTable(a0=typebuf, a1=imgtable, a2=imgdata, d0.w=maxentr, d1.w=imgsz)
* makeSwitchTileTab()
* $draw_tiles(a5=View, d2.w=xpos, d3.w=ypos, d4.w=ypos%BMAPH)
* $drawlist_backgd(a5=View)
* initTileAnims(a0=tileAnimParams, a1=tileAnimTypes)
* switchTiles(d0.b=tilecode)
* d0=retrig = newSingleTileAnim(d0.w=xpos, d1.w=ypos, d2=retrig.w|tile.b,
*                               a0=mapoffset)
* d0=retrig = newTileAnimSeq(d0.w=col, d1.w=row, d2=retrig|speed|last|first,
*                            a0=mapoffset)
* newTileAnimLoop(d0.w=col, d1.w=row, d2=retrig|speed|last|first, a0=mapoffset)
* $updateTileAnims(a5=View)
*
* Tiles
*

	include	"custom.i"
	include	"display.i"
	include	"scroll.i"
	include	"view.i"
	include	"map.i"
	include	"tiles.i"
	include	"macros.i"


; from memory.asm
	xref	alloc_chipmem

; from trackdisk.asm
	xref	td_loadcr_chip

; from main.asm
	xref	loaderr
	xref	panic

; from game.asm
	xref	BackgdBlocks

; from map.asm
	xref	Map
	xref	FgMap
	xref	MapWidth
	xref	MapHeight
	xref	MapRowOffTab



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	init_tiles
init_tiles:
; get Chip RAM for background tile images

	; make multiplication table for tile rows
	sub.l	a0,a0
	move.w	#BPR*PLANES*16,d0
	moveq	#YBLOCKS-1,d1
	lea	RowOffTab(a4),a1
.1:	move.l	a0,(a1)+
	add.w	d0,a0
	dbf	d1,.1

	rts


;---------------------------------------------------------------------------
	xdef	load_tiles
load_tiles:
; d0 = tile file id
; a0 = table of 256 tile types (empty, unmasked, masked)

	move.l	a2,-(sp)
	move.l	a0,-(sp)

	; load tiles into Chip RAM
	bsr	td_loadcr_chip
	beq	loaderr

	move.l	d0,a2
	move.l	(sp)+,a0
	lea	Tiles(a4),a1
	move.w	#256,d0
	move.w	#BLKSIZE,d1
	bsr	makeBlkTable

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
	xdef	makeBlkTable
makeBlkTable:
; Construct a table of block image pointers using an array of 256 image
; types (0=empty, 1=unmasked, 2=masked). Empty blocks use the pointer
; to image 0.
; a0 = Buffer of 256 type bytes
; a1 = table of image pointers to set up
; a2 = Interleaved image data for all present blocks
; d0.w = maximum table entries
; d1.w = size of an unmasked image

	movem.l	d2-d3,-(sp)
	move.l	a2,d2			; remember pointer to first image
	bra	.3

.1:	move.b	(a0)+,d3
	bne	.2
	move.l	d2,(a1)+		; empty
	bra	.3
.2:	move.l	a2,(a1)+
	add.w	d1,a2
	subq.b	#1,d3
	beq	.3
	add.w	d1,a2			; includes mask
.3:	dbf	d0,.1

	movem.l	(sp)+,d2-d3
	rts


;---------------------------------------------------------------------------
	xdef	makeSwitchTileTab
makeSwitchTileTab:
; Construct a table with tile codes to replace and their locations,
; whenever the appropriate switch is activated.
; Scan the background map for tiles where the following tile code has
; the type BB_SWITCH and remember it.
; Switches have always to be defined as a series of four tile codes
; in the background tile table:
; <new tile> <old tile> <switch inactive> <switch active>

	movem.l	d2-d7/a2,-(sp)

	move.l	Map(a4),a0
	move.l	SwitchTiles(a4),a1
	move.l	BackgdBlocks(a4),a2

	moveq	#MAXSWITCHTILES,d7
	move.w	MapHeight(a4),d6
	move.w	MapWidth(a4),d5
	moveq	#BB_SWITCH,d4
	moveq	#0,d3
	moveq	#0,d0

.1:	moveq	#0,d2
.2:	move.l	a0,d1
	move.b	(a0)+,d0
	cmp.b	1(a2,d0.w),d4
	bne	.3

	; This tile can be controlled by a switch. Remember its location.
	subq.w	#1,d7
	bmi	.4
	move.b	d0,(a1)+		; STold, old tile code
	subq.b	#1,d0
	move.b	d0,(a1)+		; STnew will be STold - 1
	move.w	d2,(a1)+		; STcol
	move.w	d3,(a1)+		; STrow
	sub.l	Map(a4),d1
	move.l	d1,(a1)+		; STmapoff

.3:	addq.w	#1,d2
	cmp.w	d5,d2
	bne	.2

	addq.w	#1,d3
	cmp.w	d6,d3
	bne	.1

	; last entry is indicated by a 0 in STold and STnew
	clr.w	(a1)

	movem.l	(sp)+,d2-d7/a2
	rts

.4:	move.w	#$8f8,d0		; light green: too many switch tiles
	bra	panic


;---------------------------------------------------------------------------
	xdef	draw_tiles
draw_tiles:
; Draw all background tiles, which are visible at the given coordinates.
; Initialize the View's DrawList and enter all visible foreground blocks
; into it.
; a5 = View
; d2 = xpos
; d3 = ypos
; d4 = ypos modulo BMAPH
; Registers, except a4 - a6, are not preserved!

	; initialize the View's foreground block drawlist as empty
	lea	Vdrawlist(a5),a1
	lea	Vdrawnodes(a5),a2
	move.l	a1,Vlastdn(a5)
	move.l	a1,a3			; a3 Vlastdn
	move.l	a1,d0
	move.l	a2,(a1)+		; list head
	clr.l	(a1)			; list tail
	moveq	#NUM_DRAWNODES-1,d1

.1:	lea	sizeof_DrawNode(a2),a1
	move.l	a1,DNnext(a2)
	move.l	d0,DNprev(a2)
	move.l	#-1,DNcol(a2)
	move.l	a2,d0
	move.l	a1,a2
	dbf	d1,.1

	move.l	d0,a2			; last node
	lea	Vdrawlist+4(a5),a1
	move.l	a1,DNnext(a2)
	move.l	a2,Vdrawlist+8(a5)

	; initialize constant blitter regs: copy D=A, AMOD=0, DMOD=BPR-2
	moveq	#-1,d0
	WAITBLIT
	move.l	d0,BLTAFWM(a6)
	move.l	#0<<16|BPR-2,BLTAMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)

	; convert xpos/ypos into tile-columns/rows
	asr.w	#4,d2
	asr.w	#4,d3
	asr.w	#4,d4

	; We have to start one column left and one row on top of the
	; actual display location. The invisible tiles to the left and
	; on top have to be pre drawn to make scrolling work.
	subq.w	#1,d2
	bpl	.10
	moveq	#0,d2			; map ends here - no tiles to the left
.10:	tst.w	d3
	beq	.11			; map ends here - no tiles on top
	subq.w	#1,d3
	subq.w	#1,d4
	bpl	.11
	moveq	#YBLOCKS-1,d4

	; calculate map pointer for xpos,ypos
.11:	move.l	Map(a4),a0
	move.l	FgMap(a4),a2
	lea	MapRowOffTab(a4),a1
	move.w	d3,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a1,d0.w),a1		; row offset
	add.w	d2,a1			; add column offset
	add.l	a1,a0
	add.l	a1,a2

	moveq	#0,d6
	move.w	d2,d6
	add.w	d6,d6			; column*2
	add.l	Vbitmap(a5),d6		; d6 View bitmap + column offset

	add.w	d4,d4			; d4 row-modulo*2

	; draw XBLOCKS-1 tiles per row, but don't exceed the MapWidth!
	move.w	MapWidth(a4),d5
	moveq	#XBLOCKS-1,d0
	add.w	d0,d2
	cmp.w	d5,d2
	ble	.12

	; don't draw more tiles per row than the map is wide!
	sub.w	d5,d2
	sub.w	d2,d0			; limit number of tiles to draw
	move.w	d5,d2			; last column + 1 is MapWidth

.12:	sub.w	d0,d5
	swap	d5
	move.w	d0,d5			; d5 MapWidth-modulo | tiles per row

	; draw all YBLOCKS rows
	moveq	#YBLOCKS-1,d7

	; draw a row of XBLOCKS-1 tiles (limited by MapWidth)
.2:	swap	d7
	move.w	d2,d7			; last column + 1
	sub.w	d5,d7			; current column to draw
	swap	d5
	move.w	d3,Vvisrows(a5,d4.w)	; remember visible map rows on bitmap

	; calculate destination bitmap pointer
	move.l	d6,d1			; bitmap column
	lea	RowOffTab(a4),a1
	move.w	d4,d0
	add.w	d0,d0
	add.l	(a1,d0.w),d1		; add row offset

.3:	tst.b	(a2)			; current block on FgMap
	beq	.5

	; enter new foreground block into the DrawList
	move.l	DNnext(a3),a3
	tst.l	DNnext(a3)
	beq	.4

	lea	DNcol(a3),a1
	move.w	d7,(a1)+		; DNcol
	move.w	d3,(a1)+		; DNrow
	move.l	a0,(a1)+		; DNbmap
	move.l	a2,(a1)+		; DNfmap
	move.l	d1,(a1)			; DNpos - bitmap pointer
	bra	.5

	; DrawList overflowed! No more nodes.
.4:	move.l	DNprev(a3),a3

.5:	addq.l	#1,a2

	; get pointer to background tile image
	lea	Tiles(a4),a1
	moveq	#0,d0
	move.b	(a0)+,d0		; tile number from map
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a1,d0.w),d0

	; blit the tile
	WAITBLIT
	move.l	d0,BLTAPT(a6)
	move.l	d1,BLTDPT(a6)
	move.w	#(16*PLANES)<<6|1,BLTSIZE(a6)

	; next tile in a row
	addq.l	#2,d1
	addq.w	#1,d7
	cmp.w	d2,d7
	bne	.3

	; next row
	addq.w	#1,d3
	cmp.w	MapHeight(a4),d3
	bge	.7			; stop at bottom of map
	addq.w	#2,d4
	cmp.w	#YBLOCKS*2,d4
	bne	.6
	moveq	#0,d4			; next row starts at the bitmap's top

	; move map pointer to the beginning of the next row
.6:	add.w	d5,a0
	add.w	d5,a2
	swap	d5
	swap	d7
	dbf	d7,.2

.7:	move.l	a3,Vlastdn(a5)

	; disable Vdelcol/Vdelrow comparison
	moveq	#-2,d0
	move.w	d0,Vdelcol(a5)
	move.w	d0,Vdelrow(a5)
	rts


;---------------------------------------------------------------------------
	xdef	drawlist_backgd
drawlist_backgd:
; Update all background tiles from the DrawList.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	lea	Tiles(a4),a2
	move.l	Vdrawlist(a5),a3

	; preconfigure Blitter: copy D=A, AMOD=0, DMOD=BPR-2
	moveq	#-1,d0
	WAITBLIT
	move.l	d0,BLTAFWM(a6)
	move.l	#0<<16|BPR-2,BLTAMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)

	bra	.2

	; draw next background tile
.1:	move.l	DNbmap(a3),a0
	moveq	#0,d0
	move.b	(a0),d0		; tile-code from map
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a2,d0.w),d0	; background tile image
	move.l	DNpos(a3),d1	; destination on bitmap

	WAITBLIT
	move.l	d0,BLTAPT(a6)
	move.l	d1,BLTDPT(a6)
	move.w	#(16*PLANES)<<6|1,BLTSIZE(a6)

	move.l	d2,a3
.2:	move.l	DNnext(a3),d2
	beq	.3
	tst.w	DNcol(a3)
	bpl	.1

.3:	rts


;---------------------------------------------------------------------------
resetTileAnims:
; Disable all tile animations.
; a1 is preserved!

	move.l	TileAnims(a4),a0
	moveq	#MAXTILEANIMS-1,d0
.1:	clr.w	TAtype(a0)
	lea	sizeof_TileAnim(a0),a0
	dbf	d0,.1
	rts


;---------------------------------------------------------------------------
	xdef	initTileAnims
initTileAnims:
; Reset all background tile animations. Then scan the map for continuous
; background tile animations and start them.
; a0 = tile animation parameter table (list of byte-pairs: nPhases, speed)
; a1 = tile animation types (0 = no animation)

	movem.l	d2/d6-d7/a2-a3,-(sp)
	ifd	DEBUG
	movem.l	a0-a1,$7ff10
	endif
	move.l	a0,a3			; a3 tile animation parameter table

	bsr	resetTileAnims

	move.l	Map(a4),a2
	sub.l	a0,a0			; a0 map offset
	moveq	#0,d6
	moveq	#0,d7

.1:	moveq	#0,d1
	move.b	(a2)+,d1

	; check if next map tile has to be animated
	moveq	#0,d0
	move.b	(a1,d1.w),d0
	beq	.2

	; yes, set up d2: speed << 16 | last_tile << 8 | first_tile
	; from LoopTileAnimData
	moveq	#0,d2
	move.b	1(a3,d0.w),d2		; speed
	swap	d2
	move.b	d1,d2
	subq.b	#1,d2
	add.b	(a3,d0.w),d2		; last tile
	lsl.w	#8,d2
	move.b	d1,d2			; first tile

	; establish new background tile animation loop
	move.w	d6,d0
	move.w	d7,d1
	bsr	newTileAnimLoop

	; next tile
.2:	addq.l	#1,a0
	addq.w	#1,d6
	cmp.w	MapWidth(a4),d6
	bne	.1

	; next map row
	moveq	#0,d6
	addq.w	#1,d7
	cmp.w	MapHeight(a4),d7
	bne	.1

	movem.l	(sp)+,d2/d6-d7/a2-a3
	rts


;---------------------------------------------------------------------------
	xdef	switchTiles
switchTiles:
; Replace all tiles with the given code on the map with the new tile code
; from SwitchTileTab. Create single-tile animations for all occurences,
; to make sure the tiles are also replaced on the visible bitmap.
; d0.b = tile code to replace
; d2 is destroyed!

	move.l	d3,-(sp)
	move.l	SwitchTiles(a4),a1
	moveq	#0,d2
	lsl.w	#8,d0
	move.w	d0,d3			; d3 tile to replace << 8
	bra	.2

.1:	move.b	d1,d2			; d2 retrigger.w | tilecode.w
	clr.b	d1
	cmp.w	d3,d1			; STold matches tile code to replace?
	beq	.3
	lea	sizeof_SwiTile-STcol(a1),a1
.2:	move.w	(a1)+,d1		; STold/STnew
	bne	.1

	move.l	(sp)+,d3
	rts

	; Found a matching entry. Create a single-tile animation for it.
.3:	move.w	(a1)+,d0		; STcol
	move.w	(a1)+,d1		; STrow
	move.l	(a1)+,a0		; STmapoff
	pea	.2(pc)			; return address


;---------------------------------------------------------------------------
newSingleTileAnimCR:
; Establish a new TA_SINGLE animation. With column/row coordinates.
; d0.w = column
; d1.w = row
; d2 = retrigger.w | tile-code.b
; a0 = map offset
; a0, a1 are preserved!
; -> d0 = Z : animation has been retriggered

	movem.l	d3/a0-a1,-(sp)
	swap	d0
	move.w	d1,d0
	bra	newSingleTileAnimMain


;---------------------------------------------------------------------------
	xdef	newSingleTileAnim
newSingleTileAnim:
; Establish a new TA_SINGLE animation.
; d0.w = xpos
; d1.w = ypos
; d2 = retrigger.w | tile-code.b
; a0 = map offset
; a0, a1 are preserved!
; -> d0 = Z : animation has been retriggered

	movem.l	d3/a0-a1,-(sp)

	; convert xpos/ypos to map column/row
	asr.w	#4,d0
	swap	d0
	asr.w	#4,d1
	move.w	d1,d0

newSingleTileAnimMain:
; d0 = column.w | row.w

	; find a free animation slot
	moveq	#0,d3
	move.l	TileAnims(a4),a1
	moveq	#MAXTILEANIMS-1,d1

.1:	tst.w	TAtype(a1)
	beq	.2
	cmp.l	TAcol(a1),d0
	bne	.3

	; Same position.
	moveq	#0,d1			; set d1=0 for retriggered
	tst.l	d2
	bpl	.5			; do not retrigger
	move.w	#TA_SINGLE,TAtype(a1)	; update/retrigger running animation
	lea	TAview1(a1),a1
	bra	.4

.2:	tst.l	d3
	bne	.3
	move.l	a1,d3
.3:	lea	sizeof_TileAnim(a1),a1
	dbf	d1,.1

	tst.l	d3
	ifd	DEBUG
	beq	outoftileanims
	else
	beq	.5			; out of animation slots
	endif

	; initialize new TA_SINGLE animation
	move.l	d3,a1
	move.w	#TA_SINGLE,(a1)+
	move.l	d0,(a1)+		; TAcol, TArow
	move.l	a0,(a1)+		; TAmapoff
	clr.l	(a1)+			; TAbmoff will be calculated

	; save old tile in TAview1, TAview2 and write new tile
.4:	add.l	Map(a4),a0
	move.b	(a0),d0
	move.b	d0,(a1)+		; TAview1
	move.b	d0,(a1)+		; TAview2
	move.b	d2,(a0)

.5:	movem.l	(sp)+,d3/a0-a1
	move.w	d1,d0			; retrigger-flag
	rts

	ifd	DEBUG
outoftileanims:
	trap	#6			; out of animation slots
	endif


;---------------------------------------------------------------------------
	xdef	newTileAnimSeq
newTileAnimSeq:
; Establish a new TA_SEQUENCE animation.
; d0.w = xpos
; d1.w = ypos
; d2 = retrigger | animation speed << 16 | last tile << 8 | first tile code
; a0 = map offset
; a0, a1 are preserved!
; -> d0 = Z : animation has been retriggered

	movem.l	d3/a0-a1,-(sp)

	; convert xpos/ypos to map column/row
	asr.w	#4,d0
	swap	d0
	asr.w	#4,d1
	move.w	d1,d0			; d0 = column | row

	; find a free animation slot
	moveq	#0,d3
	move.l	TileAnims(a4),a1
	moveq	#MAXTILEANIMS-1,d1

.1:	tst.w	TAtype(a1)
	beq	.2
	cmp.l	TAcol(a1),d0
	bne	.3

	; Same position.
	moveq	#0,d1			; set d1=0 for retriggered
	tst.l	d2
	bpl	.5			; do not retrigger
	move.w	#TA_SEQUENCE,TAtype(a1)	; update/retrigger running animation
	lea	TAview1(a1),a1
	bra	.4

.2:	tst.l	d3
	bne	.3
	move.l	a1,d3
.3:	lea	sizeof_TileAnim(a1),a1
	dbf	d1,.1

	tst.l	d3
	ifd	DEBUG
	beq	outoftileanims
	else
	beq	.5			; out of animation slots
	endif

	; initialize new TA_SEQUENCE animation
	move.l	d3,a1
	move.w	#TA_SEQUENCE,(a1)+
	move.l	d0,(a1)+		; TAcol, TArow
	move.l	a0,(a1)+		; TAmapoff
	clr.l	(a1)+			; TAbmoff will be calculated

	; save old tile in TAview1, TAview2 and write new tile
.4:	add.l	Map(a4),a0
	move.b	(a0),d0
	move.b	d0,(a1)+		; TAview1
	move.b	d0,(a1)+		; TAview2
	move.b	d2,(a0)

	; set animation parameters
	move.w	d2,(a1)+		; TAlast, TAfirst
	swap	d2
	move.b	d2,(a1)+		; TAcnt
	move.b	d2,(a1)			; TAspeed

.5:	movem.l	(sp)+,d3/a0-a1
	move.w	d1,d0			; retrigger-flag
	rts


;---------------------------------------------------------------------------
	xdef	newTileAnimLoop
newTileAnimLoop:
; Establish a new TA_LOOP animation.
; d0.w = map column
; d1.w = map row
; d2 = retrigger | animation speed << 16 | last tile << 8 | first tile code
; a0 = map offset
; a0, a1 are preserved!

	movem.l	d3/a0-a1,-(sp)
	swap	d0
	move.w	d1,d0			; d0 = column | row

	; find a free animation slot
	moveq	#0,d3
	move.l	TileAnims(a4),a1
	moveq	#MAXTILEANIMS-1,d1

.1:	tst.w	TAtype(a1)
	beq	.2
	cmp.l	TAcol(a1),d0
	bne	.3

	; Same position.
	tst.l	d2
	bpl	.5			; do not retrigger
	move.w	#TA_LOOP,TAtype(a1)	; update/retrigger running animation
	lea	TAview1(a1),a1
	bra	.4

.2:	tst.l	d3
	bne	.3
	move.l	a1,d3
.3:	lea	sizeof_TileAnim(a1),a1
	dbf	d1,.1

	tst.l	d3
	ifd	DEBUG
	beq	outoftileanims
	else
	beq	.5			; out of animation slots
	endif

	; initialize new TA_LOOP animation
	move.l	d3,a1
	move.w	#TA_LOOP,(a1)+
	move.l	d0,(a1)+		; TAcol, TArow
	move.l	a0,(a1)+		; TAmapoff
	clr.l	(a1)+			; TAbmoff will be calculated

	; save old tile in TAview1, TAview2 and write new tile
.4:	add.l	Map(a4),a0
	move.b	(a0),d0
	move.b	d0,(a1)+		; TAview1
	move.b	d0,(a1)+		; TAview2
	move.b	d2,(a0)

	; set animation parameters
	move.w	d2,(a1)+		; TAlast, TAfirst
	swap	d2
	move.b	d2,(a1)+		; TAcnt
	move.b	d2,(a1)			; TAspeed

.5:	movem.l	(sp)+,d3/a0-a1
	rts


;---------------------------------------------------------------------------
	xdef	updateTileAnims
updateTileAnims:
; Process active tile animation and generate new DrawNodes, when required.
; Automatically disable a TA_SINGLE or TA_SEQUENCE animation when done.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	movem.l	a4/a6,-(sp)

	; Calculate start and stop column/row of the map currently displayed
	; d6 = startrow | startcol, d7 = stoprow | stopcol
	move.l	Vxpos(a5),d6
	asr.w	#4,d6
	moveq	#YBLOCKS-2,d7
	add.w	d6,d7
	subq.w	#1,d6
	swap	d6
	swap	d7
	asr.w	#4,d6
	move.w	d6,d7
	add.w	#XBLOCKS-3,d7
	subq.w	#1,d6

	move.l	TileAnims(a4),a0
	moveq	#MAXTILEANIMS-1,d2

	; load all pointers and constants we need
	move.l	Map(a4),a2
	move.l	FgMap(a4),d4
	lea	RowOffTab(a4),a3
	move.l	Vlastdn(a5),a6		; a6 last DrawNode
	move.w	Vvisrows(a5),d5
	swap	d5
	move.w	Vid(a5),d5		; d5 top row | View ID (0 or 1)

.updateloop:
	move.w	TAtype(a0),d0
	beq	.animskip

	; get current tile code from map into d2
	swap	d2
	move.l	TAmapoff(a0),d3
	add.l	d3,a2			; a2 Map-pointer
	move.b	(a2),d2

	; check if animation is visible
	move.l	TAcol(a0),d1
	swap	d6
	swap	d7
	cmp.w	d6,d1
	blt	.invis_swap
	cmp.w	d7,d1
	bge	.invis_swap
	swap	d1
	swap	d6
	swap	d7
	cmp.w	d6,d1
	blt	.invisible
	cmp.w	d7,d1
	blt	.visible

	; block is currently invisible, animate it nevertheless
.invisible:
	clr.l	TAbmoff(a0)		; recalculate offset on next visibility
	move.b	d2,TAview1(a0,d5.w)	; invisible means TAviewN is ok
	move.w	.animjmptab-2(pc,d0.w),d0
	jmp	.animjmptab(pc,d0.w)

.invis_swap:
	clr.l	TAbmoff(a0)		; recalculate offset on next visibility
	move.b	d2,TAview1(a0,d5.w)	; invisible means TAviewN is ok
	swap	d6
	swap	d7
	move.w	.animjmptab-2(pc,d0.w),d0
	jmp	.animjmptab(pc,d0.w)

.visible:
	; Check if we need a new DrawNode. This is the case when both
	; of the following conditions are true:
	; 1. The tile in TAviewN in not the same as on the map.
	; 2. The foreground map (FgMap) has a zero tile at TAmapoff

	cmp.b	TAview1(a0,d5.w),d2	; compare Map tile with TAview1/2
	beq	.animate

	move.b	d2,TAview1(a0,d5.w)	; now we set this tile with a DrawNode

	move.l	d4,a1
	add.l	d3,a1			; a1 FgMap-pointer
	tst.b	(a1)			; location on FgMap occupied?
	bne	.animate

	; Create a new DrawNode to update the tile on the screen.

	move.l	DNnext(a6),a6
	tst.l	DNnext(a6)
	beq	.overflowed		; DrawList overflowed!

	lea	DNcol(a6),a4
	swap	d1
	move.l	d1,(a4)+		; DNcol, DNrow
	move.l	a2,(a4)+		; DNbmap
	move.l	a1,(a4)+		; DNfmap

	; calculate bitmap pointer for DrawNode
	move.l	TAbmoff(a0),d3
	bne	.2

	; need to recalculate the bitmap offset
	swap	d5
	sub.w	d5,d1			; subtract bitmap's top row
	bpl	.1
	add.w	#YBLOCKS,d1		; row is before the split - adjust
.1:	add.w	d1,d1
	add.w	d1,d1
	move.l	(a3,d1.w),a1		; row offset
	swap	d1
	add.w	d1,d1
	add.w	d1,a1			; add column offset
	move.l	a1,TAbmoff(a0)
	move.l	a1,d3
	swap	d5

	; bitmap offset is known, so use it
.2	add.l	Vbitmap(a5),d3
	move.l	d3,(a4)			; DNpos

.animate:
	move.w	.animjmptab-2(pc,d0.w),d0
	jmp	.animjmptab(pc,d0.w)

.animjmptab:
	dc.w	.animsingle-.animjmptab
	dc.w	.animsequence-.animjmptab
	dc.w	.animloop-.animjmptab

.overflowed:
	ifd	DEBUG
	trap	#6			; DrawList is too small
	endif
	move.l	DNprev(a6),a6		; return to last node
	sub.l	TAmapoff(a0),a2		; restore Map pointer a2

.animnext:
	swap	d2
.animskip:
	lea	sizeof_TileAnim(a0),a0
	dbf	d2,.updateloop

.animdone:
	; update last DrawNode pointer
	move.l	a6,Vlastdn(a5)

	movem.l	(sp)+,a4/a6
	rts


; Register setup for animation type sub routines:
;------------------------------------------------
; a0 = TileAnimation structure
; a2 = Map pointer to tile location
; d2.b = current tile code from map

	macro	ANIMNEXT
	sub.l	TAmapoff(a0),a2		; restore Map pointer a2
	swap	d2
	lea	sizeof_TileAnim(a0),a0	; next tile animation slot
	dbf	d2,.updateloop
	bra	.animdone
	endm


.animsingle:
	cmp.b	TAview1(a0),d2
	bne	.sng1
	cmp.b	TAview2(a0),d2
	bne	.sng1

	; single tile animation has been written into both views
	clr.w	TAtype(a0)		; disable this animation

.sng1:	ANIMNEXT


.animsequence:
	subq.b	#1,TAcnt(a0)
	bne	.seq2

	; next animation phase
	move.b	TAspeed(a0),TAcnt(a0)
	cmp.b	TAlast(a0),d2
	bne	.seq1

	; disable, when last phase was written to both bitmaps
	cmp.b	TAview1(a0),d2
	bne	.seq2
	cmp.b	TAview2(a0),d2
	bne	.seq2
	clr.w	TAtype(a0)		; disable this animation
	bra	.seq2

	; next phase
.seq1:	addq.b	#1,d2
	move.b	d2,(a2)			; write next tile code into map

.seq2:	ANIMNEXT


.animloop:
	subq.b	#1,TAcnt(a0)
	bne	.lop2

	; next animation phase
	move.b	TAspeed(a0),TAcnt(a0)
	cmp.b	TAlast(a0),d2
	bne	.lop1
	move.b	TAfirst(a0),d2		; restart with first tile
	subq.b	#1,d2
.lop1:	addq.b	#1,d2
	move.b	d2,(a2)			; write next tile code into map

.lop2:	ANIMNEXT



	section	__MERGED,data


	; Pointer to tile animation table
TileAnims:
	dc.l	TileAnimTab

	; Pointer to switch tiles table
SwitchTiles:
	dc.l	SwitchTileTab



	section	__MERGED,bss


	; Table with all background tile pointers
	xdef	Tiles
Tiles:
	ds.l	256

	; Bitmap row multiplication table
	xdef	RowOffTab
RowOffTab:
	ds.l	YBLOCKS



	bss

	; Table of tile animations
TileAnimTab:
	ds.b	MAXTILEANIMS*sizeof_TileAnim

	; Coordinates and pointers to tiles to be replaced when a
	; matching switch (BB_SWITCH) is activated.
	; Plus 2 bytes as a stop mark, when all slots are occupied.
SwitchTileTab:
	ds.b	MAXSWITCHTILES*sizeof_SwiTile+2

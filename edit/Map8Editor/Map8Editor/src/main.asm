*
* Map Editor main loop
*
* main()
* initgfx()
* d0/Z=error = loadMap(a0=filename)
* d0/Z=error = loadTileGfx(a0=filename)
* d0/Z=error = loadFgGfx(a0=filename)
* saveMap(a0=filename)
*
* Quit
*

	include	"custom.i"
	include "map.i"
	include	"display.i"
	include	"main.i"
	include	"view.i"
	include	"macros.i"


; from startup.asm
	xref	ParamPtr
	xref	ParamLen

; from os.asm
	xref	openFile
	xref	closeFile
	xref	readFile
	xref	writeFile

; from display.asm
	xref	startdisplay
	xref	switchView
	xref	set_sprite
	xref	View
	xref	InfoBitmap

; from input.asm
	xref	readController



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	main
main:
; Running in VERTB interrupt.
; All registers except d0, a4 and a5 must be restored when used!
; a4 = SmallData Base
; a6 = CUSTOM

	movem.l	d1-d7/a0-a3,-(sp)

	addq.w	#1,FrameCounter(a4)
	bsr	switchView
	move.l	a0,a5		; a5 rendering View

	move.w	DebugColor(a4),COLOR00(a6)
	; animate foreground blocks
	bsr	animate_fgblocks

	; position cursor sprite for currently visible View (old coordinates)
	bsr	move_cursor

	; show block markers, when visible
	bsr	move_markers

	; read controls, update cursor position and print status to info-disp.
	bsr	update_pos
	bsr	print_pos

	; position the background-view onto the new coordinates
	bsr	scroll

	; restore background from DrawList
	bsr	drawlist_backgd

	; write modified tiles into the View's bitmap
	bsr	update_bitmap

	; execute commands
	bsr	do_command

	; foreground animations from DrawList
	bsr	drawlist_foregd
	move.w	ColorTab(a4),COLOR00(a6)

	movem.l	(sp)+,d1-d7/a0-a3
	rts


;---------------------------------------------------------------------------
do_command:
; Execute an editor command.
; Fire-button: Put selected tile into current position.
; Registers, except a4 - a6, are not preserved!

	tst.b	UpdateInfo(a4)
	beq	.0
	clr.b	UpdateInfo(a4)
	bsr	print_tilesel	; update selected tile

.0:	tst.b	Button(a4)
	beq	.4

	tst.b	Plane(a4)
	bne	.1

	; write selected tile to map and remember to update in bitmap
	move.l	View(a4),a0
	move.l	View+4(a4),a1
	move.l	Map(a4),a2
	lea	MapRowOffTab(a4),a3

	move.w	LastRow(a4),d0
	move.w	d0,Vputrow(a0)
	move.w	d0,Vputrow(a1)
	add.w	d0,d0
	add.w	d0,d0
	add.l	(a3,d0.w),a2
	moveq	#0,d0
	move.w	LastCol(a4),d0
	move.w	d0,Vputcol(a0)
	move.w	d0,Vputcol(a1)
	move.b	SelTile(a4),(a2,d0.w)

	bsr	update_bitmap	; draw the tile immediately
	bra	.4

	; write selected foreground block
.1:	move.l	FgMap(a4),a2
	lea	MapRowOffTab(a4),a3

	move.w	LastRow(a4),d3
	move.w	d3,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a3,d0.w),d4
	moveq	#0,d2
	move.w	LastCol(a4),d2
	add.l	d2,d4		; d4 map offset
	move.b	SelFgBlk(a4),d5
	beq	.3
	tst.b	(a2,d4.l)
	bne	.3		; foreground block was already present?

	; make a new DrawNode for both Views
	move.l	View(a4),a0
	bsr	makenewdrawnode
	move.l	View+4(a4),a0
	bsr	makenewdrawnode

.3:	move.b	d5,(a2,d4.l)

	; any of the number keys sets a monster at the current location
.4:	moveq	#0,d4
	move.b	MonsterSet(a4),d4
	beq	.7

	clr.b	MonsterSet(a4)
	move.w	LastCol(a4),d2
	move.w	LastRow(a4),d3

	; first check if this position already has a monster, then replace it
	lea	MonsterTab(a4),a2
	moveq	#NUM_MONSTERS-1,d6
.50:	tst.w	Mtype(a2)
	beq	.51
	cmp.w	Mcol(a2),d2
	bne	.51
	cmp.w	Mrow(a2),d3
	beq	.5
.51:	addq.l	#sizeof_Monster,a2
	dbf	d6,.50

	; now find a free slot in the MonsterTab a2
	lea	MonsterTab(a4),a2
	moveq	#NUM_MONSTERS-1,d6
.52:	tst.w	Mtype(a2)
	addq.l	#sizeof_Monster,a2
	dbeq	d6,.52
	bne	.20		; monster limit reached!
	subq.l	#sizeof_Monster,a2
	addq.w	#1,MonsterCount(a4)
	bsr	print_monstcnt

	; determine direction and fix type, initialize Monster entry
.5:	tst.b	d4
	spl	d5
	bpl	.6
	neg.b	d4
.6:	ext.w	d5
	move.w	d4,(a2)+	; Mtype
	move.w	d5,(a2)+	; Mdir
	move.w	d2,(a2)+	; Mcol
	move.w	d3,(a2)		; Mrow

	; add it to the DrawList of both Views
	move.l	View(a4),a0
	move.w	d4,d0
	move.w	d5,d1
	bsr	addMonster
	move.l	View+4(a4),a0
	move.w	d4,d0
	move.w	d5,d1
	bsr	addMonster
	bra	.20

.7:	tst.b	MonsterClear(a4)
	beq	.20

	; clear a monster at the current location, when existing
	clr.b	MonsterClear(a4)
	move.w	LastCol(a4),d2
	move.w	LastRow(a4),d3

	; find current location in MonsterTab
	lea	MonsterTab(a4),a2
	moveq	#NUM_MONSTERS-1,d6
.8:	tst.w	Mtype(a2)
	beq	.9
	cmp.w	Mcol(a2),d2
	bne	.9
	cmp.w	Mrow(a2),d3
	beq	.10
.9:	addq.l	#sizeof_Monster,a2
	dbf	d6,.8
	bra	.20		; nothing to delete!

	; disable this monster slot
.10:	clr.w	Mtype(a2)

	; remove monster image from the DrawNode in both Views
	move.l	View(a4),a0
	bsr	remMonster
	move.l	View+4(a4),a0
	bsr	remMonster

	; update monster counter
	subq.w	#1,MonsterCount(a4)
	bsr	print_monstcnt

.20:	tst.b	FillFlag(a4)
	beq	.21

	; fill marked background and foreground map region
	move.b	SelTile(a4),d0
	move.l	Map(a4),a0
	bsr	fill_map
;	move.b	SelFgBlk(a4),d0		@@@ do not fill foreground
;	move.l	FgMap(a4),a0
;	bsr	fill_map

	clr.b	FillFlag(a4)
	bsr	hide_blockmarker

.21:	tst.b	CopyFlag(a4)
	beq	.22

	; copy marked background and foreground map region to current pos.
	move.l	Map(a4),a0
	bsr	copy_map
	move.l	FgMap(a4),a0
	bsr	copy_map

	clr.b	CopyFlag(a4)
	bsr	hide_blockmarker

.22:	rts


;---------------------------------------------------------------------------
fill_map:
; Fill the map region between StrtCol/Row and StopCol/Row.
; a0 = map base pointer
; d0 = tile to fill with

	move.w	StopCol(a4),d2
	move.w	StopRow(a4),d3

	; calculate start address of map region to fill
	lea	MapRowOffTab(a4),a1
	move.l	StrtCol(a4),d1
	sub.w	d1,d3		; d3 number of rows - 1
	add.w	d1,d1
	add.w	d1,d1
	add.l	(a1,d1.w),a0	; add StrtRow
	swap	d1
	add.w	d1,a0		; add StrtCol
	sub.w	d1,d2		; d2 number of columns - 1

	; fill loop
.1:	move.w	d2,d1
	move.l	a0,a1

.2:	move.b	d0,(a1)+
	dbf	d1,.2

	add.w	#MAPW,a0
	dbf	d3,.1

	rts


;---------------------------------------------------------------------------
copy_map:
; Copy the map region between StrtCol/Row and StopCol/Row to the current
; position from LastCol/Row. Copy descending when needed.
; a0 = map base pointer

	move.w	StopCol(a4),d2
	move.w	StopRow(a4),d3

	; calculate source and destination start address
	lea	MapRowOffTab(a4),a2
	move.l	a0,a1
	move.l	LastCol(a4),d0
	add.w	d0,d0
	add.w	d0,d0
	add.l	(a2,d0.w),a1
	swap	d0
	add.w	d0,a1		; a1 destination map pointer

	move.l	StrtCol(a4),d0
	sub.w	d0,d3		; d3 number of rows top copy - 1
	add.w	d0,d0
	add.w	d0,d0
	add.l	(a2,d0.w),a0
	swap	d0
	add.w	d0,a0		; a0 source map pointer
	sub.w	d0,d2		; d2 number of columns to copy - 1

	cmp.l	a0,a1
	bhi	.3

	; ascending copy
.1:	move.w	d2,d1
	move.l	a0,a2
	move.l	a1,a3
.2:	move.b	(a2)+,(a3)+
	dbf	d1,.2
	add.w	#MAPW,a0
	add.w	#MAPW,a1
	dbf	d3,.1
	rts

	; descending copy
.3:	move.w	d3,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a2,d0.w),d1
	add.l	d1,a1
	add.w	d2,a1
	addq.l	#1,a1		; a1 destination bottom right block + 1
	add.l	d1,a0
	add.w	d2,a0
	addq.l	#1,a0		; a0 source bottom right block + 1

.4:	move.w	d2,d1
	move.l	a0,a2
	move.l	a1,a3
.5:	move.b	-(a2),-(a3)
	dbf	d1,.5
	sub.w	#MAPW,a0
	sub.w	#MAPW,a1
	dbf	d3,.4
	rts


;---------------------------------------------------------------------------
hide_blockmarker:
; Move the block-marker sprites into the invisible border.

	moveq	#-1,d0
	move.l	d0,StrtCol(a4)
	move.l	d0,StopCol(a4)

	moveq	#-16,d0
	moveq	#-16,d1
	moveq	#2,d2
	moveq	#16,d3
	bsr	set_sprite
	moveq	#-16,d0
	moveq	#-16,d1
	moveq	#3,d2
	moveq	#16,d3
	bra	set_sprite


;---------------------------------------------------------------------------
makenewdrawnode:
; a0 = View
; d2 = column
; d3 = row
; d4 = map offset
; -> d0/Z = new DrawNode, or NULL

	movem.l	d2-d3/a2-a3,-(sp)

	move.l	Vlastdn(a0),a3
	move.l	DNnext(a3),a3
	move.l	DNnext(a3),d0
	beq	.2		; DrawList overflowed!

	lea	DNcol(a3),a2
	move.w	d2,(a2)+	; DNcol
	move.w	d3,(a2)+	; DNrow

	; calculate bitmap destination address
	move.w	MapY(a4),d0
	sub.w	MapYMod(a4),d0
	asr.w	#4,d0
	sub.w	d0,d3
	cmp.w	#YBLOCKS,d3
	blt	.1
	sub.w	#YBLOCKS,d3
.1:	lea	RowOffTab(a4),a1
	add.w	d3,d3
	add.w	d3,d3
	move.l	(a1,d3.w),a1	; bitmap row-offset
	add.l	Vbitmap(a0),a1
	add.w	d2,d2
	add.w	d2,a1		; plus column-offset
	move.l	a1,(a2)+	; DNpos

	; write map pointers
	move.l	Map(a4),d0
	add.l	d4,d0
	move.l	d0,(a2)+	; DNbmap
	move.l	FgMap(a4),d0
	add.l	d4,d0
	move.l	d0,(a2)+	; DNfmap
	clr.l	(a2)		; DNmonster
	move.l	a3,Vlastdn(a0)	; new last DrawNode

	move.l	a3,d0
.2:	movem.l	(sp)+,d2-d3/a2-a3
	rts


;---------------------------------------------------------------------------
addMonster:
; Add a new monster to the DrawList. The row/column defines the position of
; the monster's feet. It may be higher than 16 pixels.
; We first have to look whether a DrawNode for the given coordinate
; already exists. Only create a new DrawNode when it doesn't.
; a0 = View
; d0.w = monster type (1-9)
; d1.w = direction (-1 or 1)
; d2.w = column
; d3.w = row

	; calculate pointer to monster image d1
	lea	MonsterLabels(a4),a1
	subq.w	#1,d0
	add.w	d0,d0
	add.w	d0,d0
	tst.w	d1
	bmi	.1
	lea	9*4(a1),a1
.1:	move.l	(a1,d0.w),d1

	move.l	Vdrawlist(a0),a1
	bra	.4

	; scan through all active DrawNodes
.2:	cmp.w	DNcol(a1),d2
	bne	.3
	cmp.w	DNrow(a1),d3
	bne	.3

	; found a matching DrawNode, so we can reuse it!
	move.l	d1,DNmonster(a1)
	rts

.3:	move.l	d0,a1
.4:	move.l	DNnext(a1),d0
	beq	.5		; out of DrawNodes!
	tst.w	DNcol(a1)
	bpl	.2

	; create a new DrawNode
	movem.l	d1/d4,-(sp)
	lea	MapRowOffTab(a4),a1
	move.w	d3,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a1,d0.w),a1
	add.w	d2,a1
	move.l	a1,d4		; d4 map offset
	bsr	makenewdrawnode
	movem.l	(sp)+,d1/d4
	beq	.5		; out of DrawNodes!

	; set monster image to it
	move.l	d0,a1
	move.l	d1,DNmonster(a1)

.5:	rts


;---------------------------------------------------------------------------
remMonster:
; Remove a monster from the DrawList when it exists.
; a0 = View
; d2.w = column
; d3.w = row

	move.l	Vdrawlist(a0),a1
	bra	.3

	; scan through all active DrawNodes
.1:	cmp.w	DNcol(a1),d2
	bne	.2
	cmp.w	DNrow(a1),d3
	bne	.2

	; Clear monster image pointer. The DrawNode will be deleted
	; automatically, when there is also no foreground block to draw.
	clr.l	DNmonster(a1)
	rts

.2:	move.l	d0,a1
.3:	move.l	DNnext(a1),d0
	beq	.4
	tst.w	DNcol(a1)
	bpl	.1

.4:	rts


;---------------------------------------------------------------------------
animate_fgblocks:
; Increment the animation phase for all blocks which support animation.

	lea	FgAnimTab(a4),a0
	lea	FgAnimPhase(a4),a1
	moveq	#0,d0
	bra	.4

.1:	subq.b	#1,(a0)		; decrement animation speed counter
	bne	.3

	; it's time for the next animation phase
	move.b	1(a0),(a0)	; reset speed counter
	move.b	(a1,d0.w),d1
	addq.b	#1,d1		; next animation phase
	cmp.b	2(a0),d1
	blo	.2
	moveq	#0,d1		; reset animation phase to 0
.2:	move.b	d1,(a1,d0.w)

.3:	addq.l	#3,a0
.4:	move.b	(a0)+,d0
	bne	.1
	rts


;---------------------------------------------------------------------------
update_bitmap:
; Blit a modified tile into the bitmap.
; Registers, except a4 - a6, are not preserved!
; a5 = View

	move.w	MapY(a4),d7
	sub.w	MapYMod(a4),d7
	asr	#4,d7

	move.w	Vputrow(a5),d0
	bmi	.exit

	;---------------------------------------------
	; We have to blit a tile from Vputcol/Vputrow
	;---------------------------------------------

	; a0 calculate address of this row in the map
	move.l	Map(a4),a0
	move.w	d0,d1
	lea	MapRowOffTab(a4),a1
	add.w	d1,d1
	add.w	d1,d1
	add.l	(a1,d1.w),a0

	; determine Vputrow modulo YBLOCKS, which is the buffer-row to blit
	sub.w	d7,d0
	bmi	.exit
	cmp.w	#YBLOCKS,d0
	blt	.1
	sub.w	#YBLOCKS,d0

	; a3 calculate desintation address in bitmap
.1:	move.l	Vbitmap(a5),a3
	move.w	Vputcol(a5),d1
	add.w	d1,a3		; add column-offset
	add.w	d1,a3
	lea	RowOffTab(a4),a1
	add.w	d0,d0
	add.w	d0,d0
	add.l	(a1,d0.w),a3	; add row-offset

	; a2 get tile image pointer
	lea	Blocks(a4),a1
	moveq	#0,d0
	move.b	(a0,d1.w),d0	; tile number from map
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a1,d0.w),a2

	; blit the changed tile
	moveq	#-1,d1
	WAITBLIT
	move.l	d1,BLTAFWM(a6)
	move.l	#0<<16|BPR-2,BLTAMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)
	move.l	a2,BLTAPT(a6)
	move.l	a3,BLTDPT(a6)
	move.w	#(16*PLANES)<<6|1,BLTSIZE(a6)

	move.l	d1,Vputcol(a5)	; clear modified tile coordinates

.exit:
	rts


;---------------------------------------------------------------------------
drawlist_backgd:
; Update all background tiles from the DrawList.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	lea	Blocks(a4),a2
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
drawlist_foregd:
; Update all animated foreground blocks and monsters from the DrawList.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	tst.b	BlinkFlag(a4)
	beq	.draw
	btst	#4,FrameCounter+1(a4)
	bne	.exit

.draw:
	lea	FgAnimPhase(a4),a1
	lea	FgBlocks(a4),a2
	move.l	Vdrawlist(a5),a3

	; preconfigure Blitter: D=AB+/AC, AMOD/BMOD=0, CMOD/DMOD=BPR-2
	moveq	#-1,d0
	move.l	#0<<16|BPR-2,d1
	WAITBLIT
	move.l	d0,BLTAFWM(a6)
	move.l	d1,BLTAMOD(a6)
	swap	d1
	move.l	d1,BLTCMOD(a6)
	move.l	#$0fca0000,BLTCON0(a6)
	bra	.3

	; draw next foreground block
.1:	move.l	DNfmap(a3),a0
	moveq	#0,d0
	move.b	(a0),d0		; block-code from map
	bne	.4
	move.l	DNmonster(a3),d1
	beq	.del_drawnode	; no foreground block and no monster
	move.l	DNpos(a3),d0	; destination on bitmap
	bra	.5
.4:	add.b	(a1,d0.w),d0	; add the block's current animation phase
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a2,d0.w),a0	; foreground image block pointer
	move.l	DNpos(a3),d0	; destination on bitmap

	WAITBLIT
	move.l	d0,BLTCPT(a6)
	move.l	a0,BLTBPT(a6)
	lea	BLKSIZE(a0),a0	; offset to mask
	move.l	a0,BLTAPT(a6)
	move.l	d0,BLTDPT(a6)
	move.w	#(16*PLANES)<<6|1,BLTSIZE(a6)

	move.l	DNmonster(a3),d1
	beq	.2
	; draw a monster label
.5:	move.l	d1,a0
	WAITBLIT
	move.l	d0,BLTCPT(a6)
	move.l	a0,BLTBPT(a6)
	lea	BLKSIZE(a0),a0	; offset to mask
	move.l	a0,BLTAPT(a6)
	move.l	d0,BLTDPT(a6)
	move.w	#(16*PLANES)<<6|1,BLTSIZE(a6)

.2:	move.l	d2,a3
.3:	move.l	DNnext(a3),d2
	beq	.exit
	tst.w	DNcol(a3)
	bpl	.1
.exit:
	rts

.del_drawnode:
	; Foreground block is 0. Disable this DrawNode and move it to
	; the end of the list.
	move.l	a1,d3
	moveq	#-1,d0
	move.l	d0,DNcol(a3)	; disabled

	; remove this node
	move.l	DNprev(a3),a0
	move.l	DNnext(a3),a1
	move.l	a1,DNnext(a0)
	move.l	a0,DNprev(a1)

	cmp.l	Vlastdn(a5),a3
	bne	.addtail
	move.l	a0,Vlastdn(a5)	; new last DrawNode

.addtail:
	; add it to list's tail
	lea	Vdrawlist+4(a5),a0
	move.l	DNprev(a0),a1
	move.l	a3,DNnext(a1)
	move.l	a0,DNnext(a3)
	move.l	a1,DNprev(a3)
	move.l	a3,DNprev(a0)

	move.l	d3,a1
	bra	.2


;---------------------------------------------------------------------------
; Horizontal scroll codes for BPLCON1, xpos 0..15
ScrollTab:
	dc.w	$0000,$00ff,$00ee,$00dd,$00cc,$00bb,$00aa,$0099
	dc.w	$0088,$0077,$0066,$0055,$0044,$0033,$0022,$0011


scroll:
; Scroll the View to match the current MapX/MapY coordinates.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	move.w	MapX(a4),d2	; new coordinates
	move.w	MapY(a4),d3
	move.w	MapYMod(a4),d4

copper_scroll:
; Change BPLPTx and BPLCON1 to view the requested position.
; a5 = View
; d2 = xpos
; d4 = ypos modulo BMAPH
; Destroys a2, d6, d7!

	move.l	Vclist(a5),a2

	; write fine scrolling code for (xpos & 15)
	moveq	#15,d0
	and.w	d2,d0
	add.w	d0,d0
	move.w	ScrollTab(pc,d0.w),Cl_scroll+2(a2)

	; calculate xoffset on bitplanes
	move.l	Vbitmap(a5),a0
	move.w	d2,d0
	subq.w	#1,d0
	and.w	#$fff0,d0
	asr.w	#3,d0
	add.w	d0,a0

	; calculate a second bitplane pointer with x- and yoffset
	lea	YOffTab(a4),a1
	move.w	d4,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a1,d0.w),d6
	add.l	a0,d6		; d6 (top): bitmap + xoffset + yoffset
	move.l	a0,d7		; d7 (split): bitmap + xoffset

	; calculate raster line of display split
	move.w	#VSCROLLEND,d0
	moveq	#-3*16,d1
	add.w	d4,d1
	bmi	.2		; no split
	sub.w	d1,d0

	; write WAIT command for split line
.2:	move.b	d0,Cl_waitsplit+4(a2)
	and.w	#$ff00,d0
	sne	Cl_waitsplit(a2)
	seq	Cl_waitend(a2)

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


	; Load/update View position
	move.w	Vxpos(a5),d0	; get old coordinates
	move.w	Vypos(a5),d1
	move.w	d2,Vxpos(a5)	; update with new coordinates
	move.w	d3,Vypos(a5)

blitter_scroll:
; Draw new blocks in the border when required.
; a5 = View
; d0 = oldxpos
; d1 = oldypos
; d2 = newxpos
; d3 = newypos
; d4 = newypos modulo BMAPH

	; convert xpos/ypos into tile-columns/rows
	asr.w	#4,d0
	asr.w	#4,d1
	asr.w	#4,d2
	asr.w	#4,d3

	; check if a new column was entered
	cmp.w	d0,d2
	beq	.check_dy
	bgt	.pos_dx

	; negative dx
	moveq	#XBLOCKS-2,d0
	add.w	d2,d0
	bsr	del_drawnode_x
	moveq	#-1,d0
	add.w	d2,d0		; column from map to blit
	bmi	.check_dy
	move.w	d0,Vmapcol(a5)
	move.w	#BLTPHASES*2,Vcolcnt(a5)
	bra	.check_dy

	; positive dx
.pos_dx:
	moveq	#-2,d0
	add.w	d2,d0
	bsr	del_drawnode_x
	moveq	#XBLOCKS-3,d0
	add.w	d2,d0		; column from map to blit
	cmp.w	#MAPW,d0
	bge	.check_dy
	move.w	d0,Vmapcol(a5)
	move.w	#BLTPHASES*2,Vcolcnt(a5)

.check_dy:
; d1 = old row
; d2 = new column
; d3 = new row
; d4 = newypos modulo BMAPH

	; check if a new row was entered
	cmp.w	d1,d3
	beq	.work
	bgt	.pos_dy

	; negative dy
	moveq	#YBLOCKS-1,d0
	add.w	d3,d0
	bsr	del_drawnode_y
	subq.w	#1,d3		; row from map to blit
	bmi	.work
	asr.w	#4,d4
	subq.w	#1,d4		; row on bitmap to update
	bpl	.setyblt
	add.w	#YBLOCKS,d4
	bra	.setyblt

	; positive dy
.pos_dy:
	moveq	#-2,d0
	add.w	d3,d0
	bsr	del_drawnode_y
	moveq	#YBLOCKS-2,d0
	add.w	d0,d3		; row from map to blit
	cmp.w	#MAPH,d3
	bge	.work
	asr.w	#4,d4
	add.w	d0,d4		; row on bitmap to update
	cmp.w	#YBLOCKS,d4
	blt	.setyblt
	sub.w	#YBLOCKS,d4

.setyblt:
	subq.w	#1,d2		; column-offset for this row
	move.w	d2,Vrowcol(a5)
	move.w	d3,Vmaprow(a5)
	move.w	d4,Vbufrow(a5)
	move.w	#BLTPHASES*2,Vrowcnt(a5)
	add.w	d4,d4
	move.w	d3,Vvisrows(a5,d4.w)

.work:
	; load needed pointers
	lea	Blocks(a4),a1
	lea	MapRowOffTab(a4),a2
	lea	RowOffTab(a4),a3
	move.l	Vlastdn(a5),d3
	move.l	FgMap(a4),d4
	move.l	Map(a4),d5

	; save small-data base - no static data is available in this section!
	move.l	a4,-(sp)

	; are there any new columne tiles left to blit?
	move.w	Vcolcnt(a5),d7
	beq	.chkrowcnt
	bra	.workcol

.tileYPos:	; ypos to start drawing for each phase
	TILEYPOS
.tileYCnt:	; number of tiles to draw in each phase
	TILEYCNT

	;---------------------------------
	; draw some tiles of a new column
	;---------------------------------
.workcol:
	subq.w	#2,d7
	move.w	d7,Vcolcnt(a5)

	moveq	#0,d2
	move.w	Vmapcol(a5),d2	; column to blit
	move.w	.tileYPos(pc,d7.w),d6
	move.w	.tileYCnt(pc,d7.w),d7

	; calculate destination bitmap pointer for first tile to blit
	move.w	d6,d0
	move.l	Vbitmap(a5),a4
	add.w	d0,d0
	add.l	(a3,d0.w),a4	; add bitmap row-offset
	add.w	d2,a4
	add.w	d2,a4		; and add column-offset (column is 2 bytes)

	; preconfigure Blitter: copy D=A, AMOD=0, DMOD=BPR-2
	moveq	#-1,d1
	WAITBLIT
	move.l	d1,BLTAFWM(a6)
	move.l	#0<<16|BPR-2,BLTAMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)

.col_loop:
	; get the corresponding map row for a specific row on the display
	move.w	Vvisrows(a5,d6.w),d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a2,d0.w),d1
	add.l	d2,d1		; map-offset for current column/row

	; check for a new foreground block to draw
	move.l	d4,a0
	moveq	#0,d0
	move.b	(a0,d1.l),d0	; block number from foreground map
	beq	.col_draw	; no foreground block, just draw the new tile

	; enter new foreground block into the DrawList
	exg	d3,a4
	move.l	DNnext(a4),a4
	tst.l	DNnext(a4)
	beq	.col_overfl	; DrawList overflowed! No more nodes.

	; initialize new DrawNode
	lea	DNcol(a4),a0
	move.w	d2,(a0)+	; DNcol
	move.w	Vvisrows(a5,d6.w),(a0)+ ; DNrow
	move.l	d3,(a0)+	; DNpos - bitmap pointer
	move.l	d1,d0
	add.l	d5,d0		; Map-pointer
	move.l	d0,(a0)+	; DNbmap
	add.l	d4,d1		; FgMap-pointer
	move.l	d1,(a0)+	; DNfmap
	clr.l	(a0)		; DNmonster
	exg	d3,a4
	bra	.col_nextrow	; no need to draw the tile now

.col_overfl:
	move.l	DNprev(a4),a4
	exg	d3,a4

.col_draw:
	; calculate address of tile image
	move.l	d5,a0
	moveq	#0,d0
	move.b	(a0,d1.l),d0	; tile number from map
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

	tst.w	Vcolcnt(a5)
	bne	.chkrowcnt

	; last tile of column blitted: check for new monsters in column d2
	move.l	(sp),a4
	move.l	d3,Vlastdn(a5)
	bsr	check_monster_col
	move.l	Vlastdn(a5),d3

.chkrowcnt:
	; are there any new row tiles left to blit?
	move.w	Vrowcnt(a5),d7
	beq	.done
	bra	.workrow

.tileXOff:	; x-offset in columns to start drawing for each phase
	TILEXOFF
.tileXCnt:	; number of tiles to draw in each phase
	TILEXCNT

	;------------------------------
	; draw some tiles of a new row
	;------------------------------
.workrow:
	subq.w	#2,d7
	move.w	d7,Vrowcnt(a5)

	; calculate destination bitmap pointer for first tile to blit
	move.l	Vbitmap(a5),a4
	move.w	Vrowcol(a5),d1	; start column of this row
	add.w	d1,a4
	add.w	d1,a4		; add byte-offset of start-column
	move.w	.tileXOff(pc,d7.w),d2
	add.w	d2,a4
	add.w	d2,a4		; add byte-offset of phase
	move.w	Vbufrow(a5),d0
	add.w	d0,d0
	add.w	d0,d0
	add.l	(a3,d0.w),a4	; add bitmap row-offset

	; calculate map pointer to first tile
	move.l	d4,a3
	move.w	Vmaprow(a5),d0
	move.w	d0,d4		; d4 row
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a2,d0.w),a0	; row-offset
	add.w	d1,d2		; d2 start-col of row + col-offset of phase
	add.w	d2,a0		; map-offset
	add.l	a0,a3		; a3 foreground map pointer
	add.l	d5,a0		; a0 background map pointer

	; number of tiles to blit
	move.w	.tileXCnt(pc,d7.w),d7

	; preconfigure Blitter: copy D=A, AMOD=0, DMOD=BPR-2
	moveq	#-1,d1
	WAITBLIT
	move.l	d1,BLTAFWM(a6)
	move.l	#0<<16|BPR-2,BLTAMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)

	move.l	d3,a2		; last DrawNode

.row_loop:
	; check for a new foreground block to draw
	moveq	#0,d0
	move.b	(a3),d0		; block number from foreground map
	beq	.row_draw	; no foreground block, just draw the new tile

	; enter new foreground block into the DrawList
	move.l	DNnext(a2),a2
	tst.l	DNnext(a2)
	beq	.row_overfl	; DrawList overflowed! No more nodes.

	; initialize new DrawNode
	move.l	a0,d1
	lea	DNcol(a2),a0
	move.w	d2,(a0)+	; DNcol
	move.w	d4,(a0)+	; DNrow
	move.l	a4,(a0)+	; DNpos - bitmap pointer
	move.l	d1,(a0)+	; DNbmap
	move.l	a3,(a0)+	; DNfmap
	clr.l	(a0)		; DNmonster
	move.l	d1,a0
	addq.l	#1,a0
	bra	.row_nextcol	; no need to draw the tile now

.row_overfl:
	move.l	DNprev(a2),a2

.row_draw:
	; calculate address of tile image
	move.b	(a0)+,d0	; next tile in row
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a1,d0.w),d1	; address of tile image

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

	tst.w	Vrowcnt(a5)
	beq	.chk_monst_row
	move.l	a2,d3

.done:
	; restore small data base
	move.l	(sp)+,a4

	; update last DrawNode
	move.l	d3,Vlastdn(a5)
	rts

	; last tile of row blitted: check for new monsters in row d4
.chk_monst_row:
; (sp) = SmallDataBase a4
; d4 = new row
; a2 = last DrawNode

	move.l	(sp)+,a4
	move.l	a2,Vlastdn(a5)
	move.w	d4,d3
	bra	check_monster_row


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
	move.l	d6,DNcol(a2)	; disabled

	; remove this node
	move.l	DNprev(a2),a0
	move.l	DNnext(a2),a1
	move.l	a1,DNnext(a0)
	move.l	a0,DNprev(a1)

	cmp.l	Vlastdn(a5),a2
	bne	.2
	move.l	a0,Vlastdn(a5)	; new last DrawNode

	; add it to list's tail
.2:	lea	Vdrawlist+4(a5),a0
	move.l	DNprev(a0),a1
	move.l	a2,DNnext(a1)
	move.l	a0,DNnext(a2)
	move.l	a1,DNprev(a2)
	move.l	a2,DNprev(a0)

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
	move.l	d6,DNcol(a2)	; disabled

	; remove this node
	move.l	DNprev(a2),a0
	move.l	DNnext(a2),a1
	move.l	a1,DNnext(a0)
	move.l	a0,DNprev(a1)

	cmp.l	Vlastdn(a5),a2
	bne	.2
	move.l	a0,Vlastdn(a5)	; new last DrawNode

	; add it to list's tail
.2:	lea	Vdrawlist+4(a5),a0
	move.l	DNprev(a0),a1
	move.l	a2,DNnext(a1)
	move.l	a0,DNnext(a2)
	move.l	a1,DNprev(a2)
	move.l	a2,DNprev(a0)

.3:	move.l	d7,a2
.4:	move.l	DNnext(a2),d7
	beq	.5
	move.w	DNrow(a2),d6
	bpl	.1

.5:	rts


;---------------------------------------------------------------------------
check_monster_col:
; Checks for new monsters in column d2 and any of the 18 rows from Vvisrows.
; a5 = View
; d2.w = column

	movem.l	d0-d7/a0-a3,-(sp)
	lea	MonsterTab(a4),a2
	moveq	#NUM_MONSTERS-1,d6

.1:	move.w	Mtype(a2),d0
	beq	.4
	cmp.w	Mcol(a2),d2
	bne	.4

	; check if monster is located at any of the visible rows
	lea	Vvisrows(a5),a3
	moveq	#YBLOCKS-1,d7

.2:	move.w	(a3)+,d3
	cmp.w	Mrow(a2),d3
	bne	.3

	; add the new monster to the DrawList
	move.w	Mdir(a2),d1
	move.l	a5,a0
	bsr	addMonster

.3:	dbf	d7,.2

.4:	addq.l	#sizeof_Monster,a2
	dbf	d6,.1

	movem.l	(sp)+,d0-d7/a0-a3
	rts


;---------------------------------------------------------------------------
check_monster_row:
; Checks for new monsters in row d3 and any of the 23 columns starting
; with Vrowcol.
; a5 = View
; d3.w = row

	movem.l	d2/d4-d6/a2,-(sp)
	move.w	Vrowcol(a5),d4
	moveq	#XBLOCKS-1,d5
	add.w	d4,d5
	lea	MonsterTab(a4),a2
	moveq	#NUM_MONSTERS-1,d6

.1:	move.w	Mtype(a2),d0
	beq	.2
	cmp.w	Mrow(a2),d3
	bne	.2

	; check if monster is located within the visible columns
	move.w	Mcol(a2),d2
	cmp.w	d4,d2
	blt	.2
	cmp.w	d5,d2
	bge	.2

	; add the new monster to the DrawList
	move.w	Mdir(a2),d1
	move.l	a5,a0
	bsr	addMonster

.2:	addq.l	#sizeof_Monster,a2
	dbf	d6,.1

	movem.l	(sp)+,d2/d4-d6/a2
	rts


;---------------------------------------------------------------------------
update_pos:
; Update the current cursor and map position, according to user control.
; Registers, except a4 - a6, are not preserved!

	moveq	#1,d0
	bsr	readController

	; remember button state
	tst.l	d0
	smi	Button(a4)

	and.l	#$00ff00ff,d0
	bne	.check_directions

	; joystick is centered: auto-align on tile borders
	move.w	MapY(a4),d1
	add.w	CursorY(a4),d1
	moveq	#15,d2
	and.w	d1,d2
	beq	.checkx

	; generate up/down direction to align ypos
	addq.b	#1,d0
	btst	#3,d1
	bne	.checkx
	subq.b	#2,d0

.checkx:
	swap	d0
	move.w	MapX(a4),d1
	add.w	CursorX(a4),d1
	moveq	#15,d2
	and.w	d1,d2
	beq	.check_directions

	; generate left/right direction to align xpos
	addq.b	#1,d0
	btst	#3,d1
	bne	.check_directions
	subq.b	#2,d0

.check_directions:
	move.w	CursorX(a4),d1
	tst.b	d0
	beq	.5
	bmi	.2

	; cursor right
	addq.w	#SCROLLSPEED,d1
	cmp.w	#DISPW-SCROLLMARGIN-BLKW,d1
	ble	.4

	; scroll right
	move.w	d1,d2
	sub.w	#DISPW-SCROLLMARGIN-BLKW,d2
	add.w	MapX(a4),d2
	cmp.w	#MAPW*BLKW-DISPW,d2
	ble	.1
	move.w	#MAPW*BLKW-DISPW,d2
	cmp.w	#DISPW-BLKW,d1
	ble	.4
	move.w	#DISPW-BLKW,d1
	bra	.4
.1:	move.w	d2,MapX(a4)
	move.w	#DISPW-SCROLLMARGIN-BLKW,d1
	bra	.4

	; cursor left
.2:	subq.w	#SCROLLSPEED,d1
	cmp.w	#SCROLLMARGIN,d1
	bge	.4

	; scroll left
	move.w	d1,d2
	sub.w	#SCROLLMARGIN,d2
	add.w	MapX(a4),d2
	bpl	.3
	moveq	#0,d2
	tst.w	d1
	bpl	.4
	moveq	#0,d1
	bra	.4
.3:	move.w	d2,MapX(a4)
	moveq	#SCROLLMARGIN,d1

.4:	move.w	d1,CursorX(a4)

.5:	move.w	CursorY(a4),d1
	swap	d0
	tst.b	d0
	beq	.10
	bmi	.7

	; cursor down
	addq.w	#SCROLLSPEED,d1
	cmp.w	#DISPH-SCROLLMARGIN-BLKH,d1
	ble	.9

	; scroll down
	move.w	d1,d2
	sub.w	#DISPH-SCROLLMARGIN-BLKH,d2
	move.w	d2,d3
	add.w	MapY(a4),d2
	cmp.w	#MAPH*BLKH-DISPH,d2
	ble	.6
	move.w	#MAPH*BLKH-DISPH,d2
	cmp.w	#DISPH-BLKH,d1
	ble	.9
	move.w	#DISPH-BLKH,d1
	bra	.9
.6:	move.w	#DISPH-SCROLLMARGIN-BLKH,d1
	move.w	d2,MapY(a4)
	add.w	d3,MapYMod(a4)
	cmp.w	#BMAPH,MapYMod(a4)
	ble	.9
	sub.w	#BMAPH,MapYMod(a4)
	bra	.9

	; cursor up
.7:	subq.w	#SCROLLSPEED,d1
	cmp.w	#SCROLLMARGIN,d1
	bge	.9

	; scroll up
	move.w	d1,d2
	sub.w	#SCROLLMARGIN,d2
	move.w	d2,d3
	add.w	MapY(a4),d2
	bpl	.8
	moveq	#0,d2
	tst.w	d1
	bpl	.9
	moveq	#0,d1
	bra	.9
.8:	moveq	#SCROLLMARGIN,d1
	move.w	d2,MapY(a4)
	add.w	d3,MapYMod(a4)
	bpl	.9
	add.w	#BMAPH,MapYMod(a4)

.9:	move.w	d1,CursorY(a4)

.10:	rts


;---------------------------------------------------------------------------
print_pos:
; update position in the info display, when needed

	move.w	MapX(a4),d1
	add.w	CursorX(a4),d1
	addq.w	#8,d1
	asr.w	#4,d1
	cmp.w	LastCol(a4),d1
	beq	.1

	; write updated map column
	move.w	#INFOCOORDS_X1,d0
	move.w	d1,LastCol(a4)
	bsr	print3digits

.1:	move.w	MapY(a4),d1
	add.w	CursorY(a4),d1
	addq.w	#8,d1
	asr.w	#4,d1
	cmp.w	LastRow(a4),d1
	bne	.2
	rts

	; write updated map row
.2:	move.w	#INFOCOORDS_X2,d0
	move.w	d1,LastRow(a4)


;---------------------------------------------------------------------------
print3digits:
; Write a three-digit value at the given xpos into the info-bitmap.
; Note that the output will be written to byte-aligned positions only.
; d0 = xpos
; d1 = value

	; center the 6 pixels high font in the middle of the info display
	move.l	#InfoBitmap+((INFOH-6)>>1)*BPR*PLANES,a1
	lsr.w	#3,d0
	add.w	d0,a1

	; write first digit (hundreds)
	lea	DigitBits+6(a4),a0
	moveq	#0,d0
	move.w	d1,d0
	divu	#100,d0
	add.w	d0,d0
	move.w	d0,d1
	add.w	d0,d0
	add.w	d1,d0
	add.w	d0,a0
	move.b	-(a0),5*BPR*PLANES(a1)
	move.b	-(a0),4*BPR*PLANES(a1)
	move.b	-(a0),3*BPR*PLANES(a1)
	move.b	-(a0),2*BPR*PLANES(a1)
	move.b	-(a0),BPR*PLANES(a1)
	move.b	-(a0),(a1)+

	; write second digit (tens)
	lea	DigitBits+6(a4),a0
	clr.w	d0
	swap	d0
	divu	#10,d0
	add.w	d0,d0
	move.w	d0,d1
	add.w	d0,d0
	add.w	d1,d0
	add.w	d0,a0
	move.b	-(a0),5*BPR*PLANES(a1)
	move.b	-(a0),4*BPR*PLANES(a1)
	move.b	-(a0),3*BPR*PLANES(a1)
	move.b	-(a0),2*BPR*PLANES(a1)
	move.b	-(a0),BPR*PLANES(a1)
	move.b	-(a0),(a1)+

	; write last digit (ones)
	lea	DigitBits+6(a4),a0
	swap	d0
	add.w	d0,d0
	move.w	d0,d1
	add.w	d0,d0
	add.w	d1,d0
	add.w	d0,a0
	move.b	-(a0),5*BPR*PLANES(a1)
	move.b	-(a0),4*BPR*PLANES(a1)
	move.b	-(a0),3*BPR*PLANES(a1)
	move.b	-(a0),2*BPR*PLANES(a1)
	move.b	-(a0),BPR*PLANES(a1)
	move.b	-(a0),(a1)

	rts


;---------------------------------------------------------------------------
print_monstcnt:
; Refresh the monster counter in the info-display.

	move.w	#MONSTERCNT_X,d0
	move.w	MonsterCount(a4),d1
	bra	print3digits


;---------------------------------------------------------------------------
print_tilesel:
; Draw nine tiles into the info-display, where the middle tile is
; the actually selected one (SelTile/SelFgBlk).

	moveq	#0,d1
	tst.b	Plane(a4)
	bne	.1

	lea	Blocks(a4),a0
	move.b	SelTile(a4),d1
	bra	.2

.1:	lea	FgBlocks(a4),a0
	move.b	SelFgBlk(a4),d1

.2:	move.w	d1,d0
	subq.w	#4,d0		; start 4 tiles before selection
	add.w	d0,d0
	add.w	d0,d0
	add.w	d0,a0

	move.l	#InfoBitmap+TILESEL_X>>3,a1

	; preconfigure Blitter: copy D=A, AMOD=0, DMOD=BPR-2
	moveq	#-1,d0
	WAITBLIT
	move.l	d0,BLTAFWM(a6)
	move.l	#0<<16|BPR-2,BLTAMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)

	; blit the nine tiles
	moveq	#9-1,d0
.3:	WAITBLIT
	move.l	(a0)+,BLTAPT(a6)
	move.l	a1,BLTDPT(a6)
	move.w	#(16*PLANES)<<6|1,BLTSIZE(a6)
	addq.l	#2,a1
	dbf	d0,.3

	; print the number of the selected tile
	move.w	#TILESEL_X-4<<3,d0
	bra	print3digits


;---------------------------------------------------------------------------
	xdef	initgfx
initgfx:
; Fill both bitmaps with blocks, start display with the map's color palette.

	; make multiplication table for y-positions
	sub.l	a0,a0
	move.w	#BPR*PLANES,d0
	move.w	#BMAPH-1,d1
	lea	YOffTab(a4),a1
.1:	move.l	a0,(a1)+
	add.w	d0,a0
	dbf	d1,.1

	; make multiplication table for tile rows
	sub.l	a0,a0
	move.w	#BPR*PLANES*BLKH,d0
	moveq	#YBLOCKS-1,d1
	lea	RowOffTab(a4),a1
.2:	move.l	a0,(a1)+
	add.w	d0,a0
	dbf	d1,.2

	; initialize pointers to monster images
	lea	MonsterImgs,a0
	lea	MonsterLabels(a4),a1
	move.w	#2*BLKSIZE,d0	; includes mask
	moveq	#2*9-1,d1
.3:	move.l	a0,(a1)+
	add.w	d0,a0
	dbf	d1,.3

	; map position 0,0 is viewed at the top-left edge of our display
	clr.w	MapX(a4)
	clr.w	MapY(a4)

	move.l	View(a4),a0
	bsr	initdrawlist
	bsr	initbitmap
	move.l	View+4(a4),a0
	bsr	initdrawlist
	bsr	initbitmap

	lea	ColorTab(a4),a0
	bsr	startdisplay

	; set tile-selection sprite
	moveq	#TILESEL_X-16+4*BLKW,d0
	move.w	#DISPH+INFOGAP,d1
	moveq	#1,d2
	moveq	#16,d3
	bsr	set_sprite

	bsr	print_tilesel
	bsr	print_monstcnt

	bsr	hide_blockmarker

	; set cursor sprite to top-left edge
	clr.w	CursorX(a4)
	clr.w	CursorY(a4)


;---------------------------------------------------------------------------
move_cursor:
; Move sprite 0 to the coordinates from CursorX/CursorY.

	move.w	CursorX(a4),d0
	move.w	CursorY(a4),d1
	moveq	#0,d2
	moveq	#16,d3
	bra	set_sprite


;---------------------------------------------------------------------------
move_markers:
; Update position of block marker sprites, when enabled and currently visible.

	; Calculate visible coordinates for marker sprites.
	move.w	MapX(a4),d5
	move.w	d5,d6
	move.w	d6,d7
	sub.w	#16,d6
	add.w	#DISPW,d7
	swap	d5
	swap	d6
	swap	d7
	move.w	MapY(a4),d5
	move.w	d5,d6
	move.w	d6,d7
	sub.w	#16,d6
	add.w	#DISPH,d7

	; d5 = X | Y
	; d6 = minX | minY
	; d7 = maxX | maxY

	move.l	StrtCol(a4),d4	; StrtCol | StrtRow
	bmi	.3

	; top/left edge of block is set, show marker when visible
	lsl.l	#4,d4		; StrtX = StrtCol*16 | StrtY = StrtRow*16

	; StrtX visibility check
	moveq	#-16,d0
	swap	d4
	swap	d5
	swap	d6
	swap	d7
	cmp.w	d6,d4
	ble	.1
	cmp.w	d7,d4
	bge	.1

	; StrtX visible, calculate position on display
	move.w	d4,d0
	sub.w	d5,d0

	; StrtY visibility check
.1:	moveq	#-16,d1
	swap	d4
	swap	d5
	swap	d6
	swap	d7
	cmp.w	d6,d4
	ble	.2
	cmp.w	d7,d4
	bge	.2

	; StrtY visible, calculate position on display
	move.w	d4,d1
	sub.w	d5,d1

	; set top/left marker sprite
.2:	moveq	#2,d2
	moveq	#16,d3
	bsr	set_sprite

.3:	move.l	StopCol(a4),d4	; StopCol | StopRow
	bmi	.6

	; bottom/right edge of block is set, show marker when visible
	lsl.l	#4,d4		; StopX = StopCol*16 | StopY = StopRow*16

	; StopX visibility check
	moveq	#-16,d0
	swap	d4
	swap	d5
	swap	d6
	swap	d7
	cmp.w	d6,d4
	ble	.4
	cmp.w	d7,d4
	bge	.4

	; StopX visible, calculate position on display
	move.w	d4,d0
	sub.w	d5,d0

	; StopY visibility check
.4:	moveq	#-16,d1
	swap	d4
	swap	d5
	swap	d6
	swap	d7
	cmp.w	d6,d4
	ble	.5
	cmp.w	d7,d4
	bge	.5

	; StopY visible, calculate position on display
	move.w	d4,d1
	sub.w	d5,d1

	; set bottom/right marker sprite
.5:	moveq	#3,d2
	moveq	#16,d3
	bsr	set_sprite

.6:	rts


;---------------------------------------------------------------------------
initdrawlist:
; Initialize a View's drawlist. Set all nodes to row/col -1/-1.
; a0 = View
; a0 is preserved!

	move.l	a2,-(sp)

	lea	Vdrawlist(a0),a1
	lea	Vdrawnodes(a0),a2
	move.l	a1,Vlastdn(a0)
	move.l	a1,d0
	move.l	a2,(a1)+	; list head
	clr.l	(a1)		; list tail
	moveq	#NUM_DRAWNODES-1,d1

.1:	lea	sizeof_DrawNode(a2),a1
	move.l	a1,DNnext(a2)
	move.l	d0,DNprev(a2)
	move.l	#-1,DNcol(a2)
	move.l	a2,d0
	move.l	a1,a2
	dbf	d1,.1

	move.l	d0,a2		; last node
	lea	Vdrawlist+4(a0),a1
	move.l	a1,DNnext(a2)
	move.l	a2,Vdrawlist+8(a0)

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
initbitmap:
; Write map-blocks, starting at position 0,0 into the View's bitmap.
; a0 = View

	movem.l	d2-d4/a2-a3/a5,-(sp)
	move.l	a0,a5		; a5 View

	; remember visible map rows
	lea	Vvisrows+(YBLOCKS-1)*2(a5),a1
	moveq	#YBLOCKS-2,d0
.1:	move.w	d0,-(a1)
	dbf	d0,.1

	; no block to update
	moveq	#-1,d0
	move.l	d0,Vputcol(a5)

	clr.w	Vxpos(a5)
	clr.w	Vypos(a5)

	move.l	Vbitmap(a5),a0
	move.l	Map(a4),a1
	lea	Blocks(a4),a2

	; copy D=A, AMOD=0, DMOD=BPR-2
	moveq	#-1,d0
	WAITBLIT
	move.l	d0,BLTAFWM(a6)
	move.l	#0<<16|BPR-2,BLTAMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)

	; fill the bitmap with map blocks
	moveq	#YBLOCKS-2,d2

.2:	moveq	#XBLOCKS-2,d1

.3:	moveq	#0,d0
	move.b	(a1)+,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a2,d0.w),d0

	WAITBLIT
	move.l	d0,BLTAPT(a6)
	move.l	a0,BLTDPT(a6)
	move.w	#(16*PLANES)<<6|1,BLTSIZE(a6)

	addq.l	#2,a0
	dbf	d1,.3

	; next block row on bitmap
	lea	16*PLANES*BPR-(BPR-2)(a0),a0
	; next map row
	lea	MAPW-(XBLOCKS-1)(a1),a1
	dbf	d2,.2

	; make initial DrawNodes for foreground blocks
	move.l	FgMap(a4),a2
	lea	MapRowOffTab(a4),a3
	moveq	#YBLOCKS-3,d3
.4:	moveq	#XBLOCKS-3,d2
.5:	move.w	d3,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a3,d0.w),d4
	add.l	d2,d4		; d4 map offset
	tst.b	(a2,d4.l)
	beq	.6
	move.l	a5,a0
	bsr	makenewdrawnode
.6:	dbf	d2,.5
	dbf	d3,.4

	; add visible monster labels to the DrawList
	move.w	#-1,Vrowcol(a5)
	moveq	#YBLOCKS-2,d3
.7:	bsr	check_monster_row
	dbf	d3,.7

	movem.l	(sp)+,d2-d4/a2-a3/a5
	rts


;---------------------------------------------------------------------------
	xdef	loadMap
loadMap:
; Load a map file and extend it into our map buffers at MapData and FgMapData.
; File format:
; $0000: "MAP8"
; $0004: map-width
; $0006: map-height
; $0008: [background map] [foreground map] [monsters]
; a0 = file name
; -> d0/Z = error

	movem.l	d2-d4/d7/a2,-(sp)

	; open the map file, no problem when it doesn't exist
	moveq	#0,d0
	bsr	openFile
	move.l	d0,d7
	beq	.ok

	; read the first 8 bytes
	move.l	Map(a4),a2
	move.l	a2,a0
	moveq	#8,d1
	bsr	readFile
	bne	.err

	; must start with MAP8 ID, followed by width.w and height.w
	move.l	a2,a0
	cmp.l	#'MAP8',(a0)+
	bne	.err
	moveq	#0,d2
	move.w	(a0)+,d2	; d2 is map width, extended to 32bit
	beq	.err
	cmp.w	#MAPW,d2
	bhi	.err
	move.w	(a0),d3		; d3 is map height
	beq	.err
	cmp.w	#MAPH,d3
	bhi	.err

	; Now expand the map into our buffer.
	move.w	d3,d4
.nextrow:
	move.l	d7,d0
	move.l	d2,d1
	move.l	a2,a0
	bsr	readFile
	bne	.err

	add.w	#MAPW,a2	; pointer to start of next row
	subq.w	#1,d4
	bne	.nextrow

	; Expand the foreground map into our buffer
	move.l	FgMap(a4),a2
.nextfgrow:
	move.l	d7,d0
	move.l	d2,d1
	move.l	a2,a0
	bsr	readFile
	bne	.err

	add.w	#MAPW,a2	; pointer to start of next row
	subq.w	#1,d3
	bne	.nextfgrow

	; Read monster definitions to MonsterTab
	lea	MonsterTab(a4),a0
	move.l	d7,d0
	move.l	#NUM_MONSTERS*sizeof_Monster,d1
	bsr	readFile

	; count monsters
	clr.w	MonsterCount(a4)
	lea	MonsterTab(a4),a0
	moveq	#NUM_MONSTERS-1,d0
.mcount:
	tst.w	Mtype(a0)
	beq	.mnext
	addq.w	#1,MonsterCount(a4)
.mnext:
	lea	sizeof_Monster(a0),a0
	dbf	d0,.mcount

.ok:	moveq	#1,d4		; ok, no error
	SKIPW
.err:	moveq	#0,d4

	; close the file
	move.l	d7,d0
	beq	.exit
	bsr	closeFile

.exit:
	; calculate map row offset
	lea	MapRowOffTab(a4),a0
	moveq	#0,d0
	move.w	#MAPH-1,d1
	move.l	#MAPW,d2
.1:	move.l	d0,(a0)+
	add.l	d2,d0
	dbf	d1,.1

	move.l	d4,d0
	movem.l	(sp)+,d2-d4/d7/a2
	rts


;---------------------------------------------------------------------------
	xdef	loadTileGfx
loadTileGfx:
; Load block images used to build the map (AKA tiles). File format:
; $0000: color table with 32 RGB4 colors
; $0040: block types (0=empty, 1=unmasked, 2=masked)
; $0140: raw 5-planes interleaved 16x16 block images, empty blocks missing
; a0 = file name
; -> d0/Z = error

	movem.l	d2-d3/a2-a3,-(sp)

	moveq	#0,d0
	bsr	openFile
	move.l	d0,d2
	beq	.exit

	; read color table
	lea	ColorTab(a4),a0
	moveq	#NCOLORS*2,d1
	bsr	readFile
	beq	.1
	moveq	#0,d0
	bra	.exit

.1:	move.w	ColorTab(a4),DebugColor(a4)

	; read blocks and close file
	lea	BlockData,a2
	lea	Blocks(a4),a3
	move.w	#BLKSIZE,d3
	bsr	loadBlocks
.exit:
	movem.l	(sp)+,d2-d3/a2-a3
	rts


;---------------------------------------------------------------------------
	xdef	loadFgGfx
loadFgGfx:
; Load masked foreground block images. File format:
; $0000: number of animation phases
; $0100: animation speed in frames
; $0200: block types (0=empty, 1=unmasked, 2=masked)
; $0300: 5-planes interlv. 16x16 block images with mask, empty blocks missing
; a0 = file name
; -> d0/Z = error

	movem.l	d2-d3/a2-a3,-(sp)
	lea	-512(sp),sp

	moveq	#0,d0
	bsr	openFile
	move.l	d0,d2
	beq	.exit

	move.l	#256,d3

	; read number of animation phases per block
	move.l	sp,a0
	move.l	d3,d1
	bsr	readFile
	bne	.1

	; read animation speed per block
	lea	256(sp),a0
	move.l	d2,d0
	move.l	d3,d1
	bsr	readFile
	beq	.2
.1:	moveq	#0,d0
	bra	.exit

.2:	move.l	sp,a0
	bsr	makeFgAnimTab

	lea	FgBlockData,a2
	lea	FgBlocks(a4),a3
	move.w	#BLKSIZE*2,d3	; foreground tiles come with a mask
	bsr	loadBlocks
.exit:
	lea	512(sp),sp
	movem.l	(sp)+,d2-d3/a2-a3
	rts


;---------------------------------------------------------------------------
makeFgAnimTab:
; Enter animation status into the FgAnimTab table, for all blocks to animate.
; a0 = Table with animation phases per block (256 entries), followed by
;      a table with animation speeds (256 entries).

	moveq	#0,d1
	lea	FgAnimTab(a4),a1

.1:	move.b	(a0)+,d0	; next number of animation phases
	cmp.b	#1,d0
	bls	.2

	; create an entry for a block to animate (i.e. more than 1 phase)
	move.b	d1,(a1)+	; blockNo.
	move.b	256-1(a0),(a1)+	; frameCnt
	move.b	256-1(a0),(a1)+	; speed (max. frameCnt)
	move.b	d0,(a1)+	; nPhases

.2:	addq.b	#1,d1
	bne	.1

	clr.b	(a1)		; end of table
	rts


;---------------------------------------------------------------------------
loadBlocks:
; Load a graphics file containing up to 256 tile images, with or without
; mask. Calculate pointers to all tiles. Close file.
; d2 = handle
; d3.w = block size
; a2 = block data
; a3 = block pointers
; d0/Z = error

	movem.l	d3/a2,-(sp)
	lea	-256(sp),sp

	; read block types
	move.l	d2,d0
	move.l	sp,a0
	move.l	#256,d1
	bsr	readFile
	bne	.err

	; read all images
	move.l	d2,d0
	move.l	a2,a0
	moveq	#0,d1
	move.w	d3,d1
	lsl.l	#8,d1		; 256 * block size
	bsr	readFile

	; calculate block image pointers
	lea	-16(a3),a0
	move.l	sp,a1
	move.l	a2,d1		; 0 is empty block image
	move.l	d1,(a0)+
	move.l	d1,(a0)+
	move.l	d1,(a0)+
	move.l	d1,(a0)+
	move.w	#256-1,d0

.1:	move.b	(a1)+,d3
	bne	.2
	move.l	d1,(a0)+
	bra	.3
.2:	move.l	a2,(a0)+
	add.w	#BLKSIZE,a2
	subq.b	#1,d3
	beq	.3
	add.w	#BLKSIZE,a2	; includes mask
.3:	dbf	d0,.1

	move.l	d1,(a0)+
	move.l	d1,(a0)+
	move.l	d1,(a0)+
	move.l	d1,(a0)

	moveq	#1,d3		; ok
	SKIPW
.err:
	moveq	#0,d3		; error

	; close file
	move.l	d2,d0
	bsr	closeFile

	lea	256(sp),sp
	move.l	d3,d0
	movem.l	(sp)+,d3/a2
	rts


;---------------------------------------------------------------------------
	xdef	saveMap
saveMap:
; Determine used map dimensions and write a "MAP8" file.
; a0 = file name

	movem.l	d2-d3/d6-d7/a2,-(sp)
	move.l	Map(a4),a2

	; determine map extensions -> d6/d7
	moveq	#0,d6
	moveq	#0,d7
	move.l	a2,a1
	move.w	#MAPH-1,d1
	moveq	#0,d3
.1:	addq.w	#1,d3
	move.w	#MAPW-1,d0
	moveq	#0,d2
.2:	addq.w	#1,d2
	tst.b	(a1)+
	beq	.4
	cmp.w	d6,d2
	bls	.3
	move.w	d2,d6
.3:	cmp.w	d7,d3
	bls	.4
	move.w	d3,d7
.4:	dbf	d0,.2
	dbf	d1,.1

	; open file for writing, create file when it doesn't exist
	moveq	#1,d0
	bsr	openFile
	move.l	d0,d2
	beq	.exit

	; write MAP8 header
	move.w	d7,-(sp)
	move.w	d6,-(sp)
	move.l	#'MAP8',-(sp)
	moveq	#8,d1
	move.l	sp,a0
	bsr	writeFile
	addq.l	#8,sp
	bne	.err

	; write map data
	subq.w	#1,d7
	move.w	d7,d3
.5:	move.l	d2,d0
	move.l	d6,d1
	move.l	a2,a0
	bsr	writeFile
	bne	.err
	add.w	#MAPW,a2
	dbf	d3,.5

	; write foreground map data
	move.l	FgMap(a4),a2
.6:	move.l	d2,d0
	move.l	d6,d1
	move.l	a2,a0
	bsr	writeFile
	bne	.err
	add.w	#MAPW,a2
	dbf	d7,.6

	; write used monster slots
	lea	MonsterTab(a4),a2
	moveq	#NUM_MONSTERS-1,d3
.7:	tst.w	Mtype(a2)
	beq	.8
	move.l	d2,d0
	moveq	#sizeof_Monster,d1
	move.l	a2,a0
	bsr	writeFile
	bne	.err
.8:	addq.l	#sizeof_Monster,a2
	dbf	d3,.7

.err:
	move.l	d2,d0
	bsr	closeFile
.exit:
	movem.l	(sp)+,d2-d3/d6-d7/a2
	rts


;---------------------------------------------------------------------------
	xdef	process_keycode
process_keycode:
; Process new key code. Called from Level2 CIA-A interrupt.
; All registers must be restored on exit!
; d0 = key code
; C = 0:pressed 1:released

	movem.l	d0-d1/a0-a1,-(sp)
	bcc	.pressed

	; key released
	cmp.b	#$60,d0
	beq	.relshift
	cmp.b	#$61,d0
	bne	.exit
.relshift:
	clr.b	Shift(a4)
	bra	.exit

.pressed:
	; new key pressed
	cmp.b	#$45,d0		; ESC
	bne	.1
	move.b	#1,Quit(a4)
	bra	.exit

.1:	cmp.b	#$50,d0		; F1
	bne	.2
	clr.b	Plane(a4)
	bra	.printsel

.2:	cmp.b	#$51,d0		; F2
	bne	.4
	cmp.b	#1,Plane(a4)
	bne	.3
	eor.b	#1,BlinkFlag(a4)
	bra	.printsel
.3:	clr.b	BlinkFlag(a4)
	move.b	#1,Plane(a4)
	bra	.printsel

.4:	cmp.b	#$54,d0		; F5
	bne	.6
	move.l	StopCol(a4),d1
	bmi	.5
	cmp.w	LastRow(a4),d1
	blt	.exit
	swap	d1
	cmp.w	LastCol(a4),d1
	blt	.exit
.5:	move.l	LastCol(a4),StrtCol(a4)
	bra	.exit

.6:	cmp.b	#$55,d0		; F6
	bne	.8
	move.l	StrtCol(a4),d1
	bmi	.7
	cmp.w	LastRow(a4),d1
	bgt	.exit
	swap	d1
	cmp.w	LastCol(a4),d1
	bgt	.exit
.7:	move.l	LastCol(a4),StopCol(a4)
	bra	.exit

.8:	cmp.b	#$56,d0		; F7
	bne	.9
	tst.w	StrtCol(a4)
	bmi	.exit
	tst.w	StopCol(a4)
	bmi	.exit
	st	CopyFlag(a4)
	bra	.exit

.9:	cmp.b	#$57,d0		; F8
	bne	.10
	tst.w	StrtCol(a4)
	bmi	.exit
	tst.w	StopCol(a4)
	bmi	.exit
	st	FillFlag(a4)
	bra	.exit

.10:	cmp.b	#$59,d0		; F10
	bne	.11
	st	Quit(a4)
	bra	.exit

.11:	cmp.b	#$4f,d0		; cursor-left
	bne	.12
	moveq	#-1,d0
	bra	.seltile

.12:	cmp.b	#$4e,d0		; cursor-right
	bne	.13
	moveq	#1,d0
	bra	.seltile

.13:	cmp.b	#$4c,d0		; cursor-up
	bne	.14
	moveq	#-10,d0
	bra	.seltile

.14:	cmp.b	#$4d,d0		; cursor-down
	bne	.15
	moveq	#10,d0
	bra	.seltile

.15:	cmp.b	#$01,d0
	blo	.17
	cmp.b	#$09,d0		; Keys from '1' to '9'
	bhi	.17
	tst.b	Shift(a4)
	beq	.16
	neg.b	d0		; negative means facing right
.16:	move.b	d0,MonsterSet(a4)
	bra	.exit

.17:	cmp.b	#$0a,d0		; '0'
	bne	.18
	st	MonsterClear(a4)
	bra	.exit

.18:	cmp.b	#$60,d0
	beq	.19
	cmp.b	#$61,d0
	bne	.20
.19:	st	Shift(a4)	; Left or Right Shift pressed
	bra	.exit

.20:	cmp.b	#$22,d0		; 'D' debug used raster lines
	bne	.22
	move.w	DebugColor(a4),d0
	cmp.w	ColorTab(a4),d0
	beq	.21
	move.w	ColorTab(a4),DebugColor(a4)
	bra	.exit
.21:	add.w	#$888,d0
	move.w	d0,DebugColor(a4)
	bra	.exit

.22:	cmp.b	#$40,d0		; space
	bne	.exit
	tst.b	Plane(a4)
	bne	.23
	clr.b	SelTile(a4)
	bra	.printsel
.23:	clr.b	SelFgBlk(a4)
	bra	.printsel

.seltile:
	tst.b	Plane(a4)
	bne	.selfgblk
	add.b	d0,SelTile(a4)
	bra	.printsel
.selfgblk:
	add.b	d0,SelFgBlk(a4)
.printsel:
	st	UpdateInfo(a4)

.exit:
	movem.l	(sp)+,d0-d1/a0-a1
	rts



	bss


	; The map buffer has a fixed width of MAPW*MAPH, but will be
	; shrinked to its used size when writing it back to disk.
MapData:
	ds.b	MAPW*MAPH
FgMapData:
	ds.b	MAPW*MAPH



	section	__MERGED,data


	; pointer to map buffer
Map:
	dc.l	MapData
FgMap:
	dc.l	FgMapData

	; last column/row shown in the info-display
LastCol:
	dc.w	-1
LastRow:
	dc.w	-1

	; Digits '0'..'9' in 8x6 pixels, one plane
DigitBits:
	dc.b	$38,$44,$44,$44,$44,$38
	dc.b	$10,$30,$10,$10,$10,$38
	dc.b	$38,$44,$04,$18,$20,$7c
	dc.b	$38,$44,$04,$18,$44,$38
	dc.b	$08,$18,$28,$48,$7c,$08
	dc.b	$7c,$40,$78,$04,$44,$38
	dc.b	$1c,$20,$78,$44,$44,$38
	dc.b	$7c,$04,$08,$10,$20,$40
	dc.b	$38,$44,$38,$44,$44,$38
	dc.b	$38,$44,$44,$3c,$08,$70



	section	__MERGED,bss


	; Block pointers, including 4 blocks before and after for
	; viewing them in the tile-selection display.
	ds.l	4
Blocks:
	ds.l	256+4

	; Foreground block pointers, including 4 blocks before and after for
	; viewing them in the tile-selection display.
	ds.l	4
FgBlocks:
	ds.l	256+4

	; List of blocks to animate, terminated by a 0-entry.
	; Format: 0:blockNo. 1:frameCnt 2:speed(max-frameCnt) 3:nPhases
FgAnimTab:
	ds.b	4*256

	; Table of current animation phases for foreground blocks.
FgAnimPhase:
	ds.b	256

	; Pointers to monster labels. There are 9 labels for left and
	; 9 labels for right initial direction.
MonsterLabels:
	ds.l	2*9

	; Monster position information
MonsterTab:
	ds.b	NUM_MONSTERS*sizeof_Monster

	; RGB4 color table
ColorTab:
	ds.w	NCOLORS

	; modified COLOR00 for showing used raster-lines
DebugColor:
	ds.w	1

	; bitmap y-pos multiplication table
YOffTab:
	ds.l	BMAPH

	; bitmap row multiplication table
RowOffTab:
	ds.l	YBLOCKS

	; map row multiplication table
MapRowOffTab:
	ds.l	MAPH

	; cursor sprite position, relative to visible display window
CursorX:
	ds.w	1
CursorY:
	ds.w	1

	; top/left edge map position
MapX:
	ds.w	1
MapY:
	ds.w	1
MapYMod:			; map y-pos modulo display height
	ds.w	1

	; 16-bit frame counter
FrameCounter:
	ds.w	1

	; start and end coordinates of a block to copy/fill
StrtCol:
	ds.w	1
StrtRow:
	ds.w	1
StopCol:
	ds.w	1
StopRow:
	ds.w	1

	; Number of monsters in this map
MonsterCount:
	ds.w	1

	; Need to update the info display, when true
UpdateInfo:
	ds.b	1

	; currently selected tile number
SelTile:
	ds.b	1
SelFgBlk:
	ds.b	1

	; Plane to edit. 0 = background tiles, 1 = foreground blocks
Plane:
	ds.b	1

	; Make foreground blocks and drawing blink
BlinkFlag:
	ds.b	1

	; quit-code: 0 = running, 1 = quit without saving, -1 = quit and save
	xdef	Quit
Quit:
	ds.b	1

	; Shift-key status
Shift:
	ds.b	1

	; Key pressed to set or clear a monster.
MonsterSet:
	ds.b	1
MonsterClear:
	ds.b	1

	; Copy block from StrtCol/Row to StopCol/Row to LastCol/Row when set
CopyFlag:
	ds.b	1

	; Fill block from StrtCol/Row to StopCol/Row with SelTile when set
FillFlag:
	ds.b	1

	; joystick button status
Button:
	ds.b	1



	section	chipmem,data,chip


	; 16x16 images with mask for monster labels 1-9.
	; Two sets: With left-arrow and right-arrow below the numbers.
MonsterImgs:
	incbin	"gfx/numbers.bin"



	section	chipmem,bss,chip


	; 16x16 map block images (interleaved)
BlockData:
	ds.b	256*BLKSIZE

	; 16x16 foreground blocks images (interleaved with mask)
FgBlockData:
	ds.b	256*BLKSIZE*2

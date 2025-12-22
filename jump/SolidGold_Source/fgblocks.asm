*
* Functions to draw and animate foreground map blocks
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* init_fgblocks()
* load_fgblocks(d0.w=fileID, a0=tiletypes, a1=animphases)
* animate_fgblocks()
* $drawlist_foregd(a5=View)
* a0=imgptr = getFgTypeImage(d0.b=type)
* countFgItems(a0=stats)
*
* FgBlocks
*

	include	"custom.i"
	include	"display.i"
	include	"view.i"
	include	"map.i"
	include	"tiles.i"
	include	"levelstats.i"
	include	"macros.i"


; from memory.asm
	xref	alloc_chipmem

; from trackdisk.asm
	xref	td_loadcr_chip

; from main.asm
	xref	loaderr

; from game.asm
	xref	FgBlockTypes

; from tiles.asm
	xref	makeBlkTable

; from map.asm
	xref	FgMap
	xref	MapWidth
	xref	MapHeight



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	init_fgblocks
init_fgblocks:

	rts


;---------------------------------------------------------------------------
	xdef	load_fgblocks
load_fgblocks:
; d0 = tile file id
; a0 = table of 256 tile types (empty, unmasked, masked)
; a1 = table with 256 animation lengths and speeds

	move.l	a2,-(sp)
	move.l	a0,-(sp)
	move.l	a1,-(sp)

	; load foreground image data into Chip RAM
	bsr	td_loadcr_chip
	beq	loaderr
	move.l	d0,a2

	; initialize FgAnimTab
	move.l	(sp)+,a0
	bsr	makeFgAnimTab

	; initialize block image pointer table
	move.l	(sp)+,a0
	lea	FgBlocks(a4),a1
	move.w	#256,d0
	move.w	#BLKSIZE,d1
	bsr	makeBlkTable

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
makeFgAnimTab:
; Enter animation status into the FgAnimTab table, for all blocks to animate.
; a0 = Table with animation phases per block (256 entries), followed by
;      a table with animation speeds (256 entries).

	moveq	#0,d1
	lea	FgAnimTab(a4),a1
	ifd	DEBUG
	movem.l	a0-a1,$7ff18
	endif

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

	; reset animation phase for all blocks
	lea	FgAnimPhase(a4),a0
	move.w	#256-1,d0
.3:	clr.b	(a0)+
	dbf	d0,.3
	rts


;---------------------------------------------------------------------------
	xdef	animate_fgblocks
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
	xdef	drawlist_foregd
drawlist_foregd:
; Update all animated foreground blocks from the DrawList.
; a5 = View
; Registers, except a4 - a6, are not preserved!

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
	beq	.del_drawnode
	add.b	(a1,d0.w),d0	; add the block's current animation phase
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

.2:	move.l	d2,a3
.3:	move.l	DNnext(a3),d2
	beq	.4
	tst.w	DNcol(a3)
	bpl	.1

.4:	rts

.del_drawnode:
	; Foreground block is 0. Disable this DrawNode and move it to
	; the end of the list.
	move.l	a1,d3
	moveq	#-1,d0
	move.l	d0,DNcol(a3)	; disabled

	; remove this node
	move.l	a3,a0
	REMOVE	a0,a1

	cmp.l	Vlastdn(a5),a3
	bne	.addtail
	move.l	a0,Vlastdn(a5)	; new last DrawNode

.addtail:
	; add it to list's tail
	lea	Vdrawlist(a5),a0
	ADDTAIL	a0,a3,d0

	move.l	d3,a1
	bra	.2


;---------------------------------------------------------------------------
	xdef	getFgTypeImage
getFgTypeImage:
; Look for the first matching type in the FgBlockTypes table and return
; the corresponding image pointer.
; d0.b = type
; -> a0 = image pointer

	move.l	FgBlockTypes(a4),a0
	moveq	#0,d1

.1:	cmp.b	(a0)+,d0
	beq	.2
	addq.b	#1,d1
	bne	.1
	ifd	DEBUG
	trap	#9			; type not found
	endif

.2:	lea	FgBlocks(a4),a0
	lsl.w	#2,d1
	move.l	(a0,d1.w),a0
	rts


;---------------------------------------------------------------------------
	xdef	countFgItems
countFgItems:
; Scan the whole foreground map for collectable items, like gold coins,
; emeralds and extra lives and remember their count in a statistics
; structure.
; a0 = Statistics Record

	movem.l	a2-a3,-(sp)

	move.l	FgMap(a4),a1
	move.l	FgBlockTypes(a4),a2
	move.w	MapWidth(a4),d0
	mulu.w	MapHeight(a4),d0
	lea	(a1,d0.l),a3		; end of map
	moveq	#0,d0

	; scan the whole maps for items and count them
.1:	move.b	(a1)+,d0
	move.b	(a2,d0.w),d0		; foreground block type

	ifd	DEBUG
	cmp.b	#FB_EXTRALIFE,d0
	bls	.2
	trap	#8			; illegal type in map
	endif

.2:	lsr.b	#1,d0
	move.b	.statoffs(pc,d0.w),d0
	bmi	.3
	addq.w	#1,(a0,d0.w)		; count it
.3:	cmp.l	a3,a1
	bne	.1

	movem.l	(sp)+,a2-a3
	rts

.statoffs:
	dc.b	-1
	dc.b	-1			; FB_CHECKPOINT
	dc.b	Stat_Gold		; FB_COIN
	dc.b	Stat_Rubys		; FB_RUBY
	dc.b	Stat_Emeralds		; FB_EMERALD
	dc.b	Stat_Diamonds		; FB_DIAMOND
	dc.b	Stat_ExtraLives		; FB_EXTRALIFE



	section	__MERGED,bss


	; Table with all foreground block pointers.
	xdef	FgBlocks
FgBlocks:
	ds.l	256

	; List of blocks to animate, terminated by a 0-entry.
	; Format: 0:blockNo. 1:frameCnt 2:speed(max-frameCnt) 3:nPhases
FgAnimTab:
	ds.b	4*256

	; Table of current animation phases for foreground blocks.
FgAnimPhase:
	ds.b	256

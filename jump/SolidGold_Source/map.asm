*
* Map routines
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* load_map(d0.w=fileID)
*
* MapRowOffTab
* Map
* FgMap
* MapWidth
* MapHeight
* ScrWidth
* ScrHeight
*

	include	"display.i"
	include	"map.i"


; from trackdisk.asm
	xref	td_loadcr

; from main.asm
	xref	ovflowerr
	xref	loaderr

; from monster.asm
	xref	init_monsters



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	load_map
load_map:
; d0 = map file id

	movem.l	d2-d3/a2-a3,-(sp)
	lea	MapBuffer,a3

	; load the map to the end of the buffer
	lea	MapBufferEnd-MAXDSKMAPSIZE,a2
	move.l	a2,a0
	bsr	td_loadcr
	beq	loaderr
	cmp.l	#MAXDSKMAPSIZE,d0
	bhi	ovflowerr

	; read header, width and height
	cmp.l	#'MAP8',(a2)+
	bne	loaderr
	move.w	(a2)+,d2		; d2 width
	move.w	d2,MapWidth(a4)
	move.w	(a2)+,d3
	move.w	d3,MapHeight(a4)
	mulu	d2,d3			; d3 size of map (MapWidth * MapHeight)

	; initialize monsters
	move.l	a2,a0
	add.l	d3,a0
	add.l	d3,a0			; pointer to first monster record
	subq.l	#8,d0			; subtract header size
	sub.l	d3,d0			; and both map sizes
	sub.l	d3,d0
	divu	#sizeof_MD,d0		; number of monsters on this map
	cmp.w	#MAXMONSTERS,d0
	bhi	ovflowerr
	bsr	init_monsters

	; There are MAPTOPEXTRA rows on top of the map, which mirror the
	; blocks in the first map row.
	moveq	#MAPTOPEXTRA-1,d1
.1:	move.w	d2,d0
	subq.w	#1,d0
.2:	move.b	(a2)+,(a3)+
	dbf	d0,.2
	sub.w	d2,a2			; read first row again
	dbf	d1,.1

	; here starts the background map
	move.l	a3,Map(a4)
	move.l	d3,d0
.3:	move.b	(a2)+,(a3)+
	subq.l	#1,d0
	bne	.3

	; The extra rows at the bottom of the background map and at the
	; top of the foreground map are shared (MAPMIDEXTRA) as both
	; contain void blocks.
	moveq	#MAPMIDEXTRA-1,d1
.4:	move.w	d2,d0
	subq.w	#1,d0
.5:	clr.b	(a3)+
	dbf	d0,.5
	dbf	d1,.4

	; here starts the foreground map
	move.l	a3,FgMap(a4)
	move.l	d3,d0
.6:	move.b	(a2)+,(a3)+
	subq.l	#1,d0
	bne	.6

	; MAPBOTEXTRA rows with void blocks at the bottom of the map
	moveq	#MAPBOTEXTRA-1,d1
.7:	move.w	d2,d0
	subq.w	#1,d0
.8:	clr.b	(a3)+
	dbf	d0,.8
	dbf	d1,.7

	; Create a table of row offsets for background and foreground maps,
	; using the current map width and height.
	lea	MapRowOffTab-4*MAPTOPEXTRA(a4),a1
	moveq	#-MAPTOPEXTRA,d2
	move.w	MapWidth(a4),d0
	ext.l	d0
	muls	d0,d2
	moveq	#MAPTOPEXTRA+MAPBOTEXTRA-1,d1
	add.w	MapHeight(a4),d1
.9:	move.l	d2,(a1)+
	add.l	d0,d2
	dbf	d1,.9

	; calculate map width and height in pixels
	move.w	MapWidth(a4),d0
	lsl.w	#4,d0
	move.w	d0,ScrWidth(a4)
	move.w	MapHeight(a4),d0
	lsl.w	#4,d0
	move.w	d0,ScrHeight(a4)

	movem.l	(sp)+,d2-d3/a2-a3
	rts



	section	__MERGED,bss


	; map row multiplication table
	xdef	MapRowOffTab
	ds.l	MAPTOPEXTRA
MapRowOffTab:
	ds.l	MAXMAPH+MAPBOTEXTRA

	; pointer to map buffers
	xdef	Map
Map:
	ds.l	1
	xdef	FgMap
FgMap:
	ds.l	1

	; map dimensions in blocks and pixels
	xdef	MapWidth
MapWidth:
	ds.w	1
	xdef	MapHeight
MapHeight:
	ds.w	1
	xdef	ScrHeight
ScrHeight:				; ScrHeight before ScrWidth!
	ds.w	1
	xdef	ScrWidth
ScrWidth:
	ds.w	1



	bss


	; The map buffer has a maximum size of MAXMAPW*MAXMAPH for
	; the background tiles and the same amount for the foreground
	; tiles. The actual loaded map can have any size below these
	; dimensions.
	; We use MAPTOPEXTRA extra rows on top of the map to allow
	; objects (e.g. the hero jumping) to leave it (TOPMAPSPACE).
	; MAPBOTEXTRA rows are used after the map to allow objects
	; falling out of it and to temporarily store the monster records,
	; which come with the map (BOTMAPSPACE).
	; The extra rows between the background and foreground maps
	; are shared (MIDMAPSPACE).
	; There is an extra space for monster records at the end of the
	; buffer, which is only used during load_map.
MapBuffer:
	ds.b	2*MAXMAPW*MAXMAPH+TOPMAPSPACE+MIDMAPSPACE+BOTMAPSPACE
	ds.b	MAXMONSTERS*sizeof_MD
MapBufferEnd:

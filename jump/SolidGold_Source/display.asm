*
* Display functions
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* initdisplay()
* display_off()
* make_scrollviews()
* make_stdviews(a0=clisthook)
* a0=clistptr = write_clist_colors(a0=clistptr, a1=colortab)
* a0=clistptr, d2=flag = write_clist_wait(a0=clistptr, d0=vpos, d2=flag)
* waitvertb()
* copy_colors(a0=srccolors, a1=dstcolors)
* startdisplay(a0=RGB4palette)
* startclist()
* a0=backgdView = switchView()
* set_sprite(a0=sprPtr, d0=x.w, d1=y.w, d2=height.w)
* set_asprite(a0=sprPtrOdd, a1=sprPtrEven, d0=x.w, d1=y.w, d2=height.w)
* init_sprite(d0=sprNo.w, a0=sprDispList)
*
* View
*

	include	"custom.i"
	include	"display.i"
	include	"view.i"
	include	"map.i"
	include	"macros.i"


; from memory.asm
	xref	alloc_chipmem

; from blit.asm
	xref	bltimg



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	initdisplay
initdisplay:
; Allocate chip memory for Bitmaps and Copper lists.

	; allocate copper lists
	move.l	#sizeof_Clist,d2
	move.l	d2,d0
	bsr	alloc_chipmem
	move.l	d0,Clist1(a4)
	move.l	d2,d0
	bsr	alloc_chipmem
	move.l	d0,Clist2(a4)

	; Allocate bitmaps. The bitmap is several blocks larger than
	; the visible size to enable soft-scrolling.
	; Additionally we need an extra buffer using the height of the
	; highest BOB, so we don't have to do any clipping.
	; Layout in memory:
	; +-------------------------------------------------+
	; | MAXOBJHEIGHT lines of top clipping buffer       |
	; |-------------------------------------------------|
	; | PrefetchWord |                                  |
	; |---------------    Scrolling Bitmap 1            |
	; |                                                 |
	; |-------------------------------------------------|
	; | Extra buffer for horiz. scrolling of MAXMAPW    |
	; |-------------------------------------------------|
	; | MAXOBJHEIGHT lines of top/bottom clipping buffer|
	; |-------------------------------------------------|
	; | PrefetchWord |                                  |
	; |---------------    Scrolling Bitmap 2            |
	; |                                                 |
	; |-------------------------------------------------|
	; | Extra buffer for horiz. scrolling of MAXMAPW    |
	; |-------------------------------------------------|
	; | MAXOBJHEIGHT lines of bottom clipping buffer    |
	; +-------------------------------------------------+
	move.l	#2*(2+BMAPH*BPR*PLANES+(MAXMAPW*16)>>3)+3*MAXOBJHEIGHT*BPR*PLANES,d0
	bsr	alloc_chipmem
	add.l	#MAXOBJHEIGHT*BPR*PLANES+2,d0
	move.l	d0,Bitmap1(a4)
	add.l	#(BMAPH*BPR*PLANES+(MAXMAPW*16)>>3)+MAXOBJHEIGHT*BPR*PLANES+2,d0
	move.l	d0,Bitmap2(a4)

	; allocate a void sprite image to preset unused sprite channels
	moveq	#4,d0
	bsr	alloc_chipmem
	move.l	d0,VoidSpr(a4)
	move.l	d0,a0
	clr.l	(a0)
	rts


;---------------------------------------------------------------------------
	xdef	display_off
display_off:
; Disable Bitplane, Copper, Sprite DMA. Turn display off. Clear sprites.

	bsr	waitvertb
	move.w	#$01a0,DMACON(a6)
	move.w	#$0200,BPLCON0(a6)
	bsr	black_palette


;---------------------------------------------------------------------------
clear_sprites:
; Disarm sprite channels. Preset all sprites with void images.

	moveq	#0,d0
	moveq	#15,d1
	lea	SPR0POS(a6),a0
.1:	move.l	d0,(a0)+
	dbf	d1,.1

	lea	Sprites(a4),a0
	move.l	VoidSpr(a4),a1
	clr.l	(a1)
	moveq	#7,d0
.2:	move.l	a1,(a0)+
	dbf	d0,.2

	rts


;---------------------------------------------------------------------------
clear_view:
; clear the View structure
; a1 = View
; d0 = ID.w (0 or 1)
; a1 is preserved!

	move.w	#sizeof_View-1,d1
	move.l	a1,a0
.1	clr.b	(a0)+
	dbf	d1,.1
	move.w	d0,Vid(a1)
	rts


;---------------------------------------------------------------------------
	xdef	make_scrollviews
make_scrollviews:
; Initialize the main display registers.
; PLANES bitplanes, interleaved. Sprites before playfields.
; Set DISPWxDISPH display window and fetch an additional word at the
; beginning of each line for fine scrolling.

	; Sprites appear on top of all playfields.
	move.w	#$24,BPLCON2(a6)

	; Fetch an additional word before the normal DFETCHSTART to allow
	; horizontal playfield scrolling.
	move.w	#DFETCHSTART-(16/2),DDFSTRT(a6)
	move.w	#DFETCHSTOP,DDFSTOP(a6)

	; set the display window location and dimensions
	move.w	#(VSTART&$ff)<<8|(HSTART&$ff),DIWSTRT(a6)
	move.w	#(VEND&$ff)<<8|((HSTART+DISPW)&$ff),DIWSTOP(a6)

	; The bitplanes are interleaved, so we have to skip the words from
	; PLANES-1 rows, and the non-dispayed extra words from the current
	; row.
	move.w	#(PLANES-1)*BPR+(BPR-DISPW/8-2),d1
	move.w	d1,BPL1MOD(a6)
	move.w	d1,BPL2MOD(a6)

	; Reset the Views and their copper lists to an initial state with
	; scroll position at 0,0.

	lea	View1(a4),a1
	moveq	#0,d0
	bsr	clear_view
	move.l	Clist1(a4),a0
	move.l	Bitmap1(a4),d0
	bsr	init_scrollview_clist

	lea	View2(a4),a1
	moveq	#1,d0
	bsr	clear_view
	move.l	Clist2(a4),a0
	move.l	Bitmap2(a4),d0


;---------------------------------------------------------------------------
init_scrollview_clist:
; Write initial copper list. Reset bitmap pointers to the top-left edge
; and set the split below the visible display.
; a1 = View
; a0 = copper list
; d0 = bitmap

	movem.l	d2/a2,-(sp)
	move.l	a1,a2

	; reset scroll coordinates
	clr.w	Vxpos(a2)
	clr.w	Vypos(a2)

	; set copper list and bitmap pointer
	move.l	a0,Vclist(a2)
	move.l	d0,Vbitmap(a2)

	; Cl_sprites: write sprite pointers
	lea	Sprites(a4),a1
	bsr	write_clist_spriteptrs

	; Cl_illcolors: write two colors to illuminate during the game
	move.l	#(COLOR00+2*ILLUMCOLOR1)<<16,(a0)+
	move.l	#(COLOR00+2*ILLUMCOLOR2)<<16,(a0)+

	; Cl_scroll: set scrolling delay for the scroll display
	move.l	#BPLCON1<<16,(a0)+

	; Cl_bpltop: write bitplane pointers for top of scroll display
	move.l	Vbitmap(a2),d0
	subq.l	#2,d0		; invisible extra word for scrolling (DDFSTRT)
	bsr	write_clist_planeptrs

	IFND	COPPERBACK
	; Cl_waitsplit: write WAIT instructions for split location
	COPWAIT	$ff,$de,(a0)+
	COPWAIT	VEND,$01,(a0)+

	; Cl_bplsplit: write bitplane pointers for the split
	move.l	Vbitmap(a2),d0
	subq.l	#2,d0		; invisible extra word for scrolling (DDFSTRT)
	bsr	write_clist_planeptrs

	; end of copper list
	moveq	#-2,d0
	move.l	d0,(a0)
	ENDIF	; !COPPERBACK

	movem.l	(sp)+,d2/a2
	rts


;---------------------------------------------------------------------------
	xdef	make_stdviews
make_stdviews:
; Initialize the main display registers for a standard DISPW*DISPH screen
; without scrolling. PLANES bitplanes, interleaved. Sprites before playfields.
; a0 = hook function for additional copper list instructions, NULL=unused

	move.l	a0,-(sp)

	; No scrolling. Sprites appear on top of all playfields.
	move.w	#0,BPLCON1(a6)
	move.w	#$24,BPLCON2(a6)

	; Set normal data-fetch start and stop.
	move.w	#DFETCHSTART,DDFSTRT(a6)
	move.w	#DFETCHSTOP,DDFSTOP(a6)

	; set the display window location and dimensions
	move.w	#(VSTART&$ff)<<8|(HSTART&$ff),DIWSTRT(a6)
	move.w	#(VEND&$ff)<<8|((HSTART+DISPW)&$ff),DIWSTOP(a6)

	; The bitplanes are interleaved, so we have to skip the words from
	; PLANES-1 rows, and the non-dispayed extra words from the current
	; row.
	move.w	#(PLANES-1)*BPR+(BPR-DISPW/8),d1
	move.w	d1,BPL1MOD(a6)
	move.w	d1,BPL2MOD(a6)

	; Reset the Views and their copper lists to an initial state.

	lea	View1(a4),a1
	moveq	#0,d0
	bsr	clear_view
	move.l	Clist1(a4),a0
	move.l	Bitmap1(a4),d0
	move.l	(sp),d1
	bsr	init_stdview_clist

	lea	View2(a4),a1
	moveq	#1,d0
	bsr	clear_view
	move.l	Clist2(a4),a0
	move.l	Bitmap2(a4),d0
	move.l	(sp)+,d1


;---------------------------------------------------------------------------
init_stdview_clist:
; Write standard copper list. Reset bitmap pointers to the top-left edge
; and set the split below the visible display.
; a1 = View
; a0 = copper list
; d0 = bitmap
; d1 = hook function for copper list additions

	movem.l	a2/a5,-(sp)
	move.l	a1,a5
	move.l	d1,a2

	; reset scroll coordinates
	clr.w	Vxpos(a5)
	clr.w	Vypos(a5)

	; set copper list and bitmap pointer
	move.l	a0,Vclist(a5)
	move.l	d0,Vbitmap(a5)

	; There is no split in the stdview display, but Vtop/Vsplit are
	; needed by the BOB system.
	move.l	d0,Vtop(a5)
	move.l	d0,Vsplit(a5)

	; write sprite pointers
	lea	Sprites(a4),a1
	bsr	write_clist_spriteptrs

	; write bitplane pointers
	move.l	Vbitmap(a5),d0
	bsr	write_clist_planeptrs

	; call hook function for additional copper instructions
	move.l	a2,d0
	beq	.1
	jsr	(a2)

	; end of copper list
.1:	moveq	#-2,d0
	move.l	d0,(a0)

	movem.l	(sp)+,a2/a5
	rts


;---------------------------------------------------------------------------
write_clist_spriteptrs:
; Write pointers to sprite descriptors from a list for all 8 sprites.
; d2 gets destroyed!
; a0 = copperlist
; a1 = sprite list
; -> a0 = updated copperlist ptr

	moveq	#8-1,d1
	move.w	#SPR0PTH,d2
.1:	move.l	(a1)+,d0
	move.w	d2,(a0)+
	swap	d0
	move.w	d0,(a0)+
	addq.w	#2,d2
	move.w	d2,(a0)+
	swap	d0
	move.w	d0,(a0)+
	addq.w	#2,d2
	dbf	d1,.1
	rts


;---------------------------------------------------------------------------
write_clist_planeptrs:
; Write interleaved bitplane pointers for all planes into the copperlist.
; d2 gets destroyed!
; a0 = copperlist
; d0 = bitmap
; -> a0 = updated copperlist ptr

	moveq	#PLANES-1,d1
	move.w	#BPL1PTH,d2
	move.w	#BPR,a1
.1:	move.w	d2,(a0)+
	swap	d0
	move.w	d0,(a0)+
	addq.w	#2,d2
	move.w	d2,(a0)+
	swap	d0
	move.w	d0,(a0)+
	addq.w	#2,d2
	add.l	a1,d0
	dbf	d1,.1
	rts


;---------------------------------------------------------------------------
	xdef	write_clist_colors
write_clist_colors:
; Write copper instructions to load all colors.
; a0 = copper list pointer
; a1 = color table
; -> a0 = updated copper list pointer

	move.w	#COLOR00,d0
	moveq	#NCOLORS-1,d1
.1:	move.w	d0,(a0)+
	addq.w	#2,d0
	move.w	(a1)+,(a0)+
	dbf	d1,.1
	rts


;---------------------------------------------------------------------------
	xdef	write_clist_wait
write_clist_wait:
; Write Copper WAIT instructions for a specific vpos (0 .. VEND).
; a0 = copper list pointer
; d0 = VPOS to wait for
; d2 = true, when vpos for last WAIT already passed $100.
; -> a0 = updated copper list pointer
; -> d2 = true, when vpos passed $100.

	cmp.w	#$100,d0
	blo	.1
	bset	#0,d2
	bne	.1
	COPWAIT	$ff,$de,(a0)+
.1:	lsl.w	#8,d0
	addq.w	#1,d0
	move.w	d0,(a0)+
	move.w	#$fffe,(a0)+
	rts


;---------------------------------------------------------------------------
black_palette:
; Set all colors to black to hide flicker during display-setup operations.

	moveq	#0,d0
	moveq	#NCOLORS-1,d1
	lea	COLOR00(a6),a0
.1:	move.w	d0,(a0)+
	dbf	d1,.1


;---------------------------------------------------------------------------
	xdef	waitvertb
waitvertb:
; Wait until raster beam enters vertical blank.
; Preserves all registers.

	movem.l	d0-d2,-(sp)
	move.l	#$0001ff00,d2
	move.l	VPOSR(a6),d0
	and.l	d2,d0

.1:	move.l	d0,d1
	move.l	VPOSR(a6),d0
	and.l	d2,d0
	cmp.l	d1,d0
	bhs	.1
	
	movem.l	(sp)+,d0-d2
	rts


;---------------------------------------------------------------------------
loadpalette:
; Load a complete color palette into the COLORxx registers.
; a0 = palette in RGB4 format

	bsr	waitvertb

	lea	COLOR00(a6),a1


;---------------------------------------------------------------------------
	xdef	copy_colors
copy_colors:
; a0 = src colors
; a1 = dst colors

	moveq	#NCOLORS-1,d0
.1:	move.w	(a0)+,(a1)+
	dbf	d0,.1
	rts


;---------------------------------------------------------------------------
	xdef	startdisplay
startdisplay:
; Start copperlist of first View and load the colors.
; a0 = palette in RGB4 format

	bsr	loadpalette


;---------------------------------------------------------------------------
	xdef	startclist
startclist:
; Start copperlist of first View.

	; Work around the COPJMPx strobe bug, which may erroneously load
	; the COPxLC into a BLTxPT register when the blitter is using
	; DMA slots at the same time.
	WAITBLIT

	; set CurrentView to first View
	lea	View(a4),a1
	move.l	a1,CurrentView(a4)
	move.l	(a1),a1

	; start the View's copper list
	ifd	DEBUG
	move.l	Vclist(a1),CurrentClist(a4)
	endif
	move.l	Vclist(a1),COP1LC(a6)

	; enable bitplane, copper and sprite DMA
	move.w	#$83a0,DMACON(a6)
	tst.w	COPJMP1(a6)

	; wait for next VERTB and enable bitplanes
	bsr	waitvertb
	move.w	#PLANES<<12|$200,BPLCON0(a6)
	rts


;---------------------------------------------------------------------------
	xdef	switchView
switchView:
; Set the CurrentView to the background View and load its copper list
; for the next frame.
; -> a0 = background View

	bchg	#2,CurrentView+3(a4)
 	move.l	CurrentView(a4),a0
	move.l	(a0),a0
	ifd	DEBUG
	move.l	Vclist(a0),CurrentClist(a4)
	endif
	move.l	Vclist(a0),COP1LC(a6)
	rts


;---------------------------------------------------------------------------
	xdef	copyView
copyView:
; Copy the bitmap of the CurrentView to the background View.
; Note that the CurrentView is the background View, directly after switchView.

	movem.l	d2-d3/a5,-(sp)

	move.l	CurrentView(a4),d0
	move.l	d0,a0
	move.l	(a0),a0			; a0 CurrentView
	eor.w	#4,d0
	move.l	d0,a5
	move.l	(a5),a5			; a5 destination View

	; copy the whole bitmap
	move.l	Vbitmap(a0),a0
	moveq	#0,d0
	moveq	#0,d1
	move.w	#BMAPW/16,d2
	move.w	#BMAPH,d3
	bsr	bltimg

	movem.l	(sp)+,d2-d3/a5
	rts


;---------------------------------------------------------------------------
	xdef	set_sprite
set_sprite:
; Set x/y coordinates for a sprite. Coordinates are given as offset to
; the scroll display window.
; a0 = pointer to sprite control words
; d0.w = x
; d1.w = y
; d2.w = sprite height
; a0/a1 are preserved, d2 is trashed!

	; adjust coordinates
	add.w	#HSTART-1,d0
	add.w	#VSTART,d1

	; calculate position bits for SPRPOS and SPRCTL
	add.w	d1,d2
	lsl.w	#7,d2
	lsl.w	#8,d1
	roxl.w	#1,d2
	roxl.b	#1,d2
	lsr.w	#1,d0
	roxl.b	#1,d2
	move.b	d0,d1

	; write SPRPOS and SPRCTL words
	move.w	d1,(a0)
	move.w	d2,2(a0)
	rts


;---------------------------------------------------------------------------
	xdef	set_asprite
set_asprite:
; Set x/y coordinates for an attached sprite. Coordinates are given as
; offset to the scroll display window. Also set the ATTACHED-bit.
; a0 = pointer to sprite control words (even sprite)
; a1 = pointer to sprite control words (odd sprite)
; d0.w = x
; d1.w = y
; d2.w = sprite height
; a0/a1 are preserved, d2 is trashed!

	; adjust coordinates
	add.w	#HSTART-1,d0
	add.w	#VSTART,d1

	; calculate position bits for SPRPOS and SPRCTL
	add.w	d1,d2
	lsl.w	#7,d2
	lsl.w	#8,d1
	roxl.w	#1,d2
	roxl.b	#1,d2
	lsr.w	#1,d0
	roxl.b	#1,d2
	move.b	d0,d1

	; write SPRPOS and SPRCTL words
	move.w	d1,(a0)
	move.w	d2,2(a0)
	or.w	#$0080,d2		; attached sprite
	move.w	d1,(a1)
	move.w	d2,2(a1)
	rts


;---------------------------------------------------------------------------
	xdef	init_sprite
init_sprite:
; Set sprite display list for given sprite channel in both copper lists.
; d0.w = sprite number
; a0 = sprite display list
; a0 is preserved!

	; remember sprite display list
	add.w	d0,d0
	add.w	d0,d0
	lea	Sprites(a4),a1
	move.l	a0,(a1,d0.w)

	; update sprite pointers in both copper lists
	move.l	a0,d1
	add.w	d0,d0
	swap	d1
	move.l	Clist1(a4),a1
	lea	Cl_sprites+2(a1,d0.w),a1
	move.w	d1,(a1)
	swap	d1
	move.w	d1,4(a1)
	swap	d1
	move.l	Clist2(a4),a1
	lea	Cl_sprites+2(a1,d0.w),a1
	move.w	d1,(a1)
	swap	d1
	move.w	d1,4(a1)
	rts



	section	__MERGED,data


	; Double buffered View
	cnop	0,8
	xdef	View
View:
	dc.l	View1,View2



	section	__MERGED,bss


	; Double buffered View
View1:
	ds.b	sizeof_View
View2:
	ds.b	sizeof_View

	; Since View is at an address with the three lowest bits being zero
	; we can switch the View by flipping bit 2 in the CurrentView pointer.
CurrentView:
	ds.l	1

	; Copper list pointers (double buffered)
Clist1:
	ds.l	1
Clist2:
	ds.l	1

	ifd	DEBUG
	xdef	CurrentClist
CurrentClist:
	ds.l	1
	endif

	; Bitmap pointers (double buffered)
Bitmap1:
	ds.l	1
Bitmap2:
	ds.l	1

	; Sprite pointers
Sprites:
	ds.l	8

VoidSpr:
	ds.l	1

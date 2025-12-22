*
* Display functions
*
* initdisplay()
* waitvertb()
* startdisplay(a0=RGB4palette)
* a0=backgdView = switchView()
* set_sprite(d0=x.w, d1=y.w, d2=sprNo.w, d3.w=height.w)
*
* View
* InfoBitmap
*

	include	"custom.i"
	include "map.i"
	include	"display.i"
	include	"view.i"
	include	"macros.i"



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	initdisplay
initdisplay:
; Initialize the main display registers.
; PLANES bitplanes, interleaved. Sprites before playfields.
; Set DISPWxDISPH display window and fetch an additional word at the
; beginning of each line for fine scrolling.

	bsr	black_palette

	; Define number of bitplanes and playfield priorities.
	; Sprites appear before all playfields.
	move.w	#PLANES<<12|$200,BPLCON0(a6)
	move.w	#$24,BPLCON2(a6)

	; Fetch an additional word before the normal DFETCHSTART to allow
	; horizontal playfield scrolling.
	move.w	#DFETCHSTART-(16/2),DDFSTRT(a6)
	move.w	#DFETCHSTOP,DDFSTOP(a6)

	; set the display window location and dimensions
	move.w	#(VSTART&$ff)<<8|(HSTART&$ff),DIWSTRT(a6)
	move.w	#((VEND)&$ff)<<8|((HSTART+DISPW)&$ff),DIWSTOP(a6)

	; The bitplanes are interleaved, so we have to skip the words from
	; PLANES-1 rows, and the non-dispayed extra words from the current
	; row.
	move.w	#(PLANES-1)*BPR+(BPR-DISPW/8-2),d1
	move.w	d1,BPL1MOD(a6)
	move.w	d1,BPL2MOD(a6)


;---------------------------------------------------------------------------
reset_views:
; Reset the Views and their copper lists to the initial state with
; scroll position at 0,0.

	lea	Clist1,a0
	move.l	#Bitmap1,d0
	lea	View1(a4),a1
	bsr	init_view
	lea	Clist2,a0
	move.l	#Bitmap2,d0
	lea	View2(a4),a1


;---------------------------------------------------------------------------
init_view:
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

	; Cl_scroll: set scrolling delay for the scroll display
	move.l	#BPLCON1<<16,(a0)+

	; Cl_bpltop: write bitplane pointers for top of scroll display
	move.l	Vbitmap(a2),d0
	bsr	write_clist_planeptrs

	; Cl_waitsplit: write WAIT instructions for split location
	COPWAIT	$ff,$de,(a0)+
	COPWAIT	VSCROLLEND,$01,(a0)+

	; Cl_bplsplit: write bitplane pointers for the split
	move.l	Vbitmap(a2),d0
	bsr	write_clist_planeptrs

	; Cl_waitend: write WAIT instructions for end of scroll display
	COPWAIT	$00,$de,(a0)+
	COPWAIT	VSCROLLEND,$01,(a0)+

	; turn display off for INFOGAP lines, no scroll delay
	move.l	#BPLCON0<<16|$200,(a0)+
	move.l	#BPLCON1<<16,(a0)+

	; write bitplane pointers for the info display
	move.l	#InfoBitmap+2,d0
	bsr	write_clist_planeptrs

	; wait for start of info display and turn it on
	COPWAIT	VSCROLLEND+INFOGAP,$01,(a0)+
	move.l	#BPLCON0<<16|PLANES<<12|$200,(a0)+

	; end of copper list
	moveq	#-2,d0
	move.l	d0,(a0)

	movem.l	(sp)+,d2/a2
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

	subq.l	#2,d0		; invisible extra word for scrolling (DDFSTRT)

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
black_palette:
; Set all colors to black to hide flicker during display-init operations.

	moveq	#0,d0
	moveq	#NCOLORS-1,d1
	lea	COLOR00(a6),a0
.1:	move.w	d0,(a0)+
	dbf	d1,.1


;---------------------------------------------------------------------------
	xdef	waitvertb
waitvertb:
; Wait until raster beam reaches vertical blank.
; Saves all registers.

	movem.l	d0-d1,-(sp)
	moveq	#$0020,d0
	move.w	d0,INTREQ(a6)

.1:	move.w	INTREQR(a6),d1
	and.w	d0,d1
	beq	.1

	move.w	d0,INTREQ(a6)
	movem.l	(sp)+,d0-d1
	rts


;---------------------------------------------------------------------------
loadpalette:
; Load a complete color palette into the COLORxx registers.
; a0 = palette in RGB4 format

	bsr	waitvertb

	lea	COLOR00(a6),a1
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

	; set CurrentView to first View
	lea	View(a4),a1
	move.l	a1,CurrentView(a4)
	move.l	(a1),a1

	; start the View's copper list
	move.l	Vclist(a1),COP1LC(a6)
	tst.w	COPJMP1(a6)

	; enable bitplane, copper, blitter and sprite DMA
	move.w	#$83e0,DMACON(a6)

	; wait for next VERTB to make sure our copper list is running
	bra	waitvertb


;---------------------------------------------------------------------------
	xdef	switchView
switchView:
; Set the CurrentView to the background View and load its copper list
; for the next frame.
; -> a0 = background View

	bchg	#2,CurrentView+3(a4)
 	move.l	CurrentView(a4),a0
	move.l	(a0),a0
	move.l	Vclist(a0),COP1LC(a6)
	rts


;---------------------------------------------------------------------------
	xdef	set_sprite
set_sprite:
; Set x/y coordinates for a sprite. Coordinates are given as offset to
; the scroll display window.
; d0.w = x
; d1.w = y
; d2.w = sprite number (0-7)
; d3.w = sprite height

	add.w	#HSTART-1,d0
	add.w	#VSTART,d1

	add.w	d1,d3
	lsl.w	#7,d3
	lsl.w	#8,d1
	roxl.w	#1,d3
	roxl.b	#1,d3
	lsr.w	#1,d0
	roxl.b	#1,d3
	move.b	d0,d1

	add.w	d2,d2
	add.w	d2,d2
	lea	Sprites(a4),a0
	move.l	(a0,d2.w),a1
	move.w	d1,(a1)+
	move.w	d3,(a1)
	rts



	section	__MERGED,data


	; Double buffered View
	cnop	0,8
	xdef	View
View:
	dc.l	View1,View2

	; Sprite pointers
Sprites:
	dc.l	CursorSpr,SelectSpr,TopLftSpr,BotRgtSpr
	dc.l	EmptySpr,EmptySpr,EmptySpr,EmptySpr



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



	section	chipmem,data,chip


	; Sprite images
	cnop	0,4
CursorSpr:
	dc.w	0,0
	dc.w	%1010101010101010,%0101010101010101
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0101010101010101,%1010101010101010
	dc.w	0,0
SelectSpr:
	dc.w	0,0
	dc.w	%1010101010101010,%0101010101010101
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0000000000000001,%1000000000000000
	dc.w	%1000000000000000,%0000000000000001
	dc.w	%0101010101010101,%1010101010101010
	dc.w	0,0
TopLftSpr:
	dc.w	0,0
	dc.w	%1010101000000000,%0101010100000000
	dc.w	%1010101000000000,%0101010100000000
	dc.w	%1000000000000000,%0100000000000000
	dc.w	%1000000000000000,%0100000000000000
	dc.w	%1000000000000000,%0100000000000000
	dc.w	%1000000000000000,%0100000000000000
	dc.w	%1000000000000000,%0100000000000000
	dc.w	%1000000000000000,%0100000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	0,0
BotRgtSpr:
	dc.w	0,0
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000000,%0000000000000000
	dc.w	%0000000000000010,%0000000000000001
	dc.w	%0000000000000010,%0000000000000001
	dc.w	%0000000000000010,%0000000000000001
	dc.w	%0000000000000010,%0000000000000001
	dc.w	%0000000000000010,%0000000000000001
	dc.w	%0000000000000010,%0000000000000001
	dc.w	%0000000010101010,%0000000001010101
	dc.w	%0000000010101010,%0000000001010101
EmptySpr:
	dc.w	0,0



	section	chipmem,bss,chip


	; Memory for bitmaps. Includes a line buffer for horizontal
	; scrolling, which has the width of the map. And a word-buffer
	; preceding the bitmap, to allow blitting into column -1 and to
	; account for the fetched extra word at DDFSTRT.
	even
	ds.w	1
Bitmap1:
	ds.b	BPR*BMAPH*PLANES+(MAPW*BLKW)>>3

	ds.w	1
Bitmap2:
	ds.b	BPR*BMAPH*PLANES+(MAPW*BLKW)>>3

	; Info bitmap, which shows the selected block and coordinates
	xdef	InfoBitmap
	even
InfoBitmap:
	ds.b	BPR*INFOH*PLANES

	; copper lists
	even
Clist1:
	ds.b	sizeof_Clist
Clist2:
	ds.b	sizeof_Clist

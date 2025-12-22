*
* Font related functions. Loading and drawing.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* load_gamefont()
* gfont8_spriteprint(a0=evenSprPos, a1=oddSprPos, d0.b=asciiChar)
* load_menufonts()
* load_smallfont()
* mfont8_center(a0=string, d1=ypos.w, a5=View)
* mfont8_print(a0=string, d0=xpos.w, d1=ypos.w, a5=View)
* mfont16_print(a0=string, d0=xpos.w, d1=ypos.w, a5=View)
*
* Font8Colors
*

	include	"custom.i"
	include	"display.i"
	include	"view.i"
	include	"font.i"
	include	"files.i"
	include	"macros.i"


; from memory.asm
	xref	alloc_chipmem

; from trackdisk.asm
	xref	td_loadcr_chip

; from main.asm
	xref	loaderr

; from blit.asm
	xref	YOffTab



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	load_gamefont
load_gamefont:
; Allocate memory and load in-game fonts.

	; 8x8, 4 planes font, using colors 16-31, suitable for sprites.
	moveq	#FIL_GAMEFONT8,d0
	bsr	td_loadcr_chip
	move.l	d0,GameFont8(a4)
	beq	loaderr
	rts


;---------------------------------------------------------------------------
	xdef	gfont8_spriteprint
gfont8_spriteprint:
; Print a character from the 16-color GameFont8 into two attached sprites.
; a0 = even attached sprite position
; a1 = odd attached sprite position
; d0.b = character in ASCII

	move.l	a2,-(sp)
	move.l	GameFont8(a4),a2

	sub.b	#' ',d0
	ext.w	d0
	lsl.w	#5,d0			; offset to GameFont8
	add.w	d0,a2

	moveq	#7,d1
.1:	move.b	(a2)+,(a0)
	move.b	(a2)+,2(a0)
	move.b	(a2)+,(a1)
	move.b	(a2)+,2(a1)
	addq.l	#4,a0
	addq.l	#4,a1
	dbf	d1,.1

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
	xdef	load_menufonts
load_menufonts:
; Allocate memory and load menu fonts.

	; 16x20, 5 planes font, masked
	moveq	#FIL_MFONT16,d0
	bsr	td_loadcr_chip
	beq	loaderr

	; make character pointer table
	move.l	d0,a0
	lea	MenuFont16Tab(a4),a1
	moveq	#MENUFONT16CHARS-1,d0
.1:	move.l	a0,(a1)+
	add.w	#MENUFONT16W>>3*MENUFONT16H*PLANES*2,a0
	dbf	d0,.1


;---------------------------------------------------------------------------
	xdef	load_smallfont
load_smallfont:
; Allocate memory and load 8px intro/menu font.

	; 8x8, 5 planes font, all characters side by side in one row
	moveq	#FIL_MFONT8,d0
	bsr	td_loadcr_chip
	move.l	d0,MenuFont8(a4)
	beq	loaderr

	clr.w	Font8Colors(a4)		; make sure COLOR00 of font is black
	rts


;---------------------------------------------------------------------------
	xdef	mfont8_center
mfont8_center:
; Print a horizontally centered string using masked characters from
; the 8px menu font.
; a0 = string
; d1.w = ypos
; a5 = View

	; determine string length to calculate the centered xpos
	move.l	a0,a1
	move.l	a1,d0
.1:	tst.b	(a1)+
	bne	.1
	sub.l	a1,d0
	not.w	d0

	; xpos = (DISPW - 8 * strlen) / 2
	lsl.w	#3,d0
	neg.w	d0
	add.w	#DISPW,d0
	asr.w	#1,d0


;---------------------------------------------------------------------------
	xdef	mfont8_print
mfont8_print:
; Print a string using masked characters from the 8px menu font.
; a0 = string
; d0.w = xpos
; d1.w = ypos
; a5 = View

	movem.l	d2-d4/a2-a3/a5,-(sp)

	move.w	d0,d3			; d3 xpos
	move.l	a0,a3			; a3 string

	; add ypos to bitmap pointer
	lea	YOffTab(a4),a0
	add.w	d1,d1
	add.w	d1,d1
	move.l	(a0,d1.w),d4
	add.l	Vbitmap(a5),d4		; d4 bitmap pointer (including ypos)

	move.l	MenuFont8(a4),a5	; a5 font bitmap

	; preset modulos: AMOD/BMOD = fontwidth-4 and CMOD/DMOD = BPR-4
	move.l	#(BPR-4)<<16|MENUFONT8W>>3-4,d0
	WAITBLIT
	move.l	d0,BLTCMOD(a6)
	swap	d0
	move.l	d0,BLTAMOD(a6)
	bra	.5

.1:	sub.b	#' ',d0			; first character in font is ' '
	beq	.4

	; Depending on whether this is an odd or even character in the
	; font we need the appropriate masking and adjust the xpos.
	lsr.b	#1,d0
	bcs	.2

	; even character
	move.l	#$ff000000,d2
	moveq	#0,d1
	bra	.3

	; odd character, subtract 8 from xpos to adjust
.2:	move.l	#$00ff0000,d2
	moveq	#-8,d1

	; get start address of character in font
.3:	add.w	d0,d0
	lea	(a5,d0.w),a0
	lea	MENUFONT8SIZE(a0),a1	; font mask

	; calculate destination word on screen for next character: a2
	move.l	d4,a2
	add.w	d3,d1
	moveq	#-$10,d0
	and.w	d1,d0
	asr.w	#3,d0
	add.w	d0,a2

	; xpos & 15 is used as shift-value for the blitter
	moveq	#15,d0
	and.w	d1,d0
	ror.w	#4,d0			; ASH and BSH in bit 15-12 (BLTCONx)

	; blit the character
	WAITBLIT
	move.l	d2,BLTAFWM(a6)
	move.w	d0,BLTCON1(a6)
	or.w	#$0fca,d0		; Use A,B,C,D  D=AB+/AC
	move.w	d0,BLTCON0(a6)
	move.l	a2,BLTCPT(a6)
	movem.l	a0-a2,BLTBPT(a6)
	move.w	#(MENUFONT8H*PLANES)<<6|2,BLTSIZE(a6)

	; next character from string
.4:	addq.w	#8,d3
.5:	moveq	#0,d0
	move.b	(a3)+,d0
	bne	.1

	movem.l	(sp)+,d2-d4/a2-a3/a5
	rts


;---------------------------------------------------------------------------
	xdef	mfont16_print
mfont16_print:
; Print a string using masked characters from the 16px menu font.
; a0 = string
; d0.w = xpos
; d1.w = ypos
; a5 = View

	movem.l	d2/a2-a3/a5,-(sp)
	move.l	a0,a3
	move.w	d0,d2			; d2 xpos

	; translate start pos to a character before the bitmap's destination
	move.l	Vbitmap(a5),a1
	moveq	#-$10,d0
	and.w	d2,d0
	asr.w	#3,d0
	lea	-MENUFONT16W>>3(a1,d0.w),a2
	lea	YOffTab(a4),a0
	add.w	d1,d1
	add.w	d1,d1
	add.l	(a0,d1.w),a2		; a2 destination bitmap

	; xpos & 15 is used as shift-value for the blitter
	and.w	#15,d2
	ror.w	#4,d2			; ASH and BSH in bit 15-12 (BLTCONx)

	lea	MenuFont16Tab(a4),a5

	; Initialize constant blitter registers:
	; AMOD and BMOD = -2 for the src image/mask, because we have to
	; read an additional word to allow shifting.
	; CMOD and DMOD = BPR-4 modulo to the next line (bitplane).
	; The FWM is $ffff, but the LWM $0000 to ignore the extra word.
	moveq	#-1,d0
	clr.w	d0
	move.l	#(BPR-4)<<16|-2&$ffff,d1

	WAITBLIT
	move.l	d0,BLTAFWM(a6)
	move.l	d1,BLTCMOD(a6)
	swap	d1
	move.l	d1,BLTAMOD(a6)
	move.w	d2,BLTCON1(a6)
	or.w	#$0fca,d2		; Use A,B,C,D  D=AB+/AC
	move.w	d2,BLTCON0(a6)

	move.w	#(MENUFONT16H*PLANES)<<6|(MENUFONT16W+16)>>4,d1
	moveq	#' ',d2			; d2 first char in table
	bra	.2

.1:	addq.w	#MENUFONT16W>>3,a2	; move to next pos on screen
	sub.b	d2,d0
	beq	.2			; skip blanks
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a5,d0.w),a0		; character image to draw
	lea	MENUFONT16SIZE(a0),a1	; and its mask

	; blit the character
	WAITBLIT
	move.l	a2,BLTCPT(a6)
	movem.l	a0-a2,BLTBPT(a6)
	move.w	d1,BLTSIZE(a6)

	; next character
.2:	moveq	#0,d0
	move.b	(a3)+,d0
	bne	.1

	movem.l	(sp)+,d2/a2-a3/a5
	rts



	section	__MERGED,data


	; Font8 color table, 32xRGB4
	xdef	Font8Colors
Font8Colors:
	incbin	"gfx/menufont8.cmap"



	section	__MERGED,bss


	; 8x8x4 font, each character has 32 bytes
GameFont8:
	ds.l	1

	; 8x8x5 font, all characters in one row
MenuFont8:
	ds.l	1

	; 16x20x5 font table with pointers to 64 masked characters
MenuFont16Tab:
	ds.l	MENUFONT16CHARS

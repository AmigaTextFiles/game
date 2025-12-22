*
* Blitter copy and clear functions.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* make_yoffsets()
* clear_display(a5=View)
* bltclear(d0=xpos.w, d1=ypos.w, d2=width.w, d3=height.w, a5=View)
* bltimg(d0=xpos.w, d1=ypos.w, d2=wordwidth.w, d3=height.w, a0=image,
*        a5=View)
* bltcopy(d0=xpos.w, d1=ypos.w, d2=wordwidth.w, d3=lines.w, a0=image,
*         a5=View)
*
* YOffTab
*

	include	"custom.i"
	include	"display.i"
	include	"view.i"
	include	"macros.i"

; maximum image height for the Blitter must be a multiple of PLANES
MAXBLTHEIGHT	equ	1024/PLANES
MAXBLTLINES	equ	PLANES*MAXBLTHEIGHT



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	make_yoffsets
make_yoffsets:
; Make ypos offset table for an interleaved BPR-width bitmap.

	move.w	#-MAXOBJHEIGHT*BPR*PLANES,a0
	lea	YOffTab-4*MAXOBJHEIGHT(a4),a1
	move.w	#BMAPH+MAXOBJHEIGHT-1,d0
.1:	move.l	a0,(a1)+
	add.w	#BPR*PLANES,a0
	dbf	d0,.1
	rts


;---------------------------------------------------------------------------
	xdef	clear_display
clear_display:
; a5 = View
; Clears the View's visible bitmap from 0,0 to DISPW-1,DISPH-1.
; Destroys d2 and d3!

	moveq	#0,d0
	moveq	#0,d1
	move.w	#DISPW,d2
	move.w	#DISPH*PLANES,d3


;---------------------------------------------------------------------------
	xdef	bltclear
bltclear:
; Clear a bitmap region up to 1024x2048.
; d0.w = xpos
; d1.w = ypos
; d2.w = width in pixels
; d3.w = height in lines (multiplied by PLANES for interleaved bitmaps)
; a5 = View

	cmp.w	#MAXBLTLINES,d3
	bls	.bltclear

	; region is higher than MAXBLTLINES lines, then clear in two steps
	movem.w	d0-d1,-(sp)
	add.w	#MAXBLTHEIGHT,d1
	sub.w	#MAXBLTLINES,d3
	bsr	.bltclear		; the smaller region first
	movem.w	(sp)+,d0-d1
	move.w	#MAXBLTLINES,d3

.bltclear:
	movem.l	d2-d4,-(sp)
	move.l	Vbitmap(a5),a0
	add.w	d0,d2
	subq.w	#1,d2			; d2 xpos+width-1
	lsl.w	#6,d3			; d3 height for BLTSIZE

	; add ypos to bitmap pointer
	lea	YOffTab(a4),a1
	add.w	d1,d1
	add.w	d1,d1
	add.l	(a1,d1.w),a0

	; calculate width in words and make BLTSIZE
	move.w	d0,d1
	asr.w	#4,d1			; start word
	move.w	d2,d4
	asr.w	#4,d4			; end word
	sub.w	d1,d4
	addq.w	#1,d4			; width in words
	and.w	#$3f,d4
	or.w	d4,d3			; d3 final BLTSIZE

	; add xpos to bitmap pointer
	add.w	d1,d1
	add.w	d1,a0			; a0 bitmap pointer

	; make BLTCMOD/BLTDMOD
	swap	d3
	move.w	#BPR,d3
	add.w	d4,d4
	sub.w	d4,d3			; d3 BLTSIZE | BLTCMOD/BLTDMOD

	; make BLTAFWM/LWM
	moveq	#15,d1
	and.w	d1,d0
	add.w	d0,d0
	move.w	.fwmasks(pc,d0.w),d4
	swap	d4
	and.w	d1,d2
	add.w	d2,d2
	move.w	.lwmasks(pc,d2.w),d4

	; preset BLTCON0, BLTCON1, BLTADAT
	move.l	#$030a0000,d2		; use CD, D=/AC, ASH=0, BSH=0
	moveq	#-1,d0

	; clear masked region
	WAITBLIT
	move.l	d2,BLTCON0(a6)
	move.l	d4,BLTAFWM(a6)
	move.w	d0,BLTADAT(a6)
	move.w	d3,BLTCMOD(a6)
	move.w	d3,BLTDMOD(a6)
	swap	d3
	move.l	a0,BLTCPT(a6)
	move.l	a0,BLTDPT(a6)
	move.w	d3,BLTSIZE(a6)

	movem.l	(sp)+,d2-d4
	rts

.fwmasks:
	dc.w	$ffff,$7fff,$3fff,$1fff,$0fff,$07ff,$03ff,$01ff
	dc.w	$00ff,$007f,$003f,$001f,$000f,$0007,$0003,$0001
.lwmasks:
	dc.w	$8000,$c000,$e000,$f000,$f800,$fc00,$fe00,$ff00
	dc.w	$ff80,$ffc0,$ffe0,$fff0,$fff8,$fffc,$fffe,$ffff


;---------------------------------------------------------------------------
	xdef	bltimg
bltimg:
; Uses bltcopy to copy a word-aligned image with PLANES interleaved
; bitplanes to a bitmap position. Copy the image in two parts, when it
; is too high (more than 200 lines) for a single blit.
; This function is for large graphics only! Use bltcopy otherwise!
; d0.w = xpos
; d1.w = ypos
; d2.w = width in words
; d3.w = height
; a0 = image pointer
; a5 = View

	move.l	d4,-(sp)
	move.w	#200,d4			; maximum height
	cmp.w	d4,d3
	bls	.1

	; picture is too high, blit it in two parts
	sub.w	d4,d3
	movem.w	d0-d3,-(sp)
	move.l	a0,-(sp)
	move.w	d4,d3
	mulu	#PLANES,d3
	bsr	bltcopy

	; set up parameters for blitting the second part
	move.l	(sp)+,a0
	movem.w	(sp)+,d0-d3
	add.w	d4,d1
	move.w	d2,d4
	add.w	d4,d4
	mulu	#200*PLANES,d4
	add.l	d4,a0			; new image pointer

.1:	mulu	#PLANES,d3
	move.l	(sp)+,d4


;---------------------------------------------------------------------------
	xdef	bltcopy
bltcopy:
; Copy a word-aligned image to a bitmap position.
; Doesn't check whether height is greater than 1024!
; d0.w = xpos
; d1.w = ypos
; d2.w = width in words
; d3.w = height in lines (multiplied by PLANES for interleaved bitmaps)
; a0 = image pointer
; a5 = View

	movem.l	d2-d3,-(sp)

	lsl.w	#6,d3
	addq.w	#1,d2			; extra word for shifting
	or.w	d2,d3
	swap	d3
	move.w	d2,d3
	add.w	d3,d3			; d3 BLTSIZE | width in bytes

	; add ypos to bitmap pointer
	lea	YOffTab(a4),a1
	add.w	d1,d1
	add.w	d1,d1
	move.l	(a1,d1.w),a1
	add.l	Vbitmap(a5),a1

	; make BLTCON0, BLTCON1
	moveq	#15,d1
	and.w	d0,d1
	ror.w	#4,d1			; ASH, BSH
	move.w	d1,d2
	or.w	#$07ca,d2		; use BCD, D=AB+/AC
	swap	d2
	move.w	d1,d2			; d2 = BLTCON0 | BLTCON1

	; add xpos to bitmap pointer
	asr.w	#4,d0
	add.w	d0,d0
	add.w	d0,a1			; a1 bitmap pointer

	; BLTBMOD is -2, because we read an additional word for shifting.
	; BLTCMOD and BLTDMOD are BPR - (width in bytes)
	moveq	#BPR,d1
	sub.w	d3,d1
	swap	d1
	subq.w	#2,d1			; d1 BLTCMOD | BLTBMOD

	moveq	#-1,d0
	swap	d3			; d3 BLTSIZE

	; copy image
	WAITBLIT
	move.l	d2,BLTCON0(a6)
	move.w	d0,BLTADAT(a6)
	clr.w	d0
	move.l	d0,BLTAFWM(a6)		; BLTAFWM=$ffff, BLTALWM=$0000
	move.l	d1,BLTCMOD(a6)
	swap	d1
	move.w	d1,BLTDMOD(a6)
	move.l	a0,BLTBPT(a6)
	move.l	a1,BLTCPT(a6)
	move.l	a1,BLTDPT(a6)
	move.w	d3,BLTSIZE(a6)

	movem.l	(sp)+,d2-d3
	rts



	section	__MERGED,bss


	; bitmap y-pos multiplication table
	xdef	YOffTab
	ds.l	MAXOBJHEIGHT
YOffTab:
	ds.l	BMAPH

**************************************************************
*
* hline.asm -- Draws horizontal lines
*
*-------------------------------------------------------------
* Authors:  Casper Gripenberg  (casper@alpha.hut.fi)
*           Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)  
*
* void HorizontalLine (register __a0 PLANEPTR bpl,
*	                     register __d2 int x,
*	                     register __d1 int y,
*	                     register __d3 int length,
*	                     register __d4 int onoff)
*
*

	XDEF	_HorizontalLine
	XREF	_pixelbyterow		; row-offsets, given in LONG
	

	SECTION	TEXT,CODE

_HorizontalLine

	movem.l	d1-d4/a1,-(sp)

	tst.l	d1			; For some odd reason, negative numbers appears
	blt	.word_end		; in d1 while initing...This should fix this.	

	lea	_pixelbyterow(a4),a1	; Much faster than mulu
	add.l	(a1,d1.w*4),a0

	cmp.w	#15,d3			; Size < 16, do special case
	ble	Less

	move.l	d2,d0
	lsr.w	#4,d0
	lsl.w	#1,d0
	add.l	d0,a0		      	; Number of bytes to the right

	lsl.w	#3,d0
	sub.w	d0,d2			; Number of bits to the right

	tst.w	d4
	beq	.word_clear		; Check if we want to clear

	* Set bits

	lea	Firstword(a4),a1	; Set first bits (initial word)
	moveq	#16,d4
	sub.w	d2,d4
	move.w	(a1,d2.w*2),d0
	sub.w	d4,d3			; Decrease number of bits
	or.w	d0,(a0)+

.word_setloop
	cmp.w	#16,d3
	blt	.word_setlast
	move.w	#$ffff,(a0)+		; Don't really need or, just bang 'em in.
	sub	#16,d3
	bra	.word_setloop

.word_setlast
	lea	Lastword(a4),a1		; Set last bits
	move.w	(a1,d3.w*2),d0
	or.w	d0,(a0)
.word_end
	movem.l	(sp)+,a1/d1-d4
	rts

	* Do (basically) the same procedure as setting when clearing bits

.word_clear
	lea	Lastword(a4),a1		; Clear first bits (initial word)
	moveq	#16,d4
	sub.w	d2,d4
	move.w	(a1,d2.w*2),d0
	sub.w	d4,d3			; Decrease number of bits
	and.w	d0,(a0)+

.word_clrloop
	cmp.w	#16,d3
	blt	.word_clrlast
	clr.w	(a0)+
	sub	#16,d3
	bra	.word_clrloop

.word_clrlast
	lea	Firstword(a4),a1	; Clear last bits
	move.w	(a1,d3.w*2),d0
	and.w	d0,(a0)
	movem.l	(sp)+,a1/d1-d4
	rts

*
*	Do the same with length less than 16
*

Less	move.l	d2,d0
	lsr.w	#4,d0
	lsl.w	#1,d0
	add.l	d0,a0		      	; Number of bytes to the right

	lsl.w	#3,d0
	moveq	#32,d1	
	sub.w	d0,d2			; Number of bits to the right
	move.w	#$ffff,d0
	sub.w	d3,d1
	lsl.l	d1,d0			; Shift size
	lsr.l	d2,d0			; Shift offset

	tst.b	d4
	beq	.less_clear		; Check for clear

	or.l	d0,(a0)
	movem.l	(sp)+,a1/d1-d4
	rts

.less_clear
	eor.l	d0,(a0)
	movem.l	(sp)+,a1/d1-d4
	rts	

*
*	Local variables, used to lookup some bits
*

	SECTION __MERGED,DATA

Firstword
	dc.w	$ffff	; %1111111111111111
	dc.w	$7fff	; %0111111111111111
	dc.w	$3fff	; %0011111111111111
	dc.w	$1fff	; %0001111111111111
	dc.w	$0fff	; %0000111111111111
	dc.w	$07ff	; %0000011111111111
	dc.w	$03ff	; %0000001111111111
	dc.w	$01ff	; %0000000111111111
	dc.w	$00ff	; %0000000011111111
	dc.w	$007f	; %0000000001111111
	dc.w	$003f	; %0000000000111111
	dc.w	$001f	; %0000000000011111
	dc.w	$000f	; %0000000000001111
	dc.w	$0007	; %0000000000000111
	dc.w	$0003	; %0000000000000011
	dc.w	$0001	; %0000000000000001

Lastword
	dc.w	$0000	; %0000000000000000
	dc.w	$8000	; %1000000000000000
	dc.w	$c000	; %1100000000000000
	dc.w	$e000	; %1110000000000000
	dc.w	$f000	; %1111000000000000
	dc.w	$f800	; %1111100000000000
	dc.w	$fc00	; %1111110000000000
	dc.w	$fe00	; %1111111000000000
	dc.w	$ff00	; %1111111100000000
	dc.w	$ff80	; %1111111110000000
	dc.w	$ffc0	; %1111111111000000
	dc.w	$ffe0	; %1111111111100000
	dc.w	$fff0	; %1111111111110000
	dc.w	$fff8	; %1111111111111000
	dc.w	$fffc	; %1111111111111100
	dc.w	$fffe	; %1111111111111110

	END

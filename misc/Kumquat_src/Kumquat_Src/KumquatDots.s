; Zolyx dot drawing

; Bank format:
; 	Number.w
;	x1.w	  y1.w
;	x2.w      y2.w ....
; (Number is the number of dots to be updated)

; Parameters: a0: Start of bank
;             a1: Start of screen plane address

	move.l	a1,a2

	move.w	(a0)+,d0	;d0 = Number of dots

Start	sub.l	d1,d1		;Clean out d1 & d2
	sub.l	d2,d2
	sub.b	d3,d3
	move.l	a2,a1

	move.w	(a0)+,d1	;d1 = X-Coord
	move.w	(a0)+,d2	;d2 = Y-Coord

	mulu.w	#40,d2
	divu.w	#8,d1
	add.w	d1,d2
	adda.l	d2,a1

	swap	d1

	cmp.w	#0,d1
	beq	rm0
	cmp.w	#2,d1
	beq	rm2
	cmp.w	#4,d1
	beq	rm4

	move.b	#3,d3
	bra	bypass

rm0	move.b	#192,d3
	bra	bypass

rm2	move.b	#48,d3
	bra	bypass	

rm4	move.b	#12,d3

bypass	move.b	(a1),d4
	or.b	d3,d4
	move.b	d4,(a1)
	adda.l	#40,a1
	move.b	d4,(a1)

	subq.w	#1,d0
	bne	Start
	rts


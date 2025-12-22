	CSECT   text
;        XDEF	@MoveMem
        XDEF	@MoveMem128
        XDEF	@ClearMem
; D0 has # bytes to move
; A0 has source addre
; a1 has dest addr

@MoveMem128 equ	*
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	rts
	IFD	REGMOVE
@MoveMem equ	*
	move.l	D0,D1
	andi.l	#$1,D1
	beq.s	OKTOGO
	move.b	(a0)+,(a1)+
OKTOGO: move.l	d0,d1
	andi.l	#2,d1
	beq.s	OKTOG2
	move.w	(a0)+,(a1)+
OKTOG2: lsr.l	#2,D0 ; now d0 has # of longwords to move
	move.l	d0,d1
	beq.s	retn2
	and	#1,d1
	beq.s	nor6
	move.l	(a0)+,(a1)+
nor6:
	move.l	D0,d1
	and	#2,d1
	beq.s	nor7
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
nor7:
	lsr.l	#2,d0
	beq.s	retn2
	subq.l	#1,d0
m69:
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	dbra	d0,m69
retn2:	rts
	ENDC

@ClearMem equ * ; a0 has address start d0 has the len in bytes
	tst.l	a0
	beq.s	rete
	tst.l	d0
	bne.s	proceed33
rete:	rts
proceed33:
	move.l	d2,-(sp)
	move.l	d0,d2
	andi.l	#3,d2 ; d2 has remainder of 4 byte moves in it
	lsr.l	#2,D0 ; now d0 has # of longwords to move
	beq.s	xty
	move.l	a0,d1
	andi.l	#$1,d1
	beq.s	fineaddr1
	clr.b	(a0)+
	addq.l	#3,d2 ; 3 more bytes to clean up
	subq.l	#1,d0 ; 1 less longword to move
	beq.s	xtz
fineaddr1:
	move.l	a0,d1
	andi.l	#2,d1
	beq.s	fineaddr2
	clr.w	(a0)+
	addq.l	#2,d2
	subq.l	#1,d0
	beq.s	xtz
fineaddr2:
	btst	#0,d0
	beq.s	nor63
	clr.l	(a0)+
nor63:
	btst	#1,d0
	beq.s	nor73
	clr.l	(a0)+
	clr.l	(a0)+
nor73:
	lsr.l	#2,d0
	beq.s	xty
m693:
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	subq.l	#1,d0
	bne.s	m693
xty:	tst.l	d2
	beq.s	retokj
xtz:	subq.l	#1,d2
xtx:
	clr.b	(a0)+
	dbra	d2,xtx
retokj:
	move.l	(sp)+,d2
	rts
	end

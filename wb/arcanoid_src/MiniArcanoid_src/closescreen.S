closescreen:
	movem.l	d0-d7/a0-a6,-(sp)
;	move.b	#1,workb
	move.l	actscreen,a0
	cmp.l	#0,a0
	beq.s	noclosescreen
	tst.l	4(a0)
	bne.s	noclosescreen
	clr.l	actscreen
	move.l	intbase,a6
	jsr	-66(a6)
noclosescreen:
	movem.l	(sp)+,d0-d7/a0-a6
	rts

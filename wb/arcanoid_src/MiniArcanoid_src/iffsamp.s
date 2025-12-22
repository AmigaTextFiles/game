; a0 - iff data

; a0 - body
; d0 - rate
; d1 - len

analyseiff:
	cmp.l	#'FORM',(a0)+
	bne.s	anerror
	move.l	(a0)+,d0
	cmp.l	#'8SVX',(a0)+
	bne.s	anerror
	cmp.l	#'VHDR',(a0)+
	bne.s	anerror
	move.b	19(a0),d0
	cmp.b	#0,d0		
	bne.s	anerror
	move.w	16(a0),d0
loop:
	move.l	(a0)+,d1
	add.l	d1,a0
	cmp.l	#'BODY',(a0)+
	bne.s	loop
	move.l	(a0)+,d1
	rts

; a0 - adr
; d0 - data

search:
	cmp.l	(a0)+,d0
	bne.s	search
	rts

anerror:
	moveq	#0,d0
	move.l	#0,a0
	rts

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

anerror:
	moveq	#0,d0
	move.l	#0,a0
	rts

; d0 - # sample

playsample:
	movem.l	d0-d7/a0-a6,-(sp)
	lea	samtable,a0
	move.l	channeltableadr,a1
	move.w	(a1)+,d1
	tst.w	d1
	bne.s	playnext
	move.l	#channeltable,channeltableadr
	move.l	channeltableadr,a1
	move.w	(A1)+,d1
playnext:
	lea	$dff000,a2
	move.w	#%0000000000001111,$96(a2)
	asl.w	#3,d0
	move.l	0(a0,d0.w),0(a2,d1.w)
	move.w	4(a0,d0.w),6(a2,d1.w)
	move.w	6(a0,d0.w),4(a2,d1.w)
	move.w	#63,8(a2,d1.w)
	move.w	#%1000000000001111,$96(a2)
	move.l	a1,channeltableadr
	movem.l	(sp)+,d0-d7/a0-a6
	rts

dmaoff:
	move.w	#%0000000000001111,$dff096
	rts

normsample:
	movem.l	a2/d1,-(sp)
	move.l	channeltableadr,a2
	move.w	-(A2),d1
	lea	$dff000,a2
	move.l	#s_clear,0(a2,d1.w)
	move.w	#1,4(a2,d1.w)
	movem.l	(sp)+,a2/d1
	rts

samend:
	movem.l	a0/d0/a2,-(sp)
	lea	channeltable,a0
samendlop:
	move.w	(a0)+,d0
	tst.w	d0
	beq.s	sam_endo
	lea	$dff000,a2
	move.l	#s_clear,0(a2,d0.w)
	move.w	#1,4(a2,d0.w)
	bra.s	samendlop	
sam_endo:
	movem.l	(sp)+,a0/d0/a2
	rts

s_clear:
	dc.l	0

channeltableadr:
	dc.l	channeltable
channeltable:
	dc.w	$a0,$b0,$c0,$d0,0

initsamples:
	movem.l	d0-d7/a0-a6,-(sp)
	lea	samples,a2
	lea	samtable,a3
isamloop:
	move.l	(a2)+,a0
	cmp.l	#0,a0
	beq.s	isamend
	bsr.w	analyseiff
	move.l	a0,(a3)+
	movem.l	d2-d3,-(sp)
	clr.l	d2
	clr.l	d3
	move.w	d0,d2
	move.l	#357,d3
	divu	d2,d3
	swap	d3
	move.l	d3,cosiczek
	move.l	d3,d0
	movem.l	(sp)+,d2-d3
	move.w	d0,(A3)+	
	asr.w	#1,d1
	move.w	d1,(a3)+
	bra.s	isamloop
isamend:
	movem.l	(sp)+,d0-d7/a0-a6
	rts

cosiczek:	dc.l	0

sample1:
	incbin	"gluchepac.snd" ; paletka
sample2:
	incbin	"brum.snd" ; twarde
sample3:
	incbin	"bziut.snd" ; uciekîo
sample4:
	incbin	"brrr.snd" ; literka
sample5:
	incbin	"klik.snd" ; ôcianka

samples:
	dc.l	sample1
	dc.l	sample2
	dc.l	sample3
	dc.l	sample4
	dc.l	sample5
	dc.l	0

samtable:

; adress.l rate.w len.w

sam1:	blk.w	4
sam2:	blk.w	4
sam3:	blk.w	4
sam4:	blk.w	4
sam5:	blk.w	4

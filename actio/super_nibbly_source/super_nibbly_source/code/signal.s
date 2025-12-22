	move.l	#name,a1
	move.l	4.w,a6
	jsr	-294(a6)
	tst.l	d0
	beq	noshare
	move.l	d0,a0

	lea	$3a(a0),a0
	move.l	(a0),a0
	move.l	12(a0),a1
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-324(a6)	;signal
	

noshare:
	move.l	#0,d0	
	rts


name:	dc.b	"Chrisis_task",0
	even

LEVEL = 0

	move.l	4.w,a6
	lea	name,a1
	jsr	-294(a6)
	tst.l	d0
	beq	noshare
	move.l	d0,a0
	lea	$3a(a0),a0
	move.l	(a0),a0

	move.w	#$0f0,$dff180
	move.w	#2,4(a0)
	move.w	#LEVEL,6(a0)
	move.w	#1,2(a0)
	move.l	#0,d0
	rts

noshare:
	move.w	#$f00,$dff180
	move.l	#0,d0
	rts

name:	dc.b	"Chrisis_task",0


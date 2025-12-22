openlib		= -552
closelib	= -414
findtask	= -294
delay		= -198

        move.l  4,a6
        lea     dosname(pc),a1
        jsr     openlib(a6)
        tst.l   d0
        beq     nodos
        move.l  d0,dosbase
	
	move.l	#0,a1
	move.l	4.w,a6
	jsr	findtask(a6)	
	move.l	d0,mytask	

	;move.l	d0,a0	
	;move.l	$58(a0),savedata

waitmouse:
	move.l	#20,d1
	move.l	dosbase,a6
	jsr	delay(a6)
	btst	#6,$bfe001
	bne	waitmouse

	;move.l	mytask,a0
	;move.l	savedata,$58(a0)

	move.l  dosbase,a1
        move.l  4,a6
	jsr	closelib(a6)
nodos:
	move.l	#0,d0
	rts

dosname:	dc.b    "dos.library",0
        	even
mytask:		dc.l	0
dosbase: 	dc.l    0
savedata:	dc.l	0
dataspace:	dcb.l	20,0

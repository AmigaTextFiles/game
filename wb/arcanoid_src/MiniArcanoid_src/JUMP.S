m_JUMP:
	move.l	intbase,a0
	move.l	$3c(a0),a0
	cmp.l	#0,(a0)
	beq.W	m_jumend
	lea	jumpgads,a1
	lea	screennames,a2
	lea	screenadr,a3
	move.l	#2,d0
m_jumloop:
	cmp.l	actscreen,a0
	beq.s	m_jumnext
	move.l	a0,(a3)+
	move.l	#1,(a1)+
	move.l	#4,(a1)+
	move.l	d0,(a1)+
	move.l	#40*8+4,(a1)+
	move.l	#14,(a1)+
	move.l	a2,(a1)+
	move.l	#0,(a1)+
	move.l	#0,(a1)+
	move.l	#$80000000,(a1)+
	move.b	#1,(a2)+
	move.b	#6,(a2)+
	move.b	#10,(a2)+
	movem.l	a0/a1/d0,-(sp)
	move.l	$16(a0),a0
	move.l	a2,a1
	moveq	#40,d0
	bsr.w	movenulltext
	movem.l	(sp)+,a0/a1/d0
	adda.l	#44,a2
	add.w	#16,d0
m_jumnext:
	move.l	(a0),a0
	cmp.l	#0,a0
	bne.s	m_jumloop
	add.l	#8,d0
	move.l	#1,(a1)+
	move.l	#4+132,(a1)+
	move.l	d0,(a1)+
	move.l	#7*8+4,(a1)+
	move.l	#14,(a1)+
	move.l	#g_goback,(a1)+
	move.l	#0,(a1)+
	move.l	#0,(a1)+
	move.l	#$80000000,(a1)+
	move.l	#0,(a1)+
	add.l	#16,d0

	lea	defwindow,a0
	bsr.w	storewindow

	move.w	#-1,win_x
	move.w	#-1,win_y
	add.w	#4,d0
	move.w	d0,win_sizey
	move.w	#42*8+4,win_sizex
	move.l	#selscr,win_title
	move.l	#$20000+$2+$4+$2000,win_flags
	move.l	#$8,win_idcmpflags
	bsr.w	openwindow
	lea	jumpgads,a0
	bsr.w	drawgadgets
m_jumsel:
	bsr.w	wfnp
	bsr.w	message
	lea	jumpgads,a0
	bsr.w	dogadget
	cmp.l	#0,a0
	beq.s	m_jumsel
	cmp.l	#g_goback,20(a0)
	beq.b	m_jumbo
	move.l	a0,d0
	sub.l	#jumpgads,d0
	divu	#9*4,d0
	asl.l	#2,d0
	bsr.w	closewindow
	lea	defwindow,a0
	bsr.w	restorewindow
	bsr.w	closewindow
	bsr.w	closescreen
	lea	screenadr,a0
	move.l	(a0,d0.w),win_screen
	move.w	#$f,win_type
	move.w	win_sizey,d0
	sub.w	addy,d0
	move.w	d0,win_sizey
	bsr.w	openwindow
	rts
m_jumbo:
	move.b	#1,optflag
	bsr.w	dogadget
	bsr.b	waitblit
	bsr.w	closewindow
	lea	defwindow,a0
	bsr.w	restorewindow
	rts
m_jumend:
	move.b	#1,optflag
	bsr.w	flash
	rts

waitblit:
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	gfxbase,a6
	jsr	-228(a6)
	movem.l	(sp)+,d0-d7/a0-a6
	rts

; a0 - src
; a1 - dest
; d0 - count

movenulltext:
	movem.l	a0/a1/d0,-(sp)
	subq	#1,d0
movetloop:
	move.b	(a0)+,(a1)
	tst.b	(a1)
	beq.s	movetdone
	cmp.b	#10,(a1)+
	beq.s	movetdone
	dbf	d0,movetloop
	move.b	#0,(a1)+
movetdone:
	movem.l	(sp)+,a0/a1/d0
	rts

g_goback:
	dc.b	1,6,10,'GO BACK',0

	even

selscr:
	dc.b	'Select screen...',0

	even

	section	free,bss_c

jumpgads:
	ds.l	9*40
screennames:
	ds.b	44*40
screenadr:
	ds.l	40

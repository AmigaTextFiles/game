;
;	my first fucking blitter code
;
;
;
;

	include 'include:exec/types.i'
	include 'include:hardware/custom.i'
	include 'include:hardware/blit.i'
	include 'include:hardware/dmabits.i'

	xref _custom
	xdef _Line

	
	section code

_Line:
	lea		$dff000,a1
	sub.w	d0,d2
	bmi		xneg
	sub.w	d1,d3
	bmi		yneg
	cmp.w	d3,d2
	bmi		ygtx
	moveq.l	#OCTANT1+LINEMODE,d5
	bra		lineagain
ygtx:
	exg		d2,d3
	moveq.l	#OCTANT2+LINEMODE,d5
	bra		lineagain
yneg:
	neg.w	d3
	cmp.w	d3,d2
	bmi		ynygtx
	moveq.l	#OCTANT8+LINEMODE,d5
	bra		lineagain
ynygtx:
	exg		d2,d3
	moveq.l	#OCTANT7+LINEMODE,d5
	bra		lineagain
xneg:
	neg.w	d2
	sub.w	d1,d3
	bmi		xyneg
	cmp.w	d3,d2
	bmi		xnygtx
	moveq.l	#OCTANT4+LINEMODE,d5
	bra		lineagain
xnygtx:
	exg		d2,d3
	moveq.l	#OCTANT3+LINEMODE,d5
	bra		lineagain
xyneg:
	neg.w	d3
	cmp.w	d3,d2
	bmi		xynygtx
	moveq.l	#OCTANT5+LINEMODE,d5
	bra		lineagain
xynygtx:
	exg		d2,d3
	moveq.l	#OCTANT6+LINEMODE,d5
lineagain:
	mulu.w	#80,d1		; bitplane width in bytes
	ror.l	#4,d0
	add.w	d0,d0
	add.l	d1,a0
	add.w	d0,a0
	swap		d0
	or.w		#$BFA,d0
	lsl.w	#2,d3
	add.w	d2,d2
	move.w	d2,d1
	lsl.w	#5,d1
	add.w	#$42,d1
	btst		#DMAB_BLTDONE-8,dmaconr(a1)
waitblit:
	btst		#DMAB_BLTDONE-8,dmaconr(a1)
	bne		waitblit
	move.w	d3,bltbmod(a1)
	sub.w	d2,d3
	ext.l	d3
	move.l	d3,bltapt(a1)
	bpl		lineover
	or.w		#SIGNFLAG,d5
lineover:
	move.w	d0,bltcon0(a1)
	move.w	d5,bltcon1(a1)
	move.w	#80,bltcmod(a1)	; bitplane width in bytes
	move.w	#80,bltdmod(a1)	; bitplane width in bytes
	sub.w	d2,d3
	move.w	d3,bltamod(a1)
	move.w	d4,bltadat(a1)
	move.l	#-1,bltafwm(a1)
	move.l	a0,bltcpt(a1)
	move.l	a0,bltdpt(a1)
	move.w	d1,bltsize(a1)
	rts
	end

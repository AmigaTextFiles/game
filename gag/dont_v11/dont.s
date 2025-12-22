	incdir INCLUDE:
	include "LVO3.0/exec_lib.i"
	include "LVO3.0/dos_lib.i"

;	Don't
;
;	Ask your amiga to do nothing and it will really do nothing!!!
;
;	Please note that this piece of code is SEXware®; that means:
;	if you use this pile of c..p, please e-mail your nicest sister
;	at rekststef@unisi.it
;	Bug reports and donations welcome.      ;-)
;
;	History:	Mar 22, 1992: This was written in C !!!
;
;			Dec 10, 1994: After a complete debugging, this
;			program is now rewritten in Assembly to gain speed.
;			So it can do nothing even faster!!!
;
;   Credits: this was inspired by another program called Don't, of which
;   unfortunately I can't remember the author... :-(

	movem.l	a0/d0,-(sp)
	move.l	$4,a6
	lea	dosname,a1
	move.l	#0,d0
	jsr	_LVOOpenLibrary(a6)
	tst	d0
	beq.b	.panic
	move.l	d0,a2

	move.l	d0,a6
	jsr	_LVOOutput(a6)
	tst	d0
	beq.b	.error
	move.l	d0,d4

	move.l	d4,d1
	move.l	#okiwont,d2
	move.l	#12,d3
	jsr	_LVOWrite(a6)

	move.l	d4,d1
	move.l	(sp)+,d3
	move.l	(sp)+,d2
	jsr	_LVOWrite(a6)

	move.l	a2,a1
	move.l	$4,a6
	jsr	_LVOCloseLibrary(a6)
	moveq	#0,d0
	rts

.error
	addq	#8,sp
	moveq	#5,d0
	rts
.panic
	addq	#8,sp
	moveq	#20,d0
	rts

dosname:
	dc.b	"dos.library",0
okiwont
	dc.b	"OK, I won't "

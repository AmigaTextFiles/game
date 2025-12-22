*
* BOB system
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* initBOBs(a5=View)
* d0=err = newBOB(a0=MOB)
* unlinkBOB(a0=MOB)
* $updateBOBs(a5=View)
* $drawBOBs(a5=View)
* $undrawBOBs(a5=View)
*

	include	"custom.i"
	include	"display.i"
	include	"view.i"
	include "mob.i"
	include	"macros.i"


; from memory.asm
	xref	alloc_chipmem

; from main.asm
	xref	newlist
	xref	panic

; from display.asm
	xref	View

; from blit.asm
	xref	YOffTab



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	initBOBs
initBOBs:
; Initialize a View's BOB-lists.
; Allocate Chip RAM for BOB backup buffers and initialize buffer queue.
; a5 = View

	movem.l	d2/a2,-(sp)

	; allocate backup buffers
	move.l	#(4+MAXBOBSIZE)*(MAX_VIS_BOBS+1),d0
	bsr	alloc_chipmem

	; set up the buffer queue
	move.l	d0,Vbackgdhead(a5)
	move.l	d0,a0
	moveq	#MAX_VIS_BOBS,d0
	bra	.2

.1:	move.l	a1,(a0)			; link to next backup buffer
	move.l	a1,a0
.2:	lea	4+MAXBOBSIZE(a0),a1
	dbf	d0,.1

	clr.l	(a0)			; last buffer has no link
	move.l	a0,Vbackgdtail(a5)

	; initialize all BOBs and put them into the Vuboblist (unused)
	lea	Vuboblist(a5),a1
	lea	Vbobs(a5),a2
	move.l	a1,d0
	move.l	a2,(a1)+		; list head
	clr.l	(a1)			; list tail
	move.w	#NUM_BOBS-1,d1

.3:	lea	sizeof_BOB(a2),a1
	move.l	a1,BOnext(a2)
	move.l	d0,BOprev(a2)
	clr.w	BOsize1(a2)		; clear bltsizes
	clr.w	BOsize2(a2)
	move.l	a2,d0
	move.l	a1,a2
	dbf	d1,.3

	move.l	d0,a2			; last node
	lea	Vuboblist+4(a5),a1
	move.l	a1,BOnext(a2)
	move.l	a2,Vuboblist+8(a5)

	; empty Vvboblist and Viboblist
	lea	Vvboblist(a5),a0
	bsr	newlist
	lea	Viboblist(a5),a0
	bsr	newlist

	movem.l	(sp)+,d2/a2
	rts


;---------------------------------------------------------------------------
	xdef	newBOB
newBOB:
; Allocate new BOBs and assign them to the given MOB. Inizialize the BOBs
; and move them into the invisible BOB list of both Views.
; a0 = MOB
; -> d0/Z = out of BOBs

	movem.l	a2-a3/a5,-(sp)
	move.l	a0,a3
	clr.b	MOvisible(a3)

	; first View
	move.l	View(a4),a5
	lea	Vuboblist(a5),a0
	REMHEAD	a0,a1,d0,.1
	lea	Viboblist(a5),a0
	move.l	d0,a2
	move.l	a3,BOmob(a2)
	move.l	a2,MObobv1(a3)
	ADDHEAD	a0,a2,d0

	; second View
	move.l	View+4(a4),a5
	lea	Vuboblist(a5),a0
	REMHEAD	a0,a1,d0,.2
	lea	Viboblist(a5),a0
	move.l	d0,a2
	move.l	a3,BOmob(a2)
	move.l	a2,MObobv2(a3)
	ADDHEAD	a0,a2,d0

	moveq	#1,d0			; ok
.1:	movem.l	(sp)+,a2-a3/a5
	rts

	; no more BOBs in second View, so put BOB back from first view
.2:	move.l	a2,a1
	REMOVE	a1,a0
	move.l	View(a4),a5
	lea	Vuboblist(a5),a0
	ADDHEAD	a0,a2,d0
	clr.l	MObobv1(a3)
	moveq	#0,d0			; error
	movem.l	(sp)+,a2-a3/a5
	rts


;---------------------------------------------------------------------------
	xdef	unlinkBOB
unlinkBOB:
; Declare a MOB's linked BOBs as to be deleted. They will no longer be
; drawn and automatically be moved into the list of unused BOBs.
; a0 = MOB

	moveq	#0,d0
	lea	MObobv1(a0),a0

	move.l	(a0),a1			; BOB from first View
	move.l	d0,(a0)+
	move.l	d0,BOmob(a1)

	move.l	(a0),a1			; BOB from second View
	move.l	d0,(a0)
	move.l	d0,BOmob(a1)

	rts


;---------------------------------------------------------------------------
	xdef	updateBOBs
updateBOBs:
; Move invisible BOBs from vboblist to iboblist (x/y from linked MOB).
; Move visible BOBs from iboblist to vboblist (x/y from linked MOB).
; Calculate size and pos for BOBs from vboblist (x/y/size from MOB).
; a5 = View
; Registers, except a4 - a6, are not preserved!

	move.l	a6,-(sp)

	; Calculate x/y-start and x/y-end of display area while taking
	; the maximum BOB dimensions into account.
	movem.w	Vxpos(a5),d6-d7
	moveq	#-MAXOBJWIDTH,d4
	moveq	#-MAXOBJHEIGHT,d5
	add.w	d6,d4
	add.w	d7,d5
	add.w	#DISPW,d6
	add.w	#DISPH,d7

	;-----------------------------------------------
	; check for BOBs from iboblist becoming visible
	;-----------------------------------------------
	clr.l	-(sp)
	lea	Viboblist(a5),a6
	move.l	(a6),a0
	bra	.3

.delibob:
	; unlink invisible BOB and move it back into the list of unused BOBs
	move.l	a0,a2
	REMOVE	a0,a1
	lea	Vuboblist(a5),a0
	ADDHEAD	a0,a2,d1
	bra	.2

.1:	move.l	BOmob(a0),d1
	move.l	d1,a1
	beq	.delibob		; BOB is no longer linked to a MOB

	; check whether MOB position is getting into visible rectangle
	movem.w	(a1),d2-d3		; MOxpos/MOypos
	cmp.w	d4,d2
	blt	.2
	cmp.w	d5,d3
	blt	.2
	cmp.w	d6,d2
	bge	.2
	cmp.w	d7,d3
	bge	.2

	; remove this BOB and put it onto the stack
	st	MOvisible(a1)
	move.l	a0,-(sp)
	REMOVE	a0,a1

.2:	move.l	d0,a0
.3:	move.l	BOnext(a0),d0
	bne	.1

	;-------------------------------------------------
	; check for BOBs from vboblist becoming invisible
	;-------------------------------------------------
	lea	Vvboblist(a5),a3
	move.l	(a3),d0

.4:	move.l	d0,a0
	move.l	BOnext(a0),d0
	beq	.7
	move.l	BOmob(a0),d1
	move.l	d1,a1
	beq	.delvbob		; BOB is no longer linked to a MOB

	; check whether MOB position is still in visible rectangle
	movem.w	(a1),d2-d3		; MOxpos/MOypos
	cmp.w	d4,d2
	blt	.5
	cmp.w	d5,d3
	blt	.5
	cmp.w	d6,d2
	bge	.5
	cmp.w	d7,d3
	blt	.4

	; move BOB to the list of invisible objects
.5:	clr.b	MOvisible(a1)
	move.l	a0,a2
	REMOVE	a0,a1
	move.l	a6,a0
	ADDHEAD	a0,a2,d1

.freebuf:
	; put background buffer back into the queue
	move.l	Vbackgdtail(a5),a1
	move.l	BObuf(a2),a0
	clr.l	-(a0)
	move.l	a0,(a1)
	move.l	a0,Vbackgdtail(a5)
	bra	.4

.delvbob:
	; unlink visible BOB and move it back into the list of unused BOBs
	move.l	a0,a2
	REMOVE	a0,a1
	lea	Vuboblist(a5),a0
	ADDHEAD	a0,a2,d1
	bra	.freebuf

.panic:
	move.w	#$0ff,d0		; out of backup buffers
	bra	panic

	;--------------------------------------
	; now add new visible BOBs to vboblist
	;--------------------------------------
.6:	move.l	d0,a1
	move.l	Vbackgdhead(a5),a0	; get new background buffer from queue
	move.l	(a0)+,d0
	beq	.panic
	move.l	a0,BObuf(a1)		; set backgd buffer for visible BOB
	move.l	d0,Vbackgdhead(a5)

	move.l	a3,a0
	ADDHEAD	a0,a1,d1
.7:	move.l	(sp)+,d0
	bne	.6

	;-------------------------------------------------
	; calculate position, size and shift for vboblist
	;-------------------------------------------------
	lea	YOffTab(a4),a6
	lea	Vtop(a5),a0
	movem.l	(a0)+,d6-d7		; d6=Vtop, d7=Vsplit
	moveq	#-$10,d4
	swap	d4
	and.l	(a0)+,d4		; d4 Vxpos&$fff0 | Vypos
	move.w	(a0),d5			; d5 Vsplyoff
	move.l	(a3),a0			; Vvboblist.head
	bra	.20

.8:	addq.l	#BOmob,a0
	move.l	(a0)+,a1		; BOmob
	movem.w	(a1)+,d2-d3		; MOxpos/MOypos

	; remember shift value (MOxpos & 15) in BOB
	moveq	#15,d1
	and.w	d2,d1
	ror.w	#4,d1
	move.w	d1,(a0)+		; BOshift for BLTCONx

	; calculate bitmap x-offset in bytes
	move.l	d6,a2			; load Vtop and Vsplit
	move.l	d7,a3
	swap	d4
	moveq	#-$10,d1
	and.w	d2,d1
	sub.w	d4,d1
	asr.w	#3,d1
	add.w	d1,a2			; add x-offset to both pointers
	add.w	d1,a3

	; check whether BOB starts before or after the split
	swap	d4
	sub.w	d4,d3			; y-offset to display top
	cmp.w	d5,d3
	blt	.9
	move.l	a3,a2			; BOB starts below the split
	sub.w	d5,d3
	add.w	d3,d3
	add.w	d3,d3
	add.l	(a6,d3.w),a2
	move.w	(a1)+,d2		; MOheight
	bra	.10			; no more checks for crossing the split

	; add y-offset to bitmap pointer
.9:	move.w	d3,d1
	add.w	d1,d1
	add.w	d1,d1
	add.l	(a6,d1.w),a2

	; check whether BOB crosses the split
	move.w	(a1)+,d2		; MOheight
	add.w	d2,d3			; yoffset + MOheight
	cmp.w	d5,d3
	bgt	.11

	; split is not crossed
.10:	lsl.w	#6,d2			; bltsize height (mult. with 64*PLANES)
	move.w	d2,d1
	add.w	d2,d2
	add.w	d2,d2
	add.w	d1,d2

	move.w	(a1)+,d1		; MOwidth
	addq.w	#1,d1			; we need one extra word for shifting
	or.w	d1,d2
	add.w	d1,d1
	move.w	d1,(a0)+		; BObpr
	move.w	d2,(a0)+		; BOsize1
	move.l	a2,(a0)+		; BOpos1
	clr.w	(a0)+			; no BOsize2, split is not crossed
	addq.l	#4,a0			; no BOpos2
	bra	.12

	; crossing the split - two separate blits are needed
.11:	sub.w	d5,d3			; lines after the split
	sub.w	d3,d2			; lines before the split

	lsl.w	#6,d2			; bltsize height (mult. with 64*PLANES)
	move.w	d2,d1
	add.w	d2,d2
	add.w	d2,d2
	add.w	d1,d2

	lsl.w	#6,d3			; bltsize height (mult. with 64*PLANES)
	move.w	d3,d1
	add.w	d3,d3
	add.w	d3,d3
	add.w	d1,d3

	move.w	(a1)+,d1		; MOwidth
	addq.w	#1,d1			; we need one extra word for shifting
	or.w	d1,d2
	or.w	d1,d3
	add.w	d1,d1
	move.w	d1,(a0)+		; BObpr
	move.w	d2,(a0)+		; BOsize1
	move.l	a2,(a0)+		; BOpos1
	move.w	d3,(a0)+		; BOsize2
	move.l	a3,(a0)+		; BOpos2

.12:	move.l	(a1)+,(a0)+		; copy MOimage to BOimg
	move.l	(a1),(a0)		; copy MOmask to BOmsk

	move.l	d0,a0
.20:	move.l	BOnext(a0),d0
	bne	.8

	move.l	(sp)+,a6
	rts


;---------------------------------------------------------------------------
	xdef	drawBOBs
drawBOBs:
; Save the background to the buffer and draw all BOBs from the vboblist.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	lea	Vvboblist(a5),a3

	;-----------------------------------------------
	; Save the background of all BOBs to the buffer.
	;-----------------------------------------------
	moveq	#-1,d0
	moveq	#0,d1
	WAITBLIT
	move.l	d0,BLTAFWM(a6)
	move.w	d1,BLTDMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)

	; blitter preconfigured to:
	; AFWM/ALWM=$fff, DMOD=0, Use AD, D=A

	move.l	(a3),a0
	bra	.3

.1:	move.l	BObuf(a0),a2
	moveq	#BPR,d1
	lea	BObpr(a0),a0
	sub.w	(a0)+,d1		; AMOD = BPR-BObpr
	move.w	(a0)+,d2		; BOsize1
	move.l	(a0)+,a1		; BOpos1

	WAITBLIT
	move.w	d1,BLTAMOD(a6)
	movem.l	a1-a2,BLTAPT(a6)
	move.w	d2,BLTSIZE(a6)

	move.w	(a0)+,d2		; BOsize2
	beq	.2			; no 2nd half to draw after the split
	move.l	(a0),a1			; BOpos2

	WAITBLIT
	move.l	a1,BLTAPT(a6)
	move.w	d2,BLTSIZE(a6)

.2:	move.l	d0,a0
.3:	move.l	BOnext(a0),d0
	bne	.1

	;--------------------------------
	; Draw masked images of all BOBs.
	;--------------------------------
	move.l	a5,d5
	move.w	#$0fca,d1		; Use ABCD, D=AB+/AC
	moveq	#-1,d2
	clr.w	d2			; $ffff0000
	move.l	#$fffefffe,d3
	WAITBLIT
	move.l	d2,BLTAFWM(a6)
	move.l	d3,BLTBMOD(a6)

	; Blitter preconfiguration:
	; AMOD and BMOD = -2 for the src image/mask, because we have to
	; read an additional word to allow shifting.
	; The FWM is $ffff, but the LWM $0000 to ignore this extra word.

	move.l	(a3),a0
	bra	.6

.4:	movem.l	BOimg(a0),a2-a3		; a2=image, a3=mask
	lea	BOshift(a0),a0
	move.w	(a0)+,d3		; BOshift
	move.w	d3,d2
	or.w	d1,d2
	swap	d2
	move.w	d3,d2			; d2 = BLTCON0 | BLTCON1
	moveq	#BPR,d3
	sub.w	(a0)+,d3		; d3 = BPR-BObpr for CMOD and DMOD
	move.w	(a0)+,d4		; BOsize1
	move.l	(a0)+,a1		; BOpos1
	move.l	a1,a5

	WAITBLIT
	move.l	d2,BLTCON0(a6)
	move.w	d3,BLTCMOD(a6)
	move.w	d3,BLTDMOD(a6)
	movem.l	a1-a3/a5,BLTCPT(a6)
	move.w	d4,BLTSIZE(a6)

	move.w	(a0)+,d4		; BOsize2
	beq	.5			; no 2nd half to draw after the split
	move.l	(a0),a1			; BOpos2

	WAITBLIT
	move.l	a1,BLTCPT(a6)
	move.l	a1,BLTDPT(a6)
	move.w	d4,BLTSIZE(a6)

.5:	move.l	d0,a0
.6:	move.l	BOnext(a0),d0
	bne	.4

	move.l	d5,a5
	rts


;---------------------------------------------------------------------------
	xdef	undrawBOBs
undrawBOBs:
; Restore the saved background behind all BOBs from vboblist.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	move.l	Vvboblist(a5),a0

	moveq	#-1,d0
	moveq	#0,d1
	WAITBLIT
	move.l	d0,BLTAFWM(a6)
	move.w	d1,BLTAMOD(a6)
	move.l	#$09f00000,BLTCON0(a6)

	; blitter preconfigured to:
	; AFWM/ALWM=$fff, AMOD=0, Use AD, D=A

	bra	.3

.1:	move.l	BObuf(a0),a1
	moveq	#BPR,d1
	lea	BObpr(a0),a0
	sub.w	(a0)+,d1		; DMOD = BPR-BObpr
	move.w	(a0)+,d2		; BOsize1
	move.l	(a0)+,a2		; BOpos1

	WAITBLIT
	move.w	d1,BLTDMOD(a6)
	movem.l	a1-a2,BLTAPT(a6)
	move.w	d2,BLTSIZE(a6)

	move.w	(a0)+,d2		; BOsize2
	beq	.2			; no 2nd half to draw after the split
	move.l	(a0),a2			; BOpos2

	WAITBLIT
	move.l	a2,BLTDPT(a6)
	move.w	d2,BLTSIZE(a6)

.2:	move.l	d0,a0
.3:	move.l	BOnext(a0),d0
	bne	.1

	rts
